# -*- coding: utf-8 -*-
# vim: ft=sls

include:
{%- if 'Darwin' == grains['kernel'] %}
  - .macos.clean
{%- elif 'Windows' == grains['kernel'] %}
  - .windows.clean
{%- elif 'Linux' == grains['kernel'] %}
  - .linux.clean
{%- endif %}
