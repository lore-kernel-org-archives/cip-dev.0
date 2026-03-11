Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B01B10611F7
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:41 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18312.1773227131155430190
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=bWFklwSE;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.53, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48540355459so25661025e9.3
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227129; x=1773831929; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G45v8/34jGnRP+EFcsH1nOx/gMPsyA/GhtIu2vKPxE=;
        b=bWFklwSEhARjz64GavAPNEo3nLUHGxA7K2OJmyFouJMBB1EWzn/EDQ1Q3aetgq0Oc8
         jJCwUb9zPdm2QU2Gw8mjBHniBVVNjhLE/EeyjtVCtxS8M8stSyxwU8JqE+/9JOnx7kze
         lAp85SyhM/2ermDP72osKPjfgPHhVhg02f7xQXXMwvdYG9XJooArpJ6lhoh92n2TATeQ
         R+YaFy2ZpQ/UK0xK/x/FreKfmLk+mfPZT3XyA+ywp8HBrKBBqAgHxjJIYhkVgWj04RPi
         4VLs05P8Xlp3elLqUdfITDE8PvvjJY6CprECX4dAN+17WbAFuQCWkE1TMGM1P979l2uU
         L4bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227129; x=1773831929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+G45v8/34jGnRP+EFcsH1nOx/gMPsyA/GhtIu2vKPxE=;
        b=CG+VhHnnGs3aCGdjpe7qXrXWzBNKAMiz0BImtY3uaNJYQzjkuDSfczQZ/CA7lQZ6JN
         SyykLDSXL5Uh/KeuMIf8Si7Un+WOLgRJmdY9Mb2uLUDmEyBhHN6LSRAI3vg6ZnyFQlVc
         0ob6bzsI0Q01M7yDWW4USOENHpSv4cM2FkIcLTcsG6qKu1tf66jw+IPwjdAsV/ExRKr9
         2TiABIFPt7niPd02Lu2Cn+Y/furtUJqZl6mtVw3OMWn1TmgXGuOfEYhzBdD6ql9Sblc+
         ZDIdfhBG4VqelrCi5bpMMuJOMgEDjAb2uxLEQgsxcxdJ+DJihd65WleTOWtFEKP+aXhl
         DMOQ==
X-Gm-Message-State: AOJu0YxGgXi0nTpo6P6qbGnqiWMiwPK641scbqSem44LQfpyxOQ+kF1T
	jHV2VdAo0cqGJ76E5N4tNT01Mw4bxXCL0gEASrDfpnGzAL8YUpTYG+TDvEDWFs/rtfw=
X-Gm-Gg: ATEYQzy2pCawLqsi8zwueBBjrQijjBrTrmg1ju9rO1WXqCTnPo9oS+apOOG8O26OdzC
	SxP3cD8TnxAJ75D53NzSY2F5cqhk8/dV/FVH6wqA6C3/Q0wxYZ/9SLlFIZSImTGn8+UbJlqiNk/
	1Gy05wArNIumYjq7xDvMFxWqn8pO4mJRI9VRGeGOXA11Nnla1gBVQlA4cMZHQRCUoLnWgx7VH6e
	yWN4FdLFnhEigC6VTReUuYdE9nErkvMxSA5pNh6WXk/un8JTeyKVzIru2NaHqcvQxSKUz70ZzwC
	z+XUnZoOnhMMqDKMNggFvdq3jmOkxksQlKrWha9bta19d2XZUdJYofqoJNG6uobqQSqj1OF1tx8
	WKRrDzg2vZGBZTkx7DY97od80n62KYfEzfdJe7xjXHMs8PCaotWOsspNOypQ+77Eg/L77wUogen
	3gJKK9KHIHKyFMT+5J+tnf7mMlq1Ru0tszZlTgtTcd9hMqPy3EPk21
X-Received: by 2002:a05:600c:a44:b0:485:4100:1eee with SMTP id 5b1f17b1804b1-4854b10c539mr32408505e9.24.1773227129286;
        Wed, 11 Mar 2026 04:05:29 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:28 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 05/17] PCI: Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS
Date: Wed, 11 Mar 2026 13:05:08 +0200
Message-ID: <20260311110520.1938414-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22313

From: Niklas Cassel <cassel@kernel.org>

commit 817f989700fddefa56e5e443e7d138018ca6709d upstream.

Rename PCIE_RESET_CONFIG_DEVICE_WAIT_MS to PCIE_RESET_CONFIG_WAIT_MS.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
Link: https://patch.msgid.link/20250625102347.1205584-10-cassel@kernel.org
[claudiu.beznea: dropped the changes for
 drivers/pci/controller/plda/pcie-starfive.c because it is not available
 in v6.1 CIP]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 8f47441b16db..f305fe8327d5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -24,7 +24,7 @@
  *    completes before sending a Configuration Request to the device
  *    immediately below that Port."
  */
-#define PCIE_RESET_CONFIG_DEVICE_WAIT_MS	100
+#define PCIE_RESET_CONFIG_WAIT_MS	100
 
 extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
-- 
2.43.0


