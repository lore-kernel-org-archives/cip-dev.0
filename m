Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C38DD33A1F
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 08:35:01 +0000 (UTC)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31289.1768466099460289402
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 Jan 2026 00:34:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bMAUZGCB;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.54, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8718187eb6so93309066b.2
        for <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 00:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768466098; x=1769070898; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcO6bxC5sutfLiJ12bSbwxhOLw6VToCiNt9uC70tff4=;
        b=bMAUZGCBH2nQirnbDfaY0Jq25YJEWQEvjDuUpkZQjCVhZXNOT5NdXLlmYryePVj30c
         RcbQHkhOE5Q18TqeLDRYfAP0fc3zh8IxYuHcTydThZ5LmCwcaRSz9VGTefyd1t86qEN1
         v7J7gsHh1EHjbOr2Nf2pF/gzlA69dv7jBdCOPItsDKK6GiFk8iiXLqHnrYEXywaxTQ8m
         hLxRSVsETaHDGR6yzvJ125CHhzA79xY9wpxUx8oxeQ0/fQZwptHY+kI839MpmlC8vxZI
         mO/U8gGjtyU4LSW4AdwAxGO/Srr/asZv6Us9o+iiN1+vCWU0e9x3TlV2b4HMtK0gg3D8
         EB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768466098; x=1769070898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rcO6bxC5sutfLiJ12bSbwxhOLw6VToCiNt9uC70tff4=;
        b=wpH04v/QHu1garcYNq2CshPWktUUklAa1zUFRmA4p+ztiPOFA44ksjqYtf5LCPdaZO
         mEsMUJm9K4uhUzWudcnoPy8Xao15LgZl68J41j9UskK1mkalbNS0SBUvtK8mZK5zjZdd
         +5EtN9Hkww7+l5dwsaLHc3fk4m89DGiNNdyqd71g5em34779iGydLUYWatKNSjUhDd6v
         HFL1sRo0Kgorksy2SzFBZn7+c96wtqCKsoJ04rAa7dJCi+E6bJpiir8pZsJu1LuT+kKl
         sBM6vVvo9KGFDeYzg6ZQ+XDCTFkt/+t6NGBKnPsE7qRcj+VOcf74jUxtyZMXzHjK8Ad6
         0eew==
X-Gm-Message-State: AOJu0Yzd0xt8XvPmKj1V9Y9mh+IOvzyv78+wl/I5i4giShOgrE4bxuKQ
	JTviHoo5urNDyH17ZQ4QbbVUx4Zhigpu43ZeCAU8ugX6OBHsdsSgN9ehy38PH/C9x7UeNgvTnla
	FTF35
X-Gm-Gg: AY/fxX4HJmEpCd4n9ZYpIpye+9UDJI6UjxCoBQ0ndg8hCD1I7MTUlaYoEX4rknegxTo
	skkE5ym7GK171/7l+ethtt0M5mUWb3cwZZzzpTXP2YFi4b5ByoP+gGwUPF5MBUlS2/fCniy2m4z
	Fx+TtxxaSjjVOUWE7gzGBukoaFrJ4VTgPKxtR3Gp2k62jDURhAL0vszGWy3W94kBUamZikxN2VX
	b2didm4hFmHUDYL8qtsVNo/xRKtareVBddJOO34NKxJ+lp+E8LPO5GOVnAJaxMZ7f2yP/IY0M6/
	3ZZvmoXasYJFI0OGRVEfVpU784kY2h6rXb36pD4HTV6NLsbMOUNIkl0dEl4/QvRDLR0yQ70v0Ib
	fxRPlOqGoE+CQKl96yLSSk1T/y6wsbmO4H+nsjGv0MFKeiFvUDNiFPZKFOby9Oba9WFJ9nASWJz
	tdZcu3jrJdAYahyuBT6SXdQAlwvRBFLO0BDY7QJYrpq1vs7g5SRgda++3WkiqUXmyemA==
X-Received: by 2002:a17:907:780d:b0:b87:6e21:831 with SMTP id a640c23a62f3a-b876e21121cmr259233866b.47.1768466097787;
        Thu, 15 Jan 2026 00:34:57 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65411f70f66sm1915660a12.19.2026.01.15.00.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 00:34:57 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip v3 02/19] of: Add of_machine_compatible_match()
Date: Thu, 15 Jan 2026 10:34:34 +0200
Message-ID: <20260115083451.1064048-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083451.1064048-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 Jan 2026 08:35:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21582

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
index 788706579419..f61e2c1f7777 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -580,6 +580,27 @@ int of_device_compatible_match(const struct device_node *device,
 }
 EXPORT_SYMBOL_GPL(of_device_compatible_match);
 
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
index 44e432dbf67f..30d641eab476 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -394,6 +394,7 @@ extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);
 
 extern int of_machine_is_compatible(const char *compat);
+bool of_machine_compatible_match(const char *const *compats);
 
 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
@@ -787,6 +788,11 @@ static inline int of_remove_property(struct device_node *np, struct property *pr
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


