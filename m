Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D81FC982D7
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:14:21 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.2])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35282.1789636453021738967
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:14:13 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=GON1DhKU;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.2, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y131JhDBvS0h8XixFvDVrHOfQaMHwKrqxwwoCNYzoKUz7qtbOaBcX9/YQ5RhuMe1AajVN40+jI3sdDC7rRCM9Gbms5ewVfnml6G1+NiUdl5huLRzu01GVsIvaNPJ2llTr5wllIbTB1Fk/wfNBp20IXdCcrLQ/tuUqKbB40y/x6H2p6gZHl7RZJMRwxKpsBVAedCVVXfo9aLXkVcEZ3e4AQbnNnO+QTDO2wfMxuV9wDziGjYWSsIKhpc4n4N3U9gGZoVMZsWdhbbNJJ6u7JdefkRHOQdFzCNIzyO0KSVvzsEmkdtnItdM16YJck8zvrL9bxdaBPIsjOg2Sc5SsQrEVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6Ut8sASu+LehBqkQZ8e8+dfaSprgAkz5YGDcPGRQEE=;
 b=OrWOUZVeZoF1+Sg0W/Nr0pP8ARS0rJbMLOFBGGnEZLQ+KxQi8/jFBJ9TUW99m0UY2ksX0fSpCWBW7tgemV716f7vEYuOK/DALVcmyMpMz1ttAd4KxxvNd+UybLYZ8OU83s4IbWZpqHxDXC7PUew1VeDMmcK05u/qZaCqcfsD5CsjyHRl3XuPstEMEIKsE0ETLCc5hiC0Keqr5xZ2o2ANxVWyXblZUlD7VvDcbkXuNNxe+i4SB7uVD3JUe7RAItbBR/lgrU9995cLfRLIcnkhZbTda6bsGt5pxuOP1SH/IfLLj8RTwVvJjYXoiNntDPmguSAXDkqSAz1XHjGNc+X/bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6Ut8sASu+LehBqkQZ8e8+dfaSprgAkz5YGDcPGRQEE=;
 b=GON1DhKUC7e6E2eRwsKwenoC7hDhbBbvqfD2S465DUp1KfEu3G4MxRnGFearai6oTrDkkeTrQvBRgmNFM9R3Mjoyx2SBu9wZ78fjAsS8gAuCOsdwosCbHYKNNZW3TO9aKgyAt+BC0F2n+Ihmwzk4jbGbjFK4OxxALy3GhI9dZLM=
Received: from OSTPR01CA0075.jpnprd01.prod.outlook.com (2603:1096:604:21a::7)
 by TYYPR01MB10547.jpnprd01.prod.outlook.com (2603:1096:400:30c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:14:07 +0000
Received: from OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21a:cafe::a4) by OSTPR01CA0075.outlook.office365.com
 (2603:1096:604:21a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:14:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20D.mail.protection.outlook.com (10.167.240.36) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:14:07 +0000
Received: from Ubuntu-22.. (ukr-5cg3160n5k.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 5173530001E3;
	Thu, 17 Sep 2026 18:14:06 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 03/10] rtc: renesas-rtca3: Fix incorrect error message for reset assert
Date: Thu, 17 Sep 2026 10:13:52 +0100
Message-ID: <20260917091359.18445-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091359.18445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20D:EE_|TYYPR01MB10547:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a6171484-8c59-4373-8a69-08df149c072a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	oyn2ElHYVBRDN9sT5YSLZXPm96oBZbbL0N8HdMCh7HNsTXdNUPYBcGUeyR5JoW9qbOaidxZpXSQ4+heSjIeG+VzlvBxc4GD6BnIG9WBSFZMNCs+JTZHF5Ol3QR3CF97GjdVnV/3v5Anp8feb5VSLLrpLBcQKeRofRyY6jMb7Mw0pyQxubqKtbG+EjgnCw9NlYewm5EemPoT/KfLm9xdONdw3Ws4sgvp9PYP8R2ADz4khzK444kpKInQQxZuWRGNPHiNV1M4UhVmnWCSCxXf4OWyjnmBhb+RBa1IDkhT3puIGdXgjec4c+bpfNZDSu3d/7UUuCfGs8QiZgpiJW7UtQ9sk8bkZkufS5K0jgh+40/1//di7hHS6pM7vwtGkXH3y0MqdBiPcZMeWS9+DjEBUNrkGOGzXjf3Bf28GGdpstDyRuVoY5lmLMcHYFYmSmvyCP6ZTPjO+9+ogGmL+INppz24KB6phfAnATfKK7QfS5kTHMxHx627ZKLf4MEaFs/BddzrDtK9VKu+/OP1SfULzIARSYLUca48XS6IdK2reRftOHYeLEfE/fT4sO/TeQwYwhOAHZBDcJSPBSJtuAze2E8NoUO7f2OmcgbmpqT0hez/vbxbj1k3oB37dq+CcE30+ei17rJN37iiFJmuHxFI93g==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	JFc2XD7zy4OEhmA5cJvhOkA3ikGEc9OwmRfd129dIuoJQSq4GTPyxrTIHA77KBjHnDESoZosBzmE67byO7UXOn1BdCUhYyU/q3Xi6nDat49t6P53aowiZrMErMWiXV8Np5KmOFmq4Mmd17THSoRGV342W2qj3MAw6/JE5STt6pl/aUXUQZmohDbT8JIlL0/cq5pweD/clnbkucYXKxxNLN5tcqHPKYyBSCWB/bd9GAyrVjdSpq8WVeLmxnvamIJxv/JAlAt262R7FRp3bng0EdaZazhicZF6n1aFTiHfdqtvyParA1Jbrxziy1mnzIBU5kPqgyHWWK3cOjZThd/DNawSFdJyEm8y0WsFqlqI74M8TwGukw91Wd0S5AnC5kLWKGoxt+LKHYo/uaBoY0G2BH9VkvQm8TgHFNCb3RZzfAS3fLYArshOKLfLoYZw3KNW
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:14:07.6937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6171484-8c59-4373-8a69-08df149c072a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20D.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB10547
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:14:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24200

commit 09939630aad95fc3dc4cc2d94a5a96d7c4d6642f upstream.

Update the message to "assert reset" to accurately reflect the
operation being performed.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://patch.msgid.link/20260602192559.1791344-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/rtc/rtc-renesas-rtca3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-renesas-rtca3.c b/drivers/rtc/rtc-renesas-rtca=
3.c
index cbd040272aa91..c1e07eaa4c4fc 100644
--- a/drivers/rtc/rtc-renesas-rtca3.c
+++ b/drivers/rtc/rtc-renesas-rtca3.c
@@ -702,7 +702,7 @@ static void rtca3_action(void *data)
=20
 	ret =3D reset_control_assert(priv->rstc);
 	if (ret)
-		dev_err(dev, "Failed to de-assert reset!");
+		dev_err(dev, "Failed to assert reset!");
=20
 	ret =3D pm_runtime_put_sync(dev);
 	if (ret < 0)
--=20
2.43.0


