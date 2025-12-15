Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E0D5B174
	for <webhook@archiver.kernel.org>; Mon, 15 Dec 2025 12:53:25 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.47823.1765803200948518177
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 04:53:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=bXsqhQom;
 spf=pass (domain: gmail.com, ip: 209.85.128.48, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47a80d4a065so21510505e9.2
        for <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765803199; x=1766407999; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny9t0fLb1p3TClYBHc24K9mJq7W/LHDSvT2EQhcBPG0=;
        b=bXsqhQomb85CjJM6F7rIbt3LK5vDahRD3NJbNW1JFMtqK55UwbzEi2p2D3QRED1dFo
         V08bR4KiM3mHZbwjT1YbO+ApL+EJRzpTBEz8vOKZrbdC+xBB5/v0l88tm/lLq3v5gLWL
         cpGmS1SS2cJvGCRMleZL6n5KQluKdxxbAygpPACTeT4OBuVLDdxn2dEoSaz3fpI7De0f
         V1cSGYlQAKCYZ3OuVFwoNVocZnpnKBNhCu7t8r8pjLOYK9s1MYk8X5SvmpNuGZuGaY+r
         bqIzofbjmxIPoklgRNNKfaNUTCgww5sDJiFc2/RrNm0F/nFX0l8FOFE+3gtBzHlMc4uk
         Ok8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765803199; x=1766407999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ny9t0fLb1p3TClYBHc24K9mJq7W/LHDSvT2EQhcBPG0=;
        b=uNH5RGo/aWS1oyxuezd4xkezNsNI74PCXlq80m5p2TqDjP2AEEgyrsCwgmkuOlapyv
         2DGbyTEKVEEIfLCg93MUi/n+IeG8bsr5y/PQ/3Bo5tVRJz2womfVPt7wEimc7j4FpoaQ
         JT/awd8qHzSapzHTEt/w1B1vGmA9YytWi1APPuF8/m+VV02FIZKVRYooVVDEa1y5QrHk
         r+aZ7qXIAVKW2cG4BriCzNZd8l9xfHbjt/FXXR+sT89u879UFZ/cA9fYOefwbdoYwWvq
         FgenGO8GSPmQecM5xBS1sfvPpSmrXMX5vIeZPznTCYzz0162U0s/Rp+RqSWzH8Va0e8w
         qsMA==
X-Gm-Message-State: AOJu0YysYR5Xlz7In59qGhc/f6sW91hGMayHYGCKs4sW/Urbuz6nUhxZ
	D9lhz0wS7TAfo0DrTV6gncoKYcom1DXOjr5vUxDmbbzf/gsM+LS4bGyEdqwWkQ==
X-Gm-Gg: AY/fxX4+vpPj1/1gGQGP8pOat04Pe3B0Uo896KjBUoJ19egwERQW6nV13gMY5YEgd3D
	KyT7weFCvHlMcsMkduO7RRCinNwEDkc9+ikm4dGJPXKLirv8KSLG83A25sfv2OdM5Lu5kginpM/
	OcpIZw/A/tP+PmhU4IT2s6LURy0tvfwhNKxQCPu5I84ax83P9ZLjaxtzPO/lBTJfvutOpHwhEix
	XFMILRpTaPsNQv3S99SH545aa+gmGdOsoTReVo4zvbeVscRCEIZxDJJ3lbycGrVriFapIaovJDb
	Xyq/2LG1nfHWbPodHQdml6Af36h5S3cDJZb5WqxH9x/BSTp8+gNO08aUZYfCeEJGA4M1WwwxH7R
	Hh9uSd2IZLZ0GuRRP0tG1fWz1PdHgybfam76zXXVr3IhNgeqw0dhSG2dRQHmBeg8x/F/fc1GL4b
	v+S0t8PvDmellFYfVIlKM1iee6y5VkOVwsXC0=
X-Google-Smtp-Source: AGHT+IFEvURxpHa8T+4f6u4KQBWArS5mqj1XhVQv9uQYXhbtNPXji6cjDl71NanhzjSrrU4Mu2nc/g==
X-Received: by 2002:a05:600c:8b83:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-47a8f8a88f6mr107699135e9.5.1765803199087;
        Mon, 15 Dec 2025 04:53:19 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:73b2:9197:2aa3:716f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f268d459sm13820577f8f.32.2025.12.15.04.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 04:53:18 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 5.10.y-cip 3/3] mmc: renesas_sdhi: Replace magic number '0xff' in renesas_sdhi_set_clock()
Date: Mon, 15 Dec 2025 12:53:02 +0000
Message-ID: <20251215125316.137879-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
References: <20251215125316.137879-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Dec 2025 12:53:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21059

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
index 37b8155c93a0..06c1fdf51250 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -209,7 +209,7 @@ static void renesas_sdhi_set_clock(struct tmio_mmc_host *host,
 	}
 
 	clock = clk & CLK_CTL_DIV_MASK;
-	if (clock != 0xff)
+	if (clock != CLK_CTL_DIV_MASK)
 		host->mmc->actual_clock /= (1 << (ffs(clock) + 1));
 
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clock);
-- 
2.43.0


