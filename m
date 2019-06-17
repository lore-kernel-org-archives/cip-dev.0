From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon, 17 Jun 2019 11:20:38 +0900
Subject: [cip-dev] [cip-kernel-sec 1/2] remotes: refer to configuration files
Message-ID: <20190617022039.7197-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The Readme indicated some remote names (torvalds, stable) but
not all of them. Ask the user to check conf/remotes.yml instead.
I also added information on how to override or extend the
configuration file (through '~/.config/kernel-sec/remotes.yml')

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 README.md | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/README.md b/README.md
index a4f3d45..4c5808f 100644
--- a/README.md
+++ b/README.md
@@ -18,9 +18,10 @@ beneath that.  They require PyYAML and html5lib (packaged in Debian as
 python3-yaml and python3-html5lib).
 
 Many scripts require access to a kernel git repository.  By default
-this is assumed to be in `../kernel`, with remotes named `torvalds`
-and `stable` for the mainline and stable repositories.  These can
-be overridden by command-line options or by configuration.
+this is assumed to be in `../kernel`, with remotes configured in
+`conf/remotes.yml`, e.g. `torvalds`, `stable` and `cip` for the mainline,
+stable and cip repositories. These can be overridden by command-line options
+or configuration (`~/.config/kernel-sec/remotes.yml`).
 
 * `scripts/import_debian.py` - import information from Debian's
 `kernel_sec` project.  It includes all issues that Debian considers
-- 
2.17.1
