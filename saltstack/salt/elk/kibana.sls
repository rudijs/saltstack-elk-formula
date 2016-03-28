kibana_install:
  archive.extracted:
    - name: /opt
    - source: {{ salt['pillar.get']('elk:kibana:source') }}
    - source_hash: {{ salt['pillar.get']('elk:kibana:source_hash') }}
    - archive_format: tar
    - tar_options: xf
    - user: logstash
    - group: logstash
    - if_missing: {{ salt['pillar.get']('elk:kibana:dir') }}
    - require:
      - sls: elk.elasticsearch
      - sls: elk.logstash
    - failhard: True

kibana_symlink:
  file.symlink:
    - name: /opt/kibana
    - target: {{ salt['pillar.get']('elk:kibana:dir') }}

kibana_init:
  file.managed:
    - name: /etc/init/kibana.conf
    - source: salt://elk/files/kibana/kibana_upstart.conf

kibana_service:
  service.running:
    - name: kibana
    - enable: True
