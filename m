Return-Path: <SRS0=5mUU=GH=lists.cip-project.org=bounce+64572+5990+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F98AC433E0
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:29:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F9D20715
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 10:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9D20715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5990+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id meDZYY4521723xE2DCt29Jj3; Mon, 04 Jan 2021 02:29:14 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web09.11638.1609756153732953869
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 02:29:13 -0800
X-IronPort-AV: E=Sophos;i="5.78,473,1599490800"; 
   d="scan'208";a="67985539"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 04 Jan 2021 19:29:13 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4550541FA630;
	Mon,  4 Jan 2021 19:29:12 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip] dt-bindings: thermal: rcar-gen3-thermal: Add r8a774e1 support
Date: Mon,  4 Jan 2021 10:29:11 +0000
Message-Id: <20210104102911.8533-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: au46zeHXDO2Sub6WfAINkmDrx4520388AA=
Content-Type: multipart/mixed; boundary="eFD1e7tuuMaXhGPn8gp3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609756154;
 bh=nYlKBXS41+rXfROjODFr+peOXsX6ov0BLkeO0J+Eubo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=vEkLKnSnExUZu4qPbS4LoIWYw0wpu7QyqgN3kj1TVq8BQWe6RdPV1jbshqDb1/WHz6e
 +O4A2yQwed1pO+BvaWCu3cMor7Wxtb7xF07e0zLwqLcolUxbpLJAaN0BjA/PZ/7mhojQd
 gMbsRdJcRQj+hJVdUZXcqX/8RmTrWuKQqbE=

--eFD1e7tuuMaXhGPn8gp3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit adfe9285bed09264bf99689c4a6e932f0134cdb1 upstream.

Document RZ/G2H (R8A774E1) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1594811350-14066-3-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
[PL: Patched text version of binding file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Hi All,

This patch has been cherry picked from v5.11-rc2, note the DT nodes have
been already added into CIP for r8a774e1 SoC, hence this single patch.

Cheers,
Prabhakar
---
 Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
index ebf684cb0b8f..11dab17623d7 100644
--- a/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
+++ b/Documentation/devicetree/bindings/thermal/rcar-gen3-thermal.txt
@@ -9,6 +9,7 @@ Required properties:
 			  Examples with soctypes are:
 			    - "renesas,r8a774a1-thermal" (RZ/G2M)
 			    - "renesas,r8a774b1-thermal" (RZ/G2N)
+			    - "renesas,r8a774e1-thermal" (RZ/G2H)
 			    - "renesas,r8a7795-thermal" (R-Car H3)
 			    - "renesas,r8a7796-thermal" (R-Car M3-W)
 			    - "renesas,r8a77965-thermal" (R-Car M3-N)
-- 
2.17.1


--eFD1e7tuuMaXhGPn8gp3
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5990): https://lists.cip-project.org/g/cip-dev/message=
/5990
Mute This Topic: https://lists.cip-project.org/mt/79421300/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eFD1e7tuuMaXhGPn8gp3--
