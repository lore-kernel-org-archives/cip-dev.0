Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E31CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:36:27 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.66])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11005.1781685383669730363
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:36:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=vUkC+gnI;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yJNbOJKQrLswmoUX2d5UjS6ev++uN0NLpEJFfv4gsc2ipNAepRqrbW0TzAEKdh3xh50npPZR8mdqCRlBIMsaqcKotWyl2kMQvIHbdm4oqcpJxsNZIooZx771XeZvEuqhvdBeAAap6yDhkdLBPm+kv3TcIEnpL4itqkIVFwRH2hJWR9DI98X9RrjSQiwVejQAzLXytSkJhQR2MhbuesL5eoO/iOCxcpfKM785pnbH7IfgHd4LmAh1Y/d5PqiQVxzLcWMGWHaM8+73TEL4F0dyAmIEi8UuYnDqtJkoHiNFzeQdigurKvfw9jGfkuzqux185O/ufk5H0Cc9C7NJx/jXKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M83M4mgme3SN3L0BjV/aNoUGf5mm/JzwMRJvDvhilPo=;
 b=Hjf7LFWbBB3DDL4qFGUQJY3cjUwlHYO6/IFVDDgh6Sx/sRfnKiMH2gMM//tbTNtng4Z6VSJdb3FbmeDSxHfpscoMhcBSDB0+LaYWAs+SWNRyU+Kzh/Xaz4NeOCJDJeGlC/ECOT7W0VvTh6lYeVWWaRH4oTtVAJa7U15eH+sFKqprOMKYgA/9UsdqUhzjBBt6JQkIt3V9CeiMhFtZm7rxN0cXvzENiwka/bEipGwUT6LaNRKecS1mrd4WzPQsSD+bUBAMxuIxG3EzLkB6zKwjYhjoGTYI0ReEvw0OPY8/XDkHwk6Ml1FBHa2LLM/3HgPLsE+v1tUPDIHJueqy167ebg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M83M4mgme3SN3L0BjV/aNoUGf5mm/JzwMRJvDvhilPo=;
 b=vUkC+gnIS9wBtkmhuyq4aDe6fn5PacORuqJw0wp7dVzoLRpzIsZMlXd43CuEYX/6o+naFuiXqbc88hZ6t8m7MU58pGYXDNgjnnYUlElMYtwHL8XNypiMqlq0aTsfQx8YDFiGpfqG7+AIdPtTduJ023KbZ8E0YtOyiVGO5bD7DuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY4PR01MB12634.jpnprd01.prod.outlook.com (2603:1096:405:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:36:21 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:36:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 19/24] spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
Date: Wed, 17 Jun 2026 10:34:57 +0200
Message-ID: <20260617083502.1074160-20-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083502.1074160-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0004.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::23) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY4PR01MB12634:EE_
X-MS-Office365-Filtering-Correlation-Id: 23c7b6cc-7c4e-4f92-50a8-08decc4b820f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|52116014|366016|376014|11063799006|56012099006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	rp5QhEj2qMiBGT8CNzUvYzrwxBzBd0kf/Hz9n1lCbW06t2EZjNRskIdLfgsjpsovdl0FJEQpDY5mNFmq5Pm6JmsIok9vWWhqC9iaoW5MEn3aPJdpuabJtvRhao84WR1qArXTMlmBi60zEW0q11hg7/OBj9NEis8Ia2MrPKqwsQXKq7z4itoypkvgtYOT5fFxmUj+vOgVqVbU/7RsGj6C9A6qmy6eHH3uCrznM4YL5N5n7TIyPKQ9oiQFjDl7SvEc4vSqg1dfUIVvjI6RktHG41alJ3jAP92tiIFXEftYwgeKwpE+X/D9WKB0M3Xly6VgowZGRjXTm+k6Q4/IM9+7dSldrqgUzlGn4tVU7p0WeeMqit85/AgjU54nEoHHRHEXy5Cvre7oKyXHraIKbjtjHWBRtpSCx9sZjYrSL9J6tTSL1bbnQPaKoYM99tNHVfT0oA83f7aehnOTKIBLpbpUHyDfDilQpcBo94zsrcBrPu0wcZ7NiwJ6REPHDSJ2JpSgg+6hN/KDX3/d1XLzfSa+C2cnbJbN3bK2iIk6i6a/pSECbzZDUgVfgS4tw3N+F22FyWIZvdgGtJk1bD8eLOsfqlouWArhPnowuYhsYumXEsdfQovzlWSsz38DtKQMJaaM9/WV6+a5IM7fP/MCTXffGcWAnmurGLzLAbYIAp3rT4hngGv741//Ao0nWAyUFk19hVcYEEsZ9Q5no0mTh5hr3w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(52116014)(366016)(376014)(11063799006)(56012099006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OAseQ10rLoRO3QcYYdzmyEVt/gvZ2ab0+lRpgvoEyYoIsm9hYTi2+nXCL3B9?=
 =?us-ascii?Q?blL+NigSNpDzfWJcVLe9OwC6odk3BoLB8JwP+jc5klGrg8VnICDYy/T9xnfV?=
 =?us-ascii?Q?zLkT4z7k9ylu/mO/tIJq4Bm8KgzD99e53/400rwv9G8/bS5ygll9mmrGvqwS?=
 =?us-ascii?Q?uD4IvgDkrB3E7To3NdPWRCzjFXYmEBNMTmH7t2gah0ZZVEV4tSuwdMuUR830?=
 =?us-ascii?Q?eH8tpDEYXfuJHSxp977pH9kQdVcX+gFbhRFZnVK6OTjxhJTOsfc7v9VBWqPK?=
 =?us-ascii?Q?gVEnkr9t0eSAcwkP2hOZa7RYXfSWzVlYr2ye4fDTyT8qLWjDEuy7I89jbzTG?=
 =?us-ascii?Q?m2YD8VjWeSzC7cT3Cxf2lTbohheR8QAKwpM9GFKNkgEEAP7gIgf5QlYJ3Pxl?=
 =?us-ascii?Q?KsbGw3NPWUkCznPvQSJGo14nGUqKr2znvW3h81FS99lRN0hqyo4C4GVOipSS?=
 =?us-ascii?Q?y1XIQ9cJR0HciwI55A/5e83vTTcYldMMh2d36/TZJp44PK0iNRf4yOPbiZii?=
 =?us-ascii?Q?XKQmAJrNhqjxeNXgzuA523QapGk8tia11bhh4DLW4E337CwZ7L/PPxwrOJaa?=
 =?us-ascii?Q?tl3M9BuvmC5yr3ddN2B/wAZbqndtvAuOWrg5QgvW7YJpEiDqGcXm6L9L41kt?=
 =?us-ascii?Q?CZrHFTGsAixkgIOh7lNmBlY6pbzfZuikA3JQmj190oPK2LnQTVpno6q6Kiiv?=
 =?us-ascii?Q?tJuS5JuzJ61pNkgETp1rCOIVovuRT6fjqUaSDT3QCqMlMbNmXtlVZTo6xnl+?=
 =?us-ascii?Q?jVznOi+pbt3rFh6sAr4G0/2fM613iGX7JDZwL73I7kBBEBMz12i576IK52BP?=
 =?us-ascii?Q?295aHtPZucjiYSjkcptv8/Irz8NBw7dY5RoMhx3NqVp0NVVZffxIY8T+Ep6F?=
 =?us-ascii?Q?FiqaPW2zaKOwhJwORrTewiCjM7Cs2p7mh9Y64mD1Uc4T1AxDcpx/VqyHI9R2?=
 =?us-ascii?Q?6NHR6ujamFbCOPmN1rSACUdD+udhrFLvFes7PRj/mimRyUtJPisAvAvJuZLV?=
 =?us-ascii?Q?QLmVozokgdUcTAswmdVb9JsFP6k/QAdxWp15hBf1qmogkRptOnCiotmVFM/R?=
 =?us-ascii?Q?WlIaQWJ0E8FKAdiN1V+KIlfNh3L42t73QXkejLk1RsjKBWv6YGCFYJMPaPDQ?=
 =?us-ascii?Q?RWmI+BSSfOHov71cv2NEzboBNmcoDzS2Q4Z73fugSvJBkbPDuZW729HbA4Ri?=
 =?us-ascii?Q?02fLO6ChpUSfQ/cwR7jO4/Dmv4qhXOSFklqOJCfE+Kq9njMzbmI0Hj10pFy0?=
 =?us-ascii?Q?4JvSgfkWRBY1aU0OAKZ0Y1yIxxzxQVmAniAdRPggksu5+f0QmusfbtK8QglD?=
 =?us-ascii?Q?YGT71AZmF6ddmzfGmhM1IISWM5s2H2k78If+Dk9Zt/zpM1hxm7NETIPdpGey?=
 =?us-ascii?Q?TQSw+NTxEaMGUWnB2mdKxW2I3sgH8yIAgLGg2/uE3NTXknW5yJNinX211vpN?=
 =?us-ascii?Q?IYCAHIggARWI0LaL+6kQPrvpkSs6RuPY2rgvNgzK+JF7N3vO5GiZsvk90zqp?=
 =?us-ascii?Q?BTfibec8IleSfa26a9EOK3aqDkbwIxK3sBLQYUgxlg2Qpk/7MvgKcxJnYtKK?=
 =?us-ascii?Q?P+zkjt2RPXiRxC7ocW8k38ZJzU48MZXKD4fUHYdHLw+CxjtvW5JBBB4R0PsK?=
 =?us-ascii?Q?1ZF6vQfAREPA2Hg17izjtU+A+KgasgKQcN5idq/KwQmy7u1vVutedbklN/aO?=
 =?us-ascii?Q?FJt/ib+4jSCyAffYGSjZZq4GbmUMQdgrWqog3yCPXIbRllzfSNmHFFjyEkz9?=
 =?us-ascii?Q?5+Va3k6Uy+BJ92soaeqZ6JEa2ykk0KsUQLbVsMnHYujRMRSu/SU0?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c7b6cc-7c4e-4f92-50a8-08decc4b820f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:36:21.3340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yq26yfwZh/zlejBeH1KWFRaajoj6ekEy35BpgSPYMWcZIyz0Rc/qhLZJSZGJonF6R7KMfxHE/A8e7zUx6Pd7mEtdhbGvAQRIVFvweda8aC3KzBUJ1UNO9ZyNIaerDzyh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB12634
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:36:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23211

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 4e292cbf3890657db2f2692942cb0f168c80167e upstream.

On RZ/V2H(P), RZ/G3E and RZ/G3L, RSPI_n_TCLK is fixed at 200MHz.
The max_speed_hz was computed using clk_round_rate(tclk, ULONG_MAX)
with SPR=3D0 and BRDV=3D0, resulting in 100Mbps - the exact combination
prohibited on these SoCs. This could cause the SPI framework to request
a speed that rzv2h_rspi_find_rate_fixed() would skip, potentially
leading to a clock selection failure.

On RZ/T2H and RZ/N2H the max_speed_hz was correctly calculated as
50Mbps for both the variable PCLKSPIn and fixed PCLK clock sources.

Since the maximum supported bit rate is 50Mbps across all supported SoC
variants, replace the clk_round_rate() based calculation with a define
RSPI_MAX_SPEED_HZ set to 50MHz and use it directly for max_speed_hz.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260410080517.2405700-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 5589e361fd10..6c7cbcb13502 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -77,6 +77,8 @@
=20
 #define RSPI_RESET_NUM		2
=20
+#define RSPI_MAX_SPEED_HZ	50000000
+
 struct rzv2h_rspi_best_clock {
 	struct clk *clk;
 	unsigned long clk_rate;
@@ -771,13 +773,7 @@ static int rzv2h_rspi_probe(struct platform_device *pd=
ev)
 							   RSPI_SPBR_SPR_MAX,
 							   RSPI_SPCMD_BRDV_MAX);
=20
-	tclk_rate =3D clk_round_rate(rspi->tclk, ULONG_MAX);
-	if (tclk_rate < 0)
-		return tclk_rate;
-
-	controller->max_speed_hz =3D rzv2h_rspi_calc_bitrate(tclk_rate,
-							   RSPI_SPBR_SPR_MIN,
-							   RSPI_SPCMD_BRDV_MIN);
+	controller->max_speed_hz =3D RSPI_MAX_SPEED_HZ;
=20
 	controller->dma_tx =3D devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(controller->dma_tx)) {
--=20
2.54.0


