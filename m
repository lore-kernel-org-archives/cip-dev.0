Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643F2C28B30
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:05 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.15])
 by mx.groups.io with SMTP id smtpd.web10.34464.1741778729641746369
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:25:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=hQ2RJ88G;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.15, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+/rzPvmY/NHBuo6xtofPeKSTqSCo9Q6E31lPv9yVYROhTgCk02gEsDGcKrk2EgwsbJXLXoUG5YUmviJ2y9+PuzUXwFaj0PNv9zirZNAx3imMtCLIikVIKPhtZH+QfqzRlhsOg9uEgIrMRjEBwiyFx5B2c9fyoJ3gxGqGUGDvwtnlePUi/iZUEagFNYY0hPE6g8bVVpfkkAmxEUJn2X4yahi550hfA8bYIbIRzkg3VV4B4xIMuCNVwi9m9Z6orHlj7yjZJVM4Td0+hg7gYdtvXaNY9BjFYdYdVGPlbjNYLn/+jPdw2Y6GKI7ML5sB7dZV9Slp5/5AecSaPS05MabXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zn9gAwl9FTa4qSzQwj7JPQXu3fXxO+9DwVHfBeaNk7M=;
 b=nrDJcjQhjmnPgNUHvVfluwjAkYgkVJEeLDStkXQEXSmhvE5zzgrwjs698NiDd6QK6hOpTyEthiz8C8hEJkO8bjv7EETBV7rk/eQEAUNttgcbJz5Ro6k+1Ata4Cg5q+jhqCR2Ox9WOaC4lZyhFHiulSACjk5i6b2rHbtVk89QXhW++qJEuaGYT8ojYNQxbr7utyMwcHEucQt9jY/LzIaxPlNP+LkevlsUOhxb3dCRqL+GbGik1JWqm3ElNQvgngryU16keyrwrPqyJZzzMt2S8KK5FBuMJyS6RCpn9XXg1FP47mi8J2xdiIHAN6DVIwh+wgssbyrFtIGnalseRKnBcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zn9gAwl9FTa4qSzQwj7JPQXu3fXxO+9DwVHfBeaNk7M=;
 b=hQ2RJ88Gwzicz4/OXirQRMObwyRloQRCz+ZwjhfDA6PGArH+RtNlTz7dW5rHfKsnFrui6Fn2DJ9jBUSkdMc450Neu3x2tuwbFfcS8ggkdPj0Vk1aoyD86tkZ9PfD0dc/UMkFqf3yTlq2DrXJKwCZfArTUIqX3MUh51VTIiOI/Nw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB12752.jpnprd01.prod.outlook.com (2603:1096:604:33e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:25:28 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:25:27 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 38/85] pinctrl: renesas: rzg2l: Pass pincontrol device to pinconf_generic_parse_dt_config()
Date: Wed, 12 Mar 2025 12:22:15 +0100
Message-ID: <20250312112302.1605750-39-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB12752:EE_
X-MS-Office365-Filtering-Correlation-Id: 79041ce8-373c-4359-7033-08dd61589702
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?M52cQ1KUSyqI2sHOYJ8qvsq5AyZgflr3dltACceIN/uTbAEbezsKcY4AEkIM?=
 =?us-ascii?Q?x4wdNNZ00WZ9TUvH8enC7w3hBFWvI2jjZyT4YJl1MRFQLeiZGyjvOI2hpAn7?=
 =?us-ascii?Q?QWKp8dAw4RtkqOp+HKzoVePyCvaVAlnKrfKijE/HfCTvCY2tdajfI5JEYMm8?=
 =?us-ascii?Q?2h9IqfZfb+6Aq68wsacNSyLiFHehPJK7h0oBO94KH7RvSTEUVfAcNoaEbL9T?=
 =?us-ascii?Q?DiY7ZBAIFgsHG0F1V1bHNsYNO0COsr5bP1+qYoMZiDILNrmwhizBFd6WEGJV?=
 =?us-ascii?Q?J4vfiqqu7fvs094rsULfDfDt4OyCaFHZexyAzV5AlM70EJgsutH/uDa2OT6Q?=
 =?us-ascii?Q?ynlKHnUWSHz3YnyPqKNcANYDoj8NwfWbSmcBXo1ZhsFccDeYPAnx8yYwdUIP?=
 =?us-ascii?Q?jhZz8zxt1975w6Iq7vtUQoqWIXKRYJ+Y7dX1p+if3DyIxjt7FLoRAyEklRBh?=
 =?us-ascii?Q?Kb45gkokyKuH7Y07sdxwTak+kJNeUOkUMu1fsJjK63KPF4PxurjCK3XtumLl?=
 =?us-ascii?Q?tXM53q9AtJ1ANDN264I4Hkts0OOsC1cGUJABlHGuPdKk1KkQx5IApEpvt2xb?=
 =?us-ascii?Q?TGXW+8f0JgEGmJonRGDtdBu5iSNTys/S+/E8pY2AfK+vtXzGqW/zLt245GB1?=
 =?us-ascii?Q?dxZCQlkpKROySqSIoHj/xUyyyKIE2WJ37xGW7cDskxvwfSAQnwuuIIORYgsp?=
 =?us-ascii?Q?La7ID7ww0XCeYDv7ZTexRvj5mniZfkHMGOFF2cHAtVLbAEuf7VUJ2X4JPVfV?=
 =?us-ascii?Q?mJUpvnHNAMJ0adQUgZJsUe4SB2iPioF7RoLl4T8284BJIM6CH1tueyEyjP4k?=
 =?us-ascii?Q?EbkwbJ3dv66RlLLZeVuPwil5bDIaCp3ADYv82SPFVls4EyjG1umJOj0LfXkj?=
 =?us-ascii?Q?3eIpBjqzEYbyx0NTBU0MDXLFceoBKwE3dXKOeNd0QZCt2RlnXvtacUwhuEIf?=
 =?us-ascii?Q?W80BXBzsDEA2YWzwcvAayueZiViGPHn+uScvNh1JUuENXiVDeoDTYZZLy80K?=
 =?us-ascii?Q?NfcHV4AtDoIs/3hVPaGnz/ENAmxKFIBFhrX6bEJIFlq7Hfrv1p0JKSh7x9lm?=
 =?us-ascii?Q?SCNLcBOsyhkDVxGW7K6VCzvmWX4qwS/++np9J2263Jr9xNiL0ciUR1TKD1c9?=
 =?us-ascii?Q?6Qo4K225c+OSnMQjPQz68Uda6tw6f3KzZHS1hTDSUO2rbooVRAyc4hwVFKWI?=
 =?us-ascii?Q?ke08OFh7h9/PSMsZecAr5vYmy1vjmARgHzPdtp+kis+cU1iqG7gljmZMIOFB?=
 =?us-ascii?Q?XYKx64rAyx+0juvn90yx6lwA9lkMEBFC/HeufLCvk5DBImPmjxlCaMldbUZG?=
 =?us-ascii?Q?wg6GnY5qgulm9CKiT5g92/Ao4bcAROQIGltgjXTRLSRPdePzKtpaIupHDSx4?=
 =?us-ascii?Q?c8bPr0rRX9kuMDef0WpEkmXMfLcoEYT5Ij8GsjDs+joI8stJX9+cpOIpBR9L?=
 =?us-ascii?Q?RsY5uxR6OKYQ7x5RXzzXeUZcKcXI/ayj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DuewWk2Ohpr3o+MpPVjh83ZZ18EfXunuRPJ1nyX/vdU88p1mlsQNj3LRJ5oo?=
 =?us-ascii?Q?w652pNABDhbXjydeqClZ3AuVrms9+Po9ISJaZrLG7FjKdS8r0TcjT81UJshC?=
 =?us-ascii?Q?EylfXnl35+YqPjRro3dJWM9CVofyV0/EPZnzrEJpRDEEzXXZVkVYCEQlP3XD?=
 =?us-ascii?Q?D2o8qQYH9LvBxAFJMshKA72+0gDMHQlJmvrSXCgxspCLkEi7uG5EJ08kmVYv?=
 =?us-ascii?Q?Egz33dZ8NBRpGnaWVQxQ7rRLuAPBgPPW/GBicueC9e/sQTzbY140GPVOyFHF?=
 =?us-ascii?Q?aUt/uM+cZIQbF0KdcBlk2275d+9r4DRfYIvtN5ft2oIMCBPyBTvqaB+yhq4n?=
 =?us-ascii?Q?ETKUhaVyd5bzdp4Sy4+9DfUJ6xwM/6/bDu5R8iwcSlgd1mLsRJHuHQvrc39u?=
 =?us-ascii?Q?krIFkk49I5K7eln64REgJzBiYS/KMITfpgAr6HvOzKOAMbnYOxYFCOdvT7BQ?=
 =?us-ascii?Q?nVtE/8OG+RGJnhFarqzvZSO/trMLBcZZilRwtTohKhV2QHJ0SJzFKUgGZAjS?=
 =?us-ascii?Q?HtiWZaY5kYaU4cvPaTzT6bYS/PTbNtawzgmnuMj9eU5O9jkEeQeRwcZ1WFYl?=
 =?us-ascii?Q?Vk/67Fo4Lc6jWVOk2sXjwvGdCCaDZeXPMZqqHQUbRliyh0ZWTfVoksBf1C0A?=
 =?us-ascii?Q?KWQ2D76GwqX3agUIJdnkAUUMKDIxQhebAEos30NXxPIh/tSPNUUk/0MH79+G?=
 =?us-ascii?Q?P/ogu/tSycmygX60dSYV5ySWcvLq0u8FOvyjUYwNgb5cZPrIvIXkb/3f7R8p?=
 =?us-ascii?Q?0y74AW4X5BRyxZR3kK+JDD3U6+jLzFL/gBBz9mGGtg95LhFzo0WJzaWR48TP?=
 =?us-ascii?Q?nhrrhkaVeDCHRvJyslFbRfXdGYE+tnmHP9sJjDptSadrDcT8H7wezPqpp19Q?=
 =?us-ascii?Q?GkQ8stiw0b1foDqYixGMbPx/dY8jAD7xwnEppZsSDC+SIAkQ9rB5ZgQLf/JZ?=
 =?us-ascii?Q?bhsoUZxuCSx1Q5s8UxD+sjkZaCKdCI0NyMUHMngA2lqYNyw4bMpROM5KGC3s?=
 =?us-ascii?Q?X4f6x/syRRQ/pjzdZyfDZV15ujIoYooH0DW4TyWlrcfi7E7eQiVjWRgpGzyo?=
 =?us-ascii?Q?Qh3+QiT+gF9XDqrNssiLA5tColCnaCR+Axko5BafrS/P7aK+GRQ3zpJ6fRMF?=
 =?us-ascii?Q?KVCUrYBclaMCcmY1XTpi2SX9YUh0LD/EkKBXUGnLqSaMnHOUWvUPuDlunQ4A?=
 =?us-ascii?Q?xEyjmBafm1TB8d6CAfbQx2zZ8z7b7Zn3KjDOParl/SxTRAsE4IQG8NS0knUh?=
 =?us-ascii?Q?QjLbDd/D0AVi8UNNfYsPOg6R/7ls7OHcniJnWRRdtwk1JQrQl8qpqT6Ak7s/?=
 =?us-ascii?Q?4q2SIcWpnv3euZLOfEGyVJZwaKXT8GpMLrvgHIwJfZ9ItqQBPqzJpONTgSMh?=
 =?us-ascii?Q?3uz/Gm6E2yDdIjL29uvw8GfrmAol1lKf2j6dc23pygOKmObgPmSXEmacwWSk?=
 =?us-ascii?Q?vzCNWxASnX0CAnaLdUgI+RfYgA8eWz911MrsWwuyjSj8eMQzUOGV0KYrKkXW?=
 =?us-ascii?Q?hT8B/0q+2nw/1qrEFXOrSvUBuaOQGpPh6jmd8KM4Tqji6CBvdxTz3pd1VW0E?=
 =?us-ascii?Q?Gc58y9qVaLoimv7h2GOS8VbeogJ43mQAJHX4X6wgijp3DQkuIL1EmmfItG7z?=
 =?us-ascii?Q?E/tFRseotEPLmZvfQj8G7A8=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79041ce8-373c-4359-7033-08dd61589702
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:25:27.8819
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/o+1JHddMGz+x6Vs70R82Ue7Sx2ByY40awRaz9463tUeYEfjthokafc7WNktrdvzpMUciqOjp8MvtnKWEYsAoj0PdGPqbLJq+C8SNKp132qxq80Tt3t/KrwKqmiooPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12752
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18130

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6f38a02ad8e0335dd4dda2c42dd599e254cdd91a upstream.

Pass the pincontrol device pointer to pinconf_generic_parse_dt_config()
in preparation for passing custom params.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-13-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 33c96661092b..9c1f32f6e1e4 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -531,7 +531,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *=
pctldev,
 		return -EINVAL;
 	}
=20
-	ret =3D pinconf_generic_parse_dt_config(np, NULL, &configs, &num_configs)=
;
+	ret =3D pinconf_generic_parse_dt_config(np, pctldev, &configs, &num_confi=
gs);
 	if (ret < 0)
 		return ret;
=20
--=20
2.43.0


