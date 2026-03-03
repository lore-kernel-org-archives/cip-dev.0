Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28807EC0479
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:23:47 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14396.1772529824523009941
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:23:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=H1x2ZpME;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmlDlJ1x4Vl5IkB5cCJ8iX/LpDFm2RQRNvp6MxtdcAp3KCfrc2XYkmpb5vl6LNMMonY2fuQRA7fsEr/9zKX0K8sirUJGX91zD8YzjkISLrijaPskE5OvgLLLCvxEn1GVAKU9RJmQ8ljNFjUMhbwoOs2tpQ8sx+2c+4KiDhNSya8yzph/L4f75a871IPD8urzVKU0bpKQZBCDqqB8d9vD0okuI5K8shFhSXZ/U70xVKqiAxBWoZKwfU+V1x5ABce/dy8eBA1KFIm84RjYvAOtT7IWquB5nT7heiqUUIq6N5GDZFAsmCYd6M5hUrO/46o6VPifpt4tHoY/0CHicVo2yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxNfezvFEQHcKkUft62I4fagjsPHsoLqI4lYYHcu7KM=;
 b=qOJBX5jGDhxm19eKnkNkNC5xBwnhk7dvm7aVXHg4dYxaF4kEubINJj+tn7ZeLVn/d0mYUqqHOLmJaKdW+LsPDAgeWeJm7nZXmuDKNKXqRvP3Sw30ibV1bHwrbGyqC634tTFQbMCBZ0i3n6tejCtyZ8+/+EcgLi+L+wHv+a7APaurkhroEwU7IBNp1epziqAQ8iCRVMakewi3p4BHW7ZrNgUlbAf8vca79xUk+wWNXzz3YE6kZ/uBJt8Hi2bfD8W3aKaQIDLKgXgRQgMJB+lG7g5u5WT14hLPvo02nbB8diR6s/2bw9yPEIOqKBOgNSrRHgPFkAkw+zWul6KoagcrbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxNfezvFEQHcKkUft62I4fagjsPHsoLqI4lYYHcu7KM=;
 b=H1x2ZpME06bOopnjnOBI5Bxx8YZC8bix9Y4iC3GWvrR20QLHbKQI9dYjtBCOKGlwkwdKu8QttfIl0M2ilcnjU5CJzxgvPl9yFYBw6/Q608+bhd8g4lHjqfVTTUP48a0Dh0ucPod1kDaEECuV4SydHAtUS6C/1IXHggto98EfUSM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:23:42 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:23:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 6/7] i3c: renesas: Factor out hardware initialization to separate function
Date: Tue,  3 Mar 2026 10:22:58 +0100
Message-ID: <20260303092259.13301-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092259.13301-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 170cab9c-6aec-4926-a427-08de79068faf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	N1GY2RLOlbFGzdt+zj/pBj8zSf8h1fwErqQ1EE1j6sFpuUuvcUtzpnUJW+uzFWwhWL0vbRzlbsIBJShbqjOn386a2jS10tquHfdTFEfnS1QrKrEaqaok/pUlzwg1TKjYsrzLx0mBsdJkroMsobuNdH2C2K/fvRdv5GsfHpHo7tq1xI2AG/wexsBtvkdpj1BPc9oXZAUlYuCLB4uaVCy/1XWx+DJBY7QMKyubs2zpctGFiQjWjIR3iy5WU4dXUEA3lxVEDdgUKwkacPSzJT28k9YWGun+Lrn1/hEXRBEhf12iEv5nbOq/nq3h2fc7Lbo2HXl8e3mgSF0OB1Uf2O/qX5pp/yzi9mo3FDoZK3LJ1NvKO8KousVIBSGwdXl71mZ8bhJJRMPpiwQEZlYYlogEZS+H0XLlJCHULYr3YeOXnhkdAr58PWAvr5UCovxAsp4new0gmTPkk5sa96XmI8GlOxzroSPZ2RbR9m7Cmo9KNBP/8ztJBHaaLOmAMUhUK2XJcmj9BqV/qPPGnVPJyZ2i5LkUEy7LxFacncQs6XUVpzzn78F/J1/t0keIlr7xchIjXtg4r0W3K6VrDvHfGxWBzmZT9OqMc6qa2YSbiS7K9ZnXYhxc93nwPp0u8TeOULcGCFSJq7AuyTdKyWTA4hC7951n2wh2OPxG1uuNXILuBvpUkGuL0myBBaW/1qIU/4lOdbFJenYykImyMMsg1f4QyBUTyldFrZ1Lp/URqBIlcRXNkAFiFpNnKpqAbES0Q1zG
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IFJ4A2WKdYw+IjOd6DF4pBdlLhAhYU/Wh/6kDCcm/1adihibVJJFQHyeP4MY?=
 =?us-ascii?Q?Bi+PDVZ1kilZMpXx8zWvEpVI3xnGl6HIHT1iXK2aSAT+ZLaO0ZfixQyHiXm8?=
 =?us-ascii?Q?l5chEXQmDVIFd09muDJ7KwZdW8jSzgXcjGj1FSi1Wei3quY6E2IE3nozuq6Y?=
 =?us-ascii?Q?uFCFy9IvaGdaFpls8+0Gnf+jiIVl62yYdRgsDnqRatNoJiH5DQSaBQr+S297?=
 =?us-ascii?Q?1PXRcn4Czgx15GblyfLcbtaqXDr5L+xreLzkqb71a4Hf6eeDPwK7yWysSeVS?=
 =?us-ascii?Q?YeAFkJj2coOGmRkzm+VPRXI2TQWDlXVOdWkvuNLp3w8pCaId9P3tk3fsX2lj?=
 =?us-ascii?Q?Icig270nqrAhnq2ZQ85W3r2MIrMMhQ/kYEBF0rMx+0qOT3lq46YcqyjE3XNm?=
 =?us-ascii?Q?+3rjriFq1w4QM/ooJPKHvkq40QGg6ZQ4DOJk93MO15+S5aY9NuZ2rYxck0Vr?=
 =?us-ascii?Q?T+6JLXt7Zl9AGiwW1oL+wUbxz49gPXzA3jiM2vN90TPLAAqwG709FigMofuT?=
 =?us-ascii?Q?M6Xi/lnLNWDE1W1wCIRfgXSs8UIYt3QUro85N1PuAfBTrvU+qpMcARnrIkar?=
 =?us-ascii?Q?50EwecztaaXlNG3MXOsi1VPXd8mHYQ3ZY6CNdSs8Q+MWtsOo5qJiQEcm7ZPd?=
 =?us-ascii?Q?yUJs0qhzFJeiBkX7rEt11tUsNr57g+RDjsJy+rdsWtDkIRs6UPmGGt/oH3a1?=
 =?us-ascii?Q?fZMXaqqAjvI1U8UYJoSMBLnrJdyM0GUU7cEsDPNmY6RZMv3I0k4Edh4Yc+ri?=
 =?us-ascii?Q?e6nKe8Tl+X9q5IOynNQ8ALVHY43kq3pWCEN3gYJWAL/zTT/AR3GsbwWFPATa?=
 =?us-ascii?Q?tHDLiorJEHeyusZJRmubd+pyJIIHEDXiq2jY8VAwPIhVkV6SlkshpydERPU9?=
 =?us-ascii?Q?T9WsGapoZShhYZ2IVyy0BHTa75IjaDhT2YtTUcmpEs2SjPUL4nKB6q72lK/l?=
 =?us-ascii?Q?VyTqqeL9d1M32t9tloCWkY4k9Mbd043hEI4uXfelBuTAC6S0LzQkA2bGuZqe?=
 =?us-ascii?Q?rpzC8f8yjTRjBWYU6dqnMKTF5nxYBqene5dYjYtcrdhX6RUet/EoiQkmO303?=
 =?us-ascii?Q?3/NtVB0bexb83ZApW7qhvBIdGNQXpNTTwjDJIOgNF6BXOGnmbN3oAfu90w1X?=
 =?us-ascii?Q?7C6y0VzejLQrV7zcUGmldhNBQcC0nDWz16OMhsJnLx8Hc1l4Skwx3+oQh9GH?=
 =?us-ascii?Q?RiemWuKOsYcQlphhQjTRRpWQvtEnBfNEvDIccOpqK3HenVTftmP7JUEtdFh0?=
 =?us-ascii?Q?DNdnb82IDYiceu+7I5fxrqAXLFD01gdyQ5h6cP5oZEx3uObWLaTNxIKsv6Cw?=
 =?us-ascii?Q?Cx/8doUK6oEmS1Qp3Xa4pVSS8bJP9fhambd1KGZ/qbz3j5+I5AekXtcAvwSf?=
 =?us-ascii?Q?JeTBNloYVuPRxaYj6WPTMaZSmZK3lX00Jv8baM7jzMpuiWSLMHzB/qlqvqzb?=
 =?us-ascii?Q?P9sWqmJwoJaun80wXtqXm5RFi2kt+VYLqrN+ds384BLHg51O57vGY157Lowm?=
 =?us-ascii?Q?xfgUZCdKyQf4JlFzdztLO1/8syKnYXl2RS0Njf4hjaaijryFEd5/ARhm2im0?=
 =?us-ascii?Q?0TQVh//N8h5zE4sf1cTDtGocOeCeQ4Cq8c8QsKZf8aFs0AvD5YlHt4SIn65k?=
 =?us-ascii?Q?qmODkSQJSA9yIHGfAab8dlhllgdwzYByo1odmagxTd6sC2/DGDQyyXUbhwxU?=
 =?us-ascii?Q?V2lh3OsebQ5ifRtALdbjhktkXSsTkIj9Th/keq5v19NPfvu4TcvEXNoM4xBy?=
 =?us-ascii?Q?XN9GhZani8+71LuSBx810sg3diykeOmOHH+WkRoh9BX3RX2S8ieS?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170cab9c-6aec-4926-a427-08de79068faf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:23:42.1728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLJqxHlAd5BnHBYlWRW9oz4L4xIqOLA+BU44+RGkwJDGD/hT2yd6b5hMYEL3kPrAl+//NuwfDoDEAapLDp3nHGE+G3eQPkTlp4tN3Wy2s1v8e9FRfpqe1ww0kI/TjHZy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:23:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22057

commit 5eb3e8763e076a47ab145c5fafcf39f1ac7c7aee upstream.

Move the hardware initialization sequence in renesas_i3c_bus_init()
into a dedicated renesas_i3c_hw_init() helper.

Simplify the code and prepare the driver for upcoming suspend/resume
support.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/795327270a6ceb23e15513a2619a19ae4876cfba.176=
7781092.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master/renesas-i3c.c | 99 ++++++++++++++++++--------------
 1 file changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/i3c/master/renesas-i3c.c b/drivers/i3c/master/renesas-=
i3c.c
index 5cb194c7b400..09b2bc03a5bc 100644
--- a/drivers/i3c/master/renesas-i3c.c
+++ b/drivers/i3c/master/renesas-i3c.c
@@ -479,13 +479,65 @@ static int renesas_i3c_reset(struct renesas_i3c *i3c)
 				 0, 1000, false, i3c->regs, RSTCTL);
 }
=20
+static void renesas_i3c_hw_init(struct renesas_i3c *i3c)
+{
+	u32 val;
+
+	/* Disable Slave Mode */
+	renesas_writel(i3c->regs, SVCTL, 0);
+
+	/* Initialize Queue/Buffer threshold */
+	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
+		       NQTHCTL_CMDQTH(1));
+
+	/* The only supported configuration is two entries*/
+	renesas_writel(i3c->regs, NTBTHCTL0, 0);
+	/* Interrupt when there is one entry in the queue */
+	renesas_writel(i3c->regs, NRQTHCTL, 0);
+
+	/* Enable all Bus/Transfer Status Flags */
+	renesas_writel(i3c->regs, BSTE, BSTE_ALL_FLAG);
+	renesas_writel(i3c->regs, NTSTE, NTSTE_ALL_FLAG);
+
+	/* Interrupt enable settings */
+	renesas_writel(i3c->regs, BIE, BIE_NACKDIE | BIE_TENDIE);
+	renesas_writel(i3c->regs, NTIE, 0);
+
+	/* Clear Status register */
+	renesas_writel(i3c->regs, NTST, 0);
+	renesas_writel(i3c->regs, INST, 0);
+	renesas_writel(i3c->regs, BST, 0);
+
+	/* Hot-Join Acknowlege setting. */
+	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
+
+	renesas_writel(i3c->regs, IBINCTL, IBINCTL_NRHJCTL | IBINCTL_NRMRCTL |
+		       IBINCTL_NRSIRCTL);
+
+	renesas_writel(i3c->regs, SCSTLCTL, 0);
+	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
+
+	/* Bus condition timing */
+	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
+
+	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS,
+			   NSEC_PER_SEC / i3c->rate);
+	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
+}
+
 static int renesas_i3c_bus_init(struct i3c_master_controller *m)
 {
 	struct renesas_i3c *i3c =3D to_renesas_i3c(m);
 	struct i3c_bus *bus =3D i3c_master_get_bus(m);
 	struct i3c_device_info info =3D {};
 	struct i2c_timings t;
-	u32 double_SBR, val;
+	u32 double_SBR;
 	int cks, pp_high_ticks, pp_low_ticks, i3c_total_ticks;
 	int od_high_ticks, od_low_ticks, i2c_total_ticks;
 	int ret;
@@ -558,49 +610,8 @@ static int renesas_i3c_bus_init(struct i3c_master_cont=
roller *m)
=20
 	renesas_writel(i3c->regs, REFCKCTL, REFCKCTL_IREFCKS(cks));
=20
-	/* Disable Slave Mode */
-	renesas_writel(i3c->regs, SVCTL, 0);
-
-	/* Initialize Queue/Buffer threshold */
-	renesas_writel(i3c->regs, NQTHCTL, NQTHCTL_IBIDSSZ(6) |
-					     NQTHCTL_CMDQTH(1));
-
-	/* The only supported configuration is two entries*/
-	renesas_writel(i3c->regs, NTBTHCTL0, 0);
-	/* Interrupt when there is one entry in the queue */
-	renesas_writel(i3c->regs, NRQTHCTL, 0);
-
-	/* Enable all Bus/Transfer Status Flags */
-	renesas_writel(i3c->regs, BSTE, BSTE_ALL_FLAG);
-	renesas_writel(i3c->regs, NTSTE, NTSTE_ALL_FLAG);
-
-	/* Interrupt enable settings */
-	renesas_writel(i3c->regs, BIE, BIE_NACKDIE | BIE_TENDIE);
-	renesas_writel(i3c->regs, NTIE, 0);
-
-	/* Clear Status register */
-	renesas_writel(i3c->regs, NTST, 0);
-	renesas_writel(i3c->regs, INST, 0);
-	renesas_writel(i3c->regs, BST, 0);
-
-	/* Hot-Join Acknowlege setting. */
-	renesas_set_bit(i3c->regs, BCTL, BCTL_HJACKCTL);
-
-	renesas_writel(i3c->regs, IBINCTL, IBINCTL_NRHJCTL | IBINCTL_NRMRCTL |
-					     IBINCTL_NRSIRCTL);
-
-	renesas_writel(i3c->regs, SCSTLCTL, 0);
-	renesas_set_bit(i3c->regs, SCSTRCTL, SCSTRCTL_ACKTWE);
-
-	/* Bus condition timing */
-	val =3D DIV_ROUND_UP(I3C_BUS_TBUF_MIXED_FM_MIN_NS, NSEC_PER_SEC / i3c->ra=
te);
-	renesas_writel(i3c->regs, BFRECDT, BFRECDT_FRECYC(val));
-
-	val =3D DIV_ROUND_UP(I3C_BUS_TAVAL_MIN_NS, NSEC_PER_SEC / i3c->rate);
-	renesas_writel(i3c->regs, BAVLCDT, BAVLCDT_AVLCYC(val));
-
-	val =3D DIV_ROUND_UP(I3C_BUS_TIDLE_MIN_NS, NSEC_PER_SEC / i3c->rate);
-	renesas_writel(i3c->regs, BIDLCDT, BIDLCDT_IDLCYC(val));
+	/* I3C hw init*/
+	renesas_i3c_hw_init(i3c);
=20
 	ret =3D i3c_master_get_free_addr(m, 0);
 	if (ret < 0)
--=20
2.43.0


