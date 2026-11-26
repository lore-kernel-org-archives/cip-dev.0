Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.283.1795708115737154810
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nzRMcZHz;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nKgco/u8u75futkPcEH6ed/Il07D/8HxG0GVEdXl49MHLMu4hPbRyJX4515GBk0wANJtx6frqEOLseQQT+uqLCmm44isl9A78Y2+DGEtioWDj/QxEzbDiPNxgfQXd2p5GYNeIf+8Z2+vWSfPHg0f2CxqVzr6ijwT+hQdTgvBBOPDUEyT7LazMcTTHxSfxSjqax7CEJG0cM/ViyP+WS9xw7Xv/BKjOEUlnZ1+OkXPyFLRrGXbUSpj17+XXZGplRdKPdOOvNtKqKCS2OMUl5nShNwMDf6+RUdenGiClgyOPHQ3DOqPgZXJH/OioNXnJKlxxu87IqKSt94DEkVCIe+Ytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJwLIb3nEVYpz0NU+HQ5ACjay1LkmnrXRCPvVqk2fwE=;
 b=tLbLsZ+1Ft0xPzgjkEktVS1DLLlYEPo5rwFL1S7zfxZBYhFbBAP71EUnjmfz8WaD1JXM1flU0xsuOwIIjc0ohPuobatb4chpATMSnUcKXk/7ib1G7qwziWm9tHA3mEh85hfihsK2Y5JjlS0BLHQtlAIVQZXJY4MyHZASB0EC1jOS89DrcLfM/8MUVtGrH3zYJmG+nf82SYhZL4AW/elMJVIh2bLs+0suFLKnIcAxC4fOX87BPwHqQOCnqZ+r2JC29Qt4TziGulG05KcBXaPfEZTOpE8m2zJyQKjX5DBNB3/adkbiW1+DEiW3X0Pk2LgC2j6GHjRn+gQgkcjCYbx58Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJwLIb3nEVYpz0NU+HQ5ACjay1LkmnrXRCPvVqk2fwE=;
 b=nzRMcZHzsP0aRW4JZBWeJEFB6KfEowAWMjgek08DcZYJa4B1+3GzTfjme9hX3H+xzarot90OMxyJJlnp/crxlKfXNt2+HM09rjn1I7h/CLtVAZ/AcQlxLdq50oWE2louU/x3XJXFwCllTxJdM5idl9tyXXm1g10lvoTIMlmxpp8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:34 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 08/27] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Thu, 26 Nov 2026 16:47:28 +0100
Message-ID: <20261126154747.3832917-9-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126154747.3832917-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::17) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|OSCPR01MB12784:EE_
X-MS-Office365-Filtering-Correlation-Id: c3d82cde-f397-4e30-3870-08df4bd4ba81
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|10067099003|11063799006|56012099006|261026140227099003|261028144727099003|261021123027099003|261022105027099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gSMC6nVrf1B6XzoJw4ZnE1MwRk2/jqvs1scLp+XPA2Yp96tqURxa7fpF+aW3WtMeAGzIlhvoqpjGGJrwLXnMcXbjZuIweeqrT+AeF69evz1UN2HCBBnqGt3I9IjTgnkS1u5TLb+FpCZUz6iBKUzT+Mr81YSqaDlr7aeoitnTeEGKcTKtvVQSyioestsEiizfttakLwV1bomvGj0h+SUk+YEBmVApuxWSvl5yzuQGNIldrKTbLTXrczjBQ0i0OO2DefiEqNNO2efWj2Cmwjx5Eai3gSEP6JAqJzuWrqLFu/02kTicRkqf4GENcK0VWQnTSW89wKqqmgfkIwQDAXYmnhdrAgXZRl31jGfR7GDnlxSJRqt3RVA06DVbIdXNSLMbB0TYwNmKT+ncfugcD+7moWzUAIEhKbnVdHB4wlVqgwTwgh2BoBfbbegLsMajxVkRP26ZHfT++ww+A6yA6eaxQfsLyhNwp4KlEWdQWbBpfCU5MOB8V2rynNxg9S+7g2Px6MQsCCrRAwH4rfzVuksI+nNLlm1b6qrOcNiWP7FSMA2g4sA1uTIO6V02Mw/F0HxSVEBIuQQsC0HX/WxZJgCS7zwtUKnSJKPHAEB5sxy33721aofRvSUGSfoNe435FLPC8fFM+e0XGeQkwXL6dmFtQKC/8Qw3mtwcKxjTZjpTswY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HY5G7xinwGkSMK6j3fc9q9/szm6VVauUQeue6cvuHMI2jepWTYkH0ijJ4hVW?=
 =?us-ascii?Q?LQGQOhHXjMv07TBg7giuM/pyF7q3uPpCuEwWlI0ke8Fx/GW+76K6nqZzz5Ld?=
 =?us-ascii?Q?gH5WZXsTBplyyMYjecePgxw0FdEdJJZ4g9V3U8ZeXF/ALfgFKMitzWY+l6v/?=
 =?us-ascii?Q?AFGcKjZQQrW56f7+DNLdQ/8dpnlxmMg6BnVNCYrhQs2725jdNr5ZGUgv0QSV?=
 =?us-ascii?Q?Q3TjHzPP3ARTj9C7M2OcisKvQXLWOJHBt/CFVazFEbwfDN2f8p8jBdvhTHd1?=
 =?us-ascii?Q?hoDwZsEnDVc0VA5gJqICt2g0mUl3OzIQMd9N3HuEIdgJNxUmbp38Is4Mn9z6?=
 =?us-ascii?Q?RFWQTOky4tt0KjCucecqJqJJn2AJQvdbJ/RuBWaiE4nsMNs8imaB/pIm0Zyl?=
 =?us-ascii?Q?63fZeZeWRGJDmfzHlg/6aHGhBPsjjpiaynHGcwnsNXpqwSc1UoNRlmqU1j8x?=
 =?us-ascii?Q?i3wnla02RuHZu1fjvO3DnDfaYvy0QgWMfmqfn0nG/BStG0Nvzvw27EPsen9Q?=
 =?us-ascii?Q?rov2YXp5yQt3fTn+csuQJy/viMOvMIvEe1upqRmlgCI2F/KbNC7ryLziiN44?=
 =?us-ascii?Q?7tSSCM4uJJ4boo5lwqo9srzxuJOo8FHCiC2b8w/wFUOo4uwgnOaQBbwir6wz?=
 =?us-ascii?Q?rqnkJA4PBc901HNEGM7mS/b4zcNBP5FIYg9gNKdV6pdHPis/o1vp5T9kUlD+?=
 =?us-ascii?Q?OkX8PkDut/6DIUztuxCH4/s7t/+jptyDIacgDBROYTlfF8CNdsroieFHnzNI?=
 =?us-ascii?Q?+uB7V58VpDuVtcIhayHGpShy1cqvNb9bXAO8Y9CY342X+MLCgyeKE6MvNmK+?=
 =?us-ascii?Q?iuWw7pSryIwnhm4qNchjmTT7+9kj2uoLl8mtENJ8vRIitmOt09E7+lleDFVM?=
 =?us-ascii?Q?X9EWKKfwgCwHU033xfoxXLX1DSdQM9ERmufwcVUwqMcdMqP1vDF9b55P5Zgc?=
 =?us-ascii?Q?EzDWLZrHdNqqXVDI+VebI8xvtsY2Eyf1lLJn9vzpjeFX+zZ2ewGzxKu0dCUy?=
 =?us-ascii?Q?KmqWdbE+VBmA/YAekHsNgOlHU2eM29ZrslhGHeJWNaSLKXhfr+nYUMJL7AHT?=
 =?us-ascii?Q?YReyceV/cHtZePh/rX9nSncTYuc4kav8qpfToWmMuBmn5duYhpCg2M+pkyTT?=
 =?us-ascii?Q?4xfsuR8CzC+rKCvznxoQKN+bEEEAEXamyCbTkpu6zdWeJ12ovgCIqmjZ5aD8?=
 =?us-ascii?Q?Z5Q4/AuiJQIdkVxLMUg2bZeQhAaEfyv9QykQSLbpLhupEC3+r76Ujd9oU9XO?=
 =?us-ascii?Q?xBl2hXaiDqDGtKYjo1xKOPR+n5y6TERvEWnrWXIgutKHGgdFWPjp2sxe6mrp?=
 =?us-ascii?Q?Dy9Nxfko9Z7EZy4yufkegT+KZkdw/8fSDBG5H/YtQvhm3hEXJbKk/MxKwePK?=
 =?us-ascii?Q?NysT/aPimUsEK8Hok1rF1k+bVA1QEmtyB8/LHFWJU8dkH77q9NBYvDBKp8yT?=
 =?us-ascii?Q?+6Ss+owruKIqzDik0WgUndtpThl/1cldKd2NVmKsF+Gu+zMHFsNrcEZFPU25?=
 =?us-ascii?Q?7VJz1eEWpIdgHprn6ZQrGTcHL2r+ajH5dKcZmkdcwtcIg03HZDMCuRze0w8U?=
 =?us-ascii?Q?rVHK48uL38uZlAtNV3dpdeRTnoDaqaOPQKyg8QK8KZtcjrROqKYZbaHKnFnV?=
 =?us-ascii?Q?O+yZ1gDhKmxYT0JGak3DZWiJlmEaUL97oQxGrxFcZpGwo8ajqRdJ3hlyG7c0?=
 =?us-ascii?Q?Bq4eCdIAGTuBX5i5qMBVQ7/17KpmjfCbmpllnegbcSka51FoKCspd0gzEc8l?=
 =?us-ascii?Q?dA1+gnNEdzKIKP8JsdcMg47S31Tl8Q/BfzIEzz5qT9PmRXuRU5Cv?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3d82cde-f397-4e30-3870-08df4bd4ba81
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:34.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iQ3uuzGDAtDeNWsUe3t64WaQno7NI+dO007hTJFdkMK6RBZ9T0oyeFe+fEh/Z4DpVQmmWTzjqf92Mww5sAMvU1iuus9fI1WIlK2ciRf50QF8X11HuWn0lNE1pH2Ccl8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25158
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
index fddf9148277e..13d964c0b126 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -271,15 +271,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *ch=
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
@@ -294,8 +291,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *chan=
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

