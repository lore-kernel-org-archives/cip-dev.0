Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC07D65543
	for <webhook@archiver.kernel.org>; Wed, 17 Dec 2025 10:32:35 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11775.1765967554444622845
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Dec 2025 02:32:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=KAZZYSYM;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b79e7112398so1094964866b.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 02:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765967553; x=1766572353; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyiKtQNMoQqs3fHJwiwv2QJBQoMsgTPu5ZpIui7IeBo=;
        b=KAZZYSYMfmT74+BfHesBopo5MCDIQs+t3ua7qgxg63ONVC5Gg+v4fPqgu6a/MyJjOS
         vciddxD3TlnxWLHRGxJDFh6XJQ5rS9BGjbtf0j4JdiULBdVGSANaiIZoZIQCc8X7E04/
         J0rFMiyzRwZ3yGz14oSK+274/J35N+BsHyuuFdqPkhhlt4BUUuSeXVnIlGANtphI5yt9
         h2cPsc5tfXNvkIoqOIMZ5bRhGgxzN3UW+KR/cTHkqLtwlMmCzsQHqgTgLar0OqRJ9ngf
         nfb1ObbiEn8dkPJ0Rxidt5z68Xvt64JXpQuVPZ//b/HQvqRbZomvY/UasELtVgKPrsUk
         Xqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765967553; x=1766572353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tyiKtQNMoQqs3fHJwiwv2QJBQoMsgTPu5ZpIui7IeBo=;
        b=rbYgrpV9I8dFDtM6MZC6gJG1z++1t/uFyyWH/Xgjtzw3GY+Iimmam8XB71M0ir51SW
         oHnBgwKmDG2jx5MsWTYjLASC0NZteZFNcCglrmCSvvxnZu2Y9vV1StKqckSREvNRDF3G
         KHharmz82Bdu7JyEA7Pbsg+lUXRZM+1v2C6wDMHsiFsLPyapacMW1Hyr11B9203vaBhO
         3C3LoBUs9hg4NngL7J97Mu0iQrQbapj3b0ikXXuplIUWxbmVMtD6m6OA32z5pcRaTYH8
         I/chgrPlpGwHfJVq5JjEmrUGlcaMQMN5gR4q5OkrYxl3HjXb0gHIUeJ0Mi9G/otDo8Fz
         23DA==
X-Forwarded-Encrypted: i=1; AJvYcCWlonc8K63b4bZnMe1n15pvnrNFZOsAD45jMUifQ3hcSamlXPeA/mujrP2HuShfG29hh49qqpDm@lists.cip-project.org
X-Gm-Message-State: AOJu0YzaFo1uj+6C3DvM+l3SHx3PHtrI6vAvBR/GABrx1gUWmOvSl1Ds
	KjFm/DWknJh0a+20n4TLXummZl7M3xMOQrF/3qrXQROCIIMmVIJO0SdIZ5SFqm13I3A=
X-Gm-Gg: AY/fxX58zwb7TKP+gKBbrYSSoNwirAaioxNFB//oHstULy/taiN7L4EB5+mGE8/17Tb
	9FBiPqp0uikURkenNME+Sa7lkJ79yxe/BwPaeFGA8NAFreKXis6S8eN3nA9UHZFLPesXpoFN8sE
	HWOxFYAH2vDIS3AAm0Vbo3nsGZ+j39dM5rr/yLeZuOeegD98JfJjCu+pYLXxyOkIKBpuEEisnmE
	1d6iiiHAO2JYl48n/XQSZpICQv94WGNNjhKKMF/2WBHSsgwCBPO17Dl5UoZsd6oX2QFjJDEZBMv
	YvdCJzo2cGPyfoxK/kNffP4HgiE0LuawD09APqaIUtTj9/kcRPldMOyjSFhXhFEGmgvaemMoEPc
	CAbWuiwdmFtnOaA26L12uTqmcykW9hGSBoFZQFdcvjgFwEpziIWiGGzlLbJgWIGpNgTp18odylt
	q3eNcIAR5sXhLh8GUx6KrF2PyU13n9HRddH5hSXekHS9C0UngcACI=
X-Google-Smtp-Source: AGHT+IEOKw7Iyc/gw/YIq+KQufXg3nYPTxC6jZfjbWgwIVvMmgG94gC3SXgB3ZLHFzSU5xJNJ2UrJw==
X-Received: by 2002:a17:907:1c29:b0:b79:e4db:2e9 with SMTP id a640c23a62f3a-b7d23a8d20dmr1812725066b.60.1765967552755;
        Wed, 17 Dec 2025 02:32:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e6edesm1955414166b.18.2025.12.17.02.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 02:32:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@denx.de,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 6/6] arm64: defconfig: Enable Renesas RZ/G3S thermal driver
Date: Wed, 17 Dec 2025 12:32:22 +0200
Message-ID: <20251217103222.4183089-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217103222.4183089-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Dec 2025 10:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21119

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 823062d153851a944e61768014d7458d609fa4ca upstream.

Enable the CONFIG_RZG3S_THERMAL flag for the RZ/G3S SoC.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250810122125.792966-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index affd0e1f107a..789830ba9870 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -703,6 +703,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_RCAR_THERMAL=y
 CONFIG_RCAR_GEN3_THERMAL=y
 CONFIG_RZG2L_THERMAL=y
+CONFIG_RZG3S_THERMAL=m
 CONFIG_ARMADA_THERMAL=y
 CONFIG_MTK_THERMAL=m
 CONFIG_MTK_LVTS_THERMAL=m
-- 
2.43.0


