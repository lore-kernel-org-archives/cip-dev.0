Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A117AC36010
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:45:41 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.31])
 by mx.groups.io with SMTP id smtpd.web10.49041.1743417936979762257
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=b+uzem+5;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkNS4rsd3M404e3O9jiGYg10eq2ytWRWuYxJf3rv3HmAeAWp+SOzZsj91go1vgmAkw7JdTjI6997CBwZJHoJVUbYK4PN+FVBi2Ymgx7O845WZmMsNuekOW6UXIM8Mtw/9+RMmuFh3DTfoOlWOZ57et4fIlrmwhkkbfvu4E9wBZeiuQ5C+o7VNRlkwQu3hFHPY8BC6IKWSD3a2NkRDsA7O1etZ+cNvD8fpm3KJGlFDrHeiBWrG+W5iIJet+C+G+60D9TJSV4rT3Hni9kFOMTKnW4jt8ZYXdHhn28mzrURcuC6O1DYZ5onjBLFFPbahU3DMRDEV8pvaGuLI8TpuIN89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8mXuQwdi0WjMGPVDSumVsIbxQ6FdHPG+8kgbh23oSI=;
 b=zByfU9lwm5Oq/prWx6u4cCkmfv31vv1b5wU11mEu6x13/N6rL5QY7A54mR/3oSpyTDlQlj9a9bH5ApPCLRFHJH/kx3RwyuCt6kDX5HDXAZNWzNPE6OLgbyxcZJWVoqIjrMHSjvrdQI4niZgRpdRcQWqD2qFPNzZdgRGV1rRvwGjj1NlTRm6562U0MA/DSVHuLCOyqmr/hisMd9xp3d9lIwMOriiPNbtlFTlWyUAuWa+ydHiCw+/SI7vOeSstSioGnx3+iWv4R3tvQbYBmoxboaqEXTOYVhGFF815+6OsyVTGVM8yDxtYBCz6glsoiolZbGzUhCcRcSWIPDnnp7CAtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8mXuQwdi0WjMGPVDSumVsIbxQ6FdHPG+8kgbh23oSI=;
 b=b+uzem+5G9McaP2KdPPiIkw7jg8mfuBEgSpyo9H/Z3KOQT6G8LBXEq3DI3SxtaeoCb22xtgVNtGdY5aISiz7SSJV3Tyi2bEPoHKupWYnnxFe/WFQjmOuyJPqUOHZEEPDQJMFKyaRSqGX1UP/7PzmDl9KwMBjpvE2uW/wnDjwJe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:32 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:32 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/43] Add RZ/G3E pinctrl support
Date: Mon, 31 Mar 2025 12:44:31 +0200
Message-ID: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 57059961-0e45-46c3-b717-08dd704128de
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aQqaHCyt8BssiXkQyCpfOZLbKrX1oQdamLltsu2Wip5Nr4f1xyhral0FeWa1?=
 =?us-ascii?Q?RCntz7+yk7ufZJCAByVwoFoTS6Q6KKekVlKLi0XktDLy0V2H9c908t3ZNbKt?=
 =?us-ascii?Q?Pln/6rYbsu6DoK5FW9c2+2q25uoqNXHx1XVxMHO4biXlcKm7sOnJDvqLJYK2?=
 =?us-ascii?Q?ovn+1D6kHSGBVy4encghe7S6epa4pDfcjvBJxJm5K2R0PVM9uBWZGbD0Er/v?=
 =?us-ascii?Q?VV0JX6jGbVVxqzrKITPhiJsp5gzGPKg6T6IiRlem6OeYjr5T8akxfCgvlR09?=
 =?us-ascii?Q?uwDjoskjunkxM7Vh79LPQjph2CUCAyg5DhBNxJVnOtR900sZm10x3gzz/nw+?=
 =?us-ascii?Q?U94KMsvDf6B0PvoNLOjmXXgVezVum248j+sboU3NEN87grNiTDDQBaMSZrUU?=
 =?us-ascii?Q?6W3cDMjNRXH0vg1v4ECaDnQisTHYl4LDRbk6qpM19efohzR80TF5SHCiiwpu?=
 =?us-ascii?Q?qE12ZWJfuFFdflaXbnvU6XJUlATtdjNZpoJQP7TRlAVvNx6QGUtAd6JM8Q8B?=
 =?us-ascii?Q?5G0bXO8aOxh8ohvvI6mSvvxsfuY8UCV9RlsBfzqZg0BaiR59lyK+0qhK1j8K?=
 =?us-ascii?Q?Q+fphiJIYT5QYE228JTkH+AmX675ukqbxSJiIbUL+p+AlJnECrwN4addn292?=
 =?us-ascii?Q?BUCKXYd0Ef9XEava+hrTVk9D2QHo1nbjhtxvto3fgo24GZD7fDPnCf3TozOA?=
 =?us-ascii?Q?wBXgTYGhEM0c7NiG1dXSUBBJQsHng5M6nrY+7Dg2IMOmJP82ckjrESMMr/E1?=
 =?us-ascii?Q?7ocUH0vNbKNvfRuwbzoLIor5GmenXYaUYUEwgeD5H2NPEC9KB/RbOzboA6DE?=
 =?us-ascii?Q?B7/HeoRFWiS9Nf+hl3kAiM32o9oPvUV9tyJtj1PfiYbwN3ZFcWXywm251PZT?=
 =?us-ascii?Q?CQqHLUt9XeslkUsAhKXgDXkx3OQ9+YQ0nEdSO78GIXGN4FoRIxMDkW5QX4s/?=
 =?us-ascii?Q?KX0uXHRSfjo5PmPkyTRNHEI6jApOcuKNUryduJHHHlfB3R4AS5UKTtrLzAvp?=
 =?us-ascii?Q?pwd/xK38499VO72Xi71UTuMaByvEiZlyP07KjRw4ASlxgbywNS5byXZW4tKQ?=
 =?us-ascii?Q?9fI586OR3tTEbFO3AiOgkeOu8xn291L2G9lkIoGHNcfWXJczMD4q+T1FTZ96?=
 =?us-ascii?Q?Vc5pDF2QDjlAUQqKacKfBFNsBZmtXtatBfqEtbjBoA21+Jpp9APDwu8pmlpD?=
 =?us-ascii?Q?jqocFMWLGwjDBjZ27hausj8xeI1GZYVHypIbTbqMXd+QH43WBiOLNMS4yzEt?=
 =?us-ascii?Q?6oke+735GEluEwH7tQc8vONBji3Kc0H3Co/VVmjYxeZGGj6KYZZ02su6ZWCD?=
 =?us-ascii?Q?1znAK0TrgH7+/CSOBULPm4Kgh/dzp1TdQMbdoQNVZJz/YDEF7TZ6XqXbRWz5?=
 =?us-ascii?Q?RNQzFMtlFVq6eFLY44/7r7qtt3pETZQZ6B1eX2scLlUzizL6wrrV5WARGX31?=
 =?us-ascii?Q?FJVtBF1VDA/kmBiMlzw8/hdiThxssCdy?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ecjWvj0tZ4GCQBJ45r7gB/4rGcCAkWmctR+oeOm/griPV3B62PT1/SH6wou8?=
 =?us-ascii?Q?Y3bXn+LhrL02x5be+jj0P/sPCriHOzA9Rg98WyFhFjXwrqVMD0OcfN/GY8Vi?=
 =?us-ascii?Q?/0GVvu1IzHKdINhmjUbwKcAY/j1HjYaUpnpB5fByQuKFgFWw4NlcBfaIOiBQ?=
 =?us-ascii?Q?dDeI0JdKoqFZFpaAi9I3WmfyUJwCB1ke23KjiF+TCwpgNd9EU7ALosKvDT3V?=
 =?us-ascii?Q?mfBE5VN80yRl5m3Ri6vXNpbK9nOb4DmXEqN4xnGKzuzCZx0qoBtV/2tpJYzs?=
 =?us-ascii?Q?o3axWZj3T8N6Yf+F06aVmrJ1kLxRxR/6qfxX7VqfuNlMUfRcTbjDyVJ5lldG?=
 =?us-ascii?Q?iwYsHWoc+8nipobQ26eYIa2avpAjbJbGahNNhQXWM2RRk+36l+sj4jj8d9rg?=
 =?us-ascii?Q?1962vgzCoHKQpcBw9zicdGMLLZ0YLw+spJIxvyhFKEN8TpDU5btXPilYM+RM?=
 =?us-ascii?Q?GJ+4x6QOf57hwDhiElcnor2otE+OSZFADI4O/3fwyvtRew5l1fMewkxpsJYy?=
 =?us-ascii?Q?rKO+g/ZGcckQhlLvVymZ7UzEnncs1Vt5x3Qp9ApzoYl5lqnJDZYLsXglpUNY?=
 =?us-ascii?Q?xBoIivJj/FzIvR97d9Z0MgYDhSdTEPYcvvSlQ472mz/c8CtbdI4pandchw+F?=
 =?us-ascii?Q?yu8XEKozFM15JSIAyaHN2XDuSno5pTg64b54VU/PpMfywbaG2oD+YdMqN5bU?=
 =?us-ascii?Q?CR2sGDHTnpzMnnw0ULvydT8wOUePWjt87H6ZZTDit5abPABb72FnRea5EBKH?=
 =?us-ascii?Q?i1o/cYfeAtFXzlRlBjtCGATRL7QlwkWq+wd/xacFs4sMpDKaWYTW+UneFGsa?=
 =?us-ascii?Q?cR2QNU2p+AX0/qM16b1DXy75AtegHSAvkTsnKXwzLuGXNfSiyZeEteyddt8L?=
 =?us-ascii?Q?swywuLfrlfaaEfdmID8O+y7xWZK652hUmokQ3NS909MchGbkE3LgGjcyDuCD?=
 =?us-ascii?Q?ckYwNSeqruB5CtIyv0WnuZMIFX2TN60txpW3JiCYfrP6dBI11UHYE5obK/+x?=
 =?us-ascii?Q?HfAz3CcvMpLZ6tsLUVfi4qj4Y9duaSlshYUiR2ae7ZGh10AkmJ/VUQ2vX2Q8?=
 =?us-ascii?Q?z5uwac5IoRw7pU7ieYXR7z8ZrTnNpgfrucJ86vdo5HMgWh5qEb6c/3aLje1h?=
 =?us-ascii?Q?7gh451GEPSmNUS1sGwk5kP2ua/rqVShqNyrebHiCVQ71ATvZ5cMNW0uPlyWI?=
 =?us-ascii?Q?y9qu4txrys1T9nfr8MJQut6/5n1pRPNpVtXdZE4dYloLj6DRhEwbtGGqJjel?=
 =?us-ascii?Q?8mRQnV4hbsiNfvOAnZ/j+UhY3j/hrjvxVqXpt4qOkZwspyv7XLL0xdwKr2Bm?=
 =?us-ascii?Q?vUKCoDatI1p2fmCSCKm14jgaUxPLogEy6f1U9HC3488egN4TcpGh1dacwBt5?=
 =?us-ascii?Q?2NXTLJVczUnD5KJL9PPPL2rm90uW5R/1mBp3C3HN7r4fKtlOsYCN1HxgfVth?=
 =?us-ascii?Q?162Nsew5zhHanPR0SDyjYweJJ0wPTCsPlnP7wIfXJe/WoBqaRNEW9uvk/XT4?=
 =?us-ascii?Q?BSlNkbJ/PVkkcmMJTKU7YGIJyKRGaunMZlIsHEk6mKvhD3qCdGNbf/qzoUI7?=
 =?us-ascii?Q?gM7JJOefESpj0y9McVxNUVo2rllD2jNrtlMaM09bGX6ExK4mqK4FSEf23Boi?=
 =?us-ascii?Q?q5HzyO3vngrRUgp/5JLPBTs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57059961-0e45-46c3-b717-08dd704128de
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:32.1358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz18w87FtVEuW7s4ULRY0A26B9rK2ivXOG1eDDTNNbykgaUEDWrUnsu7oC8RGO3i6/7HffT5jv5nrnUfF6Bngrt5PGKIUeA1ZG20urrvfzAZO6R4PpMogAkEIzi/Mcjh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:45:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18388

This patch series adds pin controller support for the Renesas RZ/G3E(R9A09G=
047)
SoC to linux-6.1.y-cip kernel, this series adds also device node for SCIF
pincontrol into RZ/G3E SMARC EVK board dts.
The RZ/G3E PFC (Pin Function Controller) is almost similar to the one found
into the RZ/V2H which is in turn similar to the one found into the RZ/G2L S=
oC,
for this reason pinctrl-rzg2l.c has been re-used.

All patches are cherry-picked from mainline kernel.

base commit: 609e6d99a3155 arm64: defconfig: Enable R9A09G047 SoC

Thanks & Regards,
Tommaso

Andy Shevchenko (1):
  pinctrl: renesas: rzg2l: Replace of_node_to_fwnode() with more
    suitable API

Biju Das (8):
  dt-bindings: pinctrl: renesas: Add alpha-numerical port support for
    RZ/V2H
  dt-bindings: pinctrl: renesas: Document RZ/G3E SoC
  pinctrl: renesas: rzg2l: Use dev_err_probe()
  pinctrl: renesas: rzg2l: Fix missing return in
    rzg2l_pinctrl_register()
  pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
  pinctrl: renesas: rzg2l: Add support for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add pincontrol node
  arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol

Fabrizio Castro (1):
  pinctrl: renesas: rzg2l: Remove RZG2L_TINT_IRQ_START_INDEX

Kartik (1):
  mm/util: Introduce kmemdup_array()

Lad Prabhakar (28):
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow 'input' and
    'output-enable' properties
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Remove the check from the
    object
  dt-bindings: pinctrl: renesas: Document RZ/V2H(P) SoC
  dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open
    drain properties
  pinctrl: renesas: rzg2l: Allow more bits for pin configuration
  pinctrl: renesas: rzg2l: Drop struct rzg2l_variable_pin_cfg
  pinctrl: renesas: rzg2l: Enable variable configuration for all
  pinctrl: renesas: rzg2l: Validate power registers for SD and ETH
  pinctrl: renesas: rzg2l: Add function pointer for PFC register locking
  pinctrl: renesas: rzg2l: Add function pointer for PMC register write
  pinctrl: renesas: rzg2l: Add function pointers for OEN register access
  pinctrl: renesas: rzg2l: Add support to configure slew-rate
  pinctrl: renesas: rzg2l: Add support for pull-up/down
  pinctrl: renesas: rzg2l: Pass pincontrol device to
    pinconf_generic_parse_dt_config()
  pinctrl: renesas: rzg2l: Add support for custom parameters
  pinctrl: renesas: rzg2l: Acquire lock in rzg2l_pinctrl_pm_setup_pfc()
  pinctrl: renesas: rzg2l: Add support for RZ/V2H SoC
  pinctrl: renesas: rzg2l: Update PIN_CFG_MASK() macro to be 32-bit wide
  pinctrl: renesas: rzg2l: Adjust bit masks for PIN_CFG_VARIABLE to use
    BIT(62)
  pinctrl: renesas: rzg2l: Move RZG2L_SINGLE_PIN definition to top of
    the file
  pinctrl: renesas: rzg2l: Reorganize variable configuration macro
  pinctrl: renesas: rzg2l: Return -EINVAL if the pin doesn't support
    PIN_CFG_OEN
  pinctrl: renesas: rzg2l: Introduce single macro for digital noise
    filter configuration
  pinctrl: renesas: rzg2l: Move pinconf_to_config_argument() call
    outside of switch cases
  pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drain
    outputs
  pinctrl: renesas: rzg2l: Add support for configuring schmitt-trigger
  pinctrl: renesas: rzg2l: Use gpiochip_populate_parent_fwspec_twocell
    helper
  pinctrl: renesas: rzg2l: Fix PFC_MASK for RZ/V2H and RZ/G3E

Paul Barker (3):
  pinctrl: renesas: rzg2l: Clarify OEN read/write support
  pinctrl: renesas: rzg2l: Clean up and refactor OEN read/write
    functions
  pinctrl: renesas: rzg2l: Support output enable on RZ/G2L

Shen Lichuan (1):
  pinctrl: renesas: Switch to use kmemdup_array()

 .../pinctrl/renesas,rzg2l-pinctrl.yaml        |   61 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |   13 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |   13 +
 drivers/pinctrl/renesas/Kconfig               |    1 +
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 1229 +++++++++++++----
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |    3 +-
 drivers/pinctrl/renesas/pinctrl.c             |    3 +-
 .../pinctrl/renesas,r9a09g047-pinctrl.h       |   41 +
 .../pinctrl/renesas,r9a09g057-pinctrl.h       |   31 +
 include/linux/string.h                        |    1 +
 mm/util.c                                     |   17 +
 11 files changed, 1103 insertions(+), 310 deletions(-)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h

--=20
2.43.0


