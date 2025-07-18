Return-Path: <hirotaka.motai@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B29FC87FC3
	for <webhook@archiver.kernel.org>; Fri, 18 Jul 2025 10:10:42 +0000 (UTC)
Received: from smtp.priv.miraclelinux.com (smtp.priv.miraclelinux.com [202.210.215.66])
 by mx.groups.io with SMTP id smtpd.web10.17493.1752833433039539890
 for <cip-dev@lists.cip-project.org>;
 Fri, 18 Jul 2025 03:10:33 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: miraclelinux.com, ip: 202.210.215.66, mailfrom: hirotaka.motai@miraclelinux.com)
Received: from 120i.miraclelinux.com (21A0120i.priv.miraclelinux.com [10.2.0.233])
	by smtp.priv.miraclelinux.com (Postfix) with ESMTP id 72B1D14010D;
	Fri, 18 Jul 2025 19:10:30 +0900 (JST)
From: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
To: cip-dev@lists.cip-project.org
Cc: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
Subject: [cip-dev][isar-cip-core][PATCH 5/5] zynqmp-zcu102: add README.zynqmp-zcu102
Date: Fri, 18 Jul 2025 19:09:08 +0900
Message-ID: <20250718100926.3151777-6-hirotaka.motai@miraclelinux.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
References: <20250718100926.3151777-1-hirotaka.motai@miraclelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 18 Jul 2025 10:10:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19563

Signed-off-by: Hirotaka Motai <hirotaka.motai@miraclelinux.com>
---
 doc/boards/README.zynqmp-zcu102.md | 48 ++++++++++++++++++++++++++++++
 wic/zynqmp-zcu102.wks.in           |  2 +-
 2 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 doc/boards/README.zynqmp-zcu102.md

diff --git a/doc/boards/README.zynqmp-zcu102.md b/doc/boards/README.zynqm=
p-zcu102.md
new file mode 100644
index 000000000000..87566dbdad67
--- /dev/null
+++ b/doc/boards/README.zynqmp-zcu102.md
@@ -0,0 +1,48 @@
+# ISAR CIP Core: Instructions for the Zynq UltraScale+ MPSoC ZCU102 eval=
uation board
+
+## Build the CIP Core image
+
+Set up `kas-container` as described in the [top-level README](../../READ=
ME.md).
+Then build the base image,
+
+```
+$ ./kas-container menu
+```
+
+Select below options to create base image,
+and click on Build to start the build.
+
+* Kernel 6.1.x-cip
+* Bookworm (12)
+
+After the build is finished, insert a SDCard and flash the image.
+
+## Prepare to boot from QSPI
+
+The board must be prepared to boot from QSPI.
+
+Please refer to the official website of the board below:
+- https://www.amd.com/en/products/adaptive-socs-and-fpgas/evaluation-boa=
rds/ek-u1-zcu102-g.html
+
+and configure the board.
+
+## U-boot settings
+
+In order to boot from the SDCard, we need to set some environment variab=
le on u-boot.
+Switch on the board and the u-boot intaractive command line to set the e=
nvironment variables.
+
+```
+u-boot > setenv cip_serverip '192.168.0.1'
+u-boot > setenv cip_tftppath '/tftp'
+u-boot > setenv cip_nfspath  '/nfsrootfs'
+u-boot > setenv cip_kernel   'Image'
+u-boot > setenv cip_fdt_file 'zynqmp-zcu102-rev1.0.dtb'
+u-boot > setenv cip_bootargs 'setenv bootargs "console=3DttyPS0,115200n8=
 root=3D/dev/nfs rw nfsroot=3D${cip_serverip}:${cip_nfspath},vers=3D4,tcp=
,hard ip=3Ddhcp"'
+u-boot > setenv cip_bootcmd 'setenv autoload no && setenv initrd_high 0x=
ffffffff && setenv fdt_high 0xffffffff && dhcp && setenv serverip ${cip_s=
erverip} && tftpboot ${kernel_addr_r} ${cip_tftppath}/${cip_kernel} && tf=
tpboot ${fdt_addr_r} ${cip_tftppath}/${cip_fdt_file} && run cip_bootargs =
&& booti ${kernel_addr_r} - ${fdt_addr_r}'
+```
+
+you can boot from the Network via TFTP/NFS servers as follows:
+
+```
+u-boot > run cip_bootcmd
+```
diff --git a/wic/zynqmp-zcu102.wks.in b/wic/zynqmp-zcu102.wks.in
index a40d4bc9329c..0775db770717 100644
--- a/wic/zynqmp-zcu102.wks.in
+++ b/wic/zynqmp-zcu102.wks.in
@@ -8,9 +8,9 @@
 #
 # SPDX-License-Identifier: MIT
 #
 # short-description: Create SD card image for ZynqMP ZCU102
-# long-description: Creates a partitioned SD card image for Zynq UltraSc=
ale+ MPSoC ZCU102.
+# long-description: Create a partitioned SD card image for Zynq UltraSca=
le+ MPSoC ZCU102.
 #
=20
 # SD card is partitioned as follows,
 #  1st partition: fat32, 448MB, for kernel image and dtb
--=20
2.47.2


