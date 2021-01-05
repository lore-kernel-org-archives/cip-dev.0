Return-Path: <SRS0=o9il=GI=lists.cip-project.org=bounce+64572+6014+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA678C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:19 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55DEC2073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55DEC2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6014+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BEsHYY4521723xTW5QSQrHI1; Tue, 05 Jan 2021 05:58:19 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5338.1609855082309757812
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:18 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68085839"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:18 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4EC6E4254F73;
	Tue,  5 Jan 2021 22:58:17 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 14/17] spi: spi-mem: Fix spi_mem_dirmap_destroy() kerneldoc
Date: Tue,  5 Jan 2021 13:57:54 +0000
Message-Id: <20210105135757.11069-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: bH7p5YJ0zNSeO8vk3kuHADKnx4520388AA=
Content-Type: multipart/mixed; boundary="6kuEg0sZi9ODGPIMKYnb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855099;
 bh=0TtUNQivXsbvDlK/BacWojydaLtzJUsyunR+YaKz+8I=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=luPSR+4ybOdZDqvwWy24Ao7veDSwKgUTo4F9vWBCyWBZ5h1q5DogFbo1qpen/In1nFe
 YlzI4LhBjkO4vdbgchZzlEx+D+ujBuN+h9xRzXAuMO+EVG7sASXSzVLo5kxX0FnJUcpZ6
 CtlNA4ZXSbRxs1Q0Fgg3GwsTH3dVcWYuw/k=

--6kuEg0sZi9ODGPIMKYnb

From: Boris Brezillon <bbrezillon@kernel.org>

commit 5c0c4ec9ba61a98ecb79036afc013bba8d5b85e3 upstream.

spi_mem_dirmap_destroy() takes a single argument, remove the @info entry
in the doc.

Fixes: aa167f3fed0c ("spi: spi-mem: Add a new API to support direct mapping")
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 3d7a4183d475..0998ebc2689d 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -532,7 +532,6 @@ EXPORT_SYMBOL_GPL(spi_mem_dirmap_create);
 /**
  * spi_mem_dirmap_destroy() - Destroy a direct mapping descriptor
  * @desc: the direct mapping descriptor to destroy
- * @info: direct mapping information
  *
  * This function destroys a direct mapping descriptor previously created by
  * spi_mem_dirmap_create().
-- 
2.17.1


--6kuEg0sZi9ODGPIMKYnb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6014): https://lists.cip-project.org/g/cip-dev/message=
/6014
Mute This Topic: https://lists.cip-project.org/mt/79450078/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6kuEg0sZi9ODGPIMKYnb--
