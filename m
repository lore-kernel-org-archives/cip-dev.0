Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E19DC982D2
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:35 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.35128.1789636590484826120
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=O1PyU/PG;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.42, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyslruVqWDmL3MQfU1HKhyLBDmxZtYmQEQqJHFrywQaj9u/4fzATXw8YWHnz2vnSbnmbFSfkspka3IDeh1+a6eWi4CctwrKD/A5E7hlw5x5nZf0hP6Yct/mkzxArhV/VCJamd0dDLhngGb8smtTJx27rWir9qFJPdi5v00LbpTTVKG0wIolU9pv44kTJzHqpJqBgMSdHG6IbvLB3PweYyVgu2m9NRtwZ/3fJbUPvc/+/m7DRSdxkQc2J0kpaPTKkHl5tuDkw5jVWXbpapq3YoZlTAfR0RzGMVIIyWBeTslCyoPbBK+OZaW4Cq9pZ+pGPvLlbnHFus9OI/YMFXZXPYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7WLoKw6NzxMqsTkIRLBgLiiTcQ/XKEXb/yztE0wYp8=;
 b=hBIAwkqQdlhZ/FVvj8QdwEz9xO3sI7+lgObWv0D9pT+4yfr+zEj12TqJvNKCyiLW+moM5ZMuZ8wcpicR7XNhuVzdC+341cWGNRiniOnXyoPeYQrlomMWruLdok/9YnCGu++D3K3qzls5aNF+ktZgqQNM2EsWR7sc2ONj1EC08Py+UGwlaWuDzb3m2ktv9cY4femEWDETDzlyk5ku/tJk9PqdFgRIcF45lXNVs9LLQjozvNauLaK18FcyHgvP2mLDME2lNr3ngjUGiQg768MBrgY3EcxLU47oErUfGPbgwK8gaXmyyzCgBs9z6BusMm3OxOgq3rCd5NRa5yyPrXwdeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7WLoKw6NzxMqsTkIRLBgLiiTcQ/XKEXb/yztE0wYp8=;
 b=O1PyU/PG8HbPPuitFWow3H88LDfmXa3i5ue+U6cygxVpdbmOzrTrVVx1B/oZs1sIjXxdan9BwzkWQd7IaJSYCSTOM76QO3Nm1DvPAnmGUqEHknmwY72u2RNdnxmGoLSMDAL3xgpEPyIKmizIXwEImD+YR3lL9fXfhNZEJXE1Umo=
Received: from OS7PR01CA0247.jpnprd01.prod.outlook.com (2603:1096:604:24b::11)
 by OSCPR01MB14437.jpnprd01.prod.outlook.com (2603:1096:604:3a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:16:27 +0000
Received: from OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:24b:cafe::51) by OS7PR01CA0247.outlook.office365.com
 (2603:1096:604:24b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20E.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:25 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 5DC7430007C1;
	Thu, 17 Sep 2026 18:16:24 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 01/10] rtc: renesas-rtca3: Fix PIE clear polling condition in alarm setup error path
Date: Thu, 17 Sep 2026 10:16:12 +0100
Message-ID: <20260917091621.18551-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20E:EE_|OSCPR01MB14437:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 824f659e-21f5-49e5-4b2f-08df149c597b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	edfhwb/iErol9zE9luRON8YHfL5O886moNkawUS+sfK57NKJAXO0TtqUene7yMFDotaEh8f2KmCp2kZtul/gAv6PQDIM2HHQZwdCmceYWA0DFTGhUMkOy0FFBUVfqiphgPxx5Gwsdcm0dkUbzTmEwW5a/HKPyIfnEV5dSC3iiAesRvDqta54uWias/yzyWbndRFKQy6cOv9d7TKEf9MVEKBWvh+NYt1MuZ5qX16f3LdlCkm/O7NDh57j3dj9DRw+CUvD4bwWRdDnZ9Pcqnp5xJ0DmIsYiz+UZnxXxqUUNwxjPtHX6d2LF/KrEW2pGARHoMgbaMYpravGp2DNsVVuzBR2PAc5mXbxB537bOMhKFoFUEHRLis4qi6pvuU4asJauKa0t4RGqBiXgcMaCjeynHU2HNGoe54gKV7FTPAMwE1KfrvLgvFI0+ABit9l8Qa3vGCDWfLMJCyqWYIuyFIet/YRXsTqkdPCQvrdbgfx72jBjCDZyA03MaFSpCDtdik0xf3gelbFKYJVgjdsS8uqUyx9YXZwiZDM2exTjy1duqKA4STeDiAd/OZoF02lPT5c+n9rCpd/LtTgZm5P3VrsWcpaqXjoFgsvdQIkwvK0mYYdUdCfM++qdZThvcVwfkLQ0GI19SPDwZoLKj9DAnu7yE2cpEwdhnAeUKHM/7dIi6A=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	cmX2lQ5xp5yj1527+icEDe66TMAGVay73wZOXOgdNdB1DYz5fv6jaxJyeuuTOjQPK314KPubh9F/nCzsYnIiayoOXEeB/t+Sq9w4F1xa6KSRNMiYkKKKTKnMiH+mIalvAFDE8Sz/FOSqTtSBPlFpXczeXeoSlSriam3gybiZhPTdIbha2dOdTF2q0wlg59WlxcIs8M8/cDWbZ0+ER7zwovSJGceWMZ46cQjGBU0LnbZmZQRh1daT6wckH+GpyhG3ifwmtNZA5iiXjh792Bwg+WvdWd862IfbHGxHtBIzeK02RvvzgKvn9m5GIDh0FRaFsZ9esDj1VfkUwm5qMOjhdxDYuAm8tINCjCpO0uEN/TQtukYi7JQxaT2MRBHqHEChPtLZsD4+XOi9ve6nn+kDLFtMZ1GmXFYduZpK3jvMXXoJaIZA++hJOmvgBgSQNlh2
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:25.7978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 824f659e-21f5-49e5-4b2f-08df149c597b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24209

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
index 70f28980b9cea..78d2418501b38 100644
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


