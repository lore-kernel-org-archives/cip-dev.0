Return-Path: <SRS0=oKdd=CG=lists.cip-project.org=bounce+64572+5315+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE63C2BB84
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:52 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39704207DF
	for <cip-dev@archiver.kernel.org>; Fri, 28 Aug 2020 16:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Ye0Du2WI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39704207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5315+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 4d0eYY4521723xRUUCjzEtZ6; Fri, 28 Aug 2020 09:07:52 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.45506.1598629371850471017
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Aug 2020 08:42:52 -0700
X-IronPort-AV: E=Sophos;i="5.76,364,1592838000"; 
   d="scan'208";a="55587892"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Aug 2020 00:42:51 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.245])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id B9E4D400C9FD;
	Sat, 29 Aug 2020 00:42:49 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 25/30] dt-bindings: gpio: renesas, rcar-gpio: Add r8a7742 (RZ/G1H) support
Date: Fri, 28 Aug 2020 16:41:50 +0100
Message-Id: <20200828154155.5827-26-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
References: <20200828154155.5827-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VZ5YJj0VyJxzJa0Hbz9AmLylx4520388AA=
Content-Type: multipart/mixed; boundary="xTlMYZ9ATvAuMJRKlCAw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598630872;
 bh=Ncai3Vg+gBb+bf3HIUjd0hX3PJ1W6VX+g8s2TpkGw+E=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Ye0Du2WIFdujSK32wW6IoqhGfIZN7eVfwSNtxoaZIOV0h9wkCqEihpDNNWCMyHtweTs
 ydynf7U582SfFx+4hCoH1V3sphegznstP/pzghV/z6zlmQyKiECOpKnzVxnE5CSIhijeS
 zsvzJDTGKM02Ec/CD+VdV6E8/s442AnBWXg=

--xTlMYZ9ATvAuMJRKlCAw

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 39c7c93de02c2c0c150ff41f33068c201b964050 upstream.

Renesas RZ/G1H (R8A7742) SoC GPIO blocks are identical to the R-Car Gen2
family. Add support for its GPIO controllers.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
[biju: Patched text version of bindings file]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
index 52fa8e4d8353..74e2897013c8 100644
--- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
+++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
@@ -3,6 +3,7 @@
 Required Properties:
 
   - compatible: should contain one or more of the following:
+    - "renesas,gpio-r8a7742": for R8A7742 (RZ/G1H) compatible GPIO controller.
     - "renesas,gpio-r8a7743": for R8A7743 (RZ/G1M) compatible GPIO controller.
     - "renesas,gpio-r8a7744": for R8A7744 (RZ/G1N) compatible GPIO controller.
     - "renesas,gpio-r8a7745": for R8A7745 (RZ/G1E) compatible GPIO controller.
-- 
2.17.1


--xTlMYZ9ATvAuMJRKlCAw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5315): https://lists.cip-project.org/g/cip-dev/message=
/5315
Mute This Topic: https://lists.cip-project.org/mt/76477104/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--xTlMYZ9ATvAuMJRKlCAw--
