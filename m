Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5EB6C3600B
	for <webhook@archiver.kernel.org>; Tue, 25 Mar 2025 14:57:22 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.29])
 by mx.groups.io with SMTP id smtpd.web11.67735.1742914635923099826
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Mar 2025 07:57:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IlLC2fSs;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxcIM2K+yPoZLzIH7hx++ZvZ/APUA+idFS4uDjUmQy3vST3v9UDjY38Gt69R8ocvxY1hb6uArjwJMUkeGTePMJ4kc5u7fbvzuDfTR3L1twKc3BKpafhJl169PADtaQ9j/WiVJnrFzxlGknrbxHW/HACUya03a5YsJkcCAJ65rprtYevjPXFAsGFxMFVlduSJQ59mkkFgnr1ucpZ3pu1My46M6cPU9VuOa6+FesEownkO81PaGqKEv93kqZjHuV2VEEol+wM6a49clFKbfRqmzVV5cl1mfp+WuSuFUzH3g4LAdDuOeu6KlZr4lwkZuk265siKKiFjWTQpTtqeWAJ8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+jIYTqKxgFD785na9W59soXADMjE1XjWiwI9cfxxos=;
 b=Igu5dszu+p6ER0bqBoOS4vwFtI9pcv1dFLOV0ldgYY3S9YJCGpMYRTvLHk0CvSR4+Li+3/r/f6GZH+2E59gbsQoSALcyCsvQ2I1vP+71tff8ukGC10CKUEaXk62tVeGtEhjyTT0nSoFN25i5COz3jxrtq4Lkb4NTDW6Ov5RUQrAuldAQ/wsvxWicJEpqxLYf5tes/IGnmyaPgl4raaS4LubsmeCKoTqFh0cAtj8JpyEtEX8S/qVKcQzEF4/BLWOv2Njdvoiy//n31IaiwsnBuz7u1wROC3ljrShseUC6T1fVM8etiY+cHP7iU6zqtJjF7+4MJgF++rwgaxo7eWB9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+jIYTqKxgFD785na9W59soXADMjE1XjWiwI9cfxxos=;
 b=IlLC2fSscxn98SbBpsz1jbEKg6+l2qDj1Dm0AUv0Bm6MZiO/kpf9mTL5mtcuOwVswHf/DbkAf1SdIsnZCg6m4LPTbsDK4z8V5yq4f84eG4sK3f/tpZxxagk55pDP0qLugfogwKn7RlFYo61ekUxHQ8neaApbbhGSoqVuoOkE2qA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYRPR01MB13248.jpnprd01.prod.outlook.com (2603:1096:405:117::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.43; Tue, 25 Mar
 2025 14:57:13 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.040; Tue, 25 Mar 2025
 14:57:13 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 14/16] arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK board
Date: Tue, 25 Mar 2025 15:56:08 +0100
Message-ID: <20250325145611.3595454-15-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: efedf9b2-37f7-44ad-a377-08dd6bad53c8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+qUT9N8845IkbBAW4+8/vb4lvaunDgKONsFYFHmAFx89F9mHa713y+ag7L96?=
 =?us-ascii?Q?dHe6FEfjWT0opQhIRoO7HrROhJc1DOUrMAU2Q3tyNM32Q4wY34izEGIA+w6c?=
 =?us-ascii?Q?zIOIx7VQOEsygZfygjf0/fwKsYJwtzDj77dLVnE9MxS9wm49NuO6/3Qmo+Ie?=
 =?us-ascii?Q?ZY04rATDL5v4SxIYJRHdJ3x9YAS4aOtjydVaBJvp74PhiRKBC9JiISazr/Dl?=
 =?us-ascii?Q?TmuVuSICWP/MtpdNWSWYH4HW4HrCNctqulfGkxgkIElnQUFaIgVuVNjwcNB+?=
 =?us-ascii?Q?vMeeZljQk8b1PyFx+o+2sSyCkZg1IiUHzwEWvJS1yHCZzZgZEbOsrerg1Unn?=
 =?us-ascii?Q?nTAj7MdRgoA81/Q/ih9MBZEcyFlrXmyF+i5UkEzNoyuVxr8WZqgSPKbHZ22Q?=
 =?us-ascii?Q?67JMnpdm+CVXkP8ZS3qlsg9iflRJyh8tuL3ono3DoWAfj3mcFxQ6pmBKGolL?=
 =?us-ascii?Q?ojwCyVibqIx+jQ9PfkX0HqbFKfzRDEis03vSwuNMZnKlp+EXMi0/OBKI8qhy?=
 =?us-ascii?Q?xVO5s4KoCvn34+WetCR/ZyKDddiU2n4CDh7sQztENizFZX7brxW5RSd6kNUe?=
 =?us-ascii?Q?43OgCMe8wgHx9E0Mkn80CEgSy2oPzxq5DFX+zhjD4JUr6KyWWMjausOkZtqC?=
 =?us-ascii?Q?E42X8UUviG3mAVz29qM5Rexm3s6lX3TZYXi5c3daHPL9KvzpfeHNyMwM/z+r?=
 =?us-ascii?Q?LS3vRzrKyK6fyqFTKJnD00+4fRxlYOWZlUvQTn6ruo2OaRMIG8Dz6xyja4r6?=
 =?us-ascii?Q?VtV3LL5lZj8X105xBJrd/2AqUPnMmYOWLz9dU8Puuba0SQwsMX9eL8im/6T4?=
 =?us-ascii?Q?38EYAF4LiMVeg2hj5T6mjoSByGvLn/EcBxLeg06et4pwPpdrdSxm9C99crU/?=
 =?us-ascii?Q?4dLPKyJMapxiTuBOchlFC8MZzRf/BPtFmg92u4kpUz97cKfkXk7PihR221Kn?=
 =?us-ascii?Q?Zz1NbXLZMLTkLNFRj28GyRsY7afMc9SmqKVN9gjeRGZR2bOa5I7TwyCOrR4G?=
 =?us-ascii?Q?7piXvQk1xnFUD6MJ2qQ4qNPHQ8LS5TrTr9ZDO0UM5cCWHQCuEbCpwXM0oNI7?=
 =?us-ascii?Q?0Dch7ecoQyciWFMdL4kFD7RHS0gVFXuX5oJubGjLvlcqPePznyt9feByOWHT?=
 =?us-ascii?Q?GHwEXCYWOpio0F84vy/DqPVGYzFAhsHjmWBr8mZRX5zWV0eguxfAD5G4i4bc?=
 =?us-ascii?Q?Mk1k2ICuL9dtoJvv2LE2xpNFAbHancr7o6x6AjY2OMLAMe6pfs4yu0L/J2W+?=
 =?us-ascii?Q?rphIdIxxSsAMn9N7fmgoiG6ECIq7KIrOcVIpgvKbkUAwBYy/oUccie8Jnp+A?=
 =?us-ascii?Q?7vZ4pMuwEhejpxuXvtfHhgfseA9j6/FA4p6clcX/QsCtuy7NxR5hUSWuOHK4?=
 =?us-ascii?Q?SqFYB1hmzQ5WkXSgmLp6E1HMRtAwc0gDxDv6urha/9kVJfzDGHqljCt5Scie?=
 =?us-ascii?Q?kPzwnLEyerHYkTZfNpd1EU/799Gf6sY5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dsw8Qnut999tche80VkdS/M4RUAmg9TW4JFxs0Xfn0ZiUoCrAgXRvgk1WrIO?=
 =?us-ascii?Q?iTBngGPIknwtSh0q41go31sr9IjBEyHg38kEPxUM6cBHwftHnUtEoX4CcWIi?=
 =?us-ascii?Q?EVtTw0if4YY9ePlu7bgcf+ingBkLjzHih1WfZiJXrrzr6iLHvR2hBpydLjme?=
 =?us-ascii?Q?YkAlr0EL5v+ctY857PnAXiYuRPT44/wukgwjpD3EE4T8GccDB9b1VXnqS17B?=
 =?us-ascii?Q?GZPk7+hzb8hL+m4ow2uKxyF55dGZ52VrHlsbMZmh2jrizmgCD6cTisevIrMk?=
 =?us-ascii?Q?4ShLofo4Q9FMGUyiTmL0Sb2gi2IfMGYX70cWcnej8zXTbW/uFw2o2ZQlb+RU?=
 =?us-ascii?Q?K2tCZSjwUGo5zd3l2iJVDMJVFhGzqJBBTtsehw41ddTVrCTmhK7QuIgjZlVB?=
 =?us-ascii?Q?xgawwv5/y3Er7Pb17khjFRs6vHWM74HgXQr9X1Yt342NN9BT/WuatT0BtYKW?=
 =?us-ascii?Q?fSfJSOhShsxPIMY2ZVsbv7aoGLzRCWR++nqM3szJeY+tUich6iKQSjQxA0KF?=
 =?us-ascii?Q?5gCmEVRLNUQz2xW1GgV8+6BXxmfCET9feuY6+rjKYqk/W6AztYE5fSISGagW?=
 =?us-ascii?Q?3h8XSrJEEHslU6xhtkij/PeStSFhkO/RVAAK42p8l48uTs/TyS00xA3SvY50?=
 =?us-ascii?Q?pnOdFqp4eHW1NcM6+XPSDCY/8QDe1xhik1PD21wEGeYogSOvtoNTRjZTcLrX?=
 =?us-ascii?Q?f2ipVUVHL/8t+CCL85bpiiHXzyAik70Pa7MWZDD1bEsSz7g5XR1hYfHRaREe?=
 =?us-ascii?Q?Ra4vwwU+Gzo6aPBv6rCRRf0pxHrH99ewehb8bVXUth97Qrli0JKhjX3sB0xM?=
 =?us-ascii?Q?J8E1q4KjvtePyrwBZFysiZyqk1sSjkgOgjrB+Ipe9/M68XQwH2h6TxfQTD+q?=
 =?us-ascii?Q?loSCsqWgC2oXDMQ24+o/EmqQ9ZG3s4FcdHlJuFssqMz1J5DfC0ywGx8VED1M?=
 =?us-ascii?Q?6B3rdUxcsbUu7NvB5QR2sJXEKj7CmVelaFtx9rVAUtk5NJWuKyLvhnFXdtQV?=
 =?us-ascii?Q?mWXIBUEqdP9Q8h5elhPmoCBf3PRB5Jzi5qfjg9tntPmrUFMRIrM/t8lZd26y?=
 =?us-ascii?Q?n4tK+1/kip2m1+dA7dQcjOBR3H3vxmFFFsKd2VJ5hWma/HbGkiKKBLL261rk?=
 =?us-ascii?Q?ehRZFNwl4ZaG6CIaZyUdWmbYxPhFwvkF4iM4Kps51qZ+fbXXZT3wbjrVboCS?=
 =?us-ascii?Q?B4oyVxRSf2828eiVe0aTCIMBM5xmuW9oFkzMoZTLOsfnRiwj64jhyJZiDpah?=
 =?us-ascii?Q?qJINQdr8nIVgtKSwEq9A+MTp9+d26GmmNNTYPI28SbgRWBXgqhuq7pIIPpKu?=
 =?us-ascii?Q?Ck0grYNn8ESHfYwoQ7/PEGTKoQQbepn5IY/KYYqx7XpVlfO5sQaRVANi/ZxI?=
 =?us-ascii?Q?ngTaNJnqBWMeIzVDKkW1n+6lYIDp3pvTLWsBsxnPfCSFJReT9lXkiUMr0o3q?=
 =?us-ascii?Q?tF/JjMtpjtPJya2kshgCMPpbJprW6kHB4lA5xS0tzapmBfgUhYMS+zT+ahIO?=
 =?us-ascii?Q?uchru1obpvSPEJ16TWlI9VrJms/hX3DlH4wrzsG37jsF9tfWu47Qr8MwRFYN?=
 =?us-ascii?Q?Q03ipmEKLiKjPXRNn6DP7WaCjZ4zX50aAiTLzI7Lvtfj3I/H3xSmQsPDSbPJ?=
 =?us-ascii?Q?N+SOgl9nUMQv1ISKViQDxCk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efedf9b2-37f7-44ad-a377-08dd6bad53c8
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 14:57:13.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vyr5O8Gju0ZlEaxP86mraBcJ45r/cJM3t+GvZttwek73xEtHcC8HfH/Y/VP+4RRdtdls/TnbnRfur7d0GaLeFxy4FkJI3NWKdhpPlHWFNK5+/fqWBXIIzpMG5jj7VAiY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13248
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Mar 2025 14:57:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18364

From: Biju Das <biju.das.jz@bp.renesas.com>

commit c4d87fe3cd4eab905f235ecfdd09313be9bc0e99 upstream.

Add the initial device tree for the Renesas RZ/G3E SMARC EVK board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241203105005.103927-13-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 ++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 18 ++++++++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 24 +++++++++++++++++++
 3 files changed, 44 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
 create mode 100644 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/ren=
esas/Makefile
index 97228a3cb99c1..bf5b49f47ce82 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -140,6 +140,8 @@ dtb-$(CONFIG_ARCH_R9A08G045) +=3D r9a08g045s33-smarc.dt=
b
=20
 dtb-$(CONFIG_ARCH_R9A09G011) +=3D r9a09g011-v2mevk2.dtb
=20
+dtb-$(CONFIG_ARCH_R9A09G047) +=3D r9a09g047e57-smarc.dtb
+
 dtb-$(CONFIG_ARCH_R9A09G057) +=3D r9a09g057h44-rzv2h-evk.dtb
=20
 dtb-$(CONFIG_ARCH_RCAR_GEN3) +=3D draak-ebisu-panel-aa104xd12.dtbo
diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a09g047e57-smarc.dts
new file mode 100644
index 0000000000000..d4d61bd039696
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
index 0000000000000..e378d55e6e9bc
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


