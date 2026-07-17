Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12813C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:14:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.5])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13162.1784294051857736448
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:14:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=WTUgvPxS;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.5, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vUHbZSMWrdUt00hxlCs6CQqMz4IkMZjqyFhFZxz3StSCGdbr17teM0epcEdjJ52ckBxd+cSsZEUYX3XHOibMipcdzjX/HJuz/+2rx+ty+/AQCzs7wOh0XLs2QSJnxmQbrO7S+VeZaG3920QFYYN2Kbp+ysEuuqQDr1qURYLT2c1DhYhEQNMygRB4ZmTNZpekg4g4xTPdVga/3dfS8/HjPbFbImlo3uBrIr4XQ6RLe+VYcUtbWZzYXWnfgTdmGINr0xYhwp2F5u09f57kOcxF3WKGSS8Jydf0/CZH0v+iIWyJMm69XlsSPNtUaQxYDKIA0siRqH9ysstKtn0pylXMzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q18C5BdrJW4SrAeunabHhYXan6SzhFR9QmK2/VV4kfM=;
 b=vBTB6xk313O41IPnnfQOopWn/y8YwNrqat4heVJuNpX050Po/HMSSCLXItdWbiISMpIwhazQiVJebATPu46W/A2cpCPY3guRpt2E50MTY8RGEle8CH5CZ55YgUDIDJmvaplXGLY0oPjRTYMH4rTG4UGA9R7jYiPBv90F4xGAQdLdpy+higq97aZ0jPujEa8zH988X5Jw2xwYGGBg4ETIf0T5tyLsN0G8QZnJzgAAFFgi57krh/2rGErzoG4dLrSgMgSvnzj5JRQ6jvoZHdOPRn3wWJ6X3eOmxWODTNvFUMEaJs29v9Qpr2/lq1Yjqad9GXjuS8290+xtqVSE7pHYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q18C5BdrJW4SrAeunabHhYXan6SzhFR9QmK2/VV4kfM=;
 b=WTUgvPxSingSCgQA6dazOqVV8jtdLNOGYJHppzE/Sdkbkkf9El2rFDeow3orl8derkW8aElhFVQs0B622MuIOwATx+YroNQzRcgF+45IaiS0fEkrBYRw4sb6iQNryAcUua0OdyO5eowbMdA/p5IIP1R9ifCuicuz+5Gl6TAEI3M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:14:08 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:14:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 18/23] hwmon: (lm75) simplify lm75_write_config()
Date: Fri, 17 Jul 2026 15:12:36 +0200
Message-ID: <20260717131241.2233788-19-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: d08fe98e-f081-4cb4-5376-08dee405492e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	IAdV8L6B3g7BMstq/H5QM6eUeXMFdkdEkSXNlsNqtB22bL89ZWabmkK7lULxh2nQFTliWV47A8SbPw20WkzANDNoYC9Q5C6hBtNKCOModBnID31QKkN5wwINYThOBMsGMt1Xc3IPySO6CfLvcoLRHyP+OTZ4McBcaNt1K7LwvhBHgz2pxQ/Gv73yYJmMhsgLUba0qhE9G9ByqHgAOqwRolrk7NJAgjuKMtwbqVIVgdvHEkO+Y3XsE9urmKqqBsripxiNjOZqbhJLkF7Y4pfse6wJHqEY5cl6cD3YFa6vOKKnyJR8kEUqvWvhisDx/Ezqc+IP9tuikR6qNWQ/I621IyspryQheAHKRv/2dpkuTESpTDoe1EhgsrsiYg5Eo4bzYPUPDV91nrHC4T3Mnd5SHTPuMscRl5OXsfiAY5Hr5Ce4ICsctv7jBm/92TrZEhT9HLPYfKEEvq6j0rkrq3YbM2OHhAQcstJkEX3l7B/r3WZexX7W4pvn4KGfzJmLT+F4eo/o/HP7IqikGdzIl/w6G1r04OPMETzCpJcGTxRkAoju2QRlk+5FPYqh6WH7kVigrHs9BeHd0alkEpyC3sTi0FCedMdVdkF1LJYHD9EuYhEbgYYkqI5oHWs9vhBzsje/1uJ6fOHOto211XqNJYV9NOOf+JbcFXJbtahDKo1Kf6/U8xNFB8ja6qsiZ8JQfwsJSoEx8OkEgHQ2wIWU/3QjeN7/UkSgqjsveOxwTjfF1dU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uN4O+i0cvT8Izs4RmeyIlnDmGArKapH3LtAcgKhbfik6IU6GJYx3OfTkJYSU?=
 =?us-ascii?Q?TkT5Xyxj5RziXsndkuVq9bkTinJJUk41U/qhklc6ASkoQE9NA0Pu730DCkXx?=
 =?us-ascii?Q?IjOl4Y8OJsPkKHPmHisoa4vQolyK+Y/kYS/YOelWQ2i6cf80skXvHjsaycRZ?=
 =?us-ascii?Q?/o/K+AjznFJ7wDRheKXLKsQp5CKXvC3UFaU5RBgCD76m4yE8PEPZxTEYhv1A?=
 =?us-ascii?Q?ovE0sis+T/WYHu3ySfNmDKRJ9+e5bCoAMW7+jCjeJ12uylPLJfy4FCFpwurQ?=
 =?us-ascii?Q?M+S8lNMNwNbvzWunLaWzNPkboP6I6LGLfItpuUQxH2rCPU6FkHyQyhTDDMd2?=
 =?us-ascii?Q?qNNvcH21/EHGZ2HLdpZF9sefc03A26zKnieTAtMeLMS/p2Dg49oP7wF+aCtD?=
 =?us-ascii?Q?B04X0zK2z1ZmNjUdmknPwW5OSvUwMoLPyT4CND7KFnlbjxTarmaQ9X1hOJ4e?=
 =?us-ascii?Q?GJTnc3jA2hBkHDba2VM++atHrtv1ZDUfDUyrn8uwBjICQwQD1wtinFChvM9A?=
 =?us-ascii?Q?T11E5krl67twcfSaw4vkeyJa+JQCnerWfdgwwgd1GvDv5XFFESQiAlY+WmTH?=
 =?us-ascii?Q?llPXCPc7wSPlU4ItBCK6MI0iYQpNYohW7AYbzmLTjP0Fjb3484/T3dWhPtPp?=
 =?us-ascii?Q?VJabZ7QgNOWJsYVNqF6g82gsPrLX/IoTkRjb1POjgMbnBm/P9MUYG7mYa00k?=
 =?us-ascii?Q?KrAEU2HGldPcaOH4euggL1ALaBDlPwd4bnSi4aI8UrumL9Ohh3PEuWRVsOyd?=
 =?us-ascii?Q?n194SKoeCo1/tmqyz8L6TSOhZgITkIgbgpMehNEyZQ/TiZ7VphPXWueXH6Mg?=
 =?us-ascii?Q?Gxz2T5fG805vwfSzCe3wbIUBCJH2HIQvEWdAmD/dTqt5+LB09C4P2r/SfA/6?=
 =?us-ascii?Q?mgpkECHvXxIvUJpl+2z4ST0M8SfJUSYvPq6ULZAjUs6789GoSe0MXPnaUy0z?=
 =?us-ascii?Q?6p3lUOIGwou/eX8b1oXcD+QPiD26wJ2M+s6B6JqMGPvdSRvdWhpWn97KcbeR?=
 =?us-ascii?Q?PSkUEiJUG/LMvSl2ksoE2B2kt9b3U30ucNVrhXVem4TNSbDRM7CE9adNzZZA?=
 =?us-ascii?Q?NoW/MHZFtDJSewF0BTC3p0YCP5Q68A1C3g/ZH5SdmxyA2Xaa47xQv5OAh4o4?=
 =?us-ascii?Q?w2KmywW5FeBdYnOSg9NVfipiKMWZItM2WppcjGZmyGD1H1f2QlZd/jEwvkGE?=
 =?us-ascii?Q?HOt/7ipC7rN/JuzhgVXsbM5kq+0R03crCEMRZzjXAiLnJSco3qrpya18J8MO?=
 =?us-ascii?Q?qT7D2jRuBxW4xMhdLL00B2Ax8mrLZK0/VfHUtT3Y3zRt9vJ8uNbaNFQoh3nu?=
 =?us-ascii?Q?hoohmDBa63q2DB7vznPUuOHmkZ7hGHPOohA+1Ci71KEgp0zdKqWkoONKEe2U?=
 =?us-ascii?Q?MrAxbVTwL9wUYwRwABCn/SzS/kTdG+jS8C6XXopw46im0kfh9qo3YcBaooU1?=
 =?us-ascii?Q?n4Z6LrYpvpQGD8LQ6Qjyx3/oUcQbpKhSFFBZDjMrA1XVtTzNBiSpgZ/o0az7?=
 =?us-ascii?Q?fDsxdojMQk104QnGyasnwpMF6JzaWWJLE5ugXtKUFZaIfpCQCLRyPXLpqmvB?=
 =?us-ascii?Q?JgVNplDpIEp6h5QiRA4hJpLJpGQC9991Du1aj9W3g09T28ELLAJsv3w9JiQ7?=
 =?us-ascii?Q?niRFa8/DqHIZxEOmBhOJ5xeaXDqyX6QeTxc+yu9gKTLm7H7OcFi7fYRVyMwq?=
 =?us-ascii?Q?nv8PVOdXgrL3tnW5bO8gf+WIbVN9CEBgCQvohJUpiT3UkVk0lXiJAHY6rzb0?=
 =?us-ascii?Q?0a4YBPKnDs7yh1FAump+bcH8tvmDhZ82uXAnUzvcOhpP20b+wpYH?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08fe98e-f081-4cb4-5376-08dee405492e
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:14:08.7689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdScDpqnKmGwB6s/dZfHROstWFQ6xJm41VxIvlXnq8aNwgDHfuv3/ReCrkvWVgUki8Gco/sxKt2ul2HjUNjt2svjBlgAQIzNbM2R+m5F87QXUI243bLIqHqxuBDcqAuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:14:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23646

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c4d08cf8a03eb9b14858a9b8cf8f4d71a639da57 upstream.

After previous refactoring, it is now possible to make
lm75_write_config() a simple inline function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241219225522.3490-8-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 4bb3d2959593..81fce8bdb929 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -341,17 +341,11 @@ static inline long lm75_reg_to_mc(s16 temp, u8 resolu=
tion)
 	return ((temp >> (16 - resolution)) * 1000) >> (resolution - 8);
 }
=20
-static int lm75_write_config(struct lm75_data *data, u16 set_mask,
-			     u16 clr_mask)
+static inline int lm75_write_config(struct lm75_data *data, u16 set_mask,
+				    u16 clr_mask)
 {
-	int err;
-
-	err =3D regmap_update_bits(data->regmap, LM75_REG_CONF,
-				 clr_mask | LM75_SHUTDOWN, set_mask);
-	if (err)
-		return err;
-
-	return 0;
+	return regmap_update_bits(data->regmap, LM75_REG_CONF,
+				  clr_mask | LM75_SHUTDOWN, set_mask);
 }
=20
 static irqreturn_t lm75_alarm_handler(int irq, void *private)
--=20
2.54.0


