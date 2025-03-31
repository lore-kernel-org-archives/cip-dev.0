Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4EFC3DA4A
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.13])
 by mx.groups.io with SMTP id smtpd.web10.49098.1743418048927644782
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:29 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EcHRJjQf;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.13, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FcNZdNdBGbNjNJyVbgOCVP+g15bnruvVtynRuNPSPUZYnnpGZhswAyOzaiatyXPpsGWM0uKzTpF8qTxQqOWmihnwffwtIpFiPxWJpWrXADo6s1k134g39hW+tHwFcTbSuIRaN+E+1Ho2CiJnSIoflj2XLJbvkO2v9o2oBMMB5wqFJr36Z7zyQwkMBgO0v0ZbcgO2zijn/jBTUb7LUtPhuR1iHrVbzFRF5pAbYX4Ka+wBjygT1r6afQfpHt0Lwu4SAN4G9P9kbYPc4Q03yeVidxdOv4MzEh7PD9XBclpFHlrIfdnQOKxg2bA81veGN8mS/1ZCiJ+krMAgRjL9sZ3Jgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+PyPPhFl/VEgruP7Cxun14HvrgOiDOTzP64rVlY96s=;
 b=sies/7ktqJa8bUQrZXpimoHCbt/itFi34hF/YblJ3mNc+0AZOcIAfVTh+1+IqRCLqww4IOYXyZVusguTPiJSXIBtV37bEo8pBeCNtg1ayGNFspoHiFmYYUA/ZR0A8cRFon28cwBsDcOeEPvYO0VmUUTiObEHo2YKLOwvehBz3Qg9acTbr92QUX0iwYtOSxjrRNKNfd5EuAdK6e4iQW2JAzGoe2S6jWj6T5nLjJBkiVvyxFs/H5oSf/iisIET57WKdwuO1jS2Ku0DTpTnH3vo6SOuJ03hcIjmtLiixB6TyOUY+CthMqYviIGbx9EJw6opzhMXDdczFzEzxU09rKRbIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+PyPPhFl/VEgruP7Cxun14HvrgOiDOTzP64rVlY96s=;
 b=EcHRJjQf1Z1rZSG+S/Pz3zS5j+khvziVLeZ+9Eked5hURlGLNa0a/NCSO213OKni+QAStptUPoDvRvwnI8V3b3pCwnPpyVlgt+ooXLC7HCS+q14v+eAMmVSKaXBOkXL2SALuQ5jR18KQGZex3K8XPyP8+StV1JCMowDBLhNcVEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:47:28 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:47:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 39/43] pinctrl: renesas: rzg2l: Update r9a09g057_variable_pin_cfg table
Date: Mon, 31 Mar 2025 12:45:10 +0200
Message-ID: <20250331104514.79090-40-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0fa579c6-7fc7-44aa-4b53-08dd70416e56
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KMINUSq3To1aNTLpgC6mkgNUH01Ebd1wnfWQpUqDZpmtN4cOdixoOg6EOkoU?=
 =?us-ascii?Q?aHWcoAhu7gdt2bgr/snOQ28/5CjW3P7HuIFDW2kdiugbNYPmjrSV4FyPl3eW?=
 =?us-ascii?Q?/28LNAE4YwjhO0A85LAJfJg3kV5dRb3q87o6tYg1+rNnQYcgtkclqiLJb8Tt?=
 =?us-ascii?Q?2GHbBqhqViNFgl+BcPCh/S0geEjcTwheY2jyyijnoylPbdgGquaLP+RZumxa?=
 =?us-ascii?Q?GdKW1SB9ehpza/6INuHLH6K/hiNXtJvGzoN+jc+IhmZ6lHZLyq0RGEZosSeZ?=
 =?us-ascii?Q?OfV0GlFpYoxSrHzYdT8H6s+xRqEt1ebpIZoOOrsBd/LC6EuVFTps3CPtpewz?=
 =?us-ascii?Q?dztsbc5P9m7j25zc9gDnJUJ0LJ3bCofz+x073B8+c8NcB/49/7y3FlOg1tSG?=
 =?us-ascii?Q?uOKJxC0kOAzXegMDwyj3+zzsRnUPLJJfreGyKpO9t3s+LGaprSLvg7HEV1Sl?=
 =?us-ascii?Q?llQAP1URaeVIBuAtoPwygtkY85OIN809nIzRj2E//7/UzIuHOBI28USlJIgp?=
 =?us-ascii?Q?AHDclQvwF1oGeSqk/K4yIFQiJFTdZe02dPouzNPrmwa0+xy93Zaynkfv2eJL?=
 =?us-ascii?Q?GmyuhtedvJcFyqTOYs2Rwn0xd/1DgHhQG2DzdB5aG7EG1H2qAMDrIwIT6eAL?=
 =?us-ascii?Q?C8u+1YVaIu1sZGp5voK546hzIzJ7fo6TAovQj8ldEynT7LB4TQPEuoJImPvk?=
 =?us-ascii?Q?7b2HkLRDcgW7cHrrq7V1WVvrCvkxu9LDuAUeq5NRlz9GEMXL2NyzV5ZItGE6?=
 =?us-ascii?Q?1ch7KHPXtFMFt02LtcOy2wxKrpntPX3wC247TR7xmnTucqTj0IeqRviiLWQw?=
 =?us-ascii?Q?uxGuHgqgpGdEyQ2ly5x+z2HJkkvUsgqzXdsUb5ULwGbDZW43TOgYYmVLkwG0?=
 =?us-ascii?Q?CeIPyRFk3tonjfjez1/YFUif9xSgPqr0BHWqkXq1T+PvEetRuO5yFLcP7OAp?=
 =?us-ascii?Q?2+QxSUN3LRt8RQv4/9w3NriYOz/rg0sfbUtbm/xtRmAgLU89pE2xHo/vdQDs?=
 =?us-ascii?Q?1Cbc0VTH+pHdNylSx9SglKyf4wERxQ7yOTS53k9iglRSsbcMkTMqX/wi/Uru?=
 =?us-ascii?Q?V/RgQqcVMXivRopiJ1it2fneiOPuZiB6wuQquOYuxVXeayDR2wpgZz5aBG1U?=
 =?us-ascii?Q?ZCOrq0KKIyyGaNivTvGMWYO+/wA1lY8hjoZqC0xWH3WvzdIpSheBoL99Hbol?=
 =?us-ascii?Q?iib9fRj3NpdhwyC89kXkw770pp9Fy1ouwJXS2D3+OE8jt5ZmO9N6eEFJqycw?=
 =?us-ascii?Q?6wavG4Q23dmOB12V5o/p5lK2BX1kHzDaF9BKwuyDcVOWNn14X7Urx9IgxhFq?=
 =?us-ascii?Q?Lju8tRLxlMY2r9e9fmznsqD3TiYQjUblo0HkXEetH7nAoAtCDGfFccUSCtRK?=
 =?us-ascii?Q?+0qxIf7hMjMLylgQATbu6PP6DaaWeO1rg9aCsQuDLQKbiWfyRIGiGbRd+l8x?=
 =?us-ascii?Q?Af+49sHvn/vVYUYiojtcBIFtEmgRstWZ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CgXlU9mIpVKnrS0T0NjLXnTmNNtvytqOBRE1tBZli/oJcbkpAu4SwdoHOr7+?=
 =?us-ascii?Q?tiOeP6gPlIARGJpiS6HdcJWPiqkwpDbd3WHAgJ9Gs+yH3ujyLJr2BcKreBEL?=
 =?us-ascii?Q?cGrUWEkGexk1ZcCDegvzlvEy3xOet1V5LON036TxU79VeB+EVlDWkf4EDhmN?=
 =?us-ascii?Q?acIyKMOR1ytoVCiIBnDOt2gfQKCwQAKXT62bf4mBK/l9dKTOkq+NRJ2F3IEo?=
 =?us-ascii?Q?bt+QWNvRRpo2UhnEsmdiOJpMkB2G0OnWr13uLdN87QR8pTNFb7p0sfVjaZqN?=
 =?us-ascii?Q?lIyOOzw8kItT1xVkfJ1AgNmPCtvl1RmjGR4UhydPI80mo+UWaFvDzKS/HAV5?=
 =?us-ascii?Q?dWjVQ1zeglQoI4830Rx8EYbzV+lakZWy2DksDublEU3dHGHdtEdUUpk5wde4?=
 =?us-ascii?Q?bJS9wDnPaDhbipljazFGS7yycevbhgQbeeVloEhH1JaF2sgpzrGO5CSHeiOO?=
 =?us-ascii?Q?bmV2qfhZ1pFT0BDDPdvuOF+788UCmoIuqoq49LEyrD4Ey28H2h4x6680dkik?=
 =?us-ascii?Q?rSFZHucEWzOLbDIbcN0cSZD7p/FE0VfIRq3Neuz4blzhyomwMdwp/LuJmDeS?=
 =?us-ascii?Q?5bgbbFdZTd9J2Td/m84u+CkNfpf4AO937c1YP2xdRGxApVmkUqAJpOJ0SrrS?=
 =?us-ascii?Q?iVnU0NN8/j/6VpNwf2yf49vKg8FWlbRIfn6qHUiFuqhEhOzfMnNXse60NsJK?=
 =?us-ascii?Q?WRA9+m/4yeNatLlWna+L3L2wEpbPWQYdI8D0ljyLE2wFDE3RMa2yRZxn9A6E?=
 =?us-ascii?Q?cPBlhgleIZC+xZjBOVVXhb7R/r2TapSiCc6++Zp+s9Ee7IYJP3JhOVfE7YHU?=
 =?us-ascii?Q?roSPPrqlQCneZNGxEUfp3mCJQ+l5GVU50n0vPiQI62x9GaWmJljH/YC//5l/?=
 =?us-ascii?Q?F+F+WRfHJZSSSnoCx2XfNJbIiYI86r8HkqLrRaTlhXe1sPQq2D/Ffa0jrgIn?=
 =?us-ascii?Q?7D868Yl1Hveca+rf95eV5zpivqXggkmn/3Ec1pFILXKM+KTqYRq5zVtI8BoR?=
 =?us-ascii?Q?LKDZ/ReRIrUNI9Zd+GJaFRWEFC6L7yQ7tkzjBufcUlghH17/XgGtDWhK+oNB?=
 =?us-ascii?Q?940S3U2/djgwRBnnaq7nWVjlmHzOkwXR4UqywjoA9YObMCWYQ81qthrjdWDG?=
 =?us-ascii?Q?xQIEDbxVJOWjQVQouiK+sfEy4PYF+VuSA4jN/wMhRKbHb5sYEvrC0QRc0P78?=
 =?us-ascii?Q?kBxEp7+1+RoFXKgJI7GbDhTkwpjB9mtbdnBPqV3mGyG0Mv4ddNNFRU7uI8F3?=
 =?us-ascii?Q?moT7is0jjOnrJ0LjDru2/bO/+SMQXKGtW54RCDjnC5SvaaqbrVzhPsX/BGDn?=
 =?us-ascii?Q?TnnzdrJq6WFmq+0ttpravl4mVMZ+qx/iOuTotKEFwI/rK3ufAuFXB07eO+vs?=
 =?us-ascii?Q?c5ryEN0ZcMOPAgb6sG0sPu5MmKeI2cquplScTIXGSFv9Ip1Cqp1lPu6ep1do?=
 =?us-ascii?Q?Koou4mxfMcmLdtFNG/e4oxbez8gqFnE27sLvjnzVwwxO3MdbsWFVwegqytNX?=
 =?us-ascii?Q?nyevwXw4amBVgViQT0ePWzG2bLs1ssSKFLYfEUKhW/5QNfWhebrBUAmeIsc4?=
 =?us-ascii?Q?5DbcWnu6QBXvAGGENJq5alIgNVfJ7iJH/MFsg10cmAKbXcqVlHDgiCs2mkM6?=
 =?us-ascii?Q?w9n24LOehVjb+JvtaADb140=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa579c6-7fc7-44aa-4b53-08dd70416e56
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:47:28.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVdkmIh+6mKE/RIK+Q3hZG3XBSL+uYD88wPrDdclDEIXR28fGlNlEEg8eyCLHcV29R6TAwITHQIIGHdeCppOcHQ7mDfpHIEsivHI7ZoiRW/ZanUaXSkLcF385AYx+dk1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18427

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 0ce66380a7c7566c91d4a159751d5801280957c1 upstream.

Currently r9a09g057_variable_pin_cfg table uses port 11 instead of port PB
as mentioned in the hardware manual. Update the r9a09g057_variable_pin_cfg
table with alpha-numeric port names to match with the hardware manual.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-4-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 353f9b139413c..045033fc84f26 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -25,6 +25,7 @@
 #include <linux/pinctrl/pinctrl.h>
 #include <linux/pinctrl/pinmux.h>
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h>
 #include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
=20
 #include "../core.h"
@@ -381,12 +382,12 @@ static u64 rzg2l_pinctrl_get_variable_pin_cfg(struct =
rzg2l_pinctrl *pctrl,
 }
=20
 static const u64 r9a09g057_variable_pin_cfg[] =3D {
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 0, RZV2H_MPXED_PIN_FUNCS),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
-	RZG2L_VARIABLE_PIN_CFG_PACK(11, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 0, RZV2H_MPXED_PIN_FUNCS),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 1, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 2, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 3, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 4, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
+	RZG2L_VARIABLE_PIN_CFG_PACK(RZV2H_PB, 5, RZV2H_MPXED_PIN_FUNCS | PIN_CFG_=
IEN),
 };
=20
 #ifdef CONFIG_RISCV
--=20
2.43.0


