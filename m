Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4652C35FF1
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.web11.34848.1741778788307158776
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YWkDvM9T;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.18, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yds3XxNaUoW1RrMSFRqKJDV8Vx9n/AH1kiylL5nQYix987dfzCSP5LTl29r/XH2wE0jTK3R1003PO/EKMGJjiK5TYxF3oaEVOTKjukmRrDizXpS5vYWqQH5smHgF2cv0fGhtI1gF09FoyNS9z8PG/eyaTKhGEGt/UlcorQ6OviTMHbfs5E2LUFd5ju7FWSn+N60Zk7+VYUdnLtQiKyhY75vOwptqgc2evuFRQylH5a1GxuVeoD1yhizqZdqeCOZDTdUrr33wQhY3XQOQKpololhC6lQVgyZPTozMEKAdRZAEMw8jAQAJWqKm57zSKKl4uLmzNdoiC71POyRkAxkfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JiHF8bg5DiSWcf7ERcvupavlQPFUUW2LR+Yt9UQ5ZI=;
 b=scQV5sjE/j2A5CXX46EM244fnXhOTeuAKVk1MDPnmo1geKY2F26c/tvmJuHd7GQhP4BmR3rgJpmH9BcX5aB8qRxTIpgswP6uz8f7zZX614ANSbSTOQ5tpTUckg3Wn/1SBuy8fyuBXir/axnJefTjbHOBmf8TJGKNrhQvRXWGQ11zcHOzOKiOVoAiGzfA9IP09ex8zjxcZgyCy5NigAlZM5aj3bMj8HdSfTjCqZwORXFTb/PC0lYucPE6qZbXmV9JCfOVPRKtiJ16aomMDEQtZEMRyQEzAN4fb5Y6GMi2juOZdv3ygoPM58AR8efk5rjwrIm+V6gXmkx4yI0g1SASLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JiHF8bg5DiSWcf7ERcvupavlQPFUUW2LR+Yt9UQ5ZI=;
 b=YWkDvM9T9cmuFSbCdsnxDgG38DagbD35CMAAAsGiY1fWQYlkhFvcz6JHAbCEWSoF3G8bhilHK0yJY4vX5e3N1r8gtwPcErgP/pQaKezfWmHLuIsU9gzjlyNnHgIqCJzficgM31XKkqIgUzNvXgOIAUvWGFNHz/3uRHFcAwMnu+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:26 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:26 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 58/85] pinctrl: renesas: rzg2l: Add support for enabling/disabling open-drain outputs
Date: Wed, 12 Mar 2025 12:22:35 +0100
Message-ID: <20250312112302.1605750-59-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 106612eb-0b1a-4402-3345-08dd6158ba1d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?ClT1Vh9zvQag/j51utH3JNj1ubCXazwuFio1DTN2g4LWolEXlbv24iUkWKz6?=
 =?us-ascii?Q?+nsKhOOPlao+1yUkYfVqqX/WU6f8C8mQXCzrgwtPft2YlgEWKcY5ZFRCzvkD?=
 =?us-ascii?Q?1MRdorvwiZTicsny+xf4Om/aSq8Soi/2hQfjgsapSzPmt8XTw35Jfm63VdiL?=
 =?us-ascii?Q?I6o2ZNPywneX13OtUutcvwzlI/lyEgyiyNFJD9plJUSrIhnifTFvjlbHCNSR?=
 =?us-ascii?Q?8lnxAPqM9JHOJ03wI+bC0pO4x3V9sXy8vVvaSFMoRXlcC6idDLArZa8/gRYK?=
 =?us-ascii?Q?nsFaNC6az3npUSUl6LXYvtdr2epqV8Gj6s2GxsB4de3gqmLG8NT97SpSQ0CA?=
 =?us-ascii?Q?+xqp3JI8cyxrHR7FhpHAzYipLgrv1TQQJp7H+bJEU7zbW9rooASXQ5+DXHRM?=
 =?us-ascii?Q?4xfpmKyUYBRrM+c5IAoc8KG+hNFM2dXBRXDATw8dDBoWlUoQ/SJ4z8G2zCYT?=
 =?us-ascii?Q?WI7r/YwQt3TdSIZie9Jrftv97xn/qhd5XJT+2xKLEta5ClWHm93C0FZHp0Jc?=
 =?us-ascii?Q?GTdDsZCy73Goxez6M3QclRGoARUXP6QbYvM3p6NMY03YFyd40FtgaPwUwm9F?=
 =?us-ascii?Q?0ka/C55l0Luj3y7+UgNNlVTvc/apOym8//DT3b7qG+z5o3lCOKo0yrfsRsP+?=
 =?us-ascii?Q?/5TTqIsXhWKrTQsifVyuWF0wP80+e6W5L/Y9kgEoa9cQc8OIdiyTFmHyGkf/?=
 =?us-ascii?Q?gXJ0f+GxWqT0bK0qkv5f770wbv/z9/rhwgSi3EFr84S+6YmezTZh6kL/ppER?=
 =?us-ascii?Q?fsJ/jD05KK1L/+ebSDXHOmDBJq7dC8az8EpUeJuu4aeqecTFgcohKblf1ul5?=
 =?us-ascii?Q?L5QgrjAYLu6kmDjuCB4jtM2RGJxzMmPIRlOzg7d94X/5IChM1tVNZkl4/JMK?=
 =?us-ascii?Q?lFI+Sl0labFWuz15TuG7vnn/io2Nyo7QKhrm+P2M+OuV6nvaxcHMsDkT7DZN?=
 =?us-ascii?Q?NJUXUaCBIjvEgV/Yv0EByYflsWdSrIkpgomKiPiNlEWcfjwHlYkvRs1cEyFb?=
 =?us-ascii?Q?MlJTkPCi3cis3qV11iZjw1IvzJK7Ho8VU4XudEyBu4gfkifxrmQZJJaXHCUU?=
 =?us-ascii?Q?R01VAyWmZssvXz39+deSFhmvJM+FD9g2q9bhwvaiWwwseLNGgWRFn/C9HQBZ?=
 =?us-ascii?Q?Bp6xm9Csat35w1mjZ95Ynq2SnpWbafeqWYg7ul2WsaDXKM4GgI4Fej7NXcnY?=
 =?us-ascii?Q?Ko+uBOu4JySQs0CPk35SdUO3a5PweZ0edVnE2MV5SCw/0TIYxqhTEBR09Rbb?=
 =?us-ascii?Q?x1QYAXeoceo462/LS4z9E6THjqeEO5xGRb7x/oZrNimhrex3d5IbllpbELBA?=
 =?us-ascii?Q?MTScNHV2zfUaEXYvFsQjNRM6Mu3HXQdpH0NWYgQbr1GfiDmjLzLxlhtkrGKP?=
 =?us-ascii?Q?akjnCGfWr5Ovmu+Q07rCC/zNLO18xQJsWRnecJMZ2ZeT/1yegHzElA04JhRF?=
 =?us-ascii?Q?46JcN1htr1Wwjp1palpMLTY50CEwtcVm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wt1YUNIAkxsWduaIik5lMBDbsWnbWlywvnDt65mxIkmzXnAzsgD/ghSo/+jS?=
 =?us-ascii?Q?TvfzfQBBLLafj/kjn/Bx2r8bqifvz8PhF1NhYaoFGRkCtjQXLcvXsG7LWUxH?=
 =?us-ascii?Q?4Pd3v3BmXJL2dlSZDUD03aPi0rKGgNfUuxXi7M+3dIKl8tVJ9lXEUt0UbxgP?=
 =?us-ascii?Q?4z9azR1wBIHxFfOg7yjH5v2pd1/zf9NtUrgv5C3kwGvVbAfatR/0wPgUJXKQ?=
 =?us-ascii?Q?1z+sAUbV7RycsIUfcl/RM8sc4HbWagudNBAlxAJB/X7xwmpi74QiFaGGxD2s?=
 =?us-ascii?Q?e42im6nX7Nvu0GCKpIJBANzwAzMlUwRZtfhVT9i1FzxK/IqYWRrWZbpENa04?=
 =?us-ascii?Q?GMBE6hZ00p98rr/CFoZnsAb2W1GGHLanFDaDnESlncwU15wSuHJukpdxtXHV?=
 =?us-ascii?Q?mopGIG53C2sdN/Y/ra8KI4r9rPdlGsa/vnZIpoKFcB8eBV3viZdyl2i32aJW?=
 =?us-ascii?Q?UJvc6pEK/mKUf0O/1aXMsedufyyzh8XyvxEg3OReI1Ka34tZDUT/XQZ6URPU?=
 =?us-ascii?Q?CUbHzbvNuHkuOzsDi+sQPJxfrbN+KfsEKPHjcvIuephy6aaiF5RZXwnwqECY?=
 =?us-ascii?Q?Ek7jdSgbU3HHKGR8YUBBzNzHF1fHGL6Z282KjluY+Nd+TCE+P98IBbcyomWq?=
 =?us-ascii?Q?x1VOv6c8LFXR70KwQvVMcAVHlqNhrqZF2jq9+jn/uoqHITwA1zHapWFrxMRc?=
 =?us-ascii?Q?HWHByjt+ndesdzCrK/WH+MO4RSAzPNnJZw0rTb/QXeXik0uzcF7RNxx82Ulj?=
 =?us-ascii?Q?Wyk39DQF54yfplmE5vUhxLn9jL3tT0RKM9kinI87pYgYLvFeeXhUB+gD0zKu?=
 =?us-ascii?Q?C38696xoCAKBMsM3OFspxfWvr4E7NorbiOXUeujH8llXJXLfSfW7WQ8hnTCU?=
 =?us-ascii?Q?BPlYlNivimi07X3RPZS0p672Jiw3+AYAK9qOwCITRG6YNo+IxJTnZith7f0w?=
 =?us-ascii?Q?v9IyvdOQ8pT5/cupe+5g/7pUGZmUGrfe/eAINSeFRJ3BPbIZBKzHYfqJFP8J?=
 =?us-ascii?Q?25xzeGoaZawcOJXqSTbKylSl5o6e82K3yjSog8IPjDojPT3e2tGsuyCd3SQt?=
 =?us-ascii?Q?rApwJVsKjxZTrTCiGI0FRLD0LLHfAn7QOdSXM1FoJ8mkwU/fz8zW8O/8Ki6s?=
 =?us-ascii?Q?bM5W57wraUdLERhl6v/XjhJ/6HAfYukUdYO64VO3247F/ZPn8QVqyGGofkxL?=
 =?us-ascii?Q?nUzLzJUG0m64TqCE6zCM04mLGKAbNvGOMj/+5SUUJg2FXHtFRFZVx+edIT7w?=
 =?us-ascii?Q?V7ybMglf3wS4TDnNY6Uhub8B9+nqMKXWYE9xkzRh3vIuGoMn3Y5uxa02IQwx?=
 =?us-ascii?Q?6UEXVaB10NcGgHPUQo1szpDvFa3Lk6lW7X20WYJpQeD0V3gXtUXakUU4sDZc?=
 =?us-ascii?Q?a52rlaMs4DfyEQUYKl89Vk57piD+DEXptlFw6Cc5ofxhh417I1hlh29Y/kc+?=
 =?us-ascii?Q?737B+b3hq/PRmwT6L01+VEkghg8m0vm/R3yUtWM6+dgSrCmfS3P9AopEZOj3?=
 =?us-ascii?Q?tMLk2CY6gFkzFI5pDnLyreD5AI1xZkd5ijB52S6wZ4JH0+mhH3zjYuJZbwaF?=
 =?us-ascii?Q?QY6PpTxFO6UaB//7Su/2+6qOzjRQWShgmujuIz2py3p+RySACDO0i7Nog3ha?=
 =?us-ascii?Q?nKwtvF+MrVC9QTqrMD4Iu6k=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 106612eb-0b1a-4402-3345-08dd6158ba1d
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:26.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fMFb/ujzn6qG3GZcws3zrSHVyBbw1bpgsVuWmgOs6sr/47+lL7u8bswuLs3pEdIrfQObc3OSqGm304dJeuCWpRUWUFSdMEw6RRIu9bj6qBkoUfu2w9/9MoBp4limrYv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18150

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 9d75b70061917fbfe3247e2594879e5a14d3e24a upstream.

Add support for enabling and disabling open-drain outputs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/20241004123658.764557-3-prabhakar.mahadev-lad=
.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index c6ee32a7a941..834fac5db21e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -138,6 +138,7 @@
 #define IEN(off)		(0x1800 + (off) * 8)
 #define PUPD(off)		(0x1C00 + (off) * 8)
 #define ISEL(off)		(0x2C00 + (off) * 8)
+#define NOD(off)		(0x3000 + (off) * 8)
 #define SD_CH(off, ch)		((off) + (ch) * 4)
 #define ETH_POC(off, ch)	((off) + (ch) * 4)
 #define QSPI			(0x3008)
@@ -159,6 +160,7 @@
 #define IOLH_MASK		0x03
 #define SR_MASK			0x01
 #define PUPD_MASK		0x03
+#define NOD_MASK		0x01
=20
 #define PM_INPUT		0x1
 #define PM_OUTPUT		0x2
@@ -1338,6 +1340,18 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_=
dev *pctldev,
 		break;
 	}
=20
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if (!(cfg & PIN_CFG_NOD))
+			return -EINVAL;
+
+		arg =3D rzg2l_read_pin_config(pctrl, NOD(off), bit, NOD_MASK);
+		if (!arg && param !=3D PIN_CONFIG_DRIVE_PUSH_PULL)
+			return -EINVAL;
+		if (arg && param !=3D PIN_CONFIG_DRIVE_OPEN_DRAIN)
+			return -EINVAL;
+		break;
+
 	case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 		if (!(cfg & PIN_CFG_IOLH_RZV2H))
 			return -EINVAL;
@@ -1467,6 +1481,15 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_=
dev *pctldev,
 			rzg2l_rmw_pin_config(pctrl, IOLH(off), bit, IOLH_MASK, index);
 			break;
=20
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			if (!(cfg & PIN_CFG_NOD))
+				return -EINVAL;
+
+			rzg2l_rmw_pin_config(pctrl, NOD(off), bit, NOD_MASK,
+					     param =3D=3D PIN_CONFIG_DRIVE_OPEN_DRAIN ? 1 : 0);
+			break;
+
 		case RENESAS_RZV2H_PIN_CONFIG_OUTPUT_IMPEDANCE:
 			if (!(cfg & PIN_CFG_IOLH_RZV2H))
 				return -EINVAL;
--=20
2.43.0


