set PATH /usr/local/bin /usr/local/opt/llvm/bin /usr/sbin /usr/local/texlive/2022/bin/universal-darwin $HOME/bin $HOME/.cargo/bin $PATH

alias cade "ssh -Y u1517830@lab1-33.eng.utah.edu"
alias hpc "ssh u1517830@lonepeak.chpc.utah.edu"
alias md "open -a "MacDown""
abbr -a d nvim /Users/lee/dev/

set -gx WASMTIME_HOME "$HOME/.wasmtime"

string match -r ".wasmtime" "$PATH" > /dev/null; or set -gx PATH "$WASMTIME_HOME/bin" $PATH
export PATH="/Users/lee/.deno/bin:$PATH"
export PATH="/Users/lee/Library/Python/3.11/bin/:$PATH"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
