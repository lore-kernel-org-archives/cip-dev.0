Return-Path: <SRS0=u47z=IH=lists.cip-project.org=bounce+64572+6225+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5207C433E9
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88634651BB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88634651BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6225+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ICmDYY4521723xybzZSTsAbY; Tue, 09 Mar 2021 08:37:12 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:11 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342229"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:11 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 41FE840A2DC7;
	Wed, 10 Mar 2021 01:37:10 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 09/40] media: rcar-vin: Invalidate pipeline if conversion is not possible on input formats
Date: Tue,  9 Mar 2021 16:36:25 +0000
Message-Id: <20210309163656.20944-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: EobNw2kq3f3sEFAQ8HkqRVFrx4520388AA=
Content-Type: multipart/mixed; boundary="WwTM3U75tVJpslaqitkK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307832;
 bh=boJlbpMDVAlcZ/cQfEW5/6h0uW6GW3TZkSUXqYqe6ro=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Jsi/2iUus84m/C7KcQZs7xLwTQBm4CsdVZHFS2vZZ7eaQfMfP8dSvZPozTlxnP4W4FI
 gec400eXqWAsDtA9VRfZC6NWdvbgcgMcLHMkCvn14QruLf0jxtjUWRUfxTSjENSjxjh12
 rS7/xa8N0mwyKX8URGNf+QKWX9M0DI31+Ec=

--WwTM3U75tVJpslaqitkK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit fd22e8eb4145852223b36b0e6c7e308ed5905ad2 upstream.

Up until now the VIN was capable to convert any of its supported input mbus
formats to any of it's supported output pixel formats. With the addition of
RAW formats this is no longer true.

This patch invalidates the pipeline by adding a check if given vin input
format can be converted to supported output pixel format.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
[PL: dropped changes from rvin_enum_fmt_vid_cap()]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index e51620c6cc40..5bab9f8159f6 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -1042,11 +1042,15 @@ static int rvin_mc_validate_format(struct rvin_dev *vin, struct v4l2_subdev *sd,
 	case MEDIA_BUS_FMT_UYVY8_2X8:
 	case MEDIA_BUS_FMT_UYVY10_2X10:
 	case MEDIA_BUS_FMT_RGB888_1X24:
-		vin->mbus_code = fmt.format.code;
+		break;
+	case MEDIA_BUS_FMT_SRGGB8_1X8:
+		if (vin->format.pixelformat != V4L2_PIX_FMT_SRGGB8)
+			return -EPIPE;
 		break;
 	default:
 		return -EPIPE;
 	}
+	vin->mbus_code = fmt.format.code;
 
 	switch (fmt.format.field) {
 	case V4L2_FIELD_TOP:
-- 
2.17.1


--WwTM3U75tVJpslaqitkK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6225): https://lists.cip-project.org/g/cip-dev/message=
/6225
Mute This Topic: https://lists.cip-project.org/mt/81205351/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WwTM3U75tVJpslaqitkK--
