# vim: ft=sls

{#-
    *Meta-state*.

    Undoes everything performed in the ``tool_env`` meta-state
    in reverse order.
#}

include:
  - .env.clean
