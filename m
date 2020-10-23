Return-Path: <SRS0=3oXv=D6=lists.cip-project.org=bounce+64572+5660+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A09FC56201
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:14 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20547206BE
	for <cip-dev@archiver.kernel.org>; Fri, 23 Oct 2020 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FCVPhitt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20547206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5660+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zEZvYY4521723xwvyi5cxL0R; Fri, 23 Oct 2020 09:58:12 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.12445.1603472289888512488
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Oct 2020 09:58:11 -0700
X-IronPort-AV: E=Sophos;i="5.77,409,1596466800"; 
   d="scan'208";a="60634047"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 24 Oct 2020 01:58:11 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 01B3C400F935;
	Sat, 24 Oct 2020 01:58:09 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/6] PCI: rcar: Fix calculating mask for PCIEPAMR register
Date: Fri, 23 Oct 2020 17:58:01 +0100
Message-Id: <20201023165805.1910-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201023165805.1910-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: CoUIjLSVmLhHhgm4f1FJiFaGx4520388AA=
Content-Type: multipart/mixed; boundary="WUIKSkCNu0HdjmhgbbIZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603472292;
 bh=1wsWPIvATrgfKsgOQ8jiRXozgtLPsEpssEQFx+q6GAo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FCVPhitt+eV6X9Rqvag6rQOxKBSCczTl6KAiR2yd2SWPiDjeah76jhTS2PmHc2lxOMK
 82UCAvqR2xTZeXDKZEPtJd3EI93KToPk8O4Kljup0pPNFP7t4vDwARpgozMvPU0/VMBp1
 Ll2MuWI3gL/4+lGK9NczeaupD3No5cVKim0=

--WUIKSkCNu0HdjmhgbbIZ

commit 328263687148bebf0d5daf5d06bcc2a46f3d7b0a upstream.

The mask value was calculated incorrectly for PCIEPAMR register if the
size was less than 128 bytes. Fix this issue by adding a check on size.

Link: https://lore.kernel.org/r/1588854799-13710-4-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rcar.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index cf8840d180c3..7583699ef7b6 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -76,7 +76,10 @@ void rcar_pcie_set_outbound(struct rcar_pcie *pcie, int win,
 	 * keeps things pretty simple.
 	 */
 	size = resource_size(res);
-	mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	if (size > 128)
+		mask = (roundup_pow_of_two(size) / SZ_128) - 1;
+	else
+		mask = 0x0;
 	rcar_pci_write_reg(pcie, mask << 7, PCIEPAMR(win));
 
 	if (res->flags & IORESOURCE_IO)
-- 
2.17.1


--WUIKSkCNu0HdjmhgbbIZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5660): https://lists.cip-project.org/g/cip-dev/message=
/5660
Mute This Topic: https://lists.cip-project.org/mt/77756294/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WUIKSkCNu0HdjmhgbbIZ--
