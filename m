Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495BAD7876A
	for <webhook@archiver.kernel.org>; Fri, 19 Dec 2025 12:29:29 +0000 (UTC)
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15746.1766147359510161303
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Dec 2025 04:29:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=WgFNwabT;
 spf=pass (domain: gmail.com, ip: 209.85.218.67, mailfrom: biju.das.au@gmail.com)
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-b79ea617f55so192074966b.3
        for <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 04:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766147358; x=1766752158; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XjCjChUoRw4H/obu6b7UHs/lg3T+vp2K3rCkxhNVv84=;
        b=WgFNwabTh9MMuBXmqX1mU40Og4mGoNFmZ+N0+kyQncZg+uED5i1ei0ugsGoS14xNTw
         lp0pxXmNIHaS6Mi4NrYb3RWDIxL7ohIF7LNR61D5l1iXqYi0S2AFtpn8NWDdFQr9h8zg
         gj3iYatZIQNj+Lfi31pXGECOgUx1Qm3myvXNJQV7Qomccd00L1QjzIpeDE5UXvoeojVs
         q9YoD0L96gWQUhDLZr2vWUxWW3vcAHmI2enLElmfav0lY43N2v/sw+NYiez7lq0+lmzV
         juTqVm//oMUfuIFtXATJ0kU0hjCV5Kf/qeco6vbFi0nLCVC5zcO+nODCW9vYW871+dR4
         d5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766147358; x=1766752158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjCjChUoRw4H/obu6b7UHs/lg3T+vp2K3rCkxhNVv84=;
        b=q/gp1B2v8eipVB2laj6hr/VXlh4IQ3jEc0fHNi/Tnnvo25uz+MD9k1FJ1pX5N0J1N+
         12VdTA2n6DPCRcuwaldnKRXfo1+hPpFze1dLZCzYWZVXTdbuB49xPSMI/sRTiTAqFIzC
         oQzLlrFo9hUoK0tkCF4wbLH9BE9bGOIpgEABdAHBe6ygOamdHHdohamqVvACik2Qp62n
         MYTUm//3atOiedS87J05/isWN0zs4TVxZN4v6+V/ieeorKfM9RRoAmPXyP3xxmQce5+R
         k60SMcWDGfR68/gF1b11Ocx3tQtMuVck+E75Nce5Z9r/abZfic6N+ywFi2pLaMZbDoSK
         qPhA==
X-Gm-Message-State: AOJu0Yzk7jTN0hUAkhr6g70xVZEOGkEeLFjXvsTA6TPethtLH2+uTeb/
	sIYQwKdIGhx7tZ0WbmKgHlRnpgEaHV8UmzbBL5dHFAKbZvAWuIogehEfRs8PZXoD
X-Gm-Gg: AY/fxX7MPrVQ7aCqBYmylqN7eF+PRwg90lOGuJnYlOiX824mrukPWwz94Eb2y9R7s1l
	ePvc+OWz15ff31AmQoU7bjjVK+M/M1shdKhsuV36ki2t6UxdXaoFFsEWO7JIPZPXKa7u2e9FpqY
	+cjoY11DZ3+TeST2scVZPlZSXS64TiWMIAxyeSaBIlN2M/peuDh6B62AfHTGjRLbQkxrSVrr+oR
	tV6drrAAdV9+db2QM5jK4KfJ8r5P/R07x413G64+EmCloL0AdaDNX3hvUZUqNaaa2kKVdc885D6
	+cXJp9i34kv3Hxoh3ai4096q0GFLfWGAXPfCT5yW/BOp4UFYDAvcZVSyPhJoCrfeA6j7F+kjnAF
	jUKQ7sNcpMKlyVFxA4SFE+numJPK6nIK9rtrXo3hMTKp48zD74EMoD8A0SdkBSh/oRtJrfXNLN1
	NbCptlMz0n9XbXh9gn3wVawk0Nv2mz9Hb5FQ==
X-Google-Smtp-Source: AGHT+IHV8Nr7TyLPOj25vog8VBKwfHG3/0WG4GrPex2FD44qbgLi3TfBHd6BzZNbEHQSYCAHvX0a8Q==
X-Received: by 2002:a17:907:868e:b0:b7a:1be1:86e6 with SMTP id a640c23a62f3a-b8037224ea0mr270632766b.62.1766147357568;
        Fri, 19 Dec 2025 04:29:17 -0800 (PST)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:bb1:f7ee:1376:35e4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f511fesm223648666b.65.2025.12.19.04.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 04:29:17 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/5] Add gpio keys/sleep button support for RZ/G3E
Date: Fri, 19 Dec 2025 12:29:06 +0000
Message-ID: <20251219122916.129256-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Dec 2025 12:29:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21174

From: Biju Das <biju.das.jz@bp.renesas.com>

Add gpio keys support for waking up from s2idle and sleep button support
for entering to STR. Wakeup of STR is by pressing and holding power
button. All the patches in this series are cherry-picked from mainline.

STR logs:
root@smarc-rzg3e:~# [   25.082405] PM: suspend entry (deep)
[   25.086495] Filesystems sync: 0.000 seconds
[   25.098336] Freezing user space processes
[   25.104215] Freezing user space processes completed (elapsed 0.001 seconds)
[   25.111199] OOM killer disabled.
[   25.114443] Freezing remaining freezable tasks
[   25.120149] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   25.127557] printk: Suspending console(s) (use no_console_suspend to debug)
NOTICE:  BL2: v2.10.5(release):b288fa6dd
NOTICE:  BL2: Built : 11:10:41, Dec 11 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[   25.179095] renesas-gbeth 15c30000.ethernet end0: Link is Down
[   25.186526] Disabling non-boot CPUs ...
[   25.189612] psci: CPU3 killed (polled 4 ms)
[   25.196378] psci: CPU2 killed (polled 0 ms)
[   25.202614] psci: CPU1 killed (polled 0 ms)
[   25.209180] Enabling non-boot CPUs ...
[   25.209374] Detected VIPT I-cache on CPU1
[   25.209419] GICv3: CPU1: found redistributor 100 region 0:0x0000000014960000
[   25.209457] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   25.209990] CPU1 is up
[   25.210078] Detected VIPT I-cache on CPU2
[   25.210099] GICv3: CPU2: found redistributor 200 region 0:0x0000000014980000
[   25.210119] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   25.210484] CPU2 is up
[   25.210573] Detected VIPT I-cache on CPU3
[   25.210594] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a0000
[   25.210614] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   25.211104] CPU3 is up
[   25.212242] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rgmii-id link mode
[   25.225378] dwmac4: Master AXI performs any burst length
[   25.225409] renesas-gbeth 15c30000.ethernet end0: No Safety Features support found
[   25.225427] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
[   25.225572] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[   25.237367] dwmac4: Master AXI performs any burst length
[   25.237394] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[   25.237408] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[   25.430129] OOM killer enabled.
[   25.433255] Restarting tasks ... done.
[   25.437594] random: crng reseeded on system resumption
[   25.442833] PM: suspend exit

root@smarc-rzg3e:~#

s2idle logs:
root@smarc-rzg3e:~# echo freeze > /sys/power/state
[   49.646154] PM: suspend entry (s2idle)
[   49.660843] Filesystems sync: 0.010 seconds
[   49.670380] Freezing user space processes
[   49.676749] Freezing user space processes completed (elapsed 0.002 seconds)
[   49.683897] OOM killer disabled.
[   49.687248] Freezing remaining freezable tasks
[   49.693235] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   49.700799] printk: Suspending console(s) (use no_console_suspend to debug)
[   49.735926] renesas-gbeth 15c30000.ethernet end0: Link is Down
[   51.619991] renesas-gbeth 15c30000.ethernet end0: configuring for phy/rgmii-id link mode
[   51.635772] dwmac4: Master AXI performs any burst length
[   51.635852] renesas-gbeth 15c30000.ethernet end0: No Safety Features support found
[   51.635912] renesas-gbeth 15c30000.ethernet end0: IEEE 1588-2008 Advanced Timestamp supported
[   51.636252] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[   51.652051] dwmac4: Master AXI performs any burst length
[   51.652126] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[   51.652181] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[   51.765175] OOM killer enabled.
[   51.768332] Restarting tasks ... done.
[   51.773325] random: crng reseeded on system resumption
[   51.778619] PM: suspend exit

Biju Das (4):
  pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt
    control registers
  pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
  arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
  arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI
    function

Lad Prabhakar (1):
  pinctrl: renesas: rzg2l: Validate pins before setting mux function

 .../boot/dts/renesas/r9a09g047e57-smarc.dts   | 38 +++++++++
 .../boot/dts/renesas/renesas-smarc2.dtsi      | 31 +++++++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 82 +++++++++++++------
 3 files changed, 124 insertions(+), 27 deletions(-)

-- 
2.43.0


