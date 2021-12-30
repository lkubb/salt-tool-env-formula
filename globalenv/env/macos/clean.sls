{%- from 'globalenv/map.jinja' import env -%}

{%- for user in env.users %}
  {%- set plists = salt['file.find'](user.home ~ '/Library/LaunchAgents/my.env.var.*.plist') -%}
All generated environment plists are unloaded for user {{ user.name }}:
  cmd.run:
    - name: |
{%- for plist in plists %}
        launchctl unload -w {{ plist }}
{%- endfor %}

All generated environment plists are absent for user {{ user.name }}:
  file.absent:
    - names: {{ plists | json }}
{%- endfor %}
