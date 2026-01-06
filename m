Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32DFC47BE5
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 10:41:57 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.87381.1767696117219577055
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 02:41:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GzTfLyUJ;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47d59da3d81so13174525e9.0
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767696115; x=1768300915; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKvNVz+PZtsXqfYBNNZfolOcCYXneG7sWZQB3LdP9rM=;
        b=GzTfLyUJlM9VzcxdOC/08rJB/crWL7AqdgmbmhslvrWtKR3VL5X3I264AvxKlYiI81
         Eh7DG3D8jj/Yk4SMv+ZJ9/FXntjy/x51d9oM1rP/jovKT1iJMpzSstU4MZvmf9fyu/4O
         H/rl74z0T9D0Urgk0/g8TrBbZFY48hWE/bxxKKZiqERyrAJtLtfYG/X4ppHg7Fz9CUE0
         5MRsO0TRglYZajmJzkNNBUshAnkxtm5key3HMcwBNBTQ3Doi+EFMM8d8TggTUSAY399L
         6dcbfb/+aBuEnD9YweIMT8ZmPJ4zAzw03qZess0CWlQG3w+u8MpdMtJomRwwcVOOVUh1
         1CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767696115; x=1768300915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rKvNVz+PZtsXqfYBNNZfolOcCYXneG7sWZQB3LdP9rM=;
        b=tq3cogxoud03HYH5X5YAY1L05jkCL9hgvYBJQyTcBLjSP/ra4tBN7Y29JYdtULuaAJ
         aAAUCP4wjESx6eI0hSCEm62eYBFkEmvOLydhnp507pWuJcD3Z7VDl4SZvzuwB4tA0JAQ
         9IYXrBCwT8CvliNFZNn7FfP9iF8+3R5/zvDZlBs8wqWTAAbnWIy+6RoQVXn1wRD5MvWf
         jc2kF0OVlBEKFjAEtP0Lt9E/mAuyq8ok4BKQFF6KCVNq2/NJGDOp0YvvmLxJ2PmIksXV
         nVaQHlQd0dP0G5gDpI+y6ovJGY7LJUzSNcaGsTJbOjw7Ia8gi0S3FTEVqGLhHhYOEQ0F
         uCKA==
X-Gm-Message-State: AOJu0YxKr1n1t6X7ZhrYLsBLi+BfL0JwIaEqLER/OjcWOtNABvBzibtn
	mnSEeKsh1dHNAq1nFHG2ZGm75zHCPsC4VGxd7wG7vqjPwdoWEL56cTW6amIWZg==
X-Gm-Gg: AY/fxX5WO8zrEu5qWhgIvlnbzFhn1L3EFwkFHJ9Y+bF4Vrgc//USx8bJH9wFKmG5OmL
	SzPjuV4ny9KdLM+vPtz0OhQPhokHwX5ajYbk92CRnHJFUHWaSSfFIkRIOrWvMIw7WtQuicDTeLI
	Lcj3cgWwQ90QLokLide6BwQy2QAL1nbh0vEvHGp5WTFPstMzYzo/mApjP+SCLYf3kVByDigb870
	DdgU/5kb6TgDfPM/kgw0YPETcAaZilDTxuEW+reN9iacf7/gIrQYq73cPTBuSXXnlm2r9vvQsUO
	hv8IJUUrY+aYDyQ/SK/5MzorBhtxKOcJdK3wigSIJA1VPzWHM3PHdBPexEv4By631EaXBcg9+FZ
	OYxMs0hMOAzGZmO96RTR2cfHUP3S/5nA/olyArzNUP7TFOUnIjOAx2vOP7KiCnQ7VyKPFDQSlm+
	bgyJDyJIKXkOIwdEnq/g==
X-Google-Smtp-Source: AGHT+IGfIUwr0VPCNiCY4vKyFMx5DQ0w/iOEuYA+k4sWVOEb6O9UCtL5QSHo0Ddnj/2wTyPY2n3uZQ==
X-Received: by 2002:a05:6000:2010:b0:431:f5:c36f with SMTP id ffacd0b85a97d-432bcfe4cfamr3018355f8f.31.1767696115376;
        Tue, 06 Jan 2026 02:41:55 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5feaf8sm3583184f8f.39.2026.01.06.02.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 02:41:55 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 6/6] arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI function
Date: Tue,  6 Jan 2026 10:41:48 +0000
Message-ID: <20260106104151.88020-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
References: <20260106104151.88020-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 10:41:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21331

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4b9e0d8aa96c92be0073825344b661afc49242aa ]

The latest RZ/G3E pin control document (rev 1.2) recommends using
Schmitt input when PS0 pin used as NMI function.  Enable Schmitt input
for PS0 pin.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250817145135.166591-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Pavel Machek <pavel@denx.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
index 4a3153b33eb8..ed6fcdc337a0 100644
--- a/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
+++ b/arch/arm64/boot/dts/renesas/r9a09g047e57-smarc.dts
@@ -131,6 +131,7 @@ i2c0_pins: i2c0 {
 
 	nmi_pins: nmi {
 		pinmux = <RZG3E_PORT_PINMUX(S, 0, 0)>; /* NMI */
+		input-schmitt-enable;
 	};
 
 	scif_pins: scif {
-- 
2.43.0


