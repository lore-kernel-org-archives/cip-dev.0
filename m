Return-Path: <biju.das.au@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D0DD6D230
	for <webhook@archiver.kernel.org>; Thu, 18 Dec 2025 15:32:25 +0000 (UTC)
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44874.1766071942639565727
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Dec 2025 07:32:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=HysA0Sor;
 spf=pass (domain: gmail.com, ip: 209.85.221.65, mailfrom: biju.das.au@gmail.com)
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-42b3d7c1321so452741f8f.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 07:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766071941; x=1766676741; darn=lists.cip-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPsc/IkawCpUntfFZypieqcDhQ2jVpNqs4EYsLlbhDo=;
        b=HysA0Sorz7rWkhi0WiqkXlQePJ1refvSZtyW9a5ol05LFGJvEq7h9y5CxIc16K2hC2
         jpheF26TaVHKZhYNWPdLQ3Yn+rIvIDYk3wkir/H/bxMuUx6Ep3/aSrzuMBgiiVIFhLwM
         n91BNOAyzVRLD7TuE1Pqko7k/r+bKJIo8+rOr9GsR7ug15mu69Ml9hC8yvl7am44VsVZ
         tm0+V90PXqxSMrZyYfADvylWlL8eqTsASO6SlAc7QgSkXz6zyVlj8VlxZTz6EFEHF5p7
         ZhZ9ONSeCjcV4iylWaYCYCsQHSdSt50BRQ8KO/LUF1a5WEu9Ft8fA4Kv6xZVAl9OVnTU
         PmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766071941; x=1766676741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YPsc/IkawCpUntfFZypieqcDhQ2jVpNqs4EYsLlbhDo=;
        b=X66oeoMxH9WvvCqCb/HZdkExSE9t4Gw/fk1QlgQ6CTpw26JG73aOZrHzWfJGnl8hIS
         WdhlYKTibmA8jTICrki1/KepBMcWcyC+LgLV/CyNvxe6X3PYu+S9+Ugr6sHm/ovYWCD9
         hs97V+fA2ZhtzU5XxC1Nn8pzVB31JsVq30AIo59S0cbJ/FYjai+LephptMmMO1EWXB4E
         /mv5V+XtHsulI60CyDOZRAmnnEhXqUJ0f1XbPpu30CSUNsxxB3ltuVUAWV4hwD20vG5a
         kIpG98h/gegho1XYhFjvDueyQ8XMZd9BF5nAQy+5e2/oWbfaXDPJzIft03Ui9gROvaS7
         1lhA==
X-Gm-Message-State: AOJu0Yz8nY3VZwns5IAWRMgZg4xDJehuBasDsauhLya96sG9kdS5zG3p
	Qrqd5lxCwKD37qNWmhMqGadnRz5la+1clIWZ/61Ui40suiJIzwtW8d4O+kfMErmS
X-Gm-Gg: AY/fxX6fZoJtxfKEwA+OxzFFkILtGHgsz68aBhfB6IG6Qksgf25xnT7jjkQ1LkQaN8f
	X24WYrDaRHrm+frduHujofm1jJ3BvbNWEWQqhTyr6bufkBOU1LJX89CMp5VxMzuqfACUYqTDarw
	+VJaV9I/N0VukOET6nHS+KU4K8WON0n6QFmEHq1kKm52BYGjWmhbmfsgwJf6yYqLJshe3jyrN7X
	SExijiwAeOOhZdZi1K0UUms1qV9VGtviPAjQppjMthnAEADNW+ohBC91lbsskP54sRhH/RN7PjK
	YwnSOD09VRiOoCsGfuQUH8xN3DpXcC09NSkhoapRSiaV7QcBGX9y2dd1+yRuRPRQm3crACPSHXQ
	Jq62V2im2G84Pb7+ruluzCLeqlss8W1zsVdE4xjDbAwzheN5izRa/wpMM/zdwIz/EiMwGQRAzcl
	BXtldth+7O5/p5YvhaMQ==
X-Google-Smtp-Source: AGHT+IGxkfdMSB3flhvu+8XdkkBi2h+TtvdqRJupnzL7FcAb9QB9oz0Kl8RdgZ0E+bmRVDALonP3FA==
X-Received: by 2002:a5d:5d0e:0:b0:430:f3ab:56af with SMTP id ffacd0b85a97d-430f3ab5950mr20784396f8f.48.1766071940267;
        Thu, 18 Dec 2025 07:32:20 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:a534:2aa6:4ac4:7963])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449af076sm5637772f8f.40.2025.12.18.07.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 07:32:19 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 00/12] Add gpio keys/sleep button support for RZ/G3E
Date: Thu, 18 Dec 2025 15:31:49 +0000
Message-ID: <20251218153219.228506-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Dec 2025 15:32:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21125

From: Biju Das <biju.das.jz@bp.renesas.com>

Add gpio keys support for waking up from s2idle and sleep button support
for entering to STR. Wakeup of STR is by pressing and holding power
button. All the patches in this series are cherry-picked from mainline.

STR logs:
root@smarc-rzg3e:~# [   29.494903] PM: suspend entry (deep)
[   29.498785] Filesystems sync: 0.000 seconds
[   29.507624] Freezing user space processes
[   29.513571] Freezing user space processes completed (elapsed 0.001 seconds)
[   29.520595] OOM killer disabled.
[   29.523926] Freezing remaining freezable tasks
[   29.529647] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   29.537053] printk: Suspending console(s) (use no_console_suspend to debug)
NOTICE:  BL2: v2.10.5(release):b288fa6dd
NOTICE:  BL2: Built : 11:10:41, Dec 11 2025
NOTICE:  BL2: SYS_LSI_MODE: 0x13e06
NOTICE:  BL2: SYS_LSI_DEVID: 0x8679447
NOTICE:  BL2: SYS_LSI_PRR: 0x0
NOTICE:  BL2: Booting BL31
[   29.585148] renesas-gbeth 15c30000.ethernet eth0: Link is Down
[   29.592508] Disabling non-boot CPUs ...
[   29.595376] psci: CPU1 killed (polled 0 ms)
[   29.599955] psci: CPU2 killed (polled 4 ms)
[   29.604606] psci: CPU3 killed (polled 4 ms)
[   29.606199] Enabling non-boot CPUs ...
[   29.606372] Detected VIPT I-cache on CPU1
[   29.606410] GICv3: CPU1: found redistributor 100 region 0:0x0000000014960000
[   29.606448] CPU1: Booted secondary processor 0x0000000100 [0x412fd050]
[   29.606836] CPU1 is up
[   29.606919] Detected VIPT I-cache on CPU2
[   29.606936] GICv3: CPU2: found redistributor 200 region 0:0x0000000014980000
[   29.606954] CPU2: Booted secondary processor 0x0000000200 [0x412fd050]
[   29.607194] CPU2 is up
[   29.607285] Detected VIPT I-cache on CPU3
[   29.607302] GICv3: CPU3: found redistributor 300 region 0:0x00000000149a0000
[   29.607320] CPU3: Booted secondary processor 0x0000000300 [0x412fd050]
[   29.607621] CPU3 is up
[   29.608732] renesas-gbeth 15c30000.ethernet eth0: configuring for phy/rgmii-id link mode
[   29.619764] dwmac4: Master AXI performs any burst length
[   29.619792] renesas-gbeth 15c30000.ethernet eth0: No Safety Features support found
[   29.619808] renesas-gbeth 15c30000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[   29.619954] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[   29.631758] dwmac4: Master AXI performs any burst length
[   29.631784] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[   29.631797] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[   29.822347] OOM killer enabled.
[   29.825484] Restarting tasks ... done.
[   29.830257] random: crng reseeded on system resumption
[   29.835470] PM: suspend exit
[   32.179888] renesas-gbeth 15c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   33.298192] 8021q: 802.1Q VLAN Support v1.8
[   33.302491] 8021q: adding VLAN 0 to HW filter on device eth0
[   33.308233] 8021q: adding VLAN 0 to HW filter on device end1
[   33.736280] Process accounting resumed
[   35.807912] SDHI2-VQMMC: disabling

root@smarc-rzg3e:~# ping 192.168.10.1
PING 192.168.10.1 (192.168.10.1): 56 data bytes
64 bytes from 192.168.10.1: seq=0 ttl=64 time=0.774 ms
64 bytes from 192.168.10.1: seq=1 ttl=64 time=0.817 ms
^C
--- 192.168.10.1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.774/0.795/0.817 ms
root@smarc-rzg3e:~#

S2Idle logs:
root@smarc-rzg3e:~# echo freeze > /sys/power/state
[  111.068509] PM: suspend entry (s2idle)
[  111.072640] Filesystems sync: 0.000 seconds
[  111.082051] Freezing user space processes
[  111.087963] Freezing user space processes completed (elapsed 0.001 seconds)
[  111.094972] OOM killer disabled.
[  111.098342] Freezing remaining freezable tasks
[  111.104018] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[  111.111547] printk: Suspending console(s) (use no_console_suspend to debug)
[  111.145422] renesas-gbeth 15c30000.ethernet eth0: Link is Down
[  112.607442] renesas-gbeth 15c30000.ethernet eth0: configuring for phy/rgmii-id link mode
[  112.613010] dwmac4: Master AXI performs any burst length
[  112.613084] renesas-gbeth 15c30000.ethernet eth0: No Safety Features support found
[  112.613140] renesas-gbeth 15c30000.ethernet eth0: IEEE 1588-2008 Advanced Timestamp supported
[  112.613497] renesas-gbeth 15c40000.ethernet end1: configuring for phy/rgmii-id link mode
[  112.618886] dwmac4: Master AXI performs any burst length
[  112.618954] renesas-gbeth 15c40000.ethernet end1: No Safety Features support found
[  112.619005] renesas-gbeth 15c40000.ethernet end1: IEEE 1588-2008 Advanced Timestamp supported
[  112.732789] OOM killer enabled.
[  112.735946] Restarting tasks ... done.
[  112.740635] random: crng reseeded on system resumption
[  112.745890] PM: suspend exit
[  115.175862] renesas-gbeth 15c30000.ethernet eth0: Link is Up - 1Gbps/Full - flow control rx/tx
root@smarc-rzg3e:~#  ping 192.168.10.1
PING 192.168.10.1 (192.168.10.1): 56 data bytes
64 bytes from 192.168.10.1: seq=0 ttl=64 time=0.915 ms
64 bytes from 192.168.10.1: seq=1 ttl=64 time=0.915 ms
^C
--- 192.168.10.1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.915/0.915/0.915 ms
root@smarc-rzg3e:~#


Andy Shevchenko (1):
  pinctrl: renesas: Mark local variable with const in ->set_mux()

Biju Das (5):
  pinctrl: renesas: rzg2l: Add suspend/resume support for Schmitt
    control registers
  pinctrl: renesas: rzg2l: Drop unnecessary pin configurations
  pinctrl: renesas: rzg2l: Fix PMC restore
  arm64: dts: renesas: r9a09g047e57-smarc: Add gpio keys
  arm64: dts: renesas: r9a09g047e57-smarc: Use Schmitt input for NMI
    function

Claudiu Beznea (2):
  pinctrl: renesas: rzg2l: Add suspend/resume support for pull up/down
  pinctrl: renesas: rzg2l: Fix ISEL restore on resume

Cosmin Tanislav (2):
  pinctrl: renesas: rzg2l: Remove extra semicolons
  pinctrl: renesas: rzg2l: Remove useless wrappers

John Madieu (1):
  pinctrl: renesas: rzg2l: Refactor OEN register PWPR handling

Lad Prabhakar (1):
  pinctrl: renesas: rzg2l: Validate pins before setting mux function

 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  38 +++
 .../boot/dts/renesas/renesas-smarc2.dtsi      |  31 +++
 drivers/pinctrl/renesas/pinctrl-rzg2l.c       | 247 +++++++++++-------
 drivers/pinctrl/renesas/pinctrl-rzv2m.c       |   2 +-
 4 files changed, 228 insertions(+), 90 deletions(-)

-- 
2.43.0


