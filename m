Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEB8E73163
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 12:57:57 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.51897.1770037072080447667
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 04:57:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=GxeXVW04;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202602021257493b712e7a790002076d-kabtpi@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202602021257493b712e7a790002076d
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Feb 2026 13:57:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=yARMvStd1U3MMw21vPL/5VIqIN8PVled6ZWipI/xzq8=;
 b=GxeXVW04Eyrf703nFsFt/2u8QGKjH1Tip5j0RukgyIygnVN9rX3Vj1HHTMtdN+vBX9OWbQ
 TcKDZZsIL7Sk70vRzlIEKBZ1acptTSSg8d5s3LYZNUSZiSUYwgCvSL4ftXKTcdTs42jChZ6q
 36cjrw/XNOtYpSbfSKOz0S6N08TE+s0XlOzCbVyTuY5Ebfhq3k6hca3zqukeCezDVD8mkyzd
 GgJJ24UtQqDS+m2Zxg0zShIyQ4Ur8W6l9KB3UrnfM2zUABDed9afhO2KIloldH79oG6Td9L6
 bZ4YMJNib4C2ZqxMW+3ZuC4DNT5HBj4H3sBLI3UxKrzA2BqEhARASiHQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 4/9] Add hss-payload-generator recipe
Date: Mon,  2 Feb 2026 13:57:43 +0100
Message-ID: <5132f4a85c38c0db30b71345df0d054b8314ea53.1770037068.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1770037068.git.jan.kiszka@siemens.com>
References: <cover.1770037068.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 12:57:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21804

From: Jan Kiszka <jan.kiszka@siemens.com>

This is still needed to convert the U-Boot binary into the format
expected by the HART Software Service on the BeagleV-Fire. Maybe future
versions of U-Boot will handle this via a binman extension.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/hss-payload-generator/files/rules | 22 +++++++++++++++
 .../hss-payload-generator_2025.07.bb          | 27 +++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 recipes-bsp/hss-payload-generator/files/rules
 create mode 100644 recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb

diff --git a/recipes-bsp/hss-payload-generator/files/rules b/recipes-bsp/hss-payload-generator/files/rules
new file mode 100644
index 00000000..939c283b
--- /dev/null
+++ b/recipes-bsp/hss-payload-generator/files/rules
@@ -0,0 +1,22 @@
+#!/usr/bin/make -f
+#
+# Copyright (c) Siemens, 2025
+#
+# SPDX-License-Identifier: MIT
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
+endif
+
+override_dh_auto_clean:
+	$(MAKE) -C tools/hss-payload-generator clean
+
+override_dh_auto_build:
+	$(MAKE) -C tools/hss-payload-generator $(PARALLEL_MAKE) CC=$(CROSS_COMPILE)gcc
+
+override_dh_auto_test:
+
+override_dh_auto_install:
+
+%:
+	dh $@ --parallel
diff --git a/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
new file mode 100644
index 00000000..fa86094c
--- /dev/null
+++ b/recipes-bsp/hss-payload-generator/hss-payload-generator_2025.07.bb
@@ -0,0 +1,27 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens, 2025
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+SRC_URI = " \
+    https://github.com/polarfire-soc/hart-software-services/archive/refs/tags/v${PV}.tar.gz;downloadfilename=hart-software-services-v${PV}.tar.gz \
+    file://rules"
+SRC_URI[sha256sum] = "a6e94a3d9383d4af386718ae0ba3b4be2884f5e36ccfd66b3af66166472831c4"
+
+S = "${WORKDIR}/hart-software-services-${PV}"
+
+DEBIAN_BUILD_DEPENDS = "libyaml-dev, libssl-dev, libelf-dev"
+DEBIAN_DEPENDS = "\${shlibs:Depends}"
+
+do_prepare_build() {
+    deb_debianize
+    echo "tools/hss-payload-generator/hss-payload-generator usr/bin" > ${S}/debian/${PN}.install
+}
-- 
2.51.0


