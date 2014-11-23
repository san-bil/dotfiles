import sys
import os
from subprocess import call
import subprocess
import os.path
import re

if __name__ == "__main__":

    script_parent = os.path.dirname(os.path.realpath(__file__))
    script_gparent = os.path.dirname(script_parent)
    find_res = subprocess.Popen('find '+script_gparent, shell=True, stdout=subprocess.PIPE)
    repo_items = find_res.stdout.readlines()
    home_folder = os.getenv("HOME")

    f = open(os.path.join(script_parent, 'run_me.sh'),'w')

    for item in repo_items:
        item = item.strip()
        
        item_name = os.path.basename(item)
        if not ( re.search('\.git/',item) or re.search('\.gitignore$',item) or re.search('install', item) ):

            if os.path.isfile(item):

                new_item_parent = (os.path.dirname(item)).replace(script_gparent,home_folder)

                if not (new_item_parent == '~'):
                   mkdir_cmd = "mkdir -p "+new_item_parent
                   print(mkdir_cmd)

                symlink_path = os.path.join(new_item_parent,item_name)
                symlink_cmd = "ln -sf "+item+" "+symlink_path
                f.write(symlink_cmd+'\n')

    f.close()
