server {
  listen [::]:443 ssl http2;
  listen 443 ssl http2;

  server_name www.example.com;

  include h5bp/tls/ssl_engine.conf;
  # NOTE(secondfry): instead of include h5bp/tls/certificate_files.conf;
  # we use Let's Encrypt!
  ssl_certificate_key /etc/letsencrypt/live/example-com/privkey.pem;
  # NOTE(secondfry): inlined include h5bp/tls/policy_strict.conf;
  ssl_protocols TLSv1.2 TLSv1.3;
  ssl_ciphers EECDH+CHACHA20:EECDH+AES;
  ssl_ecdh_curve X25519;
  ssl_early_data on;

  return 301 $scheme://example.com$request_uri;
}

server {
  # listen [::]:443 ssl http2 accept_filter=dataready;  # for FreeBSD
  # listen 443 ssl http2 accept_filter=dataready;  # for FreeBSD
  listen [::]:443 ssl http2;
  listen 443 ssl http2;

  # The host name to respond to
  server_name example.com;

  include h5bp/tls/ssl_engine.conf;
  # NOTE(secondfry): instead of include h5bp/tls/certificate_files.conf;
  # we use Let's Encrypt!
  ssl_certificate_key /etc/letsencrypt/live/example-com/privkey.pem;
  # NOTE(secondfry): inlined include h5bp/tls/policy_strict.conf;
  ssl_protocols TLSv1.2 TLSv1.3;
  ssl_ciphers EECDH+CHACHA20:EECDH+AES;
  ssl_ecdh_curve X25519;
  ssl_early_data on;

  # Path for static files
  root /var/www/example.com/public;

  # Custom error pages
  include h5bp/errors/custom_errors.conf;

  # Include the basic h5bp config set
  include h5bp/basic.conf;
}
