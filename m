Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A122EF3717
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15655.1773066365144066506
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cjTO9PpY;
 spf=pass (domain: gmail.com, ip: 209.85.221.49, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so8320514f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066363; x=1773671163; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qELteX8g3zVOPaMUFbsvglcxpGSfLg35i5PsGsUYaG4=;
        b=cjTO9PpYZNRDq45NfxXI6pT/vb0OzJFQEnU+WUplAJeMc4EOxrXbOUh05SHOOiEMwl
         UuOpUgcnu3EzJLD39su+/RNMB1T0xH1Kg0RRMnHD/aGaGHup24bTuOojzkz/YUCAF7EK
         qghPfm5EQ6bDRp7i9Yws6Wlc4gRW8Z6fn7k7zZvm+hcH8Lj79ShfhGQ92Hxmw3odDRMo
         L9VdedSBYa+5nWlDXouF2w9ue0esO35+Dx7ULZlUnR8v+7EwVU/2XRwYXXo4whPyYP8l
         Yun6bfOfRidZRg0xN4lhueIt1vNtOTsFiAI2SagXiomnA/TFfGhHs2Mgp5ijz0CP5qKv
         I06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066363; x=1773671163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qELteX8g3zVOPaMUFbsvglcxpGSfLg35i5PsGsUYaG4=;
        b=lv8Nli7tbtP944Lop61hG/uxxixyh6LI9JkZgc8mMuikormb/puVT1wY9+HqBH12/D
         5lkJtGiryDg6JMJrf+ZA+MWi9db95JZzrUOlUcD446aLRUmVEmfM0+EA6vJoj9Sru/Sh
         QJ7ugNyUqNVBx4mLVembR5LfPogq1tZi+XVIjB4lW9WldJZppXBBX1TWz9DE418XCyOj
         eDPh9DYCzA0qpsDE47rg8LOwliKbAs7FWlF7uBiKpcjDcQI0Qlj3iNiXXhvp6BLDSQdU
         Um2yeO/oAKwx/e78Q9HK+aUUxLThgmdh2uIDBDsB2fq1+DDtEUO9FwJN0G3qY8EPnBhb
         5GdQ==
X-Gm-Message-State: AOJu0YyaEV/X82FbqAW05CxSTSLzNsnkTDdi8tlrzCw9Haaxg44tku5u
	tXSC8DuPOLpDSI0RDaQ+8sPLG9GOY6ffy4a3gp8yoOSW5PYfNxYKw9sPU01mjA==
X-Gm-Gg: ATEYQzyco7h5ruTmmVfOxpgjCvhcA4ACyJOcYO1oAsj0laN3wXQt16XU8BcZgArzU/z
	fMFxbtd6k819K74bI6BWQSHikhGoxEoGOMxoWeOHoQKkWy0RIKsle4kUNPw2+BHcM2AyUhB/fY9
	/srJKceNW4R4pX7kimgVg1Eb0xx2tcW1Szwu82unKz1YcP0Kcm8gbnmSMfM+Gz/TT+CPuQDBnB3
	h9bb+5J2sR19MDCVxjA0cyFW7tqkoYaIWU/caQ6H6UgZsbru/t5Lovvp10IbnyDpf3WB+N5E1Z4
	SvS3QHFjmCo4s1mqdYJjuBiW1TyPOmc85pYs7SDL9zgZQ8IDNDBKjVCMegW+SWCy/j1E5GkWfY8
	OELAaUpziM4DF3oIzABalPSazJYfvrFNWFwHkGrocwUxSxpLGAFt+ReViheUK8JqbL+uLJnRipL
	RZ/ECbdwwUIway6bfd8/q5FNFQSWWbmvg=
X-Received: by 2002:a05:6000:4383:b0:439:b6f9:b426 with SMTP id ffacd0b85a97d-439da663a4dmr20291527f8f.26.1773066363204;
        Mon, 09 Mar 2026 07:26:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 21/29] serial: sh-sci: Make sci_scbrr_calc() public
Date: Mon,  9 Mar 2026 14:25:21 +0000
Message-ID: <20260309142549.987737-22-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22189

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 5632bda5e848c4592eefa4451092beb4ce29ab76 ]

Make the function sci_scbrr_calc() public for code reuse to support RZ/G3E
RSCI IP.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-15-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ Biju: Dropped double quotes arround EXPORT_SYMBOL_NS_GPL ]
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci-common.h | 3 +++
 drivers/tty/serial/sh-sci.c        | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index 5d30771278b4..976e394ab968 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -169,6 +169,9 @@ void sci_port_enable(struct sci_port *sci_port);
 int sci_startup(struct uart_port *port);
 void sci_shutdown(struct uart_port *port);
 
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks);
+
 #define min_sr(_port)		ffs((_port)->sampling_rate_mask)
 #define max_sr(_port)		fls((_port)->sampling_rate_mask)
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6e9cd8044b89..781fc371a62c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2574,9 +2574,8 @@ static int sci_brg_calc(struct sci_port *s, unsigned int bps,
 }
 
 /* calculate sample rate, BRR, and clock select */
-static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
-		   unsigned int *brr, unsigned int *srr,
-		   unsigned int *cks)
+int sci_scbrr_calc(struct sci_port *s, unsigned int bps, unsigned int *brr,
+		   unsigned int *srr, unsigned int *cks)
 {
 	unsigned long freq = s->clk_rates[SCI_FCK];
 	unsigned int sr, br, prediv, scrate, c;
@@ -2640,6 +2639,7 @@ static int sci_scbrr_calc(struct sci_port *s, unsigned int bps,
 		min_err, *brr, *srr + 1, *cks);
 	return min_err;
 }
+EXPORT_SYMBOL_NS_GPL(sci_scbrr_calc, SH_SCI);
 
 static void sci_reset(struct uart_port *port)
 {
-- 
2.43.0


