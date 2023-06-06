Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFBDC7EE29
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 12:14:40 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
 by mx.groups.io with SMTP id smtpd.web10.1215.1686023934348122019
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Jun 2023 20:58:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@163.com header.s=s110527 header.b=aQ7lljdF;
 spf=pass (domain: 163.com, ip: 220.181.12.199, mailfrom: baocheng_su@163.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=EYJIz
	EOm39xGB+ZLz6evupnNCF8FMBwQXaE2xELYN9Y=; b=aQ7lljdFA1d3sH59a5qPi
	gQtyYyTHkNsn6IWHlt8UkmAIbzSflTrWtiZLOhySfSAkP530SW/DFrmRl5Q3ooDC
	16UjzR3c0i2hGa4cXt0bq4LQhDFR79dXqRycFBTNTyttrB014Ad6nNtJ5YBfc8JG
	nTLAjtDDK+5Q/Lqwss8qUA=
Received: from debian-on-mac.lan (unknown [116.169.3.110])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wAHtanzrn5kHOJSBg--.9063S3;
	Tue, 06 Jun 2023 11:58:46 +0800 (CST)
From: baocheng_su@163.com
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Cc: christian.storm@siemens.com,
	quirin.gylstorff@siemens.com,
	baocheng.su@siemens.com
Subject: [isar-cip-core][PATCH v2 1/2] Add recipe for optee-client
Date: Tue,  6 Jun 2023 11:55:05 +0800
Message-Id: <20230606035506.10354-2-baocheng_su@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606035506.10354-1-baocheng_su@163.com>
References: <20230606035506.10354-1-baocheng_su@163.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wAHtanzrn5kHOJSBg--.9063S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFyfur1ktFyxAw1UGw13twb_yoWxWr1xpr
	WYkF15Ars3Jws29a9rK3ZrurWrJayrAFn5ArnFg3y5AFyxGFn7KF4jkF98uFW3tryxZw1j
	qF1jqay0gw1UCaDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7ID7UUUUU=
X-Originating-IP: [116.169.3.110]
X-CM-SenderInfo: pedrux5hqjs2rx6rljoofrz/xtbBFBaGJ1aEIDxU9gABsO
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 12:14:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11876

From: Baocheng Su <baocheng.su@siemens.com>

This brings the libteec1, optee-client-dev and most important,
tee-supplicant.

Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
---
 recipes-bsp/optee-client/files/control.tmpl   | 51 +++++++++++++++++++
 recipes-bsp/optee-client/files/rules.tmpl     | 20 ++++++++
 .../optee-client/files/tee-supplicant.service |  9 ++++
 .../optee-client/optee-client_3.20.0.bb       | 47 +++++++++++++++++
 4 files changed, 127 insertions(+)
 create mode 100644 recipes-bsp/optee-client/files/control.tmpl
 create mode 100755 recipes-bsp/optee-client/files/rules.tmpl
 create mode 100644 recipes-bsp/optee-client/files/tee-supplicant.service
 create mode 100644 recipes-bsp/optee-client/optee-client_3.20.0.bb

diff --git a/recipes-bsp/optee-client/files/control.tmpl b/recipes-bsp/optee-client/files/control.tmpl
new file mode 100644
index 0000000..b0c3756
--- /dev/null
+++ b/recipes-bsp/optee-client/files/control.tmpl
@@ -0,0 +1,51 @@
+Source: optee-client
+Priority: optional
+Maintainer: Unknown maintainer <unknown@example.com>
+Build-Depends: pkg-config, uuid-dev
+Standards-Version: 4.1.3
+Section: libs
+Homepage: https://github.com/OP-TEE/optee_client
+Rules-Requires-Root: no
+
+Package: optee-client-dev
+Section: libdevel
+Architecture: arm64
+Multi-Arch: same
+Depends: libteec1 (= ${binary:Version}),
+         ${misc:Depends}
+Description: normal world user space client APIs for OP-TEE (development)
+ OP-TEE is a Trusted Execution Environment (TEE) designed as companion to a
+ non-secure Linux kernel running on Arm; Cortex-A cores using the TrustZone
+ technology. OP-TEE implements TEE Internal Core API v1.1.x which is the API
+ exposed to Trusted Applications and the TEE Client API v1.0, which is the
+ API describing how to communicate with a TEE. This package provides the TEE
+ Client API library.
+ .
+ This package contains the development files OpTEE Client API
+
+Package: libteec1
+Architecture: arm64
+Multi-Arch: same
+Depends: ${misc:Depends}, ${shlibs:Depends}
+Description: normal world user space client APIs for OP-TEE
+ OP-TEE is a Trusted Execution Environment (TEE) designed as companion to a
+ non-secure Linux kernel running on Arm; Cortex-A cores using the TrustZone
+ technology. OP-TEE implements TEE Internal Core API v1.1.x which is the API
+ exposed to Trusted Applications and the TEE Client API v1.0, which is the
+ API describing how to communicate with a TEE. This package provides the TEE
+ Client API library.
+ .
+ This package contains libteec library.
+
+Package: tee-supplicant
+Architecture: arm64
+Depends: ${misc:Depends}, ${shlibs:Depends}
+Description: normal world user space client APIs for OP-TEE
+ OP-TEE is a Trusted Execution Environment (TEE) designed as companion to a
+ non-secure Linux kernel running on Arm; Cortex-A cores using the TrustZone
+ technology. OP-TEE implements TEE Internal Core API v1.1.x which is the API
+ exposed to Trusted Applications and the TEE Client API v1.0, which is the
+ API describing how to communicate with a TEE. This package provides the TEE
+ Client API library.
+ .
+ This package contains tee-supplicant executable.
diff --git a/recipes-bsp/optee-client/files/rules.tmpl b/recipes-bsp/optee-client/files/rules.tmpl
new file mode 100755
index 0000000..a8f2afd
--- /dev/null
+++ b/recipes-bsp/optee-client/files/rules.tmpl
@@ -0,0 +1,20 @@
+#!/usr/bin/make -f
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
+endif
+
+%:
+	dh $@ --exclude=.a
+
+override_dh_auto_build:
+	dh_auto_build -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
+		CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH} ${RPMB_EMU_BUILD_OPT}
+
+override_dh_auto_install:
+	dh_auto_install -- LIBDIR=/usr/lib/$(DEB_HOST_MULTIARCH) \
+		CFG_TEE_FS_PARENT_PATH=${TEE_FS_PARENT_PATH} ${RPMB_EMU_BUILD_OPT}
+
+override_dh_auto_clean:
+	dh_auto_clean
+	rm -rf $(CURDIR)/out
diff --git a/recipes-bsp/optee-client/files/tee-supplicant.service b/recipes-bsp/optee-client/files/tee-supplicant.service
new file mode 100644
index 0000000..7148515
--- /dev/null
+++ b/recipes-bsp/optee-client/files/tee-supplicant.service
@@ -0,0 +1,9 @@
+[Unit]
+Description=TEE Supplicant
+
+[Service]
+Type=simple
+ExecStart=/usr/sbin/tee-supplicant
+
+[Install]
+WantedBy=multi-user.target
diff --git a/recipes-bsp/optee-client/optee-client_3.20.0.bb b/recipes-bsp/optee-client/optee-client_3.20.0.bb
new file mode 100644
index 0000000..b760a2c
--- /dev/null
+++ b/recipes-bsp/optee-client/optee-client_3.20.0.bb
@@ -0,0 +1,47 @@
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
+inherit dpkg
+
+DESCRIPTION = "OPTee Client"
+
+PROVIDES = "libteec1 optee-client-dev tee-supplicant"
+
+SRC_URI += "https://github.com/OP-TEE/optee_client/archive/${PV}.tar.gz;downloadfilename=optee_client-${PV}.tar.gz \
+    file://control.tmpl \
+    file://rules.tmpl \
+    file://tee-supplicant.service"
+SRC_URI[sha256sum] = "69414c424b8dbed11ce1ae0d812817eda2ef4f42a1bef762e5ca3b6fed80764c"
+
+S = "${WORKDIR}/optee_client-${PV}"
+
+TEE_FS_PARENT_PATH ?= "/var/lib/optee-client/data/tee"
+# To use the builtin RPMB emulation, empty this
+RPMB_EMU_BUILD_OPT ?= "RPMB_EMU=0"
+
+TEMPLATE_FILES = "rules.tmpl control.tmpl"
+TEMPLATE_VARS += "TEE_FS_PARENT_PATH RPMB_EMU_BUILD_OPT"
+
+do_prepare_build[cleandirs] += "${S}/debian"
+do_prepare_build() {
+    deb_debianize
+
+    cp -f ${WORKDIR}/tee-supplicant.service \
+        ${S}/debian/tee-supplicant.service
+    echo "/usr/sbin/*" > ${S}/debian/tee-supplicant.install
+    echo "lib/optee_armtz/" > ${S}/debian/tee-supplicant.dirs
+    echo "usr/lib/tee-supplicant/plugins/" >> ${S}/debian/tee-supplicant.dirs
+
+    echo "usr/lib/*/libteec*.so.*" > ${S}/debian/libteec1.install
+
+    echo "usr/include/*" > ${S}/debian/optee-client-dev.install
+    echo "usr/lib/*/lib*.so" >> ${S}/debian/optee-client-dev.install
+}
-- 
2.39.2


