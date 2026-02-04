Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171CCEA794C
	for <webhook@archiver.kernel.org>; Wed,  4 Feb 2026 23:05:36 +0000 (UTC)
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8475.1770246325845273500
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 15:05:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=QE8/QlOw;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.45, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649b1ca87ddso483868d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 04 Feb 2026 15:05:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770246325; cv=none;
        d=google.com; s=arc-20240605;
        b=OhWAUOQc4eLt4kTFrVj2f3I7x/UUcwu18M3ouCapfLsD3XEVAzmfvn54DRCcZ8Jaj/
         Ft+QNh9lA1xSdVh7VOfbvJ08nRdAXXwGA/G06bkvSAuFa9ME6su0CMEtpPnP1CwC04iu
         DM6jAZklWKZQ+BIGbgiraoqYdcK7mzDWzc94zzI56Bq3oTI9S5PTUTxX3lZk1/741OpJ
         sEvJ8b1mohUGisAWVvaLMsxORpGLo05Wcc6oX5ZFeyLr9NgCPuaew98CoTQHHoi43RWQ
         Zpua4tZpvYLJiYhUcgHa0wh8GOdNzwh4rqrl2jfeP1I3ZnkXMXbHlVu3Xm0jycyHFq3U
         3Miw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=naFGkaf4Oxy2xxV7zWMExuv3u2FfAu7DNVh9LisGoo4=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=KENZPn4DJS4elsxR3biEohQDwvLdF325OJh8Ho8vxzGbYKT5R6q5LZvGiGjCtQGtqW
         BXbnuOZRz4bL8uOLwNl0nV+U87V8ZUDYE+DqDbkGB1PBIb7Wy0yFNY8SXkbdAMG0hZxL
         If2N99LPw/5bSslSSAU8hjoWjxmLN001KCaPcmAgIEGq5frOD6Bwmzpt9S9LGGxtV8NW
         HfZIh9fIv9183cF6bnYv4VbjfHIKbMjASn86BTE2Hk/qYiyy2oP/Vm+zl4TvAaSEzwLa
         kpC2Z9kizVNMSDQYRyKFOTkXdi9N/2V4GS2OoZWq5P3dOsmjw2V+dQQhAyhaX2m+9gCH
         ILbw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1770246325; x=1770851125; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=naFGkaf4Oxy2xxV7zWMExuv3u2FfAu7DNVh9LisGoo4=;
        b=QE8/QlOwZ+OlD/d9Edu6vOhIcUAH2mEqi9PW/bIS/Sz4cBAQi7KPdIPnORyGBocvJI
         sO3rQ+oVVr3bDFKG3gb7t7tj4+Y6arfPO1d4ic4aErxEQmw6eTnJMaDHzzN10rnatdVo
         D3znP3hplS8lb8DoDI/NgI+PioajS2PFFf5ualm5pw+zvUSi1KzkQdWR69TWO7xQ2FNo
         qs78aFz0VXM1hc+mxFfu3OgojfekEj4QlvUlcsL1N2tmsrVoZkVcwx9IiybX+oXNxdwJ
         X0BXokkzv3r5AvA9VabkXx0Vk2jfCPTqhYLWLz9Lbnsw9xcIXFoH18Jntdvz7okgslVJ
         Kirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770246325; x=1770851125;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=naFGkaf4Oxy2xxV7zWMExuv3u2FfAu7DNVh9LisGoo4=;
        b=oOpMakDXhiuPIBbvTAdU4QB3y7iYoK1Eq/ns7pBmBpbPY7lq0NZ93I5QU0pyO1vyoP
         XKANuzDSQ7Iu3nQlQ19jduE18+dpNfOjPruOmlf9eCfCK3s91eqLIjmZMF3lQVgAUcHe
         Xn7XCXVrNYTVHUXzsPtC19t/Yo8q7F/6kItH2CFRGsksgPdM682waffUdvQWOH6vt0kI
         ee3cWxaDEFo5KmyjIH0ONRNYoFczpmOhhLANt4U1B5DZoK49B9LlolR0MSvoilR2z1hb
         5UexFO0J8YYGaWQb00f7C7dQV8pH1qmj03VG/ShAlBPdilho2q5Tky+rcsIGl3F1rp5o
         W+aQ==
X-Gm-Message-State: AOJu0Yy+ylPRSs4S8i3xLZB6IqnWYcUBi3P5Ym9ivCBjhGyONXPCgjWe
	BhSgLNgYCyUiOIyFG50g7++VLdLfYa03RMKXc86ABF/6k8Mu+b4F/jPEmKkhTxvkIto8mXkzYuu
	4Qj2g98fcTrmpCTEGemca6DukR3QmMmmKsrXIEtwzc3W7DhXt9mv9Wqs=
X-Gm-Gg: AZuq6aLBJkofUyiseZA0o1RhxKkd7MkTm7goapMgIcDZ8cWx0va3xW6iiNEknum/hfb
	HZiX8etgg/o0BKX7UUOctpocHunxYI9MQuxkM4iqOkzpcfxLCFFiJjspRY/fQ0kfuj2bJzNnSVg
	bq6/Jc8BtcCA6P8t8E3/FQVDtkqfQtjVucfmzGpi/O/23P+4QzkWiA/pjR5MsOkk51KO8JzG+Gm
	TiU6Cm2MRzz/JWR00riIDAvLG6c8Mo/OkiEUfp/x+MqLvIJYGaYjbW+hgjcumcBQl1z2uBN
X-Received: by 2002:a05:690e:1247:b0:649:bb59:fee7 with SMTP id
 956f58d0204a3-649db4a9e72mr3899151d50.80.1770246323321; Wed, 04 Feb 2026
 15:05:23 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Feb 2026 08:04:47 +0900
X-Gm-Features: AZwV_QhDHmXzeJr5BvbNRAU3YmJTj2ahXmQHUePImlbDPofBPESQ5S1ZM0klLuM
Message-ID: <CAODzB9ovtHcry4LvtAO6_KyrTYcFSTdxiwbK=vbS29ffqXkg8g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Feb 2026 23:05:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21827

Hi!

It's this week's CVE report.

This week reported 116 new CVEs and 16 updated CVEs.

* New CVEs
CVE-2025-71180: counter: interrupt-cnt: Drop IRQF_NO_THREAD flag

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71180

Introduced by commit a55ebd4 ("counter: add IRQ or GPIO based
counter") in v5.13-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23f9485510c338476b9735d516c1d4aacb810d46]
stable/5.15: [ef668c9a2261ec9287faba6e6ef05a98b391aa2b]
stable/6.1: [51d2e5d6491447258cb39ff1deb93df15d3c23cb]
stable/6.12: [49a66829dd3653695e60d7cae13521d131362fcd]
stable/6.18: [425886b1f8304621b3f16632b274357067d5f13f]
stable/6.6: [1c5a3175aecf82cd86dfcbef2a23e8b26d8d8e7c]

CVE-2025-71181: rust_binder: remove spin_lock() in rust_shrink_free_page()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71181

Introduced by commit eafedbc ("rust_binder: add Rust Binder driver")
in v6.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [361e0ff456a8daf9753c18030533256e4133ce7a]
stable/6.18: [30a98c97f7874031f2e1de19c777ce011143cba4]

CVE-2025-71182: can: j1939: make j1939_session_activate() fail if
device is no longer registered

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71182

According to the .vulnerable file, this bug was introduced by commit
9d71dd0 in v5.4-rc1.
Fixed in v6.19-rc2.
Affected file was added by commit 9d71dd0 ("can: add support of SAE
J1939 protocol") in 5.4-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d5602236f5db19e8b337a2cd87a90ace5ea776d]
stable/5.10: [ebb0dfd718dd31c8d3600612ca4b7207ec3d923a]
stable/5.15: [c3a4316e3c746af415c0fd6c6d489ad13f53714d]
stable/6.1: [46ca9dc978923c5e1247a9e9519240ba7ace413c]
stable/6.12: [ba6f0d1832eeb5eb3a6dc5cb30e0f720b3cb3536]
stable/6.18: [79dd3f1d9dd310c2af89b09c71f34d93973b200f]
stable/6.6: [78d87b72cebe2a993fd5b017e9f14fb6278f2eae]

CVE-2025-71183: btrfs: always detect conflicting inodes when logging inode refs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71183

According to the .vulnerable file, this bug was introduced by commit
56f23fd in v4.6-rc3.
Fixed in v6.19-rc5.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
stable/6.1: [c7f0207db68d5a1b4af23acbef1a8e8ddc431ebb]
stable/6.12: [0c2413c69129f6ce60157f7b53d9ba880260400b]
stable/6.18: [d52af58dd463821c5c516aebb031a58934f696ea]
stable/6.6: [a63998cd6687c14b160dccb0bbcf281b2eb0dab3]

CVE-2025-71184: btrfs: fix NULL dereference on root when tracing inode eviction

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71184

Introduced by commit 1abe9b8 ("Btrfs: add initial tracepoint support
for btrfs") in v2.6.39-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f157dd661339fc6f5f2b574fe2429c43bd309534]
stable/6.12: [582ba48e4a4c06fef6bdcf4e57b7b9af660bbd0c]
stable/6.18: [99e057f3d3ef24b99a7b1d84e01dd1bd890098da]

CVE-2025-71185: dmaengine: ti: dma-crossbar: fix device leak on am335x
route allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71185

Introduced by commit 42dbdcc ("dmaengine: ti-dma-crossbar: Add support
for crossbar on AM33xx/AM43xx") in v4.4-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fc17b1c6d2e04ad13fd6c21cfbac68043ec03f9]
stable/6.12: [f810132e825588fbad3cba940458c58bb7ec4d84]
stable/6.18: [30352277d8e09c972436f883a5efd1f1b763ac14]
stable/6.6: [6fdf168f57e331e148a1177a9b590a845c21b315]

CVE-2025-71186: dmaengine: stm32: dmamux: fix device leak on route allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71186

Introduced by commit df7e762 ("dmaengine: Add STM32 DMAMUX driver") in
v4.15-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd6e4943889fb354efa3f700e42739da9bddb6ef]
stable/6.12: [2fb10259d4efb4367787b5ae9c94192e8a91c648]
stable/6.18: [3ef52d31cce8ba816739085a61efe07b63c6cf27]
stable/6.6: [1a179ac01ff3993ab97e33cc77c316ed7415cda1]

CVE-2025-71187: dmaengine: sh: rz-dmac: fix device leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71187

Introduced by commit 7de8732 ("dmaengine: sh: rz-dmac: Add RZ/V2H(P)
support") in v6.16-rc1.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12

Fixed status
mainline: [9fb490323997dcb6f749cd2660a17a39854600cd]
stable/6.18: [926d1666420c227eab50962a8622c1b8444720e8]

CVE-2025-71188: dmaengine: lpc18xx-dmamux: fix device leak on route allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71188

Introduced by commit e5f4ae8 ("dmaengine: add driver for lpc18xx
dmamux") in v4.3-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4d63059dee7e7cae0c4d9a532ed558bc90efb55]
stable/6.12: [992eb8055a6e5dbb808672d20d68e60d5a89b12b]
stable/6.18: [1e47d80f6720f0224efd19bcf081d39637569c10]
stable/6.6: [9fba97baa520c9446df51a64708daf27c5a7ed32]

CVE-2025-71189: dmaengine: dw: dmamux: fix OF node leak on route
allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71189

Introduced by commit 134d9c5 ("dmaengine: dw: dmamux: Introduce RZN1
DMA router support") in v5.19-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec25e60f9f95464aa11411db31d0906b3fb7b9f2]
stable/6.12: [8f7a391211381ed2f6802032c78c7820d166bc49]
stable/6.18: [eabe40f8a53c29f531e92778ea243e379f4f7978]
stable/6.6: [db7c79c1bbfb1b0184e78a17ac2bd0f2bc3134d1]

CVE-2025-71190: dmaengine: bcm-sba-raid: fix device leak on probe

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71190

Introduced by commit 743e1c8 ("dmaengine: Add Broadcom SBA RAID
driver") in v4.13-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c3a46ebf15a9796b763a54272407fdbf945bed8]
stable/6.12: [db6f1d6d31711e73e6a214c73e6a8fb4cda0483d]
stable/6.18: [2ed1a9de1f2d727ccae5bc9cc7c63ee3519c0c8b]
stable/6.6: [c80ca7bdff158401440741bdcf9175bd8608580b]

CVE-2025-71191: dmaengine: at_hdmac: fix device leak on of_dma_xlate()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71191

Introduced by commit bbe89c8 ("at_hdmac: move to generic DMA binding")
in v3.10-rc1.
Introduced by commit 3832b78 ("dmaengine: at_hdmac: add missing
put_device() call in at_dma_xlate()") in v5.9-rc4.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [b9074b2d7a230b6e28caa23165e9d8bc0677d333]
stable/6.12: [6a86cf2c09e149d5718a5b7090545f7566da9334]
stable/6.18: [f3c23b7e941349505c3d40de2cc0acd93d9ac057]
stable/6.6: [987c71671367f42460689b78244d7b894c50999a]

CVE-2026-23015: gpio: mpsse: fix reference leak in gpio_mpsse_probe()
error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23015

Introduced by commit c46a74f ("gpio: add support for FTDI's MPSSE as
GPIO") in v6.13-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e876e5a0875e71e34148c9feb2eedd3bf6b2b43]
stable/6.18: [7ea26e6dcabc270433b6ded2a1aee85b215d1b28]

CVE-2026-23016: inet: frags: drop fraglist conntrack references

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23016

Introduced by commit 6471658 ("udp: use skb_attempt_defer_free()") in v6.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ef02ac38d3c17f34a00c4b267d961a8d4b45d1a]
stable/6.18: [088ca99dbb039c444c3ff987c5412a73f4f0cbf8]

CVE-2026-23017: idpf: fix error handling in the init_task on load

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23017

Introduced by commit 0fe4546 ("idpf: add create vport and netdev
configuration") in v6.7-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d792219fe6f891b5b557a607ac8a0a14eda6e38]
stable/6.18: [a514c374edcd33581cdcccf8faa7cc606a600319]

CVE-2026-23018: btrfs: release path before initializing extent tree in
btrfs_read_locked_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23018

Introduced by commit 8679d26 ("btrfs: initialize
inode::file_extent_tree after i_mode has been set") in v6.17-rc7.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8731f2c50b0b1d2b58ed5b9671ef2c4bdc2f8347]
stable/6.18: [92a5590851144f034adc51fee55e6878ccac716e]

CVE-2026-23019: net: marvell: prestera: fix NULL dereference on
devlink_alloc() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23019

Introduced by commit 34dd171 ("net: marvell: prestera: Add basic
devlink support") in v5.10-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a428e0da1248c353557970848994f35fd3f005e2]
stable/5.15: [8a4333b2818f0d853b43e139936c20659366e4a0]
stable/6.1: [325aea74be7e192b5c947c782da23b0d19a5fda2]
stable/6.12: [3950054c9512add0cc79ab7e72b6d2f9f675e25b]
stable/6.18: [326a4b7e61d01db3507f71c8bb5e85362f607064]
stable/6.6: [94e070cd50790317fba7787ae6006934b7edcb6f]

CVE-2026-23020: net: 3com: 3c59x: fix possible null dereference in
vortex_probe1()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23020

Introduced by commit 55c8261 ("3c59x: convert to generic DMA API") in v4.17-rc7.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ffc45340a2221f4d4fecd66d3410f4881bd25583]
mainline: [a4e305ed60f7c41bbf9aabc16dd75267194e0de3]
stable/5.10: [053ac9e37eee435e999277c0f1ef890dad6064bf]
stable/5.15: [6cff14b831dbdb32675b4c7904dcc3eeeaf47e9d]
stable/6.1: [606872c8e8bf96066730f6a2317502c5633c37f1]
stable/6.12: [2f05f7737e16d9a40038cc1c38a96a3f7964898b]
stable/6.18: [d82796a57cc0dac1dbef19d913c8f02a8cc7b1a7]
stable/6.6: [28b2a805609699be7b90020ae7dccfb234be1ceb]

CVE-2026-23021: net: usb: pegasus: fix memory leak in update_eth_regs_async()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23021

Introduced by commit 323b349 ("drivers: net: usb: pegasus: fix control
urb submission") in v3.10-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5a482c962c332a7dc01b235de52f16ea961e3bd1]
cip/4.4-st: [d815f299130d384e15d62c5c57d4dc3b48185e8f]
mainline: [afa27621a28af317523e0836dad430bec551eb54]
stable/5.10: [5397ea6d21c35a17707e201a60761bdee00bcc4e]
stable/5.15: [a40af9a2904a1ab8ce61866ebe2a894ef30754ba]
stable/6.1: [ac5d92d2826dec51e5d4c6854865bc5817277452]
stable/6.12: [471dfb97599eec74e0476046b3ef8e7037f27b34]
stable/6.18: [ce6eef731aba23a988decea1df3b08cf978f7b01]
stable/6.6: [93f18eaa190374e0f2d253e3b1a65cee19a7abe6]

CVE-2026-23022: idpf: fix memory leak in idpf_vc_core_deinit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23022

Introduced by commit 6aa53e8 ("idpf: implement get LAN MMIO memory
regions") in v6.17-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e111cbc4adf9f9974eed040aeece7e17460f6bff]
stable/6.18: [23391db8a00c23854915b8b72ec1aa10080aa540]

CVE-2026-23023: idpf: fix memory leak in idpf_vport_rel()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23023

Introduced by commit 0fe4546 ("idpf: add create vport and netdev
configuration") in v6.7-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6242b354605faff263ca45882b148200915a3f6]
stable/6.12: [a4212d6732e3f674c6cc7d0b642f276d827e8f94]
stable/6.18: [ec602a2a4071eb956d656ba968c58fee09f0622d]

CVE-2026-23024: idpf: fix memory leak of flow steer list on rmmod

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23024

Introduced by commit ada3e24 ("idpf: add flow steering support") in v6.17-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9841bd28b600526ca4f6713b0ca49bf7bb98452]
stable/6.18: [1aedff70a5e97628eaaf17b169774cb6a45a1dc5]

CVE-2026-23025: mm/page_alloc: prevent pcp corruption with SMP=n

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23025

Introduced by commit 5749077 ("mm/page_alloc: leave IRQs enabled for
per-cpu page allocations") in v6.2-rc1.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [038a102535eb49e10e93eafac54352fcc5d78847]
stable/6.12: [df63d31e9ae02e2f6cd96147779e4ed7cd0e75f6]
stable/6.18: [3098f8f7c7b0686c74827aec42a2c45e69801ff8]
stable/6.6: [4a04ff9cd816e7346fcc8126f00ed80481f6569d]


CVE-2026-23026: dmaengine: qcom: gpi: Fix memory leak in gpi_peripheral_config()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23026

Introduced by commit 5d0c353 ("dmaengine: qcom: Add GPI dma driver")
in v5.11-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f747004bbd641131d9396d87b5d2d3d1e182728]
stable/6.12: [01b1d781394fc9b83015e3a3cd46b17bda842bd8]
stable/6.18: [55a67ba5ac4cebfd54cc8305d4d57a0f1dfe6a85]
stable/6.6: [6bf4ef078fd11910988889a6c0b3698d2e0c89af]

CVE-2026-23027: LoongArch: KVM: Fix kvm_device leak in kvm_pch_pic_destroy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23027

According to the .vulnerable file, this bug was introduced by commit
e785dfa in v6.13-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cf342a7c3adc5877837b53bbceb5cc9eff60bbf]
stable/6.18: [fc53a66227af08d868face4b33fa8b2e1ba187ed]

CVE-2026-23028: LoongArch: KVM: Fix kvm_device leak in kvm_ipi_destroy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23028

According to the .vulnerable file, this bug was introduced by commit
c532de5 in v6.13-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0bf58cb7288a4d3de6d8ecbb3a65928a9362bf21]
stable/6.18: [5defcc2f9c22e6e09b5be68234ad10f4ba0292b7]

CVE-2026-23029: LoongArch: KVM: Fix kvm_device leak in kvm_eiointc_destroy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23029

According to the .vulnerable file, this bug was introduced by commit
2e8b9df in v6.13-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d8553fc75aefa7ec936af0cf8443ff90b51732e]
stable/6.18: [e94ec9661c5820d157d2cc4b6cf4a6ab656a7b4d]

CVE-2026-23030: phy: rockchip: inno-usb2: Fix a double free bug in
rockchip_usb2phy_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23030

Introduced by commit ed2b5a8 ("phy: phy-rockchip-inno-usb2: support
muxed interrupts") in v5.17-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e07dea3de508cd6950c937cec42de7603190e1ca]
stable/6.12: [027d42b97e6eb827c3438ebc09bab7efaee9270d]
stable/6.18: [efe92ee7a111fe0f4d75f3ed6b7e3f86322279d5]
stable/6.6: [ebae26dd15140b840cf65be5e1c0daee949ba70b]


CVE-2026-23031: can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23031

Introduced by commit d08e973 ("can: gs_usb: Added support for the
GS_USB CAN devices") in v3.16-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7352e1d5932a0e777e39fa4b619801191f57e603]
stable/6.12: [08624b7206ddb9148eeffc2384ebda2c47b6d1e9]
stable/6.18: [9f669a38ca70839229b7ba0f851820850a2fe1f7]
stable/6.6: [f905bcfa971edb89e398c98957838d8c6381c0c7]


CVE-2026-23032: null_blk: fix kmemleak by releasing references to
fault configfs items

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23032

Introduced by commit bb4c19e ("block: null_blk: make fault-injection
dynamically configurable per device") in v6.4-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40b94ec7edbbb867c4e26a1a43d2b898f04b93c5]
stable/6.12: [d59ba448ccd595d5d65e197216cf781a87db2b28]
stable/6.18: [f1718da051282698aa8fa150bebb9724f6389fda]
stable/6.6: [1a3286edf4d48ce37f8982ff3c3b65159a5ecbb2]

CVE-2026-23033: dmaengine: omap-dma: fix dma_pool resource leak in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23033

Introduced by commit 7bedaa5 ("dmaengine: add OMAP DMA engine driver")
in v3.6-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e1136acf8a8887c29f52e35a77b537309af321f]
stable/6.12: [4b93712e96be17029bd22787f2e39feb0e73272c]
stable/6.18: [829b00481734dd54e72f755fd6584bce6fbffbb0]
stable/6.6: [88a9483f093bbb9263dcf21bc7fdb5132e5de88d]

CVE-2026-23034: drm/amdgpu/userq: Fix fence reference leak on queue teardown v2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23034

Introduced by commit edc762a ("drm/amdgpu/userq: move some code
around") in v6.16-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2426a211dba6432e32a2e70e9183c6e134475c6]
stable/6.18: [e1a30e1ab33fc522785d04bbf7e1b13a5c5c9175]

CVE-2026-23035: net/mlx5e: Pass netdev to mlx5e_destroy_netdev instead of priv

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23035

Introduced by commit c4d7eb5 ("net/mxl5e: Add change profile method")
in v5.12-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ef8512e1427111f7ba92b4a847d181ff0aeec42]
stable/6.12: [a7625bacaa8c8c2bfcde6dd6d1397bd63ad82b02]
stable/6.18: [66a25f6b7c0bfd84e6d27b536f5d24116dbd52da]

CVE-2026-23036: btrfs: release path before iget_failed() in
btrfs_read_locked_inode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23036

Introduced by commit 6967399 ("btrfs: push cleanup into
btrfs_read_locked_inode()") in v6.13-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e1f2055ad5a7a5d548789b334a4473a7665c418]
stable/6.18: [65241e3ddda60b53a4ee3ae12721fc9ee21d5827]

CVE-2026-23037: can: etas_es58x: allow partial RX URB allocation to succeed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23037

Introduced by commit 8537257 ("can: etas_es58x: add core support for
ETAS ES58X CAN USB interfaces") in v5.13-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1979778e98569c1e78c2c7f16bb24d76541ab00]
stable/6.12: [ba45e3d6b02c97dbb4578fbae7027fd66f3caa10]
stable/6.18: [6c5124a60989051799037834f0a1a4b428718157]
stable/6.6: [611e839d2d552416b498ed5593e10670f61fcd4d]

CVE-2026-23038: pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23038

Introduced by commit d67ae82 ("pnfs/flexfiles: Add the FlexFile Layout
Driver") in v4.0-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c728083654f0066f5e10a1d2b0bd0907af19a58]
stable/6.12: [86da7efd12295a7e2b4abde5e5984c821edd938f]
stable/6.18: [ed5d3f2f6885eb99f729e6ffd946e3aa058bd3eb]
stable/6.6: [869862056e100973e76ce9f5f1b01837771b7722]

CVE-2026-23039: drm/gud: fix NULL fb and crtc dereferences on USB disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23039

Introduced by commit 73cfd16 ("drm/gud: Replace simple display pipe
with DRM atomic helpers") in v6.18-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc2d5ddb193e363187bae2ad358245642d2721fb]
stable/6.18: [a255ec07f91d4c73a361a28b7a3d82f5710245f1]

CVE-2025-71192: ALSA: ac97: fix a double free in snd_ac97_controller_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71192

Introduced by commit 74426fb ("ALSA: ac97: add an ac97 bus") in v4.15-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [830988b6cf197e6dcffdfe2008c5738e6c6c3c0f]
stable/6.1: [c80f9b3349a99a9d5b295f5bbc23f544c5995ad7]
stable/6.12: [fcc04c92cbb5497ce67c58dd2f0001bb87f40396]
stable/6.6: [21f8bc5179bed91c3f946adb5e55d717b891960c]

CVE-2025-71193: phy: qcom-qusb2: Fix NULL pointer dereference on early suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71193

Introduced by commit 891a96f ("phy: qcom-qusb2: Add support for
runtime PM") in v4.17-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ca52c0983c34fca506921791202ed5bdafd5306]
stable/6.12: [d50a9b7fd07296a1ab81c49ceba14cae3d31df86]
stable/6.6: [beba460a299150b5d8dcbe3474a8f4bdf0205180]

CVE-2025-71194: btrfs: fix deadlock in wait_current_trans() due to
ignored transaction type

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71194

Introduced commit is not determined.Fixed in v6.19-rc5.


Fixed status
mainline: [5037b342825df7094a4906d1e2a9674baab50cb2]
stable/6.12: [8b0bb145d3bc264360f525c9717653be3522e528]
stable/6.6: [99da896614d17e8a84aeb2b2d464ac046cc8633d]

CVE-2025-71195: dmaengine: xilinx: xdma: Fix regmap max_register

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71195

Introduced by commit 17ce252 ("dmaengine: xilinx: xdma: Add xilinx
xdma driver") in v6.3-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7d436a6c1a274c1ac28d5fb3b8eb8f03b6d0e10]
stable/6.12: [606ea969e78295407f4bf06aa0e272fe59897184]
stable/6.6: [df8a131a41ff6202d47f59452735787f2b71dd2d]

CVE-2025-71196: phy: stm32-usphyc: Fix off by one in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71196

Introduced by commit 94c358d ("phy: stm32: add support for STM32 USB
PHY Controller (USBPHYC)") in v4.17-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cabd25b57216ddc132efbcc31f972baa03aad15a]
stable/6.12: [b91c9f6bfb04e430adeeac7e7ebc9d80f9d72bad]
stable/6.6: [76b870fdaad82171a24b8aacffe5e4d9e0d2ee2c]

CVE-2025-71197: w1: therm: Fix off-by-one buffer overflow in alarms_store

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71197

Introduced by commit e2c94d6 ("w1_therm: adding alarm sysfs entry") in v5.8-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [761fcf46a1bd797bd32d23f3ea0141ffd437668a]
stable/6.12: [6fd6d2a8e41b7f544a4d26cbd60bedf9c67893a0]
stable/6.6: [6a5820ecfa5a76c3d3e154802c8c15f391ef442e]

CVE-2025-71198: iio: imu: st_lsm6dsx: fix iio_chan_spec for sensors
without event detection

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71198

Introduced by commit b5969ab ("iio: imu: st_lsm6dsx: add motion
events") in v5.5-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c34e2e2d67b3bb8d5a6d09b0d6dac845cdd13fb3]
stable/6.12: [4d60ffcdedfe2cdb68a1cde19bb292bc67451629]
stable/6.6: [7673167fac9323110973a3300637adba7d45de3a]

CVE-2025-71199: iio: adc: at91-sama5d2_adc: Fix potential
use-after-free in sama5d2_adc driver

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71199

Introduced by commit 23ec277 ("iio: adc: at91-sama5d2_adc: add support
for position and pressure channels") in v4.19-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbdb442218cd9d613adeab31a88ac973f22c4873]
stable/6.12: [d7b6fc224c7f5d6d8adcb18037138d3cfe2bbdfe]
stable/6.6: [9795fe80976f8c31cafda7d44edfc0f532d1f7c4]

CVE-2026-23040: wifi: mac80211_hwsim: fix typo in frequency notification

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23040

Introduced by commit a37a6f5 ("wifi: mac80211_hwsim: Add simulation
support for NAN device") in v6.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [333418872bfecf4843f1ded7a4151685dfcf07d5]

CVE-2026-23041: bnxt_en: Fix NULL pointer crash in bnxt_ptp_enable
during error cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23041

Introduced by commit a60fc32 ("ptp: rework ptp_clock_unregister() to
disable events") in v6.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3358995b1a7f9dcb52a56ec8251570d71024dad0]

CVE-2026-23042: idpf: fix aux device unplugging when rdma is not
supported by vport

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23042

Introduced by commit be91128 ("idpf: implement RDMA vport auxiliary
dev create, init, and destroy") in v6.17-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4648fb2f2e7210c53b85220ee07d42d1e4bae3f9]

CVE-2026-23043: btrfs: fix NULL pointer dereference in do_abort_log_replay()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23043

Introduced by commit 2753e49 ("btrfs: dump detailed info and specific
messages on log replay failures") in v6.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [530e3d4af566ca44807d79359b90794dea24c4f3]

CVE-2026-23044: PM: hibernate: Fix crash when freeing invalid crypto compressor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23044

Introduced by commit b03d542 ("PM: hibernate: Use crypto_acomp
interface") in v6.15-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7966cf0ebe32c981bfa3db252cb5fc3bb1bf2e77]

CVE-2026-23045: net/ena: fix missing lock when update devlink params

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23045

Introduced by commit 816b526 ("net: ena: Control PHC enable through
devlink") in v6.17-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8da901ffe497a53fa4ecc3ceed0e6d771586f88e]

CVE-2026-23046: virtio_net: fix device mismatch in devm_kzalloc/devm_kfree

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23046

Introduced by commit 4944be2 ("virtio_net: Allocate rss_hdr with
devres") in v6.15-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acb4bc6e1ba34ae1a34a9334a1ce8474c909466e]

CVE-2026-23047: libceph: make calc_target() set t->paused, not just clear it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23047

Introduced commit is not determined.Fixed in v6.19-rc5.


Fixed status
cip/4.19-st: [66ab4da278f51618ecf9dd9854c7036806288102]
mainline: [c0fe2994f9a9d0a2ec9e42441ea5ba74b6a16176]
stable/5.10: [2b3329b3c29d9e188e40d902d5230c2d5989b940]
stable/5.15: [5d0dc83cb9a69c1d0bea58f1c430199b05f6b021]
stable/6.1: [4d3399c52e0e61720ae898f5a0b5b75d4460ae24]
stable/6.12: [6f468f6ff233c6a81e0e761d9124e982903fe9a5]
stable/6.6: [4ebc711b738d139cabe2fc9e7e7749847676a342]

CVE-2026-23048: udp: call skb_orphan() before skb_attempt_defer_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23048

Introduced by commit 6471658 ("udp: use skb_attempt_defer_free()") in v6.18-rc1.
Fixed in v6.19-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5c8eda39a9fc1547d1398d707aa06c1d080abdd]

CVE-2026-23049: drm/panel-simple: fix connector type for DataImage
SCF0700C48GGU18 panel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23049

Introduced by commit 97ceb1f ("drm/panel: simple: Add support for
DataImage SCF0700C48GGU18") in v4.19-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ab3d4353bf75005eaa375677c9fed31148154d6]
stable/6.12: [04218cd68d1502000823c8288f37b4f171dcdcae]
stable/6.6: [bc0b17bdba3838e9e17e7e9adc968384ac99938b]

CVE-2026-23050: pNFS: Fix a deadlock when returning a delegation during open()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23050

Introduced by commit 29ade5d ("pNFS: Wait on outstanding layoutreturns
to complete in pnfs_roc()") in v4.10-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [857bf9056291a16785ae3be1d291026b2437fc48]
stable/6.12: [a316fd9d3065b753b03d802530004aea481512cc]

CVE-2026-23051: drm/amdgpu: fix drm panic null pointer when driver not
support atomic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23051

Introduced by commit fe151ed ("drm/amdgpu: add generic display panic
helper code") in v6.14-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cb6278b44c38899961b36d303d7b18b38be2a6e]

CVE-2026-23052: ftrace: Do not over-allocate ftrace memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23052

Introduced by commit 4a3efc6 ("ftrace: Update the mcount_loc check of
skipped entries") in v6.15-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be55257fab181b93af38f8c4b1b3cb453a78d742]

CVE-2026-23053: NFS: Fix a deadlock involving nfs_release_folio()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23053

Introduced by commit 96780ca ("NFS: fix up nfs_release_folio() to try
to release the page") in v6.3-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cce0be6eb4971456b703aaeafd571650d314bcca]
stable/6.12: [49d352bc263fe4a834233338bfaad31b3109addf]

CVE-2026-23054: net: hv_netvsc: reject RSS hash key programming
without RX indirection table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23054

Introduced by commit 962f3fe ("netvsc: add ethtool ops to get/set RSS
key") in v4.11-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d23564955811da493f34412d7de60fa268c8cb50]
stable/6.12: [4cd55c609e85ae2313248ef1a33619a3eef44a16]
stable/6.6: [82c9039c8ebb715753a40434df714f865a3aec9c]

CVE-2026-23055: i2c: riic: Move suspend handling to NOIRQ phase

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23055

Introduced by commit 5332613 ("i2c: riic: Add suspend/resume support")
in v6.12-rc1.
Fixed in v6.19-rc6.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt

Fixed status
mainline: [e383f0961422f983451ac4dd6aed1a3d3311f2be]
stable/6.12: [469f8fe4c87e43520f279e45b927c35d6fe99194]

CVE-2026-23056: uacce: implement mremap in uacce_vm_ops to return -EPERM

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23056

Introduced by commit 015d239 ("uacce: add uacce driver") in v5.7-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02695347be532b628f22488300d40c4eba48b9b7]
stable/6.12: [a407ddd61b3e6afc5ccfcd1478797171cf5686ee]
stable/6.6: [4c042bc71474dbe417c268f4bfb8ec196f802f07]

CVE-2026-23057: vsock/virtio: Coalesce only linear skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23057

Introduced by commit 581512a ("vsock/virtio: MSG_ZEROCOPY flag
support") in v6.7-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0386bd321d0f95d041a7b3d7b07643411b044a96]
stable/6.12: [568e9cd8ed7ca9bf748c7687ba6501f29d30e59f]

CVE-2026-23058: can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23058

Introduced by commit 702171a ("ems_usb: Added support for EMS
CPC-USB/ARM7 CAN/USB interface") in v2.6.32-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ce73a0eb5a27070957b67fd74059b6da89cc516]
stable/6.12: [46a191ff7eeec33a2ccb2a1bfea34e18fbc5dc1a]
stable/6.6: [e9410fdd4d5f7eaa6526d8c80e83029d7c86a8e8]

CVE-2026-23059: scsi: qla2xxx: Sanitize payload size to prevent member overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23059

Introduced by commit 875386b ("scsi: qla2xxx: Add Unsolicited LS
Request and Response Support for NVMe") in v6.6-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19bc5f2a6962dfaa0e32d0e0bc2271993d85d414]
stable/6.12: [1922468a4a80424e5a69f7ba50adcee37f4722e9]
stable/6.6: [408bfa8d70f79ac696cec1bdbdfb3bf43a02e6d0]

CVE-2026-23060: crypto: authencesn - reject too-short AAD (assoclen<8)
to match ESP/ESN spec

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23060

Introduced by commit 104880a ("crypto: authencesn - Convert to new
AEAD interface") in v4.3-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2397e9264676be7794f8f7f1e9763d90bd3c7335]
stable/6.12: [161bdc90fce25bd9890adc67fa1c8563a7acbf40]
stable/6.6: [b0a9609283a5c852addb513dafa655c61eebc1ef]

CVE-2026-23061: can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix
URB memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23061

Introduced by commit 080f40a ("can: kvaser_usb: Add support for Kvaser
CAN/USB devices") in v3.8-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [248e8e1a125fa875158df521b30f2cc7e27eeeaa]
stable/6.12: [94a7fc42e21c7d9d1c49778cd1db52de5df52a01]
stable/6.6: [7c308f7530bffafa994e0aa8dc651a312f4b9ff4]

CVE-2026-23062: platform/x86: hp-bioscfg: Fix kernel panic in
GET_INSTANCE_ID macro

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23062

Introduced by commit 5f94f18 ("platform/x86: hp-bioscfg: bioscfg-h")
in v6.6-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25150715e0b049b99df664daf05dab12f41c3e13]
stable/6.12: [eba49c1dee9c5e514ca18e52c545bba524e8a045]
stable/6.6: [eb5ff1025c92117d5d1cc728bcfa294abe484da1]

CVE-2026-23063: uacce: ensure safe queue release with state management

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23063

Introduced by commit 015d239 ("uacce: add uacce driver") in v5.7-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26c08dabe5475d99a13f353d8dd70e518de45663]
stable/6.12: [47634d70073890c9c37e39ab4ff93d4b585b028a]
stable/6.6: [43f233eb6e7b9d88536881a9bc43726d0e34800d]

CVE-2026-23064: net/sched: act_ife: avoid possible NULL deref

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23064

Introduced by commit 295a6e0 ("net/sched: act_ife: Change to use ife
module") in v4.11-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27880b0b0d35ad1c98863d09788254e36f874968]
stable/6.12: [374915dfc932adf57712df3be010667fd1190e3c]
stable/6.6: [03710cebfc0bcfe247a9e04381e79ea33896e278]

CVE-2026-23065: platform/x86/amd: Fix memory leak in wbrf_record()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23065

Introduced by commit 58e82a6 ("platform/x86/amd: Add support for AMD
ACPI based Wifi band RFI mitigation feature") in v6.8-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bf1877b7094c684e1d652cac6912cfbc507ad3e]
stable/6.12: [1152dffe01af86e42ce2b208b92ef7f8c275d130]

CVE-2026-23066: rxrpc: Fix recvmsg() unconditional requeue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23066

Introduced by commit 540b1c4 ("rxrpc: Fix deadlock between call
creation and sendmsg/recvmsg") in v4.11-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c28769a51deb6022d7fbd499987e237a01dd63a]

CVE-2026-23067: iommu/io-pgtable-arm: fix size_t signedness bug in unmap path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23067

Introduced by commit 3318f7b ("iommu/io-pgtable-arm: Add quirk to
quiet WARN_ON()") in v6.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [374e7af67d9d9d6103c2cfc8eb32abfecf3a2fd8]

CVE-2026-23068: spi: spi-sprd-adi: Fix double free in probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23068

Introduced by commit ac17750 ("spi: sprd: Add the support of
restarting the system") in v4.17-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [383d4f5cffcc8df930d95b06518a9d25a6d74aac]
stable/6.12: [346775f2b4cf839177e8e86b94aa180a06dc15b0]
stable/6.6: [417cdfd9b9f986e95bfcb1d68eb443e6e0a15f8c]

CVE-2026-23069: vsock/virtio: fix potential underflow in
virtio_transport_get_credit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23069

Introduced by commit 06a8fc7 ("VSOCK: Introduce
virtio_vsock_common.ko") in v4.8-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ef3d52a1a9860d094395c7a3e593f3aa26ff012]
stable/6.12: [d05bc313788f0684b27f0f5b60c52a844669b542]
stable/6.6: [02f9af192b98d15883c70dd41ac76d1b0217c899]

CVE-2026-23070: Octeontx2-af: Add proper checks for fwdata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23070

Introduced by commit 9978144 ("Octeontx2-af: Fetch MAC channel info
from firmware") in v6.9-rc1.
Introduced by commit 5f21226 ("Octeontx2-pf: ethtool: support multi
advertise mode") in v6.17-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a3dba48188208e4f66822800e042686784d29d1]

CVE-2026-23071: regmap: Fix race condition in hwspinlock irqsave routine

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23071

Introduced by commit 8698b93 ("regmap: Add hardware spinlock support")
in v4.15-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b58aac989c1e3fafb1c68a733811859df388250]
stable/6.12: [4aab0ca0a0f7760e33edcb4e47576064d05128f5]
stable/6.6: [24f31be6ad70537fd7706269d99c92cade465a09]

CVE-2026-23072: l2tp: Fix memleak in l2tp_udp_encap_recv().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23072

Introduced by commit 3647980 ("l2tp: Support different protocol
versions with same IP/port quadruple") in v6.10-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d10edfd1475b69dbd4c47f34b61a3772ece83ca]
stable/6.12: [5cd158a88eef34e7b100cd9b963873d3b4e41b35]

CVE-2026-23073: wifi: rsi: Fix memory corruption due to not set vif
driver data size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23073

Introduced by commit dad0d04 ("rsi: Add RS9113 wireless driver") in v3.15-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f431d88ea8093afc7ba55edf4652978c5a68f33]
stable/6.12: [99129d80a5d4989ef8566f434f3589f60f28042b]
stable/6.6: [7761d7801f40e61069b4df3db88b36d80d089f8a]

CVE-2026-23074: net/sched: Enforce that teql can only be used as root qdisc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23074

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50da4b9d07a7a463e2cfb738f3ad4cff6b2c9c3b]
stable/6.12: [4c7e8aa71c9232cba84c289b4b56cba80b280841]
stable/6.6: [0686bedfed34155520f3f735cbf3210cb9044380]

CVE-2026-23075: can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23075

Introduced by commit 96d8e90 ("can: Add driver for esd CAN-USB/2
device") in v2.6.36-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a4391bdc6c8357242f62f22069c865b792406b3]
stable/6.12: [9d1807b442fc3286b204f8e59981b10e743533ce]
stable/6.6: [adec5e1f9c99fe079ec4c92cca3f1109a3e257c3]

CVE-2026-23076: ALSA: ctxfi: Fix potential OOB access in audio mixer handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23076

Introduced commit is not determined.Fixed in v6.19-rc7.


Fixed status
mainline: [61006c540cbdedea83b05577dc7fb7fa18fe1276]
stable/6.12: [d77ba72558cd66704f0fb7e0969f697e87c0f71c]
stable/6.6: [a8c42d11b0526a89192bd2f79facb4c60c8a1f38]

CVE-2026-23077: mm/vma: fix anon_vma UAF on mremap() faulted, unfaulted merge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23077

Introduced by commit 879bca0 ("mm/vma: fix incorrectly disallowed
anonymous VMA merges") in v6.16-rc1.
Fixed in v6.19-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61f67c230a5e7c741c352349ea80147fbe65bfae]

CVE-2026-23078: ALSA: scarlett2: Fix buffer overflow in config retrieval

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23078

Introduced by commit ac34df7 ("ALSA: usb-audio: scarlett2: Update
get_config to do endian conversion") in v5.14-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f5c69f72e50d51be3a8c028ae7eda42c82902cb]
stable/6.12: [27049f50be9f5ae3a62d272128ce0b381cb26a24]
stable/6.6: [91a756d22f0482eac5bedb113c8922f90b254449]

CVE-2026-23079: gpio: cdev: Fix resource leaks on errors in
lineinfo_changed_notify()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23079

Introduced by commit d4cd090 ("gpio: cdev: make sure the cdev fd is
still active before emitting events") in v6.18-rc7.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70b3c280533167749a8f740acaa8ef720f78f984]

CVE-2026-23080: can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB
memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23080

Introduced by commit 51f3baa ("can: mcba_usb: Add support for
Microchip CAN BUS Analyzer") in v4.12-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [710a7529fb13c5a470258ff5508ed3c498d54729]
stable/6.12: [94c9f6f7b953f6382fef4bdc48c046b861b8868f]
stable/6.6: [179f6f0cf5ae489743273b7c1644324c0c477ea9]

CVE-2026-23081: net: phy: intel-xway: fix OF node refcount leakage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23081

Introduced by commit 1758af4 ("net: phy: intel-xway: add support for
PHY LEDs") in v6.13-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79912b256e14054e6ba177d7e7e631485ce23dbe]

CVE-2026-23082: can: gs_usb: gs_usb_receive_bulk_callback(): unanchor
URL on usb_submit_urb() error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23082

Introduced by commit 7352e1d ("can: gs_usb:
gs_usb_receive_bulk_callback(): fix URB memory leak") in v6.19-rc6.
Fixed in v6.19-rc7.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [79a6d1bfe1148bc921b8d7f3371a7fbce44e30f7]
stable/6.12: [c610b550ccc0438d456dfe1df9f4f36254ccaae3]
stable/6.6: [ce4352057fc5a986c76ece90801b9755e7c6e56c]

CVE-2026-23083: fou: Don't allow 0 for FOU_ATTR_IPPROTO.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23083

Introduced by commit 2346155 ("fou: Support for foo-over-udp RX path")
in v3.18-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a9bc9e3f42391e4c187e099263cf7a1c4b69ff5]
stable/6.12: [b7db31a52c3862a1a32202a273a4c32e7f5f4823]
stable/6.6: [1cc98b8887cabb1808d2f4a37cd10a7be7574771]

CVE-2026-23084: be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23084

Introduced by commit 95046b9 ("be2net: refactor MAC-addr setup code")
in v3.12-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8215794403d264739cc676668087512950b2ff31]
stable/6.12: [47ffb4dcffe336f4a7bd0f3284be7aadc6484698]
stable/6.6: [e206fb415db36bad52bb90c08d46ce71ffbe8a80]

CVE-2026-23085: irqchip/gic-v3-its: Avoid truncating memory addresses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23085

Introduced by commit cc2d321 ("irqchip: GICv3: ITS command queue") in v3.19-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d76a7d89c12d08382b66e2f21f20d0627d14859]
stable/6.12: [084ba3b99f2dfd991ce7e84fb17117319ec3cd9f]
stable/6.6: [1b323391560354d8c515de8658b057a1daa82adb]

CVE-2026-23086: vsock/virtio: cap TX credit to local buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23086

Introduced by commit 06a8fc7 ("VSOCK: Introduce
virtio_vsock_common.ko") in v4.8-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ee784fdf006cbe8739cfa093f54d326cbf54037]
stable/6.12: [c0e42fb0e054c2b2ec4ee80f48ccd256ae0227ce]
stable/6.6: [d9d5f222558b42f6277eafaaa6080966faf37676]

CVE-2026-23087: scsi: xen: scsiback: Fix potential memory leak in
scsiback_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23087

Introduced by commit d9d660f ("xen-scsiback: Add Xen PV SCSI backend
driver") in v3.18-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [901a5f309daba412e2a30364d7ec1492fa11c32c]
stable/6.12: [32e52b56056daf0f0881fd9254706acf25b4be97]
stable/6.6: [f86264ec0e2b102fcd49bf3e4f32fee669d482fc]

CVE-2026-23088: tracing: Fix crash on synthetic stacktrace field usage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23088

Introduced by commit 00cf3d6 ("tracing: Allow synthetic events to pass
around stacktraces") in v6.3-rc1.
Fixed in v6.19-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [90f9f5d64cae4e72defd96a2a22760173cb3c9ec]
stable/6.12: [327af07dff6ab5650b21491eb4f69694999ff3d1]
stable/6.6: [98ecbfb2598c9c7ca755a29f402da9d36c057077]

CVE-2026-23089: ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23089

Introduced by commit 6639b6c ("[ALSA] usb-audio - add mixer control
notifications") in v2.6.13-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [930e69757b74c3ae083b0c3c7419bfe7f0edc7b2]
stable/6.12: [e6f103a22b08daf5df2f4aa158081840e5910963]
stable/6.6: [7bff0156d13f0ad9436e5178b979b063d59f572a]

CVE-2026-23090: slimbus: core: fix device reference leak on report present

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23090

Introduced by commit 46a2bb5 ("slimbus: core: Add slim controllers
support") in v4.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9391380eb91ea5ac792aae9273535c8da5b9aa01]
stable/6.12: [54de72a7aabc0749938d7a2833a0c1a5d3ed7ac9]
stable/6.6: [2ddc09f6a0a221b1d91a7cbc8cc2cefdbd334fe6]

CVE-2026-23091: intel_th: fix device leak on output open()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23091

Introduced by commit 39f4034 ("intel_th: Add driver infrastructure for
Intel(R) Trace Hub devices") in v4.4-rc1.
Introduced by commit 6d5925b ("intel_th: Fix error handling in
intel_th_output_open") in v6.19-rc1.
Fixed in v6.19-rc7.

Bug introduced commit was backported to following branches.
cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [95fc36a234da24bbc5f476f8104a5a15f99ed3e3]
stable/6.12: [0fca16c5591534cc1fec8b6181277ee3a3d0f26c]
stable/6.6: [bf7785434b5d05d940d936b78925080950bd54dd]

CVE-2026-23092: iio: dac: ad3552r-hs: fix out-of-bound write in
ad3552r_hs_write_data_source

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23092

Introduced by commit b1c5d68 ("iio: dac: ad3552r-hs: add support for
internal ramp") in v6.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [978d28136c53df38f8f0b747191930e2f95e9084]

CVE-2026-23093: ksmbd: smbd: fix dma_unmap_sg() nents

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23093

Introduced by commit 0626e66 ("cifsd: add server handler for central
processing and tranport layers") in v5.15-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98e3e2b561bc88f4dd218d1c05890672874692f6]

CVE-2026-23094: uacce: fix isolate sysfs check condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23094

Introduced by commit e3e289f ("uacce: supports device isolation
feature") in v6.3-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98eec349259b1fd876f350b1c600403bcef8f85d]
stable/6.12: [fdbbb47d15ae17bf39fafec7e2028c1f8efba15e]
stable/6.6: [9ab05cdcac354b1b1139918f49c6418b9005d042]

CVE-2026-23095: gue: Fix skb memleak with inner IP protocol 0.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23095

Introduced by commit 37dd024 ("gue: Receive side for Generic UDP
Encapsulation") in v3.18-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a56796ad258786d3624eef5aefba394fc9bdded]
stable/6.12: [ce569b389a5c78d64788a5ea94560e17fa574b35]
stable/6.6: [f87b9b7a618c82e7465e872eb10e14c803871892]

CVE-2026-23096: uacce: fix cdev handling in the cleanup path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23096

Introduced by commit 015d239 ("uacce: add uacce driver") in v5.7-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3bece3678f6c88db1f44c602b2a63e84b4040ac]
stable/6.12: [98d67a1bd6caddd0a8b8c82a0b925742cf500936]
stable/6.6: [d9031575a2f8aabc53af3025dd79af313a2e046b]

CVE-2026-23097: migrate: correct lock ordering for hugetlb file folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23097

Introduced by commit 336bf30 ("hugetlbfs: fix anon huge page migration
race") in v5.10-rc4.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7880cb166ab62c2409046b2347261abf701530e]
stable/6.12: [b75070823b89009f5123fd0e05a8e0c3d39937c1]
stable/6.6: [526394af4e8ade89cacd1a9ce2b97712712fcc34]

CVE-2026-23098: netrom: fix double-free in nr_route_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23098

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba1096c315283ee3292765f6aea4cca15816c4f7]
stable/6.12: [94d1a8bd08af1f4cc345c5c29f5db1ea72b8bb8c]
stable/6.6: [bd8955337e3764f912f49b360e176d8aaecf7016]

CVE-2026-23099: bonding: limit BOND_MODE_8023AD to Ethernet devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23099

Introduced by commit 872254d ("net/bonding: Enable bonding to enslave
non ARPHRD_ETHER") in v2.6.24-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c84fcb79e5dbde0b8d5aeeaf04282d2149aebcf6]
stable/6.12: [ef68afb1bee8d35a18896c27d7358079353d8d8a]
stable/6.6: [80c881e53a4fa0a80fa4bef7bc0ead0e8e88940d]

CVE-2026-23100: mm/hugetlb: fix hugetlb_pmd_shared()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23100

Introduced by commit 59d9094 ("mm: hugetlb: independent PMD page table
shared count") in v6.13-rc6.
Fixed in v6.19-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [ca1a47cd3f5f4c46ca188b1c9a27af87d1ab2216]

CVE-2026-23101: leds: led-class: Only Add LED to leds_list when it is
fully ready

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23101

Introduced by commit d23a22a ("leds: delay led_set_brightness if
stopping soft-blink") in v3.7-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1883cefd31752f0504b94c3bcfa1f6d511d6e87]
stable/6.12: [da565bf98c9ad0eabcb09fc97859e0b52f98b7c3]
stable/6.6: [2757f7748ce2d0fa44112024907bafb37e104d6e]

CVE-2026-23102: arm64/fpsimd: signal: Fix restoration of SVE context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23102

Introduced by commit 85ed24d ("arm64/sme: Implement streaming SVE
signal handling") in v5.19-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2907cbe9ea0a54cbe078076f9d089240ee1e2d9]

CVE-2026-23103: ipvlan: Make the addrs_lock be per port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23103

Introduced by commit 8230819 ("ipvlan: use per device spinlock to
protect addrs list updates") in v4.17-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3ba32162488283c0a4c5bedd8817aec91748802]
stable/6.12: [1f300c10d92c547c3a7d978e1212ff52f18256ed]
stable/6.6: [04ba6de6eff61238e5397c14ac26a6578c7735a5]

CVE-2026-23104: ice: fix devlink reload call trace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23104

Introduced by commit 4da71a7 ("ice: read internal temperature sensor")
in v6.8-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3f867e7a04678640ebcbfb81893c59f4af48586]

CVE-2026-23105: net/sched: qfq: Use cl_is_active to determine whether
class is active in qfq_rm_from_ag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23105

Introduced by commit 462dbc9 ("pkt_sched: QFQ Plus: fair-queueing
service at DRR cost") in v3.8-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d837fbee92453fbb829f950c8e7cf76207d73f33]
stable/6.12: [abd9fc26ea577561a5ef6241a1b058755ffdad0c]
stable/6.6: [93b8635974fb050c43d07e35e5edfe6e685ca28a]

CVE-2026-23106: timekeeping: Adjust the leap state for the correct
auxiliary timekeeper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23106

Introduced by commit 775f71e ("timekeeping: Make do_adjtimex()
reusable") in v6.17-rc1.
Introduced by commit ecf3e70 ("timekeeping: Provide adjtimex() for
auxiliary clocks") in v6.17-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e806f7dde8ba28bc72a7a0898589cac79f6362ac]

CVE-2026-23107: arm64/fpsimd: signal: Allocate SSVE storage when restoring ZA

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23107

Introduced by commit 3978221 ("arm64/sme: Implement ZA signal
handling") in v5.19-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea8ccfddbce0bee6310da4f3fc560ad520f5e6b4]
stable/6.12: [0af233d66eff90fb8f3e0fc09f2316bba0b72bb9]
stable/6.6: [19b2c3f3ca1b4b6dccd2a42aca2692d8c79c4214]

CVE-2026-23108: can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB
memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23108

Introduced by commit 0024d8a ("can: usb_8dev: Add support for USB2CAN
interface from 8 devices") in v3.9-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7a980b3b8f80fe367f679da376cf76e800f9480]
stable/6.12: [ea4a98e924164586066b39f29bfcc7cc9da108cd]
stable/6.6: [59ff56992bba28051ad67cd8cc7b0edfe7280796]

CVE-2026-23109: fs/writeback: skip AS_NO_DATA_INTEGRITY mappings in
wait_sb_inodes()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23109

Introduced by commit 0c58a97 ("fuse: remove tmp folio for writebacks
and internal rb tree") in v6.16-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9a49aa302a05e91ca01f69031cb79a0ea33031f]

CVE-2026-23110: scsi: core: Wake up the error handler when final
completions race against each other

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23110

Introduced by commit 6eb045e ("scsi: core: avoid host-wide host_busy
counter for scsi_mq") in v5.5-rc1.
Fixed in v6.19-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe2f8ad6f0999db3b318359a01ee0108c703a8c3]
stable/6.12: [64ae21b9c4f0c7e60cf47a53fa7ab68852079ef0]
stable/6.6: [9fdc6f28d5e81350ab1d2cac8389062bd09e61e1]


* Updated CVEs

CVE-2024-26655: Fix memory leak in posix_clock_open()

stable/6.6 was fixed.

Fixed status
stable/6.6: [ea2d9bfd422e92fd197f6a0b1fe7d81413b871e0]

CVE-2024-58097: wifi: ath11k: fix RCU stall while reaping monitor
destination ring

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9f1a002f0171d27f3554e529f3c70df438f05dfe]
stable/6.6: [8db5de0cf02fccf4c759aa58edbe65659daf607c]

CVE-2025-37926: ksmbd: fix use-after-free in ksmbd_session_rpc_open

stable/6.6 was fixed.

Fixed status
stable/6.6: [1067361a1cc6ad9cdf7acfc47f90012b72ad1502]

CVE-2025-37945: net: phy: allow MDIO bus PM ops to start/stop state
machine for phylink-controlled PHY

stable/6.6 was fixed.

Fixed status
stable/6.6: [043aa41c43f8cb9cce75367ea07895ce68b5abb0]

CVE-2025-38011: drm/amdgpu: csa unmap use uninterruptible lock

stable/6.6 was fixed.

Fixed status
stable/6.6: [8d2979b9bb1be0f4a52dff600e56d780403e04ac]

CVE-2025-38232: NFSD: fix race between nfsd registration and exports_proc

stable/6.6 was fixed.

Fixed status
stable/6.6: [8120e420013d947c890f358f30a2d98ba8ac20bc]

CVE-2025-38248: bridge: mcast: Fix use-after-free during router port
configuration

stable/6.6 was fixed.

Fixed status
stable/6.6: [4d3c2a1d4c7c33103f1ddfdbc5cfe1ea4f6d0dcd]

CVE-2025-38361: drm/amd/display: Check dce_hwseq before dereferencing it

stable/6.6 was fixed.

Fixed status
stable/6.6: [60e450eec5d63113c6ad5c456ce64c12b4496a6e]

CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible
code warnings

stable/6.6 was fixed.

Fixed status
stable/6.6: [17fbad93879e87a334062882b45fa727ba1b3dd7]

CVE-2025-68333: sched_ext: Fix possible deadlock in the deferred_irq_workfn()

stable/6.12 was fixed.

Fixed status
stable/6.12: [541959b2fadb832a7d0ceb95041dc52bdcf6bff7]

CVE-2025-68351: exfat: fix refcount leak in exfat_find

stable/6.12 was fixed.

Fixed status
stable/6.12: [fc9ce762525e73438d31b613f18bca92a4d3d578]

CVE-2025-68358: btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

stable/6.12 was fixed.

Fixed status
stable/6.12: [db4ae18e1b31e0421fb5312e56aefa382bbc6ece]

CVE-2025-68365: fs/ntfs3: Initialize allocated memory before use

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f7728057220cabd720e27e46097edad48e5bd728]
stable/6.6: [7d52c592cf53f5bb7163967edc01d2d7d80de44a]

CVE-2025-68725: bpf: Do not let BPF test infra emit invalid GSO types to stack

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0f3a60869ca22024dfb9c6fce412b0c70cb4ea36]
stable/6.6: [8670b53b8ee91f028f7240531064020b7413c461]

CVE-2025-68749: accel/ivpu: Fix race condition when unbinding BOs

stable/6.12 was fixed.

Fixed status
stable/6.12: [0328bb097bef05a796217c54b3d651cc3782827c]

CVE-2025-71162: dmaengine: tegra-adma: Fix use-after-free

stable/6.6 was fixed.

Fixed status
stable/6.6: [59cb421b0902fbef2b9512ae8ba198a20f26b41f]

CVE-2025-71163: dmaengine: idxd: fix device leaks on compat bind and unbind

stable/6.6 was fixed.

Fixed status
stable/6.6: [c81ea0222eaaafdd77348e27d1e84a1b8cfc0c99]

CVE-2026-22997: net: can: j1939: j1939_xtp_rx_rts_session_active():
deactivate session upon receiving the second rts

stable/6.6 was fixed.

Fixed status
stable/6.6: [809a437e27a3bf3c1c6c8c157773635552116f2b]

CVE-2026-22998: nvme-tcp: fix NULL pointer dereferences in
nvmet_tcp_build_pdu_iovec

stable/6.6 was fixed.

Fixed status
stable/6.6: [fdecd3b6aac10d5a18d0dc500fe57f8648b66cd4]

CVE-2026-22999: net/sched: sch_qfq: do not free existing class in
qfq_change_class()

stable/6.6 was fixed.

Fixed status
stable/6.6: [0a234660dc70ce45d771cbc76b20d925b73ec160]

CVE-2026-23001: macvlan: fix possible UAF in macvlan_forward_source()

stable/6.6 was fixed.

Fixed status
stable/6.6: [15f6faf36e162532bec5cc05eb3fc622108bf2ed]

CVE-2026-23003: ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()

stable/6.6 was fixed.

Fixed status
stable/6.6: [2f03dafea0a8096a2eb60f551218b360e5bab9a3]

CVE-2026-23005: x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state
whenever XFD[i]=1

stable/6.6 was fixed.

Fixed status
stable/6.6: [1e2848bda819af569dfe7ab186223855e092a2cb]

CVE-2026-23006: ASoC: tlv320adcx140: fix null pointer

stable/6.6 was fixed.

Fixed status
stable/6.6: [659939d08e5f7bc17b941c53e8c9c0a6c6113b21]

CVE-2026-23010: ipv6: Fix use-after-free in inet6_addr_del().

stable/6.6 was fixed.

Fixed status
stable/6.6: [9356b69d03d0f50cce91cebdabd33dda023fbd64]

CVE-2026-23011: ipv4: ip_gre: make ipgre_header() robust

stable/6.6 was fixed.

Fixed status
stable/6.6: [06fe0801396a36cab865b34f666de1d65bc5ce8e]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

