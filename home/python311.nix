{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (python311.withPackages (ps: with ps; [
      numpy
      polars
      pandas
      pyarrow
      matplotlib
      seaborn
      scikit-learn
    ]))
  ];
}
