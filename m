Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E10BC28B30
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.10])
 by mx.groups.io with SMTP id smtpd.web10.34508.1741778843420900931
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=pZ8mh2pq;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltdMCQ7cAD45tITsCLio5lfI0dgfB+DFbWXL6F4DYkMETX+ceMjQBWcqOouemNsgYm5Ljiw4CZ0fVglQvjQRiPgbeBseaZkMzUwi+rjE1QY/OcgKmwuKDJ06vTsqKwWDG9RLNXJukzy2+OTGSG8ZawVbc9F/lx+/xiH+uIFKWEFd8RbM1AJSr9sn3ilSMPtHbzuEdTOsGNhOLll0FbiqWJk9Ons7+Q01CJPj/jIWec76Exrkq4Et+KNPadHH9vbFiSFfj3PgPVCDK+fEf0krYDpYktIau5LITjayZM53gsqDdXm+r062mtUMAyiVOaHs7MzFl361Qpn9VdnLzsu17g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83maoFNw942IXZFIVKcFTpI+e9fLBKb6OQM/YnXAXuY=;
 b=Rd+Q7HRDpjRFzZdaWzKajmUv0k5ApecsG8R77E/iTlJCVRZrYWwAvI1Y7DusG3zvYPTiJTBHWJCHT+COqILvv9LjFAhoP6dbwS6CdzSdMCRl54AYoHwJpEveR6Pdl52NxFHFQcxY7wBROqXF02bnBZgF/48/krvjnRYelPqUbRXVsMP6BSSMM5uCXWq3mGf2G/ztOpkfgeAcU5U1mxFhkulZXQy00hLUVp8DRr1Ag50QFitTqJR+ZgjnlKWq0s6zuWDeOCSrArj228d9Q4TrJ8Yx8XijIrhfx7/cvJGGTU4EqaXQUhn2k2e6DfRp6deaZCCJShZAACBY9RKJD22wEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83maoFNw942IXZFIVKcFTpI+e9fLBKb6OQM/YnXAXuY=;
 b=pZ8mh2pqjkAijH3tIrBZK811eR8n89J7J3R4Ga1dM/8CTcs86NMoJLN0SfxsL15yvHYAYVZgFe3nzVGza+hmqa3I+d37kHXqIIh/U1oFb/+Km0HMuZT8iSdOc8GWWzOOgRnbVtCDIwTKbBCxPdKsnmIQlrquuM+LU6vq6rBnUXA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:21 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 77/85] arm64: dts: renesas: r9a09g047e57-smarc: Add SCIF pincontrol
Date: Wed, 12 Mar 2025 12:22:54 +0100
Message-ID: <20250312112302.1605750-78-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f6b51a-e873-419f-89f9-08dd6158dac1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mUdMrtou29bpeQFBHLyS0yRwEP9HqXqDr8u0JLgK8qpxOjN9k8pg6P4r9vJU?=
 =?us-ascii?Q?Xt7qe55Z1pJpXfnE92VnxVHScM7aPpNFd1B/joB8BqGmrU2KLgCgdI1vRjn9?=
 =?us-ascii?Q?qK8FNS84z/oqqdWkmLYVB0D9nEs5NVfvSX51Sm2oY2ar4fHyfcbenWoJz32/?=
 =?us-ascii?Q?VBGMD+0yAxmJVnIaWkBA0pbTJqNgBVRkgY2uCf0gsNbgANPHKTwvFqduT2Hl?=
 =?us-ascii?Q?ck/Gn2nO6U/d/QcV96bTyfk2CJwYODW1B9vC3DUptS7lj+iMVRyKQk8wpQUp?=
 =?us-ascii?Q?l8LDDxZCE4SZedQMGbkoDIZB9EFp9U3YymGCbrlpzx0xlztWwZdb6DNrokyn?=
 =?us-ascii?Q?AHmyagmC6ehhX4aVzSH7r+d4xfNAAt1e8mR9pNqsJVfAGgb3P5ncoHijrjhC?=
 =?us-ascii?Q?+ky1X3ei4YIbaZO+/TirMmo25cMjDZ++PikV5RqCb2Ikcf6BM3iwEhJHpYwB?=
 =?us-ascii?Q?oyt4P7Zhe0tjZ+LYMTuwVo/vZ28XTvK+AvC5vy68zvKyLlyUhZy0DPC7NBV2?=
 =?us-ascii?Q?1JPso+NsaCldZMME9054OnHMCfW2teeRBo4jbr5J+/FOJsoqkJn7IleQqinc?=
 =?us-ascii?Q?5S5UUlwB0qIEwWfZYSZdN6Cfuquvg79R7n0popXAJGoxDo1Yplrqs+uu83Gi?=
 =?us-ascii?Q?4Kg3tEs/zkPTHbA1lgZDxHVpE/0SteMC6taVesaaGOurdpEPIIIbdXPpVxXL?=
 =?us-ascii?Q?cBdAKzFnAaQp4L/zwlX5+xJBto80YAtY0YtL54H3wBc3N3irpoT/B5udyaXc?=
 =?us-ascii?Q?y8RIZk1KryAPnOwa4+LkTaOjF/wuclg7rVqczebhacwt8jD8MLzJvBPq2NN5?=
 =?us-ascii?Q?91GU7j6jGu3eScmk3MtgoQFYKaMnQDxfJ8byOMFRd1XmFQr9F46wlSR/xnL2?=
 =?us-ascii?Q?gspq1KNrS7aDZIdqAE8g0lzApps2oKtIWDIujm5ftt3xLA1YADE9kBKTXUfc?=
 =?us-ascii?Q?JTP1JkcSwNrhy9AwGjW/STKB2fIETpCko9gGiwC1o5vU1izQl2G565RKOvHV?=
 =?us-ascii?Q?0EAhVRs+EbgrvdTjgQhOwKACoOnoIGQ3jnf3LbpGmqnaV4cHmnCYPrFh8Ysp?=
 =?us-ascii?Q?6aBogDkIH2aBHX8DLoBSHUMwK7q3eOd/EVyo24Y3ELrCFJeSDjOWzvGxMz7Y?=
 =?us-ascii?Q?yjhkpvMFSU+dGxjMhbZmO+/n1X0fhNL4q1+wbR23ioB0uJul8IyjjBUYDTX2?=
 =?us-ascii?Q?4Dec+SKwT3zPGhPxeHGPSyj6ai+1+7e+b8ZfgEhrrc/8/OLrzKcsq6kT7MKS?=
 =?us-ascii?Q?cqIKuUfeJiY59kZRJFYsjwc8gIulrU1Hd/ixry1pQsTdF8meIkULWFf/AmZ9?=
 =?us-ascii?Q?N71DROjt3qNywRsHKgtvtKNRtDFRK1z01xEyc9/5aSsUyojL/K4DN6jnnqMO?=
 =?us-ascii?Q?m6fbmrNyZxjGMscij4uiofmgjmS0jphFDVdfKNnTrVup5m48E0NvOQ+r0imL?=
 =?us-ascii?Q?5velGzGNrdZTzSzRs0/oyr9JpRf5nRac?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wYFucClYphnmQ9CldSLrKDhe2WoIVL4tbRtcI1io4o/y8FF3FKX1sC8rrWIm?=
 =?us-ascii?Q?MIOhuy0M+FjlRjn4DCd0pxQKHXEbKv+MmkOpp3EEncqRBcVGpj7dSINiT4yA?=
 =?us-ascii?Q?UuKq4pvS2G16lra4WxLJCPGz5qb9/f/Mj5NTDquDDENOHoOlUJ7y6QlACCq4?=
 =?us-ascii?Q?iC/1tuhKG7PxN5EMMCPIHM+ivZcJ5X3ye8O5BFowx6cUm/+e1j7BVoVz4TFf?=
 =?us-ascii?Q?TXdCOQ9xvWNw2DpqVA7yfclmG4dPS2bGLTff/fhvUtmpSWSudjydISpQa2S6?=
 =?us-ascii?Q?tumvGqUMCOLFnUMC2Cz8J8X1p84IWLu/Keji2UrM/yg5VGYD96M9bOmOkik9?=
 =?us-ascii?Q?HNC+z5l2RI2vKWvP8dJmTheYGUhtJeeRLdhII2bnIGn2v/iLvbuQVoGTLI9j?=
 =?us-ascii?Q?l7zVg1rodY/Plx6qilpS7VRnmpS6F4v8fgZaJczM0CK0AbTZejyasiZwhZYn?=
 =?us-ascii?Q?kR6/Qlr4J1VPx2ZDBkyyVIpx4yWACJFhMA173df7IhvdisASeQF508bnvNpp?=
 =?us-ascii?Q?Z24wsSO89vxAc7JlXhxslLyntpp/p3tInVJzlICXl/iZ7hil/j3pYKjMsTYa?=
 =?us-ascii?Q?0pJEgriGS1/08p8zvMkd7dSYs/+nNIhBinwTVe3HyKlWzgca1MwMIhkjtBWh?=
 =?us-ascii?Q?Uni/RarBXuXBMWnnADwVJlh+cNa73NJdQ/3M1dmtVBo2sxaiBfdSymIWKkwU?=
 =?us-ascii?Q?OwQj/7hcP/jpXicn4rE4oMDu0yvTy5b3GLXWRTcLa82DHCWuYkM038JDepRr?=
 =?us-ascii?Q?D8whdxu+7OdXdORqVrAq8DQfhJR2oi+KHXN4rgYuZwfIfqLDDCMex/P9yda6?=
 =?us-ascii?Q?FryV7s4I7X9D0FftExxaTcDo2vzI1kBsWs0G7c3qNmrfV5o2wa5wGLegl9lN?=
 =?us-ascii?Q?VBbUFOwavr4gMj7ZNR0mRrokcqD7UlNMaKJhoXLX7Beojqptnf/aj4oy3sfi?=
 =?us-ascii?Q?4B7G1bzW+JqB4rM8fr1xQWBflroaN12WvhBJSnQcei2z1iY4IUDCOD4QU4s3?=
 =?us-ascii?Q?uriWxS0GVCUVHQAwOaQvoGtvXdlE8FZcJjBtmnNkZdz6+UiGx7kUYFbhaG7h?=
 =?us-ascii?Q?E4/d7qLzhF9I9s1ROhQO6x4hORBHM+khe8JNiEXMgQXab/VdVtl5aU6l7ED3?=
 =?us-ascii?Q?rOaKo6u9qpPhR3YBFcveqJ53O9yZ8Xw/DMmZchJ6XTYYop5O8KZqa+KVWkn4?=
 =?us-ascii?Q?NtaeUoiZkqboIiVxagqgZ7gRGCEr7L8XDV6mbQWHnpwBeir6H1hOzJijqip4?=
 =?us-ascii?Q?yeMNgIe6Jk3yBP4L8G/Vk4GGiMa/H5iKdVBeHo2ucuRwvHoE7Ir3M6+Dmry3?=
 =?us-ascii?Q?v7c49AWO8NOdf//QjhRk4Mn9VGItpEwiqI+gIEoLb5DdEKSZiNmX8RAKNT20?=
 =?us-ascii?Q?mN5iOMfN74iCPEtR/vb1kSQ6odGUaQR3IlR0Kbou/D/h+lZgl6WXM+LzgRbu?=
 =?us-ascii?Q?vkqZIHi9P3Bh9kaRUsVCsSrsO+vXjjJ2X7lM9xp0ElcqkS01PJcQQae2N0ps?=
 =?us-ascii?Q?QFyVjmSM65BQlKfDt1v8R4SXB21d/SElR6qB1z7YJVQ7RMC7rUeISpkgHYbp?=
 =?us-ascii?Q?xOJxfU4GIYj5tvtnVxsV9HiXsotNco/0MuIUueiPj723ESZVwrR3sHtrZpR/?=
 =?us-ascii?Q?jVTD5rFFiWlGNrtrwh3yKCc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f6b51a-e873-419f-89f9-08dd6158dac1
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:21.5403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw81x+yNPDV1B67qebrKAZvPjsllrX1RaS1sTxdq8lvFML/RqEZ+I0R6s/pIRvIEI05kzWHBJWf3KxAKHwmvnd4leS+5MScyan9TDIFtlXHPH/ZWey4s1nVKbf8xdyw9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18169

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 9e269561b363038d573a69755c9eeabc9258837f upstream.

Add device node for SCIF pincontrol.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/20241216195325.164212-8-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
index d4d61bd03969..c063d47e2952 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -7,6 +7,7 @@
=20
 /dts-v1/;
=20
+#include <dt-bindings/pinctrl/renesas,r9a09g047-pinctrl.h>
 #include "r9a09g047e57.dtsi"
 #include "rzg3e-smarc-som.dtsi"
 #include "renesas-smarc2.dtsi"
@@ -16,3 +17,15 @@ / {
 	compatible =3D "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
 		     "renesas,r9a09g047e57", "renesas,r9a09g047";
 };
+
+&pinctrl {
+	scif_pins: scif {
+		pins =3D "SCIF_TXD", "SCIF_RXD";
+		renesas,output-impedance =3D <1>;
+	};
+};
+
+&scif0 {
+	pinctrl-0 =3D <&scif_pins>;
+	pinctrl-names =3D "default";
+};
--=20
2.43.0


