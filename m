Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE2CC35FFB
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:32:55 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.web10.34445.1741778677223540270
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:24:37 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=cDFgNtx3;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttPDrxCE3dOcBX0q9ndXyEZpyLGdTkgWS1fwOajenzcoVT6O0xfQYdQEAFRk7J3mQVw20YCzf4ZrnyVCo2wArSWINCG+iGdXUI5GeHp+zxNim9bjxUJRnPEKKyUy/599MgHOAJ6/x+FEdhgJQuXnAQa2LkSrtsFkuTlpsHyJcFgEfSeuzjAHXSdzeJJuAbmjGT81b82vC91ZBPmfZ5V6mh6cQqM1gbeDtCZJwiNzZERgZFh8/USZ+3JI8xsBQOgEOyZolqyNXnxpNbpyhJU0V6AluHBQoHuhu5lh6L/lv1NR3JRo43H7kzk8HzWWkczmqSnOM1fBGG/IC/7VEVLslg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO40OLzVklrU8I9im+FRLq0X6RrQ3p4FV0oXn/ismY8=;
 b=DHxW/jOfmFCGntCuZv+DH+ifseZsOTMEiUSuTySU9OWeCqC0mtpKQ783GSW1ikrcF2yd7KYi3mRbAmP9Mgvy1CgRp8KycJPtrf42I/RqG4iSheYSWwc8LI/FwuLID0KfIqy4/zsUfs5qL6JEsgXGPayERs5ba5zMRp1FYm4CxagV9DSWaw4aT4rcEGRlBgCUtk8GsWu4jncah9S4tMdMvhEXtML/1R2UIhNBtoXVZ5QzQFdbuo+Cd6/J/sDUQPJishkuDtz2xxE+Efh0D0KyWYBPj0HuN5Rx0NdDO/koT+hE+lqcIhKi9WBTVjJma74YeV/4cmR4l7d2odmFjRhJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO40OLzVklrU8I9im+FRLq0X6RrQ3p4FV0oXn/ismY8=;
 b=cDFgNtx3RRPmVmmnOYDx+XR7MTtYAz7A0MgLMubbLE9WfiaqGOgcTcHvP2LpucNI3GIwqIRb6UqArFIyqqo9Z0odXtresRF0Oy2vLFOAs7X0OaMGkRq+r1TZWhCO+iRMlSByvez+ZsPwSUAMijPdDxK/XTkDxNqtgwQj+fWSuuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSZPR01MB8767.jpnprd01.prod.outlook.com (2603:1096:604:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:24:35 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:24:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 20/85] arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK board
Date: Wed, 12 Mar 2025 12:21:57 +0100
Message-ID: <20250312112302.1605750-21-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSZPR01MB8767:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6fc616-0b4e-423b-df05-08dd615877a1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?NEL7SwvbfIxtFg4c8JTxbxGBp2p3QnaALyH/dJQ9VUYRyLhFQwYTwGI0RTOi?=
 =?us-ascii?Q?Pb+v5xQcniu4K4ABOGjZz14ypojysDCwdJcp3mu5O9UxX5oblClrp54+QPKD?=
 =?us-ascii?Q?/SlM6Ds6th8cSYVI4AVY8XIreW8OsByQevcn2biCYbTHC42HLorsf7Ul5/mw?=
 =?us-ascii?Q?b/KSw4zWALiAhOl+x2//C9XXdJqUgWvYosTKSoIdgEVkzwaNwzfMyWu0tFhV?=
 =?us-ascii?Q?oh7bKlgJNwhcXKJG9FJTZztYKVoFAk6WWLze8UKCMwwvpt0GTjmVfl3iKHZo?=
 =?us-ascii?Q?DCmz27pNiytHOrg7PC3f8DX+FCx2oyQkRk1c+F8KnqIgWQpKH+idnYQaSyZN?=
 =?us-ascii?Q?Hx933M2NCVzxCpdPlz4wH9RbkywahRWFBS8qg8J8sATjHwVfPqi+EJYnE96f?=
 =?us-ascii?Q?aRQKEzZ9Aq/B3XtYAOFZcteS/ait1go8aKyknFxKC6useYVDfRH5abYLe51F?=
 =?us-ascii?Q?r3/lPCTn6zF+ASrGZCB2FOWRhHaDBwHhbomNN0tRe4K2n5b0r59lyNFRHx6e?=
 =?us-ascii?Q?AubGxmZQVZDjsfXIUiBQOZBDw9Jp+I68WLxJBOSCWYL9yjcVQfnsVv5Qc8bm?=
 =?us-ascii?Q?s6RDiFGJrky3qGEXQU4pfgRlsiV9rUsxvFsecvfBGoExOhmwyBVwICrOE+QG?=
 =?us-ascii?Q?RdKKr1CbvvXGBmflITLEb7y4l8Qz5kZC5aA7X4BsGB9+5dulH/UIHfH0IYt8?=
 =?us-ascii?Q?W0TZ8AVyjy+g6EWFK3XviFPj/UWJtxrwllxnbO6XWr2ux4sTVDaJ8FforbWj?=
 =?us-ascii?Q?P2prx4IqHylvpECTD/M5MECpnHpmAKGxNu71HJMiNVNpW/IcGKKYW4VR5ren?=
 =?us-ascii?Q?Wacdnv2xPTayRMVsZ0ijvi4c3Vj89GreRgNnXncY4JXIOKawvSzuuBqlI90F?=
 =?us-ascii?Q?iKhcRrbcud8aPOjMGsd6SyxRXVVI0mV7PKx2btgwo+vZAir7oFuse/wPFo29?=
 =?us-ascii?Q?BOnYInuk7zuIDPar9yzlhiIsBmVer8dquu1jn4H5ud2wgcvifKR4UkHs0gad?=
 =?us-ascii?Q?irhQkfn0eBJSeWEHC9+hvSSVt1f4dOcsNhbLwj8eyufLAurZYXLY9Ap72aLj?=
 =?us-ascii?Q?sQk264TKSX6LiiYKU5B56yeAc0CVpG7+bglQuRlWZCGipJbsHJvrW6EihiRa?=
 =?us-ascii?Q?/5zeZVCgNqamqW0P5xZuM4NNZPRIwWEBpGPdWdnXLlX27vrRSBBaxhyuD6vR?=
 =?us-ascii?Q?/inFFLiYgaJDgiyPv5bFMp4Yuge7Jn9NVjm+TzoGrxQ8aw2nVw7CL4TbVCOo?=
 =?us-ascii?Q?tlTKshLskjhjJinz4B83W6nreNcvzhCjYdVIkpVLIU10UJ909OuI5BNE95Vc?=
 =?us-ascii?Q?KsQlPPKObQC1hfJTT7Nu+OfYJu48VyZXrus880Ze8f1Ia5RAICK7NfhhyYg4?=
 =?us-ascii?Q?jU9ZShzppu/Erhe5hVTOEb0kiZHJHnBIcMLSOeRjosDcf0RMUfAfxj9dyUaR?=
 =?us-ascii?Q?epqOtxUeJ9lpHoLwfgIAeVdwf+phfeDC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?u2EI9jHu+3IkIpPGryDBwQw/5xGUhBz3d3EBJCT8T0fNXncInKexoZhYTIZk?=
 =?us-ascii?Q?m9gl0u401rnDmLo6/Q+PuaBmCxxEt2LkpYIpSXQ8et+L1ScH2IUEl9CKhrzX?=
 =?us-ascii?Q?h1/vlJA4YoyRQxrWwswnvcIdU4GiIhKlp/ZJZwuLXHjEWlAcaW4UEsniyMMO?=
 =?us-ascii?Q?ii20f/40JtNIhrk+ADWceca4sjnjb+rVFIDKjvRC4HVkka6CRs9cT+LQXUGR?=
 =?us-ascii?Q?h44b2kgxZ1LnXaU+WU/50Bk6oSC2JdEhfgaY1VG65mG9syYghCJTAxfMraS7?=
 =?us-ascii?Q?CFAtwTVETN7a9hckTsOi2waXNwuxjNdb2ghklEaJoo8kg/U967mIDg8PaB8y?=
 =?us-ascii?Q?FPa1BXy3hVV72BokVD/pR2iEMngIRmUslmqLoKDS2x2p4KeDgnYAgQk4j7mY?=
 =?us-ascii?Q?n72QmdxaVD49LLAVF7MW1YzeJK9DNEEbQNBo4jg1KA5Kd6RrQEgVFWA5JFf/?=
 =?us-ascii?Q?VCDknYpft96MLYfKBWWonNZiEe9wr8yxbEnH+vvqSZi2757mxTYiSTPLu0qY?=
 =?us-ascii?Q?A7hQt8pesawNw6zdk81Fucf0i4Z+aQ9H4PDGlS+cpqGK187aetP1AJgPYx93?=
 =?us-ascii?Q?ySdHeoHUvNZMxcMdnsmQZWX4UZKHpa1VcIjMubIW1TFpVGjsKoAnApalRCwn?=
 =?us-ascii?Q?4bEXtYo6+yg8Xo9W1zcSc5jVqPbI0B2wQp3BHMf+TfvMxIzN8PNPTR/s5STx?=
 =?us-ascii?Q?eHKkGxbLx2pXcVdFJFBn9a17fPP7TlEhYQ2mukZpULsuSCBe+cnSPyKZH0Ux?=
 =?us-ascii?Q?f0cp5/NOkncSsABJ/4qLc9mGDA7wkQypUOL2IXZCbT9/A7d8W9fADEtTN3U2?=
 =?us-ascii?Q?//3tE1FZWRX4kr9EcldiWH/2uWkjChV0fu1RZp5XBklbnt3lmfQkYATd/8B/?=
 =?us-ascii?Q?g6RjNL0GDCPtpbam8Fbr7UNcqca+8dHIocDlzNp+BNKnEGPOVIJT6q7f6OTx?=
 =?us-ascii?Q?o8HKvqXtdifR5oCI/9oqJKYxd/AFdEt67r56owIUpfFXK2lpsMRyJMwS4uM/?=
 =?us-ascii?Q?+4NAl60I2tWpeLohXicCEZ3TdxDY9yKDEr72mJclj/V/xFQO/S4GZlcQrk/C?=
 =?us-ascii?Q?WwGMsHRTo7rMjzjCkkQ3l/ZZ7UPeSpBkxIYbi4KxhNP98ra22cBHGBzHNkCo?=
 =?us-ascii?Q?qYdRR6Ez2VeGHr9u+34/Ji2DC40iQOFs/HnWQGjor38KHvB546wDuLV7823T?=
 =?us-ascii?Q?x/AIsT6FcSXPy6xGDYb0CxDgkeNxqUpaZdoYScrHnL0l/GYEe3zVZA96WyPi?=
 =?us-ascii?Q?hKNSASX7ZhvqjKCXPIHy1NfsMpyQj2svi83o7Gm6B/IseOna3oG5cZhl/LU/?=
 =?us-ascii?Q?a+0sSG1YSc5/I9b3txB28Cwtb0yxktyYgkUTkfjFbiTu1JXgatzfzwu3KQRt?=
 =?us-ascii?Q?LW/IjJrM5ATHtsa23Hzhbf/mbgfWHJH7jRl4s+KG37LFrj9OqEZ+/wCVwwBq?=
 =?us-ascii?Q?fvlaBb+qR5FWZ0/xAugSeLd8y08QLVh+uU+hnJLiD3ViwYcY2C50fy5dvu6T?=
 =?us-ascii?Q?C0KMvMRqdC8AxcMRmUDoPKPPcnPxaNqZ49MpA9/79CnurMddvh8v8VKGWU6l?=
 =?us-ascii?Q?6M03OsRnFNkacw6vyFkJ+bTj9zAErkabuEpzD2HLm4hXI3x6h4qKQVNtyo+c?=
 =?us-ascii?Q?WyNKsn6PzisfaMJRe2g7MvQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6fc616-0b4e-423b-df05-08dd615877a1
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:35.2243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbhuBKgoTjTXVJNAhhoqf8W3fhj+YbKsG83HBzV0gNVhkja3zd4UkHft5EKfCgJRoY900rBIqXVI4v3RbkcG23g1tTUNkQpVz2BV9zlPKGnv+QTWqXgxmGe4i+Db78vy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8767
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:32:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18112

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c4d87fe3cd4eab905f235ecfdd09313be9bc0e99 upstream.

Add the initial device tree for the Renesas RZ/G3E SMARC EVK board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-13-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 ++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 18 ++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 24 +++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/ren=
esas/Makefile
index 7b0f06600f20..48f1924ed388 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -89,5 +89,7 @@ dtb-$(CONFIG_ARCH_R9A08G045) +=3D r9a08g045s33-smarc.dtb
=20
 dtb-$(CONFIG_ARCH_R9A09G011) +=3D r9a09g011-v2mevk2.dtb
=20
+dtb-$(CONFIG_ARCH_R9A09G047) +=3D r9a09g047e57-smarc.dtb
+
 dtb-$(CONFIG_ARCH_RCAR_GEN3) +=3D draak-ebisu-panel-aa104xd12.dtbo
 dtb-$(CONFIG_ARCH_RCAR_GEN3) +=3D salvator-panel-aa104xd12.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
new file mode 100644
index 000000000000..d4d61bd03969
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -0,0 +1,18 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ/G3E SMARC EVK board
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+
+#include "r9a09g047e57.dtsi"
+#include "rzg3e-smarc-som.dtsi"
+#include "renesas-smarc2.dtsi"
+
+/ {
+	model =3D "Renesas SMARC EVK version 2 based on r9a09g047e57";
+	compatible =3D "renesas,smarc2-evk", "renesas,rzg3e-smarcm",
+		     "renesas,r9a09g047e57", "renesas,r9a09g047";
+};
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/b=
oot/dts/renesas/renesas-smarc2.dtsi
new file mode 100644
index 000000000000..e378d55e6e9b
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for the RZ SMARC Carrier-II Board.
+ *
+ * Copyright (C) 2024 Renesas Electronics Corp.
+ */
+
+/ {
+	model =3D "Renesas RZ SMARC Carrier-II Board";
+	compatible =3D "renesas,smarc2-evk";
+
+	chosen {
+		bootargs =3D "ignore_loglevel";
+		stdout-path =3D "serial3:115200n8";
+	};
+
+	aliases {
+		serial3 =3D &scif0;
+	};
+};
+
+&scif0 {
+	status =3D "okay";
+};
--=20
2.43.0


