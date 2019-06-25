From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 25 Jun 2019 12:26:33 +0900
Subject: [cip-dev] [cip-kernel-sec 3/6] report_affected: fix code when
	branches are specified
In-Reply-To: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190625032636.10694-4-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The previous code could not handle branches with names
other than stable branch names. For example, passing
"linux-4.4.y-cip" as a branch would return an error.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/kernel_sec/branch.py |  8 --------
 scripts/report_affected.py   | 15 +++++++++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index 0023497..ef88b54 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -21,9 +21,6 @@ import yaml
 from . import version
 
 
-_STABLE_BRANCH_RE = re.compile(r'^linux-([\d.]+)\.y$')
-
-
 def get_base_ver_stable_branch(base_ver):
     branch_name = 'linux-%s.y' % base_ver
     return {
@@ -34,11 +31,6 @@ def get_base_ver_stable_branch(base_ver):
         }
 
 
-def get_stable_branch(branch_name):
-    match = _STABLE_BRANCH_RE.match(branch_name)
-    return match and get_base_ver_stable_branch(match.group(1))
-
-
 def _extract_live_stable_branches(doc):
     xhtml_ns = 'http://www.w3.org/1999/xhtml'
     ns = {'html': xhtml_ns}
diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index d2f1f22..bd22e29 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -18,14 +18,17 @@ import kernel_sec.version
 
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
+        for branch in live_branches:
+            for name in branch_names:
+                if name[0].isdigit():
+                    name = 'linux-%s.y' % name
+                if branch['short_name'] == name:
+                    branches.append(branch)
     else:
-        branches = kernel_sec.branch.get_live_branches()
+        branches = live_branches
         if only_fixed_upstream:
             branches = [branch for branch in branches
                         if branch['short_name'] != 'mainline']
-- 
2.17.1
