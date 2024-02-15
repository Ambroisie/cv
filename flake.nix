{
  description = "Ambroisie's CV";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    futils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, futils } @ inputs:
    futils.lib.eachDefaultSystem
      (system:
        let
          inherit (nixpkgs) lib;
          pkgs = nixpkgs.legacyPackages.${system};
          buildInputs = with pkgs; [
            gnumake
            (texliveSmall.withPackages (ps: with ps; [
              # Build script
              latexmk
              # Extra packages needed
              clearsans
              fontaxes
              textpos
              ifmtarg
              marvosym
            ]))
          ];
        in
        {
          devShells = {
            default = pkgs.mkShell {
              name = "cv";
              inherit buildInputs;
            };
          };

          packages = {
            default = pkgs.stdenvNoCC.mkDerivation {
              pname = "cv";
              version = self.rev or "dirty";
              src = ./.;

              inherit buildInputs;

              buildPhase = ''
                make
              '';

              installPhase = ''
                install -Dm644 en.pdf $out/share/en.pdf
                install -Dm644 fr.pdf $out/share/fr.pdf
              '';
            };
          };
        }
      );
}
