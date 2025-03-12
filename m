Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8142DC35FF8
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.30])
 by mx.groups.io with SMTP id smtpd.web11.34809.1741778694505172667
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=g0wOd6AJ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wUWAsI7jA7gEe2zKh/kbfpDE88OM8knI2TzgtFTiyGRfMuc0CUDPdbzEATFxzLcokmSinTm0ZaJh9tu3kANb8s2oYMk9eVnqhtCmfe16h3abbnEeFE4QV7ydLPHfj7PUCuicgLbZzsvpEFnSF7bGtngxlU/s7lUGtqMadm3aBnySbf8VqJJfKhuGlbEYpTufW+rZ1ZUcuAigoKcuH6mJAZAFGaeCCl63GtDLPqESTpmOy9I6HrtJm1Ry2FiNzKbTGkdab4a5N4/A0EhjnOevcA24MXG3iaz2KBjuNZCf2+jDLlxSlcvCZn89EGpB1zZ/Oy6aqKojpsAU7IG/vAbCMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfFCcg7fErUnNy0Orxi10T8yRo84vslYM5ZuDVDq7Uk=;
 b=BgbEyFChszXmb2FddKbVuY2XviYuAcCWo+Un9ejF1ejrhSWGHjZeWSEQQB/QiIOLvF2MErxBJnPAAMU0X3RSSp8CxsTWNFZzzrzLqoruVoV6ElkmOy4D7h/n7oviL9E0Y0a5oOKfUlBXnIZZ6txBzaBZSkc3nEvVH4eK4JVwsVAwW/hnH0tBi1xKmFQmeEiLHauwDKnt9mLHCVL+f5MLCIgvVTbAnBd1b61+vfM7DH/FnZBXrDlqGywwEtfx3C6Am1aKhMgUaEOxuMWTOAhmVCg053/ySw4aik7ItwlTNMVUA8vzlfAZVP88dHbyP8oMavVZbOIz5dk9m7pR3j/JSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfFCcg7fErUnNy0Orxi10T8yRo84vslYM5ZuDVDq7Uk=;
 b=g0wOd6AJZhWfR8+h7hn97KoPz7pC7UB9KUo63m6KKbV8HEma+iNXmAhGHd9JVnko5Al5YXcVfCnZWa2uas5Rn4V3mjXqWux9jos91c6XRQBqj8bl6kG7t9ASkKb/sRy854KFwsFrA6JfFYKlfDhpIYGpE83VBBFqIf+sZ3zCwo4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 26/85] dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
Date: Wed, 12 Mar 2025 12:22:03 +0100
Message-ID: <20250312112302.1605750-27-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5d3ac9-da33-49e1-93a6-08dd61588214
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1BBL356aseS9AMX9LMKARhGv4Qkz3wqBrkTCrS7wLXLLsvCAUemDoancBJIL?=
 =?us-ascii?Q?I5fmYlZTSkpD97u9glymwI33wKW0keGbeeOCup7V6RfZdo14e2Mys3jMEFxI?=
 =?us-ascii?Q?XgMu6bWD3ucxts/UtxdKUVEittatbtvlEk3dbC18+BFXCVYnkXig3CozmnCf?=
 =?us-ascii?Q?ATK3if7gvyIAnOAvpKSkugERofTmrh1ZPbMHhti6wCqkP/RcSQ44mtWgjrNu?=
 =?us-ascii?Q?EhDowNvdjtvHtEFIYBAVv13V+eord9Qu/kp2JadngpE+n5p9R6PZa2aT+izD?=
 =?us-ascii?Q?wtr13mS4yob98eu9Qjlb9X4Pp0QmvytIn0IWbMlmnN5aPanwx67x6Yj4Jo+R?=
 =?us-ascii?Q?hn6Foiq7sYn45WqMTDo1FFj6Rwn5K9eP9vhWkiKF0JPdPjcqKBBwaoojc0mV?=
 =?us-ascii?Q?ThBMCJJBIjrAW4AxlFoLVfsc+HVEmSjGp4KEs6S5+7SvBtBYcEFmFVrgWVcu?=
 =?us-ascii?Q?RwEI8tXeqGVSlmFxAQkA35S6J9dJHXoUe+JSEM17iOaV7sX8LNtat7ohs8/J?=
 =?us-ascii?Q?CYfOe9Q1k3VDmGMmHGGAFjgAgYWVBBt9KtXbsn0wcpdPETNKZ7QVmwVo/v55?=
 =?us-ascii?Q?rK9G1NFeX+CFNbCVzN1d7OKeV/txz4x3QLirNeCT36/4YoF/jWGt2trkJrGI?=
 =?us-ascii?Q?jyEO7ZyRcTdWs0IwXkze35YciY+YWVQ+i5rmtjGCQ3fTMN5E6Z9eYAcbML12?=
 =?us-ascii?Q?MovZGXt2sBJ6hWPkEJH5Fark3lvgAEjw7Z9nNifRrfGl22DDBeKgLQnQ37d7?=
 =?us-ascii?Q?XLGhqQGnQW6Bal8gfgQuP6bFEasD2kIyjLiCG2PBzCYPTOl+lp0RkAXB1gmH?=
 =?us-ascii?Q?Q93VdLj9ZlofwCDGcpDak5SHFG5ZjtRtLYiywICCKbRzJz0iljoP4gK0MEMa?=
 =?us-ascii?Q?b0L1e98AK88amGS9esomOGt7afZNeHAgHG1ONCAI1h2QtQX2Z35iCrjqEpGV?=
 =?us-ascii?Q?icyVGtik14FynVzrXsmm+WnnMgjjhq3r+c02xw91H3x14Jp2YA7D/qqr9sYz?=
 =?us-ascii?Q?mTXe+pCxtC/V4nNKlAaeIERUlk+MU8teMWcOUND7dVGAI+tTg9areAI+7/qR?=
 =?us-ascii?Q?4cI+4/vdwTon+uG6B3rhT4a0Fmgcw/rVduV3u0+0eq/k0kEd+YpVZaIrHlNZ?=
 =?us-ascii?Q?LJ7jFhi/Kfy36l1O8QuPNZXKAh/m8FDCB1NKC7aTnOLaDdwPboppsTDVU6Bg?=
 =?us-ascii?Q?0faQZfGVW0Vp79L7lhOpaG8tE0FYz5Ax5xziB8PlwAxxoXxTbapjKDLsT19f?=
 =?us-ascii?Q?5Tvu6vj8YD4e6psVt2nAClcQ1f8zfG/okt9UDcC4jojO96gkR5wT+dL4GiHQ?=
 =?us-ascii?Q?lx4aD3+JKhoStoJPL4mnmjbVT3HX6q8XJqN4rAPssUpsUWdrQJPkPpWDCkUa?=
 =?us-ascii?Q?MX4H0a4f6ixKqDtiTPdzd+TuuLGyDDf5jxXUWOIWqGAOeXV5QFSpCUaCbyqK?=
 =?us-ascii?Q?LMpMwrECF4ov2Zdpt9INVrNYpXD+b/lr?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?jVrCd+kyIBCS7q/67xBB4diSOF/eAS+QcxwHAAECpSonLeIJmCQzAsAbD3rj?=
 =?us-ascii?Q?SDcbCkQaHAPvM4HXYD/EcGHY3LwDtrzCNStkuKIbAIpFh43k5gDKQtyw3Nt+?=
 =?us-ascii?Q?rg7ID5jtP8ja881RpKxjwf+1AKSbgRgSYNwyiIU68dWIuaCBhft66OnZdCt2?=
 =?us-ascii?Q?MnOHvoa2Hv/cQsI3BB5pAIA5Gpys+ZuIoFGut/KOgR0BIUFHbiyCV0jB9X3U?=
 =?us-ascii?Q?hqvbJWpg3XuEq6hJyH/tKFsZOraViPz9b3lr7IwVWtb4hGfR22OGLQeA20bG?=
 =?us-ascii?Q?+aeasLWJmB5NONJOfdWrlICqA+M/b9iw7lduBNBnrKW+0jldmYbxGI03JCio?=
 =?us-ascii?Q?2E1cVzN8UsP9SjNXV+mwt68qm7WyN1t+jL5HCB6045eYmSIRmU5CDKeKUvgo?=
 =?us-ascii?Q?KEF1rDf8i6UdLiNUtVvpHqMoisl31NnWkUbhIuLAGMj2cccK8nS24kpJaXrX?=
 =?us-ascii?Q?HTg6q2kk+7ixCsFT0qqIgDTQAKiGIgW2FqI/5rW0o5poClFwO0Cch/tdjzV5?=
 =?us-ascii?Q?pn3sHl4URb1G6RA71ZeYT8YmAFJh9lmCgakI1yJWTKn8DDZnthVooykYhEw+?=
 =?us-ascii?Q?Sw1NDLxy6810sGA3aynaJTixrFGU9OgvefKPfZLBdEgz+iNml70nW1iBjxv3?=
 =?us-ascii?Q?sNAjCL1o3DwtRHZ8dwAh5M/khiiMcKiFBA2wGYnayn2jHRcah6gQ4uaI3iXW?=
 =?us-ascii?Q?c3CWmhw4e2yq85xzlLMipSG76VfqUV0U5jzLc5zK+od+BsX158JbDSgdTlXY?=
 =?us-ascii?Q?q45laIvB8L7rOx+GL15kU9tcZDz7InZnHFzsvgnw1BE6Iko/NhpUFMuMYwwa?=
 =?us-ascii?Q?ym7D+HY5GbVdX06TrkTvvfslmo+AYeA3IALxEsCrVHi2PgFutIskrR3j+KSj?=
 =?us-ascii?Q?bT7aRE4KuBgq2PmzIbrVeXTo5K/QH2GDRKkpm0IKNcRdxe3c0cNXOJbz2VQb?=
 =?us-ascii?Q?FmJI5a6KpPU/ZhBgBSzkoPkAyys+HEv0JkpzZ9Dp6xKzZGcBtcDee42/cgjr?=
 =?us-ascii?Q?buYsbEYzXpAkN/T4cF0Cz4sQ+pJRjYP3nTbLhkR/SP9DkZiuNRug8QhqUIze?=
 =?us-ascii?Q?qQtFGu66qYdZMV+FyFW64NEoC77mVDDnaiaQniV3HKhF9G3jy3ae3hZB6tXd?=
 =?us-ascii?Q?hZVCEwTEjvs52E/x8wXJfmelga3DSX7TilbbN+A5FTQNhJM6gmGOT6rK4CCo?=
 =?us-ascii?Q?8RwyQKfMQ7YAzLv3YCByzE2Ljcv2oj3Qvhx0KyYZopq0h0F1Mm2yM8tnk3k4?=
 =?us-ascii?Q?ZjA/jYNbQ9XIy1q6ydJgHCB8Kanr+LJbTNHmvOskwF0bH06CVj9P9uJt8lYw?=
 =?us-ascii?Q?XiEBC/lio2JT3QKvaQeTAsu2F+p9iy5sXtCsObxcbISq1hJ3mYuwCQmG7R9U?=
 =?us-ascii?Q?wp/uSpUKIAbUHsJVt2NLWUSCreEpYLJHzq1p5fWu1F8pnAqpdGZeq6ZOAfrL?=
 =?us-ascii?Q?rHq+eL6Enz9SaIAgKPCoamfqHMB69FNww61gV8axSwmIHONmpQmoQrbUbjBi?=
 =?us-ascii?Q?TDBDrq3PJxdQrBDEcVFz/npsLyvIyeucRAX35OYLVWzNkSJwpFPc+rAu4Fph?=
 =?us-ascii?Q?WD4Z5XcuffoJJdM9PV5Cwn3pCfxV6jtDDY8aoFxV6MRY9ODGpIp7MQHSrTB4?=
 =?us-ascii?Q?Cd5a3eGI8NpegogDEqF/YI8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5d3ac9-da33-49e1-93a6-08dd61588214
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:52.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQygXUOqntnURYqNACuIkxvPBp5mTM5lPSRPUXYv2k8e0aJPLm22elBopb6Z8/t9dyuH2lrS+qbCX1SX8tGdPJLPqYHUH2E4GRmr6zgTHOHpSbqEXSBZNO3Cal1Ao49H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18118

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
---
 .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 37 +++++++++++++++++--
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index 235cefe60f5d..7d7e66eaabf1 100644
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


