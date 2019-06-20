From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 20 Jun 2019 15:13:09 +0900
Subject: [cip-dev] [cip-kernel-sec] report_affected: report cip branches
Message-ID: <20190620061309.1252-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Allow reporting on cip branches, instead of returning an
error like this one:

$ ./scripts/report_affected.py linux-4.4.y-cip
Traceback (most recent call last):
  File "./scripts/report_affected.py", line 105, in <module>
    args.only_fixed_upstream, args.include_ignored, *args.branches)
  File "./scripts/report_affected.py", line 33, in main
    branches.sort(key=kernel_sec.branch.get_sort_key)
  File "./scripts/kernel_sec/branch.py", line 146, in get_sort_key
    base_ver = branch['base_ver']
TypeError: 'NoneType' object is not subscriptable

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/kernel_sec/branch.py | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index fb8785c..828de13 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -22,6 +22,7 @@ from . import version
 
 
 _STABLE_BRANCH_RE = re.compile(r'^linux-([\d.]+)\.y$')
+_CIP_BRANCH_RE = re.compile(r'^linux-([\d.]+)\.y-cip$')
 
 
 def get_base_ver_stable_branch(base_ver):
@@ -34,9 +35,23 @@ def get_base_ver_stable_branch(base_ver):
         }
 
 
+def get_base_ver_cip_branch(base_ver):
+    branch_name = 'linux-%s.y-cip' % base_ver
+    return {
+        'short_name': branch_name,
+        'git_remote': 'cip',
+        'git_name': branch_name,
+        'base_ver': base_ver
+        }
+
+
 def get_stable_branch(branch_name):
-    match = _STABLE_BRANCH_RE.match(branch_name)
-    return match and get_base_ver_stable_branch(match.group(1))
+    if 'cip' in branch_name:
+        match = _CIP_BRANCH_RE.match(branch_name)
+        return match and get_base_ver_cip_branch(match.group(1))
+    else:
+        match = _STABLE_BRANCH_RE.match(branch_name)
+        return match and get_base_ver_stable_branch(match.group(1))
 
 
 def _extract_live_stable_branches(doc):
-- 
2.17.1
