elasticsearch_apt_source:
  file.managed:
    - name: /etc/apt/sources.list.d/elasticsearch.list
    - require:
      - file: {{ salt['pillar.get']('elk:elastic:public_key_path') }}
    - contents: deb {{ salt['pillar.get']('elk:elasticsearch:apt_source') }} stable main

elasticsearch_install:
  pkg.installed:
    - name: elasticsearch
    - refresh: True
    - require:
      - sls: elk.common
    - failhard: True

elasticsearch_service:
  service.running:
    - name: elasticsearch
    - enable: True
    - require:
      - pkg: elasticsearch

#Currently using all default settings.
#elasticsearch_config:
#  file.managed:
#    - name: /etc/elasticsearch/elasticsearch.yml
#    - source: salt://elk/files/elasticsearch/elasticsearch.yml.conf
#    - context:
#      cluster_hosts: salt.dwsutils.get_elastic_cluster_hosts()|join(",")
#    - template: jinja
#    - watch_in:
#      - service: elasticsearch_service
