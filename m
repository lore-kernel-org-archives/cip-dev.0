Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB6FCD6E43
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:15:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24215.1779898502342748637
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:15:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=PJjlNQoK;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.6, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHE2kc/yHDrES6+T07cuCTvJwZDqocGWnXRonomlwiKDo5Ch+QFe9XSztyZbnjWpe14dnp6LGy2VzCBKeHsRNwMn2L9ezFYHb2xen3ZyNqbKGrj3aZkA/XhslabhbB0y7MdQaDFn67iaRcrTux4ssn8RKnJ+2QmZKvAd2mrd3rPoN7IITMTuwELT8aDw8yRguD7cghULhGh63HkMgar2ETI2D83X+l8Z26wXfiC8iqw0HLNVkhhV96KHV1KJI46RfHj3HnHgrFJHdL/E0TOYjZMNZLquWNqmIaLzesgoXTXvty2CxuSpdvY/kIwPS4bZdsBXCcU36/qdyQHueQEKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqctY7VNG0Ou+MXVZFMmUGTQMLYzGT8+AAFtfdbGdJQ=;
 b=JzjZzIK8pysZXlZ7DWFXFtmK+4bQB+xv3hqqqOzsfnLjHMYDjSVIlclNaaxM+j8ZgFFsA1M//OTeqkMUFNFA5ZerC3W+Czm1RW50Ocefvt1ISbSQqXgrV64NOYhiR0NwPTvV6vHB8t4VSuNB9wTAY74lOuXGBh/SxMMb+BnpwfSgiJn1s17w5sVfO6TTYjikQXlm5lmzHzEbcMY/z2ArpQi4NVY7Tji7yXAT4P8LmpuzbKDNDC+PmlDQmXfKg41687FGYyGzcppqfwKdgafjypU3FIxgJ1xI8Hl+znZWEFyUWESe5W81rzUttgY8MweJ7Ghxiwp+rMHdkbtJF+TzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqctY7VNG0Ou+MXVZFMmUGTQMLYzGT8+AAFtfdbGdJQ=;
 b=PJjlNQoKFJhQWX+ANg6YSxGjiVkxHI1S18uwEj+Xqat51jgz79Ld9ekDA2s2CWjOia6xkYL0kmAHA2a41I8DrpEX5MgZ/ValX3yEjoUuexE6f80rMSTJ/1AeD3zT4HMSDG0HIPQsTCUkOpjSpM6IeaoqpDrWd3qvxitqlLgHhu8=
Received: from OS3P301CA0032.JPNP301.PROD.OUTLOOK.COM (2603:1096:604:21e::10)
 by TYRPR01MB15648.jpnprd01.prod.outlook.com (2603:1096:405:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Wed, 27 May
 2026 16:14:57 +0000
Received: from OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:21e:cafe::72) by OS3P301CA0032.outlook.office365.com
 (2603:1096:604:21e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:14:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D213.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:14:57 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id D62633010432;
	Thu, 28 May 2026 01:14:55 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 5/9] i2c: riic: Use GENMASK() macro for bitmask definitions
Date: Wed, 27 May 2026 17:14:39 +0100
Message-ID: <20260527161446.48789-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D213:EE_|TYRPR01MB15648:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6ab295b9-42da-41c0-f126-08debc0b1867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099006|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ajmVwE5H2PdAUF6B3zSKSgiliB8NUTdvZjJi1b1pIjQTWJcZyUbVOI6yJzFTkmpC0RnRWts/6veCz6XqtICV+HeyNSQeDZd8byisCfr3blPPr7bZLAJiOa1/I/FH/SuV5t3YQdoJ25zLeko4Y+m14e04+QmVBjw5jV1AfyC9/OkJ+O0jsoHUiqzUSjxB5F6YslAU1cFyTnwreA+5DUyW166rEpPyycpNH3jlkqVmPz+1chsg/Tk9gd+9i3ulYKrP31McVLxBT84uGcQFbdbNjjiowZqPcWFfqX/xDHaxioLxFUyxiE9z9YlHR8vt9xQPfuDyA3rHqUlmadRWBGTeds7cWROMOpzFYa+0VyLSQzbKdy73/Ke8/RrmsxUUn6RJgjBpds7SXu5nyQ/JvIe22eNIxlrLk4ar5cGT3TZ0OcWjOCmuBbscWdWvmnULR+KKaxeji7r4DziE/tk3L8x2d0vYzKVoTZe/eOKM34eb/d8szdPL2dH8IGJONCsTf5vWFmmMyMSkqwieHfaX1c9+lAhxGiIAeFEDTfSp9Sb7E0VXDxUZZ2KL3JukQktfHi0SgIfw7HiEhW1Pv8LEv2/Zc+npHKJOWTerfsAGY5zCwR+giaOThhXSX/uxWPqYDXSn8yg/iAT7BqwMh2AhMipRwfUYppquqUWp3AWcXbo4SXBaBe8BGaRtRRD7Fy+XvMUZjRwN8BuVIuzyh8u8xanN8wpfbL+qvtBCRQXd03S4Frc=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099006)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Wt+6f5+NP7Z1aORwxyGPB76/UgM16NaGHMl8Yi6Udn58XlhdzEwKdsvtmipAxc3Tm+ImauuQw3fcc/VEN5iQoZWhf3wANamym3Fuv9GoDpSbo5ursRH1HS4Nc/pevuXKCdAOmLwuW9+fAxK3O7vEjte1mxme7NaZ18KGdgYpZWTK/NlpyVtlB/AeE8AZ4MGn6NNce8VzjwPpbNYLjYvf8rQ3pTbkUmoodQAH7z8ZRH1IQQ1GxkfgjMVp5ZLvOWufLCE874Ors7fTG3KuQpCoYzkpmjVO6oWSKUnxXjnSwHQPKOO9r7cqRFpTvEIR6i0XezDRpLIKTPMkkzTu4YSCXVdBccp4+MVKinsn2bU2t9xdw0GUglgHbHZxX2i+pp1GSnl2LpNckBEz6Cmq+kqdy35a6DBMngOg0ikjwlxISGzFH5GKEh5jSK7xhTMeuaKa
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:14:57.2661
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ab295b9-42da-41c0-f126-08debc0b1867
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D213.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB15648
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23020

commit 72252162258c8a0b19d5bd0bb49fe20495898d6d upstream.

Replace raw bitmask values with the `GENMASK()` macro in the `i2c-riic`
driver to improve readability and maintain consistency.

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
 drivers/i2c/busses/i2c-riic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index e3730b8730170..c884faa0d4ad2 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -57,7 +57,7 @@
 #define ICCR2_RS	BIT(2)
 #define ICCR2_ST	BIT(1)
=20
-#define ICMR1_CKS_MASK	0x70
+#define ICMR1_CKS_MASK	GENMASK(6, 4)
 #define ICMR1_BCWP	BIT(3)
 #define ICMR1_CKS(_x)	((((_x) << 4) & ICMR1_CKS_MASK) | ICMR1_BCWP)
=20
@@ -75,7 +75,7 @@
=20
 #define ICSR2_NACKF	BIT(4)
=20
-#define ICBR_RESERVED	0xe0 /* Should be 1 on writes */
+#define ICBR_RESERVED	GENMASK(7, 5) /* Should be 1 on writes */
=20
 #define RIIC_INIT_MSG	-1
=20
--=20
2.43.0


