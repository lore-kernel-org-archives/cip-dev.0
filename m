From: gitlab@mg.gitlab.com (Ben Hutchings)
Date: Wed, 17 Jul 2019 18:01:31 +0000
Subject: [cip-dev] [Git][cip-project/cip-kernel/cip-kernel-sec][master] 2
 commits: report_affected: add support for reporting on tags
Message-ID: <5d2f627ba019e_31173fe27c320840268599@sidekiq-asap-02-sv-gprd.mail>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org



Ben Hutchings pushed to branch master at cip-project / cip-kernel / cip-kernel-sec


Commits:
40329eb5 by Daniel Sangorrin at 2019-07-17T17:30:41Z
report_affected: add support for reporting on tags

Reporting on tags is useful for product engineers that
have shipped a kernel with a specific tag and need to know
which issues affect their product after some time.

Examples:
$ ./scripts/report_affected.py v4.4 v4.4.107 v4.4.181-cip33
$ cd ../kernel
$ git tag myproduct-v1 0f13d9b4d0efa9e87381717c113df57718bc92d6
$ cd ../cip-kernel-sec
$ ./scripts/report_affected.py linux-4.19.y-cip:myproduct-v1 v4.19.50-cip3

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -
d202dc5b by Daniel Sangorrin at 2019-07-17T17:30:41Z
report_affected: add show-description option

Rather than looking up each issue file, I would like
to have an overview of what each CVE ID means.

Example:
$ ./scripts/report_affected.py --show-description linux-4.4.y-cip

Signed-off-by: Daniel Sangorrin &lt;daniel.sangorrin at toshiba.co.jp&gt;
Signed-off-by: Ben Hutchings &lt;ben.hutchings at codethink.co.uk&gt;

- - - - -


4 changed files:

- README.md
- conf/branches.yml
- scripts/kernel_sec/branch.py
- scripts/report_affected.py


Changes:

=====================================
README.md
=====================================
@@ -41,7 +41,8 @@ current or previous year or that are already tracked here.
 stable and other configured branches, by reading the git commit logs.
 
 * `scripts/report_affected.py` - report which issues affect the
-specified branches, or all active branches.
+specified branches, or all active branches. You can use --show-description
+to obtain a short description for each CVE ID.
 
 * `scripts/validate.py` - validate all issue files against the
 schema.
@@ -72,6 +73,7 @@ keys:
 * `base_ver`: Stable version that the branch is based on, e.g.
   "4.4". This needs to be quoted so that it's a string not a
   number.
+* `tag_regexp`: A regular expression that matches tags on a branch.
 
 ### Remotes
 


=====================================
conf/branches.yml
=====================================
@@ -2,7 +2,9 @@
   base_ver: "4.4"
   git_remote: cip
   git_name: linux-4.4.y-cip
+  tag_regexp: '^v4\.4\.\d+-cip\d+$'
 - short_name: linux-4.19.y-cip
   base_ver: "4.19"
   git_remote: cip
   git_name: linux-4.19.y-cip
+  tag_regexp: '^v4\.19\.\d+-cip\d+$'


=====================================
scripts/kernel_sec/branch.py
=====================================
@@ -23,11 +23,13 @@ from . import version
 
 def get_base_ver_stable_branch(base_ver):
     branch_name = 'linux-%s.y' % base_ver
+    esc_base_ver = re.escape(base_ver)
     return {
         'short_name': branch_name,
         'git_remote': 'stable',
         'git_name': branch_name,
-        'base_ver': base_ver
+        'base_ver': base_ver,
+        'tag_regexp' : r'(^v%s$|^v%s\.\d+$)' % (esc_base_ver, esc_base_ver)
         }
 
 
@@ -141,7 +143,7 @@ def get_sort_key(branch):
     return version.get_sort_key(base_ver)
 
 
-def _get_commits(git_repo, end, start=None):
+def iter_rev_list(git_repo, end, start=None):
     if start:
         list_expr = '%s..%s' % (start, end)
     else:
@@ -170,7 +172,7 @@ class CommitBranchMap:
                                  branch['git_name'])
             else:
                 end = 'v' + branch['base_ver']
-            for commit in _get_commits(git_repo, end, start):
+            for commit in iter_rev_list(git_repo, end, start):
                 self._commit_sort_key[commit] \
                     = self._branch_sort_key[branch_name]
             start = end


=====================================
scripts/report_affected.py
=====================================
@@ -9,28 +9,53 @@
 # Report issues affecting each stable branch.
 
 import argparse
+import copy
 import subprocess
+import re
 
 import kernel_sec.branch
 import kernel_sec.issue
 import kernel_sec.version
 
 
-def main(git_repo, remotes,
-         only_fixed_upstream, include_ignored, *branch_names):
+def main(git_repo, remotes, only_fixed_upstream,
+         include_ignored, show_description, *branch_names):
     live_branches = kernel_sec.branch.get_live_branches()
     if branch_names:
         branches = []
         for branch_name in branch_names:
+            tag = None
             if branch_name[0].isdigit():
                 # 4.4 is mapped to linux-4.4.y
                 name = 'linux-%s.y' % branch_name
+            elif branch_name[0] == 'v':
+                # an official tag, e.g. v4.4.92-cip11
+                # infer branch from tag (regexp's must be specific)
+                for branch in live_branches:
+                    if 'tag_regexp' not in branch:
+                        # no tag_regexp defined, or mainline
+                        continue
+
+                    # predefined in branches.yml or a stable branch
+                    if re.match(branch['tag_regexp'], branch_name):
+                        tag = branch_name
+                        name = branch['short_name']
+                        break
+                else:
+                    raise ValueError('Failed to match tag %r' % branch_name)
+            elif ':' in branch_name:
+                # a possibly custom tag, e.g. linux-4.19.y-cip:myproduct-v1
+                name, tag = branch_name.split(':', 1)
             else:
                 name = branch_name
 
             for branch in live_branches:
                 if branch['short_name'] == name:
-                    branches.append(branch)
+                    # there could be multiple tags for the same branch
+                    branch_copy = copy.deepcopy(branch)
+                    if tag:
+                        branch_copy['tag'] = tag
+                    branches.append(branch_copy)
                     break
             else:
                 msg = "Branch %s could not be found" % branch_name
@@ -45,6 +70,18 @@ def main(git_repo, remotes,
 
     c_b_map = kernel_sec.branch.CommitBranchMap(git_repo, remotes, branches)
 
+    # cache tag commits and set full_name to show the tag
+    tag_commits = {}
+    for branch in branches:
+        if 'tag' in branch:
+            start = 'v' + branch['base_ver']
+            end = branch['tag']
+            tag_commits[end] = set(
+                kernel_sec.branch.iter_rev_list(git_repo, end, start))
+            branch['full_name'] = ':'.join([branch['short_name'], end])
+        else:
+            branch['full_name'] = branch['short_name']
+
     branch_issues = {}
     issues = set(kernel_sec.issue.get_list())
 
@@ -65,15 +102,32 @@ def main(git_repo, remotes,
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
@@ -102,15 +156,20 @@ if __name__ == '__main__':
     parser.add_argument('--include-ignored',
                         action='store_true',
                         help='include issues that have been marked as ignored')
+    parser.add_argument('--show-description',
+                        action='store_true',
+                        help='show the issue description')
     parser.add_argument('branches',
                         nargs='*',
-                        help=('specific branch to report on '
-                              '(default: all active branches)'),
-                        metavar='BRANCH')
+                        help=('specific branch[:tag] or stable tag to '
+                              'report on (default: all active branches). '
+                              'e.g. linux-4.14.y linux-4.4.y:v4.4.107 '
+                              'v4.4.181-cip33 linux-4.19.y-cip:myproduct-v33'),
+                        metavar='[BRANCH[:TAG]|TAG]')
     args = parser.parse_args()
     remotes = kernel_sec.branch.get_remotes(args.remote_name,
                                             mainline=args.mainline_remote_name,
                                             stable=args.stable_remote_name)
     kernel_sec.branch.check_git_repo(args.git_repo, remotes)
-    main(args.git_repo, remotes,
-         args.only_fixed_upstream, args.include_ignored, *args.branches)
+    main(args.git_repo, remotes, args.only_fixed_upstream,
+         args.include_ignored, args.show_description, *args.branches)



View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/ddf0f91c8b596022cbb40fc7b75f978420b96451...d202dc5b8e2a3b2e9a8c196891b8667d964a662f

-- 
View it on GitLab: https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec/compare/ddf0f91c8b596022cbb40fc7b75f978420b96451...d202dc5b8e2a3b2e9a8c196891b8667d964a662f
You're receiving this email because of your account on gitlab.com.


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190717/a195abe2/attachment-0001.html>
