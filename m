Return-Path: <SRS0=GsHN=GI=lists.cip-project.org=bounce+64572+6010+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40ABC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8121E2073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8121E2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6010+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cOOeYY4521723xWd0zx0KJLq; Tue, 05 Jan 2021 05:58:14 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.5380.1609855093624078507
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:13 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67868560"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:13 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 173464254F72;
	Tue,  5 Jan 2021 22:58:11 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 10/17] spi: spi-mem: fix reference leak in spi_mem_access_start
Date: Tue,  5 Jan 2021 13:57:50 +0000
Message-Id: <20210105135757.11069-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: eoxnHt6Bm4hCYB5xppAUFe0Dx4520388AA=
Content-Type: multipart/mixed; boundary="z5iHkyGjbY3Buh808R6P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855094;
 bh=cLwFCChv/79+iQ/1k7mEylPAK5MiHrz/d+eOI4kHkzw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mzkbiDgCliez7VsS5Y+sr+AWh8532Y884tKfGcTu5uAxRtgY6iowab7KXbZw+Ro00iG
 WBU1gngbvybkJOoLPA7n3mfObLkCkqGjmRf68agorCvnkDXWy6TtpyKHVxGo8wTKzqWh/
 3gDZh01BazZBFaBUPKzTtLjZQAp4zX2Wq4o=

--z5iHkyGjbY3Buh808R6P

From: Zhang Qilong <zhangqilong3@huawei.com>

commit c02bb16b0e826bf0e19aa42c3ae60ea339f32cf5 upstream.

pm_runtime_get_sync will increment pm usage counter even it
failed. Forgetting to pm_runtime_put_noidle will result in
reference leak in spi_mem_access_start, so we should fix it.

Fixes: f86c24f479530 ("spi: spi-mem: Split spi_mem_exec_op() code")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Link: https://lore.kernel.org/r/20201103140910.3482-1-zhangqilong3@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 0908f979f6a8..2607981d973d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -228,6 +228,7 @@ static int spi_mem_access_start(struct spi_mem *mem)
 
 		ret = pm_runtime_get_sync(ctlr->dev.parent);
 		if (ret < 0) {
+			pm_runtime_put_noidle(ctlr->dev.parent);
 			dev_err(&ctlr->dev, "Failed to power device: %d\n",
 				ret);
 			return ret;
-- 
2.17.1


--z5iHkyGjbY3Buh808R6P
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6010): https://lists.cip-project.org/g/cip-dev/message=
/6010
Mute This Topic: https://lists.cip-project.org/mt/79450072/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--z5iHkyGjbY3Buh808R6P--
