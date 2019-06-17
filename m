From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 17 Jun 2019 11:20:39 +0900
Subject: [cip-dev] [cip-kernel-sec 2/2] remotes: call _get_configured_remotes
In-Reply-To: <20190617022039.7197-1-daniel.sangorrin@toshiba.co.jp>
References: <20190617022039.7197-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190617022039.7197-2-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This is probably a copy&paste mistake that had no effect
because the contents of _get_configured_remotes and
_get_configured_branches is the same.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/kernel_sec/branch.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kernel_sec/branch.py b/scripts/kernel_sec/branch.py
index ae1ca2c..3ede64a 100644
--- a/scripts/kernel_sec/branch.py
+++ b/scripts/kernel_sec/branch.py
@@ -209,7 +209,7 @@ def get_remotes(mappings, mainline=None, stable=None):
     remotes = RemoteMap()
     remotes.update(_get_configured_remotes('conf/remotes.yml'))
     remotes.update(
-        _get_configured_branches(
+        _get_configured_remotes(
             os.path.expanduser('~/.config/kernel-sec/remotes.yml')))
     for mapping in mappings:
         left, right = arg.split(':', 1)
-- 
2.17.1
