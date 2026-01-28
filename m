Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D9DD3F08D
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:01:21 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.20])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.755.1769616078397665948
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:01:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=aVdKwmE9;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.20, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5HAMIS3ZQ8CmSXlW5Np2WcwhNe/9An0MiTlB1HNvKNagnk4ijJs4BKksdHkaNnc0tasjBUNRUDKcJfrd2ZBi8Yqem6kRopDzKyp5AiIpy5atq81906B8PAvYIgXXgEtwQIYykkPqJSH9NbU5PCpmUN4h3/IvZyC4ZIfCTrZ68dRBmzIaRQGJvp8OZGuWYlClYNL/0Arul9vqs8lOHJkOL3BvU857Z8Yh59Xel5YGhpZAPECLRfkVeI06asVwY3Sq1lGMzmxAULNuO6lFEBtzPFWSD7gxBwYyicon6+lwQN4aei1hvzKWaa89wKYbMJyrD89PmWqJeCkvyfBXjNYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOZFzPufQWBRgQ0eKlAN9jpZN41avMooeSlAMcBbB/w=;
 b=frrezOkTGo92MXYz6SSVpVup20kt8nFktF1tOyTs9YEWMYXWYfmA3j92ThGI+o7yq7u61INlm1aSQTpmZJXBTPdBXNw4krSoT2VMZa2BIswELRuFSkNNK1MXrBumUZcWyMBfPn6K+S3rKS21q/ah1wARtjpsEgIYEU701JjLbckboQDUMtPuVg7vYktBfh3jK9BrByoEecoPN2FmbVYVjFy08+8QW15tng8lGxf5uzgETLG9fnb7l3MB/w104gKbhesWJuCUc26YaLJBJt8hUTyAQM46v6yUYVqYOR6vjv9/DmluylGpUp7w46K77LpvykRJJ19/+rk0wB1WlqiegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOZFzPufQWBRgQ0eKlAN9jpZN41avMooeSlAMcBbB/w=;
 b=aVdKwmE9Z1Rb1dcQNIBSW+ar1d1EplIYjlloMI41YhxgMFinOJbZuJ7GZNeAJg0bfwFUoGUJyDeVnr11ZU659oDoTcJG+oq7iGtUnseo3dSwjEIQr/l8PTCfn/tS0dUx5P4pOj4N2ebYy6qyheeGbgNlih6tRfmOcJB2oU9Z+3g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by TY4PR01MB15588.jpnprd01.prod.outlook.com (2603:1096:405:28b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:01:15 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:01:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 2/4] dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
Date: Wed, 28 Jan 2026 17:00:46 +0100
Message-ID: <20260128160048.1445926-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128160048.1445926-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0091.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::10) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|TY4PR01MB15588:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5ddfc3-dae8-401a-7527-08de5e867700
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LhfEzxPP51go7TnIpg2LGa1on+X1so/Za4/aEAviYxAOkGgLOKVFtsZPzAGC?=
 =?us-ascii?Q?UDGGUC0qbIZsKw9hAZ9WTJeYVn2vQiBJDyHOfGKXUJ7IeoDSbZN69raGfMoa?=
 =?us-ascii?Q?QHYpmNbY30g/+kMqnyUX3BHkovvOpL5dD/AZLourcQUOB3u+1AcG6hIT4oUC?=
 =?us-ascii?Q?TXkst9vr0CAmgKnlrqjXO1uyb+6h29ZQYpL07tvKTxVG9ZaT+zQcOc280umA?=
 =?us-ascii?Q?tkjlIrs17Yc0G5O/h07YSPVmUTxXoWH00Av22/P9zSknAHS8sktD0iZxzYJf?=
 =?us-ascii?Q?i5xYgiKdFupaIMmvlDf7OZEZFM2BBvvqRg3p5tNDxBXPyGgLFE8W5rGudPtT?=
 =?us-ascii?Q?fDSwkmaZBf+llAWpUU3bRF4RkA+JY7iQYDpk6g/6u02kXKZXmW/MvZZKh1bs?=
 =?us-ascii?Q?nr373OZkobg8HGTH+nv4wdEKZBdMg8WSVRopZ8oGk/B8fbzZMjNht6sHIbgd?=
 =?us-ascii?Q?HulUxBzj2iX/aeGppJe97DwjNOCoHGzJZj0cIGGhTzj+Wektj591KA0qbdVR?=
 =?us-ascii?Q?+gdLY+BIIiXFWwFpIVrrRgo5PcWG3YDVn/FnmQYCrUbX1n24b5HYk7wIyUYb?=
 =?us-ascii?Q?mCxEJfqJzx38xOkaI5MNl2g80Ym8dB3fZzCZLpA9vEg2z6mIIKOUVm8P4Nq8?=
 =?us-ascii?Q?EGgeZF01z/PubbNgMiyHCLPk40ozl7aukD/W8qjJR8NVeBe6JNtN0f0vVDSB?=
 =?us-ascii?Q?h3ZDEMBVwz4p6Bn6X1eUm16/haxvv3S56SKYE9I9AXPgrkRTtOSjkW8OJPM0?=
 =?us-ascii?Q?g6HPs+ORnoJNrYUxI7rwVypbU7bLKyoC1+t5Qtgjt/wzOyxiM5prSLO7El4/?=
 =?us-ascii?Q?Oju0B57+r+sVy0bvxJ03XsZe1vuXChLFpVsXvI71Z2dVYAD+eQ1b6lbOc1Jj?=
 =?us-ascii?Q?Ht8HwsESI2TqBR4QbI33QOCPksYNC4ukp1Vr806baxtmBgSr4GnMk0IMArmT?=
 =?us-ascii?Q?KnF2y+P7qHIobLbXR9AXm4LMOwRoPAnKpQ1je3wlUauR/K1iiMqs8tkyJW7K?=
 =?us-ascii?Q?f+rzMm1yXSnJIF7raZ0Iz/kQj5TGyH9s/pNqqXZlSJGoI3OfulXj9gyaglBq?=
 =?us-ascii?Q?4F4ef9JksafS1gTT5n3rV4KPd4jIWU+0i6Ik9WKdxpqqDL+58TVrjit8JW6b?=
 =?us-ascii?Q?LA8V3S7lWbjlKc4wEWFo8vXk+6YPJ2n1JytOX6lsvfa4p+nkjYHW19xT7f0Q?=
 =?us-ascii?Q?E+5YLoOUaJ/N+BK735oJvKp/Y9dzdpr/zk6NVLefG/+PFgzl8FR6oyzmFi5m?=
 =?us-ascii?Q?m/k1uVbhC/DcQoKz4d/KKsL7dmHen8yCm1/rQBeqbr7vz5nEX8d44KwfwYVJ?=
 =?us-ascii?Q?gnD7U0AHbHKHbbTz2WM141or9ZKk1s5zL0MPZB2N/y5DAF8mab4flkjzP8d7?=
 =?us-ascii?Q?EdADqA6ie7COAeJVWchISbPGG6hBS1egDIWmdDbbyN6lvibvr5W58bNJHhQ0?=
 =?us-ascii?Q?FSvWl2S4FVZc+7kcBWH3UAFWeOGP1B9l64kKj+tHprHuWhip6bSgXX/861Ea?=
 =?us-ascii?Q?thhr2OGYDGN2Y4QE0Afz0ZhIqjojnBdC55BT/fJw5ZVbhpjsYFeEYeti2cVs?=
 =?us-ascii?Q?nrx7aB+VG/3wlmmDSX1uViuQKKDHmgtsrnAmRjHQTNJkYqFKz19I7Fx9odCJ?=
 =?us-ascii?Q?E5x56XayawZ5NHITMOKuxZw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TCfZA9h3xVzhIBRXOYFYPLhyfufjAr0xDx/wYCvwN4c2vM3Bc4z9eCuME1VM?=
 =?us-ascii?Q?SvGcl7py7fbZ9JZ/GcY5U8OzsE8H0JKux6vUqS+BibBezMG5mbVCsLq3Ijbg?=
 =?us-ascii?Q?4qamHg6dLOTbPgmzq5aTIXMt8jQgr2kKzZ+Ry1dvk+WSfaHmGMgphbJIENq1?=
 =?us-ascii?Q?XYfD6iYkHBUCk4g+uQs4OABNVNFmc+8mfHUlrljStVHK4qQ41TE5lOG9WgA4?=
 =?us-ascii?Q?yva9+U37Sc1Z0/jnv7XIBw016vKTVnRyXc59iMH2f/t8miwIFItDXKDrZVfg?=
 =?us-ascii?Q?cXiaYNyU8lUSvkaDR1Rdsjc1i8xcAWzviKqfNty2LI9UIMaVSKfSlfROR4FX?=
 =?us-ascii?Q?tGMmS2pVvwJDdIbfTs4WeCqBOrsCh8tyOsH3tbV3Q78iZDk1oJu6TCgVVv49?=
 =?us-ascii?Q?5mEL3d4IoVIIVrLJLULVL67I9EErXUFjPtVc2wQfEdhzWsFmEx7hwi3KUL3G?=
 =?us-ascii?Q?jPJ8pEFJI0+AgR2Y4OcgEqSQka0bUEp83rXCfoO1iaZ/FyriouVAxg4C633R?=
 =?us-ascii?Q?CEe23WjYKsaFWHN0omj4/cKDKP+PEns0KEyMlRIaTgGd2Z1nNusIDjLhT9mb?=
 =?us-ascii?Q?oonLcDj7Y59QDxHi5FYujThHSg2DraILlj/JwwN26FpvqUE0hnjA7m7yIRxw?=
 =?us-ascii?Q?lpo7hCt8V14sqNh3SbT2ReQJCmNESBFMtiRG9fYW7CmSTAuCJrcGTO52TA9R?=
 =?us-ascii?Q?plaV32hIPFaWhm8BVdFrbvOZjxS8Ur+/w5s2zBtWYXNfKtviC+qZL9fxQZeE?=
 =?us-ascii?Q?fL1U4YnHrJSrB8UHLE7CxOmvw+bVuj1NkuZe32b11+1uP7XCVO/cJwzfZFhn?=
 =?us-ascii?Q?Ol0b/ZWQMd5T58FUkybg576ESxUHzObGvxBsn4K73dBjbXYuGSrYzvsBfM8D?=
 =?us-ascii?Q?U+393b8qbltXj+v4OMRiRSbtVfZD+5PERYodIiLbRQtd8t7fjDTDWNxbjuNM?=
 =?us-ascii?Q?UCl8OqW91CQLMWJu2LyJUt0R81uCATCyXUQDPUK23hh9n8vcdRfgyGIAZCDN?=
 =?us-ascii?Q?ud7lkk1uEutIKtz+psQVpzlwFUICwx6ug+SpM/xkmubDHk7AlwSwkhz7yPgS?=
 =?us-ascii?Q?YvZXoYmj8N4XIp10L81Qc/z4B7arwfXMjhR7WsHNwAtf3uxF6rV/0qdmg7Ry?=
 =?us-ascii?Q?XUFlxli2bNJKdn6WIQpRUV71WxStCMzfLXJ1++1z5o5Zul3Dc+v6m+eWLrxx?=
 =?us-ascii?Q?BbsZ9mozLT9CBlVjrkTJUyekrkSgips0lORH66QljB7vDZocdd1PQEuhsxhv?=
 =?us-ascii?Q?6K/n4brvdQYOEFoOWWSjGQsu27VydGZXgHdxMeIuwTQ7RqEZcTGn0Y/7rXJO?=
 =?us-ascii?Q?AHb29VIGjkA9POuadyTyzt3pWtfJ6IjtsvHQQX5UcxFVJkKVSF4UIQbsNE5D?=
 =?us-ascii?Q?2hmLQncDIOZyti5zbBDT69cSK6x20m9CCT//+UhuSFZ03dI0xXsX0TGDCv3m?=
 =?us-ascii?Q?GBz8CTkGkIfu5j08Ahy4mZW9mbmE+HNTBhtnWBznp3hM27m97jOoDE7g0I/W?=
 =?us-ascii?Q?Gs9HPkvFu2aWwyp33SnEWs2WUJrDQ4LW9fnT7Ui7JiGw3ijmlRUpOjmovx4D?=
 =?us-ascii?Q?UKOgVhqobE2Tvd9Zd6xStVDOdydhXJYMfmlEw5p6GWFgwn7wrIfZdr9oadZH?=
 =?us-ascii?Q?0BiTqJXb3H1NltiaL5EfDHs9V5jw4JaiKtvD9ngu/oUysPKoRHue7uvvcZUa?=
 =?us-ascii?Q?5ZSpQs5+7mHMPSEYLmabE+CDuUDyI+3yjtTt0WyRFHMM9Mks0MXEHsXIvVBN?=
 =?us-ascii?Q?7fNxBCnm1/LStAVwppiwuBg/yhIhPUjaAozDbOGBwOovUaTYCh6D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5ddfc3-dae8-401a-7527-08de5e867700
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:01:14.9109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q6Gdx7G8GqaKJlPpXA6R2nNXb4Qcg9Nug5EmAqZmlC7q39q9jtsWp0LmnvYE3WoaiMWyVT0UG+SXHNbYkRRvXBSnGQ0R4iK/Bl+DVl2q5knThsYYrHlsEKQreOHyydbm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15588
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:01:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21775

commit cc0bacac6de7763a038550cf43cb94634d8be9cd upstream.

The DMAC block on the RZ/G3E SoC is identical to the one found on the
RZ/V2H(P) SoC.

No driver changes are required, as `renesas,r9a09g057-dmac` will be used
as a fallback compatible string on the RZ/G3E SoC.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250801084825.471011-3-tommaso.merciai.xr@=
bp.renesas.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml b/D=
ocumentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
index 52c247dc5fde..a43b6f29a688 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml
@@ -20,6 +20,11 @@ properties:
               - renesas,r9a08g045-dmac # RZ/G3S
           - const: renesas,rz-dmac
=20
+      - items:
+          - enum:
+              - renesas,r9a09g047-dmac # RZ/G3E
+          - const: renesas,r9a09g057-dmac
+
       - const: renesas,r9a09g057-dmac # RZ/V2H(P)
=20
   reg:
--=20
2.43.0


