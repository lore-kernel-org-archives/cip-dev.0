From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 10 Jul 2019 15:01:54 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 4
 commits: check_git_repo: add checks to the local repository
Message-ID: <5d25fde29ada0_44883fe98923078c19231fb@sidekiq-asap-01-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
6b530a7c by Daniel Sangorrin at 2019-07-10T14:43:03Z
check_git_repo: add checks to the local repository

Add checks to make sure that the local repository exists
and has the configured remotes in place.

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
c3495333 by Daniel Sangorrin at 2019-07-10T14:43:03Z
prepare_remotes: helper script to prepare local repo

Helper script that prepares the local git repository
with the configured remote branches. Expert developers
and kernel maintainers will probably have their own
worktrees but for new users or a quickstart, this
script should be helpful.

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
3eaa6089 by Daniel Sangorrin at 2019-07-10T14:43:03Z
report_affected: fix code when branches are specified

The previous code could not handle branches with names
other than stable branch names. For example, passing
&quot;linux-4.4.y-cip&quot; as a branch would return an error.

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
ddf0f91c by Daniel Sangorrin at 2019-07-10T14:43:03Z
pep8: fix pep8-related errors such as too long lines

These were distracting when checking new code.

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -


7 changed files:

- README.md
- conf/remotes.yml
- scripts/import_stable.py
- scripts/kernel_sec/branch.py
- + scripts/prepare_remotes.py
- scripts/report_affected.py
- scripts/webview.py


Changes:

=====================================
README.md
=====================================
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
 


=====================================
conf/remotes.yml
=====================================
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


=====================================
scripts/import_stable.py
=====================================
@@ -31,11 +31,6 @@ BACKPORT_COMMIT_BOTTOM_RE = re.compile(
     .format(**RE_USE))
 
 
-def update(git_repo, remote_name):
-    subprocess.check_call(['git', 'remote', 'update', remote_name],
-                          cwd=git_repo)
-
-
 def get_backports(git_repo, remotes, branches, debug=False):
     backports = {}
 
@@ -69,7 +64,8 @@ def get_backports(git_repo, remotes, branches, debug=False):
                     backports.setdefault(mainline_commit, {})[branch_name] \
                         = stable_commit
                 if line.strip() != '':
-                    commit_re = BACKPORT_COMMIT_BOTTOM_RE  # next line is not top
+                    # next line is not top
+                    commit_re = BACKPORT_COMMIT_BOTTOM_RE
 
     return backports
 
@@ -125,7 +121,8 @@ def add_backports(branches, c_b_map, issue_commits, all_backports,
                 if debug_context:
                     print('%s/%s: recording commits' %
                           (debug_context, branch_name))
-                issue_commits.setdefault(branch_name, []).extend(branch_commits)
+                issue_commits.setdefault(
+                    branch_name, []).extend(branch_commits)
                 changed = True
             else:
                 if debug_context:
@@ -140,7 +137,8 @@ def main(git_repo, remotes, debug=False):
     remote_names = set(branch['git_remote'] for branch in branches)
 
     for remote_name in remote_names:
-        update(git_repo, remotes[remote_name]['git_name'])
+        kernel_sec.branch.remote_update(
+            git_repo, remotes[remote_name]['git_name'])
     backports = get_backports(git_repo, remotes, branches, debug)
     c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
 
@@ -173,7 +171,7 @@ if __name__ == '__main__':
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-                        help='git remote name mappings, e.g. stable:korg-stable',
+                        help='git remote name mappings, e.g. stable:mystable',
                         metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
@@ -190,4 +188,5 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(args.git_repo, remotes)
     main(args.git_repo, remotes, args.debug)


=====================================
scripts/kernel_sec/branch.py
=====================================
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
@@ -19,9 +21,6 @@ import yaml
 from . import version
 
 
-_STABLE_BRANCH_RE = re.compile(r'^linux-([\d.]+)\.y$')
-
-
 def get_base_ver_stable_branch(base_ver):
     branch_name = 'linux-%s.y' % base_ver
     return {
@@ -32,11 +31,6 @@ def get_base_ver_stable_branch(base_ver):
         }
 
 
-def get_stable_branch(branch_name):
-    match = _STABLE_BRANCH_RE.match(branch_name)
-    return match and get_base_ver_stable_branch(match.group(1))
-
-
 def _extract_live_stable_branches(doc):
     xhtml_ns = 'http://www.w3.org/1999/xhtml'
     ns = {'html': xhtml_ns}
@@ -68,8 +62,8 @@ def _extract_live_stable_branches(doc):
             if match:
                 version = match.group(1)
                 eol = match.group(2) is not None
-        if branch_type not in ['mainline', 'stable', 'longterm', 'linux-next'] \
-           or version is None:
+        if branch_type not in ['mainline', 'stable', 'longterm',
+                               'linux-next'] or version is None:
             raise ValueError('failed to parse releases row text %r' % row_text)
 
         # Filter out irrelevant branches
@@ -219,3 +213,32 @@ def get_remotes(mappings, mainline=None, stable=None):
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


=====================================
scripts/prepare_remotes.py
=====================================
@@ -0,0 +1,62 @@
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
+import os
+import subprocess
+
+import kernel_sec.branch
+
+
+def main(git_repo, remotes):
+    if os.path.isdir(git_repo):
+        msg = "directory %r already exists" % git_repo
+        raise argparse.ArgumentError(None, msg)
+    else:
+        os.mkdir(git_repo)
+        subprocess.check_call(['git', 'init', '.'], cwd=git_repo)
+
+    for key in remotes.keys():
+        remote = remotes[key]  # __getitem__ will add git_name
+        kernel_sec.branch.remote_add(
+            git_repo, remote['git_name'], remote['git_repo_url'])
+        kernel_sec.branch.remote_update(git_repo, remote['git_name'])
+
+    # self-check
+    kernel_sec.branch.check_git_repo(git_repo, remotes)
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
+                        help='git remote name mappings, e.g. stable:mystable',
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


=====================================
scripts/report_affected.py
=====================================
@@ -18,14 +18,25 @@ import kernel_sec.version
 
 def main(git_repo, remotes,
          only_fixed_upstream, include_ignored, *branch_names):
+    live_branches = kernel_sec.branch.get_live_branches()
     if branch_names:
-        # Support stable release strings as shorthand for stable branches
-        branches = [kernel_sec.branch.get_base_ver_stable_branch(name)
-                    if name[0].isdigit()
-                    else kernel_sec.branch.get_stable_branch(name)
-                    for name in branch_names]
+        branches = []
+        for branch_name in branch_names:
+            if branch_name[0].isdigit():
+                # 4.4 is mapped to linux-4.4.y
+                name = 'linux-%s.y' % branch_name
+            else:
+                name = branch_name
+
+            for branch in live_branches:
+                if branch['short_name'] == name:
+                    branches.append(branch)
+                    break
+            else:
+                msg = "Branch %s could not be found" % branch_name
+                raise argparse.ArgumentError(None, msg)
     else:
-        branches = kernel_sec.branch.get_live_branches()
+        branches = live_branches
         if only_fixed_upstream:
             branches = [branch for branch in branches
                         if branch['short_name'] != 'mainline']
@@ -75,7 +86,7 @@ if __name__ == '__main__':
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-                        help='git remote name mappings, e.g. stable:korg-stable',
+                        help='git remote name mappings, e.g. stable:mystable',
                         metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
@@ -100,5 +111,6 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(args.git_repo, remotes)
     main(args.git_repo, remotes,
          args.only_fixed_upstream, args.include_ignored, *args.branches)


=====================================
scripts/webview.py
=====================================
@@ -205,7 +205,7 @@ if __name__ == '__main__':
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-                        help='git remote name mappings, e.g. stable:korg-stable',
+                        help='git remote name mappings, e.g. stable:mystable',
                         metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
@@ -219,6 +219,7 @@ if __name__ == '__main__':
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
+    kernel_sec.branch.check_git_repo(args.git_repo, remotes)
 
     conf = {
         '/static/style.css': {



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/c96dfc60475bb62048934a491a2eda588dbdfe1f...ddf0f91c8b596022cbb40fc7b75f978420b96451

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/c96dfc60475bb62048934a491a2eda588dbdfe1f...ddf0f91c8b596022cbb40fc7b75f978420b96451
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190710/84218978/attachment-0001.html>
