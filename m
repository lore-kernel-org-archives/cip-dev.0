Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF964D15D8F
	for <webhook@archiver.kernel.org>; Wed,  3 Dec 2025 15:38:07 +0000 (UTC)
Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18207.1764776282315191099
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Dec 2025 07:38:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.172, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: bAtUbUhUThK5X8JJ86tGag==
X-CSE-MsgGUID: nIcfUlFQQuqJDn4oQ/PNtw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Dec 2025 00:38:01 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.93.82])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5BA4F400F934;
	Thu,  4 Dec 2025 00:38:00 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 01/12] dt-bindings: soc: renesas: Move renesas.yaml from arm to soc
Date: Wed,  3 Dec 2025 15:37:46 +0000
Message-ID: <20251203153757.32977-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
References: <20251203153757.32977-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Dec 2025 15:38:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20814

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit c27ce08b806d606cd5cd0e8252d1ed2b729b5b55 upstream.

renesas.yaml lists out all the Renesas SoC's and the platforms/EVK's which
is either ARM32/ARM64. It would rather make sense if we move renesas.yaml
to the soc/renesas folder instead. This is in preparation for adding a new
SoC (RZ/Five) from Renesas which is based on RISC-V.

While at it drop the old entry for renesas.yaml from MAINTAINERS file and
there is no need to update the new file path of renesas.yaml as we already
have an entry for Documentation/devicetree/bindings/soc/renesas/ folder.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220920184904.90495-2-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 .../devicetree/bindings/{arm => soc/renesas}/renesas.yaml       | 2 +-
 MAINTAINERS                                                     | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/{arm => soc/renesas}/renesas.yaml (99%)

diff --git a/Documentation/devicetree/bindings/arm/renesas.yaml b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
similarity index 99%
rename from Documentation/devicetree/bindings/arm/renesas.yaml
rename to Documentation/devicetree/bindings/soc/renesas/renesas.yaml
index ea9138d66174..6d6a308ac896 100644
--- a/Documentation/devicetree/bindings/arm/renesas.yaml
+++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/arm/renesas.yaml#
+$id: http://devicetree.org/schemas/soc/renesas/renesas.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas SH-Mobile, R-Mobile, and R-Car Platform
diff --git a/MAINTAINERS b/MAINTAINERS
index bb9565bbc2e5..7abd9a781d00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2699,7 +2699,6 @@ S:	Supported
 Q:	http://patchwork.kernel.org/project/linux-renesas-soc/list/
 C:	irc://irc.libera.chat/renesas-soc
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
-F:	Documentation/devicetree/bindings/arm/renesas.yaml
 F:	Documentation/devicetree/bindings/hwinfo/renesas,prr.yaml
 F:	Documentation/devicetree/bindings/soc/renesas/
 F:	arch/arm/boot/dts/emev2*
-- 
2.51.0


