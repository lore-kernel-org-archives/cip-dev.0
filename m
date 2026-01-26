Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB108E63C8C
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:43:15 +0000 (UTC)
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16214.1769420588878023249
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:43:09 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=OmN7qQDe;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.68, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4801bc328easo48759295e9.3
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420587; x=1770025387; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LGUB+0JW3bVki1ldQs4pouCVdoEm3APZyrYE1eq4W8=;
        b=OmN7qQDegokEIlZwUlpi0Q0JaDiYztHdCMC7WQKOtLEbufT6hLDNxXaaOgMjhgm6p1
         Ghnl28mzyOP3+Z6tYarrOKiK0RRHJpUNK5CbUDG83onqCD/TKrkAjXwHS+oMrpjGvrEZ
         3kcQXa3DVrDiVWcJGq7lhWVOxyEo/mrm6X2Hx7hV+QrbbUNVBu6apphq5NKOH3oDyWpH
         6wdvbmKBWOkAS9GUL6yztfSAZVn3WMNEWL43hE/mkBP0sPvThCSZSiJQbjxoIifnSedH
         UYPuRhr/Cm/cFQxERO55s0ieQmmaaEeIkdn81r1cS4LDR7j0TBQVsfVO1ZcGS0nT8eRZ
         cDYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420587; x=1770025387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LGUB+0JW3bVki1ldQs4pouCVdoEm3APZyrYE1eq4W8=;
        b=rJnEUrfl2lOtMTzddDqWUE75/fRlfs2qaxwxYfveyONnaxHb2BAVOS6LHhLlOGjAs/
         9rc08PCgL8odPpkKNleeTy6kORKZ/UFFYhmd3+GexLC3eZXTfP62j/vxx5kZxlWn0yeE
         HSeYaqpry2bWLGFJbC9r0eidI9jfs++BBsJHDTrB9Iuqis776IMzjyelmEuKk+69c4lB
         GMu859AWuZ1kYCvvh69QmSuQ0nghF9vu0ypfYNjIRa6socvDRniVpItCgn5OLvxz6eyL
         6j4x/ilKoqi6CrUh5DQNeZmao8FztQ/d1itV2wmmJmZweKL/QTzdqUwt2fx2ZNM5Pk95
         sS6A==
X-Gm-Message-State: AOJu0YzNGhSkehItbRySlur7BeryI7UH572Dj6fnYaesOX2Mt0MUGJai
	h3jqK18BWtLY5IK1oFNYUVr+1ySSLeU6odyFmP1vw469uxvMRREt3uFA+GIquODO1mY=
X-Gm-Gg: AZuq6aJRiQlM5Y6/QgIg8D+lt7Z46K28A+z2hhXOgcAaex5IxkrY/oJRBioebti2voq
	tOsBmqRAbCcxWDhCl3wvFfksv6FDdQAKobhOyGdHeQGdFTjRylzjBngYIsn51XeRkW1vRvSdhOm
	+xL82tkIMpqFJH2zqUq5LhIPFbYox/Hi0Zi7KKlGMrv4QvwSujqBF3YFVMK1O1xtPRPMVCv+Icl
	NDe4V5uOI3bmYPCNV2NOD3QGjIt1yPD8ufRs5H3BMfgfe9xBgFp+vkb67NDbbemVhwatdTu8DtH
	kE6zGRZxdB9qNaoXtp/pJknV93FDrkNaEM+if8KHAhnulxqC9htBhylk27Uy8mqpzxuZTc8PAX8
	/gnO1Ae8g880rm/v09l0sOwGT4WwEVVUKmrqOe85IPjKyb6b9zspkpGnkPBbOjSu4q04a0U1IgR
	75yeHV5tvn1ruJrD+aNOmGbG9KeoFA0pb/gZ2pQCw=
X-Received: by 2002:a05:600c:35ce:b0:47d:3ead:7440 with SMTP id 5b1f17b1804b1-4805d06c428mr65792315e9.32.1769420586919;
        Mon, 26 Jan 2026 01:43:06 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804d61f1f8sm101010705e9.5.2026.01.26.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:43:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 1/2] mmc: renesas_sdhi: Deassert the reset signal on probe
Date: Mon, 26 Jan 2026 11:43:03 +0200
Message-ID: <20260126094304.2528903-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094304.2528903-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094304.2528903-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:43:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21710

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 15213383a3d9195db582729ab3feb923605b6f63 upstream.

Deassert the reset signal of the SDHI controller during probe to avoid
relying on the previous bootloaders. Without deasserting the reset signal,
the SDHI controller will not function.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[claudiu.beznea: used reset_control_deassert() and added devm action to
 restore its action, as reset control API from the original commit is not
 present in v5.10 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 06c1fdf51250..7f80190713b5 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -975,6 +975,11 @@ static const struct soc_device_attribute sdhi_quirks_match[]  = {
 	{ /* Sentinel. */ },
 };
 
+static void renesas_sdhi_reset_assert(void *data)
+{
+	reset_control_assert(data);
+}
+
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops)
 {
@@ -1035,6 +1040,15 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, renesas_sdhi_reset_assert,
+				       priv->rstc);
+	if (ret)
+		return ret;
+
 	priv->pinctrl = devm_pinctrl_get(&pdev->dev);
 	if (!IS_ERR(priv->pinctrl)) {
 		priv->pins_default = pinctrl_lookup_state(priv->pinctrl,
-- 
2.43.0


