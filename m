Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A276CD6E4A
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:15:09 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24219.1779898504576701242
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:15:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qqmzzbJQ;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.46, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLkfrEwxzmBpwmrxDoqM6MP15LXLeJmV2g+yqIfo9VLxd7/w+Pb6RlgRHU8UZ+vrioRN7HBA6D5xGzNbaX6n8Y1j/lsZiGMmux5e2GOSM5Y/Iiuhc6My+3OtDIFOSLHY3VdJkFo/46g+LgbhZ3Pns7TnYgD9Mnqnnm+rjaX/Y40Iaexd8o8vREBp8oQMnSmmWEPmvUSgTu06kBJ+enmtVZXdOC+OhU21uTvIdHpkHbourrhOIT1RjY3fuMnF4OyVGSyR7/7NOyXT61oJaDy5nQyEd62ZQ0tWhJ1jwWDh/odAXQxx8GZ0mWaExQ0xBla34XNZDrUcePlAe/sYYAQhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuV3jBZID9bgzGOt3ph4C7s7/LuZHnsLNtCzD7jEL4Y=;
 b=u+5p0pinkmPK9Y3bMoOPk/bfEmB0zBrwzzTmSaoWB4xXX7X9t0h0TaQG/xXCj93HylalJTB6jBGmtOWXfEkhEg6cOBHgNkZx8nnsaw0ybuhFYTxnSYT/bjR+1H67iJI4J1o4+PQBpvyuFfFrn/N3FUzcLgH89tukOsQWgs88dAtaia9zmJRn2HteUs3HOTIy8JSMrZmtnth2AxK8pqG3/gets5fYSk/FY0dldF/c4NgB/kKNJSqpnQ8UvHHBFJnreyazNV0VdgmwZfYa5soqZZM7SKLVmmnwY2X+l2kUIrvDdm7pRaxxmGXCrqSa9W4mUDs+nFh6e6MI5HSDS6gGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZuV3jBZID9bgzGOt3ph4C7s7/LuZHnsLNtCzD7jEL4Y=;
 b=qqmzzbJQJBUg3qDL7HPQ4OEnQSH36aEhTOpSC5WcEvVkGeviQ6gZUK4Rggu6r/Y2yaC3KYm/ZI9T9teCcMwoCzmwS1wQ6p1XSygSJ4HrA4K8PbeFJxTsvNp4ZXNZq8Zr9rLVy6NYkPKHWsrKRkj9ICQXIcNW62XiE+DRB4jNa4s=
Received: from TY6P286CA0038.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:3b7::8)
 by OS9PR01MB17075.jpnprd01.prod.outlook.com (2603:1096:604:40f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 16:15:00 +0000
Received: from TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7:cafe::94) by TY6P286CA0038.outlook.office365.com
 (2603:1096:405:3b7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:15:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD8.mail.protection.outlook.com (10.167.240.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:15:00 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 295513000255;
	Thu, 28 May 2026 01:14:58 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 7/9] i2c: riic: Use predefined macro and simplify clock tick calculation
Date: Wed, 27 May 2026 17:14:41 +0100
Message-ID: <20260527161446.48789-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD8:EE_|OS9PR01MB17075:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 90bc0a00-02bf-4d6c-8eea-08debc0b1a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	HGTOPnzfJWa5VB8xxGQTYtn2vsavFsJ19iExQzyI9KD9DHP/BKrwqaVR96qVDICr1vRg2WpYwck14VFYa/AI6RC+z8DRnAs1/6dXK1Wfk0tzTaEyIMhse+EGT/UsBDeIOqEYMi7L2aXKPtNLpPNOIHjFXeY31bH6o5r8WzBr4ssr96DmlFCUDMe3ByFPcXPzyUSV36Gc3bY17KDbCjpHSIMlsGf+Eyorb5LQX1287pzebZDhsv6WXrwGLQc8UEh4RNZpmAXg+UzfyuhibJNJma9GieXl6ldrzSC/FzQTGizA15hgBTcfFO2/1+8TLmvv44tIu/WWlWwStaRCXc9BNNFzmkOJSZiyBHSSfYsWa2noMHnFkTQ9eFOWqwHD9Higs0nCxKuZVkpnJz10R19jgEgn6aQ3XMJ4+Lz+SiJdR9AHcxpcZRqoUAhCzRi7ZpMkLYJHreC8gdHZpBuKsnfFP7PjMYe2gDDfXalL78/56840JV3xPEf9BD3S2NOccl37NIIv97K8wP34kPYkpFWGlt94d7BvQvUPlCHZGuIiszrYcKQYBEXu1OoxKPQRePod/RMAl6A6LfLIbNQnwb+Hnxaf3j6lcGE5f/ksAhppanEO3yl+fYXYfcKePbJJEKkxzYamMZVOnlBxZmSfv/l7nfJy4JGxhxqQDVVoD+ZXS1Ju4CEZ7lzkLB45Vni81+1KmJhFydIJYRD3fs8aEYynRey9kXPoqOougT2BnXQx1i8=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ZPqikjyKDta8oNn2cIFGzpE9D8TDDMjWOZEyp6sjAKnVG/k59U4u5nhepG7EXQIbXuYxVc1C1tfR3m2e0UFxIxLUE9rpJOkn6HWo/Juy5YJXIJtmMamSkvPHOLR62vEklPGMQVXQ70A3xkCrd0qGYDZLTT/oeXqQq1v96ZU79A0vO5fguokt1DvjFahFMg1aVWehwnz5XdBkd2GtGl4BBcXhBX1xg729QUlIftvK3JMioIVKojMzYxE0FBm4iWlkaWaqeVJ+sGrGTqyxH33blvlhMjwU3gqFKqtQPxed4FzfG1HfM9RLrlVYEEJ9hBlWaSh65Hm3/yq0hIihLQwDdKbqRO4HgPUiOxoCZoRsfB1nYQMCvLKtOVVF8MBmYs2roie4+A+3w+fkPAZCvOwuevJOVrbCCXft2sk4REKohl/W5aGiJopsiDFzVQGEtZ2/
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:15:00.4567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90bc0a00-02bf-4d6c-8eea-08debc0b1a4c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD8.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17075
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23022

commit 385bb1c2678b59db201831255b524a6d7f7a25ff upstream.

Replace the hardcoded `1000000000` with the predefined `NSEC_PER_SEC`
macro for clarity. Simplify the code by introducing a `ns_per_tick`
variable to store `NSEC_PER_SEC / rate`, reducing redundancy and
improving readability.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 98d5c2f512a3c..086f404859ffb 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -47,6 +47,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/time.h>
=20
 #define ICCR1_ICE	BIT(7)
 #define ICCR1_IICRST	BIT(6)
@@ -314,6 +315,7 @@ static int riic_init_hw(struct riic_dev *riic)
 {
 	int ret;
 	unsigned long rate;
+	unsigned long ns_per_tick;
 	int total_ticks, cks, brl, brh;
 	struct i2c_timings *t =3D &riic->i2c_t;
 	struct device *dev =3D riic->adapter.dev.parent;
@@ -377,8 +379,9 @@ static int riic_init_hw(struct riic_dev *riic)
 	 * Remove clock ticks for rise and fall times. Convert ns to clock
 	 * ticks.
 	 */
-	brl -=3D t->scl_fall_ns / (1000000000 / rate);
-	brh -=3D t->scl_rise_ns / (1000000000 / rate);
+	ns_per_tick =3D NSEC_PER_SEC / rate;
+	brl -=3D t->scl_fall_ns / ns_per_tick;
+	brh -=3D t->scl_rise_ns / ns_per_tick;
=20
 	/* Adjust for min register values for when SCLE=3D1 and NFE=3D1 */
 	if (brl < 1)
@@ -388,8 +391,7 @@ static int riic_init_hw(struct riic_dev *riic)
=20
 	pr_debug("i2c-riic: freq=3D%lu, duty=3D%d, fall=3D%lu, rise=3D%lu, cks=3D=
%d, brl=3D%d, brh=3D%d\n",
 		 rate / total_ticks, ((brl + 3) * 100) / (brl + brh + 6),
-		 t->scl_fall_ns / (1000000000 / rate),
-		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
+		 t->scl_fall_ns / ns_per_tick, t->scl_rise_ns / ns_per_tick, cks, brl, b=
rh);
=20
 	ret =3D pm_runtime_resume_and_get(dev);
 	if (ret)
--=20
2.43.0


