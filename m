Return-Path: <SRS0=FOCO=IH=lists.cip-project.org=bounce+64572+6226+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4BBC433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B618E64F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B618E64F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6226+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8rKqYY4521723xhjikRI5vGR; Tue, 09 Mar 2021 08:37:13 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11726.1615307822860198874
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:13 -0800
X-IronPort-AV: E=Sophos;i="5.81,236,1610377200"; 
   d="scan'208";a="74591005"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:12 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8F82040A2DC7;
	Wed, 10 Mar 2021 01:37:11 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 10/40] media: rcar-vin: Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format
Date: Tue,  9 Mar 2021 16:36:26 +0000
Message-Id: <20210309163656.20944-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: t0WGrhFaaPedyWfyWdKPj9SWx4520388AA=
Content-Type: multipart/mixed; boundary="Jsddnv4U5tEZSw5z1hJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307833;
 bh=9kArxn3Nw+BvONVIyApdqDWlt+LkIL9dtRpG+VYEkhI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=RP5ZxMbidCkdDE0NScZVQLiBvpqZSBkfiUN007dPfZjGa81cwAt8I0g6m98Fzho3MmD
 6f7Q48UOGi92fLQWh0M23ZRjiz91TGfYxplsOLRUQZYIfca+oy+5e9TAqVYI1eIrRk9jo
 sxs6STXJ5oe+t7/GDA4l/bO2vnFXZ+hQaV8=

--Jsddnv4U5tEZSw5z1hJt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit e87c1a81f158d6fc7b3346eb88c2d76a044f837d upstream.

Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format in rcar-vin by setting
format type to RAW8 in VNMC register and appropriately setting the bpp
and bytesperline to enable V4L2_PIX_FMT_SRGGB8.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
[PL: manually applied the changes; rvin_parallel_subdevice_attach()
updated to handle MEDIA_BUS_FMT_SRGGB8_1X8 format; VNIS_REG is set
accordingly in rvin_crop_scale_comp() for V4L2_PIX_FMT_SRGGB8]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 1 +
 drivers/media/platform/rcar-vin/rcar-dma.c  | 9 +++++++++
 drivers/media/platform/rcar-vin/rcar-v4l2.c | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index bd298bbbc48d..79d1a8a730ad 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -447,6 +447,7 @@ static int rvin_parallel_subdevice_attach(struct rvin_dev *vin,
 		case MEDIA_BUS_FMT_UYVY8_2X8:
 		case MEDIA_BUS_FMT_UYVY10_2X10:
 		case MEDIA_BUS_FMT_RGB888_1X24:
+		case MEDIA_BUS_FMT_SRGGB8_1X8:
 			vin->mbus_code = code.code;
 			vin_dbg(vin, "Found media bus format for %s: %d\n",
 				subdev->name, vin->mbus_code);
diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index 5bab9f8159f6..0d56957a54cc 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -85,6 +85,7 @@
 #define VNMC_INF_YUV8_BT601	(1 << 16)
 #define VNMC_INF_YUV10_BT656	(2 << 16)
 #define VNMC_INF_YUV10_BT601	(3 << 16)
+#define VNMC_INF_RAW8		(4 << 16)
 #define VNMC_INF_YUV16		(5 << 16)
 #define VNMC_INF_RGB888		(6 << 16)
 #define VNMC_VUP		(1 << 10)
@@ -599,6 +600,8 @@ void rvin_crop_scale_comp(struct rvin_dev *vin)
 
 	if (vin->format.pixelformat == V4L2_PIX_FMT_NV16)
 		rvin_write(vin, ALIGN(vin->format.width, 0x20), VNIS_REG);
+	else if (vin->format.pixelformat == V4L2_PIX_FMT_SRGGB8)
+		rvin_write(vin, ALIGN(vin->format.width / 2, 0x10), VNIS_REG);
 	else
 		rvin_write(vin, ALIGN(vin->format.width, 0x10), VNIS_REG);
 }
@@ -677,6 +680,9 @@ static int rvin_setup(struct rvin_dev *vin)
 
 		input_is_yuv = true;
 		break;
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		vnmc |= VNMC_INF_RAW8;
+		break;
 	default:
 		break;
 	}
@@ -730,6 +736,9 @@ static int rvin_setup(struct rvin_dev *vin)
 		/* Note: not supported on M1 */
 		dmr = VNDMR_EXRGB;
 		break;
+	case V4L2_PIX_FMT_SRGGB8:
+		dmr = 0;
+		break;
 	default:
 		vin_err(vin, "Invalid pixelformat (0x%x)\n",
 			vin->format.pixelformat);
diff --git a/drivers/media/platform/rcar-vin/rcar-v4l2.c b/drivers/media/platform/rcar-vin/rcar-v4l2.c
index 1236e6e8228c..c07e57f707ec 100644
--- a/drivers/media/platform/rcar-vin/rcar-v4l2.c
+++ b/drivers/media/platform/rcar-vin/rcar-v4l2.c
@@ -54,6 +54,10 @@ static const struct rvin_video_format rvin_formats[] = {
 		.fourcc			= V4L2_PIX_FMT_XBGR32,
 		.bpp			= 4,
 	},
+	{
+		.fourcc			= V4L2_PIX_FMT_SRGGB8,
+		.bpp			= 1,
+	},
 };
 
 const struct rvin_video_format *rvin_format_from_pixel(u32 pixelformat)
-- 
2.17.1


--Jsddnv4U5tEZSw5z1hJt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6226): https://lists.cip-project.org/g/cip-dev/message=
/6226
Mute This Topic: https://lists.cip-project.org/mt/81205352/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Jsddnv4U5tEZSw5z1hJt--
