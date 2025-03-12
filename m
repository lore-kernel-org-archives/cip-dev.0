Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2D7C36000
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.34])
 by mx.groups.io with SMTP id smtpd.web10.34460.1741778723711013373
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=L/1b4KL2;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.34, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le3Z44ts3eh/GPaIZN8rgl9ni3NBOlclQjC4YUEDx9YzLzpflVeFFByu+bdT1aBLhtpBvQRgxT8AeGZzQLdeaNPZEVNAw9m9Li0CrdG2sHTlISogsVWbsoK4weftMeWT8v9XsUfP0OW+BD4TZC290/FttvNRcvuN11Gx71F12jXki9ZEfCQygNg1S6ugFsAd1RdrHq8OlWkftPc2bi83mPsD5yR+qWaSBSvcQVpvwGTRhDYObVJcAFA9HcaLqLNPDmx40+pHmOURm23OhzQ8SeSb8OGZK/acOM7AVHZSntRElcS+EIE1z9Pmy8v+b9EwfuZsjw2q7j0/JsuZYBOpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmb2AMdNKb32nvloiicsqf+EkAqeU9U3NqGr5Xm94a4=;
 b=zAj93VBQOJrb7g0IDlkKWAb1aq9gACmU6dFZEs6dHhzNDNfcUmRJ0my7l7FVa8yYJsS9CQ2D8+kJIB3b/9sTBGUut/FiYCiI2IiLo0Z/JyDT1cCxow20B8/UjAfca36yu6FoY42QLexsoJLOcC2fjtfx3LdsKaVYgmn7Aiftwaz5nbFaeEt8rZnIMbEYo1iiHbdeGg0SthhNqOZK+c2ht3UhpgHxiXFZEhy7XJlDRKOnL9bOkMXHt5+1dHiHeYbl6D480z1JUYfzjDZACi0xiJi3+bD28mirzmIJqlLwL8jMLJ4fcLvFkfpI/g5x/BjLQgBlZGPDSQqSzab7CynEug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmb2AMdNKb32nvloiicsqf+EkAqeU9U3NqGr5Xm94a4=;
 b=L/1b4KL2FHctn7ktOUgqm8Od9TMoniYurfsw3Tkj5NFCBrSZoyvBsPCugFsvJ+V9nOsi1ZoTNi1e8ots//TGSr569WMIDaW7iJe1pGciWd9VLgnV54Arah3I3oNiLb74llFgxMRMR45/+A7XIgmJJ6myZfMHeNw4NzhI0i7nZQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:22 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:21 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 36/85] pinctrl: renesas: rzg2l: Add support to configure slew-rate
Date: Wed, 12 Mar 2025 12:22:13 +0100
Message-ID: <20250312112302.1605750-37-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c0996c-8eac-49ad-cab4-08dd61589379
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?v909HKXGvbqRBbPAuSIXeFw6z1jMDvwAPE9RzBtOXWMk4t0VDlkPuxZt3Df6?=
 =?us-ascii?Q?gA7W16Z0T9q/yoDaN2B9zlxnG/zxVhn5Jm161zrPN4qYBQ0aFycDuggv6EUR?=
 =?us-ascii?Q?QFjbIoTupYqDXBW4fJLB8jiMTUhX2k2kUXuP+HR7S88s6g7pJNccd6ip6LDz?=
 =?us-ascii?Q?OUKCXDyygRrNaZjluiLjRUz9St9e3/MbiZ8hkkgeTIxgbluEq8wyVK7y6uaP?=
 =?us-ascii?Q?/CbRKmf7alypcgS6mYvS7h9iTSI9gGJhvikuh1U2kNg5BzSrRP14OwbvkvbX?=
 =?us-ascii?Q?iGUNLTjO8dtKFwD9aGdXCYqhXVrHxnNedeCWD5k+A+JPaJ67K7voWaKStb5E?=
 =?us-ascii?Q?0g/WSym3hmwxFqsKBlIRr8pzlkl8aIMMVzVliHtmnbrZrV/es/74izCbhC2i?=
 =?us-ascii?Q?PvuIVV8W3QPWbhyMJeeBoHQDekaepGugm3aO3hou3WujTSTqhSIYx9mVh8cV?=
 =?us-ascii?Q?hfDCHBgAApM+8JNqkP9HKT++RKP6g78WnmDZpbRJB5PXeeMQOrSIoGVMQEsh?=
 =?us-ascii?Q?VrAXkpLVqnDN5rNod7SdOm25CYNCi3xyhLSrIEl3sqMo/XEciLoQm2l1yIUC?=
 =?us-ascii?Q?Zo1hFU30AGaBIX7OhGkYhI/s7hpmVFSLIiS5zscxkhXLDtt9p8CvFGnR8EWV?=
 =?us-ascii?Q?mUQ646oZYpmLQAisSJqYsC5zPfP1J72cfxNz3tmR6xOpgALSpHTLZ2JK5vCU?=
 =?us-ascii?Q?UjGwcDFJKFNaqagSGJIc8jHlp5JdZmF23hBRplOi5eujo6riK6r5qeLLgHi8?=
 =?us-ascii?Q?clgeKHCrqp3LIwcdEJ8Jm6s1cRYcM0/BC0KGNYiUqhZn4IqZx8kPLZyz4pq4?=
 =?us-ascii?Q?Cj57fNTv97o8rRfzzRYVQTxPssbdCdB5V4W6R6KZxTO/bxUcclHWbsVATDND?=
 =?us-ascii?Q?ZHCbCoeV4I6/KRYxOBHI33leDi2tvV0MH2NCmyhvLRfnF2UEsrMYaXWTLcEe?=
 =?us-ascii?Q?lV0v9Q8PhAlL4cXzLO6O4MFZGK9kNDU6bbA8uhsWxtfTBH5xTqfbsW9AfrDH?=
 =?us-ascii?Q?Oz2YjFuwe8awCw2n+lKbGeBrE4MYL86JxJ8AqfQn/HxVjjasPy9u1WCOiUhl?=
 =?us-ascii?Q?KoWP1mPdaNI6VdJ8ybpHjq+Quv6qo5DABmeBNKJTfbSx7m+KVH3Nrlrii7s/?=
 =?us-ascii?Q?PXy35Jdqf60WRMOX/JW17X4rtBWVFgull4wkjmKD0fErM6mmarY2Jr5WRTTW?=
 =?us-ascii?Q?iCNhkUQSEpDWdFhr6K5+ZeW5U6X19xwvWtVEBl9/+zlEsrdwzEJarRcRycv8?=
 =?us-ascii?Q?KNFRcMfT1MZvDz0km19JEG5J2fE3Gndb+g9niVSTp1zlVIZ1Y/FAPP2cAKNg?=
 =?us-ascii?Q?E3Q5s1/Plx/GtpiCWYH7tc9B8H1MGMsOMHIWphHCBwNIEHjnzkLJwWyMz1dS?=
 =?us-ascii?Q?OtVQtH/8aECjuVXAgm/qXm4qxBSVYhSigCCde7FG6PHHLep+Igl04SMkV/tP?=
 =?us-ascii?Q?dGhED2vsgP1Y7fu1CrZtFyGDrUcyGDwJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XnJsRihlcdM8aLa5v6mlOY5iymF20Mp05CFl5ZwkQh0feDthRspTT54aCRGg?=
 =?us-ascii?Q?PiJYDaqdEoHU26zq3/aAPXRCfE5gAwnjuK91XWLjmvZBnJK1dWu/FjzimT1B?=
 =?us-ascii?Q?W4bLXnz63m7ZbuLev6NRpxskR92zDedI9Kq5SK5Aib49zkeGP4BolFhFNxNh?=
 =?us-ascii?Q?+d26AHOFjw8UmfkhPx3vSkHkNZqBlSQ45NGLNfgIIJ/1DAzhPRpE/PGQA89U?=
 =?us-ascii?Q?mzr7mmqKEXL6kwYVohqAz3RZR4QWo0u3mRghMjib1LxRNDACAg+mQXx58/NG?=
 =?us-ascii?Q?oR6Jwid8667auge5nDkQaGHsynwexmK3ISH6HwqwViN2q1Eo4Vq5AMt0AfeD?=
 =?us-ascii?Q?NQ0BbKohyDLekfaqO9Oz1zmceHMPcCD5KktvbAy292bH612rHh3KKJkW9E6X?=
 =?us-ascii?Q?EloBgfeRx0UrhV/g1w/tMl6oNpUROOOAQqJGySrpEDrbDgo7QaQ9RZTQQ1mD?=
 =?us-ascii?Q?8wr3M9FTNa70ozaPaz5KBycVPHRmg05x2uJEgemWz8XA0IPPPzTiHbyQhnQ6?=
 =?us-ascii?Q?DbCbEYpKKyh4js6uYoFdzjlODq575iS67YDSbkev64JDatZ/JbzJRRgc4Cwo?=
 =?us-ascii?Q?jjz+EMuG1dEgkZlMqRFTv5IW87xKjM1xcdcPYuLHFvFf3yjmRSEd+vnajBWP?=
 =?us-ascii?Q?F3PPoHeAErr5pDznsZ6CRD8DIs9NeL8/YylfMf9OHH3fjUwzHtNAdHFb4hKU?=
 =?us-ascii?Q?LvQmzodrRZV2KXoX4pqOMALaZba6qYNFVs3uTFh9MQjcXiGziCD6lxWwndSN?=
 =?us-ascii?Q?seXIZcwmufIwIXl2uE5kc1ZN6urw1SlUVCi6nbCJy8/sP5pVhI3uLI54YEvj?=
 =?us-ascii?Q?ULL8jetOpcHqDl8mHrNFOlNp+RhoF4lseAdqd7y1hBa6+NcAwX+BOiSLWodp?=
 =?us-ascii?Q?7aYJMBIMikmU7ko4dWt07f2oU8yPe4obZXwxuNzs6efXpt9k2CKA+u4cl9mT?=
 =?us-ascii?Q?sclJ5kMxiQIr7KnyFbHNs+PzY0ReHREvuA4NQk9a47npJk8Wu5UJ/kqdWSmc?=
 =?us-ascii?Q?yDdYgbqYtax0X6BC39ttmIaFNx/wKlEkZ406Oj4hEUIL0Wxh9tm5l28Je0la?=
 =?us-ascii?Q?wMhaRt6Mh65Ds5DQc3z0Ymv+0PSTzCOPpRfyPAAzjYFYs16qNEXnN15ZWmFn?=
 =?us-ascii?Q?vXOV3oBgbxyFCphwNqKxKdkrulKMqPTBVRyLoorLrrCFWADBYJBDQrGTy2yJ?=
 =?us-ascii?Q?05Y0NzUxZJsnwhDyXjs2nPXaKwQkhgl8x4XNWGWfzPKGkfRgJqZFIFn9QgQ5?=
 =?us-ascii?Q?poJ7482o80AD1z7CnC9m06ZusLrwpMo8LFJHAuabvvOuuLY009u4GHW4xOCI?=
 =?us-ascii?Q?Piyb2wb0XUdoUSeMU/32AW8ww8Ww+ErSJv9NWqRFH85QLP0JZFbzADDxVZA9?=
 =?us-ascii?Q?cG5SpY+voem2cRRaNxg/i6HdczDNHEZtRHf1ahBl/uKQBQhPfCg7gR47yGpo?=
 =?us-ascii?Q?xAObGUz/YH+rU0ws/eMQb3/8I/dLpuR+jGmNGd4gH47JWwkOZntptA2PyUEg?=
 =?us-ascii?Q?l7HJiD1eaXaJr6xNcIrDyuZSnZlKK/j8AGICnlfOZbNhXTotqvtgTPD62F1N?=
 =?us-ascii?Q?HviRmtMMhvVJlEoViv37Fe0w65uuDe+hbZLHCUDgtjq1Ru5S/5ATf4vBUIwX?=
 =?us-ascii?Q?/Cc2ZWndaavLssu6eLcT9co=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c0996c-8eac-49ad-cab4-08dd61589379
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:21.9031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qut4CFzoV7ZMgK1DRPRpBAuBW0EFZneZCm1EZgZgv1dv5oYxGV19UjXQs5S/GASLA4uGuDpDw3Ymlh/SjPMRSGOTFZE/JvWDMmxIbag2UfFaXyka+kmd9lDN+2i/BbLm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18128

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b588b53b2c474bdebbac0a663e0a6a0390db2fdf upstream.

Add support to configure slew-rate property of the pin.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240530173857.164073-11-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 430a7638a9d3..596e101f5b2d 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -126,6 +126,7 @@
 #define PFC(off)		(0x0400 + (off) * 4)
 #define PIN(off)		(0x0800 + (off))
 #define IOLH(off)		(0x1000 + (off) * 8)
+#define SR(off)			(0x1400 + (off) * 8)
 #define IEN(off)		(0x1800 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
@@ -144,6 +145,7 @@
 #define PFC_MASK		0x07
 #define IEN_MASK		0x01
 #define IOLH_MASK		0x03
+#define SR_MASK			0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1049,6 +1051,13 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 		arg =3D ret;
 		break;
=20
+	case PIN_CONFIG_SLEW_RATE:
+		if (!(cfg & PIN_CFG_SR))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, SR(off), bit, SR_MASK);
+		break;
+
 	case PIN_CONFIG_DRIVE_STRENGTH: {
 		unsigned int index;
=20
@@ -1155,6 +1164,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 			settings.power_source =3D pinconf_to_config_argument(_configs[i]);
 			break;
=20
+		case PIN_CONFIG_SLEW_RATE:
+			arg =3D pinconf_to_config_argument(_configs[i]);
+
+			if (!(cfg & PIN_CFG_SR) || arg > 1)
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, SR(off), bit, SR_MASK, arg);
+			break;
+
 		case PIN_CONFIG_DRIVE_STRENGTH:
 			arg =3D pinconf_to_config_argument(_configs[i]);
=20
--=20
2.43.0


