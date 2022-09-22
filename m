Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4C78ECAAD8
	for <webhook@archiver.kernel.org>; Thu, 22 Sep 2022 00:06:52 +0000 (UTC)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mx.groups.io with SMTP id smtpd.web10.1702.1663805206819937210
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Sep 2022 17:06:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=7HcHfxKI;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.180,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f180.google.com with SMTP id m81so10273442oia.1
        for <cip-dev@lists.cip-project.org>;
 Wed, 21 Sep 2022 17:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=ZT2Qnbx+K9DnG2ZeOSRXBHsovbNu0MUwQSR1OThCc+w=;
        b=7HcHfxKIRVhKJhmh4DECuXPWzdXSrLUUZGspuez7NKEE1HioYsPyGrTTJdOnM7n9WB
         tV0aBqQe2KNhJv3q2eaAfYxPXKn4/RrOmEZpuO5jhKvpgj3tZYsj0na+LtJqrVI0Lozi
         Vn1FVVYDb6KjtLvPMDP+vM0xcVuD/rA1G6xArwpWYt9T3SlKF2q7Si63UFOV8aVk6CoG
         kwVeTKl1/NnX28NJ+wHxgvgDqbPcxRWQdi7cS91M5P43NG4Wl7g52Mp80OrlzEUjuTrS
         tXEi9fK4hdTj1NqoxGuo5l/p47GFd1UtqG8tOeuqa9f6QdjWqOIfKpudPMbPcdW1VtKE
         bFIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ZT2Qnbx+K9DnG2ZeOSRXBHsovbNu0MUwQSR1OThCc+w=;
        b=7QCcybIAnfV0KfjaB35YkXFT890bfeYbOikZdpN/OKasYwZ9Pe13LPhj48Gx0r617w
         rAxY1aYSypSPb5u58UAs9ZOuXwwjDf0LXkKiX27q+7RYx1c7CRfzltSR5cFfZ+gbrHd+
         e1VCkxWor/NG4Hdq+ZIKpQrIXE67E9BT9TOr2REnvEYkp9Ej9J7c9LFGADRw4oVWaZaz
         qWMsO/PcTKLmFLikklAc7P2QCjVivFzkx4QQPLaflLngkZsVnAMz1mGFN9GUpfoj1pxu
         p6HuzSnhHnQPmu+TXtdNPM0Eqb+PZaUoxr8uVmM+nV9V6q/iG+lxtu1YJ4YplLVupBjh
         /k+g==
X-Gm-Message-State: ACrzQf2TzID0rvXoRuvgVgG60CkW64D2gpeE+91iC/foYRyTXJCix7FZ
	Jascl6f0gc4IU+E9SLvvR9uhbhbgDIhW5AurPd996fyVMbrTpQ==
X-Google-Smtp-Source: 
 AMsMyM6UagzLAcIBZ7Is71cbLRKBfItNeHFD0ijF/9jJk/VpB/vFuuKzZjJXlqmBGG+w+UHHRLIR0agJcTajIaeRe1E=
X-Received: by 2002:a05:6808:1304:b0:350:649b:f8a1 with SMTP id
 y4-20020a056808130400b00350649bf8a1mr366668oiv.280.1663805205478; Wed, 21 Sep
 2022 17:06:45 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 22 Sep 2022 09:06:09 +0900
Message-ID: 
 <CAODzB9pM64A8SzV-=AAFUcsRa-GDo6JcMi8wVZTQFbqTnEjKqQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Sep 2022 00:06:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9534

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 4 updated CVEs.

* New CVEs

CVE-2022-40476: io_uring: use original request task for inflight tracking

CVSS v3 score is 5.5 MEDIUM.

A null pointer dereference issue was discovered in fs/io_uring.c in
the Linux kernel before 5.15.62. A local user could use this flaw to
crash the system or potentially cause a denial of service.

This vulnerability was introduced by commit d536123 ("io_uring: drop
the old style inflight file tracking") which was merged in 5.19-rc1.
Kernel 5.4 and 5.10 doesn't have commit d536123.

Fixed status
mainline: [386e4fb6962b9f248a80f8870aea0870ca603e89]
stable/5.15: [3746d62ecf1c872a520c4866118edccb121c44fd]

CVE-2022-3176: io_uring: disable polling pollfree files

CVSS v3 score is 7.8 HIGH.

There exists a use-after-free in io_uring in the Linux kernel.
Signalfd_poll() and binder_poll() use a waitqueue whose lifetime is
the current task. It will send a POLLFREE notification to all waiters
before the queue is freed. Unfortunately, the io_uring poll doesn't
handle POLLFREE. This allows a use-after-free to occur if a signalfd
or binder fd is polled with io_uring poll, and the waitqueue gets
freed.

Fixed status
mainline: [791f3465c4afde02d7f16cf7424ca87070b69396]
stable/5.10: [28d8d2737e82fc29ff9e788597661abecc7f7994]
stable/5.15: [e9d7ca0c4640cbebe6840ee3bac66a25a9bacaf5]
stable/5.4: [fc78b2fc21f10c4c9c4d5d659a685710ffa63659]

CVE-2022-40768: scsi: stex: properly zero out the passthrough command structure

CVSS v3 score is 5.5 MEDIUM.

drivers/scsi/stex.c in the Linux kernel through 5.19.9 allows local
users to obtain sensitive information from kernel memory because
stex_queuecommand_lck lacks a memset for the PASSTHRU_CMD case.

Fixed status
Patch is available at
lore.kernel.org/all/20220908145154.2284098-1-gregkh@linuxfoundation.org
but it has not been merged yet as of 2022-09-19.

CVE-2022-41218: media: dvb-core: Fix UAF due to refcount races at releasing

CVSS v3 score is not assigned.

In drivers/media/dvb-core/dmxdev.c in the Linux kernel through
5.19.10, there is a use-after-free caused by refcount races, affecting
dvb_demux_open and dvb_dmxdev_release.

It looks as if kernel 4.4 is affected too.

Fixed status
Patch is available on
https://lore.kernel.org/all/20220908132754.30532-1-tiwai@suse.de/ but
it hasn't been merged into the mainline yet.

CVE-2022-41222: mm/mremap: hold the rmap lock in write mode when
moving page table entries

CVSS v3 score is not assigned.

mm/mremap.c in the Linux kernel before 5.13.3 has a use-after-free via
a stale TLB because an rmap lock is not held during a PUD move.

kernel 4.x doesn't have 2c91bd4 ("mm: speed up mremap by 20x on large
regions") and c49dd34 ("mm: speedup mremap on 1GB or larger regions")
so that these kernels won't be affected.

mainline: [97113eb39fa7972722ff490b947d8af023e1f6a2]
stable/5.10: [2613baa3ab2153cc45b175c58700d93f72ef36c4]
stable/5.4: [79e522101cf40735f1936a10312e17f937b8dcad]

* Updated CVEs

CVE-2021-4159: bpf: Verifer, adjust_scalar_min_max_vals to always call
update_reg_bounds()

4.14 was fixed this week.

Fixed status
mainline: [294f2fc6da27620a506e6c050241655459ccd6bd]
stable/4.14: [a7cf53f9ebcd887c19588c0c1b4b8260f41a3faa]
stable/4.19: [6c6b84ef5ea8dc0ca3559ccf69810960e348c555]
stable/5.4: [7c1134c7da997523e2834dd516e2ddc51920699a]

CVE-2022-40307: efi: capsule-loader: Fix use-after-free in efi_capsule_write

Stable kernels except 4.9 were fixed this week. Applying the patch to
4.9 was failed (https://lore.kernel.org/stable/166265645917687@kroah.com/).

Fixed status
mainline: [9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95]
stable/4.14: [233d5c4d18971feee5fc2f33f00b63d8205cfc67]
stable/4.19: [021805af5bedeafc76c117fc771c100b358ab419]
stable/5.10: [918d9c4a4bdf5205f2fb3f64dddfb56c9a1d01d6]
stable/5.15: [dd291e070be0eca8807476b022bda00c891d9066]
stable/5.19: [d46815a8f26ca6db2336106a148265239f73b0af]
stable/5.4: [8028ff4cdbb3f20d3c1c04be33a83bab0cb94997]

CVE-2022-39188: unmap_mapping_range() race with munmap() on VM_PFNMAP
mappings leads to stale TLB entry

stable/4.19 56fa5f3 ("mm: Fix TLB flush for not-first PFNMAP mappings
in unmap_region()") and stable 5.10 891f03f ("mm: Fix TLB flush for
not-first PFNMAP mappings in unmap_region()") have been added.
These commits are stable specific patches which fix an issue when
backporting the upstream commit b67fbeb ("mmu_gather: Force tlb-flush
VM_PFNMAP vmas"). This fix has been sent to 5.4 and 5.15.

Fixed status
mainline: [b67fbebd4cf980aecbcc750e1462128bffe8ae15]
stable/4.14: [b8a54a2a45feacbc96065e5d6b9a1cbee2aa1e9d]
stable/4.19: [c3b1e88f14e7f442e2ddcbec94527eec84ac0ca3,
56fa5f3dd44a05a5eacd75ae9d00c5415046d371]
stable/4.9: [390f33a95419f7fa1254ba6b6feeabde480732f9]
stable/5.10: [895428ee124ad70b9763259308354877b725c31d,
891f03f688de8418f44b32b88f6b4faed5b2aa81]
stable/5.15: [3ffb97fce282df03723995f5eed6a559d008078e]
stable/5.4: [c9c5501e815132530d741ec9fdd22657f91656bc]

CVE-2022-2663: netfilter: nf_conntrack_irc: Tighten matching on DCC message

mainline and stable kernels were fixed. Commit 0efe125 ("netfilter:
nf_conntrack_irc: Fix forged IP logic") can be applied to 4.4.y-st
without any modification.

Fixed status
mainline: [0efe125cfb99e6773a7434f3463f7c2fa28f3a43]
stable/4.14: [6ce66e3442a5989cbe56a6884384bf0b7d1d0725]
stable/4.19: [3275f7804f40de3c578d2253232349b07c25f146]
stable/4.9: [eb4d8d6b44a23ff2b6e2af06c8240de73dff8a7d]
stable/5.10: [e12ce30fe593dd438c5b392290ad7316befc11ca]
stable/5.15: [451c9ce1e2fc9b9e40303bef8e5a0dca1a923cc4]
stable/5.19: [6cf0609154b2ce8d3ae160e7506ab316400a8d3d]
stable/5.4: [36f7b71f8ad8e4d224b45f7d6ecfeff63b091547]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh
Provisioning Leads to MITM

No fix information.

CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning

No fix information.

CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning

No fix information.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

