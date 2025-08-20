Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5503CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:13 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web11.924.1755705970172447702
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BBdBfwae;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnl5bZ3BcuyrRubnswtjVUU37m8rNskodaziZ1dBGuoJfR0NZhzCyN251oxbw1BBQ64UNaEHC7+vA5eLK7uPcU5QaM5zBSayMj4jvhrj9WGbcFuaI8fxbpUEHgA3zDHvuisD/PSuPU4E1DG1s2wF7aciI/e4XIrBSAlFEoypoSnT/oWLdtDpGQpW7D0u9/Ynm0q9agWqVPauxdHd81ZzxXbs4wGIwQ3OKIEPCsTzCfhsCKpjeIoOFDhATM9PQNrGrgdCS/W2/gbw0oY52lfwKC76kCo51bx8E/BwNIztbxjVKMmtGETwChe2E36w12KsOAGV1RwJTvv9RipYDywz9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8z8dA/S6LLlQtcxnrSMU2ySEsoHfpwFYLB4rjnMgQgM=;
 b=lxPIZRLqkUlInLL0Rp3rAZWhUE4sOtij4/YbOg5v+LaZjUksw/F7g22goQ4LmOoOkIOl+PUq68SC6PAW5jzDv/0/nsSPeSBjOt3B2BImAD9O/cLUKWMEcz8h++DxtvbaJzXZIfoPCtn8swOL35t8DoAR+ddZ4Nkn9saEByvvj2cvwHCQ8OkQxsgPG9nS9D50IfEXKMOiAGjMRnjOqjwZKQMLKXSWYh5Cjiu47KpCiWTNamT2bRWVFi8gL4hA0tG4snDp6t01lTeN8v0JcQnlft8kKMT35iyJWJQfU0EhiLtZ/XZ0ge74RwbxxjCe4OZpS4lvdbZzXPsngewCMvsuPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8z8dA/S6LLlQtcxnrSMU2ySEsoHfpwFYLB4rjnMgQgM=;
 b=BBdBfwaeJ2Jl2xSOVrcIeDNlXgQyR/OmnEHUuIok5slU7DBlMwmNFAqP6z2Syav1xw5D1LKreWcypwN/ILXFN60n+9aFL8r46FbYYjXp5R1D6cdwGKDTUf6Z60LSa+ztAVV0eIKo7EKwqcmzc41d8HPFUMPRvdEnQIjKARiXLZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYWPR01MB10458.jpnprd01.prod.outlook.com (2603:1096:400:2fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:06:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 35/55] media: rzg2l-cru: csi2: Skip system clock for RZ/V2H(P) SoC
Date: Wed, 20 Aug 2025 18:03:51 +0200
Message-ID: <20250820160413.801341-36-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYWPR01MB10458:EE_
X-MS-Office365-Filtering-Correlation-Id: 825bfcc3-b511-425b-0152-08dde003792f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ECD3fo6lErZNCMIvRAcd8pR20mTDby7UsB1yRihk8UX5QrRUbk89APTcOdlu?=
 =?us-ascii?Q?Bvnh7fNholL8LN8++g84Dl6Ifw/shbeDTtrQf8uQD5TjlOoP4x2Clpay7mdU?=
 =?us-ascii?Q?XGEHe016uW/3IIVQ2lXTdBNr1CmaEgPg/0BvMCgmEXGw/bEqY+/CSMtv4b7f?=
 =?us-ascii?Q?KHNsak1jbKJ0lwBszpy0jljNsudDrxi9p0434iZHMOwSglxR1uCVzXD0Uy9E?=
 =?us-ascii?Q?2PZpfOzRjJ0QN5o0f9q7BJ+PTyn/Ufl86cs6OsHeo2DPHcE4o0CkNpIEBH34?=
 =?us-ascii?Q?2HzhNaKOWQQ1h0L9s5muxc3c4YTAqRTxkt6FVupnL5u/sV3LSy+nQXAy0HI8?=
 =?us-ascii?Q?+TCZDyt3vSmHAhFoW65gIzx13a+PKswtmsAMo85wfcPEFHsO8GXKEqlNlbti?=
 =?us-ascii?Q?FKnLtkWvd1E99f7ELiAjsy2T5miAnZjNgBoBFzxy+cNhv7Kr3Wq+rCKnh8Xh?=
 =?us-ascii?Q?j3wJnSquEvJYRBC3psnzvhlzDZWv14r++tS6LsaLoTy70jAKQiqfeBwqZBkB?=
 =?us-ascii?Q?gUVGQWyL3C6c9h48dLCYjt0MZlDDHKgPIT5lpurIAEISrcYyFGB24EsOPvXp?=
 =?us-ascii?Q?4TkQtvPKyJw/ror9zDomc7PaSdvqzGnxnq6+bAYHxXlPGLkoSQNppvyFXoKT?=
 =?us-ascii?Q?JPlW/s5kQL4JWM95nvU7vnZ3MAjTpN+NcpPVGmtxVLzwtfw2+gcMmTH+0t5B?=
 =?us-ascii?Q?GpF/NeaJN81G9aetLsWtBUQvMV6tcEhKeSMqLa7iThiIKlG7d5ETg3sS6Vln?=
 =?us-ascii?Q?rT0rA31aoHXN5rjTGToAm6nxWMILzFjz0pdHFQrPqxxTfJ8Xn84xhhtaeGyf?=
 =?us-ascii?Q?QEyDhpPFSHQtnDOlR/9QZ231iYsmsodaDn78fODT8kymUAg3dtxCNG3hpfG3?=
 =?us-ascii?Q?QRFMCC7rWiECvcKMWyXj/bgtUq7fWbKOZ6/+Pm/mKzhaZyswIqcWolfcfG6v?=
 =?us-ascii?Q?pIMr1hmveDk9JnTtA9/Kab6nJBecnwWc5pKlPnMhAo55kTmB3StQKmTei6ca?=
 =?us-ascii?Q?rupFCQOy8X996EOscl/zI82zZVSUilo4adJ97PmCrrHXx0AucHCNyq+9ricz?=
 =?us-ascii?Q?Dg7Kjk/DHzGjeECJfwwV2nngl68itfE70o9gru4tbc5D3g5qvgsgbCMu8Dwu?=
 =?us-ascii?Q?SYpHa1EET5Kg3xtaf9mZDSPo5JR4knEGa6BjWueeveijzqZwNPc2kBU2XcV8?=
 =?us-ascii?Q?8Oj9f/XsD96E+zRCR7QQ+rYTO+L33wdOgX5GmVQ7qyaXwJ30nbB9weyJsfLG?=
 =?us-ascii?Q?jrYOtLUYD/l6TrA2vWPuBsjMG5OAk7UlcvdD/a1uX8FQy8i8skayjTi/Rn7o?=
 =?us-ascii?Q?t9niZvCsHf2ybpBkC0SLtaSeAtMrZwCk7o63YmuxAsCDuR7nZtpFh/JKLXoT?=
 =?us-ascii?Q?g2co+akjsu+N2kEEdrsjrypSZtR+3ZQxzBxgYx+wlzUPSSy6z4IZdBwZd1fu?=
 =?us-ascii?Q?yJsL5fmGVIYK9UAKbZw0CkfVh23y85lkE/lGOHdohVIGzsMsWfWsU4gE5Kwu?=
 =?us-ascii?Q?nAtK5sgQnYl+mso=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?r7CDqakB4QwNvJque0b1QvL3E3PmIja6jlShTcL11C3Lb49zoGZrgErpeM/0?=
 =?us-ascii?Q?33j5GQmqTOnHcA9F4Ud1+7Ib3xSx94WJQyX4e13qs2NyFDnPqyP+6QEUGKNj?=
 =?us-ascii?Q?Oe0zGcgew4y001/LLvF6kCKZlWDK4DCul+pXxkl2zYI7sBJsep/IzI0urTy6?=
 =?us-ascii?Q?XoCz1kPeXRApRjfsBlVPLgO9j3Spqj0Sd2kBXr9qPamCuDKLhh+X91uNbXSo?=
 =?us-ascii?Q?l+imbAB6uCEVZ3QGByNaScBzAt3UQYmjHrqtzM4sX6qvYTn0EwuZXy75dkXU?=
 =?us-ascii?Q?rDIFwfGXPeD/UgXugevkFxCpYVrfxmjAMLwSGG8Le3w9/18gGQZ1BsBBD5Kc?=
 =?us-ascii?Q?WxYneraW+se1xTC4fYX9lSJr+Squn/lVB8yo+yjbtuMSjQFinSdK7mMrQ/ew?=
 =?us-ascii?Q?6C1KRCYwbcHdTR4Q8C6vjPGgTG3Q7AjcoX0u17PlZKUahDSwy/3XbKOq2AG6?=
 =?us-ascii?Q?KSxl7rXl1TR30W4ZdH1Qh0NJ1pocHgPisNJEWKo4HA01JafgjGEe66+Al4Jc?=
 =?us-ascii?Q?AkGcGb9H0aN/AWkTGaOG49YPN2o9KCPj1hOpIdQeUYdgPC8odAej5h/x0XbU?=
 =?us-ascii?Q?xVQ6ZD+Tx5z7eOdToAmWscxSvnp2Si+kWTaEjMNkDKiEeFuThfjAWSJqd9AA?=
 =?us-ascii?Q?R+WTy5n9fsxpOTwBBpqkEGQoTAp/lP8WBQ+QjorqkXvSjQd5YB246S2C6sBh?=
 =?us-ascii?Q?Rc0egXvI/qi396NIwAqL+kGsBvzmhbFvREK9Bp50aKF3bWNo3PugeAcQoHKY?=
 =?us-ascii?Q?0nNqZqUt0cp2dtROqOsgka0ZSNpfKPrBannU2EdCVcHi84j6rFOzIb/kTf1n?=
 =?us-ascii?Q?THRb20iGke1tEeaZpbL3/Z/GSCxMNzJ20Wr86v9hiW0YrzRfbqIwX73B3EpK?=
 =?us-ascii?Q?xlcs0lrOy6xbqosWVlNOA+DMFhbsABccul/bjkkenlt5uAmpi7AXbhJe9lI0?=
 =?us-ascii?Q?KdqU6asoW2g9Ue+iqHTrRlWjkXkL9b7Jmq0oTYgeWyZ2jiAGwyFOLk+A6Fbv?=
 =?us-ascii?Q?7TeZuzCffYfj/y1KIts0Oa97JwXloNm2ZB3Ui04xIfRaT00yFMUfBfTS2sJz?=
 =?us-ascii?Q?doADvfLJhVAjGvZ+v+nTcHWl/4jPbQ4L1qhDbeg7teB0aJH0apSU8zDGXZLq?=
 =?us-ascii?Q?+WD1UI8edYO+i7EzohHLOhvweHMWOPB6O1qn4gsj5mpwWKwOwAmNf5YHmrtO?=
 =?us-ascii?Q?e+dIb21Z43okQvrvvX8tJLw5OXinRBX8OKfE/MlE+03ZZFiKpyrmbMJdEFWh?=
 =?us-ascii?Q?iTF3ACYE6l1s+mw70dGzUncjIi7tq6zlCwOy91d2moKlvDTIDspQKYjdavx6?=
 =?us-ascii?Q?hqxUj53gm/AK4ZldVgX31wDVf/h6VFCX0i7eHffxbeO8Q2s+VtxzHSGYHRb1?=
 =?us-ascii?Q?b/1aRYRmqXYxIJ4yDZ9E9Pz9gk8gE+Qa3OzldMCPkQWnwNozRsPgc4jQ4DOu?=
 =?us-ascii?Q?qXDkU+M224z7ewNTf6UzcPxqw/8F0ORnrmZsHGS61T0UGDsoDQycSzvs3xE7?=
 =?us-ascii?Q?RL7vus4v+12LjDQZmI1iKmHuSJFMyaAQNdZhE1fiFJYe+5RMFWUnMJJ6xVdB?=
 =?us-ascii?Q?sRfp2h/WOui230TLpcOWVUGIHmNBaP9eUb1ldRNQji88r5ldrZHgdF2fAzgu?=
 =?us-ascii?Q?1qI+RzOw94oVFSAvg6pO9+g=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 825bfcc3-b511-425b-0152-08dde003792f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:08.1978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3m3EGLi3imLfDekSM0NI+6UwBdSmu/mr0/yWfIK/TjdQvwOiGHzvptNnVseQySHR4ZnrmDWm4Df6oH3yzEab2wkKHnFQkMcAbHFRHOkcAoKLFr9pcxpeP4X7KGuNdz8M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10458
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19860

commit ed472263fcc48f72e32cb494061bf8b8c333891a upstream.

The RZ/V2H(P) SoC does not require a `system` clock for the CSI-2
interface. To accommodate this, introduce a `has_system_clk` bool flag
in the `rzg2l_csi2_info` structure and update the rzg2l_csi2_probe() to
conditionally request the clock only when needed.

This patch is in preparation for adding support for RZ/V2H(P) SoC.

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://lore.kernel.org/r/20250411170624.472257-10-tommaso.merciai.xr=
@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-csi2.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c b/driver=
s/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
index 0cde0c6d7234..5868966db28a 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-csi2.c
@@ -128,6 +128,7 @@ struct rzg2l_csi2 {
 struct rzg2l_csi2_info {
 	int (*dphy_enable)(struct rzg2l_csi2 *csi2);
 	int (*dphy_disable)(struct rzg2l_csi2 *csi2);
+	bool has_system_clk;
 };
=20
 struct rzg2l_csi2_timings {
@@ -365,6 +366,7 @@ static int rzg2l_csi2_dphy_enable(struct rzg2l_csi2 *cs=
i2)
 static const struct rzg2l_csi2_info rzg2l_csi2_info =3D {
 	.dphy_enable =3D rzg2l_csi2_dphy_enable,
 	.dphy_disable =3D rzg2l_csi2_dphy_disable,
+	.has_system_clk =3D true,
 };
=20
 static int rzg2l_csi2_dphy_setting(struct v4l2_subdev *sd, bool on)
@@ -799,10 +801,12 @@ static int rzg2l_csi2_probe(struct platform_device *p=
dev)
 		return dev_err_probe(dev, PTR_ERR(csi2->presetn),
 				     "Failed to get cpg presetn\n");
=20
-	csi2->sysclk =3D devm_clk_get(dev, "system");
-	if (IS_ERR(csi2->sysclk))
-		return dev_err_probe(dev, PTR_ERR(csi2->sysclk),
-				     "Failed to get system clk\n");
+	if (csi2->info->has_system_clk) {
+		csi2->sysclk =3D devm_clk_get(dev, "system");
+		if (IS_ERR(csi2->sysclk))
+			return dev_err_probe(dev, PTR_ERR(csi2->sysclk),
+					     "Failed to get system clk\n");
+	}
=20
 	csi2->vclk =3D devm_clk_get(dev, "video");
 	if (IS_ERR(csi2->vclk))
--=20
2.43.0


