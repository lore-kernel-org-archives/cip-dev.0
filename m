Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3343E105D287
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:19 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18648.1773227056383560929
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=eO+fsMiP;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48541edecf9so26124225e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227055; x=1773831855; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vuy4+pfZmkE5wckcKvG/7KBY3nKda2ljpwUxad2+Qkg=;
        b=eO+fsMiPswWAjfyDvJuhwekA3C8IINW5RwFS7pltezcuS66bDer0dcJFd3sbMLgVog
         s1ZiqSMSKMBiRkP+BZ+RUM4Z/wkm6krHOfwBh8EVxBStDEurlkK1v0z/zQWA9u4aau/E
         KlV4xtXMfHBWjQO2QiMck9rhmIu65DBq32FX6LAuIksZ+fZXtw83JZ+R+7iZwHOWvYgx
         THAU+15b2HrakMwUa814P3q7jlhX7ddTteOSeCEDPCT8P45SftHpCXhsv7k3FiLsq31S
         +UNoIg0vaBWp3+hWZgDeISCdbXGOwcBiO+h1lQOKEnoYoZTdC07l58K6pljGUlH+jwwp
         oREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227055; x=1773831855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vuy4+pfZmkE5wckcKvG/7KBY3nKda2ljpwUxad2+Qkg=;
        b=E3BZRW+dYrePszorKRzpIDSeEYUrotwu4Hh/cK0+E3LTeSp0wpmE+j52goofjV81zr
         doSTv3vBLi3bZU3vAcvJxDi4tu0KhuJq1GHCP71au/XrKN1PNQ0jWmPvDFMivvZ4xtQL
         w7B6L/jASjh+hTyZHvIVKtTbKIW5IK391G/WLaspeKFsAZFqu/+n34HEq+VdhD1M1WyV
         lOfgqCQQT5/g1ZmIzQvbPYoeqUdR3B9IRT/h+1QzFwRwvreLVcpHIaDQ4QDzwAAu3NMC
         ziBJ4u5xnEy9nE+9JI+LDs+7AYPJ2e412K1vS2Lfl7GFLIRq7LPT3CjUrDTqeZre2uPP
         7eAw==
X-Gm-Message-State: AOJu0YyxaIi8K39MlDMojDwBuEWKtKavAfHQV+qM8l3bLBzRm48HPQZd
	uw83vC4RLUIRFyyqCt4p2jhDVe4clT9FRflsQE8ojjdtZhvXKmV8i8rkCWfJzc7TbxU=
X-Gm-Gg: ATEYQzzno+tecNV4Rrd1hxWBr3Atm9u+1RbpKQ8k/RK65xAAlmxyYJLQU3ppAE+G4YH
	IA5ril6uFHMy09rAekYbTIKVA5O1RswdIouBjq+J0Hnv6pRgMjkwAPhW8Js0wSwuKG0cA3z7OZx
	4cfdxPahLNfiu1w4qlv7AW+3x1BV8c10jXqs0xxwlqhZAP/wSazg42pqYUqmCLwNOfXyLT573kp
	mzg6ag+lnv0vlsO8dN3pggCWNE0u/K3yT28bFiSeQbyvW+mCqRvSSNzn6A0qqXdG29CyBuwSzOQ
	28L2dUE6+RkvlK/Dr1epgh0T5iFMTIFRNqyXxe0TIbGYliP5q3ffSUixEio4gRIbUC7Cu4pLZxC
	dg5bmOgsjc+ETEPgzFNJyQpQjZdYuF/Ok8ulIfj13BI8HFv6MpVumWcrcahcTlwe/56Yq1UPpmx
	nWD97PO3t7Qr1x7QPXEfX0j2fLn8Lou8ehtmFPbR5tzJGesG6UQ1Lt
X-Received: by 2002:a05:600c:8b45:b0:485:4388:3496 with SMTP id 5b1f17b1804b1-4854b10f9bfmr31893165e9.11.1773227054772;
        Wed, 11 Mar 2026 04:04:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:14 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 12/28] reset: make shared pulsed reset controls re-triggerable
Date: Wed, 11 Mar 2026 13:03:41 +0200
Message-ID: <20260311110357.1938200-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22291

From: Amjad Ouled-Ameur <aouledameur@baylibre.com>

commit 557acb3d2cd9c82de19f944f6cc967a347735385 upstream.

The current reset framework API does not allow to release what is done by
reset_control_reset(), IOW decrement triggered_count. Add the new
reset_control_rearm() call to do so.

When reset_control_reset() has been called once, the counter
triggered_count, in the reset framework, is incremented i.e the resource
under the reset is in-use and the reset should not be done again.
reset_control_rearm() would be the way to state that the resource is
no longer used and, that from the caller's perspective, the reset can be
fired again if necessary.

Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Reported-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/reset/core.c  | 73 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/reset.h |  1 +
 2 files changed, 74 insertions(+)

diff --git a/drivers/reset/core.c b/drivers/reset/core.c
index 662867435fbe..4d1cd09096f5 100644
--- a/drivers/reset/core.c
+++ b/drivers/reset/core.c
@@ -208,6 +208,39 @@ static int reset_control_array_reset(struct reset_control_array *resets)
 	return 0;
 }
 
+static int reset_control_array_rearm(struct reset_control_array *resets)
+{
+	struct reset_control *rstc;
+	int i;
+
+	for (i = 0; i < resets->num_rstcs; i++) {
+		rstc = resets->rstc[i];
+
+		if (!rstc)
+			continue;
+
+		if (WARN_ON(IS_ERR(rstc)))
+			return -EINVAL;
+
+		if (rstc->shared) {
+			if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
+				return -EINVAL;
+		} else {
+			if (!rstc->acquired)
+				return -EPERM;
+		}
+	}
+
+	for (i = 0; i < resets->num_rstcs; i++) {
+		rstc = resets->rstc[i];
+
+		if (rstc && rstc->shared)
+			WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);
+	}
+
+	return 0;
+}
+
 static int reset_control_array_assert(struct reset_control_array *resets)
 {
 	int ret, i;
@@ -325,6 +358,46 @@ int reset_control_reset(struct reset_control *rstc)
 }
 EXPORT_SYMBOL_GPL(reset_control_reset);
 
+/**
+ * reset_control_rearm - allow shared reset line to be re-triggered"
+ * @rstc: reset controller
+ *
+ * On a shared reset line the actual reset pulse is only triggered once for the
+ * lifetime of the reset_control instance, except if this call is used.
+ *
+ * Calls to this function must be balanced with calls to reset_control_reset,
+ * a warning is thrown in case triggered_count ever dips below 0.
+ *
+ * Consumers must not use reset_control_(de)assert on shared reset lines when
+ * reset_control_reset or reset_control_rearm have been used.
+ *
+ * If rstc is NULL the function will just return 0.
+ */
+int reset_control_rearm(struct reset_control *rstc)
+{
+	if (!rstc)
+		return 0;
+
+	if (WARN_ON(IS_ERR(rstc)))
+		return -EINVAL;
+
+	if (reset_control_is_array(rstc))
+		return reset_control_array_rearm(rstc_to_array(rstc));
+
+	if (rstc->shared) {
+		if (WARN_ON(atomic_read(&rstc->deassert_count) != 0))
+			return -EINVAL;
+
+		WARN_ON(atomic_dec_return(&rstc->triggered_count) < 0);
+	} else {
+		if (!rstc->acquired)
+			return -EPERM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(reset_control_rearm);
+
 /**
  * reset_control_assert - asserts the reset line
  * @rstc: reset controller
diff --git a/include/linux/reset.h b/include/linux/reset.h
index 13aa754d2269..950e96586f1e 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -13,6 +13,7 @@ struct reset_control;
 #ifdef CONFIG_RESET_CONTROLLER
 
 int reset_control_reset(struct reset_control *rstc);
+int reset_control_rearm(struct reset_control *rstc);
 int reset_control_assert(struct reset_control *rstc);
 int reset_control_deassert(struct reset_control *rstc);
 int reset_control_status(struct reset_control *rstc);
-- 
2.43.0


