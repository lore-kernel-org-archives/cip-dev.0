Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2DACD6E4B
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 16:15:09 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24343.1779898507332111061
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 09:15:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ITWA9fXw;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.67, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEi68+m1VaigQ4ZCXpG4vJHyWVT5gQpsm2RGS8u8PdZdDJIqNYtcZxDQn3tyOZ0PVimHHpo/DnNwjPU8uXQXtxXPiE19yaHD58nQK9A9kF5RPXyWb5hm1+tG4mnJcYoJ98JIhIo2vT+qyOEkxIRvfQm6edcejruz8CL9JHdQrL3Nb8kr5901+YmarECnV4QrB6Fm7GjJpsamcNyEGUgcWHZdP4DM/JAX/DaOni377UpQUHUQHzf1YYjbDqSjirNVPWPaHLx9x/SCm7HjCpYjCBKWGoFotILml4gktNQvSAFkNUVUnkaG0c0NsgoJgHeVVuRBOe44C/PCIf5hYB46lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp4svmSep+q7kiMkjdBAMaNOdA6UkAZpMftt9pPPrGU=;
 b=LvKyNQzJnyosgTf1F3D7Ah19t3phs/FX1gQ3u3re/jY2Vh6OfNndwyLXC+qnW38taZ8vUOMr+O/xaqZ2tdfloGTPGalVTJTlzNZfqKPa2BTfPiLpurB3K4QV2Q6TuDx0b9HMv3OOLdiBVly89Uwt0DGOncWYwoGlxOO5tOoOyo2IYIDe97dypvra3Ml1CEOo7G/7qh/Ovf+hypIlmB8gqrI5nyv+UMw9hsIQn/S8KaUGaD46+dqlnoXw4wi/nOX4gQIIyteLsgb2ujUf0qfgMXFaS4y2k00qkJHOXi8ECWu+dOrL4ZyA4+phowDZtIaz6XU/LUSScSpqX74N+Ksb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp4svmSep+q7kiMkjdBAMaNOdA6UkAZpMftt9pPPrGU=;
 b=ITWA9fXw/ilUG3TskKZkXtAQkG9Ba5vWRBmrZAqjLvF4aPlQI3aw9TgYRXP9P17nP94Twuip4TFmj4mFpotJCJynvcDWMrq/Vh3c1PdB9xgNNboarPWuVix09icIZpFjmeB/xJSeat4QhqnSqzGwgLA5abDeqZX4h2pKtvCmFJs=
Received: from TY4P301CA0075.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36f::13)
 by TYRPR01MB13068.jpnprd01.prod.outlook.com (2603:1096:405:1d0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 16:15:02 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36f:cafe::2b) by TY4P301CA0075.outlook.office365.com
 (2603:1096:405:36f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Wed, 27
 May 2026 16:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 16:15:02 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.181])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id C88663000255;
	Thu, 28 May 2026 01:15:00 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 8/9] i2c: riic: Add `riic_bus_barrier()` to check bus availability
Date: Wed, 27 May 2026 17:14:42 +0100
Message-ID: <20260527161446.48789-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260527161446.48789-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TYRPR01MB13068:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8469dce0-c504-4ae3-ccee-08debc0b1b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	9Qk61KFYVApe7ilhYvuLzHsQENZ1S23F5/W5+jyL4SEAXg1zUnYNB3rvyh/uSmGktie7LGj1yRbKIUp2MROSLxCGUVuHaI2XcMq1usXDIRTuwLVdw3KuTGgVWhq58tuiAzhXqXVkltho5EP4AN8yzK2TwqrPH8QojXIp/XpIqLyXB56/Qxc5FHehRwKFhCggnA31aYhxRdziBAQRSo2RySuLBkxpWv3HUVqmsH92wXbYEDUYGm6GcBJ+MYkxcap6Ti3/lWi0OM05idgWxJatO3FAkLS0L3yBGh8u50r7KbAa87Z+9BdQ46wIsD/x9SXnypxU9glWJ5W9SzJHwRQnUtCDuGM45Dg8AsvmnFWBQS3SiZ7JI6EiGlgO53zKFBcFW/h/V5mfgQJYcOqcbi8R+1yNCDYcWyO2Pi/2/x+d3ISGHMqbsxjxdURKSUymEUtoBe6L4AAhNL8jRWYR2KcWtkcM4ikinAkgLzqv1bPtBT38EzuL1CxetSOOkwq1Erz4b36IS24obYE5NeUKDD0rJEe7ZFSyM7DNAEtvCLckmDEV1bRHj7DhH9xHxyNLiaBGGJFTOx5/0nIiX7UPIdQpqmG1dNPFlJkckgMWzpE4hnXnKrXQ8w8sJrH+c5VX6oO3VAlG6JJyvZ2U8HthMl6h0fZgYVcU/FqvI22o45NnFa5C5I6rVtw4gL3UP2GCaVchVzDxzMKXouADTPvkFQy5BYuhi9lO1nY0GipXJO4T1dQ=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	ycyRSaCAN0zkuBlwSMkoBDE3Hxt28yVaCKW6hWghTmUFALvl+N28oPcq70RZbNVgILHEmZjSmjPBKdHhk1mC80seAuCI+PzGPKZosA6jU/uB8I3lh1Z6MAk7u+FwC7w/AdSKTeAhCj2bfchhigyXdYD3nZl18sy2dYxwBGK4YfL+SVAcITT81rJV7tvVCBxDa3i4uK2bjiwK/V2XM4mSZbYWIayx1FEv8YvqYrz9WHgdmiv5vBr6BXmiuDOCeiUWdnJWfcoGuj3QQUKXsZ/ib2LgWAk/WRdi37FhkxkcHHkDnzzngvhBK3gZzknzHLI3d5waS4RKYVOj8vDmga6SQKUJsCyk7Xp8Uc2JuluSGR9GEmvLoIjWD/qIOXLEeC09d2Fq0dLGpDDHtW43jEzbSQUkz769R4pQzvAlDKDsdREFWIYnSlaz/Nl2CAPretqe
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 16:15:02.1154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8469dce0-c504-4ae3-ccee-08debc0b1b49
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13068
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 16:15:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23023

commit b31addf2a08bc5c16dfd6eae8785546f3eea92b8 upstream.

Introduce a new `riic_bus_barrier()` function to verify bus availability
before initiating an I2C transfer. This function enhances the bus
arbitration check by ensuring that the SDA and SCL lines are not held low,
in addition to checking the BBSY flag using `readb_poll_timeout()`.

Previously, only the BBSY flag was checked to determine bus availability.
However, it is possible for the SDA line to remain low even when BBSY =3D 0=
.
This new implementation performs an additional check on the SDA and SCL
lines to avoid potential bus contention issues.

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
 drivers/i2c/busses/i2c-riic.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 086f404859ffb..0bde3c25878f9 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -41,6 +41,7 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -52,6 +53,8 @@
 #define ICCR1_ICE	BIT(7)
 #define ICCR1_IICRST	BIT(6)
 #define ICCR1_SOWP	BIT(4)
+#define ICCR1_SCLI	BIT(1)
+#define ICCR1_SDAI	BIT(0)
=20
 #define ICCR2_BBSY	BIT(7)
 #define ICCR2_SP	BIT(3)
@@ -137,6 +140,27 @@ static inline void riic_clear_set_bit(struct riic_dev =
*riic, u8 clear, u8 set, u
 	riic_writeb(riic, (riic_readb(riic, reg) & ~clear) | set, reg);
 }
=20
+static int riic_bus_barrier(struct riic_dev *riic)
+{
+	int ret;
+	u8 val;
+
+	/*
+	 * The SDA line can still be low even when BBSY =3D 0. Therefore, after c=
hecking
+	 * the BBSY flag, also verify that the SDA and SCL lines are not being he=
ld low.
+	 */
+	ret =3D readb_poll_timeout(riic->base + riic->info->regs[RIIC_ICCR2], val=
,
+				 !(val & ICCR2_BBSY), 10, riic->adapter.timeout);
+	if (ret)
+		return ret;
+
+	if ((riic_readb(riic, RIIC_ICCR1) & (ICCR1_SDAI | ICCR1_SCLI)) !=3D
+	     (ICCR1_SDAI | ICCR1_SCLI))
+		return -EBUSY;
+
+	return 0;
+}
+
 static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int =
num)
 {
 	struct riic_dev *riic =3D i2c_get_adapdata(adap);
@@ -149,13 +173,11 @@ static int riic_xfer(struct i2c_adapter *adap, struct=
 i2c_msg msgs[], int num)
 	if (ret)
 		return ret;
=20
-	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
-		riic->err =3D -EBUSY;
+	riic->err =3D riic_bus_barrier(riic);
+	if (riic->err)
 		goto out;
-	}
=20
 	reinit_completion(&riic->msg_done);
-	riic->err =3D 0;
=20
 	riic_writeb(riic, 0, RIIC_ICSR2);
=20
--=20
2.43.0


