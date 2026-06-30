Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1FCC43602
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:49:07 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.19087.1782820144535934754
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:49:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=bdI5fyJJ;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-472326ca506so1431905f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820143; x=1783424943; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x1VtgIW1TCLej3nJc7SbmiLFIYmFbx1aq1fxm7lcpD0=;
        b=bdI5fyJJQ89sauDnqogGr5gLF8DACG5wv35a1zYLyFgXH+3XEyi6UplSnz1sN99JKQ
         kNygpOpLXY+IysnvT+Tgak92XK2MTmx7ZlVJyKl1KZTepTXvt3onIkUtkuyxygc8K0rq
         gDXexLZKrWCXiW99/vULEeBv/QfuUySDSKimJXH4P6VSwhaWh8vVo/bdrrHv+xytgMvI
         aH91glosIzKvCe9e/YycToVVnMjRBcj5DDZRWF9tg2Ib/M15WVAdUTBp/4uduC7yuR09
         GoArWA99HeJLsmf9BQt+tS9mgEc3Tk7oXY/1snJ/OzyE/4fLTK3p6XHNHtcJhKoSP16/
         zOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820143; x=1783424943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x1VtgIW1TCLej3nJc7SbmiLFIYmFbx1aq1fxm7lcpD0=;
        b=lNCz6HjqgKiLokjkQyT48ob7NYQE55Al3McMFI1Ksv9gxOL0SUyqcoMsWglpueXkyr
         DmUq0BNpZ1w05zPFCH6VNpmHNf/0700Xwy2du3jPVVjmHg2KR2/J5cmQFuNCjXoHNlJe
         MKeiaSjwAs62+mQcW6s7FWQGeX0dh4Y+La2gHxQMQmtmCAMAFYJTk5j7u+Ljl86Xr7yK
         i7cua3RDoqZVwOkpsYOxJ1Y+zo5VeHfNHPjiKvUcmFJ/K0o/Qz2+0zYq+nVqBC2YFFDr
         0R3avHnhN/bvJYXUcKK7z3c5U8jn3VWeqUlyAwaAZOoJi/O0J7GlKX2XckoKG1+ZisI2
         2l7Q==
X-Gm-Message-State: AOJu0YxYMLp7ORKXRsOKJ45It3bIjl0jclPaj5/Nd8uzfdcK0lZ7qehX
	KzzfeEijtOuFbkOZTTmt3yjQCXXWAkd0orM5R/BN7Gn7JfhHFY5AOkDdvlVA6G96
X-Gm-Gg: AfdE7cm33dqMNBOnf4KZbmlH3RyDZUZ1eEmpzEr37OwvaAhoxUeaF4TQrA7cf5Uu70D
	JCbuzWxZ4iL2V18Tb+B8bpEKOntrjOUYDv/N+tWoprP/E9IyIrjzDY6etJL1BzfZvfO7lbz9Lea
	wzWDQ3m7FiHPOiKCbHFsXsPSroBbjMLoXkQDU/0JEOnyApO8wnV5lmgbEXzWRpGHmhZQY7A+kbB
	aVd3CWjAD/j31xf3Gp2GYlaixeCRDC9VhnIk+4oOzxHUvBjC+YtOpE+DKj9JUaqz1wyUonMQnPl
	ISDSmYwKfkUKy7UGUn09DnvG/8T7kZq4ZKgFZYrGPYREYlxgsdmZUBx0PVS8lnnrT/Ui5u0LbA0
	cCTNInA94HVHVQTPfEgQGCOe5F65lDu/oX2K1K5lrPjwjEm+jC3iEcGwAaS9O3cIZBG6xOwwOsh
	/ZB8RQwEqJPKGr91rkIJzbPTbjXx1tFvlk05kOQA==
X-Received: by 2002:a05:6000:2386:b0:475:e015:c2a with SMTP id ffacd0b85a97d-475e0150e6fmr2490032f8f.8.1782820142634;
        Tue, 30 Jun 2026 04:49:02 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:49:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 35/39] arm64: dts: renesas: renesas-smarc2: Move usb3 nodes to board DTS
Date: Tue, 30 Jun 2026 12:47:54 +0100
Message-ID: <20260630114813.92739-36-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:49:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23359

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 7eeed6cd6a419f2f412aab29344a129e1c5c37f7 ]

The SMARC2 board DTSI is common to multiple SoCs.  Move the USB3 nodes
to the board DTS, as some SoCs (e.g. RZ/G3[SL]) do not support USB3.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20260324114329.268249-11-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 6 ++++++
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi    | 8 --------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 9be57785d9d5..6372f582a7c4 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -280,7 +280,13 @@ &sdhi1 {
 	vqmmc-supply = <&vqmmc_sd1_pvdd>;
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
 &xhci {
 	pinctrl-0 = <&usb3_pins>;
 	pinctrl-names = "default";
+
+	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
index e2a34577a1a1..696a933af808 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -111,11 +111,3 @@ &sdhi1 {
 
 	status = "okay";
 };
-
-&usb3_phy {
-	status = "okay";
-};
-
-&xhci {
-	status = "okay";
-};
-- 
2.43.0


