{{ pillar['website_venv_dir'] }}:
  file:
    - directory
    - user: jon_snow
    - group: jon_snow
    - makedirs: True

  virtualenv:
    - managed
    - no_site_packages: True
    - distribute: True
    - requirements: {{ pillar['website_requirements_path'] }}
    - user: jon_snow
    - no_chown: True
    - require:
      - pip: virtualenv
      - file: {{ pillar['website_venv_dir'] }}

django settings:
  file:
    - managed
    - name: {{ pillar['website_settings_path'] }}
    - source: salt://website/local.py.template
    - template: jinja

django-admin collectstatic:
  module:
    - run
    - name: django.collectstatic
    - bin_env: {{ pillar['website_venv_dir'] }}
    - settings_module: messaging.settings.local
    - pythonpath: {{ pillar['website_src_dir'] }}
    - noinput: True
    - require:
      - virtualenv: {{ pillar['website_venv_dir'] }}
      - file: django settings

django-admin migrate:
  module:
    - run
    - name: django.syncdb
    - bin_env: {{ pillar['website_venv_dir'] }}
    - settings_module: messaging.settings.local
    - pythonpath: {{ pillar['website_src_dir'] }}
    - migrate: True
    - require:
      - virtualenv: {{ pillar['website_venv_dir'] }}
      - file: django settings
