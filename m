Return-Path: <iwamatsu@nigauri.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDC4CD3427
	for <webhook@archiver.kernel.org>; Fri,  1 May 2026 22:59:10 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.751.1777676343673963472
 for <cip-dev@lists.cip-project.org>;
 Fri, 01 May 2026 15:59:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@nigauri-org.20251104.gappssmtp.com header.s=20251104 header.b=dxqNuRRn;
 spf=none, err=permanent DNS error (domain: nigauri.org, ip: 209.85.210.179, mailfrom: iwamatsu@nigauri.org)
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1054754b3a.1
        for <cip-dev@lists.cip-project.org>; Fri, 01 May 2026 15:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20251104.gappssmtp.com; s=20251104; t=1777676343; x=1778281143; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DB31jPvrwkXD7aZt/7u0HOms5gkrxnTUOkOsWGwy19Y=;
        b=dxqNuRRn0MyEodl26UQzwIwzS/6NkUAJZDsvkec6TD/CnpYwgrvllADOsK/FhggAym
         D/xYWyo4fVEVE5H1jBtB0VldovyvaANtCVUO7ugs/2Q/ZnxRikDx80cvg9fUMjqVTIkh
         zJ9M81ajvcxFkOe5D7eJQAqJdfnoOcxLOBBvGGam7bkTPytRHEdriMUWkhEcdKtYxlAH
         GyTPNcmg/mWYe1frcUS3i15WfnBk2ot3DvmRoNJcnEplK5vCqSjWrfR0N6SWmjOWF3lL
         8k1c/yGqa8qEOA5Dz1Jy4MOqUku3ymD6/0Pnpxcrv+q7SFXDm0PvG6a4MU/O5quOqJys
         LBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777676343; x=1778281143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DB31jPvrwkXD7aZt/7u0HOms5gkrxnTUOkOsWGwy19Y=;
        b=KdmcAaZm+ma9NG6E9bj6j6b3V87VHb3+6VWujR7e8pSuqdEggkpN5rqtu7bPYSU5j8
         wjOeE13C2D8kNNNf3bNVPBG/7x3Pc8bi0rxi0c53uok15xm++urfOtmvE8SRi7DYo2eW
         oyJeJKQhTPfD31eUOOKftygiT4QID6dBdWMXOrcrtOJjhpp3tlAOqyODHkJ3gbY2Ob4W
         iWQCgO2/Y+nkHLePHSfK9WdNKpGe03hkTpPC6tOEiOiiSvKIM9XKEir0Vmn639dZxWAn
         kMITuY89YvdjybtSsA85OmXA9zm9W+CX1E9sN7BEG5H4OsmX+YgwKdY6AVkM6rwx1ZCa
         Md2A==
X-Gm-Message-State: AOJu0YxygxGFSiNxeYkUwsGP57O4RedddJ5arN3bo0QaMnZxsu3np5q+
	nE99mRDmYdZV7DGW9GQEpNsqh4fYc9TB5Mn8QKLhCC/zTuz0EhsTEeKUaxJ9f4nP
X-Gm-Gg: AeBDieu/snqEoYFm3Oq9JhD02b6yj2e7knzTyyr9XDKmk0GYSKIqAEaGoTxwhcevK5A
	HuY2BQLO8C+DtPbrReCEgfzh70qm54dxPeRU5s9OBzsfyeKKc6QuUSWLWS3O+oP9lHIFRHM7IT0
	dugmH/rvW1EPHcuijeoti/H0BqjBzwbR/KLzxcTCoCcCJqRhM95aa6WtH2uZdrklVPNt8heDmg5
	vGXlPkOltrA1C101W9zbh+SEa0oXonGMaPEPMFXN5jC1pk50WRTNzHIFzH5mlDLS7tZc77mBxma
	K7P8MHy2MiRVLMWJ8nea88tQeKc87treSOp7gUAFF0JvXYbZiv2f3344hGnBtU/PF2T/1srn1q0
	S/qeqU390EnITmXZRD+mP6h13xfc85YOFviYS4zj7QlLnpOX+R2QgiWYGiTw72yhOZ8JhsVQRmI
	rXkJa9SyCcywKGn0kpcaAS9VlB65ZaJboVBkWqj/V1fTQB08g1ZNh7TW88He6e8b3tLFk=
X-Received: by 2002:a05:6a00:1a86:b0:82f:6a64:deac with SMTP id d2e1a72fcca58-8352d20b29emr895393b3a.28.1777676342993;
        Fri, 01 May 2026 15:59:02 -0700 (PDT)
Received: from localhost (ae047133.dynamic.ppp.asahi-net.or.jp. [14.3.47.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b73affsm3571932b3a.55.2026.05.01.15.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:59:02 -0700 (PDT)
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
X-Google-Original-From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH for 5.10.y] phy: renesas: rcar-gen3-usb2: Fix the use of msleep during spinlock
Date: Sat,  2 May 2026 07:58:59 +0900
Message-ID: <20260501225859.504868-1-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 01 May 2026 22:59:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22834

From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>

This fixes an issue caused by the use of msleep during spinlock.
In the original commit, msleep was changed to mdelay, but this fix was not
carried over during the backport to 5.10.y tree.

This is a backporting error, so no fix is needed in the upstream.

```
[   62.677594] BUG: scheduling while atomic: kworker/1:2/126/0x00000002
[   62.683957] Modules linked in:
[   62.687014] CPU: 1 PID: 126 Comm: kworker/1:2 Not tainted 5.10.253 #1
[   62.693447] Hardware name: HopeRun HiHope RZ/G2M with sub board (DT)
[   62.699812] Workqueue: events deferred_probe_work_func
[   62.704948] Call trace:
[   62.707397]  dump_backtrace+0x0/0x1c0
[   62.711058]  show_stack+0x18/0x40
[   62.714375]  dump_stack+0xe8/0x124
[   62.717776]  __schedule_bug+0x54/0x70
[   62.721436]  __schedule+0x6b4/0x710
[   62.724920]  schedule+0x70/0x104
[   62.728145]  schedule_timeout+0x80/0xf0
[   62.728153]  msleep+0x30/0x44
[   62.728165]  rcar_gen3_phy_usb2_init+0x180/0x1e0
[   62.736946]  phy_init+0x64/0x100
[   62.736955]  usb_phy_roothub_init+0x48/0xa0
[   62.736962]  usb_add_hcd+0x54/0x6c0
[   62.736974]  ehci_platform_probe+0x1ec/0x4b0
[   62.744541]  platform_drv_probe+0x54/0xac
[   62.744548]  really_probe+0xec/0x4f0
[   62.744552]  driver_probe_device+0x58/0xec
[   62.744556]  __device_attach_driver+0xb8/0x120
[   62.744562]  bus_for_each_drv+0x78/0xd0
[   62.744568]  __device_attach+0xa8/0x1c0
[   62.744575]  device_initial_probe+0x14/0x20
[   62.752315]  bus_probe_device+0x9c/0xa4
[   62.752319]  deferred_probe_work_func+0x88/0xc0
[   62.752327]  process_one_work+0x1cc/0x370
[   62.759977]  worker_thread+0x218/0x480
[   62.759984]  kthread+0x154/0x160
[   62.759990]  ret_from_fork+0x10/0x18
[   62.760115] ehci-platform ee080100.usb: EHCI Host Controller
[   62.839982] ehci-platform ee080100.usb: new USB bus registered, assigned bus number 3
```

Fixes: 0f86a559900f ("phy: renesas: rcar-gen3-usb2: Lock around hardware registers and driver data")
Cc: stable@vger.kernel.org
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/renesas/phy-rcar-gen3-usb2.c b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
index 5166a115879ea..90f2a0e5b2aa0 100644
--- a/drivers/phy/renesas/phy-rcar-gen3-usb2.c
+++ b/drivers/phy/renesas/phy-rcar-gen3-usb2.c
@@ -386,7 +386,7 @@ static void rcar_gen3_init_otg(struct rcar_gen3_chan *ch)
 	val = readl(usb2_base + USB2_ADPCTRL);
 	writel(val | USB2_ADPCTRL_IDPULLUP, usb2_base + USB2_ADPCTRL);
 
-	msleep(20);
+	mdelay(20);
 
 	writel(0xffffffff, usb2_base + USB2_OBINTSTA);
 	writel(USB2_OBINT_BITS, usb2_base + USB2_OBINTEN);
-- 
2.53.0


