Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE03BE77183
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 13:06:29 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.web10.56093.1734354384235338149
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Dec 2024 05:06:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=jF4so5+h;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2633537f8f.0
        for <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 05:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1734354383; x=1734959183; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5WTfMOeQnyatCkmlJUET/8OgOE4TJUeRagKp9v+vQU=;
        b=jF4so5+hojp8zaN+GuPEY9mcGSIfCI67jbnQzo7PZ7zKos02yBzamFZzeJSnCHLifd
         SEFzAcPzxQMW5aXFUJnBr/1ppCvUjEyGKTHnQfY6RYWA81bF1HXLML4UDNo/JKUjQFuV
         Q7yqPIszk+d7dh74GUZIagmVQd0bzIgEY5V0DME1sYWqms1OUb55c72znIfxjByPspfu
         Ri8gJ30fpqyi1u9YlFsLg/i7b/jWXkNlQucovDm4sez/zRsP3sCvnFxB+qN6yF7URE4r
         qi8KZu/qLrG8Rm1TCsCGPVkeUHV5ISiVdM0aVVWTYXA4yw38vJBJZaJE44DOrKfbPsZ8
         U2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734354383; x=1734959183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R5WTfMOeQnyatCkmlJUET/8OgOE4TJUeRagKp9v+vQU=;
        b=m5T4mjmXQvnc0Vyf7qBap/p0ZcKvNOlpxKmq6PM4uhJoy8E368V/xJI/UKmgCdqS4l
         B9SlWlpRLn6SMQGKUF0046pmCnjuPrIUgrtkw737TeW86YZRG8zRpgD990OalJvTAcrx
         vDNyLEmYQQJ9t8TeryIG+H6CNDwfc6HT3bNrPruKsiAssy7YqhWnN+WOZzw8xs2RqMDr
         0fBT9fpUxOlrdOd7SoUmN8NiBuiWn3j3R3+2dmHvIjPHcTikD5dTP1Ni74dLatNeuxo8
         4PYs7gCo/+9MWhAbsc37m1DLVIG/FEh3kXc1nMsX5+OeTELsEGWTq4rpZpnSUmZe+8JP
         VoEg==
X-Forwarded-Encrypted: i=1; AJvYcCVp4OLFd6Vr8BIZxjsOsfzjFn2aj3zHcBJd/FEmbs4y2KtUXpfoPFnnks2RPoqDM1RT1VjFXX28@lists.cip-project.org
X-Gm-Message-State: AOJu0YxB5408R4brO05f6DOstnJkW6pC/Wy/0GQ2UZwjSBbpkt2BVnrL
	BFujIVa3jUJTg5S/pTiWnL4hte/QDw8CT260EYYtKxfieIeGm3TwcVGWHOOujws=
X-Gm-Gg: ASbGncvGWEVfExWBR/zuJhdlFm4gGeZKZ59cv+lzXXeAZMFJzsloA7815kxl6eEdo+i
	fq2lfuTAFHtCi0V3PI7/J5QaLxIby+uWz50O4A4B1l7gkS093C9UZtkis1+JaWPxFgXxqDy0utZ
	DE6CTIHhN8dKSTUQFQy9RSENF63A69UShhdZU/1ePTvxZcFHiUpK1BFMOyBY+DZsVMx8TLAKFA/
	wdB8SczWg2MWb8S0IoPYl+h6bjiojYCL6GLU/gQjBfaYFwH+NJ6F3BaoztVrrV5pc8Ylxf02S/Q
	y4AL7bBWOc0=
X-Google-Smtp-Source: AGHT+IFQbn7NPA/fYuRu4ddGksKntWi/EXHwarfrpzJ7Q43JuMsFVOLhsU5ZtC97GvvCICOkIEb11w==
X-Received: by 2002:a05:6000:1f8b:b0:385:f7e5:de88 with SMTP id ffacd0b85a97d-388c3645e83mr11245268f8f.3.1734354382506;
        Mon, 16 Dec 2024 05:06:22 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.102])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c801233asm8346252f8f.9.2024.12.16.05.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 05:06:21 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Subject: [cip dev][PATCH 6.1.y-cip 1/3] pinctrl: renesas: rzg2l: Execute atomically the interrupt configuration
Date: Mon, 16 Dec 2024 15:06:17 +0200
Message-ID: <20241216130619.321397-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
References: <20241216130619.321397-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Dec 2024 13:06:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17424

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit aa43c15a790cf083a6e6a7c531cffd27a5e1fd4f upstream.

Lockdep detects a possible deadlock as listed below. This is because it
detects the IA55 interrupt controller .irq_eoi() API is called from
interrupt context while configuration-specific API (e.g., .irq_enable())
could be called from process context on resume path (by calling
rzg2l_gpio_irq_restore()). To avoid this, protect the call of
rzg2l_gpio_irq_enable() with spin_lock_irqsave()/spin_unlock_irqrestore().
With this the same approach that is available in __setup_irq() is mimicked
to pinctrl IRQ resume function.

Below is the lockdep report:

    WARNING: inconsistent lock state
    6.8.0-rc5-next-20240219-arm64-renesas-00030-gb17a289abf1f #90 Not tainted
    --------------------------------
    inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
    str_rwdt_t_001./159 [HC0[0]:SC0[0]:HE1:SE1] takes:
    ffff00000b001d70 (&rzg2l_irqc_data->lock){?...}-{2:2}, at: rzg2l_irqc_irq_enable+0x60/0xa4
    {IN-HARDIRQ-W} state was registered at:
    lock_acquire+0x1e0/0x310
    _raw_spin_lock+0x44/0x58
    rzg2l_irqc_eoi+0x2c/0x130
    irq_chip_eoi_parent+0x18/0x20
    rzg2l_gpio_irqc_eoi+0xc/0x14
    handle_fasteoi_irq+0x134/0x230
    generic_handle_domain_irq+0x28/0x3c
    gic_handle_irq+0x4c/0xbc
    call_on_irq_stack+0x24/0x34
    do_interrupt_handler+0x78/0x7c
    el1_interrupt+0x30/0x5c
    el1h_64_irq_handler+0x14/0x1c
    el1h_64_irq+0x64/0x68
    _raw_spin_unlock_irqrestore+0x34/0x70
    __setup_irq+0x4d4/0x6b8
    request_threaded_irq+0xe8/0x1a0
    request_any_context_irq+0x60/0xb8
    devm_request_any_context_irq+0x74/0x104
    gpio_keys_probe+0x374/0xb08
    platform_probe+0x64/0xcc
    really_probe+0x140/0x2ac
    __driver_probe_device+0x74/0x124
    driver_probe_device+0x3c/0x15c
    __driver_attach+0xec/0x1c4
    bus_for_each_dev+0x70/0xcc
    driver_attach+0x20/0x28
    bus_add_driver+0xdc/0x1d0
    driver_register+0x5c/0x118
    __platform_driver_register+0x24/0x2c
    gpio_keys_init+0x18/0x20
    do_one_initcall+0x70/0x290
    kernel_init_freeable+0x294/0x504
    kernel_init+0x20/0x1cc
    ret_from_fork+0x10/0x20
    irq event stamp: 69071
    hardirqs last enabled at (69071): [<ffff800080e0dafc>] _raw_spin_unlock_irqrestore+0x6c/0x70
    hardirqs last disabled at (69070): [<ffff800080e0cfec>] _raw_spin_lock_irqsave+0x7c/0x80
    softirqs last enabled at (67654): [<ffff800080010614>] __do_softirq+0x494/0x4dc
    softirqs last disabled at (67645): [<ffff800080015238>] ____do_softirq+0xc/0x14

    other info that might help us debug this:
    Possible unsafe locking scenario:

    CPU0
    ----
    lock(&rzg2l_irqc_data->lock);
    <Interrupt>
    lock(&rzg2l_irqc_data->lock);

    *** DEADLOCK ***

    4 locks held by str_rwdt_t_001./159:
    #0: ffff00000b10f3f0 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x1a4/0x35c
    #1: ffff00000e43ba88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0xe8/0x1a8
    #2: ffff00000aa21dc8 (kn->active#40){.+.+}-{0:0}, at: kernfs_fop_write_iter+0xf0/0x1a8
    #3: ffff80008179d970 (system_transition_mutex){+.+.}-{3:3}, at: pm_suspend+0x9c/0x278

    stack backtrace:
    CPU: 0 PID: 159 Comm: str_rwdt_t_001. Not tainted 6.8.0-rc5-next-20240219-arm64-renesas-00030-gb17a289abf1f #90
    Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
    Call trace:
    dump_backtrace+0x94/0xe8
    show_stack+0x14/0x1c
    dump_stack_lvl+0x88/0xc4
    dump_stack+0x14/0x1c
    print_usage_bug.part.0+0x294/0x348
    mark_lock+0x6b0/0x948
    __lock_acquire+0x750/0x20b0
    lock_acquire+0x1e0/0x310
    _raw_spin_lock+0x44/0x58
    rzg2l_irqc_irq_enable+0x60/0xa4
    irq_chip_enable_parent+0x1c/0x34
    rzg2l_gpio_irq_enable+0xc4/0xd8
    rzg2l_pinctrl_resume_noirq+0x4cc/0x520
    pm_generic_resume_noirq+0x28/0x3c
    genpd_finish_resume+0xc0/0xdc
    genpd_resume_noirq+0x14/0x1c
    dpm_run_callback+0x34/0x90
    device_resume_noirq+0xa8/0x268
    dpm_noirq_resume_devices+0x13c/0x160
    dpm_resume_noirq+0xc/0x1c
    suspend_devices_and_enter+0x2c8/0x570
    pm_suspend+0x1ac/0x278
    state_store+0x88/0x124
    kobj_attr_store+0x14/0x24
    sysfs_kf_write+0x48/0x6c
    kernfs_fop_write_iter+0x118/0x1a8
    vfs_write+0x270/0x35c
    ksys_write+0x64/0xec
    __arm64_sys_write+0x18/0x20
    invoke_syscall+0x44/0x108
    el0_svc_common.constprop.0+0xb4/0xd4
    do_el0_svc+0x18/0x20
    el0_svc+0x3c/0xb8
    el0t_64_sync_handler+0xb8/0xbc
    el0t_64_sync+0x14c/0x150

Fixes: 254203f9a94c ("pinctrl: renesas: rzg2l: Add suspend/resume support")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20240320104230.446400-2-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
index 6f49da4bd327..c2a0340ca945 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -2062,8 +2062,17 @@ static void rzg2l_gpio_irq_restore(struct rzg2l_pinctrl *pctrl)
 			continue;
 		}
 
-		if (!irqd_irq_disabled(data))
+		if (!irqd_irq_disabled(data)) {
+			unsigned long flags;
+
+			/*
+			 * This has to be atomically executed to protect against a concurrent
+			 * interrupt.
+			 */
+			raw_spin_lock_irqsave(&pctrl->lock.rlock, flags);
 			rzg2l_gpio_irq_enable(data);
+			raw_spin_unlock_irqrestore(&pctrl->lock.rlock, flags);
+		}
 	}
 }
 
-- 
2.43.0


