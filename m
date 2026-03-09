Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1605F417F9
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15663.1773066369266819536
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=A59cQ3G6;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b2965d4bso6798925f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066367; x=1773671167; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dqYrWaUp9dkA9mT7qwF1s02c0e0BQbUnBXod28Cr3Q=;
        b=A59cQ3G6L3BIQNczEJN42XnA6DH20Xs345epgOYyA6XpBrXE8oKp9LixNv5UmR/dpK
         lRwb4xQkwJMVwijzua2MTYnUzgFeJxMKIypQilPFfB1325sWRBqTR3/8UceVLR2xrcHb
         FO75a2+YKOYSri6azavx/vkp3bkafX5UaEUh8HVQO7VDh40ZA++HHHsobx3h6c72ioqw
         LlEFP7hZ3noscHLI4G8pDiDridXC7cyUGhGcDiZ8Eqs9P92w2/iBXGk03CZ7j5MoKBmS
         uE/T1iVQqoLoAKH9fao9AFdIu/j8Dnb4tbrHbGj2A5xoQVChMn+WEemnFdhz0LUApkv/
         /pqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066367; x=1773671167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dqYrWaUp9dkA9mT7qwF1s02c0e0BQbUnBXod28Cr3Q=;
        b=rLV11AA8O2aZ3ULvS4iQXNfSArxtiFpouSOv3vRi2erKfmwyvRhPLoIEcRV1BR+ylN
         ypr9ThuiW1hYQxbqlmMiLyJputb7f5AQQxe8e399azY2NKYM9p/Xbxhpvowyg8p7qo9d
         ti9dlNRy34gvIp8NdmUKRtkAqvNdKd/XuT8YbBsKmxMyJnaS6tX8FWU6uPORNMmTVVyY
         CyGVHE8wCitHrcUxo7e3vJMkLbfU0EM/uy/wEiFpWAzzfgb6GWX/MB5kH8A6r2/mEST2
         ETW6E3hTQjV4mh2TGyN+MKwl3e3RQgkcymEWe/XvR6yTxfYXECANK0oyGTj59joXLZJ/
         C6wQ==
X-Gm-Message-State: AOJu0YwN8IQ3LDBsNqroPHZJXreHFFUqf4APW1MzIpS8x9iPe6lGAuvL
	OIdH1ptqShl1gIfqunzZ+JwGNhJGWz3riuLUADyP/ASMjYpkSppR9iiSaqPkig==
X-Gm-Gg: ATEYQzxKCN7vNcgQyUDRH3gW7u1xrUjzSu2aElsPe9KeMeTcrEFzZxbTSDBnalCIuCn
	DBLcLqWkGJ8tSHJEjA5bRrdLQ7QVm/wxFW9wGquVOW6+GrOkjJ4fZPsv+pfT53Lc0tJPY7EwIGN
	4Uvm+CeQQ0idZr+eKKg1p5F0s7aovg+HCJ2T2GQiClxxKvwGxVwxRo4mpnFBheZNUsTeTsIJ1it
	Id/8yIj2br7seqkRmNbt6/Uv3V8P2RKHN8XUlxkBVqOGukBJXrA9Pw5papl+vpA9ir9/e8VrVsR
	q3oxDAuyUeOFGi2+BjNsjk9yiRDcF7Y71NupMzHh0Xgt5K6km43LuKTvtlWXuoxee/H/+aGeltf
	9/ND8zNVb8JnGmQD7fSG8FYGNkYs5KXpyEho2yixFGaqeXZOZPphkTrb8EUILHUtPmfnJe9cS32
	W3TqHlNe9u1Bj+qqJwA5kccXQVah/imwc=
X-Received: by 2002:a5d:64e7:0:b0:439:d769:ec56 with SMTP id ffacd0b85a97d-439da107fb2mr18988150f8f.0.1773066367282;
        Mon, 09 Mar 2026 07:26:07 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:07 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 29/29] serial: rsci: Convert to FIELD_MODIFY()
Date: Mon,  9 Mar 2026 14:25:29 +0000
Message-ID: <20260309142549.987737-30-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22197

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit c14afba60a61bc80403a571a67db956aa9800dbb ]

Use the FIELD_MODIFY() helper instead of open-coding the same operation.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/ada3faf4698155a618ae6371b35eab121eb8b19c.1766411924.git.geert+renesas@glider.be
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index e01ecd3ee74a..4dea8ddf6665 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -207,8 +207,7 @@ static int rsci_scif_set_rtrg(struct uart_port *port, int rx_trig)
 	else if (rx_trig < 1)
 		rx_trig = 0;
 
-	fcr &= ~FCR_RTRG4_0;
-	fcr |= field_prep(FCR_RTRG4_0, rx_trig);
+	FIELD_MODIFY(FCR_RTRG4_0, &fcr, rx_trig);
 	rsci_serial_out(port, FCR, fcr);
 
 	return rx_trig;
-- 
2.43.0


