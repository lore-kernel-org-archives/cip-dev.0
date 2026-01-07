Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625CDD0D17A
	for <webhook@archiver.kernel.org>; Wed,  7 Jan 2026 22:24:19 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18690.1767824655911410042
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 14:24:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Ai4V8lTm;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.45, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64661975669so2749267d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 14:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1767824655; x=1768429455; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5dmU06xcoKPmBvDKK6nUNZ1KU3TeFJO4bn1+tYV2syI=;
        b=Ai4V8lTmnmeRiyzifE34K8HXcztNr3FgSrrWrA0mgXcFcvr8YJKhLdXgWQL7WxNpEP
         yW3NpULM23NTEGPniK7YysQghGQp4Ae2UPeYz4x7/q9o4n7OMXBZC/CVXMTWoSScrlxH
         u6A9t02jiWK63Be4EGvtQSUFsEy/kLvuMOghCaikHIoGmZC+GEWv7Apbnn2brxxzYI5m
         RJIvRzrNs9tJ9PKN8pGCgyKgBkHsqHw9pvOPXYyWmomv397FIfxYQPLd4YbBqckfHcS2
         vb9gGdwyONCFV4pSB2jGDb7RsqALKUqLIIhFgJxtM9omatdQk9ffz9J5IrapWqjObEK0
         OmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767824655; x=1768429455;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5dmU06xcoKPmBvDKK6nUNZ1KU3TeFJO4bn1+tYV2syI=;
        b=xLb9r4t6vz5oRNznIM5mBgPZL9Ai+N1SGhOXCJih73ELXhNMsCvczQfJAwI9my8Pod
         pUCj5dLxj1IxcMKcmFnARqzwZWVAWxNTStRU5YyPteiVk1q6/UKduzHG3E6jUT7r5bb2
         0aMIlsRgE1Rr5rKDUBXRaQaKq7UwT733vca+3zEAtcPY4es+dxGxCANekABA81ztd3NQ
         kFglxKha+3/I8otYviVf01kozkcxr/swdQTLDjMQ/654DFzODLGBjjMWKK4pTAOg22c8
         BhowUofF33DT8OEKTrQoMhVjrkEyBj7rCFDMqoKbJhzTpUvZMuqzGz+a6RkiQ+PpC2G4
         V34w==
X-Gm-Message-State: AOJu0YwWQdmN5HYS7neLfMOE0ijcVy4r80Vgw+juDm6zFhsk7+LzokIK
	87l9HUYYcqON9hYIIJe3Q5vRA9oe5T6EH64+5zW5mkLCATdrEqpAKemP/8aWoML6Svh0fOfLCtS
	U1y+14w5YdO4jfcu69ZyznUyYwzOZfx/oPkkcU7L6q/h+VNVM7ndsmyY=
X-Gm-Gg: AY/fxX6pbXZaKgUUCyWyTuiDwms1Mabl//LNyuGvb1plyqhRCNyTH1chmmrzwamQtJV
	wjmxvTDTYUYbAmiHdbiBRc/mWG0gwe6DomqtRRpgwzf0hYp0vF92MN20ymIsPuz+RawJsp9foGD
	D7cPds9+0il92xmAeu6zA4DnnrFK7C/s6LqW72vteB/YfO2L2TIID14zc32iKS20A4UvIl6PB4R
	yQWM5j5yNDc50yQw8V/plWjk5AZCaY1xZJnlVBJnUKMiwlw6RiTQfxnfw4YBKr+WihReiJD
X-Google-Smtp-Source: AGHT+IGFBgbjqPFQkIQWq0veqokCE5k5TNsVwAVafGr1bBvhTUTwSayudPDWFnTvj0qx4OIrasirvmQtxqfswAClbNg=
X-Received: by 2002:a53:cd0c:0:b0:645:5cd9:cb42 with SMTP id
 956f58d0204a3-64716c9b5d3mr2591926d50.91.1767824654743; Wed, 07 Jan 2026
 14:24:14 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 8 Jan 2026 07:23:39 +0900
X-Gm-Features: AQt7F2r1sTvwIQqQnf49NW_yVdneFpIO2LrmGJK1PeOdehAIvwb9r9bKfht4vfM
Message-ID: <CAODzB9peD2i4=MZm_z6ACokwN_LvKsiuLHeV_PgTOeUa2wVErg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 Jan 2026 22:24:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21422

Hi!

It's this week's CVE report.

This week reported 16 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2025-68751: s390/fpu: Fix false-positive kmsan report in fpu_vstl()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68751

Introduced by commit dcd3e1d ("s390/checksum: provide
csum_partial_copy_nocheck()") in v6.9-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14e4e4175b64dd9216b522f6ece8af6997d063b2]

CVE-2025-68752: iavf: Implement settime64 with -EOPNOTSUPP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68752

Introduced by commit d734223 ("iavf: add initial framework for
registering PTP clock") in v6.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e43ebcd5152b3e681a334cc6542fb21770c3a2e]

CVE-2025-68753: ALSA: firewire-motu: add bounds check in put_user loop
for DSP events

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68753

Introduced by commit 634ec0b ("ALSA: firewire-motu: notify event for
parameter change in register DSP model") in v5.16-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [298e753880b6ea99ac30df34959a7a03b0878eed]
stable/6.12: [0d71b3c2ed742f1ccb3b0b7a61afb90c0251093f]

CVE-2025-68754: rtc: amlogic-a4: fix double free caused by devm

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68754

Introduced by commit c89ac91 ("rtc: support for the Amlogic on-chip
RTC") in v6.13-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [384150d7a5b60c1086790a8ee07b0629f906cca2]

CVE-2025-68755: staging: most: remove broken i2c driver

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68755

Introduced by commit 723de0f ("staging: most: remove device from
interface structure") in v5.6-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [495df2da6944477d282d5cc0c13174d06e25b310]

CVE-2025-68756: block: Use RCU in blk_mq_[un]quiesce_tagset() instead
of set->tag_list_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68756

Introduced by commit 98d81f0 ("nvme: use blk_mq_[un]quiesce_tagset")
in v6.2-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59e25ef2b413c72da6686d431e7759302cfccafa]
stable/6.12: [3baeec23a82e7ee9691f434c6ab0ab1387326108]

CVE-2025-68757: drm/vgem-fence: Fix potential deadlock on release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68757

Introduced by commit 4077798 ("drm/vgem: Attach sw fences to exported
vGEM dma-buf (ioctl)") in v4.8-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78b4d6463e9e69e5103f98b367f8984ad12cdc6f]
stable/6.12: [338e388c0d80ffc04963b6b0ec702ffdfd2c4eba]

CVE-2025-68758: backlight: led-bl: Add devlink to supplier LEDs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68758

Introduced by commit ae232e4 ("backlight: add led-backlight driver")
in v5.6-rc5.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9341d6698f4cfdfc374fb6944158d111ebe16a9d]
stable/6.12: [0e63ea4378489e09eb5e920c8a50c10caacf563a]

CVE-2025-68759: wifi: rtl818x: Fix potential memory leaks in
rtl8180_init_rx_ring()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68759

Introduced by commit f653211 ("Add rtl8180 wireless driver") in v2.6.25-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b5b9c042b30befc5b37e4539ace95af70843473]
stable/6.12: [ee7db11742b30641f21306105ad27a275e3c61d7]

CVE-2025-68760: iommu/amd: Fix potential out-of-bounds read in iommu_mmio_show

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68760

Introduced by commit 7a4ee41 ("iommu/amd: Add debugfs support to dump
IOMMU MMIO registers") in v6.17-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0c7005333f9a968abb058b1d77bbcd7fb7fd1e7]

CVE-2025-68761: hfs: fix potential use after free in
hfs_correct_next_unused_CNID()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68761

Introduced by commit a06ec28 ("hfs: add logic of correcting a next
unused CNID") in v6.18-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c105e76bb17cf4b55fe89c6ad4f6a0e3972b5b08]

CVE-2025-68762: net: netpoll: initialize work queue before error checks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68762

Introduced by commit 248f657 ("netpoll: Optimize skb refilling on
critical path") in v6.15-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5235eb6cfe02a51256013a78f7b28779a7740d5]

CVE-2025-68763: crypto: starfive - Correctly handle return of sg_nents_for_len

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68763

Introduced by commit 7883d1b ("crypto: starfive - Add hash and HMAC
support") in v6.5-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9eb52037a529fbb307c290e9951a62dd728b03d]
stable/6.12: [0c3854d65cc4402cb8c52d4d773450a06efecab6]

CVE-2025-68764: NFS: Automounted filesystems should inherit
ro,noexec,nodev,sync flags

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68764

Introduced by commit f2aedb7 ("NFS: Add fs_context support.") in v5.6-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8675c69816e4276b979ff475ee5fac4688f80125]
stable/6.12: [612cc98698d667df804792f0c47d4e501e66da29]

CVE-2025-68765: mt76: mt7615: Fix memory leak in mt7615_mcu_wtbl_sta_add()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68765

Introduced by commit 99c457d ("mt76: mt7615: move mt7615_mcu_set_bmc
to mt7615_mcu_ops") in v5.7-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53d1548612670aa8b5d89745116cc33d9d172863]
stable/6.12: [278bfed4529a0c9c9119f5a52ddafe69db61a75c]

CVE-2025-68766: irqchip/mchp-eic: Fix error code in mchp_eic_domain_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-68766

Introduced by commit 00fa346 ("irqchip/mchp-eic: Add support for the
Microchip EIC") in v5.16-rc1.
Fixed in v6.19-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dbc0d40d8347bd9de55c904f59ea44bcc8dedb7]
stable/6.12: [3873afcb57614c1aaa5b6715554d6d1c22cac95a]

* Updated CVEs

No update CVEs.

Fixed status

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

