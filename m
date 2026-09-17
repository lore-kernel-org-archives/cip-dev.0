Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D05C982D8
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:45 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35131.1789636600050441440
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JvtoDgPM;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.40, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=do8MlIj3G+kg2zsjkHgqPNqp3qcls9iAg87wLFwKx6xiabuhBadlEgvb5pS2jjW1NJje3GuAsBO97MDUq+829tkcwrV0dlqHN4PhsybZGKVGRRY5ie/6nySekyq2zn3EZcBNPt/zkhW+dEWhO59jUNz1QiAwRTqTpCVymAXwgw5G9wvb77xe1x3+yxs3bKDdGANyDlD1BVneyNvY+ypi3gqkwhGx2rCtc65JQyEYsHv3J+kviJI+C+JkT1anhtAGd6Jt2jjLKJStDEOxpH5/PuHCaEIOejumJFbK290k+Qlr0f2XulKg4ISemdr6MO7W8tifXLyFDCc3zR5DpPe1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3umZ2wlHJOu512bXs72F3fWjRdX5rVLonlIKJ1xPaA=;
 b=dLLvGs+MK6DZ7JE/m0Ofq632YZvyDHbDnPDgXI2BZZZ94tnpwG2X/9hcMwhHJAb0zGMSmoraYEjbs6979rmvDwmD9x1b6clsDLHYS0ZaEoqe15nB6HBx/3h+xZO7tQootyBqpXHxzKJXjmqulv5Y5tC9/hBkUzxyR41YKBkX6midR8mG2i1384CAjXSSD+rK04q4THnIisVi/p317UifKIwpbQeY5elPnMDtGavRKmmIRv9BB2FR65luGtnvBax/NdAE/I6amFAOhkwCqB03u+BozGbDaGNHCijRAfgXhwXxM2q3lnU5hIaeRnGjo1e9TdkRaEYX1IT+6j2Tv8N6Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3umZ2wlHJOu512bXs72F3fWjRdX5rVLonlIKJ1xPaA=;
 b=JvtoDgPMklR4y+VC2kTbbUMQT65zLgfj5Oabbczi+sUxxkPCyECFWwwfAQ88nFGkz6iweq7v4Gar6Ff7tVP2lR9ne/kA29cuB3LJC0y++BnGFT2IRkgMvJYhID7TiHJHHbXENylVvgGHMbGO0oWbiztM55P1DJmOIXhf+vEutWg=
Received: from OS7PR01CA0165.jpnprd01.prod.outlook.com (2603:1096:604:24d::13)
 by TYCPR01MB7990.jpnprd01.prod.outlook.com (2603:1096:400:187::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 09:16:31 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24d:cafe::a) by OS7PR01CA0165.outlook.office365.com
 (2603:1096:604:24d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:31 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 9094D30001E3;
	Thu, 17 Sep 2026 18:16:29 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 04/10] rtc: renesas-rtca3: Fix typo in rtca3_ppb_per_cycle documentation
Date: Thu, 17 Sep 2026 10:16:15 +0100
Message-ID: <20260917091621.18551-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|TYCPR01MB7990:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7f395349-766a-4578-a61c-08df149c5ca9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|10067099003|18002099003|22082099003|56012099006|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	Ybzu0x6JSQAxLWwHcHcqbh+1o+vN6B/wmS4EQqXQrCF6ZisTMIy3Jk3qOE3tgtlAyl7fL/XEoMQ1/Xu2+XvZZi8rvNSYpWu5hB7ZlxAHv6t2lvINUX2b2J7uXq58wpHKmtx0xDEtUCrf898RrbJ+weCqfjJY4tqP9dO4aQxXi5ZKM9MbNIbuMkgTnWGBGUcxqE4X901nSkhDxFfxQXPlJiQ6BVad/3ZFHSo7pEoaFcW7S4QXzK4j3yUvNyUrv8XwD8AFePX5eI+HAbOdKsMrt1hFMkQJWG0WW0scP32IoaH3lEXp6e8zoVfrhmE6JcPWPnmaP4YBmfjN+kFa5A+LwD8s7jOqbC4XoHVI5DemIL6dUnl5RI6/HPuUKE+LcBirnroC98mfAawnqHuc8VqeitaQo3UfZMzofMS0Vma95X+pYBA5wn69WF1YL2Vg8Y22qQOtZ/Hmv8cLwbbX7R2isC4xYdmZ5sdhPV4vBQrHV7dfDL9meJ1LP1lpLgNQXyk8JU9NDJPVvzLW4OGoq9DfV4jmh0O6FTp5tQ8BhXpu0kpfiDGxEES2MiPsHcvze7qW0yBMUX//dexXgqyLiJLZB7LVvuNV8Poyi1uYUocvhcqyzwuOsI+XapnoQDr9tmUanaQx6jh7s4sYlcFbwr+0Kg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	OtpDUWOeqFR71gVIge76bmHkwK7TBBZeuBmpatwJVJYH7rdJ9NQ3kuCRakkfrLkcFHbDUPxDK3ICfzsYKs1OyvxFu4CtIwrpCxPgU3Z44QsO3WNNd/2eTDYJtFG78URfQ2YSYO9QMrZ+OLxqFcjdLQwANAtkYoqJ0MDLKXMtHo99a7AcZ61dpvzZUxnzgF9X2104RYc2gw8zGKDNUre5b07hJ4/zKrXS8mBqae+bL1OeFWccINZg8O0uhHErgFEg0U17BmJYDVHys0WftaOYqvl32ZFCxrL+D5CE2PTl4kUY2marGY+qIMFIlPXOyuE7KeYEG88Fmw1JJ7RsU1iXvaHqtu/ew6Vk5Fo9HTeCsxENfcs8IcxBnIIWRS0AxQuSTX8bZdqYuq6GqqJapVHtKj5+hMTc0pV5iZEdQm+y4a/aS+2GzWrcH6BQVVUUAQhe
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:31.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f395349-766a-4578-a61c-08df149c5ca9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7990
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24214

commit 9fb12656a7a5473b1ce46e27f78e92e5e8df7c58 upstream.

Correct a typo in the kernel-doc comment for struct
rtca3_ppb_per_cycle by fixing "adjutment" to "adjustment".

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://patch.msgid.link/20260602192559.1791344-5-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca=
3.c
index 67ef344562884..ea349dc1084b8 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -103,7 +103,7 @@ enum rtca3_alrm_set_step {
=20
 /**
  * struct rtca3_ppb_per_cycle - PPB per cycle
- * @ten_sec: PPB per cycle in 10 seconds adjutment mode
+ * @ten_sec: PPB per cycle in 10 seconds adjustment mode
  * @sixty_sec: PPB per cycle in 60 seconds adjustment mode
  */
 struct rtca3_ppb_per_cycle {
--=20
2.43.0


