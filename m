From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 18 Jun 2019 11:40:24 +0900
Subject: [cip-dev] [cip-kernel-sec 2/3] branch: fix remotes mapping
In-Reply-To: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
References: <20190618024025.8274-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190618024025.8274-3-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Probably a copy&paste error that never got checked because
nobody is using the mapping functionality.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/kernel_sec/branch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index 6542415..fb8785c 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -214,7 +214,7 @@ def get_remotes(mappings, mainline=None, stable=None):
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
