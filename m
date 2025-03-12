Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755DFC28B28
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.70])
 by mx.groups.io with SMTP id smtpd.web11.34881.1741778858507888765
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TBj1Jxk7;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.70, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uvn4T/zwqf+Goa9rzmuQY8tXEWK9pXi6OnIDxH3BEtotSMSgRPa6w84ev/pgP0QfcWUUy3rEiPJhbQbq9wB6jAddhPcgb5+0Mnfe9qSvmr3sQMfd0xtf3icyzNtvbgbDTR69WkZ5XujJh/ZI3+pd6oHdoomlnUV/IlLPEqH626kdUpbiuP+WR41+HbjykGhvdIjRBrqVXvsAyVD5sI7T9hmcwgY7qxJpbU5W6HfGFZv2+qLIlod1kfrkr8pQ+IMaLVg6CEMSmSdoLH9aB0orXG3uoC7et7vHzJRKY6lswIEbMTkfj0Gs/w4A3q3bcBL/iwU6fI0glOO4k7KCmXECCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ERYROq1ALQnxupXN/o1SB5hrd290JvP1IpvdJCu9BLw=;
 b=tFNdCeczw8ILlnfR5WD8iNP0KDF6AOONW4S1jRRNHRQ1WznDCa7VlZjeTjFH6iGx/XXGRMdY5JMZvT/54uRRUkKWRxwIamZFboBdIGLfcsOFwFlSPOLWefwSv5FcPFak7iSJUlTKUEEBB5UyTvCUyfj2eJvgpitH7vEj22N468qBOdUc6MBJGuQJt6YLA3XNxKR8uqG5RMlEoR1fiXD4zfuqnfS7wBPGqS8usn0P0Qh/1d5q0hMVcwsPcVqe8zZWF5qpQM1J4l5aDogaRKdpfrrGFzxksgwDB5ftb/oV8IOgoVOkSmWo3l7zIvA+KmiO2FLS4gB3dd2LGmPBlbqzmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ERYROq1ALQnxupXN/o1SB5hrd290JvP1IpvdJCu9BLw=;
 b=TBj1Jxk7laCkjf8C6uDHsGqmA+sZ1RvSFn7X1ZSJggJEOouQQZVhPiKBXVZmvkZU0k1dMcgDrWQcQLncOuSMlWFAwRNvARB+brWRO68YFaJ9QdxpS3wX6eZ//69ZmCQVpPn7zvjF/WPbLFKhiqef3Sd4MLZBZuQI0pKbQjAeCqw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:35 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:35 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 82/85] i2c: riic: Introduce helper functions for I2C read/write operations
Date: Wed, 12 Mar 2025 12:22:59 +0100
Message-ID: <20250312112302.1605750-83-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: df1abedc-9787-4fb4-7646-08dd6158e341
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Xjg+Ga0sWAUvAK5FIdVFu4lmnae23ylHawS8d1kuGeHJS1hEQypwtvsVD4o5?=
 =?us-ascii?Q?51c9zQynw6JSzgo1W8uWNVYL5QbJ9Mbfo9Fa27VUmYYT5OU+R1q5nFzmLOO0?=
 =?us-ascii?Q?VSpRiIoA1+RIZCKpm3Tht2L2YP1SD9Ez+lXx1xUrm/AgZ8cuvnvxKymf6M6w?=
 =?us-ascii?Q?ZwbmaVhcMoTE9L/AnyBpShxKzB00D3N0OlM5ofJG3rUPfRhACRW2r0tBFBEc?=
 =?us-ascii?Q?xO3UDWXmYtnc3XWKzr1+QmTzyf7st9YhAxC0U+CVp1t5z/f9uIxJ5GpVYCry?=
 =?us-ascii?Q?QUZsKlvAUN7G7PIwjpJ+Zao7Yx7ZW8rVAyd2RNZU0hMj5JDpToNmqdCMBPO6?=
 =?us-ascii?Q?VgSjopcIy5UxYBJC4hkLgXckIRmaj/Hx+GjBkfi75bviG5Phvqrep9mWi8Kp?=
 =?us-ascii?Q?6KWm4xxXcdHLI4gqhZkcri9ZNnULHDibT+WEXjrpla1l5bIOSsugnlNj3wyt?=
 =?us-ascii?Q?xJcYSkFxYdBbnkzLU1+5AH5MObtQGdlnxM7d4QJhPKw20Devqia7t+apyJOZ?=
 =?us-ascii?Q?vI/W8h++KfTzWvfG5Md+NjCyuUQXj4IydZR10x/h6hBM+zCHl6kUnI//bVj6?=
 =?us-ascii?Q?oc6C4KTaUtMgn3Rw37XoOyP6ndqveSNcmq9vwVX3abKqXW0WEqpIru59YafL?=
 =?us-ascii?Q?IdYsLJ6BYStTBL/b5NcmuBqW7SGYH/+h7Dgy7XpO+1xI8tnnGR1i40xpnrNX?=
 =?us-ascii?Q?N56gB1DTIKHjlFfo0p+ziHCLE+nvwcCmbvGAxLCZdqfQV1ATFA6Jk+pyy9f9?=
 =?us-ascii?Q?IJNOZcW6Mc5INpHXVNvgS8f4uBC66LIN8MwAUZwUSY4vZ9fmBnRHJs/BHgsV?=
 =?us-ascii?Q?d302aF5rM3iFGe+/KDAYce/9v51I75/3ls3w1QjiRt620XTqF9C7l1aQCZC4?=
 =?us-ascii?Q?UzGrvVYQX0MmZZY++er6CvXRluRAw37NAvi9j8vMNeb4r/ohW7qbsO10Snnd?=
 =?us-ascii?Q?l4omO1RXuMFE6EWg/ZnBFobpAAiiI0psFoQs7fLAQB6GXo11rW++J1EtzCgu?=
 =?us-ascii?Q?xLRyNvsnUXECEJY/kh9CzhX2Pui+rwtug5BDr6g1Jh/l5SIKPoENsD9tpUnt?=
 =?us-ascii?Q?j3u3MyHkF+zdLEERKXLJceRqTjxdk4qLvuFSQz94VsKwg0AdZwXygQBVIdss?=
 =?us-ascii?Q?iKrTFI3/NYD8md6WeyOhAnhNHVEF0QbCB/sAYN9cBZLprigiM26oVXy2VcjC?=
 =?us-ascii?Q?uqt0zjJKhjr+PJAlBXaytbEsRz25cxA3R+bBrPxP8icNVcHvR6oRG8M4rH8V?=
 =?us-ascii?Q?fYRQehzg7qPHbIuXhtO5eG0xNjybczTas9A/ctVvjEdltxguUBrNV2dWSv4/?=
 =?us-ascii?Q?b99tpHEWj6y5xI01kHph2PxqgO979WZA7p2WnycLcY0UUU0JxZUx+OH4ijZX?=
 =?us-ascii?Q?dpJU1U1w4FHcVc3g4uGa69e98RMnff7Myg/4cRPJ9S4FHlIkLoE3l4g6pdhr?=
 =?us-ascii?Q?9HkVbY5Zhz/nbGGx7UC6cRmuGfq6nr4e?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Jtwe4/nmpIBt55OWxNoPPQ6nDhSuc0qytukXs6VnrrEG1b1Xwa1aSMcrULKq?=
 =?us-ascii?Q?jWkDW//EnJlU41Stdoi1YzIE+kkf/tt87jCg1ixj6hb/kwrQhdo0ZLihHtqV?=
 =?us-ascii?Q?MBJDbfK72B/OQt2B8bz+7n9yXx43dX7cJ5VHlVUL5dwh4D278zXlLW4GGnwJ?=
 =?us-ascii?Q?UKY0WRZdrbD2l0v8/F8gfPxZL1+RhJlGp4ARbwM9jDK89h2lk1a3cpx/2iu0?=
 =?us-ascii?Q?MNV7oHIPoEL5JEAEvSs1F8ggqIZtdrP4CIahQw3rZQN1L9YIiKlMDPTsZvJB?=
 =?us-ascii?Q?hoYLDxcpUNVZGRQQzgJuDKJP5/zcKrvvjcm7ms9T9qKyi4KF+V9J6nsBh9qy?=
 =?us-ascii?Q?Qlvg7kp1isbp1fcGX2fAfA79oAZoXJw1q0ammx1BvNWuhWipSldKj5IBUOwV?=
 =?us-ascii?Q?K/iHVVI0mASFRKi8UorlXHuXMuq8yUqB0AbDsCKggSKXRN6pWOLMZN+nMyOO?=
 =?us-ascii?Q?927zIScdrFdSJQqSdwu/ne+ip2zzMKcT4ZPZz/WBgE5ylblQDVBj5JVSXMCa?=
 =?us-ascii?Q?rf45nuwdINdTTR4m5bfjyF1q6lUfND5i3v8fMU2Di9LjixH7j21XYYyZ7xGC?=
 =?us-ascii?Q?E3rWRncLSQ75ZX8e2+GWc7KijJmZpwO2QGJKDLUaFXrICujeq8y7m6c62MAw?=
 =?us-ascii?Q?mWHoYLJtvqEy89MBeaoWDaOqzRa/3Y5eHYBnksAwUFep3/kIJooySZ5rNd9Q?=
 =?us-ascii?Q?6BOidYwBZ5eTmrxgvdw1Ie+cAXiBSxY38fHDDlfARbRaRiLxNq/IhLTRoYqt?=
 =?us-ascii?Q?APM9l6uh2RWernXB3bnJCEy2k6oR7DISKJbKIDD9gMzvGXq5jcJJyWX78Dsn?=
 =?us-ascii?Q?kBKgm3lDVeFen7R32cKzVTeXi+026JHqdgzMllN12ybQmizz6g1aBFtEMPki?=
 =?us-ascii?Q?MftUd/UmVbvItL0fLqYxkLoJEXGD5JlPOsN0RotspLnqpdzP0Nk6tr2cBCTA?=
 =?us-ascii?Q?BWHKJMzSkIXBsO3O+2n3AdBI55OBBHCi7lU0PBOk5DTHRVYgWY/OTAEtxCra?=
 =?us-ascii?Q?5w3u/ny8wRrKiBzixlQojguTTiUYIr2RwvA83X4IndXBiaWAnlgTtp0q/5gZ?=
 =?us-ascii?Q?EvYQwGht2ynJau30GBQ36r8Ka80vLCN47qgKjuMD4BQhnbZeeYyNUSzyHxBX?=
 =?us-ascii?Q?7RwPqfUJkj5tMZMQjfMzb4Xhz5hVbdnUeUWoEauYLVFbaRGAoUZPbEVlsrPa?=
 =?us-ascii?Q?x7S/VYIbd3xV1YbcQ7WLxj9NHH07b+QXO9GYhu/9D+CUf0c42w+vWv6h50s9?=
 =?us-ascii?Q?egnhHD6k5db+w13g1dtoFEUELPpqWZ2Vir6+6YR+41INZwKN+6iGbWSaEnqV?=
 =?us-ascii?Q?o64LxsWAh277UfUKahM6Oi5olXIO+8GyZ3XO7VR5d2mcXNCzGxseWNnFKV2V?=
 =?us-ascii?Q?u6z/v0XQZ6593PinX0ldAOGIg9jdxND66OuZPdYEpABSesHPT0j2m3gIP5XK?=
 =?us-ascii?Q?doWgbLxzn1xz3slLcE6XmRUcP+sB74zYF4oym7PLyk1IHbYYvVd1UJYlDf2/?=
 =?us-ascii?Q?EzGCJBqsqBl2ksioTo46AxHy4RUnlPauBIAWwcvpPV0OBsL9Yb9kWRy5k0lc?=
 =?us-ascii?Q?uMxGLjJuW6lOM7UCljhzU40z94Jgriy4NrfoWSD0A3pRR4V8GTJuwX1lAMh1?=
 =?us-ascii?Q?lXWYIH/z4TLJayVe777bCyg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df1abedc-9787-4fb4-7646-08dd6158e341
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:35.5374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5P3PU/XcjTINixnV26IrRIyYXq9ZkSJvsNtiCq7iqJCmrmBoVbb8JXEREIOmxXaZ7Ov/5yogB/Zm5ehV0DUEnjdqCKFObaaJ4SklbVQIurnj+csIHZ6JTnwM3F4cNwz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18174

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 26c7871100f2933a2827b217320366e89cef5a4c upstream.

Introduce helper functions for performing I2C read and write operations
in the RIIC driver.

These helper functions lay the groundwork for adding support for the
RZ/V2H SoC. This is essential because the register offsets for the RZ/V2H
SoC differ from those of the RZ/A SoC. By abstracting the read and write
operations, we can seamlessly adapt the driver to support different SoC
variants without extensive modifications.

This patch is part of the preparation process for integrating support for
the RZ/V2H SoC into the RIIC driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/i2c-riic.c | 56 +++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 6f8ce656183c..46fd6c249c7e 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -106,9 +106,19 @@ struct riic_irq_desc {
 	char *name;
 };
=20
+static inline void riic_writeb(struct riic_dev *riic, u8 val, u8 offset)
+{
+	writeb(val, riic->base + offset);
+}
+
+static inline u8 riic_readb(struct riic_dev *riic, u8 offset)
+{
+	return readb(riic->base + offset);
+}
+
 static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 =
set, u8 reg)
 {
-	writeb((readb(riic->base + reg) & ~clear) | set, riic->base + reg);
+	riic_writeb(riic, (riic_readb(riic, reg) & ~clear) | set, reg);
 }
=20
 static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int =
num)
@@ -120,7 +130,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
=20
 	pm_runtime_get_sync(adap->dev.parent);
=20
-	if (readb(riic->base + RIIC_ICCR2) & ICCR2_BBSY) {
+	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
 		riic->err =3D -EBUSY;
 		goto out;
 	}
@@ -128,7 +138,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
 	reinit_completion(&riic->msg_done);
 	riic->err =3D 0;
=20
-	writeb(0, riic->base + RIIC_ICSR2);
+	riic_writeb(riic, 0, RIIC_ICSR2);
=20
 	for (i =3D 0, start_bit =3D ICCR2_ST; i < num; i++) {
 		riic->bytes_left =3D RIIC_INIT_MSG;
@@ -136,9 +146,9 @@ static int riic_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
 		riic->msg =3D &msgs[i];
 		riic->is_last =3D (i =3D=3D num - 1);
=20
-		writeb(ICIER_NAKIE | ICIER_TIE, riic->base + RIIC_ICIER);
+		riic_writeb(riic, ICIER_NAKIE | ICIER_TIE, RIIC_ICIER);
=20
-		writeb(start_bit, riic->base + RIIC_ICCR2);
+		riic_writeb(riic, start_bit, RIIC_ICCR2);
=20
 		time_left =3D wait_for_completion_timeout(&riic->msg_done, riic->adapter=
.timeout);
 		if (time_left =3D=3D 0)
@@ -192,7 +202,7 @@ static irqreturn_t riic_tdre_isr(int irq, void *data)
 	 * value could be moved to the shadow shift register right away. So
 	 * this must be after updates to ICIER (where we want to disable TIE)!
 	 */
-	writeb(val, riic->base + RIIC_ICDRT);
+	riic_writeb(riic, val, RIIC_ICDRT);
=20
 	return IRQ_HANDLED;
 }
@@ -201,9 +211,9 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
 {
 	struct riic_dev *riic =3D data;
=20
-	if (readb(riic->base + RIIC_ICSR2) & ICSR2_NACKF) {
+	if (riic_readb(riic, RIIC_ICSR2) & ICSR2_NACKF) {
 		/* We got a NACKIE */
-		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_readb(riic, RIIC_ICDRR);	/* dummy read */
 		riic_clear_set_bit(riic, ICSR2_NACKF, 0, RIIC_ICSR2);
 		riic->err =3D -ENXIO;
 	} else if (riic->bytes_left) {
@@ -212,7 +222,7 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
=20
 	if (riic->is_last || riic->err) {
 		riic_clear_set_bit(riic, ICIER_TEIE, ICIER_SPIE, RIIC_ICIER);
-		writeb(ICCR2_SP, riic->base + RIIC_ICCR2);
+		riic_writeb(riic, ICCR2_SP, RIIC_ICCR2);
 	} else {
 		/* Transfer is complete, but do not send STOP */
 		riic_clear_set_bit(riic, ICIER_TEIE, 0, RIIC_ICIER);
@@ -231,7 +241,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
=20
 	if (riic->bytes_left =3D=3D RIIC_INIT_MSG) {
 		riic->bytes_left =3D riic->msg->len;
-		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_readb(riic, RIIC_ICDRR);	/* dummy read */
 		return IRQ_HANDLED;
 	}
=20
@@ -239,7 +249,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
 		/* STOP must come before we set ACKBT! */
 		if (riic->is_last) {
 			riic_clear_set_bit(riic, 0, ICIER_SPIE, RIIC_ICIER);
-			writeb(ICCR2_SP, riic->base + RIIC_ICCR2);
+			riic_writeb(riic, ICCR2_SP, RIIC_ICCR2);
 		}
=20
 		riic_clear_set_bit(riic, 0, ICMR3_ACKBT, RIIC_ICMR3);
@@ -249,7 +259,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
 	}
=20
 	/* Reading acks the RIE interrupt */
-	*riic->buf =3D readb(riic->base + RIIC_ICDRR);
+	*riic->buf =3D riic_readb(riic, RIIC_ICDRR);
 	riic->buf++;
 	riic->bytes_left--;
=20
@@ -261,10 +271,10 @@ static irqreturn_t riic_stop_isr(int irq, void *data)
 	struct riic_dev *riic =3D data;
=20
 	/* read back registers to confirm writes have fully propagated */
-	writeb(0, riic->base + RIIC_ICSR2);
-	readb(riic->base + RIIC_ICSR2);
-	writeb(0, riic->base + RIIC_ICIER);
-	readb(riic->base + RIIC_ICIER);
+	riic_writeb(riic, 0, RIIC_ICSR2);
+	riic_readb(riic, RIIC_ICSR2);
+	riic_writeb(riic, 0, RIIC_ICIER);
+	riic_readb(riic, RIIC_ICIER);
=20
 	complete(&riic->msg_done);
=20
@@ -366,15 +376,15 @@ static int riic_init_hw(struct riic_dev *riic, struct=
 i2c_timings *t)
 		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
=20
 	/* Changing the order of accessing IICRST and ICE may break things! */
-	writeb(ICCR1_IICRST | ICCR1_SOWP, riic->base + RIIC_ICCR1);
+	riic_writeb(riic, ICCR1_IICRST | ICCR1_SOWP, RIIC_ICCR1);
 	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
=20
-	writeb(ICMR1_CKS(cks), riic->base + RIIC_ICMR1);
-	writeb(brh | ICBR_RESERVED, riic->base + RIIC_ICBRH);
-	writeb(brl | ICBR_RESERVED, riic->base + RIIC_ICBRL);
+	riic_writeb(riic, ICMR1_CKS(cks), RIIC_ICMR1);
+	riic_writeb(riic, brh | ICBR_RESERVED, RIIC_ICBRH);
+	riic_writeb(riic, brl | ICBR_RESERVED, RIIC_ICBRL);
=20
-	writeb(0, riic->base + RIIC_ICSER);
-	writeb(ICMR3_ACKWP | ICMR3_RDRFS, riic->base + RIIC_ICMR3);
+	riic_writeb(riic, 0, RIIC_ICSER);
+	riic_writeb(riic, ICMR3_ACKWP | ICMR3_RDRFS, RIIC_ICMR3);
=20
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
=20
@@ -482,7 +492,7 @@ static int riic_i2c_remove(struct platform_device *pdev=
)
 	struct riic_dev *riic =3D platform_get_drvdata(pdev);
=20
 	pm_runtime_get_sync(&pdev->dev);
-	writeb(0, riic->base + RIIC_ICIER);
+	riic_writeb(riic, 0, RIIC_ICIER);
 	pm_runtime_put(&pdev->dev);
 	i2c_del_adapter(&riic->adapter);
 	pm_runtime_disable(&pdev->dev);
--=20
2.43.0


