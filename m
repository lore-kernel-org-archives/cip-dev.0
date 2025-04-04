Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB2FC3601E
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.69])
 by mx.groups.io with SMTP id smtpd.web10.6104.1743752350979086066
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:39:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=i3ldp9L6;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.69, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M6mto/6FCqEnVcg+tzLE4OB8+NDbKdNdXz1gBc2F6dC7IHvdrxrG8+nWtSuTzOyEiBZc1UXNxAAUdN41JfETh5qd7Eri48Ki1WC23UdxKmy9S+KVU7f0J1VIKtSIJtXWhjRf9XcJimUxowdX6d9/Eo934kHOJ4mZxz6gsofEf7+CSqAT6NhN19/9DfmePP3t3/SovOeWI2+h6LAQW41oyQpfHsjpN4MV0OG7z7EmhFDEmuvtrGVBuaNgWzj4vh8mrY15QXAB90ImrMmUVtunHHgzWApswqwtYmkaAJ5KyAukU+urGqMmr1WTfuGKGcPpzzQ0Q6XBqtdpFT3WHj27Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JhaOp6SRZR4fw4q/I8xXa28kj6HgJCeskrHuA2ywof8=;
 b=oXq7MA7Tugx/++x2foWuN3odeL9VOxzG5RZfofIpeFzz8xOXejvw2Zzzw/ktOHQhjZJrBTIIbdlEB6Rvcy497YyC041wxKCpHgHOWxPmlUYmF5OjK4viHwGLBxdstNhANOty9o4m7mugoAkjuWo1rPUnleq6Ofi8iZ65njsk8kimhig/lafSfp/XcVgLfrnA5UxWbSonDiwGH242H/hCNPpnptHKUBqls+tz7HKD/XiUqNrT3Ly3dIUxJUZrm6bb3o2gluq1alzA9f1DY0G73X3P3x9VZEq/KYBPVwZQl75UsT2klI8kFCk9ZB/PjINXs4PGeEzROi+FIoAFFgFazA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JhaOp6SRZR4fw4q/I8xXa28kj6HgJCeskrHuA2ywof8=;
 b=i3ldp9L6UgD+cS4W/GeiLqORqxDIBKqA9HOGZBoSufTkkBuuF/5DEqW0J4uFrMP9yBpo/weowKwbGwY4raTi+vbJiXpk965x5T7qnacY0nSqQp5pst2AvvfVCpUsxR87eyZkdxzMo8hC76C2KYFpP+zq89MLLkNtCTlcs639+Ms=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:39:04 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:39:04 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 7/9] i2c: riic: Pass register offsets and chip details as OF data
Date: Fri,  4 Apr 2025 09:38:17 +0200
Message-ID: <20250404073819.173272-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a2d202-3eb3-406c-aedf-08dd734bc625
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?LAqG5lO0/2D/kYtHffAJgsf0ekWSU4JOzwL9c+Qi4H3275uwveWI51nL4p7m?=
 =?us-ascii?Q?MZy1E/wGmZ4R8DD4CYxufmC9Pg/Tcor7tgBZhw07T9MDhdD51ktfs7ncVcir?=
 =?us-ascii?Q?rp3FuuHUuTmvHFyQE2SRLODsxSzs/CpnD8Jzj2pzXl7UgP69pfaqKKHoDbqr?=
 =?us-ascii?Q?lGeVA8fC3tBu7qm7eB+DmMo49V9ddrOJmmKIr4H6U00R/N3bQ5/j4CtkABgE?=
 =?us-ascii?Q?PE3b4VHKFCiVxf/vZNRE5vZ2EIBDEe+Ag/dwsP635NY3SvYj7aUGnT9N0pGX?=
 =?us-ascii?Q?RzyxVb625vWFveEWGi4Im4KtwOsKY9gxirnpiU8DxzwMAtVZZXMXqGeC8feq?=
 =?us-ascii?Q?Sco7rOhmeuUwAXBg/bHn8pjb5FpxKh88ZbDzl4jebVhjJpTHLURx8cVTfKqz?=
 =?us-ascii?Q?1bFpTpw5ftJK3cPAK/y/lFzr2O17z+qbzqwpxMBCSKd9hxlMsydyCP/628/m?=
 =?us-ascii?Q?lh98krednW7xDMglzxPIefBAqsYnkTTMgKDtFO/ElrzA2M0/1LUcWuxKpNn3?=
 =?us-ascii?Q?7aNzb3qT7b5H+F2bbv8cwboRyPE7kGcIU4eJoWkYiSGxJTcR5rc3oZb70hHu?=
 =?us-ascii?Q?V8UakLyDuR8O99L/KfvVPBvA/nLSi3NDTxuVKqjYOkKM4NCoAJx2KciHXWl+?=
 =?us-ascii?Q?qr9UowRbdDLbSmzHvoPqUhJxmSvp9Hzl7t+mxbLOyZ8OpbdiP9CAlZ8uTLIA?=
 =?us-ascii?Q?tbQFwCNZVdY3hCQV5zVN11CEgaAhLgGK4U/lQBqXEM/1PZYNrqggCOS6A+MW?=
 =?us-ascii?Q?GLsVncKS6gFKX6RP2QCscVN6uafxReUrCynjeQaNWjpvRcWh81CnbFkczZ7A?=
 =?us-ascii?Q?MzgGhCA7Kj91Ig3eharIzSNFRFZoh9swY0Xk6q0HDvf/x/tBNgXc7Oyyh0Mh?=
 =?us-ascii?Q?xSw+rgvUkVQb/Seg3ZTXDD+9BMsfQDp2BzWTCbBb566T5gzRbFnzN2VqOPuc?=
 =?us-ascii?Q?07ES6Dd78gvn4mu6R5qlolkYOsMm2VPqXjugUiXUHluBrT/13tmTnvz6cyzu?=
 =?us-ascii?Q?4zRgn82I46th7Ca4QK4eRUYVi5cPOGYtoDB1dyRc/u78Txl9H5KQmEi8XtOO?=
 =?us-ascii?Q?wGS7N54QnNzZ4OiW8ykOJ7BDLOx5t9OzT4ALzdG9V2VStfBMe7ImwdTLQHM0?=
 =?us-ascii?Q?iDILfil0PbpkK8ina1TfDulv5iJTZ3KShKYcY+B/Ql6IKnE5nPTG6I6cXqyN?=
 =?us-ascii?Q?zwVieS5/1vBZkimf4IU62O8WPYn3kUjK8liMR0zbyLWM+UZvMcq6bIxL0Opg?=
 =?us-ascii?Q?8r4GZTHWt1htIdpDdfHvpPLz1hsquG7XwBbnr4WcoLparkMCtsFKKThu/jKq?=
 =?us-ascii?Q?1oQsao1cGQ6dkYeBKGg4FDAqt+01YOeesh3EvA3tdVVu2vbKJCXmigbe5jXt?=
 =?us-ascii?Q?F2Ldf2vQzlHeb+mmegGUFvuWjUemmbIjJnEJsrleqLc5UEMThYxZNaeg1uyT?=
 =?us-ascii?Q?bOSfq+RpTxXmRorM6C+LNl28g3ab/EQp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?P++IzHw0q+8Frbg4KA79JiyDlobk2O1hLU1Ako1SvoOqxpByTRWnzQ/6CY1T?=
 =?us-ascii?Q?46m9ERIpoppSi3RddZgw19x2mRSNz0AzuIWK34iO0Oq8cq9WboWb3h4w+iPv?=
 =?us-ascii?Q?HtnXxUbTwV4WvAbaq24AqHgnwOQsgCvE/IARJh9OJfUZB6x+trW4Zi6r2UGQ?=
 =?us-ascii?Q?VxXyvGNu2y+UA1e4Swc30npwG6Hj7OWsjjMi+QduaXAEkDe5bSLyhUzaLxEf?=
 =?us-ascii?Q?5X6Svqv90W73NFJ3CZ1ZC4CEQxOwekmvGj8rDOczSeYatvTa6L3YPDhq1YQH?=
 =?us-ascii?Q?DLZhh/wQdQPZM3ooNWvmorkIgq5fs0tHoMbQ3aqZqzTzjYiqT0WHkc45ajlO?=
 =?us-ascii?Q?vKvaKgBqhjcwgu8tDLWI3IvAnO7ZmJo/A9IM9MFMBlcNrMqs5Z9PQdYZHUgW?=
 =?us-ascii?Q?4OvQahjogLvc0gx/nAiX6MfYUHI8OCiauFMcnfc75xyNpbbJOBrXkdieTy1J?=
 =?us-ascii?Q?NAkc/JYbMIUSRPz7vJ0N5DlGf0s22HXYwg2xq2UJOq/6f4fPR78ukiG+8LXl?=
 =?us-ascii?Q?Wkxef3NhORJokHSk2AdNKsSaHmNRlJaqKZ9/jm3zl6Q8wBkRgMG4fV61zyR9?=
 =?us-ascii?Q?ZcmG6HepqnzvgZbsuQWvI/bBjH+5pCEvNvJA7k86mq2vrJh6so+ahEGf5UXi?=
 =?us-ascii?Q?CEBK706lSir9MK97bPUgfmPlpxH3jJJsh60OmWzKLj8Dz5fSGUOohmwqEk1B?=
 =?us-ascii?Q?JxO+OUrqqSlJ9VY2rEwMiupo0q3fRqaoFSlOVZzSGJDZTWCdXLNaQqsxxWQA?=
 =?us-ascii?Q?HzYpqzxK4nBA5O4v+r1nEmDrOgCC4rSul3m7KcXNAkGYTHeyK/bL/ZRp/O5C?=
 =?us-ascii?Q?b0NGDwuyDPhHmb+2RKUyjaA4H5pNssUR+7nREiQDoE95iVwVUrDRwaGLYbuq?=
 =?us-ascii?Q?Yvsr/rMZhJkHYU1NxFGuuUWraocsYQDkhf1avKe8emOTuOT6vq79oHg3YTNQ?=
 =?us-ascii?Q?1XN3iqSBuvGjP26CeQ6e8w7Cg2dxe7x8AbUdtMaN9roDPwGNlKx3MNuDz5rU?=
 =?us-ascii?Q?/aCoVkBHtiBLz0XdPLeIcHb4SbfPGj0/9XcTuTnJ7Zly6QUrF/78Snq+O591?=
 =?us-ascii?Q?JyD2LByt8hJKRMQluVQkSzBMEa+27enk2LV+uGdGw3sufHE845Kdh5K0ODzJ?=
 =?us-ascii?Q?zM2g8uV8t70Kdq8SMaTaWoFIVvuGs5yR5QCdOkEX2nH4Zf8eFtPfzHSWf+lT?=
 =?us-ascii?Q?Fth2uMGPb+FN132cKS1gs1S87QfeTvJEcSxNZDXPlwOlD4took7gB/88IWOA?=
 =?us-ascii?Q?VCvFRLQ82Im2X2v64G1EtH5Nyhxn8zjn3S8qhjb4DpMyYV6Xy22qqtKzL813?=
 =?us-ascii?Q?B3mdJWw7QMcLEmcRzrbKvnEJ+qUIaM1WnIbXu9qwf6i/IdqYkHHDTCcF1h9k?=
 =?us-ascii?Q?LR4mfJhBg1TsPT6zI2LABm8f/fN+Fq7cEICDwiP7rHKxnZY40VcRRkBR8eFz?=
 =?us-ascii?Q?G/HNPA2G7kG13GwIamYiII1o07P2MoJOB9XtE1Tpm8IAzfHCrQmC9Yl1zjFt?=
 =?us-ascii?Q?L0/Olj+/nNBN6lqy3pW63gt6yQTR/9uhwSERO2GD46hDjFdubb+GpH1pbfkv?=
 =?us-ascii?Q?QHwDJsZW1/Nx6tCEUejtuKmGHbsHPBcX2eDcDPkVgDOjQlrGN8iwYtIKMUGa?=
 =?us-ascii?Q?eFPWF3txplNRUA3XaihIITE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a2d202-3eb3-406c-aedf-08dd734bc625
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:39:04.4069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JvCmViUkbU7lYOpFYqtRlpyysTHc0xws8vCUUFrjUJo0An9s2NhXrDX/0QVYKv4jtuxilNLPfk/Kc47BKYYh3LKFVg95LSfxQz+kdxn4b5kbqDB+iD5JAYkifApKNt6x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18471

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
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 56 +++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 46fd6c249c7e1..3dc806f72b785 100644
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


