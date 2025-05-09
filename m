Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261B8C3ABCB
	for <webhook@archiver.kernel.org>; Fri,  9 May 2025 09:35:05 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.10345.1746783299307664071
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 May 2025 02:34:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=ISLxNZnk;
 spf=pass (domain: tuxon.dev, ip: 209.85.218.49, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-acae7e7587dso276511366b.2
        for <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 02:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746783298; x=1747388098; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufzM/LTJXMkA1zrMtRYR38DsN9O/SlprE2IemNAeVX4=;
        b=ISLxNZnkH1gyjvbB2PyHY8tHKcAkfdd3XgaSXSG042j5WFkx+tV3qSQbGrsesGmwdN
         XCVjw1XJHTYhjvKKVZnm1cGPt46ux+wW5z0vA5f9Qm/fOIpmuQJylgmH7XtI95zlnUCw
         zGw/OPc0SvCDYybrCjkRQqgRagbJ2Jqmty8Fp0WLC1e6YMm3F0QQj1Y1xP9843RuppiJ
         jkAMz70rx17u/ScPsAfIfZU+mw1KAbMRrPEN/5O2Ndk6O/itlE2A6pVuIsQH3KlHsM01
         t/FqhCO8Pk4PuJHEYl8kuQKINeaGNRnWtFd0jAJIQiijjmrSK7Nvf+GWFc96CtzZN/k4
         cg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746783298; x=1747388098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufzM/LTJXMkA1zrMtRYR38DsN9O/SlprE2IemNAeVX4=;
        b=CiFR3su9DcjnIWt43U6htBAFqLBkJq2YCcZ6U0xooULvBpLXM/V8s7kCN3IyERf/+C
         Vy3i1oaQ8gm0N0IlyyKvq8ATD1xR1dtETu7XBVQiv6D5VVrmrbjkuvBh9GdhCgLliCpr
         K7xwLZ1GnIlAed+Ew6hjjipnDpsAhAmwwx/y7aWECAUdBNDE8IXEgNFNVC4Zwn1ogRJU
         mrVixpwioF5JKQpkgM39zlT56DrCuca0eaqdOsicYUC9w8mzcy+7FQ2IFDVfQAYKX+aG
         BrNLVkvwfmxGcILZqZBO+8ob27QTMdrKtnP/M8pMvl77FznMo0SyAuWp65AKxMrfk5Gx
         pobg==
X-Forwarded-Encrypted: i=1; AJvYcCVsUHqgj54Uk5doQb6xmB3izscn8kVUazeB7mY9hO7Pm1ZD+lgk4A/LuwqkyYSmIBUtdx9Xo44o@lists.cip-project.org
X-Gm-Message-State: AOJu0Yx7AeQmWbaNGmLvN9wrWFlO9aqy+UKvva2pw+VSrzyH7RX+eWZn
	1cj6U+JMI+Adot7Lcu6arj0mAR/Ovgnkuyj7k06LbDg1MYRW3ZS2AC7WOAUM5Ig=
X-Gm-Gg: ASbGncvu47SbbIIXeuh+0fjppjDDsTAv1N4IHgtZ5MQdcfDPjU8ExySpHHGmDvb2dBE
	sJvyGpGdOgE0xvtmorEy9bbpmX0pM7MbLSQK2OPXSHCqVnd2GvcThQHoKSyuXN+eA6LBW8ts/te
	dXfXdoDlpeh6YfcnFu2DGGKggBBZmoENKAzFao5VAYJV9mmRiI9sCppTjLFYJqDae3nJvfLeDic
	8+B5HYC+Jv/yC6rUPYw9/DCb3KD9ZlN7b/MdtvLTQIHFL0j701jxLxzig3Xl3d4Mo1OH5OESvgL
	c/llq4oeYYlbAGwmuyjW564BJ47lIuRmHqaDLr0OYMGkVWlHWAn6d9LkVp8512+rX8lovw==
X-Google-Smtp-Source: AGHT+IFfgFD6QFsrC7UNDbiFRaGodftSuff+uCqtaQMglvLigSqgO/5GX2amYoyN0bJXiMhiYk6h6w==
X-Received: by 2002:a17:907:3fa6:b0:aca:95e7:9977 with SMTP id a640c23a62f3a-ad219057ffcmr296753266b.28.1746783297636;
        Fri, 09 May 2025 02:34:57 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad21974697asm121095466b.114.2025.05.09.02.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 02:34:56 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	pavel@denx.de
Cc: claudiu.beznea@tuxon.dev,
	cip-dev@lists.cip-project.org
Subject: [PATCH 5.10.y-cip 10/37] ASoC: da7213: Initialize the mutex
Date: Fri,  9 May 2025 12:34:15 +0300
Message-ID: <20250509093442.4015145-11-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250509093442.4015145-1-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 May 2025 09:35:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18862

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
index 9a7ad34ae554..6d32026ae69f 100644
--- a/sound/soc/codecs/da7213.c
+++ b/sound/soc/codecs/da7213.c
@@ -2187,6 +2187,8 @@ static int da7213_i2c_probe(struct i2c_client *i2c,
 		return ret;
 	}
 
+	mutex_init(&da7213->ctrl_lock);
+
 	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
 	pm_runtime_use_autosuspend(&i2c->dev);
 	pm_runtime_set_active(&i2c->dev);
-- 
2.43.0


