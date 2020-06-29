Return-Path: <SRS0=D8wp=AK=lists.cip-project.org=bounce+64572+4854+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE90C433E0
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:56:17 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EBD023750
	for <cip-dev@archiver.kernel.org>; Mon, 29 Jun 2020 09:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="SFur2NPW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EBD023750
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4854+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YH3eYY4521723xf7iDNu0MP1; Mon, 29 Jun 2020 02:56:17 -0700
X-Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
 by mx.groups.io with SMTP id smtpd.web12.15186.1593424575369531696
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 02:56:15 -0700
X-Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id 05T9uDp2026499
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2020 11:56:13 +0200
X-Received: from md2dvrtc.ad001.siemens.net ([167.87.4.33])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTP id 05T9uBnw028120;
	Mon, 29 Jun 2020 11:56:13 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: Jan.Kiszka@siemens.com, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev] [isar-cip-core PATCH v2 4/5] wic: Add wks files for A/B Partition update
Date: Mon, 29 Jun 2020 11:56:10 +0200
Message-Id: <20200629095611.3000-5-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
References: <20200625132111.16367-1-Quirin.Gylstorff@siemens.com>
 <20200629095611.3000-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GM1Eku0pH9XjQaqL0Yt5DwuXx4520388AA=
Content-Type: multipart/mixed; boundary="TMHm9G31DUC4BWwJY5Tb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593424577;
 bh=8L3h5uCOhayE2RlxbeQznfU23a+lPW89APiPq84r1Mg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=SFur2NPWVg7gVIXr4As4VGxdGD/Htc6MppG3oMvgp4K4QRjBCkg7Mn1EZ2r1xw0xAZM
 gdS8qR8HDh8r0xcK/lnM3uM1OPOJc4SyWhfSARPduE5bUsYkvLjbWy/oPeZLpuU5VaTEU
 fX9/qN1ad/fkSbIFs0ith5Xcm47VFkDni34=

--TMHm9G31DUC4BWwJY5Tb
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Add wks for:
- simatic-ipc227e
- qemu-amd64

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/ebg-swu.yml                  | 26 ++++++++++++++++++++++++++
 wic/ebg-sysparts.inc                 |  8 ++++++++
 wic/qemu-amd64-efibootguard.wks      |  5 +++++
 wic/simatic-ipc227e-efibootguard.wks |  5 +++++
 wic/swupdate-partition.inc           |  4 ++++
 5 files changed, 48 insertions(+)
 create mode 100644 kas/opt/ebg-swu.yml
 create mode 100644 wic/ebg-sysparts.inc
 create mode 100644 wic/qemu-amd64-efibootguard.wks
 create mode 100644 wic/simatic-ipc227e-efibootguard.wks
 create mode 100644 wic/swupdate-partition.inc

diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
new file mode 100644
index 0000000..5b39730
--- /dev/null
+++ b/kas/opt/ebg-swu.yml
@@ -0,0 +1,26 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2020
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  swupdate: |
+    IMAGE_INSTALL_append = " swupdate efibootguard"
+    BOOTLOADER = "efibootguard"
+
+  efibootguard: |
+    WDOG_TIMEOUT = "0"
+    WICVARS += "WDOG_TIMEOUT"
+
+  wic: |
+    IMAGE_TYPE = "wic-img"
+    WKS_FILE = "${MACHINE}-${BOOTLOADER}.wks"
diff --git a/wic/ebg-sysparts.inc b/wic/ebg-sysparts.inc
new file mode 100644
index 0000000..dea99e8
--- /dev/null
+++ b/wic/ebg-sysparts.inc
@@ -0,0 +1,8 @@
+# default partition layout EFI Boot Guard usage
+
+# EFI partition containing efibootguard bootloader binary
+part --source efibootguard-efi  --ondisk sda --size 16M --extra-space 0 --overhead-factor 1 --label efi   --align 1024 --part-type=EF00 --active
+
+# EFI Boot Guard environment/config partitions plus Kernel files
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT0 --align 1024 --part-type=0700 --sourceparams "revision=2,root=PARTUUID:fedcba98-7654-3210-cafe-5e0710000001"
+part --source efibootguard-boot --ondisk sda --size 32M --extra-space 0 --overhead-factor 1 --label BOOT1 --align 1024 --part-type=0700 --sourceparams "revision=1,root=PARTUUID:fedcba98-7654-3210-cafe-5e0710000002"
diff --git a/wic/qemu-amd64-efibootguard.wks b/wic/qemu-amd64-efibootguard.wks
new file mode 100644
index 0000000..3cd7360
--- /dev/null
+++ b/wic/qemu-amd64-efibootguard.wks
@@ -0,0 +1,5 @@
+# short-description: Qemu-amd64 with Efibootguard and SWUpdate
+# long-description: Disk image for qemu-amd64 with EFI Boot Guard and SWUpdate
+
+include ebg-sysparts.inc
+include swupdate-partition.inc
diff --git a/wic/simatic-ipc227e-efibootguard.wks b/wic/simatic-ipc227e-efibootguard.wks
new file mode 100644
index 0000000..74446d3
--- /dev/null
+++ b/wic/simatic-ipc227e-efibootguard.wks
@@ -0,0 +1,5 @@
+# short-description: Simatic-ipc227e with EFI Boot Guard and SWUpdate
+# long-description: Disk image for Simatic-ipc227e with EFI Boot Guard and SWUpdate
+
+include ebg-sysparts.inc
+include swupdate-partition.inc
diff --git a/wic/swupdate-partition.inc b/wic/swupdate-partition.inc
new file mode 100644
index 0000000..15fbe80
--- /dev/null
+++ b/wic/swupdate-partition.inc
@@ -0,0 +1,4 @@
+part --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000001" --size 1000M   --extra-space 128M --overhead-factor 1 --label systema --align 1024 --fstype=ext4
+part  --source rootfs --uuid "fedcba98-7654-3210-cafe-5e0710000002" --size 1000M   --extra-space 128M --overhead-factor 1 --label systemb --align 1024 --fstype=ext4
+
+bootloader --ptable gpt --append="console=tty0 console=ttyS0,115200 rootwait earlyprintk"
-- 
2.20.1


--TMHm9G31DUC4BWwJY5Tb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4854): https://lists.cip-project.org/g/cip-dev/message=
/4854
Mute This Topic: https://lists.cip-project.org/mt/75188186/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--TMHm9G31DUC4BWwJY5Tb--
