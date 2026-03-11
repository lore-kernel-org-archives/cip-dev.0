Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2928110611E9
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:04:30 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18659.1773227069269917768
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:04:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=l6WUGwqP;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.43, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso115081825e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227068; x=1773831868; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOoZ+gOHNP+15eUMT6RLzph0bHOPF7Dht0laagrkjdw=;
        b=l6WUGwqPyEF2zeX/pKnKlVHV0K+o5ZTkhn/mY3FxEdTArWvmtOjxEHV7bP6bX5TGOp
         LpHlgvXrFNQIcYxI24mLxL7RaXuytHdQ88lV6oTXiZe+UhW0zoI8bUOpMc5vHTw0M+hD
         dhKczat3JyaSFagErpIH1KN2Usgh3DZWrsQ6KLpNXGjGjCjK/IThUTzQrSHHawhdC9Mr
         82tZQRfLcBCes8JG8mj/Uioj3icZv7DfRjIPonzQb8iSc254Tho/ckHByLPymymbyERS
         940I9lZYJztwxJVcPF9iF5pQKqEyuR2Tgscep1FrLDYKlYhbKsl27EFfQy4IStMjTyPQ
         oD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227068; x=1773831868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OOoZ+gOHNP+15eUMT6RLzph0bHOPF7Dht0laagrkjdw=;
        b=w4CeQNCM85hynlUh9BsMFW8trWRyn971BtOL4cCBsSDRR0ZQLL0PZjOu8oFHWRy7iu
         U68wJ3vAJtaX4GCBhBZZqMjc9c6xsn67l3XmdhQem6D1GSoS3/WawBVcXrvqW2UeIWvY
         ruagSO6pxbuyVlVK+RJp5593bRjbO8QyYSAwvmSzrykqdAwzv4+57fEsR2SspYWySk6x
         jcFei7SRGU4NIZacNW/4nVAVL0BJnczQ9IaRZflIKJj+y0EXoIwtnSt7SsvpYKXWE9xC
         xiA8DIOlzsyArPwsqXVzvTvYYWL33ZX0FHXd7dB1tQ5Mk7a5zOr/C0NioezyusBUSPCD
         4PcA==
X-Gm-Message-State: AOJu0YzvOGlbpLGV+AbR7Eyyp9o7sqm8gltVWn0ASankEUdssE0VJpGZ
	I9N+u0KyuyLPdvlYzDCi+VUMJwxm+5exbccZdzz/KuTguFwG84IWZnzqcu7BQ1mZHQ4=
X-Gm-Gg: ATEYQzxeMYZIvC/56ZfCS/jaL0dlBlpy+xTzYn+oMdnFDj41J6YommunOC6A3ZCz8Lj
	bKlPleuL0N3kcZcw0STd1oP92dRPtpIioe13gGmHYONc+WUaOK7owrDBlworANMv8jNqD8br9FC
	CTJ5UrKHExmuzWeYUqWiIF5thtwSu9ws4/ay7hjbmnlKuixY3oblodk9ztxNIaWiOYD1TVYWTgG
	CKETwwf3Zul2X4E8nZaeUgszvxB4YX/U5823qk+H07yBguY3rBiLQ1uKCoqFpoptSDXaKoo/j4C
	uYyBbg6+0XNr7qmlJuuB9UTg+CLEh3OPhJN2wWubBSvus/pbHNV1XrOpNVdVlO7mZOFd5oUF1BQ
	uPM8zYg5o1kZWC6zSh2c9mJh/coKjE0m7e8Ec6a1tUYh8H2wDgF0QTk6e2/6UY9w0qw2DHfYIZd
	41WiDQryE6eaRdZASpfoFcJoOsoOh2PMNHBDDsuZhHHY9DPtpc6fgy
X-Received: by 2002:a05:600c:1f8e:b0:47e:e076:c7a5 with SMTP id 5b1f17b1804b1-4854b0ca217mr35619175e9.11.1773227067611;
        Wed, 11 Mar 2026 04:04:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25004085e9.5.2026.03.11.04.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:04:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 22/28] PCI: rzg3s-host: Fix device node reference leak in rzg3s_pcie_host_parse_port()
Date: Wed, 11 Mar 2026 13:03:51 +0200
Message-ID: <20260311110357.1938200-23-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110357.1938200-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:04:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22301

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
index 80d4a4623ccc..987015e8ec9b 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1181,7 +1181,8 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
 
 static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)
 {
-	struct device_node *of_port = of_get_next_child(host->dev->of_node, NULL);
+	struct device_node *of_port __free(device_node) =
+		of_get_next_child(host->dev->of_node, NULL);
 	struct rzg3s_pcie_port *port = &host->port;
 	int ret;
 
-- 
2.43.0


