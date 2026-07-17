Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C1C44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:49 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13265.1784294027340069125
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Q6v72liO;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EaCQPKEq8O14oExeVNIfh8SvtiOSvoHLP2GjuV/ymvlhiMo8WQ0IU8g4I3klc5P5inADqDwEg5FelqOir8V+J6sORjZpxURCkXYY1bJFMQq9b/vDUJ/2Y8wMg4MxCa2KNWR1i79E+TJld94cXRGgXFsCnvtQdF85RlAR07jxDQYrnUC9ZIWK6NVXrKLQsznVSKiVCRphF7k7dL21EOiKthnPBrGFa9bmvFVwhev1+r9BKc3PZL/Gt9AW8X7nO0kg+yx2ctkkm8yGZ4he+bCwfCDxNduIS0+kbc2UDj4WYvNRz017BJzUuMZcBmVGhuo92QdTYGwN+X8E842Ga/ZfMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdlieY6NqedUWFR4MPhg5+ya4FrsJS5NDjC7jXYSek0=;
 b=AzKkcQaIB4QeEy5wWHWVri8OR7Ye/u2Uheh46obPbNmI0Yo73w1XINgL0dxYr/Be1irUxVWHs07JcKL17dFOfbEAaCuA3J6EpmqzgzjwQJCpCnZHoR36nqR2wtfOwyaVIlHu5Vsn1wje0vWO4lM3Via50uNtBfM/i4PdiE76n4OtC2XwL0XjpV07mWFBf9/6V4KDRoeHkPlA4+rZrJxqng0MCIYMsB5SZjlmfUjVATZ4AMqfuJPNf2ypZe8tLOT14jHoNaP+TO8vpla6/y2fh3cdK49HmUJm7O5Lkapsp/P6ZJBZbakSbsZacd5wYwKx9awyd4hisviqcN4HOL0e6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdlieY6NqedUWFR4MPhg5+ya4FrsJS5NDjC7jXYSek0=;
 b=Q6v72liOTRFB4e91W5Zqk7dxInjcWb7YiSIA0NWJlld83wJeUVeIVQY4kD489iOAMb0Q28VuAfnCHg+Bmtcx0X606OllbGEUKTh07oUZbehAg6bsSopsNbl1kCll30R/yj9avKW1S2cNL12jvH1DzUE7szKAHllbr6mqGzadtH0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:45 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:45 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/23] hwmon: (lm75) fix Wvoid-pointer-to-enum-cast warning
Date: Fri, 17 Jul 2026 15:12:29 +0200
Message-ID: <20260717131241.2233788-12-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: 3faa7674-8e37-4a49-24cc-08dee4053ad8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ycxvG28sP19Nq29Md7IVGW86z/k5LSDb0UFPRrD28KCSgvCpGi63JkN+MCknmsEmZGVkIXQ3ujkaciL8Lap+eUwtHYEdsBKE3f4f3cKxYhOhqOnpcEiF63XCJVpzmiEvKEW5csW1a2I9Aam43GD2d8XGrvRrdZPq+9Q0ftB+A3FYV7Hm5pL7Ewx69wSc8g+Vt2+wfrqo0mqXtV+dE+yqyBBYQnryQcRthl01SJz1xIVUhZoRC7W6zKT9KZqrPK37oyf9d5M1hXYYJcsoWrgYO1ROQHYB/J9O84RjTtxNH2+dMVI9PNalQWK9HEMe0kwpnvfFH1c8k9V/LHOxMfCyegjlBzMbk5u9mS4/ZBFZ02kxSlbLG6qW+zZKklBZWnhjIT8dROyEeJRz84NY8XwGMvu9TQT3nR/bOLwFRDt9MJulgGb7DIzhKuRTuJ2k5QwwVSaXT9I/52mX6dRrIXQcn0thi/zg9w8RQQbZlH2e+Q809wOA+CddjTE+XBNiej4nO+8HeF6PXNi93pyrm1H9X5YBTk6oGkQmpCET5AfRgaQJPEzNmNzhlFKmpNd0BxMFAwhMo5+1vUJ15flTHBG3FK54glfR5vL9O2JyTsSaC52SSxWYeIFv5IbFhFxg1TkqUYAhuD44uIWUybBIGirQYpOqw0KQsY3N2G5HzaDSqdaoJmHvy+8hwkOf8+/CsJgCjm3kiO/uYqnXOvQ9V7x9ZvEWiqJQTtkWle0S2SsGuGY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Zb9T6rzuxQeUuYcqGNwW6nzyOvOC+cIU45jJ4rvZhBgDCC45pSXBj5oAghds?=
 =?us-ascii?Q?E0sQlEGZsuVKxE+pPsvq4dt508hu8W4CcKwvLIvWJHnItaGaAjy3amAHi/1/?=
 =?us-ascii?Q?g6SzmF2qUqjXKB4icIn5TxsbrnMEBXpCd2pOyAk7hrjwD9h3Jpt+EzDNszRX?=
 =?us-ascii?Q?zRQihT2UPfxXc0VQL5hWne1lLBRdAOVwlBUejXi34pmO+n6Pdk7xTogXQyzW?=
 =?us-ascii?Q?0ITbjDl/N5angnN11OCr9EjAZGbSnrgSc8q+l+zawHk1QeTd33LexOEqSbVA?=
 =?us-ascii?Q?OIBbutamRsEV14x5hkgwlzBIXXJj+mcLfb/zg2eu3/50K+lko7pVAOjXITXZ?=
 =?us-ascii?Q?KU7JvPYWNZ4lbap32dxYbvthLpZhsj+7AikiHgDTMQRzUB9vT5YwHP6Z8VIn?=
 =?us-ascii?Q?nqmiQo9A2DC0f+dpITBhyZkuxk0dbXjD9EQudydK90nOq+v7zawXExk64U1Y?=
 =?us-ascii?Q?iF4TmTJ0KPDTN/UqVmhTcXuEtjoLW9+ftQa7aeYcX12n/S2HkV+LT7t5WNaH?=
 =?us-ascii?Q?o4vFYe6SfRMfeNIn2npr42s5Xo9p/cIj9eMKZ59r5N7AXmO3OIs4gXgaljqm?=
 =?us-ascii?Q?KnqyJ08Lk3MylmXRfOqqFGo8Wn5/+qDk13fjQ5hJgv7xM+pDR3Tx+Q8rNebd?=
 =?us-ascii?Q?EctAxrEOFQr732TCKwazzAdCQnkgHeTl3db0LPtmfSQRN3XdWIVv/UaAXrWV?=
 =?us-ascii?Q?VbtcUpo2lor3dOjlboql2u2DIqlQUtoeE99ExPuPsc6rRI3olbnuXLE5uKYT?=
 =?us-ascii?Q?dIj4F2eQvboIq30G+gkNiIexrxkvlVYYYto5C95tVkPaGVHOpFqbz9h4Vprh?=
 =?us-ascii?Q?26Yb0kwkO43IQg+HMS2iIoPKUzvt3xfZkhUYv8kk4XVOf29HyVOlj09idgFn?=
 =?us-ascii?Q?wHBHST0dXwyIPrJ5pivy7udk7KO+EI7GUqNBu9/CSPYnbxn6ASfXMxBiEPw7?=
 =?us-ascii?Q?G5LfHX+plPdLyTN11tOJe4fXw5pChgC2Ljnl+d52usk/jl26PWHZaeZsqJ5f?=
 =?us-ascii?Q?pdusAvRY7KjzseyZHx0Yz9ciODKTw0hDtH/HfG1gL4V8q40sXnuJMWrnd5pH?=
 =?us-ascii?Q?1fGHl6fGUT/rrgtE5fh53jfsb04Sw9bX1DXWclcDVAxo7TEeKZo1katm8FBJ?=
 =?us-ascii?Q?Wa/tqoQCfpDWjWCN3nqt9PJsyV9ttCmtxVf0svYCYNb7Seu1BTAyfRZVNdGW?=
 =?us-ascii?Q?YaXOjSn2RgPXEEu8sRk+fX7BbSp4QgDIFNApy8ZOBH9Bav6b0f2LY2+m8gmo?=
 =?us-ascii?Q?S/A+G+yRknm2W9sCh+JNXA94DuGSAo+kFlRCYhYxBaYPGksWuuy5s2R3dk1x?=
 =?us-ascii?Q?TVXIV1yoqLRKn7FNkXbRxRjZGKbAxyDoMIPOVH4kRLcIiCnUm33XBY9AHgvb?=
 =?us-ascii?Q?YCR667WhJ5q35x7Th8H4N83ndg8M14VW+clowTxs08/GJYegwJqY4u3gmYuK?=
 =?us-ascii?Q?9mGd7/8hgGK5x2bm+vWPkxDgfc+TESpCK02uL0ldcwafOmBe5YXOP3eF2mNE?=
 =?us-ascii?Q?ZhlHCe4+oQFGiKgpp79IFqBWh8GVOAxnSc5FVCwL0GxviE6dfbNNjOk/NODe?=
 =?us-ascii?Q?ZXDnAi2OXic7pJ7K0xX6SSuAzPuDPHM9kZ/yPb1F5x9xFSxHrX1KHYyTy1Jm?=
 =?us-ascii?Q?/8uIC1jflhYUA+I4BJqYjNOG8H35zZaQNEM5XoF04IyjFAFbyTiL8DSMQ8K/?=
 =?us-ascii?Q?ljwQ8YwiiYIqzz/vLy2+zDaoLo/0NRrMVMihaQQR0i3KKCod0IRgVggpfzD9?=
 =?us-ascii?Q?DYP49iVcJXxgUtC11gPs+blqYXrRI3/vWWiVC+q2SNLzSz5m75SX?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3faa7674-8e37-4a49-24cc-08dee4053ad8
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:44.9905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7UNwewJdh/J+Q6/mk1akGkYRuZc1R0JWgD6J3K20YAfA2dcXEABInODO2CgZCDtGH75DA12eq3hRKGBOljG4ql4zILKcf17vBNUUa19M9TibXiws+nkAI7NgJm3wy5J9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23639

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit c7e07faa48512f4beafef54b144a1e6df25c727f upstream.

'kind' is an enum, thus cast of pointer on 64-bit compile test with W=3D1
causes:

  lm75.c:581:10: error: cast to smaller integer type 'enum lm75_type' from =
'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230810093157.94244-6-krzysztof.kozlowski@=
linaro.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index bcc3adcb3af1..10784d496278 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -579,7 +579,7 @@ static int lm75_probe(struct i2c_client *client)
 	enum lm75_type kind;
=20
 	if (client->dev.of_node)
-		kind =3D (enum lm75_type)of_device_get_match_data(&client->dev);
+		kind =3D (uintptr_t)of_device_get_match_data(&client->dev);
 	else
 		kind =3D i2c_match_id(lm75_ids, client)->driver_data;
=20
--=20
2.54.0


