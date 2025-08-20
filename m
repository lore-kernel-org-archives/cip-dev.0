Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E866CA0EFF
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:09:44 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.59])
 by mx.groups.io with SMTP id smtpd.web11.1044.1755706175682582047
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=uXcld8/L;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.59, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQAlshlIaqO+MDs+1p3/PFYhVXuDvJsR9uMWAiULsVhCVUz8SBdfD6PB1/4gBTQiq7mAOqbgIfOLE2JCzsd0tUx5CbcV7ChdoYwNOp+Yk7adUN83aBME4AxFnBDn3aVsdzWxYqyWPwIdjOMeYtokyCLWNB4dpqbHomurP+LJGyJYpaNi7pjb8/UQp9Nx9LVUJ67Ernr39Tn1dbgti2ziK0C+2t68DfQ8eUAyUoob0j3QDTyVffAA0MLZ3r/w2zEopvL0PVH8RKvm5AaQIVHmpeAoJt/B0DaTOSiKY6mW652xQTyIy6a47rcZMnbIYWjQgVn4jFhqaV/Uu/QzfwMsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsJvz3giC1fRZ240ZyZ899y69XUX9VnMm42bIAV1MLM=;
 b=vGd0ww/eiNXlLq9X7FGstMuJP8uaphi0TRo5oBkjxYmbhGKF9+jyE2Bdfl9fuY959W5QJL2oWCgEUetGuof5O/1w1PiNCkQBwm8R7q15YNkvm0dzjcJdsAFD+HSdTcwuCnU365Alze+ZJ1cZ5Ma7RBgMeiOqoFzZTAnYDQuwb/45nRWoVokMMr5PfFr6KWxzJrt6AEje5+EDooaYgZk6TTJ/s6Et4W5hTlvBzW8GC8dXakGa6xvSI0tc9qhetiZeQ3DcXoHrcyM0nbc++RPbsCarT6vLaA17e2TpjjPA8NqKwkgOi07c1hkJHmodn6rhIJhUkbS3kD1ySGWQ5GL/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsJvz3giC1fRZ240ZyZ899y69XUX9VnMm42bIAV1MLM=;
 b=uXcld8/LxjS4EdScH9rqT3CdNyMvBfkRuWYwfB8DOzt8KJ5ajY3e6zCMPDGYg74yiNFWWRlDKHpifVycgI/M2piWAjH7l0NFiHka3yLG665+0VCS4CJ4gF+DCIWc69xlrWqON2SciY6S+DLj3eod27D88YlpaFAm9VzD0mIIroI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB9889.jpnprd01.prod.outlook.com (2603:1096:400:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 16:09:33 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:09:33 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 28/55] media: renesas: rzg2l-cru: Add 'yuv' flag to IP format structure
Date: Wed, 20 Aug 2025 18:07:29 +0200
Message-ID: <20250820160758.801813-29-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB9889:EE_
X-MS-Office365-Filtering-Correlation-Id: a2190680-9adb-46fc-461a-08dde003f3ad
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Oc38L8+vvkf5Rb4VouFg7TFxWv5nmlkwCp3F6G11Oqcdmy6NZk7XwwYGA2Ck?=
 =?us-ascii?Q?wIyJ7pW9DPP/Gw5QXnj06DyI2nlyhFRLh/rEYTCDYGuY/guHlYvuBKGpX7SS?=
 =?us-ascii?Q?fFpogiag+U6eOUjeGv5+XRtTiNggWwzdfbj+Hem34GgXMiF66unOUm5GAM6m?=
 =?us-ascii?Q?iyAfuDsUMCF5csZLEQ4I4AiYjZ5oM/LRI1iHaCdtbx/t0iSghu1knhkUFS+R?=
 =?us-ascii?Q?hOJT9sGG8Az0PJgxvy17+7N8cD9RJmH/wNeNEK7Xuuw5U1QWgqbbDQPirWIS?=
 =?us-ascii?Q?q4dmBdOQd13XtlNsURXH5CEe6RoZaT7Vq7Kn3s8QsgVtiE2ovk7Dkn0CrUDL?=
 =?us-ascii?Q?5an1ZptnRAwXYQmLLfutezodwje+0uiFh0aCA5bGD8BM5OS/V/CU+i+YZuwL?=
 =?us-ascii?Q?okyxRUZLpJNjkm5zYWg7XgYhi10jhtBUlntJdxcTiRnYEgTJbgTpSzDVtzVn?=
 =?us-ascii?Q?Zm9+g+7uhVKZauXh2g6tK3lOEMK/5Ppz6ivf4ghXX7R35/H7dmxjIJzcWcNN?=
 =?us-ascii?Q?cFQIiM4Cvs9L127yrUYH4FI+HWbAmAc22pXuKVBOeXSRQXJWUkWl26RC8+UL?=
 =?us-ascii?Q?EthPmH5nqR957Qy4+l6EF8Bh/rZ6CmmVAfP1RcgZFPBIvAC5K/baQvr1vToi?=
 =?us-ascii?Q?hypHvA0I5NIkT4EY8dqSuGq8x28Phpb5gOa3w8tpCJLUF5qOj0HOhPb9khA/?=
 =?us-ascii?Q?e5tFG/SfATR/VHusTICeNkm66wAW0tC9oCaHa9oLOIDYJdIWwlwkhis1O1jA?=
 =?us-ascii?Q?hIgCe97Z/wj8jBP5BEWbEKSy+iCZ540frVm0cjL8V2q1PxEIDktre0B41k5t?=
 =?us-ascii?Q?3w7gCbL637kIag0LMyCYBzy13qOsaYgtDUkHHXmyLTG15HDJEXKgVYoljRQU?=
 =?us-ascii?Q?u4mu3MZB8RziZGvyI7OM6jhwaA8A8mB0fflDbbtvF4V7m7XWbTsLP5eYc0Lm?=
 =?us-ascii?Q?5gJ0OiE434o9LS6QntgfqzSQ/nJMgtEiRn+ipqXem8m5UXvcmAViTY42EL86?=
 =?us-ascii?Q?4dPva0AQL2uBHIjmgJdv0WjFRcZm904i0HQ5SGZnD4CqtX1M72hqN7F69Mcf?=
 =?us-ascii?Q?UKn4E2ql54zoDAuMh4NB9XQyBB6TENRUTPjIMYRjK/ZxVRQYhH/fU7lza5gh?=
 =?us-ascii?Q?xtPPpUI5A8GRflKMUrUWgK2yy12I4572wtRCwXFJk2JjE1+T9al5MKKxwwVw?=
 =?us-ascii?Q?etcBiLyXAXQqSlr3QzepWb8/eKuQub9AJLb4HTDNhphLVvC80uHoeMXtbNA4?=
 =?us-ascii?Q?C7gWe2uU62qiuz4f6s8wLKQ4DpNnECQ7q27vsTEBncil+n8xeS9LvsBTtFYK?=
 =?us-ascii?Q?AzjagMeFPaoLJhDZxtLQsgP/RgQA5xUQuqxqRQJLABNvDZ2WtkvX6KtNM1We?=
 =?us-ascii?Q?c5/4JW9Xsm5U8iq7SkferBe8fLwLLz5BZ2LHxo/M7yYR5Dr1JX+oc/qgxKKp?=
 =?us-ascii?Q?a7HyUsJW9Q8owIJUB8TAM2E66AA47JXVpeFyhVutb2BPs3+mzAhjujJuW/WR?=
 =?us-ascii?Q?Qrv8lXFNg3Vx2X8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?sx/o0061RWu2rKWZ6CGyuYgWAIF+xaIBoOnZKO39z/aafEzIg2FMlxW3MBR0?=
 =?us-ascii?Q?eHtbdH/sof7UMN7D7N/VT4gPamD3KBg2Fxromm1FXzxoGsOcPLZny+R38cY8?=
 =?us-ascii?Q?P8fZZx3lqVYPKE4rWnEkeA0Dhy4v0ihni5EGgmYFmaeKLRv7s5QxmyAVLypI?=
 =?us-ascii?Q?HFRA5C7LFIyPs2Yr+pnHfYVpaB5SP1iD9U0Y/W8W/LOMEPb/XDHc7skldAFB?=
 =?us-ascii?Q?CdIFZKUenIBuBxen1G8KC4VK3ltkx8sVF8Ywi2R+kMPEKgB9dD98AF4lwD4Q?=
 =?us-ascii?Q?b8netpCkI6zp56JcyYE072RXfBEwQud9JFBxR2UOGB1ZNLBtOZVtE+Vd3W0r?=
 =?us-ascii?Q?5ZOYsKuCfuARJHlfExRMB1dAgyVwHL1tgSKrR23fRDLu6fah/ZakOOOAE5hu?=
 =?us-ascii?Q?S6TatjoHmf5skm3fZ6HFRbgjHxgPWGo/S6qbWqMrxBDOGNnA9e9qotjwsLzW?=
 =?us-ascii?Q?omT6obtvNH9xclNltfTeW6SLqiKipVURvraBB2Lb6TuGL1VkkKukJtVb0+i2?=
 =?us-ascii?Q?p1BCDcSzY+Pr9x+LNNeEs9KjbXaeodOcb2VGk1EsYdo92Af7xtUcL7nImTCU?=
 =?us-ascii?Q?v97NFy8SYyK2pnC7pNuhh86pC4slX2zhIbfBzlfHaYSFHV2USVoBHKt70tJA?=
 =?us-ascii?Q?wVK0+1XKGqPUwtbAIoZwwcqAcBElLpjoGj5ZgNfpNS1qKoaf/VAotnNEHV28?=
 =?us-ascii?Q?OyuYY6QeQqlZvU6Qpm4pgjijL+N5AfTcWcdIAyUM6zTOBnZJXLXytf77tyYS?=
 =?us-ascii?Q?OieqMbGrnp3AdRkvU5MKfQKmQnqx98edWxphaufk7nz+ialyztRLVfUxokcN?=
 =?us-ascii?Q?0ajhAOQ59u7yHXKO8ouj1e5b+PZ2Ll8yQINqt2BfH6F0/K/jHT+vP1IqLRYb?=
 =?us-ascii?Q?csbCxtaFLsqQ2+h4AeshDI+MqPwDsSXHHs8C6wn/DgSEC1kzr04KV84hemFh?=
 =?us-ascii?Q?5qkG/WvUbcNx0BNGDweBN8gzmgNRZgZut0Ufb85zhv1LqxOhlODmZgEqnOeQ?=
 =?us-ascii?Q?RKUA5rTmeXs8JLFB32uaSNEETUnZYr/+Gw/cZ5P/QILxkFzn4bIdS0gvbN0X?=
 =?us-ascii?Q?4kxSFYrmMc8lJjnqkGPylv4vcMWtdDPGJUpZPWV8it72mNCNFIf5cBfDyvFa?=
 =?us-ascii?Q?pU58iuGcusq/9Wbwxz3tdhHpVl216S2yRhWVPW6C6R/HxItG7DlEvgM/lNXd?=
 =?us-ascii?Q?l5N07eyZa5R6HHVYnxhVrU0+PFkSZjK+OicO7PcQEY/WviZElyv3pK/6LjiB?=
 =?us-ascii?Q?+YJCbfxdgqRH7UIJlcXH5b1cmT5aU8A/Zs7XfMhRw3xLms4NTLbs+RIf0L4S?=
 =?us-ascii?Q?ZO5x1Q55cvCBA4Y0CL3O7Wk5DF6z49S8EsIghV9piuln8Z8aRE5/sKamVvkI?=
 =?us-ascii?Q?J/G5NfnPwOy2nUpNFn9spV6ngXDOphzXqmdjKwjSSnpchHCFIBJNOCJbGqcS?=
 =?us-ascii?Q?Y7EkusUHB3ydiYJUo1eMdg8ZtixNDSCWKD+XE/5RZ40jF7FDgqm3ao7eDW/d?=
 =?us-ascii?Q?xtRtH12uTGwLVSTN4Lyv4pqe/Y8CtOisBCtWjXSKDbaZixvZZG3ZDT9fhMgQ?=
 =?us-ascii?Q?jxN/+Ke0VZgxuBGA9ZPj7VUCG+JWEabAKeyNmO8270WRZCKHrjMenq/3NtqL?=
 =?us-ascii?Q?JkUn7Z+4KGOR/KlZJRj3Z4k=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2190680-9adb-46fc-461a-08dde003f3ad
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:09:33.7057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NaXj5zG/wnJyyW62fVPGtXaCUHo21mO3zkWaJlIQnetExws12cZPT4+sXfC8gPWNgmx2FmndtYQhKZgEgFrjB1FFIxV2hNcd+2ImQqMBlQplqCDh0CBYJPi9o+CyYNY9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9889
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:09:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19909

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 2269e399b3f0f9d474606cddd9cb6a833fc62b7f upstream.

Add a 'yuv' flag to the `rzg2l_cru_ip_format` structure to indicate
whether a given format is YUV-based and update the `rzg2l_cru_ip_formats`
array with this flag appropriately. This change enables a more efficient
way to check if the input and output formats use the same colorspace.

With this change, we can eliminate the use of `v4l2_format_info()` in
`rzg2l_cru_initialize_image_conv()` as the necessary details for the source
and destination formats are already available through the `yuv` flag.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-24-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h   | 2 ++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c    | 5 +++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c | 6 +-----
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index a83e78d9b0be..8b898ce05b84 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -69,6 +69,7 @@ struct rzg2l_cru_ip {
  * @format: 4CC format identifier (V4L2_PIX_FMT_*)
  * @icndmr: ICnDMR register value
  * @bpp: bytes per pixel
+ * @yuv: Flag to indicate whether the format is YUV-based.
  */
 struct rzg2l_cru_ip_format {
 	u32 code;
@@ -76,6 +77,7 @@ struct rzg2l_cru_ip_format {
 	u32 format;
 	u32 icndmr;
 	u8 bpp;
+	bool yuv;
 };
=20
 /**
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index d935d981f9d3..76a2b451f1da 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -18,6 +18,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.format =3D V4L2_PIX_FMT_UYVY,
 		.bpp =3D 2,
 		.icndmr =3D ICnDMR_YCMODE_UYVY,
+		.yuv =3D true,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SBGGR8_1X8,
@@ -25,6 +26,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SGBRG8_1X8,
@@ -32,6 +34,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SGRBG8_1X8,
@@ -39,6 +42,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 	{
 		.code =3D MEDIA_BUS_FMT_SRGGB8_1X8,
@@ -46,6 +50,7 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_form=
ats[] =3D {
 		.datatype =3D MIPI_CSI2_DT_RAW8,
 		.bpp =3D 1,
 		.icndmr =3D 0,
+		.yuv =3D false,
 	},
 };
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index a4dc3689599c..e980afc32504 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -210,7 +210,6 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2l=
_cru_dev *cru,
 					   struct v4l2_mbus_framefmt *ip_sd_fmt,
 					   u8 csi_vc)
 {
-	const struct v4l2_format_info *src_finfo, *dst_finfo;
 	const struct rzg2l_cru_ip_format *cru_video_fmt;
 	const struct rzg2l_cru_ip_format *cru_ip_fmt;
=20
@@ -225,11 +224,8 @@ static int rzg2l_cru_initialize_image_conv(struct rzg2=
l_cru_dev *cru,
 		return -EINVAL;
 	}
=20
-	src_finfo =3D v4l2_format_info(cru_ip_fmt->format);
-	dst_finfo =3D v4l2_format_info(cru->format.pixelformat);
-
 	/* If input and output use same colorspace, do bypass mode */
-	if (v4l2_is_format_yuv(src_finfo) =3D=3D v4l2_is_format_yuv(dst_finfo))
+	if (cru_ip_fmt->yuv =3D=3D cru_video_fmt->yuv)
 		rzg2l_cru_write(cru, ICnMC,
 				rzg2l_cru_read(cru, ICnMC) | ICnMC_CSCTHR);
 	else
--=20
2.43.0


