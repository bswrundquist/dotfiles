{pkgs, config, ... }: {
  home.shellAliases = {
    cdw = "cd ~/workspace";
    cddl = "cd ~/Downloads";
    cddo = "cd ~/Documents";

    todos = 'rg "TODO|FIXME|HACK"';

    k = "kubectl";
    d = "docker";
    m = "make";
    v = "nvim";
    lg = "lazygit";

    g = "git";
    gs = "git status";
    ga = "git add";
    gc = "git commit";
    gp = "git push";
    gd = "git diff";
    gco = "git checkout";
    gcb = "git checkout -b";
    gpl = "git pull";

    h = "history";
    hg = "history | rg";

    l = "ls -l";
    ll = "ls -lha";

    day = "date +%A";
    dow = "date +%u";
    week = "date +%V";
    month = "date +%B";
    date = "date +'%Y-%m-%d %H:%M:%S'";
    time = "date +'%H:%M:%S'";

    tls = "tmux ls";
    tn = "tmux new -s";
    ta = "tmux attach -t";
    tk = "tmux kill-session -t";

    .. = "cd ..";
    ... = "cd ../..";
    .... = "cd ../../..";
    ..... = "cd ../../../..";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
  };
}
