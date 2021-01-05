Return-Path: <SRS0=ha4R=GI=lists.cip-project.org=bounce+64572+6005+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A62BC43381
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8082073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8082073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6005+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id aBB0YY4521723xDx6tmu8KZx; Tue, 05 Jan 2021 05:58:07 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web11.5338.1609855082309757812
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:07 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="68085817"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:06 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8D69D4254F72;
	Tue,  5 Jan 2021 22:58:05 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 05/17] memory: renesas-rpc-if: Fix a node reference leak in rpcif_probe()
Date: Tue,  5 Jan 2021 13:57:45 +0000
Message-Id: <20210105135757.11069-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iQ9x4IEwGIijnMWjO9SskP0mx4520388AA=
Content-Type: multipart/mixed; boundary="MawHpQbPcvTaB6Mq1AMi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855087;
 bh=AOoV1vgWw5eCfOb1JJIyH+fBSO0vymXfu/eKzO5fZ8M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Dw8lqTxTxkhJZOHYGxoXPfQKaMVyCj8scTSbmeNGuF5UtDIid1cWKxMJMwISs0T1A/h
 HBmg+gwdpNsyuEhw5BswQvnDF43zDs/EKoTEoHa5B2RDLI4CMhoJq6DsO5Sj02AH0KWcQ
 PfJEPxS24k0BlQdbUVTyRABazYK1Gaex8vI=

--MawHpQbPcvTaB6Mq1AMi

commit 4e6b86b409f9fc63fedb39d6e3a0202c4b0244ce upstream.

Release the node reference by calling of_node_put(flash) in the probe.

Fixes: ca7d8b980b67f ("memory: add Renesas RPC-IF driver")
Reported-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Pavel Machek (CIP) <pavel@denx.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20201126191146.8753-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 0d2b0e1c1ba4..1e7b937b739a 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -563,9 +563,11 @@ static int rpcif_probe(struct platform_device *pdev)
 	} else if (of_device_is_compatible(flash, "cfi-flash")) {
 		name = "rpc-if-hyperflash";
 	} else	{
+		of_node_put(flash);
 		dev_warn(&pdev->dev, "unknown flash type\n");
 		return -ENODEV;
 	}
+	of_node_put(flash);
 
 	vdev = platform_device_alloc(name, pdev->id);
 	if (!vdev)
-- 
2.17.1


--MawHpQbPcvTaB6Mq1AMi
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6005): https://lists.cip-project.org/g/cip-dev/message=
/6005
Mute This Topic: https://lists.cip-project.org/mt/79450064/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MawHpQbPcvTaB6Mq1AMi--
