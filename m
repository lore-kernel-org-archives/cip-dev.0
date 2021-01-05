Return-Path: <SRS0=b9j1=GI=lists.cip-project.org=bounce+64572+6017+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD194C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:23 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1672073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1672073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6017+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hrRPYY4521723xBFbb3qJkla; Tue, 05 Jan 2021 05:58:23 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5338.1609855082309757812
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:22 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68085845"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:22 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 39CD54254F72;
	Tue,  5 Jan 2021 22:58:21 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 17/17] spi: rpc-if: Fix use-after-free on unbind
Date: Tue,  5 Jan 2021 13:57:57 +0000
Message-Id: <20210105135757.11069-18-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: NJ9H2i0AvsqN33orTZDW0RKkx4520388AA=
Content-Type: multipart/mixed; boundary="g6WzdIpxaQqZ1ZEkssc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855103;
 bh=NESS4xu6RwjQ7Xqx4B7Mq3Xvmixido0KgF8bdbSStnw=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=qZEDHpzl17SdNbVk4taeJwKNeJu1BppTtoMDQCg3H4YRvVADdXIWeaiTBDrawNyrhgk
 Bpwkqn1COeeKzVQpArfzqkjZ0DdZ5rf/+qLo5dE9xUc7MhhxURa74Nu/hwjp1ni3dElE5
 fo9DdxBQp3slIX9BUB8E/gUqg1bhqMF805A=

--g6WzdIpxaQqZ1ZEkssc7

From: Lukas Wunner <lukas@wunner.de>

commit 393f981ca5f797b58b882d42b7621fb6e43c7f5b upstream.

rpcif_spi_remove() accesses the driver's private data after calling
spi_unregister_controller() even though that function releases the last
reference on the spi_controller and thereby frees the private data.

Fix by switching over to the new devm_spi_alloc_master() helper which
keeps the private data accessible until the driver has unbound.

Fixes: eb8d6d464a27 ("spi: add Renesas RPC-IF driver")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: <stable@vger.kernel.org> # v5.9+: 5e844cc37a5c: spi: Introduce device-managed SPI controller allocation
Cc: <stable@vger.kernel.org> # v5.9+
Cc: Sergei Shtylyov <s.shtylyov@omprussia.ru>
Link: https://lore.kernel.org/r/c5da472c28021da2f6517441685cef033d40b140.1607286887.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rpc-if.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rpc-if.c b/drivers/spi/spi-rpc-if.c
index ed3e548227f4..3579675485a5 100644
--- a/drivers/spi/spi-rpc-if.c
+++ b/drivers/spi/spi-rpc-if.c
@@ -134,7 +134,7 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	struct rpcif *rpc;
 	int error;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*rpc));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -159,13 +159,8 @@ static int rpcif_spi_probe(struct platform_device *pdev)
 	error = spi_register_controller(ctlr);
 	if (error) {
 		dev_err(&pdev->dev, "spi_register_controller failed\n");
-		goto err_put_ctlr;
+		rpcif_disable_rpm(rpc);
 	}
-	return 0;
-
-err_put_ctlr:
-	rpcif_disable_rpm(rpc);
-	spi_controller_put(ctlr);
 
 	return error;
 }
-- 
2.17.1


--g6WzdIpxaQqZ1ZEkssc7
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6017): https://lists.cip-project.org/g/cip-dev/message=
/6017
Mute This Topic: https://lists.cip-project.org/mt/79450084/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--g6WzdIpxaQqZ1ZEkssc7--
