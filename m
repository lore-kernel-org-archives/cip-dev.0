Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F375C3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:15 +0000 (UTC)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
 by mx.groups.io with SMTP id smtpd.web11.10355.1746783307667409177
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:35:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=WrIhz0Ao;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad221e3e5a2so61969466b.1
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783306; x=1747388106; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vd3i8EHlSxWSMK6X6ydFckpCjxw2eiECQ+buRzK2BU8=;
        b=WrIhz0Ao3ebTH0ZVnm4KtVFnv9Ur+e2p2wqNV45oLEulr4rg6HoT+tpSvvhb+dhC00
         22Qzbn1UjourfgHpS6gdoPskdqKuEGEuCSqn+cEMi83oDErsJC3lx2LxWdHmpBA4GW9T
         tBpfNWTBmIiRSdoNq50GK9NucnMvWpO6pJo/DUsb/pAn4c4Dox1EQUx4E01EowUqOeST
         y9AkDv4qPPFgFsICXwS/6yB5V7UTPA1fK+gO2IbikzA6Ga6kAtDUofBg/uZKC2BiyfzF
         PdGWY1fkLabE5GN0+ry+/x2AOOPICjY+LvPGczwevtllbCBJo07JYHBUz+vByZmIKy5s
         FXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783306; x=1747388106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vd3i8EHlSxWSMK6X6ydFckpCjxw2eiECQ+buRzK2BU8=;
        b=GhJOHuj96tykGjbBOa9mIPihGopH69Vx5utf5LnAJe5Ql6RB8C5nKBAwgvmTf1NFhl
         vn00kXKlLh+wixBO3PpzFm/TstJ1/NcM7qKfgZLfhggx0e/WAfWTBQ7ZAQyx1NGuGCba
         DNVCET21fG3dskGGJa6HnP7nb7lggMBukoXkp++xhnlGr/eO9uFxyEd9P6pDs7b5xSrA
         QN+Fyd9GEgdkcx0lrPAEMDOPbcS9w37amuLsecUJVL0sOf6WfIgtwMjeshNW4epOPM4x
         iKzgqyQFBzyHTndfggqgOAWJ/LMR4Elmb7t8Q8R41E6TNbVdhr3btA5iQ3pzfw1tmRUR
         R8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXTw3GP6ScKiOiQrboDn9FRN814q8oYMlmrfoulT5bFQwK7Cigrs/qNxaOU2Fly+7m64DgUMpke@lists.cip-project.org
X-Gm-Message-State: AOJu0Yw8ogwC+wReHjGdKlmr/ynC0IpmSQ4jSajZs/JI0kC7u5k83eef
	5XIjxuJy515x9ezKWRLu2X05o//sCHiSQ1EAPVbeyykxchK7ZsC6ABjkvQSe5vQ=
X-Gm-Gg: ASbGncuT2wrSoGMtIqsQ26xdjppgTjrtP0bPnmn2Yj437wn+Vfvu0W8JD4GjkDomN7O
	fi3ZySg+tnLGV9wMv91J05/B8O0ZQjn4syn/6/yof5CWiOAVxlExp+C9aCthvwC7e3zrEoodcsN
	rxuEO/+GCfe0JHvI/w9haKVeekexT6H6NFBjBT0x9L+6Bu1d/ZqSw3YZwV8m93Wjr+cjWGPiw5l
	Jg65sv1TdTCpydWYiCxN42ds5CBBoWJqN8s6pUlpkNvMDsfBCJPVrbOAeNEA1d8ag8Xh/PNo7e/
	ubEGiwlsT6w5bGEHIrgEbuxQjOQhh56jzGeMP9b98THkSnFcghweIDUGzGHsQNhEAagxzQ==
X-Google-Smtp-Source: AGHT+IHxv1CKpqn/PjVXPJ7VNzmoP6PFeh9meevwx8Gevn4ERy+i/vOMNrlS3raks1bVFwdgOW9DsA==
X-Received: by 2002:a17:907:a0ca:b0:ad2:15c4:e251 with SMTP id a640c23a62f3a-ad218fe426emr285527866b.24.1746783305953;
        Fri, 09 May 2025 02:35:05 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:35:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 16/37] ASoC: renesas: rz-ssi: Terminate all the DMA transactions
Date: Fri,  9 May 2025 12:34:21 +0300
Message-ID: <20250509093442.4015145-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18868

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 541011dc2d7c4c82523706f726f422a5e23cc86f upstream.

The stop trigger invokes rz_ssi_stop() and rz_ssi_stream_quit().
- The purpose of rz_ssi_stop() is to disable TX/RX, terminate DMA
  transactions, and set the controller to idle.
- The purpose of rz_ssi_stream_quit() is to reset the substream-specific
  software data by setting strm->running and strm->substream appropriately.

The function rz_ssi_is_stream_running() checks if both strm->substream and
strm->running are valid and returns true if so. Its implementation is as
follows:

static inline bool rz_ssi_is_stream_running(struct rz_ssi_stream *strm)
{
    return strm->substream && strm->running;
}

When the controller is configured in full-duplex mode (with both playback
and capture active), the rz_ssi_stop() function does not modify the
controller settings when called for the first substream in the full-duplex
setup. Instead, it simply sets strm->running = 0 and returns if the
companion substream is still running. The following code illustrates this:

static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
{
    strm->running = 0;

    if (rz_ssi_is_stream_running(&ssi->playback) ||
        rz_ssi_is_stream_running(&ssi->capture))
        return 0;

    // ...
}

The controller settings, along with the DMA termination (for the last
stopped substream), are only applied when the last substream in the
full-duplex setup is stopped.

While applying the controller settings only when the last substream stops
is not problematic, terminating the DMA operations for only one substream
causes failures when starting and stopping full-duplex operations multiple
times in a loop.

To address this issue, call dmaengine_terminate_async() for both substreams
involved in the full-duplex setup when the last substream in the setup is
stopped.

Fixes: 4f8cd05a4305 ("ASoC: sh: rz-ssi: Add full duplex support")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20241210170953.2936724-5-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index ce0233e8879d..a2cae68245a7 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -418,8 +418,12 @@ static int rz_ssi_stop(struct rz_ssi_priv *ssi, struct rz_ssi_stream *strm)
 	rz_ssi_reg_mask_setl(ssi, SSICR, SSICR_TEN | SSICR_REN, 0);
 
 	/* Cancel all remaining DMA transactions */
-	if (rz_ssi_is_dma_enabled(ssi))
-		dmaengine_terminate_async(strm->dma_ch);
+	if (rz_ssi_is_dma_enabled(ssi)) {
+		if (ssi->playback.dma_ch)
+			dmaengine_terminate_async(ssi->playback.dma_ch);
+		if (ssi->capture.dma_ch)
+			dmaengine_terminate_async(ssi->capture.dma_ch);
+	}
 
 	rz_ssi_set_idle(ssi);
 
-- 
2.43.0


