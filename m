Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DAB9C28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.25])
 by mx.groups.io with SMTP id smtpd.web10.34485.1741778802751751023
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=eSQMy4M/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.25, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yM1e84hreHfGRNxMioqW+HwNBppXN8JcOP69F2vGvcSnLaru15iX9yAR6zNMLmdrOQbTvxhZZcZJYYzPcYjtnTIJt7KNwhOoqxxkS6JrFdRUlr6ZK14LPY0w4GWjqvgObBpvynh5ANTg1s9V7F95N1i9XiyXuJ6/tmyUEKSFY9en1saH8BFaF/ha90wr4Ja10M+mhYDERthA2l7+S/SgRcQWi2+Gz45Lkwx+tZjB8WXcdHvsDyNV9R3pukO+xzCotax+h5OdzcZgirUADTe8bhIeYXyWoFzdT/CiXOmVIpt5VBVaG2eI4qJywcoLGYsGwXi8dQUjW93PJzY/dP0yvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n599i/qi8D4z33CY99LihdV9zIcSj7/sKFVRFzbVBgU=;
 b=fkwwFtmof602I7IQer36cV2sMsW77Yw7P/Swlnb5HLhSMZyYGI1rLh4NBu96+7XPd5mOXr+xZzIKpJKSck0BrrNrBUuksvyNx5WbENs50jZ138kodwcEtrUI2+nfWQBZm30ryXX9YaxDMslEVFhKbVCNeVNMi0ybHE6uCqjhE+7qx0m2GdP2pENEYooVgduG0qbwo+ynAx9esl+IQiKaEnaMD+csw9ckYO4HgmZBC4E7WRykdPT+GzRcVIm3n57LgL5zAk1Gy8RME+uPr1O3l4T5SPryaZ+Ndz9dMts3ziGB1bi0eKjq0OLDandqm5SvBTw2xukGuyiWztQjKPiqcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n599i/qi8D4z33CY99LihdV9zIcSj7/sKFVRFzbVBgU=;
 b=eSQMy4M/rXlS04V2R3+rzk/qt04atgARhLzoZWW7nW1BRNczs4SDOs2a8F3pOP0O74I1PoVA7+w1oOPN3FxykuT5Au/4VnptHQPytqh6564aczXSYRke2bQOpTb2geE/YrWUy5NkjB8yrXp55A/hlTb3MrDyuzxEtl4Vdy0HXLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:41 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 63/85] pinctrl: renesas: rzg2l: Fix PFC_MASK for RZ/V2H and RZ/G3E
Date: Wed, 12 Mar 2025 12:22:40 +0100
Message-ID: <20250312112302.1605750-64-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: eae59997-3be3-4c61-f231-08dd6158c2bf
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LV8LbU4q/Wme7BxyWsb4hKBKumlJjtSPF/ceK4Ym9EpM+elocaG4bpr3R5/O?=
 =?us-ascii?Q?6dzP/aPx5zT/nypDo/hPnN0A1KpNVDf0adBEzkUmL5MLhkt38zJN0AxIndxr?=
 =?us-ascii?Q?+K8ZKt19odJptuZsB43Gos0Q/eMKKklBbjY65DXB54jjTherFZtN4BIWj/gM?=
 =?us-ascii?Q?t87453rjXQvymEXJXbBR0Pc/U3KlEKLoBOWGl1WexDFGjf+ENdDuALnL8FDM?=
 =?us-ascii?Q?DCro1fIe4/Nl/GSs2W3ryNxjxiTtrLRtTFtdXWOCRrpmu++XvcQBWli74gOV?=
 =?us-ascii?Q?89pMQm7q+OVXxCpyv0osKjZi63Ej6KYMVRI6L8hnsS8weUwafpkLBe2tG9Uu?=
 =?us-ascii?Q?DtDsTbUxDdBGalgcJxlQ9y8fqou4jZcT5Vv9XJt0PPiy4rRrkZYYbo5SGZcC?=
 =?us-ascii?Q?K1TbnNtxUXV0GYZHA5z5/BmF47wNfcIb10EKq18cXlkgzR/NW0c7uBl/p4tT?=
 =?us-ascii?Q?Xq+R97tColSws4Yo0MEweimXsPym3OpEbZK75/fQAsUdhBPibRgRYCqRcWA3?=
 =?us-ascii?Q?afhnxQdvMYZKlGB07PW5FzlL98XuEWS9UnZwMoPfqsonU0uhFI2qTUdmUDFk?=
 =?us-ascii?Q?xgpy7RawF6i5Wzwc8l0oAdRFo57s6xVpCeT46Kbaix+8L3QwyFobkil+TPrF?=
 =?us-ascii?Q?Lv5HrRSwtGLB0eF5GgCpp4AvUygAbGGe0GWA/vajVw8Ep0tIKM1uYoN5y2IA?=
 =?us-ascii?Q?pdwBzqb7N6gOUA5wYjjyYZyJxd8iV53ggdjEci3Mibp6pioijl3Kzju5/GLf?=
 =?us-ascii?Q?mk7YKaCGD51FAxIcG7ThnIs7XYlZHTIXE/q85dVnmlKcNGs7vgdg7rYOr6sL?=
 =?us-ascii?Q?gEBoJU+8e5ckO+8cPay5ZkKD+fpTN7S7On+/9C6BI3qkXuT3pg5mRXsP9px9?=
 =?us-ascii?Q?hPo5USo/W4ONBR+8lujfMuMEbitZxXyfWgFVERql6qqWSKp174p968qAa73L?=
 =?us-ascii?Q?r6V1ZeAEtNv3P1Z1+feyKyPlKWOkZ4clEOk/baic3NjWaUc1FC+o/v0EU2Ca?=
 =?us-ascii?Q?QpvFcRV1rs2cYbtUhjbraVyKZ8kK2RR9/R6xVfJx6aHQkBMw8y8UIvCb4zSt?=
 =?us-ascii?Q?OyI9IB57xO+7yRuaUtZczbeiisUU2qiFZGdRzuzrUrRCfB18TnsmOJEfBwg+?=
 =?us-ascii?Q?3XuBMi5VzredEs/FwCfBhpXj+8aTtZc2AD6Ec5RjEDcz7bL/SLdsgGEobIzB?=
 =?us-ascii?Q?pbQe73Uo9tSOm2QyJRXovzLfHJgm83d706rZgKeKr1fZjJS1SFdfjflPLwBA?=
 =?us-ascii?Q?6XJgGTxdTbLORYesCxgXjOGKs1/PZMK43zQFq1XwmYLYJ2iSnkx8jPhqe7fJ?=
 =?us-ascii?Q?7UVAKgZ7vq9wWYnIwUfHEWyKGH6NEQSQrwUkPr4SnEXeQRjJdSPpIU4GCh7F?=
 =?us-ascii?Q?7iRFkVpWspV3Le4RUlc4z17g+2buR6FMWyKZziCO5wtQBbtDmOPi479Iu3NR?=
 =?us-ascii?Q?qCaVD5iW3UURVbhquqBktzr4CmWF6vXJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HUYmpTOBDuHQNCJVs9KD6j1lyZrau1uB4Q+ZuFePNSDN1TYUYKY58NZfqYQ0?=
 =?us-ascii?Q?ZHuJ8op4CuTLpx6xIPwmU/bvUC9Q4dsXhKXNU80GrRwTRM5f0OZG51De3sLQ?=
 =?us-ascii?Q?MFLQOA6z6hdsiu75EPpmjGOXxK1lzHAdCSXB8CQ3H6eIBfc5JsJy8+8DSOBp?=
 =?us-ascii?Q?X7+OChFwzW9fQf+qsdOwsy1rguqcy1YbiS4Ehvbn6Z8qIpfP7r7KHlVO49e7?=
 =?us-ascii?Q?llwWdNk8jLosuJSA3bFlYfXI1JXM+e39OOo5AlhNwfIiITshZuc5hDDdEvlO?=
 =?us-ascii?Q?UaKcvQChkbxybKhKQ6vwPsz+GyuF/8TqYo+2DAwGT8/CXFz7QuGk0u1JOsZd?=
 =?us-ascii?Q?ONYjo8OeAXqgZ5JSLGl2lZ2GnQgKa/a4QBRuiG6EUWLS6fZiADN+HVV3+zRk?=
 =?us-ascii?Q?6fXOuBHJx14MNXHN+jJg3GuDqbHZzXLeFtzO44CqopUglqllm/iUMjqIBz+3?=
 =?us-ascii?Q?0hHXCd+O+K3/XOshw0BWQNI+Ak6XVl5lqQBQ3ZJ1yS+/N0EN07s50mkbScC/?=
 =?us-ascii?Q?1mTdq5AcFElnOXvLJ2ZmCYQk9nnDXjEnHfnjkaddWP8T6+rZf0iC+TOtR+PI?=
 =?us-ascii?Q?8ZTaP0R0M0BglWsf1NbI46IPJsClhmNiWqdz3j98vdChb8FXV9G2AC7crWIY?=
 =?us-ascii?Q?42Sqe9xzAPZ13d1GlfR9RZ+JlTmiOmoyZUf8A+HLKR/dabELsOSeZIYuRGNC?=
 =?us-ascii?Q?xk5ogYnOKQE4yrKoNbP6GYPVG1vTKPve21PXs05Js7FeJetSpz+/2FalPkz4?=
 =?us-ascii?Q?wuhoxZuj08NXdeuAF5hMCMwxiWhDFaXxtiwTCP7XvFLRmaWarPpQzXSXlNWW?=
 =?us-ascii?Q?rf2iJ2UdqBGXjyRNmMiE4v9Hfov6wueVi2+8v4AaSEuv+TbLg1r8uKs1QPvc?=
 =?us-ascii?Q?96E0R5VLiZRUVarGrXKzIocU/jRwy2JJyJovR5XMZPBJPTg5AqzV2P+VI+8G?=
 =?us-ascii?Q?pKo69M2cUWAjTOvumOcDqhQC+utU1HtIfygL3/rOtxY7XUQDovBocL0DYgln?=
 =?us-ascii?Q?79+201qwPRQHisx/UGYsWR/In8WG/wSYKLq25OFBPc+Jd/Wx1EN3L10P08Jy?=
 =?us-ascii?Q?jw4epMVulUyF+4WwJnFny0Oyftkohri3Vao/FouHL2yNLH1PT6Eqp+0XJpnn?=
 =?us-ascii?Q?1fhV9Fhi/Ed7xeH7qdihSI0/igFNd/82BhJKHJa3u+3/9oxOBU1By1I/TsoR?=
 =?us-ascii?Q?pWE4V5p22vMRj4LeSSc1Mi1fe3pbKMGmOazJd4kklkePW3MUHc/VCMy3yrRr?=
 =?us-ascii?Q?lEyOQe6ChC9WPxsh6snmERWLE96807IYtlDEc8Bu3jJD1RRzB19d+2hlIkIF?=
 =?us-ascii?Q?/k+t5VvPgKAd+vGr40KI8AOLX+ZSo3bAjarvlQNe07qdQCgPBMkBMdLM4ggJ?=
 =?us-ascii?Q?/pRAP3LCH/nVJGdHF0QY4tvQ0vpMatIL7hVGWbyFI94yG7fZqF+sHVJPGLBu?=
 =?us-ascii?Q?yBjj6Wf8hqxEleGDBr+3oYXSe5BRdtZJb4k4f/QgkJ8cKdh1p4EJbp3ZlbQ5?=
 =?us-ascii?Q?SCe8TiSgdp2MKz8rF46ZAcPPvCzpwjA2A2twjItQF+LqYnnFKnQuiKIycpTH?=
 =?us-ascii?Q?mlbPg7dC+lLstqjp3GR3ybO7Hzy3xI5V5N7rwrRrDNsj0zyQklDqQPYuT8JA?=
 =?us-ascii?Q?OFIUkm/NogIKl0t4G9AQAeo=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae59997-3be3-4c61-f231-08dd6158c2bf
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:40.9987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFvmz27dMk4h19I3tjtzEz7bwPar1ljV1xrwJp4KGdd+DhfP/YYpNc71gKiyC9actURjl/v3dWb30GFKj3gQBVYaPfqeJVDwIcxY+AKgH0y6vyPhBAM/Qx/UCqfzlyxZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18155

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit accabfaae0940f9427c782bfee7340ce4c15151c upstream.

The PFC_MASK value for the PFC_mx registers is currently hardcoded to
0x07, which is correct for SoCs in the RZ/G2L family, but insufficient
for RZ/V2H and RZ/G3E, where the mask value should be 0x0f.  This
discrepancy causes incorrect PFC register configuration on RZ/V2H and
RZ/G3E SoCs.

On RZ/G2L, the PFC_mx bitfields are also 4 bits wide, with bit 4 marked
as reserved.  The reserved bits are documented to read as zero and be
ignored when written.  Updating the PFC_MASK definition from 0x07 to
0x0f ensures compatibility with both SoC families while maintaining
correct behavior on RZ/G2L.

Fixes: 9bd95ac86e70 ("pinctrl: renesas: rzg2l: Add support for RZ/V2H SoC")
Cc: stable@vger.kernel.org
Reported-by: Hien Huynh <hien.huynh.px@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250110221045.594596-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 36ef1b558ae3..6e5715328682 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -158,7 +158,7 @@
 #define PWPR_REGWE_B		BIT(5)	/* OEN Register Write Enable, known only in R=
Z/V2H(P) */
=20
 #define PM_MASK			0x03
-#define PFC_MASK		0x07
+#define PFC_MASK		0x0f
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
 #define SR_MASK			0x01
--=20
2.43.0


