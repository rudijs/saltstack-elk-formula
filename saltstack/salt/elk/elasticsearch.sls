elasticsearch_apt_source:
  file.managed:
    - name: /etc/apt/sources.list.d/elasticsearch.list
    - require:
      - file: {{ salt['pillar.get']('elk:elastic:public_key_path') }}
    - contents: deb {{ salt['pillar.get']('elk:elasticsearch:apt_source') }} stable main

elasticsearch_install:
  pkg.installed:
    - name: elasticsearch
    - require:
      - sls: elk.common
    - failhard: True
  service.running:
    - name: elasticsearch
    - enable: True
#    - watch:
#      - file: elastic_conf
    - require:
      - pkg: elasticsearch