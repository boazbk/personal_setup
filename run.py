#!/usr/bin/env python3
import argparse
import functools
import subprocess
import textwrap
from pathlib import Path
import sys


def blue_print(arg):
    print("\033[1;34m{}\033[0m".format(arg))


def pretty_name(fn):
    return " ".join(fn.__name__.split("_")).title()


def run(cmd, verbose=True):
    if verbose:
        blue_print(cmd)
    proc = subprocess.Popen(
        ["/bin/bash", "-c", cmd], bufsize=1, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
        cwd=Path(__file__).parent, universal_newlines=True
    )
    while True:
        if verbose:
            out = proc.stdout.readline()
            print(textwrap.indent(out, "\t"), end="")
            if out:
                continue
        if proc.poll() is not None:
            break
    return proc.poll()


fns = []


def collect(fn):
    global fns
    fns.append(fn)
    return fn


def skip_if(cmd, should_fail=False, should_raise=False):
    def decorator(fn):
        @functools.wraps(fn)
        def inner(*args, **kwargs):
            returncode = run(cmd, verbose=False)
            command_failed = bool(returncode)
            if should_fail:
                command_failed = not command_failed
            if command_failed:
                fn(*args, **kwargs)
            elif should_raise:
                raise subprocess.CalledProcessError(returncode, cmd)
            else:
                blue_print("=" * 25)
                blue_print(f"Skipping installing {pretty_name(fn)}...")
                blue_print("=" * 25)
                print()
        return inner
    return decorator


skip_if_fail = functools.partial(skip_if, should_fail=True)
raise_if_fail = functools.partial(skip_if, should_fail=True, should_raise=True)


def sh(check=True):
    def decorator(fn):
        @functools.wraps(fn)
        def inner(*args, **kwargs):
            blue_print("=" * 25)
            blue_print(f"Installing {pretty_name(fn)}...")
            blue_print("=" * 25)
            print()
            if not ARGS.yes:
                print("Enter to continue (or type something to skip)... ", end="")
                if input():
                    print()
                    return
            lines = fn(*args, **kwargs).splitlines()
            for l in lines:
                cmd = l.strip()
                if not cmd:
                    continue
                returncode = run(cmd)
                if check and returncode:
                    print("\n")
                    raise subprocess.CalledProcessError(returncode, cmd)
            print()
        return inner
    return decorator


# ==========================
# The actual setup begins...
# ==========================


@collect
@sh()
def zsh():
    return """
    [[ ! -f ~/.zshrc ]] || diff zshrc ~/.zshrc
    cp zshrc ~/.zshrc
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    git clone https://github.com/zsh-users/zsh-autosuggestions git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    #if which zsh >/dev/null 2>&1; then chsh -s $(which zsh); elif [[ -x "/usr/bin/zsh" ]]; then chsh -s /usr/bin/zsh; else echo "Failed to change shell to Zsh"; fi
    """


# The day will come when I will learn vim, but today is not that day.
# @collect
# @sh()
# def vim():
#     return """
#     [[ ! -f ~/.vimrc ]] || diff vimrc ~/.vimrc
#     cp vimrc ~/.vimrc
#     curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#     rm -rf ~/.vim/.swp
#     mkdir ~/.vim/.swp
#     """


@collect
@skip_if_fail("lsb_release")
@sh()
def ubuntu_stuff():
    return """
    mkdir -p ${HOME}/.local/bin
    git clone --depth 1 https://github.com/junegunn/fzf.git /tmp/fzf
    /tmp/fzf/install --bin
    mv /tmp/fzf/bin/fzf ${HOME}/.local/bin

    python3 -m pip install pypyp virtualenv
    """


@collect
@skip_if("which brew")
@sh()
def brew():
    return '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"'


@collect
@skip_if_fail("which brew")
@sh()
def main_brew_stuff():
    return """
    brew reinstall python3
    brew reinstall node
    brew reinstall ripgrep  # code search
    brew reinstall fzf      # fuzzy finder
    brew reinstall pipx     # manage python apps in their own venvs
    brew reinstall pyenv    # manage python versions
    brew reinstall htop     # view processes
    brew reinstall tree     # show a directory tree
    """


@collect
@skip_if_fail("which brew")
@sh()
def provisional_brew_stuff():
    return """
    brew reinstall fd         # like find but sometimes more convenient
    brew reinstall bat        # like cat with syntax highlighting
    brew reinstall tokei      # count lines in code
    brew reinstall hyperfine  # benchmarking
    brew reinstall dust       # like du + tree
    brew reinstall gh         # github cli
    brew reinstall fastmod    # fast codemod (i hate sed)
    brew reinstall watch      # repeatedly run a command
    brew reinstall prettier   # code formatter
    brew reinstall jq         # parse json
    """


# Hammerspoon seems awesome, but not just yet for me
@collect
@skip_if_fail("which brew")
@sh()
def brew_casks():
    return """
    # brew install --cask hammerspoon  # automate your mac

    brew install --cask basictex

    brew install --cask firefox
    brew install --cask google-chrome

    brew install --cask spotify

    brew install --cask visual-studio-code

    # brew install --cask --no-quarantine qlmarkdown
    # brew install --cask --no-quarantine qlstephen
    # brew install --cask --no-quarantine syntax-highlight
    """


@collect
@skip_if_fail("which code")
@sh()
def vscode_extensions():
    return """
    code --install-extension akamud.vscode-theme-onedark
    code --install-extension akamud.vscode-theme-onelight
    code --install-extension bibhasdn.unique-lines
    code --install-extension eamodio.gitlens
    code --install-extension GitHub.copilot
    code --install-extension gurumukhi.selected-lines-count
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension rust-lang.rust-analyzer
    code --install-extension stkb.rewrap
    code --install-extension tomoki1207.pdf
    code --install-extension usernamehw.errorlens
    """

# @collect
# @skip_if_fail("brew list --cask | grep hammerspoon")
# @sh()
# def hammerspoon_config():
#     return """
#     [[ ! -f ~/.hammerspoon/init.lua ]] || diff hammerspoon.lua ~/.hammerspoon/init.lua
#     rm -rf ~/.hammerspoon
#     mkdir ~/.hammerspoon
#     cp hammerspoon.lua ~/.hammerspoon/init.lua
#     """


@collect
@raise_if_fail("which pipx")
@sh()
def python_tools():
    return """
    # use python on the command line easily
    pipx install pypyp

    # some extra git commands
    pipx install git-revise
    pipx install git-delete-merged-branches

    # python formatting
    pipx install black
    pipx install darker
    pipx install isort

    # python linting
    pipx install flake8
    pipx inject flake8 flake8-pyi flake8-bugbear
    pipx install pylint
    pipx install mypy

    # python packaging, testing, profiling
    pipx install poetry
    pipx install pyinstrument
    pipx install tox
    pipx install virtualenv
    """

# TODO:
# rust, `curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`
# code, `ln -sf '/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code' /usr/local/bin/code`
# install vscode settings.json
# pre-populate shell history
# preview.sh
# terminal font
# terminal touch id, "auth sufficient pam_tid.so" to first line of "/etc/pam.d/sudo"
# git config (per-folder)
# pyenv stuff
# wemo

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--yes", action="store_true", help="Don't ask, just do!")
    parser.add_argument("sections", nargs="*", help="Things to run")
    ARGS = parser.parse_args(sys.argv[1:])

    for fn in fns:
        if not ARGS.sections or any(x == fn.__name__.lower() for x in ARGS.sections):
            fn()
