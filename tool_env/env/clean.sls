# vim: ft=sls

include:
{%- if grains.kernel == "Darwin" %}
  - .macos.clean
{%- elif grains.kernel == "Windows" %}
  - .windows.clean
{%- elif grains.kernel == "Linux" %}
  - .linux.clean
{%- endif %}
