{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, libxkbcommon
, openssl
, sqlite
, stdenv
, wayland
}:

rustPlatform.buildRustPackage rec {
  pname = "gossip";
  version = "0.8.1";

  src = fetchFromGitHub {
    owner = "mikedilger";
    repo = "gossip";
    rev = "v${version}";
    hash = "sha256-YRlIZgyRzXBZwpBOWqbQ/vUID4PGtmBXsv+NjtCTfj4=";
  };

  cargoLock = {
    lockFile = ./Cargo.lock;
    outputHashes = {
      "ecolor-0.22.0" = "sha256-4ZGgtUWIDcgZfMkCdYpUK/pHjdsotVVr/4Aa1W8tNl8=";
      "egui-video-0.1.0" = "sha256-HPnZ0Do2hvWCSGCxv+NZHNVKYOOWufJURcs7w+Ctazo=";
      "ffmpeg-next-6.0.0" = "sha256-k8aGyNdaDs85bb3nTWwmnIyQiMIpC/C6HyFMbWZoMDU=";
      "gossip-relay-picker-0.2.0-unstable" = "sha256-+1JKIK5tB+YIs/P7FTMZsZs6tkcmPY3B9asp5Z9KeQE=";
      "heed-0.20.0-alpha.4" = "sha256-fnT32ntkZB79AIg7c9+5Bry/Dlc5+VgOaoUyy1JYGMc=";
      "nostr-types-0.7.0-unstable" = "sha256-6ApmcyIiFuWdAsFpg9eEHS7MK4mXROW4dSIHFuVF0j4=";
      "qrcode-0.12.0" = "sha256-onnoQuMf7faDa9wTGWo688xWbmujgE9RraBialyhyPw=";
      "sdl2-0.35.2" = "sha256-qPId64Y6UkVkZJ+8xK645at5fv3mFcYaiInb0rGUfL4=";
      "speedy-0.8.6" = "sha256-ltJQud1kEYkw7L2sZgPnD/teeXl2+FKgyX9kk2IC2Xg=";
    };
  };

  nativeBuildInputs = [
    pkg-config
    rustPlatform.bindgenHook
  ];

  buildInputs = [
    libxkbcommon
    openssl
    sqlite
  ] ++ lib.optionals stdenv.isLinux [
    wayland
  ];

  meta = with lib; {
    description = "Gossip is a nostr client";
    homepage = "https://github.com/mikedilger/gossip";
    license = licenses.mit;
    maintainers = with maintainers; [jasonodoom];
  };
}

