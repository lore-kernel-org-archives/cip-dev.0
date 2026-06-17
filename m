Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86832CD98E4
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:45 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10766.1781685098132520261
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=ThItuAhL;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.62, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AQHXaP4OB8jV269z0IbRx6ARPe9oTS5BpRYSdTxOvaVjDFEe48YE2bxWaKJX+zKtbDABr8KNe75ypGivxSo3D02cOKzE7POowFp9/qiSw6Z9bsy70nkqN2IVR5esKl57JBqS7J0YIyyVk3rww1Ra9m9SWahtpE8FeBBTY6UP6rKaUv8qoDI7fD81gfae2RgrpUVDx0VHtDNPJjDhRXbLAcIglk2MEkKTxvE3Uw1DY0SizXKNPoLy3Cyrq9xTcLRHEIIrnvwNmXi5FKjoiB3KTCnBxDn4cWbyyqr1NvCuJa/oB9l0KYMkjGm0Xokw1mxpDaSIAHtVjkpaCIKyYOYQMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIMlizPeFsuqYZBHGJ0iHesQJkxg26WyCdiUgP7ZcnA=;
 b=HOc10zwHFUVmhQHcVRloU+m+mAN7FHJUGDGzEVrobplf0BwW2iQ9LK+An0qMZ325eH9EET5UwEcGwupmSR3FrMWSKzTERcb4FrkGdvNt1gojKZq4gIl2vGS6l925C2OloCM6hA464lIS5ZGUvFYgnKtAOZb0ac+H+e5YaP+EPVV/MaAHN13+4/CinC6oMjbTJFjOfYZKXBLeTEYIYo5+3XFISS/+dbNtUGEYaQ9qBG3MUbo0xxfxqLaZzTbf8ytooXVlCOaKUIrSl4HQyvq55pK1O80AKSOMQbh+AfVRZtJKbhiPZvKv9dPa5UP/6JYUl0LNHPJvg5957M0w9sC9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIMlizPeFsuqYZBHGJ0iHesQJkxg26WyCdiUgP7ZcnA=;
 b=ThItuAhLiZgwVo8OCrZ8K+H/ZUvjQcahRYq+tX35R9DSracrS3NSx6CsLlolBL/VyTAhV9qXJRSyokzISHGmlmaGdX1VroUp2/u+hzZJDJKi4D4pX5KEOIcLW9eLHMdoPTX1hczqPK8Rn9p5VPszU+VAn9BK0UwdrCJmK96BoJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:35 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 23/32] spi: rzv2h-rspi: set TX FIFO threshold to 0
Date: Wed, 17 Jun 2026 10:29:54 +0200
Message-ID: <20260617083003.1071543-24-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260617083003.1071543-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSZPR01MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: df05b5e5-4f7a-4200-b330-08decc4ad7f8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	8eHZVDoXwh8P9DnfXU0yhZn/U+qIYdtbdCQvnLtMte8zQLKseCypyVaeGOYREgFW3Pd3eOit4wwLJBnynn40OTggJpmY+qPBsDrbj+FhFWcN4zMg2OSQnbGy1WJ+ToH+RjAe7Yj+WVkFqiAlKspCuxOGEipATzdIAB/qG8F2KgaopPo5hTRYAVsg9Y6Go9pqRXqfIqUxX+9ShGg6bsacIcwdz8YphRBEIVQ+M1gOczTj1nVy1KL1EBPZwsLLKJwlPg9gaMRRWW3L79VpketKkDgzQ/2vyPqjGj79d4jAytLsbKFkWZXhLHanPZ2fSd2fjf/vEav5TmB9V3z0gwXup5X87983it/ZKi8u28ghbEK5OeWKtMa1sfGtrD+cAU55JZifCyKu3zHG71I37j79VJhLESqNKg7Pf5LOULP27QqdWcOcSIcqUW1fflJN0HmphsTGhwAYg/t3SttZV78UGeWGm+Felegs4jqb2vbhC2bg3pl2sYRoU55Nz7/Xg0RM/t0/9s2c5bL4Zq7hj429EpqcYdGNNATeTqTEClbvKmNomDe8zXdx0iqHJrwrzxzOyXbyHrKdcpunYF12xECx3XMDVGBkNtOkva5Axli8yAtMAQLoIJ0plBMKuKUud7Do3t/u2gcyDGMKzqi4v0ONlo6rHzAkQjmffd5cgKJBRgkxmYCLuk+fk8HcOG+Eivd3Z8H4EC4NVwrwInlqdPcRiQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hhPUV7Q5CBxZDAnLgtLzqEliYcNIuzL52JaklasCwTHscEqjqAY5eQz7pXty?=
 =?us-ascii?Q?oq5jI4Pg5p6zjDIbhqV+pTauLnQQnEBiZyLuqPZNEHM2tHmB/53VAJ274dJq?=
 =?us-ascii?Q?mH40oORYvLBMpqNw/8W8zipoOK46RGaXMl+V3JI5ku87zoFMqSL1DSYAr88D?=
 =?us-ascii?Q?iDFagEq3ZzsPHEQ/MP4Jltd2ZZZvaMg2zcDQXRLp5qOAb48DmJ9vX8A5Wev1?=
 =?us-ascii?Q?zRrsBv0JFcRxVMlMHfAjJR1z1DJX+qeUk1EHV5amvvX+wUNJWdWunVZ4cPO1?=
 =?us-ascii?Q?JTWaKvHgFHrII4NPDIZhfSROn6Zilbt2BahLIDZL6CaXqrU5bYMYjfjAptsp?=
 =?us-ascii?Q?8cS+/cwPI8Nmdd/yCZsd9VPKEZcE9TwpwyZOgW+sUXBe6dlX21bqTF7L1I11?=
 =?us-ascii?Q?5J9m5FAsGAjqux7++wuO3jaFZgUwZVTkw1KbT2YSSxzZOlE1kFjE/vdf0tz5?=
 =?us-ascii?Q?3W0fn/LlQiYw7mEoGLS0EQXouB4YS/oG5SLA+lem+4kcyPo1KAsVATwpcobP?=
 =?us-ascii?Q?klWVhmbbvuG5IJM+qUTZStZnqs4uGylIcuM0FbMnVyPat4adTdI1L+3H8Uj5?=
 =?us-ascii?Q?wuUECTwjkrdg/cuiiz7g06t4o9IidRlsYf4ITW6zlEhgnt6eRksraes/Vyc1?=
 =?us-ascii?Q?DZt1ZS4+A2Bdc3xD5/P2oRmSoWok3DnmG6sGZtkyyQ0NFhsVeIFpvNzasUPj?=
 =?us-ascii?Q?yDfzmL31x03ISEmXP4bNH3mM8poP/KfBrwLDeBEdZSc/tpfdKwq3v/XjSsw2?=
 =?us-ascii?Q?rm6CO9K78lTuNdHLVhw9UHOf0X3Lz2ZrpNOLcJTQJ5EKM/jQxXrTSklvXlyq?=
 =?us-ascii?Q?5u7GKwVJ7WUvpbOXW/Kaln5xeZKqxKCAoBZUwaXKL1TzOIIlebXSD/z6Yo67?=
 =?us-ascii?Q?YmFmrML4Ypw4LoFmibaYyTVUbOsU9sJFOhXRE5zXqhEQ0QgD20YKKtciWkFl?=
 =?us-ascii?Q?x0d0YpuCLJEOUx1uMHYv1pQ3FlC5aI36L0suR8ltScmD46Osv99r4F+YdRSa?=
 =?us-ascii?Q?6miEjInUj7KVkNG8Qw4dw1OB34Qn4AX4ObLkT0+vAdDOjMvlpoYb5gL5ycQG?=
 =?us-ascii?Q?50/lsFloli6DaGU4jngMP5zXUyFH3Sltd6p/AoY5RuTz2nhctvh7Y3wbfQh7?=
 =?us-ascii?Q?ZSjq/vcyRnQV/fyyITew2r7uFiI+ZqENAKqsY5K6NYDoDDYdGi5kMLDZV4Yw?=
 =?us-ascii?Q?iwPczQZTYMW1Swq0J7N5A+wfSQLMuU/lm0kW3S1OIZhcxb/aTlhft2jxPyyC?=
 =?us-ascii?Q?J29ZIx5t9ehfsBOkOn2XmZ6cV5uEkNeGBdmeymd7/0uMMbU/ZUMjZ4kebVWb?=
 =?us-ascii?Q?laoDO1XoT6nvsURIvneCGZZ7VVlQbN6DWcnVAKVIAjqgHkWS/zKXmWRVTOIv?=
 =?us-ascii?Q?ChuhQy0ID0udIwSDafp1f7wEPYsRyhf2Zjs5anQcre+AE91TJYq1g9lQplVo?=
 =?us-ascii?Q?Qixf3w1JqouIw1RyEY/dZ7XQdU6jXgRsxLGpzSR4OnlSvP6aF/2Lq9l3hyGY?=
 =?us-ascii?Q?bA0OFyX4/pMaFI5+dZ3fifxwLzFlTUqAayWr88BfOjLJbH9W9gTUXSnAcjbz?=
 =?us-ascii?Q?KHdcoESIqiltXzI9LOWHOTr8YD+sQ0+tDIyc7/ndZ7k2N6I5sW0FMiwYTTi7?=
 =?us-ascii?Q?lMpetsXsEaOy4wOSL29hjIXawtwGEurSsQXXQYpJg+KuBYFJfjgkRr6NJW1Q?=
 =?us-ascii?Q?aLs1MvNK2Pz9tGalK6GlJl6PNXKWNANrU8z350jFYAolLxBqikfzof9B6wUj?=
 =?us-ascii?Q?iNACHhFMDmqBeHIb4cPbE3l3bZ+puVokez5YLDo08daxKYFHiZ98?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df05b5e5-4f7a-4200-b330-08decc4ad7f8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:35.7243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNZ/T04K2m7g1CkbXc0Fb7U0wTUvW9lYAEjgKHqfFzzgl3bnmbay3xCQpytCjoMs0dqd6stVdkYBm+Mw9nxfoxHr109r8OrRlee5wMFxBBleB+8CJmM7ZTYE58a87ZOE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23182

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit a886baaaa6e12a9b7d5a9687d11d3b895f1b87c9 upstream.

In PIO mode we send data word-by-word, and wait for the received data
to be available after each sent word, making no use of the TX interrupt.

In DMA mode, we need to set the RX and TX FIFO thresholds to 0, as
described in the User Manual.

In preparation for implementing DMA support, set TX FIFO threshold to 0,
as RX FIFO threshold is already 0.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-8-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index c5e66d188cc5..f4ebfcd1470b 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -501,7 +501,7 @@ static int rzv2h_rspi_prepare_message(struct spi_contro=
ller *ctlr,
 		writeb(0, rspi->base + RSPI_SSLP);
=20
 	/* Setup FIFO thresholds */
-	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, rspi->info->fifo_size - 1);
+	conf16 =3D FIELD_PREP(RSPI_SPDCR2_TTRG, 0);
 	conf16 |=3D FIELD_PREP(RSPI_SPDCR2_RTRG, 0);
 	writew(conf16, rspi->base + RSPI_SPDCR2);
=20
--=20
2.54.0


