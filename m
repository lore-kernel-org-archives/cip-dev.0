Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8833CA0EED
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:13 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.57])
 by mx.groups.io with SMTP id smtpd.web10.934.1755705910364112648
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YXg3VP2Q;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.57, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1CN7LoK8sTez5845dfQ00rJ1v9KHYe4DLdALoHxst9mXFM51CApQn/GNnkDu7q1uqvp9XQadMdDAnKGIyx4Fnlj3ftM0DltJ3urIqijtNXXd+UzJvxFMSgaP/4q0JC5m4cifQ3PRQgANhN6DACVRP/45Sz2OLj2KQZZOKsqrjp+7IdArE/yOyIShnemJ2LpSOhgYnWwNR4QuIuAvDItw+/IoBJYeripcY5YOt11no8twicednyx/uB+pU6+WjOqWi9tZlgM5MsCuAtVVluRZIZXB52L7O+wA/MFBLUA1tOHlQfuYuQtJVxG85qIag0bydjNZAW32v3jW7MxZuC9Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqsmUZsl2dqNTbIzdNQjJjsziA1/ILjbHrCiEeY/KwU=;
 b=Rgq23+XBI1hc/9U4irVi/7NI0dAaUT3/p/+3gS1U4nzrStmQZ88Kbmfp3yZI3zJg6yQ1xz1UkAcdP+f49yS8gyOcVCId02RQoSNRUpkVGsFY196E6zuagV/5rjGF0E6KAHg9KhA4FE+IfC5SO3F3QuOktQiOPTjc1evvIOyNB41Axc9NWlqVEytnNajNtb0pmCXHTn8wDzZ6bmeXY8Se+VX36r7e0faz7nyPli4QhESQ274zqJWTW5fhWYRCzmb7HbCK0pMLwNvZBocFCsQ7IBWZlODb026ovTRiwBH+9xV42ANa2ig+uOB4tSf7Hh0FVSmpFMxV6MSEex4rz1VpMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqsmUZsl2dqNTbIzdNQjJjsziA1/ILjbHrCiEeY/KwU=;
 b=YXg3VP2QOgSUw+qk3ed6VmP3d27RFHcEVex2iWbviqy57aLpB4D6X1G/hqKB0d0FIcBo2Fb66Pwm/kNCKAqeMD7Bx+ZAIH48xm7FEgyGp9kDojDwh2C6m959b/lg/2yf28P9T+fM8UFUbmVz/ntS9N8UMb28pxFRytPpIsiwQY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:08 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:08 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 11/55] media: rzg2l-cru: Retrieve virtual channel information
Date: Wed, 20 Aug 2025 18:03:27 +0200
Message-ID: <20250820160413.801341-12-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: a4046e26-6430-404a-3edc-08dde00355c2
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Xyhvznmz/1n0g5EarcFecaOQMH9qIC7DfeBlOXRllOW6hh+a4zejyvGJhJfT?=
 =?us-ascii?Q?U4d2Ny4FYQh3y99A9YxpWN9gdbpQiv1MWeIEawz+pz8XnKYy6q0ML4fxo2tl?=
 =?us-ascii?Q?1LpH5M0rjbUauGO1sQvO8k0ExIDpB6csVm+7Z1ZvQg3RJaGdVgvtj089EOdJ?=
 =?us-ascii?Q?zXReBSb+fkyFBwbVJTvzJxwaEIEjqtttC1SKaByDRu6A1TCEn2pBH2d3BYOx?=
 =?us-ascii?Q?ElksCs2CpO+ORJRFsLP4mFFtRCMOM+M9afAUI3bGXwXmXiWFUyyn3Wq9/vpb?=
 =?us-ascii?Q?+qJC8or1PmTsZr38X7lUx511igVvrw1hRu720TNwO2db2t8VgANot4aE1mof?=
 =?us-ascii?Q?RSmIF311ABknaJbV7BCeCoZft2Zu9wtNiWnFrPHN4Pk2IGqEtHwu0rbdVsck?=
 =?us-ascii?Q?T9tzuzO+gzOepA2sg2D/o4dtNxa4BOLirqOmAy7X/lyafllsIccFGcz0CUNf?=
 =?us-ascii?Q?0ISkJTDxxRcpJHk7lh9gKnYxFmctB+soz8xn6+ThIWZ5O1K+QwXYk8bYMIYq?=
 =?us-ascii?Q?FMwnZJrigFKLEPBUwTVbiU06VijwUAigPIAxkac5hFJHWpq/pi0nJyGlzqut?=
 =?us-ascii?Q?WoIdu950A4jgxYco4uV+8A4IQQFgWs8XamrWATBrff4a4Gfa/SESWUR15O0o?=
 =?us-ascii?Q?5vBsTwHMpEkFM3SrW/R4kO/cN5AjR6e2518pzw6ssUqwN3hf54EfJFi6ggV2?=
 =?us-ascii?Q?2BqU8RsyjseYJdngnPhPKuO+JOi9Zl43OH1FAq+IIAOa0fumO83iFPV6hPhm?=
 =?us-ascii?Q?JRpFacKYjjHjy1z+YBMgKluCEZHrfd3DAAhUXQ+rs6obtYUuqNJSexERl1Ok?=
 =?us-ascii?Q?Ms+SvHHk4LNN9cWtdD27eVAPVsd6K/yAYVaTnL+/B/bHPNl4sk9RkYrFEOGr?=
 =?us-ascii?Q?/O0gW5evN8DTMv12vEXj84xgnloQs+VYHunBSHIG4nrOIiUP6UDONY5xlLqM?=
 =?us-ascii?Q?wiNs24rHouFCP7eDBv8qhv3JitRV9UBK6OJkmG15LjG3lLStxyAx44eDxRGo?=
 =?us-ascii?Q?BLacmHsiKFZ1u5ZAPi4lKVg4ZLxyhKdwqFOlx5SHL3Ml34RwIimy9c+dvOVm?=
 =?us-ascii?Q?EvhyagmJ0W/BQ1Xe3KSS9ixpQdxahz6M/JkxOKyS+1ufKhjCX4qtWUUPDqtk?=
 =?us-ascii?Q?QujP0xBnajhK1YOZT4dzHADroTdfWCUq2MM1tMRVAeL4xnM+aOc44K8NyA7P?=
 =?us-ascii?Q?kX7EAwWzd/7H7tgspnRe9S8mg5Zpr+BANzJ6ebMLHrrfSFLpZ4m1VfJvdxB9?=
 =?us-ascii?Q?bEdMGSf9JQG4WkrQyJo1hInpUUUQeJTM3qh9LmS5/o6s4ajcaBaX3G9cMxXl?=
 =?us-ascii?Q?iC8NKJshTvEWkbtaso6zjHE29zUC8yvo7SJXEDkq7QkBq/axS2KPkv4p5I8Y?=
 =?us-ascii?Q?HFxHIAYFt4YnMLfcYT/AUB5AV9531PatEu3byb4MwElBsvMyzHZ2tJw6kCsB?=
 =?us-ascii?Q?LTkXz1Eq8YhTI1QWqaFgyM+EmzKrGckyppWeIl+VDqZBAKU0iJkgZSNzH1Tw?=
 =?us-ascii?Q?XvCtSSjiaGfXN3E=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?PkGSVUbcLM0Ilo1Rs7jgSdVGhNBJ5O9HVG20hQ1sK7H55RQRHk5YZ4/POErw?=
 =?us-ascii?Q?xfTPipHHztfZte43gBZk34JqhcBQPDOkFsJz4oa6TGF6TYlgSUeVS9WLVif+?=
 =?us-ascii?Q?h3doTH1s8iPhnO8jssHIfr5jAgCOMEMlQA3oxg9OuM6w/Ek5VcILKQK7QZEz?=
 =?us-ascii?Q?/d6VQ4xYI5OuXG9ZHPLgcdkXD96Zw3UnssMA8SqEPHMGS3/LPmNu0xawXtsL?=
 =?us-ascii?Q?yOfB1Ov6b2gLlaLhRdL9QsCVKfL3CAKqAiOYxWfCqK2PMPfDZDXR0iQQwu6r?=
 =?us-ascii?Q?/l/Nemjki6XAJAmxWFGY8by04JlFWeIO7HsWdF+2yus0dE2lDgCZ0A5/BrXl?=
 =?us-ascii?Q?9R6Cs6hIjg9J1qvlfx4CtsdnSYpvxT9o0hYK2fMCWsHvPLH/zfmimJSPhRdp?=
 =?us-ascii?Q?DBChiBCxBGGDgk63cX3glSkXwtW2rTJwgoLeZ/GowU0Cc+Cu7aISA7Pwxgt/?=
 =?us-ascii?Q?ARUfGVfTmMQ9mgAHTx/XUlrLPCCnpUB0hKpn9UPMm3x0JubLbY9b/0DlwE75?=
 =?us-ascii?Q?Y4Us/lF5LxbaO4sDaxa7vaTvf/Q1xVxJrrju/b+K7w2aZW/B6faog7/gUlZ9?=
 =?us-ascii?Q?JWnY4CFMW3O7vJbVnk4YWYLXQXA+4CyV4cNR14dKav6ohpngYI9KHY6Sysxb?=
 =?us-ascii?Q?98XciN8CVHbJtq8hSsgGBjH0TMdurH3cHFqBAKtiLKfodn7lbQfrq3VyAtpQ?=
 =?us-ascii?Q?GvnXgBi2krkxqhZN0inJuYycsgDmSxi1N5Wdxew5UO2t18w5t7+fCRJLzSnB?=
 =?us-ascii?Q?Us9epW2RwM/CVwdCblfNrdRHkDxVE5XOYkU/jNXSTujWWMXx2/XxJhoxTK3y?=
 =?us-ascii?Q?x8/oBV1ZDrmWrE2IiPfPb2x3JHlXYvP21N1fQNwaZWCBstXaXoFDrPDw9Oqk?=
 =?us-ascii?Q?olFzWzh2pckEovWZ8OtIbNWPwYdPWHxJ1w2zQMpsnhQp1b+AlLWGlKFoNT7P?=
 =?us-ascii?Q?p/YwPO+CEuwKHHJJ1y4HkyAr5ySRRQWhAJBVgiA3r173Hu9JvRowQS9t+W6o?=
 =?us-ascii?Q?yORb2zvdiH29bg6vwiUJaZEaT8LJ/gPne6ImJuCy1LJCLBr+oMmwEWhbtwRv?=
 =?us-ascii?Q?V05G13fSMIPP0M/Gj76eTQ2c+WSGy3MFI4gVx6xcBHxk7lJoeATUE+LHi68c?=
 =?us-ascii?Q?fX0dMNFniceJj9zVJfeBo0cARLy3GCewpYeagiMbNt9GF2u1vWw3ihmqJ+iM?=
 =?us-ascii?Q?0UqI/Z6OQQqkwp1Bs/O8+YRI/GTaO0YJ+9qug0D1VIMFNzMCwZCTCjwZux30?=
 =?us-ascii?Q?HXSo6p0hHpRNky+tfymN4zcuQg1niGZukPM+/jmLPJqLzsmLh7VLlaGeI3tt?=
 =?us-ascii?Q?yCp1vVMZTZK91A0hIzrYWOEGPWSSoBpYXVdc0x+Kfwk/Oh0eVicsW3R4zmwS?=
 =?us-ascii?Q?B4fRnCGstZQ2JbrJs+x583zaSG694BQPOkgiXl7JljDdvXH2G8qsAy0iT1Hn?=
 =?us-ascii?Q?2pO0AbpZizCR2OevjygEJ2Tu4Q/quXNAA20S6e5QsWtsTmKOzaWuUWsJ3EPg?=
 =?us-ascii?Q?fncWQuNrrid8vw18Mzp4CQCpSwMgl6FCNmM7v76LKeElAdnVhYKqOxJf+Tv+?=
 =?us-ascii?Q?aRu1z2yLD3NSEIFWNUgnCiS3AHZMD6pUN5fJ0ByqXAQ+p1YUKAMmabYd/4Sl?=
 =?us-ascii?Q?UnRqZq03M8Z7WCT08qZrc5Q=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4046e26-6430-404a-3edc-08dde00355c2
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:08.5560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q/MEqAoxYQREU5codl1RIJvipvEh3fLK6Yu3TvDCRRsNKa0uPplW+UXYU7Wlg7K3tWZjephAxhDA02WJO8NHkIOmtHVz53BIvb7pAuqHI1oRl/o04/WQBdpEOevCrMoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19836

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit d7d72dae81d5d77c4167d793aacb73c77a13172a upstream.

The RZ/G2L CRU needs to configure the ICnMC.VCSEL bits to specify which
virtual channel should be processed from the four available VCs. To
retrieve this information from the connected subdevice, the
.get_frame_desc() function is called.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-7-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  5 +++
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  5 ---
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 34 +++++++++++++++++++
 3 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 93c0850bd9b1..786b6a61c44f 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -31,6 +31,11 @@
 #define RZG2L_CRU_MIN_INPUT_HEIGHT	240
 #define RZG2L_CRU_MAX_INPUT_HEIGHT	4095
=20
+enum rzg2l_csi2_pads {
+	RZG2L_CRU_IP_SINK =3D 0,
+	RZG2L_CRU_IP_SOURCE,
+};
+
 /**
  * enum rzg2l_cru_dma_state - DMA states
  * @RZG2L_CRU_DMA_STOPPED:   No operation in progress
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index c37c671ce2d5..0edf005418e5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -18,11 +18,6 @@ static const struct rzg2l_cru_ip_format rzg2l_cru_ip_for=
mats[] =3D {
 	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16,	.datatype =3D 0x1e, .bpp =3D 16 },
 };
=20
-enum rzg2l_csi2_pads {
-	RZG2L_CRU_IP_SINK =3D 0,
-	RZG2L_CRU_IP_SOURCE,
-};
-
 static const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned=
 int code)
 {
 	unsigned int i;
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 704278eb2f3c..fb29c1fc95c8 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -433,12 +433,46 @@ void rzg2l_cru_stop_image_processing(struct rzg2l_cru=
_dev *cru)
 	spin_unlock_irqrestore(&cru->qlock, flags);
 }
=20
+static int rzg2l_cru_get_virtual_channel(struct rzg2l_cru_dev *cru)
+{
+	struct v4l2_mbus_frame_desc fd =3D { };
+	struct media_pad *remote_pad;
+	int ret;
+
+	remote_pad =3D media_pad_remote_pad_unique(&cru->ip.pads[RZG2L_CRU_IP_SIN=
K]);
+	ret =3D v4l2_subdev_call(cru->ip.remote, pad, get_frame_desc, remote_pad-=
>index, &fd);
+	if (ret < 0 && ret !=3D -ENOIOCTLCMD) {
+		dev_err(cru->dev, "get_frame_desc failed on IP remote subdev\n");
+		return ret;
+	}
+	/* If remote subdev does not implement .get_frame_desc default to VC0. */
+	if (ret =3D=3D -ENOIOCTLCMD)
+		return 0;
+
+	if (fd.type !=3D V4L2_MBUS_FRAME_DESC_TYPE_CSI2) {
+		dev_err(cru->dev, "get_frame_desc returned invalid bus type %d\n", fd.ty=
pe);
+		return -EINVAL;
+	}
+
+	if (!fd.num_entries) {
+		dev_err(cru->dev, "get_frame_desc returned zero entries\n");
+		return -EINVAL;
+	}
+
+	return fd.entry[0].bus.csi2.vc;
+}
+
 int rzg2l_cru_start_image_processing(struct rzg2l_cru_dev *cru)
 {
 	struct v4l2_mbus_framefmt *fmt =3D rzg2l_cru_ip_get_src_fmt(cru);
 	unsigned long flags;
 	int ret;
=20
+	ret =3D rzg2l_cru_get_virtual_channel(cru);
+	if (ret < 0)
+		return ret;
+	cru->csi.channel =3D ret;
+
 	spin_lock_irqsave(&cru->qlock, flags);
=20
 	/* Select a video input */
--=20
2.43.0


