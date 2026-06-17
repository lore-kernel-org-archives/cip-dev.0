Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B1CD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:46 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10986.1781685340084820313
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=U8UgkFFv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXyk46/Qfh8yh0LbuJhZIG2tWosGHQRo4B1WSCg2qymZob26e4cESASYBAxeoqmqKV1/yfRDgnDT5/1cJJBEdrl4y88LQtthXBI6RH7JZ7qg2CitRrkHX3TUjMxbfBsq3adDaBm5L+A6DyzhRGF4wOC3RBf+C1HQWTpDJ5ZbkYx98y0mf12yLFV8P+rJEdUHXLFIbzGIbc8KZvDT+KCQfS4IvrSVzSp74YrCk8F87utbbvnO6lSkMmH+5wMybAW5R7gktNEE7ZVWnww38/SZ9E4d1vTYvGHPBSL9ANo2jDuOtO+luVuFFx7yh/MiEp3br+f1OxGwQrPIWWLX2L0zCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4uxKVEI64SZfOxag8RXZjtnhPCSU/wfu3bioSLZowE=;
 b=CJdH7UwOgIliqUttWWZHK1WVBUlWRrLA7tWsY0nmy7HIJyxaletOD9Laqoz6DJJS5DPPETo4lch8dEQ054JLlXCUeF0TgiKGg64dmTKmrttqe6xZg8MgqJ7f63KTEeD494fCJcinNchtC13Ls6yE3N9jl7XSINnAAr9vQS2iJEIFdzjcza3xaHUsHLELF729kaWJenmoDQAT9mJJKS/UM8JzhArkVQQPShedDz1d9CIYnSDR2Z0A3j/KUOx9hMIz4PgxkJmefkbyn8tQFN7tFVzcATeaWKFU+9my3EolZEn60JPrKlLAkDa0sYpWgDcEZeY1R4maRayBN4yFN1z0Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4uxKVEI64SZfOxag8RXZjtnhPCSU/wfu3bioSLZowE=;
 b=U8UgkFFvHsEtfELPe8krPpR+Q02T8aC+i21xxXpuLMEeqTdtMFvq6ZO9f0cyc+OEnB0bulgIbDuWniqp6dLOAHJHcHBq5h525c+XxuhHXExmJt3lchD9A902FxN1Dk+/n7MAtRdgJtYUWI0/zUmQV28u4/KvN6nKcEdd8Uvx3Qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:35 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/24] spi: dt-bindings: renesas,rzv2h-rspi: document optional support for DMA
Date: Wed, 17 Jun 2026 10:34:42 +0200
Message-ID: <20260617083502.1074160-5-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB13245:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b23a74-c338-40b1-205c-08decc4b66bd
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	DYsNEhkvCzjRD8sYQp4HGqnM0ASzoQ2ohQejddMRIlgOLnSRBWYdqJl4ZznlpPM6n/PI99K0qhNXKq3aNwEP6pId+OWte5Ebbm8wTGGfEIcYuhoNM0gXvtumX7L9SyAQr6OCiuOu2D4UFGyeEyATGXE74w9xMnqCNkCNhBsoFK/++tDSM3IX2UUGbf+ePs/sYHCbX6jWw2boUdC7K/kLQrD8S4mSANpM20IrAMAU3tnEGA+WRjQpI/ytv5qkEW2FW4q0zo5AiH5fFlo2B2hy1mcBQGRXkuduQZBcNBmr0xvOco9jfhHjs9XQv605aodtSquA+ROUoJMgovbuoO+BiYnICy1kzPmQdeFAuTDNpAnp48Eg2HI5+Hy3eGOROE5UrpYMVSHR5jrdn/Yf2StQHSV1DDKvDZ8oOWXSd7CUnk/zCV+l/Cut5dfIQ9qDiq45dpbTtLy44eoRSsAG9QD5/3NrzHVzqwLT0IfFUisW2xznECCxBq1tLWzQ92KJTpb5bxGJ0lypO5krFvHcz/nRu4QzpshPZ8CR7tgzh2W8CCBNUkmux3Z37+gvp2YmKekeELgFdfmcGlF3mrHZl3l9wTRSAOtLhy6eLY6eNL69Z0WJ/vI1x1uWbCag4LjkOZzB5xt9z49eleZCumhEFF+NJr5wcKKCOvRSweLryiiJf1DSmPhd0Yi6r/gI7JRXfv/U4ptPmSBMRbZHS6FD0sAi8A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?1irjwLMuu4m44KKYdB4r53MOTaPdgxFMhOKzQtUmjte4FaYxogSI7iOyWqHm?=
 =?us-ascii?Q?F2g/5m2TIBOYh5ivBMmOUA+eFxeyEs3oRkbUcVn/K3z3TT1wxW9EgtiNUjVG?=
 =?us-ascii?Q?K6ZdKZfOCLtEIoJ9QowKsFwoa6gKMvl1VzNqL8vaWcceSfpU1XJkj5Z+bC96?=
 =?us-ascii?Q?H+QEecSdzgvzyyY35UQHTxmchEsWuynqUlX0jS9iEHAPW79YSiHstPRmAho/?=
 =?us-ascii?Q?51xBpZ7ZUJ26boQFpnS1XiByLy6Z7K0WKv7fVFH03i7HM0iwzf3poXPD6G9N?=
 =?us-ascii?Q?k0yc6N4Wgaw2ynPwfDuzDzWIG3Ac2qUfFV8OwWeOvBpyFcoOw1zMpRaCADQK?=
 =?us-ascii?Q?yE8WncSCfQoMDzIIHaMB9oBGOFP9txcTVpgRrkSNQ/k2dtKr7LVAW1qHOfEr?=
 =?us-ascii?Q?2Kz3EKvMtyNPofXAo02zaudNUozMXldeJFHN1+vZGWyB5j/7b9IOBUCF2nmO?=
 =?us-ascii?Q?/s8kMW/27WSIZ7X/HA2UxeYS2WY8wS2KwQh+XNs+iWiCHoC+BkH6DDXMJQBQ?=
 =?us-ascii?Q?w40upaoxjsi2poXDoOS9d1zXZriQ8ujeNh0cOwQ1kFPGQL7WHzCIBVHZpH1D?=
 =?us-ascii?Q?aNWWovTnHFdCvwq/6akkOBx0Qyo5+dSHMh2DsJjt/JfDBaeqt8TySa993SR4?=
 =?us-ascii?Q?boeOXqiTOMEm5z+8Jv33aA5MM+rZ7FlXwW6B8NTKmWD4vzEblUcp3oYM+NyF?=
 =?us-ascii?Q?btkHdxEUtQW5bV5V1nGxssjc6/cXFs2qnXFJ/I5YC/xnJF/gkHKeO6SjkJe/?=
 =?us-ascii?Q?o57WmwJSjd+QLh+TS/hvGm3kXWLQi7eqH1YiQkh2oDYIHA+cNeDzuQe6YdTO?=
 =?us-ascii?Q?QqIKqXoXjGaSpTS28oMBbZIfw8pZYnVMmjJHI+BkN6dpXvtui6Une3xYSMO1?=
 =?us-ascii?Q?jnXZW3KkXo4axj5ug6evc4LLCQnEjkGJSRpaZxoohy7KHQvanlxrkmWyQZIP?=
 =?us-ascii?Q?NIN63GJ6GGm1DeUzyqlRTW/UtI8jBsM8n9SRKnR2tmyauikYt0R0eFoGqjh8?=
 =?us-ascii?Q?DZRwXiDcypC/ZEQqesv/bm86K8fIO+x4Epu/GUJO29ZdANXKE+6Dh74x+bG2?=
 =?us-ascii?Q?sCX7PVqzqn286jy2nyhmNUyGCBoLNKCDfxqnAfrHY7V+d88xeEq02dUvSbLo?=
 =?us-ascii?Q?uikMLoJDb+ZiomPX5vOXvEwS92145iRAokVt1S+AxtK9MEUx6MhpjQQHPeR7?=
 =?us-ascii?Q?QPC7Vdnsuk/dTNp2OK0V5vULf/eAZYl5cncieqoPjzG2w7esQm7z6HO5nNzG?=
 =?us-ascii?Q?sBqPgaZjIgvN+2QFIKu/w9tALGEyP8sCvPxrc1Xw9iKNXj29oBIyEbHUVUYg?=
 =?us-ascii?Q?suidhVRdeo0W5KUvTLAUAexD5Bs8SS/oX/fj+FHknvuDACr1z/tWY64Vyyi+?=
 =?us-ascii?Q?sskxGmP23eduJDtmxLQz+sBOF5JhEa+ZsyMoUYIdIW0R0xyuc+KzU/XV/tAV?=
 =?us-ascii?Q?YLIx5AhpsIIlxOkwc+newDr8ql5CAzros3hG0H/KVhc1+8Fsfi8BPi8HchLh?=
 =?us-ascii?Q?tyZ6ivKjcC31JExdDsYO/mxWv2T9jVhCjjfBkHa72J7xGN9EDA3tZC+RMvPl?=
 =?us-ascii?Q?YyZZUlCu0WpTlD9Bk0rtCCaxSDGx8tsCd+cwPJdd9K1NBRfN2Vbf1IJZ1ID3?=
 =?us-ascii?Q?4qP1OsQxf7XBENQENAxxNmOQ/bo4V1Nf4HdjLlaPrc2T3IImmchWCvkIeNc3?=
 =?us-ascii?Q?Nx88h3rxLbUlk6bCInijj60En19BsLW1TDGT2pbQGuS4SI1YwIeQjbrjoPFT?=
 =?us-ascii?Q?/zfqcZubvMxkP2qpYVrgSZBlwEKuY+rqmXfYy7FHBVhLR4mrsU+r?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b23a74-c338-40b1-205c-08decc4b66bd
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:35.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aeHLE8UcVQ8xwKo4EfW+ZSmVOwgu8+tBniemrKxpyLii2mPxNOE3f8oiA+SWJ3vMPB6Pp2mdw0jOcD/4j/4IPWS5yND5JHYWDpW94mHTZRlrVw+vXkEs2QpCfntKNveA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23196

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 163345e356722e98ba57cd120787d6e991da7b1d upstream.

The IP supports using DMA for reading and writing data from the FIFO,
document it.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://patch.msgid.link/20251201134229.600817-11-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/spi/renesas,rzv2h-rspi.yaml       | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml =
b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 069557a587b5..a588b112e11e 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -57,6 +57,14 @@ properties:
       - const: presetn
       - const: tresetn
=20
+  dmas:
+    maxItems: 2
+
+  dma-names:
+    items:
+      - const: rx
+      - const: tx
+
   power-domains:
     maxItems: 1
=20
--=20
2.54.0


