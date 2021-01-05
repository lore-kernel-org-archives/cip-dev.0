Return-Path: <SRS0=C7Yv=GI=lists.cip-project.org=bounce+64572+6003+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7563C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 636042073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 636042073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6003+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id rU98YY4521723xxQLzP4llXJ; Tue, 05 Jan 2021 05:58:04 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.5372.1609855081956264875
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:04 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67868551"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:03 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id ED4154255460;
	Tue,  5 Jan 2021 22:58:02 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 03/17] memory: renesas-rpc-if: Return correct value to the caller of rpcif_manual_xfer()
Date: Tue,  5 Jan 2021 13:57:43 +0000
Message-Id: <20210105135757.11069-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: y6SVMHz6IILF0LuOwljyjJLFx4520388AA=
Content-Type: multipart/mixed; boundary="N0j8zx3a0i4YhiR4htnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855084;
 bh=rgwkr//jLjUvG2hX4hfyOLI5PxVXvQkWD7X+H7CCNFY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=g6w1+ehCc6mC7cyf81wUAnWUYmBC4DOc9x4SuNP6brM66pabjugwP/hobEDF6DJtLdL
 hqXbOTNisJOVAZCMDKbsG7RZPC/BQhju6VUzM4uJSl0afmBsW3Y1fqszyPAdB23kGKXLn
 SatuaKge2TZsiKZ0VB+X7rq3UcFjBpi1Lgo=

--N0j8zx3a0i4YhiR4htnr

commit a0453f4ed066cae651b3119ed11f52d31dae1eca upstream.

In the error path of rpcif_manual_xfer() the value of ret is overwritten
by value returned by reset_control_reset() function and thus returning
incorrect value to the caller.

This patch makes sure the correct value is returned to the caller of
rpcif_manual_xfer() by dropping the overwrite of ret in error path.
Also now we ignore the value returned by reset_control_reset() in the
error path and instead print a error message when it fails.

Fixes: ca7d8b980b67f ("memory: add Renesas RPC-IF driver")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek (CIP) <pavel@denx.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20201126191146.8753-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 88f51ec8f1d1..d58b80d9e605 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -510,7 +510,8 @@ int rpcif_manual_xfer(struct rpcif *rpc)
 	return ret;
 
 err_out:
-	ret = reset_control_reset(rpc->rstc);
+	if (reset_control_reset(rpc->rstc))
+		dev_err(rpc->dev, "Failed to reset HW\n");
 	rpcif_hw_init(rpc, rpc->bus_size == 2);
 	goto exit;
 }
-- 
2.17.1


--N0j8zx3a0i4YhiR4htnr
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6003): https://lists.cip-project.org/g/cip-dev/message=
/6003
Mute This Topic: https://lists.cip-project.org/mt/79450061/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--N0j8zx3a0i4YhiR4htnr--
