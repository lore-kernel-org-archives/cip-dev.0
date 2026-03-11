Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA07104BEC5
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 10:05:16 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17322.1773223506371718944
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 03:05:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=PRSMPfxC;
 spf=pass (domain: gmail.com, ip: 209.85.221.42, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-439c6fc2910so5584789f8f.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 03:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773223504; x=1773828304; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O24j8uXQXYIHV2Or5pHws4d6zQwjf2vdNRXLo6Z4WLA=;
        b=PRSMPfxCj6qJMbCzBRQanxJw+TobfUuTN3Wab3IU/icUCb6py6sR3zbB5mRWaysvWf
         hYbWDwfaimfpwznPhmxf7hjSke9+YEWEQng6eH02ZNF/p2j/0Cm+HZ4+t7TofO1AQdvK
         cT13I3x+qmHf/Qowop1hm35Hl44BHkS/5GbWkQEWLog94Mf3rpO+zbxsXK8bowhfRVAe
         +uo1gwI7lTt+so2THUEbsJ1NXiZEms5xaSlN9gkPb+xkeibOMOvznaSYfazOtTA38Tx+
         YAlhl81IC5uTQYqDAO6FgcV4yZHEayKzw1GBPhA4ALN7N27y0zNUPCtknnN+a0e7cr7W
         TZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773223504; x=1773828304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O24j8uXQXYIHV2Or5pHws4d6zQwjf2vdNRXLo6Z4WLA=;
        b=pflQ40ZYzhWmfFyvFCI3NYUMpwSYULIVgJlKAXCk0e+1KUAqEwYS+SJhOwy6kxhUTm
         o5SO41nGEmz/QHMYltsDm+KS7jrlTXERO1NRElyRdPaBXsRjqj0wbVevtO7KHTNyw2uR
         q25wlOueTkrOfGrYve2vja/mPdq0WrfKKNgQbubSaS+94tC/2+r5ffXq8mJrL73V2cQi
         3eKDRounX29z8Q2n6FEZhKP2102IZBGrMSZ0FT8yO8KEEbMBYD1c0ZL2gzPQLV5jDxdc
         QgjPBq5O9UuSi1xkU0ymc0JgVcqQtqMvzhnkpvALJNRITsi2fObyLk2S8tCgN+YIN9X/
         nLoA==
X-Gm-Message-State: AOJu0YxPWHoV4pGPZz4GOX4Oew6cJdT5aB5H9G54e+CBc7cFnP6We341
	hmS7akYHyck8S933RKjzTNJfqvUJkmfEbGSwr7MevEcVg4RrJHEYfoke1mYkzA==
X-Gm-Gg: ATEYQzyaQ2jPIMwRdeY0PS3Ig1DWN3uuoAK9dh65GezkA3QoQwb00tvf5UQ7zMcOAR9
	yFDtwIFEfDIXrlOdbNMvnjeeQqKtmd+1MVJosBLUxJpWeLRrQT5QaKcfrfss2SBXhj3XIBbfDGp
	6MxKJxBtt+KwTggwHqDJhbS4fbsXGRAuhLZOA3L+CHrZLCiM6wqIdKew1y3sRt+oOLBPV6274wg
	3XSsJSOBXbcpgcRXqFA655oxuFN8mMNdVkRqQEL8Af8zMcyi81HeYuE8o8jDc9gyW7bZBjOwKFI
	EDHD8P3Guexgk/HFo5YvUK26BDFInl8QqtuIMFO2NzG0/n7boKM6zI/R17q+sSXoO4+UrZ8tOfh
	+8EZyqhyoGrtIx7g7lxJyR6ij0EknTbyvvX5UU8sKwZ5KcFgLaAzOAaH6qNLyaH2ELabATYUosg
	+VMSEyHNp6qL6wNJ9xEplrxKttH2CTkuc=
X-Received: by 2002:a05:6000:604:b0:439:e334:426a with SMTP id ffacd0b85a97d-439f8435927mr3853883f8f.46.1773223503904;
        Wed, 11 Mar 2026 03:05:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:38b7:8ca3:cb55:d344])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81acc22sm5177153f8f.16.2026.03.11.03.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 03:05:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 08/27] serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
Date: Wed, 11 Mar 2026 10:04:27 +0000
Message-ID: <20260311100458.162447-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
References: <20260311100458.162447-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 10:05:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22254

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 75a9f4c54770f062f4b3813a83667452b326dda3 ]

On RSCI IP, a deadlock occurs during a FIFO overrun error, as it uses a
different register to clear the FIFO overrun error status.

Cc: stable@kernel.org
Fixes: 0666e3fe95ab ("serial: sh-sci: Add support for RZ/T2H SCI")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20251114101350.106699-3-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1cb9d474c0f1..80b2b9b3542e 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1198,8 +1198,16 @@ static int sci_handle_fifo_overrun(struct uart_port *port)
 
 	status = s->ops->read_reg(port, s->params->overrun_reg);
 	if (status & s->params->overrun_mask) {
-		status &= ~s->params->overrun_mask;
-		s->ops->write_reg(port, s->params->overrun_reg, status);
+		if (s->type == SCI_PORT_RSCI) {
+			/*
+			 * All of the CFCLR_*C clearing bits match the corresponding
+			 * CSR_*status bits. So, reuse the overrun mask for clearing.
+			 */
+			s->ops->clear_SCxSR(port, s->params->overrun_mask);
+		} else {
+			status &= ~s->params->overrun_mask;
+			s->ops->write_reg(port, s->params->overrun_reg, status);
+		}
 
 		port->icount.overrun++;
 
-- 
2.43.0


