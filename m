Return-Path: <cedric.hombourger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CF7D1812B
	for <webhook@archiver.kernel.org>; Mon, 14 Oct 2024 15:56:27 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.526.1728921378706723971
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Oct 2024 08:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=cedric.hombourger@siemens.com header.s=fm2 header.b=UXLL1gyN;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1212295-2024101415561471984aaa3e804be555-yir1nc@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024101415561471984aaa3e804be555
        for <cip-dev@lists.cip-project.org>;
        Mon, 14 Oct 2024 17:56:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gWcfqTyBeUD6tMHyP0/e8dRHFjfRCzdtxLI33rerlCE=;
 b=UXLL1gyNJiLymABlz0dcWP7WIGt7pyVZK3M37pxQgGdqCd571Mm0CmkepPbPomgIPObXNv
 mod+R9mzUp9YdfTkKatxNnwQMXVUYJDlB0CPE4D3vMWCVe65j941MS7ALtAlQcQn6jbDaJ6V
 VwJAyodRJrUzmbM3CyTj5KnmTp39znLYLPb38Y5huPU5qJ5rVY5OlyEeUXfwnRlRsqGHb5r2
 e6lWYQ+p5rJJSlGZ5JdbMuDBjANDi87kMPq/zTxrjNsiher08l8iWkZr24df/X2tUb3XeXbi
 qVsONC7rfCEgHXCsJKJkMgHfQSu1dey6IHqQwsBn6g/qQyfnREBtrzng==;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [isar-cip-core][PATCH] distro: add preliminary support for the upcoming Debian 13 (trixie)
Date: Mon, 14 Oct 2024 17:56:04 +0200
Message-Id: <20241014155604.569003-1-cedric.hombourger@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Oct 2024 15:56:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17034

Debian will probably start freezing packages next year (first a soft freeze
then a hard freeze). It is important that the CIP community starts testing
Debian 13 to provide feedback upstream while we may still influence versions
that the distribution will select for their new major version.

Signed-off-by: Cedric Hombourger <cedric.hombourger@siemens.com>
---
 Kconfig                                          |  5 +++++
 conf/distro/cip-core-trixie.conf                 | 16 ++++++++++++++++
 kas/opt/trixie.yml                               | 15 +++++++++++++++
 .../secure-boot-secrets/files/trixie             |  1 +
 .../swupdate-certificates/files/trixie           |  1 +
 5 files changed, 38 insertions(+)
 create mode 100644 conf/distro/cip-core-trixie.conf
 create mode 100644 kas/opt/trixie.yml
 create mode 120000 recipes-devtools/secure-boot-secrets/files/trixie
 create mode 120000 recipes-devtools/swupdate-certificates/files/trixie

diff --git a/Kconfig b/Kconfig
index a70ce22..9b15c05 100644
--- a/Kconfig
+++ b/Kconfig
@@ -136,6 +136,10 @@ config DEBIAN_BOOKWORM
 	bool "bookworm (12)"
 	depends on !ARCH_RISCV64
 
+config DEBIAN_TRIXIE
+	bool "trixie (testing)"
+	depends on !ARCH_RISCV64
+
 config DEBIAN_SID
 	bool "sid (unstable)"
 	depends on ARCH_RISCV64
@@ -147,6 +151,7 @@ config KAS_INCLUDE_DEBIAN
 	default "kas/opt/buster.yml" if DEBIAN_BUSTER
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
 	default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
+	default "kas/opt/trixie.yml" if DEBIAN_TRIXIE
 	default "kas/opt/sid.yml" if DEBIAN_SID
 
 comment "Image features"
diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
new file mode 100644
index 0000000..58999d1
--- /dev/null
+++ b/conf/distro/cip-core-trixie.conf
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Cedric Hombourger <cedric.hombourger@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require conf/distro/debian-trixie.conf
+require cip-core-common.inc
+
+PREFERRED_VERSION_linux-cip ?= "6.1.%"
+PREFERRED_VERSION_linux-cip-rt ?= "6.1.%"
diff --git a/kas/opt/trixie.yml b/kas/opt/trixie.yml
new file mode 100644
index 0000000..e9a76ef
--- /dev/null
+++ b/kas/opt/trixie.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2024
+#
+# Authors:
+#  Cedric Hombourger <cedric.hombourger@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+distro: cip-core-trixie
diff --git a/recipes-devtools/secure-boot-secrets/files/trixie b/recipes-devtools/secure-boot-secrets/files/trixie
new file mode 120000
index 0000000..91bf492
--- /dev/null
+++ b/recipes-devtools/secure-boot-secrets/files/trixie
@@ -0,0 +1 @@
+bullseye
\ No newline at end of file
diff --git a/recipes-devtools/swupdate-certificates/files/trixie b/recipes-devtools/swupdate-certificates/files/trixie
new file mode 120000
index 0000000..3d633ae
--- /dev/null
+++ b/recipes-devtools/swupdate-certificates/files/trixie
@@ -0,0 +1 @@
+../../secure-boot-secrets/files/trixie
\ No newline at end of file
-- 
2.39.5


