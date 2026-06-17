Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34D3CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:55 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.4])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10775.1781685112610873224
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:52 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=permoTl1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.4, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BAuzdetgUiYtHdFq07tB0ohIRRjria4ypufJp14tVN6yCo9jPpa9xdof6boKCxmgaqi0BG4STa/c8ZbMMY1Ty4wuOD6rm886lZCGIsGg6l7o9VJEU7/FVfxK2smjbBq+fW/rCGu6RlUEXDLxTYDzcyJi3hdIBEEgg9MFkhoFPF7lL3XMdYIyXKY4Ie31re4YJyVFjbBL/qNZRn1oCy1r/PKirhnrmzkwDobb1QJjabSIwlW9poqAFONi3flQc9e/UQc6ewkxoiNQSDcYjsMvGVNQ2/pruT79FAaKu391t79lJE/+V2+yC9Q3g7S01sFqKkqwq1GPaYNAmojz5IQNVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5g5Hy8bFmVl9CKSulnEnJOHnFgxsWRHOQIzhxY+Ua80=;
 b=SBUCj60peSiJnw2v43dQI0XU7un0AIB0UgSl63tMki00llomMfSwqIhb2AGpVY11upGLDMYIIiYUu9lMNSRgaEnf9TTH1yy++rLIpFZbUQoxn4xg7CnhFf9CmZBJR5MvXA4O3YD4guMnInGeXRhyikXNhfPnPQfTzSoXu8edNkD/ACyT1lON3uJB1oGJEA1y6XrlcB1HX4c7Puua2h43fjqJgrKNYyfoMcHjgs5uYdsGOuGg9kJ6GDwC13UPHNuyiQmXFpfnMGMbFJT26/4kSzfhTgZ39BqoThVnw8zJGFz/FQVVUgG6qJbcdwsADK2OaUHKwIEZw/1ZDjQu6yWp5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5g5Hy8bFmVl9CKSulnEnJOHnFgxsWRHOQIzhxY+Ua80=;
 b=permoTl1GPtlQST39ZmtpW+5dAoWf4IZ026zQSLM5bZRF0SDWYirKagdOMJ0i0uUJ5sgPqfVyR8rTYRbvMyXi9jcwewZQhjbWQa1pzsQirF0Yk4ryILyahKFRo5TdsEE96ksZ76ucHnW05atK8QoTR7NJrsQxqprgY29SwFw63I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:49 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 27/32] spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
Date: Wed, 17 Jun 2026 10:29:58 +0200
Message-ID: <20260617083003.1071543-28-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b1744b4-097e-4040-c09c-08decc4adf15
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	dU0mu/jbFXBIecRU8yxyPZ5t+QWP80yGDxu4SgZwujXPR7y3E4udRPE8QR6jdEftd7Xqjio26GwyM9jdsh+gtKGOWfW9cp3IMf2ghrtXTc/3cOhPhUab2ZwNFV66Jgk8+i0SuliygWVlyqXOT2Dx2jxzgStUryt0TjqnM4TKx9u0x2B8IrlYUQCbDckKEhd3PoAFsSYZSIktIq4HeEzwoLrMUCSYPrMT4JFQ/5CVnKj8TxwTF9ScmHCGAzOb39H1lQab2X01XI2PMJ4ko5C0qJLvTDHPrNkW4g5zk+J2B0O3dHEV0fR2A/pWdE8b9Thklvn94ENIaXzZOwvYttgT4rBOrI9DT/HavWwqQ4O0ychCNUSW8zqe3jqyHUULjpb90vugp2NDO4wT+ugU+1OE1WARaXWS4c+xjUIBsnToZA2NVWjUP8n4c4aIG5Dh1sfA7ibjIUu5uAWO7mGK5n7nQKWW/pJVOKUjNbv/kAyKvwJGoMWz9cBjhX2KJ3oO0m1odLMtX9E5Q7C57lDoWjXQPsKArBJWNDRt8CN92iuwojT6cbf4bNdtfpmHlVXCJBGfnK5VvYr7fl4cRJqI31BDRQ3z8hqLvSpAA+loWrfzDedZSYeyJS5T73vEhMsdwSfHAOug657c+b5+x0SKBuo0PBZaZSkoSI5HHjS75ACMRIWz8QGGZXzHqebJaP0wUF1n+35Gv9eoyEVDqK/eoVEMfQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8tJ+Mr4fPMnQEc+0xIhdHIaK8N06eUx7hjgTNLBCc3AJFuL8VbOOpA9Uundc?=
 =?us-ascii?Q?ytW/wnyrIy55Sbrm/BTBSA2PUeM2e7xXICgGhKpBoG8ile6ssIKqqKoUQNud?=
 =?us-ascii?Q?zZdsQVOAodrQyJTAqbs7WofKXFh3+jLdZQ6o6jOU0rrgJmRYTXTkTVfOKrdX?=
 =?us-ascii?Q?Rrmz1/9HikqPtRhefVAFApmZnYtnULKIWB28it/wF+KBTVOMs1LHrhnhhYYA?=
 =?us-ascii?Q?eN5lQ07trq7+rxONgZjcTzWeHvKNYMezlhRSjhamsn+qOHWntK3wrgmvtpK/?=
 =?us-ascii?Q?KAXm+IJMHC+yAekKnqE5l53hlKqihB8xsAzoJ0Hy5sE9VJ7trezZZDoUTJPF?=
 =?us-ascii?Q?4SJyTUG3wQPGl7Xfoh5OrEdbk67LH/6UErqMW7z7w6kENaWiviRTFM+Mf8Iw?=
 =?us-ascii?Q?pBwj+AY6INPuJhq4h2i25KhqrB+M/BoM296w0NjY9S2TUCdZZcHTsHfIkqKU?=
 =?us-ascii?Q?R24wjyT59oFprTk65GLe8vDBX9V5RWAMYfxu3g5QZEpprkXt3Ruafo7lTc2S?=
 =?us-ascii?Q?a8eD1FYg8Ef5QMCmN/dWkj2qzoHNoO4PXPPDnCZw+n8Bcjpp7uxVsr3h+A4O?=
 =?us-ascii?Q?psSIGTemPXSC6iGy2wy7zQJd0atNkCSZ/pCAhLWrq/VGxgtKja4snm+LIqhe?=
 =?us-ascii?Q?sne2soGd8bNmCIV3qQE0H4KFBZmRhtiRfHEeQNN8RNDmF5KE6iTTNpDkkInf?=
 =?us-ascii?Q?P9pcRwCUD01mDSTeMtxL1KBjDvSB/firAyvhxCwlyUa/ep4tMhZzaRJXUQfI?=
 =?us-ascii?Q?Abfspd9J5hpmFkxKPK6zShr6QIpr0Jm6HXydJ2gpcfi/Sbm+T3wMnuEsM2Nh?=
 =?us-ascii?Q?yPnqfDxbQkhWghHOAeAfsC0+7GE4zJct+gUXknnJWe9aCF3sNP7AefiucBZF?=
 =?us-ascii?Q?oNK1h/gc0/ZtAhJvHiOGjjAX7r0llOCZyjDlqh1XUen8GeB+rMWT0nP+hQpv?=
 =?us-ascii?Q?fuZ3BuhQ0broLxUuoZS4z0xcZPmjLVlTleNqLpbVUtd2Ui5OGdKx/f6Rku1z?=
 =?us-ascii?Q?9GKHCDkcelmGZrZD8ZIdc5Yk/egrAPE6W8KmFcj6Xs1pW3V7sIj/3+xE1PEK?=
 =?us-ascii?Q?h61nma/k6leSNMh89k5pgx8IhfoJIkHoFAs4r9jRbXC6dG4TVQTjfR5iogxr?=
 =?us-ascii?Q?v1CI2pKMsXLRjfWgocCEV7DV0P1A7CBV2m1iKkTgxlcUG1j4HKH/ySe8eFDK?=
 =?us-ascii?Q?rO2//cUS+voatRon2zjr/2CyYkf0Yj/5ewoqe6PxEYa1WTCj4pB92oxzhhqf?=
 =?us-ascii?Q?03y8Kui0rTESdsh+zPeJq4WZUvyH8qZgbaTC0IpJwdJNn+hcqVBk4FEG1v/T?=
 =?us-ascii?Q?pya8tUR+WLCITL8CvDa91Dc6aXHjgPYPsTjUcfLYjELccG8pY2sY/f6/2PTR?=
 =?us-ascii?Q?2AWv4NYT5GyppdESnYZOnoqzH+SWnSJiJjObgyAlrtm4tpnQtJ1tTucAv1Jv?=
 =?us-ascii?Q?DlbZ+FmZL2FRqo7qA/bwZpXAQ/VwF1k12gSsztPIkhTrDA3bjhX5xq7F6A0p?=
 =?us-ascii?Q?y0FloFeI2I6TKbU6z6g9zmUNQbU2khEyLOBJlaFYnFw9+bqVH1t00fpCz1vz?=
 =?us-ascii?Q?+/romi8kATaxTL2YSOY0VbcGV4FqqCx+NX8UFUiJcARp6gg4NWuXDA1HQhtp?=
 =?us-ascii?Q?COIxadsQ/cWuq3pZ+dRe6hQZud+bGU1esQ/pFWAPo0jpC+mIMnVxTDEYh/TE?=
 =?us-ascii?Q?KB9JvECPuhFs8wAcReiqfPmgearsDYhyq61D8MTJTZY1dMg9GqtXvHyq70qp?=
 =?us-ascii?Q?7z6bPPrSXJ1DJLNMs/GQtom7s2cfd+33509V25Ds7I99jTE7PLow?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b1744b4-097e-4040-c09c-08decc4adf15
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:48.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSYoGPjXO0P7ks/aYxx3BvmPSDmvwJL1Y3nIA29LusMqw3jb+ejmgPB79olxSEo+NIwb+GPfVCcVfJTNj/qZ05IdErMTfeyId/zyYy6+LxSrGa4/WOfJsU/vTDob9l1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23186

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
index 623e7683dcf3..1b3127812d50 100644
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
@@ -790,13 +792,7 @@ static int rzv2h_rspi_probe(struct platform_device *pd=
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


