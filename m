Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE6FCD98E2
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 08:31:35 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.29])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10762.1781685090821933454
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jun 2026 01:31:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ajr4Cwu1;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.29, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTqusfRV56v86iAJgugE/+ho/sMv0Lek64D46lMxVuljAHCyQrsodzHyhGSHGZTgvWA6tuKQXqQTFaGJcvpIiDxuPto/dfny926Drar9ap89HI/2K1SIMh2DKaOmUgWl4CRKBgev822dsOVc8vVpA8Y/Bm7h33KonmW3RFJDkpk+8JEg+Yy37jxPIA6Z+mIwdajCLziQb26SkRkS+QFM42jqzr8sjJyoVz9stcJTRfXCSkECNmpLdFwjIx33uG6M+7PQmqnnPp1qhG6XknkkHgQsy0ISlLGGx6IiPJopLYEmmYDXUI1GedcZ6Z64iPt0LMqp8yL6z9txgsiUbqgbBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qk7uikUlcC1vB4I8th0xEzsQKv7ptJzEieNX7q+3lXY=;
 b=reNOvWIVy1U7l6Kg/v3eX4mi6b6iXs7ZPXxGkU98g3cXODf6z0nsaaYSZgXIVIauoog21TIthfrcy08SYDb05yT2FdMsMbk0f4zLhP5Wv/UKLqE9qxgjR4UjMrBj4KuyW7PmVledhiSXrR6SAcpY98TRgeWSpDCod8CnYxHtNl/GTCnvqUa60X0XJAHOFoCfbwKJoswZCs09GXTgSger3knQAwittQUogK9t0G/jURH07ym0fWRSDXJq72yqFTfVtQ6yo291KelJAhZQ03ohTTTGVLxkbCNKDiqjT1VBvAPu0k+/ykwesY0Di5rk4K1Yla/6LzcxsntV6IMN8ep6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk7uikUlcC1vB4I8th0xEzsQKv7ptJzEieNX7q+3lXY=;
 b=Ajr4Cwu1jRSC6on/dg5maEMV9WvyHT6yj4Nq7jfcwoNKdwkYsz4uEF24tkkok2jOzatfTYF16zIfVwHyPcj42sJH56/vDGIo9YRjfKAJ6hhrdVD5ltkQeHNVHOjZS2lUMZRk4ECQUzNijnaLEOk/v27rrYVOKkqIx7ChzxJN9cI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSZPR01MB8108.jpnprd01.prod.outlook.com (2603:1096:604:165::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:31:29 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 08:31:29 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 21/32] spi: rzv2h-rspi: store RX interrupt in state
Date: Wed, 17 Jun 2026 10:29:52 +0200
Message-ID: <20260617083003.1071543-22-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4fca874f-56e8-4573-d5a9-08decc4ad44a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|23010399003|18002099003|22082099003|38350700014|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	fYw+hwhagTT0LOA+bA2UEHchwEosp7kbKYZOjWm6dAEcqGXlBEZvp9kgTXI+NpdGYz4NHKR3FKSByc7V4KNb0pGQfd5FuSkuETlOH//rd5JNuO5A4dsUca3afwWDFfqyEWBIY0L6eerh2XotlxcawLc7e625RE96X9l0wrGtqF0mmOf+h/FjGnyHDihCDKPpE9MYD8DdkJDQC9phGQRJs3WWI+U1vjtWcPJtwzKdFVqqyp9A6gab3XP/lVwxfuMaHnA+6pHz5pbLvJJs5aHDu4Ozy4X483XWedDtFwK+Sni/TQNZGnbACErUvm8+rbLVPKSOLQ1JbxCGixnuLIbqipe5KMmrftcTRD8GTjgvVB/BEub/0JeQFpOQiKpzitm2+YDIKzMdfuBIjL0m2Mw+z9UeCTILfGDVUadrKhEytFSkvW3gnTh74bLe12AEKzLZixfcbTVGelIu3XMgnktn3KP9q3bNSx/D6NBAXpTK07S3bJnJI+CunPfzs9rTIKBK51l1GE6GeLgVV9xxFX6bl2jjOKKxwn8C6GX8CX5i7X+jXP0jzr1MooQAB7QkvjAGjVaGyiNdvZTUkFYCPs6JpzSnhgJxHDnovg5aTHfrWPOmB3sfzSs49xV4HUaU9aReE3YEvLl4Ucz9ML0qDVFuOVhe+ScA8bzAwT9NLeDgMl9gRHviaPA9phL8WgGti9nPeIdpEEUEmNkOYxuJKCQPiQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(23010399003)(18002099003)(22082099003)(38350700014)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?p39o9JzwduCaiYTvO/9NIvRgUf9uBFRfFUoRwOFPYPQZoPAt6mD6k2C485ne?=
 =?us-ascii?Q?t0ZK4MNyofPFNFC7UT2KJ/BrZ/rS/ogUnxh0KHd54rwN6CcNU9ol2yGZ+MTO?=
 =?us-ascii?Q?c6Wd7s500pZiTTYVCK9oUpVwyEmOcxuFHejByUjCnhoHNlTyeenJ0Cd56IrA?=
 =?us-ascii?Q?sszDyqpQORiOv41N/wja7Yc6ptD6yAr9plR2CY+1QJ3qv8Vgwp5vP4+b5irh?=
 =?us-ascii?Q?bMYEanvMDKbtY1c2x9iYW9Uo9+Rh0McuPKy6kgu5xyk67FAKbC469EWhM9XO?=
 =?us-ascii?Q?XIsgVYpJJ9NGL50k4tqCrpBvZkRv7mIaW2TwmvoWPrZwkOkCYcKj4fT5m6Rj?=
 =?us-ascii?Q?SvIeKvCNRA25Hm+LZIbMEQTUjWQRAw2sgolbc+7lJsEHGUzbaMrMR3HW39Ge?=
 =?us-ascii?Q?zSZw2sJBdANwmz5walqyLTXCBlUOwaZuNPo/3bAtKkDvV6KYzSdKV4EViAIF?=
 =?us-ascii?Q?HM+im2j3D3Da7CPuQC6A3SV3fA3oxovCr/ATQozrC4NwxuqpmDjLWRRoE2rO?=
 =?us-ascii?Q?9PlyT9Vae4b4G9hL1OuBCYSyRiLF4rcM1bQFfk4LcG/dkUATun2jYsOkAinW?=
 =?us-ascii?Q?xIyxL5WVd0xjOwk82aUa1PCXtskVBes82LpMq6iAR0EgiG/81bX9YqD8zHYY?=
 =?us-ascii?Q?qgXCmUbpx+qLTym/yOfSyal2mY7CYsFZtO9gBPffSsu34d84QcXTRf8MNS30?=
 =?us-ascii?Q?9gJZ88n3d2uQFydbNjvicZTEdgyA90Lq0vWX2fIQ4W5SmgndtqTVzskG99zW?=
 =?us-ascii?Q?93WHV1AHV9FrcyrHdG9DszoyHpJ9rWcFNeHVZaWjprdEZJbH/+8/HOpA/Xxt?=
 =?us-ascii?Q?rV2sWGs2pBh0hAhykJLtOs8agpRt1wKmPB1YBnblktHcugsPG6CX2+Z4WbYe?=
 =?us-ascii?Q?T3z/kOX34HQ8WcYycYq5P0qtPOSV8o1wudQ7pCOLIjmRt+nCKsNOSi+ZJIoK?=
 =?us-ascii?Q?zuWV6DbdofaLqLBNV3MT/0rPKB861fJm2pw5UKYqMKwRqTAU1Yla4cv7Ohxp?=
 =?us-ascii?Q?ueTztf5SdUEwCgME3DKU2r+t5LpLzJaGMAjz16j1kD24NDH0KlnE30x5mdZa?=
 =?us-ascii?Q?iyGPI29PnztdzqGEXWD6foP2fwTJhl1GZ7sF8fz0fn2fndabQeDVEHDlo9dz?=
 =?us-ascii?Q?oNWv74bmTtNZzrevJp0DFQZrnfw7pTOfns09CI2vzL/ZrjfdoscfZ50gRn9I?=
 =?us-ascii?Q?pQaPlb1oiOUMIzBUXckoITqYwF25/u/T4Bf72t/8yO48I+pJ5lq49dyrkjQ5?=
 =?us-ascii?Q?HfTwuhbZ4tDD0cPlQcNiSQqQHHKc24YdLfe94AUhTgMdOyoj8oUjjVxi08xg?=
 =?us-ascii?Q?YZwSwczNbbKLVjmEXGtSFDWHMLDgTJKln+jHmLGs5p0hHfF0c8FjNPaEhYY7?=
 =?us-ascii?Q?ODjocD6H2vJfl12b4gK2aJ53DHNly11iMd0o9LXWdCBFrTD/wgwuquGYfZf3?=
 =?us-ascii?Q?FODMcSGbJO8Wbz4ybfUWFItoxNsACTX5mt4GPMzNBYGuXhX+s+HXHw0ORuJj?=
 =?us-ascii?Q?2xZ5+w5FqD9/HuzTfRZPwipPi1ZQOY4c9aGsRFqbkdik+cbb1HThP8aY+0Yu?=
 =?us-ascii?Q?crZRI812AVUaT4S9oESxU2yznSxWS0IG4B7QAaUA6lPrgy0MUdLXc0JHw0Vh?=
 =?us-ascii?Q?YQPj+DOJu5jIdOooSvGfBqVyuI05Gy3i5MdwfJ46SIGDVypa2FCym4oDrKhx?=
 =?us-ascii?Q?wsxcpM9jL/PDUJNqAbq5nyRXsLyI647L9eTTFTu+E724DDQIE3aMG/lcz2wA?=
 =?us-ascii?Q?/S460QxggNer+O9rJCMG1XYSoVvO7e273VJz+OTJ/iOD/N1VGDlM?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fca874f-56e8-4573-d5a9-08decc4ad44a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:31:29.7892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lEa1Tt5JdwEaqhqzpns36BtMOgCLkWW4KKYR4Zkvh7FbKVQ+V9wVIWDl4D1wlGhbWaBTn22PesdgDiPS0Elcd8SuIUkEkUUgb8YgUEAo9JTQ9WhiYMmEwY6xwoy/IcR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8108
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jun 2026 08:31:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23180

From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>

commit 28b590bd4c6a051ec61cf286a46a8b14846e6fcf upstream.

In preparation for implementing DMA support, store the RX interrupt
number in the private state, to allow disabling it during DMA.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Link: https://patch.msgid.link/20251201134229.600817-6-cosmin-gabriel.tanis=
lav.xa@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 1153f2aba44a..df1eab16cefd 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -100,6 +100,7 @@ struct rzv2h_rspi_priv {
 	struct clk *pclk;
 	wait_queue_head_t wait;
 	unsigned int bytes_per_word;
+	int irq_rx;
 	u32 last_speed_hz;
 	u32 freq;
 	u16 status;
@@ -539,8 +540,8 @@ static int rzv2h_rspi_probe(struct platform_device *pde=
v)
 	struct rzv2h_rspi_priv *rspi;
 	struct reset_control *reset;
 	struct clk_bulk_data *clks;
-	int irq_rx, ret, i;
 	long tclk_rate;
+	int ret, i;
=20
 	controller =3D devm_spi_alloc_host(dev, sizeof(*rspi));
 	if (!controller)
@@ -599,13 +600,13 @@ static int rzv2h_rspi_probe(struct platform_device *p=
dev)
 	if (ret)
 		return ret;
=20
-	irq_rx =3D platform_get_irq_byname(pdev, "rx");
-	if (irq_rx < 0)
-		return dev_err_probe(dev, irq_rx, "cannot get IRQ 'rx'\n");
+	rspi->irq_rx =3D platform_get_irq_byname(pdev, "rx");
+	if (rspi->irq_rx < 0)
+		return dev_err_probe(dev, rspi->irq_rx, "cannot get IRQ 'rx'\n");
=20
 	init_waitqueue_head(&rspi->wait);
=20
-	ret =3D devm_request_irq(dev, irq_rx, rzv2h_rx_irq_handler, 0,
+	ret =3D devm_request_irq(dev, rspi->irq_rx, rzv2h_rx_irq_handler, 0,
 			       dev_name(dev), rspi);
 	if (ret) {
 		dev_err(dev, "cannot request `rx` IRQ\n");
--=20
2.54.0


