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


}
