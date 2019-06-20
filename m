From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 20 Jun 2019 14:51:42 +0900
Subject: [cip-dev] [cip-kernel-sec][PATCH v2 2/3] help:remote_name: use
	colon instead of equal
In-Reply-To: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
References: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190620055143.341-2-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The example and implementation use a colon (:) to specify
remote mappings, but the command's help use the equal
sign (=).

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/import_stable.py   | 2 +-
 scripts/report_affected.py | 2 +-
 scripts/webview.py         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index b3261cf..2c88b07 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -174,7 +174,7 @@ if __name__ == '__main__':
     parser.add_argument('--remote-name',
                         dest='remote_name', action='append', default=[],
                         help='git remote name mappings, e.g. stable:korg-stable',
-                        metavar='NAME=OTHER-NAME')
+                        metavar='NAME:OTHER-NAME')
     parser.add_argument('--mainline-remote',
                         dest='mainline_remote_name',
                         help="git remote name to use instead of 'torvalds'",
diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index fac0885..879c021 100755
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
index 9e16a0c..a3a643b 100755
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
