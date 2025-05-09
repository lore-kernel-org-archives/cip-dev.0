Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C320C3ABD2
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:23 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.10323.1746783141002647972
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MvKrqgwZ;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5fcaff7274bso423446a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783139; x=1747387939; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jh4mE/V04tw3VY0nYO2Q5lFwdkLo/svtNfCtK4+d/z0=;
        b=MvKrqgwZ9EUkVEzGOmKUPcFNtGSPcQkFR79fyCm81BSNfpall7ejoV9eyLTD+ZBF6l
         SaBIOy3goDLtqHTOeGmn8Ji210+iQnb8QNfZmoJBbiDYrQjkwPIQFdx82L2uiLfkL/L6
         WQivrXjBG1cT9m4a5GTYj8Q+Gfuj9e1d9GAMaWU0w5qa35NK741VbccqEYf/pIjHLleH
         Mt4F3jkpwBP3BEbFKqTyfJhgbdu9sBhzrJjXR1UqghnhPfqCgX2wbfoXdGDYDGXEQ5gy
         LeYTJ5OHiq/7M1CNXVPvKoe0F/WkTg1UP2kH/oGMPZDgCNfrQq4yNkYN2muPVXDBPnSS
         XaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783139; x=1747387939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jh4mE/V04tw3VY0nYO2Q5lFwdkLo/svtNfCtK4+d/z0=;
        b=sqO2KuhpeoIE6GSR5usK1Gjg3OPROBTYIy4LuneLFuBF2kJejjMLlMjXcCHPMcNqH7
         +ulsoCyaIDY9zULPHHH0RLrrki8fkzSQC4OeSxyrP+kQpryvQDbY/yiT8qIDmaQ3f06Q
         a2hJGfw8762XzK8UUE8hXm9JCnkeCXJaxQ8fhTiqU3BCBtyH8LLKT2kGJcL/9X0HIAdx
         DHq+Pz9aHJCCE3JpApm7ZqYPj0pbjmwfOEdgbx3DEcGCfu7l6g4sm6dr85UwLgHwY6lK
         2PdzeS9wkoq1W8RcfpZZH+FvendlVDVCX7o8lX6virMN1H7sNuTkBpNlM+2AqMsOF2fx
         rbqA==
X-Forwarded-Encrypted: i=1; AJvYcCUQUdrMUcZVrpmruE44XFpHwn1mArkSy6FxABXYazlVmCWH5SfiCbxJHniaDlxSm2jBpWipAYTi@lists.cip-project.org
X-Gm-Message-State: AOJu0YyzoyFCTPKx442XpdTINYN75BOEmIC+V9hISeTHjbXADUZYQWSJ
	Lan0AT6fb9SR53eTJKMOOF0hUCC8Ovgfp3LniOZpvoh72qWdt4mv2ncQQpzEAbU=
X-Gm-Gg: ASbGncv4+gNu/PUB5WI2/HLP3G7C570nqhnN/Gctnafvn7ZZtGfm47rbsDK4rxK9Qac
	KVlgz18X66uqj1j1O+NsGvgpO2FeEF7AFLjxx6qGwLlMPHt9ma4ekpU08NBXWDpiwKT+ReHHRmb
	tmbxI9cjfEFbXYXsj0eKXF5AtH3GUA3sRlxlAP6lprbblc70echqe6ctSf86Zn1WhqW4SAxmu0M
	gZptum0c7GWQM6sFONjP1AzjATFMNvJ95HQwo9p4iJ+npYJBHlSeoZ4Nhuo6EkMtZy79V0tu1GR
	Cm1kPoIE7rtlIMz1ZvHCs1X/gZWBptblgnR0rGxMAfX+qYwd+sNpA4ZIhE6YyNpBuAS4UQ==
X-Google-Smtp-Source: AGHT+IFQGBnr3+AEBvOAroJN9oZ2HIWXcp+1na2cPjOdlfNKuJrDokvZl8x7WhGd1ocuAt4Qq0BkYg==
X-Received: by 2002:a05:6402:34c6:b0:5fb:9f73:d0dd with SMTP id 4fb4d7f45d1cf-5fca07708b2mr2104868a12.15.1746783139336;
        Fri, 09 May 2025 02:32:19 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:18 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 11/29] ASoC: renesas: rz-ssi: Remove the rz_ssi_get_dai() function
Date: Fri,  9 May 2025 12:31:45 +0300
Message-ID: <20250509093203.4014750-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18798

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit dec61e16e72db196e8dc1daf7f7022fd98e6d921 upstream.

Remove the rz_ssi_get_dai() function and use directly the
snd_soc_rtd_to_cpu() where needed or the struct device pointer embedded
in the struct rz_ssi_priv objects.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241210170953.2936724-9-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index bcb9656853d5..be913a69bc4c 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -162,14 +162,6 @@ static void rz_ssi_reg_mask_setl(struct rz_ssi_priv *priv, uint reg,
 	writel(val, (priv->base + reg));
 }
 
-static inline struct snd_soc_dai *
-rz_ssi_get_dai(struct snd_pcm_substream *substream)
-{
-	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
-
-	return snd_soc_rtd_to_cpu(rtd, 0);
-}
-
 static inline bool rz_ssi_stream_is_play(struct rz_ssi_priv *ssi,
 					 struct snd_pcm_substream *substream)
 {
@@ -243,15 +235,15 @@ static void rz_ssi_stream_init(struct rz_ssi_stream *strm,
 static void rz_ssi_stream_quit(struct rz_ssi_priv *ssi,
 			       struct rz_ssi_stream *strm)
 {
-	struct snd_soc_dai *dai = rz_ssi_get_dai(strm->substream);
+	struct device *dev = ssi->dev;
 
 	rz_ssi_set_substream(strm, NULL);
 
 	if (strm->oerr_num > 0)
-		dev_info(dai->dev, "overrun = %d\n", strm->oerr_num);
+		dev_info(dev, "overrun = %d\n", strm->oerr_num);
 
 	if (strm->uerr_num > 0)
-		dev_info(dai->dev, "underrun = %d\n", strm->uerr_num);
+		dev_info(dev, "underrun = %d\n", strm->uerr_num);
 }
 
 static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, unsigned int rate,
@@ -992,7 +984,8 @@ static int rz_ssi_pcm_open(struct snd_soc_component *component,
 static snd_pcm_uframes_t rz_ssi_pcm_pointer(struct snd_soc_component *component,
 					    struct snd_pcm_substream *substream)
 {
-	struct snd_soc_dai *dai = rz_ssi_get_dai(substream);
+	struct snd_soc_pcm_runtime *rtd = snd_soc_substream_to_rtd(substream);
+	struct snd_soc_dai *dai = snd_soc_rtd_to_cpu(rtd, 0);
 	struct rz_ssi_priv *ssi = snd_soc_dai_get_drvdata(dai);
 	struct rz_ssi_stream *strm = rz_ssi_stream_get(ssi, substream);
 
-- 
2.43.0


