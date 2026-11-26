Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.583.1795708916234460591
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 08:01:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fGmXbU3A;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hFnCbv7/IurTO5H9ThJ4BQVFMRwBu7FgGSWeF6uBBkUZIYAfetEtDxiBwHSEicwV0AjY02Jzk2VUtJVJXnX3aiGnQNRIgC0W2I5jP3BqyAHOryPb03AtiwCIcQMmE1ALfwt7ORuEPD8brvFpx/ICExt1f9xnB3MQ+MQBzUl0pSXzNiSGYrORHsM3MhVwekJYGZ/0wBp/QDy/DQjUC0T8GnbK+k5cVRkNiLtDOi47wzwYLds6bbqQJzlATRRzyrbaJC4liDPert8bSoQvNY5Z8Hkjq7xUqHj3g63pcUj+DD9Pj7myr28KPh9lS/FS/C//bi09CqdPDK2zCwz9hZE3Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ssN2QZwseLMyA9EVG1mcrOn0iQ4/XLqDinTwIQvZV4=;
 b=G+K6laf/2wBAJZ7iJWeI0s4Sk7vJqQqDzs66MDD6JuafiM2NvgmZL4KPAz4WiQjHiKBsbOKCyG2zfZAh1lGrczRhR+R2U75/P+Co61EX4VRTtQuo4mawa36zMGtFYUca9/agFbw1bINsYy4mpLHIBypVetUpElREpwpmGgRW42FR3B6l0Is2ABBDvhlsRxkfHZ/anOYmT7/aLdv+uFbxgTURLiHuKK5VR/+WRaLDcvgaGxPO8FWgwOn0Aa29AycBc6adPnfcQVsSwfUaeBAdq2W9kbRUkYlo/3sWkdaQXfzBNQapwoTY91egvnxStGtRxRErlzB99iM+tZzJhLEA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ssN2QZwseLMyA9EVG1mcrOn0iQ4/XLqDinTwIQvZV4=;
 b=fGmXbU3Az4syIj6pE5vnH4seXl39lyeiKabumrrHauWIGH0lMStKHq3gAMK0c1w1o1lrT360oGyXQMSu8wf5LEqkZHonIc4/lDZRbt86zpYBmaxGZmirc+k4DzUXwm/k+jWXxskxl8T0sg/tJhnzTEF+3hxM6N6pUcCFaLP+w1Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY5PR01MB181845.jpnprd01.prod.outlook.com
 (2603:1096:403:50b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Thu, 26 Nov
 2026 16:01:53 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 16:01:53 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 2/8] ASoC: renesas: rz-ssi: Drop unnecessary if condition
Date: Thu, 26 Nov 2026 17:01:13 +0100
Message-ID: <20261126160119.3836850-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126160119.3836850-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VIVP296CA0010.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::14) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY5PR01MB181845:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d2664ba-d310-4656-ef11-08df4bd696ab
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|52116014|1800799024|261009223027099003|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021121427099003|38350700014|261021123027099003;
X-Microsoft-Antispam-Message-Info: 7ouLjNwFq8oUEqJNJXCfPTxnqBy8klvLyHzfllN+ik0me7poHlcOnqAbayLAnaU90Iz/DnmYknw61XA8Y17LSFHXogu3LpP22T6hZgL1jJhThEM/QExz82XGVtmNeQ/cR7s0XSbKrO/tOjynYuHZUy3aqW0u+ffZYmlpsWerqhNo5czJbwKZ31W8YjLHxKKiHIfGGDIwgNCJaTZLiu/68PQ9tjv/ur1SFxFGkmul5dsQDHnIEN08PueQsj/D51yhTp+B5F5oLYe8IgLZ5xHWvNTEbVBM885cy8Yn7uoIRtL2dDdK2xsqx5pzLDIfEMyBvYZh71g1NIjygzvcifdSqaoQHu2/1I0H7QX7dcFjFVh7ldoyjwPjgGDhsoN/ItNQjiEog2Aan40XR/oPJ3U8Hy7eSNYEso9ca1vXgFkWl2viygsqUesCOKfKdgHVNUfHjI+fSzzHamInW9bjTT0kqeZTxSpxrAolULlJ8P5rIvT12X+YlA0xitf3FAADkvrohjpf/J3HMs14TR0ueL8NjeMBgqcTBfx9m1VF+1K30M+2/9QaJb/VrRryl+h/jcWr/e6YxV6XktW63nc/3HqqnWM3yK07lE9V261h5BvHD9cosfXknRlXmhxcfosNqgP3KxAdCu77+dXae51/nemTNgX5NGEpMZgrnGQSJ+NUYMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(52116014)(1800799024)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021121427099003)(38350700014)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZttPYz2b5rJwXKig8aNimJgekxuzQakc2yfnpR5kL4UqKWJaY4XDAlNpx2Yj?=
 =?us-ascii?Q?CjukPDGErEWU/eV8h4DU32ozBq/heTLnSzZXPbHVumn/B7n/f620fEt3myXH?=
 =?us-ascii?Q?c7B7qcVTmB2OHd/205X0nSSQ1XGK2eURpmYGLya07Rf9sk2hUuFaWP475egR?=
 =?us-ascii?Q?tBqj/GVZ4512AavIUulF9nN/vudmjfUYWMzRL8lDbnciKDO3V4ZWA//C3rU1?=
 =?us-ascii?Q?6KRbBylGjRIOCIwTefYqZKWg+9bV74EjR8O/J8LKAo1yTGjqbt2wOzCNmnrN?=
 =?us-ascii?Q?IgoLkLJ603MZv8Gf5lnhswJzF2LhLVFhzGpYELFVq6X2QJb32+JWa0pOP6sr?=
 =?us-ascii?Q?bQizrEM7q3gyL/aQEnfKEkk75J9zaVcaRBL27asQI2YH8qkOIqZ48rWXFc8D?=
 =?us-ascii?Q?2POdTW/3pcgyxssy0yUrj5z/egBZTqiEPhi0rISuZr0Qyhliyh+Df0ih5Mgl?=
 =?us-ascii?Q?ALtbNo1U1vPGfPRVEVNFBSYPDIdvsHttV5TfbK4mmk2I8axA4QcjOu6eqCqx?=
 =?us-ascii?Q?yi+eZ2nLTMRSGtpfvPJjE/G7707H5mkjvsUixvFKDQYh5ypnFdKcF/l8MaSv?=
 =?us-ascii?Q?kHpoY70J+Do8D0ZE+fTjk7yehPhlYrb1FUWyrkdFj3DoZYIcxlQpMQ0e+hc6?=
 =?us-ascii?Q?Auc1fdq3BooBv8qcrdGhnWO54K2iGtr0Ri2QK8Se+Qr58JlTDAwvf+imUMv2?=
 =?us-ascii?Q?DRlythOg/9RIQpa5+f57nwGUFMmxZLvNxtmrnsczXHsqkKg7aSpAtNcgY16v?=
 =?us-ascii?Q?oq8c4LjtNk6AYqY14qTFtSlgM8b+Ex25BFmz16X/PjeLFJW1tuVFW+ohGMh5?=
 =?us-ascii?Q?O8F5OMAiK6VDToJEQBHBPn9t3Q+p2gH5rrzbcGxDUNLwsMD+nz6FWyi7iyWN?=
 =?us-ascii?Q?JSr3SSEkQ4jPivbZRV3SZIIHs58QDijJtfEOXPH+9vzsqbqvmyyRnuGFsEpV?=
 =?us-ascii?Q?A44y5iC/VqPgTatNRUcsdw8QmWosCdhBMNz1X0itrsLM8DpT3dYVGT+KZpwi?=
 =?us-ascii?Q?iozj+yh6FNeY6+rLjoYCyap1jGwb+4UAvsjqnwEmKkdmWsuOeXyXTerXEaLO?=
 =?us-ascii?Q?vbaGBBHBqqQf5OaYT1k/2Of66CMkj1M/SoGUNxDe3oYctCVWl63QoHQ8nOpT?=
 =?us-ascii?Q?XTU2AFx46PG/eSPqbeAzrrEH9BumgiooXa3qKipUw+IFSymRUti4qw6jqn1B?=
 =?us-ascii?Q?gTAeFIOatJfo+0c0Ozav2rFbal3pIVBhMguFAoQKkSm8BxvN1pXvG2swaKvM?=
 =?us-ascii?Q?JXgHuR7HQr+JGA0SyjSW6w59Gf9fX/E4kxGcuBTuoRYxyWQSK+v+W7yVPU5P?=
 =?us-ascii?Q?QF8T9lbZpvEr9HqGdKKJWuWZvde0epS13yqITYwPAPzQLwQ12ASshCOV8xmo?=
 =?us-ascii?Q?StmApu99n3IeZXV0hrOMRVUSvTf8YzVMtdIYFXHD7zUC10kHwAofK4aRPw5T?=
 =?us-ascii?Q?hKZthbDK5pDW+T4ORnpeSSdFRwZeP15j1TpGEIeG2+V9tasPev1RUuHFNuf8?=
 =?us-ascii?Q?o+roXj8tMBnqlIUhy5S9d3rP0Xw7N/fnWWuAyhcdPWeuotEvty8E/MshDjPj?=
 =?us-ascii?Q?v5RzjjNHvSWzwZe74vunv7J3eoprUTeBUQsq6XkNaIqjF3GpcajZp7zzxRe3?=
 =?us-ascii?Q?o5bDnXoGCCb92ka4W8o3mYOUvhmzbM/8h04itvuu/utcFnpWLrwWDTA87pkN?=
 =?us-ascii?Q?5ygHtcghdNdiouizkuvQYAlqXLD/DBE7nPkRgC0i6M2padCia9smQgnKpxkX?=
 =?us-ascii?Q?G1b8Ao0HzYWHKH5RKHV39g7cgzDRZhjxqvcKGGOrjN4f9+J03aqH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2664ba-d310-4656-ef11-08df4bd696ab
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 16:01:53.3370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bT5O9qs/xoN1t3RxqBD9TgEowOntMDw9c4vBoF3hw7HfjBu75gHMWajd4/l+WxKlRQ/89VH+SsOSww5WkcvkIJSneAB4YPubYlRZsXiBdWM1g0X5ymjBCJZ3itElu9Wu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB181845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 16:02:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25217
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
index 30bcc98bcf2e..86ae5869cae7 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -612,7 +612,8 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data=
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
@@ -620,9 +621,6 @@ static irqreturn_t rz_ssi_interrupt(int irq, void *data=
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

