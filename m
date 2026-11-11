Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5804.1794388785224457922
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 01:19:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PTrtt3K2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.21, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KypRmzNRxkrFHqsuooN5ZXIPxz6bHR6SuSqP9YEewgwrVimQIX7ubrwUUoQRE3fNRorgw1GcT9vd+RShuyh9EF4wG2W9OIvtZDkS1uqJy1erGE5jxTyeRZvGscm+JXQoaRItAofLqmNbm8qCTVGmVw0zUBTimSYAev+G8Jt6syjBEeyStx0oZ0QomrwW0Y9r4uCJLFIY+PIomVD2kNB23vYh5LPUbZTQihwl/LG+b6DA+cnRu2H/VhEgxFVa/SiMS17LqemmnIyAJDTNpDiUxc+Kqdmcbsf4E4sEGae0fwYR3HUxyT63uuqXM4dPWtD+FaQqU8CmldEFwkjHHHIm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5gHMCQcQU7D6wtVgKQYJSyPiXRpxFOiqmvYWab7kMk=;
 b=L609Htc7zj1RJczkLBkOU0i0hRkPoUjgFpNlSoxPetsWWFa2OUX5nqrRJKVheqwmSSsv4LbRnK/tV0cvvcwKaKKBDu+NqzqLfCUXQb04SZPYVHkz5qAdD/g+ztlrL2YEoAOrzh6bHDl9c+C8MePEJjgqzjVa6AZCa0UMBP6Irp/J5lBgqh8Ne4TPS8Mj9wPhDg2yDe9XPwSbXj4NkzfqqLpC8zsYjEuukFlz9HB0Amz/xefs3Yfr1lvBNfBvIYMpH6mDEvktnV97ozmKAUr++cb2Vbo9PhGrtSPkTrt0CMiUIOh/GYbbfownoXMtPwdHEE1p3t6ELUR+38SsDaz2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5gHMCQcQU7D6wtVgKQYJSyPiXRpxFOiqmvYWab7kMk=;
 b=PTrtt3K21eOTSIgAcvwRTiBAQz9b+6A/udBK6MzwBLlyQKRMLbYWQexCrkMi1AKDAkg/MGVGMlCrbpckQeYrDTJeHFfJWwrqizxwLUX5SdfxFyFncbmqt8aD96cak/xpLgNEMWdcbr8N0uysFh1OjyuUGgxgc6KyaZ0f8XzFcts=
Received: from TYCP286CA0163.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:383::10)
 by TYYPR01MB12161.jpnprd01.prod.outlook.com (2603:1096:405:fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 09:19:38 +0000
Received: from TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383:cafe::4e) by TYCP286CA0163.outlook.office365.com
 (2603:1096:400:383::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 09:19:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF00046B4D.mail.protection.outlook.com (10.167.253.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Wed, 11 Nov 2026 09:19:38 +0000
Received: from Ubuntu-22.. (deu-5cg22344cp.diasemi.com [10.24.0.52])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 0FFD93001DF5;
	Wed, 11 Nov 2026 18:19:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/21] arm64: dts: renesas: rzt2h-n2h-evk: Enable RTC support
Date: Wed, 11 Nov 2026 09:19:00 +0000
Message-ID: <20261111091901.41995-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261111091901.41995-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF00046B4D:EE_|TYYPR01MB12161:EE_
X-MS-Office365-Filtering-Correlation-Id: 126326dc-51dc-4e17-a982-08df3fd4e8f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|13003099007|261009223027099003|10067099003|261102123227099003|261021121427099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dUYFB8E3zAwl7P7knaKt50TsgheX014GbYJBiX0TMk9VKIBvyTNVDk5cjc5E/J/bYj/9ztoR+L8Js/57a38ixLx/H4hhJg7LXcGYXilFBe88FMBF9UcXHgUT88kyMw32ZPw/8EuWZchtSTM0RNgl2lIXd/4AmRpLlGqFclvyvNvcgmHTK0gOwkh5umISy9OIyxLVOn6z1pmWvjXfg+eV/GZu1jTyfzldL04PXBvCUejlIrVGGWoGRMHIuFND6XdG9JLhqbVTDoBE5HKN75i5RvjQ3CPDflVoTxc8cmG/T2vIO9iTcjOwIEvlozqYFn7McV3phUdHnu6Ypm911T1rYr1kGOn+seJINfM0KfQxOed+kgLWgBQtvqG7s4ckl836tBxbAkZsfXWev8t85DxfLAHSO3+QoqNNnYglaKmS+f2m+zc5VWjRm6cb5NWq/GEjdDTy9AVcNZpobPaUb5IEHxc/UglnLBRiDgsnUp8ahmDeHPOEHy9RhzyTql2RxiBkg7u4QKiji0J5W+JcZ+RgPpfsKCj7T27LhYmCYQj2V8NmyKSk2KzzZTObXV9iyT8Uo7jbLFyr4yYBi//lgdb0geoa6+tRtiZZaZufBelHuT2wDV4Z8ZwtJXYNvlfJ4oRW52BvRo3eyFO8Lcu6ngPPgghOh44UF+3teqHbq0tXkfo=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(13003099007)(261009223027099003)(10067099003)(261102123227099003)(261021121427099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 60KJO5BBlfLc+dncaYT6G1PpY2AVayzBKEDStuxcE8PKISduaGlb7RN9zJ1dTn8dXezM7/iAozXMNfH5vyavvV59s3R2jHBk7UhgeSMUXQi6Wtky/oSKVS1xyOOZ+sOqQ90p+awGIq4oM84RqpWpRtf3nfYdksTDdAP5p1YBnYjCb4fWFnulsiw0Y6M/ji7+q/OJ1iTnQ54eQtI7wAm/Hd1z3WxRfccTk10wOT0PK3ZcMU682Cjv3gNc0zN/mIk0P6FlrqymhMkEw54jZMG79NSPiAKrkGTqZs0zTwKlUbfV4Yp2CX53r1GW+LYDW/w7FEwHquoZbv9jcF1+5K/oLEXMzIkbM8ZVimylWHkWoFJlX94zBTUfRUnZpqW/cgpGn09ZJbj1BWfgYCKzDoSO3vpZQYbfPrlOFK5ZElFO1AYDIvzyUiYneMHaYOfBBozc
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 09:19:38.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 126326dc-51dc-4e17-a982-08df3fd4e8f7
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF00046B4D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12161
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 11 Nov 2026 09:19:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24761
Content-Type: text/plain; charset="utf-8"

commit b367a2544e5c41ce6038fea19929a360b35a9e71 upstream.

Enable RTC support on RZ/T2H and RZ/N2H EVKs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260824075936.2904336-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi b/arch/a=
rm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
index 5123a6caa4016..ec5462d60a27e 100644
--- a/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzt2h-n2h-evk-common.dtsi
@@ -20,6 +20,7 @@ aliases {
 		i2c1 =3D &i2c1;
 		mmc0 =3D &sdhi0;
 		mmc1 =3D &sdhi1;
+		rtc0 =3D &rtc0;
 		serial0 =3D &sci0;
 		spi0 =3D &xspi0;
 		spi1 =3D &xspi1;
@@ -375,6 +376,10 @@ xspi1_pins: xspi1-pins {
 	};
 };
=20
+&rtc0 {
+	status =3D "okay";
+};
+
 &sci0 {
 	pinctrl-0 =3D <&sci0_pins>;
 	pinctrl-names =3D "default";
--=20
2.43.0

