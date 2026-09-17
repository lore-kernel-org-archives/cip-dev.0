Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F72C982D3
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 09:16:35 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.12])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35312.1789636593202281867
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 02:16:33 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=A+g0QIow;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.12, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uTr1IwJ0wS3Wv/MQFfu+BpirebjvsZFdL6Ed5fx4EOOkDPtx8Es55m4yB0GZIVGqWuZ8H0vV3ASKqDK4j1fczTRwP9Gn3pkVXnmVnPjyLkstcrcdxwKzSiLEQhF2SUPoeUc8uBbGS0icu8YfYKYG5zKcC6hzNXOreQn2pOPGK6tveYhy1RNS5P5beFCnoTxZL26h+lBQvED5Foi2R6w0azOaGEbfzubmBm0C3bULrtii7rHOr4EdXj7NwziN/QdaAkglowG0Rc5Yy3voR+b90qOfno8KUNnWaqMaDmhON6xmASQmRdrCSZzm2gfgJlSjbnsSGgMQw6lYBCr48i982w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVGS469NCQA7x+mOE/2LLJoTL9gEPwB7oH9mLse8THQ=;
 b=J+HPPE7E/Z1jZDRsZ8Jct5mHNk1fsG2+BOpGCq+L+XJDza8dFxh74TLIPq7wfY5X0gyKVqsgJYTplmQFrAmkjdhftWbk7vQXSjgLMQeFuFWotTLIKvG+U9lEIOlQ4PlmzWm3c2ju4asU59Err/eMlPCQOBnITXDkEdOnpBGia6BiopeAUHCSRx2e6Q0bZdiefI/frWb5dx4bwVy/5U03HVkPFzT+aiIIfdKBu2YRIN4oJXfNA9xL4DLKaNhYqbmJNCbnZVMzpJBS1EHceTqxRGw1AohhsiJHiaFkDotZvH29JE0n3IRV+axHeZzBAFPLX23oz/zRSznC9CXU8P4hzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVGS469NCQA7x+mOE/2LLJoTL9gEPwB7oH9mLse8THQ=;
 b=A+g0QIow3NKkJWcQgeeQIpCS7RWH+kuUUQx8GJno3o6tzSI7CKe4Gdx7/VnzD7Pg8sN+uj3K0VtZrY2yFKsFeTiFWMdCKQiuQSMD4GgA0MF1gQdJMSgnAWygoGQE3zoHd9XsCMAS5TwZScRE8R4SRV8fEk6puK9wBDGmjPPESKw=
Received: from TY4P286CA0134.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:37f::6)
 by OS7PR01MB14907.jpnprd01.prod.outlook.com (2603:1096:604:397::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 09:16:29 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37f:cafe::10) by TY4P286CA0134.outlook.office365.com
 (2603:1096:405:37f::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 09:16:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 09:16:29 +0000
Received: from Ubuntu-22.. (li-hr-lt-dhl.diasemi.com [10.24.0.21])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D158430001E3;
	Thu, 17 Sep 2026 18:16:27 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 03/10] rtc: renesas-rtca3: Fix incorrect error message for reset assert
Date: Thu, 17 Sep 2026 10:16:14 +0100
Message-ID: <20260917091621.18551-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260917091621.18551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|OS7PR01MB14907:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6f3ead63-d30a-4af8-92a0-08df149c5b7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	QIRHbtu+kf0BT/B0iTWBp0bgIpjb7pnb3kTEx9cYSzUQogVaeZZotzP7Kxn8XouBsSy8fzqDykvi5wEof76/tLqbGmlGLgStIQCzgALf8gcDyYj7BZ0U2xR7cIaoBGjaqCw+SRMH3IP8RWEGeSjns1p81c7s9ZvO32/3vRXZNjNHXYK2BVz3BTUYCMqEn20XeRst9cZClLii+G/PDZNvTsty8GYJ1tWXkWPFC4ThINkX+0vMCkWMcIQOxWNDmT/QhVHnlkXSFZ2zVSpkMSmvweeWv0P6z+1lG8aN+Ts6kmYeVoaBIkFh/AlGzCMZQIJRnPRG1gpC7u4LHOoKFPv5nqCz4l20DumCD3/hJ3wXzhmOaYvgksE/tREkqtHbXpBepH2PEfsoYjYQwQqc0e+qg4hp3Lk6oY/8OBkWdJwqDV+isRFkaLIMeNabKOG+rrJ0UqBaSWXq+rPDwHmn3gyEV8zdvmfjMe9fuYz4JleLd/7N+rJNUX1vcapahxs9csxiJN+PAFrKZYJjl0aMU4z+o0LiE1CFcEi7MsIP4PtvlzolCDGNNi66GsS2eWuOTMcXPZg1KTgAoFDVBn8bn3TYvX6/IQEA4KIs+c6jB3qwDEYNlmFsaYFePsOZILqDIIKmtBiOJnm8q/6N+ZQRP1HWXw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	R+scbicEi+nAdS8LQyDZWfnPtzrWuWoCcHjX2mgfU+5PSQBVhQPhcJwaPwhVD1bU992Ygz6QC6SEmVsUqsxkjapS30zIvth/tLGFx7btv51ckR/mXQ3Kqio47lb4qbvYcqCTCu6SutzHJQFbtE1ceQhHJm0OepqPJWdFk8pGQkqt+MfHgNUIBwSCNp1fO3e/wOp1UwZWnE3E7N3F0Cf01yiSs7bN9CW2eeHejN/juSYEQ2thMsTHeEYB5fapUKu3RWxmO8eb57iX0URWvBUpwB/NI6WXb30WTyyXyE/dI/HH+/JUEXit0+gPLLXITlsY2TRzqeYVcEcKWUwOjiaDDWgkvhc38Y3TCGiN5a+TB+qm3Qt4pGK/ADw4HCLu/SR4iJPMvqOcVtzwTLbebOrIxfwWTQoF7cf2WhX31Y/FMU1IdLNiPB7X1ocKmu64iXDW
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:16:29.1616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3ead63-d30a-4af8-92a0-08df149c5b7a
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB14907
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 09:16:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24211

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
index 77739a40419cb..67ef344562884 100644
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


