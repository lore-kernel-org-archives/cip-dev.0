Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B469AC35FF3
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:15 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.11])
 by mx.groups.io with SMTP id smtpd.web11.34847.1741778785609907805
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:26:25 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ae17sqS9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzxjUJVADWLv58WmmpyjTEUqI14walymR34kPJPlWKzcH/rR3Ryp4Un3i3a7ykcx4qjo0GoNHq+OCruLrK7R3KoRIGkqFf8/64t9TxTcyeKIQRzxUQLO5bDz76oWZz81TvaKx7Of5jzpLCpz74eWPDI9gNSRYMtQTEOTB+vJclIR+a4xHol5lHZKmivJu2xqykwFYRhje9FtVJhuMfsje2VDN8VC1VXk8Ghpz0bbnUmhPaChWOWJUlICZgPnqO7hFk/4E5Kdb9UGI4nKU8EDP/efeKafX6c4jyy7fs2lRYL5pPrD4m6kR3Z76ZJYegmI0bKxKirkwMSbTB+zEFy1uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGZL2tEpkmTzBZePg+wQTj3xhYqMo5WC1mrrRrnHmhE=;
 b=oLEhgZeqWWqtMitskSHuSE9JNmiukNl9Bpo2ENw46OeGPdtQkhhzX2rtOf6iJAhKDYNOQa4wUf0Ysl2t7qr2l/W+IyF5PDzDJ4y90XW3ZUa/msYrbqakS6E8YtlYXcW+kuF4f9t461XbJIoUcgJE5WCmdT2gFu1LhQ7M9H6uMz8BEtK7c+B6UClag1QWTRhl8va6o0MhhaNkepSXrX5Z+xwUv3WedCzijdND2jLci5yltKn5ueNRpjhAaOPWYx3fU3aqPC2ypqAVt1LikeQBSNhAPfJ45b/ZUBwp+x7lGNOp9echUNmpcH9UaRVEOlYZJIdljdUG47LtZo4JFu7qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGZL2tEpkmTzBZePg+wQTj3xhYqMo5WC1mrrRrnHmhE=;
 b=Ae17sqS9eWMSqXFgICEb8E6XffdXhwJjqUU62nJin/N796d6zjYFYFBfTEXjF9taFJdfZFfQx1CsFq4EHTspbIQ6GObM1krdLFrE8eiXvJfk2/z2Iy3yody6+7YzGquaQynxf2Cu6gqyEa+/3q+E7dUgBWetXtZuu71xJcMHH78=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYWPR01MB10982.jpnprd01.prod.outlook.com (2603:1096:400:397::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:26:23 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:26:23 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 57/85] pinctrl: renesas: rzg2l: Fix missing return in rzg2l_pinctrl_register()
Date: Wed, 12 Mar 2025 12:22:34 +0100
Message-ID: <20250312112302.1605750-58-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYWPR01MB10982:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e85fc23-7ddd-471e-fa30-08dd6158b87b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1f9TSW5QgnRYRcBIsu0GC1vvMdp4KnM7v5fdSSVCnhY4EtZJbwoneivshYYV?=
 =?us-ascii?Q?112tAyM5kUZb2TD4dP5FTqImyScgw/fTWUzpBjll0BVzrB6ZiYO44d+ti9eu?=
 =?us-ascii?Q?cJa5Ra0va2S7U7liTP0B6crfESxO0xt1WjZwhM2uaa2/xDlRjCbhlmum0Pvr?=
 =?us-ascii?Q?7263iqZHARtt6EVRmoxS3if5caIQgJLN4E8c6x8OkQexzVqVLDRZ7CFTvJqU?=
 =?us-ascii?Q?ysb9EKLRv14KnrwbdLOoW5iQCE1sljF0XwbvYEk+QPZiMdd4hBFgnPWXQqKZ?=
 =?us-ascii?Q?yOGba0tYVzTKY0zT0Ov5roXESB4ORaSkO8ZGTDHVRxm981E8rkOmLD00sIo1?=
 =?us-ascii?Q?f0GY9Ri5kuE20pM6iaKJjPK5cgcy80Bq5AuRUKfsK3MHkT8rlQv9yhwrFVKk?=
 =?us-ascii?Q?hpJ2W/8m+ZQvlX/rJFaQXJM4ZOWjy2TYWPYn0/HYTxYTU12q++VFDT7YK+eX?=
 =?us-ascii?Q?HaiokFSbeFXWQEVf+VLrXhARhapKNvoHG4WfCPvEcDXLyZmmQnZ7WGpXH7r5?=
 =?us-ascii?Q?h/pGg5bh3xkFO5xbDtlwkkVjSy4W76tEH+PZfVP1QenTGolwAmHIjbuAM0bz?=
 =?us-ascii?Q?0lOTnNjwYeybUeuuZunK6I90E+j5V0Jvd4iaekgMkArPMcPcZbW3L6c2PdIY?=
 =?us-ascii?Q?E5fL457tNt1YN/v50925P8kbQ8cQOC58lw32OG61dPBUnYjoVVLyyw05GqMF?=
 =?us-ascii?Q?fZ/eqLzRopTYLt2WrndTJUmBytIK8K14H9oPZfRTV2/UIEUSEDcFOTIBYit4?=
 =?us-ascii?Q?YJFYU5PLoIgo+kRw0m6iA3t3JPNnHoeyVb/lQro0YLPaVys+W19SaUrSBwlg?=
 =?us-ascii?Q?URD/59NmUf7b0toR27/wve0F1zM5/jjAWAj87XuaQTuLVexAYztIBKQCnUcy?=
 =?us-ascii?Q?ug28kN/ul+/HBdiD4xjs9Ssed0mYReIJUWVGjLiDzLDTWak4f+TCa2OqsT/o?=
 =?us-ascii?Q?P2Ucl80+UaIW4310ny2ojjpZC+IgHtObJtT5qPuP9g1Wo4zQyk35z1aGjNLM?=
 =?us-ascii?Q?HjzDiOiCoJyAT6tUlKlAM2bQTYBa7WHOVafIzOx8JNpgOeuRU8bG7KstAH1N?=
 =?us-ascii?Q?D06jMwleWFFuunpNt9Yt2ufH501ML5BrxKu+OFyYhppKjt3fVQTK0r1P66aF?=
 =?us-ascii?Q?/8YsAS6SNVbQVjqStoBkD9vmJQx/j6CGTqKPMyrVSf0D5oW8ioQwA6g4QsQY?=
 =?us-ascii?Q?xQJ2aSOeVti0Jt3gHciBVytGbQZQsnd4Mm+jrC9LPPfLO1Hwt1Ig76j/IFQe?=
 =?us-ascii?Q?kX+24s3+fKoVw7Rn7BvQnMg3lu0CKuErzF5cTgU2lGIXVWEG9jJJXRKiMSa2?=
 =?us-ascii?Q?xHv/hs6vOBaTx9la5FCnOr9Nsxxf7HaA/1L+WkGsdC5SQuvdnZrnfBjnqr1U?=
 =?us-ascii?Q?JQ9MMkpr1fp/AebnY9oE/fLJt0pszgqXLRpb+U3FvTS1KK4k1TgvDhuc5ZMD?=
 =?us-ascii?Q?TDb2C2gkMPUEjRWmNCTZtoZKaSDXhVQaa9GXFQB4nkhqSb7LDE0m9g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ffigQxtCEp4nifw2zVYw5Vym4A4F8rbSuI8TiIjAMCg5Y2B8tJwDJZVI8AmC?=
 =?us-ascii?Q?W7TOHO232W3j8Bw6GSq79m1iD/jxmecj2JUCoe6pBUe72pA4ZQheoGQcUiXu?=
 =?us-ascii?Q?JV6sed/IqJ5UlcHLp7o1qbYY07Wu+r7yBS9BRQSvbawta+KiUeN0OiJqT9iT?=
 =?us-ascii?Q?WTqkmRFaZf/eWJ3AGvgpolZ/OTaUhsPz22lMsxBwPIMQzhmdg+hehO8GQfak?=
 =?us-ascii?Q?3vdnq+6U5xH84+axr45rzcyF5vTpE89T2msk4jYcrpC8BZH2RP43h3lXTGxy?=
 =?us-ascii?Q?/W3x+nsbjS/E9VzX1rl1XhbaUsx1CqUjtm8sjtf03fgjWBBb6ARUgbsDGBk1?=
 =?us-ascii?Q?+/qk6ly9uNXjhscNYzJwDxts8QcdjLFh/3sJ9A9obsG1yQT7S9r9etVBi8TX?=
 =?us-ascii?Q?X/5uOfunBt1aqma/CxZVfQ/ScMi2ls/Qzhq0qm0TbcQNp9YZZOoeaNQrRB5j?=
 =?us-ascii?Q?aPBKWZvXTtog0JK4LdleJ4tOcFj8dwNTt62SutGdiBAo0e/idLhC/L+/B78U?=
 =?us-ascii?Q?06lvtJ4pmI7LwjcSwstMVdqbfA0GRZlBTkVZIEaC9rWEmnkji6naJ5kFwa1H?=
 =?us-ascii?Q?ZCx73GH9IHAMxlRW3UoapW1jw0bxkth6d+ylDHRZAlhZmCcX9bQnzF4mCffh?=
 =?us-ascii?Q?IBo2IgjIGXyu9TpiKAHADhNCCi4baBEQ3PWoVpZe3V7W7w0u4xWAPbT/SajH?=
 =?us-ascii?Q?2z0G2727Y0RG3pjxHLkl8kmwc5fp8bS6ajnq1OkVN6i8OAI2Csz1Q1Uss3I2?=
 =?us-ascii?Q?xqrFUeK3V4qkV0YhtzxsLBTpDEcUPMYRZumAX2EIFbMw4DbaV6vTwySjhTco?=
 =?us-ascii?Q?QLO6dGq/naugph56/C2P+aPsk4vaCGnCGhOvWvM/AudniO3hfmR6bZQfnSVV?=
 =?us-ascii?Q?t+CUf8MWNxbKA/TgaF95L7/JY881i1GGf54zAlkdZ/zUtwHpywGLLkoVj0qH?=
 =?us-ascii?Q?PENhcB612LhwpN6k4pKVC1hhA8wiXyX5iL8/04PnBTctRUJz1FkhEITv8NT9?=
 =?us-ascii?Q?lXzzJVMWXx+LUaVFDhsm4TTs2Usooyif8ZwdMJHwqD/5Y34wREqtj4J4so0y?=
 =?us-ascii?Q?qStO5YSYx8WVx7/S8yIj+Iu0M2omCFSoneqpbyv27iAWqAGfRz/8zoNt0Mn6?=
 =?us-ascii?Q?hiPLQGVice/mTXx38BlXaHN8HjACnkMfXu2qAWjdD/oyg4mRKPm7LBX+uhNL?=
 =?us-ascii?Q?/5A2jSSidh5qEVpvYLe1v2YN+BH3yYUQWPomEchaziinKLmadj1tjAJmK73A?=
 =?us-ascii?Q?B30JB0KwTsRDghhzH8xEu4JQzONK/Wolctib80p1dLwumwwntXGD2m0RDLjZ?=
 =?us-ascii?Q?ZuoQ1wH+8gvMwkuRp+stniG02yHoeRmzZwIH5x4oI02BoIfU71ATr5ZsZDzw?=
 =?us-ascii?Q?t4EDXflXvakJqjT8tepS7N8swtznLhnaNPOrA8Y8eHjgAmeUOOr/txOTb0k8?=
 =?us-ascii?Q?7p8AnIHZ/Aak/5ZMMWTFXnZjBERGvQFdRHQxoM0sgdpKeZ4fK8amJZiRjzUJ?=
 =?us-ascii?Q?1X1JXAViYj3TEarqkibwupcL4d1nZqgcxV0It3dxQK/gkO0/VsGkHWucb0RD?=
 =?us-ascii?Q?u6x0In69/tUPGpEqy+6GHi6d90XN4uzBhI1Xl0nfoBjxhuqyjWfzARvorbhT?=
 =?us-ascii?Q?6iTw3wfUYjycQbsvTJL8z88=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e85fc23-7ddd-471e-fa30-08dd6158b87b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:26:23.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1KjDDHcaszwtCLIlZnLBMD79bYujZDd6E2MSPk39YECaJRzkZWqfg9zn8epQi4obDMf935ywnfFZK8pru4UGk9XbRUR9mDb+LKiDDBw0cRt6zJg+ViO06wdbQaVIxI7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10982
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18149

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 1737715a4c2c08f207c94cc1f3af3c5945318d29 upstream.

Fix the missing return statement in the error path of
rzg2l_pinctrl_register().

Fixes: f73f63b24491fa43 ("pinctrl: renesas: rzg2l: Use dev_err_probe()")
Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Closes: https://lore.kernel.org/all/OS0PR01MB638837327E5487B71D88A70392712@=
OS0PR01MB6388.jpnprd01.prod.outlook.com/
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20241003082550.33341-1-biju.das.jz@bp.renesas=
.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 4ccdcb145704..c6ee32a7a941 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2711,7 +2711,7 @@ static int rzg2l_pinctrl_register(struct rzg2l_pinctr=
l *pctrl)
=20
 	ret =3D pinctrl_enable(pctrl->pctl);
 	if (ret)
-		dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
+		return dev_err_probe(pctrl->dev, ret, "pinctrl enable failed\n");
=20
 	ret =3D rzg2l_gpio_register(pctrl);
 	if (ret)
--=20
2.43.0


