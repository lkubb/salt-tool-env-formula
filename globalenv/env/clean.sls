{#- setting env vars for gui and cli apps differs a lot between different systems.
    I did not want to include files randomly depending on a grain for several reasons,
    therefore I chose to make it explicit. this will fail on other kernels like OpenBSD/FreeBSD/NetBSD -#}

include:
{%- if 'Darwin' == grains['kernel'] %}
  - .macos.clean
{%- elif 'Windows' == grains['kernel'] %}
  - .windows.clean
{%- elif 'Linux' == grains['kernel'] %}
  - .linux.clean
{%- endif %}
