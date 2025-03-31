Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822DCC36014
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:45:51 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web10.49046.1743417947150721213
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=rnUZdLPv;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAF5BgKGJDcfYFzGDhvuw2ZagE932JaR3t1fFwtadLK6UWFYXQ9RPgcWydIzchfQA02Og7KUJL/jMXoRTSLRSClwIN3Cmo7Wm4pNT6GaTC9Beo52FhKXPD6D/s/i+ycJpFJni/JhirpRAL31+xX8UP3TIQJk8nwGOmeArSzVwae0CgDvsI9CZwiNiL0JCVxHxp49nX7EYr/mPL5o1mQnjRJhQueEuo4X6iJqcajtXFcvtadxOt5zAB9ZJI0vx4WckHETzNTLN0HHYbVZBNTXG8swbFMN4+SQwanj9iFkl6Lr5jC/j8JDucOCVPSyNwzAocJUJDyMIBfAG6BVgSnTzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1pIKDVxDKUV+IERQWmM0cmHdrte17J4SqXkRj0T/52c=;
 b=nM6wrDCxfcElDfNWvGJ8yUIQaQleqhzPY7AW058M3jcgFZHtLKef+Nt9D4uPiSVL36Q8g2AS//zLtmPTBVwS1f1F4I9Avrh2vbZZyHAO2LXGmgDLt1vUThB05H3YgkMxwbwt9oTliNqqPcqP5rx+gRxsVAx2RpnPxFAE1QLOD/48G1SA201g1LliFKDXej6to7GL0XsQ23AGVgHjjPryJKzq/9gi/ayNCh9yIc3m6Kuu1Qkxm2lIhxo1Wsxub3NHk2QXhK2MZDrrhBSSMCObmtupnr6eMHgrs6o+dPSeAHwQrnO6+BnoF2lfODOm0LbyfWlSqGGYtpoAEDA8ljCD/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1pIKDVxDKUV+IERQWmM0cmHdrte17J4SqXkRj0T/52c=;
 b=rnUZdLPvoae9thM4bP9FNDq8vItAzE7P5GabXdGaiQZLPRYFK/9eXkyTsw10Ft2PFeYkzFgtjEMDZAtc6qtE1NcbqDqO5KlH9sKduU2gggi+NikLLXc1Sf+OjKNEa+q3dZMIDLbtIMfolFSHa59E7dnzhKFMobqFPNGNeq7kHCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:43 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:43 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/43] dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
Date: Mon, 31 Mar 2025 12:44:35 +0200
Message-ID: <20250331104514.79090-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: d9b403f3-c22c-4b47-dcb2-08dd70412fc2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?hODLurNZVPn6YRE16V+amvvc2apAm6VvDebpIyIONxqEyVhJyoc6vWwSNjmM?=
 =?us-ascii?Q?TzFZm+DEgjjY+Jja7HJE9fYqh1KlzWZ2PY4PJ8USdzD3FM6/VQ3kiD/Ngdn8?=
 =?us-ascii?Q?IC1Xl/EdeczKyRwFP+6F85GD6mkx+QloZ79MaXVlRWJt4bdrzyJqaejJUsKB?=
 =?us-ascii?Q?DTnWfesx26eAy9yu6qR4lEBqNjQJGYIzxgV0xaV0Oab6FOku7s0KdmprK6JP?=
 =?us-ascii?Q?XQ8rBv2EFvG9qopL7Rzb2oFDQQa6GsbYp4nm1MxNORLqmGnCOw0TxFWElIpk?=
 =?us-ascii?Q?gxJRHwGIJdievBK8cBqo3lOmWhac0408O0/XITbS1gEENnJzkb4dwdOnXRWY?=
 =?us-ascii?Q?vvhDjEeXYE3vYFTt6FYjsSrzkSleT78mYa6PGciEjga0OLEYmEbuCCSQ+1BV?=
 =?us-ascii?Q?O9YPXD/OACnsP+xw2AllvjU4Qb7yvr42viQ35SAsPryDYhlvG47p6GmTEKLD?=
 =?us-ascii?Q?/B38Mv78+AK0tdKGb181WrKpVJC1YXecPFt8KuwcLPtgmqlVFpXGPH7/Mdic?=
 =?us-ascii?Q?OTCVJR2z/Ta2wwV9SJvELgtRJFCGwYhDS63bFIwQXyVON9ExFisu9Tmrb9fP?=
 =?us-ascii?Q?fzFUqtCYaYI82t0EMJEiQ4bCVdWFjD+M3PgPl08407tPV0jly4CQAd7DkWoT?=
 =?us-ascii?Q?5asuvYjJfTB2J2eER+Wjhk26+EvcCnwUAEpzxsrJklHvlSKRwOiomW4YHcGh?=
 =?us-ascii?Q?yM4GvKMZL+yPyYzGiYIyUNapLm2E8BCRw8B1uJERn6f0csfiKLu3mIUBDlYs?=
 =?us-ascii?Q?qxIPzz/PR9Ka3cI07uUp35QkIA39eRH57BldCCQcFuaK1pcNQJCLYS3NvwJM?=
 =?us-ascii?Q?38wpB6TIWsRgtfkomy2cVIzf7gIQOWCo0In2rlcTw3OInL9i2REaRogAoHzT?=
 =?us-ascii?Q?ZWOqRb/tobVDKU0M6gYe+JMmFAHMQHvRgkes2lkBqCOrArRhMls/Ejlg8yG+?=
 =?us-ascii?Q?P6qCoBRaC8g71e5w+/DS0imwsUs6QAav4hbjnjgpAP0w7wjSDUOWKp9duO7c?=
 =?us-ascii?Q?EmIi1VvH9Uem9ag4V7T+N0i6zDHITRSwPss13Io75awXl2iFSHpC2q15CRtY?=
 =?us-ascii?Q?z3R0FrCOTuGe1bddvi5LwKm5kIZaA96QedcS/bSALPxRwp2UW1zX8KMhjwDe?=
 =?us-ascii?Q?ViP37GbWs4oFaWoNLEd1bZCYIg3/J/GG2Nc1N4ztAAM/U2yolXvVWXjumt+2?=
 =?us-ascii?Q?IAcz3wr8EqCTrNXalNEjb2Q0Kn1LSSkHvurjgRGIQr4kCinORaESHLTKRdgr?=
 =?us-ascii?Q?yLYGK+TWneie8GUuTilBSMHzR+aBPBiTKYAHpET1OgFTeOreK/d5gy7VRDmg?=
 =?us-ascii?Q?kdG5yel1SuBrzx6yZmwtD1XHwRFAbQBRI8LqlR5bgtyhFI8g3MIf8Zzoj4kR?=
 =?us-ascii?Q?cWUTqWVDp00uMEEUggagQnzP2Oi6NwVutpcuK3kPWZ+dhqijDlrtt9bweUr1?=
 =?us-ascii?Q?nJJXWRt1YYxc7NMNXrgwtSMSx0PNBTOL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FcXfVBoYDLlON0pYQ3+CTomO62netrr8YbUekXI5sidSEA6goLejTl1ZphSL?=
 =?us-ascii?Q?2dJMRm6CH65LEg7mxONzm9Nm6tnwbjZrBQBXlI0gKCEWHQRusnBDG8793uFt?=
 =?us-ascii?Q?PJ+FCl4lOw/2S57jDPpa758/vFoColVWkckFzO3JuJ7oG2m2pgvkA9LSUyKm?=
 =?us-ascii?Q?b0BouYfz2lkAEhiRzMqUAq1xfeugKWaQ0b/XEASouNpicKqzikLU1gzq0j3R?=
 =?us-ascii?Q?B3NtZDBDXTQbOpZ9bdWYPQ7iwJFXuJei8eT/rNoOz9lruUR1/mKCLgI8B1nH?=
 =?us-ascii?Q?C2hpBcuf6MU8SOAtwyh+L3v+o2hh9wJek38cVvVpcPhyQDdc/ZY/fWotrCIX?=
 =?us-ascii?Q?sLbcNsr3t9ADmxFABedFUeqCHFHGMcDmoxecwse1y0lKa/8IXR3IODrFME75?=
 =?us-ascii?Q?aOaq/83NsfFNKNmud+n2sl6lQ92SdSq0M1bkHZZBz59BrD41HnveKoepNkRq?=
 =?us-ascii?Q?93uFqiC50C2pV0CCH+vVpcyRPmQA390Cc14YXngjI9rDMa3bfHrM0tGaqRgG?=
 =?us-ascii?Q?PmeejxfRXMEKddU40jU1+fpLXqqNSIsBIoFkH2bwbsrkvd0iLk1HBggkdTjI?=
 =?us-ascii?Q?i5w6C7qEL77sNP14q1TV4LiBQAJvjAEF1Md9uTq+zHooag8RGjyjto4lDgaz?=
 =?us-ascii?Q?xFlVph3Gtv/P4Fs/1Cfdp7jwZ4hiS4Gzk4RbGdoU/ofeJ2VspliTwR7m5iD+?=
 =?us-ascii?Q?oY8fgv5GiKU65iL+x+/owO1iVaxrgE8Rk2DiqIGKC0C90QmMAw/DLdpLcTuP?=
 =?us-ascii?Q?mBVYl/HO/xwTz5zMeWc2DaUeOxMRgcUeEr+n6qocpqreTipCUh7rZdOJyd4D?=
 =?us-ascii?Q?ELjM+SLzXvcxDeRFCgvl8vOuULG5nNCbJW2dBkkzxX1C7tt3Z3Youb3NZa/1?=
 =?us-ascii?Q?sGchI+xYVJScmRGJTdmAAuJMu7Gier5tGAUfjo4y1zehVjXvIytsIeptQ1VR?=
 =?us-ascii?Q?gTedGvkDxvqeUzOWDF7xV+VWEqjJ49oiet53fyl0AKu3gxxpeYlNpleqf19N?=
 =?us-ascii?Q?ZrRgxC7bWZfS5e4vOIX9yEcf7lOaZYVDix24G+GnvV3yfyvpJ8Mf5UxgaEfI?=
 =?us-ascii?Q?Qxz6jS4puChn/5oF17Lt2INcgVstrIj9s4Yj2J0kPD43z6PO93nQUSePQ6vD?=
 =?us-ascii?Q?FgToJaH2MdhbnRNz2WX2NrEo3s6ZAXaoki3OwEl2reTg0fobus1snxDMDXud?=
 =?us-ascii?Q?mEcqY5wVPv5Wzeqe+I6pvNKXRgFhEoT9M8k4QBNNrwy8ElUA8nSbxXRH63Zb?=
 =?us-ascii?Q?lafkpNuaOSypxJB6OifiCFWGqRv2IsrLBYO4jeugEF4MmOpLKdRfuqid/0jl?=
 =?us-ascii?Q?E8WzuVjozrOw73qlqJChC9B/38TuHLskzF02n2vQEYPxS6exqpvxDeuUxRjW?=
 =?us-ascii?Q?Me1IWu0fiG/zrT544pxjjHdQ+NOOtsjh0HwmeV/4WDlbmHe/Q7PTmQLaejQ2?=
 =?us-ascii?Q?i0zvuOeOkbSheIgkXZJKbnaDmrogGh/N196qyrLyShpsdb1go/OU688Rf6Z5?=
 =?us-ascii?Q?GAvst1+uzJxM+oFDCxt+udJgDWpl9Ls9n+t21rjkHNEJhCqpfp5x2Mkxklft?=
 =?us-ascii?Q?qpuKCv7eZq1Qk46M1npAr6w4F6yC8ItbC1eHzedbaEHlCCs38oGWVSZAWbp7?=
 =?us-ascii?Q?trGf2t59LZux6inzTOXc9dA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b403f3-c22c-4b47-dcb2-08dd70412fc2
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:43.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4guwnVptdieIoMtBA0MUKIIE7R96xpxRWloM6P8CBLRBt1Qb53lc6ugrAy32X+V3PNVfJQehDx6c9QC5FS2I4WAS6L2Wio9rqlKjsm3vMKVb3T566Mg0KElzB/pBm2ci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:45:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18392

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit fb73d663b31398aea8528fb231e660c4958b29ff upstream.

Add documentation for the pin controller found on the Renesas RZ/V2H(P)
(R9A09G057) SoC.  The RZ/V2H PFC varies slightly compared to the RZ/G2L
family:
  - Additional bits need to be set during pinmuxing,
  - The GPIO pin count is different.

Hence, a SoC-specific compatible string, 'renesas,r9a09g057-pinctrl', is
added for the RZ/V2H(P) SoC.

Also, add the 'renesas,output-impedance' property.  The drive strength
settings on RZ/V2H(P) depend on the different power rails coming out from
the PMIC (connected via I2C).  These power rails (required for drive
strength) can be 1.2V, 1.8V, or 3.3V.

Pins are grouped into 4 groups:

Group 1: Impedance
  - 150/75/38/25 ohms (at 3.3V)
  - 130/65/33/22 ohms (at 1.8V)

Group 2: Impedance
  - 50/40/33/25 ohms (at 1.8V)

Group 3: Impedance
  - 150/75/37.5/25 ohms (at 3.3V)
  - 130/65/33/22 ohms (at 1.8V)

Group 4: Impedance
  - 110/55/30/20 ohms (at 1.8V)
  - 150/75/38/25 ohms (at 1.2V)

The 'renesas,output-impedance' property, as documented, can be
[0, 1, 2, 3], these correspond to register bit values that can
be set in the PFC_IOLH_mn register, which adjusts the drive
strength value and is pin-dependent.

As power rail information may not be available very early in the boot
process, the 'renesas,output-impedance' property is added instead of
reusing the 'output-impedance-ohms' property.

Also, allow bias-disable, bias-pull-down and bias-pull-up properties
as these can be used to configure the pins.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/r/20240606085133.632307-1-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 235cefe60f5dd..7d7e66eaabf19 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -26,6 +26,7 @@ properties:
               - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/=
Five
               - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
               - renesas,r9a08g045-pinctrl # RZ/G3S
+              - renesas,r9a09g057-pinctrl # RZ/V2H(P)
=20
       - items:
           - enum:
@@ -66,10 +67,14 @@ properties:
     maxItems: 1
=20
   resets:
-    items:
-      - description: GPIO_RSTN signal
-      - description: GPIO_PORT_RESETN signal
-      - description: GPIO_SPARE_RESETN signal
+    oneOf:
+      - items:
+          - description: GPIO_RSTN signal
+          - description: GPIO_PORT_RESETN signal
+          - description: GPIO_SPARE_RESETN signal
+      - items:
+          - description: PFC main reset
+          - description: Reset for the control register related to WDTUDFC=
A and WDTUDFFCM pins
=20
 additionalProperties:
   anyOf:
@@ -111,6 +116,16 @@ additionalProperties:
         output-high: true
         output-low: true
         line-name: true
+        bias-disable: true
+        bias-pull-down: true
+        bias-pull-up: true
+        renesas,output-impedance:
+          description:
+            Output impedance for pins on the RZ/V2H(P) SoC. The value prov=
ided by this
+            property corresponds to register bit values that can be set in=
 the PFC_IOLH_mn
+            register, which adjusts the drive strength value and is pin-de=
pendent.
+          $ref: /schemas/types.yaml#/definitions/uint32
+          enum: [0, 1, 2, 3]
=20
     - type: object
       properties:
@@ -122,6 +137,20 @@ additionalProperties:
 allOf:
   - $ref: "pinctrl.yaml#"
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-pinctrl
+    then:
+      properties:
+        resets:
+          maxItems: 2
+    else:
+      properties:
+        resets:
+          minItems: 3
+
 required:
   - compatible
   - reg
--=20
2.43.0


