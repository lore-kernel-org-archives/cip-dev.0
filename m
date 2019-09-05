From: chris.paterson2@renesas.com (Chris Paterson)
Date: Thu,  5 Sep 2019 17:22:53 +0100
Subject: [cip-dev] [PATCH linux-4.19.y-cip-rt] gitlab-ci: Start testing the
	r8a774a1-hihope-rzg2m-ex device
In-Reply-To: <20190905162254.24424-1-chris.paterson2@renesas.com>
References: <20190905162254.24424-1-chris.paterson2@renesas.com>
Message-ID: <20190905162254.24424-3-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Cc: Pavel Machek <pavel@denx.de>
---

Please apply this patch either with or before the "Add HopeRun RZ/G2[M]
main/sub boards" series:
https://patchwork.kernel.org/project/cip-dev/list/?series=167529

This will mean that the RZ/G2M board is tested in the LAVA lab as the code
for it is added.

It is safe to add this patch before the above series if that's easier.

 .gitlab-ci.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 78748f84ada5..e2e1f7dcf203 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -109,8 +109,8 @@ arm64_renesas_defconfig:
     BUILD_ARCH: arm64
     CONFIG: renesas_defconfig
     CONFIG_LOC: cip-kernel-config
-    DEVICES: r8a774c0-ek874
-    DTBS: r8a774c0-ek874.dtb
+    DEVICES: r8a774c0-ek874 r8a774a1-hihope-rzg2m-ex
+    DTBS: r8a774c0-ek874.dtb r8a774a1-hihope-rzg2m-ex.dtb
   script:
     - /opt/build_kernel.sh
   artifacts:
@@ -241,8 +241,8 @@ arm64_defconfig:
     BUILD_ARCH: arm64
     CONFIG: defconfig
     CONFIG_LOC: intree
-    DEVICES: r8a774c0-ek874
-    DTBS: r8a774c0-ek874.dtb
+    DEVICES: r8a774c0-ek874 r8a774a1-hihope-rzg2m-ex
+    DTBS: r8a774c0-ek874.dtb r8a774a1-hihope-rzg2m-ex.dtb
   script:
     - /opt/build_kernel.sh
   artifacts:
-- 
2.17.1
