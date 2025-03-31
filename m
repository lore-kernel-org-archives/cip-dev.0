Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8806CC3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.39])
 by mx.groups.io with SMTP id smtpd.web10.49088.1743418032272919449
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=F27HlM7K;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.39, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YVtTQBkc9jEy6sCURU4s0IkDqhXrZzYOKEz9eGupiEtcKzq7P1jdHUQwPJmN25J8Ba7UDv1tHyaetWTTBk0B2eJICQkKXSeRlSJpngC2fovqty4PQq1UBulx/xa4W3DJQdfDF+2NF2sTkTMxoOcBkQrxP5O+uy7ffkhqi6k6okQN4iFyiKlTMMyn1qHK0fzCsGD3p9B2SCMUuHk++bdAg+g8aKeoklE1rR8T7FqBotusCTs6jeJ6hqZvgzwTz7XU4SsTcDnWM9L+4joQIaTp1P1RhXAqo2zMfbkE0gxpfFnfoEj8XvoAduFIa38tKyKEDLs3YYzuuansJTN5vncJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pyj/XLvPxG+Vfbycj5J5+000vwlK6K+mpGRz2pk0VdY=;
 b=Zp/4LM8pbH+4ppXmLXKTs+mz0HLlZJfSuNQxtkjxriSeGDgGUELft+82EMQGeWUnSNAKwsiJBGw1d8JHY/ZWbSlARe/4ZcpUiWQMSVky0CrOLzTSgbHnivrsYVPXoBkMyRbNzyMb2qyW8BxWWf2PXK/h2kBNMRv+jZp2EBC2FSfNdTHVeBTOH8L7EI3Bszx437ecu88t1KpQptxapicAH2k7lD75M/DWVgXiQYjHaUmQj6XHh6yGG3np08cAyfKMZcXTHqxS0dwrwY0N4G0VWy2tgHZTnhbYKVEeyBO8GzMtAdtl8zF+SFnQYIyXDfQwWhNytGsfQgObDuyGdmoKMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyj/XLvPxG+Vfbycj5J5+000vwlK6K+mpGRz2pk0VdY=;
 b=F27HlM7KV8LfGasaTi3e8z4+SB6pdpCZH9rzmzepxRzfD/6s4qNIu31xbhz+Or1lzXvxCQLEZ5LILxDZcvlCpZECzex5yxGcTzSBytaBDUunwb7lcOEMK69guqhdjuQt0XoxqRBioEKyMFbisrBDBc/NcJasChpICMq4K5eOjSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:10 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 33/43] pinctrl: renesas: rzg2l: Move pinconf_to_config_argument() call outside of switch cases
Date: Mon, 31 Mar 2025 12:45:04 +0200
Message-ID: <20250331104514.79090-34-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: 99cb3db2-17fe-451b-7621-08dd7041638a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?rzziHA8rnvSPGXF+DkjwivAOniYgrp/QUY2/M7sxVE0TITWqF8nay2k0nhDl?=
 =?us-ascii?Q?LSUZRrNLxClp5NQSIZlttqJ6O14uKqR0X+VO2hO8RWagqsYCpdUfDD5i6bJP?=
 =?us-ascii?Q?gyt2JsEYXPvqwmCzctMdTbapJ07bPJIYhBWvNTUASc8V21sx8lQVzaCHtIrv?=
 =?us-ascii?Q?tJaRBHRsGKBBf2/JVMFDtHhfwyCO/VIl49tqCX9yQ4bX5NpVo7V+KSJKtCqK?=
 =?us-ascii?Q?NGdc/EFqomykP4wp7bI96mGED5ZuIkzVtnXO2OzqZ3aCFwe+10saDUI90RhO?=
 =?us-ascii?Q?h5TaYhB8PVi5/M8WbKaMKdAGAuHDxGXxjRsqquLFpr0q6cT54JRbSRslc7Za?=
 =?us-ascii?Q?IdjrtSpvqAi0emtlIqlvOcuvh0iaZQfz1mjLDH5bpLtg9VS8c3wDG2LMFiCJ?=
 =?us-ascii?Q?p8op5SWpnmjdLQBlQJIFv6gFH2qqVgLyVL2yLOgPDwzvqHt9VTTy07Ati/L8?=
 =?us-ascii?Q?UmrMFn32cfTHurZTwUtP3rNepfoW9NDy30TBlItMPVR3qFGKRUK/4WStO9TK?=
 =?us-ascii?Q?fTS21jgkpnBBnjWhPYbkkuqqsp8gGYVOoe1VxkJRaWgEjqI97p14ECT2W/73?=
 =?us-ascii?Q?5w7k3Ur41Fzzqjn492tFP3+84ae4zVmNa54PP2LUGR/cR8HKRNGhsBU+Zuuz?=
 =?us-ascii?Q?eIawsV2rsFk22phEtWdr29BnOJglJI7s4pGKQc3li+7VEnQFZx0F4Wb9Jwc5?=
 =?us-ascii?Q?pacHR3V4l2y9BdwDQMLMoj86nIoxaxVGrRr8Q1zan3ta0CMwmpJABwjjKQWw?=
 =?us-ascii?Q?f7LXtDBmJloxhGh6RkwG+enm6qOOt2BLwYN42gFl5Tmzj9+Y3xBkl40Q91sj?=
 =?us-ascii?Q?28Lt19YyFd24kMnfpIyGgPtusZzUZzyNBvtd+fuxV28qeUVzW2y3vVzqZO9n?=
 =?us-ascii?Q?w7uiALYSmYzqQZHpj56BIdUQPOEH+gOD1JZk5fu4qPMDGLDToH1W86BdUwAL?=
 =?us-ascii?Q?Je6TguoG5fgif+a0IyFVfF+Gw2OcHcUwk5x+8qiIrbwv+Xk12TzU8jGFa5K2?=
 =?us-ascii?Q?bNR6GyuYE+eMciMnpERk2jZ1K91HwzokkE95InaN0hxfkQOCfpISyBMd6uyM?=
 =?us-ascii?Q?v1TxnT4K+4AhrncdIwbttoxDgDti/CrjptjuZQNWNg4+V/JFyBPthui6kMeW?=
 =?us-ascii?Q?eG4sNzBbDE92XO6zEV+IPXFP5SQ8KR6HyNDnNq1CyjmnmRlXi32r3eaFVUs7?=
 =?us-ascii?Q?IVXSlQN+ecLzgOeg624u2EzjNuAU01YPnaPhPAMPoYhhO3v8Ls4b23ufDQkr?=
 =?us-ascii?Q?oaEzSjt4sckvQcKQijZGfdGdh/MT0nozpws4F/tmct0u7uR9HelvdDzDS3uJ?=
 =?us-ascii?Q?UdBGmZ89n+qXAkCj9SklXUuO5SaEbVBycr/wsBOCf3Lv4FiF9EkP8YQtDaEz?=
 =?us-ascii?Q?nnSpvIrOgIaniZxu+UgyZ5dRsIreRGAktkn+zvOYX1KYiA5ZWb130p3e4/h3?=
 =?us-ascii?Q?fhwZCxlggL5CJyvZO7ObYaw0/ZKLsfAl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CR3yWiNc0Ux0BAe8okayL6AlX0A7+1xubQ/SD2KhkZkUCPWqhA+xzP3sGxi6?=
 =?us-ascii?Q?vcYbK5eKyCmmbRnTCMzdMSJ8QcFdvr/vv7NUSMMvGge+cCzjit8oQGcoH+8+?=
 =?us-ascii?Q?FOirQgVoHCrAkdLYVYbcE46RW5mg4q54xAl2hJodEh+3x4gxNasLkrqjjN8S?=
 =?us-ascii?Q?C59xrLIVg15xU7+R5OPLal1dirt6WgaUcZwHF7DQYnYsZN8j2JE84w62FDE8?=
 =?us-ascii?Q?FCwH686yPJyA8fM2R+hdGu1WoQTUH+68Y5zXZZi8onq4G5Mhzv+UVtE7H041?=
 =?us-ascii?Q?jRDUXeJekU4l5B09mmA0L2u1G9nzZD3EJzRQ6NP+d+grYKcX514m8xZq3+Bu?=
 =?us-ascii?Q?jMljXfuvpKOEpzoxSupPXYGTo+bzJvXsznmzfo5tkj/9oQUwVH4EH1Hd6n6O?=
 =?us-ascii?Q?LdS+RNiyd32SIddnu8QQicYcJrCEDPRQ1OGRKTQuB12yLitfHnVv5SMPTT8B?=
 =?us-ascii?Q?GXQg0okAwJ0o9TGJFK8GrpX+wtEh6n8ExjFa/SH3gDU7B2wO6hkgzIHDyUEg?=
 =?us-ascii?Q?Z8SnLcJ3w7WYsDQJzwee6Ze0r+xosHl1VFyGzqjl6gF/RAPVL3tzmYl4IpDs?=
 =?us-ascii?Q?KLAlOqq4+OmEVeaP67qOM4+UW0xmsai6cw43O2hrVt1IAMu0tsg5/U8bsINt?=
 =?us-ascii?Q?frC+mV7LquALuJzqm0CcO1T2aaKYiL3FhFGMYdAPdwntMNNOR7WbIR+ZOFHk?=
 =?us-ascii?Q?aCZi3CEunXQg/SXnapXogMU5wfL1yYK5E9fzQeogxvgetU7XpknrmWQC5hGa?=
 =?us-ascii?Q?R3WBrker39m7FDNL5LaUvfK7Rvwx8kUAcbh2Vj2nUsmS8sq6aR495QZIwFVm?=
 =?us-ascii?Q?eWZKMNVQYWeKcKxKhHa5IiwYke2+KVIGt7GmWLupVFm7NtqrK4LE+hB+NfYN?=
 =?us-ascii?Q?qXQq+FZjvLtgJBBa04cz7KabwWQ5fpseXWXvVqGE7OoL4w3OuMTDwxRK/172?=
 =?us-ascii?Q?5jW3MXtotkPEsltLBSD7xQ/aJC6xh2PY8Ndf2NscN/s0kfrw16drE2evtgTq?=
 =?us-ascii?Q?YJoKShg1rFAc+5pQQZA4ZusRKzwC0WCYEkGs1R+7H8boEYD1hX3qYtYhkqkA?=
 =?us-ascii?Q?50QbuajqwoxgbQIqbUsQUCM1terAEVIC0bkCABe+HQiIWe8vXZ5M4D+KdWsm?=
 =?us-ascii?Q?B0iVbSGjLL63502MSP4Jufr6G8r5Rmhm1d5o8p2qXM+0Vn1ozzihm6aqFh+C?=
 =?us-ascii?Q?hpKbSIYjrdF8oWjjU0UwYrCx6QUyj1mimVGe3qKeMIzj4RDUn7JN89+UpHyl?=
 =?us-ascii?Q?0cf8wW7KpL7z9giz4jVPE1EDCkRnWasrfkXpDy8p8RXGJaQ8Yoec+l7watL0?=
 =?us-ascii?Q?J7sN7M7HXskewXkfnRrX07T09SjkCtU1VtVHb1u7KcnoF7jwqwC2UpZZbYwY?=
 =?us-ascii?Q?AR43Ex9NuUEEiE+jZl1KbPWi/mFZFlch2TrpKqZ+YuVLdZgaC9w33ArXEI6t?=
 =?us-ascii?Q?ktsE3UnaPuV4y/Rlv/YAkxCM6GHKIGq7vz0AgXykrLKpC8YN+ysShG4SImIm?=
 =?us-ascii?Q?aB5XwYbcMoaTaIBWPycsvQ9O04ggidapXVlbEvs/5BJin0izq58XK8jbZHeu?=
 =?us-ascii?Q?Bxpts1CoXM0wK8d7ltHNfWxsF071jFPewNjk24J9cl30KSS+7a8kcOHYh12R?=
 =?us-ascii?Q?qb735UHr8SUdOehVsaFKD64=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99cb3db2-17fe-451b-7621-08dd7041638a
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:10.5406
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X0bDZ/JcS8sOew9n6LzTNU35K7P/4vrlE0uqieauGNydz2BVRgXqx2s99bMGnmmbSF2qUwfLgMs3Y1unyGq78Tire5UAy+G1xK6fh2EIYxZjX3x803sG6LxhEed7JCpt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18421

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 1325820dd085809645bdd89a2fd408a05b4a5492 upstream.

Refactor the `rzg2l_pinctrl_pinconf_set()` function by moving the call to
`arg =3D pinconf_to_config_argument(_configs[i])` to the beginning of the
loop. Previously, this call was redundantly made in most cases within the
switch statement.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240829194841.84398-3-prabhakar.mahadev-lad.=
rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index d5249955c9a49..5919a9c441be9 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1385,9 +1385,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 	for (i =3D 0; i < num_configs; i++) {
 		param =3D pinconf_to_config_param(_configs[i]);
+		arg =3D pinconf_to_config_argument(_configs[i]);
 		switch (param) {
 		case PIN_CONFIG_INPUT_ENABLE:
-			arg =3D pinconf_to_config_argument(_configs[i]);
=20
 			if (!(cfg & PIN_CFG_IEN))
 				return -EINVAL;
@@ -1396,7 +1396,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 			break;
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
-			arg =3D pinconf_to_config_argument(_configs[i]);
 			if (!(cfg & PIN_CFG_OEN))
 				return -EINVAL;
 			if (!pctrl->data->oen_write)
@@ -1407,12 +1406,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl=
_dev *pctldev,
 			break;
=20
 		case PIN_CONFIG_POWER_SOURCE:
-			settings.power_source =3D pinconf_to_config_argument(_configs[i]);
+			settings.power_source =3D arg;
 			break;
=20
 		case PIN_CONFIG_SLEW_RATE:
-			arg =3D pinconf_to_config_argument(_configs[i]);
-
 			if (!(cfg & PIN_CFG_SR) || arg > 1)
 				return -EINVAL;
=20
@@ -1433,8 +1430,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 			break;
=20
 		case PIN_CONFIG_DRIVE_STRENGTH:
-			arg =3D pinconf_to_config_argument(_configs[i]);
-
 			if (!(cfg & PIN_CFG_IOLH_A) || hwcfg->drive_strength_ua)
 				return -EINVAL;
=20
@@ -1454,12 +1449,10 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl=
_dev *pctldev,
 			    !hwcfg->drive_strength_ua)
 				return -EINVAL;
=20
-			settings.drive_strength_ua =3D pinconf_to_config_argument(_configs[i]);
+			settings.drive_strength_ua =3D arg;
 			break;
=20
 		case PIN_CONFIG_OUTPUT_IMPEDANCE_OHMS:
-			arg =3D pinconf_to_config_argument(_configs[i]);
-
 			if (!(cfg & PIN_CFG_IOLH_B) || !hwcfg->iolh_groupb_oi[0])
 				return -EINVAL;
=20
@@ -1477,7 +1470,6 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
=20
-			arg =3D pinconf_to_config_argument(_configs[i]);
 			if (arg > 3)
 				return -EINVAL;
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, arg);
--=20
2.43.0


