Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02DD8C4345F
	for <webhook@archiver.kernel.org>; Fri, 19 Apr 2024 08:18:28 +0000 (UTC)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
 by mx.groups.io with SMTP id smtpd.web11.15267.1713514698609912885
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Apr 2024 01:18:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=YM54hyn5;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e48d0a632so2558658a12.2
        for <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713514697; x=1714119497; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4Wcz67oEZr8bU5wYyLrP2VOiePGMSk0jp2XZj9rVlU=;
        b=YM54hyn5tI+8a6Gcfw5XSXKPVn3bCVsALRh81VPq1fk7brb0aVzGO3V18lOUaUIQmV
         TGx0M721u9xjE0BsGsh0hPE7maOCIbPaq06aFbcQ+xGxw02xjq6T9me7HDaiaKVz3Ssq
         Mtx3ccZ+DWJWYTM+vEAarf3t9HPuV+Qr/cpXqiUcCDFpWM/iWHY7OH6cyb3B/o16IyT0
         n20XdxLqwxqkiEn+0DyvU5rD76s0q+DwX+WjWyhYlkCXeo3cdb7hvcUtYKA1CpeUtycp
         bFwjekXZOhO2Yx4iki2aY1Ky4Jeww/19fQfoBStWjq1u/cVKJ+9hGoTnaLMXLWluoIfE
         jn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713514697; x=1714119497;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4Wcz67oEZr8bU5wYyLrP2VOiePGMSk0jp2XZj9rVlU=;
        b=JOflWvcxQfCCnMvPtzwD3jmmoNKDn0eHNSu5PRNP49wX3kkdn5KlOlCildX0tK53p/
         6+kFcK5LkElqV2XhM4208kToJ2h7ns2WDF2pzMMITxGJVYEyLECnCfYVvbgkiJ2xXB1t
         /XRgGd6bcVDoiwCDSCNCYQWCXlauNg8U+zgAagCkp0DMVUm0kP8Pu8L57hAtmrrI/lrQ
         qxeH5oCdxtNY0s1oM4Zw+PeZZvSxqPO2dg2k/haKo+rQ+FtrydRPNXjnJ4wRkr39fdnb
         MKbaQ9S0r6YxzcK/RvnCLwx7yu581iNXu3oe6xbMQAbQXXRrTQa+mQC/ovAUstVARrub
         8YPA==
X-Gm-Message-State: AOJu0YxtLK8Z4illmD/AUFIyqVjgAvUd1Kc3fOJh7FgBBs+dBEwb0Rvd
	e+qd66xwHAM2OlD2NZ+BrNX9wGlQHy7NqtUthKS3crBShEbxYDjZAkWbKR1upfc=
X-Google-Smtp-Source: AGHT+IFpTyQMpt8NKiNU1bfCfhtsVqb8QNy/k7S/lwVua6EbIUFrHizZNtnPEHooeqFuZp3VpUCUNQ==
X-Received: by 2002:a17:906:470e:b0:a54:c12d:2be8 with SMTP id y14-20020a170906470e00b00a54c12d2be8mr1226905ejq.23.1713514696991;
        Fri, 19 Apr 2024 01:18:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.185])
        by smtp.gmail.com with ESMTPSA id w23-20020a170907271700b00a556f2f18d6sm1816243ejk.57.2024.04.19.01.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 01:18:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	claudiu.beznea@tuxon.dev
Subject: [PATCH 5.10.y-cip 21/53] clk: divider: Add re-usable determine_rate implementations
Date: Fri, 19 Apr 2024 11:17:10 +0300
Message-Id: <20240419081742.3496709-22-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240419081742.3496709-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Apr 2024 08:18:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15608

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

commit bbd7a6cc382f4317b08ba71151b23abf76fc4c34 upstream.

These are useful when running on 32-bit systems to increase the upper
supported frequency limit. clk_ops.round_rate returns a signed long
which limits the maximum rate on 32-bit systems to 2^31 (or approx.
2.14GHz). clk_ops.determine_rate internally uses an unsigned long so
the maximum rate on 32-bit systems is 2^32 or approx. 4.29GHz.

To avoid code-duplication switch over divider_{ro_,}round_rate_parent
to use the new divider_{ro_,}determine_rate functions.

Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Link: https://lore.kernel.org/r/20210627223959.188139-2-martin.blumenstingl@googlemail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
[claudiu.beznea: keep unchanged the divider_{ro_,}round_rate_parent()
 functions]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/clk-divider.c    | 38 ++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
index f32157cb4013..24dd9897128f 100644
--- a/drivers/clk/clk-divider.c
+++ b/drivers/clk/clk-divider.c
@@ -342,6 +342,44 @@ static int clk_divider_bestdiv(struct clk_hw *hw, struct clk_hw *parent,
 	return bestdiv;
 }
 
+int divider_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			   const struct clk_div_table *table, u8 width,
+			   unsigned long flags)
+{
+	int div;
+
+	div = clk_divider_bestdiv(hw, req->best_parent_hw, req->rate,
+				  &req->best_parent_rate, table, width, flags);
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(divider_determine_rate);
+
+int divider_ro_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			      const struct clk_div_table *table, u8 width,
+			      unsigned long flags, unsigned int val)
+{
+	int div;
+
+	div = _get_div(table, val, flags, width);
+
+	/* Even a read-only clock can propagate a rate change */
+	if (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) {
+		if (!req->best_parent_hw)
+			return -EINVAL;
+
+		req->best_parent_rate = clk_hw_round_rate(req->best_parent_hw,
+							  req->rate * div);
+	}
+
+	req->rate = DIV_ROUND_UP_ULL((u64)req->best_parent_rate, div);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(divider_ro_determine_rate);
+
 long divider_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 			       unsigned long rate, unsigned long *prate,
 			       const struct clk_div_table *table,
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 54e19005e78d..75cdef73e751 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -656,6 +656,12 @@ long divider_ro_round_rate_parent(struct clk_hw *hw, struct clk_hw *parent,
 				  unsigned long rate, unsigned long *prate,
 				  const struct clk_div_table *table, u8 width,
 				  unsigned long flags, unsigned int val);
+int divider_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			   const struct clk_div_table *table, u8 width,
+			   unsigned long flags);
+int divider_ro_determine_rate(struct clk_hw *hw, struct clk_rate_request *req,
+			      const struct clk_div_table *table, u8 width,
+			      unsigned long flags, unsigned int val);
 int divider_get_val(unsigned long rate, unsigned long parent_rate,
 		const struct clk_div_table *table, u8 width,
 		unsigned long flags);
-- 
2.39.2


