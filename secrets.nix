let
  donnan = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHxCAff3/nhO7qXVHEz/T98wt/2sVWcLnvMRp6/wq3d0";
  brutus = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH1ueAYgvxSqr8kW726E2dBY9m0kHSS161h510FisQgZ";
in
{
  "secret1.age".publicKeys = [donnan brutus];
}
