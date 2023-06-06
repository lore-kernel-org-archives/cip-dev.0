Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FD4C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 12:14:50 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.216])
 by mx.groups.io with SMTP id smtpd.web10.1216.1686023936663174371
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 20:58:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@163.com header.s=s110527 header.b=BBj6aNPq;
 spf=pass (domain: 163.com, ip: 220.181.12.216, mailfrom: baocheng_su@163.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wdtjp
	lMKgvr2LVgdoYwy2maVRkGqw68Wbn9eQxR99To=; b=BBj6aNPq9ZwcZormkBCDS
	CNbJGDMeVKdq3qOLyEY+ensvL1w5Pdd3kWxISvA05Np2ORIo43vxff/ing4TjAPv
	v1bF0Sb8IU8vQlWX0UhymgqJAg04qdgJsBBUbBbFEY65IV1OyginYsIZq26nu41B
	3cunq9ySS+hk0FQJMBtbIs=
Received: from debian-on-mac.lan (unknown [116.169.3.110])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wAHtanzrn5kHOJSBg--.9063S4;
	Tue, 06 Jun 2023 11:58:52 +0800 (CST)
From: baocheng_su@163.com
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Cc: christian.storm@siemens.com,
	quirin.gylstorff@siemens.com,
	baocheng.su@siemens.com
Subject: [isar-cip-core][PATCH v2 2/2] initramfs: Add recipe for optee based ftpm hook
Date: Tue,  6 Jun 2023 11:55:06 +0800
Message-Id: <20230606035506.10354-3-baocheng_su@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606035506.10354-1-baocheng_su@163.com>
References: <20230606035506.10354-1-baocheng_su@163.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wAHtanzrn5kHOJSBg--.9063S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZr1xtFW7Wr1kGr4ftry3CFg_yoWrXFyrpa
	9IkFWfWrZ7ZF4xK3y2kr4UArW3Kw4Fyws8XrnFqw4xC34rGr98tr4xtF17WrZ2qF4UJa1F
	qF4q9a43uF1jvFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jllksUUUUU=
X-Originating-IP: [116.169.3.110]
X-CM-SenderInfo: pedrux5hqjs2rx6rljoofrz/1tbiLB+GJ1sph3jA5gAAs5
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 12:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11877

From: Baocheng Su <baocheng.su@siemens.com>

Prepare for initramfs applications relying on TPM, such as clevis or
systemd-cryptsetup

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
---
 .../initramfs-ms-ftpm-hook/files/ms-ftpm.hook | 38 ++++++++++++++++
 .../files/ms-ftpm.script                      | 43 +++++++++++++++++++
 .../initramfs-ms-ftpm-hook_0.1.bb             | 30 +++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.hook
 create mode 100644 recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.script
 create mode 100644 recipes-initramfs/initramfs-ms-ftpm-hook/initramfs-ms-ftpm-hook_0.1.bb

diff --git a/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.hook b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.hook
new file mode 100644
index 0000000..6db4ef9
--- /dev/null
+++ b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.hook
@@ -0,0 +1,38 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Su Bao Cheng <baocheng.su@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+PREREQ=""
+prereqs()
+{
+    echo "$PREREQ"
+}
+case $1 in
+prereqs)
+    prereqs
+    exit 0
+    ;;
+esac
+
+. /usr/share/initramfs-tools/hook-functions
+
+hook_error() {
+    echo "(ERROR): $2" >&2
+    exit 1
+}
+
+# Just in case these modules are not built-in. For stock debian arm64 kernel,
+# the tee.ko and the optee.ko exist since bookworm; the tpm_ftpm_tee.ko does not
+# exist in any stock debian kernels, it could be provided by customized kernel.
+manual_add_modules tee
+manual_add_modules optee
+manual_add_modules tpm_ftpm_tee
+
+copy_exec /usr/sbin/tee-supplicant || hook_error "/usr/sbin/tee-supplicant not found"
diff --git a/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.script b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.script
new file mode 100644
index 0000000..c6ee2dd
--- /dev/null
+++ b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.script
@@ -0,0 +1,43 @@
+#!/bin/sh
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Su Bao Cheng <baocheng.su@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+PREREQ=""
+
+prereqs()
+{
+	echo "$PREREQ"
+}
+
+case $1 in
+# get pre-requisites
+prereqs)
+	prereqs
+	exit 0
+	;;
+esac
+
+FTPM_DEV=/dev/tpmrm0
+
+. /scripts/functions
+
+/usr/sbin/tee-supplicant -d
+
+# The fTPM TA would take some time to be discovered as well as the tee-supplicant
+# 10 seconds should be enough
+wait_sec=10
+until test $wait_sec -eq 0 || test -c "${FTPM_DEV}" ; do
+	wait_sec=$((wait_sec-1))
+	sleep 1
+done
+
+if ! test -c "${FTPM_DEV}"; then
+    panic "Can't discover the fTPM device ${FTPM_DEV}!"
+fi
diff --git a/recipes-initramfs/initramfs-ms-ftpm-hook/initramfs-ms-ftpm-hook_0.1.bb b/recipes-initramfs/initramfs-ms-ftpm-hook/initramfs-ms-ftpm-hook_0.1.bb
new file mode 100644
index 0000000..fece6ff
--- /dev/null
+++ b/recipes-initramfs/initramfs-ms-ftpm-hook/initramfs-ms-ftpm-hook_0.1.bb
@@ -0,0 +1,30 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2023
+#
+# Authors:
+#  Su Bao Cheng <baocheng.su@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg-raw
+
+SRC_URI += " \
+    file://ms-ftpm.hook \
+    file://ms-ftpm.script \
+    "
+
+DEBIAN_DEPENDS = "initramfs-tools, tee-supplicant"
+
+do_install[cleandirs] += " \
+    ${D}/usr/share/initramfs-tools/hooks \
+    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
+
+do_install() {
+    install -m 0755 "${WORKDIR}/ms-ftpm.hook" \
+        "${D}/usr/share/initramfs-tools/hooks/ms-ftpm"
+    install -m 0755 "${WORKDIR}/ms-ftpm.script" \
+        "${D}/usr/share/initramfs-tools/scripts/local-bottom/ms-ftpm"
+}
-- 
2.39.2


