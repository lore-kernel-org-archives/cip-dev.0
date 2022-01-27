Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA353C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:13:13 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.78])
 by mx.groups.io with SMTP id smtpd.web11.679.1643303593049432141
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:13:13 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=gSKpQVx8;
 spf=pass (domain: siemens.com, ip: 40.107.22.78,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpp65VOKiZqWedxz/GT8ETBlTcSimkeCd6YwrRiwEd5yeMsjTWrUVVdG/n4URW3l2pHxTAPMMtEw5n2LEUi1mOPXKF54I18H6IMeDT8KI/oK+iVcOCggXixFMcv9ltJcKBAibz6UlHr6AtnvKA/x3QnUXO/QQVuVN/H2vebX5y4BQlIiSzAwFgxg/G3T4Ni7bDgiFBCXWZXnrcE94L+EAA7Y04V67ylir0D3/vbAYGPzsxrKRrza/r+RWPwgojCeeGk4jzvV3PRxUBNNm1S8k2Oc6pbrslu1b+tuB4X+5nGHUakr6f1KVGD8lBerRTshoWyE4EpSKJMs3zbP1gUG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EC0lIKofTDzT3drt+Kt3tLtQxqj3bTu42bqNYS3ph8U=;
 b=iV8nSxdBhMu1qGsQJ5UYalufu7QYQ9PDklp/bkem2hNehPNaebi2zjkj0VsddXpgXuRteABgS/Ef/QnXLbtcnolsK+jrkAXCRXVwnVgUIqu4OAlhvsKETbmeWslr0urNTzcYqn73fvf+4sCrjCNH8XD+KkH3O5U2CpdZBbKt4w1awtEguivXihr4wBIl9JR/UwlTPZhmaScW3IoniCE+s+gBn2ESnXuoLT64Zv7nZ4u/wJa9y9NLWVJ+MekDt15+Et1EfSQufapq6gvRKZ2R1DLOd4rLTRvsaaujFNlFbtVl2yNs/6Ql2Z5O6YKvLUL9bJDdE9NJLJ1lnyQSNTiK5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EC0lIKofTDzT3drt+Kt3tLtQxqj3bTu42bqNYS3ph8U=;
 b=gSKpQVx8P+vodZaoYiCHtayRZFT//pxKX0c4x8tql9aAn+KsNIkZREoY6XMPdOiYkVsTqA8W9Gn00Q2fbAhCQjF5yexa17oBXiK4HcwfXw19wQxjoWH8uNSXqYPX7way1GiD/15gjnb5ONA2aF1GW3RBahxiCPmUQ955dKge+6nZu1/pELeY0j01j26qJrpm/Z7JgbLZpn/GNsnHtoX7/Z2Sgc5RI9Hdsm26P6UhREiQBJmWD67sqcDygDC3/Bq/9uGd408sVsbPrrUEICla+aZ/amGYyqDIojUQq551lJzf3yTUyoBLR6SPb0ZM+pu2JJwiaU1/bs6SbNfu3d2c+Q==
Received: from DB7PR02CA0027.eurprd02.prod.outlook.com (2603:10a6:10:52::40)
 by DB6PR10MB1800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:6:3a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 27 Jan
 2022 17:13:10 +0000
Received: from DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:52:cafe::50) by DB7PR02CA0027.outlook.office365.com
 (2603:10a6:10:52::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17 via Frontend
 Transport; Thu, 27 Jan 2022 17:13:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT031.mail.protection.outlook.com (10.152.4.253) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:13:10 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:13:10 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.73.11) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 18:13:09 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v3 6/6] kernelci-customizations: Reuse common
 customizations
Date: Thu, 27 Jan 2022 18:12:43 +0100
Message-ID: 
 <124e70d6301147514c30211eb43ea71523d0c36b.1643303563.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643303563.git.jan.kiszka@siemens.com>
References: <cover.1643303563.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8529a1a1-7fdf-47d0-374b-08d9e1b84b72
X-MS-TrafficTypeDiagnostic: DB6PR10MB1800:EE_
X-Microsoft-Antispam-PRVS: 
	<DB6PR10MB1800265A849259C05357F5A595219@DB6PR10MB1800.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AhVaI9RtZxzYXE0FMB/RKfXP8in8BlI8gSTHYEAwP1qbgzgs8UnRYiSB6YxNKu8eDyMeUQY8ydiobpLcr1yzM9crhSNdtX6JkOJgRp9wii5A3ivavNTEFy+QSCfY2xKYmh9XtqphzAFfHDRVGvseVD5VuIy6D0bQzQSPhQ2fM9SQ6aK34LoMCy69FnwlOMupffO8V9uz6xF8Br1LFftXGhAna3cqkaPanYnepncm0B9bZlPuONddRTTwhmAXPPrUc9CSHSehbfxo6JHU7IEtj6uSCN1Pe2y/4VONA7nlMRb7q4KJKVuxb7dbMQ5QhGlkWmsVJYS/8V7txnbLCzzZ4AG7FZsrKDwISZDwGxVDxBJmr5uPsDqV5+m8s6kD+G2P54PXoUpUSK8HVkaNE750G4rIe5uiKjl1EqU8oqXcZqPlF5I+t5jI+KWvi1oyuuGoZrTqQvmsdF4cYJIkujqB+CvPGP+bjnRptLrt+GxicioGd6M5uVo+EWh7P8z14Oj4i2cCJyd5hzL5V9H3Sr0iVwcEVdPgcGpg9wjAS2WK+A6POhfHg96xqCROdapX6pQHpa2nbm1Fp+wKPRAse+C6leF5Jy5swTsfFQ2Zz0OriOUJ3TdvKEEI5TrwBZ+Tq8RUwqyLSOhIlwrLpqqsCxkSmhDX24fYXBX/izy/211axzqBCUub28H3AjANW8I4D6k/SiWpNutCqQkgk7ZKSkSuTHWff5gDUmid2pQ0IKZ2qNf7t+IYEEncakdiiCNZWmo86QU5oTatMVNpqS4HFbR54A6DgWCB7uORGe7t/Ee85Qw=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(40470700004)(46966006)(4326008)(8676002)(5660300002)(86362001)(336012)(2616005)(956004)(47076005)(6666004)(26005)(44832011)(81166007)(36860700001)(36756003)(82310400004)(70206006)(70586007)(8936002)(82960400001)(508600001)(2906002)(6916009)(83380400001)(356005)(186003)(316002)(16526019)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:13:10.5019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8529a1a1-7fdf-47d0-374b-08d9e1b84b72
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR10MB1800
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:13:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7513

From: Jan Kiszka <jan.kiszka@siemens.com>

We can share most of the customization steps for kernelci with the
common recipe. This comes with the theoretical risk that changes to the
latter will break the former but has the larger benefit of avoiding
duplications and gaining support for new boards etc. automatically.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../files/99-silent-printk.conf               |  1 -
 .../kernelci-customizations/files/ethernet    | 23 -------------------
 .../kernelci-customizations.bb                | 23 ++++---------------
 3 files changed, 4 insertions(+), 43 deletions(-)
 delete mode 100644 recipes-core/kernelci-customizations/files/99-silent-pr=
intk.conf
 delete mode 100644 recipes-core/kernelci-customizations/files/ethernet

diff --git a/recipes-core/kernelci-customizations/files/99-silent-printk.co=
nf b/recipes-core/kernelci-customizations/files/99-silent-printk.conf
deleted file mode 100644
index ad24d3a..0000000
--- a/recipes-core/kernelci-customizations/files/99-silent-printk.conf
+++ /dev/null
@@ -1 +0,0 @@
-kernel.printk =3D 3 4 1 3
diff --git a/recipes-core/kernelci-customizations/files/ethernet b/recipes-=
core/kernelci-customizations/files/ethernet
deleted file mode 100644
index fa47d1a..0000000
--- a/recipes-core/kernelci-customizations/files/ethernet
+++ /dev/null
@@ -1,23 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2019
-#
-# Authors:
-#  Jan Kiszka <jan.kiszka@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-allow-hotplug eth0
-allow-hotplug enp0s2
-allow-hotplug enp2s0
-
-# used on BBB
-iface eth0 inet dhcp
-
-# used on qemu-amd64
-iface enp0s2 inet dhcp
-
-# used on simatic-ipc227e
-iface enp2s0 inet dhcp
diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.b=
b b/recipes-core/kernelci-customizations/kernelci-customizations.bb
index df4257c..91ad929 100644
--- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
+++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
@@ -11,28 +11,13 @@
 # SPDX-License-Identifier: MIT
 #
=20
-inherit dpkg-raw
+require recipes-core/customizations/common.inc
=20
-DESCRIPTION =3D "CIP Core image demo & customizations"
+DESCRIPTION =3D "CIP Core KernelCI image customizations"
=20
-SRC_URI =3D " \
-    file://postinst \
-    file://ethernet \
-    file://dmesg.sh \
-    file://99-silent-printk.conf"
-
-DEPENDS +=3D "sshd-regen-keys"
-
-DEBIAN_DEPENDS =3D " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-ke=
ys"
-
-do_install() {
-  install -v -d ${D}/etc/network/interfaces.d
-  install -v -m 644 ${WORKDIR}/ethernet ${D}/etc/network/interfaces.d/
-
-  install -v -d ${D}/etc/sysctl.d
-  install -v -m 644 ${WORKDIR}/99-silent-printk.conf ${D}/etc/sysctl.d/
+SRC_URI +=3D "file://dmesg.sh"
=20
+do_install_append() {
   install -v -d ${D}/opt/kernelci
   install -v -m 744 ${WORKDIR}/dmesg.sh ${D}/opt/kernelci/
 }
--=20
2.31.1


