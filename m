Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0A8CCF9F1
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 07:22:01 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.26589.1761549712339909661
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Oct 2025 00:21:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=NhPggJWf;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-20251027072149cb24dcebdc0002072e-hkdlro@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251027072149cb24dcebdc0002072e
        for <cip-dev@lists.cip-project.org>;
        Mon, 27 Oct 2025 08:21:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=oifydttCXg0OT14OsX25wErHZw1H06EN4ePw3H1lYD8=;
 b=NhPggJWfnsGNvboijIEBATlgA7REN+COiIKVMV6qshHb9zHeh4tX/T7l2N6nCkiWxN1rDp
 jxtdxrcFQ8O5kbg8uzZnh+xN+Frue5FasBdkp9WBHuWyS7PJQKqm6k+4XiCb0lQYSpwu7ZKf
 pyqaitsfpxCF7oizoGKxXL/HPsKXPHYYNu+WJrQPKncllDdrOFMyuDTHI1jiaDkc+eVySbYD
 TnNPNAbOjGT9K1OfUQKvaT32pK+By+YQhGqT+iWcuZ444q4axeHn0GKPgUNb43P1nTWDiRkA
 KB0PyR186cnO4I6SxKhmUCFamIg4q2a+JTGlsQCC9Vf6R7FDbNXiuw2A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 04/19] qemu-arm64: Add optee-os 4.8.0
Date: Mon, 27 Oct 2025 08:21:33 +0100
Message-ID: <76b778f5267becb2a0b314f2d535414bb0c8239c.1761549708.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1761549708.git.jan.kiszka@siemens.com>
References: <cover.1761549708.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 07:22:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20232

From: Jan Kiszka <jan.kiszka@siemens.com>

Build OP-TEE for qemu-arm64 with fTPM and StMM. If QEMU comes with an
RPMB emulation, this allows to run a firmware stack that is very close
to real devices. It specifically enables modifiable secure UEFI
variables and allows to drop the virtual discrete TPM.

For building the fTPM TA, also the corresponding tadevkit package is
generated.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../optee-os/optee-os-qemu-arm64_4.8.0.bb     | 13 ++++++
 .../optee-os/optee-os-qemu-arm64_4.8.0.inc    | 18 ++++++++
 recipes-bsp/optee-os/optee-os-qemu.inc        | 44 +++++++++++++++++++
 .../optee-os-tadevkit-qemu-arm64_4.8.0.bb     | 15 +++++++
 4 files changed, 90 insertions(+)
 create mode 100644 recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
 create mode 100644 recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc
 create mode 100644 recipes-bsp/optee-os/optee-os-qemu.inc
 create mode 100644 recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb

diff --git a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
new file mode 100644
index 00000000..18eec20b
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.bb
@@ -0,0 +1,13 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require recipes-bsp/optee-os/optee-os-custom.inc
+require optee-os-qemu-arm64_${PV}.inc
diff --git a/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc
new file mode 100644
index 00000000..bc684534
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-qemu-arm64_4.8.0.inc
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require optee-os-qemu.inc
+
+SRC_URI[sha256sum] = "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49744701918e8b4d"
+
+OPTEE_NAME = "qemu-arm64"
+OPTEE_PLATFORM = "vexpress-qemu_armv8a"
+OPTEE_EXTRA_BUILDARGS += "CFG_ARM64_core=y CFG_USER_TA_TARGETS=ta_arm64"
diff --git a/recipes-bsp/optee-os/optee-os-qemu.inc b/recipes-bsp/optee-os/optee-os-qemu.inc
new file mode 100644
index 00000000..dec393e5
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-qemu.inc
@@ -0,0 +1,44 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+SRC_URI += " \
+    https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
+    "
+
+S = "${WORKDIR}/optee_os-${PV}"
+
+DEBIAN_BUILD_DEPENDS += ", device-tree-compiler, python3-cryptography:native"
+
+OPTEE_EXTRA_BUILDARGS = " \
+    TEE_IMPL_VERSION=${PV} \
+    CFG_TEE_CORE_LOG_LEVEL=2 CFG_TEE_TA_LOG_LEVEL=2 \
+    CFG_REE_FS=n CFG_CORE_HEAP_SIZE=524288 CFG_RPMB_FS=y \
+    CFG_RPMB_WRITE_KEY=y CFG_RPMB_TESTKEY=y \
+    "
+
+OPTEE_ENABLE_APPS ?= "1"
+OVERRIDES .= "${@':optee-with-apps' if bb.utils.to_boolean(d.getVar("OPTEE_ENABLE_APPS")) else ''}"
+
+# StMM integration, required by UEFI auth variable management
+DEPENDS:append:optee-with-apps = " edk2-standalonemm-rpmb"
+DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", edk2-standalonemm-rpmb"
+OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
+    CFG_STMM_PATH=/usr/lib/edk2/BL32_AP_MM.fd \
+    "
+
+# OP-TEE fTPM integration
+DEPENDS:append:optee-with-apps = " optee-ftpm-${OPTEE_NAME}"
+DEBIAN_BUILD_DEPENDS:append:optee-with-apps = ", optee-ftpm-${OPTEE_NAME}"
+FTPM_UUID = "bc50d971-d4c9-42c4-82cb-343fb7f37896"
+OPTEE_EXTRA_BUILDARGS:append:optee-with-apps = " \
+    CFG_EARLY_TA=y \
+    EARLY_TA_PATHS=/usr/lib/optee-os/${OPTEE_NAME}/ta/${FTPM_UUID}.stripped.elf \
+    "
diff --git a/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb b/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb
new file mode 100644
index 00000000..252e7bc4
--- /dev/null
+++ b/recipes-bsp/optee-os/optee-os-tadevkit-qemu-arm64_4.8.0.bb
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+OPTEE_ENABLE_APPS = "0"
+
+require recipes-bsp/optee-os/optee-os-tadevkit-custom.inc
+require optee-os-qemu-arm64_${PV}.inc
-- 
2.51.0


