From: chris.paterson2@renesas.com (Chris Paterson)
Date: Wed, 18 Sep 2019 16:43:37 +0100
Subject: [cip-dev] [PATCH linux-4.4.y-cip 2/2] gitlab-ci: Run tests on
	RZ/G1C iwg23s platform
In-Reply-To: <20190918154337.8305-1-chris.paterson2@renesas.com>
References: <20190918154337.8305-1-chris.paterson2@renesas.com>
Message-ID: <20190918154337.8305-2-chris.paterson2@renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

LAVA device-type r8a77470-iwg23s-sbc.

Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
---
 .gitlab-ci.yml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3a927f07cb3f..e33099ea6594 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -44,8 +44,8 @@ arm_renesas_shmobile_defconfig:
     BUILD_ARCH: arm
     CONFIG: renesas_shmobile_defconfig
     CONFIG_LOC: cip-kernel-config
-    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
-    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
+    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm r8a77470-iwg23s-sbc
+    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb r8a77470-iwg23s-sbc.dtb
   script:
     - /opt/build_kernel.sh
   artifacts:
@@ -270,8 +270,8 @@ arm_shmobile_defconfig:
     BUILD_ARCH: arm
     CONFIG: shmobile_defconfig
     CONFIG_LOC: intree
-    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm
-    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb
+    DEVICES: r8a7743-iwg20d-q7 r8a7745-iwg22d-sodimm r8a77470-iwg23s-sbc
+    DTBS: r8a7743-iwg20d-q7-dbcm-ca.dtb r8a7745-iwg22d-sodimm-dbhd-ca.dtb r8a77470-iwg23s-sbc.dtb
   script:
     - /opt/build_kernel.sh
   artifacts:
-- 
2.17.1
