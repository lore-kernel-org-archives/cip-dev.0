Return-Path: <SRS0=4yS2=D3=lists.cip-project.org=bounce+64572+5606+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47126C5517B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 925EE21D7B
	for <cip-dev@archiver.kernel.org>; Tue, 20 Oct 2020 14:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="so4pyTU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 925EE21D7B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5606+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id f4BdYY4521723xoNvtscjWkq; Tue, 20 Oct 2020 07:57:52 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.8061.1603205857454945281
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2020 07:57:49 -0700
X-IronPort-AV: E=Sophos;i="5.77,397,1596466800"; 
   d="scan'208";a="60088191"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 20 Oct 2020 23:57:48 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 7FAF4433DEA1;
	Tue, 20 Oct 2020 23:57:47 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 09/26] PCI: pci-epf-test: Remove setting epf_bar flags in function driver
Date: Tue, 20 Oct 2020 15:57:15 +0100
Message-Id: <20201020145732.30343-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201020145732.30343-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8wg1hovowlO94KQFAdtyULDfx4520388AA=
Content-Type: multipart/mixed; boundary="eV6Fnc3KBUBQ9AczyTO9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603205872;
 bh=/jhiEz6dOY0Xg2KpCEBJE89l8GpLI4OWHI6ebtHsqZM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=so4pyTU5BJ35WfMJlTPX8KXQQAKJrWWwPAD0wK9HxaYxQf3R707sH+JvhKdoE1bU6/r
 0cvhzIzRXHEZFoukY0XKdj+lZIiqaHAOxFNo4HhVd1WoRtodhJIvxHSQjp99C8TFtU2uQ
 SDMjC8Zx/KFDwliO7n3t0fMiAsw1cBuiy/Q=

--eV6Fnc3KBUBQ9AczyTO9

From: Kishon Vijay Abraham I <kishon@ti.com>

commit 0342e9a797db42a7d4d083d10b5d3f38b0cfc193 upstream.

Now that pci_epf_alloc_space() sets BAR MEM TYPE flags as 64Bit or
32Bit based on size, remove setting it in function driver.

Tested-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 4bbd26e8a9e2..ad0efa4446ba 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -406,10 +406,6 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 	for (bar = BAR_0; bar <= BAR_5; bar++) {
 		epf_bar = &epf->bar[bar];
 
-		epf_bar->flags |= upper_32_bits(epf_bar->size) ?
-			PCI_BASE_ADDRESS_MEM_TYPE_64 :
-			PCI_BASE_ADDRESS_MEM_TYPE_32;
-
 		ret = pci_epc_set_bar(epc, epf->func_no, epf_bar);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar);
-- 
2.17.1


--eV6Fnc3KBUBQ9AczyTO9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5606): https://lists.cip-project.org/g/cip-dev/message=
/5606
Mute This Topic: https://lists.cip-project.org/mt/77683523/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eV6Fnc3KBUBQ9AczyTO9--
