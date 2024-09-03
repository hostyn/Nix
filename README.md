Generate sops key based on ssh key

```
nix run nixpkgs#ssh-to-age -- -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt`
```

Generate pulic key

```
nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt
```
