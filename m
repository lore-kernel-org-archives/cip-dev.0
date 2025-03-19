Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4C3C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:48:40 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.2])
 by mx.groups.io with SMTP id smtpd.web10.4019.1742377714365169766
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:48:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=La7/At4D;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.2, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uY/8T4IWoGtXQLnKuwrgnlVDV3IwvigifcEDp3YEXfuvo4uHF6tf2wZ3FP50e+2ul0K//NUDsr6JIeT4l6y7YMYdiSZjxwk9xLOwu8LyQpdqQaWyw49Mk3lx4ExmPXRFpdS051H0mFMAgYWFid3J2C65uB5pRock7v67m90kuDrx7NzmZFlG5/pnlXLTQE9KJ0EUcEm7pvB7w0RJlXBjcH8tOP1E89898stDLdoCgLAZHZMxYPY5m4F38c9xE8csuTsUJvpN9PQ+Oo4+kUkkwNQ889RCvkUJpaNY3Yhn0wjOg4pXmB+eYk2mLhb71zqY3mQP3dEWyfSrNOFuHULsnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKyo/VTEMUDsggB6jFLZ+eQTpHKATc1TDdcpHKTyg0M=;
 b=yCE9ltRVqSssQMUHLer0pKVI86w20EMRn++qVg5R6IEf7mOCxYDiEpL04p2qiyiNQtUWF3gvX12huLY/qzG1OzUBfoalHZGxr1fl1nY46XUitdllts+LRAepf9pD8FQjI5dqS+DQL+qFipEE0S7xNK+vH3D4MNbTMM6Etkd0dlDCdk0J3Sy01yv3Hj2kOmoJgVj5I5jaT5Rs+e2lXpsSy/gJcL01EvQpc2tA+xewf5kQD6eBvPX3UsGKubFJk2SIwOLceWty/03NbbuCYq/4970hIHy81E1lpbFXICwOlgymspSxA6cjLCBEKVsc2E+AKGbypu8uw1W8GZ4OXUrpUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DKyo/VTEMUDsggB6jFLZ+eQTpHKATc1TDdcpHKTyg0M=;
 b=La7/At4DKXKdmiMmoBVp8RQnGFbaowYrSRoTUxIUDAmODADP91OZJoRq/ezUZl8s0R8Lq+0/MxS1OgGhlmaQiFn2d79wkBlkgZE0qF9ZeRRkzFc+I+XXK77kQLiqUMzNy7tXI/LF0jIaizNy+Xn4qXMvFXrZPR/l+5F8nZGgOQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:48:34 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:48:34 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/12] dt-bindings: serial: renesas,scif: Validate 'interrupts' and 'interrupt-names'
Date: Wed, 19 Mar 2025 10:47:44 +0100
Message-ID: <20250319094754.2404386-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: 2edc48e0-348c-4a7f-f524-08dd66cb3696
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KsQAdvTRbJEguj5LV93pvz+n25UAZW0zZXmSyRkOyHG9gVUANFk+zTC1WzPx?=
 =?us-ascii?Q?UVs+77998rm78vROu4Er9ZS+7TBgX2UWO3rMzJukG9ihC5Wf4OVFOUkEF33c?=
 =?us-ascii?Q?mXY+M1XDPozLacFyNVkuIb4qaZ08g1oHQpyGhYkmbBtgDYVig8CoNrg6ldSW?=
 =?us-ascii?Q?AnjMIGxOrj7TThunGd4Nss9+6khoz/TFw0W2lzR/jtZqaexb1dwHa4wsGscu?=
 =?us-ascii?Q?/Nu8sK9zC2VVS8XbFx3GOHXaOaFuyDTOUcY+aQXb+OW6Uw10Qm8h9gNxZKHs?=
 =?us-ascii?Q?XPaO72yGMSWWEcB95WLNONlizb07zOyVb0iTl73aVRTDXmfAxqr6POE8K7h1?=
 =?us-ascii?Q?5ETdgtZbzw5S5djc5Qm8Jv3LnEW5MsvNBOn30pzY9sYRAHr1lMAwJIEtxg6C?=
 =?us-ascii?Q?1rpSndCuTrc+KdzSk317SLydL/iUYaEp2WGUX5ApVR5xbM0QaM4OeWGJWqBa?=
 =?us-ascii?Q?VX6DIZAin2OjHGd0cQGZ7d+zRsxD+EO48/GEAHaZK+Y960p9+z770dtDctsx?=
 =?us-ascii?Q?xirF/M7ywiOFaRtwuIfwaoZz0fuDM4VI8DFiAXhVG7HjySD2uco/9QewHMgp?=
 =?us-ascii?Q?sPWBibHb8/JtNRDLLJzlLIhzcOENtYoiacNQnBX+qRzTzd610iyCY8Rh1hcS?=
 =?us-ascii?Q?pszzqwRzm8MZtc29mt3+5brXPs/UYzdWJAjdqiiYKI0DyRkK2NF1SIvAgunD?=
 =?us-ascii?Q?CGwrB489u3I+GkcACArXRabZojlGOranFZkpzTffWFlijGfByr5qw8OnE1dH?=
 =?us-ascii?Q?yh6hRpwPlpoP9b4snoGUhoSyQuDQA+ca5X4ONKmvgqAYISbTRzAUhnhqe1kI?=
 =?us-ascii?Q?101qWSe+i1ABzINVcttYJedTnuJAmsYIwCkbHx3kv8kz/NiPxnN+FW0L3+vc?=
 =?us-ascii?Q?61v/LqICdfZy3VmHNy0HfoJIya986N8RdrzlvV+PQ6IkDeCUYZEQ6JGMl/2g?=
 =?us-ascii?Q?janXzeqxhXwHVa8+6lyY8YpP1ryRWIe9i0p4kbJk1sU/eEVKGArcKyVWZvCV?=
 =?us-ascii?Q?3Lun/NR8hXwDaspd0o5WGQ9rBKQFb+HupmK5EyoRbscF9CZ+iV1QwwX6Af9O?=
 =?us-ascii?Q?FNw8NwJkU7ynIg4q0vyhwYSeAbZXT/oB7/RRHo2rzEsvz2hAl8qAiSfZYOwy?=
 =?us-ascii?Q?AuYVSjWlzuFS3ZVZg09kVrTzGvRM5Q98Z23tdohoL2uO3P3gW++K+2IrZdHr?=
 =?us-ascii?Q?xNdr31XkMzBc6yoXKbo1EiJghQeb/ryJB011bSzQszxJO0w/aiwEg6SKDdEi?=
 =?us-ascii?Q?2IOEMky5r7Wp9ytvSfwTKbCo0/Sq/msq2clxfEz+GIfooQADRoIAGoIeJdqF?=
 =?us-ascii?Q?FnC2HAPuxOG1Kh5boenaj1fSFLFzmhvM5UaVMqCXMw3ndBLLml8dtSmJxXUs?=
 =?us-ascii?Q?ZOBmrG1N+0CD8JdiQGbnaZctiO/cZKrpf7/3vqfa1YTjmd7RaLO/kyCRbc4u?=
 =?us-ascii?Q?iJsjfwEcplYpce1GfGp0pU6TvOq3hRd0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?4enNMRHVqYwxv8utOeHHBKb2qmPgMew2eMO3mNo1SG/tK3ZIhW3rf22VTqnC?=
 =?us-ascii?Q?wRBUDK0lwb2Su8GIQeFeV4BIaC+0ATEvVNM2t3AriJFQW3T+VYRzRJ/iqE5D?=
 =?us-ascii?Q?LER12KPEWPCDcW5XmNJcW8Ut0gpF8Z/9OegUB0F4BK+4byD7FemjiDKvuDac?=
 =?us-ascii?Q?4269wMpMP1OxLqH/7LKF+zu22fvXO6yHCxdfRuME5JchzeVAmdhq3g18XOCa?=
 =?us-ascii?Q?94dFsr+C3vpd/XXFxckW3/YbarWDhzIsPbB0oRNUDc1cTi3kj0scsU1FCWea?=
 =?us-ascii?Q?Y4b2cfMyTnlQG2yF6KAM1xJN7MPfRIUlkDBeS8Mo6dw2IRoTzXo8pQc6iB8d?=
 =?us-ascii?Q?28pkaov4TaMGNvCRHY1aosLbHC9ydGFmU/c4M91R5mFYkbAbliJ6kwkYIXYS?=
 =?us-ascii?Q?z2+WFkt5DbJt00oDvH1Vxb+4sKF4Ivp5xksMQVGyGypdyYcSkc9xihtssAA2?=
 =?us-ascii?Q?3nrUSGKkKsR4gTRjnFmHI5QIU0vDugf+NS5VLTzW7NHh3Cv8RzarhMA0kJt1?=
 =?us-ascii?Q?iz+X9XGxN9lv9nAeoafXD8sSGPnSUzy+bT210HQCU/WM5QmksPwcBlXv6idb?=
 =?us-ascii?Q?3WdMUN6NuEVZozjwjlUW1eoED7CSijZUxdfMIAKV72ForviWYS1t4p03hL/N?=
 =?us-ascii?Q?SShzMWMGVDV/I/sqdtwHrXrRLbskeCsFzcMw/wmmwWswrc4rCwq5HhT1wvji?=
 =?us-ascii?Q?kdF4cR33bE0eBDIu7+8dySqFXPusikxI3yt+2aah2A2g3VYoMdAWRaBrlcZB?=
 =?us-ascii?Q?VmH901LjApTUmgAYP4dZfBEpiQi48zdWgqaXidhFRe047J/hC+64Es3dm6MH?=
 =?us-ascii?Q?zHnpHM4l4HozUi6zmLdomUm+mVWqDFYlZMo0bl/CaXDIpssKQt30MVPjH8/O?=
 =?us-ascii?Q?wvg8bI0DSDxF2yXCRllLC/dvVDq+Gu6uCeueuYaY60QlLTFf6p9ywqkzwGmt?=
 =?us-ascii?Q?n/NTEITjTHVdPgMukmSRk2I/42BQgA5TsFC10oYptkdCGIlTsYBm04to2HQy?=
 =?us-ascii?Q?D2usQFXCbHrCxVASdxxsIUB3qEFtKkNKA/EtDlm3UyyTsuScbaXSpKf8HQo7?=
 =?us-ascii?Q?6zs/cZwmAGnLirCJtMVEb5EdPPTyJuRfBFgohsINvnMFy8nOBo3z5t0lpjLw?=
 =?us-ascii?Q?Fa9nDgsgkktbCoN0lfp144uwfJEiTQigwFhzvV5pHI5Ic3ElcJzVg8S5MxUj?=
 =?us-ascii?Q?kc8mL1WvBd1CoaJCrqO5pHUhTxsUA1AtzdyQCaOYtqMWVbQ7zlHVY7xKpRUU?=
 =?us-ascii?Q?c3+JDoRcv7H/y3VQVauBHJFEEHnpCs7FCNbUjXp+HjRNCQjGaTLsfpTRyC/W?=
 =?us-ascii?Q?eR6im9QQ8DuYbEzvonmXXfWBeIMERng3yWhfcPNCL+XDRunha/yEXZBt7WHE?=
 =?us-ascii?Q?0t7d+5KgcHcGmzn70PfjIMav3ry46WgF9zAgrISJEezv1cuZA2ldHDWFS5fL?=
 =?us-ascii?Q?RBn7lzMF1gqtGIQeYrKCrOsbKq3MtarMYEVZqev2wKKywAuWzV6XrviJ3j90?=
 =?us-ascii?Q?nEe8GR8GHcRv8rUTLr98kwitWwkaII0K6IgkNpzLM4SCRw7ZAOXxNK8Wx3tG?=
 =?us-ascii?Q?cgwrKALeQgyIoXuw670VGBPMVBtkzXmZ05G2wTVw09iUvKNJEhRUXlDVJohc?=
 =?us-ascii?Q?jRK6PJA4OUN0e0SCkQM7ts8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edc48e0-348c-4a7f-f524-08dd66cb3696
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:48:34.0029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gdikPKR5GaXEq9kC2pESHIVPCtNTdeXLjH1oVdrvHwj3dXTTE7b89WeMSv9Zf0eGliUflzYJJ/IxZMxZAHQZa0b9W57eBDXGTccvklye0TMuK52L7+wYMw43EoeCuMhx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:48:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18249

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


