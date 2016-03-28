base:
  '*':
    - common

  'minion1':
    - elk
    - beats.filebeat

  'minion2':
    - beats.filebeat
