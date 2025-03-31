Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC155C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 11:07:41 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.28])
 by mx.groups.io with SMTP id smtpd.web11.49165.1743419252172756719
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 04:07:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uwf2hVEa;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.28, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yCAVQ+cA8QZ2THaaDOJoe0JduI72WTNj9P/1xL9MQyrIkYD5Z4a2XhJcj5cjEAJY4dwSeAT0z+aUSotyvHN4haTXtRva0Nw+eWw3o+7OQkWQTWcfbF6ErmF0bii0L9crbLm2T79EC17ZMQu/p95oNvqhZRHKKjjgk2mDgfs6qygu/PFhRGuMzpTA/rPsygbtR/OoepnLybpH0MNH0Ql5bzgdQmhWTktlyVdnrUIhZmKAqqNfDjuUMjMcmuzkwTOCfISPjS72CG3IcJ+4X2BjplUDQ//BSq66nZg3yG5RpKYnmdiURaH3qvoFcul0C/dGk316VFlwc/qmUXR+QO6QNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ime1UGMPKaC9sNTCt3n1Ol8tKiA+C0D4LrAv1jCMqe4=;
 b=L3uo2Ei23efUCUhO8m5nTuPYWI1UeARRzVoHcTypJDOA0VuodR9cnEN6KDH7zRvHjF03iiKfhKNVyc71Q8TrzruWw/LeilWxzhR5Kj1WWkHtfL1LdWvmmE6V7c22SOf0YYl4i2r2DPPSEnX8poVQQxHprGKpG13ozdXxupVn/o+sK+EJedLWqKEJFKhN3xX7+6Fwna/Xgew83d8yPAle7c6zHS7NxsccfHH8dVQvtTfQbmOWTbg1wWeJpiGj2lIrQaUScSYOoWANxvn+ktLpmQMJ/ZC1Do4JznSdkqgxfw9k61L2q9v5UESkD5gWyrWqMBjU3KKg1bv9EPbYLasCbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ime1UGMPKaC9sNTCt3n1Ol8tKiA+C0D4LrAv1jCMqe4=;
 b=uwf2hVEaspbg4lV0ZiL5fGWQ2Lja9PJoThfjeErmwOML9dA6F/oJ+cyKPxqg6ybq/h3QzGL9WJB0wFNFcVzvnxPrT/Cni1r1Zp9+XJmRt+ISkOQ5wHJ7mRkK54NTqUWxRcyXDOqi40BTZnKkZeXuOJMwIAmuPO8tj1efajwANNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS7PR01MB15065.jpnprd01.prod.outlook.com (2603:1096:604:370::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 11:07:29 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 11:07:28 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 03/13] dt-bindings: pinctrl: renesas,rzg2l-pinctrl: Allow schmitt and open drain properties
Date: Mon, 31 Mar 2025 13:06:49 +0200
Message-ID: <20250331110659.252237-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331110659.252237-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::20) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS7PR01MB15065:EE_
X-MS-Office365-Filtering-Correlation-Id: c83f2dfb-d89d-4b4d-aa98-08dd704439ef
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?0g1wwqiNjpPBwpvyEgbkXvMbkSjZMj0K0rJSpjVl7hdf9G7PWGQsP/QUqsK2?=
 =?us-ascii?Q?UxX1GQCLBs3UEr3YVRoISyY6J9r4apRnl9uieSFGkk54fT5oocFO9VaG6zky?=
 =?us-ascii?Q?ZZ+gKipTVpml9EK5T7lsqMEYV8bLeSbTOm7SZVsI5Pf0xoj1znVovPjYJG78?=
 =?us-ascii?Q?B3HI6oYqJbv0BIio8yMT6+PuIIxpCi0yHpb96FzTu2PKnlwyKVvKP7wNPsEb?=
 =?us-ascii?Q?emaklBXbYKe1l66j6ulY3IWZ3B6BHXclzSbxA31uHJI0jq/b2ssPqyf4xMZe?=
 =?us-ascii?Q?UbPtos8ZFzRLMWzAvWnF2AKU2mwxN1ARPUkODd3Kb1zMhix/DZx+TSWowT2+?=
 =?us-ascii?Q?xelE8LDzghlLuXjxtvrc/7RnS/fv7aN/Let1e6q5QwcQmjjdXbPhf7WxLQnE?=
 =?us-ascii?Q?YgBEKPxMCgtZvNxEAzOjFpJmv5G7cPFPk2AZq/q7V0w1Gdti5CA11aYRkie4?=
 =?us-ascii?Q?EHTk77x2i9JSFXUiqZNYU5b3uLUPhDtB5RcsumzOhU3E9oTRVEJ1DWUQ4+cL?=
 =?us-ascii?Q?MBnGJ90RpQnVfXpoMCA/88/MHPFXPjxr7JmAKs43cExQiQPKc5ZGAqZSbgex?=
 =?us-ascii?Q?/BByOQk6jv4akeufduTlv4T9CR06O7WpK6TmE3tjWVTq1HRq7m+Ld7Ne6532?=
 =?us-ascii?Q?QXuqqTNZwMVdcXUZ9j16s+T4Fg0KMi7kbyQii6BxXweOQJ1oTTmXR/sG3Fbx?=
 =?us-ascii?Q?vV6hjBCz/nHojwy7DofF/hfl0SY5FKnmnGRsiQ4PgrE9gsS1su4fIZcMlo7t?=
 =?us-ascii?Q?81tKhjHKmmqbwP9oXJKT9jrFmfgpSYDc7WHYpKAuouz+338X5UvvNl1zPzdW?=
 =?us-ascii?Q?etaUlVOSICO51brOt76P5mPlWQE3c+qPXwBwSsNAky1p2ekfI14w4NpxIfpI?=
 =?us-ascii?Q?ysaB18oIPgZGEEhTCSLT87SdVvEuDViVNEMhmfXEoYPvMEvLGqocrOt4bxqv?=
 =?us-ascii?Q?cq8abfQDqdXudPb1Z/rictrUA7S8b/9qilB9tLxx5Xu1+s7IFFWv9juSYHA8?=
 =?us-ascii?Q?XKhBlvjkUpXnMCTuFuEmyvhSDinnGUSCaARXUdMLuwhtGwVjOo/GoCQi4e27?=
 =?us-ascii?Q?HeokTtYimr+Aes1DqgNZ8IjVoy9fEZnympPYLToXryO3p3bzyzAMIexjwhUp?=
 =?us-ascii?Q?56HvmVYljcLAaPF/+oP5VXI8GcE/TjK6og9X52NRYfFxajiYQ2XYz18/fLtR?=
 =?us-ascii?Q?CkXqv5B3Qox2I3mvR8ofDPou8sHM8468kKwV1PATS4uYpn4YBN29eggaSord?=
 =?us-ascii?Q?iSSvNyGeCAm+cRMRNBOr6U+ZQ8E6yFWRsp2eD8lMRS38AJ7exEblIH3XN9uT?=
 =?us-ascii?Q?rR64oViCIssvDXsDJ57xmiCgyMDE9SEn79TnilVNeVG1J2AuvZhXsd4R/ZXu?=
 =?us-ascii?Q?nJcY9BPdRRlVJsjw1nQvvUA2rQMa+72i0xYo5s0DkUEXj8qe/51pMUtsVh6P?=
 =?us-ascii?Q?OtGcJWj2FK3cfWVCrqwjN+GQ3KrfUN+I?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AS+xuqnd8rLR3+HW4kJSMtLTYaDOGwaEQWWWvFjJ0X+rPD3fPOy3OSkLPM3R?=
 =?us-ascii?Q?1rYLYxnXgpBv2LJUG9IUv8OYvaNMuMCOdMercLbydtXPZ2rgIINODDdpfoXr?=
 =?us-ascii?Q?VUGALqYTHI6lBQiI9/5V4bj+JDlCbsM2ebfeXP0xW/8BM7yluvvnZNuOrPpP?=
 =?us-ascii?Q?TnJbPxSe5zLw/1UIh3LQTQZTkSD2NSBXVlwA5Vo8w1IoezBUf7RVVQq0+UbS?=
 =?us-ascii?Q?51GFPebOSS6AQZH/ErlTar4idhkHRXkOXSKZHH1Lrl6ydRJA81hwFbV2+1/l?=
 =?us-ascii?Q?jKjg3NPVc+Y0LEmEpGv2+onNtEfX8oknE332dnSF5rLlcsTQbFHyifEjFbUi?=
 =?us-ascii?Q?4Fb3qkDluAdTPGlyxhErY1u6swk+ny8VMg1d1haxdhgZGdLLgGXMZF2dGMG+?=
 =?us-ascii?Q?FDKRG2rYH/PSIeHk5P27x1iT0VYC1q5UbVoVJminlU09Az4Vh52cmaXdFhe3?=
 =?us-ascii?Q?3Ie52xS9KkDtSCcHvmM21qCtnRgJ8HxhCFgtkKB+3YPzvgXJEIYL3fFk4fyF?=
 =?us-ascii?Q?lW94AitsWPR+3VXPd3ff+Y7QSbPvudsL59bdKl4KCcFmEXgqux8wmIBFFCYW?=
 =?us-ascii?Q?/ubLRFexB3AdJFnAevmUo2qNewCLAvnaDfBJQN49GtPg6GlFAt6UipMtHJw/?=
 =?us-ascii?Q?Sc2FZOU5QSTS4fa7uz7MBMLNNIalGc0dwJYokmYdGyg/X66EA8HBekLWd2G8?=
 =?us-ascii?Q?GiVO/EbiQKc62HAVr8UU+StqNXru83UR311fPdoz3RK9rTwbsNXrmoj6Rynj?=
 =?us-ascii?Q?XywkcpTIp9NwJW4W8PoIRENlAbsCFBAIHiAMobXNDJNW/TlEgzJjg2+DmMUT?=
 =?us-ascii?Q?M1dLVG7ZMTXg6nU3Fsl3vLANL++wlywDSnwsJO6W4GB961Bkxfcl74bR+7Zv?=
 =?us-ascii?Q?7YTXvIHU5fBqkjazC6cncsawMdNI/V/M68nRg5TLhONjFQRuGr6TPhJwwkjt?=
 =?us-ascii?Q?3zYx/FgOQ1cySj5RSSg1uBxlj67GaIiHuZ5ol0tQEoG6MrFTADuwV2zs6erA?=
 =?us-ascii?Q?aCzfYESceB+3M59eGrzpNkb1VO7INz77G9uohsVN8FGH1jMDbd80SNrpr8/8?=
 =?us-ascii?Q?wpF0EGDBWWKWKMeWzeM+9ZC6FnUq6wbGmsHsoqGSff4C1BdMbbasGDU2Aufh?=
 =?us-ascii?Q?fdbtYCE5gCjOTwDUbmbo2ZYsY0ZOqZ+cSZlJS5CeswIncPs6GBWyB5GDjyPf?=
 =?us-ascii?Q?m7J6RCyT/iFPDS8pI8zMyuaArcmEfBoNGlEEEGBAcSoOH8FmVM5cE2/FyBei?=
 =?us-ascii?Q?XXittbtc19d3i8nUDnwuhtyW4DcZgzJPlWODXCkLagZv60dW53pGE2eQn7Ae?=
 =?us-ascii?Q?tOSB9sH0GeuzaLZvZVLXA+kI0tzb/UckXgY+cC5SW/4L2rohVaLYS4mDJpy6?=
 =?us-ascii?Q?7ZFnP56qMWJqIliFM4Lq1HDn5kevDMx/rCRG26CBIyJMSbgCDpDD/IPuTLvU?=
 =?us-ascii?Q?ix0pJHfQWAGYLLp+Hy3iIksBsbzeUrxOgcXtpbreaeW+sj0/Gabhz3u9eLUt?=
 =?us-ascii?Q?SZ9jLE1gI4LZsTAttbSwT3rdUg1wdoxdTPyTUGTU6TgmCrCGJz9iSQMeLNqd?=
 =?us-ascii?Q?a+7KS/QeRAdr39vS+SdbXUTYe/ZUhrd8dXuMHR4mS5Gt9c0TK7UYVBPr7Em2?=
 =?us-ascii?Q?QtpWtxML2pRSMBR/6BdgTFE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83f2dfb-d89d-4b4d-aa98-08dd704439ef
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:07:28.9336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHFHpxvw30Eryoq5xIeG/7QcHxX06rXNxrSJCADhz1aX9rsWWzZfzwbkbY0FVE+pELWGLPm0Dv3uLOdiYCZB3KV2i6PQQzsbbxKILFsegvyHMEaL7xR8VuyvQvwS+g+U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB15065
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 11:07:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18435

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit f07e2b681edd8d8ed25048b958fdcfb55abaf487 upstream.

On the RZ/V2H(P) SoC one can configure the 'input-schmitt-{enable,disable}'=
,
'drive-open-drain' and 'drive-push-pull' of multiplexed pins. Update the
binding documentation to include these properties.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/20241004123658.764557-2-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.ya=
ml
index dda91d0a5cb9f..7b9b65612dc7c 100644
--- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
@@ -119,6 +119,10 @@ additionalProperties:
         bias-disable: true
         bias-pull-down: true
         bias-pull-up: true
+        input-schmitt-enable: true
+        input-schmitt-disable: true
+        drive-open-drain: true
+        drive-push-pull: true
         renesas,output-impedance:
           description:
             Output impedance for pins on the RZ/V2H(P) SoC. The value prov=
ided by this
--=20
2.43.0


