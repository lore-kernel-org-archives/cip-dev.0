Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CAE0C3ABCF
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:33:34 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.web11.10283.1746783205549443539
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:33:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=Gq8JQlVk;
 spf=pass (domain: tuxon.dev, ip: 209.85.208.52, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6f4b3ebe5so3651717a12.0
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783204; x=1747388004; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P1V5oDcrgClKAnvR6I59Pq+Ryadgd9qHfq2v9HDaVX4=;
        b=Gq8JQlVkO2zyE6ZFB9ApYBY2FmaZItRTC4IIgc2Ok4GrdUu7od6nQPCgLxkZC5HfxS
         /dPFSFPxqawAMbzGpqsnfDdVRkEEC5mg2FakYCXRQXiCY5OFKdhrXNCOiip7k8/BeiTb
         cUlh6aVvFfSXk68GDR6wgiHoZoyqJF1sXBL611T0d3zqKJhBEDj2WvJRrtNJrUS9NRgM
         nR/jn0n86PsjyelmKETjxaRXs+H3aFJA2MvH17SH+P3rFh7MaCGHf7D01SVZ5pSnktnW
         GikakTEoCOON1QqgG4z5HSH9OBOoS/AG0FjDEAA/43Pn9AbqMqFgA3CtBxgZDfW76uom
         EUrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783204; x=1747388004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1V5oDcrgClKAnvR6I59Pq+Ryadgd9qHfq2v9HDaVX4=;
        b=GrgJyVTIgoBw2Pb0TUN/1isJFQtrhu6ui71K+iKg4jnNxV6nDdHWyNm5KuHch2nGm9
         v+y1nK+4lfRgGUMy4pUZFJDwEC1UW2wkykgoBzAZAXkgUbMYWYpxEQa/k7B3bVfL7Mn7
         TlGTT/ccK47ItwZHEVmoMsQPIygr3rGeWddcbt/Lolk87y1gGG0svKPNtYvAbU2t1SHu
         9hfY2jevBEglU4fcAOdeR7bUDN8Jdz+nSyDhp2UJz3VIsSjHvyygRNaip/A9mvWVNsyu
         k1Fqr+IK78IsLcmzy2znH6xqQ3IOijPRY9OaBtQ8knA24CKGfyYchliKblmHPZyntFwK
         AfnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaEf7UdykD9FO2hv9DGgBUVcFTr0m16j4+TunlaZ2fNjauIP6nFFe2CuwHUO8lZ9cEMsKxQxbe@lists.cip-project.org
X-Gm-Message-State: AOJu0YzUYYsTL1h/GNokD06exOuQBYFlZEy1ZSopPTuUKsPeTYDI2XGs
	5Cz9PVqB9kQiPaoaB7LUsE/F9j0Yjf5f7HGAmJfzl7LhzOZZZ7Js9q91TxTtv8JuDjN9cTfIJkS
	O
X-Gm-Gg: ASbGncvlZPHSCWbrdWLBoQK3m+E8QwlzvGFGYcQMo4Vn0/5l2aNl031uwDp3Wfl/T4k
	NxOvj+fYPtZ7jA/9pHbz/5zIXzp36lt0haAZHtJ8FyosnFEVnM9Pe3IUlpqszsOj/VkexuyVvsg
	qX4RqnU8iBuQLQ8G4eK0HhJXCXzNFxl1+Ov2uM+eRpt0yJF0Ly9lbS9RghdUEPpm6ggjWpvIvII
	Pmd/p47q/bEOQap/2rFrF9oqQ0lLipKebiJHtrDkFXth2tlZk5ETmrUdWJcEEOea2I2D5KBBPIF
	weh1GIC0KSh3PPKT4BJ7MsXF9ZyqJ6HoOZBj96wX09hPk2TXk0jzaxz8xh5MmoRMVZfwqf8vqrK
	G9CBu
X-Google-Smtp-Source: AGHT+IGX+Jo/mD/iemBZhJxCpHpaSjhaOPL3AwFQfAaR+3E98gUx24pZPGN6og4qExW0Jp+Z/8ITxw==
X-Received: by 2002:a05:6402:1e96:b0:5f4:9017:c6a1 with SMTP id 4fb4d7f45d1cf-5fca07e9b06mr2164662a12.25.1746783203967;
        Fri, 09 May 2025 02:33:23 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fc9d700d6esm1106984a12.60.2025.05.09.02.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:33:23 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 6.1.y-cip 03/34] ASoC: da7213: Initialize the mutex
Date: Fri,  9 May 2025 12:32:47 +0300
Message-ID: <20250509093318.4014916-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093318.4014916-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:33:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18820

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 4a32a38cb68f55ff9e100df348ddb3d4b3e50643 upstream.

Initialize the struct da7213_priv::ctrl_lock mutex. Without it the
following stack trace is displayed when rebooting and lockdep is enabled:

DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 0 PID: 180 at kernel/locking/mutex.c:564 __mutex_lock+0x254/0x4e4
CPU: 0 UID: 0 PID: 180 Comm: alsactl Not tainted 6.13.0-next-20250123-arm64-renesas-00002-g132083a22d3d #30
Hardware name: Renesas SMARC EVK version 2 based on r9a08g045s33 (DT)
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __mutex_lock+0x254/0x4e4
lr : __mutex_lock+0x254/0x4e4
sp : ffff800082c13c00
x29: ffff800082c13c00 x28: ffff00001002b500 x27: 0000000000000000
x26: 0000000000000000 x25: ffff800080b30db4 x24: 0000000000000002
x23: ffff800082c13c70 x22: 0000ffffc2a68a70 x21: ffff000010348000
x20: 0000000000000000 x19: ffff00000be2e488 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 00000000000003c1 x13: 00000000000003c1 x12: 0000000000000000
x11: 0000000000000011 x10: 0000000000001420 x9 : ffff800082c13a70
x8 : 0000000000000001 x7 : ffff800082c13a50 x6 : ffff800082c139e0
x5 : ffff800082c14000 x4 : ffff800082c13a50 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff00001002b500
Call trace:
  __mutex_lock+0x254/0x4e4 (P)
  mutex_lock_nested+0x20/0x28
  da7213_volsw_locked_get+0x34/0x60
  snd_ctl_elem_read+0xbc/0x114
  snd_ctl_ioctl+0x878/0xa70
  __arm64_sys_ioctl+0x94/0xc8
  invoke_syscall+0x44/0x104
  el0_svc_common.constprop.0+0xb4/0xd4
  do_el0_svc+0x18/0x20
  el0_svc+0x3c/0xf0
  el0t_64_sync_handler+0xc0/0xc4
  el0t_64_sync+0x154/0x158
 irq event stamp: 7713
 hardirqs last  enabled at (7713): [<ffff800080170d94>] ktime_get_coarse_real_ts64+0xf0/0x10c
 hardirqs last disabled at (7712): [<ffff800080170d58>] ktime_get_coarse_real_ts64+0xb4/0x10c
 softirqs last  enabled at (7550): [<ffff8000800179d4>] fpsimd_restore_current_state+0x30/0xb8
 softirqs last disabled at (7548): [<ffff8000800179a8>] fpsimd_restore_current_state+0x4/0xb8
 ---[ end trace 0000000000000000 ]---

Fixes: 64c3259b5f86 ("ASoC: da7213: Add new kcontrol for tonegen")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20250123121036.70406-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 sound/soc/codecs/da7213.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
index 3aa98b52a912..f2bbee15c06e 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2176,6 +2176,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c)
 		return ret;
 	}
 
+	mutex_init(&da7213->ctrl_lock);
+
 	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
 	pm_runtime_use_autosuspend(&i2c->dev);
 	pm_runtime_set_active(&i2c->dev);
-- 
2.43.0


