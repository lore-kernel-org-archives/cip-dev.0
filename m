Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4A1C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:45:41 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.31])
 by mx.groups.io with SMTP id smtpd.web10.49041.1743417936979762257
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=r/apJ9p1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.31, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7l2J5Ny5muUEwEUttwW5T+0NNgd4fablU333aw5HsAHMpir8W8WqgbMABsH7VoMoK3XLX7Pyiw7a1m4MLXP9QGAYP8ulP/QUVlP7BoCTszoO1OTmRLNzJZj8TVBruTgU/VrlGJh0KAhbxRmTvgZkHpZwtNQZiHUOsdUpiHLuBW7SYacqkC8/ob+PsyPv4CI5XstOQBcM33L3uS5v+s+g6rotPiPTCpcx5l3b9wCpErkq41ApdhqwdzZMoDuW9yLyyKKQLBXPJ96dXiykSk1j4alVRP0FgP7n0CGmnWmiZKPdt4e+rFba7E0B/P+fltQ5CxEfw19TPQ8YrRrBS/1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxHWdbHZE4dIMkhOG1bTj8tY2Xycq1+ZxkHLDkuV/Uk=;
 b=nmImtmYhhgO0xw754G3VDt2DCnOYN3Je9L1vcBDoQgD04Epbhat3Jv5UzzWbr1aYEWSMPhmuk60yIgraCM++iKmgrgiIYa/Dk5PFgpoEsZU/bimqlEHfwEi+msUtkOLCRNK3shFQjKAh5ryBFvcQ8TefsHVbguAuDTmlkO25XKaIulOTXDaFKdcQmfeaeax4PidVWaXPv9fTqDrjVpH9wrdihOLY9SrBAtYCJ8rS3Mr3bn1+0sn35fbEczvOCJhsRZr/mDkSlL1lHYs3OuNc71yvU8GACF7+3o+4znK0wM9N/Pph5c+VhkwcYKHCWqoFEdKbWwsPWjdJEkN/ZZLcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxHWdbHZE4dIMkhOG1bTj8tY2Xycq1+ZxkHLDkuV/Uk=;
 b=r/apJ9p15KkgbFPGTE2wNThwWfrwqr5g9ygJmbMcySwDFmY759lzen6gWCZLNznZdF2/p/1dx9pvtNgoRPJvEPWhBcG6iBSr01XNiTWSBbOofQeRL+vpx7xaEtaTBVhA4WIcNVfFxxFSptqnCfrkyP1tAQY1Mpch7/7Q9Kc8UfA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:35 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/43] dt-bindings: pinctrl: renesas: Add alpha-numerical port support for RZ/V2H
Date: Mon, 31 Mar 2025 12:44:32 +0200
Message-ID: <20250331104514.79090-2-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9012ad-7dbc-4ca2-6a59-08dd70412ab0
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4GprAD+34BKSqRBxcGMvKBz0dPx4jf9VZCPyyRSoq2mz4z/HTgthG2hJdkx4?=
 =?us-ascii?Q?idpuAB7RMODmAUbof1jEQ/c/lS4aEFoVLPTKYx7mhaJJgw/GkT0A039SPlYW?=
 =?us-ascii?Q?SAnZIW89YQjzvD/pDmAsQjm/X4QEL5m+vZg9nLilTUFtcE01l7Dbpfx+ucqz?=
 =?us-ascii?Q?lBQygDBbQDUVSUN/T4fVpqnBJt/HwGvedf+s6seb980HYbG9STJ4FtPgLgqp?=
 =?us-ascii?Q?XDOGMuxHqqAK/P24Il+IRhrbbQ+9gDidmhcLBqYIAuegEXpefF8HbmOwPw0F?=
 =?us-ascii?Q?K7xEv9KTBbp01H5MhxJe16sTPtPqxaNtrVzXgp6U4Fz47iCbx20veXI8bZ/J?=
 =?us-ascii?Q?BRFLJMYUaVs3gLeLwdapeDIhwZZUeSLheje3kKpzQxRYZgIYtB+LxKU/w6jZ?=
 =?us-ascii?Q?8kf1eQAgrnAidTUyC8xNsqpFI+53pF6fAPxfnGfLFNJvX5auqmQkCAdhxVmB?=
 =?us-ascii?Q?Ip1/jutsbU2tMXPDtEFvYUMLPItUQL8FVQT491BdquWvoMQ71/TcpEIn5IVB?=
 =?us-ascii?Q?WRw744z5wZAu6pK+awZdK+wLnMO3NR8TgPUo4el9NHHg7QBqpf1pOqvy8vmz?=
 =?us-ascii?Q?pBSFpYOL/AdS5Ik2qBwMnjkE1elmoVhBvilv4qi31tEotQBwfZWx098B7uO2?=
 =?us-ascii?Q?YAOukB092aWWpRz0dpDT4BFzCgwXVsCrK/HvbQBvqXgR8SrnT3EO+trsDgmK?=
 =?us-ascii?Q?7slz99n1SK77Zz8enqmFwC4kno8R9alelZKIoAi0nkl1JuO7r0WQkSu42ifK?=
 =?us-ascii?Q?s/Lt2+o6ShtQfOr8wbZzDZTRM5wT8OLR0HTLqG4wGVA9FdqeliyX16bfD4ea?=
 =?us-ascii?Q?rCsavrhhcAH5bVUwJ0ejsnGO4hPLCoaPBMtTtkyraApQRc/fY7Ryme0WPenr?=
 =?us-ascii?Q?ZwGOi/UwYYJ8ZZLqrZFM5eHjFtoQIvUiFLDvp04tF0eGdeHuo8dyGrB2IgJ2?=
 =?us-ascii?Q?GxSOr1qyJl9t2iPXha3hOBcfsz2rdK7RMjm6sy89DSP3cGRme/WOlm/QgAj8?=
 =?us-ascii?Q?s/Uo7VCmfjH6YkXmFWSXrixKmOHLQM83uzEvRQsOzYZJ0K5Qnwx+3SY3p+16?=
 =?us-ascii?Q?+vPS6gVyzcNUg5eOIerkYIY9Ycu7yCrgBZG54dslrm/nyG68K5Q+MKsl16ZP?=
 =?us-ascii?Q?v6cLz5zXNtyx2SrcP/3ofG42WGTry06BL9QTkE3hcGx9hCRChhkY3g70qfzo?=
 =?us-ascii?Q?XpkdO6NRnkxpcEOyNvVbeEmydgiiuIZQ55LpY1wKUOFG6mK6ZdmJoKQbLxoU?=
 =?us-ascii?Q?OCfTCco6QT4SMZgqm5IAROztYJMkih3C2Youg+mdXTjKN81pB0hAiRvafy+b?=
 =?us-ascii?Q?ZoTJm+PWh9dIGiSdKr0xoEOqJRJN0qMlP3iw97PuDkPGJ9YPsdRAbjaiTrYY?=
 =?us-ascii?Q?pCuyZ5tM2ne7GKxa3PdyzT6WRDWVrIvS4xk0NrIXAzy5xwAyWndTmBQNx9GS?=
 =?us-ascii?Q?EuPT/lcv+rbcpOdPPrVtgmPP9ZN6iqdw?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5s8S9Z8dnu1ybAlb3nb6g3TzuHTSsmlrYMM4OyG4qnmr2zWFYhQGrFu8cMIE?=
 =?us-ascii?Q?VB4GFbhtKf8YUjrmgNXO4zUE+cmGvBPba1AfvcUhcqGYbDZbcpHkg5LDnfzD?=
 =?us-ascii?Q?LMsxnoGPefKmXzqIzSP9rnNug+KsO0Ej+NiafV7EjW7frT4sHY9P5uMQGaXb?=
 =?us-ascii?Q?+Y9v2Gc+du0/D0YC6VnB2neYke53Cy6Wj/nTMOGtoGZSV5pPAnuKnBaTRnyo?=
 =?us-ascii?Q?yBVTMP5yxxKB4SQGPU++wIPG2VlQHKIy53KrvU5v7qWnCmOLTDX7d7nCCDYe?=
 =?us-ascii?Q?LFu587pWyPP89ddz4U2X415JtXgRYdzT7oYX6pMirHRe2M2juzmnkscSxoMy?=
 =?us-ascii?Q?db270ugXh08fbabRSFX8eM1/sNU7K58FdJ6c3KOzRJgjsAmblXXGg2HTg5dc?=
 =?us-ascii?Q?mkvjh9iPFwNX4vbm7UXGd9TfBlFxFQJMnk98XCmytJGPIOjrMHAoKv0mPj4K?=
 =?us-ascii?Q?NWxKUmsSRVOVdbqI3wzaUytngkYA6CyFIXvCvVw38a3JZKtA6cHOiNcKhVZJ?=
 =?us-ascii?Q?X/hxBV4y7MsHGcT0SLP8nBtvWFuCSsMTPfdfyTqpQRtBoPDp19tgpDxxx7co?=
 =?us-ascii?Q?0u18X/O7OYR6u1hEWO474WNg4q+z3e8oT9VJ+w8efVpGh0djnFqF8v9ZKGok?=
 =?us-ascii?Q?1w3/+XuvvbpJ9WPFY5huXChTZliZxQH3EWxbeYw/YqCisnEvr7u7j6aFZjRX?=
 =?us-ascii?Q?LHdyFlKMavvGj5DicRE5Qv1vaakSMdPelLLMrHj9Sv9Qg6RhAPa64yl+NMiS?=
 =?us-ascii?Q?f4DfuG81DPnWaNGlenQsUZu0JRgXmp+rSrkRydP2LeYzKzHa0d1q103eLYYU?=
 =?us-ascii?Q?KzjrPNdC81c2/Mk6Bu5NKOxoX6eqFZN+WqYiVRTW5yHg/7dWuyGwX0zYpA5k?=
 =?us-ascii?Q?pKAJVOlZUNjnM8ScRe7axCImUy0iwICHJcp9y46JVRKMc2coun3Ksa+WxWO+?=
 =?us-ascii?Q?yRRpCCKb0QJJhAT7+zphQQpCEyl62wp/2QyAnUosj+h2jWmsksWXA57LSeiZ?=
 =?us-ascii?Q?C0QI4ooDLsGUtWczKd/z0KPQNbWBNpWOQu2zwOncu/xvimubfy5uzkcdw2Zd?=
 =?us-ascii?Q?UqfoNKeBrS42xtQpGYCqjVvKydBS6AkvEVANQ5DrBJm4y1sElN/Trnzjr3Hu?=
 =?us-ascii?Q?Pa60d0o35n/JHA3xpyvTZnHHZWm07k+eCousvC+BI7stMgQBw6xmZJNTMNmy?=
 =?us-ascii?Q?mIPJATp6eiXaBw+KrINP/RRp1mcVVDDNlH00M4eNtnD6fCfrLpyN9xjAEqy+?=
 =?us-ascii?Q?q5wjaDBeypIHQmP8kYSKHtdIcZPjlwuU2LtLQPnwbi7Qwz6zNxOSDjPClZS4?=
 =?us-ascii?Q?lsjevhxQIdQUUWVv3o4xFUd2zVOX0slSnCH7EXMaz1SwJ1NZS3cgA424pyQi?=
 =?us-ascii?Q?um2duVxTu8i0Xe0k4B9l6G1uB1VxH7Qal+FVAse8v29JMqKfugf/2ykCOXfs?=
 =?us-ascii?Q?fIqo5wB3lT4QC2uNVkGljC64eCdSp5Mz+wKsdG57docbcFYzb6TUpou7QFBh?=
 =?us-ascii?Q?69XwW5bFqRTKVMZIq6ssEGqQgykcB6LUuKbeYiCm/CsMGfnbZw0S+U+N+AId?=
 =?us-ascii?Q?h5ZyVEbyiZqJtbc0K6GrCBCLAKSMXpHgI/xkqnPp/cwiN+u1TW3POYs4pOES?=
 =?us-ascii?Q?pDiYtVeICtepIS8/O3FZN1k=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9012ad-7dbc-4ca2-6a59-08dd70412ab0
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:35.1272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbS5SHXWb8uE2VMCQmrXYq/sJhxDoxeYdFxSSrokLrNxMHWl0Ae+sZXvofSp9zRAzJ54wb5ykkZ+XUVO4XG38OFpTVd1DjYhAMSrY+hQWqZUnIhM8IyxgE/GKt9vWkRJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:45:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18389

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 3e4863d24818a41db42b4f2680715f204657839e upstream.

RZ/V2H has ports P0-P9 and PA-PB. Add support for defining alpha-numerical
ports in DT using RZV2H_* macros.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241216195325.164212-2-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../pinctrl/renesas,r9a09g057-pinctrl.h       | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h

diff --git a/include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h b/incl=
ude/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h
new file mode 100644
index 0000000000000..2e83bf43160b9
--- /dev/null
+++ b/include/dt-bindings/pinctrl/renesas,r9a09g057-pinctrl.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/V2H family pinctrl bindin=
gs.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__
+#define __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__
+
+#include <dt-bindings/pinctrl/rzg2l-pinctrl.h>
+
+/* RZV2H_Px =3D Offset address of PFC_P_mn  - 0x20 */
+#define RZV2H_P0	0
+#define RZV2H_P1	1
+#define RZV2H_P2	2
+#define RZV2H_P3	3
+#define RZV2H_P4	4
+#define RZV2H_P5	5
+#define RZV2H_P6	6
+#define RZV2H_P7	7
+#define RZV2H_P8	8
+#define RZV2H_P9	9
+#define RZV2H_PA	10
+#define RZV2H_PB	11
+
+#define RZV2H_PORT_PINMUX(b, p, f)	RZG2L_PORT_PINMUX(RZV2H_P##b, p, f)
+#define RZV2H_GPIO(port, pin)		RZG2L_GPIO(RZV2H_P##port, pin)
+
+#endif /* __DT_BINDINGS_PINCTRL_RENESAS_R9A09G057_PINCTRL_H__ */
--=20
2.43.0


