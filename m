Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17304104BECF
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17329.1773223510414627498
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=gDcbUiZD;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4327790c4e9so10904774f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223509; x=1773828309; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIJMtk4umd+TrXIVGS2cMeifmpx8PCBIgC8XyRmrK9M=;
        b=gDcbUiZD1iXG5i86iSEm1qFS0iBwEDSDFV7XTNVDdyoM/1w/7nFrGVdJLdbLom0iSO
         tQ9dFQCMZslXJrUOswNIMNRYnBGDZV6GBueuyU1I8RZpYEaTOyFA8+TATEmamPCCzVOj
         vmoSjJQgUU6D5t084Esu121TqCIXT0g/9/oURw9reY7J2J3NF4fj1e3J0RT4+wKSzP8R
         hzOknxdlexf3ZThK9m/ZL7fNI3Lyr0z6fH031hfpakZ3Hew26y8blTSoFT6yf+RbcsU3
         CgjjgbGHlu71jz0+LJqaW/fl/sZT/ZJaCoGTLpOHhFWWdLJycu0qDBUJ4RDiVQrpWbIi
         369g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223509; x=1773828309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pIJMtk4umd+TrXIVGS2cMeifmpx8PCBIgC8XyRmrK9M=;
        b=HOkEyBEC0cza7E9oQz/d8b3JUJoKepVHL29JgPT7DJPUykHsq98c8WVamJcLxsmp5p
         PTQTtphbzLoinbUFo5AcOBPfjJ14/ZVYeS06XMaEu4OY+ZNyM48Od75RGounPifDu8z6
         iFWp+ukF9RaO3o7j9Rg9DKU78ovC8jwdDL0Gplqeezn2Hb0IyRGVRXuo7AwPO8rCRqdQ
         KJTkXZgfQs8/IRRAesHII6L5vXMekLqtmjjtOKF1EW68X43q2mR+qxEsGuWqm6sCkQXi
         HtJkLk6M06CJWEigTMhtg1ddlKfhyQSmqwHJowJ/Ik/UVb0X8gKk6enIZBTsF7pA8pDH
         tZOA==
X-Gm-Message-State: AOJu0YyP/kBr6Dz+E3dDjAISFXmapVZue/D5DhyJGX6v4loZSKb1BhZE
	0hB4Zj6JAOlNuVXjriwcxDHhppaz41Znygtqznc+1x3LetITpL7MOGZEm+YpkA==
X-Gm-Gg: ATEYQzzVwTS8f9unKrs5vmYQnS93aViM+8bJ6wkZEe84mIe7yVF5AkpmSLs2kJB3xXH
	qn2qd9s/Duyad6q8xPAxfjCAfpeR6yZvQtNinHqj9fFqC+4FfrfFM+d5OTQqmbMSyggJpffqzYK
	T/EaNHtHeufQjo0Z3Ms5nTPiesPS8Wcrc5IbeUN+Q1isTSTkMR0gqiCbnvDtqiZ9S2jUADGLIW6
	g1s+jmk4GDynWrN8ZiBvQsQevo+DKN6n42m7m+7qrWYSbFWEd5suUQU5PKwnxUor+1ZHY0etzNI
	Y110bdeEaMdBQd8af8tl1X3tGMVGRl1UaI5+VluA2Kt+bgey67rWgpiaYlji39FI/vWEsDpK+tZ
	X68gN87a2rVgSqWZdat9YSYP5xnTdkevZ6hOF8eidbFWKKzQEjYuYhPKv3VUC5gI+cewUEiFfOf
	cZbn3dWMEpqn15W2KkID+RPGkYmgLCLLE=
X-Received: by 2002:a05:6000:381:b0:439:beee:43b5 with SMTP id ffacd0b85a97d-439f81decdcmr3840147f8f.3.1773223508182;
        Wed, 11 Mar 2026 03:05:08 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 14/27] serial: rsci: Drop unused macro DCR
Date: Wed, 11 Mar 2026 10:04:33 +0000
Message-ID: <20260311100458.162447-15-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22260

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
index ca593665b551..0ca9d38fe8d2 100644
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


