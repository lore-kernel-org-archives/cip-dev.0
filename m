Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D42EFCD9F
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15649.1773066361953706402
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=FPxhL7qC;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4853f2826f7so7449935e9.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066360; x=1773671160; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ms/bqzjYcNshmqyVwO9xS7g4SKdmIol7DfSRDATe2iQ=;
        b=FPxhL7qCpnGcB22JclNh45J5Aixbz3RljhjQeRrjXbGCHixXaWtPh85YPCMFbgbGnX
         nuirJ/qksZ9Y4d12hhllZXSy/BsgII/TVStdPPx6lnifcWvMFDThTZHRd+STNG+XczIa
         bWiGZIM6jV8m04luV0lrAEL6TB57C+2+ncWk3ZYFew5qIJfElCGyYkIRqqTHUwBDMaVo
         qEWA0QT4rEWAyq9Y7P3u8pdrgZ68qVmnGVljflOX7qQX3s7j0iJq1rWp4xePNh8tx+cx
         NMsviV7RfqeubnIyWQglojxs5qv4HubPlw1UUZlbN+p5nhJNxkmli789lCVwR+XPY6+J
         mmqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066360; x=1773671160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ms/bqzjYcNshmqyVwO9xS7g4SKdmIol7DfSRDATe2iQ=;
        b=IyqOLHXp6CvsgwjmB8NFmjZb5swga0TAUUuluJaC34K0QUVN6onMh7pQt47+Rs13mK
         izQ8X2as9DVYch5FcQ8yzWYXOT69ZJwwSa5tr20zbti4k/w9RA0n/ooy1X22LknZ1q8I
         JjDdlyuyfMhwgjxn4PjiKmXWwg1/GvQXwAz3psXE0SlmNSIV9c1144TxmxZyJdCkCpIB
         MIpW9uJdmP7JGa9a3DOuBXPucKbxKrxCsUyhng/jwdovLQGFT3Vn0fkgwkOUn6RUwYwL
         sxFyADfeQTe5qVpZ7H7YxwkHLhBMmHyacFm8VntImqTNGhXxLgKjZiGK0Icvsq27MSf1
         j3+A==
X-Gm-Message-State: AOJu0Yy1toPSWhUP1bGoq4VxcDzTSAV3oW/c58TMdCbz42k6CGz1gK5o
	UtHJqRdresonLSQdOolhLMIqEV0xCQd/dE9AvvHeOaiYCwbmDiIvPGimaSiSBw==
X-Gm-Gg: ATEYQzxR6vPTdjby8O5EdJMF3ZKHDgpz+SNDAR+oshNNN03ojKY51pEbM1zXaOlPtHs
	GF6+0jd5iMOSFxr0UFoUBFuvQlT1e4bIbPA523B3xPECtxhgxU8Js/uEs6QCeuqlhxXx+uEd+CT
	d04UOCX2f307sMf5O/TcYQZQXMUeAPB1BfJmWbcWyBfsc/SzNsEsnqlFc/z8JSrKBSqFXMpg/Dc
	ZGt+yp3eVwkl8wMER98tFVgly35xHAUMhEOwV3W+dAzDs9U6fMXWJkTASdtXyslG5tT2NlxyIwo
	TPPNYj7NLzgElzfAOjQzzdrmZrNq7XzpE1L1pRdFnA2m4C0rTjjAYj8Oi+tJPKvnnaXdazlnjBE
	vuh3xgLarD/GfcJ15YWPLV4HjUf12LfnItgcsI2IAh1nr/9RLknGxnBkGdmqp2cF8w3/Gie6uF2
	9rlEEkWD4yic29n0Ye5HxungpMB0Ts1BAh7LShoNcD8Q==
X-Received: by 2002:a05:600c:4446:b0:485:34b3:8589 with SMTP id 5b1f17b1804b1-48534b3882emr99739465e9.31.1773066359795;
        Mon, 09 Mar 2026 07:25:59 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:59 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 15/29] serial: rsci: Drop unused TDR register
Date: Mon,  9 Mar 2026 14:25:15 +0000
Message-ID: <20260309142549.987737-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22183

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 507a7ba917cd7ae043ba05db02089b152ae0aaa8 ]

Drop the unused TDR register-related macros.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-9-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 92c7fd605b05..0d0202265a10 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -35,12 +35,6 @@ MODULE_IMPORT_NS(SH_SCI);
 #define RDR_FPER		BIT(11) /* FIFO Parity Error */
 #define RDR_RDAT_MSK		GENMASK(8, 0)
 
-/* TDR (Transmit Data Register) */
-#define TDR_MPBT		BIT(9)	/* Multiprocessor Transfer */
-#define TDR_TDAT_9BIT_LSHIFT	0
-#define TDR_TDAT_9BIT_VAL	0x1FF
-#define TDR_TDAT_9BIT_MSK	(TDR_TDAT_9BIT_VAL << TDR_TDAT_9BIT_LSHIFT)
-
 /* CCR0 (Common Control Register 0) */
 #define CCR0_SSE		BIT(24)	/* SSn# Pin Function Enable */
 #define CCR0_TEIE		BIT(21)	/* Transmit End Interrupt Enable */
-- 
2.43.0


