From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 25 Jun 2019 12:26:36 +0900
Subject: [cip-dev] [cip-kernel-sec 6/6] pep8: fix pep8-related errors such
	as too long lines
In-Reply-To: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190625032636.10694-7-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

These were distracting when checking new code.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/import_stable.py     | 8 +++++---
 scripts/kernel_sec/branch.py | 4 ++--
 scripts/prepare_remotes.py   | 2 +-
 scripts/report_affected.py   | 2 +-
 scripts/webview.py           | 2 +-
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index 194219d..b4d8e0a 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -64,7 +64,8 @@ def get_backports(git_repo, remotes, branches, debug=False):
                     backports.setdefault(mainline_commit, {})[branch_name] \
                         = stable_commit
                 if line.strip() != '':
-                    commit_re = BACKPORT_COMMIT_BOTTOM_RE  # next line is not top
+                    # next line is not top
+                    commit_re = BACKPORT_COMMIT_BOTTOM_RE
 
     return backports
 
@@ -120,7 +121,8 @@ def add_backports(branches, c_b_map, issue_commits, all_backports,
                 if debug_context:
                     print('%s/%s: recording commits' %
                           (debug_context, branch_name))
-                issue_commits.setdefault(branch_name, []).extend(branch_commits)
+                issue_commits.setdefault(
+                    branch_name, []).extend(branch_commits)
                 changed = True
             else:
                 if debug_context:
@@ -169,7 +171,7 @@ if __name__ == '__main__':
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-                        help='git remote name mappings, e.g. stable:korg-stable',
+                        help='git remote name mappings, e.g. stable:mystable',
                         metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index ef88b54..9a7bc3a 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -62,8 +62,8 @@ def _extract_live_stable_branches(doc):
             if match:
                 version = match.group(1)
                 eol = match.group(2) is not None
-        if branch_type not in ['mainline', 'stable', 'longterm', 'linux-next'] \
-           or version is None:
+        if branch_type not in ['mainline', 'stable', 'longterm',
+                               'linux-next'] or version is None:
             raise ValueError('failed to parse releases row text %r' % row_text)
 
         # Filter out irrelevant branches
diff --git a/scripts/prepare_remotes.py b/scripts/prepare_remotes.py
index 59310fc..ab0db24 100755
--- a/scripts/prepare_remotes.py
+++ b/scripts/prepare_remotes.py
@@ -45,7 +45,7 @@ if __name__ == '__main__':
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-                        help='git remote name mappings, e.g. stable:korg-stable',
+                        help='git remote name mappings, e.g. stable:mystable',
                         metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index 32e9345..0296649 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -121,7 +121,7 @@ if __name__ == '__main__':
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-                        help='git remote name mappings, e.g. stable:korg-stable',
+                        help='git remote name mappings, e.g. stable:mystable',
                         metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
diff --git a/scripts/webview.py b/scripts/webview.py
index 52a7b15..cf54948 100755
--- a/scripts/webview.py
+++ b/scripts/webview.py
@@ -205,7 +205,7 @@ if __name__ == '__main__':
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-                        help='git remote name mappings, e.g. stable:korg-stable',
+                        help='git remote name mappings, e.g. stable:mystable',
                         metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
-- 
2.17.1
