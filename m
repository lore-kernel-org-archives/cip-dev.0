Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D12ACD5BD0
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:14:59 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24336.1779898498625332015
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:14:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VNGj+hNB;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.46, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z1dwqlCfK/I45aVcsUyFWP5Qu0JVW4XGF1fTLmNvocq88oWO8aNSU86OaJJVWB8l18/t5KpxZOuuxdO1Q057YG3+EYzqYhuHWRNG/b9NjEYo5PzyCQMBnm18bMwcJvtASsaQ3p8JBxTFiwRzzt8jwnxjmbKeWXzU0qVzWDm6D1QgG5kkLQXbqG/4xgvee+c37jqgvYb/j9mcUD2036TMTqwrGACsJ6iLQl3C9lGNf2LNNIvfp6zE+zCuyGKAUXVUVFwx1GoRUPmComvNDNHRTpMpweyiLC23kDrRXdOZ9mNVOd8b0uOZUDetPGU8OhS4KxWzruNAdTZFSR5ObR9HgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3W4pzoBydtpzOPdhJqD1JxkTBuTmvw4B+lnlIs4gSM=;
 b=L+67NRvQ2Dv4hsdOIcfbnIiG0phW8fZtD1xTn4knfSEVvGiZJsZzI0OQw0upW7OWMChx6Hcnrom/jBLZ/fuBprPsLae9t/Gee8pG3s1B+fTYz2IOX94NoaDgIjNObyeaxhGrmbC+mkCUPOZwoND2+C/yXjg9lh3JNgfh8GwFCaC5MyR3JeEpRfTMPFqi3XlrucEwA9PDEGMkOYJgSS3a80p7uasyXKHGOLQAXdbu8A5D1wy6K/H7vk8F4eu+ispzRCivT8ZhNzu2ZhnhpYJ3Nh2yoXEIjf2H8QEdi7wc4b1nsLCiwZNrTGx1GDEmhlAEzY2LSPvFDp+0oP8TTezbsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O3W4pzoBydtpzOPdhJqD1JxkTBuTmvw4B+lnlIs4gSM=;
 b=VNGj+hNBqoNbtCJlpbKRGJNFI1Ttzbst2Zg5da6YKbdh5816aD7dJ5D2dMwtFU1r8gcBN9SmvL9PO/hL5N6XnRJ0FyFoLiXVLnPCB1H2uJ1xjaTzZ3xSoX8GzlgaZoW/xfxc6EMikT0JJ+bsOplyoE6pGlMbwMmqzsSOzPKrkds=
Received: from OS3P286CA0105.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1a4::8)
 by TYRPR01MB14303.jpnprd01.prod.outlook.com (2603:1096:405:223::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:14:54 +0000
Received: from OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1a4:cafe::a5) by OS3P286CA0105.outlook.office365.com
 (2603:1096:604:1a4::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D210.mail.protection.outlook.com (10.167.240.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:14:53 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8DADE300025E;
	Thu, 28 May 2026 01:14:52 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/9] i2c: riic: Use local `dev` pointer in `dev_err_probe()`
Date: Wed, 27 May 2026 17:14:37 +0100
Message-ID: <20260527161446.48789-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D210:EE_|TYRPR01MB14303:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 650e1d2f-e384-4273-80aa-08debc0b1668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|6133799003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	TSDAp4mSwJRbLurs8ypP6oNBu9J347i7Z/d7OIra46B9wCc9xAX65mXdvSmEqFxyVR2iR62wjQQ1A/u7UuYzFrLehr9YjOO92xycNyPciCIHNSRCrXWUWgJhy7Tfq0928dKxRUPyjfFJrwGAxrDnlCQWY2f2jIYlk2/Kw8ThohFYbimBjROhCKiPFumpe8y1QgWjCbzpyu1zl22eQaYBbIZ0QTHUodeeamqi2GrMdAjKK0uXK4ryDGWLYgYQNIpfQ1P64Ewk0Y+OD30/8RIHNluwjbZieYedSXbhW964N5jn6burDtFaYMn8ef9UNoTogqlFjnrE4mPoNVpmCZUxaVx9M+/L3jhozTC4gB0eJz9bO9oMwlTfDQ2ZNI7KXxSK5TYkumU+9zYgcbGFUUC4HAbMSJWivsc8KpJShRb/8T/FUvjpCu3NnFQLiYBNSwaS8IzVGbYmcoRZoY7pGo7Uewnf8ON2HwTOOC+0zqOtINqRMhfZmilnVLDn0Y71kvYFeYW5bfgqKgpVXP6A7kvTb2QmQYv4v/flrCnpbyc71B5HvFRv4ronGrJRpksSg6bpc/TAF+YmS/e3pRvGEXqg6pXJr0jN70rz4kWBLhHWG4EL2vqkW90lGAu3UeQ9Ps1P4k27/ShDTsusgT2I958T7fq+B4NpdU4FZn5Q/IfYnjyfAH6Bq3ccl49skngjQa8yj5qUvXZVutJzBd92QDC8yqRC0Hp23cxqEHW6UBu1Wtg=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(6133799003)(22082099003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	9VwSRbFcg4tRdxReVAdrKVMDVqxUltFhUknH1tf+V250R2ijbiJYbXX0gLQwWBBblxoOdEVNqrIfryPNB0CiBll9ZPWccKOpeHWTPlresX+1iFDJq8G3zSCWNV/q0h6aP1kM6KxgIOMbWWkNXokmrcVVvjsf1ZAGNrr+9aNNsX2vwE0atiYo0XvThrLKpmP9poYNjn1EMxMRp0u9DIm0QIx5XZt54ibDBBebxxw+k60tpbUjhAMhJFN801tz7LBHYzt1bDhGbiLVVm6sd0KaDwS4hhhMIooaXLeV9HNVR5pJVBXy0vT03SXuWPPswAx/13deCcgj+H84GrKmmYczI+YZNr3D5v7dsswda09QmgErHBiTU66mxi9eGGUFokxl9BnKAispNgnZ2W8iGEc7bL9/EYjoKqRHkWSQoonhhiX+7EUk34E4FG8MzvXNIuYu
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:14:53.9156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 650e1d2f-e384-4273-80aa-08debc0b1668
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D210.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB14303
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:14:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23018

commit 279c83db24552e83caa09347358473e633e56617 upstream.

Update the `riic_init_hw()` function to use the local `dev` pointer in
calls to `dev_err_probe()`. Previously, `riic_init_hw()` used
`riic->adapter.dev` in error reporting. Since this function is invoked
during the probe phase, the I2C adapter is not yet initialized, leading to
`(null) ...` being printed in error messages. This patch fixes the issue
by consistently using the local `dev` pointer, which points to
`riic->adapter.dev.parent`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index c4a85f8a5b874..521589cb5264f 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -321,7 +321,7 @@ static int riic_init_hw(struct riic_dev *riic)
 				      : I2C_MAX_FAST_MODE_FREQ;
=20
 	if (t->bus_freq_hz > max_freq)
-		return dev_err_probe(&riic->adapter.dev, -EINVAL,
+		return dev_err_probe(dev, -EINVAL,
 				     "unsupported bus speed %uHz (%u max)\n",
 				     t->bus_freq_hz, max_freq);
=20
--=20
2.43.0


