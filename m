Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.434.1795708446843928626
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:54:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=KO/3EVAb;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOz8CE1qHcEdN5KIum+sLlo313RJ16bK08XYU//I3UTvnvL0oUfT7kulfpGhAI6BWfclwz/2IPPkZjo0P2DQrxlABpeDvsXZHeY5EHSuu+JXNhUsTRNL46sZoBEk+qMlChDE/5KnOj3ZqO5WhdOZlINgVDqZdfeGhPSv6SGYAaX19DnF5uDFAwd6yQ8H2h2DfiJSagdO921Xi8o0zyij8BoAI/ANqKlXkDrHFYHdBe8j0skJNS1W1au3zCUHuPB7hebtXlr516dJZm5vR16nW9dFIVuF8UzsFWrsrNGOyGeI7h6ji8Oi8mmrQcep4QdLH+aHZLglVu0nbw/SlL1/pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FU2qcJu8ZCNJPTd8AtcJuPoMW8kf6lAEufmZ/nZTXXQ=;
 b=WwS+A6/EktcJ9fQtLnb/nhSyCLuHNlBx+EvDNKItPPDopkQKActsgPrkD2D+12kWT7qtD+Fd9yCNzCdbrzYPPmrqbAgOyp/MIr1DyspdoTo3y3S8KEzis+Kl0PFDThsRgcPrL9JJzQ22czXa5gcbTbbgns34dWe/fX+RC/ng+13trQaZ7gkXxk/F6hR5GKMWl9BvNbgFxXuaZz1zh8wnN0uz/KIw+EFsFTo1eb1tvfpZdHCev+HlCksh+msFIVy5L3cFzqjFTMHyMrX9mTmClQCwlMQk9wCEjyDgMJJ6gvCyEPkYewAJA/9WS3RfYA75u4d6W8IWUtTtRQvMsvGIIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FU2qcJu8ZCNJPTd8AtcJuPoMW8kf6lAEufmZ/nZTXXQ=;
 b=KO/3EVAbDSuvAbilQ44MRUMGlC1t1Qh8u4v0jQvBoadun04l58PnVcRkaA42k8XgJuNDxcnU5QXB/17UPJ8OXKqzaXp3DVen/bPYHIeWY2Uba6Zd/33yWHLnA5TvANOuje6fZzrKaLOe+k0Yo46fIN3sCQ6yYifHrf+AccTuRCc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:54:05 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:54:05 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/12] ASoC: renesas: rz-ssi: Drop unnecessary if condition
Date: Thu, 26 Nov 2026 16:53:15 +0100
Message-ID: <20261126155321.3834347-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ddefa46-b719-467b-2992-08df4bd57ff2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|11063799006|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +Qsmn9qpWCY0ZYCHGzxfzdUQlz8FdcDv/xGSANiK35GytL/yacbRT82fgO+44SN+UV2aXBJW/DenqjTnvgR6UmybrKfUkPVgVtlpo12MFL9txeeXip09EHQyMr1Y2N+jDgvcJQZ7MqnPeURzQxy1B6Ys5lUyIYlzGQpTYntsJCOIrcxAzNjDnCJSDnZHJwH6mjZJ1N2B9fRKtOKLCvrpgob6R3F7uAtes8x6H5sIeYF144aNL3RQOfl1D7zNhVS3SDgAM/ID2uC46eyeEihkvK/1R9v5MrUn5gCsjE5iiDrKJ1+giYtDcSV2MtyOI9kj2PCZXCDt4wFN+vJ4U14KOp+uqW+HWUjic0Q12/GFMFfe3ggQJKzkNMS7uXh0kMBe/TNQvNGtHKm54BmuYq6z3oir9BwDXRMfk3oVvTAiUMyu0B8mbFlIUTym6IEIaFGFJ1xwL8iM0AI5UTuHDX0IpfoBUF8fOGjTq2gOY23Ks/eZHqk1BSDPzOox5BkXIZ8gXADpTue3vPKnVoyLnqgUnmhgbNY9qQ0c9HkOzlDrKCm9IDmbnhfENrl/CrVtney4InHkx/WErlziUIth4+ok+9ycjuoVgoi4oaKUEherWc02LJtVXlyNfmxNjt/k+8q8BKufs7XwO/+JueWvLfHnQojK9NTfWc9kpKQ05RmBJFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?glIB/W/VaxwbvK9hjGVlQbSKBrAGjC2WQ9UohWk4gshINawDzkU0UhziEbQ+?=
 =?us-ascii?Q?pEZiFa+MmShUuE8Af2+04JcSpcu/rD15FMyA4mDyHMNcKNkg7+lINtSO8hNx?=
 =?us-ascii?Q?0GRw2JEft55uQ+6a5YhwGf+g+KsYba1b7mr4JbpBU0AY0OXiKMkQLHlpN4aA?=
 =?us-ascii?Q?tjUTlf2lhl8UMqjusfR2uxKzr3l99DGObacaJurPA5Z3GIZtBSt4oYNsE8mB?=
 =?us-ascii?Q?7YF0UeqzyKdrDglb8jNMSQ06VWfRS/yCD32vVMcTsEvLTteGqy1+1exEgo0g?=
 =?us-ascii?Q?ZpY82l8mKo6Xm+0qzpXuEUTi5u3Cu52yvdc3yRIHbcyf56X8oDjHQ3iTBBVx?=
 =?us-ascii?Q?Lm3nmZGDOTw2Nlugq/35SYCOOFWCuak2OA9cRWUvonPyHO4QRcXxhOX+90wV?=
 =?us-ascii?Q?tDDT3y3uRqmNLEndRPj2D0wgr0m2GojhRPU/o6rZbYr29bV/HSRi7B+T/TWK?=
 =?us-ascii?Q?pR1wsxma3zjI3jrBjSxOQeFRp9d4D1zvPZ3dIcnFbU7DBpA5hApEktriMGit?=
 =?us-ascii?Q?Jl1pmxMvDDmf7qf0xaMmq4jjsDSGjVgvmedKJULajjE9BCtctJN2ELLaHUHz?=
 =?us-ascii?Q?xtFqJZlek71dtJRcfxmZ7kJv3KvlVBdXyNPvnNMF4lpHndZgJbyXiGaRMhME?=
 =?us-ascii?Q?tsrxjOG63xVKi2X0oHe/XTvNs7CvUAL/Y8AJ84CPxkg7uQI7rZJoE9BUr/UZ?=
 =?us-ascii?Q?yKEEnKQVMB/C5CFTrS2TV4mg6WEUcmKyj0tj/dJOfXJlL+LPX8tnZbQZNgde?=
 =?us-ascii?Q?tL2L85iZVb6yApmQbH0x8JFoUm+2YiBCn+JMZI4P2baO2zuIWHOtk5nBzYmG?=
 =?us-ascii?Q?rgCJ1Md6LgVQLpmUKmNR8el//v8/QtvOBg3VMEeSMgvr34wEtgF76/8WEjlv?=
 =?us-ascii?Q?B8D97bCv1h556AjLWMBctLTwXMo6EdJpalN2YpM0ytwdGrvlhn/J3SkBG0pB?=
 =?us-ascii?Q?g7W8t9odWn4gaNhCkyjaeIT+tEvGpqL+E96Un3ZjLpvXH6ZYl7nnqXusgpfK?=
 =?us-ascii?Q?K8VF8Ozf6QASo4fxM34Qarvz/WZikSxOhDUOSXp86qAiC4jEbbG+ARfXV2s7?=
 =?us-ascii?Q?CsgixegQWyd8h32W5gNLmQ6Z5Vsdsaf8ltqJ8HffQjc/Wx4hA8KnyB70GXcX?=
 =?us-ascii?Q?we9LBCQfqjaCd1MeKYmpOMwyGpuu4Gpk5mMnneqvl5U0oztzwFJrnrDEnS6h?=
 =?us-ascii?Q?U52z1ghTX+ZYPz/YrISfV0ojy6WJcObJahxDy2Rex6yzZRdCXnlfV3Ze24j5?=
 =?us-ascii?Q?HSAxUE3XWw+DJ8K4My9igsTceZM6ix3RKlbu3d+qdRqKyELGUHSAemp3Msih?=
 =?us-ascii?Q?myehUTE8qrAq3leh7IBcR5MJXfBrzPF0JHFmV8AygSil63dn5aO5zf8V+cIs?=
 =?us-ascii?Q?EfPnnFl08s69aG+BuIrRX764fvdoFP0IpygcYv9sRFSK/XUmWuHBb+bIwC/1?=
 =?us-ascii?Q?yolvSCgQhKW8I7Krpi3BQWO6yZkLIiu2oDgOyl5ZdPvSmRbP0KtWGrLYOtet?=
 =?us-ascii?Q?1AtaQQD4JhqBqkLJTVfiwnSrqkl+oKt90I4FY9sCRxKe9Vp3fP44gjdUPdzm?=
 =?us-ascii?Q?Vi9hvcxihQOhlTas+oS18X6U9WZAOjlupg4PqkNKpAak7y+pBe4t5b/T3K42?=
 =?us-ascii?Q?i5EGpkmta7LcVHpgMBozwddfh4cnEO5so7b+BKkhzJdgnfEFY/hDoGQGv9iU?=
 =?us-ascii?Q?dLa9UOrhzOxrxrIQTMtyWfOXiqElNj4sBZTKiayHY/uIkodDF0qkm3Zb+g5X?=
 =?us-ascii?Q?8mQSee9KImTDKY/ya2n8W8y+ZnytCuplMJHYfCWZJMKyWbFC5W6U?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ddefa46-b719-467b-2992-08df4bd57ff2
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:54:05.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFRtqU+rXOMIYRPvYIh9H8JAqe0MJC1HJiVnRjCqWlRpuUVPW5u84dCLWSMtQV9TVPmNiJKWSzLK/V6jVLDeSVb+qn4pWhy1s/MkwAxNtmkKH8p1VCCV2d6+bqNQx7jh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25184
Content-Type: text/plain; charset="utf-8"

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 9e0e337cc6c7f30a5986dd44dac5c0a0e30d971f upstream.

The is_stopped variable can be initialized directly at declaration,
removing the need for an extra if condition. Drop the if condition and
initialize is_stopped at declaration.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260119195252.3362486-3-claudiu.beznea.uj@b=
p.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index 73b6c75adb8a..d38653a825ae 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -605,7 +605,8 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data=
)
 		return IRQ_HANDLED; /* Left over TX/RX interrupt */
=20
 	if (irq =3D=3D ssi->irq_int) { /* error or idle */
-		bool is_stopped =3D false;
+		bool is_stopped =3D !!(ssisr & (SSISR_RUIRQ | SSISR_ROIRQ |
+					      SSISR_TUIRQ | SSISR_TOIRQ));
 		int i, count;
=20
 		if (rz_ssi_is_dma_enabled(ssi))
@@ -613,9 +614,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data=
)
 		else
 			count =3D 1;
=20
-		if (ssisr & (SSISR_RUIRQ | SSISR_ROIRQ | SSISR_TUIRQ | SSISR_TOIRQ))
-			is_stopped =3D true;
-
 		if (ssi->capture.substream && is_stopped) {
 			if (ssisr & SSISR_RUIRQ)
 				strm_capture->uerr_num++;
--=20
2.54.0

