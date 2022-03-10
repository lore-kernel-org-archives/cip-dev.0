Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5871BC433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 18:50:44 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.70])
 by mx.groups.io with SMTP id smtpd.web11.585.1646938242699546962
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Mar 2022 10:50:43 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=b0wLOkbO;
 spf=pass (domain: siemens.com, ip: 40.107.22.70,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U7b32IglA78Rx6ETpRE1PI4KVjfWOg0Dn9j3baOxlnDuzqr6CXL8ipSOIaqVHEK0k3m++BRxy5cWQJgjpvLxaXZMwT64NlvhrZt7MpnwSyS1iJSLTPasB/ybpvOIeyLjLmAR4BA9fvqCZXsEIZZ50X07saGrHd+WRQvEpKGqOH2C14+g12bqL2FlVKNgbFTB5tqD3qVhF++7fTSY04Gp/7yqmNSOOEeUfpJxUM9PMhaxZzzzCkhKgFbXr+1zU/Fmo/3fIgo32KJykaqSuKJfjrkEeihHy/x3H46LxZfdVqVCna26WM+uWk3HwmvVoXWTmsq0FSq277rgnmgdMyct9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vthh/u10s+dyo2U5QgPwjbk5D2VeA1DlgftMpC87JgQ=;
 b=aF89vj9UwfvNgK7U01YNuDPfuomzzajgb2P3M1gpQo3ZcfKHmLTm3mP2LI1Yyi6JVb6sfNSre2Y0abBFBbHMclrKiYQ/pmQ4nIF6zK5Tjes5805/si2bbPLedoTXnEa3mjX0AHCzlQUnMAzN6iWYHcbSwNqyg9Ixnysl3J6nIMiCTvYBEyvyY2dtrwIYzkCok+qtO30gb/3OMGTwKXkrg/R+kif34XHiBM/Tzzhwbh2sztNz3p//6tMCo8axurb1JWawwJ9nNs5jrj+vmXddlumXYVScQxnG6FvOChkBmhnCai5mVPr8sdoR+Q+SRE24+vQnXkapfhF/ybzWpebcvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vthh/u10s+dyo2U5QgPwjbk5D2VeA1DlgftMpC87JgQ=;
 b=b0wLOkbOB4YFyIc5V8V3dH7oO/XS6miOLiVTq85h5RbAFhuNfm9VrEJDUNKOeUDUXdmrxpVKSOa65wzHUktnjLsft8DG9tIHQYLC5Td0zkZAsNIP/Y1yfnz8grNnwety4CRJ2nWN/84adwEMdOTbGQVEx2e/a79+xfVDOZUVx3nm3giRZKyhFl3dPrpmO5T1z08ZGqkAuA9MT72QB95lX854YZXf67Ve9n6vP35d/rsX/npBCTBVBcqyytI8ZKren5PZudL8Jtj09CtaW5/XWfU8q2Agnp414yOOIvg416rFwrYzNrHxXNjREUjL6X+U7jX1n1ZU5mvVrRzYow4FfA==
Received: from AM3PR05CA0101.eurprd05.prod.outlook.com (2603:10a6:207:1::27)
 by DB9PR10MB4700.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:261::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 18:50:39 +0000
Received: from VE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:207:1:cafe::21) by AM3PR05CA0101.outlook.office365.com
 (2603:10a6:207:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22 via Frontend
 Transport; Thu, 10 Mar 2022 18:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT016.mail.protection.outlook.com (10.152.2.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 18:50:38 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 19:50:38 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.0.196) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 19:50:37 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] swupdate-img: Add support for
 automatically compressing files
Date: Thu, 10 Mar 2022 19:50:28 +0100
Message-ID: 
 <6e5722e86c9ddf733464c7484158555df707cddc.1646938228.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1646938228.git.jan.kiszka@siemens.com>
References: <cover.1646938228.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.0.196]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9019a81-6c61-495f-f104-08da02c6de8d
X-MS-TrafficTypeDiagnostic: DB9PR10MB4700:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB4700FB4B8BCAD5B139EF28BF950B9@DB9PR10MB4700.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	48vDDC8JLGyoUOedTBdPXLb+afcjrt5luD6UjABJb4fgMA+vD94tDGTX778WAtESD75qM/U2TWhGJjf5Ra9c8mCMoaZznL03RlRfYApo2ebrIl84pefdi0x9Qo4Gsf05ig9VhcEYQ88V3lNPSeA61l6ufWXu60lTbzNdT1y97MxOlk+z/+Sk/fhF46EYuf5WNfiTq06duxKGjstFySYHSPj+ouc+fik2XlewSct8OvQLwNEGxSFZlWITQ70ymu+QgQexky2FVssogNcdVbbEAxysdGY2JN6nXoo1lyDIUxii25PsoG/BSw+IrJBtJNZsU/AEkg4jGii3gYg8M0yjWT0wzYwvwYM8HdYWL4Bg8WjD1c+5MzhsYh2e/9ic5N3typzjzQ3vlB2czdnkI1yKxKFQj5u7EE06NX6lNgIr7ley3ZRON2dM35MUpLeS5OsyNtgBF9b9/ww/WrjFQGoZpDF+VqF8922Xchxksdhjr8TIXYxPqeY1TSZpgxAVMFZWuoK2t+xkrVhDmGHwThkaSnF4tVIwxm2oTpaGdWYFFVkNtG532PIuv6suP4HtSlwxXUSc+oyZCxgM6jYtzDCyLRhLj+fJxW10mO6iRq8rJjJBDG4xMRxHtFZfpQSBqIsIhZ+aYlhqkMvNlLZbMXeFT0g3KxtmZJasvPs2D3M/HWVAQ1VZEO+dXxJCTA9b/wChUqJwWv+qj6cGp2KV4+AZZQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(8936002)(2616005)(956004)(8676002)(107886003)(2906002)(4326008)(70206006)(508600001)(5660300002)(83380400001)(36756003)(86362001)(26005)(70586007)(316002)(36860700001)(186003)(44832011)(16526019)(6916009)(82960400001)(336012)(7636003)(7596003)(40460700003)(356005)(82310400004)(47076005)(403724002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 18:50:38.6502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c9019a81-6c61-495f-f104-08da02c6de8d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT016.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4700
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 18:50:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7692

From: Jan Kiszka <jan.kiszka@siemens.com>

Automatically gzip files specified in SWU_ADDITIONAL_FILES if they end
on .gz and there is an uncompressed version (without .gz suffix) in the
search path. This obsoletes the extra compress_swupdate_rootfs class
and makes the usage more convenient.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/compress_swupdate_rootfs.bbclass | 21 ---------------------
 classes/secure-swupdate-img.bbclass      |  4 +---
 classes/swupdate-img.bbclass             | 15 +++++++++++++++
 classes/wic-swu-img.bbclass              |  5 +----
 recipes-core/images/secureboot.inc       |  3 +--
 recipes-core/images/swupdate.inc         |  4 ++--
 6 files changed, 20 insertions(+), 32 deletions(-)
 delete mode 100644 classes/compress_swupdate_rootfs.bbclass

diff --git a/classes/compress_swupdate_rootfs.bbclass b/classes/compress_sw=
update_rootfs.bbclass
deleted file mode 100644
index 2a01e59..0000000
--- a/classes/compress_swupdate_rootfs.bbclass
+++ /dev/null
@@ -1,21 +0,0 @@
-#
-# CIP Core, generic profile
-#
-# Copyright (c) Siemens AG, 2022
-#
-# Authors:
-#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
-#
-# SPDX-License-Identifier: MIT
-#
-
-EXTRACT_PARTITIONS ?=3D "${IMAGE_FULLNAME}.wic.img.p4"
-
-do_compress_swupdate_rootfs () {
-    for PARTITION in ${EXTRACT_PARTITIONS}; do
-        if [ -e ${DEPLOY_DIR_IMAGE}/${PARTITION} ]; then
-            rm -f ${DEPLOY_DIR_IMAGE}/${PARTITION}.gz
-            gzip ${DEPLOY_DIR_IMAGE}/${PARTITION}
-        fi
-    done
-}
diff --git a/classes/secure-swupdate-img.bbclass b/classes/secure-swupdate-=
img.bbclass
index 1715c8a..330f619 100644
--- a/classes/secure-swupdate-img.bbclass
+++ b/classes/secure-swupdate-img.bbclass
@@ -21,12 +21,10 @@ INITRD_IMAGE =3D "${INITRAMFS_RECIPE}-${DISTRO}-${MACHI=
NE}.initrd.img"
=20
 inherit verity-img
 inherit wic-img
-inherit compress_swupdate_rootfs
 inherit swupdate-img
=20
 SOURCE_IMAGE_FILE =3D "${WIC_IMAGE_FILE}"
=20
 addtask do_verity_image after do_${SECURE_IMAGE_FSTYPE}_image
 addtask do_wic_image after do_verity_image
-addtask do_compress_swupdate_rootfs after do_wic_image
-addtask do_swupdate_image after do_compress_swupdate_rootfs
+addtask do_swupdate_image after do_wic_image
diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
index 7b7154f..97e833e 100644
--- a/classes/swupdate-img.bbclass
+++ b/classes/swupdate-img.bbclass
@@ -24,6 +24,21 @@ do_swupdate_image() {
     rm -f '${SWU_IMAGE_FILE}'
     cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPT=
ION_FILE}'
=20
+    # Compress files if requested
+    for file in ${SWU_ADDITIONAL_FILES}; do
+        basefile=3D$(basename "$file" .gz)
+        if [ "$basefile" =3D "$file" ]; then
+            continue
+        fi
+        for uncompressed in "${WORKDIR}/$basefile" "${DEPLOY_DIR_IMAGE}/$b=
asefile"; do
+            if [ -e "$uncompressed" ]; then
+                rm  -f "$uncompressed.gz"
+                gzip "$uncompressed"
+                break
+            fi
+        done
+    done
+
     # Create symlinks for files used in the update image
     for file in ${SWU_ADDITIONAL_FILES}; do
         if [ -e "${WORKDIR}/$file" ]; then
diff --git a/classes/wic-swu-img.bbclass b/classes/wic-swu-img.bbclass
index 3a09721..5e6de40 100644
--- a/classes/wic-swu-img.bbclass
+++ b/classes/wic-swu-img.bbclass
@@ -9,12 +9,9 @@
 # SPDX-License-Identifier: MIT
 #
=20
-
 inherit wic-img
-inherit compress_swupdate_rootfs
 inherit swupdate-img
=20
 SOURCE_IMAGE_FILE =3D "${WIC_IMAGE_FILE}"
=20
-addtask do_compress_swupdate_rootfs after do_wic_image
-addtask do_swupdate_image after do_compress_swupdate_rootfs
+addtask do_swupdate_image after do_wic_image
diff --git a/recipes-core/images/secureboot.inc b/recipes-core/images/secur=
eboot.inc
index 950b41a..3e6eef8 100644
--- a/recipes-core/images/secureboot.inc
+++ b/recipes-core/images/secureboot.inc
@@ -11,8 +11,7 @@
=20
 FILESEXTRAPATHS_prepend :=3D "${THISDIR}/files/secure-boot:"
=20
-EXTRACT_PARTITIONS =3D "${IMAGE_FULLNAME}.wic.img.p4"
-ROOTFS_PARTITION_NAME=3D"${IMAGE_FULLNAME}.wic.img.p4.gz"
+ROOTFS_PARTITION_NAME =3D "${IMAGE_FULLNAME}.wic.img.p4.gz"
=20
 SRC_URI +=3D "file://sw-description.tmpl"
 TEMPLATE_FILES +=3D "sw-description.tmpl"
diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdat=
e.inc
index 2e9094a..c23c103 100644
--- a/recipes-core/images/swupdate.inc
+++ b/recipes-core/images/swupdate.inc
@@ -11,11 +11,11 @@
=20
 FILESEXTRAPATHS_prepend :=3D "${THISDIR}/files:"
=20
-EXTRACT_PARTITIONS =3D "${IMAGE_FULLNAME}.wic.img.p4"
-ROOTFS_PARTITION_NAME=3D"${IMAGE_FULLNAME}.wic.img.p4.gz"
+ROOTFS_PARTITION_NAME =3D "${IMAGE_FULLNAME}.wic.img.p4.gz"
=20
 SRC_URI +=3D "file://sw-description.tmpl"
 TEMPLATE_FILES +=3D "sw-description.tmpl"
+
 TEMPLATE_VARS +=3D "PN ROOTFS_PARTITION_NAME KERNEL_IMAGE INITRD_IMAGE"
=20
 SWU_ADDITIONAL_FILES +=3D "${INITRD_IMAGE} ${KERNEL_IMAGE} ${ROOTFS_PARTIT=
ION_NAME}"
--=20
2.34.1


