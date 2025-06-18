Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 691BEC71157
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 22:43:50 +0000 (UTC)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
 by mx.groups.io with SMTP id smtpd.web10.1642.1750286623267293422
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Jun 2025 15:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=KbX1sMQI;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.177, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e7311e66a8eso236587276.2
        for <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1750286622; x=1750891422; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VYq8dEn3PHD3bqZpVqeG7lplBB+IECSkm5a2bKhYdv8=;
        b=KbX1sMQIZGUPiMUiSCOymTsX4UtSDnua5cpVAJyzn1U4DeVjUFU77llmJmX3fenM+z
         3ZW4VQMs1E4Y9Ols3y377bZ4mF3wQrJTihn/2j3+AMdYrOyjCuLNZlZowA6qGer4/JVJ
         FwRdd+SdWtEZkG3aa2O4sXFYQji5cqEAZkor8o0c1L27W6wJOCj744LGCvaFS93I30g4
         ZOGX1kSSuQCZW9usZKpVF/LOxK+TCHNoCkXP4ysZe4o/YoyRBP10uFZ9BY8Ju5VdN89V
         HLaUC/ba6dX7wiW4PVD4dGNiQGK9zbL7hlvG+x1bVqviEHdkjKt2sPCUhhUhXiXkFd69
         O6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750286622; x=1750891422;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VYq8dEn3PHD3bqZpVqeG7lplBB+IECSkm5a2bKhYdv8=;
        b=Uk4jHW7nWNYkLPafgT5c4DFw86Bz5iCGQcvBcXa1JGx1E98gMqg6L6gNUV+/3Mx0dK
         x5Mwc5tNN0dnktluyBodXNFY0mc00TdsGtYfW4y8VGgKOMyENmGIY6j76TQAq+9ur+5i
         rVXjw2bpjbXtWHbVbJHXLg7XGAMmThAZrHqOKD7OncgGlNHHJN11F6DTxQBteirOn/WK
         lip+FwnUH3V6mI/UFVwABw9GmwSiMJErezBEJ4CK63uhfS8XzgBAMNt6UmdE0glc6nPI
         5baTPs6Nt820DPaCRoRgNpFc+UlHCu6WksAHYTrLJJZ+Csnmvf1qaeEvMBR6pWGCcYGf
         72eQ==
X-Gm-Message-State: AOJu0YwtdE8OyGXakwoV8moCqje7all7vkCIM5et4J73xyuTa3XEWe8M
	zTgjtrBfH1JnYAiJHyJ+0GbfMXKArYlpIRA8D+5QpvX2ETcOU6nf19649EwxtYWKs90TKNW9SIx
	0SzFEBPvHFyGxgr5et7GH17hfjrWidlDub5u+pcEkrPnIMxl25tzDZFk=
X-Gm-Gg: ASbGnctUKydvolJiYmKm9t0dByigk8QykgC4XC8dy56i6reTCvbZnopD/tNB87ani9R
	xXt/zG5sSawt2LgLMVhjpmxmarvN/Y4UNUgLVogr4aZtExgO4FmoY7xHUIA1mblnkN1HuewP+my
	E/dzuPrHmTSR7IrQpzVSYpV+5ePtBPTRiW0XF0baB4BgHYHZGfyDknaR0=
X-Google-Smtp-Source: AGHT+IHMIO2/PANNv3Oeh94BqwFRo7J9sC2Clum7d41UdpWPytMV0vyc5gbsrd+Npe2oXp45OREOy552CjwFV534q1w=
X-Received: by 2002:a05:690c:7083:b0:6fb:9280:5bf4 with SMTP id
 00721157ae682-7117544d5cfmr277358377b3.30.1750286620265; Wed, 18 Jun 2025
 15:43:40 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Jun 2025 07:43:04 +0900
X-Gm-Features: Ac12FXzp7rGMcGvliuejBjSVsEMpcGguKAr6qUozlUdoHwoaFj_TFXhwaxn8jxM
Message-ID: <CAODzB9qaw6_NEiTdk-a2kAj09COTdQDacccBcy+Uxg9YitEtNA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 22:43:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19136

Hi!

It's this week's CVE report.

This week reported 375 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2022-49934: wifi: mac80211: Fix UAF in ieee80211_scan_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49934

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
cip/4.19-st: [78a07732fbb0934d14827d8f09b9aa6a49ee1aa9]
cip/4.4-st: [26a9c4fc048433ce50263c01f1d808037edafd55]
mainline: [60deb9f10eec5c6a20252ed36238b55d8b614a2c]
stable/4.19: [78a07732fbb0934d14827d8f09b9aa6a49ee1aa9]
stable/5.10: [4abc8c07a065ecf771827bde3c63fbbe4aa0c08b]
stable/5.15: [5d20c6f932f2758078d0454729129c894fe353e7]
stable/5.4: [9ad48cbf8b07f10c1e4a7a262b32a9179ae9dd2d]

CVE-2022-49935: dma-buf/dma-resv: check if the new fence is really later

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49935

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
mainline: [a3f7c10a269d5b77dd5822ade822643ced3057f0]

CVE-2022-49936: USB: core: Prevent nested device-reset calls

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49936

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
cip/4.19-st: [cc9a12e12808af178c600cc485338bac2e37d2a8]
cip/4.4-st: [277f1c0cb0bf54e2f35f2fbefaf7859a7d74b8a5]
mainline: [9c6d778800b921bde3bff3cff5003d1650f942d1]
stable/4.19: [cc9a12e12808af178c600cc485338bac2e37d2a8]
stable/5.10: [abe3cfb7a7c8e907b312c7dbd7bf4d142b745aa8]
stable/5.15: [c548b99e1c37db6f7df86ecfe9a1f895d6c5966e]
stable/5.4: [df1875084898b15cbc42f712e93d7f113ae6271b]

CVE-2022-49937: media: mceusb: Use new usb_control_msg_*() routines

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49937

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
mainline: [608e58a0f4617977178131f5f68a3fce1d3f5316]
stable/5.10: [587f793c64d99d92be8ef01c4c69d885a3f2edb6]
stable/5.15: [75913c562f5ba4cf397d835c63f443879167c6f6]

CVE-2022-49938: cifs: fix small mempool leak in SMB2_negotiate()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49938

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
mainline: [27893dfc1285f80f80f46b3b8c95f5d15d2e66d0]
stable/5.15: [9e3c9efa7caf16e5acc05eab5e4d0a714e1610b0]

CVE-2022-49939: binder: fix UAF of ref->proc caused by race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49939

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
cip/4.19-st: [06e5b43ca4dab06a92bf4c2f33766e6fb11b880a]
mainline: [a0e44c64b6061dda7e00b7c458e4523e2331b739]
stable/4.19: [06e5b43ca4dab06a92bf4c2f33766e6fb11b880a]
stable/5.10: [9629f2dfdb1dad294b468038ff8e161e94d0b609]
stable/5.15: [c2a4b5dc8fa71af73bab704d0cac42ac39767ed6]
stable/5.4: [30d0901b307f27d36b2655fb3048cf31ee0e89c0]

CVE-2022-49940: tty: n_gsm: add sanity check for gsm->receive in
gsm_receive_buf()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49940

Introduced by 01aecd9 ("tty: n_gsm: fix tty registration before
control channel open")
in 6.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [f16c6d2e58a4c2b972efcf9eb12390ee0ba3befb]
stable/5.10: [5a82cf64f8ad63caf6bf115642ce44ddbc64311e]
stable/5.15: [5a82cf64f8ad63caf6bf115642ce44ddbc64311e]

CVE-2022-49941: [REJECTED]: tty: n_gsm: avoid call of sleeping
functions from atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49941

This CVE was rejected. Introduced by commit 32dd59f ("tty: n_gsm: fix
race condition in gsmld_write()")
in 6.0r-c1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [902e02ea9385373ce4b142576eef41c642703955]
stable/5.10: [eb75efdec8dd0f01ac85c88feafa6e63b34a2521]

CVE-2022-49942: wifi: mac80211: Don't finalize CSA in IBSS mode if
state is disconnected

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49942

Introduced by commit cd7760e ("mac80211: add support for CSA in IBSS
mode") in v3.13-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d9eb37db6a28b59a95a3461450ee209654c5f95b]
cip/4.4-st: [701a31abfa2b90bd2cf68522ec9a8b8bc55974fb]
mainline: [15bc8966b6d3a5b9bfe4c9facfa02f2b69b1e5f0]
stable/4.19: [d9eb37db6a28b59a95a3461450ee209654c5f95b]
stable/5.10: [dd649b49219a0388cc10fc40e4c2ea681566a780]
stable/5.15: [552ba102a6898630a7d16887f29e606d6fabe508]
stable/5.4: [66689c5c02acd4d76c28498fe220998610aec61e]

CVE-2022-49943: USB: gadget: Fix obscure lockdep violation for udc_mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49943

Introduced by commit 2191c00 ("USB: gadget: Fix use-after-free Read in
usb_udc_uevent()")
in 6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1016fc0c096c92dd0e6e0541daac7a7868169903]

CVE-2022-49944: Revert "usb: typec: ucsi: add a common function
ucsi_unregister_connectors()"

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49944

Introduced by commit 87d0e2f ("usb: typec: ucsi: add a common function
ucsi_unregister_connectors()") in v5.19-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f73aa2cf8bef4a39baa1591c3144ede4788826e]

CVE-2022-49945: hwmon: (gpio-fan) Fix array out of bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49945

Introduced by commit b5cf88e ("(gpio-fan): Add thermal control hooks")
in v4.1-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c8ae6a18708f260ccdeef6ba53af7548457dc26c]
cip/4.4-st: [e2c311d76850c8f685f1bc17a2eec1005695160b]
mainline: [f233d2be38dbbb22299192292983037f01ab363c]
stable/4.19: [c8ae6a18708f260ccdeef6ba53af7548457dc26c]
stable/5.10: [517dba798793e69b510779c3cde7224a65f3ed1d]
stable/5.15: [53196e0376205ed49b75bfd0475af5e0fbd20156]
stable/5.4: [7756eb1ed124753f4d64f761fc3d84290dffcb4d]

CVE-2022-49946: clk: bcm: rpi: Prevent out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49946

Introduced by commit 93d2725 ("clk: bcm: rpi: Discover the firmware
clocks") in v5.9-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc163555603e4ae9c817675ad80d618a4cdbfa2d]
stable/5.10: [fcae47b2d23c81603b01f56cf8db63ed64599d34]
stable/5.15: [ff0b144d4b0a9fbd6efe4d2c0a4b6c9bae2138d2]

CVE-2022-49947: binder: fix alloc->vma_vm_mm null-ptr dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49947

Introduced by 44e602b ("binder_alloc: add missing mmap_lock calls when
using the VMA") in 6.0-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [1da52815d5f1b654c89044db0cdc6adce43da1f1]
stable/5.15: [81203ab7a6ef843a2b904a0a494f28c457d44d27]

CVE-2022-49948: vt: Clear selection before changing the font

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49948

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
cip/4.19-st: [f74b4a41c5d7c9522469917e3072e55d435efd9e]
cip/4.4-st: [121037cabba962326bcd0f9b74a3354784903a61]
mainline: [566f9c9f89337792070b5a6062dff448b3e7977f]
stable/4.19: [f74b4a41c5d7c9522469917e3072e55d435efd9e]
stable/5.10: [989201bb8c00b222235aff04e6200230d29dc7bb]
stable/5.15: [2535431ae967ad17585513649625fea7db28d4db]
stable/5.4: [1cf1930369c9dc428d827b60260c53271bff3285]

CVE-2022-49949: firmware_loader: Fix memory leak in firmware upload

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49949

Introduced by commit 97730bb ("firmware_loader: Add firmware-upload
support") in v5.19-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [789bba82f63c3e81dce426ba457fc7905b30ac6e]

CVE-2022-49950: misc: fastrpc: fix memory corruption on open

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49950

Introduced by commit f6f9279 ("misc: fastrpc: Add Qualcomm fastrpc
basic driver model") in v5.1-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d245f43aab2b61195d8ebb64cef7b5a08c590ab4]
stable/5.10: [5cf2a57c7a01a0d7bdecf875a63682f542891b1b]
stable/5.15: [cf20c3533efc89578ace94fa20a9e63446223c72]
stable/5.4: [f8632b8bb53ebc005d8f24a68a0c1f9678c0e908]

CVE-2022-49951: firmware_loader: Fix use-after-free during unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49951

Introduced by commit 97730bb ("firmware_loader: Add firmware-upload
support") in v5.19-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b40c38e37492b5bdf8e95b46b5cca9517a9957a]

CVE-2022-49952: misc: fastrpc: fix memory corruption on probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49952

Introduced by commit f6f9279 ("misc: fastrpc: Add Qualcomm fastrpc
basic driver model") in v5.1-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9baa1415d9abdd1e08362ea2dcfadfacee8690b5]
stable/5.10: [c99bc901d5eb9fbdd7bd39f625e170ce97390336]
stable/5.15: [0e33b0f322fecd7a92d9dc186535cdf97940a856]
stable/5.4: [ec186b9f4aa2e6444d5308a6cc268aada7007639]

CVE-2022-49953: iio: light: cm3605: Fix an error handling path in cm3605_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49953

Introduced by commit 0d31d91 ("iio: light: cm3605: Make use of the
helper function dev_err_probe()") in v5.16-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [160905549e663019e26395ed9d66c24ee2cf5187]

CVE-2022-49954: Input: iforce - wake up after clearing IFORCE_XMIT_RUNNING flag

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49954

Introduced by commit c2b27ef ("Input: iforce - wait for command
completion when closing the device") in v2.6.33-rc3.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98e01215708b6d416345465c09dce2bd4868c67a]
stable/5.10: [b271090eea3899399e2adcf79c9c95367d472b03]
stable/5.15: [df1b53bc799d58f79701c465505a206c72ad4ab8]
stable/5.4: [d186c65599bff0222da37b9215784ddfe39f9e1b]

CVE-2022-49955: powerpc/rtas: Fix RTAS MSR[HV] handling for Cell

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49955

Introduced by commit b6b1c3c ("powerpc/rtas: Keep MSR[RI] set when
calling RTAS") in v5.19-rc1.
Fixed in v6.0-rc4.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [91926d8b7e71aaf5f84f0cf208fc5a8b7a761050]

CVE-2022-49956: staging: rtl8712: fix use after free bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49956

Introduced by commit 2865d42 ("staging: r8712u: Add the new driver to
the mainline kernel") in v2.6.37-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9fd6170c5e2d0ccd027abe26f6f5ffc528e1bb27]
mainline: [e230a4455ac3e9b112f0367d1b8e255e141afae0]
stable/4.19: [9fd6170c5e2d0ccd027abe26f6f5ffc528e1bb27]
stable/5.10: [19e3f69d19801940abc2ac37c169882769ed9770]
stable/5.15: [dc02aaf950015850e7589696521c7fca767cea77]
stable/5.4: [d0aac7146e96bf39e79c65087d21dfa02ef8db38]

CVE-2022-49957: kcm: fix strp_init() order and cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49957

Introduced by commit e557124 ("kcm: Check if sk_user_data already set
in kcm_attach") in v4.15.
Introduced by commit dff8baa ("kcm: Call strp_stop before strp_done in
kcm_attach") in v4.17-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a8a0c321319ad64a5427d6172cd9c23b4d6ca1e8]
mainline: [8fc29ff3910f3af08a7c40a75d436b5720efe2bf]
stable/4.19: [a8a0c321319ad64a5427d6172cd9c23b4d6ca1e8]
stable/5.10: [1b6666964ca1de93a7bf06e122bcf3616dbd33a9]
stable/5.15: [55fb8c3baa8071c5d533a9ad48624e44e2a04ef5]
stable/5.4: [0946ff31d1a8778787bf6708beb20f38715267cc]

CVE-2022-49958: net/sched: fix netdevice reference leaks in
attach_default_qdiscs()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49958

Introduced by commit bf6dba7 ("net: sched: fallback to qdisc noqueue
if default qdisc setup fail") in v5.8-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f612466ebecb12a00d9152344ddda6f6345f04dc]
stable/5.10: [44dfa645895a56f65461249deb5b81cd16560e2a]
stable/5.15: [a420d587260185407eda9c5766cfa9bdd5c39a56]

CVE-2022-49959: openvswitch: fix memory leak at failed datapath creation

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49959

Introduced by commit b83d23a ("openvswitch: Introduce per-cpu upcall
dispatch") in v5.15-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a87406f4adee9c53b311d8a1ba2849c69e29a6d0]
stable/5.15: [ca54b2bfaab385778e55a9fd33f6c31e7f743b48]

CVE-2022-49960: drm/i915: fix null pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49960

Introduced by commit c64a9a7 ("drm/i915: Update memory bandwidth
formulae") in v5.17-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [458ec0c8f35963626ccd51c3d50b752de5f1b9d4]

CVE-2022-49961: bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49961

Introduced by commit 457f443 ("bpf: Implement BPF ring buffer and
verifier support for it") in v5.8-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fc31465c5373b5ca4edf2e5238558cb62902311]

CVE-2022-49962: xhci: Fix null pointer dereference in remove if xHC
has only one roothub

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49962

Introduced by commit e0fe986 ("usb: host: xhci-plat: prepare operation
w/o shared hcd") in v5.19-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a593a62a9e3a25ab4bc37f612e4edec144f7f43]

CVE-2022-49963: drm/i915/ttm: fix CCS handling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49963

Introduced by commit da0595a ("drm/i915/migrate: Evict and restore the
flatccs capable lmem obj") in v5.19-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d905254162965c8e6be697d82c7dbf5d08f574d]

CVE-2022-49964: arm64: cacheinfo: Fix incorrect assignment of signed
error value to unsigned fw_level

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49964

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc3.


Fixed status
cip/4.19-st: [1668c38ef2e5bb80dbee88afcecfcdc3e7abc2aa]
mainline: [e75d18cecbb3805895d8ed64da4f78575ec96043]
stable/4.19: [1668c38ef2e5bb80dbee88afcecfcdc3e7abc2aa]
stable/5.10: [43b9af72751a98cb9c074b170fc244714aeb59d5]
stable/5.15: [29906311b351e5398aff2c5dc209f8b6c9d6a410]
stable/5.4: [fcab25a6b0ace130589d810390d1ce3698b53604]

CVE-2022-49965: drm/amd/pm: add missing ->fini_xxxx interfaces for
some SMU13 asics

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49965

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc2.


Fixed status
mainline: [4bac1c846eff8042dd59ddecd0a43f3b9de5fd23]

CVE-2022-49966: drm/amd/pm: add missing ->fini_microcode interface for
Sienna Cichlid

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49966

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc2.


Fixed status
mainline: [0a2d922a5618377cdf8fa476351362733ef55342]
stable/5.10: [60d522f317078381ff8a3599fe808f96fc256cd5]
stable/5.15: [a89e753d5a9f3b321f4a3098e2755c5aabcff0af]

CVE-2022-49967: bpf: Fix a data-race around bpf_jit_limit.

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49967

Introduced by commit ede95a6 ("bpf: add bpf_jit_limit knob to restrict
unpriv allocations") in v4.20-rc1.
Fixed in v6.0-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [0947ae1121083d363d522ff7518ee72b55bd8d29]

CVE-2022-49968: ieee802154/adf7242: defer destroy_workqueue call

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49968

Introduced by commit 58e9683 ("net: ieee802154: adf7242: Fix OCL
calibration in v4.18-rc6.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dede80aaf01f4b6e8657d23726cb4a3da226ec4c]
mainline: [afe7116f6d3b888778ed6d95e3cf724767b9aedf]
stable/4.19: [dede80aaf01f4b6e8657d23726cb4a3da226ec4c]
stable/5.10: [23a29932715ca43bceb2eae1bdb770995afe7271]
stable/5.15: [9f8558c5c642c62c450c98c99b7d18a709fff485]
stable/5.4: [bed12d7531df1417fc92c691999ff95e03835008]

CVE-2022-49969: drm/amd/display: clear optc underflow before turn off odm clock

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49969

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc2.


Fixed status
cip/4.19-st: [443687798d6f094412b7312b64b3bb4d99aedff7]
mainline: [b2a93490201300a749ad261b5c5d05cb50179c44]
stable/4.19: [443687798d6f094412b7312b64b3bb4d99aedff7]
stable/5.10: [3c1dfeaeb3b4e3ea656041da1241e6ee3c3b3202]
stable/5.15: [5ee30bcfdb32526233d2572f3d9ec371928679f1]
stable/5.4: [814b756d4ec3a8728debb116cf49005feada7750]

CVE-2022-49970: bpf, cgroup: Fix kernel BUG in purge_effective_progs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49970

Introduced by commit 4c46091 ("bpf: Fix KASAN use-after-free Read in
compute_effective_progs")
in 6.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [7d6620f107bae6ed687ff07668e8e8f855487aa9]
stable/5.10: [c5f975e3ebfa57be13393c585a4b58ea707023cb]
stable/5.15: [222bd95c89b135fde21f0bd0cb5cc1611c0c576c]

CVE-2022-49971: drm/amd/pm: Fix a potential gpu_metrics_table memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49971

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc2.


Fixed status
mainline: [5afb76522a0af0513b6dc01f84128a73206b051b]

CVE-2022-49972: xsk: Fix corrupted packets for XDP_SHARED_UMEM

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49972

Introduced by commit 94033cd ("xsk: Optimize for aligned case") in v5.16-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58ca14ed98c87cfe0d1408cc65a9745d9e9b7a56]

CVE-2022-49973: skmsg: Fix wrong last sg check in sk_msg_recvmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49973

Introduced by commit 9974d37 ("skmsg: Fix invalid last sg check in
sk_msg_recvmsg()")
in 6.0-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [583585e48d965338e73e1eb383768d16e0922d73]
stable/5.15: [de22cba333d8699ad77e79f862fe1320cb1284de]

CVE-2022-49974: HID: nintendo: fix rumble worker null pointer deref

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49974

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
mainline: [1ff89e06c2e5fab30274e4b02360d4241d6e605e]

CVE-2022-49975: bpf: Don't redirect packets with invalid pkt_len

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49975

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [fd1894224407c484f652ad456e1ce423e89bb3eb]
stable/5.10: [6204bf78b2a903b96ba43afff6abc0b04d6e0462]
stable/5.15: [a75987714bd2d8e59840667a28e15c1fa5c47554]
stable/5.4: [8b68e53d56697a59b5c53893b53f508bbdf272a0]

CVE-2022-49976: platform/x86: x86-android-tablets: Fix broken
touchscreen on Chuwi Hi8 with Windows BIOS

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49976

Introduced by commit 84c2dcd ("platform/x86: x86-android-tablets: Add
an init() callback to struct x86_dev_info") in v5.17-rc3.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2986c51540ed50ac654ffb5a772e546c02628c91]

CVE-2022-49977: ftrace: Fix NULL pointer dereference in
is_ftrace_trampoline when ftrace is dead

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49977

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc2.


Fixed status
cip/4.19-st: [ddffe882d74ef43a3494f0ab0c24baf076c45f96]
cip/4.4-st: [8fb68a753d47ab275df245489f5185b68f9572b5]
mainline: [c3b0f72e805f0801f05fa2aa52011c4bfc694c44]
stable/4.19: [ddffe882d74ef43a3494f0ab0c24baf076c45f96]
stable/5.10: [dbd8c8fc60480e3faa3ae7e27ebe03371ecd1b77]
stable/5.15: [e4ae97295984ff1b9b340ed18ae1b066f36b7835]
stable/5.4: [934e49f7d696afdae9f979abe3f308408184e17b]

CVE-2022-49978: fbdev: fb_pm2fb: Avoid potential divide by zero error

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49978

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc3.


Fixed status
cip/4.19-st: [7f88cdfea8d7f4dbaf423d808241403b2bb945e4]
cip/4.4-st: [462206247931feb7f2f5ae9e314c434bf75e8f83]
mainline: [19f953e7435644b81332dd632ba1b2d80b1e37af]
stable/4.19: [7f88cdfea8d7f4dbaf423d808241403b2bb945e4]
stable/5.10: [8fc778ee2fb2853f7a3531fa7273349640d8e4e9]
stable/5.15: [34c3dea1189525cd533071ed5c176fc4ea8d982b]
stable/5.4: [7d9591b32a9092fc6391a316b56e8016c6181c3d]

CVE-2022-49979: net: fix refcount bug in sk_psock_get (2)

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49979

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [2a0133723f9ebeb751cfce19f74ec07e108bef1f]
stable/5.10: [61cc798591a36ca27eb7d8d6c09bf20e50a59968]
stable/5.15: [a5d1cb908131e939bd8b63b8e5e23365bbc2edaf]

CVE-2022-49980: USB: gadget: Fix use-after-free Read in usb_udc_uevent()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49980

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [2191c00855b03aa59c20e698be713d952d51fc18]

CVE-2022-49981: HID: hidraw: fix memory leak in hidraw_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49981

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc4.


Fixed status
cip/4.19-st: [f5b7e9611cffec345d62d5bdd8b6e30e89956818]
cip/4.4-st: [ee94e46e97280ff31001e19b6acfcd9d0cc2ca09]
mainline: [a5623a203cffe2d2b84d2f6c989d9017db1856af]
stable/4.19: [f5b7e9611cffec345d62d5bdd8b6e30e89956818]
stable/5.10: [7e2fa79226580b035b00260d9f240ab9bda4af5d]
stable/5.15: [dfd27a737283313a3e626e97b9d9b2d8d6a94188]
stable/5.4: [53c7c4d5d40b45c127cb1193bf3e9670f844c3cf]

CVE-2022-49982: media: pvrusb2: fix memory leak in pvr_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49982

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [491762b3250fb06a0c97b5198656ea48359eaeed]
mainline: [945a9a8e448b65bec055d37eba58f711b39f66f0]
stable/4.19: [491762b3250fb06a0c97b5198656ea48359eaeed]
stable/5.10: [bacb37bdc2a21c8f7fdc83dcc0dea2f4ca1341fb]
stable/5.15: [f2f6e67522916f53ad8ccd4dbe68dcf76e9776e5]
stable/5.4: [466b67c0543b2ae67814d053f6e29b39be6b33bb]

CVE-2022-49983: udmabuf: Set the DMA mask for the udmabuf device (v2)

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49983

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [9e9fa6a9198b767b00f48160800128e83a038f9f]
stable/5.10: [872875c9ecf8fa2e1d82bb2f2f1963f571aa8959]
stable/5.15: [e658538c610c6047b3c9f552e73801894d9284b1]
stable/5.4: [63d8c1933ed280717f934e2bc2edd869bb66f329]

CVE-2022-49984: HID: steam: Prevent NULL pointer dereference in
steam_{recv,send}_report

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49984

Introduced by commit c164d6a ("HID: add driver for Valve Steam
Controller") in v4.18-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c20d03b82a2e3ddbb555dad4d4f3374a9763222c]
mainline: [cd11d1a6114bd4bc6450ae59f6e110ec47362126]
stable/4.19: [c20d03b82a2e3ddbb555dad4d4f3374a9763222c]
stable/5.10: [dc815761948ab5b8c94db6cb53c95103588f16ae]
stable/5.15: [989560b6d9e00d99e07bc33067fa1c770994bf4d]
stable/5.4: [fa2b822d86be5b5ad54fe4fa2daca464e71ff90a]

CVE-2022-49985: bpf: Don't use tnum_range on array range checking for
poke descriptors

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49985

Introduced by commit d2e4c1e ("bpf: Constant map key tracking for prog
array pokes") in v5.5-rc1.
Fixed in v6.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a657182a5c5150cdfacb6640aad1d2712571a409]
stable/5.10: [e8979807178434db8ceaa84dfcd44363e71e50bb]
stable/5.15: [4f672112f8665102a5842c170be1713f8ff95919]

CVE-2022-49986: scsi: storvsc: Remove WQ_MEM_RECLAIM from storvsc_error_wq

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49986

Introduced by commit 436ad94 ("scsi: storvsc: Allow only one remove
lun work item to be issued per lun") in v4.15-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b692c238ddfa61f00d97c4c1f021425d132ba96f]
mainline: [d957e7ffb2c72410bcc1a514153a46719255a5da]
stable/4.19: [b692c238ddfa61f00d97c4c1f021425d132ba96f]
stable/5.10: [46fcb0fc884db78a0384be92cc2a51927e6581b8]
stable/5.15: [cd2a50d0a097a42b6de283377da98ff757505120]
stable/5.4: [b4c928ace9a123629eeb14ec5d7ee8f73e5ac668]

CVE-2022-49987: md: call __md_stop_writes in md_stop

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49987

Introduced by commit 48df498 ("md: move bitmap_destroy to the
beginning of __md_stop") in v4.12-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [690b5c90fd2d81fd1d2b6110fa36783232f6dce2]
mainline: [0dd84b319352bb8ba64752d4e45396d8b13e6018]
stable/4.19: [690b5c90fd2d81fd1d2b6110fa36783232f6dce2]
stable/5.10: [a5a58fab556bfe618b4c9719eb85712d78c6cb10]
stable/5.15: [661c01b2181d9413c799127f13143583b69f20fd]
stable/5.4: [8e7fb19f1a744fd34e982633ced756fee0498ef7]

CVE-2022-49988: [REJECTED]: binder_alloc: add missing mmap_lock calls
when using the VMA

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49988

This CVE was rejected. Introduced by commit a43cfc8 ("android: binder:
stop saving a pointer to the VMA")
in 6.0-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [44e602b4e52f70f04620bbbf4fe46ecb40170bde]
stable/5.15: [577d9c05cc48c5242bcf719c06a5baf3105473ad]

CVE-2022-49989: xen/privcmd: fix error exit of privcmd_ioctl_dm_op()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49989

Introduced by commit ab520be ("xen/privcmd: Add IOCTL_PRIVCMD_DM_OP")
in v4.11-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5deb27895e017a0267de0a20d140ad5fcc55a54]
stable/5.10: [6de50db104af0dc921f593fd95c55db86a52ceef]
stable/5.15: [c2b7bae7c90051fd6a679d5dee00400d67ebbf4a]

CVE-2022-49990: s390: fix double free of GS and RI CBs on fork() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49990

Introduced by commit 8d9047f ("s390/runtime instrumentation: simplify
task exit handling") in v4.15-rc1.
Introduced by commit 7b83c62 ("s390/guarded storage: simplify task
exit handling") in v4.15-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [25a95303b9e513cd2978aacc385d06e6fec23d07]
mainline: [13cccafe0edcd03bf1c841de8ab8a1c8e34f77d9]
stable/4.19: [25a95303b9e513cd2978aacc385d06e6fec23d07]
stable/5.10: [297ae7e87a87a001dd3dfeac1cb26a42fd929708]
stable/5.15: [8195e065abf3df84eb0ad2987e76a40f21d1791c]
stable/5.4: [cacd522e6652fbc2dc0cc6ae11c4e30782fef14b]

CVE-2022-49991: mm/hugetlb: avoid corrupting page->mapping in
hugetlb_mcopy_atomic_pte

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49991

Introduced by commit f619147 ("userfaultfd: add UFFDIO_CONTINUE
ioctl") in v5.13-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab74ef708dc51df7cf2b8a890b9c6990fac5c0c6]
stable/5.15: [da60ddd80d09f8371fbba1a238a4b318d13ba698]

CVE-2022-49992: mm/mprotect: only reference swap pfn page if type match

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49992

Introduced by commit 6c28760 ("mm: remember exclusively mapped
anonymous pages with PG_anon_exclusive") in v5.19-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d2f78f08cd8388035ac375e731ec1ac1b79b09d]

CVE-2022-49993: loop: Check for overflow while configuring loop

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49993

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc3.


Fixed status
cip/4.19-st: [2035c770bfdbcc82bd52e05871a7c82db9529e0f]
cip/4.4-st: [f94074ab9098ea36122a896c81f85375a89ab936]
mainline: [c490a0b5a4f36da3918181a8acdc6991d967c5f3]
stable/4.19: [a217715338fd48f72114725aa7a40e484a781ca7]
stable/5.10: [6858933131d0dadac071c4d33335a9ea4b8e76cf]
stable/5.15: [0455bef69028c65065f16bb04635591b2374249b]
stable/5.4: [b40877b8562c5720d0a7fce20729f56b75a3dede]

CVE-2022-49994: bootmem: remove the vmemmap pages from kmemleak in
put_page_bootmem

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49994

Introduced by commit f41f2ed (mm: hugetlb: free the vmemmap pages
associated with each HugeTLB page) in v5.14-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd0ff4d12dd284c334f7e9b07f8f335af856ac78]
stable/5.15: [16a12ee619e39e8112f61b603255c16b73b6264b]

CVE-2022-49995: writeback: avoid use-after-free after removing device

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49995

Introduced by commit 45a2966 ("writeback: fix bandwidth estimate for
spiky workload") in v5.15-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f87904c075515f3e1d8f4a7115869d3b914674fd]
stable/5.15: [f96b9f7c1676923bce871e728bb49c0dfa5013cc]

CVE-2022-49996: btrfs: fix possible memory leak in
btrfs_get_dev_args_from_path()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49996

Introduced by commit faa775c ("btrfs: add a
btrfs_get_dev_args_from_path helper") in v5.16-rc1.
Fixed in v6.0-rc3.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [9ea0106a7a3d8116860712e3f17cd52ce99f6707]
stable/5.15: [5f52402c77013e4a826394b807dd5ea4dc83bd72]

CVE-2022-49997: net: lantiq_xrx200: restore buffer if memory allocation failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49997

Introduced by commit 7ea6cd1 ("lantiq: net: fix duplicated skb in rx
descriptor ring") in v5.13-rc7.
Fixed in v6.0-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [c9c3b1775f80fa21f5bff874027d2ccb10f5d90c]

CVE-2022-49998: rxrpc: Fix locking in rxrpc's sendmsg

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49998

Introduced by commit bc5e3a5 ("rxrpc: Use MSG_WAITALL to tell
sendmsg() to temporarily ignore signals") in v4.15-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0f571ecd7943423c25947439045f0d352ca3dbf]
stable/5.10: [79e2ca7aa96e80961828ab6312264633b66183cc]
stable/5.15: [2bc769b8edb158be7379d15f36e23d66cf850053]

CVE-2022-49999: btrfs: fix space cache corruption and potential double
allocations

Announce: https://www.cve.org/CVERecord?id=CVE-2022-49999

Introduced by commit d0c2f4f ("btrfs: make concurrent fsyncs wait less
when waiting for a transaction commit") in v5.12-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ced8ecf026fd8084cf175530ff85c76d6085d715]
stable/5.15: [92dc4c1a8e58bcc7a183a4c86b055c24cc88d967]

CVE-2022-50000: netfilter: flowtable: fix stuck flows on cleanup due
to pending work

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50000

Introduced by commit c29f74e ("netfilter: nf_flow_table: hardware
offload support") in v5.5-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9afb4b27349a499483ae0134282cefd0c90f480f]
stable/5.15: [8fbdec08dbf7d7ab8e35bdc65eb4394bc82d1e26]

CVE-2022-50001: netfilter: nft_tproxy: restrict to prerouting hook

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50001

Introduced by commit 4ed8eb6 ("netfilter: nf_tables: Add native tproxy
support") in v4.19-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0b21edf4cc13516716848e0a4fdf726aa2a62cd9]
mainline: [18bbc3213383a82b05383827f4b1b882e3f0a5a5]
stable/4.19: [0b21edf4cc13516716848e0a4fdf726aa2a62cd9]
stable/5.10: [eaba3f9b672c3a3f820da8ee9584b9520674eafa]
stable/5.15: [9a1d92cbeac3335fee99fa865b8c5b0f2e71a8f7]
stable/5.4: [83ef55c4281f1b4c6bd4457c2e96ccd1c9e80200]

CVE-2022-50002: net/mlx5: LAG, fix logic over MLX5_LAG_FLAG_NDEVS_READY

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50002

Introduced by commit 8a66e45 ("net/mlx5: Change ownership model for
lag") in v5.14-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6e675a66175869b7d87c0e1dd0ddf93e04f8098]

CVE-2022-50003: ice: xsk: prohibit usage of non-balanced queue id

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50003

Introduced by commit 2d4238f ("ice: Add support for AF_XDP") in v5.5-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a42f112d367bb4700a8a41f5c12724fde6bfbb9]
stable/5.10: [1bfdcde723d8ceb2d73291b0415767e7c1cc1d8a]
stable/5.15: [fe76b3e674665ea4059337f8f66d20cdfb0168eb]

CVE-2022-50004: xfrm: policy: fix metadata dst->dev xmit null pointer
dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50004

Introduced by commit 2d151d3 ("xfrm: Add possibility to set the
default to block if we have no policy") in v5.15-rc1.
Fixed in v6.0-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [17ecd4a4db4783392edd4944f5e8268205083f70]
stable/5.10: [2761612bcde9776dd93ce60ce55ef0b7c7329153]
stable/5.15: [96f2758a6d028d1ac08616de9c3c7ff2a122ecf1]

CVE-2022-50005: nfc: pn533: Fix use-after-free bugs caused by pn532_cmd_timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50005

Introduced by commit c656aa4 ("nfc: pn533: add UART phy driver") in v5.5-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1e941dbf80a9b8bab0bffbc4cbe41cc7f4c6fb6]
stable/5.10: [50403ee6daddf0d7a14e9d3b51a377c39a08ec8c]
stable/5.15: [9c34c33893db7a80d0e4b55c23d3b65e29609cfb]

CVE-2022-50006: NFSv4.2 fix problems with __nfs42_ssc_open

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50006

Introduced by commit ec4b092 ("NFS: inter ssc open") in v5.5-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fcfc8be1e9cf2f12b50dce8b579b3ae54443a014]
stable/5.10: [5e49ea099850feadcbf33c74b4f514a3e8049b91]
stable/5.15: [5626f95356111602ad26fc05445a4d1f818a0992]

CVE-2022-50007: xfrm: fix refcount leak in __xfrm_policy_check()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50007

Introduced by commit 134b0fc ("IPsec: propagate security module errors
up from flow_cache_lookup") in v2.6.20.16.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0769491a8acd3e85ca4c3f65080eac2c824262df]
cip/4.4-st: [4d58862464427614d6b61dc0f00d610dc9f68544]
mainline: [9c9cb23e00ddf45679b21b4dacc11d1ae7961ebe]
stable/4.19: [0769491a8acd3e85ca4c3f65080eac2c824262df]
stable/5.10: [1305d7d4f35ca6f214a2d23b075aa6a924cff3be]
stable/5.15: [26ad2398fe4984f4f6f930bcb3bc9047fa77265b]
stable/5.4: [63da7a2bbf3f28094920e0b8a17d2571a9bd842d]

CVE-2022-50008: kprobes: don't call disarm_kprobe() for disabled kprobes

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50008

Introduced by commit 69d54b9 ("kprobes: makes kprobes/enabled works
correctly for optimized kprobes.") in v4.0-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fc91d2db55acdaf0c0075b624e572d3520ca3bc3]
cip/4.4-st: [415c04b362ab6a0dc246e2e0207273e5f4724c84]
mainline: [9c80e79906b4ca440d09e7f116609262bb747909]
stable/4.19: [fc91d2db55acdaf0c0075b624e572d3520ca3bc3]
stable/5.10: [744b0d3080709a172f0408aedabd1cedd24c2ee6]
stable/5.15: [55c7a91527343d2e0b5647cc308c6e04ddd2aa52]
stable/5.4: [b474ff1b20951f1eac75d100a93861e6da2b522b]

CVE-2022-50009: f2fs: fix null-ptr-deref in f2fs_get_dnode_of_data

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50009

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [4a2c5b7994960fac29cf8a3f4e62855bae1b27d4]

CVE-2022-50010: video: fbdev: i740fb: Check the argument of i740_calc_vclk()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50010

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [d2d375eb68b4b8de6ea7460483a26fa9de56b443]
cip/4.4-st: [1589a87dd85f7b32f00a2acdd3398f649fe81e5d]
mainline: [40bf722f8064f50200b8c4f8946cd625b441dda9]
stable/4.19: [d2d375eb68b4b8de6ea7460483a26fa9de56b443]
stable/5.10: [4b20c61365140d432dee7da7aa294215e7b900d9]
stable/5.15: [e740e787f06671455b59d1e498c9945f7b4e7b3b]
stable/5.4: [2b7f559152a33c55f51b569b22efbe5e24886798]

CVE-2022-50011: venus: pm_helpers: Fix warning in OPP during probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50011

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [1d95af02f23031c2e1cca7607c514b86ce85bc6e]
stable/5.15: [0bdec5eed69c73886af4cfbb94b663e1e10b8344]

CVE-2022-50012: powerpc/64: Init jump labels before parse_early_param()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50012

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [4bb1188e2b1ed98fa2b618cc0628ccba63c6c80f]
cip/4.4-st: [8dc03c1051f401b56fe04ab3cde4ec69480b34f0]
mainline: [ca829e05d3d4f728810cc5e4b468d9ebc7745eb3]
stable/4.19: [4bb1188e2b1ed98fa2b618cc0628ccba63c6c80f]
stable/5.10: [dac28dff90849af4200b8269fcdc84cdc12fa46c]
stable/5.15: [e3c9e9452a8ea12d335b1e59b2c72e1b99c699b8]
stable/5.4: [5e14b04c8459afbeea1eeb74e81af86d7b196a4d]

CVE-2022-50013: f2fs: fix to avoid use f2fs_bug_on() in f2fs_new_node_page()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50013

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [fbfad62b29e9f8f1c1026a806c9e064ec2a7c342]
mainline: [141170b759e03958f296033bb7001be62d1d363b]
stable/4.19: [fbfad62b29e9f8f1c1026a806c9e064ec2a7c342]
stable/5.10: [800ba8979111184d5194f4233cc83afe683efc54]
stable/5.15: [5a01e45b925a0bc9718eccd33e5920f1a4e44caf]
stable/5.4: [29e734ec33ae4bd7de4018fb0fb0eec808c36b92]

CVE-2022-50014: mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50014

Introduced by commit 9ae0f87 ("mm/shmem: unconditionally set pte dirty
in mfill_atomic_install_pte") in v5.16-rc1.
Fixed in v6.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5535be3099717646781ce1540cf725965d680e7b]

CVE-2022-50015: ASoC: SOF: Intel: hda-ipc: Do not process IPC reply
before firmware boot

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50015

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [499cc881b09c8283ab5e75b0d6d21cb427722161]

CVE-2022-50016: ASoC: SOF: Intel: cnl: Do not process IPC reply before
firmware boot

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50016

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [acacd9eefd0def5a83244d88e5483b5f38ee7287]

CVE-2022-50017: mips: cavium-octeon: Fix missing of_node_put() in
octeon2_usb_clocks_start

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50017

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [c06166a484eece51916dd700a870e53356b7e1bc]
cip/4.4-st: [2830f4d4ac4341064e1f6d754d950acfcef16914]
mainline: [7a9f743ceead60ed454c46fbc3085ee9a79cbebb]
stable/4.19: [c06166a484eece51916dd700a870e53356b7e1bc]
stable/5.10: [1e39037e44d7fa3728686af146f9285ea197097d]
stable/5.15: [7822d994eb9579a1df4cdbc315db090a041e50f3]
stable/5.4: [1b49707df679b5510ed06ace7378ddc2aec5c3fb]

CVE-2022-50018: [REJECTED]: ALSA: hda: Fix page fault in
snd_hda_codec_shutdown()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50018

This CVE was rejected. There is no mention of the commit that
introduced the bug in the CVE announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [980b3a8790b402e959a6d773b38b771019682be1]

CVE-2022-50019: tty: serial: Fix refcount leak bug in ucc_uart.c

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50019

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [59bc4c19d53bdac61ec952c01c6e864f5f0f8367]
cip/4.4-st: [0f3bbba636158df99edffb68aaff1f2ec6c2e221]
mainline: [d24d7bb2cd947676f9b71fb944d045e09b8b282f]
stable/4.19: [59bc4c19d53bdac61ec952c01c6e864f5f0f8367]
stable/5.10: [81939c4fbc2d5c754d0f1c1f05149d4b70d751ed]
stable/5.15: [17c32546166d8a7d2579c4b57c8b16241f94a66b]
stable/5.4: [ca3fc1c38e4253bc019881301a28ea60b8b0bca3]

CVE-2022-50020: ext4: avoid resizing to a partial cluster size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50020

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [7bdfb01fc5f6b3696728aeb527c50386e0ee09a1]
cip/4.4-st: [268714308b9e276044021947654c647601c6db17]
mainline: [69cb8e9d8cd97cdf5e293b26d70a9dee3e35e6bd]
stable/4.19: [7bdfb01fc5f6b3696728aeb527c50386e0ee09a1]
stable/5.10: [80288883294c5b4ed18bae0d8bd9c4a12f297074]
stable/5.15: [72b850a2a996f72541172e7cf686d54a2b29bcd8]
stable/5.4: [a6805b3dcf5cd41f2ae3a03dca43411135b99849]

CVE-2022-50021: ext4: block range must be validated before use in
ext4_mb_clear_bb()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50021

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [1e1c2b86ef86a8477fd9b9a4f48a6bfe235606f6]
stable/5.10: [7550aade978371ac582f6d43b14c4cb89ca54463]
stable/5.15: [560a2744cbbf03cac65a6394f9b0d99aa437c867]

CVE-2022-50022: drivers:md:fix a potential use-after-free bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50022

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [e5b3dd2d92c4511e81f6e4ec9c5bb7ad25e03d13]
cip/4.4-st: [2c1b65e60d7940bd9d34e470bff8bea555b5e376]
mainline: [104212471b1c1817b311771d817fb692af983173]
stable/4.19: [e5b3dd2d92c4511e81f6e4ec9c5bb7ad25e03d13]
stable/5.10: [5d8325fd15892c8ab1146edc1d7ed8463de39636]
stable/5.15: [d9b94c3ace549433de8a93eeb27b0391fc8ac406]
stable/5.4: [f5d46f1b47f65da1faf468277b261eb78c8e25b5]

CVE-2022-50023: dmaengine: dw-axi-dmac: ignore interrupt if no descriptor

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50023

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [820f5ce999d2f99961e88c16d65cd26764df0590]
stable/5.15: [54aa6c49361b79f7f6b15fc63dfe9ea52c70bb03]

CVE-2022-50024: dmaengine: dw-axi-dmac: do not print NULL LLI during error

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50024

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [86cb0defe0e275453bc39e856bb523eb425a6537]
stable/5.15: [af76e6fdcf92f1a742b788d0dba5edd194267bf9]

CVE-2022-50025: cxl: Fix a memory leak in an error handling path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50025

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [89d51dc6878c47b6400922fac21b6a33f9d1a588]
mainline: [3a15b45b5454da862376b5d69a4967f5c6fa1368]
stable/4.19: [89d51dc6878c47b6400922fac21b6a33f9d1a588]
stable/5.10: [4be138bcd6d68cec0ce47051b117541061f5141a]
stable/5.15: [addff638c41753639368c252d0c5ba0d8fe9ed97]
stable/5.4: [695af60af755873399ce01cb97176768828bc1fd]

CVE-2022-50026: habanalabs/gaudi: fix shift out of bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50026

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [01622098aeb05a5efbb727199bbc2a4653393255]
stable/5.15: [b09e5ab18c9f52ff14cf968770e15d5b2dd85c43]

CVE-2022-50027: scsi: lpfc: Fix possible memory leak when failing to
issue CMF WQE

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50027

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [2f67dc7970bce3529edce93a0a14234d88b3fcd5]
stable/5.15: [9c8e2e607270a368834a0ef72aa82d970f89c596]

CVE-2022-50028: gadgetfs: ep_io - wait until IRQ finishes

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50028

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [77040efe59a141286d090c8a0d37c65a355a1832]
cip/4.4-st: [e96c2207c844b7f52c8f6373db652c9ec1427f8d]
mainline: [04cb742d4d8f30dc2e83b46ac317eec09191c68e]
stable/4.19: [77040efe59a141286d090c8a0d37c65a355a1832]
stable/5.10: [9ac14f973cb91f0c01776517e6d50981f32b8038]
stable/5.15: [94aadba8d000d5de56af4ce8da3f334f21bf7a79]
stable/5.4: [ca06b4cde54f8ec8be3aa53fd339bd56e62c12b3]

CVE-2022-50029: clk: qcom: ipq8074: dont disable gcc_sleep_clk_src

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50029

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [4203b76abe539f3cac258d4cf1e16e2dd95ea60f]
mainline: [1bf7305e79aab095196131bdc87a97796e0e3fac]
stable/4.19: [4203b76abe539f3cac258d4cf1e16e2dd95ea60f]
stable/5.10: [6b90ab952401bd6c1a321dcfc0e0df080f2bc905]
stable/5.15: [17d58499dc9c7e059dab7d170e9bae1e7e9c561b]
stable/5.4: [d401611a93b332914cf91eb9bc0b63fa1bdc17e9]

CVE-2022-50030: scsi: lpfc: Prevent buffer overflow crashes in debugfs
with malformed user input

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50030

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [f8191d40aa612981ce897e66cda6a88db8df17bb]
stable/5.10: [c29a4baaad38a332c0ae480cf6d6c5bf75ac1828]
stable/5.15: [b92506dc51f81741eb26609175ac206c20f06e0a]
stable/5.4: [927907f1cbb3408cadde637fccfc17bb6b10a87d]

CVE-2022-50031: scsi: iscsi: Fix HW conn removal use after free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50031

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [c577ab7ba5f3bf9062db8a58b6e89d4fe370447e]

CVE-2022-50032: usb: renesas: Fix refcount leak bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50032

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [36b18b777dece704b7c2e9e7947ca41a9b0fb009]
mainline: [9d6d5303c39b8bc182475b22f45504106a07f086]
stable/4.19: [36b18b777dece704b7c2e9e7947ca41a9b0fb009]
stable/5.10: [9790a5a4f07f38a5add85ec58c44797d3a7c3677]
stable/5.15: [fbdbd61a36d887e00114321c6758e359e9573a8e]
stable/5.4: [cfa8f707a58d68b2341a9dd0b33cf048f0628b4d]

CVE-2022-50033: usb: host: ohci-ppc-of: Fix refcount leak bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50033

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [ec583e300aee9f152a64911445092d18e1c36729]
cip/4.4-st: [63fe91560dd89d077dc126acdaaaa4e1e5f55239]
mainline: [40a959d7042bb7711e404ad2318b30e9f92c6b9b]
stable/4.19: [ec583e300aee9f152a64911445092d18e1c36729]
stable/5.10: [cb5dd65e889163e723df1c2f02288cc527a57785]
stable/5.15: [0fc62bbc95319bbd330e3645afc7c286acec9ef8]
stable/5.4: [0334d23c56ecf1ee1563bb83e29cc5a51ed7fb4e]

CVE-2022-50034: usb: cdns3 fix use-after-free at workaround 2

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50034

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [7d602f30149a117eea260208b1661bc404c21dfd]
stable/5.10: [6d7ac60098b206d0472475b666cb09d556bec03d]
stable/5.15: [c3c1dbad3a2db32ecf371c97f2058491b8ba0f9a]
stable/5.4: [e65d9b7147d7be3504893ca7dfb85286bda83d40]

CVE-2022-50035: drm/amdgpu: Fix use-after-free on amdgpu_bo_list mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50035

Introduced by commit 90af0ca ("drm/amdgpu: Protect the amdgpu_bo_list
list with a mutex v2") in v5.19-rc8.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbca24d0a3c11193bafb9e174f89f52a379006e3]

CVE-2022-50036: drm/sun4i: dsi: Prevent underflow when computing packet sizes

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50036

Introduced by commit 133add5 ("drm/sun4i: Add Allwinner A31 MIPI-DSI
controller support") in v4.18-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82a1356a933d8443139f8886f11b63c974a09a67]
stable/5.10: [a1e7908f78f5a7f53f8cd83c7dcdfec974c95f26]
stable/5.15: [98e28de472ef248352f04f87e29e634ebb0ec240]

CVE-2022-50037: drm/i915/ttm: don't leak the ccs state

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50037

Introduced by commit 48760ff ("drm/i915/gt: Clear compress metadata
for Flat-ccs objects") in v5.19-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [232d150fa15606e96c0e01e5c7a2d4e03f621787]

CVE-2022-50038: drm/meson: Fix refcount bugs in
meson_vpu_has_available_connectors()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50038

Introduced by commit bbbe775 ("drm: Add support for Amlogic Meson
Graphic Controller") in v4.10-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fc1fc2abfcb9235d0ece9a4d858426fb617cfa66]
mainline: [91b3c8dbe898df158fd2a84675f3a284ff6666f7]
stable/4.19: [fc1fc2abfcb9235d0ece9a4d858426fb617cfa66]
stable/5.10: [3aa710e96747c8b4e52ba12ffe09edcb2755897c]
stable/5.15: [fe71d84c1a6c0d54657431e8eeaefc9d24895304]
stable/5.4: [d58ef256781398ad115aef44de0a02ad27ea6c3a]

CVE-2022-50039: stmmac: intel: Add a missing clk_disable_unprepare()
call in intel_eth_pci_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50039

Introduced by commit 5ec5582 ("net: stmmac: add clocks management for
gmac driver") in v5.13-rc1.
Fixed in v6.0-rc2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [5c23d6b717e4e956376f3852b90f58e262946b50]
stable/5.10: [02f3642d8e657c05f382729c165bed46745dc18c]
stable/5.15: [47129531196054b374017555165b47a43cdb6f41]

CVE-2022-50040: net: dsa: sja1105: fix buffer overflow in
sja1105_setup_devlink_regions()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50040

Introduced by commit bf425b8 ("net: dsa: sja1105: expose static config
as devlink region") in v5.10-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd8e899cdb5ecaf8e8ee73854a99e10807eef1de]
stable/5.10: [7983e1e44cb322eba6af84160b6d18df80603fb8]
stable/5.15: [e84c6321f3578c38cb3c24258db91a92672b17a8]

CVE-2022-50041: ice: Fix call trace with null VSI during VF reset

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50041

Introduced by commit efe4186 ("ice: Fix memory corruption in VF
driver") in v5.19-rc3.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf90b74341eecc32ceef0c136954a1668e43b1e7]

CVE-2022-50042: net: genl: fix error path memory leak in policy dumping

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50042

Introduced by commit 50a896c ("genetlink: properly support per-op
policy dumping") in v5.10-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [249801360db3dec4f73768c502192020bfddeacc]
stable/5.10: [83411c9f05d5a8b637293b3389eca3d378197c04]
stable/5.15: [b0672895d8be5d19d4b05ac83f807026fc791037]

CVE-2022-50043: net: fix potential refcount leak in ndisc_router_discovery()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50043

Introduced by commit 6b2e04b ("net: allow user to set metric on
default route learned via Router Advertisement") in v5.12-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7396ba87f1edf549284869451665c7c4e74ecd4f]
stable/5.15: [ffb15594433391fd7885eb88ce5a7f7bdeefbb15]

CVE-2022-50044: net: qrtr: start MHI channel after endpoit creation

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50044

Introduced by commit a2e2cc0 ("net: qrtr: Start MHI channels during
init") in v5.11-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68a838b84effb7b57ba7d50b1863fc6ae35a54ce]
stable/5.15: [c682fb70a7dfc25b848a4ff3a385b0471b470606]

CVE-2022-50045: powerpc/pci: Fix get_phb_number() locking

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50045

This CVE announce does not contain fixed commit in the mainline.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [5db5ce0f1963c6c8275719a80cb65e9c98d32726]
mainline: [8d48562a2729742f767b0fdd994d6b2a56a49c63]
stable/5.10: [6f75057c21eab12c6ccb7f06f859641a6edfab99]
stable/5.15: [5db5ce0f1963c6c8275719a80cb65e9c98d32726]
stable/5.4: [ccb0a42d3f40c436295e0fef57ab613ae5b925a4]

CVE-2022-50046: net/sunrpc: fix potential memory leaks in
rpc_sysfs_xprt_state_change()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50046

Introduced by commit 5b7eb78 ("SUNRPC: take a xprt offline using
sysfs") in v5.14-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfc48f1b0505ffcb03a6d749139b7577d6b81ae0]
stable/5.15: [c0434f0e058648649250b8ed6078b66d773de723]

CVE-2022-50047: net: dsa: mv88e6060: prevent crash on an unused port

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50047

Introduced by commit 0abfd49 ("net: dsa: use dedicated CPU port") in v4.15-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [246bbf2f977ea36aaf41f5d24370fef433250728]
stable/5.10: [92dc64e8f591425ce4dabf7d479ebf6e67fb8853]
stable/5.15: [dd236b62d25e44ecfa26b0910a12f8d8251aff00]
stable/5.4: [cb1753bc689c7a7f94da6eee7efc1ae6d8abb36c]

CVE-2022-50048: netfilter: nf_tables: possible module reference
underflow in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50048

Introduced by commit 8cfd9b0 ("netfilter: nftables: generalize set
expressions support") in v5.11-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c485c35ff6783ccd12c160fcac6a0e504e83e0bf]
stable/5.15: [b59bee8b05b0e789b5a298cacb09e8aaa3367a29]

CVE-2022-50049: ASoC: DPCM: Don't pick up BE without substream

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50049

Introduced by commit bbf7d3b ("ASoC: soc-pcm: align BE 'atomicity'
with that of the FE") in v5.17-rc1.
Fixed in v5.19.4.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [6a840e8ef6b6c56d1b7e6a555adc31135e517875]

CVE-2022-50050: ASoC: SOF: Intel: hda: Fix potential buffer overflow
by snprintf()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50050

Introduced by commit 29c8e43 ("ASoC: SOF: Intel: hda: add extended rom
status dump to error log") in v5.10-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94c1ceb043c1a002de9649bb630c8e8347645982]
stable/5.15: [6ee1310f4d148dbf04c4159b88afd0b941018903]

CVE-2022-50051: ASoC: SOF: debug: Fix potential buffer overflow by snprintf()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50051

Introduced by commit 5b10b62 ("ASoC: SOF: Add `memory_info` file to
debugfs") in v5.11-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1eb123ce985e6cf302ac6e3f19862d132d86fa8f]
stable/5.15: [b318b9dd2ac67f39d0338ce563879d1f59a0347a]

CVE-2022-50052: ASoC: Intel: avs: Fix potential buffer overflow by snprintf()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50052

Introduced by commit f1b3b32 ("ASoC: Intel: avs: Generic soc component
driver") in v5.19-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca3b7b9dc9bc1fa552f4697b7cccfa0258a44d00]

CVE-2022-50053: iavf: Fix reset error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50053

Introduced by commit f0db789 ("i40evf: use netdev variable in reset
task") in v4.14-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31071173771e079f7bc08dacd61e0db913262fbf]
stable/5.15: [743dc4377bbac06a6fe44c3c5baf75a49439678a]

CVE-2022-50054: iavf: Fix NULL pointer dereference in iavf_get_link_ksettings

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50054

Introduced by commit 209f2f9 ("iavf: Add support for
VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation") in v5.17-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [541a1af451b0cb3779e915d48d08efb17915207b]

CVE-2022-50055: iavf: Fix adminq error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50055

Introduced by commit d358aa9 ("i40evf: init code and hardware
support") in v3.14-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [419831617ed349992c84344dbd9e627f9e68f842]
stable/5.10: [4fe80492d53971d9a49f39f3c86d2d67c6f3638a]
stable/5.15: [dab6b551f5ba4c79a0dd4970dd8533c37a7b100f]
stable/5.4: [ff289f2be5899efd0e897d2b434a78e36df2c69b]

CVE-2022-50056: fs/ntfs3: Fix missing i_op in ntfs_read_mft

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50056

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37a530bfe56ca9a0d3129598803f2794c7428aae]
stable/5.15: [c293e8abc09e6e1faa50d967bd8862b1cbd575e5]

CVE-2022-50057: fs/ntfs3: Fix NULL deref in ntfs_update_mftmirr

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50057

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [321460ca3b55f48b3ba6008248264ab2bd6407d9]
stable/5.15: [8e8e1a84dac7a3d2b432162a70d7fb6a75960772]

CVE-2022-50058: vdpa_sim_blk: set number of address spaces and virtqueue groups

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50058

Introduced by commit bda324f ("vdpasim: control virtqueue support") in
v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19cd4a5471b8eaa4bd161b0fdb4567f2fc88d809]

CVE-2022-50059: ceph: don't leak snap_rwsem in handle_cap_grant

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50059

Introduced by commit 6f05b30 ("ceph: reset i_requested_max_size if
file write is not wanted") in v5.8-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58dd4385577ed7969b80cdc9e2a31575aba6c712]
stable/5.10: [aee18421bda6bf12a7cba6a3d7751c0e1cfd0094]
stable/5.15: [f546faa216d0f53a42ca73ba1fd8c48765b22d77]

CVE-2022-50060: octeontx2-af: Fix mcam entry resource leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50060

Introduced by commit c554f9c ("octeontx2-af: Teardown NPA, NIX LF upon
receiving FLR") in v5.0-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f8fe40ab7730cf8eb6f8b8ff412012f7f6f8f48]
stable/5.15: [dc5be2d4f9285efe0d16f1bf00250df91d05d809]

CVE-2022-50061: pinctrl: nomadik: Fix refcount leak in
nmk_pinctrl_dt_subnode_to_map

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50061

Introduced by commit c2f6d05 ("pinctrl: nomadik: refactor DT parser to
take two paths") in v3.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f498542bc703bf1e5c6a1610e1ea493a437f0196]
cip/4.4-st: [18b951abfce733a479d872429d63ea689a34fbac]
mainline: [4b32e054335ea0ce50967f63a7bfd4db058b14b9]
stable/4.19: [f498542bc703bf1e5c6a1610e1ea493a437f0196]
stable/5.10: [78d05103891d3e96144b846fbc39f2cfb3384eae]
stable/5.15: [9272265f2f76629e1a67e6d49b3a4461b3da1a73]
stable/5.4: [c26012a1e61c7bbd1b393d3bbae8dffdb6df65bb]

CVE-2022-50062: net: bgmac: Fix a BUG triggered by wrong bytes_compl

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50062

Introduced by commit b38c83d ("bgmac: simplify tx ring index
handling") in v4.1-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b7680c6c1f6de9904f1d9b05c952f0c64a03350]
stable/5.10: [ab2b55bb25db289ba0b68e3d58494476bdb1041d]
stable/5.15: [c506c9a97120f43257e9b3ce7b1f9a24eafc3787]
stable/5.4: [ac6d4482f29ab992b605c1b4bd1347f1f679f4e4]

CVE-2022-50063: net: dsa: felix: suppress non-changes to the tagging protocol

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50063

Introduced by commit 7a29d22 ("net: dsa: felix: reimplement tagging
protocol change with function pointers") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c46bb49460ee14c69629e813640d8b929e88941]

CVE-2022-50064: virtio-blk: Avoid use-after-free on suspend/resume

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50064

Introduced by commit 4e04005 ("virtio-blk: support polling I/O") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d12ec10292877751ee4463b11a63bd850bc09b5]

CVE-2022-50065: virtio_net: fix memory leak inside XPD_TX with mergeable

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50065

Introduced by commit 44fa2db ("xdp: transition into using xdp_frame
for ndo_xdp_xmit") in v4.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a542bee27c6a57e45c33cbbdc963325fd6493af]
stable/5.10: [faafa2a87f697ee537c29446097e1cc3143506fa]
stable/5.15: [d3723eab11196475ef83279571b2b0bd0924cf82]

CVE-2022-50066: net: atlantic: fix aq_vec index out of range error

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50066

Introduced by commit 97bde5c ("net: ethernet: aquantia: Support for
NIC-specific code") in v4.11-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ba5e47fb75fbb8fab45f5c1bc8d5c33d8834bd3]
stable/5.10: [df60c534d4c5a681172952dd4b475a5d818b3a86]
stable/5.15: [422a02a771599cac96f2b2900d993e0bb7ba5b88]

CVE-2022-50067: btrfs: unset reloc control if transaction commit fails
in prepare_to_relocate()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50067

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc2.


Fixed status
cip/4.19-st: [dcb11fe0a0a9cca2b7425191b9bf30dc29f2ad0f]
cip/4.4-st: [0b3b6eea93e2ed35071c10edbaf02ca7508265d6]
mainline: [85f02d6c856b9f3a0acf5219de6e32f58b9778eb]
stable/4.19: [dcb11fe0a0a9cca2b7425191b9bf30dc29f2ad0f]
stable/5.10: [b60e862e133f646f19023ece1d476d630a660de1]
stable/5.15: [78f8c2370e3d33e35f23bdc648653d779aeacb6e]
stable/5.4: [8e546674031fc1576da501e27a8fd165222e5a37]

CVE-2022-50068: drm/ttm: Fix dummy res NULL ptr deref bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50068

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc2.


Fixed status
mainline: [cf4b7387c0a842d64bdd7c353e6d3298174a7740]
stable/5.15: [76672cd326c146ded2c2712ff257b8908dcf23d8]

CVE-2022-50069: BPF: Fix potential bad pointer dereference in bpf_sys_bpf()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50069

Introduced by commit af2ac3e ("bpf: Prepare bpf syscall to be used
from kernel and user space.") in v5.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2dcac2f58f5a95ab092d1da237ffdc0da1832cf]
stable/5.15: [41fd6cc88aaf7058b9dfc9c7a09cc80f99c8c830]

CVE-2022-50070: mptcp: do not queue data on closed subflows

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50070

Introduced by commit d5f4919 ("mptcp: allow picking different xmit
subflows") in v5.10-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c886d70286bf3ad411eb3d689328a67f7102c6ae]

CVE-2022-50071: mptcp: move subflow cleanup in mptcp_destroy_common()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50071

Introduced by commit e16163b ("mptcp: refactor shutdown and close") in
v5.11-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0bf3c6aa444a5ef44acc57ef6cfa53fd4fc1c9b]

CVE-2022-50072: NFSv4/pnfs: Fix a use-after-free bug in open

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50072

Introduced by commit 6949493 ("NFSv4: Don't hold the layoutget locks
across multiple RPC calls") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [0fffb46ff3d5ed4668aca96441ec7a25b793bd6f]
mainline: [2135e5d56278ffdb1c2e6d325dc6b87f669b9dac]
stable/4.19: [0fffb46ff3d5ed4668aca96441ec7a25b793bd6f]
stable/5.10: [76ffd2042438769298f34b76102b40dea89de616]
stable/5.15: [a4cf3dadd1fa43609f7c6570c9116b0e0a9923d1]
stable/5.4: [f7ee3b772d9de87387a725caa04bc041ac7fe5ec]

CVE-2022-50073: net: tap: NULL pointer derefence in
dev_parse_header_protocol when skb->dev is null

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50073

Introduced by commit 924a9bc ("net: check if protocol extracted by
virtio_net_hdr_set_proto is correct") in v5.12-rc3.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [4f61f133f354853bc394ec7d6028adb9b02dd701]

CVE-2022-50074: apparmor: Fix memleak in aa_simple_write_to_buffer()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50074

Introduced by commit a6a5257 ("apparmor: split load data into
management struct and data blob") in v4.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6500eb3a48ac221051b1791818a1ac74744ef617]
mainline: [417ea9fe972d2654a268ad66e89c8fcae67017c3]
stable/4.19: [6500eb3a48ac221051b1791818a1ac74744ef617]
stable/5.10: [8aab4295582eb397a125d2788b829fa62b88dbf7]
stable/5.15: [bf7ebebce2c25071c719fd8a2f1307e0c243c2d7]
stable/5.4: [7db182a2ebeefded86fea542fcc5d6a68bb77f58]

CVE-2022-50075: tracing/eprobes: Have event probes be consistent with
kprobes and uprobes

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50075

Introduced by commit 7491e2c ("tracing: Add a probe that attaches to
trace events") in v5.15-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a832ec3d680b3a4f4fad5752672827d71bae501]
stable/5.15: [b489aca082a23033a3d8355cfb0032f0e2523440]

CVE-2022-50076: cifs: Fix memory leak on the deferred close

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50076

Introduced by commit 9e99275 ("cifs: Call close synchronously during
unlink/rename/lease break.") in v5.14-rc6.
Introduced by commit e3fc065 ("cifs: Deferred close performance
improvements") in v5.15-rc3.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca08d0eac020d48a3141dbec0a3cf64fbdb17cde]
stable/5.15: [860efae127888ae535bc4eda1b7f27642727c69e]

CVE-2022-50077: apparmor: fix reference count leak in aa_pivotroot()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50077

Introduced by commit 2ea3ffb ("apparmor: add mount mediation") in v4.14-rc2.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f4d5c7796571624e3f380b447ada52834270a287]
mainline: [11c3627ec6b56c1525013f336f41b79a983b4d46]
stable/4.19: [f4d5c7796571624e3f380b447ada52834270a287]
stable/5.10: [2ceeb3296e9dde1d5772348046affcefdea605e2]
stable/5.15: [64103ea357734b82384c925cba4758fdb909be0c]
stable/5.4: [ef6fb6f0d0d8440595b45a7e53c6162c737177f4]

CVE-2022-50078: tracing/eprobes: Do not allow eprobes to use $stack,
or % for regs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50078

Introduced by commit 7491e2c ("tracing: Add a probe that attaches to
trace events") in v5.15-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2673c60ee67e71f2ebe34386e62d348f71edee47]
stable/5.15: [ba53c21ce9773743b8e0a8ada048c96ff2d55c67]

CVE-2022-50079: drm/amd/display: Check correct bounds for stream
encoder instances for DCN303

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50079

Introduced by commit cd6d421 ("drm/amd/display: Initial DC support for
Beige Goby") in v5.14-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89b008222c2bf21e50219725caed31590edfd9d1]
stable/5.15: [82a27c1855445d48aacc67b0c0640f3dadebe52f]

CVE-2022-50080: tee: add overflow check in register_shm_helper()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50080

Introduced by commit 033ddf1 ("tee: add register user memory") in v4.16-rc1.
Fixed in v6.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b37e0f17653c00b586cdbcdf0dbca475358ecffd]
mainline: [573ae4f13f630d6660008f1974c0a8a29c30e18a]
stable/4.19: [b37e0f17653c00b586cdbcdf0dbca475358ecffd]
stable/5.10: [578c349570d2a912401963783b36e0ec7a25c053]
stable/5.15: [c12f0e6126ad223806a365084e86370511654bf1]
stable/5.4: [965333345fe952cc7eebc8e3a565ffc709441af2]

CVE-2022-50081: [REJECTED]: KVM: Unconditionally get a ref to /dev/kvm
module when creating a VM

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50081

This CVE was rejected. Introduced by commit 5f6de5c ("KVM: Prevent
module exit until all VMs are freed") in v5.18-rc1.
Fixed in v6.0-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [405294f29faee5de8c10cb9d4a90e229c2835279]
stable/5.15: [177bf354200962c6f0de6dd37c86a9bf3b54003a]

CVE-2022-50082: ext4: fix warning in ext4_iomap_begin as race between
bmap and write

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50082

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [51ae846cff568c8c29921b1b28eb2dfbcd4ac12d]
stable/5.10: [e1682c7171a6c0ff576fe8116b8cba5b8f538b94]
stable/5.15: [30dfb75e1f8645404a536c74d468d498adcd4e74]

CVE-2022-50083: ext4: add EXT4_INODE_HAS_XATTR_SPACE macro in xattr.h

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50083

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [0e69cf833161b29b2e25dcbf2f2b4e70d75b15cf]
cip/4.4-st: [1a117d0c2cb488f372c3bf8a322f0af5cff2b1e9]
mainline: [179b14152dcb6a24c3415200603aebca70ff13af]
stable/4.19: [0e69cf833161b29b2e25dcbf2f2b4e70d75b15cf]
stable/5.10: [2da44a2927a71bff2bc66cefa8cfbd2ace702536]
stable/5.15: [e6321fda51e5b4dd7ec295afb84cbf63c2634c7b]
stable/5.4: [748d17d47687e178f8e38938447fa4636c071c41]

CVE-2022-50084: dm raid: fix address sanitizer warning in raid_status

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50084

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [b856ce5f4b55f752144baf17e9d5c415072652c5]
mainline: [1fbeea217d8f297fe0e0956a1516d14ba97d0396]
stable/4.19: [b856ce5f4b55f752144baf17e9d5c415072652c5]
stable/5.10: [49dba30638e091120256a9e89125340795f034dc]
stable/5.15: [4c233811a49578634d10a5e70a9dfa569d451e94]
stable/5.4: [cb583ca6125ac64c98e9d65128e95ebb5be7d322]

CVE-2022-50085: dm raid: fix address sanitizer warning in raid_resume

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50085

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [3bfdc95466f5be4d8d95db5a5b470d61641a7c24]
mainline: [7dad24db59d2d2803576f2e3645728866a056dab]
stable/4.19: [3bfdc95466f5be4d8d95db5a5b470d61641a7c24]
stable/5.10: [c2d47bef93fb74aa97d90f9a40ca657b8f376083]
stable/5.15: [50235d9a1f1f742619ed9963cb9f240e5b821d46]
stable/5.4: [71f601c779b3cc1baf497796f5b922c3fe5d2a1e]

CVE-2022-50086: block: don't allow the same type rq_qos add more than once

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50086

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [14a6e2eb7df5c7897c15b109cba29ab0c4a791b6]
stable/5.15: [0b7f5d7a4d2a72ad9de04ab8ccba2a31904aa638]

CVE-2022-50087: firmware: arm_scpi: Ensure scpi_info is not assigned
if the probe fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50087

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [5aa558232edc30468d1f35108826dd5b3ffe978f]
mainline: [689640efc0a2c4e07e6f88affe6d42cd40cc3f85]
stable/4.19: [5aa558232edc30468d1f35108826dd5b3ffe978f]
stable/5.10: [08272646cd7c310642c39b7f54348fddd7987643]
stable/5.15: [0c29e149b6bb498778ed8a1c9597b51acfba7856]
stable/5.4: [18048cba444a7c41dbf42c180d6b46606fc24c51]

CVE-2022-50088: mm/damon/reclaim: fix potential memory leak in
damon_reclaim_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50088

Introduced by commit 4d69c34 ("mm/damon/reclaim: use
damon_select_ops() instead of damon_{v,p}a_set_operations()") in
v5.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [188043c7f4f2bd662f2a55957d684fffa543e600]

CVE-2022-50089: btrfs: ensure pages are unlocked on cow_file_range() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50089

Introduced by commit 42c0110 ("btrfs: zoned: introduce dedicated data
write path for zoned filesystems") in v5.12-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ce7466f372d83054c7494f6b3e4b9abaf3f0355]
stable/5.15: [b367f125c80fa838eae49e3b138dc67dfc9f46ef]

CVE-2022-50090: btrfs: replace BTRFS_MAX_EXTENT_SIZE with
fs_info->max_extent_size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50090

Introduced by commit d8e3fb1 ("btrfs: zoned: use ZONE_APPEND write for
zoned mode") in v5.12-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7b12a62f008a3041f42f2426983e59a6a0a3c59]
stable/5.15: [1aa262c1d056551dd1246115af8b7e351184deae]

CVE-2022-50091: locking/csd_lock: Change csdlock_debug from
early_param to __setup

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50091

Introduced by commit 8d0968c ("locking/csd_lock: Add boot parameter
for controlling CSD lock debugging") in v5.13-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c9b26b0df270d4f9246e483a44686fca951a29c]
stable/5.15: [d2cbdbe22b5f190055d2d0ae92e7454479343a30]

CVE-2022-50092: dm thin: fix use-after-free crash in
dm_sm_register_threshold_callback

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50092

Introduced by commit ac8c3f3 ("dm thin: generate event when metadata
threshold passed") in v3.10-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3534e5a5ed2997ca1b00f44a0378a075bd05e8a3]
stable/5.10: [5e2cf705155a1514be3c96ea664a9cd356998ee7]
stable/5.15: [f83131a3071a0b61a4d7dca70f95adb3ffad920e]
stable/5.4: [05cef0999b3208b5a6ede1bfac855139e4de55ef]

CVE-2022-50093: iommu/vt-d: avoid invalid memory access via
node_online(NUMA_NO_NODE)

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50093

Introduced by commit ee34b32 ("dmar: support for parsing Remapping
Hardware Static Affinity structure") in v2.6.33-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0b0b77ea611e3088e9523e60860f4f41b62b235]
stable/5.10: [5659efdadf04b56707d58c1b758df16d2e0eff2c]
stable/5.15: [0b4c0003aeda32a600f95df53b2848da8a5aa3fa]
stable/5.4: [b12304984654d8e58a2b22ff94c4410906d6267f]

CVE-2022-50094: spmi: trace: fix stack-out-of-bound access in SPMI
tracing functions

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50094

Introduced by commit a9fce37 ("spmi: add command tracepoints for
SPMI") in v4.3-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ac730c72bddc889f5610d51d8a7abf425e08da1a]
cip/4.4-st: [0b0a5aa074813c4af6d082d07139e4cb6b63a047]
mainline: [2af28b241eea816e6f7668d1954f15894b45d7e3]
stable/4.19: [ac730c72bddc889f5610d51d8a7abf425e08da1a]
stable/5.10: [dd02510fb43168310abfd0b9ccf49993a722fb91]
stable/5.15: [1e0ca3d809c36ad3d1f542917718fc22ec6316e7]
stable/5.4: [37690cb8662cec672cacda19e6e4fd2ca7b13f0b]

CVE-2022-50095: posix-cpu-timers: Cleanup CPU timers before freeing
them during exec

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50095

Introduced by commit 55e8c8e ("posix-cpu-timers: Store a reference to
a pid not a task") in v5.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e362359ace6f87c201531872486ff295df306d13]
stable/5.10: [541840859ace9c2ccebc32fa9e376c7bd3def490]
stable/5.15: [9e255ed238fc67058df87b0388ad6d4b2ef3a2bd]

CVE-2022-50096: x86/kprobes: Update kcb status flag after singlestepping

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50096

Introduced by commit 6256e66 ("x86/kprobes: Use int3 instead of debug
trap for single-step") in v5.13-rc1.
Fixed in v5.19.2.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [663cdda2716b70751df9c7e60b81bd0850fdfe3c]
stable/5.10: [edc2ac7c7265b33660fa0190898966b49966b855]
stable/5.15: [edc2ac7c7265b33660fa0190898966b49966b855]

CVE-2022-50097: video: fbdev: s3fb: Check the size of screen before memset_io()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50097

Introduced by commit a268422 ("fbdev driver for S3 Trio/Virge") in v2.6.21-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3c35a0dc2b4e7acf24c796043b64fa3eee799239]
mainline: [6ba592fa014f21f35a8ee8da4ca7b95a018f13e8]
stable/4.19: [3c35a0dc2b4e7acf24c796043b64fa3eee799239]
stable/5.10: [5e0da18956d38e7106664dc1d06367b22f06edd3]
stable/5.15: [ce50d94afcb8690813c5522f24cd38737657db81]
stable/5.4: [eacb50f1733660911827d7c3720f4c5425d0cdda]

CVE-2022-50098: scsi: qla2xxx: Fix crash due to stale SRB access
around I/O timeouts

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50098

Introduced by commit d745952 ("scsi: qla2xxx: Add multiple queue pair
functionality.") in v4.10-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c39587bc0abaf16593f7abcdf8aeec3c038c7d52]
stable/5.15: [b7bae3886a30d258b5b4fee26647043d68da3661]

CVE-2022-50099: video: fbdev: arkfb: Check the size of screen before memset_io()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50099

Introduced by commit 681e147 ("arkfb: new framebuffer driver for ARK
Logic cards") in v2.6.22-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [352305ea50d682b8e081d826da53caf9e744d7d0]
mainline: [96b550971c65d54d64728d8ba973487878a06454]
stable/4.19: [352305ea50d682b8e081d826da53caf9e744d7d0]
stable/5.10: [09e733d6ac948e6fda4b16252e44ea46f98fc8b4]
stable/5.15: [0701df594bc1d7ae55fed407fb65dd90a93f8a9c]
stable/5.4: [53198b81930e567ad6b879812d88052a1e8ac79e]

CVE-2022-50100: sched/core: Do not requeue task on CPU excluded from cpus_mask

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50100

Introduced by commit c6e7bd7 ("sched/core: Optimize ttwu() spinning on
p->on_cpu") in v5.8-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [751d4cbc43879229dbc124afefe240b70fd29a85]
stable/5.15: [748d2e9585ae53cb6be48e84f93d2f082ae1d135]

CVE-2022-50101: video: fbdev: vt8623fb: Check the size of screen
before memset_io()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50101

Introduced by commit 558b7bd ("vt8623fb: new framebuffer driver for
VIA VT8623") in v2.6.22-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [52ad9bfeb8a0e62de30de6d39e8a49a72dd78150]
mainline: [ec0754c60217248fa77cc9005d66b2b55200ac06]
stable/4.19: [52ad9bfeb8a0e62de30de6d39e8a49a72dd78150]
stable/5.10: [bd8269e57621e5b38cc0b4bd2fa02e85c9f2a441]
stable/5.15: [4a3cef1eaced13ba9b55381d46bfad937a3dac2c]
stable/5.4: [d71528ccdc7ae8d7500d414091d27805c51407a2]

CVE-2022-50102: video: fbdev: arkfb: Fix a divide-by-zero bug in
ark_set_pixclock()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50102

Introduced by commit 681e147 ("arkfb: new framebuffer driver for ARK
Logic cards") in v2.6.22-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b9a66f23612b84617e04412169e155a4b92f632d]
mainline: [2f1c4523f7a3aaabe7e53d3ebd378292947e95c8]
stable/4.19: [b9a66f23612b84617e04412169e155a4b92f632d]
stable/5.10: [0288fa799e273b08839037499d704dc7bdc13e9a]
stable/5.15: [236c1502520b7b08955467ec2e50b3232e34f1f9]
stable/5.4: [a249e1b89ca25e1c34bdf96154e3f6224a91a9af]

CVE-2022-50103: sched, cpuset: Fix dl_cpu_busy() panic due to empty
cs->cpus_allowed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50103

Introduced by commit 7f51412 ("sched/deadline: Fix bandwidth
check/update when migrating tasks between exclusive cpusets") in
v3.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6e8d40d43ae4dec00c8fea2593eeea3114b8f44]
stable/5.10: [336626564b58071b8980a4e6a31a8f5d92705d9b]
stable/5.15: [147f66d22f58712dce7ccdd6a1f6cb3ee8042df4]

CVE-2022-50104: powerpc/xive: Fix refcount leak in xive_get_max_prio

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50104

Introduced by commit eac1e73 ("powerpc/xive: guest exploitation of the
XIVE interrupt controller") in v4.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f658d5b528ce97a68efbb64ee54f6fe0909b189a]
mainline: [255b650cbec6849443ce2e0cdd187fd5e61c218c]
stable/4.19: [f658d5b528ce97a68efbb64ee54f6fe0909b189a]
stable/5.10: [6d1e53f7f181a11a8a343def1e0d0209905b7c64]
stable/5.15: [ea494e8a9852abd0ba60f69b254ce0d7c38449e2]
stable/5.4: [d99733ad47a6c990b52e136608455643bfa708f2]

CVE-2022-50105: powerpc/spufs: Fix refcount leak in spufs_init_isolated_loader

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50105

Introduced by commit 0afacde ("[POWERPC] spufs: allow isolated mode
apps by starting the SPE loader") in v2.6.20.16.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d0cb99948c5f6d8fe56f6e69b8dd0a05ee5f9cec]
mainline: [6ac059dacffa8ab2f7798f20e4bd3333890c541c]
stable/4.19: [d0cb99948c5f6d8fe56f6e69b8dd0a05ee5f9cec]
stable/5.10: [85aff6a9b7b7ec4e5c319f7946c9864c8d5e3d4a]
stable/5.15: [69e9fa07b229badab808980e984a9fe824116f00]
stable/5.4: [14329d29a048dc35aac2374fb3d588d8190095a2]

CVE-2022-50106: powerpc/cell/axon_msi: Fix refcount leak in
setup_msi_msg_address

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50106

Introduced by commit ce21b3c ("[CELL] add support for MSI on
Axon-based Cell systems") in v2.6.23-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [51cf876b11fb6ca06f69e9d1de58f892d1522e9d]
mainline: [df5d4b616ee76abc97e5bd348e22659c2b095b1c]
stable/4.19: [51cf876b11fb6ca06f69e9d1de58f892d1522e9d]
stable/5.10: [00dc7cbbb558955ff410fd392cc9b0366eb06df0]
stable/5.15: [5eaa93caa63abf382b319dbe2f032232026740c2]
stable/5.4: [f388643657cd5a04dc47a68d85321876c5b4c208]

CVE-2022-50107: cifs: Fix memory leak when using fscache

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50107

Introduced by commit 0174ee9 ("cifs: Implement cache I/O by accessing
the cache directly") in v5.17-rc3.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6f62f81b488d00afaa86bae26c6ce9ab12c709e]

CVE-2022-50108: mfd: max77620: Fix refcount leak in max77620_initialise_fps

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50108

Introduced by commit 327156c ("mfd: max77620: Add core driver for
MAX77620/MAX20024") in v4.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1520669c8255bd637c6b248b2be910e2688d38dd]
stable/5.10: [afdbadbf18c19779d7bc5df70d872924f9bbd76b]
stable/5.15: [facd31bbc799f4d0cd25d9d688af7ca41e7f38ee]
stable/5.4: [b948ff8a9e9ad46d4dff9127777caa14c8c2b53c]

CVE-2022-50109: video: fbdev: amba-clcd: Fix refcount leak bugs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50109

Introduced by commit d10715b ("video: ARM CLCD: Add DT support") in v3.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [a97ff8a949dbf41be89f436b2b1a2b3d794493df]
mainline: [26c2b7d9fac42eb8317f3ceefa4c1a9a9170ca69]
stable/4.19: [a97ff8a949dbf41be89f436b2b1a2b3d794493df]
stable/5.10: [da276dc288bf838ea0fd778b5441ec0f601c69f7]
stable/5.15: [29f06f1905c312671a09ee85ca92ac04a1d9f305]
stable/5.4: [49a4c1a87ef884e43cdda58b142a2a30f2f09efc]

CVE-2022-50110: watchdog: sp5100_tco: Fix a memory leak of EFCH MMIO resource

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50110

Introduced by commit 0578fff ("Watchdog: sp5100_tco: Add
initialization using EFCH MMIO") in v5.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [c6d9c0798ed366a09a9e53d71edcd2266e34a6eb]
stable/5.15: [84ddf527f90755beec6b55ce2e31331f5ccd4e37]

CVE-2022-50111: ASoC: mt6359: Fix refcount leak bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50111

Introduced by commit 6835302 ("ASoC: mt6359: fix failed to parse DT
properties") in v5.10-rc1.
Introduced by commit eef07b9 ("ASoC: mediatek: mt6359: add MT6359
accdet jack driver") in v5.13-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8d5df69e2ec702d979f7d04ed519caf8691a032]
stable/5.15: [3d69d86b3e9d82f524e7e1906adcbbe939dc836e]

CVE-2022-50112: rpmsg: qcom_smd: Fix refcount leak in qcom_smd_parse_edge

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50112

Introduced by commit 53e2822 ("rpmsg: Introduce Qualcomm SMD backend")
in v4.9-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cb50423e46ea585620a6be307d7f7b71587936b7]
mainline: [65382585f067d4256ba087934f30f85c9b6984de]
stable/4.19: [cb50423e46ea585620a6be307d7f7b71587936b7]
stable/5.10: [9715809b9eeb85b3f9b083857a2f29a9e2351125]
stable/5.15: [ece6cfe62a103cc6032664983be557f1b5a1ff7e]
stable/5.4: [8ee5d40ae29e63f6fd6cbf9dcfc0a48c474013db]

CVE-2022-50113: ASoc: audio-graph-card2: Fix refcount leak bug in
__graph_get_type()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50113

Introduced by commit c8c7493 ("ASoC: audio-graph-card2: add Multi
CPU/Codec support") in v5.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eda26893dabfc6da7a1e1ff5f8628ed9faab3ab9]

CVE-2022-50114: net: 9p: fix refcount leak in p9_read_work() error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50114

Introduced by commit 728356d ("9p: Add refcount to p9_req_t") in v4.20-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [4ac7573e1f9333073fa8d303acc941c9b7ab7f61]
stable/5.15: [8324649b0035cbb30ebc3ca901540cb392e89041]

CVE-2022-50115: ASoC: SOF: ipc3-topology: Prevent double freeing of
ipc_control_data via load_bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50115

Introduced by commit b5cee8f ("ASoC: SOF: topology: Make control
parsing IPC agnostic") in v5.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5bd47f3ca124058a8e87eae4508afeda2132611]

CVE-2022-50116: tty: n_gsm: fix deadlock and link starvation in
outgoing data path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50116

Introduced by commit e1eaea4 ("tty: n_gsm line discipline") in v2.6.35-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0af021678d5d30c31f5a6b631f404ead3575212a]

CVE-2022-50117: vfio: Split migration ops from main device ops

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50117

Introduced by commit 6fadb02 ("vfio/mlx5: Implement vfio_pci driver
for mlx5 devices") in v5.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e97eba8ad8748fabb795cffc5d9e1a7dcfd7367]

CVE-2022-50118: powerpc/perf: Optimize clearing the pending PMI and
remove WARN_ON for PMI check in power_pmu_disable

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50118

Introduced by commit 2c9ac51 ("powerpc/perf: Fix PMU callbacks to
clear pending PMI before resetting an overflown PMC") in v5.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [890005a7d98f7452cfe86dcfb2aeeb7df01132ce]
stable/5.10: [875b2bf469d094754ac2ba9af91dcd529eb12bf6]
stable/5.15: [87b1a9175f08313f40fcb6d6dc536dbe451090eb]

CVE-2022-50119: rpmsg: Fix possible refcount leak in
rpmsg_register_device_override()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50119

Introduced by commit bb17d11 ("rpmsg: Fix calling device_lock() on
non-initialized device") in v5.19-rc1.
Fixed in v4.19.298.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [c449b28e437d18ae807479c4ac6b69d87b287c79]
stable/5.10: [3fdd5b2bb09fc2b5bf3504778f51c89bb48c097f]

CVE-2022-50120: remoteproc: imx_rproc: Fix refcount leak in imx_rproc_addr_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50120

Introduced by commit 6e962bf ("remoteproc: imx_rproc: add missing
of_node_put") in v5.13-rc1.
Introduced by commit a0ff4aa ("remoteproc: imx_rproc: add a
NXP/Freescale imx_rproc driver") in v4.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61afafe8b938bc74841cf4b1a73dd08b9d287c5a]
stable/5.15: [0dc1663e3fc22c72e1ab33be7701a0d51cca84ef]

CVE-2022-50121: remoteproc: k3-r5: Fix refcount leak in k3_r5_cluster_of_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50121

Introduced by commit 6dedbd1 ("remoteproc: k3-r5: Add a remoteproc
driver for R5F subsystem") in v5.10-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa220c05d282e7479abe08b54e3bdffd06c25e97]
stable/5.10: [75358732af9b26acfe3e609943290bcba13330fc]
stable/5.15: [cf112a52d758092ca3d5ebdad51dd17bda5ba3e5]

CVE-2022-50122: ASoC: mediatek: mt8173-rt5650: Fix refcount leak in
mt8173_rt5650_dev_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50122

Introduced by commit 0f83f92 ("ASoC: mediatek: Add machine driver for
ALC5650 codec") in v4.6-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e024a24fb264523149658c10c76bb363b3d0004d]
mainline: [efe2178d1a32492f99e7f1f2568eea5c88a85729]
stable/4.19: [e024a24fb264523149658c10c76bb363b3d0004d]
stable/5.10: [403d46971936f9f704b91cecffe66e44aa39e915]
stable/5.15: [994f2edeeb2114bb22b62741cb8fb030fc7e5441]
stable/5.4: [79f566907d27abbd7600cebe51def5081d5796b5]

CVE-2022-50123: ASoC: mediatek: mt8173: Fix refcount leak in
mt8173_rt5650_rt5676_dev_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50123

Introduced by commit 94319ba ("ASoC: mediatek: Use platform_of_node
for machine drivers") in v4.2-rc5.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fab5eb31819a2693b0c3d6f3df6a0d193af9a089]
mainline: [ae4f11c1ed2d67192fdf3d89db719ee439827c11]
stable/4.19: [fab5eb31819a2693b0c3d6f3df6a0d193af9a089]
stable/5.10: [aa1214ece37944e4dbbb5cfb1d02bf37e4d89b02]
stable/5.15: [540c7b7385fb110740703888b4b2bbfa06c7f79c]
stable/5.4: [d6d41f04640db0f946e2c3f7963bb2774afc7a0d]

CVE-2022-50124: ASoC: mt6797-mt6351: Fix refcount leak in
mt6797_mt6351_dev_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50124

Introduced by commit f0ab0bf ("ASoC: add mt6797-mt6351 driver and
config option") in v4.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1042353bb67cd1c9109d7481ea182c7794336458]
mainline: [7472eb8d7dd12b6b9b1a4f4527719cc9c7f5965f]
stable/4.19: [1042353bb67cd1c9109d7481ea182c7794336458]
stable/5.10: [a0381a9f3e595988e83bac4c4dd1e45ed2b3c744]
stable/5.15: [7dee72b1bcecb26bfff8d6360f2169f8656dbaf6]
stable/5.4: [b488ceb2336905f071f80627bc8a7d657274e5de]

CVE-2022-50125: ASoC: cros_ec_codec: Fix refcount leak in
cros_ec_codec_platform_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50125

Introduced by commit b6bc07d ("ASoC: cros_ec_codec: support WoV") in v5.5-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a034d93ee929a9ea89f3fa5f1d8492435b9ee6e]
stable/5.10: [bae95c5aee1f67da6608ceaebfb744d900e5ffbf]
stable/5.15: [1065c385325845c88350c765cc6e449f46741984]

CVE-2022-50126: jbd2: fix assertion 'jh->b_frozen_data == NULL'
failure when journal aborted

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50126

Introduced by commit 470decc ("[PATCH] jbd2: initial copy of files
from jbd") in v2.6.20.16.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6073389db83b903678a0920554fa19f5bdc51c48]
mainline: [4a734f0869f970b8a9b65062ea40b09a5da9dba8]
stable/4.19: [6073389db83b903678a0920554fa19f5bdc51c48]
stable/5.10: [f7161d0da975adc234161cd0641d0e484f5ce375]
stable/5.15: [e62f79827784f56499a50ea2e893c98317b5407b]
stable/5.4: [fa5b65d39332fef7a11ae99cb1f0696012a61527]

CVE-2022-50127: RDMA/rxe: Fix error unwind in rxe_create_qp()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50127

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1a63f24e724f677db1ab21251f4d0011ae0bb5b5]
mainline: [fd5382c5805c4bcb50fd25b7246247d3f7114733]
stable/4.19: [1a63f24e724f677db1ab21251f4d0011ae0bb5b5]
stable/5.10: [3ef491b26c720a87fcfbd78b7dc8eb83d9753fe6]
stable/5.15: [2ceeb04252e621c0b128ecc8fedbca922d11adba]
stable/5.4: [b348e204a53103f51070513a7494da7c62ecbdaa]

CVE-2022-50128: [REJECTED]: android: binder: stop saving a pointer to the VMA

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50128

This CVE was rejected. Introduced by commit da1b956 ("android: binder:
fix the race mmap and alloc_new_buf_locked") in v4.19-rc4.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a43cfc87caaf46710c8027a8c23b8a55f1078f19]
stable/5.15: [622ef885a89ad04cfb76ee478fb44f051125d1f1]

CVE-2022-50129: RDMA/srpt: Fix a use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50129

Introduced by commit a42d985 ("ib_srpt: Initial SRP Target merge for
v3.3-rc1") in v3.3-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5605148e6ce36bb21020d49010b617693933128]
stable/5.10: [de95b52d9aabc979166aba81ccbe623aaf9c16a1]
stable/5.15: [e60d7e2462bf57273563c4e00dbfa79ee973b9e2]

CVE-2022-50130: staging: fbtft: core: set smem_len before
fb_deferred_io_init call

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50130

Introduced by commit 856082f ("fbdev: defio: fix the pagelist
corruption") in v5.19-rc1.
Fixed in v5.19.2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [6ae6abe240306f878557d6eadd950a2e2561f59f]

CVE-2022-50131: HID: mcp2221: prevent a buffer overflow in mcp_smbus_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50131

Introduced by commit 67a95c2 ("HID: mcp2221: add usb to i2c-smbus host
bridge") in v5.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62ac2473553a00229e67bdf3cb023b62cf7f5a9a]
stable/5.10: [66c8e816f2f2ca4a61b406503bd10bad1b35f72f]
stable/5.15: [91443c669d280937968f0aa4edefa741cfe35314]

CVE-2022-50132: usb: cdns3: change place of 'priv_ep' assignment in
cdns3_gadget_ep_dequeue(), cdns3_gadget_ep_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50132

Introduced by commit 7733f6c ("usb: cdns3: Add Cadence USB3 DRD
Driver") in v5.4-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3ffc9c4ca44bfe9562166793d133e1fb0630ea6]
stable/5.10: [7af83bb516d7aa4f96835288e4aeda21d7aa2a17]
stable/5.15: [bfa0201468587072454dba7933e4a4a7be44467a]

CVE-2022-50133: usb: xhci_plat_remove: avoid NULL dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50133

Introduced by commit 4736ebd ("usb: host: xhci-plat: omit shared hcd
if either root hub has no ports") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7de14d74d6551f0d097430f9893ce82ad17e5b8]

CVE-2022-50134: RDMA/hfi1: fix potential memory leak in setup_base_ctxt()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50134

Introduced by commit e87473b ("IB/hfi1: Only set fd pointer when base
context is completely initialized") in v4.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [90ef48a718f88935d4af53d7dadd1ceafe103ce6]
mainline: [aa2a1df3a2c85f855af7d54466ac10bd48645d63]
stable/4.19: [90ef48a718f88935d4af53d7dadd1ceafe103ce6]
stable/5.10: [a85c7dd1edadcdeca24e603a6618153a3bcc81ca]
stable/5.15: [e25b828553aecb3185a8d8d0c4f9b4e133fb5db6]
stable/5.4: [2f90813f1c21c3d780585390af961bd17c8515ae]

CVE-2022-50135: RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in rxe_qp_do_cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50135

Introduced by commit 4703b4f ("RDMA/rxe: Enforce IBA C11-17") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37da51efe6eaa0560f46803c8c436a48a2084da7]

CVE-2022-50136: RDMA/siw: Fix duplicated reported
IW_CM_EVENT_CONNECT_REPLY event

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50136

Introduced by commit 6c52fdc ("rdma/siw: connection management") in v5.3-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3056fc6c32e613b760422b94c7617ac9a24a4721]
stable/5.10: [9ade92ddaf2347fb34298c02080caaa3cdd7c27b]
stable/5.15: [f6e26e1a5f600b760dc32135d3fac846eabe09e7]
stable/5.4: [11edf0bba15ea9df49478affec7974f351bb2f6e]

CVE-2022-50137: RDMA/irdma: Fix a window for use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50137

Introduced by commit b48c24c ("RDMA/irdma: Implement device supported
verb APIs") in v5.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ecef7890b3aea78c8bbb501a4b5b8134367b821]
stable/5.15: [92520864ef9f912f38b403d172a0ded020683d55]

CVE-2022-50138: RDMA/qedr: Fix potential memory leak in __qedr_alloc_mr()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50138

Introduced by commit e0290cc ("qedr: Add support for memory
registeration verbs") in v4.9-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3236a64ddd125a455ef5b5316c1b9051b732974]
stable/5.10: [79ce50dddaf28b5c57911ecc80a2be17a0b17f83]
stable/5.15: [7e647a8d5fc0a2c8e0f36f585a6388286a25bb15]

CVE-2022-50139: usb: aspeed-vhub: Fix refcount leak bug in ast_vhub_init_desc()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50139

Introduced by commit 30d2617 ("usb: gadget: aspeed: allow to set usb
strings in device tree") in v5.8-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [220fafb4ed04187e9c17be4152da5a7f2ffbdd8c]
stable/5.10: [e6db5780c2bf6e23be7b315809ef349b4b4f2213]
stable/5.15: [4070f3c83cd28267f469a59751480ad39435f26a]

CVE-2022-50140: memstick/ms_block: Fix a memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50140

Introduced by commit 0ab3049 ("memstick: add support for legacy
memorysticks") in v3.12-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [37958980eb4cd71ae594ace093c11b6a91e165e8]
mainline: [54eb7a55be6779c4d0c25eaf5056498a28595049]
stable/4.19: [37958980eb4cd71ae594ace093c11b6a91e165e8]
stable/5.10: [9260a154b3b5e387dbceec7c0ac441470646bc6f]
stable/5.15: [961d7d12080fe70847f944d656e36cd0dd0214ba]
stable/5.4: [9d8b911fe3c3ed788c66edba7c90e32a4a7a5f53]

CVE-2022-50141: mmc: sdhci-of-esdhc: Fix refcount leak in
esdhc_signal_voltage_switch

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50141

Introduced by commit ea35645 ("mmc: sdhci-of-esdhc: add support for
signal voltage switch") in v4.12-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [547db1dd98d1815574ebea7358015a17199a93bc]
mainline: [b5899a3e2f783a27b268e38d37f9b24c71bddf45]
stable/4.19: [547db1dd98d1815574ebea7358015a17199a93bc]
stable/5.10: [b305475df756256a186623f0991d05a816de881a]
stable/5.15: [352377cf74710bc3368dddf78f17210dfe456933]
stable/5.4: [4c472a2c9ed6ea9d272268d7f484d4303c549f1a]

CVE-2022-50142: intel_th: msu: Fix vmalloced buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50142

Introduced by commit ba39bd8 ("intel_th: msu: Switch over to
scatterlist") in v5.2-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac12ad3ccf6d386e64a9d6a890595a2509d24edd]
stable/5.10: [6ae2881c1d1fa0e33f4763b7c786f8ef05a9c828]
stable/5.15: [566887bad7ff2297d6b3f9659c702ba075f3d62d]
stable/5.4: [b5d924cb4c7b952eaa61622f14427723a78137a3]

CVE-2022-50143: intel_th: Fix a resource leak in an error handling path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50143

Introduced by commit 7b7036d ("intel_th: pci: Use MSI interrupt
signalling") in v5.2-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [086c28ab7c5699256aced0049aae9c42f1410313]
stable/5.10: [a8f3b78b1f8e959d06801ae82149f140a75724e8]
stable/5.15: [9b5469573a274729bdb04b60a8d71f8d09940a31]
stable/5.4: [859342220accd0d332864fafbf4e3d2d0492bc3f]

CVE-2022-50144: soundwire: revisit driver bind/unbind and callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50144

Introduced by commit 56d4fe3 ("soundwire: Add MIPI DisCo property
helpers") in v4.16-rc1.
Introduced by commit 528be50 ("soundwire: sdw_slave: add
probe_complete structure and new fields") in v5.6-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd29c00edd0a5dac8b6e7332bb470cd50f92e893]
stable/5.15: [250b46505175889c6b5958c3829f610f52199f5f]

CVE-2022-50145: dmaengine: sf-pdma: Add multithread support for a DMA channel

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50145

Introduced by commit 6973886 ("dmaengine: sf-pdma: add platform DMA
support for HiFive Unleashed A00") in v5.5-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2cc5c465c2cb8ab697c3fd6583c614e3f6cfbcc]
stable/5.10: [b9b4992f897be9b0b9e3a3b956cab6b75ccc3f11]
stable/5.15: [5ab2782c944e324008ef5d658f2494a9f0e3c5ac]

CVE-2022-50146: PCI: dwc: Deallocate EPC memory on dw_pcie_ep_init() errors

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50146

Introduced by commit 2fd0c9d ("PCI: designware-ep: Pre-allocate memory
for MSI in dw_pcie_ep_init") in v4.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8161e9626b50892eaedbd8070ecb1586ecedb109]
stable/5.10: [e7599a5974d4c64eaae8009c3f2e47b9e3223e07]
stable/5.15: [b03a8f1264ea8c363bec9ef6e37b467f27cb04ea]

CVE-2022-50147: mm/mempolicy: fix get_nodes out of bound access

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50147

Introduced by commit e130242 ("mm: simplify compat numa syscalls") in v5.15-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [000eca5d044d1ee23b4ca311793cf3fc528da6c6]
stable/5.15: [44652154484e7e3d12008802cfb6c28a8aa16d85]

CVE-2022-50148: kernfs: fix potential NULL dereference in __kernfs_remove

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50148

Introduced by commit 393c371 ("kernfs: switch global kernfs_rwsem lock
to per-fs lock") in v5.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72b5d5aef246a0387cefa23121dd90901c7a691a]

CVE-2022-50149: driver core: fix potential deadlock in __driver_attach

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50149

Introduced by commit ef0ff68 ("driver core: Probe devices
asynchronously instead of the driver") in v5.1-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70fe758352cafdee72a7b13bf9db065f9613ced8]
stable/5.10: [a93f33aeef4e6a94ae9c9d3f5b2f9085ad0572ec]
stable/5.15: [733ab0c19bf17f6ad7c2b580ede006e369d5ab1b]
stable/5.4: [8191b6cd9ada09b675f17446d5872eb1f77685cb]

CVE-2022-50150: [REJECTED]: mwifiex: fix sleep in atomic context bugs
caused by dev_coredumpv

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50150

This CVE was rejected. Introduced by commit f5ecd02 ("mwifiex: device
dump support for usb interface") in v4.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a52ed4866d2b90dd5e4ae9dabd453f3ed8fa3cbc]
stable/5.10: [956b79c2066551845d7124b01c5845d02ccf47a1]
stable/5.15: [a78b882c1a9feda10821a25201a0464674f8209e]

CVE-2022-50151: usb: cdns3: fix random warning message when driver load

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50151

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [8659ab3d936fcf0084676f98b75b317017aa8f82]
stable/5.15: [8e142744f0e96abc69ccd99e6d6c7eb662267f21]

CVE-2022-50152: usb: ohci-nxp: Fix refcount leak in ohci_hcd_nxp_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50152

Introduced by commit 73108aa ("USB: ohci-nxp: Use isp1301 driver") in v3.5-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4db00c2fa6f8c9876a7e20511dccf43b50be9006]
mainline: [302970b4cad3ebfda2c05ce06c322ccdc447d17e]
stable/4.19: [4db00c2fa6f8c9876a7e20511dccf43b50be9006]
stable/5.10: [d35903e9650f4fa79426ce390db8678dbf5ac432]
stable/5.15: [59026d5cc615da28e0c9806a71bf07065c906464]
stable/5.4: [65d36ec409b635dfc2f95f0d7c5877c9d0cb7630]

CVE-2022-50153: usb: host: Fix refcount leak in ehci_hcd_ppc_of_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50153

Introduced by commit 796bcae ("USB: powerpc: Workaround for the
PPC440EPX USBH_23 errata [take 3]") in v2.6.29-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [038453b17fe30ea38f0f3c916e2ae2b7f8cef84e]
mainline: [b5c5b13cb45e2c88181308186b0001992cb41954]
stable/4.19: [038453b17fe30ea38f0f3c916e2ae2b7f8cef84e]
stable/5.10: [585d22a5624ef2b540c337665c72fea8cd33db50]
stable/5.15: [c0a4b454486b23bb4d94ce49f490830ecc354040]
stable/5.4: [8cbc3870ff356366842af3228dd8e7bc278e5edd]

CVE-2022-50154: PCI: mediatek-gen3: Fix refcount leak in
mtk_pcie_init_irq_domains()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50154

Introduced by commit 814ccee ("PCI: mediatek-gen3: Add INTx support")
in v5.13-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf038503d5fe90189743124233fe7aeb0984e961]
stable/5.15: [0675fe20da7fa69b1ba80c23470c1433a2356c03]

CVE-2022-50155: mtd: parsers: ofpart: Fix refcount leak in
bcm4908_partitions_fw_offset

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50155

Introduced by commit bb17230 ("mtd: parsers: ofpart: support BCM4908
fixed partitions") in v5.13-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e607879b0da18c451de5e91daf239cc2f2f8ff2d]
stable/5.15: [762475464982b15014f364ec0cf2a843407f5af1]

CVE-2022-50156: HID: cp2112: prevent a buffer overflow in cp2112_xfer()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50156

Introduced by commit 542134c ("HID: cp2112: Fix I2C_BLOCK_DATA
transactions") in v4.15-rc6.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3af7d60e9a6c17d6d41c4341f8020511887d372d]
mainline: [381583845d19cb4bd21c8193449385f3fefa9caf]
stable/4.19: [3af7d60e9a6c17d6d41c4341f8020511887d372d]
stable/5.10: [ebda3d6b004bb6127a66a616524a2de152302ca7]
stable/5.15: [8489a20ac481b08c0391608d81ed3796d373cfdf]
stable/5.4: [519ff31a6ddd87aa4905bd9bf3b92e8b88801614]

CVE-2022-50157: PCI: microchip: Fix refcount leak in mc_pcie_init_irq_domains()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50157

Introduced by commit 6f15a9c ("PCI: microchip: Add Microchip PolarFire
PCIe controller driver") in v5.12-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f030304fdeb87ec8f1b518c73703214aec6cc24a]
stable/5.15: [c0ad5c7e68d10f6f8ffb0f4329e3c19404fbca58]

CVE-2022-50158: mtd: partitions: Fix refcount leak in parse_redboot_of

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50158

Introduced by commit 2379608 ("mtd: partitions: redboot: seek
fis-index-block in the right node") in v5.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [9f7e62815cf3cbbcb1b8cb21649fb4dfdb3aa016]
stable/5.10: [55d0f7da66dec93c4d53d0886a1555618079a900]
stable/5.15: [8ea607579d300b2f7fc997f3dd20949114565fcd]
stable/5.4: [f3cc27198c5d78cdda60a55ae749f815cd1fe5eb]

CVE-2022-50159: of: check previous kernel's ima-kexec-buffer against
memory bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50159

Introduced by commit 467d278 ("powerpc: ima: get the kexec buffer
passed by the previous kernel") in v4.10-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbf9c4b9617b6767886a913705ca14b7600c77db]
stable/5.15: [beb5bba5dd132650c073f815c685c60c3e5b783b]

CVE-2022-50160: mtd: maps: Fix refcount leak in ap_flash_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50160

Introduced by commit b0afd44 ("mtd: physmap_of: add a hook for
Versatile write protection") in v4.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d10855876a6f47add6ff621cef25cc0171dac162]
mainline: [77087a04c8fd554134bddcb8a9ff87b21f357926]
stable/4.19: [d10855876a6f47add6ff621cef25cc0171dac162]
stable/5.10: [941ef6997f9db704fe4fd62fc01e420fdd5048b2]
stable/5.15: [d5730780e9ea84e5476752a47c749036c6a74af5]
stable/5.4: [80b1465b2ae81ebb59bbe62bcb7a7f7d4e9ece6f]

CVE-2022-50161: mtd: maps: Fix refcount leak in of_flash_probe_versatile

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50161

Introduced by commit b0afd44 ("mtd: physmap_of: add a hook for
Versatile write protection") in v4.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [79e57889aa0d92a6d769bad808fb105e7b6ea495]
mainline: [33ec82a6d2b119938f26e5c8040ed5d92378eb54]
stable/4.19: [79e57889aa0d92a6d769bad808fb105e7b6ea495]
stable/5.10: [52ae2b14f76ef2d490337ddc0037bc37125be7b8]
stable/5.15: [4d67c8f74d804b20febf716ec96e9a475457ec60]
stable/5.4: [9124d51e01232a91da4034768a2a8d1688472179]

CVE-2022-50162: wifi: libertas: Fix possible refcount leak in if_usb_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50162

Introduced by commit ce84bb6 ("libertas USB: convert to asynchronous
firmware loading") in v3.5-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4c8e2f9ce1428e44cb103035eeced7aeb6b80980]
mainline: [6fd57e1d120bf13d4dc6c200a7cf914e6347a316]
stable/4.19: [4c8e2f9ce1428e44cb103035eeced7aeb6b80980]
stable/5.10: [97e5d3e46a3a2100253a9717a4df98d68aeb10b8]
stable/5.15: [d7365590d15bbd9008f424ef043d1778ffe29f42]
stable/5.4: [878e7f39803a9ab5bb9766956a7a04351d4bf99d]

CVE-2022-50163: ax25: fix incorrect dev_tracker usage

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50163

Introduced by commit feef318 ("ax25: fix UAF bugs of net_device caused
by rebinding operation") in v5.17-rc4.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [d7c4c9e075f8cc6d88d277bc24e5d99297f03c06]

CVE-2022-50164: wifi: iwlwifi: mvm: fix double list_add at
iwl_mvm_mac_wake_tx_queue

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50164

Introduced by commit cfbc6c4 ("iwlwifi: mvm: support mac80211 TXQs
model") in v5.1-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14a3aacf517a9de725dd3219dbbcf741e31763c4]
stable/5.10: [38d71acc15a2e72806b516380af0adb3830d4639]
stable/5.15: [4a40af2b0b9517fca7ae2a030c9c0a16836303c0]
stable/5.4: [5cca5f714fe6cedd2df9d8451ad8df21e6464f62]

CVE-2022-50165: wifi: wil6210: debugfs: fix uninitialized variable use
in `wil_write_file_wmi()`

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50165

Introduced by commit 7a48365 ("wifi: wil6210: debugfs: fix info leak
in wil_write_file_wmi()") in v6.0-rc1.
Introduced by commit ff974e4 ("wil6210: debugfs interface to send raw
WMI command") in v3.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [c9fde3a44da566d8929070ab6bda4f0dfa9955d0]
mainline: [d578e0af3a003736f6c440188b156483d451b329]
stable/4.19: [c9fde3a44da566d8929070ab6bda4f0dfa9955d0]
stable/5.10: [6c5fee83bdbeffe8d607d1ab125122a75f40bd1a]
stable/5.15: [689e5caf63e99e15d2f485ec297c1bf9243e0e28]
stable/5.4: [52b11a48cf073e0aab923ae809a765d756cecf13]

CVE-2022-50166: Bluetooth: When HCI work queue is drained, only queue
chained work

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50166

Introduced by commit 76727c0 ("Bluetooth: Call drain_workqueue()
before resetting state") in v3.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [877afadad2dce8aae1f2aad8ce47e072d4f6165e]

CVE-2022-50167: bpf: fix potential 32-bit overflow when accessing
ARRAY map element

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50167

Introduced by commit c85d691 ("bpf: move memory size checks to
bpf_map_charge_init()") in v5.3-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87ac0d600943994444e24382a87aa19acc4cd3d4]

CVE-2022-50168: bpf, x86: fix freeing of not-finalized bpf_prog_pack

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50168

Introduced by commit 1022a54 ("bpf, x86_64: Use
bpf_jit_binary_pack_alloc") in v5.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d5f82d9dd477d5c66e0214a68c3e4f308eadd6d]

CVE-2022-50169: wifi: wil6210: debugfs: fix info leak in wil_write_file_wmi()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50169

Introduced by commit ff974e4 ("wil6210: debugfs interface to send raw
WMI command") in v3.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4615458db7793fadc6d546ac3564b36819e77a22]
mainline: [7a4836560a6198d245d5732e26f94898b12eb760]
stable/4.19: [4615458db7793fadc6d546ac3564b36819e77a22]
stable/5.10: [05ceda14ef7c73104e709c414c3680d8a59f51d4]
stable/5.15: [074e865b37da55aa87baa16d68b96896f85f8adb]
stable/5.4: [60c9983425167ec5073c628d83a6875760d18059]

CVE-2022-50170: kunit: executor: Fix a memory leak on failure in
kunit_filter_tests

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50170

Introduced by commit a02353f ("kunit: bail out of test filtering logic
quicker if OOM") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94681e289bf5d10c9db9db143d1a22d8717205c5]

CVE-2022-50171: crypto: hisilicon/sec - don't sleep when in softirq

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50171

Introduced by commit 416d822 ("crypto: hisilicon - add HiSilicon SEC
V2 driver") in v5.5-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02884a4f12de11f54d4ca67a07dd1f111d96fdbd]
stable/5.10: [16e18a8ac7c9748cf35a8d2f0ba2c6e8850e7568]
stable/5.15: [aa495dfe71229b9034b59d8072ff0b2325ddd5ee]

CVE-2022-50172: mt76: mt76x02u: fix possible memory leak in
__mt76x02u_mcu_send_msg

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50172

Introduced by commit 4c89ff2 ("mt76: split __mt76u_mcu_send_msg and
mt76u_mcu_send_msg routines") in v4.20-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cffd93411575afd987788e2ec3cb8eaff70f0215]
stable/5.10: [3ad958bc488e3ecb0207d31621c00efb86f17482]
stable/5.15: [f1609c4f4a21777e081b36596224802b85052ad9]

CVE-2022-50173: drm/msm/mdp5: Fix global state lock backoff

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50173

Introduced by commit d59be57 ("drm/msm/mdp5: Return error code in
mdp5_pipe_release when deadlock is detected") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
cip/4.19-st: [247f2934324f9a18d18df24ea4bfcc7d4631d0ef]
mainline: [92ef86ab513593c6329d04146e61f9a670e72fc5]
stable/4.19: [247f2934324f9a18d18df24ea4bfcc7d4631d0ef]
stable/5.10: [bf386c955f35a0a01bef482b6035d40ff2f6cc75]
stable/5.15: [f4e3a8c7e890049e7ba2b49ad0315dae841dfa55]
stable/5.4: [2e34d6c8180a398de6448a93df25068bf3062042]

CVE-2022-50174: net: hinic: avoid kernel hung in hinic_get_stats64()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50174

Introduced by commit edd384f ("net-next/hinic: Add ethtool and stats")
in v4.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98f9fcdee35add80505b6c73f72de5f750d5c03c]
stable/5.10: [e74f3097a9c713ce855cda07713393bcc23a005d]
stable/5.15: [693f31dc91568e61047fd2980a8235e856cd9ce8]

CVE-2022-50175: media: tw686x: Fix memory leak in tw686x_video_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50175

Introduced by commit 704a84c ("[media] media: Support
Intersil/Techwell TW686x-based video capture cards") in v4.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0b212ec9d8177d6f7c404315293f6a085d6ee42]
stable/5.10: [611f86965df013d6021e6cd0d155b1734ad2cf21]
stable/5.15: [0597bcf774896a002edcc7934a9cdbb932b66702]

CVE-2022-50176: drm/mcde: Fix refcount leak in mcde_dsi_bind

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50176

Introduced by commit 5fc537b ("drm/mcde: Add new driver for
ST-Ericsson MCDE") in v5.3-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a149169e4a2f9127022fec6ef5d71b4e804b3b9]
stable/5.10: [f57699a9b66ea11f000f56d1f1179059239b8690]
stable/5.15: [3123ae6fdd4013d24a3a4877084b14e917faae5c]
stable/5.4: [87c35bbefdfa3c5edfb8c80f5c04717aaacc629d]

CVE-2022-50177: rcutorture: Fix ksoftirqd boosting timing and iteration

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50177

Introduced by commit ea6d962 ("rcutorture: Judge RCU priority boosting
on grace periods, not callbacks") in v5.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3002153a91a9732a6d1d0bb95138593c7da15743]
stable/5.15: [621595f771a6bd458ffbc40679e222ba5d0a7a1e]

CVE-2022-50178: wifi: rtw89: 8852a: rfk: fix div 0 exception

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50178

Introduced by commit e3ec701 ("rtw89: add Realtek 802.11ax driver") in
v5.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [683a4647a7a3044868cfdc14c117525091b9fa0c]

CVE-2022-50179: ath9k: fix use-after-free in ath9k_hif_usb_rx_cb

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50179

Introduced by commit fb9987d ("ath9k_htc: Support for AR9271
chipset.") in v2.6.35-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ab7a0ddf5f1cdec63cb21840369873806fc36d80]
mainline: [0ac4827f78c7ffe8eef074bc010e7e34bc22f533]
stable/4.19: [ab7a0ddf5f1cdec63cb21840369873806fc36d80]
stable/5.10: [eccd7c3e2596b574241a7670b5b53f5322f470e5]
stable/5.15: [03ca957c5f7b55660957eda20b5db4110319ac7a]
stable/5.4: [e9e21206b8ea62220b486310c61277e7ebfe7cec]

CVE-2022-50180: [REJECTED]: wifi: iwlegacy: 4965: fix potential
off-by-one overflow in il4965_rs_fill_link_cmd()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50180

This CVE was rejected. Introduced by commit be663ab ("iwlwifi: split
the drivers for agn and legacy devices 3945/4965") in v2.6.39-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [20be29b99dfed089fe7b8698cd18dfdda6049bd7]
mainline: [a8eb8e6f7159c7c20c0ddac428bde3d110890aa7]
stable/4.19: [20be29b99dfed089fe7b8698cd18dfdda6049bd7]
stable/5.10: [e7d6cac6967534e1298497e853964b3d3f994ce3]
stable/5.15: [88b551561ded10017dd846c8aeb2296a5119a915]
stable/5.4: [73304c7594080362107bea4c0c3b7da2fb134cc4]

CVE-2022-50181: virtio-gpu: fix a missing check to avoid NULL dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50181

Introduced by commit 62fb7a5 ("virtio-gpu: add 3d/virgl support") in v4.4-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd63f11f4c3c46afec07d821f74736161ff6e526]
stable/5.10: [259773fc874258606c0121767a4a27466ff337eb]
stable/5.15: [39caef09666c1d8274abf9472c72bcac236dc5fb]

CVE-2022-50182: media: imx-jpeg: Align upwards buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50182

Introduced by commit 2db16c6 ("media: imx-jpeg: Add V4L2 driver for
i.MX8 JPEG Encoder/Decoder") in v5.13-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e7aa76cdb02923ee23a0ddd48f38bdc3512f92b]
stable/5.15: [9ae2d729de6350c53a06c57782751d84eb2c08d9]

CVE-2022-50183: drm/meson: encoder_cvbs: Fix refcount leak in
meson_encoder_cvbs_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50183

Introduced by commit 318ba02 ("drm/meson: encoder_cvbs: switch to
bridge with ATTACH_NO_CONNECTOR") in v5.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d255ddbbf679aa47e041cbf68520fd985ed2279]

CVE-2022-50184: drm/meson: encoder_hdmi: Fix refcount leak in
meson_encoder_hdmi_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50184

Introduced by commit e67f603 ("drm/meson: split out encoder from
meson_dw_hdmi") in v5.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d82a5a4aae9d0203234737caed1bf470aa317568]
stable/5.15: [275fed7142fff5b27e176e53508196715043de5c]

CVE-2022-50185: drm/radeon: fix potential buffer overflow in
ni_set_mc_special_registers()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50185

Introduced by commit 69e0b57 ("drm/radeon/kms: add dpm support for
cayman (v5)") in v3.11-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1f341053852be76f82610ce47a505d930512f05c]
mainline: [136f614931a2bb73616b292cf542da3a18daefd5]
stable/4.19: [1f341053852be76f82610ce47a505d930512f05c]
stable/5.10: [8508d6d23a247c29792ce2fc0df3f3404d6a6a80]
stable/5.15: [deb603c5928e546609c0d5798e231d0205748943]
stable/5.4: [db1a9add3f90ff1c641974d5bb910c16b87af4ef]

CVE-2022-50186: ath11k: fix missing skb drop on htc_tx_completion error

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50186

Introduced by commit f951380 ("ath11k: Disabling credit flow for WMI
path") in v5.17-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5646fe3b7ef739c392e59da7db6adf5e1fdef42]

CVE-2022-50187: ath11k: fix netdev open race

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50187

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Introduced by commit 840c36f ("ath11k: dp: stop rx pktlog before
suspend") in v5.11-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [d4ba1ff87b17e81686ada8f429300876f55f95ad]
stable/5.10: [a2c45f8c3d18269e641f0c7da2dde47ef8414034]
stable/5.15: [eaff3946a86fc63280a30158a4ae1e141449817c]

CVE-2022-50188: drm/meson: Fix refcount leak in meson_encoder_hdmi_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50188

Introduced by commit 0af5e0b ("drm/meson: encoder_hdmi: switch to
bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR") in v5.17-rc1.
Fixed in v5.19.2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [bfcca6234b2a36d213f0cc1c127becc17680f7df]

CVE-2022-50189: tools/power turbostat: Fix file pointer leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50189

Introduced by commit eae97e0 ("tools/power turbostat: Support thermal
throttle count print") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e5fd36c58d6c820f7292ee492c3731c9a104a41]

CVE-2022-50190: spi: Fix simplification of devm_spi_register_controller

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50190

Introduced by commit 59ebbe4 ("spi: simplify
devm_spi_register_controller") in v5.13-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43cc5a0afe4184a7fafe1eba32b5a11bb69c9ce0]
stable/5.15: [445fb9c19cf45bd9472fd9babaa31c5e6c7d2720]

CVE-2022-50191: regulator: of: Fix refcount leak bug in
of_get_regulation_constraints()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50191

Introduced by commit 40e20d6 ("regulator: of: Add support for parsing
regulator_state for suspend state") in v3.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b9ca8585c766616563cf3c062c6878f61f83cf00]
mainline: [66efb665cd5ad69b27dca8571bf89fc6b9c628a4]
stable/4.19: [b9ca8585c766616563cf3c062c6878f61f83cf00]
stable/5.10: [332e555dca074c4eb2084898021c3676423814c3]
stable/5.15: [c9df8ff290097aabd5c9200f7f729b0813d37b19]
stable/5.4: [35f9e861d9b9434903a8ede37a3561f78985826d]

CVE-2022-50192: spi: tegra20-slink: fix UAF in tegra_slink_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50192

Introduced by commit 26c8634 ("spi: tegra20-slink: Don't use
resource-managed spi_register helper") in v5.15-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e9984d183bb1e99e766c5c2b950ff21f7f7b6c0]
stable/5.15: [415b4ce61308f24583912d887772dfcbf97f1d20]

CVE-2022-50193: erofs: wake up all waiters after z_erofs_lzma_head ready

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50193

Introduced by commit 622cead ("erofs: lzma compression support") in v5.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2df7c4bd7c1d2bc5ece5e9ed19dbd386810c2a65]

CVE-2022-50194: soc: qcom: aoss: Fix refcount leak in
qmp_cooling_devices_register

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50194

Introduced by commit 05589b3 ("soc: qcom: Extend AOSS QMP driver to
support resources that are used to wake up the SoC.") in v5.4-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6e0951414a314e7db3e9e24fd924b3e15515288]
stable/5.10: [97713ed9b6cc4abaa2dcc8357113c56520dc6d7f]
stable/5.15: [053543ac1d095132fcfd1263805d6e25afbdc6a8]
stable/5.4: [bc73c72a856c26df7410ddf15f42257cb4960fe9]

CVE-2022-50195: ARM: dts: qcom: replace gcc PXO with pxo_board fixed clock

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50195

Introduced by commit 40cf5c8 ("ARM: dts: qcom: add L2CC and RPM for
IPQ8064") in v5.14-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eb9e93937756a05787977875830c0dc482cb57e0]

CVE-2022-50196: soc: qcom: ocmem: Fix refcount leak in of_get_ocmem

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50196

Introduced by commit 88c1e94 ("soc: qcom: add OCMEM driver") in v5.5-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92a563fcf14b3093226fb36f12e9b5cf630c5a5d]
stable/5.10: [07aea6819d569d1e172227486655e4fb5bd4cdb9]
stable/5.15: [84a928b44cb303d5756e3bff2734921de8dce4f6]

CVE-2022-50197: cpufreq: zynq: Fix refcount leak in zynq_get_revision

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50197

Introduced by commit 00f7dc6 ("ARM: zynq: Add support for SOC_BUS") in
v3.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [dcbb974254d2a27240c2e50185afdde90f923feb]
mainline: [d1ff2559cef0f6f8d97fba6337b28adb10689e16]
stable/4.19: [dcbb974254d2a27240c2e50185afdde90f923feb]
stable/5.10: [22e6d8bcde8e66b64f46bf9bd2d3d0f88d40c39f]
stable/5.15: [179034fb108e3655142f2af0c309cef171c34d68]
stable/5.4: [a530fa52d4fdffc5f010f90c05ac63019b8ff5f8]

CVE-2022-50198: ARM: OMAP2+: Fix refcount leak in omap3xxx_prm_late_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50198

Introduced by commit 1e03779 ("ARM: OMAP3+: PRM: register interrupt
information from DT") in v3.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c9ec7993d00250a394d367c8a19fcfe8211c258b]
mainline: [942228fbf5d4901112178b93d41225be7c0dd9de]
stable/4.19: [c9ec7993d00250a394d367c8a19fcfe8211c258b]
stable/5.10: [d294d60dc68550fee0fbbe8a638d798dcd40b2c5]
stable/5.15: [1bf747824a8ca4008879fd7d2ce6b03d7b428858]
stable/5.4: [c4f92af7fc8cecb8eb426ad187e39c7bcc6679c7]

CVE-2022-50199: ARM: OMAP2+: Fix refcount leak in omapdss_init_of

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50199

Introduced by commit e0c827a ("drm/omap: Populate DSS children in
omapdss driver") in v4.20-rc3.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9705db1eff38d6b9114121f9e253746199b759c9]
stable/5.10: [14bac0c7035bf920e190a63c7e1b113c72eadbf4]
stable/5.15: [230ad40a59c9a9ee8f3822b9a7bec09404102ebc]
stable/5.4: [935035cf97c8cd6794044b500fb0a44a6d30ffa1]

CVE-2022-50200: selinux: Add boundary check in put_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50200

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [477722f31ad73aa779154d1d7e00825538389f76]
mainline: [15ec76fb29be31df2bccb30fc09875274cba2776]
stable/4.19: [477722f31ad73aa779154d1d7e00825538389f76]
stable/5.10: [adbfdaacde18faf6cd4e490764045375266b3fbd]
stable/5.15: [7363a69d8ca8f0086f8e1196c8ddaf0e168614b1]
stable/5.4: [90bdf50ae70c5571a277b5601e4f5df210831e0a]

CVE-2022-50201: selinux: fix memleak in security_read_state_kernel()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50201

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [73de1befcc53a7c68b0c5e76b9b5ac41c517760f]
stable/5.15: [c877c5217145bda8fd95f506bf42f8d981afa57d]

CVE-2022-50202: PM: hibernate: defer device probing when resuming from
hibernation

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50202

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [5a283b59bce72c05c60e9f0fa92a28b5b850d8bb]
mainline: [8386c414e27caba8501119948e9551e52b527f59]
stable/4.19: [5a283b59bce72c05c60e9f0fa92a28b5b850d8bb]
stable/5.10: [003a456ae6f70bb97e436e02fc5105be577c1570]
stable/5.15: [2f0e18e0db42f4f8bc87d3d98333680065ceeff8]
stable/5.4: [3c48d3067eaf878642276f053575a5c642600a50]

CVE-2022-50203: ARM: OMAP2+: display: Fix refcount leak bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50203

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [0b4f96b47ff8dc2fa35d03c4116927248796d9af]
mainline: [50b87a32a79bca6e275918a711fb8cc55e16d739]
stable/4.19: [0b4f96b47ff8dc2fa35d03c4116927248796d9af]
stable/5.10: [88d556029a78999b098d26a330bb6a7de166f426]
stable/5.15: [a89a865dc9f0600fd146224e314775b9efc9d845]
stable/5.4: [3e505298a75f0bbdc96e923e76e5d45d6c8f64a7]

CVE-2022-50204: ARM: OMAP2+: pdata-quirks: Fix refcount leak bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50204

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [5cdbab96bab314c6f2f5e4e8b8a019181328bf5f]
stable/5.15: [75f23d72b6e0a34c8a0e8d275b69ba1e6dd0f15f]

CVE-2022-50205: ext2: Add more validity checks for inode counts

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50205

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [07303a9abe3a997d9864fb4315e34b5acfe8fc25]
mainline: [fa78f336937240d1bc598db817d638086060e7e9]
stable/4.19: [07303a9abe3a997d9864fb4315e34b5acfe8fc25]
stable/5.10: [d08bb199a406424a8ed0009efdf41710e6d849ee]
stable/5.15: [96b18d3a1be0354ccce43f0ef61b5a3d7e432552]
stable/5.4: [b3f423683818cfe15de14d5d9dff44148ff16bbf]

CVE-2022-50206: arm64: fix oops in concurrently setting insn_emulation sysctls

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50206

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [b51881b1da57fe9877125dfdd0aac5172958fcfd]
mainline: [af483947d472eccb79e42059276c4deed76f99a6]
stable/4.19: [b51881b1da57fe9877125dfdd0aac5172958fcfd]
stable/5.10: [353b4673d01c512303c45cf2346f630cda73b5c9]
stable/5.15: [cc69ef95988b9ef2fc730ec452a7441efb90ef5e]
stable/5.4: [04549063d5701976034d8c2bfda3d3a8cbf0409f]

CVE-2022-50207: ARM: bcm: Fix refcount leak in bcm_kona_smc_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50207

Introduced by commit b8eb35f ("ARM: bcm281xx: Add L2 cache enable
code") in v3.10-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [75866df2b1d673df5b7781e565ada753a7895f04]
mainline: [cb23389a2458c2e4bfd6c86a513cbbe1c4d35e76]
stable/4.19: [75866df2b1d673df5b7781e565ada753a7895f04]
stable/5.10: [91e7f04f53e680bc72f0a9a5c682ab652100b9c8]
stable/5.15: [bc7f487395f208fd9af69e9a807815e10435aba7]
stable/5.4: [5afe042c889437de83f38a9d73d145742fb4f65f]

CVE-2022-50208: soc: amlogic: Fix refcount leak in meson-secure-pwrc.c

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50208

Introduced by commit b3dde50 ("soc: amlogic: Add support for Secure
power domains controller") in v5.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d18529a4c12f66d83daac78045ea54063bd43257]
stable/5.10: [80c469e63bfa9a5a8114952bffc6a7d241e7497e]
stable/5.15: [f370fbbd3151c1c87d1e976c8964cb6cc46f2e00]

CVE-2022-50209: meson-mx-socinfo: Fix refcount leak in meson_mx_socinfo_init

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50209

Introduced by commit 5e68c0f ("soc: amlogic: Add
Meson6/Meson8/Meson8b/Meson8m2 SoC Information driver") in v4.15-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [69a64c77aafcf3c772264a36214937514e31ad82]
mainline: [a2106f38077e78afcb4bf98fdda3e162118cfb3d]
stable/4.19: [69a64c77aafcf3c772264a36214937514e31ad82]
stable/5.10: [2691b8780f88e1b8b3578a5bc78a0011741bbd74]
stable/5.15: [e21744c6a0d4116a2d6ebccd947620ca4c952e92]
stable/5.4: [6b28bf3e044f12db0fc18c42f58ae7fc3fa0144a]

CVE-2022-50210: MIPS: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50210

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [4cb392956ae392aec4aa06e661a0bb9146b0bace]
mainline: [e1a534f5d074db45ae5cbac41d8912b98e96a006]
stable/4.19: [4cb392956ae392aec4aa06e661a0bb9146b0bace]
stable/5.10: [807adf6ffa8c3beedcd63b20f5a59c7d061df7d2]
stable/5.15: [e41db8a9ce696a3382a4f098878fd4d14bccd201]
stable/5.4: [274e44e2123417e0924c90d4b4531913b5f3aa2e]

CVE-2022-50211: md-raid10: fix KASAN warning

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50211

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [7a6ccc8fa192fd357c2d5d4c6ce67c834a179e23]
cip/4.4-st: [b503cf1b56e574b0d4b5f5dda2621b73eed4b40a]
mainline: [d17f744e883b2f8d13cca252d71cfe8ace346f7d]
stable/4.19: [7a6ccc8fa192fd357c2d5d4c6ce67c834a179e23]
stable/5.10: [5fd4ffa2372a41361d2bdd27ea5730e4e673240c]
stable/5.15: [0f4d18cbea4a6e37a05fd8ee2887439f85211110]
stable/5.4: [ce839b9331c11780470f3d727b6fe3c2794a4620]

CVE-2022-50212: netfilter: nf_tables: do not allow CHAIN_ID to refer
to another table

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50212

Introduced by commit 837830a ("netfilter: nf_tables: add
NFTA_RULE_CHAIN_ID attribute") in v5.9-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95f466d22364a33d183509629d0879885b4f547e]
stable/5.10: [9e7dcb88ec8e85e4a8ad0ea494ea2f90f32d2583]
stable/5.15: [91501513016903077f91033fa5d2aa26cac399b2]

CVE-2022-50213: netfilter: nf_tables: do not allow SET_ID to refer to
another table

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50213

Introduced by commit 958bee1 ("netfilter: nf_tables: use new
transaction infrastructure to handle sets") in v3.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [77d3b5038b7462318f5183e2ad704b01d57215a2]
mainline: [470ee20e069a6d05ae549f7d0ef2bdbcee6a81b2]
stable/4.19: [77d3b5038b7462318f5183e2ad704b01d57215a2]
stable/5.10: [1a4b18b1ff11ba26f9a852019d674fde9d1d1cff]
stable/5.15: [faafd9286f1355c76fe9ac3021c280297213330e]
stable/5.4: [fab2f61cc3b0e441b1749f017cfee75f9bbaded7]

CVE-2022-50214: coresight: Clear the connection field properly

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50214

Introduced by commit 37ea1ff ("coresight: Use fwnode handle instead of
device names") in v5.3-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2af89ebacf299b7fba5f3087d35e8a286ec33706]
stable/5.10: [847b9273dd61567fb77617eabc5fa002594db062]
stable/5.15: [b49b29ee113a87997bcca0bb0585bb46582846c1]
stable/5.4: [e9205d8dd1cafb7cff689ef9ddf06276a68f54a4]

CVE-2022-50215: scsi: sg: Allow waiting for commands to complete on
removed device

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50215

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [ed9afd967cbfe7da2dc0d5e52c62a778dfe9f16b]
cip/4.4-st: [a65285d5a19e63a00148df1c1815ffd4057a39a5]
mainline: [3455607fd7be10b449f5135c00dc306b85dc0d21]
stable/4.19: [ed9afd967cbfe7da2dc0d5e52c62a778dfe9f16b]
stable/5.10: [408bfa1489a3cfe7150b81ab0b0df99b23dd5411]
stable/5.15: [8c004b7dbb340c1e5889f5fb9e5baa6f6e5303e8]
stable/5.4: [f135c65085eed869d10e4e7923ce1015288618da]

CVE-2022-50216: [REJECTED]: md-raid: destroy the bitmap after
destroying the thread

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50216

This CVE was rejected. Introduced by commit 48df498 ("md: move
bitmap_destroy to the beginning of __md_stop") in v4.12-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e151db8ecfb019b7da31d076130a794574c89f6f]
stable/5.10: [e0bdaed154e5b9cc4310ddaf5da290483d00e6ba]
stable/5.15: [c5e4cdd4438787e008c1b4a23bb66e49f4b12417]

CVE-2022-50217: fuse: write inode in fuse_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50217

Introduced by commit 36ea233 ("fuse: write inode in fuse_vma_close()
instead of fuse_release()") in v5.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [035ff33cf4db101250fb980a3941bf078f37a544]

CVE-2022-50218: iio: light: isl29028: Fix the warning in isl29028_remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50218

Introduced by commit 2db5054 ("staging: iio: isl29028: add runtime
power management support") in v4.11-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [359f3b150eab30805fe0e4e9d616887d7257a625]
mainline: [06674fc7c003b9d0aa1d37fef7ab2c24802cc6ad]
stable/4.19: [359f3b150eab30805fe0e4e9d616887d7257a625]
stable/5.10: [fb1888205c0782f287e5dd4ffff1f665332e868c]
stable/5.15: [fac589fb764699a4bcd288f6656b8cd0408ea968]
stable/5.4: [ed43fb20d3d1fca9d79db0d5faf4321a4dd58c23]

CVE-2022-50219: bpf: Fix KASAN use-after-free Read in compute_effective_progs

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50219

Introduced by commit af6eea5 ("bpf: Implement bpf_link-based cgroup
BPF program attachment") in v5.7-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c46091ee985ae84c60c5e95055d779fcd291d87]
stable/5.10: [3527e3cbb84d8868c4d4e91ba55915f96d39ec3d]
stable/5.15: [1f8ca9c40e6222ce431e9ba5dae3cccce8ef9443]

CVE-2022-50220: usbnet: Fix linkwatch use-after-free on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50220

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [7f77dcbc030c2faa6d8e8a594985eeb34018409e]
cip/4.4-st: [0c2a9da968f25d5e1e20fbe68febe018c4c1195e]
mainline: [a69e617e533edddf3fa3123149900f36e0a6dc74]
stable/4.19: [7f77dcbc030c2faa6d8e8a594985eeb34018409e]
stable/5.10: [135199a2edd459d2b123144efcd7f9bcd95128e4]
stable/5.15: [635fd8953e4309b54ca6a81bed1d4a87668694f4]
stable/5.4: [8b4588b8b00b299be16a35be67b331d8fdba03f3]

CVE-2022-50221: drm/fb-helper: Fix out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50221

Introduced by commit 67b723f ("drm/fb-helper: Calculate damaged area
in separate helper") in v5.18-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae25885bdf59fde40726863c57fd20e4a0642183]

CVE-2022-50222: tty: vt: initialize unicode screen buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50222

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
cip/4.19-st: [e02fa87e572bb7d90dcdbce9c0f519f1eb992e96]
mainline: [af77c56aa35325daa2bc2bed5c2ebf169be61b86]
stable/4.19: [e02fa87e572bb7d90dcdbce9c0f519f1eb992e96]
stable/5.10: [5c6c65681f39bf71bc72ed589dec3b8b20e75cac]
stable/5.15: [446f123aa6021e5f75a20789f05ff3f7ae51a42f]
stable/5.4: [cc9e874dace0c89ae535230c7da19b764746811e]

CVE-2022-50223: LoongArch: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50223

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [28e112afa44ad0814120d41c68fa72372a2cd2c2]

CVE-2022-50224: KVM: x86/mmu: Treat NX as a valid SPTE bit for NPT

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50224

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.0-rc1.


Fixed status
mainline: [6c6ab524cfae0799e55c82b2c1d61f1af0156f8d]

CVE-2022-50225: riscv:uprobe fix SR_SPIE set/clear handling

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50225

Introduced by commit 7478408 ("riscv: Add uprobes supported") in v5.12-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dbe5829408bc1586f75b4667ef60e5aab0209c7]
stable/5.15: [c71e000db8536d27ec410abb3e314896a78b4f19]

CVE-2022-50226: crypto: ccp - Use kzalloc for sev ioctl interfaces to
prevent kernel memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50226

Introduced by commit 3810367 ("crypto: ccp: Use the stack and common
buffer for status commands") in v5.13-rc1.
Introduced by commit e799035 ("crypto: ccp: Implement SEV_PEK_CSR
ioctl command") in v4.16-rc1.
Introduced by commit 76a2b52 ("crypto: ccp: Implement
SEV_PDH_CERT_EXPORT ioctl command") in v4.16-rc1.
Introduced by commit d6112ea ("crypto: ccp - introduce SEV_GET_ID2
command") in v5.2-rc1.
Fixed in v6.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [13dc15a3f5fd7f884e4bfa8c011a0ae868df12ae]
stable/5.10: [4c5300f6f5e18b11c02a92f136e69b98fddba15e]
stable/5.15: [f2a920daa780956b987c14b9f23de7c3c8915bf2]

CVE-2022-50227: KVM: x86/xen: Initialize Xen timer only once

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50227

Introduced by commit 5363952 ("KVM: x86/xen: handle PV timers oneshot
mode") in v5.19-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af735db31285fa699384c649be72a9f32ecbb665]

CVE-2022-50228: KVM: SVM: Don't BUG if userspace injects an interrupt with GIF=0

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50228

Introduced by commit 219b65d ("KVM: SVM: Improve nested interrupt
injection") in v2.6.32-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [c3396c1c8b87510f2ac2a674948156577559d42d]
cip/4.4-st: [67703e09ca43617e95935f425f1143e2be7b20b7]
mainline: [f17c31c48e5cde9895a491d91c424eeeada3e134]
stable/4.19: [c3396c1c8b87510f2ac2a674948156577559d42d]
stable/5.10: [8bb683490278005b4caf61e22b0828a04d282e86]
stable/5.15: [6afe88fbb40eac3291a8728688d61fdc745d8008]
stable/5.4: [68e1313bb8809e8addcd9431f2bfea0e8ddbca80]

CVE-2022-50229: ALSA: bcd2000: Fix a UAF bug on the error path of probing

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50229

Introduced by commit b47a222 ("ALSA: MIDI driver for Behringer BCD2000
USB device") in v3.16-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5e7338f4dd92b2f8915a82abfa1dd3ad3464bea0]
cip/4.4-st: [bb231eae2e5693424b5b7e19a744d9a775ba1080]
mainline: [ffb2759df7efbc00187bfd9d1072434a13a54139]
stable/4.19: [5e7338f4dd92b2f8915a82abfa1dd3ad3464bea0]
stable/5.10: [348620464a5c127399ac09b266f494f393661952]
stable/5.15: [64ca7f50ad96c2c65ae390b954925a36eabe04aa]
stable/5.4: [05e0bb8c3c4dde3e21b9c1cf9395afb04e8b24db]

CVE-2022-50230: arm64: set UXN on swapper page tables

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50230

Introduced by commit 18107f8 ("arm64: Support execute-only permissions
with Enhanced PAN")
in 5.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9283e708a9b8529e7aafac9ab5c5c79a9fab8846]

CVE-2022-50231: crypto: arm64/poly1305 - fix a read out-of-bound

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50231

Introduced by commit f569ca1 ("crypto: arm64/poly1305 - incorporate
OpenSSL/CRYPTOGAMS NEON implementation") in v5.5-rc1.
Fixed in v6.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ae19d422c7da84b5f13bc08b98bd737a08d3a53]
stable/5.10: [3c77292d52b341831cb09c24ca4112a1e4f9e91f]
stable/5.15: [3d4c28475ee352c440b83484b72b1320ff76364a]

CVE-2022-50232: arm64: set UXN on swapper page tables

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50232

Introduced by commit 18107f8 ("arm64: Support execute-only permissions
with Enhanced PAN")
in 5.13-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3cee924bd855184d15bc4aa6088dcf8e2c1394c]
stable/5.15: [775871d4be0d75e219cca937af843a4a1b60489a]

CVE-2025-38005: dmaengine: ti: k3-udma: Add missing locking

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38005

Introduced by commit 25dcb5d ("dmaengine: ti: New driver for K3 UDMA")
in v5.6-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fca280992af8c2fbd511bc43f65abb4a17363f2f]
stable/5.10: [27e71fa08711e09d81e06a54007b362a5426fd22]
stable/5.15: [0ea0433f822ed0549715f7044c9cd1cf132ff7fa]
stable/6.1: [df5987e76a4ae4cbd705d81ab4b15ed232250a4a]
stable/6.12: [26e63b2fe30c61bd25981c6084f67a8af79945d0]
stable/6.6: [d87f1cddc592387359fde157cc4296556f6403c2]

CVE-2025-38006: net: mctp: Don't access ifa_index when missing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38006

Introduced by commit 583be98 ("mctp: Add device handling and netlink
interface") in v5.15-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f11cf946c0a92c560a890d68e4775723353599e1]
stable/6.12: [d4d1561d17eb72908e4489c0900d96e0484fac20]
stable/6.6: [acab78ae12c7fefb4f3bfe22e00770a5faa42724]

CVE-2025-38007: HID: uclogic: Add NULL check in uclogic_input_configured()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38007

Introduced by commit dd613a4 ("HID: uclogic: Correct devm device
reference for hidinput input_dev name") in v6.6-rc1.
Fixed in v6.15-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [bd07f751208ba190f9b0db5e5b7f35d5bb4a8a1e]
stable/6.1: [01b76cc8ca243fc3376b035aa326bbc4f03d384b]
stable/6.12: [94e7272b636a0677082e0604609e4c471e0a2caf]
stable/6.6: [ad6caaf29bc26a48b1241ce82561fcbcf0a75aa9]

CVE-2025-38008: mm/page_alloc: fix race condition in unaccepted memory handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38008

Introduced by commit dcdfdd4 ("mm: Add support for unaccepted memory")
in v6.5-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fefc075182275057ce607effaa3daa9e6e3bdc73]
stable/6.12: [74953f93f47a45296cc2a3fd04e2a3202ff3fa53]
stable/6.6: [98fdd2f612e949c652693f6df00442c81037776d]

CVE-2025-38009: wifi: mt76: disable napi on driver removal

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38009

Introduced by commit 2ac515a ("mt76: mt76x02: use napi polling for tx
cleanup") in v5.2-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78ab4be549533432d97ea8989d2f00b508fa68d8]
stable/5.10: [ff0f820fa5b99035b3c654dd531226d8d83aec5f]
stable/5.15: [ca5b213bf4b4224335a8131a26805d16503fca5f]
stable/6.1: [b892e830d1ea8c5475254b98827771f7366f1039]
stable/6.12: [2b81e76db3667d1f7f2ad44e9835cdaf8dea95a8]
stable/6.6: [5e700b06b970fc19e3a1ecb244e14785f3fbb8e3]

CVE-2025-38010: phy: tegra: xusb: Use a bitmask for UTMI pad power
state tracking

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38010

Introduced by commit a30951d ("xhci: tegra: USB2 pad power controls")
in v6.3-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b47158fb42959c417ff2662075c0d46fb783d5d1]
stable/6.12: [1db527f0cb8f677adadd4e28e5bc77aaf5d4e4c9]
stable/6.6: [ba25131b3c1ceec303839b2462586d7673788197]

CVE-2025-38011: drm/amdgpu: csa unmap use uninterruptible lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38011

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc7.


Fixed status
mainline: [a0fa7873f2f869087b1e7793f7fac3713a1e3afe]
stable/6.12: [8d71c3231b33e24a911b8f2d8c3a17ee40aa32d5]

CVE-2025-38012: sched_ext: bpf_iter_scx_dsq_new() should always
initialize iterator

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38012

Introduced by commit 650ba21 ("sched_ext: Implement DSQ iterator") in v6.12-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [428dc9fc0873989d73918d4a9cc22745b7bbc799]
stable/6.12: [0102989af4c334d1d98b2a0fd4d61a5152e39b72]

CVE-2025-38013: wifi: mac80211: Set n_channels after allocating struct
cfg80211_scan_request

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38013

Introduced by commit e3eac9f ("wifi: cfg80211: Annotate struct
cfg80211_scan_request with __counted_by") in v6.6-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82bbe02b2500ef0a62053fe2eb84773fe31c5a0a]
stable/6.12: [07c737d9ab02c07b562aefcca16aa95077368e24]
stable/6.6: [fde33ab3c052a302ee8a0b739094b88ceae4dd67]

CVE-2025-38014: dmaengine: idxd: Refactor remove call with idxd_cleanup() helper

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38014

Introduced by commit bfe1d56 ("dmaengine: idxd: Init and probe for
Intel data accelerators") in v5.6-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a409e919ca321cc0e28f8abf96fde299f0072a81]
stable/6.12: [23dc14c52d84b02b39d816bf16a754c0e7d48f9c]
stable/6.6: [d530dd65f6f3c04bbf141702ecccd70170ed04ad]

CVE-2025-38015: dmaengine: idxd: fix memory leak in error handling
path of idxd_alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38015

Introduced by commit a8563a3 ("dmanegine: idxd: reformat opcap output
to match bitmap_parse() input") in v6.1-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46a5cca76c76c86063000a12936f8e7875295838]
stable/6.1: [64afd9a1f644b27661420257dcc007d5009c99dd]
stable/6.12: [868dbce755ec92855362d213f47e045a8388361a]
stable/6.6: [6e94a2c3e4c166cd2736ac225fba5889fb1e8ac0]

CVE-2025-38016: HID: bpf: abort dispatch if device destroyed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38016

Introduced by commit 8bd0488 ("HID: bpf: add HID-BPF hooks for
hid_hw_raw_requests") in v6.11-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [578e1b96fad7402ff7e9c7648c8f1ad0225147c8]
stable/6.12: [f8544be7e8e55b0ef23e1ab90e23e8d4d4aad3d3]

CVE-2025-38017: fs/eventpoll: fix endless busy loop after timeout has expired

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38017

Introduced by commit 0a65bc2 ("eventpoll: Set epoll timeout if it's in
the future")
in 6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9ec73301099ec5975505e1c3effbe768bab9490]

CVE-2025-38018: net/tls: fix kernel panic when alloc_page failed

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38018

Introduced by commit 84c61fe ("tls: rx: do not use the standard
strparser") in v6.0-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [491deb9b8c4ad12fe51d554a69b8165b9ef9429f]
stable/6.1: [8f7f96549bc55e4ef3a6b499bc5011e5de2f46c4]
stable/6.12: [a11b8c0be6acd0505a58ff40d474bd778b25b93a]
stable/6.6: [406d05da26835943568e61bb751c569efae071d4]

CVE-2025-38019: mlxsw: spectrum_router: Fix use-after-free when
deleting GRE net devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38019

Introduced by commit 8fdb09a ("mlxsw: spectrum_router: Replay
neighbours when RIF is made") in v6.6-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92ec4855034b2c4d13f117558dc73d20581fa9ff]
stable/6.12: [abc43c1ffdbc801b0b04ac845bfaf1d42b8f68f7]
stable/6.6: [f1ecccb5cdda39bca8cd17bb0b6cf61361e33578]

CVE-2025-38020: net/mlx5e: Disable MACsec offload for uplink representor profile

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38020

Introduced by commit 8ff0ac5 ("net/mlx5: Add MACsec offload Tx command
support") in v6.1-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [588431474eb7572e57a927fa8558c9ba2f8af143]
stable/6.1: [1e577aeb51e9deba4f2c10edfcb07cb3cb406598]
stable/6.12: [1f80e6ff026041721d8089da8c269b1963628325]
stable/6.6: [b48a47e137cedfd79655accaeeea6b296ad0b9e1]

CVE-2025-38021: drm/amd/display: Fix null check of
pipe_ctx->plane_state for update_dchubp_dpp

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38021

Introduced by commit 63ab80d ("drm/amd/display: DML2.1 Post-Si
Cleanup") in v6.14-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3b7e65b6be59e686e163fa1ceb0922f996897c2]

CVE-2025-38022: RDMA/core: Fix "KASAN: slab-use-after-free Read in
ib_register_device" problem

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38022

Introduced by commit 779e0bf ("RDMA/core: Do not indicate device ready
when device enablement fails") in v5.11-rc1.
Fixed in v6.15-rc7.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
mainline: [d0706bfd3ee40923c001c6827b786a309e2a8713]
stable/6.12: [10c7f1c647da3b77ef8827d974a97b6530b64df0]

CVE-2025-38023: nfs: handle failure of nfs_get_lock_context in unlock path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38023

Introduced by commit f30cb75 ("NFS: Always wait for I/O completion
before unlock") in v4.12-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c457dc1ec770a22636b473ce5d35614adfe97636]
stable/5.10: [4c189fd40a09a03f9a900bedb2d9064f1734d72a]
stable/5.15: [72f552e00c50f265896d3c19edc6696aa2910081]
stable/5.4: [db6f5ee1fc8f54d079d0751292c2fc2d78e3aad1]
stable/6.1: [85fb7f8ca5f8c138579fdfc9b97b3083e6077d40]
stable/6.12: [da824f1271633bcb515ca8084cda3eda4b3ace51]
stable/6.6: [a6879a076b98c99c9fe747816fe1c29543442441]

CVE-2025-38024: RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38024

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f81b33582f9339d2dc17c69b92040d3650bb4bae]
stable/5.10: [3a3b73e135e3bd18423d0baa72571319c7feb759]
stable/5.15: [f8f470e3a757425a8f98fb9a5991e3cf62fc7134]
stable/5.4: [7c7c80c32e00665234e373ab03fe82f5c5c2c230]
stable/6.1: [52daccfc3fa68ee1902d52124921453d7a335591]
stable/6.12: [336edd6b0f5b7fbffc3e065285610624f59e88df]
stable/6.6: [ee4c5a2a38596d548566560c0c022ab797e6f71a]

CVE-2025-38025: iio: adc: ad7606: check for NULL before calling sw_mode_config()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38025

Introduced by commit e571c19 ("iio: adc: ad7606: move scale_setup as
function pointer on chip-info") in v6.13-rc1.
Fixed in v6.15-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5257d80e22bf27009d6742e4c174f42cfe54e425]

CVE-2025-38027: regulator: max20086: fix invalid memory access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38027

Introduced by commit bfff546 ("regulator: Add MAX20086-MAX20089
driver") in v5.17-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b0cd72757c69bc2d45da42b41023e288d02e772]
stable/6.1: [6ba30f7aa2c550b2ac04f16b81a19a8c045b8660]
stable/6.12: [d2a9a92bb4cc7568cff68241b0051dc7268bdc68]
stable/6.6: [7bddac8603d4e396872c2fbf4403ec08e7b1d7c8]

CVE-2025-38028: NFS/localio: Fix a race in nfs_local_open_fh()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38028

Introduced by commit 86e0041 ("nfs: cache all open LOCALIO
nfsd_file(s) in client") in v6.14-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa7ab64f1e2fdc8f2603aab8e0dd20de89cb10d9]

CVE-2025-38029: kasan: avoid sleepable page allocation from atomic context

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38029

Introduced by commit 3c5c3cf ("kasan: support backing vmalloc space
with real shadow memory") in v5.5-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6ea95a34cbd014ab6ade4248107b86b0aaf2d6c]

CVE-2025-38030: Revert "drm/amd: Keep display off while going into S4"

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38030

Introduced by commit 68bfdc8 ("drm/amd: Keep display off while going into S4")
in 6.15-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [7e7cb7a13c81073d38a10fa7b450d23712281ec4]
stable/5.15: [ff887e77b777e806b5210eba229e0bd657e07b60]
stable/6.1: [9c40d1f7b75fc93d7ef02acc3a2a712cb057e576]
stable/6.12: [7c220f89add8e7d6db63c9c4d9566917f8175a0b]
stable/6.6: [ed7d24b0c375f74a1956e73d53549be78bf2774c]

CVE-2025-38031: padata: do not leak refcount in reorder_work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38031

Introduced by commit dd7d37c ("padata: avoid UAF for reorder_work") in
v6.14-rc1.
Fixed in v6.15.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [d6ebcde6d4ecf34f8495fb30516645db3aea8993]
stable/5.10: [b9ad8e50e8589607e68e6c4cefa7f72bf35a2cb1]
stable/5.15: [1a426abdf1c86882c9203dd8182f3b8274b89938]
stable/6.1: [cceb15864e1612ebfbc10ec4e4dcd19a10c0056c]
stable/6.12: [5300e487487d7a2e3e1e6e9d8f03ed9452e4019e]
stable/6.6: [584a729615fa92f4de45480efb7e569d14be1516]

CVE-2025-38032: mr: consolidate the ipmr_can_free_table() checks.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38032

Introduced by commit 50b9420 ("ipmr: tune the ipmr_can_free_table()
checks.") in v6.13-rc2.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c46286fdd6aa1d0e33c245bcffe9ff2428a777bd]

CVE-2025-38033: x86/Kconfig: make CFI_AUTO_DEFAULT depend on !RUST or
Rust >= 1.88

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38033

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [5595c31c370957aabe739ac3996aedba8267603f]
stable/6.12: [5a8d073d87da4ad1496b35adaee5719e94665d81]

CVE-2025-38034: btrfs: correct the order of prelim_ref arguments in
btrfs__prelim_ref

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38034

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [bc7e0975093567f51be8e1bdf4aa5900a3cf0b1e]
stable/5.10: [a641154cedf9d69730f8af5d0a901fe86e6486bd]
stable/5.15: [a876703894a6dd6e8c04b0635d86e9f7a7c81b79]
stable/5.4: [5755b6731655e248c4f1d52a2e1b18795b4a2a3a]
stable/6.1: [0528bba48dce7820d2da72e1a114e1c4552367eb]
stable/6.12: [7f7c8c03feba5f2454792fab3bb8bd45bd6883f9]
stable/6.6: [7a97f961a568a8f72472dc804af02a0f73152c5f]

CVE-2025-38035: nvmet-tcp: don't restore null sk_state_change

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38035

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc5.


Fixed status
mainline: [46d22b47df2741996af277a2838b95f130436c13]
stable/5.10: [17e58be5b49f58bf17799a504f55c2d05ab2ecdc]
stable/5.15: [fc01b547c3f8bfa6e1d23cd5a2c63c736e8c3e4e]
stable/5.4: [6265538446e2426f4bf3b57e91d7680b2047ddd9]
stable/6.1: [c240375587ddcc80e1022f52ee32b946bbc3a639]
stable/6.12: [ec462449f4cf616b0aa2ed119f5f44b5fdfcefab]
stable/6.6: [3a982ada411b8c52695f1784c3f4784771f30209]

CVE-2025-38036: drm/xe/vf: Perform early GT MMIO initialization to read GMDID

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38036

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [13265fe7426ec9ba5aa86baab913417ca361e8a4]

CVE-2025-38037: vxlan: Annotate FDB data races

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38037

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [f6205f8215f12a96518ac9469ff76294ae7bd612]
stable/5.10: [87d076987a9ba106c83412fcd113656f71af05a1]
stable/5.15: [e033da39fc6abbddab6c29624acef80757f273fa]
stable/5.4: [02a33b1035a307453a1da6ce0a1bf3676be287d7]
stable/6.1: [784b78295a3a58bf052339dd669e6e03710220d3]
stable/6.12: [a6644aeb8ddf196dec5f8e782293c36f065df4d7]
stable/6.6: [13cba3f837903f7184d6e9b6137d5165ffe82a8f]

CVE-2025-38038: cpufreq: amd-pstate: Remove unnecessary driver_lock in set_boost

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38038

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [db1cafc77aaaf871509da06f4a864e9af6d6791f]
stable/6.12: [61e931ee145eeab8196e585ff4334870b130b744]

CVE-2025-38039: net/mlx5e: Avoid WARN_ON when configuring MQPRIO with
HTB offload enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38039

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [689805dcc474c2accb5cffbbcea1c06ee4a54570]
stable/6.12: [b82e496531c571caf8a2ef247f51c160bab2162e]
stable/6.6: [090c0ba179eaf7b670e720aa054533756a43d565]

CVE-2025-38040: serial: mctrl_gpio: split disable_ms into sync and no_sync APIs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38040

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [1bd2aad57da95f7f2d2bb52f7ad15c0f4993a685]
stable/6.1: [68435c1fa3db696db4f480385db9e50e26691d0d]
stable/6.12: [e6a46719a2369eb5186d4f7e6c0478720ca1ec3d]
stable/6.6: [c504c11b94d6e4ad818ca5578dffa8ff29ad0f20]

CVE-2025-38041: clk: sunxi-ng: h616: Reparent GPU clock during frequency changes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38041

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [eb963d7948ce6571939c6875424b557b25f16610]

CVE-2025-38042: dmaengine: ti: k3-udma-glue: Drop skip_fdq argument
from k3_udma_glue_reset_rx_chn

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38042

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [0da30874729baeb01889b0eca16cfda122687503]

CVE-2025-38043: firmware: arm_ffa: Set dma_mask for ffa devices

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38043

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [cc0aac7ca17e0ea3ca84b552fc79f3e86fd07f53]
stable/5.15: [97bab02f0b64ba6bcdf6a8fae561db07f509aee9]
stable/6.1: [c6aa1d6bd6ccff4ecdf064d288817657ec8532f0]
stable/6.12: [3a3efeef64364c2a028cf0d03d68c831813a97fd]
stable/6.6: [e2de76c34a8a925efe80fccae4810427bc144ed0]

CVE-2025-38044: media: cx231xx: set device_caps for 417

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38044

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [a79efc44b51432490538a55b9753a721f7d3ea42]
stable/5.10: [0884dd3abbe80307a2d4cbdbe5e312be164f8adb]
stable/5.15: [c91447e35b9bea60bda4408c48e7891d14351021]
stable/5.4: [2ad41beb7df3bd63b209842d16765ec59dafe6e4]
stable/6.1: [9d1a5be86dbe074bd8dd6bdd63a99d6bb66d5930]
stable/6.12: [4731d5328f507ae8fd8a57abbca9119ec7a8d665]
stable/6.6: [5c9eca180a4235abd56cc7f7308ca72128d93dce]

CVE-2025-38045: wifi: iwlwifi: fix debug actions order

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38045

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [eb29b4ffafb20281624dcd2cbb768d6f30edf600]
stable/6.12: [181e8b56b74ad3920456dcdc8a361520d9007956]
stable/6.6: [2b790fe67ed483d86c1aeb8be6735bf792caa7e5]

CVE-2025-38046: [REJECTED]: xen: Add support for XenServer 6.1 platform device

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38046

This CVE was rejected.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2356f15caefc0cc63d9cc5122641754f76ef9b25]
stable/5.10: [5239ba49ad23a2285b4c2d15bec71566d32e0300]
stable/5.15: [7258b92ceff342912945eaaf8787ca3b83dbae21]
stable/5.4: [baedd1ef924d2b04d6223e0e1633e2d84fee6763]
stable/6.1: [02d850de9495699f2029886a6a69f0ed07a39b84]
stable/6.12: [f5363ffdabc2a281bd0023584944e3d0c25dfcd3]
stable/6.6: [0fb6c439d265f09785a561fd2c637af567641cab]

CVE-2025-38047: x86/fred: Fix system hang during S4 resume with FRED enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38047

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [e5f1e8af9c9e151ecd665f6d2e36fb25fec3b110]
stable/6.12: [c42f740a07eea4807e98d2d8febc549c957a7b49]

CVE-2025-38048: virtio_ring: Fix data race by tagging event_triggered
as racy for KCSAN

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38048

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc4.


Fixed status
mainline: [2e2f925fe737576df2373931c95e1a2b66efdfef]
stable/5.15: [02d2d6caee3abc9335cfca35f8eb4492173ae6f2]
stable/6.1: [b6d6419548286b2b9d2b90df824d3cab797f6ae8]
stable/6.12: [b730cb109633c455ce8a7cd6934986c6a16d88d8]
stable/6.6: [b49b5132e4c7307599492aee1cdc6d89f7f2a7da]

CVE-2025-38050: mm/hugetlb: fix kernel NULL pointer dereference when
replacing free hugetlb folios

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38050

Introduced by commit 04f13d2 ("mm: replace free hugepage folios after
migration") in v6.14-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [113ed54ad276c352ee5ce109bdcf0df118a43bda]

CVE-2025-38051: smb: client: Fix use-after-free in cifs_fill_dirent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38051

Introduced by commit a364bc0 ("[CIFS] fix saving of resume key before
CIFSFindNext") in v2.6.28-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7a8fe56e932a36f43e031b398aef92341bf5ea0]
stable/5.10: [a24c2f05ac3c5b0aaa539d9d913826d2643dfd0e]
stable/5.15: [1b197931fbc821bc7e9e91bf619400db563e3338]
stable/5.4: [aee067e88d61eb72e966f094e4749c6b14e7008f]
stable/6.1: [c8623231e0edfcccb7cc6add0288fa0f0594282f]
stable/6.12: [9bea368648ac46f8593a780760362e40291d22a9]
stable/6.6: [73cadde98f67f76c5eba00ac0b72c453383cec8b]

CVE-2025-38052: net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38052

Introduced by commit fc1b6d6 ("tipc: introduce TIPC encryption &
authentication") in v5.5-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e279024617134c94fd3e37470156534d5f2b3472]
stable/5.10: [d42ed4de6aba232d946d20653a70f79158a6535b]
stable/5.15: [f5c2c4eaaa5a8e7e0685ec031d480e588e263e59]
stable/6.1: [b8fcae6d2e93c54cacb8f579a77d827c1c643eb5]
stable/6.12: [689a205cd968a1572ab561b0c4c2d50a10e9d3b0]
stable/6.6: [b19fc1d0be3c3397e5968fe2627f22e7f84673b1]

CVE-2025-38053: idpf: fix null-ptr-deref in idpf_features_check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38053

Introduced by commit a251eee ("idpf: add SRIOV support and other
ndo_ops") in v6.7-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2dabe349f7882ff1407a784d54d8541909329088]
stable/6.12: [f6f5e9c8cb680c3cb9771fd9fa114319cbc4f514]

CVE-2025-38054: ptp: ocp: Limit signal/freq counts in summary output functions

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38054

Introduced by commit ef61f55 ("ptp: ocp: add Adva timecard support")
in v6.9-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9e455581e2ba87ee38c126e8dc49a424b9df0cf]
stable/6.12: [0b7d3e782027ac3b6fec56159e8e348042000aef]

CVE-2025-38055: perf/x86/intel: Fix segfault with PEBS-via-PT with sample_freq

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38055

Introduced by commit 722e42e ("perf/x86: Support counter mask") in v6.11-rc1.
Fixed in v6.15-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99bcd91fabada0dbb1d5f0de44532d8008db93c6]
stable/6.12: [ca51db23166767a8445deb8331c9b8d5205d9287]

CVE-2025-38056: ASoC: SOF: Intel: hda: Fix UAF when reloading module

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38056

Introduced by commit 5458411 ("ASoC: SOF: Intel: hda: refactoring
topology name fixup for HDA mach") in v6.12-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dd7f39fce0022b386ef1ea5ffef92ecc7dfc6af]
stable/6.12: [2b49e68360eb6a1c03dc1642a51f7d9f6784c034]

CVE-2025-38057: espintcp: fix skb leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38057

Introduced by commit e27cca9 ("xfrm: add espintcp (RFC 8229)") in v5.6-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63c1f19a3be3169e51a5812d22a6d0c879414076]
stable/6.12: [28756f22de48d25256ed89234b66b9037a3f0157]

CVE-2025-38058: __legitimize_mnt(): check for MNT_SYNC_UMOUNT should
be under mount_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38058

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [250cf3693060a5f803c5f1ddc082bb06b16112a9]
stable/5.10: [b89eb56a378b7b2c1176787fc228d0a57172bdd5]
stable/5.15: [f6d45fd92f62845cbd1eb5128fd8f0ed7d0c5a42]
stable/5.4: [628fb00195ce21a90cf9e4e3d105cd9e58f77b40]
stable/6.1: [9b0915e72b3cf52474dcee0b24a2f99d93e604a3]
stable/6.12: [8cafd7266fa02e0863bacbf872fe635c0b9725eb]
stable/6.6: [d8ece4ced3b051e656c77180df2e69e19e24edc1]

CVE-2025-38059: btrfs: avoid NULL pointer dereference if no valid csum tree

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38059

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc6.


Fixed status
mainline: [f95d186255b319c48a365d47b69bd997fecb674e]
stable/6.12: [6e9770de024964b1017f99ee94f71967bd6edaeb]
stable/6.6: [50d0de59f66cbe6d597481e099bf1c70fd07e0a9]

CVE-2025-38060: bpf: copy_verifier_state() should copy 'loop_entry' field

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38060

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [bbbc02b7445ebfda13e4847f4f1413c6480a85a9]
stable/6.12: [46ba5757a7a4714e7d3f68cfe118208822cb3d78]

CVE-2025-38061: net: pktgen: fix access outside of user given buffer
in pktgen_thread_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38061

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [425e64440ad0a2f03bdaf04be0ae53dededbaa77]
stable/5.10: [5bfa81539e22af4c40ae5d43d7212253462383a6]
stable/5.15: [128cdb617a87767c29be43e4431129942fce41df]
stable/5.4: [a3d89f1cfe1e6d4bb164db2595511fd33db21900]
stable/6.1: [ef1158a6a650ecee72ab40851b1d52e04d3f9cb5]
stable/6.12: [6b1d3e9db82d01a88de1795b879df67c2116b4f4]
stable/6.6: [c81c2ee1c3b050ed5c4e92876590cc7a259183f6]

CVE-2025-38062: genirq/msi: Store the IOMMU IOVA directly in msi_desc
instead of iommu_cookie

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38062

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [1f7df3a691740a7736bbc99dc4ed536120eb4746]
stable/6.1: [e4d3763223c7b72ded53425207075e7453b4e3d5]
stable/6.12: [53f42776e435f63e5f8e61955e4c205dbfeaf524]
stable/6.6: [ba41e4e627db51d914444aee0b93eb67f31fa330]

CVE-2025-38063: dm: fix unconditional IO throttle caused by REQ_PREFLUSH

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38063

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [88f7f56d16f568f19e1a695af34a7f4a6ce537a6]
stable/6.1: [95d08924335f3b6f4ea0b92ebfe4fe0731c502d9]
stable/6.12: [b55a97d1bd4083729a60d19beffe85d4c96680de]
stable/6.6: [52aa28f7b1708d76e315d78b5ed397932a1a97c3]

CVE-2025-38064: virtio: break and reset virtio devices on device_shutdown()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38064

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [8bd2fa086a04886798b505f28db4002525895203]

CVE-2025-38065: orangefs: Do not truncate file size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38065

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [062e8093592fb866b8e016641a8b27feb6ac509d]
stable/5.10: [341e3a5984cf5761f3dab16029d7e9fb1641d5ff]
stable/5.15: [5111227d7f1f57f6804666b3abf780a23f44fc1d]
stable/5.4: [ceaf195ed285b77791e29016ee6344b3ded609b3]
stable/6.1: [15602508ad2f923e228b9521960b4addcd27d9c4]
stable/6.12: [cd918ec24168fe08c6aafc077dd3b6d88364c5cf]
stable/6.6: [121f0335d91e46369bf55b5da4167d82b099a166]

CVE-2025-38066: dm cache: prevent BUG_ON by blocking retries on failed
device resumes

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38066

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [5da692e2262b8f81993baa9592f57d12c2703dea]
stable/5.10: [c5356a5e80442131e2714d0d26bb110590e4e568]
stable/5.15: [025c8f477625eb39006ded650e7d027bcfb20e79]
stable/5.4: [c614584c2a66b538f469089ac089457a34590c14]
stable/6.1: [00586b78eeb7c626a14ca13453a1631f88a7cf36]
stable/6.12: [cc80a5cc520939d0a7d071cc4ae4b3c55ef171d0]
stable/6.6: [3986ef4a9b6a0d9c28bc325d8713beba5e67586f]

CVE-2025-38067: rseq: Fix segfault on registration when rseq_cs is non-zero

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38067

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [fd881d0a085fc54354414aed990ccf05f282ba53]

CVE-2025-38068: crypto: lzo - Fix compression buffer overrun

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38068

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [cc47f07234f72cbd8e2c973cdbf2a6730660a463]
stable/5.15: [4b173bb2c4665c23f8fcf5241c7b06dfa6b5b111]
stable/6.1: [a98bd864e16f91c70b2469adf013d713d04d1d13]
stable/6.12: [7caad075acb634a74911830d6386c50ea12566cd]
stable/6.6: [0acdc4d6e679ba31d01e3e7e2e4124b76d6d8e2a]

CVE-2025-38069: PCI: endpoint: pci-epf-test: Fix double free that
causes kernel to oops

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38069

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [934e9d137d937706004c325fa1474f9e3f1ba10a]
stable/6.12: [fe2329eff5bee461ebcafadb6ca1df0cbf5945fd]

CVE-2025-38070: ASoC: sma1307: Add NULL check in sma1307_setting_loaded()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38070

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [0ec6bd16705fe21d6429d6b8f7981eae2142bba8]

CVE-2025-38071: x86/mm: Check return value from memblock_phys_alloc_range()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38071

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [631ca8909fd5c62b9fda9edda93924311a78a9c4]
stable/6.1: [8c18c904d301ffeb33b071eadc55cd6131e1e9be]
stable/6.12: [c6f2694c580c27dca0cf7546ee9b4bfa6b940e38]
stable/6.6: [bffd5f2815c5234d609725cd0dc2f4bc5de2fc67]

CVE-2025-38072: libnvdimm/labels: Fix divide error in nd_label_data_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38072

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [ef1d3455bbc1922f94a91ed58d3d7db440652959]
stable/5.10: [396c46d3f59a18ebcc500640e749f16e197d472b]
stable/5.15: [f49c337037df029440a8390380dd35d2cf5924d3]
stable/5.4: [2bd4a938d2eda96ab7288b8fa5aae84a1de8c4ca]
stable/6.1: [db1aef51b8e66a77f76b1250b914589c31a0a0ed]
stable/6.12: [1d1e1efad1cf049e888bf175a5c6be85d792620c]
stable/6.6: [ea3d95e05e97ea20fd6513f647393add16fce3b2]

CVE-2025-38073: block: fix race between set_blocksize and read paths

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38073

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc4.


Fixed status
mainline: [c0e473a0d226479e8e925d5ba93f751d8df628e9]
stable/6.12: [64f505b08e0cfd8163491c8c082d4f47a88e51d4]

CVE-2025-38074: vhost-scsi: protect vq->log_used with vq->mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38074

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc4.


Fixed status
mainline: [f591cf9fce724e5075cc67488c43c6e39e8cbe27]
stable/6.12: [bd8c9404e44adb9f6219c09b3409a61ab7ce3427]
stable/6.6: [ca85c2d0db5f8309832be45858b960d933c2131c]

CVE-2025-38075: scsi: target: iscsi: Fix timeout on deleted connection

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38075

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc4.


Fixed status
mainline: [7f533cc5ee4c4436cee51dc58e81dfd9c3384418]
stable/5.10: [2c5081439c7ab8da08427befe427f0d732ebc9f9]
stable/5.15: [019ca2804f3fb49a7f8e56ea6aeaa1ff32724c27]
stable/5.4: [571ce6b6f5cbaf7d24af03cad592fc0e2a54de35]
stable/6.1: [6815846e0c3a62116a7da9740e3a7c10edc5c7e9]
stable/6.12: [87389bff743c55b6b85282de91109391f43e0814]
stable/6.6: [fe8421e853ef289e1324fcda004751c89dd9c18a]

CVE-2025-38076: alloc_tag: allocate percpu counters for module tags dynamically

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38076

Introduced by commit 0db6f8d ("alloc_tag: load module tags into
separate contiguous memory") in v6.13-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12ca42c237756182aad8ab04654c952765cb9061]

CVE-2025-38077: platform/x86: dell-wmi-sysman: Avoid buffer overflow
in current_password_store()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38077

Introduced by commit e8a60aa ("platform/x86: Introduce support for
Systems Management Driver over WMI for Dell Systems") in v5.11-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e89a4077490f52cde652d17e32519b666abf3a6]
stable/5.15: [fb7cde625872709b8cedad9b241e0ec3d82fa7d3]
stable/6.1: [60bd13f8c4b3de2c910ae1cdbef85b9bbc9685f5]
stable/6.12: [8594a123cfa23d708582dc6fb36da34479ef8a5b]
stable/6.6: [f86465626917df3b8bdd2756ec0cc9d179c5af0f]

CVE-2025-38078: ALSA: pcm: Fix race of buffer access at PCM OSS layer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38078

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15.


Fixed status
mainline: [93a81ca0657758b607c3f4ba889ae806be9beb73]
stable/5.10: [8170d8ec4efd0be352c14cb61f374e30fb0c2a25]
stable/5.15: [10217da9644ae75cea7330f902c35fc5ba78bbbf]
stable/5.4: [c0e05a76fc727929524ef24a19c302e6dd40233f]
stable/6.1: [f3e14d706ec18faf19f5a6e75060e140fea05d4a]
stable/6.12: [bf85e49aaf3a3c5775ea87369ea5f159c2148db4]
stable/6.6: [74d90875f3d43f3eff0e9861c4701418795d3455]

CVE-2025-38079: crypto: algif_hash - fix double free in hash_accept

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38079

Introduced by commit fe869cd ("crypto: algif_hash - User-space
interface for hash operations") in v2.6.38-rc1.
Fixed in v6.15.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2df03ed4052e97126267e8c13ad4204ea6ba9b6]
stable/5.10: [bf7bba75b91539e93615f560893a599c1e1c98bf]
stable/5.15: [c3059d58f79fdfb2201249c2741514e34562b547]
stable/5.4: [5bff312b59b3f2a54ff504e4f4e47272b64f3633]
stable/6.1: [f0f3d09f53534ea385d55ced408f2b67059b16e4]
stable/6.12: [2f45a8d64fb4ed4830a4b3273834ecd6ca504896]
stable/6.6: [134daaba93193df9e988524b5cd2f52d15eb1993]

CVE-2025-38080: drm/amd/display: Increase block_sequence array size

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38080

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [3a7810c212bcf2f722671dadf4b23ff70a7d23ee]
stable/6.12: [e55c5704b12eeea27e212bfab8f7e51ad3e8ac1f]
stable/6.6: [de67e80ab48f1f23663831007a2fa3c1471a7757]

CVE-2025-38081: spi-rockchip: Fix register out of bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38081

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc1.


Fixed status
mainline: [7a874e8b54ea21094f7fd2d428b164394c6cb316]
stable/6.12: [ace57bd1fb49d193edec5f6a1f255f48dd5fca90]
stable/6.6: [4a120221661fcecb253448d7b041a52d47f1d91f]

CVE-2025-38082: gpio: virtuser: fix potential out-of-bound write

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38082

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc7.


Fixed status
mainline: [7118be7c6072f40391923543fdd1563b8d56377c]
stable/6.12: [afe090366f470f77e140ff3407db813f57852c04]


* Updated CVEs

No updated CVEs.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

