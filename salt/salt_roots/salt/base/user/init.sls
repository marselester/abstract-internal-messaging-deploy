jon_snow:
  user.present

jon_snow public key:
  ssh_auth:
    - present
    - user: jon_snow
    - source: salt://user/id_rsa.pub
    - require:
      - user: jon_snow

jon_snow secret key:
  file:
    - managed
    - name: /home/jon_snow/.ssh/id_rsa
    - source: salt://user/id_rsa
    - user: jon_snow
    - group: jon_snow
    - mode: 600
    - require:
      - ssh_auth: jon_snow public key
