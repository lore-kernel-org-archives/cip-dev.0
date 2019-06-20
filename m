From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Thu, 20 Jun 2019 18:08:54 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 5
 commits: remotes: refer to configuration files
Message-ID: <5d0bcbb6652e4_74213f92c2642ce43244681@sidekiq-asap-05-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
3ed9dc6d by Daniel Sangorrin at 2019-06-17T20:14:31Z
remotes: refer to configuration files

The Readme indicated some remote names (torvalds, stable) but
not all of them. Ask the user to check conf/remotes.yml instead.
I also added information on how to override or extend the
configuration file (through &#39;~/.config/kernel-sec/remotes.yml&#39;)

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
716ee107 by Daniel Sangorrin at 2019-06-17T20:16:36Z
import_stable: update torvalds remote as well

Otherwise, the script will not find all the expected tags
and fail with a message like:

fatal: ambiguous argument &#39;v5.1..torvalds/master&#39;:
unknown revision or path not in the working tree

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
b2aed3f3 by Daniel Sangorrin at 2019-06-18T14:43:19Z
remotes: call _get_configured_remotes

This is probably a copy&amp;paste mistake that had no effect
because the contents of _get_configured_remotes and
_get_configured_branches is the same.

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
6210caef by Daniel Sangorrin at 2019-06-20T17:41:20Z
branch: fix remotes mapping

Probably a copy&amp;paste error that never got checked because
nobody is using the mapping functionality.

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
b257980d by Daniel Sangorrin at 2019-06-20T17:41:20Z
help:remote_name: use colon instead of equal

The example and implementation use a colon (:) to specify
remote mappings, but the command&#39;s help use the equal
sign (=).

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -


5 changed files:

- README.md
- scripts/import_stable.py
- scripts/kernel_sec/branch.py
- scripts/report_affected.py
- scripts/webview.py


Changes:

=====================================
README.md
=====================================
@@ -18,9 +18,10 @@ beneath that.  They require PyYAML and html5lib (packaged in Debian as
 python3-yaml and python3-html5lib).
 
 Many scripts require access to a kernel git repository.  By default
-this is assumed to be in `../kernel`, with remotes named `torvalds`
-and `stable` for the mainline and stable repositories.  These can
-be overridden by command-line options or by configuration.
+this is assumed to be in `../kernel`, with remotes configured in
+`conf/remotes.yml`, e.g. `torvalds`, `stable` and `cip` for the mainline,
+stable and cip repositories. These can be overridden by command-line options
+or configuration (`~/.config/kernel-sec/remotes.yml`).
 
 * `scripts/import_debian.py` - import information from Debian's
 `kernel_sec` project.  It includes all issues that Debian considers


=====================================
scripts/import_stable.py
=====================================
@@ -137,8 +137,7 @@ def add_backports(branches, c_b_map, issue_commits, all_backports,
 
 def main(git_repo, remotes, debug=False):
     branches = kernel_sec.branch.get_live_branches()
-    remote_names = set(branch['git_remote'] for branch in branches
-                       if branch['short_name'] != 'mainline')
+    remote_names = set(branch['git_remote'] for branch in branches)
 
     for remote_name in remote_names:
         update(git_repo, remotes[remote_name]['git_name'])
@@ -175,7 +174,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",


=====================================
scripts/kernel_sec/branch.py
=====================================
@@ -209,10 +209,10 @@ def get_remotes(mappings, mainline=None, stable=None):
     remotes = RemoteMap()
     remotes.update(_get_configured_remotes('conf/remotes.yml'))
     remotes.update(
-        _get_configured_branches(
+        _get_configured_remotes(
             os.path.expanduser('~/.config/kernel-sec/remotes.yml')))
     for mapping in mappings:
-        left, right = arg.split(':', 1)
+        left, right = mapping.split(':', 1)
         remotes[left]['git_name'] = right
     if mainline:
         remotes['torvalds']['git_name'] = mainline


=====================================
scripts/report_affected.py
=====================================
@@ -76,7 +76,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",


=====================================
scripts/webview.py
=====================================
@@ -206,7 +206,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/e200ae50e6cb7c480c55b2d8cd279f374fa9c5a3...b257980d1c30e737c5b36feeb4ff6c6b81cc2fd9

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/e200ae50e6cb7c480c55b2d8cd279f374fa9c5a3...b257980d1c30e737c5b36feeb4ff6c6b81cc2fd9
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190620/98d9d614/attachment-0001.html>
