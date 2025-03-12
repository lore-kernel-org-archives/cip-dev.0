Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A5BC35FF2
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.23])
 by mx.groups.io with SMTP id smtpd.web10.34510.1741778849042148174
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hH1Hpr8+;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F9Y6LqiVU4Qic816zso9QkEYBUEG746ppuzQQ0cZHf2vz+4sTTu8E7y0lwT+WmdUkLZ03UHQyvE3nGxguBAnhmaRvPaim6/GBsmY+HcZ1z49ivCF879oXSF2KYKe5UwnjNzIP7ejW2LIw44PT3CWtJyRiy8nwYqJrrKNUZiAd8ajS+XQyPS3sK7tDHmcS6Gz3v9o7YzzQnPKbUoE1R8RJjxQGPwkXyp5eG7OpGKaeQQj5S00TB5uTHbH+Yl6Q+yZXbT5XH8vGrkZDaI3PkdO83E6+/2VoWUmSuoB7AZjzaBOXSWv51YQCsDVfyiNjlzxSm5gFaYjTnFklg5/o9PxSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f5rs3T9Wo8YDqmEH0hakQlyG0PhuSZAXuGGkdcBt8KQ=;
 b=hifzd/LZFlpX1i7II5DJlu8aQo/xa6Y5seSF8Hu/irbKJvObk1XzZsE4PrWs80pAU8IXqj/kR8KLCo4r7k32kQS2Q1v6oViuLhdrWv0aby9DMNEmGZ2C2Ljgb69XhBRR7o8aEOwsC0eCcAO2wQ0VbtEArzUAoIk/IS9QiZIO62B7dYqiBUr+B2YfTEk00L7ohVRGcrjsuh8XCxA23dgOkqnrQB1pUTvD+4Rs/EIlUCuhnPzfQVw/DI8eheipOj71YTcjg80zVIZ57ec+qTR8YJPw5hcjKMwNB/qgX/wcrJGeHk31gn9YpVhetQ/3l6gCuOrYDw/6VotOiQc/Z/SqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5rs3T9Wo8YDqmEH0hakQlyG0PhuSZAXuGGkdcBt8KQ=;
 b=hH1Hpr8+vHI758wglQte7u0luQE79AwHvMUojwdYPsNTKu3h10I4zOx9OYRZMewwKow8Ar+DkyS+dloIkyUcj1cfX582DH68XPKD93BdRbYGTBGT11gA0OGSOsNYFMR8s75RzBi9o8qCpJzCFgga5FjlESXaDktoheNuzn0Hc+0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:27 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 79/85] dt-bindings: i2c: renesas,riic: Document R9A09G057 support
Date: Wed, 12 Mar 2025 12:22:56 +0100
Message-ID: <20250312112302.1605750-80-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: ebee200c-4ab5-4a75-290d-08dd6158de23
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HUcT1ohmtoCb1xIeF6EXLw4tJqUs+8zxzMAEWLykPg4GEL+OtzeX15jMcm4J?=
 =?us-ascii?Q?BkJvDQGDUZkdXYyTVq67goXw1Y5lZizt1YQtZRPvozyNuyh6TZW+TiVQtZJP?=
 =?us-ascii?Q?PeW6XjaNU8P/4WvByYJCSainPUczfPsq/J8uYknU5wmtxhdhtlX4h750dkKk?=
 =?us-ascii?Q?kkzEfvSROAvQ07Hv4YIy4UzlyTNYyCrqK5V+uFhg9zTC/pLQ0dwLv8PbWZfR?=
 =?us-ascii?Q?AW6tVRrALtA0DSh6+DeW0xYCVI+L1EqcCU48SDin8vxe0pV/j+gRgGoxN/QE?=
 =?us-ascii?Q?SxWKtjPfkIoGHWr+lSEZbhYjnXzo0HKeXphQAoDptTkEdQevFMKg6Xc8VfPr?=
 =?us-ascii?Q?+nB4fS9y9K1fxnwC2lTPwThoJWx/GUkdXfIO34mQeDvuhBRmMiVb3l90Xsza?=
 =?us-ascii?Q?1/+V9Nv1ZFKbgapUJKhL3cY+Wtn8xN8EJZignp0g25Yscu15mg0GMFnKzJ2F?=
 =?us-ascii?Q?egZLcbEWWupN68dIpkw0qETt6umLIEw4gnNPM2qnP8nlIQWG4PQE7ctMM82v?=
 =?us-ascii?Q?eP67QoEK3hxlU9nLVaTSIYKN7SaKr36/CJLN19Y9CreXOB/WxxgrlijACqEn?=
 =?us-ascii?Q?VMMxr/xHMCBBym3hjJQyaMzr7YcXX039KEwRERlZT6WqOBszxQZznCXmM9a0?=
 =?us-ascii?Q?uBoMfp1W2Vlerq+tHO+S9w18JvV0y/PlteEgBfrEM+dW595wkK7WMfzfRrks?=
 =?us-ascii?Q?3LOegoGssFgagoyOwZlTH7UNYKl5dy6u/sxOJBIsTSfAi6Is08RCdu0LHnE+?=
 =?us-ascii?Q?LzezBrUB+18M1OZ+/igNZaORbP3NlqyGMBOtEJlEPfGSuExL+lXG7OzOYylC?=
 =?us-ascii?Q?fPhv0xgdvHL9+BfCREa9zHDr7ie1RIN9IoWJkTrHjxpK2rr1342m8lif0c4T?=
 =?us-ascii?Q?nVB6zn08sjHawrX23qZhYKeGXHh906SpYaGD46cOXmeLQ/ics4J66MhLUIPk?=
 =?us-ascii?Q?Nh4nm6IZ07Sb9sJVXGMuFxgKrxyUbH/buMCb95pdu/VS9jqVjXAsv7S8lXsy?=
 =?us-ascii?Q?08PF1TGtM1YJBka/Beyqa/x3ajtFpgyAQ6bXM3EOvcovW1eJEWvWiX6I+Rk7?=
 =?us-ascii?Q?ZXzOoPlFOyCdfuj7TPSxhqqKZrAQLJphnrE828b9UEhcb8OYSL6WaD1rDB5X?=
 =?us-ascii?Q?uZOzBKyq1Ny+eryI+4eFKXjuS5ZvMkJahfSORjL8ZpYiK43s3rH0XF4ylC61?=
 =?us-ascii?Q?y2kTjWvTLFJHE0kYM7TGkw3hP6rTChzorX7BR2Bz+hMCfBXTpepZ7TEuUqUm?=
 =?us-ascii?Q?aEaFdh+QkwT+2ZCSo1wkNtY0yFMNu1tmDtS3iT7e6h1+c1ArIDMdu5I44wCq?=
 =?us-ascii?Q?S4QPTS4mCxQZJMOwmitKYvcns0/EEq70e/CYp7aaXKOA/3477mrBFwzslzxu?=
 =?us-ascii?Q?Fqztqe4UT/c1KXwdDwNiGSEXQ/O7eZSJcC9rPke7/8kQq9vgXczbTSC1SqZe?=
 =?us-ascii?Q?DFSASiGkKIgBOmchkZF5slge0gzNE5e9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5rcZLpA9WxtK8e7x3bxrZUZmDgbUgZanw6I9RAyOlpAmBiEm0tG0xJ4dR+WV?=
 =?us-ascii?Q?+VrhwqDRw34qF8GqBBS8xNaAd3KOPDg5VDJ6j78CPPW0+ieZDB8hSlnLXile?=
 =?us-ascii?Q?pNV/t5dGbNaSUEB4+RRA9DpO6sPMbm7aRGMvUCtjWP8VPyVa0aEhQlyOpuWS?=
 =?us-ascii?Q?SWa7Lnf7BKcZkmt48u0FbviO119iG2NsDp1GCLrORodVkNYDVFHyppSPfsOc?=
 =?us-ascii?Q?Mea8Lo4QhV5fYsCW3XowCAp5UxJhlKQVO1Ft4bpNDTkqDwuxzvJnywxP+Rq1?=
 =?us-ascii?Q?B8H/c/ihRhsq5XznZBri8lap+AmXxJ+q/c8aI4dIXy/MgWQBRSL7v7XJoIA6?=
 =?us-ascii?Q?knvVkvOhfXbeuzq3C02rMEDbgo9oCZcY3khcPliLgDavJpMgHG1fhooG+RRk?=
 =?us-ascii?Q?qB56Ogn9LAS7UCpKfWbAQoxc23BdviUwMOap8B23qV1fuGKEIuPMlsHrAL6x?=
 =?us-ascii?Q?qXokWIlo5TtpQFxN02wtPVyXLTYBgnNSEBTFBdLWlH3V/KdcjuUPpgJhULl9?=
 =?us-ascii?Q?MTL2wZYquT7CrtGena1V4OxM5szRvgqRGh3w8XFsD+aHjYgQCbMhq7Z4q/Jv?=
 =?us-ascii?Q?PLFPPL+b0Y2qdZWzIhsR/DlIMMyqU1R166yuERoYY/TgNtmUSnQwwmaGdxv/?=
 =?us-ascii?Q?DmQsRoRXa4aJ8hoFPwt0+ydiPP1hCkMaDYZsE64y+j336BkSApgV7/vBzwmD?=
 =?us-ascii?Q?jn7HGoERqpwexJrqqO9T1AnxMpZnTJ5lQ3/OTfV8FHDVxDxI38NlPCKd56+7?=
 =?us-ascii?Q?OClgW/rGnExP1Wqt1QBwyQQn95z22bj0Zh4Q0G7rmJ8INZvFCmKcLsQnYb4X?=
 =?us-ascii?Q?SwRMG/wj44kpsvnLhl3QdPYnO5WKqhvFfJAd009J5Ba3YIC+Bjdz7D/MGAw5?=
 =?us-ascii?Q?zVTBLzY6UeYExtc1yyR08NL8F0G6WFsP2HNvrIDTPC+5kLg9Q16ukqcgHVne?=
 =?us-ascii?Q?me4imeGEp0OXcxqK02MNNrSOhYXrjaX+wLHCrkcB8qsFLJp8UhuTlaMvBGsB?=
 =?us-ascii?Q?lQ/eETWKqZnL5nxNBdPs3A1P+HMyM9lWxw33SqfVxr8tUJ12qkh/WeDZNvjj?=
 =?us-ascii?Q?5Bnhz0YfUvqr60c7q31pAEEz0heVEEayJ6Xl/zywBPUI2KCzg6HV4W7LGI76?=
 =?us-ascii?Q?BxR1YSzx/VxjcbalXB8qK/FJOsHAT1/U7YjZD7kLvaDag6TkWxmArPC2/3gF?=
 =?us-ascii?Q?i/O8nrpCuRL1DKGmGKDu9sPnlcjEEJ5t5nkaCcqo72Q6PqHamAEnlEqNc+Ve?=
 =?us-ascii?Q?3HLpfVmq2IyTr0dphgi9gZR97GSoxI7biGt+PF+RXlL7GrDE6sJslOQ1JihI?=
 =?us-ascii?Q?M9UV6WG71QlL+/XN4rVjB1Ot5AyBXh0azuyrXHBG5Z10sIBdulFJHmyGfyBm?=
 =?us-ascii?Q?sPTUseUVLPrEPiRFuLYyQDWQWhrKjhM66PSPTv/dgeCm0bVcYXfa1B0iqc/D?=
 =?us-ascii?Q?Pa3MBgDAJ1ThFY10M7Rrjq2JZdiBEnB1n4arjoS2dbFG8n853c1P0N5zR4Bi?=
 =?us-ascii?Q?avI7h5TaYm3YoWwg1egPBocRdYVOf1nAOqXoPVTEdv9QZIK1BCkbtgtXnUR7?=
 =?us-ascii?Q?H4OYBwEasf/pnPurDrw5lU7YWTXjXglC1ikQnYRGCkPLR+8npemK6ZE/XLfH?=
 =?us-ascii?Q?4ahgYpH0SKAfulGp6xekcWs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebee200c-4ab5-4a75-290d-08dd6158de23
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:27.1719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2Vl9re48kI1St1mLQEjajxgfZrXyGtIoY7RSGgby/4otWXAgiOFk0xaGhtB81TtbrNNYwnabgY2AHdIuOqLt8d0G5Qizvkg9wJmLCSAyir4I03YVgSZnJupkGT7BfEP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18171

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c1f39c62eb09fa2e692a9377295ecbd0740c0914 upstream.

Document support for the I2C Bus Interface (RIIC) available in the
Renesas RZ/V2H(P) (R9A09G057) SoC.

The RIIC interface in the Renesas RZ/V2H(P) differs from RZ/A in a
couple of ways:
- Register offsets for the RZ/V2H(P) SoC differ from those of the
  RZ/A SoC.
- RZ/V2H register access is limited to 8-bit, whereas RZ/A supports
  8/16/32-bit.
- RZ/V2H has bit differences in the slave address register.

To accommodate these differences, a new compatible string
"renesas,riic-r9a09g057" is added.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 .../devicetree/bindings/i2c/renesas,riic.yaml | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index 2291a7cd619b..91ecf17b7a81 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -15,14 +15,17 @@ allOf:
=20
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,riic-r7s72100   # RZ/A1H
-          - renesas,riic-r7s9210    # RZ/A2M
-          - renesas,riic-r9a07g043  # RZ/G2UL and RZ/Five
-          - renesas,riic-r9a07g044  # RZ/G2{L,LC}
-          - renesas,riic-r9a07g054  # RZ/V2L
-      - const: renesas,riic-rz      # RZ/A or RZ/G2L
+    oneOf:
+      - items:
+          - enum:
+              - renesas,riic-r7s72100   # RZ/A1H
+              - renesas,riic-r7s9210    # RZ/A2M
+              - renesas,riic-r9a07g043  # RZ/G2UL and RZ/Five
+              - renesas,riic-r9a07g044  # RZ/G2{L,LC}
+              - renesas,riic-r9a07g054  # RZ/V2L
+          - const: renesas,riic-rz      # RZ/A or RZ/G2L
+
+      - const: renesas,riic-r9a09g057   # RZ/V2H(P)
=20
   reg:
     maxItems: 1
--=20
2.43.0


