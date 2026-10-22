Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23305.1792676433455595436
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Oct 2026 06:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=mr0yHILN;
 spf=pass (domain: gmail.com, ip: 209.85.128.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1dfd49525so14575005e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792676432; x=1793281232; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nH99OY+uvDsqua+LqxhxvxWhUnIlSXJ4EC8PljF889Q=;
        b=mr0yHILNKafgSGc4UvCb+b4gDgJ5zRJTo7A81NYVZt8FZY6+OWgl/pS4ATSCNEDyW+
         ZKxg+ZoTZFWKuoX+EuJQ471xSTcPiyzef6iojtBMbOqXJ43uw6FQ9Wd3HEJpkCJ+SxUD
         Sey7DBd4kGDuwURiwooaDrwJKdYr9Er4UvwWM3exma6d5lqYmcyJ66UZyxl75g3LTGp6
         FItgeI0Plz3k8gCLZzQRThwG3E7CR4PEhcnZ0scvBrYeef9cW3Sg6UJchvuHFvaYP/Sy
         DMeSb8nokwQHxvjzaN+UICpgVxHrQYv3OZFQ79GLowfInuao16w1d+b2BNU0OXCMoLGX
         58sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792676432; x=1793281232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nH99OY+uvDsqua+LqxhxvxWhUnIlSXJ4EC8PljF889Q=;
        b=t0KhRTLNBXhcRnIErpc9XfhNWLnLUha+LkoV/mAD6biwITGnGQau6LJMItijpNtqqS
         w1xOGwy/C4IfU2gNshO4iANUeFnzdq9nDeo/9yz8v9BSVhpFseAItLz3MKprQaScx5pW
         0VWdOL1tNVJ/tdwgyiEaxGaZcJsAS58UeW0e+c+dwtA2fWF49mZ1+ta+ZVZWHb0VNhU+
         O1Vqex7E5XEuDupfZLv0ZTFyzbm3AqiwYHyrOJIpFBPlHvcKl5WQQ0ww9TPYZReOtTnN
         zQYM2A0eeRNXweTKCFUY8y0rofgLTlTUX7Q5ap98r/nWSFw1JT5P6eQ/onMvVL7k0+Qi
         E6ug==
X-Gm-Message-State: AFq9FYJZ0F6ZvcFJCMCy763yeJnLoQDv2vAEpoy+yhtgDfj41qbujpM7
	1uOJg71Ra/IuTb0USrtVgS0nlQTnema6ILR9UqBgRYZf6+U1QzRM8+d+NaclCA==
X-Gm-Gg: AYBFou3WTccDRPrMB1sOFyltwyMVQDQCqfjr5R5i0Ky+668OTudx80q17BcfDdyLmuv
	maw8zImJc8gfrhA6wZ4M/O68QDi5Ywe+nezqgEpk9DklgI31OmzBX0w+CPHeNRZbA/EHJm1VTDN
	DmaquYRwXdhgHqAGYZciuucPfhQK5vLDc7uuopuBSj9juj/N2HaZtJD/MuxIkvQdU20d9Sje7fS
	OXv5fgGmKCvdR4zRrEjKNRPw9WmlsNItj9s0KhoskozCR2Dw+eLkf54QdhpdL7JnJzWtmXEpu+R
	K3K9f5C8M1trKJnBIoPSgqtVwBcsL07kiNZg/WYEaaF9WCeyuoJb7/KDMkkNcc7SSK/gUYPHk48
	wOQl3wBbOc29qVFKrOWeXLBlVSOCMbI2d2V61pMsdD6QtncrSF13FbKc+Y5vBYC8px3f1wWUcK1
	b72c1ZUQZvUhgJA8szG/fFGa2ELkUQLFlaVQWp56bRWF7+auEDQmUxSdW6tZldbJJPFgOfGlEqW
	TPYF4QdyNSaarPIE2jjaQTDAEnqk4g/j4LTEHSXYTTJP7d3/w8cYy2C/KX4CTYHZ9uCymqIUQv0
	Mtztxi18+Yfp5Tc/iruE5E+gyh280SiWz8GYr+yl1/TqIEXFypM=
X-Received: by 2002:a05:600c:4f91:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4a1fdb1d82bmr113647415e9.6.1792676430656;
        Thu, 22 Oct 2026 06:40:30 -0700 (PDT)
Return-Path: <biju.das.au@gmail.com>
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3c4e:ba43:9a8e:7e31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a203963f3fsm82888415e9.2.2026.10.22.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 06:40:29 -0700 (PDT)
From: Biju Das <biju.das.au@gmail.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 5/5] arm64: dts: renesas: r9a09g047e57-smarc: Drop SW_SER0_PMOD condition for rsci4
Date: Thu, 22 Oct 2026 14:40:14 +0100
Message-ID: <20261022134021.217964-6-biju.das.au@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022134021.217964-1-biju.das.au@gmail.com>
References: <20261022134021.217964-1-biju.das.au@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 22 Oct 2026 13:40:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24514
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 31fd71751e699117d71ed998c58fc7fe9ec471fa ]

Rsci4 is routed to either the PMOD connector or the M.2 connector,
depending on the SW_SER0_PMOD switch state.  In both cases, rsci4 is
available for use, so there is no need to guard it with SW_SER0_PMOD.

Drop the SW_SER0_PMOD condition and retain only the SW_LCD_EN check,
as rsci4 is unavailable only when the LCD is enabled.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260603143340.162457-2-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 6372f582a7c41..07db9e4345217 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -237,7 +237,7 @@ &rsci2 {
 };
 #endif
 
-#if (!SW_LCD_EN) && (SW_SER0_PMOD)
+#if !SW_LCD_EN
 &rsci4 {
 	pinctrl-0 = <&rsci4_pins>;
 	pinctrl-names = "default";
-- 
2.43.0

