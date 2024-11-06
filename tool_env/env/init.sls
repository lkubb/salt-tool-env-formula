# vim: ft=sls

include:
{%- if grains.kernel == "Darwin" %}
  - .macos
{%- elif grains.kernel == "Windows" %}
  - .windows
{%- elif grains.kernel == "Linux" %}
  - .linux
{%- endif %}


{#-
    Setting env vars for gui and cli apps differs a lot between different systems.
    I did not want to include files randomly depending on a grain for several reasons,
    therefore I chose to make it explicit.

    This will fail on other kernels like OpenBSD/FreeBSD/NetBSD
-#}
