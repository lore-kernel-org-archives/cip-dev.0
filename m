Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B94104BED0
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:17 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17330.1773223510654844747
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=X1r3IAa4;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439d8df7620so3648878f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223509; x=1773828309; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cWqBdHjrghcXHEJFIY0W9fiI7nPgtm3iJiNvPC4Jw5U=;
        b=X1r3IAa4/i3yn6qCCA44dwNL/w+bMm9Bk4r3PdRPgrbMmG7hRyaKWCNK1OhRm2fkzR
         8oq7hNiECQBj+t6WUOQi+0nEt/Oru8v2OUGUWbHwgb2nNMUaOw8u3eN2RC9Goqprt9rU
         kEV3/qqadPm/Lh+leWx9y8j5+OtywStHk5srJOSNOvIQdmXBw9axC9gITgAYGmX+LT0n
         XcQA0yLeZRCK3SJ+ge7gjgfQMkW2QvHOQRCQqxPpiMNuWXYiDG1+XgRKCZXOy7f3IlYX
         XGoNK0V/krCQP8KnnHG3PKBuI1SDt8F43J36MEhePD4y/8PbMeC00U5gwgH4NtwuqPuQ
         w4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223509; x=1773828309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cWqBdHjrghcXHEJFIY0W9fiI7nPgtm3iJiNvPC4Jw5U=;
        b=t6RCvujX56i30tMUEnRQMc4dz8OmcJxrQ5HjUFc0fgOnlik5TfZlEk9zmQ+2BYqARb
         90uG8iaorjA7c+mp/C66ZnTyUCTd4hFQXm4U/RFm0Z+ar8wF/WtIclGUKah4NJOGPnTV
         MadpcEvBm8NYrb1uqNgMKbeCO5rwX7PHf46NcGfNWA9/5OM3FJJRq1xUrgn27wEnMXVL
         A0boJoTeYifyNDY4YBVImmOHGW0ge6DcZd1SAI3KeO6maYRseOS87xZuFuHe91Vt7cjK
         ClRcM0wLuvFZbsS5mAKdca9sUm7CTVdEe6rPNzjtmlpOtBo4Ru+cq3SkwIuEE0hNjQ+n
         cRzw==
X-Gm-Message-State: AOJu0YyLd6ODSzNyvbPQZKOlesWvMT5icymA1eZUfjx83/iN9R+T2nTv
	eBT0e0Ryfo+0S/dE78QKE7r4Wte56TEiDWzjgoEPrFqvvrDbrwYUwhBCZ0zuTQ==
X-Gm-Gg: ATEYQzyui7W+QUVYCPP8/FOmtrehgxoU9MKHr7av0HU6swY3rPpuc9OLgW+AxJE/Yyl
	XohD1fz80B6/PTuy3oM1w9mrqvEfD0H7QOmR9+J/mr38vRZusVU8aDoYywPhg+fl4gm3QQrBxtA
	A3xHFslTBwSeZtFifkCdh5qow4IfgxZiX/0tmtDLmejTOxH93gfW5I4jsNKamNFDoTU9pH/BuMO
	SA8mzdyHGYldTvHBwwnu4SUSVZtuCo1zXTnI8BDD5Fh4qAWwTg9hNBoTqGo/RjW8htLbc8o4mWT
	EVK/4OZnyNAFuxK7PByYoRYDpSLrNm6xQIvvmgYgTVUsrhI6uKQZMDgUC2hh3DZ5NcC9MM11Wxo
	spJnXPLx3SAiLheXyqP6ORAJSj1zYjh4tSuA7LWj2ec5QXV1K9nRgbk128PTu3IxyuYrl7bvTyv
	5NAovMf981i6WYLSwyAR1Hc8nut1ZlNUo=
X-Received: by 2002:a05:6000:612:b0:439:b636:1fa0 with SMTP id ffacd0b85a97d-439f822b872mr3633031f8f.42.1773223508738;
        Wed, 11 Mar 2026 03:05:08 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:08 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 15/27] serial: rsci: Drop unused TDR register
Date: Wed, 11 Mar 2026 10:04:34 +0000
Message-ID: <20260311100458.162447-16-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22261

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
index 0ca9d38fe8d2..fb419f34f35d 100644
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


