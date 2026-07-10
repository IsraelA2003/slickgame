# TerraForge — AWS Browser Game

A lightweight Terraria-inspired 2D sandbox game built with HTML5 Canvas. It includes procedural terrain, caves, ores, trees, mining, block placement, enemies, day/night cycles, crafting, health, armor, and responsive controls.

## Controls
- `A/D` or arrow keys: move
- `Space`: jump
- Left click: mine or attack
- Right click: place selected block
- `1–8`: select hotbar item
- `C`: crafting menu
- `R`: regenerate/restart

## Put it on GitHub
Create a public repository under `IsraelA2003`, upload every file in this folder, and note the repository name. The included `user-data.sh` assumes the repository is named `terraria-game`. Change `REPO_NAME` in that script if your repository has another name.

## AWS EC2
1. Launch an Amazon Linux 2023 EC2 instance.
2. Allow inbound TCP port `80` in its security group.
3. Paste `user-data.sh` into Advanced details → User data.
4. Launch the instance.
5. Visit `http://YOUR_EC2_PUBLIC_IP`.

## Updating the live game
SSH into the server and run:
```bash
sudo /usr/local/bin/update-terraforge
```

## Private repository
For a private repository, do not hard-code a personal access token in user data. Use an EC2 IAM role plus AWS Secrets Manager, or deploy through GitHub Actions.
