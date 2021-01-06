Return-Path: <SRS0=1HhK=GJ=lists.cip-project.org=bounce+64572+6044+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4A2C433DB
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 13:22:30 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 006282311A
	for <cip-dev@archiver.kernel.org>; Wed,  6 Jan 2021 13:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 006282311A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6044+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rvPJYY4521723xzDviIdWb32; Wed, 06 Jan 2021 05:22:29 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.7806.1609939347990077820
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Jan 2021 05:22:28 -0800
X-IronPort-AV: E=Sophos;i="5.78,480,1599490800"; 
   d="scan'208";a="67965564"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 06 Jan 2021 22:22:23 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6FCA34257198;
	Wed,  6 Jan 2021 22:22:22 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip] spi: spi-mem: Make spi_mem_default_supports_op() static inline
Date: Wed,  6 Jan 2021 13:22:21 +0000
Message-Id: <20210106132221.17458-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FjP0ay6eYWpTwEDDA8tfDBu6x4520388AA=
Content-Type: multipart/mixed; boundary="ZOhXMuk22Nlz2hvkmRp5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609939349;
 bh=i1sqMaWCtjp2wKwGpLFgt3lXnG/+FlKA1x5gnXDHFP0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=AvMHbqO8cK+izQebOpLKRsbbJZv/aVOKC5vEPyQdddo774u6jHFzJbi1xO+xpxg3C4c
 5+JMKLe7mPBNOOKea1Eo4qybfUVv+UydXIU7AlfxG51px5IhKTwu6y/6KOhkEFYCvB4+g
 sRW5jpPORwp0qAhoHE6NJ/t2SuiQ0xHWfok=

--ZOhXMuk22Nlz2hvkmRp5

From: YueHaibing <yuehaibing@huawei.com>

commit b5881b153bc81d63a5a7e82a35e8a4bdbe1f8c73 upstream.

Stub helper spi_mem_default_supports_op() should
be set to static inline

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi Pavel,

This is a incremental patch on top of series [1], as you pointed out in
patch [2] the function should be static, this patch fixes this issue
and is backported from upstream kernel.

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=409359
[2] https://patchwork.kernel.org/project/cip-dev/patch/20210105135757
    .11069-9-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
---
 include/linux/spi/spi-mem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 762b3974cf9c..46497e742e7f 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -315,6 +315,7 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
 {
 }
 
+static inline
 bool spi_mem_default_supports_op(struct spi_mem *mem,
 				 const struct spi_mem_op *op)
 {
-- 
2.17.1


--ZOhXMuk22Nlz2hvkmRp5
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6044): https://lists.cip-project.org/g/cip-dev/message=
/6044
Mute This Topic: https://lists.cip-project.org/mt/79474032/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZOhXMuk22Nlz2hvkmRp5--
