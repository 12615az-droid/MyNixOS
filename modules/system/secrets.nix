{ ... }:

{
  age.identityPaths = [
    "/var/lib/agenix/recovery"
  ];

  age.secrets.github-ssh = {
    file = ../../secrets/github_ed25519.age;
    owner = "popov";
    group = "users";
    mode = "600";
  };

  age.secrets.server-ssh = {
    file = ../../secrets/server_ed25519.age;
    owner = "popov";
    group = "users";
    mode = "600";
  };

age.secrets.vpn-nm-env = {
  file = ../../secrets/vpn_nm_env.age;
  owner = "root";
  group = "root";
  mode = "600";
};
}
