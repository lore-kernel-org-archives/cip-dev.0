Return-Path: <SRS0=+YVz=B7=lists.cip-project.org=bounce+64572+5213+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BA9C433E4
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C08D2078B
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="u1GbWyuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C08D2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5213+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bthfYY4521723xcU3cTVanT4; Fri, 21 Aug 2020 07:17:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.135295.1598019427382928687
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 07:17:07 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55184973"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 23:17:06 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6AE0A40065C6;
	Fri, 21 Aug 2020 23:17:05 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 1/7] dt-bindings: iommu: renesas,ipmmu-vmsa: Add r8a774e1 support
Date: Fri, 21 Aug 2020 15:16:56 +0100
Message-Id: <20200821141702.3977-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
References: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Uu4vvKVpKCw5P88qL8HIEHsux4520388AA=
Content-Type: multipart/mixed; boundary="EIvvq6CMDlVBv5QSQrxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598019479;
 bh=kaV25Osbv+b+86Nz8JRmAkSLdsP8dx+XPAD4RfX8fQY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=u1GbWyuwILRANKn69vIGyF8QRkUI9B8hkw/ch7RIs+IXNIhxyZFW0xiH+ku0mQZCP57
 iIkdCfJEmX/Kdv3BX0f04rDJz77gyjlvHU6fFJMoSeNNQr3ByiX1Pmz0GEpKZ7c1b3Vfs
 0F8P0iwuoJ3MCFULzTYr56722hLYqmfYNgc=

--EIvvq6CMDlVBv5QSQrxg

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8a71c743bf5ecdcfb439662e4cef89d7b1132495 upstream.

Document RZ/G2H (R8A774E1) SoC bindings.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/r/1594676120-5862-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
index 56faf8dd0077..e2bc780b803c 100644
--- a/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
+++ b/Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
@@ -16,6 +16,7 @@ Required Properties:
     - "renesas,ipmmu-r8a774a1" for the R8A774A1 (RZ/G2M) IPMMU.
     - "renesas,ipmmu-r8a774b1" for the R8A774B1 (RZ/G2N) IPMMU.
     - "renesas,ipmmu-r8a774c0" for the R8A774C0 (RZ/G2E) IPMMU.
+    - "renesas,ipmmu-r8a774e1" for the R8A774E1 (RZ/G2H) IPMMU.
     - "renesas,ipmmu-r8a7790" for the R8A7790 (R-Car H2) IPMMU.
     - "renesas,ipmmu-r8a7791" for the R8A7791 (R-Car M2-W) IPMMU.
     - "renesas,ipmmu-r8a7793" for the R8A7793 (R-Car M2-N) IPMMU.
-- 
2.17.1


--EIvvq6CMDlVBv5QSQrxg
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5213): https://lists.cip-project.org/g/cip-dev/message=
/5213
Mute This Topic: https://lists.cip-project.org/mt/76329796/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--EIvvq6CMDlVBv5QSQrxg--
