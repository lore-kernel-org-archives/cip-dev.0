Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A9C7EE33
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 10:28:09 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.38])
 by mx.groups.io with SMTP id smtpd.web11.16542.1750674479269778632
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 03:28:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ax+243C/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmuCeE5pCcqK2Qw6Fb6J0XHW6IspZ6GqURmD+/Lljc3kOfpFteNvkGHCabynac9DjlZnS42gJGVA3i9q1gqvxfEtvNZyu1XbnV1aIkBgXoEQ9oFUep0e1jYOy0qXHaoOjmvmnIn8N6ePcsXSMoM9wO7yQX4AkHtsBQqOOoT9beGzeaPZRJAEmHSz7zfnXE674BudOYLGrdC/wRkBlCM5sJRzyGamXW8esKS+ZdRLjYSxP/qbmvO2alPvfVlSaAhQXLb8tg/p/75RHdd9dH1xcTqx6x1kAry/oW+j9NqpdPbm4wA5vSLFlAHlSMHrl10rTSjhejzui86yqxlLRyQ3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzOZYuJAfOTJAKI19+dNju6i7zqekXHy/4LhyHx026U=;
 b=EvhuFeRyqUAZLa+7AUMnW0iP4FUCliuDHMHDi5HZlV6vCNsTrfOj8XXJ3R4mkHQ+Kwuk7rIOIFqNWKaxpTrzGBquHjFPRZffiPgY9ap4oZ41LQKWJ+Gewl7gj3tq1jOlq/nqyIZgUesZwr/Mt5uNDzbGzAPnKcsWU1d0nZc2ZdxfD+Q0bXr9fbeFqKZu26+tQLVDGJdDXauiBUIv4gRiqaFsyRwJmJpDIE1Xbr6S28j2f13jcFkayHcTv2tVGNZcQCEmtCfYObAChKvbmK7AD+tXy+QZECpGmT3FMvUwZzS+0I85gqn5i09YAYJfMwDeAkXkB5QW8x4z08HBYQAqxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzOZYuJAfOTJAKI19+dNju6i7zqekXHy/4LhyHx026U=;
 b=Ax+243C/SxkPXMJnAMqweW6Gd7/lCAdVxEUmea4aXFt0j5b6C4BtrYlbB6vpJRw0ElAqk7YloLmn08GAFmGuQ8dF2dhouq33ndViG6z9cN0FHxJcSXHdYa9R6bzvVWDUc8VhQghIVSbto1+/A9nHaJMvzAIy9pi6o+YTEx8+07Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS0PR01MB5747.jpnprd01.prod.outlook.com (2603:1096:604:b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 10:27:55 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 10:27:55 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 1/8] dt-bindings: watchdog: renesas,wdt: Document RZ/V2H(P) SoC
Date: Mon, 23 Jun 2025 12:27:23 +0200
Message-ID: <20250623102730.1493286-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623102730.1493286-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0247.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS0PR01MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddfea8b-1978-4125-d556-08ddb2409df4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2vtxmOGsMGPn3KViovhxKl1jCr3hXT2RJwAiT/CDbEJUUzSKHKiKHbBSe6+B?=
 =?us-ascii?Q?6xz79If5oXjm4xN0SQt0qETJ42yMdAqNYp9Ku+YOKfEsxp/T7WCmkHRaKWy1?=
 =?us-ascii?Q?323dUj8YAs0D2rum6EoWajISI6zjRG/OYZi574wd6m32KzHxQbLQfLPTyiGu?=
 =?us-ascii?Q?ID0XPkLQvDP5cJ+pFLmafbvXByTVqPWW6UQTC2s+t7Y1kbLodwoNWIPPDOwZ?=
 =?us-ascii?Q?38KsvMZDezIuoynKrxHfJNuJuxh8D6igRbxBbbhq7JAfLOOBSw84KQglMhYg?=
 =?us-ascii?Q?7cjQ/UEdS1ShX5BkTObhH5CjsLgFzpRN4qhiiH2gfSenmB0orj2n6HvDtJvH?=
 =?us-ascii?Q?YDWrT3E5g+wUQGef9r70tYv3DR+UFr0CJjHaxMd6CrbuvekilrZmZxC6EUvv?=
 =?us-ascii?Q?xPLTBk+Y924CFviFruyCxN4UqfgvI9HwkMn+A5S16JUYb1ALQ393ewEZZ7/I?=
 =?us-ascii?Q?mrYURDksi33s2GFA94M5zbj6qVUfGxN8D1qUa9GcwV1lb9J3WEvwuQQDr/7U?=
 =?us-ascii?Q?wI6DRAj6IlS++ioWaFAtAW2Kxzg3hFcBamlTQUy7apfIQmGANAkO9yoHR9bY?=
 =?us-ascii?Q?R1ANsEO+zqD+JMXqAOHIiMP1/06gGFtmnorVjX4frmJQp93AAihm5Z+0arGU?=
 =?us-ascii?Q?rofEU2uqf/JW7/R8nj/O6y6zIrk9Sh7OvODssa9oNYZEpsJavnURNke/zn52?=
 =?us-ascii?Q?D6u8To0w8kVji8qMPfqXGukQ0Xa0T2tuGqMQh7W5q7rK5XmZJRYfGQdJdLEh?=
 =?us-ascii?Q?wxfuSUnfq3TAdHJkJs0u6Bua4NCeL1BxaamN7Tkab+KUgpbe3xZKZEA9hduU?=
 =?us-ascii?Q?xOZT3mRYTcsDRMiFZ4t5teGa1S8+91PqpPwwU+bxWzN+ie2jA1+XL+qpkpXF?=
 =?us-ascii?Q?sMhc+CBV9EAUc0JYpog0ELSIIjaRtcMLFwzGkHbtN7mYv+FGMILt3HYzDa0u?=
 =?us-ascii?Q?xBkbKL8O6ikts/cjpPkgV3FkK1PognmPUZMlAc4Jl68DZP05/cZbGWjgiwDH?=
 =?us-ascii?Q?qLXfce/k7h5Gjjfe3Vm2aEfOQQxuxtSQJKMaaymJBefH1u5jYaFFiscZyF00?=
 =?us-ascii?Q?M+a1Mdm8xums2jCTidag1niFbcqTQyEL8Ed/JpGiIdn8tnDTQnkZmvEpsXqQ?=
 =?us-ascii?Q?jZGigpbkMbL6CKS+UwJ27+V4oyFwsrEyCY+bSV9xVAkIJGCKzO+SGCmE/DBF?=
 =?us-ascii?Q?1xpzewJEwE18+bH9YvK9kG3FOIko/sNx4O0ExIwhL44+x/bX3YYGPOvEea5x?=
 =?us-ascii?Q?3qIWJba8YU865T/icsjh1fzE5iq35uspZR64icdnGLuEIsdBnmyCcBBC3SsA?=
 =?us-ascii?Q?87KpstA43CGkNWWRbzWXlm2Gq8HZP+tYprZ+aP9Ti5oUzHYMXD4koKRZ8OCE?=
 =?us-ascii?Q?GtSRv47uEfuLeCnvLLyTf2X+cmvFlK/6bLJ6a/DVrh8sobMIHgHmpDsRew7Y?=
 =?us-ascii?Q?S6dNWwZiiQnut88kAHnjX7kKWwVuCfVzvDxw7ONZAMAbDqqmo+/vK33C7YwA?=
 =?us-ascii?Q?OfT5oCij83UL22o=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?TfPOTpaV7najRZP+27KwnZxlol6k17xW+Q0HDChB8UZQKupq0FRziJwo71h3?=
 =?us-ascii?Q?yCtuvE7g5t1+L8XsnsKifr+LjRRGFG+buLyLi+Qcx2E+7YuHnGkvhjbjJUkj?=
 =?us-ascii?Q?2hVd2XiUC+PVm2MfHKET2sRdrR4vxtto6uG81FykO3mq5Emj0aa64P6RM4Qh?=
 =?us-ascii?Q?atqr9dWwzNSsiCFjHkePweNMlRhU6fGfCx3AOdjrYdKfawX8Ze+ZRTdVH8Lw?=
 =?us-ascii?Q?0nkEGaWpveTKCv0z7ToiqD9BvMAXNNnMJ6iXc4xO1d6MlU3UtK+2eHMQQ6/l?=
 =?us-ascii?Q?xVTSBBx+d5XhXL2SF5GfoTHT6seYEAFG8gcrdBocqirpfbazsGjg48jgZ5L4?=
 =?us-ascii?Q?mXWAE+1AqO1VCaKmOsUYikvRZVxg7oaVrNkGgXpfRGsJ9hMVFADCIiLO64Rv?=
 =?us-ascii?Q?9G40LnbaXo65NovaectmNyvcB4kQ1D6R0/SyrQdlyhApYcK6T+yNorsQ6Sds?=
 =?us-ascii?Q?rb46mH89si0zsvkg7jaD42y0UyA4n6SPQl23waTMbFVdH5rfYDfqaztCEEUy?=
 =?us-ascii?Q?jF6rj9+6RnZF4vg3KCJcQTlveu2J06J63zojE6klTS/bv4qkCHc1s7Wt4IcL?=
 =?us-ascii?Q?4Chxo/82+AS/M4J5RUwXmdLQ7yQRsRMm/Lvk6D0gUM6CSOovgvhfpg9J9VBT?=
 =?us-ascii?Q?Qvvs4siVwbKoUv407skCwDpxIHLWgW0ITp8+voy/UjQCXsDfPR5x0YJkXLq4?=
 =?us-ascii?Q?OGzlME5OlUXcGOyDZWPziXQZ4j1WfOIxzwr4gcMDLKWzRfPzvf+f6H9Iu/3m?=
 =?us-ascii?Q?/hlLCtWKHRBXslR5LKz1wfzBUtbpM/8MgTEBgeWbbHVuFmXSvUkixSjtqvzz?=
 =?us-ascii?Q?UIXXShphrE25HgtXYiDdKJ35E1f5Aq0IkYMRj1iv37itIjnrgLwPoR2Amk3h?=
 =?us-ascii?Q?mWVFNQQCWz8LFeGIOYpI8ly7UruhSFZGgqu0V94/MO/Fd3L/3yZnmaqME7NI?=
 =?us-ascii?Q?v0enLuI68Lemk4GkYqfk8WnURrfZAsC71ScrFpvdK+cQXWu7vUn+Y8NEfNEN?=
 =?us-ascii?Q?IPW3hvdpGqhQ0oA94Yf2dldx50KLFGN24RqmTltzXW1+ovVR/7deZ1yieepZ?=
 =?us-ascii?Q?CwjCRIsNwX0NoQAC1FAvqF+Y3cjvTZEv/d9fBW3OuQAADgz0LlohW9KIU64/?=
 =?us-ascii?Q?nJ1inSiMb4WH8wbgaWkPiheyFYCNsZNr+o1+6OrYZBPkM70px/CRfblWiYlG?=
 =?us-ascii?Q?2qrloUIFUKRivWsQqaOjDnpPyrr2KAPShTMIJO/bVwhAae7EAxeaJiAhLHAF?=
 =?us-ascii?Q?Y1Rfq7KriCM5bMFvTJ9Xoezw8KBeJlpUSz0Orm/tLotXiG1z3O9UwgJFAp4m?=
 =?us-ascii?Q?V1UgdEGDIhvJPkP2QcTSvh1HteeHAogGyQzoT+I48rtnNkFs4Vy0H6fv86AC?=
 =?us-ascii?Q?5kACtdio2UkMvl5v0uqFX6HL+Cc9UH+O+jLw4zQ4OnADgYBO8hiwhXHi0QSD?=
 =?us-ascii?Q?nuPJ28ELDRMOr8opUPadErI99ZFmHiO8yVALw5J8AYCzuBlruG4Bgo4VesJQ?=
 =?us-ascii?Q?ECB2Anlf45CKK5DjWScAVV2cCvkGgLrE/i/1qlgjSztP3ZMPE4EtALGls5JE?=
 =?us-ascii?Q?1NXVjTXtLAVzKenlt3/TA/IYVvRIsjpzfQlaF2WOM3lhDaey17lnux2CIDWE?=
 =?us-ascii?Q?QDaLW6sL2E38j+u6BSLgRG0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddfea8b-1978-4125-d556-08ddb2409df4
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 10:27:55.7588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uxunxvyv0D+jlULL/CKAM4jENCNXrE6HGDefnibgyqaaE9D+H5CnyO0d2I2LAu1Yvi/eMX456+15lH7qpCBK037IcCe8y+7gfiHCR2z9jjRqqoi1PGVTyUn7ivVK2y+Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 10:28:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19166

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 892067cda23d02e1d5c4d90e504e9c8caff6f21c upstream.

Add support for the Watchdog Timer (WDT) hardware found in the Renesas
RZ/V2H(P) SoC to the `renesas,wdt` device tree bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240829193831.80768-2-prabhakar.mahadev-la=
d.rj@bp.renesas.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../bindings/watchdog/renesas,wdt.yaml          | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml b/=
Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
index 26b1815a6753..62ffba8545f9 100644
--- a/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/renesas,wdt.yaml
@@ -73,6 +73,8 @@ properties:
               - renesas,r8a779g0-wdt     # R-Car V4H
           - const: renesas,rcar-gen4-wdt # R-Car Gen4
=20
+      - const: renesas,r9a09g057-wdt       # RZ/V2H(P)
+
   reg:
     maxItems: 1
=20
@@ -111,7 +113,6 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
   - clocks
=20
 allOf:
@@ -135,6 +136,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - renesas,r9a09g057-wdt
               - renesas,rzg2l-wdt
               - renesas,rzv2m-wdt
     then:
@@ -169,6 +171,19 @@ allOf:
         interrupts:
           maxItems: 1
=20
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g057-wdt
+    then:
+      properties:
+        interrupts: false
+        interrupt-names: false
+    else:
+      required:
+        - interrupts
+
 additionalProperties: false
=20
 examples:
--=20
2.43.0


