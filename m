Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE93CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:04 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.14])
 by mx.groups.io with SMTP id smtpd.web11.1027.1755706141819191484
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ky2ZFyoy;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.14, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EGQnn505WQtBJTCR2bSVqaTaN+GvDDPoWQOpXFRvELR3jUOaSP82GEYQSmyEnvxdFk2WbtY/ZxhO7wl/8J/Wxfyx33bQFOwqb+eM7uhKOnUEXGtxAvudSestDWT2eBEG6hS85QwpRJjh3VeP2OehoqAjfpR84ojuFjDQTzKhw2ydMEMrWP91bZ9eusKxECpHfha49YDjwBh69s/mlF1VpNqZoF72oSDZO7H/unpi1qrlovK8+3nJKNci6HgltI0h/jpgIYGQ2FuyMlGLh6iaq/pwfuwqnteV0xoZmgO107RV28BBcs4TQvuEOptMaAfxwJMnz+asFfE8v4hEC6RW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lqjjMAs8O8ukTMtVlS2V8TKI2uHwT6McKxLxq3lCEk=;
 b=YhCDCUt8VQM5lQpo5b3ooq5E9CUCWSJoN7wFPcQfoECOc39Vs39YRSS0Em3d+hLyCS7NSSNolypTqmrvthELvFc0sP+KLsfaYzXJkb4blLhaRMHsg+rrz3ndeb0SAYibdeqFpJaC44RUNDrR8bK5CBEnQx8EE/i6tqsTo8eDNoKevYnpEq8wRAg8FjATmmtfugO40xjaQpEckyU+O+n++muQQp0k8Vcc75F8QM7WEUI3scmFvNTR9qGcEusuFUo4THY0rkaayf4aW0jBzTkhoLr3nyjAbPyry3RHDMP7NY4Jjn15piNIiJvWgUvDP+i/FRBp6GX5EVQeFTUmePlwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lqjjMAs8O8ukTMtVlS2V8TKI2uHwT6McKxLxq3lCEk=;
 b=Ky2ZFyoyCvSw0SN44XvWbWG5ftl/iq7t1X+wmMfOmF+uO1nIwESpMLWPfbJLG7y6KOa/UUq1O8V3GxJFnYFCc6G3rQpDfoWSR1ihLZW61qrf1hUevcx5NCj2QL1u5FgrzgnxEoe0efTjc1cLmchpt/01YDJdzcaELGkRiiPntds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OSCPR01MB15595.jpnprd01.prod.outlook.com (2603:1096:604:3c1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:09:00 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 14/55] media: rzg2l-cru: Remove unused fields from rzg2l_cru_ip_format struct
Date: Wed, 20 Aug 2025 18:07:15 +0200
Message-ID: <20250820160758.801813-15-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OSCPR01MB15595:EE_
X-MS-Office365-Filtering-Correlation-Id: 703e2dbe-89f9-4828-4fa8-08dde003dee6
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?20VE9f+5pzYIcwTaCA3kZtBUZx77rwSM4sq0QBncE4cfncOdcNEowDqMs06u?=
 =?us-ascii?Q?35e4kS8MIXfNmBSzZhVoXNAVdpMdkVhX/ZIV7Le0VI/t4oyNIttDOc7CzNv7?=
 =?us-ascii?Q?4cN+ktUJ9c30gfyW2/eKeF1Tk3tdvClXVH9+fi+Yj4kqV8tHmD/5cK8Q43t+?=
 =?us-ascii?Q?zcPpk3WAlzpOqdZ6D8wUuBEj7FiI81Tj6DcviDBflmLeJcMpcGVk7VEwdj9V?=
 =?us-ascii?Q?4XeKpQRVo4++k17mJKJie9Fs87jQWnBr8Jn2Gp4um/P9TZEcgMjdjZRca3wR?=
 =?us-ascii?Q?YbhA0Si7BRJonPteKxqQgrlFd/GKyDfRMyVlYR7y4+8G9w/DMwMpW48dzRhz?=
 =?us-ascii?Q?BSqhu9B5qRpAFKQF+UHlvzXJEqFK+ycLIj91mW65qugVO8ks+NxvutumZpAe?=
 =?us-ascii?Q?MNzhds9j6lA1HM7eqBI+hSBBnV1iYVuFCdyeHGtXkWfeyVY4YaDFVpY+CHwR?=
 =?us-ascii?Q?R5M0qxbMBVezeyloMbJKQAkAkF5kDZI3B72m+EKNsiEyhlK5di+CqQ749652?=
 =?us-ascii?Q?hC08DuS+osSNppb163dl6Ix0pqQogkxtyPqxEeiot69g2yUpQqxklodQacbc?=
 =?us-ascii?Q?60FHRGwlHVnA8+j0u2NFAld1KYnf3EGXQZShuWFGsETbF25aJRwaoYW69a1E?=
 =?us-ascii?Q?COwDjb7Cd/S0RO7WzHtaqV/MiTR5YDKLjNVLUac9PzUPovbP2sXiMtlD17g6?=
 =?us-ascii?Q?OoLsbc+lyaew5n3+XxyBn/ITpVWej/mSoii4tkmHFyTnfbFgn1k/dBnEbFOu?=
 =?us-ascii?Q?xPXHWtCqtB0KtOmbMgqfRfTySXyX4HnDSyP6Jl1+hCLO5mxRlpKX4bF90cwt?=
 =?us-ascii?Q?zxIb6daGARfRRrK6pPEpj0F+03nK8EqezdWaXmV+s2oVyZ16XXrMVMox2eJM?=
 =?us-ascii?Q?rSOWOIKOQKmuvg/op08KlfumiVcjvk0s7ndDaDdiRoF6CaazDdQ18kyMJ0Uk?=
 =?us-ascii?Q?IDbpiG+qaJ+PlkyQ/Exo3XRULr7qMJvoh3gx2Wwc5D8cZ2vXkRImmCIRee3D?=
 =?us-ascii?Q?CFKjRya3sICA8XUjHmFDOE1XgLm3zstbaEOS+seQPCSCUZpgtf2ltX3JvbaE?=
 =?us-ascii?Q?DiUOMa0jCMfG77nqbwfxxf5B2kiq6ZGHWTyjfancZjYyneM8wzOF0UmtvIm1?=
 =?us-ascii?Q?elawoDXnVIsT+A0K4GVOUIRq9JFQAOrPfoSWOSg4YXADyRArtNESWatm7Tfj?=
 =?us-ascii?Q?McxjXdsFCyqnvF+uMHXpx0c6h9VAP4np3Q2XIvE1jl5CfXP5CPlb/RDJDYgY?=
 =?us-ascii?Q?Ht9QhgF9Vr97GSvyA85+Wr4QkU3xQgPSqcH83aLD9AYZFLBGe30K98LwQayl?=
 =?us-ascii?Q?DBxdHhs5r5WNchyU1qeutO2IIUtMMAr+g4vyQ89JrSxI0hLSKlzTEKBZH1oE?=
 =?us-ascii?Q?lW9Tq7vG4rwEEbis2754W9P2vyntoLUeDUWb/qoVnaLJnhzgC/C+zh+QxJ8g?=
 =?us-ascii?Q?wM07MdPbSGCkZQBGXqbLMcZaGZc6OjSRpGchs2jJv12k4c3db1Nb7FEINQeg?=
 =?us-ascii?Q?vTblnkOFz8ORTms=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X38MNkU/FDYR1ViAwARqZ4xpW9p6f6Is0cROYaDEVq6Q9J8S/QDw2b+EF+8c?=
 =?us-ascii?Q?y3tZGM9qbhPzOd3NHMdm0FUpiKb3H0ScD2qrqL+aArzwAGqE/sF75sDuYZ1+?=
 =?us-ascii?Q?cqIxuGRRGThPiIsM8S9IZL7Gt+TyOYrX56QMj10o9JXscYF5iGjtaCQkwbEg?=
 =?us-ascii?Q?GWjhrRGKqOzgJOdPg8gO//lWIvMP+ZqGmoIsLxGPTvsOW8XGPppEV2L/3CNm?=
 =?us-ascii?Q?qswSiZ/v288dZTJSc/bov35iUnpz+SG3KY+3tJa6Ro7VuDk4g1q3eO6rqIBn?=
 =?us-ascii?Q?dJOu3nCksv2SDyZG3fl5NzQe7Xo0yy9qiDc46Y3kaCLh76CUTBrFm2RBbLKg?=
 =?us-ascii?Q?3X/zUZoksebq5g7qoNg4+nVk9zROLmOfclbZCnJfAzjLjyF/loxN5dKSjdLy?=
 =?us-ascii?Q?QjXhT639LBCtRrp8ZhAvSXDQp8u5qsEtmt6rwXpp3T3XP6yUEBTKQz4RHzwN?=
 =?us-ascii?Q?qvFa/dFJNjAfNhGd4GeX3xs7c8TkJ3SfuJXsNrZ+htxUZV/xnVEDJ/GfcwBp?=
 =?us-ascii?Q?5dT2QikqQ0+I0YDAvlAKXhHk4gKrrRkcEE+XdPfl4Pv6ZhKKss/YmlVZHW4z?=
 =?us-ascii?Q?RF3MjEt/sLfLTSmpwUqJZZBJwIk8pnAoZYAIzYwDN6DMy2MkrEtHqYNa4r47?=
 =?us-ascii?Q?g7mFwnDmODK+Tw1qJEUjEqdjkA0kIyRjYlSSaedDcVANeajb9qo9gOWLaCNS?=
 =?us-ascii?Q?MWM/4xEOeFOGgJkEw39aDSP5oSo9PiB6lb6CQEG2Ba4ITddp6PXIYUUi9+2S?=
 =?us-ascii?Q?rCWCLAmqaKK586yUnmtWvJ4hyATgHuolMM/mshns19Fezp754A9AgMIpAdSt?=
 =?us-ascii?Q?W6Q/D3YgxM9iO1mWkb/BYZR85IqnAm+0d0HSavJjV4LRZht/7WnE2d+jPQqM?=
 =?us-ascii?Q?vVld78Wi8oloSyVd0NN67tmXfoiTqUsko/n3ohuNSo4z6WuVK3OQJQr6NSya?=
 =?us-ascii?Q?VQm89s50WZSJPud+Y2zoiCf7y2By5we7++19B3j93GwmqjvfqqzQEhdjXJQW?=
 =?us-ascii?Q?vBuzF4C13QWLmVI/Z8DWX8dFW1ppaHbLgwy+rOVYtHC63Av2HLYzblFD7+di?=
 =?us-ascii?Q?knrNI1uDqV4Xkydo8Vici4zRnbBNOG8E0k2IKpTJKBgw6aVAoS+DQ0wJqIPs?=
 =?us-ascii?Q?nlkRcGEqZ3aw+chB/SKaQF2RlgLp4rNHNwnIM9pT4DiN+LHEkXShU415PZQH?=
 =?us-ascii?Q?Nda8RWeCrDWOJLSWbqCCjBIQ1omza5WPguymESGoN4ccKOTprNUQgeI4QU0h?=
 =?us-ascii?Q?FnRKPnVUk6CEuAKSQhWupX1Zlb808ypH8Dn+aGCKs63ZnYGnQ/eOis0TmloM?=
 =?us-ascii?Q?MMu88Nprrqr+Yqwvus2QokY5Szr1w+9C8gIOkfiI7xL+9qP9psl4x9yHSd+e?=
 =?us-ascii?Q?044Zgzzcynm/MBpVki3CcrVUz2RCF5sXHmAOmr/tjB6AsffTNF11yBYzxMse?=
 =?us-ascii?Q?dN6fwkQ8in8yUkQsmSuLPQxTzk1OIcpUaiVJlw07D4/a1/iXB+fXt6mW1LLA?=
 =?us-ascii?Q?5TBe4b/1KRZSAIfQy8PGjxks5vBWFqaWqkLAnnjIr/LcCC731VeHHdB9cwY5?=
 =?us-ascii?Q?8k84daC67cEI0YiEbHPYoSvVreJFRErBq3wuHfBQ5XKB4vyGPJvGM1hD9PYl?=
 =?us-ascii?Q?3Kk0kRCZPU1Uyx3qyFrqUCY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703e2dbe-89f9-4828-4fa8-08dde003dee6
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:58.6464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YnxgXOa+PFo7OnqVrw0HhuDIGxQQFu9ZeHcoeaqoOoCb+k5IT+2uaClTr0ocJ3g6uaNCIoGIz8Ij0N201bb11GeD1gMtBnzwvA7MDmTXaAxQisUCnv3YTJZct1cKeoUV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB15595
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19895

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 40516958d7ec1b3b92d6db879d959eedb8205a4c upstream.

Simplified the `rzg2l_cru_ip_format` struct by removing the unused
`datatype` and `bpp` fields from the structure in `rzg2l-ip.c`.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-10-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index aee7d4ba70b0..7b006a0bfaae 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -10,12 +10,10 @@
=20
 struct rzg2l_cru_ip_format {
 	u32 code;
-	unsigned int datatype;
-	unsigned int bpp;
 };
=20
 static const struct rzg2l_cru_ip_format rzg2l_cru_ip_formats[] =3D {
-	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16,	.datatype =3D 0x1e, .bpp =3D 16 },
+	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16, },
 };
=20
 static const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned=
 int code)
--=20
2.43.0


