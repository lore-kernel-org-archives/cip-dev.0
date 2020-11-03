Return-Path: <SRS0=R7ze=EJ=lists.cip-project.org=bounce+64572+5726+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E1BFC388F9
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:57 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E376922226
	for <cip-dev@archiver.kernel.org>; Tue,  3 Nov 2020 17:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="CS0xqjdT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E376922226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5726+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jv2AYY4521723xmkmHU5WLcP; Tue, 03 Nov 2020 09:33:56 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.810.1604424820973392125
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2020 09:33:55 -0800
X-IronPort-AV: E=Sophos;i="5.77,448,1596466800"; 
   d="scan'208";a="61561057"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 04 Nov 2020 02:33:55 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 6DBFF4009BE5;
	Wed,  4 Nov 2020 02:33:54 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 13/17] dt-bindings: pwm: renesas,pwm-rcar: Add r8a774e1 support
Date: Tue,  3 Nov 2020 17:33:32 +0000
Message-Id: <20201103173336.2829-14-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201103173336.2829-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 9jb0yF7WwdNf9d41nHxWgnlox4520388AA=
Content-Type: multipart/mixed; boundary="eWOQf1JAnXYNItw0LQ4D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604424836;
 bh=Cw57g8KfcYvNyslnIKUGxJatXmcLT7QThzVRC8SoyFU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=CS0xqjdTHb6/zgP0y1q0CDYQ+f3zWA1+INvoevSsXUyPUsX6FRE/jzT7FNsQm16IFt3
 UPcxRfmXuJrMPbu7ea5MpMvNKGWMvQ2Mw0BWrZrdv0mkmc8K8CrHRw92gFoFosqHiU8IN
 93zwhopWHpioR5iSmwj9cnQDLQnerDmUUWE=

--eWOQf1JAnXYNItw0LQ4D

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 0142ee3f2e88ef894427e926b3c8ad7c95964b01 upstream.

Document RZ/G2H (R8A774E1) SoC bindings.

No driver change is needed due to the fallback compatible value
"renesas,pwm-rcar".

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
[PL: Patched text version of bindings file]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
index 3627516b0dad..6b8d831f306a 100644
--- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
+++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
@@ -6,6 +6,7 @@ Required Properties:
  - "renesas,pwm-r8a7745": for RZ/G1E
  - "renesas,pwm-r8a774a1": for RZ/G2M
  - "renesas,pwm-r8a774c0": for RZ/G2E
+ - "renesas,pwm-r8a774e1": for RZ/G2H
  - "renesas,pwm-r8a7778": for R-Car M1A
  - "renesas,pwm-r8a7779": for R-Car H1
  - "renesas,pwm-r8a7790": for R-Car H2
-- 
2.17.1


--eWOQf1JAnXYNItw0LQ4D
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5726): https://lists.cip-project.org/g/cip-dev/message=
/5726
Mute This Topic: https://lists.cip-project.org/mt/78011705/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--eWOQf1JAnXYNItw0LQ4D--
