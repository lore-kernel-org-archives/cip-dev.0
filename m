Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88993C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:01 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.63])
 by mx.groups.io with SMTP id smtpd.web10.49079.1743418013966373336
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=K4TQTXdR;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.63, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSY4l3sM47Fzn78hjoXAnoyIqnS29saIQ/oywtoHefpRvyErr+dVXYsx3XZFKwMbZ3/unZhWxbV4iGQJUw2M/8VKzIa6r+VZqkBYurN0MsfzVFmfoJWMBKcOnWhSagSbM/XpVjzqQdj6N7OdirEhdxayM91bDHFSnCuhfVNodlnKV9ffZn22kn9i2l+GBHy1AumOSBbD3A6BxdrMwpawcODd+MieOZu/4DRgoFn02W4yeWj1ItlEIl/+08KTyn1dB5Jcf+2PlqzFFPMSygF0nntHeDvslN7kf/ga0b14v0Yg/01zeXo4Zn9Hs6JhBXtwQCFUAPOUUv6ay/YaO4Y9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBEFhnT3CVets8zI9wLf/TNnBdIi5ovNKxwzfsR7gLA=;
 b=F/TZlPtbwAGFT+rC9kfCVNHH6/P2xlWdgTIViOkP9DjnOrk1cI/8YQpJDfuZE08xs1mXw8nXfJMp9ymVbp8zY2cYUxg2Z/jgb4JZ62OtTtuatvhBI/eCUXrS0ej4OTRiVs+dCUaAfwbRgcABX00IZOW2vSiBVBiCjZ4uEUszo/RbCSd6SAX0TqkvItaRqGrtKikMB/RAh1AfM2GHP1+dfWwkNs1zjsQ2Rr6iOkvgjqOdbG4pVZpjtfJGp2APfCSoB43j8ja0l7X3gWBMoWTvcsBGD9vCLtK7slitXp/oTj/BPkQFfvGt9E3gwPEDPThdGdZ3EQPrJ/gAZEO3aRX8vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBEFhnT3CVets8zI9wLf/TNnBdIi5ovNKxwzfsR7gLA=;
 b=K4TQTXdRxok9J94wYsC//zRh1C5nqfnCXyi6rZ9xrQYqDh+eRPMROdnTXYNV7J7Kv+v8oxInFvBb6koEv9kA6NM40YyFy/jGMfWWZAedbOY82Vq2puWBZFlF9ZCDOXX26BXy0ifSImWBFb3P/zmHuDlN7ZDOHpngDvG3pWeCxiQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 27/43] pinctrl: renesas: rzg2l: Return -EINVAL if the pin doesn't support PIN_CFG_OEN
Date: Mon, 31 Mar 2025 12:44:58 +0200
Message-ID: <20250331104514.79090-28-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cddcc72-9fc9-44c7-7a0c-08dd70415889
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?sZCwE9T1I1AFJ6uguGvgNu8ZkHnwLfbx5ZrtlKbgUw1e+FyUu9dviMD2CI0s?=
 =?us-ascii?Q?4QyQl7gypVLJzMOQa6zSbfS2JpaXYKFuybTfUCCL0fKDOLIr/DTJwcbqq0x8?=
 =?us-ascii?Q?pcXoFiccGn6WbubhxGHgkj8qXpM5t8jxaBWxzUKgZwp4qlWsmivXVjGE5VfG?=
 =?us-ascii?Q?2dIu4QjkC/rvQinU7KJH1w/57e+Sfq+5JltyuOE6fSztYOJt+7GJSurgrdqu?=
 =?us-ascii?Q?9JOxjVuoBp2omrF1q3Kega5Owlaus8kMqsnvjzeHyYFkd9aYGPm3Ms7qpCeo?=
 =?us-ascii?Q?FgHxYFxXqgGsF1h0v9Xuj6TAkLDJUgqKKLwx3TsMvr8KFj0UmxcB1L6tIeAi?=
 =?us-ascii?Q?ObRHO7qh5SjDicWywIWMdOBMiGmMCbIwfvYA9agjKMGpry7bz++ifXMS9Z3k?=
 =?us-ascii?Q?06u4OR87h4C+jeO8T9wk6ndpjLRsqvqVdUGmPPg+EXf7JpFckqgeUuQzTytZ?=
 =?us-ascii?Q?/YUVe8Fbi84ad8gg2WXod4WwGWXTagHL9sqG1ijAHZXh7UZrAtsLvnyluWMt?=
 =?us-ascii?Q?PGZ5rqKEaYJ3Dxc9zcyidtz2LUhB3FZBydejdADV6+4mRjiIlpU/P2N+qL3T?=
 =?us-ascii?Q?B8f4OFc63Io6jiGp+gdeuuX5azxAtmOyrqUqmcpG8tAmbuTT9hfd6yx+F1ZT?=
 =?us-ascii?Q?ZvtjttmEcpDw/uoE70YDP4zVw69KY79Pe7zvdHOMuMysKI1XopjUsfKg4cGX?=
 =?us-ascii?Q?kbBBq6LUuAR7fN1MGDYmlSiOnz4zaH5ltc57Y+2XIcQuG7BeZgktXlGdd8Bk?=
 =?us-ascii?Q?xF+mZ8N2Mvx7nZ2Bm1RHna6AIHBuSaCGJjecMCPNjEn0KEeNQXSwqJW2ZlP4?=
 =?us-ascii?Q?Kq9GMiniSjeHrHSPxmHvXOOw9u1QRtMVMo8g4WZyydWet7oahWpbk2ed3/qa?=
 =?us-ascii?Q?KTpsaQ2SVW2t9ejH1dS00m6HlMWsVQmxS0nYKbwrweyblPFM3Yx1BSU9I9wI?=
 =?us-ascii?Q?mpMP/b/LPVUpMrcv9GlCNbC66LWtCpXZVnRkWQIROhAoHSDBztHV/fhUz9kd?=
 =?us-ascii?Q?agTBigs4yVIBE5ffP0v9L2j6b6PjXKCKODnX2jW/N9JF9ZruhDlJOUMwWyhd?=
 =?us-ascii?Q?lgcyCibUip5zPrj9bXJ46Ht3xt6uXeH06Z/d7UquPEe8YmVF6sfW/aJzl9/X?=
 =?us-ascii?Q?4wzo2/ZZMDyp3Pc+pvXuHHsWfF8Fw7Hms1Gj0QcF4BYRfyIxEonnmRLoRuXg?=
 =?us-ascii?Q?uMk6axp1ZvuRgoDtgxdypN4nlh9fcTKiD6pPX5EHGMAfwjbrm7+sP6HqPIMu?=
 =?us-ascii?Q?Lf0LQoBWtSE6dNj2YkPuSizb+J4/rj5EBp+KkEChaw7q4YnMsDy+wQiA8Yr6?=
 =?us-ascii?Q?FGTtoqaHP/jt1ddeVi76qDqjjovXYlSyfQzOYciSjzjOej8eatp3mruFh2TK?=
 =?us-ascii?Q?Pob5jpCJq33zgxteoPjnsDTQP++FeQ13jL55mUpEXgoKK5Zm7ZOaP1qwZM4Z?=
 =?us-ascii?Q?2/SxCBQ4T6BYZ6FmUGPNI7l82alTpRit?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?0I44g4RXXRDkL1sclyImFAl56qSgQOoigW8RUwJc69YQFZkG45okYbVLaz1F?=
 =?us-ascii?Q?v4cwZdNx3DcYYIlncbzmRFKTHJ0B5CD31J1FrPrVoUvYDOqFzbbBqJewg/4r?=
 =?us-ascii?Q?YagF61hu/fiF/wtU1wFbRvuq671idibmf1on+g7tp37XbfeF6UjKyT5cdEsE?=
 =?us-ascii?Q?ovG96wnt+EOnJmulCHJJugz2pQIwQ6chBzr97wLuoKjUPeduMmLMlAtjKzkv?=
 =?us-ascii?Q?uc03g2hXgBW/msTRPN0J/pzpBxLaSCBphTuttCcghDUJREIiKv7v/ra5d+ck?=
 =?us-ascii?Q?G3nEd5V6XIfBe61SNDELfQlJbPtz1J5cbQN9QC3+I4czkzrXLARffGjvJRIa?=
 =?us-ascii?Q?wnuk6h5ZGg9YlF6Rw7IL69mMoOmiT1d6eEftoVoXU+i0nudjI1ehS8CzUAgX?=
 =?us-ascii?Q?jifdzDmvfizxQf/e/PQKgg8B1ssjrJzmq7YpKloepb5pqiQClSWv35Zo8QWw?=
 =?us-ascii?Q?kYpxdNEK/wplfooAQSdyUA0rGRg3KCnOrGBRAmRdWEd7wzeLNqOCItbBzigW?=
 =?us-ascii?Q?LoVVlotagBZ8w2OycZ3OHmFbA65yGOeU3CJpRQMkvebnerICzqLZlocaQfBe?=
 =?us-ascii?Q?d76wChpWhp8zH79Yh7iWl3pZeB2mr7hE7FtdKG8idmnhU8wYbRGwXl66IvNh?=
 =?us-ascii?Q?xCgxugm98/Ys+BnJby12p190tLxbgkxIkYD7+tJxMcsA22zDu6UenQCvrZiW?=
 =?us-ascii?Q?/8Zdrh4aYWV7hHCA+Zl84Z4mv8qIn2FiI/7sop9w9ZwE5BCJsczZYjiyWmEY?=
 =?us-ascii?Q?lQXwwKVt4b7k0cOmtNQdd8UwBBjEG8qJ26rolxVgOowmNRVOLN/0R5OJYALg?=
 =?us-ascii?Q?T0XclHcmZCuJwSpC2Yjxxtb40FNsd9FcEJLSCldirdX2ukmUAAwrHfYTTnZU?=
 =?us-ascii?Q?ESE+4VF5pxTbE2Kibgz6fvPuo5ZAoZbm5ClZgDMuOqydxbECoR04UJe9N758?=
 =?us-ascii?Q?0nGJxtxld4us5Oua/rjt1ftI+JniEKvFHK71b3mGP4HM1X5aYgONauwVmpEM?=
 =?us-ascii?Q?2lWXg56p+lhnet8ALEk6a6PtzIICBx/LPB/iDW2ejvNMGCLzqfpBoT2WkF32?=
 =?us-ascii?Q?JykFVAdKd5sCi0XEROjhbGHCIHliOxM3ritFExtInBc83Xk9GcezQKnfeR4n?=
 =?us-ascii?Q?sMLS/MPC/VMDLn6Zslb5yrXWS4lL0JqREfUefZqoAioXyJyMnmlwP6CRvw6W?=
 =?us-ascii?Q?s5Rh0tSfwrP4lD64FUt6wF1k2V9cu/1jsV9+ss82a+1l2YOthRDQWo+MvNOh?=
 =?us-ascii?Q?jcc+niPKOpcqoeaZ1EjetyposhJPF0UgjhigyxhoF03sToo6/JdbGuf10dqA?=
 =?us-ascii?Q?5Y4NgYiI3+e7guqQTWxWVEuxiQgbveonsty+h8FQ6qfy/nQThC9NbadrjNTJ?=
 =?us-ascii?Q?zpzT+vnAq/e7rYm7m9xKRRVr/VUd0Ku44EDd7hwUpwP2TTVznbuOG7Mfgrka?=
 =?us-ascii?Q?wVYm8y9ltpQMDIS1EMhwZF0HC2yIhoy54NkwIghC42IDuhJdA3qRrjEf/2nF?=
 =?us-ascii?Q?2caEaS5uTNW+Iq2nTwB3S1I14vDMZsJ4W9BOCGOMomjcgApDW+wFbHViuXzM?=
 =?us-ascii?Q?dklZaS5oHRHs3hOeEM/j8/A52CeEEG9Ny0/zCmGeHUnm5AqBINfUmysp18D1?=
 =?us-ascii?Q?/0GqSvYlgJvQ2UPe3qr7FZQ=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cddcc72-9fc9-44c7-7a0c-08dd70415889
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:52.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucjlLfOqSopVbY1sFLg49qSWwZMKqwcL2fUdVNbyvBv5HuEiU/VhcTyG2ykw7BPanTiEo7Am9bSqEILVO/WuVYnbIJ2CXt9dgUTDgkan4zGKgMuX+jRzxywACgLUqwm1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18415

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d56abfed1c02814b5ee96b0ed1f989ea9d7f6cbb upstream.

Update the rzg2l_pinctrl_pinconf_get() function to return -EINVAL for
PIN_CONFIG_OUTPUT_ENABLE config if the pin doesn't support the PIN_CFG_OEN
configuration.

-EINVAL is a valid error when dumping the pin configurations. Returning
-EOPNOTSUPP for a pin that does not support PIN_CFG_OEN resulted in the
message 'ERROR READING CONFIG SETTING 16' being printed during dumping
pinconf-pins.

For consistency do similar change in rzg2l_pinctrl_pinconf_set() for
PIN_CONFIG_OUTPUT_ENABLE config.

Fixes: a9024a323af2 ("pinctrl: renesas: rzg2l: Clean up and refactor OEN re=
ad/write functions")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20240723164744.505233-1-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index ba0122b46da08..7168495da5659 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -1261,7 +1261,9 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 		break;
=20
 	case PIN_CONFIG_OUTPUT_ENABLE:
-		if (!pctrl->data->oen_read || !(cfg & PIN_CFG_OEN))
+		if (!(cfg & PIN_CFG_OEN))
+			return -EINVAL;
+		if (!pctrl->data->oen_read)
 			return -EOPNOTSUPP;
 		arg =3D pctrl->data->oen_read(pctrl, _pin);
 		if (!arg)
@@ -1402,7 +1404,9 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
=20
 		case PIN_CONFIG_OUTPUT_ENABLE:
 			arg =3D pinconf_to_config_argument(_configs[i]);
-			if (!pctrl->data->oen_write || !(cfg & PIN_CFG_OEN))
+			if (!(cfg & PIN_CFG_OEN))
+				return -EINVAL;
+			if (!pctrl->data->oen_write)
 				return -EOPNOTSUPP;
 			ret =3D pctrl->data->oen_write(pctrl, _pin, !!arg);
 			if (ret)
--=20
2.43.0


