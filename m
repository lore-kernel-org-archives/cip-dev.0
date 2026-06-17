Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CB9CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:46 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10990.1781685343361971596
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=B7/e41hH;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6j/P+XQw7c+o8YHxaFOH0iEQmm7MtteQy8B/2ra1PmlTfgHT0cN9eId4cPrU2ixTRwQJ1bIL/P5fNpFkH2zutf54S6yjp0STRX1/zik+hkT7UIZielBkXEKrkRzIV4U1CTuP2IYUseyMp3+WrYrNGUjUN3JSaspqRyqU76on8D4QEb7mDdXXm9KNqe9wCcsDEsMAefwtkTuynkPo7/AK4FijAyHbYAoAi/9RdfnKUXGcxHm46HZAUclYT+Js7uFpc740NUeQ7QZmBvLdPWEgYitdR9V7srRMFzW0gl10tQjBTTpbIBJaZPcKaYru7IRYYboeXPiAVI9hAJHM3ECtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XE4r/TqghB4A32D5k9i/fHgPfoR4q7KlCuL1RQIp1s=;
 b=IT3Xk4nDf89rm88xMuFxDb/o5kE95oirNwuNkSLXcBU93iBQrQpwdLIilsCtf3gZL1VJDR2LC0YY+J/UKcKmRVKWjJ2QLDxaaJgxA5MEONK2ElnyqQ1esz4fo/VvjSHLh0H0vPozxjyX4K5SghIjClrB36GWA8rtCmHzJspU1RIFrndtyviDPp7QcsYjtf4KW5p4hXuJMZAc5BxD/uvPzgUl61SkDriwa3p3iWs5kXDQHEpPqdsrkGMCQiwhjoSoIFJ4/lQtJggf8DFLLD3F94U/shi7mM0ZWG88N738kmAOPxuIwCAnk9Y0Piu3z8Mjk6/FaFYOM1kbZzltGIeKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XE4r/TqghB4A32D5k9i/fHgPfoR4q7KlCuL1RQIp1s=;
 b=B7/e41hHBRngKSraPczmYanDkuw4uQZvk4bXiheWLpOi31Wb/fbi2UTLMZQR1a0vm7AqursP00Y6QiwHfj28tGyWyAA7vA5YefFcv4N/8VMjfjuyOPVkwqY5D9eGmsg2OGN7LpGZvKO9A8sXzJ7OlG1GYaZ7H3gLGZMN2BMHPy8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:39 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 05/24] spi: dt-bindings: renesas,rzv2h-rspi: allow multiple DMAs
Date: Wed, 17 Jun 2026 10:34:43 +0200
Message-ID: <20260617083502.1074160-6-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 5d7b8e18-8c19-409f-ad8f-08decc4b68a3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|3023799007|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	FzsrycR2qf5H+yu9vDe6powfrLE2a/oUVw3yhAtDyTU4rLEnKf2TRrAsz8fxUgMwG6rP6JMKL9Gmk/OFnZoxAxZiPvGlGFdmaJRVuHhbJnHDsYaXlqEIEv7O85nXpG9ypMBsPBFzSK+XhRYM5YATy6G5qvLUzA619hGXpE/RWBHlQOFJUkRBdZHBAsQTbPE9TqaGFWMs/31ANpx6BWdI0V2utROOuIT9fLJesS+BoYSQA56XVv0r8pA9WTQyZTz3duAWHwkdd6VQGlrgWTquH3s2CP79J0zXwZs2wxtAZPfbbaHVra2/pvF/dU/+aKEsaZTWbZ1DwOs2KTdtajwECiEuXP3LXmRSlItyXqm0sqv1o23/57fvvjg2o8CqIB115Q2/rIvwX0JkJA0Br6gFbNteXFPblkFnyH96DGeBv/4D7VifnakhIHE6+t9/jl5iX7BENXjCkw1dw1ceAqPuYEeEYYoVZNVT4j1+fThdHUfPR28wvzCII+puTctNG2LIcGHVyYiXeUpxHIAdBshYyrFnfD4X4FogfvA3gqRTwClEDVGYBbPgs90OY3HjxlVxDlbv8GNU2KunJQselfS2fZdDOu9FTUfsaCzEueCcw3OlvpBJLyTlzpkhDtxQ+moY6a5SiTECEdBEk4e9ZYxkGM9PlslXg2eQ3XSIFxk3ccjcJWiyNU6fy+30JEa4y22F1hK9uzx0MLG05jVeUcJKoA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(3023799007)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FmYy2R2rnLYmVixSikVdEuuxAMWBsigmYfitovSfYTDtV3vgZqpJVUNECVIW?=
 =?us-ascii?Q?fXaKrBpxNPp931spXLXHyZY+EA5XdTjVBW+oh8zLkfGqhyWoiIbNdhkI/MxW?=
 =?us-ascii?Q?n7QSsaYLhPUloAlhfmb8z647PagFnUkOx5uwLftgKLBqCFNrnAGy1vxOnK8W?=
 =?us-ascii?Q?Jg/o4ne4jC38snNhB5WuHgSVgKZy998Z3z0NBNnEviKqXr67/5SbycgsLAnY?=
 =?us-ascii?Q?A+K0KSoSMti/JgpKNCfOtXsQtz9tLShsPxAHAgsTCJBKxoMiEu/iGJD/yNV/?=
 =?us-ascii?Q?dUEqu9jyahi67GuHBXBKibFpuRRAU9T/OzEn07BL5X4+IJfDEku5YXsoIXYq?=
 =?us-ascii?Q?r1cXqF7qU6DILbRn/0XYm8vJvoFsHfZi3hCqInQZqB6gy5sjcuQyS/Gvea75?=
 =?us-ascii?Q?puStgKyEuKtZCzuTyp5Fy+fAygu8lrfalIXLWQq53sa9y63tvqiNWEPdPWJj?=
 =?us-ascii?Q?Xp0P532MTouUNy9lyHC6QIG8FQNZ3YAYJYO/1oCal96wdEJywtUuRcXaGHxY?=
 =?us-ascii?Q?Mn8zohTBP9cdfTQbZBiK/3quvAKFUplJNK5tFnBJqqh8B0rBaj7aTFDx2n6l?=
 =?us-ascii?Q?77xSo9tW0s2s+3h2y7doeEaMEeoN4YCH3dHeNdLi7Lh2HfBAaLtmxlgePmwp?=
 =?us-ascii?Q?uVqXFXk0NCHw40thfN5Nlw+4rEQ84k5t2BcWj+ogrUzmmi15f/jmV0IZUx2T?=
 =?us-ascii?Q?ERgoU4lheDjYy38gzENF+eOzHeX+ZSQv5OZL+b61C063ucLyjKY+7Kgs3Urq?=
 =?us-ascii?Q?gouKBOjNMXFnEm9vfdIKBpvoBSWzPWdmsCZKqXZPc/a4MFDzzQTBbgoHoqFz?=
 =?us-ascii?Q?JOfOsS0dfWgSWa/HIfqncvhr+5+Zn3oKAPQ/pMGJXAFo+mNcPpaemc7JbRs9?=
 =?us-ascii?Q?D0gTAKh9TVFpwFGIUWjXXDcpZe7RsWZ5efmQpmjfl7d5Fu37mdFm3hqmpUOV?=
 =?us-ascii?Q?PX3xJq+5veurUY/j7bUcI7CwynOwkv+bt8SrD0UiHaZxS9AEfS/2iAsek+5f?=
 =?us-ascii?Q?TREsmDsexd/7R75TWi93gGOPhP4L4RrI2OT0vsQAcSmFeDxZfEGoleB8Z8A2?=
 =?us-ascii?Q?sKZ36CPlXS0mnXh3X1Tnaw6wbZr8QzZfIkH1gSdknJ7mEd/5afnyXR/3pf7O?=
 =?us-ascii?Q?Zkhk4Tk4fD1te1auyau8CTVS/lndHE/u/U2IPyPF1L4BukXmBJmzfDEL6Xg1?=
 =?us-ascii?Q?2DnQh8IYXtXSIh0wmbSiBP8NeRnaodKQtEw4BHGcGbcx16sUMb3QcVk80Eb/?=
 =?us-ascii?Q?lhmyni95eLfxPhDCdE/oJLasJYCoOOC6Rl7NPf6oWAfqafGjZdODd/i6kcVF?=
 =?us-ascii?Q?QmgDcUI1i+P6l6Kmtj8bA6aGktdtx8f7n2630Bx3dnkfSNRHLECBOg9/HGK6?=
 =?us-ascii?Q?yGgy+gqwyCHrBQH/6DlwZHeovQb1tWuGU5mU9B0psfmtzZD1rJICy83h+o38?=
 =?us-ascii?Q?lufunBmNMAJHUQvySxsOUsOxDPQfYSRmgo9POi4+KmJFt7HGSVtLwnAjdHR0?=
 =?us-ascii?Q?l6NDpasTvrgh1CwfqTJirNwm3U87YLlQWTzdO9t8j3qUYzwAE/0VU656DRbi?=
 =?us-ascii?Q?Q6Q4cN2ChiIxmtsmsoQQIff5zT5bS9FJ5W5gj6Wfc/xglAhj4uq+rqCryTNu?=
 =?us-ascii?Q?SJkhXfTNfdywDCKNNWdNPgSgPdAsF0CUQMPZK6IgzVnNkShG60EGrggT/Icv?=
 =?us-ascii?Q?ayxWT/aq43bQoMB9HfdUdRtSwxp1zWYMk6CXoDxWX+eTbsOkLn3geX5j4PTj?=
 =?us-ascii?Q?m0wP31+Xt4utK8poxwJ0dirQ6GY10AdpG1OO/PtVXqGBFpe0FupJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7b8e18-8c19-409f-ad8f-08decc4b68a3
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:38.7304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rytqEFRy26UAs5w8WDoPO0bwkFmnio6kuiu3OexC5j/Af/xNaFkj8TqGtZyYzbfi5a+obqDcKhnIgnGra6mHqT8Kh+2rVe9F6EEQjDznCaUr7ag1KupN7nzzKWY93pH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23197

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 4d28f38f64ef69ab27839069ef3346c3c878d137 upstream.

All supported SoCs have multiple DMA controllers that can be used with
the RSPI peripheral. The current bindings only allow a single pair of RX
and TX DMAs.

The DMA core allows specifying multiple DMAs with the same name, and it
will pick the first available one.

There is an exception in the base dt-schema rules specifically for
allowing this behavior (dtschema/schemas/dma/dma.yaml).

dma-names:
  anyOf:
    - uniqueItems: true
    - items:
        # Hack around Renesas bindings which repeat entries to support
        # multiple possible DMA providers
        enum: [rx, tx]

Allow multiple DMAs to have the same name and only restrict the possible
names of the DMA channels, not their count.

For RZ/T2H and RZ/N2H SoCs, limit the number of DMA channels to 6, as
they have 3 DMA controllers.

For RZ/V2H and RZ/V2N SoCs, limit the number of DMA channels to 10, as
they have 5 DMA controllers.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260128215132.1353381-2-cosmin-gabriel.tani=
slav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/spi/renesas,rzv2h-rspi.yaml         | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml =
b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index a588b112e11e..cf8b733b766d 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -58,12 +58,16 @@ properties:
       - const: tresetn
=20
   dmas:
-    maxItems: 2
+    minItems: 2
+    maxItems: 10
=20
   dma-names:
+    minItems: 2
+    maxItems: 10
     items:
-      - const: rx
-      - const: tx
+      enum:
+        - rx
+        - tx
=20
   power-domains:
     maxItems: 1
@@ -121,6 +125,12 @@ allOf:
         resets: false
         reset-names: false
=20
+        dmas:
+          maxItems: 6
+
+        dma-names:
+          maxItems: 6
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.54.0


