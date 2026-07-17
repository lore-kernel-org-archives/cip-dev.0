Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A912C4451C
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:16:10 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13341.1784294162206399374
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:16:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=QEtRE/ji;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmuGtaqRMVZ+rgQqM+bQlgcV0KwfZLJ0jtqJI00oJYnrICbznbmdcmm9q73frSLlRhSvZUQ1JG6lR3KVmuxXxkSEfUXzbMQxQpKQR3wVnfGIvkrmKz7ktkz55+vVNEees0oE8hcUGBObUGXwc7Z/Wf2M1LfukiOoMQcqe1gI5wWOPBQPSSE4a4l7yGM5qTaoqAWCBXlCMwwijQK3xMnB/4HOdCAtpmyt8gTl4TO0holJ1TkgUzXPECxfgoHKS10T/+81fIYuvvo2sUUK7SUWdWHvTRKeM7i1h8LPcYtoEli5PWPna5PFnItSX9dWKmNj9AHSdIFRgbz9pFVtA9PgKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE3vGdDW/CJtcWpgIJgnlLcePL0xKbsZj1UHLrQ1RI0=;
 b=OP5aKhXdj2ScT1iWt0hpasilsUwwwnyx3PeUSu3R+wSbWA6TA2coSJPzYqcnflTTfCYXLQMi8Afz1CkU4/skY61muuOPV1VVDSm7Qruz1EB833QrwZuJmI5Y0allcBxtk3Sg7rPtvXS30RgBAQeITQ9n8hNVtKarvWoVq1QwVHq+4thS61iBAABk7wW2BORCEYJ03yqW3hU3JZHmw4BgYbBUE7eHqyhN02BaWURbTOXoOnhfrA/tWIHMJ/XhxvSFebHdES2BO9yAXIJbkrwzI5H0hxOy9Hd7n+/nqKNx96pz3dWk36BjMDZ7KymSgxE1iweujF3YLcxZtM5QkK0RrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE3vGdDW/CJtcWpgIJgnlLcePL0xKbsZj1UHLrQ1RI0=;
 b=QEtRE/ji7zWrbDFD1TGx8wtVgcQ5+3mWKJDcluMVLzydb2WyG2XUj9h3VxZZc2wDWxmKc5vocDoOMj+YuiMEguuc0mhqdrb/iJ9RuVdUqAC+QST4E9XoIey9R3JhRy/7TffhixyqSPY8KozB80fG5SXKDxyU3czJzVOrvFvOw9w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TYWPR01MB8447.jpnprd01.prod.outlook.com (2603:1096:400:174::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:15:56 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:15:56 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 11/15] hwmon: (lm75) simplify regulator handling
Date: Fri, 17 Jul 2026 15:14:58 +0200
Message-ID: <20260717131502.2234020-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131502.2234020-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TYWPR01MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 10109702-fb42-41be-7879-08dee405890f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|52116014|38350700014|6133799003|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	2GgvaFFh+c987Uvj9OR7VxPj4UsYhwLHGpDGTmHwIVNS/bqvzhYFEsGcPtYu/4eXRyzdzgSIGl0cLGjgjAwwQHcWCY19tI+YDz3OitNLyQJm94e9DEgvjvcPXWyvgFVEYAecqf5YiBHtM7Bbdzu7s9VomKHTIMx+uefEpU6FJl9IYDItskGWj+4GTXSaoI6xabnxGCOdnJEQWgVRGp5155THTLDYRephLDoW7tqB0yaMRnMGJqSZkEIbGSvUJqUDEhwBU9YPt1wqs6sz+SVOk6EnZTdHojmRXrzQ7nvkNrMItMtLfcZOjZIEf/uUjg3MCe7r+wRvECIWmzOzVfuYkM1xpZw4+oz7NfF2eAHo+BdX9rHgNdzCpvZy09hJV7tMF1l+amvZEhl8tAS9AkfpI5/KN4gxLWqUtCL2jr88IDj8BczEqmisHDi6C0GWd2m/IC3r1jkmpz6iFJTcRUAAhsuAavO++RCHC8IqcjBE3GL0tVS31Gr5tVAN9T85kyOfFW23FrgQJLkow9F31PtD7b2j5/B1vP7YcphdL38wJF1FWyTspnsdaWkvR32p/1jl54MDxu+YzgnQH0Ez057lStrVjq2YKmlGZS/3My3MWnNxEg5tqnUzW+MgVvXVwDnFU3fkxKQJFm5sfs4S9Hx7bIJYc3b5YzgFwyPuQCQ+4IKFdbcqEIW6/W86CjmDVQTG5IMpUdus+Vs2t28F1btylIRgIOdcKr2t3mZsVU5ER88=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(52116014)(38350700014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8Cry5WnQa6cBw1aUKICCfnnMsYZ6d5eEvq+Ai3NW6CWclW28e851r1nV8kzs?=
 =?us-ascii?Q?x6MXyKYaLp5xnMcrmQaQP+cPJ3AR8UkA9TUn190qioFRIoPLq773ToJPWrVV?=
 =?us-ascii?Q?sqa4+b2XJldaUBNXj7niC7n7clvA+QVY7OGFJrv5Zdq3hAwf3t3yaaFD+MyO?=
 =?us-ascii?Q?9oPRVLKjMC2a8Nt8fq8ZOymoU8PhiYdDHiQUl6EfAu7uo+KH/HrBX6fm4VxX?=
 =?us-ascii?Q?CCzuqszGp1y6tnDwT5BlIypgrdMMP2LQ/wJukaS6OgMKP7sjfhmvpzy50jBa?=
 =?us-ascii?Q?mI2q3P27apYsHLB1u6yYg2wtQYlrHmo1joF4PXi/L9ViECD9xPEP9q4c5QtB?=
 =?us-ascii?Q?X1DJaWtpUZLE0JOZ2ZtvV3kNsFzksRvhjkxH2YLQBQqzL3iGrYANqGWWFf1Z?=
 =?us-ascii?Q?3IFW39PXBb7TKslOK61Y3a6YFBceeJNY6di/0p9EXcf3lt14klvxE5oIH1Ej?=
 =?us-ascii?Q?SgSTiK5lYs3vi2VfJjBKv4ShDqk3h+050L/ExgwRxqTpBQDkXSULY3HqBgsl?=
 =?us-ascii?Q?dlVcHaimtJY7ZlAt4GMelAuGsM+ME6VBPAEgIGVGoLYaS+kPeXBe2hUHHBFD?=
 =?us-ascii?Q?FbsC28asFY92318LF2TOx1AzR8ECT1sdTuGm/PPj29N+600amasrLTHOxD/u?=
 =?us-ascii?Q?sNVvr9h+4nd6DuC4CQurLEGV5Gz7bKNTNvcBGW53Ha78s2Ruoau/IUVRZ2R1?=
 =?us-ascii?Q?xxYme33PHo969jSOYuI1hqN04yu2it0pGwD1b4T65af86rsyRmksq1Dvp2Fb?=
 =?us-ascii?Q?FeC/CDPa5fxwN6lsfDdV2Ji2ab1TbXx1ziOqOISpbi3aUhm+fB+Gnq5tmwBm?=
 =?us-ascii?Q?WnfLlaEA7IYEaSkIoxSu72sPC2DHqRPaK8z1rHv4m6/GvZtrKKGA0xkBGeUa?=
 =?us-ascii?Q?N5ZGd0cOMzmYraPgsC+1IuG4UjZChjM2vF5YZYZjGn9ElEqPwV3q7BHtuBOA?=
 =?us-ascii?Q?VeqclH8XuKERBe07OEOoW+/D6K5aF3tc+dw+0xp7CJx3RzL5UZi3GRz+FRCl?=
 =?us-ascii?Q?GhSXHPjrLP3CDGouIQcZsdBBp1dtZL/1XXFhizOctysLQbiOxLzbe4kjnp4n?=
 =?us-ascii?Q?RUj+WXToxnLJtK8tly41Vyelhk9HqCr2XM+W4/pEvZ0edaaEtN/YFVf8rAQi?=
 =?us-ascii?Q?Bs1X4vpnHRbKZWwf2ISxgq71AV2E8fV7WnaGNZFV+0noXcU7o3sv4TLjuwtG?=
 =?us-ascii?Q?BOVEjWX9zwTbSvoWsTMma1pi3pAGE8LCfswVz/V91FMAeNVc5tCeT/RwTuAl?=
 =?us-ascii?Q?B8xL9sj9HJ6VrUGzWOWp+FXX58VHlcxKLjpJxwmUFfNU4tTxli+uXIepBppz?=
 =?us-ascii?Q?jugGZa1gXgFnaetGsBR/GPhB3dIH8k8ILZIIpzabkxU0aAeKFnOXiNrE7/u2?=
 =?us-ascii?Q?cLz9ImNXH5knHqYhkhNk72Kew3Fb+xwJO/x/QC0tVoNlQuwu0IYaXd8A3FS1?=
 =?us-ascii?Q?KqmltQpRj15HrYUAXRNdWsXC73ZappKYNx5pGRIj1/uF6Zie6utyKsw3wfJ3?=
 =?us-ascii?Q?LA8vuYObyWu+KZzHgIJSd/4U/EvIwGgV22ch8V7poZv+Jnc7Cqxoioaf7zqm?=
 =?us-ascii?Q?Kv07gbVRV/fP/+axWQtWOLBTPh5jlOpXR5YF57WNaFNQP+WyeNSyGkS7UJbR?=
 =?us-ascii?Q?IT1coTZj9XWzjYZez0UQ2XQmVCHNIn3TxyAx7U2sJjNNVGWDuM5bEowY8z+4?=
 =?us-ascii?Q?N6Ci1xt4q3HKsJCCTFiGeB9Onmog1iUedPQ8k/AisH/pkugqKqHYIYqLcqqP?=
 =?us-ascii?Q?fT2qNQYvPCYpi6mN7rNWkMzHzbyw6wn/r9zxphRYQxPxpcp1S2HY?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10109702-fb42-41be-7879-08dee405890f
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:15:56.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MEsQ3VZp5TQCMjcsd5+eTtW8tUjV5uobFvTIhD7IL3T4F0pIBX1GHXMdPtke8bPr3YlgJ4hcXRCVXF6kYjOIvDMhNycr38C1tQBnlLoLS1HiBPjO8AMdeEgCKxHqKxuS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:16:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23663

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 2b64c6f652b0f5435b293d33f7d231132e987fb2 upstream.

devm_regulator_get_enable() was introduced exactly to avoid open coding
regulator handling like in this driver. Make use of this helper.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20241219225522.3490-9-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/hwmon/lm75.c | 25 +++----------------------
 1 file changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index b03e760cf3a1..4d0fd1c93c63 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -109,7 +109,6 @@ static const unsigned short normal_i2c[] =3D { 0x48, 0x=
49, 0x4a, 0x4b, 0x4c,
 struct lm75_data {
 	struct i2c_client		*client;
 	struct regmap			*regmap;
-	struct regulator		*vs;
 	u16				orig_conf;
 	u8				resolution;	/* In bits, 9 to 16 */
 	unsigned int			sample_time;	/* In ms */
@@ -621,13 +620,6 @@ static const struct regmap_bus lm75_i2c_regmap_bus =3D=
 {
 	.reg_write =3D lm75_i2c_reg_write,
 };
=20
-static void lm75_disable_regulator(void *data)
-{
-	struct lm75_data *lm75 =3D data;
-
-	regulator_disable(lm75->vs);
-}
-
 static void lm75_remove(void *data)
 {
 	struct lm75_data *lm75 =3D data;
@@ -656,9 +648,9 @@ static int lm75_probe(struct i2c_client *client)
 	data->client =3D client;
 	data->kind =3D (uintptr_t)i2c_get_match_data(client);
=20
-	data->vs =3D devm_regulator_get(dev, "vs");
-	if (IS_ERR(data->vs))
-		return PTR_ERR(data->vs);
+	err =3D devm_regulator_get_enable(dev, "vs");
+	if (err)
+		return err;
=20
 	data->regmap =3D devm_regmap_init(dev, &lm75_i2c_regmap_bus, data,
 					&lm75_regmap_config);
@@ -675,17 +667,6 @@ static int lm75_probe(struct i2c_client *client)
 	data->sample_time =3D data->params->default_sample_time;
 	data->resolution =3D data->params->default_resolution;
=20
-	/* Enable the power */
-	err =3D regulator_enable(data->vs);
-	if (err) {
-		dev_err(dev, "failed to enable regulator: %d\n", err);
-		return err;
-	}
-
-	err =3D devm_add_action_or_reset(dev, lm75_disable_regulator, data);
-	if (err)
-		return err;
-
 	/* Cache original configuration */
 	err =3D regmap_read(data->regmap, LM75_REG_CONF, &status);
 	if (err)
--=20
2.54.0


