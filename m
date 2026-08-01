Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7995C55184
	for <webhook@archiver.kernel.org>; Sat,  1 Aug 2026 09:15:13 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2478.1785575709140103261
 for <cip-dev@lists.cip-project.org>;
 Sat, 01 Aug 2026 02:15:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=A2rxwOSz;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954f5e8020so2265035e9.2
        for <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785575707; x=1786180507; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iKMvCsFLiK/jnGZlsmh9rqAHtFfcT+CyFLq0OJ8lZJ8=;
        b=A2rxwOSz19vMervCn68LxPnGryrIT0UBwrhClX2xgIvIoYOBIDsAgb/J6cj7m0m4k5
         QB5pv/u0pZ5zLSj6qKfYhnpSARdKHxviYLYQGCvumS4CCBi2dVV2V16V/kHlki8UAsVf
         R2tJ5A+i2kGOhE5Ni7GaIRIpGhbF+w3dBquciwKuOxraT+o3jM386QvzzhF3Eq29KoDn
         ggKcm3BlA5z0fgD/qhFZOq+cdXM7rSl5Uou9DsJXUG3S9bl5nEgw6Z2HDM8RuUvSiv5p
         K3oJ8rn6CtHDF3TwhGwWNJw06yL+O5Kih4ZSM1xJLGBlpASODXFdg6EJsohYSzmuVwvz
         cLeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785575707; x=1786180507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iKMvCsFLiK/jnGZlsmh9rqAHtFfcT+CyFLq0OJ8lZJ8=;
        b=pEYiAzywLNdg1NrtNawj3sH5IoSDJnvGWq6ei75a1E1RNZnWMBmNf0/Qh6FHwHQlK4
         o4xpJWN0gQWjVLiv9BfuJH/2ZohGd1NEdUVLu8A91dSkCcZoDtTeydLAZi1klR6os26S
         nbRij9//AZPh6CgiyHYrer9DlbVFFAKmhXD4vp0OtCGyof8tbyMQHP5kZ5LvWIrFNbcz
         VO7oI8fu8Iz88JWilAWe+PB4g53WXgvj9idyQljklB6Qi5fiLuNDrv7TxkQfYl/AK8eX
         fnQiGKTjhmQR2hZfaZ7UViL89RH/QryVtO/r6kQS4Ie7S4SMh5ZaaNBYSQLfsO9vDqGf
         CxeA==
X-Gm-Message-State: AOJu0YxRChBFY5mPEeRs4nHM/bypPV6QHuY1NQv3EYdSTpVxm8Ovr/f+
	UC0dQI+CYFXURPwhiUxXraOqdLHzegb9tJr4kzUKP4sTSzgxaFd0uo8i/4clhA==
X-Gm-Gg: AR+sD12Ty/o0HrmnChuinvOmeLBlGQ8eGUT3kQANGfTicBOxvHIh5F3YhwkBKcOogqf
	qY749vJcqQuEayePMBN8uN57LCTvjJIJqTzZxDMPxTuNmGmLDsMwyMMlr2p73zTD21AuYjvSdG2
	EUFyFxWw43inqDMXiPLWxjimeDaLnvWYDnpx4eySUrFdq9oU+GWEdBhEditlAsK2qRuJK7VgJ1z
	c00NuytqA4jpKOM8jpnh0aINiOVFGDUG1CipUn0/3Ihq8a63RiwFD4l0Nn5BPZzSuvp7ne/BuzM
	P6gN7NTFzgR/w9sUEczTnK0udvitPQlcHWv1T+eH1a7aG8pzesStFFc9HRLflcQZCBy9H0Gx2EH
	xCNTOuE0T+iR76bXJFs4qlVVTotS4BlGXbiGz3G5bGb+xAJf2QOApD43nRpmSbg2yQ9+EJN5SE5
	nYxe1K/EgV92U1sc+WMM4jOb5Cb2BIsd788g/gv3e/M2Gtg9+tD1m/kKbNNrzx24moDwLTCdFe+
	EQoR6RbB/76Mw==
X-Received: by 2002:a05:600c:12c8:b0:495:63e6:5fb8 with SMTP id 5b1f17b1804b1-4980c653e58mr19784425e9.12.1785575707315;
        Sat, 01 Aug 2026 02:15:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c3e4:203e:a11f:3195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b5f007sm36171565e9.6.2026.08.01.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:15:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/19] arm64: dts: renesas: rzg3l-smarc-som: Enable watchdog
Date: Sat,  1 Aug 2026 10:14:41 +0100
Message-ID: <20260801091458.14026-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
References: <20260801091458.14026-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 01 Aug 2026 09:15:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23837

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 5a5dcb6a52feeef07bc6ad4e32f8276b1093b8f6 ]

Enable watchdog timer channel0 on RZ/G3L SoM DTSI.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260505125921.149682-3-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
index 1e4c929d7081..6ced094d9f6e 100644
--- a/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3l-smarc-som.dtsi
@@ -162,3 +162,8 @@ ctrl {
 		};
 	};
 };
+
+&wdt0 {
+	timeout-sec = <60>;
+	status = "okay";
+};
-- 
2.43.0


