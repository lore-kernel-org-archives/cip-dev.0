Return-Path: <SRS0=sVhb=GQ=lists.cip-project.org=bounce+64572+6073+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B83C433E6
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:09 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D78A23406
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D78A23406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6073+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id JQZNYY4521723xGOkNePsvvP; Wed, 13 Jan 2021 08:01:08 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.10141.1610553666445693623
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:07 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68896932"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:06 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id EF44A400F792;
	Thu, 14 Jan 2021 01:01:05 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 2/9] display: renesas,du: Document the r8a7742 bindings
Date: Wed, 13 Jan 2021 16:00:55 +0000
Message-Id: <20210113160102.16310-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: m1q9gSTju7IGO8vcl4teLRRPx4520388AA=
Content-Type: multipart/mixed; boundary="e03nQewUVCSGdQKnatf2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553668;
 bh=jMW2JgCFzaw3j1QrHMJWbyMa5hLuhRI6ekAridtnAG0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sEXXiBCISyrvG6A9XCMC00r/VUllhUPS0k7QpZS/NMYDM181X+pyquj5nrEHecc2QYY
 bls3/MhQvQdJuLjlfeTQr2Cnwl4P3bXqHPaDlKRUBadwgQc7BpuPpTSkqbwZXYfsZKpJm
 5OrjEfLePBQz4+p2eyGwrf2LCrpMsbREkLY=

--e03nQewUVCSGdQKnatf2

commit c3415d91832cf47bf54973ef5415caeaba5249c6 upstream.

Document the RZ/G1H (R8A7742) SoC in the R-Car DU bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[PL: Manually applied the changes, dropped Port3 column changes]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/display/renesas,du.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/renesas,du.txt b/Documentation/devicetree/bindings/display/renesas,du.txt
index 96cc0805da56..d2f8a74c6718 100644
--- a/Documentation/devicetree/bindings/display/renesas,du.txt
+++ b/Documentation/devicetree/bindings/display/renesas,du.txt
@@ -3,6 +3,7 @@
 Required Properties:
 
   - compatible: must be one of the following.
+    - "renesas,du-r8a7742" for R8A7742 (RZ/G1H) compatible DU
     - "renesas,du-r8a7743" for R8A7743 (RZ/G1M) compatible DU
     - "renesas,du-r8a7744" for R8A7744 (RZ/G1N) compatible DU
     - "renesas,du-r8a7745" for R8A7745 (RZ/G1E) compatible DU
@@ -46,6 +47,7 @@ corresponding to each DU output.
 
                       Port 0         Port1          Port2
 -----------------------------------------------------------------------------
+ R8A7742 (RZ/G1H)     DPAD 0         LVDS 0         LVDS 1
  R8A7743 (RZ/G1M)     DPAD 0         LVDS 0         -
  R8A7744 (RZ/G1N)     DPAD 0         LVDS 0         -
  R8A7745 (RZ/G1E)     DPAD 0         DPAD 1         -
-- 
2.17.1


--e03nQewUVCSGdQKnatf2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6073): https://lists.cip-project.org/g/cip-dev/message=
/6073
Mute This Topic: https://lists.cip-project.org/mt/79653999/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--e03nQewUVCSGdQKnatf2--
