Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E921CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:15 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10913.1781685066770964161
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZD5ZmyET;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvNiUsQ6wJ/CR7sBmy+bcOcC5ZHJP8ZWLVDRA14D2qotjw92QW9mZxbTk/cNs/gIB+6VpDA3mKnbx6KGJGfsWYzfOnVRbHgU8L7vZKxvVuKbfTdeve0WnrLyTP1yK6CZ2/Xf4wtvQyWZwEkM0tYEvAjhDYq/pt3JW8X5RtQR4+IcVUQRqMX0HiNb91Q0DnTfcVEByjgn2bNmKpIQpll85E1bTzenbChwqkkPPf+gporKWv2hUZvYYRg9XQOkcMdRg0vJp/ldNuBbxUQ858xx7m/7O2Hx+F8cYpDhxX/HSnLHf4xphZDF+qAOxrkPOgHD6mORFw2h9F6S9LeNhjbObQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRdFHDZj05Oa1OoO38+Uw3Zomz62M6PczaLsUmWuo7Q=;
 b=CNqQbDQAsnyhzw+trEbUIjHP/CL0w0FUedp3D0Up17vY5jatOeXVFbA/6PT5wzWx2z6yiG7OZO/U8p+9o4tfuwTBjcXOatX1KiDThaQmi8jMLOba0teEXCp248kXUF4VWfcYQp9Rl2n3so1xENTrvSw0wV1UDFlo3iEwptf34ww5OgMc80SHGufoeDirmwjeJ0rafLl1GTBu2mLZT5W7+tz463BMRVFaW1fNOJjQMMhlZKNXknDMQgiZl3gUBzbJmqvxYy8fXf2PzuyoTn6XhoFbz06Jx2gaDcABYr+/X9pCxepAbtuTfZhqkOwQUEKXRADhmcrGF1wJSCfuA/TS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BRdFHDZj05Oa1OoO38+Uw3Zomz62M6PczaLsUmWuo7Q=;
 b=ZD5ZmyETjUPdrQWnB9p0KX2skSmfuPIUgLIvv2R7GSRkEYXNZWypfCpJS+aXxJNviPChNuoln2T6uhVL8xqNG6Dc9e7h7QIehAFKcJ5M9He1khjIslsTfKyDVx6be08gLEFGE796vvrBAxd3AYGxUozn8zXsnsZ/LeUMYzTrf6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:31:02 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:02 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/32] spi: rzv2h-rspi: avoid recomputing transfer frequency
Date: Wed, 17 Jun 2026 10:29:43 +0200
Message-ID: <20260617083003.1071543-13-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce56a76-561a-4921-800d-08decc4ac458
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	HCNEtPhyTQTzVx2NePm4GRQBfPLTwtwGZyDnbkncnvxB9/j67M3OTfJ2PwYXwHpYlfr5gwnndT0hJWJnNeN2tEOZLxliISbmOyxP6FtT/GC+QjxSEZcM0UOdlb+OhskBk1yMDhBMa9tE7Kev2vd43vDrmb6xtALYzZAw00fLkY3RCcNwdU0W4voerRX1tifnsriRSibiB2dAUaVvF5DDGiYRKud6emLdJds3mByH9TktVsR0vYxLJAmXfbAgdXY+gpa4SZBBLQ1e9uYirbmbnAfyvDB10AVfHkaIFIKTK5PtGkfN8TYU0BgBCPyYv2gpfBx5eE0OXRpxxp1PuBaysstWoCrV38XRzTfOhRRBY8ugQ8E4wHuuNImZa5eAMWxqhMdtzIGYCNAN3J6UZIiHOIGbrz6zDCkXWS7cV3uUgWFBBJvwBnjzGRuXmB9mu3TGfhoMC8/nL9ibSeLZnzMiR41mzzaIVbdjt3kXXwN5M8TTEqGn2ppBXl70H//XBx6/8zlFJk/GpQ53dRH/1UnNMRgVioSmcyiuXQjikDrglKL8x1OBlV1owwYoenrF7sYOmG08/bbuJ5iAKcOEfBu4XjVM1Kis7wspXfa602gksv7unrXKOCIpys348/VxNok3psB0feybOsbtB7ZHKBQmOnHmrRo254LIykvh483UPnBh9oIrvpTF+ULIRP0kNSlap+ZeBymKO+IHt61ko7uQLw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lbNfr2c8fHw0DgIJkjmjvQ5sk6YAUmvfaKKymljca/jd/uPgaActoYa3NznS?=
 =?us-ascii?Q?nwISWVhjQFHgjp8/YOXroBQaeKCWAkGG3Lttgv+LcIpSjRh6uRZPNzPmL0Hn?=
 =?us-ascii?Q?kG71yj1ixa2zvZGEw9iNMO+B9d68Osa937Npu1kdtdQhNj2AiMMII/jc9sns?=
 =?us-ascii?Q?+pT81/JNmvUkdBB0Edg5I3+ouN3w79acYxtiK2oO++ycXYplHin+EyaxXMTp?=
 =?us-ascii?Q?n2PopaIynBqKFimw0auvBNohndOG2QGXjz8veNTq4b14+i4793kAt280bYu4?=
 =?us-ascii?Q?kqCnqxmBdyRMn1Vv7bDVG4y9xffV+iQ9x5YCqaLlYAk8nQxL3Qt3OmhPKqCu?=
 =?us-ascii?Q?LFcP8h221zbvSsvGBoqfN0shtEjs1VUiQIkEDOyLL0OIhjqPy7uqI/AJFoBm?=
 =?us-ascii?Q?I7cgsnkCb9T73JLZSe6fk2duE0cq1sQiJs6wuk/V4bhu/xr2uft6GoRo8Y5Z?=
 =?us-ascii?Q?5KVy53YLcC7LWU+qxU72gVxDlJreDFfy7C/JsuCIK/xQmJgqxZdfT1v/6+wG?=
 =?us-ascii?Q?xrYg+g1nJGZ9NzMNzECtC1Xkx1vzDE9hVhDnLf/oogKVdPbMhPIgrAGzPdNL?=
 =?us-ascii?Q?gKfSfwB8QILbpq2hRPnJsMltbE+GPNNCBCv+hp9ctJcTFIN8yLS0qbYiFHjf?=
 =?us-ascii?Q?564FlLt/q2FMO+iRdN2v040jcvMp1Ynp1cem/yNc1CK9rbX02Sts5Rzlnhg1?=
 =?us-ascii?Q?fIcnOGbeGgWhKDhTtU8aKbHYnk0KmsPrCBH4uUZ+w56/hO5EG12ZK2oT/L/2?=
 =?us-ascii?Q?MeI/DbMvYYdKP8oH9tl3IN8Vh4ZA+Zq89usQqciAuZA0jRV+Qa5hLFK9hq1t?=
 =?us-ascii?Q?nIwdnzs4kkKWT61RNwNhNHWV2Pk9I5M5bVTtOTjf1utDnKDvy9C0DgArm+B9?=
 =?us-ascii?Q?6rZv279ztFB2uhCpw4Gl4E+cP0mJY6TFzVMNkUyKD1wY8oRAGC/QVd/XvKwA?=
 =?us-ascii?Q?97Z23Mu1HaVW+gCt7XihY0h0s9Vh8LIRaaMK+XL4dMX03tkktBhQobu3aA0a?=
 =?us-ascii?Q?y2LBIRE7KumXadQ3MaMl8PTEOdCi2VYdV1pLOI5eyGdZWX8h0wMrhbk/fIpZ?=
 =?us-ascii?Q?Es5mzZbKGTf4ko9l6ZsFrPyV77sHzz88xq82TPYobn608MZYq+EB+CIUw9Mg?=
 =?us-ascii?Q?A5uf7cS+9XtpG5YKFtk8hB1yAw66ZB8tBj9rqbnKg87VDwOULebUWGfYz/14?=
 =?us-ascii?Q?+UiKHzkLnFs9lmufk9nlSS2oJYEvFtcexF0K+BN/Mfv5+nIHkoxAQgY+UYZA?=
 =?us-ascii?Q?PmvzFTA27fG6q/mbFMnUnR13B2FLCVH/91dWPVw7qHR31Ygw9x19ukwAWthX?=
 =?us-ascii?Q?1h6p6dJVfMpwedQTEP27E5z9a34tfiNRJRMIME2/HBK5l2VT8891nC0P2CVX?=
 =?us-ascii?Q?BInOUAAjOkqqRtdGDECis3FFt1G5GhEbun34HQTdmYDzTPaVJKH5kVRlJhtf?=
 =?us-ascii?Q?outfu1+Yc5Y1G3uqkrqw0UBn5/bNfgNIiDUjqnS8+bfUmXoiE8Nh8hDXpYke?=
 =?us-ascii?Q?P6zDhlB0UP7a8Ui4sU8GoXW5CL5RxSniMI130MPXwPkA61dpRVWz8NLOCkf/?=
 =?us-ascii?Q?wuP+3tppJGT+YlpwMjJm46Bjdnm/tug0EdhiKfpgwzPvioAtvvPJiH5Fepa7?=
 =?us-ascii?Q?MBVVecffM+uUI//xpuOkJlY9E9GunpX4B4zNiGyR7w6k0FmMySXCDoZ5cg1V?=
 =?us-ascii?Q?H/C15pQC4z7673WqhWshH5IG75wyA2YPFTUCcQMcEU4AZnJUZJKUcmn2Cl6m?=
 =?us-ascii?Q?aWvMZZE2M31HzqjWMAzq9GhgqemYydFwmC+OuSN4zo+3JcTMyNNZ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce56a76-561a-4921-800d-08decc4ac458
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:02.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gR8cN62k+HyMgsRGUQ8WOntzv4kJQBxLjOV2obN+sDMjm3YiNEIgt/b9l0KuE5e5gv5wTEYyeaqsfFcLcfJ0YOWs1nSCtwug47/zhIV/xmU8v70SkAiJ/Pgiy9Y3SlO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23171

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 88782493204512fcf4e020e2385bca3e3c5bd4c0 upstream.

Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs have a more
complicated algorithm for calculating the optimal SPI transfer frequency
compared to RZ/V2H, as the clock from which the SPI frequency is
generated supports multiple dividers.

Cache the requested transfer frequency and skip calling
rzv2h_rspi_setup_clock() if it matches the last used one to prepare for
adding support for variable clock frequency handling.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251119161434.595677-6-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index e61289877eff..f22f418325d8 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -81,6 +81,7 @@ struct rzv2h_rspi_priv {
 	struct clk *tclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
+	u32 last_speed_hz;
 	u32 freq;
 	u16 status;
 	u8 spr;
@@ -295,9 +296,13 @@ static int rzv2h_rspi_prepare_message(struct spi_contr=
oller *ctlr,
=20
 	rspi->bytes_per_word =3D roundup_pow_of_two(BITS_TO_BYTES(bits_per_word))=
;
=20
-	rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
-	if (!rspi->freq)
-		return -EINVAL;
+	if (speed_hz !=3D rspi->last_speed_hz) {
+		rspi->freq =3D rzv2h_rspi_setup_clock(rspi, speed_hz);
+		if (!rspi->freq)
+			return -EINVAL;
+
+		rspi->last_speed_hz =3D speed_hz;
+	}
=20
 	writeb(rspi->spr, rspi->base + RSPI_SPBR);
=20
--=20
2.54.0


