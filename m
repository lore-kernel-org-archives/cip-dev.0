From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 25 Jun 2019 15:00:11 +0900
Subject: [cip-dev] [cip-kernel-sec] report_affected: add show-description
	option
Message-ID: <20190625060011.14152-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Rather than looking up each issue file, I would like
to have an overview of what each CVE ID means.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/report_affected.py | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index 0296649..d2459f4 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -18,8 +18,8 @@ import kernel_sec.issue
 import kernel_sec.version
 
 
-def main(git_repo, remotes,
-         only_fixed_upstream, include_ignored, *branch_names):
+def main(git_repo, remotes, only_fixed_upstream,
+         include_ignored, show_description, *branch_names):
     live_branches = kernel_sec.branch.get_live_branches()
     if branch_names:
         branches = []
@@ -106,9 +106,16 @@ def main(git_repo, remotes,
                         break
 
     for branch in branches:
-        print('%s:' % branch['full_name'],
-              *sorted(branch_issues.get(branch['full_name'], []),
-                      key=kernel_sec.issue.get_id_sort_key))
+        sorted_cve_ids = sorted(
+            branch_issues.get(branch['full_name'], []),
+            key=kernel_sec.issue.get_id_sort_key)
+        if show_description:
+            print('%s:' % branch['full_name'])
+            for cve_id in sorted_cve_ids:
+                print(cve_id, '=>',
+                      kernel_sec.issue.load(cve_id).get('description', 'None'))
+        else:
+            print('%s:' % branch['full_name'], *sorted_cve_ids)
 
 
 if __name__ == '__main__':
@@ -137,6 +144,9 @@ if __name__ == '__main__':
     parser.add_argument('--include-ignored',
                         action='store_true',
                         help='include issues that have been marked as ignored')
+    parser.add_argument('--show-description',
+                        action='store_true',
+                        help='show the issue description')
     parser.add_argument('branches',
                         nargs='*',
                         help=('specific branch[/tag] or stable tag to '
@@ -149,5 +159,5 @@ if __name__ == '__main__':
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
     kernel_sec.branch.check_git_repo(args.git_repo, remotes)
-    main(args.git_repo, remotes,
-         args.only_fixed_upstream, args.include_ignored, *args.branches)
+    main(args.git_repo, remotes, args.only_fixed_upstream,
+         args.include_ignored, args.show_description, *args.branches)
-- 
2.17.1
