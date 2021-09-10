# RemoteSSH

Remote control Pi and setup SSH tunneling

Install Cloudflared
```
sudo systemctl enable ssh
sudo systemctl start ssh
sudo dpkg --add-architecture arm
wget -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm.deb
sudo dpkg -i cloudflared-linux-arm64.deb
```

Then run this which will give you a link that you must put in a browser to authenticate through cloudflare
```
sudo cloudflared tunnel login
```

Create the tunnel
```
sudo cloudflared tunnel create terminal
```
Now you must set up Authentication & access in Cloudflare (Google or one-time pin). Ensure this application in Cloudflare Teams has an application domain of pi4 then your domain, as this will be the full domain we use.

Back to the pi, get the tunnel id from 
```
sudo cloudflared tunnel list
```
And update the config file (/home/pi/.cloudflared/config.yml) to include the path to the credentials file (also in /hommme/pi/.cloudflared/), the ID of the tunnel and make the hostname pi4.\<domain>.com.
```
tunnel: <tunnel-id>
credentials-file: /root/.cloudflared/<tunnel-id>.json

ingress:
  - hostname: pi4.<domain>.com
    service: ssh://localhost:22
  - service: http_status:404
```

Now run the tunnel
```
sudo cloudflared tunnel run terminal
sudo cloudflared tunnel route dns <tunnel id> pi4.<domain>.com
```

Now go to pi4.\<domain>.com and authentiicate yourself, and see if you have access to your pi's terminal.

Now install it as a service
```
sudo cloudflared --config .cloudflared/config.yml service install
```


Please see this blog for inspiration
https://blog.cloudflare.com/ssh-raspberry-pi-400-cloudflare-tunnel-auditable-terminal/

And note that Cloudflare support these ports by default:
```
HTTP:   80, 8080, 8880, 2052, 2082, 2086, 2095
HTTPS: 443, 2053, 2083, 2087, 2096, 8443
```