Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42E0CD98EE
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:30:44 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.28])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10903.1781685042426952964
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:30:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qcwIvb7c;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.28, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yStvGc216lkZ8RUpwjP51xO1/gw5jAdjXl6Snd4mt3SrwpxrKUOZ1FLEf0VotA/SQPqZbjqiz8MP7suahuorPSIEi6rnxeQqcVNERJmrg5i5YyFu6q34B2wEscTTSKqYo94jQ9py/ENOqtSjoLxyDdPPHGa/C+RX0KqMTvBxFZzA3eVflB9KoQ3o7UZayslg+n1xUaOgJMdQ11i2qpG4mBHWjR8zvFK5qI9o/0Tf+dRsKIjsHG8yLliBWzuG1Rl9U5bITp+3dCFczKGA+ZK0vif9kf/+sMTEdYGyo6lCF1FoCRNuRhd47fPLR4CMHpQQ/oMbufqIRMWyUNz7eaml7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ei02GKjearLLHDqjOrjMHlcz/TqadGSBLM3vheIq3W8=;
 b=GWxBwutj6XoR0xG+bP5puIcSaNENgEUsY6qq+ex2zjLha6pHSNwTctSLMu69vcB0+jpdpBEuUWLt7Z7ydAzvWKcY1/ROVWrxgoyKJYgkcS3bJhajpG0mxUTsOxXV8zSWwsDQGfXIz+3louqM+5PaAOm+32TZG8thjc/6071vjEELTW/88shUjZJapwqEKy0rn3vwTKgXLZSK0PGc0nlc4AzFxyUuhmvl23qC+4LmhIKKTfQOgDBryHHqQSK3ciyEV8vOAKgery5ZpEjix6mIJmVHiJak4HQQJZScANBtY3LU1Mxs2c8Ic9FrJFteNSkxXuuT1oWraRX97tReOhTP9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ei02GKjearLLHDqjOrjMHlcz/TqadGSBLM3vheIq3W8=;
 b=qcwIvb7c4y0DF/si/t6bF/csz8PzMtMHn1sOpBkhhdXSe15o2MRKvdq/GzpLpOsgrN/mLLGxUReS24Fvps6nOyIO56J7G3QBgqxOgrExo0MReSlHUEbRFHiMv45ODloOu3w1VZawny3TXMsYBZS6jxp7IKabxyC39szkXWsTZ74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8217.jpnprd01.prod.outlook.com (2603:1096:604:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:30:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:30:37 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/32] spi: dt-bindings: renesas,rzv2h-rspi: document optional support for DMA
Date: Wed, 17 Jun 2026 10:29:35 +0200
Message-ID: <20260617083003.1071543-5-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f13409a-1d4f-42f0-0d3d-08decc4ab551
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|23010399003|366016|1800799024|56012099006|11063799006|38350700014|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	3uTmXmDzcmwaUvY2Kp2e0kNBhE29Wp++mnvyhuzf0fNTlOXtdMwrQeL00/Q3VIkGGhO4MCFl0UafiOBoo4Ah4sqte5NqMB8VrVhPNVyKLVZHdsC03Os3CzY+Gp+n/1xNfJbX2p2zPywImQzMjYLGDGvce/3LfZ0PQ0lRfm9Y99nChrbF11oZmcwDr6e3qI3dvDOaaXcP+1/9zBKt3IDrVI3xVFHcrseuoglVQJ5mdNcSM8ot3CGAvbJ78dQg9d5rKj44WeMEE9rcIR6MCtJG1GUxD+DxSOpDHSmiJYE+yjreUbLT4b6qr7OIWO23ovKLFHrMmEstvefxA+lwEwsrK3qQ/VTpjq3s5TQB/WNDXbuUzy+7LSZdil5/qipreizBxH4TPLsNQSH3rY3lTYas/dmYdY9l5FuEV9IzPhjOAnHWQWgFW1eUr6p3nGD+3oSwVCHsfRep0yMKQrpKI6ABrqEIKG/GlrJkR6Dybwh5noYKJXI00oUAq/EbBCuh73zRuQvZTLjCO/sQqOMgvQxbA/olF/S06o94ZVQHB5z4ZCgQ9kLGt48nKb/GI0NVrLHL5ftMwWYvt2ApGbGDwx3AFK5sodcxq0jbk/1MwRUaUTP+8MGS+TYgySExaDsSRoqwruhsfwgqT10oDPHt+v8bhwo3/y53ffB3YpcrsbDcdO33agmX6wtTodGKAbQZBc9LWPg/jqJnJ8axQKUTmTojMg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(38350700014)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?a8PT4k1CrRbsvcA9WGXt4NN9nSFUSICrC2iLErxXR2ZFeV6RZsv3eCci1tPs?=
 =?us-ascii?Q?0TUO3QYwBlrJn9jxeqLmDCPHs/4wJudgF4UShg60slel5Bg+5XJzQQMWryb2?=
 =?us-ascii?Q?55tED+gAHQqHhWqIK/Fiq5E017C10EaBPIlXL6w9KnSKlts/mssvF6IEXfmo?=
 =?us-ascii?Q?UmzJr9IPvQZwMcscq/EaARkrfl3FLw3lhqi73ZYlAKMl2X4lT/el2TdMmv35?=
 =?us-ascii?Q?3CuSZ7S4fov3UPmqlRRyk7lbNVcfv+1Q/sqq0ZtKgLr1D2SjXfH/NhdW4R+3?=
 =?us-ascii?Q?G2KCkb61mc59ns2pXzWW/2IjiiwtIS6tCT0VOfTKOcnpvB7bBqFFS2d8ZwP8?=
 =?us-ascii?Q?Yyky2mS5XJ5bxaJxbhVab33jp8+xSlyO8O+2eUhndJ9eo/44IouIjgHmz/Og?=
 =?us-ascii?Q?exbiI+hHNIuZsb/NIJH2yvc9PrEZYEnxWMYHi1jovMP6JyRw8rKhQwXWzxjk?=
 =?us-ascii?Q?ppjLrYaVGhCRKz9Nx3g0d50gZ2efaaM5jClF0K/op9OOmBe4Tj2cECC1HpSs?=
 =?us-ascii?Q?YS0o+ZEFcJMYW3iRXBrEh+eMKaW4q4Scd4yVGM+/tbhEkmO7zREKHm8FW8gj?=
 =?us-ascii?Q?ES3AiKFFvpzufbcEphrBoCzHxRN1uvVMR4oD0GP4bhdnywNN09+HpOlop5Ac?=
 =?us-ascii?Q?EvgJCBC6U2FecAgIQp2EVghX+W1D4ARtJeRVjpc+v2zeYmd/qjeOs3TUc+t0?=
 =?us-ascii?Q?oPKyhNoHtIJ76PIyaBGQqPjyDMkGFahsl53swOLb9+LgUn2HG0KUua/VV/yd?=
 =?us-ascii?Q?jySoTO9xaMYt1m5vKU+QQacLrWSV/xdQdUfD6hFnSdeBHWOUjjh0lEfjFKvR?=
 =?us-ascii?Q?OCy7Zq8ljQ/55Q3pXTSCP6AFMUq7TTJTrV3OZXGVEN7SVI/eLlwPPYK7hdgg?=
 =?us-ascii?Q?enybUtOE8nht94wWwBoOu6Tdb46UzR2zZX6tYQOJ5xsCKB8VV5hruOiokqFG?=
 =?us-ascii?Q?o/l0GktZR8WSiwUWdQF86Os+z5BfPCT4ehISlG1d3rkMJDbrB5qbBQlX0TnS?=
 =?us-ascii?Q?NdNO0UGJ3seigHFYFgcLkUwyWAR1StHEsKwsm7DyICrU5+lZdFjYLMA6v/VT?=
 =?us-ascii?Q?+ekJ/az3WpIiReW8OzPkK3952KaamF1IKzpy4sjFhog5WBq7ACxqoA1fKHSs?=
 =?us-ascii?Q?5TTv6xQPH/2JV8tki6qWyk47aE8jKZu7HxS4Y+T0tQ8V7Vee3h4dNGax6juT?=
 =?us-ascii?Q?R1IZEdTKYZKF9daTd8Bzk8ZDEVlu9AOdsm5z+ThVDkcSIn/BgpeaOlWYMfKu?=
 =?us-ascii?Q?Vix/zHrcJHx63BNxOWYFXA7o3ZUQ7kLVafV5DBo94SsU3MFm10SqE69pWwPr?=
 =?us-ascii?Q?DB/1DZoSEqbayJywQRV6ro6ATabkcbPhqcB2aFRDXOFl+ZPg46NWjqtnE48o?=
 =?us-ascii?Q?pUFtYhwamGCoTRzRMUap7GZ7ljucuH9EQHhaxVbQdGZS3q2KJJToUGzfw0ZG?=
 =?us-ascii?Q?AhSK/yISXwLghNxoIUFe0fZt345gKSB05xIzmsD4WKOu8GAOqEq/nAPBx+vO?=
 =?us-ascii?Q?Ggs4ftHV1pMvcR05VUBfiHLQaHTj17HTDRUalzmoK3+RUc7xClIcVEV2tyd/?=
 =?us-ascii?Q?2eK3DzskL3ZKGCxll/M0vxuTDpYHq7sXvnZpY2LLKhoEh+SnrpxT2KWeHGcx?=
 =?us-ascii?Q?fVYzjD1DMUWRJjLQGlHfLq0xJp5HY1Ike1x0aVZr3ycnmfXRKW4TADAOq0Qu?=
 =?us-ascii?Q?dmoQH/D69TvqG/xbBz/K+XqzcOqwB9LxnWyuum37nhzFJLWMicZ53QJYA7+z?=
 =?us-ascii?Q?O3oflnt6r2hadtka8By3yq1g4dviTlqHRhGYBf9FLfx9go5LdmtT?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f13409a-1d4f-42f0-0d3d-08decc4ab551
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:30:37.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4OeKvtfuyTgmS5mU1302Ymk/JLgEY+OeqKTSMKVqG3vsAQPggrfqmcavidxPWujY4X6CrOIR07fqciczyysF1C37G4ZYwva/BNv2DYojKPtNpD2uNUiz7YB8uogTMrus
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8217
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:30:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23163

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
index 394438b3d680..d7c32eb9b981 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -56,6 +56,14 @@ properties:
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


