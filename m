Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B57EC433EF
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 07:59:45 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.58])
 by mx.groups.io with SMTP id smtpd.web10.27693.1647849584170185867
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Mar 2022 00:59:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=T0Jzdvj8;
 spf=pass (domain: siemens.com, ip: 40.107.7.58,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8k0WpqEed/SpHrSw0bO+3mrvKvhVmeqCqDZBRdH/bua2icxB8Cjn9//WgG2IbcnMdc3fLTIcvvk0KpaqHeaVJ/uTn9qEEj7Kqr5NTcehmpALWW9S75XLhyFUr5V8FgDx4AIbkzm447huTr3q/fTPTKktyfELzs9oswthA6OM1AdKd1weSB30EOSS9qcolJtCx7ElbbiIuAV3Kelx64p/9/X/JNwR2qQC9qv/mlH4dF25qxdQA3m67yHf2vfgMk+YQxUO1mQ2yn65JXSNJl0BugYTDP3x1tDg9dfH2F3MrfcqXwEVU3FxMVpMWM1DwC3o5SxCmnP/dcDxq7XwV/nNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLjav6r4ejRScE+J322PSzEtTj7VnbhGg0svnMdkjCM=;
 b=CueSMIHF4EcwQBXdVJqH+7W3iyeb1kQyPvJzdlFtF04fJB8nO133eqsOqzP8Prv0e0RtFYbvQJ7uFHO1GqEXKCyovQrgRV+v01XfoH6GQTvlY8KDin1BkDv3mnk15lTKTYo9x0slCwLm5SZa4QIVvXLhwHn8+2uypP/RkbDAN/m9uwMYN/gyxecGOpfmDK/iGBAP4JpwcNaHIefQlYi8kdso31iKD+IvBT/dx8RqYF33B2DeUMmuT8Kacsla1KR8HgnlXTuu7eavxMAiKX6h6eYTGdrboTWhZKa+XlRIOfhg/fO/v4P/2WCqcKmg0PH65sK6AbN0qKRDi7gdyOQ9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLjav6r4ejRScE+J322PSzEtTj7VnbhGg0svnMdkjCM=;
 b=T0Jzdvj8kwkAEfN71z1i/rlR6LOlcE7GK+UhC+b7E3c2dJDkWPuO4nq2AYYWq1xRGAZi510jiJQTbL1QFXdWPZ2OuEORo1+wGo7M/CXQN+SSPpT9AJMAcRmXIYBGdg9M3B3Y5/GFmFJGY16jbt2KQhccbtioXhtG3w6fut3neHtOr5zsJrO4J9ttweCtq8pcDkToNjqfwg7zincDPc9PN9H/FegpzQzBEfMoLOdjv6xgbuVJzsKJUrsrPZS0DLPFkZ2Y7ZkwG7Pp5p3wXW04g0Ndz+YB4J4js4iJeO2eHtKq1UbvQsM+v1zIrXW5Ae1Upf0YAzp7w5o6QqIpCMADiQ==
Received: from AM6PR10CA0019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::32)
 by VI1PR1001MB1070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:69::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Mon, 21 Mar
 2022 07:59:41 +0000
Received: from VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::d9) by AM6PR10CA0019.outlook.office365.com
 (2603:10a6:209:89::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.13 via Frontend
 Transport; Mon, 21 Mar 2022 07:59:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT047.mail.protection.outlook.com (10.152.3.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.15 via Frontend Transport; Mon, 21 Mar 2022 07:59:40 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 08:59:31 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.32.40) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Mar 2022 08:59:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 4/4] efibootguard: Fix plugins for aarch64
Date: Mon, 21 Mar 2022 08:59:20 +0100
Message-ID: 
 <d9f17a73158544ed308625dfb0e02125092b143e.1647849560.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647849560.git.jan.kiszka@siemens.com>
References: <cover.1647849560.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.32.40]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b031c816-9869-4f17-c9cc-08da0b10c0b8
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1070:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR1001MB1070A1C9992479371DFD377295169@VI1PR1001MB1070.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AJZLLCBwImJad0nvjJt3mFoaKeMIsqeErLC74j2TpkcDTixcY4HQmiXGBjoEP0SZTF9c/b4/fKyx7JD+4FGrtLfLx1k9UHK44ut1ByX/FnBX47x8OIaOzrutdEZOQYG1vGBLkWPkak+dhQNS/NmEZ084HFQELC6XiZNdIIs4Tlqxu1qnf8smOTVI2NXbpsmLMDapqZsT8x7wF78kg0ezRA3fqDtJFvRqER8sYm32GEso/hMDrG1dJljVjTZwcRa02bFOvFcpcz3luvfq0BL1gzQ7O2P1iPLB+2S7IRCP5udunabk4GNGEGbslQsY1AabQ/SyH2MUUhqNJ/HVVNyT0ycBQb+H0gmbeUDAbnAVQC2Hq8BUXqFtjVXXTNklLqjf3HeRBdmXk7hO5c3g683+H5PYSpQvDARb4604mCubl7lw+iQOarWV9HImpk3JKJnMckF5HjCCkhFV1uO8HcUlMmDO9M5lbRcm+R3t0Iq7AXxW/3ibISiNaRnU4mt9KpczM0jzfiVX7Nshn5HTzR8hs1V1EKDKw5xaScdNZTcGSFhu8rNq2SUkEk+wFfuGjVnJhDghtm2YknSQ1WTu7YsWh1mzhZ75XnZSYZQ8E1Q6gPHXX+ijknrOlV4Vmftat/zDc3A1TGQzU1pZ6rJvCpSjlv5FtSb2JcgbU4NjR9oB8fEE6WPIBIFONQNDBPJeQMeijTNz6GbUoHHV05XdM14x+eA0B+7iOW8BKYv/eZLPGyne0gEiAdjfGJ1howdJPkAOiqizXfBmPc4JLrUlHcB63BMDljcBy9Qv+Is6zU1yKHs=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(2906002)(82960400001)(82310400004)(83380400001)(36860700001)(336012)(36756003)(6666004)(956004)(186003)(8676002)(4326008)(26005)(47076005)(19627235002)(107886003)(70206006)(356005)(16526019)(81166007)(70586007)(2616005)(6916009)(8936002)(966005)(498600001)(44832011)(40460700003)(86362001)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:59:40.6439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b031c816-9869-4f17-c9cc-08da0b10c0b8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1070
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Mar 2022 07:59:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7785

From: Jan Kiszka <jan.kiszka@siemens.com>

This requires to add a post-0.10 fix from upstream EBG and own changes
so that the right arch string is used, for the loader as well as the
stub.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/efibootguard/efibootguard_0.10.bb |  1 +
 .../0001-configure-Fix-aarch64-EFI-arch.patch | 28 +++++++++++++++++++
 .../wic/plugins/source/efibootguard-boot.py   | 11 ++++++--
 .../wic/plugins/source/efibootguard-efi.py    |  2 +-
 4 files changed, 39 insertions(+), 3 deletions(-)
 create mode 100644 recipes-bsp/efibootguard/files/0001-configure-Fix-aarch=
64-EFI-arch.patch

diff --git a/recipes-bsp/efibootguard/efibootguard_0.10.bb b/recipes-bsp/ef=
ibootguard/efibootguard_0.10.bb
index b0877d0..bfc0ede 100644
--- a/recipes-bsp/efibootguard/efibootguard_0.10.bb
+++ b/recipes-bsp/efibootguard/efibootguard_0.10.bb
@@ -19,6 +19,7 @@ MAINTAINER =3D "Jan Kiszka <jan.kiszka@siemens.com>"
 SRC_URI =3D " \
     https://github.com/siemens/efibootguard/archive/refs/tags/v${PV}.tar.g=
z;downloadfilename=3Defitbootguard-v${PV}.tar.gz \
     file://debian \
+    file://0001-configure-Fix-aarch64-EFI-arch.patch \
     "
 SRC_URI[sha256sum] =3D "4d58574a0bb8f1e56056ab0bcc2487d37e49fa147dc991e719=
c2ec8e20f88dd3"
=20
diff --git a/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-=
arch.patch b/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-=
arch.patch
new file mode 100644
index 0000000..ee05e94
--- /dev/null
+++ b/recipes-bsp/efibootguard/files/0001-configure-Fix-aarch64-EFI-arch.pa=
tch
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
+ 	   MACHINE_TYPE_NAME=3Dx64])
+=20
+ AM_COND_IF(ARCH_AARCH64, [
+-	   MACHINE_TYPE_NAME=3Daarch64])
++	   MACHINE_TYPE_NAME=3Daa64])
+=20
+ AC_SUBST([ARCH])
+ AC_SUBST([MACHINE_TYPE_NAME])
+--=20
+2.34.1
+
diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/=
lib/wic/plugins/source/efibootguard-boot.py
index 05cef4e..5061629 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
@@ -176,10 +176,17 @@ class EfibootguardBootPlugin(SourcePlugin):
     def _create_unified_kernel_image(cls, rootfs_dir, cr_workdir, cmdline,
                                      uefi_kernel, deploy_dir, kernel_image=
,
                                      initrd_image, source_params):
+        # we need to map the distro_arch to uefi values
+        distro_to_efi_arch =3D {
+            "amd64": "x64",
+            "arm64": "aa64",
+            "i386": "ia32"
+        }
         rootfs_path =3D rootfs_dir.get('ROOTFS_DIR')
         os_release_file =3D "{root}/etc/os-release".format(root=3Drootfs_p=
ath)
-        efistub =3D "{rootfs_path}/usr/lib/systemd/boot/efi/linuxx64.efi.s=
tub"\
-            .format(rootfs_path=3Drootfs_path)
+        efistub =3D "{rootfs_path}/usr/lib/systemd/boot/efi/linux{efiarch}=
.stub"\
+            .format(rootfs_path=3Drootfs_path,
+                    efiarch=3Ddistro_to_efi_arch[get_bitbake_var("DISTRO_A=
RCH")])
         msger.debug("osrelease path: %s", os_release_file)
         kernel_cmdline_file =3D "{cr_workdir}/kernel-command-line-file.txt=
"\
             .format(cr_workdir=3Dcr_workdir)
diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/l=
ib/wic/plugins/source/efibootguard-efi.py
index 9e6febe..e1411cb 100644
--- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
+++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
@@ -54,7 +54,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
         # we need to map the distro_arch to uefi values
         distro_to_efi_arch =3D {
             "amd64": "x64",
-            "arm64": "aarch64",
+            "arm64": "aa64",
             "i386": "ia32"
         }
=20
--=20
2.34.1


