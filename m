Return-Path: <john.madieu.xa@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BD6CD4F39
	for <webhook@archiver.kernel.org>; Thu, 14 May 2026 09:40:43 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.32])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6978.1778751634469304810
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 May 2026 02:40:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ZzqfyIEQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.32, mailfrom: john.madieu.xa@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzhKf3EcvW3kfRhKQAiwb4c0R1tmiZsl2EHaEgxWgBPEuZ/J/98a5pwdsv1mJ67HVJFoC3LZy4yNTXGByZUwmEp4h5uZVwQSfAZfOpU9jDQQsGjf96lZJfYIF2UrtXTUGewu02y0Tq+53555hdQPzadLD9/Q+JljoNrdtrssu80vbFHMPnLQUNxBnZxhtZ2uXx2NyYBrH/mwkUWujJ0ABtDbBiZlerB++52Am89XFQMX/0OvTodHS2wuaW/ANn5KZEdeoDGFlKQCZnC6qmInpp82qNs8WSGXZsSW12mhkIp6q1ozf7A3jwCUASnvSnJ1n+SD7U2FV9zW99hI1drP9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9LDo2hchL+IoBIHSHR3CDagB5UGk+tq5SvgK4r4sX8=;
 b=CkTwXKTCfEmv+vJwG5N+tA+/XHVpjBc5SHDEadoCvIalz9VoNkgbA++QuhJZb+/ku9WOGLLzu+tUjMh9PyH5nW4TtFoQs+RKBqmToj6yIc1z2LUHOEtLUJixXixgdt476OtcDgZI9kVi5Fg7RWPTf/Xbfnr+aBqq6ygYJ6trfCP3iI8hq2wJrZIWEMjZMGdWYYw4+fimPhVOqOGZ/awUKTw0zKlxOrHjzZL/imEHuaahqKNRJNnCzX6XuNj5lotDJHaia7NlVLavYcJhMFPaJZTP2nPAiVdl5EGo6jrQrJNi2WJVy3qTJr+jJyonUw6SzbmUH1mWoTcv1PNK4Jtg5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9LDo2hchL+IoBIHSHR3CDagB5UGk+tq5SvgK4r4sX8=;
 b=ZzqfyIEQJHLu9o00THQv8DPXe/OnkqAG/xzP/N57balK1T7AF5/rsp/j7gap3pNupAqwV3olbl2QtC7H6LdkWInsvRyx6tsItdaERnhn+9eCy3l3FbCRxsMMM7UiTAaedTBDvbZibT9aGZ3FgUCi91y5SQF6SrAWOnYRMB1U2nM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by TYRPR01MB13674.jpnprd01.prod.outlook.com (2603:1096:405:18f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 09:40:33 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 09:40:33 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	john.madieu@gmail.com
Subject: [PATCH 6.12.y-cip 10/17] PCI: rzg3s-host: Make configuration reset lines optional
Date: Thu, 14 May 2026 09:39:28 +0000
Message-ID: <20260514093935.2212718-11-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
References: <20260514093935.2212718-1-john.madieu.xa@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: PA7P264CA0033.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::11) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|TYRPR01MB13674:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e52dabb-d72a-49eb-2027-08deb19cd824
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	GrtARlAf9ut9Oc9cHF67GVCt+X7LMRJCaH1cOni96ZoA3ynDa30TIB8y8ZYqTh1E+NSyHV5xiXwPOlovc+zvlObDOB+IMcrX6n9jva2u4v290RJ3TA/nsqn9610b7yd1QQeDzsCbfW+rBqLV2vXwyF2KEp/djpK/mf40Ttum3k9FNYevScqzhDaExvwnfP6WI5h4nzizqM2gREVqJZMGZMenBFoI1YQnt5YJcQTyTrsh7vEu6ggrkKAey1gD+mKdMdiSx/1x7cj6IkF4wqB1/CxV28KiteuKmL9Fxw98C3BTx4dHNTo9vRHOPNjnqSWBjMejaowq/uIB+dvMwaVj2ej4hgHOiDB2+L29/zVRWOlh39mpR7akEeIsfUUkKGn+Mia7/KNhuvldz8kgDL2OI9ar2ogmXFMT7+c1UR+YjQTWnayawnRlzcJC+UcyDsYh5o+jnuID6V1D8hM+RUI+YxWlQ7yit0ePlaPQRnRkUoc6w0Evpbb/Li5NmuBiNKh18JyQ+4+qr+RelDFk0JFFfGM4V9+I9L/yjkaqMGFx8ln1520jhi3BdOOlM1LRzGHlqaesZ1ioCQExJjigS2ahJdWhjw8dFOQ4Aq675mmFsNWlI5Y8erlfMCFruPQk4aIq/7vfzgbKSerTxd/jei+4pi1XhyTHp5k4gLTt1kaNhG98q1wL5da2sw1Q9w7+gJ4wH8UlBNaubiIz02HgCA7oRg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hDa226HdDL52JkF1uSiNMBQyStB9i1hr2GRwPQX4yOr3OvYdo/NK4fDYdAKG?=
 =?us-ascii?Q?wUSyTDf7GrZezicln1tXrmcqHrWn9MI7+dqnmJgeTQ7IUxFAKWNGlHRtDvd2?=
 =?us-ascii?Q?Q/UjyxeA6aBW5AjM0k3X8122t9vvDuMO3EwrSNlWegPfZR4KvI74gFLE7q8B?=
 =?us-ascii?Q?l6/ForI70JZDkyt/KY6XHs9DW0qniYee66p54a5KwJoxd4qfOixme2+U0hBV?=
 =?us-ascii?Q?6c3GluAaOJ8I1a+PpUi58NqfxGbL+7maok1Z5/3ZmZciQuj6R+FLr05Qo6PQ?=
 =?us-ascii?Q?e9yiTFm8xe0M26wSL/cOyvoDGEOOuzVVGcDG/JOHjKfWhqpHnPRr00al1u8y?=
 =?us-ascii?Q?6BsaX9gczZZ2c4sIMvqHaV/IvXu9VmKg65QH01Cf78m8G0UFBvbA7eGXZM9t?=
 =?us-ascii?Q?7WnhNGwaLE+GeJBUCyN0oxN/zr0xeTVt1VRp91DdKerZn2r0Ja1OPpnmzNr1?=
 =?us-ascii?Q?Hh9VwAmoA1RxWaHb9dDhAffmFFkFVEjdiaihLrtqh9SB5CUKcXVWZZIyQm2B?=
 =?us-ascii?Q?0pk7Gl2O510M4ENCjpBvXrmrOVl40msN1uLGAT4Z2xCHUGNkSjsMGb9zU78x?=
 =?us-ascii?Q?jjxH03azxW9KPhQ9HZHiYe1zeT9xI1obLlyoo5RsXRzH+tYdfxcospn214Jx?=
 =?us-ascii?Q?ODtvzOSKxc7SiJpvA7Mv1mcRzAVgjQP8pipTkhEgSfjDXSA19hFHxdpbvM3v?=
 =?us-ascii?Q?+JdEZZzWu/r6020TbrP4NQneO5Xp2HOZzcaZzn2B6BejlepGSUMYXZYvZI3y?=
 =?us-ascii?Q?dg2LvuDf7lprSsN/c/+Oh0SqxGU0vvFsE35UDLyFEOEZ0qtqpbXR1t6NabSU?=
 =?us-ascii?Q?WneKBC8mWACmj860Uo+Sg6y0hw590icRWgfkN5rjlUao0eoMCwwtfbWweeKo?=
 =?us-ascii?Q?G+roeWjqRwXoMjUdQXXXnUJkW7ZE7in67my/m8tE1IdcO7+o7ISOqpwqiPgw?=
 =?us-ascii?Q?Eo9A5P9EaUufTdXs5jSm2qv0Oyu0TyEuY8v7q7WiwBp/64E50CpxbR4tZgke?=
 =?us-ascii?Q?edcaGstZH73FWva8xjlr9O82bMjNIZLsrn5V3gkUvYHnL6IO+zA8Ny3/xRnZ?=
 =?us-ascii?Q?i4bOtjOPW/vWd+87odaBQNHLKdFHWWC1gh86KFE6e3WnnijQ9p5GPfktBOOh?=
 =?us-ascii?Q?dzaoi3nsrcbE0PXaWEa9PMxpHrrFTrVrdJ2CqYYVk17ILWRcMb2iyUqp1viY?=
 =?us-ascii?Q?kXgXla2XjXsVy9M3tx637UiPGVI+25CTTYbxJWrE8ZbfmdvkS75bsu7MFTNg?=
 =?us-ascii?Q?3WoozzM1CVoZ3d2ZN1c9TJkex9YihmfzXQ2HDRNvi9I5wezjERHF4rPDsuEd?=
 =?us-ascii?Q?zN6B0l5I4RazZTTL6fHIVHS9lW+QtnB0prdlfTLzqdO5JxGLcw8iT4TSPvAF?=
 =?us-ascii?Q?fSBulRGIfsC7wzYttGxoX7ydi4fQWejSjAjazjEmIFBhLTQsdv0V+eYHCqDw?=
 =?us-ascii?Q?9agdI9wHMQyw/aLPFo4g9xTzNVHiXLIP8wn2K5Njd+6jDgGdDKQEfbswiCoC?=
 =?us-ascii?Q?hoTIdTJ3i8zpvuTwISq7WL8TU5SLChy5zQT488yEg3VjFEHWUyhhf/r7dLj3?=
 =?us-ascii?Q?IeCN42IfR24OjrrhkAb+vD3eDrDHhtpkZOGFfn9Zccbt9IA0CY8hTgXM0IL8?=
 =?us-ascii?Q?7qEFFmzhhSCpXP+iqAJgaKKHkgC+5wbfsHdrtotVo8/SqNqPwxwjN8Bef+gu?=
 =?us-ascii?Q?Okdno2dztuswCbKcEbMQfqR5gE+KAj7seb44M71NwFh7Q+BDMfe8LsLnF9X1?=
 =?us-ascii?Q?AWwG0ZZh5FsAG6uutCMYqbxJzKKufRk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e52dabb-d72a-49eb-2027-08deb19cd824
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 09:40:33.5597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUwpvnkKr2HEjxGl+fy59CVSWyunTUCcccKpPtBSbWXqocZSq4UG6yM8vjj6Q15zolo1UG4Eyz78fVHHmZaCibLa7eD7iU3RBugID51ZhBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13674
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 May 2026 09:40:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22944

[ Upstream commit 4ec4ccdaace40397638c305c0a36b423d2142a93 ]

Some SoC variants such as RZ/G3E handle configuration reset control through
PCIe AXI registers instead of dedicated reset lines. Make cfg_resets
optional by using devm_reset_control_bulk_get_optional_exclusive() to allow
SoCs to use alternative or complementary reset control mechanisms.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> # RZ/V2N=
 EVK
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260306143423.19562-9-john.madieu.xa@bp.ren=
esas.com
Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/control=
ler/pcie-rzg3s-host.c
index e4102744aab4..8620d8d31137 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1210,9 +1210,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct r=
zg3s_pcie_host *host)
 	if (ret)
 		return ret;
=20
-	return devm_reset_control_bulk_get_exclusive(host->dev,
-						     data->num_cfg_resets,
-						     host->cfg_resets);
+	return devm_reset_control_bulk_get_optional_exclusive(host->dev,
+							      data->num_cfg_resets,
+							      host->cfg_resets);
 }
=20
 static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
--=20
2.25.1


