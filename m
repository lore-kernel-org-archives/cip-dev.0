Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94092C433F5
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 07:59:36 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.60])
 by mx.groups.io with SMTP id smtpd.web10.27692.1647849575205898263
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Mar 2022 00:59:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=EwGHI/nO;
 spf=pass (domain: siemens.com, ip: 40.107.2.60,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJeyKh/wUCTY37Vlqn5IAXyaO0eS72VJ1HgtYs9GDfkQa8Adw2H6cn1g6v9kb4Cp4ME2JWSchE0Dh+VaJthlkJ96drz9WwUeKD5hhXYnZdUUyX2hwRwd0vNaJQDuS5ashWX45YRl+1eFhImEjVuMPQ9oMuXNvqgDsZPkXALXZEgsW4v74e7Sr62oh4ZfJPF93yCzQe+zguEG2x7piFu3RTZ36x0N9k9DOCBFjF47pJ0mR0wscMefl0JjQtskVfmaovmFLbYLgbEenO83zaZjxvSSjGKyqqjbFXN1Zx9i6txZ8mz4+lZTyhF3Qp82B5VPZUZdClQTIoIDWMFEtSTNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdEOK5u14V+axuIwNL7gU2y4kbynl23fslWgU+3nMdc=;
 b=bL964GdiPPKfifTdAQ3I2LORLyeq3ss7kbS9NkmcAKJAghOk2gQ70k8b1Y6xUXE7J7uPQV+gIb/KnrB+fy6tGdzUMOD1Z2C3LU9ma237L2P5Sk0W9y5sRd+gxfFPaHZv9K+uBSIm+TG//uNBtTYx0X7AntZXYmMjpFlF2mi4+pDZe7X/bKkWmeaPWBqw8UXcSbKsJKzBmQ9A3XRj9AZWSUSUVy98Jqf0qY9kJt1aVd0bfKbfB4xzdf6LeUqQ8mqhPAWPQg/jXlvTdLXYBykgW9clrN0p6TLFFJUg8HVRDHBXXQcqph+dhe6QmyPGGJ1d1IqWKFTzQkwFMmS0tHlXog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdEOK5u14V+axuIwNL7gU2y4kbynl23fslWgU+3nMdc=;
 b=EwGHI/nOlI81V2pTK5X8UbGS+mMngmFW0aDeT74D7TrxoDevCewKPacWye/SytopVHRFFsFCYophvljfvh0sao2fL2VbZ5j2fG2tY4MhB6apC8sdv9f/1V6MgtiZUqafRzOgqbs35fq4+QcDo1LJNotQqi6rxdPNKAh+xsU/Dkg/baq4/Yfo7DCy+mhFk15P9u9YrdDmZ3zRvrARk4nESUIIcY1iOgb3LxBmpwhMGSG1XrFLx/brf/p10ay/mo3xsQWSoGrtBpv1k44ggst7TGGNaigBOae+i/yTGJ+msrmYwgJ2smIgbLy6Dz42Bt1ITlQxJiboYP/52JFfzpm4Lg==
Received: from SV0P279CA0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:14::6) by
 DB7PR10MB2345.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Mon, 21 Mar 2022 07:59:32 +0000
Received: from HE1EUR01FT106.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:14:cafe::b5) by SV0P279CA0055.outlook.office365.com
 (2603:10a6:f10:14::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22 via Frontend
 Transport; Mon, 21 Mar 2022 07:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT106.mail.protection.outlook.com (10.152.0.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.10 via Frontend Transport; Mon, 21 Mar 2022 07:59:31 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 08:59:30 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.32.40) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Mar 2022 08:59:30 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 2/4] shtab: Fix PYBUILD_NAME
Date: Mon, 21 Mar 2022 08:59:18 +0100
Message-ID: 
 <9cb3eac0524495aeb5249338964d9c75bde2c1f6.1647849560.git.jan.kiszka@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: dac07ccb-c7e9-4fef-9088-08da0b10bb30
X-MS-TrafficTypeDiagnostic: DB7PR10MB2345:EE_
X-Microsoft-Antispam-PRVS: 
	<DB7PR10MB2345627B140C5F9C242AA5D195169@DB7PR10MB2345.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	H0tdts2GZA5LzM34z/bC2Ba0IumhG2yPC/xiZc0bSaePPzdkzydUdUSF1o8CVS+CbPN3DBAAAuhkLmEaf7RLorqZqge00ghm/LRleALpyoxx8QDrgLSdYVOBkzILscPOlos3fjfFcvo+HlW8D3d7+hX74fe++WA46Ou2CfL+nNhwUbvVHYZz6WLwk2FRWasxsArojKoPKUuTwvNcpJpfnh/ToySKRsb6TCJEDwOy1m+Y6lRmbZuk+aoqG9crxkcpWhcvcKnwywZ7rjcdfPGV+vTs6Va4zg7A1Ij6gLRSsgqf8NnhTi6GCi6+mjbSTumMrP2ySagSlqB7q6/QfsSsseAw96mQpaxP/gzL/Zok3gTp31Z/rIvj/E+IX71NHOAg4Eu1vgCdgGfrwPtg94Eip7l+HCRPt12McU4TVGY+jJcNUDVHiB05lCLZoT7/US0r2nKg6ugH1odsAp1tC3G9R6jcjnuwqjauNZZzkIK1aC7R2r+dHUk/III2nvKBiJ13SyTcka8II2kg8a5yo7wr3vb3uVEtJsdd1TPnXiI3qyEtJGssZoV5+OUpMq4tG+EWGkdf/Sp3uOi3V4R2dP/95/0RPRCZeDeVmRRqqOUY1HYD9goueHn3l+gGDbToWy5OgrgcVYC2o4ofR97Z9Ar5IpElklPldKrCFrHJy7EJyLCSWX9CH4OxRTiKa9qlpltOU+dl4mP+y65UlTShipoc6Q==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(107886003)(82960400001)(356005)(26005)(2616005)(956004)(81166007)(186003)(16526019)(82310400004)(36860700001)(336012)(83380400001)(47076005)(5660300002)(36756003)(44832011)(4744005)(8936002)(40460700003)(86362001)(2906002)(498600001)(6666004)(4326008)(8676002)(70206006)(70586007)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:59:31.3469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 dac07ccb-c7e9-4fef-9088-08da0b10bb30
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT106.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2345
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Mar 2022 07:59:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7782

From: Jan Kiszka <jan.kiszka@siemens.com>

Copy&pasted from meta-coral. Seems to have had only cosmetic impact.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-python/shtab/files/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-python/shtab/files/rules b/recipes-python/shtab/files/=
rules
index 43ba686..2dd07b2 100755
--- a/recipes-python/shtab/files/rules
+++ b/recipes-python/shtab/files/rules
@@ -11,7 +11,7 @@
=20
 export DH_VERBOSE=3D1
 export PYBUILD_VERBOSE=3D1
-export PYBUILD_NAME=3Dpasta
+export PYBUILD_NAME=3Dshtab
=20
 ifneq ($(filter nocheck,$(DEB_BUILD_PROFILES)),)
 export PYBUILD_DISABLE=3Dtest
--=20
2.34.1


