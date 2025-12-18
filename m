Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4F1D6E2C2
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 16:56:07 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1389.1766076965068885927
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 08:56:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lGoybbbH;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso9144935e9.0
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 08:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766076963; x=1766681763; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KR3JVLkko+7QDFGsv9NXqVf1ABJ3W+J3DLElNvRXVLg=;
        b=lGoybbbHPzWsZhlLCFwWJDh2wL9OwcD7/nrdJ5HP+X7nUUgHUDN9p3WZb0tfSU9gIS
         ckk1+Nma3tUI4iq51gL6Xiuz8aajvaPpPfM4m6k7nvxx1A8VuD1E6W08FhhyQDKZX66x
         Q0ryhQH/i9rmMFprY8qorjMrshGibDygcC34qEl5F9AnsNusm4wAZnwGn5eFvJpnlsWi
         N+9jthfhfCpfzuEfI4A5zjxJqzPDv9WBPz/y9tzrhAiqHpl6hz/iU4SegzudTC8KlKr/
         ai8RuLk+JHg8HZyecMb2WNT1r9BPCm8PtMwJ2cIldnsE5eBLFZG+2432Ro70l9Q+v0je
         MRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766076963; x=1766681763;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KR3JVLkko+7QDFGsv9NXqVf1ABJ3W+J3DLElNvRXVLg=;
        b=hjtkyadzbMEioNPbBeaRpU5egfkeMx5ixM3au1+LODGdoJXXVTdLXmRBGHhf8R8wu8
         Fvkp7c7uCrJeNNzS6xaNmgJrPL0NPWsLwuzusVBEIk61Ms1GnweuPi0SpeX+pLitSCOs
         rtq4mL8L44RGnAafVtBXuJQxAWKR3k06hzgTs8Fyc/yMBYtOFNCBPWvKli7cZ/gnldhI
         8pSZRoZHL7e4ycxkmHCWFuncLwGZHNstY/qQK+oKWeCcFrad+RtewY8IpV4jcDUfbjE8
         OsVVs1ouXTkq8YErvgnG99Rjqb0tFxCs/Q8ZCcsCxt9vDqTSqLz1pYg63jcKVy6fse7W
         1RJw==
X-Gm-Message-State: AOJu0YwG2nrcwR6F3gi2JAZ3AdvAMEA5iS3tN5fQ1tqYUuP65HTExmq1
	ZeklHEMB/WW1K9nsl1WNHN0eUkTFgvK30yr5JVjW7f+I7MQyelY9wRmap9ZEWA==
X-Gm-Gg: AY/fxX67uXwYDPwd3jNDGovl42N9CKRGkHTs/L1U/0gPbyXrmCpXZOsQ2KUCOGebwTp
	3yQOp+AWEiQI9XZoCWbf4D9nK1fPryJRWoPQ9yv7gcn8EnfiuXkZGH685ZGtJbMtviuliJnE/yE
	7AeuLUVrqM2eFqoK3hDRcpCCrmSMArKyyGnEpzub1+P3xTObnpd9ZSGupGwyYqEyhyFFZJwdQWY
	QxdESwT1X5U48O++OP+PU225/HRSgAb4nF6+hx7/fQznRbeJP2/L4MfHZl24YPZRSui0Fcx5n0P
	ardIxERCfe/W+MFjn+WyoJxPC6JI7i0N81dWhUBE9Q2PuWZ9XSRyzzOHFL7XeJUHBFC9mfQHphC
	TJhL/I3X4Iwytx4V1lkEivVdV6MO7TXUg5OF7t/kkqawYV8Aa/Lui/MQNh6oDVa9cTsRx9eqVHU
	hqhmd0fdANNXS+a6gjmg==
X-Google-Smtp-Source: AGHT+IFCb/a9HmHkgSg+xwT/RED/GV3+ODjtYRu3/Tjm7V7j5KdiNDFmUhfg5yigKHRXaUcJ8yCb9w==
X-Received: by 2002:a05:600c:46c4:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-47a8f9043bbmr247805535e9.22.1766076963089;
        Thu, 18 Dec 2025 08:56:03 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b1fsm6180351f8f.8.2025.12.18.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:56:02 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 05/24] can: rcar_canfd: Simplify data access in rcar_canfd_{ge,pu}t_data()
Date: Thu, 18 Dec 2025 16:55:04 +0000
Message-ID: <20251218165600.258194-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
References: <20251218165600.258194-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 16:56:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21143

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit f5e3150b1a0f0f80b162c1ac6178344959a2506d ]

Replace the repeated casts, pointer additions, and pointer dereferences
by array accesses to improve readability.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/4f43f44dcfda13d48a2c502648833934a51d9d6c.1749655315.git.geert+renesas@glider.be
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 0b47461bcb08..425abaad77df 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -782,23 +782,23 @@ static void rcar_canfd_update_bit(void __iomem *base, u32 reg,
 static void rcar_canfd_get_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
+	u32 *data = (u32 *)cf->data;
 	u32 i, lwords;
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		*((u32 *)cf->data + i) =
-			rcar_canfd_read(priv->base, off + i * sizeof(u32));
+		data[i] = rcar_canfd_read(priv->base, off + i * sizeof(u32));
 }
 
 static void rcar_canfd_put_data(struct rcar_canfd_channel *priv,
 				struct canfd_frame *cf, u32 off)
 {
+	const u32 *data = (u32 *)cf->data;
 	u32 i, lwords;
 
 	lwords = DIV_ROUND_UP(cf->len, sizeof(u32));
 	for (i = 0; i < lwords; i++)
-		rcar_canfd_write(priv->base, off + i * sizeof(u32),
-				 *((u32 *)cf->data + i));
+		rcar_canfd_write(priv->base, off + i * sizeof(u32), data[i]);
 }
 
 static void rcar_canfd_tx_failure_cleanup(struct net_device *ndev)
-- 
2.43.0


