

let
  recovery = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxqAx3tSDGyST/Q90ZVl4507U2zjMImihRBXh96pobv agenix-recovery
";
in
{
 "github_ed25519.age".publicKeys = [ recovery ];
}

