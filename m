From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 25 Jun 2019 12:26:35 +0900
Subject: [cip-dev] [cip-kernel-sec 5/6] report_affected: add support for
	reporting on tags
In-Reply-To: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190625032636.10694-6-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Reporting on tags is useful for product engineers that
have shipped a kernel with a specific tag and need to know
which issues affect their product after some time.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/report_affected.py | 60 ++++++++++++++++++++++++++++++++------
 1 file changed, 51 insertions(+), 9 deletions(-)

diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index 7557dc8..32e9345 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -9,7 +9,9 @@
 # Report issues affecting each stable branch.
 
 import argparse
+import copy
 import subprocess
+import re
 
 import kernel_sec.branch
 import kernel_sec.issue
@@ -23,10 +25,26 @@ def main(git_repo, remotes,
         branches = []
         for branch in live_branches:
             for name in branch_names:
+                # there could be multiple tags for the same branch
+                branch_copy = copy.deepcopy(branch)
+                if name[0] == 'v':
+                    # a stable tag, e.g. v4.4.92-cip11
+                    branch_copy['tag'] = name
+                    match = re.match(r'^v(\d+\.\d+).*', name)
+                    if not match:
+                        raise ValueError('failed to parse tag %r' % name)
+                    if 'cip' in name:
+                        name = 'linux-%s.y-cip' % match.group(1)
+                    else:
+                        name = 'linux-%s.y' % match.group(1)
+                if '/' in name:
+                    # a possibly custom tag, e.g. product-v1
+                    branch_copy['tag'] = name.split('/')[1]
+                    name = name.split('/')[0]
                 if name[0].isdigit():
                     name = 'linux-%s.y' % name
-                if branch['short_name'] == name:
-                    branches.append(branch)
+                if branch_copy['short_name'] == name:
+                    branches.append(branch_copy)
         if not branches:
             msg = "supplied branches didn't match any known branch"
             raise argparse.ArgumentError(None, msg)
@@ -40,6 +58,18 @@ def main(git_repo, remotes,
 
     c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
 
+    # cache tag commits and set full_name to show the tag
+    tag_commits = {}
+    for branch in branches:
+        if 'tag' in branch:
+            start = 'v' + branch['base_ver']
+            end = branch['tag']
+            for commit in kernel_sec.branch._get_commits(git_repo, end, start):
+                tag_commits.setdefault(end, []).append(commit)
+            branch['full_name'] = '/'.join([branch['short_name'], end])
+        else:
+            branch['full_name'] = branch['short_name']
+
     branch_issues = {}
     issues = set(kernel_sec.issue.get_list())
 
@@ -60,14 +90,24 @@ def main(git_repo, remotes,
             if not include_ignored and ignore.get(branch_name):
                 continue
 
+            # Check if the branch is affected. If not and the issue was fixed
+            # on that branch, then make sure the tag contains that fix
             if kernel_sec.issue.affects_branch(
                     issue, branch, c_b_map.is_commit_in_branch):
-                branch_issues.setdefault(branch_name, []).append(cve_id)
+                branch_issues.setdefault(
+                    branch['full_name'], []).append(cve_id)
+            elif 'tag' in branch and fixed:
+                if fixed.get(branch_name, 'never') == 'never':
+                    continue
+                for commit in fixed[branch_name]:
+                    if commit not in tag_commits[branch['tag']]:
+                        branch_issues.setdefault(
+                            branch['full_name'], []).append(cve_id)
+                        break
 
     for branch in branches:
-        branch_name = branch['short_name']
-        print('%s:' % branch_name,
-              *sorted(branch_issues.get(branch_name, []),
+        print('%s:' % branch['full_name'],
+              *sorted(branch_issues.get(branch['full_name'], []),
                       key=kernel_sec.issue.get_id_sort_key))
 
 
@@ -99,9 +139,11 @@ if __name__ == '__main__':
                         help='include issues that have been marked as ignored')
     parser.add_argument('branches',
                         nargs='*',
-                        help=('specific branch to report on '
-                              '(default: all active branches)'),
-                        metavar='BRANCH')
+                        help=('specific branch[/tag] or stable tag to '
+                              'report on (default: all active branches). '
+                              'e.g. linux-4.14.y linux-4.4.y/v4.4.107 '
+                              'v4.4.181-cip33 linux-4.19.y-cip/myproduct-v33'),
+                        metavar='[BRANCH[/TAG]|TAG]')
     args = parser.parse_args()
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
-- 
2.17.1
