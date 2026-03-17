Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83091FD7091
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73595.1773746261022778146
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Yr11S9sq;
 spf=pass (domain: gmail.com, ip: 209.85.128.53, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso50011405e9.3
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746259; x=1774351059; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Dt7zUB9Vb4q0YbktpZLYwQvf0eNxBP4lNMdMP6ZGmo=;
        b=Yr11S9sqK7VFLeA3oMyDcn74flmJHv4YY5v7BCnSm2+LS41iKyAQT1Ps29FitJMyYy
         vK3ceh8RfBz2SpWU1YzhhtCJCnU0k5VxiehF54Aipbb4lMfHXN/adwbAIvqlABLBalQ1
         kaoFrLl8ygPl6pfssn1+IcEyiFoJXYwAE3+WGVgeAdI76TyjmfBei8kHyzo0JB6YHHsU
         DykUkaGU6Ne4zUNdfl5ErDHoDs9ZpX/hAmPRaCEi05LD+vbv78tKEnfb6Kd0CiYLnpFz
         fJdPjnMrBkhcq1Ori3ulerOvqfFUm24f8N557J8y14447ad8ZyhrTvHtbPY8Prconi7+
         fvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746259; x=1774351059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0Dt7zUB9Vb4q0YbktpZLYwQvf0eNxBP4lNMdMP6ZGmo=;
        b=Qs+JKe88CioiXUdz84VdCKWug9RiqNcep25V+UKE0se+1Zex9A0G0eOBiBKGYruYWQ
         nZoo07tBMbgFd6ihXpkQ6bKkcCMCARco0FoyHpbnFHUVS73kg0OZvagll5NHIzHZKaEw
         2sVIi9GqOyXecVwC7+pboGaakMgMjphrJ2ylNzYEDLLfYhbawlHVwP2Ja/klTYf0H+96
         OZz0BmXUPmAr/cuZdI4GEDm4jZiZ13dl6N1EZlfxmQc9BBbg2hax2c4peKJ8gjdxRMm+
         vd0YcBEBra1HgAC0EgEihqzcaxunc4CClhLGLacsMoPYjKySBTSC4GAaVepYEhTbhtbp
         ifpA==
X-Gm-Message-State: AOJu0YwwBGDsY4rE1JUxDjqzFNEMsTXti3pn9DAF08SbvnIqmIPjrOd0
	960lbEtmTfra5yq9jjp/I5YDYylKrBSficOETo6/4aILEkWhfeA3Le9GrPK3cQ==
X-Gm-Gg: ATEYQzwCxZ//6/2CFGQ6VuqE/rIbMB52wepYIohdItgqGI7+zYJ+oRAD0r3yW5vNLUc
	mHHBN6AqquPKuc8duDSyUGaHJFwBOUM8Gxa0Rg6zFE/w92ZnNF/8YLpeswSQWX05OUv7zVOQ+C0
	aMP2+SU1lROtCvZ1caVrADv5lJlBdTx7azmEuieoI/ZQ+W3+718cGQoWAlVomBCpZ3pT0DkpHsG
	iWkFmkJsukNqeEEKJ3R+su10Vc7hpAs8ECUU+D/OtZiTBlGsVNYafFUEkDxTnLNdpRpYOZTdxBG
	KS+W7Tl2BOa40ZL5Cu/Hvb+lH3yiWvjJsa6Nzep+yrBoMmkf79wYucw74ZXcpTk918krnufcWjJ
	ZykFbMH1XYAq04VuLPrfYQh8iYOTq/HzuXfrCUkTPoeiJ9EW+XTKDVHUKfAPUkozW0KDzgVsxIH
	vYvX5B3Oz5ucFyInl5Lj+SbV/qsxmt9lwcafd2QHS6uDvRMDmD
X-Received: by 2002:a05:600c:c0d1:20b0:485:3abe:ab86 with SMTP id 5b1f17b1804b1-485570ce1cfmr203272565e9.4.1773746259076;
        Tue, 17 Mar 2026 04:17:39 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 24/39] serial: rsci: Drop rsci_clear_SCxSR()
Date: Tue, 17 Mar 2026 11:16:49 +0000
Message-ID: <20260317111718.281633-25-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22457

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 450bd399c8797d2783c73aa6c83f382ac8d5f630 ]

Drop rsci_clear_SCxSR by reusing rsci_clear_CFC() as the contents of
both functions are the same.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-6-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/rsci.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 3869ecb0315b..6ba2413bfd8a 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -137,10 +137,6 @@ static void rsci_clear_DRxC(struct uart_port *port)
 	rsci_serial_out(port, FFCLR, FFCLR_DRC);
 }
 
-static void rsci_clear_SCxSR(struct uart_port *port, unsigned int mask)
-{
-	rsci_serial_out(port, CFCLR, mask);
-}
 
 static void rsci_start_rx(struct uart_port *port)
 {
@@ -393,7 +389,7 @@ static void rsci_poll_put_char(struct uart_port *port, unsigned char c)
 	}
 	rsci_serial_out(port, TDR, c);
 done:
-	rsci_clear_SCxSR(port, CFCLR_TDREC);
+	rsci_clear_CFC(port, CFCLR_TDREC);
 }
 
 static void rsci_prepare_console_write(struct uart_port *port, u32 ctrl)
@@ -466,7 +462,7 @@ static const struct uart_ops rsci_uart_ops = {
 static const struct sci_port_ops rsci_port_ops = {
 	.read_reg		= rsci_serial_in,
 	.write_reg		= rsci_serial_out,
-	.clear_SCxSR		= rsci_clear_SCxSR,
+	.clear_SCxSR		= rsci_clear_CFC,
 	.transmit_chars		= rsci_transmit_chars,
 	.receive_chars		= rsci_receive_chars,
 	.poll_put_char		= rsci_poll_put_char,
-- 
2.43.0


