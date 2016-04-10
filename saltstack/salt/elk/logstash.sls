logstash_apt_source:
  file.managed:
    - name: /etc/apt/sources.list.d/logstash.list
    - require:
      - cmd: elastic_public_key
    - contents: deb {{ salt['pillar.get']('elk:logstash:apt_source') }} stable main

logstash_install:
  pkg.installed:
    - name: logstash
    - refresh: True
    - require:
      - sls: elk.common
    - failhard: True
  service.running:
    - name: logstash
    - enable: True
    - watch:
      - file: /etc/logstash/conf.d/*
    - require:
      - pkg: logstash

logstash_conf.d input:
  file.managed:
    - name: /etc/logstash/conf.d/input.conf
    - source: salt://elk/files/logstash/input.conf
    - require:
      - pkg: logstash

logstash_conf.d output:
  file.managed:
    - name: /etc/logstash/conf.d/output.conf
    - source: salt://elk/files/logstash/output.conf
    - require:
      - pkg: logstash
