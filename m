Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2758C8303F
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 10:37:53 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.38])
 by mx.groups.io with SMTP id smtpd.web11.20594.1751452672352793971
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 03:37:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=i9d6tfVo;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.38, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUxoFg24N1EIAdrgbbPZJGPfTQjsbABMshmD+TQyZChJZTwBZgeqPzje1xglf+ekCMXDEX2+Mthnjox6EwdKRajCjJ4lUfwBM0NxgcLXJrmZDT2wSXgdP86cLE2Au/4GOuqEfu1l44a/H6uwHS+jLbC+Rwv3/ZyTLfRVvzG1sADMy6hTSEfvCXAacAV0hgoh4fULOywTHWYy0qhGfIKPplOq93fIJ/coTr5I2dUgtzBXhv8Ij42TE126kWfe04ZSdN9LvwCZ6pDLH40l+Uu11Va1yVbHKAFJRPF27jsmzvCn9MiX41dNwak0fORbhQSAFOQq4CLxUOt/X0AMMZD1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL106PH5+t9LO5uGova4gbkc66bJVIVeWwlBNxnj+lw=;
 b=NOq5orRclvt635BJTRVwPo2ScEApIjDoJ72ZinBpZt6CLq3fo8fxHSRpG57fGZXVTsW1Xwp3CnEgzHNh2ZKB/jNROAVp7ZMlgO59VEvlgrRnHYBizorh/Hcx+2epaJo2AT4xC1r2q6B1P+gemiJZerX1P0y7ZRYCoD2/0JKBHej190rj6idyIv2/e1QObeHeKJjqgie4U5jyHbUCoHjO2Y9Rpqru4aYLd8ZuS0iny2KhOcy5DfXvxbPbqHiQH5MJ1z22wl4QFUg7eIicns9vC35WVAb5VjRdJJ9gdsTjw7fuv6w0vu/lhdtdXxvdvh7uzjwb1otvaWzu8BMtY4oyyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL106PH5+t9LO5uGova4gbkc66bJVIVeWwlBNxnj+lw=;
 b=i9d6tfVoBaEJm1H3/4YdG19OoqMOT+V8k5SB6u1pp1vtOJ/Yd+67tCcvJnqwL4j2R/vMHiDJF9t6fGEXSe79OlLjKMGetFxdlhTlKTqOMu/mQ6vUWy1xhCSHcHS2YCu7KC/TtU7IRI5yZOJCnzGj5292uSH+keWQ9kscmuBBHa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB10187.jpnprd01.prod.outlook.com (2603:1096:604:1e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 10:37:49 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Wed, 2 Jul 2025
 10:37:49 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 07/12] clk: renesas: r9a09g057: Add entries for the DMACs
Date: Wed,  2 Jul 2025 12:37:05 +0200
Message-ID: <20250702103710.117760-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250702103710.117760-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0263.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::10) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB10187:EE_
X-MS-Office365-Filtering-Correlation-Id: 4710bbe8-684e-457b-038a-08ddb9547da3
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2/7QEvFkIcxWRYjr3mDxVwhTe8rhgS8XJfVw2H01hYo6ZPYk9q/XX6fh1m+R?=
 =?us-ascii?Q?/cBEv9yJnmUBU1PGEyVV8M7RDBe8Id6tQ0IXuwbIMTbwuxxHzzcn4sx35W2n?=
 =?us-ascii?Q?34juhWyJcgSjACuSOZFXgiROQylnc+U/OkAFw2xtG8uxkjaJj3LXUtnqXtOT?=
 =?us-ascii?Q?S5C1I/MU+PH3FmjwcP9MlcupIe+werIrHNoKlrZjKLdJ4tMQ1SO9vvuTRPGV?=
 =?us-ascii?Q?QIuBGLYi0rDoePuEso4Hjsjkg4PHARkynasWt+Xqh0TimSTk+TI4nFSPI26w?=
 =?us-ascii?Q?aNOPm0/J3S8/LgWbtamxuGtByhf2vYZfyZ9S4r018kuJco6yRtJqvlzlF1NL?=
 =?us-ascii?Q?2PUxI3bH6Pdsl4rcG6aOKkggWqGfvrfIjOgE6t5RxgrzEkL2H/b1hcyBV8p/?=
 =?us-ascii?Q?GMRxENCLEkz42wZdTELNhms2oUcEBLOtBzz0I5/8a6qm2N1ibncRD/vbpe3G?=
 =?us-ascii?Q?7Gj4gp5ojXAdJRxrvi11Btg98mF/hMUeN5eOPsgT6PcRUp/ZiJE6iotexlG2?=
 =?us-ascii?Q?G0p/4ZyiCmHCmSQrHPa5O7oC8Khzk2LrgCJ+J35jTZrDuJXx0twKMQAQgyi6?=
 =?us-ascii?Q?LWKwjda+m6fQzg1NLHkSXzhkBC5E/UdNex6Kzv2YJNWimL3CMUYWRjxhc4f3?=
 =?us-ascii?Q?GPeC5SB/NMBwVkKSqP5RLT81ZvE9CJZDBTgViKViHBPWPbGp/A0H+PUB7CPW?=
 =?us-ascii?Q?6UTXPBJL5kdFIhYRWw7yklqa/ITPQx2OFg9B8f7HpiuVOKpYLvqeKNZxCf6x?=
 =?us-ascii?Q?9X/8nbiqgrOiuOT9dG82Vk/fiuDN5v6L7fTzUlAAIHRtekPTC/ri7pqEr58f?=
 =?us-ascii?Q?hPfi5aE2tVL74nYKUi0QHuo0sdoKSVDoDlvHe1VaO60ESyx62z6LOzp4e2cp?=
 =?us-ascii?Q?LE7Z53HWYTwES17H5ltyjT55pGezlwnC8oalmKmGeceMBoebrVEmrtXOgXD+?=
 =?us-ascii?Q?iwfiDMD6SV9nkmX+lJYYYekBx5AqzeJ0Q4sHWntQC3gV6PQOHlwP6goIFdEL?=
 =?us-ascii?Q?2/kPZehr7iMbYt8zeISVqWzIpyVGWqbp2b5CXPHD7WS47IJW8StR583eFFeb?=
 =?us-ascii?Q?eHHGm7H7dK2aBZGhHUXFBw/pdVB0ZHZp3r6gIS5mK1Rysutf+51S5953z/jW?=
 =?us-ascii?Q?vCo1mNRwKZaG9ESjF+EaglDheW4i2TXj3rDbDN7JAcOvWFJmcQYmT42Zb2C0?=
 =?us-ascii?Q?tN3AmWcfvFdBUnORTdKhCW+N4+ZgQGg5n/wy9+U2loM4HqOo1pig0BxEuBYS?=
 =?us-ascii?Q?qgnvurrt1Ni/KeaDYgPo1xD04EWXsc2VpZgSgjTLmB76elTbKs5giRxduqKB?=
 =?us-ascii?Q?GPgUXwZTzjYbSnaysu/NpSDGEQWEtO4Os1f4qFy1B5XPpfKn1mN9Fbh2WSuM?=
 =?us-ascii?Q?PQgrNSZo4uhfy1TNN4klNHjd9/DlDWpNfC7TUKWelLLJZov4AVsk+xZ9emw0?=
 =?us-ascii?Q?w50fVAuF+a6hb6CURFOV9ZUqOZfL9/9FE5j71M/U7BRo4IsmH6UMz7MmMOUE?=
 =?us-ascii?Q?wHqDITfXzybUHBA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?OIqn3QLBe3uhoo48mbGUwAJiUNNLrdy/BDYGenzXy+rnHuhVysus45xwAtQq?=
 =?us-ascii?Q?se3t31y7TnIywYxnlusppq73+iN6DkLUyBB2eC8UDpal2siIjxOJ2iLFXOEu?=
 =?us-ascii?Q?BnmP5uS8Tsdu7j76QHGpbX5rtgRlUC1BZkxNoOpYXGTubhYGeVSwFo3QXaff?=
 =?us-ascii?Q?5Q+aFpWbYnunBBGNkQID1UMiDgtyTwS2h6wiLOA1b6ol7C+Gvp8n7b5NpX33?=
 =?us-ascii?Q?EfewcKV9F8upLcK93dewEW6rmao6PBPSJcQHg/1hikca+fZczHd7UhitVJ5Z?=
 =?us-ascii?Q?XMOTX4EDZXppQW5EOSM5YQYNN66SaqXLM4rMEWGEo38bwZ5k2bO9rCBu5nrN?=
 =?us-ascii?Q?emNsFzxKHBUe72ZhKQNWEsrowW0J3ULY+u3rNuceOr4ULCVWGM1I8NLaEpMV?=
 =?us-ascii?Q?YzjjFnOZjqU+5HeyWt/TBiDz8eerFBxKV+96NsW6PEjDzEVlbaIiuHBHBBj8?=
 =?us-ascii?Q?an5FySLF3q+B60bUJtLrTkFKQYT9/yx5o77aThikff2QNjNap4QFLPJSilQE?=
 =?us-ascii?Q?p0l2SvgnwCWzqq32th5Q1TVIGrXA14y6Hq/PIRT+QtxC51qBKZM/jR0bXycq?=
 =?us-ascii?Q?5zKm9a+gH6G27VEUqxMk2hvEL+CxDE9Dl4E544wSnvog99DOgRtyMKRv9hp4?=
 =?us-ascii?Q?1PfhwWaOff01m9+njeHdESToo+KliPEMKIIj13EgyyD1au/pEzweU/3UYgbr?=
 =?us-ascii?Q?glPuPiTX7XAZ29UBCln9lYUOYY5WwUwXdXRZgOjQvw+p+wVDZ4AvSVYyGBUq?=
 =?us-ascii?Q?L4rGz6EPqkSDPG91705hrpe/Nk+vZNx6w58TYvNWCaJXgDOC2Xfit4M0hC5f?=
 =?us-ascii?Q?epzCWz8kJbbvzkwRlAOVoiHQQ4Sew1Xmku3bO6YO2EcvrC1yMHpjPpYlH0Kc?=
 =?us-ascii?Q?Pnx8KObF90dymqMVyoa4XsQHIhVQNY07ZvNYaJoI8Uf16tJv7Xzs2xebsN+o?=
 =?us-ascii?Q?puk1tFs/79NZIZIAHW5Zj1/K0WflZbJzIM88svOX6cCD5pYik3+x1kk1w//4?=
 =?us-ascii?Q?MSvc804wqYJVhXaP8zPiYiqN2qQr7+LBJ83X33K57Yy9sTuHwKPMSsi6Jx6h?=
 =?us-ascii?Q?tqo1SF8PByhaOFAh7uM4D2e9OxigzS/BPorEyGi3ld3XpXoFxU6In9TtrxDf?=
 =?us-ascii?Q?8+HOJnDuosUx0rUrWP1LSa7EZ5hCa4TLLB94xI1JKZvwQZu7crtZZEo6vN0S?=
 =?us-ascii?Q?chFkxsv+hMfOfXlV0E4fbxl/ZexKaKfbe7dlZ7+j1OPvPn6XsQojbfytFd29?=
 =?us-ascii?Q?HSPmoQQZiv9OGAmkN5LtnGvU4tnxagTZjbsadoIUuTyLu1j7jEjOlKf6TnLw?=
 =?us-ascii?Q?+7ZxZICvw4jxXzV4feOwCdoahWps/8pl4rzi/dGYRe5ldVnog/auLhHBNvZt?=
 =?us-ascii?Q?UKbSyXYIlp4yzTT2VJZ9LlEOzirReq9uJDH+iHhu56yKpedjInDVLUL1aCCB?=
 =?us-ascii?Q?jYzw5vUJHLpbB44OqWJ2VZ0wNuGVkDt41l/oIRphVfwnfZi9mVzQA65d0ysa?=
 =?us-ascii?Q?p4cV2hlzh26aQS+Ghloq+XUYbefv1yxjkdxyC1X80UJp1Sy2hAihUlMRDLgO?=
 =?us-ascii?Q?qi2lUoFJfaXj7OeVa9i/UHx7y4HRxmw5acvBj5ZcLMb1G61lKEHPHjLlsXYv?=
 =?us-ascii?Q?MQL/a28djOKiLw6m6IpeTlo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4710bbe8-684e-457b-038a-08ddb9547da3
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 10:37:49.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9KeCjO95qUt7sudlaYjXTE0fPAMnCQH8HsZKdoOS5v2s/G8BpcJTLA4JWs3aiVzZDCdScXsM+GCR93Bp4uYTSzPm/6rJ686zgptlz4Y+fsRM3wo5ia31sDZwS0NmdZQu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10187
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 10:37:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19305

From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

commit 4d6952981244d1e455e2469cfd93e3b5eaddc4a7 upstream.

Add clock and reset entries for the Renesas RZ/V2H(P) DMAC IPs.

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250220150110.738619-2-fabrizio.castro.jz@re=
nesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/renesas/r9a09g057-cpg.c | 24 ++++++++++++++++++++++++
 drivers/clk/renesas/rzv2h-cpg.h     |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/clk/renesas/r9a09g057-cpg.c b/drivers/clk/renesas/r9a0=
9g057-cpg.c
index cd0f3d4d737a..031f332893a1 100644
--- a/drivers/clk/renesas/r9a09g057-cpg.c
+++ b/drivers/clk/renesas/r9a09g057-cpg.c
@@ -31,6 +31,8 @@ enum clk_ids {
 	CLK_PLLVDO,
=20
 	/* Internal Core Clocks */
+	CLK_PLLCM33_DIV4,
+	CLK_PLLCM33_DIV4_PLLCM33,
 	CLK_PLLCM33_DIV16,
 	CLK_PLLCLN_DIV2,
 	CLK_PLLCLN_DIV8,
@@ -39,6 +41,8 @@ enum clk_ids {
 	CLK_PLLDTY_ACPU_DIV2,
 	CLK_PLLDTY_ACPU_DIV4,
 	CLK_PLLDTY_DIV16,
+	CLK_PLLDTY_RCPU,
+	CLK_PLLDTY_RCPU_DIV4,
 	CLK_PLLVDO_CRU0,
 	CLK_PLLVDO_CRU1,
 	CLK_PLLVDO_CRU2,
@@ -85,6 +89,9 @@ static const struct cpg_core_clk r9a09g057_core_clks[] __=
initconst =3D {
 	DEF_FIXED(".pllvdo", CLK_PLLVDO, CLK_QEXTAL, 105, 2),
=20
 	/* Internal Core Clocks */
+	DEF_FIXED(".pllcm33_div4", CLK_PLLCM33_DIV4, CLK_PLLCM33, 1, 4),
+	DEF_DDIV(".pllcm33_div4_pllcm33", CLK_PLLCM33_DIV4_PLLCM33,
+		 CLK_PLLCM33_DIV4, CDDIV0_DIVCTL1, dtable_2_64),
 	DEF_FIXED(".pllcm33_div16", CLK_PLLCM33_DIV16, CLK_PLLCM33, 1, 16),
=20
 	DEF_FIXED(".pllcln_div2", CLK_PLLCLN_DIV2, CLK_PLLCLN, 1, 2),
@@ -95,6 +102,8 @@ static const struct cpg_core_clk r9a09g057_core_clks[] _=
_initconst =3D {
 	DEF_FIXED(".plldty_acpu_div2", CLK_PLLDTY_ACPU_DIV2, CLK_PLLDTY_ACPU, 1, =
2),
 	DEF_FIXED(".plldty_acpu_div4", CLK_PLLDTY_ACPU_DIV4, CLK_PLLDTY_ACPU, 1, =
4),
 	DEF_FIXED(".plldty_div16", CLK_PLLDTY_DIV16, CLK_PLLDTY, 1, 16),
+	DEF_DDIV(".plldty_rcpu", CLK_PLLDTY_RCPU, CLK_PLLDTY, CDDIV3_DIVCTL2, dta=
ble_2_64),
+	DEF_FIXED(".plldty_rcpu_div4", CLK_PLLDTY_RCPU_DIV4, CLK_PLLDTY_RCPU, 1, =
4),
=20
 	DEF_DDIV(".pllvdo_cru0", CLK_PLLVDO_CRU0, CLK_PLLVDO, CDDIV3_DIVCTL3, dta=
ble_2_4),
 	DEF_DDIV(".pllvdo_cru1", CLK_PLLVDO_CRU1, CLK_PLLVDO, CDDIV4_DIVCTL0, dta=
ble_2_4),
@@ -115,6 +124,16 @@ static const struct cpg_core_clk r9a09g057_core_clks[]=
 __initconst =3D {
 };
=20
 static const struct rzv2h_mod_clk r9a09g057_mod_clks[] __initconst =3D {
+	DEF_MOD("dmac_0_aclk",			CLK_PLLCM33_DIV4_PLLCM33, 0, 0, 0, 0,
+						BUS_MSTOP(5, BIT(9))),
+	DEF_MOD("dmac_1_aclk",			CLK_PLLDTY_ACPU_DIV2, 0, 1, 0, 1,
+						BUS_MSTOP(3, BIT(2))),
+	DEF_MOD("dmac_2_aclk",			CLK_PLLDTY_ACPU_DIV2, 0, 2, 0, 2,
+						BUS_MSTOP(3, BIT(3))),
+	DEF_MOD("dmac_3_aclk",			CLK_PLLDTY_RCPU_DIV4, 0, 3, 0, 3,
+						BUS_MSTOP(10, BIT(11))),
+	DEF_MOD("dmac_4_aclk",			CLK_PLLDTY_RCPU_DIV4, 0, 4, 0, 4,
+						BUS_MSTOP(10, BIT(12))),
 	DEF_MOD_CRITICAL("icu_0_pclk_i",	CLK_PLLCM33_DIV16, 0, 5, 0, 5,
 						BUS_MSTOP_NONE),
 	DEF_MOD_CRITICAL("gic_0_gicclk",	CLK_PLLDTY_ACPU_DIV4, 1, 3, 0, 19,
@@ -223,6 +242,11 @@ static const struct rzv2h_mod_clk r9a09g057_mod_clks[]=
 __initconst =3D {
=20
 static const struct rzv2h_reset r9a09g057_resets[] __initconst =3D {
 	DEF_RST(3, 0, 1, 1),		/* SYS_0_PRESETN */
+	DEF_RST(3, 1, 1, 2),		/* DMAC_0_ARESETN */
+	DEF_RST(3, 2, 1, 3),		/* DMAC_1_ARESETN */
+	DEF_RST(3, 3, 1, 4),		/* DMAC_2_ARESETN */
+	DEF_RST(3, 4, 1, 5),		/* DMAC_3_ARESETN */
+	DEF_RST(3, 5, 1, 6),		/* DMAC_4_ARESETN */
 	DEF_RST(3, 6, 1, 7),		/* ICU_0_PRESETN_I */
 	DEF_RST(3, 8, 1, 9),		/* GIC_0_GICRESET_N */
 	DEF_RST(3, 9, 1, 10),		/* GIC_0_DBG_GICRESET_N */
diff --git a/drivers/clk/renesas/rzv2h-cpg.h b/drivers/clk/renesas/rzv2h-cp=
g.h
index 6811c0332812..d52f5416e371 100644
--- a/drivers/clk/renesas/rzv2h-cpg.h
+++ b/drivers/clk/renesas/rzv2h-cpg.h
@@ -57,11 +57,13 @@ struct ddiv {
 #define CPG_CDDIV3		(0x40C)
 #define CPG_CDDIV4		(0x410)
=20
+#define CDDIV0_DIVCTL1	DDIV_PACK(CPG_CDDIV0, 4, 3, 1)
 #define CDDIV0_DIVCTL2	DDIV_PACK(CPG_CDDIV0, 8, 3, 2)
 #define CDDIV1_DIVCTL0	DDIV_PACK(CPG_CDDIV1, 0, 2, 4)
 #define CDDIV1_DIVCTL1	DDIV_PACK(CPG_CDDIV1, 4, 2, 5)
 #define CDDIV1_DIVCTL2	DDIV_PACK(CPG_CDDIV1, 8, 2, 6)
 #define CDDIV1_DIVCTL3	DDIV_PACK(CPG_CDDIV1, 12, 2, 7)
+#define CDDIV3_DIVCTL2	DDIV_PACK(CPG_CDDIV3, 8, 3, 14)
 #define CDDIV3_DIVCTL3	DDIV_PACK(CPG_CDDIV3, 12, 1, 15)
 #define CDDIV4_DIVCTL0	DDIV_PACK(CPG_CDDIV4, 0, 1, 16)
 #define CDDIV4_DIVCTL1	DDIV_PACK(CPG_CDDIV4, 4, 1, 17)
--=20
2.43.0


