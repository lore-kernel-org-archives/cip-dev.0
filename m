Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DA3CD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:35:46 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.7])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.10990.1781685343361971596
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:35:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=kuQ5vpOd;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJaSXVQ8cRGx3eI2XXRAkaMaJGXSbvP/dJ9jIfd/iK0WYCXKfuFoMgoBgxN6b58Uwy1EXFuYs4+CdYWxaH77w/2wBg1cqEhc3sCrBlOrFia827qleaSaEq62PrazkjAagWvpOXgGhtIpk/8Qd6SmnQM4l16USojJWglXO5Cmi6mCO+MzqjZ/x4nApLG25wAllc6mgtuEm9OG2zLiOoExBeXCKZmGRhDs0jzTmx3g7hy4zRgHNVrlDeSJf/tD39xIKlRDMAKVlr7EmP+RHPDxBAnS46hNTqdU2iSuDJXtNnTOhf/Y53iX7RZW6CkagcqNo77dardERjQTxoJM/OnACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GIZTWkZ6djY/6jeq/emMPnNM+lwTSswuqH2hmpKzkE=;
 b=Hl0o6ouIBMaNjX9UXK8HqiyyGzh3p4AuFUifhy4Wwwo3Yd3XGP0Z2NG1zX36/KTsL8T9C7HRYGSiz3dXWOWgRuXYkl7MtJO/D017QjdVZYWcf9OPx3rRaJHOd8rmeEWqE6pnfbmZPi+kAqznG2FuLJDjTIxU5pz4PIAixmvb3HjDFll3QiUN5HRnTzPnuGM/iy3nGUvsvsRD40q2hdQ92gOo2Esz0FptGOP3/vdUasYT/6GRh522qZ/EKFYHfRIVKTLfqOAXcy6TAymfiyjUD/th0qHErIVxF7tdN1RMgwJpFT0uZDHQwOU4NoYiqwoSypzraZeq9unuYSJXCAqXvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GIZTWkZ6djY/6jeq/emMPnNM+lwTSswuqH2hmpKzkE=;
 b=kuQ5vpOdx3/TIMMVo0+P3tKduLpbiam1evHndYRg7Vkdy8Vy1ijaPnwh4vM7V5n5whjxHtHNKi1fe0WRYLgKHsDMlEflI5VIv5+buR7W4WPYFjXlPTIbCTxlE1xu1Rjhg07JBXoWU1X0QLdhwaODaj1aKSIkmHd7QWMvyt7cvF0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB13245.jpnprd01.prod.outlook.com (2603:1096:405:162::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Wed, 17 Jun
 2026 08:35:42 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:35:42 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 06/24] spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
Date: Wed, 17 Jun 2026 10:34:44 +0200
Message-ID: <20260617083502.1074160-7-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: fa6bc8ef-5520-4fb4-3141-08decc4b6a87
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|52116014|376014|1800799024|56012099006|11063799006|22082099003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info: 
	Q1FjVfpCLYxSes34psjt1NV+B7QZAAKYDF2mUJNeWc4JtB43gD7XB1Kab6reud2n1n5PoGWCG2OMGkghlpLeUnHCel0V27M+cBNV0FpdXK4YGWeBozXmDS0yL/T8B1S3r99I13UCY+/Jz3agNLAI5rF6z8UhNuJXVpSzvgNBQzJ3LhiLz8URBg4UW4n+hiDKLSRAnCs5Lt5WkcXG8QV+Ga5MLbgxvV0r0vUjiWJTSLePWfrZhmClHySaf+7mJoV0HKJmQirSYDym3xQ1jOfvDFNgFkH8e06MMsI7AsjuLDINungKG0tsnQbMblV28DeJmtu1hKh4MoB9i8E0SewbhY7Xomj7jehzdywFVYrLWciP3Acd0GHqQxpaUlhM9OK04cHe5o961r0co3GXzOgSGzWsXJSX9uRW3ip+kYLjTbMqIcifOiiZPyFYyv/1f+CPgqW58QzrqBOUEdUeR7eEuyD6UJQl7MVbatxPmY48ZQ6tFS97F8wyZ9woGrepc8GlQl9NeR1S8twf+SumiWQ4VACbrvuOePPXIDo7O+VQZBk8CNd3ZOxeeq816hvq00hK+LaUYVntf9EB/RA8N40IvkmlGdQcFL8sWxOAeHXn75LtbKADlSlYkleSKHIUxQXWyhD37KfZZ0O0XAd9ZFyHEZYgxNj2dv3qGMwRLJIOMReyLFvpx5ooTGj0bAaFVfvo1O9gkIwIZnrVerXM/8q0IQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(38350700014)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WWgBU3sJQxm72c923GWkfg0Uqy3tlLzKP3VGge8fzZfqXqacUl8ESG4BliTF?=
 =?us-ascii?Q?/yRqgaWdWP8Lv0kuHZKwj6muBcVjl2m9Z8LZkjFphKLCHJg1FwM8dec3ZvW7?=
 =?us-ascii?Q?HuaJVREFUpj40oX2DSWAzp6XUMUtCT5+cmkGwNgjSdPtQcJx7UcTz08C2Tgb?=
 =?us-ascii?Q?fyhH2rk57f4EOYuZVNiDJoVk/J4TTHU7JspHxJqsYAH/wlh0uj1zqvBmOq1L?=
 =?us-ascii?Q?T+ClBoVLquf4eLRDtSff3FN0eflIj3KYW7ofhQQA6E5wzKRUp7TDx57nMgCT?=
 =?us-ascii?Q?xuq1zW1OXDw9KhKF5J1mzGliP1MdXdx+sfwbFeBEK6b7r5R8sbzddXnDlhAR?=
 =?us-ascii?Q?FenhCInUhC1bVrXLjgAu0+bk3X+HWphWuI06qUKvycT8EPy8gZmqXt3y7n93?=
 =?us-ascii?Q?KwUcP12B7JxLCdy67hEyRdM0/a1EFRinjkE+ha+M+8JhTsqF6SQHjuIKNYFe?=
 =?us-ascii?Q?rtz+SvztCltv2tTgjIUV61S65UWyycb4NZZI42QJHqFyW2LI+AfSUujlCtDe?=
 =?us-ascii?Q?JvgM7+M5lIDyfae9KMarY92G7iORGauQf4+PRhKrDPkeEYYroF9bqG/7DzDx?=
 =?us-ascii?Q?PeDBLipYStD3U8w61rAEtjDXHb+gv3yhQmtbAnT+kb4X+hE+yzZY+urQYPN6?=
 =?us-ascii?Q?f0il8r8xcZzA8leaiiHgk2Kvg82jYf3v0zkYs9YBi+y6BGlxHT3ci0UKHrmW?=
 =?us-ascii?Q?Wm5yAbPQSno27bSmcR7KItdQLFcI0YeVws8yHXjx/L0RB5e3CAs4q8ude2bs?=
 =?us-ascii?Q?d8xA7J5vdN6aZn+FPWAtcXoL+fDokgr7WbqmFXgMuTMvxZyz2X4QRlYJ89IT?=
 =?us-ascii?Q?F+pGM9dtedgSIOfo3BQMNYYlHOsPvdZLTqz81IsohDxmZ10rtMarGGiItR/N?=
 =?us-ascii?Q?QADmlT/JahoZ0inp/VoacG46Fw80zDnHht7r7NIMdXPKM0Fgr86PtdqGLFGl?=
 =?us-ascii?Q?b3qWssJliTYMbuelqsg3+5neDhE/SasWqyiiOiZibZgHhz2UQn9tOSyAtRz/?=
 =?us-ascii?Q?XYsmEySLYSq0DhjxqAeQohU8OrV7quXBY2cK0xrp0FzIQ5oQaAMFIc3078CQ?=
 =?us-ascii?Q?QH3iRxh5UirGG9GqvZEAZivcTgIxTiG+hl7YjV7K9roZgH0TSK2U6nuUXhvs?=
 =?us-ascii?Q?uUc6JSARpDvmKyCB61Lm99A2CFAlnLFnePVwrpCFEqn6l0JGrO+NP9FfwVWA?=
 =?us-ascii?Q?1rbb080mjz6VIbxJzZq8ILM2W7lzDh3meBBk/nS6dVPqx4Nxy4KmRb6EbRh1?=
 =?us-ascii?Q?IELJhrhS0Vj9MoyK1M8oNvkEEbPhA1n8llY96WKHTifYdQaTzfAW49ewp1UP?=
 =?us-ascii?Q?bunXZPP7KHYSQQB4K6ACbnXIqmL18mz5XUfEdiKtvbDkLKCGH2QtfblMhlDn?=
 =?us-ascii?Q?LZUrnjuQMolK5yqcwOctSkwvo6ILWj6kCQ/2pxQAvR8IfFOAYlXR4FDI1s9k?=
 =?us-ascii?Q?cwAMyiD2qqeB595LXQof6eSro1u6CeRinsAAHqRrUhk5HMNDy3ESXjG2rX5z?=
 =?us-ascii?Q?kNZ5j0cDFFvPTyblyi3Dvt1WANUjdi7TzuBtEHVDkv7LXLxhVA3gmeMHP+mH?=
 =?us-ascii?Q?WNBPvViwLLYdzpExdDmoz6tEL5hu+owmPt1YdEzFEcYutycP66yXJPV6D9uh?=
 =?us-ascii?Q?MBM272Y151GlyReaoFRZcobyDybjNzx4Qsp4RZ/nGCK7gWtfwv5FM0pxZO0v?=
 =?us-ascii?Q?EZHprTA5CL0L9wTD+j8KxxBd5JneBvk4GiAjSh2RFlBJOaiZxFqAI+11W6JI?=
 =?us-ascii?Q?FTUJHnjVf+/qAIrUSEZq0qMetUg8Dljru6L+3jWC6d8nQXU7m5+z?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6bc8ef-5520-4fb4-3141-08decc4b6a87
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:35:41.9427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TF5PfoEVtGsShjLsflAZFuqCTtJMeBI69K54tbexxnaHYa9CpE0gzYKeX6xM4Yvc1CrbDiXNWS06JM0OPI80Ay9f3NN2BKYBz7A1UdpiU0fX7ITSG4f4c/PeUdnezUl3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13245
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:35:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23198

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
index cf8b733b766d..d6a5338d6521 100644
--- a/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
+++ b/Documentation/devicetree/bindings/spi/renesas,rzv2h-rspi.yaml
@@ -60,6 +60,9 @@ properties:
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


