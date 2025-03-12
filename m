Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F1C35FF6
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.23])
 by mx.groups.io with SMTP id smtpd.web10.34492.1741778811411077572
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Vc8Xe1XV;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.23, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G93wCc+bJIRMooYEqz5u5E970v0ueLduUDLPkjtA/TiSTM3WvI5OUogLhtM5crTHnc+5agWEFIDIU9xZcenRAQGZkUz/unTaKwvGa99Ox0hs9MHTob8Rr1CPdYg+7zj4fWOW5s1MzLKrcSypMCA4bAQCbGPEMLi3EMtsdIU/cngqwgOtS0zZOfO0wFV9xsWugMNlQw2gwcixhFiTxN9wxaXKogHUrIeypzIEj0gj1K6D27AQJkhcbPW8TN048QC5mGtbipFIKby/zX7RhxSAts/GQ9BsJ7yVLlOYQXj5yKtIal0h9N6hGaPJHlU57BIBGN1MSM1VVaJ+VV/QK1KYvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKyo/VTEMUDsggB6jFLZ+eQTpHKATc1TDdcpHKTyg0M=;
 b=HmCVay6XxlSG2L9NlPRPDNaHQB+x9pAWYDoFFgE5rGzytn6lS9xHDgCuIe1J6m8WlOkZvPZ3pNAQgGDaifet6wpOnWFYOXplk5Bqhizxpek4GkMaGvkgPdO2hQwvvaskAmRFkm0z1S/h5xSA8AdB8fJxdJjWF3EZz31/v45ZMvnS9KWIE2oTVW2y5WV+kjNtQLPcvb1uIWxgYOgifmXzBbtv+CsU5Dr68QcKeB2P6fi1zGZRFldLab244Wbg+uxu1xczCXFGqaZCzr/DGutukEePpAYGOsm+5h7CcPNwsz217Cdat5vulPoj33mpB08r4IZ768FVUAAJvUcRD+1jmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKyo/VTEMUDsggB6jFLZ+eQTpHKATc1TDdcpHKTyg0M=;
 b=Vc8Xe1XV8FlU9/7Uu/XUHNyhKXQrGXxEjapR7ShcjyAhbR2s9PgiAlHPqkPLgbIwZ0MJ2ydJ3y542b2ElYdBSwWDqlpMlXZH/G/nzcczl+CkZ9tj7GkS2uNByLR5XmikKzwgR+Mxo2fEaX4nMq7wzAezlqgzhVaN6bXwlB4B/S8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 66/85] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Wed, 12 Mar 2025 12:22:43 +0100
Message-ID: <20250312112302.1605750-67-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 7db020c4-6c86-44b4-077e-08dd6158c7e7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a6X1WCnbgW19WkJSRfA9YJtN2m+SZSPbwjV+mZMUtEhCPCkRDCiEfdeqbjOD?=
 =?us-ascii?Q?ddwI47R7tTJGNTDFFBqjESkwDuVQRuSNpwM3FSTSgRyLSPwz7j5PmjhANslS?=
 =?us-ascii?Q?5RK5Xu4J6GIEBWo1y8RYQQCS4yj86bD6nHoI5sEJ51xpMc/RtDpfDavd0wOK?=
 =?us-ascii?Q?wIMyYFOEH2fxHO07ljTNwVSxoPRTD5GKfife7fFzwJXYgcgdUCSR9UDhThak?=
 =?us-ascii?Q?niMrccXGtpTmJto+U9lC/oqF7j2TMFuHsv3kzgI02N66Vt0PPFPfAZOtLUqi?=
 =?us-ascii?Q?W1XLGvPuTF8PbgAX71rLPR9EbwSNBqz0I83q2gTE67pTVYm96aD77d2M3Ocp?=
 =?us-ascii?Q?UOW9259uG8ux/Cv10qWSPoc4RJ+5MpGSRXy6Ta03Sxa8AkUJ4SaAtgruDWlm?=
 =?us-ascii?Q?wbnFk9BPePINTm6pvgMBZmZFOvfQREyQs8weUlk9T6RUGy4x/BejauMiHceY?=
 =?us-ascii?Q?eAmNZKhWjQPaD+yR6ceOpY+UsYydN9IwXhQH4ow5HgxegC+m68/tOXpNYX/l?=
 =?us-ascii?Q?H8hbbp26MCSGj/WctnucZbPsPkzTqhachqqY5fAMpLpeShpg63BASn0rnNGY?=
 =?us-ascii?Q?zXHvp0hHA6p0zoooq2i0xfSa9wfe9nQReCre8qwLSjEN9iwlMw+JsFfd6I7e?=
 =?us-ascii?Q?Bij9U+A07Y31k56HP8MdE+wSlEVO17Rl0mi9nxl9tpETvmJIOTGbHMf29cY+?=
 =?us-ascii?Q?79BE4n+jOOtKJrwKP5fGDfeIAszzg1Hopsw7R5cDgzLZyzWFEMsrG4TqCx0a?=
 =?us-ascii?Q?Y9UafIYfwBrjKrJqXVGbEHYTLDGDrfxnMM2B6lZA4mCKTB29wNzzmgOsq6st?=
 =?us-ascii?Q?/ppR1fQCQIqYpZJdr0teHer3Vv3Vf+BUQsnbReFIdVVFFPNZuW76vagtZaZZ?=
 =?us-ascii?Q?6XHzsuaf8AYitXVS30F2sDIhrZRuxH+w/RuVNtbRTTyr4hjnKWEj4M0Qb3bw?=
 =?us-ascii?Q?E3qp2iFE/VtRQBO8bCMvM9zS7ZOMXPGQI63kMCSosrrpWDKgaq6cQXukiTd1?=
 =?us-ascii?Q?Q7h9Mong9cKvtiiVWcaxrOxXEqyZAz+StL1Nlbr4VjW1RqA3G9rXFIBn/k1U?=
 =?us-ascii?Q?WEh/0zBBV6n4efww6mNvWc16xQHjiKDpJVYxdC7NysF7cTUh4OgcmVdHWoo8?=
 =?us-ascii?Q?jJc8l+1ddhxe6ueScJRmBQfeiKDYjdUdCm+FXrekw2kKcwLvkG+lVKpwWJW+?=
 =?us-ascii?Q?PaBlbbHfoi4vh4KGkB9TUE+Fbd964ah3nxEw6uXn2DhSGujtlJbRyuHH1WfV?=
 =?us-ascii?Q?ARQRcxUQIHC+5y5X8cGU4mZl5A7Wgvxg5yX5ud1eEfVEPcX8l55dmbh/z/ul?=
 =?us-ascii?Q?5wnQGIbrW54uq7UgRsNQdXa4BkC97zkMM/2TO6N/WwYIIKvpIwOUpkyzNhld?=
 =?us-ascii?Q?lGcc29uV2MDyzDp1O58JRVAgbS0REsVkwAnb4D1/skMjzUUyAYLOAi6S93cZ?=
 =?us-ascii?Q?C7Wmh4ttFrSEsjkttbVP4fLxTAM5Sa0n?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UaqlH42qcqYjBzlGtIdfPsxcDyToQe2iUAN2IgQ4SmzLj1FiwFtv3RCbr3ra?=
 =?us-ascii?Q?TSdIDHJ9qwXAuC3ZsssHzHw7lFNYCsM9KPnmgUW5z+DYxhWNyqw3tXFIV70n?=
 =?us-ascii?Q?FsBRZv9qNXnYZ6UGpZm+orKABgSueIXTvV+ehnzYuh10YExE6kHpb5znB/pE?=
 =?us-ascii?Q?2tV4czjiUaqfxGdfgS9KxJv5KvPS32yeyWpE65uB4LOYtqXZZhZCUio0Ewck?=
 =?us-ascii?Q?H4nG1aylMj4Qj/2q/zpgXc3U5oPwBZZVjp2PBxinLipGQftPv6KRI4DnztiU?=
 =?us-ascii?Q?wcmJbNCz8abStBAgJ5jxOKY8Zhp3yt2l/IqLdEAF57vYCN5qSMtn8lD4C5dM?=
 =?us-ascii?Q?Qm7ClC7H/W5C5GbOMxDNV7P7auy1zAoOuJ1gpn6K1o/Awr1a4k/MMqwtZ2Xh?=
 =?us-ascii?Q?UQL60NPSgJjBenBDiP3MLwFzeseW6PBtF6Gx422aU4HOn+I9H5Xn7Z2HMtku?=
 =?us-ascii?Q?4GLmmnEVGAbyOq/vJXFcOXS1Mxn+owYXRLTRNsQIDpR+/PAyjrsUpocZ2Sz0?=
 =?us-ascii?Q?xHNJPC9K0jV2t1cR0ut88pVK2A99m4YDPW1HlWOB/XrUilfwUGAaZO1kXPG9?=
 =?us-ascii?Q?32E7SddzKj+OH0/hStY1Vi9XN3YgbeqvqTMgkcJXU3Ws2I1SywE8UVRHZlr8?=
 =?us-ascii?Q?UJe0qOanPSsJoSN8gadnULhIvWLkHzbD92HNJNDZf5WawsId3RnpAKk7ywz7?=
 =?us-ascii?Q?aT/5Jpxzet8qRtdEhamNqBuqpumNcAprCPQInb+VjZw4XFoJ+NCYElDmyCr4?=
 =?us-ascii?Q?XgvqwA1EmyOfPkGzuwQkQhEGeSPA2jjsUJXyi+C04ylyvLxqGcw7kiWdd8Tj?=
 =?us-ascii?Q?zLglRKsxYeTDbpic4sNrB1HXj3P6zk7jOwj7Jlbi7lC2HPdSoBlHjkQNDj5h?=
 =?us-ascii?Q?IblDF8GyEjA2040oC/z0dHThDuzMnJoJNqlidMwrCNEnHxgwVBpWEMeeBOIY?=
 =?us-ascii?Q?R/uzEX+u1CHQ/bF34+/p950PS7fR+xq3QSKVJbHC1KetLChg3n18jgBHGQHI?=
 =?us-ascii?Q?PA70RgLGV7UUx7kdjcXYKRzsPDXS3ghLuBR7au9LHX04geLnkDrz7sj8Q35i?=
 =?us-ascii?Q?qXbrZp86fETpeyr1ZaHb+bn4i9XmPwpTSUcdSyB4O5QcL/zMwXoPKXEa+Gcn?=
 =?us-ascii?Q?6cyvMXaDk+hXW+9LJdp7K3SIOGL4OAKF36N66VckPbZLJznJU/HJeLWgkqcl?=
 =?us-ascii?Q?1vfP7QtlLp0StP3Nr80FXLNggifNUD6CQfqE2602ifnh1cYd/E4jw1l5Fb+D?=
 =?us-ascii?Q?sOYd9TDKjf2XRW3RQrHDdpMB4r+xE2EoJS0qkJwOwQmLQrYw4yhiqLB90BDc?=
 =?us-ascii?Q?d+ieN9xMr54sKNlkYGyX+CyCacjlSu5t5/vGxwFSXMuq8+1lbAqCk0EmVrrT?=
 =?us-ascii?Q?cJAnhXtUwdArflndkcpbIvUUSY7vtRalXjHNLvDrqIx0yYuLSQttQKSD2oMk?=
 =?us-ascii?Q?vZ2O4fdUFJlBru8D1TJkCko8Wkujjs2ISHUhVugwW0qtPK5PxMjL5NHVmeMY?=
 =?us-ascii?Q?8SWQmRuL6LZZzbr9kuPVeMPYhJOLIAjXuKLAPWZ1gmvgVOZw9V/YBPD8D+bX?=
 =?us-ascii?Q?QOHrr/5lq03TvvsRZqSF2FLXNV2p+QUIfZcGDX1i+XZDXJGrpCwdQoKy9qTi?=
 =?us-ascii?Q?QVeNyDh0VEHIl5La9ydQHak=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db020c4-6c86-44b4-077e-08dd6158c7e7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:49.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: my7c3+VH690DSUMsZwkt+yOP2HgiauKhh0vJ8URL9ytJsuHwsAqh86ERrNfJ4gxXZkpu9IQ4YKO8Uc5GVZexj9pXEbz0mnFg7fS1u/HRF+LkN/CJTbMqDeRjWxjoJZc7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18158

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d057a1e3e475c6d9e24ce2e79c3f3daf367e33d8 upstream.

This commit adds support to validate the 'interrupts' and 'interrupt-names'
properties for every supported SoC. This ensures proper handling and
configuration of interrupt-related properties across supported platforms.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://lore.kernel.org/r/20240604170513.522631-3-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../bindings/serial/renesas,scif.yaml         | 73 ++++++++++++++-----
 1 file changed, 55 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 77587b0c8642..20132a3202fd 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -85,11 +85,6 @@ properties:
     oneOf:
       - items:
           - description: A combined interrupt
-      - items:
-          - description: Error interrupt
-          - description: Receive buffer full interrupt
-          - description: Transmit buffer empty interrupt
-          - description: Break interrupt
       - items:
           - description: Error interrupt
           - description: Receive buffer full interrupt
@@ -97,21 +92,17 @@ properties:
           - description: Break interrupt
           - description: Data Ready interrupt
           - description: Transmit End interrupt
+        minItems: 4
=20
   interrupt-names:
-    oneOf:
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-      - items:
-          - const: eri
-          - const: rxi
-          - const: txi
-          - const: bri
-          - const: dri
-          - const: tei
+    minItems: 4
+    items:
+      - const: eri
+      - const: rxi
+      - const: txi
+      - const: bri
+      - const: dri
+      - const: tei
=20
   clocks:
     minItems: 1
@@ -172,6 +163,52 @@ allOf:
       required:
         - resets
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen1-scif
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
+        interrupt-names: false
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s72100
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+
+        interrupt-names:
+          maxItems: 4
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,scif-r7s9210
+              - renesas,scif-r9a07g044
+    then:
+      properties:
+        interrupts:
+          minItems: 6
+
+        interrupt-names:
+          minItems: 6
+
 unevaluatedProperties: false
=20
 examples:
--=20
2.43.0


