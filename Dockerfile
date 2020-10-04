# hadolint ignore=DL3007
FROM jupyter/minimal-notebook:latest

ARG code_server_proxy_wheel="jupyter_codeserver_proxy-1.0b3-py3-none-any.whl"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# prerequisites ----
# hadolint ignore=DL3008
RUN apt-get update && apt-get install -yq --no-install-recommends \
    curl \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# code-server install ----
#TODO: replace by wget already installed in the imag
RUN curl -fsSL https://code-server.dev/install.sh | sh && \
    rm -rf "${HOME}/.cache"

USER $NB_UID

# set the home directory
ENV CODE_WORKINGDIR="${HOME}/work"

# code-server proxy copy package ----
COPY ./dist/${code_server_proxy_wheel} /${HOME}/

# jupyter-server-proxy + code-server proxy install ----
# hadolint ignore=DL3013
RUN conda install --quiet --yes \
    'jupyter-server-proxy' && \
    jupyter labextension install @jupyterlab/server-proxy && \
    pip install --quiet --no-cache-dir "${HOME}/${code_server_proxy_wheel}" && \
    rm "${HOME}/${code_server_proxy_wheel}" && \
    jupyter lab clean -y && \
    npm cache clean --force && \
    conda clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"

WORKDIR $HOME
