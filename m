Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C88C109E52D
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 23:18:44 +0000 (UTC)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.36114.1774480716703786368
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 16:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=1dvBazLk;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78fc4425b6bso4139237b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 16:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774480716; cv=none;
        d=google.com; s=arc-20240605;
        b=Y4F6IctKCfETRYTdYhe0nCBITSQF4ttFCCVW9scDWiIRzUQBxev8+YjB3M1mq7blOn
         qZglp6lqFa2PwSuhylvZ8obIFMlXWVvAfne4Mm+aRKna4q76QwaI8VOnflARQ7hutHzj
         4A9ezjDbq2foAZnmoj1PZmZC5mhuak3JCB1lW4+bK7De+ktHJWGzkzZmQVgYhPYO1+FU
         k0JURYbwx2UrhVw3djNjiKEjK6MzeOXDYGtws0D+bO/SNOnvWiSU6fdgIwsfeuduNAWw
         rnUpGSdfWu93rCm0RtmojTlwhkT48qHClmIneVIDwPFpk7j9qLLzPHEb1jIjqDRsmW/Q
         hR8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=5I1bJIMod3f5iOPpv6J2sG8+1HTwUSYj6jHvgtMyTxM=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=g2GWW4YF/qX9jmsOtZIbmeXNf7LvhNZD0XLa2FyzlDmfZ7yxcpq/Ye3/Sh3ooMRRdg
         nOE0nSekiGMdSqyVJjBvhu7719z7ABbdcdfYj7hlsMg1A7KFQMkuUbp23QZxBku4DkDD
         DIB7cYvAaRqrPZe8ayWfG2dhIgQNkeirTB+WH+FHnXj7WSFPBFLIWGPyVXGMN3fkJvw0
         x6/izJwjUo1tyngIgtYvM63HQDxMPNOO5+XyGBj/UAl5BhIm6Tl9NFYnfTd4ixcjVI0k
         6YMM09ydqJR53WwZYcp9w6Ue9ktGw2oXwON+1aCIV3salLpzl5sD12mrRdWx1lqgPsHA
         0p1g==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1774480716; x=1775085516; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5I1bJIMod3f5iOPpv6J2sG8+1HTwUSYj6jHvgtMyTxM=;
        b=1dvBazLkctUIYVXLYKmSHUCecYd/0ib1HoUXw7m1cyRF0yxeQWQYKcXknNvRzYRGQc
         ZR0/zTye0tyZr6IAO0ElSfwaKGpufsOm6s2wHK6NovOT030jCLN12I+dialOQ8RYqU5x
         OXnp4jdyZALAuauqaey+7sJ1MAPR7MHhn+u36NFY0gDZ9mQxwAAFAvjNeDkE/7mVFXSX
         hpMtmh+ZaFEyAvLQVCoUehyEhNfm//Ma1/2h8QA2o0N5T2zpECD4xC6J75dRjU5x1ff1
         iKWecYDLBtNIvGow79B+rl1A/mjpg4ejuZLL2QKwsdRFGc4s6IjoE9KWIBUYG4XE+Cmk
         cnYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774480716; x=1775085516;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5I1bJIMod3f5iOPpv6J2sG8+1HTwUSYj6jHvgtMyTxM=;
        b=qY+EmchE54wBlmCnqXvm+9ZUvxMzdCZCgABJ51EcYoogAvwywP8KaoVuUFABkbIOZF
         I2scC/eHbcIlkaMoYR2TCC8DvJN+qqLrLCIMWT3orybbSvteaKUfjtJV1yop51AUe7Ru
         03GFJrSq0HjSKq4yEOFEgDVXXb0J3XHsGmHATjXsRO0S2Fn8YRh4gdXfD+578kzKgero
         ouDROCm0MAZhvPchZMPRF9M8jVfSOE0GCnDkladDpFMAwE9gGNTmdEkbH8SEkEAGNzkJ
         +Wg2ZBLQRf+LXdNAOVqg0HrecShYrB66DZ1+HscT5td6t+aMJ11DwJop87fP6CYorZ1H
         VFUQ==
X-Gm-Message-State: AOJu0YynqdFtYwWGFTx4vkvTtF1omqAFRkuoqvJIW3nlAG3xo4sPm1yR
	ufhJAoNiXWKfA4T5CSnLonWSQpuP+qJF27jvPI1+iOFAlPjA5XYfM25laxMEZHarFdn/Aw23cbc
	ZLJP3NMdtj/HcG62lpH0lac6XNFKNHKpyeWqrZ6EaQVzfJWHmIrXJdVs=
X-Gm-Gg: ATEYQzwHvbiI2ZQsNEvEEvP1/1CguFAkvzKk7Oz4jVF8zrerGD9mQIq76XSBjDFFmlf
	xjbUxQ8TbjbT35gTzrFs0gp9ZCnxFvsudi+F6PFCkk3ux8MpNoXpFOTqiuBD8t1sz8WEm+/fhwg
	UBhieVruhQJRp69UvEg0pIP+JbiwXW01umOKfw1VgvuymUGy+l2eLo6OkFMLbO03kBv5y/Fpdey
	ZrChX0f1HG3xaghOv0gLGlFwY7WGnEnWtbC9Anf5jkZVAC+5r+EMGJN/nsoqoIiQTpA8GszpOkx
	cO57SIBw
X-Received: by 2002:a05:690c:f06:b0:79a:c659:6756 with SMTP id
 00721157ae682-79acf3c064emr58008587b3.21.1774480713322; Wed, 25 Mar 2026
 16:18:33 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 26 Mar 2026 08:17:56 +0900
X-Gm-Features: AaiRm52YlxRfszdp6xnxq0KMPjgiUzWtCuly3fC_PCr-dh630AUsODJJsat_qqE
Message-ID: <CAODzB9o_aic=kB7qtXhOBpN2YvUewySvA8awc5xiXOMhwNepJg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 23:18:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22570

Hi!

It's this week's CVE report.

This week reported 125 new CVEs and 66 updated CVEs.

* New CVEs
CVE-2026-23271: perf: Fix __perf_event_overflow() vs
perf_remove_from_context() race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23271

Introduced by commit 592903c ("perf_counter: add an event_list") in v2.6.31-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9bc1753b3cc41d0e01fbca7f035258b5f4db0ae]
stable/6.1: [4df1a45819e50993cb351682a6ae8e7ed2d233a0]
stable/6.12: [5c48fdc4b4623533d86e279f51531a7ba212eb87]
stable/6.18: [3f89b61dd504c5b6711de9759e053b082f9abf12]
stable/6.19: [bb190628fe5f2a73ba762a9972ba16c5e895f73e]
stable/6.6: [4f8d5812337871227bb2c98669a87c306a2f86ef]

CVE-2026-23272: netfilter: nf_tables: unconditionally bump set->nelems
before insertion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23272

Introduced by commit 35d0ac9 ("netfilter: nf_tables: fix set->nelems
counting with no NLM_F_EXCL") in v4.10-rc6.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [def602e498a4f951da95c95b1b8ce8ae68aa733a]
stable/6.18: [6826131c7674329335ca25df2550163eb8a1fd0c]
stable/6.19: [ccb8c8f3c1127cf34d18c737309897c68046bf21]

CVE-2026-23273: macvlan: observe an RCU grace period in
macvlan_common_newlink() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23273

Introduced by commit f8db647 ("macvlan: fix error recovery in
macvlan_common_newlink()") in v6.19.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12
stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [e3f000f0dee1bfab52e2e61ca6a3835d9e187e35]
stable/5.10: [91e4ff8d966978901630fc29582c1a76d3c6e46c]
stable/5.15: [3d94323c80d7fc4da5f10f9bb06a45d39d5d3cc4]
stable/6.1: [721eb342d9ba19bad5c4815ea3921465158b7362]
stable/6.12: [a1f686d273d129b45712d95f4095843b864466bd]
stable/6.18: [d34f7a8aa9a25b7e64e0e46e444697c0f702374d]
stable/6.19: [1e58ae87ad1e6e24368dea9aec9048c758cd0e2b]
stable/6.6: [19c7d8ac51988d053709c1e85bd8482076af845d]

CVE-2026-23274: netfilter: xt_IDLETIMER: reject rev0 reuse of ALARM timer labels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23274

Introduced by commit 68983a3 ("netfilter: xtables: Add snapshot of
hardidletimer target") in v5.7-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [329f0b9b48ee6ab59d1ab72fef55fe8c6463a6cf]
stable/6.1: [28c7cfaf0c0ab17cbd7754092116fd1af45271f9]
stable/6.12: [5e7ece24c5cb75a60402aad4d803c7898ea40aa9]
stable/6.18: [f5ef97c13165542480a6ffdbe6f09f40bbb7cbf1]
stable/6.19: [f228b9ae2a7e84d1153616d8e71c4236cb1f1309]
stable/6.6: [54080355999381fed4a26129579a5765bab87491]

CVE-2026-23275: io_uring: ensure ctx->rings is stable for task work
flags manipulation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23275

Introduced by commit 79cfe9e ("io_uring/register: add
IORING_REGISTER_RESIZE_RINGS") in v6.13-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96189080265e6bb5dde3a4afbaf947af493e3f82]
stable/6.18: [7cc4530b3e952d4a5947e1e55d06620d8845d4f5]
stable/6.19: [46dc07d5f31411cc023f3bf1f4a23a07bf6e0ed1]

CVE-2026-23276: net: add xmit recursion limit to tunnel xmit functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23276

Introduced by commit 745e20f ("net: add a recursion limit in xmit
path") in v2.6.37-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f1a9140ecda3baba3d945b9a6155af4268aafc4]
stable/6.12: [834c4f645726a25fd71ea50cdfb5c135f8f95d85]
stable/6.18: [8a57deeb256069f262957d8012418559ff66c385]
stable/6.19: [b56b8d19bd05e2a8338385c770bc2b60590bc81e]

CVE-2026-23277: net/sched: teql: fix NULL pointer dereference in
iptunnel_xmit on TEQL slave xmit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23277

Introduced by commit 039f506 ("ip_tunnel: Move stats update to
iptunnel_xmit()") in v4.5-rc1.
Fixed in v7.0-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cc0c2e661af418bbf7074179ea5cfffc0a5c466]
stable/6.1: [57c153249143333bbf4ecf927bdf8aa2696ee397]
stable/6.12: [81a43e8005366f16e629d8c95dfe05beaa8d36a7]
stable/6.18: [0bad9c86edd22dec4df83c2b29872d66fd8a2ff4]
stable/6.19: [21ea283c2750c8307aa35ee832b0951cc993c27d]
stable/6.6: [59b06d8b9bdb6b64b3c534c18da68bce5ccd31be]

CVE-2026-23278: netfilter: nf_tables: always walk all pending catchall elements

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23278

Introduced by commit 628bd3e ("netfilter: nf_tables: drop map element
references from preparation phase") in v6.4.
Fixed in v7.0-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [7cb9a23d7ae40a702577d3d8bacb7026f04ac2a9]
stable/6.12: [eb0948fa13298212c5f8b30ee48efdae4389ab09]
stable/6.18: [de47a88c6b807910f05703fb6605f7efdaa11417]
stable/6.19: [77c26b5056d693ffe5e9f040e946251cdb55ae55]

CVE-2026-23279: wifi: mac80211: fix NULL pointer dereference in
mesh_rx_csa_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23279

Introduced by commit 8f2535b ("mac80211: process the CSA frame for
mesh accordingly") in v3.13-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [017c1792525064a723971f0216e6ef86a8c7af11]
stable/6.1: [2b5f282b1b7241ef624c3399a1cdff0bb1a3eeab]
stable/6.12: [f5d8af683410a8c82e48b51291915bd612523d9a]
stable/6.18: [cc6d5a3c0a854aeae00915fc5386570c86029c60]
stable/6.19: [be8b82c567fda86f2cbb43b7208825125bb31421]
stable/6.6: [22a9adea7e26d236406edc0ea00b54351dd56b9c]

CVE-2026-23280: accel/amdxdna: Prevent ubuf size overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23280

Introduced by commit bd72d4a ("accel/amdxdna: Support user space
allocated buffer") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03808abb1d868aed7478a11a82e5bb4b3f1ca6d6]
stable/6.18: [1500b31db94374a6669e73ce94d6f71cf8e85e06]
stable/6.19: [972bf4a23478fcb247b4f507d47a584bc8aea5bd]

CVE-2026-23281: wifi: libertas: fix use-after-free in lbs_free_adapter()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23281

Introduced by commit 8f641d9 ("libertas: detect TX lockups and reset
hardware") in v3.2-rc1.
Introduced by commit 954ee16 ("[PATCH] libertas: reorganize and
simplify init sequence") in v2.6.24-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03cc8f90d0537fcd4985c3319b4fafbf2e3fb1f0]
stable/6.1: [3f9dec4a6d95d7f1f5e9e9dfdfa173c053bba8dc]
stable/6.12: [d0155fe68f31b339961cf2d4f92937d57e9384e6]
stable/6.18: [ed7d30f90b77f73a47498686ede83f622b7e4f0d]
stable/6.19: [a9f55b14486426d907459bced5825a25063bd922]
stable/6.6: [3c5c818c78b03a1725f3dcd566865c77b48dd3a6]

CVE-2026-23282: smb: client: fix oops due to uninitialised var in smb2_unlink()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23282

Introduced by commit 1cf9f2a ("smb: client: handle unlink(2) of files
open by different clients") in v6.17.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [048efe129a297256d3c2088cf8d79515ff5ec864]
stable/6.18: [86163b98891aa9800f6103252e5acc7bb98afb91]
stable/6.19: [dc710c87af3341554d02d634ada1d2036c49a94a]

CVE-2026-23283: regulator: fp9931: Fix PM runtime reference leak in
fp9931_hwmon_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23283

Introduced by commit 12d821b ("regulator: Add FP9931/JD9930 driver")
in v6.19-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0902010c8d163f7b62e655efda1a843529152c7c]
stable/6.19: [ada571018d54c2381bab7c290577114f9667cda7]

CVE-2026-23284: net: ethernet: mtk_eth_soc: Reset prog ptr to old_prog
in case of error in mtk_xdp_setup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23284

Introduced by commit 7c26c20 ("net: ethernet: mtk_eth_soc: add basic
XDP support") in v6.0-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0abc73c8a40fd64ac1739c90bb4f42c418d27a5e]
stable/6.1: [8c2d76a9658a4dbfcf02f2693a97e2d5ff42197a]
stable/6.12: [b73dfe1ea7be7a072482434643b517d7726f4c8d]
stable/6.18: [6f95b59520278a72df9905db791b7ea31375fbc1]
stable/6.19: [ff14cd44c85c20ad69479db73698185de291550c]
stable/6.6: [29629dd7d37349e9fb605375a75de44ac8926ea9]

CVE-2026-23285: drbd: fix null-pointer dereference on local read error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23285

According to the .vulnerable file, this bug was introduced by commit
0d11f3c in v6.4-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d195d3b205ca90db30d70d09d7bb6909aac178f]
stable/6.12: [1e906c08594c8f9a6a524f38ede2c4e051196106]
stable/6.18: [4e8935053ba389ae8d6685c10854d8021931bd89]
stable/6.19: [91df51d2df0ca4fd3281f73626341563d64a98a5]
stable/6.6: [6f1d1614f841d91a4169db65812ffd1271735b42]

CVE-2026-23286: atm: lec: fix null-ptr-deref in lec_arp_clear_vccs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23286

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [101bacb303e89dc2e0640ae6a5e0fb97c4eb45bb]
stable/6.1: [e9665986eb127290ceb535bd5d04d7a84265d94f]
stable/6.12: [2d9f57ea29a1f1772373b98a509b44d49fda609e]
stable/6.18: [7ea92ab075d809ec8a96669a5ecf00f752057875]
stable/6.19: [5f1cfea7921f5c126a441d973690eeba52677b64]
stable/6.6: [622062f24644b4536d3f437e0cf7a8c4bb421665]

CVE-2026-23287: irqchip/sifive-plic: Fix frozen interrupt due to
affinity setting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23287

Introduced by commit cc9f04f ("irqchip/sifive-plic: Implement
irq_set_affinity() for SMP host") in v5.1-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1072020685f4b81f6efad3b412cdae0bd62bb043]
stable/6.1: [8942fb1a5bc2dcbd88f7e656d109d42f778f298f]
stable/6.12: [686eb378a4a51aa967e08337dd59daade16aec0f]
stable/6.18: [1883332bf21feb8871af09daf604fc4836a76925]
stable/6.19: [f611791a927141d05d7030607dea6372311c1413]
stable/6.6: [2edbd173309165d103be6c73bd83e459dc45ae7b]

CVE-2026-23288: accel/amdxdna: Fix out-of-bounds memset in command slot handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23288

Introduced by commit 3d32eb7 ("accel/amdxdna: Fix cu_idx being cleared
by memset() during command setup") in v7.0-rc1.
Fixed in v7.0-rc2.

Bug introduced commit was backported to following branches.
stable/6.19

Fixed status
mainline: [1110a949675ebd56b3f0286e664ea543f745801c]
stable/6.19: [cca770d710d5e03bc814af585cd6975eb6d74074]

CVE-2026-23289: IB/mthca: Add missed mthca_unmap_user_db() for
mthca_create_srq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23289

Introduced by commit ec34a92 ("[PATCH] IB/mthca: Add SRQ
implementation") in v2.6.20.16.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [117942ca43e2e3c3d121faae530989931b7f67e1]
stable/6.1: [f67f1ad4029e9fa183141546de31987b254c9292]
stable/6.12: [da8eaa73bc37d004350ba68eb18b6ade8e49db52]
stable/6.18: [deee46b37ebd8cc5ff810127883fca90f2412a7b]
stable/6.19: [972b72d7e2d8fe1400f1c7a8304c282c539b7e02]
stable/6.6: [d0148965dbca8cc8efa7e3d6e99940487bf661c0]

CVE-2026-23290: net: usb: pegasus: validate USB endpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23290

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11de1d3ae5565ed22ef1f89d73d8f2d00322c699]
stable/6.1: [43d7c4114b1ec14f41f09306525d3b9382286fc1]
stable/6.12: [95556b4e879711693c9865ba0938c148f62d5ea4]
stable/6.18: [c3f1672eaea68c5cb6e1ec081cdb92045453218f]
stable/6.19: [ee31ec8cf1eafeefa85ef934ba688d27f88bf0e2]
stable/6.6: [7f8505c7ce3f186ef9d2495f3c0bd6ad6fce999f]

CVE-2026-23291: nfc: pn533: properly drop the usb interface reference
on disconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23291

Introduced by commit c46ee38 ("NFC: pn533: add NXP pn533 nfc device
driver") in v3.1-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12133a483dfa832241fbbf09321109a0ea8a520e]
stable/6.1: [7398d6570501edc55a50ece820f369ab3c1df2e7]
stable/6.12: [7ff14eb070f0efecb2606f8d7aa01b77d188e886]
stable/6.18: [00477cab053dc4816b99141d8fcca7a479cfebeb]
stable/6.19: [4551d6cea00224ab65a0ef35e4e6da0e9c0a2d74]
stable/6.6: [d1f6d20b3c2642ec85ce6ea5da7155746c31c6d0]

CVE-2026-23292: scsi: target: Fix recursive locking in __configfs_open_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23292

According to the .vulnerable file, this bug was introduced by commit
b0841ee in v5.3-rc8.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [14d4ac19d1895397532eec407433c5d74d9da53b]
stable/6.1: [3161ef61f121d4573cad5b57c92188dcd9b284b3]
stable/6.12: [4fcfa424a581d823cb1a9676e3eefe6ca17e453a]
stable/6.18: [9a5641024fbfd9b24fe65984ad85fea10a3ae438]
stable/6.19: [142eacb50fb903a4c10dee7e67b6e79ebb36a582]
stable/6.6: [e8ef82cb6443d5f3260b1b830e17f03dda4229ea]

CVE-2026-23293: net: vxlan: fix nd_tbl NULL dereference when IPv6 is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23293

Introduced by commit e15a00a ("vxlan: add ipv6 route short circuit
support") in v3.12-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [168ff39e4758897d2eee4756977d036d52884c7e]
stable/6.1: [b5190fcd75a1f1785c766a8d1e44d3938e168f45]
stable/6.12: [f0373e9317bc904e7bdb123d3106fe4f3cea2fb7]
stable/6.18: [fbbd2118982c55fb9b0a753ae0cf7194e77149fb]
stable/6.19: [abcd48ecdeb2e12eccb8339a35534c757782afcd]
stable/6.6: [5f93e6b4d12bd3a4517a6d447ea675f448f21434]

CVE-2026-23294: bpf: Fix race in devmap on PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23294

Introduced by commit 3253cb4 ("softirq: Allow to drop the softirq-BKL
lock on PREEMPT_RT") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1872e75375c40add4a35990de3be77b5741c252c]
stable/6.18: [6c10b019785dc282c5f45d21e4a3f468b8fd6476]
stable/6.19: [ab1a56c9d99189aa5c6e03940d06e40ba6a28240]

CVE-2026-23295: accel/amdxdna: Fix dead lock for suspend and resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23295

Introduced by commit 063db45 ("accel/amdxdna: Enhance runtime power
management") in v6.19-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aa82181a3c285c7351523d587f7981ae4c015c8]
stable/6.19: [ac24537478dd8eb2fd3984b4652bb19461e5e74c]

CVE-2026-23296: scsi: core: Fix refcount leak for tagset_refcnt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23296

Introduced by commit 8fe4ce5 ("scsi: core: Fix a use-after-free") in v6.0-rc5.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [1ac22c8eae81366101597d48360718dff9b9d980]
stable/6.1: [9f5e4abed9248448aa1b45b12ab0bea4d329b56a]
stable/6.12: [ec5c17c687b189dbc09dfdec11b669caa40bc395]
stable/6.18: [944a333c8e4d42256556c1d2ebb6d773a33e0dcd]
stable/6.19: [a03d96598d39fdf605d90731db3ef3b13fb8bdc8]
stable/6.6: [7c01b680beaf4d3143866b062b8e770e8b237fb8]

CVE-2026-23297: nfsd: Fix cred ref leak in nfsd_nl_threads_set_doit().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23297

Introduced by commit 924f4fb ("NFSD: convert write_threads to netlink
command") in v6.10-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cb968a2013ffa8112d52ebe605009ea1c6a582c]
stable/6.12: [41170716421c25cd20b39e83f0e0762e212b377b]
stable/6.18: [27c13c5bb0948e3b5c64e59f8a903231896fab9b]
stable/6.19: [a3f88e3e18b51a7f654189189c762ebcdeaa7e29]

CVE-2026-23298: can: ucan: Fix infinite loop from zero-length messages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23298

Introduced by commit 9f2d3ea ("can: ucan: add driver for Theobroma
Systems UCAN devices") in v4.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e446fd0582ad8be9f6dafb115fc2e7245f9bea7]
stable/6.1: [ab6f075492d37368b4c7b0df7f7fdc2b666887fc]
stable/6.12: [bd85f21a6219aeae4389d700c54f1799f4b814e0]
stable/6.18: [aa9e0a7fe5efc2f74327fd37d828e9a51d9ff588]
stable/6.19: [c7bc62be6c1a60bb21301692009590b1ffda91d9]
stable/6.6: [13b646eec3ba1131180803f5aaf1fee23540ad8f]

CVE-2026-23299: Bluetooth: purge error queues in socket destructors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23299

Introduced by commit 134f4b3 ("Bluetooth: add support for skb TX
SND/COMPLETION timestamping") in v6.15-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21e4271e65094172aadd5beb8caea95dd0fbf6d7]
stable/6.18: [2b6c942a526635f5c61d2f000258e620da32d3a7]
stable/6.19: [3de7c10a950b36affc692d8bd2ac713852580e56]

CVE-2026-23300: net: ipv6: fix panic when IPv4 route references
loopback IPv6 nexthop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23300

Introduced by commit 493ced1 ("ipv4: Allow routes to use nexthop
objects") in v5.3-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21ec92774d1536f71bdc90b0e3d052eff99cf093]
stable/6.1: [b5062fc2150614c9ea8a611c2e0cb6e047ebfa3a]
stable/6.12: [f7c9f8e3607440fe39300efbaf46cf7b5eecb23f]
stable/6.18: [b3b5a037d520afe3d5276e653bc0ff516bbda34c]
stable/6.19: [8650db85b4259d2885d2a80fbc2317ce24194133]
stable/6.6: [b299121e7453d23faddf464087dff513a495b4fc]

CVE-2026-23301: ASoC: SDCA: Add allocation failure check for Entity name

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23301

Introduced by commit 48fa77a ("ASoC: SDCA: Add terminal type into
input/output widget name") in v6.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27990181031fdcdbe0f7c46011f6404e5d116386]
stable/6.19: [bdcc10a86055beb7109a786d94abf5626f375bbd]

CVE-2026-23302: net: annotate data-races around sk->sk_{data_ready,write_space}

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23302

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ef2b20cf4e04ac8a6ba68493f8780776ff84300]
stable/6.18: [f17c1c4acbe2bd702abce73a847a04a196fab2c5]
stable/6.19: [27fccdbcbbfc4651b6f66756e6fa3f52e051ec23]

CVE-2026-23303: smb: client: Don't log plaintext credentials in
cifs_set_cifscreds

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23303

Introduced by commit 8a8798a ("cifs: fetch credentials out of keyring
for non-krb5 auth multiuser mounts") in v3.3-rc2.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f37dc436d4e61ff7ae0b0353cf91b8c10396e4d]
stable/6.1: [ff0ece8ed04180c52167c003362284b23cf54e8d]
stable/6.12: [b746a357abfb8fdb0a171d51ec5091e786d34be1]
stable/6.18: [2ef0fc3bf49db2b9df36d5f44508c9e384bfa2a1]
stable/6.19: [3e182701db612ddd794ccd5ed822e6cc1db2b972]
stable/6.6: [3990f352bb0adc8688d0949a9c13e3110570eb61]

CVE-2026-23304: ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23304

Introduced by commit 4832c30 ("net: ipv6: put host and anycast routes
on device with address") in v4.14-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ffb4f5c2ccb2fa1c049dd11899aee7967deef5a]
stable/6.1: [4a48fe59f29f673a3d042d679f26629a9c3e29d4]
stable/6.12: [3310fc11fc47387d1dd4759b0bc961643ea11c7f]
stable/6.18: [0b5a7826020706057cc5a9d9009e667027f221ee]
stable/6.19: [ae88c8256547b63980770a9ea7be73a15900d27e]
stable/6.6: [581800298313c9fd75e94985e6d37d21b7e35d34]

CVE-2026-23305: accel/rocket: fix unwinding in error path in rocket_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23305

Introduced by commit 0810d5a ("accel/rocket: Add job submission
IOCTL") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34f4495a7f72895776b81969639f527c99eb12b9]
stable/6.18: [7fc4b49474c836cee7d9801abf05e0198fcbfa74]
stable/6.19: [eeaf28c8f4defe371a008a5ddefaf18abf534f81]

CVE-2026-23306: scsi: pm8001: Fix use-after-free in pm8001_queue_command()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23306

Introduced by commit e29c47f ("scsi: pm8001: Simplify
pm8001_task_exec()") in v5.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38353c26db28efd984f51d426eac2396d299cca7]
stable/6.1: [ebbb852ffbc952b95ddb7e3872b67b3e74c6da47]
stable/6.12: [c5dc39f8ae055520fd778b7fb0423f11586f15c4]
stable/6.18: [824a7672e3540962d5c77d4c6666254d7aa6f0b3]
stable/6.19: [227ff4af00abc40b95123cc27ee8079069dcd8d7]
stable/6.6: [8b00427317ba7b7ec91252b034009f638d0f311b]

CVE-2026-23307: can: ems_usb: ems_usb_read_bulk_callback(): check the
proper length of a message

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23307

Introduced by commit 702171a ("ems_usb: Added support for EMS
CPC-USB/ARM7 CAN/USB interface") in v2.6.32-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38a01c9700b0dcafe97dfa9dc7531bf4a245deff]
stable/6.1: [c703bbf8e9b4947e111c88d2ed09236a6772a471]
stable/6.12: [18f75b9cbdc3703f15965425ab69dee509b07785]
stable/6.18: [1cf469026d4a2308eaa91d04dca4a900d07a5c2e]
stable/6.19: [2833e13e2b099546abf5d40a483b4eb04ddd1f7b]
stable/6.6: [1818974e1b5ef200e27f144c8cb8a246420bb54d]

CVE-2026-23308: pinctrl: equilibrium: fix warning trace on load

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23308

Introduced by commit 52066a5 ("pinctrl: equilibrium: Convert to
immutable irq_chip") in v6.4-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e00b1b332e54ba50cca6691f628b9c06574024f]
stable/6.12: [af3b0ec98dc1133521b612f8009fdd36b612aabe]
stable/6.18: [53eba152810ef0fff8567b13ea0f62d48e62df6b]
stable/6.19: [ec54546e8d8a50a9824c139a127a8459d1b0b1bb]
stable/6.6: [896449ad9053a42c6c710aeae6175170176cabd0]

CVE-2026-23309: tracing: Add NULL pointer check to trigger_data_free()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23309

Introduced by commit 0550069 ("tracing: Properly process error
handling in event_hist_trigger_parse()") in v7.0-rc1.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.19 stable/6.6

Fixed status
mainline: [457965c13f0837a289c9164b842d0860133f6274]
stable/6.1: [13dcd9269e225e4c4ceabdaeebe2ce4661b54c6e]
stable/6.12: [42b380f97d65e76e7b310facd525f730272daf57]
stable/6.18: [2ce8ece5a78da67834db7728edc801889a64f643]
stable/6.19: [477469223b2b840f436ce204333de87cb17e5d93]
stable/6.6: [59c15b9cc453b74beb9f04c6c398717e73612dc3]

CVE-2026-23310: bpf/bonding: reject vlan+srcmac xmit_hash_policy
change when XDP is loaded

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23310

Introduced by commit 39a0876 ("net, bonding: Disallow vlan+srcmac with
XDP") in v5.15-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [479d589b40b836442bbdadc3fdb37f001bb67f26]
stable/6.12: [d36ad7e126c6a0c5f699583309ccc37e3a3263ea]
stable/6.18: [0ace8027e41f6f094ef6c1aca42d2ed6cd7af54e]
stable/6.19: [e85fa809e507b9d8eff4840888b8c727e4e8448c]
stable/6.6: [5c262bd0e39320a6d6c8277cb8349ce21c01b8c1]

CVE-2026-23311: perf/core: Fix invalid wait context in ctx_sched_in()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23311

Introduced by commit f4b07fd ("perf/core: Use POLLHUP for a pinned
event in error") in v6.15-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [486ff5ad49bc50315bcaf6d45f04a33ef0a45ced]
stable/6.18: [c67ab059953e3b66cb17ddd6524c23f9e1f6526d]
stable/6.19: [825f218ca70ef394c2b8546b313711d867b24584]

CVE-2026-23312: net: usb: kaweth: validate USB endpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23312

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b063c002ca759d1b299988ee23f564c9609c875]
stable/6.1: [7c7ebf5e45d2504d92ea294ac3828d58586491df]
stable/6.12: [f33e80d195a003b384620ee240f69092b519146b]
stable/6.18: [2795fc06e7652c0ba299d936c584d5e08b6b57a1]
stable/6.19: [0aae18e4638a7c1c579df92bc6edc36cedfaaa8c]
stable/6.6: [72f90f481c6a059680b9b976695d4cfb04fba1f3]

CVE-2026-23313: i40e: Fix preempt count leak in napi poll tracepoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23313

Introduced by commit 6d4d584 ("i40e: Add i40e_napi_poll tracepoint")
in v6.2-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b3d54a85bd37ebf2d9836f0d0de775c0ff21af9]
stable/6.12: [b7e91827e1cf89cd34ad11dc8f8c010b70ab786e]
stable/6.18: [9e0f091821571f0da387462803ee42f0bb157582]
stable/6.19: [dca4ea596a3b0a1b82bc1d9f3e4d88bd9ad9561f]

CVE-2026-23314: regulator: bq257xx: Fix device node reference leak in
bq257xx_reg_dt_parse_gpio()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23314

Introduced by commit 981dd16 ("regulator: bq257xx: Add bq257xx boost
regulator driver") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4baaddaa44af01cd4ce239493060738fd0881835]
stable/6.18: [93b64bef8cd4074806d981ed1b4c38c3ae0542e3]
stable/6.19: [aba54a5a113667df9d339f4192650f6bc27e9d1f]

CVE-2026-23315: wifi: mt76: Fix possible oob access in
mt76_connac2_mac_write_txwi_80211()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23315

Introduced by commit 577dbc6 ("mt76: mt7915: enable offloading of
sequence number assignment") in v5.10-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e10a730d1b511ff49723371ed6d694dd1b2c785]
stable/6.1: [84419556359bc96d3fe1623d47a64c86542566cc]
stable/6.12: [7b692dff8df0ba5feb8df00f27d906d6eb1fe627]
stable/6.18: [9612d91f617231e03c49cb9b0c02f975a3b4f51f]
stable/6.19: [0fb3b94a9431a3800717e5c3b6fa2e1045a15029]
stable/6.6: [7ae7b093b7dba9548a3bc4766b9364b97db4732d]

CVE-2026-23316: net: ipv4: fix ARM64 alignment fault in multipath hash seed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23316

Introduced by commit 4ee2a8c ("net: ipv4: Add a sysctl to set
multipath hash seed") in v6.11-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ee7fa6cf78ff26d783d39e2949d14c4c1cd5e7f]
stable/6.12: [4bdc94d45d5459f0149085dfc1efe733c8e14f11]
stable/6.18: [7e4ad34a8889a6a9e0f6cc7c55d02161fe31a199]
stable/6.19: [607e923a3c1b2120de430b3dcde25ed8ad213c0a]

CVE-2026-23317: drm/vmwgfx: Return the correct value in
vmw_translate_ptr functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23317

Introduced by commit a309c71 ("drm/vmwgfx: Remove rcu locks from user
resources") in v6.2-rc4.
Fixed in v7.0-rc2.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [5023ca80f9589295cb60735016e39fc5cc714243]
stable/6.1: [ce3a5cf139787c186d5d54336107298cacaad2b9]
stable/6.12: [36cb28b6d303a81e6ed4536017090e85e0143e42]
stable/6.18: [531f45589787799aa81b63e1e1f8e71db5d93dd1]
stable/6.19: [149f028772fa2879d9316b924ce948a6a0877e45]
stable/6.6: [7e55d0788b362c93660b80cc5603031bbbdefa98]

CVE-2026-23318: ALSA: usb-audio: Use correct version for UAC3 header validation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23318

Introduced by commit 57f8770 ("ALSA: usb-audio: More validations of
descriptor units") in v5.4-rc1.
Fixed in v7.0-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [54f9d645a5453d0bfece0c465d34aaf072ea99fa]
stable/6.1: [0dcd1ed96c03459cf14706885c9dd3c1fd8bd29f]
stable/6.12: [d3904ca40515272681ae61ad6f561c24f190957f]
stable/6.18: [1e5753ff4c2e86aa88516f97a224c90a3d0b133e]
stable/6.19: [499ffd15b00dc91ac95c28f76959dfb5cdcc84d5]
stable/6.6: [a0c6ae2ea84528f198bf7fd0117f12fd0cf6d7cc]

CVE-2026-23319: bpf: Fix a UAF issue in bpf_trampoline_link_cgroup_shim

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23319

Introduced by commit 69fd337 ("bpf: per-cgroup lsm flavor") in v6.0-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56145d237385ca0e7ca9ff7b226aaf2eb8ef368b]
stable/6.1: [529e685e522b9d7fb379dbe6929dcdf520e34c8c]
stable/6.12: [cfcfa0ca0212162aa472551266038e8fd6768cff]
stable/6.18: [3eeddb80191f7626ec1ef742bfff51ec3b0fa5c2]
stable/6.19: [4e8a0005d633a4adc98e3b65d5080f93b90d356b]
stable/6.6: [9b02c5c4147f8af8ed783c8deb5df927a55c3951]

CVE-2026-23320: usb: gadget: f_ncm: align net_device lifecycle with bind/unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23320

Introduced by commit 40d133d ("usb: gadget: f_ncm: convert to new
function interface with backward compatibility") in v3.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56a512a9b4107079f68701e7d55da8507eb963d9]
stable/6.18: [b62076e780a2121903ecf9ffdfb89c64647cb7da]
stable/6.19: [188338c1827842f898761a939669cf345bdf07e2]

CVE-2026-23321: mptcp: pm: in-kernel: always mark signal+subflow endp as used

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23321

Introduced by commit 85df533 ("mptcp: pm: do not ignore 'subflow' if
'signal' flag is also set") in v6.11-rc3.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [579a752464a64cb5f9139102f0e6b90a1f595ceb]
stable/6.1: [c5c877e140e5f46023a74a51e577ce5edd0a4be7]
stable/6.12: [67f34ab318807989b57dfdb0f79e2d4e57018290]
stable/6.18: [a64aa7db39392add5be09dffaedbf1f0ce5554df]
stable/6.19: [198824ccfa64ffebd918bf99c939bd8170a4a4d8]
stable/6.6: [05799c2f1ca5eb13d65764dda688d02021b65e06]

CVE-2026-23322: ipmi: Fix use-after-free and list corruption on sender error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23322

Introduced by commit 9cf93a8 ("ipmi: Allow an SMI sender to return an
error") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [594c11d0e1d445f580898a2b8c850f2e3f099368]
stable/6.18: [c08ec55617cb9674a060a3392ea08391ab2a4f74]
stable/6.19: [65ff5d1e4410df05edfbeb7bf2d62f7681ce1d53]

CVE-2026-23323: hwmon: (macsmc) Fix regressions in Apple Silicon SMC
hwmon driver

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23323

Introduced by commit 785205f ("hwmon: Add Apple Silicon SMC hwmon
driver") in v6.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5dd69b864911ae3847365e8bafe7854e79fbeecb]
stable/6.19: [625ef35b70d3883fb9a41cd5a988e64dd3e447d6]

CVE-2026-23324: can: usb: etas_es58x: correctly anchor the urb in the
read bulk callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23324

Introduced by commit 8537257 ("can: etas_es58x: add core support for
ETAS ES58X CAN USB interfaces") in v5.13-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eaad4f768266f1f17e01232ffe2ef009f8129b7]
stable/6.1: [2185ea6e4ebcb61d1224dc7d187c59723cb5ad59]
stable/6.12: [b878444519fa03a3edd287d1963cf79ef78be2f1]
stable/6.18: [18eee279e9b5bff0db1aca9475ae4bc12804f05c]
stable/6.19: [b8f9ca88253574638bcff38900a4c28d570b1919]
stable/6.6: [f6e90c113c92e83fc0963d5e60e16b0e8a268981]

CVE-2026-23325: wifi: mt76: mt7996: Fix possible oob access in
mt7996_mac_write_txwi_80211()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23325

Introduced by commit 98686cd ("wifi: mt76: mt7996: add driver for
MediaTek Wi-Fi 7 (802.11be) devices") in v6.2-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60862846308627e9e15546bb647a00de44deb27b]
stable/6.12: [ca1adc04fc2cb1d9f1842e429debe6a520d54966]
stable/6.18: [f4cdf6b43689e901a341e7147fcfb25057c38eae]
stable/6.19: [45661d22639c4b747ef1bd0822b8e76e421a808a]
stable/6.6: [a6605f61913155e130bfd04d438c3ce1a572fb0f]

CVE-2026-23326: xsk: Fix fragment node deletion to prevent buffer leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23326

Introduced by commit b692bf9 ("xsk: Get rid of
xdp_buff_xsk::xskb_list_node") in v6.13-rc1.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.6

Fixed status
mainline: [60abb0ac11dccd6b98fd9182bc5f85b621688861]
stable/6.12: [2a9ea988465ece5b6896b1bdc144170a64e84c35]
stable/6.18: [645c6d8376ad4913cbffe0e0c2cca0c4febbe596]
stable/6.19: [b38cbd4af5034635cff109e08788c63f956f3a69]
stable/6.6: [5172adf9efb8298a52f4dcdc3f98d4d9d1e06a6d]

CVE-2026-23327: cxl/mbox: validate payload size before accessing
contents in cxl_payload_from_user_allowed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23327

Introduced by commit 6179045 ("cxl/mbox: Block immediate mode in
SET_PARTITION_INFO command") in v5.19-rc1.
Introduced by commit 206f9fa ("cxl/mbox: Add Clear Log mailbox
command") in v6.10-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60b5d1f68338aff2c5af0113f04aefa7169c50c2]
stable/6.19: [7c8a7b7f063b7e7ae9bba4cbaa14a5d2fe3a55e1]

CVE-2026-23328: accel/amdxdna: Fix NULL pointer dereference of mgmt_chann

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23328

Introduced by commit b87f920 ("accel/amdxdna: Support hardware
mailbox") in v6.14-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6270ee26e1edd862ea17e3eba148ca8fb2c99dc9]
stable/6.19: [032ca7a9059c4ba6c329e0f1b442dab54dd9c3e5]

CVE-2026-23329: libie: don't unroll if fwlog isn't supported

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23329

Introduced by commit 641585b ("ixgbe: fwlog support for e610") in v6.18-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [636cc3bd12f499c74eaf5dc9a7d5b832f1bb24ed]
stable/6.18: [0138d1cdb19fa49181a5aaba32427f1787cb3935]
stable/6.19: [460c56ecbef57684aad1d6af525b89dcd3565701]

CVE-2026-23330: nfc: nci: complete pending data exchange on device close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23330

Introduced by commit 38f04c6 ("NFC: protect nci_data_exchange
transactions") in v3.2-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66083581945bd5b8e99fe49b5aeb83d03f62d053]
stable/6.18: [91ff0d8c3464da7f0c43da38c195e60b660128bf]
stable/6.19: [d05f55d68ebdebb2b0a8480d766eaae88c8c92de]

CVE-2026-23331: udp: Unhash auto-bound connected sk from 4-tuple hash
table when disconnected.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23331

Introduced by commit 78c91ae ("ipv4/udp: Add 4-tuple hash for
connected socket") in v6.13-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6996a2d2d0a64808c19c98002aeb5d9d1b2df6a4]
stable/6.18: [b955350778b8715e1b7885179979b3a68221c0fb]
stable/6.19: [3b8f104880c104151f8c30f2f89df81fb59a286c]

CVE-2026-23332: cpufreq: intel_pstate: Fix crash during turbo disable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23332

Introduced by commit 973207a ("cpufreq: intel_pstate: Rearrange max
frequency updates handling code") in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b050482ec40569429d963ac52afa878691b04c9]
stable/6.18: [a1850e2aef4d15405e7ff53fd51c4b3124d46182]
stable/6.19: [d20d48916ce8531b157c2edeba76d69af2974270]

CVE-2026-23333: netfilter: nft_set_rbtree: validate open interval overlap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23333


Introduced by 7c84d41 ("netfilter: nft_set_rbtree: Detect partial
overlaps on insertion") in v5.6. Fixed by 6489469 ("netfilter:
nft_set_rbtree: validate open interval overlap") in v7.0-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [648946966a08e4cb1a71619e3d1b12bd7642de7b]
stable/6.18: [12b1681793e9b7552495290785a3570c539f409d]
stable/6.19: [6db2be971e3d70c9e3f85d39eff7103c2ee2f579]

CVE-2026-23334: can: usb: f81604: handle short interrupt urb messages properly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23334

Introduced by commit 88da174 ("can: usb: f81604: add Fintek F81604
support") in v6.5-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7299b1b39a255f6092ce4ec0b65f66e9d6a357af]
stable/6.12: [c5d69da6c919648838734097861e979677eedcde]
stable/6.18: [36ead57443146e6b730ce1f48ca3e9b17e19a3d2]
stable/6.19: [66615e6293388f75a56226d1216fd9cfb3d95e05]
stable/6.6: [9b740ff5bc649575a5e14ca8ee54e3dd5010aaf0]

CVE-2026-23335: RDMA/irdma: Fix kernel stack leak in irdma_create_user_ah()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23335

Introduced by commit b48c24c ("RDMA/irdma: Implement device supported
verb APIs") in v5.14-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74586c6da9ea222a61c98394f2fc0a604748438c]
stable/6.1: [14b47c07c69930254f549a17ee245c80a65b1609]
stable/6.12: [2fd37450d271d74b3847baed284f9cfdf198c6f8]
stable/6.18: [cfe962216c164fe2b1c1fb6ac925a7413f5abc84]
stable/6.19: [c9bd0007c4bdb7806bbd323287e50f9cf467c51a]
stable/6.6: [1b1fac4c7a3ab7f52e9cfb91e5c91216646ca4d8]

CVE-2026-23336: wifi: cfg80211: cancel rfkill_block work in wiphy_unregister()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23336

Introduced by commit 1f87f7d ("cfg80211: add rfkill support") in v2.6.31-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [767d23ade706d5fa51c36168e92a9c5533c351a1]
stable/6.1: [eeea8da43ab86ac0a6b9cec225eec91564346940]
stable/6.12: [57e39fe8da573435fa35975f414f4dc17d9f8449]
stable/6.18: [584279ad9ff1e8e7c5494b9fce286201f7d1f9e2]
stable/6.19: [cd2f52944c7b95dcdfe0d87f385a2d96458a3ae5]
stable/6.6: [fa18639deab4a3662d543200c5bfc29bf4e23173]

CVE-2026-23337: pinctrl: pinconf-generic: Fix memory leak in
pinconf_generic_parse_dt_config()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23337

Introduced by commit 90a18c5 ("pinctrl: pinconf-generic: Handle string
values for generic properties") in v6.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a648d598cb8e8c62af3f0e020a25820a3f3a9a7]
stable/6.19: [63ee429780a5d43b5b4406c6128109b0f47cf2f1]

CVE-2026-23338: drm/amdgpu/userq: Do not allow userspace to trivially
triger kernel warnings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23338

Introduced by commit a292fde ("drm/amdgpu: Implement userqueue
signal/wait IOCTL") in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b7d7693a55d606d700beb9549c9f7f0e5d9c24f]
stable/6.18: [1753f5f81ab60a553287f9ee659a6ac363adf8d7]
stable/6.19: [7321302edca3a349ddaea689df95b986beee6c4a]

CVE-2026-23339: nfc: nci: free skb on nci_transceive early error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23339

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7bd4b0c4779f978a6528c9b7937d2ca18e936e2c]
stable/6.1: [33f6b8a96dda045789796c3bcb451c74ac158039]
stable/6.12: [3245801d44a44c090acefe19a12d22d12cac45c5]
stable/6.18: [9d448bbab724b94d6c561e1f314656f5b88a7cb3]
stable/6.19: [54f7f0eaafa56b5994cdb5c7967946922c2e1d22]
stable/6.6: [dcbcccfc5195c9caaa4bb8d31f23c345f00a9e89]

CVE-2026-23340: net: sched: avoid qdisc_reset_all_tx_gt() vs dequeue
race for lockless qdiscs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23340

Introduced by commit 6b3ba91 ("net: sched: allow qdiscs to handle
locking") in v4.16-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f083faf59d14c04e01ec05a7507f036c965acf8]
stable/6.1: [7594467c49bfc2f4644dee0415ac2290db11fa0d]
stable/6.12: [5bc4e69306ed7ae02232eb4c0b23ed621a26d504]
stable/6.18: [8314944cc3bdeaa5a73e6f8a8cf0d94822e625cb]
stable/6.19: [c69df4e0524f8de8e176ba389acd83e85f5f49d0]
stable/6.6: [dbd58b0730aa06ab6ad26079cf9a5b6b58e7e750]

CVE-2026-23341: accel/amdxdna: Fix crash when destroying a suspended
hardware context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23341

Introduced by commit 97f2757 ("accel/amdxdna: Fix potential NULL
pointer dereference in context cleanup") in v7.0-rc1.
Fixed in v7.0-rc2.

Bug introduced commit was backported to following branches.
stable/6.19

Fixed status
mainline: [8363c02863332992a1822688da41f881d88d1631]
stable/6.19: [a6317704edab95d66a62fc1861d9546284ab678e]

CVE-2026-23342: bpf: Fix race in cpumap on PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23342

Introduced by commit 3253cb4 ("softirq: Allow to drop the softirq-BKL
lock on PREEMPT_RT") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [869c63d5975d55e97f6b168e885452b3da20ea47]
stable/6.18: [7466ae2aeed483de80c5d8dea0913cf74038b652]
stable/6.19: [e67299e1044349ad0088d52c6bc5764cc1816c06]

CVE-2026-23343: xdp: produce a warning when calculated tailroom is negative

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23343

Introduced by commit bf25146 ("bpf: add frags support to the
bpf_xdp_adjust_tail() API") in v5.18-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8821e857759be9db3cde337ad328b71fe5c8a55f]
stable/6.1: [01379540452a02bbc52f639d45dd365cd3624efb]
stable/6.12: [c7c790a07697148c41e2d03eb28efe132adda749]
stable/6.18: [98cd8b4d0b836d3edf70161f40efd9cbb8c8f252]
stable/6.19: [94b9da7e9f958cb3d115b21eff824ecd8c3217aa]
stable/6.6: [a0fb59f527d03c60b2cd547cfae4a842ad84670f]

CVE-2026-23344: crypto: ccp - Fix use-after-free on error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23344


Introduced by 88da174 ("can: usb: f81604: add Fintek F81604 support")
in v6.5-rc1. Fixed by 7299b1b ("can: usb: f81604: handle short
interrupt urb messages properly") in v7.0-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7299b1b39a255f6092ce4ec0b65f66e9d6a357af]
stable/6.12: [c5d69da6c919648838734097861e979677eedcde]
stable/6.18: [36ead57443146e6b730ce1f48ca3e9b17e19a3d2]
stable/6.19: [66615e6293388f75a56226d1216fd9cfb3d95e05]
stable/6.6: [9b740ff5bc649575a5e14ca8ee54e3dd5010aaf0]

CVE-2026-23345: arm64: gcs: Do not set PTE_SHARED on GCS mappings if
FEAT_LPA2 is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23345

Introduced by commit 6497b66 ("arm64/mm: Map pages for guarded control
stack") in v6.13-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a85b3131225a8c8143ba2ae29c0eef8c1f9117f]
stable/6.18: [ca1684dd297bf0725c1d487cff80e615497accf6]
stable/6.19: [1df3ef7e612d6ccbae5a48e1121553c47c2123d6]

CVE-2026-23346: arm64: io: Extract user memory type in ioremap_prot()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23346

Introduced by commit 893dea9 ("arm64: Add HAVE_IOREMAP_PROT support")
in v6.0-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f098037139b294050053123ab2bc0f819d08932]
stable/6.18: [3d64dcc0799c2d6921ba027716b7be721eb19fa8]
stable/6.19: [d1ad8fe7f72d73e1617bac79f2ec7a3bedf47e2a]

CVE-2026-23347: can: usb: f81604: correctly anchor the urb in the read
bulk callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23347

Introduced by commit 88da174 ("can: usb: f81604: add Fintek F81604
support") in v6.5-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [952caa5da10bed22be09612433964f6877ba0dde]
stable/6.12: [c001214e12202338425d6dda5d2a1919d674282d]
stable/6.18: [f6d80b104f904a6da922907394eec66d3e2ffc57]
stable/6.19: [7724645c4792914cd07f36718816c5369cc57970]
stable/6.6: [54ee74307165b348b2fddcd7942eb48fb4ee1237]

CVE-2026-23348: cxl: Fix race of nvdimm_bus object when creating nvdimm objects

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23348

Introduced by commit 8fdcb17 ("cxl/pmem: Add initial infrastructure
for pmem support") in v5.14-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [96a1fd0d84b17360840f344826897fa71049870e]
stable/6.18: [5fc4e150c5ada5f7d20d8f9f1b351f10481fbdf7]
stable/6.19: [5b230daeee420833287cc77314439903e5312f10]

CVE-2026-23349: HID: pidff: Fix condition effect bit clearing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23349

Introduced by commit 7f3d7bc ("HID: pidff: Better quirk assigment when
searching for fields") in v6.18-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97d5c8f5c09a604c4873c8348f58de3cea69a7df]
stable/6.18: [d1edc027a4b0bb4c7a2670b530590b4df6177011]
stable/6.19: [ef0e669dbceaf3d7bb4ae0b235fa61feabd92b0b]

CVE-2026-23350: drm/xe/queue: Call fini on exec queue creation fail

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23350

Introduced by commit 3c1fa4a ("drm/xe: Move queue init before LRC
creation") in v6.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99f9b5343cae80eb0dfe050baf6c86d722b3ba2e]
stable/6.19: [fae65b8a4449ae556990efcde8d74bec4adc5925]

CVE-2026-23351: netfilter: nft_set_pipapo: split gc into unlink and
reclaim phase

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23351

Introduced by commit 3c4287f ("nf_tables: Add set type for arbitrary
concatenation of ranges") in v5.6-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9df95785d3d8302f7c066050117b04cd3c2048c2]
stable/6.1: [16f3595c0441d87dfa005c47d8f95be213afaa9e]
stable/6.12: [c12d570d71920903a1a0468b7d13b085203d0c93]
stable/6.18: [500a50a301ce962b019ab95053ac70264fec2c21]
stable/6.19: [aff13667708dfa0dce136b8efd81baa9fa6ef261]
stable/6.6: [7864c667aed01a58b87ca518a631322cd0ac34c0]

CVE-2026-23352: x86/efi: defer freeing of boot services memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23352

Introduced by commit 916f676 ("x86, efi: Retain boot service code
until after switching to virtual mode") in v3.0-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4b0bf6a40f3c107c67a24fbc614510ef5719980]
stable/6.1: [227688312fece0026fc67a00ba9a0b3611ebe95d]
stable/6.12: [399da820ecfe6f4f10c143e5c453d3559a04db9c]
stable/6.18: [f9e9cc320854a76a39e7bc92d144554f3a727fad]
stable/6.19: [7dcf59422a3b0d20ddda844f856b4a1e0608a326]
stable/6.6: [6a25e25279282c5c8ade554c04c6ab9dc7902c64]

CVE-2026-23353: ice: fix crash in ethtool offline loopback test

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23353

Introduced by commit 93f53db ("ice: switch to Page Pool") in v6.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9c354e656597aededa027d63d2ff0973f6b033f]
stable/6.19: [85c98b81849e4724ae99005a6cccd33cab9cfd18]

CVE-2026-23354: x86/fred: Correct speculative safety in fred_extint()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23354

Introduced by commit 14619d9 ("x86/fred: FRED entry/exit and dispatch
code") in v6.9-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa280a08e7d8fae58557acc345b36b3dc329d595]
stable/6.12: [3bc5887b0a2b06d2d9c22f1f4f8500490b3ae643]
stable/6.18: [e58f1a9b0677de24dcfee0b21393446ec92ff120]
stable/6.19: [92caa5274b99cb6729177232a029ce0dfa6c5f7b]

CVE-2026-23355: ata: libata: cancel pending work after clearing deferred_qc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23355

Introduced by commit 0ea8408 ("ata: libata-scsi: avoid Non-NCQ command
starvation") in v7.0-rc1.
Introduced by commit eddb98a ("ata: libata-eh: correctly handle
deferred qc timeouts") in v7.0-rc2.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.18 stable/6.19

Fixed status
mainline: [aac9b27f7c1f2b2cf7f50a9ca633ecbbcaf22af9]
stable/6.12: [0d12453818c35e1ded84633152c6b05002ae48b9]
stable/6.18: [6c5e8f16b5e8e614e829aaf38619bdd79107bb0a]
stable/6.19: [58e658763ba2aa9168d8516b98a6314d7461a53e]

CVE-2026-23356: drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23356

According to the .vulnerable file, this bug was introduced by commit
08a1dda in v3.10-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab140365fb62c0bdab22b2f516aff563b2559e3b]
stable/6.1: [7752569fc78e89794ce28946529850282233f99d]
stable/6.12: [eef1390125b660b8b61f9f227a03bb9c5e6d36a5]
stable/6.18: [d1ef3aed4df2ef1fe46befd8f2da9a6ec5445508]
stable/6.19: [f558e5404a72054b525dced1a0c66aa95a144153]
stable/6.6: [e91d8d6565b7819d13dab21d4dbed5b45efba59b]

CVE-2026-23357: can: mcp251x: fix deadlock in error path of mcp251x_open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23357

Introduced by commit bf66f37 ("can: mcp251x: Move to threaded
interrupts instead of workqueues.") in v2.6.34-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab3f894de216f4a62adc3b57e9191888cbf26885]
stable/6.1: [256f0cff6e946c570392bda1d01a65e789a7afd0]
stable/6.12: [38063cc435b69d56e76f947c10d336fcb2953508]
stable/6.18: [d27f12c3f5e85efc479896af4a69eccb37f75e8e]
stable/6.19: [e728f444c913a91d290d1824b4770780bbd6378e]
stable/6.6: [b73832292cd914e87a55e863ba4413a907e7db6b]

CVE-2026-23358: drm/amdgpu: Fix error handling in slot reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23358

Introduced by commit 732c6ce ("drm/amdgpu: Replace tmp_adev with hive
in amdgpu_pci_slot_reset") in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b57c4ec98c17789136a4db948aec6daadceb5024]
stable/6.18: [73e8bdf14248136459753252a438177df7ed8c7c]
stable/6.19: [baf4e7968911635eb816870af0ea587ac1457052]

CVE-2026-23359: bpf: Fix stack-out-of-bounds write in devmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23359

Introduced by commit aeea1b8 ("bpf, devmap: Exclude XDP broadcast to
master device") in v5.15-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7bf516c3ecd9a2aae2dc2635178ab87b734fef1]
stable/6.1: [5000e40acc8d0c36ab709662e32120986ac22e7e]
stable/6.12: [d2c31d8e03d05edc16656e5ffe187f0d1da763d7]
stable/6.18: [75d474702b2ba8b6bcb26eb3004dbc5e95ffd5d2]
stable/6.19: [ca831567908fd3f73cf97d8a6c09a5054697a182]
stable/6.6: [8a95fb9df1105b1618872c2846a6c01e3ba20b45]

CVE-2026-23360: nvme: fix admin queue leak on controller reset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23360

Introduced by commit 03b3bcd ("nvme: fix admin request_queue
lifetime"). in v6.18-rc7.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [b84bb7bd913d8ca2f976ee6faf4a174f91c02b8d]
stable/6.12: [64f87b96de0e645a4c066c7cffd753f334446db6]
stable/6.18: [e159eb852aeee95443a9458ecb7d072bbb689913]
stable/6.19: [8eb2b3cdcd9b6631b94b82c1f4f6bc32b40d942f]

CVE-2026-23361: PCI: dwc: ep: Flush MSI-X write before unmapping its ATU entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23361

Introduced by commit beb4641 ("PCI: dwc: Add MSI-X callbacks handler")
in v4.19-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c22533c66ccae10511ad6a7afc34bb26c47577e3]
stable/6.12: [a7afb8f810c04845fdfc58c57d9cf0cc5f23ced0]
stable/6.18: [6f60a783860c77b309f7d81003b6a0c73feca49e]
stable/6.19: [eaa6a56801ddd2d9b4980f19e7fe002b00994804]

CVE-2026-23362: can: bcm: fix locking for bcm_op runtime updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23362

Introduced by commit c2aba69 ("can: bcm: add locking for bcm_op
runtime updates") in v6.15.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [c35636e91e392e1540949bbc67932167cb48bc3a]
stable/6.1: [800f26f11ae37b17f58e0001f28a47dd75c26557]
stable/6.12: [8bcf2d847adb82b2c617456f6da17ac5e6c75285]
stable/6.18: [8215ba7bc99e84e66fd6938874ec4330a9d96518]
stable/6.19: [f0c349b2c21b220af5ba19f29b885e222958d796]
stable/6.6: [70e951afad4c025261fe3c952d2b07237e320a01]

CVE-2026-23363: wifi: mt76: mt7925: Fix possible oob access in
mt7925_mac_write_txwi_80211()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23363

Introduced by commit c948b5d ("wifi: mt76: mt7925: add Mediatek Wi-Fi7
driver for mt7925 chips") in v6.7-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c41a9abd6ae31d130e8f332e7c8800c4c866234b]
stable/6.12: [3356464e50e1ee15ba3c324ef6cc5a475c2e96e4]
stable/6.18: [2831a8c574545101e6d0df50785fccb16474eb3c]
stable/6.19: [22a6419a8b955df81082285543be3e61816c49b5]

CVE-2026-23364: ksmbd: Compare MACs in constant time

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23364

Introduced by commit e2f3448 ("cifsd: add server-side procedures for
SMB3") in v5.15-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5794709bc9105935dbedef8b9cf9c06f2b559fa]
stable/6.1: [cd52a0e309659537048a864211abc3ea4c5caa63]
stable/6.12: [2cdc56ed67615ba0921383a688f24415ebe065f3]
stable/6.18: [93c0a22fec914ec4b697e464895a0f594e29fb28]
stable/6.19: [f4588b85efd6007d46b80aa1b9fb746628ffb3dc]
stable/6.6: [307afccb751f542246bd5dc68a2c1ffe1a78418c]

CVE-2026-23365: net: usb: kalmia: validate USB endpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23365

Introduced by commit d402612 ("net/usb: Add Samsung Kalmia driver for
Samsung GT-B3730") in v3.0-rc4.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c58b6c29a4c9b8125e8ad3bca0637e00b71e2693]
stable/6.1: [28a380bfa5bc7f6a9380b85e8eab919ee6ac1701]
stable/6.12: [51c20ea5f1555a984c041b0dbf56f00d41b9e652]
stable/6.18: [011684cd18349aa4c52167c8ac37a0524169f48c]
stable/6.19: [7bfda1a0be4caec3263753d567678451cef73a85]
stable/6.6: [12c0243de0aee0ab27cc00932fd5edae65c1e3a2]

CVE-2026-23366: drm/client: Do not destroy NULL modes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23366

Introduced by commit 3039cc0 ("drm/client: Make copies of modes") in v6.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c601fd5414315fc515f746b499110e46272e7243]
stable/6.18: [4e3ca5f82346cc23c0a71f1ceb006115ff6b0745]
stable/6.19: [9aa3e33f0c7f2679ac599a09e3102c8f716a6321]

CVE-2026-23367: wifi: radiotap: reject radiotap with unknown bits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23367

Introduced by commit 33e5a2f ("wireless: update radiotap parser") in
v2.6.34-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c854758abe0b8d86f9c43dc060ff56a0ee5b31e0]
stable/6.1: [703fa979badbba83d31cd011606d060bfb8b0d1d]
stable/6.12: [2a60c588d5d39ad187628f58395c776a97fd4323]
stable/6.18: [2f8ceeba670610d66f77def32011f48de951d781]
stable/6.19: [e664971759a0e5570b50c6592e58a7f97d55e992]
stable/6.6: [129c8bb320a7cef692c78056ef8e89a2a12ba448]

CVE-2026-23368: net: phy: register phy led_triggers during probe to
avoid AB-BA deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23368

Introduced by commit 06f502f ("leds: trigger: Introduce a NETDEV
trigger") in v4.16-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8dbdc6e380e7e96a51706db3e4b7870d8a9402d]
stable/6.1: [c6ffc2d2338d325e1edd0c702e3ee623aa5fdc6a]
stable/6.12: [241cd64cf2e32b28ead151b1795cd8fef2b6e482]
stable/6.18: [2764dcb3c35de4410f642afc62cf979727470575]
stable/6.19: [cde2d0b5ab5d03b5b6f17d4f654d8b30ccf36757]
stable/6.6: [c33523b8fd2d4c504ada18cd93f511f2a8f84217]

CVE-2026-23369: i2c: i801: Revert "i2c: i801: replace acpi_lock with
I2C bus lock"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23369

Introduced by commit f707d6b ("i2c: i801: replace acpi_lock with I2C
bus lock") in v6.7-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cfc69c2e6c699c96949f7b0455195b0bfb7dc715]
stable/6.12: [9507f9953a2a5647eb42668d0c243fdbd7e72954]
stable/6.18: [1c72e7b0b442ce21a1348d9b8237cfddb67048eb]
stable/6.19: [c726273044a5a8308a889d19d6884135c0f3321d]

CVE-2026-23370: platform/x86: dell-wmi-sysman: Don't hex dump
plaintext password data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23370

Introduced by commit e8a60aa ("platform/x86: Introduce support for
Systems Management Driver over WMI for Dell Systems") in v5.11-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1a196e0a6dcddd03748468a0e9e3100790fc85c]
stable/6.1: [d9e785bd62d2ac23cf29a75dcfea8c8087fd3870]
stable/6.12: [0e6115c2f2facaed9593c16ad2e5accd487f5c52]
stable/6.18: [5de34126fb2edf8ab7f25d677b132e92d8bf9ede]
stable/6.19: [d78e74adc5cfff7afd9d03b9da8058a7e435f9bc]
stable/6.6: [411ba3cd837f7825c0e648e155bc505641f95854]

CVE-2026-23371: sched/deadline: Fix missing ENQUEUE_REPLENISH during
PI de-boosting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23371

Introduced by commit 2279f54 ("sched/deadline: Fix priority
inheritance with multiple scheduling classes") in v5.10-rc5.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [d658686a1331db3bb108ca079d76deb3208ed949]
stable/6.19: [ba1c22924ddcc280672a2a06a9ca99ee3a1b92c3]

CVE-2026-23372: nfc: rawsock: cancel tx_work before socket teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23372

Introduced by commit 23b7869 ("NFC: add the NFC socket raw protocol")
in v3.1-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d793458c45df2aed498d7f74145eab7ee22d25aa]
stable/6.1: [3ae592ed91bb4b6b51df256b51045c13d2656049]
stable/6.12: [78141b8832e16d80d09cbefb4258612db0777a24]
stable/6.18: [edc988613def90c5b558e025b1b423f48007be06]
stable/6.19: [da4515fc8263c5933ed605e396af91079806dc45]
stable/6.6: [722a28b635ec281bb08a23885223526d8e7d6526]

CVE-2026-23373: wifi: rsi: Don't default to -EOPNOTSUPP in rsi_mac80211_config

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23373

Introduced by commit 0a44dfc ("wifi: mac80211: simplify non-chanctx
drivers") in v6.9-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d973b1039ccde6b241b438d53297edce4de45b5c]
stable/6.12: [b64fbd718cf42feb75502bf25d0d16eb671aea45]
stable/6.18: [95ed07644b2c6119f706484b87b7f43e6133f3b5]
stable/6.19: [67d10e8db57ffc21f8177e9e884bbc743fdc0bae]

CVE-2026-23374: blktrace: fix __this_cpu_read/write in preemptible context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23374

Introduced by commit 7ffbd48 ("tracing: Cache comms only after an
event occurred") in v3.8-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da46b5dfef48658d03347cda21532bcdbb521e67]
stable/6.19: [59efa088752b1c380a0475974679850cc8aef907]

CVE-2026-23375: mm: thp: deny THP for files on anonymous inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23375

Introduced by commit 7fbb5e1 ("mm: remove VM_EXEC requirement for THP
eligibility") in v6.8-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd085fe9a8ebfc5d10314c60452db38d2b75e609]
stable/6.12: [08de46a75f91a6661bc1ce0a93614f4bc313c581]
stable/6.18: [0524ee56af2c9bfbad152a810f1ca95de8ca00d7]
stable/6.19: [f6fa05f0dddd387417d0c28281ddb951582514d6]

CVE-2026-23376: nvmet-fcloop: Check remoteport port_state before
calling done callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23376

Introduced by commit 10c165a ("nvmet-fcloop: call done callback even
when remote port is gone") in v6.18-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd677d0598387ea623820ab2bd0e029c377445a3]
stable/6.18: [f30b95159a53e72529a9ca1667f11cd1970240a7]
stable/6.19: [31d3817bcd9e192b30abe3cf4b68f69d48864dd2]

CVE-2026-23377: ice: change XDP RxQ frag_size from DMA write length to
xdp.frame_sz

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23377

Introduced by commit 2fba7dc ("ice: Add support for XDP multi-buffer
on Rx side") in v6.3-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e142dc4ef0f451b7ef99d09aaa84e9389af629d7]
stable/6.19: [b0f05100e8795aadd1c0606bae9caefbda070d63]

CVE-2026-23378: net/sched: act_ife: Fix metalist update behavior

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23378

Introduced by commit aa9fd9a ("sched: act: ife: update parameters via
rcu handling") in v4.15-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2cedd400c3ec0302ffca2490e8751772906ac23]
stable/6.1: [56ade7ddea6ce605552341785d08e365c3f61861]
stable/6.12: [91a89d3bdc2f63d983adc13d1771631663c5dc1b]
stable/6.18: [cd888c3966672239f2e0707b846a5a936ac9038a]
stable/6.19: [691866c4cca54dc4df762276b49e89b36e046947]
stable/6.6: [5b1449301ca070814d866990b46f48d3f39ea4ee]

CVE-2026-23379: net/sched: ets: fix divide by zero in the offload path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23379

Introduced by commit d35eb52 ("net: sch_ets: Make the ETS qdisc
offloadable") in v5.6-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e35626f610f3d2b7953ccddf6a77453da22b3a9e]
stable/6.1: [3912871344d6a0f1f572a7af2716968182d1e536]
stable/6.12: [78b8d2f55a564236435649fbd8bd6a103f30acf5]
stable/6.18: [a6677e23b313cd9fd03690c589c6452cb6fffb97]
stable/6.19: [abe1d5cb7fe135c0862c58db32bc29e04cf1c906]
stable/6.6: [7dbffffd5761687e168fb2f4aaa7a2c47e067efc]

CVE-2026-23380: tracing: Fix WARN_ON in tracing_buffers_mmap_close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23380

Introduced by commit cf9f0f7 ("tracing: Allow user-space mapping of
the ring-buffer") in v6.10-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e39bb9e02b68942f8e9359d2a3efe7d37ae6be0e]
stable/6.12: [91f3e8d84c89918769e71393f839c9fefadc2580]
stable/6.18: [cdd96641b64297a2db42676f051362b76280a58b]
stable/6.19: [b0f269ba6fefe9e3cb9feedcf78fcd0b633800c0]

CVE-2026-23381: net: bridge: fix nd_tbl NULL dereference when IPv6 is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23381

Introduced by commit ed842fa ("bridge: suppress nd pkts on
BR_NEIGH_SUPPRESS ports") in v4.15-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5e890630533bdc15b26a34bb8e7ef539bdf1322]
stable/6.1: [7a894eb5de246d79f13105c55a67381039a24d44]
stable/6.12: [aa73deb3b6b730ec280d45b3f423bfa9e17bc122]
stable/6.18: [33dec6f10777d5a8f71c0a200f690da5ae3c2e55]
stable/6.19: [20ef5c25422f97dd09d751e5ae6c18406cdc78e6]
stable/6.6: [a12cdaa3375f0bd3c8f4e564be7c143529abfe5b]

CVE-2026-23382: HID: Add HID_CLAIMED_INPUT guards in raw_event
callbacks missing them

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23382

According to the .vulnerable file, this bug was introduced by commit
d0742ab in v2.6.35-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecfa6f34492c493a9a1dc2900f3edeb01c79946b]
stable/6.1: [ac83b0d91a3f4f0c012ba9c85fb99436cddb1208]
stable/6.12: [892dbaf46bb738dacf1fa663eadb3712c85868f0]
stable/6.18: [20864e3e41c74cda253a9fa6b6fe093c1461a6a9]
stable/6.19: [575122cd6569c4c4aa13c4c9958fea506724c788]
stable/6.6: [6e330889e6c8db99f04d4feb861d23de4e8fbb13]

CVE-2026-23383: bpf, arm64: Force 8-byte alignment for JIT buffer to
prevent atomic tearing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23383

Introduced by commit b2ad54e ("bpf, arm64: Implement
bpf_arch_text_poke() for arm64") in v6.0-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef06fd16d48704eac868441d98d4ef083d8f3d07]
stable/6.12: [80ad264da02cc4aee718e799c2b79f0f834673dc]
stable/6.18: [519b1ad91de5bf7a496f2b858e9212db6328e1de]
stable/6.19: [66959ed481a474eaae278c7f6860a2a9b188a4d6]

CVE-2026-23384: RDMA/ionic: Fix kernel stack leak in ionic_create_cq()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23384

Introduced by commit e852182 ("RDMA/ionic: Register device ops for
control path") in v6.18-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faa72102b178c7ae6c6afea23879e7c84fc59b4e]
stable/6.18: [a6f3e0fa8e862f220c26c2f27e5ddc42eb82ad3e]
stable/6.19: [547d0b07ad73915b323bc21f85c5d3252bebbbcf]

CVE-2026-23385: netfilter: nf_tables: clone set on flush only

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23385

Introduced by commit 3f1d886 ("netfilter: nft_set_pipapo: move cloning
of match info to insert/removal path") in v6.10-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb7fb4016300ac622c964069e286dc83166a5d52]
stable/6.18: [9154945a6394029822bd08c24cef5a3f86d0424a]
stable/6.19: [b7f67282ca2be14b727dd698b50e10cf5d8c66f9]

CVE-2026-23386: gve: fix incorrect buffer cleanup in
gve_tx_clean_pending_packets for QPL

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23386

Introduced by commit a6fb8d5 ("gve: Tx path for DQO-QPL") in v6.6-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb868db5f4bccd7a78219313ab2917429f715cea]
stable/6.12: [c171f90f58974c784db25e0606051541cb71b7f0]
stable/6.18: [07e0c80e17ef781799e7cd5c41a7bf44f1bf6a5f]
stable/6.19: [3744ebd8ffaa542ae8110fb449adcac0202f4cc8]
stable/6.6: [71511dae56a75ce161aa746741e5c498feaea393]

CVE-2026-23387: pinctrl: cirrus: cs42l43: Fix double-put in cs42l43_pin_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23387

Introduced by commit 9b07cdf ("pinctrl: cirrus: Fix fwnode leak in
cs42l43_pin_probe()") in v6.18-rc7.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [fd5bed798f45eb3a178ad527b43ab92705faaf8a]
stable/6.12: [188ba3468cb7c098c62609d82e9fc58d29ead7f4]
stable/6.18: [ea07fcfbba4301839db3784f09955d9fa3e98090]
stable/6.19: [1e0465139fd9caee7ffefe285ef7d5f21919e474]
stable/6.6: [95b14ecc56881dd9a187e1e84dd0daa88ff22c5d]

CVE-2026-23388: Squashfs: check metadata block offset is within range

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23388

Introduced by commit f400e12 ("Squashfs: cache operations") in v2.6.29-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fdb24a820a5832ec4532273282cbd4f22c291a0d]
stable/6.1: [0c8ab092aec3ac4294940054772d30b511b16713]
stable/6.12: [9e9fa5ad37c9cbad73c165c7ff1e76e650825e7c]
stable/6.18: [01ee0bcc29864b78249308e8b35042b09bbf5fe3]
stable/6.19: [3b9499e7d677dd4366239a292238489a804936b2]
stable/6.6: [6b847d65f5b0065e02080c61fad93d57d6686383]

CVE-2026-23389: ice: Fix memory leak in ice_set_ringparam()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23389

Introduced by commit fcea6f3 ("ice: Add stats and ethtool support") in
v4.17-rc1.
Introduced by commit efc2214 ("ice: Add support for XDP") in v5.5-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe868b499d16f55bbeea89992edb98043c9de416]
stable/6.19: [44ba32a892b72de3faa04b8cfb1f2f1418fdd580]

CVE-2026-23390: tracing/dma: Cap dma_map_sg tracepoint arrays to
prevent buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23390

According to the .vulnerable file, this bug was introduced by commit
038eb43 in v6.12-rc1.
Fixed in v6.19.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [daafcc0ef0b358d9d622b6e3b7c43767aa3814ee]
stable/6.12: [02d209bb018a40dee9eac89e91860253dee9605b]
stable/6.18: [f2584f791a10343bdc995ff6ff402db45b95de69]

CVE-2026-23391: netfilter: xt_CT: drop pending enqueued packets on
template removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23391

Introduced by commit 24de58f ("netfilter: xt_CT: allow to attach
timeout policy + glue code") in v3.4-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f62a218a946b19bb59abdd5361da85fa4606b96b]
stable/6.1: [d2d0bae0c9a2a17b6990a2966f5cdce0813d6256]
stable/6.12: [19a230dec6bb8928e3f96387f9085cf2c79bcef9]
stable/6.18: [cb549925875fa06dd155e49db4ac2c5044c30f9c]
stable/6.19: [777d02efe3d630cca4c1b63962cec17c57711325]
stable/6.6: [63b8097cea1923fe82cd598068d0796da8c015ec]

CVE-2026-23392: netfilter: nf_tables: release flowtable after rcu
grace period on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23392

Introduced by commit 3b49e2e ("netfilter: nf_tables: add flow table
netlink frontend") in v4.16-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d73f4b53aaaea4c95f245e491aa5eeb8a21874ce]
stable/6.1: [d2632de96ccb066e0131ad1494241b9c281c60b8]
stable/6.12: [7e3955b282eae20d61c75e499c75eade51c20060]
stable/6.18: [c8092edb9a11f20f95ccceeb9422b7dd0df337bd]
stable/6.19: [e78a2dcc7cfb87b64a631441ca7681492b347ef6]
stable/6.6: [adee3436ccd29f1e514c028899e400cbc6d84065]

CVE-2026-23393: bridge: cfm: Fix race condition in peer_mep deletion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23393

Introduced by commit dc32cbb ("bridge: cfm: Kernel space
implementation of CFM. CCM frame RX added.") in v5.11-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3715a00855316066cdda69d43648336367422127]
stable/6.12: [e89dbd2736a45f0507949af4748cbbf3ff793146]
stable/6.18: [d8f35767bacb3c7769d470a41cf161e3f3c07e70]
stable/6.19: [1fd81151f65927fd9edb8ecd12ad45527dbbe5ab]

CVE-2026-23394: af_unix: Give up GC if MSG_PEEK intervened.

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23394

Introduced by commit 118f457 ("af_unix: Remove lock dance in
unix_peek_fds().") in v6.10-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [e5b31d988a41549037b8d8721a3c3cae893d8670]
stable/6.19: [37dd7ab332396eb8dd80b2dc7ea4b61abf767436]

CVE-2026-23395: Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23395

Introduced by commit 15f02b9 ("Bluetooth: L2CAP: Add initial code for
Enhanced Credit Based Mode") in v5.7-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b3e2052334f2ff6d5200e952f4aa66994d09899]
stable/6.1: [fb4a3a26483f3ea2cd21c7a2f7c45d5670600465]
stable/6.12: [6b949a6b33cbdf621d9fc6f0c48ac00915dbf514]
stable/6.18: [8d0d94f8ba5b3a0beec3b0da558b9bea48018117]
stable/6.19: [e72ee455297b794b852e5cea8d2d7bb17312172a]
stable/6.6: [2124d82fd25e1671bb3ceb37998af5aae5903e06]


* Updated CVEs

CVE-2023-53228: drm/amdgpu: drop redundant sched job cleanup when cs is aborted

stable/6.1 was fixed.

Fixed status
stable/6.1: [cdce1644d85e858c68fb5fa67d78eb1035bf34f4]

CVE-2023-53510: scsi: ufs: core: Fix handling of lrbp->cmd

stable/6.1 was fixed.

Fixed status
stable/6.1: [b6d76d63c6d21d5d26c301a46853a2aee72397d5]

CVE-2023-53545: drm/amdgpu: unmap and remove csa_va properly

stable/6.1 was fixed.

Fixed status
stable/6.1: [ae325b245208394279a1dc412c831ebd71befb0d]

CVE-2024-43826: nfs: pass explicit offset/count to trace events

stable/6.6 was fixed.

Fixed status
stable/6.6: [1562138b9cababf637eee485e98491f9206a990d]

CVE-2024-46691: usb: typec: ucsi: Move unregister out of atomic section

stable/6.6 was fixed.

Fixed status
stable/6.6: [1e3769aa0946c2b6e509c06d7a0aa9b955eaef9e]

CVE-2024-47809: dlm: fix possible lkb_resource null dereference

stable/6.1 was fixed.

Fixed status
stable/6.1: [8d55ce46dd543c6965970ce70c22c3076dd35b1e]

CVE-2024-49979: net: gso: fix tcp fraglist segmentation after pull
from frag_list

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [75733986fcb0725c0033cde94764389e287b331e]
stable/6.6: [e19201b0c67da5146eaac06fd3d44bd7945c3448]

CVE-2024-49998: net: dsa: improve shutdown sequence

stable/6.1 was fixed.

Fixed status
stable/6.1: [ab9e90619b6339becc5415647ae154a9a46a044d]

CVE-2024-50298: net: enetc: allocate vf_state during PF probes

stable/6.1 was fixed.

Fixed status
stable/6.1: [35668e29e979b3a1927d3959cdd87327afd8e5eb]

CVE-2024-56719: net: stmmac: fix TSO DMA API usage causing oops

stable/6.1 was fixed.

Fixed status
stable/6.1: [6abcdc9a73274052a9e96a1926994ecf9aedad82]

CVE-2025-21676: net: fec: handle page_pool_dev_alloc_pages error

stable/6.1 was fixed.

Fixed status
stable/6.1: [eacdcc14f3c8d4c1447565521e792ddb3a67e08d]

CVE-2025-21682: eth: bnxt: always recalculate features after XDP
clearing, fix null-deref

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [076a694a42ae3f0466bc6e4126050eeb7b7d299a]
stable/6.6: [90336fc3d6f5e716ac39a9ddbbde453e23a5aa65]

CVE-2025-38105: ALSA: usb-audio: Kill timer properly at removal

stable/6.1 was fixed.

Fixed status
stable/6.1: [efaf61052b8ff9ee8968912fbaf02c2847c78ede]

CVE-2025-38162: netfilter: nft_set_pipapo: prevent overflow in lookup
table allocation

stable/6.1 was fixed.

Fixed status
stable/6.1: [91edc076439c9e2f34b176149f1c84a47a8ec32f]

CVE-2025-38164: f2fs: zone: fix to avoid inconsistence in between SIT and SSA

stable/6.6 was fixed.

Fixed status
stable/6.6: [d1365d2abfaf2d85ee51a005da3ca373aea97f6a]

CVE-2025-38192: net: clear the dst when changing skb protocol

stable/6.1 was fixed.

Fixed status
stable/6.1: [98b1d8dc9a3170b2614f1e8c93854e75cdd83980]

CVE-2025-38250: Bluetooth: hci_core: Fix use-after-free in vhci_flush()

stable/6.1 was fixed.

Fixed status
stable/6.1: [c56b177efce8b62798e4d96bdb9867106cb7c4a0]

CVE-2025-38426: drm/amdgpu: Add basic validation for RAS header

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [0479268fdfaaff6e15d69e8a8387410f36d1b793]
stable/6.6: [e1903358b2152f5d64a83e796bb776aba0d3628d]

CVE-2025-38626: f2fs: fix to trigger foreground gc during
f2fs_map_blocks() in lfs mode

stable/6.1 was fixed.

Fixed status
stable/6.1: [d2f280f43a2a9d918fd23169ff3a6f3b65c7cec5]

CVE-2025-38627: f2fs: compress: fix UAF of f2fs_inode_info in f2fs_free_dic

stable/6.12 was fixed.

Fixed status
stable/6.12: [cc81768212cdc509e5a986274db7bc24d18cde19]

CVE-2025-38659: gfs2: No more self recovery

stable/6.1 was fixed.

Fixed status
stable/6.1: [6ebe17b359bead383581f729e43f591c1c36e159]

CVE-2025-38704: rcu/nocb: Fix possible invalid rdp's->nocb_cb_kthread
pointer access

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [b097ae798298885695c339d390b48b4e39619fa7]
stable/6.6: [3da45ec1e485a1a5ad31fe9ddd467c7ee5ae4ef9]

CVE-2025-39748: bpf: Forget ranges when refining tnum after JSET

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [591c788d16046edb0220800bf1819554af5853ce]
stable/6.6: [0643aa2468192a4d81326e8e76543854870b1ee2]

CVE-2025-39764: netfilter: ctnetlink: remove refcounting in expectation dumpers

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [64b7684042246e3238464c66894e30ba30c7e851]
stable/6.12: [078d33c95bf534d37aa04269d1ae6158e20082d5]
stable/6.6: [9e5021a906532ca16e2aac69c0607711e1c70b1f]

CVE-2025-39863: wifi: brcmfmac: fix use-after-free when rescheduling
brcmf_btcoex_info work

stable/6.1 was fixed.

Fixed status
stable/6.1: [ae58f70bde0433f27ef4b388ab50634736607bf6]

CVE-2025-40005: spi: cadence-quadspi: Implement refcount to handle
unbind during busy

stable/6.1, stable/6.12 were fixed.

Fixed status
stable/6.1: [56787f4a75907ae99b5f5842b756fa68e2482f6d]
stable/6.12: [65ed52200080eafce3eead05cf22ce01238defca]

CVE-2025-40135: ipv6: use RCU in ip6_xmit()

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [f0a54d00d2f36de40266f47c27989853e8588656]
stable/6.12: [bd0905e2122e3680968cd0741966983490bf2ed3]
stable/6.6: [f69fec6287565fdeb61f65e700a1184352306943]

CVE-2025-40147: blk-throttle: fix access race during throttle policy activation

stable/6.12 was fixed.

Fixed status
stable/6.12: [7b4bfd02c934dbbb18814ed012ecb90b58db6935]

CVE-2025-40150: f2fs: fix to avoid migrating empty section

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [25d2dc669f2a7e48b335d1cb07139f2ffc9fe5df]
stable/6.6: [db489778e6f2a4034c2cd26fadda2796eba24dcd]

CVE-2025-40358: riscv: stacktrace: Disable KASAN checks for non-current tasks

stable/6.1 was fixed.

Fixed status
stable/6.1: [ef4d626ac59a56f8ec5cc09c1fef26f2923eec6f]

CVE-2025-68206: netfilter: nft_ct: add seqadj extension for natted connections

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [4de80f0dc3868408dd7fe9817e507123c9dd8bb0]
stable/6.6: [b477ef7fa612fa45b6b3134d90d1eeb09396500a]

CVE-2025-68239: binfmt_misc: restore write access before closing files
opened by open_exec()

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [480ac88431703f2adbb8e6b5bd73c3f3cf9f3d7f]
stable/6.12: [6cce7bc7fac8471c832696720d9c8f2a976d9c54]
stable/6.6: [fbab8c08e1a6dbaef81e22d672a7647553101d16]

CVE-2025-68265: nvme: fix admin request_queue lifetime

stable/6.1 was fixed.

Fixed status
stable/6.1: [ff037b5f47eeccc1636c03f84cd47db094eb73c9]

CVE-2025-68334: platform/x86/amd/pmc: Add support for Van Gogh SoC

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [996092ba6df66e2ac8cf9022007a7c8a412e7733]
stable/6.6: [8af210df4f71dda74dc027da69372a028c6d4d84]

CVE-2025-68357: iomap: allocate s_dio_done_wq for async reads as well

stable/6.6 was fixed.

Fixed status
stable/6.6: [bfc717be833fd9ee41443fde2dea0352a7fca333]

CVE-2025-71067: ntfs: set dummy blocksize to read boot_block when mounting

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c9327c8abf9c8f046e45008bb43d94d8ee5c6c5]

CVE-2025-71152: net: dsa: properly keep track of conduit reference

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [b358fc6ff3b35a29f7f677da1c67af67d0d560cb]
stable/6.6: [ec2b34acb1894cfc10ed22d8277ca4f11e9f4b23]

CVE-2025-71156: gve: defer interrupt enabling until NAPI registration

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [dbc81975f0ee6b4b752dd9ccce10530466b6313c]
stable/6.6: [ca049ef5c8c71b3d846a11daea4d8f353772866c]

CVE-2025-71161: dm-verity: disable recursive forward error correction

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [e227d2b229c7529bd98d348efc55262ccf24ab35]
stable/6.12: [4220cb37406915c926c0e4a3dbab77cd9cceeb1e]
stable/6.6: [897d9006e75f46f8bd7df78faa424327ae6a4bcf]

CVE-2025-71184: btrfs: fix NULL dereference on root when tracing inode eviction

stable/6.6 was fixed.

Fixed status
stable/6.6: [64d8abd8c5305795a2b35fc96039d99d34f5e762]

CVE-2025-71203: riscv: Sanitize syscall table indexing under speculation

stable/6.6 was fixed.

Fixed status
stable/6.6: [33743ec6679aa364ee19d1afbaa50593e9e6e443]

CVE-2025-71221: dmaengine: mmp_pdma: Fix race condition in mmp_pdma_residue()

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [dfb5e05227745de43b7fd589721817a4337c970d]
stable/6.12: [fc023b8fab057f0c910856ff36d3e12a30b7af4a]
stable/6.6: [eba0c75670c022cb1f948600db972524bcfe8166]

CVE-2026-23004: dst: fix races in rt6_uncached_list_del() and
rt_del_uncached_list()

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [f24a52948c95e02facbca2b3b6eb5a225e27eb01]
stable/6.6: [815db2363e51f0ef416947492d4dac5b7a520f56]

CVE-2026-23050: pNFS: Fix a deadlock when returning a delegation during open()

stable/6.6 was fixed.

Fixed status
stable/6.6: [c57387d447a2bcbaea009ba5f9497adf3de5edeb]

CVE-2026-23053: NFS: Fix a deadlock involving nfs_release_folio()

stable/6.6 was fixed.

Fixed status
stable/6.6: [a4810f8beb0122f032f10735f98d257aa6064f4c]

CVE-2026-23066: rxrpc: Fix recvmsg() unconditional requeue

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [cf969bddd6e69c5777fa89dc88402204e72f312a]
stable/6.6: [0464bf75590da75b8413c3e758c04647b4cdb3c6]

CVE-2026-23070: Octeontx2-af: Add proper checks for fwdata

stable/6.12 was fixed.

Fixed status
stable/6.12: [079050a23de6b7505595e4af75b36c34f0e9627e]

CVE-2026-23100: mm/hugetlb: fix hugetlb_pmd_shared()

stable/6.1 was fixed.

Fixed status
stable/6.1: [5b2aec77f92265a9028c5f632bdd9af5b57ec3a3]

CVE-2026-23104: ice: fix devlink reload call trace

stable/6.12 was fixed.

Fixed status
stable/6.12: [8ac7dd0f813fb65ff2fd9543900c3009f8e84110]

CVE-2026-23113: io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop

stable/6.1 was fixed.

Fixed status
stable/6.1: [d05d99573f81a091547b1778b9a50120f5d6c68a]

CVE-2026-23118: rxrpc: Fix data-race warning and potential load/store tearing

stable/6.6 was fixed.

Fixed status
stable/6.6: [a426f29ac3fa3465093567ab763ada46762fb57c]

CVE-2026-23138: tracing: Add recursion protection in kernel stack
trace recording

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [19e18e6dabb1bbba76d2809ca7d8ae9e1f5975fe]
stable/6.6: [9b03768037d91ce727effb1c5d92d2c7781bf692]

CVE-2026-23141: btrfs: send: check for inline extents in
range_is_hole_in_parent()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d948055bd46a9c14d1d4217aed65c5c258c32903]

CVE-2026-23154: net: fix segmentation of forwarding fraglist GRO

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [9122d7280b2303e835cdfec156bd932ac1f586ed]
stable/6.6: [2cbef9ea5a0ac51863ede35c45f26931a85d3888]

CVE-2026-23157: btrfs: do not strictly require dirty metadata
threshold for metadata writepages

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [bb9be3f713652e330df00f3724c18c7a5469e7ac]
stable/6.12: [0c3666ec188640c20e254011e7adf4464c32ee58]
stable/6.6: [4357e02cafabe01c2d737ceb4c4c6382fc2ee10a]

CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()

stable/6.1 was fixed.

Fixed status
stable/6.1: [cfa745830e45ecb75c061aa34330ee0cac941cc7]

CVE-2026-23227: drm/exynos: vidi: use ctx->lock to protect struct
vidi_context member variables related to memory alloc/free

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [92dd1f38d7db75374dcdaf54f1d79d67bffd54e5]
stable/6.6: [1b24d3e8792bcc050c70e8e0dea6b49c4fc63b13]

CVE-2026-23244: nvme: fix memory allocation in nvme_pr_read_keys()

stable/6.6 was fixed.

Fixed status
stable/6.6: [e42ff5abbd14927553b624c0e06d24df76156fe6]

CVE-2026-23245: net/sched: act_gate: snapshot parameters with RCU on replace

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [8b1251bbf0f10ac745ed74bad4d3b433caa1eeae]
stable/6.12: [035d0d09d5ab3ed3e93d18cde2b562a6719eea23]
stable/6.6: [dfc314d7c767e350f78a46a8f8b134f80e8ad432]

CVE-2026-23246: wifi: mac80211: bounds-check link_id in
ieee80211_ml_reconfiguration

stable/6.6 was fixed.

Fixed status
stable/6.6: [650981e718e68005ca2760a6358134b8a98ebea4]

CVE-2026-23252: xfs: get rid of the xchk_xfile_*_descr calls

stable/6.12 was fixed.

Fixed status
stable/6.12: [695455fbc49053cbf555f2f302a5dcd600f412ff]

CVE-2026-23253: media: dvb-core: fix wrong reinitialization of
ringbuffer on reopen

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [f1e520ca2e83ece6731af6167c9e5e16931ecba0]
stable/6.6: [af050ab44fa1b1897a940d7d756e512232f5e5df]

CVE-2026-23268: apparmor: fix unprivileged local user can do
privileged policy management

stable/6.6 was fixed.

Fixed status
stable/6.6: [17debf5586020790b5717f96e5e6a3ca5bb961ab]

CVE-2026-23269: apparmor: validate DFA start states are in bounds in unpack_pdb

stable/6.6 was fixed.

Fixed status
stable/6.6: [07cf6320f40ea2ccfad63728cff34ecb309d03da]

CVE-2026-23270: net/sched: Only allow act_ct to bind to clsact/ingress
qdiscs and shared blocks

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [fb3c380a54e33d1fd272cc342faa906d787d7ef1]
stable/6.6: [5a110ddcc99bda77a28598b3555fe009eaab3828]

CVE-2026-31788:

stable/6.1, stable/6.12, stable/6.18, stable/6.19, stable/6.6 were fixed.

Fixed status
stable/6.1: [87a803edb2ded911cb587c53bff179d2a2ed2a28,
65dcb23973e0464ef3502959bdff87ca483e4914]
stable/6.12: [78432d8f0372c71c518096395537fa12be7ff24e,
1f00bad1b69b79ae9bfe066416a63c5835b54124]
stable/6.18: [389bae9a4409934e8b8d4dbdaaf02a3ae71cf8e4,
a52e3970f971771b79950d38aa5479bcf5755a91]
stable/6.19: [cbede2e833da1893afbea9b3ff29b5dda23a4a91,
916c52aed0cb5c5e3f2ba8a5e3ae52775b22e1a0]
stable/6.6: [1879319d790f7d57622cdc22807b60ea78b56b6d,
1dacf6b3718a356428f0e31300fb7b9e5fc6e347]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

