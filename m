Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D6FCF65C8
	for <webhook@archiver.kernel.org>; Mon, 26 Jan 2026 09:44:15 +0000 (UTC)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16236.1769420653372419944
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Jan 2026 01:44:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=he3AWgNq;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.65, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-4359019da8cso3787607f8f.1
        for <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 01:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769420652; x=1770025452; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ibU9rH95jj+mVJWHUT0sav+P5qqHr0n31/AAglzaF0=;
        b=he3AWgNq8sjAhD4gQmw+UiQKQLnPE1FSx8W7C0pNBeJSub7iW6cexpQglJgLZ0X53Y
         rxa68vt/+9QKMQmLJhymJ5WujpMb9IDSDxvfvtbiO9aQZJkIAIgJoUttZjYPZC6QNNu/
         cybeom7WNrERstdbs6AIl2Rfm6UJtTT/+O/ODvU5ka2fLpIWNEHrFhh+zq2jctPvfTXz
         UsdayuInyuFi6GVOwQz+NE0wonrgsb/En8o4t/RNr41Fq47cFt8o/UWX6lE9Ft7/fvk2
         3om0dgCjJGgEGN2nmkHeuTqqYe4S2q5NPzQ5O1ARn1mhNCjIoiQjM1Q/bXlm00MP4Uyc
         iNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420652; x=1770025452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5ibU9rH95jj+mVJWHUT0sav+P5qqHr0n31/AAglzaF0=;
        b=FaAIeaV4dAi//tdwedgf2txCQl6LU5zzQYFNAuLKkdiwrJG8MrGWWquPaF3yrn34SV
         jCfj09lfGR9xnQJYnEeBSp0OUjwbY7l6epyfMNoN0Os0odF4GiDHcyNvsk3pH9UHAsgD
         DnmTDdD9IKagN4csnVgXjBHaSnBRQCSZi73h1X5EbJLcxG1LKXg25Is+EGYem3QF/afU
         4RBKFoknYBCXVv3BQJf8SFfk43jz8jcLrz+NSY9/8fmtNXYe5v+oo5QsTXwPjUK7Cats
         IphulflnunlSxblCd/mimLy33ZxgI1ay9bm5TMe+gsBfevCnuEjhexnqQrdZtVOViGjJ
         3Myw==
X-Gm-Message-State: AOJu0YzF3sHpfYr3IfBRyirwa8sHC1ZCVkxdIf3jmh5njVUm3Y+LXYX1
	BCRV9syevlS9jTcIuy4H9N4JIQ3Z7cXw5GmfmdpD/eF0RBQmUwVnXi4d1PUaDFa8pOOilx6wld5
	71KTinMU=
X-Gm-Gg: AZuq6aIbJOt7u+WJg5w34Lze9mZI2j2XDqAwWZLNKNUpvPcJv/FYnKLPt2ksJHsmyPT
	hKeyl/zbgSqAycOeBZ7Rcv+AIFkySI1ObiyjdXMEFgHau10gSy1B7fPVhDggHOflyhD8j+ob0UZ
	9YBAepnmmfTSyzNkYK6Jf6rD/PwSn6ugwwAAqUP9blNUi7Wi/WEVPClapD++LYvdNJPgRhEQtBT
	fcvTTEZUE3g+c4ZfARZW4vkUUOc0IMirwCxhZg8DpUn0CoRcnJ7m8V8TuOCW8+h5GS+W24chZ+0
	Hyi2TqSfXg1nYpzgij9jP8m07kwXgItw8wGjalqQTkp34QvcgbO3KejqXWKmRMDun9FTwljMXgc
	x4a3pNykJRsMhIGdsrT4kfbHSxptY/lMQejfjv3sY5P70n5FGok7RCFCiTDEsxcWrCrglyVopq8
	EEkw1jRGS2qYgUYDJLdgxgprxHwO5NssaGvLma3aM=
X-Received: by 2002:a05:6000:2483:b0:435:9770:9ec8 with SMTP id ffacd0b85a97d-435ca1ad923mr6334682f8f.32.1769420651633;
        Mon, 26 Jan 2026 01:44:11 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f745c5sm29675520f8f.32.2026.01.26.01.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:44:11 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 1/3] mmc: renesas_sdhi: Deassert the reset signal on probe
Date: Mon, 26 Jan 2026 11:44:07 +0200
Message-ID: <20260126094409.2529052-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126094409.2529052-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 26 Jan 2026 09:44:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21717

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 15213383a3d9195db582729ab3feb923605b6f63 upstream.

Deassert the reset signal of the SDHI controller during probe to avoid
relying on the previous bootloaders. Without deasserting the reset signal,
the SDHI controller will not function.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 8b898d0229c8..bc1d6a877c0e 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1071,7 +1071,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->clk_cd))
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
 
-	priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
-- 
2.43.0


