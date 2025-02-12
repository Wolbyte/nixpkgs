{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "dnscontrol";
  version = "4.4.0";

  src = fetchFromGitHub {
    owner = "StackExchange";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-OxZH8dUl7PEzcan9Jl1rwPpP0+pj4jzLydEQfxxWM+o=";
  };

  vendorHash = "sha256-3aGdn6Gp+N/a+o9dl4h0oIOnYhtu4oZuBF6X/HKjQOI=";

  subPackages = [ "." ];

  ldflags = [ "-s" "-w" "-X=main.Version=${version}" ];

  preCheck = ''
    # requires network
    rm pkg/spflib/flatten_test.go pkg/spflib/parse_test.go
  '';

  meta = with lib; {
    description = "Synchronize your DNS to multiple providers from a simple DSL";
    homepage = "https://dnscontrol.org/";
    changelog = "https://github.com/StackExchange/dnscontrol/releases/tag/${src.rev}";
    license = licenses.mit;
    maintainers = with maintainers; [ mmahut SuperSandro2000 ];
    mainProgram = "dnscontrol";
  };
}
