Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88029C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.63])
 by mx.groups.io with SMTP id smtpd.web11.48841.1743418038377730104
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=G/3dJsxy;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ff+jOYw/8rJrgwERQo5aFN1ZZIlut90u2Iw02G/K240CilqOmzi71lQKzGekeyjTsl/cQtjRWYQx+xLFCd+E3CdStWIPL21jjM4JWh6+5TkjphI6+QmeUfyfmWtHgT484KE9b7B+FRL4aUWwCaXlxVCBRXL5fxyXkI4mvHfpngdTlZrcS+Jvjm3nLekBMJc4yKqvsoCFJ3ZOiI8ngHWwjJpX8Q7t7OoadslPonLraDJrXbAlHzxWzNUq6GyxX0LEibY5gYeH+Xf7Ji56dvGR/uZ620kwQXZ+EW43P6gtfdvIB5eOk3f3ieI4uHwG1XfvGmCQC7xxn/9duIMb2pxNAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0yS+CSTJryJdIx9UODoupW/EqbsxlFeLUvtzIxJ1Y0=;
 b=gXhKq9e8cUSltpEgSy5lq6qK/ggU2MjLawl5zU/z0/tg4ms6gHtqfSXOrKBvsT20Ivxerl8vBiZSFRD+b82WVdxtoLj8oXd0UjygSrDkj+i90nzIPY7+g8h+WekJsCZDXICvuMRCd/Rn56NBxbu6if6ILBz3uxS/w6eHjLcIItX+IKzXq1Z+A8DVvDHfnifdUF8BWKWHkR+j2Tl5HLkwr8Z17S6J5LTr9asH9S6Sk9GVbgM6qFnLhRa2EkHDz11Cem6ykhMjkx279FXXHmi4OFWVmcq/GXOnEum2mWjgecuWiAicrbh7iaCZHUTGusLZ8XF2LwTRd1xo5AuvsFpdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0yS+CSTJryJdIx9UODoupW/EqbsxlFeLUvtzIxJ1Y0=;
 b=G/3dJsxy3g56nqYwIs1XeBfFtZslErDgxj+06ZfQB6WqtO1De8wNvc05rAiOOaOwd/3YSzuxyvgAl6B4i+cOpbeEgkRPnLrVWuPm43dB1qpZ9th/R+/LUYtGNExYBxANpeR2PIXejOof+pOpjpeUOi8y0+AAQxhlmGCprjZiFXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:16 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:16 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 35/43] pinctrl: renesas: rzg2l: Fix missing return in rzg2l_pinctrl_register()
Date: Mon, 31 Mar 2025 12:45:06 +0200
Message-ID: <20250331104514.79090-36-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 62c85375-3d03-4aa1-04bb-08dd70416747
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a2293NyJpChSF8AkyDYGAEfYlyGacKuSeePDJ3hojlL4vJC8VOmZW2JugLfG?=
 =?us-ascii?Q?uOQEtIifxVmH25CBVnkEdhBMqe5tfvSNurUh2oGnFeNkFyfkwuLRcA7rlNOa?=
 =?us-ascii?Q?fZXQ7eAWxXvJfUznKyuZSEdopUAk9qlL6XOfj1vVw4BcLwQgzAzB1bKMsmdB?=
 =?us-ascii?Q?r7u7+TD4GxuxRHQde+uzxtgP/ppGwG4qntN/AJJAtzAB/xCNRpHY69ymE5bx?=
 =?us-ascii?Q?oSsr4zguC66OxvZV/25cOAZyfoG1HNmksZlehcXotfRbdENRfN/3NrVPOikQ?=
 =?us-ascii?Q?uv1IoKvlJCPK5a7rZE9Ce//xaktSodOkKETibMOz3EJNvVUlJcooSI4ZSiWC?=
 =?us-ascii?Q?/GfbKaKSR4QRoKPyJO8vc6le/WmoymGq79P76p8KtxnHVvY5a+qlo79Jxape?=
 =?us-ascii?Q?byXTbHk4WQXXVsa5ORVb+f0V4L/TvRHUyAeW3dENXHi1xoAgDiNGka42N+cm?=
 =?us-ascii?Q?Dtt/V0bDhKCvq60lt2g9+YJvrN4WgT791MZJZZ3SO8HivnlGU5FjjGNcAMX7?=
 =?us-ascii?Q?eAS1C91uQ5kBXNbboEAGKfhUJPsFDRijNIWtphyFWvplAizJUHX88JlxmPDq?=
 =?us-ascii?Q?oWSZJTlk7kQRBEwN6fJXr3sl9jHdwK1KXbvIA3nZVKj5ItZ6F0kGX41gB9aw?=
 =?us-ascii?Q?zYbGzZGik+QSaZuckci1qTD/2Mqqwh6nVlXAbwEEtftKBta4H8l92CXmsLyJ?=
 =?us-ascii?Q?elWiGEIug1dwoTXa+YTBmX0p3gleKlL2sOeAVoaqsIfOTWv+HTS9kYfCY3PE?=
 =?us-ascii?Q?ZrD2zJhGdmvB8ROXE1kZG6SlY429hl261XCVZH2WPp/qnevagvD0gsoRfzwd?=
 =?us-ascii?Q?GSEH+G7NiTtREaupciqdAUVsWOz5RaRD4Mfduo6+ljbXlC5tKQbD33+d0gb0?=
 =?us-ascii?Q?ftVmAZYZe5FD/t35WPNZtAraZZuntjW8NfbAQM9nDklB+mtbL+mVhajaVoqF?=
 =?us-ascii?Q?b+F9jlwRu+/2cEvF9NKdGKmkmGgO2QALVdC7n9enSejprepZ6wyJ7qybaiTU?=
 =?us-ascii?Q?W7GmbW8W0dNalBnor92GhvFDzNW8XfdePY8AQpemUQSzIawv70c5GLFfI5um?=
 =?us-ascii?Q?Jc9K3Zydl5ENSi3m4J/gp1155UghX9h55tzivxmgm3I/bopM1Z5W+ksPXCyl?=
 =?us-ascii?Q?/wT3ix27blXJNOkNf0c1971yrEl/cHRvY7fve83tooV4U6iPtWswD7rq6wvW?=
 =?us-ascii?Q?IoyD9qQnokcvBouqpvpapP8Vbst8amEplC8eLDiGb3ZbkG4GuwIt291ItF0V?=
 =?us-ascii?Q?gF7DGKdQsShaDv7kJKWxTu+VxcOWmOVOBEAW+ZhQKsbNJ4eT9QQ4pZobLK8m?=
 =?us-ascii?Q?Miv0CMmYkqV534lRrzkBMDcqc6Fqzyr6W+4PeJCk9eWKYWBuboWOr2wZGzCt?=
 =?us-ascii?Q?YDq5nDm2ZW6CUqxzK2Kb1l7gc6lxg+ziyqQuAbmRqE7X5pJRzIT9JscSJO2v?=
 =?us-ascii?Q?ylPepJA5obE63d8Hv1E/vH9FjHNrVvrgETZRtVJBTEh4iHCm2UKt9w=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?b10HRFJFT126iW7ANV+iTAHSjXIkTYR1KtQeXxQP7mwFMjlkseFia5MQ7eYB?=
 =?us-ascii?Q?hb0l8k8A7YVib/vNm3cIqL8PBUVR4FUay2UaoB1GcnRzWfL4ST+sAcl5YOPT?=
 =?us-ascii?Q?uwxaQUAyBYNTSLpNvaCAsonDDLxnaCo/kLP2GNR/Dv9713J415tCDyF2IORk?=
 =?us-ascii?Q?yA+Z8Suw5czhgB+KRlUILXm2EVrkEqJbrEUWVYxX5RDzr6MfezfKE/eb75UJ?=
 =?us-ascii?Q?w/jC4kjbpZzqh6Ogu1Asf7PAV6jLC5qNoVdOx6dnQ+m+5ae/kuc9CFOMid8f?=
 =?us-ascii?Q?RQrmpbW2Vi5vnBm/1/rfZyjdcL5PaqrCOQfV+98D7WlUx+ImPRXqTgYdOupq?=
 =?us-ascii?Q?dltiZPrEzD+53Iqcrfu5+n2JBcxIMD2LAc50VpA5mJC9MIl3eFGxa5oOkRyI?=
 =?us-ascii?Q?j4zjQFSGP0joPylDn1nD6TKKMpSdqH22OUkYuJxX7LilTRIa+XWq+nM3xdtu?=
 =?us-ascii?Q?cJPFN/gmMTO7GjNkQ6dQC16wM2bZlnY7FT50n2lARd6TFeTBtQRSQBoR5OxR?=
 =?us-ascii?Q?s9iA6pGprwtEK+L4TzjrRH8SY2B9hmBdLMA/DqC5tjigpCqXPXcT/fDNuXAl?=
 =?us-ascii?Q?zO/2/70IH25Lc8G5gGNPvZDr/Ap+7b7D0kyRzoNsDAwq0SEsO9meLxyhvWMM?=
 =?us-ascii?Q?Poe2B7haWBSaNeuSJFuo/JTNLApmlLsperKgEvAyJY60oYO02HRJ5KLFP1q2?=
 =?us-ascii?Q?W1Q0fu472Yic5voM6eobGyeRKr/ZoZ9tHHtI/aNqOEaR50gOsdHHXdlEk2d5?=
 =?us-ascii?Q?3F0HPUHipOcBMP/Z+QNlu8qnSFsL9PQNVhmJfpvMrvUTA5hUpHhLVYJOCksu?=
 =?us-ascii?Q?GUptZq+szN3zThY/dVnvBFEoAhpAuBHSkIQSuoo2Je3UBJWOOxKkWbotWMOu?=
 =?us-ascii?Q?GpC2wTqKZ1c/Qo199b/XUlE4/VbHHlkUJWZSd3NAiFtd3KxS0E08bHkf9lYH?=
 =?us-ascii?Q?WddEx1PCw/3a3ykCFWBJjPuwmCwAaAizPp5hjSa0hdRGowVjakG3XKXvnw/5?=
 =?us-ascii?Q?n+XeN7XZVjrmJMvLSg1ETWeNUduITLCCzPx1EJSXxjZCjJTkxRLSYRUNx0qA?=
 =?us-ascii?Q?fOChYtflGCTIA22SaLr9QaNK9+ZIQxCqa6YKQpF7XeNGmJQZvvW0uc8Of4e6?=
 =?us-ascii?Q?48BVWB2b5t2wGPhOeo5pnBT7iHtipgND1+oAvqNLQitnf94TLzD16GOgbF6h?=
 =?us-ascii?Q?ka1RjyzbcBsW4DotVV71vKNMgUQl2A44khXRpSSxSz0/YNR3ysrcQE5bl1vt?=
 =?us-ascii?Q?f7KVoxjaADLqCypr2QGY/EIPoW03Q9SjwfQps41hQnAWoNLOTEBpx2GQ9fTE?=
 =?us-ascii?Q?YZAWZWS9Iq1pXmEYAEZOnZIjDGpEw1UWSKXOMn1xBpDHwPd5Y8dsvWehxHKq?=
 =?us-ascii?Q?7+kUW0nclDgCB4Dj0uQECoU4qhQilfEt5E5fWSLjxSh8zqrwd3U5dgrUMDK+?=
 =?us-ascii?Q?Liu5wWw7B0sLwILb6DzOVckPQoQcz7Ohp8YBBW6QwvGIPaIjmM4NPiWbaUe6?=
 =?us-ascii?Q?j0xtwYnblYW1nGYdtuQkQM9K0ar5fwYZheYcXWunCvOlEKoUfzRDvZxu7dZu?=
 =?us-ascii?Q?sZuAlA4JV3bznyHjM82bKtnPca3wAXRNW+OaZUqXoYN6up/uOF/YpHeo6KjF?=
 =?us-ascii?Q?J+zb33a/KtHz+SlCIiKPHsw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c85375-3d03-4aa1-04bb-08dd70416747
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:16.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hCLj0z9pt0tLg7GMlT7WvZM0tyKAacTFcp5mc42LMt9SF1xqdGRgRSbLAA25x4dX/CO9/Km0SEheHjMJorfA1g1ynNTDWlOS0M/sd1M+PXzhEkTdODz2WQ6A4zjHUIV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18423

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1737715a4c2c08f207c94cc1f3af3c5945318d29 upstream.

Fix the missing return statement in the error path of
rzg2l_pinctrl_register().

Fixes: f73f63b24491fa43 ("pinctrl: renesas: rzg2l: Use dev_err_probe()")
Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Closes: https://lore.kernel.org/all/OS0PR01MB638837327E5487B71D88A70392712@=
OS0PR01MB6388.jpnprd01.prod.outlook.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241003082550.33341-1-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 4ccdcb1457045..c6ee32a7a9410 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2711,7 +2711,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctr=
l *pctrl)
=20
 	ret =3D pinctrl_enable(pctrl->pctl);
 	if (ret)
-		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
+		return dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
=20
 	ret =3D rzg2l_gpio_register(pctrl);
 	if (ret)
--=20
2.43.0


