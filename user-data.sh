#!/bin/bash
set -e
GITHUB_USER="IsraelA2003"
REPO_NAME="dicebound-roguelike"
APP_DIR="/usr/share/nginx/html"
dnf update -y
dnf install -y git nginx
systemctl enable --now nginx
rm -rf "${APP_DIR:?}"/* /tmp/dicebound
git clone "https://github.com/${GITHUB_USER}/${REPO_NAME}.git" /tmp/dicebound
cp -R /tmp/dicebound/* "$APP_DIR/"
rm -rf /tmp/dicebound
cat > /usr/local/bin/update-dicebound <<'SCRIPT'
#!/bin/bash
set -e
rm -rf /tmp/dicebound
git clone "https://github.com/IsraelA2003/dicebound-roguelike.git" /tmp/dicebound
rm -rf /usr/share/nginx/html/*
cp -R /tmp/dicebound/* /usr/share/nginx/html/
rm -rf /tmp/dicebound
systemctl restart nginx
echo "Dicebound updated."
SCRIPT
chmod +x /usr/local/bin/update-dicebound
chown -R nginx:nginx "$APP_DIR"
restorecon -Rv "$APP_DIR" || true
systemctl restart nginx
