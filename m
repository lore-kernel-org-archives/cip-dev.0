Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1552FD8755
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:36:57 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73936.1773747413504453496
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:36:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=ghzzdJ8u;
 spf=pass (domain: gmail.com, ip: 209.85.128.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48539d21b76so40255765e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773747412; x=1774352212; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0WWwPGw7ZvZfsDuyxFOaMvVkfmaSnnB/OeYxtV7K8U=;
        b=ghzzdJ8uIZrZsRgoRSSjCvW04oRrq4or5pakOAt34mSRNX0XiYcM+ZNqe5P7f5ETFK
         lSiMcgkJyHo23lrtbjR61y846OUxYW7J4k2EgVjCHfdGm/4s7047sMX/wSCughueh0i7
         3GZIvR1FO75OJY79uuA5yTDluQ8EzMvgOZV0/xHkm8ZTLGPY/AFVFN2XtAqhjXbMqz4h
         FPDu2WzlwGk8ZGsBbfAOh4Qy/rQE2mBmcWKh9Pw5iV911a+Ew2jEBhU1lAyj7EOJoFNa
         BknQv4uX/NZsgaTsiorHZqly4UwQcf7RleZMbVajVtxRE63oy4X/45r8YO0rjFieRRUT
         o4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773747412; x=1774352212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I0WWwPGw7ZvZfsDuyxFOaMvVkfmaSnnB/OeYxtV7K8U=;
        b=ZpJBp6HmfPvFFzY6VDyb06606n5M2y132O75I/JvUBFZ4LYpqU4vWWoOYRWq7XapWD
         hk7kYQGaoZMjc630TeZjE8Ktsy+BGqPFk5KEdb+uCVSEkVmbw+HnUFp4VTCwulAAA0DJ
         NhLqEh55eR31cU+KS6OuaS0/aAKYx3uw2xlsD5fgSFcZ46HobUiGtrVwzvxhycJe0Bf6
         y+F/Dcdk3LO2co40BZyh0F9oEgG5AQUd6n7A+qfpo/PqTLJV8KJcPNwsFhdS7oIAtdGQ
         K380KB2oTX0l4xCyantALDi9b5sdKkxr11omXC12B/+xoz2JnBPT+SqaADzcPWD0rwnm
         84lw==
X-Gm-Message-State: AOJu0YzqcYT0mNwqkEprMj0cw0fURBkcRCxlKIWEw0iCtmkM6u2XmSub
	sYOdCMkGQCJBQe+DA3zegJHwLpTGymTt3ZG8rY4zx29xtiA3P5S6OnBXiRXTmQ==
X-Gm-Gg: ATEYQzyFjeNL41cwAwO3LYU9m+Lb2Tr/6zRXDrvIjWf9F5owkG9bt3bkrRd9Bbu0w6K
	ZVCvF74105LK21JjLXRjUQNk5q6OpsgmUmbtrHN0LkEZ0zpemS2XJIgzDyl5aXVjRMICrTeBVtc
	dC1Ix2qZjxuyPlchJ31Kh/yBgqAM6feOJbNJyKYQGZt5mt5z/XHkXdCW33uGQ+mgAQWzZByMVrU
	Lj4QmHhiy767M2BJ2r4kAXWwHfkqMsIfdhC2j3iISWFeMjWN2m6nVrNcFhlH0u9ggxfQRFLfQLM
	Orpn2YsXUi+C2RPvKq2rKF3RRsx9uk/eeTnqvEMH9naoAccuUKIOEkviKCc7d9yCg660h8YfCbE
	MjCKVuAGuklvosKp0LuFNW+k9A9KVB0rPlt9bNT3kTMB2smNQn6dBlsZlKwX2wOUFT9yKH4twUo
	rdyIsA6D6DNKce30PQlOr/CHiksQCCsf3Ciof368a82xaDI1dbdnIFa3ex50g=
X-Received: by 2002:a05:600c:3550:b0:485:3983:aba2 with SMTP id 5b1f17b1804b1-4855670b64emr303388475e9.23.1773747411608;
        Tue, 17 Mar 2026 04:36:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea97af2sm57469965e9.4.2026.03.17.04.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:36:51 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 11/11] arm64: defconfig: Enable RZ/G3E USB3 PHY driver
Date: Tue, 17 Mar 2026 11:36:38 +0000
Message-ID: <20260317113643.311192-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
References: <20260317113643.311192-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:36:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22485

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
index ffdd6bc3170c..c72372dd4f45 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1271,6 +1271,7 @@ CONFIG_PHY_QCOM_USB_SS=m
 CONFIG_PHY_RCAR_GEN3_PCIE=y
 CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_RCAR_GEN3_USB3=m
+CONFIG_PHY_RZ_G3E_USB3=m
 CONFIG_PHY_ROCKCHIP_EMMC=y
 CONFIG_PHY_ROCKCHIP_INNO_HDMI=m
 CONFIG_PHY_ROCKCHIP_INNO_USB2=y
-- 
2.43.0


