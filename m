Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0366C433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 12:32:19 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.70])
 by mx.groups.io with SMTP id smtpd.web09.30005.1647865938766374793
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Mar 2022 05:32:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z4qeCbBK;
 spf=pass (domain: siemens.com, ip: 40.107.20.70,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpqJNCrt5snsceiX5e11LJZrni7I8HbO9f+2Rv3Q8i3Up65elFb/rwIAkHZsq4eAEZPCY6ZWS00HxOytOM5dDKRqR9V/TQUPnzB07erQCSXyoJAxk25+KLJME3xu9M5Cxw2TQfyoiaS8CBIWRrm2skfKaU4+ygnZkpnI8EUsoX0McCbE0a4JeSqS+Afn2zuZyD/WwDQRzURtdckH9+Pu1MZmebLB8u74+vOT7dvSCIDUQu05BQDbUxMwvZZzZgsFH6OP/UE3MAixtBF7ejSbMM9d9iABOywiAB0cVUwEiIpvYP9joxjm4ZPTSS2gSXTCRg5HkfpeBTUlTf5SRj3FWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UxG40zjP3ZrgcFGfQtqwS9PSnMhKmkU1FHt20blw4a4=;
 b=XUYT8CeZWgJne4Gi9kvsP1QONr1DNXeo+nA1Cf34UcCv0oa/W+dRiVBgmTCaX/GicUtdauh9VSluCpMjoGr8QtsolGhLd8W5YHu+YQS5A34cc9imMx0ewH+9TPZCydoNSNJC3B+4CDOGFk/IwXg6w7E/kHP2EFiYMRoDCqDnpDMB9rkABO9LLj0gKLS9+DULvDeSYbPmgyWUr4c6XY3JnqGjGT2lGLLBuUrew2JYBlQHhzVqTP3PIXsldhi7ZFVKtWlaKV+MROcpAqz0vh9AOBkjMHad0ed/6/PzLGbX6QhFJBnf5EnevW2QShYLkcdnFRE8rUPSj6aSGaQgggCkZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UxG40zjP3ZrgcFGfQtqwS9PSnMhKmkU1FHt20blw4a4=;
 b=z4qeCbBKtY/YCq2YWqeoJx6jonS2TTfhYDTCp8B0LEqfNh+Aw3GL+F3X6IiY/nH1iWHzxZNhOFkKW+0tAfUck0gLsRVzP3+PY9oTxGQLNJzt04v05unTiMu1kxRSaHMtuvpZGPJZzPxwQnBGhsjJClJ1d9oKk/2fCCh+NMa/rKhBwG8Qo9AuLawFttAWtLAYfdr+1ggQrFTMV5TmCUgJt09q0tqiZfqPYZuKDKtJK4/pNBkrDkBW/7QR0UZhO/k0qkbKLfqle66WmyIseVtwEu/dD0u0lfSw9YaW4g7lmMNq9g+eHGRA0YfyCcRTRBT0e2/xN+a7gsJ9JiRw+HxxvQ==
Received: from AM6PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:20b:92::33)
 by DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:e::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.18; Mon, 21 Mar 2022 12:32:15 +0000
Received: from VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:92:cafe::5c) by AM6PR04CA0020.outlook.office365.com
 (2603:10a6:20b:92::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Mon, 21 Mar 2022 12:32:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT047.mail.protection.outlook.com (10.152.3.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.15 via Frontend Transport; Mon, 21 Mar 2022 12:32:15 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 13:32:14 +0100
Received: from [167.87.32.40] (167.87.32.40) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 21 Mar
 2022 13:32:14 +0100
Message-ID: <6c6745b0-7838-b63d-f094-5bf81c40dd8c@siemens.com>
Date: Mon, 21 Mar 2022 13:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [isar-cip-core v2][PATCH 4/4] efibootguard: Fix plugins for aarch64
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1647849560.git.jan.kiszka@siemens.com>
 <d9f17a73158544ed308625dfb0e02125092b143e.1647849560.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <d9f17a73158544ed308625dfb0e02125092b143e.1647849560.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.32.40]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c58bc95e-4a63-4eaf-71cd-08da0b36d4b5
X-MS-TrafficTypeDiagnostic: DB7PR10MB1915:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR10MB1915F7A2FBF4E4F9FC35A5AF95169@DB7PR10MB1915.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f3u33t5h8fhtYE5cSaooeadX4uPH5dnp8eQ4O2MlxMdh/VajY8nGp5meVfe5cVv5411ndNYoZI9i7PJ94G71X96LNMIe1uyKb0adnYLsXA+YDb394e4ZQW92BLLt7wIEQFL2SVbK/dblymSjWjxf7AnAPGQUV58EVCJLGTVcLyrlQTlBT5Thpm0nyMeRsxpdNO51AEAIni/u52UY2xpMsw/abTbwm1kQyjV6GLfXuEymMNef12F5VH0lDWMc3HrbACQuLDgCC+RCqyqXOby7JajUm5ZiMt3PrclTdPweZvubnqxh9TNui7FW5ytl6Ku0BrAajeeJLum/FrfyBkgZJOno8HWEYjKF7qbXyvBf+SFgA4Nq43tOerB3Bx2HfCXFt8ajTTs0TkzbhE/w3ocWTwWryFqEWLxKXyJtiZbUUG9Ky4mcUhibAeQJKh3ZKDvF6YVkZ4jI45AIODh74tSdJ1UlplU3Z9E4MlMfDaCIE7qMgBLSgJDihGRlux80ovJSAR2X7YeLX765WGsJANathhwb3HqLOzKBDht1H1Py6ZXZmjnjKaHcqYuhSOVvOJplbHmwtyiW8Y+rBfGxpdd3+Ie4GbGCJtVm+o3q42dmIJ4l9SwBZ0M3kmYo7mtvMncBH7ZlXCT+sAvp67agCeZipBUisKu5c7Xh/iHPq0dRfLuzs7b+f2RXPyeMK8nk38gfdWijYjBgUorfEjYIdYqceucAaXpZDzkoeyqHl8CP4kss/X0z9UtsSuWs97AoOIjBn6sj99Ex/fWCRh+8Nfj6CiGfIVkKveN4h9uJMxkY91a/NCXfnCNGanHfk6Rtqmz6
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(86362001)(966005)(31696002)(107886003)(36860700001)(498600001)(7596003)(6916009)(2906002)(356005)(6706004)(2616005)(82960400001)(82310400004)(7636003)(956004)(40460700003)(5660300002)(44832011)(19627235002)(83380400001)(8936002)(47076005)(186003)(26005)(16526019)(36756003)(336012)(8676002)(31686004)(70206006)(4326008)(70586007)(16576012)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 12:32:15.0678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c58bc95e-4a63-4eaf-71cd-08da0b36d4b5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1915
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Mar 2022 12:32:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7787

From: Jan Kiszka <jan.kiszka@siemens.com>

This requires to add a post-0.10 fix from upstream EBG and own changes
so that the right arch string is used, for the loader as well as the
stub.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---

Changes in v2:
 - fix a regression in the linux<arch>.efi.stub filename

 recipes-bsp/efibootguard/efibootguard_0.10.bb |  1 +
 .../0001-configure-Fix-aarch64-EFI-arch.patch | 28 +++++++++++++++++++
 .../wic/plugins/source/efibootguard-boot.py   | 11 ++++++--
 .../wic/plugins/source/efibootguard-efi.py    |  2 +-
 4 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch

diff --git a/recipes-bsp/efibootguard/efibootguard_0.10.bb b/recipes-bsp/efibootguard/efibootguard_0.10.bb
index b0877d0..bfc0ede 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.10.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.10.bb
@@ -19,6 +19,7 @@ MAINTAINER = "Jan Kiszka <jan.kiszka@siemens.com>"
 SRC_URI = " \
     https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.gz;downloadfilename=efitbootguard-v${PV}.tar.gz \
     file://debian \
+    file://0001-configure-Fix-aarch64-EFI-arch.patch \
     "
 SRC_URI[sha256sum] = "4d58574a0bb8f1e56056ab0bcc2487d37e49fa147dc991e719c2ec8e20f88dd3"
 
diff --git a/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch b/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch
new file mode 100644
index 0000000..ee05e94
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.patch
@@ -0,0 +1,28 @@
+From 3f11612fbcbd1c17988d634ecdaecf1ec241f6e0 Mon Sep 17 00:00:00 2001
+From: Jan Kiszka <jan.kiszka@siemens.com>
+Date: Mon, 21 Mar 2022 07:02:28 +0100
+Subject: [PATCH] configure: Fix aarch64 EFI arch
+
+It's aa64 here according to the UEFI spec.
+
+Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
+---
+ configure.ac | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/configure.ac b/configure.ac
+index a1a83e9..09d06d7 100644
+--- a/configure.ac
++++ b/configure.ac
+@@ -102,7 +102,7 @@ AM_COND_IF(ARCH_X86_64, [
+ 	   MACHINE_TYPE_NAME=x64])
+ 
+ AM_COND_IF(ARCH_AARCH64, [
+-	   MACHINE_TYPE_NAME=aarch64])
++	   MACHINE_TYPE_NAME=aa64])
+ 
+ AC_SUBST([ARCH])
+ AC_SUBST([MACHINE_TYPE_NAME])
+-- 
+2.34.1
+
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
index 05cef4e..98a327c 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -176,10 +176,17 @@ class EfibootguardBootPlugin(SourcePlugin):
     def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
                                      uefi_kernel, deploy_dir, kernel_image,
                                      initrd_image, source_params):
+        # we need to map the distro_arch to uefi values
+        distro_to_efi_arch = {
+            "amd64": "x64",
+            "arm64": "aa64",
+            "i386": "ia32"
+        }
         rootfs_path = rootfs_dir.get('ROOTFS_DIR')
         os_release_file = "{root}/etc/os-release".format(root=rootfs_path)
-        efistub = "{rootfs_path}/usr/lib/systemd/boot/efi/linuxx64.efi.stub"\
-            .format(rootfs_path=rootfs_path)
+        efistub = "{rootfs_path}/usr/lib/systemd/boot/efi/linux{efiarch}.efi.stub"\
+            .format(rootfs_path=rootfs_path,
+                    efiarch=distro_to_efi_arch[get_bitbake_var("DISTRO_ARCH")])
         msger.debug("osrelease path: %s", os_release_file)
         kernel_cmdline_file = "{cr_workdir}/kernel-command-line-file.txt"\
             .format(cr_workdir=cr_workdir)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
index 9e6febe..e1411cb 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -54,7 +54,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
         # we need to map the distro_arch to uefi values
         distro_to_efi_arch = {
             "amd64": "x64",
-            "arm64": "aarch64",
+            "arm64": "aa64",
             "i386": "ia32"
         }
 
-- 
2.34.1


