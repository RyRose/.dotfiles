{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  packages = with pkgs; [
    stow # Symlink manager
    git # Version control system
    python3 # Python 3 programming language
    chntpw # Windows registry editor, for dual boot setup.
  ];
}
