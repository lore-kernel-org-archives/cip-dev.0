Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4C4C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 06:09:50 +0000 (UTC)
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.57])
 by mx.groups.io with SMTP id smtpd.web11.23605.1647238189291369162
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 23:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=zphyFkKs;
 spf=pass (domain: siemens.com, ip: 40.107.1.57,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bahOViVU89/CUpmXR3ySQ5HyuKag4hLRCugRgcK8FhsBFHWrOPk00Iib/ItMiyYwSRTeeRRH/JrHHWQW/aokLHwqCGClltbx28K/mvfP32cGoVhcz0y6A+QYA+1MJbuurqQ9LCHkAgvJGO+zNZW+KEHfq66tXpYSds3fKK4k6ZevOn26Y8T0ETCD3vAIqC9hECwh+ncz4yjOgvTfCE8JxZqGbIwo/MHbJQIwrtIIH1PIZ4akx0Xsq+MWhuKtNbD6mG7FB7LSvivOXIp1R9XmZTQ/RYCqpB5R2X1cZOMTksx7dN3SZ8t3D1T80AvxamVcqC4LNK4fYA0VegwE1vTzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=slfEE/zI9DN93qwgKWv9QxRg2d/SPBvYbMh9/0fdfQk=;
 b=fmIFbXWKstHEcuL8r1HQiPVuC2cEBEDoRC2UkbNivWo9J0bRndUBiaIVKmSMNaH7UrFD2I74ds0yNnIWjf5vySUWhvCfuluVjGFrTGRySk2W4K55hm3ZxOvDHSbsrZd+C9bon6SxIcmho+MVsS4U+WCgjyzmT7uTcPgQiRDaN4M7VuTBmVuNJX7u0aVkDtm+pKW5ON2lQK1rqLlq6gFH1gMF4sPMyISSoWcj55eWUk7+2fZAEJTt03MzZ/6qinGkSA4UAE1IR+DZAyqTAo5o2rOrTCBT811tDN+cBwp9/6jRFvM2FlsPDhkaYWtEHQFS36Ak1NHFGYymOhefVDSSPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slfEE/zI9DN93qwgKWv9QxRg2d/SPBvYbMh9/0fdfQk=;
 b=zphyFkKs6My/NEsj9J99K0jmAE+kKoHySKyHDFUGonufRCdEkcZAjbvm9/x7gGsDLFTu5dGaJeYnEzlP+H9G6+4H7ZDZDRbMirbJArXBpE34NAX3Y8xuR78hyhUX3wL3xutvfLZ8Q2MtERoL0IxXQIXeFuhKXOpHWu8M28Xkm66PhycTKc71JtcqjWHBb/+zK/jxmG6WX/2d7XBDmVJL+JPwzP9n9cSuqxXElDRT8S+T26Ekws0V6FFXxCPV9ZQBGJR8feUok6ngL9CwqjrZTky7rZ47+yaiPb0XanbayMTazWGdiPc5CBG3BSDVGsTbFhFDvquyXJxbRdmbdExt6Q==
Received: from AM6PR01CA0072.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::49) by DB9PR10MB5259.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:33b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Mon, 14 Mar
 2022 06:09:46 +0000
Received: from VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:e0:cafe::3d) by AM6PR01CA0072.outlook.office365.com
 (2603:10a6:20b:e0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Mon, 14 Mar 2022 06:09:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT089.mail.protection.outlook.com (10.152.3.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.10 via Frontend Transport; Mon, 14 Mar 2022 06:09:44 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:44 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.72.30) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:44 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 6/6] linux-cip: Update to 4.19.233-cip69 and
 5.10.104-cip3
Date: Mon, 14 Mar 2022 07:09:21 +0100
Message-ID: 
 <961e277ad70f70aaf2d09e2b05f8242ac622c96d.1647238161.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647238161.git.jan.kiszka@siemens.com>
References: <cover.1647238161.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19431344-5386-4b22-6ebf-08da05813c7d
X-MS-TrafficTypeDiagnostic: DB9PR10MB5259:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB52590C9D33A9FAF9D394128E950F9@DB9PR10MB5259.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PzVrJf32MGntY8Jkr3dC11yH6TJmmsS1//Ar+oR0PryzfY2N3rQr7H+1jxuPYopucKq4X2p1pUzc/zzpVvymatIhM/69Ynyyv4KQOUf5xh8wxKLl37Yz94Hr1RFMiH8ywIHijx5w/cTmMvDtVWkY9g8O5AX2Dm2BDsQ0CHYO2RBTwUyfpoVMk06ZGPHNJj1IjSsC4oVOTTToEMycgARnvUjc8ABnbAQdX9x6oln5S04TlPTQRCfkH7FDsMv0JbRGCzjRQU0XqMbS1Y6XtwrgRxC/9CYmswSCV8ofHhQzslANOSE+eSXcPwmFYaVkTaIJA9hNQx1LMwy2VxXzdlF8oDgicPl4F9GPqW0QvIAmvScNfrzDV9ef2hA/i/nmZExBjV4bhgtiACseiPTB5O/C0mX8LIF7wpoc+x5EYDO6BCaSWIOM003uQYbl+VHd5ntQEADNWjW8VS3IaADG+fUamXS1D4/a69V5s+tK1eQ0QKYyBrbl2vwt+NDA4T1e6ZPNGlySUs+VcMLW8hMrOUJiWm0+PNKe0eERUJejQs0gXuqDcV6oSylcU0JJ6mTu3GddaqbkNpPJ1DeGrLZc0wLPohNV5o9pVEsVOyqAESc9W/uc2B7D/Ljzq/7bEkyHvEoWAilYTcQzrzX0qBrde4QAmSOnNcK4kZ/ob22aSm1SmKKJ6o5enmvVchNfTFw9uq7/
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(86362001)(5660300002)(508600001)(70206006)(4326008)(70586007)(82310400004)(8936002)(6916009)(316002)(8676002)(83380400001)(40460700003)(7636003)(7596003)(36860700001)(356005)(82960400001)(336012)(956004)(2616005)(16526019)(107886003)(47076005)(186003)(44832011)(2906002)(26005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:09:44.9651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 19431344-5386-4b22-6ebf-08da05813c7d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT089.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5259
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 06:09:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7711

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .../{linux-cip_4.19.231-cip68.bb =3D> linux-cip_4.19.233-cip69} | 4 ++--
 ...{linux-cip_5.10.100-cip2.bb =3D> linux-cip_5.10.104-cip3.bb} | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename recipes-kernel/linux/{linux-cip_4.19.231-cip68.bb =3D> linux-cip_4.=
19.233-cip69} (60%)
 rename recipes-kernel/linux/{linux-cip_5.10.100-cip2.bb =3D> linux-cip_5.1=
0.104-cip3.bb} (60%)

diff --git a/recipes-kernel/linux/linux-cip_4.19.231-cip68.bb b/recipes-ker=
nel/linux/linux-cip_4.19.233-cip69
similarity index 60%
rename from recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
rename to recipes-kernel/linux/linux-cip_4.19.233-cip69
index 91ef5f6..fcf621e 100644
--- a/recipes-kernel/linux/linux-cip_4.19.231-cip68.bb
+++ b/recipes-kernel/linux/linux-cip_4.19.233-cip69
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019 - 2021
+# Copyright (c) Siemens AG, 2019-2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-common.inc
=20
 KERNEL_DEFCONFIG_VERSION ?=3D "4.19.y-cip"
=20
-SRC_URI[sha256sum] =3D "f39146555dcee1e9f76c4b6e000e0d6f42d4a6a56d95d415ac=
1442b1f99d0465"
+SRC_URI[sha256sum] =3D "cfb579d34e8de9129312426bab3b955bf7ea542156ea4d6974=
8577869abf18cd"
diff --git a/recipes-kernel/linux/linux-cip_5.10.100-cip2.bb b/recipes-kern=
el/linux/linux-cip_5.10.104-cip3.bb
similarity index 60%
rename from recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
rename to recipes-kernel/linux/linux-cip_5.10.104-cip3.bb
index e2bb298..2c23c6f 100644
--- a/recipes-kernel/linux/linux-cip_5.10.100-cip2.bb
+++ b/recipes-kernel/linux/linux-cip_5.10.104-cip3.bb
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2021
+# Copyright (c) Siemens AG, 2021-2022
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -13,4 +13,4 @@ require linux-cip-common.inc
=20
 KERNEL_DEFCONFIG_VERSION ?=3D "5.10.y-cip"
=20
-SRC_URI[sha256sum] =3D "0fe532c7900299888160a740ed70c1daaa9536fe545bee4f75=
4043e1e0a09c16"
+SRC_URI[sha256sum] =3D "7c2a9b0d7450f57909e4531b6c4fdc395c865140005596e0e8=
7c9669047b3cb0"
--=20
2.34.1


