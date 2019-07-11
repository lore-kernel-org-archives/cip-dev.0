From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 11 Jul 2019 13:44:25 +0900
Subject: [cip-dev] [cip-kernel-sec][RESEND v2 2/2] report_affected: add
	show-description option
In-Reply-To: <20190711044425.30128-1-daniel.sangorrin@toshiba.co.jp>
References: <20190711044425.30128-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190711044425.30128-3-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Rather than looking up each issue file, I would like
to have an overview of what each CVE ID means.

Example:
$ ./scripts/report_affected.py --show-description linux-4.4.y-cip

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/report_affected.py | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index 27c39ef..22a923b 100755
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
@@ -121,7 +121,13 @@ def main(git_repo, remotes,
         sorted_cve_ids = sorted(
             branch_issues.get(branch['full_name'], []),
             key=kernel_sec.issue.get_id_sort_key)
-        print('%s:' % branch['full_name'], *sorted_cve_ids)
+        if show_description:
+            print('%s:' % branch['full_name'])
+            for cve_id in sorted_cve_ids:
+                print(cve_id, '=>',
+                      kernel_sec.issue.load(cve_id).get('description', 'None'))
+        else:
+            print('%s:' % branch['full_name'], *sorted_cve_ids)
 
 
 if __name__ == '__main__':
@@ -150,6 +156,9 @@ if __name__ == '__main__':
     parser.add_argument('--include-ignored',
                         action='store_true',
                         help='include issues that have been marked as ignored')
+    parser.add_argument('--show-description',
+                        action='store_true',
+                        help='show the issue description')
     parser.add_argument('branches',
                         nargs='*',
                         help=('specific branch[:tag] or stable tag to '
@@ -162,5 +171,5 @@ if __name__ == '__main__':
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
     kernel_sec.branch.check_git_repo(args.git_repo, remotes)
-    main(args.git_repo, remotes,
-         args.only_fixed_upstream, args.include_ignored, *args.branches)
+    main(args.git_repo, remotes, args.only_fixed_upstream,
+         args.include_ignored, args.show_description, *args.branches)
-- 
2.17.1
