Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE9C83030
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:07:56 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.8])
 by mx.groups.io with SMTP id smtpd.web11.8479.1751620069236542798
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:07:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PqajQDhT;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.8, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DlnEwfCy5d9rRXKvZpvPPw6HIOZXvbFsWMKwZM+TuKUBvRtsJBKpGsWXtMs0JYK8lSwj7UdDYsJrm9SegDelkCG2bem2PxqAfTNh7eGU5L0aCjyaLbrz9fN9UPtFY4+n2zVl5d53nTIVAbkSWLrr0BdzMOa3d99k2capjcsOhaRbThGmmdwXjl04kaDsPFo0EjT8mybhzq4icWZMZwuPABR8c48UGOO/sl8Xs/cOglRTcfkV/RzpKbSYOKlL0oM+IOJoAO0sp4sT3D9IJECyT0aC9Bix8o1muOXmsXrIyp0pgThpwxxROmoUnljXw0QfbtWCdcYx6Xyl6V+BMbNsDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmVOyx2tZHgWvglXlIjrHHtznCoBDM9cH47auRHZb78=;
 b=qBxlVOq3DhTGlFvAB8NsnfrA+D/fPQ4ivNljJK7KgYsrnLGZS9JpX1ZdaSodQbZjcVUwi7zvHcLT5K2wzJAA3EzGQYIr0zfNJw/w23AjUqVfJQFpoAA0ShCIqF5jJDgso68OdFzbzqvPTpDIAZ3xnz/Sm+At5KcnXK3bzFSvCYN1MSj5HFah/QKKhNTMMHbVN19Fz2liTfn31TNgY6tuNHvwreWmpCTHKsslnUga/No2meVYsUdoJh6aqoTXGq95f/jHCeAFPm87IZUgQs7U4sdF83BRUkpyPa/hbsd5bEK+gI3IMkAZd72YTz7/LIFDo8Hy9jq0VoUAvQai7fallw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmVOyx2tZHgWvglXlIjrHHtznCoBDM9cH47auRHZb78=;
 b=PqajQDhTzzdrGuUVDM2uCfgG8+tyFA3LNnJV9inadzmlbjYDYSH2dIel50PcW93qAvK/MHFPMBgmhueENSBmuft7chEQ9Tsabb81R0QkpZPtP+j5STi7BBDO4FLczX4PgnfFQi5YQ3/TwjO7KEHUt9iTyhL72JzaGNOWBAyU5+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:07:46 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:07:46 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/18] Add Support for RZ/G3E ICU
Date: Fri,  4 Jul 2025 11:07:06 +0200
Message-ID: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: 361a1cb2-1cd6-4b9d-13c6-08ddbada3df7
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gDd6BiQFIf23rDRwVVIxmnAY0Z1/R6MOxBOvL9ykgIbgfJQFRrfmth3n9W+B?=
 =?us-ascii?Q?UlKEy2xDw4OgiTfRfPS+1bPsfrYRYbmkLmhxeatPrAfUMpXJWpzuKPk4rJcI?=
 =?us-ascii?Q?Ss2d5OCnR6+ZqeMwlWWyyjKWna85XHLFhSgMFKxRwKBxlt/IHCOPyTGKjRVI?=
 =?us-ascii?Q?Muo4md+4d/LAd8F0nI+SeDj5SQprMfP7ovLVHQ/kMuW0YPCpLSCIqLxq6H/Y?=
 =?us-ascii?Q?W/RENWdKj5QeSI6vAolkYKoM04PMAuKHwKajdlxorpxm4WG1v3w2pKwsB42q?=
 =?us-ascii?Q?4PyBcHiVFInvL8Fm/R2Yx8MIw9O36NBjD8jzEELPvDs5evq7y9kFFrKPaENa?=
 =?us-ascii?Q?YacAlTBmNsb/tOFMSwuQLqaTxitVKHqVTOAu++Zx15IYOypEt3Pqxba5kenq?=
 =?us-ascii?Q?FFsBu/ZCT9I17088HIAD27cVCPNci6hO5aAanESMUUlOoC297j09JNHlDWA/?=
 =?us-ascii?Q?X6fzDmrkSwG6I6ym9YNIft9Q2R5FsXG3Zso8VDUonqt0gkU/VC12QTwVMkpu?=
 =?us-ascii?Q?funmJXbwRM9jB3aDZHZ0N00iagMZePnFMWETsbg0DF9rKdnLpltRneoUWcox?=
 =?us-ascii?Q?XjAFZ8GAttNEHoLzr5inzIOLRMwl+2nrrIl1qkwR/94Z3P+PV56BW16jTWtz?=
 =?us-ascii?Q?PwoUsMT6hi3kiSe2oAwPXugB/EValtCUtayn5KrzCwHHnusBs8Chy5pLyQnD?=
 =?us-ascii?Q?d8szbD4drAH2r3bbNYAGJvSv/MPpwLwA1UszpPhfLzkY5qpDAQX5410HV6Om?=
 =?us-ascii?Q?sRD4HJhGe45x4gbcXiD6q9FtAlAQekpJUJrrlf8p4vnSs3A5yYprDuSrzy8D?=
 =?us-ascii?Q?5PHv5lTD6Tu6yTOulN9RIP8FsZlyPwB0xGw58elbR+FIzzD7Jy5QUL45wIJE?=
 =?us-ascii?Q?rxhP6AvzPT2Qf7oUka+xS2euEfPfDb3LpavdEV6SfOBesfFW3Asb95Qse7EK?=
 =?us-ascii?Q?QGcLjcjeRmOB9/ED21R+PH+eEZXIGYYEONgVEJG/qx/AUJstiqi/qf2Bljin?=
 =?us-ascii?Q?IPLWfqOCiecWj8rOc+GVAy8W8YIXNbONj+xJM5soLGBBL8CV+XoxPNp+B0To?=
 =?us-ascii?Q?RALTI5WfOyqahn0a/Rj5jmlpENMhoUb47WppPHxbPm99ILtMeyndRITWDLo2?=
 =?us-ascii?Q?vgacG23Kru9f5j3HTukQ1ClYiEVGsKOupRWg0ZSZ87IvQwSKu+pRcSq0/a5q?=
 =?us-ascii?Q?gPyrONJhp34xZaBom7/l6M9rATR2nMLBapAjbRdAvcWVZaDjjrwnrEOEyaDt?=
 =?us-ascii?Q?zPZ/VvBurnc9gy/DfXu8JOkzN6qBb9y5Td/FselGeRlcOuNhXEV4+ERB5JhA?=
 =?us-ascii?Q?OA8Ym/b9khjUePsuvKwBjtrYqaTtbasYdt9BT5fmFBBEjoazqoco1yhC5SO0?=
 =?us-ascii?Q?UC//ek/tBKwZn0LuCTVhR08x16+b4MWNb8iJllPTRsFj2T6OGw+wAiujnmNX?=
 =?us-ascii?Q?1J9/4T7LQAYMNLg7BWLnhtJhy2dL/1Keep8z1CPeXsrUJIdhcm00+Hx6HWHS?=
 =?us-ascii?Q?0eVb7YNy7BIoW9U=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?K0xKOXCyIvoydTGuCG/sEn8BYERg4PzOe9D6kIQx1DtZGRbXpYuKzVy/t7of?=
 =?us-ascii?Q?xZ1INW7X07ii3uo++roNwW5m0/Anc2b85/b+bK2r9lyd9UqruTuK+El2F4bx?=
 =?us-ascii?Q?9ZSNg/q8LPTBA2MdtZUfiY10D/IzHwt9YDXRRHkjEsy6xkEaSVwltoBHqFin?=
 =?us-ascii?Q?YAv3CUsuUr4uXJhAQ1u96ENdIq31vM47QkgMAW2ttarf/kT5zTwPvWXOxP1Z?=
 =?us-ascii?Q?P4Qq6WdpNzHnyODylBjFfyINRdZcIcb1fnepnnVG28FPOT2GRyVLl7oErM7y?=
 =?us-ascii?Q?rC+lxuvLyzGeM9EVd/Ugh3UckQh06635RkcIZ+YdbOEd8fenJ0l+YTaWjU4G?=
 =?us-ascii?Q?q0URGgyRYTPHccKOgZSejNIQQNmrvl1nGhTCnW5vdexJvDoEpIEH2VEX8lZl?=
 =?us-ascii?Q?QIqPIPPnVz9Ekz89sq9xjq1e5ARHCArkFSxhmj5y5wNRqcGvvEEUaqE20ahM?=
 =?us-ascii?Q?XEEIAVhs3Z56hbSBLN9blq0cJf5y85OEJtEBFhD3rqV84ZANDkWHPcQVgNV1?=
 =?us-ascii?Q?vgAc+JOluhmzZAurGnU4DM+qnVFx1kl+8MWRB7XRLt+5qjR/C/hHu8qxZjPZ?=
 =?us-ascii?Q?FXRt+l7RLDYfJZS1Q0SFFMAJCU9Pya2xBP3XM33o0KJCC2k6vLylrilWJd8n?=
 =?us-ascii?Q?az1IMO50st9MTUCmRX9e0XJUtRWa+khVHA6q85201H+jXp5jWkgqdO7GfQUC?=
 =?us-ascii?Q?oDSupRunYLsxORa6+0v3KhP+Kp4/QBxgNPsalmSYLh/P9MdVQTr+p+bZ1hUC?=
 =?us-ascii?Q?m99sU8IyJODGC6hXgfGUnXE1/Aw7j7n1aYhB5QTlcsPRGck7IGK6gP7gJZ2f?=
 =?us-ascii?Q?Y06I+oOzj9C0CxaX5Gks46m0ZH0jbuibWTQjUSXaq4/ugHj31X0ySsBjluJ8?=
 =?us-ascii?Q?sH+dLz2Mx2FRD2mDcBmMX+PlZmZ7DJXY451IBXYlG1SZBTu90r8o+LzdoAzf?=
 =?us-ascii?Q?GS+PE0GX1xfHbjbd+6Ru3ElFZTJQuKSA00yXw9YuJHGUv71Xt/tLSeZMC/KH?=
 =?us-ascii?Q?UBUTfVprWV0CrJLhdXWl713cApIfsGuY1Z3EQYGc4XY1+lgcu2BhicZlIBkN?=
 =?us-ascii?Q?kQtsgLFgg/uznFdvpVxiZiZeL3TSfYqcliXinzlD5yJE/zFku3/JsDCbbw8R?=
 =?us-ascii?Q?4qJZ9vy1KGqk1JicT+FeUsGdNCqqene2VUyOrCt6aZ9biHZlx0m2B+uJ5J37?=
 =?us-ascii?Q?Rsfa3xuPcY9lYOldvWG34+PgrnKVQYQqtO84GdYjIEylhfkYGCpRFYmTZriH?=
 =?us-ascii?Q?iI/cRdKtO1xXflJCn/GZmHjbmce4gaNKaxalx4intdlNcAII8MBnVkzSRBxI?=
 =?us-ascii?Q?9BnvtIHcmuCVkXVCE0cj4BTx3H3zirt4qC68ioSchQFf/rWptbq/CrFN8AB9?=
 =?us-ascii?Q?AZ3h+2nMphdP3SVz5iuOTm9kPtV+BBdaCv2xGXxL2kz5QILfQlYTTYGIzZjb?=
 =?us-ascii?Q?mSXvrkGsoPoXmj6y2UBk6e1CagEia6yt+Z+yYOHBpsREY8T9g9mtUURbOBw5?=
 =?us-ascii?Q?qyql3fTeOAfdvOUbVju4NOaXpJ2G3zFSzdBGfltL1VyRKQN2PDXpOcW1Slz/?=
 =?us-ascii?Q?qg/1FUGFWm0b/oMA9DPuxWAMmw+xT1n8MkCGHhf5TFflVrRlO7+IJ9nYHFFy?=
 =?us-ascii?Q?Wc9Ss2g0Nr/xOV/f1uWlGU0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361a1cb2-1cd6-4b9d-13c6-08ddbada3df7
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:07:46.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/8IcmHMbYD72GZCidEeXorN9gnEPBiXos5+QUUD4oUlYwGJhRkL6cLs2T5uUhXA3UwoYo9YHzgXleta/Q+GLS9ikoJono0GNDiGpJ3Bt8bwgmr5M+bEJqlWPbGCbfKZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:07:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19344

Dear All,

This series adds support for the RZ/G3E ICU driver into linux 6.12.y-cip.

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:
 - The TINT register base offset is 0x800 instead of zero.
 - The number of supported GPIO interrupts for TINT selection is 141
   instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

This series applies on top of [1]

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D978150&stat=
e=3D%2A&archive=3Dboth

Thanks & Regards,
Tommaso

Biju Das (14):
  dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E
    SoC
  irqchip/renesas-rzv2h: Fix wrong variable usage in
    rzv2h_tint_set_type()
  irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
  irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
  irqchip/renesas-rzv2h: Use
    devm_reset_control_get_exclusive_deasserted()
  irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()
  irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
  irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
  irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
  irqchip/renesas-rzv2h: Update TSSR_TIEN macro
  irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
  irqchip/renesas-rzv2h: Add RZ/G3E support
  irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
  arm64: dts: renesas: r9a09g047: Add ICU node

Fabrizio Castro (2):
  dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt
    Controller
  irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver

Philipp Zabel (2):
  reset: replace boolean parameters with flags parameter
  reset: Add devres helpers to request pre-deasserted reset controls

 .../renesas,rzv2h-icu.yaml                    | 280 ++++++++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  90 +++
 drivers/irqchip/Kconfig                       |   7 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-renesas-rzv2h.c           | 601 ++++++++++++++++++
 drivers/reset/core.c                          | 119 +++-
 drivers/soc/renesas/Kconfig                   |   1 +
 include/linux/reset.h                         | 274 ++++++--
 8 files changed, 1278 insertions(+), 95 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
renesas,rzv2h-icu.yaml
 create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c

--=20
2.43.0


