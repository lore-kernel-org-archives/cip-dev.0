Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8771F10611EA
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:30 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18693.1773227129643845192
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Qbx0YUHs;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.51, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48532925a4bso19972995e9.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227128; x=1773831928; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5lOCwcE1nbTc3unb3WziR6fBHvu6MKiwhNderAn8a7s=;
        b=Qbx0YUHs8V8Edq7EiDgch92e6p7BzAS2nHXsgpGv5AzgGsLnTY+/tIRmT5ZEITdoJU
         NyTYWHQIB7/eFb8tDc4rWDK132f9wrzXQiC/ryLWV2x3S7NQswNPvCXR+UPPCZVUI1q6
         4EH1Ap96F9MJUwyLLTFccLgmJ6k0v+kpAsCLXbEkH/YRrhKB0LpAcs2pRnwgRy0DDQ74
         0PE46Ys66JS98WpvdyVqFTzCcguSrWk8xyOq5xgKmKzRjhOK2KzFG1FKNzRkrDYSKAG3
         3d8X0qaiTDNcJ9YJqmE5AiCI7gG+LVgenzX3kyaRqduXngF2XOE+AcnhA4zWt2e2M0GG
         /NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227128; x=1773831928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5lOCwcE1nbTc3unb3WziR6fBHvu6MKiwhNderAn8a7s=;
        b=C+WS0X2e5SOFlg8cNdCY4PBRDUhz7yqJoQZnHFmzk+xC2vBPy4q4P84s9HWuIyp7D9
         rgPaScqxO5h/MfS8Sme2yuKwSsNckMgb+FC5nk9oj0wQUWcPdnA7PT9IfSc7JVJdF53H
         6jdN6VeNmqQhCbXOtWlNTIMlIKknbjqe4qY46ZWzhdUhsz3TWSTOIJqM2O7XkorzX9ML
         9J514MdD0oHp8KaYPBn7RoP+bW1R9VgmU/I8/kgb0Eerp8uLlPCOaZt+LZS+kOYIoeBh
         7GxxzPmgVXYQ3+OptV8Ft0EUhYFvbPghp99sq5PJYZZKk4sMrAAAX3kvsyQwGZfNGECY
         2eKA==
X-Gm-Message-State: AOJu0Yx9+2fbLl7MK+Ks3M417Rvcpc38PAqUN9afQ8KHic5mC+dUpW2f
	yFzYwvP9XJ/CIkYrnDiLgpR9i5rST0CV0HHYXZf4QNuWa6nakysPQl0XX+RiZib7xUvUeC44CA4
	xhDJ0
X-Gm-Gg: ATEYQzyEnxSMznN5cOKU3ASrm7nzhfCn3nyIpJgT1FNH/8wwjsJ4lpNHloPi4ETgSFy
	Dae06O5ongvP0qD07wmDJh8SIZUKElOiK7wJJL/tVthEt6oR7E/l94NHx9Qj5HMu0nTVeaZEqCb
	R/IE2CaYrFUziyxXyoVsCoTOnjZ2UJKX1CTsjYi2GljHzjpCp4TWTiE1D6Ty3081s13SAdvfh7t
	1S1Vb4cCVvjC1/E6pyTuhxciVeitbAc7wkHoCy39Q5mtjZQl/h8P092YYF73vEv/+vG4RoLbmGh
	KbNuPwD0aeDOoK+JvLVsbrBkxhvdBlvLBzd5ADe0mzTthOch8uQZKiWDE4qbHUNP1H/+05TAlpU
	KcxyxIQskOuuAb9I+wwL+jNH9/c053zFZCiUL7FJPZIBlOjIk0GWc3TqFHv1QlP3hIWaXI3Kys5
	GZryN9m6+cDyCbC4QQ6CoWqDV64hRtd+INCNofgEneEGcCm2EWxB1b0Hg79VLkZIk=
X-Received: by 2002:a05:600c:1f8e:b0:485:4394:b0e with SMTP id 5b1f17b1804b1-4854b0be737mr36698635e9.12.1773227127843;
        Wed, 11 Mar 2026 04:05:27 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:27 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 04/17] PCI: Add PCIE_RESET_CONFIG_DEVICE_WAIT_MS waiting time value
Date: Wed, 11 Mar 2026 13:05:07 +0200
Message-ID: <20260311110520.1938414-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22312

From: Kevin Xie <kevin.xie@starfivetech.com>

commit d5ceb9496c565eb5763c127c6eb2d2b3068ab1df upstream.

Add the PCIE_RESET_CONFIG_DEVICE_WAIT_MS macro to define the minimum
waiting time between exit from a conventional reset and sending the
first configuration request to the device.

As described in PCIe r6.0, sec 6.6.1 <Conventional Reset>, there are two
different use cases of the value:

   - "With a Downstream Port that does not support Link speeds greater
     than 5.0 GT/s, software must wait a minimum of 100 ms following exit
     from a Conventional Reset before sending a Configuration Request to
     the device immediately below that Port."

   - "With a Downstream Port that supports Link speeds greater than
     5.0 GT/s, software must wait a minimum of 100 ms after Link training
     completes before sending a Configuration Request to the device
     immediately below that Port."

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/20240328091835.14797-21-minda.chen@starfivetech.com
Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
[claudiu.beznea: fixed conflict by keeping only the definition for
 PCIE_RESET_CONFIG_DEVICE_WAIT_MS]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 38ad75ce52c3..8f47441b16db 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -11,6 +11,21 @@
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
 
+/*
+ * PCIe r6.0, sec 6.6.1 <Conventional Reset>
+ *
+ * - "With a Downstream Port that does not support Link speeds greater
+ *    than 5.0 GT/s, software must wait a minimum of 100 ms following exit
+ *    from a Conventional Reset before sending a Configuration Request to
+ *    the device immediately below that Port."
+ *
+ * - "With a Downstream Port that supports Link speeds greater than
+ *    5.0 GT/s, software must wait a minimum of 100 ms after Link training
+ *    completes before sending a Configuration Request to the device
+ *    immediately below that Port."
+ */
+#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
-- 
2.43.0


