Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C5EF3C277
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15526.1773066357653012642
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:25:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Qjv+C1dp;
 spf=pass (domain: gmail.com, ip: 209.85.221.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-439b9b1900bso5988556f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066356; x=1773671156; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O24j8uXQXYIHV2Or5pHws4d6zQwjf2vdNRXLo6Z4WLA=;
        b=Qjv+C1dpJseoBM7/qxFPCqFDfgEZaFOrlZnHUBxall3FIzrBMtvGQsSQjd/5rfRA9R
         bIGxRVPwWdoJBi5O8rdG91ofNPPmFE+JvqNOeVQPAX1Z4lnb14vitIlKSk7DxYK/jG6u
         rJ/UmPbepnMV51enbdXkp+sjteSq3vHyogO196fRQOl6kFTLVMSIK3t+B8bdWn6Fs/bi
         DakxjicLTYdh1xxmso/ywKuwCld6lJbcnsH/Pmpv8+mUC+s4ifkU7C8gHcp3QY0dBPus
         r3gpy/mNwmrGO+d8n8pPoOkUf62H6PbQgEEfbgreL3j8HNQVjBnH84dptSkYD48lYrf8
         sh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066356; x=1773671156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O24j8uXQXYIHV2Or5pHws4d6zQwjf2vdNRXLo6Z4WLA=;
        b=MysXer6jKgprP1IDktpUUOYUde/wTcu1xyApCGbaK5/03TR05jcR0Gn7niGetK6u5/
         5RV1U1nZrflDOkW3c61QRxb9578igXf+vD93BE9FuK2m1Cf6rV/NNbhh96Vkes5M7p2K
         XfBOW8W+9kUyD8nOuco0RgBo849/SZiCCnFmLqmx6BkzeWv/d7XJqb2rUmP0uHmWzcq1
         YEVCth00wEfyMG5DhRfa9RdpaEs28gIUohS5FcAHV0dMqS/NjoYj0vrHm+ZOrgepAjT1
         TB9Y8p+Z9pvhQ7XLCfhGterWXzJCBMVJAi8b3vLH4YOdirmfCjpl57QtIqDSHDYkgSiN
         eFbw==
X-Gm-Message-State: AOJu0YymjDfDXtL40juVCNsb59Dcddf1jl64rmyzVm5dTlSvwsh0jP5i
	yEdT+JvLhHNGXULL0ewRfNdCaa+BGmSKk0GGLIJKfesxtLN5RPaJwiAfcnYtZg==
X-Gm-Gg: ATEYQzy/vljb7uIJ36xZ1iSFAERX/ZAxpm7lV/GVYRYQdA5fK8PTwpRHNCuVEG6r6/D
	hvYDF3pZD5z4KBNmdkBTaNgiqpp2rYxMOU8dEXaw8bU4qBMgLYjnfk71aCGwsTDOP74+tAAhPL5
	naplvALMaOv0r6bqIkhBoLbWOGR90AZS7DYqSzY8lpkFQvIvxbJdlcvFAmhbLbAQ9uzhy9uY0Cw
	vpOBz8Dxs0WpNsbzPiZYKEYj2nv4Pqc7MmUDVOG3FEZUQEiB527wmlC6HYfrkKiJWk14LPWoV0t
	m7po7CtOTjASt7aHOzEyWHe+yaE0kyI9dChNWN01MAWoKdTW6UiSinPXjh259EFr5oUtW4s7esD
	SR3Rwk6BVgzvM8a+t9EdKh5kaXyXV8KzzBgHf1ECjt+8JpP9K3kFEq17FOH2Polrq+iIodPTmVA
	ql4gs22Cx0W2SlSiY3+hrQuNYtLbvKQOAfPy1oAhaWag==
X-Received: by 2002:a05:6000:2c0c:b0:439:b541:a088 with SMTP id ffacd0b85a97d-439da8a2e9fmr18725957f8f.54.1773066355593;
        Mon, 09 Mar 2026 07:25:55 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:55 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 08/29] serial: sh-sci: Fix deadlock during RSCI FIFO overrun error
Date: Mon,  9 Mar 2026 14:25:08 +0000
Message-ID: <20260309142549.987737-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22176

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


