Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032741067054
	for <webhook@archiver.kernel.org>; Thu, 12 Mar 2026 15:35:43 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.24722.1773329734214166810
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Mar 2026 08:35:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=RnjKWUYm;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48534237460so12330325e9.3
        for <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 08:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773329732; x=1773934532; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HHYK2z7N14HlewHbj/Inv3/UxiYmVcai0oIXlC4lt4g=;
        b=RnjKWUYmPnHSlP7oQHmTY7tjbGATx5zTg5bVeiwJ8HIJ0F9DgCTKoqRr4u/AlP1PyL
         PHi9EFRMudYRrCYh1b5J9cdIc09/LMVKJrnXwiinyJ00l9WMnS1bcRht1KIFPF2e6fs5
         NEzqW2t/E9Z80Hx8+/esYC6cidlW8mZVLpjq6pStMrraf62xKmdgpeO3w7qdJeeP8Dkd
         yXYG+G/GO7p3o8CLIVTu9Im9Yo6WJCsvGKEnTF7X8zO7VKUjJfH1HCt8rVpPo8IRNXJw
         ZIJ5Xm3L8ecl1jnwS7yUNUivtTDN7Ja71HgfpPQcIVb5GOPnTVuikmFQMtmYzJsudFFM
         nkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773329732; x=1773934532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HHYK2z7N14HlewHbj/Inv3/UxiYmVcai0oIXlC4lt4g=;
        b=E01cm0vRL/H8W1ATot4LFcvFjoJloY3Cc6gQjFyQ/wsRPdee3kzt/wyC9fDAWMXxhc
         EZI4RVE470970I32HEnFR7z40gVz9zAIIbafpS9FYVZvDLvn381hu36aFhw6G92cZwJE
         ynHHoT/nTwP8xRsQmBeawAlGrC2eUL89A1v8vXP4JF6COc9BbAxaOOjECB0knPG+RLzb
         Y71aCBtULVRipE9lXh85+L8F66sZZ6BglwhpqBxmssa1O7DOASM5LWgCGkiPe7l5L9Hp
         7JxH++xMsTRacxO8dt5BuMZx2j3jwRrhYPTF5W6H1ipZ03H09CXqyh9A74pD1tHDSrzO
         gBfQ==
X-Gm-Message-State: AOJu0YwlW/oqa6PiVAy1onLFAewvTCnNLrgUc1kwcR1Dnwle8okoFs0S
	BDYpo+BW0XGMvViDLWUJHnD0BaMjHOFU7/DRplF/8zZl4DyoIqVW9vw5vCcyXQ==
X-Gm-Gg: ATEYQzyg97UG2wxt9t0g2N7aZ1wug0vASjoDzPjHmetvbe4c+O+8muPJE6BGyS0t5cL
	FMdRjgCdVsDmzkJWL71Il7UH1TtO8gla5qLgWroGJcpH5JGK7jxOry6+m14c1/tnK0HciLx+lmT
	3k/1nfDsNIFy2AZrSzDU816ZMSGm+/qZfOa+GFV08xfQnict4jZCDlK3aH9Q9a4iw/TrEYexXb2
	WkdY7eeX1bvx1siTnV8oQp1P5nGrJbjtYY83S5CuBECibaZCl9MF0tw+y9s5fI0OWGrVHNrdfnz
	E4FZXTyUyEsHbeCebraknZP57pwuS3oOk4h2JMEv5AbeKx2kKfPb5UEmw/3tSlRZrKM2Gr571Te
	BJVDQHcmVMQrYaC6EkDLpOZ7mmka7PGYN12oOIuE8T1s0SfZOll1Ih+BvgA9M3M7en5+tHjwTjm
	8uwWiIbfxQI/uAjLZXh8Q6ensHiq8kWnO0OFSdRF4RRB2MDRA=
X-Received: by 2002:a05:600c:4583:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-4854b0a4911mr125707115e9.6.1773329732270;
        Thu, 12 Mar 2026 08:35:32 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:775:4d0d:d776:157e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm246968205e9.4.2026.03.12.08.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:35:31 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 11/11] arm64: defconfig: Enable RZ/G3E USB3 PHY driver
Date: Thu, 12 Mar 2026 15:35:16 +0000
Message-ID: <20260312153522.1131675-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
References: <20260312153522.1131675-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Mar 2026 15:35:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22367

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 4e9153de25bf3c89b90f63cb4d155abc7f1a2117 ]

Enable the RZ/G3E USB3 PHY driver on the Renesas RZ/G3E SMARC EVK board.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20250916150255.4231-10-biju.das.jz@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 59b72226b5be..9ee6d08ba8cc 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1564,6 +1564,7 @@ CONFIG_PHY_R8A779F0_ETHERNET_SERDES=y
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_RCAR_GEN3_USB3=m
+CONFIG_PHY_RZ_G3E_USB3=m
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-- 
2.43.0


