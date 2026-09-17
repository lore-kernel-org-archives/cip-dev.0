Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B5C982D0
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:20 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35279.1789636450140237410
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=JupaYdpO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.13, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l39nahbl/9cUY3QYuLLjPyQF43TAyPcq9dP5LeIsINi3INYvnkEybfsm2gWOUhiWHFoDA1Pmvs4Lw6ZqABVfl0PyyFw6nfSY3SUEF6hwhPu/igM7jkB7XDlSL7DWvzSfJKWqOnLbd6KB1ivuRlQS7ddxq/baaqUSERp3aqYU10BN3u1NS6+yS0HI9lwOuOhiZskoN2SeLI78vN1K+flIG0ZYIwveBn521mOX3ZEYndjo6vbN0bz/l6fQu/pKviIVgwPCly5HTTnuQ9QeNbR8PJrgYk39EoODgnSUc2EJcA5QvAmwRM2VxKb2ej7tb++iobmQrawO0W/BXyrVuW4eNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmFi/1VdmuTna1Fv2FcvTxk2QZ4T945ojVkGmy9HUnw=;
 b=HCsDFrL3FV6NS6eYYbv59TO9kpJNkwJDtS5Eg29B/nSXXMu9J2DDOgC2L9qaVbLN2I3M25NnsVHxYHTm91e4Qx9r6FgLZg8WMJxVcKL8jNw3kbsFGzKTRODFNW69hb2A8xn1+M5Qvmea5EzGDgQMeUcjlj7E2L3PI+tG0XaLdFLFCkl8KBp7jwd1IPsb44S4Loos6KL/oCmdLcZmb3WNyTAkuRfYuyuo/Q4EQVoKXN4ZyTl7kcxnbhqT3+QiDWGBfxSbYfCyj/K1AWfV4mh//y9bRzvR9//NuPe1Ahcgm9BCHwSxjdZRU9g4+yf+wmDB2tD2e9v4nMN013R5N+ypFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmFi/1VdmuTna1Fv2FcvTxk2QZ4T945ojVkGmy9HUnw=;
 b=JupaYdpOFXT3K6sG06hrm4DqabPP4djiY4CjK2xNIqEcw0Gr3oDsV3yGYUDQydXb2xWaqlEFu+1xz+9XXl6q5Li8dr/4ep7e+ai55X7jJlhSRVd17vLVf0zbm6adsF1uf6nG4CbVyWhhyX2j/9L92HBc1goXXpr0YMs4M5mU4/8=
Received: from TYCP286CA0286.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3c8::18)
 by TY7PR01MB18006.jpnprd01.prod.outlook.com (2603:1096:405:39e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 09:14:04 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8:cafe::38) by TYCP286CA0286.outlook.office365.com
 (2603:1096:400:3c8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:03 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 9932630001E3;
	Thu, 17 Sep 2026 18:14:02 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 01/10] rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup error path
Date: Thu, 17 Sep 2026 10:13:50 +0100
Message-ID: <20260917091359.18445-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TY7PR01MB18006:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 26a985d4-74e6-4c49-2f26-08df149c04eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|10067099003|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	cDt6Jx85gTL6ErM574rM3gixDAG2zpYBfgXKAiY9RZk0pdHLArIga28Z3iklmNygst4D1EUBXdjBOGVq7E2xTOnzyiHrlC4IQFajI9zHqY9fD1vQPn403DV+9HOiHjNx3XBKeTYmbNjo2skwtB9VMe/izZMLSlEpCIUl2rWqWeXtCwTf7uLQC0601QZ/W+zIlUjNMuznOjiSswM/a58gHMPFK6HWW0lZ6t41onk7NbgMst58a36DcZcU0uy8pMe2tqNlTg0bE4BgIJY8vVXX6Cy/Kl5WCnRQXnE/CyxnsZf5ECQrWZAN5slewzMHIwJdezHy4IY4Z0iIBYhaLrMbS0p0TahWSiMv+O+rCYWqw+qWiMwiuCeQYhqVW0E+Xc7pvX0EykfP1OJEXzgxzMu/aUeAuGMbASVYuszz4KHDrWh0+baXsa2JKk94XReoE1tulK0Vxx8rgFSeX50YzjEx35Nlk3G2bJwKoRyWEbcv7P1s0CIravkETgLEJAyRsEvfL9FRFIss7OnpsS0njw/romrGYMu+qifRlL1IvFMWO4Ar2khrNe5/ObDdHwyD1mNW6D7QXgPyYqynHt2hyobmQI5AMoEOKRLpch3CPrmKVRCXXeEztCdTKa5YOqmwWKDOjP7hT6q5dmh57JyAyxDDK78tXSQcj4tIi9JRIQiP2Yk=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	136jfPnBNMZp0paEzidljVulGWC4a49/A/gUy/gV6e4Hljpm+uX5mc5mTbSKmcj7UAy9RFvFarXVna86vUi4VAVzyIh5vXQPkL/4PTAJFnUsg9Pkg9bDm+qmOPdc8hkt7IVYsBLG7vviooRc0s//sWO+tjALnbk+1Zf2ugYet2iTdjg4fvVY2gZlPIwEq98a0Ki94psRHroRAjw9AdycvgaaHAabT/CXp8XMw8ym9LYceaaeTMGukcGy6f0u8m5DNqGVLbZeLityL3OPH76nRk45/Y+K6a4faZ/GdngHtShm+L3O78J7il0IM7QnvyDFmwTvCgeHFh5CLp+M3Kkg9pqfvw5WJ9eZ2GtlfMdhzg5DBfWO/wkyQGHJg+T6dHy6RqKaRx/ZjKvWkRBtr9bIsSoUVm+bNJU2A6k45faz//vhm/oyk0A8p2NgV/8n+EL9
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:03.9388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a985d4-74e6-4c49-2f26-08df149c04eb
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB18006
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24197

commit 7e342d87aa8e6b831cf6d21ca41b1f7e032d0fcf upstream.

In rtca3_set_alarm(), the setup_failed path attempts to disable the
Periodic Interrupt Enable (PIE) bit and wait until it is cleared.
However, the polling condition passed to readb_poll_timeout_atomic()
uses an incorrect expression:

    !(tmp & ~RTCA3_RCR1_PIE)

As ~RTCA3_RCR1_PIE evaluates to a mask of all bits except PIE, the
condition effectively waits for all non-PIE bits to become zero, which
is unrelated to the intended operation and is unlikely to ever be true.
This causes the poll to time out unnecessarily.

Fix the condition to check for the PIE bit itself being cleared:

    !(tmp & RTCA3_RCR1_PIE)

This correctly waits until PIE is deasserted after being cleared.

Fixes: d4488377609e3 ("rtc: renesas-rtca3: Add driver for RTCA-3 available =
on Renesas RZ/G3S SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://patch.msgid.link/20260602192559.1791344-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca=
3.c
index 3c677790d8fab..0f9d88c1cdee8 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -455,7 +455,7 @@ static int rtca3_set_alarm(struct device *dev, struct r=
tc_wkalrm *wkalrm)
 		 * specified timeout for setup.
 		 */
 		writeb(rcr1 & ~RTCA3_RCR1_PIE, priv->base + RTCA3_RCR1);
-		readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp, !(tmp & ~RTCA3_R=
CR1_PIE),
+		readb_poll_timeout_atomic(priv->base + RTCA3_RCR1, tmp, !(tmp & RTCA3_RC=
R1_PIE),
 					  10, RTCA3_DEFAULT_TIMEOUT_US);
 		atomic_set(&priv->alrm_sstep, RTCA3_ALRM_SSTEP_DONE);
 	}
--=20
2.43.0


