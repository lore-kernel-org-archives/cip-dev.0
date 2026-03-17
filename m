Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085AFD7087
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:33 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73581.1773746249569519010
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=hC0v+743;
 spf=pass (domain: gmail.com, ip: 209.85.128.54, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-483487335c2so53403035e9.2
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746248; x=1774351048; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TxY+n3NUbtzHhLpeuI5pgVnLp6Cb6p5QvJzeW9BsmZA=;
        b=hC0v+7434G/HhD5q7rb2wPlrurwm5EweUDWrBGkI403guBt+RiUgN2IBniUsBOgH64
         52ZyuTKC5b+9HeVkuOdPbbpSzUza+7Mpe2aJ+wi5I6L+67RXgov+PduemzpkQFkLr8lH
         kFzvJcza34yAVwjraa5EWBrxqh1HI2glsVH/AcVaRIOGbiP0xQXOcYiCZw9SbrJPIbnZ
         8Olg5TCXS+OpMQOgvUqmRlBHz17I5E8Ct+/Rl2XgExC+L4+dvNWddslff70su7xxO/8z
         NvwSsppzydBddItz+Fgm12zbXE1iH7ASUyoPp0LcriUcgC/pB47raoc6julXY7hlYA+K
         0xhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746248; x=1774351048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TxY+n3NUbtzHhLpeuI5pgVnLp6Cb6p5QvJzeW9BsmZA=;
        b=SA/zLSXQZDiNnvzrxF+9xvPx8HO4B8jnlX7DLAkBerQeqJDdio9lf5SQgMj0fbnD5v
         XuYpexrcxWK85io2U19Tx/FynCG+v1/jNIWjAG5NbeNeZvvDi7W3c0/tjpE+S13k8sE2
         Ahz7aUgafW8uy9mTx4gD82QlK0TtU+Bg1kt5kb6sIKeqY6B7419rgnA1eBPG9sW1K/AH
         AC6LE1AqtDEVEJKbjOP/oj9/CVF+c2XwMAXbE1uVpFD/rcGamsiNXp5cXDpLC1Tho1PP
         gf0he8tNT1X1dgss8dv/O3uK0Gy6baJY9UQIK3fe3LW//G9KvZsWPTaslx1vehPxTf0L
         WE8w==
X-Gm-Message-State: AOJu0YyN4L6DOrP488o4ajXIck+967z2usPQqNMhYktvTVgtwJc5NlJf
	IgeeUMCUuqB9WNwfV/gTOdf+b26hm8eiv1ymscPs8doslwBi5kegTDA1ZAhjzg==
X-Gm-Gg: ATEYQzySGbq/07M17olTCacFLzO4MbShomg2Z+MfX0QLdudERhMcQij0bXAWl39XSVd
	4zXneBByl3Ary5/Q0GDU2+/cUhUy1V6wQSzbBKDAP708/ZQz9o3P3DWhxi1TdTrc7o1lzP3Wsib
	vHMBNju0c6Glgelkv8JKHXsBQ4aX6/vplCXNzxUfHQ/i0Vn/2s+2O7E/44e7CM9dEYR3QldaDrR
	qIqGlOBiXqLNkPrvxFK4V/T/75Avi5w9oYQXmh9co/mv7EFQwn8A/iglEeVA123Gjd6HhkSWKun
	A+BvSBDsfPOltusUCuAREeD2EIcwHXndAoWlxnyrUYb2Norp+vLszEa0ZuUNygOWygZV+hJmP/W
	2tdHP4EAlwskpYLd273ismmHDAMBCNiVcPDK6Tkvql+WJEod+7AlHqRsFQzsqBgPrWanz9lwUw1
	1Wp9xgYjZw5VhRUXJi6is/q2NXQuaseRmAzNoxuk8OdTmpqJb+
X-Received: by 2002:a05:600c:4687:b0:485:b6dd:5066 with SMTP id 5b1f17b1804b1-485b6dd5206mr31318735e9.7.1773746247132;
        Tue, 17 Mar 2026 04:17:27 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:26 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 10/39] serial: sh-sci: Replace direct stop_rx/stop_tx calls with port ops in sci_shutdown()
Date: Tue, 17 Mar 2026 11:16:35 +0000
Message-ID: <20260317111718.281633-11-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22443

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 13af95c7f602cf3644f3145530ec2e80a88659eb ]

Replace direct calls to sci_stop_rx() and sci_stop_tx() with port ops
callbacks in sci_shutdown(). This enables the RSCI driver, which reuses
the SCI core but implements its own stop_rx and stop_tx logic, to reuse
sci_shutdown() without duplicating code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20250630202323.279809-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Retained spin_lock_irq{save,restore} ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 591ea7bcb1fe..53a750813600 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2297,8 +2297,8 @@ void sci_shutdown(struct uart_port *port)
 	mctrl_gpio_disable_ms_sync(to_sci_port(port)->gpios);
 
 	spin_lock_irqsave(&port->lock, flags);
-	sci_stop_rx(port);
-	sci_stop_tx(port);
+	s->port.ops->stop_rx(port);
+	s->port.ops->stop_tx(port);
 	s->ops->shutdown_complete(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.43.0


