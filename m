Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5DDC44506
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:08 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19086.1782820143877492262
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=TCQKVWF5;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-463f1165e16so4461404f8f.0
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820142; x=1783424942; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UcRZJKfKEo7ekea44PuF9zNIoJRCDOs9ANe48AsMUSQ=;
        b=TCQKVWF5lbs/vgkh2mGBFzSAyi+p9eXshmR7CrfHRKjPDvm3UVNXPypeUcTWgfCEOp
         NrcUnFINqVZhjwVBg8WDWer4vxVO/o+VLv9GSoUSeQ7fjshRxUxcD8OLl3BgXtfWislr
         L0PnkLAjLsuaIm1SQNGuLduzJvegVpFmS8lg6KUs6B7NDkXIIqoeugwlh4yS9M8TVczo
         Tk++5c/x+xedBNU2JNV7/uEuzsZS+zmn2DreH0mIaUVYa09afD9kgksVznCnWA+YKald
         iXc4Wvi4a/mOI2BVR92GeS26RgFR6hRiGazezmnti5/Rvl2V8szBZIliNUSjYWqI0z5b
         2xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820142; x=1783424942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UcRZJKfKEo7ekea44PuF9zNIoJRCDOs9ANe48AsMUSQ=;
        b=q2oMAfe7oAGXW8D64+zRFCAYMdvjluq50Z4eTugbCyrQS9xmR2hFYCIdonPUO3Rsu0
         Y5iNhbMV9KRqQVI1e41J7xjihFkVagQxGCAPwdPD/ZogAg4gcVUwAJfNUds8zQMjuxK/
         Xnlblj8iA6EZpO5Ub/BCbsQdeLDeyTavTQ2Zf2MyTSSgQ3UQobzT42U5eXdYMJoYX0Ie
         XFUOqFIj4SLqUyfiyCaS4Y+XkkATa43Ws3Id7WSW7vaPi6h5j4q+7nnkE7ZErHgeeh5A
         5jmUMLczZYZ7g3wdcDZtAOn1OxEdc9rVMzOV72tVQOGoPpEuCsi7Ou3E1njzxIjgkbpb
         jeGg==
X-Gm-Message-State: AOJu0YyM8PI0WR97KD2W6rMVTtsSMgbNTU1OdTMeZc03DP4SLfylvxP/
	UHsTK/ygqn7fCFQIvMrrf6LxHtxue95ARu7xp3VrDISiIiI+AgSqC49TobEZUvs0
X-Gm-Gg: AfdE7cl/N2dFqMl5zEST+E0PEVoUuS35tmVaRZYJ4wyFqruVbJtuE78QOK1Tbtthqje
	hyR+b1XWEeAlWOYNkUpWCod+ihAvALTjAQjsAo44HrAy9cokTuyTamu/MuK3aJQ7b+9dB04kQcl
	zEpI70Ihsx5SKNQkXRsaT566jw/a3MgTwzPUv98tOgVltL2INnUcl6Z8n6vDkPapvMx2xDI9S7J
	dTTGsVQMFdOoGB68ZusQBw5s8oq8zGuY38YUmbrm1PU2DQPY8WUSLH9aLnjHVy1fC6F328BFWpi
	ubTUBMKklug9LMPUDFGla0I8S7l672kZquavhp32FrvrdhKk8Dvjhy+FbClRQ4KLuVQS1imPoOd
	glexqchkjLBmFg8H1/03XnVU3Dv3whd3wt38Ighr00pTaUbAKw2hkjhunzZJEP+1p7WV/oGWLs7
	+cTmC/YaDKWuBcUSYqyPQdnmCci+3MY3Cey7iKSA==
X-Received: by 2002:a05:6000:4284:b0:475:f100:35fc with SMTP id ffacd0b85a97d-475f10036c2mr2243715f8f.57.1782820142003;
        Tue, 30 Jun 2026 04:49:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:01 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 34/39] arm64: dts: renesas: Add initial support for RZ/G3L SMARC SoM
Date: Tue, 30 Jun 2026 12:47:53 +0100
Message-ID: <20260630114813.92739-35-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23358

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit e130dde0ab3ea21932cac19c27cf7650f53fa78d ]

Add initial support for the RZ/G3L SMARC SoM with 2GiB memory and
extal clk.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260324114329.268249-10-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../boot/dts/renesas/rzg3l-smarc-som.dtsi     | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi

diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
new file mode 100644
index 000000000000..ab4950671c7c
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+/*
+ * Device Tree Source for R9A08G046L48 SMARC SoM board.
+ *
+ * Copyright (C) 2026 Renesas Electronics Corp.
+ */
+
+/ {
+	compatible = "renesas,rzg3l-smarcm", "renesas,r9a08g046l48", "renesas,r9a08g046";
+
+	memory@48000000 {
+		device_type = "memory";
+		/* First 128MiB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x78000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <24000000>;
+};
-- 
2.43.0


