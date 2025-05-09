Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BA6C3ABC3
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:13 +0000 (UTC)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
 by mx.groups.io with SMTP id smtpd.web11.10255.1746783129697255723
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=nobNuuHK;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-acb415dd8faso316564366b.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783128; x=1747387928; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9c0Lp6fdWJT79Lue2WvQ2hEHhhudoi0Qe3QHR3h6/kA=;
        b=nobNuuHKNdOV1U9lkNnTyoFkdoDrFrFycSkOVgGuvlReAMbLpwfx6wUTgW3s65P8lE
         QI3m0Mh5n1I+GmDUzF6Vt83Nu5AstSHfldtxbWEBC5++5BXtuaEohTJMLmN058F8D0R9
         mXlitG8XJg3ATWSxj2eTH+FN+o1Z7pAe7CWVYIBCbqhMq+8/jYaCGsKb61eAGi35W3oE
         opvy1uJHGmGtiZr6zAgIhQjmZxECFTNPjS9UxgiiX6xdwqdyBseZWI9D8SZTu9ejBYxX
         i9e1/1cKJ9tuZ7PwV1fPvtDcOsb3Xxb/WJV64++H05a/7Uuqj2MnZlzmUhn2syyzXhx9
         WqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783128; x=1747387928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9c0Lp6fdWJT79Lue2WvQ2hEHhhudoi0Qe3QHR3h6/kA=;
        b=lqxMFB+crFdC+v2fj0zI7a9zOnKMC+46KMTmTViSpStv6dp1np36wx42et4axFpveW
         EX1pJ4emseB65Nzyrpvr82amChAI9StM1kI0rKo3C3eVPJ8p6v0eNiiORTNNvt6rpEKq
         99cbpuegVfzBzwxcA2DgmsO5ti3XKDflSKzmnJRvtjk8LFbPNxhQo7994zqp5UNPomn3
         EJ9BasQ2ti2G/o8NPlfUE2nIgs4sa4PJ6UAfeuQtbL95rhGtRVUn6OeiOVXI+auHRbfT
         FyPlU/G9fBKiGC1iy+hYh5na4RwKHgBpMnYg5uu6cI1LfGkWgQga3KUtf+TI75ILyZqZ
         Sy1A==
X-Forwarded-Encrypted: i=1; AJvYcCWTf2zXWcv2xA11U61S+qQoSZrEKGYxDguqmHNdFxEExXDgPl5xyRBTM57lMDEOKHYww73Y6Flw@lists.cip-project.org
X-Gm-Message-State: AOJu0YxG2uh+GhGtyr+eq91AFH6Y4dE3UE6YVcBFdtnbDFJb27yhs3dh
	8lD5roojXFT7zJ+QNiKfqdf4Twoa7WMNd5ZTxKt/L/CpVWJGI5wuEX508Wu88jg=
X-Gm-Gg: ASbGncuokveavAYqWUJJJGmjhnGx81dcc/OE99s4b90685PPaaZpnVMh3seD8zGJqVr
	wy35LI4hhE0r37qFsGBroGvJ2/sB2liY+L91oqUdaSO8FWpi8t7Y1eRWAF0SxT6rgLbKVCarnlu
	YvtTPPHgNjNfr70ydTLN9/QVK6MSNN2c+EU5P+l62aa1KJeoKTKN6mDvxtgGXy/H8rqbriJ76TW
	JlLuqlV3ONNuXO06IfkIDyyZWFshkyIoWw/YlQPLSnmCLGxr7hOAcMr0ciqln2dQdkF+TgiKoZr
	Nkyf8NlFJdPn6E4I0Q5j/7+XtCL+D0h/OVQysG6DJizHaopa2dll/zQDHGeHlIeDFKFfAg==
X-Google-Smtp-Source: AGHT+IFqnObvN2CJIX2eewM1TmwjbOuzv8HIw9JbSCHN4h9SaEIMNWU9+zp8lnn73zl0T5sg1Hkvxw==
X-Received: by 2002:a17:907:a646:b0:ace:d3f0:e51d with SMTP id a640c23a62f3a-ad2192d52demr248983566b.54.1746783127876;
        Fri, 09 May 2025 02:32:07 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 02/29] ASoC: da7213: Add suspend to RAM support
Date: Fri,  9 May 2025 12:31:36 +0300
Message-ID: <20250509093203.4014750-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18789

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 431e040065c814448ffcc2fac493f7dbbfb2e796 upstream.

Add suspend to RAM support. This uses the already available runtime PM
support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-25-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 35aa9e6bcba9..d2bb12538a20 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2237,6 +2237,7 @@ static int __maybe_unused da7213_runtime_resume(struct device *dev)
 
 static const struct dev_pm_ops da7213_pm = {
 	SET_RUNTIME_PM_OPS(da7213_runtime_suspend, da7213_runtime_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static const struct i2c_device_id da7213_i2c_id[] = {
-- 
2.43.0


