Return-Path: <SRS0=hMfb=GH=lists.cip-project.org=bounce+64572+5988+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E0BC433E6
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:05 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0561F20780
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:20:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0561F20780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5988+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p6aYYY4521723xZukQbdvr4v; Mon, 04 Jan 2021 02:20:04 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web08.11678.1609755603596803773
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 02:20:03 -0800
X-IronPort-AV: E=Sophos;i="5.78,473,1599490800"; 
   d="scan'208";a="67985042"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jan 2021 19:20:02 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id A9F47400388B;
	Mon,  4 Jan 2021 19:20:01 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/2] dt-bindings: PCI: rcar: Add device tree support for r8a774b1
Date: Mon,  4 Jan 2021 10:19:58 +0000
Message-Id: <20210104101959.8182-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210104101959.8182-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210104101959.8182-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rjKVih3poRl8FbTbuW5cR27Bx4520388AA=
Content-Type: multipart/mixed; boundary="OzH4jm6VQ0jZtuGmtolf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609755604;
 bh=2guSv29U/e3Au1ry0JGx5Cm6xWxX/QhnKUTZtHnJtho=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=e1wD1Ybx8+zNMu6lI0CcAi1OwOvXeF44+JFsh0tzGEAHQODJndsijJiL3XUeo/qZc7B
 aEQSsSXpXtau95WfHisL8tIsN4wvyrE5O/5rsgkQ4eFV1XE6FiAvrG8xEAdNjgNKC748M
 +3afYldgkmXud7OM4Ku5OSJyPy5G4ZsxXGU=

--OzH4jm6VQ0jZtuGmtolf

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

commit 2ca98a46435c45f6b749b6ed4d9177f230e3cd12 upstream.

Add PCIe support for the RZ/G2N (a.k.a. R8A774B1).

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pci/rcar-pci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/Documentation/devicetree/bindings/pci/rcar-pci.txt
index 7920d303b924..a59c2ee141ec 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci.txt
+++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
@@ -3,6 +3,7 @@
 Required properties:
 compatible: "renesas,pcie-r8a7743" for the R8A7743 SoC;
 	    "renesas,pcie-r8a774a1" for the R8A774A1 SoC;
+	    "renesas,pcie-r8a774b1" for the R8A774B1 SoC;
 	    "renesas,pcie-r8a774c0" for the R8A774C0 SoC;
 	    "renesas,pcie-r8a7779" for the R8A7779 SoC;
 	    "renesas,pcie-r8a7790" for the R8A7790 SoC;
-- 
2.17.1


--OzH4jm6VQ0jZtuGmtolf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5988): https://lists.cip-project.org/g/cip-dev/message=
/5988
Mute This Topic: https://lists.cip-project.org/mt/79421230/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--OzH4jm6VQ0jZtuGmtolf--
