Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02988C36004
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:16 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.61])
 by mx.groups.io with SMTP id smtpd.web11.34836.1741778762451588215
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=UxQLt48Z;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.61, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pj/AdbbpwHotByptff2eCvW7ay5QJpsHed4YbYzo5+4iNv1TWYTAPw2ZuWYhGwOLAjtjkiFgVJfdZ11h2dV52L8KdQ26JSQ6tIXCgtXHSZzAnULJrvkN4qG/D6XnkijtcHaTPL5DPJaqJ1pN729tLhlNERI0LxMHJkcT9vzGzQ03Ndp5vrHw3DaKjLUmrjXOsHLDNClVPsCszzHmO6c5gygb4P0K7iWOIZJAhsdyK0sjvfuwI1bWvgGL1PqCBmgr0/e0Ne0WoNBcRjcXDvDhZr5gYF5e4j8BT1+YLMps+nS2BK1yP54Ri/PguBPATR3d5sQzVQIZ2nlnGlG9gOnB+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cV2fDlbYBOAPYnYRC8BBP5TP1aY0l5gXOCOTs1X5Gyo=;
 b=vPffkhByYUwNaumZfplicnpCF7/3qoqoohaULMXMCmQCrO6lGkHrI31tcLYENZwM0In7t4iYqu9Fw8Td8rd+qsOJcAOUG65gKWpSBOULfCRxPGp14A5TtA6n1l2ett9/BqTO2I5vkRb42hUSB0y6OU2viAzNlv4sp8cUkGgjDR3OVq1I/xR8/bXrdjRI0gRRuqC9EJa1XW6jAoSAo640fEb1Hk+n4D48HW/viuBSipriwNzlhnwaOyTjgS/QXohsHGH7e62InUzzeIc56OKAVVf9Fm9ARcXCDbb9KXetBthOh6JO7ER49Q6TdtaKcKLleT0pEXA3I3TcXKt/Y1rPxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cV2fDlbYBOAPYnYRC8BBP5TP1aY0l5gXOCOTs1X5Gyo=;
 b=UxQLt48ZNogrdmq9n5L+beQPs2GD/IL/U2tGcdVpi+AhnGCOtJ3L3dH18viXE1Renh3thZA4Jy9lWnzgQnG9YB97ghZYDYKLDRb636SlWq6C15YuRZo5yZH9ArvnIgd4O3vLHQGSJt29ic3bQd3jos36MJhDIAeLs+J6M4sl52g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:00 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:00 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 49/85] pinctrl: renesas: rzg2l: Return -EINVAL if the pin doesn't support PIN_CFG_OEN
Date: Wed, 12 Mar 2025 12:22:26 +0100
Message-ID: <20250312112302.1605750-50-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 455dea90-ea2f-446d-a251-08dd6158aa80
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?T0IJBlpTpwEsdrSO8CqlEn6yXosKA49Dsp7Z3mYTNdOYcdJS8QdRCPm8SAGF?=
 =?us-ascii?Q?JgwXXrpDB/aNF7alrd1U7ATO37YnYMvQ8D9QZgMZEeUUL4R4HOBNL6QKC3pq?=
 =?us-ascii?Q?Uq25sdSVFeviB4ran7/SJpoVjBWU5jNas4j9vywAdGxbtNXUwxXZ4x69I4BT?=
 =?us-ascii?Q?Uk0TQDOx3gAss+iO0oXdi+grVFsEKVcYRO9z+v6Xa5AH8YukJAv4l5iQzMoS?=
 =?us-ascii?Q?lRLplF4ipLvgK3FcuSLDWg9+9Rl5QzxL3GH8wKeUmjjPExFiIS45Y1mQ/uyP?=
 =?us-ascii?Q?iK45KHEXjGsEF5DdDt3/DmmJca2o/TeKKnpSCAzhzMjSXpLoSBqPACUEUX6g?=
 =?us-ascii?Q?M7GOuJaDtkqlVmBgk8MYAtcxOny8rilJD92x3qOv5+P3a5+vDWAdRoicADVm?=
 =?us-ascii?Q?vjw+hLAxMUTUR810ziGaMLyjdNNNp4XhfIUuVSl93xoP2rfkOXNp6LoTMxQD?=
 =?us-ascii?Q?o9rY4PDa6OEcz9kVfTee9oHVdwzKXb9lZJkDtzn96Cb4xZkmLzQGbU0JgiAI?=
 =?us-ascii?Q?szUcKXjD5bY7fF+rU5aFCQ/PQVUVafaZi0+M9883288f7n0r5KePlee7Vxtf?=
 =?us-ascii?Q?4vBY7dp9XzaW4q+9X0hfvPZFBYNeKUH79jP5h68TIBLtkKdzEeIBE2wBHOqP?=
 =?us-ascii?Q?N5u/cZtf0inzXDPTbTxZwoEa/+NG7b9PFQ6YMm2HZTnPrHp2h+0/kR+iqTo9?=
 =?us-ascii?Q?ju24ojU8lSyj1VRKgAxBFumeoPaELrTfFJ4sMT2qgHeWfwTB4kP7ilrXhVzI?=
 =?us-ascii?Q?HjobveaAV8I0rUfZrt6/rqzRujzDMJGcQdV197QUYSBIM8AwjodZGkWs1TQg?=
 =?us-ascii?Q?Z4Yi616jriadW/6ONxFNjHOs1S+GgUozp2xlBWQeQ5O2trBAU9tAJnquk/hw?=
 =?us-ascii?Q?1jXiShmi+OYCBW+tt6aWLZJrj1EVyLsOB9P+G1HKYG9YpzlyggK7hcJO2jxN?=
 =?us-ascii?Q?gWaxRzxP6TxBDBK93VuYSGLyN6f5ZadN0+8uSQpw5iYASE1rWv8dsC63jeLI?=
 =?us-ascii?Q?srsYiQCnNNFaYzVBwhWbCABlUVz6A8IBZULZveYYXWYkjmSwsErVlgFqvB+q?=
 =?us-ascii?Q?v4k3O9V9SJQCRIw8QMbLGQ9cxONqJLdTNbS7Zq4z3L6ViLh9ploMSJhyYg2i?=
 =?us-ascii?Q?imeuA1iNgK2SRe9xTrHpB7/Qsbpqwqff4WulbXUmoBwEpquwPqVfbiTgZ0gV?=
 =?us-ascii?Q?3lNWPdzswBGiL6YtRxCr7xLop+zFZ17C5PntnVcRHtjnxAkzBocZoRXmhBI9?=
 =?us-ascii?Q?QxFFc7kQeQO5/Uel5qMFkPy0ZPvnzyOkzdngc7j1DeM0UePkSA5dUFZV08XD?=
 =?us-ascii?Q?Zh587BK2HhbL+w2cLTVVUOvPNF0FRRtyw5PuwahwPGV9qjPMvRsRlRVFnbu5?=
 =?us-ascii?Q?dexsCjBa8hpVmafgwpmKNM7buj+7R8+NIZAgky1Zc2JF5TGFocCl9hrmLXr4?=
 =?us-ascii?Q?1PwoAX8PaBd4TWZvRPdurkxAUAShUBQu?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?D7alimsZo9dLaOcndJ4jXz2Oe9sii3jR/gDAYoWp21VpKi4tKSmb7jg7YtnA?=
 =?us-ascii?Q?IJoSANHDrQxMe9p8mZtEaGeDwk98d3856XTNlqwt8hZrl8/jwofAeZvr378j?=
 =?us-ascii?Q?4lXGdCAVYhGxMgxQthqokFN19Znk++5xFe8xX9jMoDEXeCiT4Iqazf97dvX3?=
 =?us-ascii?Q?zoV/LGD14ky3cmt32oeZsJ7Bg+clclOgZufwh4aVUXe9wXK0VCOfcBU/zk+E?=
 =?us-ascii?Q?+yVFKBFN7nRn6Nrsaq9npx+dhZ9dfbkKFPd4aPUIKtadA4PuSDbLeCtruJgy?=
 =?us-ascii?Q?rt/z6o4RCZomNkVA602C+7hUYHUxt1M59RG71LkzadEYmQjKpI+OiutG8ZOY?=
 =?us-ascii?Q?3RRAs7h8EAfHvwrVAZPKTbHPbLlvQ9tS/RRXHzW1ZH62nSVZOY5Og0yVGYTW?=
 =?us-ascii?Q?J/fXeOE4DhjuJLMjeh89dPd1+L18mVXkbNK0wqjCEip1yCQawlmN7hVQUt1C?=
 =?us-ascii?Q?POW/9ig2/FKzC17YooYhbzr0HIvLdgYI5eTa0aoCf+DsM5dvk/WuFGm2UqwZ?=
 =?us-ascii?Q?jINccpqQ+PTEci7aGL1lHoCR8GuyL3W21VKkBLJ3e6ihKKG060CHX+x9K56/?=
 =?us-ascii?Q?R4iC9lSqmpTf+jPqY2Im9tDUnZm3gHFwFgG+oobdoLraNjecJtfNI6PM03bO?=
 =?us-ascii?Q?Rn7OMGSF/3DNJ10E9rzuXSZyZoKOr9B43RftlynfSoVUK9sK7OxQ137Qji2R?=
 =?us-ascii?Q?64sp3Mk5UHp5JsIsRp/TybMRkq/Xuje7ogu0shkYRhdrCLILxC5WMXuT9d+d?=
 =?us-ascii?Q?wdBXG9BwjI+zL37y00GZoNkhI3fZpsI/xWOT3vLyTE9yDKyWlccM49YfpFd5?=
 =?us-ascii?Q?0vGg8bdbIDR2YA8CAWw25G76klHA9DM5Ymx4USZukeMNpznI5ZnD+QiOqnhK?=
 =?us-ascii?Q?jryZ9aIgX06ybe4e77YwJHQ9In4G4aPwEGAu3Jlk7gJr1x33QU3U+kY9QDQ9?=
 =?us-ascii?Q?EsQ+W0EhHSNXUDh3nZy+9WxRdYmePXhig2zKhX1Wk6SLhX5LLvV5mN++tWZH?=
 =?us-ascii?Q?PG0eeNjVJFz8dPqwTUxm5N/0GjvYW11piv0McmJgNVZ0VkGxN0dcox4HzxU3?=
 =?us-ascii?Q?T05odLw+/IwK2UbWodYOxmJABFtrFZ52ZjWHNszNZqT0JN+xFajfEuSQvks+?=
 =?us-ascii?Q?ALfq7OiHTOnABlJr939u3TuBQNyCdW6A/GH9GRGeEE5J6N9rjnt5VHhcDP/N?=
 =?us-ascii?Q?XlLJl3txMomIiG0znIAYkfaEEpjzSUYmeXL9MuMzb7oTZ1Lp8D9eFhnqFr1L?=
 =?us-ascii?Q?ejRxpphnn6q4LQLZLEEUbKdllTtK2+kydZ/XxFbfAnx/3RHcJ8QVKTKoMdud?=
 =?us-ascii?Q?tZuLzLAC+yTVddyesx01rKFqCEdUXgAQk5cB2iY7UFcOorSEZVWB7c8z2Lcm?=
 =?us-ascii?Q?a5spNvF/+1t8zqkIrs22iUNv3oln04wsl729NeE49n97qkSyN4KQhKoxQTyR?=
 =?us-ascii?Q?ywNLfcAyQz6hBds1B50lhYz8JEehVsp4YBLGZQ5tTXG2KFle4U4BAHzDq+Mj?=
 =?us-ascii?Q?2DqJp61RzRD3+8SYvBLUF+hKGFbiV42RsEac40zum5FEBRl8LxppLmLX9O7a?=
 =?us-ascii?Q?GdHNEwhPPrRWHOx+wgrS5KUkXj4lUI9uixJ207cFv/Tfdklo+P9CJVgw/l9F?=
 =?us-ascii?Q?L17qQkfvhkton9D3BeyxNOI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 455dea90-ea2f-446d-a251-08dd6158aa80
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:00.5306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Gmb6igFrFvGFUODJQBLUws1GjxUEYlU8LWy5JInpvOBqu8Z6hsLsRWonwIfS3orr3td9/bTv2MDLhDTofkSk3OlTVM6U4nVDQd937E1GOXy8v0epwcC1T8fwXzNVFRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18141

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
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index ba0122b46da0..7168495da565 100644
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


