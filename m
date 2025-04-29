Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A8CC3ABA5
	for <webhook@archiver.kernel.org>; Tue, 29 Apr 2025 13:47:57 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.web11.20342.1745934468193605254
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Apr 2025 06:47:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=grqpZTy/;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.42, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac7bd86f637so1345455466b.1
        for <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1745934466; x=1746539266; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HUjJs53pECTQAQLLLIFnroxQozV2zkDi6pnqFMTwqEA=;
        b=grqpZTy/ulXjerMSslsUVR1778YtYT6NjA2nWxB4tPQbE/i7xRrSMxIULmX3RmAMY+
         0m8AcmPSPalg7Bk4IYOoMaw0YVDIku85PdZ+5rSC9thku2lmIRnwtuFlu1S7ZtDpPI0o
         pgr0ma3rcRDsTgJoo7Cr8h5rSs0Hip+EkclwB8irxgy21dzkqGnjdXIxialQN7MVvGSs
         8DCobN01N9WGT1oHlcbPj6Rq8TxGnQ2RGABoSk5912E/1RWH/FekPHb8TzEXLWdLQBtG
         IDKqN23nHNaigB5A+sKrhEtKZT2eiWL6TR/r2/1BeDfRDBoCho6soXFGOtNjAaighXTQ
         FeiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934466; x=1746539266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HUjJs53pECTQAQLLLIFnroxQozV2zkDi6pnqFMTwqEA=;
        b=rjZm5FvSSlqslWANqzgNJ0oZZQPRgCoKtNn7EuVi1Re6fVhkH69pgYqgOOGamoFr83
         RVYAu/goMGLO3v6DtoJXnWC/8mrJd6eWzFk3SkqIeU5QU0onCXWDvhYw8LuK3BDIVXzL
         t3/wr0pMxaB/WfwN1zKja0RUIAOP9MNkTDgq58GIPcZhtYXdw56Tg9/iOVcpsNWl5aHe
         rgNLUnB0IXAe6rclNM6vqOJL9uvIzXSc9m0QILSR+dlIEN1GMng5zPd/drWrWTME1dtA
         zMFl5OGEb/8JIjcKbInz7Ib8mmyg+S0vVJwgmbOwMtBM9h3AYhXVM4xqmoLllkILruZp
         mrsg==
X-Forwarded-Encrypted: i=1; AJvYcCWxyNLrccxj2aRvPMK4GzyxL011eEZgUVdm8UWqKKoP1YE9GbUv634sxPwlYVtVvcid4BR4a9A0@lists.cip-project.org
X-Gm-Message-State: AOJu0YziVacPzoJz2yIBScrsE/j2roiTQLjXYBaqmxIx/j7glv+U6TTV
	TWHI/2dxR6p3KIDq1A+b0aCTkWk1BCxlHHFw83cHWo/U4lJGl7FPPIF6oK2vRCw=
X-Gm-Gg: ASbGncsj3d0u1IDChMwZZ0p87SUj7fDiOTMlWPjqzYjVTh8IQEWj3x/yH51CbloEwVy
	wrNn/DtAYKQJQHDb2YcjC71OgVDGqMkBOI2u4+eiETfxWx6H2G6MyXqi8Ktc/4s0C7yqIvk9hmp
	1Mrk179wr1hQYyL6MSCzGs97/iBD27VSyKXrTPZaGW5stA+EeLixZwVYgURSUF57x/pwmvYMdge
	qSQEr4A5lLLVFSXR/5NhD5FWACgx3Ca1P5y7MH5LfklpjegL1yXh1/b0UTB+i3AqwP549pZl51I
	mKYat18bSxeTHEp+fygAGTh4v2GhZcikQ2h1CXiwTpag9hB+lIispDQUNo9ZXlj8Ms5GRJs=
X-Google-Smtp-Source: AGHT+IHda4ofzSfEPCvYmOhFJl7AXI6wrEk64ooqKdPSDgcjIkyAzojW+atGnXxDLBd5oxXHjJQZvA==
X-Received: by 2002:a17:907:2d1f:b0:aca:aeb4:938e with SMTP id a640c23a62f3a-acec6a2689fmr321752866b.8.1745934466604;
        Tue, 29 Apr 2025 06:47:46 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6edb1cbfsm776852766b.181.2025.04.29.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 06:47:45 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH v5.10.y-cip 10/21] i2c: riic: Enable runtime PM autosuspend support
Date: Tue, 29 Apr 2025 16:47:16 +0300
Message-ID: <20250429134727.2429662-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250429134727.2429662-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Apr 2025 13:47:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18723

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 10d5c8845d36ca71212f588849532c5f484111e4 upstream.

Enable runtime PM autosuspend support for the RIIC driver. With this, in
case there are consecutive xfer requests the device wouldn't be runtime
enabled/disabled after each consecutive xfer but after the
the delay configured by user. With this, we can avoid touching hardware
registers involved in runtime PM suspend/resume saving in this way some
cycles. The default chosen autosuspend delay is zero to keep the
previous driver behavior.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
[claudiu.beznea: fix conflict in riic_i2c_remove() as the function
 returns int compared to its upstream version]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 84f831635cd9..d3c17891970a 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -172,7 +172,8 @@ static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int num)
 	}
 
  out:
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 
 	return riic->err ?: num;
 }
@@ -400,7 +401,8 @@ static int riic_init_hw(struct riic_dev *riic, struct i2c_timings *t)
 
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
 
-	pm_runtime_put(dev);
+	pm_runtime_mark_last_busy(dev);
+	pm_runtime_put_autosuspend(dev);
 	return 0;
 }
 
@@ -480,6 +482,9 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 	i2c_parse_fw_timings(dev, &i2c_t, true);
 
+	/* Default 0 to save power. Can be overridden via sysfs for lower latency. */
+	pm_runtime_set_autosuspend_delay(dev, 0);
+	pm_runtime_use_autosuspend(dev);
 	pm_runtime_enable(dev);
 
 	ret = riic_init_hw(riic, &i2c_t);
@@ -497,6 +502,7 @@ static int riic_i2c_probe(struct platform_device *pdev)
 
 out:
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 	return ret;
 }
 
@@ -513,6 +519,7 @@ static int riic_i2c_remove(struct platform_device *pdev)
 	}
 	i2c_del_adapter(&riic->adapter);
 	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
 
 	return 0;
 }
-- 
2.43.0


