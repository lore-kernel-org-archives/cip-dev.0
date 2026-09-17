Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6880C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:55 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35320.1789636605693320667
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=v3Zmmwbx;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpiJdRHzM90MlTclpxA3W5JSTv5gnWoDWz5n4aTsu0r4fxr1+kRQwRetuEXt6l62HeurWS5cdCMwqJ3kY7hqLsqkM0F1TF7X3U02KCq9NW5noXXyYEKyCfmJCyS9tS4uYucMOv8TbVDM1P/l5QU6ldKavk1ix+AHejTwLEeep2l5fl/Q1UKkPREYIJURHf9Wc4KvSSl1w0Y2dhyb11lpVfsNWYtFYLrYfdnjK6EBjCnayAqpL5C/lZyMCYIsu64QXM7xIV863SoSqGKRtiDKYrXIVCo8t0O33CfmIGGb/RwzG9sHONB65rpnNiDLuPckIWzlKrPIqUl0ZetrxqPr6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+/cgWFlR4u4hExfQl/UlkdPr8FUZ420J9r5QC4TWUA=;
 b=LN4tSRg05x68+Gx6QPzIm7GFlcDdyn/1iSSMpJg9cFs0qvmlm9QyFnXpglDcXhJvgSpvClhHd1MY/Z4d33JyEz65mqEisHYYRIDcoJ8zTNO5cg8UrB4VDRrJO201F2Zeoqteu1NmUA4j7UnGkMIqwFVOIhYuTesMowtbq+d5HYwYf8ALTQnAymlCAAmvpN2NHvJCMH6KVAwl29EYSag7BYSSJUBH1iw3+/jUvrCWBaNZDQciX61mjXKWinJJY7tgh1bDlDZhhtkfOc6NjBzm2CyAp2fL+4xyMIU3FUlWmS7+8vicRlHSf6/06pnG8QJXgW0T+CfXraYu6q8AwNo6rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+/cgWFlR4u4hExfQl/UlkdPr8FUZ420J9r5QC4TWUA=;
 b=v3ZmmwbxeMHZtjCdx59ejxlRRBLX7/AUCj3vLQ0Oc8jFPA0fcxAwle919hIFfO+ExiR4DS0a0yoaEwRxPWICvT9MW61Y78MnIjPM33t6UyPzevir22cZq63wsT0SVXqxmmyARFObVxT0Q7VkGLd+rcXulSo0FATPGasIwilyukw=
Received: from OS3P301CA0026.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21f::10)
 by OSCPR01MB12723.jpnprd01.prod.outlook.com (2603:1096:604:339::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:16:41 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21f:cafe::38) by OS3P301CA0026.outlook.office365.com
 (2603:1096:604:21f::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:41 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 315B230001E3;
	Thu, 17 Sep 2026 18:16:39 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/10] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Add alias for on-SoC RTC
Date: Thu, 17 Sep 2026 10:16:21 +0100
Message-ID: <20260917091621.18551-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|OSCPR01MB12723:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e0000843-ecda-4fc9-2542-08df149c62e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	rFA6gwD6stvI3BseviWCjjht98MbBnvl0B475WNWnCUHGO5Od+Qby/IT59/1CgvJB0YcgdtatmO9wj92iJT1RwQl1scqegCwBg3Cjy0mvlUPn134ACFVRDy1rXjSpgD5XeoFTR7PKT1coyHlZMYTu9pK7MmwumzI6IW8HHqvkv4WDMdZiJu9YyLDj/zQ5q+hHxlfPS7BYE9Zg9XQH+gIccU5G66Ir1+jFVBpV+7zTOI+u7HEkWHWX7YpLbp3gIgHNTHQiM/OmKjauQ8MQ3/mYKt4wrNOHXAMCxcvHKZkndXOoyYmkfHgEQ5dSRWNYZfTyJe+gQKpF1+icCTJbE3R8pGAtAKNkJw6e/ElF5rq79JQTy9moLRqNT/bhmXgvlj4jepKntBTQ6H0A2I4Pzke69hxHYRpDnLKbyW5mFxxIzLqVAuqvksh33JjBkQPRrIWqvku0A+G25C4Pl+YAcoJsudKf7MwO6RI90teRd2WmDwPVRuTEAaMMI3jhyLF8wJdxyJyqPLKuV7i3BGUMJb05HBysxGK7AkJnzyR1ljHerfJdwu2mxcc7xwNHgnR/z95FfOaEIp5JQgR3pzi0YWj2Fpz5y4/0MTIVgf37OkC7wABhG4p7fAV9/bs/XrcMR/ccYFl+c9pcqq7nt+kS562oA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	bgVm28eIS92WgKfANwciKihxkhzAwWhFYc6XWbklURbYvUquBoCnrS0B+nNZtyiZ/cr8d5yOXHl+3GRhYE/a1hr00XpE2Zvt14Pg0Ai0j0R2fD6o6pACT7oTsUEri20CQW67i297oUT738aL0pSzy71NOQUo6/cjQWn00+ksI66dbZBGs8s/rUXraOIUnduFFwY5kcYJVUaVtMZdU63pKFG8LBh0wINJvKK2Ez9lM8i9ozFO66aIMI+W7ij49MsvYQGHU2Nao9ORuQoqDAmWxpZfshIXECoYqaD7z5ID+387kBw/Mj6M856n7XUHvfrW8AHIZzgpCwQ8rkZgmSfz5jI2GqtkttZTh2lQvYrnBudbelh1xZsGaGjQL9U4Sbkf1gJivlvnFzYYOn3rjWh3UWWjjln3U0dID0MC6L3XKghAuiaYTetjowLFsw1halXz
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:41.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0000843-ecda-4fc9-2542-08df149c62e6
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12723
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24218

commit 8fdfbe0f114fd406a1e98d185a8f9e1d193a6526 upstream.

The RZ/V2N SoC provides an internal RTC, which is enabled in the DT.
The RZ/V2N EVK board also includes an external RTC in the RAA215300
PMIC.

Add an "rtc0" alias pointing to the on-SoC RTC node to ensure a stable
device numbering.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260506155804.3984418-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 914960100e659..29364343048cf 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -26,6 +26,7 @@ aliases {
 		i2c7 =3D &i2c7;
 		i2c8 =3D &i2c8;
 		mmc1 =3D &sdhi1;
+		rtc0 =3D &rtc;
 		serial0 =3D &scif;
 	};
=20
--=20
2.43.0


