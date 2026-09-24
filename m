Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C627C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 09:32:38 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.11])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.3875.1790242351866493111
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 02:32:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=mgt7hpUx;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.11, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u89xm18mW0IOxV1OMvovuOQQwGTMws3Y23bSNuSx8zBHsNrYY20tGNf88nbAqnJg3oYf0dUCCGc617SNSyWZVKEhl7eN/8orzesNrbrapQr792X8a9ODDhf+qfVdIHxBaSIEgoxaSKJVV9luPmuKxR+2Nj1EWnnwxrbQkuC/hKibj/jPDQymYBujg7o5ZrIpuFSUjtDOexM2pKORpYZnSRWxrSRbv6csUwqQgEbRQHbplVb6ZFuOxOnHegHOWi72pfRM+vrTRolfPHvc3ttu5Q2h77hn6IPSJD7BBnUdxRH2RTuir3gRMSzhHAVtajaHff19QAf0xYse9h3Wjd71Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbRcVtFC5etypjOmOoQit5XBFWE+LIn+SJT1z/4581A=;
 b=rrkj/9VBiMElIkdFHAbOXitK6KeTyd0onW5qLaCXerYo1E/Jpy146dlflytFxY0+pxE+iicCnJuccFb/UM+Y2s5rXUyhfNkmChQOl25vjyFUuIFm4ntVLVDXh+HJzKF107DA35ZLLfXdJ0nG7IxiIuIXdTL+qFfiWFzPLTnsiV3hUuA2mWZHPqVVa1o6wObS1HDJ8hrd87dU9lhabzjczFVS8Gb2Lzb7ARlhASdlfK+XHIa71T85bXhhuBumrO7hSpaf8YgMTEzMnwWPnAu2RgtNsnUYmIlXf0WU3Crc8f3WeZxtYw9sNeN8ejUdLrQYKiARvEs/Co2w4WfHgw5QAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbRcVtFC5etypjOmOoQit5XBFWE+LIn+SJT1z/4581A=;
 b=mgt7hpUxq95nVNOOwzsmoL3prTQk+sMbA3JmY6VnNLVnRFEPj6Yw9e8SKD9GlY3QNcKKO3faEcsITKfuW2Gsd5cdPJMWgMPWPB/THJOcKGOZXowFHExEgZbJWaGOtRyWk6dDUANspYzd8XoZLDEjjIuu3uXuZzj9u3aZxStDzLQ=
Received: from TY4P301CA0051.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36b::12)
 by OSOPR01MB12331.jpnprd01.prod.outlook.com (2603:1096:604:2de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 09:32:26 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36b:cafe::98) by TY4P301CA0051.outlook.office365.com
 (2603:1096:405:36b::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 09:32:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 24 Sep 2026 09:32:26 +0000
Received: from biju-VirtualBox.adwin.renesas.com (DEU-5CG6192QFB.adwin.renesas.com [10.226.92.107])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 025C9300020C;
	Thu, 24 Sep 2026 18:32:23 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/3] arm64: dts: renesas: r9a08g046l48-smarc: Enable RSPI2
Date: Thu, 24 Sep 2026 10:31:53 +0100
Message-ID: <20260924093156.131928-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924093156.131928-1-biju.das.jz@bp.renesas.com>
References: <20260924093156.131928-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|OSOPR01MB12331:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 40c7b252-51b2-4a9c-d952-08df1a1ebf2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|13003099007|10067099003|11063799006|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	sO1QnqLYeQpspQx1sxHFeTdtzEgVZtnrXiO0SMtKFNZmxapdJcXgLosfsMCxNUkMgZuht+JRv2Mb+DOEuSvlMOQ7NuE3htJ2vAQ9Pzt3BUY/3oh04tR90iN77ay8lYEGi5v6MGXOfVpQo7WHZ2NCLIAcykNUiF9pJgzi2OcMdjWW7OBtyV1R/+lqosGklysWKnNn/NzTq12eRX9kDiPZZdz2UPkQTTQlOPCn2QnzCvS0V6XlPkqrOxgZYkhP7isvw2vDOj8qDFMqx1oMFS/L6/2+8i4lzqrf4AqvWg8YsQwJqGuo8xUXuPxXZL42ukQt2GGvF8gRI94yk92qIj6yjRZEsmkKCFuXJThMUo0puR/wTyh0cg18vJ/c8iDD1gUAqhjD5e1w0mOSUndDjZNCqbW3gNaF+i999Ir4qzziUNn2eTIjpTBVHM32G/E36OckhMVhPbtFlrjlvO6McFmAyma/Ixu7jVs3EeqM0vdhMYR9EjcCSyQAFjBRfjYAPDO6L6DCAGkTYFsDgi9MotRyFBYP3S8Zvb83fIzV3ShBzeUxnjTDVKx8U5QP92LesrrabQu2nUlKHTEdBe8665+YxRXnKLCaNCpFWIiWnzomketg27fl7gwY41G310pEm44RSwEQPu/xKtUp1HEN7x/+rQ==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(13003099007)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	5QsIgg7vWXtWJz+f/0h1ing+6xx2nz5GNtUBWSBwiABhUQ3eHc6kE3fxugEqE5+Ci/u0ZgGrHX2X6pOFDmbcxK74J60McQyiFz0W7bvvCDiFrikh3AJZEg+uWkLKKn8aS9h1F0pGXZgv87dr4hxNh/9tfGzNvgRnQWcUKfxRNWr9f4t6VYvYO5u4mVXTc5kJp7waDaZZg6tEgMMswfD33TYg5SLlJANBVQPCRmPsjBtssMc+2TLhMC95hco4YBzqY2vfLpvNJtfbI9iayDeRydJphsTnXNjzPee8nyKRMN2tW1F6iEoJT9rCC+5dbxpWqtbuBZbT+VAg5xhARvBYV7JLXmAfAQlUH2WHJqPPD0XKtCs1XgySHqWj1AYqJ+N+/KwS/4rgs8+v4SShm9OopmMk0s2+GxPi/kyA5KojrIabStbfsOQwIEY41y+zvvvL
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 09:32:26.8054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c7b252-51b2-4a9c-d952-08df1a1ebf2b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOPR01MB12331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 09:32:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24305

commit db60b8a6154af4221954065c695a0b35cee34b72 upstream.

Enable RSPI2 on the RZ/G3L SMARC EVK board by adding pin control
configuration and activating the rspi2 node.

The RSPI2 pins are shared with the DPI display interface and the
two cannot be used simultaneously.  This is controlled by switch
SW_DPI_EN.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260529130704.327505-3-biju.das.jz@bp.renes=
as.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/r9a08g046l48-smarc.dts   | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts b/arch/arm6=
4/boot/dts/renesas/r9a08g046l48-smarc.dts
index 32d3b08a3cf3..c1c36f752959 100644
--- a/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a08g046l48-smarc.dts
@@ -134,6 +134,14 @@ i2c3_pins: i2c3 {
 			 <RZG3L_PORT_PINMUX(2, 1, 4)>; /* RIIC3_SDA */
 	};
=20
+	rspi2_pins: rspi2 {
+		pinmux =3D <RZG3L_PORT_PINMUX(6, 0, 2)>, /* RSPI2_MISO */
+			 <RZG3L_PORT_PINMUX(6, 1, 2)>, /* RSPI2_MOSI */
+			 <RZG3L_PORT_PINMUX(6, 2, 2)>, /* RSPI2_SCK */
+			 <RZG3L_PORT_PINMUX(6, 3, 2)>; /* RSPI2_SSLA */
+			 power-source =3D <1800>;
+	};
+
 	scif0_pins: scif0 {
 		pins =3D "SCIF0_TXD", "SCIF0_RXD";
 		power-source =3D <1800>;
@@ -147,6 +155,17 @@ ssi0_pins: ssi0 {
 	};
 };
=20
+#if !SW_DPI_EN
+&rspi2 {
+	pinctrl-0 =3D <&rspi2_pins>;
+	pinctrl-names =3D "default";
+	#address-cells =3D <1>;
+	#size-cells =3D <0>;
+
+	status =3D "okay";
+};
+#endif
+
 &scif0 {
 	pinctrl-0 =3D <&scif0_pins>;
 	pinctrl-names =3D "default";
--=20
2.43.0


