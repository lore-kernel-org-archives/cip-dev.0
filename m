Return-Path: <SRS0=wJ+m=IH=lists.cip-project.org=bounce+64572+6234+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EE7C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F7A64F35
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F7A64F35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6234+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PnxEYY4521723x6X5jCBpO5I; Tue, 09 Mar 2021 08:37:24 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:23 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342242"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:23 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4A9C340A2DC7;
	Wed, 10 Mar 2021 01:37:22 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 18/40] media: i2c: imx219: Fix a bug in imx219_enum_frame_size
Date: Tue,  9 Mar 2021 16:36:34 +0000
Message-Id: <20210309163656.20944-19-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: TX8AEmpAs3uj6TEcDj49mptox4520388AA=
Content-Type: multipart/mixed; boundary="796GfbVeWnKjcJJBnRYm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307844;
 bh=nqxVKsNz2EKUz86yQLMWUL/t7tSvya10Op/2Dz6ZoTM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PbZJuTNw3JSczhkxe+EeJJIRK6oH6cI9Wx4rdc47ejKyX5tyy3Qcq27tTH8QjM7GuNE
 CIToQq07jjKCpjUiLpT/e07LmrBG/5+S96k70Wn135da/sF4btWQIZ7MMYGnJCEZgXeRB
 vFTltSaGlJQ8NjhEgHB0lxJQbzma0cPs2vg=

--796GfbVeWnKjcJJBnRYm

From: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

commit b2bbf1aac61186ef904fd28079e847d3feadb89e upstream.

When enumerating the frame sizes, the value sent to
imx219_get_format_code should be fse->code
(the code from the ioctl) and not imx219->fmt.code
which is the code set currently in the driver.

Fixes: 22da1d56e982 ("media: i2c: imx219: Add support for RAW8 bit bayer format")
Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Reviewed-by: Helen Koike <helen.koike@collabora.com>
Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/i2c/imx219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/imx219.c b/drivers/media/i2c/imx219.c
index c50530d2a728..c92d935a87ce 100644
--- a/drivers/media/i2c/imx219.c
+++ b/drivers/media/i2c/imx219.c
@@ -825,7 +825,7 @@ static int imx219_enum_frame_size(struct v4l2_subdev *sd,
 	if (fse->index >= ARRAY_SIZE(supported_modes))
 		return -EINVAL;
 
-	if (fse->code != imx219_get_format_code(imx219, imx219->fmt.code))
+	if (fse->code != imx219_get_format_code(imx219, fse->code))
 		return -EINVAL;
 
 	fse->min_width = supported_modes[fse->index].width;
-- 
2.17.1


--796GfbVeWnKjcJJBnRYm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6234): https://lists.cip-project.org/g/cip-dev/message=
/6234
Mute This Topic: https://lists.cip-project.org/mt/81205365/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--796GfbVeWnKjcJJBnRYm--
