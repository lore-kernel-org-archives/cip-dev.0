Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.526.1795708613559338529
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:56:53 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FwJfd45L;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lsTMfKXKxuFcwNScbewhTyDmIeWtf+DIex/xVihGn9fWm8SV3r/Id689g7DP57gPZilc4LOxW4C1qM7dISmNPwqHnjZ5TLPhj7Cce2teDx9d8IritukWeDfvVwQdY3Sz+E1t5ZGKRtD8VFbrdxZ6Z7uhM8rWVtN85RVxuCRUqrT119GqYitp6z8LI2knmvzbrd5oKeGDFYDZCMMED+LCJquBn1ER10jjEiB6bvExh5Oy5kmtlE/nlov9rEOT+JWzm6xw2gw+NtsW/4ZGZvZmBIZM+DFtBqzUVzfcI8H9o0f0RtZadfbz92Vfw+UzZ3t4jFbdjKkOqS2d0miNj14YMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GZpeAtbO/dSFppILFOfaLjaHI9q+0QY9QGXxyUsp8Y=;
 b=o557FEd5lbBOd62HCJf35GdvW1Zp+5rkWuCv5gKL3G9aYzZP/CpxzIC6nEkpOTU2KRDbWUTMTkbswr2KIK3sc8wjdBuAr3TPdOTrMK1ihqTXHwO7mtxUpRL3qzgYed2QbTHqWkhFJRzH+MAiK0g/UZGqTuq4i2xLo6eng+vNU5h628id5rUVisb7+TySDAVvS+lcP+2yX+7L80O4vo6Jj7EsushrvXSatC6pg1UctoZk1uDuR88yPoePLlXL/ZR/N+Dx6xFARD+lW1Uoh9nUfiHdluouUzsIWlHdrSrNe1S5Wf26w1nBwYYa504x433M2NlHM61406JMU9duXJ7txw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GZpeAtbO/dSFppILFOfaLjaHI9q+0QY9QGXxyUsp8Y=;
 b=FwJfd45LG5iDsWlNn/fk7A/w1VQ+acSf9bSuCCoQbrq5lERHTvms/P/gVtS+JnSp5FwjiWwnPx+heFqz+Z1uvg82+fyXjHLLeL7QK9sory4K4/vujrP6tvbUzLfDwULdvZ2lRQxuE9cesHPanPxwuNjYSCXVy0nJbswFgPQNoFM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:56:51 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:56:51 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 17/23] dmaengine: sh: rz-dmac: Drop the update of channel->chctrl with CHCTRL_SETEN
Date: Thu, 26 Nov 2026 16:55:39 +0100
Message-ID: <20261126155545.3834937-18-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155545.3834937-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To OSOPR01MB295138.jpnprd01.prod.outlook.com (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a46e4aa-5798-4a64-e32f-08df4bd5e2d1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|6133799003|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026130827099003|261026121527099003|261026140227099003|261026135527099003|261022105027099003|261021130227099003|261022113327099003|261022075727099003|261022115727099003|261021121427099003|38350700014|261021123027099003|261021133027099003|261021135927099003;
X-Microsoft-Antispam-Message-Info: CQeHRTZtFHOfP5JX/6g9lIlUE3vK0CeasE63vh76QJEYha3APNTvLbMfH3B1XU3limThoxGpF6T+4Iw2H1TTpwTsK7vuB2tiN/SrwVUF+dbmvHFudhqGUdTG9Gex7Apxxj3ov11uSe9ryF4zMzYV8aCAiGgQZE2UPMA7njoSMOfCAwLbn1C88t8jVUKFPygiRc+ahB6r91Aup4e9gd5aV2GeGV0lSSM8QcbPxQcmGQsHx89X1AG23vF/RC1N4aun6OgH/ew3BjJJhuNa0ax2uO7894aT2UWYAchoRJr4AQaN0Uxi3q5HnVVyIIZXu5h9jBI10c1R9GIJ0FsH+EoxVYDkTPe/Xy/cR3wsNNYA5RfLvAAFo4lq9i1jelS3bnnbiNBv9CdWAd6FIZ93e24wQFXBNt1sujoQi+XLdYwnpjvZPWALFLr3Mq8TVKfKFRZpuWRxAtkKRUdqZOxnIJBvPqfBVA752YEQs3anE2RRkm0IsBh1uvQ+QJuh+iKRUvq9zffDaT9ZzQQJBPSRwpskPV4Z9zri4ZrMq2odLI3UT2x+ITkaVtZjwyQUEzuE2Yz/0VrFD6/HTTRqZQ6c6ykrZXHuEa0tjer5M5iHGu7kT5v2QQBiuRreC5xq2gc89l4/q3yG8VWxksp+J2H3PqJzssDBCLHloV959uCVhByaeH4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(6133799003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026130827099003)(261026121527099003)(261026140227099003)(261026135527099003)(261022105027099003)(261021130227099003)(261022113327099003)(261022075727099003)(261022115727099003)(261021121427099003)(38350700014)(261021123027099003)(261021133027099003)(261021135927099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DhW1fUA3/jtQ/1LBYkI4BLxPFK9+eUyxuTexiHR8I17pM4ZX9K5exDHP5UM5?=
 =?us-ascii?Q?oTaPRmr0dZJNmnhyzWxDJG2kibARYCJTDzo7lUva60zzNQ8jDBDqKIj686Zk?=
 =?us-ascii?Q?VDKVWI8IZSc22L4BCfaG2/iaJIPIXP8OGdP4tixSWZuCHJ90Vsuj6KAbzv05?=
 =?us-ascii?Q?da5aUyUpgMG2AKUTJcZKBGBElMMVF4fxQaqIAue15sGxl1ZX8uDQhJQ7TueZ?=
 =?us-ascii?Q?H0iXPF+OFyRTk2jWZtrlKMTcj6xhH/tfDJaMwH/zggItWnGwC1iWnnlSw0Ba?=
 =?us-ascii?Q?bnFFl5wXnODz/MuRFVyOX1G5yHIudNLAaTpP40NnFnQoO28gcdRBPHeRh7l+?=
 =?us-ascii?Q?g5XNvHYcbRfAFC/HyOdxPCqXQfg0fDx/pa0H+nf8m4VqBQe3oASM0PInSJLx?=
 =?us-ascii?Q?vEoGPvwi+ga0fMhi9icEN6A3GGml29nZE6XmAjgQQd52gB0HljTRo4Gp/QV+?=
 =?us-ascii?Q?eQ4PtvmPAcZQ/rJbb2uZGH2nya0+kjM1cahwpUXOZFjQrNt2BF7TorgFdRXC?=
 =?us-ascii?Q?3P9ybEFkNzbVd/OLwBbe0QrY4MJhFReND9ZsF4YY0zOx5xgspZ57A0e2xhJo?=
 =?us-ascii?Q?sRTTxy/wjqG3FSEf+vaEmaXqwLzmL3+VWFgXVRPsEIeEcCyVBHqHbRYCLuDt?=
 =?us-ascii?Q?vXlxMOU+RoLpn4dw9D4zxPVh1PSsmP1b+5DtZiNLvmHZVdb42dg2hYq32HtN?=
 =?us-ascii?Q?ptwZzJ4USx1tmcLrMeR/CDWmQUbsKnPt37srM4kHUJvHmikWew4kqme2eyAP?=
 =?us-ascii?Q?WH7ukXEFU6ZibBNUrTfeXl31fJa6oC5uzze9VP3MVo4HWgQwkLU+0eZro2Up?=
 =?us-ascii?Q?8c+nHz0eUUG7cyPAhWr41OljI3dpMO3yMFqe64uCSLmbAElJxK3HYR0FxHWJ?=
 =?us-ascii?Q?G+GqE6oqbZbYb/fTkvgqoT+ts9wP4CiV9W6SHIG7e0wET0v0eIn2sY4odoWh?=
 =?us-ascii?Q?embiBxdxJRFe66U+tZMUFQTQKS0SzNqVQchnPcpeqGsoGEgsgSW5dD6ELEpE?=
 =?us-ascii?Q?AYk+XF713QL8V7KWAcL3USNhzp7cMreWLbFgKzxo63aHpSi1J3ocq2CRRBJG?=
 =?us-ascii?Q?rm5jhen6eGkTK6Q6Qxnur33ItpDsrhP8zTp6tYnY8qK43iHBqouNNHB5g7wT?=
 =?us-ascii?Q?2EikY5Z220zaiH/5rBt97FC+WZZDVCZ3ADgX0LnEIpRKy/oInDznQE1nCL9s?=
 =?us-ascii?Q?aqws1RhXo1qImopDkbhHLLrRaAsZdOATVzttaAfaYhvqz6CriGe2czaZ/rXG?=
 =?us-ascii?Q?B7xjm+gXJcLnyXQFnlDgVPrhMQtgBJjJUPaj+pBQelXIxeTruEFI+DSkDUW1?=
 =?us-ascii?Q?Cb0RNXEEG3Kzth4D/7+TF2oZxVZIJDqMdY25N4e5adx0AJe9bWigKqwtc5Bs?=
 =?us-ascii?Q?c5ZIJ072CcpIxb/60I47/tUukxFzzkNxy/NUHCWxAFrXAS0LJtjqsHXSk8x4?=
 =?us-ascii?Q?tyLkarGtKgjeQ871TOzDFbrWlKFzucLGxnYMucSKXT2dRNml7fLNVMc9YYbh?=
 =?us-ascii?Q?Bfg63DPZE1F56mEuxwNkfJYkGt1wMqreMSiuFX2BcerOMFhChb38IZMZm51s?=
 =?us-ascii?Q?lXWVSwNqIJX+qCsCiKj+XJLrlsl6NTZEYSv/21RazbHc96DHOELegaJs6kaL?=
 =?us-ascii?Q?e+Z55agoI7MI5dxjrHFPB363OPVtnAQ+u0m//mwRhznUe2w8MlWGAuBc91CD?=
 =?us-ascii?Q?ROISldKoXteHin6dgRyxpx8meUhprU50PAb/s/RCU5tkxp3e4cUf87N65Jv8?=
 =?us-ascii?Q?jMqWK+D1U5C26ZbJ64L3ac/DUqD2zpkR9cDHD7j2dJ05h9jy8pov?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a46e4aa-5798-4a64-e32f-08df4bd5e2d1
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:56:51.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5BkqkxjUQYnqqSq21C6Ze95hNS+uLEE6PBepw7yYeGqAJfk3QkywWM6z2gMCuJNKx+lZNLsPPtBZ2BKQfsjEZbFIimlIQTMFxVIvlVO0ONeSkuCve2tJOMpfMjzF09nq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25208
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit e8baee1d1cddc8e2be7bc362d6dc3fcb2021e873 upstream.

The CHCTRL_SETEN bit is explicitly set in rz_dmac_enable_hw(). Updating
struct rz_dmac_chan::chctrl with this bit in
rz_dmac_prepare_desc_for_memcpy() and rz_dmac_prepare_descs_for_slave_sg()
is unnecessary in the current code base. Moreover, it conflicts with the
configuration sequence that will be used for cyclic DMA channels during
suspend to RAM. Cyclic DMA support will be introduced in subsequent
commits.

This is a preparatory commit for cyclic DMA suspend to RAM support.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-12-claudiu.beznea@ker=
nel.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 54f59462b969..404af9b8a8f9 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -377,7 +377,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_d=
mac_chan *channel)
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_=
no);
=20
 	channel->chcfg =3D chcfg;
-	channel->chctrl =3D CHCTRL_STG | CHCTRL_SETEN;
+	channel->chctrl =3D CHCTRL_STG;
 }
=20
 static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channe=
l)
@@ -428,7 +428,7 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct r=
z_dmac_chan *channel)
=20
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
=20
-	channel->chctrl =3D CHCTRL_SETEN;
+	channel->chctrl =3D 0;
 }
=20
 static void rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
--=20
2.54.0

