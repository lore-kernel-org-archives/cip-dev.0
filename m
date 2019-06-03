From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Mon,  3 Jun 2019 16:25:31 +0900
Subject: [cip-dev] [isar-cip-core] kernel: add yml file for 4.19 kernels
Message-ID: <20190603072531.28135-1-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Currently 4.4 is used by default, as specified in
conf/distro/cip-core.conf. I guess you can override
the PREFERRED_VERSION_linux variables on the board's yaml
but having this as build option is convenient.

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 README.md    |  2 +-
 opt-4.19.yml | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 opt-4.19.yml

diff --git a/README.md b/README.md
index dfd9ef1..f90c649 100644
--- a/README.md
+++ b/README.md
@@ -27,7 +27,7 @@ This image can be run using `start-qemu.sh x86`.
 
 The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In
 order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` to
-the above.
+the above. Append ':opt-4.19.yml' to use the kernel version 4.19.
 
 Physical targets will generate ready-to-boot images under
 `build/tmp/deploy/images/`. To flash, e.g., the BeagleBone Black image to an SD
diff --git a/opt-4.19.yml b/opt-4.19.yml
new file mode 100644
index 0000000..94306b4
--- /dev/null
+++ b/opt-4.19.yml
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba corp., 2019
+#
+# Authors:
+#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  kernel-version: |
+    PREFERRED_VERSION_linux-cip = "4.19.%"
+    PREFERRED_VERSION_linux-cip-rt = "4.19.%"
-- 
2.17.1
