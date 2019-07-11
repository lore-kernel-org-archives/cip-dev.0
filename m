From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 11 Jul 2019 15:00:11 +0900
Subject: [cip-dev] [cip-kernel-sec] readme: add info about tag_regexp and
	show-description
Message-ID: <20190711060011.16784-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Probably this should be squashed into the corresponding
patches.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 README.md | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 576cc75..8164826 100644
--- a/README.md
+++ b/README.md
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
 
-- 
2.17.1
