Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A2DC4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:49 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13144.1784294021141233597
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kV0w7gHB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7vwXhNF6rzofCMnQFZ5Snve11s8+OQoMhhsdE/tFBW+OmaBTQQdB442frodj9MZ5KgeAhmkFanV4Lgu345vRl85AffaR4Aei1AkRkxno5c6ieaPSxp7yhC7kwlKTtaEWw4HloB9uNHahrcJuf9S5rPnUs/4YZLsBuMZE3cgglichO03pK2xr2xaTkuDuPHqm2hQbrB2gGlcy2QjvIrw1k4ZvFdJd+YxNi+r5OmCYCl+CdyU2y93SpIp5F+r64K65KL2G5wTFJ2ZD47g7f3QygQIHfWgGQc+r/PxZy8blxLjQPSYlRKry4X8iaCbTPgT2sUOMOF6Ys3C/IOqWL1r4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WohMU2noF7puZTwJACzo1rbtmIs8aFB6xk6AaN1sg7c=;
 b=NJneamdepkgQCp1QLB5ceCY9TD1H2dZ575u+reo0myKTUWCiimP571u+ercsVCAFeN++g5/QC8gKE9XuHzAX+7gq0TLFDkctJi+MyfRDAAkI4ejeQceEwyyZla0HZzZWv9oZSixAEdrtT5Sk34MoxuAXcFLn5ETLLt19KkjVZqB4rBWf7BkB7COEo6wi3r8172XTHa+kk/t7YQLYqC+wQGekU+PDtqKPCC+70kRUzA+5Rq8QoJT/2xZhRlrNqPxYpuUi6vrZ9aUHRagpxjr6+T5ac8CnFPTUcC5Kl3XQrUM/AlgPKnZYftL8BN61Gxwb/yxaMU9vEYdjHnnBNjpqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WohMU2noF7puZTwJACzo1rbtmIs8aFB6xk6AaN1sg7c=;
 b=kV0w7gHBbaneLGoN9jlJ9r2NBevnSIsp1ZVb6IdfVlbbHn7Na9S37WoRe/ujV51D0PwRvcNYf8PGdFCWIqEAq6Nk40dWdHKYs5pT7jCQTRYJxEFyiW4GCgl/+h2CjBBRoAS1OPJAps9VPq6Sm/CFvv06sfm8rg4ieOjVV7N095U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:38 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 09/23] dt-bindings: hwmon: lm75: use common hwmon schema
Date: Fri, 17 Jul 2026 15:12:27 +0200
Message-ID: <20260717131241.2233788-10-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b2e522-493b-4107-f6f5-08dee405371f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	i0mFffuDIFpPmb4x3dlhNJnmS8Xezgqx+6UL61iI0ghDTUluQEA6jDcw+9Lkf5z8DJp0g49y1K9I9WuGamwxTLzilhgGHK4xvv4ca1ABR/48LoYPou9wFghf5G5SHG5IkrGIT5kxR0zHJhkfAoOElTWEGGElwkli6sktypVfj9NyP3Rl1WtQnnO5QNP/Uua05cx1vBJY+HwOW5QiNyBiflcdwlxO/2B/2u+w2U9UNGgp8eGq6ylSxlu3usV/ARgDU8MYrMEddUKBFpL9D88jYSwVU5mdGnK/GtPkL091mtjMTnX9L4ELoESv2gwGRFzTrrhWQbIFXigzOk44FDszCK0W2b24xXxyi98HsTweLhPVcpIScWYwTba31LVnPULBbD0xJoqZXfIIwvFi7rwi1EfEIECUHSEqYkIMvAewYf4A+dL7nimtQKvyYCM3dLzaYh/FGH/5S+vFM7kprg0Q0kycXbIpo94DzwlrVl3GAj2J+KTRtvO7lcFNc3tR4kzEgVvBA728HTJ8GuqFrh8F4IOOdqWFKWL0VZU2XhDML3URwwj2nbJF++gBiVAfpQ3nwcZXGZPHkfzWPaWQ06v58r9JFQAh7v/u7OsOobmD3k2OzjSk5QGoOOuhcel/2jw4GYj273ES5dIw5Ywi9KeH7+qx65yhSv3IFvd8I9ud/e+5Fi4EvyWBgZnPoUkcFpPlKFXnzN1dmup+dZwQzIduZOSXM008595TvPiLVl5ONVc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?iM/hSgbbShoeUdJYscK8mcRshUenNPWQfj/1lZMeJ49SKXxkanRTx9woeQMw?=
 =?us-ascii?Q?vLfxrlm/P8H0djFrlU+LJcrhQi3ARL8yUjYkJ/gh/um0McvWSCMGWGhx+SIc?=
 =?us-ascii?Q?WuCRlpMOqQL1Zk7VX6XhQhor0OowxBaCzfmucrgUrbuQvthU3XPFcmVFzlMF?=
 =?us-ascii?Q?MZpAHcCq1seHaQ70iQDJnMXUOttobfspG3DUqSPywx9DxDTGX4UOqm3rIcny?=
 =?us-ascii?Q?9bTdCQPEVavqUZmHUTG+TJ8Kt5H6XYRK5MrIl8Cm7h8/m6xxdbTX8tjMeJ4q?=
 =?us-ascii?Q?96MPSK1seAOyGaZ99QLI7fJqe4ZotnDbjzU5IBwAAcMltIPQnLkGRMmxwAdq?=
 =?us-ascii?Q?/64NxxoUx0RPEhFeAsLjXZwOLtHVeb31Xvs3QEZ9D0vWfAIw163IcBuIDbTg?=
 =?us-ascii?Q?Fa5xr6V2hYXkYwYl7BYXTxqARKWlzrKM2ru66eNaXdoZMxshXF8Alsmpc4wJ?=
 =?us-ascii?Q?7oWeRjHX9sLWCPTCAIjSfQocoWxonkl28bVErMED80oIkBepJ2z4Hvm6j7lm?=
 =?us-ascii?Q?XYJR3F75s+Exzg6KFTL55GmJWSoI1SUvHrGVWYIuADj0ZWqaqluuxIlgl87A?=
 =?us-ascii?Q?rdOtzCou+YJLrQQPe3NryzgBHyPd9Aa1ad87aKZdXrXro8+1bVUt8gpLKCSL?=
 =?us-ascii?Q?35PZZgMCEOlal5Y5bbejthIKSgaoGiEU5VtkSDcTDATH3elJ/qPTSiws0fzc?=
 =?us-ascii?Q?VQK9k33ITtk5sB0CI4UNhyS/AA7qOl6oiaYSnXld6YD31DDyCtSUAx35qLmH?=
 =?us-ascii?Q?9pwfO9JOqsToqiCKjXm72jol49RM1SrR7f2EmpZVMe7zPQS5Y8X+ijT2KQ3X?=
 =?us-ascii?Q?1bZxVMfzA7SeyPzmQxr9lKWSE0ABN8/RLAN/BrtNMPePmBsNHescEny+bIqq?=
 =?us-ascii?Q?jCCsVgOxD1YE9ETZ0cLTgWbhf5CMHaYLzbDMVNIZvYvgqngIsXOUHYG4zEa9?=
 =?us-ascii?Q?ngBW5bkuOAJ47dg1c9yI+Ez/RuJeVj0DiipfpsTR6o75XZt/kaNYLhnbqSmw?=
 =?us-ascii?Q?aMidP5ZmOCZT6Ma3kFKpnPhCRwZP2zRqvhIvcWRDQOmJUhXBv2O1TREcebmW?=
 =?us-ascii?Q?FSR0Y6x2B9FyJI+cv29Tvb+9YtusXvOP5PICGUmKNq47aEdO29NsrKXEdmuz?=
 =?us-ascii?Q?vNv1ndaySkzj+Blr4zrZCrFtLZGwu69ORlcDVzvalQV5tCs1oD9mcF16v1FW?=
 =?us-ascii?Q?zzV0a1XiIW3uVqasA3w3zazx+0rBjU3LWKvJypH9A2llRS4wfHLc1Rjukydq?=
 =?us-ascii?Q?RecZlmEhOliUvUll5XgCVPfSlBH7zc2W2MkZxyKJYEl99gKGuWyA7zwPRsOD?=
 =?us-ascii?Q?gIZN3Uv0KD3dTFRZSV/n6+n64EleF6oavnn6G6+E7ZIrYf6zaX9eDH3Dbzxj?=
 =?us-ascii?Q?sYUmqst3yy2Cs0+IhsXK2hOrVLa5Cu00IljpidMKGT7UAJywnQT13gYeeKef?=
 =?us-ascii?Q?8Se3eH8YQcEgGt9jPARmOtXjcmHpzO/puoVQx+teA5MmGrKCLYX782DtIKeM?=
 =?us-ascii?Q?RRdFdg+asRPBL/f/xCCA4NWQFXHf/23OOC9WWMGpQ0g5r99WgARGDW/j6vxu?=
 =?us-ascii?Q?C5Gzt3vOLVbqn4c8EfM0FlAag0/PuiGzxYQlmgVfo2HSsBy/LXOH3Teq3IjW?=
 =?us-ascii?Q?tGx2IW2bnfBkeMyuhwzEzOCBBuiNQn+tQonEwrYGQUpMlNK6Kl5xBNAAJ9TP?=
 =?us-ascii?Q?Q/ASCAiQX9UwKsr5mklSKgRGiMKlgs3k7O5/x3IBVZKw5W1H0azte+ATze9q?=
 =?us-ascii?Q?H7Ad/NbAOlx7yw73oUoMxdgoWk2YuJIHoYNXyFS4d+LleipiaJe1?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b2e522-493b-4107-f6f5-08dee405371f
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:38.7941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WX5vtyCH+/ralbpGS2Y0HXYNG3fAEchdznSvcjrK2PFdxfK4HY7ieeOjpdHXD0CaxPRiKypj+834KOi+VZGmRuwl+1Wy6XQZOAehB+pq6sFJsHCatbKTimAuldKqgW2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23637

From: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

commit 78cc80d834ed3b792605bc9c2215ed9e63825459 upstream.

Reference common hwmon schema which has the generic "label" property,
parsed by Linux hwmon subsystem.

To: Jean Delvare <jdelvare@suse.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org
Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240229-mbly-i2c-v2-2-b32ed18c098c@bootlin=
.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/hwmon/lm75.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/lm75.yaml b/Documentat=
ion/devicetree/bindings/hwmon/lm75.yaml
index a7af231c52d3..5aefcf8e5ca1 100644
--- a/Documentation/devicetree/bindings/hwmon/lm75.yaml
+++ b/Documentation/devicetree/bindings/hwmon/lm75.yaml
@@ -57,6 +57,7 @@ required:
   - reg
=20
 allOf:
+  - $ref: hwmon-common.yaml#
   - if:
       not:
         properties:
@@ -71,7 +72,7 @@ allOf:
       properties:
         interrupts: false
=20
-additionalProperties: false
+unevaluatedProperties: false
=20
 examples:
   - |
--=20
2.54.0


