# Neither of those require you to configure your git user name/email.

git:
  pkg.installed

github.com:
  ssh_known_hosts:
    - present
    - user: jon_snow
    - fingerprint: 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48

messaging repository clone:
  cmd:
    - run
    - unless: test -d /home/jon_snow/messaging_repository
    - user: jon_snow
    - name: >
              git clone https://github.com/marselester/abstract-internal-messaging.git /home/jon_snow/messaging_repository
    - require:
      - pkg: git
      - ssh_known_hosts: github.com

messaging latest source code:
  cmd:
    - run
    - cwd: /home/jon_snow/messaging_repository
    - user: jon_snow
    - name: >
              git fetch origin &&
              git reset --hard origin/master
    - require:
      - cmd: messaging repository clone

  file:
    - symlink
    - name: {{ pillar['website_src_dir'] }}
    - target: /home/jon_snow/messaging_repository
    - force: True
    - user: jon_snow
