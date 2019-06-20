From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 20 Jun 2019 14:51:41 +0900
Subject: [cip-dev] [cip-kernel-sec][PATCH v2 1/3] branch: fix remotes mapping
Message-ID: <20190620055143.341-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Probably a copy&paste error that never got checked because
nobody is using the mapping functionality.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/kernel_sec/branch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index 3ede64a..10f3339 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -212,7 +212,7 @@ def get_remotes(mappings, mainline=None, stable=None):
         _get_configured_remotes(
             os.path.expanduser('~/.config/kernel-sec/remotes.yml')))
     for mapping in mappings:
-        left, right = arg.split(':', 1)
+        left, right = mapping.split(':', 1)
         remotes[left]['git_name'] = right
     if mainline:
         remotes['torvalds']['git_name'] = mainline
-- 
2.17.1
