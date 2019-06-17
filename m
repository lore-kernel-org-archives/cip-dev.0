From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 17 Jun 2019 11:52:06 +0900
Subject: [cip-dev] [cip-kernel-sec] import_stable: update torvalds remote as
	well
Message-ID: <20190617025206.7753-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Otherwise, the script will not find all the expected tags
and fail with a message like:

fatal: ambiguous argument 'v5.1..torvalds/master':
unknown revision or path not in the working tree

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/import_stable.py | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/import_stable.py b/scripts/import_stable.py
index dff3954..b3261cf 100755
--- a/scripts/import_stable.py
+++ b/scripts/import_stable.py
@@ -137,8 +137,7 @@ def add_backports(branches, c_b_map, issue_commits, all_backports,
 
 def main(git_repo, remotes, debug=False):
     branches = kernel_sec.branch.get_live_branches()
-    remote_names = set(branch['git_remote'] for branch in branches
-                       if branch['short_name'] != 'mainline')
+    remote_names = set(branch['git_remote'] for branch in branches)
 
     for remote_name in remote_names:
         update(git_repo, remotes[remote_name]['git_name'])
-- 
2.17.1
