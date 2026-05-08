import os
from ranger.api.commands import Command

class extract(Command):
    """
    :extract

    Extracts the selected archive based on its extension.
    """
    def execute(self):
        # Ensure a file is actually selected
        if not self.fm.thisfile or not self.fm.thisfile.is_file:
            self.fm.notify("No valid file selected to extract!", bad=True)
            return

        filepath = self.fm.thisfile.path
        name = self.fm.thisfile.basename
        name_no_ext = os.path.splitext(name)[0]

        # Determine the appropriate shell command
        if name.endswith(('.tar.bz2', '.tbz2')):
            cmd = f"tar -jxvf '{filepath}'"
        elif name.endswith(('.tar.gz', '.tgz')):
            cmd = f"tar -zxvf '{filepath}'"
        elif name.endswith('.tar'):
            cmd = f"tar -xvf '{filepath}'"
        elif name.endswith('.bz2'):
            cmd = f"bunzip2 '{filepath}'"
        elif name.endswith('.dmg'):
            cmd = f"hdiutil mount '{filepath}'"
        elif name.endswith('.gz'):
            cmd = f"gunzip '{filepath}'"
        elif name.endswith(('.zip', '.ZIP')):
            cmd = f"unzip -d '{name_no_ext}' '{filepath}'"
        elif name.endswith('.pax'):
            cmd = f"cat '{filepath}' | pax -r"
        elif name.endswith('.pax.Z'):
            cmd = f"uncompress '{filepath}' --stdout | pax -r"
        elif name.endswith('.Z'):
            cmd = f"uncompress '{filepath}'"
        elif name.endswith('.7z'):
            cmd = f"7za x '{filepath}'"
        else:
            self.fm.notify(f"'{name}' cannot be extracted via the extract command.", bad=True)
            return

        # Execute the command in Ranger's shell. 
        # The '-w' flag tells Ranger to wait for you to press Enter after it finishes 
        # so you can see if there were any extraction errors.
        self.fm.execute_console(f"shell -w {cmd}")
