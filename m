Return-Path: <SRS0=0ujb=GQ=lists.cip-project.org=bounce+64572+6076+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E59C4332D
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2365023437
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 16:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2365023437
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6076+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ofRPYY4521723xkFXLGYFs2L; Wed, 13 Jan 2021 08:01:11 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web09.10141.1610553666445693623
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 08:01:11 -0800
X-IronPort-AV: E=Sophos;i="5.79,344,1602514800"; 
   d="scan'208";a="68896947"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Jan 2021 01:01:10 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id DB97C400F792;
	Thu, 14 Jan 2021 01:01:09 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 5/9] dt-bindings: pwm: renesas,tpu-pwm: Document r8a7742 support
Date: Wed, 13 Jan 2021 16:00:58 +0000
Message-Id: <20210113160102.16310-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210113160102.16310-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 1GQKhmX5jpLVsM5sJhgDHzJkx4520388AA=
Content-Type: multipart/mixed; boundary="eTvkuYstSzSpYwWqL1Sq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610553671;
 bh=Y8LuD2so0INLo11bCVnph1Rkw5b2gr0WWw4T2HUbVBU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ILlAaXVyefA25n7gyyK59Xj+ULTahCfiv0s/U7Ckm/eKQ5FlFKfoB2boafpSdJrgfCT
 J8qsP5oco7am9GwBHBP2/ZoVMxzpZv/Z+Dk4lh150H2LTqOAREXet3l0JCtunFe0EMmb1
 dR/GP7fB+sORlHkyMEq8CQpj4lC54gwB/8Q=

--eTvkuYstSzSpYwWqL1Sq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 6a78dfb8facadef74bdf5af5ed84f6c722299fbb upstream.

Document r8a7742 specific compatible strings. No driver change is
needed as the fallback compatible string "renesas,tpu" activates the
right code in the driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <robh@kernel.org>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[PL:Patched text version of bindings file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
index 90e0a0a3ae71..1613243d88aa 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt
@@ -5,6 +5,7 @@ Required Properties:
   - compatible: should be one of the following.
     - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM controller.
     - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM controller.
+    - "renesas,tpu-r8a7742": for R8A7742 (RZ/G1H) compatible PWM controller.
     - "renesas,tpu-r8a7743": for R8A7743 (RZ/G1M) compatible PWM controller.
     - "renesas,tpu-r8a7745": for R8A7745 (RZ/G1E) compatible PWM controller.
     - "renesas,tpu-r8a7790": for R8A7790 (R-Car H2) compatible PWM controller.
-- 
2.17.1


--eTvkuYstSzSpYwWqL1Sq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6076): https://lists.cip-project.org/g/cip-dev/message=
/6076
Mute This Topic: https://lists.cip-project.org/mt/79654003/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eTvkuYstSzSpYwWqL1Sq--
