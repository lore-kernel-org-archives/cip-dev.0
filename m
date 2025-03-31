Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4E7C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.48])
 by mx.groups.io with SMTP id smtpd.web10.49054.1743417963420854391
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QdUQCUGf;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jOQrh1Mqe6EP69UIwziNp5fBxnC2qx3q+TcQlq4sISDOWrUyEuYbRjc2wNqo6G3fkkCw7F2FO31oQWK81QkIEJwgq4b1wBuQMY78FLPG+gIkJvv4I4CEXaWXR3iw/SqnoAK3lfMd/dNjjm4fuT3CHAcRahmemMvpCzbVG723SkjGHJ/CFT4tHuMVHSJvWoJWUKCR0dsO2IjHqhEpnqpPSfMpyXpiEbPrlXmZsKr/rq2Yp0w9IBlZjOSEAeb7dDbUTWK6gd+wfSORdtVEVkabBheEvU/kOgggYcUjZEzWv3QSMqxi7kKA0PjI7rUvV1TjcPJE+XUomPEacplMUmHMcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJdDsx0gpxNztSPhjhDmJzhBGAbD2kx7tnLry2gOd2Q=;
 b=FviP8Wa4gZZ95POOzBnAh+t5fSGbtQu19INb2FPpaAf48fGuGXOOvwtC5V7V9EN1ZdkQZm3ZAoRV81jZnN1X5b8hessVDdPJHfLTT8ztz3qXGceGNfOMuD/jlFimGIDYwXSZX5sWhgk211pfPB1HwYvFx4Aff+2vnZn4LHZyU6vCCGNvsg4XDmBp3OWABmgr3NTaMouvR5ZowHZCmIq/k2LGo63xgjCV63RR4FrKZWsVJU0ijQmlAbjZanze1PSTkTNN/5QLvzGWXFbT4poZYyV7VwVrurIs6mg5XWodEPx9auuHQsYAWmPvPHtsQ3t1JGAZIbYfus+aFarPX5F/Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJdDsx0gpxNztSPhjhDmJzhBGAbD2kx7tnLry2gOd2Q=;
 b=QdUQCUGfUJGntXj9AVi+BZfQiIdG/77bgB/GoSbNp7JkSZAKgOYzUGyfwEF60uqurtY9RmpFrUqWbcIyscsqzqe1xAc1VRgvvqCrp77vAiTcMpwknjvZh9osw5UsAmYIiPM/hDcj+/9bvbECk2o0GdDeMZNP/T03hYYRQnwQ1Ok=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:01 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 10/43] pinctrl: renesas: rzg2l: Validate power registers for SD and ETH
Date: Mon, 31 Mar 2025 12:44:41 +0200
Message-ID: <20250331104514.79090-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 97eed8aa-927a-41da-4eed-08dd70413a5c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?uRkQTgpJC7U49ZC9V0XTN56K2vrAIDL3lN5TeFWU5SxiQ0uB0EBr39XLWTcM?=
 =?us-ascii?Q?Bph69zDGFLT+Xd2n9HqUMySHSBet43RMReXhD+eWcgUljmnMfDew3mEpat4A?=
 =?us-ascii?Q?Rx89qhxC4BAOGClVmzXMHojwOL78rMLBqyquj41GiwLs/5I/rlndoxbUe3o4?=
 =?us-ascii?Q?GmPTu+fJ0C2opk3WkaXzFAy76m/a1ZlPjRk5z8pf8vmPWCaKiGuQUYdsYN6X?=
 =?us-ascii?Q?znaSHctzSu1VhfI8znAHo/USHK3KiEYairOXxEcHsEJksVCQt3sExiic9XDm?=
 =?us-ascii?Q?WoH/tNafC9IBVGsAAuq/M5gRgtSUd7xbGOYTNamJEgRc4a2Sfu36+fQIUQit?=
 =?us-ascii?Q?zGzzDyBCkdOH8T8/vgmUjMCs9AajgiuouOVMZJZ3c4WOSk2eeOmpxYWGHp9A?=
 =?us-ascii?Q?NENQIY/g7AMgVhlotWU7I1ff3/DF7WB3FKHKjQL/9xHac0umAERBDQd7mp33?=
 =?us-ascii?Q?SLfuzpO4P6DjWfZQHbGmGxdgK891A9hv7OpH1IFWRy9vck9ANnIl3rywQ/j0?=
 =?us-ascii?Q?Y65CW0AIFWG6H68kv57NMKVyXdKb9F1m4lBqjV6qVx2nytfYk8Y64BagE7ru?=
 =?us-ascii?Q?3EMgS/MqH/3fEfCBz26UvsrlzjSn03U0WtrqDt8elPkyMmV9DVoGwOQFXSH5?=
 =?us-ascii?Q?wp+NnrcXeJU3mqnCKr5FGMUzDz0RXxQ/mpQjTAxbvltsReUHHTakGWf1WcxA?=
 =?us-ascii?Q?STovtD4H676lNAOkR+tkM1mjaLVi9S3tNNX8gEK1Ui9kC6JpzfNkedUG6qlU?=
 =?us-ascii?Q?C4AOf3qGO4KgizwfPOM+fWLmLhGIxEOSRyz7dWZn0OFjMm1YueImCHL7t31A?=
 =?us-ascii?Q?/6FWdBucohqN2daed3kwImEu70WlGBFECFw8x15RKW7RxqXaKiByryYOBWdO?=
 =?us-ascii?Q?d00QzHipGhcMqXpCZ+R+cFtStervUqOMjH90QKo4fSfqzGLQAR4ajrSDyQ9n?=
 =?us-ascii?Q?2QkZyJUVKg6ho10EAlerT4JBkpPbRNaQDaNr0vlX44Dax2rLaVYmjgTWgRDO?=
 =?us-ascii?Q?pRy04JuGMRsXwO94vVmm2BEzgcJQpDbnryorTLUkzLoxSIBypaBXSuyqV/pR?=
 =?us-ascii?Q?LnpWMVt4peAqsQ3hyHqTaSdZYP8cnRZ6a56k+OiKKHOHX+tT1OpQQdnmt0W6?=
 =?us-ascii?Q?PpMqFCp3X4vxT+i4mKe9kG1rzdZV11Ko5mekULMhyVNzO52JXu8k19aSt9SW?=
 =?us-ascii?Q?E7VXA3GBADecKl2GzoF/GsYpzD8qKrt54DBvGTbeypHrvbEDeGrwmJhMzLB1?=
 =?us-ascii?Q?iDPeVrhpvHFcQCTKo25U2Xl5y4fadnC07WSzqpaeWVZJi34vXzSVHcO9JU8s?=
 =?us-ascii?Q?pS57FrEXn/PovqVYLx5+yQ/biLFTRvMuynpgepmDqlKpa85Mdh14cKHAUSh5?=
 =?us-ascii?Q?/49/YEGQGXhrt2WG+0olYYUSq+a8+YwJcK7DitmYTAVIkEPrytRzf7UPmXql?=
 =?us-ascii?Q?VQu2eAg41mDmvKjZ4zuEH76Xp2D3VAIh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jApGCXDEr8+Du0PRRBOSLNDRxJ5IoSKBr4eKizEggI3uruczHqID9emJ2ARK?=
 =?us-ascii?Q?h66DxlyeC8Sz5mpNW0FcoG2b01bgbt7LxGPuHM6qArTGfz6osfLpZAI3GgPA?=
 =?us-ascii?Q?gHVV3wLTURY9QKkcdhMVVyZtUNC0k0obcy8cdlidS4CiLzxRdCx2OVwMifiD?=
 =?us-ascii?Q?FyGgRn+dPwiU0pJDECB1H/XxrFTweoV6wmT4SobTAUJ6byIioLUSKt4S+m1y?=
 =?us-ascii?Q?bATYji4KX2lDUo0nWAg7rJLIoSjPX4W0gA2MVp5CHAMq5TPMuiyWIWTF0H2s?=
 =?us-ascii?Q?BdMqB88mkkcsitnshNY9YNWCse4cT67PJJlUCeqqhfkvllyXCMsn0fQzzoTH?=
 =?us-ascii?Q?5cqqTWhxuZZbDRxjwNgtBVfRLLcb0jizurDhT9GS/rkcDytcVN5ftsFU6JHy?=
 =?us-ascii?Q?inVlFf9IxW76NSUeSjEiUU7jacpOkFHxwtTU7pta/2/ywXw/AvWXtbaDmMwG?=
 =?us-ascii?Q?pq2pby70d6hwjOmR/71Pp7K4laSBf7vC2XbZl0Qjoq587AE5x4txtRXX/r5Q?=
 =?us-ascii?Q?Pi2rZp5225clCw5vkymAeI0WVUK5nhKF212vGBCDl526ra2rguOWGTnWvMWb?=
 =?us-ascii?Q?LtLY6IcFoLLoyh2LREBl/aFurlEwkYihPngf6mUTBYz20XRyJEJ4z/A0k6ov?=
 =?us-ascii?Q?z+NERMgj5/2ZCeZmMbCe5N0qZzBFjxSbiHEVzUr55iiWngHJe+sHXCvTLY43?=
 =?us-ascii?Q?gZkFTwhFc554ocYmgl5+dHC9PR9DjwhBdbubKdZmIXx1De17TglMPSyIuuEd?=
 =?us-ascii?Q?Aakt64m11Xj8qybFsCOS/aywL4T/ojjDxEbL+bPwC8F0mKJ1XT+VEEKjSZ7w?=
 =?us-ascii?Q?wHNOcTrvJOIZQj+ff3QwlqQtQZ8ok6NgYYyIk699US5XmIyXK+w9oi1Vm8tN?=
 =?us-ascii?Q?361kHsdH9GShMdeuoXiSizjUgfBDJYCwRQA4blMQJu94bmgnhvaS/Cnz66rx?=
 =?us-ascii?Q?t4He2MJ9yFS0jqqLpzesASyH8SptlzKSUtMv6Po9v1VNDguSjV81SLot0Y/k?=
 =?us-ascii?Q?GZA6okrFbwN1cSvpmzMdLmy5wyshoYFftTqiEaYdoRe2De/10mahQ38vxfug?=
 =?us-ascii?Q?vN5MywSTRKwIgJO/1XJExF3wkePT+STfYxr3fmbcI1huO7HN/w86PadsOeD6?=
 =?us-ascii?Q?kz7FqSUpWn4Yj2MokMo88bTbYAM2xD2y4uG3Dk9TV036K0ABrUu4pcEYCACj?=
 =?us-ascii?Q?K6YhkiHieV8ERVUnxDzgTtBvpzHEbFyxitZyUxQVRzqB2bu2ggoHmNEGij2T?=
 =?us-ascii?Q?IPIbDzJY24yO9FVLXaW10+iFh0O3kO2Pz9Wgy9aLKvGiD6BnJqXF6qN6F5jo?=
 =?us-ascii?Q?Vx4krh1t2yhG0mVCQAGJIk+cDwK7v2U7BTsrQrDNJC4f/AthShoqUTkhZf9i?=
 =?us-ascii?Q?hCmSlMl+CVCU2tl27mS1rZg2p4IwWCaNkol4iaRJR7evPHMIJagD+KijcSDB?=
 =?us-ascii?Q?7xFHlowvoBsWkSQzm7ulO97Vf+BVDkjJbCYqcKsGGXFB2FzGc54Vyq7Whd58?=
 =?us-ascii?Q?PaBq4AK7IqB4T0wcmFUsZI/lbxfOa14DaF4tOhLab7UR9hcsV7n06OArE0i6?=
 =?us-ascii?Q?2eLrB3J3lroLY47YR+OVcf0UQoTPggO4NOOInTDsHnlz3v3dCSzVP7f94QKB?=
 =?us-ascii?Q?ZwzxUrAd70MHZGan67DSaBM=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97eed8aa-927a-41da-4eed-08dd70413a5c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:01.4164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8RVPu6C5iAz3Yw5gwJJAFeh/he1ybxOLAdaVOTy9zEI05QMTYLM+vDtKMlxaW/D4WzPYgiE5xSbFeNp1TQ5A5iCvQ7TFT75ptqdk7F3/7V7z8hfdOu/sgKBQrXl2PBp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18398

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit a3a632ed87f0913779092c30bd0ea7dfd81601f3 upstream.

On RZ/V2H(P) SoC, the power registers for SD and ETH do not exist,
resulting in invalid register offsets.  Ensure that the register offsets
are valid before any read/write operations are performed.  If the power
registers are not available, both SD and ETH will be set to '0'.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-7-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 0d3ffd7617625..b6b53757d803b 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2503,8 +2503,10 @@ static int rzg2l_pinctrl_suspend_noirq(struct device=
 *dev)
 	rzg2l_pinctrl_pm_setup_dedicated_regs(pctrl, true);
=20
 	for (u8 i =3D 0; i < 2; i++) {
-		cache->sd_ch[i] =3D readb(pctrl->base + SD_CH(regs->sd_ch, i));
-		cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch)
+			cache->sd_ch[i] =3D readb(pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc)
+			cache->eth_poc[i] =3D readb(pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
=20
 	cache->qspi =3D readb(pctrl->base + QSPI);
@@ -2535,8 +2537,10 @@ static int rzg2l_pinctrl_resume_noirq(struct device =
*dev)
 	writeb(cache->qspi, pctrl->base + QSPI);
 	writeb(cache->eth_mode, pctrl->base + ETH_MODE);
 	for (u8 i =3D 0; i < 2; i++) {
-		writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
-		writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
+		if (regs->sd_ch)
+			writeb(cache->sd_ch[i], pctrl->base + SD_CH(regs->sd_ch, i));
+		if (regs->eth_poc)
+			writeb(cache->eth_poc[i], pctrl->base + ETH_POC(regs->eth_poc, i));
 	}
=20
 	rzg2l_pinctrl_pm_setup_pfc(pctrl);
--=20
2.43.0


