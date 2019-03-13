=========
Cloud9 IDE
=========

http://coder.com is a port of microsoft VScode to the browser

This package is a plugin for `jupyter-server-proxy <https://jupyter-server-proxy.readthedocs.io/>`_
that lets you run an instance of cloud9 alongside your notebook, primarily
in a JupyterHub / Binder environment.

Installing code-server
================
```
RUN	cd /opt && \
	mkdir /opt/code-server && \
	cd /opt/code-server && \
	wget -qO- https://github.com/codercom/code-server/releases/download/1.32.0-245/code-server-1.32.0-245-linux-x64.tar.gz | tar zxvf - --strip-components=1

ENV	PATH=/opt/code-server:$PATH
```

