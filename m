Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA018C36007
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 11:01:39 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.web11.18718.1742554898185898909
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 04:01:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=oaFyhH1k;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le+1bTQ0pS3aYPpmfH3Fyn/gMgfHBIZrdz53dtsuT52K+Vk8/KgNQNbGsr/LGyubruXtkMsIf7ld/t2xrvQaqeaBbxDby/fFZsHVLtQ+lvO0Z9UP0BiWETLYw41yKjXbf+Q5eV7nugxVU5gArpL6bRZl5aMDknqwXVLaPIBYK3J3hmhbB7YCI2IoMQjHXhiUolKnXZu46efkh1ovw+3wzFM1vW1bqkriOTISU6/B5hbMXqCclhAbGB+kdvejW7hK4jTr02EzRsmXCbEhy37Xs5CuMKGzf85iCuaIdVtfWt+7mhzQ3lpMH/+EeYWxRZNKYg/I/9MsJKeEt8DRdbXzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fE42K5IBfRJyOj0QyLBMCQI/ZVNF2ZmgoGSAMUjb2D0=;
 b=aqrrKoOtwJ8POkUAcOZOmS+wG4M7UbefrxgbwOt5kkaOsGSKnCIRF2tShFFFm7j0FtkWYpfNwR+PlJ3yColHGrHHpUwuZ+ziH1Dq8vWnV53u3dBwH3bvphSu8MpPGpaAjDs/Z6zcR5eTD04Amv+9KJ+5ocqHRz9pk5AfoJMJhZqyRbcbn6Ex7nG1/amWBn/w5C8ZgH+gM0H1hOVmbxcRSy0VXw99czCVw0WUpgVZGrA6GUIsCCB/9SEQRrsCuMqptW9VH9hHa+2kpQzoVvIxmiN8Ahvgzl0iIdn9itOaH6q5Kwm/TCGfkMZkJ3jjWCukwzOMvEsDzu6LWR23Y/yjAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fE42K5IBfRJyOj0QyLBMCQI/ZVNF2ZmgoGSAMUjb2D0=;
 b=oaFyhH1kckdKm3vldWZrmpL2a/Wt37dYgq/t6VcJbK7lNhKypZ3GRXUK+wTSIAlBLpcL4Tu4eQRLETzTveK3/oOJGrTqrUgDtycvCCduyUtPUD9z8YdQstClnaOyRBkeWSOfiQpg9EcqM2LfIwPAAHw53tAcavnzL4Ey3yw0MxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS3PR01MB8652.jpnprd01.prod.outlook.com (2603:1096:604:19a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 11:01:36 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 11:01:36 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 19/21] arm64: dts: renesas: Add initial device tree for RZ/G3E SMARC EVK board
Date: Fri, 21 Mar 2025 12:00:19 +0100
Message-ID: <20250321110021.3612805-20-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250321110021.3612805-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS3PR01MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c54b408-47cc-4027-69ad-08dd6867bf63
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?suhEUXVD3pLLAUSoVQnYHBOTUiWz7yum1muci9rQ9eONuRBawW23GKJRa2P/?=
 =?us-ascii?Q?IgKdJuACWWSSHYMew6DNSSwxJLo6TRy6U5cAop+iAsqI8kDI+gJMV63j/R/K?=
 =?us-ascii?Q?B6r1wP1aqbumMgG8M1zDS1aXkqAOj/kH0ON81VuWkdOXZ7LQLzu1EOvv23JY?=
 =?us-ascii?Q?TTTKBH6zjy8ubiVkSeKEBfJRYOw1hA+RXwls1kfUxkv7qkrrt/TmAOFyf4d1?=
 =?us-ascii?Q?qpshRLTPmQ/gBglaZvFNkvySFdBHxzml8UPq3EoQN5UvK1UV0PLmaeLcgM1M?=
 =?us-ascii?Q?tmkqLeOaXpXymhBdMdgiKnRabcu3fSpg/CnV3TL8269TUMPByJkTJ2m40U2v?=
 =?us-ascii?Q?1enXlLbydgmheppWE5bEv3C8COnVU8aTJtHdzSdX11uMC+aSI/0uYTlYSh18?=
 =?us-ascii?Q?HHWRBklmwsPOv1rJQUwKLTKtk/luww3bwLwohuy0ywNzFo5BFuMiXUY7rK3U?=
 =?us-ascii?Q?pa66O+dnmUtbpU7GX69v1gG9poN0jd9PRp3Qkyg27ZxOCORkmTd/tXLtmZmO?=
 =?us-ascii?Q?8EwDmmQ8ssI0QJiUOy4sFsetCVqZOVjgpDOlBZYKBbbT1UX6qGnUD7l2UzQJ?=
 =?us-ascii?Q?MFR79MhtQ0cBCCmbat8zf8ToYEys3zGoS037yQj/MkuwGilBW7K+u22YSeKF?=
 =?us-ascii?Q?l3s3yKBP4QDbt7TlSOe26FevKwZ+YvCqZq57JIp0KpsK1Fzgr6MxKi9Y/tni?=
 =?us-ascii?Q?kKGBbfzbCGo9nVIbcgn4pjWRCjWMsrl4xBi8q4BKe3gN71dyucnE3mSj1ARt?=
 =?us-ascii?Q?WpWGuua9E5Um/u+qwC6HqZnrxaiIQ4ZXVK9tnBu6H6Tke67Ck9zhkvNAlC79?=
 =?us-ascii?Q?//lXPYepSaZrAO3uiDGVD4LEF19C3ADAPKjKvqygwCYbMybElTHq+d6iCjtk?=
 =?us-ascii?Q?rjIiB9HdbFCBE2abB/MmLBV/8CpAuZ06fh28zbHaaflSbmRaX2HR8Qi6Gnht?=
 =?us-ascii?Q?urmbrhPAEiyUoo0Y6WIYfcNy4B5SD94w51cvKCcJ27uVMnaSuwP/OlTZKZfq?=
 =?us-ascii?Q?reALP0UXTvscDH9xo+4W0x6GXC+c2O1UBF1SjZjj0mGScjf6axv6Qea7hRSw?=
 =?us-ascii?Q?fsx3rP3yXsw6b/XE4M8KGWF7Ot04UzExJPfU6TVy9+cQQyyWnkjwaE4q71wM?=
 =?us-ascii?Q?XFR6PPwP0nPlSynpG9JZxn+hQyh6eiss2rc6rdjDOGJO2MlWxdn9aIOEvMkB?=
 =?us-ascii?Q?0L5kX6yMlQTux+uXpT0R+kDI5NTMVTGnimavm5vmGZp3UVa99h0h3ctWFvVu?=
 =?us-ascii?Q?x1nK5PZLYZuG4aCxTf9K9Nf6UDKVHiHPKtpTGD1UlQ57yo44rRJUIH2Smthd?=
 =?us-ascii?Q?syvvIXDcV0v68L5xoN7v+SPYs3P1R0ge3lO8YzGUT2/EIFGGKXckX6gTf53H?=
 =?us-ascii?Q?RCOOQYhgncC9zZUg1eaNh9Do8u4g7djg6oX9IRrJDHlF/T/LRGX4Jo/5Udtf?=
 =?us-ascii?Q?X/f3wTCIoMYGH6KLU1GPxwWXmU7B5DVe?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?EMVoWNmK6/foiU8R1IFxvZe6Kk97YKx7Lb3nP6llQYvQ40c+R0If0sGDKrje?=
 =?us-ascii?Q?VPbLgCr86l9CQlu18EUNjfH1DD74mdko8YzTAmG960wWMo80f/vC06e+U8D/?=
 =?us-ascii?Q?lha4rWXMeiQuI/mNYtrEIS/ijhYPGV853IOSsY1g7sLoGJ03JdaC4zckmWBu?=
 =?us-ascii?Q?i9d8MDGSkUz3RagG5rXIOJ/rNEdGojNzlApYcZno80KWowec2jitfFq9veIT?=
 =?us-ascii?Q?F8dQqf0m3hyyBbjLXY+EDTJ2K2SHccT5UYOWrcVkDFKA4uTWSLjndkpmcCKn?=
 =?us-ascii?Q?mOYfwtfV6Z6Tl9m6RsLQJQisq4S+l3q8TCJEx1YtgHu6te7JT5467aKehckR?=
 =?us-ascii?Q?ZjSmdOd1s5swQ2c4ipsiWvyO/L8AiQ0mdRsAyDoyRdYgfcgavPweT2Aj1g2z?=
 =?us-ascii?Q?SdwOckPtYEzB2bASb266i0T6CCwuGSPJl+Dzfa0cHzU+USo7wgeIbSatP5PP?=
 =?us-ascii?Q?hlQa0GPUEgZe7cdKqE53KMe2E4RGa3E9wFmt7QMONfPfUaAbOHtQ43iMCtSc?=
 =?us-ascii?Q?qSn7Ot6YpWe2Ol8PAtDKXiAFbE13dtdGi/R8Dqe+IGlQL2w86DX4h95L+LLO?=
 =?us-ascii?Q?yb8K7eZ41B0FH9pyHr/aLf8XrfrWIIxY4GwEsFMg8oa6Hz/NC3lVtU3HoYnb?=
 =?us-ascii?Q?MGQGHvDV9N9w18G/FRJMJgfkBKueyixKvofusCvrTQu/CFHO1J4ZkqtSVl+v?=
 =?us-ascii?Q?OkaEDfXZlaKaysFD/dWP3pGfmj3EjVt7IxN5JGVvmCIZ03VjLDy0bpqVhUAK?=
 =?us-ascii?Q?nZCJboGkjMYOCQg480n4dQHn+qCRUvrYqFsARLDFwiXlwNijOpmSd0Q5H7/l?=
 =?us-ascii?Q?o2z6t/p3uYFjZ3AFpB9XU+Ayile50PR+mkVGq9E9gD46xa6+oeLuLx5k28jf?=
 =?us-ascii?Q?Ki5dQWxmldAZUitbc86emOnpSlbtu6PBJh/Ur6uC6Gw8JkoZYvbxezgPzYyp?=
 =?us-ascii?Q?aPnCllw5Fg9+/F2M3YSF/qRxUJw0NHwf5QDITGIVD9cDdB8ubirOLlOiAQDB?=
 =?us-ascii?Q?pJozAMkYI6JGX8Cv9oY0M2PXYBBqhYa3413R3xoDm6V9el8BWvWcml2dtBWo?=
 =?us-ascii?Q?DusO6/yp4ILu2w7u6CYzzQYSTcRY2vDdGabYVw3EZIKd9iowxNVql0CHIKpO?=
 =?us-ascii?Q?nLuJxHYzi6l1uBjrI1JJCkJHne+pbZh/sjWeuYhXYJwPJicQg6N7WdtqGbLO?=
 =?us-ascii?Q?eSWZqRhh98Z6hULcKazeZkEtcimw2cHrCV+gEV4Ny9InWdP0xFZCZ4dmGCKe?=
 =?us-ascii?Q?YKCCnyQQN//KO229cs9VCJUVSqSmqHeh0079v7zReAnPWbypc+QseNdm7BFI?=
 =?us-ascii?Q?m0bb0+f3dutIZl6xA5YjtL1QF5yCYJ7dFupkiXsZoryyijk2zqNQ3AvZsM85?=
 =?us-ascii?Q?F6uDymYMJcExSY0l4goUEd6oMTvJjkIaFMDPh+iByxS5herxkJJH65VJlrXd?=
 =?us-ascii?Q?Kgh+52dHyBcoXop9X48/I2J2RR5AsGeS/GTv8EP1CdYoEKqLF9ouYflNHmcU?=
 =?us-ascii?Q?wDyKGXHcUkdiubzvSimbTBTYiTGAeZsGtKqdnonqG4t2Lqlgoq8x5RZMQ7a+?=
 =?us-ascii?Q?3fygi4xmQDrOtQkK6K+2JjXQE7Ni3FxdI/UZ7sYspGLBh4W0cjZJNqJNoWhh?=
 =?us-ascii?Q?jcQ+8kavo0zJ19yxjvSWvCE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c54b408-47cc-4027-69ad-08dd6867bf63
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 11:01:36.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLOLzVtYQrxTUmW9BvBlqiu9NmdUU7UWORTU1nX4mi/gYQmBqqQNf4puMkn2gKxD6Pf31G/Ypljg5GxS9UvuPMbrOHJCY5dr9AC5MtI+i6yB2ddbG2UUZRYyv4ZZIWrU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8652
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 11:01:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18326

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


