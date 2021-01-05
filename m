Return-Path: <SRS0=uxZw=GI=lists.cip-project.org=bounce+64572+6011+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25146C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:16 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BECE62073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BECE62073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6011+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id TCwlYY4521723xzY13t3YbSO; Tue, 05 Jan 2021 05:58:15 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5338.1609855082309757812
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:14 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68085833"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:14 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 5F62F4254F73;
	Tue,  5 Jan 2021 22:58:13 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 11/17] spi: spi-mem: Fix passing zero to 'PTR_ERR' warning
Date: Tue,  5 Jan 2021 13:57:51 +0000
Message-Id: <20210105135757.11069-12-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8oWePJAR6P5pjQ5RLWnxbfB4x4520388AA=
Content-Type: multipart/mixed; boundary="wqEmFvzex2f9aUWDtBIj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855095;
 bh=dDivwK6fM5qiM7boJEBHFdwdIVEt/i5ZaZ64i1MDrf8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Bw62WEIGk3xrgcIjwYxCPGR+zjUyakYVccgUU2P++knVLoTRIjsqlkZbhw3vF1cnkHq
 KDgva+N0vSn04EeCXX8MJEtQd+I/lPV6sIs9Oq1g0ZV7EC7d67qVLoXhyiJoUFeMpsw+Z
 4ocPdUyWHN4O5MAwHKlp5s6D0SVpr8UVBFg=

--wqEmFvzex2f9aUWDtBIj

From: YueHaibing <yuehaibing@huawei.com>

commit a9c52d42814a44472fe1205775320ec20f556908 upstream.

Fix smatch warning:

drivers/spi/spi-mem.c:746 spi_mem_probe() warn: passing zero to 'PTR_ERR'

Fixes: 5d27a9c8ea9e ("spi: spi-mem: Extend the SPI mem interface to set a custom memory name")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Link: https://lore.kernel.org/r/20201031033042.42892-1-yuehaibing@huawei.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 2607981d973d..59f7aa117a10 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -456,7 +456,7 @@ static int spi_mem_probe(struct spi_device *spi)
 		mem->name = dev_name(&spi->dev);
 
 	if (IS_ERR_OR_NULL(mem->name))
-		return PTR_ERR(mem->name);
+		return PTR_ERR_OR_ZERO(mem->name);
 
 	spi_set_drvdata(spi, mem);
 
-- 
2.17.1


--wqEmFvzex2f9aUWDtBIj
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6011): https://lists.cip-project.org/g/cip-dev/message=
/6011
Mute This Topic: https://lists.cip-project.org/mt/79450073/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--wqEmFvzex2f9aUWDtBIj--
