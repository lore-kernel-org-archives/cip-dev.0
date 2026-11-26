Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.0])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.500.1795708578007463285
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YKBHY1Ks;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqoV5VcW+Q2u7RyYci6yFOs9Lx7hrNIvCsL9ILGtB1FRon9++fd0cl/jQS/A17HUSY0+lrzls8jNloHPAsY/l8LOYqRS1SH1rDUkg1+ksheWVyPQ4uVb2dMNArkOK3vWQbB8S+eG6G8sJ8BWRO89mklEgdWrGM4JRimSlSR6kyRA4zPL4gHQREC4lf3MT4N8owbaKvLVg92rlw5THHtZQGfULdU93LiCJ/3CFV3sJ8A6Cc+2A+8WccI7c1VsvKwaOirbxX0oWqnAyZdsaclKFzXpyjsTDqOioV1rQAJziaTClBEhsuNiCWaDGeUP5I/JDQpfd4R4E0XMKRQiZLPhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZFsSxFgL4r9mVNblAobPsr2dUPIO0Kx8SfPT43XRC4=;
 b=v3iGMtEs366YV8v4B0Y4pLM9G1wrV9TJ0rWMKYUB8FVzAHo0o03n0Ep0kmFji0UZAXvEq0OW/6+kL+Qi4qOmWdKh8qo8qB0+qpeuqbTFaXH5T8F1Ql3MvsYW3OtLSrj+q4vgaVblr7skfkgMsVNV4a77qkC5HmNxeDo/Vxe2EmKpAJQVFZFQsZoM0UblESjXRfg0r0rj4KN5PtTLHA0W9BjaQ4rLX/eWatZ3U7+SpwfvO+c1SJWbX+Z87PrIYhRo/Xcg45isBImyaEt9a5Cb6YSo9jGIc493UZ5iuCbevPLGF8y0pA1OLFbUefylLkBELr1XgzaD6mv/N0OGBy2f5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZFsSxFgL4r9mVNblAobPsr2dUPIO0Kx8SfPT43XRC4=;
 b=YKBHY1KsmZ5nFQoiNfK601fAgrW6jUkIjKewYtuMjNJSUNN7JHTc1s7tdpEeVcpq+ZMybKvdcikfDTSzMOmbaFKY2j8gY8d3k+6cOmv9OlCH26xYQ3Hti6rhupm+AXWx4Uo1vHloPiLl0eoj6pAi80ddB83NhlQKqBUpF9BGvIY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OS9PR01MB16957.jpnprd01.prod.outlook.com
 (2603:1096:604:410::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:56:17 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/23] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Thu, 26 Nov 2026 16:55:26 +0100
Message-ID: <20261126155545.3834937-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OS9PR01MB16957:EE_
X-MS-Office365-Filtering-Correlation-Id: c3607461-6f66-4b80-202f-08df4bd5ce44
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024|23010399003|38350700014|56012099006|10067099003|11063799006|261028144727099003|261022105027099003|261026140227099003|261021123027099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cFOhgqTIOtHZqa8BWo1r7nau5D+cWS/I3ZGDE0pYpLbhF56PE8zQ1Pby5MqPQxSFe0ZQ4QGH2eGcZSpaf/MPKGlgnLdDhQBp+JJojnOc5q7rier8Tu0OXLNelIWuM1zk/MEOvC/suWi+JE7WTLHOItaCc8ZO4Paj+6ExZmQH+R3cwxq9rpHMaplt8NLLC7z7cw1J4vifFdtxEjl6vaWTqP3utiiL0bOxRo0wJNQGm2oT5Fx4Ixz+VKETZ11Bf0yprMikqFRPbxT+V9Wi5kImGRqulp6FszxtJo2MwXQ6yos+Ku4IGxs0v9qbo3yIn0ZwktNQPXNs7hbjG/FAEkhpxWqlTf5nNpEOFYmW6CB826SkmzImVRP6gDfmBn/r7xRAiUi/e70vEumRmFG0xRfbR9CE/oLJGempY/6LQ3S/cc8n6m2GukcCdeXpkhzM+nQBuk5AVD95GNXQUwNmAcnxDUsNvCGj8A5mvTyAtSjzZADOtCKh1YKZaUATT6pFGK0bkHDYYzOhyTR52OtXP20kNlukqlfgLkyEi6qANP36JzfGwAk2ToH3Kyipj/lECc+h1xK0O9j62lWQRGkXEn4Tu5vXnbCfPFw43JGDS81Auso2in9v/89Gb1yELgFLf2ih81eM4DS7JEVpK9PzuGPSXWf3E2PeywUApB/vH+2vx+k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(23010399003)(38350700014)(56012099006)(10067099003)(11063799006)(261028144727099003)(261022105027099003)(261026140227099003)(261021123027099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s33NoSoygKMzlKHxM3KpfqXignOCOORxP4fAnZHjejsBORhLEP/8KgUYInGU?=
 =?us-ascii?Q?tGxPtDuRWKaKrxgfU3CFORYSxhuRK/lDy+QCYO920JMR8HsMw2BMZpQKZcLt?=
 =?us-ascii?Q?/53RcOhxDZvQpkqgx8TqKpD+S31iMaMDWV2RVN4IKW85rhU0xhaKBG270BnT?=
 =?us-ascii?Q?Ku0S0PW82C9rVVvfGt+lmdhwc0O5sVUR9plzjoC79flfOEYnoruXa19F8Gol?=
 =?us-ascii?Q?gWSLZ9yCP8L7TQenhwOzx3Iix6r9i8CM71l74ikJiNqe7sEtTRsOfbzlZM2p?=
 =?us-ascii?Q?fPrUhyUa6b6KuI655Aw9cT2a4Pv9hkduqSkdvKtIHbfOuy5G44r4al0y1CKu?=
 =?us-ascii?Q?H/ZImJjroHC87Xz4n6TweoHHzGQcNJ2OHT7gNSJrx8GcDKknAFotJiddovLh?=
 =?us-ascii?Q?yRkCtTRbXvt9eHcs1e8M8S7qddgQRjSRddhVI2bvRFmam4x7t2JpCwtFR+O/?=
 =?us-ascii?Q?gJe/s52mqbkPSCQ7ZdzYv4ScNe8vcHqE59b8KlK1o8xMokugowPzZAHnQwQN?=
 =?us-ascii?Q?vk0Nxiv60ewCaXuTAe8Fi0+H/1WLBz8glDiaW7Scc+bSLD70AxftZ9R1fgrG?=
 =?us-ascii?Q?horUP9O4Ap8puf+uu3raq7+9Wxe9Yx3mxtbYgr4MibzvUsl/3im5aoreuC6Y?=
 =?us-ascii?Q?IfHzeVlu9e7IeURSq1Q6mWCVLU6yyfy7+Kbbr76u6qKAe4OffqfkbFDmRN/l?=
 =?us-ascii?Q?toqS59JmbJxNt3jjncHNWKO5MPzS5TQ+U/Sz/vzqkiGYfmFzv9IsGreh/iOp?=
 =?us-ascii?Q?ZPlDWb/wau8Cwjr6lbBaiThznMKkhLXyb4fiIdjYqGG8eqmU6UWhQxUgfaej?=
 =?us-ascii?Q?kKiS/fl92GpCNqBGOGpiVw0ICTkIUiK1yb05dw6tBgBVwsqI1ASZG4785suK?=
 =?us-ascii?Q?PT1TVrz+KY17CqpyN8PbscyxZhKJg19gJS8NpcL5HBOSm1YJGbDqFtKaKe/k?=
 =?us-ascii?Q?A+p9/MmoHLsB8zBe41EMIsHdWDUdojckCaTVpTb59auexeh172s9nALa45Fu?=
 =?us-ascii?Q?zhEn2s2V5+TS420LEyEMwGIIeH0GXHKBPQSYV/vMIlrPU5QKzBPr3Yk8RnRm?=
 =?us-ascii?Q?7WfaD7fNt4qNchVsLjVHXG4huMhBAHu4VizWbEJE5VBADDSgpiEpj8i7OQko?=
 =?us-ascii?Q?lwnRzmEBLKaODoVZvJvIbKQ9B+u9ChOewzAQqgIRrnyUsBqELIXwbWvnYl5B?=
 =?us-ascii?Q?RwcmaP4/8Uwe4f4LCzFjkhErPgp7NHULRR3awZL1Mu7s1i99tcky0mtAsr9B?=
 =?us-ascii?Q?p8ng+mhHTqLim9Y2zVWmI9XuQSHVRsKOXXX4Nne/1BMJ+GyLuZsucjNlgEgr?=
 =?us-ascii?Q?skAhNk7ba1/ovbA5E4mdatIYQPCOap0gsQDFTqCRHPt9OF2y8SN87zLsUEkK?=
 =?us-ascii?Q?5XFQnBMhBWIo+xTUT/WlDMDL45RdTaHnqYgcSF/Q/oAKkc3K64kkZ8SuC5BT?=
 =?us-ascii?Q?1fJ3xQwLC+hiEcdRDWNtjsodW0WlONU/1apWl61Ust7Ixj2De95IT5A2VXQu?=
 =?us-ascii?Q?siWno0qbF9cuGgb9Mth0b98rhMI9aOhv6N1MiiaUcF7rQKakoNTFGK6QMhDl?=
 =?us-ascii?Q?lCyRSp2wKCmfia3HK6QRKbS37u7WVzg0vw+8ZjiEE6h8aN8xV6V/HxBgFRit?=
 =?us-ascii?Q?/9CHU4D+pQetqkFu31AhwYDVJ0A+6Rl9HJop4aR2ZbaXdlXd/Ln99T5ZZiOT?=
 =?us-ascii?Q?9edkmtm8b2Gt6+6JglaLmjAjvIRO8NEpG4I7sX+F8uRPQmZPZ8n78FXgXSjx?=
 =?us-ascii?Q?Xc/wbkczgDcocM2Nmd4Z4bZTVBh30HH7e4yhoGlu4x55QpkBE1Yu?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3607461-6f66-4b80-202f-08df4bd5ce44
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:17.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxz4O5bp4GYwafWF8Xe8aAHwjvDXXT+7qn4jSVa0Z/YysJOiWIlugitP6WK4/Z8QZdzfB1HbeCgfKCGEIKWK6W9XjXYVcVbrQ1L60ZCQ/U4+CV6n9pgkDbC0nnA156f8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16957
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25195
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea@tuxon.dev>

commit be25945d0ca3ac736c448b530c47e854c82a0343 upstream.

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using
spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260316133252.240348-6-claudiu.beznea.uj@bp=
.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d9403ec2fbbc..d10511edfa50 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -272,15 +272,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *ch=
annel)
 {
 	struct dma_chan *chan =3D &channel->vc.chan;
 	struct rz_dmac *dmac =3D to_rz_dmac(chan->device);
-	unsigned long flags;
 	u32 nxla;
 	u32 chctrl;
 	u32 chstat;
=20
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
=20
-	local_irq_save(flags);
-
 	rz_dmac_lmdesc_recycle(channel);
=20
 	nxla =3D channel->lmdesc.base_dma +
@@ -295,8 +292,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *chan=
nel)
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 	}
-
-	local_irq_restore(flags);
 }
=20
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
--=20
2.54.0

