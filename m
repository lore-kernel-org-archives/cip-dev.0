Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB85106121C
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:06:52 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18350.1773227206392733015
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:06:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=JA5BvJFf;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.48, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439c56e822eso8500863f8f.2
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227205; x=1773832005; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+YcS2RNp0MZz2UqLDcejlLHES9d1b8nzx7wYeIvF4w=;
        b=JA5BvJFfSVPQWJneLbx/FDtfwhzXdZkYLvXFTrP++ql2xXMHenoqiBy+YBRfx0OwFI
         h35WAKuSZSoPsUzsuPMTDEKdHXhtvQxL6TgcxzP24Xxz/uzQa3f0AI3kYFX+MN8XI/+O
         jT3wfEVgx28NN4UqaMOR5fHsqjW04XHjBKWHwUykRNV0PcncNKLi7qfpjbsLS3aE6+uP
         mwSPLMU2YdeR78Ief80oTPv8fpMbwVb5KgJCfIoeOHoznAeKzS+8VmKah6kf/7UlBxrE
         OSNNOtHvn/1WzTar5mHhwabAxG+lfUvgLdt9VTmhbtDnBJoL4T0cK4voOsr2Iz0Uywwr
         lYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227205; x=1773832005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+YcS2RNp0MZz2UqLDcejlLHES9d1b8nzx7wYeIvF4w=;
        b=ovDmnnkyU2a8QdkN0oH7isWj05Ig2yWAfinZLFjPVQR+tN5Rl2FRtB3uvQTVFIqH8T
         2GsR9oV+m4wIuKOoGRZ5kiMM8Qi7mvZwScLuOz6r1hk2ITKRxO0Gi+PurRphQp8v5D0F
         NCJhOTvodEcONjo5QNzsLWwPjmBvK+ml91HFuL0BB4JoWPnHXV+aGj/sOUtcZlIhY9G9
         9MkEpqM97XipzjCEOpvRhbfZYdKs9BtJyGSKy0Tc2+Au46W4BQR8V6tJz1oMU5qtj6gg
         5KxnhxLugXct9v7y0tdxXosm099Z6hwS5/6AaOt47M4yeT2oxvxkZi4btDMf2vTWTCIB
         473g==
X-Gm-Message-State: AOJu0YzTZ+mPp9SFog0E1SCwNbp+97rCYykNZzIXx3g1gzg/HxUVj3Kj
	hS6pPtF+r7NOkbDcziTmz27atKDlnqWpeP7tGx89n6Yn5fVMfsvOmY0VbSHRVv9+a3M=
X-Gm-Gg: ATEYQzw1Ps9BoI3eZO0oGE6DPRtekNTW4bWBUiG8eb0qecXVeaKIZCLzK3YS5PghKaW
	Slr+/eCZgwsCcFfMXf0IydbQ5t4S1kthIJxXWOVoHoAGn5hpLAfpx1jqQHN8UczX5bixKawjV4e
	4ypyAyjEUlvS3driC8Ee0rjK6hC0fw5Ay81TGTGZ0OEy/TbB2WAHM5aWwpwW64Y2wdp9BWR0fxi
	05tdggFODd1xemAvyLDFmB41qMzo0Z0DgqsJr3eZ0w5fF2loOA2WnitdUseoMBFim7FDHFjr9jC
	Sj73KqmP1EWS/F6BNSE9ry15ypWuQ3jLlwahpf8Ih1tmXF7/xB/HLjkbPN2LjCKqQgS4X5WxTOi
	MM8RyXDoKhywtVr19zMisxCX9lf7wkp4gL31YzvaDN/gJZdCILXmvvsQ3H8MRnHmR06wgTwfIzf
	WGFNj3EeTVMAEBcPTJtUlJakyGb6kkNnt8Mnqo4aAfgWIc1B3gQQ8+
X-Received: by 2002:a5d:64c5:0:b0:439:f61a:e005 with SMTP id ffacd0b85a97d-439f8206d88mr4091303f8f.32.1773227204693;
        Wed, 11 Mar 2026 04:06:44 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439f81a3b91sm6378244f8f.13.2026.03.11.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:06:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.12.y-cip 08/13] PCI: rzg3s-host: Fix device node reference leak in rzg3s_pcie_host_parse_port()
Date: Wed, 11 Mar 2026 13:06:28 +0200
Message-ID: <20260311110633.1938579-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110633.1938579-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22334

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


