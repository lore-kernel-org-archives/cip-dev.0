Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0A4C83F04
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:36:03 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.web11.20547.1751452555834169188
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:35:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lgBVvb9F;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWhTkkyu6fYRDFiGqv0ZTEe/qdPaJTCT+H0pap2NlCyni3zChBvZlMGjfMGGLgw0cSvizoTt6shbDl9ZNrod6gNgt8VicoPlA5L6vRY+rGzObg5Fu4tlALq8kmTcDHHHZp5QFOE+dEAU0imxaCX+uFUcIzeqHI46fn3qbOWB6C5d9P44AnKYRbAjeWMzzjPHMob6Npx51paeN/a+FxjWOPGH2gj8IRb1RHFA5/CBiCUgP3z5aHQa3G6VGU6B/CzTANFTNH6/9fF4NoWlcRqWxgd9pH6LwdpwftnXuVG8JWNpWgVpnIebThvOA9LuiqXbE3F9gT/h5Aqjw5r0OLi/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAaW3HsLUQvNVa6rgjxuOkIkDZHQ/11+DkBgjJJRFpM=;
 b=xKbo+NZ7OPJ7u5ANCTsWKXx+KBSu6Z4ZDWPVRHJPnUwJVlRXA35rXY71JPmpsp9/hnrDcvTG7DnyC2GfxWQgFSO9Gj57yXrkmnRdvZ0IUIZPL9JFjPXjHI2ThFd1iTG66YVxGKtd8XDjQDAgIlNb1JxRlbxjBGIUZ+SiewnVOMi62b1TInAi40i+XtdmxtdUkiT9XJm19Xf9klOUSbOasuDxm8GMPR6LKdGuDlS9yT/aasLWdEce98dncqnJ+n9fpvC83gZbv3NwHnz3eLuKRJj5j0Id7Vz7TSXUbbGgdy1WSSH+0Z2TxxFxAtWtUTkYED8cV7OA/1fifTYZ+4KZyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAaW3HsLUQvNVa6rgjxuOkIkDZHQ/11+DkBgjJJRFpM=;
 b=lgBVvb9FN9aiWAMlL/oEZofdMfKpNdRAgKiec4GfurpdxaTnirJI/HMUuFHJ3b4dnzU2tuWR0+PZdCVlkAyBLrLWU1VZorw+vV0eETPYg8EvIQTmvdcyO+l6Ht6/dIGYreBtZajUmcMtciiWGlj7I+KHgaeNP5mDhI4wPfV5cCc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB14154.jpnprd01.prod.outlook.com (2603:1096:604:363::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:35:48 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:35:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/12] Add support for Mali-G52 to RZ/G3E SoC
Date: Wed,  2 Jul 2025 12:35:13 +0200
Message-ID: <20250702103525.117166-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0146.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB14154:EE_
X-MS-Office365-Filtering-Correlation-Id: d77e06fe-b5fb-4f5e-7c1f-08ddb9543571
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HKuKZDlp6LtzEsfa/yYUVa89wfsXYthapRl9Mmm3rqe6TmJdxlICON5ZZvo+?=
 =?us-ascii?Q?NjAFi0kqo0KB6kqtkGnyeNI1Qs4/X9eItGPiv0ib0rXfqLSMGXDrwDf3BCE2?=
 =?us-ascii?Q?h3fxfVSZvYBOyQ3TKQ42PixmjsG3eqMkm2SSaThx2MEzTmOmP4R3sW8BOjgp?=
 =?us-ascii?Q?sVvravfX4wbHO9CawjIoCvgzKUwBKCYjGXmly8y7onFaaZLaezANfSWyuERA?=
 =?us-ascii?Q?rSSp/WXh9vrxJBQZQn2m1hHirMXu/XDC7zVDQaihaTmnctoKb7HtcgDM0GeH?=
 =?us-ascii?Q?HHM1FE2QtGAv8ZUQNUJyOvrE6RFwJCvZ6NcxOxEjVypGddfQ+rqwJx5Ma3be?=
 =?us-ascii?Q?mfbbijO2mMXr+2/9mKOhIOqAubD9/JwxdHOfoFRy/1uXEn5Wux++F3mpcs7R?=
 =?us-ascii?Q?oVIqOr3A8itxWZf8KqWMyVFKFG5FSFbFSDHfZGjqUoDLHR0znIuWrQVgRZgL?=
 =?us-ascii?Q?wRrSYzV7ZmFmZC1L6/58/jOX5ImapL0H40M7eYmDXAVrB0vYCHRSDDayWA5A?=
 =?us-ascii?Q?Hh6Y87dTpC1u1NB7Ws61aCeVVM+qZieFiukbracIvGUCNRi9B6kBieW2jegr?=
 =?us-ascii?Q?dxyQsbMXTK8mbdl7Mq6LV9YSKTzdPY6FXVXa9BSUzLnDJRRuEksDbzvU1snZ?=
 =?us-ascii?Q?xOubnd0TGmMwjMZgJZQqgsRTJ+M6ms+zKW8IUOaoR0PC8UZmD47o7FaCSWuO?=
 =?us-ascii?Q?EEClDXFW1u14OwtO1NaMyEqqeGoXssuQRb9SISb32dUYByoTWTVgXRLe+aNc?=
 =?us-ascii?Q?7iUxe9YRCkzNvajd/8OPuwyEBR24dC+P+Qw0Tyjh7V0MUcAmGDygSBsjESkn?=
 =?us-ascii?Q?dyMTw7pKqzolo3JpnY1Oa1oWvu5mxIcojbY8jbEnux08XpFBa2CYSOSGG/xz?=
 =?us-ascii?Q?E6boSFHw3K1bwX29Kr55lrgJTZYvvf8tg5aBXX1BIvXECoo1qohUEgb7d0b4?=
 =?us-ascii?Q?6JYn8p5Gfqsi3LM4UDgmpf8H37TYmNngGSfi0hbbkF/iiUHGjzniMBtrwd80?=
 =?us-ascii?Q?UKJTL2728rP0EfGsFN1sCJx3k8EEq/91SBoUM0bJUHs0Ogv1zTg8LTqb3ZdW?=
 =?us-ascii?Q?Ril6H7NGgi4eFOO5Cb95b9iRBaJkPVRCVn2GD01C8KwrBD4mLDVAnMZF6RYN?=
 =?us-ascii?Q?yyaAlxdCjU2F0RG3+IljLi3htMUyE0+gqPU17y6sfOrRq7qplptjz7cMs4mw?=
 =?us-ascii?Q?uXQRy47jI6f3CMYAIIbLS45/Ozl1YIfcCGooCdFCFVxp9q4EFGjpoBDNFpUS?=
 =?us-ascii?Q?nkv9O6jWohy2F2GhVeQG+7WY8iBOWkcV3EDTyYmVdWNSKscF4yHJmzbCnLZG?=
 =?us-ascii?Q?Q3xEoa0zDmb9deKg7sbkHFJD8Ipx1pinJXhjz3/jgcNyNKwj0m09n1pImy/2?=
 =?us-ascii?Q?kc7yUby7EvRD9ZldIZjvd2J2/Ch6zMSp2Yq4DXIHh1+Km9Pbr1Ayt/IPipO7?=
 =?us-ascii?Q?25fcsxCDSVQDjXJU3qVN6pedEOccKB8BmNqhut16gLrYo+dpbHFFYw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m4o3C2lxUmvJAcN2UABaPlSF1teAzh7BpZVpQRNwIKtw5Cv0i9Aajg4hjTHX?=
 =?us-ascii?Q?KwBXqIVW+3F+AUuxP1YuYJIjzUcUf5vsMs2Gpx8mAtrnIlRHbUYLWNWBrMZT?=
 =?us-ascii?Q?8Nmqi2FjTGxS3Mjz6uKlgIhJj9nvsp6JCx98ZKzK0N30+2uP/8SKfQcOsGE2?=
 =?us-ascii?Q?pJCwupNekL0w8Ls4SLGkiai8Qr2FBlx1ykMG11zCzzOqGyl++JTxr7UgTU6G?=
 =?us-ascii?Q?M+wO7DRclw2qxhPRbVPBIEK0WUsJPEimmL7FtwQI+MARd525koG0lNo7uhz5?=
 =?us-ascii?Q?43rBoOZNiLEo2toOuLeWwH9GLOrz7G1Zg9Tsr+LONpxG63QUyuTdUnmnlOad?=
 =?us-ascii?Q?p37BMPhiP+UP7mT54T2LRBZDZW0OfBeObGmL3D9mBOb79K8VbEwTpj/WLGsW?=
 =?us-ascii?Q?tlT+kx3zFl6NNTxTUjqIW0y7p4BRegcdzyElvHt0zmvH9RGoF+67g2TuoGGP?=
 =?us-ascii?Q?dEf+MNZjvUdWZVZApqkbkEKV/CEfRgekjBqf5zGKoK3efzvKK19HopBdTDvN?=
 =?us-ascii?Q?uodxpG4/9Q9x1sU3nZr3/zRGRKc07hHsz5th549xjZykX4QOjX3NBuAx7k34?=
 =?us-ascii?Q?pjGBGofQo+dYHwUOmg105OdajyAPwgCjX/ryffBMMRwAB7w5mg2RnX4dEEUU?=
 =?us-ascii?Q?jop4v49MpfPpxwxKV6gRcTnG62vIYIbNlyBnt1CehNPjrlg+woL31j5NrWou?=
 =?us-ascii?Q?CxmkSxMbTF0h3CLdBgNG7sTrS02I5VdcBWn89G8X+coNrR7tXXtuRPFzhmyf?=
 =?us-ascii?Q?1S30XIfk2abue9aom5OIZmrAu0db1b4FQaUgY0IgAYmStUj8A7SmNkbuyBvn?=
 =?us-ascii?Q?QQev6gQF0ew7gN6nDWQgN8R82EuAudlaxWlinPk0gB2IrUrRc86AN1Gh4+3H?=
 =?us-ascii?Q?MseloOM/QKgYA0Vyuk+hNdITud6WBa9WnCsmFgmdMMdhqDb6VvWZD+w/Vhwm?=
 =?us-ascii?Q?RQsdUqQHKRuZFsZXNOGrGdKOWoaGTZG2ZoGt1adfCAu9reQIl9MRjZPN5R+x?=
 =?us-ascii?Q?a2Ff1TpsNnoO3Fc3qroghTfRUMeWxy+/UBRX+yVtbMJ7+eLWrEUzx9SU06ml?=
 =?us-ascii?Q?R054BQCIesFfRzaT/FO//6AdBupHMU5Mwwix/8pZcIAhQK+K/DZtF6RTEYfw?=
 =?us-ascii?Q?diiqWI4nlWllPf3vf+QJ69hiWS1FzZZOKRgt8v+OsC8RNE1+xWVg1fAQKqoc?=
 =?us-ascii?Q?fAuSDra8XMfXpJ7D3PxmpeRLTla59MFt1bFOAwE/hQoeVO5mmys8SqlSphYn?=
 =?us-ascii?Q?mqFBQI/rKupa9EOyQCIGQDvZNXEbQGIcnkr9Afkhh1sSgZHLEXpZUpp/UA7X?=
 =?us-ascii?Q?wObLZIS62ArA50qjpVM6qV5qfQXEcpOytVPpLUVU9NIhagt5luq48Xl13PQO?=
 =?us-ascii?Q?agL2sqza1sRc930mgtgUWSUA6AAWOvwEQ131S68nk8zXmatOlJukJSGstnKh?=
 =?us-ascii?Q?PAw/B/eim9+zhvwncT+ZuVZy/+G9nPtZq4qxqfVVeyEO6pNSAgF23VptJxuf?=
 =?us-ascii?Q?1IRYvTsJo/yOKWHjLM8ml72rfu9b0pdURE7YJ2HQo2i+xjKJ+X9Htg0R8dZS?=
 =?us-ascii?Q?11XuTxJVwTXXEGxkjIzFDsPepnsoaKjgaOZgLq5DwJfOKTGuWvr8SHXMAV0o?=
 =?us-ascii?Q?9HS8No7jBfPR2u8TNHKI+Fg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77e06fe-b5fb-4f5e-7c1f-08ddb9543571
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:35:48.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+W9QoLVsWJtNRPNBtavWRsShcpbfEpJZ48ALxFuX2/eZX18SC5AvOoQxs7gIebX/sdo9Y9LGruo49SZlgmpOHAtGyQzu+KaHVe0LKuMBuK0XdOL8mUtLQdRyPe3dVjA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:36:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19285

Dear All,

This patch series adds support for the Mali-G52 GPU on the RZ/G3E SoC into
linux-cip 6.1.y Linux Kernel.

The changes include updating the device tree bindings, adding the GPU node
to the SoC device tree, and enabling the GPU on the R9A09G047E57 SMARC SoM =
board.

Thanks & Regards,
Tommaso

Biju Das (2):
  clk: renesas: r9a09g047: Add ICU clock/reset
  clk: renesas: r9a09g047: Add CANFD clocks and resets

Fabrizio Castro (1):
  clk: renesas: r9a09g057: Add entries for the DMACs

John Madieu (1):
  clk: renesas: r9a09g047: Add clock and reset signals for the TSU IP

Lad Prabhakar (3):
  clk: renesas: rzv2h: Refactor PLL configuration handling
  clk: renesas: r9a09g057: Add clock and reset entries for GE3D
  dt-bindings: gpu: mali-bifrost: Add compatible for RZ/V2H(P) SoC

Tommaso Merciai (5):
  clk: renesas: r9a09g047: Add CRU0 clocks and resets
  clk: renesas: r9a09g047: Add clock and reset entries for GE3D
  dt-bindings: gpu: mali-bifrost: Add compatible for RZ/G3E SoC
  arm64: dts: renesas: r9a09g047: Add Mali-G52 GPU node
  arm64: dts: renesas: rzg3e-smarc-som: Enable Mali-G52

 .../bindings/gpu/arm,mali-bifrost.yaml        |  4 ++
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    | 49 +++++++++++++++++
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 15 ++++++
 drivers/clk/renesas/r9a09g047-cpg.c           | 53 ++++++++++++++++++-
 drivers/clk/renesas/r9a09g057-cpg.c           | 40 +++++++++++++-
 drivers/clk/renesas/rzv2h-cpg.c               | 13 +++--
 drivers/clk/renesas/rzv2h-cpg.h               | 34 +++++++++---
 7 files changed, 193 insertions(+), 15 deletions(-)

--=20
2.43.0


