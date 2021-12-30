# Globalenv Salt Formula
## Overview
This formula provides a way to set environment variables that are independent from a user's shell configuration and are loaded during login. These variables are available to GUI and CLI applications alike. On MacOS, a custom Launch Agent will be installed that sets the variable since other methods are deprecated. Linux and Windows are currently not implemented, but Linux will follow soon.

## Pillar Configuration
### User-specific
```yaml
globalenv:
  users:
    user:
      env:
        var_name: var_value
```
### Formula-specific
```yaml
globalenv:
  defaults:
    default_var: default_value
```

## Todo
* support Linux (easy)
* support Windows (not sure atm)
