{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (python312.withPackages (ps: with ps; [
      gcsfs
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
