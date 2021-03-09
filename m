Return-Path: <SRS0=ui+I=IH=lists.cip-project.org=bounce+64572+6227+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991D3C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BB4D64F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BB4D64F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6227+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ExMeYY4521723xVKX7puJOR3; Tue, 09 Mar 2021 08:37:16 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:14 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342232"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:13 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id DF5CB40A2DC7;
	Wed, 10 Mar 2021 01:37:12 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 11/40] media: rcar-csi2: Add support for MEDIA_BUS_FMT_SRGGB8_1X8 format
Date: Tue,  9 Mar 2021 16:36:27 +0000
Message-Id: <20210309163656.20944-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: HJPpbv9y28YyML85ZFX2aAabx4520388AA=
Content-Type: multipart/mixed; boundary="WaOmBkoXdJY5dn0xRsK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307836;
 bh=EnDWXVLRJ/f2UoKrw/9lJ3+y3PF1R3xtcMrNULYJx8c=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=g4L8xve0Uklz3LYny/UMxHm6VG4VPdkwEiR8RX0znxNWRlyExNhRRNmYqUOBbMuH/16
 3reglMvGK6ziLWxOpaOsgFQU/VX54yJ0Uzi2Upb7q07MZejOUVXZegC8M2m+cc3KVhGa9
 e6cXwpl9MRVeDPTZuS9Kg9LgE6T8usWtrlo=

--WaOmBkoXdJY5dn0xRsK0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 675616554d0a5caff138008ee9bd4623bc4390b2 upstream.

This patch adds support for MEDIA_BUS_FMT_SRGGB8_1X8 format for CSI2
input.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-csi2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/platform/rcar-vin/rcar-csi2.c b/drivers/media/platform/rcar-vin/rcar-csi2.c
index 1c910fdbf4c0..e6a531c4fde5 100644
--- a/drivers/media/platform/rcar-vin/rcar-csi2.c
+++ b/drivers/media/platform/rcar-vin/rcar-csi2.c
@@ -315,6 +315,7 @@ static const struct rcar_csi2_format rcar_csi2_formats[] = {
 	{ .code = MEDIA_BUS_FMT_YUYV8_1X16,	.datatype = 0x1e, .bpp = 16 },
 	{ .code = MEDIA_BUS_FMT_UYVY8_2X8,	.datatype = 0x1e, .bpp = 16 },
 	{ .code = MEDIA_BUS_FMT_YUYV10_2X10,	.datatype = 0x1e, .bpp = 20 },
+	{ .code = MEDIA_BUS_FMT_SRGGB8_1X8,     .datatype = 0x2a, .bpp = 8 },
 };
 
 static const struct rcar_csi2_format *rcsi2_code_to_fmt(unsigned int code)
-- 
2.17.1


--WaOmBkoXdJY5dn0xRsK0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6227): https://lists.cip-project.org/g/cip-dev/message=
/6227
Mute This Topic: https://lists.cip-project.org/mt/81205354/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WaOmBkoXdJY5dn0xRsK0--
