Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F1EC87FC9
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 13:49:07 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.58])
 by mx.groups.io with SMTP id smtpd.web10.81585.1753710544498144925
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 06:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ld6icwuu;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.58, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Q7415JJ4yD6fxPfKIZpYbR51NXdcUdrfXtYOXLmKOt7m1NE5yNK4ywX+y19TVk0S9VIgrzLcHsuyQBhwlVWtCV06PcfMleSWOWPbPg1vRUpvU0pKDVusjhxAbbFX378wLTDWJmyoS5KrEeyuJ3NA0kA6u84IUaKOfK9SEYE4Yob3GRRozYHYK4G7VHsK7klLYjkaJXx/3DzLYk9JUa0+kDbVG8GJYooWp79gfAGpka01Ap9L7pplIQXc+OO2AfOdK/a8hdiVSMI7cFSFuiSmWHz63j2InR/+aCmrbqQ82f1U7aBTd8f6BQDXnNK3tLhXVMOcZWjRlm7HI4/5IvUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgYpR6xQg9hcuKw1zTZ+gjcL15AqLTNAjbcw56pm/+g=;
 b=HRjXY7XWdY0KtQTddymy/FGUDzbNdjMYQLmBCHP6LWOHjaa02KmekhJbjMN0t4Tx/Th3m3Jg4K1jTobPx21h974Qj/uq7eALZGuScw4wnTaoEWM4WGLf6GUyyTHt6uLOOVeE6qjU8CO4Fwl2rwtfRV5AF69r6h6NI62i/G/e6yysaBLg9p3C/CDatDPxNVQAZxQoGp+Xd9ejUusrdW5xnJlB3k2TX3hSeZStgrv+Iubygrkho2wPmojcU6B8NI6Q+qCw0nHv99FvT9YKpspFptj+kjRQ0HeK6hIUw9Q5JzCNfDYBbk58VIunD+u9yIfF8OoKKqSyhtBLSjUTL9cIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgYpR6xQg9hcuKw1zTZ+gjcL15AqLTNAjbcw56pm/+g=;
 b=ld6icwuu2/UuHkqTz4SiESSFUsdjCayIcdmmOUp06YY+1wNH49CtupdaY6t7Jdcdf+GkmtyjL1UOlyUkrUZoZlYEU5okdGAGWKCt4IbhTenDmZmzf976+i12Cd1SDMLw1a0EKB/E/JaL+p0TydXw6pd2YxRQ59RNk1ELXQz+DOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com (2603:1096:604:10b::10)
 by TY4PR01MB14280.jpnprd01.prod.outlook.com (2603:1096:405:209::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:49:01 +0000
Received: from OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0]) by OS3PR01MB6657.jpnprd01.prod.outlook.com
 ([fe80::8575:e22a:3c44:76f0%5]) with mapi id 15.20.8964.026; Mon, 28 Jul 2025
 13:49:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 0/2] arm64: dts: renesas: r9a09g047e57-smarc: Add I2C2 and PMIC support
Date: Mon, 28 Jul 2025 15:48:42 +0200
Message-ID: <20250728134844.1288347-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0150.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::6) To OS3PR01MB6657.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6657:EE_|TY4PR01MB14280:EE_
X-MS-Office365-Filtering-Correlation-Id: b6b6e8eb-b352-4813-d2a8-08ddcddd8219
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?r8s5EJVYdQV60phWniWP9cdsUA+YdJkqYgVDAJnWfgXxqvAx21RYb/1ersEM?=
 =?us-ascii?Q?OOKtDsA0eh2Fpe/hpSS/m1QZ3s+arl4TrOVn4/KsFzG2Ok3KIFNqMLUXXs1h?=
 =?us-ascii?Q?HRetS39YepeLo5Sq8sgB7V03aBcDmi2JhdVzpH5z4YmtHh3Vze69L9sUeDhr?=
 =?us-ascii?Q?xcp7hTwJOkocSfFkFVV2bJJmV7E1yoO7doGpYI0zr2MQA7uWxLzg0dXQpyml?=
 =?us-ascii?Q?qFyPRMPu6rHP+fWb28cjWowET2F9IhTdb8cyrCCeRXPUJzY60cI3wq2ACzmD?=
 =?us-ascii?Q?bYo95qlaQBQgpWKQtBEXLFhQqVhI4dz8g7x/hq7UiAhQLQIdqGFPA2jXs64j?=
 =?us-ascii?Q?S8sNyNy5ZB0V1MO0S6xTVSEe+Y86nJFIb+E3jnAXygFed+yapDcL3teZ4Qdp?=
 =?us-ascii?Q?sUEGz/CnamstO8rrYcc2wTmUMG459wFweOpqcHW3INAoOAKb4uIB+J7/Y6eR?=
 =?us-ascii?Q?IbVmOpZAJJNrZDVrK5kclglb6jbnvcoiNG+6aw1pF4hl0m9bxJkc5CX8acAW?=
 =?us-ascii?Q?sPAY8m/VvvJJ3fd/YrvBor3JLqTxl2cNMAVbJiBbZxLov8BMdFtrj7mDZ0TT?=
 =?us-ascii?Q?GqlzFt8OQNGh0wOvBEF/+UvbiaWga4xotbkxMmVrnvdVypxhwvSG5xhILQd8?=
 =?us-ascii?Q?Do2Bmt2SgfnaebHFpR1suwTilgUDBIRcBkWdaUtJAVbaWPvSJq3Mn3j5Twiu?=
 =?us-ascii?Q?17NxZ6+VnlPXuZDDvHvEZa+M8ZIwMHKebdMNFqLIYNpWFxZSJOfL28w7pB+R?=
 =?us-ascii?Q?BrwK+dD9gHJRgjCf2p5HiNcQ8NVaSHoTgKoqiHsNptMmq6Skna6jD7yzI8yH?=
 =?us-ascii?Q?uq45rlawmglrhjxe4RQ7/2eX+VyQoYYvGY1Gkk3ghUHKDvzERAu/uGny056G?=
 =?us-ascii?Q?ukJNC9gMOnSw/zc4GJa+hPZ6R8ZWi9rYiBQ1yUUDtN858G+mwhqd0inC6ct2?=
 =?us-ascii?Q?XCauBlzuKDvLiDAI1j/9vx9fDW8iIPDJSe/V14j0OkYWUJBsuDRiI7rkrZmB?=
 =?us-ascii?Q?rzQYIHVhzVy7V59EgIHrAbfZWTnuqPJwENH482h1hxhV4pB1gdvcgyTwpsEg?=
 =?us-ascii?Q?t4fw79yYT1Tyl/QUbv0jE5OtvI7GcC4QPdzOx8A4sjm3NE+pM0OcqfGlfOVl?=
 =?us-ascii?Q?t6qp9jF7mQVLgeZTzJVzm2NV/rGFuVIrnn315gN8PHiIvkRXxLiYEjmBM6p0?=
 =?us-ascii?Q?eDr8fg+KZecOvG8jU7tIAurZINyT+0lYXbqjQcxsdah+m6AloINq5QPs3wdx?=
 =?us-ascii?Q?wUWYw1PmQZ4ge9aKYu47gliSgCWpRgtJiFIaCVo1WqO9XhEiV8iuUWn3dQqd?=
 =?us-ascii?Q?+4I6/nbpbecvJn1DBrQUOE4ID1gKbqUFIue69FRibWsmaZMSn+HeXXGpmtta?=
 =?us-ascii?Q?DtxSwTvvD/jxA8IVm2W1i5GehCJq1TbzE/FFlZWIQ8e+nO4M/5Ubb1Hq0uEr?=
 =?us-ascii?Q?bTsSY/gHyK+SaDDF3GmEaMIS/3y4K7jtQ9r5/BVzKrjBuyY5gaZKWQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6657.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?IfuA40j97JSfOlMfZTqvu0m/6oHKJx/to+S4gDFuyz9y7Yyffup+Kq6DP0Qj?=
 =?us-ascii?Q?ivr3gfk8Ty0DbKTU0Ic0Af99Lc04aadBdOqPTAiMuoQb+vxbeZ1Uxa8EiuUK?=
 =?us-ascii?Q?QkiYiTje9vIN9WPnSibyd7lb9eJn/2x89QjmHWGUQKAcUR3MSQc7x1wCzl+J?=
 =?us-ascii?Q?afCVykWgFATJ4ed/YueVwteb2HPVCTVjGN6qeYwGns0Hd9TUMMH42FbvLjCU?=
 =?us-ascii?Q?Ft1sCUfb9KKf5N84wDLLm2Cu8vTvyEufLrCfPUH67VL3c86gmIxgrANmaqVt?=
 =?us-ascii?Q?D7zkounjiMz3nX22g6ibga4J8nV4gzPgzHn+r29DRXMeH9++7P2fubMgFrpD?=
 =?us-ascii?Q?DkzZLNkkEUmxn5+SNhveL+TqbyKJQtTSreV4QvynBIHqyYUHxjbsjjDYNafI?=
 =?us-ascii?Q?c3fUgECGVLk0g/dCrVvxSIOruufZQ45UbRVeTRTnlWgIVX68upJxDIT00Ute?=
 =?us-ascii?Q?uFTM0Cs38vnTXFN0BLzKZsHpiVmWKBuFDk0D45PpMgcLznWh/1/PEUzkAXor?=
 =?us-ascii?Q?dtdqjmG7NumqAowgDP0tJxCUjlJTCRhPCY3jA/sTvsU7+OKYvAAAs9PEoQYC?=
 =?us-ascii?Q?fUu9I2gJ0zj5yJJhyk8q3Vrikh4wFVsYHSVUujkC5FAMOp6BN2dsICZu9lAt?=
 =?us-ascii?Q?2j02nXmNwncYcGpnmgnoulHUUvPBQZCIqOxx2KEantpPwCQAPUiJb/faQiqn?=
 =?us-ascii?Q?orJy9+YNUDUgqbLXO4IoFc+LCkPTQXS115NXV5XmUh9AV78tkuiubIYTNcfE?=
 =?us-ascii?Q?P7eJRSFlggExR6Js0MxOGRiOKbGjcm6ONPi7RUx9cAjoqKe2sGFsC/PPNtCP?=
 =?us-ascii?Q?qpJd8WI4m6R9VnOTfqtgUSDzLlQohhLhYq0+dfbghanqEWCJIb4Y/gqxA83h?=
 =?us-ascii?Q?fX5y+TY3gZxBDqGjbwxJc7+FGKhrQ9t3chcFfTvDCrA/IFbZLDe7jJoqr7k1?=
 =?us-ascii?Q?t1PzwlhXU/rtM8E5qWe8P1uOHHd4UDOlKk3MVulqPET6zSwqM8Jg3M1ffthY?=
 =?us-ascii?Q?56x5ss33DvexTrbeNYuXFyiYnPRNtFo6yK14cQhLZOIacyJdXJHHoG+aA5eP?=
 =?us-ascii?Q?cz2O2DBvugNOAyhuZMY2qi2px/2JAmsdjGyswFdaNwhuVI2Kc6cTG6ySvMoR?=
 =?us-ascii?Q?ysuXjU2M6y2D7a9A5n9k7KfuRCbh6gTDaM6mmGx83ApaOxGsKYZyrcdZ8ZNi?=
 =?us-ascii?Q?zFHtNivxZnOxKlsIrGoUaXU3Y/tepBotY4tGdYrrXTOcO4GAG+2RBJ8SBg+n?=
 =?us-ascii?Q?QlWaqpu+x+DWQnAHdN1s3GVaDdA2Jqsp5O7yDNMlzcdazcHiTCAjWSjMBDUY?=
 =?us-ascii?Q?3A0EonWVAkFxmp+EfB2h5qJ2RsZJIQPlRQgweyFXOeHW0MiMPs9ZLYJ/3Gx1?=
 =?us-ascii?Q?uw843z6HnU7uYY1VS2cf2GNCweIwNb3zmmyxnMHoSFvwoZYvHes8vYfv9Eoo?=
 =?us-ascii?Q?Z4BRgFnI2pefX9vrpSDHc1VxnlY7aGf+QiJNGX0SOOqNeUqysuKz93rosPCj?=
 =?us-ascii?Q?vJiiXJXSQZpVEB1F0BrmnL2QwAkzSOeQdvywwc6soOHFqgqzbgbTxTpINkKr?=
 =?us-ascii?Q?gKNylBWdHDRhxxZMxBglzPiB2k/xYbh0KM87s+Fu6tOOLKkkxNVpcu9TYA34?=
 =?us-ascii?Q?y5xeO/CNoXTN+cb0zindkFY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b6e8eb-b352-4813-d2a8-08ddcddd8219
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6657.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:49:01.3910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pitD1DSWuOR9Cclkl9WN4Pn9+1jQVeCXCJbL5yxEa2WvCVnoMnghLJDl19aWZnOna6q8NSDneFtaEg0uBWAcVpcMHqg51XLeRvkid/amR5oEjEVssG5kwRWpyGuV4jBQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14280
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 13:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19606

Dear All,

This patch series adds support for the Renesas RAA215300 PMIC into
linux 6.12.y-cip kernel, on the RZ/G3E SMARC EVK board.

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


