# -*- coding: utf-8 -*-
# vim: ft=sls

include:
{%- if 'Darwin' == grains['kernel'] %}
  - .macos
{%- elif 'Windows' == grains['kernel'] %}
  - .windows
{%- elif 'Linux' == grains['kernel'] %}
  - .linux
{%- endif %}


{#-
    Setting env vars for gui and cli apps differs a lot between different systems.
    I did not want to include files randomly depending on a grain for several reasons,
    therefore I chose to make it explicit.

    This will fail on other kernels like OpenBSD/FreeBSD/NetBSD
-#}
