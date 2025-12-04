Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412E7D24469
	for <webhook@archiver.kernel.org>; Thu,  4 Dec 2025 18:14:28 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.50473.1764872061680253496
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Dec 2025 10:14:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Son4kxlO;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42e29739ff1so579695f8f.1
        for <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 10:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764872060; x=1765476860; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCB6ErHg3HBJCpKTkqNetM5X8qwre32JJAbUTZr6jzA=;
        b=Son4kxlO3istCpWNSgyTmAox7sQSmJ0GT/E4r9bThjEIxBoTvalltP9M764q+5rDLo
         O8vnSpeOuC3GBKXLnXObaBCjvJeYAx2MFSwO1ROjvWr3aahxYg1N2a6PJFaatf3z/gI8
         vITptftVUI80iHSSMXeiUNRGB5qBikd2hiOBWUUnWFUEVa2V45cqFFeG+IqElZTlkHcE
         Q5x7gmAnSY1TEjYcIRFYRdC3vmUEOpgAsH5oIBsSIvWWJHP0cgdypZvWrnCi7URmXHl7
         zmNnbnfqXIfWgyoL10Wu1N8NVWjr4yTDmI5hBRWfllMhF6mG1cM56emnFNgFyTAlWExs
         +rxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764872060; x=1765476860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCB6ErHg3HBJCpKTkqNetM5X8qwre32JJAbUTZr6jzA=;
        b=wOTmhbTbeY5taWH69sfK2hGGqEWvZu9QSdftZIC4/tAJiIYhU2A32LGarpgjnLKHPv
         6NB1peRTmMoMLeoXkjg3k3PZpTtbdji+oCyM7buyquIXWv2Hrf5jIWBcg+XPlH7oaZI5
         3XWh6NgWsuU8q0gInrxw7SSKyil/wNBToEDTAD6gESxcvRy+Jp+5ZV6xcn9NkDJ5qRW6
         hj7nHrJf9Nw7EXE1TQBnARy4xKlfWjuCOLkKDJU594/peoc5whRUtxko3YeIghsaUbtI
         lu9hI4+NpXQDUPiAFdzULV8g82GbS2WcH2MHbQd3NRs/rj9jmtfe/ox0o9NVYA8tz4hv
         mQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUh0oWZoJJAbzge9JCaOIkKrWYeU/kvgN8B9sHO7POUDzHB2PNCuIp3W9MQEMq70BMiD5y016rP@lists.cip-project.org
X-Gm-Message-State: AOJu0YzX9/5gBjAzuaVnwTBLzu7wvKewGK8LjOiVKu/xXFrxhZFilCFA
	4Aj+/xCetrzTDwJbbrcXKImq2bUtfetOzt54dsrF5Nkw8dEKmB30ckXz+gFaENXcZrc=
X-Gm-Gg: ASbGnct/Lr4j1R+9E460dRsodYaUx2Gfs9N4krDgdY4NMYqeTzu5gwBqM/ioUtaRH+C
	Gat/yhyot/L0HE2lFCysdm6t3mPE8JkhYEybDvfPng3FqiD/klhm06nGw0Q7yJm0Q4wFkKMlC1H
	9qQ4lMaUZOTuuyDZDfxWyZ+sWvkwRkL+hnKld7EWXgrgItvNERrX2EztawYYGLkNlqYib6LK2Qr
	KBm013djVqr4eCuAi0Ey7e6SejLi2FfRfExufr6lBDtIuu7CRDMxvGeCFhvHrKjZG7UiEWstLrd
	A0k8xQ64Y9S4Qcb+F5tFlX7hTO5kHTPcjTFuc8SvAAAEZb8+lGwjprSo3DsBcBMTbB0E/vMNNat
	SZ+G+HPJWjV4gJ3biBC1f6NzKdXynK6CMvIqgB6XBE3R7YaJ2uvpxOSPZtEqb1Vj/ukHxqJYJV1
	6rFUYQRKPxDRvTlqNqLwEtG4/x6ZuWpxkbwwMabdGT
X-Google-Smtp-Source: AGHT+IGJ7QVd/gBk+Yx92olg/d0olaGuDC2fvhYfWrujyZaged1eZx2qoZ/CHV1apjr2aH1s8iraGA==
X-Received: by 2002:a05:6000:2889:b0:429:b963:cdd5 with SMTP id ffacd0b85a97d-42f7875f606mr4603818f8f.5.1764872059990;
        Thu, 04 Dec 2025 10:14:19 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cc090bdsm4381629f8f.19.2025.12.04.10.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 10:14:19 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip v2 02/18] of: Add of_machine_compatible_match()
Date: Thu,  4 Dec 2025 20:13:59 +0200
Message-ID: <20251204181415.689009-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251204181415.689009-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Dec 2025 18:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20849

From: Michael Ellerman <mpe@ellerman.id.au>

commit c029b22f8a98e14988f800d5c0176a9eaec3c8db upstream.

We have of_machine_is_compatible() to check if a machine is compatible
with a single compatible string. However some code is able to support
multiple compatible boards, and so wants to check for one of many
compatible strings.

So add of_machine_compatible_match() which takes a NULL terminated
array of compatible strings to check against the root node's
compatible property.

Compared to an open coded match this is slightly more self
documenting, and also avoids the caller needing to juggle the root
node either directly or via of_find_node_by_path().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/20231214103152.12269-1-mpe@ellerman.id.au
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/of/base.c  | 21 +++++++++++++++++++++
 include/linux/of.h |  6 ++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 1029173ded4d..013549c61be2 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -557,6 +557,27 @@ int of_device_compatible_match(struct device_node *device,
 	return score;
 }
 
+/**
+ * of_machine_compatible_match - Test root of device tree against a compatible array
+ * @compats: NULL terminated array of compatible strings to look for in root node's compatible property.
+ *
+ * Returns true if the root node has any of the given compatible values in its
+ * compatible property.
+ */
+bool of_machine_compatible_match(const char *const *compats)
+{
+	struct device_node *root;
+	int rc = 0;
+
+	root = of_find_node_by_path("/");
+	if (root) {
+		rc = of_device_compatible_match(root, compats);
+		of_node_put(root);
+	}
+
+	return rc != 0;
+}
+
 /**
  * of_machine_is_compatible - Test root of device tree for a given compatible value
  * @compat: compatible string to look for in root node's compatible property.
diff --git a/include/linux/of.h b/include/linux/of.h
index 4ed8dce624e7..65c0e3105809 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -398,6 +398,7 @@ extern int of_alias_get_alias_list(const struct of_device_id *matches,
 				   unsigned int nbits);
 
 extern int of_machine_is_compatible(const char *compat);
+bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
@@ -794,6 +795,11 @@ static inline int of_remove_property(struct device_node *np, struct property *pr
 	return 0;
 }
 
+static inline bool of_machine_compatible_match(const char *const *compats)
+{
+	return false;
+}
+
 static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
 {
 	return false;
-- 
2.43.0


