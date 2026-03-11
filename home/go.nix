{ pkgs, ... }:

{
  home.packages = with pkgs; [
    go

    # Language server
    gopls

    # Formatter
    gofumpt

    # Linter
    golangci-lint

    # Debug adapter
    delve

    # Tools
    gotools      # includes goimports, godoc, etc.
    gore         # Go REPL
    gotests      # Generate Go tests
    gomodifytags # Modify struct field tags
  ];

  home.sessionVariables = {
    GOPATH = "$HOME/go";
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];
}
