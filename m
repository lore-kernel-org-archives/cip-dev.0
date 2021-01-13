Return-Path: <SRS0=nq84=GQ=lists.cip-project.org=bounce+64572+6078+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F6E5C433E6
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1FEA23406
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1FEA23406
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6078+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZBz0YY4521723xPYwV2NjxWL; Wed, 13 Jan 2021 08:01:14 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.10261.1610553672734300249
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:13 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68678590"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:13 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 78B2340108FC;
	Thu, 14 Jan 2021 01:01:12 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 7/9] dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742 support
Date: Wed, 13 Jan 2021 16:01:00 +0000
Message-Id: <20210113160102.16310-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5vaOcyhILMM7ypMrOoLneIh2x4520388AA=
Content-Type: multipart/mixed; boundary="qF1KeYnnpVe02XtXWT5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553674;
 bh=NT5pdeBRW6JZ4Tv8M1XORsp73Obft8Szaw8nPfSKmZ0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=PgGTeXpy80hpDD3PYQ45lhb/f0CHeOQg6onkjdOvrwnmTk7mWBpEmKGZQpepkD3TMDO
 T7dJS7x9to4l3yEvuGnFmQ7PRy9o2g96XXDBrfdZDVRsi3on0heOHwJgcdC9cGOnJR55/
 AdkjyS0QQGXG717YZKZo7SxtRjsQKTNZgYw=

--qF1KeYnnpVe02XtXWT5D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 3b1954cd57bf7648417c593d60eac1ec661ad514 upstream.

Document RZ/G1H (R8A7742) SoC bindings.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[PL:Patched text version of bindings file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index 4493fc5771a9..e47a8d2495e8 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -2,6 +2,7 @@
 
 Required Properties:
 - compatible: should be "renesas,pwm-rcar" and one of the following.
+ - "renesas,pwm-r8a7742": for RZ/G1H
  - "renesas,pwm-r8a7743": for RZ/G1M
  - "renesas,pwm-r8a7745": for RZ/G1E
  - "renesas,pwm-r8a7778": for R-Car M1A
-- 
2.17.1


--qF1KeYnnpVe02XtXWT5D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6078): https://lists.cip-project.org/g/cip-dev/message=
/6078
Mute This Topic: https://lists.cip-project.org/mt/79654005/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--qF1KeYnnpVe02XtXWT5D--
