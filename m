Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BEBCD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:54 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10732.1781685047025390987
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pbh+cQP1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jG6xNYqLDwKUDYztJyzqZPp2O3gc3Z9rwxuVWfPwAFhHZ3dUw9MSd/0ely6ADLhBJFT8eOiwVsRT71+rCDkIUNgQFcVI1Wv6/KLtl1SsmPtjfwxkHjfN00kReNIbJizaVnTdLvRE7A9v/jKRPynbQsIfHsyslqC1DkDqauI2TofAAjFAPaqD+SnMW6qKiNQIHfS/VyV4mzgumOz08kiEOlkOGiQWWgYnDNDPOhpNlfmYlYARkON2roryW82wdxNxbr0JoTffIzXgR6FTT3jeA4g/XJuta8vMVbFvDyr8hjX7ZVXjM2JuuPQVMdyvmEsy4wLkK8wZAnBq6KKqu983Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFKB6ho7tpTajI+BX00Y/h/0CooHDXOZEzJ2vkdbtgQ=;
 b=SHTaT/gjZ54Vhx3rnUXankLzQb+NImi/T+dtWAApVWRNWHAK2fqb/SpCczi1mzKxxGdLVxb7yGQEgRxybnOjKsOLg7Zdxn5W7mQetszClUzfyCcm2zIYT/Wr+qWrNeEfHB6tnr9DSND4y0sj0/idcP0Q2L9JQR8d8R0jCcwN/cRwPwXvR1kSv7z2hnfvks8AI24c4YccFAm8UjrKsmK0SkBC9hfaQyi6+kFTyLzfUck1yxBD9cxoHeZtM/Po4AMxNJ7TWxaFLrtHOEKF9Kreq3NPjKno8xSSG1vNhn+bfuz74/5gNeiIdydplbLB3foMZg8fq1+palYxIPDgWnlX4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFKB6ho7tpTajI+BX00Y/h/0CooHDXOZEzJ2vkdbtgQ=;
 b=pbh+cQP1+55nUJD75iIVjUTRvwhY46QgZB7neYH/+EL62L0I2mKWs2ZzvUMdIT2/4LVib+aEsg3gWa4YvcBqJDUNNV8CqkgrchBa18dmqZJcuyRVagX5tPbNAg+5lUvaVnA2SLH9hm1WOttCeGyplmnPSerm3MRn6wPKpaI8M7M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:44 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:44 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 06/32] spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
Date: Wed, 17 Jun 2026 10:29:37 +0200
Message-ID: <20260617083003.1071543-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8099b376-2c7a-438f-fa64-08decc4ab933
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	ptJKfQ8LTN1XX0zq9YrxkYTOyPsdCt3sa884q9suNEgG+O1FuzKn4IAT7bK0XtA4kH9s4k+7hMCMXUwuL7m48YGn9lWvKoF6IgJu6Z+2RFxDiqysUiU5hLXSAd+DkckszccFCNHUhQxTay2gF3VfwiBIdU7cTRKzy9uUKp831aS3FwgWSDh2u9QLdNIh6TWDAELwkQHes/OAEPSehnpjdGzy2jLIU2zKLcZZdT9Z+e6XPyunvN5VMoiAdBqMWi+xVcpbHcUEvKB8tjyGPy0AXpfX0WhZMdkg558kl1rmyMyEZhSGtUE3h+SLo/zym/9Ve26t/cngkgiDiLa+fww+b8Ww1rqzbngskCnbB0VOpgr52ajsooO7lPYQr2afAF0VrX8sBKU5RtRwyr5Pc1r41MKdoZXoUoNXkPGzEwJXQy7kjL+cMgSrfxRLwg4kKM061oyCCKMVm1xZogy2t23EiojyO+OsaTG1yRkCb6lawX848QWlmxyTmvF2q5a7JNOBZdhKS4yulhEEpy0i98xFtnsmW3TgHbilV0Tckj1eeJvH72DxVlbNp+82yXaj5b82fa3kjvQ/fbtEp73ahoLQsdbDKkKdVJjLJAKmXo1Oi6hFDZZEOhjAl5RYmm4fnGN8nTekrUm+GJWDIb9/U2PFDLs0gWcRFEbZQtHYrkzLP/FQnx5paQA5o2bYh/VESFX5ZJA2Zq4QHT73ZwxMjg9WcQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mxf4tbCXPwqzhzAv0SF7SJ8htdQLXpbf4MuHp7rhuOtUTN+9SSvX9Tkx4/Fm?=
 =?us-ascii?Q?jap6Pove8ygLzeBSjyzbeNYvoHpfaH6cYUvxFLGlwDvelL3SE8r4UU5BkrsB?=
 =?us-ascii?Q?sOhvucvejYHTKdtXrkPeNk/Nj6rBzhsijn4qULCs/PqnDwEjI4MoibcMR4l0?=
 =?us-ascii?Q?tFb+HQ2hcxj5UBapwM1f3KIASh1j2O5O6p5yD1znK0IuvoVp1hPv5xywFHPy?=
 =?us-ascii?Q?m865GmjaImU/kK9gFKgbVPpGp8TZeLiGUMgBmPEpDb6Ed/DoWXxz+wq4Hod1?=
 =?us-ascii?Q?B6cZk1sofGgHlFeoxIRRIX2FkcuRKGM7BYmeDhueVC4j/RPvwVzUWYyaVxcJ?=
 =?us-ascii?Q?O1skj4W0eyhIeOdqdC9Ct6TvONs9azoncf+nBy0App2I9HivSjs6pA5x8eJ2?=
 =?us-ascii?Q?cAA+xAOpR6869wFhxXIcQjsR+GpSqwzIr/H4JAo/WEbxCGLUiCO441UilmHs?=
 =?us-ascii?Q?s/UrbVSTC884OeAowYWaBC4VYCz63cufa/lV1e9RM1me62/mn40tnRZzyssk?=
 =?us-ascii?Q?ahMu1wzTlAmzXnAszjn5QkR6XUToGpqpItRVvqUpn152dzk9e1CuTJtNOuHW?=
 =?us-ascii?Q?fowHrSTjsdzj0F2KVL7r6fRFS2QXkjg08mxYn6EfVwszP5GEjnP/6xjKurt5?=
 =?us-ascii?Q?VGZN3NTSlhpdajEyEJVkcxl/y/uVrDb7RIg3ayO4/479zE1vQSlaTcSJbghk?=
 =?us-ascii?Q?i5yX9hyQiSTRq0ixwvomXYe02Css08fpnXbRXYlfvbo4EiNrB0j+KjCfg19G?=
 =?us-ascii?Q?d7FGw2m9rZ5ncSfpdO6Vl7wXV+Ks+4aHy+Uhcr2OWlJoKamz0APlCdrBUW0n?=
 =?us-ascii?Q?HaY5abpy0lbemqMkomvmr/75hvxXzPBfhU+s8lxx7Ej8YCCu7AY21nrJP29+?=
 =?us-ascii?Q?a8lk0T/MLIXh6xHk71ZIUBWND2wW4f35aqcjfE+Y5KgWV+F9cFJTG141DVhC?=
 =?us-ascii?Q?jYFHzlKI9Y7B/su+iOwvWsMHCqMY4TdexcmdLLeMV+ERGqxVVc1MZlWYNQJa?=
 =?us-ascii?Q?ja6ySTZubNyaaFjWUs5bhPoOZXqhg9Tn8sI6Zf5vJNHyrrokx0Zj4nu4mzhU?=
 =?us-ascii?Q?qci3bHvGF4+ECt5p1cZ2J8z+tU8ckVcBUnHtDv2ke6y9W0DFMcOQFtK4JlaP?=
 =?us-ascii?Q?NSGPTKEEh2DbGKdsXW+WidP8YS5ByMg1YEL6Nx+SstVy2DCovHoaYnY2U8I9?=
 =?us-ascii?Q?hA1MiKMxDi+ExZc6p6h4DER7dXjzi9C7jMjJvnkqtEaIzG956WMS07ZFa1kp?=
 =?us-ascii?Q?/9+qionHG92WrZ5QBmXrQ5zR8aIlgw9YbyQCGLSuY3tbSLIZut3cL8BYxcpS?=
 =?us-ascii?Q?Yp/BFnsEneoLgAsJjQRXw9epeBGXgXdPbJQts7Y4H4tzsyz0h5SpYhASznC7?=
 =?us-ascii?Q?ieSgE2Ty4ee6OreS+rFiZ5qMVO8AmA2s/TTWSC6OAdd2wpzOBVdVZusso2EF?=
 =?us-ascii?Q?1EILdBsflgqPfDj/dPbvisQ0+7CXs8ifp+Bghb3hFwxC/fTCSe71/eobfJ6R?=
 =?us-ascii?Q?vchGKcD/fJAOnhvslMoXy+kFDb0tHg3O88SlMwzeRrBUhc6Mfxtnn3lEEGJ9?=
 =?us-ascii?Q?OlNR5t0P4klSznNhCDrHgSvs2PiM4f9H52iDdoHt9yr47+nt7FpKLLxNZ1lv?=
 =?us-ascii?Q?SPNpxL/P8oX5Zohy258KfxUgHWcnqsllmRSCqiDW4dxDgwnpobM82I56rM2F?=
 =?us-ascii?Q?/XfWisw+5IK/CHcJ03tHP0hgvhNuB1dRQy4UVuarVN7z/Zr+uPlF0V6B8v+m?=
 =?us-ascii?Q?H+Uyg/W3J197S2BXO5sVqPmEA1FU8cKVoBX2mYB5GICAYw0WkRT6?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8099b376-2c7a-438f-fa64-08decc4ab933
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:44.3902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v6PCImWD18XcDUbZ2hFeAQ7umoCsG+mNw7sfq7TJ6tVeoS+7Mc/2s5EoN2RwKtsY/YF7iZerzrbwCWxLv9+9sXLHkk9zZL7ax0SMwTgbvM92apKxJDVaTFc4ni9iPvgl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23165

commit c2edd7841f58cf228347b91256f0d9efcc1a1f50 upstream.

Document the dmas property to state it must be specified as TX/RX DMA
specifier pairs.
This clarifies the expected ordering and improves binding readability
without changing behavior.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/ea6ed3b82c5a326732adfc0fcdb2922bfcad2591.177=
1344527.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml =
b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
index 21f53d9fea66..0f49d1d697b3 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -59,6 +59,9 @@ properties:
   dmas:
     minItems: 2
     maxItems: 10
+    description:
+      Must contain a list of pairs of references to DMA specifiers, one fo=
r
+      transmission, and one for reception.
=20
   dma-names:
     minItems: 2
--=20
2.54.0


