# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as env with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

{%- for user in env.users %}
{%-   for name, value in user.env.items() %}
{%-     set service_file = user.home | path_join('Library', 'LaunchAgents', 'my.env.var.' ~ name ~ '.plist') %}

Global environment variable '{{ name }}' is unloaded for '{{ user.name }}':
  cmd.run:
    - name: launchctl unload '{{ service_file }}'
    - runas: {{ user.name }}
    - onlyif:
      - sudo -u {{ user.name }} launchctl list | grep {{ salt['file.basename'](service_file)[:-6] }}
{%-   endfor %}

Global environment variables set at login of user '{{ user.name }}' are absent:
  file.absent:
    - names:
{%-   for name, value in user.env.items() %}
      - {{ user.home | path_join('Library', 'LaunchAgents', 'my.env.var.' ~ name ~ '.plist') }}
{%-   endfor %}
{%- endfor %}
