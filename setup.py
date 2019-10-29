import setuptools

setuptools.setup(
    name="jupyter-codeserver-proxy",
    version='1.0b3',
    url="https://github.com/dirkcgrunwald/jupyter-codeserver-proxy.git",
    author="Dirk Grunwald based on Project Jupyter Contributors",
    description="grunwald@colorado.edu",
    packages=setuptools.find_packages(),
	keywords=['Jupyter'],
	classifiers=['Framework :: Jupyter'],
    install_requires=[
        'jupyter-server-proxy'
    ],
    entry_points={
        'jupyter_serverproxy_servers': [
            'codeserver = jupyter_codeserver_proxy:setup_codeserver',
        ]
    },
    package_data={
        'jupyter_codeserver_proxy': ['icons/*'],
    },
)
