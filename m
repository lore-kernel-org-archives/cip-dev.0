Return-Path: <SRS0=fUt6=GI=lists.cip-project.org=bounce+64572+6015+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9983C433DB
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F17E2073C
	for <cip-dev@archiver.kernel.org>; Tue,  5 Jan 2021 13:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F17E2073C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6015+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id y8OlYY4521723xstjqj5hNoL; Tue, 05 Jan 2021 05:58:20 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web12.5380.1609855093624078507
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jan 2021 05:58:20 -0800
X-IronPort-AV: E=Sophos;i="5.78,477,1599490800"; 
   d="scan'208";a="67868569"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 05 Jan 2021 22:58:19 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 999B64254F72;
	Tue,  5 Jan 2021 22:58:18 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH v3 4.19.y-cip 15/17] spi: spi-mem: Fix a memory leak in spi_mem_dirmap_destroy()
Date: Tue,  5 Jan 2021 13:57:55 +0000
Message-Id: <20210105135757.11069-16-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210105135757.11069-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 69FujixlqrxFZfmwpr8FfhFJx4520388AA=
Content-Type: multipart/mixed; boundary="3aWoIJ16gpWAN3DqzcfD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609855100;
 bh=V/kMvJYr57DM4gU2ZOLP5dYTofoKUb7yORLJalt/Urk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Aam2CeJHeUcgV03nQIsFn/sSLKsJlGhZH4aF4yloMWzsiuokIsUDE2e7GoO4OkvJshJ
 CsA8IgJ4EfIIh35sTQ65PaSJAq1ZyATx0yIjetRC81Ji/GPEDHzJuBeB4MygWN/Gv/Yk3
 yTQUOiPEtUX3NAshda9WOlMMh/TYST7WYyY=

--3aWoIJ16gpWAN3DqzcfD

From: Boris Brezillon <bbrezillon@kernel.org>

commit bfecfd6e23bf677c85828eb20fa4b13a18bffe23 upstream.

The dirmap descriptor object allocated in spi_mem_dirmap_create is
never freed. Add a kfree(desc) in spi_mem_dirmap_destroy().

Fixes: aa167f3fed0c ("spi: spi-mem: Add a new API to support direct mapping")
Signed-off-by: Boris Brezillon <bbrezillon@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-mem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index 0998ebc2689d..c3a08afb6edf 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -542,6 +542,8 @@ void spi_mem_dirmap_destroy(struct spi_mem_dirmap_desc *desc)
 
 	if (!desc->nodirmap && ctlr->mem_ops && ctlr->mem_ops->dirmap_destroy)
 		ctlr->mem_ops->dirmap_destroy(desc);
+
+	kfree(desc);
 }
 EXPORT_SYMBOL_GPL(spi_mem_dirmap_destroy);
 
-- 
2.17.1


--3aWoIJ16gpWAN3DqzcfD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6015): https://lists.cip-project.org/g/cip-dev/message=
/6015
Mute This Topic: https://lists.cip-project.org/mt/79450081/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3aWoIJ16gpWAN3DqzcfD--
