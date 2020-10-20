Return-Path: <SRS0=aaUW=D3=lists.cip-project.org=bounce+64572+5623+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EAEC4363A
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57C121D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="PGpofDeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57C121D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5623+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id DtauYY4521723xgkUSczc0bB; Tue, 20 Oct 2020 07:58:15 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8069.1603205878331425469
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:58:14 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088244"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:58:14 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 33023433DEA0;
	Tue, 20 Oct 2020 23:58:13 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 26/26] tools: PCI: Fix fd leakage
Date: Tue, 20 Oct 2020 15:57:32 +0100
Message-Id: <20201020145732.30343-27-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fD2TfO3YyhiSX97k5roBa9eJx4520388AA=
Content-Type: multipart/mixed; boundary="UQgL0BFUkSgvp4i9xvp8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205895;
 bh=I8+OjHY5ZQ2n0zWpXfD7X+zeirvr1DAAjKzaYZnNYcM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PGpofDeq0Dl80tO/5aVRRRZnsLBteYkj6BKz33+/3uOmxzZ+SAjl8+acX2K7uET9Oj2
 68Yxf08XK2oWWoOSML3FxvOZaOmKQvMnEzdr2AJ1p+x+q0l+3dGEexAs4oRqXClHSEYuP
 t5cEW/DEYPUlFdUN+DRdC0hjdYXhD2TlMW8=

--UQgL0BFUkSgvp4i9xvp8

From: Hewenliang <hewenliang4@huawei.com>

commit 3c379a59b4795d7279d38c623e74b9790345a32b upstream.

We should close fd before the return of run_test.

Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
Signed-off-by: Hewenliang <hewenliang4@huawei.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 tools/pci/pcitest.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index b7e3b6a64956..9f3d2e584ce4 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -140,6 +140,7 @@ static int run_test(struct pci_test *test)
 	}
 
 	fflush(stdout);
+	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
 }
 
-- 
2.17.1


--UQgL0BFUkSgvp4i9xvp8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5623): https://lists.cip-project.org/g/cip-dev/message=
/5623
Mute This Topic: https://lists.cip-project.org/mt/77683547/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--UQgL0BFUkSgvp4i9xvp8--
