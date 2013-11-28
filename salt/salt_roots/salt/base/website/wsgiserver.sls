supervisord conf:
  file:
    - managed
    - name: /etc/supervisor/conf.d/website_gunicorn.conf
    - source: salt://website/supervisord.conf
    - template: jinja

gunicorn conf:
  file:
    - managed
    - name: {{ pillar ['website_gunicorn_conf_path'] }}
    - source: salt://website/gunicorn.conf.py
    - user: jon_snow
    - group: jon_snow

supervisor:
  pkg:
    - installed

supervisored gunicorn:
  supervisord:
    - running
    - name: website_gunicorn
    - update: True
    - restart: True
    - watch:
      - file: supervisord conf
      - file: gunicorn conf
    - require:
      - pkg: supervisor
