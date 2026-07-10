#!/bin/bash
set -euxo pipefail

# Change only this value if your GitHub repository has a different name.
GITHUB_USER="IsraelA2003"
REPO_NAME="terraria-game"
BRANCH="main"
APP_DIR="/opt/terraforge"
WEB_DIR="/usr/share/nginx/html"
LOG_FILE="/var/log/terraforge-install.log"

exec > >(tee -a "$LOG_FILE") 2>&1

dnf install -y nginx git
systemctl enable nginx

rm -rf "$APP_DIR"
git clone --depth 1 --branch "$BRANCH" "https://github.com/${GITHUB_USER}/${REPO_NAME}.git" "$APP_DIR"

rm -rf "${WEB_DIR:?}"/*
cp -a "$APP_DIR"/index.html "$APP_DIR"/style.css "$APP_DIR"/game.js "$WEB_DIR"/
chown -R nginx:nginx "$WEB_DIR"
find "$WEB_DIR" -type d -exec chmod 755 {} \;
find "$WEB_DIR" -type f -exec chmod 644 {} \;

cat > /etc/nginx/conf.d/terraforge.conf <<'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name _;
    root /usr/share/nginx/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }

    location ~* \.(js|css|png|jpg|jpeg|gif|svg|ico|webp)$ {
        expires 7d;
        add_header Cache-Control "public, max-age=604800";
    }

    add_header X-Content-Type-Options nosniff always;
    add_header X-Frame-Options SAMEORIGIN always;
    add_header Referrer-Policy strict-origin-when-cross-origin always;
}
NGINX

# Remove the default server block if this image created one.
rm -f /etc/nginx/conf.d/default.conf
nginx -t
systemctl restart nginx

cat > /usr/local/bin/update-terraforge <<UPDATE
#!/bin/bash
set -euxo pipefail
cd "$APP_DIR"
git fetch origin "$BRANCH"
git reset --hard "origin/$BRANCH"
rm -rf "${WEB_DIR:?}"/*
cp -a index.html style.css game.js "$WEB_DIR"/
chown -R nginx:nginx "$WEB_DIR"
find "$WEB_DIR" -type d -exec chmod 755 {} \;
find "$WEB_DIR" -type f -exec chmod 644 {} \;
nginx -t
systemctl reload nginx
UPDATE
chmod 755 /usr/local/bin/update-terraforge
