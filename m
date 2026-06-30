Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24677C43638
	for <webhook@archiver.kernel.org>; Tue, 30 Jun 2026 11:48:46 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19419.1782820125261347829
 for <cip-dev@lists.cip-project.org>;
 Tue, 30 Jun 2026 04:48:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=EFv0LN9G;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47362928f65so1776117f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 04:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782820123; x=1783424923; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YAR5WEhOfOkVJ+dcK6AIyjk6yCf8j4DyX/Ykf/FsNa4=;
        b=EFv0LN9GGpX7x+HH1Gqx2gYHw7sUvtb9DrR1aMclC9cXx1r3Nz51BIlkxvZvPUI29s
         q1gIvc04uijCkBXYZ2CT7CI7y8OddBX5CXDwr7RoeCTcRZQuB9SGh3cnjfZlpLT81BI6
         XUPNoO6GOBTjtX1m1i3zAaHTbxwFBfkIMD4USxIgBeYSbTeaKumZHTRhlLmoNUUV34yh
         xzp9IZ72AfGh5N0fSXc6NYclKL/TON1USYcPz4rIFO16R2pH9KpEKROKYqEJ8CMXLkrB
         gjOS4GyFw4vCTMOucpz6d8EmRCRENkBeNQRf7aUZmv49+12hwWdCnBmP9U7ggVTyMfuW
         mPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782820123; x=1783424923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YAR5WEhOfOkVJ+dcK6AIyjk6yCf8j4DyX/Ykf/FsNa4=;
        b=fMbgyUQ3kUDwki8Av82/Wy0eFVK5IsJJMfzMIhFnMybe+5+C6uFRuGaGkTlqtGPQEY
         Vx5aJBFm2jLgZbqbWMfD/vL5SSEKQsGSWlED+odu9+Zhn3nBal+mx2OyySWCGhkyg7kr
         mcskfHKqC+9Iyw/3hMAWTuoSJoJzP+v8Nto82VzxlBDPoTLNzZeh1YzlJyGJUSX/1p6y
         23WtVuqpirGaky5Mj41K+alaW2GZmLlLktKBYrZ15QC4wHzQokS7rIQPEHdOAAicluDv
         x/vNjjfu4oooZt3AvuTJUpI2hscbwehDrYz3OLiU0Wud+HxMBWuyWgOArulGteec6Acx
         E8dg==
X-Gm-Message-State: AOJu0YwGIfUbf49D1i6eeeN+L4n1PCr4igZiJoVTdchKYkDfgNr+UOqj
	L3eOsxGAQTiQzg0mlG7Hb/roi+kwDf3A9cZ4boTbj4RS9Lf1Cxl7pBReYsFoBtCp
X-Gm-Gg: AfdE7cm7ynoxpVs012/O7crXehbLJiL9nYwz/BFZYkx0mL3v0JnrZXkCPZYZFtSaAf+
	8KSMD4tdQkFxRJiJt0491si5hWS7b2lelwpIZvyHVYgaiUE4SMZsu7uHIOmuB0PJ0nSHii3AKGA
	IU/W9Z3HrYEg5roiG0YjnyBQ6FVpAmJ90Y1QFc7NtCely9ZHfklhYqe0aKqoN6Kcx4coBstuD4h
	KoeQe4h8mk5zWN991ZPCfIGv/bZSeDDgK0fpAPfqzkpEp39dBkgCbRg+MvmXTKFOoFOKXXYawnB
	87JLrB7+FEJj6uH+exgZlumQ+E9sotmw81urHS9ounOzunr559VdopKRU3iFZy/V5RKHGcr09xP
	Z/wcjGiyxdgfcGfJERWQcqdUW/BjCun4ncDKtjlS7SciuRUyZ6SBqHYblKL54rnlF2yO5uCoY7U
	AooGPwJuZPnkQl2qWTAtJtC15dhmCvF4NTp+6aWJL6tFgSFt1Q
X-Received: by 2002:a05:6000:25e3:b0:46f:7d90:8128 with SMTP id ffacd0b85a97d-47551737cf2mr4009489f8f.14.1782820120140;
        Tue, 30 Jun 2026 04:48:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:3f6d:4f26:2d9c:ab4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4542sm7343031f8f.10.2026.06.30.04.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 04:48:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 06/39] net: stmmac: dwmac-renesas-gbeth: Add support for RZ/G3L SoC
Date: Tue, 30 Jun 2026 12:47:25 +0100
Message-ID: <20260630114813.92739-7-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
References: <20260630114813.92739-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 30 Jun 2026 11:48:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23330

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 1ba377008420a63ba2cdbb3f5d1f9d30591f6c52 ]

Compared to other Renesas GBETH stmmac glue drivers, RZ/G3L GBETH IP use
the version Synopsys DesignWare MAC (version 5.30). It has an extra clock
compared to RZ/V2H and has ptp_pps_o interrupts. Add support for RZ/G3L
GBETH by reusing device data of RZ/V2H and can be extended to add other
functionalities later.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260131161250.5047-3-biju.das.jz@bp.renesas.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
index 62a33b3fb00d..3233d979cf32 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-renesas-gbeth.c
@@ -213,6 +213,7 @@ static const struct renesas_gbeth_of_data renesas_gmac_of_data = {
 };
 
 static const struct of_device_id renesas_gbeth_match[] = {
+	{ .compatible = "renesas,r9a08g046-gbeth", .data = &renesas_gbeth_of_data },
 	{ .compatible = "renesas,r9a09g077-gbeth", .data = &renesas_gmac_of_data },
 	{ .compatible = "renesas,rzv2h-gbeth", .data = &renesas_gbeth_of_data },
 	{ /* Sentinel */ }
-- 
2.43.0


