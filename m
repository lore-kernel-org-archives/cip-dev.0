Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B6DD2F00F
	for <webhook@archiver.kernel.org>; Tue, 27 Jan 2026 12:57:29 +0000 (UTC)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.10413.1769518648542759193
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Jan 2026 04:57:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=EG/Eg8EB;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.66, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso3484799f8f.2
        for <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 04:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769518646; x=1770123446; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GezMaTgnd/aiH/LUx7sBYeBHciHJn1iCbCUqQhWDXX0=;
        b=EG/Eg8EBnPx3XxNLoX/8zKDFwX5GqEp11b3A3nW7ntC0a88ZNdS1+7oPzqHGFbOsZL
         9q4F+SLILKmhC5pecrrYjeFWuq9NR1MbejXQTMMcMGAqz2AZpthYW1ms4Fo7RPF8ipXe
         vULVwP5ypR8uWZ+UDfvjbwFVbHuweSO01eaf5/uz/csstI+DuafQhxxDevBU0gdTCg8m
         7sjePmkrJ8L7FGy4jgJx+QWVxDf7HF8Qpt7bNpCJgbSsqzx3+B+ejiIiTfH2R2S+RNkG
         AkFbtdA7YfgNFuqgz4yOvdeJqR8vwBMpogrrdftKn22OTKRXaUwOuXvd4eGNSKSMUEjL
         FoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769518646; x=1770123446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GezMaTgnd/aiH/LUx7sBYeBHciHJn1iCbCUqQhWDXX0=;
        b=tglds1JDQlAIuhbJKBsOXEa4x8g+cx9DvavScYiWvVaUzUgcyjJn8zBNmF35O95bhy
         q7XyDb/xs2M2KIaNaUpkn7vI+/ChIFvPVdw5MMkzfHvqvbf0kiEOSs5bGagzLyRbPsjc
         YglwVA8tltj7rZrFQ24z0airr/nTIEaJ954bDASBpJLq8BFKNTlsn7E3oQcYmFzwbi9I
         HO8s6PgQcMurwv+Xsw+04DOc/zjVpDKA7ZgVdBur8Hy/quFrkrJ3bQtgWKG/KdQy/Dab
         YweUeXcerJCv4mvBlySmRIoovcUnJLoUaPt3Zk6Subgp3VyPEJoC7o2uR5UMLiwc6zXJ
         hwNQ==
X-Gm-Message-State: AOJu0YzZOt7GeE1uwihHthTpOefuTVX53fTixixdisU+gtVS3cAyP6RS
	BgDvBdQPyKVYdj65OW/CbF/2/AqbPpMuom3pFKJvyekYrSZaPam9H6gfXtgSa0McZBMD6Zdozxc
	rHelnvqY=
X-Gm-Gg: AZuq6aLf113UrTyrm9HgIzAfKXUGt8U+zVhGTeIAdmc5AbhFbfGrGgYA42N5PkzrWs0
	tnjrlBUgKBpjdoFIpdGcmaFyh7XtDLuq8YVGy7Yw/9YK/yUzdfnGdNY5iQeJKGXggCqEIb8xsEc
	qMFUi2q7pYZwAeaCMFOFbbhk/3Frb+nz/WdJXrfiCpmT9QrSI+fFxxgmnVxDfpkxsvsaG+lrKgf
	BbYSqkDR5d/3K17KC7e+FGZpXbhI/2DZwN/OzFPNai0GRenXcgwHiaULi+6RK88JvdFShEV/Zoy
	doDMIf+dk3fLBGEUnFnbMTmVyd4dmqHaMkr0LjSNMcTOAJPDYXyZ6VJkcEN3EEeNuQ1DAFaIwmQ
	m8JHWsJkA5Y3WKB+CNYmF7PHumvPtjfxAyfguW3aCnal8Su8033cRPLd0fBstbsPbeRTixbX6RL
	KfLn1IBrc3okuIlatzKlepPmS1K6E3/ZjfPV8MX5w=
X-Received: by 2002:a5d:5f85:0:b0:435:9756:d4c4 with SMTP id ffacd0b85a97d-435dd05b9e7mr2479258f8f.17.1769518646193;
        Tue, 27 Jan 2026 04:57:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm37089738f8f.2.2026.01.27.04.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:57:25 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 1/2] mmc: renesas_sdhi: Deassert the reset signal on probe
Date: Tue, 27 Jan 2026 14:57:22 +0200
Message-ID: <20260127125723.3705611-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260127125723.3705611-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 27 Jan 2026 12:57:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21727

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
 restore it, as reset control API from the original commit is not
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


