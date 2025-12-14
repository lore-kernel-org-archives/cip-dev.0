Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22653D5B16E
	for <webhook@archiver.kernel.org>; Sun, 14 Dec 2025 22:59:20 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.24306.1765714591839628296
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Dec 2025 04:16:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FwPKiqm3;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47755de027eso18556185e9.0
        for <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 04:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765714590; x=1766319390; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZnBIRXBG+UMfBu0l+e1/iwDLueHSBVjEM7HflRVQCU=;
        b=FwPKiqm3noHWIfPpixItOw+T/kKw3sX6KzVgY92lJDzvG7sCYphnmPx8Pks0F+HOLs
         KHnmxkGK1teAVSot1zi7NfCWGZtwUYPNj2ribnU8DpWVi+v/VYlzx8bPMhO8A7q6QNAW
         d2FZWqrENU3sHq6LPRb5hWxLQpJy7eQ8MXU6BJx1QT1xGiK9cD+QFYwH29akdkUL49Tq
         sRdw5F8UAJP0ODJ3L6z9DXjt5mDPbCbV0c03j7k2xvIjZUt3j7ojpi6i0B0QtTuZa+yE
         tHefkyaNvWsD/rCjOTiDRoRXDcY5FkwENCu36GS8K1/79K70QK+N0USsQsjK66ndi+33
         8woQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765714590; x=1766319390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gZnBIRXBG+UMfBu0l+e1/iwDLueHSBVjEM7HflRVQCU=;
        b=h1Rz1vEigdqd6imBdN6u9PIBdMzD0eTXaiH6iFyGa/O7bw9DT6GPyxxLRy0HKC7yjM
         RWUFnPq5suL7cOqVvHYc64uPX0IwDhmsrVsEaB55k9at2y0PxV8FULgRaLsydbzhTYNY
         fdhFqYSf2ezba9/fzNNecNg1mMMfnxKr0jL54dnYF6bD29T5xnN/Erl0nKgtyT9wRyeV
         uwqIMPNV+7Wz18tBsqhgLCgOvnMBpjiS9V7NEeXKOG0PZidjoKhilgqny1N7+kYJj96m
         fmSJ/n+H1EeUgb2ptPtL/L/g5eXABvhUn1o2eqtGU3wycay0AHR+rmIkLGz/MkjU/3Ip
         Oflg==
X-Gm-Message-State: AOJu0Yxk2WFThryT72LBVRg8vsbWP3DQbMOSrvG/PBuf9gunHvhVHcLf
	HPiWuOZtzwSB/KNP8aYDXvwdjjaTzdudMzz+kDMzeAoM2QKC2nthfrTB+M5KSw==
X-Gm-Gg: AY/fxX4s+pTvAZ9bRH/9N+Nu9JW70DIuBb0bnFAOfIwlIO/1EZ0gMvdOchqCqnmCn6W
	/xjdrYPsPmEjqlx5nqd2wA9+fpwWV1kqC/a1LtUyvjd3eQ81IM4hp5KE952FbI0vAA6iVcJfwtu
	uTZnsGrdYYbJ1gV0YdK1QeFOiatJUvSn6fs47TXumU//GasAWD/2nVOOvOsoaXxgH3R2+7qyBuE
	I1KlG+Y/hWQAfjTMeXbMELPqBNCTwgsir82F4qxPJKK1XPPeFuMwGVhV7LJVQ53RepCJ4uGd9il
	rYZw/8l6271Ad7bvVkDBWp8Xw3EH4o4XbQiF12EXMbHn/eQs7+kS/qQ9M3XTg0v6so38OAh7xNT
	Ff6cGq7OW4izNClavciVYvSHFeYtHM5CaUyapXA9p4+e1ywH0NJkZadhGriiZtuuaMwsNtYUEGq
	KGqyfe5Y3bNoN2/v+2zySu2sTQFboQs56pPRFIhAVsl14cJVE3szkgMgnv/V5qHoVjzOLbjDPHo
	sMXoeU3sA==
X-Google-Smtp-Source: AGHT+IFTVJkMehG3imVgOxTDrzg5ffjcSDQfe1kUWGuDKqfCI7emX804Kj0qsu6nhMJIa/Ns4Z0zEw==
X-Received: by 2002:a05:600c:444a:b0:465:a51d:d4 with SMTP id 5b1f17b1804b1-47a8f8a7570mr78085365e9.6.1765714589956;
        Sun, 14 Dec 2025 04:16:29 -0800 (PST)
Received: from biju.lan (host81-152-191-146.range81-152.btcentralplus.com. [81.152.191.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f3352a0sm49112485e9.0.2025.12.14.04.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 04:16:29 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 3/3] mmc: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_clock()
Date: Sun, 14 Dec 2025 12:16:19 +0000
Message-ID: <20251214121627.4656-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
References: <20251214121627.4656-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Dec 2025 22:59:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21026

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 5d0702dc9c2f6700140b7366dd9ec6c78cde3aa1 ]

Replace the magic number '0xff' with CLK_CTL_DIV_MASK macro for finding
actual clock in renesas_sdhi_set_clock().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250820104808.94562-1-biju.das.jz@bp.renesas.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f123fcb8e01e..8b898d0229c8 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -223,7 +223,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	clock = clk & CLK_CTL_DIV_MASK;
-	if (clock != 0xff)
+	if (clock != CLK_CTL_DIV_MASK)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
-- 
2.43.0


