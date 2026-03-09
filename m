Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBEC3F417E3
	for <webhook@archiver.kernel.org>; Mon,  9 Mar 2026 14:26:08 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15650.1773066362425989769
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Mar 2026 07:26:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=AApBZ4p7;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439b78b638eso8921660f8f.2
        for <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 07:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066361; x=1773671161; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJ7lZhYolkiA8KYaY4e9I5iUsNa7fwrgZMgoxqNlD1o=;
        b=AApBZ4p75gwMQEenjIk+pvHsGic9t0fdDGGZqY2Bytz81d39igZ7hwjnUth7ygyHaS
         60JuG9j7V1g+ezDqD9WSdg3/YmGwk/D5xC7Ipb03IfTTqb0fjYnY8Q4IrCxC96QXnOUA
         YzZfNsp+I3igh5HEX+TZFu3jB96jYZhYrrZTtfyG0/qEGQepw9Ts0Z8+mWzOngdUJg5V
         8KWvZUI/ic4HQm9om1xfVe59mPwTxsVeYpkQUa/Qf+RMoKlalY2U+MUOm5kJJtM6iOy2
         NV2NGG8EqtyJez9EUGhVADhGuJ56DmFocfi1ub7uTMsW6/azfh9M57dAzvG9B39V3/jt
         HEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066361; x=1773671161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJ7lZhYolkiA8KYaY4e9I5iUsNa7fwrgZMgoxqNlD1o=;
        b=ItEZUM0RPIejfcrHDHfjNnRTDU+JWW3KUIg2NIUu+vH/MH4tNpwucUdBAiPBewAwYG
         VS3DaKvvlAW7Ew+ONw3NvwcziTR+Lul66SmwubxuUaryg2ffec1blnAKv91E3IF2vjum
         Ht+liXSXXH8Tb1GTtDvpXkV2YlGzqExVrWFoiZGo4a3VR8CKnyh1hZ62QTmw1vQZcc51
         dIZJuF6xf/vX5F/To+VBNQeIASi6uyD1xP5MnDlNoX21KLOsQFJXUYz2937iz6BCMbWL
         lGdO1Cp6VWewiEFjzurkwkzqtiwX67hEsEFlmtsunpyyW29S+nSptmFcPMPFqplppKTu
         nPlA==
X-Gm-Message-State: AOJu0YyBzxXX7SNvX3l2Xo9LWZc8ge53KQ4DdoWE/WkhwFnGVYxSFUBu
	9WDs9vf6XvZ68rIp/y5w5EouyK/vivht1rc1ij13aTh05jx2u8pmbxAK3D4+sw==
X-Gm-Gg: ATEYQzxAbp1IQckRpcPRZoLfMuKHOdNIQHRtJdOVhwQoa7gy9IngxGtGH8akH12oLBA
	xk6GAtxEdROE7UYw5kVTtaa7OnI5AAGObzznpbJqddhLAob/rwIidcA1OcLqttvdZnzU0dxeCT1
	b14BTfkp5QnlATUsXz/7BQXwbzsn/TNO9QBr7HpgvqPYucSGxwBM+/g69IWALemlttR/57lsrjq
	XBo4rerpanUh5Moc46zl8d3VtQt7YrIYoE5OfzcHX0C8IGUMdh86tPm+O/59GWoRytkJTynWLG7
	Hwg2W7T6IOr6sf7kX6qqHvjPsDmRHEt03o58V5vUaLs406QmyB/79BlrvVtuFDeirBU1OP2IHvE
	696nZO3lfxm8qXhx4BAiIQgsn24vkZOzUCApFDHxM62EGqLMG8buzRJTK3n3GmRsoGe5yCeMdWi
	a0xhBLhc5y9u3R6lGadXyshBaz7+6mAQk=
X-Received: by 2002:a05:6000:40dd:b0:439:ad4a:f40e with SMTP id ffacd0b85a97d-439da89c257mr20049114f8f.48.1773066360323;
        Mon, 09 Mar 2026 07:26:00 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:7e80:c383:72cf:ebc3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm25970311f8f.6.2026.03.09.07.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:26:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 16/29] serial: sh-sci: Use devm_reset_control_array_get_exclusive()
Date: Mon,  9 Mar 2026 14:25:16 +0000
Message-ID: <20260309142549.987737-17-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
References: <20260309142549.987737-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Mar 2026 14:26:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22184

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit 850ec928922fb819c28eb175bf85b01e28afdea7 ]

Replace devm_*_get_exclusive()->devm_*_array_get_exclusive() to support
existing SoCs along with RZ/G3E as RZ/G3E has 2 resets.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-10-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 97f6dc8692f5..cc6765463003 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3706,7 +3706,7 @@ static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
 
 	data = of_device_get_match_data(&pdev->dev);
 
-	rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	rstc = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
 	if (IS_ERR(rstc))
 		return ERR_PTR(dev_err_probe(&pdev->dev, PTR_ERR(rstc),
 					     "failed to get reset ctrl\n"));
-- 
2.43.0


