Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C828F417EF
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:09 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15528.1773066359686121632
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jMadE4YH;
 spf=pass (domain: gmail.com, ip: 209.85.221.47, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-439b9cf8cb5so7330856f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066358; x=1773671158; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EOLLju/OafIQ/UeohWRrM4kICM8vXyZX31iqNO3UNSg=;
        b=jMadE4YHknZ5iK83Jij6ib4NQZQMbfcWIdvvE+vQNR7n673mLMU8rsYv/BSDZdoCMs
         wPdzkl56+uLYvF2D75F/4UnXT6yF3+nqsIK8TKFilsqzjdH4j11h5zC3Ra6cDDIsw0VN
         sWEmndVp3kDK+ED0LLBvWpjfaIeTThH03DU462h3TFViADKqO24xmXE8iFhhud+fsig6
         MgkOLCnkC7aL1CSNq76mVSNbcBjPg3MBafqSAOY60eD6W6+FxZsrxOGr2HQmXazASBcu
         fT9pvIMgNtEuj27DNEFVpM4Mf8SaDPProAKiYN7H2oINNc7gSMEPlzJab8hD5uCFYMxP
         No3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066358; x=1773671158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EOLLju/OafIQ/UeohWRrM4kICM8vXyZX31iqNO3UNSg=;
        b=eZ/Awe90d8ePcdYgABm/Jj9mGpJ/dUyF0o83nhg2nvDwhHpWehwkLorwcEJXZ8JOLP
         KOw4rtf6Ckr8uAUntgWdRe2cfQGcRGq21l+Xam/j4igiPPSz/U3yp/4S5TBTrSykDqEi
         fLMpouAa+/wWxjo1423t1KL4NGi/+95OuO9wmgXdSLSBc46Snzc3WK8MqmvDGuLFbhsV
         wNhSSCA+cEAWfQajdNTv68i/GHOBvWUqeDHTiZpgeOCsFW5H+npBQy3sJNPHdnHv7+CU
         IoNTFcMjb8Y+Hnstf3JrRIh3/bqNS9JeVlDUFWN6JnznCbNYj91sM/sWLI+4giewsR8t
         9PJg==
X-Gm-Message-State: AOJu0YxhwTmO+vaT7R8Cno2a7xekx4zlxZy5HMsnnvw5kxlNce/Oj61Z
	D95Fyt08E/1nKnLJZCpjRpxPpi3q4zbC7VofxsgCMm7ngiwzDhgedCZdZQ277A==
X-Gm-Gg: ATEYQzxFx1ZfeKdPbVpjXD9kiJzEhsEWlRoUdfo4PalV1116Yq/CNcdaC4TNqaQVD6h
	On3Jw9UW0z/hAdUqc5N7ZWMbtsyg6hQQCNWR/yCQb8TZDAJhUchppQdytfWPCcdu2cAREgJJISg
	af/+mnwE+ozxhV5JQ9JRgIodRswYjMMUcpHyl2m7+WmWUE5AfSjURvEc1Q78XRw+P0anC3aeQ7r
	HAVkNUGK5U8/xe47R7j5IUf33bTBxE8LdvZux8ggKA4nZYiiiDmm3BjXxYlWrrNzoeOYkK/CGxV
	WCoIMWqAjKxlv9N4MyVGu2IlgC63AEvuRDpkugKOxMuVtM5snbS4eCB4UBEq+O/S28yEzvS/Tns
	D62ackXD+pYksZpsdeEWi9kFAW2noi9xK1i5WKII+99u0cMhUaCUs07U3QaaEbh7jS/lY08J7nL
	eaY1aYxV3mfoKeUTBFs2w73/VUD8VJZ9g=
X-Received: by 2002:a5d:64e7:0:b0:439:ac16:bc8 with SMTP id ffacd0b85a97d-439da10e339mr18627949f8f.0.1773066357771;
        Mon, 09 Mar 2026 07:25:57 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:25:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 12/29] serial: rsci: Drop rsci_clear_SCxSR()
Date: Mon,  9 Mar 2026 14:25:12 +0000
Message-ID: <20260309142549.987737-13-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22180

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
index 4d2572d63180..baf4eeb46e5f 100644
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
@@ -391,7 +387,7 @@ static void rsci_poll_put_char(struct uart_port *port, unsigned char c)
 	}
 	rsci_serial_out(port, TDR, c);
 done:
-	rsci_clear_SCxSR(port, CFCLR_TDREC);
+	rsci_clear_CFC(port, CFCLR_TDREC);
 }
 
 static void rsci_prepare_console_write(struct uart_port *port, u32 ctrl)
@@ -464,7 +460,7 @@ static const struct uart_ops rsci_uart_ops = {
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


