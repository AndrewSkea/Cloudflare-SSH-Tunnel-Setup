sudo systemctl enable ssh
sudo systemctl start ssh
wget -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb
sudo dpkg -i cloudflared-stable-linux-amd64.deb
sudo cloudflared tunnel login
