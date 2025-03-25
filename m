Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0058C3600B
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:12 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.43])
 by mx.groups.io with SMTP id smtpd.web10.67884.1742914631188034508
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=r7SbXXkG;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.43, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqM0rHipJICq6eQF5UQe1LRuBfBv/+X8lCtdL0lPpKKmyWd7vqbGYyrgGEOoS9xbuokHB9vqQxzsLxD5AMiFbGQVd83Vw+aJrD8Fl7tNrzkOPNat4eHMlCbmOUhYgIAyBAGO87gin0+7KAwVCFMh260Lb4L46KL7qp19riJbffHkKKKmlfC/jAXdb4v8if5mVwcERgmZEVYTyaaN0DGA3ghc5ftr9aD3pEum/0AB9QdzS/m8ciWodvhmGqe3/ZrzHur78pKkpWS06gup6tdqnl99dWyhsnC6+KhLGABaLKxNEdqnYqCpo6JBML3xJySbc3YcNgAOjRZKnZPmHVFrvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2xbGq7ZVT1TACJnD4pVWrRfXl1uRzKeTmkxpkbdN+o=;
 b=HQnM2KyQuBNkPhJyvF829EkwJYogTYjYuSrg9EygfAb1xtBdnIxv0cwMi3e7Dg2ofiqqnv0RB7DkzfossfPs+rMRLCChe3WBlgqV9M417KwBERaoqadTTX7eW0ge2+nB8XKkMiW0XSxjBVcf90EKd3noH5XmjiwPuZcSvwcxtsXwb6cY7w+dEzk7FfZcw7uwe3GoUvoeg7G32qpkaFHrXxNb/Pw6rY++j7Iv1jglOL+5WDx19+eYY5H6kQrP0nct7bzyjl+CcLx2e6KpGJSrYYDdEyxX4+vNdch9JHGcZlNXwPe0sg5On+sK1YmKTQhYt2KYBbrSaYk+CYAFFRb4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2xbGq7ZVT1TACJnD4pVWrRfXl1uRzKeTmkxpkbdN+o=;
 b=r7SbXXkGh+IR0Fn+Ec/V2rcguDyXDZPVrnTpp3bk9peT8071A0kbsLDdkWiE3Mrkv8kGzIbv9y6TUzIvoWvgsryHOCRnzSx5lNDuUCJdH2jFUcuxOmQ5bQWNurQBcNN4SU2qOYQwbB/QMnQnFchax4sdEIjTEowb8Sa1SXUtoRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:57:11 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:57:10 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 13/16] arm64: dts: renesas: Add initial support for RZ/G3E SMARC SoM
Date: Tue, 25 Mar 2025 15:56:07 +0100
Message-ID: <20250325145611.3595454-14-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250325145611.3595454-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYRPR01MB13248:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b52e891-d677-490e-18bd-08dd6bad5227
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lAzBjCaYtmZWHcJTGgehCehVuihDapKhVL4cJZqES7nDs4SBTtkzQrFd14sW?=
 =?us-ascii?Q?w1NLB6aLx19XFbiLXWwd07h5EozQd+h0mNJq0mfZkmOWe5QPis2Q5WXoRPa8?=
 =?us-ascii?Q?F+k4wgnyePZ3NvyRufxGyvRXs0fL32bdFVqQVrqM//Ziq670rF+L6mRdDEta?=
 =?us-ascii?Q?Tb78CShYUIedj8D8oTPra9ezvBmyDsMMoB6e34UQNdl++sD8XR6mZxmdC2aR?=
 =?us-ascii?Q?K+HJaN4a2Rz7Fbi2tXoc9I4RWVrDO1VMf9bGng86VhdkAQcXTteEfZknHM8t?=
 =?us-ascii?Q?7WPGzAk9U/ThhypkWQz4TMzPzH6fWDUSdr2U0s7MiDEIyEY43bU5ECQTRU2I?=
 =?us-ascii?Q?e3cXP5zHbYXR23Ici/UOS2H+HJum4soNruZfn77qKPmjiluV2F2j7XhWJUJc?=
 =?us-ascii?Q?AVKlHKnXIztm5Uk5BjEh1Wv8U/NCGTdhHI36/JEQd8basDq3qvLW7sA+e5gR?=
 =?us-ascii?Q?3h3rIuwtbCgTsia5ZfTEfthQs8Nwcgz09OOLsJkvmOxaan/qiUb6iXYKEABc?=
 =?us-ascii?Q?h1ZK9HmU+XE6J/l5fClW2YEA0g41ss43CtS2u1Fqa8ZQ2Gif+17IRdr6G6EN?=
 =?us-ascii?Q?IjOqnCVPs3QEfPQ+7n3dF8oO3ifOd4z00Y/RuQu6XweMnt9oHcXN0k/bB97R?=
 =?us-ascii?Q?0ALPNFoSq2GQxCZ9Imuxg+BVSDZgK8RIq9GE0yJucTsardFM3goJE40mWQ7s?=
 =?us-ascii?Q?hCilM3peNLYHs2P6NRyiJZF+3b/3xsls4nHyvQdED4KKz6wRjwartfDv1yMF?=
 =?us-ascii?Q?TaKEnGPFL2pmGrID5l8BHPe71INKrYl2LzGW3VaR78AXua5jVFEqUv5TJe2/?=
 =?us-ascii?Q?r1AU18mwXkR/BlClTKIrLkIwqT0Rd69mBwD9yqVwRGh/X/hOMRZsjlgZjxtW?=
 =?us-ascii?Q?/il5aHoykAqYVcuukHUKfyKhCw2Jr7EIDvFGO7As8DIa6lWv1xocy0dG8LsU?=
 =?us-ascii?Q?+nEIiM8rqzXSyP6SH0ZBJr5vecwkW73SW5rV+fWY9jPyVifp63fwN4sFkTJr?=
 =?us-ascii?Q?n0ltQCjyYnyTotrLyXRH1gwfQnm7pt4C/XoZlFEfz75xWyHNLce8NRWUjrzM?=
 =?us-ascii?Q?e9lQfedLAOKQxVjs4Q12yp6Ie3eyzlVpWWD+VtVxlZYY0S64lxejElKnGygl?=
 =?us-ascii?Q?zLOnkcj2S7TOcueeiz4LiaXJ8SGwdXhNsYivGxKqAgn6h6SLNejTm2OeXthx?=
 =?us-ascii?Q?GtuIWNGJCfyp8Y6WLyVT1jMkFnaedZHcIq9O3sviXZCgmLur9Gl0GECAZGz4?=
 =?us-ascii?Q?VwqHOwOHgoP34t6jmeSCtTJ3avz80VL+xDV+ZUIqqK+lpFK/hz3+xHUOvprW?=
 =?us-ascii?Q?pODhtukLnITIg558teFxkwpVQZKpADpNeRWmyeSUuayLij49BqyR+veli8Fi?=
 =?us-ascii?Q?QpWEVtQyTg+UB3bMS7WUdLVwlLtd/GKdkeqZyG/7cie+JH/TUQ81kTX31xrY?=
 =?us-ascii?Q?1tXUGbzE7VyH3PKltlWL5oMBZ5DNf4Tf?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nRSi67HIcRIbsW/3+y8W36VeEWcw6k9HxzIY+PYddsQLd0l47xVz0dgJuFlB?=
 =?us-ascii?Q?dyI+CXuDkFNyCT046dRzuoJ+kJj/fN5pcRl+oA9aAKuIbSQobNAHOqToEzSU?=
 =?us-ascii?Q?mr9aDJcHudXTzEi2N7uMOhdiA3CTlvXQAEQO3WSZeR08wNytYostvEhvl/Kp?=
 =?us-ascii?Q?w9mEy5SssQTbu7T/00/NSNIW0KoufYpRTrtlDLDf75pKyCZMffG1qZQaS4m2?=
 =?us-ascii?Q?S7R+VxDOXf3qXThxByKDzCJqjY6VlttNuyRzB1QGV+hjLdiU3EZjX2Rd5u6z?=
 =?us-ascii?Q?ZX1ojZOLXeOlbANJDEQQ9GrKgjcNt3zsRI+IMO2A0OUGIo9dNjkdwW7tw1hJ?=
 =?us-ascii?Q?VmQB3SXwnzIOGysMenb7tbfOl50edLO/Mq6blUqieERK/zz9oWFy6bRnvGRi?=
 =?us-ascii?Q?pGuLCOuiYP0DXF6+9qyFaeiDS+ocaa7b2HoL/COQ/mYq2FMWKkftIE9ZcsZQ?=
 =?us-ascii?Q?RTmlLFBrr/D5qlHvhTmuUI0zKO5nN3FPCsN3xgGD5pnf2gZHAyumWUDkWQNS?=
 =?us-ascii?Q?T6//flXYZ9/cS4XkNQjpe03ECHE86+i1oVAfn5ANahXnxmqUaIy2mD46f58u?=
 =?us-ascii?Q?HwXXU6CeONvxNfjqbvzmwZqWiETO5hJwZOSOXmG74uwMQn2Y8QQugZ08dxzH?=
 =?us-ascii?Q?oEUVzI8Rf9cvDia8C0b8SxKSN7sjtEKEpBsUIlZz7xh7nF/o5z6PqBjAch/t?=
 =?us-ascii?Q?QQhUN/Bnuycu6m39AtmdnIcKUpsgCEzAeYG3rJGxhYKIIDATD+/pQgLvEVRU?=
 =?us-ascii?Q?lw3V39hQx3qXwh7Z+iLlRYbbJ/dmleYzJJ4UdE/Dr0o2Ys/G66I5l1vdv9pZ?=
 =?us-ascii?Q?bs2ExMlqnuN39QVrUFUb3AqWcURrcDtbo/go5iE7bobngsh0gEbmOf0opXl5?=
 =?us-ascii?Q?EN3IiPYQpp/7gqs2VqHg3cHAuqCv7dUD1DB2zT2wOJ6JWpOPaSfSMx28ufRh?=
 =?us-ascii?Q?Ifze5Qc2l+ICvzecPBqFi9a2W5ALj6qk2c0Li5+oCnhIXlcT/FxGoIkiKM/w?=
 =?us-ascii?Q?4MWU5WHT06QAUejMM5O5sMBtg1hnqxq/WtBK77qy+CQs+WNSzfKYyGicF3Vs?=
 =?us-ascii?Q?iuLMjO6L7uuKTSwFqoov/TqidmCLlcPL6OXSSZ4vbap3yyp/NCIW2BAujEsH?=
 =?us-ascii?Q?bJ7ChsqLHSJuM6B4BwooeU7yXnp6EtC8WdJ126IOdw5iuqBpmZ117w5Ep6oM?=
 =?us-ascii?Q?wyuk16huG3BCrTN8lf3EFu8ybCWnFMbDDrNKaW3FlITtuEePmzmbSUyV9eJP?=
 =?us-ascii?Q?X0mgjndSwyK7L+/PN3oiawLQasgFf4NPP/1/nR3RkAuKehSuDh4hzxBvr1G7?=
 =?us-ascii?Q?4DqOUP01lrXGZwHkSELNm5K77WSDwt+IvTCkRXXTqT8O/xQPvyb62Gnwdz51?=
 =?us-ascii?Q?ZnXcrlMSzoNIv+jD+FC11K1dxVC3jaSTUrEq2ip3jOaCnsaJMBpvBgsij9/Z?=
 =?us-ascii?Q?nwUDoSIJ4613PXQWwECQoQXhO3KRGFWteBhFKfWwrING12o1RZjVHD4vz3W0?=
 =?us-ascii?Q?rse2T1feN0qZmasXzn5vyZFMz/JgtPwlzaEltJg7rOJ+KgmB1BfjbYkZeG8E?=
 =?us-ascii?Q?X9s5Ff4yBFg6yEJk/xLktJiOv8q0oBsBFkqNwaNVXqq/qh/sThOf2c/VrXZl?=
 =?us-ascii?Q?/EW7iBafOOn/SzOcaHaMUKY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b52e891-d677-490e-18bd-08dd6bad5227
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:57:10.9233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/91VR0Xltj2uweR1FQEM668jAMJPonoGQqQuJfCng3UA6bG84CnwZdG0EiiccaYI1RN1oKS/z59R0eG0G+mE8/WwGeswP71cXpzrnPum8ZXzFNO4AvKH0LQXOcGZScO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18363

From: Biju Das <biju.das.jz@bp.renesas.com>

commit e0379695728b0d79c20bc1a904bb4168d4f117c0 upstream.

Add initial support for the RZ/G3E SMARC SoM with 4GB memory,
audio_extal, qextal and rtxin clks.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-12-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3e-smarc-som.dtsi     | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
new file mode 100644
index 0000000000000..6b583ae2ac529
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the R9A09G047E57 SMARC SoM board.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/ {
+	compatible =3D "renesas,rzg3e-smarcm", "renesas,r9a09g047e57", "renesas,r=
9a09g047";
+
+	memory@48000000 {
+		device_type =3D "memory";
+		/* First 128MB is reserved for secure area. */
+		reg =3D <0x0 0x48000000 0x0 0xf8000000>;
+	};
+};
+
+&audio_extal_clk {
+	clock-frequency =3D <48000000>;
+};
+
+&qextal_clk {
+	clock-frequency =3D <24000000>;
+};
+
+&rtxin_clk {
+	clock-frequency =3D <32768>;
+};
--=20
2.43.0


