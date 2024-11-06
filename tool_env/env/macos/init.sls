# vim: ft=sls

{%- set tplroot = tpldir.split("/")[0] %}
{%- from tplroot ~ "/map.jinja" import mapdata as env with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}


{%- for user in env.users | selectattr("env") %}

Global environment variables set at login of user '{{ user.name }}' are managed:
  file.managed:
    - names:
{%-   for name, value in user.env.items() %}
      - {{ user.home | path_join("Library", "LaunchAgents", "my.env.var." ~ name ~ ".plist") }}:
          - context:
              name: {{ name }}
              value: {{ value }}
{%-   endfor %}
    - source: {{ files_switch(["setenv.plist.jinja"],
                              lookup="Global environment variables set at login of user '{}' are managed".format(user.name),
                              opt_prefixes=[user.name])
              }}
    - template: jinja
    - mode: '0600'
    - user: {{ user.name }}
    - group: {{ user.group }}
    - makedirs: true

{%-   for name, value in user.env.items() %}
{%-     set service_file = user.home | path_join("Library", "LaunchAgents", "my.env.var." ~ name ~ ".plist") %}

Global environment variable '{{ name }}' is updated for applications launched from now on by user '{{ user.name }}':
  cmd.run:
    - name: launchctl load -w '{{ service_file }}'
    - runas: {{ user.name }}
    - onchanges:
      - file: '{{ service_file }}'
{%-   endfor %}
{%- endfor %}
