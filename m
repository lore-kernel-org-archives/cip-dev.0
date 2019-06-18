From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 18 Jun 2019 11:40:25 +0900
Subject: [cip-dev] [cip-kernel-sec 3/3] help:remote_name: use colon instead
	of equal
In-Reply-To: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
References: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190618024025.8274-4-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The example and implementation use a colon (:) to specify
remote mappings, but the command's help use the equal
sign (=).

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/import_stable.py   | 2 +-
 scripts/prepare_remotes.py | 2 +-
 scripts/report_affected.py | 2 +-
 scripts/webview.py         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index a2fa6b3..194219d 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -170,7 +170,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",
diff --git a/scripts/prepare_remotes.py b/scripts/prepare_remotes.py
index 8bdfb55..d7be4db 100755
--- a/scripts/prepare_remotes.py
+++ b/scripts/prepare_remotes.py
@@ -30,7 +30,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",
diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index a724cba..d2f1f22 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -76,7 +76,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",
diff --git a/scripts/webview.py b/scripts/webview.py
index b5709a3..e4b36f6 100755
--- a/scripts/webview.py
+++ b/scripts/webview.py
@@ -206,7 +206,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",
-- 
2.17.1
