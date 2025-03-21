Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4502C36009
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:00:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.60])
 by mx.groups.io with SMTP id smtpd.web10.18676.1742554849009449281
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:00:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=BZaH88HG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.60, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=em0r72EMYpf56E4Hy7OdvIzyKH/AznzHU5cy5ddXjPA5IQpMzYdMHkcW7a17ynQKT0pTr8gOw9o7YML/IC0faBvJi8YJpxjexHjo1nzkd+JO1tXnUfLQSFUb8hq4uCNQ1IIDtBKPZs/1GlqISfN4iYu2nT0zpBJ8cp1DY19C8nPM7E6PfzOZ3+G7j2THbloioeAVSszubkVnbDNK9kYPDl+6S9WEJwH5wPMHFFjUR6MnOZ3D0pUx1rEXUfpW/BSN8ibCh9GtZZv43toUcWESQoO+aQkiohH+vG9Td7pnT9AmUdeiLJwEwI32s3k/G/8mkV4Clmn77Sy54UP+4MCNdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCMU2mxLXzvbyqb/Fgtf9AV8X9/k4FZUDmIuLh51PPA=;
 b=u9e/d+S/0FzuUnxks2OOFNs7tiDNlErCYF+dkJXut1MxNN1EW4tqmixNVXP7Z7y6GgsoY73n9FSBIJeu6cDeuGu5LaL2AWXgP8Q8ACsYKHIakdkmrzK2T7x0IF6ah4hLACFeT2SpdSMBM2ILDM4eXbflnbpwVwQO6nwjwqKSkFomeHG/T5aCqLGfT6z9vKou+v7S2GdjUuAedbIng5sZAYXFhSZMLiviAzleNIMHMFf/RJrNLuvCVDoopRMQO/eezpFD72Ank86hhm/NlQO15446rIMJAuCY2i6ppyIAXo05CyQCVmK/Mgd1iD63rIB1GImEtTYtQERdRJi+zcUYMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCMU2mxLXzvbyqb/Fgtf9AV8X9/k4FZUDmIuLh51PPA=;
 b=BZaH88HG4HU23v5Fk4FT8DFfZGEjjDD5c7UymCyc6IgSxwJncisjonttfC8ea++T2waA5S/GojuFe8EN5/wsoxVzChKQ6SXCo5sNCNtJ5LXThsR2f4+Iv/4IMcWi2ShrVmGEEf/n6Lg0ZFNpNwNA64b3anyAN9q3bbj7iuZJ8DU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB12437.jpnprd01.prod.outlook.com (2603:1096:604:2e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 11:00:50 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:00:50 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/21] dt-bindings: clock: renesas: Document RZ/V2H(P) SoC CPG
Date: Fri, 21 Mar 2025 12:00:03 +0100
Message-ID: <20250321110021.3612805-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB12437:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6fda5a-69ec-4f25-198c-08dd6867a423
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HF6EatiDNpGH6dFlxkPVmKGubDtlFmVYLfIJZi/hNUsqj2BMZG0k2OV2uhau?=
 =?us-ascii?Q?0pp4b6n99+/keJkfSuDKrWQuA//QuWZEoHUbzaOocxZy2vIy/5/n+SJkDaWy?=
 =?us-ascii?Q?MX5Hx9ITWxDCLbMdj2tVA7I0Q/8U8ADM2Vwhok3k5dkD7vqRACZTtEHNC59H?=
 =?us-ascii?Q?ZZaW+yO/VyvM6MxLFi2f5+hRkRNGEcWdEuS3OtAg1SOOInwYVIniwwtu55H+?=
 =?us-ascii?Q?gPWESad+CcMQgFSaaFRcZsM616vYPBX80shViseSYHrjIulOOxOzE+2HEK/v?=
 =?us-ascii?Q?EHh0IUgUTwuj63id8oOiYB0+Mpa2XuU6dNyogmu20d2/+U6HAiCiVSnMtn9g?=
 =?us-ascii?Q?FrATFUXSWuhreJFctPywgQHI3/RK6sVc6vQ+GvBRnWhvTswU5UueoqKglIIF?=
 =?us-ascii?Q?cwj/F1/Il9UogpQ4oUuu9oxPysERsgJu2wf5c5wCqa0tlHOOTeEf0s/jVdDz?=
 =?us-ascii?Q?BIipuP8ERz/cv2I3078kskyT5rBtwptmgCboVQ9Y4jekP1Jhiw/e+cX3tOZ/?=
 =?us-ascii?Q?JtXkSM/Q6/na4hJCs61Q7EGRpwAk6ZNb+LuNTXSL4eWCtgMOd4UgpFdVPExI?=
 =?us-ascii?Q?R5RG1R1j6RL2rMV+u9puPmjcMDkMr65lje1LdFHPZixN/h8UHaK5v30PKuiI?=
 =?us-ascii?Q?iGXYQ2VPZMvf/pxNNJFiVemfRmORset102uTsU+TeXm6TQkun1Y2NYGkTwhG?=
 =?us-ascii?Q?AZ4D8kP3JOAZeFHjrzgYzqKcvHrG0H/uSRCxi7v8ehgiQeYp4gGYRWoNiOUD?=
 =?us-ascii?Q?prQNU0pGxgxCCwc9Do3laEZ7Mo8WSSRUoC53mAz+FHOWEVCIRXM/c92+3HdL?=
 =?us-ascii?Q?wDTzaOFENyhgUrrG6rVl/lgAEU6CAxxskiyLa+v+zo0nWEbQoSivU71PEFDs?=
 =?us-ascii?Q?wC2FtGVKfdAhxCVKs3Mxv5un2keF9goYHzsQwXRcrJKxOomCUdAYsEwvuTMD?=
 =?us-ascii?Q?vO4+ARjPug2zvfYuTd4joJN+OgumjprI3b83UhzeFqyOSFX5yCjXuDSMjowY?=
 =?us-ascii?Q?kr6DOtePl45mdGomn5BcBqToqhku9Nv3K9KXtkeOLLTNWcMqohiymC0yHtnK?=
 =?us-ascii?Q?o0dVoLstZ4XXThK5n1dGU7+eOkS6DOwzZXfMepyGCFj8c4G5NVFCUATymHWf?=
 =?us-ascii?Q?vb/+t48MShSDd3RANZS8Dvt6GvFHImTUTicvyjvhlfO2AC8edaxyp0IAquje?=
 =?us-ascii?Q?92ApTyM9uoDvbcnQcuc0n8fgl/Gzvg4CHlhhxeP36En4fGO8BzSyyjLsiRra?=
 =?us-ascii?Q?y0JnCWZ9sOLkGbnz1ECLdNEZOWD6f0o04RTpn/6l5SAgVgpswT3H/1o72pTs?=
 =?us-ascii?Q?ZDz3r7AMq3b42GAzT3q6dRoWvfJvSTk51N2BjqqTdUYai/CAjO4pwxFy9XUU?=
 =?us-ascii?Q?lFgLX+GbyhEJwMCvqx0GHwrg+n5166RBTmBSLpD/66OEht7tuA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?+oVgCTFEtuAQ7DSpMK5hINBltTSSQLaS5d61HTzLtsyL+D5cr9Tb7Vkf0KcT?=
 =?us-ascii?Q?kfZ/Cfoo6c8IRi+t3PEi+qaIQrkzNcPwiNz8C/JC12ozqcEhFHErNxCNyR34?=
 =?us-ascii?Q?8+RkHww+it2wjjEP6HDWY0Y9UMSWEcHe3z9wsx9RRSYk6142YwjuKNGMa5HO?=
 =?us-ascii?Q?69DPjMxMDs/lhRi5qqxE1TAvu9TmTtiA3fvNPKtlexBvE3G/ZPTKujUixKVr?=
 =?us-ascii?Q?nMSA5IkR74JY0EG/k6knY/7J9gNAvEOkzN/gnlkY7YUdsdWvK2HunTz8biGj?=
 =?us-ascii?Q?ewBFPp4NgqIdED+qS+UoeZz8XlqKseXhxojaJDfWSwwal7fvdeVk6liYQXsP?=
 =?us-ascii?Q?UQi8RAuOzRXlD4aBSAI63uKaIXALAwm+jlUoStY8/gamatKGEc/ciaEhH5KA?=
 =?us-ascii?Q?AqHyT8IZjNXmUJt2K9vcjNtzeCTYdubTKYUnwvLafFp44aO1gfBUHpSQylby?=
 =?us-ascii?Q?lb01L6lKPTOj/SC6UBfboSyeApsaFciJw7K0iU5qTXusAxHe8m55QLDIX8Qa?=
 =?us-ascii?Q?ICFyPoMRKuGbrMJyaAmLOnd7AxKGuirjyd6gwdCZrLFzeckoEealOi89H+iR?=
 =?us-ascii?Q?xgxMYo+lTRZo1iSrHhYIKbnAxOIH06JeloNivNq15lisQg6jZEtNs7VRAPBS?=
 =?us-ascii?Q?hbjCeNVFqRdcS5J+3idTr/q6eeU1ZsABNxLyMp4eWkCnoAh47f2Jl+HRCcZj?=
 =?us-ascii?Q?wPNSPxOzSsElgQVUXD4BkR3XnsmW/yPnitM6czvvAHmD5++evBVp59McuHey?=
 =?us-ascii?Q?E3Zf39ZVH7Qzc5hYsxQ6QrJpJleSAlrGLgrfXRUyPHEuhffHzEk8LPf85jEH?=
 =?us-ascii?Q?jvZTvVq3i3movWAQDwpGh6EIemTgCjLWxUn3gIEMMk0Y2UqpcmIZocWXZSUu?=
 =?us-ascii?Q?AuNwdQmXlqyJzSimabBzpAoIJ7Ql8lHRICV+8IFIFW1NzbTUNLbBqd7XBE0g?=
 =?us-ascii?Q?1rOxvKWfjImsTfxr25rN4LWENmG9BUPkmw11f20pbyP+2itVLznDXvNLAW+T?=
 =?us-ascii?Q?n+B+Cx9pyoVZY/9vXxcq0XiK1Iu3xnFw/7/qPM5DlvcohxUmpDxqyaQcVml+?=
 =?us-ascii?Q?DZJQCZxmWV9HJx81RwQa7zHZDIDoVc5Q8N3MXT7g83opFztE1v8NzravdKMs?=
 =?us-ascii?Q?C5V8k0FwV9xVGmZ+MbQzTtUOMgFZ2yO51m3xTLs4Z9pn/KmbGUGYwYW62gvH?=
 =?us-ascii?Q?b0mIwMWGGmn4AUrDx4mh8hhauTgN51p71yDK1fzinxXBCvPodz7FjjdaL1Ql?=
 =?us-ascii?Q?9qm6m8OP73laELZHAi/Q1Pf7TwCuNs2n8jv8tBCwE6+WGeYl5TQ9CeF9x9ai?=
 =?us-ascii?Q?YUdrT777JOfhzkMgfw5UXOXqzTE8jspq4sCbiclQzgQwfXvuoBpAvnDPhLqT?=
 =?us-ascii?Q?RBzJHPVtEMgXCzZqs75kpql3APEkuXaFfghtwUvaONJx4okjtX+m3O3rjk2m?=
 =?us-ascii?Q?zzyvwu0e5vpNEHawWQxLwaCNcXw2TvJFBBzQWuFpBHzl6BBzTxSWGFtzWTgT?=
 =?us-ascii?Q?GOAxAyNobJ/ub5thxaGqEg66aWLp1d6CmkjLbF3K4OWfi/P475ujT2sz7Rm0?=
 =?us-ascii?Q?f+0ZADrnu3o/9o34OksPcS7Y7zmSNP0pq1FM7w+ExE5txApfB4RcajoE/5NI?=
 =?us-ascii?Q?0DVJY18ObA9jJHGOiv2XyLY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6fda5a-69ec-4f25-198c-08dd6867a423
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:00:50.4384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x05KVTRlFliONnhRU5vIwRoPZM1SkijgwuZWJvTAqAaNffLgKkHQsZXX1WctaL5LnJfS5bBgDAMveaXZ1xKjqZ+L2vN7mtXdmxcWK86yjcNhwKngFDk+6SDiMOQZ8T4e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12437
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:00:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18310

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
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


