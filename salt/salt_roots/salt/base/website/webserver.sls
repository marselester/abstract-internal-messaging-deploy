nginx:
  pkgrepo:
    - managed
    - name: deb http://nginx.org/packages/ubuntu/ precise nginx
    - key_url: http://nginx.org/keys/nginx_signing.key

  pkg:
    - installed
    - require:
      - pkgrepo: nginx

  service:
    - running
    - watch:
      - pkg: nginx
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file:
    - managed
    - source: salt://website/nginx.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
