Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116AEC982D6
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:21 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35089.1789636450932208374
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=q9gD9k0r;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.40, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOcuw7WRcxmI4KiFXTtprHYmy4Nk8dOSTEjiZtk5Fo1lGIpVMsq+/Wu6+ZgVpljSeqBOPsGG2piKY7fVReWOnYjw8F0XazAyc6X4FySUP1HAMVlRjeA/2ERxTNdtFSSy1lroyFUin/RDM3GzjzkbkHdMvs1MTRC60aUhzj2A1TicZRPRKqv0Cf/1n5U5NSduB15lK1qB5wQeXugRRw8iYybFMCk+am0vEQkeGHaJxmW8tkwYGbvrsa/OAW+Rw4rgRPdgXAN2DcfwclrDJKqBbpDSWs6d/lhlZVrh9D+zgRcM/6DGj+TiPYhLo3LVayJvY6hAPLudXg9bFkWvyvVopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cFtT7CDT42HbxiXQMJ3p8oX+NedV2W+B2RnBox07SHA=;
 b=OT1Z1baxoyRnqieoeXWqiurpYou7Z5VJpnTOB9MseK59zVFQJ4epMzeX+abuJF9DP74KNHx5d58XE0n0k2JgG0tBPPO7nWZFhGCreZK2lHx+Wtkvc7r8bdTmz8NTaiPgkJ9A77QLdHNlMuOP8Ew+D5ZJYWVfbo/2RTcVGGd6quJvMYU7pKtk2PkdOlrzs1I5VQAnDXgkAY54LmGUP2OkmwiEHTUZlzwAzBHD+nrbwYaBiOKaUhjXqNmNiSLOLplwrWq26NVBpIVMv6xoI/YiNr5Q+eVNY6oVZm//QqjhD4BoPboQJoq+hy7RG3RlKyXu/9ekDnu6TbtCUCnfvSpMjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cFtT7CDT42HbxiXQMJ3p8oX+NedV2W+B2RnBox07SHA=;
 b=q9gD9k0r6pMhm0V3sxrJsVJ3DfUvF0MM18/2uwxa5S9o1STlZIC4SOrytUDPxJRurMWg2g0UmYOY+ClFDYkmUd/4/XCgGsXpaQqSQbFHDHUv0peTPLcCOhLa+8w0T0JCoSQwG0C89n2pcW4djJibk4uhxAgD0Inxf7x+Xt2eIr8=
Received: from OS7PR01CA0081.jpnprd01.prod.outlook.com (2603:1096:604:25b::20)
 by TY3PR01MB11573.jpnprd01.prod.outlook.com (2603:1096:400:375::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:14:06 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:25b:cafe::71) by OS7PR01CA0081.outlook.office365.com
 (2603:1096:604:25b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:05 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 5A43230001E3;
	Thu, 17 Sep 2026 18:14:04 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 02/10] rtc: renesas-rtca3: Check RADJ poll result during initial setup
Date: Thu, 17 Sep 2026 10:13:51 +0100
Message-ID: <20260917091359.18445-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|TY3PR01MB11573:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d961fcd-a35e-4695-fd38-08df149c0621
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	Ez8H0tm4ywc9ekW1NPb+7B5aupLiGb17645pbvQou4l6PHdkHmFXIIUhKZLrGeFpNewOj9Eq4IxTzet6TACa+LEexX/lq/ELyHO0/LPmn1Pqgc5lijXhGomb6GkyyeSZwFOyyPEVZDa+IVetf1/AOldK+arP1Eg/4U8iaiLBFv12UwT1/SmIkN3wlTPA/Q84aigC8PkTkWQRui04QczoVv4IDdg2icttj22LMrjJXE3vqaz6GvdJU3QqlJuw7E/MFywBerlCVoEuPsQO0uc1SAHTQby1NOhV4Rg2MUSFX3+lpOzV0YgReGb3DfT7X5mMNuBDIiyEONxeaZtWvrT9JIYZY8zQ9Nr2oVyE6irZBFhe9M7W8nCTcqOQKZvstkyJO4uCdjpupMJbQ0vqIaggHpzJgbMt8wGc7cgWEQzJR72s3FludAmY0/y5fsf46XC/5tvPOsGlimtrjMkuqAdI1Z67aXiaGDCLeu78NTFPG3tOmvZkb5Z4ovV22MdB6WM2tfOQzVkDZ6K5JujC3rBgat8n/YRn33YQ2UlUte3zVGZEM4KChdybP9qYXFMjPntcn9YSBu3GOCjKTL8UoQGh6RLlflQXugGkxToQVdd29ANF1yIsgCMZBE+Mo2oZm3Ho40JvMhpWr8S9apazpytI7e/4sT59vwxRtMQBuBjq5PA=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9157UQXbn3vwwx5wpzwxCnC4UrIkQ6m//I1X/R0TdfqaIDKUIZk/FVvl7Y8OA7yeDnA/WVbXed0dy1HUPjlyykklgwZWkCH6JcSLLvVHJQJdz50XnZsAOTrYA9gOPjUXLvegIkdKb2zoZXpuFvo0dYznzC0n71wufmslOZuVsCXr6KQabCvvR9DOg1RWA44jwMAgZk9NeJOmT/1RRF/M7NYAyBBwu+mR3t/1g8ehKp0gHpcZON0bh6oNrPoFY5de/me7nX+6ZpVASc+O1seipYhHteasCKpbm3geIR7vRCgMttUt2uJDZLCknxZkfo/8i7C1XCVUuViUffIY8xEWewRfDXLmCmtvKKHBzl4esKqUwYIWUQ0DqhWRxbQOIs3dpMlhWTAHY6tty1tZO6GZ+Cijm4vjtbwpILvdUZJY7pjIPTdv4Z5rXLTsfhs86KYL
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:05.9603
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d961fcd-a35e-4695-fd38-08df149c0621
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11573
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24199

commit fafb016d081200c7652e84202f8ba5951e659a53 upstream.

In rtca3_initial_setup(), the driver clears the RTCA3_RADJ register and
waits for it to reach zero using readb_poll_timeout(). Check the return
value of readb_poll_timeout() and propagate the error if the poll fails.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://patch.msgid.link/20260602192559.1791344-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca=
3.c
index 0f9d88c1cdee8..cbd040272aa91 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -634,6 +634,8 @@ static int rtca3_initial_setup(struct clk *clk, struct =
rtca3_priv *priv)
 	writeb(0, priv->base + RTCA3_RADJ);
 	ret =3D readb_poll_timeout(priv->base + RTCA3_RADJ, tmp, !tmp, 10,
 				 RTCA3_DEFAULT_TIMEOUT_US);
+	if (ret)
+		return ret;
=20
 	/* Start the RTC and enable automatic time error adjustment. */
 	mask =3D RTCA3_RCR2_START | RTCA3_RCR2_AADJE;
--=20
2.43.0


