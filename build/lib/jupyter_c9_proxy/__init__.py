"""
Return config on servers to start for cloud9

See https://jupyter-server-proxy.readthedocs.io/en/latest/server-process.html
for more information.
"""
import os
import shutil

def setup_c9():
    # Make sure cloud9 is in $PATH
    def _cloud9_command(port):
        full_path = shutil.which('node')
        if not full_path:
            raise FileNotFoundError('Can not find node executable in $PATH')
        path = os.getenv("C9SDK") or "/opt/c9sdk"
        bin = path + "/server.js"
        if not os.path.isfile(bin):
            raise FileNotFoundError('Can not find cloud9 server.js')
        return ['node', bin, '--listen=127.0.0.1', '--port=' + str(port), "-a", ":", "--packed"]

    return {
        'command': _cloud9_command,
        'environment': {
            'USE_LOCAL_GIT': 'true'
        },
        'launcher_entry': {
            'title': 'C9 IDE',
            'icon_path': os.path.join(os.path.dirname(os.path.abspath(__file__)), 'icons', 'c9.svg')
        }
    }
