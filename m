From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 25 Jun 2019 12:26:34 +0900
Subject: [cip-dev] [cip-kernel-sec 4/6] report_affected: check user supplied
	branch names
In-Reply-To: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
References: <20190625032636.10694-1-daniel.sangorrin@toshiba.co.jp>
Message-ID: <20190625032636.10694-5-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

This makes sure that we return when the user supplied
branch names are not within the configured branches.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 scripts/report_affected.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/report_affected.py b/scripts/report_affected.py
index bd22e29..7557dc8 100755
--- a/scripts/report_affected.py
+++ b/scripts/report_affected.py
@@ -27,6 +27,9 @@ def main(git_repo, remotes,
                     name = 'linux-%s.y' % name
                 if branch['short_name'] == name:
                     branches.append(branch)
+        if not branches:
+            msg = "supplied branches didn't match any known branch"
+            raise argparse.ArgumentError(None, msg)
     else:
         branches = live_branches
         if only_fixed_upstream:
-- 
2.17.1
