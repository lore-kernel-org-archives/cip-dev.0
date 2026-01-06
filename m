Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 836F1C98331
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 11:45:08 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.88211.1767699904617893136
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 03:45:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Ey+9JRT5;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4775ae77516so9559275e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 03:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767699903; x=1768304703; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDQ+EK7+Mz+xI6NX6PGnWiApQlNfEiuwXCx1U2BS/NQ=;
        b=Ey+9JRT5yEH18SA0fMgGfpDGtsSq5nMSOACdvHMYRlf6jaLFT4yH3ev16wQSUHj1Qw
         M58V6Qhg/JpZgnyI2IuNehOhgsZH4jVh+xA/R15FyxzUb9UDFJBrmSYpJC7Ads5kWs+r
         muSxg6KiFOoHUX1kuWANyyAc4lpNQbcfZ9OtxI/COX1GEzXWkTsAl2hp3d4Y4wty4LSU
         euGvxp0ZXG8umLSu0h1zXmoEIMZYtbrWSjvxVXI6mkydIl0Bwf+w59QankgP1sRJR8E7
         iMlbOiE+Jzqy791EnsKTR6wtVI8S5tDQ8oerBwbwqJfwlquqZ3sI+DTbRjm+Av8yJFm4
         jDMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767699903; x=1768304703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fDQ+EK7+Mz+xI6NX6PGnWiApQlNfEiuwXCx1U2BS/NQ=;
        b=cTKKUqdCvI5L+fhBF4OWAC/YLNGIcV0TtKaElkdJNy1WbFnz5XQC+riLz45gLf9Tms
         rtgloWaWZKxohlrHN0M+cuUMypRC5qEcbpVkIbK7UXi/oLF7SD384QK14MZ6Jt2aSstu
         MpzhEhVsSZdFCC9lTZXgIzOfUVBSUdwHp5l0zv3VeG+6Cwlkf8KG02flpcSbAWkOmvkU
         2tBCspgB5JPnae0rPuaTgjX/Q2n9WmfjmIJIccX1osrQHRVOn/fh41DBOzi404SadYBX
         /BDeyujcaahrhHTozQ36gc426xg0p0HIgMy5DaHYAVaIBX+NnLEyogPFK4bt7DVnD43d
         vK2g==
X-Gm-Message-State: AOJu0YyWmi+lMLrI63Olm8WVdtuHdIaPW0GJ/N539rYXhoM+wuWTttMt
	Kq8aHrhpVBLDi8DOSsNz5n1nvfv/KpTf3gbPYosYq8UC44X5WVwdYuH9VokV3A==
X-Gm-Gg: AY/fxX56hrW1UnR9QQ0WUmhiMxq5uBZO1owQm604pvr5CMLPDOQpfMGzt1TkNbUDeeJ
	p9XNFdKfG1zERzYZBcZsEbA/X6W38Ve3GgKknOgGJh1gZLZwEYjEciH7cCYFlGZGXmMJM8I+09j
	mWzYj3NROZE69yqpRxNVj2nwRGDZSPQPCKX/2SXpmFe/HzKj0BNn7ZGzPTrgrw6BrJDO6ld09Dy
	+WIWearuNRey7iW/LQ/S9RpuZUJpijM9YjBXacr9TxuUSdSGPC7njFfx2ijOt5KG/E0iJ+167n4
	C5awPmgsvg1DuXDfK73CBI3JCenYj5K35lhKTAy0snX3qRmV6O6wjFprYY7wp1RoI/mq3YpTPuq
	Zp/gE8BqJPAdR5jQC+yJQAIemv/A8ZaaQE93XazS0Qj/VrGchN96h0wPxL7ZxdbvGlbs7t9OSKk
	EHnoTH+l3L0epQTwEggQ==
X-Google-Smtp-Source: AGHT+IHJ/wTyN82OfeEhujySSUegVVlZQrBL7u5cEOJb1OjLSIsal7hv/trttgc7qI+FH4ZEuPXsEw==
X-Received: by 2002:a05:600c:5395:b0:47b:de05:aa28 with SMTP id 5b1f17b1804b1-47d7f06c8e2mr29325295e9.2.1767699902711;
        Tue, 06 Jan 2026 03:45:02 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:8a99:e76a:4e83:ddf8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f982cdesm18170205e9.0.2026.01.06.03.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 03:45:02 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip v2 07/24] can: rcar_canfd: Rename rcar_canfd_setrnc() to rcar_canfd_set_rnc()
Date: Tue,  6 Jan 2026 11:44:30 +0000
Message-ID: <20260106114458.122333-8-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
References: <20260106114458.122333-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 11:45:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21339

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 1b76dca8fd892a8ced41d980e123b4701ad3cf10 ]

Insert an underscore in the function's name, for consistency with other
getter and setter helper functions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/9fdc2584ce27b2784ecea76390d2a81eab289d0d.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 3133ef64f537..2f84393d95c1 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -830,8 +830,8 @@ static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
 		can_free_echo_skb(ndev, i, NULL);
 }
 
-static void rcar_canfd_setrnc(struct rcar_canfd_global *gpriv, unsigned int ch,
-			      unsigned int num_rules)
+static void rcar_canfd_set_rnc(struct rcar_canfd_global *gpriv, unsigned int ch,
+			       unsigned int num_rules)
 {
 	unsigned int rnc_stride = 32 / gpriv->info->rnc_field_width;
 	unsigned int shift = 32 - (ch % rnc_stride + 1) * gpriv->info->rnc_field_width;
@@ -968,7 +968,7 @@ static void rcar_canfd_configure_afl_rules(struct rcar_canfd_global *gpriv,
 			    RCANFD_GAFLECTR_AFLDAE));
 
 	/* Write number of rules for channel */
-	rcar_canfd_setrnc(gpriv, ch, num_rules);
+	rcar_canfd_set_rnc(gpriv, ch, num_rules);
 	if (gpriv->info->shared_can_regs)
 		offset = RCANFD_GEN4_GAFL_OFFSET;
 	else if (gpriv->fdmode)
-- 
2.43.0


