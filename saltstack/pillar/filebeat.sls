filebeat:

  # The Logstash hosts
  logstash:
      hosts:
        - 192.168.50.11:5044

  # Paths that should be crawled and fetched. Glob based paths.
  paths:
    - /var/log/*.log
    - /var/log/upstart/*.log
    - /var/log/syslog

  nodes:
    saltminion1:
      paths:
        - /tmp/test.log
    saltminion2:
      paths:
        - /tmp/test.log
