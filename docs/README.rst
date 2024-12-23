.. _readme:

Global Environment Variables Formula
====================================

Manages global environment variables in the user environment. It therefore provides a way to set environment variables that are independent from a user's shell configuration and are loaded during login. These variables are available to GUI and CLI applications alike. On MacOS, a custom Launch Agent will be installed that sets the variable since other methods are deprecated. Linux and Windows are currently not implemented, but Linux will follow soon.

.. contents:: **Table of Contents**
   :depth: 1

Usage
-----
Applying ``tool_env`` will make sure user-scope global environment variables are configured as specified.

Configuration
-------------

This formula
~~~~~~~~~~~~
The general configuration structure is in line with all other formulae from the `tool` suite, for details see :ref:`toolsuite`. An example pillar is provided, see :ref:`pillar.example`. Note that you do not need to specify everything by pillar. Often, it's much easier and less resource-heavy to use the ``parameters/<grain>/<value>.yaml`` files for non-sensitive settings. The underlying logic is explained in :ref:`map.jinja`.

User-specific
^^^^^^^^^^^^^
The following shows an example of ``tool_env`` per-user configuration. If provided by pillar, namespace it to ``tool_global:users`` and/or ``tool_env:users``. For the ``parameters`` YAML file variant, it needs to be nested under a ``values`` parent key. The YAML files are expected to be found in

1. ``salt://tool_env/parameters/<grain>/<value>.yaml`` or
2. ``salt://tool_global/parameters/<grain>/<value>.yaml``.

.. code-block:: yaml

  user:

      # Persist environment variables used by this formula for this
      # user to this file (will be appended to a file relative to $HOME)
    persistenv: '.config/zsh/zshenv'

      # Add runcom hooks specific to this formula to this file
      # for this user (will be appended to a file relative to $HOME)
    rchook: '.config/zsh/zshrc'

      # This user's configuration for this formula. Will be overridden by
      # user-specific configuration in `tool_env:users`.
      # Set this to `false` to disable configuration for this user.
    env:
        # Mapping of environment variables to requested values.
      XDG_CACHE_HOME: ${HOME}/.cache
      XDG_CONFIG_HOME: ${HOME}/.config
      XDG_DATA_HOME: ${HOME}/.local/share
      XDG_STATE_HOME: ${HOME}/.local/state

Formula-specific
^^^^^^^^^^^^^^^^

.. code-block:: yaml

  tool_env:

      # Specify an explicit version (works on most Linux distributions) or
      # keep the packages updated to their latest version on subsequent runs
      # by leaving version empty or setting it to 'latest'
      # (again for Linux, brew does that anyways).
    version: latest

      # Default formula configuration for all users.
    defaults:
        # Default mapping of environment variables to requested values.
      XDG_CACHE_HOME: default value for all users

Config file serialization
~~~~~~~~~~~~~~~~~~~~~~~~~
This formula serializes configuration into a config file. A default one is provided with the formula, but can be overridden via the TOFS pattern. See :ref:`tofs_pattern` for details.


Available states
----------------

The following states are found in this formula:

.. contents::
   :local:


``tool_env``
~~~~~~~~~~~~
*Meta-state*.

Performs all operations described in this formula according to the specified configuration.


``tool_env.env``
~~~~~~~~~~~~~~~~



``tool_env.env.linux``
~~~~~~~~~~~~~~~~~~~~~~



``tool_env.env.macos``
~~~~~~~~~~~~~~~~~~~~~~



``tool_env.env.windows``
~~~~~~~~~~~~~~~~~~~~~~~~



``tool_env.clean``
~~~~~~~~~~~~~~~~~~
*Meta-state*.

Undoes everything performed in the ``tool_env`` meta-state
in reverse order.


``tool_env.env.clean``
~~~~~~~~~~~~~~~~~~~~~~



``tool_env.env.linux.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~



``tool_env.env.macos.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~



``tool_env.env.windows.clean``
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




Development
-----------

Contributing to this repo
~~~~~~~~~~~~~~~~~~~~~~~~~

Commit messages
^^^^^^^^^^^^^^^

Commit message formatting is significant.

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

pre-commit
^^^^^^^^^^

`pre-commit <https://pre-commit.com/>`_ is configured for this formula, which you may optionally use to ease the steps involved in submitting your changes.
First install  the ``pre-commit`` package manager using the appropriate `method <https://pre-commit.com/#installation>`_, then run ``bin/install-hooks`` and
now ``pre-commit`` will run automatically on each ``git commit``.

.. code-block:: console

  $ bin/install-hooks
  pre-commit installed at .git/hooks/pre-commit
  pre-commit installed at .git/hooks/commit-msg

State documentation
~~~~~~~~~~~~~~~~~~~
There is a script that semi-autodocuments available states: ``bin/slsdoc``.

If a ``.sls`` file begins with a Jinja comment, it will dump that into the docs. It can be configured differently depending on the formula. See the script source code for details currently.

This means if you feel a state should be documented, make sure to write a comment explaining it.

Todo
----
* support Linux (easy)
* support Windows (not sure atm)
