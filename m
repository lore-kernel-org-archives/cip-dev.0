Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8861FF887E
	for <webhook@archiver.kernel.org>; Wed, 29 Apr 2026 22:59:30 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8554.1777503559129758062
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Apr 2026 15:59:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=XxknG5YG;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.172, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79a7109f568so3426947b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 Apr 2026 15:59:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777503558; cv=none;
        d=google.com; s=arc-20240605;
        b=OHVVekYsFN4eStVfR4KBUur19gI3pM+u2/Tl8D/Cu+2gsDXv3XRhwYrRdnHPObz2hZ
         mfcBVEH/REIl2s9KOO3z9jY6TpdMTjhBb1Y+6KG6lkDCPMehNAJKf7UMwQ3gFvYjlqO5
         chCSOecGwwbKsD191iKwJlbVK7Bb5G5K3MD+iGHzoo6h3RptFgdjmA4TeQalCRAsezJ8
         gecEu15XZR6eCnEuey+1PpJtAtRtmantBlMv2KRZvRnBZ0rmwp9DoAP8D8DSxdKVMUWG
         Yya1dyMKjNYk0V7dQug8v0at7bfPTL5AmPediwURPwG9nIJF2BbJ1CTmeEjLdsGTk7f4
         Fugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=SyDU575M8C9JX2FII0jr45I0WVaOMJxUVP6HnWBgn54=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=IEUE8msUoAbsyitDniXtXS8/4/94D2vXuWES5KMHe68yWE8bOhYsMmrMGKmfmJr3Dd
         +Qt2nS3FPB9OBf1RLfMWsbeU3xGJ6Gwt+dAp6GHHgWq9Hrqt5XbM7rHXUn5UnIi9aqPA
         Z5Qi7tkzrMiRqi/26GYelL/3b5l/euOTj/0/EMZXby8V7/57p/F17PhiwreJnjhD7e3F
         KchL9FkZzEJfyBXQ5/EpgSVFhpsKoJMI3iBEboXXs37PdMhUEjGYMUTOHBc3DTplnzxu
         oFppVmxlEC8mF5bHyGCZp5ChigH+ZtyARowu7e92HQnCHl7gpEdGZKcgBGqGj3exAQOV
         8GDg==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1777503558; x=1778108358; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SyDU575M8C9JX2FII0jr45I0WVaOMJxUVP6HnWBgn54=;
        b=XxknG5YGgQZ00G/OyH+h/1zWA0NAzRIARNaXJW13rnD1DgkedL8ZxFXbQWOMas54WU
         f33tMiRx8zCltg/yD3hItPAXA1eA46j4My3Vx2+vIS8AzwGBZdHoqLpUZ3+UYlkB1+Nr
         +3OwVgPDAeIB40tod7BVHs7h7ot5lu1FspAgQjPharUQcxGoH3RK2h8IF0pP5rmIXS/T
         p7H/daoLu/Jnmsnb2eTYrQltke1KVFQTDhW+Ekp192erHijYWozVYc5ZcuQxia50cHlf
         9yQX1JILq+yEhG1cZ+t669hQyZz0kphZyoT56llFO6QD82xXVzXWbfvvLvEYgieVkZJv
         andw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777503558; x=1778108358;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyDU575M8C9JX2FII0jr45I0WVaOMJxUVP6HnWBgn54=;
        b=ClWVjwYzI/7DpBdFa3bkB3NvniiCk1+iW3Wz1aAEfjFtfoSYMg/THZ0DLmFTSxAppf
         MmrQFaqIq/FbUWMzEVn8/G2nKUG9L3V812J2VjXgaOiUuJA3ZzOhqHoPFG/cYaj2H59o
         SsAeYv/mljkMvtgF29aBrPldnBub5iJj2rwx4hLA1hbg2snjeJxlniIp8to/C+sh7bWa
         yujras/1vuH730r2rYOzoqzyZ8c/xt3zuHb9kbI+Zg99nZSi0Y2+kpi5b4FWG6jRndAA
         JlmCf0JsO9ZMt5v752sDBSex4mgxKpPxGTbzAm8mgG3+IHKp4xdQpOENQXIHMH/Q3tSB
         FsEw==
X-Gm-Message-State: AOJu0YxKB4ScCI8YBc7PfRFLnhE6hDgc69a5cmL9lOAoRspeHTTzcE5n
	X0Ir7xSBVBYdcvRLqSdPHSBrU/g+6XbUQCM/sDx53/cry/nlKs7wmO1HBRexVEKmtaFvxlTTUyc
	5xbJ4ha1KkaivngtMSYEToAzAd0v03SnKC9/yzTrEs/WK46ZlBhosne+ZqQ==
X-Gm-Gg: AeBDietA+kC2mC35J/tfCY2eiTBmPanfi4sRBwbUs8JNPa6whAQjdfsqTy2E8+3BmFc
	T86NpO2TMKq3lm7bj1vPnW0hLZKetWwkT+joZdvWkArfRxnyLklwvKtm1m7cjj1wh0sRzkzbjoc
	Om4Dmebx9NTcaFWx74AaLZ+4ERGoEsTpYAvpwTCqWjZSOhldy3PQENx4jCFFuryQSKOXYkl8WK4
	2/ZJ/Ig7+wHrDNthWDO5LtirEwuAFDrfexEL2d083LdW0KyA8zNBLbaBWwoZDZ815No/PhoxIfK
	5/SV9NRXHK0i6S+YgGc=
X-Received: by 2002:a05:690c:620a:b0:7b4:657d:bd5d with SMTP id
 00721157ae682-7bd5294df87mr7472847b3.30.1777503556223; Wed, 29 Apr 2026
 15:59:16 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Apr 2026 07:58:39 +0900
X-Gm-Features: AVHnY4J6TN8YxxmJakjfA5CdNTpypsuQ1OjUfemoV0RZYfnDyZv4zNLKWVRaVP0
Message-ID: <CAODzB9pBqBOhOpu=H4RyON1VaLGJSP4jsFrLmGVdACU73DXyxw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Apr 2026 22:59:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22822

Hi!

It's this week's CVE report.

This week reported 162 new CVEs and 14 updated CVEs.

* New CVEs
CVE-2026-31531: ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31531

Introduced by commit 430a049 ("nexthop: Add support for nexthop
groups") in v5.3-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14cf0cd35361f4e94824bf8a42f72713d7702a73]
stable/6.12: [615517f3f8d53b0cf41507c7599971e17adfdfa5]
stable/6.18: [40bd39e383a0478fd5c221f393df05fd9d70cfbc]

CVE-2026-31532: can: raw: fix ro->uniq use-after-free in raw_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31532

Introduced by commit 514ac99 ("can: fix multiple delivery of a single
CAN frame for overlapping CAN filters") in v4.1-rc1.
Fixed in master.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a535a9217ca3f2fccedaafb2fddb4c48f27d36dc]
stable/6.12: [572f0bf536ebc14f6e7da3d21a85cf076de8358e]
stable/6.18: [1a0f2de81f7fbdc538fc72d7d74609b79bc83cc0]
stable/6.6: [5e9cfffad898bbeaafd0ea608a6d267362f050fc]
stable/7.0: [34c1741254ff972e8375faf176678a248826fe3a]

CVE-2026-31533: net/tls: fix use-after-free in -EBUSY error path of
tls_do_encryption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31533

Introduced by commit 8590541 ("net: tls: handle backlogging of crypto
requests") in v6.8-rc5.
Fixed in v7.0.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [a9b8b18364fffce4c451e6f6fd218fa4ab646705]
stable/5.15: [414fc5e5a5aff776c150f1b86770e0a25a35df3a]
stable/6.1: [02f3ecadb23558bbe068e6504118f1b712d4ece0]
stable/6.12: [aa9facde6c5005205874c37db3fd25799d741baf]
stable/6.18: [5d70eb25b41e9b010828cd12818b06a0c3b04412]
stable/6.6: [0e43e0a3c94044acc74b8e0927c27972eb5a59e8]

CVE-2026-31557: nvmet: move async event work off nvmet-wq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31557

Introduced commit is not determined.Fixed in v7.0-rc4.


Fixed status
mainline: [2922e3507f6d5caa7f1d07f145e186fc6f317a4e]
stable/6.12: [49c7c50ee6325a084216e94395e067ecde8088fa]
stable/6.18: [ca111c9d8d6c9d5735878d933a1716c4be86c2d1]

CVE-2026-31537: smb: server: make use of smbdirect_socket.send_io.bcredits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31537

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [34abd408c8ba24d7c97bd02ba874d8c714f49db1]
stable/6.18: [5ef18a2e66f2f33fdac64437bddfb9fe6389fdc7]

CVE-2026-31536: smb: server: let send_done handle a completion without
IB_SEND_SIGNALED

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31536

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [9da82dc73cb03e85d716a2609364572367a5ff47]
stable/6.18: [24082642654f3e5149913946e89c00a297a8868f]

CVE-2026-31534: [REJECTED]: smb: client: let send_done handle a
completion without IB_SEND_SIGNALED

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31534

This CVE was rejected. Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [cf74fcdc43b322b6188a0750b5ee79e38be6d078]
stable/6.18: [16c8be3d55441287ddd334e25df4cc376450dec9]

CVE-2026-31671: xfrm_user: fix info leak in build_report()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31671

Introduced commit is not determined.Fixed in v7.0.


Fixed status
mainline: [d10119968d0e1f2b669604baf2a8b5fdb72fa6b4]
stable/5.10: [d27c02eec529f78055a46a5c9e6c62684382b2d8]
stable/5.15: [716c546e88cfe49d841658240e10cb57bc50a2cc]
stable/6.1: [0616314b3b34f24cbb91da8c6bd8bcdc4c8592f9]
stable/6.12: [ff5ee507302303b15859753c3e0d67d38fd12c88]
stable/6.18: [6c55714c931051cd7f4839c19ce0867179fd22fe]
stable/6.6: [e0c8542c3d097ed4205ded51868195d5d6ddac62]

CVE-2026-31670: net: rfkill: prevent unlimited numbers of rfkill
events from being created

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31670

Introduced commit is not determined.Fixed in v7.0.


Fixed status
mainline: [ea245d78dec594372e27d8c79616baf49e98a4a1]
stable/5.10: [4bcd1615a4e2a185ae9edd27b4143d7dfa7134f4]
stable/5.15: [b1e0c8d3ab58a0161db487bf5fc47adfcaf5d5ca]
stable/6.1: [e3842779547c83150569071d9980517cc9029fc0]
stable/6.12: [82843afc19012a29ba863961ef494165aa1a88f4]
stable/6.18: [a8c26800e0220e1550af012f5a20e50f5c78864d]
stable/6.6: [673d2a3eef6e0ee9736501a150c9e4024a4e60a6]

CVE-2026-31628: x86/CPU: Fix FPDSS on Zen1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31628

Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e55d98e7756135f32150b9b8f75d580d0d4b2dd3]
stable/5.10: [ed7a3a246309ccc807238f1b4f159ee6d37ff9c4]
stable/5.15: [0548529af20e68c6552817834b766646dd3bd7a7]
stable/6.1: [1272cfedf4cd1019ddf583917a99b62f2d3645bb]
stable/6.12: [b731aca06387b195058a9f6449a03b62efa1bd10]
stable/6.18: [ad17f07e95e6e8505e2153e5b391f0d27eacce25]
stable/6.6: [91f02726b2203b71545713ecb7fb006e60a2d66f]
stable/7.0: [546785c719418c6166834a47e372a88f5f7ae893]

CVE-2026-31627: i2c: s3c24xx: check the size of the SMBUS message
before using it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31627


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0128c7157d639a931353ea344fb44aad6d6e17a]
stable/6.12: [d87d5620125a03b1eadbd5df39748215d3db7ddb]
stable/6.18: [377fae22a137b6b89f3f32399a58c52cf2325416]
stable/6.6: [fa00738ab30b07db1a43b9c85fc56b8cc3b7d197]
stable/7.0: [aaaaec39ddbcd06770dca7f1adebc3b1242ebe7b]

CVE-2026-31624: HID: core: clamp report_size in s32ton() to avoid
undefined shift

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31624


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69c02ffde6ed4d535fa4e693a9e572729cad3d0d]
stable/6.12: [58386f00af710922cafb0fb69211497beddfaa95]
stable/6.18: [8a8333237f1f5caab8d4c3d2c2e7578c4263a97f]
stable/6.6: [932ae5309e53561197aa7d1606c7cf63af10e24f]
stable/7.0: [97014719bb8fccb1ffcbbc299e84b1f11b114195]

CVE-2026-31618: fbdev: tdfxfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31618


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f98b81fe011e1879e6a7b1247e69e06a5e17af2]
stable/6.12: [53cb4e79a07124d2ebe502983c29800104080b47]
stable/6.18: [fc386daa6846551a88d338ba9864fc2812cd9030]
stable/6.6: [859a239d58a812b61267d9944b701affe6a6244e]
stable/7.0: [63dfb0b4741f46d65b667c4275132b3d1966acc8]

CVE-2026-31616: usb: gadget: f_phonet: fix skb frags[] overflow in
pn_rx_complete()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31616


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c088d5dd2fffb4de1fb8e7f57751c8b82942180a]
stable/6.12: [c9315ce9da3632c591666a29de82d3e92d46bec1]
stable/6.18: [4e476c25bfcab0535ba7c76a903ae77ca8747711]
stable/6.6: [9ceff1251904901b0b4e5fe6350fcaffa368ce83]
stable/7.0: [66f7471c4042e4eb300e30b5b9d87d1406862673]

c: smb: client: fix off-by-8 bounds check in check_wsl_eas()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31614


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d8b9d06bd3ac4c6846f5498800b0f5f8062e53b]
stable/6.12: [5cc0574c84aa73946ade587c41e81757b8b01cb5]
stable/6.18: [b2b76d09a64c538c57006180103fc1841e8cfa66]
stable/6.6: [bfbc74df8bbe095b3ed68f6d4487b368af087890]
stable/7.0: [a893f1757d9a4009e4a8d7ceb2312142fe29cea4]

CVE-2026-31613: smb: client: fix OOB reads parsing symlink error response

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31613


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3df690bba28edec865cf7190be10708ad0ddd67e]
stable/6.18: [e0dd90d14cbbf318157ea8e3fb62ee68a28655ed]
stable/7.0: [a66ef2e7ed837325c5600f8617d5ee0a0a149fdd]

CVE-2026-31612: ksmbd: validate EaNameLength in smb2_get_ea()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31612


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66751841212c2cc196577453c37f7774ff363f02]
stable/6.12: [551dfb15b182abad4600eaf7b37e6eb7000d5b1b]
stable/6.18: [3363a770b193f555f29d76ddf4ced3305c0ccf6d]
stable/6.6: [4b73376feecb3b61172fe5b4ff42bbbb8531669d]
stable/7.0: [dfc6878d14acafffbe670bf2576620757a10a3d8]

CVE-2026-31611: ksmbd: require 3 sub-authorities before reading sub_auth[2]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31611


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53370cf9090777774e07fd9a8ebce67c6cc333ab]
stable/6.12: [08f9e6d899b5c834bbcc239eae1bed58d9b15d2c]
stable/6.18: [d2454f4a002d08560a60f214f392e6491cf11560]
stable/6.6: [b5b5d5936a50497fb151c0b122899a6894721c2b]
stable/7.0: [9401f86a224f37b50e6a3ccf1d46a70d5ef8af0a]

CVE-2026-31610: ksmbd: fix mechToken leak when SPNEGO decode fails
after token alloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31610


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad0057fb91218914d6c98268718ceb9d59b388e1]
stable/6.12: [dd577cb55588ec3fbc66af3621280306601c4192]
stable/6.18: [dd53414e301beb915fe672dc4c4a51bafb917604]
stable/6.6: [745a535461bbb90a56d9357573c9f97a5c12abe1]
stable/7.0: [6c8c44e6553b9f072f62d9875e567766eb293162]

CVE-2026-31606:  usb: gadget: f_hid: don't call cdev_init while cdev in use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31606


Introduced commit is not determined. Fixed in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81ebd43cc0d6d106ce7b6ccbf7b5e40ca7f5503d]
stable/6.12: [c6c0d13db5d0f8d465eabc14bd23d2b6a7247a43]
stable/6.18: [eb6ef6185f2054a341ec70d7e2165f5381744215]
stable/7.0: [75ecc46828ec377dd5692c677168ef6d64fd7123]

CVE-2026-31560: spi: spi-dw-dma: fix print error log when wait finish
transaction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31560

Introduced commit is not determined.Fixed in v7.0-rc3.


Fixed status
mainline: [3b46d61890632c8f8b117147b6923bff4b42ccb7]

CVE-2026-31559: LoongArch: Fix missing NULL checks for kstrdup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31559

Introduced commit is not determined.Fixed in v7.0-rc6.


Fixed status
mainline: [3a28daa9b7d7c2ddf2c722e9e95d7e0928bf0cd1]
stable/6.12: [5e7fde2c551f86e6c3de3fd7a9b1f52806ac8db0]
stable/6.18: [a1da957c25cf751a2dce8fb7777f82ccbac0cb3e]

CVE-2026-31672: wifi: rt2x00usb: fix devres lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31672

Introduced by commit 8b4c000 ("rt2x00usb: Use usb anchor to manage
URB") in v4.7-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25369b22223d1c56e42a0cd4ac9137349d5a898e]
stable/5.10: [64a457f6afbf15f984d95201a9a1e71eed3f9dd1]
stable/5.15: [65518a6965d527c53013947031f26754f6a4f6af]
stable/6.1: [15b233e33b35b927bd8d0044c15325564ea1ba24]
stable/6.12: [b245db719bc7e57abf48bd5701662b270c3880f7]
stable/6.18: [e360d15fcb1e819eef49e3d4434d8050542eed16]
stable/6.6: [1de5c76bf40e9cdeebf54662f63011fb10fa452f]

CVE-2026-31669: mptcp: fix slab-use-after-free in __inet_lookup_established

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31669

Introduced by commit b19bc29 ("mptcp: implement delegated actions") in
v5.12-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b55b253907e7431210483519c5ad711a37dafa1]
stable/5.15: [f6e1f25fa5e733570f6d6fe37a4dfed2a0deba47]
stable/6.1: [fb1f54b7d16f393b8b65d328410f78b4beea8fcc]
stable/6.12: [eb9c6aeb512f877cf397deb1e4526f646c70e4a7]
stable/6.18: [15fa9ead4d5e6b6b9c794e84144146c917f2cb62]
stable/6.6: [3fd6547f5b8ac99687be6d937a0321efda760597]

CVE-2026-31668: seg6: separate dst_cache for input and output paths in
seg6 lwtunnel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31668

Introduced by commit 6c8702c ("ipv6: sr: add support for SRH
encapsulation and injection with lwtunnels") in v4.10-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3812651b522fe8437ebb7063b75ddb95b571643]
stable/5.10: [1dec91d3b1cefb82635761b7812154af3ef46449]
stable/5.15: [750569d6987a0ff46317a4b86eb3907e296287bf]
stable/6.1: [57d0374d14fa667dec6952173b93e7e84486d5c9]
stable/6.12: [6305ad032b03d2ea4181b953a66e19a9a6ed053c]
stable/6.18: [fb56de5d99218de49d5d43ef3a99e062ecd0f9a1]
stable/6.6: [84d458018b147176b259347103fccb7e93abd2b1]

CVE-2026-31667: Input: uinput - fix circular locking dependency with ff-core

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31667

Introduced by commit ff46255 ("Input: uinput - switch to the new FF
interface") in v2.6.20.16.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cda78d6f8bf2b700529f2fbccb994c3e826d7c2]
stable/5.10: [71a9729f412e2c692a35c542e14b706fb342927f]
stable/5.15: [271ee71a1917b89f6d73ec82dd091c33d92ee617]
stable/6.1: [974f7b138c3a96dd5cd53d1b33409cd7b2229dc6]
stable/6.12: [a3d6c9c053c9c605651508569230ead633b13f76]
stable/6.18: [1e09dfbb4f5d20ee111f92325a00f85778a5f328]
stable/6.6: [546c18a14924eb521fe168d916d7ce28f1e13c1d]

CVE-2026-31666: btrfs: fix incorrect return value after changing leaf
in lookup_extent_data_ref()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31666

Introduced by commit 1618aa3 ("btrfs: simplify return variables in
lookup_extent_data_ref()") in v6.10-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [316fb1b3169efb081d2db910cbbfef445afa03b9]
stable/6.12: [4125a194db4a6cf91f619f38788272651cb97dce]
stable/6.18: [450e6a685d0cad95b15f8af152057bd0bf79f50b]

CVE-2026-31665: netfilter: nft_ct: fix use-after-free in timeout object destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31665

Introduced by commit 7e0b2b5 ("netfilter: nft_ct: add ct timeout
support") in v4.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8dca15a1b190787bbd03285304b569631160eda]
stable/5.10: [c458fc1c278a65ad5381083121d39a479973ebed]
stable/5.15: [c581e5c8f2b59158f62efe61c1a3dc36189081ff]
stable/6.1: [f16fe84879a5280f05ebbcea593a189ba0f3e79a]
stable/6.12: [aa7cfa16f98f8ec3e6d47c34e1a8c1ae4b9b8b77]
stable/6.18: [b42aca3660dc2627a29a38131597ca610dc451f9]
stable/6.6: [070abdf1b04325b21a20a2a0c39a2208af107275]

CVE-2026-31664: xfrm: clear trailing padding in build_polexpire()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31664

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71a98248c63c535eaa4d4c22f099b68d902006d0]
stable/6.1: [ac6985903db047eaff54db929e4bf6b06782788e]
stable/6.12: [eda30846ea54f8ed218468e5480c8305ca645e37]
stable/6.18: [b1dfd6b27df35ef4f87825aa5f607378d23ff0f2]
stable/6.6: [c221ed63a2769a0af8bd849dfe25740048f34ef4]

CVE-2026-31663: xfrm: hold dev ref until after transport_finish NF_HOOK

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31663

Introduced by commit acf568e ("xfrm: Reinject transport-mode packets
through tasklet") in v4.15-rc6.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c428b03840094410c5fb6a5db30640486bbbfcb]
stable/6.18: [0f451b43c88bf2b9c038b414be580efee42e031b]

CVE-2026-31662: tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31662

Introduced by commit 2f48771 ("tipc: guarantee that group broadcast
doesn't bypass group unicast") in v4.15-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48a5fe38772b6f039522469ee6131a67838221a8]
stable/5.10: [a7db57ccca21f5801609065473c89a38229ecb92]
stable/5.15: [36ec4fdd6250dcd5e73eb09ea92ed92e9cc28412]
stable/6.1: [575faea557f1a184a5f09661bd47ebd3ef3769f8]
stable/6.12: [a2ea1ef0167d7a84730638d05c20ccdc421b14b6]
stable/6.18: [1b6f13f626665cac67ba5a012765427680518711]
stable/6.6: [3bcf7aca63f0bcd679ae28e9b99823c608e59ce3]

CVE-2026-31661: wifi: brcmsmac: Fix dma_free_coherent() size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31661

Introduced by commit 5b435de ("net: wireless: add brcm80211 drivers")
in v3.2-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12cd7632757a54ce586e36040210b1a738a0fc53]
stable/5.10: [f449676bab54fea1440775c8c915dadb323fe015]
stable/5.15: [3c204a0fd079fa7a867151a47d830ad1c2db5177]
stable/6.1: [0f87777b74bcce29b966ec42d9aa8f9edd9b1667]
stable/6.12: [77263f053963dea9f3962505ac0c768853d7dc59]
stable/6.18: [b27fa888e4a426a3bcf6f6ab24701d888d9bf5aa]
stable/6.6: [4bf41c2731a0549e21f66180ff780b1e036639ab]

CVE-2026-31660: nfc: pn533: allocate rx skb before consuming bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31660

Introduced by commit c656aa4 ("nfc: pn533: add UART phy driver") in v5.5-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c71ba669b570c7b3f86ec875be222ea11dacb352]
stable/5.10: [2ca64fb7e2d2ae14619dd204d4f2f0a601f421fb]
stable/5.15: [8b71299d587d9e4c830c18afb884c80ddb30ad28]
stable/6.1: [16649adc2e19509104245ea1f349b629d858f11f]
stable/6.12: [a9495069b43b8634c1ae0042e888766c34f66637]
stable/6.18: [21ae2cda66a55c759607bbf1d23cbaa42019d2de]
stable/6.6: [07cb6c72e66ba548679f22ac29ad588da8999279]

CVE-2026-31659: batman-adv: reject oversized global TT response buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31659

Introduced by commit 7ea7b4a ("batman-adv: make the TT CRC logic VLAN
specific") in v3.13-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a359bf5c61d52e7f09754108309d637532164a6]
stable/5.10: [7e5d007e0df946bffb8542fb112e0044014a5897]
stable/5.15: [2997f4bd1f982e7013709946e00be89b507693fa]
stable/6.1: [95c71365a2222908441b54d6f2c315e0c79fcec3]
stable/6.12: [f970646b9a39539d1bac86822ac78b5915455ea9]
stable/6.18: [de6c1dc3c7d01a152607e6fcecee4d5288283f10]
stable/6.6: [69d61639bc7e963c3b645e570279d731e7c89062]

CVE-2026-31658: net: altera-tse: fix skb leak on DMA mapping error in
tse_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31658

Introduced by commit bbd2190 ("Altera TSE: Add main and header file
for Altera Ethernet Driver") in v3.15-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dede3967619b5944003227a5d09fdc21ed57d10]
stable/5.10: [ae2cd46f57f422b51aedd406ff5d75cbff401d5d]
stable/5.15: [cb1d318702fdf643061350d164250198df4116f2]
stable/6.1: [d5ec406f0543bd6cdfd563b08015fdec8c4d5712]
stable/6.12: [9f3ec44aeb58501d11834048d5d0dbaeacb6d4e7]
stable/6.18: [60f462cd2716d86bd2174f9d5e035c9278f30480]
stable/6.6: [2eb9d67704ca8f1101f7435b85f113ede471f9f2]

CVE-2026-31657: batman-adv: hold claim backbone gateways by reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31657

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Introduced by commit 04f3f5b ("batman-adv: add B.A.T.M.A.N. Dump BLA
claims via netlink") in v4.9-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82d8701b2c930d0e96b0dbc9115a218d791cb0d2]
stable/6.1: [f4858832ddef2f39f21e30b7226bbcd3c4b2bc96]
stable/6.12: [7962b522222628596ca9ecc8722efc95367aadbd]
stable/6.18: [4dee4c0688443aaf5bbec74aa203c851d1d53c35]
stable/6.6: [2f55b58b5a0bbed192d60c444a45a49cdf1b545f]

CVE-2026-31656: drm/i915/gt: fix refcount underflow in
intel_engine_park_heartbeat

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31656

Introduced by commit 058179e ("drm/i915/gt: Replace hangcheck by
heartbeats") in v5.5-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c71fd099513bfa8acab529b626e1f0097b76061]
stable/5.15: [70d3e622b10092fc483e28e57b4e8c49d9cc7f68]
stable/6.1: [8ce44d28a84fd5e053a88b04872a89d95c0779d4]
stable/6.12: [a00e92bf6583d019a4fb2c2df7007e6c9b269ce7]
stable/6.18: [2af8b200cae3fdd0e917ecc2753b28bb40c876c1]
stable/6.6: [ca3f48c3567dd49efdc55b80029ae74659c682ee]

CVE-2026-31655: pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31655

Introduced by commit 77b0ddb ("soc: imx: add i.MX8MP HDMI blk ctrl
HDCP/HRV_MWR") in v6.1-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e91d5f94acf68618ea3ad9c92ac28614e791ae7d]
stable/6.12: [3086374e8bc7fd65f2cc62ef52351c6d662f1543]
stable/6.18: [e44919669f07b8f113ad49a248b44ca4f119bc94]
stable/6.6: [80fd0de89805a3f92dc320f5ab5a18007c260374]

CVE-2026-31654: mm/vma: fix memory leak in __mmap_region()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31654

Introduced by commit 605f658 ("mm/vma: do not leak memory when
.mmap_prepare swaps the file") in v6.19-rc7.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [894f99eb535edc4514f756818f3c4f688ba53a59]

CVE-2026-31653: mm/damon/sysfs: dealloc repeat_call_control if
damon_call() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31653

Introduced by commit 04a06b1 ("mm/damon/sysfs: use dynamically
allocated repeat mode damon_call_control") in v6.17-rc7.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0199390a6b92fc21860e1b858abf525c7e73b956]
stable/6.18: [b9dadf026a9fb681ed32a0646adc10ab485bf3b1]

CVE-2026-31652: mm/damon/stat: deallocate damon_call() failure leaking damon_ctx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31652

Introduced by commit 405f619 ("mm/damon/stat: use damon_call() repeat
mode instead of damon_callback") in v6.17-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c04c6b47c361612b1d70cec8f7a60b1482d1400]
stable/6.18: [447f8870b484f6596d7a7130e72bd0a3f1e037bb]

CVE-2026-31651: mmc: vub300: fix NULL-deref on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31651

Introduced by commit 88095e7 ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC
driver") in v3.0-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dff34ef879c5e73298443956a8b391311ba78d57]
stable/5.10: [6446516e626ce7c44bdadbcbb3d7677a2c52ce93]
stable/5.15: [ba3b9429de94958dc0060d9816a915dd75c34919]
stable/6.1: [517b58e1d067115f80d198feee10192da4c424d0]
stable/6.12: [53f2642d77ab5f1f303388bff5500363c6cf962c]
stable/6.18: [c83a282615d8f7ba28cebddd54600b419d562d82]
stable/6.6: [6468cab1173f44f7a4b7a05ce8abfdfd1ce1557a]

CVE-2026-31650: mmc: vub300: fix use-after-free on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31650

Introduced by commit dcfdd69 ("mmc: vub300: Use devm_mmc_alloc_host()
helper") in v6.17-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f4d20a710225ec7a565f6a0459862d3b1f32330]
stable/6.18: [ea7468f61be033f4e18b95f2912010ed1d175d75]

CVE-2026-31649: net: stmmac: fix integer underflow in chain mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31649

Introduced by commit 286a837 ("stmmac: add CHAINED descriptor mode
support (V4)") in v3.2-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51f4e090b9f87b40c21b6daadb5c06e6c0a07b67]
stable/5.10: [513e06735f5be575b409d195822195348b164e48]
stable/5.15: [275bdf762e82082f064e60a92448fa2ac43cf95b]
stable/6.1: [a2b68a9a476b9544ff31f1fbcd5d80867a8a5e2f]
stable/6.12: [2c91b39912278d0878f9ba60ba04d2518b18a08d]
stable/6.18: [6fca757c20396dc2e604dcc61922264e9e3dc803]
stable/6.6: [b7b8012193fd98236d7ae05d4b553f010a77b2ef]

CVE-2026-31648: mm: filemap: fix nr_pages calculation overflow in
filemap_map_pages()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31648

Introduced by commit 743a275 ("filemap: cap PTE range to be created to
allowed zero fill in folio_map_range()") in v6.12-rc1.
Fixed in v7.0.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [f58df566524ebcdfa394329c64f47e3c9257516e]
stable/6.12: [633ab680c405ac390e6bec5b74aaf46197c837b6]
stable/6.18: [576543bedd616254032d4ebe54a90076f9e31740]
stable/6.6: [88591194df736a508dd5461ab2167a61e98caac1]

CVE-2026-31647: idpf: fix PREEMPT_RT raw/bh spinlock nesting for async
VC handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31647

Introduced by commit 34c21fa ("idpf: implement virtchnl transaction
manager") in v6.9-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [591478118293c1bd628de330a99eb1eb2ef8d76b]
stable/6.12: [b448529f2f2921c6fe82fd4e985cc7c05cbf02a3]
stable/6.18: [e02c974fc331f04b5ba2007d4bc6862df8a43148]

CVE-2026-31646: net: lan966x: fix page_pool error handling in
lan966x_fdma_rx_alloc_page_pool()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31646

Introduced by commit 11871ab ("net: lan96x: Use page_pool API") in v6.2-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fd0da4fd8851a7e62d009b7db6c4a05b092bc19]
stable/6.12: [305832c53551cfbe6e5b81ca7ee765e60f4fe8e9]
stable/6.18: [b5dcb41ba891b55157006cac79825c78a32b409e]
stable/6.6: [e63265f188ea39dcf5f546770650027528f3bd0f]

CVE-2026-31645: net: lan966x: fix page pool leak in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31645

Introduced by commit 11871ab ("net: lan96x: Use page_pool API") in v6.2-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [076344a6ad9d1308faaed1402fdcfdda68b604ab]
stable/6.12: [73e940c4249dc5ec6422d1fae535d192fb125955]
stable/6.18: [22e1ee9f22b5c3bb702bb6d4167d770002a85b2b]

CVE-2026-31644: net: lan966x: fix use-after-free and leak in
lan966x_fdma_reload()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31644

Introduced by commit 89ba464 ("net: lan966x: refactor buffer reload
function") in v6.12-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59c3d55a946cacdb4181600723c20ac4f4c20c84]
stable/6.12: [691082c0b93c13a5e068c0905f673060bddc204e]
stable/6.18: [92a673019943770930e2a8bfd52e1aad47a1fc1f]

CVE-2026-31643: rxrpc: Fix key parsing memleak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31643

Introduced by commit 0ca100f ("rxrpc: Add YFS RxGK (GSSAPI) security
class") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b555912b9b21075e8298015f888ffe3ff60b1a97]
stable/6.18: [d5f76f812d2c0ea6dd651b0586be49e85ecca085]

CVE-2026-31642: rxrpc: Fix call removal to use RCU safe deletion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31642

Introduced by commit 2baec2c ("rxrpc: Support network namespacing") in
v4.13-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [146d4ab94cf129ee06cd467cb5c71368a6b5bad6]
stable/6.12: [c63abf25203b50243fe228090526f9dbf37727bd]
stable/6.18: [3be718f659683ad89fad6f1eb66bee99727cae64]
stable/6.6: [93fc15be44a35b8e3c58d0238ac0d9b7c53465ff]

CVE-2026-31641: rxrpc: Fix RxGK token loading to check bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31641

Introduced by commit 0ca100f ("rxrpc: Add YFS RxGK (GSSAPI) security
class") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d179a868dd755b0cfcf7582e00943d702b9943b8]
stable/6.18: [3e04596cba8a86cbff9c3f4bf0a524a3a488773c]

CVE-2026-31640: rxrpc: Fix use of wrong skb when comparing queued RESP
challenge serial

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31640

Introduced by commit 5800b1c ("rxrpc: Allow CHALLENGEs to the passed
to the app for a RESPONSE") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b33f5741bb187db8ff32e8f5b96def77cc94dfca]
stable/6.18: [9132b1a7bf83b4a8042fffbc99d075b727a16742]

CVE-2026-31639: rxrpc: Fix key reference count leak from call->key

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31639

Introduced by commit f3441d4 ("rxrpc: Copy client call parameters into
rxrpc_call earlier") in v6.2-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d666540d217e8d420544ebdfbadeedd623562733]
stable/6.12: [e6b7943c5dc875647499da09bf4d50a8557ab0c3]
stable/6.18: [2e6ef713b1598f6acd7f302fa6b12b6731c89914]
stable/6.6: [f1a7a3ab0f35f83cf11bba906b9e948cf3788c28]

CVE-2026-31638: rxrpc: Only put the call ref if one was acquired

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31638

Introduced by commit 5e6ef4f ("rxrpc: Make the I/O thread take over
the call and local processor work") in v6.2-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6331f1b24a3e85465f6454e003a3e6c22005a5c5]
stable/6.12: [0c156aff8a2d4fa0d61db7837641975cf0e5452d]
stable/6.18: [8299ca146489664e3c0c90a3b8900d8335b1ede4]
stable/6.6: [b8f66447448d6c305a51413a67ec8ed26aa7d1dd]

CVE-2026-31637: rxrpc: reject undecryptable rxkad response tickets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31637

Introduced by commit 17926a7 ("[AF_RXRPC]: Provide secure RxRPC
sockets for use by userspace and kernel both") in v2.6.22-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe4447cd95623b1cfacc15f280aab73a6d7340b2]
stable/6.12: [a149dcae23309df9de1c3b6b5d468610ef5ab7de]
stable/6.18: [22f6258e7b31dba9bf88dce4e3ee7f0f20072e60]
stable/6.6: [47073aab8a3a5a7b41c9bd37d2a3dcbeeccd6c8a]

CVE-2026-31636: rxrpc: fix RESPONSE authenticator parser OOB read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31636

Introduced by commit 9d1d2b5 ("rxrpc: rxgk: Implement the yfs-rxgk
security class (GSSAPI)") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e3138007887504ee9206d0bfb5acb062c600025]
stable/6.18: [7875f3d9777bd4e9892c4db830571ab8ac2044c0]

CVE-2026-31635: rxrpc: fix oversized RESPONSE authenticator length check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31635

Introduced by commit 9d1d2b5 ("rxrpc: rxgk: Implement the yfs-rxgk
security class (GSSAPI)") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2567217ade970ecc458144b6be469bc015b23e5]
stable/6.18: [beee051f259acd286fed64c32c2b31e6f5097eb5]

CVE-2026-31634: rxrpc: fix reference count leak in rxrpc_server_keyring()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31634

Introduced by commit 17926a7 ("[AF_RXRPC]: Provide secure RxRPC
sockets for use by userspace and kernel both") in v2.6.22-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f125846ee79fcae537a964ce66494e96fa54a6de]
stable/5.15: [fc76d0bd00850b7372f0a4a319c0c60f80487632]
stable/6.1: [c6d9ea26cf8756ad6f162578e94a5f82f6fae3c2]
stable/6.12: [12de9e0e0b0b7058be7dfb8a5927eb565bc25780]
stable/6.18: [8ee931c3cd97f1c42b4fbf057f04b9dae45dfb7a]
stable/6.6: [9ce36d28f67c2a477a7e2f03480de3f6783fb363]

CVE-2026-31633: rxrpc: Fix integer overflow in rxgk_verify_response()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31633

Introduced by commit 9d1d2b5 ("rxrpc: rxgk: Implement the yfs-rxgk
security class (GSSAPI)") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [699e52180f4231c257821c037ed5c99d5eb0edb8]
stable/6.18: [1f864d9daaf622aeaa774404fd51e7d6a435b046]

CVE-2026-31632: rxrpc: Fix leak of rxgk context in rxgk_verify_response()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31632

Introduced by commit 9d1d2b5 ("rxrpc: rxgk: Implement the yfs-rxgk
security class (GSSAPI)") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e1876caa8363056f58a21d3b31b82c2daf7e608]
stable/6.18: [4b5e8365515f4409de7d3b92a439154ee4f90f6d]

CVE-2026-31631: rxrpc: Fix buffer overread in rxgk_do_verify_authenticator()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31631

Introduced by commit 9d1d2b5 ("rxrpc: rxgk: Implement the yfs-rxgk
security class (GSSAPI)") in v6.16-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f564af387c8c28238f8ebc13314c589d7ba8475d]
stable/6.18: [794586789800b16dcbe235452494f4223ac80413]

CVE-2026-31630: rxrpc: proc: size address buffers for %pISpc output

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31630

Introduced by commit 75b54cb ("rxrpc: Add IPv6 support") in v4.9-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a44ce6aa2efb61fe44f2cfab72bb01544bbca272]
stable/6.18: [db297c78ce537c9ac96f0eda9b25ad72c8caefa9]

CVE-2026-31629: nfc: llcp: add missing return after LLCP_CLOSED checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31629


This bug was introduced by d646960 ("NFC: Initial LLCP support") in v3.3-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b5dd4632966c39da6ba74dbc8689b309065e82c]
stable/6.12: [796e0cac058252d0ad34ebe288e6f7979b5fc9b2]
stable/6.18: [8977fad2b3c6eefd414131168d597c5d1d5e1abf]
stable/6.6: [0eb1263a3b8c36418c9ba295c9ab3abed664edbf]
stable/7.0: [aba4712e8f0381cd5d196534ce2ad082626a5ab6]

CVE-2026-31626: staging: rtl8723bs: initialize le_tmp64 in rtw_BIP_verify()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31626


This bug was introduced by 554c0a3 ("staging: Add rtl8723bs sdio wifi
driver") in v4.12-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c964b82a4e97ec7f25e17b803ee196009b38a57]
stable/6.12: [d5b8f5f8d6fc09a8af5ed139c688660f578ed732]
stable/6.18: [b487a7754d874230299d5a9c2710ec4df8b2ed8a]
stable/6.6: [c65ee4d3be5df395e48afbcd0946dd5fce4338a9]
stable/7.0: [ef74ce5f0bc0e53ce702d8a794f3957884a26efc]

CVE-2026-31625: HID: alps: fix NULL pointer dereference in alps_raw_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31625


This bug was introduced by 73196eb ("HID: alps: add support for Alps
T4 Touchpad device") in v4.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1badfc4319224820d5d890f8eab6aa52e4e83339]
stable/6.12: [8eed7bce7a4c41ab28ee4891103623a12fd41611]
stable/6.18: [0091dfa542a362c178a7e9393097138a57d327d1]
stable/6.6: [c8cc765253ad89ccc106a7bdeb5aeac6cf963078]
stable/7.0: [ee2cb3ddfdca949dbc0c3f796ed5a439f0efc9f6]

CVE-2026-31623: net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31623


This bug was introduced by 87cf656 ("USB host CDC Phonet network
interface driver") in v2.6.31-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [600dc40554dc5ad1e6f3af51f700228033f43ea7]
stable/6.12: [a23b1b1aaf41e174181d5853a70e65d4d01e648c]
stable/6.18: [c183d5775129a0a7495bd61a6e57ec230dcf01e5]
stable/6.6: [d4e1946bea8d6441835eb3fd09b19237ba366a6f]
stable/7.0: [9989938d13cc5ba8447eeed5a61acfcf61bc6801]

CVE-2026-31622: NFC: digital: Bounds check NFC-A cascade depth in SDD
response handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31622


This bug was introduced by 2c66dae ("NFC Digital: Add NFC-A technology
support") in v3.13-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46ce8be2ced389bccd84bcc04a12cf2f4d0c22d1]
stable/6.12: [1bec5698b55aa2be5c3b983dba657c01d0fd3dbc]
stable/6.18: [5a59bf70c38ee1eb4be03bab830bbc3a6f0bd1f1]
stable/6.6: [2819f34e08bdffb6f06a51c67948ec5737fb166a]
stable/7.0: [cc024a3de265ef6c58957f4990eccb9f806208cb]

CVE-2026-31621: bnge: return after auxiliary_device_uninit() in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31621


This bug was introduced by 8ac050e ("bng_en: Add RoCE aux device
support") in v6.19-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b0c25528cb64f71a73b5c0d49cbbcb68540a4ce]
stable/7.0: [87bc3557c708110d83086bf091328271298a44e3]

CVE-2026-31620: ALSA: usx2y: us144mkii: fix NULL deref on missing interface 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31620


This bug was introduced by dee1bcf ("ALSA: usb-audio: Add initial
driver for TASCAM US-144MKII") in v6.18-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48bd344e1040b9f2eb512be73c13f5db83efc191]
stable/6.18: [09b145c1f1331c40dc955c0024d636f25417cddb]
stable/7.0: [d04dd67ab10dc978c6c843c6bd6a2a66a9444f51]

CVE-2026-31619: ALSA: fireworks: bound device-supplied status before
string array lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31619


This bug was introduced by bde8a8f ("ALSA: fireworks: Add transaction
and some commands") in v3.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07704bbf36f57e4379e4cadf96410dab14621e3b]
stable/6.12: [e103f98f6615ed2934e9cf340654f0cad9eb8a8a]
stable/6.18: [67cfd14074cdafab5de3f7cfc0952c1a9b653e5d]
stable/6.6: [f856f4b6efd51be7950e4b84c06cd961961ca41c]
stable/7.0: [682d8accf0d83a871e8c327b95c81f53902c922b]

CVE-2026-31617: usb: gadget: f_ncm: validate minimum block_len in
ncm_unwrap_ntb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31617


This bug was introduced by 2b74b0a ("USB: gadget: f_ncm: add bounds
checks to ncm_unwrap_ntb()") in v5.9-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [8f993d30b95dc9557a8a96ceca11abed674c8acb]
stable/6.12: [8757a2593631443648218244b9788e193ae0fdc1]
stable/6.18: [6762f8a95772265dd0c2ffe7f400493f3115b135]
stable/6.6: [0f156bb5334e588034ca68ac2ee92b23f66e56e7]
stable/7.0: [74908b0318d1df1188457040b8714ff4d4b68126]

CVE-2026-31615: usb: gadget: renesas_usb3: validate endpoint index in
standard request handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31615


This bug was introduced by 746bfe6 ("usb: gadget: renesas_usb3: add
support for Renesas USB3.0 peripheral controller") in v4.5-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f880aac8a57ebd92abfa685d45424b2998ac1059]
stable/6.12: [adb8014599fdf0818d3d93f1f74e06cd0bdec08d]
stable/6.18: [44216e3dd4455b798899b50eedb0ec3831dff8e0]
stable/6.6: [1b2bfedccc4fb8c9572e1ea464f905424c91de2a]
stable/7.0: [e3d42598f2995cdc07b7779874e7c5f8a1b773db]

CVE-2026-31609: smb: client: avoid double-free in smbd_free_send_io()
after smbd_send_batch_flush()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31609


This bug was introduced by 2153812 ("smb: client: make use of
smbdirect_socket.send_io.bcredits") in v7.0-rc1.
Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [27b7c3e916218b5eb2ee350211140e961bfc49be]
stable/6.18: [a9940dcbe5cb92482c04efc7341039ddf7dbf607]
stable/7.0: [f9a162c2bbcd0ac85bd07c5b37cf20286048b65c]

CVE-2026-31608: smb: server: avoid double-free in
smb_direct_free_sendmsg after smb_direct_flush_send_list()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31608


This bug was introduced by 34abd40 ("smb: server: make use of
smbdirect_socket.send_io.bcredits") in v7.0-rc1
Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [84ff995ae826aa6bbcc6c7b9ea569ff67c021d72]
stable/6.18: [6968c91fab05b8fc4d6700e0cf34472bb422df25]
stable/7.0: [830de6eeb9db4cb7e758201fb99328ef4ca4b032]

CVE-2026-31607:  usbip: validate number_of_packets in usbip_pack_ret_submit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31607


This bug was introduced by 1325f85 ("staging: usbip: bugfix add number
of packets for isochronous frames") in v2.6.39-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ab833a16a825373aad2ba7d54b572b277e95b71]
stable/6.12: [8d155e2d1c4102f74f82a2bf9c016164bb0f7384]
stable/6.18: [906f16a836de13fe61f49cdce2f66f2dbd14caf4]
stable/6.6: [885c8591784da6314f9aa82fa460ac69f9f79e5f]
stable/7.0: [5e1c4ece08ccdc197177631f111845a2c68eede3]

CVE-2026-31605: fbdev: udlfb: avoid divide-by-zero on FBIOPUT_VSCREENINFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31605


This bug was introduced by 59277b6 ("Staging: udlfb: add dynamic
modeset support") in v2.6.34-rc1
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a31e4518bec70333a0a98f2946a12b53b45fe5b9]
stable/6.12: [03797cdee38ef19c87785622d423aabaafb71c5f]
stable/6.18: [6de048d78f3029744778b7a2891745f3ca7c209a]
stable/6.6: [cce24f70090e0decb597b88bc52e8ef8efed6105]
stable/7.0: [afaaaa38579f1252bb42b145f6e88a955c4f73f3]

CVE-2026-31604: wifi: rtw88: fix device leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31604


This bug was introduced by a82dfd3 ("wifi: rtw88: Add common USB chip
support") in v6.2-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bbb15e71156cd9f5e1869eee7207a06ea8e96c39]
stable/6.12: [a4f4371d194dfa5473cc961f86194084b1b13a69]
stable/6.18: [89a9c1bc7d797120bcc290864e0cb10a440a677f]
stable/6.6: [f632987306bce9242cdfcf911ee0b2c9455e05a3]
stable/7.0: [25a827b7e1d5747a255bdc757f1d3e9e1e8a4e2a]

CVE-2026-31603: staging: sm750fb: fix division by zero in ps_to_hz()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31603


This bug was introduced by 81dee67 ("staging: sm750fb: add sm750 to
staging") in v4.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75a1621e4f91310673c9acbcbb25c2a7ff821cd3]
stable/6.12: [2f640c6043aeab31a2f607d7605271860c3b11df]
stable/6.18: [1412ba36597a82e928f20047f41d6c6582dafe8a]
stable/6.6: [779412e0e391fd4a0d12e1d1adaa7bf043de62d7]
stable/7.0: [daf6733bd7c4c5015b431739ac29b0e29021096b]

CVE-2026-31602:  ALSA: ctxfi: Limit PTP to a single page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31602


This bug was introduced by 391e691 ("ALSA: ctxfi: Bump playback
substreams to 256") in v3.2-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9418da50d9e5c496c22fe392e4ad74c038a94eb]
stable/6.12: [365c36e1a126c6aa1aecedd3a351bcabc66f0c29]
stable/6.18: [3fd0685d7fef68c2d8a04876bcf9eaa0724ad6a5]
stable/6.6: [452894005b4abe141b11fe01e7bfe152e6d3860f]
stable/7.0: [ad9011a795407093dcf507f6e5da1828987b4b47]

CVE-2026-31601: vfio/xe: Reorganize the init to decouple migration from reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31601


This bug was introduced by 1f5556e ("vfio/xe: Add device specific
vfio_pci driver variant for Intel graphics") in 6.19-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b81ed612e12ea9df8c5cb6f0ddd4419fd0b8ac8]
stable/7.0: [73e53ff144a538f1843b3dea1e2740a755031cdc]

CVE-2026-31600: arm64: mm: Handle invalid large leaf mappings correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31600


This bug was introduced by a166563 ("arm64: mm: support large block
mapping when rodata=full") in v6.18-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15bfba1ad77fad8e45a37aae54b3c813b33fe27c]
stable/6.18: [8140b21d19015227a28c255404462f2d3e6edc9a]
stable/7.0: [cbea627ea634f41c79d18f0c6d20db66fa93514c]

CVE-2026-31599: media: vidtv: fix NULL pointer dereference in
vidtv_channel_pmt_match_sections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31599


This bug was introduced by f90cf60 ("media: vidtv: add a bridge
driver") in v5.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8e1fc918a9fe67103bcda01d20d745f264d00a7]
stable/6.12: [e589de36da106ef739ba98f66f5a5c2023370706]
stable/6.18: [2dff11fb5098ae453651f8f77e94ad499c078022]
stable/6.6: [b7efb4c94797c504a1c678edb48c2aa311d3309f]
stable/7.0: [07c1e474cf9acf777f09d14a8f8dfcef5b84e46f]

CVE-2026-31598: ocfs2: fix possible deadlock between unlink and dio_end_io_write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31598


This bug was introduced by a86a72a ("ocfs2: take ip_alloc_sem in
ocfs2_dio_get_block & ocfs2_dio_end_io_write") in v4.6-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b02da26a992db0c0e2559acbda0fc48d4a2fd337]
stable/6.12: [2b884d52273c60c298bd570163e8053657bbaff6]
stable/6.18: [bc0fb5c7d54c78be43a536df0e20dee32adb27d3]
stable/6.6: [4b80b5a838a32437f2cae0662578bac216a2c51a]
stable/7.0: [e049f7a9bd80b7319590789ea5e1c523d6339d91]

CVE-2026-31597: ocfs2: fix use-after-free in ocfs2_fault() when VM_FAULT_RETRY

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31597


This bug was introduced by commit 614a9e8 ("ocfs2: Remove FILE_IO from
masklog.") in v2.6.39-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7de554cabf160e331e4442e2a9ad874ca9875921]
stable/6.12: [4cf2768a0291a0cdd0dae801ea0eafa3878a349d]
stable/6.18: [d45ff441b416d4aa1af72b1db23d959601c04da2]
stable/6.6: [6f072daefcab1d84ce37c073645615f63be91006]
stable/7.0: [925bf22c1b823e231b1baea761fe8a1512e442f2]

CVE-2026-31596: ocfs2: handle invalid dinode in ocfs2_group_extend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31596


This bug was intrdouced by 10995aa ("ocfs2: Morph the haphazard
OCFS2_IS_VALID_DINODE() checks.") in v2.6.29-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a1c0ddc6e7bcf2e9db0eeaab9340dcfe97f448f]
stable/6.12: [911b557dd7817460881fd51a03069b539c674d0e]
stable/6.18: [e384a850a3370d89a7a446cdeccd964bfba2a302]
stable/6.6: [6575f9fbf084502b7118a628425bf7866666498d]
stable/7.0: [41c6e9bc3a09539deab43957a3211d902a4818f0]

CVE-2026-31595: PCI: endpoint: pci-epf-vntb: Stop cmd_handler work in
epf_ntb_epc_cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31595


This bug was introduced by e35f56b ("PCI: endpoint: Support NTB
transfer between RC and EP") in v6.0-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [d799984233a50abd2667a7d17a9a710a3f10ebe2]
stable/6.12: [6773cc24c004930903a57761132c1e7728907f8f]
stable/6.18: [9921cce25bfe4021f6e55ca995351eb967165297]
stable/6.6: [ceb73484e7204f661f770069ecdf35f6e941879c]
stable/7.0: [fbb6c353fa2fb5f5f990eda034a1074b0356127e]

CVE-2026-31594: PCI: endpoint: pci-epf-vntb: Remove duplicate resource teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31594


This bug was introduced by e35f56b ("PCI: endpoint: Support NTB
transfer between RC and EP") in v6.0-rc1.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [0da63230d3ec1ec5fcc443a2314233e95bfece54]
stable/6.12: [73bf218de28d039126dc64281d2b47dd3c46a0a3]
stable/6.18: [cec9ead73ab154a7953f6ab8dd5127e0d6bbf95a]
stable/6.6: [e238ab12556b00f3b4d8b870b32ba1e4f4d4ebc2]
stable/7.0: [a7a3cab4d33fd8a8aed864c447d0d7c99e85404e]

CVE-2026-31593:  KVM: SEV: Reject attempts to sync VMSA of an
already-launched/encrypted vCPU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31593


This bug was introduced by ad27ce1 ("KVM: SEV: Add
KVM_SEV_SNP_LAUNCH_FINISH command") in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b9f7962e3e879d12da2bf47e02a24ec51690e3d]
stable/6.12: [c9609847ae65ca36233077c2b6cb2bc0fb37c77a]
stable/6.18: [692fdf05e55fa03960a1278afdc2478c12daea13]
stable/7.0: [8f85a4885eee8cb495961ffa371a91828afb9445]

CVE-2026-31592: KVM: SEV: Protect *all* of
sev_mem_enc_register_region() with kvm->lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31592


This bug was introduced by 1e80fdc ("KVM: SVM: Pin guest memory when
SEV is active") in v4.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ff93ff0ba82e9511770e175fa50682a1ab14fb6]
stable/6.18: [35a0963d361f98bba798fd15d229dcb166c04684]
stable/7.0: [0ff93ff0ba82e9511770e175fa50682a1ab14fb6]

CVE-2026-31591: KVM: SEV: Lock all vCPUs when synchronzing VMSAs for
SNP launch finish

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31591


This bug was introduced by ad27ce1 ("KVM: SEV: Add
KVM_SEV_SNP_LAUNCH_FINISH command") in v6.11-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb923ee6a80f4e604e6242a4702b59251e61a380]
stable/6.18: [30fd9d8c82087742168db779929d8be0459b0716]
stable/7.0: [c87938fc7d99a06a7e5477c45b4e5a4148f85d66]

CVE-2026-31590: KVM: SEV: Drop WARN on large size for
KVM_MEMORY_ENCRYPT_REG_REGION

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31590


This bug was introduced by 78824fa ("KVM: SVM: fix svn_pin_memory()'s
use of get_user_pages_fast()") in v5.9-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8acffeef5ef720c35e513e322ab08e32683f32f2]
stable/6.12: [ab423e5892826202a660b5ac85d1125b0e8301a5]
stable/6.18: [28cc13ca20431b127d42d84ba10898d03e2c8267]
stable/6.6: [b670833749ffd8681361db2bb047c6f2e3075f3a]
stable/7.0: [1cba4dcd795daf6d257122779fb6a349edf03914]

CVE-2026-31589: mm: call ->free_folio() directly in folio_unmap_invalidate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31589


This bug was introduced by fb7d3bc ("mm/filemap: drop
streaming/uncached pages when writeback completes") in v6.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [615d9bb2ccad42f9e21d837431e401db2e471195]
stable/7.0: [c330e65ea59c4805d6ab6757c4ddfe8c63acef31]

CVE-2026-31588: KVM: x86: Use scratch field in MMIO fragment to hold
small write values

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31588


This was introduced by f78146b ("KVM: Fix page-crossing MMIO") in v3.5-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b16e69d17d8c35c5c9d5918bf596c75a44655d3]
stable/6.12: [b5a02d37eb0739f462fa12df449ab9b3480c783b]
stable/6.18: [22d2ff69d487a32a8b88f9c970120fc2daa08a77]
stable/6.6: [dc6a6c3db3a4eca7e747cfc46e22c08d016c68f7]
stable/7.0: [3a7b6d75c8f85b09dea893f64a85a356bcf6c3fe]

CVE-2026-31587:  ASoC: qcom: q6apm: move component registration to
unmanaged version

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31587


This bug was introduced by 5477518 ("ASoC: qdsp6: audioreach: add
q6apm support") in v5.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ec1235fc941dac6c011b30ee01d9220ff87e0cd]
stable/6.12: [b7412ed789ffb1e59c8d6f5ab6a6a718963c85e2]
stable/6.18: [30383b7780ffa140bc124de5b66cae7c84133dbb]
stable/6.6: [887632163b546a8944b46ef465f1d74e838b727a]
stable/7.0: [a561a55b79a9c55f0443377f2d4dcf6149d057af]

CVE-2026-31586: KVM: SEV: Protect *all* of
sev_mem_enc_register_region() with kvm->lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31586


This bug was introduced by 59b5771 ("blkcg: delay blkg destruction
until after writeback has finished") in v4.19-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f5857be99f1ed1fa80991c72449541f634626ee]
stable/6.12: [dfc8292a1d6782c76b626315605e0585a5a18447]
stable/6.18: [ea3af09eb87d8f8708c66747fcf1a2762902e839]
stable/6.6: [115a5266749dcde7fe4127e8623d19c752088f69]
stable/7.0: [67cb119d32f35e32acd0393bbeb318b2bb1fdafe]

CVE-2026-31585: media: vidtv: fix nfeeds state corruption on
start_streaming failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31585


This bug was introduced by f90cf60 ("media: vidtv: add a bridge
driver") in v5.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0e5a598fe9a4612b852406b51153b881592aede]
stable/6.12: [98c22210aeadce67d9d20059f0dbbd01ba7fdbba]
stable/6.18: [25f19e476ab15defe698504212899fdb9f7cd61b]
stable/6.6: [17cb7957c979529cc98ff57f7ac331532f1f7c83]
stable/7.0: [4bf95f797edd63c93330eafb6d6e670982344b9b]

CVE-2026-31584: media: mediatek: vcodec: fix use-after-free in encoder
release path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31584


This bug was introduced by 0934d37 ("media: mediatek: vcodec: separate
decoder and encoder") in v6.6-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76e35091ffc722ba39b303e48bc5d08abb59dd56]
stable/6.12: [a8a55913552aed45108525d1851c65e1db0cc25b]
stable/6.18: [f99353cd0e9f58bf17889049137b8d65fb44ebf1]
stable/6.6: [9a9bdaf9dc42ccca50e53f82165292f74a365c11]
stable/7.0: [f1692337c6fa26e04f89b22a4d84bf5b7ada50d1]

CVE-2026-31583: media: em28xx: fix use-after-free in em28xx_v4l2_open()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31583


This bug was introduced by 8139a4d ("[media] em28xx: move v4l2 user
counting fields from struct em28xx to struct v4l2") in v3.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a66485a934c7187ae8e36517d40615fa2e961cff]
stable/6.12: [5fb2940327722b4684d2f964b54c1c90aa277324]
stable/6.18: [871b8ea8ef39a6c253594649f4339378fad3d0dd]
stable/6.6: [b5d141ea15f173f15b9f0a72965902f3428c0d92]
stable/7.0: [dd2b888e08d3b3d6aacd65d76cd44fac11da750f]

CVE-2026-31582: hwmon: (powerz) Fix use-after-free on USB disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31582


This bug was introduced by 4381a36 ("hwmon: add POWER-Z driver") in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08e57f5e1a9067d5fbf33993aa7f51d60b3d13a4]
stable/6.12: [c78e1d4e48f23792adaa7c94251e22b0d9700a39]
stable/6.18: [9e1b798257f96d2e2a2639830eb71add545ce749]
stable/7.0: [61f2aa23b0ce8d7aa5071ed25a7471e246a4fdd4]

CVE-2026-31581: ALSA: 6fire: fix use-after-free on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31581


This bug was introduced by a0810c3 ("ALSA: 6fire: Release resources at
card release") in v6.13-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [b9c826916fdce6419b94eb0cd8810fdac18c2386]
stable/6.12: [af75b486f7e883e3422ece23c8d727e6815144a0]
stable/6.18: [d21e8a2af4869b5890b34e081d5aeadc93e9cd5c]
stable/6.6: [e88354b381e2006de63d6b052ed7005c9a47d00e]
stable/7.0: [51f6532790b74ffdd6970bc848358a2838c1c185]

CVE-2026-31580: bcache: fix cached_dev.sb_bio use-after-free and crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31580


This bug was introduced by cafe563 ("bcache: A block layer cache") in v3.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fec114a98b8735ee89c75216c45a78e28be0f128]
stable/6.12: [add4982510f3b7c318a2dd7438bdc9c63171e753]
stable/6.18: [2d6965581e164fa2ba3f7652ddae5535f6336576]
stable/6.6: [47fa09fe7f3e09df28a51cb2cbd8f5d2f7f6edc1]
stable/7.0: [383f7fec0de8cee1cf7ae1f9d9f14044a61f10f9]

CVE-2026-31579: wireguard: device: use exit_rtnl callback instead of
manual rtnl_lock in pre_exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31579


This bug was introduced by 900575a ("wireguard: device: avoid circular
netns references") in v5.8-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60a25ef8dacb3566b1a8c4de00572a498e2a3bf9]
stable/6.18: [9a9e69155b2091b8297afaf1533b8d68a3096841]
stable/7.0: [a1d0f6cbb962af29586e3e65a4bced1a5e39221f]

CVE-2026-31578: media: as102: fix to not free memory after the device
is registered in as102_usb_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31578


This bug was introduced by cd19f7d ("[media] as102: fix leaks at
failure paths in as102_usb_probe()") in v3.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bd29dbe03fc5b0f039ab2395ff37b64236d2f0c]
stable/6.12: [582fbecb3756330006fe1950762412a68c2cacd2]
stable/6.18: [09e9206008b887aa553733bd915d73131071a086]
stable/6.6: [cb8092038e95dc1113a68e63762de40fff61ba71]
stable/7.0: [7e5aedf6059cba2a669d86caeaf5a51f33ec85a1]

CVE-2026-31577: nilfs2: fix NULL i_assoc_inode dereference in
nilfs_mdt_save_to_shadow_map

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31577


This bug was introduced by e897be1 ("nilfs2: fix lockdep warnings in
page operations for btree nodes") in v5.18-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [4a4e0328edd9e9755843787d28f16dd4165f8b48]
stable/6.12: [449ec5fc99f45974525ba9eea16b6670c45cd363]
stable/6.18: [c36e206f302f1ddefed92d09ecbba070e1ae079e]
stable/6.6: [7318e3549518ce8f14776a489d86488d80d7e2c8]
stable/7.0: [97fb7afec404912d967a7d4715f37742666b3084]

CVE-2026-31576: media: hackrf: fix to not free memory after the device
is registered in hackrf_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31576


This bug was introduced by 8bc4a9e ("[media] hackrf: add support for
transmitter") in v4.4-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b7da2b4d0fe014eff181ed37e3bf832eb8ed258]
stable/6.12: [98a0a81ce78020c2522e0046f49d200de9778cb9]
stable/6.18: [07e9e674b6146b1f6fc41b1f54b8968bf2802824]
stable/6.6: [45cbaf5c7cdc5386d86377f0daf94a17a007fed0]
stable/7.0: [fcd1d70792a35c8a97414fe429f48311e41269c2]

CVE-2026-31575:  mm/userfaultfd: fix hugetlb fault mutex hash calculation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31575


This bug was introduced by a08c719 ("mm/filemap: remove hugetlb
special casing in filemap.c") in v6.7-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0217c7fb4de4a40cee667eb21901f3204effe5ac]
stable/6.12: [5a525c43baaba0bf3063f86996ca3623b71e4172]
stable/6.18: [574501ede47ac439afd67ba9812bc66722d500ba]
stable/7.0: [f4689fc089765d36c026063fb22d23533e883eb6]

CVE-2026-31574:  clockevents: Add missing resets of the next_event_forced flag

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31574


This bug was introduced by d6e152d ("clockevents: Prevent timer
interrupt starvation") in v7.0.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4096fd0e8eaea13ebe5206700b33f49635ae18e5]
stable/7.0: [9401b593fa48218d2667df1610b0ebc518554880]

CVE-2026-31573: media: verisilicon: Fix kernel panic due to __initconst misuse

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31573

Introduced by commit e0203dd ("media: verisilicon: Avoid G2 bus error
while decoding H.264 and HEVC") in v7.0-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8d97c270cb46a2a88739019d0f8547adc7d97da]

CVE-2026-31572: i2c: designware: amdisp: Fix resume-probe race condition issue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31572

Introduced by commit d6263c4 ("i2c: amd-isp: Add ISP i2c-designware
driver") in v6.16-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2f1ada8e089dd5a331bcd8b88125ae2af8d188f]
stable/6.18: [83bcea9da91965484df64a6492b89e65d41ab31c]

CVE-2026-31571: drm/i915: Unlink NV12 planes earlier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31571

Introduced by commit 6a01df2 ("drm/i915: Remove pointless visible
check in unlink_nv12_plane()") in v6.15-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfa71b7a9dc6b5b8af157686e03308291141d00c]
stable/6.18: [70e2eb91cb6310a3508439f6f2539dfffa0abf77]

CVE-2026-31570: can: gw: fix OOB heap access in cgw_csum_crc8_rel()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31570

Introduced by commit 456a8a6 ("can: gw: add support for CAN FD
frames") in v5.4-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9c310d72783cc2f30d103eed83920a5a29c671a]
stable/5.10: [e7c99348b0612b2bc02d5ce6ff9873261cc7605f]
stable/5.15: [999ca48d55a8a46da21519db7e834e5867200379]
stable/6.1: [a025283d7f7404c739225e457fb99db2368bb544]
stable/6.12: [c4e8eaa75fa0b6bcbfa5356d6195c4ad0e05e57a]
stable/6.18: [84f8b76d24273175a22713e83e90874e1880d801]
stable/6.6: [54ecdf76a55e75c1f5085e440f8ab671a3283ef5]

CVE-2026-31569: LoongArch: KVM: Handle the case that EIOINTC's coremap is empty

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31569

Introduced by commit 3956a52 ("LoongArch: KVM: Add EIOINTC read and
write functions") in v6.13-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b97bd69eb0f67b5f961b304d28e9ba45e202d841]
stable/6.18: [126053d0a685bf1f2e98db8966386f38b2336338]

CVE-2026-31568: s390/mm: Add missing secure storage access fixups for
donated memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31568

Introduced by commit 084ea4d ("s390/mm: add (non)secure page access
exceptions handlers") in v5.7-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b00be77302d7ec4ad0367bb236494fce7172b730]
stable/6.18: [b36b0e804aee5f20c6798dbeaeaa7cfdb7c6cf88]

CVE-2026-31567: PM: sleep: Drop spurious WARN_ON() from pm_restore_gfp_mask()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31567

Introduced by commit 35e4a69 ("PM: sleep: Allow pm_restrict_gfp_mask()
stacking") in v6.18-rc4.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a8d51efb5929ae308895455a3e496b5eca2cd143]
stable/6.18: [3025ca5daa9d682b629c0c958b538e41deeb559d]

CVE-2026-31566: drm/amdgpu: Fix fence put before wait in amdgpu_amdkfd_submit_ib

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31566

Introduced by commit 9ae55f0 ("drm/amdgpu: Follow up change to
previous drm scheduler change.") in v6.0-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7150850146ebfa4ca998f653f264b8df6f7f85be]
stable/6.1: [bc7760c107dc08ef3e231d72c492e67b0a86848b]
stable/6.12: [138e42be35ff2ce6572ae744de851ea286cf3c69]
stable/6.18: [39820864eacd886f1a6f817414fb8f9ea3e9a2b4]
stable/6.6: [e23602eb0779760544314ed3905fa6a89a4e4070]

CVE-2026-31565: RDMA/irdma: Fix deadlock during netdev reset with
active connections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31565

Introduced by commit c8f304d ("RDMA/irdma: Prevent QP use after free")
in v6.4-rc5.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [6f52370970ac07d352a7af4089e55e0e6425f827]
stable/5.15: [009831768faeca3fb5950ce63f1b49594ec82389]
stable/6.1: [adf0de36e52a48681eb58cbd7cbf6c8d200caa2b]
stable/6.12: [a8a1c7621127a15a02494b96ee376406c064237b]
stable/6.18: [cd8bcec2de5e24e05c34c9391940fda6f50e79b4]
stable/6.6: [acb060bc2609c2eab49263968be59c7d59d497bc]

CVE-2026-31564: LoongArch: KVM: Fix base address calculation in
kvm_eiointc_regs_access()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31564

Introduced by commit d3e43a1 ("LoongArch: KVM: Use 64-bit register
definition for EIOINTC"). in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bcfb7f46d667b04bd1a1169ccedf5fb699c60df]

CVE-2026-31563: net: macb: Use dev_consume_skb_any() to free TX SKBs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31563

Introduced by commit 6bc8a50 ("net: macb: Fix tx_ptr_lock locking") in
v6.17-rc5.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [647b8a2fe474474704110db6bd07f7a139e621eb]
stable/6.1: [92e7081f0c79d9073087e54bab745bb184192c2e]
stable/6.12: [984350b37372f79f71d4f0a5264c640e40daf9ce]
stable/6.18: [f4bc91398b579730284328322365afa77a9d568f]
stable/6.6: [78c8b090a3d5c1689dc989861b0163180db2b3f8]

CVE-2026-31562: drm/mediatek: dsi: Store driver data before invoking
mipi_dsi_host_register

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31562

Introduced by commit e4732b5 ("drm/mediatek: dsi: Register DSI host
after acquiring clocks and PHY") in v6.9-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cfdfeb6ac06079f92fccd977fa742d6c5b8dd3a]
stable/6.18: [9a709b7e36324dfc1e6728eb81405470b7ae84e5]

CVE-2026-31561: x86/cpu: Remove X86_CR4_FRED from the CR4 pinned bits mask

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31561

Introduced by commit ff45746 ("x86/cpu: Add X86_CR4_FRED macro") in v6.9-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [411df123c017169922cc767affce76282b8e6c85]
stable/6.12: [d7853d9fe94abf43b46c57b0b7f8418198b7615a]
stable/6.18: [a6e14114684d2324e5401617d6d01acb4a4e0e22]

CVE-2026-31558: LoongArch: KVM: Make kvm_get_vcpu_by_cpuid() more robust

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31558

Introduced by commit 73516e9 ("LoongArch: KVM: Add vcpu mapping from
physical cpuid") in v6.10-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2db06c15d8c7a0ccb6108524e16cd9163753f354]
stable/6.12: [596c3f8069c4792f22fce8c4452f44410032d910]
stable/6.18: [878cf6acb4fd8ab4126cf9d369a5bb0e23123418]

CVE-2026-31556: xfs: scrub: unlock dquot before early return in quota scrub

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31556

Introduced by commit 7d1f0e1 ("xfs: check the ondisk space mapping
behind a dquot") in v6.8-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [268378b6ad20569af0d1957992de1c8b16c6e900]
stable/6.12: [e822f535273af0e8968eab7acc0cea0b90dd25af]
stable/6.18: [3b0c3414b308e6822cda90bf99f7eac94d4cca2b]

CVE-2026-31555: futex: Clear stale exiting pointer in futex_lock_pi() retry path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31555

Introduced by commit 3ef240e ("futex: Prevent exit livelock") in v5.5-rc1.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [210d36d892de5195e6766c45519dfb1e65f3eb83]
stable/5.10: [33095ae3bdde5e5c264d7e88a2f3e7703a26c7aa]
stable/5.15: [e7824ec168d2ac883a213cd1f4d6cc0816002a85]
stable/6.1: [5e8e06bf8909e79b4acd950cf578cfc2f10bbefa]
stable/6.12: [7475dfad10a05a5bfadebf5f2499bd61b19ed293]
stable/6.18: [92e47ad03e03dbb5515bdf06444bf6b1e147310d]
stable/6.6: [de7c0c04ad868f2cee6671b11c0a6d20421af1da]

CVE-2026-31554: futex: Require sys_futex_requeue() to have identical flags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31554

Introduced by commit 0f4b5f9 ("futex: Add sys_futex_requeue()") in v6.7-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [19f94b39058681dec64a10ebeb6f23fe7fc3f77a]
stable/6.12: [027145ace09fad4c7cbcd6c61fe9b429c63eb0e5]
stable/6.18: [18b7d09c2b794c71d4252f3ea2cf84ad12b73d6a]

CVE-2026-31553: KVM: arm64: Fix the descriptor address in __kvm_at_swap_desc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31553

Introduced by commit f6927b4 ("KVM: arm64: Add helper for swapping
guest descriptor") in v6.19-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0496acc42fb51eee040b5170cec05cec41385540]

CVE-2026-31552: wifi: wlcore: Return -ENOMEM instead of -EAGAIN if
there is not enough headroom

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31552

Introduced by commit e75665d ("wifi: wlcore: ensure skb headroom
before skb_push") in v6.19-rc4.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [deb353d9bb009638b7762cae2d0b6e8fdbb41a69]
stable/5.10: [980f793645540ca7a6318165cc12f49d5febeb99]
stable/5.15: [12f9eef39e49716c763714bfda835a733d5f6dea]
stable/6.1: [ceb46b40b021d21911ff8608ce4ed33c1264ad2f]
stable/6.12: [cfa64e2b3717be1da7c4c1aff7268a009e8c1610]
stable/6.18: [46c670ff1ff466e5eccb3940f726586473dc053c]
stable/6.6: [a6dc74209462c4fe5a88718d2f3a5286886081c8]

CVE-2026-31551: wifi: mac80211: Fix static_branch_dec() underflow for
aql_disable.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31551

Introduced by commit e908435 ("mac80211: introduce aql_enable node in
debugfs") in v5.12-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b94ae8e0d5fe1bdbbfdc3854ff6ce98f6876a828]
stable/5.15: [787152497ac763deab16f6f4b7ce79aaeb3eb7e8]
stable/6.1: [8bb90ff77326c34e75b573b1febdd9586fec5aba]
stable/6.12: [29a1a350afcd28a2150bd73b8bd83eac3480f13e]
stable/6.18: [5ba05436f15d16ae7ab04b880e8bf8d440be892b]
stable/6.6: [256f7d4c11235d0569f78413c41dc89d2dc1557c]

CVE-2026-31550: pmdomain: bcm: bcm2835-power: Increase ASB control timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31550

Introduced by commit 670c672 ("soc: bcm: bcm2835-pm: Add support for
power domains under a new binding.") in v5.1-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b826d2c0b0ecb844c84431ba6b502e744f5d919a]
stable/5.10: [0e84e74849d2d7e9b23a09c2d5e0d9357db1ca59]
stable/5.15: [c5e734f6a0740dce92e7c919e632cb43fa5d4e53]
stable/6.1: [622ab02e955c35c125ff2b65d8327b2c52db8758]
stable/6.12: [ea4fa54b83bb2e4a21e9026824bfe271b1a6ee1e]
stable/6.18: [18605b1b936b66b1f34dcf8e9ad4f1fbcf7a7c13]
stable/6.6: [9443202d91388026dbf7312972a74fbfd27ee82f]

CVE-2026-31549: i2c: cp2615: fix serial string NULL-deref at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31549

Introduced by commit 4a76954 ("i2c: cp2615: add i2c driver for Silicon
Labs' CP2615 Digital Audio Bridge") in v5.13-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa79f996eb41e95aed85a1bd7f56bcd6a3842008]
stable/5.15: [e68c267787778bcdf3d91b06f794faaba7f0d1d1]
stable/6.1: [4a22af879172336370ae3e81e7f65fb2f69472ee]
stable/6.12: [13ccf9b106bba121728f1625c4375a1bd8f5c5a3]
stable/6.18: [a9778298f47036866ea15eeb17242e8a4612580f]
stable/6.6: [69aece634a7eebafd9a596e5494d52facf6f26ec]

CVE-2026-31548: wifi: cfg80211: cancel pmsr_free_wk in cfg80211_pmsr_wdev_down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31548

Introduced by commit 9bb7e0f ("cfg80211: add peer measurement with FTM
initiator API") in v5.0-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dccbc9f3e1d38565dff7730d2b7d1e8b16c9b09]
stable/6.1: [28d3551f8d8cb3aec7497894d94150fe84d20e5e]
stable/6.12: [d32c07ef1880fe20cf4ab223dbfedc9c0b2816aa]
stable/6.18: [a1b7a843f12a0c3e9d3a2ca607ce451916ef42cf]
stable/6.6: [37e776e2e0a523731e2470dce6d563f0e8632a40]

CVE-2026-31547: drm/xe: Fix missing runtime PM reference in ccs_mode_store

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31547

Introduced by commit 480b358 ("drm/xe: Do not wake device during a GT
reset") in v6.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [65d046b2d8e0d6d855379a981869005fd6b6a41b]

CVE-2026-31546: net: bonding: fix NULL deref in bond_debug_rlb_hash_show

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31546

Introduced by commit caafa84 ("bonding: add the debugfs interface to
see RLB hash table") in v2.6.38-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [605b52497bf89b3b154674deb135da98f916e390]
stable/5.10: [19f0fd87df0e5746b24f5caa465a66a8c6e6e241]
stable/5.15: [edacf1613f7b26423ebfa8b2892e7453c4235354]
stable/6.1: [2ec2c777f357a83c3d503d8d9370c90b60f0ae63]
stable/6.12: [6a3bb74e25d79cbb15f67ef80f71e2b2bfe27ff4]
stable/6.18: [017d674cf6930e9586a29ee808c7ca09d1396d07]
stable/6.6: [0a3f8cd3f370247ded14d38d216b49dd30eade76]

CVE-2026-31545: NFC: nxp-nci: allow GPIOs to sleep

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31545

Introduced by commit 4320176 ("NFC: nxp-nci: Convert to use GPIO
descriptor") in v5.4-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55dc632ab2ac2889b15995a9eef56c753d48ebc7]
stable/5.10: [0c2320c3c860d281cbc2f49fc574c1947a6b9e2a]
stable/5.15: [2a175bc3c338c6b2bc55004e93dd35a2467bdca2]
stable/6.1: [c24dcac1a9d1b4fd164898df0c2f5b0adbf81a78]
stable/6.12: [548a1bfe591364e63bce4af7c5802bb434efdaf8]
stable/6.18: [4de9ed2ea22d611b4149969266b45a86ea8daf35]
stable/6.6: [70662874f646871c2f08ef1cf2544ba9a5f71b96]

CVE-2026-31544: firmware: arm_scmi: Fix NULL dereference on notify error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31544

Introduced by commit b5daf93 ("firmware: arm_scmi: Avoid notifier
registration for unsupported events") in v6.17-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [555317d6100164748f7d09f80142739bd29f0cda]
stable/6.18: [70d9bd9a2e683afe6200b0c20af22f06f1a199a4]

CVE-2026-31543: crash_dump: don't log dm-crypt key bytes in
read_key_from_user_keying

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31543

Introduced by commit 479e585 ("crash_dump: store dm crypt keys in
kdump reserved memory") in v6.16-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36f46b0e36892eba08978eef7502ff3c94ddba77]
stable/6.18: [4897bd307ba8757c31a3325ba6730961be606016]

CVE-2026-31542: x86/platform/uv: Handle deconfigured sockets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31542

Introduced by commit 8a50c58 ("x86/platform/uv: UV support for
sub-NUMA clustering") in v6.5-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f6aa5bbf1d0f81a8a2aafc16136e7dd9a609ff3]
stable/6.12: [9956d4892e78812246336c7ea51f5aa62018049e]
stable/6.18: [79f0faf81d3bbbe5f07bf6892450d3740a1b290d]
stable/6.6: [c51957601d32c0d195bce0b9345dfe93ef5728cc]

CVE-2026-31541: tracing: Fix trace_marker copy link list updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31541

Introduced by commit 7b382ef ("tracing: Allow the top level
trace_marker to write into another instances") in v6.16-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07183aac4a6828e474f00b37c9d795d0d99e18a7]
stable/6.18: [75668e58244e63ec3785098a02e1cdcff14a6c2e]

CVE-2026-31540: drm/i915/gt: Check set_default_submission() before deferencing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31540

Introduced by commit ff44ad5 ("drm/i915: Move engine->submit_request
selection to a vfunc") in v4.12-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0162ab3220bac870e43e229e6e3024d1a21c3f26]
stable/5.15: [db8b1bebe81ffb410ddd746b6869f72e22420850]
stable/6.1: [da6552d67012a1cf0585f2eb401d0c4abcf108c9]
stable/6.12: [2e20a886b443a71b573ceaed3ca7053d15380916]
stable/6.18: [cf4b224ffb9a58181be32b64130fc36cf59c3192]
stable/6.6: [df1f4a7d9cf689b4e96c95255228896505f44c31]

CVE-2026-31539: smb: smbdirect: introduce
smbdirect_socket.recv_io.credits.available

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31539

Introduced by commit 5fb9b45 ("smb: client: count the number of posted
recv_io messages in order to calculated credits") in v6.18-rc1.
Introduced by commit 89b021a ("smb: server: manage recv credits by
counting posted recv_io and granted credits") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e3c5052f9686192e178806e017b7377155f4bab]
stable/6.18: [e811e60e1cc79923c4388146eb1fa26a7482731e]

CVE-2026-31538: smb: server: make use of
smbdirect_socket.recv_io.credits.available

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31538

Introduced by commit 89b021a ("smb: server: manage recv credits by
counting posted recv_io and granted credits") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26ad87a2cfb8c1384620d1693a166ed87303046e]
stable/6.18: [66c082e3d4651e8629a393a9e182b01eb50fb0a3]

CVE-2026-31535: smb: client: make use of
smbdirect_socket.recv_io.credits.available

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31535

Introduced by commit 5fb9b45 ("smb: client: count the number of posted
recv_io messages in order to calculated credits") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9911b1ed187a770a43950bf51f340ad4b7beecba]
stable/6.18: [f664e6e8a81103cb45c8802a9bc7499e0902c458]

CVE-2026-31673: af_unix: read UNIX_DIAG_VFS data under unix_state_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31673

Introduced by commit 5f7b056 ("unix_diag: Unix inode info NLA") in v3.3-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39897df386376912d561d4946499379effa1e7ef]
stable/6.12: [0c739f3785f84af695952c2bac8be2f45082c9b8]
stable/6.18: [900a4e0910e98b8caef117d5df00471fa438dcf9]
stable/6.6: [b9232421a77a649c9376c99fdfc8cb7f79cad34c]

CVE-2026-31674: netfilter: ip6t_rt: reject oversized addrnr in rt_mt6_check()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31674

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d3f027327c2fa265f7f85ead41294792c3296ed]
stable/5.10: [13e3e30ed3b5b67cc1db2bd58a5d09b0f07debfa]
stable/5.15: [af9b7e2b765966457f4ec23be5bd34a141f89574]
stable/6.1: [29ea965a1353bc8303877422f79c8211e9ba9c55]
stable/6.12: [ded71f5684df16fa645cca5bf4fe6b0cd8a46119]
stable/6.18: [d8795fde1f78669a87c87ac29fceab2f104daa8c]
stable/6.6: [c6a503a9f4debc654e3a6a7ca1f7fce6a9953c59]

CVE-2026-31675: net/sched: sch_netem: fix out-of-bounds access in
packet corruption

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31675

Introduced by commit c865e5d ("[PKT_SCHED] netem: packet corruption
option") in v2.6.20.16.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d64cb81dcbd54927515a7f65e5e24affdc73c14b]
stable/6.12: [13a66ca1e235d4bcd53d12d4c68490cad7f8e46f]
stable/6.18: [3a2999704ac36cfb4041fed3652d26a3373e8d12]
stable/6.6: [a14b56863348686dd0387eea8ce66b85cf455908]

CVE-2026-31676: rxrpc: only handle RESPONSE during service challenge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31676

Introduced by commit 17926a7 ("[AF_RXRPC]: Provide secure RxRPC
sockets for use by userspace and kernel both") in v2.6.22-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c43ffdcfdbb5567b1f143556df8a04b4eeea041c]
stable/6.12: [29b44d904dceb832be880def08b8cb17a0aba91c]
stable/6.18: [d0035e634dae83237ab7f5681eb52b2f65d0ceb8]
stable/6.6: [a6bcf8010af093fe04f7100562e9542ab7882585]

CVE-2026-31677: crypto: af_alg - limit RX SG extraction by receive buffer budget

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31677

Introduced by commit e870456 ("crypto: algif_skcipher - overhaul
memory management") in v4.14-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8eceab19eba9dcbfd2a0daec72e1bf48aa100170]
stable/6.12: [9bf3e6ccfdcfe56ae3190d1ae987dacf1cfef4f9]
stable/6.18: [07c6f6ffe29009426f0bd4d3cfbb6308b8ea8453]

CVE-2026-31678: openvswitch: defer tunnel netdev_put to RCU release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31678

Introduced by commit a9020fd ("openvswitch: Move tunnel destroy
function to oppenvswitch module.") in v4.3-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6931d21f87bc6d657f145798fad0bf077b82486c]
stable/6.1: [9d56aced21fb9c104e8a3f3be9b21fbafe448ffc]
stable/6.12: [bbe7bd722bfaea36aab3da6cc60fb4a05c644643]
stable/6.18: [98b726ab5e2a4811e27c28e4d041f75bba147eab]
stable/6.6: [42f0d3d81209654c08ffdde5a34b9b92d2645896]

CVE-2026-31679: openvswitch: validate MPLS set/set_masked payload length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31679

Introduced by commit fbdcdd7 ("Change in Openvswitch to support MPLS
label depth of 3 in ingress direction") in v5.5-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [546b68ac893595877ffbd7751e5c55fd1c43ede6]
stable/5.10: [68f32ef0683c8d1c05cd2e4f16818fa63ff59c6f]
stable/5.15: [4cae986225f8b8679ad86b924918e7d75a96aa61]
stable/6.1: [8ed7b9930cbc3bc71f868fa79a68700ac88d586a]
stable/6.12: [98de18d327ef8cbbb704980e359e4872d8c28997]
stable/6.18: [bd50c7484c3bb34097571c1334174fb8b7408036]
stable/6.6: [c1f97152df8dfb17e855ddf0fc409b7bd13e9700]

CVE-2026-31680: net: ipv6: flowlabel: defer exclusive option free
until RCU teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31680

Introduced by commit d3aedd5 ("ipv6 flowlabel: Convert hash list to
RCU.") in v3.9-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ca562bb8e66978b53028fa32b1a190708e6a091]
stable/5.10: [4b6798024f7b2d535f3db1002c760143cdbd1bd3]
stable/5.15: [3c54b66c83fb8fcbde8e6a7bf90b65856e39f827]
stable/6.1: [5a6b15f861b7c1304949e3350d23490a5fe429fd]
stable/6.12: [8027964931785cb73d520ac70a342a3dc16c249b]
stable/6.18: [414726b69921fe6355ae453f5b35e68dd078342a]
stable/6.6: [6c7fbdb8ffde6413640de7cfbd7c976c353e89f8]

CVE-2026-31681: netfilter: xt_multiport: validate range encoding in checkentry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31681

Introduced by commit a89ecb6 ("[NETFILTER]: x_tables: unify IPv4/IPv6
multiport match") in v2.6.20.16.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff64c5bfef12461df8450e0f50bb693b5269c720]
stable/6.12: [aec14808271f2bf2b656de6ff12dfe73c5fd3b67]
stable/6.18: [8368ce8eb01f0b91111d814703696e780d0ef12f]
stable/6.6: [36bf0d98e180a7c384c8d8a59b0d2d4b80e5eb16]

CVE-2026-31682: bridge: br_nd_send: linearize skb before parsing ND options

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31682

Introduced by commit ed842fa ("bridge: suppress nd pkts on
BR_NEIGH_SUPPRESS ports") in v4.15-rc1.
Fixed in v7.0-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a01aee7cafc575bb82f5529e8734e7052f9b16ea]
stable/5.10: [c68433fd291c9e88c00292095172c62d1997d662]
stable/5.15: [4f397b950c916e9a1f8a4fce04ea0110206cad47]
stable/6.1: [bd91ec85aa4c77d645bd2739fc56784157a88ca2]
stable/6.12: [2ba4caba423ed94d63006eb1d2227b0332ab7fcd]
stable/6.18: [9c55e41c73af5c4511070933b1bd25248521270c]
stable/6.6: [658261898130da620fc3d0fbb0523efb3366cb55]

CVE-2026-31683: batman-adv: avoid OGM aggregation when skb tailroom is
insufficient

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31683

Introduced by commit c6c8fea ("net: Add batman-adv meshing protocol")
in v2.6.38-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d4aef630be9d5f9c1227d07669c26c4383b5ad0]
stable/5.10: [67176c96f325837b0bb3e9538ca2eba414f447d8]
stable/5.15: [0b10a8b355c3f71012ce89289ec2c2f5e3bfd6c1]
stable/6.1: [6755347c5f9bdd44dee80f692208b056fcd40a52]
stable/6.12: [6e40ebb999c2c3d2fbb3cacb61f0384ee6e69075]
stable/6.18: [0e35db29fc5a97a8553f7c2d3a2ba730e46b1ee8]
stable/6.6: [1ada20331f2df2a942d6b83ae1f04a304b642e2a]

CVE-2026-31684: net: sched: act_csum: validate nested VLAN headers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31684

Introduced by commit 2ecba2d ("net: sched: act_csum: Fix csum calc for
tagged packets") in v5.1-rc1.
Fixed in v7.0.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [c842743d073bdd683606cb414eb0ca84465dd834]
stable/6.12: [a69738efea0996d05a3c7d2178551b891744df1b]
stable/6.18: [ec4930979b3f7bbeb7af5744599fc6603a4dba62]
stable/6.6: [eb3765b90eb8f2a3d6310a80c14a9e57ec4267a2]

CVE-2026-31685: netfilter: ip6t_eui64: reject invalid MAC header for all packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31685

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdce0b3590f724540795b874b4c8850c90e6b0a8]
stable/6.12: [9eda5478746ef7dc0e4e537b5a5e4b0ca1027091]
stable/6.18: [807d6ee15804df6f01a35c910f09612e858739a6]
stable/6.6: [288138418bef956f8b295751a4536c60f0e89f4a]

CVE-2026-31686: mm/kasan: fix double free for kasan pXds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31686

Introduced by commit 0207df4 ("kernel/memremap, kasan: make
ZONE_DEVICE with work with KASAN") in v4.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51d8c78be0c27ddb91bc2c0263941d8b30a47d3b]
stable/6.12: [a05f77cb227c39c5069aea6f12762a29d1e6c103]
stable/6.18: [f6204f7ff6aff62ce6242a76982c5ba3a9ded707]
stable/6.6: [cec74b2ab7dff866b1d77eaa545b9e8fd14a1f87]
stable/7.0: [b38237a2ea9c6c19836eee2c57037e1f9f103576]

CVE-2026-31687: gpio: omap: do not register driver in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31687

Introduced by commit dc23806 ("driver core: enforce device_lock for
driver_match_device()") in v7.0-rc1.
Introduced by commit 11a78b7 ("ARM: OMAP: MPUIO wake updates") in v2.6.22-rc1.
Fixed in v6.19-rc8.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
cip/4.19-st: [e38585cd2e47b673d1a82e25e323fcc68c32a1b8]
cip/4.4-st: [5d0a5d906ff5a9d06fe4ac76342c7aad27389dfa]
mainline: [730e5ebff40c852e3ea57b71bf02a4b89c69435f]
stable/5.10: [57bcd3feffa79544c73a1a1872472389a391cc79]
stable/5.15: [86588916e1887a5edb8a9161cd7ae81e47a7ed25]
stable/6.1: [a29215961d833f4de33a09c3964d31ebc6083033]
stable/6.12: [2211d77892913804d16c28c7415b82804ab1e54c]
stable/6.18: [32f08c3ddd6dda6cbb6c9d715de10f21dccde50f]
stable/6.6: [1c04c3a4de8d4bcb9202f94c44f26c57c2572308]

CVE-2026-31688: driver core: enforce device_lock for driver_match_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31688

Introduced by commit 49b420a ("driver core: check bus->match without
holding device lock") in v2.6.30-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc23806a7c47ec5f1293aba407fb69519f976ee0]
stable/6.12: [cd0e0a76e40c2e77bcfc88291d00dca22b00158e]
stable/6.18: [8d76b2488eb3cc0717ab81b60622cff4a5f90f79]
stable/6.6: [adc1796eced46b48e23ec200a219d635f33a38ee]

CVE-2026-31689: EDAC/mc: Fix error path ordering in edac_mc_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31689

Introduced by commit 0bbb265 ("EDAC/mc: Get rid of silly one-shot
struct allocation in edac_mc_alloc()") in v5.19-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51520e03e70d6c73e33ee7cbe0319767d05764fe]
stable/6.1: [aae95970fad2127a1bd49d8713c7cd0677dcd2d6]
stable/6.12: [d20e98c2df9354cc744431ad8ccbf49405b8b40f]
stable/6.18: [87ce8ae511962e105bcb3534944208c6a9471ed9]
stable/6.6: [d3de72e2a2b9ee3a57734c1c068823e41a707715]

CVE-2026-31690: firmware: thead: Fix buffer overflow and use standard
endian macros

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31690

Introduced by commit e4b3cbd ("firmware: thead: Add AON firmware
protocol driver") in v6.15-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88c4bd90725557796c15878b7cb70066e9e6b5ab]
stable/6.18: [fbdb43f6bb2a15ed382d6eb0ef82c8b07b0d47bb]

CVE-2026-31691: igb: remove napi_synchronize() in igb_down()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31691

Introduced by commit 2c61960 ("igb: Add AF_XDP zero-copy Rx support")
in v6.14-rc1.
Fixed in v7.0.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1e067240379f950a0022208e0685f3465c211cb]
stable/6.18: [4700471775746058c962ded6e659bf908fd76e13]

CVE-2026-31786: Buffer overflow in drivers/xen/sys-hypervisor.c

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31786


This bug was introduced by d71f513 ("xen: privcmd: support
autotranslated physmap guests.") in v3.8-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24daca4fc07f3ff8cd0e3f629cd982187f48436a]

CVE-2026-31787: xen/privcmd: fix double free via VMA splitting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31787


This bug was introduced by 84b7625 ("xen: add sysfs node for
hypervisor build id") in v4.13-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27fdbab4221b375de54bf91919798d88520c6e28]


* Updated CVEs

CVE-2025-54505: x86/CPU: Fix FPDSS on Zen1

stable/7.0 was fixed.

Fixed status
stable/7.0: [546785c719418c6166834a47e372a88f5f7ae893]

CVE-2025-22125: md/raid1,raid10: don't ignore IO flags

stable/6.6 was fixed.

Fixed status
stable/6.6: [10f4ff4baeb6951cf58282954318827b6852d501]

CVE-2025-38531: iio: common: st_sensors: Fix use of uninitialize device structs

stable/6.6 was fixed.

Fixed status
stable/6.6: [f9d4b618f1b9e6d760cc7c15052b92f7faf47201]

CVE-2026-23255: net: add proper RCU protection to /proc/net/ptype

stable/6.6 was fixed.

Fixed status
stable/6.6: [002a73470b56848e4c81efeaaedd471e92d66d8d]

CVE-2026-23302: net: annotate data-races around sk->sk_{data_ready,write_space}

stable/6.6 was fixed.

Fixed status
stable/6.6: [7ad01905831c815520f1b0486336a03bb7420465]

CVE-2026-23313: i40e: Fix preempt count leak in napi poll tracepoint

stable/6.6 was fixed.

Fixed status
stable/6.6: [fa5d5baf67f619c7aa70697a194b5a9edd9f5bb7]

CVE-2026-23330: nfc: nci: complete pending data exchange on device close

stable/6.6 was fixed.

Fixed status
stable/6.6: [9df613ef6e8e873cdab969a11f74823488977f1f]

CVE-2026-23374: blktrace: fix __this_cpu_read/write in preemptible context

stable/6.6 was fixed.

Fixed status
stable/6.6: [aaba6ee63ba65b026401c94e2dd16b9f6e895934]

CVE-2026-23389: ice: Fix memory leak in ice_set_ringparam()

stable/6.6 was fixed.

Fixed status
stable/6.6: [e0c211a0c26159058303712d6b4fbd1c88835e6d]

CVE-2026-23399: nf_tables: nft_dynset: fix possible stateful
expression memleak in error path

stable/6.6 was fixed.

Fixed status
stable/6.6: [e6661add2d9c6913e1dad97336595e23a2bed195]

CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths

stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.18: [c5cedee5d97382176573bbe21e1724e737a5eb64]
stable/6.6: [50352fc103928e10e8729abc79a0d05abef26c4d]

CVE-2026-23444: wifi: mac80211: always free skb on
ieee80211_tx_prepare_skb() failure

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [3b4d27acafaeab478fd24f79ad6e593a892828b9]
stable/6.6: [f77b51bcee7be2bb686b5f7a2d4a1921e4bdb9f4]

CVE-2026-31407: netfilter: conntrack: add missing netlink policy validations

stable/6.6 was fixed.

Fixed status
stable/6.6: [c5e918390002edf0cff80a0e7ce1f86f16a9507c]

CVE-2026-31429: net: skb: fix cross-cache free of KFENCE-allocated skb head

stable/6.6 was fixed.

Fixed status
stable/6.6: [128b03ccb2582a643983a48a37fda58df80edbde]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

