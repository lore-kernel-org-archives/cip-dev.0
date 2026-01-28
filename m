Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E4DD3F081
	for <webhook@archiver.kernel.org>; Wed, 28 Jan 2026 16:00:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.720.1769616014445519675
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Jan 2026 08:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=NX7hPQEE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ws7XvzcavSBj+6/R8NBE7R312qU7LhmulL6rOo9nXfjHbpFTQSr/wAlNdP+5hs5j1mv9qEyaeD4hyEdaCVbQMyDYzfMypnzAE8j+gAjClF+39MnYxGFFobzcMyA8Nu8fch7991d4vW+uwCSXY1bJi7qIfVFQmB4wAZyu3xOVCgvn5jh1Z3gt5Qidt/bm3K2ayhanDIENPQtTJqq8fbV/s1IBmCHusmuHZRS+K3WN1h1SwUGTxiZ3TqCNHxBWKuyW/15j6Bia+avhc7f4E5wCRXrWHT8oDsYkE7nBOKSDlag02KrHf/kuWuLR0p29P5ToQacwR3sisf8ftM58ow+6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOZFzPufQWBRgQ0eKlAN9jpZN41avMooeSlAMcBbB/w=;
 b=GKNacY45J8uQjgu7NJl+tLQ9zAfon+fOI0Q46C1Ya2bDF8m9xBlxEPGK9X4OCVQuET6AhGWEIOWyAB58z58/eWkVBoJUVWXNJ71I8gFH6xgSj1aeoP116EyTZEnPz7d/c2QCRPKae5eoE5fX1dw6yT6a1WIftGDgkW4Xk9kV8p/zh7DY2FzGWpNg7QiXIpFSvivlsgu0+D/IxVVhFvBGirGqrw3/JjjBQMELaFsg0qMmPA+ge835Eadsj3du0jnONRS6KvEJr8J+qFF43li41UeFy6/4SzdF3Xbz24ftLeVSpoXGT/ERHI0h56CsRIFzFW6YHVhw3QVo53NgmURLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOZFzPufQWBRgQ0eKlAN9jpZN41avMooeSlAMcBbB/w=;
 b=NX7hPQEEwLVqPBIPWP7hQEegVIt+e1umboaIDHru2jWwWfeN6z12UsG4YD2L6ExALmjQDuJywCBLql8QQGVVitQOpLCUCYUlfsmx7H/cB35gNF5oBlpDfE2YRLLW1BKnU+ksAZgmzlEdOE1db2Cxwcuh5X+Rrho1vIvx+NQmEg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com (2603:1096:400:409::5)
 by OS9PR01MB12487.jpnprd01.prod.outlook.com (2603:1096:604:2f7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 16:00:12 +0000
Received: from TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495]) by TY3PR01MB11948.jpnprd01.prod.outlook.com
 ([fe80::b718:17d0:6c0f:1495%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:00:12 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 2/4] dt-bindings: dma: rz-dmac: Document RZ/G3E family of SoCs
Date: Wed, 28 Jan 2026 16:59:38 +0100
Message-ID: <20260128155940.1445842-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260128155940.1445842-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::15) To TY3PR01MB11948.jpnprd01.prod.outlook.com
 (2603:1096:400:409::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11948:EE_|OS9PR01MB12487:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1c3456-a799-46a6-7b5b-08de5e865177
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VRGYBOuh/1U6snn7l6DgqyC6RjMzBtcELve4mKvLQQybkgZgLHO9/PhPmBq9?=
 =?us-ascii?Q?F1jqrIVQVAHkoxJmd4ec/LErZww/SVAV58uU3B6ABPQLys/+8rPnGTLhdM8l?=
 =?us-ascii?Q?o7DcYMsXqqVWx2S+saS6kZh7HhGII78VXizStHgG//quMCf3q8VvDv6uqjZL?=
 =?us-ascii?Q?FEMReLEO5cScf9IrUO0yWIyZpN2pRaGhCXfnt7fByO2rE60lhSjjBEJqbgLc?=
 =?us-ascii?Q?Lb5SkfooSaWEO0eyM64SWVY+3ENvVjOsrAX0ei7jK/tTuCbJSuaYkP4POAXt?=
 =?us-ascii?Q?CiIBCqU/HL12QJrD/1t+coAzJJvM1kL8nJ7QMzIS+iQ+llUcLNfLTvfpkCkV?=
 =?us-ascii?Q?mgrXXVA61jcbbk104Cml63lncExkdTnRlCwD736gDFAAmAEFzbIGYUZ1xv5T?=
 =?us-ascii?Q?g/guXlyW6CNNcOYhpnEknBSeJ4ggtZxk8/25w/zE87p+D6BJRgZjtgYebWQi?=
 =?us-ascii?Q?hQVGoiA9riFDyntD+0Ht/MRe9ESBUGVUjiLdIBEFRpre+rQnkZRCY0PK6Vv4?=
 =?us-ascii?Q?AVfCkw1EUfUnu3WFK/KDf+s9dR9uGhrNj3jyITBAwFmbxE5KeXMSu0hM+qnu?=
 =?us-ascii?Q?yN+N2iIIsg9b/j9FxadsQS8Vak0Rf45aDFPzL8oMfBdj0UHGlDNUvNvm6PiD?=
 =?us-ascii?Q?oxI2ILUhfFPsy1kDy5IHMy7nzE3bmwdurXuvAY1s+cLHPebrtxn1VmfRUxkp?=
 =?us-ascii?Q?mQ1vvUscy45UMKk6457v43ASiAUZi9B3dN9ggDJ/cnCYJRiEQWNgo/he7XQ9?=
 =?us-ascii?Q?W22ZiwfPoH9iul+2DGEMkyiH7DkReoClSaiNME/u9dkSK467ceonjbeKUKwT?=
 =?us-ascii?Q?LPclZpXyvvWCK/oAzjFtQUkuN/xhm7UevWW3MO5i4ShCP0zBXGbNkikSu/tn?=
 =?us-ascii?Q?VN1+WX6RTmTys6DVqrLxzVMq/dO06YvIgt3H47xfo1uxOahU0fRQIJeuG9N9?=
 =?us-ascii?Q?vUsc0APFccoYnH1AUQ9ryDCxDcS6Ob91cTA8fXfG7GdNcb+aVrCifTD2PJz5?=
 =?us-ascii?Q?XYOpDJMbxT1HWgvQvy3Imx8KKKrVUqV1EOx70bYqSiuf/rmXgvtIUdvGy7CZ?=
 =?us-ascii?Q?jx16RG1XnG8vGNieq87Ug6G3iYHV/joJiNvqGRCT4t2eDuVdAv6HMpa2FD1m?=
 =?us-ascii?Q?cARjk5rEiw/xmk8/BMNlYnM8ymf7uf8k5jD6bFbmGDaZCpuUS/NM3DHyYPM0?=
 =?us-ascii?Q?5APP4D+myUDHFPs3HQawRBdwwVT6WGHYFp1kk94QrppPUzQyIosQE1kiie/n?=
 =?us-ascii?Q?47U2NHpXcwH6IrEsz97czAfOa1HcHNNNngfCvFKHw1+tAkyzart58wYaHOEa?=
 =?us-ascii?Q?6fpUdlLeGzqgBZ+pb2rOiHpbbw+DsCFZ9M/p7O9CXPdlEhvWrxjytUSptZP9?=
 =?us-ascii?Q?/b/NQAfQmNvTMqPfLqmyFb9fJDLD8ttMH+tcCFf1Sxab8u5BPN2urEh8Gkj0?=
 =?us-ascii?Q?pnMwT2fPSbNvKmY+tt+wyYTBxzFe7dfcsnCO1FGf4CqscBCGrNp7vQyVhF3b?=
 =?us-ascii?Q?3IGIKe/jcoUqfHhLslOvD0V7YJSCSMUNh94O5yqT2IrxmxfrQDxR7j4Ze7VA?=
 =?us-ascii?Q?Uo3RIwTFZF/3W3vz2xunkrFLOzbXkSqAef6u4qgRQ7E1qmqBMmmiO7INpz3R?=
 =?us-ascii?Q?1pZUWyp1prmSPTCLTKObj9Y=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11948.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vpcglAA1NeuzLqw7jdMkxfkBTbAg7Ybdbn3hhE0vYl2RSN4knri2Tx3Ffq+m?=
 =?us-ascii?Q?BVgRwCQ/MkzX9YT5LmQhNGM6u3iWYJQabtRcO+gM8ELYsqxCY2fXRS9CLh8a?=
 =?us-ascii?Q?9wW78mkYpk0OOot2YKZNvYcZ0fC83aWqVfqzDzbZFi2NtAbptXmEPqjW53V1?=
 =?us-ascii?Q?bARNNOe1HsWL4uBUVFPtzRdmZJur74XIaX3w4e2fHvzInUAqkURZn1Vsn1Tx?=
 =?us-ascii?Q?wr7xgHj4y25jgkXgLX6L4Z+svqP8jgQFT106g8/Hd+jwv2mjrYzPEuc6DHzj?=
 =?us-ascii?Q?LGLFbRSrRPFdIR0xh1CKCK56GI3xq4iSEPCD5RZik5omwueXclZS2cnVmH9W?=
 =?us-ascii?Q?ZXFDnY2kFzNE+H8LKZDnXO5rk6KCYDB1/cYTwRfUTUQ3VKULgGDD7vcfgWoV?=
 =?us-ascii?Q?TkF31kLQ8U7FgkUMHwmORfQquH9FTqBAM963ILp0KNoboNIvnRN5/gYaSl6X?=
 =?us-ascii?Q?1kqmTNgHCh4s8nSAttgoQxD36pK3ds+ezRdCiFjjCQ76fXQs38h9Yx2ni5WF?=
 =?us-ascii?Q?3xr8T4C0yEXiIFZtuTrxwLKQw7qzAwbT8RDOT6Juvvmioupr9rt2eup8HD1k?=
 =?us-ascii?Q?twLEl4dA+Q3j8EbevGm9xqBhLOpEw0ZgFUM0RWCn8f11R4XYc/rAJF9P/oP+?=
 =?us-ascii?Q?i3GeUtKic6T6QJAriQLHMuVQ46SnLyUhsWJbWXGut2s+vynuYu5l1n9+x+2C?=
 =?us-ascii?Q?TaWBSgH3P4QwZQr508mGKjoEWNQiamf+jVSdvE7Cid56LafcKOXc2di12/JN?=
 =?us-ascii?Q?b80yA95ttQOznjzhibPGZiieCnZ8NmXPUkp2KornZWz5/fd1RZ+11sQxdkCZ?=
 =?us-ascii?Q?jaSV3H7Edenoiwd7HrRp6gLXeI2HQquf/zMYqyUi/P7fxOJAukxIUnvDSNNb?=
 =?us-ascii?Q?OjIH2u+HDW6k5Xz9EvLyhaEtsdLeGfOBvND0mvXBIF8qZap5O/0pr+Kg3BgK?=
 =?us-ascii?Q?+bnM1KQBdu3xchtzQneEydGrVO8VPV493SU2GgxqOrpflkXg4bzkroouiCkB?=
 =?us-ascii?Q?gatHfnDQQK4i/ihNHoTAJZ7wH+n2CBn0XUzdbJ/YFrh7c3xSGqL48nogZYP9?=
 =?us-ascii?Q?haUZL33AnQxmOZ66BkRsoUMeUPEq8dmy10Zp3MAiLpw+49mp381b396rczne?=
 =?us-ascii?Q?jFCWFbi3dL0IU8b2deerLxnlDMgR2nhGEfOQo1A5bguFgc943LD0u0K44Yrg?=
 =?us-ascii?Q?c0MSKjWsbWOqLdG7auP4mLEQpYsVvL7gg6AZneQt3ErzWM01fNsFSNHTaT8n?=
 =?us-ascii?Q?mzY17JuPBXMciwDsENR2yS1qXrDg38VDEFAy0nunWY9fw6QsoRyrcyrA6Aja?=
 =?us-ascii?Q?LMAfUP29m1fyEP8lETTI660U6TB6MPsOnbFLINXKAlseJyjhXuVCD5/+8fmx?=
 =?us-ascii?Q?co0m9V5ur+3Luz7otn/fqASiZ0FdoL9PU2ATG57oSC/mHCNgZ0ywH8EAWYAR?=
 =?us-ascii?Q?dsEUwKDa6EAeEsj7YZk4W3MHJbKMcoyff/KPEBgMvB0yeHUYUaUqYz8LifS6?=
 =?us-ascii?Q?Zti9OJ0HdisSedGkejsUzUF02OlFkr9aX0TJWZ9ENR22bQ6yXMSU25Dg+AsA?=
 =?us-ascii?Q?Xo8IefFWt8/tx8dMG33kd6PJP4YGsiCYg/E0+HzbiRHOA1YRH5reJw3uP9fn?=
 =?us-ascii?Q?R6pWOrtTnL331cRrH3DyjiZB5KLgxctsGukdSAZOEVfuwRK2XvPLX/KmU58e?=
 =?us-ascii?Q?RVWvlMYztvCSPOiGIcwMXsaK7MQ0v3jSzaAwNSJ9B0yB8VUP4M0Gq/UxGHe9?=
 =?us-ascii?Q?55+eMkILlSi0VGxv3zzF/7O0y+z0x4J8SYUpJcbVDC9vhIpp8Xe0?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1c3456-a799-46a6-7b5b-08de5e865177
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11948.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:00:11.9286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rkNQveDlpkDtdaKTYNnskry7zn4QP2Kb3WgLrXhCilbPOEP8U5wWod8AXw/Su5ceNVHz/b6NlZHrncV4G/P0KFivN+ElmLhkf/ngZTqZCUg5OSKWKudfq+dUGugCXHBB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12487
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Jan 2026 16:00:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21770

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


