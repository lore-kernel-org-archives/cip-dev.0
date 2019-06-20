From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 20 Jun 2019 14:51:43 +0900
Subject: [cip-dev] [cip-kernel-sec][PATCH v2 3/3] remotes: check that
	remotes exist
In-Reply-To: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
References: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190620055143.341-3-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This patch introduces some checks for the local git
repository containing the remotes configured in
conf/remotes.yml

These checks occur at the beginning of import_stable.py,
report_affected.py and webview.py, to make sure that
the local repository is consistent with the configuration
yaml files.

We also add a new script, prepare_remotes.py, that is
useful to bootstrap the local git repository with the
configured remote branches. Expert users may want
to use their own, but the script is helpful for new
users or a quickstart.

Both the checks and the new script, take repository
name mappings into account.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 README.md                    |  5 ++++
 conf/remotes.yml             |  3 +++
 scripts/import_stable.py     |  9 +++----
 scripts/kernel_sec/branch.py | 42 ++++++++++++++++++++++++++++++++
 scripts/prepare_remotes.py   | 46 ++++++++++++++++++++++++++++++++++++
 scripts/report_affected.py   |  1 +
 scripts/webview.py           |  1 +
 7 files changed, 101 insertions(+), 6 deletions(-)
 create mode 100755 scripts/prepare_remotes.py

diff --git a/README.md b/README.md
index 4c5808f..576cc75 100644
--- a/README.md
+++ b/README.md
@@ -23,6 +23,10 @@ this is assumed to be in `../kernel`, with remotes configured in
 stable and cip repositories. These can be overridden by command-line options
 or configuration (`~/.config/kernel-sec/remotes.yml`).
 
+* `scripts/prepare_remotes.py` - creates the local git repository
+and adds all configured remotes. You may prefer to skip this script
+and configure the repository by hand.
+
 * `scripts/import_debian.py` - import information from Debian's
 `kernel_sec` project.  It includes all issues that Debian considers
 active or that are already tracked here.
@@ -81,6 +85,7 @@ with the keys:
   branch from this remote.
 * `git_name`: (optional) The name actually used for this git
   remote, if it's different from the default.
+* `git_repo_url`: URL of the remote git repository.
 
 ## Contributions
 
diff --git a/conf/remotes.yml b/conf/remotes.yml
index 51c523d..cfaa35f 100644
--- a/conf/remotes.yml
+++ b/conf/remotes.yml
@@ -1,6 +1,9 @@
 torvalds:
   commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=
+  git_repo_url: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
 stable:
   commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit?id=
+  git_repo_url: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
 cip:
   commit_url_prefix: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commit?id=
+  git_repo_url: https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index 2c88b07..194219d 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -31,11 +31,6 @@ BACKPORT_COMMIT_BOTTOM_RE = re.compile(
     .format(**RE_USE))
 
 
-def update(git_repo, remote_name):
-    subprocess.check_call(['git', 'remote', 'update', remote_name],
-                          cwd=git_repo)
-
-
 def get_backports(git_repo, remotes, branches, debug=False):
     backports = {}
 
@@ -140,7 +135,8 @@ def main(git_repo, remotes, debug=False):
     remote_names = set(branch['git_remote'] for branch in branches)
 
     for remote_name in remote_names:
-        update(git_repo, remotes[remote_name]['git_name'])
+        kernel_sec.branch.remote_update(
+            git_repo, remotes[remote_name]['git_name'])
     backports = get_backports(git_repo, remotes, branches, debug)
     c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
 
@@ -190,4 +186,5 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(args.git_repo, remotes)
     main(args.git_repo, remotes, args.debug)
diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index 10f3339..fb8785c 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -4,10 +4,12 @@
 # Public License, Version 3 or later. See http://www.gnu.org/copyleft/gpl.html
 # for details.
 
+import argparse
 import io
 import os
 import re
 import subprocess
+import sys
 import time
 import urllib.error
 import urllib.request
@@ -219,3 +221,43 @@ def get_remotes(mappings, mainline=None, stable=None):
     if stable:
         remotes['stable']['git_name'] = stable
     return remotes
+
+
+def remote_update(git_repo, remote_name):
+    subprocess.check_call(['git', 'remote', 'update', remote_name],
+                          cwd=git_repo)
+
+
+def remote_add(git_repo, remote_name, remote_url):
+    subprocess.check_call(['git', 'remote', 'add', remote_name, remote_url],
+                          cwd=git_repo)
+
+
+def check_git_repo(git_repo, remotes, create=False):
+    if create:
+        if os.path.isdir(git_repo):
+            msg = "directory %r already exists" % git_repo
+            raise argparse.ArgumentTypeError(msg)
+        else:
+            os.mkdir(git_repo)
+            subprocess.check_call(['git', 'init', '.'], cwd=git_repo)
+
+        for key in remotes.keys():
+            remote = remotes[key]  # __getitem__ will add git_name
+            remote_add(git_repo, remote['git_name'], remote['git_repo_url'])
+    else:
+        if not os.path.isdir(git_repo):
+            msg = "directory %r not present" % git_repo
+            raise argparse.ArgumentTypeError(msg)
+        if not os.path.isdir(os.path.join(git_repo, '.git')):
+            msg = "directory %r is not a git repository" % git_repo
+            raise argparse.ArgumentTypeError(msg)
+
+        current_remotes = subprocess.check_output(
+            ['git', 'remote', 'show'], cwd=git_repo).decode(
+                sys.stdout.encoding).strip().split('\n')
+        for key in remotes.keys():
+            remote = remotes[key]  # __getitem__ will add git_name
+            if remote['git_name'] not in current_remotes:
+                msg = "remote %r not in git repository" % remote['git_name']
+                raise argparse.ArgumentTypeError(msg)
diff --git a/scripts/prepare_remotes.py b/scripts/prepare_remotes.py
new file mode 100755
index 0000000..004519d
--- /dev/null
+++ b/scripts/prepare_remotes.py
@@ -0,0 +1,46 @@
+#!/usr/bin/python3
+
+# Copyright 2019 Toshiba corp.
+# Based on import_stable.py by Codethink Ltd.
+#
+# This script is distributed under the terms and conditions of the GNU General
+# Public License, Version 3 or later. See http://www.gnu.org/copyleft/gpl.html
+# for details.
+
+# Helper script that prepares the local git repository with the configured
+# remote branches
+
+import argparse
+
+import kernel_sec.branch
+
+
+def main(git_repo, remotes):
+    kernel_sec.branch.check_git_repo(git_repo, remotes, create=True)
+
+
+if __name__ == '__main__':
+    parser = argparse.ArgumentParser(
+        description=('Prepare local git repository with configured remotes.'))
+    parser.add_argument('--git-repo',
+                        dest='git_repo', default='../kernel',
+                        help=('local git repository location '
+                              '(default: ../kernel)'),
+                        metavar='DIRECTORY')
+    parser.add_argument('--remote-name',
+                        dest='remote_name', action='append', default=[],
+                        help='git remote name mappings, e.g. stable:korg-stable',
+                        metavar='NAME:OTHER-NAME')
+    parser.add_argument('--mainline-remote',
+                        dest='mainline_remote_name',
+                        help="git remote name to use instead of 'torvalds'",
+                        metavar='OTHER-NAME')
+    parser.add_argument('--stable-remote',
+                        dest='stable_remote_name',
+                        help="git remote name to use instead of 'stable'",
+                        metavar='OTHER-NAME')
+    args = parser.parse_args()
+    remotes = kernel_sec.branch.get_remotes(args.remote_name,
+                                            mainline=args.mainline_remote_name,
+                                            stable=args.stable_remote_name)
+    main(args.git_repo, remotes)
diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index 879c021..d2f1f22 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -100,5 +100,6 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(args.git_repo, remotes)
     main(args.git_repo, remotes,
          args.only_fixed_upstream, args.include_ignored, *args.branches)
diff --git a/scripts/webview.py b/scripts/webview.py
index a3a643b..e4b36f6 100755
--- a/scripts/webview.py
+++ b/scripts/webview.py
@@ -219,6 +219,7 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(git_repo, remotes)
 
     conf = {
         '/static/style.css': {
-- 
2.17.1
