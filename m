Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E92BC021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 07:26:57 +0000 (UTC)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
 by mx.groups.io with SMTP id smtpd.web11.5724.1740641215627046306
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Feb 2025 23:26:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=sb0NLljU;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.180, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f6ae4846c7so5801667b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 26 Feb 2025 23:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1740641214; x=1741246014; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=On49k33VjKephQZ8Av7BOizvYeSw4nLSvIDin+I2Eyk=;
        b=sb0NLljUAdBC5Ki+OBp0MYHP1SDFGMkk2Ib7KOOLSrB9+QRzci6TnJxxHjyST26Ry+
         QgPNhwhZjWZ7kyKbF9FnATuR4mBuWBg4PMkCxtW71ilAmRghcBF3VBxM0dCN5KIpDOQL
         9f1cGb9llzcafM9nmQk0nxFmy/VsLqcSTRxF0/p5qHRmQdESmkA/PNWmO6Q5nYa6znGH
         YOFCojgYi1SGqmZ/xgfPi95v9mwn4isMceymAhCktbkM8619M0eRxrOp1+QluxvWHlNB
         +PaqQMe/jZ5Hm0//ZdzSL7mf64qJ2lFGJfy2WXUiJ6ER0I8BZMZFiQizlr09kteAkxFY
         Pdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740641214; x=1741246014;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=On49k33VjKephQZ8Av7BOizvYeSw4nLSvIDin+I2Eyk=;
        b=IV5wJJjO9jzT5l57QyDbwiGEm2J/OaOrAiSBj6M5scJ1uNDRcqgVzjpknT3go1OlXw
         cU//TuLhwEvmNuWyUmXJaofh/8dV2hzwO5jPYNWNN3C37S05pipH3pfuKrjZ5R/arXmp
         8thF16W8v+00Bp9Q40r3/tquNYqwJc1DzEBHsdrFTCj28rWuJwTEll7IJi57Ydkxl26j
         mZiHFpCF3Csgjj3PZ2JzZwyHiOv4yAryn/JgwLtVSN4IfCtH3csApvnS/K298+z0DcgE
         j1HoFQfZXN7kjIzP04ZargVKYW6s9mV4FQNAFYoi+G2mWfADA+BiDEb5hPyROIE8/XFP
         gIxw==
X-Gm-Message-State: AOJu0YxUjbMJ1L7JsUSfNjDcyhbsh98gXcdNtSq7j5C6iwkBF/xfYEo+
	xUE6ovGaJIiS2DncUGyOmqyEY7q2zAwB88hyJTnnch0E0qIEzXOxqGesPD0ICXJ9+PSQm6tdkVs
	hGPBiGM0rIa72L7bGFDjYRLolNCde5geZuFYz3/JmsN6wvsNEM6k=
X-Gm-Gg: ASbGncugsgBYbtvoxxh/1t+Vwm65hc1YAkrpGdHqc3zuezaIztIp4MxoHX4CQUf3g50
	ZwcFaRQBzY8lWvjyP7tKO3FR5AnEbufWlBzCx3JBODfdgFVctsNGaKCO/dXxIwSlZiCToA3K99m
	hcq3ryNXc/
X-Google-Smtp-Source: AGHT+IHUL+lzF95QG0qEmSPKJDJFwqq7k7q7bc95ffT8+9rvbiLxS9oTOqHted2X63OtSSW2EylYz4B5yzqsxju8Yg4=
X-Received: by 2002:a05:690c:6f8f:b0:6ef:4696:f1cc with SMTP id
 00721157ae682-6fbcc7ac7a4mr216771647b3.22.1740641212278; Wed, 26 Feb 2025
 23:26:52 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Feb 2025 16:26:15 +0900
X-Gm-Features: AQ5f1JoyQVxn0cbQ_SXg7HSM6kUrwqhg5GEwlWPnYhtF6iRy97r97svue2Q2wCo
Message-ID: <CAODzB9pY_Sa4dDnkrTmm5zxov48Og1pTwYsQj0p=UtososVPwg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 07:26:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17926

Hi!

It's this week's CVE report.

This week reported 866 new CVEs and 14 updated CVEs.

* New CVEs

CVE-2021-4453: drm/amd/pm: fix a potential gpu_metrics_table memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2021-4453-a1d6@gregkh/

Introduced by commit 95868b8 ("drm/amd/powerplay: add Renoir support
for gpu metrics export") in v5.10-rc1.
Fixed in v5.16-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa464957f7e660abd554f2546a588f6533720e21]
stable/5.10: [222cebd995cdf11fe0d502749560f65e64990e55]
stable/5.15: [257b3bb16634fd936129fe2f57a91594a75b8751]

CVE-2021-47631: ARM: davinci: da850-evm: Avoid NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2021-47631-bcc8@gregkh/

Introduced by commit bae1058 ("davinci: DA850/OMAP-L138 EVM: implement
autodetect of RMII PHY") in v2.6.33-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c64e2ed5cc376e137e572babfd2edc38b2cfb61b]
cip/4.4-st: [c87aaec4fdae5fbe8eb6cfa1ae7a658a425f94f5]
mainline: [83a1cde5c74bfb44b49cb2a940d044bb2380f4ea]
stable/4.19: [c64e2ed5cc376e137e572babfd2edc38b2cfb61b]
stable/5.10: [0a312ec66a03133d28570f07bc52749ccfef54da]
stable/5.15: [0940795c6834fbe7705acc5c3d4b2f7a5f67527a]
stable/5.4: [89931d4762572aaee6edbe5673d41f8082de110f]

CVE-2021-47632: powerpc/set_memory: Avoid spinlock recursion in
change_page_attr()

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2021-47632-c136@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [a4c182ecf33584b9b2d1aa9dad073014a504c01f]
stable/5.15: [6def4eaf0391f24be541633a954c0e4876858b1e]

CVE-2021-47633: ath5k: fix OOB in ath5k_eeprom_read_pcal_info_5111

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2021-47633-ad15@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [25efc5d03455c3839249bc77fce5e29ecb54677e]
cip/4.4-st: [999889053cc6a5706a5ef7e8dfc16a38704ba04c]
mainline: [564d4eceb97eaf381dd6ef6470b06377bb50c95a]
stable/4.19: [25efc5d03455c3839249bc77fce5e29ecb54677e]
stable/5.10: [9d7d83d0399e23d66fd431b553842a84ac10398f]
stable/5.15: [be2f81024e7981565d90a4c9ca3067d11b6bca7f]
stable/5.4: [c4e2f577271e158d87a916afb4e87415a88ce856]

CVE-2021-47634: ubi: Fix race condition between ctrl_cdev_ioctl and
ubi_cdev_ioctl

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2021-47634-f73e@gregkh/

Introduced by commit 714fb87 ("ubi: Fix race condition between ubi
device creation and udev") in v4.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [a8ecee49259f8f78d91ddb329ab2be7e6fd01974]
mainline: [3cbf0e392f173ba0ce425968c8374a6aa3e90f2e]
stable/4.19: [a8ecee49259f8f78d91ddb329ab2be7e6fd01974]
stable/5.10: [432b057f8e847ae5a2306515606f8d2defaca178]
stable/5.15: [1a3f1cf87054833242fcd0218de0481cf855f888]
stable/5.4: [d727fd32cbd1abf3465f607021bc9c746f17b5a8]

CVE-2021-47635: ubifs: Fix to add refcount once page is set private

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2021-47635-8c4f@gregkh/

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b67db8a6ca83e6ff90b756d3da0c966f61cd37b]
stable/5.10: [c34ae24a2590fee96a3a7735ba2fa6cc52306221]
stable/5.15: [4f75bab98565afd4f905059c56ec4caba88a7eec]

CVE-2021-47636: ubifs: Fix read out-of-bounds in ubifs_wbuf_write_nolock()

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2021-47636-09a4@gregkh/

Introduced by commit 1e51764 ("UBIFS: add new flash file system") in
v2.6.27-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5343575aa11c5d7044107d59d43f84aec01312b0]
mainline: [4f2262a334641e05f645364d5ade1f565c85f20b]
stable/4.19: [5343575aa11c5d7044107d59d43f84aec01312b0]
stable/5.10: [07a209fadee7b53b46858538e1177597273862e4]
stable/5.15: [a7054aaf1909cf40489c0ec1b728fdcf79c751a6]
stable/5.4: [b80ccbec0e4804436c382d7dd60e943c386ed83a]

CVE-2021-47637: ubifs: Fix deadlock in concurrent rename whiteout and
inode writeback

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2021-47637-c754@gregkh/

Introduced by commit 9e0a1ff ("ubifs: Implement RENAME_WHITEOUT") in v4.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9dddc8211430fb851ddf0b168e3a00c6f66cc185]
mainline: [afd427048047e8efdedab30e8888044e2be5aa9c]
stable/4.19: [9dddc8211430fb851ddf0b168e3a00c6f66cc185]
stable/5.10: [83e42a78428fc354f5e2049935b84c8d8d29b787]
stable/5.15: [c58af8564a7b08757173009030b74baf4b2b762b]
stable/5.4: [37bdf1ad592555ecda1d55b89f6e393e4c0589d1]

CVE-2021-47638: ubifs: rename_whiteout: Fix double free for whiteout_ui->data

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2021-47638-5ede@gregkh/

Introduced by commit 9e0a1ff ("ubifs: Implement RENAME_WHITEOUT") in v4.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2b3236ecf96db7af5836e1366ce39ace8ce832fa]
mainline: [40a8f0d5e7b3999f096570edab71c345da812e3e]
stable/4.19: [2b3236ecf96db7af5836e1366ce39ace8ce832fa]
stable/5.10: [a90e2dbe66d2647ff95a0442ad2e86482d977fd8]
stable/5.15: [2ad07009c459e56ebdcc089d850d664660fdb742]
stable/5.4: [14276d38c89a170363e90b6ac0a53c3cf61b87fc]

CVE-2021-47639: KVM: x86/mmu: Zap _all_ roots when unmapping gfn range
in TDP MMU

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2021-47639-9183@gregkh/

Introduced by commit b7cccd3 ("KVM: x86/mmu: Fast invalidation for TDP
MMU") in v5.13-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d62007edf01f5c11f75d0f4b1e538fc52a5b1982]
stable/5.15: [af47248407c0c5ae52a752af1ab5ce5b0db91502]

CVE-2021-47640: powerpc/kasan: Fix early region not updated correctly

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2021-47640-1cf1@gregkh/

Introduced by commit cbd1899 ("powerpc/mm: Fix an Oops in
kasan_mmu_init()") in v5.4-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd75080aa8409ce10d50fb58981c6b59bf8707d3]
stable/5.10: [f39a3309393a4a484532f6ba745c6acbcfe06115]
stable/5.15: [5a3d8f3192a409893c57808cc935e16484df1068]
stable/5.4: [7f19245c3647afea8c7c41f795506ef70f64b9f2]

CVE-2021-47641: video: fbdev: cirrusfb: check pixclock to avoid divide by zero

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2021-47641-5a38@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [40b13e3d85744210db13457785646634e2d056bd]
cip/4.4-st: [a9a8e4771a6eedf16bd83ff90ec4f535188d3af2]
mainline: [5c6f402bdcf9e7239c6bc7087eda71ac99b31379]
stable/4.19: [40b13e3d85744210db13457785646634e2d056bd]
stable/5.10: [8c7e2141fb89c620ab4e41512e262fbf25b8260d]
stable/5.15: [6fe23ff94e7840097202e85c148688940b37c9b1]
stable/5.4: [53a2088a396cfa1da92690a1da289634cd73bf0d]

CVE-2021-47642: video: fbdev: nvidiafb: Use strscpy() to prevent buffer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2021-47642-ae1b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [72dd5c46a152136712a55bf026a9aa8c1b12b60d]
cip/4.4-st: [3fdd1933deab439f44f4e168c1a3e1a616c83803]
mainline: [37a1a2e6eeeb101285cd34e12e48a881524701aa]
stable/4.19: [72dd5c46a152136712a55bf026a9aa8c1b12b60d]
stable/5.10: [08dff482012758935c185532b1ad7d584785a86e]
stable/5.15: [9ff2f7294ab0f011cd4d1b7dcd9a07d8fdf72834]
stable/5.4: [055cdd2e7b992921424d4daaa285ced787fb205f]

CVE-2021-47643: media: ir_toy: free before error exiting

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2021-47643-0b4b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
It looks as if this bug was introduced by commit 261463d ("media: rc:
add support for Infrared Toy and IR Droid devices") in 5.9-rc1.

Fixed status
mainline: [52cdb013036391d9d87aba5b4fc49cdfc6ea4b23]
stable/5.10: [99e3f83539cac6884a4df02cb204a57a184ea12b]
stable/5.15: [2011363c196846c083649c91ed30aeef64358d52]

CVE-2021-47644: media: staging: media: zoran: move videodev alloc

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2021-47644-b267@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [82e3a496eb56da0b9f29fdc5b63cedb3289e91de]
stable/5.10: [bd01629315ffd5b63da91d0bd529a77d30e55028]
stable/5.15: [ff3357bffd9fb78f59762d8955afc7382a279079]

CVE-2021-47645: media: staging: media: zoran: calculate the right
buffer number for zoran_reap_stat_com

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2021-47645-ab28@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
It looks as if this bug was introduced by commit 61c3b19 ("media:
staging: media:
Revert \"media: zoran: remove deprecated driver\"") in 5.10-rc1.

Fixed status
mainline: [e3b86f4e558cea9eed71d894df2f19b10d60a207]
stable/5.10: [bafec1a6ba4b187a7fcdcfce0faebdc623d4ef8e]
stable/5.15: [7e76f3ed7ab2ae026c6ef9cc23096a7554af8c52]

CVE-2021-47646: Revert "Revert "block, bfq: honor already-setup queue merges""

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2021-47646-d726@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [f990f0985eda59d4f29fc83fcf300c92b1225d39]
mainline: [15729ff8143f8135b03988a100a19e66d7cb7ecd]
stable/4.19: [f990f0985eda59d4f29fc83fcf300c92b1225d39]
stable/5.10: [cc051f497eac9d8a0d816cd4bffa3415f2724871]
stable/5.15: [65d8a737452e88f251fe5d925371de6d606df613]
stable/5.4: [931aff627469a75c77b9fd3823146d0575afffd6]

CVE-2021-47647: clk: qcom: ipq8074: fix PCI-E clock oops

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2021-47647-febb@gregkh/

Introduced by commit f0cfcf1 ("clk: qcom: ipq8074: Add missing clocks
for pcie") in v5.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf8f5182b8f59309809b41c1d1730ed9ca6134b1]
stable/5.10: [8b89c9e68a01a19a1dd689a42aa65d545e931899]
stable/5.15: [41e360fa73a4c2f5b78f5ded78a5375b08c206a5]

CVE-2021-47648: gpu: host1x: Fix a memory leak in 'host1x_remove()'

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2021-47648-51ef@gregkh/

Introduced by commit 8474b02 ("gpu: host1x: Refactor channel
allocation code") in v4.13-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [025c6643a81564f066d8381b9e2f4603e0f8438f]
stable/5.10: [6bb107332db28a0e9256c2d36a0902b85307612c]
stable/5.15: [c06577a80485511b894cb688e881ef0bc2d1d296]

CVE-2021-47649: udmabuf: validate ubuf->pagecount

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2021-47649-f358@gregkh/

Introduced by commit fbb0de7 ("Add udmabuf misc device") in v4.20-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b6dd600dd72573c23ea180b5b0b2f1813405882]
stable/5.10: [b267a8118c2b171bf7d67b90ed64154eeab9fae0]
stable/5.15: [811b667cefbea9cb7511a874b169d6a92907137e]
stable/5.4: [5d50f851dd307c07ca5591297093f19967c834a9]

CVE-2021-47650: ASoC: soc-compress: prevent the potentially use of null pointer

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2021-47650-d468@gregkh/

Introduced by commit 467fece ("ASoC: soc-dai: move
snd_soc_dai_stream_valid() to soc-dai.c") in v5.4-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de2c6f98817fa5decb9b7d3b3a8a3ab864c10588]
stable/5.10: [4639c1d97f385f4784f44d66a3da0672f4951ada]
stable/5.15: [fc237b8d624f4bcb0f21a532627ce4e3b3a85569]
stable/5.4: [68a69ad8df959e5211ed4a8e120783b2d352ea74]

CVE-2021-47651: soc: qcom: rpmpd: Check for null return of devm_kcalloc

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2021-47651-57dd@gregkh/

Introduced by commit bbe3a66 ("soc: qcom: rpmpd: Add a Power domain
driver to model corners") in v5.1-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a811126d38f9767a20cc271b34db7c8efc5a46c]
stable/5.10: [b5d6eba71997b6d661935d2b15094ac7f9f6132d]
stable/5.15: [724376c30af5a57686b223dbcd6188e07d2a1de2]
stable/5.4: [755dbc3d73789ac9f0017c729abf5e4b153bf799]

CVE-2021-47652: video: fbdev: smscufx: Fix null-ptr-deref in ufx_usb_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2021-47652-65fa@gregkh/

Introduced by commit 3c8a63e ("Add support for SMSC UFX6000/7000 USB
display adapters") in v3.2-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dd3a6cc7385b89ec2303f39dfc3bafa4e24cec4b]
cip/4.4-st: [132ee7957c8b6a11ef33a74e8e8fdd76739a1b62]
mainline: [1791f487f877a9e83d81c8677bd3e7b259e7cb27]
stable/4.19: [dd3a6cc7385b89ec2303f39dfc3bafa4e24cec4b]
stable/5.10: [64ec3e678d76419f207b9cdd338dda438ca10b1c]
stable/5.15: [c420b540db4b5d69de0a36d8b9d9a6a79a04f05a]
stable/5.4: [da8b269cc0a2526ebeaccbe2484c999eb0f822cf]

CVE-2021-47653: media: davinci: vpif: fix use-after-free on driver unbind

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2021-47653-2d4e@gregkh/

Introduced by commit 479f7a1 ("[media] davinci: vpif: adaptions for DT
support") in v4.13-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43acb728bbc40169d2e2425e84a80068270974be]
stable/5.15: [6512c3c39cb6b573b791ce45365818a38b76afbe]

CVE-2021-47654: samples/landlock: Fix path_list memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2021-47654-671d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by ba84b0b ("samples/landlock: Add a sandbox manager
example") in 5.13-rc1.

Fixed status
mainline: [66b513b7c64a7290c1fbb88e657f7cece992e131]
stable/5.15: [20fbf100f84b9aeb9c91421abe1927bc152bc32b]

CVE-2021-47655: media: venus: vdec: fixed possible memory leak issue

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2021-47655-0491@gregkh/

Introduced by commit 40d87aa ("media: venus: vdec: decoded picture
buffer handling during reconfig sequence") in v5.16-rc1.
Fixed in v5.17.2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [5f89d05ba93df9c2cdfe493843f93288e55e99eb]

CVE-2021-47656: jffs2: fix use-after-free in jffs2_clear_xattr_subsystem

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2021-47656-0abd@gregkh/

Introduced by commit aa98d7c ("[JFFS2][XATTR] XATTR support on JFFS2
(version. 5)") in v2.6.20.16.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c3b07c875fa8f906f932976460fd14798596f101]
mainline: [4c7c44ee1650677fbe89d86edbad9497b7679b5c]
stable/4.19: [c3b07c875fa8f906f932976460fd14798596f101]
stable/5.10: [7bb7428dd73991bf4b3a7a61b493ca50046c2b13]
stable/5.15: [7a75740206af5f17e9f3efa384211cba70213da1]
stable/5.4: [30bf7244acf32f19cb722c39f7bc1c2a9f300422]

CVE-2021-47657: drm/virtio: Ensure that objs is not NULL in
virtio_gpu_array_put_free()

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2021-47657-6f3d@gregkh/

Introduced by commit 377f833 ("drm/virtio: fix possible leak/unlock
virtio_gpu_object_array") in v5.13-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b79f96f4a23846516e5e6e4dd37fc06f43a60dd]
stable/5.15: [b094fece3810c71ceee6f0921676cb65d4e68c5a]

CVE-2021-47658: drm/amd/pm: fix a potential gpu_metrics_table memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2021-47658-3eb0@gregkh/

Introduced by commit 95868b8 ("drm/amd/powerplay: add Renoir support
for gpu metrics export") in v5.10-rc1.
Fixed in v5.17-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [583637d66a70fc7090e12fb0ebbacc33d39e2214]

CVE-2021-47659: drm/plane: Move range check for format_count earlier

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2021-47659-ba18@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
Introduced by e6fc3b6 ("drm: Plumb modifiers through plane init") in 4.14-rc1.

Fixed status
cip/4.19-st: [4ab7e453a3ee88c274cf97bee9487ab92a66d313]
mainline: [4b674dd69701c2e22e8e7770c1706a69f3b17269]
stable/4.19: [4ab7e453a3ee88c274cf97bee9487ab92a66d313]
stable/5.10: [b5cd108143513e4498027b96ec4710702d186f11]
stable/5.15: [978e3d023256bfaf34a0033d40c94e8a8e70cf3c]
stable/5.4: [1e29d829ad51d1472dd035487953a6724b56fc33]

CVE-2021-47660: fs/ntfs3: Fix some memory leaks in an error handling
path of 'log_replay()'

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2021-47660-af30@gregkh/

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e589f9b7078e1c0191613cd736f598e81d2390de]
stable/5.15: [d8be98ab88250dc12a98efdb703792a537b0eac3]

CVE-2022-49044: dm integrity: fix memory corruption when tag_size is
less than digest size

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49044-43d1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc3.
Introduced by 329e0989 ("treewide: Replace more open-coded allocation
size multiplications") in 4.19-rc8.

Fixed status
cip/4.19-st: [6a95d91c0b315c965198f6ab7dec7c94129e17e0]
mainline: [08c1af8f1c13bbf210f1760132f4df24d0ed46d6]
stable/4.19: [6a95d91c0b315c965198f6ab7dec7c94129e17e0]
stable/5.10: [cd02b2687d66f0a8e716384de4b9a0671331f1dc]
stable/5.15: [6b4bf97587ef6c1927a78934b700204920655123]
stable/5.4: [7f84c937222944c03f4615ca4742df6bed0e5adf]

CVE-2022-49045: ALSA: pcm: Test for "silence" field in struct "pcm_format_data"

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49045-7d21@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc3.


Fixed status
cip/4.19-st: [eb04e3112a3516e483d60a9af9762961702a6c1b]
cip/4.4-st: [37a52f172623ed515523d1c30917cea2ef511bfe]
mainline: [2f7a26abb8241a0208c68d22815aa247c5ddacab]
stable/4.19: [eb04e3112a3516e483d60a9af9762961702a6c1b]
stable/5.10: [912797e54c99a98f0722f21313e13a3938bb6dba]
stable/5.15: [63038f6e96a77a0abf8083649c53e6a72c1a0124]
stable/5.4: [377a80ca6590f40ec8a85227b889a5d399fe26c3]

CVE-2022-49046: i2c: dev: check return value when calling dev_set_name()

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49046-9186@gregkh/

Introduced by commit 1413ef6 ("i2c: dev: Fix the race between the
release of i2c_dev and cdev") in v5.7-rc1.
Fixed in v5.18-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
mainline: [993eb48fa199b5f476df8204e652eff63dd19361]
stable/5.15: [2f345bb14ad4744950499ff222e2899209297afa]

CVE-2022-49047: ep93xx: clock: Fix UAF in ep93xx_clk_register_gate()

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49047-fbc3@gregkh/

Introduced by commit 9645ccc ("ep93xx: clock: convert in-place to
COMMON_CLK") in v5.16-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b68b08885217abd9c57ff9b3bb3eb173eee02a9]

CVE-2022-49048: ipv6: fix panic when forwarding a pkt with no in6 dev

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49048-8b39@gregkh/

Introduced by commit ccd27f0 ("ipv6: fix 'disable_policy' for fwd
packets") in v5.14-rc2.
Fixed in v5.18-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [74b68f5249f16c5f7f675d0f604fa6ae20e3a151]
mainline: [e3fa461d8b0e185b7da8a101fe94dfe6dd500ac0]
stable/4.19: [74b68f5249f16c5f7f675d0f604fa6ae20e3a151]
stable/5.10: [a263712ba8c9ded25dd9d2d5ced11bcea5b33a3e]
stable/5.15: [adee01bbf6cb5b3e4ed08be8ff866aac90f13836]
stable/5.4: [ab2f5afb7af5c68389e8c7dd29e0a98fbeaaa435]

CVE-2022-49049: mm/secretmem: fix panic when growing a memfd_secret

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49049-d847@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc3.
Affected file was introduced by 1507f51 ("mm: introduce memfd_secret system
call to create "secret" memory areas") in 5.14-rc1.

Fixed status
mainline: [f9b141f93659e09a52e28791ccbaf69c273b8e92]
stable/5.15: [b6d17c67885a5624e96eb30c4178c65eea8374bf]

CVE-2022-49050: memory: renesas-rpc-if: fix platform-device leak in error path

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49050-e12a@gregkh/

Introduced by commit ca7d8b9 ("memory: add Renesas RPC-IF driver") in v5.9-rc1.
Fixed in v5.18-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt

Fixed status
mainline: [b452dbf24d7d9a990d70118462925f6ee287d135]
stable/5.10: [c089ffc846c85f200db34ad208338f4f81a6d82d]
stable/5.15: [05d1824a7fb43ab9adb1eb82404954af81d8c984]

CVE-2022-49051: net: usb: aqc111: Fix out-of-bounds accesses in RX fixup

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49051-08bd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.
It seems as if it was introduced by 361459cd ("net: usb: aqc111:
Implement RX data path")
in 5.0-rc1.

Fixed status
mainline: [afb8e246527536848b9b4025b40e613edf776a9d]
stable/5.10: [d90df6da50c56ad8b1a132e3cf86b6cdf8f507b7]
stable/5.15: [b416898442f2b6aa9f1b2f2968ce07e3abaa05f7]
stable/5.4: [404998a137bcb8a926f7c949030afbe285472593]

CVE-2022-49052: mm: fix unexpected zeroed page mapping with zram swap

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49052-4ea2@gregkh/

Introduced by commit 0bcac06 ("mm, swap: skip swapcache for swapin of
synchronous device") in v4.15-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f86d55cf616199404c05f5b0c5c41b17351baa02]
mainline: [e914d8f00391520ecc4495dd0ca0124538ab7119]
stable/4.19: [f86d55cf616199404c05f5b0c5c41b17351baa02]
stable/5.10: [20ed94f8181a25212e7404e44958e234f407624b]
stable/5.15: [12ba1d38115a101c45d8e0ca3aa1181fd148e57f]
stable/5.4: [f098f8b9820fe3f2e41aefc4329dfe8a3859d1c1]

CVE-2022-49053: scsi: target: tcmu: Fix possible page UAF

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49053-a1fe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.


Fixed status
cip/4.19-st: [e3e0e067d5b34e4a68e3cc55f8eebc413f56f8ed]
mainline: [a6968f7a367f128d120447360734344d5a3d5336]
stable/4.19: [e3e0e067d5b34e4a68e3cc55f8eebc413f56f8ed]
stable/5.10: [aec36b98a1bbaa84bfd8299a306e4c12314af626]
stable/5.15: [b7f3b5d70c834f49f7d87a2f2ed1c6284d9a0322]
stable/5.4: [fb7a5115422fbd6a4d505e8844f1ef5529f10489]

CVE-2022-49054: Drivers: hv: vmbus: Deactivate sysctl_record_panic_msg
by default in isolated guests

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49054-d850@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.
The hv_is_isolation_supported was introduced by a6c76bb ("x86/hyperv: Load/save
the Isolation Configuration leaf") in 5.12-rc1-dontuse.
So, apply this patch to before 5.12, it needs to backport a6c76bb as well.

Fixed status
mainline: [9f8b577f7b43b2170628d6c537252785dcc2dcea]
stable/5.15: [1b576e81d31b56b248316b8ff816b1cc5c4407c7]

CVE-2022-49055: drm/amdkfd: Check for potential null return of kmalloc_array()

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49055-b2a2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.


Fixed status
cip/4.19-st: [94869bb0de69a812f70231b0eb480bb2f7ae73a6]
cip/4.4-st: [02b0f90da0145f967bb152a07f6124e90ad3b03e]
mainline: [ebbb7bb9e80305820dc2328a371c1b35679f2667]
stable/4.19: [94869bb0de69a812f70231b0eb480bb2f7ae73a6]
stable/5.10: [1d7a5aae884ca727d41c7ed15d4c82fdb67c040c]
stable/5.15: [f2658d5966bcee8c3eb487875f459756d4f7cdfc]
stable/5.4: [c7a268b33882d5feaafd29c1734456f41ba41396]

CVE-2022-49056: io_uring: abort file assignment prior to assigning creds

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49056-f882@gregkh/

This CVE announce does not contain fixed commit in the mainline.
Introduced by 6bf9c47a ("io_uring: defer file assignment") in 5.18-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [701521403cfb228536b3947035c8a6eca40d8e58]

CVE-2022-49057: block: null_blk: end timed out poll request

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49057-94a2@gregkh/

Introduced by commit 0a593fb ("null_blk: poll queue support") in v5.16-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e3876d322aef82416ecc496a4d4a587e0fdf7a3]

CVE-2022-49058: cifs: potential buffer overflow in handling symlinks

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49058-5df2@gregkh/

Introduced by commit c69c1b6 ("cifs: implement CIFSParseMFSymlink()")
in v2.6.37-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [eb5f51756944735ac70cd8bb38637cc202e29c91]
cip/4.4-st: [210259beddfc21292ed0c9be53854c8b1f053f21]
mainline: [64c4a37ac04eeb43c42d272f6e6c8c12bfcf4304]
stable/4.19: [eb5f51756944735ac70cd8bb38637cc202e29c91]
stable/5.10: [4e166a41180be2f1e66bbb6d46448e80a9a5ec05]
stable/5.15: [9901b07ba42b39266b34a888e48d7306fd707bee]
stable/5.4: [22d658c6c5affed10c8907e67160cef0b6c92186]

CVE-2022-49059: nfc: nci: add flush_workqueue to prevent uaf

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49059-4608@gregkh/

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1a1748d0dd0f0a98535c6baeef671c8722107639]
cip/4.4-st: [a0d7e60819c2dcbabcfeaeddd7095e9b47a0f52d]
mainline: [ef27324e2cb7bb24542d6cb2571740eefe6b00dc]
stable/4.19: [1a1748d0dd0f0a98535c6baeef671c8722107639]
stable/5.10: [67677050cecbe0edfdd81cd508415e9636ba7c65]
stable/5.15: [9ded5ae40f4fe37fcc28f36d76bf45df20be5432]
stable/5.4: [5c63ad2b0a267a524c12c88acb1ba9c2d109a801]

CVE-2022-49060: net/smc: Fix NULL pointer dereference in smc_pnet_find_ib()

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49060-6210@gregkh/

Introduced by commit af5f60c ("net/smc: allow PCI IDs as ib device
names in the pnet table") in v5.1-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d22f4f977236f97e01255a80bca2ea93a8094fc8]
stable/5.10: [35b91e49bc80ca944a8679c3b139ddaf2f8eea0f]
stable/5.15: [3a523807f01455fe9a0c1a433f27cd4411ee400f]
stable/5.4: [a05f5e26cb8bb4d07e0595545fcad1bb406f0085]

CVE-2022-49061: net: ethernet: stmmac: fix altr_tse_pcs function when
using a fixed-link

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49061-01b6@gregkh/

Introduced by commit fb3bbdb ("net: ethernet: Add TSE PCS support to
dwmac-socfpga") in v4.8-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e2423aa174e6c3e9805e96db778245ba73cdd88c]
mainline: [a6aaa00324240967272b451bfa772547bd576ee6]
stable/5.10: [08d5e3e954537931c8da7428034808d202e98299]
stable/5.15: [62a48383ebe2e159fd68425dd3e16d4c6bd6599a]
stable/5.4: [7e59fdf9547c4f948d1d917ec7ffa5fb5ac53bdb]

CVE-2022-49062: cachefiles: Fix KASAN slab-out-of-bounds in
cachefiles_set_volume_xattr

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49062-ec51@gregkh/

Introduced by commit 413a4a6 "cachefiles: Fix volume coherency
attribute" in v5.17-rc8.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b2f6c306601240635c72caa61f682e74d4591b2]

CVE-2022-49063: ice: arfs: fix use-after-free when freeing @rx_cpu_rmap

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49063-a6de@gregkh/

Introduced by commit 28bf267 ("ice: Implement aRFS") in v5.8-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7442f512b71fc63a99c8a801422dde4fbbf9f93]

CVE-2022-49064: cachefiles: unmark inode in use in error path

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49064-3c74@gregkh/

Introduced by commit 1f08c92 ("cachefiles: Implement backing file
wrangling") in v5.17-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea5dc046127e857a7873ae55fd57c866e9e86fb2]

CVE-2022-49065: SUNRPC: Fix the svc_deferred_event trace class

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49065-46dc@gregkh/

Introduced by commit ece200d ("sunrpc: Save remote presentation
address in svc_xprt for trace events") in v4.17-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d5004451ab2218eab94a30e1841462c9316ba19]
stable/5.10: [85ee17ca21cf92989e8c923e3ea4514c291e9d38]
stable/5.15: [726ae7300fcc25fefa46d188cc07eb16dc908f9e]

CVE-2022-49066: veth: Ensure eth header is in skb's linear part

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49066-bc68@gregkh/

Introduced by commit e314dbd ("[NET]: Virtual ethernet device
driver.") in v2.6.24-rc1.
Fixed in v5.18-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1ef0088e43af1de4e3b365218c4d3179d9a37eec]
cip/4.4-st: [29f2ddb45315eaa1b311c277c99465867cb6b6b4]
mainline: [726e2c5929de841fdcef4e2bf995680688ae1b87]
stable/4.19: [1ef0088e43af1de4e3b365218c4d3179d9a37eec]
stable/5.10: [d67c900f1947d64ba8a64f693504bcaab8d9000c]
stable/5.15: [93940fc4cb81840dc0fa202de48cccb949a0261d]
stable/5.4: [2fd90b86dff413fbf8128780c04ea9c6849c16e2]

CVE-2022-49067: powerpc: Fix virt_addr_valid() for 64-bit Book3E & 32-bit

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49067-94d7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.


Fixed status
mainline: [ffa0b64e3be58519ae472ea29a1a1ad681e32f48]
stable/5.10: [d36febbcd537fcc50284e8b89609632d0146529f]
stable/5.15: [fddb88bd266f4513abab7c36bca98935c9148a98]
stable/5.4: [deab81144d5a043f42804207fb76cfbd8a806978]

CVE-2022-49068: btrfs: release correct delalloc amount in direct IO write path

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49068-aa1b@gregkh/

Introduced by commit f0bfa76 ("btrfs: fix ENOSPC failure when
attempting direct IO write into NOCOW range") in v5.17-rc1.
Fixed in v5.18-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [6d82ad13c4110e73c7b0392f00534a1502a1b520]
stable/5.15: [07cacfd9d9dc134557ac8866c73d570a59b3d1f3]

CVE-2022-49069: drm/amd/display: Fix by adding FPU protection for
dcn30_internal_validate_bw

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49069-2dba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.
Introduced by bc204778 ("drm/amd/display: Set min dcfclk if pipe count
is 0") in 5.16-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [ca1198849ab0e7af5efb392ef6baf1138f6fc086]

CVE-2022-49070: fbdev: Fix unregistering of framebuffers without device

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49070-6511@gregkh/


Introduced by 27599aa ("fbdev: Hot-unplug firmware fb devices on
forced removal") in 5.18-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [0f525289ff0ddeb380813bd81e0f9bdaaa1c9078]
stable/5.15: [2388f826cdc9af2651991adc0feb79de9bdf2232]

CVE-2022-49071: drm/panel: ili9341: fix optional regulator handling

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49071-4599@gregkh/

Introduced by commit 5a04227 ("drm/panel: Add ilitek ili9341 panel
driver") in v5.15-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d14eb80e27795b7b20060f7b151cdfe39722a813]
stable/5.15: [28dc1503a9d36654f9c61adb2915682515a30f71]

CVE-2022-49072: gpio: Restrict usage of GPIO chip irq members before
initialization

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49072-8479@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.


Fixed status
mainline: [5467801f1fcbdc46bc7298a84dbf3ca1ff2a7320]
stable/5.10: [7e88a50704b0c49ad3f2d11e8b963341cf68a89f]
stable/5.15: [0912cf021fb5749372b3782611d8b1de4986c13a]

CVE-2022-49073: ata: sata_dwc_460ex: Fix crash due to OOB write

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49073-0a26@gregkh/

Introduced by commit 28361c4 ("libata: add extra internal command") in
v4.18-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [596c7efd69aae94f4b0e91172b075eb197958b99]
mainline: [7aa8104a554713b685db729e66511b93d989dd6a]
stable/4.19: [596c7efd69aae94f4b0e91172b075eb197958b99]
stable/5.10: [fc629224aa62f23849cae83717932985ac51232d]
stable/5.15: [8a05a6952ecd59aaa62cbdcdaf523ae2c8f436e8]
stable/5.4: [55e1465ba79562a191708a40eeae3f8082a209e3]

CVE-2022-49074: irqchip/gic-v3: Fix GICR_CTLR.RWP polling

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49074-a7c9@gregkh/

Introduced by commit 021f653 ("irqchip: gic-v3: Initial support for
GICv3") in v3.17-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c7daf1b4ad809692d5c26f33c02ed8a031066548]
mainline: [0df6664531a12cdd8fc873f0cac0dcb40243d3e9]
stable/4.19: [c7daf1b4ad809692d5c26f33c02ed8a031066548]
stable/5.10: [ff24114bb08d8b90edf2aff0a4fd0689523e6c17]
stable/5.15: [7218a789abb3e033f5f3a85636ca50d9ae7b0fc9]
stable/5.4: [3c07cc242baf83f0bddbbd9d7945d0bee56d8b57]

CVE-2022-49075: btrfs: fix qgroup reserve overflow the qgroup limit

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49075-ad31@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.
Introduced by 7bc329c ("btrfs: qgroup: Return actually freed bytes for qgroup
release or free data") in 4.13-rc1.

Fixed status
cip/4.19-st: [f3d97b22a708bf9e3f3ac2ba232bcefd0b0c136b]
mainline: [b642b52d0b50f4d398cb4293f64992d0eed2e2ce]
stable/4.19: [f3d97b22a708bf9e3f3ac2ba232bcefd0b0c136b]
stable/5.10: [82ae73ac963cee877ce34f7c31b2b456b516e96c]
stable/5.15: [4b98799e181b4326a613108cf37acc1f55d21b45]
stable/5.4: [44277c50fdba5019ca25bfad1b71e2561b0de11b]

CVE-2022-49076: RDMA/hfi1: Fix use-after-free bug for mm struct

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49076-cddc@gregkh/

Introduced by commit 3d2a9d6 ("IB/hfi1: Ensure correct mm is used at
all times") in v5.10-rc6.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bbac98d0930e8161b1957dc0ec99de39ade1b3c]
stable/5.10: [5f54364ff6cfcd14cddf5441c4a490bb28dd69f7]
stable/5.15: [9ca11bd8222a612de0d2f54d050bfcf61ae2883f]

CVE-2022-49077: mmmremap.c: avoid pointless invalidate_range_start/end
on mremap(old_size=0)

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49077-6e0c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.


Fixed status
cip/4.19-st: [e2c328c2a8f9de8b761bd4025b66c63120c55761]
cip/4.4-st: [549d58e285225718f98401aaae8a55bb3501d544]
mainline: [01e67e04c28170c47700c2c226d732bbfedb1ad0]
stable/4.19: [e2c328c2a8f9de8b761bd4025b66c63120c55761]
stable/5.10: [7d659cb1763ff17d1c6ee082fa6feb4267c7a30b]
stable/5.15: [a04cb99c5d4668fe3f5c0e5b6da1cecd34c3f219]
stable/5.4: [c19d8de4e682ec4b0ea2b04a832cd8cc0be3bb31]

CVE-2022-49078: lz4: fix LZ4_decompress_safe_partial read out of bound

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49078-df00@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc2.
Introduced by 2209fda ("lib/lz4: update LZ4 decompressor module") in 4.20-rc1.

Fixed status
mainline: [eafc0a02391b7b36617b36c97c4b5d6832cf5e24]
stable/5.10: [6adc01a7aa37445dafe8846faa0610a86029b253]
stable/5.15: [9fb8bc6cfc58773ce95414e11c9ccc8fc6ac4927]
stable/5.4: [73953dfa9d50e5c9fe98ee13fd1d3427aa12a0a3]

CVE-2022-49079: btrfs: zoned: traverse devices under chunk_mutex in
btrfs_can_activate_zone

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49079-6c19@gregkh/

Introduced by commit a85f05e ("btrfs: zoned: avoid chunk allocation if
active block group has enough space") in v5.16-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b9e66762aa0cda2a9c2d5542d64e04dac528fa6]

CVE-2022-49080: mm/mempolicy: fix mpol_new leak in shared_policy_replace

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49080-5718@gregkh/

Introduced by commit 42288fe ("mm: mempolicy: Convert shared_policy
mutex to spinlock") in v3.8-rc2.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [39a32f3c06f6d68a530bf9612afa19f50f12e93d]
cip/4.4-st: [1ba9c04b008a35ebdddb676297af1601259f339b]
mainline: [4ad099559b00ac01c3726e5c95dc3108ef47d03e]
stable/4.19: [39a32f3c06f6d68a530bf9612afa19f50f12e93d]
stable/5.10: [f7e183b0a7136b6dc9c7b9b2a85a608a8feba894]
stable/5.15: [198932a14aeb19a15cf19e51e151d023bc4cd648]
stable/5.4: [25f506273b6ae806fd46bfcb6fdaa5b9ec81a05b]

CVE-2022-49081: highmem: fix checks in __kmap_local_sched_{in,out}

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49081-7a0f@gregkh/

Introduced by commit 5fbda3e ("sched: highmem: Store local kmaps in
task struct") in v5.11-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66f133ceab7456c789f70a242991ed1b27ba1c3d]
stable/5.15: [c21d040de6225414547d9bd31cd200f290991c85]

CVE-2022-49082: scsi: mpt3sas: Fix use after free in
_scsih_expander_node_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49082-676c@gregkh/

Introduced by commit 7d310f2 ("scsi: mpt3sas: Get device objects using
sas_address & portID") in v5.11-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87d663d40801dffc99a5ad3b0188ad3e2b4d1557]
stable/5.15: [25c1353dca74ad7cf3fd7ce258fe7c957a147d5e]

CVE-2022-49083: iommu/omap: Fix regression in probe for NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49083-34be@gregkh/

Introduced by commit 6785eb9 ("iommu/omap: Convert to
probe/release_device() call-backs") in v5.8-rc1.
Introduced by commit 3f6634d ("iommu: Use right way to retrieve
iommu_ops") in v5.18-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71ff461c3f41f6465434b9e980c01782763e7ad8]
stable/5.10: [bd905fed87ce01ac010011bb8f44ed0140116ceb]
stable/5.15: [47e239117bd97c8556f9187af7a9a7938db4e021]

CVE-2022-49084: qede: confirm skb is allocated before using

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49084-b132@gregkh/

Introduced by commit 8a86339 ("qede: Add build_skb() support.") in v4.18-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9648adb1b3ece55c657d3a4f52bfee663b710dfe]
mainline: [4e910dbe36508654a896d5735b318c0b88172570]
stable/4.19: [9648adb1b3ece55c657d3a4f52bfee663b710dfe]
stable/5.10: [8928239e5e2e460d95b8a0b89f61671625e7ece0]
stable/5.15: [c9bdce2359b5f4986eb38d1e81865b3586cc20d2]
stable/5.4: [034a92c6a81048128fc7b18d278d52438a13902a]

CVE-2022-49085: drbd: Fix five use after free bugs in get_initial_state

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49085-a9d4@gregkh/

Introduced by commit a297284 ("drbd: Backport the "events2" command")
in v4.5-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [188fe6b26765edbad4055611c0f788b6870f4024]
mainline: [aadb22ba2f656581b2f733deb3a467c48cc618f6]
stable/4.19: [188fe6b26765edbad4055611c0f788b6870f4024]
stable/5.10: [594205b4936771a250f9d141e7e0fff21c3dd2d9]
stable/5.15: [a972c768723359ec995579902473028fe3cd64b1]
stable/5.4: [b6a4055036eed1f5e239ce3d8b0db1ce38bba447]

CVE-2022-49086: net: openvswitch: fix leak of nested actions

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49086-a289@gregkh/

Introduced by commit 34ae932 ("openvswitch: Make tunnel set action
attach a metadata dst") in v4.3-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7438dc55c0709819b813f4778aec2c48b782990b]
mainline: [1f30fb9166d4f15a1aa19449b9da871fe0ed4796]
stable/4.19: [7438dc55c0709819b813f4778aec2c48b782990b]
stable/5.10: [5ae05b5eb58773cfec307ff88aff4cfd843c4cff]
stable/5.15: [837b96d8103938e35e7d92cd9db96af914ca4fff]
stable/5.4: [ef6f9ce0a79aa23b10fc5f3b3cab3814a25aac40]

CVE-2022-49087: rxrpc: fix a race in rxrpc_exit_net()

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49087-1127@gregkh/

Introduced by commit ace45be ("rxrpc: Fix firewall route keepalive")
in v4.17-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [864297ee30727ae6233f80296b7fc91442620b05]
mainline: [1946014ca3b19be9e485e780e862c375c6f98bad]
stable/4.19: [864297ee30727ae6233f80296b7fc91442620b05]
stable/5.10: [08ff0e74fab517dbc44e11b8bc683dd4ecc65950]
stable/5.15: [571d8e1d154ca18f08dcb72b69318d36e10010a0]
stable/5.4: [7ee84d29f22de6f6c63fad6c54690517659862f1]

CVE-2022-49088: dpaa2-ptp: Fix refcount leak in dpaa2_ptp_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49088-a1ec@gregkh/

Introduced by commit d346c9e ("dpaa2-ptp: reuse ptp_qoriq driver") in v5.3-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b04bd4f03bba021959ca339314f6739710f0954]
stable/5.10: [ebd1e3458dbf6643aa0272da398cb5b537d492b7]
stable/5.15: [599874bbc4ed832ccb578d48ac0ae7344382ef43]
stable/5.4: [fbe5f4c0dd3475178f17ddd8b8d5044ebeae0be7]

CVE-2022-49089: IB/rdmavt: add lock to call to rvt_error_qp to prevent
a race condition

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49089-2a32@gregkh/

Introduced by commit d757c60 ("IB/rdmavt: Fix concurrency panics in QP
post_send and modify to error") in v5.1-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d809f69695d4e7d1378b3a072fa9aef23123018]
stable/5.10: [43c2d7890ecabe527448a6c391fb2d9a5e6bbfe0]
stable/5.15: [92f1947c0d26060e978b3a9f21f32ce7c8c9cca3]
stable/5.4: [8a50937227c385a477177c9ffa122b4230e40666]

CVE-2022-49090: arch/arm64: Fix topology initialization for core scheduling

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49090-c4ae@gregkh/

Introduced by commit 9edeaea ("sched: Core-wide rq->lock") in v5.14-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5524cbb1bfcdff0cad0aaa9f94e6092002a07259]
stable/5.15: [87f5d66daa5f457449bb95d6b8d18bb7596aa627]

CVE-2022-49091: drm/imx: Fix memory leak in imx_pd_connector_get_modes

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49091-0014@gregkh/

Introduced by commit 76ecd9c ("drm/imx: parallel-display: check return
code from of_get_drm_display_mode()") in v4.8-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [41624d7c0c3df71dee170c610744aaa5909327b8]
mainline: [bce81feb03a20fca7bbdd1c4af16b4e9d5c0e1d3]
stable/4.19: [41624d7c0c3df71dee170c610744aaa5909327b8]
stable/5.10: [f8b0ef0a5889890b50482b6593bd8de544736351]
stable/5.15: [31e449302ed00c38d4068443cf0243279701ab28]
stable/5.4: [c539a6a5896ed92bfb91494e46996d013f3d5967]

CVE-2022-49092: net: ipv4: fix route with nexthop object delete warning

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49092-db38@gregkh/

Introduced by commit 4c7e808 ("ipv4: Plumb support for nexthop object
in a fib_info") in v5.3-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bf92d70e690b7ff12b24f4bfff5e5434d019b82]
stable/5.10: [63ea57478aaa3e06a597081a0f537318fc04e49f]
stable/5.15: [907c97986d6fa77318d17659dd76c94b65dd27c5]
stable/5.4: [f5064531c23ad646da7be8b938292b00a7e61438]

CVE-2022-49093: skbuff: fix coalescing for page_pool fragment recycling

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49093-0ccf@gregkh/

Introduced by commit 53e0961 ("page_pool: add frag page recycling
support in page pool") in v5.15-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1effe8ca4e34c34cdd9318436a4232dcb582ebf4]
stable/5.15: [ba965e8605aee5387cecaa28fcf7ee9f61779a49]

CVE-2022-49094: net/tls: fix slab-out-of-bounds bug in decrypt_internal

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49094-9749@gregkh/

Introduced by commit f295b3a ("net/tls: Add support of AES128-CCM
based ciphers") in v5.2-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9381fe8c849cfbe50245ac01fc077554f6eaa0e2]
stable/5.10: [589154d0f18945f41d138a5b4e49e518d294474b]
stable/5.15: [6e2f1b033b17dedda51d465861b69e58317d6343]
stable/5.4: [2b7d14c105dd8f6412eda5a91e1e6154653731e3]

CVE-2022-49095: scsi: zorro7xx: Fix a resource leak in zorro7xx_remove_one()

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49095-641f@gregkh/

Introduced by commit 45804fb ("[SCSI] 53c700: Amiga Zorro NCR53c710
SCSI") in v2.6.23-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [db863ab2baf058ed05c7b723612e3c40c9dd6885]
cip/4.4-st: [600db6912a5a806ed5084eb68f9cb4715578474b]
mainline: [16ed828b872d12ccba8f07bcc446ae89ba662f9c]
stable/4.19: [db863ab2baf058ed05c7b723612e3c40c9dd6885]
stable/5.10: [c5f77b595379b5191316edd365a542f8b1526066]
stable/5.15: [aefd755a96051aa56b198cb7ecd168b22ba384f6]
stable/5.4: [34a47f7ddb4fd1cbd12397aa6f7dad1de08b4050]

CVE-2022-49096: net: sfc: add missing xdp queue reinitialization

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49096-3214@gregkh/

Introduced by commit 3990a8f ("sfc: allocate channels for XDP tx
queues") in v5.5-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [059a47f1da93811d37533556d67e72f2261b1127]
stable/5.15: [ed7a824fda8732578d1014fad1f7fb0363705090]

CVE-2022-49097: NFS: Avoid writeback threads getting stuck in mempool_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49097-fb5e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [0bae835b63c53f86cdc524f5962e39409585b22c]
stable/5.10: [c74e2f6ecc51bd08bb5b0335477dba954a50592e]
stable/5.15: [ea029e4ce760f786919d06ef52efa2e50ea92a5f]

CVE-2022-49098: Drivers: hv: vmbus: Fix potential crash on module unload

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49098-9755@gregkh/

Introduced by commit 74347a9 ("x86/Hyper-V: Unload vmbus channel in hv
panic callback") in v5.7-rc2.
Fixed in v5.18-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
cip/4.19-st: [6b4c0149a56147b29169e07000d566162892722a]
mainline: [792f232d57ff28bbd5f9c4abe0466b23d5879dc8]
stable/4.19: [6b4c0149a56147b29169e07000d566162892722a]
stable/5.10: [cf580d2e3884dbafd6b90269b03a24d661578624]
stable/5.15: [dcd6b1a624c0ffa21034d8b1e02e9d068458f596]
stable/5.4: [2133c422a103cf7c7768c37b9ac382e73b691892]

CVE-2022-49099: Drivers: hv: vmbus: Fix initialization of device
object in vmbus_device_register()

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49099-35b8@gregkh/

Introduced by commit 743b237 ("scsi: storvsc: Add Isolation VM support
for storvsc driver") in v5.17-rc1.
Fixed in v5.18-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a5469582c241abca22500f36a9cb8e9331969cf]

CVE-2022-49100: virtio_console: eliminate anonymous module_init & module_exit

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49100-1357@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [0f3d824bd70a1303464d5e93ee3e7afe7832fe89]
cip/4.4-st: [59f6af8cccf0cf7b1df46c7ed05e62b8ff944bd3]
mainline: [fefb8a2a941338d871e2d83fbd65fbfa068857bd]
stable/4.19: [0f3d824bd70a1303464d5e93ee3e7afe7832fe89]
stable/5.10: [c69b442125bf009fce26e15aa5616caf8a3673c3]
stable/5.15: [44c2d5fbe7b2bd1f8cb114d608a591a73a5d4ae6]
stable/5.4: [3504b0a177208eda85bf472bbf7c9aa77d2b8343]

CVE-2022-49102: habanalabs: fix possible memory leak in MMU DR fini

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49102-fea1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by aa6df65 ("habanalabs: fix reset process in case of
failures") in 5.11-rc5.

Fixed status
mainline: [eb85eec858c1a5c11d3a0bff403f6440b05b40dc]
stable/5.15: [12e49aefda2e04b07604f13e03f40027cbeb0dc6]

CVE-2022-49103: NFSv4.2: fix reference count leaks in _nfs42_proc_copy_notify()

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49103-751e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 0491567b ("NFS: add COPY_NOTIFY operation") in 5.5-rc1.

Fixed status
mainline: [b7f114edd54326f730a754547e7cfb197b5bc132]
stable/5.10: [9b9feec97c1fc7dd9bb69f62c4905cddf1801599]
stable/5.15: [b37f482ba9f0e6382c188e3fccf6c4b2fdc938eb]

CVE-2022-49104: staging: vchiq_core: handle NULL result of
find_service_by_handle

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49104-818d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 77b3f6c ("staging: vchiq: Move message queue into struct
vchiq_service") in 5.9-rc1.

Fixed status
mainline: [ca225857faf237234d2fffe5d1919467dfadd822]
stable/5.10: [aa0b7296785312a4bfa8fac0ba8ad78698fd9fcf]
stable/5.15: [42f2142a337ee372455574809fc924580a7e51b2]

CVE-2022-49105: staging: wfx: fix an error handling in wfx_init_common()

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49105-b5ae@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 354d6ca ("staging: wfx: Get descriptors for GPIOs") in 5.9-rc1.

Fixed status
mainline: [60f1d3c92dc1ef1026e5b917a329a7fa947da036]
stable/5.10: [93498c6e775ae91732a8109dba1bdcd324908f84]
stable/5.15: [86efcb524ae1889ae73f2a2f0bb7fff2ec757ab0]

CVE-2022-49106: staging: vchiq_arm: Avoid NULL ptr deref in
vchiq_dump_platform_instances

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49106-7fa5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 71bad7f ("staging: add bcm2708 vchiq driver") in 4.9-rc1.

Fixed status
mainline: [aa899e686d442c63d50f4d369cc02dbbf0941cb0]
stable/5.15: [176df12b38c70b0a45e6392a0ee5bc83489dfc29]

CVE-2022-49107: ceph: fix memory leak in ceph_readdir when
note_last_dentry returns error

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49107-03bc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 2817b00 ("ceph: directory operations") in 2.6.34-rc2.

Fixed status
mainline: [f639d9867eea647005dc824e0e24f39ffc50d4e4]
stable/5.10: [f4429786129648a8f4bb1e5faa143c4478cc5c4a]
stable/5.15: [2fe82d3254029ef9ec4e7be890125d5ef4f537de]

CVE-2022-49108: clk: mediatek: Fix memory leaks on probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49108-328f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 710573de ("clk: mediatek: Add MT8192 basic clocks
support") in 5.15-rc1.

Fixed status
mainline: [7a688c91d3fd54c53e7a9edd6052cdae98dd99d8]

CVE-2022-49109: ceph: fix inode reference leakage in ceph_get_snapdir()

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49109-1b4f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 3e10a15ff ("ceph: fix inode reference leakage in
ceph_get_snapdir()") in 5.18-rc1.

Fixed status
mainline: [322794d3355c33adcc4feace0045d85a8e4ed813]
stable/5.15: [3ae7163598c611a8892698e0c056fe794e52b44b]

CVE-2022-49110: netfilter: conntrack: revisit gc autotuning

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49110-5519@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 4608fdf ("netfilter: conntrack: collect all entries in
one cycle") in 5.14-rc6.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [2cfadb761d3d0219412fd8150faea60c7e863833]
stable/5.15: [58d52743ae85d28c9335c6034d6ce350b8689951]

CVE-2022-49111: Bluetooth: Fix use after free in hci_send_acl

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49111-8795@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [684e505406abaeabe0058e9776f9210bf2747953]
cip/4.4-st: [29f38e8aaf032941a1d81795cf391bbdd7003a81]
mainline: [f63d24baff787e13b723d86fe036f84bdbc35045]
stable/4.19: [684e505406abaeabe0058e9776f9210bf2747953]
stable/5.10: [2cc803804ec9a296b3156855d6c8c4ca1c6b84be]
stable/5.15: [d404765dffdbd8dcd14758695d0c96c52fb2e624]
stable/5.4: [3803d896ddd97c7c16689a5381c0960040727647]

CVE-2022-49112: mt76: fix monitor mode crash with sdio driver

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49112-3f57@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by d089692 ("mt76: move token utilities in mt76 common
module") in 5.13-rc1.

Fixed status
mainline: [123bc712b1de0805f9d683687e17b1ec2aba0b68]
stable/5.15: [13946d5a68efd11dd6af2f6ef4c908f6b00158a5]

CVE-2022-49113: powerpc/secvar: fix refcount leak in format_show()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49113-5c20@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [d601fd24e6964967f115f036a840f4f28488f63f]
stable/5.10: [02222bf4f0a27f6eba66d1f597cdb5daadd51829]
stable/5.15: [2a71e3ecd829a82013cf095c55068c61d991e885]

CVE-2022-49114: scsi: libfc: Fix use after free in fc_exch_abts_resp()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49114-86bb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [6044ad64f41c87382cfeeca281573d1886d80cbe]
cip/4.4-st: [cedcfca92976c8ed7219886175efa7d5dc1b8813]
mainline: [271add11994ba1a334859069367e04d2be2ebdd4]
stable/4.19: [6044ad64f41c87382cfeeca281573d1886d80cbe]
stable/5.10: [1d7effe5fff9d28e45e18ac3a564067c7ddfe898]
stable/5.15: [f581df412bc45c95176e3c808ee2839c05b2ab0c]
stable/5.4: [5cf2ce8967b0d98c8cfa4dc42ef4fcf080f5c836]

CVE-2022-49115: PCI: endpoint: Fix misused goto label

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49115-44c9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 5ebf3fc ("PCI: endpoint: functions/pci-epf-test: Add DMA
support to transfer data")
in 5.7-rc1.

Fixed status
mainline: [bf8d87c076f55b8b4dfdb6bc6c6b6dc0c2ccb487]
stable/5.10: [7c657c0694ff690e361a13ce41c36b9dfb433ec8]
stable/5.15: [dc9d33b2d8d09e6478e8ef817a81cf26930acc3e]

CVE-2022-49116: Bluetooth: use memset avoid memory leaks

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49116-8bf8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by da49b602 ("Bluetooth: L2CAP: Use DEFER_SETUP to group
ECRED connections")
in 5.7-rc1.

Fixed status
mainline: [d3715b2333e9a21692ba16ef8645eda584a9515d]
stable/5.10: [9567d54e70ff58c2695c2cc2e53c86c67551d3e6]
stable/5.15: [42b6a39f439b6f37cc2024d91ce547d83290ff78]

CVE-2022-49117: mips: ralink: fix a refcount leak in ill_acc_of_setup()

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49117-6f1f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 5433acd ("MIPS: ralink: add illegal access driver") in 3.19-rc1.

Fixed status
mainline: [4a0a1436053b17e50b7c88858fb0824326641793]
stable/5.10: [142ae7d4f21524acfe073e5a3da5667aa85eb970]
stable/5.15: [5fb47ca3490813d3884d8ad0b2ce511aa3537551]
stable/5.4: [060a485df4ec1183d543317511cb4caa43468b5d]

CVE-2022-49118: scsi: hisi_sas: Free irq vectors in order for v3 HW

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49118-e2fa@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected file was added by 92f61e3 (scsi: hisi_sas: add skeleton v3 hw driver")
in 4.13-rc1.

Fixed status
mainline: [554fb72ee34f4732c7f694f56c3c6e67790352a0]
stable/5.10: [224903cc60d045576393c3b16907742f23e6c740]
stable/5.15: [f05a0d8de2ea49af36821a20b0b501e20ced937e]

CVE-2022-49119: scsi: pm8001: Fix memory leak in
pm8001_chip_fw_flash_update_req()

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49119-b6a8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 4c8f04b ("scsi: pm8001: Fix tag leaks on error") in 5.18-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [f792a3629f4c4aa4c3703d66b43ce1edcc3ec09a]
stable/5.10: [d83574666bac4b1462e90df393fbed6c5f57d1a3]
stable/5.15: [e5ecdb01952f230921aa8163d8d7f4c97c925ed8]

CVE-2022-49120: scsi: pm8001: Fix task leak in pm8001_send_abort_all()

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49120-5357@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
This commit fixes c6b9ef5 ("[SCSI] pm80xx: NCQ error handling
changes") in 3.10-rc1
and 5533abc ("pm8001: honor return value") in 3.17-rc1.

Fixed status
mainline: [f90a74892f3acf0cdec5844e90fc8686ca13e7d7]
stable/5.10: [2051044d7901f1a9d7be95d0d32e53b88e9548f7]
stable/5.15: [2290dcad6f65864dec518fb2d5fb45f67d684150]

CVE-2022-49121: scsi: pm8001: Fix tag leaks on error

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49121-9a82@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [4c8f04b1905cd4b776d0b720463c091545478ef7]
stable/5.10: [a0bb65eadbf942024226241d9d99fed17168940b]
stable/5.15: [43c617eefab7077d69f5989ad3e2a273da1d728b]

CVE-2022-49122: dm ioctl: prevent potential spectre v1 gadget

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49122-b139@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [7ae2c5b89da3cfaf856df880af27d3bb32a74b3d]
cip/4.4-st: [6eb63a9c14025b761e40e6c4bdd5b881cb621dbc]
mainline: [cd9c88da171a62c4b0f1c70e50c75845969fbc18]
stable/4.19: [7ae2c5b89da3cfaf856df880af27d3bb32a74b3d]
stable/5.10: [71c8df33fd777c7628f6fbc09b14e84806c55914]
stable/5.15: [02cc46f397eb3691c56affbd5073e54f7a82ac32]
stable/5.4: [0320bac5801b31407200227173205d017488f140]

CVE-2022-49123: ath11k: Fix frames flush failure caused by deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49123-8a84@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
It seems as if this bug was introduced by commit d5c6515 ("ath11k:
driver for Qualcomm IEEE 802.11ax devices") in 5.6-rc1.

Fixed status
mainline: [261b07519518bd14cb168b287b17e1d195f8d0c8]

CVE-2022-49124: x86/mce: Work around an erratum on fast string copy instructions

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49124-b593@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [8ca97812c3c830573f965a07bbd84223e8c5f5bd]

CVE-2022-49125: drm/sprd: fix potential NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49125-5909@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 43531ed ("drm/sprd: add Unisoc's drm kms master") in 5.17-rc1.

Fixed status
mainline: [8668658aebb0a19d877d5a81c004baf716c4aaa6]

CVE-2022-49126: scsi: mpi3mr: Fix memory leaks

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49126-02a6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by c9566231 ("scsi: mpi3mr: Create operational request and
reply queue pair")
in 5.14-rc1.

Fixed status
mainline: [d44b5fefb22e139408ae12b864da1ecb9ad9d1d2]
stable/5.15: [5d76a88b8536d75ff5362e232097e85946b8aadf]

CVE-2022-49127: ref_tracker: implement use-after-free detection

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49127-15e6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected files were introduced by 4e66934 ("lib: add reference
counting tracking infrastructure")
in 5.17-rc1.

Fixed status
mainline: [e3ececfe668facd87d920b608349a32607060e66]

CVE-2022-49128: drm/bridge: Add missing pm_runtime_put_sync

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49128-8459@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected file was added by 44cfc62334 ("drm/bridge: Add NWL MIPI DSI host
controller support") in 5.8-rc1.

Fixed status
mainline: [46f47807738441e354873546dde0b000106c068a]
stable/5.15: [ff13c90d7f7ab606b37be6d15140d19013d6736c]

CVE-2022-49129: mt76: mt7921: fix crash when startup fails.

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49129-a098@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected function was introduced by e0f9fdd ("mt76: mt7921: add
ieee80211_ops") in 5.12-rc1-dontuse.

Fixed status
mainline: [827e7799c61b978fbc2cc9dac66cb62401b2b3f0]
stable/5.15: [38fbe806645090c07aa97171f20fc62c3d7d3a98]

CVE-2022-49130: ath11k: mhi: use mhi_sync_power_up()

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49130-8e95@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by commit 1399fb ("ath11k: register MHI controller device
for QCA6390") in 5.10-rc1.

Fixed status
mainline: [3df6d74aedfdca919cca475d15dfdbc8b05c9e5d]
stable/5.10: [339bd0b55ecdd0f7f341e9357c4cfde799de9418]
stable/5.15: [20d01a11efde2e05e47d5c66101f5c26eaca68e2]

CVE-2022-49131: ath11k: fix kernel panic during unload/load ath11k modules

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49131-584c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by d5c6515 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
in 5.6-rc1.

Fixed status
mainline: [22b59cb965f79ee1accf83172441c9ca0ecb632a]
stable/5.10: [c6a815f5abdf324108799829dd19ea62fef4bf95]
stable/5.15: [c4b7653af62a9a5efe2856183d1f987c5429758b]

CVE-2022-49132: ath11k: pci: fix crash on suspend if board file is not found

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49132-e49f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected functions were introduced by d1b0c33 ("ath11k: implement
suspend for QCA6390 PCI devices")
in 5.11-rc1.

Fixed status
mainline: [b4f4c56459a5c744f7f066b9fc2b54ea995030c5]
stable/5.15: [fed4cef115ab21a18faf499b3fa9b9a4b544f941]

CVE-2022-49133: drm/amdkfd: svm range restore work deadlock when process exit

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49133-d5c9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [6225bb3a88d22594aacea2485dc28ca12d596721]

CVE-2022-49134: mlxsw: spectrum: Guard against invalid local ports

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49134-f6cf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [bcdfd615f83b4bd04678109bf18022d1476e4bbf]

CVE-2022-49135: drm/amd/display: Fix memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49135-adff@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected file was added by dc38fd9 ("drm/amd/display: Add front end
for dp debugfs
files") in 4.19-rc1.

Fixed status
mainline: [5d5c6dba2b43e28845d7d7ed32a36802329a5f52]
stable/5.15: [7e10369c72db7a0e2f77b2e306aadc07aef6b07a]

CVE-2022-49136: Bluetooth: hci_sync: Fix queuing commands when
HCI_UNREGISTER is set

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49136-033c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected function was added by 6a98e38 ("Bluetooth: Add helper for serialized i
HCI command execution") in 5.17-rc1.

Fixed status
mainline: [0b94f2651f56b9e4aa5f012b0d7eb57308c773cf]

CVE-2022-49137: drm/amd/amdgpu/amdgpu_cs: fix refcount leak of a dma_fence obj

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49137-92fc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected function was added by 7ca24cf ("drm/amdgpu: add FENCE_TO_HANDLE ioctl
that returns syncobj or sync_file") in 4.15-rc1.

Fixed status
cip/4.19-st: [72d77ddb2224ebc00648f4f78f8a9a259dccbdf7]
mainline: [dfced44f122c500004a48ecc8db516bb6a295a1b]
stable/4.19: [72d77ddb2224ebc00648f4f78f8a9a259dccbdf7]
stable/5.10: [927beb05aaa429c883cc0ec6adc48964b187e291]
stable/5.15: [3edd8646cb7c11b57c90e026bda6f21076223f5b]
stable/5.4: [4009f104b02b223d1a11d74b36b1cc083bc37028]

CVE-2022-49138: Bluetooth: hci_event: Ignore multiple conn complete events

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49138-a241@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [d5ebaa7c5f6f688959e8d40840b2249ede63b8ed]

CVE-2022-49139: Bluetooth: fix null ptr deref on hci_sync_conn_complete_evt

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49139-66ce@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [3afee2118132e93e5f6fa636dfde86201a860ab3]
stable/5.10: [0f9db1209f59844839175b5b907d3778cafde93d]
stable/5.15: [c1aa0dd52db4ce888be0bd820c3fa918d350ca0b]
stable/5.4: [1c1291a84e94f6501644634c97544bb8291e9a1a]

CVE-2022-49140: Revert "nbd: fix possible overflow on 'first_minor' in
nbd_dev_add()"

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49140-974f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
This fix reverts 6d35d04a in 5.18-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [7198bfc2017644c6b92d2ecef9b8b8e0363bb5fd]
stable/5.15: [3b14aa053181709d42319d4145855025c23ddd12]

CVE-2022-49141: net: dsa: felix: fix possible NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49141-eb9c@gregkh/

Introduced by commit 23ae3a7 ("net: dsa: felix: add stream gate
settings for psfp"). in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [866b7a278cdb51eb158cd8513bc7438fc857804a]

CVE-2022-49142: net: preserve skb_end_offset() in skb_unclone_keeptruesize()

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49142-b3b9@gregkh/

Introduced by commit c4777ef ("net: add and use
skb_unclone_keeptruesize() helper") in v5.16-rc1.
Introduced by commit 097b914 ("net: fix up truesize of cloned skb in
skb_prepare_for_shift()") in v5.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [2b88cba55883eaafbc9b7cbff0b2c7cdba71ed01]
stable/5.15: [23629b673b780d967b88a850b1518cf0f0ffc6aa]

CVE-2022-49144: io_uring: fix memory leak of uid in files registration

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49144-0d56@gregkh/

Introduced by commit 08a4517 ("io_uring: allow sparse fixed file
sets") in v5.5-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c86d18f4aa93e0e66cda0e55827cd03eea6bc5f8]
stable/5.10: [b27de7011cb3ba14b047be2cee0ed8278368665b]
stable/5.15: [0853bd6885c2f293d88aaa7f7f1702c959b31680]

CVE-2022-49145: ACPI: CPPC: Avoid out of bounds access when parsing _CPC data

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49145-3c50@gregkh/

Introduced by commit 337aadf ("ACPI: Introduce CPU performance
controls using CPPC") in v4.4-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [28d5387c1994f5e1e0d41b30a1f3dd6e1f609252]
cip/4.4-st: [1d374915f21f450373ec0e67ea6c8d04dfb40bc6]
mainline: [40d8abf364bcab23bc715a9221a3c8623956257b]
stable/4.19: [28d5387c1994f5e1e0d41b30a1f3dd6e1f609252]
stable/5.10: [e5b681822cac1f8093759b02e16c06b2c64b6788]
stable/5.15: [97b5593fd1b182b3fdb180b6bbe64ec09669988b]
stable/5.4: [cb249f8c00f40dba83b7da8207ac14ca46e9ec9e]

CVE-2022-49146: virtio: use virtio_device_ready() in virtio_device_restore()

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49146-60f4@gregkh/

Introduced by commit d50497e ("virtio_config: introduce a new
.enable_cbs method") in v5.16-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d65bc9a5be3f23c5e2ab36b6b8ef40095165b18]

CVE-2022-49147: block: Fix the maximum minor value is blk_alloc_ext_minor()

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49147-7f2f@gregkh/

Introduced by commit 22ae8ce ("block: simplify bdev/disk lookup in
blkdev_get") in v5.11-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1868328dec5ae2cf210111025fcbc71f78dd5ca]
stable/5.15: [5b9ac3727e4abb11c9cfbe9c0781fc05dfdd7cfb]

CVE-2022-49148: watch_queue: Free the page array when watch_queue is dismantled

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49148-88d2@gregkh/

Introduced by commit c73be61 ("pipe: Add general notification queue
support") in v5.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b490207017ba237d97b735b2aa66dc241ccd18f5]
stable/5.10: [7169f60110915c8b53bffd43741fa020a75eb87a]
stable/5.15: [4913daecd04addb41bc96a9175a885e1c19862a8]

CVE-2022-49149: rxrpc: Fix call timer start racing with call destruction

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49149-a2ed@gregkh/

Introduced by commit a158bdd ("rxrpc: Fix call timeouts") in v4.15-rc2.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a7f62f91933c8ae5308f9127fd8ea48188b6bc3]
stable/5.10: [051360e51341cd17738d82c15a8226010c7cb7f6]
stable/5.15: [8cbf4ae7a2833767d63114573e5f9a45740cc975]

CVE-2022-49150: rtc: gamecube: Fix refcount leak in
gamecube_rtc_read_offset_from_sram

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49150-57a2@gregkh/

Introduced by commit 8655940 ("rtc: gamecube: Add a RTC driver for the
GameCube, Wii and Wii U") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b2dc39ca024990abe36ad5d145c4fe0c06afd34]

CVE-2022-49151: can: mcba_usb: properly check endpoint type

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49151-5b76@gregkh/

Introduced by commit 51f3baa ("can: mcba_usb: Add support for
Microchip CAN BUS Analyzer") in v4.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b48d1bb3f1ca337ad653022aefb5a40a47dfe5cd]
mainline: [136bed0bfd3bc9c95c88aafff2d22ecb3a919f23]
stable/4.19: [b48d1bb3f1ca337ad653022aefb5a40a47dfe5cd]
stable/5.10: [ef0acc514123140157b19a9ff2e2de5d91d612bc]
stable/5.15: [fa9c1f14002dc0d5293e16a2007bd89b6e79207b]
stable/5.4: [cbd110b8dd7ad763bf413f71c0484116ae9302d4]

CVE-2022-49152: XArray: Fix xas_create_range() when multi-order entry present

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49152-7f28@gregkh/

Introduced by commit 6b24ca4 ("mm: Use multi-index entries in the page
cache") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e3c658055c002900982513e289398a1aad4a488]
stable/5.10: [1ac49c8fd49fdf53d3cd8b77eb8ffda08d7fbe22]
stable/5.15: [7521a97b1929042604bef6859f62fa8b4bbc077b]
stable/5.4: [3e2852eda19ee1a400cd809d7a9322680f34a262]

CVE-2022-49153: wireguard: socket: free skb in send6 when ipv6 is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49153-972a@gregkh/

Introduced by commit e7096c1 ("net: WireGuard secure network tunnel")
in v5.6-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbbf962d9460194993ee1943a793a0a0af4a7fbf]
stable/5.10: [096f9d35cac0a0c95ffafc00db84786b665a4837]
stable/5.15: [402991a9771587acc2947cf6c4d689c5397f2258]

CVE-2022-49154: KVM: SVM: fix panic on out-of-bounds guest IRQ

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49154-5fd5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [a80ced6ea514000d34bf1239d47553de0d1ee89e]
stable/5.10: [0fb470eb48892e131d10aa3be6915239e65758f3]
stable/5.15: [3fa2d747960521a646fc1aad7aea82e95e139a68]

CVE-2022-49155: scsi: qla2xxx: Suppress a kernel complaint in qla_create_qpair()

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49155-f1d2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by e326d22a ("scsi: qla2xxx: Enable Target Multi Queue") in 4.13-rc1.

Fixed status
cip/4.19-st: [f68776f28d9134fa65056e7e63bfc734049730b7]
mainline: [a60447e7d451df42c7bde43af53b34f10f34f469]
stable/4.19: [f68776f28d9134fa65056e7e63bfc734049730b7]
stable/5.10: [f97316dd393bc8df1cc2af6295a97b876eecf252]
stable/5.15: [9c33d49ab9f3d8bd7512b3070cd2f07c4a8849d5]
stable/5.4: [8077a7162bc3cf658dd9ff112bc77716c08458c5]

CVE-2022-49156: scsi: qla2xxx: Fix scheduling while atomic

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49156-a5c9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [afd438ff874ca40b74321b3fa19bd61adfd7ca0c]
stable/5.10: [7fef50214dd04427233a2e66cd624d468e67aecb]
stable/5.15: [826a9d4a00d1424afa961504aec6298ee92d5053]

CVE-2022-49157: scsi: qla2xxx: Fix premature hw access after PCI error

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49157-59a1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [e35920ab7874d5e2faeb4f958a74bfa793f1ce5a]
stable/5.15: [5ef6319f9882699613d5182fbd7929b017e8c5ab]

CVE-2022-49158: scsi: qla2xxx: Fix warning message due to adisc being flushed

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49158-64aa@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [64f24af75b79cba3b86b0760e27e0fa904db570f]
stable/5.15: [7a3457777c4f700c64836e78dc71e6ce459f62b8]

CVE-2022-49159: scsi: qla2xxx: Implement ref count for SRB

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49159-58f3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [31e6cdbe0eae37badceb5e0d4f06cf051432fd77]
stable/5.15: [e17111dd2fda81c35f309b1e5b6ab35809a375e7]

CVE-2022-49160: scsi: qla2xxx: Fix crash during module load unload test

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49160-0990@gregkh/

Introduced by commit 62e9dd1 ("scsi: qla2xxx: Change in PUREX to
handle FPIN ELS requests") in v5.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0972252450f90db56dd5415a20e2aec21a08d036]
stable/5.15: [9b7eb92dac240ab3bc83e188d83a3df834b41eb2]

CVE-2022-49161: ASoC: mediatek: Fix error handling in
mt8183_da7219_max98357_dev_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49161-ff61@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected file was added by ebbddc7 ("ASoC: Mediatek: MT8183: Add machine
driver with DA7219") in 5.2-rc1.

Fixed status
mainline: [28a265a1ee11febeec5ea73a804f30dcec3181ca]

CVE-2022-49162: video: fbdev: sm712fb: Fix crash in smtcfb_write()

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49162-654f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [1aea36a62f0a0ad67eccc945bac0bd6422ef720f]
cip/4.4-st: [13ad237810e82eee8b4e6572cc4766aa39f51885]
mainline: [4f01d09b2bbfbcb47b3eb305560a7f4857a32260]
stable/4.19: [1aea36a62f0a0ad67eccc945bac0bd6422ef720f]
stable/5.10: [b1c28577529cdfad40c8242673285f1e1e4c314e]
stable/5.15: [eae90015d10f0c9a47fc4adccba4cd79dce664e4]
stable/5.4: [3b36c05f68ba32d0dfb63abc9016d6fe9117829f]

CVE-2022-49163: media: imx-jpeg: fix a bug of accessing array out of bounds

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49163-f5bc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 2db16c6e ("media: imx-jpeg: Add V4L2 driver for i.MX8
JPEG Encoder/Decoder")
in 5.13-rc1.

Fixed status
mainline: [97558d170a1236280407e8d29a7d095d2c2ed554]
stable/5.15: [02f9f97d54ffc85b50ad77f5b1f3c8f69cd17747]

CVE-2022-49164: powerpc/tm: Fix more userspace r13 corruption

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49164-12d7@gregkh/

Introduced by commit 98ae22e ("powerpc: Add helper functions for
transactional memory context switching") in v3.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d71165d3934e607070c4e48458c0cf161b1baea]
stable/5.15: [5dce84f475d13b773a1a4c823581cab25044d86a]

CVE-2022-49165: media: imx-jpeg: Prevent decoding NV12M jpegs into
single-planar buffers

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49165-6b4c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 2db16c6e ("media: imx-jpeg: Add V4L2 driver for i.MX8
JPEG Encoder/Decoder")
in 5.13-rc1.

Fixed status
mainline: [417591a766b3c040c346044541ff949c0b2bb7b2]
stable/5.15: [eff76b180751e5e55c872d17755680c3b83ba9ab]

CVE-2022-49166: ntfs: add sanity check on allocation size

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49166-7308@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [07793d2e55563124108762f4e5f811db92ffe02f]
cip/4.4-st: [b98e460a8bd9468a6e0b27b1700b3a114b9f4158]
mainline: [714fbf2647b1a33d914edd695d4da92029c7e7c0]
stable/4.19: [07793d2e55563124108762f4e5f811db92ffe02f]
stable/5.10: [b230f2d9441a34c7f483d39ab78519bcf73cc2e0]
stable/5.15: [24ab2d4ef52c2dbb62a60844b87fc8872383407a]
stable/5.4: [fe41ad8be036a3de3e4bdde709551aeb4de2fe7d]

CVE-2022-49167: btrfs: do not double complete bio on errors during
compressed reads

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49167-d747@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [f9f15de85d74e7eef021af059ca53a15f041cdd8]

CVE-2022-49168: btrfs: do not clean up repair bio if submit fails

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49168-d59d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [8cbc3001a3264d998d6b6db3e23f935c158abd4d]

CVE-2022-49169: f2fs: use spin_lock to avoid hang

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49169-10ae@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 66af62c ("f2fs: add global mutex_lock to protect
f2fs_stat_list") in 3.8-rc5.

Fixed status
mainline: [98237fcda4a24e67b0a4498c17d5aa4ad4537bc7]
stable/5.15: [2eff60346e7ae1a24cd868b8fdcf58e946e7dde1]

CVE-2022-49170: f2fs: fix to do sanity check on curseg->alloc_type

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49170-b183@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected function was added by c854f4d68 ("f2fs: fix to do sanity check on
segment bitmap of LFS curseg") in 5.3-rc1.

Fixed status
mainline: [f41ee8b91c00770d718be2ff4852a80017ae9ab3]
stable/5.10: [498b7088db71f9707359448cd6800bbb1882f4c3]
stable/5.15: [f68caedf264a95c0b02dfd0d9f92ac2637d5848a]

CVE-2022-49171: ext4: don't BUG if someone dirty pages without asking ext4 first

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49171-83e6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [0d3a6926f7e8be3c897fa46216ce13b119a9f56a]
cip/4.4-st: [c3c3877d44ee9f76cd4f287bb8f360d4fe3b0d71]
mainline: [cc5095747edfb054ca2068d01af20be3fcc3634f]
stable/4.19: [0d3a6926f7e8be3c897fa46216ce13b119a9f56a]
stable/5.10: [330d0e44fc5a47c27df958ecdd4693a3cb1d8b81]
stable/5.15: [a0856764dc1276ad2dc7891288c2e9246bf11a37]
stable/5.4: [5a016c053f426a73752c3b41b60b497b58694d48]

CVE-2022-49172: parisc: Fix non-access data TLB cache flush faults

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49172-3fe3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [f839e5f1cef36ce268950c387129b1bfefdaebc9]

CVE-2022-49173: spi: fsi: Implement a timeout for polling status

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49173-4844@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected file was introduced by bbb6b2f ("spi: Add FSI-attached SPI controller
driver") in 5.7-rc1.

Fixed status
mainline: [89b35e3f28514087d3f1e28e8f5634fbfd07c554]

CVE-2022-49174: ext4: fix ext4_mb_mark_bb() with flex_bg with fast_commit

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49174-b971@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [bfdc502a4a4c058bf4cbb1df0c297761d528f54d]
stable/5.10: [cd6d719534af993210306f8a13f9cb3e615f7c8d]
stable/5.15: [6a6beb074186a0452368a023a261c7d0eaebe838]

CVE-2022-49175: PM: core: keep irq flags in device_pm_check_callbacks()

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49175-1b88@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by aa8e54b ("PM / sleep: Go direct_complete if driver has
no callbacks") in 4.5-rc1.

Fixed status
cip/4.19-st: [be8bc05f38d667eda1e820bc6f69234795be7809]
mainline: [524bb1da785a7ae43dd413cd392b5071c6c367f8]
stable/4.19: [be8bc05f38d667eda1e820bc6f69234795be7809]
stable/5.10: [ede1ef1a7de973321699736ef96d01a4b9a6fe9e]
stable/5.15: [c29642ba72f87c0a3d7449f7db5d6d76a7ed53c3]
stable/5.4: [0cccf9d4fb45f1acbc0bbf6d7e4d8d0fb7a10416]

CVE-2022-49176: bfq: fix use-after-free in bfq_dispatch_request

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49176-fd92@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected function was introduced by 9b25bd0 ("block, bfq: remove batches of
confusing ifdefs") in 4.16-rc1.

Fixed status
cip/4.19-st: [74e610b5ee0d95e751280567100509eb11517efa]
mainline: [ab552fcb17cc9e4afe0e4ac4df95fc7b30e8490a]
stable/4.19: [74e610b5ee0d95e751280567100509eb11517efa]
stable/5.10: [df6e00b1a53c57dca82c63b5ecbcad5452231bc7]
stable/5.15: [080665e2c3cbfc68359b9a348a3546ed9b908e7a]
stable/5.4: [5117c9ff4c2ebae0f5c2c262d42a25a8fbc086e6]

CVE-2022-49177: hwrng: cavium - fix NULL but dereferenced coccicheck error

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49177-f751@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 680efb3 ("hwrng: cavium - Check health status while reading
random data") in 5.17-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [e6205ad58a7ac194abfb33897585b38687d797fa]

CVE-2022-49178: memstick/mspro_block: fix handling of read-only devices

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49178-b663@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [6dab421bfe06a59bf8f212a72e34673e8acf2018]

CVE-2022-49179: block, bfq: don't move oom_bfqq

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49179-9857@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [8410f70977734f21b8ed45c37e925d311dfda2e7]
stable/5.10: [7507ead1e9d42957c2340f2c4a0e9d00034e3366]
stable/5.15: [8f34dea99cd7761156a146a5258a67d045d862f7]
stable/5.4: [c4f5a678add58a8a0e7ee5e038496b376ea6d205]

CVE-2022-49180: LSM: general protection fault in legacy_parse_param

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49180-ac1e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [ecff30575b5ad0eda149aadad247b7f75411fd47]
stable/5.10: [2784604c8c6fc523248f8f80a421c313a9d790b7]
stable/5.15: [f3f93a1aaafc3032e0a9655fb43deccfb3e953a3]
stable/5.4: [ddcdda888e14ca451b3ee83d11b65b2a9c8e783b]

CVE-2022-49182: net: hns3: add vlan list lock to protect vlan list

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49182-f154@gregkh/

Introduced by commit c6075b1 ("net: hns3: Record VF vlan tables") in v5.1-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1932a624ab88ff407d1a1d567fe581faa15dc725]
stable/5.15: [30f0ff7176efe8ac6c55f85bce26ed58bb608758]

CVE-2022-49183: net/sched: act_ct: fix ref leak when switching zones

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49183-1962@gregkh/

Introduced by commit 2f131de ("net/sched: act_ct: Fix flow table
lookup after ct clear or switching zones") in v5.17-rc6.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [bcb74e132a76ce0502bb33d5b65533a4ed72d159]
stable/5.15: [bcbf4e5c3b5b373cd61528392dd1ec8e9c0fd33d]

CVE-2022-49184: net: sparx5: switchdev: fix possible NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49184-4de2@gregkh/

Introduced by commit 1061590 ("net: sparx5: switchdev: adding frame
DMA functionality") in v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0906f3a3df07835e37077d8971aac65347f2ed57]
stable/5.15: [b375ea083fa649092cd016ac1f89a2d1fd8f8e8b]

CVE-2022-49185: pinctrl: nomadik: Add missing of_node_put() in nmk_pinctrl_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49185-119e@gregkh/

Introduced by commit 32e67ee ("pinctrl: nomadik: Allow prcm_base to be
extracted from Device Tree") in v3.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0067ba448f1c29ca06e5aee00d8506889ed1f9d0]
cip/4.4-st: [d44d9d4946351c8486156c25b117e06a91dbf6b9]
mainline: [c09ac191b1f97cfa06f394dbfd7a5db07986cefc]
stable/4.19: [0067ba448f1c29ca06e5aee00d8506889ed1f9d0]
stable/5.10: [669b05ff43bd7ed684379c6e2006a6dad5127b71]
stable/5.15: [c52703355766c347f270df222a744e0c491a02f2]
stable/5.4: [bc1e29a35147c1ba6ea2b06a16cb0028f7c852d2]

CVE-2022-49186: clk: visconti: prevent array overflow in
visconti_clk_register_gates()

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49186-4d69@gregkh/

Introduced by commit b4cbe60 ("clk: visconti: Add support common clock
driver and reset driver") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5601e0720ce1a3ad895f94a5838530edde01ed3]

CVE-2022-49187: clk: Fix clk_hw_get_clk() when dev is NULL

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49187-e8b4@gregkh/

Introduced by commit 30d6f8c ("clk: add api to get clk consumer from
clk_hw") in v5.11-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c1b56df451716ba207bbf59f303473643eee4fd]
stable/5.15: [4be3e4c05d8dd1b83b75652cad88c9e752ec7054]

CVE-2022-49188: remoteproc: qcom_q6v5_mss: Fix some leaks in
q6v5_alloc_memory_region

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49188-2a10@gregkh/

Introduced by commit 278d744 ("remoteproc: qcom: Fix potential device
node leaks") in v4.17-rc4.
Introduced by commit 051fb70 ("remoteproc: qcom: Driver for the
self-authenticating Hexagon v5") in v4.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07a5dcc4bed9d7cae54adf5aa10ff9f037a3204b]
stable/5.10: [f7210ca29a783c94478da02368731e4c9cf7cdb7]
stable/5.15: [bd4771ba2cf9e18473a42b5b70175e50d67a64bb]

CVE-2022-49189: clk: qcom: clk-rcg2: Update logic to calculate D value for RCG

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49189-b7be@gregkh/

Introduced by commit 99cbd06 ("clk: qcom: Support display RCG clocks")
in v3.16-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58922910add18583d5273c2edcdb9fd7bf4eca02]
stable/5.10: [334720f418f57b1d969dad2117b21f9388cb9395]
stable/5.15: [34dca60982e93e69ae442aa2d36ce61c9a3bb563]
stable/5.4: [52592f9afbfe01bce8f8953e4f19cbe3bcbdbd3a]

CVE-2022-49190: kernel/resource: fix kfree() of bootmem memory again

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49190-3c68@gregkh/

Introduced by commit ebff7d8 ("mem hotunplug: fix kfree() of bootmem
memory") in v3.10-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cbcc92917c5de80f15c24d033566539ad696892]
stable/5.15: [a9e88c2618d228d7a4e7e515cf30dc0d0d813f27]

CVE-2022-49191: mxser: fix xmit_buf leak in activate when LSR == 0xff

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49191-ed02@gregkh/

Introduced by commit 6769140 ("tty: mxser: use the tty_port_open
method") in v2.6.33-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [685b6d16bf89595310b5d61394c9b97cc9505c7c]
cip/4.4-st: [6accf66cda46b5fd35c20dc1db0c5444aae569db]
mainline: [cd3a4907ee334b40d7aa880c7ab310b154fd5cd4]
stable/4.19: [685b6d16bf89595310b5d61394c9b97cc9505c7c]
stable/5.10: [2cd05c38a27bee7fb42aa4d43174d68ac55dac0f]
stable/5.15: [b125b08dbee3611f03f53b71471813ed4ccafcdd]
stable/5.4: [996291d06851a26678a0fab488b6e1f0677c0576]

CVE-2022-49192: drivers: ethernet: cpsw: fix panic when interrupt
coaleceing is set via ethtool

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49192-b1e7@gregkh/

Introduced by commit d43c65b ("ethtool: runtime-resume netdev parent
in ethnl_ops_begin") in v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2844e2434385819f674d1fb4130c308c50ba681e]
stable/5.15: [585dc196a08fccdcd1b7fcf473cf566b34c4b840]

CVE-2022-49193: ice: fix 'scheduling while atomic' on aux critical err interrupt

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49193-b8b8@gregkh/

Introduced by commit 348048e ("ice: Implement iidc operations") in v5.14-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32d53c0aa3a7b727243473949bad2a830b908edc]
stable/5.15: [9b77c8cf69a41d1e3851370aeaa04a9ea83b865c]

CVE-2022-49194: net: bcmgenet: Use stronger register read/writes to
assure ordering

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49194-fc80@gregkh/

Introduced by commit 69d2ea9 ("net: bcmgenet: Use correct I/O
accessors") in v4.14-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d3ea3d402db94b61075617e71b67459a714a502]
stable/5.10: [b26091a02093104259ca64aeca73601e56160d62]
stable/5.15: [06d836801cd82ded282aaf9e888ff9e7e4a88b91]

CVE-2022-49195: net: dsa: fix panic on shutdown if multi-chip tree
failed to probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49195-740b@gregkh/

Introduced by commit 0650bf5 ("net: dsa: be compatible with masters
which unregister on shutdown") in v5.15-rc3.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fd36358ce82382519b50b05f437493e1e00c4a9]
stable/5.15: [95df5cd5a446df6738d2d45872e08594819080e4]

CVE-2022-49196: powerpc/pseries: Fix use after free in remove_phb_dynamic()

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49196-978c@gregkh/

Introduced by commit 2dd9c11 ("powerpc/pseries: use
pci_host_bridge.release_fn() to kfree(phb)") in v4.8-rc5.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe2640bd7a62f1f7c3f55fbda31084085075bc30]
stable/5.15: [33d39efb61a84e055ca2386157d39ebbdf6b7d31]

CVE-2022-49197: af_netlink: Fix shift out of bounds in group mask calculation

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49197-494d@gregkh/

Introduced by commit f7fa9b1 ("[NETLINK]: Support dynamic number of
multicast groups per netlink family") in v2.6.20.16.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f75f4abeec4c04b600a15b50c89a481f1e7435ee]
cip/4.4-st: [8fe9d21fec39715ea5c38ce1169d3d43e3dbec45]
mainline: [0caf6d9922192dd1afa8dc2131abfb4df1443b9f]
stable/4.19: [f75f4abeec4c04b600a15b50c89a481f1e7435ee]
stable/5.10: [b0898362188e05b2202656058cc32d98fabf3bac]
stable/5.15: [7409ff6393a67ff9838d0ae1bd102fb5f020d07a]
stable/5.4: [41249fff507387c3323b198d0052faed08b14de4]

CVE-2022-49198: mptcp: Fix crash due to tcp_tsorted_anchor was
initialized before release skb

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49198-98a2@gregkh/

Introduced by commit f70cad1 ("mptcp: stop relying on
tcp_tx_skb_cache") in v5.16-rc1.
Fixed in v5.17.2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [4d54181eba4b077fb74033a7186898ad4000a7a5]

CVE-2022-49199: RDMA/nldev: Prevent underflow in
nldev_stat_set_counter_dynamic_doit()

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49199-54e5@gregkh/

Introduced by commit 3c3c1f1 ("RDMA/nldev: Allow optional-counter
status configuration through RDMA netlink") in v5.16-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87e0eacb176f9500c2063d140c0a1d7fa51ab8a5]

CVE-2022-49200: Bluetooth: btmtksdio: Fix kernel oops in btmtksdio_interrupt

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49200-54e9@gregkh/

Introduced by commit 9aebfd4 ("Bluetooth: mediatek: add support for
MediaTek MT7663S and MT7668S SDIO devices") in v5.2-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b062a0b9c1dc1ff63094337dccfe1568d5b62023]
stable/5.10: [70a6cf749d9ff9f463490248322e5343199bc267]
stable/5.15: [770a97d3f34b801de1b04737b43e02c55118c41a]
stable/5.4: [874eca93966a786eace87fa6dfb206c2dd9519b1]

CVE-2022-49201: ibmvnic: fix race between xmit and reset

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49201-f972@gregkh/

Introduced by commit 7ed5b31 ("net/ibmvnic: prevent more than one
thread from running in reset") in v5.4-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4219196d1f662cb10a462eb9e076633a3fc31a15]
stable/5.15: [1bd58abf595b6cf1ba6dd47ec887c4c009155fc9]

CVE-2022-49202: Bluetooth: hci_uart: add missing NULL check in h5_enqueue

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49202-070c@gregkh/

Introduced by commit d9dd833 ("Bluetooth: hci_h5: Add runtime
suspend") in v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32cb08e958696908a9aad5e49a78d74f7e32fffb]
stable/5.15: [7235485433d290367d60ae22fcdfc565e61d42ab]

CVE-2022-49203: drm/amd/display: Fix double free during GPU reset on DC streams

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49203-48ec@gregkh/

Introduced by commit 6d63fcc ("drm/amd/display: Reset link encoder
assignments for GPU reset") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32685b32d825ca08c5dec826477332df886c4743]

CVE-2022-49204: bpf, sockmap: Fix more uncharged while msg has more_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49204-38c3@gregkh/

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84472b436e760ba439e1969a9e3c5ae7c86de39d]
stable/5.10: [7b812a369e6416ab06d83cdd39d8e3f752781dd0]
stable/5.15: [168ff181f5b6e7fce684c98a30d35da1dbf8f82a]
stable/5.4: [244ce90c8d0bd10ebf957da02c6f3fcd5d920bdf]

CVE-2022-49205: bpf, sockmap: Fix double uncharge the mem of sk_msg

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49205-5180@gregkh/

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2486ab434b2c2a14e9237296db00b1e1b7ae3273]
stable/5.10: [cd84ea3920aef936c559b63099ef0013ce6b2325]
stable/5.15: [cb6f141ae705af0101e819065a79e6d029f6e393]
stable/5.4: [94c6ac22abcdede72bfaa0f4c22fb370891f4002]

CVE-2022-49206: RDMA/mlx5: Fix memory leak in error flow for subscribe
event routine

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49206-51a6@gregkh/

Introduced by commit 7597385 ("IB/mlx5: Enable subscription for device
events over DEVX") in v5.3-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [087f9c3f2309ed183f7e4b85ae57121d8663224d]
stable/5.10: [c98d903ff9e79c210beddea4e6bc15ac38e25aa5]
stable/5.15: [8dd392e352d3269938fea32061a74655a613f929]
stable/5.4: [0174a89663a5ef83617da15bf24c0af2f62b6c7f]

CVE-2022-49207: bpf, sockmap: Fix memleak in sk_psock_queue_msg

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49207-cfc1@gregkh/

Introduced by commit 9635720 ("bpf, sockmap: Fix memleak on ingress
msg enqueue") in v5.14-rc4.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [938d3480b92fa5e454b7734294f12a7b75126f09]
stable/5.15: [ef9785f429794567792561a584901faa9291d3ee]

CVE-2022-49208: RDMA/irdma: Prevent some integer underflows

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49208-9293@gregkh/

Introduced by commit 3f49d68 ("RDMA/irdma: Implement HW Admin Queue
OPs") in v5.14-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f6dbb819dfc1a35bcb8b709b5c83a3ea8beff75]
stable/5.15: [d52dab6e03550f9c97121b0c11c0a3ed78ee76a4]

CVE-2022-49209: bpf, sockmap: Fix memleak in tcp_bpf_sendmsg while sk
msg is full

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49209-85dc@gregkh/

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c34e38c4a870eb30b13f42f5b44f42e9d19ccb8]
stable/5.10: [bec34a91eba3483e1830c02bdd36f8f968642047]
stable/5.15: [de3a8d8fab0710186f7864ec812836d8d70da3c9]
stable/5.4: [6d03722c34d9603df325f67c6d30dc1b7b3c6067]

CVE-2022-49210: MIPS: pgalloc: fix memory leak caused by pgd_free()

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49210-6839@gregkh/

Introduced by commit f9cb654 ("asm-generic: pgalloc: provide generic
pgd_free()") in v5.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bc5bab9a763d520937e4f3fe8df51c6a1eceb97]
stable/5.10: [fa3d44424579972cc7c4fac3d9cf227798ebdfa0]
stable/5.15: [d29cda15cab086d82d692de016f7249545d4b6b4]

CVE-2022-49211: mips: cdmm: Fix refcount leak in mips_cdmm_phys_base

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49211-eec8@gregkh/

Introduced by commit 2121aa3 ("mips: cdmm: Add mti,mips-cdmm dtb node
support") in v5.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4528668ca331f7ce5999b7746657b46db5b3b785]
stable/5.10: [ef1728e3cb9e43f38ed10cde705a7ba2b4ad2d35]
stable/5.15: [69155dc2e04777aa94207a73a8b10f12b8428a68]

CVE-2022-49212: mtd: rawnand: atmel: fix refcount issue in
atmel_nand_controller_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49212-d8e6@gregkh/

Introduced by commit f88fc12 ("mtd: nand: Cleanup/rework the
atmel_nand driver") in v4.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9843c9c98f26c6ad843260b19bfdaa2598f2ae1e]
mainline: [fecbd4a317c95d73c849648c406bcf1b6a0ec1cf]
stable/4.19: [9843c9c98f26c6ad843260b19bfdaa2598f2ae1e]
stable/5.10: [a3587259ae553e41d1ce8c7435351a5d6b299a11]
stable/5.15: [fe0e2ce5c87e9c0b9485ff566362030aa55972cf]
stable/5.4: [9b08d211db4c447eb1a07df65e45e0aa772e0fa6]

CVE-2022-49213: ath10k: Fix error handling in ath10k_setup_msa_resources

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49213-6ce9@gregkh/

Introduced by commit 727fec7 ("ath10k: Setup the msa resources before
qmi init") in v5.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9747a78d5f758a5284751a10aee13c30d02bd5f1]
stable/5.10: [315772133a4b960859e4f5efe0e738e347188cdc]
stable/5.15: [32939187f254171a5666badc058bc3787fe454af]

CVE-2022-49214: powerpc/64s: Don't use DSISR for SLB faults

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49214-1b9a@gregkh/

Introduced by commit 46ddcb3 ("powerpc/mm: Show if a bad page fault on
data is read or write.") in v5.5-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4679ac8ea2e5078704aa1c026db36580cc1bf9a]
stable/5.15: [4a852ff9b7bea9c640540e2c1bc70bd3ba455d61]

CVE-2022-49215: xsk: Fix race at socket teardown

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49215-8328@gregkh/

Introduced by commit 42fddcc ("xsk: use state member for socket
synchronization") in v5.4-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18b1ab7aa76bde181bdb1ab19a87fa9523c32f21]
stable/5.15: [ad7219cd8751bd258b9d1e69ae0654ec00f71875]

CVE-2022-49216: drm/tegra: Fix reference leak in tegra_dsi_ganged_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49216-186e@gregkh/

Introduced by commit e94236c ("drm/tegra: dsi: Add ganged mode
support") in v3.19-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2d6ae8b747fe55f54de4a4441d636974aa53f56a]
cip/4.4-st: [bde5cb95993bd22761e2884fc14587f246ee64cb]
mainline: [221e3638feb8bc42143833c9a704fa89b6c366bb]
stable/4.19: [2d6ae8b747fe55f54de4a4441d636974aa53f56a]
stable/5.10: [1e06710c43a090f14bb67714265a01cd1d7a37c5]
stable/5.15: [852c1f5f3119a38ee68e319bab10277fc1ab06b7]
stable/5.4: [a725070701883fe62266ee6d2f31d67e6cdd31df]

CVE-2022-49217: scsi: pm8001: Fix abort all task initialization

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49217-1e82@gregkh/

Introduced by commit c6b9ef5 ("[SCSI] pm80xx: NCQ error handling
changes") in v3.10-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1824a21b2cedc5774a5adfa74f5f7b90472d8677]
cip/4.4-st: [82f03e12fbea4928240d6a5a110200d20ed1e790]
mainline: [7f12845c8389855dbcc67baa068b6832dc4a396e]
stable/4.19: [1824a21b2cedc5774a5adfa74f5f7b90472d8677]
stable/5.10: [279f318bd7d6e04e6e0bc7b8cd8e190da8fa37a4]
stable/5.15: [c8db786858d895ac58342f67767b4999ae6538fa]
stable/5.4: [765674e3b30121782a2b792684554baa48c61f5e]

CVE-2022-49218: drm/dp: Fix OOB read when handling Post Cursor2 register

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49218-26ee@gregkh/

Introduced by commit 79465e0 ("drm/dp: Add helper to get post-cursor
adjustments") in v5.5-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2151490cc6c57b368d7974ffd447a8b36ade639]

CVE-2022-49219: vfio/pci: fix memory leak during D3hot to D0 transition

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49219-3b9b@gregkh/

Introduced by commit 51ef3a0 ("vfio/pci: Restore device state on PM
transition") in v5.1-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eadf88ecf6ac7d6a9f47a76c6055d9a1987a8991]
stable/5.15: [4319f17fb8264ba39352b611dfa913a4d8c1d1a0]

CVE-2022-49220: dax: make sure inodes are flushed before destroy cache

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49220-7247@gregkh/

Introduced by commit 7b6be84 ("dax: refactor dax-fs into a generic
provider of 'struct dax_device' instances") in v4.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7e8de822e0b1979f08767c751f6c8a9c1d4ad86]
stable/5.10: [ec376f5c11c88c0215d173599db8449cd4196759]
stable/5.15: [e2951eaa9398415ac054b7bd80b8163b6838ead4]
stable/5.4: [770d42fff12d8595adda9025a0b92091f543e775]

CVE-2022-49221: drm/msm/dp: populate connector of struct dp_panel

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49221-353c@gregkh/

Introduced by commit 7948fe1 ("drm/msm/dp: return correct edid
checksum after corrupted edid checksum read") in v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [5e602f5156910c7b19661699896cb6e3fb94fab9]
stable/5.10: [413c62697b61226a236c8b1f5cd64dcf42bcc12f]
stable/5.15: [9525b8bcae8b99188990b56484799cf4b1b43786]

CVE-2022-49222: drm/bridge: anx7625: Fix overflow issue on reading EDID

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49222-ad42@gregkh/

Introduced by commit 8bdfc5d ("drm/bridge: anx7625: Add anx7625 MIPI
DSI/DPI to DP") in v5.11-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5c6f647aec9ed524aedd04a3aec5ebc21d39007]
stable/5.15: [64c06df2428bb7bb3d8cf5691416001af42d94dd]

CVE-2022-49223: cxl/port: Hold port reference until decoder release

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49223-5a42@gregkh/

Introduced by commit 40ba17a ("cxl/acpi: Introduce cxl_decoder
objects") in v5.14-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74be98774dfbc5b8b795db726bd772e735d2edd4]
stable/5.15: [518bb96367123062b48b0a9842f2864249b565f6]

CVE-2022-49224: power: supply: ab8500: Fix memory leak in ab8500_fg_sysfs_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49224-8d81@gregkh/

Introduced by commit 8c0984e ("power: move power supply drivers to
power/supply") in v4.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [db3a61ef8e6aef3b888baa6a85926c2230c2cc56]
mainline: [6a4760463dbc6b603690938c468839985189ce0a]
stable/4.19: [db3a61ef8e6aef3b888baa6a85926c2230c2cc56]
stable/5.10: [879356a6a05559582b0a7895d86d2d4359745c08]
stable/5.15: [ffb8e92b4cef92bd25563cf3d8b4489eb22bc61f]
stable/5.4: [41ed61364285ff38bbbe9ca8a45c8372ba72921d]

CVE-2022-49225: mt76: mt7921s: fix a possible memory leak in mt7921_load_patch

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49225-4daa@gregkh/

Introduced by commit 78b2175 ("mt76: mt7921s: fix bus hang with wrong
privilege") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11005b18f453aa192d035d410c11d07edcba5a45]

CVE-2022-49226: net: asix: add proper error handling of usb read errors

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49226-b30c@gregkh/

Introduced by commit d9fe64e ("net: asix: Add in_pm parameter") in v4.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [920a9fa27e7805499cfe78491b36fed2322c02ec]
stable/5.15: [b96a7265f763b37ff3138b9ca8122a950f13b00e]

CVE-2022-49227: igc: avoid kernel warning when changing RX ring parameters

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49227-76b1@gregkh/

Introduced by commit 73f1071 ("igc: Add support for XDP_TX action") in
v5.13-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [453307b569a0d41bddd07f26bf41b784cd82a4c9]
stable/5.15: [ab8c107470d12e7ef99030bf0911a10cdef62d16]

CVE-2022-49228: bpf: Fix a btf decl_tag bug when tagging a function

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49228-f915@gregkh/

Introduced by commit b5ea834 ("bpf: Support for new btf kind
BTF_KIND_TAG") in v5.16-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7e7b42f4f956f2c68ad8cda87d750093dbba737]

CVE-2022-49229: ptp: unregister virtual clocks when unregistering
physical clock.

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49229-2c2e@gregkh/

Introduced by commit 73f3706 ("ptp: support ptp physical/virtual
clocks conversion") in v5.14-rc2.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfcbb76b0f595ea9ede9f7a218086fef85242f10]
stable/5.15: [b2dea2a696d09163da4cd33cb598ce1f73e86597]

CVE-2022-49230: mt76: mt7915: fix possible memory leak in mt7915_mcu_add_sta

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49230-2758@gregkh/

Introduced by commit 89bbd37 ("mt76: mt7915: rework starec TLV tags")
in v5.16-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a43736cd12d82913102eb49cb56787a5553e028f]

CVE-2022-49231: rtw88: fix memory overrun and memory leak during hw_scan

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49231-88de@gregkh/

Introduced by commit 10d162b ("rtw88: 8822c: add
ieee80211_ops::hw_scan") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d95984b5580dcb8b1c0036577c52b609990a1dab]

CVE-2022-49232: drm/amd/display: Fix a NULL pointer dereference in
amdgpu_dm_connector_add_common_modes()

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49232-bf6c@gregkh/

Introduced by commit e7b07ce ("drm/amd/display: Merge amdgpu_dm_types
and amdgpu_dm") in v4.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2c729dec8c1e3e2892fde5ce8181553860914e74]
mainline: [588a70177df3b1777484267584ef38ab2ca899a2]
stable/4.19: [2c729dec8c1e3e2892fde5ce8181553860914e74]
stable/5.10: [19a7eba284790cfbba2945deb2363cf03ce41648]
stable/5.15: [bdc7429708a0772d90c208975694f7c2133b1202]
stable/5.4: [57f4ad5e286fe4599c8fc63cf89f85f9eec7f9c9]

CVE-2022-49233: drm/amd/display: Call dc_stream_release for remove
link enc assignment

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49233-43db@gregkh/

Introduced by commit 0bb2455 ("drm/amd/display: retain/release at
proper places in link_enc assignment") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2bde8349c35d01d7c50456ea06a5c7d5e0e5ed0]

CVE-2022-49234: net: dsa: Avoid cross-chip syncing of VLAN filtering

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49234-b4b1@gregkh/

Introduced by commit d371b7c ("net: dsa: Unset vlan_filtering when
ports leave the bridge") in v5.2-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [108dc8741c203e9d6ce4e973367f1bac20c7192b]

CVE-2022-49235: ath9k_htc: fix uninit value bugs

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49235-52fb@gregkh/

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ee4222052a76559c20e821bc3519cefb58b6d3e9]
cip/4.4-st: [66455ad338815258e707463b172b438425e68b1f]
mainline: [d1e0df1c57bd30871dd1c855742a7c346dbca853]
stable/4.19: [ee4222052a76559c20e821bc3519cefb58b6d3e9]
stable/5.10: [11f11ac281f0c0b363d2940204f28bae0422ed71]
stable/5.15: [0b700f7d06492de34964b6f414120043364f8191]
stable/5.4: [4d244b731188e0b63fc40a9d2dec72e9181fb37c]

CVE-2022-49236: bpf: Fix UAF due to race between btf_try_get_module
and load_module

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49236-e3f7@gregkh/

Introduced by commit 541c3ba ("bpf: Support BPF ksym variables in
kernel modules") in v5.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18688de203b47e5d8d9d0953385bf30b5949324f]
stable/5.15: [51b82141fffa454abf937a8ff0b8af89e4fd0c8f]

CVE-2022-49237: ath11k: add missing of_node_put() to avoid leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49237-760d@gregkh/

Introduced by commit 6ac04bd ("ath11k: Use reserved host DDR addresses
from DT for PCI devices") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d38faef0de1756994b3d95e47b2302842f729e2]

CVE-2022-49238: ath11k: free peer for station when disconnect from AP
for QCA6390/WCN6855

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49238-3642@gregkh/

Introduced by commit b4a0f54 ("ath11k: move peer delete after vdev
stop of station for QCA6390 and WCN6855") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [212ad7cb7d7592669c067125949e0a8e31ce6a0b]

CVE-2022-49239: ASoC: codecs: wcd934x: Add missing of_node_put() in
wcd934x_codec_parse_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49239-e012@gregkh/

Introduced by commit a61f3b4 ("ASoC: wcd934x: add support to
wcd9340/wcd9341 codec") in v5.6-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9531a631379169d57756b2411178c6238655df88]
stable/5.10: [1f24716e38220fc9e52e208d20591d2bc9b7f020]
stable/5.15: [2f44eca78cc6d4e1779eb95765ec79e433accab4]

CVE-2022-49240: ASoC: mediatek: mt8195: Fix error handling in
mt8195_mt6359_rt1019_rt5682_dev_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49240-c047@gregkh/

Introduced by commit 082482a ("ASoC: mediatek: mt8195: release
device_node after snd_soc_register_card") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4b7174fe5bb875a09a78674a14a1589d1a672f3]

CVE-2022-49241: ASoC: atmel: Fix error handling in sam9x5_wm8731_driver_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49241-928c@gregkh/

Introduced by commit fdbcb3c ("ASoC: atmel: machine driver for
at91sam9x5-wm8731 boards") in v3.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [740dc3e846537c3743da98bf106f376023fd085c]
stable/5.10: [90ac679aa6a01841da90ec5a4aaa4b5e0badddf0]
stable/5.15: [f589063b585ac6dd2081bde6c145411cf48d8d92]

CVE-2022-49242: ASoC: mxs: Fix error handling in mxs_sgtl5000_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49242-3bd3@gregkh/

Introduced by commit e968194 ("ASoC: mxs: add device tree support for
mxs-sgtl5000") in v3.5-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f8d38056bcd220ea6f0802a5586d1a12ebcce849]
cip/4.4-st: [63e59ee9bb017582e3fd8f1ec56fc3990856f97e]
mainline: [6ae0a4d8fec551ec581d620f0eb1fe31f755551c]
stable/4.19: [f8d38056bcd220ea6f0802a5586d1a12ebcce849]
stable/5.10: [86b6cf989437e694fd0a15782b5a513853a739e0]
stable/5.15: [44acdaf7acb60054d872bed18ce0e7db8ce900ce]
stable/5.4: [67e12f1cb2f97468c12b59e21975eaa0f332e7d2]

CVE-2022-49243: ASoC: atmel: Add missing of_node_put() in
at91sam9g20ek_audio_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49243-9779@gregkh/

Introduced by commit 531f67e ("ASoC: at91sam9g20ek-wm8731: convert to
dt support") in v3.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b0c56a0071116a37c24df998166c22a7e4684626]
cip/4.4-st: [74201fa97c173d986c2ed51d7c31d759a7ac0e95]
mainline: [f590797fa3c1bccdd19e55441592a23b46aef449]
stable/4.19: [b0c56a0071116a37c24df998166c22a7e4684626]
stable/5.10: [662ee5ac6b451aa5a27b8eebd397f2f5c7f42cec]
stable/5.15: [a0bc36b247dcf4d21bf820bfc4bcbaf7f6cf19b5]
stable/5.4: [0325193cf40dc3a6e27d55a5b98680936deebcd0]

CVE-2022-49244: ASoC: mediatek: mt8192-mt6359: Fix error handling in
mt8192_mt6359_dev_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49244-cff0@gregkh/

Introduced by commit 4e28491 ("ASoC: mediatek: mt8192-mt6359: fix
device_node leak") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [e45ac7831ff3e2934d58cce319c17c8ec763c95c]
stable/5.15: [87e04a89c31e792eef62bcba6ebb77fd323d28a1]

CVE-2022-49245: ASoC: rockchip: Fix PM usage reference of
rockchip_i2s_tdm_resume

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49245-dcd4@gregkh/


Introduced by commit 081068f ("ASoC: rockchip: add support for i2s-tdm
controller")
in 5.16-rc1..Fixed in v5.18-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc5d8ac95663a5813c696008bc524b794d471215]

CVE-2022-49246: ASoC: atmel: Fix error handling in snd_proto_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49246-0ed0@gregkh/

Introduced by commit a45f885 ("ASoC: Add driver for PROTO Audio CODEC
(with a WM8731)") in v4.20-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0bfaf0544d08d093d6211d7ef8816fb0b5b6c75]
stable/5.15: [f32ac9bf5e3f594ef9bfedb410aebc98cf784e69]

CVE-2022-49247: media: stk1160: If start stream fails, return buffers
with VB2_BUF_STATE_QUEUED

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49247-66c2@gregkh/

Introduced by commit 8ac4564 ("[media] stk1160: Stop device and
unqueue buffers when start_streaming() fails") in v3.7-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f04a520a422222fc921bf035dc67414c500a286a]
mainline: [fbe04b49a54e31f4321d632270207f0e6304cd16]
stable/4.19: [f04a520a422222fc921bf035dc67414c500a286a]
stable/5.10: [4d68603cc4382174bc1e7d532e10675c48c6b257]
stable/5.15: [a09e9882800fdfc5aab93f77c3f0132071d2191b]
stable/5.4: [3cc050df73e3d973f1870a8dc0e177e77670bc7f]

CVE-2022-49248: ALSA: firewire-lib: fix uninitialized flag for AV/C
deferred transaction

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49248-b4a9@gregkh/

Introduced by commit 00a7bb8 ("ALSA: firewire-lib: Add support for
deferred transaction") in v3.16-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [60e5d391805d70458a01998de00d0c28cba40bf3]
cip/4.4-st: [df94a70792ed516950176b09a0e995c940cf44b0]
mainline: [bf0cd60b7e33cf221fbe1114e4acb2c828b0af0d]
stable/4.19: [60e5d391805d70458a01998de00d0c28cba40bf3]
stable/5.10: [7e6f5786621df060f8296f074efd275eaf20361a]
stable/5.15: [eab74c41612083bd627b60da650e19234e4f1051]
stable/5.4: [7025f40690a235a118c87674cfb93072694aa66d]

CVE-2022-49249: ASoC: codecs: wc938x: fix accessing array out of
bounds for enum type

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49249-18dc@gregkh/

Introduced by commit e8ba1e0 ("ASoC: codecs: wcd938x: add basic
controls") in v5.14-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc587b7c8fbbe128f6bd0dad025a0caea5e6d164]
stable/5.15: [adafea71b49ec4dbc44e0b84ec6eb602004a7a08]

CVE-2022-49250: ASoC: codecs: rx-macro: fix accessing compander for aux

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49250-c66c@gregkh/

Introduced by commit 4f69292 ("ASoC: codecs: lpass-rx-macro: add dapm
widgets and route") in v5.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42c709c4e1ce4c136891530646c9abd5dff3524f]
stable/5.15: [9208ecc703b5ed5b12d7ea13c79207f4c8456638]

CVE-2022-49251: ASoC: codecs: va-macro: fix accessing array out of
bounds for enum type

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49251-7153@gregkh/

Introduced by commit 908e6b1 ("ASoC: codecs: lpass-va-macro: Add
support to VA Macro") in v5.11-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ea5eff7c6063a8f124188424f8e4c6727f35051]
stable/5.15: [966408e37d84b762d11978b7bfb03fff0c6222ad]

CVE-2022-49252: ASoC: codecs: rx-macro: fix accessing array out of
bounds for enum type

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49252-f276@gregkh/

Introduced by commit 4f69292 ("ASoC: codecs: lpass-rx-macro: add dapm
widgets and route") in v5.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bcfe5f76cc4051ea3f9eb5d2c8ea621641f290a5]
stable/5.15: [eb15c6ea692fd88d70698d874d9a0d667fb4cde9]

CVE-2022-49253: media: usb: go7007: s2250-board: fix leak in probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49253-f3d7@gregkh/

Introduced by commit d3b2ccd ("[media] s2250: convert to the control
framework") in v3.10-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b7dd177225355da55f8d80d8e568928e0eec3608]
cip/4.4-st: [199b6ed8b1fbf314f576eecdeff25a7625783a84]
mainline: [67e4550ecd6164bfbdff54c169e5bbf9ccfaf14d]
stable/4.19: [b7dd177225355da55f8d80d8e568928e0eec3608]
stable/5.10: [44973633b0064c46083833b55dd0a45e6235f8ca]
stable/5.15: [895364fa97e60749855f789bc4568883fc7a8b39]
stable/5.4: [14cd5a8e61c654828a1f1056d56f0b0a524d2c69]

CVE-2022-49254: media: ti-vpe: cal: Fix a NULL pointer dereference in
cal_ctx_v4l2_init_formats()

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49254-ea38@gregkh/

Introduced by commit 7168155 ("media: ti-vpe: cal: Move format
handling to cal.c and expose helpers") in v5.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abd77889851d2ead0d0c9c4d29f1808801477b00]
stable/5.15: [aa613ac270292e102503e9767882e39200efe608]

CVE-2022-49255: f2fs: fix missing free nid in f2fs_handle_failed_inode

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49255-68f3@gregkh/

Introduced by commit 7735730 ("f2fs: fix to propagate error from
__get_meta_page()") in v4.19-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fef99b8372c1ae3d8445ab570e888b5a358dbe9]
stable/5.10: [1a11a873749c6375bb668953fa1a196d8538d26b]
stable/5.15: [d1eaaf6cadedf638e17017b0a04d56308405ac10]
stable/5.4: [005f9cdab70c915702254c5eb67a8efced80e821]

CVE-2022-49256: watch_queue: Actually free the watch

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49256-042d@gregkh/

Introduced by commit c73be61 ("pipe: Add general notification queue
support") in v5.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d8dcf278b1ee1eff1e90be848fa2237db4c07a7]
stable/5.10: [9d92be1a09fbb3dd65600dbfe7eedb40e7228e4b]
stable/5.15: [f69aecb49968e14196366bbe896eab0a904229f5]

CVE-2022-49257: watch_queue: Fix NULL dereference in error cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49257-351f@gregkh/

Introduced by commit c73be61 ("pipe: Add general notification queue
support") in v5.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a635415a064e77bcfbf43da413fd9dfe0bbed9cb]
stable/5.10: [5ae75b4ed30322b42abaa75ef1b784addfdb7dc9]
stable/5.15: [695c47cea02b9101e2fc2e7d36d552128592b347]

CVE-2022-49258: crypto: ccree - Fix use after free in cc_cipher_exit()

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49258-0dd7@gregkh/

Introduced by commit 63ee04c ("crypto: ccree - add skcipher support")
in v4.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d950c34074ed74d2713c3856ba01264523289e6]
stable/5.10: [c93017c8d5ebf55a4e453ac7c84cc84cf92ab570]
stable/5.15: [335bf1fc74f775a8255257aa3e33763f2257b676]

CVE-2022-49259: block: don't delete queue kobject before its children

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49259-00f9@gregkh/

Introduced by commit 2c2086a ("block: Protect less code with
sysfs_lock in blk_{un,}register_queue()") in v4.16-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b2001eb10f59363da930cdd6e086a2861986fa18]
mainline: [0f69288253e9fc7c495047720e523b9f1aba5712]
stable/4.19: [b2001eb10f59363da930cdd6e086a2861986fa18]
stable/5.10: [0b5924a14d64487ebd51127b0358d06066ef5384]
stable/5.15: [efaa0e969261e97c1fdd8e0338e5dd3ba5b9219c]
stable/5.4: [84fe3ca6e7910beb47ec13509d484f84fa2a41ad]

CVE-2022-49260: crypto: hisilicon/sec - fix the aead software fallback
for engine

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49260-a4a5@gregkh/

Introduced by commit 6c46a32 ("crypto: hisilicon/sec - add fallback
tfm...") in v5.14-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a2a464f863187f97e96ebc6384c052cafd4a54c]
stable/5.15: [40dba7c26e897c637e91312b35f664f1d4d0073c]

CVE-2022-49261: drm/i915/gem: add missing boundary check in vm_access

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49261-d253@gregkh/

Introduced by commit 9f909e2 ("drm/i915: Implement vm_ops->access for
gdb access into mmaps") in v5.8-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3886a86e7e6cc6ce2ce93c440fecd8f42aed0ce7]
stable/5.10: [89ddcc81914ab58cc203acc844f27d55ada8ec0e]
stable/5.15: [312d3d4f49e12f97260bcf972c848c3562126a18]

CVE-2022-49262: crypto: octeontx2 - remove CONFIG_DM_CRYPT check

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49262-c11a@gregkh/

Introduced by commit 6f03f0e ("crypto: octeontx2 - register with linux
crypto framework") in v5.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d841af23ae8f398c85dd1ff2dc24b5ec8ba4569]
stable/5.15: [e6374086f249295121384bfaa7cdcc8d461146f0]

CVE-2022-49263: brcmfmac: pcie: Release firmwares in the
brcmf_pcie_setup error path

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49263-2e87@gregkh/

Introduced by commit 82f93cf ("brcmfmac: get chip's default RAM info
during PCIe setup") in v5.4-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e90f0f3ead014867dade7a22f93958119f5efab]
stable/5.10: [f3820ddaf4f3ac80c7401ccc6a42e663c9317f31]
stable/5.15: [a88337a06966f2d733ad9a97714b874469133f14]
stable/5.4: [d0ab87f8dcdfe72dc1d763be3392c1fc51a1ace2]

CVE-2022-49264: exec: Force single empty string when argv is empty

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49264-ca90@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [b50fb8dbc8b81aaa126387de428f4c42a7c72a73]
cip/4.4-st: [5afe97e9f7b3f1c8021b6ff7e82ca03dbb68daae]
mainline: [dcd46d897adb70d63e025f175a00a89797d31a43]
stable/4.19: [b50fb8dbc8b81aaa126387de428f4c42a7c72a73]
stable/5.10: [27a6f495b63a1804cc71be45911065db7757a98c]
stable/5.15: [1290eb4412aa0f0e9f3434b406dc8e255da85f9e]
stable/5.4: [1fe82bfd9e4ce93399d815ca458b58505191c3e8]

CVE-2022-49265: PM: domains: Fix sleep-in-atomic bug caused by
genpd_debug_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49265-11d4@gregkh/

Introduced by commit 718072c ("PM: domains: create debugfs nodes when
adding power domains") in v5.11-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6bfe8b5b2c2a5ac8bd2fc7bca3706e6c3fc26d8]
stable/5.15: [2039163c30f886cf5638afd6993705ae9bb34a06]

CVE-2022-49266: block: fix rq-qos breakage from skipping rq_qos_done_bio()

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49266-3d45@gregkh/

Introduced by commit a647a52 ("block: don't call rq_qos_ops->done_bio
if the bio isn't tracked") in v5.15-rc3.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa1b46dcdc7baaf5fec0be25782ef24b26aa209e]
stable/5.15: [af9452dfdba4bf7359ef7645eee2d243a1df0649]

CVE-2022-49267: mmc: core: use sysfs_emit() instead of sprintf()

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49267-b3ac@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [f5d8a5fe77ce933f53eb8f2e22bb7a1a2019ea11]

CVE-2022-49268: ASoC: SOF: Intel: Fix NULL ptr dereference when ENOMEM

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49268-4842@gregkh/

Introduced by commit d16046f ("ASoC: SOF: Intel: Add Intel specific
HDA firmware loader") in v5.2-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7fb0ae09009d076964afe4c1a2bde1ee2bd88a9]
stable/5.10: [0c307349fe060971625b856c92f0361b8ea9a120]
stable/5.15: [b6094744e261083d3790c3def770ebf5060d383b]
stable/5.4: [01df5f7627f1624d6bb0b8c0870a569b32adfbf8]

CVE-2022-49269: can: isotp: sanitize CAN ID checks in isotp_bind()

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49269-dbd1@gregkh/

Introduced by commit e057dd3 ("can: add ISO 15765-2:2016 transport
protocol") in v5.10-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ea566422cbde9610c2734980d1286ab681bb40e]
stable/5.10: [d72866a7f5326160d2a9d945a33eb6ef1883e25d]
stable/5.15: [f343dbe82314ab457153c9afd970be4e9e553020]

CVE-2022-49270: dm: fix use-after-free in dm_cleanup_zoned_dev()

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49270-c331@gregkh/

Introduced by commit bb37d77 ("dm: introduce zone append emulation")
in v5.14-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [588b7f5df0cb64f281290c7672470c006abe7160]
stable/5.15: [0987f00a76a17aa7213da492c00ed9e5a6210c73]

CVE-2022-49271: cifs: prevent bad output lengths in smb2_ioctl_query_info()

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49271-55c9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [b92e358757b91c2827af112cae9af513f26a3f34]
stable/5.10: [9963ccea6087268e1275b992dca5d0dd4b938765]
stable/5.15: [f143f8334fb9eb2f6c7c15b9da1472d9c965fd84]

CVE-2022-49272: ALSA: pcm: Fix potential AB/BA lock with buffer_mutex
and mmap_lock

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49272-4b85@gregkh/


Introduced by dca947d ("ALSA: pcm: Fix races among concurrent read/write and
buffer changes") in 5.18-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [40f4cffbe13a51faf136faf5f9ef6847782cd595]
mainline: [bc55cfd5718c7c23e5524582e9fa70b4d10f2433]
stable/5.10: [7e9133607e1501c94881be35e118d8f84d96dcb4]
stable/5.15: [40f4cffbe13a51faf136faf5f9ef6847782cd595]
stable/5.4: [9661bf674d6a82b76e4ae424438a8ce1e3ed855d]

CVE-2022-49273: rtc: pl031: fix rtc features null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49273-61de@gregkh/

Introduced by commit d9b0dd5 ("rtc: pl031: use RTC_FEATURE_ALARM") in v5.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea6af39f3da50c86367a71eb3cc674ade3ed244c]
stable/5.15: [cd2722e411e8ab7e5ae41102f6925fa13dffdac5]

CVE-2022-49274: ocfs2: fix crash when mount with quota enabled

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49274-9f33@gregkh/

Introduced by commit 6c85c2c ("ocfs2: quota_local: fix possible
uninitialized-variable access in ocfs2_local_read_info()") in
v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de19433423c7bedabbd4f9a25f7dbc62c5e78921]
stable/5.15: [7c5312fdb1dcfdc1951b018669af88d5d6420b31]

CVE-2022-49275: can: m_can: m_can_tx_handler(): fix use after free of skb

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49275-9e36@gregkh/

Introduced by commit 8064673 ("can: m_can: update to support CAN FD
features") in v3.18-rc6.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7728d937ec403a1ceff9483023252d2cb8777f81]
cip/4.4-st: [7321f6f3f07dbb8b23c705d71ebbf2d2d6aeb47b]
mainline: [2e8e79c416aae1de224c0f1860f2e3350fa171f8]
stable/4.19: [7728d937ec403a1ceff9483023252d2cb8777f81]
stable/5.10: [869016a2938ac44f7b2fb7fc22c89edad99eb9b3]
stable/5.15: [f43e64076ff1b1dcb893fb77ad1204105f710a29]
stable/5.4: [08d90846e438ac22dc56fc49ec0b0d195831c5ed]

CVE-2022-49276: jffs2: fix memory leak in jffs2_scan_medium

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49276-d58d@gregkh/

Introduced by commit e631ddb ("[JFFS2] Add erase block summary support
(mount time improvement)") in v2.6.20.16.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e711913463af916d777a4873068f415f1fe2ad33]
cip/4.4-st: [597b202ea4e078e2e4f227011c5734d6bb949573]
mainline: [9cdd3128874f5fe759e2c4e1360ab7fb96a8d1df]
stable/4.19: [e711913463af916d777a4873068f415f1fe2ad33]
stable/5.10: [51dbb5e36d59f62e34d462b801c1068248149cfe]
stable/5.15: [52ba0ab4f0a606f02a6163493378989faa1ec10a]
stable/5.4: [455f4a23490bfcbedc8e5c245c463a59b19e5ddd]

CVE-2022-49277: jffs2: fix memory leak in jffs2_do_mount_fs

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49277-ff2c@gregkh/

Introduced by commit e631ddb ("[JFFS2] Add erase block summary support
(mount time improvement)") in v2.6.20.16.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dbe0d0521eaa6a3d235517319266c539bb5c5112]
cip/4.4-st: [64e64a4b0d14eb33c83a154cd17b3f66b768a7f1]
mainline: [d051cef784de4d54835f6b6836d98a8f6935772c]
stable/4.19: [dbe0d0521eaa6a3d235517319266c539bb5c5112]
stable/5.10: [607d3aab7349f18e0d9dba4100d09d16fe27caca]
stable/5.15: [4392e8aeebc5a4f8073620bccba7de1b1f6d7c88]
stable/5.4: [0978e9af4559a171ac7a74a1b3ef21804b0a0fa9]

CVE-2022-49278: remoteproc: Fix count check in rproc_coredump_write()

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49278-b48d@gregkh/

Introduced by commit 3afdc59 ("remoteproc: Add coredump debugfs
entry") in v5.9-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f89672cc3681952f2d06314981a6b45f8b0045d1]
stable/5.10: [b97b305656a7013690e7b6e310f0e827e0bbff90]
stable/5.15: [34afac3c75fa08d6fabbab4c93f0a90618afaaa6]

CVE-2022-49279: NFSD: prevent integer overflow on 32 bit systems

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49279-811f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Introduced by 37c8876 ("NFSv4; Clean up XDR encoding of type bitmap4")
in 4.17-rc1.

Fixed status
cip/4.19-st: [3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8]
mainline: [23a9dbbe0faf124fc4c139615633b9d12a3a89ef]
stable/4.19: [3a2789e8ccb4a3e2a631f6817a2d3bb98b8c4fd8]
stable/5.10: [7af164fa2f1abc577d357d22d83a2f3490875d7e]
stable/5.15: [303cd6173dce0a28d26526c77814eb90a41bd898]
stable/5.4: [ce1aa09cc14ed625104acc2d487bd92b9a88efe2]

CVE-2022-49280: NFSD: prevent underflow in nfssvc_decode_writeargs()

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49280-8de2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [9f0f048c1bfa7867d565a95fd8c28f4484ba1043]
cip/4.4-st: [eda38881e126d80ccbf444517cb6de140c93eb09]
mainline: [184416d4b98509fb4c3d8fc3d6dc1437896cc159]
stable/4.19: [9f0f048c1bfa7867d565a95fd8c28f4484ba1043]
stable/5.10: [65e21cc042f4c1518c8c55283f53bc725b78419d]
stable/5.15: [614a61e1592051cc42d3c38f899c9f7bdaad8a1d]
stable/5.4: [85259340fc9bd54e3d567b41b881ecb4d0055da1]

CVE-2022-49281: cifs: fix handlecache and multiuser

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49281-4365@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
mainline: [47178c7722ac528ea08aa82c3ef9ffa178962d7a]
stable/5.15: [2fafbc198613823943c106d1ec9b516da692059f]

CVE-2022-49282: f2fs: quota: fix loop condition at f2fs_quota_sync()

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49282-9868@gregkh/

Introduced by commit 9de71ed ("f2fs: quota: fix potential deadlock")
in v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [680af5b824a52faa819167628665804a14f0e0df]
stable/5.10: [e58ee6bd939b773675240f5d0f5b88a367c037c4]
stable/5.15: [f9156db0987f1b426015d56505e2c58dee70c90d]
stable/5.4: [f1d5946d47c0827bae39e1537959ce8d6f0224c5]

CVE-2022-49283: firmware: sysfb: fix platform-device leak in error path

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49283-e19b@gregkh/

Introduced by commit 0589e88 ("drivers/firmware: Add missing
platform_device_put() in sysfb_create_simplefb") in v5.17-rc1.
Introduced by commit 8633ef8 ("drivers/firmware: consolidate EFI
framebuffer setup for all arches") in v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [202c08914ba50dd324e42d5ad99535a89f242560]
stable/5.15: [b3e38f939ab4d0d86f56bff3362c3f88c4b2ad32]

CVE-2022-49284: coresight: syscfg: Fix memleak on registration failure
in cscfg_create_device

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49284-f545@gregkh/

Introduced by commit 85e2414 ("coresight: syscfg: Initial coresight
system configuration") in v5.15-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfa5dbcdd7aece76f3415284569f2f384aff0253]
stable/5.15: [c61e2fc87f24cae4701f352fe9ecd4c5c143106c]

CVE-2022-49285: iio: accel: mma8452: use the correct logic to get mma8452_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49285-627c@gregkh/

Introduced by commit c3cdd6e ("iio: mma8452: refactor for seperating
chip specific data") in v4.4-rc1.
Introduced by commit 8b7651f ("iio: iio_device_alloc(): Remove
unnecessary self drvdata") in v5.17-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c87b7b12f48db86ac9909894f4dc0107d7df6375]
stable/5.15: [4c0bb583a4444cce224e8661090cbffc98e2fe07]

CVE-2022-49286: tpm: use try_get_ops() in tpm-space.c

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49286-a585@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.
Affected function was added by 745b361 ("tpm: infrastructure for TPM
spaces") in 4.12-rc1.

Fixed status
mainline: [fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9]
stable/5.10: [95193d12f10a8a088843b25e0f5fe1d83ec6b079]
stable/5.15: [476ddd23f818fb94cf86fb5617f3bb9a7c92113d]
stable/5.4: [5b1d2561a03e534064b51c50c774657833d3d2cf]

CVE-2022-49287: tpm: fix reference counting for struct tpm_chip

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49287-2ed9@gregkh/

Introduced by commit fdc915f ("tpm: expose spaces via a device link
/dev/tpmrm<n>") in v4.12-rc1.
Introduced by commit 8979b02 ("tpm: Fix reference count to main
device") in v4.12-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cb64bd038beacb4331fe464a36c8b5481e8f51e2]
mainline: [7e0438f83dc769465ee663bb5dcf8cc154940712]
stable/4.19: [cb64bd038beacb4331fe464a36c8b5481e8f51e2]
stable/5.10: [290e05f346d1829e849662c97e42d5ad984f5258]
stable/5.15: [662893b4f6bd466ff9e1cd454c44c26d32d554fe]
stable/5.4: [a27ed2f3695baf15f9b34d2d7a1f9fc105539a81]

CVE-2022-49288: ALSA: pcm: Fix races among concurrent prealloc proc writes

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49288-d3cb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [e14dca613e0a6ddc2bf6e360f16936a9f865205b]
mainline: [69534c48ba8ce552ce383b3dfdb271ffe51820c3]
stable/4.19: [e14dca613e0a6ddc2bf6e360f16936a9f865205b]
stable/5.10: [b560d670c87d7d40b3cf6949246fa4c7aa65a00a]
stable/5.15: [51fce708ab8986a9879ee5da946a2cc120f1036d]
stable/5.4: [37b12c16beb6f6c1c3c678c1aacbc46525c250f7]

CVE-2022-49289: uaccess: fix integer overflow on access_ok()

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49289-3435@gregkh/

Introduced by commit da55128 ("csky: User access") in v4.20-rc1.
Introduced by commit f663b60 ("microblaze: Fix uaccess_ok macro") in v3.10-rc1.
Introduced by commit 7567746 ("Hexagon: Add user access functions") in v3.2-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [222ca305c9fd39e5ed8104da25c09b2b79a516a8]
stable/5.15: [e65d28d4e9bf90a35ba79c06661a572a38391dec]

CVE-2022-49290: mac80211: fix potential double free on mesh join

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49290-42e8@gregkh/

Introduced by commit 6a01afc ("mac80211: mesh: Free ie data when
leaving mesh") in v5.8.
Fixed in v5.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
cip/4.19-st: [273ebddc5fda2967492cb0b6cdd7d81cfb821b76]
cip/4.4-st: [4173ed6b9ed3a40b157c8479cd4b7cc4df22e1dc]
mainline: [4a2d4496e15ea5bb5c8e83b94ca8ca7fb045e7d3]
stable/4.19: [273ebddc5fda2967492cb0b6cdd7d81cfb821b76]
stable/5.10: [5d3ff9542a40ce034416bca03864709540a36016]
stable/5.15: [12e407a8ef17623823fd0c066fbd7f103953d28d]
stable/5.4: [3bbd0000d012f92aec423b224784fbf0f7bf40f8]

CVE-2022-49291: ALSA: pcm: Fix races among concurrent hw_params and
hw_free calls

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49291-8c67@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [9cb6c40a6ebe4a0cfc9d6a181958211682cffea9]
mainline: [92ee3c60ec9fe64404dc035e7c41277d74aa26cb]
stable/4.19: [9cb6c40a6ebe4a0cfc9d6a181958211682cffea9]
stable/5.10: [0f6947f5f5208f6ebd4d76a82a4757e2839a23f8]
stable/5.15: [33061d0fba51d2bf70a2ef9645f703c33fe8e438]
stable/5.4: [fbeb492694ce0441053de57699e1e2b7bc148a69]

CVE-2022-49292: ALSA: oss: Fix PCM OSS buffer allocation overflow

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49292-b60c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.18-rc1.


Fixed status
cip/4.19-st: [a63af1baf0a5e11827db60e3127f87e437cab6e5]
mainline: [efb6402c3c4a7c26d97c92d70186424097b6e366]
stable/4.19: [a63af1baf0a5e11827db60e3127f87e437cab6e5]
stable/5.10: [5ce74ff7059341d8b2f4d01c3383491df63d1898]
stable/5.15: [7a40cbf3579a8e14849ba7ce46309c1992658d2b]
stable/5.4: [0c4190b41a69990666b4000999e27f8f1b2a426b]

CVE-2022-49293: netfilter: nf_tables: initialize registers in nft_do_chain()

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49293-15b7@gregkh/

Introduced by commit 9651851 ("netfilter: add nftables") in v3.13-rc1.
Fixed in v5.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [88791b79a1eb2ba94e95d039243e28433583a67b]
cip/4.4-st: [d90721416cde50f04a108331d524c69c7213be83]
mainline: [4c905f6740a365464e91467aa50916555b28213d]
stable/4.19: [88791b79a1eb2ba94e95d039243e28433583a67b]
stable/5.10: [2c74374c2e88c7b7992bf808d9f9391f7452f9d9]
stable/5.15: [fafb904156fbb8f1dd34970cd5223e00b47c33be]
stable/5.4: [06f0ff82c70241a766a811ae1acf07d6e2734dcb]

CVE-2022-49294: drm/amd/display: Check if modulo is 0 before dividing.

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49294-a2fc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
It seems as if this bug was introduced by commit 77a2b72 ("drm/amd/display:
Synchronize displays with different timings") in 5.13-rc1.

Fixed status
mainline: [49947b906a6bd9668eaf4f9cf691973c25c26955]
stable/5.15: [10ef82d6e0af5536ec64770c07f6bbabfdd6977c]

CVE-2022-49295: nbd: call genl_unregister_family() first in nbd_cleanup()

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49295-6374@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
It seems as if this bug was introduced by commit e46c7287 ("nbd: add a basic
netlink interface") in 4.12-rc1.

Fixed status
cip/4.19-st: [013a79f1b5c89290e2e97f1ebf14b14e0cf5fe5c]
mainline: [06c4da89c24e7023ea448cadf8e9daf06a0aae6e]
stable/4.19: [013a79f1b5c89290e2e97f1ebf14b14e0cf5fe5c]
stable/5.10: [c0868f6e728c3c28bef0e8bee89d2daf86a8bbca]
stable/5.15: [cbeafa7a79d08ecdb55f8f1d41a11323d0f709db]
stable/5.4: [1be608e1ee1f222464b2856bda9b85ab5184a33e]

CVE-2022-49296: ceph: fix possible deadlock when holding Fwb to get inline_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49296-f8f1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [825978fd6a0defc3c29d8a38b6cea76a0938d21e]

CVE-2022-49297: nbd: fix io hung while disconnecting device

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49297-2edb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [62d227f67a8c25d5e16f40e5290607f9306d2188]
mainline: [09dadb5985023e27d4740ebd17e6fea4640110e5]
stable/4.19: [62d227f67a8c25d5e16f40e5290607f9306d2188]
stable/5.10: [f72df77600a43e59b3189e53b47f8685739867d3]
stable/5.15: [c4ba982bd5084fa659ef518aaf159e4dab02ecda]
stable/5.4: [69893d6d7f5c10d8306c1b5fc64b71efc91aa6cd]

CVE-2022-49298: staging: rtl8712: fix uninit-value in r871xu_drv_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49298-bc33@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [a6535d00a9d54ce1c2a8d86a85001ffb6844f9b2]
cip/4.4-st: [d71fdb3420778b37a67f276a0bde8c68433e366b]
mainline: [0458e5428e5e959d201a40ffe71d762a79ecedc4]
stable/4.19: [a6535d00a9d54ce1c2a8d86a85001ffb6844f9b2]
stable/5.10: [ff727ab0b7d7a56b5ef281f12abd00c4b85894e9]
stable/5.15: [f36e754a1f0bafb9feeea63463de78080acb6de0]
stable/5.4: [52a0d88c328098b4e9fb8f2f3877fec0eff4104b]

CVE-2022-49299: usb: dwc2: gadget: don't reset gadget's driver->bus

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49299-6304@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [bee8f9808a7e82addfc73a0973b16a8bb684205b]
cip/4.4-st: [d13c7728d67657763a6e6de24f6a53f6001c9087]
mainline: [3120aac6d0ecd9accf56894aeac0e265f74d3d5a]
stable/4.19: [bee8f9808a7e82addfc73a0973b16a8bb684205b]
stable/5.10: [5b0c0298f7c3b57417f1729ec4071f76864b72dd]
stable/5.15: [547ebdc200b862dff761ff4890f66d8217c33316]
stable/5.4: [d232ca0bbc7d03144bad0ffd1792c3352bfd03fa]

CVE-2022-49300: nbd: fix race between nbd_alloc_config() and module removal

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49300-a91a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [2573f2375b64280be977431701ed5d33b75b9ad0]
mainline: [c55b2b983b0fa012942c3eb16384b2b722caa810]
stable/4.19: [2573f2375b64280be977431701ed5d33b75b9ad0]
stable/5.10: [122e4adaff2439f1cc18cc7e931980fa7560df5c]
stable/5.15: [71c142f910da44421213ade601bcbd23ceae19fa]
stable/5.4: [8a7da4ced236ce6637fe70f14ca18e718d4bf9e9]

CVE-2022-49301: staging: rtl8712: fix uninit-value in usb_read8() and friends

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49301-a631@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [d1b57669732d09da7e13ef86d058dab0cd57f6e0]
stable/5.10: [33ef21d55418ab6a62a63fd550b2dbe297433372]
stable/5.15: [95b0f54f8a898072a2810c05fab34d971f23a612]
stable/5.4: [58762f1c63c75cbe1dc393eed3c9cf8e38310ca1]

CVE-2022-49302: USB: host: isp116x: check return value after calling
platform_get_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49302-fd6c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [3825db88d8c704e7992b685618a03f82bffcf2ef]
cip/4.4-st: [7ed1b652762b7ffcda706466d56985b839839eb5]
mainline: [134a3408c2d3f7e23eb0e4556e0a2d9f36c2614e]
stable/4.19: [3825db88d8c704e7992b685618a03f82bffcf2ef]
stable/5.10: [ee105039d3653444de4d3ede642383c92855dc1e]
stable/5.15: [3592cfd8b848bf0c4d7740d78a87a7b8f6e1fa9a]
stable/5.4: [c91a74b1f0f2d2d7e728742ae55e3ffe9ba7853d]

CVE-2022-49303: drivers: staging: rtl8192eu: Fix deadlock in
rtw_joinbss_event_prehandle

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49303-58f0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [0fcddf9c7c10202946d5b19409efbdff744fba88]

CVE-2022-49304: drivers: tty: serial: Fix deadlock in sa1100_set_termios()

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49304-db99@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [920f0ae7a129ffee98a106e3bbdfd61a2a59e939]
cip/4.4-st: [9088aeddfbee4ad73b0048cb80dd361731280c6f]
mainline: [62b2caef400c1738b6d22f636c628d9f85cd4c4c]
stable/4.19: [920f0ae7a129ffee98a106e3bbdfd61a2a59e939]
stable/5.10: [6e2273eefab54a521d9c59efb6e1114e742bdf41]
stable/5.15: [2cbfc38df580bff5b2fe19f21c1a7520efcc4b3b]
stable/5.4: [09a5958a2452ad22d0cb638711ef34ea1863a829]

CVE-2022-49305: drivers: staging: rtl8192u: Fix deadlock in
ieee80211_beacons_stop()

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2022-49305-9a46@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [b465bb2ebf666116c1ac745cb80c65154dc0d27e]
mainline: [806c7b53414934ba2a39449b31fd1a038e500273]
stable/4.19: [b465bb2ebf666116c1ac745cb80c65154dc0d27e]
stable/5.10: [66f769762f65d957f688f3258755c6ec410bf710]
stable/5.15: [042915c1bfedd684c1d98a841794ee203200571a]
stable/5.4: [1fbe033c52480f7954c057510040fa6286c4ea25]

CVE-2022-49306: usb: dwc3: host: Stop setting the ACPI companion

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2022-49306-a115@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
Introduced by 11c3980 ("usb: dwc3: Add ACPI support for xHCI ports") in 5.7-rc1.

Fixed status
mainline: [7fd069d65da2e20b1caec3b7bcf9dfbe28c04bb2]

CVE-2022-49307: tty: synclink_gt: Fix null-pointer-dereference in slgt_clean()

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2022-49307-246e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [ba08cbc5b53e151d0acf1930fb526fc65b7f3e65]
cip/4.4-st: [a76df32dec41ccda060a593d659372c9187e45d9]
mainline: [689ca31c542687709ba21ec2195c1fbce34fd029]
stable/4.19: [ba08cbc5b53e151d0acf1930fb526fc65b7f3e65]
stable/5.10: [d68d5e68b7f64de7170f8e04dd9b995c36b2c71c]
stable/5.15: [8a95696bdc0e13f8980f05b54a3b9081963d1256]
stable/5.4: [f6e07eb7ebec53ffe81fc2489589320fbe4a6b75]

CVE-2022-49308: extcon: Modify extcon device to be created after
driver data is set

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2022-49308-23f0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [cb81ea998c461868d1168411a867d8ffee12f23f]
mainline: [5dcc2afe716d69f5112ce035cb14f007461ff189]
stable/4.19: [cb81ea998c461868d1168411a867d8ffee12f23f]
stable/5.10: [abf3b222614f49f98e606fccdd269161c0d70204]
stable/5.15: [368e68ad6da4317fc4170e8d92b51c13d1bfe7a7]
stable/5.4: [d472c78cc82999d07bd09193a6718016ce9cd386]

CVE-2022-49309: drivers: staging: rtl8723bs: Fix deadlock in
rtw_surveydone_event_callback()

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2022-49309-582d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
It seems as if this bug was introduced by commit 554c0a3a ("staging:
Add rtl8723bs
sdio wifi driver") in 4.12-rc1.

Fixed status
mainline: [cc7ad0d77b51c872d629bcd98aea463a3c4109e7]
stable/5.15: [f89f6c3ebf69623b8ea48200bd690e9e210335a1]

CVE-2022-49310: char: xillybus: fix a refcount leak in cleanup_dev()

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2022-49310-d185@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
It seems as if this bug was intrdocued by a53d1202 ("char: xillybus: Add driver
for XillyUSB (Xillybus variant for USB)") in 5.14-rc1.

Fixed status
mainline: [b67d19662fdee275c479d21853bc1239600a798f]
stable/5.15: [bc8fceda3b89006e8a7dda8a097d36045d044c25]

CVE-2022-49311: drivers: staging: rtl8192bs: Fix deadlock in
rtw_joinbss_event_prehandle()

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2022-49311-fe0f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
Affected file was added by commit 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in 4.12-rc1.

Fixed status
mainline: [041879b12ddb0c6c83ed9c0bdd10dc82a056f2fc]
stable/5.15: [ae60744d5fad840b9d056d35b4b652d95e755846]

CVE-2022-49312: staging: rtl8712: fix a potential memory leak in
r871xu_drv_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2022-49312-6cea@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [7288ff561de650d4139fab80e9cb0da9b5b32434]
stable/5.10: [5a89a92efc342dd7c44b6056da87debc598f9c73]
stable/5.15: [8eb42d6d10f8fe509117859defddf9e72b4fa4d0]

CVE-2022-49313: drivers: usb: host: Fix deadlock in oxu_bus_suspend()

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2022-49313-06e5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [f8242044c91cafbba9e320b0fb31abf2429a3221]
cip/4.4-st: [e8234fda96b7d6ca5ec025656d3364a7113cfd35]
mainline: [4d378f2ae58138d4c55684e1d274e7dd94aa6524]
stable/4.19: [f8242044c91cafbba9e320b0fb31abf2429a3221]
stable/5.10: [ffe9440d698274c6462d2e304562c6ddfc8c84df]
stable/5.15: [d888753872190abd18f68a7d77b9c7c367f0a7ab]
stable/5.4: [2dcec0bc142be2096af71a5703d63237127db204]

CVE-2022-49314: tty: Fix a possible resource leak in icom_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2022-49314-beeb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [a2df0b4d080cc770b4da7bff487048c803dfd07e]
cip/4.4-st: [9ba0b3ee6a3145687e22cc0f5be0b5635ce88d8e]
mainline: [ee157a79e7c82b01ae4c25de0ac75899801f322c]
stable/4.19: [a2df0b4d080cc770b4da7bff487048c803dfd07e]
stable/5.10: [cb7147afd328c07edeeee287710d8d96ac0459f5]
stable/5.15: [5f9b2e4ca88cab1a96b86ecd45544e488ca43faf]
stable/5.4: [8c014373f178a4f13a08e045ef63bdb23f62e892]

CVE-2022-49315: drivers: staging: rtl8192e: Fix deadlock in
rtllib_beacons_stop()

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2022-49315-4e45@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [08bacf871c019163ccd1389d0bc957a43324967a]
cip/4.4-st: [2fbbbdb592f89cc2664bacba238a4ce66dd1aa3d]
mainline: [9b6bdbd9337de3917945847bde262a34a87a6303]
stable/4.19: [08bacf871c019163ccd1389d0bc957a43324967a]
stable/5.10: [0f69d7d5e918aa43423d86bd17ddb11b1b5e8ada]
stable/5.15: [fef451f0fbbe85dbd2962b18379d02e2965610db]
stable/5.4: [64b05fa212c7e4d057676e8b7e7120c6eb2f615b]

CVE-2022-49316: NFSv4: Don't hold the layoutget locks across multiple RPC calls

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2022-49316-3e10@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [6b3fc1496e7227cd6a39a80bbfb7588ef7c7a010]
mainline: [6949493884fe88500de4af182588e071cf1544ee]
stable/4.19: [6b3fc1496e7227cd6a39a80bbfb7588ef7c7a010]
stable/5.10: [0ee5b9644f06b4d3cdcd9544f43f63312e425a4c]
stable/5.15: [d4c2a041ed3ba114502d5ed6ace5b1a48d637a8e]
stable/5.4: [a2b3be930e79cc5d9d829f158e31172b2043f0cd]

CVE-2022-49317: f2fs: avoid infinite loop to flush node pages

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2022-49317-0b90@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [a7b8618aa2f0f926ce85f2486ac835a85c753ca7]

CVE-2022-49318: f2fs: remove WARN_ON in f2fs_is_valid_blkaddr

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2022-49318-732e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [dc2f78e2d4cc844a1458653d57ce1b54d4a29f21]
stable/5.10: [32bea51fe4c6e92c00403739f7547c89219bea88]
stable/5.15: [99c09b298e47ebbe345a6da9f268b32a6b0f4582]
stable/5.4: [0a7a1fc7e71eecf2e5053a6c312c9f0dcbb9b8fd]

CVE-2022-49319: iommu/arm-smmu-v3: check return value after calling
platform_get_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2022-49319-f0b3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
It seems as if this bug was introduced by commit 48ec83bc ("iommu/arm-smmu:
Add initial driver support for ARM SMMUv3 devices") in 4.2-rc1.

Fixed status
mainline: [b131fa8c1d2afd05d0b7598621114674289c2fbb]
stable/5.10: [54c1e0e3bbcab2abe25b2874a43050ae5df87831]
stable/5.15: [fb0f1c5eb8d60b3e018ba7c87da249b52674ebe6]

CVE-2022-49320: dmaengine: zynqmp_dma: In struct zynqmp_dma_chan fix
desc_size data type

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2022-49320-c76e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [f9a9f43a62a04ec3183fb0da9226c7706eed0115]
stable/5.10: [95a0ba85c1b51b36e909841c02d205cd223ab753]
stable/5.15: [7b5488f4721fed6e121e661e165bab06ae2f8675]
stable/5.4: [83960276ffc9bf5570d4106490346b61e61be5f3]

CVE-2022-49321: xprtrdma: treat all calls not a bcall when bc_serv is NULL

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2022-49321-6cf0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [998d35a2aff4b81a1c784f3aa45cd3afff6814c1]
mainline: [11270e7ca268e8d61b5d9e5c3a54bd1550642c9c]
stable/4.19: [998d35a2aff4b81a1c784f3aa45cd3afff6814c1]
stable/5.10: [8dbae5affbdbf524b48000f9d357925bb001e5f4]
stable/5.15: [a3fc8051ee061e31db13e2fe011e8e0b71a7f815]
stable/5.4: [da99331fa62131a38a0947a8204c5208de7b0454]

CVE-2022-49322: tracing: Fix sleeping function called from invalid
context on RT kernel

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2022-49322-b0f0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
Affected function was added by 4239174 ("tracing: Make
tracepoint_printk a static_key") in 4.10-rc1.

Fixed status
cip/4.19-st: [40f9fde06b25884baa0c4bd138b909a9b67218b4]
mainline: [12025abdc8539ed9d5014e2d647a3fd1bd3de5cd]
stable/4.19: [40f9fde06b25884baa0c4bd138b909a9b67218b4]
stable/5.10: [1788e6dbb61286215442b1af99e51405a6206762]
stable/5.15: [9b534640a2c6a8d88168febc82ec6d161184f2ec]
stable/5.4: [48c6ee7d6c614f09b2c8553a95eefef6ecf196e0]

CVE-2022-49323: iommu/arm-smmu: fix possible null-ptr-deref in
arm_smmu_device_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2022-49323-7559@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [d9ed8af1dee37f181096631fb03729ece98ba816]
stable/5.10: [3660db29b0305f9a1d95979c7af0f5db6ea99f5d]
stable/5.15: [98dd53a92825747395649f54d23512a13c3ed471]

CVE-2022-49324: mips: cpc: Fix refcount leak in mips_cpc_default_phys_base

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2022-49324-2bbc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [961ee8a6eeef4632a215d995d837b204f8c7c2d4]
mainline: [4107fa700f314592850e2c64608f6ede4c077476]
stable/4.19: [961ee8a6eeef4632a215d995d837b204f8c7c2d4]
stable/5.10: [c667b3872a4c435a3f29d4e15971cd8c378b0043]
stable/5.15: [1699ec1bfb59304a788901474f6bb003f7831b61]
stable/5.4: [cc0aed22d33ced9e266c50bdf1cbe668c5acfdf8]

CVE-2022-49325: tcp: add accessors to read/set tp->snd_cwnd

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2022-49325-a2ac@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [40570375356c874b1578e05c1dcc3ff7c1322dbe]
stable/5.15: [3308676ec525901bf1656014003c443a60730a04]

CVE-2022-49326: rtl818x: Prevent using not initialized queues

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2022-49326-7834@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [9d5e96cc1f1720019ce27b127a31695148d38bb0]
cip/4.4-st: [279e5dc7dc61716c287610ab54143fb02b1c7d9c]
mainline: [746285cf81dc19502ab238249d75f5990bd2d231]
stable/4.19: [9d5e96cc1f1720019ce27b127a31695148d38bb0]
stable/5.10: [769ec2a824deae2f1268dfda14999a4d14d0d0c5]
stable/5.15: [6ad81ad0cf5744738ce94c8e64051ddd80a1734c]
stable/5.4: [b8ce58ab80faaea015c206382041ff3bcf5495ff]

CVE-2022-49327: bcache: avoid journal no-space deadlock by reserving 1
journal bucket

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2022-49327-6356@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [32feee36c30ea06e38ccb8ae6e5c44c6eec790a6]
stable/5.10: [59afd4f287900c8187e968a4153ed35e6b48efce]
stable/5.15: [5607652823ac65e2c6885e73bd46d5a4f9a20363]

CVE-2022-49328: mt76: fix use-after-free by removing a non-RCU wcid pointer

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2022-49328-ec2f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [51fb1278aa57ae0fc54adaa786e1965362bed4fb]
stable/5.15: [4448327b41738dbfcda680eb4935ff835568f468]

CVE-2022-49329: vduse: Fix NULL pointer dereference on sysfs access

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2022-49329-ed73@gregkh/

Introduced by commit c8a6153 ("vduse: Introduce VDUSE - vDPA Device in
Userspace") in v5.15-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b27ee76c74dc831d6e092eaebc2dfc9c0beed1c9]
stable/5.15: [3a7a81f4835dfda11f39fdd27586da14331896eb]

CVE-2022-49330: tcp: fix tcp_mtup_probe_success vs wrong snd_cwnd

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2022-49330-199b@gregkh/

Introduced by commit 5d424d5 ("[TCP]: MTU probing") in v2.6.20.16.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f2845e1504a3bc4f3381394f057e8b63cb5f3f7a]
cip/4.4-st: [82ae2b380f4c3b0e5af8f3292386fcd952d87f5b]
mainline: [11825765291a93d8e7f44230da67b9f607c777bf]
stable/4.19: [f2845e1504a3bc4f3381394f057e8b63cb5f3f7a]
stable/5.10: [9ba2b4ac35935f05ac98cff722f36ba07d62270e]
stable/5.15: [90385f2b65d0cd2b3b1ac8909f0cc6dd31062cfc]
stable/5.4: [602b338e3c3cd7f935f3f5011882961d074e5ac1]

CVE-2022-49331: nfc: st21nfca: fix memory leaks in EVT_TRANSACTION handling

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2022-49331-f86f@gregkh/

Introduced by commit 26fc6c7 ("NFC: st21nfca: Add HCI transaction
event support") in v4.0-rc1.
Introduced by commit 4fbcc1a ("nfc: st21nfca: Fix potential buffer
overflows in EVT_TRANSACTION") in v5.17-rc1.
Fixed in v5.19-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [6fce324b530dd74750ad870699e33eeed1029ded]
cip/4.4-st: [03813d9b5e9663fa7fb2390ddd85624c164c19b6]
mainline: [996419e0594abb311fb958553809f24f38e7abbe]
stable/4.19: [6fce324b530dd74750ad870699e33eeed1029ded]
stable/5.10: [54423649bc0ed464b75807a7cf2857a5871f738f]
stable/5.15: [f444ecd3f57f4ba5090fe8b6756933e37de4226e]
stable/5.4: [3eca2c42daa4659965db6817479027cbc6df7899]

CVE-2022-49332: scsi: lpfc: Address NULL pointer dereference after
starget_to_rport()

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2022-49332-ecf5@gregkh/

Introduced by commit bb21fc9 ("scsi: lpfc: Use fc_block_rport()") in v5.18-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f808bd78e8296b4ded813b7182988d57e1f6176]

CVE-2022-49333: net/mlx5: E-Switch, pair only capable devices

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2022-49333-8ae3@gregkh/

Introduced by commit dd3fddb ("net/mlx5: E-Switch, handle devcom
events only for ports on the same device") in v5.14-rc4.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3008e6a0049361e731b803c60fe8f3ab44e1d73f]

CVE-2022-49334: mm/huge_memory: Fix xarray node memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2022-49334-7f6b@gregkh/

Introduced by commit 6b24ca4 ("mm: Use multi-index entries in the page
cache") in v5.17-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69a37a8ba1b408a1c7616494aa7018e4b3844cbe]

CVE-2022-49335: drm/amdgpu/cs: make commands with 0 chunks illegal behaviour.

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2022-49335-ae62@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [15c3bcc9b5349d40207e5f8d4d799b8b4b7d13b8]
cip/4.4-st: [3ffdc45822b358e54801f678f2d6e832051dd1b8]
mainline: [31ab27b14daaa75541a415c6794d6f3567fea44a]
stable/4.19: [15c3bcc9b5349d40207e5f8d4d799b8b4b7d13b8]
stable/5.10: [be585921f29df5422a39c952d188b418ad48ffab]
stable/5.15: [70276460e914d560e96bfc208695a872fe9469c9]
stable/5.4: [c12984cdb077b9042d2dc20ca18cb16a87bcc774]

CVE-2022-49336: drm/etnaviv: check for reaped mapping in etnaviv_iommu_unmap_gem

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2022-49336-bc56@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
Affected file was added by commit a8c21a5 ("drm/etnaviv: add initial
etnaviv DRM driver") in 4.5-rc1.

Fixed status
mainline: [e168c25526cd0368af098095c2ded4a008007e1b]
stable/5.10: [436cff507f2a41230baacc3e2ef1d3b2d2653f40]
stable/5.15: [03bd455a79f69d97fee3e3b212ab754442f10e5c]
stable/5.4: [19323b3671a85788569d15685c8f83a05ec48cbb]

CVE-2022-49337: ocfs2: dlmfs: fix error handling of user_dlm_destroy_lock

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2022-49337-d06a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [733a35c00ef363a1c774d7ea486e0735b7c13a15]
cip/4.4-st: [7d9645da346e9db862d5ba6178c74b0b6d4c6429]
mainline: [863e0d81b6683c4cbc588ad831f560c90e494bef]
stable/4.19: [733a35c00ef363a1c774d7ea486e0735b7c13a15]
stable/5.10: [337e36550788dbe03254f0593a231c1c4873b20d]
stable/5.15: [9c96238fac045b289993d7bc5aae7b2d72b25c76]
stable/5.4: [82bf8e7271fade40184177cb406203addc34c4a0]

CVE-2022-49338: net/mlx5e: CT: Fix cleanup of CT before cleanup of TC ct rules

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2022-49338-fe26@gregkh/

Introduced by commit d1a3138 ("net/mlx5e: TC, Move flow hashtable to
be per rep") in v5.18-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15ef9efa855cf405fadd78272e1e5d04e09a1cf3]

CVE-2022-49339: net: ipv6: unexport __init-annotated seg6_hmac_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2022-49339-8220@gregkh/

Introduced by commit bf355b8 ("ipv6: sr: add core files for SR HMAC
support") in v4.10-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ab8b2c2de273ec1d698a18e399896a6febb5cda0]
mainline: [5801f064e35181c71857a80ff18af4dbec3c5f5c]
stable/4.19: [ab8b2c2de273ec1d698a18e399896a6febb5cda0]
stable/5.10: [5d9c1b081ad28c852a97e10dd75412546497694a]
stable/5.15: [1084716f76c8045eadf92a9d9a62641f3c8d8c90]
stable/5.4: [317260b3eb6384a05a8af212308fa50f3b2e8290]

CVE-2022-49340: ip_gre: test csum_start instead of transport header

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2022-49340-419b@gregkh/

Introduced by commit 8a0ed25 ("ip_gre: validate csum_start only on
pull") in v5.15-rc1.
Fixed in v5.19-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [7596bd7920985f7fc8579a92e48bc53ce4475b21]
mainline: [8d21e9963bec1aad2280cdd034c8993033ef2948]
stable/4.19: [7596bd7920985f7fc8579a92e48bc53ce4475b21]
stable/5.10: [fbeb8dfa8b87ef259eef0c89e39b53962a3cf604]
stable/5.15: [e6b6f98fc7605c06c0a3baa70f62c534d7b4ce58]
stable/5.4: [3d08bc3a5d9b2106f5c8bcf1adb73147824aa006]

CVE-2022-49341: bpf, arm64: Clear prog->jited_len along prog->jited

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2022-49341-b0e9@gregkh/

Introduced by commit db49694 ("bpf: arm64: add JIT support for
multi-function programs") in v4.16-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [aaf61a312af63e1cfe2264c4c5b8cd4ea3626025]
mainline: [10f3b29c65bb2fe0d47c2945cd0b4087be1c5218]
stable/4.19: [aaf61a312af63e1cfe2264c4c5b8cd4ea3626025]
stable/5.10: [0cf7aaff290cdc4d7cee683d4a18138b0dacac48]
stable/5.15: [3f4d5e727aeaa610688d46c9f101f78b7f712583]
stable/5.4: [e412b3d178ea4bf746f6b8ee086761613704c6be]

CVE-2022-49342: net: ethernet: bgmac: Fix refcount leak in
bcma_mdio_mii_register

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2022-49342-1ad0@gregkh/

Introduced by commit 55954f3 ("net: ethernet: bgmac: move BCMA MDIO
Phy code into a separate file") in v4.8-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8d91399775c55162073bb2aca061ec42e3d4bc1]

CVE-2022-49343: ext4: avoid cycles in directory h-tree

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2022-49343-bddc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [b3ad9ff6f06c1dc6abf7437691c88ca3d6da3ac0]
mainline: [3ba733f879c2a88910744647e41edeefbc0d92b2]
stable/4.19: [b3ad9ff6f06c1dc6abf7437691c88ca3d6da3ac0]
stable/5.10: [ff4cafa51762da3824881a9000ca421d4b78b138]
stable/5.15: [3a3ce941645407cd0b0b7f01ad9e2ea3770f46cc]
stable/5.4: [e157c8f87e8fac112d6c955e69a60cdb9bc80a60]

CVE-2022-49344: af_unix: Fix a data-race in unix_dgram_peer_wake_me().

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2022-49344-2b3a@gregkh/

Introduced by commit 7d26727 ("unix: avoid use-after-free in
ep_remove_wait_queue") in v4.4-rc4.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [95f0ba806277733bf6024e23e27e1be773701cca]
mainline: [662a80946ce13633ae90a55379f1346c10f0c432]
stable/4.19: [95f0ba806277733bf6024e23e27e1be773701cca]
stable/5.10: [c61848500a3fd6867dfa4834b8c7f97133eceb9f]
stable/5.15: [c926ae58f24f7bd55aa2ea4add9f952032507913]
stable/5.4: [556720013c36c193d9cbfb06e7b33e51f0c39fbf]

CVE-2022-49345: net: xfrm: unexport __init-annotated xfrm4_protocol_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2022-49345-5c80@gregkh/

Introduced by commit 2f32b51 ("xfrm: Introduce xfrm_input_afinfo to
access the the callbacks properly") in v3.15-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [31f3c6a4dcd3260a386e62cef2d5b36e902600a1]
cip/4.4-st: [2e3d10c1c0be428032496d822555a3b9d027f3dc]
mainline: [4a388f08d8784af48f352193d2b72aaf167a57a1]
stable/4.19: [31f3c6a4dcd3260a386e62cef2d5b36e902600a1]
stable/5.10: [be3884d5cd04ccd58294b83a02d70b7c5fca19d3]
stable/5.15: [85a055c03691e51499123194a14a0c249cf33227]
stable/5.4: [ef6d2354de238b065d8799c80da4be9a6af18e39]

CVE-2022-49346: net: dsa: lantiq_gswip: Fix refcount leak in gswip_gphy_fw_list

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2022-49346-4f13@gregkh/

Introduced by commit 14fceff ("net: dsa: Add Lantiq / Intel DSA driver
for vrx200") in v4.20-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0737e018a05e2aa352828c52bdeed3b02cff2930]
stable/5.10: [c2ae49a113a5344232f1ebb93bcf18bbd11e9c39]
stable/5.15: [54d6802c4d83fa8de7696cfec06f475d5fd92d27]
stable/5.4: [7c8df6fad43d9d5d77f281f794b2a93cd02fd1a9]

CVE-2022-49347: ext4: fix bug_on in ext4_writepages

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2022-49347-6ba6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [de1732b5c1693ad489c5d254f124f67cb775f37d]
cip/4.4-st: [7bf550365de8a378b2d3ddbe9a8f81cd99fde57a]
mainline: [ef09ed5d37b84d18562b30cf7253e57062d0db05]
stable/4.19: [de1732b5c1693ad489c5d254f124f67cb775f37d]
stable/5.10: [1b061af037646c9cdb0afd8a8d2f1e1c06285866]
stable/5.15: [18a759f7f99f0b65a08ff5b7e745fc405a42bde4]
stable/5.4: [73fd5b19285197078ee8a2e651d75d5b094a4de9]

CVE-2022-49348: ext4: filter out EXT4_FC_REPLAY from on-disk
superblock field s_state

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2022-49348-d5db@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
It seems as if this bug was introduced by commit ac27a0e ("[PATCH]
ext4: initial copy of files from ext3") in 2.6.19-rc2.

Fixed status
mainline: [c878bea3c9d724ddfa05a813f30de3d25a0ba83f]
stable/5.10: [cc5b09cb6dacd4b32640537929ab4ee8fb2b9e04]
stable/5.15: [b99fd73418350dea360da8311e87a6a7b0e15a4c]

CVE-2022-49349: ext4: fix use-after-free in ext4_rename_dir_prepare

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2022-49349-a7f6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [10801095224de0d0ab06ae60698680c1f883a3ae]
mainline: [0be698ecbe4471fcad80e81ec6a05001421041b3]
stable/4.19: [10801095224de0d0ab06ae60698680c1f883a3ae]
stable/5.10: [dd887f83ea54aea5b780a84527e23ab95f777fed]
stable/5.15: [364380c00912bed9b5d99eb485018360b0ecf64f]
stable/5.4: [eaecf7ebfd5dd09038a80b14be46b844f54cfc5c]

CVE-2022-49350: net: mdio: unexport __init-annotated mdio_bus_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2022-49350-c5d2@gregkh/

Introduced by commit 90eff90 ("net: phy: Allow splitting MDIO
bus/device support from PHYs") in v4.12-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5534bcd7c40299862237c4a8fd9c5031b3db1538]
mainline: [35b42dce619701f1300fb8498dae82c9bb1f0263]
stable/4.19: [5534bcd7c40299862237c4a8fd9c5031b3db1538]
stable/5.10: [7759c3222815b945a94b212bc0c6cdec475cfec2]
stable/5.15: [59fa94cddf9eef8d8dae587373eed8b8f4eb11d7]
stable/5.4: [6a90a44d53428a3bf01bd80df9ba78b19959270c]

CVE-2022-49351: net: altera: Fix refcount leak in altera_tse_mdio_create

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2022-49351-b85d@gregkh/

Introduced by commit bbd2190 ("Altera TSE: Add main and header file
for Altera Ethernet Driver") in v3.15-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5cd0e22fa11f4a21a8c09cc258f20b1474c95801]
cip/4.4-st: [42b29975de7ac442cede395f8659551b8998df08]
mainline: [11ec18b1d8d92b9df307d31950dcba0b3dd7283c]
stable/4.19: [5cd0e22fa11f4a21a8c09cc258f20b1474c95801]
stable/5.10: [96bf5ed057df2d157274d4e2079002f9a9404bb8]
stable/5.15: [e31d9ba169860687dba19bdc8fccbfd34077f655]
stable/5.4: [8174acbef87b8dd8bf3731eba2a5af1ac857e239]

CVE-2022-49352: ext4: fix warning in ext4_handle_inode_extension

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2022-49352-f7cf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [f4534c9fc94d22383f187b9409abb3f9df2e3db3]
stable/5.10: [adf490083ca52ebfb0b2fe64ff1ead00c0452dd7]
stable/5.15: [b81d2ff6885e38fc745eeaf9565775055778fc0b]
stable/5.4: [0ab308d72af7548f21e4499d025c25887da0c26a]

CVE-2022-49353: powerpc/papr_scm: don't requests stats with '0' sized
stats buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2022-49353-8599@gregkh/


Introduced by commit 0e0946e2 in 5.19-rc1. Fixed in 5.19-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07bf9431b1590d1cd7a8d62075d0b50b073f0495]

CVE-2022-49354: ata: pata_octeon_cf: Fix refcount leak in octeon_cf_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2022-49354-9be3@gregkh/

Introduced by commit 43f01da ("MIPS/OCTEON/ata: Convert
pata_octeon_cf.c to use device tree.") in v3.8-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8d8ad067b90f231b8fdb14acee673ca4012f6045]
cip/4.4-st: [8e998d6192271b0863ed015abaed0eeddcce1959]
mainline: [10d6bdf532902be1d8aa5900b3c03c5671612aa2]
stable/4.19: [8d8ad067b90f231b8fdb14acee673ca4012f6045]
stable/5.10: [19cb3ece14547cb1ca2021798aaf49a3f82643d1]
stable/5.15: [888312dc297a8a103f6371ef668c7e04f57a7679]
stable/5.4: [d5a1e7f33c88780b279835d63665d7e38ccb671f]

CVE-2022-49356: SUNRPC: Trap RDMA segment overflows

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2022-49356-6195@gregkh/

Introduced by commit 7a1cbfa ("svcrdma: Use parsed chunk lists to
construct RDMA Writes") in v5.11-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f012e95b377c73c0283f009823c633104dedb337]
stable/5.15: [ea26bf5eca1459b5a7824997d7823409ce38214e]

CVE-2022-49357: efi: Do not import certificates from UEFI Secure Boot
for T2 Macs

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2022-49357-9dc8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [155ca952c7ca19aa32ecfb7373a32bbc2e1ec6eb]
stable/5.10: [c072cab98bac11f6ef9db640fb51834d9552e2e6]
stable/5.15: [65237307f88f5200782ae7f243bdd385e37cde5d]
stable/5.4: [b1cda6dd2c44771f042d65f0d17bec322ef99a0a]

CVE-2022-49358: netfilter: nf_tables: memleak flow rule from commit path

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2022-49358-6cfd@gregkh/

Introduced by commit c9626a2 ("netfilter: nf_tables: add hardware
offload support") in v5.3-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9dd732e0bdf538b1b76dc7c157e2b5e560ff30d3]
stable/5.10: [330c0c6cd2150a2d7f47af16aa590078b0d2f736]
stable/5.15: [e33d9bd563e71f6c6528b96008d65524a459c4dc]
stable/5.4: [5b8d63489c3b701eb2a76f848ec94d8cbc9373b9]

CVE-2022-49359: drm/panfrost: Job should reference MMU not file_priv

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2022-49359-f054@gregkh/

Introduced by commit 7fdc48c ("drm/panfrost: Make sure MMU context
lifetime is not bound to panfrost_priv") in v5.15-rc1.
Fixed in v5.19-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [6e516faf04317db2c46cbec4e3b78b4653a5b109]

CVE-2022-49360: f2fs: fix to do sanity check on total_data_blocks

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2022-49360-b0ac@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [6b8beca0edd32075a769bfe4178ca00c0dcd22a9]
stable/5.10: [ef221b738b26d8c9f7e7967f4586db2dd3bd5288]
stable/5.15: [c9e4cd5b0ccd7168801d6a811919171b185c5cf8]

CVE-2022-49361: f2fs: fix to do sanity check for inline inode

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2022-49361-40d7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [677a82b44ebf263d4f9a0cfbd576a6ade797a07b]
stable/5.10: [efdefbe8b7564602ab446474788225a1f2a323b5]
stable/5.15: [7cfe2d43becaf76e562b9617d2c2d9b445f86761]

CVE-2022-49362: NFSD: Fix potential use-after-free in nfsd_file_put()

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2022-49362-3299@gregkh/

Introduced by commit 9993979 ("nfsd: Clean up nfsd_file_put()") in v5.18-rc3.
Fixed in v5.15.154.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [261eabe19cb28e4a8587a4442d257b543d7c2d57]
stable/5.10: [ada1757b259f353cade47037ee0a0249b4cddad3]

CVE-2022-49363: f2fs: fix to do sanity check on block address in
f2fs_do_zero_range()

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2022-49363-a93a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [25f8236213a91efdf708b9d77e9e51b6fc3e141c]
stable/5.10: [a34d7b49894b0533222188a52e2958750f830efd]
stable/5.15: [f2e1c38b5ac64eb1a16a89c52fb419409d12c25b]
stable/5.4: [7361c9f2bd6a8f0cbb41cdea9aff04765ff23f67]

CVE-2022-49364: f2fs: fix to clear dirty inode in f2fs_evict_inode()

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2022-49364-29dc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [f2db71053dc0409fae785096ad19cce4c8a95af7]
stable/5.10: [ccd58045beb997544b94558a9156be4742628491]
stable/5.15: [c9196d21359be8c7ee231029d13682273925fd00]
stable/5.4: [54c116615c99e22aa08aa950757ed726e2f60821]

CVE-2022-49365: drm/amdgpu: Off by one in dm_dmub_outbox1_low_irq()

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2022-49365-37e7@gregkh/

Introduced by commit e27c41d ("drm/amd/display: Support for DMUB HPD
interrupt handling") in v5.16-rc1.
Fixed in v5.18.4.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [607c5cd1a08e196d9f2bd3b25a8083ed27ad7ceb]

CVE-2022-49366: ksmbd: fix reference count leak in smb_check_perm_dacl()

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2022-49366-d901@gregkh/

Introduced by commit 777cad1 ("ksmbd: remove select FS_POSIX_ACL in
Kconfig") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d21a580dafc69aa04f46e6099616146a536b0724]
stable/5.15: [cf824b95c12a1abacadbc2d069931963221a3414]

CVE-2022-49367: net: dsa: mv88e6xxx: Fix refcount leak in
mv88e6xxx_mdios_register

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2022-49367-3b2e@gregkh/

Introduced by commit a3c53be ("net: dsa: mv88e6xxx: Support multiple
MDIO busses") in v4.11-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [86c3c5f8e4bd1325e24f6fba9017cade29933377]
mainline: [02ded5a173619b11728b8bf75a3fd995a2c1ff28]
stable/4.19: [86c3c5f8e4bd1325e24f6fba9017cade29933377]
stable/5.10: [42658e47f1abbbe592007d3ba303de466114d0bb]
stable/5.15: [c1df9cb756e5a9ba1841648c44ee5d92306b9c65]
stable/5.4: [a101793994c0a14c70bb4e44c7fda597eeebba0a]

CVE-2022-49368: net: ethernet: mtk_eth_soc: out of bounds read in
mtk_hwlro_get_fdir_entry()

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2022-49368-d1d6@gregkh/

Introduced by commit 7aab747 ("net: ethernet: mediatek: add ethtool
functions to configure RX flows of HW LRO") in v4.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [657e7174603f0aab2cdedc64ac81edffd2a87afe]
mainline: [e7e7104e2d5ddf3806a28695670f21bef471f1e1]
stable/4.19: [657e7174603f0aab2cdedc64ac81edffd2a87afe]
stable/5.10: [71ae30662ec610b92644d13f79c78f76f17873b3]
stable/5.15: [b24ca1cf846273361d5bd73a35de95a486a54b6d]
stable/5.4: [2bd1faedb74dc2a2be3972abcd4239b75a3e7b00]

CVE-2022-49369: amt: fix possible memory leak in amt_rcv()

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2022-49369-9a4e@gregkh/

Introduced by commit cbc21dc ("amt: add data plane of amt interface")
in v5.16-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a1a0e80e005cbdc2c250fc858e1d8570f4e4acb]

CVE-2022-49370: firmware: dmi-sysfs: Fix memory leak in
dmi_sysfs_register_handle

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2022-49370-05fc@gregkh/

Introduced by commit 948af1f ("firmware: Basic dmi-sysfs support") in
v2.6.39-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c66cc3c62870a27ea8f060a7e4c1ad8d26dd3f0d]
cip/4.4-st: [782073562b1328646967e9cdd22764d095cc50e3]
mainline: [660ba678f9998aca6db74f2dd912fa5124f0fa31]
stable/4.19: [c66cc3c62870a27ea8f060a7e4c1ad8d26dd3f0d]
stable/5.10: [985706bd3bbeffc8737bc05965ca8d24837bc7db]
stable/5.15: [fdffa4ad8f6bf1ece877edfb807f2b2c729d8578]
stable/5.4: [a724634b2a49f6ff0177a9e19a5a92fc1545e1b7]

CVE-2022-49371: driver core: fix deadlock in __device_attach

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2022-49371-30f9@gregkh/

Introduced by commit 765230b ("driver-core: add asynchronous probing
support for drivers") in v4.2-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b232b02bf3c205b13a26dcec08e53baddd8e59ed]
stable/5.10: [36ee9ffca8ef56c302f2855c4a5fccf61c0c1ada]
stable/5.15: [df6de52b80aa3b46f5ac804412355ffe2e1df93e]
stable/5.4: [593b595332bd2d65e1a5c1ae7897996c157f5468]

CVE-2022-49372: tcp: tcp_rtx_synack() can be called from process context

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2022-49372-45e1@gregkh/

Introduced by commit 168a8f5 ("tcp: TCP Fast Open Server - main code
path") in v3.7-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [58bd38cbc961fd799842b7be8c5222310f04b908]
mainline: [0a375c822497ed6ad6b5da0792a12a6f1af10c0b]
stable/4.19: [58bd38cbc961fd799842b7be8c5222310f04b908]
stable/5.10: [0a0f7f84148445c9f02f226928803a870139d820]
stable/5.15: [88cd232146207ff1d41dededed5e77c0d4438113]
stable/5.4: [d05c2fdf8e10528bb6751bd95243e862d5402a9b]

CVE-2022-49373: watchdog: ts4800_wdt: Fix refcount leak in ts4800_wdt_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2022-49373-0137@gregkh/

Introduced by commit bf90063 ("watchdog: ts4800: add driver for
TS-4800 watchdog") in v4.5-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d24df3d690809952528e7a19a43d84bc5b99d44]
stable/5.10: [910b1cdf6c50ae8fb222e46657d04fb181577017]
stable/5.15: [7a4afd8a003d6abf1f5d159c2bb67e6b7cbde253]
stable/5.4: [5b110d940417942bc87d9e4bea6d4f24e05ed483]

CVE-2022-49374: tipc: check attribute length for bearer name

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2022-49374-22a3@gregkh/

Introduced by commit cb30a63 ("tipc: refactor function
tipc_enable_bearer()") in v4.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f07670871f4d19e613740eebe210e7e9ea535973]
mainline: [7f36f798f89bf32c0164049cb0e3fd1af613d0bb]
stable/4.19: [f07670871f4d19e613740eebe210e7e9ea535973]
stable/5.10: [b8fac8e321044a9ac50f7185b4e9d91a7745e4b0]
stable/5.15: [92a930fcf4250fe961f6238b99af0bc405799f39]
stable/5.4: [8b91d0dfc839e67708c905648cd0e7507a2263e5]

CVE-2022-49375: rtc: mt6397: check return value after calling
platform_get_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2022-49375-c238@gregkh/

Introduced by commit fc29791 ("rtc: mediatek: Add MT6397 RTC driver")
in v4.2-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6ecd4d5c28408df36a1a6f0b1973f633c949ac1f]
cip/4.4-st: [4c15da6a362bb003fbd0551be9cbfec513b6ee74]
mainline: [d3b43eb505bffb8e4cdf6800c15660c001553fe6]
stable/4.19: [6ecd4d5c28408df36a1a6f0b1973f633c949ac1f]
stable/5.10: [82bfea344e8f7e9a0e0b1bf9af27552baa756620]
stable/5.15: [865051de2d9eaa50630e055b73921ceaf3c4a7fc]
stable/5.4: [d77f28c1bc9d3043a52069fe42e4a26fbf961ebd]

CVE-2022-49376: scsi: sd: Fix potential NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2022-49376-9ec1@gregkh/

Introduced by commit 89d9475 ("sd: Implement support for ZBC devices")
in v4.10-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05fbde3a77a4f1d62e4c4428f384288c1f1a0be5]
stable/5.10: [c1f0187025905e9981000d44a92e159468b561a8]
stable/5.15: [0fcb0b131cc90c8f523a293d84c58d0c7273c96f]

CVE-2022-49377: blk-mq: don't touch ->tagset in blk_mq_get_sq_hctx

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2022-49377-4fdf@gregkh/

Introduced by commit b6e68ee ("blk-mq: Improve performance of non-mq
IO schedulers with multiple HW queues") in v5.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d05426e2d5fd7df8afc866b78c36b37b00188b7]
stable/5.15: [460aa288c5cd0544dcf933a2f0ad0e8c6d2d35ff]

CVE-2022-49378: sfc: fix considering that all channels have TX queues

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2022-49378-2598@gregkh/

Introduced by commit 8700aff ("sfc: fix channel allocation with brute
force") in v5.5-rc3.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e102b53f8a778f872dc137f4c7ac548705817aa]
stable/5.10: [8f81a4113e1e574d2cbde4f2cd599380a9189c0f]
stable/5.15: [5567d69b95b9c07e1c56f15cf0301251d12e5f97]

CVE-2022-49379: driver core: Fix wait_for_device_probe() &
deferred_probe_timeout interaction

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2022-49379-722a@gregkh/

Introduced by commit 35a6723 ("driver core: Ensure
wait_for_device_probe() waits until the deferred_probe_timeout fires")
in v5.7-rc5.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ee76c256e928455212ab759c51d198fedbe7523]
stable/5.10: [71cbce75031aed26c72c2dc8a83111d181685f1b]
stable/5.15: [29357883a89193863f3cc6a2c5e0b42ceb022761]

CVE-2022-49380: f2fs: fix to avoid f2fs_bug_on() in dec_valid_node_count()

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2022-49380-24ee@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [4d17e6fe9293d57081ffdc11e1cf313e25e8fd9e]
stable/5.10: [2766ddaf45b69252bb8fe526b5b6e56904a9ae7a]
stable/5.15: [bce859358d3d5940aa858e40ceee70ee6e76130e]
stable/5.4: [f8b3c3fcf33105bc1ee7788e3b51b0a1ae42ae53]

CVE-2022-49381: jffs2: fix memory leak in jffs2_do_fill_super

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2022-49381-89d2@gregkh/

Introduced by commit e631ddb ("[JFFS2] Add erase block summary support
(mount time improvement)") in v2.6.20.16.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [28048a4cf3813b7cf5cc8cce629dfdc7951cb1c2]
mainline: [c14adb1cf70a984ed081c67e9d27bc3caad9537c]
stable/4.19: [28048a4cf3813b7cf5cc8cce629dfdc7951cb1c2]
stable/5.10: [3252d327f977b14663a10967f3b0930d6c325687]
stable/5.15: [ecc53e58596542791e82eff00702f8af7a313f70]
stable/5.4: [d3a4fff1e7e408c32649030daa7c2c42a7e19a95]

CVE-2022-49382: soc: rockchip: Fix refcount leak in rockchip_grf_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2022-49382-a96e@gregkh/

Introduced by commit 4c58063 ("soc: rockchip: add driver handling grf
setup") in v4.11-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [28133325526b92921f3269fdf97a20d90b92b217]
mainline: [9b59588d8be91c96bfb0371e912ceb4f16315dbf]
stable/4.19: [28133325526b92921f3269fdf97a20d90b92b217]
stable/5.10: [5b3e990f85eb034faa461e691e719e8ce9e2a3c8]
stable/5.15: [aab25b669cb9fd3698c2631be4435f4fe92d9e59]
stable/5.4: [69a30b2ed620c2206cbbd1e9c112e4fc584e02bd]

CVE-2022-49383: watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2022-49383-dfdc@gregkh/

Introduced by commit 2cbc5cd ("watchdog: Add Watchdog Timer driver for
RZ/G2L") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt

Fixed status
mainline: [e4cf89596c1f1e33309556699f910ced4abbaf44]

CVE-2022-49384: md: fix double free of io_acct_set bioset

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2022-49384-422b@gregkh/

Introduced by commit 0c031fd (md: Move alloc/free acct bioset in to
personality) in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [42b805af102471f53e3c7867b8c2b502ea4eef7e]
stable/5.15: [36a2fc44c574a59ee3b5e2cb327182f227b2b07e]

CVE-2022-49385: driver: base: fix UAF when driver_attach failed

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2022-49385-258c@gregkh/

Introduced by commit 190888a ("driver core: fix possible missing of
device probe") in v3.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [310862e574001a97ad02272bac0fd13f75f42a27]
stable/5.10: [823f24f2e329babd0330200d0b74882516fe57f4]
stable/5.15: [cdf1a683a01583bca4b618dd16223cbd6e462e21]
stable/5.4: [5d709f58c743166fe1c6914b9de0ae8868600d9b]

CVE-2022-49386: net: ethernet: ti: am65-cpsw-nuss: Fix some refcount leaks

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2022-49386-a590@gregkh/

Introduced by commit b1f66a5 ("net: ethernet: ti: am65-cpsw-nuss:
enable packet timestamping support") in v5.8-rc1.
Introduced by commit 93a7653 ("net: ethernet: ti: introduce
am65x/j721e gigabit eth subsystem driver") in v5.7-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dd89d2fc438457811cbbec07999ce0d80051ff5]
stable/5.10: [f7ba2cc57f404d2d9f26fb85bd3833d35a477829]
stable/5.15: [a4b7ef3b159805ba6be061d0cd2403d84b9b0063]

CVE-2022-49387: watchdog: rzg2l_wdt: Fix 32bit overflow issue

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2022-49387-b17b@gregkh/

Introduced by commit 2cbc5cd ("watchdog: Add Watchdog Timer driver for
RZ/G2L") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt

Fixed status
mainline: [ea2949df22a533cdf75e4583c00b1ce94cd5a83b]

CVE-2022-49388: ubi: ubi_create_volume: Fix use-after-free when volume
creation failed

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2022-49388-1025@gregkh/

Introduced by commit 493cfae ("mtd: utilize new cdev_device_add helper
function") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [abb67043060f2bf4c03d7c3debb9ae980e2b6db3]
mainline: [8c03a1c21d72210f81cb369cc528e3fde4b45411]
stable/4.19: [abb67043060f2bf4c03d7c3debb9ae980e2b6db3]
stable/5.10: [6d8d3f68cbecfd31925796f0fb668eb21ab06734]
stable/5.15: [5ff2514e4fb55dcf3d88294686040ca73ea0c1a2]
stable/5.4: [8302620aeb940f386817321d272b12411ae7d39f]

CVE-2022-49389: usb: usbip: fix a refcount leak in stub_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2022-49389-c9ca@gregkh/

Introduced by commit 3ff6744 ("usbip: fix error handling in
stub_probe()") in v3.19-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [247d3809e45a34d9e1a3a2bb7012e31ed8b46031]
mainline: [9ec4cbf1cc55d126759051acfe328d489c5d6e60]
stable/4.19: [247d3809e45a34d9e1a3a2bb7012e31ed8b46031]
stable/5.10: [bcbb795a9e78180d74c6ab21518da87e803dfdce]
stable/5.15: [51422046be504515eb5a591adf0f424b62f46804]
stable/5.4: [2f0ae93ec33c8456cdfbf7876b80403a6318ebce]

CVE-2022-49390: macsec: fix UAF bug for real_dev

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2022-49390-1583@gregkh/

Introduced by commit 2bce1eb ("macsec: fix refcnt leak in module exit
routine") in v5.4-rc6.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [196a888ca6571deb344468e1d7138e3273206335]

CVE-2022-49391: remoteproc: mtk_scp: Fix a potential double free

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2022-49391-a147@gregkh/

Introduced by commit c1407ac ("remoteproc: mtk_scp: Use devm variant
of rproc_alloc()") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eac3e5b1c12f85732e60f5f8b985444d273866bb]

CVE-2022-49392: serial: 8250_aspeed_vuart: Fix potential NULL
dereference in aspeed_vuart_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2022-49392-59db@gregkh/

Introduced by commit 54da3e3 ("serial: 8250_aspeed_vuart: use
UPF_IOREMAP to set up register mapping") in v5.14-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e0fd55719fa081de6f9e5d9e6cef48efb04d34a]
stable/5.15: [923d34ce069e8e51a4d003caa6b66a8cd6ecd0ed]

CVE-2022-49393: misc: fastrpc: fix list iterator in fastrpc_req_mem_unmap_impl

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2022-49393-dd81@gregkh/

Introduced by commit 5c1b97c ("misc: fastrpc: add support for
FASTRPC_IOCTL_MEM_MAP/UNMAP") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5c07c5958cf0c9af6e76813e6de15d42ee49822]

CVE-2022-49394: blk-iolatency: Fix inflight count imbalances and IO
hangs on offline

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2022-49394-bcce@gregkh/

Introduced by commit 8c772a9 ("blk-iolatency: fix IO hang due to
negative inflight counter") in v5.0-rc6.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
cip/4.19-st: [515d077ee3085ae343b6bea7fd031f9906645f38]
mainline: [8a177a36da6c54c98b8685d4f914cb3637d53c0d]
stable/4.19: [515d077ee3085ae343b6bea7fd031f9906645f38]
stable/5.10: [77692c02e1517c54f2fd0535f41aa4286ac9f140]
stable/5.15: [a30acbb5dfb7bcc813ad6a18ca31011ac44e5547]
stable/5.4: [d19fa8f252000d141f9199ca32959c50314e1f05]

CVE-2022-49395: um: Fix out-of-bounds read in LDT setup

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49395-7419@gregkh/

Introduced by commit 858259c ("uml: maintain own LDT entries") in v2.6.20.16.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3549ab4b962cf619e8c55484a0d870a34b3f845f]
cip/4.4-st: [421d901ea019a20770c0f080af02436b204eaf31]
mainline: [2a4a62a14be1947fa945c5c11ebf67326381a568]
stable/4.19: [3549ab4b962cf619e8c55484a0d870a34b3f845f]
stable/5.10: [cf0dabc37446c5ee538ae7b4c467ab0e53fa5463]
stable/5.15: [10995a382271254bd276627ec74136da4a23c4a6]
stable/5.4: [9caad70819aef3431abaf73ba5163b55b161aba0]

CVE-2022-49396: phy: qcom-qmp: fix reset-controller leak on probe errors

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49396-3a8f@gregkh/

Introduced by commit e78f3d1 ("phy: qcom-qmp: new qmp phy driver for
qcom-chipsets") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a39d9eccb333b8c07c43ebea1c6dfda122378a0f]
mainline: [4d2900f20edfe541f75756a00deeb2ffe7c66bc1]
stable/4.19: [a39d9eccb333b8c07c43ebea1c6dfda122378a0f]
stable/5.10: [2156dc390402043ba5982489c6625adcb0b0975c]
stable/5.15: [ba173a6f8d8dffed64bb13ab23081bdddfb464f0]
stable/5.4: [7ac21b24af859c097eb4034e93430056068f8f31]

CVE-2022-49397: phy: qcom-qmp: fix struct clk leak on probe errors

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49397-fef3@gregkh/

Introduced by commit e78f3d1 ("phy: qcom-qmp: new qmp phy driver for
qcom-chipsets") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [621a4bcfb7aa031e7760d7b156bad7a45df58387]
mainline: [f0a4bc38a12f5a0cc5ad68670d9480e91e6a94df]
stable/4.19: [621a4bcfb7aa031e7760d7b156bad7a45df58387]
stable/5.10: [6f3673c8d8eff0c4ab5a5ee0d3ca9717d85419b4]
stable/5.15: [b246695636a861a09f0e2cde92bb2dd8f114f024]
stable/5.4: [1668ad103679306ba2ef37f758d704e58a3ef1a0]

CVE-2022-49398: usb: dwc3: gadget: Replace list_for_each_entry_safe()
if using giveback

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49398-9274@gregkh/

Introduced by commit d4f1afe ("usb: dwc3: gadget: move requests to
cancelled_list") in v5.0-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [bf594d1d0c1d7b895954018043536ffd327844f9]
stable/5.15: [1c6e5dc3b639c96e6839a8d1b8e951923fdfd34a]

CVE-2022-49399: tty: goldfish: Use tty_port_destroy() to destroy port

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49399-a988@gregkh/

Introduced by commit 666b779 ("goldfish: tty driver") in v3.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [326192b99c903a2193d820c30ed936cc2402382c]
mainline: [507b05063d1b7a1fcb9f7d7c47586fc4f3508f98]
stable/4.19: [326192b99c903a2193d820c30ed936cc2402382c]
stable/5.10: [ee6c33b29e624f515202a31bf6ef0437f26a1867]
stable/5.15: [da64f419d7f78272bfe40dde1262602d4ff6b32c]
stable/5.4: [9ae3d073f7db5578ae1907544f0c15947e9678e6]

CVE-2022-49400: md: Don't set mddev private to NULL in raid0 pers->free

Announce: https://lore.kernel.org/linux-cve-announce/2025022650-CVE-2022-49400-0754@gregkh/

Introduced by commit 0c031fd (md: Move alloc/free acct bioset in to
personality) in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [0f2571ad7a30ff6b33cde142439f9378669f8b4f]
stable/5.15: [f63fd1e0e0fc158023cc67ea6a07e278019061ba]

CVE-2022-49401: mm/page_owner: use strscpy() instead of strlcpy()

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49401-2fa3@gregkh/

Introduced by commit 865ed6a ("mm/page_owner: record task command
name") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd8c1fd8cdd14158f2d8bea2d1bfe8015dccfa3a]

CVE-2022-49402: ftrace: Clean up hash direct_functions on register failures

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49402-73ee@gregkh/

Introduced by commit 763e34e ("ftrace: Add register_ftrace_direct()")
in v5.5-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d54c15cb89a29a5f59e5ffc9ee62e6591769ef1]
stable/5.10: [82c888e51c2176a06f8b4541cf748ee81aac6e7e]
stable/5.15: [cae2978d6907ef2c08b9b15f704e783f7c284713]

CVE-2022-49403: lib/string_helpers: fix not adding strarray to
device's resource list

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49403-cd89@gregkh/

Introduced by commit acdb89b ("lib/string_helpers: Introduce managed
variant of kasprintf_strarray()") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd290a9839cee2f6641558877e707bd373c8f6f1]

CVE-2022-49404: RDMA/hfi1: Fix potential integer multiplication overflow errors

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49404-9bb3@gregkh/

Introduced by commit 7724105 ("IB/hfi1: add driver files") in v4.3-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [79c164e61f818054cd6012e9035701840d895c51]
mainline: [f93e91a0372c922c20d5bee260b0f43b4b8a1bee]
stable/4.19: [79c164e61f818054cd6012e9035701840d895c51]
stable/5.10: [31dca00d0cc9f4133320d72eb7e3720badc6d6e6]
stable/5.15: [3f09ec80f115d2875d747ed28adc1773037e0f8b]
stable/5.4: [8858284dd74906fa00f04f0252c75df4893a7959]

CVE-2022-49405: staging: r8188eu: prevent ->Ssid overflow in rtw_wx_set_scan()

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49405-7627@gregkh/

Introduced by commit 2b42bd5 ("staging: r8188eu: introduce new os_dep
dir for RTL8188eu driver") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc10916e890948d8927a5c8c40fb5dc44be5e1b8]
stable/5.15: [ac2eab7de458f5e1210ce1237afab40a307075c8]

CVE-2022-49406: block: Fix potential deadlock in blk_ia_range_sysfs_show()

Announce: https://lore.kernel.org/linux-cve-announce/2025022651-CVE-2022-49406-8378@gregkh/

Introduced by commit a2247f1 ("block: Add independent access ranges
support") in v5.16-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41e46b3c2aa24f755b2ae9ec4ce931ba5f0d8532]

CVE-2022-49407: dlm: fix plock invalid read

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49407-2755@gregkh/

Introduced by commit 586759f ("gfs2: nfs lock support for gfs2") in v2.6.22-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5a1765adf9855cf0f6d3f7e0eb4b78ca66f70dee]
cip/4.4-st: [695b24fca22e9990f2e33d93df2574173e0a4b9f]
mainline: [42252d0d2aa9b94d168241710a761588b3959019]
stable/4.19: [5a1765adf9855cf0f6d3f7e0eb4b78ca66f70dee]
stable/5.10: [899bc4429174861122f0c236588700a4710c1fec]
stable/5.15: [acdad5bc9827922ec2f2e84fd198718aa8e8ab92]
stable/5.4: [49cd9eb7b9a7b88124b31e31f8e539acaf1b3a6d]

CVE-2022-49408: ext4: fix memory leak in parse_apply_sb_mount_options()

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49408-2973@gregkh/

Introduced by commit 7edfd85 ("ext4: Completely separate options
parsing and sb setup") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c069db76ed7b681c69159f44be96d2137e9ca989]

CVE-2022-49409: ext4: fix bug_on in __es_tree_search

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49409-b4e3@gregkh/

Introduced by commit 5946d08 ("ext4: check for overlapping extents in
ext4_valid_extent_entries()") in v3.13-rc6.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d36f6ed761b53933b0b4126486c10d3da7751e7f]
stable/5.10: [4fd58b5cf118d2d9038a0b8c9cc0e43096297686]
stable/5.15: [3c617827cd51018bc377bd2954e176920ddbcfad]
stable/5.4: [d0083459e2b6b07ebd78bea2fe684a19cc0f3d0f]

CVE-2022-49410: tracing: Fix potential double free in create_var_ref()

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49410-de6a@gregkh/

Introduced by commit 067fe03 ("tracing: Add variable reference
handling to hist triggers") in v4.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f8b383f83cb573152c577eca1ef101e89995b72a]
mainline: [99696a2592bca641eb88cc9a80c90e591afebd0f]
stable/4.19: [f8b383f83cb573152c577eca1ef101e89995b72a]
stable/5.10: [058cb6d86b9789377216c936506b346aaa1eb581]
stable/5.15: [37443b3508b8cce6832f8d25cb4550b2f7801f50]
stable/5.4: [c27f744ceefadc7bbeb14233b6abc150ced617d2]

CVE-2022-49411: bfq: Make sure bfqg for which we are queueing requests is online

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49411-63ad@gregkh/

Introduced by commit e21b7a0 ("block, bfq: add full hierarchical
scheduling and cgroups support") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [075a53b78b815301f8d3dd1ee2cd99554e34f0dd]
stable/5.10: [51f724bffa3403a5236597e6b75df7329c1ec6e9]
stable/5.15: [6ee0868b0c3ccead5907685fcdcdd0c08dfe4b0b]
stable/5.4: [ccddf8cd411c1800863ed357064e56ceffd356bb]

CVE-2022-49412: bfq: Avoid merging queues with different parents

Announce: https://lore.kernel.org/linux-cve-announce/2025022652-CVE-2022-49412-8fac@gregkh/

Introduced by commit 430a67f ("block, bfq: merge bursts of
newly-created queues") in v5.13-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1cee4ab36acef271be9101590756ed0c0c374d9]
stable/5.10: [7d172b9dc913e161d8ff88770eea01701ff553de]
stable/5.15: [5ee21edaed09e6b25f2c007b3f326752bc89bacf]
stable/5.4: [97be7d13fbd4001eeab49b1be6399f23a8c66160]

CVE-2022-49413: bfq: Update cgroup information before merging bio

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49413-ae69@gregkh/

Introduced by commit e21b7a0 ("block, bfq: add full hierarchical
scheduling and cgroups support") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea591cd4eb270393810e7be01feb8fde6a34fbbe]
stable/5.10: [b06691af08b41dfd81052a3362514d9827b44bb1]
stable/5.15: [e8821f45612f2e6d9adb9c6ba0fb4184f57692aa]
stable/5.4: [da9f3025d595956410ceaab2bea01980d7775948]

CVE-2022-49414: ext4: fix race condition between ext4_write and
ext4_convert_inline_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49414-5693@gregkh/

Introduced by commit 0c8d414 ("ext4: let fallocate handle inline data
correctly") in v3.8-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f87c7a4b084afc13190cbb263538e444cb2b392a]
stable/5.10: [91f90b571f1a23f5b8a9c2b68a9aa5d6981a3c3d]
stable/5.15: [14602353b350950b551eccc6b46411aa3b12ffe2]
stable/5.4: [18881d7e517169193d9ef6c89c7f322e3e164277]

CVE-2022-49415: ipmi:ipmb: Fix refcount leak in ipmi_ipmb_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49415-8762@gregkh/

Introduced by commit 00d9361 ("ipmi:ipmb: Add the ability to have a
separate slave and master device") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a508e33956b538e034ed5df619a73ec7c15bda72]

CVE-2022-49416: wifi: mac80211: fix use-after-free in chanctx code

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49416-7c8e@gregkh/

Introduced by commit 5bcae31 ("mac80211: implement multi-vif in-place
reservations") in v3.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9f1e5cc85ad77e52f54049a94db0407445ae2a34]
cip/4.4-st: [2e92cc14352c2e4380518018b75016a4c5e65e3b]
mainline: [2965c4cdf7ad9ce0796fac5e57debb9519ea721e]
stable/4.19: [9f1e5cc85ad77e52f54049a94db0407445ae2a34]
stable/5.10: [6118bbdf69f4718b02d26bbcf2e497eb66004331]
stable/5.15: [b79110f2bf6022e60e590d2e094728a8eec3e79e]
stable/5.4: [265bec4779a38b65e86a25120370f200822dfa76]

CVE-2022-49417: iwlwifi: mei: fix potential NULL-ptr deref

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49417-2a5f@gregkh/

Introduced by commit 2da4366 ("iwlwifi: mei: add the driver to allow
cooperation with CSME") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78488a64aea94a3336ee97f345c1496e9bc5ebdf]

CVE-2022-49418: NFSv4: Fix free of uninitialized nfs4_label on referral lookup.

Announce: https://lore.kernel.org/linux-cve-announce/2025022653-CVE-2022-49418-ff01@gregkh/

Introduced by commit 9558a00 ("NFS: Remove the label from the
nfs4_lookup_res struct") in v5.16-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3ed222745d9ad7b69299b349a64ba533c64a34f]
stable/5.15: [eb1fe9600b86c24a789046bfc5c6851dda119280]

CVE-2022-49419: video: fbdev: vesafb: Fix a use-after-free due early
fb_info cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49419-fc59@gregkh/

Introduced by commit b3c9a92 ("fbdev: vesafb: Cleanup fb_info in
.fb_destroy rather than .remove") in v5.18-rc7.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [acde4003efc16480375543638484d8f13f2e99a3]
stable/5.15: [0fac5f8fb1bc2fc4f8714bf5e743c9cc3f547c63]

CVE-2022-49420: net: annotate races around sk->sk_bound_dev_if

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49420-2ad4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [4c971d2f3548e4f11b1460ac048f5307e4b39fdb]

CVE-2022-49421: video: fbdev: clcdfb: Fix refcount leak in clcdfb_of_vram_setup

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49421-6067@gregkh/

Introduced by commit d10715b ("video: ARM CLCD: Add DT support") in v3.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [51eb1bb6baeb478538dd4ec6459fd68c44a855b1]
cip/4.4-st: [c05c8ed0eabaffca6e01f8f629d2e7e3143c0d08]
mainline: [b23789a59fa6f00e98a319291819f91fbba0deb8]
stable/4.19: [51eb1bb6baeb478538dd4ec6459fd68c44a855b1]
stable/5.10: [c1c4405222b6fc98c16e8c2aa679c14e41d81465]
stable/5.15: [f2dfb4ab887d67be7d0892ba041d3c8d738d3356]
stable/5.4: [8db59df7f5826e104db82cfddbf22a33a151193e]

CVE-2022-49422: dmaengine: idxd: Fix the error handling path in
idxd_cdev_register()

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49422-b047@gregkh/

Introduced by commit 42d279f ("dmaengine: idxd: add char driver to
expose submission portal to userland") in v5.6-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aab08c1aac01097815fbcf10fce7021d2396a31f]
stable/5.10: [6073af78156b8c3fc1198f8bcc190b7ac3ac0143]
stable/5.15: [b3c7b5d08e9d5b2ff31c03078c00ecf11042419f]

CVE-2022-49423: rtla: Avoid record NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49423-e3fc@gregkh/

Introduced by commit 51d64c3 ("rtla: Add -e/--event support") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a6b52ed72c822b5ee146a6a00ea66614fe02653]

CVE-2022-49424: iommu/mediatek: Fix NULL pointer dereference when
printing dev_name

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2022-49424-23ec@gregkh/

Introduced by commit 635319a ("media: iommu/mediatek: Add device_link
between the consumer and the larb devices") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [de78657e16f41417da9332f09c2d67d100096939]
stable/5.15: [c3c2734e28d7fac50228c4d2b8896e8695adf304]

CVE-2022-49425: f2fs: fix dereference of stale list iterator after loop body

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49425-05aa@gregkh/

Introduced by commit 8c242db ("f2fs: fix stale ATOMIC_WRITTEN_PAGE
private pointer") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [385edd3ce5b4b1e9d31f474a5e35a39779ec1110]
mainline: [2aaf51dd39afb6d01d13f1e6fe20b684733b37d5]
stable/4.19: [385edd3ce5b4b1e9d31f474a5e35a39779ec1110]
stable/5.10: [51d584704d18e60fa473823654f35611c777b291]
stable/5.15: [45b2b7d7108ae1e25a5036cab04ab9273e792332]
stable/5.4: [5e47a7add3dda7f236548c5ec3017776dc2a729f]

CVE-2022-49426: iommu/arm-smmu-v3-sva: Fix mm use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49426-313d@gregkh/

Introduced by commit 32784a9 ("iommu/arm-smmu-v3: Implement
iommu_sva_bind/unbind()") in v5.11-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbd23144f7662b00bcde32a938c4a4057e476d68]
stable/5.15: [fc90f13ea0dcd960e5002d204fa55cec4e0db2fa]

CVE-2022-49427: iommu/mediatek: Remove clk_disable in mtk_iommu_remove

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49427-f29d@gregkh/

Introduced by commit b34ea31 ("iommu/mediatek: Always enable the clk
on resume") in v5.13-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98df772bdd1c4ce717a26289efea15cbbe4b64ed]
stable/5.15: [053465ab20dcd324a43a1811ee98e5721e6a3e65]

CVE-2022-49428: f2fs: fix to do sanity check on inline_dots inode

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49428-9756@gregkh/

Introduced by commit 510022a ("f2fs: add F2FS_INLINE_DOTS to recover
missing dot dentries") in v4.1-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12662d19467b391b5b509ac5e9ab4f583c6dde16]
stable/5.15: [250e5a6be52a6b9d82fe91976c83cc158868b4e9]

CVE-2022-49429: RDMA/hfi1: Prevent panic when SDMA is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49429-c9a7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [0e4dda8b3f4c07ee9ea670a10ea3171a5e63a86f]
mainline: [629e052d0c98e46dde9f0824f0aa437f678d9b8f]
stable/4.19: [0e4dda8b3f4c07ee9ea670a10ea3171a5e63a86f]
stable/5.10: [cc80d3c37cec9d6ddb140483647901bc7cc6c31d]
stable/5.15: [32e6aea33944f364d51cd263e4cd236393a188b6]
stable/5.4: [e60ad83f645ee6fadd5a8057ba267aeec54f08fe]

CVE-2022-49430: Input: gpio-keys - cancel delayed work only in case of GPIO

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2022-49430-3b17@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [cee409bbba0d1bd3fb73064fb480ff365f453b5d]
stable/5.15: [96c460687813915dedca9dd7d04ae0e90607fd79]

CVE-2022-49431: powerpc/iommu: Add missing of_node_put in iommu_init_early_dart

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49431-bca9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [57b742a5b8945118022973e6416b71351df512fb]
stable/5.10: [dfc308d6f29aa28463deb9a12278a85a382385ca]
stable/5.15: [df6d8b689252c0acc0448d4ae3d33f2d6db048ab]
stable/5.4: [cb4f2dc513e99c5d0485661f114e4dda73612d10]

CVE-2022-49432: powerpc/xics: fix refcount leak in icp_opal_init()

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49432-12c6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [1d5c8cea85fb1680eae8d645b96b92146cb4633c]
mainline: [5dd9e27ea4a39f7edd4bf81e9e70208e7ac0b7c9]
stable/4.19: [1d5c8cea85fb1680eae8d645b96b92146cb4633c]
stable/5.10: [6a61a97106279c2aa16fbbb2a171fd5dde127d23]
stable/5.15: [df802880a7f9cd96b921b00639b00871f18a9a57]
stable/5.4: [537a317e5ff45d1f5a0ecaf6a0d7c8043c878cb1]

CVE-2022-49433: RDMA/hfi1: Prevent use of lock before it is initialized

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49433-5ef1@gregkh/

Introduced by commit 473291b ("IB/hfi1: Fix for early release of sdma
context") in v4.16-rc1.
Introduced by commit 7724105 ("IB/hfi1: add driver files") in v4.3-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [66090815a24ce14cf51ef5453fc0218fe8a39bc2]
mainline: [05c03dfd09c069c4ffd783b47b2da5dcc9421f2c]
stable/4.19: [66090815a24ce14cf51ef5453fc0218fe8a39bc2]
stable/5.10: [fc0750e659db7b315bf6348902cc8ca3cdd4b8d8]
stable/5.15: [ca55150bff5817af4f857a746ecab9862c23e12a]
stable/5.4: [addb192000d8819c0b1553453994df9bb54c28db]

CVE-2022-49434: PCI: Avoid pci_dev_lock() AB/BA deadlock with
sriov_numvfs_store()

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49434-4a2c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [aed6d4d519210c28817948f34c53b6e058e0456c]
cip/4.4-st: [32929cb876be29bed4b43c665f7a96cfd7feed01]
mainline: [a91ee0e9fca9d7501286cfbced9b30a33e52740a]
stable/4.19: [aed6d4d519210c28817948f34c53b6e058e0456c]
stable/5.10: [eff3587b9c01439b738298475e555c028ac9f55e]
stable/5.15: [2cdd5284035322795b0964f899eefba254cfe483]
stable/5.4: [c9a81f9ed6ae3554621d6a50220b1bc74b67d81e]

CVE-2022-49435: mfd: davinci_voicecodec: Fix possible null-ptr-deref
davinci_vc_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49435-78f3@gregkh/

Introduced by commit b5e29aa ("mfd: davinci_voicecodec: Remove
pointless #include") in v5.4-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [311242c7703df0da14c206260b7e855f69cb0264]
stable/5.10: [a1d4941d9a24999f680799f9bbde7f57351ca637]
stable/5.15: [5289795824b77489803b0802cd9edc13824a2d0b]
stable/5.4: [49c1e32e7b3f301642a60448700ec531df981269]

CVE-2022-49436: powerpc/papr_scm: Fix leaking nvdimm_events_map elements

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2022-49436-e924@gregkh/

Introduced by commit 4c08d4b ("powerpc/papr_scm: Add perf interface
support") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e0946e22f3665d27325d389ff45ade6e93f3678]

CVE-2022-49437: powerpc/xive: Fix refcount leak in xive_spapr_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49437-7624@gregkh/

Introduced by commit eac1e73 ("powerpc/xive: guest exploitation of the
XIVE interrupt controller") in v4.14-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d1fb9618bdd5a5fbf9a9eb75133da301d33721c]
stable/5.15: [65f11ccdd746e0e7f0b469cc989ba43d4f30ecfe]

CVE-2022-49438: Input: sparcspkr - fix refcount leak in bbc_beep_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49438-30c7@gregkh/

Introduced by commit 9c1a507 ("input: Rewrite sparcspkr device
probing.") in v2.6.26-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [353bc58ac6c782d4dcde9136a91d1f90867938fe]
cip/4.4-st: [d8453e0870b354ec9fbfb927aff4bacab127d5c7]
mainline: [c8994b30d71d64d5dcc9bc0edbfdf367171aa96f]
stable/4.19: [353bc58ac6c782d4dcde9136a91d1f90867938fe]
stable/5.10: [6e07ccc7d56130f760d23f67a70c45366c07debc]
stable/5.15: [418b6a3e12f75638abc5673eb76cb32127d0ab13]
stable/5.4: [bbc2b0ce6042dd3117827f10ea8cb67e0ab786da]

CVE-2022-49439: powerpc/fsl_rio: Fix refcount leak in fsl_rio_setup

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49439-a4af@gregkh/

Introduced by commit abc3aea ("fsl-rio: Add two ports and rapidio
message units support") in v3.3-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5b8aa2ba38c010f47c965dd9bb5a8561813ed649]
mainline: [fcee96924ba1596ca80a6770b2567ca546f9a482]
stable/4.19: [5b8aa2ba38c010f47c965dd9bb5a8561813ed649]
stable/5.10: [46fd994763cf6884b88a2da712af918f3ed54d7b]
stable/5.15: [7b668a59ddfb32727e39b06fdf52b28e58c684e0]
stable/5.4: [bcb6c4c5eb4836a21411dfe8247bf9951eb6e7c3]

CVE-2022-49440: powerpc/rtas: Keep MSR[RI] set when calling RTAS

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49440-6751@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [b6b1c3ce06ca438eb24e0f45bf0e63ecad0369f5]
stable/5.15: [5ca40fcf0da0ce2b5bc44e7d8b036535955f2e3d]

CVE-2022-49441: tty: fix deadlock caused by calling printk() under
tty_port->lock

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49441-8b58@gregkh/

Introduced by commit b6da31b ("tty: Fix data race in
tty_insert_flip_string_fixed_flag") in v4.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [04ee31678c128a6cc7bb057ea189a8624ba5a314]
cip/4.4-st: [7d010fd9c7c5b54934a56072ad0c9a72a981b223]
mainline: [6b9dbedbe3499fef862c4dff5217cf91f34e43b3]
stable/4.19: [04ee31678c128a6cc7bb057ea189a8624ba5a314]
stable/5.10: [9834b13e8b962caa28fbcf1f422dd82413da4ede]
stable/5.15: [18ca0d55e8639b911df8aae1b47598b13f9acded]
stable/5.4: [3219ac364ac3d8d30771612a6010f1e0b7fa0a28]

CVE-2022-49442: drivers/base/node.c: fix compaction sysfs file leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2022-49442-ae21@gregkh/

Introduced by commit ed4a6d7 ("mm: compaction: add /sys trigger for
per-node memory compaction") in v2.6.35-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f76ddc8fcf6d81fe89bfa4d3efcbc4fe69a91d48]
cip/4.4-st: [08e3ffdc4d6946481b04fabdfd5d2ed6aeb6ed1a]
mainline: [da63dc84befaa9e6079a0bc363ff0eaa975f9073]
stable/4.19: [f76ddc8fcf6d81fe89bfa4d3efcbc4fe69a91d48]
stable/5.10: [d8a5bdc767f17281da648555cdbd286f98fd98ee]
stable/5.15: [b3fcf1f583b1a0946d9d9bfb7362c9c186801775]
stable/5.4: [386e69e068177ee91cac27f2f0e6ebda1515f5ca]

CVE-2022-49443: list: fix a data-race around ep->rdllist

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49443-15cc@gregkh/

Introduced by commit e59d3c6 ("epoll: eliminate unnecessary lock for
zero timeout") in v5.11-rc1.
Introduced by commit c5a282e ("fs/epoll: reduce the scope of wq lock
in epoll_wait()") in v5.0-rc1.
Introduced by commit bf3b9f6 ("epoll: Add busy poll support to epoll
with socket fds.") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d679ae94fdd5d3ab00c35078f5af5f37e068b03d]
stable/5.15: [5d5d993f16be15d124be7b8ec71b28ef7b7dc3af]

CVE-2022-49444: module: fix [e_shstrndx].sh_size=0 OOB access

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49444-ff21@gregkh/

Introduced by commit ec2a295 ("module: harden ELF info handling") in v5.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [391e982bfa632b8315235d8be9c0a81374c6a19c]
stable/5.15: [09cb6663618a74fe5572a4931ecbf098832e79ec]

CVE-2022-49445: pinctrl: renesas: core: Fix possible null-ptr-deref in
sh_pfc_map_resources()

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49445-244f@gregkh/

Introduced by commit c7977ec ("pinctrl: sh-pfc: Convert to
platform_get_*()") in v4.3-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5376e3d904532e657fd7ca1a9b1ff3d351527b90]
stable/5.10: [f991879762392c19661af5b722578089a12b305f]
stable/5.15: [5ed0519d425619b435150372cce2ffeec71581fa]

CVE-2022-49446: nvdimm: Fix firmware activation deadlock scenarios

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49446-f39e@gregkh/

Introduced by commit 48001ea ("PM, libnvdimm: Add runtime firmware
activation support") in v5.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6829d1bd3c4b58296ee9e412f7ed4d6cb390192]
stable/5.10: [641649f31e20df630310f5c22f26c071acc676d4]
stable/5.15: [2f97ebc58d5fc83ca1528cd553fa725472ab3ca8]

CVE-2022-49447: ARM: hisi: Add missing of_node_put after of_find_compatible_node

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49447-4819@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [dd4be8ecfb41a29e7c4e551b4e866157ce4a3429]
cip/4.4-st: [d19343df77ce51e84da3a13594c4e4406eaf78d4]
mainline: [9bc72e47d4630d58a840a66a869c56b29554cfe4]
stable/4.19: [dd4be8ecfb41a29e7c4e551b4e866157ce4a3429]
stable/5.10: [21a3effe446dd6dc5eed7fe897c2f9b88c9a5d6d]
stable/5.15: [a3265a9440030068547a20dfee646666f3ca5278]
stable/5.4: [e109058165137ef42841abd989f080adfefa14fa]

CVE-2022-49448: soc: bcm: Check for NULL return of devm_kzalloc()

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2022-49448-0cec@gregkh/

Introduced by commit 8bcac40 ("soc: bcm: add PM driver for Broadcom's
PMB") in v5.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4bd2aafacce48db26b0a213d849818d940556dd]
stable/5.15: [5650e103bfc70156001615861fb8aafb3947da6e]

CVE-2022-49449: pinctrl: renesas: rzn1: Fix possible null-ptr-deref in
sh_pfc_map_resources()

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49449-bf9c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [2f661477c2bb8068194dbba9738d05219f111c6e]
stable/5.10: [b646e0cfeb38bf5f1944fd548f1dfa9b129fa00c]
stable/5.15: [c16b59d445135c8026a04e388d8b2762feaa3b3b]

CVE-2022-49450: rxrpc: Fix listen() setting the bar too high for the
prealloc rings

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49450-a2f7@gregkh/

Introduced by commit 00e9071 ("rxrpc: Preallocate peers, conns and
calls for incoming service requests") in v4.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4a3a78b7918bdd723d8c7c9786522ca969bffcc4]
mainline: [88e22159750b0d55793302eeed8ee603f5c1a95c]
stable/4.19: [4a3a78b7918bdd723d8c7c9786522ca969bffcc4]
stable/5.10: [5b4826657d36c218e9f08e8d3223b0edce3de88f]
stable/5.15: [b3a9b227d5e7467b8518160ff034ea22bb9de573]
stable/5.4: [91b34bf0409f43bb60453bab23c5beadd726d022]

CVE-2022-49451: firmware: arm_scmi: Fix list protocols enumeration in
the base protocol

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49451-5d2f@gregkh/

Introduced by commit b6f20ff ("firmware: arm_scmi: add common
infrastructure and support for base protocol") in v4.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [444a2d27fe9867d0da4b28fc45b793f32e099ab8]
mainline: [8009120e0354a67068e920eb10dce532391361d0]
stable/4.19: [444a2d27fe9867d0da4b28fc45b793f32e099ab8]
stable/5.10: [1052f22e127d0c34c3387bb389424ba1c61491ff]
stable/5.15: [98342148a8cd242855d7e257f298c966c96dba9f]
stable/5.4: [b0e4bafac8963c2d85ee18d3d01f393735acceec]

CVE-2022-49452: dpaa2-eth: retrieve the virtual address before dma_unmap

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49452-a5fa@gregkh/

Introduced by commit 3dc709e ("dpaa2-eth: add support for software
TSO") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06d129946a71f3159b3b40ee95549183edf2c79d]

CVE-2022-49453: soc: ti: ti_sci_pm_domains: Check for null return of
devm_kcalloc

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49453-9819@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [ba56291e297d28aa6eb82c5c1964fae2d7594746]
stable/5.10: [05efc4591f80582b6fe53366b70b6a35a42fd255]
stable/5.15: [7cef9274fa1b8506949d74bc45aef072b890824a]

CVE-2022-49454: PCI: mediatek: Fix refcount leak in mtk_pcie_subsys_powerup()

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2022-49454-21c8@gregkh/

Introduced by commit 87e8657 ("PCI: mediatek: Add new method to get
shared pcie-cfg base address") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [214e0d8fe4a813ae6ffd62bc2dfe7544c20914f4]
stable/5.15: [ad1c9d13e04509ae24fae8dd2897148657323519]

CVE-2022-49455: misc: ocxl: fix possible double free in ocxl_file_register_afu

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49455-a338@gregkh/

Introduced by commit 75ca758 ("ocxl: Create a clear delineation
between ocxl backend & frontend") in v5.2-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [950cf957fe34d40d63dfa3bf3968210430b6491e]
stable/5.10: [ee89d8dee55ab4b3b8ad8b70866b2841ba334767]
stable/5.15: [8fb674216835e1f0c143762696d645facebb4685]
stable/5.4: [de65c32ace9aa70d51facc61ba986607075e3a25]

CVE-2022-49456: bonding: fix missed rcu protection

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49456-2bf4@gregkh/

Introduced by commit aa60346 ("bonding: use rcu_dereference_rtnl when
get bonding active slave") in v5.17-rc2.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b80ccda233fa6c59de411bf889cc4d0e028f2c7]

CVE-2022-49457: ARM: versatile: Add missing of_node_put in dcscb_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49457-0a07@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [a0fc05cd17617e63fc13ad0c01f3f0afd890d8ec]
cip/4.4-st: [b1a88c95e9dbc60c0ca6e96bb0da34a184988cab]
mainline: [23b44f9c649bbef10b45fa33080cd8b4166800ae]
stable/4.19: [a0fc05cd17617e63fc13ad0c01f3f0afd890d8ec]
stable/5.10: [d146e2a9864ade19914494de3fb520390b415d58]
stable/5.15: [83c329b980bddbc8c6a3d287d91f2103a4d4a860]
stable/5.4: [fcd1999ba97445a12cc394f5f42ffd9116bf0185]

CVE-2022-49458: drm/msm: don't free the IRQ if it was not requested

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49458-46ef@gregkh/

Introduced by commit f026e43 ("drm/msm: Convert to Linux IRQ
interfaces") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [577e2a9dfc8fba7938aaf75db63fae7e328cc3cb]
stable/5.15: [beb81c13d020ceb7f8693e65464162e5f249218e]

CVE-2022-49459: thermal/drivers/broadcom: Fix potential NULL
dereference in sr_thermal_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49459-70f1@gregkh/

Introduced by commit 250e211 ("thermal: broadcom: Add Stingray thermal
driver") in v5.1-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e20d136ec7d6f309989c447638365840d3424c8e]
stable/5.10: [79098339ac2065f4b4352ef5921628970b6f47e6]
stable/5.15: [ef1235c6514a58f274246cf4a2d5f4e40af539ce]
stable/5.4: [b3461ccaa5d2588568d865faee285512ad448049]

CVE-2022-49460: PM / devfreq: rk3399_dmc: Disable edev on remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2022-49460-4733@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [664736e2cc09e504ce58ec61164d029d1f2651bb]
mainline: [2fccf9e6050e0e3b8b4cd275d41daf7f7fa22804]
stable/4.19: [664736e2cc09e504ce58ec61164d029d1f2651bb]
stable/5.10: [86b091b6894c449d2734de7aa7d79ccb33ffd97d]
stable/5.15: [cb1be1d4be18fe286ba5a67d928598378fd7fbe5]
stable/5.4: [a0180e324a9a63de8f770da300477b48cb4a53f1]

CVE-2022-49461: amt: fix memory leak for advertisement message

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49461-ccd9@gregkh/

Introduced by commit cbc21dc ("amt: add data plane of amt interface")
in v5.16-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe29794c3585d039fefebaa2b5a4932a627ad4fd]

CVE-2022-49462: drm/msm/a6xx: Fix refcount leak in a6xx_gpu_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49462-52fb@gregkh/

Introduced by commit 4b565ca ("drm/msm: Add A6XX device support") in v4.19-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c56de483093d7ad0782327f95dda7da97bc4c315]
stable/5.10: [48e82ce8cdb19c20a5020fa446b286d6a147450c]
stable/5.15: [edff4c1af831d0c02e654eed9da7d74174de49d5]
stable/5.4: [6832e36f156ea35a6ed74bca72727806116effdd]

CVE-2022-49463: thermal/drivers/imx_sc_thermal: Fix refcount leak in
imx_sc_thermal_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49463-ae19@gregkh/

Introduced by commit e20db70 ("thermal: imx_sc: add i.MX system
controller thermal support") in v5.7-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09700c504d8e63faffd2a2235074e8c5d130cb8f]
stable/5.10: [8bbf522a2c51ef939d0e8835e236bfcd252193af]
stable/5.15: [3ade442ea5d3512a3c67984489ab4d8a6fb3b29f]

CVE-2022-49464: erofs: fix buffer copy overflow of ztailpacking feature

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49464-7407@gregkh/

Introduced by commit ab749ba ("erofs: support unaligned data
decompression") in v5.17-rc1.
Introduced by commit cecf864 ("erofs: support inline data
decompression") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dcbe6803fffd387f72b48c2373b5f5ed12a5804b]

CVE-2022-49465: blk-throttle: Set BIO_THROTTLED when bio has been throttled

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49465-c14f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [5a011f889b4832aa80c2a872a5aade5c48d2756f]

CVE-2022-49466: regulator: scmi: Fix refcount leak in scmi_regulator_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2022-49466-d3cd@gregkh/

Introduced by commit 0fbeae7 ("regulator: add SCMI driver") in v5.11-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68d6c8476fd4f448e70e0ab31ff972838ac41dae]
stable/5.15: [9ebbfa73d69909b7c737f599fd4ebd42318fc881]

CVE-2022-49467: drm: msm: fix possible memory leak in mdp5_crtc_cursor_set()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49467-9d0a@gregkh/

Introduced by commit e172d10 ("drm/msm/mdp5: Add hardware cursor
support") in v4.0-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f8cd192752a1f613b14eee77783c6f0aebb49691]
mainline: [947a844bb3ebff0f4736d244d792ce129f6700d7]
stable/4.19: [f8cd192752a1f613b14eee77783c6f0aebb49691]
stable/5.10: [656aa3c51fc662064f17179b38ec3ce43af53bca]
stable/5.15: [33546183c16c7b9650682dc610bedd732d9c6919]
stable/5.4: [449374565f349d4233beec811d4286fdfe5de44b]

CVE-2022-49468: thermal/core: Fix memory leak in
__thermal_cooling_device_register()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49468-fc5a@gregkh/

Introduced by commit 8ea2295 ("thermal: Add cooling device's
statistics in sysfs") in v4.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98a160e898c0f4a979af9de3ab48b4b1d42d1dbb]
stable/5.10: [18530bedd221160823f63ccc20dd55c7a03edbcf]
stable/5.15: [21ccc58b671aea924f2481cf5c1cf0ebbfd3552d]

CVE-2022-49469: btrfs: fix anon_dev leak in create_subvol()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49469-8006@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [2256e901f5bddc56e24089c96f27b77da932dfcc]

CVE-2022-49470: Bluetooth: btmtksdio: fix use-after-free at btmtksdio_recv_event

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49470-1421@gregkh/

Introduced by commit 9aebfd4 ("Bluetooth: mediatek: add support for
MediaTek MT7663S and MT7668S SDIO devices") in v5.2-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fab6361c4ba17d1b43a991bef4238a3c1754d35]
stable/5.15: [b3cec8a42fcd11d05313c724f27e01b1db77522c]

CVE-2022-49471: rtw89: cfo: check mac_id to avoid out-of-bounds

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2022-49471-4e82@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [97df85871a5b187609d30fca6d85b912d9e02f29]

CVE-2022-49472: net: phy: micrel: Allow probing without .driver_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49472-eeea@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [91e720b32cba25fa58eaa4c88fe957009cffe9f3]
mainline: [f2ef6f7539c68c6bd6c32323d8845ee102b7c450]
stable/4.19: [91e720b32cba25fa58eaa4c88fe957009cffe9f3]
stable/5.10: [abb5594ae2ba7b82cce85917cc6337ec5d774837]
stable/5.15: [660dfa033ccc9afb032015b6dc76e846bba42cfb]
stable/5.4: [1e5fbfc2a6f384e3195446c14bbd3bc298eb88c2]

CVE-2022-49473: ASoC: ti: j721e-evm: Fix refcount leak in j721e_soc_probe_*

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49473-038f@gregkh/

Introduced by commit 6748d05 ("ASoC: ti: Add custom machine driver for
j721e EVM (CPB and IVI)") in v5.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a34840c4eb3278a7c29c9c57a65ce7541c66f9f2]
stable/5.10: [510e879420b410d88c612aecc6ca15dc6fe77473]
stable/5.15: [2a3966b950b37a6f10c5f9caee15b4cdcf5a7413]

CVE-2022-49474: Bluetooth: fix dangling sco_conn and use-after-free in
sco_sock_timeout

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49474-ce0b@gregkh/

Introduced by commit e1dee2c ("Bluetooth: fix repeated calls to
sco_sock_kill") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [390d82733a953c1fabf3de9c9618091a7a9c90a6]
mainline: [7aa1e7d15f8a5b65f67bacb100d8fc033b21efa2]
stable/4.19: [390d82733a953c1fabf3de9c9618091a7a9c90a6]
stable/5.10: [36c644c63bfcaee2d3a426f45e89a9cd09799318]
stable/5.15: [65d347cb39e2e6bd0c2a745ad7c928998ebb0162]
stable/5.4: [6f55fac0af3531cf60d11369454c41f5fc81ab3f]

CVE-2022-49475: spi: spi-fsl-qspi: check return value after calling
platform_get_resource_byname()

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49475-9398@gregkh/

Introduced by commit 858e26a ("spi: spi-fsl-qspi: Reduce devm_ioremap
size to 4 times AHB buffer size") in v5.8-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2b331ac11e1cac56f5b7d367e9f3c5796deaaed]
stable/5.10: [560dcbe1c7a78f597f2167371ebdbe2bca3d0735]
stable/5.15: [10f537219629769498ecb8515e096be213224c24]

CVE-2022-49476: mt76: mt7921: fix kernel crash at mt7921_pci_remove

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49476-1946@gregkh/

Introduced by commit 5c14a5f ("mt76: mt7921: introduce mt7921e
support") in v5.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad483ed9dd5193a54293269c852a29051813b7bd]

CVE-2022-49477: ASoC: samsung: Fix refcount leak in aries_audio_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2022-49477-8fb3@gregkh/

Introduced by commit 7a3a767 ("ASoC: samsung: Add driver for Aries
boards") in v5.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf4a9b2467b775717d0e9034ad916888e19713a3]
stable/5.10: [cacea459f95be22b3750f3b25b7a1c5897a68206]
stable/5.15: [85d899f396622d3034643bf89615a78f9be7c91a]

CVE-2022-49478: media: pvrusb2: fix array-index-out-of-bounds in
pvr2_i2c_core_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49478-4f2d@gregkh/

Introduced by commit d855497 ("V4L/DVB (4228a): pvrusb2 to kernel
2.6.18") in v2.6.20.16.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a3660e06675bccec4bf149c7229ea1d491ba10d7]
mainline: [471bec68457aaf981add77b4f590d65dd7da1059]
stable/4.19: [a3660e06675bccec4bf149c7229ea1d491ba10d7]
stable/5.10: [a3304766d9384886e6d3092c776273526947a2e9]
stable/5.15: [3309c2c574e13b21b44729f5bdbf21f60189b79a]
stable/5.4: [1310fc3538dcc375a2f46ef0a438512c2ca32827]

CVE-2022-49479: mt76: fix tx status related use-after-free race on
station removal

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49479-520e@gregkh/

Introduced by commit bd1e3e7 ("mt76: introduce packet_id idr") in v5.16-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcfe1b5e162bf473c1d47760962cec8523c00466]

CVE-2022-49480: ASoC: imx-hdmi: Fix refcount leak in imx_hdmi_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49480-1f86@gregkh/

Introduced by commit 6a5f850 ("ASoC: fsl: Add imx-hdmi machine
driver") in v5.11-rc1.
Introduced by commit f670b27 ("ASoC: imx-hdmi: add put_device() after
of_find_device_by_node()") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [ed46731d8e86c8d65f5fc717671e1f1f6c3146d2]
stable/5.15: [cf760e494ee5fa6bc2dc222f0098c741ad460801]

CVE-2022-49481: regulator: pfuze100: Fix refcount leak in
pfuze_parse_regulators_dt

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49481-cbff@gregkh/

Introduced by commit 3784b6d ("regulator: pfuze100: add pfuze100
regulator driver") in v3.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [984cfef0675ed7398814e14af2c5323911723e1c]
cip/4.4-st: [54e85815d63afc5c08045c8cbeda47bdfe0256ca]
mainline: [afaa7b933ef00a2d3262f4d1252087613fb5c06d]
stable/4.19: [984cfef0675ed7398814e14af2c5323911723e1c]
stable/5.10: [9f564e29a51210a49df3d925117777c157a17d6d]
stable/5.15: [56ab0c01027492cd161c64148e1dc892c56887ad]
stable/5.4: [0be5d9da5743b9825a95baec85a67500b2c1d362]

CVE-2022-49482: ASoC: mxs-saif: Fix refcount leak in mxs_saif_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49482-b33c@gregkh/

Introduced by commit 08641c7 ("ASoC: mxs: add device tree support for
mxs-saif") in v3.5-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [30d110ca703ce60162ec337aa564a3e4da30715f]
cip/4.4-st: [e941b83325452375b08cbc674208de07def65c9f]
mainline: [2be84f73785fa9ed6443e3c5b158730266f1c2ee]
stable/4.19: [30d110ca703ce60162ec337aa564a3e4da30715f]
stable/5.10: [2a0da7641e1f17a744ac7b3f76471388c97b63dc]
stable/5.15: [24491124406666bf0dcb9ee10c5575c6ce6a1730]
stable/5.4: [18b907ff0ae4bf20120aae1538f7156b9d08e3a7]

CVE-2022-49483: drm/msm/disp/dpu1: avoid clearing hw interrupts if
hw_intr is null during drm uninit

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2022-49483-dd7b@gregkh/

Introduced by commit f25f656 ("drm/msm/dpu: merge struct dpu_irq into
struct dpu_hw_intr") in v5.16-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01013ba9bbddc62f7d011163cebfd7ed06bb698b]

CVE-2022-49484: mt76: mt7915: fix possible NULL pointer dereference in
mt7915_mac_fill_rx_vector

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49484-4983@gregkh/

Introduced by commit 78fc30a ("mt76: mt7915: move testmode data from
dev to phy") in v5.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62fdc974894eec80d678523458cf99bbdb887e22]

CVE-2022-49485: drm/v3d: Fix null pointer dereference of pointer perfmon

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49485-a8ec@gregkh/

Introduced by commit 26a4dc2 ("drm/v3d: Expose performance counters to
userspace") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce7a1ecf3f9f1fccaf67295307614511d8e11b13]
stable/5.15: [4be045434923e549a50846a066a04b7b6c1d6d33]

CVE-2022-49486: ASoC: fsl: Fix refcount leak in imx_sgtl5000_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49486-cdcc@gregkh/

Introduced by commit 81e8e49 ("ASoC: fsl: add sgtl5000 clock support
for imx-sgtl5000") in v3.5-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41cd312dfe980af869c3503b4d38e62ed20dd3b7]
stable/5.10: [e84aaf23ca82753d765bf84d05295d9d9c5fed29]
stable/5.15: [922bccdb1796a9e7b989f2bc6d9ada7b499a4329]
stable/5.4: [96fc3da6184af5687e153d420cd7dcdeefdd2f9a]

CVE-2022-49487: mtd: rawnand: intel: fix possible null-ptr-deref in
ebu_nand_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49487-c710@gregkh/

Introduced by commit 0b1039f ("mtd: rawnand: Add NAND controller
support on Intel LGM SoC") in v5.11-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddf66aefd685fd46500b9917333e1b1e118276dc]
stable/5.15: [e5b1e419cdb6dd8709eb05ed34039a3ded8e6003]

CVE-2022-49488: drm/msm/mdp5: Return error code in mdp5_mixer_release
when deadlock is detected

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49488-5f36@gregkh/

Introduced by commit 7907a0d ("drm/msm/mdp5: Use the new private_obj
state") in v4.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1a5d1474026ea4f1a6f931075ca2adb884af39cf]
mainline: [ca75f6f7c6f89365e40f10f641b15981b1f07c31]
stable/4.19: [1a5d1474026ea4f1a6f931075ca2adb884af39cf]
stable/5.10: [883f1d52a57bf51e1d7a80c432345e2c6222477e]
stable/5.15: [09bdeedc1fc53e64b8282e1de67752c69e43bdba]
stable/5.4: [22d8424913b1348c6324916745fadaeea5273f0e]

CVE-2022-49489: drm/msm/disp/dpu1: set vbif hw config to NULL to avoid
use after memory free during pm runtime resume

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49489-4131@gregkh/

Introduced by commit 25fdd59 ("drm/msm: Add SDM845 DPU support") in v4.19-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [aa4cb188988dc6f1b3f4917d4dbc452150a5d871]
mainline: [fa5186b279ecf44b14fb435540d2065be91cb1ed]
stable/4.19: [aa4cb188988dc6f1b3f4917d4dbc452150a5d871]
stable/5.10: [134760263f6441741db0b2970e7face6b34b6d1c]
stable/5.15: [ef4bdaac7cb5416f236613ed9337ff0ea8ee329b]
stable/5.4: [ef10d0c68e8608848cd58fca2589685718426607]

CVE-2022-49490: drm/msm/mdp5: Return error code in mdp5_pipe_release
when deadlock is detected

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49490-e38c@gregkh/

Introduced by commit 7907a0d ("drm/msm/mdp5: Use the new private_obj
state") in v4.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [776f5c58bfe16cf322d71eeed3c5dda1eeac7e6b]
mainline: [d59be579fa932c46b908f37509f319cbd4ca9a68]
stable/4.19: [776f5c58bfe16cf322d71eeed3c5dda1eeac7e6b]
stable/5.10: [49dc28b4b2e28ef7564e355c91487996c1cbebd7]
stable/5.15: [04bef5f1ba8ea6d7c1c8f5f65e0395c62db59cb8]
stable/5.4: [b2aa2c4efe93e2580d6a8774b04fe2b99756a322]

CVE-2022-49491: drm/rockchip: vop: fix possible null-ptr-deref in vop_bind()

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49491-b27f@gregkh/

Introduced by commit 2048e32 ("drm: rockchip: Add basic drm driver")
in v3.19-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6ff986e057bf28e2f7690dad410768b2270f9453]
cip/4.4-st: [71d60e6bbb03edaba2cfb124c246ac087245f1af]
mainline: [f8c242908ad15bbd604d3bcb54961b7d454c43f8]
stable/4.19: [6ff986e057bf28e2f7690dad410768b2270f9453]
stable/5.10: [3451852312303d54a003c73bd0ae39cebb960bd5]
stable/5.15: [b54926bd558d97c888c3d2d87886f3c159d3254a]
stable/5.4: [a9b4599665e437de8a1152799c34841b799a2e1c]

CVE-2022-49492: nvme-pci: fix a NULL pointer dereference in
nvme_alloc_admin_tags

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49492-6a2d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [8da2b7bdb47e94bbc4062a3978c708926bcb022c]
mainline: [da42761181627e9bdc37d18368b827948a583929]
stable/4.19: [8da2b7bdb47e94bbc4062a3978c708926bcb022c]
stable/5.10: [af98940dd33c9f9e1beb4f71c0a39260100e2a65]
stable/5.15: [906c81dba8ee8057523859b5e1a2479e9fd34860]
stable/5.4: [f76729662650cd7bc8f8194e057af381370349a7]

CVE-2022-49493: ASoC: rt5645: Fix errorenous cleanup order

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49493-a2ff@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [0941150100173d4eaf3fe08ff4b16740e7c3026f]
cip/4.4-st: [32ab6f27ac8264da14ff3b8dc17da1013fb5560f]
mainline: [2def44d3aec59e38d2701c568d65540783f90f2f]
stable/4.19: [0941150100173d4eaf3fe08ff4b16740e7c3026f]
stable/5.10: [1a5a3dfd9f172dcb115072f0aea5e27d3083c20e]
stable/5.15: [061a6159cea583f1155f67d1915917a6b9282662]
stable/5.4: [abe7554da62cb489712a54de69ef5665c250e564]

CVE-2022-49494: mtd: rawnand: cadence: fix possible null-ptr-deref in
cadence_nand_dt_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49494-f378@gregkh/

Introduced by commit ec4ba01 ("mtd: rawnand: Add new Cadence NAND
driver to MTD subsystem") in v5.5-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a28ed09dafee20da51eb26452950839633afd824]
stable/5.10: [81f1ddffdc22ca5789e33b9d4712914e302090c1]
stable/5.15: [0cfee868b89ffa945f3d535ee5c985cb40c5a0f8]

CVE-2022-49495: drm/msm/hdmi: check return value after calling
platform_get_resource_byname()

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49495-7aba@gregkh/

Introduced by commit c6a57a5 ("drm/msm/hdmi: add hdmi hdcp support
(V3)") in v4.3-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0978fcce91b90b561b8c82e7c492ba9fc8440eef]
cip/4.4-st: [d4b71ed094097ebcca35727487c6e7cd07df6ec4]
mainline: [a36e506711548df923ceb7ec9f6001375be799a5]
stable/4.19: [0978fcce91b90b561b8c82e7c492ba9fc8440eef]
stable/5.10: [d9cb951d11a4ace4de5c50b1178ad211de17079e]
stable/5.15: [4cd66a8016b872a153bf892fe4258cbc0dacf5b1]
stable/5.4: [2b3ed7547b1a052209da6c4ab886ffe0eed88c42]

CVE-2022-49496: media: mediatek: vcodec: prevent kernel crash when
rmmod mtk-vcodec-dec.ko

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49496-a532@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [c10c0086db688c95bb4e0e378e523818dff1551d]

CVE-2022-49497: net: remove two BUG() from skb_checksum_help()

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49497-bfc0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [d7ea0d9df2a6265b2b180d17ebc64b38105968fc]
stable/5.10: [312c43e98ed190bd8fd7a71a0addf9539d5b8ab1]
stable/5.15: [6320ae1b5876c30bf98203b6a5abe8b5c45e6a04]

CVE-2022-49498: ALSA: pcm: Check for null pointer of pointer substream
before dereferencing it

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49498-dd18@gregkh/

Introduced by commit d4cfb30 ("ALSA: pcm: Set per-card upper limit of
PCM buffer allocations") in v5.6-rc1.
Fixed in v5.18.3.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [b41ef7ad9238c22aa2e142f5ce4ce1a1a0d48123]
stable/5.10: [b2421a196cb0911ea95aec1050a0b830464c8fa6]
stable/5.15: [f2c68c52898f623fe84518da4606538d193b0cca]

CVE-2022-49499: drm/msm: Fix null pointer dereferences without iommu

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49499-8617@gregkh/

Introduced by commit bc21125 ("drm/msm/gpu: Track global faults per
address-space") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36a1d1bda77e1851bddfa9cf4e8ada94476dbaff]

CVE-2022-49500: wl1251: dynamically allocate memory used for DMA

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49500-2b04@gregkh/

Introduced by commit a1c510d ("ARM: implement support for vmap'ed
stacks") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [454744754cbf2c21b3fc7344e46e10bee2768094]

CVE-2022-49501: usbnet: Run unregister_netdev() before unbind() again

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49501-6f2e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [d1408f6b4dd78fb1b9e26bcf64477984e5f85409]
stable/5.15: [6d5deb242874d924beccf7eb3cef04c1c3b0da79]

CVE-2022-49502: media: rga: fix possible memory leak in rga_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49502-0cba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [a71eb6025305192e646040cd76ccacb5bd48a1b5]
stable/5.10: [8ddc89437ccefa18279918c19a61fd81527f40b9]
stable/5.15: [eeb4819e94aa69767b9e5591e70c63e8b7c5786a]

CVE-2022-49503: ath9k_htc: fix potential out of bounds access with
invalid rxstatus->rs_keyix

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49503-a3bf@gregkh/

Introduced by commit 4ed1a8d ("ath9k_htc: use ath9k_cmn_rx_accept") in
v3.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4bdcf32c965c27f55ccc4ee71c1927131115b0bb]
cip/4.4-st: [fb27b0fbd8dd89b809eb1bd2f70c7d6e4d9cac56]
mainline: [2dc509305cf956381532792cb8dceef2b1504765]
stable/4.19: [4bdcf32c965c27f55ccc4ee71c1927131115b0bb]
stable/5.10: [461e4c1f199076275f16bf6f3d3e42c6b6c79f33]
stable/5.15: [7f6defe0fabc79f29603c6fa3c80e4fe0456a3e9]
stable/5.4: [2326d398ccd41ba6d93b8346532dfa432ab00fee]

CVE-2022-49504: scsi: lpfc: Inhibit aborts if external loopback plug is inserted

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49504-9b25@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [ead76d4c09b89f4c8d632648026a476a5a34fde8]

CVE-2022-49505: NFC: NULL out the dev->rfkill to prevent UAF

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49505-302d@gregkh/

Introduced by commit 3e3b5df ("NFC: reorder the logic in
nfc_{un,}register_device") in v5.16-rc2.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [6abfaca8711803d0d7cc8c0fac1070a88509d463]
cip/4.4-st: [c2cd28ef43cbfa340fbd52df8bdf361f30c8581a]
mainline: [1b0e81416a24d6e9b8c2341e22e8bf48f8b8bfc9]
stable/4.19: [6abfaca8711803d0d7cc8c0fac1070a88509d463]
stable/5.10: [2a1b5110c95e4d49c8c3906270dfcde680a5a7be]
stable/5.15: [1632be63862f183cd5cf1cc094e698e6ec005dfd]
stable/5.4: [fbf9c4c714d3cdeb98b6a18e4d057f931cad1d81]

CVE-2022-49506: drm/mediatek: Add vblank register/unregister callback functions

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49506-2808@gregkh/

Introduced by commit 9b07049 ("drm/mediatek: Register vblank callback
function") in v5.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b74d921b900b6ce38c6247c0a1c86be9f3746493]
stable/5.15: [8a2dbdeccef6de47565638abdf3c25f41cdffc37]

CVE-2022-49507: regulator: da9121: Fix uninit-value in
da9121_assign_chip_model()

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49507-16f6@gregkh/

Introduced by commit f3fbd55 ("regulator: da9121: Add device
variants") in v5.11-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bab76514aca36bc513224525d5598da676938218]
stable/5.15: [be96baa0c79588084e0d7a4fa21c574cec9a57f4]

CVE-2022-49508: HID: elan: Fix potential double free in elan_input_configured

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49508-c351@gregkh/

Introduced by commit b7429ea ("HID: elan: Fix memleak in
elan_input_configured") in v5.9-rc4.
Introduced by commit 9a6a419 ("HID: Add driver for USB ELAN Touchpad")
in v4.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
cip/4.19-st: [c92ec22a991778a096342cf1a917ae36c5c86a90]
mainline: [1af20714fedad238362571620be0bd690ded05b6]
stable/4.19: [c92ec22a991778a096342cf1a917ae36c5c86a90]
stable/5.10: [6d0726725c7c560495f5ff364862a2cefea542e3]
stable/5.15: [24f9dfdaece9bd75bb8dbfdba83eddeefdf7dc47]
stable/5.4: [f1d4f19a796551edc6679a681ea1756b8c578c08]

CVE-2022-49509: media: i2c: max9286: fix kernel oops when removing module

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49509-60c3@gregkh/

Introduced by commit 66d8c9d ("media: i2c: Add MAX9286 driver") in v5.9-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [365ab7ebc24eebb42b9e020aeb440d51af8960cd]
stable/5.15: [a4ec75df70575cdf33d9638c7844e729bfe6ce24]

CVE-2022-49510: drm/omap: fix NULL but dereferenced coccicheck error

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49510-389b@gregkh/

Introduced by commit e02b5cc ("drm/omap: Add a 'right overlay' to
plane state") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f2a3970c969d0d8d7289a4c65edcedafc16fd92]

CVE-2022-49511: fbdev: defio: fix the pagelist corruption

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49511-100a@gregkh/

Introduced by commit 105a940 ("fbdev/defio: Early-out if page is
already enlisted") in v5.18-rc1.
Fixed in v5.18.3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [6a9ae2fe887042f76fd3d334349e64e8ab3c55a2]

CVE-2022-49512: mtd: rawnand: denali: Use managed device resources

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49512-f7ca@gregkh/

Introduced by commit 93db446 ("mtd: nand: move raw NAND related code
to the raw/ subdir") in v4.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a745b51cddafade99aaea1b93aad31e9614e230]
stable/5.10: [3c68daf4a368cd9e63ae5a2145c9e4a6f838c166]
stable/5.15: [3830dbdfb9a4aec680e43ed80b9f23db7a88eac9]

CVE-2022-49513: cpufreq: governor: Use kobject release() method to free dbs_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49513-f147@gregkh/

Introduced by commit c443563 ("cpufreq: governor: New sysfs show/store
callbacks for governor tunables") in v4.6-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a85ee6401a47ae3fc64ba506cacb3e7873823c65]
stable/5.15: [a1964688582d26af1328e19b658933659fb54337]

CVE-2022-49514: ASoC: mediatek: Fix error handling in mt8173_max98090_dev_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49514-843e@gregkh/

Introduced by commit 94319ba ("ASoC: mediatek: Use platform_of_node
for machine drivers") in v4.2-rc5.
Introduced by commit 4934337 ("ASoC: mediatek: mt8173: fix device_node
leak") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [cc43b9fdca519c5b13be6a717bacbebccd628cf6]
mainline: [4f4e0454e226de3bf4efd7e7924d1edc571c52d5]
stable/4.19: [cc43b9fdca519c5b13be6a717bacbebccd628cf6]
stable/5.10: [fb66e0512e5ccc093070e21cf88cce8d98c181b5]
stable/5.15: [48889eb3cce91d7f58e02bc07277b7f724b7a54a]
stable/5.4: [23f340ed906c758cec6527376768e3bc1474ac30]

CVE-2022-49515: ASoC: cs35l41: Fix an out-of-bounds access in
otp_packed_element_t

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49515-61ba@gregkh/

Introduced by commit 6450ef5 ("ASoC: cs35l41: CS35L41 Boosted Smart
Amplifier") in v5.16-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f342904216f378e88008bb0ce1ae200a4b99fe8]

CVE-2022-49516: ice: always check VF VSI pointer values

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49516-2748@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [baeb705fd6a7245cc1fa69ed991a9cffdf44a174]

CVE-2022-49517: ASoC: mediatek: Fix missing of_node_put in
mt2701_wm8960_machine_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49517-701e@gregkh/

Introduced by commit 8625c1d ("ASoC: mediatek: Add mt2701-wm8960
machine driver") in v4.12-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9345122f5fb9f97a206f440f38bb656e53f46912]
mainline: [05654431a18fe24e5e46a375d98904134628a102]
stable/4.19: [9345122f5fb9f97a206f440f38bb656e53f46912]
stable/5.10: [f279c49f17ce10866087ea6c0c57382158974b63]
stable/5.15: [61a85a20e8df5e0a92cfe169c92425c7bae0753b]
stable/5.4: [c71494f5f2b444adfd992a7359a0d2a791642b39]

CVE-2022-49518: ASoC: SOF: ipc3-topology: Correct get_control_data for
non bytes payload

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49518-082d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [a962890a5a3cce903ff7c7a19fadee63ed9efdc7]

CVE-2022-49519: ath10k: skip ath10k_halt during suspend for driver
state RESTARTING

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49519-3b0d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [b72a4aff947ba807177bdabb43debaf2c66bee05]
stable/5.10: [8aa3750986ffcf73e0692db3b40dd3a8e8c0c575]
stable/5.15: [c2272428090d0d215a3f017cbbbad731c07eee53]

CVE-2022-49520: arm64: compat: Do not treat syscall number as ESR_ELx
for a bad syscall

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49520-465c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [3fed9e551417b84038b15117732ea4505eee386b]
stable/5.10: [ad97425d23af3c3b8d4f6a2bb666cb485087c007]
stable/5.15: [621916afe8cd4f322eb12759b64a2f938d4e551d]
stable/5.4: [efd183d988b416fcdf6f7c298a17ced4859ca77d]

CVE-2022-49521: scsi: lpfc: Fix resource leak in lpfc_sli4_send_seq_to_ulp()

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49521-64b2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [646db1a560f44236b7278b822ca99a1d3b6ea72c]
stable/5.10: [fa1b509d41c5433672f72c0615cf4aefa0611c99]
stable/5.15: [40cf4ea4d2d497f7732c87d350ba5c3f5e8a43a1]

CVE-2022-49522: mmc: jz4740: Apply DMA engine limits to maximum segment size

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49522-ced4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [afadb04f1d6e74b18a253403f5274cde5e3fd7bd]
stable/5.10: [90281cadf5077f2d2bec8b08c2ead1f8cd12660e]
stable/5.15: [353298cadbd4c7d8e8a16d6000066414694933c3]
stable/5.4: [7923f95997a79cef2ad161a2facae64c25a0bca0]

CVE-2022-49523: ath11k: disable spectral scan during spectral deinit

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49523-51ef@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [161c64de239c7018e0295e7e0520a19f00aa32dc]
stable/5.10: [60afa4f4e1350c876d8a061182a70c224de275dd]
stable/5.15: [451b9076903a057b7b8d5b24dc84b3e436a1c743]

CVE-2022-49524: media: pci: cx23885: Fix the error handling in cx23885_initdev()

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49524-74f0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [7b9978e1c94e569d65a0e7e719abb9340f5db4a0]
mainline: [e8123311cf06d7dae71e8c5fe78e0510d20cd30b]
stable/4.19: [7b9978e1c94e569d65a0e7e719abb9340f5db4a0]
stable/5.10: [ca17e7a532d1a55466cc007b3f4d319541a27493]
stable/5.15: [98106f100f50c487469903b9cf6d966785fc9cc3]
stable/5.4: [fa636e9ee4442215cd9a2e079cd5a8e1fe0cb8ba]

CVE-2022-49525: media: cx25821: Fix the warning when removing the module

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49525-efd9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [258639bc55a586ee6df92d89786ccf1c71546d70]
cip/4.4-st: [4e9a4e265fcc864868a410f0b1badbb23676bea0]
mainline: [2203436a4d24302871617373a7eb21bc17e38762]
stable/4.19: [258639bc55a586ee6df92d89786ccf1c71546d70]
stable/5.10: [3f94169affa33c9db4a439d88f09cb2ed3a33332]
stable/5.15: [1f0fc1dfb5fdd456657519a97fab83691b96c6a0]
stable/5.4: [222292930c8ecc3516e03ec1f9fa8448be7ff496]

CVE-2022-49526: md/bitmap: don't set sb values if can't pass sanity check

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49526-5b0b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [422e8f7ba1e08c8e0e88d375bcb550bc2bbfe96d]
mainline: [e68cb83a57a458b01c9739e2ad9cb70b04d1e6d2]
stable/4.19: [422e8f7ba1e08c8e0e88d375bcb550bc2bbfe96d]
stable/5.10: [e69e93120f6219b9cc4fba3b515b6ababd8548aa]
stable/5.15: [27f672af28a8e9b783ff7f0eaf7ef2fbd5a2f4ba]
stable/5.4: [0959aa00f9765bd8c654b1365012e41b51c733cc]

CVE-2022-49527: media: venus: hfi: avoid null dereference in deinit

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49527-db75@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [a21d15dde21d7e8ae047eb8368677407db45d840]
mainline: [86594f6af867b5165d2ba7b5a71fae3a5961e56c]
stable/4.19: [a21d15dde21d7e8ae047eb8368677407db45d840]
stable/5.10: [27ad46da44177a78a4a0cae6fe03906888c61aa1]
stable/5.15: [9c385b961d4c378228e80f6abea8509cb67feab6]
stable/5.4: [0ac84ab50712879eac3c1dd2598440652a85d3d0]

CVE-2022-49528: media: i2c: dw9714: Disable the regulator when the
driver fails to probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49528-9957@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [02276e18defa2fccf16413b44440277d98c2b1ea]

CVE-2022-49529: drm/amdgpu/pm: fix the null pointer while the smu is disabled

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49529-39ba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [eea5c7b3390c6e006ba4cbd906447dd8cea8cfbf]

CVE-2022-49530: drm/amd/pm: fix double free in si_parse_power_table()

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49530-e721@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [c0e811c4ccf3b42705976285e3a94cc82dea7300]
mainline: [f3fa2becf2fc25b6ac7cf8d8b1a2e4a86b3b72bd]
stable/4.19: [c0e811c4ccf3b42705976285e3a94cc82dea7300]
stable/5.10: [ca1ce206894dd976275c78ee38dbc19873f22de9]
stable/5.15: [a5ce7051db044290b1a95045ff03c249005a3aa4]
stable/5.4: [af832028af6f44c6c45645757079c4ed6884ade5]

CVE-2022-49531: loop: implement ->free_disk

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49531-573a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [d2c7f56f8b5256d57f9e3fc7794c31361d43bdd9]

CVE-2022-49532: drm/virtio: fix NULL pointer dereference in
virtio_gpu_conn_get_modes

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49532-1e14@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [edafcad84c4134ebec4bc24b29ca4497a1184eea]
cip/4.4-st: [b32dc56cc01beeea3457ada461d0ec777f30905c]
mainline: [194d250cdc4a40ccbd179afd522a9e9846957402]
stable/4.19: [edafcad84c4134ebec4bc24b29ca4497a1184eea]
stable/5.10: [fadc626cae99aaa1325094edc6a9e2b883f3e562]
stable/5.15: [32e10aabc287f09a148ff759bb9ce70b01b0012c]
stable/5.4: [f85cb059fad03a3b33a50023be91e944bb065ae8]

CVE-2022-49533: ath11k: Change max no of active probe SSID and BSSID
to fw capability

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49533-a0a4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [50dc9ce9f80554a88e33b73c30851acf2be36ed3]

CVE-2022-49534: scsi: lpfc: Protect memory leak for NPIV ports sending PLOGI_RJT

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49534-ad11@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [672d1cb40551ea9c95efad43ab6d45e4ab4e015f]

CVE-2022-49535: scsi: lpfc: Fix null pointer dereference after failing
to issue FLOGI and PLOGI

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49535-0abf@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [577a942df3de2666f6947bdd3a5c9e8d30073424]

CVE-2022-49536: scsi: lpfc: Fix SCSI I/O completion and abort handler deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49536-db89@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [03cbbd7c2f5ee288f648f4aeedc765a181188553]
stable/5.15: [7625e81de2164a082810e1f27547d388406da610]

CVE-2022-49537: scsi: lpfc: Fix call trace observed during I/O with CMF enabled

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49537-abf2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [d6d45f67a11136cb88a70a29ab22ea6db8ae6bd5]
stable/5.15: [ae373d66c427812754db5292eb1481b181daf9ce]

CVE-2022-49538: ALSA: jack: Access input_dev under mutex

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49538-c7b9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [c093b62c40027c21d649c5534ad7aa3605a99b00]
mainline: [1b6a6fc5280e97559287b61eade2d4b363e836f2]
stable/4.19: [c093b62c40027c21d649c5534ad7aa3605a99b00]
stable/5.10: [e2b8681769f6e205382f026b907d28aa5ec9d59a]
stable/5.15: [5cc6f623f4818c7d7e9e966a45ebf324901ca9c5]
stable/5.4: [f68bed124c7699e23ffb4ce4fcc84671e9193cde]

CVE-2022-49539: rtw89: ser: fix CAM leaks occurring in L2 reset

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49539-9ea2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [b169f877f001a474fb89939842c390518160bcc5]

CVE-2022-49540: rcu-tasks: Fix race in schedule and flush work

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49540-0827@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [f75fd4b9221d93177c50dcfde671b2e907f53e86]
stable/5.10: [1c6c3f2336642fb3074593911f5176565f47ec41]
stable/5.15: [ba722d061bc4b54802d701fc63fc2fd988934603]

CVE-2022-49541: cifs: fix potential double free during failed mount

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49541-7460@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [8378a51e3f8140f60901fb27208cc7a6e47047b5]
stable/5.15: [ce0008a0e410cdd95f0d8cd81b2902ec10a660c4]

CVE-2022-49542: scsi: lpfc: Move cfg_log_verbose check before calling
lpfc_dmp_dbg()

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49542-8f78@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [e294647b1aed4247fe52851f3a3b2b19ae906228]
stable/5.15: [271725e4028559ae7974d762a8467dc9de412f2e]

CVE-2022-49543: ath11k: fix the warning of dev_wake in
mhi_pm_disable_transition()

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49543-09f7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [0d7a8a6204ea9271f1d0a8c66a9fd2f54d2e3cbc]

CVE-2022-49544: ipw2x00: Fix potential NULL dereference in libipw_xmit()

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49544-65c1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [167affc11781d7d35c4c3a7630a549ac74dd0b21]
cip/4.4-st: [f46aae4729e3f3066b5439ffffd142fe39aa1ca0]
mainline: [e8366bbabe1d207cf7c5b11ae50e223ae6fc278b]
stable/4.19: [167affc11781d7d35c4c3a7630a549ac74dd0b21]
stable/5.10: [98d1dc32f890642476dbb78ed3437a456bf421b0]
stable/5.15: [48d4a820fd33f012e5f63735a59d15b5a3882882]
stable/5.4: [8fb1b9beb085bb767ae43e441db5ac6fcd66a04d]

CVE-2022-49545: ALSA: usb-audio: Cancel pending work at closing a MIDI substream

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49545-4e81@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [0125de38122f0f66bf61336158d12a1aabfe6425]
stable/5.10: [40bdb5ec957aca5c5c1924602bef6b0ab18e22d3]
stable/5.15: [11868ca21585561659c2575b0d6508ef8e9c4291]

CVE-2022-49546: x86/kexec: fix memory leak of elf header buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49546-8673@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [b3e34a47f98974d0844444c5121aaff123004e57]
stable/5.15: [8765a423a87d74ef24ea02b43b2728fe4039f248]

CVE-2022-49547: btrfs: fix deadlock between concurrent dio writes when
low on free data space

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49547-c0fc@gregkh/

Introduced by commit f0bfa76 ("btrfs: fix ENOSPC failure when
attempting direct IO write into NOCOW range") in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [f5585f4f0ef5b17026bbd60fbff6fcc91b99d5bf]

CVE-2022-49548: bpf: Fix potential array overflow in bpf_trampoline_get_progs()

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49548-47fe@gregkh/

Introduced by commit 88fd9e5 ("bpf: Refactor trampoline update code")
in v5.7-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2aa95b71c9bbec793b5c5fa50f0a80d882b3e8d]
stable/5.10: [7f845de2863334bed4f362e95853f5e7bc323737]
stable/5.15: [e36452d5da6325df7c10cffc60a9e68d21e2606d]

CVE-2022-49549: x86/MCE/AMD: Fix memory leak when threshold_create_bank() fails

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49549-db30@gregkh/

Introduced by commit 6458de9 ("x86/mce/amd: Straighten CPU hotplug
path") in v5.8-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5f28623ceb103e13fc3d7bd45edf9818b227fd0]
stable/5.10: [b4acb8e7f1594607bc9017ef0aacb40b24a003d6]
stable/5.15: [cc0dd4456f9573bf8af9b4d8754433918e809e1e]

CVE-2022-49550: fs/ntfs3: provide block_invalidate_folio to fix memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49550-29a9@gregkh/

Introduced by commit 7ba13ab ("fs: Turn block_invalidatepage into
block_invalidate_folio") in v5.18-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [724bbe49c5e427cb077357d72d240a649f2e4054]

CVE-2022-49551: usb: isp1760: Fix out-of-bounds array access

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49551-4fc9@gregkh/

Introduced by commit 1da9e1c ("usb: isp1760: move to regmap for
register access") in v5.14-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26ae2c942b5702f2e43d36b2a4389cfb7d616b6a]
stable/5.15: [bf2558bbdce3ab1d6bcba09f354914e4515d0a2b]

CVE-2022-49552: bpf: Fix combination of jit blinding and pointers to
bpf subprogs.

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49552-e30f@gregkh/

Introduced by commit 69c087b ("bpf: Add bpf_for_each_map_elem()
helper") in v5.13-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b6313cf99b0d51b49aeaea98ec76ca8161ecb80]

CVE-2022-49553: fs/ntfs3: validate BOOT sectors_per_clusters

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49553-4466@gregkh/

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3b774342fa752a5290c0de36375289dfcf4a260]
stable/5.15: [58cf68a1886d14ffdc5c892ce483a82156769e88]

CVE-2022-49554: zsmalloc: fix races between asynchronous zspage free
and page migration

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49554-bd02@gregkh/

Introduced by commit 77ff465 ("zsmalloc: zs_page_migrate: skip
unnecessary loops but not return -EBUSY if zspage is not inuse") in
v4.14-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [645996efc2ae391246d595832aaa6f9d3cc338c7]
mainline: [2505a981114dcb715f8977b8433f7540854851d8]
stable/4.19: [645996efc2ae391246d595832aaa6f9d3cc338c7]
stable/5.10: [fae05b2314b147a78fbed1dc4c645d9a66313758]
stable/5.15: [3ec459c8810e658401be428d3168eacfc380bdd0]
stable/5.4: [fc658c083904427abbf8f18280d517ee2668677c]

CVE-2022-49555: Bluetooth: hci_qca: Use del_timer_sync() before freeing

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49555-64d2@gregkh/

Introduced by commit 0ff252c ("Bluetooth: hciuart: Add support QCA
chipset for UART") in v4.3-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72ef98445aca568a81c2da050532500a8345ad3a]
stable/5.10: [4989bb03342941f2b730b37dfa38bce27b543661]
stable/5.15: [db03727b4bbbbb36e6ef4cb655c670eefb6448e9]

CVE-2022-49556: KVM: SVM: Use kzalloc for sev ioctl interfaces to
prevent kernel data leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49556-9870@gregkh/

Introduced by commit eaf7826 ("KVM: SVM: Move SEV code to separate
file") in v5.7-rc1.
Introduced by commit 2c07ded ("KVM: SVM: add support for SEV
attestation command") in v5.12-rc1.
Introduced by commit 4cfdd47 ("KVM: SVM: Add KVM_SEV SEND_START
command") in v5.13-rc1.
Introduced by commit d3d1af8 ("KVM: SVM: Add KVM_SEND_UPDATE_DATA
command") in v5.13-rc1.
Introduced by commit eba04b2 ("KVM: x86: Account a variety of
miscellaneous allocations") in v5.13-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d22d2474e3953996f03528b84b7f52cc26a39403]
stable/5.10: [401bef1f95de92c3a8c6eece46e02fa88d7285ee]
stable/5.15: [d8fdb4b24097472ff6b3c0559448200d420b1418]

CVE-2022-49557: x86/fpu: KVM: Set the base guest FPU uABI size to
sizeof(struct kvm_xsave)

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49557-f9a3@gregkh/

Introduced by commit be50b20 ("kvm: x86: Add support for
getting/setting expanded xstate buffer") in v5.17-rc1.
Introduced by commit c60427d ("x86/fpu: Add uabi_size to guest_fpu")
in v5.17-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d187ba5312307d51818beafaad87d28a7d939adf]

CVE-2022-49558: netfilter: nf_tables: double hook unregistration in netns path

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49558-f8ba@gregkh/

Introduced by commit 767d121 ("netfilter: nftables: fix possible UAF
over chains from packet path in netns") in v5.11.
Fixed in v5.19-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [c73955a09408e7374d9abfd0e78ce3de9cda0635]
mainline: [f9a43007d3f7ba76d5e7f9421094f00f2ef202f8]
stable/4.19: [c73955a09408e7374d9abfd0e78ce3de9cda0635]
stable/5.10: [3fac8ce48fa9fd61ee9056d3ed48b2edefca8b82]
stable/5.15: [9c413a8c8bb49cc16796371805ecb260e885bb2b]
stable/5.4: [b09e6ccf0d12f9356e8e3508d3e3dce126298538]

CVE-2022-49559: KVM: x86: Drop WARNs that assert a triple fault never
"escapes" from L2

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49559-7711@gregkh/

Introduced by commit cb6a32c ("KVM: x86: Handle triple fault in L2
without killing L1") in v5.13-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45846661d10422ce9e22da21f8277540b29eca22]
stable/5.15: [8d3a2aa0976f57320ba89baf9d57fb158dd0cd0d]

CVE-2022-49560: exfat: check if cluster num is valid

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49560-d207@gregkh/

Introduced by commit 1e49a94 ("exfat: add bitmap operations") in v5.7-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64ba4b15e5c045f8b746c6da5fc9be9a6b00b61d]
stable/5.10: [82f723b8a5adf497f9e34c702a30ca7298615654]
stable/5.15: [c504167adc3248095a905fa0700a9693897cb5ed]

CVE-2022-49561: netfilter: conntrack: re-fetch conntrack after insertion

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49561-3e6a@gregkh/

Introduced by commit 71d8c47 ("netfilter: conntrack: introduce clash
resolution on insertion race") in v4.7-rc1.
Introduced by commit 2ad9d77 ("netfilter: conntrack: free extension
area immediately") in v5.5-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [92a999d1963eed0df666284e20055136ceabd12f]
mainline: [56b14ecec97f39118bf85c9ac2438c5a949509ed]
stable/4.19: [92a999d1963eed0df666284e20055136ceabd12f]
stable/5.10: [91a36ec160ec1a0c8f5352b772dffcbb0b6023e3]
stable/5.15: [01989d7eebb61c99bd4b88ebc8e261bd2f02caed]
stable/5.4: [b16bb373988da3ceb0308381634117e18b6ec60d]

CVE-2022-49562: KVM: x86: Use __try_cmpxchg_user() to update guest PTE A/D bits

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49562-1d2c@gregkh/

Introduced by commit bd53cb3 ("X86/KVM: Handle PFNs outside of kernel
reach when touching GPTEs") in v5.2-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f122dfe4476890d60b8c679128cd2259ec96a24c]

CVE-2022-49563: crypto: qat - add param check for RSA

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49563-9a67@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
Affected functions were added by a99053 (crypto: qat - Add support for
RSA algorithm") in 4.3-rc1.

Fixed status
mainline: [9714061423b8b24b8afb31b8eb4df977c63f19c4]
stable/5.15: [4d6d2adce08788b7667a6e58002682ea1bbf6a79]

CVE-2022-49564: crypto: qat - add param check for DH

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49564-0645@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.
Affected function was added by c9839143 ("crypto: qat - Add DH
support") in 4.8-rc1.

Fixed status
mainline: [2acbb8771f6ac82422886e63832ee7a0f4b1635b]
stable/5.15: [e7f979ed51f96495328157df663c835b17db1e30]

CVE-2022-49565: perf/x86/intel/lbr: Fix unchecked MSR access error on HSW

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49565-e60d@gregkh/

Introduced by commit 1ac7fd8 ("perf/x86/intel/lbr: Support LBR format
V7") in v5.17-rc2.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0380e13502adf7dd8be4c47d622c3522aae6c63]

CVE-2022-49566: crypto: qat - fix memory leak in RSA

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2022-49566-66a0@gregkh/

Introduced by commit 879f77e ("crypto: qat - Add RSA CRT mode") in v4.8-rc1.
Fixed in v5.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [80a52e1ee7757b742f96bfb0d58f0c14eb6583d0]
stable/5.15: [a843925e0287eebb4aa808666bf22c664dfe4c53]

CVE-2022-49567: mm/mempolicy: fix uninit-value in mpol_rebind_policy()

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49567-6118@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
cip/4.19-st: [13d51565cec1aa432a6ab363edc2bbc53c6f49cb]
cip/4.4-st: [dc7af3c1f5d9152d60288ccbfa59e6dc706285d0]
mainline: [018160ad314d75b1409129b2247b614a9f35894c]
stable/4.19: [13d51565cec1aa432a6ab363edc2bbc53c6f49cb]
stable/5.10: [ddb3f0b68863bd1c5f43177eea476bce316d4993]
stable/5.15: [8c5429a04ccd8dbcc3c753dab2f4126774ec28d4]
stable/5.4: [a1f8765f68bc9bf5744b365bb9f5e0b6db93edfe]

CVE-2022-49568: KVM: Don't null dereference ops->destroy

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49568-e2f5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc2.


Fixed status
mainline: [e8bc2427018826e02add7b0ed0fc625a60390ae5]
stable/5.10: [3616776bc51cd3262bb1be60cc01c72e0a1959cf]
stable/5.15: [e91665fbbf3ccb268b268a7d71a6513538d813ac]
stable/5.4: [170465715a60cbb7876e6b961b21bd3225469da8]

CVE-2022-49569: spi: bcm2835: bcm2835_spi_handle_err(): fix NULL
pointer deref for non DMA transfers

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49569-3c5b@gregkh/

Introduced by commit 1513cee ("spi: bcm2835: Drop dma_pending flag")
in v5.4-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ceaa684459d414992acbefb4e4c31f2dfc50641]
stable/5.10: [684896e675edd8b669fd3e9f547c5038222d85bc]
stable/5.15: [58466e05390043d2805685c70f55f3f59711bdf2]
stable/5.4: [76668d2a2f367d25ff448e6d7087406af7d7bb2b]

CVE-2022-49570: gpio: gpio-xilinx: Fix integer overflow

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49570-468c@gregkh/

Introduced by commit 02b3f84 ("xilinx: Switch to use bitmap APIs") in v5.14-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [32c094a09d5829ad9b02cdf667569aefa8de0ea6]
stable/5.15: [e129e5486b981d324057e6986059f852658b0d00]

CVE-2022-49571: tcp: Fix data-races around sysctl_tcp_max_reordering.

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49571-74ee@gregkh/

Introduced by commit dca145f ("tcp: allow for bigger reordering
level") in v3.19-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5e38cee24f19d19280c68f1ac8bf6790d607f60a]
mainline: [a11e5b3e7a59fde1a90b0eaeaa82320495cf8cae]
stable/4.19: [5e38cee24f19d19280c68f1ac8bf6790d607f60a]
stable/5.10: [064852663308c801861bd54789d81421fa4c2928]
stable/5.15: [ce3731c61589ed73364a5b55ce34131762ef9b60]
stable/5.4: [50a1d3d097503a90cf84ebe120afcde37e9c33b3]

CVE-2022-49572: tcp: Fix data-races around sysctl_tcp_slow_start_after_idle.

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2022-49572-51d7@gregkh/

Introduced by commit 35089bb ("[TCP]: Add tcp_slow_start_after_idle
sysctl.") in v2.6.20.16.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3b26e11b07a09b31247688bec61e2925d4a571b6]
mainline: [4845b5713ab18a1bb6e31d1fbb4d600240b8b691]
stable/4.19: [3b26e11b07a09b31247688bec61e2925d4a571b6]
stable/5.10: [0e3f82a03ec8c3808e87283e12946227415706c9]
stable/5.15: [41aeba4506f6b70ec7500c6fe202731a4ba29fe5]
stable/5.4: [369d99c2b89f54473adcf9acdf40ea562b5a6e0e]

CVE-2022-49573: tcp: Fix a data-race around sysctl_tcp_early_retrans.

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49573-e482@gregkh/

Introduced by commit eed530b ("tcp: early retransmit") in v3.5-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [488d3ad98ef7cddce7054193dbae6b4349c6807d]
mainline: [52e65865deb6a36718a463030500f16530eaab74]
stable/4.19: [488d3ad98ef7cddce7054193dbae6b4349c6807d]
stable/5.10: [11e8b013d16e5db63f8f76acceb5b86964098aaa]
stable/5.15: [5037ca9e4b169cc9aed0174d658c3d81fdaf8ea5]
stable/5.4: [83767fe800a311370330d4ec83aa76093b744a80]

CVE-2022-49574: tcp: Fix data-races around sysctl_tcp_recovery.

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49574-018f@gregkh/

Introduced by commit 4f41b1c ("tcp: use RACK to detect losses") in v4.4-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c7a492db1f7c37c758a66915908677bd8bc5d368]
mainline: [e7d2ef837e14a971a05f60ea08c47f3fed1a36e4]
stable/4.19: [c7a492db1f7c37c758a66915908677bd8bc5d368]
stable/5.10: [d8781f7cd04091744f474a2bada74772084b9dc9]
stable/5.15: [a31e2d0cb5cfa2aae3144cac04f25031d5d20fb4]
stable/5.4: [92c35113c63306091df9211375eebd0abd8c2160]

CVE-2022-49575: tcp: Fix a data-race around sysctl_tcp_thin_linear_timeouts.

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49575-ccf0@gregkh/

Introduced by commit 36e31b0 ("net: TCP thin linear timeouts") in v2.6.34-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f4b0295be9a3c4260de4585fac4062e602a88ac7]
mainline: [7c6f2a86ca590d5187a073d987e9599985fb1c7c]
stable/4.19: [f4b0295be9a3c4260de4585fac4062e602a88ac7]
stable/5.10: [cc133e4f4bc225079198192623945bb872c08143]
stable/5.15: [404c53ccdebd11f96954f4070cffac8e0b4d5cb6]
stable/5.4: [492f3713b282c0e67e951cd804edd22eccc25412]

CVE-2022-49576: ipv4: Fix data-races around sysctl_fib_multipath_hash_fields.

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49576-a9e2@gregkh/

Introduced by commit ce5c9c2 ("ipv4: Add a sysctl to control multipath
hash fields") in v5.14-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8895a9c2ac76fb9d3922fed4fe092c8ec5e5cccc]
stable/5.15: [36f5b86f309b3b11295d087cd7433f1c897caf94]

CVE-2022-49577: udp: Fix a data-race around sysctl_udp_l3mdev_accept.

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49577-da62@gregkh/

Introduced by commit 63a6fff ("net: Avoid receiving packets with an
l3mdev on unbound UDP sockets") in v4.11-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d72bb4188c708bb16758c60822fc4dda7a95174]
stable/5.10: [fcaef69c79ec222e55643e666b80b221e70fa6a8]
stable/5.15: [3f2ac2d6511bb0652abf4d7388d65bb9ff1c641c]
stable/5.4: [f39b03bd727a8fea62e82f10fe2e0d753b9930ff]

CVE-2022-49578: ip: Fix data-races around sysctl_ip_prot_sock.

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2022-49578-6d9b@gregkh/

Introduced by commit 4548b68 ("Introduce a sysctl that modifies the
value of PROT_SOCK.") in v4.11-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b55c20f83369dd54541d9ddbe3a018a8377f451]
stable/5.10: [9add240f76af6d141d2eebd3a1558a0e503a993d]
stable/5.15: [95724fe897a4ecf2be51452ef96e818568071664]

CVE-2022-49579: ipv4: Fix data-races around sysctl_fib_multipath_hash_policy.

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49579-4f40@gregkh/

Introduced by commit bf4e0a3 ("net: ipv4: add support for ECMP hash
policy choice") in v4.12-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7998c12a08c97cc26660532c9f90a34bd7d8da5a]
stable/5.15: [21fb844bc1dc1461f5038d655aa1a14f39e13049]

CVE-2022-49580: ipv4: Fix a data-race around sysctl_fib_multipath_use_neigh.

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49580-c398@gregkh/

Introduced by commit a6db449 ("net: ipv4: Consider failed nexthops in
multipath routes") in v4.7-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87507bcb4f5de16bb419e9509d874f4db6c0ad0f]
stable/5.10: [e045d672ba06e1d35bacb56374d350de0ac99066]
stable/5.15: [b8d345db03b4deffb4f04219a51d3b1e94171b76]
stable/5.4: [6727f39e99e0f545d815edebb6c94228485427ec]

CVE-2022-49581: be2net: Fix buffer overflow in be_get_module_eeprom

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49581-b9dc@gregkh/

Introduced by commit e36edd9 ("be2net: add ethtool "-m" option
support") in v3.18-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8ff4f9df73e5c551a72ee6034886c17e8de6596d]
cip/4.4-st: [daf8fc89dc879e6c4d34f660907902656a9aaec2]
mainline: [d7241f679a59cfe27f92cb5c6272cb429fb1f7ec]
stable/4.19: [8ff4f9df73e5c551a72ee6034886c17e8de6596d]
stable/5.10: [665cbe91de2f7c97c51ca8fce39aae26477c1948]
stable/5.15: [aba8ff847f4f927ad7a1a1ee4a9f29989a1a728f]
stable/5.4: [a8569f76df7ec5b4b51155c57523a0b356db5741]

CVE-2022-49582: net: dsa: fix NULL pointer dereference in
dsa_port_reset_vlan_filtering

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49582-8f09@gregkh/

Introduced by commit d0004a0 ("net: dsa: remove the "dsa_to_port in a
loop" antipattern from the core") in v5.16-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1699b4d502eda3c7ea4070debad3ee570b5091b1]

CVE-2022-49583: iavf: Fix handling of dummy receive descriptors

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49583-d8d5@gregkh/

Introduced by commit efa14c3 ("iavf: allow null RX descriptors") in v5.3-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9f49e0060301a9bfebeca76739158d0cf91cdf6]
stable/5.10: [c6af94324911ef0846af1a5ce5e049ca736db34b]
stable/5.15: [2918419c06088f6709ceb543feb01752779ade4c]
stable/5.4: [d88d59faf4e6f9cc4767664206afdb999b10ec77]

CVE-2022-49584: ixgbe: Add locking to prevent panic when setting
sriov_numvfs to zero

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2022-49584-ceae@gregkh/

Introduced by commit d773d13 ("ixgbe: Fix memory leak when SR-IOV VFs
are direct assigned") in v3.6-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e53834ce541d4fe271cdcca7703e50be0a44f8a]
stable/5.10: [b82de63f8f817b5735480293dda8e92ba8170c52]
stable/5.15: [16f929a5e76fd047fd8697e1e568bdd7d771955c]
stable/5.4: [031af9e617a6f51075d97e56fc9e712c7dde2508]

CVE-2022-49585: tcp: Fix data-races around
sysctl_tcp_fastopen_blackhole_timeout.

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49585-659c@gregkh/

Introduced by commit cf1ef3f ("net/tcp_fastopen: Disable active side
TFO in certain scenarios") in v4.12-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [021266ec640c7a4527e6cd4b7349a512b351de1d]
stable/5.10: [0dc2f19d8c2636cebda7976b5ea40c6d69f0d891]
stable/5.15: [a77a75a0e7f397550ab039f96115103e78dd5c69]

CVE-2022-49586: tcp: Fix data-races around sysctl_tcp_fastopen.

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49586-f70a@gregkh/

Introduced by commit 2100c8d ("net-tcp: Fast Open base") in v3.6-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [03da610696a32578fc4f986479341ce9d430df08]
mainline: [5a54213318c43f4009ae158347aa6016e3b9b55a]
stable/4.19: [03da610696a32578fc4f986479341ce9d430df08]
stable/5.10: [22938534c611136f35e2ca545bb668073ca5ef49]
stable/5.15: [539d9ab79eba3974b479cad61a8688c41fe62e12]
stable/5.4: [25d53d858a6c0b89a6e69e376c2a57c4f4c2c8cc]

CVE-2022-49587: tcp: Fix a data-race around sysctl_tcp_notsent_lowat.

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49587-33ba@gregkh/

Introduced by commit c9bee3b ("tcp: TCP_NOTSENT_LOWAT socket option")
in v3.12-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0f75343584ee474303e17efe0610bdd170af1d13]
mainline: [55be873695ed8912eb77ff46d1d1cadf028bd0f3]
stable/4.19: [0f75343584ee474303e17efe0610bdd170af1d13]
stable/5.10: [fd6f1284e380c377932186042ff0b5c987fb2b92]
stable/5.15: [80d4d0c461674eea87f0977e12a2ecd334b9b79c]
stable/5.4: [e9362a993886613ef0284c2a4911c6017c97d803]

CVE-2022-49588: tcp: Fix data-races around sysctl_tcp_migrate_req.

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49588-9a52@gregkh/

Introduced by commit f9ac779 ("net: Introduce
net.ipv4.tcp_migrate_req.") in v5.14-rc1.
Fixed in v5.19-rc8.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [4177f545895b1da08447a80692f30617154efa6e]
stable/5.15: [fcf6c6d8aeffebca66f37b17ef1b57112e5e09c1]

CVE-2022-49589: igmp: Fix data-races around sysctl_igmp_qrv.

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2022-49589-fb90@gregkh/

Introduced by commit a9fe8e2 ("ipv4: implement igmp_qrv sysctl to tune
igmp robustness variable") in v3.18-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9eeb3a7702998bdccbfcc37997b5dd9215b9a7f7]
mainline: [8ebcc62c738f68688ee7c6fec2efe5bc6d3d7e60]
stable/4.19: [9eeb3a7702998bdccbfcc37997b5dd9215b9a7f7]
stable/5.10: [b399ffafffba39f47b731b26a5da1dc0ffc4b3ad]
stable/5.15: [c721324afc589f8ea54bae04756b150aeaae5fa4]
stable/5.4: [e20dd1b0e0ea15bee1e528536a0840dba972ca0e]

CVE-2022-49590: igmp: Fix data-races around sysctl_igmp_llm_reports.

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49590-44d5@gregkh/

Introduced by commit df2cf4a ("IGMP: Inhibit reports for local
multicast groups") in v4.3-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ed876e99ccf417b8bd7fd8408ba5e8b008e46cc8]
mainline: [f6da2267e71106474fbc0943dc24928b9cb79119]
stable/4.19: [ed876e99ccf417b8bd7fd8408ba5e8b008e46cc8]
stable/5.10: [473aad9ad57ff760005377e6f45a2ad4210e08ce]
stable/5.15: [260446eb8e5541402b271343a4516f2b33dec1e4]
stable/5.4: [1656ecaddf90e2a070ec2d2404cdae3edf80faca]

CVE-2022-49591: net: dsa: microchip: ksz_common: Fix refcount leak bug

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49591-68c7@gregkh/

Introduced by commit 912aae2 ("net: dsa: microchip: really look for
phy-mode in port nodes") in v5.9.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a14bd7475452c51835dd5a0cee4c8fa48dd0b539]
stable/5.15: [88ec2ff42da3ac93b2437dc52fe25cd4372148e6]

CVE-2022-49592: net: stmmac: fix dma queue left shift overflow issue

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49592-f07c@gregkh/

Introduced by commit d43042f ("net: stmmac: mapping mtl rx to dma
channel") in v4.12-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [508d86ead36cbd8dfb60773a33276790d668c473]
mainline: [613b065ca32e90209024ec4a6bb5ca887ee70980]
stable/4.19: [508d86ead36cbd8dfb60773a33276790d668c473]
stable/5.10: [a3ac79f38d354b10925824899cdbd2caadce55ba]
stable/5.15: [7c687a893f5cae5ca40d189635602e93af9bab73]
stable/5.4: [573768dede0e2b7de38ecbc11cb3ee47643902dc]

CVE-2022-49593: tcp: Fix a data-race around sysctl_tcp_probe_interval.

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49593-b98d@gregkh/

Introduced by commit 05cbc0d ("ipv4: Create probe timer for tcp PMTU
as per RFC4821") in v4.1-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b3798d3519eda9c409bb0815b0102f27ec42468d]
mainline: [2a85388f1d94a9f8b5a529118a2c5eaa0520d85c]
stable/4.19: [b3798d3519eda9c409bb0815b0102f27ec42468d]
stable/5.10: [c61aede097d350d890fa1edc9521b0072e14a0b8]
stable/5.15: [e6b6f027e2854a51f345a5e3e808d7a88001d4f8]
stable/5.4: [73a11588751a2c13f25d9da8117efc9a79b1843f]

CVE-2022-49594: tcp: Fix a data-race around sysctl_tcp_mtu_probe_floor.

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49594-5cb2@gregkh/

Introduced by commit c04b79b ("tcp: add new tcp_mtu_probe_floor
sysctl") in v5.4-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e92d4423615a5257d0d871fc067aa561f597deb]
stable/5.10: [d5bece4df6090395f891110ef52a6f82d16685db]
stable/5.15: [cc36c37f5fe066c4708e623ead96dc8f57224bf5]
stable/5.4: [033963b220633ed1602d458e7e4ac06afa9fefb2]

CVE-2022-49595: tcp: Fix a data-race around sysctl_tcp_probe_threshold.

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2022-49595-6abc@gregkh/

Introduced by commit 6b58e0a ("ipv4: Use binary search to choose tcp
PMTU probe_size") in v4.1-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [96900fa61777402eb5056269d8000aace33a8b6c]
cip/4.4-st: [1e6bd7d6df1b913f4221439b052e771d42f5753a]
mainline: [92c0aa4175474483d6cf373314343d4e624e882a]
stable/4.19: [96900fa61777402eb5056269d8000aace33a8b6c]
stable/5.10: [d452ce36f2d4c402fa3f5275c9677f80166e7fc6]
stable/5.15: [f524c3e7f6cdad66b3b6a912cef47b656f8b0de3]
stable/5.4: [b04817c94fbd285a967d9b830b274fe9998c9c0b]

CVE-2022-49596: tcp: Fix data-races around sysctl_tcp_min_snd_mss.

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49596-ebcf@gregkh/

Introduced by commit 5f3e2bf ("tcp: add tcp_min_snd_mss sysctl") in v5.2-rc6.
Fixed in v5.19-rc8.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [78eb166cdefcc3221c8c7c1e2d514e91a2eb5014]
stable/5.10: [97992e8feff33b3ae154a113ec398546bbacda80]
stable/5.15: [0fc9357282df055e30990b29f4b7afa53ab42cdb]
stable/5.4: [fdb96b69f5909ffcdd6f1e0902219fc6d7689ff7]

CVE-2022-49597: tcp: Fix data-races around sysctl_tcp_base_mss.

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49597-2087@gregkh/

Introduced by commit 5d424d5 ("[TCP]: MTU probing") in v2.6.20.16.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88d78bc097cd8ebc6541e93316c9d9bf651b13e8]
stable/5.10: [514d2254c7b8aa2d257f5ffc79f0d96be2d6bfda]
stable/5.15: [4d7dea651b7fe0322be95054f64e3711afccc543]
stable/5.4: [30b73edc1d2459ba2c71cb58fbf84a1a6e640fbf]

CVE-2022-49598: tcp: Fix data-races around sysctl_tcp_mtu_probing.

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49598-d784@gregkh/

Introduced by commit 5d424d5 ("[TCP]: MTU probing") in v2.6.20.16.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7e8fc428a7f680f1c4994a40e52d7f95a9a93038]
mainline: [f47d00e077e7d61baf69e46dde3210c886360207]
stable/4.19: [7e8fc428a7f680f1c4994a40e52d7f95a9a93038]
stable/5.10: [77a04845f0d28a3561494a5f3121488470a968a4]
stable/5.15: [aabe9438fdfe004e021d5a206227ec105dbe2416]
stable/5.4: [f966773e13cdd3f12baa90071b7b660f6c633ccb]

CVE-2022-49599: tcp: Fix data-races around sysctl_tcp_l3mdev_accept.

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49599-4a64@gregkh/

Introduced by commit 6dd9a14 ("net: Allow accepted sockets to be bound
to l3mdev domain") in v4.5-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08a75f10679470552a3a443f9aefd1399604d31d]
stable/5.10: [1d9c81833dec46ccb52a1d0db970fefb7c4fa071]
stable/5.15: [9ba9cd43b5776c27d25e5a32dde9e80bdeb1c6a1]

CVE-2022-49600: ip: Fix a data-race around sysctl_ip_autobind_reuse.

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49600-9d38@gregkh/

Introduced by commit 4b01a96 ("tcp: bind(0) remove the SO_REUSEADDR
restriction when ephemeral ports are exhausted.") in v5.7-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0db232765887d9807df8bcb7b6f29b2871539eab]
stable/5.10: [611ba70e5aca252ef43374dda97ed4cf1c47a07c]
stable/5.15: [87ceaa199a72c5856d49a030941fabcd5c3928d4]

CVE-2022-49601: tcp/dccp: Fix a data-race around sysctl_tcp_fwmark_accept.

Announce: https://lore.kernel.org/linux-cve-announce/2025022611-CVE-2022-49601-75fc@gregkh/

Introduced by commit 84f39b0 ("net: support marking accepting TCP
sockets") in v3.16-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [abf70de2ec026ae8d7da4e79bec61888a880e00b]
cip/4.4-st: [5ecdc984c93a1fdf8d69bd38f0cdc5f89d320fa2]
mainline: [1a0008f9df59451d0a17806c1ee1a19857032fa8]
stable/4.19: [abf70de2ec026ae8d7da4e79bec61888a880e00b]
stable/5.10: [d4f65615db7fca3df9f7e79eadf937e6ddb03c54]
stable/5.15: [bf3134feffe61b7a0e21f60a04743f8da0958b53]
stable/5.4: [a7386602a2fe2f6192477e8ede291a815da09d81]

CVE-2022-49602: ip: Fix a data-race around sysctl_fwmark_reflect.

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49602-0366@gregkh/

Introduced by commit e110861 ("net: add a sysctl to reflect the fwmark
on replies") in v3.16-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9096edcf4854289f92252e086cf6e498c7f8c21d]
cip/4.4-st: [dc69bdfc565dcfd0ca14c0cb54e6b3b1fe059dbb]
mainline: [85d0b4dbd74b95cc492b1f4e34497d3f894f5d9a]
stable/4.19: [9096edcf4854289f92252e086cf6e498c7f8c21d]
stable/5.10: [0ee76fe01ff3c0b4efaa500aecc90d7c8d3a8860]
stable/5.15: [dccf8a67f30e18980d13f07006e5a536bbd1e136]
stable/5.4: [25a635a67c830766110410fea88ec4e6ee29684b]

CVE-2022-49603: ip: Fix data-races around sysctl_ip_fwd_update_priority.

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49603-e042@gregkh/

Introduced by commit 432e05d ("net: ipv4: Control SKB reprioritization
after forwarding") in v4.19-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bf9e18d9a5e99e3c83482973557e9f047b051e7]
stable/5.10: [11038fa781ab916535c53351537b22d6d405667d]
stable/5.15: [351f81f7d7185d18a9ff76f8f8c2fa8c4eea563b]

CVE-2022-49604: ip: Fix data-races around sysctl_ip_fwd_use_pmtu.

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49604-eb2c@gregkh/

Introduced by commit f87c10a ("ipv4: introduce
ip_dst_mtu_maybe_forward and protect forwarding path against pmtu
spoofing") in v3.14-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [eb15262128b793e4b1d1c4514d3e6d19c3959764]
mainline: [60c158dc7b1f0558f6cadd5b50d0386da0000d50]
stable/4.19: [eb15262128b793e4b1d1c4514d3e6d19c3959764]
stable/5.10: [b96ed5ccb09ae71103023ed13acefb194f609794]
stable/5.15: [93fbc06da1d819f3981a7bd7928c3641ea67b364]
stable/5.4: [7828309df0f89419a9349761a37c7d1b0da45697]

CVE-2022-49605: igc: Reinstate IGC_REMOVED logic and implement it properly

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49605-fef2@gregkh/

Introduced by commit 146740f ("igc: Add support for PF") in v4.20-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c1ddcee5311f3315096217881d2dbe47cc683f9]
stable/5.10: [77836dbe35382aaf8108489060c5c89530c77494]
stable/5.15: [e75b73081f1ec169518773626c2ff3950476660b]
stable/5.4: [16cb6717f4f42487ef10583eb8bc98e7d1e33d65]

CVE-2022-49606: RDMA/irdma: Fix sleep from invalid context BUG

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49606-3753@gregkh/

Introduced by commit 146b975 ("RDMA/irdma: Add connection manager") in
v5.14-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc0315564d6eec91c716d314b743321be24c70b3]
stable/5.15: [a4c5115140ed1833197bad9a6b80265840ff427f]

CVE-2022-49607: perf/core: Fix data race between
perf_event_set_output() and perf_mmap_close()

Announce: https://lore.kernel.org/linux-cve-announce/2025022612-CVE-2022-49607-bfc4@gregkh/

Introduced by commit 9bb5d40 ("perf: Fix mmap() accounting hole") in v3.10-rc7.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [17f5417194136517ee9bbd6511249e5310e5617c]
cip/4.4-st: [f6ac83a1517193d100bd2cfaaa1d1f46c2472bde]
mainline: [68e3c69803dada336893640110cb87221bb01dcf]
stable/4.19: [17f5417194136517ee9bbd6511249e5310e5617c]
stable/5.10: [43128b3eee337824158f34da6648163d2f2fb937]
stable/5.15: [da3c256e2d0ebc87c7db0c605c9692b6f1722074]
stable/5.4: [98c3c8fd0d4c560e0f8335b79c407bbf7fc9462c]

CVE-2022-49608: pinctrl: ralink: Check for null return of devm_kcalloc

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49608-3814@gregkh/

Introduced by commit a86854d ("treewide: devm_kzalloc() ->
devm_kcalloc()") in v4.18-rc1.
Fixed in v5.19-rc8.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [13596e6c9e541e90e5fc2c52b23f08b951370da9]
mainline: [c3b821e8e406d5650e587b7ac624ac24e9b780a8]
stable/4.19: [13596e6c9e541e90e5fc2c52b23f08b951370da9]
stable/5.10: [5694b162f275fb9a9f89422701b2b963be11e496]
stable/5.15: [44016a85419ca0d4f1e4d0127b330f8e4e2a57d0]
stable/5.4: [6194c021496addc11763d1ffa89ce5751889fe3c]

CVE-2022-49609: power/reset: arm-versatile: Fix refcount leak in
versatile_reboot_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49609-3352@gregkh/

Introduced by commit 0e545f5 ("power: reset: driver for the Versatile
syscon reboot") in v3.18-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6689754b121bd487f99680280102b3a5cd7374af]
cip/4.4-st: [caef4a78dcfa4669aa920b032e10855aa9124d5b]
mainline: [80192eff64eee9b3bc0594a47381937b94b9d65a]
stable/4.19: [6689754b121bd487f99680280102b3a5cd7374af]
stable/5.10: [493ceca3271316e74639c89ff8ac35883de64256]
stable/5.15: [71ab83ac65e2d671552374123bf920c1d698335a]
stable/5.4: [78bdf732cf5d74d1c6ecda06830a91f80a4aef6f]

CVE-2022-49610: KVM: VMX: Prevent RSB underflow before vmenter

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49610-5628@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc7.


Fixed status
mainline: [07853adc29a058c5fd143c14e5ac528448a72ed9]

CVE-2022-49611: x86/speculation: Fill RSB on vmexit for IBRS

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49611-737d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc7.


Fixed status
cip/4.19-st: [f744b88dfc201bf8092833ec70b23c720188b527]
mainline: [9756bba28470722dacb79ffce554336dd1f6a6cd]
stable/4.19: [f744b88dfc201bf8092833ec70b23c720188b527]
stable/5.10: [4d7f72b6e1bc630bec7e4cd51814bc2b092bf153]
stable/5.15: [8d5cff499a6d740c91ff37963907e0e983c37f0f]
stable/5.4: [17a9fc4a7b91f8599223631bb6ae6416bc0de1c0]

CVE-2022-49612: power: supply: core: Fix boundary conditions in interpolation

Announce: https://lore.kernel.org/linux-cve-announce/2025022613-CVE-2022-49612-8875@gregkh/

Introduced by commit a4585ba ("power: supply: core: Use library
interpolation") in v5.17-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [093d27bb6f2d1963f927ef59c9a2d37059175426]

CVE-2022-49613: serial: 8250: Fix PM usage_count for console handover

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49613-32fa@gregkh/

Introduced by commit bedb404 ("serial: 8250_port: Don't use power
management for kernel console") in v5.7-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9b11229b79c0fb2100b5bb4628a101b1d37fbf6]
stable/5.10: [d9cb6fabc90102f9e61fe35bd0160db88f4f53b4]
stable/5.15: [190ce5cdc55d1b66ea582ac2be6fd5a72e3cc486]

CVE-2022-49614: nvme: use struct group for generic command dwords

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49614-b2a0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc6.


Fixed status
mainline: [5c629dc9609dc43492a7bc8060cc6120875bf096]

CVE-2022-49615: ASoC: rt711-sdca: fix kernel NULL pointer dereference
when IO error

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49615-e815@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc6.


Fixed status
mainline: [1df793d479bef546569fc2e409ff8bb3f0fb8e99]
stable/5.15: [269be8b2907378adf72d7347cfa43ef230351a06]

CVE-2022-49616: ASoC: rt7*-sdw: harden jack_detect_handler

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49616-5eb4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc6.


Fixed status
mainline: [0484271ab0ce50649329fa9dc23c50853c5b26a4]
stable/5.15: [07a606e1389a63b61cb8cd591026f30529117573]

CVE-2022-49617: ASoC: Intel: sof_sdw: handle errors on card registration

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49617-44c8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc6.


Fixed status
mainline: [fe154c4ff376bc31041c6441958a08243df09c99]
stable/5.15: [f2556ce6b35ae0fc72000a4daa21ded12665e2f2]

CVE-2022-49618: pinctrl: aspeed: Fix potential NULL dereference in
aspeed_pinmux_set_mux()

Announce: https://lore.kernel.org/linux-cve-announce/2025022614-CVE-2022-49618-6279@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc6.


Fixed status
mainline: [84a85d3fef2e75b1fe9fc2af6f5267122555a1ed]
stable/5.10: [ef1e38532f4b2f0f3b460e938a2e7076c3bed5ee]
stable/5.15: [3cb392b64304a05bf647e2e44efacd9a1f3c3c6a]

CVE-2022-49619: net: sfp: fix memory leak in sfp_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49619-bba8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc5.


Fixed status
cip/4.19-st: [1545bc727625ea6e8decd717e5d1e8cc704ccf8f]
mainline: [0a18d802d65cf662644fd1d369c86d84a5630652]
stable/4.19: [1545bc727625ea6e8decd717e5d1e8cc704ccf8f]
stable/5.10: [67dc32542a1fb7790d0853cf4a5cf859ac6a2002]
stable/5.15: [204543581a2f26bb3b997a304c0bd06926ba7f15]
stable/5.4: [ede990cfc42775bd0141e21f37ee365dcaeeb50f]

CVE-2022-49620: net: tipc: fix possible refcount leak in tipc_sk_create()

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49620-dca0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc5.


Fixed status
cip/4.19-st: [ef488669b2652bde5b6ee5a409a5b048a2a50db4]
mainline: [00aff3590fc0a73bddd3b743863c14e76fd35c0c]
stable/4.19: [ef488669b2652bde5b6ee5a409a5b048a2a50db4]
stable/5.10: [efa78f2ae363428525fb4981bb63c555ee79f3c7]
stable/5.15: [833ecd0eae76eadf81d6d747bb5bc992d1151867]
stable/5.4: [4919d82f7041157a421ca9bf39a78551d5ad8a1b]

CVE-2022-49621: cpufreq: pmac32-cpufreq: Fix refcount leak bug

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49621-ac28@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc5.


Fixed status
cip/4.19-st: [4585890ab2dbf455d80e254d3d859d4c1e357920]
cip/4.4-st: [c308e3f9bd1ba5d91109c84035f292d9226a752e]
mainline: [ccd7567d4b6cf187fdfa55f003a9e461ee629e36]
stable/4.19: [4585890ab2dbf455d80e254d3d859d4c1e357920]
stable/5.10: [3ea9dbf7c2f436952bca331c6f5d72f75aca224e]
stable/5.15: [57289b6601fe78c09921599b042a0b430fb420ec]
stable/5.4: [8dda30f81c751b01cd71f2cfaeef26ad4393b1d1]

CVE-2022-49622: netfilter: nf_tables: avoid skb access on nf_stolen

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49622-bd19@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc5.


Fixed status
mainline: [e34b9ed96ce3b06c79bf884009b16961ca478f87]

CVE-2022-49623: powerpc/xive/spapr: correct bitmap allocation size

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49623-53ab@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc5.


Fixed status
mainline: [19fc5bb93c6bbdce8292b4d7eed04e2fa118d2fe]
stable/5.15: [10f2cd373e65bcd3be8f3cdc71c330c25763dfd8]

CVE-2022-49624: net: atlantic: remove aq_nic_deinit() when resume

Announce: https://lore.kernel.org/linux-cve-announce/2025022615-CVE-2022-49624-caf9@gregkh/

Introduced by commit 1809c30 ("net: atlantic: always deep reset on pm
op, fixing up my null deref regression") in v5.18-rc7.
Fixed in v5.19-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [2e15c51fefaffaf9f72255eaef4fada05055e4c5]
stable/5.10: [c2978d0124f26e453ed30fda6a37f62d8c7f19cb]
stable/5.15: [58c90993933e7a76305519bc70da8c0cd2907c1f]

CVE-2022-49625: sfc: fix kernel panic when creating VF

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49625-2fa2@gregkh/

Introduced by commit d778819 ("sfc: DMA the VF stats only when
requested") in v4.2-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [82bcb730f856086f033e6c04082eb4503d4c2fa4]
cip/4.4-st: [d499bdbf99670406d40e72ab6b435c426be994be]
mainline: [ada74c5539eba06cf8b47d068f92e0b3963a9a6e]
stable/4.19: [82bcb730f856086f033e6c04082eb4503d4c2fa4]
stable/5.10: [b82e4ad58a7fb72456503958a93060f87896e629]
stable/5.15: [68e5f32f0de9594629ff9e599294d9801c6187de]
stable/5.4: [da346adcf5573fd8663cabfdfe8371009629a906]

CVE-2022-49626: sfc: fix use after free when disabling sriov

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49626-e785@gregkh/

Introduced by commit 3c5eb87 ("sfc: create vports for VFs and assign
random MAC addresses") in v4.2-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9c854ae512b89229aeee93849e9bd4c115b37909]
cip/4.4-st: [c936b051eeab4545e5461ee3c5825c997e920df7]
mainline: [ebe41da5d47ac0fff877e57bd14c54dccf168827]
stable/4.19: [9c854ae512b89229aeee93849e9bd4c115b37909]
stable/5.10: [c2240500817b3b4b996cdf2a461a3a5679f49b94]
stable/5.15: [58d93e9d160c0de6d867c7eb4c2206671a351eb1]
stable/5.4: [bcad880865bfb421885364b1f0c7351280fe2b97]

CVE-2022-49627: ima: Fix potential memory leak in ima_init_crypto()

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49627-ec2b@gregkh/

Introduced by commit 6d94809 ("ima: Allocate and initialize tfm for
each PCR bank") in v5.8-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [067d2521874135267e681c19d42761c601d503d6]
stable/5.10: [c1d9702ceb4a091da6bee380627596d1fba09274]
stable/5.15: [601ae26aa2802a4c10c94d7388a99eabdbefab2b]

CVE-2022-49628: net: stmmac: fix leaks in probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49628-0794@gregkh/

Introduced by commit 2bb4b98 ("net: stmmac: Add Ingenic SoCs MAC
support.") in v5.14-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23aa6d5088e3bd65de77c5c307237b9937f8b48a]
stable/5.15: [f4bd3202a2b4194ab6c0ce61628095d54f994db4]

CVE-2022-49629: nexthop: Fix data-races around nexthop_compat_mode.

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49629-c5d3@gregkh/

Introduced by commit 4f80116 ("net: ipv4: add sysctl for nexthop api
compatibility mode") in v5.8-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bdf00bf24bef9be1ca641a6390fd5487873e0d2e]
stable/5.10: [a51040d4b120f3520df64fb0b9c63b31d69bea9b]
stable/5.15: [0d17723afea3ae8c9f245c9bbd2ba5945b77e812]

CVE-2022-49630: tcp: Fix a data-race around sysctl_tcp_ecn_fallback.

Announce: https://lore.kernel.org/linux-cve-announce/2025022616-CVE-2022-49630-71c3@gregkh/

Introduced by commit 4921355 ("tcp: add rfc3168, section 6.1.1.1.
fallback") in v4.2-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12b8d9ca7e678abc48195294494f1815b555d658]
stable/5.15: [8bcf7339f2cf70ea4461df6ea045d1aadfabfa11]

CVE-2022-49631: raw: Fix a data-race around sysctl_raw_l3mdev_accept.

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49631-b546@gregkh/

Introduced by commit 6897445 ("net: provide a sysctl raw_l3mdev_accept
for raw socket lookup with VRFs") in v5.0-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1dace014928e6e385363032d359a04dee9158af0]
stable/5.10: [038a87b3e460d2ee579c8b1bd3890d816d6687b1]
stable/5.15: [46e9c46203fd4676720ddca0fef7eff26826648e]
stable/5.4: [cc9540ba5b3652c473af7e54892a48cdced87983]

CVE-2022-49632: icmp: Fix a data-race around
sysctl_icmp_errors_use_inbound_ifaddr.

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49632-ea1e@gregkh/

Introduced by commit 1c2fb7f ("[IPV4]: Sysctl configurable icmp error
source address.") in v2.6.12.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2efabce81db7eed1c98fa1a3f203f0edd738ac3]
stable/5.15: [de9490c32bc10020efdd1509689a28f197d6dfb8]

CVE-2022-49633: icmp: Fix data-races around sysctl_icmp_echo_enable_probe.

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49633-ddaf@gregkh/

Introduced by commit d329ea5 ("icmp: add response to RFC 8335 PROBE
messages") in v5.13-rc1.
Introduced by commit 1fd07f3 ("ipv6: ICMPV6: add response to ICMPV6
RFC 8335 PROBE messages") in v5.14-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a2f7083cc6cb72dade9a63699ca352fad26d1cd]
stable/5.15: [cce955efa0ab81f7fb72e22beed372054c86005c]

CVE-2022-49634: sysctl: Fix data-races in proc_dou8vec_minmax().

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49634-4a89@gregkh/

Introduced by commit cb94441 ("sysctl: add proc_dou8vec_minmax()") in v5.13-rc1.
Fixed in v5.18.13.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [5f776daef0b5354615ec4b4234cd9539ca05f273]
stable/5.10: [f177b382c33900d0e5a9766493c11a1074076f78]
stable/5.15: [f177b382c33900d0e5a9766493c11a1074076f78]

CVE-2022-49635: drm/i915/selftests: fix subtraction overflow bug

Announce: https://lore.kernel.org/linux-cve-announce/2025022617-CVE-2022-49635-af1b@gregkh/

Introduced by commit e1c5f75 ("drm/i915: Avoid overflow in computing
pot_hole loop termination") in v4.12-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [333991c4e66b3d4b5613315f18016da80344f659]

CVE-2022-49636: vlan: fix memory leak in vlan_newlink()

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49636-b283@gregkh/

Introduced by commit 37aa50c ("vlan: introduce
vlan_dev_free_egress_priority") in v5.17-rc4.
Fixed in v5.19-rc7.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [72a0b329114b1caa8e69dfa7cdad1dd3c69b8602]

CVE-2022-49637: ipv4: Fix a data-race around sysctl_fib_sync_mem.

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49637-402f@gregkh/

Introduced by commit 9ab948a ("ipv4: Allow amount of dirty memory from
fib resizing to be controllable") in v5.2-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [73318c4b7dbd0e781aaababff17376b2894745c0]
stable/5.10: [418b191d5f223a8cb6cab09eae1f72c04ba6adf2]
stable/5.15: [9be8aac91960ea32fd0e874758c9afee665c57d2]
stable/5.4: [7c1acd98fb221dc0d847451b9ab86319f8b9916c]

CVE-2022-49638: icmp: Fix data-races around sysctl.

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49638-e524@gregkh/

Introduced by commit 4cdf507 ("icmp: add a global rate limitation") in
v3.18-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [edeec63b13c252193d626c2a48d7a2f0e7016dc2]
cip/4.4-st: [fb87028999184e2af2c6b3ae945bc331e6193c05]
mainline: [48d7ee321ea5182c6a70782aa186422a70e67e22]
stable/4.19: [edeec63b13c252193d626c2a48d7a2f0e7016dc2]
stable/5.10: [e088ceb73c24ab4774da391d54a6426f4bfaefce]
stable/5.15: [e2828e8c605853f71267825c9415437c0a93e4f2]
stable/5.4: [0cba7ca667ceb06934746ddd9833a25847bde81d]

CVE-2022-49639: cipso: Fix data-races around sysctl.

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49639-a1b4@gregkh/

Introduced by commit 446fda4 ("[NetLabel]: CIPSOv4 engine") in v2.6.20.16.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ca26ca5e2f3eeb3e6fe699cd6effa3b4b2aa8698]
cip/4.4-st: [95f08489dbda66ee8bc31894b08bf2ba99e8f5f4]
mainline: [dd44f04b9214adb68ef5684ae87a81ba03632250]
stable/4.19: [ca26ca5e2f3eeb3e6fe699cd6effa3b4b2aa8698]
stable/5.10: [fe2a35fa2c4f9c8ce5ef970eb927031387f9446a]
stable/5.15: [07b0caf8aeb9b82e6ecc6c292a3e47c7fcdb1148]
stable/5.4: [0e41a0f73ccb9be112a80bde3804a771633caaef]

CVE-2022-49640: sysctl: Fix data races in proc_douintvec_minmax().

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49640-96ed@gregkh/

Introduced by commit 61d9b56 ("sysctl: add unsigned int range
support") in v4.13-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d3b559df3ed39258737789aae2ae7973d205bc1]
stable/5.10: [e3a2144b3b6bf9ecafd91087c8b8b48171ec19df]
stable/5.15: [40e0477a7371d101c55b69d9c32a7a1ed82ab5ea]

CVE-2022-49641: sysctl: Fix data races in proc_douintvec().

Announce: https://lore.kernel.org/linux-cve-announce/2025022618-CVE-2022-49641-00e7@gregkh/

Introduced by commit e7d316a ("sysctl: handle error writing UINT_MAX
to u32 fields") in v4.8-rc4.
Fixed in v5.19-rc7.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [4762b532ec9539755aab61445d5da6e1926ccb99]
stable/5.10: [d5d54714e329f646bd7af4994fc427d88ee68936]
stable/5.15: [d335db59f7fb3353f56e52371f1ee796ae9c8f09]

CVE-2022-49642: net: stmmac: dwc-qos: Disable split header for Tegra194

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49642-dbbe@gregkh/

Introduced by commit 67afd6d ("net: stmmac: Add Split Header support
and enable it in XGMAC cores") in v5.4-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [029c1c2059e9c4b38f97a06204cdecd10cfbeb8a]
stable/5.10: [9cc8edc571b871d974b3289868553f9ce544aba6]
stable/5.15: [d5c315a787652c35045044877a249f7d5c8a4104]
stable/5.4: [2968830c9b47ce093237483c6207c61065712386]

CVE-2022-49643: ima: Fix a potential integer overflow in
ima_appraise_measurement

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49643-ae05@gregkh/

Introduced by commit 39b0709 ("ima: Implement support for module-style
appended signatures") in v5.4-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2ee2cfc4aa85ff6a2a3b198a3a524ec54e3d999]
stable/5.10: [831e190175f10652be93b08436cc7bf2e62e4bb6]
stable/5.15: [c8d5d81940938b5f6c0f495ca9538e7740416f30]
stable/5.4: [388f3df7c3c8b7f2a32b9ae0a9b2f9f6ad3b1b77]

CVE-2022-49644: drm/i915: fix a possible refcount leak in
intel_dp_add_mst_connector()

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49644-e3b0@gregkh/

Introduced by commit 091a4f9 ("drm/i915: Handle drm-layer errors in
intel_dp_add_mst_connector") in v4.15-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85144df9ff4652816448369de76897c57cbb1b93]
stable/5.10: [592f3bad00b7e2a95a6fb7a4f9e742c061c9c3c1]
stable/5.15: [505114dda5bbfd07f4ce9a2df5b7d8ef5f2a1218]
stable/5.4: [72f231b9a88abcfac9f5ddaa1a0aacb3f9f87ba5]

CVE-2022-49645: drm/panfrost: Fix shrinker list corruption by madvise IOCTL

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49645-03ab@gregkh/

Introduced by commit 013b651 ("drm/panfrost: Add madvise and shrinker
support") in v5.4-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fc33eaaa979d112d10fea729edcd2a2e21aa912]
stable/5.10: [0581613df7f9a4c5fac096ce1d5fb15b7b994240]
stable/5.15: [1807d8867402a58b831a7fc16832747ff559a0d1]
stable/5.4: [393594aad55179eb761af41533d8d1d6eb4543b0]

CVE-2022-49646: wifi: mac80211: fix queue selection for mesh/OCB interfaces

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49646-248b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc7.


Fixed status
mainline: [50e2ab39291947b6c6c7025cf01707c270fcde59]
stable/5.10: [e013ea2a51a94b903b396a8dff531a07d470335d]
stable/5.15: [5a9df31017999197b6e60535940f2f2fe1bd3b0d]
stable/5.4: [444be5a02b77f3b7a8ac9c1a0b074fbb3bd89cd0]

CVE-2022-49647: cgroup: Use separate src/dst nodes when preloading
css_sets for migration

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49647-b3cb@gregkh/

Introduced by commit f817de9 ("cgroup: prepare migration path for
unified hierarchy") in v3.16-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cec2bbdcc14fbaa6b95ee15a7c423b05d97038be]
mainline: [07fd5b6cdf3cc30bfde8fe0f644771688be04447]
stable/4.19: [cec2bbdcc14fbaa6b95ee15a7c423b05d97038be]
stable/5.10: [7657e3958535d101a24ab4400f9b8062b9107cc4]
stable/5.15: [54aee4e5ce8c21555286a6333e46c1713880cf93]
stable/5.4: [ad44e05f3e016bdcb1ad25af35ade5b5f41ccd68]

CVE-2022-49648: tracing/histograms: Fix memory leak problem

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49648-ffaa@gregkh/

Introduced by commit 46bbe5c ("tracing: fix double free") in v5.9-rc7.
Fixed in v5.19-rc7.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
cip/4.19-st: [eb622d5580b9e2ff694f62da6410618bd73853cb]
mainline: [7edc3945bdce9c39198a10d6129377a5c53559c2]
stable/4.19: [eb622d5580b9e2ff694f62da6410618bd73853cb]
stable/5.10: [78a1400c42ee11197eb1f0f85ba51df9a4fdfff0]
stable/5.15: [22eeff55679d9e7c0f768c79bfbd83e2f8142d89]
stable/5.4: [ecc6dec12c33aa92c086cd702af9f544ddaf3c75]

CVE-2022-49649: xen/netback: avoid entering xenvif_rx_next_skb() with
an empty rx queue

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49649-7285@gregkh/

Introduced by commit 98f6d57 ("xen-netback: process guest rx packets
in batches") in v4.9-rc1.
Fixed in v5.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5a071aefd6414af5a20321ab58a0557b81993687]
mainline: [94e8100678889ab428e68acadf042de723f094b9]
stable/4.19: [5a071aefd6414af5a20321ab58a0557b81993687]
stable/5.10: [b9c32a6886af79d6e0ad87a7b01800ed079cdd02]
stable/5.15: [b99174ac57fe5d8867448c03b23828e63f24cb1c]
stable/5.4: [7425479d20f9e96f7c3ec8e8a93fe0d7478724cb]

CVE-2022-49650: dmaengine: qcom: bam_dma: fix runtime PM underflow

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49650-c3d8@gregkh/

Introduced by commit dbad41e ("dmaengine: qcom: bam_dma: check if the
runtime pm enabled") in v4.17-rc6.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ac9c3dd0d6fe293cd5044cfad10bec27d171e4e]
stable/5.15: [2f6ded79068cac8cff41d5d5632564165d98ee12]

CVE-2022-49651: srcu: Tighten cleanup_srcu_struct() GP checks

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49651-601b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc1.


Fixed status
mainline: [8ed00760203d8018bee042fbfe8e076579be2c2b]

CVE-2022-49652: dmaengine: ti: Fix refcount leak in ti_dra7_xbar_route_allocate

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49652-0369@gregkh/

Introduced by commit ec9bfa1 ("dmaengine: ti-dma-crossbar: dra7: Use
bitops instead of idr") in v4.5-rc1.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3bd66010398871807c1cebacee07d60ded1b1402]
mainline: [c132fe78ad7b4ce8b5d49a501a15c29d08eeb23a]
stable/4.19: [3bd66010398871807c1cebacee07d60ded1b1402]
stable/5.10: [37147e22cd8dfc0412495cb361708836157a4486]
stable/5.15: [cb9813d7eae917acd34436160a278b8b5d48ca53]
stable/5.4: [b31ab132561c7f1b6459039152b8d09e44eb3565]

CVE-2022-49653: i2c: piix4: Fix a memory leak in the EFCH MMIO support

Announce: https://lore.kernel.org/linux-cve-announce/2025022620-CVE-2022-49653-f6b6@gregkh/

Introduced by commit 7c14872 ("i2c: piix4: Add EFCH MMIO support to
region request and release") in v5.18-rc1.
Fixed in v5.19-rc6.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [8ad59b397f86a4d8014966fdc0552095a0c4fb2b]
stable/5.15: [d2bf1a6480e8d44658a8ac3bdcec081238873212]

CVE-2022-49654: net: dsa: qca8k: reset cpu port on MTU change

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49654-4ed4@gregkh/

Introduced by commit f58d259 ("net: dsa: qca8k: implement the port MTU
callbacks") in v5.9-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [386228c694bf1e7a7688e44412cb33500b0ac585]
stable/5.15: [188c798f3c2554fa0d7147e9b97baf144b817019]

CVE-2022-49655: fscache: Fix invalidation/lookup race

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49655-0370@gregkh/

Introduced by commit d24af13 ("fscache: Implement cookie
invalidation") in v5.17-rc1.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85e4ea1049c70fb99de5c6057e835d151fb647da]

CVE-2022-49656: ARM: meson: Fix refcount leak in meson_smp_prepare_cpus

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49656-830e@gregkh/

Introduced by commit d850f3e ("ARM: meson: Add SMP bringup code for
Meson8 and Meson8b") in v4.15-rc1.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2e1bcd33478ef44e63a45457055060b5fe4118ad]
mainline: [34d2cd3fccced12b958b8848e3eff0ee4296764c]
stable/4.19: [2e1bcd33478ef44e63a45457055060b5fe4118ad]
stable/5.10: [3d90607e7e6afa89768b0aaa915b58bd2b849276]
stable/5.15: [7208101ded1e9dcc52c8f0f8b16474211c871c1a]
stable/5.4: [3cf8ece9113242c10f83c7675ea4f4f67959ee43]

CVE-2022-49657: usbnet: fix memory leak in error case

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49657-0cbf@gregkh/

Introduced by commit 877bd86 ("usbnet: introduce usbnet 3 command
helpers") in v3.8-rc1.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d5165e657987ff4ba0ace896d4376a3718a9fbc3]
cip/4.4-st: [bb16c917e6f7c8f086435239abf83f94a2e6ef77]
mainline: [b55a21b764c1e182014630fa5486d717484ac58f]
stable/4.19: [d5165e657987ff4ba0ace896d4376a3718a9fbc3]
stable/5.10: [0085da9df3dced730027923a6b48f58e9016af91]
stable/5.15: [db89582ff330556188da856e01382ccbf3a5e706]
stable/5.4: [04894ab34faf40ab72a8a5ab5b404bb0606bbbff]

CVE-2022-49658: bpf: Fix insufficient bounds propagation from
adjust_scalar_min_max_vals

Announce: https://lore.kernel.org/linux-cve-announce/2025022621-CVE-2022-49658-37f3@gregkh/

Introduced by commit b03c9f9 ("bpf/verifier: track signed and unsigned
min/max values") in v4.14-rc1.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3844d153a41adea718202c10ae91dc96b37453b5]
stable/5.10: [e917be1f83ea14a68b3cf64d3da9968eaf991dae]
stable/5.15: [a7de8d436db92bab8b1f44624297c2554a6ac36b]

CVE-2022-49659: can: m_can: m_can_{read_fifo,echo_tx_event}(): shift
timestamp to full 32 bits

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49659-31c4@gregkh/

Introduced by commit 1be37d3 ("can: m_can: fix periph RX path: use
rx-offload to ensure skbs are sent from softirq context") in
v5.13-rc1.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c3333693f07313f5f0145a922f14a7d3c0f4f21]
stable/5.15: [c7333f79888497bfd75dcd02a94eaf836dd1042c]

CVE-2022-49661: can: gs_usb: gs_usb_open/close(): fix memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49661-c53c@gregkh/

Introduced by commit d08e973 ("can: gs_usb: Added support for the
GS_USB CAN devices") in v3.16-rc1.
Fixed in v5.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d91492638b054f4a359621ef216242be5973ed6b]
cip/4.4-st: [3128f9deceb9c57dcf4e47f56f5ad74de1413f5f]
mainline: [2bda24ef95c0311ab93bda00db40486acf30bd0a]
stable/4.19: [d91492638b054f4a359621ef216242be5973ed6b]
stable/5.10: [d0b8e223998866b3e7b2895927d4e9689b0a80d8]
stable/5.15: [0e60230bc64355c80abe993d1719fdb318094e20]
stable/5.4: [6f655b5e13fa4b27e915b6c209ac0da74fd75963]

CVE-2022-49662: ipv6: fix lockdep splat in in6_dump_addrs()

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49662-3875@gregkh/

Introduced by commit 88e2ca3 ("mld: convert ifmcaddr6 to RCU") in v5.13-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e43e64d0f1332fcc503babad4dc31aead7131ca]
stable/5.15: [2930ee1a166df0e12fe9fec4b79cc3dc9634ae45]

CVE-2022-49663: tunnels: do not assume mac header is set in
skb_tunnel_check_pmtu()

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49663-2213@gregkh/

Introduced by commit 4cb47a8 ("tunnels: PMTU discovery support for
directly bridged IP packets") in v5.9-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [853a7614880231747040cada91d2b8d2e995c51a]
stable/5.10: [59c51c3b545128a92ebfb6dbae990d3abee110e7]
stable/5.15: [674a641e5b67e16ba3112eacd680ff87b38539de]

CVE-2022-49664: tipc: move bc link creation back to tipc_node_create

Announce: https://lore.kernel.org/linux-cve-announce/2025022622-CVE-2022-49664-d3af@gregkh/

Introduced by commit 4cbf8ac ("tipc: enable creating a "preliminary"
node") in v5.5-rc1.
Fixed in v5.19-rc5.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [cb8092d70a6f5f01ec1490fce4d35efed3ed996c]
stable/5.10: [456bc338871c4a52117dd5ef29cce3745456d248]
stable/5.15: [35fcb2ba35b4d9b592b558c3bcc6e0d90e213588]

CVE-2022-49665: platform/x86: thinkpad_acpi: Fix a memory leak of EFCH
MMIO resource

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49665-502b@gregkh/

Introduced by commit 455cd86 ("platform/x86: thinkpad_acpi: Add a
s2idle resume quirk for a number of laptops") in v5.18-rc7.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2f33f0c3ad7b0d5262d9b986f1353265fad7a08]

CVE-2022-49666: powerpc/memhotplug: Add add_pages override for PPC

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49666-98ab@gregkh/

Introduced by commit ffa0b64 ("powerpc: Fix virt_addr_valid() for
64-bit Book3E & 32-bit") in v5.18-rc2.
Fixed in v5.19-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [ac790d09885d36143076e7e02825c541e8eee899]
stable/5.15: [89296ac435e2cf8a5101f7fab8f0c7b754b92052]

CVE-2022-49667: net: bonding: fix use-after-free after 802.3ad slave unbind

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49667-4710@gregkh/

Introduced by commit 0622cab ("bonding: fix 802.3ad aggregator
reselection") in v4.7-rc6.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f162f7c348fa2a5555bafdb5cc890b89b221e69c]
cip/4.4-st: [65f56da6ff723e4a84b68d8aeda268ac950d7969]
mainline: [050133e1aa2cb49bb17be847d48a4431598ef562]
stable/4.19: [f162f7c348fa2a5555bafdb5cc890b89b221e69c]
stable/5.10: [63b2fe509f69b90168a75e04e14573dccf7984e6]
stable/5.15: [ef0af7d08d26c5333ff4944a559279464edf6f15]
stable/5.4: [893825289ba840afd86bfffcb6f7f363c73efff8]

CVE-2022-49668: PM / devfreq: exynos-ppmu: Fix refcount leak in
of_get_devfreq_events

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49668-1793@gregkh/

Introduced by commit f262f28 ("PM / devfreq: event: Add devfreq_event
class") in v4.0-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f44b799603a9b5d2e375b0b2d54dd0b791eddfc2]
stable/5.10: [e65027fdebbacd40595e96ef7b5d2418f71bddf2]
stable/5.15: [01121e39ef537289926ae6f5374dce92c796d863]
stable/5.4: [bdecd912e99acfd61507f1720d3f4eed1b3418d8]

CVE-2022-49669: mptcp: fix race on unaccepted mptcp sockets

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49669-44d5@gregkh/

Introduced by commit 86e39e0 ("mptcp: keep track of local endpoint
still available for each msk") in v5.17-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6aeed9045071f2252ff4e98fc13d1e304f33e5b0]

CVE-2022-49670: linux/dim: Fix divide by 0 in RDMA DIM

Announce: https://lore.kernel.org/linux-cve-announce/2025022623-CVE-2022-49670-0b7b@gregkh/

Introduced by commit f491545 ("linux/dim: Implement RDMA adaptive
moderation (DIM)") in v5.3-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fe3dbbefb74a8575f61d7801b08dbc50523d60d]
stable/5.10: [fae2a9fb1eaf348ad8732f90d42ebbb971bd7e95]
stable/5.15: [0b6e0eb5c45e79e9095de2498cc0ca5ec563fc5e]
stable/5.4: [5af106f8e072aebd88b95e164a08fa320651a99a]

CVE-2022-49671: RDMA/cm: Fix memory leak in ib_cm_insert_listen

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49671-62fb@gregkh/

Introduced by commit 98f6715 ("RDMA/cm: Simplify establishing a listen
cm_id") in v5.7-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2990f223ffa7bb25422956b9f79f9176a5b38346]
stable/5.10: [b0cab8b517aeaf2592c3479294f934209c41a26f]
stable/5.15: [889000874c1204e47c7f2a4945db262a47e7efc9]

CVE-2022-49672: net: tun: unlink NAPI from device on destruction

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49672-e5ec@gregkh/

Introduced by commit 9431709 ("tun: enable NAPI for TUN/TAP driver")
in v4.15-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [82e729aee59acefe135fceffadcbc5b86dd4f1b9]
mainline: [3b9bc84d311104906d2b4995a9a02d7b7ddab2db]
stable/4.19: [82e729aee59acefe135fceffadcbc5b86dd4f1b9]
stable/5.10: [bec1be0a745ab420718217e3e0d9542a75108989]
stable/5.15: [8145f77d38de4f88b8a69e1463f5c09ba189d77c]
stable/5.4: [a8cf919022373c97a84fe596bbea544f909c485d]

CVE-2022-49673: dm raid: fix KASAN warning in raid5_add_disks

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49673-0197@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc5.


Fixed status
cip/4.19-st: [3553a69bb52be2deba61d0ca064c41aee842bb35]
cip/4.4-st: [a9169bd50890598daba649ca4b7197ca891cd56d]
mainline: [617b365872a247480e9dcd50a32c8d1806b21861]
stable/4.19: [3553a69bb52be2deba61d0ca064c41aee842bb35]
stable/5.10: [d8bca518d5272fe349e0a722fdb9e3acb661f3f0]
stable/5.15: [d5b06039b195d4b6f94f5d345b1e4ac1975a9832]
stable/5.4: [f157bd9cf377a947fdb7035e69466b6ecdc17c17]

CVE-2022-49674: dm raid: fix accesses beyond end of raid member array

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49674-90d4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc5.


Fixed status
cip/4.19-st: [df1a5ab0dd0775f2ea101c71f2addbc4c0ea0f85]
mainline: [332bd0778775d0cf105c4b9e03e460b590749916]
stable/4.19: [df1a5ab0dd0775f2ea101c71f2addbc4c0ea0f85]
stable/5.10: [9bf2b0757b04c78dc5d6e3a198acca98457b32a1]
stable/5.15: [6352b2f4d8e95ec0ae576d7705435d64cfa29503]
stable/5.4: [90de15357504c8097ab29769dc6852e16281e9e8]

CVE-2022-49675: tick/nohz: unexport __init-annotated tick_nohz_full_setup()

Announce: https://lore.kernel.org/linux-cve-announce/2025022624-CVE-2022-49675-17aa@gregkh/

Introduced by commit ae9e557 ("time: Export tick start/stop functions
for rcutorture") in v5.5-rc1.
Fixed in v5.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2390095113e98fc52fffe35c5206d30d9efe3f78]
stable/5.10: [c4ff3ffe0138234774602152fe67e3a898c615c6]
stable/5.15: [f4a80ec8c51d68be4b7a7830c510f75080c5e417]

CVE-2022-49676: memory: samsung: exynos5422-dmc: Fix refcount leak in
of_get_dram_timings

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49676-d16b@gregkh/

Introduced by commit 6e7674c ("memory: Add DMC driver for Exynos5422")
in v5.5-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1332661e09304b7b8e84e5edc11811ba08d12abe]
stable/5.10: [889aad2203e09eed2071ca8985c25e9d6aea5735]
stable/5.15: [cde4480b5ab06195b9164184b0c02ced71e601b4]

CVE-2022-49677: ARM: cns3xxx: Fix refcount leak in cns3xxx_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49677-8643@gregkh/

Introduced by commit 415f591 ("ARM: cns3xxx: initial DT support") in v3.10-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [68d4303bf59662b64bd555e2aa0518282d20aa4f]
cip/4.4-st: [5a2642b59ce80349d3adcbf48c37170322195b7f]
mainline: [1ba904b6b16e08de5aed7c1349838d9cd0d178c5]
stable/4.19: [68d4303bf59662b64bd555e2aa0518282d20aa4f]
stable/5.10: [c980392af1473d6d5662f70d8089c8e6d85144a4]
stable/5.15: [da3ee7cd2f15922ad88a7ca6deee2eafdc7cd214]
stable/5.4: [d1359e4129ad43e43972a28838b87291c51de23d]

CVE-2022-49678: soc: bcm: brcmstb: pm: pm-arm: Fix refcount leak in
brcmstb_pm_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49678-d39c@gregkh/

Introduced by commit 0b741b8 ("soc: bcm: brcmstb: Add support for
S2/S3/S5 suspend states (ARM)") in v4.15-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4f5877bdf7b593e988f1924f4c3df6523f80b39c]
mainline: [37d838de369b07b596c19ff3662bf0293fdb09ee]
stable/4.19: [4f5877bdf7b593e988f1924f4c3df6523f80b39c]
stable/5.10: [30bbfeb480ae8b5ee43199d72417b232590440c2]
stable/5.15: [10ba9d499a9fd82ed40897e734ba19870a879407]
stable/5.4: [734a4d15142bb4c8ecad2d8ec70d7564e78ae34d]

CVE-2022-49679: ARM: Fix refcount leak in axxia_boot_secondary

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49679-610d@gregkh/

Introduced by commit 1d22924 ("ARM: Add platform support for LSI
AXM55xx SoC") in v3.16-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [71e12e5b02674459a24f16e965255d63b31fe049]
cip/4.4-st: [85edd02f0bdee6ca24e82ced1f932a36587a6c97]
mainline: [7c7ff68daa93d8c4cdea482da4f2429c0398fcde]
stable/4.19: [71e12e5b02674459a24f16e965255d63b31fe049]
stable/5.10: [44a5b3a073e5aaa5720929dba95b2725eb32bb65]
stable/5.15: [4d9c60e868f7cf8e09956e7d5bb44d807d712699]
stable/5.4: [29ca9c4efacccdc15104a8d4bf10b5183fc92840]

CVE-2022-49680: ARM: exynos: Fix refcount leak in exynos_map_pmu

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49680-9dea@gregkh/

Introduced by commit fce9e5b ("ARM: EXYNOS: Add support for mapping
PMU base address via DT") in v3.17-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7571bcecf01b69f0d3ec60ca41ce5d4c75411a4a]
cip/4.4-st: [1c115ab8c74925094999b17e3a36c0e31b554dd9]
mainline: [c4c79525042a4a7df96b73477feaf232fe44ae81]
stable/4.19: [7571bcecf01b69f0d3ec60ca41ce5d4c75411a4a]
stable/5.10: [68f28d52e6cbab8dcfa249cac4356d1d0573e868]
stable/5.15: [d23f76018e17618559da9eea179d137362023f95]
stable/5.4: [f9b77a52937582a5b99a5a07e4ef1e2f48f87347]

CVE-2022-49681: xtensa: xtfpga: Fix refcount leak bug in setup

Announce: https://lore.kernel.org/linux-cve-announce/2025022625-CVE-2022-49681-faa1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc4.


Fixed status
cip/4.19-st: [0715d0e60052662c3f225342062f174dd721d1c7]
cip/4.4-st: [c4c60fcd95dac0477d876cef9d688b80789e8db2]
mainline: [173940b3ae40114d4179c251a98ee039dc9cd5b3]
stable/4.19: [0715d0e60052662c3f225342062f174dd721d1c7]
stable/5.10: [6c0839cf1b9e1b3c88da6af76794583cbfae8da3]
stable/5.15: [0162451723178602c37f0555d235dfa17e486112]
stable/5.4: [a52972ee706b438302eb0350e61f378eb191e3d1]

CVE-2022-49682: xtensa: Fix refcount leak bug in time.c

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49682-87bd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc4.


Fixed status
cip/4.19-st: [f1eaf4ba5372ad111f687a80c67e270708e14c23]
mainline: [a0117dc956429f2ede17b323046e1968d1849150]
stable/4.19: [f1eaf4ba5372ad111f687a80c67e270708e14c23]
stable/5.10: [af0ff2da01521144bc11194f4c26485d7c9cee73]
stable/5.15: [0dcc1dd8a5dd9240639f1051dfaa2dffc9fbbde5]
stable/5.4: [e5234a9d64a976abd134a14710dcd5188158a7c5]

CVE-2022-49683: iio: adc: adi-axi-adc: Fix refcount leak in
adi_axi_adc_attach_client

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49683-b7e3@gregkh/

Introduced by commit ef04070 ("iio: adc: adi-axi-adc: add support for
AXI ADC IP core") in v5.8-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ada7b0c0dedafd7d059115adf49e48acba3153a8]
stable/5.10: [501652a2ad5450b4908e1f204ce75b2414c305b7]
stable/5.15: [ab7bf025cee89db73c649216ddd2bc589c3d3862]

CVE-2022-49684: iio: adc: aspeed: Fix refcount leak in aspeed_adc_set_trim_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49684-9c43@gregkh/

Introduced by commit d0a4c17 ("iio: adc: aspeed: Get and set trimming
data.") in v5.16-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a2b6b5687984a010ed094b4f436a2f091987758]

CVE-2022-49685: iio: trigger: sysfs: fix use-after-free on remove

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49685-3634@gregkh/

Introduced by commit f38bc92 ("staging:iio:sysfs-trigger: Use irq_work
to properly active trigger") in v3.7-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [31ff3309b47d98313c61b8301bf595820cc3cc33]
cip/4.4-st: [96ec131ce4f7269ac69928e50a288b7361367540]
mainline: [78601726d4a59a291acc5a52da1d3a0a6831e4e8]
stable/4.19: [31ff3309b47d98313c61b8301bf595820cc3cc33]
stable/5.10: [b07a30a774b3c3e584a68dc91779c68ea2da4813]
stable/5.15: [4687c3f955240ca2a576bdc3f742d4d915b6272d]
stable/5.4: [5e39397d60dacc7f5d81d442c1c958eaaaf31128]

CVE-2022-49686: usb: gadget: uvc: fix list double add in uvcg_video_pump

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49686-29d5@gregkh/

Introduced by commit f9897ec ("usb: gadget: uvc: only pump video data
if necessary") in v5.16-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96163f835e65f8c9897487fac965819f0651d671]

CVE-2022-49687: virtio_net: fix xdp_rxq_info bug after suspend/resume

Announce: https://lore.kernel.org/linux-cve-announce/2025022626-CVE-2022-49687-bcfa@gregkh/

Introduced by commit 754b8a2 ("virtio_net: setup xdp_rxq_info") in v4.16-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9222672fa6370f0ec3d899662cb8680e9282fc4c]
mainline: [8af52fe9fd3bf5e7478da99193c0632276e1dfce]
stable/4.19: [9222672fa6370f0ec3d899662cb8680e9282fc4c]
stable/5.10: [340fbdc8011f2dc678f622c5ce1cbb5ab8305de7]
stable/5.15: [8d7fe9ad6fddc2af8bde4b921b4f8fab231ed38c]
stable/5.4: [8c7a32b7c15555beddc5810c3334d9cefff061bf]

CVE-2022-49688: afs: Fix dynamic root getattr

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49688-5c71@gregkh/

Introduced by commit 2aeb8c8 ("afs: Fix afs_getattr() to refetch file
status if callback break occurred") in v5.18.
Fixed in v5.19-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [65c24caf1b9f5b08397c6e805ec24ebc390c6e4d]
mainline: [cb78d1b5efffe4cf97e16766329dd7358aed3deb]
stable/4.19: [65c24caf1b9f5b08397c6e805ec24ebc390c6e4d]
stable/5.10: [7b564e3254b7db5fbfbf11a824627a6c31b932b4]
stable/5.15: [2b2bba96526f25f2eba74ecadb031de2e05a83ce]
stable/5.4: [e3a232e5767051483ffad4cef7d0a89d292a192b]

CVE-2022-49691: erspan: do not assume transport header is always set

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49691-004b@gregkh/

Introduced by commit d5db21a ("erspan: auto detect truncated ipv6
packets.") in v4.18-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fb401f37f6eadf24956d93687e5758c163c0d12b]
mainline: [301bd140ed0b24f0da660874c7e8a47dad8c8222]
stable/4.19: [fb401f37f6eadf24956d93687e5758c163c0d12b]
stable/5.10: [cec9867ee55478ef5dcb2adf030fe0c442a4c4ee]
stable/5.15: [a3b2470399f679587c45abe56e551caf10becca2]
stable/5.4: [02da602bc2f353dccd9e489a604490034ded941e]

CVE-2022-49692: net: phy: at803x: fix NULL pointer dereference on AR9331 PHY

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49692-0f29@gregkh/

Introduced by commit 3265f42 ("net: phy: at803x: add fiber support")
in v5.18-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9926de7315be3d606cc011a305ad9adb9e8e14c9]

CVE-2022-49693: drm/msm/mdp4: Fix refcount leak in mdp4_modeset_init_intf

Announce: https://lore.kernel.org/linux-cve-announce/2025022627-CVE-2022-49693-c20b@gregkh/

Introduced by commit 86418f9 ("drm: convert drivers to use
of_graph_get_remote_node") in v4.12-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9cc4598607cb7f7eae5c75fc1e3209cd52ff5e0]
stable/5.10: [d16a4339825e64f9ddcdff5277982d640bae933b]
stable/5.15: [3c39a17197733bc37786ed68c83267c2f491840b]
stable/5.4: [d1592d3e362cc59b29f15019707b16c695d70ca3]

CVE-2022-49694: block: disable the elevator int del_gendisk

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49694-d7d9@gregkh/

Introduced by commit e155b0c ("blk-mq: Use shared tags for shared
sbitmap support") in v5.16-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50e34d78815e474d410f342fbe783b18192ca518]

CVE-2022-49695: igb: fix a use-after-free issue in igb_clean_tx_ring

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49695-59b3@gregkh/

Introduced by commit 9cbc948 ("igb: add XDP support") in v5.10-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f6a57ee8544ec3982f8a3cbcbf4aea7d47eb9ec]
stable/5.10: [c12a2c9b1b460ed72e6b3c33aac1ef51b0329b66]
stable/5.15: [2af944210dc23d43d8208dafac4df7be7e3c168b]

CVE-2022-49696: tipc: fix use-after-free Read in tipc_named_reinit

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49696-c188@gregkh/

Introduced by commit d966ddc ("tipc: fix a deadlock when flushing
scheduled work") in v5.10-rc1.
Fixed in v5.19-rc4.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [911600bf5a5e84bfda4d33ee32acc75ecf6159f0]
stable/5.10: [361c5521c1e49843b710f455cae3c0a50b714323]
stable/5.15: [cd7789e659e84f137631dc1f5ec8d794f2700e6c]

CVE-2022-49697: bpf: Fix request_sock leak in sk lookup helpers

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49697-db0b@gregkh/

Introduced by commit f7355a6 ("bpf: Check sk_fullsock() before
returning from bpf_sk_lookup()") in v5.2-rc6.
Introduced by commit edbf8c0 ("bpf: add skc_lookup_tcp helper") in v5.2-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3046a827316c0e55fc563b4fb78c93b9ca5c7c37]
stable/5.10: [516760f1d2979903eaad5b437256913c5cd98416]
stable/5.15: [b03607437ea81b850599f705096b05b85e7a4a71]
stable/5.4: [8ffe2e50e9678c8373027492035f094b130437f1]

CVE-2022-49698: netfilter: use get_random_u32 instead of prandom

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49698-9ddd@gregkh/

Introduced by commit 6b2faee ("netfilter: nft_meta: place prandom
handling in a helper") in v5.6-rc1.
Introduced by commit 978d8f9 ("netfilter: nft_numgen: add map lookups
for numgen random operations") in v4.18-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1fd94e704571f98b21027340eecf821b2bdffba]
stable/5.10: [15cc30ac2a8d7185f8ebf97dd1ddd90a7c79783b]
stable/5.15: [d0906b0fffc9f19bc42708ca3e84e2089088386c]

CVE-2022-49699: filemap: Handle sibling entries in filemap_get_read_batch()

Announce: https://lore.kernel.org/linux-cve-announce/2025022628-CVE-2022-49699-d60e@gregkh/

Introduced by commit cbd59c4 ("mm/filemap: use head pages in
generic_file_buffered_read") in v5.12-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb995f4eeba9d268fd4b56c2423ad6c1d1ea1b82]

CVE-2022-49700: mm/slub: add missing TID updates on slab deactivation

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49700-2b3e@gregkh/

Introduced by commit c17dda4 ("slub: Separate out kmem_cache_cpu
processing from deactivate_slab") in v3.6-rc1.
Introduced by commit 03e404a ("slub: fast release on full slab") in v3.1-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e2b2f0e2e34d71ae6c2a1114fd3c525930e84bc7]
cip/4.4-st: [a04efb94743828ce73be8d7211284cc9681440cd]
mainline: [eeaa345e128515135ccb864c04482180c08e3259]
stable/4.19: [e2b2f0e2e34d71ae6c2a1114fd3c525930e84bc7]
stable/5.10: [6c32496964da0dc230cea763a0e934b2e02dabd5]
stable/5.15: [0515cc9b6b24877f59b222ade704bfaa42caa2a6]
stable/5.4: [e7e3e90d671078455a3a08189f89d85b3da2de9e]

CVE-2022-49701: scsi: ibmvfc: Allocate/free queue resource only during
probe/remove

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49701-ed2a@gregkh/

Introduced by commit 3034ebe ("scsi: ibmvfc: Add alloc/dealloc
routines for SCSI Sub-CRQ Channels") in v5.12-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72ea7fe0db73d65c7d977208842d8ade9b823de9]
stable/5.15: [161ec2a0807ddd58bc0f24f3e1e7e3d4fef5297f]

CVE-2022-49702: btrfs: fix hang during unmount when block group
reclaim task is running

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49702-4b46@gregkh/

Introduced by commit 18bb8bb ("btrfs: zoned: automatically reclaim
zones") in v5.13-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31e70e527806c546a72262f2fc3d982ee23c42d3]
stable/5.15: [341d33128a940c6634175dcb6ca92dc454cfa7d2]

CVE-2022-49703: scsi: ibmvfc: Store vhost pointer during subcrq allocation

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49703-9539@gregkh/

Introduced by commit 3034ebe ("scsi: ibmvfc: Add alloc/dealloc
routines for SCSI Sub-CRQ Channels") in v5.12-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aeaadcde1a60138bceb65de3cdaeec78170b4459]
stable/5.15: [8540f66196ca35b7b5e902932571c18b9fde0cd1]

CVE-2022-49704: 9p: fix fid refcount leak in v9fs_vfs_get_link

Announce: https://lore.kernel.org/linux-cve-announce/2025022629-CVE-2022-49704-b01e@gregkh/

Introduced by commit 6636b6d ("9p: add refcount to p9_fid struct") in v5.11-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5690f263208c5abce7451370b7786eb25b405eb]
stable/5.15: [f0126bcaee81dabc1926012126aa74caa03a4c6e]

CVE-2022-49705: 9p: fix fid refcount leak in v9fs_vfs_atomic_open_dotl

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49705-9fee@gregkh/

Introduced by commit 6636b6d ("9p: add refcount to p9_fid struct") in v5.11-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beca774fc51a9ba8abbc869cf0c3d965ff17cd24]
stable/5.15: [22832ac3eb5be3f7168816a76b64c1284e12eb3c]

CVE-2022-49706: zonefs: fix zonefs_iomap_begin() for reads

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49706-eed8@gregkh/

Introduced by commit 8dcc1a9 ("fs: New zonefs file system") in v5.6-rc1.
Fixed in v5.19-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1c1204c0d0c1dccc1310b9277fb2bd8b663d8fe]
stable/5.10: [355be6131164c5bacf2e810763835aecb6e01fcb]
stable/5.15: [c2f71b9bb398e2e573bdc2574149f42b45efe410]

CVE-2022-49707: ext4: add reserved GDT blocks check

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49707-c4b7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc3.


Fixed status
cip/4.19-st: [b9747263b13e5290ac4d63bec47e38f701303cad]
cip/4.4-st: [dc918cd07cd161c3a6730be58ced01c4b0550695]
mainline: [b55c3cd102a6f48b90e61c44f7f3dda8c290c694]
stable/4.19: [b9747263b13e5290ac4d63bec47e38f701303cad]
stable/5.10: [bfd004a1d3a062aac300523d406ac1f3e5f1a82c]
stable/5.15: [33b1bba31f4c784d33d2c2517964bdccdc9204cd]
stable/5.4: [fba54289176702a7caac0b64738406775817f451]

CVE-2022-49708: ext4: fix bug_on ext4_mb_use_inode_pa

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49708-f056@gregkh/

Introduced by commit cd648b8 ("ext4: trim allocation requests to group
size") in v4.11-rc1.
Fixed in v5.19-rc3.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [5707d721d1819db57dba57b1d4623034fcb32047]
cip/4.4-st: [f93cf95841790be6c2ce0ab3e2042219f23fd659]
mainline: [a08f789d2ab5242c07e716baf9a835725046be89]
stable/4.19: [5707d721d1819db57dba57b1d4623034fcb32047]
stable/5.10: [6fdaf31ad5f3d3afab744dfd9a8b0d9142aa881f]
stable/5.15: [90f0f9d45dff0128c0fca0d2358c4153b024afa6]
stable/5.4: [a6b31616e5afe1d3972cb0682a373e50597faf5c]

CVE-2022-49709: cfi: Fix __cfi_slowpath_diag RCU usage with cpuidle

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49709-f834@gregkh/

Introduced by commit cf68fff ("add support for Clang CFI") in v5.13-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57cd6d157eb479f0a8e820fd36b7240845c8a937]
stable/5.15: [75f3a5fa2ad049c85ab5d5ee1ed9cfaa7e62c5ed]

CVE-2022-49710: dm mirror log: round up region bitmap size to BITS_PER_LONG

Announce: https://lore.kernel.org/linux-cve-announce/2025022630-CVE-2022-49710-0591@gregkh/

Introduced by commit 29121bd ("[PATCH] dm mirror log: bitset_size
fix") in v2.6.20.16.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85e123c27d5cbc22cfdc01de1e2ca1d9003a02d0]
stable/5.10: [ba751f0d25f07aa21ce9b85372a3792bf7969d13]
stable/5.15: [0d2209b54f1de0c2f99cab246d4cf2cfe24aaaa9]
stable/5.4: [ae460312875159285cef5bf3dc654593f404a1ef]

CVE-2022-49711: bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove()

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49711-3cab@gregkh/

Introduced by commit f936271 ("staging: fsl-mc: fix asymmetry in
destroy of mc_io") in v4.8-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [928ea98252ad75118950941683893cf904541da9]
stable/5.15: [ccd1751092341ac120a961835211f9f2e3735963]

CVE-2022-49712: usb: gadget: lpc32xx_udc: Fix refcount leak in lpc32xx_udc_probe

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49712-a800@gregkh/

Introduced by commit 24a28e4 ("USB: gadget driver for LPC32xx") in v3.5-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [2a598da14856ead80c726b38ba426c68637d9211]
cip/4.4-st: [f3769857fdb7dcd966c66903cd9e52fb90777481]
mainline: [4757c9ade34178b351580133771f510b5ffcf9c8]
stable/4.19: [2a598da14856ead80c726b38ba426c68637d9211]
stable/5.10: [57901c658f77d9ea2e772f35cb38e47efb54c558]
stable/5.15: [46da1e4a8b6329479433b2a4056941dfdd7f3efd]
stable/5.4: [b75bddfcc18170ce8e3fb695a76ec2dec4ce0ea5]

CVE-2022-49713: usb: dwc2: Fix memory leak in dwc2_hcd_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49713-8ddc@gregkh/

Introduced by commit 856e6e8 ("usb: dwc2: check return value after
calling platform_get_resource()") in v5.15-rc3.
Fixed in v5.19-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [84e6d0af87e27bbc0db94f2e7323b34abe17b6e5]
mainline: [3755278f078460b021cd0384562977bf2039a57a]
stable/4.19: [84e6d0af87e27bbc0db94f2e7323b34abe17b6e5]
stable/5.10: [a44a8a762f7fe9ad3c065813d058e835a6180cb2]
stable/5.15: [701d8ec01e0f229d4db6f43d3d64ee479120cbeb]
stable/5.4: [6506aff2dc2f7059aa3d45ee2e8639b25e87090f]

CVE-2022-49714: irqchip/realtek-rtl: Fix refcount leak in map_interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49714-b926@gregkh/

Introduced by commit 9f3a0f3 ("irqchip: Add support for Realtek
RTL838x/RTL839x interrupt controller") in v5.12-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eff4780f83d0ae3e5b6c02ff5d999dc4c1c5c8ce]
stable/5.15: [e85b1b797de0e7a271b906291ce28245822820b8]

CVE-2022-49715: irqchip/gic-v3: Fix refcount leak in gic_populate_ppi_partitions

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49715-429c@gregkh/

Introduced by commit e3825ba ("irqchip/gic-v3: Add support for
partitioned PPIs") in v4.7-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e824482e2c5edacc961b7dd30a92fd47606c3036]
mainline: [fa1ad9d4cc47ca2470cd904ad4519f05d7e43a2b]
stable/4.19: [e824482e2c5edacc961b7dd30a92fd47606c3036]
stable/5.10: [506a88a5bf261d76a5214c0338a320f2214c67ac]
stable/5.15: [cc5984cf270b69d03f9f4b27063e535036c659e9]
stable/5.4: [8d884c08eeb83142a7173cb46bcff0434ec42cf1]

CVE-2022-49716: irqchip/gic-v3: Fix error handling in
gic_populate_ppi_partitions

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2022-49716-7528@gregkh/

Introduced by commit 52085d3 ("irqchip/gic-v3: Dynamically allocate
PPI partition descriptors") in v5.4-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec8401a429ffee34ccf38cebf3443f8d5ae6cb0d]
stable/5.10: [7c9dd9d23f26dabcfb14148b9acdfba540418b19]
stable/5.15: [0b325d993995a321f6ab4e6c51f0504ec092bf5b]
stable/5.4: [58e67c81e229351027d28c610638378606e33a08]

CVE-2022-49717: irqchip/apple-aic: Fix refcount leak in build_fiq_affinity

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49717-acc7@gregkh/

Introduced by commit a5e8801 ("irqchip/apple-aic: Parse FIQ affinities
from device-tree") in v5.18-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1ac803f47cb1615468f35cf1ccb553c52087301]

CVE-2022-49718: irqchip/apple-aic: Fix refcount leak in aic_of_ic_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49718-327a@gregkh/

Introduced by commit a5e8801 ("irqchip/apple-aic: Parse FIQ affinities
from device-tree") in v5.18-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d45670fab3c25a7452721e4588cc95c51cda134]

CVE-2022-49719: irqchip/gic/realview: Fix refcount leak in realview_gic_of_init

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49719-dd71@gregkh/

Introduced by commit 82b0a43 ("irqchip/gic/realview: Support more
RealView DCC variants") in v4.6-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b634af84bc1edece4e63317b0ad95618dd3a8693]
mainline: [f4b98e314888cc51486421bcf6d52852452ea48b]
stable/4.19: [b634af84bc1edece4e63317b0ad95618dd3a8693]
stable/5.10: [e52a58b79f11755ea7e877015c4a1704303fa55f]
stable/5.15: [5d38720661a4b9c87705c206a6081177ffb8ec1d]
stable/5.4: [56526c3883fc7a1f5898b1d40a02c8b8685a5d92]

CVE-2022-49720: block: Fix handling of offline queues in
blk_mq_alloc_request_hctx()

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49720-b0a8@gregkh/

Introduced by commit 20e4d81 ("blk-mq: simplify queue mapping &
schedule with each possisble CPU") in v4.16-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14dc7a18abbe4176f5626c13c333670da8e06aa1]
stable/5.10: [7fa28a7c3d74933a4fc22d341b60927952f31c19]
stable/5.15: [b5e65ef044d627effdc2599040b6d204e003f955]

CVE-2022-49721: arm64: ftrace: consistently handle PLTs.

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49721-b74f@gregkh/

Introduced by commit 3b23e49 ("arm64: implement ftrace with regs") in v5.5-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6253579977e4c6f7818eeb05bf2bc65678a7187]
stable/5.10: [bc28fde90937a920f7714ec4408269cac744f796]
stable/5.15: [db73aa9466338ec821ed2a0b01721fe4d06876b1]

CVE-2022-49722: ice: Fix memory corruption in VF driver

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2022-49722-9d4e@gregkh/

Introduced by commit ec4f5a4 ("ice: Check if VF is disabled for Opcode
and other operations") in v5.5-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [efe41860008e57fb6b69855b4b93fdf34bc42798]

CVE-2022-49723: drm/i915/reset: Fix error_state_read ptr + offset use

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49723-ac32@gregkh/

Introduced by commit 0e39037 ("drm/i915: Cache the error string") in v5.0-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9b576d0c7bf55aeae1a736da7974fa202c4394d]
stable/5.10: [63b26fe0252f923e6aca373e3ad4b31202dcd331]
stable/5.15: [f4c5eba87675a07a6c28cdaca7366aeb4258ec78]

CVE-2022-49724: tty: goldfish: Fix free_irq() on remove

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49724-124b@gregkh/

Introduced by commit 465893e ("tty: goldfish: support platform_device
with id -1") in v4.6-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c83a1d40dc624070a203eb383ef9fb60eb634136]
mainline: [499e13aac6c762e1e828172b0f0f5275651d6512]
stable/4.19: [c83a1d40dc624070a203eb383ef9fb60eb634136]
stable/5.10: [65ca4db68b6819244df9024aea4be55edf8af1ef]
stable/5.15: [fb15e79cacddfbc62264e6e807bde50ad688e988]
stable/5.4: [f7183c76d500324b8b5bd0af5e663cfa57b7b836]

CVE-2022-49725: i40e: Fix call trace in setup_tx_descriptors

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49725-5494@gregkh/

Introduced by commit e17bc41 ("i40e: Disable offline diagnostics if
VFs are enabled") in v4.2-rc1.
Introduced by commit 510efb2 ("i40e: Fix ethtool offline diagnostic
with netqueues") in v4.3-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [15950157e2c24865b696db1c9ccc72743ae0e967]
mainline: [fd5855e6b1358e816710afee68a1d2bc685176ca]
stable/4.19: [15950157e2c24865b696db1c9ccc72743ae0e967]
stable/5.10: [814092927a215f5ca6c08249ec72a205e0b473cd]
stable/5.15: [0a4e5a3dc5e41212870e6043895ae02455c93f63]
stable/5.4: [ff6e03fe84bc917bb0c907d02de668c2fe101712]

CVE-2022-49726: clocksource: hyper-v: unexport __init-annotated
hv_init_clocksource()

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49726-582f@gregkh/

Introduced by commit dd2cb34 ("clocksource/drivers: Continue making
Hyper-V clocksource ISA agnostic") in v5.3-rc1.
Fixed in v5.19-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [245b993d8f6c4e25f19191edfbd8080b645e12b1]
stable/5.10: [db965e2757d95f695e606856418cd84003dd036d]
stable/5.15: [0414eab7c78f3518143d383e448d44fc573ac6d2]
stable/5.4: [cff3a7ce6e81418b6e8bac941779bbf5d342d626]

CVE-2022-49727: ipv6: Fix signed integer overflow in l2tp_ip6_sendmsg

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2022-49727-a010@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc2.


Fixed status
cip/4.19-st: [6c4e3486d21173d60925ef52e512cae727b43d30]
cip/4.4-st: [3b9aa7167e56a40f09464546bc819ba16e29e351]
mainline: [f638a84afef3dfe10554c51820c16e39a278c915]
stable/4.19: [6c4e3486d21173d60925ef52e512cae727b43d30]
stable/5.10: [b8879ca1fd7348b4d5db7db86dcb97f60c73d751]
stable/5.15: [27a37755ceb401111ded76810359d3adc4b268a1]
stable/5.4: [2f42389d270f2304c8855b0b63498a5a4d0c053d]

CVE-2022-49728: ipv6: Fix signed integer overflow in __ip6_append_data

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49728-1f8a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc2.


Fixed status
mainline: [f93431c86b631bbca5614c66f966bf3ddb3c2803]

CVE-2022-49729: nfc: nfcmrvl: Fix memory leak in nfcmrvl_play_deferred

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49729-4536@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc2.


Fixed status
cip/4.19-st: [3e7c7df6991ac349f2fa8540047757df666e610f]
cip/4.4-st: [3fc3900d9a23158da5d500a285f6cbbd93aec962]
mainline: [8a4d480702b71184fabcf379b80bf7539716752e]
stable/4.19: [3e7c7df6991ac349f2fa8540047757df666e610f]
stable/5.10: [0eeec1a8b0cd38c47edeb042980a6aeacecf35ed]
stable/5.15: [6616872cfe7f0474a22dd1f12699f95bcf81a54d]
stable/5.4: [6b4d8b44e7163a77fe942f5b80e1651c1b78c537]

CVE-2022-49730: scsi: lpfc: Resolve NULL ptr dereference after an ELS
LOGO is aborted

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49730-db2b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc2.


Fixed status
mainline: [b1b3440f437b75fb2a9b0cfe58df461e40eca474]
stable/5.15: [5e83869e29448958f8ae2c6911f350318f75e4fc]

CVE-2022-49731: ata: libata-core: fix NULL pointer deref in
ata_host_alloc_pinfo()

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2022-49731-c7ba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.19-rc2.


Fixed status
cip/4.19-st: [a810bd5af06977a847d1f202b22d7defd5c62497]
cip/4.4-st: [e67894ea6e1ebe321a9cb4e88c3e8336b4b3de54]
mainline: [bf476fe22aa1851bab4728e0c49025a6a0bea307]
stable/4.19: [a810bd5af06977a847d1f202b22d7defd5c62497]
stable/5.10: [36cd19e7d4e5571d77a2ed20c5b6ef50cf57734a]
stable/5.15: [ff128fbea720bf763fa345680dda5f050bc24a47]
stable/5.4: [253334f84c81bc6a43af489f108c0bddad989eef]

CVE-2022-49732: sock: redo the psock vs ULP protection check

Announce: https://lore.kernel.org/linux-cve-announce/2025022619-CVE-2022-49732-fc0d@gregkh/

Introduced by commit 8a59f9d ("sock: Introduce
sk->sk_prot->psock_update_sk_prot()") in v5.13-rc1.
Fixed in v5.19-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e34a07c0ae3906f97eb18df50902e2a01c1015b6]
stable/5.15: [72fa0f65b56605b8a9ae9fba2082f2123f7fe017]

CVE-2023-52926: io_uring/rw: split io_read() into a helper

Announce: https://lore.kernel.org/linux-cve-announce/2025022416-CVE-2023-52926-7cb1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.7-rc1.


Fixed status
mainline: [a08d195b586a217d76b42062f88f375a3eedda4d]
stable/6.1: [72060434a14caea20925e492310d6e680e3f9007]
stable/6.6: [6c27fc6a783c8a77c756dd5461b15e465020d075]

CVE-2024-49570: drm/xe/tracing: Fix a potential TP_printk UAF

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2024-49570-d2e7@gregkh/

Introduced by commit e46d3f8 ("drm/xe/trace: Extract bo, vm, vma
traces") in v6.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07089083a526ea19daa72a1edf9d6e209615b77c]

CVE-2024-52557: drm: zynqmp_dp: Fix integer overflow in zynqmp_dp_rate_get()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2024-52557-506d@gregkh/

Introduced by commit 28edaac ("drm: zynqmp_dp: Add debugfs interface
for compliance testing") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67a615c5cb6dc33ed35492dc0d67e496cbe8de68]

CVE-2024-52559: drm/msm/gem: prevent integer overflow in msm_ioctl_gem_submit()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2024-52559-6125@gregkh/

Introduced by commit 1987253 ("drm/msm: fix cmdstream size check") in v3.12-rc2.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a47f4b439beb98e955d501c609dfd12b7836d61]

CVE-2024-52560: fs/ntfs3: Mark inode as bad as soon as error detected
in mi_enum_attr()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2024-52560-8446@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [2afd4d267e6dbaec8d3ccd4f5396cb84bc67aa2e]

CVE-2024-54456: NFS: Fix potential buffer overflowin nfs_sysfs_link_rpc_client()

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2024-54456-e8a9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [49fd4e34751e90e6df009b70cd0659dc839e7ca8]
stable/6.6: [19b3ca651b4b473878c73539febe477905041442]

CVE-2024-54458: scsi: ufs: bsg: Set bsg_queue to NULL after removal

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2024-54458-75cd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [1e95c798d8a7f70965f0f88d4657b682ff0ec75f]
stable/6.1: [5e7b6e44468c3242c21c2a8656d009fb3eb50a73]
stable/6.6: [5f782d4741bf558def60df192b858b0efc6a5f0a]

CVE-2024-57834: media: vidtv: Fix a null-ptr-deref in vidtv_mux_stop_thread

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2024-57834-f004@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [1221989555db711578a327a9367f1be46500cb48]
stable/6.1: [86307e443c5844f38e1b98e2c51a4195c55576cd]
stable/6.6: [2c5601b99d79d196fe4a37159e3dfb38e778ea18]

CVE-2024-57852: firmware: qcom: scm: smc: Handle missing SCM device

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2024-57852-f942@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [94f48ecf0a538019ca2025e0b0da391f8e7cc58c]

CVE-2024-57953: rtc: tps6594: Fix integer overflow on 32bit systems

Announce: https://lore.kernel.org/linux-cve-announce/2025022631-CVE-2024-57953-9830@gregkh/

Introduced by commit 9f67c1e ("rtc: tps6594: Add driver for TPS6594
RTC") in v6.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09c4a610153286cef54d4f0c85398f4e32fc227e]

CVE-2024-57973: rdma/cxgb4: Prevent potential integer overflow on 32bit

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2024-57973-8797@gregkh/

Introduced by commit 1cab775 ("RDMA/cxgb4: Fix LE hash collision bug
for passive open connection") in v3.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd96a3935e89486304461a21752f824fc25e0f0b]
stable/6.1: [4422f452d028850b9cc4fd8f1cf45a8ff91855eb]
stable/6.6: [de8d88b68d0cfd41152a7a63d6aec0ed3e1b837a]

CVE-2024-57974: udp: Deal with race between UDP socket address change and rehash

Announce: https://lore.kernel.org/linux-cve-announce/2025022632-CVE-2024-57974-189e@gregkh/

Introduced by commit 30fff92 ("udp: bind() optimisation") in v2.6.33-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a502ea6fa94b1f7be72a24bcf9e3f5f6b7e6e90c]

CVE-2024-57975: btrfs: do proper folio cleanup when run_delalloc_nocow() failed

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2024-57975-e1c7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [c2b47df81c8e20a8e8cd94f0d7df211137ae94ed]

CVE-2024-57976: btrfs: do proper folio cleanup when cow_file_range() failed

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2024-57976-10f5@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [06f364284794f149d2abc167c11d556cf20c954b]

CVE-2024-57977: memcg: fix soft lockup in the OOM process

Announce: https://lore.kernel.org/linux-cve-announce/2025022633-CVE-2024-57977-88ac@gregkh/

Introduced by commit 9cbb78b ("mm, memcg: introduce own oom handler to
iterate only over its own threads") in v3.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ade81479c7dda1ce3eedb215c78bc615bbd04f06]

CVE-2024-57978: media: imx-jpeg: Fix potential error pointer
dereference in detach_pm()

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2024-57978-2a90@gregkh/

Introduced by commit fd0af4c ("media: imx-jpeg: Ensure power suppliers
be suspended before detach them") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [1378ffec30367233152b7dbf4fa6a25ee98585d1]
stable/6.1: [fde89fe11b44500bfcb2d405825b69a5df805d19]
stable/6.6: [1b2af918bb714937a8be6cb637f528585461cd98]

CVE-2024-57979: pps: Fix a use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2024-57979-aad0@gregkh/

Introduced by commit d953e0e ("pps: Fix a use-after free bug when
unregistering a source.") in v3.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c79a39dc8d060b9e64e8b0fa9d245d44befeefbe]
stable/6.1: [91932db1d96b2952299ce30c1c693d834d10ace6]
stable/6.6: [cd3bbcb6b3a7caa5ce67de76723b6d8531fb7f64]

CVE-2024-57980: media: uvcvideo: Fix double free in error path

Announce: https://lore.kernel.org/linux-cve-announce/2025022634-CVE-2024-57980-4b5a@gregkh/

Introduced by commit a31a405 ("V4L/DVB:usbvideo:don't use part of
buffer for USB transfer #4") in v2.6.28-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6ef3a7fa97ec823a1e1af9085cf13db9f7b3bac]
stable/6.1: [9232719ac9ce4d5c213cebda23d72aec3e1c4c0d]
stable/6.6: [6c36dcd662ec5276782838660f8533a7cb26be49]

CVE-2024-57981: usb: xhci: Fix NULL pointer dereference on certain
command aborts

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2024-57981-bba6@gregkh/

Introduced by commit c311e39 ("xhci: rework command timeout and
cancellation,") in v3.16-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e0a19912adb68a4b2b74fd77001c96cd83eb073]
stable/6.1: [4ff18870af793ce2034a6ad746e91d0a3d985b88]
stable/6.6: [b649f0d5bc256f691c7d234c3986685d54053de1]

CVE-2024-57982: xfrm: state: fix out-of-bounds read during lookup

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2024-57982-c76a@gregkh/

Introduced by commit c2f672f ("xfrm: state lookup can be lockless") in v4.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e952837f3ddb0ff726d5b582aa1aad9aa38d024d]

CVE-2024-57983: mailbox: th1520: Fix memory corruption due to
incorrect array size

Announce: https://lore.kernel.org/linux-cve-announce/2025022635-CVE-2024-57983-d9c0@gregkh/

Introduced by commit 5d4d263 ("mailbox: Introduce support for T-head
TH1520 Mailbox driver") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db049866943a38bf46a34fa120d526663339d7a5]

CVE-2024-57984: i3c: dw: Fix use-after-free in dw_i3c_master driver
due to race condition

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2024-57984-191f@gregkh/

Introduced by commit 1dd728f ("i3c: master: Add driver for Synopsys
DesignWare IP") in v5.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b75439c945b94dd8a2b645355bdb56f948052601]
stable/6.6: [60d2fb033a999bb644f8e8606ff4a1b82de36c6f]

CVE-2024-57985: firmware: qcom: scm: Cleanup global '__scm' on probe failures

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2024-57985-1f49@gregkh/

Introduced by commit 40289e3 ("firmware: qcom: scm: enable the TZ mem
allocator") in v6.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e76b546e6fca7eb568161f408133904ca6bcf4f]

CVE-2024-57986: HID: core: Fix assumption that Resolution Multipliers
must be in Logical Collections

Announce: https://lore.kernel.org/linux-cve-announce/2025022636-CVE-2024-57986-6166@gregkh/

Introduced by commit 5a4abb3 ("HID: core: process the Resolution
Multiplier") in v5.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64f2657b579343cf923aa933f08074e6258eb07b]
stable/6.1: [bebf542e8d7c44a18a95f306b1b5dc160c823506]
stable/6.6: [ed3d3883476423f337aac0f22c521819b3f1e970]

CVE-2024-57987: Bluetooth: btrtl: check for NULL in btrtl_setup_realtek()

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2024-57987-09a3@gregkh/

Introduced by commit b39910b ("Bluetooth: Populate hci_set_hw_info for
Intel and Realtek") in v6.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c15082f3567032d196e8760753373332508c2ca]

CVE-2024-57988: Bluetooth: btbcm: Fix NULL deref in btbcm_get_board_name()

Announce: https://lore.kernel.org/linux-cve-announce/2025022637-CVE-2024-57988-db3b@gregkh/

Introduced by commit f9183ea ("Bluetooth: btbcm: Use devm_kstrdup()")
in v6.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b88655bc6593c6a7fdc1248b212d17e581c4334e]

CVE-2024-57989: wifi: mt76: mt7925: fix NULL deref check in
mt7925_change_vif_links

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2024-57989-0a14@gregkh/

Introduced by commit 69acd6d ("wifi: mt76: mt7925: add
mt7925_change_vif_links") in v6.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cd0bd815c8a48862a296df9b30e0ea0da14acd3]

CVE-2024-57990: wifi: mt76: mt7925: fix off by one in mt7925_load_clc()

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2024-57990-67dc@gregkh/

Introduced by commit 9679ca7 ("wifi: mt76: mt7925: fix a potential
array-index-out-of-bounds issue for clc") in v6.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08fa656c91fd5fdf47ba393795b9c0d1e97539ed]

CVE-2024-57991: wifi: rtw89: chan: fix soft lockup in
rtw89_entity_recalc_mgnt_roles()

Announce: https://lore.kernel.org/linux-cve-announce/2025022638-CVE-2024-57991-a3e1@gregkh/

Introduced by commit 68ec751 ("wifi: rtw89: chan: manage active
interfaces") in v6.13-rc1.
Fixed in v6.13.2.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [01d2d34e9fcc9897081c3c16a666f793c8a38c58]

CVE-2024-57992: wifi: wilc1000: unregister wiphy only if it has been registered

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2024-57992-fa9c@gregkh/

Introduced by commit fbdf0c5 ("wifi: wilc1000: Register wiphy after
reading out chipid") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1be94490b6b8a06ff14cd23fda8714e6ec37cdfb]

CVE-2024-57993: HID: hid-thrustmaster: Fix warning in
thrustmaster_probe by adding endpoint check

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2024-57993-e136@gregkh/

Introduced by commit c49c336 ("HID: support for initialization of some
Thrustmaster wheels") in v5.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50420d7c79c37a3efe4010ff9b1bb14bc61ebccf]
stable/6.1: [220883fba32549a34f0734e4859d07f4dcd56992]
stable/6.6: [ae730deded66150204c494282969bfa98dc3ae67]

CVE-2024-57994: ptr_ring: do not block hard interrupts in
ptr_ring_resize_multiple()

Announce: https://lore.kernel.org/linux-cve-announce/2025022639-CVE-2024-57994-8dbd@gregkh/

Introduced by commit ff4e538 ("page_pool: add a lockdep check for
recycling in hardirq") in v6.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a126061c80d5efb4baef4bcf346094139cd81df6]

CVE-2024-57995: wifi: ath12k: fix read pointer after free in
ath12k_mac_assign_vif_to_vdev()

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2024-57995-892d@gregkh/

Introduced by commit b5068bc ("wifi: ath12k: Cache vdev configs before
vdev create") in v6.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a10971c7645a95f5d5dc23c26fbac4bf61801d0]

CVE-2024-57996: net_sched: sch_sfq: don't allow 1 packet limit

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2024-57996-b670@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10685681bafce6febb39770f3387621bf5d67d0b]
stable/6.1: [35d0137305ae2f97260a9047f445bd4434bd6cc7]
stable/6.6: [833e9a1c27b82024db7ff5038a51651f48f05e5e]

CVE-2024-57997: wifi: wcn36xx: fix channel survey memory allocation size

Announce: https://lore.kernel.org/linux-cve-announce/2025022640-CVE-2024-57997-a004@gregkh/

Introduced by commit 29696e0 ("wcn36xx: Track SNR and RSSI for each RX
frame") in v5.18-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6200d947f050efdba4090dfefd8a01981363d954]
stable/6.1: [ae68efdff7a7a42ab251cac79d8713de6f0dbaa0]
stable/6.6: [e95f9c408ff8311f75eeabc8acf34a66670d8815]

CVE-2024-57998: OPP: add index check to assert to avoid buffer
overflow in _read_freq()

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2024-57998-e730@gregkh/

Introduced by commit 142e17c ("OPP: Introduce
dev_pm_opp_find_freq_{ceil/floor}_indexed() APIs") in v6.6-rc1.
Introduced by commit a589392 ("OPP: Add
dev_pm_opp_find_freq_exact_indexed()") in v6.6-rc1.
Fixed in v6.13.2.

Bug introduced commit was backported to following branches.
stable/6.1

Fixed status
mainline: [da2a6acc73933b7812c94794726e438cde39e037]
stable/6.1: [774dd6f0f0a61c9c3848e025d7d9eeed1a7ca4cd]
stable/6.6: [774dd6f0f0a61c9c3848e025d7d9eeed1a7ca4cd]

CVE-2024-57999: powerpc/pseries/iommu: IOMMU incorrectly marks MMIO range in DDW

Announce: https://lore.kernel.org/linux-cve-announce/2025022641-CVE-2024-57999-1029@gregkh/

Introduced by commit 3c33066 ("powerpc/kernel/iommu: Add new
iommu_table_in_use() helper") in v5.15-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f70caad82e9c088ed93b4fea48d941ab6441886]

CVE-2024-58000: io_uring: prevent reg-wait speculations

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2024-58000-4f74@gregkh/

Introduced by commit d617b31 ("io_uring: restore back registered wait
arguments") in v6.13-rc1.
Introduced by commit aa00f67 ("io_uring: add support for fixed wait
regions") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29b95ac917927ce9f95bf38797e16333ecb489b1]

CVE-2024-58001: ocfs2: handle a symlink read error correctly

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2024-58001-3f9c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [2b4c2094da6d84e69b843dd3317902e977bf64bd]
stable/6.1: [6e143eb4ab83c24e7ad3e3d8e7daa241d9c38377]
stable/6.6: [b6833b38984d1e9f20dd80f9ec9050c10d687f30]

CVE-2024-58002: media: uvcvideo: Remove dangling pointers

Announce: https://lore.kernel.org/linux-cve-announce/2025022654-CVE-2024-58002-6f93@gregkh/

Introduced by commit e5225c8 ("media: uvcvideo: Send a control event
when a Control Change interrupt arrives") in v4.19-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [221cd51efe4565501a3dbf04cc011b537dcce7fb]

CVE-2024-58003: media: i2c: ds90ub9x3: Fix extra fwnode_handle_put()

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2024-58003-2b9b@gregkh/

Introduced by commit 905f88c ("media: i2c: ds90ub9x3: Fix sub-device
matching") in v6.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60b45ece41c5632a3a3274115a401cb244180646]
stable/6.6: [474d7baf91d37bc411fa60de5bbf03c9dd82e18a]

CVE-2024-58004: media: intel/ipu6: remove cpu latency qos request on error

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2024-58004-cf99@gregkh/

Introduced by commit f50c4ca ("media: intel/ipu6: add the main input
system driver") in v6.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [facb541ff0805314e0b56e508f7d3cbd07af513c]

CVE-2024-58005: tpm: Change to kvalloc() in eventlog/acpi.c

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2024-58005-f2fa@gregkh/

Introduced by commit 55a82ab ("[PATCH] tpm: add bios measurement log")
in v2.6.20.16.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3a860bc0fd6c07332e4911cf9a238d20de90173]
stable/6.6: [50365a6304a57266e8f4d3078060743c3b7a1e0d]

CVE-2024-58006: PCI: dwc: ep: Prevent changing BAR size/flags in
pci_epc_set_bar()

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2024-58006-9855@gregkh/

Introduced by commit 4284c88 ("PCI: designware-ep: Allow
pci_epc_set_bar() update inbound map address") in v6.0-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3708acbd5f169ebafe1faa519cb28adc56295546]

CVE-2024-58007: soc: qcom: socinfo: Avoid out of bounds read of serial number

Announce: https://lore.kernel.org/linux-cve-announce/2025022655-CVE-2024-58007-123c@gregkh/

Introduced by commit efb448d ("soc: qcom: Add socinfo driver") in v5.4-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22cf4fae6660b6e1a583a41cbf84e3046ca9ccd0]
stable/6.1: [9c88b3a3fae4d60641c3a45be66269d00eff33cd]
stable/6.6: [47470acd719d45c4c8c418c07962f74cc995652b]

CVE-2024-58008: KEYS: trusted: dcp: fix improper sg use with CONFIG_VMAP_STACK=y

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2024-58008-548d@gregkh/

Introduced by commit 0e28bf6 ("KEYS: trusted: dcp: fix leak of blob
encryption key") in v6.11-rc4.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8d9fab39d1f87b52932646b2f1e7877aa3fc0f4]

CVE-2024-58009: Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2024-58009-b2d2@gregkh/

Introduced by commit 7c4f78c ("Bluetooth: L2CAP: do not leave dangling
sk pointer on error in l2cap_sock_create()") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [5f397409f8ee5bc82901eeaf799e1cbc4f8edcf1]
stable/6.1: [297ce7f544aa675b0d136d788cad0710cdfb0785]
stable/6.6: [245d48c1ba3e7a1779c2f4cbc6f581ddc8a78e22]

CVE-2024-58010: binfmt_flat: Fix integer overflow bug on 32 bit systems

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2024-58010-39bc@gregkh/

Introduced by commit c995ee2 ("binfmt_flat: prevent kernel dammage
from corrupted executable headers") in v4.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55cf2f4b945f6a6416cc2524ba740b83cc9af25a]
stable/6.1: [95506c7f33452450346fbe2975c1359100f854ca]
stable/6.6: [d17ca8f2dfcf423c439859995910a20e38b86f00]

CVE-2024-58011: platform/x86: int3472: Check for adev == NULL

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2024-58011-5ed8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [cd2fd6eab480dfc247b737cf7a3d6b009c4d0f1c]
stable/6.1: [4f8b210823cc2d1f9d967f089a6c00d025bb237f]
stable/6.6: [f9c7cc44758f4930b41285a6d54afa8cbd9762b4]

CVE-2024-58012: ASoC: SOF: Intel: hda-dai: Ensure DAI widget is valid
during params

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2024-58012-90ce@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [569922b82ca660f8b24e705f6cf674e6b1f99cc7]

CVE-2024-58013: Bluetooth: MGMT: Fix slab-use-after-free Read in
mgmt_remove_adv_monitor_sync

Announce: https://lore.kernel.org/linux-cve-announce/2025022656-CVE-2024-58013-55de@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [26fbd3494a7dd26269cb0817c289267dbcfdec06]
stable/6.1: [75e65b983c5e2ee51962bfada98a79d805f28827]
stable/6.6: [4ebbcb9bc794e5be647ee28fdf14eb1ae0659405]

CVE-2024-58014: wifi: brcmsmac: add gain range check to
wlc_phy_iqcal_gainparams_nphy()

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2024-58014-6269@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [3f4a0948c3524ae50f166dbc6572a3296b014e62]
stable/6.1: [ada9df08b3ef683507e75b92f522fb659260147f]
stable/6.6: [093286c33409bf38896f2dab0c0bb6ca388afb33]

CVE-2024-58015: wifi: ath12k: Fix for out-of bound access error

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2024-58015-f72e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [eb8c0534713865d190856f10bfc97cf0b88475b1]

CVE-2024-58016: safesetid: check size of policy writes

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2024-58016-115b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [f09ff307c7299392f1c88f763299e24bc99811c7]
stable/6.1: [a0dec65f88c8d9290dfa1d2ca1e897abe54c5881]
stable/6.6: [96fae5bd1589731592d30b3953a90a77ef3928a6]

CVE-2024-58017: printk: Fix signed integer overflow when defining
LOG_BUF_LEN_MAX

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2024-58017-fb48@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [3d6f83df8ff2d5de84b50377e4f0d45e25311c7a]
stable/6.1: [9a6d43844de2479a3ff8d674c3e2a16172e01598]
stable/6.6: [4acf6bab775dbd22a9a799030a808a7305e01d63]

CVE-2024-58018: nvkm: correctly calculate the available space of the
GSP cmdq buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025022657-CVE-2024-58018-605c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [01ed662bdd6fce4f59c1804b334610d710d79fa0]

CVE-2024-58019: nvkm/gsp: correctly advance the read pointer of GSP
message queue

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2024-58019-64da@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [8d9beb4aebc02c4bd09e1d39c9c5f1c68c786dbc]

CVE-2024-58020: HID: multitouch: Add NULL check in mt_input_configured

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2024-58020-a097@gregkh/

Introduced by commit 4794394 ("HID: multitouch: Correct devm device
reference for hidinput input_dev name") in v6.6-rc1.
Fixed in v6.14-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [9b8e2220d3a052a690b1d1b23019673e612494c5]
stable/6.1: [4e7113f591163d99adc7cbcd7295030c8c5d3fc7]
stable/6.6: [62f8bf06262b6fc55c58f4c5256140f1382f3b01]

CVE-2024-58021: HID: winwing: Add NULL check in winwing_init_led()

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2024-58021-0769@gregkh/

Introduced by commit 266c990 ("HID: Add WinWing Orion2 throttle
support") in v6.10-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45ab5166a82d038c898985b0ad43ead69c1f9573]

CVE-2025-21704: usb: cdc-acm: Check control transfer buffer size before access

Announce: https://lore.kernel.org/linux-cve-announce/2025022235-CVE-2025-21704-7d61@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e563b01208f4d1f609bcab13333b6c0e24ce6a01]
stable/6.1: [7828e9363ac4d23b02419bf2a45b9f1d9fb35646]
stable/6.6: [6abb510251e75f875797d8983a830e6731fa281c]

CVE-2025-21705: mptcp: handle fastopen disconnect correctly

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2025-21705-c7e5@gregkh/

Introduced by commit c2b2ae3 ("mptcp: handle correctly disconnect()
failures") in v6.4.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [619af16b3b57a3a4ee50b9a30add9ff155541e71]
stable/6.1: [73e268b4be27b36ae68ea10755cb003f43b38884]
stable/6.6: [0263fb2e7b7b88075a5d86e74c4384ee4400828d]

CVE-2025-21706: mptcp: pm: only set fullmesh for subflow endp

Announce: https://lore.kernel.org/linux-cve-announce/2025022642-CVE-2025-21706-f5bd@gregkh/

Introduced by commit 73c762c ("mptcp: set fullmesh flag in
pm_netlink") in v5.18-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bb0d1348546ad059f55c93def34e67cb2a034a6]
stable/6.1: [22b0734c9401a74ed4ebd9e8ef0da33e493852eb]
stable/6.6: [de3b8d41d2547452c4cafb146d003fa4689fbaf2]

CVE-2025-21707: mptcp: consolidate suboption status

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2025-21707-2961@gregkh/

Introduced by commit 84dfe36 ("mptcp: send out dedicated ADD_ADDR
packet") in v5.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c86b000782daba926c627d2fa00c3f60a75e7472]
stable/6.1: [3b5332d416d151a15742d1b16e7319368e3cc5c6]
stable/6.6: [7f6c72b8ef8130760710e337dc8fbe7263954884]

CVE-2025-21708: net: usb: rtl8150: enable basic endpoint checking

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2025-21708-77ac@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90b7f2961798793275b4844348619b622f983907]
stable/6.1: [e10b392a7495a5dbbb25247e2c17d380d9899263]
stable/6.6: [3c706829ceb6e347bd4ddfd17f1d3048acd69da2]

CVE-2025-21709: kernel: be more careful about dup_mmap() failures and
uprobe registering

Announce: https://lore.kernel.org/linux-cve-announce/2025022643-CVE-2025-21709-e967@gregkh/

Introduced by commit d240629 ("fork: use __mt_dup() to duplicate maple
tree in dup_mmap()") in v6.8-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64c37e134b120fb462fb4a80694bfb8e7be77b14]

CVE-2025-21710: tcp: correct handling of extreme memory squeeze

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2025-21710-5e28@gregkh/

Introduced by commit e214282 ("net: tcp: send zero-window ACK when no
memory") in v6.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c670bdfa58e48abad1d5b6ca1ee843ca91f7303]
stable/6.6: [b01e7ceb35dcb7ffad413da657b78c3340a09039]

CVE-2025-21711: net/rose: prevent integer overflows in rose_setsockopt()

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2025-21711-9e79@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d640627663bfe7d8963c7615316d7d4ef60f3b0b]
stable/6.1: [9bdee49ad6bbd26ab5e13cc6731e54fb1b6c1dca]
stable/6.6: [352daa50946c3bbb662432e8daf54d6760796589]

CVE-2025-21712: md/md-bitmap: Synchronize bitmap_get_stats() with
bitmap lifetime

Announce: https://lore.kernel.org/linux-cve-announce/2025022644-CVE-2025-21712-8345@gregkh/

Introduced by commit 32a7627 ("[PATCH] md: optimised resync using
Bitmap based intent logging") in v2.6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d28d0ddb986f56920ac97ae704cc3340a699a30]

CVE-2025-21713: powerpc/pseries/iommu: Don't unset window if it was never set

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2025-21713-4c72@gregkh/

Introduced by commit f431a8c ("powerpc/iommu: Reimplement the
iommu_table_group_ops for pSeries") in v6.11-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17391cb2613b82f8c405570fea605af3255ff8d2]

CVE-2025-21714: RDMA/mlx5: Fix implicit ODP use after free

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2025-21714-8169@gregkh/

Introduced by commit 5256edc ("RDMA/mlx5: Rework implicit ODP
destroy") in v5.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3d930411ce390e532470194296658a960887773]

CVE-2025-21715: net: davicom: fix UAF in dm9000_drv_remove

Announce: https://lore.kernel.org/linux-cve-announce/2025022645-CVE-2025-21715-2837@gregkh/

Introduced by commit cf9e60a ("net: davicom: Fix regulator not turned
off on driver removal") in v5.12-rc3.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [19e65c45a1507a1a2926649d2db3583ed9d55fd9]
stable/6.1: [c94ab07edc2843e2f3d46dbd82e5c681503aaadf]
stable/6.6: [c411f9a5fdc9158e8f7c57eac961d3df3eb4d8ca]

CVE-2025-21716: vxlan: Fix uninit-value in vxlan_vnifilter_dump()

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2025-21716-3afa@gregkh/

Introduced by commit f9c4bb0 ("vxlan: vni filtering support on collect
metadata device") in v5.18-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5066293b9b7046a906eff60e3949a887ae185a43]
stable/6.1: [cb1de9309a48cc5b771115781eec05075fd67039]
stable/6.6: [a84d511165d6ba7f331b90ae6b6ce180ec534daa]

CVE-2025-21717: net/mlx5e: add missing cpu_to_node to kvzalloc_node in
mlx5e_open_xdpredirect_sq

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2025-21717-3893@gregkh/

Introduced by commit bb135e4 ("net/mlx5e: move XDP_REDIRECT sq to
dynamic allocation") in v6.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [979284535aaf12a287a2f43d9d5dfcbdc1dc4cac]

CVE-2025-21718: net: rose: fix timer races against user threads

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2025-21718-d976@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5de7665e0a0746b5ad7943554b34db8f8614a196]
stable/6.1: [f55c88e3ca5939a6a8a329024aed8f3d98eea8e4]
stable/6.6: [51c128ba038cf1b79d605cbee325919b45ab95a5]

CVE-2025-21719: ipmr: do not call mr_mfc_uses_dev() for unres entries

Announce: https://lore.kernel.org/linux-cve-announce/2025022646-CVE-2025-21719-dbee@gregkh/

Introduced by commit cb16789 ("net: Plumb support for filtering ipv4
and ipv6 multicast route dumps") in v4.20-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15a901361ec3fb1c393f91880e1cbf24ec0a88bd]
stable/6.1: [57177c5f47a8da852f8d76cf6945cf803f8bb9e5]
stable/6.6: [b379b3162ff55a70464c6a934ae9bf0497478a62]

CVE-2025-21720: xfrm: delete intermediate secpath entry in packet offload mode

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2025-21720-063a@gregkh/

Introduced by commit 5958372 ("xfrm: add RX datapath protection for
IPsec packet offload mode") in v6.2-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [600258d555f0710b9c47fb78d2d80a4aecd608cc]
stable/6.6: [c6e1b2cac24b2a4d1dd472071021bf00c26450eb]

CVE-2025-21721: nilfs2: handle errors that nilfs_prepare_chunk() may return

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2025-21721-28d2@gregkh/

Introduced by commit 2ba466d ("nilfs2: directory entry operations") in
v2.6.30-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee70999a988b8abc3490609142f50ebaa8344432]

CVE-2025-21722: nilfs2: do not force clear folio if buffer is referenced

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2025-21722-5415@gregkh/

Introduced by commit 8c26c4e ("nilfs2: fix issue with flush kernel
thread after remount in RO mode because of driver's internal error or
metadata corruption") in v3.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca76bb226bf47ff04c782cacbd299f12ddee1ec1]
stable/6.1: [19296737024cd220a1d6590bf4c092bca8c99497]

CVE-2025-21723: scsi: mpi3mr: Fix possible crash when setting up bsg fails

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2025-21723-9f05@gregkh/

Introduced by commit 4268fa7 ("scsi: mpi3mr: Add bsg device support")
in v5.19-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [295006f6e8c17212d3098811166e29627d19e05c]

CVE-2025-21724: iommufd/iova_bitmap: Fix shift-out-of-bounds in
iova_bitmap_offset_to_index()

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2025-21724-f4b1@gregkh/

Introduced by commit 58ccf01 ("vfio: Add an IOVA bitmap support") in v6.1-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e24c1551059268b37f6f40639883eafb281b8b9c]
stable/6.1: [44d9c94b7a3f29a3e07c4753603a35e9b28842a3]
stable/6.6: [38ac76fc06bc6826a3e4b12a98efbe98432380a9]

CVE-2025-21725: smb: client: fix oops due to unset link speed

Announce: https://lore.kernel.org/linux-cve-announce/2025022647-CVE-2025-21725-3a4d@gregkh/

Introduced by commit a6d8fb5 ("cifs: distribute channels across
interfaces based on speed") in v6.7-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [be7a6a77669588bfa5022a470989702bbbb11e7f]
stable/6.1: [208e102a2fca44e40a6c3f7b9e2609cfd17a15aa]
stable/6.6: [3f901c35e1a1b3ed1b528a17ffdb941aa0294458]

CVE-2025-21726: padata: avoid UAF for reorder_work

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2025-21726-73b1@gregkh/

Introduced by commit bbefa1d ("crypto: pcrypt - Avoid deadlock by
using per-instance padata queues") in v5.6-rc1.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [dd7d37ccf6b11f3d95e797ebe4e9e886d0332600]
stable/6.1: [7000507bb0d2ceb545c0a690e0c707c897d102c2]
stable/6.6: [6f45ef616775b0ce7889b0f6077fc8d681ab30bc]

CVE-2025-21727: padata: fix UAF in padata_reorder

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2025-21727-b034@gregkh/

Introduced by commit b128a30 ("padata: allocate workqueue internally")
in v5.4-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e01780ea4661172734118d2a5f41bc9720765668]
stable/6.1: [0ae2f332cfd2d74cf3ce344ec9938cf3e29c3ccd]
stable/6.6: [bbccae982e9fa1d7abcb23a5ec81cb0ec883f7de]

CVE-2025-21728: bpf: Send signals asynchronously if !preemptible

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2025-21728-5da4@gregkh/

Introduced by commit 1bc7896 ("bpf: Fix deadlock with rq_lock in
bpf_send_signal()") in v5.6.
Fixed in v6.14-rc1.

Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [87c544108b612512b254c8f79aa5c0a8546e2cc4]
stable/6.1: [be42a09fe898635b0093c0c8dac1bfabe225c240]
stable/6.6: [eeef8e65041a031bd8a747a392c14b76a123a12c]

CVE-2025-21729: wifi: rtw89: fix race between cancel_hw_scan and
hw_scan completion

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2025-21729-24e3@gregkh/

Introduced by commit 8959077 ("rtw89: 8852a: add
ieee80211_ops::hw_scan") in v5.18-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba4bb0402c60e945c4c396c51f0acac3c3e3ea5c]

CVE-2025-21730: wifi: rtw89: avoid to init mgnt_entry list twice when
WoWLAN failed

Announce: https://lore.kernel.org/linux-cve-announce/2025022648-CVE-2025-21730-5bfb@gregkh/

Introduced by commit 68ec751 ("wifi: rtw89: chan: manage active
interfaces") in v6.13-rc1.
Fixed in v6.13.2.

Bug introduced commit was backported to following branches.
stable/6.12

Fixed status
mainline: [4ed5bf49819757303e657f3900725febf2f3926f]

CVE-2025-21731: nbd: don't allow reconnect after disconnect

Announce: https://lore.kernel.org/linux-cve-announce/2025022649-CVE-2025-21731-c18b@gregkh/

Introduced by commit b7aa3d3 ("nbd: add a reconfigure netlink
command") in v4.12-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [844b8cdc681612ff24df62cdefddeab5772fadf1]
stable/6.1: [e7343fa33751cb07c1c56b666bf37cfca357130e]
stable/6.6: [d208d2c52b652913b5eefc8ca434b0d6b757f68f]

CVE-2025-21732: RDMA/mlx5: Fix a race for an ODP MR which leads to CQE
with error

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2025-21732-e800@gregkh/

Introduced by commit e6fb246 ("RDMA/mlx5: Consolidate MR destruction
to mlx5_ib_dereg_mr()") in v5.13-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abb604a1a9c87255c7a6f3b784410a9707baf467]

CVE-2025-21733: tracing/osnoise: Fix resetting of tracepoints

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2025-21733-f0b8@gregkh/

Introduced by commit e88ed22 ("tracing/timerlat: Add user-space
interface") in v6.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3ff4245928f948f3eb2e852aa350b870421c358]
stable/6.6: [ee8c4c39a8f97467d63adfe03bcd45139d8c8b53]

CVE-2025-21734: misc: fastrpc: Fix copy buffer page size

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2025-21734-ac40@gregkh/

Introduced by commit 02b45b4 ("misc: fastrpc: fix remote page size
calculation") in v5.2-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e966eae72762ecfdbdb82627e2cda48845b9dd66]
stable/6.1: [c56ba3ea8e3c9a69a992aad18f7a65e43e51d623]
stable/6.6: [c0464bad0e85fcd5d47e4297d1e410097c979e55]

CVE-2025-21735: NFC: nci: Add bounds checking in nci_hci_create_pipe()

Announce: https://lore.kernel.org/linux-cve-announce/2025022658-CVE-2025-21735-259b@gregkh/

Introduced by commit a1b0b94 ("NFC: nci: Create pipe on specific gate
in nci_hci_connect_gate") in v4.4-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [110b43ef05342d5a11284cc8b21582b698b4ef1c]
stable/6.1: [d5a461c315e5ff92657f84d8ba50caa5abf5c22a]
stable/6.6: [172cdfc3a5ea20289c58fb73dadc6fd4a8784a4e]

CVE-2025-21736: nilfs2: fix possible int overflows in nilfs_fiemap()

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2025-21736-6d94@gregkh/

Introduced by commit 622daaf ("nilfs2: fiemap support") in v2.6.38-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6438ef381c183444f7f9d1de18f22661cba1e946]
stable/6.1: [f3d80f34f58445355fa27b9579a449fb186aa64e]
stable/6.6: [f2bd0f1ab47822fe5bd699c8458b896c4b2edea1]

CVE-2025-21737: ceph: fix memory leak in ceph_mds_auth_match()

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2025-21737-db6e@gregkh/

Introduced by commit 596afb0 ("ceph: add ceph_mds_check_access()
helper") in v6.10-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b7d93db450e9d8ead80d75e2a303248f1528c35]

CVE-2025-21738: ata: libata-sff: Ensure that we cannot write outside
the allocated buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2025-21738-f502@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [6e74e53b34b6dec5a50e1404e2680852ec6768d2]
stable/6.1: [a8f8cf87059ed1905c2a5c72f8b39a4f57b11b4c]
stable/6.6: [d5e6e3000309359eae2a17117aa6e3c44897bf6c]

CVE-2025-21739: scsi: ufs: core: Fix use-after free in init error and
remove paths

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2025-21739-5578@gregkh/

Introduced by commit cb77cb5 ("blk-crypto: rename blk_keyslot_manager
to blk_crypto_profile") in v5.16-rc1.
Introduced by commit d76d9d7 ("scsi: ufs: use devm_blk_ksm_init()") in
v5.12-rc1.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8fb2403ddebb5eea0033d90d9daae4c88749ada]

CVE-2025-21740: KVM: x86/mmu: Ensure NX huge page recovery thread is
alive before waking

Announce: https://lore.kernel.org/linux-cve-announce/2025022659-CVE-2025-21740-083e@gregkh/

Introduced by commit 931656b ("kvm: defer huge page recovery vhost
task to later") in v6.14-rc1.
Fixed in v6.12.14.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13

Fixed status
mainline: [2b3928b7c896e5a9fb6b1373924adafe8e01a0c6]

CVE-2025-21741: usbnet: ipheth: fix DPE OoB read

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2025-21741-cbfd@gregkh/

Introduced by commit a2d274c ("usbnet: ipheth: add CDC NCM support")
in v6.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee591f2b281721171896117f9946fced31441418]
stable/6.6: [22475242ddb70e35c9148234be9a3aa9fb8efff9]

CVE-2025-21742: usbnet: ipheth: use static NDP16 location in URB

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2025-21742-7d50@gregkh/

Introduced by commit a2d274c ("usbnet: ipheth: add CDC NCM support")
in v6.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86586dcb75cb8fd062a518aca8ee667938b91efb]
stable/6.6: [8fb062178e1ce180e2cfdc9abc83a1b9fea381ca]

CVE-2025-21743: usbnet: ipheth: fix possible overflow in DPE length check

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2025-21743-c67f@gregkh/

Introduced by commit a2d274c ("usbnet: ipheth: add CDC NCM support")
in v6.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c219427ed296f94bb4b91d08626776dc7719ee27]
stable/6.6: [18bf6f5cce3172cb303c3f0551aa9443d5ed74f8]

CVE-2025-21744: wifi: brcmfmac: fix NULL pointer dereference in
brcmf_txfinalize()

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2025-21744-2585@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [68abd0c4ebf24cd499841a488b97a6873d5efabb]
stable/6.1: [4e51d6d093e763348916e69d06d87e0a5593661b]
stable/6.6: [3877fc67bd3d5566cc12763bce39710ceb74a97d]

CVE-2025-21745: blk-cgroup: Fix class @block_class's subsystem refcount leakage

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2025-21745-19ee@gregkh/

Introduced by commit ef45fe4 ("blk-cgroup: show global disk stats in
root cgroup io.stat") in v5.9-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1248436cbef1f924c04255367ff4845ccd9025e]
stable/6.1: [431b6ef2714be4d5babb802114987541a88b43b0]
stable/6.6: [993121481b5a87829f1e8163f47158b72679f309]

CVE-2025-21746: Input: synaptics - fix crash when enabling pass-through port

Announce: https://lore.kernel.org/linux-cve-announce/2025022600-CVE-2025-21746-380d@gregkh/

Introduced by commit 100e169 ("Input: libps2 - attach ps2dev instances
as serio port's drvdata") in v6.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08bd5b7c9a2401faabdaa1472d45c7de0755fd7e]

CVE-2025-21747: drm/ast: astdp: Fix timeout for enabling video signal

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2025-21747-a514@gregkh/

Introduced by commit 4e29cc7 ("drm/ast: astdp: Replace
ast_dp_set_on_off()") in v6.13-rc1.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd39c41bcd82d5ebaaebadb944eab5598c668a90]

CVE-2025-21748: ksmbd: fix integer overflows on 32 bit systems

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2025-21748-c980@gregkh/

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in v5.15-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aab98e2dbd648510f8f51b83fbf4721206ccae45]
stable/6.1: [760568c1f62ea874e8fb492f9cfa4f47b4b8391e]
stable/6.6: [82f59d64e6297f270311b16b5dcf65be406d1ea3]

CVE-2025-21749: net: rose: lock the socket in rose_bind()

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2025-21749-cd11@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1300691aed9ee852b0a9192e29e2bdc2411a7e6]
stable/6.1: [667f61b3498df751c8b3f0be1637e7226cbe3ed0]
stable/6.6: [e0384efd45f615603e6869205b72040c209e69cc]

CVE-2025-21750: wifi: brcmfmac: Check the return value of
of_property_read_string_index()

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2025-21750-d10d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [082d9e263af8de68f0c34f67b251818205160f6e]
stable/6.1: [af525a8b2ab85291617e79a5bb18bcdcb529e80c]
stable/6.6: [c9480e9f2d10135476101619bcbd1c49c15d595f]

CVE-2025-21751: net/mlx5: HWS, change error flow on matcher disconnect

Announce: https://lore.kernel.org/linux-cve-announce/2025022601-CVE-2025-21751-101c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [1ce840c7a659aa53a31ef49f0271b4fd0dc10296]

CVE-2025-21752: btrfs: don't use btrfs_set_item_key_safe on RAID stripe-extents

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2025-21752-5815@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [dc14ba10781bd2629835696b7cc1febf914768e9]

CVE-2025-21753: btrfs: fix use-after-free when attempting to join an
aborted transaction

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2025-21753-91bd@gregkh/

Introduced by commit 871383b ("btrfs: add missing unlocks to
transaction abort paths") in v3.4-rc5.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2f0943cf37305dbdeaf9846e3c941451bcdef63]
stable/6.1: [6ba4663ada6c6315af23a6669d386146634808ec]
stable/6.6: [8f5cff471039caa2b088060c074c2bf2081bcb01]

CVE-2025-21754: btrfs: fix assertion failure when splitting ordered
extent after transaction abort

Announce: https://lore.kernel.org/linux-cve-announce/2025022602-CVE-2025-21754-9daa@gregkh/

Introduced by commit 52b1fdc ("btrfs: handle completed ordered extents
in btrfs_split_ordered_extent") in v6.5-rc1.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d85f5c2dd91df6b5da454406756f463ba923b69]
stable/6.6: [927b930f117bbae730a853c1dc43da8afe8380fa]

CVE-2025-21755: vsock: Orphan socket after transport release

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2025-21755-5887@gregkh/

Introduced by commit fcdd224 ("vsock: Keep the binding until socket
destruction") in v6.14-rc1.
Fixed in v6.6.79.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13 stable/6.6

Fixed status
mainline: [f3b8e9d3414b2eb083d8293be25a949fe480897b]
stable/6.6: [f3b8e9d3414b2eb083d8293be25a949fe480897b]

CVE-2025-21756: vsock: Keep the binding until socket destruction

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2025-21756-5e09@gregkh/

Introduced by commit c0cfa2d ("vsock: add multi-transports support")
in v5.5-rc1.
Fixed in v6.14-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcdd2242c0231032fc84e1404315c245ae56322a]
stable/6.6: [3f43540166128951cc1be7ab1ce6b7f05c670d8b]

CVE-2025-21757: net: ipv6: fix dst refleaks in rpl, seg6 and ioam6 lwtunnels

Announce: https://lore.kernel.org/linux-cve-announce/2025022603-CVE-2025-21757-912a@gregkh/

Introduced by commit 985ec6f ("net: ipv6: rpl_iptunnel: mitigate
2-realloc issue") in v6.14-rc1.
Introduced by commit 40475b6 ("net: ipv6: seg6_iptunnel: mitigate
2-realloc issue") in v6.14-rc1.
Introduced by commit dce5251 ("net: ipv6: ioam6_iptunnel: mitigate
2-realloc issue") in v6.14-rc1.
Fixed in v6.12.16.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.13

Fixed status
mainline: [2248b8145053eb2ae35ca4cf694b885a086719bb]

CVE-2025-21758: ipv6: mcast: add RCU protection to mld_newpack()

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2025-21758-9f8c@gregkh/

Introduced by commit b8ad0cb ("[NETNS][IPV6] mcast - handle several
network namespace") in v2.6.26-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a527750d877fd334de87eef81f1cb5f0f0ca3373]
stable/6.1: [e8af3632a7f2da83e27b083f787bced1faba00b1]
stable/6.6: [1b91c597b0214b1b462eb627ec02658c944623f2]

CVE-2025-21759: ipv6: mcast: extend RCU protection in igmp6_send()

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2025-21759-ad7c@gregkh/

Introduced by commit b8ad0cb ("[NETNS][IPV6] mcast - handle several
network namespace") in v2.6.26-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [087c1faa594fa07a66933d750c0b2610aa1a2946]
stable/6.6: [81b25a07ebf53f9ef4ca8f3d96a8ddb94561dd5a]

CVE-2025-21760: ndisc: extend RCU protection in ndisc_send_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2025-21760-fb9d@gregkh/

Introduced by commit 1762f7e ("[NETNS][IPV6] ndisc - make socket
control per namespace") in v2.6.26-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed6ae1f325d3c43966ec1b62ac1459e2b8e45640]
stable/6.1: [a9319d800b5701e7f5e3fa71a5b7c4831fc20d6d]
stable/6.6: [ae38982f521621c216fc2f5182cd091f4734641d]

CVE-2025-21761: openvswitch: use RCU protection in ovs_vport_cmd_fill_info()

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2025-21761-218b@gregkh/

Introduced by commit 9354d45 ("openvswitch: reliable interface
indentification in port dumps") in v4.15-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90b2f49a502fa71090d9f4fe29a2f51fe5dff76d]
stable/6.1: [7e01abc34e87abd091e619161a20f54ed4e3e2da]
stable/6.6: [8ec57509c36c8b9a23e50b7858dda0c520a2d074]

CVE-2025-21762: arp: use RCU protection in arp_xmit()

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2025-21762-8b8d@gregkh/

Introduced by commit 29a26a5 ("netfilter: Pass struct net into the
netfilter hooks") in v4.4-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a42b69f692165ec39db42d595f4f65a4c8f42e44]
stable/6.1: [f189654459423d4d48bef2d120b4bfba559e6039]
stable/6.6: [e9f4dee534eb1b225b0a120395ad9bc2afe164d3]

CVE-2025-21763: neighbour: use RCU protection in __neigh_notify()

Announce: https://lore.kernel.org/linux-cve-announce/2025022604-CVE-2025-21763-dcff@gregkh/

Introduced by commit 426b530 ("[NETNS]: Modify the neighbour table
code so it handles multiple network namespaces") in v2.6.25-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [becbd5850c03ed33b232083dd66c6e38c0c0e569]
stable/6.1: [784eb2376270e086f7db136d154b8404edacf97b]
stable/6.6: [1cbb2aa90cd3fba15ad7efb5cdda28f3d1082379]

CVE-2025-21764: ndisc: use RCU protection in ndisc_alloc_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2025-21764-1061@gregkh/

Introduced by commit de09334 ("ndisc: Introduce ndisc_alloc_skb()
helper.") in v3.9-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [628e6d18930bbd21f2d4562228afe27694f66da9]
stable/6.1: [3c2d705f5adf5d860aaef90cb4211c0fde2ba66d]
stable/6.6: [9e0ec817eb41a55327a46cd3ce331a9868d60304]

CVE-2025-21765: ipv6: use RCU protection in ip6_default_advmss()

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2025-21765-4d5e@gregkh/

Introduced by commit 5578689 ("[NETNS][IPV6] route6 - make route6 per
namespace") in v2.6.26-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c8ffcd248da34fc41e52a46e51505900115fc2a]
stable/6.1: [84212387caadb211cd9dadd6fd5563bd37dc1f5e]
stable/6.6: [4176a68b0db8fc74ac14fcd00ba8231371051dc2]

CVE-2025-21766: ipv4: use RCU protection in __ip_rt_update_pmtu()

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2025-21766-a004@gregkh/

Introduced by commit 2fbc6e8 ("ipv4: Update exception handling for
multipath routes via same device") in v5.9-rc7.
Introduced by commit 1de6b15 ("Namespaceify min_pmtu sysctl") in v5.17-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [139512191bd06f1b496117c76372b2ce372c9a41]
stable/6.1: [ea07480b23225942208f1b754fea1e7ec486d37e]
stable/6.6: [9b1766d1ff5fe496aabe9fc5f4e34e53f35c11c4]

CVE-2025-21767: clocksource: Use migrate_disable() to avoid calling
get_random_u32() in atomic context

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2025-21767-4c7f@gregkh/

Introduced by commit 7560c02 ("clocksource: Check per-CPU clock
synchronization when marked unstable") in v5.14-rc1.
Fixed in v6.14-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [6bb05a33337b2c842373857b63de5c9bf1ae2a09]
stable/6.1: [852805b6cbdb69c298a8fc9fbe79994c95106e04]
stable/6.6: [8783ceeee797d9aa9cfe150690fb9d0bac8cc459]

CVE-2025-21768: net: ipv6: fix dst ref loops in rpl, seg6 and ioam6 lwtunnels

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2025-21768-512b@gregkh/

Introduced by commit 8cb3bf8 ("ipv6: ioam: Add support for the ip6ip6
encapsulation") in v5.16-rc1.
Introduced by commit 6c8702c ("ipv6: sr: add support for SRH
encapsulation and injection with lwtunnels") in v4.10-rc1.
Introduced by commit a7a29f9 ("net: ipv6: add rpl sr tunnel") in v5.7-rc1.
Fixed in v6.14-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92191dd1073088753821b862b791dcc83e558e07]

CVE-2025-21769: ptp: vmclock: Add .owner to vmclock_miscdev_fops

Announce: https://lore.kernel.org/linux-cve-announce/2025022605-CVE-2025-21769-c349@gregkh/

Introduced by commit 2050327 ("ptp: Add support for the AMZNC10C
'vmclock' device") in v6.13-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b07b040257c1b658ef3eca86e4b6ae02d65069c]

CVE-2025-21770: iommu: Fix potential memory leak in iopf_queue_remove_device()

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2025-21770-d7e0@gregkh/

Introduced by commit 1991123 ("iommu: Track iopf group instead of last
fault") in v6.9-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9759ae2cee7cd42b95f1c48aa3749bd02b5ddb08]

CVE-2025-21771: sched_ext: Fix incorrect autogroup migration detection

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2025-21771-6032@gregkh/

Introduced by commit 8195136 ("sched_ext: Add cgroup support") in v6.12-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d6f3e7d564b2309e1f17e709a70eca78d7ca2bb8]

CVE-2025-21772: partitions: mac: fix handling of bogus partition table

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2025-21772-5ec0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc3.


Fixed status
mainline: [80e648042e512d5a767da251d44132553fe04ae0]
stable/6.1: [27a39d006f85e869be68c1d5d2ce05e5d6445bf5]
stable/6.6: [92527100be38ede924768f4277450dfe8a40e16b]

CVE-2025-21773: can: etas_es58x: fix potential NULL pointer
dereference on udev->serial

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2025-21773-2ee7@gregkh/

Introduced by commit 9f06631 ("can: etas_es58x: export product
information through devlink_ops::info_get()") in v6.2-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1ad2109ce41c9e3912dadd07ad8a9c640064ffb]
stable/6.6: [1590667a60753ee5a54871f2840ceefd4a7831fa]

CVE-2025-21774: can: rockchip: rkcanfd_handle_rx_fifo_overflow_int():
bail out if skb cannot be allocated

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2025-21774-26d5@gregkh/

Introduced by commit ff60bfb ("can: rockchip_canfd: add driver for
Rockchip CAN-FD controller") in v6.12-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7f0adfe64de08803990dc4cbecd2849c04e314a]

CVE-2025-21775: can: ctucanfd: handle skb allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2025022606-CVE-2025-21775-3137@gregkh/

Introduced by commit 2dcb8e8 ("can: ctucanfd: add support for CTU CAN
FD open-source IP core - bus independent part.") in v5.19-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bd24927e3eeb85642c7baa3b28be8bea6c2a078]
stable/6.1: [84b9ac59978a6a4e0812d1c938fad97306272cef]
stable/6.6: [e505b83b9ee6aa0ae2f4395f573a66579ae403fb]

CVE-2025-21776: USB: hub: Ignore non-compliant devices with too many
configs or interfaces

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2025-21776-5581@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc3.


Fixed status
mainline: [2240fed37afbcdb5e8b627bc7ad986891100e05d]
stable/6.1: [c3720b04df84b5459050ae4e03ec7d545652f897]
stable/6.6: [e905a0fca7bff0855d312c16f71e60e1773b393e]

CVE-2025-21777: ring-buffer: Validate the persistent meta data subbuf array

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2025-21777-0c96@gregkh/

Introduced by commit c76883f ("ring-buffer: Add test if range of boot
buffer is valid") in v6.12-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5b95f1fa2ef3a03f49eeec658ba97e721412b32]

CVE-2025-21778: tracing: Do not allow mmap() of persistent ring buffer

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2025-21778-9ae4@gregkh/

Introduced by commit 9b7bdf6 ("tracing: Have trace_printk not use
binary prints if boot buffer") in v6.12-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [129fe718819cc5e24ea2f489db9ccd4371f0c6f6]

CVE-2025-21779: KVM: x86: Reject Hyper-V's SEND_IPI hypercalls if
local APIC isn't in-kernel

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2025-21779-f239@gregkh/

Introduced by commit 214ff83 ("KVM: x86: hyperv: implement PV IPI send
hypercalls") in v4.20-rc1.
Introduced by commit 2bc3997 ("x86/kvm/hyper-v: Introduce
KVM_GET_SUPPORTED_HV_CPUID") in v5.0-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8de7f100bb5989d9c3627d3a223ee1c863f3b69]
stable/6.1: [5393cf22312418262679eaadb130d608c75fe690]
stable/6.6: [874ff13c73c45ecb38cb82191e8c1d523f0dc81b]

CVE-2025-21780: drm/amdgpu: avoid buffer overflow attach in
smu_sys_set_pp_table()

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2025-21780-8283@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc3.


Fixed status
mainline: [1abb2648698bf10783d2236a6b4a7ca5e8021699]
stable/6.1: [3484ea33157bc7334f57e64826ec5a4bf992151a]
stable/6.6: [e43a8b9c4d700ffec819c5043a48769b3e7d9cab]

CVE-2025-21781: batman-adv: fix panic during interface removal

Announce: https://lore.kernel.org/linux-cve-announce/2025022607-CVE-2025-21781-7324@gregkh/

Introduced by commit c833484 ("batman-adv: ELP - compute the metric
based on the estimated throughput") in v4.6-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccb7276a6d26d6f8416e315b43b45e15ee7f29e2]
stable/6.1: [7eb5dd201695645af071592a50026eb780081a72]
stable/6.6: [072b2787321903287a126c148e8db87dd7ef96fe]

CVE-2025-21782: orangefs: fix a oob in orangefs_debug_write

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2025-21782-9d97@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc1.


Fixed status
mainline: [f7c848431632598ff9bce57a659db6af60d75b39]
stable/6.1: [1da2697307dad281dd690a19441b5ca4af92d786]
stable/6.6: [2b84a231910cef2e0a16d29294afabfb69112087]

CVE-2025-21783: gpiolib: Fix crash on error in gpiochip_get_ngpios()

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2025-21783-2714@gregkh/

Introduced by commit 55b2395 ("gpio: mmio: handle "ngpios" properly in
bgpio_init()") in v6.6-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b4aebeecbbd5b5fe73e35fad3f62ed21aa7ef44]
stable/6.6: [4d9b2b62e1136d10f661ec4c0c268140b6f74f4f]

CVE-2025-21784: drm/amdgpu: bail out when failed to load fw in
psp_init_cap_microcode()

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2025-21784-cd4e@gregkh/

Introduced by commit 07dbfc6 ("drm/amd: Use `amdgpu_ucode_*` helpers
for PSP") in v6.3-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0a455b4bc7483ad60e8b8a50330c1e05bb7bfcf]
stable/6.6: [3f40a7ff39d9f1d283d5aa9b13e2fb16200aff5f]

CVE-2025-21785: arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2025-21785-184c@gregkh/

Introduced by commit 5d425c1 ("arm64: kernel: add support for cpu
cache information") in v4.0-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [875d742cf5327c93cba1f11e12b08d3cce7a88d2]
stable/6.1: [4ff25f0b18d1d0174c105e4620428bcdc1213860]
stable/6.6: [ab90894f33c15b14c1cee6959ab6c8dcb09127f8]

CVE-2025-21786: workqueue: Put the pwq after detaching the rescuer from the pool

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2025-21786-f31d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.14-rc3.


Fixed status
mainline: [e76946110137703c16423baf6ee177b751a34b7e]

CVE-2025-21787: team: better TEAM_OPTION_TYPE_STRING validation

Announce: https://lore.kernel.org/linux-cve-announce/2025022608-CVE-2025-21787-c4f2@gregkh/

Introduced by commit 3d249d4 ("net: introduce ethernet teaming
device") in v3.3-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bef3ac184b5626ea62385d6b82a1992b89d7940]
stable/6.1: [4512482e4805dd30bc77dec511f2a2edba5cb868]
stable/6.6: [d071a91fa614ecdf760c29f61f6a7bfb7df796d6]

CVE-2025-21788: net: ethernet: ti: am65-cpsw: fix memleak in certain XDP cases

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2025-21788-2619@gregkh/

Introduced by commit 8acacc4 ("net: ethernet: ti: am65-cpsw: Add
minimal XDP support") in v6.10-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5db843258de1e4e6b1ef1cbd1797923c9e3de548]

CVE-2025-21789: LoongArch: csum: Fix OoB access in IP checksum code
for negative lengths

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2025-21789-9691@gregkh/

Introduced by commit 69e3a6a ("LoongArch: Add checksum optimization
for 64-bit system") in v6.4-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6287f1a8c16138c2ec750953e35039634018c84a]
stable/6.6: [964a8895704a22efc06a2a3276b624a5ae985a06]

CVE-2025-21790: vxlan: check vxlan_vnigroup_init() return value

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2025-21790-af3e@gregkh/

Introduced by commit f9c4bb0 ("vxlan: vni filtering support on collect
metadata device") in v5.18-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5805402dcc56241987bca674a1b4da79a249bab7]
stable/6.1: [79aea5e55156c87dc570e43fcd8bba01b9d6ab3f]
stable/6.6: [a303649b99b64858d62ce7428125d8e71675d2b6]

CVE-2025-21791: vrf: use RCU protection in l3mdev_l3_out()

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2025-21791-6074@gregkh/

Introduced by commit a8e3e1a ("net: l3mdev: Add hook to output path")
in v4.9-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d0ce46a93135d96b7fa075a94a88fe0da8e8773]
stable/6.1: [c7574740be8ce68a57d0aece24987b9be2114c3c]
stable/6.6: [c40cb5c03e37552d6eff963187109e2c3f78ef6f]

CVE-2025-21792: ax25: Fix refcount leak caused by setting
SO_BINDTODEVICE sockopt

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2025-21792-d8e8@gregkh/

Introduced by commit 9fd75b6 ("ax25: Fix refcount leaks caused by
ax25_cb_del()") in v5.18-rc1.
Fixed in v6.14-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [bca0902e61731a75fc4860c8720168d9f1bae3b6]
stable/6.1: [90056ece99966182dc0e367f3fd2afab46ada847]
stable/6.6: [94a0de224ed52eb2ecd4f4cb1b937b674c9fb955]

CVE-2025-21793: spi: sn-f-ospi: Fix division by zero

Announce: https://lore.kernel.org/linux-cve-announce/2025022609-CVE-2025-21793-2c1e@gregkh/

Introduced by commit 1b74dd6 ("spi: Add Socionext F_OSPI SPI flash
controller driver") in v6.2-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3588b1c0fde2f58d166e3f94a5a58d64b893526c]
stable/6.6: [966328191b4c389c0f2159fa242915f51cbc1679]

CVE-2025-21794: HID: hid-thrustmaster: fix stack-out-of-bounds read in
usb_check_int_endpoints()

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2025-21794-ddde@gregkh/

Introduced by commit 50420d7 ("HID: hid-thrustmaster: Fix warning in
thrustmaster_probe by adding endpoint check") in v6.14-rc1.
Fixed in v6.13.4.

Bug introduced commit was backported to following branches.
stable/6.1 stable/6.12 stable/6.13 stable/6.6

Fixed status
mainline: [73e36a699b9f46322ffb81f072a24e64f728dba7]
stable/6.1: [436f48c864186e9413d1b7c6e91767cc9e1a65b8]
stable/6.6: [436f48c864186e9413d1b7c6e91767cc9e1a65b8]

CVE-2025-21795: NFSD: fix hang in nfsd4_shutdown_callback

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2025-21795-785d@gregkh/

Introduced by commit 66af257 ("NFSD: add courteous server support for
thread with only delegation") in v5.19-rc1.
Fixed in v6.14-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [036ac2778f7b28885814c6fbc07e156ad1624d03]
stable/6.1: [38d345f612503b850c2973e5a879f88e441b34d7]
stable/6.6: [23ad7797c74cd8f7f90617f1e59a8703e2b43908]

CVE-2025-21796: nfsd: clear acl_access/acl_default after releasing them

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2025-21796-0133@gregkh/

Introduced by commit a257cdd ("[PATCH] NFSD: Add server support for
NFSv3 ACLs.") in v2.6.13-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7faf14a7b0366f153284db0ad3347c457ea70136]
stable/6.1: [2e59b2b68782519560b3d6a41dd66a3d01a01cd3]
stable/6.6: [55d947315fb5f67a35e4e1d3e01bb886b9c6decf]

CVE-2025-21797: HID: corsair-void: Add missing delayed work cancel for
headset status

Announce: https://lore.kernel.org/linux-cve-announce/2025022610-CVE-2025-21797-04ee@gregkh/

Introduced by commit 6ea2a6f ("HID: corsair-void: Add Corsair Void
headset family driver") in v6.13-rc1.
Fixed in v6.14-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48e487b002891eb0aeaec704c9bed51f028deff1]


* Updated CVEs

CVE-2024-26596: net: dsa: fix netdev_priv() dereference before check
on non-DSA netdevice events

stable/6.1 was fixed.

Fixed status
stable/6.1: [9e9953f5e4d6d11a9dad56fdee307bb923302809]
stable/6.6: [69a1e2d938dbbfcff0e064269adf60ad26dbb102]
stable/6.7: [dbd909c20c11f0d29c0054d41e0d1f668a60e8c8]

CVE-2024-40945: iommu: Return right value in iommu_sva_bind_device()

stable/6.1 was fixed.

Fixed status
stable/5.10: [cf34f8f66982a36e5cba0d05781b21ec9606b91e]
stable/5.15: [2973b8e7d127754de9013177c41c0b5547406998]
stable/5.4: [700f564758882db7c039dfba9443fe762561a3f8]
stable/6.1: [6325eab6c108fed27f60ff51852e3eac0ba23f3f]
stable/6.6: [7388ae6f26c0ba95f70cc96bf9c5d5cb06c908b6]
stable/6.9: [61a96da9649a6b6a1a5d5bde9374b045fdb5c12e]

CVE-2024-42122: drm/amd/display: Add NULL pointer check for kzalloc

stable/6.1 was fixed.

Fixed status
stable/6.1: [552e7938b4d7fe548fbf29b9950a14c6149d0470]
stable/6.6: [cd1e565a5b7fa60c349ca8a16db1e61715fe8230]

CVE-2024-47726: f2fs: fix to wait dio completion

stable/6.1 was fixed.

Fixed status
stable/6.1: [f81302decd64245bb1bd154ecae0f65a9ee21f04]
stable/6.11: [e3db757ff9b7101ae68650ac5f6dd5743b68164e]
stable/6.6: [c2a7fc514637f640ff55c3f3e3ed879970814a3f]

CVE-2024-49919: drm/amd/display: Add null check for head_pipe in
dcn201_acquire_free_pipe_for_layer

stable/6.6 was fixed.

Fixed status
stable/6.11: [8a1b1655a490a492a5a6987254c935ecce4eb9de]
stable/6.6: [16ce8fd94da8599bb6f0496895d392a69aead1c0]

CVE-2024-49923: drm/amd/display: Pass non-null to
dcn20_validate_apply_pipe_split_flags

stable/6.6 was fixed.

Fixed status
stable/6.11: [9a05270869f40c89f8d184fe2d37cb86e0d7e5f5]
stable/6.6: [39a580cd15397e102aaec25986ae5acf492f8930]

CVE-2024-49989: drm/amd/display: fix double free issue during amdgpu
module unload

stable/6.1 was fixed.

Fixed status
stable/6.1: [df948b5ba6858d5da34f622d408e5517057cec07]
stable/6.11: [3c0ff4de45ce2c5f7997a1ffa6eefee4b79e6b58]
stable/6.6: [cf6f3ebd6312d465fee096d1f58089b177c7c67f]

CVE-2024-50061: i3c: master: cdns: Fix use after free vulnerability in
cdns_i3c_master Driver Due to Race Condition

stable/6.1 was fixed.

Fixed status
stable/6.1: [2a21bad9964c91b34d65ba269914233720c0b1ce]
stable/6.11: [687016d6a1efbfacdd2af913e2108de6b75a28d5]
stable/6.6: [ea0256e393e0072e8c80fd941547807f0c28108b]

CVE-2024-50070: pinctrl: stm32: check devm_kasprintf() returned value

stable/6.1 was fixed.

Fixed status
stable/6.1: [a8d52de0a6c6b091b2771bcb98ce408cf9d69fe3]
stable/6.11: [1f266957ae1207b0717c2d69096bc70654ae9fcb]
stable/6.6: [3b36bb1fca2b87f6292ca2a8593f297c5e9fab41]

CVE-2024-56549: cachefiles: Fix NULL pointer dereference in object->file

stable/6.1 was fixed.

Fixed status
stable/6.1: [d6bba3ece960129a553d4b16f1b00c884dc0993a]
stable/6.12: [9582c7664103c9043e80a78f5c382aa6bdd67418]
stable/6.6: [785408bbafcfa24c9fc5b251f03fd0780ce182bd]

CVE-2025-21684: gpio: xilinx: Convert gpio_lock to raw spinlock

stable/6.1 was fixed.

Fixed status
stable/6.1: [f0ed2d0abc021f56fa27dc6d0770535c1851a43b]
stable/6.12: [9c035105c5537d2ecad6b9415e9417a1ffbd0a62]
stable/6.6: [b0111650ee596219bb5defa0ce1a1308e6e77ccf]

CVE-2025-21700: net: sched: Disallow replacing of child qdisc from one
parent to another

stable/6.1 was fixed.

Fixed status
stable/6.1: [deda09c0543a66fa51554abc5ffd723d99b191bf]
stable/6.12: [73c7e1d6898ccbeee126194dcc05f58b8a795e70]
stable/6.13: [46c59ec33ec98aba20c15117630cae43a01404cc]
stable/6.6: [7e2bd8c13b07e29a247c023c7444df23f9a79fd8]

CVE-2025-21701: net: avoid race between device unregistration and ethnl ops

stable/6.1 was fixed.

Fixed status
stable/6.1: [b1cb37a31a482df3dd35a6ac166282dac47664f4]
stable/6.12: [b382ab9b885cbb665e0e70a727f101c981b4edf3]
stable/6.13: [4dc880245f9b529fa8f476b5553c799d2848b47b]
stable/6.6: [2f29127e94ae9fdc7497331003d6860e9551cdf3]

CVE-2025-21703: netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()

stable/6.1 was fixed.

Fixed status
stable/6.1: [7b79ca9a1de6a428d486ff52fb3d602321c08f55]
stable/6.12: [6312555249082d6d8cc5321ff725df05482d8b83]
stable/6.13: [839ecc583fa00fab785fde1c85a326743657fd32]
stable/6.6: [1f8e3f4a4b8b90ad274dfbc66fc7d55cb582f4d5]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

