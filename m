Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C68310611E4
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:30 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18655.1773227061886616503
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=fJPTbAk/;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso25853765e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227060; x=1773831860; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VtrLvHv7xX0GJn0zeooMsgxLJ5eqY+t0hMh/p07LfGs=;
        b=fJPTbAk/+zAaacmi/67KeE2k91bC0kZeSCMmVc2FTYqyRAN5u9fZl+pTNw87k6QJu4
         EUiy7z/rigilPUZJ8d/DBHHXuTXnP7CF1dOEy6PY53DzSKSI7sXHCkNSjDQhfHE0nb+U
         5+fub4nBbvVOQC21FC7/oKfvmPXgL22ibip1ljlb294FR+1QnyUCSlfzxVyXhSiVSvOe
         mKSv5DdnfF5qIFMRgyU7RnWrrpKKWlq/Nr9jVdObe1mYF9hDCRaGZ8ke9VUsYthhsOYB
         ScZ0GZSeLHYLT5w6aR07DRpRQGTY1PoYMhJoAn9LIQzj87P8eZ2/AfbrARfkJwEGRNw0
         ODCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227060; x=1773831860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VtrLvHv7xX0GJn0zeooMsgxLJ5eqY+t0hMh/p07LfGs=;
        b=G2s9b/4bT+LJ+HPxBTBAfcm9nzKC1ylBjSmOUWiq5baAmJoP+Vb8D1yWFp+wI4A2xr
         vhqPBwanMFrBmg7b5E/v0CZ5TyoEv3S/GQNHybpTVnpHG9VpHzL9vOGmdJJLQz5iN3tw
         h4JYYht7Z3HzCAooUNYOcUr1kzJm71Dei7PdElDyOaD4q+gyPKrrWyX24Yb/zDDxmID/
         G6Mq09tosLn98kEopunY38ZTslQGiIyUzuqpOOilmAQ2oV9GpKcQu/hRpmrE5xJuBmuE
         vz7gvtwyfiPUyjbHu9K0Y8jB3Rw/dc/ORqZhW0B3PrxpUR3Dz3CpDtntal8LfCE26Pr/
         0OyQ==
X-Gm-Message-State: AOJu0Yw7Ry9ORgW9ffkgqc1E1z5TzQq65g8i2OdHL71jZIlppwOVNFa4
	qO6e3myFEGthzAvCXQKOCI2sEVkWq8O2r3bKAp9CQQy9+p3h6AiCogAVKSsuVJj6qhk=
X-Gm-Gg: ATEYQzzoNf07CjjQt8+NobcOmkl4yD86mltgCJkqtVcZZQSrI1ObYMxMiMcMX09RkCS
	QcwVSBlJjrWTH2/tGX8f5hzXNvRj2ADxmcKVsT7er17RYu0PJyj3wKOJAjDDJ+D5ap9D12X58ni
	2eG2LwrfqvSoJZN5mKNV0Mg+i14nEZaeGfL735Dh5Fa49ibY7n/An4qw0/hj8cdq7saj+OBUAfx
	+sSyfZKBNv6Rt5rhfg8vOkNKtaj7TlpnC29bcQkkhnyJJ0pFciE/Xi3pjBXegoNDPNe+h/nFz6K
	soFpwzshItNdee36wcEP1RRLEjXrXPXNrr7y6nqRz3hf0jqC2zFfM8kzaaY3AabTxo+CP9gfD3a
	fesiVL34FecjVDk0zyvpaEbtv/BO0/kh761ueDOJvFOjWRozGgKdUVCUTCwSmvUlm54jCYzx7Qw
	+gE665fDyLWx4IVZKvhzGUeJK3eGI5KYjM4mpiEYPqXAp0CMZ9Y9qy5qK5qt9j+rc=
X-Received: by 2002:a05:600c:3490:b0:485:39d4:2dd9 with SMTP id 5b1f17b1804b1-4854b13e2c7mr32660375e9.33.1773227060248;
        Wed, 11 Mar 2026 04:04:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:19 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 16/28] of/irq: Update the out_irq->np before returning success
Date: Wed, 11 Mar 2026 13:03:45 +0200
Message-ID: <20260311110357.1938200-17-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22295

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Upstream commit c1e459d72448 ("of/irq: Factor out parsing of interrupt-map
parent phandle+args from of_irq_parse_raw()") refactored the parsing of the
interrupt-map parent phandle and updated out_irq->np before returning
success.

This change allows declaring interrupt-map and interrupt-map-mask on the
PCIe device tree nodes representing the host controllers, pointing to
itself, making it possible to reuse the RZ/G3S PCIe upstream device tree
format in v5.10 CIP.

Without this change, interrupt-map and interrupt-map-mask would have to be
described on the PCIe port DT node, which would break the DT ABI.

Since commit c1e459d72448 ("of/irq: Factor out parsing of interrupt-map
parent phandle+args from of_irq_parse_raw()") spans multiple functions,
and to keep this backport minimal, only the relevant lines are updated.
The functional changes are applied only for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/of/irq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 691e72598f70..50f998222569 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -271,6 +271,7 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 		addrsize = newaddrsize;
 
 		if (renesas) {
+			out_irq->np = newpar;
 			if (ipar == newpar) {
 				pr_debug("%pOF interrupt-map entry to self\n", ipar);
 				return 0;
@@ -279,8 +280,10 @@ int of_irq_parse_raw(const __be32 *addr, struct of_phandle_args *out_irq)
 
 	skiplevel:
 		/* Iterate again with new parent */
-		out_irq->np = newpar;
-		pr_debug(" -> new parent: %pOF\n", newpar);
+		if (!renesas) {
+			out_irq->np = newpar;
+			pr_debug(" -> new parent: %pOF\n", newpar);
+		}
 		of_node_put(ipar);
 		ipar = newpar;
 		newpar = NULL;
-- 
2.43.0


