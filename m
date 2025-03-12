Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46639C35FF7
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.57])
 by mx.groups.io with SMTP id smtpd.web11.34862.1741778808731895504
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=sk3pvErS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vJGoCE0pp0VVpvh+kGXnl/lFbDCETTbyo2IFI2TaGJe4NEVSCPdYbC1C1H6GopknAhMHI2nEAHyCCxvaRfuRon4jnN7HN/TKJIwZT669GC+C7TQc+45qLBg0YATXrUIS/5CiLaHsfJY0fOT9H32PuXzW0BF86yv5cFonjjlk25mavrclCXOJGHOdzb1PhMzgGrW83RMNXLKvXaJmngsU+R/a9ZniE+rw+NCROePA6lKB0aJ/foxndbo547zbGNOmFYwuMTPHZFSueiAZ+6Jkep5rzBPc9ahH9dgkQcSH2E7dvlGcgXt/ECelK1bus9HipuBr4uMo1B+Q92D+hxWrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OH0Fnv9nMLVVRtgt6DAW6fxpEit3etTSgxoE7zxbBv0=;
 b=rarplh45YKLDA8LhHlq4ComkAvabPPA8PAdLdJlw3ACO4CwPsL3mUH2whpAFl2qqL7GG/4FfcuaLAcHMTO5w0hggjRqB8kdVk/K9Dhepl+vdSIQCw9bEDF7i9YPZRos1o6EqMUQSa2H8xVjjL5Z/EOf7gQZJgO8Bux2HMRqcUn3Dw7zPMRtxlhDYgfwzVLdEwENyLEI0Ckg2GjLl9THAAZ7H+2kBkhzMxKUqxc4mwtVlHterDl/5RH6XPXFYgj7dVQZWKFaxDzg4CaJHf/qv2aRgg7Yd8PDv7rwJYT608qHlfYE1eqDEO+ksUFYnSA/TVFEnypRtBs6M8y7Jeue3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OH0Fnv9nMLVVRtgt6DAW6fxpEit3etTSgxoE7zxbBv0=;
 b=sk3pvErSBcxkQDdQrDPbPyz12HS2xH1hTiE8foZqmf3Vo2PEorIHGrdadf9/zbdZj+aEvJgHKiDe82fhaqbI5I7KerDl1DncbN0y3VAtx64X/uKvvCcpXuAU3IgTZigyv7HcQPsj5T3zagCrlZF26IOHNT/GzAbBdvxs582MXio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:47 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 65/85] dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
Date: Wed, 12 Mar 2025 12:22:42 +0100
Message-ID: <20250312112302.1605750-66-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e9cb99-1852-45c4-8179-08dd6158c625
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KSj6nUy0v/MnfESlrzBTEnDzlnbJLH61yNLWK+1s6jmQ5zZ7REXcHdY8i+ey?=
 =?us-ascii?Q?kiX/+oKT5d9ZsVm/CkjKvmoH+c4vhQFnd5BKGSO0ZFwao6XEXzMcEnME5NMO?=
 =?us-ascii?Q?YaCxNa9MG+PB3eIJhASj6TVTcLZ3J1qsJec3jlGC0kyWNKgDHdIgdaclax7p?=
 =?us-ascii?Q?bzticx35ILXUQ115UFT1SroK24Vv57bK/ARz4J3j2DEblBdpbrKeoqETVdun?=
 =?us-ascii?Q?dSe1y8N5esqnHOJO9SuhULKLkHzs5lBs6IL1bohLXWxFNIseAhWb9wlictzw?=
 =?us-ascii?Q?3VQoGE1u05fYU5bzgUL07Uug+0Ggxsu/77hzyvnFCG5av40InIJl5i9U6HOQ?=
 =?us-ascii?Q?NwiJ4yi9W7jGkjd94Q8GhUlg8t9mevqnHIE1gOnyH5n9ptAAZK0E7kWRiany?=
 =?us-ascii?Q?J6OCaZXt6kmYKiSHNRS3afFu0unq2GQHTVS3869sD1r9530L+lVtS/rkPagU?=
 =?us-ascii?Q?ADSNzXx4xInyeQuEI27pnECACyOrf19t1tMRdgxHyyvwP4j0UOQ6L028FtCR?=
 =?us-ascii?Q?+rcqhOX51wFBUZOiEqrDumMRaQXyB//UBhTuzAR27LkhP21eeIO/wMgxzZmt?=
 =?us-ascii?Q?STudQNCtH8ByUMCILarwAnORPlhrNLP8QrlOsnGT+Gx5XMB+ZMvRrrIrksg2?=
 =?us-ascii?Q?GozLR2O1B7aWyqMGaIFis4I8eW7NOyntDd+tL2cxcj/6f1gyFiTTr/j7vG6g?=
 =?us-ascii?Q?RtS8wru7I4A/hZ0D8YfOeita6MB9T3FHr87x+30/D6yj4UJoFBTn73Sx2egw?=
 =?us-ascii?Q?/yuEYOOMuSclp7yKwOIGPHkKmCtW9Ueo7NPHQMSJ1pw20EdkvU7O4OnVJj+r?=
 =?us-ascii?Q?545LD1/ye9UIvP0Nc0biZXn8D9yLGWBqYaEnCg+G6K+ruXW6ex2s6P1c7IVZ?=
 =?us-ascii?Q?SARyeV9tjKEEJMlzb6vDSYHJz6griazNjUXG2wciR0MUelgi8dNoI092QWS8?=
 =?us-ascii?Q?awb86xyHPtThGid7jOmJiIxi3qEi02RCHYOOFt2lKz0n1flBMcHl4xzXre+j?=
 =?us-ascii?Q?zeCwp7mZSWbrsLOOyr95xRYJ221ByEyh0OJKLo9gJKc07osMSJqYYYLurMMz?=
 =?us-ascii?Q?HO4OQkdUedu40MdbLyO80kDfiWgEtxkIyMvZSjNQp4onGGZJbJvSpkdiwHay?=
 =?us-ascii?Q?PfzeN0WhlLc/MeVGw7X/SnDSf2LYXX64+lF/qRiucpipS13HaAgZVZ8sXigP?=
 =?us-ascii?Q?dMQ7Nn9DWqSjjedPKs9q7MhJjyQFf5cPhPS1a5qIGDhtf8XTu22+tk9i0oPd?=
 =?us-ascii?Q?riL246wEuaaZwV7q7uEf9R+vdW4dFOFbUJz3f7OtT9pmUtbpk1b6JBQl5ovG?=
 =?us-ascii?Q?cVJlyOQc6Pzxq5SA+f8D9j4xUBqxGRjIBEM9o+9HRAy9ZTcLc04szY86g/5u?=
 =?us-ascii?Q?XtD210YhDaoq3uxkvDK2zfPqnyzOOmTWK3tkoJ5LGEsNZCORHES/uWK84wdv?=
 =?us-ascii?Q?qakCGEdHBTawWDyLwK+2Ber6Znxi5Nga?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qphtwhjq7nF7rjfKZUwUmwcGOiaaBpKAdVPCVnEGHBVwerT0IT8VbrItE8gr?=
 =?us-ascii?Q?WNT9FQKx/UbJhTG/fYxoMM9Q77eXYwpAmkmVChRBZiF79vJvi8P+8sybUOZI?=
 =?us-ascii?Q?S1TcOh7lbXFtP74bPPDpXOxAcULh+Zcbz4ed8VtzSEBiuRegvaAbZ6KOhSz6?=
 =?us-ascii?Q?EjYf6MfvKQBhMkbblcd5uwO2YW0+qZJ90wUfikt+ghFfyD3QB6G0of4lcye4?=
 =?us-ascii?Q?OmSWmE0GRGDqbCEKFp3sSpMUv8+XpAaimbMET9J9jT3ElE2/zxG1uCRLorqU?=
 =?us-ascii?Q?0OFNzkUVCRSosPkAXcAyMwIdfOoBwItk72UgD8UF6Gjy7zHqREb4sSyMOVRO?=
 =?us-ascii?Q?tZJxZd2M8cNRuVLJkqjHxAW2f2J2htve9JWQbUS2AsQgDwQTeUVgc8c5ntU9?=
 =?us-ascii?Q?sGcJTY5h33K51hI9vcm99qio5RCawGeHR0oKJMj39FL5ttvjgHzeH6ciBrFE?=
 =?us-ascii?Q?UChj/HvPpIxyBAh3/ErEK/I8oU6Hcm8x8jOgtfkS6hjoQQ/i+A7p4UMc93gG?=
 =?us-ascii?Q?a24ZYCMfoOPktijBHU33QJ1kb/rgCDFsS2zX22iKWBmxVDPyf4yDCC+Di+bx?=
 =?us-ascii?Q?ne+RhMEKqNRMFo7sBIYKYWZIdTPkq41SiwhD7wW08XTSIReE5BJegt5sUvD0?=
 =?us-ascii?Q?WK2VMkmi1ycTcW0A67P7VUQ0ARUj+/DIDb6JoAkxcTMu0t70CAAf/lwBQGwx?=
 =?us-ascii?Q?ed4IVz/B1LppnTcNND05X+X7IsKVJgjatN+c2HgB7ofp8Aqb6UqmG9BrTDjE?=
 =?us-ascii?Q?ftEUT2yUrjk57KKpppjymQUONIUaJOEFV1eADTPZzbSRqOlG5oCQpXcJe4B/?=
 =?us-ascii?Q?0poLiyEM3ekvwf3JeutVufe0REX4AIRNucnilXI9HObquzTm9BRKub9oD3mM?=
 =?us-ascii?Q?MH8JrD75drC+j/w3FmOFDNZeC3zh5ydM6s+3dueTnVnrajhIU2Qlly52YJ47?=
 =?us-ascii?Q?3ZlueGfNlSdVF6ElS5JEJuJT6UjN5pZeRF+NVKMieUAzuS022YFSIPVPHNlp?=
 =?us-ascii?Q?AZ6T6t8WP7uj97a3o0rC3y0Mpp7ElGLQVed+mWOTcb9RiWtTBWgBEokrnrAX?=
 =?us-ascii?Q?b3Sgpfx+k8h8B+9dQ9z3jh2Pi3jbGPVpv05Hi921Tx7Mc+iTzr53PdgaA59Y?=
 =?us-ascii?Q?Kv0bt4YZRNEIJxN9nqw5vVGpRBWGrTlSd9qLBcR01fXBZQIrYqwz0gKl+Xp6?=
 =?us-ascii?Q?bui+RuCexxNs8JZUo7g7N/WwLRa2TvuO4zMu/G0nmQXoscAcC3ZTFpCJ9wqj?=
 =?us-ascii?Q?DJaI0OYxRszEDyfA19IXRtzl5v9TUd+D77a/uyO2ZfHxCvOBcDgfeZamckM/?=
 =?us-ascii?Q?ucKMu/AoqQsMKtxuHw5pHUh735jUCOZlI297rQ275Qpzuu8wXpPv8pwi+C2j?=
 =?us-ascii?Q?HS/dqC00tuG96IndLNe1dqHPZm33JtZA7pXD39928QU5g/fyS40KVePNy34i?=
 =?us-ascii?Q?inYPmQJvhNWNauZNXQMhs0+fJR1SQD9o8ahW766qWY8WU503oFCinjH12VBf?=
 =?us-ascii?Q?qmEcD/GgRQiA87YHmrzLaT5lLXZNG+sohMDw2zbVNunwlKZFv8UL1aXPsBHP?=
 =?us-ascii?Q?yguVSd8jUP2Z71IFcU8zxl/FioCM/W8pqpAX+ULIxOfaVwbC+hppuFZxVmVF?=
 =?us-ascii?Q?uuB8J6qcRi2sdv6HdV3Jyi0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e9cb99-1852-45c4-8179-08dd6158c625
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:46.9126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJmCEdPhtZfZw4Zajsqp1Muu0IfLeg50C3FbC+8Jw1EktnpWBAtuXjR08pTWya0ESaX1IZ5wrx4Ev2iuB0eDm1sIWvYj4rtHTP9asYNtlpexJtoOUaNoN345Zc5qFReA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18157

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 220fb8ff6d326d91fed8a0a44e3ac0a2f34d3f9c upstream.

In preparation for adding more validation checks move the ref for
'serial.yaml' to the end and also move reset check in 'allOf' block.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20240604170513.522631-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../bindings/serial/renesas,scif.yaml         | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml b/D=
ocumentation/devicetree/bindings/serial/renesas,scif.yaml
index 1b5b6ce6de0d..77587b0c8642 100644
--- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
@@ -9,9 +9,6 @@ title: Renesas Serial Communication Interface with FIFO (SC=
IF)
 maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
=20
-allOf:
-  - $ref: serial.yaml#
-
 properties:
   compatible:
     oneOf:
@@ -159,18 +156,21 @@ required:
   - clock-names
   - power-domains
=20
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - renesas,rcar-gen2-scif
-          - renesas,rcar-gen3-scif
-          - renesas,rcar-gen4-scif
-          - renesas,scif-r9a07g044
-then:
-  required:
-    - resets
+allOf:
+  - $ref: serial.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen2-scif
+              - renesas,rcar-gen3-scif
+              - renesas,rcar-gen4-scif
+              - renesas,scif-r9a07g044
+    then:
+      required:
+        - resets
=20
 unevaluatedProperties: false
=20
--=20
2.43.0


