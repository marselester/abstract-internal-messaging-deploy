postgresql:
  pkg:
    - installed
    - names:
      - postgresql-9.1
      - python-dev
      - libpq-dev

  service.running:
    - watch:
      - file: /etc/postgresql/9.1/main/pg_hba.conf
    - require:
      - pkg: postgresql

  file.managed:
    - name: /etc/postgresql/9.1/main/pg_hba.conf
    - source: salt://postgresql/pg_hba.conf
    - user: postgres
    - group: postgres
    - mode: 644
    - require:
      - pkg: postgresql

postgresql-database-setup:
  postgres_user:
    - present
    - name: {{ pillar['postgresql_user'] }}
    - password: {{ pillar['postgresql_password'] }}
    - createdb: True
    - user: postgres
    - require:
      - service: postgresql

  postgres_database:
    - present
    - name: {{ pillar['postgresql_db'] }}
    - encoding: UTF8
    - lc_ctype: en_US.UTF8
    - lc_collate: en_US.UTF8
    - template: template0
    - owner: {{ pillar['postgresql_user'] }}
    - user: postgres
    - require:
      - postgres_user: postgresql-database-setup
