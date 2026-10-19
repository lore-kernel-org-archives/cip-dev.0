Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4CFCCF2E6
	for <webhook@archiver.kernel.org>; Mon, 19 Oct 2026 10:26:00 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31404.1792405559440302034
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Oct 2026 03:25:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JBKLF2Il;
 spf=pass (domain: siemens.com, ip: 52.101.70.60, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sczW3sumihJg5xfyyDXPjjQU3lKEC08ka+RDnd/+iuh1JRXExjTE/+6ORoyh2HBlX4xp74BNPj/QtErte8ceC1KJjKYevHR7rv8MNO8R4x4hxDYsQT4DyghP/LI8S2hB+USbzkjq1pi3nmjUJpOVeHqOa7Gb9KAYc4yw/We2C35DnkzeRtuv1Pr2YED+rU0/sbvP6e/xnDMtTTGX109f1q700RCmA4D5URopJ9yuAGE1M510fImMyCBxbtpXDowYquwVPs1HJNlaQjFqTUjBxgKOwl9nV4Xz7G/dnszqqYeM2J5rib+++I8SNR2nuESWa4A58rVbaPQ+IcapgHJxyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZlBADfOUxDFddeFjHUWtgfpEfzTM61wTQehI5ucFJE=;
 b=qPuhcDN+2gcNid0JRoF23ubzpOdSbBlM0TqfffTj5TkTxrFQ49crB9Z2YX/OFCPZUIMRdY0KEdPZZlpKO67ZcUzDMt2ywup/ohpjrLo42XHb1Q+O8wTsejVctB6rRaSWn2a7nAumpCFBK181W5h5Q6Cv9ZmzsW5LpnM8UA2RJJus7HAbxoKO0zWfUYjDVQzTI1QEDaIPvLge/n/Bghjdx/Zp1i1/PNMNBuV/jy8yXXOatiZU11iK/iCUM/SHgIaRxoPP1Lmhc/fOFeyj3lbkbRqXVg5Ool8zeL8uGwmyPwfBeJhowvgldAL2HS9WM+4N6+Xw+t4CJi4oZtqGQHhM8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZlBADfOUxDFddeFjHUWtgfpEfzTM61wTQehI5ucFJE=;
 b=JBKLF2Il5s5n1XZ82bzbe9NOjFJGZGLgvrpDFN1mL9qI+y7ecCyZiPkR7W7cpo9OmWqKl5JLrRJUg8Upc3PkB+yyN0PcwezVgXA4f3z5lqegufSnl0K54hvNS/ATs70UfY8VlPksqlitXIAJkv04V5yt3QJP9X6uO7C8XjFdGx9+VsmZjqaf7Xx10IPlhE50+4Pn76Q27fyW4llISt7uyc9zPUzqOlNHIhO6JoW7LYBqRsVlDPOLLp6fTaxSKcRoO+VNioilu7uBg1qTpxFL10tHNEEeCUyQDQSvhWt8xK/FR8fOM1ezPLXcfhebNbENgcFMCta+qo5XaOxHEKMfCA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 10:25:52 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 10:25:52 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 06/12] factory-reset-helper-efi: use systemd FactoryReset variable with dracut
Date: Mon, 19 Oct 2026 12:25:17 +0200
Message-ID: <20261019102541.672620-7-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
References: <20261019102541.672620-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0314.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::13) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5524:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b72dae-7540-4ccd-5b5b-08df2dcb59a6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|55112099003|18002099003|22082099003|10067099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	zVlmKWdQaCQ/8r+R+cy7zCnw8r1BIM2ljN2yGm5qWLa2AuBINFKnZOud+F553NB/c9R09YkXW1aeiEEzFoIBcVl4dzrFt+/v0AdWpuXKqEzzKfrp8+aC+S7GNl3uzxgK6Iop+zRU6QeoH2ML5801DDlTy0qyzjRoBLD4T990wouKGWPl+o1zstkcxQ8Kynix2eFRJSvLv1poyqeDSMasaoa/3kTsZi9CDkScB6IQFYapRqGg8jRw/h6grdH7aAepq51vRmFxDTnEX63odDV3StVBCFM67VJdUlYGvCW4ZEJfGfu8kJnS36kiM+eKE372jo0WlLWRtQ599mMAmi+w9X5v/XBTWfwx6wzREXLo2kjFPk7BgMjVYS1Xuwxz3BWZPyh+Ude6bipzZbq7JRCQ1zEt0EPUlSae8vZcH1CLLmX5iPU7R9Zqngf2YDn888BvvJfu67Lx9TsiS0ueoKaQo6EQ3jXUvvZTqZvbjAsn0tYAsk0UfjVhyfbnwkWsqynenPB3WrpTXj94uaEaadWnBOIL2+TxR81xHDC+4Jg8LqtIQgDwiYESP8G07lQr+05QRQ+o2cySpE9DQYKqB/MH/jl6WTsNzlKKS3nsgAY9sQCFwdg6Xc36kzS1T1UpRrde
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(55112099003)(18002099003)(22082099003)(10067099003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ENUnQT23Og6zkYGOTS2gwhHjhxGJFTvupZQFpksRwGHZiQWRhch5fN1bKCVY?=
 =?us-ascii?Q?L4eZX+GG4pu6ujUzHpuE1VmxlvaRC65FYvppgBBy1FgfwdFrL8CyOpQEAidG?=
 =?us-ascii?Q?8tJodk2tXMuvHOKGajcLiyRcZU4MKtSHFGOWVttxGC4bMsuJMM94HevqhV2t?=
 =?us-ascii?Q?he5hEeBJH22BEIkiGIVqodVb+tC2m8Sw5w3kHh/7h7KCUUT1EVIfPY89H1nN?=
 =?us-ascii?Q?0nqRctjjOk6rcnsraO1hp7b7AxhM13ibN2tomlhahkRKdo333qMCajCDNZ88?=
 =?us-ascii?Q?Expcmltlnpqof7AYfWAwb7NJOV5vrqk9Q29kKzagHg0Ch9OTgFGpF1BOWNXF?=
 =?us-ascii?Q?4ZUblKak6Buc/ZZ9DHgrvgFRLHfp85K9gatnkNajG/lKuShpdm/ggMcr7WI7?=
 =?us-ascii?Q?NgUHywaFv7f61kYImF+HYPuNNPVyeD1Na1I0tqtDBJZCT3j4I8YKkkc2cqs+?=
 =?us-ascii?Q?yPW2wg38yvuvHaSk86UmeqxDq+h6AnijukeQSSwuR/PxCIZEDZ+FFI21zuJg?=
 =?us-ascii?Q?3xo0hFohSXV+k/GONqJbpQPVzbWB8XUNEMdWML+e96Y586iIKgGimvEa8lQn?=
 =?us-ascii?Q?zROn2Ptdteo3swscZL6aDCgf/Qb9NW7u71/wXhnn0BN6yeBuedEFOktvF+ig?=
 =?us-ascii?Q?qWe+4bqeXCm3H5zEP2eLiuSUw+YfM5qn7wQNaUFVAl4811jnuTitwhSjfkt0?=
 =?us-ascii?Q?2TScXTgtZFJHLe9+/pzW2YXjetPwIZGyxgYpA7KNy31E/bEXXVd/SfQ4N6SB?=
 =?us-ascii?Q?QJcuVrGoWdfK8WC/LeVtINvzB7NWjACa3mx+oTnemYNGjAIs5OvVY3POfElo?=
 =?us-ascii?Q?981kbvyh1KzaZtBo0KV3ZdEp15RymxMXonYIpseWuS22CqakO8/h9HDnvdED?=
 =?us-ascii?Q?3WM+yDYC2xtOCP969vT3yTDdAdrfWvGMNi6+vrb4vCWK0M5A/SQ0R1MbtDJK?=
 =?us-ascii?Q?bOpwIfrlLbu2O15kIFXWJ+MF8RrRlJqE8ztEKLtKBJajjDYX55DuGPQpuZ14?=
 =?us-ascii?Q?NDZ1IZndfgJNpI9ii989jDLfxkX6tkk2is52y0BuGv0uBFLoxVZsgU1iCkTP?=
 =?us-ascii?Q?/roNuYAb6OaEWaJpzdOk1fLREXMksRBj4Mk65eAs9ULFruecu9EqNAAMnf5N?=
 =?us-ascii?Q?Ti7p9hpW79qaoyWy5eq28yIMLlTu16k83lpTcSpE552thKRJBuiqUvDoRcvD?=
 =?us-ascii?Q?yfTC4I7EGaD9eS69qGxbobKYOHlnXy/3RJraaTvz9RaKwzVvcw18wxBOC2Np?=
 =?us-ascii?Q?fD+Ez3zD6CRmR0r3PMpn8gUawvApnR3kg5jerghwn+rL9sVROZPcjRyDxMTu?=
 =?us-ascii?Q?hdTs55KZZNXBftfswnW39gjmaXS3K3vPyh3U6P6h9p+tWHp+7PRTM1tqmyeA?=
 =?us-ascii?Q?eVEv8C5DNlAb2LUOx9k/0u3BWVYFIQQgu31Fsvk9HrpNAGUcX9MdbP0+Rpx+?=
 =?us-ascii?Q?wtVU49JdL3qFn9pC5A51FZxZGdGUtqt8LxHwbxbFEUatOG3EWRO5H1uCh0Kj?=
 =?us-ascii?Q?t3Ci7y72RbLFVs8KU4lvSeBsazNl+pomYOEvRZToMswdWs8hHZSFshcwTde8?=
 =?us-ascii?Q?TZxyMWiaHXC4hAlZvkQtK++hOwmRciAXeIMG5XiKuMoHtQx6TRAV11Y7zmkN?=
 =?us-ascii?Q?DigStsiVw4m4s+CrvXVX1IkOgvAaas9FpNY8G3XQkZk3g41wqoqQ90xhZhHY?=
 =?us-ascii?Q?XXsPCjHySTrvxgugSV+CtGKU/tZpn34QClbL3i4b2hlBgmPj7jy2OpbVm4Jb?=
 =?us-ascii?Q?Gf4ENv0xh5NgZlbUluxI15aahzFR42Y=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b72dae-7540-4ccd-5b5b-08df2dcb59a6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:25:51.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PscOpa5cKoXyIcICfAKdcnRnlL2UQvcuL/uWWtAJAskMFyghRe8TtoT/0rJQO/cK/tOLHBMT21CIoonCVr0lHZoV23hf7p6zau56Q3UT8W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Oct 2026 10:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24486

The cip-factory-reset dracut module reacts on systemd's FactoryReset
EFI variable. Keep the CIP vendor variable for initramfs-tools.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../factory-reset-helper/factory-reset-helper-efi_0.1.bb     | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/recipes-support/factory-reset-helper/factory-reset-helper-efi_=
0.1.bb b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.=
bb
index 071b1ddb..bd455897 100644
--- a/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
+++ b/recipes-support/factory-reset-helper/factory-reset-helper-efi_0.1.bb
@@ -15,9 +15,8 @@ DEBIAN_CONFLICTS =3D "factory-reset-helper-file"
 # use systemd-factory-reset as default
 # https://www.freedesktop.org/software/systemd/man/devel/systemd-factory-r=
eset.html#EFI%20Variables
 # The efivariable is defined by ${FACTORY_RESET_MARKER}-${FACTORY_RESET_EF=
IVARS_GUID}
-FACTORY_RESET_MARKER ?=3D "FactoryResetRequest"
-# Use a new vendor id instead of the one from systemd
-FACTORY_RESET_EFIVARS_GUID ?=3D "abc688c9-fee3-41f7-87d3-1076e4a29e8f"
+FACTORY_RESET_MARKER ?=3D "${@ 'FactoryReset' if d.getVar('INITRD_CMDLINE_=
STYLE') =3D=3D 'systemd' else 'FactoryResetRequest'}"
+FACTORY_RESET_EFIVARS_GUID ?=3D "${@ '8cf2644b-4b0b-428f-9387-6d876050dc67=
' if d.getVar('INITRD_CMDLINE_STYLE') =3D=3D 'systemd' else 'abc688c9-fee3-=
41f7-87d3-1076e4a29e8f'}"
 FACTORY_RESET_TYPE =3D "efivar"
=20
 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, bsdextrautils, ef=
ivar"
--=20
2.55.0


