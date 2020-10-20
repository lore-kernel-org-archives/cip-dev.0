Return-Path: <SRS0=lxBH=D3=lists.cip-project.org=bounce+64572+5618+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78A2C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:08 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E2A021D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VxJ6CcjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2A021D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5618+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id XFDSYY4521723x4dPnMxZwcW; Tue, 20 Oct 2020 07:58:07 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8069.1603205878331425469
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:58:07 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088226"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:58:06 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A5B60433DEA6;
	Tue, 20 Oct 2020 23:58:05 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 21/26] PCI: endpoint: Clear BAR before freeing its space
Date: Tue, 20 Oct 2020 15:57:27 +0100
Message-Id: <20201020145732.30343-22-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8PrMerOQlOEibL9pFx7a9yZCx4520388AA=
Content-Type: multipart/mixed; boundary="DbWtiwFpRzSU1HQd7JHl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205887;
 bh=fqY8tIJ0ZYAIl/242kXsBN3TFTr8DjvEs8oUEKPzFP4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VxJ6CcjTvBeM2srQoszhoE7aTrVfnurrZieLzPnpn4OPQNX6FUPXJvy7gu/VSwp3UFP
 i9Yh50DwON8AqXW0IndhFRJcw+Pvgs1LLCCxlUOwqyG6VWyatk1aPP+HH2l1w2BGQ/tb7
 YOwy88bgnUB7wfT5cTseAoMDXIuG5I6Adyk=

--DbWtiwFpRzSU1HQd7JHl

From: Alan Mikhak <alan.mikhak@sifive.com>

commit dbb7bbcc8ad248b1ab05bd27dfdb587ef4023dab upstream.

Associated pci_epf_bar structure is needed in pci_epc_clear_bar() to
clear a BAR correctly but it is reset in pci_epf_free_space() (that
is called first) which results in pci_epc_clear_bar() failure.

Reorder the pci_epc_clear_bar()/pci_epf_free_space() calls execution
to fix the issue.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
[lorenzo.pieralisi@arm.com: reworded the commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index e8bcc924dbf8..1cfe3687a211 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -381,8 +381,8 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 		epf_bar = &epf->bar[bar];
 
 		if (epf_test->reg[bar]) {
-			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 			pci_epc_clear_bar(epc, epf->func_no, epf_bar);
+			pci_epf_free_space(epf, epf_test->reg[bar], bar);
 		}
 	}
 }
-- 
2.17.1


--DbWtiwFpRzSU1HQd7JHl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5618): https://lists.cip-project.org/g/cip-dev/message=
/5618
Mute This Topic: https://lists.cip-project.org/mt/77683538/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--DbWtiwFpRzSU1HQd7JHl--
