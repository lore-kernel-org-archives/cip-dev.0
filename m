Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A0CC98304
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 00:27:06 +0000 (UTC)
Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1105.1790209622727588001
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Sep 2026 17:27:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=bg4sBigT;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.141, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-8716a5baf64so20031797b3.3
        for <cip-dev@lists.cip-project.org>; Wed, 23 Sep 2026 17:27:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790209622; cv=none;
        d=google.com; s=arc-20260327;
        b=q/kp3dVThiwjE1xMXWr4LIhsdNk7i0zNJGP4m8Wk93NYjkOIvjwRrDCOrDU+zaN6Ml
         KdXOpXtLDbgAMNTM5Q0dk5+j4bR3xmnZGQ9ip6g/5hjzv4bb5OVjRh32RBwwyNJO0Nzi
         J4qbxiaiT0LR7FNz289KeSslHcjAy3RMB+3OX4YjbvoUcSFekDk4R4Jw+rdu/On5x1z1
         dvPz5ZIUuXObmG2uNBpunlIzApP46QSUECYxTlExS+Y1MQKZgqU8x/pGNCc3+uvF5k6e
         hbu06UXew+252oVMOHfuhyI9o7sZvFkslqQ8Jv8SFtPG5nCjeGLVTsY3MXs+KHiME3JR
         DKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nLw5Cq6i0ORna8LK4PxOwYNg4dprqVbdlxt5OpwmOB4=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=ej3rTHYla9JpWVrs02GFVsN0TkaPvuXooipH9pc0deqAAlatpJwfodPrrzE/vfQTRA
         hwW4ldNbyCZj9WsXBieI5OD95odTQZv8eg3U0PXbmbaZCoXJBn+/lnGjDFJm8MhdI803
         +YCOSabwWVevSpZUARtW2fTErrFL36fcZJ5/Ol5ZjF3FNkOb7zUjmrQf/ubVj0AnIXM2
         1MtXpuOJmYnw8ZvvGhbQRzDT+U/5WMD7+PxWt8J/NT/IihmzlnZM2FXoH7dAgAD94YP2
         iPJxBWQzI5UYUTs4Krix4Vrgyu7mKHZuUm/UhoVunc1my/+Cyursi2LHxbiD6xI1XnZ+
         AJjA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1790209622; x=1790814422; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nLw5Cq6i0ORna8LK4PxOwYNg4dprqVbdlxt5OpwmOB4=;
        b=bg4sBigTrsjrw+LwLI5Km5wMiWnzVua9vlUVA/IPI+AvJyayhykg3pxC9zxz8mjazW
         p7HSfYD682lgTmFc0Wn83sNcMB0HBJFs5fdL4ohQhgZ7O24f+TE9dShRS1Y5uhYUek2g
         aylri/MvB75sQfk8aJToA2IO98YBlAte26BI5e7a7q/Xe4CCEeLENelIh+WRKdOVdSY4
         QFNbEtBhBTrOFaB1jBfnKMKLLYUEu8BbtuXuDaVaUSeR0Z/BTRoXtmZu6rYUm/z3F7mp
         hWSHq8d1Q25pY6o7c8761wqQfaof19Bygx+YGXuRXOy/w0v5y0Edd3HUOuKTk+BZ6EfO
         EGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790209622; x=1790814422;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nLw5Cq6i0ORna8LK4PxOwYNg4dprqVbdlxt5OpwmOB4=;
        b=eTUtEopyDn0sdKihtH89+OWnBTeNntfKsMrY401Rsv/7x6bJKQjGh1Zxt6hEkYZu26
         8KzqrPBfpbFtRqv7dB3h+DC0YktD7yMTl5V6va5yb7PUCvcTy4UkNEzkbHMjhEn8KZRO
         1gHrGDcJV8354c9R2fyPli8RKNbcUfg67c9RnJSLxQ+VLm9Dg/y9u6J4VvuJ0GIn1RR8
         nEB3SOobRptheGU1SXNf99H+G57XyJULuQMpr44nzjAXRzUQQ5MBHFui+M7CFCWD2PNE
         ONJnf71ZS0FJEYt3XqeOu5cxAahK6Z/1bUPbku6GO6itXD1YhQTtS3hB5XmikBu9OQTb
         XQoQ==
X-Gm-Message-State: AFuF++kecq1zFm4EdCvRoKrAITi3B7ftulL+eVrvXlSuTy3AIF8NRw3I
	62Znpd2xjSC9s3FxjfyDuUb6GQmhhCfaqYcVm+yH3UzdckmKP0Z1AJY6Ib9W/kFX3T7fAJuaCQU
	bfd0xbhvKQMMz6yBgtqy4aXUhOlW8pbazh6v6RzqMX5CDIIUjaoDw140DBQ==
X-Gm-Gg: AYBFou3kdV1EkMWJRBvZCCqcMlof/J9ed2nQ5xTDWF6NKqWz33qeX2Weq4zA/V2R25y
	CGi6LnMwNLmlgo88xIFPqxV/M+5nsQC6g3Kh33BKpt5lj2rNeSzR0gmPHPIVoT2q45U9k1Uhnbj
	gsU6iZy6n4RANe3bNprg72PHQT1mCE7JuSa5/mzcAn85WmMGlP4hQc/dlLIbf7eNOqmV7Mh39v8
	AyYxsq0oSFfH5FGaQ/CHwPuZDPdZR/cAdZmzXaSlw4lkazhuNJlJQ2uw6LXFXRExkIORPTterKz
	mUjg7V01L5cWuYt9qobmieL8t88NY9cCjZb/lFd6/EIJVcTkAtRj1+5L3SEGBcNqirsBTOMlRbj
	MI90r9Z64DqYg4u1m5gJoZgsGf64=
X-Received: by 2002:a05:690c:c507:b0:8a6:1090:8047 with SMTP id
 00721157ae682-8a64c32aaedmr4755617b3.38.1790209616587; Wed, 23 Sep 2026
 17:26:56 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Sep 2026 09:26:19 +0900
X-Gm-Features: AclHuK-rRF_AJD1_V5h8ajIMezEQJJAzs7EE6VepY3I9hUDyC1OymWmDcdg7eQs
Message-ID: <CAODzB9p9c2Z6Ok8W7viEoEfO8d2iiFnVrMT90uhmbvZVrUVP+A@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 00:27:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24284

Hi!

It's this week's CVE report.

This week reported 603 new CVEs and 80 updated CVEs.

* New CVEs
CVE-2026-90050: net/sched: fq: clamp quantum and initial_quantum in change path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90050

Introduced by commit 709f34f ("net/sched: fq: add overflow bounds to
quantum and initial quantum") in v7.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.18 stable/7.2

Fixed status
mainline: [094cc07f98dfe70a34e2a1923af17fd29b8cf622]
stable/6.12: [a27498d34c3f429fb6db3aa609569f8154afa175]
stable/6.18: [798283cd0fe7ba997f67e5a917f14ab40afa8d9f]
stable/7.2: [72e9387884554f47b03bfd40fb8b2bf52789c68d]

CVE-2026-90051: tcp: reject non zerocopy devmem tx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90051

Introduced by commit bd61848 ("net: devmem: Implement TX path") in v6.16-rc1.
Introduced by commit d9c5650 ("net: tcp: block mixing readable and
unreadable frags") in v7.3-rc1.
Fixed in v7.3-rc3.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.2

Fixed status
mainline: [125755776bc6d4dd53eaf551c87e3d460625d638]
stable/6.18: [2151b2bcf6fcec52665f606eed20da068447f0b7]
stable/7.2: [b04326c7927af7048fd4e730f5770cca350d0a60]

CVE-2026-90052: dm-integrity: fix buffer overflow with keyed discard

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90052

Introduced by commit 68c5c42 ("dm-integrity: replace forgeable discard
filler with a keyed sector marker") in v7.3-rc1.
Fixed in v7.3-rc2.

Bug introduced commit was backported to following branches.
stable/6.18 stable/7.2

Fixed status
mainline: [59e6f919d77d72ec79cbf171256f2f7819737580]
stable/6.18: [9988c1c9e0d1c78391e3d8e2817beb667470c76f]
stable/7.2: [dd08a645195f410f2dcaa40de379a45ce110e873]

CVE-2026-90053: net/sched: sch_htb: limit htb_classify inner-class filter hops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90053

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [729c4896ab829169f95915d65edd530325910b37]
stable/5.15: [83bb11805b620c498d6417e0e409f26887981489]
stable/6.1: [90a149ab1f8344b7f713e9a838f69fde9e8d2a51]
stable/6.12: [8c9611f7ba3ea5594e41bac952363aa0966d3280]
stable/6.18: [e54be9aa503a0297b63aec530fbf760350effd45]
stable/6.6: [010d05df52cec053bdc67d82c5b61cc4996f3fde]
stable/7.2: [872317e84fd019ceffba125e62d31586e3336d41]

CVE-2026-90054: tcp: fix corruption of urgent data on multi-segment retransmit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90054

Introduced by commit 10d3be5 ("tcp-tso: do not split TSO packets at
retransmit time") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce2b807f42ed5e55567b8864ab72963f90779270]
stable/5.10: [8eb51013b6308870479a64b4a2a018697b997849]
stable/5.15: [711bfd762bec05fb19bc3b17cbb157c39f4e66da]
stable/6.1: [3d4e005c198dc410ad568f832bffa7569c059ff8]
stable/6.12: [ebe55406404f3cb28e36d2b668e2c6c05026ec29]
stable/6.18: [b8f08a94b2a4addc39249dcf9c792e786108621b]
stable/6.6: [4fd2ee4ac154c204d95d8db72221446dac5af9b8]
stable/7.2: [47eb90299e6882d6445672530dd7c51ac33ebdbd]

CVE-2026-90055: usb: atm: usbatm: fix invalid ci_range initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90055

Introduced by commit c59bba7 ("[PATCH] USB ATM: new usbatm core") in
v2.6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a60fd8c6dbaa76da4163cf225ed2b9e982540f39]
stable/5.10: [8442586526c406527bf31206e538c0ce6bc672e6]
stable/5.15: [561cbd6d49022c9a383e22a39c87a165a4d39f9c]
stable/6.1: [76bc7c3a44856744b64aa91d9afe6d9522a78c42]
stable/6.12: [1e964d414bfd9f8dfe9948d08e4b9dda4ed2e422]
stable/6.18: [ff7f77a234f7b74e5955a6e34fa74eca4c9ca44c]
stable/6.6: [7baa0c92be39eb3da755ed6f200497a57078c47b]
stable/7.2: [75667703115154a4fd9cf259d4f826d8729cbcda]

CVE-2026-90056: net: fec: only stop PTP if it was initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90056

Introduced by commit 32cba57 ("net: fec: introduce fec_ptp_stop and
use in probe fail path") in v4.2-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd890ae29299636fb037276fc1b5238698d08b03]
stable/5.10: [0dc8b3a395c3a749ab62c078f2fd54a402ae7e2b]
stable/5.15: [1973f108c481fab9bdc7daa6c77442af4a7388ab]
stable/6.1: [0602a4c238d2b6ed6e2bf5fa8ef7fa0203883dac]
stable/6.12: [383f699a86fd04458dc47d10578c17e94f63d92f]
stable/6.18: [1f9639caeece703012bdb23975ebedf70f426269]
stable/6.6: [7566789664813c1778f0d4b7e0539fd863ea450c]
stable/7.2: [5975009651c4e5ec1492612962d0dd3dc86f6bda]

CVE-2026-90057: slip: remove slip_hangup() to fix use-after-free in
slip_receive_buf()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90057

Introduced by commit 5342b77 ("slip: Clean up create and destroy") in
v2.6.32-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23c53269f2baaedf2d92784290cb9ef6db2a3bce]
stable/6.1: [9a3b1edff1ecb47d323f2506b3ffc22178acd1c6]
stable/6.12: [de1f978c0f6ab42b28192d74dc59af52fdc76135]
stable/6.18: [ddbc5dc5a2e29b3934da09c1ba3c930fd8a40fd6]
stable/6.6: [a2dbac3fb03b4427ccf057debc83fc61ee102529]
stable/7.2: [a540a49fcca59d1c92c3a6462e67ca21676a88df]

CVE-2026-90058: net/sched: bound qdisc_pkt_len to prevent qdisc soft lockup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90058

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f735d64382dcf162f4276d6699d03ad2f859c0b]
stable/5.10: [4f0f4b09a95ef602fbdae948326beadd9c20eab3]
stable/5.15: [0bc5a6280a132a2170c6fa742436e01b635f02de]
stable/6.1: [448c34421b38ec7c93a0060a885218ca319d382b]
stable/6.12: [6e78792d8ce1fa3561713860ee8086901dde4f99]
stable/6.18: [1a5c26e586481bc82abc19ac92c3d9f10518f525]
stable/6.6: [82fdbf49b9f7528c82bf608cfa9710e5f81a198c]
stable/7.2: [16d21a27df3f50b7251c9388fc5a7ab22703b469]

CVE-2026-90059: net: stmmac: restore NET_IP_ALIGN in the RX DMA offset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90059

Introduced by commit df542f6 ("net: stmmac: Switch to zero-copy in
non-XDP RX path") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23680bf5f8c69c923546b84a8e6c401bef8b88fe]
stable/6.18: [2ea42936416b29cca42b2c7bc7d3d3768f77c199]
stable/7.2: [c0d3f9560cc890bc2d96d9f487584688ae6e5185]

CVE-2026-90060: ALSA: control: Don't add invalid kcontrols to LED layer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90060

Introduced by commit 22d8de6 ("ALSA: control - add generic LED trigger
module as the new control layer") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74e3b979ce8b78a690f8b94ccf2e2c965f7f5c11]
stable/6.1: [6e152cbfac3a2a62f79df7d23d621917c20367eb]
stable/6.12: [3d20cd049fc5f51f80e24a2db7a3cf00593c79e4]
stable/6.18: [2f0c97b1a32fba8e81a69f6231aa0b3c9b6bc581]
stable/7.2: [18c08f84ca483029f04e426ec7ca3b5d3684cf22]

CVE-2026-90061: netfilter: nf_tables: skip double clone set
expressions on element insert

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90061

Introduced by commit 6503842 ("netfilter: nf_tables: allow to specify
stateful expression in set definition") in v5.7-rc1.
Introduced by commit fca05d4 ("netfilter: nft_dynset: honor stateful
expressions in set definition") in v5.11-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [43559058d21e0493aa220ac167e0279334dea5f9]
stable/7.2: [1e7fb6801d9cc826adcdb7fa0533c397730657f2]

CVE-2026-90062: netfilter: nf_tables: move hardware offload step after
building the chain blob

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90062

Introduced by commit c9626a2 ("netfilter: nf_tables: add hardware
offload support") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b1881d362e1924b66f6016c3efd28807032b41bf]
stable/5.10: [923f824f30faebc5560c3061a595063cecdbdbb8]
stable/5.15: [6e7ad6e69be4751ab2476042c70c600bdaa8d4f2]
stable/6.1: [309acbab74e46114246bf4346c9b60b3d8cb4fcd]
stable/6.12: [52febaf1d311d6ede312b2ec7692a309714f9554]
stable/6.18: [d5497644329d3a01e951aba76561bbd883ff6b0c]
stable/6.6: [79eafe22ab0a650996da2b3e5d94a12c3e16f3aa]
stable/7.2: [6a7d3b074cfbb64513f5f92d60ab1b216ae98076]

CVE-2026-90063: virtio-net: Ensure that TCP packets don't overflow gso_segs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90063

Introduced by commit 7c6d2ec ("net: be more gentle about silly gso
requests coming from user") in v5.7.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [c27c449d455aafd9018a3cbab150f1c42c87923f]
stable/5.15: [d3d111fe809773edbb4ae121e36253b7d683509a]
stable/6.1: [8f6667a081887c2b59c6f3dd86c1789ada563762]
stable/6.12: [29bd12c7c5f9d6cf855b87bace18f71e9607f9e8]
stable/6.18: [0e5ed3b98d1d8d251acfdccfeaa607453ad12954]
stable/6.6: [339f47ae04dcc6b5a730dd6bc70dddc8937c3260]
stable/7.2: [75c271c48f483af678e514734e10b2452410e08c]

CVE-2026-90064: drm/xe: Reject page faults from non-fault-mode scratch VMs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90064

Introduced by commit ad9843a ("drm/xe/madvise: Implement purgeable
buffer object support") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e977521d21717edb8e91d004434697d6e3f248c]
stable/7.2: [905d648e97ef3a291f71a935a7fab0133f27f0f7]

CVE-2026-90065: net/smc: release the internal TCP sock on IPPROTO_SMC
socket creation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90065

Introduced by commit d25a92c ("net/smc: Introduce IPPROTO_SMC") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cec261b0b4c5c0b044165303198d10ffcdf3414c]
stable/6.12: [2f4ece7fed6d915ec64b7735962c0d84d6261032]
stable/6.18: [84180988a455fd8e147c6b35c8df65d8b8cc76c2]
stable/7.2: [94a913cd521c0f0408820bcdbd80dadf076d97b5]

CVE-2026-90066: samples/ftrace: Fix kthread_stop() on ERR_PTR in
ftrace-direct-multi-modify

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90066

Introduced by commit e1067a0 ("ftrace/samples: Add module to test
multi direct modify interface") in v5.16-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6727b7618f49401acf373fa3ec5712e2ec52e5cf]
stable/6.12: [98b7b2a29ae87937aa02ab9391543ef8c602cd94]
stable/6.18: [626614df9080d7052fbe24dc90b5434717ab7a9f]
stable/6.6: [7a96b9f6d5ba23dbce66c8a4a242effd4c01a830]
stable/7.2: [cf839636911d8313f3ecd098329fd0b96499e4cf]

CVE-2026-90067: libceph: validate banner payload length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90067

Introduced by commit cd1a677 ("libceph, ceph: implement msgr2.1
protocol (crc and secure modes)") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f374967fcdf04001c9b66df1c19106fa83cd91f7]
stable/5.15: [279c0852999fd2384f4a88155091a99e81f96873]
stable/6.1: [6cf666e47f2b51d5a887ec8a3226cde951757d27]
stable/6.12: [c1b937ff24b19e69aa7fb1b0f46a74d4c9668692]
stable/6.18: [6d1c6f228854aa89844fd0152d7ed7ac72a55e89]
stable/6.6: [3b2e62a7655d347a845a91155610ddae11daffc6]
stable/7.2: [c77633a9595658210a6e216a071e5a396a0835a7]

CVE-2026-90068: ASoC: dapm: Fix off-by-one check on the second enum channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90068

Introduced by commit 3727b49 ("ASoC: dapm: Consolidate MUXs and value
MUXs") in v3.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [14511c9b54ceeeef487409d73947c89ee8563590]
stable/5.10: [57ab955bde747327fb2042516ae1b7192c30e881]
stable/5.15: [806fa4e1f2bf73c54bc4b6360790ecc69d095ca5]
stable/6.1: [496081b4edc1f6e662418831c5b14cddd8d7920c]
stable/6.12: [32fc048391112559c34cb88d13594546939a4cd6]
stable/6.18: [10a36512c21f861a03fba461a7ead09023df9c1b]
stable/6.6: [faf539af1a595a26e5a081a4e512caee2bc2f4c5]
stable/7.2: [55126ef66298e43c69f192acebae8c7cc0022cf6]

CVE-2026-90069: crypto: acomp - allocate async request context when cloning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90069

Introduced by commit 097c432 ("crypto: acomp - Add
ACOMP_REQUEST_CLONE") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee440d4fc0d2f15894ab1f64c474a3adbc858880]
stable/6.18: [d48197cbd5d3476c7deea644972e9ec510865ec2]
stable/7.2: [889fa17a0af09ff93a9166abc82ee7a654faa49b]

CVE-2026-90070: tpm: st33zp24: Return zero on status read failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90070

Introduced by commit 251a7b0 ("TPM: STMicroelectronics ST33 I2C KERNEL
3.x") in v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b92687708f5ef980de01c2042dbd76d11f78547]
stable/5.10: [d732cfc4befe28f02ec82ed5fd2bc2a21fbabd42]
stable/5.15: [4973e8386257eed10e5433a94a53bcc6ec37d2a1]
stable/6.1: [981307e2e8a930da492c2bcf763865c47c2a5165]
stable/6.12: [38c26fe4522963a91d4fb02c844d8faa740fe9d1]
stable/6.18: [14feaa498c20c1b7ddefe27de5329aaff822cc0d]
stable/6.6: [1bfd5c54e40704ce93d128a25de3d8dd772bf183]
stable/7.2: [e6d7d9b665419cda3e9f91030d81c9f8ba71e51d]

CVE-2026-90071: net/sched: sch_teql: restore skb->dev on the slave failure path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90071

Introduced by commit 0cc0c2e ("net/sched: teql: fix NULL pointer
dereference in iptunnel_xmit on TEQL slave xmit") in v7.0-rc4.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [dc4b95b8fee95113587e93ca116356032d271371]
stable/5.10: [1360bc93f5be1be3cf937ebea667b3418dd30a79]
stable/5.15: [d453bf439ef230b5743afc25e194adacca8c6e43]
stable/6.1: [012559cf3c67ce8825a31d4f66b040b6fbaf775e]
stable/6.12: [00d8a387b23b7831ad9919256a6b9caaa10f19c3]
stable/6.18: [96bc345a3f17543d0d92ada609e02198d6380e26]
stable/6.6: [aa39a790d56b40bfcf3861653ceb46a3a113adb6]
stable/7.2: [0cd75037948567193f7f5767176538822ce23873]

CVE-2026-90072: net/sched: sfq: clamp quantum to avoid signed overflow
soft lockup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90072

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [816e90057ab1879562a5b7cc688e35bb9027ae97]
stable/5.10: [86799499585af06a9431c9e7782658667bd62650]
stable/5.15: [2017c355a5a1af77736cd1739fe922f69b5652dc]
stable/6.1: [6581a82bf08ba5d4e2a6d4e3080df43315b296c4]
stable/6.12: [d72dbdfaeb5b9b8d884e0e036c3442754379ef74]
stable/6.18: [aeb8196ecb95146e3410f635628e6cd47352b3e5]
stable/6.6: [9d782c662879c3adaaca30e05c36910ad11b9e54]
stable/7.2: [da16c31517cd2c06bb2c78c73e91ae192c01c426]

CVE-2026-90073: net/sched: hhf: clamp quantum before hhf_change() to
avoid overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90073

Introduced by commit 10239ed ("net-qdisc-hhf: Heavy-Hitter Filter
(HHF) qdisc") in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2164b512b97bb053e8ce4d6e95576f11bed6a005]
stable/5.10: [2e0f0729f922c8de13801004e2131b57646c7c5f]
stable/5.15: [0c66223e90ddb4fd3700965a9241f2fde7bd6bc7]
stable/6.1: [20b65bf7ca06e48ec1d62ed8012f71205328dbe4]
stable/6.12: [fa9c2055f0a60f801ccf286af53d387dc6202c3f]
stable/6.18: [99770b5d8e0e1c69b996f74a19d71afd2c4a9aa4]
stable/6.6: [dea2789a9d5ff38bdd77f2e64d550430899e2839]
stable/7.2: [2446644b0f6d045b01db6acbaf55552dbec8a59a]

CVE-2026-90074: net/sched: fq_pie: clamp default quantum to avoid
signed overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90074

Introduced by commit ec97ecf ("net: sched: add Flow Queue PIE packet
scheduler") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c86cd7ed0b0e44779a3d1683f03e4353baf4bdc9]
stable/5.10: [1f43e4dbc93b7d02761a024d5f895df823c07b72]
stable/5.15: [f7942b2693bc24c7d609a03d06f97bee3b0bd96a]
stable/6.1: [6f1be05faecef4c0f9a008200209f66ef2e133f7]
stable/6.12: [44dad8fe99b58a7fe2961e9eec6a5f07ace5b51f]
stable/6.18: [044fa2498bbc2900f0c48a6ef2fdd5b2bdfc3795]
stable/6.6: [435da3734a8e63d3067016accc977ed1d10aaaa0]
stable/7.2: [bf97fd2163ad1191ef8daa3d4df8372aee19e396]

CVE-2026-90075: net/sched: fq_codel: clamp default quantum and mtu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90075

Introduced by commit 4b549a2 ("fq_codel: Fair Queue Codel AQM") in v3.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9ebd8f9aa8b2773235889cb903fafd61f2d8585]
stable/5.10: [d315ee8a07fd1810880227319cf60e6cd925ef22]
stable/5.15: [a9a5b2943a00df2ab81a2209f31dd9e87016f120]
stable/6.1: [3782067ec0d485628b6f1f9ede3eeeb4f611fcf2]
stable/6.12: [324f86806673ae4a55f66d28db84577f46f615e1]
stable/6.18: [dfb4b61db886917244284b18b44b23d2254b82c2]
stable/6.6: [397e2b1f71d9f15b8b4e47d24eb620e4dff8878d]
stable/7.2: [9f499e5827fdb6d7fdb46a7ce731852f6b1a1bb9]

CVE-2026-90076: net/sched: fq: add overflow bounds to quantum and
initial quantum

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90076

Introduced by commit afe4fd0 ("pkt_sched: fq: Fair Queue packet
scheduler") in v3.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [709f34f7c28dc4dd6c40343d101850f11e172312]
stable/6.12: [d16dac3925be95ad46e986d4b139c9898b6e227f]
stable/6.18: [f6b3e3848a5fca63438984acd6d9eceac80814c1]
stable/7.2: [e35acd56f244d94355f9ab237c2ecc8fba5e6f04]

CVE-2026-90077: net: fix a resource leak in copy_net_ns() error handling path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90077

Introduced by commit 08027f6 ("net: use ns_common_init()") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3220b62fbb8a55feebd2a826d5ead0f49f09ed5a]
stable/6.18: [76c847e80d2b6be047707d58e8e05eedbe2593ad]
stable/7.2: [e69bde4eb566aea8fa97cbb93e0bab608964f1a5]

CVE-2026-90078: net/sched: act_skbmod: fix length calculations and
avoid invalid header warnings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90078

Introduced by commit 56af5e7 ("net/sched: act_skbmod: Add SKBMOD_F_ECN
option support") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81d0d1e64f30d9989c829c0953cd6e6c68d9c5fb]
stable/5.15: [985a37781ade19061400100c2ba0f43979dd4d63]
stable/6.1: [d896843d8d925f0adbba319020595cfb1a7bcd57]
stable/6.12: [e8a2027b7e686784a69b2dfcee841d779919f313]
stable/6.18: [1719865b20b22c88d2a55e922eff5ca31b0841f6]
stable/6.6: [0675cff3c2924eb9b80d9dd250cf56a1140af157]
stable/7.2: [62126464f3a6159c0a3dd89e196ba65bfeb0afc6]

CVE-2026-90079: octeontx2-af: fix cn20k mailbox lifetime on repeated
rvu_mbox_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90079

Introduced by commit e53ee4a ("octeontx2-af: CN20k basic mbox
operations and structures") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b11a77f69980932c3924054d66e565c9a135747]
stable/7.2: [a0fcbea79f034f49bdd44915f28938922023458d]

CVE-2026-90080: octeontx2-pf: fix NULL deref of af_xdp_zc_qidx on rep setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90080

Introduced by commit efabce2 ("octeontx2-pf: AF_XDP zero copy receive
support") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b09a0503c755b6609fad59a84cc7f05b6843a03c]
stable/6.18: [b003d5b4e46ca5033859db601e12d36da24d0e40]
stable/7.2: [7e33c6bd049b532d2ec4916895ef07e538bed905]

CVE-2026-90081: net/rds: use wq_has_sleeper() in rds_cong_map_updated()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90081

Introduced by commit 922cb17 ("RDS: Congestion-handling code") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4f484661961636eb90d287050959e613795f73a]
stable/5.10: [2a809d7896dbf18e1ecfbdd930f71c9fc298b16d]
stable/5.15: [fa4b98e891fda28cc0638d809c6125ec63d8319d]
stable/6.1: [0e169f6a2adeb17b5577ed7e8abd642465bb50ec]
stable/6.12: [a526214b9f0548ca0e53a6e0d1727d8ea9befc23]
stable/6.18: [bf2b8130723efcb5b86c3ddb6317c3a9b2a9cfc5]
stable/6.6: [42884bd8b8fd023d6a610a695bd5ddd1d5dece17]
stable/7.2: [281f9fda2e06d6c211bb365a5379ed2e05cc2e21]

CVE-2026-90082: net: mana: Cap MSI-X vectors to the device MSI-X table size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90082

Introduced by commit 7553911 ("net: mana: Allocate MSI-X vectors
dynamically") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c7493f980140a5c40eb4f98f97c557193a2c330]
stable/7.2: [4f9827b314ee57cd99f86f8dbadcaf567112e2b2]

CVE-2026-90083: net/sched: act_ife: Only operate on Ethernet frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90083

Introduced by commit 295a6e0 ("net/sched: act_ife: Change to use ife
module") in v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b483f7791b079bb97d411f1066652ff659207ff]
stable/6.18: [d218ea7df6eba076171f2d4897a429a31f2139f0]
stable/7.2: [138b0054021fd7d57bc3eb68b3f4e2bcec037849]

CVE-2026-90084: octeontx2-vf: fix workqueue and netdev race in probe/remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90084

Introduced by commit cbc100a ("octeontx2-nicvf: add ndo_set_rx_mode
support for multicast & promisc") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ba97ff4f873481d370bee7f7dfb87f8296af9be]
stable/6.18: [42a139332ce81a907dac987f1494d30e0a8ab149]
stable/7.2: [ef42c9e922dfa806576d9d82867da2f3cd76b3ca]

CVE-2026-90085: octeontx2-af: fix NULL deref in NIX TM tree debugfs read path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90085

Introduced by commit b907194 ("octeontx2-af: Add debugfs support to
dump NIX TM topology") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec65631bd5ec251cdf67a4919fac7a3149a6e235]
stable/6.12: [fb736d733b0a60377cf53010571c261886446fd5]
stable/6.18: [537e11a1700f64dc6754108f0e1333ad63d4f548]
stable/7.2: [fdf7358e2688f12eff41290bc45030b7aff0845e]

CVE-2026-90086: xsk: honor XDP_TX_METADATA in zero-copy path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90086

Introduced by commit 48eb03d ("xsk: Add TX timestamp and TX checksum
offload support") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6e4b9a6deb9362ef7a0706c70d674e92fe1411a]
stable/6.18: [53a5b262d706b572840cbe8feae392538077ee19]
stable/7.2: [bf9387488d6394845076928c6ca5315ce5d84f54]

CVE-2026-90087: Bluetooth: do not leak an hci_conn when a second LE
connect is rejected

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90087

Introduced by commit c9f73a2 ("Bluetooth: hci_conn: Fix
hci_connect_le_sync") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e1e4047200fd7519f9bdfe8a001437715e618b4]
stable/7.2: [2eafcf310f4e0ad4f387881db01116bbe3cc0b39]

CVE-2026-90088: Bluetooth: RFCOMM: Validate MTU in rfcomm_apply_pn()
to prevent infinite loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90088

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44c98fd082eafd49d55a8a4077ff488175b2fe24]
stable/5.10: [e7c0aa45ae6c5a338661b23812bfcdef50bf3e96]
stable/5.15: [cbc2962da99b6b89345267d3aa74b4b573340548]
stable/6.1: [9b2e5f1928c99224345a9ed8c5dae5fc74964d6d]
stable/6.12: [f561e44261344adadf9d6a6dff31e3af9776d5c6]
stable/6.18: [aeee917a4878af95f0c63e18c5f22eaf6299c7b8]
stable/6.6: [fc4851ff8dfb505e9a19efcc286712132bbd178d]
stable/7.2: [3988cbb1be501dbff909a2ee024670e3c955a66d]

CVE-2026-90089: Bluetooth: btnxpuart: Validate the FW dump header length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90089

Introduced by commit 998e447 ("Bluetooth: btnxpuart: Add support for
HCI coredump feature") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [060fa7592bdc043a93b6b7870f5b8551206d315d]
stable/6.18: [a644b8df94966b672ac656577df98bd01bc88393]
stable/7.2: [22d419db7f9a01bea22cfcf66774d2b2fd4bb354]

CVE-2026-90090: Bluetooth: btmtksdio: Fix out-of-bounds DMA read in the TX path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90090

Introduced by commit 9aebfd4 ("Bluetooth: mediatek: add support for
MediaTek MT7663S and MT7668S SDIO devices") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa0ad2d277c7adead61d1c22411c55cea6990c2a]
stable/6.1: [c8742f53c9ef623decd5285403df0e5b5273c9fd]
stable/6.12: [9a785ea864214aaffd8300683825c3f788d0b634]
stable/6.18: [7b37556d7d801b79096c7ba8ea92db2338aa8b00]
stable/6.6: [0b71a6caaf284915c8cf9cd320ecee9f0361824a]
stable/7.2: [7b80d2701a68456c536f82e577dbed2f60ccb82b]

CVE-2026-90091: Bluetooth: L2CAP: fix race l2cap_sock_cleanup_listen()
vs. put_chan

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90091

Introduced by commit 6fef032 ("Bluetooth: L2CAP: Fix use-after-free in
l2cap_sock_new_connection_cb()") in v7.2-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [66d6ef18548ae6d7dd452b84115fc82c0a73a4ea]
stable/6.1: [827de6bd2865b22aaabd554540def3b8a33018ab]
stable/6.12: [4f8c63fe0097c9f6ea34409f82f79b3894903d91]
stable/6.18: [61d5ddbd524c715b224cbe7e9f01da4e05098b19]
stable/6.6: [7c7ac736b50fa259ed1bdddc18d79523f07c0442]
stable/7.2: [32a7bc6e93be36b37fe61f351d312d358195bd61]

CVE-2026-90092: Bluetooth: L2CAP: reject accept queue add unless BT_LISTEN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90092

Introduced by commit 2ff1a41 ("Bluetooth: L2CAP: Fix null-ptr-deref in
l2cap_sock_state_change_cb()") in v7.1-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [d4bfa78fd67929b62b02013c107973e0c5b7aa9a]
stable/6.1: [bf61a65c6093970e3b50031c4b79ebf3bd411eba]
stable/6.12: [2a3a27aaf19bf069720e024ce6fde54e6bf80df9]
stable/6.18: [87276dc15b559d32757a43b4415c8445fbae06c4]
stable/6.6: [491e4c60017969b053888029998d2a61f298986a]
stable/7.2: [c47339e169bf4a0a4cfabb91351471f67744c2bc]

CVE-2026-90093: Bluetooth: L2CAP: access chan->conn safely in get/setsockopt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90093

Introduced by commit b66774b ("Bluetooth: L2CAP: Fix UAF in channel
timeout by holding conn ref") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1 cip/6.12
stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [ca2c4c26498643f421d35ffe258fafbd3ed461c3]
stable/7.2: [f49321c85785178214fd67f2e9b4b73d6363783b]

CVE-2026-90094: arm64: process: Fix context switching MTE store-only tag check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90094

Introduced by commit 4d51ff5 ("arm64/kernel: Support store-only mte
tag check") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8f070ac3167595069feb1f794c127b805115645]
stable/6.18: [00a73ce437e27fdc636a5ede445a4a491e01788d]
stable/7.2: [2f10bc3ff24c91657887901c3235b803e5055f2b]

CVE-2026-90095: fuse: Fix the condition to enable over-io-uring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90095

Introduced by commit 3393ff9 ("fuse: block request allocation until
io-uring init is complete") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f59015e958174e89be58cc8db16d70a60d17255]
stable/7.2: [8f9a725d89711ad027f6b7183586ef91528f106d]

CVE-2026-90096: fuse: invalidate the correct range after O_APPEND direct write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90096

Introduced by commit 2b0408d ("fuse: invalidate page cache after DIO
and async DIO writes") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26d7e1f5c407b5859122b5cd47d7ebbf4b4c1cd2]
stable/7.2: [833963069adf86dcbdffd4e7d7b3171f95070b77]

CVE-2026-90097: Drivers: hv: vmbus: Skip VMBus module cleanup for
non-nested root partition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90097

Introduced by commit 7e279d7 ("Drivers: hv: vmbus: skip VMBus
initialization if Linux is root") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cee0d90bceae1dee3bcc70f8d6b2ceb5b87deb42]
stable/6.18: [aa17842bbccaeaba7d05c166019d1c96a41bca54]
stable/7.2: [4c19c302cc577bd6b466f6d8e97971777392c2fa]

CVE-2026-90098: net: sparx5: fix sleep in atomic context in MAC table access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90098

Introduced by commit d6fce51 ("net: sparx5: add switching support") in
v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b62793a7baeea9cf20209c9fd2e333311aaf3b8d]
stable/7.2: [648d196ccc03ae3b04402ae71ffa44959a85e88f]

CVE-2026-90099: net/sched: account classifier filter allocations to memcg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90099

Introduced by commit 0da974f ("[NET]: Conversions from kmalloc+memset
to k(z|c)alloc.") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1beb81947eb486716af80db7a584f9e9fef7e003]
stable/7.2: [18c68c8f3d3ff0a4def1391021b439c4333a6c71]

CVE-2026-90100: ptp: netc: fix period truncation and potential
divide-by-zero in PEROUT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90100

Introduced by commit 671e266 ("ptp: netc: add periodic pulse output
support") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [777dbc9914b2f003f1d44af80c7a4a395c5961b2]
stable/6.18: [51fe3fe0ffec033bd831c71d9bee3dee827e491c]
stable/7.2: [08988d1941e180f0ad30d91233cb64f3418ba23c]

CVE-2026-90101: bnxt_en: Fix call to hardware monitoring event handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90101

Introduced by commit a19b480 ("bnxt_en: Event handler for Thermal
event") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [622d698df4239fef3e0eb51fe59f4198f957f28a]
stable/6.12: [e3cad8389a72b8a309b5689c1683310126b0d7da]
stable/6.18: [001ff5d8e68aacd91768b824b930dd7e68db6688]
stable/7.2: [b17907ef665bc76a495a8f909f74656d3f32b7a2]

CVE-2026-90102: NFSv4/pnfs: key the data server cache on the NFS version

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90102

Introduced by commit d67ae82 ("pnfs/flexfiles: Add the FlexFile Layout
Driver") in v4.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13c23c5cb977f66390795437fd3837887ce1fd75]
stable/5.10: [ffb100b0da0e217d5d63ce6fe092f9c29e59f7dd]
stable/5.15: [02e160922bc83cd25e346a028ed43cbdb0b57e1a]
stable/6.1: [bc7aa9d8aff826031ffe25eba7f2f3acafcbf7a1]
stable/6.12: [f2994ba1263d9e88d3d9ae1d097c5cf811d4bfa5]
stable/6.18: [27f640cd92eebf5c2f64336be7ca24f4636390cb]
stable/6.6: [dd5bd091daa48c6ed8f9235ddf448aa288a0881f]
stable/7.2: [bbc975cfb07a146843fde1126c43441e76177539]

CVE-2026-90103: NFSv4.2: fix LAYOUTSTATS send buffer exhaustion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90103

Introduced by commit 27c4306 ("pnfs/flexfiles: encode LAYOUTSTATS
flexfiles specific data") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c75ef2137e749f2673f0617cfdaae53b2bb7195a]
stable/5.10: [842ac26615424577f24f0486b9d3bf97f28fad9c]
stable/5.15: [397aa7000bbf6b6a0d32e66a544e978fb478c8e4]
stable/6.1: [e82d7d999fe9f893f84bf332fd39cb5d9de7128f]
stable/6.12: [cb11590c7ddc6883a1b1d70b1f98b2779fe626f2]
stable/6.18: [3815b894b922e9b4f40b8b6f6d67bf80d44141c9]
stable/6.6: [5aca000630c0fd0da102ae1abf9245dd74f2ce36]
stable/7.2: [a973622da0c62c34043ddbbf382cd761b03e5136]

CVE-2026-90104: NFSv4.1: zero referring call lists before decoding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90104

Introduced by commit 4aece6a ("nfs41: cb_sequence xdr implementation")
in v2.6.31-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fa4804fe62ca4155a2d8fc2789d630376cbf2fc]
stable/7.2: [f31f3c042e024aef437cda42f0424ae8d4594b6c]

CVE-2026-90105: vxlan: fix reading neigh ha

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90105

Introduced by commit e4f67ad ("add DOVE extensions for VXLAN") in v3.8-rc1.
Introduced by commit f564f45 ("vxlan: add ipv6 proxy support") in v3.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b824059a673b2283e78c7aae2c7d257aad7f0e1d]
stable/7.2: [ecc8bac11a101e5f6989a14b92e17b51f9761630]

CVE-2026-90106: net: bridge: arp/nd proxy: fix reading neigh ha

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90106

Introduced by commit 057658c ("bridge: suppress arp pkts on
BR_NEIGH_SUPPRESS ports") in v4.15-rc1.
Introduced by commit ed842fa ("bridge: suppress nd pkts on
BR_NEIGH_SUPPRESS ports") in v4.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57549ab9079122991dfa0f8248ca00e101e8e69b]
stable/7.2: [291c9e137b7c74e8a512cded4845352da4c4adda]

CVE-2026-90107: net/smc: free pending qentry in smc_llc_flow_stop()
before memset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90107

Introduced by commit 555da9a ("net/smc: add event-based llc_flow
framework") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ee0ceddc7785c6dcf4a8107fef01f0414a354f4]
stable/5.10: [8e3deb150a5237b672c4579e69a6deb02027dbed]
stable/5.15: [11bc373ee6630709f0c2da2e7860c23d503c9e9d]
stable/6.1: [032aec7d03c9102616b98fea74f8f7145e7f867c]
stable/6.12: [f03aa5d36ae3c4068a1c3885146be99aa7fd9307]
stable/6.18: [0879ea157acc1ac6752f6fcb755d1f91a2359238]
stable/6.6: [957dba2b8b5aebfe09caa6a6b22b958079082eab]
stable/7.2: [5ff429dd6725fa6c1e17a4ed0be8ab675f67a98b]

CVE-2026-90108: net/smc: free stashed qentry before overwrite in
REQ_ADD_LINK to ADD_LINK transition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90108

Introduced by commit b4ba465 ("net/smc: extend LLC layer for SMC-Rv2")
in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [036322025d6e440cb75fc6fecbba9a16b271a2ae]
stable/6.1: [7dd55348c0d9399a9448847819e9f3904ae507ad]
stable/6.12: [b08aacfb226a840628151643b6a34eecf545d311]
stable/6.18: [0fb9a513766071ea9d5f3bf988e39241b8e9ee3b]
stable/6.6: [056395acb7041b3a1f2baa08d89a1938a8b8776a]
stable/7.2: [e25a602c45c76a7130878db72bcf6f76df04bf85]

CVE-2026-90109: net: sched: fix 32-bit backlog wrap in gred, bfifo and
plug enqueue

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90109

Introduced by commit a3eb95f ("net_sched: gred: add TCA_GRED_LIMIT
attribute") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c660ee8c809637909f4f7eb1017f7b9401c75c4]
stable/6.12: [3fb51b3960342bbee563543f8d33710fd0fb5a96]
stable/6.18: [8b2d8c70b969bf84f9e248bfaf2a7135129f2eb6]
stable/7.2: [d98b92f3d57976ae185238946ec5ea0be32195aa]

CVE-2026-90110: inetpeer: randomize RB-tree node comparison using SipHash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90110

Introduced by commit b145425 ("inetpeer: remove AVL implementation in
favor of RB tree") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ee66e9487172fcd189bc52a767c30dad7141c09]
stable/6.1: [b20e98f0bb668a59abaf7bcf85d75c073e90d352]
stable/6.12: [199fcf285e498111e029137d088949bc6c26d578]
stable/6.18: [857681f6835d5b0a7bc4a34a026baeaaf5215623]
stable/6.6: [5f127e3cc9647a8a70db12c65dbd0de473545380]
stable/7.2: [7109bb63667a53e4542ad845476f97d0c8b28a61]

CVE-2026-90111: ip6mr: do not clone dst in ip6mr_cache_report()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90111

Introduced by commit 67f415d ("ipv6: convert rx data path to not take
refcnt on dst") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [235b42b5860189eb8c27c36435ad932cae65a734]
stable/7.2: [4a674afaae4136c71943aa3e35d433676fd40e8f]

CVE-2026-90112: net: qlcnic: validate unified ROM sections before loading

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90112

Introduced by commit af19b49 ("qlcnic: Qlogic ethernet driver for CNA
devices") in v2.6.34-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e8076e4e4124dae75a3e080ddc20404700d7585]
stable/6.12: [b9efc177703a03312cc2f6e6a4bbd4595e8158a1]
stable/6.18: [4be733a450c86938c91f9c70a56802ef5069764c]
stable/7.2: [684773c4d26f7f2211beb31fb90629216f8a61f5]

CVE-2026-90113: netdevsim: update queue NAPI association on queue reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90113

Introduced by commit 5bc8e8d ("netdevsim: add queue management API
support") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07e98a4d5e9c292eae97c9cc5ab0937384e48492]
stable/6.18: [b8f32b0804b4bf0cba0ee0a093e3fd74f11d7166]
stable/7.2: [db038ac4dca0fa626199e9c297eddd8362be0550]

CVE-2026-90114: net: bridge: Reject descending VLAN tunnel ranges

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90114

Introduced by commit 9433944 ("net: bridge: notify on vlan tunnel
changes done via the old api") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b74a072d8fb71d3c9ffba4a17d5943e63266fb38]
stable/5.10: [1181f6bad009408a259bab6aaf0681f11b487972]
stable/5.15: [5a8e0e3a18b5e3172343b8479c5d04187f5b4795]
stable/6.1: [0874a6d5275091429ec4c675c54c53a8776665ae]
stable/6.12: [bd741b819ff1c239d26cc5b0f0e6b1fd4e67ed17]
stable/6.18: [c0444d7499f113d6b7803ef0175591464e17525e]
stable/6.6: [4b0f5b25f114651f03058395b490626c4444875e]
stable/7.2: [434849b21ef56b09d16e6366b2a230002f363e45]

CVE-2026-90115: xsk: fix NULL pointer dereference in __xsk_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90115

Introduced by commit 8046277 ("xsk: add support for AF_XDP
multi-buffer on Rx path") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e37b2abca80473e106176e41712a369fd2f72117]
stable/6.12: [60d7d3559ce66e227e195e9463cdfed8077c8659]
stable/6.18: [214fb79b0379cb0214905632a2537c0c33f594eb]
stable/6.6: [aaebce297efc3e3dccb98a6ff838cfaa47db08db]
stable/7.2: [8341bd3ff126d85bc8c4ed52eedcaa5b1a65f194]

CVE-2026-90116: ALSA: mtpav: shut down output timer before card teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90116

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c73cb5b7c159246dd572277c668851a56e516019]
stable/6.18: [392c985c6b03dfdf4904c0d464f18735ca3c4df8]
stable/7.2: [1e16e82581521a2fe20eda29bdc9e75286f7c950]

CVE-2026-90117: ntfs: validate usa_ofs before preserving the update
sequence number

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90117

Introduced by commit 495e90f ("ntfs: update attrib operations") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81684340963da2e898eabb8c1e274433d9375bc6]
stable/7.2: [ea5a3c30710710c1dc5e483d3313309ec2e868f7]

CVE-2026-90118: ntfs: fix off-by-one page overflow in ntfs_decompress()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90118

Introduced by commit 1e9ea7e ("Revert "fs: Remove NTFS classic"") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98716c9fce21f6c8a9d71e08cf53e7504fa562f4]
stable/7.2: [b42644e425fed4a5cd6c88372655da5c1b52c666]

CVE-2026-90119: ALSA: ice1712: Fix the card leak at probe error with
the auto-cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90119

Introduced by commit ca642da ("ALSA: ice1712: Allocate resources with
device-managed APIs") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d736eba9c453fedce664fdf592c8b71ecff1932b]
stable/6.12: [d8ac49391a1562dc784fc91e810e696284cb647e]
stable/6.18: [b15782627b6562f7b6d628f4699316f26340f835]
stable/6.6: [c5c7c7b6cfae73c46e4544a9ef08ff89231a670d]
stable/7.2: [24b399f51812d727dc25d7814c4d7e0cca38201e]

CVE-2026-90120: irqchip/gic-v5: Check get_logical_index() return value
in MADT IAFFID parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90120

Introduced by commit 35866ef ("irqchip/gic-v5: Add ACPI IRS probing")
in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [328affc639ce9873a7a0a3fd6b8339f19767529b]
stable/7.2: [6caeb878f809bdf0aec2fdd96f3d41ef4b69fc69]

CVE-2026-90121: irqchip/gic-v5: Clear per-CPU IRS data on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90121

Introduced by commit 5cb1b6d ("irqchip/gic-v5: Add GICv5 IRS/SPI
support") in v6.17-rc1.
Introduced by commit 35866ef ("irqchip/gic-v5: Add ACPI IRS probing")
in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3dfc0ab5fefd052c6028c4632b1fad8bdaf7967e]
stable/7.2: [54937af6f4a0d44c2852a203d457902f3264c906]

CVE-2026-90122: clk: visconti: Make sure clk_init_data is fully initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90122

Introduced by commit b4cbe60 ("clk: visconti: Add support common clock
driver and reset driver") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39c0e6c844a14945040cca4ccf6997792ab764c4]
stable/6.1: [0e97c22b286e1918c6f48bad7e77fb8240a24b4a]
stable/6.12: [1cc0539e5b0906bace15d3fc7347b344a017cc02]
stable/6.18: [8f7980033e9f7ecaaecd873a0b5bf6b6c87d7e5a]
stable/6.6: [9f756f1965bad65e6066608f33c36988cd10302a]
stable/7.2: [5ecfa72e74c6e2a765fa5bc1da574e5beae588f2]

CVE-2026-90123: irqchip/ast2700-intc: Avoid allocating in the
irq_domain activate() callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90123

Introduced by commit 07825e4 ("irqchip/ast2700-intc: Add AST2700-A2
support") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b76eee9c2157223aa4aac42ceebb563288e078aa]
stable/7.2: [f2f0da11648616e47419dca93610f6c0d70ec00b]

CVE-2026-90124: irqchip/renesas-rzg2l: Fix loss of interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90124

Introduced by commit 3fed095 ("irqchip: Add RZ/G2L IA55 Interrupt
Controller driver") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt

Fixed status
mainline: [50b10bd0c2d721ad38abd1abe3acdefb6caa0944]
stable/6.1: [c043591f03a8111f7d306b8122c444a949486269]
stable/6.12: [3791e242ec2e5a5cd9e010a75ed1125d0e84d394]
stable/6.18: [38c6831fefde0ff89f8d2dcb924f957a89dec414]
stable/6.6: [b5ba8b861b5d833394bd23df3f4b59883ef18c88]
stable/7.2: [dbecbe23dc606c4af68b4591a41124186f5c1802]

CVE-2026-90125: smb: client: fix request buffer leak in smb2_new_read_req()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90125

Introduced by commit bd3dcc6 ("CIFS: SMBD: Upper layer performs SMB
read via RDMA write through memory registration") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deb6468f4164640e4dc875f008aa449cf55987a5]
stable/6.12: [12092ed28434bf41e08d41e3c5269eb6b337fc02]
stable/6.18: [442c5f1358ced0d4e716778ac06f1e323a7e4f21]
stable/6.6: [58066940076b90c16e821fd6f9767cd979cbdb5e]
stable/7.2: [73f6bdb0380486ab37fe12cd74de20abfaf5d3ae]

CVE-2026-90126: rtc: pcf8563: fix clock provider leak on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90126

Introduced by commit a39a640 ("rtc: pcf8563: add CLKOUT to common
clock framework") in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c48a53685040bb0de45a640b34055cbbfc69d4f]
stable/5.10: [2b5622cf4ee218b6f98d31dbf3fbd44b9b6bd675]
stable/5.15: [36cb00c33bd83e7ce31b5a9f1f7c70db0cb7776c]
stable/6.1: [30b7c63af50fe1464e7582a37de1ca4bd030ecc1]
stable/6.12: [97edf3fd9a46ea89a167966991c0449cfa07b36f]
stable/6.18: [08a59c28c2bdbcd655e99526c86a41dc83834283]
stable/6.6: [7afb8db47c4f107bce89cfe5115fb31ba7c94665]
stable/7.2: [6218c0533a72235ec9c5f41b812c63d963bd4a3e]

CVE-2026-90127: virtio: rtc: time out alarm requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90127

Introduced by commit 9d4f22f ("virtio_rtc: Add RTC class driver") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68e00d9212929805b40dcb9166755610f4f4acee]
stable/6.18: [28701b74c22d2a43ddf7aebb6378e60c18323865]
stable/7.2: [afbf69d1d691c06d093d7c3f17168ecb608c4977]

CVE-2026-90128: vdpa/mlx5: fix wrong list iterated in add_direct_chain
error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90128

Introduced by commit 94abbcc ("vdpa/mlx5: Add shared memory
registration code") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [23ae56d9e74c122f95cae71ae3b9fc259fb88446]
stable/5.10: [c93defccf5eb0a92bdafa43487be6ce0221a2477]
stable/5.15: [ed3462365636df3bc63e34d7468f4faed3f70a4e]
stable/6.1: [22d52af9e26a72bdfe2dcfb1419a091de4862cd9]
stable/6.12: [637d867530daea61898e3346975978b7f67fc2ac]
stable/6.18: [6ca752850de3b8162f030793cc15001aec85c4cf]
stable/6.6: [eeac2ea4ad2654e3f160a9b608d05c9af31433a6]
stable/7.2: [c678d04ac9e5a64c2559c43bce273e845fbd09eb]

CVE-2026-90129: virtio_balloon: quiesce balloon work before device shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90129

Introduced by commit 8bd2fa0 ("virtio: break and reset virtio devices
on device_shutdown()") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e17eef04600c399c7e0f5ce765da5cf9d40d8e1]
stable/6.18: [6dd28e32f4d81a0d57c732b9900de24184e60a7d]
stable/7.2: [bdef50a8226fc04899ef6815dd08a002247d47d5]

CVE-2026-90130: vdpa_sim: fix cleanup after worker creation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90130

Introduced by commit 76acfa7 ("vdpa_sim: use kthread worker") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bd670e5dfd2b01fd9692f61fa1456434c54026a4]
stable/6.12: [05ddc94afb69e36df59e88cfa9e5c7bf9d10cfd0]
stable/6.18: [68b726b3a01fb02a68843781b17d05ef3d759987]
stable/6.6: [feafa109f031ed111f7f968e447c13985db498e0]
stable/7.2: [ca6f3fa599cb764518df595368b743f856fdb516]

CVE-2026-90131: ntfs: serialize resident iomap reads with mrec_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90131

Introduced by commit b041ca5 ("ntfs: update iomap and address space
operations") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9e00c457d4ab8ab59c6e4b8554c921260e4e16c]
stable/7.2: [0400e0d50eb3be19c98323faa322b652e4ae3f99]

CVE-2026-90132: ntfs: reject unprivileged writes to reserved $LX* xattrs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90132

Introduced by commit fc053f0 ("ntfs: add reparse and ea operations")
in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea6a67ef64451d2da298f15baa35865b4bb6372a]
stable/7.2: [86f46508016bc1f2bffb3a52dc2664f942fb9802]

CVE-2026-90133: ntfs: Fix index_root heap OOB write in ntfs_ir_to_ib()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90133

Introduced by commit 0a8ac0c ("ntfs: update directory operations") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc09bf79b76f9a7157e225f449655f3f62f96c9c]
stable/7.2: [825dec5120933e90c54e30e31ccfa6c3449043a8]

CVE-2026-90134: ntfs: fix kmap_local_page() usage in compress

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90134

Introduced by commit 495e90f ("ntfs: update attrib operations") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e03fbd5f772ad24ea64f7632e4d0d73184787ca]
stable/7.2: [950e2ecc7aec21af24b05bc661a097a81c670409]

CVE-2026-90135: net: add missing ref_tracker_dir_exit() to alloc_netdev_mqs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90135

Introduced by commit 4d92b95 ("net: add net device refcount tracker
infrastructure") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b1c2af8a22c35cb099c735c2f63ea3ba757557d]
stable/6.12: [2775bf36be7872834a7f8c0a0d9681a1a3e1cd4c]
stable/6.18: [5fe03b5257095e2beef0bc79e1f068fbd09a24c7]
stable/7.2: [63ab05e8f9654aa100d366c0236399fda6ffaab1]

CVE-2026-90136: platform/x86/amd/hsmp: Reject negative power cap writes in hwmon

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90136

Introduced by commit 92c025d ("platform/x86/amd/hsmp: Report power via
hwmon sensors") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3921bb8635ff2836622df1cdf3194d4f3c1835a4]
stable/6.18: [2c09cadec116eba3fdbcb5d8d8641f6777d4a11f]
stable/7.2: [1b0a3d915320f1600e5ff43f8bc21b73118480b8]

CVE-2026-90137: platform/x86: hp-bioscfg: fix password encoding bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90137

Introduced by commit 8646a3b ("platform/x86: hp-bioscfg:
passwdobj-attributes") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e213939ed9e6e6badf7aa48c4c8dd9a9cdf00615]
stable/6.12: [59fe8491ddaa03a510b352552e6ee291e7ce45d3]
stable/6.18: [ace1ba5fca0ab775b3641e154bcbc3ccde26a71a]
stable/6.6: [c224759555a13735b0d67561d818cefe00c3309a]
stable/7.2: [8a7499b8fd34438c1b11964e0e7ef5bd590fec92]

CVE-2026-90138: vsock: don't check the listener's sk_err in vsock_accept()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90138

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8c899cf5e7be29840a172c183dedd8d3e7a0287]
stable/6.12: [c5a75d37c21e558cc6fad1597e732ead30745eed]
stable/6.18: [36e5fa009f98a4edbe1783ac11c0df672b224742]
stable/7.2: [491b368a0c6e5f28b615a50b0d384f5c25fde2a7]

CVE-2026-90139: fuse: check for NULL root inode in fuse_fill_super_submount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90139

Introduced by commit 1866d77 ("fuse: Allow fuse_fill_super_common()
for submounts") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [928f659a3e3650978a5b4829cc982324f72b474b]
stable/6.12: [e0b7f2922f6bd4c23cbddb7d1fc2bada570d27d1]
stable/6.18: [a5129155ca9fba40d77ff19ffead8244e88d6f9c]
stable/6.6: [17120c5bfb16808509ea18d7fab6027802d93eba]
stable/7.2: [509f4a09bae7f03c87f67f053648874a5e177867]

CVE-2026-90140: cuse: wait for pending RCU callbacks on module exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90140

Introduced by commit 053fc4f ("fuse: fix UAF in rcu pathwalks") in v6.8-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [4deb3edead0c0e172cc7349e8855d741d3c5e162]
stable/5.15: [7fe415e1cd8fa875be263670c0ab47109818abb6]
stable/6.1: [45ae914b2f6ea56fc2f1c017fdee4e995bcb4c0e]
stable/6.12: [a1b46aee33d83f14ed62d7fdef1a91d3e0b732a9]
stable/6.18: [389bd349ddbcf90dbd8a4f2a4ab6e552d53df134]
stable/6.6: [ac5c499413385cea3e0220d6050408d50842891d]
stable/7.2: [c40f3f24839f8404325a2099e26c2a04786ae309]

CVE-2026-90141: ipvs: fix integer overflow in ftp helper port/address parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90141

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e625a9477d12baaff4025c5f9989184a907ea8fc]
stable/5.10: [d02de9a7a7e2484da0cf37e50614840623b98a62]
stable/5.15: [fc1493c905d7e0bc8830c1d83915cb7831daf1a1]
stable/6.1: [50cb9b7263a2ed01f7d2f97818a800c2ee05f661]
stable/6.12: [00bcc6d679262ea42688fba1d7819ea6e56f12ef]
stable/6.18: [4aed450adaee3a021db27be94c61fe025b0d05ff]
stable/6.6: [deaa88fa010ba0dfc554d09e006ddd1ce9945c82]
stable/7.2: [b1908bff0faaa94d55be72da65879cad632e8236]

CVE-2026-90142: virtio_net: Fix resize of the RX ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90142

Introduced by commit e9f3962 ("virtio_net: xsk: rx: support fill with
xsk buffer") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d09c98a6da215bce2173a292e4b95c8de6ea5d51]
stable/7.2: [8344c9233c8f77017174d9e280c5a26034d068b6]

CVE-2026-90143: net: kcm: Hold RCU read lock while running BPF parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90143

Introduced by commit 9b73896 ("kcm: Use stream parser") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0346dd64e4905291cc9c479f2e6cf1884ced4e6]
stable/5.10: [37108861cf7bd909d4a372069bcd61c8f489e232]
stable/5.15: [3c70d27e792a28bca650ddd8a9aa0fe3591ffec5]
stable/6.1: [1d26a6e007d46babc7fa76e5a157dccf86cd55c0]
stable/6.12: [21526f8a191a3c50622b8c10bd927870d780eae4]
stable/6.18: [292846223eaddba890e40699d2ab82ee5671798c]
stable/6.6: [b0e94ea63dbdcbfec9beb819cd5f8fa584809ef2]
stable/7.2: [f392affef3c9ce64dfdde794df0579e0a7793440]

CVE-2026-90144: dpll: fix NULL deref in dpll_device_ops() during teardown race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90144

Introduced by commit 9431063 ("dpll: core: Add DPLL framework base
functions") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33f016b23a219fe034213849b51436b8e79df251]
stable/7.2: [fdbf04e3e01a872d0ef2149f846f1a3e3cb54f5b]

CVE-2026-90145: hinic3: Fix skb linearization mismatch and drop skb
when skb_checksum_help() failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90145

Introduced by commit 17fcb3d ("hinic3: module initialization and tx/rx
logic") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0c2bed6927cbfa2cb51f240b4812bf6916bce0e]
stable/6.18: [e794cdc5c369c1b06359e2fe03a8d9270f56bead]
stable/7.2: [96c3959770386b2913c62005f0d0c3151e0c01c3]

CVE-2026-90146: bpf, xdp: move offload check into dev_xdp_install()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90146

Introduced by commit 026a4c2 ("bpf, xdp: Implement LINK_UPDATE for BPF
XDP link") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad27ed7d2309419a129078d781504f486b1b469a]
stable/6.18: [ea7b35dcc9430293b861bc7bad0c546f193c85f9]
stable/7.2: [03022dd874070768a7099f18b1944c633641315f]

CVE-2026-90147: clk: devres: fix cleanup in
devm_clk_get_optional_enabled_with_rate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90147

Introduced by commit 9934a1b ("clk: provide
devm_clk_get_optional_enabled_with_rate()") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt

Fixed status
mainline: [0d4d262c1664365e17e0a5ba2ab79f4db484b44e]
stable/6.12: [9a365f41fe0f227ef5a269e240233bd0bffc66c9]
stable/6.18: [9d4843f1051259854f724e9cdc5b9eac56327037]
stable/7.2: [647157fecb42b72d930e7b7d0bfbc5f2db9a858a]

CVE-2026-90148: NFSv4: Fix incorrect argument passed to
nfs4_delete_lease() in nfs4_add_lease()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90148

Introduced by commit e93a5e9 ("NFSv4: Add support for application
leases underpinned by a delegation") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [468e458ffde907ba19acd2102ca1fbb8f6fbede2]
stable/6.12: [ff7244faa13b23e9acfad9df0438f0b44b338f62]
stable/6.18: [d148a652d52fd6aee96daf798922eb800ebb3018]
stable/7.2: [d179ff22cd8514f966966fd9ad425dcbb98e1ada]

CVE-2026-90149: NFSv4/flexfiles: fix NULL dereference for NFSv4.0 data servers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90149

Introduced by commit a7878ca ("nfs: flexfilelayout: remove v3-only
data server limitation") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b03ebbf8d5e8f6af4ecd6c65375232dd1ec32cc]
stable/6.18: [163c16e01f53fc8eb8d0f3484ae6c382265ecbbd]
stable/7.2: [436a214514e24103159aea455147d58b44a8a585]

CVE-2026-90150: pnfs/blocklayout: Fix device leaks on parse failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90150

Introduced by commit 5c83746 ("pnfs/blocklayout: in-kernel
GETDEVICEINFO XDR parsing") in v3.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c056f817e4200fb18079d5052c273a22f191ff0a]
stable/6.12: [8a2494964edac2a13e82441c2bf887548dc3be0b]
stable/6.18: [1e1c36b206c659cf94c6755a1d821ed1babd32bc]
stable/7.2: [23e4162405c456ce12c772d5882d306135e828ae]

CVE-2026-90151: NFSv4: remove callback IDR entry on client allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90151

Introduced by commit f4eecd5 ("NFS implement v4.0 callback_ident") in
v2.6.38-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d05c2007b3d84ccba11dc6e9cb3202768cc72f14]
stable/5.10: [68c721391b761dbe38d5b0094d2bb6e8489ad92b]
stable/5.15: [9bfdd0f591307b5198826a0e7a5b2f35f87acd2d]
stable/6.1: [7c4812eb96bdcafb31a65b12f2aa96659429d1d4]
stable/6.12: [80b1c3d5a881f7d9081aa9f46da9742878a0f893]
stable/6.18: [3f2387e8bfbc4efda5d77c3a11a028d0a119c48f]
stable/6.6: [fc95ca82d5ae598c428ab5a00ae69f8526d59371]
stable/7.2: [5891c03e150920618db0e9c4ea2d772abacdcfd1]

CVE-2026-90152: smb/server: fix session leak in ksmbd_session_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90152

Introduced by commit f5c779b ("ksmbd: fix racy issue from session
setup and logoff") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [99b25b046e47e4904373cfeb445c5483f1633d88]
stable/6.12: [03a22a003f41b182245e6c71fe565e277cff7094]
stable/6.18: [b967a595fb735d313a8676b2ca6a4cba38506482]
stable/7.2: [55c677619084f9c9fa4146d933cc8ccafc924c87]

CVE-2026-90153: ksmbd: bound smb_check_perm_dacl() ACE walks by DACL size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90153

Introduced by commit 8f05411 ("ksmbd: fix heap-based overflow in
set_ntacl_dacl()") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [79decd88dd3f0d42e7fb0689b1a7853bfa302459]
stable/6.12: [a29f57a14c939586d84d7fd6a029bd1fd170098f]
stable/6.18: [a4a307d149327dad5fb25187e1b03cebd1b04de6]
stable/6.6: [a2051ffe452afad52f580b85a3fd8851933b1e7c]
stable/7.2: [8e4f75e979c1d9a51b0a48ac33d0cfd5f039ec67]

CVE-2026-90154: ksmbd: scope session state changes to bound connections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90154

Introduced by commit f5a544e ("ksmbd: add support for SMB3
multichannel") in v5.15-rc1.
Introduced by commit abcc506 ("ksmbd: fix racy issue from smb2 close
and logoff with multichannel") in v6.4-rc1.
Introduced by commit c444139 ("ksmbd: rewrite stop_sessions() with
restartable iteration") in v7.1-rc2.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [c50e628122aed077695669e25b842e778511a43d]
stable/7.2: [0875872718b98e8530fbc634e5aa7dbd3253b80d]

CVE-2026-90155: ksmbd: detach blocked lock requests before freeing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90155

Introduced by commit d63528e ("ksmbd: free ksmbd_lock when file is
closed") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [215e8816b1ac25176d911abb8704390413ccee4b]
stable/7.2: [514a0b2bc949963497e66cacd433f65dc768a71d]

CVE-2026-90156: ksmbd: safely discard unregistered deferred locks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90156

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [054bcca4cd9f00719b01f7108b51a2168fb94f15]
stable/7.2: [d09af9a35ff7b77a950b507133d9092aadbfeff4]

CVE-2026-90157: bpf: Reject negative optlen in cgroup getsockopt hook

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90157

Introduced by commit 9cacf81 ("bpf: Remove extra lock_sock for
TCP_ZEROCOPY_RECEIVE") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [1b5aacd5b2419b0790e955e466d389a61c79b4b1]
stable/5.10: [5b09d984b38b018b123c3a9e02a96bbc6468dbe5]
stable/5.15: [554ba7195c4108726450e24480c8449990c2268c]
stable/6.1: [d02a12b4085ffe41ea750b1007f7a9c7aee2875a]
stable/6.12: [f68671b1a98d426c57864bd457c125fee14ac1a5]
stable/6.18: [2bdbe00454200fcb0110f31eeca8d906a3515e74]
stable/6.6: [e6fbf0eba87f50084d67508898f6ad6fc7ff1ba2]
stable/7.2: [31a89af4f513d750fec196e2bb6195a7d4473e9f]

CVE-2026-90158: m68k: nfcon: Do not call console_is_registered() in
nfcon_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90158

Introduced by commit 7c2af0f ("tty: tty_io: use console_list_lock for
list synchronization") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f8e3cad53b5c36ab0ed5d3195bfc55c59ea61a5]
stable/6.12: [e5e11274b5512e24a346ed83f8dd85e3389d2f4b]
stable/6.18: [be98f92fc244688a6bdecbc834cf2cd243056d9d]
stable/6.6: [7d3f15a664d115584fc177b5f2cfbdb3e5a50d60]
stable/7.2: [d73441232f1f067eb659e94447b1353c16609711]

CVE-2026-90159: bpf: Disallow bpf_{g,s}etsockopt() in cgroup UNIX getname hooks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90159

Introduced by commit 859051d ("bpf: Implement cgroup sockaddr hooks
for unix sockets") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84473a7e1813a2da7b759ab1d098a84998c8d3f5]
stable/6.12: [61769b9c882a964af3a6ebd9a8e43615f8713234]
stable/6.18: [fe91c3f64a738dd97e8542ad5bdfbe5ac430edf6]
stable/7.2: [daeb74f5f398e847d1d42906aec6610406a34fdc]

CVE-2026-90160: lwt_bpf: Restore reserved headroom after xmit program

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90160

Introduced by commit 3a0af8f ("bpf: BPF for lightweight tunnel
infrastructure") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fe7007aed9ad069b2bd77e5d0c875c64f5c0269]
stable/5.10: [753e5cdcca5474d230d62bb3489e5168ab27c272]
stable/5.15: [c488071c3441fa34f5a87cd6c12ce2cc6304f20e]
stable/6.1: [a38c0eb447e2dd0120a2ebcdba470f9505ac8907]
stable/6.12: [7d043e24520a273c362be5dd7d9c82796879a49b]
stable/6.18: [7cf561843ed0ad57501892a65abb77957e6c800f]
stable/6.6: [de2b2004e16f2930eb689175e2c1998b0a68d499]
stable/7.2: [179a5b2171573d94a25c9aa8e1c9f9ac352ad316]

CVE-2026-90161: erofs: fix interlaced ztailpacking pclusters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90161

Introduced by commit fdffc09 ("erofs: support interlaced uncompressed
data for compressed files") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [862427ebb81d1f6abbf74d799790e1694b37b187]
stable/6.18: [ddb7ea4fd99bf6c4314d1dfca18aec6945ce8054]
stable/7.2: [451027c642e752420e1a04237db9ce7b35cee595]

CVE-2026-90162: ksmbd: defer publishing granted locks to prevent
UAF/double-free race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90162

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29f74f0f2e6df3b393b7b66e810136d0c64e3c59]
stable/7.2: [a1d26dfb32919088e3638dca01068df3c4507433]

CVE-2026-90163: smb/server: call ksmbd_proc_cleanup() on module init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90163

Introduced by commit b38f99c ("ksmbd: add procfs interface for runtime
monitoring and statistics") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f43cbe3b58ce989ce420c3bc875d48e7754c8aba]
stable/7.2: [7d2cd9269b570347e6e2dd24d4b3c1da868bc91d]

CVE-2026-90164: smb/server: abort initialization when proc setup fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90164

Introduced by commit b38f99c ("ksmbd: add procfs interface for runtime
monitoring and statistics") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db97f3763727d652112ae70038d4e17b3ce277bb]
stable/7.2: [fb4ba2bdfc1de8866e7c8e00df99f4b03ff42f09]

CVE-2026-90165: smb/server: fix invalid pointer dereference in
ksmbd_stop_durable_scavenger()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90165

Introduced by commit d484d62 ("ksmbd: add durable scavenger timer") in
v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [bef46b604732d83f8da29f782868de4d25bf972c]
stable/6.12: [af9cb997d13a17029a0d3863e33f4c837e27a8ae]
stable/6.18: [b2d78c199dfd983638662ace0612d4fade3dbea1]
stable/6.6: [3f8651f6bb52159c9e23993c77a2b51b9505ad64]
stable/7.2: [a2eb72b4d53bb9d8d6c00f3f794eaccb4b1ce5ed]

CVE-2026-90166: smb/server: fix null-ptr-deref in
ksmbd_ipc_tree_connect_request()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90166

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2ccf905f47d2344270749f4dfa905afcd3edeb0]
stable/6.12: [4eb74a34ea401abfbbd5991076715dae3de938df]
stable/6.18: [8461f27902727ad434375caf13a0100aafc0340f]
stable/7.2: [7065d3648b1a48d2c49da3d6364dd3c4d503b10c]

CVE-2026-90167: ksmbd: serialize oplock close with pending break ownership

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90167

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0148dc5625dbfd50596ac63c7487c12e8a8ab03]
stable/7.2: [5f97bac88bfb333f426f01c118b8235e75af8d96]

CVE-2026-90168: [REJECTED]: ksmbd: retain connection for pending notify work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90168

This CVE was rejected. Introduced commit is not determined.Fixed in v7.3-rc1.


Fixed status
mainline: [f495154703cbcc0050cfd53469bd56965791616b]
stable/7.2: [50be5e96c381ae995b7de3869eecdc84476be7f2]

CVE-2026-90169: ksmbd: free preauth sessions on connection teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90169

Introduced by commit f5a544e ("ksmbd: add support for SMB3
multichannel") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06c7b1d731bc105a8644f1b70165ba8b9416cbab]
stable/6.12: [b62b1ebb25f0a19067ed5b1a86036b2dc98be44f]
stable/6.18: [a41a98ee16ae038751b6639decadaa3ce15ca18a]
stable/6.6: [effcf48d79d8aa53113d8289e140746f25ceb62c]
stable/7.2: [8e2ebc77678832e981adc008d25cd8f67d08ebc4]

CVE-2026-90170: ksmbd: validate ipc response length before
dereferencing its fields

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90170

Introduced by commit d6a6aa8 ("ksmbd: validate response sizes in
ipc_validate_msg()") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [e9b33376bd07bca4175f7bcc2d6034ef250f8181]
stable/6.12: [398cba4b646a6c08ff3d79e6b1e70e5ddae8a065]
stable/6.18: [0aa8f94bfd4d818284c8a7ce0040d40ca1ec3595]
stable/6.6: [17b7d1a2b4d5473df5dca8c9a07d65021806c23a]
stable/7.2: [c494fcf8e89e3c970e13d78ebe62bf5d8f2b1c52]

CVE-2026-90171: smb: smbdirect: release pending child sockets outside
the handler lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90171

Introduced by commit dc691b9 ("smb: smbdirect: introduce
smbdirect_socket_{listen,accept}()") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db82fbe4bb68e68e4aef00ef5b79f92991d8ef8e]
stable/7.2: [8ea83ef0c40ec4463695e22bc9ae43e29bcfede7]

CVE-2026-90172: smb: smbdirect: destroy QP before mem pools on accept failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90172

Introduced by commit eb3ed1e ("smb: smbdirect: introduce
smbdirect_accept_connect_request()") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [383a9480f5f40bc46454cce27ccfad532cedad9c]
stable/7.2: [959813a3752b459ed77b0b3eaf30b9f4c6204260]

CVE-2026-90173: smb: smbdirect: free completion queues with ib_free_cq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90173

Introduced by commit 6073eb3 ("smb: smbdirect: introduce
smbdirect_connection_{create,destroy}_qp()") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe2c0cacbcff9d56c03b296f68f22151c4223b04]
stable/7.2: [8a953b1a47fffb71e70767bc1e914401e3c2f27f]

CVE-2026-90174: ksmbd: fix slab-out-of-bounds read in ksmbd_alloc_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90174

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7405d0ba294306721843bc551611775e6edef516]
stable/7.2: [497c221bf6b2f659511719a6acfae84cc1be1caf]

CVE-2026-90175: smb: server: fix leak of ksmbd_ipc_login_request_ext()
returned buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90175

Introduced by commit a77e0e0 ("ksmbd: add support for supplementary
groups") in v6.12-rc4.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [1c3ebf832d010c08afe1359215d4121cb1ed2de5]
stable/6.12: [c9f2872e91b9fe99c1d0ba768906f7aeb48c8517]
stable/6.18: [7a98c3b903b10c4d6176948254012b5ca24b071b]
stable/6.6: [4d6fe49fa3e7fbd779c761518e6572e340233c9b]
stable/7.2: [abb5146b2d8197d695ea9eaa0847c73e34f00985]

CVE-2026-90176: ksmbd: Do not skip lock checks for single-byte ranges

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90176

Introduced by commit 5d510ac ("ksmbd: skip lock-range check on equal
size to avoid size==0 underflow") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [d40c24634fe077a0dc91fd11fccf44ce12b454d5]
stable/6.1: [a89cc145832e81c32199d4ca2e1ea8bd51ed601d]
stable/6.12: [f751d6e39d4c937c45f8fedc66699aa7d2d52288]
stable/6.18: [84c2d8e807ac489f5c91769293fb15dfdae8bae8]
stable/6.6: [993e0158331d37c04da18efe551b5e1e35fb3078]
stable/7.2: [07a9e289ff7edcc004f58952405f8a65c4e37512]

CVE-2026-90177: bpf: Check pointer type for all atomic RMW paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90177

Introduced by commit d503a04 ("bpf: Add support for certain atomics in
bpf_arena to x86 JIT") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bc49ae344d65cfcef738f281ac575cf73ca2fc5]
stable/7.2: [eb287c6e81dedef92da01eb947f380d0aae513c3]

CVE-2026-90178: hwmon: (coretemp) Fix core_data leak on CPUs without PTS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90178

Introduced by commit 1a793ca ("hwmon: (coretemp) Use dynamic allocated
memory for core temp_data") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cd8450c257faa0cece0e0c43d3b55d1a389acc7]
stable/6.12: [dc0d79b1be384e7f6a2308356afd10dcf3bf940f]
stable/6.18: [86c1617b7d4b001b20a71deda3c791538a4fa6aa]
stable/7.2: [9b23a010a1e8232974617c412cb9f578f3378b70]

CVE-2026-90179: apparmor: fix deadlock in complain-mode change_hat

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90179

Introduced by commit 32e9276 ("apparmor: grab ns lock and refresh when
looking up changehat child profiles") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [4ec11f14d1d6fdda787d991b142537be7841d395]
stable/6.18: [00cce5e457cb690a3b3b3d334e76e71049ec8ae5]
stable/7.2: [072fb5aeec2eac7d445bf28c7119a1d6f6a2e333]

CVE-2026-90180: block: mtip32xx: synchronize ioctls with device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90180

Introduced by commit 88523a6 ("block: Add driver for Micron RealSSD
pcie flash cards") in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68940f841d013192086a0f6d7cfbac2cd079e228]
stable/6.1: [521afbd936ac256b7531470b0b9aa96abf9cd853]
stable/6.12: [8a7799597bd683b6bc251fe2edfa9fd1db568a3a]
stable/6.18: [4609e0e0be709e974bec9b52c5022136d25e97d3]
stable/6.6: [8283049aa5fcb4e84b2b2928b2888903bb8ee12e]
stable/7.2: [b389dc35a55713ac24a145741e76196fea1663bc]

CVE-2026-90181: ublk: avoid teardown retry loop on xarray allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90181

Introduced by commit 309e02d ("ublk: avoid unpinning pages under maple
tree spinlock") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fd66a7f829f3f38f92a79081f0f2688aed644f0]
stable/7.2: [b9cc6cc74daf6fef533dbe65d8cee779fea69600]

CVE-2026-90182: blk-iocost: clear delay state when freeing policy data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90182

Introduced by commit 7caa471 ("blkcg: implement blk-iocost") in v5.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97cb95d2148835ae86ff916b145aef332d40439d]
stable/7.2: [b9c16db833e3ff15d923282f94dddf0e10fab8c0]

CVE-2026-90183: blk-iolatency: clear delay state when freeing policy data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90183

Introduced by commit d706751 ("block: introduce blk-iolatency io
controller") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8935bf22c0a0db517a7f72f7097300e05dd852f5]
stable/7.2: [02f1b90ab33ef99c89dd96a385b432ff57abc64d]

CVE-2026-90184: null_blk: serialize configfs attribute updates with device setup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90184

Introduced by commit 3bf2bd2 ("nullb: add configfs interface") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e1f23f9c33c156be7e313b40695af5a3a834739]
stable/6.1: [6352e7ead2d8111802a554eeb94886f5a9894bb9]
stable/6.12: [aed8af338a09a64d63b068a803c4ecfc5701dd4c]
stable/6.18: [32456a85995579e56c60cc53c357cda75a9d4f7c]
stable/6.6: [7de792b4c48fba02a36a8077032f7d5093c925e5]
stable/7.2: [d3d35dd045a35991bf6fd13de5f293e6dd7bf3b3]

CVE-2026-90185: null_blk: serialize configfs attribute stores with the lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90185

Introduced by commit 45919fb ("null_blk: Enable modifying
'submit_queues' after an instance has been configured") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e7fff51808237703a3a1df6dd5cae1dfd1db86d]
stable/6.1: [8e839ed5210399a0330a8a6c5885c1d40a537c6d]
stable/6.12: [3945ce8cbce4e328e6fdf0b522dc71e340de19db]
stable/6.18: [65cae82fd3c39b53430672cb9e3ecd267471a6ce]
stable/6.6: [88d806d0e1d36246208386a8e55b511c1b3d647c]
stable/7.2: [c70994c2862b05e44728912b2ea9487d31e2aea7]

CVE-2026-90186: null_blk: reject per-device queue resize for shared tag set

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90186

Introduced by commit 45919fb ("null_blk: Enable modifying
'submit_queues' after an instance has been configured") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cdfe2fa62b48728a9b436fbbd3dbe4c11593e24]
stable/6.1: [9c7bae099ddc92676ad1b7e29dd6c089e5f6196c]
stable/6.12: [f609f7bf9ce8c2fc427705c4a9f623a281239d06]
stable/6.18: [3e35ad503386a2e8a0e0460530dcbf421c79f6f2]
stable/6.6: [fcd53f3e8b758c79c3f2420d28a2a1dce6fda61a]
stable/7.2: [baff300541a0012907cdde349728739fe16176d7]

CVE-2026-90187: null_blk: free zones array on device power-off

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90187

Introduced by commit ca4b2a0 ("null_blk: add zone support") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a6357a9b935a34f5508618fee8a7fffbf7722a8]
stable/6.12: [056be41932c95aabdb3c2967d1ef4978f17a0225]
stable/6.18: [b2437d37fcc31fce8a5da1cc1739e284814d2491]
stable/7.2: [0a3afab87124171022fb3579502fa38ef5b311c9]

CVE-2026-90188: null_blk: free global tag_set on init error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90188

Introduced by commit 82f402f ("null_blk: add support for shared tags")
in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a1c5ff3a49ba93a1fd0b70537e7a0164071760d]
stable/6.1: [0b2faa330184340d9418ad2c627c2ae881772e33]
stable/6.12: [2882e1450fa4597811a951196e07553ea134eb31]
stable/6.18: [2b59484ac1e64dd78dbe8c6140891c6308085a75]
stable/6.6: [665c94554ff0d5d88caae7f40c16c8e0a3369eda]
stable/7.2: [081cf37e8a0e00cd91d6df53172c9d928790a798]

CVE-2026-90189: null_blk: register configfs subsystem after creating
default devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90189

Introduced by commit 3bf2bd2 ("nullb: add configfs interface") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9d293d6bb0575fcb1f3408129453187e2a28a4e]
stable/6.1: [2679b11e9256bd70a5ef41783bab6ad6c34a3db1]
stable/6.12: [57debc907aef66319d244009d3370dcd97388d37]
stable/6.18: [d761be1b8f2bbabc41252deb79a426d3f0d4fa10]
stable/6.6: [dbcedbe4819ae21274ea77469e61e46a878b9943]
stable/7.2: [cab9bf5f68f76cd44e0ec92bd4a60c9b83656a36]

CVE-2026-90190: null_blk: use DEFINE_MUTEX for the file-scope mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90190

Introduced by commit 49c3b92 ("block: null_blk: Improve device
creation with configfs") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [017dac7670909eaea3eb36e6b3b5a8be9ce0a14d]
stable/6.1: [f9f4ca45c770b7eec83fea6c9b727b26e691b513]
stable/6.12: [0a8c2f7b95981913ac370683e34db4906970c210]
stable/6.18: [c7dea90c9b4ef1dfbd2e4df36de180c76fd7c33c]
stable/6.6: [349903f7ee72f7ac5b7a98840d701b2082d140a3]
stable/7.2: [234117949da3b3f9705a21b66094f9f30bbe681d]

CVE-2026-90191: mailbox: riscv-sbi-mpxy: validate RPMI notification lengths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90191

Introduced by commit bf3022a ("mailbox: Add RISC-V SBI message proxy
(MPXY) based mailbox driver") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11d5af151bcbe78f5a579e0faecd3be9cea0399a]
stable/6.18: [cbc24bce70dfd91c7b2f53b4fa896e9a4b6d6a6b]
stable/7.2: [c7bc5e7677bcda7a446d63b989cfaa3fe91d6b76]

CVE-2026-90192: mailbox: qcom-cpucp: handle NULL data in send_data callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90192

Introduced by commit 0e2a9a0 ("mailbox: Add support for QTI CPUCP
mailbox controller") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc4f2f99530298a1739226947aa76525142d421d]
stable/6.12: [3d11d2a6c9a10de287e0f1b53a5e65d16afe2760]
stable/6.18: [413b0b94d6d06b8d49735280e86a01dac90cf177]
stable/7.2: [b3d73e7440e0c40644285be1bda349cdf90122d8]

CVE-2026-90193: mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in IRQ handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90193

Introduced by commit 0e2a9a0 ("mailbox: Add support for QTI CPUCP
mailbox controller") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3690aaa6d18f6775c3e7932fb8af8c5bf6a6b69c]
stable/6.12: [aa482273f32117c3adeba9b1cc945e0b5d33722d]
stable/6.18: [8b8de6400c86937ed57d680d06d716e167b381de]
stable/7.2: [e40b3edeaf25cd09e9c88edb1ef99373ca37593b]

CVE-2026-90194: ACPI: scan: fix bus ID cleanup on device_add() failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90194

Introduced by commit d783156 ("ACPI / scan: Define non-empty device
removal handler") in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a414485ebc2aa50907d0ce97cde2b1a353696897]
stable/6.1: [8cc2017aa804f157e717b5fd471e50fbddfec654]
stable/6.12: [83ee65feadc88de681abc6e977d54eceda95abd7]
stable/6.18: [15512c6b5dea72fb5f1f41c1aa96f3f32531ca03]
stable/6.6: [f30379b8a4e24623594235dd5aefb2957e0cc228]
stable/7.2: [0b9053cd0955c7cd66d71a8442be33926d70e197]

CVE-2026-90195: riscv, bpf: Fix missing sign-ext for signed 1-byte and
2-byte kfunc args

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90195

Introduced by commit 443574b ("riscv, bpf: Fix kfunc parameters
incompatibility between bpf and riscv abi") in v6.9-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2aaa621591093cfe8224a25ef2f04a3b1e304b0]
stable/6.12: [555fc6f1caf00ce7005e732b688da26c0dc3c5c5]
stable/6.18: [801ae90f8ce099187e6224cec7d72d07a4df0324]
stable/7.2: [71dbd143be598954ae103feadd12692aeb0f2f88]

CVE-2026-90196: ASoC: SOF: validate topology volume range before allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90196

Introduced by commit 311ce4f ("ASoC: SOF: Add support for loading
topologies") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a698e4a60fa54268a38f4e66378851a196cb139b]
stable/6.1: [992e130b888699d18da901b593d7a0fb75041a03]
stable/6.12: [8e1d63f5e272061208455b5aa4cc0d5bcbe5c1a8]
stable/6.18: [d2f41287b51a3261d447ae38000f7a6f5860663a]
stable/6.6: [cd63a1eb677e9548ba2d512be5dac4cb474ae145]
stable/7.2: [72d0b77412aef2cec554cc84e176658f2a48dafa]

CVE-2026-90197: HID: haptic: don't write an uninitialized value to
unhandled usages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90197

Introduced by commit 344ff35 ("HID: haptic: initialize haptic device")
in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3efb7f6491526f5012f9ec94769e9ed832feeef8]
stable/6.18: [324cc98b71f0d3dee7367ef3c669fd80747e71b6]
stable/7.2: [2d92c250815cba6bffd64f0125fac7afe4fa6ce0]

CVE-2026-90198: ALSA: core: Fix use-after-free in snd_card_do_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90198

Introduced by commit e8ad415 ("ALSA: core: Add managed card creation")
in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ae1a690c522fea2900ff56c8c2ace7b059f5e04]
stable/5.15: [d3d67f680dbc23a5e5e3d3ecfdbf700465809877]
stable/6.1: [09b27dd01b98480334c10bf6fb8d41d5fb063a4b]
stable/6.12: [6da22efb5cf490b06ffbca32b10fc8af7654fee0]
stable/6.18: [a561012868ae37c28f61fdf658bf6f251bc0e8e8]
stable/6.6: [03c5dabc8f16bc212a5b26d2425c03a55e55a86d]
stable/7.2: [7d9b5e86775fa97a487da08b9aa76e1674bf8868]

CVE-2026-90199: fs/ntfs3: reject out-of-range evcn in mi_enum_attr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90199

Introduced by commit 013ff63 ("fs/ntfs3: Add more attributes checks in
mi_enum_attr()") in v6.6-rc7.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [20fd9f64c0050658f2031e6bd5d552c6f0c8f7e3]
stable/6.12: [7ab69cef49ebdfee288287d62641b24ab1445ecc]
stable/6.18: [ce9a619c432b9a4044fee115c5483fbed946c131]
stable/6.6: [0441e34ce098c19185a7b52c5b8b89a8a5b26888]
stable/7.2: [2b9a0e57bfd365e2096706b19ae34dce3b4a884b]

CVE-2026-90200: fs/ntfs3: fix integer overflow in MFT cluster validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90200

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c510c63873103a5da6a498fe537bdb5d6f8d03a2]
stable/6.12: [805cc5554b13d045dce9b03c13eaf015418739fd]
stable/6.18: [dc6d85de7e2656e56e10ff5ba514f2583a4f612b]
stable/6.6: [f77a8d9fdf58e298b36564a44c27fadc617bdd28]
stable/7.2: [169383d8914b8fe03464a83540b5b6de3e7831af]

CVE-2026-90201: net: page_pool: fix UAF in
__page_pool_release_netmem_dma on xa_cmpxchg race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90201

Introduced by commit ee62ce7 ("page_pool: Track DMA-mapped pages and
unmap them when destroying the pool") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [24ef02f934eeb48830cff6b739abc3c62b1d107b]
stable/6.12: [bbfef303f980c1c078b8fa142e10a0e2fbcdd247]
stable/6.18: [424a9fc4876cc7f28e9cb0aa8d92e920d726e350]
stable/7.2: [9b65b0253ad5a66f73efee9a79a21a1e2b57cf59]

CVE-2026-90202: scsi: mpt3sas: Avoid freeing unallocated PCIe SGL buffers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90202

Introduced by commit dbec4c9 ("scsi: mpt3sas: lockless command
submission") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b9f679dfe629004b593f018df33b330d799bcee4]
stable/5.10: [3361709fb6f6568b157c6f24ed21a4a5d86d73db]
stable/5.15: [240b582b6372bebb1245d911add9954b7dd6c02d]
stable/6.1: [a61181f9ee30a98d2350c1bff32954a7521f9a23]
stable/6.12: [bc3398db3b64729b4a7907af317daad04795ad40]
stable/6.18: [2dbdd025b228110ccbfbab95fe16e098313a14af]
stable/6.6: [afedf35df054bd713e9e13771aa0a056932c5c67]
stable/7.2: [e2cd23443d3616ea0876f27762b17e2ec67d896c]

CVE-2026-90203: Squashfs: check block offset is not negative

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90203

Introduced by commit f400e12 ("Squashfs: cache operations") in v2.6.29-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e300eb5002925b29be803d2661af07266cfa267e]
stable/5.10: [b169185d5c672b989985c6c2e38cafab2548ba88]
stable/5.15: [c2a126fca820ae74872da28de68dc74d4595dc4b]
stable/6.1: [95dadf366c117dcdca78a570e6832071deab1ecd]
stable/6.12: [bbb2218eb072b0a15dc063929200183bd23c2344]
stable/6.18: [d0a3729d464fcf516416a41cf304c0c92126ee03]
stable/6.6: [3d2f0cb66c909ea2312cdef465165bb9a3ba2d84]
stable/7.2: [e4afd90bc7bf3dd477970c6c42bdd29ad3fda7fe]

CVE-2026-90204: ocfs2: validate DIO orphan slot during inode read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90204

Introduced by commit 06ee5c7 ("ocfs2: add functions to add and remove
inode in orphan dir") in v4.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb88131c9831075b8dc08cdd375743e5d44c7ca2]
stable/6.18: [e35fa6eb4d2a39f8049f62361a4b44930882b5f8]
stable/7.2: [418e0ae42fa769d354b15e62c01a00413024755b]

CVE-2026-90205: ocfs2: validate orphan slot during inode read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90205

Introduced by commit b4df6ed ("[PATCH] ocfs2: fix orphan recovery
deadlock") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2d31acbd3b182755b019183fb46949ba5e39b9f]
stable/6.18: [c6c908f9b4edfb04534b15573168ae038f7a9cbf]
stable/7.2: [3d7c4b7ce7b4baedfd8699fa692cd95f77d332de]

CVE-2026-90206: nvmet: fix max_qid race between configfs and
controller allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90206

Introduced by commit 3e980f5 ("nvmet: expose max queues to configfs")
in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1a8846e06388113dfdbb89dee005083fa9afdf9]
stable/7.2: [2c23fc91789dfd9db746edb3ae9b90d65fabd410]

CVE-2026-90207: ALSA: seq: midi: Serialize input teardown with event_input

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90207

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [403f7f3ad3808a0096d84cf228fab68dc253fd9d]
stable/6.1: [de76a2b47582cd6dba2e15f024681bf377ecc94a]
stable/6.12: [6290afaae54c7a9fa3bca3b4d5433e6d83e8669d]
stable/6.18: [210c193a9ef1312fab153948c6928e4cfaa1f03b]
stable/6.6: [89d986897aff7275b42e075e556731b8353366af]
stable/7.2: [282a3ef9e4b63b2f6823bbbb3c1a90b002cdaf12]

CVE-2026-90208: clocksource/drivers/samsung_pwm: Switch to raw_spinlock_t type

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90208

Introduced by commit 7aac482 ("clocksource: samsung_pwm_timer: Make
PWM spinlock global") in v3.10-rc1.
Introduced by commit f118998 ("clocksource: add samsung pwm timer
driver") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b212f9d70805d91febae01d618868f4860e267c]
stable/7.2: [7eb5764d25c4ac7f5d126621660f7219b61fd2fd]

CVE-2026-90209: s390/debug: Fix deadlock during unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90209

Introduced by commit 9372a82 ("s390/debug: fix debug area life cycle")
in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [445c31ac638fd1af203d79bdf25fc0cb3149fbbc]
stable/5.15: [a214c3dacc779b2afcb0ac9c8001e45ee4ffb2ed]
stable/6.1: [183f8f6d64bb0510070c856b9927618c53014a7b]
stable/6.12: [45bb341d1b73eb293e0dd43d9b72bbc8b615d0ba]
stable/6.18: [5d83f3faa3fb7f23f298cfd40382611999de5d1d]
stable/6.6: [a08b70ed2d1ec907353a72f15163b8e34ff4b2f8]
stable/7.2: [54e1259b75d6402a1d0cfb822b9bb2c507e53dab]

CVE-2026-90210: bpf: Fix UAF in bpf_trampoline_multi_attach_free on
update failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90210

Introduced by commit aef4dfa ("bpf: Add
bpf_trampoline_multi_attach/detach functions") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0253073fb7d79a2dd2eae9581ea16db2aef395a6]
stable/7.2: [65c3939656fd7848e9274faa07c26748b5bf049c]

CVE-2026-90211: bpf, s390: Clear fetch destination on faulting arena atomic

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90211

Introduced by commit 2f94694 ("s390/bpf: Support arena atomics") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc3e12330599f097f0e1f792435686ddc276f26d]
stable/6.12: [1a26541b3f60ce447433a4c4dd56edb10d2cd580]
stable/7.2: [44b702fceb4cf3a4ddbfb496f487b034814bf1a3]

CVE-2026-90212: arm64/efi: Avoid voluntary preemption with efi_mm installed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90212

Introduced by commit a5baf58 ("arm64/efi: Call EFI runtime services
without disabling preemption") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e98a9d0146372b046d863164025a66ab4488b972]
stable/7.2: [829539c4a650544cb8e5e8690f2c2d0aa2c0e298]

CVE-2026-90213: firewire: core: fix memory leak in error path of build_tree()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90213

Introduced by commit 3038e35 ("firewire: Add core firewire stack.") in
v2.6.22-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05bfb1327dc5fb61528bab31cd8f0c1e4bddec23]
stable/6.12: [848eaef4d30b385eb074214b7fa58287506158ad]
stable/6.18: [d6037e42aa4dd29bb9d9f67ef438128c5bfe3448]
stable/7.2: [6a990e74d4e848f32eda91d69e4f885604fc326d]

CVE-2026-90214: ASoC: xilinx: formatter_pcm: fix stream_data leak on open error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90214

Introduced by commit 6f6c3c3 ("ASoC: xlnx: add pcm formatter platform
driver") in v5.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b992511180e126150c6ad3580a6fd568c385f4c6]
stable/5.10: [5e1a2d9fff57f3a2b1a0f54d128d64245a253004]
stable/5.15: [edf81b293cba1b00a5e71becf184414f6991a6ca]
stable/6.1: [3fd89a51b8cfe788df67f54b716b305dd45b8468]
stable/6.12: [9030aa4e14b704dc39ee208207cb65064020d857]
stable/6.18: [8b30628dfc2b2fad3b55a9441776a226035045fa]
stable/6.6: [8c38ae4a465691947977c25d10394da22a64a19f]
stable/7.2: [4e0ce77df7d9808926719d7950a07fbad14ea9ef]

CVE-2026-90215: mtd: ubi: Release device reference on busy detach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90215

Introduced by commit 7e84c96 ("mtd: ubi: introduce pre-removal
notification for UBI volumes") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31dd710cd84d5dd63c49f640d3a9f36c9699ca95]
stable/6.12: [87812858c4c8df979cb70bcd0040b925a543df6f]
stable/6.18: [e065960366b55ab21e6c643c30dec2a41451900b]
stable/7.2: [851c5e9a829d56cb0982965f07ef8966a6722884]

CVE-2026-90216: ubi: Fix rollback for explicit UBI device numbers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90216

Introduced by commit 83ff59a ("UBI: support ubi_num on mtd.ubi command
line") in v3.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b0a6b554e12a97f9771a9a9f4ea1f5457373c73]
stable/5.10: [83c978921688af40dcab6db74882d1ff9b0b765c]
stable/5.15: [6b92e66ec6dd8019e8efb2a568ef7c967c5a18c5]
stable/6.1: [4417ab6ecad01cf2d01045ef8104c95a66b0e893]
stable/6.12: [9754f049d5f1945d4c691d1f52824eb8daf8f9be]
stable/6.18: [e3f7e58189bc222971ddc860f1716f37e51ba996]
stable/6.6: [552e565ed8846e7db143e4a6bdf3f5677453c686]
stable/7.2: [87b3da4acb860605643ebee312178f13b20744cf]

CVE-2026-90217: bpf: Compare iterator types during state pruning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90217

Introduced by commit dfab99d ("bpf: teach the verifier to enforce
css_iter and task_iter in RCU CS") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83608e303b95d07afba1c15da0b5d9e513c2f15a]
stable/7.2: [6424b9cde9edc7f2098115bbfd1ee3d84a958380]

CVE-2026-90218: RDMA/cma: Fix WARNING in res_to_rt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90218

Introduced by commit cb5cd0e ("RDMA/core: Add CM to restrack after
successful attachment to a device") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [c6d1ec4fbe56492bb88987d577f04a5fb6955f26]
stable/5.10: [1d7e55ea64dd15769318ba2e0fe0956db82ba3c3]
stable/5.15: [39e83bb77fc92344cd62a373b311f096d812e548]
stable/6.1: [9c80273d663959504957606b9a24fe901ee2a4a1]
stable/6.12: [f72957e0b31f2962f4c1089a9223f1206aa26983]
stable/6.18: [544e40805dbb6cfe64916bd4c8b238fec585ac2a]
stable/6.6: [2a63cb9ea862ac7d947952b497eef6520853538c]
stable/7.2: [64a2bd4cfc16c24f0a0e6321a2fd00ffde3e0a5b]

CVE-2026-90219: RDMA/cxgb4: Free debugfs on registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90219

Introduced by commit 49ea0c0 ("RDMA/iw_cxgb4: cleanup device debugfs
entries on ULD remove") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [fe5c16bb6252dea6025b748257ddc3b2665495b0]
stable/5.10: [459b59f7ed56511d6529311cb4e5e482ebfcfb8e]
stable/5.15: [cd60992f09b7e83bfd3c76e3bb06b29f3e2fa0a8]
stable/6.1: [c332d9e7dce234d8bef78271d003a68ee943b61b]
stable/6.12: [479a7f90060e62bdd9bb4036ec0a70bf460f6d23]
stable/6.18: [046425412529dbfca1433c8bef5641b271b4ab2a]
stable/6.6: [f98e894ec029a752cf9c7f7834741bead0fb463d]
stable/7.2: [ea41b5630fa3d9877ce9ed8832cf5575f742bfbb]

CVE-2026-90220: ALSA: seq: Don't leak the extension cell pointer in
the bounce payload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90220

Introduced by commit efc8669 ("ALSA: seq: Fix kernel heap address leak
in bounce_error_event()") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [59e1592d3c270ff4642d5d6dc55c545306eb0693]
stable/6.12: [42c3f856d13a91a0d4c302a0c6854813621136db]
stable/6.18: [b1e8d40663997aacaa198f37ce6893e07aaba77a]
stable/7.2: [6e6e471eef1d5d8cb056c7d364023fe048249204]

CVE-2026-90221: nfc: nci: fix use of uninitialized memory in
CORE_INIT_RSP parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90221

Introduced by commit bcd684a ("net/nfc/nci: Support NCI 2.x initial
sequence") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d56575a2595ee1f597f39e8a1cfb67ed3501678d]
stable/5.15: [baed3fdf6ed2195c56f25ae18a086b938dcd3983]
stable/6.1: [2f434478771a4ebdd535033561c0590bcde39753]
stable/6.12: [bbe68e8249e2c76d65adfd9224fa95f1ca0fbe4e]
stable/6.18: [4f0483bbcdaccc9d4aee30df7351863334cecfa7]
stable/6.6: [5487f04c1ccbfa15aa6e531eb1ec9c9ec9c7bf31]
stable/7.2: [7d44b897bff84edcd4814899314d661ad4956a8e]

CVE-2026-90222: nfc: pn533: hold a reference to the request skb during
send_frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90222

Introduced by commit 9815c7c ("NFC: pn533: Separate physical layer
from the core implementation") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47792358a624ea066455ef86b744159928cd7716]
stable/5.10: [8710faddef4ad8b2a6bfa985d896e2e1bfb77018]
stable/5.15: [19f1239758c23f087f4c25733cfcf62bf0b06051]
stable/6.1: [7ee72c64b4b66b1b42dbddbca0a80a218f1b9297]
stable/6.12: [d329f61ad5786900334a54c2445dc99feda545bf]
stable/6.18: [7a8e0a7aef80721da287ac246349aba7d98f6aed]
stable/6.6: [753bdaf3220fe8371a6c3c75da645ea7753d11be]
stable/7.2: [3e7a093c177f9f8b9fd039cab41191515079425a]

CVE-2026-90223: nfc: llcp: bound SNL TLV parsing to the skb and add
length checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90223

Introduced by commit 19cfe58 ("NFC: Initial SNL support") in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4c7f37f0ab990952539dc68d931d65c3657600a]
stable/5.10: [88b36d36e12c9ba76decdb580d9c1907c084e587]
stable/5.15: [587fc2a5a35b41883b22b8f808fe5d345208914b]
stable/6.1: [f04ac9bf2379f3e2470c400c235eb12f74891bef]
stable/6.12: [99fdb5c2522f365efa199d0117b641e35097041e]
stable/6.18: [749a9048bf51a668ec3ab6c0392ba32325607281]
stable/6.6: [02030f95820c42431280f4f945ff34247fb840ff]
stable/7.2: [eeb16fb24cfe67947b832fd9ada5f488afc72579]

CVE-2026-90224: nfc: nci: fix double completion race in
nci_data_exchange_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90224

Introduced by commit 4527025 ("nfc: nci: fix circular locking
dependency in nci_close_device") in v7.0-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [8265a626cc14a48e46e6dc8c47667e72b4232ac2]
stable/5.10: [3f075832734005310740d148d1cf1c1e792ebdca]
stable/5.15: [588ccd19a6e69eca72d54608c3ab3b45709b2305]
stable/6.1: [cf646a9f5554bc07d6ccb59c327812b3a0c6a368]
stable/6.12: [bfdf412208fea7fc0d5b32d68a35b25261917393]
stable/6.18: [ba4c776af3dc21ed04e315e6545e99703bb1b53a]
stable/6.6: [9030a1bbe2c6b1e3e54cef462d159b5248f09fd2]
stable/7.2: [ee08414d78b851e3d1856d6e4d631939b01a1bbe]

CVE-2026-90225: nfc: llcp: read llcp_sock->local under the socket lock
in getsockopt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90225

Introduced by commit 26fd76c ("NFC: llcp: Implement socket options")
in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36812527052c5bfb1ec6c1e292d67a5bf76b750f]
stable/5.10: [56fd158fef20268f48db6cdfe5d722e930134eda]
stable/5.15: [8ba8cec0586727cc135ca4827921fc7b52946d71]
stable/6.1: [ed5240bab3468988077fe8bf29b935eaecc9ff89]
stable/6.12: [2d8ac24565be85bf56580b87bf1b874d35625eb5]
stable/6.18: [156e65bd29307f5053835bff60bc1ba342fa010f]
stable/6.6: [fe65727a4a21b11c18eebae1338482767a897b76]
stable/7.2: [d1b73962675cdc5a58e2707e25b548d8b495fde0]

CVE-2026-90226: nfc: llcp: avoid userspace overflow on invalid optlen

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90226

Introduced by commit 26fd76c ("NFC: llcp: Implement socket options")
in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99985bfa8336fadcc69190ba2dcbd5386af3d661]
stable/5.10: [42859562b7cc4313a84a584f338118edb7087066]
stable/5.15: [598dcd53c52f8eeb9dd5382198c03960d5d40fcd]
stable/6.1: [7e40f2f5e7bc06c3ddef781180ce4f7994176547]
stable/6.12: [b4c5abaea06292e1dddb70eac1b51589b32c77a3]
stable/6.18: [8bf228fa02b1ed8ce622fb81fa8edc42be9aeb67]
stable/6.6: [35573c6cb081af2f4a7caeea291302aca5484526]
stable/7.2: [bd6f1277b62bc1df348ca21739df2bc546fcd493]

CVE-2026-90227: nvme/ioctl: check SUBMIT_IO with nvme_cmd_allowed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90227

According to the .vulnerable file, this bug was introduced by commit
a53295b in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b53d495c7f0db46b6748b5ade48371a10dd5d3bc]
stable/6.12: [95b0591d51dbf9e618d7845883d535e88ad7c8af]
stable/6.18: [736b7c6adc7a65c4411beff197b6a634f7a6ca27]
stable/6.6: [c35cd98eed1a863e8dd51073953563cd8c907f68]
stable/7.2: [b116e9dae433ff631f94c36c61a7a78fe400ed1e]

CVE-2026-90228: nvmet: fix NULL pointer dereference in
nvmet_execute_identify_ns_zns()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90228

Introduced by commit aaf2e04 ("nvmet: add ZBD over ZNS backend
support") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f594863967d87b7fcbff6e724d51135fd701a13d]
stable/5.15: [1ce8faf90eb0bf5599b90db38500aefea9426485]
stable/6.1: [b873099944dae5702b4b6db6814d1f1e8d4cfb00]
stable/6.12: [cc29f7082b7ab5e0337f27d1fef16359f05fcffa]
stable/6.18: [1fb1236312ee1a600de6b3ca560f0b3fd5a50471]
stable/6.6: [ff28a93a895912010a7827a0e1445ebe8be53b4d]
stable/7.2: [0b4cf43f9ca7118590a338de900edbd6047cd89f]

CVE-2026-90229: nvme-apple: Destroy the admin queue on removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90229

Introduced by commit 5bd2927 ("nvme-apple: Add initial Apple SoC NVMe
driver") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87d5b9864c8118d26f54de4b66d2bddf2c659272]
stable/6.12: [bf51e306e3dcffd1a63ef09a7a39d28f3578dd2d]
stable/6.18: [215d1682f0bae495f3f9cf692b358116b7a18602]
stable/6.6: [5f6f4777b7a8676251139dbfbcdec3cb578f0e40]
stable/7.2: [c11685ee4eedc70f738b117a4a8c0fbe84cd79b3]

CVE-2026-90230: nvmet: fix heap out-of-bounds read in nvmet_auth_negotiate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90230

Introduced by commit db1312d ("nvmet: implement basic In-Band
Authentication") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bb96cc218835769ab74ec7f3ea2bf81fbffe955]
stable/6.12: [aaac783950b17c57df9b6f7344747cacb1a407ed]
stable/6.18: [c38a8186326799957d293d370136c128cd113916]
stable/6.6: [89ff11b72f38976f3b5aea23a5228ee05e277209]
stable/7.2: [7b81e4d2230e3d2d372c826180c4ef0efc244f31]

CVE-2026-90231: apparmor: fix unconfined user namespace restriction forced stack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90231

Introduced by commit 2d9da9b ("apparmor: allow restricting
unprivileged change_profile") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08c2f7c8d4b1434cfae006f3daf4d1bce330b57b]
stable/6.18: [7d1099b86356df81c379159bfb8a598aaf83ce81]
stable/7.2: [7da0bdf0610f6d35bbb061536a47fc41646306f0]

CVE-2026-90232: amt: Don't support cross-netns setup.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90232

Introduced by commit b9022b5 ("amt: add control plane of amt
interface") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e99ecc3046ea5f5c6b5e1f8b4ef854c6c6998e06]
stable/6.18: [569eb11f0990849ba48706a2bfa743273707e254]
stable/7.2: [e1dc0af719a2566ae7ccb82c0a11f70aa54908e9]

CVE-2026-90233: nvme-pci: release descriptor pools on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90233

Introduced by commit d977506 ("nvme-pci: make PRP list DMA pools
per-NUMA-node") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb144c2f67128abfa5c7ba33318617d19f192156]
stable/6.18: [c25b6b28a35f9e36ce5dd6da5905bcddb2128707]
stable/7.2: [79fb405966edb5065234440d94cc75bfd7b01f41]

CVE-2026-90234: NFS: Return a delegation the client fails to record

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90234

Introduced by commit ade0464 ("NFSv4: Ensure we honour
NFS_DELEGATION_RETURNING in nfs_inode_set_delegation()") in v4.0-rc3.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [220af23d863995091f0edeb1e6aa0945b3db8b37]
stable/7.2: [92533e49fe3c455088657b862cf3562260c0ce25]

CVE-2026-90235: sunrpc: xprtsock: annotate shared socket callbacks
with READ_ONCE/WRITE_ONCE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90235

Introduced by commit a246b01 ("[PATCH] RPC: introduce client-side
transport switch") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33930840b5f0a79f826e7c69dc6cd78f72a67481]
stable/6.12: [589f761236e05ff9de1bdfd6a5258f113e6457fe]
stable/6.18: [da652cb17f9faeea1fa44b7215e8869a0b10b664]
stable/6.6: [ed80d009b154aa204f541d390884851b3d4f15ae]
stable/7.2: [d8f0b83753809761a560c4b33249388548ba6e43]

CVE-2026-90236: NFSD: Release the export reference when reaping open stateids

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90236

Introduced by commit ba0cde5 ("NFSD: Track svc_export in nfs4_stid")
in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6480bd703684ed3f760e9e36c4a699033c0806ae]
stable/7.2: [7458727fd7cb79d09e5120b6fecc1ad11cdb0946]

CVE-2026-90237: netfilter: nft_ct: move custom expectation support to helper

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90237

Introduced by commit 857b460 ("netfilter: nft_ct: add ct expectations
support") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3679da4ad8be84cddaf40bc307fef1fe13e051ff]
stable/7.2: [af3fe52fd108fd38235e4813df62442ed0f1d8ff]

CVE-2026-90238: media: amd: isp4: fix self-deadlock in
isp4sd_pwron_and_init() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90238

Introduced by commit 4e5e7a7 ("media: platform: amd: isp4 subdev and
firmware loading handling added") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef46d80a7015269a98c9505b5912a83798799199]
stable/7.2: [74669cc3483e9729ca26b4e06a096ccdd607db64]

CVE-2026-90239: media: amd: isp4: release partial allocations in
isp4if_alloc_fw_gpumem()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90239

Introduced by commit 4c5feef ("media: platform: amd: Add isp4 fw and
hw interface") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fea97ee13c5332f67850733d6cefc1fe99460bde]
stable/7.2: [a1f8750668e552837df781783909f2f680958006]

CVE-2026-90240: iommu/vt-d: Flush context cache with correct SID when
tearing down aliases

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90240

Introduced by commit f90584f ("iommu/vt-d: Add helper to flush caches
for context change") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c54e4ae971b98e8d650400137d332cee56c03f55]
stable/6.18: [a803141597d61dc0511f7cd849625e17d042ca8a]
stable/7.2: [5baddf100b3be730912485648cbaae5e3a251923]

CVE-2026-90241: iommu/vt-d: Tear down scalable-mode context on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90241

Introduced by commit 301f1a8 ("iommu/vt-d: Setup scalable mode context
entry in probe path") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c509fb73a1093a15accd7d43a61645d4b520f6ac]
stable/6.12: [25ac85a9747cd63e1d166ace7b360a2cd9479d9d]
stable/6.18: [d0e978ced7429b516358bb4d41d337214768ae98]
stable/7.2: [db5daf25f754cdc20c18525adb88240ece6fdee9]

CVE-2026-90242: iommu/vt-d: Fix iopf_refcount leak on RID domain replacement

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90242

Introduced by commit 17fce9d ("iommu/vt-d: Put iopf enablement in
domain attach path") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [236dd58fabd2e951b940a6ad88b81147899ed311]
stable/7.2: [143cd37ce76527ddd6f6dbac4a89bde31fb8b0dc]

CVE-2026-90243: iommu/vt-d: Clear Present bit before tearing down
copied context entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90243

Introduced by commit c719198 ("iommu/vt-d: Factor out helpers from
domain_context_mapping_one()") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f532c57985b1a7d6b7e37e05506b46d413e5cca4]
stable/6.12: [97750a8dce79c1a9b2b2d2a020b61b800141996c]
stable/6.18: [3c88cfedc7768b1ae2dc7ddc71547ae9a1aaff7d]
stable/7.2: [6b822d18c33af9d1e16a8e5e6aa6e656987b09de]

CVE-2026-90244: iommu/dma: Restore locking around msi_page_list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90244

Introduced by commit 288683c ("iommu: Make iommu_dma_prepare_msi()
into a generic operation") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a9e89ea34e0e34ac5d7e949042d665533549e40]
stable/6.18: [e3c53e9173a47d5ce1fae020f2c6b1fb3c1123c2]
stable/7.2: [2af1e99ec14d226d66ceb9f16c663ee2568e6676]

CVE-2026-90245: fbdev: kyro: Validate overlay viewport coordinates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90245

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b5c7bc55e13e7f5ac7b1eaf5c6d690389ea5ee3]
stable/5.10: [d8c1a9579cbd8f4ac5cbd5a10f1afb5ee64adf30]
stable/5.15: [2ac6e30a552e6f9932c21c865a5c69f40c8aef64]
stable/6.1: [413d763439ba68e5d547538e6b6c7de97d5818a5]
stable/6.12: [a6decd4e72fc5846d3b268bd085a2089213fd5ee]
stable/6.18: [33e54e3e0b2ca959304e62c3d84f0ad49bbe1afe]
stable/6.6: [e8d4e4cf388daeb49704f3de10b203034f28eb90]
stable/7.2: [7bf36dc23bcf3496dec274a46ae0aaff4961ea03]

CVE-2026-90246: apparmor: fix integer overflow in verify_tags() bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90246

Introduced by commit 3d28e23 ("apparmor: add support loading per
permission tagging") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [465946d3c560c0137e6a180ba054dddc4d049f5a]
stable/7.2: [ef79a405f83993f0fda5efde371d98433f7d7a47]

CVE-2026-90247: bpf: Fix mmap_lock leak in irq_work path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90247

Introduced by commit eac9153 ("bpf/stackmap: Fix deadlock with rq_lock
in bpf_get_stack()") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [fa9dcacdcdf487f0ffef64bf67622f1caed509f1]
stable/6.18: [a052ad5edccf5319f50ed955de4368f8318a9f20]
stable/7.2: [051f2da26ce377f683b938a3382e0f16d02f3139]

CVE-2026-90248: net/sched: cls_api: fix teardown of an adopted proto
on insert-race loss

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90248

Introduced by commit 8b64678 ("net: sched: refactor tp insert/delete
for concurrent execution") in v5.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4e359b3608a0e184bbe8d61a5c3b50d0831c44a]
stable/5.15: [a68e664ddf16ecae6d769d6a2eb356f8abab75c9]
stable/6.1: [df02b6dc136af45e92ee4c86f4aa6c9a60790b1e]
stable/6.12: [219c87aeefdcc8c1caf28cc99e9b361ce7393d3a]
stable/6.18: [bbe2fd6d77df630356185406a97317f6aa6a92cf]
stable/6.6: [bee2208276c8e0e40a249ffdcf6e5434a79a847c]
stable/7.2: [dc8b33b819cb02a75936940c120aa669ad89942d]

CVE-2026-90249: iio: light: gp2ap002: Fix unbalanced runtime PM on
repeated event writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90249

Introduced by commit 97d642e ("iio: light: Add a driver for Sharp
GP2AP002x00F") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [579c049b4cb6fc72ce2c505fc5334540be0efcd3]
stable/5.10: [b2d7a97d75b648a643f60d77f4d6d70161268855]
stable/5.15: [685d9d1e5c47e024413981fb7eddab86132b04a1]
stable/6.1: [56fe8e5f313a64e458bb6f8b982de925345e21a7]
stable/6.12: [70b9482926ca92862460e659f5e5fde99ae0b4fa]
stable/6.18: [0fc740c25c9abb25113398ebb58e2f2ce57741a7]
stable/6.6: [8e76ab81319858736ccf23141e9415f9a1869337]
stable/7.2: [470edb012b1d9a4fba1cd59e329e60f0798c791a]

CVE-2026-90250: bpf, cgroup: Fix storage null-ptr-deref after replacing prog

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90250

Introduced by commit 0c991eb ("bpf: Implement bpf_prog replacement for
an active bpf_cgroup_link") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f562c537e9ecf4bc5e206cfffc2cc047f1b7e94]
stable/6.12: [a033c950f6731be88a7da98604ed78f302f15b80]
stable/6.18: [1ab3da12061d7ccb099f7e925fa2d865967a316a]
stable/7.2: [12feca126831556dc7fabe5a3ba28fbd328768b6]

CVE-2026-90251: Bluetooth: MSFT: validate evt_prefix_len against the
response length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90251

Introduced by commit 145373c ("Bluetooth: Add framework for Microsoft
vendor extension") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0079e1a944634ab2dc1c7cdec1144486d096407e]
stable/5.10: [dce783a10e70f013410f5b583a29fc3286899629]
stable/5.15: [21f539c59ed330b671d75fd119c5f659ff92fbd1]
stable/6.1: [52b1b3b4d403cbda1b70ce2385e1a71f166a87ba]
stable/6.12: [620c2631cff490d14d0b9d56f185cc745806d6d7]
stable/6.18: [7c2658023d839b651368a5b8b781bf9a817647cb]
stable/6.6: [e804d54a5a99d99250490e68093eff7190472e6f]
stable/7.2: [63562cfaea8a650fdb31ee8de21c32e3600be642]

CVE-2026-90252: Bluetooth: MGMT: free the HCI command when it is cancelled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90252

Introduced by commit 827af47 ("Bluetooth: MGMT: Add initial
implementation of MGMT_OP_HCI_CMD_SYNC") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [414b365ecea6c30357adee6b8a7c5edc03a03575]
stable/6.18: [e0cd7b34dc6b5414cac3d4cd376f73d3e9ffbd93]
stable/7.2: [481533b03985177ddc805e0bd12fc07e7adf9040]

CVE-2026-90253: Bluetooth: MGMT: free the mesh send cancel command
when it is cancelled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90253

Introduced by commit b338d91 ("Bluetooth: Implement support for Mesh")
in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c742feda8fcabf741a17bcf668b63c8f606f9c5]
stable/6.1: [b609341ee56967d9a45845ff26f79336d2114b55]
stable/6.12: [88e30d036d777b00aed42bd35000de23ff40910c]
stable/6.18: [05438d338a875a9daa08ca3f6a35b4480cf13de4]
stable/6.6: [416fabca9b7237b76aa9cafcf8c497b8ac00d88c]
stable/7.2: [fa46d428c014e7b72a18634679815670418e67dc]

CVE-2026-90254: Bluetooth: hci_sync: free the advertising instance on
the failure and cancel paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90254

Introduced by commit c249ea9 ("Bluetooth: Move Adv Instance timer to
hci_sync") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [120d8dc042e3d45073bb6e50ee7b058a0b182627]
stable/6.1: [c2019224a766245b7db39d87fdfe84c3fdc879d9]
stable/6.12: [2e3d827cd56865c14f6ca118bbccd7801091fb21]
stable/6.18: [9c3b6c1413bd0b4993642d987616331f84d9b7f5]
stable/6.6: [193182c6467f508a8a61d5db506d796ffed6eee6]
stable/7.2: [bb5ca1cc7744c41c59002bd6523714a685ae6595]

CVE-2026-90255: Bluetooth: hci_conn: fix the SCO setup context lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90255

Introduced by commit e07a06b ("Bluetooth: Convert SCO
configure_datapath to hci_sync") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [42de40abe25db9211107af8896d0fd741f10648d]
stable/6.1: [37cfec41365c826d5496ef5d00c9e215eee53aa2]
stable/6.12: [a661de0ee29d0915c5e924edf91d2be2b4d35bae]
stable/6.18: [c1fe3c74a89a7749cba3caa0dd91236049c66116]
stable/6.6: [9a2ba69cebe3fc5a3d4fa8eaaad3c42862723c27]
stable/7.2: [4d7b1c834d2775b73c65e4888e01f5af8b477fe9]

CVE-2026-90256: Bluetooth: L2CAP: use proto_lock for l2cap_data to fix
l2cap_disconn_ind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90256

Introduced by commit ab4eedb ("Bluetooth: L2CAP: Fix corrupted list in
hci_chan_del") in v6.14-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [2b66c83ff1751d6bd3201b3017206262ab46dc05]
stable/7.2: [b495a3a9b33bc4e4613e685bf5c96c136caa22d8]

CVE-2026-90257: Bluetooth: virtio_bt: avoid OOB read of build info string

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90257

Introduced by commit afd2daa ("Bluetooth: Add support for virtio
transport driver") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [502adc06ba76dee19c292ae4a07d74d202fe734d]
stable/5.15: [fb445b3466a8d1c7a0b0d0676fb475e3ce22d94e]
stable/6.1: [d08c99abf06133a7829d46627e77e3315ca974d2]
stable/6.12: [54e9387eb7546eaa6f600220599d55740956ffc3]
stable/6.18: [be1e3df2c49c91b0a052c6563884e8d39bd768b2]
stable/6.6: [0e388d805233a883a31271676eae6031dfc9e898]
stable/7.2: [84ea9c99874804f5ca13f35bbc186ba93902f30f]

CVE-2026-90258: pinctrl: airoha: add missed IRQ resource helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90258

Introduced by commit 1c8ace2 ("pinctrl: airoha: Add support for EN7581
SoC") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a02fa031b9520e46e98bff17e12b472eba770670]
stable/6.18: [fda7350f257e59eee1bc7537c202e36bd56aea97]
stable/7.2: [2c968c11592b478af4fbcb9453a0e1ac664c2e90]

CVE-2026-90259: btrfs: qgroup: fix a wrong length calculation in
qgroup_free_reserved_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90259

Introduced by commit bc42bda ("btrfs: qgroup: Fix qgroup reserved
space underflow by only freeing reserved ranges") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9102b179512e11644fb0489ae62010a09afa199c]
stable/6.18: [e6edde29990af8064b9d12217ec03db231ccd55d]
stable/7.2: [c4c136555ff90f1e2921cc42da43daac0ef9985e]

CVE-2026-90260: btrfs: zoned: don't clobber the extent buffer when
zeroing it out

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90260

Introduced by commit aa6313e ("btrfs: zoned: don't clear dirty flag of
extent buffer") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db4b9eefc8ee0bcaeee4d5e6a7313905f6a2fe7c]
stable/6.18: [92484ad014f2e2b0e0e7bbc1610951e978cf557c]
stable/7.2: [98e3747587f9f87f010d8d7e55786216249a94af]

CVE-2026-90261: btrfs: zoned: flush active metadata block group at
btree_writepages() start

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90261

Introduced by commit 13bb483 ("btrfs: zoned: activate metadata block
group on write time") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecc05eda9a346848ae01a6c8bfa3f0bec133bd8b]
stable/7.2: [e2de2989adb3e58c2320e57c255f52e065667b5e]

CVE-2026-90262: btrfs: retry verity reads for not-uptodate Merkle folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90262

Introduced by commit 06ed093 ("btrfs: convert
btrfs_read_merkle_tree_page() to use a folio") in v6.6-rc3.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cc569696dac51fc62bb39b3b8f530582b916d29]
stable/6.12: [c1fa005cdf3b7ff14cdfd7d512830088a3fc256b]
stable/6.18: [12b6d1a1715cbced2e445ca353f9c9987b8636e2]
stable/6.6: [90e9eae1b5907fa36620ffb7f4f1a4afa9333427]
stable/7.2: [81241f734f0f662378f5ffc53882b012923e6fe5]

CVE-2026-90263: btrfs: check if root is readonly when setting posix acl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90263

Introduced by commit 353c2ea ("btrfs: remove redundant readonly root
check in btrfs_setxattr_trans") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01c2f41fc441f75b3f9326443372faceb1cb6638]
stable/7.2: [d5602f96ff1e266f069b4d0d94f441050e057e06]

CVE-2026-90264: btrfs: always wait for ordered extents to avoid OE races

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90264

Introduced by commit ff66fe6 ("btrfs: fix incorrect buffered IO
fallback for append direct writes") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [ec78575dde998c21be7e0cb2503b5620f34b6255]
stable/6.18: [58ce50b1802a446d3b26df1b9c58be1ab8913d0e]
stable/7.2: [aaac9b352f7f53f5d2f7e58e612d67d2a2bf7094]

CVE-2026-90265: btrfs: defrag: fix deadlock between defrag and
delalloc space reservation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90265

Introduced by commit 22b398e ("btrfs: defrag: introduce helper to
defrag a contiguous prepared range") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba02eab28041f9a4bbe9fc90c7249644fef6de0f]
stable/6.18: [a9701dd06e82c345fe70debdf8835b7eb5000c59]
stable/7.2: [ac916391e1c70801649f7d6f85014f687983bc33]

CVE-2026-90266: btrfs: zoned: don't force read-only on transient
-EAGAIN from reloc merge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90266

Introduced by commit 7bcb04d ("btrfs: zoned: cap delayed refs metadata
reservation to avoid overcommit") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e549093c11a2fff8430df3dfbdb45eb9811a69a5]
stable/7.2: [8249dfe46337d599e2087b772a2e32ef9f77282b]

CVE-2026-90267: scsi: sd: Fix special_vec mempool leak when
scsi_alloc_sgtables() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90267

Introduced by commit 81d926e ("sd: split sd_setup_discard_cmnd") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb31844d88b77138b67aa20c3600203baff40140]
stable/7.2: [5d7d1b8b525e5eff33a01d07dfcf7bdd3b6d790d]

CVE-2026-90268: scsi: sd: Fix error handling in sd_probe() after large
pool creation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90268

Introduced by commit 7179e62 ("scsi: sd: Enable sector size >
PAGE_SIZE in SCSI sd driver") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3cc6ea1a745e7f5d326f919a428b244fa119d8f]
stable/7.2: [748a14a0d41cfe3017251c11b314f85045414942]

CVE-2026-90269: bpf: Reject load-acquire from pointers requiring fault
protection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90269

Introduced by commit 8804423 ("bpf: Introduce load-acquire and
store-release instructions") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7db0a00445f1a40bacfe9b747405c11cb5f10fc9]
stable/6.18: [c4c8de3bf48d3756ab0f910fe5cc4937d70efdcd]
stable/7.2: [5f8ade6e9b7931fc9697394f1b2c4ae833f5ac18]

CVE-2026-90270: arm_mpam: Disable driver unbind to avoid UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90270

Introduced by commit f04046f ("arm_mpam: Add probe/remove for mpam msc
driver and kbuild boiler plate") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb1a0f582d519c0461b0940116e2b52c5ba31459]
stable/7.2: [7d199b6a0651abad3ca6d0877dbedbe8fe6ea9e2]

CVE-2026-90271: arm_mpam: Fix a NULL pointer dereference on unbinding
after an error interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90271

Introduced by commit f04046f ("arm_mpam: Add probe/remove for mpam msc
driver and kbuild boiler plate") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fc996c39689bb15aa80e5366809434f7258fb703]
stable/7.2: [a29044c9c83513c7463de2adb84c169685562ad2]

CVE-2026-90272: perf: arm_pmuv3: Zero initialize hw_id branch stack field

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90272

Introduced by commit 58074a0 ("perf: arm_pmuv3: Add support for the
Branch Record Buffer Extension (BRBE)") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c3b63386c27bed8d59a4b4c283d02860420eb0a]
stable/6.18: [57b72442c1672963fd51ab441ca1b71f6dc79b66]
stable/7.2: [988e11b69ef9d4034e19c64407030fa948580c3d]

CVE-2026-90273: coresight: etm4x: missing
cscfg_csdev_disable_active_config() in perf enable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90273

Introduced by commit 810ac40 ("coresight: etm4x: Add complex
configuration handlers to etmv4") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a47f0be6557b4a851addd430383a4dc7ee08752]
stable/7.2: [7e4f2702bbadbde887a5d8897297720a7f037ee5]

CVE-2026-90274: coresight: etm4x: fix underflow for usage of (nrseqstate - 1)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90274

Introduced by commit 2e1cdfe ("coresight-etm4x: Adding CoreSight ETM4x
driver") in v4.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1674d9bff8073bdee5dbc200f56fc3caa28d0566]
stable/5.15: [8d669db59f7283b838e029af29da12e505265fae]
stable/6.1: [4091f2d5b26d117c992ffcce1a5df425a0daedcd]
stable/6.12: [4f9a0f548413bf864f609c9f4bc56e3f1b3577d4]
stable/6.18: [1ade9a335c69fc735cb7b3f222ed35ab135540fb]
stable/6.6: [be7b2de5b9a96ae68ffa3528e0a40d63e0fd8148]
stable/7.2: [5ac900f73ce1d4d8308f40752b51bc8a02b244d2]

CVE-2026-90275: md/raid1: don't set array_frozen in raid1_takeover()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90275

Introduced by commit b39f35e ("md: don't quiesce in mddev_suspend()")
in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc386aa0ac0a3ec06c9a3ea9b064b073fb72a916]
stable/6.12: [c57ec2749ee03cace564eec7bb37c89dc3d8d47b]
stable/6.18: [f9cdb5bb8efbf401e84d850828271af87e6be2dc]
stable/6.6: [668d99ba47210ab6ceb18f1cf022c0accca7e3bb]
stable/7.2: [b6ec4bf1ec4446c0213c08ea493e48e6b83cd1af]

CVE-2026-90276: md/md-llbitmap: stop daemon timer rearm on destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90276

Introduced by commit 5ab829f ("md/md-llbitmap: introduce new lockless
bitmap") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5553d64e01d9a995be6c3de38501c6dd4ceede3b]
stable/6.18: [c55aa6c17f019b6296952d336939891efa084c06]
stable/7.2: [bb7f92d58fca9a9f06f3f51a82481c5f0bbbd46c]

CVE-2026-90277: md/md-llbitmap: prevent create failure bitmap UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90277

Introduced by commit 5ab829f ("md/md-llbitmap: introduce new lockless
bitmap") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2116c2f0a0e547615886900e2ed8c529c016499b]
stable/6.18: [930cc4f1af5a1afcd545a6ba00e38921ff8401e0]
stable/7.2: [2f0722435ce3a844dbb66b9bb0a18229dcc8739c]

CVE-2026-90278: md: wait for behind writes before destroying bitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90278

Introduced by commit 5ab829f ("md/md-llbitmap: introduce new lockless
bitmap") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a79365b2278f16e163e4024086105693b421601]
stable/6.18: [73881ff7a75913f919a1ce9d9571bfaab8e8588d]
stable/7.2: [4224dccd325a9380e8edfb66aad8bb5771c94222]

CVE-2026-90279: md/raid5: round bitmap stripes with sector division

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90279

Introduced by commit 9c89f60 ("md/raid5: implement
pers->bitmap_sector()") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [17ea021ae74987d6064c8195c4922fa025753892]
stable/6.12: [cab7d949b18b2f1cd625689dc16c5f81236bac93]
stable/6.18: [02c10581866d08822c6348e299881485fc546185]
stable/6.6: [9d7490007707f90691911385365bd1d691d99225]
stable/7.2: [ccbdc483eb041eef809e9ff223d1ad63518a2c52]

CVE-2026-90280: phy: qcom: qmp-usb: Fix possible NULL-deref on early
runtime suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90280

Introduced by commit e464a31 ("phy: qcom-qmp-usb: split off the legacy
USB+dp_com support") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [142c5593379273264474f31d5956b1a0065cd576]
stable/6.12: [f4e39ab1b2009a89c60e4cb9dbefb8140d405eff]
stable/6.18: [5547fd950d6bf72de861b6934341e7bb0888640c]
stable/6.6: [9b28287c5dea7650e6dd317591b9e82b6e145365]
stable/7.2: [03455404fb6cbfd65842695df26739853fc1516b]

CVE-2026-90281: phy: qcom: snps-femto-v2: Fix possible NULL-deref on
early runtime suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90281

Introduced by commit 0d75f50 ("phy: qcom-snps: Add runtime suspend and
resume handlers") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c271a6926ea7d3c9566b033d63fd4e8c488dc860]
stable/5.10: [0c5c08c94dd64c05679970d4eed8b06d36a889a8]
stable/5.15: [1027b1d4e29756dfbf74ef8743456a1efa3679f0]
stable/6.1: [34293f5a8982a06c40af69c8c7c856b5837ac652]
stable/6.12: [82cb1aedf4bdb279cf8853fe8f39bec4e6cffa0a]
stable/6.18: [61749681e4a3629ec20b04ba2443b91016af3d2f]
stable/6.6: [3ddf41938fee3d148a170c31e76b0515a522ef7e]
stable/7.2: [b85bbec72fa813b60e093c6bb36ae232b9b0eb5e]

CVE-2026-90282: phy: qcom: qmp-usb-legacy: Fix possible NULL-deref on
early runtime suspend

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90282

Introduced by commit e464a31 ("phy: qcom-qmp-usb: split off the legacy
USB+dp_com support") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e3687f7e18fe84372e86875709d56c37e7525a8]
stable/6.12: [29449ce1f5958e36df80318878016e3ecac26b40]
stable/6.18: [52ad86ea5f98d29a7a29d9ba12e24276c6e30acd]
stable/6.6: [602059c5128a78857ca92bd22791ab640185e381]
stable/7.2: [0f9789d1b63e7d9f868ac9c29564339a4c03ceb5]

CVE-2026-90283: hugetlbfs: release subpool on fill_super failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90283

Introduced by commit 7ca02d0 ("hugetlbfs: accept subpool min_size
mount option and setup accordingly") in v4.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [308ab73e97c87bd0e142b11758faab7f88d82854]
stable/5.10: [f2d6cea221d777fab3ba18f805ba4c17c90e0b8b]
stable/5.15: [91c4f3a87862fd86594d5945512decbfa0b1d13d]
stable/6.1: [04f0354a4abf6793aa5b3f32e2b019ab206f344d]
stable/6.12: [1d8be4ee81e73fcc52e58f47842d9a2277cfeaaa]
stable/6.18: [dfe848cadfde4179a0691da34f4bed36ff7185b5]
stable/6.6: [5b7fc7a1ce2a5f2cd8ed80a883157c7108074e0b]
stable/7.2: [dc2bd517ac0bce4ec7498644bd16b6db502df8e2]

CVE-2026-90284: firmware_loader: do not queue completed sysfs fallback requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90284

Introduced by commit 75d95e2 ("firmware_loader: fix use-after-free in
firmware_fallback_sysfs") in v5.14-rc5.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [b48373c901951fad1a26bd7c33ad91172b3945b5]
stable/5.10: [c8b97c5130f27b64fa2cfe1aa4bebb13f724c6c7]
stable/5.15: [93a2385730540105df8524447dcc11309ad280f9]
stable/6.1: [ea33fac0df7fe7b49a4b27acb83e227b82317d1d]
stable/6.12: [85aeb8fc61839098ae0942ccba86e669c08e75d4]
stable/6.18: [6eaa632d0ed7bbb84f9cb670e5ec4e2cecf4cc7b]
stable/6.6: [5a250bff75a446374c05622973b18b4ab662b504]
stable/7.2: [fb4824880b0dba0e7b3a497c46c642f979630392]

CVE-2026-90285: scsi: qla2xxx: Remove redundant VPD flash read in
sysfs read path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90285

Introduced by commit 5fa8774 ("scsi: qla2xxx: Add 28xx flash
primary/secondary status/image mechanism") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cbc49d5c4cd20c18041e86958103045216d2190]
stable/5.10: [ea79c01ef23c2ec3ace8a98ada517d56763814c2]
stable/5.15: [beaf45d9a10e7c1de86dcd1cbc8dc17f930444f7]
stable/6.1: [abe224e7077ae5d47f1208430ede4d99ae310627]
stable/6.12: [95e1ad3f19dfec09eb4f4273cf7079fd9b35cee6]
stable/6.18: [067504c00fe175864652764308922d99e199828f]
stable/6.6: [9b6325fc58ab877ecb97fc5642a39e071c343315]
stable/7.2: [0e4b5f8cad67eabf98da3f90b6443dcea5783ff3]

CVE-2026-90286: drm/amdgpu/gfx6: Use PFP on the compute queues too

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90286

Introduced by commit 2cd46ad ("drm/amdgpu: add graphic pipeline
implementation for si v8") in v4.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60f20946cd318518ddc2c0da12103c666b2b9564]
stable/5.10: [f37211b9c01433f0bbb4709d25df7a0257cf915b]
stable/5.15: [2aa869c6b23e0b1b7f39f762618852811d75deb9]
stable/6.1: [fbabc39b4f0fc771b00525ffd448be6a84355048]
stable/6.12: [e1d3018e3621c90cec070b6915836ae129656663]
stable/6.18: [8d752f1bb73fabe5a425acbf5c767c0fe68bf3c5]
stable/6.6: [b5d1d3e4519dc8f1b55d6b236848bed67b11a2e8]
stable/7.2: [e399e9d7e291ccbeba6560fb8278c8d2aa744521]

CVE-2026-90287: phy: sunplus: fix error handling in sp_uphy_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90287

Introduced by commit 99d9ccd ("phy: usb: Add USB2.0 phy driver for
Sunplus SP7021") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b2683bc4cc18c581b7cd24f227cbe61abca7f4d]
stable/6.1: [d8856bfe6d00c21c4c0ba689cb6c9e30ceaccb8f]
stable/6.12: [3a7dcbe3112aef3505beae4f982331a00326217c]
stable/6.18: [1489b694b1f3265cd5363100642a22190033f4b0]
stable/6.6: [1fce81a40e3b3ec6b4f52e278d5c2bde79b25939]
stable/7.2: [5acdc4d5b58bd0730824938db79b5f08ef996d9c]

CVE-2026-90288: phy: renesas: rcar-gen2: Fix double of_node_put on phy
creation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90288

Introduced by commit b64b327 ("phy: renesas: rcar-gen2: Simplify with
scoped for each OF child loop") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b780b8929c759cfa7a892d58625a5ad46cb1cbd2]
stable/7.2: [5374f3d53376d35085e0727c8c1b945bf7123996]

CVE-2026-90289: drm/amd/display: Resize MST HDCP per-connector arrays to 32

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90289

Introduced by commit 82986fd ("drm/amd/display: save restore hdcp
state when display is unplugged from mst hub") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [261e0fe4e2c99f687114b64b10b98db964b475f4]
stable/7.2: [0fa116a17b69a28712cdf209318e345b676d7f6c]

CVE-2026-90290: arm64: hibernate: Restore DAIF state on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90290

Introduced by commit ee11f33 ("arm64: mte: Save tags when
hibernating") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [541549827889d0380fd73f8aacb5de6ef7a5a1ac]
stable/5.10: [f5693dfaf28d66e7e880feafd1778d3715869efc]
stable/5.15: [2c941f383a53e188cd6fe3a129eb9b52b298e683]
stable/6.1: [cb51a05498e755d900900ff4b8503b4da4325996]
stable/6.12: [c8c6835f62a7f9fc68865e85397d13a2dc9210fb]
stable/6.18: [519e7de2c4c7b92ef57d4404b7e564aa9be24143]
stable/6.6: [ad3839fe2114bb092846df79edd8d119e148b8c3]
stable/7.2: [77053624d03359a4e2ec47d7106639ec9a498c2b]

CVE-2026-90291: module/dups: Fix use-after-free in kmod_dup_req
lifetime handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90291

Introduced by commit 8660484 ("module: add debugging auto-load
duplicate module support") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eecb11b543f9f417bcf0dea239ff99c6af65dbd]
stable/6.12: [2c85e0fb528e039aa8ea1e9c2a1f64347f990541]
stable/6.18: [b2709aad7599f6fd957939b60f4a8323c8f08072]
stable/7.2: [cd2396fc9684d2cfd3f3c3f09c79d6d9d725b0ca]

CVE-2026-90292: RDMA/siw: Fix use-after-free in siw_accept()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90292

Introduced by commit 6c52fdc ("rdma/siw: connection management") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9394971825933074032794a5feee5211509c774]
stable/5.10: [d57db36e74cca4763e1c2c0c6eb9f84d19813879]
stable/5.15: [59de5502f32895ffe9c45530327ed997b90fdf06]
stable/6.1: [a89d120615e711ce8fce551fd291c2f387666735]
stable/6.12: [8f286a8094ee32c415f9ecd2c20765beb8a18c79]
stable/6.18: [de603f01d9ccf823e575b013ffd86ebedca9a8c5]
stable/6.6: [b9e7d3d9fdb2bfcfb25d93529fdf766536b37c78]
stable/7.2: [561651d6a15588cee2040755f253faca2463415c]

CVE-2026-90293: IB/isert: post the full-feature receive buffers after
session registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90293

Introduced by commit b8d26b3 ("iser-target: Add iSCSI Extensions for
RDMA (iSER) target driver") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5247dde9daac7e107853b6fea043f7f47be033f7]
stable/5.10: [962edb9a6b0dae09d33a677485a398fc7d55968c]
stable/5.15: [068fe9841d2585b79d479fc7b58251d02d0b066f]
stable/6.1: [d4f8257c3283919ca7e149381d062b9af5f7df7d]
stable/6.12: [9b2c61344992c8c2b883e1eebe416cc488a19390]
stable/6.18: [6c506fee5a5f2c8719c65bcfc5e5d0862b0a1946]
stable/6.6: [9c21a433022219ca899d1b3cd9049991f51a6a2c]
stable/7.2: [ad4492dcaf90a1d1a728ec5eef1a68ce5355027a]

CVE-2026-90294: IB/isert: delay the final Login Response until the
session is registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90294

Introduced by commit b8d26b3 ("iser-target: Add iSCSI Extensions for
RDMA (iSER) target driver") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [464f5afa92d071a226f88424803b0fcf88093ede]
stable/5.10: [e148dbac43308d9e4313070bfc5b355d03134809]
stable/5.15: [a18fb8d540b3e631cb7e50e55f3c462c05b3a114]
stable/6.1: [0d2efc355982064855f24f73f9fbb6c65ca4a5c7]
stable/6.12: [11694889c4bab47047a60690ceb70d7551ed5b2e]
stable/6.18: [a6c19af05c170f267eca1d01c3c72c84ba7860ae]
stable/6.6: [f84e9adf4d9f4c0c79ef4a7d9e0c5c08b1337033]
stable/7.2: [4397ea31e3b0d017c2b9b876b326df0b3eb845bf]

CVE-2026-90295: cpufreq: imx6q: fix out-of-bounds write when probed
more than once

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90295

Introduced by commit b4573d1 ("cpufreq: imx6q: correct VDDSOC/PU
voltage scaling when cpufreq is changed") in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c3afcf27fa4582c1ab912503dc8a4ebb8dc0f82]
stable/5.10: [263a35331169390f7f9ccb51d74e668610199af4]
stable/5.15: [49f2f9b1d0cc76cf221306fc707703205bd27073]
stable/6.1: [c5135bc34ea37e9d19f758e61ac44415afb3891a]
stable/6.12: [b166bb79b7ef36b4f1d6d1f40d1a72b2eb0a56b9]
stable/6.18: [aaa66e60c0e21d19993a95bc3718dc29eb2d3192]
stable/6.6: [55864b26c22cbd4b2e0d36154a8c35931c2e133b]
stable/7.2: [55516986a3d81325c84f2d4ae9cd03116bc63599]

CVE-2026-90296: cpufreq: imx6q: fix devres accumulation across driver rebind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90296

Introduced by commit b4573d1 ("cpufreq: imx6q: correct VDDSOC/PU
voltage scaling when cpufreq is changed") in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22c23c72c3b21fa3ec3db5070dfc0582794e0ef9]
stable/5.10: [493c4d5982f037f288509a1cee352b8b9705fb38]
stable/5.15: [d91f07381e2b70578ff92b83d9422ac31e7b9096]
stable/6.1: [38d2c3c9238b9d499e1829a3b8e80c2f73c73b5c]
stable/6.12: [9e314b3ecd2594958d4f4999313641290ad28ebe]
stable/6.18: [e2d2612e63e294ebcdec7c6f08a1a052b7dfdc59]
stable/6.6: [92e53a5274276a7b1ca815b9aacebea4fb7efe75]
stable/7.2: [0f77d1a0a25056146eea1f8619fa06ce287c91f7]

CVE-2026-90297: drm/sun4i: crtc: Propagate layer initialization error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90297

Introduced by commit dcd2158 ("drm/sun4i: Drop primary layer pointer
from sun4i_drv") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7061ff05ed4a3cf16e83f7e3ad09cbd212508a32]
stable/5.10: [aaf812960fb5ade24be7a1d8fea27a1ffc458c30]
stable/5.15: [e216d6168f25a69e5ae5b981ee73b3a860a46441]
stable/6.1: [2bb3169788f8296c8fc1e0d4fa6f1c6367cd5829]
stable/6.12: [8f32af44d43332c02198752e596df00659bf4354]
stable/6.18: [65bc02fec98e4e1d7d59d86cf2ddf8fd73dacb89]
stable/6.6: [1882112124a642de7571fbf354fa1929decbb3ef]
stable/7.2: [c0d3219ffd4c0d42295e0dc949856067b7818b71]

CVE-2026-90298: drm/sun4i: tcon: Drop TCON TOP device reference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90298

Introduced by commit 0305189 ("drm/sun4i: tcon: Add support for R40
TCON") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8208832a38ff3d2560eb8a77a9d7a2f17d8ebcdc]
stable/5.10: [31b54c92a49a2b40fcd59b0c8cf346b0b3fb288b]
stable/5.15: [3eeb8545d5513defe935ce46a9824512f7a2bbd9]
stable/6.1: [b192f08480d63d3f5e46d35c91d4fccd4e703ca7]
stable/6.12: [e6406726ee7f4deb1b9b32c1ad6a147ffd208bec]
stable/6.18: [1ca06d47ac40bdcb63e4e528499bf531c6c3231b]
stable/6.6: [4fa22218c2351621d470d2d2ae4f6a2ac39ada94]
stable/7.2: [ae08a67bca7817e37c16c1ec51bce7f2ff9aaf2c]

CVE-2026-90299: bpf: Fix sleepable check for tracing/lsm prog

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90299

Introduced by commit 16d9c56 ("bpf: Always allow sleepable programs on
syscalls") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00244bdaa423d93f4571f3f6854378ce3365e524]
stable/7.2: [976f1be72740cfbc351d3841fd21186dda3ea723]

CVE-2026-90300: bpf: Clear buf on error in __bpf_get_task_stack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90300

Introduced by commit 06ab134 ("bpf: Refcount task stack in
bpf_get_task_stack") in v5.12-rc7.
Introduced by commit b992f01 ("bpf: Guard against accessing NULL
pt_regs in bpf_get_task_stack()") in v5.17-rc2.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [f5d242825ca417bb6afe35fde6e8880f97ca43fb]
stable/7.2: [f523359c4789bb0396d2d642464a6e2fd4f2299d]

CVE-2026-90301: ocfs2: o2hb: quiesce negotiate handlers and timeout work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90301

Introduced by commit 34069b8 ("ocfs2: o2hb: add NEGO_TIMEOUT message")
in v4.7-rc1.
Introduced by commit e76f823 ("ocfs2: o2hb: add NEGOTIATE_APPROVE
message") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [011291b70ba4832e136b7b581825b2bc0f525bf6]
stable/7.2: [b5a2907bdeced0949bcddc84b95ba7d4cb93841b]

CVE-2026-90302: ocfs2: synchronize heartbeat callbacks with o2net teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90302

Introduced by commit 9821148 ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e326f3bf16506873777444608e8b715aab74a7a]
stable/5.10: [7601db4c9d3bd9ab2482a863cb05204154d51ae8]
stable/5.15: [fb61882e184ee5ca745806bc5b2a8483fa129bca]
stable/6.1: [a03078a9a2a1c5e4a62f65d389c1f75f9898e21d]
stable/6.12: [8f96b78314cff0778a3466e49e5edbc1e459c95c]
stable/6.18: [aee687a2fb36974dc37e4e0f5b03802067c6c4ec]
stable/6.6: [cbb4efc2f99d6a8dba09c96b10acad82da982cf9]
stable/7.2: [073f51e39bed354452a057d38a4cc3952727c304]

CVE-2026-90303: ARM: 9485/1: mm: acquire mmap write lock around
show_pte() for user faults

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90303

Introduced by commit 6d021b7 ("ARM: dump pgd, pmd and pte states on
unhandled data abort faults") in v4.0-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1039bffd6ae9c75b42b7d148d6c1106134107b66]
stable/5.10: [ab14f07952adfe735d86a53518f8cd576dfd5892]
stable/5.15: [07e4d5380f2a844ab7a1b440dde350caf561cbb0]
stable/6.1: [2a14d7797a49a47bccd1a9327fd69da838dcb0dd]
stable/6.12: [59bbf86d0ff9373bfa033ca123c1e924f09f1eba]
stable/6.18: [c71f9a56520b419e55d173052629f2324deb5549]
stable/6.6: [63e3c958a602d0896a101a897c2361878c266ca7]
stable/7.2: [720408d98d9fb3c91a12090436734c8c61f04545]

CVE-2026-90304: ARM: 9484/1: enable interrupts when unhandled user
faults are triggered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90304

Introduced by commit c6e61c0 ("ARM: 9463/1: Allow to enable RT") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e79ca91165d4fd18549c536abdb86101e889052f]
stable/6.12: [ab88cca39edeb0636daa50b6b642c3ce74806f72]
stable/6.18: [8a98ed4f7b7069d530b9e3e26230919b7d0cbf14]
stable/7.2: [8d7cbc6df9632d334b21c4be66ccdde76a08fb13]

CVE-2026-90305: ARM: 9483/1: select HAVE_POSIX_CPU_TIMERS_TASK_WORK

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90305

Introduced by commit c6e61c0 ("ARM: 9463/1: Allow to enable RT") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a58a41100ea377e978d99600ec24a9bd0273662]
stable/7.2: [8de56782d6e5ba7a9f8c820342dccde65502f93f]

CVE-2026-90306: ARM: 9481/2: breakpoint: CFI breakpoints only on demand

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90306

Introduced by commit c3f8998 ("ARM: 9391/2: hw_breakpoint: Handle CFI
breakpoints") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ed9bff906cf8036531d1559f10e82733a52b41f]
stable/6.12: [22107402c2669b0163d43cc68901a2c4a59fa43a]
stable/6.18: [314f1a6762b5d51b37784ed7dc701d4c3d893703]
stable/7.2: [da64b150e4b7bee615b33ab21f3137c31ec36922]

CVE-2026-90307: RDMA/srp: fix heap information leak on a truncated SRP_CRED_REQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90307

Introduced by commit bb12588 ("IB/srp: Implement SRP_CRED_REQ and
SRP_AER_REQ") in v2.6.37-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [961ac0f0c5e414abdd6b33fae84b311d9fde0bd0]
stable/5.10: [3f7fdf561f1ec3b523c39708df00bd808671668d]
stable/5.15: [138eb2f0ef02adfe6ad126afad5b54c56b5046ee]
stable/6.1: [3787f4c3e0d813d6c56be9f6dfaf66f8551fb0a7]
stable/6.12: [001adf2fe87d1ab677c014a97467bbea5153ae5f]
stable/6.18: [dc2272c00d7c00ee2a69b57f7ca9caaefcbdb8cd]
stable/6.6: [0e7ba617514902501514d577647d866e670dad90]
stable/7.2: [fa1b33fdab3e79dce83721ead3220200a2dbec22]

CVE-2026-90308: RDMA/erdma: Hold QP references for AE and CM processing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90308

Introduced by commit 1550557 ("RDMA/erdma: Add verbs implementation")
in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a52eeff32024f190b3bdc99088c7becccd4fa60b]
stable/6.12: [6e32f84b63c054e09392153125d7202abab2d14b]
stable/6.18: [ec987c0654651036dad6a42f7fa2a6d7c16a3687]
stable/7.2: [c92686867638cda954fdb2bdbac8a75e3aa6eaae]

CVE-2026-90309: RDMA/erdma: Hold CQ references when processing EQ events

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90309

Introduced by commit 1550557 ("RDMA/erdma: Add verbs implementation")
in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98df2aee1459ee1c62c70cbe9b370d2a532aea36]
stable/6.1: [610ef81797bb4f709e8675c1d8d093bb9ccdcbd8]
stable/6.12: [05b8ca493dd02319bca93c640b259c2ba51ef321]
stable/6.18: [1fc9c1933959d2776a1ce7bf424251b8b5b586cd]
stable/6.6: [c0a83f29a24c7e7f8516630848ef6db4c174deed]
stable/7.2: [4545f355654d044d35a31cd01cc46f491a8a7c36]

CVE-2026-90310: [REJECTED]: xen/xenbus: check otherend_id only after
it has been initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90310

This CVE was rejected. Introduced by commit e2dcf90 "xen/xenbus:
better handle backend crash" in v7.0-rc3.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c76cbf348c7df077f93fa99a1225a527ce64cfa1]
stable/7.2: [36fb592af353c55832e2cafe3fcfc3291be05f19]

CVE-2026-90311: thermal: hwmon: Remove hwmon class device along with its parent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90311

Introduced by commit f6b6b52 ("thermal_hwmon: Pass the originating
device down to hwmon_device_register_with_info") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b57e24d34b2dfc43c81942bb359d6315bf302fb]
stable/7.2: [4fa8915f40f744c6db2a3c25b2ae7d2dd64c77b4]

CVE-2026-90312: bpf: Check load-acquire src ptr type before the load

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90312

Introduced by commit c03bb2f ("bpf: Fix out-of-bounds read in
check_atomic_load/store()") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b87803391baa7e0bef60549d8841f12e549ad057]
stable/6.18: [6ee7b00888498cf387dd30729e18a05328b94709]
stable/7.2: [422a416041172af1ac610736d5f556d22b31b115]

CVE-2026-90313: bpf, cgroup: Fix invalid storage access after
__cgroup_bpf_attach failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90313

Introduced by commit 7d9c342 ("bpf: Make cgroup storages shared
between programs on the same cgroup") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6655c409707ec8ce9ce0850ffe4fe02331fd4d9c]
stable/6.12: [aaca16e042527f7efe48b50799bc662f1a191ce1]
stable/6.18: [86ead176301109b78e1d14c0e9d0d9ff9723c769]
stable/6.6: [e26db0d636e4c24a6b16683ea95cf5077c64d74b]
stable/7.2: [2c2218560b6e28a63ff7834ba26d09ff8efdee39]

CVE-2026-90314: remoteproc: fix OOB read via signed offset in
rsc_table_for_each_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90314

Introduced by commit fd2c15e ("remoteproc: resource table overhaul")
in v3.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bb840ea69347aff7bde5a208e7b5b180669a7656]
stable/5.10: [0d385be8f199b349f325cf90584b47b6a044ea79]
stable/5.15: [cc85e0d3d3333fd5fd2d50c9a4578d209d7f2564]
stable/6.1: [6a01ad25aa4f3a02153cf1d112cb9b65865cd5d8]
stable/6.12: [bc4940793aaa16a9cf90063b11d6926f8014a1b7]
stable/6.18: [6fd220604f06c746760183df74b07384c3fdd660]
stable/6.6: [c82241a9454b2d30d53b50884f94b7972ba44a5e]
stable/7.2: [6282d47b24b0c98d08d02807d676a7f67b4c052e]

CVE-2026-90315: PCI/sysfs: Add lockdown checks to legacy I/O and memory handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90315

Introduced by commit eb627e1 ("PCI: Lock down BAR access when the
kernel is locked down") in v5.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [747b9bbbbdfdee51aee2456388f9b94b5086de4d]
stable/7.2: [cd07aef510ac6a2873e01f9ddddc5492490b0067]

CVE-2026-90316: drm/omap: dsi: Do not copy isr table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90316

Introduced by commit 4ae2ddd ("OMAP: DSS2: DSI: Add ISR support") in
v2.6.39-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97c03b32b28a9f7f13f768f2b06e1eaafe850e66]
stable/5.15: [b3cbd1451c240446ce170f514244e1cb65ec0de4]
stable/6.1: [f6733460b6d483dea7bfb5cfceb11cbff31a60b7]
stable/6.12: [2c27a84ba8d1bfed046d0067161d92001605accc]
stable/6.18: [9063b30faae8ccaacf003735560df3956dbb592f]
stable/6.6: [542a6a3ec77cd29f953987f7263f32fb8acb097e]
stable/7.2: [30810bdf273b4c93f8731b96a7204f33e052180d]

CVE-2026-90317: bpf: Invalidate RCU pointers after final spin unlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90317

Introduced by commit 5861d1e ("bpf: Allow bpf_spin_{lock,unlock} in
sleepable progs") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [180c7000712db77063b3a26f4c97e7dd9038f449]
stable/7.2: [7ae71629357d0a6d0bdadb929c7b296d5b7e61c2]

CVE-2026-90318: fat: release buffer head after rebuilding parent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90318

Introduced by commit f1e6fb0 ("fat (exportfs): rebuild directory-inode
if fat_dget()") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83e98dbf19ab64e8528e101e20f8d50e1aaa68a8]
stable/5.10: [5e44b6944e11fd6647f028219ad0be4e85e9acee]
stable/5.15: [d2a86329152c69a6200c15b2bf618755f8563826]
stable/6.1: [0f18d712ba9c980e05b7e33a27cde4fe3ed2d393]
stable/6.12: [c6a67aa438179cad40f8ae45469e304338d65c0a]
stable/6.18: [571ea4263d69df1b48578e4314a828ecd0604755]
stable/6.6: [e38587d98d1ceac608420052c0cdd901d25878f3]
stable/7.2: [7565e44507634514e3e1899d3acad3de43f7a2c1]

CVE-2026-90319: rapidio: clear mport->net when rio_add_net() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90319

Introduced by commit e842f9a ("rapidio: add check for rio_add_net() in
rio_scan_alloc_net()") in v6.14-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [b74030fbf187b43c1f85b66a7082e9946511cb5d]
stable/5.10: [24f60ebabeb8757cec8ec2f97660d521bc9147ec]
stable/5.15: [6a760a53e73064735cdfa9e51c664983a89baf96]
stable/6.1: [3f00999e44d9984036a029dbad9d2afe94a674d0]
stable/6.12: [75f0bc167b96bbbef8182b88308c732af82c8d83]
stable/6.18: [44a37264b26911e13d0a4f5630751c4157ed0354]
stable/6.6: [332591a245de978349a7558f8b20469951bb77cc]
stable/7.2: [530a9d5ef831a0049dad9a6b2b92d02301352c38]

CVE-2026-90320: ocfs2: validate external xattr entries when reading metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90320

Introduced by commit cf1d6c7 ("ocfs2: Add extended attribute support")
in v2.6.28-rc1.
Introduced by commit 0c044f0 ("ocfs2: Add xattr bucket iteration for
large numbers of EAs") in v2.6.28-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cf82b46d5e43be0dfbaac7fa1073cec2fc1f5e6]
stable/7.2: [9f4129b6905b7d638bbc9eb8013c3989cbe30b7e]

CVE-2026-90321: ocfs2: validate inline xattrs during inode block validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90321

Introduced by commit cf1d6c7 ("ocfs2: Add extended attribute support")
in v2.6.28-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8914a3330b72378136c2c02d6328a826f6abdad7]
stable/7.2: [3fd45b24879fa4885b66a582a6e47eda67f11310]

CVE-2026-90322: ocfs2/cluster: keep heartbeat local node stable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90322

Introduced by commit a7f6a5f ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [688bc88e2046dd6ce81ce18079b5254cb8dadc0e]
stable/6.12: [8e5cb90f212fda9f6cd29915a1ed74353108ceb3]
stable/6.18: [8abb2b7c60d2b2c0f40606048c873096c03874d2]
stable/7.2: [70d7bb7a0be033e5ebe8a2c48974692b1318891c]

CVE-2026-90323: ublk: validate auto buf reg before taking uring_cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90323

Introduced by commit 52460dd ("ublk: move auto buffer register
handling into one dedicated helper") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca5a01eee34c7cbe0f531a613b0292a3ad1a419b]
stable/7.2: [653d22269a8b83b491f7f186a5d7872f14e6ddca]

CVE-2026-90324: ublk: check import_ubuf() return value

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90324

Introduced by commit 981f95a ("ublk: cleanup ublk_copy_user_pages") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3831568792af75b6523fa93bb91560e29189cf55]
stable/6.18: [0121c84adb6a4cd6f7560b5895bd88f9899bbc1f]
stable/7.2: [5ac6019cb78e98c9608fda72726b36ddf8474dd7]

CVE-2026-90325: blk-cgroup: skip dying blkg in blkcg_activate_policy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90325

Introduced by commit f1c006f ("blk-cgroup: synchronize pd_free_fn()
from blkg_free_workfn() and blkcg_deactivate_policy()") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [5e9220389920f33b6a804d50c548cd0cd1b04634]
stable/6.1: [0489f95b79cfa991f766c845be4dad38981720cc]
stable/6.12: [7337d012ca3fc3a6a2d1c8e2a19c6d97c38b410d]
stable/6.18: [3d8c3da95c75a4d312e272fc7b4076dd3ba9115c]
stable/6.6: [1a267295b1ea6a6477963f3fda84adfecd48fcad]
stable/7.2: [d8c872901e6459339374e9eea80aa919176c2ccd]

CVE-2026-90326: blk-cgroup: fix race between policy activation and
blkg destruction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90326

Introduced by commit f1c006f ("blk-cgroup: synchronize pd_free_fn()
from blkg_free_workfn() and blkcg_deactivate_policy()") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [5313d4d41739b0cb63000747c97bb1217ac45f3e]
stable/6.1: [b5dae1cd0d8368b4338430ff93403df67f0b8bcc]
stable/6.18: [ac34e655dffa74349d885a43d098115336f53842]
stable/7.2: [2cf9f50a38c1839e549a08e22aa35e8d69e2c8fd]

CVE-2026-90327: phonet: pep: do not write beyond optlen in getsockopt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90327

Introduced by commit 02a4761 ("Phonet: implement GPRS virtual
interface over PEP socket") in v2.6.28-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77e5eb0e192aec6710c03ca8144582fd2af36ca4]
stable/5.10: [6054fed6bad08b6d03973e8ffca7f0c9394d1c30]
stable/5.15: [eac733a0b6fe0a52d91f9f623425735ed50ac6c2]
stable/6.1: [95e0ed2439dd1792eb454c68ae8d10f30ffe3bff]
stable/6.12: [1bf499e438da80455e258049bce60ffb3a53f3fa]
stable/6.18: [c4487e4d5309de587479ecc2f5173b49586f46f4]
stable/6.6: [056eea1a2068ad2fb7c3093c5f1095268f87d0c7]
stable/7.2: [f97022fefe6eb06ee18549d603420440f2959802]

CVE-2026-90328: HID: steam: Reject short reads

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90328

Introduced by commit c164d6a ("HID: add driver for Valve Steam
Controller") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33ff7b49c38b39b1f3d27db508ac0720fb25c08a]
stable/6.18: [f694ea0ead544080949e409a7c6885ee1fc77a98]
stable/7.2: [93c5cc35bcd9f62db589a21945b49691dccdd99d]

CVE-2026-90329: HID: synchronize input before cleaning up a failed probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90329

Introduced by commit c849a61 ("HID: Separate struct hid_device's
driver_lock into two locks.") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [207853d46f7ef2e28042344a1468da8754c3ddbf]
stable/5.10: [3ffb088a2ed34ca982cfc2c81d107ce370aa45f1]
stable/5.15: [2c35cdeb13a0c52429501e66f368fa59cad235f6]
stable/6.1: [98201b46f7e33fe11af6f024fecb40fb56634225]
stable/6.12: [edd490b8ad85c052eaf10dcc9f390ea54f1e1b39]
stable/6.18: [01eeb601a1626e683fb7b77c63f442b06fb87093]
stable/6.6: [9a3da56aae28e1ad3a3e591f72a537742053ecd2]
stable/7.2: [b85d1000eb8842768970f2fd0a8fd362472d02d5]

CVE-2026-90330: HID: logitech-hidpp: Fix FF device cleanup on init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90330

Introduced by commit ff21a63 ("HID: logitech-hidpp: Force feedback
support for the Logitech G920") in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd5be4d9ce2dfc4d4a4527ef7d31d21a78e3cdac]
stable/7.2: [13378c9ac0a1bcdf49ba158e4199594aafb589cd]

CVE-2026-90331: HID: asus: refactor the two workqueues and init sequence

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90331

Introduced by commit f631011 ("HID: hid-asus: Implement fn lock for
Asus ProArt P16") in v7.0-rc1.
Introduced by commit 1489a34 ("HID: asus: Implement Fn+F5 fan control
key handler") in v7.0-rc1.
Introduced by commit b34b594 ("HID: asus: listen to the asus-wmi
brightness device instead of creating one") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47669bec44fe12fe2c7adf2b299e980d7935a2ce]
stable/7.2: [744b3f930c1173ad57f49b614fc875d8d2715396]


CVE-2026-90332: PCI: dwc: ep: Flush cached MSI write before unmapping the iATU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90332

Introduced by commit 468711a ("PCI: dwc: ep: Refresh MSI Message
Address cache on change") in v7.0-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b01d725d8b42450b86a857bab3c46856c740166]
stable/7.2: [914704c7b318bdaa42dce4e55f6c492190fee3b5]

CVE-2026-90333: dm-integrity: replace forgeable discard filler with a
keyed sector marker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90333

Introduced by commit 84597a4 ("dm integrity: add optional discard
support") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68c5c42567bc462139128968ebbfadd0aefff519]
stable/6.18: [5c58ea19a909ef6bed4f0f824e9cd7e30d7e4775]
stable/7.2: [6228722c27304e4682cddc1fede03898f87e4414]

CVE-2026-90334: tty: clear cdev pointer after cdev_add() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90334

Introduced by commit c1a752b ("tty: don't leak cdev in
tty_cdev_add()") in v4.3-rc5.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6645856f0df3aeecd45519cb611415b4b89c2223]
stable/5.10: [fb1de260033c215dba438973d82b48562bdc86bb]
stable/5.15: [e9e64dd02fd68776afda00777591eca0c3984285]
stable/6.1: [33a44333a9dfda044b0e233399b12ead7f8a90ae]
stable/6.12: [a83fcddf3c75d004f12aa13555bb73da19fb75a9]
stable/6.18: [4f6bd79bb7e55095f09bec9b4eb6c09df1306116]
stable/6.6: [d331c63570af61ef7aaf516b64a8d6f47518a3a4]
stable/7.2: [5c5a795bf6248fe96f96dd9fd79d66bbb4a92077]

CVE-2026-90335: tty: skip cdev_del() when no cdev is registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90335

Introduced by commit a3a10ce ("Avoid usb reset crashes by making
tty_io cdevs truly dynamic") in v4.3-rc1.
Introduced by commit da4c279 ("serial: enable serdev support") in v4.12-rc3.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3b5623fd97648f2747444aa8932ae604662df93]
stable/7.2: [3dbf85ef40b6366ba15e882f7536cdc98bea579a]

CVE-2026-90336: serial: core: clear freed pointers on
uart_register_driver() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90336

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Introduced by commit 9e845ab ("serial: fix NULL pointer dereference")
in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61a2fb25551be0375bc16ef2a70c987dfca26183]
stable/7.2: [06b376432974fe5f25f2843a8e8438c6a1cf3d50]

CVE-2026-90337: serial: core: do fallible allocations before the
console can be registered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90337

Introduced by commit 266dcff ("Serial: allow port drivers to have a
default attribute group") in v3.17-rc1.
Introduced by commit f7048b1 ("tty: serial_core: Add name field to
uart_port struct") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a0e4fbce5d9c1bc179a35a2fd9ed142664299e3]
stable/7.2: [c2aec15f78b2e6ccd9b94216a901248511355982]

CVE-2026-90338: serial: amba-pl011: keep console clock enabled for atomic writes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90338

Introduced by commit 2eb2608 ("serial: amba-pl011: Implement nbcon
console") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0e8cfef754645856374e82c8effd54b7d82002b]
stable/6.18: [5b77848423f4a5a362dcc3caedcdc1a75d0758c3]
stable/7.2: [2ad24c1d0b939d814a3020f96a667ac2d0394289]

CVE-2026-90339: powerpc/syscall: Fix syscall skip handling for seccomp
and ptrace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90339

Introduced by commit bee25f9 ("powerpc: Enable GENERIC_ENTRY feature")
in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69cb2be898be6d5826cacd1a628f6945a24480b6]
stable/7.2: [19b54740e2e1102c7d48553d9e0347c1f6af22b0]

CVE-2026-90340: pinctrl: generic: free maps on pinctrl_generic_to_map() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90340

Introduced by commit aaaf31b ("pinctrl: extract
pinctrl_generic_to_map() from
pinctrl_generic_pins_function_dt_node_to_map()") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17007cd700601777d9ee203a13d97e64ece3a10f]
stable/7.2: [09f47abc95ee9e819e7e93cd68c1c23abe11c842]

CVE-2026-90341: firmware: coreboot: Validate table bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90341

Introduced by commit d384d6f ("firmware: google memconsole: Add
coreboot support") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a58a57a1076f8c5dae0327e3710899478c3be901]
stable/5.10: [3cca0d6dd4c2636d2514234233cb02db76621607]
stable/5.15: [f79f621215a0944c4a0e1b3b86b99e433ae8c527]
stable/6.1: [d848fac90c6f0566e7b93066b0b86024f65f395e]
stable/6.12: [fd93859ecfa5b6495a6863c18fd923a7666def26]
stable/6.18: [2d98a3b89394f283f054a4a54587c14ee89acaf9]
stable/6.6: [88027241c1d2c3213bac937a1c2cb89a5775a413]
stable/7.2: [e82f260a74dea8cdd7857f2cc66f73d0da522bb3]

CVE-2026-90342: bpf: Fix mmap_lock deadlock on arena lock failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90342

Introduced by commit b846729 ("bpf: arena: make arena kfuncs any
context safe") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b10b945479c954393d62ee3229d2f224a4ca91c]
stable/7.2: [af8087f16714f7620c4db3e732baaa1b2337948f]

CVE-2026-90343: wifi: cfg80211: stop PMSR before P2P and NAN teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90343

Introduced by commit 9bb7e0f ("cfg80211: add peer measurement with FTM
initiator API") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c5fc504d0d6934132637aa3db4b9b58148eaa78]
stable/6.18: [7a22cbc6c6bdd3c3811b4ce13875685c520f94de]
stable/7.2: [db3439ad11ac5e52decdefe784c98b21c3757848]

CVE-2026-90344: wifi: mac80211: disconnect on CSA to channel 0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90344

Introduced by commit 21c3f8f ("wifi: mac80211: refactor STA CSA
parsing flows") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf57f0a674cc3e3cda1a789359cc1238b61b9d7d]
stable/6.12: [099aadb2012d7490bc584cc5075ef11cbc33f2c3]
stable/6.18: [e7bc5ab93acd1c3f54feeb9fa19ead3530168090]
stable/7.2: [eef374088450bb91626e133c7172b8a0e969a522]

CVE-2026-90345: wifi: brcmfmac: fix P2P action frame handling without device vif

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90345

Introduced by commit 30fb1b2 ("brcmfmac: use actframe_abort to cancel
ongoing action frame") in v5.8-rc1.
Introduced by commit 6eda4e2 ("brcmfmac: Add tx p2p off-channel
support.") in v3.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b1edb9ebed49099bdc924cef49a9aea8b552199]
stable/7.2: [f26e1b16904555e171292e183c3cfc1c38159fc5]

CVE-2026-90346: wifi: nl80211: clean up color-change beacon data on errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90346

Introduced by commit dc1e3cb ("nl80211: MBSSID and EMA support in AP
mode") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [927ee844c47ac2aef22c8f7a35f098ff576b398b]
stable/7.2: [4e0a67fbe3d9e2e1d6f81dfc607184c6b0abd3dd]

CVE-2026-90347: arm64: ptrace: Keep 'orig_x0' in-sync with x0 on syscall entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90347

Introduced by commit e057b94 ("arm64: syscall: Ensure saved x0 is kept
in-sync with tracer updates") in v7.2-rc5.
Introduced by commit a5cd110 ("arm64/ptrace: run seccomp after
ptrace") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [88b839ce497ccb1ff92f7ae742c78dd2937ba572]
stable/7.2: [f433869f23841a50455c4087d85540d5b4d37cde]

CVE-2026-90348: wifi: ath10k: snoc: use memcpy_fromio() for MSA ramdump

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90348

Introduced by commit 3f14b73 ("ath10k: Enable MSA region dump support
for WCN3990") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f25071afe9218aaae1c63fbf75e229aa6405319]
stable/5.10: [e5bc3658da9c8a535e3fa5c0c875b2a456954e81]
stable/5.15: [fed1f662c9f9fd19eeab6c01966b7b5a33804420]
stable/6.1: [838cab267ce9a975776e022f25094f8cbe1625d2]
stable/6.12: [152e894e90716163c646d70f86b3afeb70442783]
stable/6.18: [7039825a7479df637c4f5d546cb0e1cec18cd8e1]
stable/6.6: [eb946595a58decdb4cab1b5f3c972ae66f41f1c8]
stable/7.2: [045d1bfb72d2631ab9ec74afa491aa788ebb57aa]

CVE-2026-90349: wifi: mt76: mt7996: fix out-of-bounds link array
access in mt7996_tx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90349

Introduced by commit 1609b01 ("wifi: mt76: mt7996: Overwrite
unspecified link_id in mt7996_tx()") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4330a0ef9f75a54fde3548432a9a698f06bab635]
stable/6.18: [637bb99cc766a858d744905e46638459ca128b6c]
stable/7.2: [aff81505a84d27f83b4db8e039e813930cb23c2c]

CVE-2026-90350: wifi: mt76: reject out-of-range link ids in mt76_vif_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90350

Introduced by commit a9384b3 ("wifi: mt76: mt7996: rework set/get_tsf
callabcks to support MLO") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ba744a28c26eaa5cae930688a22e01888395308]
stable/6.18: [13f6a9c786022d5213e84d494cc8717c378f5395]
stable/7.2: [c1442c345ca8da857fadea1d0797b97347ab6984]

CVE-2026-90351: wifi: mt76: mt7996: do not attach hif2 WED when the
main WED attach failed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90351

Introduced by commit 83eafc9 ("wifi: mt76: mt7996: add wed tx
support") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7c1924332e986019c6bcddf55c843361cccac73f]
stable/6.18: [76144da3c6184c7850631ad79d0600ac8bf7649a]
stable/7.2: [d566387df8306257d2f703a0d99fd9896400317e]

CVE-2026-90352: wifi: mt76: mt7915: release hif2 reference on probe IRQ failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90352

Introduced by commit f68d676 ("mt76: mt7915: add Wireless Ethernet
Dispatch support") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8370aebd26a9dfa2e0de665e3ab504c0e97ee730]
stable/6.1: [8a2e38019846da29a112fac4dd96fe5bfa298faf]
stable/6.12: [5c30a6350a300fbb800831f1b4373b2f59e03410]
stable/6.18: [ed5cc46a3c8f4fe7f549c661914d8d835169acc0]
stable/6.6: [2a434d2637b9c9be9bcc8a84dc46880cc1446643]
stable/7.2: [fb9c7b4c238b4e5469a11a1fb8cf332f6193b995]

CVE-2026-90353: wifi: mt76: mt7915: fix ext PHY use-after-free on
register error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90353

Introduced by commit 7b8e1ae ("mt76: mt7915: rework hardware/phy
initialization") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15b960014f24dce5388d4a2e7274e6490cb3c421]
stable/6.1: [aa55bec92ba7747dd08feff409f8074c5e052e71]
stable/6.12: [34058ad122f7524e33df8e38caba4b1d803b025a]
stable/6.18: [a7fd3bae8e11a7c00df6a5021d9ef248ae9f9bf5]
stable/6.6: [ad706fcf6255494613b94418e7243d98065dbeaf]
stable/7.2: [648f5f03ff50d4bd719106ace0cdf1d8be02cbdd]

CVE-2026-90354: wifi: mt76: mt7915: fix double hif2 init on the non-WED path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90354

Introduced by commit cacdd67 ("mt76: mt7915: add mt7915_mmio_probe()
as a common probing function") in v5.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ae8ad277e2819a281b0e36b55633c8515c16ce7]
stable/6.1: [eac18fadc791928379b179e54636494b92f8cf86]
stable/6.12: [bd2e8f535ae35beb45a7fcc17ec9bbf8dc4db5fe]
stable/6.18: [249cbaa1873550689fab136b74982cbba74c4169]
stable/6.6: [927fe8c0eb8c10295bc0018c8faa4d91f8fe98c6]
stable/7.2: [29fbc5256c2d8448f084ff179d2e5092ecd1fc54]

CVE-2026-90355: wifi: mt76: mt7996: clear stale link state on full reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90355

Introduced by commit ace5d3b ("wifi: mt76: mt7996: improve hardware
restart reliability") in v6.18-rc1.
Introduced by commit 0881370 ("wifi: mt76: mt7996: Destroy vif active
links in mt7996_remove_interface()") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75d2a4e2129b58bb0ddb842387299038495aad2a]
stable/7.2: [fc3762724a36867c1749233c43368c2637ecf029]

CVE-2026-90356: wifi: mt76: mt7996: free vif links after clearing wcid
entries on full reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90356

Introduced by commit ace5d3b ("wifi: mt76: mt7996: improve hardware
restart reliability") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e4208e9f6a876c2b7d28fdb6b86dff3b05db2f7]
stable/6.18: [2b10eb3636d0c4cb6b763e045ec1294dbd70f5ad]
stable/7.2: [8826d7a5e2dd727aa96456ccd58b33d2b080e935]

CVE-2026-90357: wifi: mt76: mt7915: unlink TWT flow if the MCU rejects
the agreement

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90357

Introduced by commit 3782b69 ("mt76: mt7915: introduce
mt7915_mac_add_twt_setup routine") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16a04441eab0dcd4d7126a6f66b370adbf28f96d]
stable/6.1: [c09d1b15ed2dc49060303b16a296b7b8b7794cbe]
stable/6.12: [cabe239e95b4eebf5b6c3654087b66ff9425bc7b]
stable/6.18: [6bce0f1280c94af8314f895f404629da09f0788c]
stable/6.6: [1bd5c4ed2b9045faf83315c54cd37a9b7c71b5c7]
stable/7.2: [beaa42b875965dbc3e80e46970e0bfa60a94c2db]

CVE-2026-90358: bpf, x86: Fix trampoline stack size for 128-bit arguments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90358

Introduced by commit a9c5ad3 ("bpf: x86: Support in-register struct
arguments in trampoline programs") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [814cba835ef648e0c5eb79505c96c0493b29eea6]
stable/6.12: [4aed2346fa9b88d458eeb8c01123f3c07585a675]
stable/6.18: [40f3bfbbb222b92278f3797614b70f68d46824ac]
stable/7.2: [a6d7d7a253c550e74b0651897fe313c2f9b2301f]

CVE-2026-90359: bpf: Reject >8 byte return values on return-reading
trampoline paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90359

Introduced by commit fec56f5 ("bpf: Introduce BPF trampoline") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c48796aa6c392cde93946e5d5a9a1f1b1cf72feb]
stable/7.2: [d36ac53fc83baf843c51b7afd6d2471f36b713d8]

CVE-2026-90360: regulator: core: use system_freezable_wq for init complete work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90360

Introduced by commit 55576cf ("regulator: Defer init completion for a
while after late_initcall") in v5.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [03eab318cedd6ae34ecd34533cd986edf5237164]
stable/5.10: [2cebc00340a585adeffe321bc41f1937eb79a4dc]
stable/5.15: [9cf65270c1c1717c84dcfacd58a782c1186b0cbf]
stable/6.1: [dc8570a5b830190bf0b57017c35aef97cd6ad7d9]
stable/6.12: [0d23d658d79925076026fff62a49b8c94e0e8922]
stable/6.18: [0b950aa7ec95e120b2bde745ca9a7ed3ce49d528]
stable/6.6: [6d0a2c5e210f2fba099129e6183ef81316a6ae48]
stable/7.2: [29dc2e24f6adb36dcb884acf455644c397a67471]

CVE-2026-90361: wifi: ath11k: fix leak in ath11k_service_ready_ext_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90361

Introduced by commit 5b90fc7 ("ath11k: fix wmi service ready ext tlv
parsing") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0293be2212d319d59589082461abf2a9b626cd1c]
stable/5.10: [35cb3086b426b3468cfc32d0d8d9883409705ea9]
stable/5.15: [854eb9053a793b73c4e8082e1923735a80c77bcd]
stable/6.1: [7dbf0bc50cf3ddd039becd875691bb7f484fa004]
stable/6.12: [10ccd92825504c029390874c6fb84c62d9f263f9]
stable/6.18: [f5bb3471c9f46c6cabc06a152c13fc518330913e]
stable/6.6: [1296cae53052881ddd571a9d4f467a16ebfb7f14]
stable/7.2: [047a817147806140cdef5fa25d69d7b7a24f905c]

CVE-2026-90362: drm/msm/dsi: Drop dev_pm_opp_set_rate(0)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90362

Introduced by commit 32d3e0f ("drm/msm: dsi: Use OPP API to set
clk/perf state") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06b7ba206561619bb34116f49e0ef26b867ce3aa]
stable/5.10: [bc1df05cccdb4f08aa42e736b54d265c6c11a45b]
stable/5.15: [27e181c185194baf5c1ef18bbff1fc3bc283ef21]
stable/6.1: [5c3e537db05021c93ea40a46bd0c50eee2f30f87]
stable/6.12: [393b43cc12c95f3d2762a06f799807313029032e]
stable/6.18: [83bc4eab83ae5ab88d410148a2e73e09e6f21c04]
stable/6.6: [d3e8355a63cead3dedaa52f46cd1ee9796fdc7a8]
stable/7.2: [00008e6f544c2d480f920ab1e593a46cfb87cead]

CVE-2026-90363: drm/msm: don't tear down KMS twice when KMS init fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90363

Introduced by commit 506efcb ("drm/msm: carve out KMS code from
msm_drv.c") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93c125e4ea98fb25f927ba5a334d85845127d667]
stable/6.18: [08827aa40f0ee9d37dcff8d6acb340b970051486]
stable/7.2: [e2a99fa93b400dfbb9598103249f71969501094a]

CVE-2026-90364: ACPI: processor: Unregister cpufreq notifier on init failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90364

Introduced by commit c0e0421 ("ACPI: processor: Reorder
acpi_processor_driver_init()") in v6.3-rc4.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06f32dd67e6b23a05bef0d8183c5335af91c0c3b]
stable/6.12: [8f3036c5de8b651880f323e223b1604b6cfbff21]
stable/6.18: [64976f3b34b07eb866ead4052cefe7e9ff45fd2f]
stable/6.6: [ccee0785030978c49505e04954eee3f30a5f01ca]
stable/7.2: [182cd086b31ea4ccc1d8f2ec5b81e988dfe0b892]

CVE-2026-90365: wifi: mt76: cancel reset and rc work on device unregister

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90365

Introduced by commit e57b790 ("mt76: add mac80211 driver for MT7915
PCIe-based chipsets") in v5.8-rc1.
Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e995d3dccc9d980af13a60ad37409ed1561f9eeb]
stable/7.2: [c4dc85481d38951ca7f8bc104e711936306cc664]

CVE-2026-90366: wifi: mt76: mt7996: reserve space for the CSA-abort
countdown TLV

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90366

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50c66bab321140c49aa2ed779a3ec9d2f085b458]
stable/6.12: [bc1d694a1ffe0062c3adf0db1d64ad54454398ec]
stable/6.18: [45d8896e4cffffb2c6554ccbec6efe7a0d53166f]
stable/6.6: [1d348f96623ec20d700af7d4dfc00a74da6238ac]
stable/7.2: [1a51aff0e048dc5b8252d65808b79939c942d6ec]

CVE-2026-90367: wifi: mt76: mt7996: hold dev->mt76.mutex while
disabling tx worker in SER

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90367

Introduced by commit 27015b6 ("wifi: mt76: mt7996: enable full system
reset support") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6190db312b8230813f529f014b26247c6d9800d0]
stable/6.18: [906ad486ba5c4933d82e1ebe0685656390a48450]
stable/7.2: [594c4b7f89f9ea75dc9c50b5e4c4296db4a3d701]

CVE-2026-90368: wifi: mt76: mt7915: unwind state on add_interface failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90368

Introduced by commit b619e01 ("mt76: fix MBSS index condition in DBDC
mode") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fb6480c52f611338e1b0abe5e6219be1fc9ab75]
stable/6.12: [218fdf0fcb796b8d281dbdd4a6144c5a8fc7fd0f]
stable/6.18: [507eddb8175a67df5086354b92d6a4fd7f6f1f96]
stable/7.2: [71bf9de2ab3fb2c54bedb0b4c9b468d2e1d55280]

CVE-2026-90369: wifi: mt76: fix out-of-bounds access in mmio copy helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90369

Introduced by commit 2df0080 ("wifi: mt76: mmio_*_copy fix byte order
and alignment") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6689b4a65e88d7b019e687fa9d6943ca070f3e43]
stable/7.2: [6ed0fba58bb125a8d8de96e391aa86111166efca]

CVE-2026-90370: wifi: mt76: mt7996: bound TLV walk in mt7996_mcu_get_chip_config

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90370

Introduced by commit 5d33053 ("wifi: mt76: mt7996: add variants
support") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44af52467e72094351a362bf69effd52f1d9c186]
stable/6.12: [39aa6b853b6d69dd1fee3507efdb3c277b7c53e6]
stable/6.18: [d0bb2189ade617e624f3c8f444ebb05f59bb2524]
stable/6.6: [3106f62809d45c1e6aadfad1f4d7c3f74cd53a96]
stable/7.2: [93eaddfdd35aa6bfe570c087db4e97fb9d8a791a]

CVE-2026-90371: wifi: mt76: fix RXDMAD_C buffer recycling race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90371

Introduced by commit e50d4d7 ("wifi: mt76: Add
mt76_dma_get_rxdmad_c_buf utility routione") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1f97c10a4ec2b9db69a134b757304399ca903ce]
stable/6.18: [7ac05ed3a50e511c93f8506e555709a208dfce0a]
stable/7.2: [a273dc3b86a7d983d643827d3d3c795d55d8f632]

CVE-2026-90372: wifi: mt76: mt7915: avoid nss underflow in
mt7915_mcu_get_sta_nss

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90372

Introduced by commit 89029a8 ("mt76: mt7915: add Tx beamformer
support") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a2f4be532e3ea4e2b536e411793a05aaa51af25]
stable/5.10: [2801477c36a19be4f549fe60e54995f03b0ea7b9]
stable/5.15: [38f4d6323bcd65e41a691432eddabd2b03acdeee]
stable/6.1: [25f753f7f620955a8a51e63e445d8b9076c51396]
stable/6.12: [85bd46ab7674b6d357f9a14791352c65fb09eee9]
stable/6.18: [6ce78d04c7ea4b66838941b5a4232dd1ee0e2cc7]
stable/6.6: [e63c6291ecddf94769ab91f9d8cdb6ca939f7fc6]
stable/7.2: [ecfd1a07e78c31d81322fb2d81dc468081cc3004]

CVE-2026-90373: wifi: mt76: mt7915: clear wcid mask under mutex after
RCU pointer clear

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90373

Introduced by commit f3049b8 ("wifi: mt76: mt7915: allocate vif wcid
in the same range as stations") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6486e11a6e2f679597af2d5bb48c3b07a2b2a7ba]
stable/6.12: [5dce25f1d609ba991a9c22c27be586c92f03ed77]
stable/6.18: [b4a41a47a67c788e6b0625fa517ec8872e99bb6c]
stable/7.2: [a97b2b942d2f8f12fbd6a7caafc735d1ad115e6b]

CVE-2026-90374: wifi: mt76: mt7996: validate RX band_idx before
dereferencing phys[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90374

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2243778a5fae8329ab5f18e7adcd7e03b911a1b7]
stable/6.12: [535091c587268cc783608642838a655d828eefdd]
stable/6.18: [0f53ece876e1f3bbb3e18f48afc4af1ee967b16c]
stable/7.2: [b1c5cf8903bec5476a2233b4e45287b9a2213e02]

CVE-2026-90375: wifi: mt76: fix non-AQL packet accounting for MLO stations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90375

Introduced by commit e1378e5 ("mt76: rely on AQL for burst size limits
on tx queueing") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ae659743ba936b22ecb4620815887728e2820d6]
stable/6.12: [f85f6933cc170155f1c7c2dffdd014965787c71b]
stable/6.18: [fc7fae55255ccbde009232e84b102d2782a69ecf]
stable/7.2: [186c957ac3325aefb982567ffdd3654b283688a7]

CVE-2026-90376: wifi: mt76: mt7996: fix MLD ID in MAC TXD and HIF TXP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90376

Introduced by commit 85cd553 ("wifi: mt76: mt7996: use correct link_id
when filling TXD and TXP") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [ce35ecffc96e6d097d27b6fe30677a2cfe2e0461]
stable/6.18: [5183b9f092fc0041618f38f895bd0ad860c26ca9]
stable/7.2: [0a951ff6704db7b46c3f6d03b77e6053122be8ab]

CVE-2026-90377: wifi: mt76: fix RX data queuing of RRO 3.0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90377

Introduced by commit b1e58e1 ("wifi: mt76: mt7996: Introduce RRO MSDU
callbacks") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86897f106669c07eea4c34b54c3268d448d41426]
stable/6.18: [62aea1d45b524cde9e02d1e7f65d2c4fd60871b8]
stable/7.2: [db4be207f3f6d8886f0b31f8c7db863a4b835ec1]

CVE-2026-90378: wifi: mt76: mt792x: Fix memory leak in SDIO TX path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90378

Introduced by commit b747fa3 ("mt76: mt7915: drop zero-length packet
to avoid Tx hang") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [808f2767d4217a5b96f674288573b9b89d432eed]
stable/5.15: [b64d196280aff8494ba6fb387e37b18479c99b83]
stable/6.1: [9ef1351209d42b7d96604f2a13d7ea8215a24e07]
stable/6.12: [6a8000c76dc34490a2bb321ad1a5f882a2ccab7c]
stable/6.18: [ddf6a17d8e3d0dbb841c13c10d7c1340a138a80d]
stable/6.6: [c2c7f16f2c62f79f7c381e500afa7123580742a5]
stable/7.2: [6a342db7a6502bc6781579145e05d4d4731786ab]

CVE-2026-90379: wifi: mt76: mt7921: Add PCIe AER handler support to
prevent system crash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90379

Introduced by commit 17f1de5 ("mt76: add common code shared between
multiple chipsets") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [915672c5ae32deeb72f4572856d123f314791136]
stable/6.18: [670b3dc4e3713542a9f002d38fb9d1740b9e342b]
stable/7.2: [f544bcba4721e1074e9bc6666f0ef4f8b96ddba8]

CVE-2026-90380: wifi: mt76: mt792x: fix use-after-free in mt76_rx_poll_complete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90380

Introduced by commit c948b5d ("wifi: mt76: mt7925: add Mediatek Wi-Fi7
driver for mt7925 chips") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [217f9e7bb02558759be9d9ecfe532e9708741c50]
stable/6.12: [aaf414bf81ab4b680580871784b0b929818188eb]
stable/7.2: [b250943f3f8351385a17972bda001664a5c51008]

CVE-2026-90381: wifi: mt76: fix handling channel context with
different bands in mt76_switch_vif_chanctx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90381

Introduced by commit 8233462 ("wifi: mt76: add chanctx functions for
multi-channel phy support") in v6.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70869cc429fffc77de51e7777c0ecb651e8fca07]
stable/7.2: [063169a2755abdcbe7698d98360336abb6bef414]

CVE-2026-90382: wifi: mt76: mt76x02: do not WARN on invalid rx descriptor length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90382

Introduced by commit 7bc0421 ("mt76: add driver code for MT76x2e") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81497634d9f872fd3e8b03aada55574afff6f174]
stable/5.10: [61b1f6d92249bc34580ff19de7c69c805f82adca]
stable/5.15: [c65bbfc730df9ebf0fea8e286b0ad2dfab03dbfe]
stable/6.1: [d55e7aede542c4c76ead82d37d0c112f21eb2ac2]
stable/6.12: [2d31e332c13b1db7745a7bd9cf74bc105524bcac]
stable/6.18: [17d6b89e09eac2d90272fceeba3644e92212e02f]
stable/6.6: [b6e7958602bd1acdb8ae92703b6689a28bcc9bc0]
stable/7.2: [6def491fe9c4e83aa8cba62d74e9d4ab751ee967]

CVE-2026-90383: misc: sgi-gru: remove interrupt-context page-table walks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90383

Introduced by commit 1425864 ("GRU Driver: page faults & exceptions")
in v2.6.27-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [928a8e9f523df845fc496bcb9811013b67aabec5]
stable/6.12: [877423f595b60f8fe7c18b64a5d283d9e1732a13]
stable/6.18: [6248eb1833ff0adfdbbadd5f846c2f22e02a01b0]
stable/7.2: [ef81e4a1628ecfb9cfc442de10883f383faf17a1]

CVE-2026-90384: iomap: release the folio batch on iomap callback failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90384

Introduced by commit 395ed1e ("iomap: optional zero range dirty folio
processing") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31e3d833d522746a93d135e8b465d16f8ad33453]
stable/7.2: [34470cc3a8e66751030d7b777dd18d9f2acb48e8]

CVE-2026-90385: md/raid1: create serial pool adding rdev to array with
serialize_policy=1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90385

Introduced by commit 69b00b5 ("md: introduce a new struct for IO
serialization") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [140234b2380ffb8ffb0cfc46fee0e822f43adef7]
stable/6.12: [f9e4364449f7ca6917f3599eb32064dba5b7b147]
stable/6.18: [37f11973c3eb72a5eb061082cad529bb6939c24f]
stable/7.2: [c02d675e81468003e4f2253b616c53729070d712]

CVE-2026-90386: i3c: dw: avoid shift-out-of-bounds when DAA assigns no devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90386

Introduced by commit 1dd728f ("i3c: master: Add driver for Synopsys
DesignWare IP") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [038cf48b3170af26a70bf2dee4f8c3ac910f5176]
stable/5.10: [5650b013e6bfc14c8b30be727f4a715b01860a08]
stable/5.15: [63110ccc434e10d9e9d2c7d82ebfa8a6f9cedd94]
stable/6.1: [3a1c35739efb69e8ec2a868113a0471a01bb8f29]
stable/6.12: [754533e6169d1f10bdef7a6ba9bd7740b524e1d4]
stable/6.18: [9eaac0cb4ca94e2e32c53c156ae5b813ba7ef90c]
stable/6.6: [111f559e5b6461f5f6977275716e6c5d1eb7ea27]
stable/7.2: [618dd640ded6b94bbdb79c798a901ec564797033]

CVE-2026-90387: swiotlb: Preserve allocation virtual address for dynamic pools

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90387

Introduced by commit 79636ca ("swiotlb: if swiotlb is full, fall back
to a transient memory pool") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57d29044d0f29a76c6ec0c112c8c7371d5608dc7]
stable/6.12: [45507dcb0847e96add4455274b12df0eca6590b4]
stable/6.18: [35e0103177826430b5df888b1506239d41e76ab5]
stable/6.6: [68bf3ebd8e7020dae58e8aa14c7d482738bff9a8]
stable/7.2: [c1f4d7763cdf1b9e0d35c14aa6f52d0512a36319]

CVE-2026-90388: iommu/dma: Check atomic pool allocation result directly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90388

Introduced by commit 9420139 ("dma-pool: fix coherent pool allocations
for IOMMU mappings") in v5.9-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af95a0ebc0a0db0762be75f51eadf770bad01aaa]
stable/5.10: [ac9cd0a669b8be5d178dbd471b0d68039dac58b5]
stable/5.15: [db46cb9da83a507d86d2bb080bdb09c865da3d0a]
stable/6.1: [d56c3f955b21e5764c1497e295a5b5d0b3a40470]
stable/6.12: [a4ace31d732b657d774e31fb444c0c27d42c78e5]
stable/6.18: [fb0b39287ba894dbdfac2901c51788b63f5c2291]
stable/6.6: [06dffc96693083dda3412311406e558cf27f1574]
stable/7.2: [8c486293ddd0af60991408149fc3e964ea888dc4]

CVE-2026-90389: md: scope memalloc_noio to allocation critical sections

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90389

Introduced by commit 78f57ef ("md: use memalloc scope APIs in
mddev_suspend()/mddev_resume()") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bace2010dd7ac07bc980575afb135c406730a7fe]
stable/6.12: [72ebfdf507ede7d7f2b7ca0a5634811a0e4bf045]
stable/6.18: [28fdea874f68cac6c36651b1fc7272fd2199c48d]
stable/7.2: [a58923756b0f8e71032070c23ae0b167e46731da]

CVE-2026-90390: md/bitmap: resume array on backlog_store() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90390

Introduced by commit 5822694 ("md: use new apis to suspend array
before mddev_create/destroy_serial_pool") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2911cd0a0f4366a7e06832bc5f0a7fdcc138e4dc]
stable/6.12: [03aad318f0a1f039dddf98739e705fdca3bf0d86]
stable/6.18: [6763fb409a0b4106676a52cf934440d9484b32c8]
stable/7.2: [cc543e769b97d563b089b9e0ebf8ad361d15076f]

CVE-2026-90391: lib/test_hmm: fail dmirror_fault() when the mirrored mm is gone

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90391

Introduced by commit b2ef9f5 ("mm/hmm/test: add selftest driver for
HMM") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a8024511ddf4877435c34fb3d6028aa8e590649]
stable/5.10: [50606ced303782f8715e2d0b98ca374ea498fa29]
stable/5.15: [541a67f21ab807c8dbc0ea88d5a2eb73b2618090]
stable/6.1: [d8e64ffab01e032ae29159d27230ace8cf8bdc80]
stable/6.12: [701347e31aa607f3782403151a3125729d685275]
stable/6.18: [af7a6d6ec36a16a583ba2e4e9984c3cf1fe34655]
stable/6.6: [2636569ea7c19d9a40db4a1e8d0a027bdacf1569]
stable/7.2: [a2074f86fc9653831e4fb7b711bb715db330f182]

CVE-2026-90392: bpf: Fix potential UAF when reading bpf link info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90392

Introduced by commit 0c991eb ("bpf: Implement bpf_prog replacement for
an active bpf_cgroup_link") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [863f3ddd0b8ac65abfb50d3be0869268ac0e277b]
stable/6.12: [d7d7208e2603b45724b684f4df73904fb347741e]
stable/6.18: [85cf991c881e7198be32be05a9daa2625390c8b3]
stable/6.6: [a5c936ac904767fc1d943d40b0308bcb2ae2509b]
stable/7.2: [79347e42cfbc9e78872922e8f08a70609c9af82f]

CVE-2026-90393: bpf: Fix potential UAF in bpf_netns_link_update_prog

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90393

Introduced by commit 7f045a4 ("bpf: Add link-based BPF program
attachment to network namespace") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c5997836381010fc5907b36bc17d3b19407e933]
stable/5.10: [d462b5481d77ce7df8a5ff89a699386f00c9214d]
stable/5.15: [bdddf3e1493ee973619c154a57071ce67f78598b]
stable/6.1: [79a66fd997d4eecf17302d613194879eb32e0986]
stable/6.12: [277168cb9d153ce8e9c3f9275670e32ae61b41d6]
stable/6.18: [bda86e9f31b9a296b6e64a51c91dc776fc9f613e]
stable/6.6: [f4ce6803df4095777191d800bebc50219b615ca0]
stable/7.2: [923f559e95b89b33c7e1793b3d8f7f4ec9b2e4b7]

CVE-2026-90394: power: supply: sc2731_charger: cancel work on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90394

Introduced by commit 8ac1091 ("power: supply: sc2731_charger: Add one
work to charge/discharge") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dfc859bb8d332c525872f1a44028137724fa1998]
stable/5.10: [bb74a5ab30963022981381ea6aee176fd0c7957c]
stable/5.15: [232e9e946b496e4706e2f34ce4a617460d8ae713]
stable/6.1: [05c188addc6d1af51e28496e95096f4df9a000e9]
stable/6.12: [c6df6e0c099086bc553d44410015cc81795070e6]
stable/6.18: [d5266b4c5c77152e386a3a2d9d5244b3b6cbd57a]
stable/6.6: [972d88069050d0272b776145b824198b8f899dce]
stable/7.2: [aab9d81a415c6653b44b057695ebfbba34dc9556]

CVE-2026-90395: power: supply: isp1704_charger: cancel work on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90395

Introduced by commit ec46475 ("power_supply: Add isp1704 charger
detection driver") in v2.6.37-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60c5b8a9ef4dbc5d69bbc1a960fe55826cb3b643]
stable/5.10: [b0fa49bcb25b905b49dbb681c8a94f00d1a7f94d]
stable/5.15: [a4750d5d7d1a3bac1b23ac5817f2bfbedcc95ac7]
stable/6.1: [1ed74e3a8bbc104b744c257f8cbb2c371485ba4f]
stable/6.12: [cb442f1823df5782002ab4c36a8775270d41a772]
stable/6.18: [f312c5d17f2a7ad50df5b52935d76abbe7b89feb]
stable/6.6: [c22a9a539c76179fca5c0f28ee7652c4afda750b]
stable/7.2: [ad4f4e6678ecd4f6de97b73d4bab7d2352d40d70]

CVE-2026-90396: block: fix dio leak on metadata mapping error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90396

Introduced by commit 2729a60 ("block: don't silently ignore metadata
for sync read/write") in v6.17-rc6.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [702a2a9f3dfe066a7481698c858371112f3cb697]
stable/6.18: [d29c5a88d5703afb6286038e86e1b88daa4962a9]
stable/7.2: [cbbaf0c870dde06cf4b887a77a94e3094179ca9f]

CVE-2026-90397: firmware: qcom: scm: Fix NULL dereference in IRQ
handler before __scm is published

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90397

Introduced by commit 6bf3259 ("firmware: qcom: scm: Add wait-queue
handling logic") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [966d23c7e68ea32679275a7e3d2383181002c868]
stable/6.12: [b451f38cb7f5bca78484362347f039c08c94de95]
stable/6.18: [1d753df5899ec356272d08bc4718e82844e4bdf0]
stable/7.2: [f312ef5026678f14caf1378c5f7fffdf667f9c81]

CVE-2026-90398: wifi: ath11k: fix stride mismatch in mac_phy_caps_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90398

Introduced by commit 5b90fc7 ("ath11k: fix wmi service ready ext tlv
parsing") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a246c72132eb943b5844ba79dad597b47429dba]
stable/6.12: [bbb3b3334a9ed850c5b332eedea107796e691237]
stable/6.18: [75185e2b214e842b7e0af29e5d1fef155662b8b1]
stable/7.2: [acff2713c3212ade15051e7b421f15c89927e70f]

CVE-2026-90399: wifi: ath12k: fix stride mismatch in mac_phy_caps_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90399

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c6eb712a91fa079be6f9f1419c96e0ad2227081]
stable/6.12: [d3355e0fdbbf531ca8b82a6a3feb80a1b7306a8b]
stable/6.18: [b9a5d12cbdeb860306f8d47c92caee0ea6ee0e0a]
stable/7.2: [26f8f87f0a556e7984366c64cebc16d49e15d22f]

CVE-2026-90400: md: recheck spare changes before starting sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90400

Introduced by commit bc08041 ("md: suspend array in md_start_sync() if
array need reconfiguration") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7d34d17ea43ebc86b45d439ebb435e11ca44bca]
stable/6.12: [c3777d16bc3335c0ac4bdad0551c80d38c5d94cc]
stable/6.18: [e5ac7ab78467b064f1da8b0f3042a63595fafcfd]
stable/7.2: [81b39df5d701976cf20e52f33106c1fc1603b4cb]

CVE-2026-90401: md: remove REQ_NOWAIT support from raid1/10/456

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90401

Introduced by commit bf2c411 ("md: raid456 add nowait support") in v5.17-rc1.
Introduced by commit c9aa889 ("md: raid10 add nowait support") in v5.17-rc1.
Introduced by commit 5aa7050 ("md: raid1 add nowait support") in v5.17-rc1.
Introduced by commit f51d46d ("md: add support for REQ_NOWAIT") in v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fe5b7c9fb72ccc29bfd0f955b124892af7e3674]
stable/7.2: [9bb9504e2d8f3d22ef12d51c333dd499f402dc8f]

CVE-2026-90402: bus: mhi: host: Fix controller cleanup on EDL sysfs failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90402

Introduced by commit 17553ba ("bus: mhi: host: Add sysfs entry to
force device to enter EDL") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d5b9e66591d4e2a4376ac82c8cda889a29ba3ee]
stable/6.12: [7943dc67250fad6ceac0dd089c6ad5776e4be71d]
stable/6.18: [4fb17a7c437f145353e93e6a9791f6db70e1cc63]
stable/7.2: [4743959aa8d876b5b456a62e8a62eb770db7afe9]

CVE-2026-90403: wifi: rtlwifi: pci: fix error path in rtl_pci_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90403

Introduced by commit 0c81733 ("rtl8192ce: Add new driver") in v2.6.38-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c2999d13eeb222ae56631aeb7ca248090f2b210]
stable/5.10: [2634998247d24be34ba16a7666f31815ef1da00b]
stable/5.15: [cfd6824dd1d151ab3abc00117b3774c8056006e0]
stable/6.1: [86e6187f8525c8f8219eb49e022eba854cc6ab86]
stable/6.12: [b42fcfb097da46f0e86564736ced939e83cb8442]
stable/6.18: [a89818977338ba71194b1ab1d071f0c0848b1e13]
stable/6.6: [aef178ffae5420afdbf46f7133ed28bd4248e15c]
stable/7.2: [1b68b6e529ce75112fab98e89583a76370ca394b]

CVE-2026-90404: platform/chrome: cros_ec_debugfs: Unregister panic notifier

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90404

Introduced by commit d90fa2c ("platform/chrome: cros_ec: Poll EC log
on EC panic") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5954d3031fb55dd31aa59bae477d63c68e941c0]
stable/6.12: [a5d3128b06ccfc398c2e456fddebadce52310bd8]
stable/6.18: [e2cbe14361d7cb0b5abd66d87f3afa0e16efde9f]
stable/6.6: [56989e2a9c292ff7689603feed41d030301ca636]
stable/7.2: [05c1081ae4503e45b934b390350f942db3208892]

CVE-2026-90405: media: stm32: dcmi: fix some error handling bugs in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90405

Introduced by commit bc90188 ("media: stm32: dcmi: perform
dmaengine_slave_config at probe") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1d1ed39ced825615aeac61f0b6a322178756632]
stable/7.2: [4d030d7d1af95d24d3eb6e536a4f09b7bf9a8659]

CVE-2026-90406: media: qcom: iris: handle runtime PM resume failure in
core deinit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90406

Introduced by commit bb8a95a ("media: iris: implement power
management") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75d79879ec3cbfd288144b0ae4c3e3fa7700c5fc]
stable/6.18: [e7768f3dae9f2c6e5b80e9c02429550ea39f2be6]
stable/7.2: [cb83cfff8dff5d546fadce15596e01b1504b632a]

CVE-2026-90407: wifi: ath11k: fix overreads in
ath11k_wmi_process_csa_switch_count_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90407

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [208d7fdb85976a737a715b81d54efaff6703880c]
stable/6.12: [d6625dc5f1fe42cd81b8c57a1f5317afb9b410ce]
stable/6.18: [0364926fb4bfb5b798e5fe2785b3023b4f767327]
stable/6.6: [f760b7d7e43584d2fa9bffcec1a04e502609f827]
stable/7.2: [5de2b8c53714ad58f2fda118cd29ebbe31b38665]

CVE-2026-90408: wifi: ath12k: fix overreads in
ath12k_wmi_process_csa_switch_count_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90408

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [878654eb78c6aa0ff585baf1376567c775ca28ec]
stable/7.2: [bf97c9d5123859a07848462539153176db029f3a]

CVE-2026-90409: drm/panthor: Add vm_bind region with kbo range overlap check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90409

Introduced by commit 12cf826 ("drm/panthor: Support sparse mappings")
in v7.3-rc1.
Introduced by commit 647810e ("drm/panthor: Add the MMU/VM logical
block") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/7.2

Fixed status
mainline: [985f5e12f3cdf43030e13c2bbd154913133b5c3f]
stable/7.2: [761cf9c63274a5b711c3dc829601723215710d2d]

CVE-2026-90410: spi: davinci: switch to managed controller allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90410

Introduced by commit 5b3bb59 ("spi: davinci: Use devm_*() functions")
in v3.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea408a05dc8f18b4a184b88d6e19d2fd1acc1527]
stable/6.12: [f9452eba71fbfcee55c0b8e030ee3615e9f75f65]
stable/6.18: [3b544072185c3d19ddec621ec9f6897ea2d10ee3]
stable/6.6: [29e37f768f35592e26477f703649bd2e6f18d857]
stable/7.2: [1a7958ce58dc95b06615df00c120ece4eb9ccc86]

CVE-2026-90411: nvme-fc: unmap cmd_iu DMA on rsp_iu mapping failure in
init_request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90411

Introduced by commit e399441 ("nvme-fabrics: Add host support for FC
transport") in v4.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f49d0c3a8d56a7cda1628ae17341a4a42063563c]
stable/5.10: [c0892cfb60a75e2c86ba8e2127b133f6549c12b3]
stable/5.15: [5e820d04c241c81a47e1940349018690e93d8167]
stable/6.1: [bb0251991420c25e3ceeac40ea09250d79ed7ef0]
stable/6.12: [18c5781ed8bc2f423c26ec93e47e2057cd76a783]
stable/6.18: [bd764baf82bb46e958a0bd0b481630dd71313055]
stable/6.6: [acc173608ca7abe5dee8983086b44efd8b0dbc84]
stable/7.2: [be5eb47ee3fea338efae1a5b678d6bb5f0fcc931]

CVE-2026-90412: nvmet: fix return status of RMI log page on allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90412

Introduced by commit 5fd075c ("nvmet: implement rotational media
information log") in v6.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [581d8bb556dd3e5567bcf322aa5e3e4b6a200c08]
stable/7.2: [9e136150ac55df4b7ea36e6110ffa39d08905f37]

CVE-2026-90413: IB/isert: reject login PDUs declaring more data than
was received

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90413

Introduced by commit b8d26b3 ("iser-target: Add iSCSI Extensions for
RDMA (iSER) target driver") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2488b5b4827e5415768afc8daf097e8eb83c98df]
stable/5.10: [b1f3313e7b3e396e4985fea5c709477387e0a065]
stable/5.15: [228aaa620fe6a7bc8b5b21dd348b4836b1760c61]
stable/6.1: [0d9c0586af703890afe1bd0cfe641e3a3af1c32d]
stable/6.12: [71ec8bbfa4a183f1e623662f9cfbcd702e433bdb]
stable/6.18: [c345d9d0b3eefc990bb90cf565325785aab06aab]
stable/6.6: [44fe800ec13386c88bd5b32bcd1deaa1e17535d5]
stable/7.2: [48812c8103071d550d9ab4a3431be5bdc52255bc]

CVE-2026-90414: IB/isert: reject PDUs declaring more data than was received

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90414

Introduced by commit b8d26b3 ("iser-target: Add iSCSI Extensions for
RDMA (iSER) target driver") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [957f92ea4022fb6af4618271615a2a21a7b5bef9]
stable/5.10: [b4706722ed3ea72882b3c986a19b4a1ba66384c4]
stable/5.15: [bc58e9d3dc560220c57b8bdfc12af0cff1c8a43d]
stable/6.1: [274b1ad7e78338710864c4b4235bb1ce7e7107f9]
stable/6.12: [39da0b7e1f530347d284cebcfc5b5afa90a173bf]
stable/6.18: [cf36fa5357a2fb25776a568d13a3653da7d99bcb]
stable/6.6: [2a6b8f88fb7ee51714a1922a039225bdcaf12855]
stable/7.2: [352dc85324b29f5c85876f2666f3158b645e3f18]

CVE-2026-90415: RDMA/cxgb4: free STAG index when TPT entry write fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90415

Introduced by commit ec3eead ("RDMA/cxgb4: Remove kfifo usage") in v3.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdfb5cea4bf070cdb31d997efd87bb684df041fd]
stable/5.10: [5fe4731bfbd8d83c4a14b4af3a27329969ce8a99]
stable/5.15: [8f6976d635d190e3d7af7103daaa581cf1ccc12e]
stable/6.1: [9eeafcda1d6c11f0eec532243c4e96ec8c632bd7]
stable/6.12: [2f17ca7ab5269ac2504e1039c3921373dccd7712]
stable/6.18: [a2e37d1ab773be3cd26b1c19593ca2dbcece9c57]
stable/6.6: [5a21e5114cec4cd3f8a2843d4c46bc49634d6e96]
stable/7.2: [a64e2beb450179a5d43034af8d5476a11eac1486]

CVE-2026-90416: RDMA/mlx5: Fix stack out-of-bounds read in cc_params debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90416

Introduced by commit 4a2da0b ("IB/mlx5: Add debug control parameters
for congestion control") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03826bc1fa6c90405bf05831f2b501a8368dcd27]
stable/5.10: [1c5b4f76cd73372c5a8a4c91c95d5a31f141e091]
stable/5.15: [06b62758f81e27ca4c81201c22e3436c6d9ac894]
stable/6.1: [d809cf3f0ed9255abfc73c4730bcf187151422af]
stable/6.12: [ce8dfd32a33b578c3abf178f67b4c8d36854f041]
stable/6.18: [4599311e78e88c893ad551aca622de2bfdf1c31f]
stable/6.6: [0b0122fcc923a0271130f5fb71af2cd7e20434d9]
stable/7.2: [c75ee076fa09778a2f9602a972dade4a0b0785f7]

CVE-2026-90417: RDMA/cxgb4: Fix dereg_skb leak and double free in
write_tpt_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90417

Introduced by commit 0f8ab0b ("RDMA/iw_cxgb4: Low resource fixes for
Memory registration") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [373f3716a2de7adc739269ebb4d87e5bf4dc180c]
stable/7.2: [6b15fc9bc117fb6597fa1c2cc30284aafe71101c]

CVE-2026-90418: nilfs2: fix BUG in nilfs_copy_dirty_pages() on dirty
state mismatch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90418

Introduced by commit 8c26c4e ("nilfs2: fix issue with flush kernel
thread after remount in RO mode because of driver's internal error or
metadata corruption") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66f4ad3ce158902e5f98afea93189972ed8750c2]
stable/6.12: [4e1f21e7540b25d83f86b50780836ed7d2afcc93]
stable/6.18: [3904fb0ee741ebbbc27ec8f50a9bb6cd31e8af05]
stable/6.6: [5166a21b12f549774f2983fa86d2526ea9e66ace]
stable/7.2: [f181155baf0c93a74ebe804c6cecbe970e78ee9e]

CVE-2026-90419: nilfs2: prevent out-of-bounds read in super root block parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90419

Introduced by commit 8a9d219 ("nilfs2: operations for the_nilfs core
object") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cb2f76a6a2ba2130b577cb8ac13e1e46c4fc689]
stable/5.10: [16df2520502867a4f34e202b89d01243d59bb8b5]
stable/5.15: [dcc85fc28f884038735464f6f104dda9c7dbfad6]
stable/6.1: [5b69ebe20d7f944c1f45177dca0c11474ac277cc]
stable/6.12: [71bd64471ff583101b4a33dfc838ce29aef57960]
stable/6.18: [842397fdfd2e61d6470166c796f3125b6c27a162]
stable/6.6: [7029e70cf86d5c54c0a2812479b0bee2cabcbaaa]
stable/7.2: [15c8559376416a84c3d8402fd8d0c89bb323d05f]

CVE-2026-90420: nilfs2: fix infinite loop in nilfs_clean_segments()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90420

Introduced by commit 9ff0512 ("nilfs2: segment constructor") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce5a5ad1a8330a2fcfdd9ec2ab341be739e89a18]
stable/5.10: [e3e9367dae1a6392cbb14ab0b2ab5edbf39735c3]
stable/5.15: [217b967ad7887a3e1ebc08f46f6484e081acd4b4]
stable/6.1: [3bcdbdaac884a4baa59716cf9bd9470c75276e2d]
stable/6.12: [c07e5ad6539e7e9350d5c65cbf8adb69d1711b15]
stable/6.18: [1fc6df85b4954b6fda9c351843aaca3c06f66d8d]
stable/6.6: [d7afca8e4efbf4c455b4663c29ae59fde2f1b671]
stable/7.2: [8cea0bc78ac64cb88da49c07f80bf2cf9fb7aff8]

CVE-2026-90421: PCI: Fix UAF when probe runs concurrent to dyn ID removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90421

Introduced by commit 0994375 ("PCI: add remove_id sysfs entry") in v2.6.30-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ffc4c9690c33ee28cdb3d0182b12f9c623e3acc]
stable/7.2: [42a5661ff7e4c7d3c5025d0f8e5079fb5479ea49]

CVE-2026-90422: clk: mediatek: pllfh: Fix IO remapping leak in
register_pllfhs error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90422

Introduced by commit d7964de ("clk: mediatek: Add new clock driver to
handle FHCTL hardware") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [540d91480bcb1b28a62d7023aa70947ea44c55b9]
stable/6.18: [d35e45e5bad4fabcf122126402b6c6dcb4379672]
stable/7.2: [fea0b4fd891a2af77b55e05b950e7ea55b5d234e]

CVE-2026-90423: RDMA/rxe: Fix UAF in ODP init error-handling path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90423

Introduced by commit d03fb5c ("RDMA/rxe: Allow registering MRs for
On-Demand Paging") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51f2c8d2c99fc1f452f7113c08a35edcc4bf8732]
stable/6.18: [5f1933163327c9f1c8f2a341c6cb551aaf231ff9]
stable/7.2: [4cfb448705da3171d44d9cbe7be53ff03284d532]

CVE-2026-90424: iommu/tegra241-cmdqv: Fix VINTF0 leak on the init-failure path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90424

Introduced by commit 918eb5c ("iommu/arm-smmu-v3: Add in-kernel
support for NVIDIA Tegra241 (Grace) CMDQV") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f40f3144477314b489e4bc209c06cb51679fe82b]
stable/6.18: [1d2271d7df5230e4ce36bdafd17524bd004f3b3f]
stable/7.2: [417190bde0fda4ee857999a722ca90163fbec587]

CVE-2026-90425: iommu/tegra241-cmdqv: Require exactly one Stream ID for a vSID

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90425

Introduced by commit 4dc0d12 ("iommu/tegra241-cmdqv: Add user-space
use support") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb292bfc9be936dade7eef7ec5762de1201983d8]
stable/6.18: [9b37afb2d34d99ec4f8db28134181b5a8ec9a4a5]
stable/7.2: [0b139ec4641c7d4163d8e345c26cc630e24fa43b]

CVE-2026-90426: iommu/tegra241-cmdqv: Free the error IRQ before
tearing down VINTFs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90426

Introduced by commit 918eb5c ("iommu/arm-smmu-v3: Add in-kernel
support for NVIDIA Tegra241 (Grace) CMDQV") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61f0d437988e5730b04442f6a7d30a9907339f2a]
stable/6.12: [076a4f5b1fc2016b973a12bc2ebb9b730e5e1e48]
stable/6.18: [735698e81f798b4c02dcb6291ffbdd1b962c8c66]
stable/7.2: [421f5ab135cd4a1353891e5bf2602cfc3c01afc7]

CVE-2026-90427: iommu/tegra241-cmdqv: Don't fall back to a freed smmu
after devm_krealloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90427

Introduced by commit 918eb5c ("iommu/arm-smmu-v3: Add in-kernel
support for NVIDIA Tegra241 (Grace) CMDQV") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4d05f55e9da646ec03adfa77260eb46f4163749]
stable/7.2: [86197679b293f0601c3331d545f99a70a7780aa9]

CVE-2026-90428: iommu/tegra241-cmdqv: Don't run the error ISR before
probe sets up vintfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90428

Introduced by commit 918eb5c ("iommu/arm-smmu-v3: Add in-kernel
support for NVIDIA Tegra241 (Grace) CMDQV") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5acd67ceb38debe2fbf70ea35e2dec9f7ab01bbd]
stable/6.12: [b1605a56745f22670205f6561df5771bbbb62a99]
stable/6.18: [2f627118b668659c6b195ac48beedb1bf8f53368]
stable/7.2: [a168254ff8db08f2292be3d8fcbd37d2bb8c3d2d]

CVE-2026-90429: iommu/tegra241-cmdqv: Synchronize the error ISR
against VINTF (de)init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90429

Introduced by commit 4dc0d12 ("iommu/tegra241-cmdqv: Add user-space
use support") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a491be376abd1c80a314cdd658632c85cd660b73]
stable/6.18: [bcb82407633c3008362ad927699d985ee4981557]
stable/7.2: [f3ef4abc271a1d3d7b6715879e149c286dc8aae7]

CVE-2026-90430: iommu/tegra241-cmdqv: Publish an LVCMDQ only after it
is fully initialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90430

Introduced by commit 918eb5c ("iommu/arm-smmu-v3: Add in-kernel
support for NVIDIA Tegra241 (Grace) CMDQV") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbc41aacd49e695338940196e7084770365e1b68]
stable/6.12: [d5ec248ee1c79354979c23f7f390e856e9535651]
stable/6.18: [792f720fc23fe5bd6508d40ed73ae739debd6dcb]
stable/7.2: [b4535b403d6bf9bcc24dbd62096711329b9c612c]

CVE-2026-90431: remoteproc: Prevent crash handling to race with rproc_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90431

Introduced by commit 8afd519 ("remoteproc: add rproc_report_crash
function to notify rproc crashes") in v3.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74ee3b2f5767447c57959994341e5b95f1079977]
stable/5.10: [50f232c26298923d39a48dc8e03d1732e5a5dcf1]
stable/5.15: [69af36f1fb7d24d287662fef6b2093bcf847a9db]
stable/6.1: [a8a62cb4d2f3fd6aa06e86f1711c62d2a4cf17d5]
stable/6.12: [a31d9562eeec5c4103c202fc87651f6e7d3d0035]
stable/6.18: [f15cde11298402f803d5dda9cb9f95eea3d2ca40]
stable/6.6: [47de033918cd772146f7438aa04471c020b2dedc]
stable/7.2: [61862ed651b2493573e6d2192d5640bc6616f5d0]

CVE-2026-90432: sched_ext: Abort directly from the hardlockup handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90432

Introduced by commit bd2d764 ("sched_ext: Defer scx_hardlockup() out
of NMI") in v7.1-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c4b38064937a761ebbf85b1649e812db85eb59e]
stable/7.2: [4d6270bbb4e083a4d2d39f3c36f30f5c939c06ed]

CVE-2026-90433: spi: oc-tiny: switch to managed controller allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90433

Introduced by commit ce79258 ("spi: add OpenCores tiny SPI driver") in
v2.6.39-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d710f43ce30975d197f73c543bfe47b958d8ba17]
stable/6.12: [0260c94453a08491640e61f8cf0c384edbe7bd11]
stable/6.18: [ef5cc4a8c088d05549f71950a72b5deff5000fd7]
stable/7.2: [1cd16c8d68f58e54abb8f331d05469237200631f]

CVE-2026-90434: isofs: release zisofs block pointer buffer head

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90434

Introduced by commit 59bc055 ("zisofs: Implement reading of compressed
files when PAGE_CACHE_SIZE > compress block size") in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f7dd9b86fe4076059e6a4a2a2c5d565afd76b9e]
stable/5.10: [dbcc7d1b818162aeab2e97fd217d86546d9fde15]
stable/5.15: [ec33e6b7a1de20d7e623b12633191a855445657d]
stable/6.1: [0c2c54a7d174edc845f7bae24179fe72a926d10f]
stable/6.12: [f2a1611065c700a374b31c5cc8a7587f5e3bfe73]
stable/6.18: [106e1a3b2b3454fbda63a59e9290cb9a253f81aa]
stable/6.6: [5677737c2cedf417c0fcf61540b9cef0e62273d4]
stable/7.2: [3371d30a97a257b7b5f2c8009612e9d452180f0a]

CVE-2026-90435: RDMA/mlx5: Fix integer overflow of user QP buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-90435

Introduced by commit e126ba9 ("mlx5: Add driver for Mellanox
Connect-IB adapters") in v3.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dec47e4b0fe34afdf38caa72b4408ba95502e5de]
stable/5.10: [ccce6b7ef1d7efc59ccba3421e1339c6e63a3d20]
stable/5.15: [d99622e40aaa910ade681dfd4dc0fa240a011331]
stable/6.1: [c845e5e05140ea1bc64a5b1107942d93c876034d]
stable/6.12: [d7fa2ff72ad1861eac194a4e0075d504ba8c246e]
stable/6.18: [5b6cfc6d7ff0959dd9766fdc24286a253b59ca77]
stable/6.6: [42fb8aefffff5b458aaa66803364a16e0ea44129]
stable/7.2: [f917707f0de0832b8ab582391b1f64e549995c6c]

CVE-2026-92476: crypto: keembay - Initialize completion before requesting IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92476

Introduced by commit 8857433 ("crypto: keembay - Add support for Keem
Bay OCS AES/SM4") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fce20289dd622cc7ab78d72c8a979a9f8b7cb10e]
stable/5.15: [a3ffced8be1555f283680065c3b87a19f5ab9097]
stable/6.1: [4ce407055ae9d37f46a3c6f05eb27198b354d287]
stable/6.12: [f8970ee9e315c9e2258ae8914d5fb32b1039d2f6]
stable/6.18: [7efb51a5893b22003a679d088b7794be2ccd6c32]
stable/6.6: [d52a15c4559b69805bc69bf4ad9e16bbf6480d52]
stable/7.2: [5aae80dcec0748b4ed61daace2ad8b12082261f2]

CVE-2026-92477: scsi: ufs: debugfs: Reserve space for a string terminator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92477

Introduced by commit 7340faa ("scsi: ufs: core: Add debugfs attributes
for triggering the UFS EH") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abd26e6b53c4169122d61fdd4cabe09bdd916aac]
stable/6.1: [b43890843e834300f967c69e74c7c2eb22cb1664]
stable/6.12: [d223989e1a1edad217b673486b093bd157fb6c9a]
stable/6.18: [cc92af8cc0e4dacd4375d34475141b0f1a70c09e]
stable/6.6: [587be18e0935632ebd367b0f89e37aa5762e400f]
stable/7.2: [2b3fb5693c25c21741f357a8c9d0e1f19b7e368f]

CVE-2026-92478: scsi: ufs: core: Validate connected lane counts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92478

Introduced by commit 03e5d38 ("scsi: ufs: core: Add support for TX
Equalization") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e6dd452f1affb5c412ca64bf5809ce9fde3174d]
stable/7.2: [4b62f73836f4d037c9afd20c4c6084e4d44b3a57]

CVE-2026-92479: scsi: ufs: Avoid NULL CQE dereference when reporting
invalid tags

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92479

Introduced by commit 22089c2 ("scsi: ufs: core: Optimize the hot
path") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [331bda797e6afc143127ce72b1469d73316f49b4]
stable/7.2: [a769095d1d74ebac2b1474c56bbd29bb0b9ed5a7]

CVE-2026-92480: scsi: ufs: core: Validate string descriptors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92480

Introduced by commit 4b828fe ("scsi: ufs: revamp string descriptor
reading") in v5.4-rc1.
Introduced by commit d794b49 ("scsi: ufs: core: fix incorrect buffer
duplication in ufshcd_read_string_desc()") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [d96e83d028d7d8762e424e49c671d49ac2ecf14f]
stable/7.2: [66da25277256b6bf4c3fdbf3c9bfd43324c9cf25]

CVE-2026-92481: pinctrl: mediatek: free EINT resources on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92481

Introduced by commit e46df23 ("pinctrl: mediatek: refactor EINT
related code for all MediaTek pinctrl can fit") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88292b7103d260e3e606eb3bb2794060a5fde48e]
stable/6.1: [23252bc1cd9a58a039c9b1ae77b22d2b33da48e9]
stable/6.12: [51552c8c60d3b1fecc062eab2d8cfeaa1cb339dd]
stable/6.18: [7f6d898179ca4771ee602bdad4246c3952af83eb]
stable/6.6: [903a7cdf63a81d3738594c5bd1b5955f58fda427]
stable/7.2: [e06785cba7f86d72abd531058b1a82d6952a7346]

CVE-2026-92482: pinctrl: mediatek: use devm_gpiochip_add_data() for GPIO chip

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92482

Introduced by commit a6df410 ("pinctrl: mediatek: Add Pinctrl/GPIO
driver for mt8135.") in v4.1-rc1.
Introduced by commit 8052509 ("pinctrl: mediatek: add pinctrl-paris
that implements the vendor dt-bindings") in v4.20-rc1.
Introduced by commit e78d57b ("pinctrl: mediatek: add pinctrl-moore
that implements the generic pinctrl dt-bindings") in v4.20-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c650317ba553d297f3fc5f0ae40ec53d86f9dab]
stable/7.2: [b8fa1098ee9f627d38bdf7c0ef6c1a6058a4165b]

CVE-2026-92483: liveupdate: Remember FLB retrieve() status

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92483

Introduced by commit cab056f ("liveupdate: luo_flb: introduce
File-Lifecycle-Bound global state") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c4a03afcb21783987ffc64562b76ddd5a21b12b]
stable/7.2: [908f3ea3f050b865c5c2d8c1da566185a4a3efc0]

CVE-2026-92484: cxl/region: Fix use-after-free in find_pos_and_ways() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92484

Introduced by commit d90acdf ("cxl/region: Add a dev_err() on missing
target list entries") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [15da704b732332cc1e8f121f624e5e6c05124c5d]
stable/6.12: [b38ca9ce8c7d9b8151bb9e4770404c5e39600a48]
stable/6.18: [f54b96e8aadbfc7f2a1b26df349ef9b062c47d2e]
stable/6.6: [68edf359b0b45cad2654510c1ca257079b241aa5]
stable/7.2: [8f7683ce37a53eeabd721941517341d2eef2cf3c]

CVE-2026-92485: bpf: Fix WARNING in bpf_tracing_link_release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92485

Introduced by commit 2b5dcb3 ("bpf, x64: Fix tailcall infinite loop")
in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [61aaa8782bec59ecffd22e030f54ef9351bcabf9]
stable/7.2: [48a0209d8da0d90a7b0a0db19d1ff88027b13781]

CVE-2026-92486: bpf: Fix CFI mismatch in task work callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92486

Introduced by commit 38aa700 ("bpf: task work scheduling kfuncs") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2805abd089576799b15092949420e3f8ba97fabd]
stable/6.18: [85a33c910edc3651f68b17ae3c597c012545958f]
stable/7.2: [a2cbab47f44e9ea8c5a161ecba1b6bb8535771eb]

CVE-2026-92487: exfat: fix valid_size extension over a shared writable mapping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92487

Introduced by commit 82a81a7 ("exfat: add iomap buffered I/O support")
in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1135704ed22f54873eb0498a232611d9eca30dd4]
stable/7.2: [24f20986b253c3e4eb13ebe3c2007d1d352408a6]

CVE-2026-92488: RDMA/erdma: complete object teardown when the destroy
command fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92488

Introduced by commit 1550557 ("RDMA/erdma: Add verbs implementation")
in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [652befcba956ef357f480525ccbe25c59bc81d4d]
stable/6.12: [5fcfc988ecf3e2bbe308b95c2c0d2f011d9afabe]
stable/6.18: [ce7d205c264665517c25e8a3231cf2d0c2443e3c]
stable/7.2: [334145d683ad3e31d052247f10807f2ebc950351]

CVE-2026-92489: xfrm: Fix skb double-free in xfrm_dev_direct_output()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92489

Introduced by commit 5eddd76 ("xfrm: fix tunnel mode TX datapath in
packet offload mode") in v6.14.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [2aed51fc58d9ce450e2c116efb956160fd06fa02]
stable/6.12: [bc9297796bfdcc8d9609236e54519a4f38737aac]
stable/6.18: [02deb637e965950148752a304dd1471212dd6470]
stable/6.6: [621871b696b108026bf4b44ed4085ffa2102f417]
stable/7.2: [56a347950e661c1a7f8f31c43a2ea53c2323b6f4]

CVE-2026-92490: firmware: arm_scmi: Unrequest devices if driver
registration fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92490

Introduced by commit d3cd7c5 ("firmware: arm_scmi: Refactor protocol
device creation") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f7cd6a62aa754ed6b48cbd5d50de40add1bcc86]
stable/6.12: [06e65e07a1bcb39a1ebc8bb89a981f8e07900497]
stable/6.18: [a76b20b1f03099204db29b90e1024fe1c2b2cdd7]
stable/6.6: [524e57035af2d32498af9dd8fa6fdc92fcc8f80a]
stable/7.2: [4520d4a1db37198756ad23568e36cdf091b6ffff]

CVE-2026-92491: firmware: arm_scmi: Roll back partial protocol table
registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92491

Introduced by commit 2858f6e ("firmware: arm_scmi: Add multiple
protocols registration support") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [2224b622260ba590ab56ea1585d6bf7610be25b2]
stable/6.12: [3fa8cabd2d8ed80dd0b818ca7fd410b591392ff6]
stable/6.18: [456856a34906475fcf4b23879237103770dc7ef2]
stable/6.6: [ee556d118b11c6f5b60a32c1e84f366b336ac7d7]
stable/7.2: [826413b858ea2969e4c3e8197d0065efc47c6343]

CVE-2026-92492: cpufreq/amd-pstate: handle missing policy in dynamic
EPP callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92492

Introduced by commit e30ca6d ("cpufreq/amd-pstate: Add dynamic energy
performance preference") in v7.1-rc1.
Introduced by commit 798c475 ("cpufreq/amd-pstate: Add support for
platform profile class") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [39c0cf62fc7851a17782e7efe8dfb2948739c681]
stable/6.18: [70c8c8b50d80f681f50ddcc66a9400dd87508913]
stable/7.2: [f4ade8d224756ab69f108204dde6777bac4664e4]

CVE-2026-92493: cpufreq: amd-pstate-ut: Skip tests when amd-pstate
driver is not active

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92493

Introduced by commit 14eb1c9 ("cpufreq: amd-pstate: Add test module
for amd-pstate driver") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d31bb1451643f328db0cea0e21e63ef54b4faf2]
stable/6.18: [baf5a7fd3f3e2f4297b42b249f4f4f63214f44c0]
stable/7.2: [ba6ce23d17db3d114adf13909a9002f1eedcf183]

CVE-2026-92494: ext4: fix buffer_head leak in ext4_init_orphan_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92494

Introduced by commit 02f310f ("ext4: Speedup ext4 orphan inode
handling") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05704335803b69c1bfa8637b7ada942bf2ee8a41]
stable/5.15: [a9a6ec1298f9bc134b2c5db27d25bb10603b7113]
stable/6.1: [35fc83c65faf7949f5701bb34b20f822560a7718]
stable/6.12: [6ec53ccab0d691b3c73e03d930343ca45987e88d]
stable/6.18: [1399f102d8a1855c1a38506057306ec79d0787d9]
stable/6.6: [74637f7fef030e5fb2e835b7dfeb05efdc48e0fe]
stable/7.2: [e1e342d9a561c016b8531ec1f4dcefaad9d64954]

CVE-2026-92495: RDMA/bnxt_re: Clear VM_MAYWRITE on DBR/toggle page mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92495

Introduced by commit ea22248 ("RDMA/bnxt_re: Update alloc_page uapi
for pacing") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b66c9af7172ffcf727214fa0ebe9a5e1ed6eb16]
stable/6.12: [13e7861809ef9e7e720ff5f0af1d4293a6d0a9b4]
stable/6.18: [0afbfe019c881483337d9f8304e678af05ebe7cc]
stable/6.6: [5361fb1e5bc246f9a2c0721543f72c8dac200769]
stable/7.2: [518df61b9b0a5b288dfa72c87246045329c18b8c]

CVE-2026-92496: wifi: ath11k: Avoid buffer overread in ath11k_wmi_tlv_op_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92496

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ef9dd30058cc9223c72f711dca1a28a5947d0c5]
stable/5.10: [20166fd9a4ad15d7eccc63c9dc99680aea6558ef]
stable/5.15: [71690d26c1415e816158b45ee354367244c50d4c]
stable/6.1: [f9726f6d97dca94ab14739c8b632301a940a7e8f]
stable/6.12: [9652e7e23137538169f60323300cae3413475685]
stable/6.18: [72a5e45f606ec454ef556a68ffd92e06b0677f44]
stable/6.6: [2677fc48dd10dc08cdec99c2692d50fe5f48dcbf]
stable/7.2: [9ddbc95dac167e3f2d0e3859e6ce022ae0184fc1]

CVE-2026-92497: wifi: ath12k: Avoid buffer overread in ath12k_wmi_op_rx()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92497

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7698656a2f7b045af5a6859766238cefea1b1945]
stable/6.12: [07659388110de004cbb753f3c7bc85e657e51f7a]
stable/6.18: [95d1bd1db9e9d8eccffc880166e01c4775115716]
stable/6.6: [9784faa6afd26693287e8e4569bdedee00212909]
stable/7.2: [9e6ec0977f0b9c16fc20efea050e3eea8f66e34b]

CVE-2026-92498: wifi: ath6kl: avoid buffer overreads in WMI event handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92498

Introduced by commit bdcd817 ("Add ath6kl cleaned up driver") in v3.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f57314aade9d74d30f3360ec5ef85a83654748be]
stable/5.10: [144fe0b0fa8f311ebe29ef16c8239bf6a24addc0]
stable/5.15: [a2de3fb4f83a525e95a86a683f0ff105b9b5785b]
stable/6.1: [d1d2ac5f5b1609a05c455d0aed12904b0985530d]
stable/6.12: [41159d392c3adedc093a8d80521037b72350f606]
stable/6.18: [abda58f4529d7eebb6ef82e2d266dabc17507faa]
stable/6.6: [ea2a77682f9f984bc9a45a00b7d1aa198503c2fe]
stable/7.2: [2f3635213ecf52ff943f01645f895cb39db8f0dc]

CVE-2026-92499: ext4: validate readdir offset before accessing dirent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92499

Introduced by commit ac27a0e ("[PATCH] ext4: initial copy of files
from ext3") in v2.6.20.16.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc4b7b0414c33b2c8898eb04386df0d21a13dad8]
stable/6.18: [64d445d40e5ea4c4d4d88880db753b370cb69161]
stable/7.2: [b4c728577933753180e3e97f08424d5bcaff705e]

CVE-2026-92500: ext4: use fsdata to track inline data write state and fix race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92500

Introduced by commit 3fdcfb6 ("ext4: add journalled write support for
inline data") in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7edbb323bab2b2a609016014caafdb651c898249]
stable/6.18: [bd8d74bd46d09905164255b8635fa58b45f41068]
stable/7.2: [439aedfd7ae868d1d7b4930afe66091cb979cd5c]

CVE-2026-92501: ext4: drain in-flight DIO before buffered write fallback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92501

Introduced by commit 378f32b ("ext4: introduce direct I/O write using
iomap infrastructure") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15cdefd0c0522f9d5e12d947fa04f4c11649b699]
stable/5.10: [fd7e0dab20837b9ea1eeef7c26f78ace8ac8258c]
stable/5.15: [f0af3ae09fb72382da1a5371bf6761b0264668e4]
stable/6.1: [7341e234927ff215f1d5d0bcfe04b74f53af378d]
stable/6.12: [d47cdadd6e49023f7ee248048463807f1214f1ee]
stable/6.18: [4e4e3eec506247c8f8bd8aaa1eb25e67016681a5]
stable/6.6: [74eee4ff9698a65b2e6e15dac0e50d6526ad5f20]
stable/7.2: [9fd3ffc3c51c9deaba99bd7b338fff2d08f52416]

CVE-2026-92502: ext4: clear stale xarray tags on folios skipped during writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92502

Introduced by commit dff4ac7 ("ext4: move keep_towrite handling to
ext4_bio_write_page()") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec524aae479b4b2078c47492b90ec21200bce434]
stable/6.12: [a450ab88bfd57b227d72c7a3faad54d16c3fc099]
stable/6.18: [aa0042630b1f7cab735b0a168539281198822586]
stable/6.6: [f82a4929d0ef7ddf254c1c295ec1dfd24094f2de]
stable/7.2: [43ae387c3ae6a11227d096669ddf883e27a39a11]

CVE-2026-92503: ext4: fix ABBA deadlock in ext4_xattr_inode_cache_find()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92503

Introduced by commit 0a46ef2 ("ext4: do not create EA inode under
buffer lock") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [03438084a7b8621fb5c762dd3d04cff5f2630fb2]
stable/7.2: [7720fddd1fe344d14be258a2028f74ebf1569511]

CVE-2026-92504: thermal: intel: int3400: clean up ODVP on probe failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92504

Introduced by commit 006f006 ("thermal/int340x_thermal: Export OEM
vendor variables") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d83dc9ce57a746a6dca28439bcc0575d26fa6986]
stable/5.10: [5798c714fccf1b4939a98a812b9073da365172c8]
stable/5.15: [bfd6df12ce6781e4bf1c7177dab42a8780177960]
stable/6.1: [ad13e550ce51c66560bafd315eb5d09f2ee7c4ce]
stable/6.12: [bc0e96267a6715fcc4b81cf980034a5e65703780]
stable/6.18: [d7b025d3fdf3cf8b726ce1d13f434f57477972bb]
stable/6.6: [08df725b927512fa9672b146a00766da478b6c2e]
stable/7.2: [169772cd2147c517be5cfda2710d17f8c90d6f10]

CVE-2026-92505: iommu/amd: Fix undefined behavior in devid_write
debugfs function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92505

Introduced by commit 2e98940 ("iommu/amd: Add support for device id
user input") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [843e149989665f8309ad2efe6048dc76591e1f94]
stable/6.18: [8aabe0fba01486b5d893e708b05a8fa7f1b7efbb]
stable/7.2: [99d42aef089a07cfb1d404a7227ac9dc7628b497]

CVE-2026-92506: firmware: arm_scmi: Fix requested device removal race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92506

Introduced by commit d3cd7c5 ("firmware: arm_scmi: Refactor protocol
device creation") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c4097e6c4aed276c5e9ec2ab331ab397ea780bf]
stable/6.12: [1c35915eaaa81a12340c838c5c2ccb02be2194c3]
stable/6.18: [c3d4ef1c0ca6917aad6f1093b49f3932944a8c19]
stable/6.6: [2ff7713b7308cd6bea3328f7cd750b5eaab42af3]
stable/7.2: [21d35c5f46e99e9047bb9ded3ecb5ab440dd75b3]

CVE-2026-92507: RDMA/core: Fix potential use after free in ib_dealloc_pd_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92507

Introduced by commit 91a7c58 ("RDMA: Restore ability to fail on PD
deallocate") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b90e701342275f414e36e7421c502237df241ad]
stable/6.1: [df0e9efe61ca706a07b1c9bf93fcb9032455efc4]
stable/6.12: [d9c0daf9362aad2aeed1d9c5536d108772a8d31c]
stable/6.18: [66d65f36d39759e9f62dc746dc71d862f20f827f]
stable/6.6: [7647363fa02046da681acc3c827d9f301c06e0e7]
stable/7.2: [c06f2856a1d7e75a5ff247fc05224aa2452e7265]

CVE-2026-92508: RDMA/core: Fix potential use after free in ib_free_cq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92508

Introduced by commit 43d781b ("RDMA: Allow fail of destroy CQ") in v5.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29dc2f8e1c97372c2871a70088707933515fbd5b]
stable/5.15: [a804b162f9bc2b38b2ed1b4752eea9faadb1645b]
stable/6.1: [91f8a17a22ab615a03743120e19935e731f28fb9]
stable/6.12: [b8dcca427096fc9c50f1b376847fea72bc842d31]
stable/6.18: [9abea37942534eeb049335476178696b654b000c]
stable/6.6: [76f2cb4f721815c3b6262a6dc2151de88646924c]
stable/7.2: [43403fe45379c64fa6276e5a8ede44493e5d2d3d]

CVE-2026-92509: RDMA/core: Fix potential use after free in counter_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92509

Introduced by commit 99fa331 ("RDMA/counter: Add "auto" configuration
mode support") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [235ef2d0e750885c29340b0fc40620a7a4f52e12]
stable/6.1: [5eb0c57a8b568eb08f464861d84d518a2af939ac]
stable/6.12: [2f0c6705e26ba92c0c6b0b0908a2d3f35a039d5b]
stable/6.18: [8c013e3a8d8273da4d47bf1c27f016a3551996f5]
stable/6.6: [d5cc211e8c39e46f357d30a092d683e84d560de9]
stable/7.2: [64c72390d8407ea86de712a477c796b07d37abc4]

CVE-2026-92510: RDMA/core: Fix potential use after free in ib_destroy_srq_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92510

Introduced by commit 48f8a70 ("RDMA/restrack: Add support to get
resource tracking for SRQ") in v5.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88244ecc71cc0b3ed200f5ef7ddea6686adfd730]
stable/6.1: [a5bfd9fe05d5cebbd3e447bf7f7b2c663007d8b9]
stable/6.12: [9c704383529044c02122f85a2a9a42cbf14a07a6]
stable/6.18: [bedd7dee72588c838f5b67197ea8b387e7beb918]
stable/6.6: [d3d0eabe6e39b024deb3e085e2d408d037e967c3]
stable/7.2: [95c992c869df54a6a7061f5f3fb6400244f2af8f]

CVE-2026-92511: RDMA/core: Fix potential use after free in ib_destroy_cq_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92511

Introduced by commit 08f294a ("RDMA/core: Add resource tracking for
create and destroy CQs") in v4.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3481bec4dfc4aee24ffea5a547ee95b70b67d9d5]
stable/6.1: [42f7a0c7a94003059540cce448acabfa62ad119d]
stable/6.12: [b85a148731eceffacb6a030950187d785175607f]
stable/6.18: [197c262dbf94c0f7ab7ac54b66f892ce9f343232]
stable/6.6: [253c2ed71a532c70fa0e64317ceb02bb1a50c84c]
stable/7.2: [8a72a6aad84b3928dbb5e564bff1f56a7ec222ae]

CVE-2026-92512: RDMA/core: Fix use after free in ib_query_qp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92512

Introduced by commit 514aee6 ("RDMA: Globally allocate and release QP
memory") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [709ba0e5311bd034eb4d9c1c00cc4e1109d6dc3e]
stable/6.1: [2ef2ea52ae41bd9efa83139e97ae839de7e17156]
stable/6.12: [8998829739c31fdbc892078e4449887d902e5dc9]
stable/6.18: [038cf231b7099ba6202dcc0c1ea01525122df09f]
stable/6.6: [a608af8cde3dd38936b356bbdeedea0653a05b3f]
stable/7.2: [001383248e5d754bbddb7ae2a8573bc8501c85d8]

CVE-2026-92513: RDMA/mana_ib: drain QP references after partial table insertion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92513

Introduced by commit 8001e92 ("RDMA/mana_ib: extend mana QP table") in
v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97f7c2262c28ebcae64fc957ee978646684a5ed9]
stable/6.18: [4aaa2ab816c710be7385b31d08373edcdcd71656]
stable/7.2: [638b9a5364c1482e5d104823c1a3884b3d249484]

CVE-2026-92514: RDMA/erdma: Fix CEQ tasklet use-after-free on removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92514

Introduced by commit f2a0a63 ("RDMA/erdma: Add event queue
implementation") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ca79979384f031d710c4b3bae065dcb5d95aca3]
stable/6.1: [0e8b78dabb1f156db05ffe74c6eae861167c7c21]
stable/6.12: [f738c0a372d36a10dfae6dc357717c13b2aa72f4]
stable/6.18: [a60c36d8d17f1b86705523d5eb6d290df28831e5]
stable/6.6: [6e129c1310abfa786a510cc63e69c5ef12349048]
stable/7.2: [61a25b8d333e1eb2a189881d516f8d5194e26840]

CVE-2026-92515: bpf: Preserve unique-field state across nested structs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92515

Introduced by commit 64e8ee8 ("bpf: look into the types of the fields
of a struct type recursively.") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f08619f060468076e4acbdc10e0713af20d60e65]
stable/6.12: [cec97102d4147e18568c93946014c4c8ebf86fcf]
stable/6.18: [28d5f20ed022ade0fb0bfbf50b78fec782083175]
stable/7.2: [373a1e9366e711b89bc5e45bd6edf33ef62402cd]

CVE-2026-92516: bpf: Fix offset warn check for bpf_res_spin_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92516

Introduced by commit 0de2046 ("bpf: Implement verifier support for
rqspinlock") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04e19012efaec2bfd8c3b37fd8a6c3f1fe731ffc]
stable/6.18: [dfdce1f20a7e5e826165c556fd3367c65387e966]
stable/7.2: [92356df4aa2b044b62bc7e45e0d99231af147f29]

CVE-2026-92517: bpf, riscv: Fix extable handling for arena load_acquire

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92517

Introduced by commit fb7cefa ("riscv, bpf: Add support arena atomics
for RV64") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eb8921371c6fd117d4a328b6053dfda38707df8]
stable/6.18: [26d9496c826586338d1b8c27edfec4a19a89f462]
stable/7.2: [08fe2eaa609180c1baeb76c2629a9c82263b0427]

CVE-2026-92518: riscv, bpf: Fix kernel stack corruption in tailcall with CFI

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92518

Introduced by commit 30a59cc ("riscv, bpf: Fix possible infinite
tailcall when CONFIG_CFI_CLANG is enabled") in v6.12-rc4.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52fb1756ea1d2759dfef2d86245be00b05dac3a2]
stable/6.18: [34b1bb33a025787e05f966e74de18cd36276f801]
stable/7.2: [a6e11a81da3420fd37f1518d4f238c4d5784086e]

CVE-2026-92519: riscv, bpf: Fix memory leak in bpf_jit_free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92519

Introduced by commit 48a8f78 ("bpf, riscv: use prog pack allocator in
the BPF JIT") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [369e4635d04801f394d5bd42556f21029e95ff93]
stable/6.12: [b594c23f584ab032a5eae809eee81b809dd27330]
stable/6.18: [5cadc66b534fe8140441916200a20c7efb06a388]
stable/7.2: [2a3a29e90021806ea00527f6458cfd2edb58b42a]

CVE-2026-92520: bpf: Zero queue and stack outputs on lock failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92520

Introduced by commit a34a9f1 ("bpf: Avoid deadlock when using queue
and stack maps from NMI") in v6.6-rc3.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [7ac6e1ae41a09f1dd4baeeff1d028ae49ee01232]
stable/6.18: [1534c4bff3aaca19c4c9a82f93e9b81f7c983de3]
stable/7.2: [e2396b8a562073787e627a5f483f1bc5c452fa6a]

CVE-2026-92521: ACPI: PCI: Clear driver_data on all paths that free
the acpi_pci_root

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92521

Introduced by commit db89b4f ("ACPI: catch calls of acpi_driver_data
on pointer of wrong type") in v2.6.28-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a742141f7ab84975aa758b775567ef4740ef0cf]
stable/5.10: [321bb0eb1486a0d575f02e24e3f4170e408c2f51]
stable/5.15: [3c1e8a14f9d06c1ed6f3e4bd2d283a62079109e2]
stable/6.1: [a285fa3780c768dcc51c76768707d099a2cc611d]
stable/6.12: [70cf773cca30a10b4964c24520a71279c974b899]
stable/6.18: [3eee4c21931dc048ce63b86809f04e4e6f0dcad5]
stable/6.6: [6aaf6dbf54fdfae096f3f90a79e9614e46579280]
stable/7.2: [6e11ac626f9f9fc3a2ed27dfa44ccbe5fb762217]

CVE-2026-92522: ACPI: processor: validate MADT IOAPIC entry bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92522

Introduced by commit ecf5636 ("ACPI: Add interfaces to parse IOAPIC ID
for IOAPIC hotplug") in v4.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c50ffdc73f3a70d745d249f509fc290754121e6]
stable/5.10: [5601bd81bc290a724ed47797d22c16cba4d7ed9f]
stable/5.15: [ff82e3374e9103d046b2a82f4315d9a422ff097d]
stable/6.1: [2a5520065e76000f8c979d3d7b3d861ccaaecf1e]
stable/6.12: [74d84320f8e37955eb286a7777843d554e6e75b2]
stable/6.18: [4d8ecaa332c163f2b44aa5027bf061950b71b5f3]
stable/6.6: [8e67b58c04990817ac2dbf8ae03353be6a358cd4]
stable/7.2: [355bee5f11acb116cd256588631b4028ca562646]

CVE-2026-92523: RDMA/nldev: validate dynamic counter attribute length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92523

Introduced by commit 3c3c1f1 ("RDMA/nldev: Allow optional-counter
status configuration through RDMA netlink") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74f49255492a62658f36bf2578d7916f1c6ffad1]
stable/6.1: [7828d68ae8cad3463e38def5c91668c84e722596]
stable/6.12: [d00b0d808ca706a04bd198827319a4a287eff82a]
stable/6.18: [0bfa897e3e1a61d172f95675b353168bc9290312]
stable/6.6: [f8e9315236c8b5155158c6955a758e7960b143e6]
stable/7.2: [c57e238b475e8e1e514499772b8c0db5768be93f]

CVE-2026-92524: irqchip/gic-v3-its: Prevent leak in its_vpe_irq_domain_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92524

Introduced by commit 7d75bbb ("irqchip/gic-v3-its: Add VPE irq domain
allocation/teardown") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [325ff3e78c64cd619d52b99f7c8b09a3f31e1495]
stable/5.10: [82bccf7f9a12bf0eec9774968f6a853020ea26d3]
stable/5.15: [6cd7e9b5463e1bceddcaf4acec6ca0f12553455b]
stable/6.1: [05c199d6b806ed1cc64807062f9986f11315e8ab]
stable/6.12: [0d1951a1935a11c197272dbd38349033f0ef8991]
stable/6.18: [6eb1f1414bf70185dad2525ecac5411db551faa2]
stable/6.6: [c4643bcb3bdda96b7292d6ab6ed196755a5bc304]
stable/7.2: [d324c4353f64190a032c78d6e07be6d57ddfb2f1]

CVE-2026-92525: RDMA/rxe: Validate num_sge/cur_sge before indexing
wqe->dma.sge[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-92525

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [126c757e4cd46f866ddc283143b58eb4d9bf52cd]
stable/6.1: [69d3ccf6543f24c452a020c8028ca6f46cb1e8db]
stable/6.12: [c067aa7b231e91a18a1b3666201ab14dfb00347a]
stable/6.18: [13cb7160e5b791f5e3ecf9311cf32849fe7e9b62]
stable/6.6: [750bba6ce9bb0b11d6a166031c9728ae3f21765e]
stable/7.2: [5ec111ddc1f727c1e4580aea459842ae5a8359a5]

CVE-2026-93037: RDMA/hfi1: Propagate sdma_txinit_ahg() errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93037

Introduced by commit e3304b7 ("IB/hfi1: Optimize cachelines for user
SDMA request structure") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [091c6162c022cbdfb64219708a71728cfd1d4600]
stable/5.10: [cb73c2fe6e9cf563c99f22b7c8bca0d5f70d603e]
stable/5.15: [122a730675565ff2ad210537c3fc3afb8291d482]
stable/6.1: [bf974994150cfd14bfc599748925f4d426e00d90]
stable/6.12: [5b7cefffd15d87c8103865f887cdcf9077d8094b]
stable/6.18: [3416db552eb378e54cb2f2ce0db5f0df88654bda]
stable/6.6: [fd6dee13f3857259b6b2ddd28e1ed95fd94ae2f9]
stable/7.2: [ca99431820e8cac19f6a091c04da54cbe8d64f52]

CVE-2026-93038: iio: dac: ad5686: missing NULL check on match data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93038

Introduced by commit 0eb1728 ("iio: dac: ad5686: drop enum id") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [572a008526359cdac2fa935dad75e9d50a79792f]
stable/7.2: [cdaa9cb77eb67f2d4921600f6531315040888e29]

CVE-2026-93039: ASoC: meson: Keep link pointers valid on realloc failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93039

Introduced by commit 7864a79 ("ASoC: meson: add axg sound card
support") in v4.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aaa41cf974f83a6fb105422bac4e2f107150774]
stable/5.10: [de33afc57f24538186bccf4c4f6c65dd38634fd8]
stable/5.15: [1c1485343b7c1c39dab7ecb9cd16ba49fd0ce642]
stable/6.1: [8db0a0fc84e80aa9924e0833aef6cc95df94e5a7]
stable/6.12: [0b30fbe6bf7cf6499b19dd886f466e7c9e820089]
stable/6.18: [8fec16898f184e5f8f8fdd09ff1ced2bd7ffc13d]
stable/6.6: [41e92e0caa1fe3df2efaca346bfcaeb7fb9826ab]
stable/7.2: [5ed1b048527bebe4529eb6e01c34dcc5d97ba5fe]

CVE-2026-93040: dmaengine: dw-edma: Serialize channel state checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93040

Introduced by commit e63d79d ("dmaengine: Add Synopsys eDMA IP core
driver") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7d1619f3e10c619b62c6cd6d95371b5c526c85a]
stable/5.10: [be0072af8ce6e9458cc586e0e8b41a251e7d4316]
stable/5.15: [2d76b91deeab973dd8a8c2ee587ce27f881de768]
stable/6.1: [3001cfcee30dcc81f8b3774319c12067f126e49a]
stable/6.12: [da16a02f0998a0d455ce6265b836b29ad92e6e58]
stable/6.18: [fe0ffa0190e862ed71e8c1a476090f648c9cb7d9]
stable/6.6: [b6293a8a38f4d5866ce1a264c138265a02e4c53a]
stable/7.2: [6fc436e1500c5e4f0dde2a3dbadf6d898057be8f]

CVE-2026-93041: dmaengine: dw-edma: Serialize abort state updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93041

Introduced by commit e63d79d ("dmaengine: Add Synopsys eDMA IP core
driver") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd80e259f65d932634e26d366570d71669ef6654]
stable/5.10: [4a72f81b8681b2ad7705cf039974c443dcc8ff00]
stable/5.15: [b7b8b08cd6422f7ed783226ac4aa6cebe398ab54]
stable/6.1: [0b028e5175590fb34ccbd537ff5b9cd386ce5747]
stable/6.12: [e20c6539394ac8d70240b85bb5963c74a3a49789]
stable/6.18: [0c3294066c36d5980fd9c8192dcb53bb9ccd1f7b]
stable/6.6: [075de95d7a7cd8fecfb6fe1c685c9064fc6c9d76]
stable/7.2: [f71c94c1a657492e015be227d44c4198a8e7a91d]

CVE-2026-93042: dmaengine: dw-edma: Terminate all descriptors without callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93042

Introduced by commit e63d79d ("dmaengine: Add Synopsys eDMA IP core
driver") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99109a51efd28c9a661fbfb9469b023c517b31d1]
stable/6.12: [4793f9099a1cadf4e37f3a03d524af6bce88a0ea]
stable/6.18: [be87d86537de7ea6fd025f41033d2faff880973f]
stable/6.6: [65e387b95d3855aa894ac729e1778e5bcb9083cb]
stable/7.2: [f3ec6702a1d216be61f692cc0a983d6c8fb5ebf7]

CVE-2026-93043: bpf: Disallow interpreter fallback for gotox insn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93043

Introduced by commit 493d9e0 ("bpf, x86: add support for indirect
jumps") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [905f716362e1186c1a23447ca279e6d21f795cdb]
stable/7.2: [17da80d0c7b56579476b6644120bcfea778e531a]

CVE-2026-93044: bpf: Disallow interpreter fallback for arena-related insns

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93044

Introduced by commit 6082b6c ("bpf: Recognize addr_space_cast
instruction in the verifier.") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34746b5a84ec37c0ea2bf6808c65c5ed8790eb51]
stable/7.2: [408b6d3bc19c4aa852ab7ee2f447756e52e69967]

CVE-2026-93045: bpf: Reject arena frees below the arena base

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93045

Introduced by commit 3174603 ("bpf: Introduce bpf_arena.") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5a71cb2db6d84ac0042549dcec266b18429d41e]
stable/6.12: [90453eaf8f14e7be0ab03983f2a93aeb6b990a58]
stable/6.18: [a968dffa5ab3c74d2ebb3a6233bf8b843f0bfc20]
stable/7.2: [8a08635656037aee9c12231ed384449c4ffb1a93]

CVE-2026-93046: software node: Fix software_node_get_reference_args()
with index -1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93046

Introduced by commit 31e4e12 ("software node: Correct a OOB check in
software_node_get_reference_args()") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [ba3dedcf3bd47017307595a7e54924198f018246]
stable/5.10: [6cde06887487b4febd14658c9a246616abcc0097]
stable/5.15: [0631384eadebc66d92d2dd72d57a0263c3877bee]
stable/6.1: [b2fa4e8c7e4a33e02e6aaa8f6df72f84cf4aed75]
stable/6.12: [849076df15129e47dd8db751fa18489419ffea56]
stable/6.18: [df5466412b362db7adfa78e3e092fe07ac6769a4]
stable/6.6: [4ebf96d5f834aba7f6d0397db4c421f6078171b9]
stable/7.2: [231bbc04c58f115a505bf3b668ec69ef40a1773b]

CVE-2026-93047: drm/v3d: Associate BOs with every job that accesses them

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93047

Introduced by commit dffa9b7 ("drm/v3d: Add missing implicit
synchronization.") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa98563ab00dbe62fcedfef6bdd34ded7a860d9f]
stable/7.2: [7244dd0f12629484a1936dc5c5837670d8d9f80c]

CVE-2026-93048: mtd: part: reject MTDPART_OFS_RETAIN in mtd_add_partition()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93048

Introduced by commit 1a31368 ("mtd: add a flags for partitions which
should just leave smth. after them") in v3.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b759d5bb6265419344ee9729fd0dc07ad85719d8]
stable/5.10: [701c3ae7273e1adc20db5d97c42e0139b479f16b]
stable/5.15: [6aaab2ace3f7b55733d904e5549acf8405f03642]
stable/6.1: [181c1bff940e7d3e34ca485d37e3cdbfe409203c]
stable/6.12: [e204e5c49a012f99638633fdbd773e3c86260053]
stable/6.18: [398aca2f90122d5abbabff1079deaeb885fe9e40]
stable/6.6: [a536eb57be58442b19398b2783071007ecfb1735]
stable/7.2: [c645f6dd1af2ecc70fd3578e141f2f71fa9e4eff]

CVE-2026-93049: mtd: mtdswap: Avoid freeing registered blktrans device twice

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93049

Introduced by commit e8e3edb ("mtd: create per-device and module-scope
debugfs entries") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [779aa4c66a96bf43d2d62982ea1a9096a9128d87]
stable/5.10: [ecadb9137aeaa0615183f8d23eabea2b45c862f1]
stable/5.15: [eec130fc9ffbbd08a5d5432683122b79aca2a726]
stable/6.1: [d5086911d532b82ca070d944aa08ddde00baefe4]
stable/6.12: [a82d93fcfdfd26af17049c34319dfdd079cd1901]
stable/6.18: [5c349c533e72af2313c3be0f80a24d7407fa4777]
stable/6.6: [0ce48c6ddea1a8e675a2eb0221b62a9950788f3c]
stable/7.2: [37be7bc2c2d09c18e939da20224405864a0090b9]

CVE-2026-93050: ipack: ipoctal: fix UAF, null-ptr-deref, and
use-after-free in cleanup on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93050

Introduced by commit 05e5027 ("Staging: ipack: move out of staging")
in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6b5d64cb161a28347d64dc3168a636c4abb68d5]
stable/6.1: [ab5f5b27a340004b92252c6a5f23bf1c6cf3b02a]
stable/6.12: [a4613140f01bd0fb9980e2746ed9aaa65a29b5d6]
stable/6.18: [1a3258e105f711538201bdd2ac2a05b11554eabc]
stable/6.6: [c92ef8fd834521f0b788e0511976c689fe57c63c]
stable/7.2: [4a6518be316029650301f2a5e8f0def229b895d9]

CVE-2026-93051: misc: ad525x_dpot: use driver core groups for sysfs files

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93051

Introduced by commit 4eb174b ("ad525x_dpot: new driver for AD525x
digital potentiometers") in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3a8557e88eb26278eda60bf64f2ef33ce7de8bf]
stable/5.10: [1d43cef1d4ff258dee3020cc29f29fd6becfd8b9]
stable/5.15: [ddbd794e543e5f917d191f8259ce40b79c52d105]
stable/6.1: [aa3ace3f6c66811001ffa63a53fbb01ed8109312]
stable/6.12: [e30f2c23c8d5620f9679e3b6656a6eb7cb1fd38b]
stable/6.18: [c7ff7a70f405a3c6fde39ed00a36d9f4fecaf3ab]
stable/6.6: [0394902df38279da7f880021b2cfc64577a60e42]
stable/7.2: [ab2fe43041412d37f88eb368a99f63f98b31d8ea]

CVE-2026-93052: misc: bcm-vk: Use acquire/release for msgq_inited

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93052

Introduced by commit 111d746 ("misc: bcm-vk: add VK messaging
support") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61b101c6a150057b6d512421ed108aed16e822ea]
stable/5.15: [bab66a9e30e39a06f3463b19f8c704386dfd5268]
stable/6.1: [679cfada6868723ccf162ec3b78c7402ff2405bf]
stable/6.12: [1df3926ed8771edf286ff753428b243f334e6041]
stable/6.18: [a45d6dd3c11e921882a2e74c7c8710b975f2eaa7]
stable/6.6: [f7a8f4cbc8cede0be55220367dc52b126e2d39e5]
stable/7.2: [4984277bc43f84d7506346a09b29af138246d54a]

CVE-2026-93053: speakup: keyhelp: guard letter_offsets possible
out-of-range indexing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93053

Introduced by commit c6e3fd2 ("Staging: add speakup to the staging
directory") in v2.6.37-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a19ad4d68c95185308cd9e5d169b10a2cf236c8]
stable/5.10: [fd339b9ef0accb2c24a5285df842552ebf5eb146]
stable/5.15: [900cd6e5ef46bd15153762fb26bb03f874fccc52]
stable/6.1: [6b39969c724d39b6062efa354dc2d38442bfd021]
stable/6.12: [d7deb90c4cd086cb111f0ecc9da021218fbde1b0]
stable/6.18: [5310334762c3f08f51dc2414344dd47492c07d1d]
stable/6.6: [2e91ab73f9beb659f581e2a6a09f79ace1140905]
stable/7.2: [ca4489b3e54666a7cac7294e71a3cf64e5e95286]

CVE-2026-93054: uio: Fix stale info pointer in failed registration path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93054

Introduced by commit a93e7b3 ("uio: Prevent device destruction while
fds are open") in v4.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67b6fc084b034a91c3ec7907a3fed89a2450f30b]
stable/5.10: [63eaa7663335d482a8825c231213e312cacea567]
stable/5.15: [df4faf65194ec6c315a59be4c6749eaeb3009243]
stable/6.1: [506b43dde5f9ac0068b1360e6b5dbee07fda59fb]
stable/6.12: [234156f6c6d9ec35dc47abbcc3adc3c79fc6a5ac]
stable/6.18: [16695e9059d80ea6661e8399064b0c01f641dd8c]
stable/6.6: [15340b00e665af805523b08515294a1aa1778151]
stable/7.2: [ec5bd6731183eb6f619140c9bef2ee11ed818c20]

CVE-2026-93055: UDF symlink pathComponent header OOB read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93055

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d23eb7380d1594cda31a5dc8487dd2a5c8def8c7]
stable/5.10: [d9f49c8b55debf1512f912077b6c759cc8b6d2e0]
stable/5.15: [48b2a74317e15f93983c74a5a07245bc94a00d39]
stable/6.1: [f44f5f795f1a56249821a05183347ea025855e31]
stable/6.12: [ee264227b656218bc1b257d8e4f83467f5f17723]
stable/6.18: [8da8fd3df9fc14cf79ca3a3978d27ba067985111]
stable/6.6: [57371e743398e0d485f0f7beede1ade41f812324]
stable/7.2: [b21cb958292ee1e02eb305ff9de09f2f7edd551a]

CVE-2026-93056: usb: gadget: f_uac1_legacy: remove broken string
configfs attributes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93056

Introduced by commit 0854611 ("usb: gadget: f_uac1: add configfs
support") in v3.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [590d74ec8f488e06b9f1c0f8f0941f45531f3a55]
stable/5.10: [745adfe6c337f3d5d7737d57529d14a208151b45]
stable/5.15: [6351ba62778f72dc4f6bc18bfa99e618829cff0d]
stable/6.1: [021b58ac3e58cffa68ed9585ff492a19e98414f6]
stable/6.12: [8b9335aec93975bb9186d63993a5a610e5066ffc]
stable/6.18: [2ed25c9d4400cf90d9201657963a231c27a5ea57]
stable/6.6: [fd43eae7d539ea7cfc7c9f0d3f0eaa890415e8a7]
stable/7.2: [977659adb341f6e30fb00dcf183f63f29df879e2]

CVE-2026-93057: scsi: ufs: core: Avoid possible memory reclaim
deadlock in TX EQTR context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93057

Introduced by commit 03e5d38 ("scsi: ufs: core: Add support for TX
Equalization") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [760fc6f0e25a72832c2fcf37ecf5f1b770ec8374]
stable/7.2: [a28a7d9b3bb116da788ae492c90465ec1a7fa6e8]

CVE-2026-93058: drm/msm: Only fini scheduler after successful init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93058

Introduced by commit 1d8a5ca ("drm/msm: Conversion to drm scheduler")
in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2332abed2a4d3caa59052095dc16e4ce44791ea]
stable/6.18: [d43e1bbfd43458b9242806eec77ea3b032134baf]
stable/7.2: [09b360eb6ce345996a30fad8c86e9df80f41cd7e]

CVE-2026-93059: drm/msm: Fix task_struct reference leak in recover_worker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93059

Introduced by commit 25654a1 ("drm/msm: Update global fault counter
when faulty process has already ended") in v6.17-rc4.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40b793714ad8f393ab3d469f9d00b20ebda46257]
stable/6.18: [6c472fde2c8096e16bb46b0605adda2488f300c0]
stable/7.2: [d684f756d029d81db1cd64cd9645556e53fcc784]

CVE-2026-93060: drm/msm/adreno: fix use after free on error path in
a6xx_gpu_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93060

Introduced by commit d158886 ("drm/msm/adreno: Trust the SSoT UBWC
config") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8a9c9c5787bed1243e5364c89ca66c26b4e4d83]
stable/7.2: [105aaff286a153bfde3c1f5be534e6ded1f64342]

CVE-2026-93061: gpu: host1x: Avoid stack over-read in debug output helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93061

Introduced by commit 6236451 ("gpu: host1x: Add debug support") in v3.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bc17ac285fb708f22a8fa2c0ed32eceb1d37e6d6]
stable/5.10: [d7a560dc912756fd8b39b28b10818d931e863d2d]
stable/5.15: [41517c46002afd717f0f2d0975c740dd610f87fe]
stable/6.1: [ebab3a25a0403bcbc0c40ef77d69d23270e45547]
stable/6.12: [819dd96a6571f2b12496b080e5187ba3fa897232]
stable/6.18: [9ad7a6ccc7b839247663d57d3dbb4481dec492de]
stable/6.6: [4f9f0afdbdf513a49065207ff6b7e1d15051175a]
stable/7.2: [b00290d1dc23a5ef9a0d3103aad1fe2274e86569]

CVE-2026-93062: wifi: iwlwifi: guard against division by zero in
iwl_dbg_tlv_alloc_fragments

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93062

Introduced by commit 14124b2 ("iwlwifi: dbg_ini: implement monitor
allocation flow") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9318bc0c41b24705690cf80d1596cf6b711e7027]
stable/6.12: [6df26657c626b63b5a47026128cc021f66722a41]
stable/6.18: [f26f72c2448829701d7c3e840fac9d168a98a955]
stable/6.6: [11dde137f1258004bd1ed76ea2480a641e1fb753]
stable/7.2: [bc7a7ad93070879c74cdcb107ebb1a02ec212712]

CVE-2026-93063: wifi: iwlwifi: mei: check SAP message length before reading it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93063

Introduced by commit bcd68b3 ("wifi: iwlwifi: mei: fix tx DHCP packet
for devices with new Tx API") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [7d8cc301bcba233f31b589a45f4c1c97f2bb90d6]
stable/6.1: [a4034f1cc8a422cefc519290d8e6cfb7ff773586]
stable/6.12: [9c6bea89a16815688a5240dd4a74c922a92fcdc3]
stable/6.18: [242125bbf19a2974d22f3d5025c9c14c0a4aea58]
stable/6.6: [b90ebae632318dc2e5cd4ac96e454ec50f705579]
stable/7.2: [f7f770d12e6e928006f89a59291074e5fea82886]

CVE-2026-93064: wifi: iwlwifi: mvm: fix off-by-one in TXF key sanitiser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93064

Introduced by commit 12d60c1 ("iwlwifi: mvm: scrub key material in
firmware dumps") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6a6c01cbc046f68e6916a7e047a1bc881c8c9ab]
stable/6.1: [1af000d75b1c96f7cbdf23f14d0ee1c51b12f8e6]
stable/6.12: [4c582ed61325135f841ca93667d7551a8e31e58d]
stable/6.18: [c9d8641aea01c3b2516483e128e1f557cfbcf44a]
stable/6.6: [5bcc933c6d47d795dab27458b9001c2d97130fd3]
stable/7.2: [2a77cb320e3998afa5e1ed0e95908b226aae9ed6]

CVE-2026-93065: wifi: iwlwifi: fix counter type in iwl_fwrt_dump_error_logs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93065

Introduced by commit 2b69d24 ("wifi: iwlwifi: fw: print PC register
value instead of address") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [71e67b4b59337b2f9f4fef976a27de2dad7aabf2]
stable/6.12: [9710b20d09d847e07e190087b0b529673d3f1fad]
stable/6.18: [8d8a526f3ec659194f846a2cb33844d9f6cb9995]
stable/6.6: [8d74cb5fbb7a0d825403a74d18386dc7b22426a9]
stable/7.2: [769e1910d41fdd01453cef4ae032a3c162f029f8]

CVE-2026-93066: x86/mm/pat: Take cpa_lock around large-page collapse

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93066

Introduced by commit 41d8848 ("x86/mm/pat: restore large ROX pages
after fragmentation") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aac65f3e651334259ecb2a5f5ddb81c01f02599]
stable/6.18: [591b6fac9df3f43522e8ff6eed8662f8b6f1a124]
stable/7.2: [fb97d1d6c20692e15247fa5c8b894b2325e38aee]

CVE-2026-93067: drm/bridge: tc358767: clamp the reported AUX read size
to the request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93067

Introduced by commit 12dfe7c ("drm/bridge: tc358767: Use reported AUX
transfer size") in v5.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec6444a00c49e6c2b5e9a507272a28126677f9ee]
stable/5.10: [ebf00c51c9ac9188e2806a2b842418805ee879be]
stable/5.15: [424b762cc26d512e3e7421e57e41b4b55be2400b]
stable/6.1: [dd6274706bec30d005bff0587a4262d01dc2775a]
stable/6.12: [33c0b072e31dee98a754d9bd01800359dfeb9e8f]
stable/6.18: [57c567e0e8aa76f6e3e8f39d7f40c20bc37e76af]
stable/6.6: [982caa744fce79d18f2920382aaeb0da821a6e73]
stable/7.2: [9ff718df547372d70ca20ad8e66a3fb1300936b2]

CVE-2026-93068: drm/amd/display: Fix DM I2C teardown race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93068

Introduced by commit 5b3eca0 ("drm/amd/display: Use
devm_i2c_add_adapter to simplify i2c cleanup logic") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4ae30a12aa95942814957d8bc1ce7366a7107d7]
stable/6.18: [8ee385305e8902fa6fbfd66b5a112238292567b6]
stable/7.2: [6970ec944567f109ac4240f9aea58158ee8a18cd]

CVE-2026-93069: OPP: Fix cleanup ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93069

Introduced by commit 173e02d ("OPP: Initialize scope-based pointers
inline") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ce46fede7792cedd247e34b48bc8a02eb90c7848]
stable/7.2: [f0c4b7ca24d2e2618a70826881d69b237e36bcc0]

CVE-2026-93070: media: ipu6: Do not free aux device pdata after init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93070

Introduced by commit cb3117b ("media: intel/ipu6: add IPU auxiliary
devices") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9be07216af4cfc4813e1a46ce26407d31ea845de]
stable/6.12: [faa1eb97f0e66bf122f44b62be6b323f86333e9f]
stable/6.18: [5323ed5a7bb2568191ec676b2035b0396105aa05]
stable/7.2: [7d102d1f0631807a491a140f67c9628dea85dfd2]

CVE-2026-93071: media: bcm2835-unicam: Fix asc leaked in error/remove path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93071

Introduced by commit 392cd78 ("media: bcm2835-unicam: Add support for
CCP2/CSI2 camera interface") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [253c9659e25131b0169f718e7d094ac1aa0d9279]
stable/6.12: [5479372db364c80bb6bd59f640f5c31de3984bab]
stable/6.18: [2c29cd408ef86e695acb2a5d4e00fa2f5695368d]
stable/7.2: [de9be39cefda1ecd762e6a913665c01f7bb18100]

CVE-2026-93072: irqchip/renesas-irqc: Fix generic interrupt chip leak on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93072

Introduced by commit 99c221d ("irqchip/renesas-irqc: Move over to
nested generic chip") in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [616dd89d81ad9a3cf1cfff4088a4c43e4e00d6ba]
stable/6.12: [4bf7614d048434326081eef0ebef33cb77fe2ffc]
stable/6.18: [9acc996cb2e8477ae81bd7c067fec15202d6bc89]
stable/6.6: [3d39757ef791f90028da9c8b7c1fbbb497237e58]
stable/7.2: [7c614f83301d464e2fb498d63552490d137ea10d]

CVE-2026-93073: dax: read holder_ops once in dax_holder_notify_failure()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93073

Introduced by commit 8012b86 ("dax: introduce holder for dax_device")
in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ae9d15bdcde0f2955ae13b6a95587f9e23b2359]
stable/6.1: [1661b9bf78def01a8c96409569772d9b2592f4ba]
stable/6.12: [ee1251621d1c7cf3155c6704542cbb358d799968]
stable/6.18: [6a37acecc7c29136235cbc446a1b89e81414344b]
stable/6.6: [0a42180d5410c98829ee72d1d426fb7faf9e6873]
stable/7.2: [eb412f80311fc7ab6eb3203091a3fe59a5e9fd30]

CVE-2026-93074: dax/fsdev: use __va(phys) for kaddr in direct_access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93074

Introduced by commit 7594558 ("dax: Save the kva from memremap") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff7c73fca793bd5c29a15ba735b0886f62f3a840]
stable/7.2: [7b642bd3d39105eef4d5908970726c5fda291b53]

CVE-2026-93075: dax/fsdev: clear pgmap ops and owner on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93075

Introduced by commit d5406bd ("dax: add fsdev.c driver for fs-dax on
character dax") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f48884ac31b6bfc99f36b3f207b8c0cbe5d54bd7]
stable/7.2: [9b0f91dc9147a8601cec3d4d83cf13c6aaf71b27]

CVE-2026-93076: dax/fsdev: clear vmemmap_shift when binding static pgmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93076

Introduced by commit d5406bd ("dax: add fsdev.c driver for fs-dax on
character dax") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0239229931faf9ca3367e3befcf16f77b2cd45b]
stable/7.2: [d298a0513aaf7d48f2a9f4a90041de910750cfcf]

CVE-2026-93077: cxl/features: Clamp Get Feature output size to the
remaining buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93077

Introduced by commit 5e5ac21 ("cxl/mbox: Add GET_FEATURE mailbox
command") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aeb21fe557ef154f0cdf4f9745ebd8d5b31ca83]
stable/6.18: [b8abbd5c2928fd839dab702244cc57b228ab43aa]
stable/7.2: [ca95b15a0760e7724e61addbdd61050be13b6406]

CVE-2026-93078: cxl/features: Reject Set Features output buffer
smaller than the header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93078

Introduced by commit eb5dfcb ("cxl: Add support to handle user feature
commands for set feature") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cde18d6c1d913a67ab0afd3d9475ece4be79da50]
stable/6.18: [1281dc84c81577b51e2b61c24617c9f44b2cdb99]
stable/7.2: [16b7c99eff030c6ea11ca24efa4b9f989cc74093]

CVE-2026-93079: cxl/features: Reject Get Feature count larger than the
output buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93079

Introduced by commit 5908f3e ("cxl: Add support to handle user feature
commands for get feature") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4bf6bac375076ced2fa4b3fef8739bd985f93456]
stable/6.18: [3f02031a0a53de0d3ef066c92d0486b2b11be40c]
stable/7.2: [329ea475581c647a680a6937e353c1a6e2534b40]

CVE-2026-93080: firmware: arm_scmi: Fix transport device teardown lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93080

Introduced by commit 9593804 ("firmware: arm_scmi: Exclude transport
devices from bus matching") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a14dd8fe0a95db638c550ed984cfe2a7428c783d]
stable/6.18: [c656427440ea627166394d00c4b72147d5d79c60]
stable/7.2: [4635953b4c1af477e166073521a77de6279f6929]

CVE-2026-93081: firmware: arm_scmi: Fix SCMI device destroy lifetimes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93081

Introduced by commit 9ca6784 ("firmware: arm_scmi: Balance device
refcount when destroying devices") in v6.15-rc6.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [6abe8fe36b29ff51d1a42c2f338972883f4751a5]
stable/7.2: [c59b3393df1348a12308aaabd5fbc58ed6b21cf5]

CVE-2026-93082: firmware: arm_scmi: Unwind P2A receiver mailbox setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93082

Introduced by commit fa8b28b ("firmware: arm_scmi: Add support for
platform to agent channel completion") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3e3773c4e5e96549d7540d8ddeb4fcd534f6f1d]
stable/6.12: [4c2a5d72357e5c6743c23b59615da287140d9d31]
stable/6.18: [3b0b02134ab90202af80b102fa37196b9689e86f]
stable/7.2: [3515aed7fe424b79c49ff9cd51f7802a64a4ab7b]

CVE-2026-93083: firmware: arm_scmi: Unwind TX receiver mailbox setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93083

Introduced by commit 9f68ff7 ("firmware: arm_scmi: Add support for
unidirectional mailbox channels") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f7c06744d53dc8e047725d411d7f915d9ec35ae]
stable/6.12: [babb017cf5e4600c94c23ea87175a0380235a3ee]
stable/6.18: [717b8e972a667fc1bebe63cbcf0d58e692cbb491]
stable/7.2: [9958f55eace8b43713c9fc54dcf90e7cdefee413]

CVE-2026-93084: firmware: arm_scmi: Drop handle on protocol bind failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93084

Introduced by commit 971fc06 ("firmware: arm_scmi: Move handle get/set
helpers") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3a5c30d233ca5d3e799a80da806554c703bda13]
stable/6.12: [df273eced7cec550465fd1bb82a5d2c3c7d3c437]
stable/6.18: [a54dc23e8bd2246c28eafffa60b4634f0d1a11cc]
stable/6.6: [0f860db24ee95e5da4866303a35e55098b9641b3]
stable/7.2: [77d2985d1e80e67f32026fc03e975c4c83cc543d]

CVE-2026-93085: firmware: arm_scmi: Reject out of range DT protocol IDs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93085

Introduced by commit 05a2801 ("firmware: arm_scmi: Use dedicated
devices to initialize channels") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [59407ccb52130f2c81f4b3cbe4f14114afceb54f]
stable/6.12: [5142fd31bd8c9aff9bad4f6e0cc20e9574f2cee1]
stable/6.18: [e66756313d1b4eadd13f39a0aee9fc8773d4d375]
stable/6.6: [8eb2ab209570526728b35e39c4aecdb5099fbaf7]
stable/7.2: [0b6e59eb885f985a5ea7beed385adfa9412b324d]

CVE-2026-93086: firmware: arm_scmi: Avoid IDR updates while cleaning channels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93086

Introduced by commit 05a2801 ("firmware: arm_scmi: Use dedicated
devices to initialize channels") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c38b1e19485aaa820e52cfe162525a8af67563da]
stable/6.12: [431c6b872ba7fedcc5a3afb0ec3517db4d95d088]
stable/6.18: [54e5a4f7d83db4552d963d0785be32d9df680dcd]
stable/6.6: [aed24a3c63920539e9de7fbfe7929a2e7c888cd2]
stable/7.2: [bab26acebe55e8ad3ab545abda72faa7ca28c477]

CVE-2026-93089: firmware: arm_scmi: Free transport channel on IDR failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93089

Introduced by commit 05a2801 ("firmware: arm_scmi: Use dedicated
devices to initialize channels") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d72e7e5f24687c0490aabf317653caffe0447aeb]
stable/6.12: [de0a4c103740cf54cf77370d47e03c9aa51aa5ee]
stable/6.18: [d7c60c0fe2bd452b56fe07947842d64da61b7290]
stable/6.6: [ae7980c9af698d0a7e6790d49249abc71f0fc304]
stable/7.2: [fbaebd380caa4e1cec9306ca00231da6518a123f]

CVE-2026-93090: firmware: arm_scmi: Clean up channels on setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93090

Introduced by commit 05a2801 ("firmware: arm_scmi: Use dedicated
devices to initialize channels") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [687d67be3d87894ef12e8a164434612e0b53cfae]
stable/6.12: [b8479e1f0219cf18bfdfeca97994e563a0afb602]
stable/6.18: [d33b2b68bce6d5e28ee77f0952d7f3dc82bbe610]
stable/7.2: [43aad7687238d6178cb3fdac53c8de3f43bfa028]

CVE-2026-93091: firmware: arm_scmi: Quiesce notifications before teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93091

Introduced by commit 1e7cbfa ("firmware: arm_scmi: Free mailbox
channels if probe fails") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e49055d0d495c9c07575ad8e111d9eaf0efb13f]
stable/6.12: [6778bcabd2e0c32f73476f0bc6369013692540be]
stable/6.18: [2aac23bc0a79af41104d99823bb250fae92ba144]
stable/7.2: [5e30d3d16d1a9e599be4dcea872874e65e2c277b]

CVE-2026-93092: firmware: arm_scmi: Unregister device notifier before
IDR teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93092

Introduced by commit 53b8c25 ("firmware: arm_scmi: Add common notifier
helpers") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66a0bbf30cc14140fe13f63cd594a7c1ee352b75]
stable/6.12: [492fb49eac24beecd6d3c5e4744a513e626f8dcf]
stable/6.18: [f5e528f631425416f9b39e9d8b385c9f1ceb40d6]
stable/6.6: [70a26b37389846f1f29a09f7983aa3f45feff529]
stable/7.2: [74fcaa0a3f7ad3edfde2e8c6cb8ae457a00e0b7a]

CVE-2026-93093: firmware: arm_scmi: Publish channel state before callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93093

Introduced by commit 5c8a47a ("firmware: arm_scmi: Make scmi core
independent of the transport type") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0314900dcdde044af0208fed212035dbfaa55843]
stable/6.12: [6f3f532531e4a27d28a2240719d1b05ac11766c6]
stable/6.18: [1bea027f7ef6fb889628b16c568a5f7c07a51b30]
stable/7.2: [a1bc587568a4e373db76261dc9561dfc3653917f]

CVE-2026-93094: wifi: ath12k: fix dp_link_peer dangling references on
AP vdev rollback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93094

Introduced by commit 5525f12 ("wifi: ath12k: Attach and detach
ath12k_dp_link_peer to ath12k_dp_peer") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f066e1a93703c5be0fd905109d00587541711c97]
stable/7.2: [af405d216316d99f9b48733145fc708110011e0f]

CVE-2026-93095: hfsplus: validate thread record before delete key rebuild

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93095

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2ea5cac61acfc11dad22f1d2d4bc71d56c52a20]
stable/5.10: [33cda0036bc683fc888c20b04a5fc030e3e8413b]
stable/5.15: [b9729c51a8b67f8b20b8a8cf395da4be63a0c15b]
stable/6.1: [af48abc1b00d865c3f4c4d76b901c44115cb7162]
stable/6.12: [7898beee166c1145c0bca364d687b8437435bf1a]
stable/6.18: [e31985c67ba00a59d9b1340af473c1dbe6c87856]
stable/6.6: [e20f3b749ad241df77ec1c3e13a9c22209aa1eb3]
stable/7.2: [473ea7aa35615829f0de7a71e8691d69dc24e328]

CVE-2026-93096: cxl/features: Serialize multi-part Get/Set Feature transfers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93096

Introduced by commit 5e5ac21 ("cxl/mbox: Add GET_FEATURE mailbox
command") in v6.15-rc1.
Introduced by commit 14d502c ("cxl/mbox: Add SET_FEATURE mailbox
command") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77b814c1832fde018c30357b4ec3fcdaa91a1c10]
stable/7.2: [7682b617db1f19bc606b5f1badadcf1e63a87b14]

CVE-2026-93097: cxl/mbox: Break poison list loop on an empty payload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93097

Introduced by commit ed83f7c ("cxl/mbox: Add GET_POISON_LIST mailbox
command") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b301c4afbce4bc3f94528441d8d5ce1366504ad]
stable/6.12: [42eab80981f4d2ac820e253e80ecf92f8cd91f69]
stable/6.18: [6ad491cef1a812cf7b53aa769cd8869516c47362]
stable/6.6: [86771c105293ca26bfcc320b4f60d32c137b54aa]
stable/7.2: [e77594e0cea67ab1c2317a27aa77a744e26ad6a6]

CVE-2026-93098: rpmsg: glink: fix deadlock in endpoint destroy during
driver detach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93098

Introduced by commit a53e356 ("rpmsg: glink: fix rpmsg device leak")
in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [5a5a48e788e02fd8a8eb7188ce440572d6c12418]
stable/5.10: [73092c2292aa65515671e54abbcda2166d3827ed]
stable/5.15: [bbc236357876d35a624030e5c50eedbc380be98e]
stable/6.1: [8597f669a5268e0dcf243e2b2d6ca00370117057]
stable/6.12: [cbcdf96e1c87bc07055d04264018ded1f3bafffb]
stable/6.18: [ecad679e2b92c419cc22cc8f257cd457d5192647]
stable/6.6: [48f55b90f0d713e477e26b85d7327d9592d016f9]
stable/7.2: [e559626bee8a6632aafc08eedcdb4bf26ca245c5]

CVE-2026-93099: fs/resctrl: Fix UAF from worker threads when domains are removed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93099

Introduced by commit 24247ae ("x86/intel_rdt/cqm: Improve limbo list
processing") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2566b5cd6a275c124e8f154fef6e815f92ec8d5c]
stable/7.2: [b86dbfe4583bf134932a6cc45bf25b12c10a0b2f]

CVE-2026-93100: fs/resctrl: Prevent use-after-free in rdtgroup_kn_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93100

Introduced by commit b8511cc ("x86/resctrl: Fix use-after-free when
deleting resource groups") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [f5bcf539484d2d604c2f2330e09487ea090b21c7]
stable/6.18: [ae69f936e8ffed553d899ba4c02f8a7461a89e54]
stable/7.2: [4c593c62c1499665baebbb41b70e2c9b7e947b86]

CVE-2026-93101: media: v4l2-async: Unregister sub-device if asc_list is empty

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93101

Introduced by commit 28a1295 ("media: v4l: async: Allow multiple
connections between entities") in v6.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e72f13d58c4245c177a9d5f54579345554f354d]
stable/6.12: [e190320cebe921f99973c984ac53f317061a011f]
stable/6.18: [65e55f34fb2d61cb4f8a5dfcb93848af2aea0f32]
stable/6.6: [c7201bd08cad791858337e33ffcd90d8ae4147c2]
stable/7.2: [9fb74dce5c650cb23b60f6ba0ffcd5024e948a75]

CVE-2026-93102: RDMA/hfi1: Free RX data on late probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93102

Introduced by commit 4730f4a ("IB/hfi1: Activate the dummy netdev") in v5.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e17e101e04a3dc062e2719da57ff78c1c060632]
stable/5.15: [cfad037c6d305876b877abc39fd4d7e2185e44f3]
stable/6.1: [d1c91cb02e05fdd93411de707cc5c3c08375df9e]
stable/6.12: [cd06c17afb08b37995f66cf560c2332a769b8f80]
stable/6.18: [149a14ec70887ad14e820a7ca15738ded3d2d493]
stable/6.6: [10e5e37495096b58f07adc4020de2701efc3a9e0]
stable/7.2: [83fe4e4f4fbf01d3832a24511c0ddfaccf5df9d8]

CVE-2026-93103: RDMA/hfi1: Preserve unit 0 on allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93103

Introduced by commit 03b9278 ("hfi1: Convert hfi1_unit_table to
XArray") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e3809ad8911f5d5581b3f046bd628417bface76]
stable/5.10: [852637d3ee56aed8ea3ee8948eda21eca406c051]
stable/5.15: [3d0e5252b8d0345ef494763ca31e3ddd666e02cb]
stable/6.1: [0feb29d434e6cc0ebefec4f77be014c85ad751b0]
stable/6.12: [4ff9d58d34758e9633078b37e8d5289b513ff80e]
stable/6.18: [fd4d3ad5f244a867166d1e2da7ece3d82878ec81]
stable/6.6: [3f1e196eb66b8cd3882e373794d6cea46f150a20]
stable/7.2: [4204f5c0312ba136181a6e148ffa0bfaf95a4cc1]

CVE-2026-93104: RDMA/rvt: Return NULL after port allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93104

Introduced by commit ff6acd6 ("IB/rdmavt: Add device structure
allocation") in v4.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2982eaf3b9d2d953318c74cd6f1b7576ea6d7b1f]
stable/7.2: [b1e1b25723af44328524c7b54433e4bf0ab9930c]

CVE-2026-93105: esp: do not unref managed frag pages in esp_ssg_unref()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93105

Introduced by commit cac2661 ("esp4: Avoid skb_cow_data whenever
possible") in v4.11-rc1.
Introduced by commit 03e2a30 ("esp6: Avoid skb_cow_data whenever
possible") in v4.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21697720ff43b8dfa25b8e8d9ca7f56f4597fc80]
stable/7.2: [26b6b14c7a0368e317a1e9fb5144ebe6f8d495cf]

CVE-2026-93106: crash_dump: release keyring reference at the correct time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93106

Introduced by commit 62f17d9 ("crash_dump: retrieve dm crypt keys in
kdump kernel") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ada2e5a44e99113e08ad9b7b71396c6c572204da]
stable/6.18: [b0f7343a002f9c8b8378011f60482c76f3216dfd]
stable/7.2: [ed566979f99c5516cad45a76ae25e2a4928ffb67]

CVE-2026-93107: RDMA/rxe: Avoid reprocessing the current packet after
the QP enters the error state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93107

Introduced by commit 49dc9c1 ("RDMA/rxe: Cleanup reset state handling
in rxe_resp.c") in v6.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [15ae32c4a3551c4c9da457370bdfdd65d171e512]
stable/6.12: [62a4b48767e06fdd64548450fae2b1ffc6ff5d69]
stable/6.18: [399713f1f0eac641351c8ceaec0ab8244ddcf78c]
stable/6.6: [c319b986a88cedf600c4497cd7814a891b2f9e7c]
stable/7.2: [0d37e2503efd1069a74be740eadf63ea17c96810]

CVE-2026-93108: RDMA/ipoib: Drain RCU callbacks during module teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93108

Introduced by commit b63b70d ("IPoIB: Use a private hash table for
path lookup in xmit path") in v3.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31b7c700670830a0e8a4cdcd451c88a13cc5dc48]
stable/5.10: [bb9c23733a0c50e136bd40c27cb60023cc58e22c]
stable/5.15: [4a6dc313f9661f80e4ed43461d7ed5615c2450ca]
stable/6.1: [d8917353966d1d5a486437dd0dd68a2cf8ecb136]
stable/6.12: [2b3330cfc097db2d31f47ad09261967630270d66]
stable/6.18: [8dc5ffcb8efcc01e44dd1ebc490eaae72de3fadf]
stable/6.6: [7bc08d7f9338c9f9c09965e5d020591c793a80cb]
stable/7.2: [24ce944721dcd92ae62e7a448d770e2a3e79f5fd]

CVE-2026-93109: RDMA/mlx5: Drain RCU callbacks during module teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93109

Introduced by commit 6898d1c ("RDMA/mlx5: Use RCU and direct refcounts
to keep memory alive") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e37cdd75f8d61c1123d324ae5667ac3da562290e]
stable/5.15: [ca428e597f12b278bf158356e34641e6386cfa82]
stable/6.1: [59d60e04afd012f07e996d2e34cb90a4ec6f5cff]
stable/6.12: [4be7810ba70291abb2f68cc6db0ae1b93ee9c76a]
stable/6.18: [7babc25d8dd5b7642920fbc0737cfd1469e7025b]
stable/6.6: [2f946e7839f677fa14574b6babad14b37ae0bbbe]
stable/7.2: [4664368b9bd9d5d79ebad24056b98c34b9fed20f]

CVE-2026-93110: RDMA/core: Wait for RCU callbacks before unloading ib_core

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93110

Introduced by commit 943bd98 ("RDMA/core: Allow detaching gid
attribute netdevice for RoCE") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d75592114d1664623c8cf191a12b38052c04483]
stable/5.10: [82dfd1df456227279b1c8c648983a530f2612098]
stable/5.15: [1646e123e56c3ad679fbfb571e8eef6386efb729]
stable/6.1: [8e4f1677c09d75d738099f42afcf65d8587b664a]
stable/6.12: [0d5817fa4819abdc445fa77b5be4f0d49334a864]
stable/6.18: [9d998297fdaf47492f6679287f6552879d1a7e3a]
stable/6.6: [7853af5f15738dc00aebaa1fc9f1f0df40f6f603]
stable/7.2: [48b72fa0d209a92fb51b834a6080171cfa207b2c]

CVE-2026-93111: bpf: Mark tracing_multi trampolines as ftrace managed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93111

Introduced by commit aef4dfa ("bpf: Add
bpf_trampoline_multi_attach/detach functions") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30bdd6d1384d894931f113eb595636092d8e650c]
stable/7.2: [280145253fd38fa975cc04963ddaf74c7f415011]

CVE-2026-93112: bpf: Require a BPF cpumask for bpf_cpumask_populate()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93112

Introduced by commit 950ad93 ("bpf: add kfunc for populating cpumask
bits") in v6.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8740156ad33be5071b588b594c55f279457f667c]
stable/6.18: [0cfc9348a045da64955af2dd6902e66dfc7d6469]
stable/7.2: [b7e2a5c6519adc73be55c3de2cb545e095a0fbc5]

CVE-2026-93113: clk: qcom: camcc-sc8280xp: unregister CAMCC_GDSC_CLK

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93113

Introduced by commit ff93872 ("clk: qcom: camcc-sc8280xp: Add sc8280xp
CAMCC") in v6.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [499b4cb6710f9a351d8b57a2132f9b4389d8464a]
stable/6.12: [60b1d807bfd87b8053dff4dc0c1d87831a1d1bdf]
stable/6.18: [9257ece49ae727495d90cd9f10e0c2082ada238c]
stable/7.2: [b425cc3913fb127c60fe96b3e34712418f130d52]

CVE-2026-93114: platform/surface: acpi-notify: Check ACPI companion before use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93114

Introduced by commit a9e10e5 ("ACPI: scan: Extend
acpi_walk_dep_device_list()") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b3a5dabe89e330413af403246b648c1890f368f]
stable/5.15: [4faa43d4ef0b98beb6c2b77a279f4aa5d7fa2d13]
stable/6.1: [3855be0100efb98c26228c610db70a673611f3bd]
stable/6.12: [9b6479da662c2ec4e931ed9f7228df46aa8c3766]
stable/6.18: [7fea5a310e3b2db24f7aafe64897e4e659ffbb7d]
stable/6.6: [f276b62f2ce1cbff7fa50a8ee5afd8fef5a60897]
stable/7.2: [428a82d987fcd8844e8868c85582eae75b4b5c51]

CVE-2026-93115: platform/mellanox: mlxbf-pmc: Check ACPI_COMPANION()
against NULL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93115

Introduced by commit 1a218d3 ("platform/mellanox: mlxbf-pmc: Add
Mellanox BlueField PMC driver") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c38cce70adef874c2a7b5132c14d6c221401deff]
stable/5.15: [950d8e8375f3ff4787de51b7bdf8dd23a3ad6547]
stable/6.1: [fdfb736282b9665c0169df0c4152ec91fdea2767]
stable/6.12: [a75b84119e56fc34b0f1403f3b93d357a55dabb6]
stable/6.18: [71ba8b6e28f7a83b724036f5de07e03bb5473286]
stable/6.6: [bf1e0cc5cc1d4e71b699fc98cc9198ead0ed53e0]
stable/7.2: [d25dd08268aeaceb485189aaa84aa6d68a460291]

CVE-2026-93116: platform/x86: asus-wmi: fix resource leaks on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93116

Introduced by commit 0f0ac15 ("platform/x86: asus-wmi: Add support for
custom fan curves") in v5.17-rc1.
Introduced by commit 2c97d3e ("platform/x86: asus-wmi: add support for
ASUS screenpad") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef3daa2b84a2b8499ce9e2ce1c865dca36d39f95]
stable/7.2: [3308b8c5f5a28403611a2f5a46f06aabe4f0c661]

CVE-2026-93117: usb: fix UAF when probe runs concurrent to dyn ID removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93117

Introduced by commit 0c7a2b7 ("USB: add remove_id sysfs attr for usb
drivers") in v2.6.33-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef8154d8b52d60338c1fd8d793cd8e891c604c14]
stable/6.1: [9b82ddf76827e2a8ff033a8131ecf24f2d6cae26]
stable/6.12: [64320c6e721bdec4c43a789c866c8a099dd0c843]
stable/6.18: [7e795801295c84a6bbc10a3e7a4c99c50bfe45ac]
stable/6.6: [44904468e58d3dc3a0229782acbeb9677b060541]
stable/7.2: [e6a9c6b79b70046afdf5a1dbd03b1104536f30c0]

CVE-2026-93118: usb: gadget: aspeed_udc: check endpoint DMA allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93118

Introduced by commit 055276c ("usb: gadget: add Aspeed ast2600 udc
driver") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97cee53a94be3bd4fd8fbed6071bd2f32dad1ab1]
stable/6.1: [d7ae1a48e70e9c3451b7dc7bc3896c82884bc4df]
stable/6.12: [6182e708e2e1f55521c8a01d7535630ecc2d7df9]
stable/6.18: [ff6e88e29965bd06f640e59acdcf0bbf04a7f55c]
stable/6.6: [4aaad88f857498ed1294f061f0b25d27ae891c55]
stable/7.2: [9e6f57107c1886052d4baaa047a2bc3d0e91be5d]

CVE-2026-93119: usb: ljca: bound bank_num in ljca_enumerate_gpio()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93119

Introduced by commit acd6199 ("usb: Add support for Intel LJCA
device") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd9483726d0f16c1a56879c3edb65128259a4e2b]
stable/6.12: [0069593170a3d177de793c9a0b36989c4f069111]
stable/6.18: [aed958c4f784a29cf42abb3e54af51a16bddde46]
stable/7.2: [9c4bc8f7426aa001387800bf0140bfc5087a6de3]

CVE-2026-93120: usb: gadget: configfs: fix out-of-bounds read of qw_sign

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93120

Introduced by commit 76180d7 ("usb: gadget: configfs: make qw_sign
attribute symmetric") in v4.13-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f63edb54d8f738f9c21e2068c777ae1c097df6b7]
stable/5.10: [b895dbed8ac9e12a5ffa1a2165575a8469f8340d]
stable/5.15: [9b45125501aad2dff7730970461b455b0e0658ee]
stable/6.1: [f6da500b0f8106882598b6dec87fe37d653946cf]
stable/6.12: [7e94cb967778e074411940db4db97f22ed77560c]
stable/6.18: [afbf39c0f2297c6abef6d670a82a2079b0836191]
stable/6.6: [a28c486434634f6d1e120711d2b09f3eddea6c98]
stable/7.2: [36315a330e067f7773196940552feacb1debbef1]

CVE-2026-93121: usb: gadget: f_fs: Fix fence cleanup in
ffs_dmabuf_transfer() error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93121

Introduced by commit 7b07a2a ("usb: gadget: functionfs: Add DMABUF
import interface") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [621707dc67c9846fd876d7579ec951d92aa033f1]
stable/6.12: [be539138d9a187af3b884525a395db10797c64f1]
stable/6.18: [5fd8baacc7dc477df9cac61b45491840247a9b1e]
stable/7.2: [58952c83dfe6ea3294a74734d2d1018c1120779a]

CVE-2026-93122: usb: gadget: uac: validate rate list length before storing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93122

Introduced by commit 695d39f ("usb: gadget: f_uac1: Support multiple
sampling rates") in v5.18-rc1.
Introduced by commit a7339e4 ("usb: gadget: f_uac2: Support multiple
sampling rates") in v5.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [844d83d5964b87919b958ff48405188c6ddae9cc]
stable/7.2: [3819c6f255a37c4d085ce9f264f9f11bf3c2c6bb]

CVE-2026-93123: serial: qcom-geni: do not advance stale DMA completions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93123

Introduced by commit 2aaa43c ("tty: serial: qcom-geni-serial: add
support for serial engine DMA") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7ea38c49e7178960926657863299face6dc0e1b0]
stable/6.12: [231c84fe7ec40e4a06c398c0591d5b8e823d68e1]
stable/6.18: [c02d030747c46da33faf406dd772ef91100efa27]
stable/7.2: [59faa59c25a0a098fbc86275408d7c8405015702]

CVE-2026-93124: platform/x86: asus-wireless: Fail probe when there is
no ACPI match

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93124

Introduced by commit f7e6480 ("platform/x86: asus-wireless: Convert
ACPI driver to a platform one") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4aefd66ef7822cf7d3f53146dcee0b71021ed2b7]
stable/7.2: [7bfa711f311a584002e16ecd750627306deb805c]

CVE-2026-93125: bpf: Reject rdonly/rdwr_buf_size kfunc arguments that
exceed u32 max

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93125

Introduced by commit eb1f7f7 ("bpf/verifier: allow kfunc to return an
allocated mem") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aaf67f0516fde29620d0edfc29c01b9ea7ad430]
stable/7.2: [56a3846830ac95a472297d0cbba75cbff29540bb]

CVE-2026-93126: remoteproc: qcom_q6v5_adsp: Fix reference leak for device node

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93126

Introduced by commit f22eedf ("remoteproc: qcom: Add support for
memory sandbox") in v6.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c952807c2cebd5e9e9b37146c9383229794c129]
stable/6.12: [b8bf07b031b202a93d8aa44a4a230a0bbfe0c1fc]
stable/6.18: [7420aac8b1f7e5a75a9d659be3f151dd89de6911]
stable/6.6: [a73cfa80f1ec6b0f948cf3c91455c62423747b3e]
stable/7.2: [5aed51501447ebb925b0ce0d7d923a9d5ce0bf9e]

CVE-2026-93127: bpf: Drop scalar id on sign-extending narrowing stack fills

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93127

Introduced by commit 3cd5c89 ("bpf: Let the verifier assign ids on
stack fills") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2cb5f4ca695ebe552647e5ba4aad6934d6a43bae]
stable/7.2: [f3614622dc41f3dd99bb4f691da253814e4e6cae]

CVE-2026-93128: platform/x86: lg-laptop: Fix LED resource handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93128

Introduced by commit ae26278 ("platform/x86: lg-laptop: Use correct
event for keyboard backlight FN-key") in v5.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e91964aa74ab261aa15d9d96318eded2fd9d22a]
stable/6.12: [4fbfe3714f645b6c64c9ba8faa83b27e4c9f2edd]
stable/6.18: [9a85e2d35e54248aca39bad4f4152ed34de1995f]
stable/7.2: [acc190322250562d5f28860f4ae1ebaf3e304fc2]

CVE-2026-93129: platform/x86: dell-wmi-base: Fix handling of ultra
performance key

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93129

Introduced by commit 5fbd827 ("platform/x86: dell-wmi: Recognise or
support new switches") in v5.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adfd6846bea13667ff28f8aaf00c32fbd69825ab]
stable/7.2: [392c19faec6bf4cb72fb02322e2a61e198dd8f72]

CVE-2026-93130: platform/x86: dell-wmi-base: Fix resource leak on
module load failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93130

Introduced by commit 8af9fa3 ("platform/x86: dell-privacy: Add support
for Dell hardware privacy") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [072841e02cf9c00a7e8a9c567a14239e02ca47ad]
stable/5.15: [4877e20c64be0abfbf22c094b2bac386a87d6d07]
stable/6.1: [6836048b7057cf3493cdd13e1e11533d71a4281e]
stable/6.12: [b615d27308f7b426f352f79f5215735773edc8a6]
stable/6.18: [6ff6af62f042bb34ac9d2b650c6c043082c5bbda]
stable/6.6: [62b24e1c338f5d0258262d95c5c8af2e0f18ca49]
stable/7.2: [f59cd5007055cc0cdac1621d1cecff2d295ff8d0]

CVE-2026-93131: platform/x86: dell-privacy: Fix race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93131

Introduced by commit 8af9fa3 ("platform/x86: dell-privacy: Add support
for Dell hardware privacy") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ca9338dbc64759b30741b12017c050b33c94dfa2]
stable/5.15: [239ae86b7c97341f49d2ba32037ee3ddbaf0f1ab]
stable/6.1: [2d2108685a491b369f95774d0a7579d6e5287215]
stable/6.12: [f3c4532f6dac8fb5504d342e2a15e6353e5eb56e]
stable/6.18: [9f860050c3d17ff8499d3998f7534d306c3da50a]
stable/6.6: [a22beeb90475b5f71a477564eecf764b24f47277]
stable/7.2: [ef59ff891adf9bd696917f71f841fdb23c245790]

CVE-2026-93132: ACPI: RISC-V: Fix riscv_acpi_add_prt_dep() loop handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93132

Introduced by commit 1b173cc ("ACPI: RISC-V: Implement function to add
implicit dependencies") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a56321d0aceee2a0bd80d23366401c131ff8350]
stable/6.12: [41652ca8c6ff2b77b9780cbbb2f20f1551b9ff80]
stable/6.18: [c9729ced165d6c5b57d99141b6632bb8711efec9]
stable/7.2: [3fd86a5d6facb6618f63a76d499f28007cef878f]

CVE-2026-93133: ACPI: RISC-V: Check acpi_get_handle() status in
riscv_acpi_add_prt_dep()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93133

Introduced by commit 1b173cc ("ACPI: RISC-V: Implement function to add
implicit dependencies") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [20435bda13f1219891ed0ce41207e320a916ff9c]
stable/6.12: [f8625752bfdf108a0000116aa583b3efe767b540]
stable/6.18: [4cdcf4e19ed3127afd787f026d4ec56ae4d2a4ed]
stable/7.2: [088c1c85921344d7244ca2e8d5d336ae7461de6e]

CVE-2026-93134: printk: Fix possible console use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93134

Introduced by commit c158834 ("printk: nbcon: Use nbcon consoles in
console_flush_all()") in v6.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36630cafbeede0b64c370edb2f7b4094327ee1e0]
stable/6.12: [f0104a7b730de32eefb3d4a27279592b5504ad59]
stable/6.18: [fbf9bb81b21537ede387a31cc586f1d2ce66a74e]
stable/7.2: [8f194dee0c0d1223255bae1429e1939882f540fc]

CVE-2026-93135: bpf: Reject programs with inlined helpers if JIT is
not available

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93135

Introduced by commit 2ddec2c ("riscv, bpf: inline
bpf_get_smp_processor_id()") in v6.10-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1c27922576edccb99d0257827d09bd05c0304a6]
stable/7.2: [21c6445366795fa3a89954e1d318e7c8afdef843]

CVE-2026-93136: bus: mhi: ep: Fix device refcount leak in the error
path of MHI device creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93136

Introduced by commit 297c77a ("bus: mhi: ep: Add support for creating
and destroying MHI EP devices") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f12862600bb70e599a614d706a095ea5f8f9858]
stable/6.1: [8acc3813ab5015af73eeb74c9032443162f122d1]
stable/6.12: [4fae8fd4adc7f4765463ddeb1a5fad23936432f6]
stable/6.18: [5587e7871ce994bb079f97fe7e430d99627e5292]
stable/6.6: [51ddb831a36102fd0ea25f354935e49abce9f0a1]
stable/7.2: [8f3f64faee335eb678fd7dca7b95dfe3d0b271fd]

CVE-2026-93137: bpf: Fix use-after-free on mm_struct in bpf_find_vma()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93137

Introduced by commit 7c7e3d3 ("bpf: Introduce helper bpf_find_vma") in
v5.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47b079e2117a2ee52e21f8b72935900c702fc0b5]
stable/6.1: [db347840d6b6ee9bb9b8e4a985d4b4419f9f3200]
stable/6.12: [c7ad910e987008e125eeff448892e86852173384]
stable/6.18: [86d54cf069fc5ae2e111c87933bebf6eb527978e]
stable/6.6: [8e1101fc4118019a69c96ced4aec93164f89cbd5]
stable/7.2: [2b2a903bee56d312539046d9defa8023eec94760]

CVE-2026-93138: bpf: Fix vmlinux BTF prep race in bpf_get_btf_vmlinux

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93138

Introduced by commit 8580ac9 ("bpf: Process in-kernel BTF") in v5.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92863e678070f57c17c868e4bfa2441a5c61ad2b]
stable/5.10: [f32a4a40bc635be25d6816da4bd91e9e58c31bf3]
stable/5.15: [a7fe72d780122eb934536f1719abad445f6afdf7]
stable/6.1: [e18a10b39c994f04e1ebd7f8fc042bb1ca8ad053]
stable/6.12: [eaf302628a78806f66d8224d6ba03fb4d5025de4]
stable/6.18: [2892f3f44bf865c8fb6b6c0960edec4cc91806ee]
stable/6.6: [978524ecfc1c539282df5858de1eec20748c6f74]
stable/7.2: [86d11c594d60b255b526fa5260f669463fb1a063]

CVE-2026-93139: drm/amdgpu/mes: Fix hung_queue_db_array loop limit for multi-XCC

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93139

Introduced by commit a132fc9 ("drm/amdgpu: Fixup boost mes detect hang
array size") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c256086a363f01f9840a57949506eccf5c990a6]
stable/7.2: [7ff668cfc3960ed5b944ac35129f18a15ea08b74]

CVE-2026-93140: udf: Mark LVID buffer as uptodate before marking it dirty

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93140

Introduced by commit 853a0c2 ("udf: Mark LVID buffer as uptodate
before marking it dirty") in v3.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb0601134c7e51728bd098abc6909315de1e5d86]
stable/5.10: [e6461ef34f91ad7dbffdf912b3d661a7dd892931]
stable/5.15: [359cea636f4a74a96c01a8050f155e12840c079a]
stable/6.1: [a4c4e38b356ad4c1f90478124922917489137c08]
stable/6.12: [ee477e5204f764444e60699280abf5936c2a6ae6]
stable/6.18: [11afe1912140f79d5af3091a54b181ef72fce1a5]
stable/6.6: [8034ddf4751d9143c5ef7eebe3d4f33218fdd378]
stable/7.2: [c4058355d27488a3cd31c60c032335f77c4fdcfc]

CVE-2026-93141: usb: gadget: r8a66597: avoid double free of ep0_req in
probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93141

Introduced by commit 776976a ("usb: gadget: r8a66597-udc: cleanup
error path") in v3.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41d541e3718db01668a4cd29815ee4b3b55f76d2]
stable/5.10: [c9e93290ffe7db22a8131a5f5fd026335090fbbe]
stable/5.15: [7721cf32efa428bd9649f4a9b89fc85601df87de]
stable/6.1: [f9c43246128a2dd0f2bbad71decf153910ce3606]
stable/6.12: [b2e68583c7c51eea2aafb8f1793e0d285c56ac82]
stable/6.18: [6648c470918371766f6d368113dd2a4faebac93f]
stable/6.6: [150d3f3c461345b6c9ae784912cf1e49c8e5ff6b]
stable/7.2: [6be64cca6527f7fc99b05abf54f22db91bbc116f]

CVE-2026-93142: thermal/drivers/rcar: Fix error checking in probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93142

Introduced by commit bbcf90c ("thermal: Explicitly enable non-changing
thermal zone devices") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd04ad1cdabcad51e34b74b4e91b9aeb7180d05d]
stable/6.1: [a85bcd0c7ef66e3404b3c99e5589c5ea622a757e]
stable/6.12: [623349a18d4c6e6add7876553c0cb6947c8d92e6]
stable/6.18: [35bf61798e7d4abf39667d98f298f793b3dd9bbe]
stable/6.6: [810875c5996f731961fc5ee1bd24e711f2e8fe78]
stable/7.2: [d67607e7749527850619a10d3ed033b02dcea516]

CVE-2026-93143: staging: media: ipu7: fix pm_runtime refcount leak in
ipu7_resume()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93143

Introduced by commit b7fe4c0 ("media: staging/ipu7: add Intel IPU7 PCI
device driver") in v6.17-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b298b80814dd0fc3cb1c8c0e0082fc14fdb5fecf]
stable/6.18: [593fda71983b9c23c84a566b20c53dc402c6b376]
stable/7.2: [437d6d15936db87485afabf7d52754b7b19cc787]

CVE-2026-93144: bpf: Reject writes through untrusted BTF pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93144

Introduced by commit 282de14 ("bpf: Introduce allocated objects
support") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac65c710cc643cbc52b899627577357867249530]
stable/7.2: [19d5566b84ca1af0256d0d0003e1a081580c3ba3]

CVE-2026-93145: clk: qcom: gdsc: tear down per-domain genpds in
gdsc_unregister()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93145

Introduced by commit 45dd0e5 ("clk: qcom: Add support for GDSCs") in v4.4-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86b23609d5e17a770d03037e53c6a443e742a6e6]
stable/5.10: [418d2f0a32b2a9ceb656a88aa9139408a9b7b517]
stable/5.15: [6333cbf7e86df9797b342ce64ae7d32ba46d8d10]
stable/6.1: [cfe16d993c578f6b17e0171a8dfd68f6fdfcfb24]
stable/6.12: [6b9228a43963bcd4db92deb467375345132c29b3]
stable/6.18: [f60f495858379dc70e87c6898d761a9db98739ff]
stable/6.6: [0f4733f5fc6b6b62750619f30c18730922a1dbdb]
stable/7.2: [40bd77fa2857ccfa77b885b77d44cea406f24a4c]

CVE-2026-93146: time/namespace: Validate nanosecond field in
proc_timens_set_offset()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93146

Introduced by commit 04a8682 ("fs/proc: Introduce
/proc/pid/timens_offsets") in v5.6-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06aba58e58492d2b8eae059274caed29025ea96e]
stable/6.18: [db667d2970c756cc7b483f45f272440f845a665b]
stable/7.2: [1f0c3c0c36c7aedf55a60d9c71c4bd258b8937ce]

CVE-2026-93147: s390/bpf: Replace ly instruction with llgf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93147

Introduced by commit 9012cf2 ("s390/bpf: Inline smp_processor_id and
current_task") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f6cc299938b561cb01e343bab7042611fcee12a]
stable/7.2: [88500a86ab79f01c568de6ed00f5b1c5c79f11d5]

CVE-2026-93148: bpf: Reject MEM_ALLOC BTF accesses past object bounds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93148

Introduced by commit 958cf2e ("bpf: Introduce bpf_obj_new") in v6.2-rc1.
Introduced by commit 36d8bdf ("bpf: Add alloc/xchg/direct_access
support for local percpu kptr") in v6.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c9ee0324c774490ae953162aaaf4561d222bd93]
stable/7.2: [e626a50d07d43421cbf7bfb5a084b33a5e276b6e]

CVE-2026-93149: wifi: mac80211_hwsim: avoid NULL skb in stop queue drain

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93149

Introduced by commit bd18de5 ("mac80211_hwsim: drop pending frames on
stop") in v5.13-rc7.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [158438cd6ad69d6dd7d871582c38baf22169fede]
stable/6.1: [d131027054a8dd922dda01fe8d381abe5af4970b]
stable/6.12: [2817431a61557f46dc63077b7cc126bc906c242e]
stable/6.18: [e7fccad2c8e6ef6bbafe509c95869d161d0f466b]
stable/6.6: [c40ba47f2ba1951cb32ea048667ed014d36a5749]
stable/7.2: [1c2a4ab6efa26415dd131b8c222e7893fda03435]

CVE-2026-93150: cgroup/cpuset: Make nr_deadline_tasks an atomic_t

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93150

Introduced by commit 6c24849 ("sched/cpuset: Keep track of
SCHED_DEADLINE task in cpusets") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [95220e1f18f6321008f021abc7d6f581f64bcb82]
stable/6.12: [e422b32e6a57269ca8164c60674a78bee85cf5fb]
stable/6.18: [e5965ae3f7c918151b87e5c925b7978afbeaf638]
stable/7.2: [78d9daf5e13ad1448b7dfebac949936710ec7565]

CVE-2026-93151: nvmet-rdma: fix response resource leak on queue teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93151

Introduced by commit 8f000ca ("nvmet-rdma: add a NVMe over Fabrics
RDMA target driver") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0114dd303b373522dea06053aabae34bdd33a7c4]
stable/5.15: [91cfa74f1f3772e8c3662c064a45d8633e00c78e]
stable/6.1: [156ec10a8be2c33b0c279d8b2f4fe8e16fa89ef7]
stable/6.12: [5cc3b21729d45b5af8f79891f9dedb7e6b6dbd08]
stable/6.18: [ca795fc1d8a1a4ab0e6bd1d27c9adb78d4ed1a1c]
stable/6.6: [9584b3c30e4ee8ca315bdc12249cc6c47cf1a482]
stable/7.2: [d553a9dc1c45666e76d8d2ac9a4f8ff0cbf53a50]

CVE-2026-93152: nvme-apple: Use acquire/release for queue enabled state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93152

Introduced by commit 5bd2927 ("nvme-apple: Add initial Apple SoC NVMe
driver") in v5.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f61c934aa084b7440fec681be3f4b481eb5a8609]
stable/6.1: [cbe53ecd696e354bfda8173364f7595759bc562d]
stable/6.12: [0e9d9fe12da779516dc3899dc9141304675f5416]
stable/6.18: [e5a79244a3c526a76d930f2ef30aff64528b0c6a]
stable/6.6: [86782a72c6d8c7541813b9ddb009668468601f18]
stable/7.2: [840ab22ffa4d859ca40a31e96fc3554688e7a035]

CVE-2026-93153: RDMA/bng_re: return a timeout when firmware responses stall

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93153

Introduced by commit 53c6ee7 ("RDMA/bng_re: Enable Firmware channel
and query device attributes") in v6.19-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f9576c6734abca88a02db72c466e09d2eddf160]
stable/7.2: [02d4ee65dc2e883f554169155937742e6014c243]

CVE-2026-93154: RDMA/irdma: Add refcounting to user ring MRs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93154

Introduced by commit b48c24c ("RDMA/irdma: Implement device supported
verb APIs") in v5.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f67d8a08f60c9217df6d40da56422d2049f5e334]
stable/6.18: [07974c267f603a76aead348bca97deee95efdcc9]
stable/7.2: [a6c0e693a7c881bfa43ac74cbcad1f8e10f1382b]

CVE-2026-93155: crypto: keembay - Fix AEAD unregister count in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93155

Introduced by commit 8857433 ("crypto: keembay - Add support for Keem
Bay OCS AES/SM4") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e264401ce4776a288524e5b87593d4d864147115]
stable/6.12: [5607b101d86cbee8dd1ffab784495c880ca73383]
stable/6.18: [5bbb726d27ff6dff750264e51aa665538394d0f8]
stable/6.6: [27ec91c29ee155cc507b2f56221fc6fab65dbb51]
stable/7.2: [a3217fe7998622728a53dff405615e0971949eaf]

CVE-2026-93156: crypto: rk3288 - fail ahash requests on HASH idle timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93156

Introduced by commit 37bc221 ("crypto: rockchip - use
read_poll_timeout") in v6.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae150db7826f21e8d19e54fb6243169628809c4d]
stable/6.12: [2feb52b2796c25510903bf0f18a84cde44631391]
stable/6.18: [e7d8ddd471d2895f1d4098832c21121d4191adaa]
stable/6.6: [a22dc48d58ef46e21c0172ba83c33f1c9859e63c]
stable/7.2: [0a261177ad3245af393548d0632226d99c643191]

CVE-2026-93157: hwrng: xilinx-trng - propagate timeout before any data is read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93157

Introduced by commit 8979744 ("crypto: xilinx - Add TRNG driver for
Versal") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba088974419326daf46c5dc03e2cf6ab6ab701f7]
stable/6.18: [62219775a07ce0bd8085852f3d1e2d772bf6fdec]
stable/7.2: [bdc3b37a935f28c3e9eb2f6e889b4644d859fb08]

CVE-2026-93158: crypto: sa2ul - stop probe if context pool creation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93158

Introduced by commit 7694b6c ("crypto: sa2ul - Add crypto driver") in v5.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d03f980a25853f6a380895119a572a3bb1194e8d]
stable/5.10: [304dcd26bfc3ce6771c2bd3b7c0299dcfd5f4e06]
stable/5.15: [9907426b438e4dbc8c45138bd440ad6d732d80b7]
stable/6.1: [9a692a6a2b47328a36c8d80c7fbf81da16b6d6b1]
stable/6.12: [f72c7837614a9705f8b3021828d49c9f095803ba]
stable/6.18: [91ded4742fcde6ad415c4d8a20e5ea0dcdf4f73e]
stable/6.6: [04c46784ec249cac995e31f0691397b82bdaa5fd]
stable/7.2: [b68b35ed97d3e18edb9dea500d88420a95006742]

CVE-2026-93159: crypto: atmel-sha204a - fix heap info leak on I2C
transfer failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93159

Introduced by commit da001fb ("crypto: atmel-i2c - add support for
SHA204A random number generator") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72bbf11ba14bd7d5fbf31a1ec42fff608b657f74]
stable/5.10: [a430b5b6d2ddd2b266330f8507a655be1148347d]
stable/5.15: [4e76d85e505b7451925efbcd67c015e8c2440c68]
stable/6.1: [bcac9052e19490231ff6e0678a06bd2fcf8db3af]
stable/6.12: [0d6db386133d9230befb77967bbf130443964860]
stable/6.18: [f4d347fb1309b69ea6f817a17e6b2893c8d754b7]
stable/6.6: [28cc179252347718f97045dd5ea74165609dbd7d]
stable/7.2: [94abda77b57a35b82bba0365bad072d94d67ffe9]

CVE-2026-93160: crypto: atmel-ecc - reject hardware ECDH without a public key

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93160

Introduced by commit 1110569 ("crypto: atmel-ecc - introduce Microchip
/ Atmel ECC driver") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f240f9b588f4e2de89822adebf560a96b5d263ed]
stable/5.10: [5e33791dfcc6459e402a524669093cd953d5b2df]
stable/5.15: [33241f198287960bba5fc2251400896762650bfa]
stable/6.1: [3ea8b780d68f02fe235c5051ce8ac4b4940b9259]
stable/6.12: [2b40bab362d2b598f34e5ccd4694cedc3c2553d4]
stable/6.18: [e64d6f1aae8c837cb3f0446bf44108226d7370f4]
stable/6.6: [6457162f74f45284ade2da644a4f0c54758ac0a6]
stable/7.2: [add28e9988902d29ea93f4869280b4a16a049ea5]

CVE-2026-93161: crypto: qat - clear AES key schedule from stack

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93161

Introduced by commit 5106dfe ("crypto: qat - add AES-XTS support for
QAT GEN4 devices") in v5.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d41a9fcfb7f9ee36e4a4aaf5e7996bca6be1e7a9]
stable/5.15: [b9cf42622b30178f554fa74411eec67e02d70411]
stable/6.1: [fb1194b78a163cc56bb9480c707fc34b53522359]
stable/6.12: [dcaa0f1e86cbcb01f68131ae907b54cf299a3592]
stable/6.18: [9af019e213ada5c3d0d33c515071a1414b6899f3]
stable/6.6: [892f34dc1819cceb8841005a68086710ce3763b6]
stable/7.2: [92e4979e1a770860b26aa3d90cce0c4c6a53833c]

CVE-2026-93162: crypto: qat - cancel work on re-enable SR-IOV timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93162

Introduced by commit 4469f9b ("crypto: qat - re-enable sriov after pf
reset") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [455b0f3ac9e254edab9f5a873d337abe5e6e3604]
stable/6.12: [cbeef7ba0de4a7b84a772eee1784948473e7a7e6]
stable/6.18: [6b19f343ae8ada4c84209bc6f62d50ea9781c4ae]
stable/7.2: [1a106c6e17525827ee6d8091bb8c06fafbc21fed]

CVE-2026-93163: hwrng: core - fix rng list on registration error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93163

Introduced by commit 2bbb698 ("hwrng: use rng source with best
quality") in v4.14-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a5834db2b1ce25649f330e78efe1ccde78967fd]
stable/6.12: [de4f1bcb61a73cc896decdbd27d61a34add93b53]
stable/6.18: [cf293c9c7424de0d04b51367d07f40570ce80231]
stable/7.2: [bee8d1fcdc8f389b595b0a4cf6fe8440f499458a]

CVE-2026-93164: uprobes/x86: Move optimized uprobe from nop5 to nop10

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93164

Introduced by commit ba2bfc9 ("uprobes/x86: Add support to optimize
uprobes") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [554ba38456dad8053a1a80afe6ae6da9eff745cc]
stable/7.2: [1b3fecd09910040668b752f3377d7218ca5c59ac]

CVE-2026-93165: platform/chrome: sensorhub: Fix memory overread in ring handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93165

Introduced by commit 145d59b ("platform/chrome: cros_ec_sensorhub: Add
FIFO support") in v5.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1ceb2b2324717fa30b44d56ef0c52813e239569]
stable/5.10: [98604cc8fd2578442f49cd113481e8fc83bc0ad3]
stable/5.15: [86bcfab7dff6f0a61cbe0660e5176e907353141b]
stable/6.1: [7e901aaf95828364b05a2120a1bea1a1669bdc9a]
stable/6.12: [ee0403520cdbcf87e853df9aaa9b518a0684ed38]
stable/6.18: [847a5ba0ac75f609e3f88da905251f7a76179145]
stable/6.6: [7780d93ae28f31fe517417c9451255315d1ad584]
stable/7.2: [6268f46d83875d294d75b68b97a5b79953744598]

CVE-2026-93166: wifi: rtw89: debug: fix off by on in rtw89_ppdu_str()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93166

Introduced by commit 419ed7f ("wifi: rtw89: debug: extend bb_info with
TX status and PER") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1908534deb53a018580309be84a4f7dcc9cb1af3]
stable/7.2: [876b110114da39cfcf07cd35e2e6213ef6982e4b]

CVE-2026-93167: csky: Fix a4/a5 restoration in syscall trace path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93167

Introduced by commit e0bbb53 ("csky: Fixup abiv2 syscall_trace break
a4 & a5") in v5.7.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [abb81e5ce7d995baa41556b8125fa59e28ba3be8]
stable/5.10: [e9ae8e86eed68bea5d2670eadf61938a43bd2263]
stable/5.15: [64e3ec7a71d3b715e2567f19f64207f04999bb0c]
stable/6.1: [863fa63fd1491f201ac819f805a8db98d2a32c3d]
stable/6.12: [31c81b376e5f058c7f2c94f69719cf7caec2fc3f]
stable/6.18: [a776afa89424570bfa637ebf812ca281a5732904]
stable/6.6: [e71a3dc5b8d2ea4d9cfbdb135d6b7777de84212e]
stable/7.2: [343aa5275484d627c921a42e8e115cae366be5de]

CVE-2026-93168: dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93168

Introduced by commit 9495f26 ("dmaengine: xilinx_vdma: Use
readl_poll_timeout instead of do while loop's") in v4.6-rc1.
Introduced by commit 7349a69 ("iopoll: Do not use timekeeping in
read_poll_timeout_atomic()") in v6.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt

Fixed status
mainline: [aa99c4d1d63bbc26a5fc4c667d89b2595743c19d]
stable/7.2: [8b5654d317277e6e505c23f8fa7e415237fefc7f]

CVE-2026-93169: dmaengine: zynqmp_dma: fix race between runtime PM and
device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93169

Introduced by commit 72dd8b2 ("dmaengine: zynqmp_dma: Add shutdown
operation support") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [516ba2d8b7aac4238f9fcbd58579c43c71b9b695]
stable/6.18: [32f69e6c95b59f9cfc649ebf352a204d23ba93d7]
stable/7.2: [aec7cf9a5bd89047c58d5648bfce0b1bd19ba7d5]

CVE-2026-93170: dmaengine: xilinx_dma: Fix channel idle state
management in AXIDMA and MCDMA interrupt handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93170

Introduced by commit c0bba3a ("dmaengine: vdma: Add Support for Xilinx
AXI Direct Memory Access Engine") in v4.7-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0b6d055edb55ecadadf54e930c2b4fab76fa9a5a]
stable/5.10: [7f4b989d7d87381927b98d64492f8dcf979f57ab]
stable/5.15: [5459e02707b27a964ae72e028d3ff72a3b687c4a]
stable/6.1: [425630e9eea1f9f8912b8c6abf01e0dab1e27917]
stable/6.12: [c27d16fd2358b2fc3e1ffaca03afd11dc28630ea]
stable/6.18: [ec927657524be4438447944a58173c7baf7f2384]
stable/6.6: [fdaf297ab275c6efecac5e87669c31bc89b74297]
stable/7.2: [c3e943490ced0b9ad475844eda7661f6a9bcfb4a]

CVE-2026-93171: leds: lp5860: Fix a potential double-unlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93171

Introduced by commit f0a6656 ("leds: Add support for TI LP5860 LED
driver chip") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10a5a70c02277a1c12999b669a1bd1922558338a]
stable/7.2: [989f3d01fc1961d0850b343e0b4e3973c082d82e]

CVE-2026-93172: mm/mm_init: handle alloc_percpu failure in
free_area_init_core_hotplug

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93172

Introduced by commit 75ef718 ("mm, vmstat: add infrastructure for
per-node vmstats") in v4.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ebce860bdd7ae5e13002811bc9bbbf33fcfc221]
stable/6.12: [4cc5caef9a8d1894dfa31d84a0daa0ac1437dadc]
stable/6.18: [bc3b5e6519b8df22d622a03eab6772784da97db4]
stable/7.2: [1017fe1c7f48e511c5a680e3057005daaff2f3a2]

CVE-2026-93173: bpf,lsm: Drop bpf_prog_free from sleepable_lsm_hooks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93173

Introduced by commit 1b67772 ("bpf,lsm: Refactor
bpf_prog_alloc/bpf_prog_free LSM hooks") in v6.9-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ce3f548cfc6a1fe4c53479cf8a21931cdfd51d8]
stable/6.12: [2135f661fae7160a7fc603cab43cbc7999e8bfce]
stable/6.18: [d5f2f741a900123fbcb7c7c0a002b81306fbe242]
stable/7.2: [915c2d9d69fc6c5f9f41d12bf4a9c51293aaee62]

CVE-2026-93174: bpf: Copy per-CPU map value padding in copy_map_value_long()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93174

Introduced by commit 4483251 ("bpf: Add copy_map_value_long to copy to
remote percpu memory") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cf9cd98cf6f0df3befc167ca6b54c07014d71de]
stable/6.12: [003bf840ed3326bd01396ce7d5b431cef0d371e7]
stable/6.18: [5e9f69829835521aa2942d1d14bd0990fbc6991e]
stable/6.6: [953e85da53541a8dc3e7ad4e8532f29a34a32eae]
stable/7.2: [ff3f22ed8d2f350b4c24ee26e33daea5f08d58ef]

CVE-2026-93175: drm/amd/display: Fix dangling pointer in CRTC reset function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93175

Introduced by commit e7b07ce ("drm/amd/display: Merge amdgpu_dm_crtc
and dm_crtc_state") in v4.15-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0aeed866cb938943908c3ba46422128e49d2d080]
stable/7.2: [32bd68edbc6cbcfac0e4033b64f0bcadbf0efef5]

CVE-2026-93176: drm/amd/display: Fix dangling pointer in plane reset function

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93176

Introduced by commit 5d945cb ("drm/amd/display: Create a file
dedicated to planes") in v6.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [98cad4bd1443975d972f4c7f705980da03722a22]
stable/7.2: [80c0f51aced43d6eaf72f95a2833b0a77cf7880d]

CVE-2026-93177: drm/amdgpu/pm/powerplay: bounds-check voltage index in
Vega10 lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93177

Introduced by commit f83a999 ("drm/amd/powerplay: add Vega10 powerplay
support (v5)") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fa33f594e46e775a94097f71b486d7b006b6917]
stable/5.10: [206e478810d6af50b25d8da72e3af8d55a014365]
stable/5.15: [25dedc13ceb9b6109c79c92a726ca4ca017c9eaa]
stable/6.1: [ae25c92d91f2cb90ede2b0eb0f58efa82ccc718b]
stable/6.12: [dfe89f1a0c7f40ef858b93881198f9728df956cf]
stable/6.18: [46d27e56dbd6345b9c7b62b67ec57407bf3bf29a]
stable/6.6: [b349dcf061a6dc8c6cef9a10530331ef2ff66c72]
stable/7.2: [06aef6dcc1d52da5112cbcde39c062e493247ab5]

CVE-2026-93178: drm/amdgpu/pm/powerplay: bounds-check voltage index in
SMU7 lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93178

Introduced by commit c82baa2 ("drm/amd/powerplay: add Tonga dpm
support (v3)") in v4.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a8a05477cda6c8293e2b629495b42981dcaba32]
stable/5.10: [d9ef085114d1e3c2c1f869c0bdb275a7b358ce8b]
stable/5.15: [6f08c001fa6e8212930d694540ae8d9d6d3fb58a]
stable/6.1: [ce0d8e72836c9d3710a160ad848b0f1d096075e3]
stable/6.12: [f925d317d84d401d642e537ea18ee12f67cb6983]
stable/6.18: [8a3db9f593b643904c6cc6d8a3f211c84ca6cf8a]
stable/6.6: [745297208d31222f916cc04da313cb737b997935]
stable/7.2: [1664327ce797e09e387dc10cbbaa5b8d76558d2c]

CVE-2026-93179: drm/amd/powerplay: fix VoltageObjectInfo zero-stride
loop and OOB read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93179

Introduced by commit c82baa2 ("drm/amd/powerplay: add Tonga dpm
support (v3)") in v4.5-rc1.
Introduced by commit 0d2c756 ("drm/amdgpu: add new atomfirmware based
helpers for powerplay") in v4.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d3cc8e388464f485d0944b87b8f9426e637d082]
stable/7.2: [83c680de6d41d627c077dedb24f89d9e5be0e2a2]

CVE-2026-93180: drm/panthor: Fix NPD issue on partial unmap of an evicted BO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93180

Introduced by commit 8e7460e ("drm/panthor: Support partial unmaps of
huge pages") in v7.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fb40edc7439b99d001988da63485ca51dbd3550]
stable/7.2: [23d41b2e68765ad7095b1424f70c21c281f8a600]

CVE-2026-93181: perf/x86/intel/uncore: Fix uncore_box ref/unref ordering

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93181

Introduced by commit c74443d ("perf/x86/uncore: Support per PMU
cpumask") in v6.11-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [174f0582e38abe03b88e15f04bfe58490f88cb19]
stable/7.2: [64aa1bb4017d598828c6d8cd718f43daf2a83375]

CVE-2026-93182: sched/fair: Fix overflow in update_tg_cfs_runnable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93182

Introduced by commit 95246d1 ("sched/pelt: Relax the sync of
runnable_sum with runnable_avg") in v5.17-rc2.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f166adb5cb0525d9e32d45729fd8f28c80acbee]
stable/6.1: [39d707097a0820c6e87eff4195f0940e8ff1147e]
stable/6.12: [7cc237e3bc1733928313d2462b413ae441b0eef3]
stable/6.18: [18fdd0978ec3dda0ff6865cd273e47e022180710]
stable/6.6: [69fafae4eb2c9fc9bcff1bcbfcccf5d197434d75]
stable/7.2: [f94e62d21faad5e244d0874598a4d0ebbc0ea405]

CVE-2026-93183: drm/lima: call drm_mm_init() with a valid allocation range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93183

Introduced by commit a1d2a63 ("drm/lima: driver for ARM Mali4xx GPUs")
in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b3bce4a692ac60d9f4a341e6b597dd1fd0a28f9]
stable/5.10: [af1f276d50c9d7ebcd25770f358ca503a89d96d7]
stable/5.15: [fd6bc5f1d6b54047b06b82bab25a7e21e4b1c95a]
stable/6.1: [ad4e908096dff97646f77b04e2e2825225e215f7]
stable/6.12: [79a3331ee436c8b1454f897d539606c9b5ebdf9f]
stable/6.18: [e2a7cee341986cb5b544a8286edc7fb0494c592e]
stable/6.6: [788917ba77f5d69bd368c1d176ecceda346a2951]
stable/7.2: [e0773ad25a34a49aece176721c466cf214e02222]

CVE-2026-93184: ASoC: fsl_audmix: rework runtime PM handling in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93184

Introduced by commit be1df61 ("ASoC: fsl: Add Audio Mixer CPU DAI
driver") in v5.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3359ba93d01a23b2e4249e9e44ccfe48eb9c5d71]
stable/6.12: [b5c3f8015af442c2411722cf8c220cfbae271230]
stable/6.18: [e921cc73fae68ccee932ad0a4fb11d637557db0e]
stable/7.2: [22c944e440bc9b16c4ee409943d69bb8ef575c9e]

CVE-2026-93185: ASoC: rt700-sdw: always drain jack work on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93185

Introduced by commit 737ee8b ("ASoC: rt700-sdw: use cancel_work_sync()
in .remove as well as .suspend") in v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [612ccf42acd14bb2685fa60c3495ca13e63e8989]
stable/5.15: [f1e21b7b977f5ae2955ecf3ab144da2578a4fe00]
stable/6.1: [b81c2131dbb6fe04e27841bc719977c106177c61]
stable/6.12: [45fcf435ffcc5f61a43bd9b19094dc52de6cbc05]
stable/6.18: [1e8fddab6cbe536dd02e61205e4b9bf97df6479b]
stable/6.6: [1bb23c9d68312e77cec81bdfb2cc385e2d2960f7]
stable/7.2: [a47f087877bb2bc57c3ccb714fc49abf45d28e12]

CVE-2026-93186: cxl/mbox: Clamp mailbox output allocation to the payload size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93186

Introduced by commit 583fa5e ("cxl/mem: Add basic IOCTL interface") in
v5.12-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a13db9f899d149c3aab24abcb668121cfda5a4f]
stable/6.12: [f5d2bbf0300f46307948864fbb97bce5097f4fe2]
stable/6.18: [31d4841eca7c4b75751ca96d24339e19303337f2]
stable/7.2: [b4e11c731d6bee3b87315e055a1ca417c92dc1fc]

CVE-2026-93187: ASoC: SOF: ipc4-topology: Return error for invalid
number of formats

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93187

Introduced by commit 21a5adf ("ASoC: SOF: ipc4-topology: Validate the
number of in/out formats for src/asrc") in v7.2-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11e828cd6b0f283ebe9dc6b4cffd38e3321e7725]
stable/7.2: [4992cdc4eb97981d6ea66002c5b764a6115edb0c]

CVE-2026-93188: HID: roccat: bound device-supplied profile index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93188

Introduced by commit 14bf62c ("HID: add driver for Roccat Kone gaming
mouse") in v2.6.35-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43fae42628a8c10fa8981773d7ec9f1a367821a7]
stable/5.10: [686e5c3bd378933b4e795fcc7d40c5aad358eaaa]
stable/5.15: [0a139188a7ce4baab7acc5d60e0d1c8657f9b4d4]
stable/6.1: [67d7851f113fd0205dd27416d3c47ab32b176097]
stable/6.12: [579c78c8c317ecff8b6b820c227c93e6ec4e565d]
stable/6.18: [635914c60da26a9892f27ffb5edcc922a10effab]
stable/6.6: [4b29be4b23bc28f59def1485702887e395256e11]
stable/7.2: [99330b12376c3373ab555c24bc797630f03b81a2]

CVE-2026-93189: HID: core: quiesce input in hid_hw_stop() to prevent
use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93189

Introduced commit is not determined.Fixed in v7.3-rc1.


Fixed status
mainline: [a4bc41504690b7d7064931909874f5b98cd148b6]
stable/5.10: [0744cb9520aade37e78f69134f3111086158f1d2]
stable/5.15: [c876c437d188911685d8bed645416f2e86bd0354]
stable/6.1: [6787f1828f5616f17250e108c0031fb96fd2cfe6]
stable/6.12: [02246d8b462fd9bd90bc7ae7d6cab1acf69bcb87]
stable/6.18: [544ebb25bd58f67e821573412ab7a982b9e02211]
stable/6.6: [92cca302a4eaf65d1b38b3fb600b4ee5eb856a51]
stable/7.2: [0fecd89f979a8653b9a5b0816570329b7a94a081]

CVE-2026-93190: platform/chrome: cros_ec_typec: Reject out-of-bounds
PD cap count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93190

Introduced by commit 348a2e8 ("platform/chrome: cros_ec_typec:
Register partner PDOs") in v6.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0a8cd9fc9c48b95095bcec4b146f7a99486f58e]
stable/6.1: [7617b210a2200b76d8f171819390468c7d189c80]
stable/6.12: [2a7a4e45a3aa4f4ef7013eb64649f6184b76a293]
stable/6.18: [e4728288473a5024a8bdba7d43f346719606fea0]
stable/6.6: [4e37371cb4e3b8ff564d7760029236a7bd614562]
stable/7.2: [54d6b0ee9b8ba434089b11843effc111dc2e6ead]

CVE-2026-93191: smack: fix incorrect task context in smack_msg_queue_msgrcv

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93191

Introduced by commit e114e47 ("Smack: Simplified Mandatory Access
Control Kernel") in v2.6.25-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fba3d32825f4bbc8e20f0cdc3b14df57965b8fe5]
stable/5.10: [4e49f997ef0c569e09b42aab6bd38c7c54ea095d]
stable/5.15: [dbece6c2f80b0470d8d99d7a016827dce99ed6e3]
stable/6.1: [7be4bd21c50afa83c93799b0f16cf5bfa493194e]
stable/6.12: [e35dc5a4ed6d1e536382d80c685187511ff248a1]
stable/6.18: [c2ab27c2e11591524b1378c24ad18882a425d1fa]
stable/6.6: [ec47f4177046dfaaf1cebb15f4d2e7b543475daf]
stable/7.2: [d02c55e3ea82e41ea2c2026e08201e5daa4d0cfe]

CVE-2026-93192: drm/v3d: Clear queue->active_job when v3d_fence_create() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93192

Introduced by commit a783a09 ("drm/v3d: Refactor job management.") in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25a1669907512e927fab9ad4d4fb74ff57f63cd9]
stable/6.12: [bdeb73d7312100e00c3e643ff233f09b6ec114aa]
stable/6.18: [3a8aa74859dd73eaa76c55eb74da708e56ef51c5]
stable/7.2: [0b9878aba5cf93bc2b55ba9eb807757ce3239bec]

CVE-2026-93193: drm/rockchip: analogix_dp: Fix OF node reference leak
via auto cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93193

Introduced by commit 729f8ee ("drm/rockchip: analogix_dp: Add support
for RK3588") in v6.16-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87e060521371257ddbb77964b66e60d80afcc7b2]
stable/6.18: [396a193867c6e8ee810287d6f79624144b5629e9]
stable/7.2: [887315e5d2eb87c3d6d0da9f7610bc5b3113ae30]

CVE-2026-93194: drm/rockchip: dw_dp: Release core resources

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93194

Introduced by commit d68ba7b ("drm/rockchip: Add RK3588 DPTX output
support") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc6d7aca2f37a1525a94ef97eb3ce361732c876c]
stable/6.18: [362e005b816ee8052a195b98d845966689b398a1]
stable/7.2: [11f07929f454ecc2c5d0da3a4727fd205be43e49]

CVE-2026-93195: drm/bridge: synopsys: dw-dp: Support unregistering the
AUX channel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93195

Introduced by commit 86eecc3 ("drm/bridge: synopsys: Add DW DPTX
Controller support library") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed04e8e2307f35b3d8d49a554faf5e72d3d224e6]
stable/6.18: [b2bec2d4a769d5b7b8202123404c7cd1aec17861]
stable/7.2: [48aaa495e24ce5aec3dc56706473b0bd4305a306]

CVE-2026-93196: nvdimm: virtio_pmem: refcount requests for token lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93196

Introduced by commit 6e84200 ("virtio-pmem: Add virtio pmem driver")
in v5.3-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e57140944b5a47a7fd5a142faab29a02af040bc8]
stable/6.18: [be072a5d5e35f4bdf2da22f600b5d6dc6c5ff491]
stable/7.2: [b1e740b9156621afd4c4aa66257f4dde8df1febe]

CVE-2026-93197: memcg: move LRU size accounting on reparenting instead
of copying it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93197

Introduced by commit 07a6e9a ("mm: vmscan: prepare for reparenting
traditional LRU folios") in v7.1-rc1.
Introduced by commit f304652 ("mm: vmscan: prepare for reparenting
MGLRU folios") in v7.1-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e0ac326c511d514817cc7b6d7741afd59098ce2]
stable/7.2: [007bc1842317bb99f5f6205afede940f951674c2]

CVE-2026-93198: dm-pcache: validate the persisted dirty_tail chain at load

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93198

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [58d620ee9e01d4bdbceaf2ae1450d307a2a9d58b]
stable/6.18: [8195cf3f4a82ef49d9b0651c507ed0784caf23fb]
stable/7.2: [4822a030929e0e77aa380722dc42e3e4c9edd346]

CVE-2026-93199: i3c: master: Do not treat master device as a duplicate target

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93199

Introduced by commit 3a379bb ("i3c: Add core I3C infrastructure") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dc1b3eeba7991905a5b5b8129ebea51be7d87b7]
stable/6.18: [d0cc00957292e353ad46039034cd8f82fc4f8057]
stable/7.2: [150e71808d3715a0deefbb189c780d03fdbdc735]

CVE-2026-93200: i3c: master: Fix use-after-free of master->this

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93200

Introduced by commit 3a379bb ("i3c: Add core I3C infrastructure") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [feb0ed76601f3c2f91f08688c5a7d8b9d382f720]
stable/6.18: [4f3145db05fede36b35f8249b8acde5bd5d54864]
stable/7.2: [50034d8d0f797c3a7a599f750a7d3e792e80dea5]

CVE-2026-93201: dm-pcache: validate seg_id fields from persistent memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93201

Introduced by commit 1d57628 ("dm-pcache: add persistent cache target
in device-mapper") in v6.18-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [90c990a68460d7b5720e5634cf650eccdf0f4098]
stable/7.2: [b4bf8af5e7d7db4c5e179e15017da55857761ac4]

CVE-2026-93202: i3c: master: Fix recursive locking during device registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93202

Introduced by commit 3a379bb ("i3c: Add core I3C infrastructure") in v5.0-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [456f832e5fc26fbfd3b8200fd4553eee520cc377]
stable/6.18: [b25232f66e8cd653d0c6bfdbe534e62a2f9d6a1b]
stable/7.2: [9dc73c51ed3ee965c3ddb0ac31cf5c3eea68fa0c]

CVE-2026-93203: batman-adv: bla: avoid CRC corruption due to parallel claim add

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93203

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08645ab95768b88e2ff85a89211994651710465b]
stable/5.10: [3d4a9ae2c69c0fe4c3c69587288241243bb7a39b]
stable/5.15: [ad982d925f00d860d2467811256ffadcccd9e4a7]
stable/6.1: [d5b0e7574da5a485f4dbec32a15911900a4487c2]
stable/6.12: [1d390db003cbb52cdd86837608bff3794501a5ea]
stable/6.18: [8bcfa58c4277bff1882a23547c37ab08aa1de12f]
stable/6.6: [a3e07db74f22a85aeeb51c600da5c98b9cbca11f]
stable/7.2: [e54602d9e38db8573f2097d60c7ea8be0a5af1fa]

CVE-2026-93204: batman-adv: dat: atomically update mac addresses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-93204

Introduced by commit 2f1dfbe ("batman-adv: Distributed ARP Table -
implement local storage") in v3.8-rc1.
Fixed in v7.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6de568d3eda3e3c01c868fabd7a9535d5ee4a73]
stable/5.15: [159360a0de831845c4500b4f8638decdcd624040]
stable/6.1: [259db2c04586d40b82c5c3002b1e28b0698a0bb7]
stable/6.12: [66238e2a74eca5dabf85b0cd2c3c944e474dc2fd]
stable/6.18: [a5e4d6cb4f6848b8906c1c493f99a8ccc0638515]
stable/6.6: [1674855a5b6eacfe35f4db3095d7055c25467274]
stable/7.2: [f68038c77a2f38c09c7e2e4f7fa1f4e246fdf2c9]

CVE-2026-13087: A heap out-of-bounds write vulnerability was found in
the Linux kernel's
RPC-over-RDMA server reply path in net/sunrpc/xprtrdma/svc_rdma_sendto.c.
When a crafted RPC-over-RDMA client sends a large NFS READ request with an
empty Write list and no Reply chunk, the server linearizes the entire
multi-page reply into a fixed-size 4096-byte heap buffer without bounds
checking, resulting in a kernel heap overflow. This can lead to denial of
service via kernel crash or potential code execution through corruption of
adjacent kernel heap objects.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-13087


Introduced by e248aa7b ("svcrdma: Remove max_sge check at connect
time") in v5.0-rc6. Fixed by 0fbe20dfe ("svcrdma: Reject inline
replies that overflow the pull-up buffer") in 7.3-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [0fbe20dfe74b783d255bf389a6ea77aa25dc7860]
stable/6.12: [fcd91b9957462d398792201c239dffaeff1cc8b2]
stable/6.18: [1949dd1576f7a8aa161b1330c6125df9d53046d5]
stable/7.2: [8ec60eb51fae37cd3d334ff26e4a7d6fb21ff7cf]


* Updated CVEs

CVE-2025-40210: Revert "NFSD: Remove the cap on number of operations
per NFSv4 COMPOUND"

stable/6.12 was fixed.

Fixed status
stable/6.12: [cde00075007fee461d0cf504239ee4671fe58de0]

CVE-2026-68286: drop_monitor: perform u64_stats updates under
IRQ-disabled section

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [be9b121894d6ad44f0011f79543a2e3245979497]
stable/6.18: [7d857cf5f0120bb0e020fa20b03bd21b9d3e0c04]

CVE-2026-68287: drop_monitor: fix size calculations for 64-bit attributes

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [6048ed2dfb33426c8aef32f8d225ea91c66813db]
stable/6.18: [925669d4cfd47a9019ab29b40676215bab5dae35]

CVE-2026-68288: net: drop_monitor: fix info leak in NET_DM_ATTR_PAYLOAD

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [05173de42a9923a3eaadebcb0dd5bc83ffba174c]
stable/6.18: [89178ffe5bddc99c057ba2768db1f8d9c5e1408c]

CVE-2026-68289: tipc: fix integer overflow in tipc_recvmsg() and
tipc_recvstream()

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [1b6066313b9b8fac870483bf7a26d6bd56579747]
stable/6.18: [7364014fdc289225229eb08de8bcbf4580e78e4d]

CVE-2026-68303: drm/vc4: hvs/v3d: Fix null dereference in unbind

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [8f62aae059e06746a18a00af27179c3c0f17f4c7]
stable/6.18: [708688ec31ac6b35103ba364dc300a09930079d4]

CVE-2026-68337: bpf: Reject redirect helpers without a bpf_net_context

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [0f2118b757509332bb0e65f90e5233766f14bb88]
stable/6.18: [aafb093adffad91d4d071e8a7e0dcd9b1d91c94a]

CVE-2026-72334: Bluetooth: ISO: fix malformed ISO_END/CONT handling

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [49aeb54e3c912ef785311264a51ab9f3698e421b]
stable/6.18: [5e53e285f8c989662e34d4938c728a94226bff34]

CVE-2026-72355: netfs: Fix barriering when walking subrequest list

stable/6.18 was fixed.

Fixed status
stable/6.18: [4cca4b44e561a19c77cb1949ae6846da0539db40]

CVE-2026-72402: bpf: Mask pseudo pointer values in verifier logs

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [c727b3d50ecb0f4992a964360771040a84026914]
stable/6.18: [b96cb1235fcaa687291b1e1d910f0930d1939919]

CVE-2026-72413: sctp: fix err_chunk memory leaks in INIT handling

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [6acedac7a14af71cfe25024ead28e16a070899e4]
stable/6.18: [1cae40d423a2042c7970f29c00028951ec20db8a]

CVE-2026-72438: md/raid10: fix writes_pending and barrier reference
leaks on discard failures

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [fea33968592559a55a3f5a96a6386bebcaf988a8]
stable/6.18: [11b35d1906a7277a3d64afe34224133b44327328]

CVE-2026-72485: coresight: platform: defer connection counter
increment until alloc succeeds

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [aed6915c2f304ed34281856c53e374483c71b68b]
stable/6.18: [09c44549820df67048be3ba19c723bac72ebb98e]

CVE-2026-72494: RDMA/irdma: Replace waitqueue and flag with completion

stable/6.18 was fixed.

Fixed status
stable/6.18: [706591cccdd3ac2c0ddc8c2ed6c89a6be9865826]

CVE-2026-72496: RDMA/bnxt_re: Proper rollback if the ioremap fails

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [3c69ff7f4a761e18ce8abfa0c98e12097b39adaa]
stable/6.18: [f956477c343aa73e9d9c8d6ebf32efac7cd4f4e2]

CVE-2026-74258: bpf: Guard __get_user acesss with access_ok for
uprobe_multi data

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [2c387db784293256d35fd3d438f577cc82bb823d]
stable/6.18: [a9f1395028c2bbe18e57864cc355c11faff488cb]

CVE-2026-74269: bnxt: fix head underflow on XDP head-grow

stable/6.18 was fixed.

Fixed status
stable/6.18: [4c03275bc4435cc8e25f7f3f08aff58c0e783d8d]

CVE-2026-74289: ipv4: fib: Don't dump dying fib_info in fib_leaf_notify().

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [7980a13add57f97c5da1dc961d0145a6ad2a7f98]
stable/6.18: [bea03e887db5a8a79234531faf14cf2c4d8816c3]

CVE-2026-74291: ASoC: topology: Check PCM and DAI name strings before use

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [473f7d25d93e80db526a9d05887f0071abdc6d9b]
stable/6.18: [5c2537cf24d673956b4e58029001667f89586fa2]

CVE-2026-74294: ASoC: meson: aiu: Validate written enum values

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [8a6d6735e7c02e88841cca1497ff3d8089f2ef24]
stable/6.18: [96f5b92d958bc34500500f29fab8e0b908f25397]

CVE-2026-74347: netfilter: cttimeout: detach dataplane timeout policy
and repurpose refcount

stable/6.18 was fixed.

Fixed status
stable/6.18: [44583fd5735cb0bdf3bfe11b1e51504ce387bdb7]

CVE-2026-74407: wifi: ath11k: cancel SSR work items during PCI shutdown

stable/6.18 was fixed.

Fixed status
stable/6.18: [6dd3701facc0cee62d6682e49eed64499f9d0e43]

CVE-2026-74496: fou: Fix use-after-free in fou_create()

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [58835985c035a8333742f829ad7e0889a082f9d3]
stable/6.18: [9042867d4701728f0c6527215b11471759904d8f]

CVE-2026-74521: ksmbd: use memcmp() to compare ClientGUIDs

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [ba2a5b66f1d414eb8403d655f8813783892cfc85]
stable/6.18: [a386c83043015a703e227775f778e40343f45911]

CVE-2026-74735: l2tp: fix tunnel and session refcount leak on seq_file release

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [bdf83613781956cc39798ed08321f74ab0467f4d]
stable/6.18: [8c4fde01bcf91f22b9c7ded8c3e14addd7ddd500]

CVE-2026-80521: af_unix: Unlink scc_entry in unix_del_edge().

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [1293fd69a50d188a5788b08ba3741a3e86be1608]
stable/6.18: [fe198b077864feafd4aa4b33b1a5ce26f50195a2]

CVE-2026-80836: crypto: virtio - bound the akcipher result length

stable/6.12 was fixed.

Fixed status
stable/6.12: [12c4f29e97f31b013f77ad65ba7daeb02aaa6abe]

CVE-2026-80841: net/packet: defer vmalloc TX_RING free until skbs finish

stable/6.12 was fixed.

Fixed status
stable/6.12: [4ce6e2d2e38055b2012bd5fdb0c8a8183c8a1b0c]

CVE-2026-80847: tcp: clamp route advmss to TCP_MIN_MSS

stable/6.12 was fixed.

Fixed status
stable/6.12: [eaf4af9bd6975c2eff8d48820937c83032d968dc]

CVE-2026-80860: fuse: fix race between interrupt and resend

stable/6.12 was fixed.

Fixed status
stable/6.12: [67ddf061790e833d7e34f9dc901866c9fb25d72d]

CVE-2026-80861: usb: xhci: bail out of setup if the controller is inaccessible

stable/6.12 was fixed.

Fixed status
stable/6.12: [70706dbcf122940f4e3595d7ba1445004cc00074]

CVE-2026-80925: vlan: fix skb_under_panic and races when toggling HW
VLAN offload

stable/6.12 was fixed.

Fixed status
stable/6.12: [b30fe4de285b9bdaf9508740191f69f7cd83b8fa]

CVE-2026-80926: ksmbd: fix use-after-free in oplock break notification

stable/6.12 was fixed.

Fixed status
stable/6.12: [5de0527f782430b1109a447646e32033ad018a6a]

CVE-2026-80945: crypto: iaa - unmap dst before software fallback on decompress

stable/6.12 was fixed.

Fixed status
stable/6.12: [c0279e5ea2aad99d8b91f1a6579d751cc9eb2408]

CVE-2026-89492: ocfs2: validate directory-index entry counts when
reading metadata

stable/6.12 was fixed.

Fixed status
stable/6.12: [5e661f55ca8568471fce558effe81cca112f5cb2]

CVE-2026-89535: svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id

stable/6.12 was fixed.

Fixed status
stable/6.12: [fcd4a752ac840d39356f4d2a424d3aca4e39716b]

CVE-2026-89543: sunrpc: fix use-after-free in __rpc_clnt_handle_event
and __rpc_clnt_remove_pipedir

stable/6.12 was fixed.

Fixed status
stable/6.12: [59527bbfb1eabdb28e95e7c725886cc2c2899cb3]

CVE-2026-89544: SUNRPC: fix gssx_dec_option_array error path bugs

stable/6.12 was fixed.

Fixed status
stable/6.12: [fb30241f7ccace372ee83017891549f23a715581]

CVE-2026-89545: sunrpc: defer rq_argp and rq_resp free until after RCU
grace period

stable/6.12 was fixed.

Fixed status
stable/6.12: [0ea49d69aa806008b2424c8cf21cf746b9963967]

CVE-2026-89561: ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()

stable/6.12 was fixed.

Fixed status
stable/6.12: [e7123e10c86eb88eaa90537dd1f232706de2d308]

CVE-2026-89564: ip: orphan prefetched skbs before multicast forwarding

stable/6.12 was fixed.

Fixed status
stable/6.12: [e62aef7d6a5b27569bf540bbe11a9482117ff588]

CVE-2026-89572: cpufreq: apple-soc: Fix OPP table cleanup

stable/6.12 was fixed.

Fixed status
stable/6.12: [d28ad9bb050e80770f0b644304cb75932e289238]

CVE-2026-89589: acpi/apei/ghes: Use raw_spinlock_t for CXL CPER work locks

stable/6.12 was fixed.

Fixed status
stable/6.12: [cbc27a4302a1feb0ff77c1755021837a738b0ce9]

CVE-2026-89602: erofs: skip sufficiently large global buffers when resizing

stable/6.12 was fixed.

Fixed status
stable/6.12: [3fbdd15d5830f52661eb78be95058d101cb0c2cb]

CVE-2026-89622: HID: mcp2221: clear rxbuf after I2C/SMBus transfer completes

stable/6.12 was fixed.

Fixed status
stable/6.12: [d6c6b293173c0ea87189501cbd77e8fa677814a1]

CVE-2026-89624: HID: universal-pidff: stop the device when
force-feedback init fails

stable/6.12 was fixed.

Fixed status
stable/6.12: [519fa26695b02870022fcdc651efb3d379abe54e]

CVE-2026-89625: HID: sony: fix UAF of ghl_poke_timer / ghl_urb at driver unbind

stable/6.12 was fixed.

Fixed status
stable/6.12: [0e3d42ef008f0931e3878b4f1b046b6e45a95bde]

CVE-2026-89644: btrfs: fix extent map leak in NOCOW direct I/O write

stable/6.12 was fixed.

Fixed status
stable/6.12: [b7c873765875645b11503f94c9bae2ca80127375]

CVE-2026-89659: NFSD: Prevent client use-after-free during delegation revoke

stable/6.12 was fixed.

Fixed status
stable/6.12: [0dd276b1324a5e08e83c6f675919946c9f0d61c9]

CVE-2026-89660: NFSD: Prevent client use-after-free during admin state
revocation

stable/6.12 was fixed.

Fixed status
stable/6.12: [e1ba4d3c5bfdca3f013b8cbc829ae2f7975d8608]

CVE-2026-89667: nfsd: close shrinker/GC/fsnotify vs per-net shutdown
race in filecache

stable/6.12 was fixed.

Fixed status
stable/6.12: [b15997b53b61c74fb4d083f7261d19f389ff854f]

CVE-2026-89676: nfsd: fix stale s2s_cp_stateids IDR entry for async COPY

stable/6.12 was fixed.

Fixed status
stable/6.12: [7aa34ea78f74e6ef60c8112635a87fc43d57f6c9]

CVE-2026-89685: nfsd: fix clock domain mismatch in clients_still_reclaiming()

stable/6.12 was fixed.

Fixed status
stable/6.12: [e92e80c5b043108029bc729b30d12c37158fb9cb]

CVE-2026-89693: nfsd: check nfsd4_acl_to_attr() return value in nfsd4_create()

stable/6.12 was fixed.

Fixed status
stable/6.12: [26877d3a09afb3838a053867a655ca30c46a1f81]

CVE-2026-89698: nfsd: widen nfsd_genl_rqstp address fields to sockaddr_storage

stable/6.12 was fixed.

Fixed status
stable/6.12: [9a2e791639a1c5cac3f219b0d2632835d8f88d27]

CVE-2026-89700: nfsd: validate sockaddr length per family in listener_set

stable/6.12 was fixed.

Fixed status
stable/6.12: [bf85a0f1e45258f90ceeec14772b5769697dfd75]

CVE-2026-89708: nfsd: RCU-protect cl_cb_session to fix use-after-free
on session teardown

stable/6.12 was fixed.

Fixed status
stable/6.12: [2775ec1d617e665eab71ce0f13ab1f7959713a2b]

CVE-2026-89717: zram: set default primary compressor in zram_destroy_comps()

stable/6.12 was fixed.

Fixed status
stable/6.12: [4bf3328eeec9afc2a55632ff47fc18101ea62d73]

CVE-2026-89718: zram: fix out-of-bounds access in writeback_store()

stable/6.12 was fixed.

Fixed status
stable/6.12: [4d82d60178b02797dbe529e01ac211b26670c49f]

CVE-2026-89719: zram: fix out-of-bounds access in read_block_state()

stable/6.12 was fixed.

Fixed status
stable/6.12: [6d52c1f43ff39ea1ebf8f016e847677f0b60cf2b]

CVE-2026-89731: cxl/ras: Fix cxl_rch_get_aer_info() out-of-bounds AER
register read

stable/6.12 was fixed.

Fixed status
stable/6.12: [7f5a2a330dde8e8aa2dd80e1f3e05b6ada049607]

CVE-2026-89755: mm/migrate_device: clear stale mapping after freeing swapcache

stable/6.12 was fixed.

Fixed status
stable/6.12: [4fa91f7bbc4135240b67daac03fc17d9e180a331]

CVE-2026-89763: KEYS: trusted: Fix TPM teardown ordering

stable/6.12 was fixed.

Fixed status
stable/6.12: [3d67b4acbfc7af331d887a8efc04bef6573b8a7a]

CVE-2026-89792: ksmbd: prevent out-of-bounds reads in share config responses

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [ffa507f5f774cb4d45136b106989ebc051361263]
stable/6.18: [cd2bcee450bc94770be56c0b896c1a1dc6838bd8]

CVE-2026-89796: mm/damon/core: avoid infinite kdamond_merge_regions()
internal loop

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [769c16699c89811386eb003c8fd9dcb8d405b316]
stable/6.18: [50a7a5aec1aa43efc297fd4377c1cbdc7d15620d]

CVE-2026-89798: rpcrdma: arm rn_done before publishing the notification

stable/6.12 was fixed.

Fixed status
stable/6.12: [f9fe3cad43c42d874a388583552b39b411d886eb]

CVE-2026-89799: bpf: Disable preemption in bpf_get_stackid

stable/6.12 was fixed.

Fixed status
stable/6.12: [18c71e4b65ee60b8611fc071bdd7159f10185117]

CVE-2026-89815: drm/ttm: Drop tt->restore after successful restore

stable/6.18 was fixed.

Fixed status
stable/6.18: [329ddc5d438f991f49e4fd24c704d1c7288d5e03]

CVE-2026-89827: drm/amdgpu: avoid force-completing uninitialized UVD rings

stable/6.18 was fixed.

Fixed status
stable/6.18: [dc136795f9997adc8d3219f40e8e3afa7df7183f]

CVE-2026-89838: f2fs: limit recovery filename logging to stored length

stable/6.18 was fixed.

Fixed status
stable/6.18: [35c5abccd0924b02ad34126f562d93c8d75b0831]

CVE-2026-89840: f2fs: validate MOVE_RANGE destination size

stable/6.18 was fixed.

Fixed status
stable/6.18: [db13064669526494cd78ba3a4394063b740e940c]

CVE-2026-89859: scsi: qla2xxx: Zero dport diagnostics buffer to avoid info leak

stable/6.18 was fixed.

Fixed status
stable/6.18: [d6e2411516bb95e52cb74c9c56b60ad2548a2730]

CVE-2026-89868: media: chips-media: wave5: Add timeout while stop_streaming

stable/6.18 was fixed.

Fixed status
stable/6.18: [c343348473e716882249bacf9297d6c363665fd9]

CVE-2026-90036: NFSD: Prevent client use-after-free during blocked-lock reaping

stable/6.12 was fixed.

Fixed status
stable/6.12: [7081224a59a0ca4edcd62c068588f4d900199a18]

CVE-2026-90037: NFSD: Prevent client use-after-free during close_lru reaping

stable/6.12 was fixed.

Fixed status
stable/6.12: [0763482227822f7343557f086afc382086d56c4c]

CVE-2026-90039: NFSD: Guard admin state-revocation walks with NFSD_NET_UP

stable/6.12 was fixed.

Fixed status
stable/6.12: [73bf459d696ecf207a9037bf9bb70c51a459469e]

CVE-2026-90041: HID: sony: clean up device list on probe failure

stable/6.12 was fixed.

Fixed status
stable/6.12: [b84544ef00a27e8081498d33af7dac33b6cb8418]

CVE-2026-90042: ceph: properly decrypt filenames in vmalloc() buffers

stable/6.12 was fixed.

Fixed status
stable/6.12: [93729594af506557a86f8b603be7ac5f3370eeca]

CVE-2026-90044: usb: gadget: f_fs: Fix Use-After-Free in AIO error path

stable/6.12 was fixed.

Fixed status
stable/6.12: [b5f0e80a03e87bd932487e03248eae3ba3ed7b45]

CVE-2026-90045: USB: gadget: ffs: fix mm lifetime handling

stable/6.12 was fixed.

Fixed status
stable/6.12: [1625827648f4e1595ea6ba5521bc87ee5088b32b]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

