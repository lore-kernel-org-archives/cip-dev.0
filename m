Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320A3CE7AE5
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 11:13:59 +0000 (UTC)
Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15674.1763118828695230397
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 03:13:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: renesas.com, ip: 210.160.252.171, mailfrom: ovidiu.panait.rb@renesas.com)
X-CSE-ConnectionGUID: 6V8EZ/omSe2LtxLXImoKPw==
X-CSE-MsgGUID: uo2JbZCgTG2/GXyQt6w9Bw==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 14 Nov 2025 20:13:48 +0900
Received: from vm01.adwin.renesas.com (unknown [10.226.92.4])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id F3C124575F02;
	Fri, 14 Nov 2025 20:13:46 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@denx.de,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [PATCH 6.1.y-cip 1/2] kbuild: Allow DTB overlays to built from .dtso named source files
Date: Fri, 14 Nov 2025 11:13:42 +0000
Message-ID: <20251114111343.74438-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
References: <20251114111343.74438-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 11:13:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20548

From: Andrew Davis <afd@ti.com>

commit 363547d2191cbc32ca954ba75d72908712398ff2 upstream.

Currently DTB Overlays (.dtbo) are build from source files with the same
extension (.dts) as the base DTs (.dtb). This may become confusing and
even lead to wrong results. For example, a composite DTB (created from a
base DTB and a set of overlays) might have the same name as one of the
overlays that create it.

Different files should be generated from differently named sources.
 .dtb  <-> .dts
 .dtbo <-> .dtso

We do not remove the ability to compile DTBO files from .dts files here,
only add a new rule allowing the .dtso file name. The current .dts named
overlays can be renamed with time. After all have been renamed we can
remove the other rule.

Signed-off-by: Andrew Davis <afd@ti.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Frank Rowand <frowand.list@gmail.com>
Tested-by: Frank Rowand <frowand.list@gmail.com>
Link: https://lore.kernel.org/r/20221024173434.32518-2-afd@ti.com
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 scripts/Makefile.lib | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ceeb76a29591..d01961c799e1 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -412,6 +412,9 @@ $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
 $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
 
+$(obj)/%.dtbo: $(src)/%.dtso $(DTC) FORCE
+	$(call if_changed_dep,dtc)
+
 dtc-tmp = $(subst $(comma),_,$(dot-target).dts.tmp)
 
 # Bzip2
-- 
2.51.0


