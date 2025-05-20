Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48209C3DA6D
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 01:03:22 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.19418.1747743793740742127
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 05:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=christoph.steiger@siemens.com header.s=fm1 header.b=CtBo6JD/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1328957-202505201223101dfed6adbb6bacfda3-ee1f_h@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 202505201223101dfed6adbb6bacfda3
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 May 2025 14:23:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=christoph.steiger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=0vZTVzYg2SnMDOd4MPNLqLCYyFRBuuAeJt+XXmElL98=;
 b=CtBo6JD/8bgczTBaXtbDOAHul1QbBJquW+FoZe6/do5l/jgnmMeix7ZK20G3BnCOhn9dKq
 GQ4eiUEHSFDHINpuic7xcHCGIhrDPLkbQDuhlpGnutqaTansw8C7zxkbnS+7rYDuVpREAl2S
 gH3hXmEuGyvddpE37AUYKMtaKXjSTUiZnrzznbf3DGxBwppYKuzh4vv2nqGzYJlGd9y//2b0
 DUatMh9v5kh/SEWF7hShXYXtlHn7wEVptVWHxDuFercbu12fw2DY2l4NkInI4XqV3tMlytAC
 kuz1ZdypZ97nJy9iwWlCWTVpr3JA4U8GKhOQAqYozk00fbBEc9RsgyhA==;
From: Christoph Steiger <christoph.steiger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Christoph Steiger <christoph.steiger@siemens.com>
Subject: [PATCH 4.19.y-cip 0/1] mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()
Date: Tue, 20 May 2025 14:23:08 +0200
Message-Id: <20250520122309.180558-1-christoph.steiger@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328957:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 May 2025 01:03:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18931

Hi,

This backport fixes a sleep-in-atomic-context bug we encountered on a
4.19.124-cip27 kernel:

[   24.086013] BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:3475
[   24.093364] in_atomic(): 1, irqs_disabled(): 128, pid: 47, name: kworker/2:1
[   24.099129] 3 locks held by kworker/2:1/47:
[   24.102023]  #0: (ptrval) ((wq_completion)"events_freezable"){+.+.}, at: process_one_work+0x204/0x83c
[   24.109986]  #1: (ptrval) ((work_completion)(&(&host->detect)->work)){+.+.}, at: process_one_work+0x204/0x83c
[   24.118629]  #2: (ptrval) (&(&host->lock)->rlock#2){-.-.}, at: sdhci_check_ro+0x14/0x9c
[   24.125369] irq event stamp: 17836
[   24.127492] hardirqs last  enabled at (17835): [<8029a178>] kfree+0xd0/0x360
[   24.133263] hardirqs last disabled at (17836): [<80bfe8c8>] _raw_spin_lock_irqsave+0x1c/0x68
[   24.140425] softirqs last  enabled at (0): [<8011fab8>] copy_process.part.3+0x33c/0x1d44
[   24.147230] softirqs last disabled at (0): [<00000000>]   (null)
[   24.151955] CPU: 2 PID: 47 Comm: kworker/2:1 Not tainted 4.19.124-cip27 #1
[   24.157544] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[   24.162793] Workqueue: events_freezable mmc_rescan
[   24.166319] [<801115f8>] (unwind_backtrace) from [<8010d060>] (show_stack+0x10/0x14)
[   24.172789] [<8010d060>] (show_stack) from [<80be1c54>] (dump_stack+0xb4/0xe0)
[   24.178739] [<80be1c54>] (dump_stack) from [<80153d38>] (___might_sleep+0x1ac/0x260)
[   24.185212] [<80153d38>] (___might_sleep) from [<805cead0>] (gpiod_get_value_cansleep+0x1c/0x8c)
[   24.192719] [<805cead0>] (gpiod_get_value_cansleep) from [<8087027c>] (sdhci_check_ro+0x40/0x9c)
[   24.200231] [<8087027c>] (sdhci_check_ro) from [<80865a60>] (mmc_sd_setup_card+0x1cc/0x2ec)
[   24.207302] [<80865a60>] (mmc_sd_setup_card) from [<80865c84>] (mmc_sd_init_card+0x104/0x3f4)
[   24.214547] [<80865c84>] (mmc_sd_init_card) from [<8086611c>] (mmc_attach_sd+0xcc/0x168)
[   24.221355] [<8086611c>] (mmc_attach_sd) from [<8085efa8>] (mmc_rescan+0x374/0x3e8)
[   24.227734] [<8085efa8>] (mmc_rescan) from [<801434e0>] (process_one_work+0x2c8/0x83c)
[   24.234375] [<801434e0>] (process_one_work) from [<80143a98>] (worker_thread+0x44/0x590)
[   24.241187] [<80143a98>] (worker_thread) from [<8014aa7c>] (kthread+0x160/0x168)
[   24.247303] [<8014aa7c>] (kthread) from [<801010b4>] (ret_from_fork+0x14/0x20)
[   24.253240] Exception stack(0xec63dfb0 to 0xec63dff8)
[   24.257009] dfa0:                                     00000000 00000000 00000000 00000000
[   24.263903] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   24.270796] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000

The patch fixes 6d5cd068ee59 ("mmc: sdhci: use WP GPIO in sdhci_check_ro()")
which was later introduced in 5.0, which is likely why this fix has been
missed so far in 4.19. As it turns out it also fixes a very similar problem in
some drivers like the sdhci-esdhc-imx, which is already relevant for 4.4 and
4.19.

I tested this for 4.19 on hardware, I can not verify it easily for 4.4.

Kind regards,
Christoph

Adrian Hunter (1):
  mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()

 drivers/mmc/host/sdhci.c | 5 -----
 1 file changed, 5 deletions(-)

-- 
2.39.5


