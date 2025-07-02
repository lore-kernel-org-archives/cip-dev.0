Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C93FC83F03
	for <webhook@archiver.kernel.org>; Wed,  2 Jul 2025 23:03:02 +0000 (UTC)
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
 by mx.groups.io with SMTP id smtpd.web10.9934.1751497380648281109
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Jul 2025 16:03:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=tHxnsnPh;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.170, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e731a56e111so4245969276.1
        for <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1751497379; x=1752102179; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ag785EB9vhBjHLUGaVQ2TU6aie6bqCf9Nqui1fd6MCg=;
        b=tHxnsnPhIsiOLnB0EubyQdbq0k6ydq+nR8iRsKlfZb7iN3PD6fCpxP7fJhLj2IKVon
         sOhAJDZ9JPiRarxZNgBh+4YSBJO2VTP2Wqgg05U+DHJNoLCtuU29HckzMvCOFNGu274K
         oWwUhouDU+EbmOwyWYJw9I417M6fm4Ghs8Pfjglssd/qMkM4RrFTOIgocdb7nLGJ9S59
         +JNUIuQ9RiOFCQCJBLt/DXKmd/mq6VAfozuIHno/UyimC2ic3jiH/InidawSieurTb1R
         42AFgxGQKVTAB5L2C9WsJleYCip1h6CMuLNkZTrCvzKovyyIbG/yvPDEWT8J1hDPSgB2
         EXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751497379; x=1752102179;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ag785EB9vhBjHLUGaVQ2TU6aie6bqCf9Nqui1fd6MCg=;
        b=i6fjxkaFv3w3k3LfHdTX2dpLdxFB//0oHVclGSsTtLy9xnPpnveZ8tV43QERiQIwNg
         127E0T2Q/a5a24l7dDA8VvrhfQE/miCmDeUi1zfRJnTcfc57s3E6Qr5nHbd1gW1AGQN6
         h3suYy0ySTn2/E3whZz07xyNzhBrTXU5zaAFzfmnpg9qYJZH42TryJ46J7tuubkzyIu9
         G8I9/8ILY3nNPdHrBY4jcAufgFQARUrxsmX8cUef9qX1w2tLzPEledNUmg3D0w5/6oDK
         ahdjaWLQlUjbn7WnShYDhM4Lh3FIKMZapnRgTARWaLI85OP6STDFPfKIrHf/LhyN7DXJ
         r6sA==
X-Gm-Message-State: AOJu0Yz32hkSh+Pq/ILeiaNQgkvx5X42GjGcMOXkisFgWLz/ewJxxexJ
	HsZ1j7INBd3W85FMriz+TY03iMKfymsDFNWM08Wffhvkk5DOW0mNh9bTOw6FuHiP6orgDVd9vkB
	ta/v6VP39pCoTp+B5S/26xdUN1lKRlF7iTfflip1sMZA7UBjLJPPGh30=
X-Gm-Gg: ASbGncvxoj+5qyBN99r47UUgQWZsg4chqleKEym9wLUYH2/4XIFj8Ejmye+QJITstKI
	y4KaYWxedO5A5uM+cdfn4elVNaJ/SrXVsRmhOuO442bSal47LcGBz/6FqHOE6jR5guemyObAdt7
	9n0lPClZeyJ0WjXsRdjmZXEkwZ5D/+8+9aSD4SXGUmKnux
X-Google-Smtp-Source: AGHT+IFxFiIhIBra2OrXpMab6RPDMp6pQhWdo/hMoAYBNPOAOCu0ZyAxqGPLRlH0j7uXZ7eqJhVMWa6z3UyLxXVY03o=
X-Received: by 2002:a05:690c:4447:b0:708:f6d:b79f with SMTP id
 00721157ae682-7164d47f68amr67196637b3.29.1751497379343; Wed, 02 Jul 2025
 16:02:59 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Jul 2025 08:02:23 +0900
X-Gm-Features: Ac12FXx3Vr1k0Rwdaij31YA1smlAB_H9X8Fxa2GXHXfCi6AeaSZg_djQQKU40Jo
Message-ID: <CAODzB9px0iA5=NGdNc0Qby9ojfg77gfHESgWoE0YhphquC+OmA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Jul 2025 23:03:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19317

Hi!

It's this week's CVE report.

This week reported 10 new CVEs and 17 updated CVEs.

* New CVEs

CVE-2025-38084: mm/hugetlb: unshare page tables during VMA split, not before

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38084

Introduced by commit 39dde65 ("[PATCH] shared page table for hugetlb
page") in v2.6.20.16.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [081056dc00a27bccb55ccc3c6f230a3d5fd3f7e0]
stable/5.10: [e8847d18cd9fff1edbb45e963d9141273c3b539c]
stable/5.15: [366298f2b04d2bf1f2f2b7078405bdf9df9bd5d0]
stable/6.1: [2511ac64bc1617ca716d3ba8464e481a647c1902]
stable/6.12: [9cf5b2a3b72c23fb7b84736d5d19ee6ea718762b]
stable/6.6: [af6cfcd0efb7f051af221c418ec8b37a10211947]

CVE-2025-38085: mm/hugetlb: fix huge_pmd_unshare() vs GUP-fast race

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38085

Introduced by commit 39dde65 ("[PATCH] shared page table for hugetlb
page") in v2.6.20.16.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1013af4f585fccc4d3e5c5824d174de2257f7d6d]
stable/5.10: [952596b08c74e8fe9e2883d1dc8a8f54a37384ec]
stable/5.15: [a3d864c901a300c295692d129159fc3001a56185]
stable/6.1: [b7754d3aa7bf9f62218d096c0c8f6c13698fac8b]
stable/6.12: [034a52b5ef57c9c8225d94e9067f3390bb33922f]
stable/6.6: [fe684290418ef9ef76630072086ee530b92f02b8]

CVE-2025-38086: net: ch9200: fix uninitialised access during mii_nway_restart

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38086

Introduced by commit 4a476bd ("usbnet: New driver for QinHeng CH9200
devices") in v4.3-rc3.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ad0452c0277b816a435433cca601304cfac7c21]
stable/5.10: [33163c68d2e3061fa3935b5f0a1867958b1cdbd2]
stable/5.15: [9da3e442714f7f4393ff01c265c4959c03e88c2f]
stable/5.4: [119766de4930ff40db9f36b960cb53b0c400e81b]
stable/6.1: [9a350f30d65197354706b7759b5c89d6c267b1a9]
stable/6.12: [4da7fcc098218ff92b2e83a43f545c02f714cedd]
stable/6.6: [6bd2569d0b2f918e9581f744df0263caf73ee76c]

CVE-2025-38087: net/sched: fix use-after-free in taprio_dev_notifier

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38087

Introduced by commit fed87cc ("net/sched: taprio: automatically
calculate queueMaxSDU based on TC gate durations") in v6.3-rc1.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b160766e26d4e2e2d6fe2294e0b02f92baefcec5]
stable/6.12: [8a008c89e5e5c5332e4c0a33d707db9ddd529f8a]
stable/6.6: [8c5713ce1ced75f9e9ed5c642ea3d2ba06ead69c]

CVE-2025-38088: powerpc/powernv/memtrace: Fix out of bounds issue in
memtrace mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38088

Introduced by commit 08a022a ("powerpc/powernv/memtrace: Allow mmaping
trace buffers") in v5.13-rc1.
Fixed in v6.16-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd097df4596f3a1e9d75eb8520162de1eb8485b2]
stable/5.15: [81260c41b518b6f32c701425f1427562fa92f293]
stable/6.1: [620b77b23c41a6546e5548ffe2ea3ad71880dde4]
stable/6.12: [9c340b56d60545e4a159e41523dd8b23f81d3261]
stable/6.6: [8635e325b85dfb9ddebdfaa6b5605d40d16cd147]

CVE-2025-38089: sunrpc: handle SVC_GARBAGE during svc auth processing
as auth error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38089

Introduced by commit 29cd292 ("SUNRPC: Fix encoding of accepted but
unsuccessful RPC replies") in v6.4-rc3.
Fixed in v6.16-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94d10a4dba0bc482f2b01e39f06d5513d0f75742]
stable/6.12: [353e75b55e583635bf71cde6abcec274dba05edd]
stable/6.6: [599c489eea793821232a2f69a00fa57d82b0ac98]

CVE-2025-38090: drivers/rapidio/rio_cm.c: prevent possible heap overwrite

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38090

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.16-rc2.
Affected function was added by b6e8d4a ("rapidio: add RapidIO channelized
messaging driver") in 4.8-rc1.

Fixed status
mainline: [50695153d7ddde3b1696dbf0085be0033bf3ddb3]
stable/5.10: [c03ddc183249f03fc7e057e02cae6f89144d0123]
stable/5.15: [58f664614f8c3d6142ab81ae551e466dc6e092e8]
stable/5.4: [a8b5ea2e302aa5cd00fc7addd8df53c9bde7b5f6]
stable/6.1: [ecf5ee280b702270afb02f61b299d3dfe3ec7730]
stable/6.12: [1cce6ac47f4a2ac1766b8a188dc8c8f6d8df2a53]
stable/6.6: [1921781ec4a8824bd0c520bf9363e28a880d14ec]

CVE-2025-38091: drm/amd/display: check stream id dml21 wrapper to get plane_id

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38091

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15-rc7.
Affected file was added by 70839da ("drm/amd/display: Add new DCN401 sources")
in 6.11-rc1.

Fixed status
mainline: [2ddac70fed50485aa4ae49cdb7478ce41d8d4715]
stable/6.12: [6f47d7408133631a1b178f8a04e79aee189ef046]

CVE-2025-38092: ksmbd: use list_first_entry_or_null for opinfo_get_list()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38092

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.15.
The commit 18b4fac ("ksmbd: fix use-after-free in smb_break_all_levII_oplock()")
changed from list_first_or_null_rcu to list_first_entry that causes this bug.

Fixed status
mainline: [10379171f346e6f61d30d9949500a8de4336444a]
stable/6.12: [334da674b25fdb7a1a4d4b89dcd7795144fc7e11]
stable/6.6: [c78abb646ff823e7d22faad4cc0703d4484da9e8]

CVE-2025-38093: arm64: dts: qcom: x1e80100: Add GPU cooling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38093

Introduced by commit 721e383 ("arm64: dts: qcom: x1e80100: Add gpu
support") in v6.11-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ba21fa11f473c9827f378ace8c9f983de9e0287]
stable/6.12: [cd9d354bdd28b20a8f3170dab3bc0f096e66d6b4]

* Updated CVEs

CVE-2022-48773: xprtrdma: fix pointer derefs in error cases of rpcrdma_ep_create

stable/5.4 was fixed.

Fixed status
stable/5.10: [1e7433fb95ccc01629a5edaa4ced0cd8c98d0ae0]
stable/5.15: [9921c866dc369577c3ebb9adf2383b01b58c18de]
stable/5.4: [59892d18dd36e61514d3187b4b3cc7ae3e3b6ea8]

CVE-2022-48828: NFSD: Fix ia_size underflow

stable/5.4 was fixed.

Fixed status
stable/5.10: [38d02ba22e43b6fc7d291cf724bc6e3b7be6626b]
stable/5.15: [8e0ecaf7a7e57b30284d6b3289cc436100fadc48]
stable/5.4: [d2211e6e34d0755f35e2f8c22d81999fa81cfc71]

CVE-2022-48829: NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes

stable/5.4 was fixed.

Fixed status
stable/5.10: [a231ae6bb50e7c0a9e9efd7b0d10687f1d71b3a3]
stable/5.15: [37f2d2cd8eadddbbd9c7bda327a9393399b2f89b]
stable/5.4: [72c14aed6838b5d90b4dd926b6a339b34bb02e08]

CVE-2024-41013: xfs: don't walk off the end of a directory data block

stable/6.1 was fixed.

Fixed status
stable/6.1: [b0932e4f9da85349d1c8f2a77d2a7a7163b8511d]
stable/6.6: [ca96d83c93071f95cf962ce92406621a472df31b]

CVE-2024-46855: netfilter: nft_socket: fix sk refcount leaks

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [6572440f78b724c46070841a68254ebc534cde24]
stable/5.15: [ddc7c423c4a5386bf865474c694b48178efd311a]
stable/5.4: [076d281e90aaf4192799ecb9a1ed82321e133ecd]
stable/6.1: [33c2258bf8cb17fba9e58b111d4c4f4cf43a4896]
stable/6.10: [1f68e097e20d3c695281a9c6433acc37be47fe11]
stable/6.6: [83e6fb59040e8964888afcaa5612cc1243736715]

CVE-2024-57883: mm: hugetlb: independent PMD page table shared count

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [94b4b41d0cdf5cfd4d4325bc0e6e9e0d0e996133]
stable/5.15: [8410996eb6fea116fe1483ed977aacf580eee7b4]
stable/6.1: [02333ac1c35370517a19a4a131332a9690c6a5c7]
stable/6.12: [2e31443a0d18ae43b9d29e02bf0563f07772193d]
stable/6.6: [56b274473d6e7e7375f2d0a2b4aca11d67c6b52f]

CVE-2024-57996: net_sched: sch_sfq: don't allow 1 packet limit

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [1e6d9d87626cf89eeffb4d943db12cb5b10bf961]
stable/5.15: [1b562b7f9231432da40d12e19786c1bd7df653a7]
stable/6.1: [35d0137305ae2f97260a9047f445bd4434bd6cc7]
stable/6.12: [7d8947f2153ee9c5ab4cb17861a11cc45f30e8c4]
stable/6.13: [7fefc294204f10a3405f175f4ac2be16d63f135e]
stable/6.6: [833e9a1c27b82024db7ff5038a51651f48f05e5e]

CVE-2025-22112: eth: bnxt: fix out-of-range access of vnic_info array

stable/6.12 was fixed.

Fixed status
stable/6.12: [e1724f07693439deaa413ebc2a2640325cf247f5]
stable/6.14: [b1e081d331ab3a0dea25425f2b6ddeb365fc9d22]

CVE-2025-22119: wifi: cfg80211: init wiphy_work before allocating rfkill fails

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [b679fe84cd5cc6f3481b7131fd28676191ad2615]
stable/6.12: [60606efbf52582c0ab93e99789fddced6b47297a]
stable/6.14: [2617f60c3613ef105b8db2d514d2cac2a1836f7d]
stable/6.6: [eeacfbab984200dcdcd68fcf4c6e91e2c6b38792]

CVE-2025-22128: wifi: ath12k: Clear affinity hint before calling
ath12k_pci_free_irq() in error path

stable/6.12 was fixed.

Fixed status
stable/6.12: [a69a594794fcad96d4cfce12aab6c5014a12b4c8]
stable/6.14: [35b33ba76765ce9e72949d957f3cf1feafd2955c]

CVE-2025-23137: cpufreq/amd-pstate: Add missing NULL ptr check in
amd_pstate_update

stable/6.12 was fixed.

Fixed status
stable/6.12: [82b6dfff0d6000b14b271f74e43d672d81fb390e]
stable/6.14: [b99c1c63d88c75a4dc5487c3696cda38697b8d35]

CVE-2025-37752: net_sched: sch_sfq: move the limit validation

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [7d62ded97db6b7c94c891f704151f372b1ba4688]
stable/5.15: [6c589aa318023690f1606c666a7fb5f4c1c9c219]
stable/6.1: [1348214fa042a71406964097e743c87a42c85a49]
stable/6.12: [f86293adce0c201cfabb283ef9d6f21292089bb8]
stable/6.14: [b36a68192037d1614317a09b0d78c7814e2eecf9]
stable/6.6: [d2718324f9e329b10ddc091fba5a0ba2b9d4d96a]

CVE-2025-37929: arm64: errata: Add missing sentinels to Spectre-BHB MIDR arrays

stable/5.10 was fixed.

Fixed status
stable/5.10: [e68da90ac00d8b681561aeb8f5d6c47af3a04861]
stable/5.15: [6266b3509b2c6ebf2f9daf2239ff8eb60c5f5bd3]
stable/6.1: [446289b8b36b2ee98dabf6388acbddcc33ed41be]
stable/6.12: [090c8714efe1c3c470301cc2f794c1ee2a57746c]
stable/6.14: [333579202f09e260e8116321df4c55f80a19b160]
stable/6.6: [3821cae9bd5a99a42d3d0be1b58e41f072cd4c4c]

CVE-2025-37948: arm64: bpf: Add BHB mitigation to the epilogue for cBPF programs

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c6a8735d841bcb7649734bb3a787bb174c67c0d8]
stable/5.15: [993f63239c219696aef8887a4e7d3a16bf5a8ece]
stable/6.1: [8fe5c37b0e08a97cf0210bb75970e945aaaeebab]
stable/6.12: [38c345fd54afd9d6ed8d3fcddf3f6ea23887bf78]
stable/6.14: [852b8ae934b5cbdc62496fa56ce9969aa2edda7f]
stable/6.6: [42a20cf51011788f04cf2adbcd7681f02bdb6c27]

CVE-2025-37958: mm/huge_memory: fix dereferencing invalid pmd migration entry

stable/5.10, stable/5.15, stable/5.4, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [9468afbda3fbfcec21ac8132364dff3dab945faf]
stable/5.15: [ef5706bed97e240b4abf4233ceb03da7336bc775]
stable/5.4: [753f142f7ff7d2223a47105b61e1efd91587d711]
stable/6.1: [22f6368768340260e862f35151d2e1c55cb1dc75]
stable/6.12: [6166c3cf405441f7147b322980144feb3cefc617]
stable/6.14: [fbab262b0c8226c697af1851a424896ed47dedcc]
stable/6.6: [3977946f61cdba87b6b5aaf7d7094e96089583a5]

CVE-2025-37963: arm64: bpf: Only mitigate cBPF programs loaded by
unprivileged users

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [038866e01ea5e5a3d948898ac216e531e7848669]
stable/5.15: [df53d418709205450a02bb4d71cbfb4ff86f2c1e]
stable/6.1: [6e52d043f7dbf1839a24a3fab2b12b0d3839de7a]
stable/6.12: [e5f5100f1c64ac6c72671b2cf6b46542fce93706]
stable/6.14: [477481c4348268136227348984b6699d6370b685]
stable/6.6: [80251f62028f1ab2e09be5ca3123f84e8b00389a]

CVE-2025-38083: net_sched: prio: fix a race in prio_tune()

stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/5.10: [4483d8b9127591c60c4eb789d6cab953bc4522a9]
stable/5.15: [20f68e6a9e41693cb0e55e5b9ebbcb40983a4b8f]
stable/5.4: [53d11560e957d53ee87a0653d258038ce12361b7]
stable/6.1: [3aaa7c01cf19d9b9bb64b88b65c3a6fd05da2eb4]
stable/6.12: [e3f6745006dc9423d2b065b90f191cfa11b1b584]
stable/6.15: [93f9eeb678d4c9c1abf720b3615fa8299a490845]
stable/6.6: [46c15c9d0f65c9ba857d63f53264f4b17e8a715f]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

