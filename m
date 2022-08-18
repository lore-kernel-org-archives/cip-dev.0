Return-Path: <Shivanand.Kunijadar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F778C28B2B
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 04:12:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.38189.1660795954217081874
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 21:12:34 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154,
 mailfrom: shivanand.kunijadar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27I4CWej019408;
 Thu, 18 Aug 2022 13:12:32 +0900
X-Iguazu-Qid: 34tMdeWZcVITNmwVb5
X-Iguazu-QSIG: v=2; s=0; t=1660795951; q=34tMdeWZcVITNmwVb5;
 m=FB/Wo3FAEoUiMfyNC6d3WfWEbNKh1rVWR+1j8/gALIQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1510) id 27I4CVr3038142
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2022 13:12:31 +0900
From: Shivanand.Kunijadar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core 1/4] U-Boot: Add custom BBB U-Boot and partitioning
Date: Thu, 18 Aug 2022 09:34:25 +0530
X-TSB-HOP2: ON
Message-Id: <20220818040428.11124-2-Shivanand.Kunijadar@toshiba-tsip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
References: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Aug 2022 04:12:28.0126 (UTC)
 FILETIME=[BA9197E0:01D8B2B8]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 04:12:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9285

From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>

Add custom-built BBB U-Boot and adapt partitioning
layout.

Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
---
 recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in |  79 +++++++++++++++++++
 recipes-bsp/u-boot-bbb/files/fw_env.config   |   1 +
 recipes-bsp/u-boot-bbb/files/ubootenv-bbb    | Bin 0 -> 131072 bytes
 recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb |  59 ++++++++++++++
 wic/bbb-u-boot.wks.in                        |  13 +++
 5 files changed, 152 insertions(+)
 create mode 100644 recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in
 create mode 100644 recipes-bsp/u-boot-bbb/files/fw_env.config
 create mode 100644 recipes-bsp/u-boot-bbb/files/ubootenv-bbb
 create mode 100644 recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb
 create mode 100644 wic/bbb-u-boot.wks.in

diff --git a/recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in b/recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in
new file mode 100644
index 0000000..65bf9e4
--- /dev/null
+++ b/recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in
@@ -0,0 +1,79 @@
+setenv loadaddr 0x82000000
+setenv fdtaddr 0x88000000
+setenv rdaddr 0x88080000
+
+echo "#########################################################"
+if printenv ustate; then
+    echo "ustate value is ${ustate}"
+    if test ${ustate} = 0; then
+        ## swprovisioning did not run, nothing to do.
+        echo "ustate is: ok"
+        echo "Update did not run. Boot normally."
+    elif test ${ustate} = 1; then
+        ## swprovisioning did perform an update, hence
+        ## * set new state to "testing"
+        ## * switch root filesystems
+
+        setenv ustate 2
+        #echo "setting swprovisioning state to: testing"
+        echo "Setting ustate to: testing"
+        echo "ustate value has been changed to ${ustate}"
+
+        setenv chg "${bootpart_root}"
+        setenv bootpart_root "${bootpart_root2}"
+        setenv bootpart_root2 "${chg}"
+        echo "new bootpart: ${bootpart_root} (was: ${bootpart_root2})"
+
+        saveenv
+    elif test ${ustate} = 2; then
+        ## swprovisioning did not run, the update is not confirmed
+        ## working by the swprovisioning daemon, hence
+        ## * set new state to "failed"
+        ## * switch back to old root filesystem
+
+        setenv chg "${bootpart_root}"
+        setenv bootpart_root "${bootpart_root2}"
+        setenv bootpart_root2 "${chg}"
+        echo "update not confirmed working!, restored root to ${bootpart_root} (was: ${bootpart_root2})"
+
+        setenv ustate 3
+        #echo "setting swprovisioning state to: failed"
+        echo "Setting ustate to: failed"
+        echo "ustate value has been changed to ${ustate}"
+
+        saveenv
+    elif test ${ustate} = 3; then
+        ## Return ustate from 3 to 0 to handle new update
+        setenv ustate 0
+        echo "Return ustate to normal boot to be able to handle new update"
+        echo "Setting ustate to: ok"
+        echo "ustate value has been changed to ${ustate}"
+
+        saveenv
+    else
+        ## error handling
+        echo "unsupported ustate value ${ustate}. reset."
+
+	reset
+    fi
+else
+    ## first bootup of device, initialize environment
+    #echo "doing first-run initialization of swprovisioning environment"
+    echo "doing first-run initialization of environment variables"
+    setenv ustate 0
+    setenv bootpart_root 2
+    setenv bootpart_root2 3
+    echo "Setting ustate to: ok"
+    echo "ustate value has been created. The value is ${ustate}."
+
+    saveenv
+fi
+echo "#########################################################"
+
+setenv bootargs "console=ttyO0,115200 root=/dev/mmcblk0p${bootpart_root} ro rootwait omap_wdt.early_enable=1 omap_wdt.timer_margin=60"
+
+load mmc 0:1 ${fdtaddr} am335x-boneblack.dtb
+load mmc 0:1 ${loadaddr} vmlinuz
+load mmc 0:1 ${rdaddr} initrd
+setenv rdsize ${filesize}
+bootz ${loadaddr} ${rdaddr}:${rdsize} ${fdtaddr}
diff --git a/recipes-bsp/u-boot-bbb/files/fw_env.config b/recipes-bsp/u-boot-bbb/files/fw_env.config
new file mode 100644
index 0000000..dc22d7a
--- /dev/null
+++ b/recipes-bsp/u-boot-bbb/files/fw_env.config
@@ -0,0 +1 @@
+/boot/uboot.env	0x0000	0x20000
diff --git a/recipes-bsp/u-boot-bbb/files/ubootenv-bbb b/recipes-bsp/u-boot-bbb/files/ubootenv-bbb
new file mode 100644
index 0000000000000000000000000000000000000000..cd1e027d2abaad0859fd2d5c1adf0718f8c99f2e
GIT binary patch
literal 131072
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
K0wnNXBJdw}wR>3r

literal 0
HcmV?d00001

diff --git a/recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb b/recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb
new file mode 100644
index 0000000..a8d2a5a
--- /dev/null
+++ b/recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb
@@ -0,0 +1,59 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Christian Storm <christian.storm@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DESCRIPTION = "U-Boot for BBB"
+
+# To build u-boot-tools package
+U_BOOT_TOOLS_PACKAGE = "1"
+U_BOOT_CONFIG_PACKAGE = "1"
+
+require recipes-bsp/u-boot/u-boot-custom.inc
+
+U_BOOT_REV = "c4fddedc48f336eabc4ce3f74940e6aa372de18c"
+
+SRC_URI += " \
+    git://gitlab.denx.de/u-boot/u-boot.git;rev=${U_BOOT_REV};protocol=https \
+    file://boot-bbb.scr.in \
+    file://fw_env.config \
+    file://ubootenv-bbb"
+
+# Build U-Boot with MLO (MLO does not build with $ make spl)
+U_BOOT_BIN = ""
+
+U_BOOT_CONFIG = "am335x_evm_defconfig"
+
+S = "${WORKDIR}/git"
+
+DEBIAN_BUILD_DEPENDS =. "openssl, u-boot-tools,"
+
+do_prepare_build_append() {
+    echo "MLO /usr/lib/u-boot/${MACHINE}" > \
+        ${S}/debian/u-boot-${MACHINE}.install
+    echo "u-boot.img /usr/lib/u-boot/${MACHINE}" >> \
+        ${S}/debian/u-boot-${MACHINE}.install
+    echo "tools/env/fw_printenv   /usr/bin/" >> \
+        ${S}/debian/u-boot-tools.install
+    echo "tools/env/fw_env.config	/etc" >> \
+        ${S}/debian/u-boot-tools.install
+
+    echo "\ngen_bootscript:" >> ${S}/debian/rules
+    echo "\tmkimage -A arm -O linux -T script -d ../boot-bbb.scr.in ../boot.scr" >> ${S}/debian/rules
+    sed -i 's/\(override_dh_auto_build:\)/\1 gen_bootscript/' ${S}/debian/rules
+
+    # Install BBB's fw_env.config
+    install -v -m 0644 ${WORKDIR}/fw_env.config ${S}/tools/env/fw_env.config
+}
+
+dpkg_runbuild_append() {
+    mkdir -p ${DEPLOY_DIR_IMAGE}
+    install ${WORKDIR}/boot.scr ${DEPLOY_DIR_IMAGE}/boot.scr
+    install ${WORKDIR}/ubootenv-bbb ${DEPLOY_DIR_IMAGE}/uboot.env
+}
diff --git a/wic/bbb-u-boot.wks.in b/wic/bbb-u-boot.wks.in
new file mode 100644
index 0000000..f1cf410
--- /dev/null
+++ b/wic/bbb-u-boot.wks.in
@@ -0,0 +1,13 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# SPDX-License-Identifier: MIT
+#
+part --source bootimg-partition --ondisk mmcblk0p1 --fstype vfat --label boot --align 1 --size 32 --overhead-factor 1 --extra-space 0 --active
+part / --source rootfs-u-boot --ondisk mmcblk0p2 --fstype ext4 --label platformA --align 1024 --size 2048
+part / --source rootfs-u-boot --ondisk mmcblk0p3 --fstype ext4 --label platformB --align 1024 --size 2048
+
+bootloader --append "rw rootwait"
+
-- 
2.20.1



