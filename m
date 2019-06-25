From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 25 Jun 2019 12:26:31 +0900
Subject: [cip-dev] [cip-kernel-sec 1/6] check_git_repo: add checks to the
	local repository
In-Reply-To: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190625032636.10694-2-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Add checks to make sure that the local repository exists
and has the configured remotes in place.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/import_stable.py     |  1 +
 scripts/kernel_sec/branch.py | 21 +++++++++++++++++++++
 scripts/report_affected.py   |  1 +
 scripts/webview.py           |  1 +
 4 files changed, 24 insertions(+)

diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index 2c88b07..26fcc2f 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -190,4 +190,5 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(args.git_repo, remotes)
     main(args.git_repo, remotes, args.debug)
diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index 10f3339..a138b96 100644
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
@@ -219,3 +221,22 @@ def get_remotes(mappings, mainline=None, stable=None):
     if stable:
         remotes['stable']['git_name'] = stable
     return remotes
+
+
+def check_git_repo(git_repo, remotes):
+    if not os.path.isdir(git_repo):
+        msg = "directory %r not present" % git_repo
+        raise argparse.ArgumentError(None, msg)
+    # .git could be a regular file (worktrees) or a directory
+    if not os.path.exists(os.path.join(git_repo, '.git')):
+        msg = "directory %r is not a git repository" % git_repo
+        raise argparse.ArgumentError(None, msg)
+
+    current_remotes = subprocess.check_output(
+        ['git', 'remote', 'show'], cwd=git_repo).decode(
+            sys.stdout.encoding).strip().split('\n')
+    for key in remotes.keys():
+        remote = remotes[key]  # __getitem__ will add git_name
+        if remote['git_name'] not in current_remotes:
+            msg = "remote %r not in git repository" % remote['git_name']
+            raise argparse.ArgumentError(None, msg)
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
index a3a643b..52a7b15 100755
--- a/scripts/webview.py
+++ b/scripts/webview.py
@@ -219,6 +219,7 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(args.git_repo, remotes)
 
     conf = {
         '/static/style.css': {
-- 
2.17.1
