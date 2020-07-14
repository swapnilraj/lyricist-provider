{ mkDerivation, aeson, base, bytestring, dom-selector, html-conduit
, http-client, http-conduit, mtl, servant-server, stdenv
, string-conversions, text, wai-logger, warp, xml-conduit
}:
mkDerivation {
  pname = "lyricist-provider";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [
    aeson base bytestring dom-selector html-conduit http-client
    http-conduit mtl servant-server string-conversions text wai-logger
    warp xml-conduit
  ];
  license = stdenv.lib.licenses.bsd3;
}
