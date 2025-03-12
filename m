Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849F3C28B30
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:36 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.26])
 by mx.groups.io with SMTP id smtpd.web10.34513.1741778860314319583
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ic/NBdra;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qv3bfd0MttD695CTsmV9UPTUyoH86f3hDHkexGNZ0wNTaCZKNFqQrQ1exyWOIyJwE7V8ZYHVeI8NZ7rLvG10ot84/5ZZqIYqvdjeKaZOcvEmCEfZTb3yzcBQqbFSTTJPkblkuQcahZilWuFndDYiCfloNHzfIzQGSV/O+9yYUbZ9ypqDs/jaWEuivJUcqi5j6Qw8K+SP7utpx1GvlR0bgkxq5RhhHxh2HKH7VkPjR47AbB9L3a9vYeDH/ThsNqNHOG1FfWJrTgg/ewfoYyqYUkFPrVc4+k/GV4TQVOVesv2xxLrZAmwaTXBmXBivFy8J0WhMtDu8UUPe/LrTbmLS+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atBOlsEN467Nir4maYXurSHsR+1ksj/ijJMJL7o++/M=;
 b=d03qtLoj9jQSfqWvSvZHNBbDcsPRPeUDpZNX18o/xKVnaUJd0BW527cs7iTG3ByHQCRE4e58o9WsPSyLq35L+N1du6AspUfz7Jb+0RKlLCDRJ/d5f8xtFU4DD8Bs5BAUSv1UFe4XWYV7fp6Y2izMVZueWutLE+/sy1b9OYLUjO1k6iA3N5M1QCcxX8Q8xFFSj3J4SPToIfxmnMhOWfzvRdb+CKwb2Kn6deVlg/wtW3UtwMB8YdVN0X/5eaxvvnotkQCU/7ymO/qN/k3vwxT5mdYidBOojU+GleWq8GQ8JfJb+Pd1IVlGdCmWDDvFl1Z3VULmo3+eq2X9Qikcgo2AQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atBOlsEN467Nir4maYXurSHsR+1ksj/ijJMJL7o++/M=;
 b=Ic/NBdraW9CU8/n16i3a7tVdlbIigov4TdhzeFQiPMqCT/WMdsgSXhgQsqY8xJUyDSn65/I97QnaZSVpToe96/R9TJQTUBClK8UL3ApGy3BAIWtUleGbXXUjjw++9yKwWTiCNdRMraGUHLR0twfcGo78giloIbY4qqFcpOALz5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:38 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 83/85] i2c: riic: Pass register offsets and chip details as OF data
Date: Wed, 12 Mar 2025 12:23:00 +0100
Message-ID: <20250312112302.1605750-84-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adb4427-f955-4450-9edf-08dd6158e4e5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?yutoBTR73yrn4hR2evM/FFBvPTSnD6pw6fqb/OE4izISW5XqBLBpIqLswIlE?=
 =?us-ascii?Q?XdVMToDj7C0ZIN5t2nJpC4/KLURMWKJFEiz0X4C4vCj/emmAH+R1C6xySQVm?=
 =?us-ascii?Q?Eo+47TeswhRZj1XhHFQmU5+Uz/eCtES1n/8PFWeliflZzYQvBC8MXW6yMNih?=
 =?us-ascii?Q?UEUeSkshjpw9hDZ5cTOMRPTmGv/+dPHMq/huPA3imVzyb8S3m5pplXbIhZJR?=
 =?us-ascii?Q?Gw8dREqe+jBdP031gDfmh1Sn26rGsrc0AXmvuFw5x0OwMoqnxTRe0Tunp9Lk?=
 =?us-ascii?Q?uU2qPLA6kx5MmpgB0yv7tKFkmH2/Pmt5EkpEKnQlesBazYe90ExxuaOu+hJ3?=
 =?us-ascii?Q?DoDCk8yap6F5lnlWi4GbTWPTCxDC2jla7IWZI1Cxd9SEYYqC64nkVKk0ibHt?=
 =?us-ascii?Q?IzlWPYCEoHrMyM9i52eqom+VFVsPyl65FWKP+Mz/ck8OgjkFO88OyGMrE9gx?=
 =?us-ascii?Q?Kp2p2p4IVZXxx/RqVySdvhX2dXVOuGjAgDx9ztQHniOtLos53WuUp3RpuLXA?=
 =?us-ascii?Q?XhxFq5z7JGVESUHBfsByujU2/f2wq/FGaZohlRVj44wwMSAT1aKr/L46eUHn?=
 =?us-ascii?Q?5Scf1T1yFUeI2M9PU+9leky9b/RFTs4qr+ZXpNhKahogEfUpVcv1wpoNfuNa?=
 =?us-ascii?Q?XVH2C3IiPl1PrZRidSvLUgTNm1O+hPSXawVN/cIO9Qnd3cC/2lr2+wWLss0q?=
 =?us-ascii?Q?xQ/fzQTgTie/IhQMjes/XQSr19IJl19wCEIfKx6vyJdPQBkMUp6HOGowhDNo?=
 =?us-ascii?Q?MomT+4gAdAO/P8Mzj2JDehfyE3Tkpm4XuQVRPnVtnVgBqsRn06kaL+qEfko7?=
 =?us-ascii?Q?NnUJPSWw4yxj6vj1E8UDsev1gjtBKMLDmE5ZcMVoG8vDofbqzv0IC8hYK6NZ?=
 =?us-ascii?Q?VAqoX1Zs6G1FvsJ8D23oFaZK6061idCsW4SCLLWpzTgwNzgtn24swyoqdWev?=
 =?us-ascii?Q?mERzZ2LPYli++oeLvKx4QFmUyMpqws0Fnit+in8cBDgb7La2TCMrS5oPBjYJ?=
 =?us-ascii?Q?1gu923ichjBhYz1ozECIPDG9Gye+qJ5KcpMHdA3+SlJk/FVI8svQxjBw7F82?=
 =?us-ascii?Q?N3PqcDy2RAkj4KW2VvAvU8MG7zw3Y7JYhOU9uabBsb91/CQ6xxq7h8sF4oyJ?=
 =?us-ascii?Q?uy8IjxV24I+K9MnJEgD26SEtJBiTnrb0OffAxK4aRSkoEh3J9Rys7QF3iG8u?=
 =?us-ascii?Q?uLiZ6mAZiMQ+DPj5ksKDCqmf6Vra9suOwAT2PQ4QTCk0eiUcwoxNixSIYzSA?=
 =?us-ascii?Q?u9jkQCc63r5uAr6ETcJLvr17AF8kAVu+FDcMA6DSc6K2KVUVg6AtLvXffkHC?=
 =?us-ascii?Q?3GrMMGeNhcHKXOq0Tb/ZcW44sG7TiTqqzyMQuF2nWjjHrDu9d0qnKVtkhTEh?=
 =?us-ascii?Q?O0OkYTK2as3bTl3vuKBZX1UpTfMM7qsXJow4Jz91yFahlZ8tRHSaIdwDe6pr?=
 =?us-ascii?Q?bv6M0H7GsotWJB7M3kzsdQW32PEgt5N0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/9uUIHUqb4K+dhPGNfgB3JwZYSwMExnOh/yzur7AGLlMQKR1/YI/u9cy2CsT?=
 =?us-ascii?Q?2zAg62NYnYWJiOFsl/GckLiKajyO9IT582Sd6nwanuHKQAzjYr737IQU5SKh?=
 =?us-ascii?Q?R51jHKO/ikYviNC0k3paD1K6/Oq4lWpHtKaDUCzD+Tkfw585rTuXlLOgXiff?=
 =?us-ascii?Q?yBsR/oeSIAL8dHhNP3ugcxh3Rq/zVAtTve0iGNos0PxOHHgAMIN7Ie9r6WKh?=
 =?us-ascii?Q?dv3jJguXWLZFP8U3lMfdf5Zn9zzeQh+mW6z0GVDELuZ/0p1uiXdi6MImAlxU?=
 =?us-ascii?Q?sTo5v9D8rlMpRv0QDlY5RBMXN3umgQoKdQdxppJ7x3l2r+n2CQ+rN8L3sxvz?=
 =?us-ascii?Q?W45BX0SkMKgNTkSCMUHfvI84d91XVTuWjnbKgg3IWeezR9xnylsE4slQBeKi?=
 =?us-ascii?Q?ui2QM8U4PSkWe2VSQAmp0HW5BCcDZIWt3Ycu4mTUymT0ScnH53MqHulpPPsK?=
 =?us-ascii?Q?dfQGs7RtrXxrl2kRRkiUDKFLv7f+EsqvtwWIr9N4gtyUzfpPsqUiwC13Gomp?=
 =?us-ascii?Q?6ZxZ2oh6ZkvrsDlanRGakpnRdbgGSfsJ87nqj13LcH20MYARa8U/sAZE/2y9?=
 =?us-ascii?Q?ILxmffqnLmQaVhhV9z8xXeBZ8FFpTHa7SqTvFBntw2xGqRRHJ/GHstaWaNa8?=
 =?us-ascii?Q?iVj7r9vCwzcZ/XvCQWc5BpM5Wwkcw5BhpoI/+/nVlhDhEllVNTPEhId92Pte?=
 =?us-ascii?Q?8NNyC7xDVEftzNDif/hyQddPcM3Xgnkxj0z1T4HMduVa1rdynWQcThPQ077+?=
 =?us-ascii?Q?lm9fqzI6AnwxUWCWhc50lCYqHCKRtjnBcoJ6pcCLHmOCGCkIQufwfev7/Vi0?=
 =?us-ascii?Q?eFEysUKn/GR/hsNrWqbM2JHt9ZEWqyxz3Um6aPeRZlMdqfmqsKFdoGBpdPTy?=
 =?us-ascii?Q?FVTgzvV/C0fbKJeRwWzkGBKAsSbwonoK7vgarqhVyzPm/kQvuTbuNoM8Eltw?=
 =?us-ascii?Q?GsxJ97BRa6k/2+Opi2iMRazH9QKC9oTwVStP74+vNI41EMjdBS9dqmnuoQ9g?=
 =?us-ascii?Q?zK0dE8aAfdaNqrT/hs6cpZ9GV8izqwfYSTCmFPF1haSy1UIb02cyrQ0rg5XL?=
 =?us-ascii?Q?wVhdeLE28Rvtc7E343VVj9s/MsKlAETmPHNGhuuaqIGmhQg02w4KEwPVbDHI?=
 =?us-ascii?Q?N4Ov8JnmaKaqLErWgcCBCHFvi6fNutxg6kkMVKhQLk5kiNdpOJxxoGduLzEx?=
 =?us-ascii?Q?Ynp6509EDh1EcTJtXq8qgZ+PUEYVvYltGs/kATvmkNqKcPVwo8FJCLG4BMDi?=
 =?us-ascii?Q?+r1hpMyiOAA1gvULfvPAoniAO7Vtn2OZYO7bL78MVxgyhRVe2GjoAm0ceZi8?=
 =?us-ascii?Q?cmBHCyZaV35Mp3xHh4L6nUrLW0l7NH+P01+sEJBzZY2e9Jx01t96Cj/tpyrl?=
 =?us-ascii?Q?k2zzkoCTVka8CG8Xv/eDduHBsE4FIZWzwSdRvb5iGFsIgM3qKk4Ok1JnEcuH?=
 =?us-ascii?Q?o71i+dHA8RuuFeW26jJCbFDTBZl9UijZA1vLjeTevY2YcxTESVDTyrsBqaDX?=
 =?us-ascii?Q?WY9ksXDyPQtKS2yxFsu45piJ0kR0rskv6eh3w6yJUW0oeVodIOtLMAwmlCc8?=
 =?us-ascii?Q?f0RWkl75j5T+uSda6ZeY9Qs2LZKReTdWcs/E9AZts3zGKWXoABcmENiwGKer?=
 =?us-ascii?Q?KWeM7btRNVCDvovczTZlhOI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adb4427-f955-4450-9edf-08dd6158e4e5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:38.4907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEuLKApXNFjAaqscOjW/b+1HwomuCHKBT015jqk53zxI3HtHO0uBpq9osaiG1jHEs5jQoFpupAhvFwVvFkn/xEJLMtGlB3xW0SXBPxLA9kcP8oJ9oI/b0T4A7l5DJ7OX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18175

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 748ee3b2a477821957adfe0ee7d1fd11d0f9a512 upstream.

With an increasing number of SoCs reusing this driver, each with slight
variations in the RIIC IP, it becomes necessary to support passing these
details as OF data. This approach simplifies the extension of the driver
for other SoCs.

This patch lays the groundwork for adding support for the Renesas RZ/V2H
SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 drivers/i2c/busses/i2c-riic.c | 56 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 46fd6c249c7e..3dc806f72b78 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -47,18 +47,6 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
=20
-#define RIIC_ICCR1	0x00
-#define RIIC_ICCR2	0x04
-#define RIIC_ICMR1	0x08
-#define RIIC_ICMR3	0x10
-#define RIIC_ICSER	0x18
-#define RIIC_ICIER	0x1c
-#define RIIC_ICSR2	0x24
-#define RIIC_ICBRL	0x34
-#define RIIC_ICBRH	0x38
-#define RIIC_ICDRT	0x3c
-#define RIIC_ICDRR	0x40
-
 #define ICCR1_ICE	0x80
 #define ICCR1_IICRST	0x40
 #define ICCR1_SOWP	0x10
@@ -88,6 +76,25 @@
=20
 #define RIIC_INIT_MSG	-1
=20
+enum riic_reg_list {
+	RIIC_ICCR1 =3D 0,
+	RIIC_ICCR2,
+	RIIC_ICMR1,
+	RIIC_ICMR3,
+	RIIC_ICSER,
+	RIIC_ICIER,
+	RIIC_ICSR2,
+	RIIC_ICBRL,
+	RIIC_ICBRH,
+	RIIC_ICDRT,
+	RIIC_ICDRR,
+	RIIC_REG_END,
+};
+
+struct riic_of_data {
+	u8 regs[RIIC_REG_END];
+};
+
 struct riic_dev {
 	void __iomem *base;
 	u8 *buf;
@@ -95,6 +102,7 @@ struct riic_dev {
 	int bytes_left;
 	int err;
 	int is_last;
+	const struct riic_of_data *info;
 	struct completion msg_done;
 	struct i2c_adapter adapter;
 	struct clk *clk;
@@ -108,12 +116,12 @@ struct riic_irq_desc {
=20
 static inline void riic_writeb(struct riic_dev *riic, u8 val, u8 offset)
 {
-	writeb(val, riic->base + offset);
+	writeb(val, riic->base + riic->info->regs[offset]);
 }
=20
 static inline u8 riic_readb(struct riic_dev *riic, u8 offset)
 {
-	return readb(riic->base + offset);
+	return readb(riic->base + riic->info->regs[offset]);
 }
=20
 static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 =
set, u8 reg)
@@ -454,6 +462,8 @@ static int riic_i2c_probe(struct platform_device *pdev)
 		}
 	}
=20
+	riic->info =3D of_device_get_match_data(&pdev->dev);
+
 	adap =3D &riic->adapter;
 	i2c_set_adapdata(adap, riic);
 	strscpy(adap->name, "Renesas RIIC adapter", sizeof(adap->name));
@@ -500,8 +510,24 @@ static int riic_i2c_remove(struct platform_device *pde=
v)
 	return 0;
 }
=20
+static const struct riic_of_data riic_rz_a_info =3D {
+	.regs =3D {
+		[RIIC_ICCR1] =3D 0x00,
+		[RIIC_ICCR2] =3D 0x04,
+		[RIIC_ICMR1] =3D 0x08,
+		[RIIC_ICMR3] =3D 0x10,
+		[RIIC_ICSER] =3D 0x18,
+		[RIIC_ICIER] =3D 0x1c,
+		[RIIC_ICSR2] =3D 0x24,
+		[RIIC_ICBRL] =3D 0x34,
+		[RIIC_ICBRH] =3D 0x38,
+		[RIIC_ICDRT] =3D 0x3c,
+		[RIIC_ICDRR] =3D 0x40,
+	},
+};
+
 static const struct of_device_id riic_i2c_dt_ids[] =3D {
-	{ .compatible =3D "renesas,riic-rz", },
+	{ .compatible =3D "renesas,riic-rz", .data =3D &riic_rz_a_info },
 	{ /* Sentinel */ },
 };
=20
--=20
2.43.0


