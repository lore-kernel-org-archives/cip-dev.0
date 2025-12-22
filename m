Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D63E6749B
	for <webhook@archiver.kernel.org>; Mon, 22 Dec 2025 11:17:21 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.78201.1766402237323414153
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 Dec 2025 03:17:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=h03TVDMm;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: biju.das.au@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so3183445a12.0
        for <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 03:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766402235; x=1767007035; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9b9V1Pyt5hg1998UzviVXo3nG7ipMD+7ZM3JyuTurU=;
        b=h03TVDMmTRd7ylW3NshqxBTpCQljJOcAvanGImW1NVoHGJG0soZhZ1o/sC7Vc/JqYx
         M2xiRiJjOAiiT8pouf3YbcxX4e38DQsxzW/5hRehO+1Kj26pnJUWZ7w79uhdUT+gIdoh
         SvutgueHscm/sPUYph00z/pyBX/7IKSPTXr3I7NIxuzKfwcF7oBK5URT8itB/EsCV5ws
         Mz/Frtl58nzLGUbVyb9gAoz0gWaN1gtGTBAXk4LTMY8tF83LmmhqdMUKiFOQnMWychmC
         k/IWnQ6LQlZVFQpyxVmOoPQKHyZ96AFiO1bfgtOoqNMV/EIRGR86yiGb9nPZOHHTBOaw
         //qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766402235; x=1767007035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y9b9V1Pyt5hg1998UzviVXo3nG7ipMD+7ZM3JyuTurU=;
        b=or7dD5eG4/gdcXv83QXBH6jtnE0ydHSGJVAcV2SQutCMHz8m6qe73UzaYdRnk3a0/+
         p6iOmCi+YW0AiEuGxcbV/uzxuvyNBF0ykz4mviTMVVuEN7UsxeZQh9X2q0wsbL9CxnrW
         4BDKIf+5UuJutUjg5XAejCHp/Z2R/Vn9BpdhU2N09cgRfD03YICepL9Gy/9ujkBZObOt
         OSPa+Y03Hmds0fK17l+nABYs+x75/OXVXZrZgjXQ94VdwO1gI7ZXLTqyztWiv9FdQbVD
         VC7HMGbALj/CzlQq4GpibgeWhVuH9sKRw41BWqD6qPj6yUIKsVS5W7U05AdbCUcszrGF
         /BgA==
X-Gm-Message-State: AOJu0YyRtl6W/BeMPO0zFJPepS0K7pYJYDLDggpCk4qqZt4wLi0SqY+c
	0nSaYXrsT3tIKOhdrDsyw8zuaoupRGLlttkwXvUMrRLv1uob0wC1PxCkopeYrg==
X-Gm-Gg: AY/fxX41Jrs0Tu8PE/TDB4uY+h5rLTl2PaSc87jKTzhyH0XAXgVWjLnswXaGvaIvM7T
	rOuu3zTzlIbLdI7s4iaxaALjH3nV0yPFU4up+9Ui1iBmFgDR+iKbEKAg0ov3rVUI2UQKEwUz1vE
	UqgWZFr6d0M5QaSkUBdZAoPaBRygTtj9v2vSuJr1tTluTCM39u6rRrKHQiMgXMTMGk0dHfkk4qs
	/BTu2TVeLuvNT3fc0liq0cDp8A+MKqdt8hDpjgIKRbnn5y6sFsVM7FMYVg3D5CLWimO+/V7BkWc
	vKZoarQinZM4oGI1Eq42AGDd89AyA7y/7kfPdOFlO3dOw16wPReqkh0HpWiMIkwopVv8i4yZR7u
	tSwDDbRZIuIlbA2DPcNPCRebZCKTVk1vjRVxCXknj4qzFQ70TcmLnqkk6vOVab4jEzFhCaBUyLD
	LlJ4i8xHDk5YlEWcAfvH4dgQnS8Pf4AObhC9g=
X-Google-Smtp-Source: AGHT+IGInaZQd3P+UHnIxgjiMM3zv74F2Iy4p9WDzRKDwlmfWrV2y+x5BADMy5PzLOi6j5q4XTbYIA==
X-Received: by 2002:a17:907:3e12:b0:b7d:27dd:9a54 with SMTP id a640c23a62f3a-b8020634a93mr1568597866b.31.1766402235390;
        Mon, 22 Dec 2025 03:17:15 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:46ab:7c54:6a94:818c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f13847sm1023592566b.57.2025.12.22.03.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 03:17:15 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 18/24] can: rcar_canfd: Invert global vs. channel teardown
Date: Mon, 22 Dec 2025 11:16:50 +0000
Message-ID: <20251222111705.27028-19-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
References: <20251222111705.27028-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 22 Dec 2025 11:17:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21204

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 790ec4c453890f1221ea595674a1206bbee41dc4 ]

Global state is initialized and torn down before per-channel state.
Invert the order to restore symmetry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://patch.msgid.link/20251124102837.106973-3-biju.das.jz@bp.renesas.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 7132db201a72..3924e46e448a 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2204,14 +2204,14 @@ static void rcar_canfd_remove(struct platform_device *pdev)
 	struct rcar_canfd_global *gpriv = platform_get_drvdata(pdev);
 	u32 ch;
 
-	rcar_canfd_reset_controller(gpriv);
-	rcar_canfd_disable_global_interrupts(gpriv);
-
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_disable_channel_interrupts(gpriv->ch[ch]);
 		rcar_canfd_channel_remove(gpriv, ch);
 	}
 
+	rcar_canfd_disable_global_interrupts(gpriv);
+	rcar_canfd_reset_controller(gpriv);
+
 	/* Enter global sleep mode */
 	rcar_canfd_set_bit(gpriv->base, RCANFD_GCTR, RCANFD_GCTR_GSLPR);
 	clk_disable_unprepare(gpriv->clkp);
-- 
2.43.0


