Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA5CF6A96
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:20 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2989.1767864549884021623
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FyDFifki;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.30, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oMNYqae05UUkp4HCj09fSlBKX2Ed08QrnyuCYtma2ZwL3qnVlqv2kj4BH3GOQeH62d8HEbkUTp8JLU7Uk09NNGXk/bd6WX6UCRSufKshPFwvxuOqnTXhwKJ+wUEMsisPygHkt58cGzqaLHvUousC0m/GqLlfCndm1bZQgnZznnLoQ5uIFGeejimC5M0/oWGNRENYn03BUDsymeHrceyCPRjfbVvUPabJAfJDJqm/bSw8z/YnDjwCRYHVrsDDaOEVssl5HTZjkEsgmCsk781qzQYPTERJcakNkkez8C1V+Bbmw+iDlUezZXyqGU2yC6XEuE5srmnCd1x3aPswo8OGnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x214aKHC9h0AtdxBCKwaJf4Qly+a1EICI3Y2wi26GoM=;
 b=B5JfUB6uiPV/LSEOvCfMSxXHNeQx9lp/Z0+Ro3hPk+FQcm8hm92cCDnLbzBQEljcFYV0RIqeeSu+EipWVQcUpnH5HaKu0W3IpXpR27ICXMjbxiWmTVzb+DLHgpiRVzbGlpRcp6S18tv30N5ffflaCX4VhxjODeEgC5cHepbyxaGtlSIe5KyXUy65P+LSVDr+whXQcFoSyyWCgiDjcSqcaed2bvjaVoVCaNT8hBdPctkCkOs7Qlm7a1d0XdOuq08U3I/JKjs+NUyGUNgu0S1CUDnhYv1ImBVXDdKnjjva+p/VacU0aDvhIm+mykJmvkFo5AhruJasxOrLx7UVNos73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x214aKHC9h0AtdxBCKwaJf4Qly+a1EICI3Y2wi26GoM=;
 b=FyDFifkim5EtdSHoEOWbGd+VWbOBUxkA9USRKLNF41sq25Dq7J62Stz7r3j9HK90TptqSTreFTZSVAHVaCt7AiFugznYsPTgUR+rLWVX9himPJXynJvRXTRRlA2RFiPQbFVrW9suV0Mr2MBqniQc+ZH5GKtKnFc80ehtxmQsLo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:06 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:06 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/22] i3c: Standardize defines for specification parameters
Date: Thu,  8 Jan 2026 10:28:08 +0100
Message-ID: <20260108092823.489287-8-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbefe6ae-ed97-4177-cf7e-08de4e985eb5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jDfDN8OLH6hgnUdHaznuuSmgKTAHFBh+Aw9xycFy0LFknyvY8IY5YH/0+Pkh?=
 =?us-ascii?Q?RiPA+qxf/fbhuelk0/5bBwK6h/mcvwhGGCNc+Vsl4oT+Cdy0A+T+g/2kV28R?=
 =?us-ascii?Q?62GIcVfA3Y7czHFhxQMrE6O1jdgr4REahyMlq4tFXl1yPiDnetXEF1IAkZVn?=
 =?us-ascii?Q?oMHtPCOw/4DsmDQFvWTwZ/Tltl3ptwOBXq+udKPvYTg/rxfdbUTqe8MT5c9a?=
 =?us-ascii?Q?ZgPiRixft2Q7/ukl3voQaf8Lo4kVaPomRyERKE0RAGZ0M5aUN7jAOmsrD3CB?=
 =?us-ascii?Q?GgNPpK5x27QyzRjLTwordA/hahDbRRZwvQzvzEGEuDIYYHcQ6im+QpZZjdGo?=
 =?us-ascii?Q?6bwbrFd5sf/ypCDzU0t2av/5Tbo8opcdX3TDLzCGO7lBZrBT5l0OdA4dt6gT?=
 =?us-ascii?Q?0TqGzTaRZ10p95njlsz22+RDgueU+6pRF9fftUBn4+CbFOhQe+WD2DVH+Oh6?=
 =?us-ascii?Q?uGc00jGCO32/wqtCKzMn4VOF/NjBK8Bu1g7PM8+L9fMC9Siuu+d2RLtKJ9XV?=
 =?us-ascii?Q?zyih2qQNJo4/VXh/Y3ZOBp18Qq/+MDkwpEAJT6+0BiQP/vJXL+3/a+kl9pkR?=
 =?us-ascii?Q?GLesRfvqDJSoUIYy0b82h5kVbSKYOkRvl6wtxr6pGlgDgGDlvKMYBZ3VQKGv?=
 =?us-ascii?Q?2fArTf3HXQJra8JapZVIEOLSOVIq8S6d9PsixW/RMlJjNTVq2hOiAw0oUHP6?=
 =?us-ascii?Q?xesMk7xxOv7uhQEJaBECay+g8RlXBFNMk9H1Sio8J+9gRfdD3XQbdrMQjgNn?=
 =?us-ascii?Q?2lyHxnBwQzLv5KLbp8Lu2/O2GCf5hhOTHHwUx/Ox1wKe7XBVYNWyctVPfEST?=
 =?us-ascii?Q?WledE2RU98WoNQWVBVp9lB5VS2SHLArsKp4Frj6eTIsKS8LSJSn+OtXLRAmB?=
 =?us-ascii?Q?2bC6rRSsZxli6YV9m/jxgp4I61ialqAM91eDbRQIzztt4qpCF5KMQpnKmxrY?=
 =?us-ascii?Q?NC+CTQpHgHXEOxwupzCdroJT3MNmid18WH6C0UsEErbz6x8j06wI/OiR6+Dl?=
 =?us-ascii?Q?m1HL/MdLNrJeX++ipbyk9qlZGZuxdhPX6HwXRZjU6pD5eAguKTPZow9YUHt/?=
 =?us-ascii?Q?IyhidU5H8sBSiDS56ei0V0n98VliG6SYMbKqa65Cq/PsQqu4aWXF8N7VK3xk?=
 =?us-ascii?Q?tHoiWymv8OK9NgNfLDM0BGGfMvWfHzhFJTAC2/d8pPxsdHmp9ShF84fs+Vig?=
 =?us-ascii?Q?TW5pT+5O86vCkTpXq5fc2G4abaIyL7IV6/DDBkNhn9Ku6NR66JCIu+sMss/q?=
 =?us-ascii?Q?cHjbS+wMeDXKkPWU3S8BaRytUGnIT48ZsYprL8zvL+qCuNc3Ko2ralfmBSB3?=
 =?us-ascii?Q?qrd7745OxNIwfdYNcmyM4LEc6vwLUF5xQl6CO6jkyIZk90fTVj90CE+cm6Tf?=
 =?us-ascii?Q?BT74fvFCjnUAEY60rJKUC787CfV5PzJBhq7Z2JP/EueaMVgkN7tQr/L+zEHy?=
 =?us-ascii?Q?owjVz4E93c3n0j57RSItdDVoUzt3PLZOBuSTYg7f4UwBNc2yEC8ZBk0BjEn/?=
 =?us-ascii?Q?vhyjVBLy6d3yrrAGH0f+GxaS9ECTlNkTiGXP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eZGjX0TfIYNDS8S1JK0dzy3nLmd+BUKeCLOQjN+EI3oQ7jgJHLwAe3/xMM0v?=
 =?us-ascii?Q?NfQKE2+I+KG4Y+H0jWwPNwAsLxId6HJh6ueVLZQtYknYZfPX8I1Bp9mMgMcW?=
 =?us-ascii?Q?X4unc9MCkHxCgJFdea0LAZgEV88AraT6CMRUuqFPSkQGg/Y4vBkEOG/LSPCz?=
 =?us-ascii?Q?RbLiK5gh0RZk/6c1dylr++/YwEdD3uE/tCIaCGOfONKTWkhNmC028crMyiP5?=
 =?us-ascii?Q?TGN08R/BX5ou+UoVajaBzoS0MXlMfzFxl9aC9rjNhWw4DgwNgckuaHauvSLy?=
 =?us-ascii?Q?ZMt6JZCYP2OyPp9jsu5+GrScR/tGV7mmOEbry9xPkKobqZgUt0Z8RMncT5RF?=
 =?us-ascii?Q?JjLF9ydxG6O1VZCjsAw2mLx7ivuvnru3qG+Lbv4P3TyKNcDYBvUgXd052M4W?=
 =?us-ascii?Q?Or9ZGgaMTd3VnSBKNybLhk0xhMyBMwccrBmBqp8twB8qpZCeOjuGuBgUrX+a?=
 =?us-ascii?Q?J+rf0QzrmCNzdUADI0g8NCxm2zD1+1TCqwA8kCQ3xXTEspCWnbjm0y/ipNUE?=
 =?us-ascii?Q?XnC4mVWJjrNxGi9SsiqlZCFAEKo5rCvCSJCrHrmOY7cbIq5jtcxVbwQ34Vds?=
 =?us-ascii?Q?XPwe7CebhNwKuHur/t2fy963mmJYaSYassuccFe424a1JYjGm78QpSDcEh9E?=
 =?us-ascii?Q?2d37Hp4ARV8IKLJhe1IjTdsYYl/87mmOeA+2gSRiHfFrxXjxh60M22BXrl/T?=
 =?us-ascii?Q?jJ+L+vxgVOHckwNFpqU8gf4+Aka4A/3P3K0KyhBzDjmBEE2SjA5XdHvgVNQZ?=
 =?us-ascii?Q?mMAgJFtLaK1XkUq+8oQkr9a7KyAuE4vNnhU+FvTFSoc547D7+or3XeIoknvK?=
 =?us-ascii?Q?+LoP4Avc+vT4crsVExrLq5ExAvU3mO83FIkmfXwrsJWbYZpXvDlXHaJdp3ny?=
 =?us-ascii?Q?r2g6xK7Q0CFckQA7bENpQ9szsf3FZ1Ia75bopUZVSa+jUTv8RjvBkZYmNO/L?=
 =?us-ascii?Q?r5U44yuQnz4RjEWpiBELBK0Nsmmkf9gSHvSJS2FeU2dc/UhLLnxDDa83JB2I?=
 =?us-ascii?Q?x3liwQ1HgIQt1vK3LN/m3zyKh0BBvyHPYG1Db0AgnFEvcbm+o2WQip6Xf/IN?=
 =?us-ascii?Q?qOTPGcPktXdePz3TpnrSILJuseeegYHEsyL63xtbPQvPBm26G7Hev6RfjiiZ?=
 =?us-ascii?Q?1n+hB8IENSERJGJSjBZRit14yUhjYrvWC43e5UEQgyXxW17CBGRbN8ObmgAv?=
 =?us-ascii?Q?G5a48r6Unq52+Nm24Fsm3MNTiZLeyurQkT0FMhooiYG53GvMC3d/aF3kk0DT?=
 =?us-ascii?Q?U6o+Psap/+7OkdK+1JyyJwDEom2hyIgN6x6CdhBvsVl3cuQyYHLVZytQ/PFq?=
 =?us-ascii?Q?qDI+NTCvokkAkQBy6tqq7rWpUY4nz1GUy28arxRwmiMEmykKmNJPPtoe+wao?=
 =?us-ascii?Q?lYPGn5CgdrHLWze0/C0NQUfFXAIw3Oh5ulLbZa2koyP0maGcDl1zfuS+f4f4?=
 =?us-ascii?Q?6f5QgCWu/mk/VAAwGce1Ifw4iYePmIrIRdP0hGFUTL8feEHpNJeHmotksicU?=
 =?us-ascii?Q?SpgW1b/RVkpmZlfgfCRafrK/6lMsEtNIYrctoR07yag2zKMkaui6sl4K+Hr/?=
 =?us-ascii?Q?xYpGRz+CXdPNJuqWWT6LKENqeVbn6zzRaYGMVNPSub0v/d3xhK0z1jPl2Q86?=
 =?us-ascii?Q?hsAKsAiMZasb3ILipLglnNcOssrATtX10e28lck/fJ2HK0nKYN2CQE2+M6XI?=
 =?us-ascii?Q?C6nX8Rkyxqg4uywcwVMFkdjxgnL2f93e4C05Sbpkk6jp3iFy7S3lp9rimuiX?=
 =?us-ascii?Q?XGqCqib/59h1cjpK750D3uN+1kAvzpy/2dzGhFpWOiSjnzEjkbbR?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbefe6ae-ed97-4177-cf7e-08de4e985eb5
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:06.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+6ie1c7BcJd29VAMYCwMBSvzAp5ONMW5rdaB4Yeer8dVttuXCyr9YlQ8eY3UMl+o+cnEjgt5sBiabEc2Y410gq2NDYwuTua+9EAdpgiuD8xw6gou9GoRnVNYapbMJbN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21443

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit 9c0609d685b27a0bb392390680207baa820ed118 upstream.

Align existing defines to follow the consistent pattern:
I3C_BUS_<PARAM>_<MAX|MIN|TYP>_<UNIT>. Prepare the codebase for adding
new parameters and help avoid duplication.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/r/20250724094146.6443-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/master.c               | 12 ++++++------
 drivers/i3c/master/dw-i3c-master.c |  4 ++--
 include/linux/i3c/master.h         |  9 +++++----
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 019fd9bd928d..3361b466c3fa 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -682,12 +682,12 @@ static int i3c_bus_set_mode(struct i3c_bus *i3cbus, e=
num i3c_bus_mode mode,
 	switch (i3cbus->mode) {
 	case I3C_BUS_MODE_PURE:
 		if (!i3cbus->scl_rate.i3c)
-			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
+			i3cbus->scl_rate.i3c =3D I3C_BUS_I3C_SCL_TYP_RATE;
 		break;
 	case I3C_BUS_MODE_MIXED_FAST:
 	case I3C_BUS_MODE_MIXED_LIMITED:
 		if (!i3cbus->scl_rate.i3c)
-			i3cbus->scl_rate.i3c =3D I3C_BUS_TYP_I3C_SCL_RATE;
+			i3cbus->scl_rate.i3c =3D I3C_BUS_I3C_SCL_TYP_RATE;
 		if (!i3cbus->scl_rate.i2c)
 			i3cbus->scl_rate.i2c =3D max_i2c_scl_rate;
 		break;
@@ -709,8 +709,8 @@ static int i3c_bus_set_mode(struct i3c_bus *i3cbus, enu=
m i3c_bus_mode mode,
 	 * I3C/I2C frequency may have been overridden, check that user-provided
 	 * values are not exceeding max possible frequency.
 	 */
-	if (i3cbus->scl_rate.i3c > I3C_BUS_MAX_I3C_SCL_RATE ||
-	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_RATE)
+	if (i3cbus->scl_rate.i3c > I3C_BUS_I3C_SCL_MAX_RATE ||
+	    i3cbus->scl_rate.i2c > I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE)
 		return -EINVAL;
=20
 	return 0;
@@ -2727,7 +2727,7 @@ int i3c_master_register(struct i3c_master_controller =
*master,
 			const struct i3c_master_controller_ops *ops,
 			bool secondary)
 {
-	unsigned long i2c_scl_rate =3D I3C_BUS_I2C_FM_PLUS_SCL_RATE;
+	unsigned long i2c_scl_rate =3D I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE;
 	struct i3c_bus *i3cbus =3D i3c_master_get_bus(master);
 	enum i3c_bus_mode mode =3D I3C_BUS_MODE_PURE;
 	struct i2c_dev_boardinfo *i2cbi;
@@ -2782,7 +2782,7 @@ int i3c_master_register(struct i3c_master_controller =
*master,
 		}
=20
 		if (i2cbi->lvr & I3C_LVR_I2C_FM_MODE)
-			i2c_scl_rate =3D I3C_BUS_I2C_FM_SCL_RATE;
+			i2c_scl_rate =3D I3C_BUS_I2C_FM_SCL_MAX_RATE;
 	}
=20
 	ret =3D i3c_bus_set_mode(i3cbus, mode, i2c_scl_rate);
diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c=
-master.c
index 49e495509632..d6585d0a20c5 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -571,13 +571,13 @@ static int dw_i2c_clk_cfg(struct dw_i3c_master *maste=
r)
 	core_period =3D DIV_ROUND_UP(1000000000, core_rate);
=20
 	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FMP_TLOW_MIN_NS, core_period);
-	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_RATE) - lcnt;
+	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE) - lcnt=
;
 	scl_timing =3D SCL_I2C_FMP_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FMP_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FMP_TIMING);
=20
 	lcnt =3D DIV_ROUND_UP(I3C_BUS_I2C_FM_TLOW_MIN_NS, core_period);
-	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_RATE) - lcnt;
+	hcnt =3D DIV_ROUND_UP(core_rate, I3C_BUS_I2C_FM_SCL_MAX_RATE) - lcnt;
 	scl_timing =3D SCL_I2C_FM_TIMING_HCNT(hcnt) |
 		     SCL_I2C_FM_TIMING_LCNT(lcnt);
 	writel(scl_timing, master->regs + SCL_I2C_FM_TIMING);
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 5fb114f10623..b399ef2a9359 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -240,10 +240,11 @@ struct i3c_device {
  */
 #define I3C_BUS_MAX_DEVS		11
=20
-#define I3C_BUS_MAX_I3C_SCL_RATE	12900000
-#define I3C_BUS_TYP_I3C_SCL_RATE	12500000
-#define I3C_BUS_I2C_FM_PLUS_SCL_RATE	1000000
-#define I3C_BUS_I2C_FM_SCL_RATE		400000
+/* Taken from the I3C Spec V1.1.1, chapter 6.2. "Timing specification" */
+#define I3C_BUS_I2C_FM_PLUS_SCL_MAX_RATE	1000000
+#define I3C_BUS_I2C_FM_SCL_MAX_RATE		400000
+#define I3C_BUS_I3C_SCL_MAX_RATE	12900000
+#define I3C_BUS_I3C_SCL_TYP_RATE	12500000
 #define I3C_BUS_TLOW_OD_MIN_NS		200
=20
 /**
--=20
2.43.0


