openjdk_install:
  pkg.installed:
    - name: openjdk-7-jre
    - refresh: True
    - failhard: True

elastic_public_key:

  file.managed:
    - name: {{ salt['pillar.get']('elk:elastic:public_key_path') }}
    - contents: |
        {{ salt['pillar.get']('elk:elastic:public_key') | indent(8) }}

  cmd.run:
    - name: cat {{ salt['pillar.get']('elk:elastic:public_key_path') }} | apt-key add -
    - require:
      - file: {{ salt['pillar.get']('elk:elastic:public_key_path') }}
