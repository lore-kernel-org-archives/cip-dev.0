Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4405EFD7088
	for <webhook@archiver.kernel.org>; Tue, 17 Mar 2026 11:17:45 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.73596.1773746262465696269
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Mar 2026 04:17:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=nqDHn59s;
 spf=pass (domain: gmail.com, ip: 209.85.128.44, mailfrom: biju.das.au@gmail.com)
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48541edecf9so61294135e9.1
        for <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 04:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773746260; x=1774351060; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=znl3xqc2C/RHyCidd3hbffjBa6lEEEwNmQAZN+Htm8s=;
        b=nqDHn59skciuRFyEzDyaCm6SCfVUtHRd6aZ4hyXMx3zh9sEa3G0+QpNHOYEF7s/Y2l
         0QTLCpK16W1oW+CzrOlQ38kv8l86f3U8ZGCMEmv5WFtjc6q9EaRc8uigptwO3I7nPJb/
         Haq6Eo3cZtE2gkIWwTrODFA+TdXGnrdhmQOPLxYsolM4MnWx94nKaXVdv3sj1OO4UgdR
         oDfyOp0IHQKOyax8JaSw8r71lN7i8jufGRi6M6ulS7XwDqFqZb9RFaQprmlCCNd6VLY4
         kJLFRokYUcGx5pspBjU4Db0IVjf+XK0TQb8E+zL6AJ4pdJd1aK8cZ/20jBpQtR//baL8
         KMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773746260; x=1774351060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=znl3xqc2C/RHyCidd3hbffjBa6lEEEwNmQAZN+Htm8s=;
        b=L9VVHktcExu/XWSTxi783cF0kcfOueH8JaUIggu6MhtAOF6ejfmnuDmJOeq2LnNmlr
         rMXJktHzigpb0R2mZ+6QDfjgz7vVlqsMQvgseZ30ldhiopSBt7HUqvEECe5/fcZwqF07
         ctWk6w+2BWTJKXf2RfpMp8nr5dMNfWJISGCGPOUPVttAWqHUqT/mjjusfWYRNlHplKsE
         gF/CarN700ezh66AUb2K8UDcJS1iF2IgOvYn0IFH3o2A8iTiOsu5dFx1Z/iYH8eATsZ+
         QnwCOmk4hTNB8fiQ5T/KIErndJvOQMQ0iJFhosFzbfTwf5Kx7UvUdGU0O0ym4Abyoedo
         UhZQ==
X-Gm-Message-State: AOJu0YwIhmcKSxM82+pwsKKnKovVU+l1cYiClFJhLcqpIbu8SDj2V+T4
	FRZIoDQD+1B7s5eeAz9HoKsEPt2/jyqq8AdaYZL7zTEPsWUqeFdEU5ZqyALj3A==
X-Gm-Gg: ATEYQzwnYSNxEqZ4TntX0M0y0rI2tlJxQ3DaTTC8jnu7Ku/9PTikHYR8erZMBRFCCn0
	j/umldvm1NzgyVbL0Tm8BzPm6/+PbrmwePIXzSKIQ22W919+nJjokZpajavKpCxvNKAgMAqYSBD
	rvpPGXyOyLpqffK5aCEofw+Q3E3A7y9bjUxpDDUZlkL7echu3ZWmPZRHjXrEv5J5dk67OIriRx+
	SLlSSobvrvd1ArtW10yqcn84qndJUP1Jmql00K98co288hUJ4a793i26rAxg810Ima/zudG2p/w
	/AJk85Wc8w4AG8NUuXdjDvKNCvOBxdXRMKkiKwqvUqjTZYmwombi/lntQgZoQ+EAk2NuMUnRte2
	pTSIxop+wQc1w6Lh5xZwboHpZhM4YfY7ojH7ev/jCTz+q60e18zUHodDTH2iWzf0jzQItzsHe6s
	iVIIj8SN8BsmyO2cCfCGhYTqKB0w2yME5Mkn8Bix1y5xJGTrwudNG9C9C4AQ0=
X-Received: by 2002:a05:600c:5942:b0:485:38fc:7080 with SMTP id 5b1f17b1804b1-4855670c01dmr181502365e9.28.1773746260142;
        Tue, 17 Mar 2026 04:17:40 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:e16b:fc56:e220:9aa9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea8dd57sm59723235e9.3.2026.03.17.04.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 04:17:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 25/39] serial: sh-sci: Drop extra lines
Date: Tue, 17 Mar 2026 11:16:50 +0000
Message-ID: <20260317111718.281633-26-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
References: <20260317111718.281633-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Mar 2026 11:17:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22458

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit c17db4d06cabc7746d48d99c6245d19bd55077d4 ]

Shorten the number lines in sci_init_clocks() by fitting the error
messages within an 100-character length limit.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20251129164325.209213-7-biju.das.jz@bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/tty/serial/sh-sci.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3effde1090a6..b135914e53c3 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3194,11 +3194,8 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			return PTR_ERR(clk);
 
 		if (!clk && sci_port->type == SCI_PORT_RSCI &&
-		    (i == SCI_FCK || i == SCI_BRG_INT)) {
-			return dev_err_probe(dev, -ENODEV,
-					     "failed to get %s\n",
-					     name);
-		}
+		    (i == SCI_FCK || i == SCI_BRG_INT))
+			return dev_err_probe(dev, -ENODEV, "failed to get %s\n", name);
 
 		if (!clk && i == SCI_FCK) {
 			/*
@@ -3208,16 +3205,13 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 			 */
 			clk = devm_clk_get(dev, "peripheral_clk");
 			if (IS_ERR(clk))
-				return dev_err_probe(dev, PTR_ERR(clk),
-						     "failed to get %s\n",
-						     name);
+				return dev_err_probe(dev, PTR_ERR(clk), "failed to get %s\n", name);
 		}
 
 		if (!clk)
 			dev_dbg(dev, "failed to get %s\n", name);
 		else
-			dev_dbg(dev, "clk %s is %pC rate %lu\n", name,
-				clk, clk_get_rate(clk));
+			dev_dbg(dev, "clk %s is %pC rate %lu\n", name, clk, clk_get_rate(clk));
 		sci_port->clks[i] = clk;
 	}
 	return 0;
-- 
2.43.0


