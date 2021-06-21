Return-Path: <SRS0=u3n9=LP=lists.cip-project.org=bounce+64572+6562+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726C5C49EA4
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4209E60FF2
	for <cip-dev@archiver.kernel.org>; Mon, 21 Jun 2021 17:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4209E60FF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6562+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id RwU1YY4521723xBP8ylKeflZ; Mon, 21 Jun 2021 10:09:54 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.50319.1624295393354335105
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Jun 2021 10:09:53 -0700
X-IronPort-AV: E=Sophos;i="5.83,289,1616425200"; 
   d="scan'208";a="85077305"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jun 2021 02:09:43 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F33994003EA5;
	Tue, 22 Jun 2021 02:09:42 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 5.10.y-cip 12/16] spi: spi-mem: Fix passing zero to 'PTR_ERR' warning
Date: Mon, 21 Jun 2021 18:09:21 +0100
Message-Id: <20210621170925.11328-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210621170925.11328-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5641P8KoWHRwLIOf7sNqJLb4x4520388AA=
Content-Type: multipart/mixed; boundary="Y9jpZM4BqVqdtTdgFYst"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624295394;
 bh=M3suTp0lE6FSBBy9OGqk80eQCvDfNHhNW1MiypOgCf8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=km2OeiEK5+doIWit1PS8lCCa7Ko1m64tg34ZAQRfMZTSwrFSLCURc1TJR7KqrjVgqws
 wQbQA+XIKK2tSLtygQF3h3hBWh1WFSQ+Nmg8YoT+QXabfeMSTnmixyZYC/L6hEJtaAALk
 QZVQ+2fqPuvC8O2NErx6A5ow4J2Vi36ttwg=

--Y9jpZM4BqVqdtTdgFYst

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
index 4682f49dc733..f3a3f196e628 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -744,7 +744,7 @@ static int spi_mem_probe(struct spi_device *spi)
 		mem->name = dev_name(&spi->dev);
 
 	if (IS_ERR_OR_NULL(mem->name))
-		return PTR_ERR(mem->name);
+		return PTR_ERR_OR_ZERO(mem->name);
 
 	spi_set_drvdata(spi, mem);
 
-- 
2.17.1


--Y9jpZM4BqVqdtTdgFYst
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6562): https://lists.cip-project.org/g/cip-dev/message=
/6562
Mute This Topic: https://lists.cip-project.org/mt/83693894/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Y9jpZM4BqVqdtTdgFYst--
