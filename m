From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 17 Jun 2019 14:21:27 +0900
Subject: [cip-dev] [cip-kernel-sec 2/2] git_repo: add a check for the
	git_repo directory
In-Reply-To: <20190617052127.9571-1-daniel.sangorrin@toshiba.co.jp>
References: <20190617052127.9571-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190617052127.9571-2-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Users are required to prepare a local git repository, by
default "../kernel", however there is no check at the
moment. Alternatively, we could also create a repository
for them (mkdir ../kernel; git init .) but that for
now let's just spit an error.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/import_stable.py     |  1 +
 scripts/kernel_sec/branch.py | 11 +++++++++++
 scripts/report_affected.py   |  1 +
 scripts/webview.py           |  1 +
 4 files changed, 14 insertions(+)

diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index 26e45a9..2d9b66b 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -179,6 +179,7 @@ if __name__ == '__main__':
                         dest='git_repo', default='../kernel',
                         help=('git repository from which to read commit logs '
                               '(default: ../kernel)'),
+                        type=kernel_sec.branch.check_git_repo,
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index 3ede64a..0ea5086 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -219,3 +219,14 @@ def get_remotes(mappings, mainline=None, stable=None):
     if stable:
         remotes['stable']['git_name'] = stable
     return remotes
+
+
+def check_git_repo(git_repo):
+    import argparse
+    if not os.path.isdir(git_repo):
+        msg = "directory %r not present" % git_repo
+        raise argparse.ArgumentTypeError(msg)
+    if not os.path.isdir(os.path.join(git_repo, '.git')):
+        msg = "directory %r is not a git repository" % git_repo
+        raise argparse.ArgumentTypeError(msg)
+    return git_repo
diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index fac0885..bcb8168 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -72,6 +72,7 @@ if __name__ == '__main__':
                         dest='git_repo', default='../kernel',
                         help=('git repository from which to read commit logs '
                               '(default: ../kernel)'),
+                        type=kernel_sec.branch.check_git_repo,
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
diff --git a/scripts/webview.py b/scripts/webview.py
index 9e16a0c..e334371 100755
--- a/scripts/webview.py
+++ b/scripts/webview.py
@@ -202,6 +202,7 @@ if __name__ == '__main__':
                         dest='git_repo', default='../kernel',
                         help=('git repository from which to read commit logs '
                               '(default: ../kernel)'),
+                        type=kernel_sec.branch.check_git_repo,
                         metavar='DIRECTORY')
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
-- 
2.17.1
