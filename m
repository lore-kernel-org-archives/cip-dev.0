Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9D1C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 06:09:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web12.23395.1647238176505401078
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 23:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=tcP8bPBh;
 spf=pass (domain: siemens.com, ip: 40.107.22.61,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DyBjqwVRBhoS7WbK8vZFpzJtKCNLX9HJS3/JeR6mswxIudEy2PB2E9b1fHtO3KXSS/szRV4NHpDxasXGXVMchV/aeynVUPGpPhONeYP7mbUjjNKhB/EcuDrI3E9UYyQDZZ6aoqexD+RZpJmgcqypOgQwSzcq6cEXlshR0c+CtuB7un2CBHsF4Klu9cwNDvo3TYVs4JzwNXFftbQr+WyLwT0t/if3cFavKWgCQz8KFlLlJ43R/ghfZzUmkyHjvhdPbKVZODil3xexDI4mkWfKHwX85V2nHflcL04vAjT71R6fN1GTOh6o6Ug1SYRbMyvloRp7HhXZjry4Mdwo8azm9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvsu1qNs0CogOvuBay2tkAR80/iRcXZoQCdKKG+JRcc=;
 b=lx0+gBfxbMo/n/sgUWx+lgzw9DW86gdZQw1ZFJKDe7SBWdTHSdAZ3zf+jItTOc6N/juuaKiwCxtlrCAVLJqgKeUH7VqCFRVhKC6TvX4TbTjaj6aYXakkapbhQqeFiixf9KiUyIWoia7rWT2ML36v2vgd0FIY5P17Qr6aFznOJv3R2aaqtXLQX+88g/lojXPseBjs9W0lXd0RKi8Ts9wEZie/ewh2UqTkIEYAssBu9JaCPjRyyBcx7pDrmdtLvTD2i18VcFLMSDAz5q/k5dlGURMNcDh41Ivx0/HwfBFan6k4eNIAWSVdlPycMYjp069Iz25mjM9vUoCD5G6w3fPyaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvsu1qNs0CogOvuBay2tkAR80/iRcXZoQCdKKG+JRcc=;
 b=tcP8bPBhK97Nb0LuD3R3rOz8Gu4/TiKlmbovq35sF2pJrJoVeWb+4JSEF1SHLnb4YYups8qCl3CLmVTiyKI0s3Rd5ESGK+OLPZ8rxMDsZLOY0aODHKBz0VYo8C22hUKfpxTzf3lYwYpuRrevO86naiPLlqQSnRC5w2YTTqg3Nwhv1dih9wYm1r54tdmPhPzDinTtf55QPnwIlplpZIURvVT0x3S6FJPLV5PQdAWU2htSmm5jyYnujrJQF7s52gdC2vG8KzsSuZKiZoSQHm8qw8Cgc7XeAuvHnIOJ2qizkvTtf4dkwtVXzbzB5Z8l9zNXNjB5QSuEqISpNLQaut0i/w==
Received: from AS8P189CA0024.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::29)
 by VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 06:09:33 +0000
Received: from VE1EUR01FT028.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:31f:cafe::2) by AS8P189CA0024.outlook.office365.com
 (2603:10a6:20b:31f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Mon, 14 Mar 2022 06:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT028.mail.protection.outlook.com (10.152.2.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 06:09:32 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.72.30) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 2/6] start-qemu: Use Debian's OVMF also for
 SWUpdate mode
Date: Mon, 14 Mar 2022 07:09:17 +0100
Message-ID: 
 <f65269cdbeb965667a7aad5b9eb5ba2eb43eddf1.1647238161.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647238161.git.jan.kiszka@siemens.com>
References: <cover.1647238161.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa57f2c-fa56-4c02-fdb8-08da058134c8
X-MS-TrafficTypeDiagnostic: VI1PR10MB2672:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB26722E4CDC5387802581ED26950F9@VI1PR10MB2672.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fMQUa54kok0Ix0qm7clDmyC5sy59Q7caYwW20ioyitWXJolO+wCyN4n5vTHbo5DuBO1TrQ6/zsRSDINX34hP8Xuf0ES3bY3ox+Gk+FioCrhDFABfwSIDCX3bqN09DARHRutJMCugVFeTvkz36lNMuM8BBSR3dMRgeeGUHvfk8oAeDXi7wt+2BtvbgsYk2yU3hZTR6lFVtGAmQUSm61J9eEeJi8gRbGSvwy9AVPf/+Y1YzPQb6qM24kHpn9qFajEH+TpDgGYDKHacFxNOPBOq34tUGF9fxRCa7WES0fxFCXrmXjaVqRnFg/JRynGZPu47Hfef9EZQv4f5WiVLZ6FpuJz5nQ7BK3yIR1PjZI9NC1xa9PgKg9PT5xiWZIi5Wg104u2TNcSdq6TqEvOah0lmeVMGdphbxEnwFxkKvzGK08RlaSjuJcIYYSPh0K1xIRyLR5OHzq3MwxZuFgrB5681CzcQOrxDpVkW7ndWPdkIDq22jAu+kyZVzLtNkdq/A0X/2yBs4F1oQyDtcVtfpjF/BqH5ZM9/OVZjMhdbJ4LS8u4if8jJCDWw+Pbxr1oVJt9zbL7ggI8xYWMTajVFzgyQ+bopwwlK3XwNdCH7Y4jQgZCAYBQQwlYm+4l/1FSOCzn5R6tvaVSeCTvlGheXo4BFqOLSB8ngpUX/L6rteF2GYBzrQRmZ/+I25uxJpuDERUiG
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(6916009)(316002)(4326008)(107886003)(8676002)(70586007)(70206006)(508600001)(86362001)(40460700003)(5660300002)(36860700001)(44832011)(7596003)(8936002)(356005)(7636003)(47076005)(36756003)(83380400001)(82310400004)(26005)(956004)(2906002)(82960400001)(336012)(186003)(16526019)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:09:32.0385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9aa57f2c-fa56-4c02-fdb8-08da058134c8
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT028.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2672
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 06:09:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7709

From: Jan Kiszka <jan.kiszka@siemens.com>

Align the SWUpate case with secure boot, resolving the need to provide
some OVMF.fd locally.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml | 4 ++--
 kas/opt/efibootguard.yml             | 3 +++
 start-qemu.sh                        | 4 +++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index 1f4d668..d404df5 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -28,8 +28,8 @@ local_conf_header:
     WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
=20
   secure-boot: |
-    # Add snakeoil and ovmf binaries for qemu
-    IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-snakeoil ovmf-binaries"
+    # Add snakeoil binaries for qemu
+    IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-snakeoil"
     IMAGER_INSTALL +=3D "ebg-secure-boot-snakeoil"
=20
   ovmf: |
diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index f5f9169..9624584 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -27,3 +27,6 @@ local_conf_header:
     IMAGE_FSTYPES ?=3D "wic-img"
     WKS_FILE ?=3D "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
=20
+  ovmf-binaries: |
+    # Add ovmf binaries for qemu
+    IMAGER_BUILD_DEPS +=3D "ovmf-binaries"
diff --git a/start-qemu.sh b/start-qemu.sh
index b623602..0431906 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -133,9 +133,11 @@ if [ -n "${SECURE_BOOT}" ]; then
 			${QEMU_COMMON_OPTIONS} "$@"
=20
 elif [ -n "${SWUPDATE_BOOT}" ]; then
+		ovmf_code=3D${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_=
CODE_4M.fd}
+
 		${QEMU_PATH}${QEMU} \
 			-drive file=3D${IMAGE_PREFIX}.wic.img,discard=3Dunmap,if=3Dnone,id=3Ddi=
sk,format=3Draw \
-			-bios OVMF.fd \
+			-drive if=3Dpflash,format=3Draw,unit=3D0,readonly=3Don,file=3D${ovmf_co=
de} \
 			${QEMU_COMMON_OPTIONS} "$@"
=20
 else
--=20
2.34.1


