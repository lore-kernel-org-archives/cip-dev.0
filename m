Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A991ACD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:33 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6975.1778751628130284255
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ay/DSzut;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.1, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSWOAJvkUy/sD0WAbiTpDLly9eLKuZ8HNQJhxjWTBDqAHhC1PO62vJKDhijc1NvxUpSdNgK5Sr9JhhekzALkGk5qmTPQMhhunbzxJJYb5A8bTfG2ZcfS2ySg474OEXEIL/amuxY76qovZIhC1PhdKXuB/6YB+PFijlxqJ6poOQYM+Ns/EzudDCSXdp6zCbTI4M0ziJYWgkQsZCsTUOfqub82uUSEM1YIabkHFfM+E4suet72g7sgklw3+zG2wWJT/XE+FDRGXV7tgXDaiiOdvvIufzuEd55RP5Lt77HIEjCKkgCV+YEAeh5tX++ZlBIpDczEhwEna9tf3RnhN2E0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMMcHuf3NgM5fyE6T1aha2zPrMj4ZbGr+TbU7+QSwoo=;
 b=YbzdLbiqz8K10MnVdA7NhQFs09fsOdPK4BsvpWbj3MI2eXyzg3OHCHoz07HzfZxAjQ1+ww2DKdpyRWBCCCdWcKpMCf36CV5qqmkolSBmS5iO9FZBMJSAKCVmVKM9+s4efXoXKWnFF/9/UpZ1AsNInOu0K84Y5Gv2kwG2RlbANyFlTvPtxzn5UR6EWBKx5xdlU8FdRYf8llE+u3xT71uPKRAB3fzMiKS0AoF7JJ9nvcedqB5+IpAJcLfErpV17kRWQfevTjYaCQnEsLMLc3toulNEbecbKsPbEcDiC0q/X1qXzETK6KfP73HG+RMha6KjQT/RBrC1vQ14o47v6KFPGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMMcHuf3NgM5fyE6T1aha2zPrMj4ZbGr+TbU7+QSwoo=;
 b=ay/DSzut4lP4WBkIIb/EQSXUA51R/nDFiZEyWJ5IkkK26ZFC1k8pk28Ysg9L07w0fRJM+pemPRtO/li37KAWntmJX9BIg59kjp2f0b74/Luk+mAWQX8rVyehbZSeB3bUG9l2Thn/Px2q0x6aQDK+8uJaRrxN4/cy6UFmhyXhDR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:24 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:24 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 07/17] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
Date: Thu, 14 May 2026 09:39:25 +0000
Message-ID: <20260514093935.2212718-8-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: b816cf76-7411-4bdf-cafd-08deb19cd2c0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	H2RvS24SXj0aVgBwBVtXaAX8XfPRGVCvlXmgLt/z1kS9XHFX/BaQZPHolvtvbNXamlX85CLkPxWBETHz6jt7ga3am7Bqo7Un66aSxw+es0sSXanTZmKanU8NrmtHNz37p3dQ3f44q++d7MKq4Is8WyYwEf5Yqs0kdwgmnl9kTTlAozEqRcdVtQ+v2sU/FbNgpuDRdE7gjK03zJBpaMI/dzfL4E49Z5SWjTr0f+zQYPTcIMx8fKb6imxO1xSlLoLcUG64KkfyzCcfuVj9hSyewFB36S1FDwNSrPDGNVs2H6k0A6GKrosQMGuL0Vzr+iL6OX3hJVDCtVVVZrlvsV1PH5htUH0aq4ZrxJIanOu0iAgT36qjvx0dN/KsYVoZOllMk3EbJPQRisa4zhl0Y3PyqM4cxk7S3UpuJmlHH2nUPrNrGC3RF8kwKo7F0tD1Z2lnUdAMs/LKzRNNuLoDZ+Izxb8jUGjB9TAVno5/dOWpMvVxwZc+Sc/AE4wbYLdA3ovD3KnAcLi8JUkKTVA8T9snqyI7vdUDUX1L6GoVSAOkIhgpULSK3qUIHXnAN9W+Hcp8b+zI2YejM3FeHd4/toLC3WZf7nu6bOII1RsWIYqEsPA7XAYx/qxHxAJyJ/NXXSDpOupw65Q3C0jkxObIz9xKjDhmE+ilEPgI8WX2GzTZyFtHB7r10sTldk85IVtncsNzd2N4+F4JBcfYIJAQLwwbGQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Lm2Ap9b3m63rzVKhCXG+2ARPP0402uSV6pFSX0Ts9LyDlXCmTECyQ/3EEfyw?=
 =?us-ascii?Q?44F5zm/eqW8g4XtY2uZETChNHrkxCpN0QwylGl2RKbUwrFe3gzmF/Y1dw/Vc?=
 =?us-ascii?Q?eJiej09LRZtGLlab3296H5Mnk4FWBQ9ugTcKDvFSizUxiSEcE5O8nXxAcHwd?=
 =?us-ascii?Q?S4Ik8WSTJ3uX2SK+ocbn/iW/kDlxQlH18BOxrxjy5jfY/dvoZpMY+ng095B/?=
 =?us-ascii?Q?SaJ8OaV0mO4YMtGQcDdy5B/YoQ6qFEjNoOIVVU7BqGBlFFgekkWv73vNDZCF?=
 =?us-ascii?Q?5CWzqx12TgKFe19x6Qe1BUJbXdqbri5xa170hPFmffDswqauXHd4LMMdCYpa?=
 =?us-ascii?Q?8px7JYn5J4trTuiAm3qXJAjoG5Li/LE2c/jHuOCdBPvlE/qvkDx/6ubrtUdx?=
 =?us-ascii?Q?aO1TmWI6fD/hI6ukFnPeP060I5Lnuvk0VyGZpuDzyNGVSAG0bNaLd8e+ZYdp?=
 =?us-ascii?Q?wRIVNayLwgOwoF4MOP2kZAkyYEMGqO+gj3yzlfLO8VoxDGI2I9IgLyLrjN52?=
 =?us-ascii?Q?+rVQc1ttcvK96uaqafblPD3c+xo+bj+mbTTDYSCpogyU55oHMEG4xD/MhwLw?=
 =?us-ascii?Q?V5AxHZg98dnO3p43+7r5ZP1hSs9CGMtKmM99g2B0Go0BXQlLNQKRH51Ky6eq?=
 =?us-ascii?Q?XpbQZdgM2h3unR6hPtAFCQJbRFWmYxOs+CwUMe3I8jnB1xEkd3IrUAPdOS6m?=
 =?us-ascii?Q?1I+RSm20e/+Jt2wUbfbC1M+7l8tr8ZYnaXzQyjtK2ELDLFs0jGNd8jtQ/joX?=
 =?us-ascii?Q?xrh6pLHzf+jNHg3xIgowGUOUmp2U3BZVoLjGzUu7nt6JhRARD0XWk/VBBPBI?=
 =?us-ascii?Q?B/XjFJAR9mv35k6Nrn4MULRLDOzWGu/lDFVm0X4kyxxD6Mmp3Qk1UmeEJi9K?=
 =?us-ascii?Q?cxTX5UY2Nyz7AskH5aNaSOqJ83/jHtvFeqGjrDe4qeCP43F4dWNF2jGq7xbW?=
 =?us-ascii?Q?guKgj2ZR2dDjWxoF13ipjbA9Je77EqrDIFq9z1i5eNDyazeS4IDxHICFOL7V?=
 =?us-ascii?Q?85U3nmxc0X+SIIN5mo3Oer5cz3cntf4CkfRvyR0ef/xCPUofchy3Gh1Q0UJt?=
 =?us-ascii?Q?n9MGsltCe4++ANNVeIoSjGNlPBQ9arGpTYnIWWBmNluT2Dr8+o6OzsbH7FOH?=
 =?us-ascii?Q?BpYY7YOoIskdj2BIImzVGIpqyyW05TVOwDi6zONcEEK+jGyydZbQaBSlyBqJ?=
 =?us-ascii?Q?PY+tSXH+JxTvUffc3CPv8qSeROD20Kfetmdqpym2PtedIJ2mOr1WgGa6MX9q?=
 =?us-ascii?Q?qWTxxdfmEGNukFqPgmiRyGaaszSnIr2zmycQEzNlJsyjQoZN//enOj3qWMqB?=
 =?us-ascii?Q?fesDnwEgFVynnuJYa2l/ZxU1aTrLNPTX+bi1KnhPvPduh9GXzstDnIRwUzhB?=
 =?us-ascii?Q?/x5/IUmrnLEf0Ay5zLSWQhTI5Xw4eiVBVjlE5tPOGqN2nfy8YHw5NxSnLvXM?=
 =?us-ascii?Q?CI37WkwQIsdWi1axTuWIyyQiijkFcEEM8UdJj0nbpCDi+bmwYDWazoiobqdb?=
 =?us-ascii?Q?t8o6AkskIY2OBbk8iwP9Xv2qEY/iO8WduW/gMAvBCr6rMS6vQvrnbw9avK52?=
 =?us-ascii?Q?1px+Z1YLfkNJ8KN7gnxEwS7OIMzzSHhuONGh8V5GXpPLIY5xN5+aCW5hQSqB?=
 =?us-ascii?Q?LcUMRJRHg/ZnhKx01NrhPndjDiTD+I0rm4Oo6HANOSVmenOISS8csKOVwzzB?=
 =?us-ascii?Q?mwZa2xMMrVvyFE7zoV5rBNZdOGIOxNLpHUxJ08cxzd3Pn9idT+PuTaQgIMiZ?=
 =?us-ascii?Q?lyh//bnwr+/QiHqBBT8www5ptcZ5dB8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b816cf76-7411-4bdf-cafd-08deb19cd2c0
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:24.5769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ruTmI3EhItPDo9jGPlH7KpgSmwTMOkMxG2ZeDZTAGr9yKy1YM6GzcUdmBW1/+qhaocIE5bSYICOMBVN9SOntIo7BOuOYOzoijsqPTFbceH0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22941

[ Upstream commit bb1b0f47f6822864c1689f46348efa42c5d4074c ]

Fix a typo in interrupt-names: "ser_cor" should be "serr_cor" (System
Error Correctable).

Also convert interrupt-names, clock-names, and reset-names properties
from "description" to "const" to enable proper validation with
dtbs_check.

Fixes: e7534e790557 ("dt-bindings: PCI: Add Renesas RZ/G3S PCIe controller =
binding")
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20260306143423.19562-6-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 50 +++++++++----------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.y=
aml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
index d668782546a2..d1eb92995e2c 100644
--- a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -41,22 +41,22 @@ properties:
=20
   interrupt-names:
     items:
-      - description: serr
-      - description: ser_cor
-      - description: serr_nonfatal
-      - description: serr_fatal
-      - description: axi_err
-      - description: inta
-      - description: intb
-      - description: intc
-      - description: intd
-      - description: msi
-      - description: link_bandwidth
-      - description: pm_pme
-      - description: dma
-      - description: pcie_evt
-      - description: msg
-      - description: all
+      - const: serr
+      - const: serr_cor
+      - const: serr_nonfatal
+      - const: serr_fatal
+      - const: axi_err
+      - const: inta
+      - const: intb
+      - const: intc
+      - const: intd
+      - const: msi
+      - const: link_bandwidth
+      - const: pm_pme
+      - const: dma
+      - const: pcie_evt
+      - const: msg
+      - const: all
=20
   interrupt-controller: true
=20
@@ -67,8 +67,8 @@ properties:
=20
   clock-names:
     items:
-      - description: aclk
-      - description: pm
+      - const: aclk
+      - const: pm
=20
   resets:
     items:
@@ -82,13 +82,13 @@ properties:
=20
   reset-names:
     items:
-      - description: aresetn
-      - description: rst_b
-      - description: rst_gp_b
-      - description: rst_ps_b
-      - description: rst_rsm_b
-      - description: rst_cfg_b
-      - description: rst_load_b
+      - const: aresetn
+      - const: rst_b
+      - const: rst_gp_b
+      - const: rst_ps_b
+      - const: rst_rsm_b
+      - const: rst_cfg_b
+      - const: rst_load_b
=20
   power-domains:
     maxItems: 1
--=20
2.25.1


