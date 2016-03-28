filebeat_group:
  group.present:
    - name: filebeat
    - gid: 4000

# Create a filebeat user that has the privileged groups 'adm' and 'root'.
# The filebeat user needs these group permissions to read log files.
filebeat_user:
  user.present:
    - name: filebeat
    - fullname: FileBeat
    - shell: /usr/sbin/nologin
    - home: /home/filebeat
    - uid: 4000
    - gid: 4000
    - groups:
      - adm
      - root

filebeat_install:
  archive.extracted:
    - name: /opt
    - source: {{ salt['pillar.get']('elk:filebeat:source') }}
    - source_hash: {{ salt['pillar.get']('elk:filebeat:source_hash') }}
    - archive_format: tar
    - tar_options: xf
    - user: filebeat
    - group: filebeat
    - if_missing: {{ salt['pillar.get']('elk:filebeat:dir') }}

# Vagrant is showing weird file permissions, run this check to fix:
filebeat_check_permissions:
    file.directory:
    - name: {{ salt['pillar.get']('elk:filebeat:dir') }}
    - user: filebeat
    - group: filebeat
    - recurse:
        - user
        - group
        - mode

filebeat_symlink:
  file.symlink:
    - name: /opt/filebeat
    - target: {{ salt['pillar.get']('elk:filebeat:dir') }}
    - force: True

filebeat_conf:
  file.managed:
    - name: {{ salt['pillar.get']('elk:filebeat:dir') }}/filebeat.yml
    - source: salt://beats/files/filebeat/filebeat.yml

filebeat_init:
  file.managed:
    - name: /etc/init/filebeat.conf
    - source: salt://beats/files/filebeat/filebeat_upstart.conf

filebeat_service:
  service.running:
    - name: filebeat
    - enable: True
    - reload: True
    - watch:
      - file: {{ salt['pillar.get']('elk:filebeat:dir') }}/filebeat.yml
