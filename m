Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230DAF417EA
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15533.1773066361181048447
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=QMle4dzL;
 spf=pass (domain: gmail.com, ip: 209.85.221.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c56e822eso6198619f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066359; x=1773671159; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4bVutW1Xx08m2y/xK1RxrDy4Traa26oh1t5RPxqWMs=;
        b=QMle4dzLrxPjf1UH+59BgSWSZU9JyVKMwbK6nlBhZHoDf5Wji8EM0FwypJynl+w99M
         4ib7+oLk7WYld1DKhvvzHf9FEhmLcdtkhrGf5w72uxaCd6B3kGdxtC13uNFdl6JICm8t
         TSLTHjs1icoFPnC5e+0DPbj7Dim+Du3GEPkRMy0oQmjtz3D0eThX9B9PBAWlO52Ofc1A
         xUnOJMeLvvfF1kB5MDpiAHeHty697e9m+E/XP45PVffM41sO1EDGqzlE0036LVTwTrTN
         nLpwxg1ensflYpyhZdopmn9DYSxWrOu3sj6GAfPG5aXkxZ7ACMHbcbnntevf4b9ZrM7z
         jIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066359; x=1773671159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v4bVutW1Xx08m2y/xK1RxrDy4Traa26oh1t5RPxqWMs=;
        b=MtJ86NaKnwNXYIDPLPRlDbDrAgHxFIphmwE1c2AqpfxABCqMddmoD48Plt1nGYihxQ
         t43pvkH/wQO0tpn81ZMgTPmLBAOatBhmheceFG/1sRuNz3hN21W7rcWYSBRtIJLtDYQG
         eNxSYsaEoxNInNSSuNnDyNzpTro6VAtW+QpYC9dmIGPeCOkxdkujX+qXBDu2j23xSMy7
         oBuGF8UWm0JNlfDXBEzP8LR8TTySHGqrHXh7lRcbrRAwfrV7ZdQThepuSLYLt+cfnPrZ
         +S2OGbTcLojuvxU+s141/Ug3fYedj95e9v3/hdcLvIuBiFfkYt+SjHY2dc9tLLbjnulD
         eyqQ==
X-Gm-Message-State: AOJu0YxBRf9fAg7skXhDl5n2V7W72vJm4G4apMdi4AWVFj9NpLFo3txy
	z4/Dr/2TNzCvHOG/ifVq73ID6dlXiQ570oZr05l1GtoW9vMio6uV7U3v3BeMJA==
X-Gm-Gg: ATEYQzz0S6B86PsHr8Q6AMpK40QY/8JNPLEAizbM1LMSZQH1nyThIEPtDA+GEXEsB4m
	5wMEpm452qO7CsZbW/gtZAnd0AALS9Xn4VdR6j6Lrw+cdTNyIdHBMtofLTeY2vmba+Frp9wjLQv
	mLnsNUoTvEvob5qGIeIsoMp2ekR9sBXCJ0CcmuUHJDlKLQeqIp0tUCgO7g4t9Ei34dDHg986No5
	cmVusHWm/9fVFfC4wmK9hc3hUW0o/ew3YuqvvTpi0sehtZa/Ht1ryN+Sc6L2G7PzqIXSGNasO6w
	V3n47YBY9/zAqhTSnMTP83S0eTQpPoeq98piryDD8ONMn0kh8ei8rCudZEDmCHPRuyTPZsZ/o+W
	O9cUi8+Rqv9Rju5w+KouR58ICJejxpZRfUJt1VbvajKdtGowNumJP7QXt6PGCwRtN6hS0htMIlM
	S9mrinqzFMbQF8/mRCxc6Ff1DQamXhYp4=
X-Received: by 2002:a05:6000:2388:b0:439:b3d2:3766 with SMTP id ffacd0b85a97d-439da657049mr20306638f8f.19.1773066359069;
        Mon, 09 Mar 2026 07:25:59 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:58 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 14/29] serial: rsci: Drop unused macro DCR
Date: Mon,  9 Mar 2026 14:25:14 +0000
Message-ID: <20260309142549.987737-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22182

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 36816a033dd41fda415ae0696931d6bfe87671a2 ]

Drop unused macro DCR and its bit definition.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-8-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index baf4eeb46e5f..92c7fd605b05 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS(SH_SCI);
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS(SH_SCI);
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0


