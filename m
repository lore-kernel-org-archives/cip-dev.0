Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D8310611F1
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18316.1773227139856649728
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=G2TFFGwa;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852f73d0a3so37674715e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227138; x=1773831938; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+YcS2RNp0MZz2UqLDcejlLHES9d1b8nzx7wYeIvF4w=;
        b=G2TFFGwa0r79MNn96z3xggpWnuyMA8iCNI7FvBOFnrfoiRipGcf8+IiwjtzzTytXBM
         YLsKHOArYtjQIKcDmVIjZPARdVFoKIFf6w5XEZi3PI0n9SsXU9P0SklS2jKxPKnRnZJ2
         3i2rQjPntit6rCL6zj1ggcc5JNwSGMhGOWJ6NWKXrsXkP8QajY5JKa4Twgu2+yRvDcjB
         B2eXCOlrvJfwxylPrf2yNeUPqsBaIONgGogjfgZf25afNQGI1Z5Af7pKrV91fdo/NNHi
         /uwWCtsGIaIsonCdbAvUJwB+DaIyt3VvhAZNeVc3j1slmlc272zpmWu0gBW5dvwRneRZ
         tcEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227138; x=1773831938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+YcS2RNp0MZz2UqLDcejlLHES9d1b8nzx7wYeIvF4w=;
        b=r8p8ZA+FskI+1XO7SflUaaYoQWOeu8VKJoyc9MaPqvNLN4xfDpdmDJwoUp6fSfy7SP
         kbaYcD2RI6urCzijSDk/FjMcmXqoYmHB+c01uaxHGpPPOZzgBfrw0E+K1BC6ilXk8TGJ
         pudIXAV5ZCFGwgbZfaOa89RilLiTjHzUup+pgn59mWqUXRaZrVsTAjBp2OD10g2NBYJk
         WD5KGvT6LS529Q9Smi5tOgM+HWLTaMNLrROh2H0TFpc8Pdhp9R+ISoNYqd6oexMAUhnG
         WgkEa98a5YJzoRpU8r4Z4SAO53mC6P5722hJH1uCne4aq4ulPQ05AO4k6yen40twmNnm
         U9rg==
X-Gm-Message-State: AOJu0YyZbEKhfCV8X8qaF2RSKnGKYjQVWR88/8mi+Aj71wUzWZilTZze
	fQE/PhjuBG/tBduPreQiO/mdfIc0eRks52/OKoG6ftqQJseeCpVNRvYgdf1J+1vS81d+9B07B8m
	UnZ6T
X-Gm-Gg: ATEYQzxoFKfQ6PSoI3KkLu+b4io8fjQsePbD24HkY7L43NMYq91rzY/aWZaIl9TPwup
	hCZ7FtJBy7f+8OjAg3nJXQSvjBNYIz0siU8j+BAsBg8Av8yDO5jw2xirzJatMefNLf5rKhyF7c3
	h7bbRYpSTBmUsQuv0oBeqNzUUgoJV4kdwf+QSQCOqAd8eJ4dQj5Yec8OTh3bGil6TnKxubodxX0
	Z9lyVSXztKTZcsykotgqcurULRkpM1d14SxweG5k3lJoecjU0K5wjNShR5ykJWoR1GctHpxW3Ln
	t7FoQrjq0IGV9bOWUk0S0uoeOB/20SqPf5yOchU+kqsCHjsqoqywFjvDRzrCSHCtRMsoeqJqqKq
	00FuYiv3p6KFWMHalJ48uRpHFbS8Kx35R+Sm+lEjK2cB51gc5cbFhdoIvO6NG7ZovMlb1SGg78K
	rermyHSNPhSSLwe3wSKExjF0r7NRhtIezfWQG5Z+lsi7YyKUPJGpwQo9EIOYwA9Gk=
X-Received: by 2002:a05:600c:8209:b0:485:3a93:3aa3 with SMTP id 5b1f17b1804b1-4854b0c75b8mr35216805e9.12.1773227138229;
        Wed, 11 Mar 2026 04:05:38 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:37 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 12/17] PCI: rzg3s-host: Fix device node reference leak in rzg3s_pcie_host_parse_port()
Date: Wed, 11 Mar 2026 13:05:15 +0200
Message-ID: <20260311110520.1938414-13-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22320

From: Felix Gu <ustc.gu@gmail.com>

commit e43e2aa557040bbcc5de0eaa1c59ee3ae9e31793 upstream.

In rzg3s_pcie_host_parse_port(), of_get_next_child() returns a device node
with an incremented reference count that must be released with
of_node_put(). The current code fails to call of_node_put() which causes a
reference leak.

Use the __free(device_node) attribute to ensure automatic cleanup when the
variable goes out of scope.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20260204-rzg3s-v1-1-142bc81c3312@gmail.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/controller/pcie-rzg3s-host.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 5f007569d824..46be4dba46be 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1164,7 +1164,8 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 
 static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
 {
-	struct device_node *of_port = of_get_next_child(host->dev->of_node, NULL);
+	struct device_node *of_port __free(device_node) =
+		of_get_next_child(host->dev->of_node, NULL);
 	struct rzg3s_pcie_port *port = &host->port;
 	int ret;
 
-- 
2.43.0


