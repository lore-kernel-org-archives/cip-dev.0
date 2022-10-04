Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB605C433FE
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.13111.1664902103763325993
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=K7odvW9H;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-294854-20221004164821860b2fb828f5ca1e17-cerofg@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 20221004164821860b2fb828f5ca1e17
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=+48DsQTcS4eHf5EH+qhGY1ZDRq5wTuusdxzqzYoIsAI=;
 b=K7odvW9H8ZTH8fnAwl3EQyza143vuYZT7iW+aVALIeuIy3i9qBz2pLYrWlERd62B3B7Wpz
 jQYX/Hp40n7D3g8iWmE8ub0cJ9rskWLMt4v6vM60twRsnu+ys/BN7MPcd7HhhxIk8BFe4pHb
 xbkNi99+Ri9I/t2YYdSlEQC3LhW1A=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 10/12] Add qemu-riscv64 target
Date: Tue,  4 Oct 2022 18:48:16 +0200
Message-Id: 
 <b12847bd2a3e4275442ef762cb60a5eac9e4497d.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9635

From: Jan Kiszka <jan.kiszka@siemens.com>

RISC-V is not yet an official Debian port, so we need to pick sid-ports
as source. And that means things can break randomly, as today. Therefore
pick a version that builds and runs from snapshot.d.o.

Note that fetching from snapshot.d.o can be slow due to throttling or
may even fail. Let's hope things will get stable with bookworm.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 Kconfig                             | 16 +++++++++++++++-
 conf/distro/cip-core-sid-ports.conf | 16 ++++++++++++++++
 conf/distro/debian-sid-ports.list   |  2 ++
 conf/distro/debian-sid.list         |  2 ++
 conf/machine/qemu-riscv64.conf      | 15 +++++++++++++++
 kas/board/qemu-riscv64.yml          | 12 ++++++++++++
 kas/opt/sid-ports.yml               | 15 +++++++++++++++
 7 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100644 conf/distro/cip-core-sid-ports.conf
 create mode 100644 conf/distro/debian-sid-ports.list
 create mode 100644 conf/distro/debian-sid.list
 create mode 100644 conf/machine/qemu-riscv64.conf
 create mode 100644 kas/board/qemu-riscv64.yml
 create mode 100644 kas/opt/sid-ports.yml

diff --git a/Kconfig b/Kconfig
index 45637de8..cd24ce24 100644
--- a/Kconfig
+++ b/Kconfig
@@ -63,6 +63,10 @@ config TARGET_IWG20D
 	bool "iWave Systems RainboW-G20D-Qseven"
 	select ARCH_ARM
 
+config TARGET_QEMU_RISCV64
+	bool "QEMU RISC-V 64-bit (riscv64)"
+	select ARCH_RISCV64
+
 endchoice
 
 config KAS_INCLUDE_BOARD
@@ -74,6 +78,7 @@ config KAS_INCLUDE_BOARD
 	default "kas/board/qemu-arm.yml" if TARGET_QEMU_ARM
 	default "kas/board/bbb.yml" if TARGET_BBB
 	default "kas/board/iwg20m.yml" if TARGET_IWG20D
+	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
 
 comment "Kernel options"
 
@@ -83,10 +88,11 @@ choice
 
 config KERNEL_4_4
 	bool "Kernel 4.4.x-cip"
-	depends on !ARCH_ARM64
+	depends on !ARCH_ARM64 && !ARCH_RISCV64
 
 config KERNEL_4_19
 	bool "Kernel 4.19.x-cip"
+	depends on !ARCH_RISCV64
 
 config KERNEL_5_10
 	bool "Kernel 5.10.x-cip"
@@ -101,6 +107,7 @@ config KAS_INCLUDE_KERNEL
 
 config KERNEL_RT
 	bool "Real-time CIP kernel"
+	depends on !ARCH_RISCV64
 
 config KAS_INCLUDE_KERNEL_RT
 	string
@@ -115,9 +122,15 @@ choice
 
 config DEBIAN_BUSTER
 	bool "buster (10)"
+	depends on !ARCH_RISCV64
 
 config DEBIAN_BULLSEYE
 	bool "bullseye (11)"
+	depends on !ARCH_RISCV64
+
+config DEBIAN_SID_PORTS
+	bool "sid (unstable) with unofficial ports"
+	depends on ARCH_RISCV64
 
 endchoice
 
@@ -125,6 +138,7 @@ config KAS_INCLUDE_DEBIAN
 	string
 	default "kas/opt/buster.yml" if DEBIAN_BUSTER
 	default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
+	default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
 
 comment "Image features"
 
diff --git a/conf/distro/cip-core-sid-ports.conf b/conf/distro/cip-core-sid-ports.conf
new file mode 100644
index 00000000..0b369bb6
--- /dev/null
+++ b/conf/distro/cip-core-sid-ports.conf
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+require conf/distro/debian-sid-ports.conf
+require cip-core-common.inc
+
+PREFERRED_VERSION_linux-cip ?= "5.10.%"
+PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
diff --git a/conf/distro/debian-sid-ports.list b/conf/distro/debian-sid-ports.list
new file mode 100644
index 00000000..bf0f7a27
--- /dev/null
+++ b/conf/distro/debian-sid-ports.list
@@ -0,0 +1,2 @@
+deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian-ports/20220925T001806Z sid main
+deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
diff --git a/conf/distro/debian-sid.list b/conf/distro/debian-sid.list
new file mode 100644
index 00000000..46d34d76
--- /dev/null
+++ b/conf/distro/debian-sid.list
@@ -0,0 +1,2 @@
+deb	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
+deb-src	[check-valid-until=no] https://snapshot.debian.org/archive/debian/20220925T001806Z sid main
diff --git a/conf/machine/qemu-riscv64.conf b/conf/machine/qemu-riscv64.conf
new file mode 100644
index 00000000..f1f3e871
--- /dev/null
+++ b/conf/machine/qemu-riscv64.conf
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "riscv64"
+
+IMAGE_FSTYPES ?= "ext4"
+KERNEL_DEFCONFIG ?= "defconfig"
diff --git a/kas/board/qemu-riscv64.yml b/kas/board/qemu-riscv64.yml
new file mode 100644
index 00000000..0de158a8
--- /dev/null
+++ b/kas/board/qemu-riscv64.yml
@@ -0,0 +1,12 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 12
+
+machine: qemu-riscv64
diff --git a/kas/opt/sid-ports.yml b/kas/opt/sid-ports.yml
new file mode 100644
index 00000000..2e89f2b7
--- /dev/null
+++ b/kas/opt/sid-ports.yml
@@ -0,0 +1,15 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 12
+
+distro: cip-core-sid-ports
-- 
2.35.3


