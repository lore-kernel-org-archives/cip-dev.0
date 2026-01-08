Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA16CF6A9C
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:30 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2995.1767864564558330120
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:24 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IGqtDXxY;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEl7gwb0KHFZ+ONDz4r/C4f67u/DOkTLDPi3nzYAUMDO0AGgBkYzGOLEpG5WFAiyqELjZ2av6s2uZukg8n7eHN0gu3XZCDwGxlJh3Bg8HmgJfbmX/zPCuFUqycg/A8euseZVPPw86/UlwUG5kwfkCKNtjdA6FrOu/muC9iqh/XlXbiGRaDSIhVn2uUISaQv+yJhJ4WgL0iJOvzMFwsa9SXxNEmEsGauWGm0DdT1DoZ5q8R41T3ZvreWBzNgVTwnUDIVXVhQvV7z7O27oWjxWRHFZ103Bx5fCGQbr/ox4sqD2IXN0Bz9dJT+SGE9Q7DiyxOlj/zq/R+/tancNYuj5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eUUVhRx+ApHUvWOvMyHGuV79Ge3AtpIT/dvZ+3lUL4=;
 b=Rn8qubPD2TUPOtM5bY2DMw04jIgZZ8UTS2AMnl+rLfnK2lziW32bwF3L2jKy+FzwKBXvA2u4LlN8za5U84FoCsc8QQo1kOdB4c+qQa830tH2n3Hg7OZjWpFtW5cQMGIbN3ztI4sMNfCCEtlB/38N1ZKwEyE6w8+j1QF1Bg+YQyazEall3MMG+rSdD14DLfZJg34NiSfapOPyURs29L1Gl4edk9K1IrAbeg9ZxuT8vntG5yCFP3dRYuCr4G+gt+wT17Ek1rzG+ZLPuIOWYeyWNh+EzrqtxdNH7nYeYmHNsRyxxzqz5qnJ5mLALnwp0dO7EqIauUi3o3/L/jXka7/P+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eUUVhRx+ApHUvWOvMyHGuV79Ge3AtpIT/dvZ+3lUL4=;
 b=IGqtDXxYD/vagdnVd3AkvmOpOIiN0rPojTXGuUywMVY2vOSHXPHoY+kkcEIpSFfLZqR6SlCQtGnM/IeNCA3opydX22mtJANhKQal6KXrW+uF0qCjDVDdZeQwZY/pKd77JM/B54BAuiBEHjfq9e2/dLRJjPJnAxokKbgRa+nVOVk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:22 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:22 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/22] i3c: Correct the macro module_i3c_i2c_driver
Date: Thu,  8 Jan 2026 10:28:13 +0100
Message-ID: <20260108092823.489287-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fbd78ba-6ec8-42a5-a29f-08de4e9867da
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?B9ZfPtBJFOAy1GIXBBZUseqWs6UVuvbZ7R09jVtgzLPBllS4HgceTf20JisO?=
 =?us-ascii?Q?a5PqNyLBGhNdHBaLYOBgLhCBz5CvInE2o5tYKKF8fjrxDPWTEn3zMFuQXmsy?=
 =?us-ascii?Q?dnD2wkWrhwpJqkW/khaTJeETq9Bkj2opf7B5jQKde2IfyXV1WnyvxWj39JUo?=
 =?us-ascii?Q?xDSwQbFY6T/DBOzzqrnPBKsO4t3AU4lDkmC8oRGrtRG3q22bHeO4RQTpRcUJ?=
 =?us-ascii?Q?dLLerFQ7aqtbGYYAz535CFuRt32jDkQy9hMQgLObfIPNXnSQmfuGobs0e1pv?=
 =?us-ascii?Q?xjUQhy/ObPtCcgMjX9KUfm98MtXfGiab8tTl2aCvbMMYlc6XchyA455Rm+o8?=
 =?us-ascii?Q?gNnPkIAXniptw7/TFJuDXBFd73huYr4PGFPU2pXtSYsIxXqBkfBTZ2aoSTDU?=
 =?us-ascii?Q?28N3OoDZv8Q+vsIYeftnNCJ0ngKbA2D0GjX/Cpqwg5I0kK0BEGKtLZhEZu1X?=
 =?us-ascii?Q?MvNP0BkcvwwL9gz0bduh9icNlDf0IRkV+L6c4echkpvo16jwHdiXjeKWT2SC?=
 =?us-ascii?Q?ifsNOmFrog1rz2pmcPTl4762ooMpiuit14xN900C7S5SxcliHoroIg/F+jos?=
 =?us-ascii?Q?DUJ5PrBOZ86bnb0JTw9zAYKSCfukyklLwUsfkI/JRR6SPRBVWT9GzVjRPaws?=
 =?us-ascii?Q?QaHlhb1obzw77DH4lUdGeRKQs0/0vUuF1Utqm5E41djvShND5dYbzZL7Jn60?=
 =?us-ascii?Q?MD8qnB49QASpu6A9MW70w2aaL6Xw5L0oL5Gj82guxdDTmHdao4KzWTeAqd/C?=
 =?us-ascii?Q?J10ooMgB2aMYKQU1liFjRuArblHyhpiIOZlcakfLQ8y8HpbgFpVgJapMQGS7?=
 =?us-ascii?Q?m04uxHsusdX2tFP1BVlArE3NusV6r7TRMQPUZhQtvdp1EbdV5VwznfCNgvSq?=
 =?us-ascii?Q?hzEdwT6/8pOdVobAOAJQwWsIdAc1qBZr3Zvk1cu28V5R4MBi/yDZjPKQ7CsL?=
 =?us-ascii?Q?Wfm/Al0fvbWLevH/2WsI8AhuxyfbmtmL0V9+fA9p3L9HNqcvhrdiQKtsw0nV?=
 =?us-ascii?Q?3NRGj6EbJau9zTr8g9RumjGXtc9rYzzDk4DHBoyikNy6mQPdWq0ApcpGjoQ7?=
 =?us-ascii?Q?hqY2bgmzH1pQ7OOMTTuZv9+1py/sPo5njbcYBH+rDd41UocouBVnoCu4q9fV?=
 =?us-ascii?Q?+YBwsvoB3MroHSk2oAyd8fYOKyZXK9GjdymG1LzH/RI/OL0q1VjPua3Wbg3k?=
 =?us-ascii?Q?FeVn7A02v1RG2ZuJqlkHPIYI1l15E6scIsZMtJRLYjN2GYyXtUp8Rad6y3Dv?=
 =?us-ascii?Q?1pmv4oh8/pemKe904GpTL3zaxgseGD6xD0VcB5QMokVcQb92rIoGlahCnWh2?=
 =?us-ascii?Q?HC5yBbIDFoe1yIqeBRUM8iQTQxYNFSqTu/UxnX4mWwKYinYwE4AO6wtJ35eP?=
 =?us-ascii?Q?bpLAdW6/3jgOihUj4u44lUC9ujpm02FpuhjlpyrRyG1sncUiCkXiwVA1rndF?=
 =?us-ascii?Q?tUdwcI4xc/vDpW7oOz+FcN3Zthz0OtgWPI47sC/Hb2VyYcpj/gkyVbST+5Sb?=
 =?us-ascii?Q?V8XgibBgR5pV2/FCifJMbYRi6vSItYzVfl35?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nvQuTUKTiw4vS7ns+KNi9GPqXiKZJZvp/LkVs8U2LzXGokY3YjiRhH0NsEW8?=
 =?us-ascii?Q?RRWp7ywF0DORMc53JYBduLcYOd6Ha6ixAwcZ76dDUJucbiC7n+KCnP7mr8nW?=
 =?us-ascii?Q?l1kXGLvKPDLd07sSwf9xrjlVc5U4F2Z2q41/H6j5H+uAAJNJ2ovT9WbwJFEF?=
 =?us-ascii?Q?z6MUGOIQtydNsXYKTMjcRBwuyLseIpAOnyohA3h0uUWLX8XCcaL5fVjLC4PR?=
 =?us-ascii?Q?0Xs91gK5ZbKdt2RYlDXc8X4gmGrkRhUReOpzBNhmiwj2hSRf7Q7xMTZwST+p?=
 =?us-ascii?Q?EHmHKq48supgfhm3tBPfwgHf7vbLnj3TOugSqGQ0f0gdCSjcMu2CH/kPBwh4?=
 =?us-ascii?Q?t7TzbaO/pqHnX/AEid83CB3FT8hQfIPPBth+t5S+1AmS6kBqH4rb6+cn68F5?=
 =?us-ascii?Q?Lt6LfVRCqBTPyvUMisg+HygZWMAqCXlwWi/OuXVL0AMyeR3pnQIqo/6Imgkd?=
 =?us-ascii?Q?ln1B8WgcqPSoy7o6fKdzYuskg4u/oOnH5eQgGajb/rHVVUNgVy0hjVmy5+y4?=
 =?us-ascii?Q?kmKgoPRW6/nFC0jAJuZ05ck5EVPLaQT6ZEai/KSVj2cheFWTz9B5bjTsWI0E?=
 =?us-ascii?Q?l/tq2of69HotInFKAlIo8ouaJmf9jGWnfTHVMqdl5Hq5fSa3N8yG3aKLmcUE?=
 =?us-ascii?Q?b21HXqU6NAQmzNCl0Sce2Dr/q84TMueqgHCZ1qHUkxHJGGs2ZgiQyL+g9vD6?=
 =?us-ascii?Q?LBbNu8+4gGpfnh8vnai+s32YuSxMY5AZqlgzZxrrlJk6WWn9ku05epdec880?=
 =?us-ascii?Q?zJnq3HBM7+ml+51bJKTzQ1hNNdthvWt557d2tPBOfC4pdOkP5Umfe7dVJCQr?=
 =?us-ascii?Q?Vjfz1f/pi2DaIwzY4BIzFhLZsCG/yA9MqLW2PbQwexdP1rT9e/IyVLpYJZvY?=
 =?us-ascii?Q?+1Fz/HOdLc9QQc4l0emCr12hXLT5x0ToFRWB8QaC4bqnTeBHjrb5QeyyFphG?=
 =?us-ascii?Q?mdYua6WJIsm4CF9pyKptTl7fKhpZATuG0HrHxZIdI8/AsO71BMRKjHJpEBOZ?=
 =?us-ascii?Q?vbylcnPrUtDj4UiT2UdMd6VxXnUHBaE8gpojDuTIwhLeqaSXElBnayxLJUXx?=
 =?us-ascii?Q?ivshNmwuOBqvhkzY0EJUOuKhtGq9SzCZXqdMDrUq3CGsRGkz1zQDDEFIFJER?=
 =?us-ascii?Q?HA7ZjO9cc4Y14G5fHAYfDgDXrXL5OxMMr9J19L0x2oJTa9RXFJTAWChQDO0X?=
 =?us-ascii?Q?uelTlkisbSa1Zhy5eYsX8CRbhIInO4OJIqim/TLwlLO9LG+WMN0msTaowavH?=
 =?us-ascii?Q?lkIwIB/X4jc2JBQSSUp7Xpxy9B50MehLskFuhcRF7Jqhnz21lz9MXhkOPrYG?=
 =?us-ascii?Q?fbDWo82czQ+Xqay5rehjlnBjNb7ShlPeL81YBuZ1vdV+dPRYQqtIOl7tstR6?=
 =?us-ascii?Q?IGpX6zjHUxH4m1Je3XOfTiVPMc8nCoqOeyFSe+Pe1BIP+W6344HxU2iDrVc8?=
 =?us-ascii?Q?VoszSz0FwWV0CyrCahPiMRSXXwRlJTq7ZenjMQ776x5Npd5kfSYoXyuqgLdL?=
 =?us-ascii?Q?1PlF8Vdp7OBRGbm1sorZSopVnGUM5wFjFbpfkIj3f7oo1+sF3tqGfflShgbG?=
 =?us-ascii?Q?/5b1a+PFwlZZjtnKkSOIkSdOFrUGC4ApIPtBLEds7x4dJem/gIivqwG+Xl0I?=
 =?us-ascii?Q?SaWUT8kPwtmeYCQSXeM0miBsoHx+ZXr6qghjRMxF3sVFdwRgk3UHkidhBXdL?=
 =?us-ascii?Q?i12zx0+dAbKihqMmGU+ZCEUAN/c602QUstieGw5HvCURrBfK9K/QMooIw1Wt?=
 =?us-ascii?Q?clnXwnjC3Jw7mOhRVCvB5X3TFSHW1BbyYWYtJ/nBlg5VWcQ3AuNJ?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbd78ba-6ec8-42a5-a29f-08de4e9867da
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:21.8383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGZCKYz/ctKz1taxOiTPL2Gsfa4ZncoD/YsVQGhTHM3mRR1YgkL/ArCBx7A3Oap/pB5x8aDRl/hgrkm6EqBlezQ5YyqrbRTQg/TlvY/dPM051uQCZiEGNFRy4b2KLY3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21448

From: Naveen Krishna Chatradhi <nchatrad@amd.com>

commit 01744ce9f07f0b76b0b2d30adba2a7c104f1ff2a upstream.

Present definition for module_i3c_i2c_driver uses only the
1st argument i.e., struct i3c_driver.
Irrespective of CONFIG_I3C being enabled/disabled,
struct i2c_driver is never passed to module_driver()

Passing struct i2c_driver as the 4th argument works.

Signed-off-by: Akshay Gupta <Akshay.Gupta@amd.com>
Signed-off-by: Naveen Krishna Chatradhi <nchatrad@amd.com>
Link: https://lore.kernel.org/r/20221205105413.937704-1-naveenkrishna.chatr=
adhi@amd.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/i3c/device.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 8242e13e7b0b..419192b5cc4d 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -287,7 +287,8 @@ static inline void i3c_i2c_driver_unregister(struct i3c=
_driver *i3cdrv,
 #define module_i3c_i2c_driver(__i3cdrv, __i2cdrv)	\
 	module_driver(__i3cdrv,				\
 		      i3c_i2c_driver_register,		\
-		      i3c_i2c_driver_unregister)
+		      i3c_i2c_driver_unregister,	\
+		      __i2cdrv)
=20
 int i3c_device_do_priv_xfers(struct i3c_device *dev,
 			     struct i3c_priv_xfer *xfers,
--=20
2.43.0


