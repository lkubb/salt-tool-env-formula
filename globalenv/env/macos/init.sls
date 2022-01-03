{%- from 'globalenv/map.jinja' import env -%}

{%- for user in env.users %}
  {%- for name, value in user.env.items() %}
Global environment variable '{{ name }}' is set at login of user {{ user.name }}:
  file.managed:
    - name: {{ user.home }}/Library/LaunchAgents/my.env.var.{{ name }}.plist
    - source: salt://globalenv/files/setenv.plist
    - template: jinja
    - context:
        name: {{ name }}
        value: {{ value }}
    - mode: '0600'
    - user: {{ user.name }}
    - group: {{ user.group }}
    - makedirs: True

Global environment variable '{{ name }}' is updated for applications launched from now on by user '{{ user.name }}':
  cmd.run:
    - name: launchctl load -w {{ user.home }}/Library/LaunchAgents/my.env.var.{{ name }}.plist
    - runas: {{ user.name }}
    - onchanges:
      - file: {{ user.home }}/Library/LaunchAgents/my.env.var.{{ name }}.plist
  {%- endfor %}
{%- endfor %}
