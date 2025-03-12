Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 137FCC35FF1
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web11.34779.1741778625533897542
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:23:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=o/ys1PLi;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YnJPF5MduWYyiq2gBAhoOSInb8fpwFhpbtWkkTfluAWTOXpEJcG+0WOcl9st2EhiGJrm1UZfRDZ3oTHNzGHXGsF1McBeZvF8/df87/Lz3+MizWCjVXGQgOIrVFGkG0YUVtrG73sDyFF6rtyPeCygk4LAq7Qe94N+UomwEwNt2NqXJWwMmKHcb4A+CaATV6ZdN73hvyGIxq+SahDzSpQIKeyPch2foTDmKz833YeMOkkvkDQC6aghD1ZesH9zPG4HB4Plyjz+HAdcd7oD7MwtG4t1woo66UcHS/BFh4WinFJLhjCBApTG+TR7gh92+AOn3k7jXADjp0yywU/eUNiRgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDf0Px/Eyqva/b6cri/qbXzI70cBK4oIF5KoxeOuU9I=;
 b=dlnHbBhsm0cUxTLPgFrLw0qs5l9VdbVRK4yVsCdwd7Q10Pj7x5xbvqU8YHobk88jGKADlfwP7z3+iQP6kqeAuvYgKJFp17O0mEPedAOFFkCrfFOpgh1gO45WDl4NuUt/bTJASsi5jV38Y91Hc9Y2DRJcTontXgUDhUmBmNWFnLtc9beUQKzPi5Ln5SNRDaAVNnvHxZ3XblGYCio7DmIpUoTkkJ9N++ktOIw46NGblk5eHCvl64DxLhhOGxsTLimZbtz1wr7yVA5N+zDYgm1mukqUYvFhb5gEZAjmuSdh9+ZXkrCEoRCLQ/4jGMycuZH8uNvrqsA1BVgPwJpTqmzNiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDf0Px/Eyqva/b6cri/qbXzI70cBK4oIF5KoxeOuU9I=;
 b=o/ys1PLiCCDnA7wg6jaAMymGj4Ql0RzG15+ui7HYdwJkxPXRmbUM+4CiEEdtirEM6q2OU4ppVPtUA9A1F2DoWa7hULjgfBx6EtNcH1MelpII+UTcHqlQnAVE4HaDYRT306nexhh5qB7yvKAbhJFi9Sa87RLMsY9z5M0RVEZipBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY3PR01MB10581.jpnprd01.prod.outlook.com (2603:1096:400:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:23:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:23:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/85] dt-bindings: clock: renesas: Document RZ/V2H(P) SoC CPG
Date: Wed, 12 Mar 2025 12:21:40 +0100
Message-ID: <20250312112302.1605750-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY3PR01MB10581:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b9c512-60e4-485e-a2fd-08dd61585aa1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?PWcRhHAYIz2sags8RfEL7SThq3Dulrivmg6wpKpQ+QOSiObnKUcxRCO2fOM0?=
 =?us-ascii?Q?f8sYHwZ09yPBvkRuJbCxAUXnZmNx+8SYm5t3MpJpgqzX7cLCqUaSaCXRA0md?=
 =?us-ascii?Q?ah8YFVvPIC8pBMUCkWqcvRrRzvJN3VttWNVqyPnTEo4qm8h9GBxDDzQ/tBEp?=
 =?us-ascii?Q?+Ih7wZqDNvHx924Mxuqbqj9nlGNQU6Pj1SFsFkSJDNrz3H914gujDTBGkVoL?=
 =?us-ascii?Q?sPG61+tSFslSSVabkQiPzQUGsOP2Vw49eKTGe+NjcVYVBXq/WWFHZg6GU/QU?=
 =?us-ascii?Q?vA06vVvoWfmkSG0wRx4i1PmqTyxtPisQwL7+AMVOMg9aoPpo2Fjbphmfgn2t?=
 =?us-ascii?Q?2RvK8Bl0gi9kxiQIrRpIjBlsFoH9NWqdUeOYRi6Ry7tRuk9R+PKF4GdLDgvS?=
 =?us-ascii?Q?GHlbqK75BYaAQxamNuPsV1YyiwJNnkwqPHIHXWSJQeK83Xribw/QSyb9i0HU?=
 =?us-ascii?Q?GZQiPxVc/SooSKbaLgJv36cjISJc0zAa1zUZ/ass25mpsKdtabrP2+bcz7Lx?=
 =?us-ascii?Q?nqbL4GEDZC3EsZlBjzlKeXdEMjeHwknL0frjMFnttWrx3+6/GuFQeROEjqnM?=
 =?us-ascii?Q?yNK3gfYUui2cGByiYK7/65EwQtFUq+zanwo786PuyKJKS23H036cAQqJl4Oj?=
 =?us-ascii?Q?u6y2O3aIfRUzJIUUN1s0ezeLb/6Nw9iP3GRdcorVEy5fDZpIuVWs9Ees/Fxt?=
 =?us-ascii?Q?wsrYvky72I1aHkWmYYcPfC56/LPDs5mBMlmyGju4lVtTIxUl5BifIytjLwJe?=
 =?us-ascii?Q?XHpr78hWdO8QruHvgxZiWTFjZZGtzhk2gD7S18X9QFXHwLXKDgSpAeUZennD?=
 =?us-ascii?Q?wSmzzSbKfm4pEgQOLZLI6rKtZ1pPCkQ6KqkvNnGdsUQ3+h4WZ8B5DeX/DuyE?=
 =?us-ascii?Q?2EVgKrDVN0AldXl3r58u0pQLWNZxQzi0Se4QQWG0aURg3DcVhgTbot4QSzmd?=
 =?us-ascii?Q?t4feKrpLUpR5JQPUSatjZgzhygUBKB7YA8CeOPRCIypHvK2c5+neHp6i+Fub?=
 =?us-ascii?Q?GdA8xisIhKf9ST2KPMzaKq0MjF5XEU1x7FePNJbYkW58SVciooxfCpkvxVh5?=
 =?us-ascii?Q?P1wZ0crUKz471vGSKRVfKd3LabSXinZW4MRC+NFQsjaCmZfe9aKQkzUItQJq?=
 =?us-ascii?Q?1Fu+s/1Y34jjnK6NUsRpsSQb5OnYtqdjqFOUzIVVrivwu+9uFexgkfvUE4pd?=
 =?us-ascii?Q?NW6jH7gvozM2eEOXbwkDXOWu85OHXwsWj7QFIfu/3SmCI+XqoreNGBzZqEKM?=
 =?us-ascii?Q?kI0srX8kgBK4PF5uuw1lzfZaehBghDBs25aoN59JoPC0mnEqEE/MU+Yzlpwo?=
 =?us-ascii?Q?+UGNqU+OqdbYW9qaGPyvA1syTkw1LwnpjooiDSKvksVrZ2ZcIiwooHkm+3gU?=
 =?us-ascii?Q?iKW+Ii2te+WvHfVyRYRIHuFfp0fNCB4KRjNeq6x/RXEil3otaw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IEYYFI9znftmSiiuCeAQC1txNGYC76vM1L7hMNve2JoBFha6nlrT8QWe6/qc?=
 =?us-ascii?Q?mU8cPzPHNgHQE+a44m0hXFGIDYxEkepuA6lv5mjrrMLHrVbkymZ+r/esLGCO?=
 =?us-ascii?Q?BUZHbeSvQ+0cUsN4W4B1IdX/hh9slPL1aCLB/aMPzkzu26dubUqPWn6ChEYd?=
 =?us-ascii?Q?GMk1IpNtpV0ajS3hfFKWkzQyjjYxGtPTx9xAMy01zfp5C8JXiV1JZ6P1qTZQ?=
 =?us-ascii?Q?iHssPygpEToXznG9t8CVpXSxEa6kiGQtxAt3XZsp1KAVYhPSxWcyyDQxrVQ7?=
 =?us-ascii?Q?D9yjNF3QvYbqmxVH56a7ew5qyGUkUAyNu50b8yii8hIJ2IuJzXUBlPB8VDhM?=
 =?us-ascii?Q?3Awb8PuDroGhQbd3kp53qIZJ+MUIR+XmnZUiOWFlBUagvvJDbS0WPT5GU+yt?=
 =?us-ascii?Q?2RGZ9ySO2oV8gtDGOlcEfhoby5ATlB7a5EUuWt07Tkb2W8DULlh1ZF8EZ2Pz?=
 =?us-ascii?Q?/qqCRe5NNCFc/K3nhDZ2UvSkOEBnxkMb1jAkWQ5OY4IoKM9kKmk9gRYzo+r6?=
 =?us-ascii?Q?2BkkG4Kl1GpYeT/poRvzhfC7oxbB45nC/1Gkna7fwkp0e8L+3Ey7aVNS4dyo?=
 =?us-ascii?Q?2VEBjG7+uQQtt1QF+l0VVRr2tGiz4W0ZcngEXauzjyoVnEUYCxy+QaiYUecC?=
 =?us-ascii?Q?1IUvRWweTCCUzZrHyjn3UjhCcJ+0P3+eZCzfuJKLtfywFnrzp9bbV9xDBqCE?=
 =?us-ascii?Q?pll4MZQJL5mbhx1bQuFZ/mp9znGuN5Fq7jvvzF8UA1oFii8wj5kxfjWcswLU?=
 =?us-ascii?Q?el6UhZZR93bgCzqRelqR77liMnC+0rIb3oEOv+VaRz2HZBT5+U/1G4lp1V4a?=
 =?us-ascii?Q?mUrZP1HHHXi5bxkhMBoxMUoB9xwhHKchFC1rxZWHo9zvrU0K87BDW8E5WXuv?=
 =?us-ascii?Q?PDalbEjud/ErvOQMIkXVe5FNUpaRkjYFIimch/0HEmacsItsdzBl5vF4rnmz?=
 =?us-ascii?Q?go5zlRKeCYem5teoej/wR9IrTueiFQ0qVpgN7ayqoj+9KlWl77bWBOhgERkZ?=
 =?us-ascii?Q?3UEk30LmWEYJzth/Y6GW1GcowLVPSd4acc4JlXbGAftUPYJa+B2Ny/w3Vjos?=
 =?us-ascii?Q?uOlzYpfSGZnG/DL2DIu/Hpg+6VFZ9hfwqiSdfjU8qBEObjogNHm6CjUpIWea?=
 =?us-ascii?Q?R1OjznMYU2GOoXsOwlGRciRAEFaObGuf7ZNVb2C9LgTgrUu6C5SgIBA82HOW?=
 =?us-ascii?Q?EgDfLmPR32Ogbcj0gtI9/xkLLcncPW54xH1ArQ8UXR8+lfnC+KbcT6YEI2ec?=
 =?us-ascii?Q?LkHHo7gE4AIq/Ri/U7xZ/xV3U1wD2hgheWGqUy/24q8CocS6kVsHniW7rfHv?=
 =?us-ascii?Q?XdpyVxjrdfOnv2wCCDJE3OUMRWiVR06JF1fO+WYAoTrXeND3plG2QPjL4NK7?=
 =?us-ascii?Q?GbRqUCU0r828XU7iV+JtIT9oiguRFBJii6O8CsSZZsT0duxmyHhxhmxWftSL?=
 =?us-ascii?Q?fZcYsg6LCiYLWONZFW492rq86OmL6vhDsSYCI5QUo9ZtzJd2vmmIQIRhuR0V?=
 =?us-ascii?Q?4ewnhqwpFxD6e0Ycfa+UMiGQAyKH1ojiKEVLCreMQvj73nkfZreNgbBpU2C9?=
 =?us-ascii?Q?pYyzDqBpecKXjL0fkX96jR8Afz+02JvDPW1/adPCqk3wmw57FMER7cmLNccR?=
 =?us-ascii?Q?KLXYICAsqn3c0DensE8tuy4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b9c512-60e4-485e-a2fd-08dd61585aa1
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:23:46.2976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XUmYB2KMnJ9nQALYmKlrhU3o2HC3uTSgzZvzuJkrcMy++s5hhb4zotbqiW6+acfZD9kzksTJ9mzhGx29qouqYvkyuOmFfaZVIP1+XOGqSnn8zmUS00AZIeWP4S7VkKgx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10581
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18095

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit afec1aba08607b18cfd00fdcd6525aeca0e187bf upstream.

Document the device tree bindings for the Renesas RZ/V2H(P) SoC
Clock Pulse Generator (CPG).

CPG block handles the below operations:
- Generation and control of clock signals for the IP modules
- Generation and control of resets
- Control over booting
- Low power consumption and power supply domains

Also define constants for the core clocks of the RZ/V2H(P) SoC. Note the
core clocks are a subset of the ones which are listed as part of section
4.4.2 of HW manual Rev.1.01 which cannot be controlled by CLKON register.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240729202645.263525-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../bindings/clock/renesas,rzv2h-cpg.yaml     | 80 +++++++++++++++++++
 .../dt-bindings/clock/renesas,r9a09g057-cpg.h | 21 +++++
 2 files changed, 101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,rzv2h-c=
pg.yaml
 create mode 100644 include/dt-bindings/clock/renesas,r9a09g057-cpg.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml=
 b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
new file mode 100644
index 000000000000..926c503bed1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,rzv2h-cpg.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,rzv2h-cpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/V2H(P) Clock Pulse Generator (CPG)
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+
+description:
+  On Renesas RZ/V2H(P) SoCs, the CPG (Clock Pulse Generator) handles gener=
ation
+  and control of clock signals for the IP modules, generation and control =
of resets,
+  and control over booting, low power consumption and power supply domains=
.
+
+properties:
+  compatible:
+    const: renesas,r9a09g057-cpg
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: AUDIO_EXTAL clock input
+      - description: RTXIN clock input
+      - description: QEXTAL clock input
+
+  clock-names:
+    items:
+      - const: audio_extal
+      - const: rtxin
+      - const: qextal
+
+  '#clock-cells':
+    description: |
+      - For CPG core clocks, the two clock specifier cells must be "CPG_CO=
RE"
+        and a core clock reference, as defined in
+        <dt-bindings/clock/renesas,r9a09g057-cpg.h>,
+      - For module clocks, the two clock specifier cells must be "CPG_MOD"=
 and
+        a module number.  The module number is calculated as the CLKON reg=
ister
+        offset index multiplied by 16, plus the actual bit in the register
+        used to turn the CLK ON. For example, for CGC_GIC_0_GICCLK, the
+        calculation is (1 * 16 + 3) =3D 0x13.
+    const: 2
+
+  '#power-domain-cells':
+    const: 0
+
+  '#reset-cells':
+    description:
+      The single reset specifier cell must be the reset number. The reset =
number
+      is calculated as the reset register offset index multiplied by 16, p=
lus the
+      actual bit in the register used to reset the specific IP block. For =
example,
+      for SYS_0_PRESETN, the calculation is (3 * 16 + 0) =3D 0x30.
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+  - '#power-domain-cells'
+  - '#reset-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller@10420000 {
+        compatible =3D "renesas,r9a09g057-cpg";
+        reg =3D <0x10420000 0x10000>;
+        clocks =3D <&audio_extal_clk>, <&rtxin_clk>, <&qextal_clk>;
+        clock-names =3D "audio_extal", "rtxin", "qextal";
+        #clock-cells =3D <2>;
+        #power-domain-cells =3D <0>;
+        #reset-cells =3D <1>;
+    };
diff --git a/include/dt-bindings/clock/renesas,r9a09g057-cpg.h b/include/dt=
-bindings/clock/renesas,r9a09g057-cpg.h
new file mode 100644
index 000000000000..541e6d719bd6
--- /dev/null
+++ b/include/dt-bindings/clock/renesas,r9a09g057-cpg.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_R9A09G057_CPG_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_R9A09G057_CPG_H__
+
+#include <dt-bindings/clock/renesas-cpg-mssr.h>
+
+/* Core Clock list */
+#define R9A09G057_SYS_0_PCLK			0
+#define R9A09G057_CA55_0_CORE_CLK0		1
+#define R9A09G057_CA55_0_CORE_CLK1		2
+#define R9A09G057_CA55_0_CORE_CLK2		3
+#define R9A09G057_CA55_0_CORE_CLK3		4
+#define R9A09G057_CA55_0_PERIPHCLK		5
+#define R9A09G057_CM33_CLK0			6
+#define R9A09G057_CST_0_SWCLKTCK		7
+#define R9A09G057_IOTOP_0_SHCLK			8
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_R9A09G057_CPG_H__ */
--=20
2.43.0


