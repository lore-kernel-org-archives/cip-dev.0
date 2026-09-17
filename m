Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F78FC982D6
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:45 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35318.1789636602980051720
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=U9m1gNQj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.0, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4L/NvNjCTSfN4QbNB7o7jq/vC3+eT7fktjGpsdFUddr0iUtXxxj9YeGaQ5BB6zr2Uj+ZbqIrP4yNZcnlKjH+R2CXFXwi1Q0W8dfu55Wt5jMDKYvgT6m7gIYcn6A8ts2RPVn6aEBH0Te622VC8n4FFGdZHDXGGpgp2zxc96k3+OqDtR8ezqhuTxw/sqdH35P9+3tZHmT0RLL0nh0QTvWgoF6TJTJlMsB3zSK/C9FAamAWGCV5g7p0D6IIWlW9jTDbkA1xW0ZPH/A7iajh36xiyqInwz3NTU1NCRT3Og/ZTOXZAJRVi12/3iJVApdasqSwtGtpAdJDUqOhv7DgbwTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=skoG+h3o2Km0vbNCowfSzxfndNehqT7PrGYMhHhCcUk=;
 b=SeKNxxQOwx4oW8sje/zWgT1/u+Nr186uMfJILP4Y1YUkqeXMwA/bJr63ztlIk+SUKzWdbSRMj8WZTLz2XiiTI/Ov42n2lWzgOH2j+VJ1am5fwzvPKRMorRRRvIkfGjjn/OEDuHRSaHPqFijJpNWzKxMDyMsZeggOubuUshGbe21uI1XH51iidOlsq4Pg3jPNzWqQDBpxfeXXK2a3VQf+0jIx1bWl9U6u48uXeAB9BqE8Co32d/axhg7zmf11ie9lyss1oCaeNYLvPrfdsU4jDfEfFF1uCfE7bJWva8Kra+1ImLNYi9MGgHsk438fnBB6ROoOjuVGfulW8mSmsEjLBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skoG+h3o2Km0vbNCowfSzxfndNehqT7PrGYMhHhCcUk=;
 b=U9m1gNQjb0QwAb2GxmbKWFDQe0FgWbTG0J+4bjfVCHfuZNajI59YtpO6GrXP0KbfxwJEnsVKyL+q2clVxPo5VxevWUM2VjnK/aegvy1/xV52CGME9PNMZj7SUjhA8tmNbaODIOWY98cCt/pkZ5XL4/WXXUu7FklT5d+HCL2vKgg=
Received: from TY4P286CA0122.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:37c::7)
 by OS7PR01MB16883.jpnprd01.prod.outlook.com (2603:1096:604:420::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Thu, 17 Sep
 2026 09:16:39 +0000
Received: from TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c:cafe::72) by TY4P286CA0122.outlook.office365.com
 (2603:1096:405:37c::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD7.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:39 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 70EE030007C2;
	Thu, 17 Sep 2026 18:16:38 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 09/10] arm64: dts: renesas: r9a09g056n48-rzv2n-evk: Enable RTC
Date: Thu, 17 Sep 2026 10:16:20 +0100
Message-ID: <20260917091621.18551-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD7:EE_|OS7PR01MB16883:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2e7f07ed-8f2e-4c31-11a8-08df149c61d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	tI1axWwCvfFKG3/Rhmr8eUt0XTutONSeQs0z16RbYWQ8E8HDCXNK3lhGqRSw2L4NIJnh6SgHvmnOrU2ABUjPnl4D8tJFIKABvMV79OBFHXgp4me/cnmwO/L9QN3EkWvUHCiJxRo5uBdIL8LwDGz+ZQnuvRhQhz8lXQ851K5nbBtlD3I1alZSLVfm+8W7FXvhTvdEvEPfOt94aIEMjE3jOyCrF+h4AEydDKN1/odgMeETV/tmWW/2JOjq+lrs5MDKDcVaaJ1Gy+YlvzYdFilw0mA6Z1gYBt4ldEPEX/ArAGkAWv5e2taZBFRleECKEKiHHsUxXYy1A44OfFk+BgUuxE+2ooLHakvghFfzBuOA2yZXtVL+YUB52dG5S5wS/HJjQNIRMBDzbOSYjzaSGgqPNSBVbuLFAFKh6XWt7CHliW91IBLlJJVaUicS9s3z77CECk9mPp8CvuxomzFGHrrFq3Sl+bsSDRq3gnHPNMK8VlTCYkWKCeg0oB8msd110PZ4dJggJ11f1GTmii+YWSAUi8EibWISf8uBIydf0K7tq9m8CF2vAepq5HlTAVyG0R1WwKVgCA1y6cz+R7DcvcZAwUhs/IEygYfIRTm62oZ5huVTjYjxfRxINfaCoW+xQeYmqdrW6WHj/hmNRgaZSc8Ubg==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	RAvunZ5LksxyhMKTH1I2sg3bQX8+s3mY2D6xQnN+GwsaK1br2dfmFjm6wUbzuWuizUHD/xGc+OczGJ6cqIoTnJC9iFJxy2PsXbN5nBYYOwe1mOB00ICjqUQJmNJB3nNrs2i5aGHQnEuCDdnvoF+h2HEpzFnsLuwUakgfqHz/DxHBf9SBuNQ7l9rk0q090QnC0yR+4FUytakS+0Ya+ZinNKFUowFG3ffpxzRQqi4wPq/Mp9xg5oaVSc6JFbTvAHkecjBNd9NJvB/shnM9sOHDeMn58JyUa1WYJx/ME3Yg/Dt5vWDRMliXBXLYuqAKl3cEvO+muxqiu/8kFqf697S/M57NVKpyLFh1OZP6oHsoqK5iIc7StZkIqfjBLY4DUV85q9lNlcbHadWOx7dYuWDHLmfGtD7CHYky+624QSIshqxddB2GqWTwlTWH9KrKO8Ek
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:39.7956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e7f07ed-8f2e-4c31-11a8-08df149c61d1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD7.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB16883
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24216

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


