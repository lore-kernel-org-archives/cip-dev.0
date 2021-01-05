Return-Path: <SRS0=/j7w=GI=lists.cip-project.org=bounce+64572+6004+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24114C433E6
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:07 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE5F2073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE5F2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6004+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GvCOYY4521723x01poqqY54q; Tue, 05 Jan 2021 05:58:06 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5338.1609855082309757812
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:05 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68085814"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:05 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 434894254F73;
	Tue,  5 Jan 2021 22:58:04 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 04/17] memory: renesas-rpc-if: Fix unbalanced pm_runtime_enable in rpcif_{enable,disable}_rpm
Date: Tue,  5 Jan 2021 13:57:44 +0000
Message-Id: <20210105135757.11069-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: XDc8v6o1jo8MhSx3JLck5PFex4520388AA=
Content-Type: multipart/mixed; boundary="Xl5m3MIJgxxFYN0dAU9g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855086;
 bh=feXbEXjXa6ZJzkeD5LZ8K/XVJ0teA68IlKdhGK2So7Q=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Sph7sgzWqTbxO8SWN33E1sVgLm/e1iLQ2l+Je627AVZrKpsu05UrTLEkWlfF3ZPwLrI
 LL5EohyE+SZm3aGP1pseMKVCJ1P4Wug8Ub6qg27uRzdbhOzE4N212b+0IHCFkvbrxzUgy
 /TuSoWfa49rXDUeruRkch9Pbn2vDyAVtdyM=

--Xl5m3MIJgxxFYN0dAU9g

commit 61a6d854b9555b420fbfae62ef26baa8b9493b32 upstream.

rpcif_enable_rpm calls pm_runtime_enable, so rpcif_disable_rpm needs to
call pm_runtime_disable and not pm_runtime_put_sync.

Fixes: ca7d8b980b67f ("memory: add Renesas RPC-IF driver")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20201126191146.8753-3-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index d58b80d9e605..0d2b0e1c1ba4 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -214,7 +214,7 @@ EXPORT_SYMBOL(rpcif_enable_rpm);
 
 void rpcif_disable_rpm(struct rpcif *rpc)
 {
-	pm_runtime_put_sync(rpc->dev);
+	pm_runtime_disable(rpc->dev);
 }
 EXPORT_SYMBOL(rpcif_disable_rpm);
 
-- 
2.17.1


--Xl5m3MIJgxxFYN0dAU9g
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6004): https://lists.cip-project.org/g/cip-dev/message=
/6004
Mute This Topic: https://lists.cip-project.org/mt/79450062/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Xl5m3MIJgxxFYN0dAU9g--
