Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E9710611F0
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 11:05:30 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18691.1773227128063911979
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 04:05:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=cgyAg+1E;
 spf=pass (domain: tuxon.dev, ip: 209.85.128.47, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48529c325f0so37133615e9.0
        for <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773227126; x=1773831926; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zi7QtTjmf3JBTGpHNfrjzuEqa2c9T9ut5WEDjEFSlwo=;
        b=cgyAg+1EpZmZA9+19uJf1KCeFqJsMEpwgauwOxvj8cMeSjnwFQTMlrTqQkgsnoAwTf
         jfDtKyMCEuZdLAssxmZTXwW2QADuCe8QW8//BSKq+jwm/wxNYkS9/Ecie9hm4+bPmyep
         y/aQaLmDPEaLUA+2/sSkQIqOoKP3/KFPkJol2942/iPat+vn/Lq7ecUsxdsqF5WnrM44
         yAmFCPMVd4YG7x1O8h7U0YGLNb/heo9YYhz00zCx9Vi+hp6YT8CWs5S93FKC9rOEK3wy
         jmr+pmWGF8cPL+HusIlOog+WzkfsWxImPhj2o4b0ZVWJRxD2r+67ikfXySk9QmTOKjqK
         gmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773227126; x=1773831926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zi7QtTjmf3JBTGpHNfrjzuEqa2c9T9ut5WEDjEFSlwo=;
        b=sPalJRjzo4lB8CwYp1uuV4mQtM1o1h+1qrAwlsmEtVddyKG5STp/UNo6mlTN3dnYUS
         eznwHUzN4D+rUB4I2VW1rBW8gI+5tNhv5KeaifbXtlrjb0HrYw3PFC8Q016AIhUkOaCx
         XW2U8Eb5ePENuSZgFYpzYRytczvBkJI3qLPnecLpxPRtKz/14W+C8dMUhjZ6PzIalBwW
         7VcNh2Bv1AwYCg05o0PqLjuy4M+u0GaYLSOq3vS/SPaJ78zQ3NssIBNE7i0tZgZD9brB
         Xd+PohEb3F1ReP8GX7mLYXYKMR+rI6/tz0vhu80SzE+wuvrQBQZ0fzr2hOe/8LlS4QAA
         Aofw==
X-Gm-Message-State: AOJu0YxYZ+XH5i2OOK6o9h0UySneVRuIYQxDpyAtFqLCVuCxnmRtrPVH
	3YsP8XASvF0RL8Y1kd4S5fdGYhFpioxipU6RUZxQxaw2PNjCwtk5dGOa0OwhizYvP0M=
X-Gm-Gg: ATEYQzwqRl3NqjUn0ovxBNeb3nLK2WCqu0YftnaKVg0NBwlEin1Om5o1EdjQ6tVcNrt
	QrFHEqv1TadR7F7DPM3KfIMuDoBrJUmjMsJDPcdmkc/mpyttTV9noiilBorscsBgejP3zzONC35
	s1GlFnaCLHfZf2Ds+gHZvvwGDWdILjHEVlQFqlyFfnIFHRHOAkb2cusznIHWs+EY1tnSjIyebOm
	s7cEh1vZ4Ve8M9Z1XtNcjw1jrHjLt7IHG6JXDEohr6YsxmDOvhcnmxQW0AGTb3UvYJRzHwv2+At
	SJ13b9ZGWE2AOG/qiBfQyjzF5OMglUio/8QA7pGa23Qn/PnBcRICGJ4yLCMwtf6E8hMaELGMHCT
	OMtdTSjpgdpDXSuO1iwPsE26e6Pl2v4/dVu8oR6o8YYYp4tb4R9REoojYsPF9ifBjs2COhDD6Z4
	t42kujpI8I0jbyffrg0fB558g6YWuT+GQWCF6CdcR3Iuch/M7wwAz1
X-Received: by 2002:a05:600c:4583:b0:485:4278:2558 with SMTP id 5b1f17b1804b1-4854b0a4911mr36594925e9.6.1773227126393;
        Wed, 11 Mar 2026 04:05:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2d7de3sm18998525e9.3.2026.03.11.04.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:05:25 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro.iwamatsu.x90@mail.toshiba,
	pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 03/17] genirq/msi: Silence 'set affinity failed' warning
Date: Wed, 11 Mar 2026 13:05:06 +0200
Message-ID: <20260311110520.1938414-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260311110520.1938414-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 11:05:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22311

From: Marek Vasut <marek.vasut+renesas@mailbox.org>

commit 5297bba507dc54045e6efeb9955c1271ca9aafe1 upstream.

Various PCI controllers that mux MSIs onto a single IRQ line produce these
"IRQ%d: set affinity failed" warnings when entering suspend. This has been
discussed before [1] [2] and an example test case is included at the end of
this commit message.

Controller drivers that create MSI IRQ domain with
MSI_FLAG_USE_DEF_CHIP_OPS and do not override the .irq_set_affinity()
irqchip callback get assigned the default msi_domain_set_affinity()
callback. That is not desired on controllers where it is not possible to
set affinity of each MSI IRQ line to a specific CPU core due to hardware
limitation.

Introduce flag MSI_FLAG_NO_AFFINITY, which keeps .irq_set_affinity() unset
if the controller driver did not assign it.  This way, migrate_one_irq()
can exit right away, without printing the warning. The .irq_set_affinity()
implementations which only return -EINVAL can be removed from multiple
controller drivers.

  $ grep 25 /proc/interrupts
   25:   0 0 0 0 0 0 0 0   PCIe MSI   0   Edge   PCIe PME

  $ echo core > /sys/power/pm_test ; echo mem > /sys/power/state
  ...
  Disabling non-boot CPUs ...
  IRQ25: set affinity failed(-22). <---------- This is being silenced here
  psci: CPU7 killed (polled 4 ms)
  ...

[1] https://lore.kernel.org/all/d4a6eea3c5e33a3a4056885419df95a7@kernel.org/
[2] https://lore.kernel.org/all/5f4947b18bf381615a37aa81c2242477@kernel.org/

Link: https://lore.kernel.org/r/20240723132958.41320-2-marek.vasut+renesas@mailbox.org
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[bhelgaas: commit log]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
[claudiu.beznea: fixed conflict in msi.h by keeping the 6.1 CIP definitions
 for MSI_FLAG_* along with the MSI_FLAG_NO_AFFINITY introduced by this
 commit]
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 include/linux/msi.h | 2 ++
 kernel/irq/msi.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 1bf8d126f792..074756e1991e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -416,6 +416,8 @@ enum {
 	MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS	= (1 << 9),
 	/* Free MSI descriptors */
 	MSI_FLAG_FREE_MSI_DESCS		= (1 << 10),
+	/* PCI MSIs cannot be steered separately to CPU cores */
+	MSI_FLAG_NO_AFFINITY		= (1 << 21),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 4e462b5f7bbe..f839a2a3a043 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -664,7 +664,7 @@ static void msi_domain_update_chip_ops(struct msi_domain_info *info)
 	struct irq_chip *chip = info->chip;
 
 	BUG_ON(!chip || !chip->irq_mask || !chip->irq_unmask);
-	if (!chip->irq_set_affinity)
+	if (!chip->irq_set_affinity && !(info->flags & MSI_FLAG_NO_AFFINITY))
 		chip->irq_set_affinity = msi_domain_set_affinity;
 }
 
-- 
2.43.0


