Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875A4CD4851
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:42:54 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.39])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7022.1778751764436126277
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:42:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LraGywpK;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.39, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kjq5pL5QUXI7qgFpD5gl9pSoT/RmBl7A9W8/kegC+MTGAC9EFKB5Z9s6gm5oYuO/hH1lK293ojGqY9UsQp0EQyNn/MuO7Y69w0JsZ25hncfIOqZ6JwuWsoa5B6PyMBaEHVw5uzR3bhrDZyttXiJMfhBk2kKX7PR8yaRHnWPqbcijRsyqRABX88CDeea9tnh9fYe7R1p+CuC9PbdJrKFU9qAOcS8+zRq4W9+9P9SF7Z0YXI3ZhyNJjiFM/t19201BWoF6CW3xvE6geT9CcVs1CN+1buPeClSQEIMmX2Y7qRBhczvM7jObt8kVYMur+lJJ2fqX6qT7leWm9zRujbkEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMMcHuf3NgM5fyE6T1aha2zPrMj4ZbGr+TbU7+QSwoo=;
 b=D9XUlriUHTuTJAHAOudZPYgn2iX55E+1qy7Dkfv4nyt8NBMivlipuWgrDXOOFwDPcnAWBFi0pnogyX3s7N9n+5G21yNMGuQCExWzFpJh2U1AxKjIm/yamjiwa75VHr9nMNblLS+Pp20Cn3PnWZw1rr7fdchctatyC5UmmN1oiQbDH2skz1QJaTRYpfbhizMnSMwMT7wNufXdO7F8KL0QANioK0D/vcJaBz65xJxyE8sXqaz1WEomuwNBr09M+pJIQmagTduOrn7D6Tpg1IkK/0NRen9/cqXiRLF4Uz+bNkQBXF1LdBfikMSgWwjFu6dp8jxjiaQq8tmgVWgVHxdPcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMMcHuf3NgM5fyE6T1aha2zPrMj4ZbGr+TbU7+QSwoo=;
 b=LraGywpKCb1bWaroX0PJ4B6/ZuRsW4D0heGEf1Fiv4Eoi/YtXPBUlbESxS3kL0a4DNYVxmTu7l2HLdMU9Bbe56J1HgJ9S6bCjLOGWb/I4mRRsgqRsMKnT6n9j4EPRCV+Mbvk8Hro3TvZ3E34D72ls2Ng/rBlYbWWSemj8wEv8GY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TY4PR01MB13906.jpnprd01.prod.outlook.com (2603:1096:405:1fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:42:41 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:42:41 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.1.y-cip 07/17] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Fix naming properties
Date: Thu, 14 May 2026 09:41:42 +0000
Message-ID: <20260514094152.2215176-8-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
References: <20260514094152.2215176-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19f::12) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TY4PR01MB13906:EE_
X-MS-Office365-Filtering-Correlation-Id: 082f790f-0bd6-421d-d824-08deb19d2490
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|11063799003|18002099003|56012099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: 
	oHqlT50CG4Qslu4TiocTSMrmb6kBaE7K0JqB3WqoYMOtIXta/2mhH5JRKFNFx1oD8loPCZStu2PIBRMk+38EEFkg8t92YmaTF32ICVbhbpmDKkW5yAiu3aGjZ+3kXleHQzi1XicUtJSvnkrWhk4Dx+fwKAlDKsD/MHft6tpb+bS21QfSfrNSy0oF+/aLVyuiwx+5ca+RI2/ylEfyEtgNal3+1K6FkByb2nXkIj9M1nj8VFrEGq/Dn57SLMhRKZXaf/jjU8EMCwfKbF5aaLS0QIVkoPRAzDJmrXKRW4T14Ochy3+VwjObo5Cf9xwdqYr+Y2en6UBU7N2kbSGZIJCOzGOrt7RPIdB5IwoPrlRA4FHgs4fXYsjyKO1DU9qsXDos/fd5AU38yN2ftQNT/9AfpUzGkBiDoSPeqvTD5pMIvyLqnkBbQ4XNYC0nl0uvvlIQepjE9d1ArnUl60GHts76K1zLdn3EMW0wo0iDxOG5iyCeGbzdx1YPlwALmGvJL38u0IiccpZWBH7DDyD0G1TztyKG4ec+qsw1C0qSL1KDRZogXO4hjJp/eGJJRyG8Fb9ESap4ZWEYmW4ZNbs/uGsa6BFOIjI0/f7oohuo/IcQ0M7M8BnARxDi4AJ8AQ1M/93ST0ANJx7TsstGnXmVetqRxvAh1Xg0gQdQh3zg2hCW/h+fB9T5ys1jaNV3PZ5A76nCr9I1ZV2dEnI99WXmD0lnwA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(11063799003)(18002099003)(56012099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+rFQQNv2sktqLS4DYKl6EFGUM70+Bf7OxGZ4MLKAuQEewJ9xGlqwJOcP/Q76?=
 =?us-ascii?Q?9rzmHuHVv39qwHN30SoMon/Ux4cGZ0mx4YPLO1x16jKsw6KZQKMmywz6jvzG?=
 =?us-ascii?Q?BhXAHa2iBWoUIONA703UiOf7ZBPZrZ8H6qN7uOPByMmLkoiiW+oXPdpE14gf?=
 =?us-ascii?Q?sy3rWjc7cXrVza6ZrN6r5j41FGAyxfEz4uhp650Ry8QsE/bGgfQPKbgm9kW9?=
 =?us-ascii?Q?4OEjK72YUDYeB9y2/LnBh9ytrxj0PgQ9oSp84adSNfiRyId6cfXGMBT1vxoM?=
 =?us-ascii?Q?mCRqL3pMSGwvUysHum0kIsXocYoh3vSr+b0waq0OJ5nY9uMlWhEf/RC+DpMV?=
 =?us-ascii?Q?DbAmqKGsGgVaO/i0ByVFSQP+FhSDiMYxAPhlDeTKviPLFIqM/TI3yuwivdaT?=
 =?us-ascii?Q?WDxzhIDlWtwKQqoe74GYRPGw01qArPq0XsD9ZoA+iOkKipqGEXxTj2YsWndA?=
 =?us-ascii?Q?vuHGV1Is4wjMj0fQhB6X0hGfnHjVfFvoYPDuanYT/x8EDVvC/E1HF1Nx9Y41?=
 =?us-ascii?Q?HJqPijWVROrw4XO2FrewJaDi44knOcGH4ugeQEkmjE6+sJhsWsKC4mn6naoO?=
 =?us-ascii?Q?FX8cDbF/qvG+6grtuRlyaoiCU5L9Rq1N5tLQ8CSBzwPTvNU4ANEh8HV1zQAZ?=
 =?us-ascii?Q?1o7+Exmoa7XTqQ891c20t7wuzf2hPR6DENzBaVQ73HP4rqyQwpFVvB/K2ICW?=
 =?us-ascii?Q?ROScia6jkEx6DESKecc+vuAsGjpkX2n/+adYI6nGYdipDJq6fot2GCY1dASB?=
 =?us-ascii?Q?qvYn5/4ELr4kA/PKTO89q47y8geTxU0wMTHxVnYQVp/WDSOK46T3uWwqsqCJ?=
 =?us-ascii?Q?0BFUjc9jTCnhhBgnZcRsG5jcnzOMfaRr/MIb6BZGaT1IesZPBdY8O/hVrn4U?=
 =?us-ascii?Q?MLa+5ewrOPRfpsmmF04OfNm4xm4m00McRX3jJiQgHnjNuSRvqwHnOwrpvXDO?=
 =?us-ascii?Q?sYL1xGy0yxr1uCZ5k5WnLomjX0oIA0Jk4ecOLxx5zhC+pi8eqw7kWRMerjUF?=
 =?us-ascii?Q?vhJEgJrqlkNZaxofotdxwHV8vWMOpI4EdZRyFij/9dRuZIjG9w0gHMl9EM1u?=
 =?us-ascii?Q?/83wWlockiypjpTEfexuPWEHnuhcYvkxYlT31E+5YVxyKGKt+/pOypi90LLm?=
 =?us-ascii?Q?1MJqWL5oABAQz4Pln0Ef7hQU0gZdp0Iina2qjkNCtPHEPSWgHZ0pWAiTPElf?=
 =?us-ascii?Q?uKRya0KJib0LWqkQBmzLONRz00D/idOYxINnNJYVOEnolxw0OB9c0jDq3JO6?=
 =?us-ascii?Q?8MG/427ECdNyA11JcJ2+qc8chmlC8S8Qhy9+3+sySuyumVb831LhBSHbDLEm?=
 =?us-ascii?Q?85V+YL0LzanGLnC3bBt+t9ACMyUb2aqJuSewxR0Tys0d6TFAkzYTo0OifiQ6?=
 =?us-ascii?Q?TqzZooQH8TLGirnSscqpsOaTCjd0/qirntjzGIowlzDJAuovPn0ijyUr1C9g?=
 =?us-ascii?Q?6joBSH06RRUhz6IFFEBTKoFvOLv5CSxozXK/N48QWCCqcPPD91NDzjWxRNrf?=
 =?us-ascii?Q?86XyFdi5sQQ/QiBo9SZpL3021cj3pSHbO57/+NCLv7R0pQVZF5qFzxCEnB9g?=
 =?us-ascii?Q?Ef4dz+u/+IgE2DomtjBWB2HlTQm+rS2AxfpgIYBwop0BNJs3VJmTmbphy93i?=
 =?us-ascii?Q?Wr4HejIDIiFhwmHuKcYgel01nt//pB+7rVy/jQL0bUNh12bKVON56b0y9tr6?=
 =?us-ascii?Q?uqIOa3eUH0wOBFmXug5JfTUT2wyhrvlfRLA2i78Tx54nVKF3MJDNaEN0wVEj?=
 =?us-ascii?Q?VoRmIp6Fs2qMCSYJHLj1gZCoMFg4TnY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 082f790f-0bd6-421d-d824-08deb19d2490
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:42:41.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Um/m76gfmoXPGbpBetVNJeFUpXh80UmConKZRUz/CjCRAIG75DzzjfzO7XacDlq3X65bXUTJ0xyQNGew11BhgK7Uv5tvmN9r9a1ZkQ9Imr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13906
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:42:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22959

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


