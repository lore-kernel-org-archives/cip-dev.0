Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76143C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 10:17:00 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.0])
 by mx.groups.io with SMTP id smtpd.web10.4360.1742379409972823433
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 03:16:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=esJyPEZK;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.0, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+ATQ/1We7E7J95+nd6OdnwbdSL8bWo411VwvsDOwopQ3yckDXczgXYl9k7ioEFdpErPxFY2ZSZSQjj5vt4n6ldT6Up1bnEvVCIAldRPYK7006IhCWpOnG46/97bb8HstE11fa/sC/xlyKMdYyegsRWbSeWEBI7wXNjuvvZ47eTYb7urQXXNCvVyQKwtRRNllys3zLQ/4DIj1RyWi7ZdnSY/idE2Fu09V1Z2IS9M7DodSQTCXV8MYL4qnelUVQViy0OBtZAWul1nEktpmJg6nxNrRRzc997tlZ9JarPQo7rg2Rqxq5r5xa3c2+PsxdTYMXW6bGSERkykjAr7SQGj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zki1eimhI07LFvVe1eVoILb2apkDJOQfhIWN70wfOdE=;
 b=rUtY8gfCuRL0MgeU3Ls7FA6ehoVhC0D0y8d6GWfHYLBN7AosB4FbrrdBbC0vllW1bgi+45UKyqr3SMYOK96ZYILHcPHK6fXVlhGDvC33BJYYUp2h0z8RHSD5R/2ner7S5ayWs+sxqf67hvzWHujcRIKSb/CZGUGUi5nymzZCffou6OGz8QT8Wc5P6ocSRqSbZLuKExFoTLkjoCKSwSRzDBW14ogqaAq60bBux7ZEWOI8MR+Me32uz8pkm5IJM5YpN9S4+hqzr6nvMbZ/7UwhrhPx5RQl240CDvJLVvH/usT0cBzDcw5xtTKWzd/8sbNlKREozsfiAgi4jwshH9PYAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zki1eimhI07LFvVe1eVoILb2apkDJOQfhIWN70wfOdE=;
 b=esJyPEZKeaJ4whWkQ/7ojhmNsA4i9CaiXIfKVz39xY6jHQW0yG+9oOw+XShtcNmI69OehrANW3iWpX/TyT5cwS3klSivMtdZIaeNcjj2f5as3LCKZi89OD9a9nUy6GH/ndduWp21M92VzyPwOIVq+5bSCC+dhdM7nA9OfEkFuxI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB12680.jpnprd01.prod.outlook.com (2603:1096:405:1b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 10:16:48 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 10:16:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip v2 01/12] dt-bindings: serial: renesas,scif: Move ref for serial.yaml at the end
Date: Wed, 19 Mar 2025 11:16:18 +0100
Message-ID: <20250319101629.2407727-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319101629.2407727-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::12) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB12680:EE_
X-MS-Office365-Filtering-Correlation-Id: ab02887c-9c87-4dbf-02df-08dd66cf2893
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?quCdN7r5GDFVaCzOpQNxHQNtsYPY0GJEF8jJxnwKjt73IhZ9mdM/nV4y2pcp?=
 =?us-ascii?Q?MskEcUyd1bIsIsCDXGaaAHrH7e0jXi75SAjMgJ5DbFbFjP69hE0l1J4biymu?=
 =?us-ascii?Q?FMNj+UV9ukfnFdiwHlWIuhi1p+RUhMbZSiggmAUWrgjVbONXcpoTTxFwt4vm?=
 =?us-ascii?Q?1KjdHg7/S6Vu4hpJzdZ8shTwS3fchMD5rjwMJR0BY77KzGDmi0SiQtQ1PG38?=
 =?us-ascii?Q?1kWF+xmDwLje2HRk4mlzpuDVPllra7YF82W1YDKKFePY/i72nICFVyfLDr/z?=
 =?us-ascii?Q?NjUtUfoi38HnAnSEpYlhgVPfOYEubVwJ/nG4F38zKpq3PbNLwC4rMnZPqsjo?=
 =?us-ascii?Q?7j6iisyugE0uxEZ202j1/gJIhH0WWRVK4A9W6o4qoffHkjtlgybv/4qOgt7f?=
 =?us-ascii?Q?v7aOtccxXVAw/2hahqhOxxKZP9mWIefu9pljfj+chjcBI3KZ05hq9Cdi9LNL?=
 =?us-ascii?Q?xLxGqlrhD0VkOlepZLn3jgFwt5Z50cRDgumLKqzUCwU/yKOywcxRy2mDCPAh?=
 =?us-ascii?Q?t4/2DDvOGmcWBLkilnTczmdDuGjr1qPbl0HdcJ8Sd53I2KVPugdi301E8Dqg?=
 =?us-ascii?Q?ReRKdXvoURRImO+kp1/7KLWm4rELBipIZwRWOZ2vd8HABhALDuRQEIk8/BfP?=
 =?us-ascii?Q?sE/VZ8wk9DccdQEdnENAws+fTT3KmqkPBZ1wWkAG44UX84tx7rGD/eg2EbQd?=
 =?us-ascii?Q?xahxHBiUUR9lWtRjsbmQ9pLgBo/yKRTj1aKLhRIVHzPhmBEB7MSlS/7zbrHT?=
 =?us-ascii?Q?iG8kYrUQy/m+G+iAtlV+1tgtBhlZ9cYyi+o3ibsHvgGXb9lIBzs0LK/VjlWm?=
 =?us-ascii?Q?isXMshTWJu6w5zaGHnQoacWX3PBjoIu9lnzz37OKbkmKYGfCLjoiq5bBs/bi?=
 =?us-ascii?Q?bXOC8scsD6eWZYQmtpYYhp/c71bSmR8j7E1eysAVsrc4web0Zl/NhmYf7EB1?=
 =?us-ascii?Q?dZcIvx6Ko6XtxJLneOKW3tAzi/29OTF0LyTNuY/GvxznDD7mpQrNrmoCvG8A?=
 =?us-ascii?Q?zfFPM2tSE+AhLUTTb/RqbyqhH3kZNYD8o4RBt213yEUEzNc0vOKyJXhuw6oQ?=
 =?us-ascii?Q?iDJN89AXtcSiSKJskJkUids42IvTqi2a+E/dgC2c+UvJfuffJmJuB1E4tx6G?=
 =?us-ascii?Q?gvzOXMFJYHeO4gPexLsfFKTS+ITjQEqs1At2aUXefSQr22TbJKYB11Bvnjcu?=
 =?us-ascii?Q?ztgpyY6fFIYxAryj/GxuV7wZw6WkIk0liKjObNPtWZuedx/Cz1d1F7dgxwI5?=
 =?us-ascii?Q?LUHunJ2SCRPsdznne0oR74AyaqyMM1i8Qr5NnN1z3/fdt3Yxkxx7O0Awpc7N?=
 =?us-ascii?Q?tZVMjCk8XLjhXPSM0tiQQJwehL6+lbsa1UiZYWWYnhfNQbOmvxWflSG1u6PC?=
 =?us-ascii?Q?l3Ocwa7U455GsSASHQ4uJo1XT1JAp/HTE4tuEZkZr5khg+Tauzr22uGtXR+h?=
 =?us-ascii?Q?m8YkE8bvs3rw+wMzcSi+BwPqlVj+oyDl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?H3WyfiwXa2zKSOr98qohRl7C2c6O2fA18uodklNH/wT+UiRJO3xxFKyyRzdm?=
 =?us-ascii?Q?AxJiVSPuvxaxepUDv7SFSI6jH9I0ZyAoLPyOwHsqfE9PaiIE4UtObRPpZ9G+?=
 =?us-ascii?Q?bioLDKO2F1fxYD7rKTl8n7gGq0XP1Z3e5F19RJzblB53QxOrq5S3NVRCyRYN?=
 =?us-ascii?Q?ikW+uflpEPjt8Z5RnDGWC5HRBKm+G06DFMHMlFJkAjYhKQJI22bXZfLSu6tn?=
 =?us-ascii?Q?TqAfIV0SOmvFHTMec1auC2FVEullifuMP+KASjrIVFFzDLevcd1RSrK+JiAQ?=
 =?us-ascii?Q?AxyLA51rMZBYS4NcVVTO73S/K/YrpB+0EAnP2rQ+aJKEcAQPILWO+NhIHsNy?=
 =?us-ascii?Q?w4BV6gTSgCofC3mB3RxmMoemAY7Zci5SfCftG4nKatJkfRp0iYI4qx2Y0fN5?=
 =?us-ascii?Q?H5tCOU329oUkr23rILL3D/r+4fQ47LFvISboFlT8TjqYm/RYh/kphUuUECP1?=
 =?us-ascii?Q?F+rZwg2OVY/Fd8TPrnDq1Un0iPa5za0iWnACuhQQFAeF0aDV/NjBKSP5Vmzf?=
 =?us-ascii?Q?Q4PTNbhzKz7bE6MeoFpVM4W1dhB6xENrjPRiIhCWBYBLVr2+uaE0WBHKFVHF?=
 =?us-ascii?Q?PDVC8psk9Bqdy40ZFW8BstTHR4dKggs68KQst9zKOM6V0jjPLWehFPOgL34c?=
 =?us-ascii?Q?ZUcRIeF/CmlVJbxyjWjOMHxvhT8w49XJedaU2wT87Z7nntP9HTWdrd/yACJJ?=
 =?us-ascii?Q?tI3g6nAAlutE944+dSXgFnaSoooR74tzA0ibSRKc5Cwk2JXWVBkQ7+7j63KB?=
 =?us-ascii?Q?8R7Z9T8gQI6R7BdAYgGCEU1XHKl5oaSKpYfRHjMjIpHDIQvlzkMT5fQqOagV?=
 =?us-ascii?Q?q3ML2rG5aWxJsFvjaWqAORkKIvgTmKyrhUros4CzRe/X1DWAOmOOOMHKplcQ?=
 =?us-ascii?Q?y4vQvUSkU0MiDXsTU2MT6HvrOVsFvGKxmORnwiQIrWxlpOiZ0b9oN0RX9+zD?=
 =?us-ascii?Q?j3NXoNvJPqJEHmcaideBGxNZ36/60IJ1lv0LIHUuCnSkPUKDj++1VZFpqamj?=
 =?us-ascii?Q?rA/5hLwaAWFTT2iTBIVmk6hMEESFfWF9ZOXwf/uAckzMaid4/SHfr+wP15dD?=
 =?us-ascii?Q?x2Ry1sTRk37qCRTp54URlBNA2t3VnCbdUXCKL8tO3vBGNBL+UQB7it1sDu7x?=
 =?us-ascii?Q?R0yNUqNIctoa4gOt32Y2aGprvw+DEn0Gh2RjEtrVTFYT63FvehIETdFxH0t3?=
 =?us-ascii?Q?+oLSKPR3QHvA77mGO5+r5oX4V9K13Ire3TXpYU1nnF05c56ZpiXxLx+NiURU?=
 =?us-ascii?Q?Q6h7wfPgVjUcseMGRK1wf0E6c+Bvno99OJ2fxr4c3dn0famfIrrvuxbL7WGV?=
 =?us-ascii?Q?rb2+kAyMoAt+M8ulim789oqW9nmH1llDVNi8Qk5xmlyZXvYjn+XOCzbBuVqL?=
 =?us-ascii?Q?3WIQEudtwXS8mj9HVLYoiKuL7PhLzVr5KnWorZlTiXT8KlhabJl6Prtht8o2?=
 =?us-ascii?Q?MKFLbX5mN6f9dK9XgLgapuqkXGtNYxcbygAGWn/OHBpXtEFrRjiNypS8RjMR?=
 =?us-ascii?Q?rU+TsP6D8cNeVQReIY/ruSqtxK1lEQz2IztVnJOYuVgbToItbmbAaLbpfIRt?=
 =?us-ascii?Q?RvKsF49TrmCsO1QF3P70mM9a8yhdEuHwPHISGls2ZzC22XRkr2pQtbCuBHOO?=
 =?us-ascii?Q?hlKkAlU3rIsU809a1AfE5V0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab02887c-9c87-4dbf-02df-08dd66cf2893
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 10:16:48.5286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8zrrd6Q/KjV5Pxx4aelzWu1gI1WK3W0Q9IvLO9GPb4sBc8Sgxkt4I82RAcQ1GpYrhpsXrAoZNZZnA8vE930+bzxM+esjX3STWBawMFELqzyUdKzxlLI3brxBBJinzVF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 10:17:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18262

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
Changes Since v1:
 - Added missing Signed-off-by

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


