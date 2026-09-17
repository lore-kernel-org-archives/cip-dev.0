Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7AAC982D2
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35285.1789636461948081216
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=LWOJ6gps;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.15, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PDtD8kOTuhJtfLa7eyiJDNZ9QLe/GgW1dPEfTcwz4l/XhJtbb8cpNYvLltlYFRTzRmdCPIbrOzSCYaVtkSMDZqP4dQbJFJh2jKD2CauWMjTxCUReJk765cmO9hH0hVVvWzfclXaM9KtccUyLaoN7wNnUrjZqajvYjFH6bw2F3bnWDlmvtrWeou1gIbItqYREF2oexAzwPbF9zLnxs0TDv53RQYUQ3Sbibb3ivSbTw4A9ISeztujbJIEJdkyjb7Y3EqpuNFL2VcGKHdB33fW5vo5C+eOtXPhgAju2GIUi1WwVxCXO5+Pq/riMI2MpbPhbTIrpd13JvOZLxEmcMaSpPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skoG+h3o2Km0vbNCowfSzxfndNehqT7PrGYMhHhCcUk=;
 b=d9CD0mBwlFssGCcpK6tPaZQcLl79ngc4/TpD384BfVdE4nPwbbiNoFxMnDnKVRlcQlG1uwQ8FYzJpb/leua8+an/hlobYpz0M80mr2fPew/TIX7+OdOMgTo6Uqhykw+aGU1X4aaUTu+A4uNmycf2dv/+ay8UJ1LHF2KJw8BkLcOcdbu8Y3j/QnZDbrqcUzsGa08MhIMvaKAynj3+j4qMdkuNSfoRLIcPs3ZPcyE5fZRetrA646h2Mas/86bZFWb4YvyzxqzoRoY7rix7sYISdpk3GB3nasVGX7E1p5x5MzOhBu9GtGizHVLCBfmVuNf7chvnr6DnWwL/LZeaZATKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skoG+h3o2Km0vbNCowfSzxfndNehqT7PrGYMhHhCcUk=;
 b=LWOJ6gpsEGULgTrJaXSYBv0aGsLyeM06mzMTChyQCQBIXz5GkJ5vFK470gC1U43b8lEjpphUymNuhv2b+YohhXKHBts2UtzVyGBhFsyIHG2ZpXcZqQfIgdiRogdYhF9Dh6tkDV002mnti0cB2/MWjJGDoel/FeK0/+ml6VHYaf4=
Received: from TY4P301CA0028.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:2b1::10)
 by OS7PR01MB17871.jpnprd01.prod.outlook.com (2603:1096:604:441::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.14; Thu, 17 Sep
 2026 09:14:18 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b1:cafe::76) by TY4P301CA0028.outlook.office365.com
 (2603:1096:405:2b1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:18 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C1D1730007C1;
	Thu, 17 Sep 2026 18:14:16 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 09/10] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC
Date: Thu, 17 Sep 2026 10:13:58 +0100
Message-ID: <20260917091359.18445-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|OS7PR01MB17871:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d80ca2a8-ad0f-4785-248c-08df149c0d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|36860700016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	GkeKLXsB2DKSbx0zfp3yGApNWg+EpEOZH2wdTJwBGtp0WGVGXGxUHKo/v2FlqxIlvxNkcALfRhphockDtZHZhCUUr7G5jo52So1CSp5qi5mSE0tFm17dw5djtkfSZSeIK7PnHJirjZCQQiyZE3twO01kpjFnPr5Yq7QWInCDMiuFyZgBda5qlOEcQxsHkDBsqtdnl58K+3Pt8Ldpt324tqmlCBkjbkq4noGBIT5+5S4RRdImL0+OJWwhZgdGLEndNGEJgkIqt34e0WTcidlSjlbXdn9s2QDim3G1xwZaXm+IrivHzu6XV7geA3wDK+mb5HO8BjOaH9qMROC/deR3XUnKxe0X/Sm/PliLU1SigzS9/fxg46887rHCtToxVub9dSQPjT3lh4HCiv48t1cpXIRfBS+pi4is5e7YWp8ApJYq8nMd8BAQ1MfQiWBnGzeFOVTGFlV/k5ZSt8A5GmajH/YXirnTglCNsnNeyOtzZ71X4B3QkynA81dPTC0Zp8hPmkhaqHRVP6ICkBEXcCNNAs6SIuk12jV/W4dQNJan318KXL0Bu9nrxIIqu3fbASOFkWJofe7+sk0N8IP/NxF9EurTMGcnqkdHluhw0qHHW1gVO0msxwNOhniryiyH4FTy0aS8EyXmeuVEUi/40DVu1A==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	x+9t9gahuEtVmMCTMjIHkh2uWI7g0wZinkJ63mgwdnp7//rub9H5mLmr9dfU7/lk91GQBRXLSoRq0O7h4xp2AVpWM3YCuIVnXQPUrZKdcg4H6hSJMHRqCSOzaQ+o7PDrZLodh+Ye99mPnvmcPsU7cBJS4hwKZ9ShAIqCMBriPzJluMIA3rlYyRUUc3+Vm1IJYYA7dRbBGqeVn3Fl7Bez4AMCOUNZXrfbn8VKK7XN8w54nXIiwmv7VNSd3Bv7AFCKDxWEIuogxoSep3aidk8S41hBOBdTTnXihTmdeXTBnvxtKgAFEBVvtVk+amxDYku26/+5ImehN4KMcUDIeYavb78ItSIjqTErFPeWxrK3k3HqUf6bxAe/ANJuBlRaAJis2OnsZpq77lIcUBofLV1ZrSNuxQO2QbCPyEBXRv1FsdgRTTECG7qjbJSXuCEkvxNW
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:18.4071
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d80ca2a8-ad0f-4785-248c-08df149c0d8b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17871
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24206

From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>

commit b901f2f03ed72ccef7a46619550546e2471d581f upstream.

Enable RTC.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260125192706.27099-6-ovidiu.panait.rb@rene=
sas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts b/arch/=
arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
index 38c9a0489f851..914960100e659 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g056n48-rzv2n-evk.dts
@@ -454,6 +454,10 @@ &qextal_clk {
 	clock-frequency =3D <24000000>;
 };
=20
+&rtc {
+	status =3D "okay";
+};
+
 &rtxin_clk {
 	clock-frequency =3D <32768>;
 };
--=20
2.43.0


