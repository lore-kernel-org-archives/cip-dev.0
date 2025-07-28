Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0981C87FCE
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:48:07 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.62])
 by mx.groups.io with SMTP id smtpd.web11.81875.1753710481295114634
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:48:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qD3HR1do;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApTNg3ydD+p4I517scDmQQprctEa7kqXCCodQColEET3+lOV+7sfGXezSUPsRJKA+tCRNI42zPMOwyxL6ubX+XWqv/gh75EO1PbsWkFJCBfj+IBkw/DuqyLjO3C4zQyxkxpCakx65HwEEMzAc0CdB655HMv8vJZgqghlQbOa4HE/fq0uSRc08361sBUzSH1JIvtIzfd7DOvznsaJOpEuIqEPGtY5Pt/dXV2LvgcgB7bYrUdFRh8JV6uhJ8O3rcyO+2LfUKWyMNH2vHyAwxvvUmyO9Z+q7BmUhNS7ADHZDokaZPH8SWgnTW9T7YmNtbLDw9k0aSr4PkviTFw3tFmdfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kI5OBiUfCiNCKZ0On5VP3swpRDUMqLXEPRWikOM7Rg=;
 b=s+h/gBuwbQY+eCq9iIjF2Ms8b33Xdw3WMTUkLDTAmjeAC1b0XYtVy9/zTAMeII5gPE6MA6rObGspYMBmsdUSGUZHXYeC5a69q/VX0Lo8P2elgQqI2+bj97vEuQeHl0w8IMTQSQDFeeVzB5E6DJxOFRnOqdx6S0pKKIAhS3WiVJ1Ko4XBEdG+rOjhrUC6BdgAAz4vcH9nPP6HhevItoVZxVnkqG+5CeWmuK/CkkjmO9IjhD1mZOZ6q5DPneVv9en7oucRgi635txN03meeHwF41n415cl4Zh+j7WCaFoM2WF+3DiD0NM9o7qaP3k+O5BZmnohuGod1CnC5G7EA5uGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0kI5OBiUfCiNCKZ0On5VP3swpRDUMqLXEPRWikOM7Rg=;
 b=qD3HR1doY5+vqiCN9tEnSsQ9mMjX0KRjakdyU5BwI0atyLRibuyfTKHqqDt6+gcg/uetS1nIkKxk80u1wbIrdqtew/ufdnwOV7yBbMMYM+hyEy36xQNknD7iTBjtTbsdMvjCL+svn1H76acuurpm/AvAHeUt/RSRYeAUHggYLD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com (2603:1096:604:10b::10)
 by TY4PR01MB14280.jpnprd01.prod.outlook.com (2603:1096:405:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:47:54 +0000
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0]) by OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0%5]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:47:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc: Add I2C2 and PMIC support
Date: Mon, 28 Jul 2025 15:47:29 +0200
Message-ID: <20250728134731.1287791-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0017.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::22) To OS3PR01MB6657.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6657:EE_|TY4PR01MB14280:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d137d6e-85a2-4f17-182e-08ddcddd5a29
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YBwwKzr7OwVI85BY5LzPKpqcye9auVIqZBskmhoVVaYK53vFdxmz7etUePzX?=
 =?us-ascii?Q?ru2dHxlO4nDw/v7Y7Luu6GlSenYit8GhCKyFwLrQ/HyMzkLpMAl8qu0gzYXl?=
 =?us-ascii?Q?COGc37RDVJgGNe+sK/dZVLbjR0cL/Sx/OvP1Ti4VK3Y5xYDfwYJXsJ6JSN6s?=
 =?us-ascii?Q?PVToIuMynhEn2CjU4xG/XTodlSGcbaHmmBt74ian9XJJtovM0MrMvuL/YY4v?=
 =?us-ascii?Q?xZp+539vv+/YDwb8s94ChBtqhe+SBn5ebx9jPLwdkf+WVBRQscp2N2Iu83ZA?=
 =?us-ascii?Q?SyOKMSacABXOoRhyfyjhwx6f3Cowujce+w9uabnvjrNK9lif00uCeumGOiE8?=
 =?us-ascii?Q?CbeDDQW7kuW0jIgGm7Vwipfzn04ZZSGrSaGz52UI+EzmHLXVKQsUswywfbqE?=
 =?us-ascii?Q?TJrjW/qPZtjfQxa2UO22wm1iECrdyvQdvQHHc3sFwoiECCODQAWocW7f4Tgm?=
 =?us-ascii?Q?5mkQ5C6k56lHlVh/lBoGfSA1xYvSArHoIUZeh+J5+d5hKAzq5NotXw5r2CUe?=
 =?us-ascii?Q?/ws6+Y9yH2qUouUtKC4W2AxbmFccehNljxH1o8DyQtFoHueWlC59VRsETq0K?=
 =?us-ascii?Q?zXvKdwP05FVtgNQvoUk6GubljaDaWCXu1LfrQ30USFFqKy4PJcvY/7qxL4V/?=
 =?us-ascii?Q?RoBksdsYhz0UaMZKY86FoPw7hM3dcMtT4/CrNHFo0Az56WZslvZkcVij8Sr9?=
 =?us-ascii?Q?eXU6pV3gcbYhd9i4j5Gz9/uhi8XVJDb0zJSa3BG8G57QaqW1zW0twqKtox9p?=
 =?us-ascii?Q?fBSIKezU1HDCoWTqgRHeO2ZEPy2LSRKSbiU0sUh2gXvt5zQu9z73/OCK+fmv?=
 =?us-ascii?Q?zGyNGDd2dXKlvLN3GUB1hb0sr4DUGryRWSLOjXDSIAu5Mt6skZtvTEHIOeGD?=
 =?us-ascii?Q?BH/j6566h7DGWqpXRwF4H7Hd5cfhiCtsaeJcuThJ1xwCscgSwJpesqqTTQbV?=
 =?us-ascii?Q?Om9HqQau0LaVWzhFAII0y0W1qbFPemAsTg24Y/yndWubEepFP12yHAodmA58?=
 =?us-ascii?Q?lMpZp17atDNs1yHy4kb9LIEj0zpC16QYnH848WptRf3MCJ0esGnUgqkUGzfP?=
 =?us-ascii?Q?b4VdT2HnEiO0w2th5/QtricqGVZTxpipt7LPS1FGQhE8TcwDHK223U6tHczD?=
 =?us-ascii?Q?d1kO4sCRFC9wi7JyxCFG1BjTCQWZMeSnoABF1KHfoqxHGvkUrYzFClfP9wud?=
 =?us-ascii?Q?P4kLbfEgwMw9vwXVP39agdtRvTYPNbbFJwlmdS+VxBPLsLMerw+V7k272F5X?=
 =?us-ascii?Q?R2JjefKSIocwa+W9Mc0ExhBh8L+z0sphdtnQY1Ii5ktGo6XO4XYbhfuhre1c?=
 =?us-ascii?Q?joBRCmCYxC+RshV4/XxNhwBdF0mVXeO7/IudjdYa+Fgg3kW+06UUlPe4rWcR?=
 =?us-ascii?Q?y2jrSPhcUu2wHbs1riHLMwnJEq/IKHDTjL0N/DM1tMtuuoEdlnTKp8RnyoNr?=
 =?us-ascii?Q?fBfs7VexhMBsvE3uge+vDAQOWWRY1YTYBZo/oI65289dhfCnv99F7A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6657.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qJKCJ/Ji9Ihxfzm/eGjy7A11F3Adk4klOcZeROygjDEzTZwRz4y7fQfC2R4A?=
 =?us-ascii?Q?bsd8qWQ1sUyJcVlWClZD0nDLeTSkt+LdYZxImKyyJX3xf++JDKqHo1az84O9?=
 =?us-ascii?Q?d5oCYfckJLiAftfZaC1B5LqZIBV11roWkt2M666a5zeYRTtS1Ywo93zgCcxP?=
 =?us-ascii?Q?Xqj6IXLBkN96Uoecl1h0DWNKw4lE/q2EFeQgekpVNJVIvmFVwgv0adXObRvk?=
 =?us-ascii?Q?YxXj8wpmoQLtiwt84sZK3frN4L+6Or2ts76eXAetgtsAjwfZzd0rHaP5Eawo?=
 =?us-ascii?Q?89PMlY9UvDSKTzpDYqzNavO49A35Yj88nskuHnx1S5kGhfkMrRJAcJBqiU1p?=
 =?us-ascii?Q?U8FX6hKlVtVyAdaNbHvxZs2yyYCHmDYqM+aIjsPXPqp1y1+Zgox6/90BLija?=
 =?us-ascii?Q?9gdOEqkDvxx7RMDx96ruvWkTeXI0d2P4SCr6fCeZcjK4XAdYG9newVrbeNZR?=
 =?us-ascii?Q?atWX5Qm6H26jJrI1pbd4kUsT5h8Z1LFvX9xG8BHRuVnBRHhtXJSmfDgGLzUq?=
 =?us-ascii?Q?/Mim+wqvLp9ho86amZbb/EMJd0zAe9Hvb83/r2F+YwpdDBPzRgvGMmWG9FKP?=
 =?us-ascii?Q?dG4c88nNDdPu7bKi3Wvmiv0Myja9FDFENyJIboo6qDlkJoFz40KpRE7LkQj1?=
 =?us-ascii?Q?S1iz28DI+mltc+Wyw6OAOK00YKCk5XSRIgpHv4xvarVeO5H8Rt0s1iou+yDr?=
 =?us-ascii?Q?cNAXfR2DdL/LqafPeALREq2isZcUBDvrFUeTvCxQ9GVEmRYnmpa572kOVpYP?=
 =?us-ascii?Q?xZZ5bXVNjsLm1wPAs5nH1frJJNiXI/P1ZmhCj92lvuTrxfH1oReouj9bpxok?=
 =?us-ascii?Q?DUoKkwavLTdzplLgZuCJ04FQIQGLJXfZ4X+qpTUDw3VqxzSnA2KtAhAYvJed?=
 =?us-ascii?Q?d+5enb4z9wxpHBOq5dn38SO1kcpG5epDQYWO6v/NfIJFhMhrk0OSfgO/9iYi?=
 =?us-ascii?Q?CON8+XnqVbxWvTky9XPJ+qL/0dtjLQlrjZjvfFmpaUvFDYljv7q6RlK0+MpU?=
 =?us-ascii?Q?emxieMJSIaaqsFeWVuKe6jc71YU5TcIAGyaxhA1UG4H/P+C+CLbyXMXGI5ri?=
 =?us-ascii?Q?uplyXE3LEwrQGiUFXezKsEgI6QPB9G/ZZY7NqNOyYKQHf3H+rdvnLF0G9HmH?=
 =?us-ascii?Q?lMTaadggDV+tPV3YLl9UPjWElDdRuuzMZNffMpMsR+B1u5T2mk1FcHTydhDz?=
 =?us-ascii?Q?qx2lV4v1X1sK7f0sJmhg3nXr566QZlNKZcp3Vrolx8RsLY7C7kA2Le98Ge6B?=
 =?us-ascii?Q?T2e7g0sDk7RRxMHkMjC+mswyYSiSoNn6AacEj1jGWrTi7e8MjhJu0/IokISn?=
 =?us-ascii?Q?PUfCvwEAPIOM0C9jDnBZLjp2Wu9AwbVzNHa7ijhQB08fwGvgKVhmQ2dDEa5k?=
 =?us-ascii?Q?hWqO39Rb74wJTsU8ohbAm89QCeJTF1J9w0cS2Rs7mIk6QuLfnOJ3KjqBs9Z1?=
 =?us-ascii?Q?IPsB5wFfvW/z8h/gfkyBmS4KLOiBu6iq2UzlqCOuEoUkYRq7FevMPVld9n5u?=
 =?us-ascii?Q?Y+Q6JrhSwN+O0mk/Xpslvr1kQy0khAL0WxAxMywPVOePNipLapTlsZU675oy?=
 =?us-ascii?Q?LZ9AepoQANq+Jc0v9kn0ArFbBx//4jOpb8JUXZ9DIR6jylLDj4Tk4KtqAFAS?=
 =?us-ascii?Q?b+NrDBItiG0Oxjl1ZsvJnIk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d137d6e-85a2-4f17-182e-08ddcddd5a29
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6657.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:47:54.4310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JWlkxm6JUhpHb8O55H6+qtOP1tPDwI2+wNInkbuSatYDPYDY7iwAxUnQUehY45LiRAnr7owJSJQbTkIWa0AYJlU7glBDIngcvTDUrxuC2gq4kcHQ4TAxmPgLI/X0IaTj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:48:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19603

Dear All,

This patch series adds support for the Renesas RAA215300 PMIC into
linux 6.1.y-cip kernel, on the RZ/G3E SMARC EVK board.

To enable PMIC communication, the I2C2 pinctrl configuration is added first=
,
followed by the RAA215300 node.

Thanks & Regard,
Tommaso

John Madieu (2):
  arm64: dts: renesas: rzg3e-smarc-som: Add I2C2 device pincontrol
  arm64: dts: renesas: rzg3e-smarc-som: Add RAA215300 pmic support

 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

--=20
2.43.0


