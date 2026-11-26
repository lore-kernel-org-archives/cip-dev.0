Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.313.1795708127015319456
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:48:47 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=DCUW10Fm;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7hjH8cVsrcNJdYGhNLwAdihOs1GQOtcZNaa6Cd/xk1rxhEMcnaX3hOGw5+J0UmulZFRP0glDXFlE3HhWLkURvgZFSqZKIKBfTgpg7kglD8ctIGjwwfer4dgC2C2EskYFXcXDa+ilCcwOm25i5cc1I6CE8aCG/L3/j+pk2BmoFBy+C29bwL7ytMDSRtXdskGPK0g9+ycaSF4K5einU9ANHbAiyg2ocGOYYuvtxvXztWhNtiPmezrsXqYCeS2lR7sENVcvIl+bJ2rRnrkvDInFflvrfBxpgECIiKIEFrmADpvgxcNIqBDPOHMH0JF5GY+V0IFJYYus/HXmZI6muZoMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoVRqHEe4UG4lkQ4EXSzGqbz+4c2MyreeRRg3uZbuio=;
 b=bfhXg+61IT9My8Y2f1fhE08BzxwsqShauQwmAzVfI9m3yMe4tY3YaMMIAnMN9c3m2H0LS4yUoPR1qGBw9MBkbopo3jjccluiQdBhLrflc1+UgAtD9Hx+S3BkzEWF1Bgj+RaT0T1DSXrrA48UldqCWYd8ewWhWxm97sgJx1aY7DwI+R/57dCccia0iUoBVUWBlVgY6Nayxm069tCHk5yvw0P62m9P5ljBnrhd63xdmPeRL2Z4FMEUyWKe8gTztLsEsCbfoRZSG/Tdtix56/21nEAXQDrRq8HvEdZ7SPvQz/7ZL3yBx0aanZlP3J/M7py9qRkLsLDPahfAKOPV6ut0Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoVRqHEe4UG4lkQ4EXSzGqbz+4c2MyreeRRg3uZbuio=;
 b=DCUW10FmBf4HRx2Lws39H5pWM2N7gHCyHF8IaGqCQqObBQRX78FYk1iUHR073IL8NHpEuKHszqeUGBiDtdhrVz2haHnTfI4MVeRZ31K4KQAG/DVkifCRLxmXNasUFCtgMogrFZ6ulMurJTLQQ2/RGnYvL8kP/cCAdNzKONM9bEk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by OSCPR01MB12784.jpnprd01.prod.outlook.com
 (2603:1096:604:33b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 15:48:44 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:48:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/27] dmaengine: sh: rz-dmac: Fix incorrect NULL check for list_first_entry()
Date: Thu, 26 Nov 2026 16:47:32 +0100
Message-ID: <20261126154747.3832917-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0f92b4be-afd0-4317-a265-08df4bd4c0ad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|52116014|23010399003|366016|376014|1800799024|38350700014|261102123227099003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: CCk8MLYHMtlGfg9RO7JCKE9J+OUI0sk9GwcjE8G2RJsupcgUBC9yWlwbYGT1f8uzQNNTnXvfgv7p7H7jMztQyDb7nKsAd/ybtLugvhRvKsH/oKsGKf2WdQjVi+vxZ/MmNPc0bV5IhExg6mQ9vzm9+SvA18zR3+jtcHmWB+nf1ksBm3K5qhi51yx5oJqTZjSTiFlKbKrNThAGLrLlIq6WvzPTanYwj4x02SMgSV2NYoR1LZNRw+idfOyrOxbiWRTDvkZWgUSE5fZtkgSVWJa59aob7tquUA82LoDPP/1Da4O90RNQv8Q+WlgRRhcm47qCwX1NevqwNEYNhX48R+HIYydA8GmOnei+cT8CN1IYUR5HCxWFizRLrP5Y2MmAkLGMWP4CRpFd4kLE0am9cF01sjioG2MG/c1fygdDK626QvT3ipyAKaFxbbScpiWmBdpxzIpbBE6S4apElypdY4XnaqTjBJ9deQ4pxfaTZbM4cNZYZkhU2jPBd3rKkvAxuN5an3YeqfFCqJxJracBko76HZeadiiAL3FUtqycudTXfbjgCQLsNLN6YF76LN5FYVV0XNL1MQ+Gu/UqnrQ62CacBiGmMzAXTkIONtD7Gq6LmWVz8r10Fd4fMy7mHhf7X9rt8f/AOmYr8ab9wrYapfqXLj9WkM8izrWollXlD4Z1v1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(23010399003)(366016)(376014)(1800799024)(38350700014)(261102123227099003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oCvZBDljKHGIvB2FJxP93ZQKsd/IzSAg/n3uAAVFUcY6RhhZF47pNK37Y94w?=
 =?us-ascii?Q?/NQJtemfSYX1OhqwhA9uPURarzwliS57XiCCQVbKCr4G0O6gFoKofv+xyydl?=
 =?us-ascii?Q?KUqG4OdgW3MMR2O6auNJwNS6FuCuW4ny51tJ7wLwrBSsg7fMsDYeOmJzNx+F?=
 =?us-ascii?Q?1Ugh5BuoRh9Khtpo6q10EfIkeqdhq39UdLwjPly3izIq/wd779ZUOMXmzYRA?=
 =?us-ascii?Q?jlqNSfTmxkXi/MMSSQZvoCU/r6sG0CRb8sEPnXzAc5qnRnUbdvrZOBgYuwkt?=
 =?us-ascii?Q?6AnGX++/oYuMLeK1OhXv0/STww8De6b+ByW8D2e32jkiaouJm97el+EXCk4I?=
 =?us-ascii?Q?tBC0nvL65ZSjKMrEfodRNsE2Tap1i7eDZ8UGWz4mYW1EHlMxMFdKtoMZ9CFb?=
 =?us-ascii?Q?1r1V+3rMgAwxy9MwnPg6g4O4bzYYHgoBebclPUO6VkkFwZPPbG86RV7z6tDI?=
 =?us-ascii?Q?vny7kO7x8wd6vYckamz2Iu+CddV9tIqAfBwGeVDSfad9LueEn16693/xUaN/?=
 =?us-ascii?Q?Va4m9YsAvrq4yLE/up5cqyPp/GIqkVkSuy8kjtgjxagglYvrqu/IP+MRGvvp?=
 =?us-ascii?Q?CkEA+LAKAKgov/aryTlBaqmxMJcum64scgfRkLdQ77k2Wmp0UeVl7rJB+TeK?=
 =?us-ascii?Q?117HLqzcVLrNg0CFQ/0+F1R6Qg4QUSMOQJvVx7rspcgFwbfxg9+I6pV40I2Q?=
 =?us-ascii?Q?2oO4T3H5DkDiTzIpZFZkj/w4ziqQQGuYLIxG/PKhw5alLoj9lX+DIyngkhmS?=
 =?us-ascii?Q?qhG/rR/40S9LIOkf7MEKBZx9SD4Yl6iHnVSMg1HnYi1BBa6l/wE7NKW/Dh2L?=
 =?us-ascii?Q?a6CLFYZu2H4E7l3VftG1zxb4P0MsHYNMA2HpFagrMexwStPHHMfL2PhgPfhW?=
 =?us-ascii?Q?xyoDtWnKrO/JugRai3GDqdMJk9K7xxRLJyFXHUzTHslvmMruPFP2mMTl+w+N?=
 =?us-ascii?Q?j0S0NEjFl1k6c55dfAZnmMtb/jaM7qGXb1Dn8iDSaX85tbPhXPTZXsQ/UzWN?=
 =?us-ascii?Q?VctklQsMfrB6e1aQ3a0eQTMZiLS1aO9MlXT4gVDzrw617e+RMALqBM9fy041?=
 =?us-ascii?Q?RrLssXCvEpPn3O4ZS8araLBfOvT4GOEismqJH86vDVC7lk/iSnJK+v/Ykrjb?=
 =?us-ascii?Q?UH8l5mum+h57twgSRihVXCUlQ4V7m35qgDpYYZk3oBctJxXc+b+7Qf3CwTnZ?=
 =?us-ascii?Q?TucJmL7QjOpnDI1bNI5KImAIwkxFeBuXljTBfAeTlk/g8G2PZPRNata+F4YC?=
 =?us-ascii?Q?++xIiTlhDpd6sjfzycAukvJywBmZE4HfmjwTnqSXMe+uI61KoTcYFUL/hRow?=
 =?us-ascii?Q?wDdnjiVzZKbzx6KLhMLwxaHkbMSuHfRTNKLgWNZExdfessHKBVTsjELwSzDp?=
 =?us-ascii?Q?ZmAPmiKOBF8slv2iBxE1vMdIllF68/gQ3fY2Fxcdps3WG4IIaB7Xy8aiSWP7?=
 =?us-ascii?Q?dkhK6GjzkuCtoCbpMmWsz/28HfbOpWi4GrWiuYUPW5HC8N7+bpZxf+CDSH/M?=
 =?us-ascii?Q?cfI/t34Ct8q6I8q70Avf6QIrpLWr1Xm6UIJxNsfvEFlpC7VtZcgCFR6L6uEr?=
 =?us-ascii?Q?l7JfyI54W0QHPrhLeaXyfxKc33bVIba9X0vM1EWZ3yCj5X6I0ve2P17rBd6I?=
 =?us-ascii?Q?ndKsbAkaD2j2hFWu4JkcFrjLafPfOYpARxK1WEdMYNYcq8pKJj6mckjkrM8A?=
 =?us-ascii?Q?NzLMvvkXDA5BqMfR2MF5P03ocjm/vBGQ+LdCnZh+rl4z6QycvELH5ba2dSfu?=
 =?us-ascii?Q?PB+g5zkLbv7DIwR7VCY6lXt+P1yqg6Jzgs0ZYOy3bwB6RToo5ffL?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f92b4be-afd0-4317-a265-08df4bd4c0ad
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:48:44.8157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KWEbKlA3lhHSrwBtMtQF35/taMPt9DTnn4//P1rM15d6dXiOzgWWRV3PSrzqvk1IjZiO93JBnmR9IHZzgNPgP+HDTT9zukF4ulRn3ek1KR34AtOgzEb3IfFf61bq/U+R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:48:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25162
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 5fbf3a2a3b96ef5810e6e0fbc601f82067629bc5 upstream.

list_first_entry() does not return NULL when the list is empty,
making the existing NULL check invalid. Use list_first_entry_or_null()
instead.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callba=
ck")
Cc: stable@vger.kernel.org
Tested-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Link: https://patch.msgid.link/20260526084710.3491480-3-claudiu.beznea@kern=
el.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 84d662ad798d..3cd3687f1949 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -722,8 +722,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan=
 *channel,
 	u32 crla, crtb, i;
=20
 	/* Get current processing virtual descriptor */
-	current_desc =3D list_first_entry(&channel->ld_active,
-					struct rz_dmac_desc, node);
+	current_desc =3D list_first_entry_or_null(&channel->ld_active,
+						struct rz_dmac_desc, node);
 	if (!current_desc)
 		return 0;
=20
--=20
2.54.0

