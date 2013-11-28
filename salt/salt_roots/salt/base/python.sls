python2:
  pkg:
    - installed
    - names:
      - python-dev
      - python

pip:
  pkg:
    - installed
    - name: python-pip
    - require:
      - pkg: python2

virtualenv:
  pip:
    - installed
    - require:
      - pkg: pip
