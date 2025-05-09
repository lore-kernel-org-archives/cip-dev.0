Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225DFC3ABBC
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:32:13 +0000 (UTC)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
 by mx.groups.io with SMTP id smtpd.web10.10312.1746783128194227895
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:32:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=g9j6JEGH;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so3649209a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783126; x=1747387926; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BaJ5nKefVJ6sDsamtscW0tprMfBkdd8Mimlv9MVNRc=;
        b=g9j6JEGHHXxQ7OhlUTyxHc/78HnQfQxl+5j7v3z0jDwHyvPUsJAuhqjih3OMXLkfNH
         y2HvuIR3r8xJ+WiDNU1ykI4HIPHddTqjs7la4MyZDsLGs954IvH/jV+4cW7/t9PZwo1/
         QzraoXtXGghpm9e2GY5I5ZerFP7ITAd+ZZbfxP1cSGWY/vKKkZO70Yqyp2fvcMcJHTFY
         2HTnr5v20kRPjfNdHESInQpDRkpyfAFfbtWBEuthIuQG/g3shQV2wz/WXnY8kWZxvakx
         rvCvmvc4FBC7rnghJW5X906HYUomd1Af+G5XYz/EiGE1K39XSad+pg+JYvI6Jo/UKVk6
         CjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783126; x=1747387926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BaJ5nKefVJ6sDsamtscW0tprMfBkdd8Mimlv9MVNRc=;
        b=cSHEOVppOrrek6gj/VqztR5SpphbMyDlqauOUXLjg9oggNzHycvwd+S8cADCk+Dkmz
         QWG5UNQ2StKJU3v+q1qziTHagrsMd3s3VnSRCw00O8r0mdRaeOHIrGPYAEIjanLt+OAc
         I4jfTaF4CEy5jU+KIYgUCuN11H2PJ35AZLlpKvFbKCuDmPbFIPw5R8UFOmap0r+NKAf5
         HDJFgQu3LrouqHR6Grivg2Id8psq6m6okF33LjNITHgvhl++gJrsF5l8/z/V6ha4dii6
         rUqwVzl9bNM/QbEUbzVqN5u7ZYpvGfDpUvYk8z9cztXBbaFzLQ9+ANfPlxPvwwAPQsTV
         tvog==
X-Forwarded-Encrypted: i=1; AJvYcCU00mULdz0GFP591QPMKTl9N1sJYramoMKtkwnzSQO7/QhzR6zg6Sq+HHU4uGzdibo3QZol2a7b@lists.cip-project.org
X-Gm-Message-State: AOJu0YxsUhoZvM+XoORzBO3toUpOR1ZBzuGNI0GujkOFAEM7Y6bfxH1h
	YYfsnB2B9WOeCBuuS7OsF5WBPSATzvPqXx0xtfz44xp/8eD3PJKRprz3JzkP6nc=
X-Gm-Gg: ASbGncuIqHVevyzra+4BtreUpRL8BNWCuB1xNsZewNzf2uQZEwQfKIb9QQPithq+aEM
	/RmvgP8HFQzVatsoD71gNQ1xG5+W7mjSWJrTKplZA26Y0YTIsZSDL0mUh6Ylgl0Hw1cKjzRN4BV
	/QuouDMeo++wkqG06l+UttiT8WI8+rqq3E2veaz3eXTCJNL41eBPULWH3gkuRSDKJzf+ZKf9Pan
	L2R3rEMsLhjt90lEW6zZReX3egk3OP78BfMrfwJZk5YrbXx1R+W8vJIeab8LXb/reX4wWOshNwU
	EFdcaZwmk3KkmJaFlEvcZ0sEdH6/IyKTIgHUbigFiDddng1vhnEuBtMtlTzwmeOQXCtj1Szawmt
	PAIrg
X-Google-Smtp-Source: AGHT+IF9Yei4USTtaWr08Dk0pAtLR/IqKMdLtJoe8sLpfFWZfVhsJB/lAZPzABleyFgaxd2YavmTpQ==
X-Received: by 2002:a05:6402:34c6:b0:5f6:212f:ed3 with SMTP id 4fb4d7f45d1cf-5fca07707eamr2117083a12.15.1746783126563;
        Fri, 09 May 2025 02:32:06 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9cbe523bsm1128033a12.12.2025.05.09.02.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:32:05 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 01/29] ASoC: da7213: Return directly the value of regcache_sync()
Date: Fri,  9 May 2025 12:31:35 +0300
Message-ID: <20250509093203.4014750-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093203.4014750-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:32:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18788

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 841256954037ad80a57b8fa17a794ae9a01b2e23 upstream.

Return directly the value of the regcache_sync() in
da7213_runtime_resume(). In case of any failures this will inform the
runtime resume process.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20241106081826.1211088-24-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index f17f02d01f8c..35aa9e6bcba9 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2232,8 +2232,7 @@ static int __maybe_unused da7213_runtime_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 	regcache_cache_only(da7213->regmap, false);
-	regcache_sync(da7213->regmap);
-	return 0;
+	return regcache_sync(da7213->regmap);
 }
 
 static const struct dev_pm_ops da7213_pm = {
-- 
2.43.0


