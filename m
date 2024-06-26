Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC8FC27C4F
	for <webhook@archiver.kernel.org>; Wed, 26 Jun 2024 23:25:47 +0000 (UTC)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
 by mx.groups.io with SMTP id smtpd.web11.1870.1719444339114229396
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jun 2024 16:25:39 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=IDjbCUB1;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.51, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2598a57b2c1so3439274fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1719444338; x=1720049138; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oW+oZ0pNcwiDXvp1RPIC2ljzNWKU6qIiTMUypS8M53g=;
        b=IDjbCUB1SYD2xCyDACl92Zm+c803RMjOH31zHS7FC6RuY81SoJrDsGd8iJ7dM6/5p+
         Pw7BQ/OzY6tNVc47STJEcMpePBhKFg7Eh+qmCvVx7Mjq1FXYwn1uPQoZWlDUXntJJ56G
         w+WxpJmoptSrMwBOPEzUMoR5IMF8Y3aTrCvuxyL+xnsvihdajp5v7vITKMR4vx0kXCZz
         gRAdN0onEoVqhBwUxAb/Xksrtex3GM4Fn/E9oA9wiX1RCZr/fHNu/RlAfQpgdm2CnLB4
         yOX/sSuQOezFeiN0VLDdNgsxgTs+AXgfTocGl/w3XfZ5zoOvW6zcU5NvbDSRp3nXfnOK
         +tnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719444338; x=1720049138;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oW+oZ0pNcwiDXvp1RPIC2ljzNWKU6qIiTMUypS8M53g=;
        b=wlZNdVbV04hax19j5ivtp0u6va98UZUETm5Q+ba37qDDd81pV49kg0izykB6EUWZ9R
         rLz+EDuFS4B88SiP3tI4+a0n/cJiQlVb7z4IVuzjVZugr6xvBlRnbIVBXHcapZ2P+lA7
         4+bCEx7TPE9cmP+a5zqz76m+HXpQA8u1BHwEpFgIk8VtFn/pkEayb2bH+C4cpoSwg66l
         1j7HtA0/QbQQnksXY9JGhcjuIwVqvzPK/dJhnE305++PraXeSoobtVlPCRUZSEI0fBAE
         x/bM1i83jdUJrNQbF5lSGQuKeuCeyfYEFnq4+RARluahHHNXwJnfjVoenYDnYgfcA97m
         ym9A==
X-Gm-Message-State: AOJu0YyzykEai1QGouteVTkre4e4xF+To9G72816c/bhYgw2kT6mCg/H
	VH07cR1CF1iHFj0rSvJe+5Q5Ozjg/rcL/vsV6+skMniSr27ngSPM4LOrWHbd+qyiOTMZ7XC0vca
	e9OrueRS/WFnJZKptvhaopcaWqeYAqR+3iycZV9qa+xDzaQKf264=
X-Google-Smtp-Source: AGHT+IECp2Nk6zxd+nsRuy/NFyjLTtfwYxwdpSQvuWdkv4/EPESSell+Va49hRtOMS6U9LYEa1HqB1VtOyKoiFJjjZ0=
X-Received: by 2002:a05:6870:a2c7:b0:254:b0b0:9336 with SMTP id
 586e51a60fabf-25d06bc8565mr12815605fac.2.1719444335886; Wed, 26 Jun 2024
 16:25:35 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Jun 2024 08:24:59 +0900
Message-ID: <CAODzB9pgDiinwxFYspy19SHiqJqv5UsiguJa7ye2u7CwddOx1Q@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jun 2024 23:25:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16335

Hi!

It's this week's CVE report.

This week reported 150 new CVEs and 12 updated CVEs.

* New CVEs
CVE-2024-38619: usb-storage: alauda: Check whether the media is initialized

Announce: https://lore.kernel.org/linux-cve-announce/2024062035-CVE-2024-38619-97c7@gregkh/

Introduced by commit e80b0fa ("[PATCH] USB Storage: add alauda
support") in v2.6.20.16.
Fixed in v6.10-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16637fea001ab3c8df528a8995b3211906165a30]
stable/6.1: [e0e2eec76920a133dd49a4fbe4656d83596a1361]
stable/6.6: [2cc32639ec347e3365075b130f9953ef16cb13f1]

CVE-2021-4439: isdn: cpai: check ctr->cnr to avoid array index out of bound

Announce: https://lore.kernel.org/linux-cve-announce/2024062001-CVE-2021-4439-59ce@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.15-rc6.

Fixed status
cip/4.4: [e8b8de17e164c9f1b7777f1c6f99d05539000036]
cip/4.4-rt: [e8b8de17e164c9f1b7777f1c6f99d05539000036]
cip/4.4-st: [e8b8de17e164c9f1b7777f1c6f99d05539000036]
mainline: [1f3e2e97c003f80c4b087092b225c8787ff91e4d]
stable/4.19: [7d91adc0ccb060ce564103315189466eb822cc6a]
stable/5.10: [7f221ccbee4ec662e2292d490a43ce6c314c4594]
stable/5.4: [285e9210b1fab96a11c0be3ed5cea9dd48b6ac54]

CVE-2021-47617: PCI: pciehp: Fix infinite loop in IRQ handler upon power fault

Announce: https://lore.kernel.org/linux-cve-announce/2024062005-CVE-2021-47617-da02@gregkh/

Introduced by commit 8edf533 ("PCI: pciehp: Fix MSI interrupt race")
in v5.7-rc1.
Fixed in v5.17-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19 stable/5.4

Fixed status
mainline: [23584c1ed3e15a6f4bfab8dc5a88d94ab929ee12]
stable/4.19: [ff27f7d0333cff89ec85c419f431aca1b38fb16a]
stable/5.10: [3b4c966fb156ff3e70b2526d964952ff7c1574d9]
stable/5.15: [1db58c6584a72102e98af2e600ea184ddaf2b8af]
stable/5.4: [464da38ba827f670deac6500a1de9a4f0f44c41d]

CVE-2021-47618: ARM: 9170/1: fix panic when kasan and kprobe are enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024062007-CVE-2021-47618-fd65@gregkh/

Introduced by commit 35aa1df ("ARM kprobes: instruction
single-stepping support") in v2.6.25-rc1.
Introduced by commit 4210157 ("ARM: 9017/2: Enable KASan for ARM") in v5.11-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b59b0a53c840921b625378f137e88adfa87647e]
stable/5.15: [1515e72aae803fc6b466adf918e71c4e4c9d5b3d]

CVE-2021-47619: i40e: Fix queues reservation for XDP

Announce: https://lore.kernel.org/linux-cve-announce/2024062012-CVE-2021-47619-8dbb@gregkh/

Introduced by commit 41c445f ("i40e: main driver core") in v3.12-rc1.
Introduced by commit 74608d1 ("i40e: add support for XDP_TX action")
in v4.13-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92947844b8beee988c0ce17082b705c2f75f0742]
stable/4.19: [d46fa4ea9756ef6cbcf9752d0832cc66e2d7121b]
stable/5.10: [768eb705e6381f0c70ca29d4e66f19790d5d19a1]
stable/5.15: [00eddb0e4ea115154581d1049507a996acfc2d3e]
stable/5.4: [be6998f232b8e4ca8225029e305b8329d89bfd59]

CVE-2021-47620: Bluetooth: refactor malicious adv data check

Announce: https://lore.kernel.org/linux-cve-announce/2024062014-CVE-2021-47620-a200@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc1.

Fixed status
cip/4.4: [305e92f525450f3e1b5f5c9dc7eadb152d66a082]
cip/4.4-rt: [305e92f525450f3e1b5f5c9dc7eadb152d66a082]
cip/4.4-st: [305e92f525450f3e1b5f5c9dc7eadb152d66a082]
mainline: [899663be5e75dc0174dc8bda0b5e6826edf0b29a]
stable/4.19: [8819f93cd4a443dfe547aa622b21f723757df3fb]
stable/5.10: [83d5196b65d1b29e27d7dd16a3b9b439fb1d2dba]
stable/5.15: [bcea886771c3f22a590c8c8b9139a107bd7f1e1c]
stable/5.4: [835d3706852537bf92eb23eb8635b8dee0c0aa67]

CVE-2022-48711: tipc: improve size validations for received domain records

Announce: https://lore.kernel.org/linux-cve-announce/2024062053-CVE-2022-48711-4d4e@gregkh/

Introduced by commit 35c55c9 ("tipc: add neighbor monitoring
framework") in v4.8-rc1.
Fixed in v5.17-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [5385b4231e31a64bee1c2a636eb68e2b5461f005]
cip/4.4-rt: [5385b4231e31a64bee1c2a636eb68e2b5461f005]
cip/4.4-st: [5385b4231e31a64bee1c2a636eb68e2b5461f005]
mainline: [9aa422ad326634b76309e8ff342c246800621216]
stable/4.19: [f1af11edd08dd8376f7a84487cbb0ea8203e3a1d]
stable/5.10: [3c7e5943553594f68bbc070683db6bb6f6e9e78e]
stable/5.15: [1f1788616157b0222b0c2153828b475d95e374a7]
stable/5.4: [d692e3406e052dbf9f6d9da0cba36cb763272529]

CVE-2022-48712: ext4: fix error handling in ext4_fc_record_modified_inode()

Announce: https://lore.kernel.org/linux-cve-announce/2024062054-CVE-2022-48712-6289@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.
Affected file is not present before 5.10. The fast_commit.c was added by
commit 6866d7b3f (ext4 / jbd2: add fast commit initialization") in 5.10-rc1.

Fixed status
mainline: [cdce59a1549190b66f8e3fe465c2b2f714b98a94]
stable/5.10: [62e46e0ffc02daa8fcfc02f7a932cc8a19601b19]
stable/5.15: [1b6762ecdf3cf12113772427c904aa3c420a1802]

CVE-2022-48713: perf/x86/intel/pt: Fix crash with stop filters in
single-range mode

Announce: https://lore.kernel.org/linux-cve-announce/2024062054-CVE-2022-48713-6025@gregkh/

Introduced by commit 6706384 ("perf/x86/intel/pt: Opportunistically
use single range output mode") in v5.5-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1d9093457b243061a9bba23543c38726e864a643]
stable/5.10: [456f041e035913fcedb275aff6f8a71dfebcd394]
stable/5.15: [e83d941fd3445f660d2f43647c580a320cc384f6]

CVE-2022-48714: bpf: Use VM_MAP instead of VM_ALLOC for ringbuf

Announce: https://lore.kernel.org/linux-cve-announce/2024062054-CVE-2022-48714-726f@gregkh/

Introduced by commit 457f443 ("bpf: Implement BPF ring buffer and
verifier support for it") in v5.8-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b293dcc473d22a62dc6d78de2b15e4f49515db56]
stable/5.10: [6304a613a97d6dcd49b93fbad31e9f39d1e138d6]
stable/5.15: [5e457aeab52a5947619e1f18047f4d2f3212b3eb]

CVE-2022-48715: scsi: bnx2fc: Make bnx2fc_recv_frame() mp safe

Announce: https://lore.kernel.org/linux-cve-announce/2024062055-CVE-2022-48715-dba4@gregkh/

Introduced by commit d576a5e ("bnx2fc: Improve stats update
mechanism") in v3.16-rc4.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [6df50fb492a9f5e439ae51c33890fb7c8448b688]
cip/4.4-rt: [6df50fb492a9f5e439ae51c33890fb7c8448b688]
cip/4.4-st: [6df50fb492a9f5e439ae51c33890fb7c8448b688]
mainline: [936bd03405fc83ba039d42bc93ffd4b88418f1d3]
stable/4.19: [003bcee66a8f0e76157eb3af369c173151901d97]
stable/5.10: [ec4334152dae175dbd8fd5bde1d2139bbe7b42d0]
stable/5.15: [2f5a1ac68bdf2899ce822ab845081922ea8c588e]
stable/5.4: [53e4f71763c61a557283eb43301efd671922d1e8]

CVE-2022-48716: ASoC: codecs: wcd938x: fix incorrect used of portid

Announce: https://lore.kernel.org/linux-cve-announce/2024062055-CVE-2022-48716-7621@gregkh/

Introduced by commit e8ba1e0 ("ASoC: codecs: wcd938x: add basic
controls") in v5.14-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5c1546a654f613e291a7c5d6f3660fc1eb6d0c7]
stable/5.15: [aa7152f9f117b3e66b3c0d4158ca4c6d46ab229f]

CVE-2022-48717: ASoC: max9759: fix underflow in speaker_gain_control_put()

Announce: https://lore.kernel.org/linux-cve-announce/2024062055-CVE-2022-48717-064d@gregkh/

Introduced by commit fa8d915 ("ASoC: max9759: Add Amplifier Driver")
in v4.17-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c907bcd9dcd233da6707059d777ab389dcbd964]
stable/4.19: [a0f49d12547d45ea8b0f356a96632dd503941c1e]
stable/5.10: [5a45448ac95b715173edb1cd090ff24b6586d921]
stable/5.15: [baead410e5db49e962a67fffc17ac30e44b50b7c]
stable/5.4: [71e60c170105d153e34d01766c1e4db26a4b24cc]

CVE-2022-48718: drm: mxsfb: Fix NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024062056-CVE-2022-48718-1d94@gregkh/

Introduced by commit b776b0f ("drm: mxsfb: Use bus_format from the
nearest bridge if present") in v5.15-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [622c9a3a7868e1eeca39c55305ca3ebec4742b64]
stable/5.15: [86a337bb803040e4401b87c974a7fb92efe3d0e1]

CVE-2022-48719: net, neigh: Do not trigger immediate probes on
NUD_FAILED from neigh_managed_work

Announce: https://lore.kernel.org/linux-cve-announce/2024062056-CVE-2022-48719-4312@gregkh/

Introduced by commit 7482e38 ("net, neigh: Add NTF_MANAGED flag for
managed neighbor entries") in v5.16-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a81f6da9cb2d1ef911131a6fd8bd15cb61fc772]

CVE-2022-48720: net: macsec: Fix offload support for NETDEV_UNREGISTER event

Announce: https://lore.kernel.org/linux-cve-announce/2024062056-CVE-2022-48720-5541@gregkh/

Introduced by commit 3cf3227 ("net: macsec: hardware offloading
infrastructure") in v5.6-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cef24c8b76c1f6effe499d2f131807c90f7ce9a]
stable/5.10: [2e7f5b6ee1a7a2c628253a95b0a95b582901ef1b]
stable/5.15: [e7a0b3a0806dae3cc81931f0e83055ca2ac6f455]

CVE-2022-48721: net/smc: Forward wakeup to smc socket waitqueue after fallback

Announce: https://lore.kernel.org/linux-cve-announce/2024062056-CVE-2022-48721-3959@gregkh/

Introduced by commit 2153bd1 ("net/smc: Transfer remaining wait queue
entries during fallback") in v5.16-rc2.
Fixed in v5.17-rc3.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [341adeec9adad0874f29a0a1af35638207352a39]
stable/5.15: [0ef6049f664941bc0f75828b3a61877635048b27]

CVE-2022-48722: net: ieee802154: ca8210: Stop leaking skb's

Announce: https://lore.kernel.org/linux-cve-announce/2024062057-CVE-2022-48722-dc20@gregkh/

Introduced by commit ded845a ("ieee802154: Add CA8210 IEEE 802.15.4
device driver") in v4.12-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [621b24b09eb61c63f262da0c9c5f0e93348897e5]
stable/4.19: [d6a44feb2f28d71a7e725f72d09c97c81561cd9a]
stable/5.10: [78b3f20c17cbcb7645bfa63f2ca0e11b53c09d56]
stable/5.15: [94cd597e20ed4acedb8f15f029d92998b011cb1a]
stable/5.4: [6f38d3a6ec11c2733b1c641a46a2a2ecec57be08]

CVE-2022-48723: spi: uniphier: fix reference count leak in uniphier_spi_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024062057-CVE-2022-48723-1347@gregkh/

Introduced by commit 28d1ddd ("spi: uniphier: Add DMA transfer mode
support") in v5.6-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37c2c83ca4f1ef4b6908181ac98e18360af89b42]
stable/5.10: [e895e067d73e154b1ebc84a124e00831e311d9b0]
stable/5.15: [dd00b4f8f768d81c3788a8ac88fdb3d745e55ea3]

CVE-2022-48724: iommu/vt-d: Fix potential memory leak in
intel_setup_irq_remapping()

Announce: https://lore.kernel.org/linux-cve-announce/2024062057-CVE-2022-48724-6bcd@gregkh/

Introduced by commit e3beca4 ("irqdomain/treewide: Keep firmware node
unconditionally allocated") in v5.8-rc6.
Fixed in v5.17-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19 stable/5.4

Fixed status
mainline: [99e675d473eb8cf2deac1376a0f840222fc1adcf]
stable/4.19: [a31cb1f0fb6caf46ffe88c41252b6b7a4ee062d9]
stable/5.10: [9d9995b0371e4e8c18d4f955479e5d47efe7b2d4]
stable/5.15: [336d096b62bdc673e852b6b80d5072d7888ce85d]
stable/5.4: [5c43d46daa0d2928234dd2792ebebc35d29ee2d1]

CVE-2022-48725: RDMA/siw: Fix refcounting leak in siw_create_qp()

Announce: https://lore.kernel.org/linux-cve-announce/2024062058-CVE-2022-48725-aba3@gregkh/

Introduced by commit 514aee6 ("RDMA: Globally allocate and release QP
memory") in v5.15-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a75badebfdc0b3823054bedf112edb54d6357c75]
stable/5.15: [2989ba9532babac66e79997ccff73c015b69700c]

CVE-2022-48726: RDMA/ucma: Protect mc during concurrent multicast leaves

Announce: https://lore.kernel.org/linux-cve-announce/2024062058-CVE-2022-48726-adb1@gregkh/

Introduced by commit 95fe510 ("RDMA/ucma: Remove mc_list and rely on
xarray") in v5.10-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36e8169ec973359f671f9ec7213547059cae972e]
stable/5.10: [75c610212b9f1756b9384911d3a2c347eee8031c]
stable/5.15: [2923948ffe0835f7114e948b35bcc42bc9b3baa1]

CVE-2022-48727: KVM: arm64: Avoid consuming a stale esr value when SError occur

Announce: https://lore.kernel.org/linux-cve-announce/2024062058-CVE-2022-48727-5101@gregkh/

Introduced by commit defe21f ("KVM: arm64: Move PC rollback on SError
to HYP") in v5.11-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c71dbc8a179d99dd9bb7e7fc1888db613cf85de]
stable/5.15: [e1e852746997500f1873f60b954da5f02cc2dba3]

CVE-2022-48728: IB/hfi1: Fix AIP early init panic

Announce: https://lore.kernel.org/linux-cve-announce/2024062058-CVE-2022-48728-caf6@gregkh/

Introduced by commit d99dc60 ("IB/hfi1: Add functions to transmit
datagram ipoib packets") in v5.8-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f8f55b92edd621f056bdf09e572092849fabd83]
stable/5.10: [4a9bd1e6780fc59f81466ec3489d5ad535a37190]
stable/5.15: [a3dd4d2682f2a796121609e5f3bbeb1243198c53]

CVE-2022-48729: IB/hfi1: Fix panic with larger ipoib send_queue_size

Announce: https://lore.kernel.org/linux-cve-announce/2024062059-CVE-2022-48729-dc0b@gregkh/

Introduced by commit d47dfc2 ("IB/hfi1: Remove cache and embed txreq
in ring") in v5.16-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c83d39cc730378bbac64d67a551897b203a606e]

CVE-2022-48730: dma-buf: heaps: Fix potential spectre v1 gadget

Announce: https://lore.kernel.org/linux-cve-announce/2024062059-CVE-2022-48730-f1fd@gregkh/

Introduced by commit c02a81f ("dma-buf: Add dma-buf heaps framework")
in v5.6-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92c4cfaee6872038563c5b6f2e8e613f9d84d47d]
stable/5.10: [5d40f1bdad3dd1a177f21a90ad4353c1ed40ba3a]
stable/5.15: [24f8e12d965b24f8aea762589e0e9fe2025c005e]

CVE-2022-48731: mm/kmemleak: avoid scanning potential huge holes

Announce: https://lore.kernel.org/linux-cve-announce/2024062059-CVE-2022-48731-d547@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [c10a0f877fe007021d70f9cada240f42adc2b5db]
stable/5.10: [352715593e81b917ce1b321e794549815b850134]
stable/5.15: [a5389c80992f0001ee505838fe6a8b20897ce96e]
stable/5.4: [d3533ee20e9a0e2e8f60384da7450d43d1c63d1a]

CVE-2022-48732: drm/nouveau: fix off by one in BIOS boundary checking

Announce: https://lore.kernel.org/linux-cve-announce/2024062000-CVE-2022-48732-9d9b@gregkh/

Introduced by commit 4d4e990 ("drm/nouveau/bios: guard against
out-of-bounds accesses to image") in v4.8-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b777d4d9e383d2744fc9b3a09af6ec1893c8b1a]
stable/4.19: [b2a21669ee98aafc41c6d42ef15af4dab9e6e882]
stable/5.10: [f071d9fa857582d7bd77f4906691f73d3edeab73]
stable/5.15: [d877e814a62b7de9069aeff8bc1d979dfc996e06]
stable/5.4: [acc887ba88333f5fec49631f12d8cc7ebd95781c]

CVE-2022-48733: btrfs: fix use-after-free after failure to create a snapshot

Announce: https://lore.kernel.org/linux-cve-announce/2024062000-CVE-2022-48733-4217@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [28b21c558a3753171097193b6f6602a94169093a]
stable/5.15: [a7b717fa15165d3d9245614680bebc48a52ac05d]

CVE-2022-48734: btrfs: fix deadlock between quota disable and qgroup
rescan worker

Announce: https://lore.kernel.org/linux-cve-announce/2024062000-CVE-2022-48734-88b7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [e804861bd4e69cc5fe1053eedcb024982dde8e48]
stable/5.10: [32747e01436aac8ef93fe85b5b523b4f3b52f040]
stable/5.15: [89d4cca583fc9594ee7d1a0bc986886d6fb587e6]
stable/5.4: [26b3901d20bf9da2c6a00cb1fb48932166f80a45]

CVE-2022-48735: ALSA: hda: Fix UAF of leds class devs at unbinding

Announce: https://lore.kernel.org/linux-cve-announce/2024062001-CVE-2022-48735-32e6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [549f8ffc7b2f7561bea7f90930b6c5104318e87b]
stable/5.10: [a7de1002135cf94367748ffc695a29812d7633b5]
stable/5.15: [0e629052f013eeb61494d4df2f1f647c2a9aef47]

CVE-2022-48736: ASoC: ops: Reject out of bounds values in snd_soc_put_xr_sx()

Announce: https://lore.kernel.org/linux-cve-announce/2024062001-CVE-2022-48736-afa0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
cip/4.4: [46057f6ddfddc634a16f0885b1e9b8c50f1605ed]
cip/4.4-rt: [46057f6ddfddc634a16f0885b1e9b8c50f1605ed]
cip/4.4-st: [46057f6ddfddc634a16f0885b1e9b8c50f1605ed]
mainline: [4cf28e9ae6e2e11a044be1bcbcfa1b0d8675fe4d]
stable/4.19: [7659f25a80e6affb784b690df8994b79b4212fd4]
stable/5.10: [6877f87579ed830f9ff6d478539074f035d04bfb]
stable/5.15: [b0a7836ecf1345814a7d8ef748fb797c520dad18]
stable/5.4: [fd9a23319f16e7031f0d8c98eed6e093c2927229]

CVE-2022-48737: ASoC: ops: Reject out of bounds values in snd_soc_put_volsw_sx()

Announce: https://lore.kernel.org/linux-cve-announce/2024062001-CVE-2022-48737-8efb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
cip/4.4: [7a78bde1faa42e0057350378baf518a04b3bae58]
cip/4.4-rt: [7a78bde1faa42e0057350378baf518a04b3bae58]
cip/4.4-st: [7a78bde1faa42e0057350378baf518a04b3bae58]
mainline: [4f1e50d6a9cf9c1b8c859d449b5031cacfa8404e]
stable/4.19: [9a12fcbf3c622f9bf6b110a873d62b0cba93972e]
stable/5.10: [038f8b7caa74d29e020949a43ca368c93f6b29b9]
stable/5.15: [e8e07c5e25a29e2a6f119fd947f55d7a55eb8a13]
stable/5.4: [c33402b056de61104b6146dedbe138ca8d7ec62b]

CVE-2022-48738: ASoC: ops: Reject out of bounds values in snd_soc_put_volsw()

Announce: https://lore.kernel.org/linux-cve-announce/2024062001-CVE-2022-48738-ecf0@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
cip/4.4: [86ad5e66a4c50aa415e9c3e0ba5cc8bd023708d2]
cip/4.4-rt: [86ad5e66a4c50aa415e9c3e0ba5cc8bd023708d2]
cip/4.4-st: [86ad5e66a4c50aa415e9c3e0ba5cc8bd023708d2]
mainline: [817f7c9335ec01e0f5e8caffc4f1dcd5e458a4c0]
stable/4.19: [65a61b1f56f5386486757930069fbdce94af08bf]
stable/5.10: [a9394f21fba027147bf275b083c77955864c366a]
stable/5.15: [9e8895f1b3d4433f6d78aa6578e9db61ca6e6830]
stable/5.4: [68fd718724284788fc5f379e0b7cac541429ece7]

CVE-2022-48739: ASoC: hdmi-codec: Fix OOB memory accesses

Announce: https://lore.kernel.org/linux-cve-announce/2024062002-CVE-2022-48739-c0d9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.
The iec_status value was added by commit 7a8e1d4421 ("ASoC: hdmi-codec:
Add iec958 controls") in 5.14-rc1.

Fixed status
mainline: [06feec6005c9d9500cd286ec440aabf8b2ddd94d]
stable/5.15: [10007bd96b6c4c3cfaea9e76c311b06a07a5e260]

CVE-2022-48740: selinux: fix double free of cond_list on error paths

Announce: https://lore.kernel.org/linux-cve-announce/2024062002-CVE-2022-48740-a623@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc3.

Fixed status
mainline: [186edf7e368c40d06cf727a1ad14698ea67b74ad]
stable/5.10: [f446089a268c8fc6908488e991d28a9b936293db]
stable/5.15: [70caa32e6d81f45f0702070c0e4dfe945e92fbd7]

CVE-2022-48741: ovl: fix NULL pointer dereference in copy up warning

Announce: https://lore.kernel.org/linux-cve-announce/2024062002-CVE-2022-48741-cdd7@gregkh/

Introduced by commit 5b0a414 ("ovl: fix filattr copy-up failure") in v5.16-rc1.
Fixed in v5.17-rc3.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [4ee7e4a6c9b298da44029ed9ec8ed23ae49cc209]
stable/5.15: [e6b678c1a3673de6a5d2f4e22bb725a086a0701a]

CVE-2022-48742: rtnetlink: make sure to refresh master_dev/m_ops in
__rtnl_newlink()

Announce: https://lore.kernel.org/linux-cve-announce/2024062003-CVE-2022-48742-6393@gregkh/

Introduced by commit ba7d49b ("rtnetlink: provide api for getting and
setting slave info") in v3.14-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [d707a4f8965d1b7e5193b4b6f13de2a9f03f4257]
cip/4.4-rt: [d707a4f8965d1b7e5193b4b6f13de2a9f03f4257]
cip/4.4-st: [d707a4f8965d1b7e5193b4b6f13de2a9f03f4257]
mainline: [c6f6f2444bdbe0079e41914a35081530d0409963]
stable/4.19: [a01e60a1ec6bef9be471fb7182a33c6d6f124e93]
stable/5.10: [3bbe2019dd12b8d13671ee6cda055d49637b4c39]
stable/5.15: [def5e7070079b2a214b3b1a2fbec623e6fbfe34a]
stable/5.4: [bd43771ee9759dd9dfae946bff190e2c5a120de5]

CVE-2022-48743: net: amd-xgbe: Fix skb data length underflow

Announce: https://lore.kernel.org/linux-cve-announce/2024062003-CVE-2022-48743-ee30@gregkh/

Introduced by commit 622c36f ("amd-xgbe: Fix jumbo MTU processing on
newer hardware") in v4.11-rc4.
Fixed in v5.17-rc3.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.4: [9bf0b2cf782c03adeee198134706670ca157d44e]
cip/4.4-rt: [9bf0b2cf782c03adeee198134706670ca157d44e]
cip/4.4-st: [9bf0b2cf782c03adeee198134706670ca157d44e]
mainline: [5aac9108a180fc06e28d4e7fb00247ce603b72ee]
stable/4.19: [34aeb4da20f93ac80a6291a2dbe7b9c6460e9b26]
stable/5.10: [4d3fcfe8464838b3920bc2b939d888e0b792934e]
stable/5.15: [db6fd92316a254be2097556f01bccecf560e53ce]
stable/5.4: [9892742f035f7aa7dcd2bb0750effa486db89576]

CVE-2022-48744: net/mlx5e: Avoid field-overflowing memcpy()

Announce: https://lore.kernel.org/linux-cve-announce/2024062003-CVE-2022-48744-0f03@gregkh/

Introduced by commit b5503b9 ("net/mlx5e: XDP TX forwarding support")
in v4.9-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad5185735f7dab342fdd0dd41044da4c9ccfef67]

CVE-2022-48745: net/mlx5: Use del_timer_sync in fw reset flow of halting poll

Announce: https://lore.kernel.org/linux-cve-announce/2024062004-CVE-2022-48745-7f0a@gregkh/

Introduced by commit 38b9f90 ("net/mlx5: Handle sync reset request
event") in v5.10-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c5193a87b0fea090aa3f769d020337662d87b5e]
stable/5.10: [502c37b033fab7cde3e95a570af4f073306be45e]
stable/5.15: [f895ebeb44d09d02674cfdd0cfc2bf687603918c]

CVE-2022-48746: net/mlx5e: Fix handling of wrong devices during bond netevent

Announce: https://lore.kernel.org/linux-cve-announce/2024062004-CVE-2022-48746-3d3a@gregkh/

Introduced by commit 7e51891 ("net/mlx5e: Use netdev events to set/del
egress acl forward-to-vport rule") in v5.8-rc1.
Fixed in v5.17-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec41332e02bd0acf1f24206867bb6a02f5877a62]
stable/5.10: [a01ee1b8165f4161459b5ec4e728bc7130fe8cd4]
stable/5.15: [fe70126da6063c29ca161cdec7ad1dae9af836b3]

CVE-2022-48747: block: Fix wrong offset in bio_truncate()

Announce: https://lore.kernel.org/linux-cve-announce/2024062004-CVE-2022-48747-c63f@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc1.
Valnerable code was added by commit 85a8ce62c ("block: add bio_truncate
to fix guard_bio_eod") in 5.5-rc5.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [3ee859e384d453d6ac68bfd5971f630d9fa46ad3]
stable/5.10: [b63e120189fd92aff00096d11e2fc5253f60248b]
stable/5.15: [4633a79ff8bc82770486a063a08b55e5162521d8]
stable/5.4: [6cbf4c731d7812518cd857c2cfc3da9fd120f6ae]

CVE-2022-48748: net: bridge: vlan: fix memory leak in __allowed_ingress

Announce: https://lore.kernel.org/linux-cve-announce/2024062004-CVE-2022-48748-3e75@gregkh/

Introduced by commit a580c76 ("net: bridge: vlan: add per-vlan state")
in v5.6-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd20d9738395cf8e27d0a17eba34169699fccdff]
stable/5.10: [446ff1fc37c74093e81db40811a07b5a19f1d797]
stable/5.15: [c5e216e880fa6f2cd9d4a6541269377657163098]

CVE-2022-48749: drm/msm/dpu: invalid parameter check in dpu_setup_dspp_pcc

Announce: https://lore.kernel.org/linux-cve-announce/2024062005-CVE-2022-48749-0566@gregkh/

Introduced by commit 4259ff7 ("drm/msm/dpu: add support for pcc color
block in dpu driver") in v5.8-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [170b22234d5495f5e0844246e23f004639ee89ba]
stable/5.10: [93a6e920d8ccb4df846c03b6e72f7e08843d294c]
stable/5.15: [8f069f6dde518dfebe86e848508c07e497bd9298]

CVE-2022-48750: hwmon: (nct6775) Fix crash in clear_caseopen

Announce: https://lore.kernel.org/linux-cve-announce/2024062005-CVE-2022-48750-20d1@gregkh/

Introduced by commit 2e7b988 ("hwmon: (nct6775) Use superio_*()
function pointers in sio_data.") in v5.16-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79da533d3cc717ccc05ddbd3190da8a72bc2408b]

CVE-2022-48751: net/smc: Transitional solution for clcsock race issue

Announce: https://lore.kernel.org/linux-cve-announce/2024062005-CVE-2022-48751-10d0@gregkh/

Introduced by commit fd57770 ("net/smc: wait for pending work before
clcsock release_sock") in v5.1-rc6.
Fixed in v5.17-rc2.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [c0bf3d8a943b6f2e912b7c1de03e2ef28e76f760]
stable/5.15: [38f0bdd548fd2ef5d481b88d8a2bfef968452e34]

CVE-2022-48752: powerpc/perf: Fix power_pmu_disable to call
clear_pmi_irq_pending only if PMI is pending

Announce: https://lore.kernel.org/linux-cve-announce/2024062006-CVE-2022-48752-7ff8@gregkh/

This CVE announce does not contain fixed commit in the mainline.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [fb6433b48a178d4672cb26632454ee0b21056eaa]
stable/5.10: [55402a4618721f350a9ab660bb42717d8aa18e7c]
stable/5.15: [28aaed966e76807a71de79dd40a8eee9042374dd]

CVE-2022-48753: block: fix memory leak in
disk_register_independent_access_ranges

Announce: https://lore.kernel.org/linux-cve-announce/2024062006-CVE-2022-48753-38c0@gregkh/

Introduced by commit a2247f1 ("block: Add independent access ranges
support") in v5.16-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83114df32ae779df57e0af99a8ba6c3968b2ba3d]

CVE-2022-48754: phylib: fix potential use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024062006-CVE-2022-48754-4012@gregkh/

Introduced by commit bafbdd5 ("phylib: Add device reset GPIO support")
in v4.16-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cbda1b16687580d5beee38273f6241ae3725960c]
stable/4.19: [67d271760b037ce0806d687ee6057edc8afd4205]
stable/5.10: [bd024e36f68174b1793906c39ca16cee0c9295c2]
stable/5.15: [aefaccd19379d6c4620269a162bfb88ff687f289]
stable/5.4: [f39027cbada43b33566c312e6be3db654ca3ad17]

CVE-2022-48755: powerpc64/bpf: Limit 'ldbrx' to processors compliant
with ISA v2.06

Announce: https://lore.kernel.org/linux-cve-announce/2024062006-CVE-2022-48755-8abf@gregkh/

Introduced by commit 156d0e2 ("powerpc/ebpf/jit: Implement JIT
compiler for extended BPF") in v4.8-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f5f766d5f7f95a69a630da3544a1a0cee1cdddf]
stable/5.10: [129c71829d7f46423d95c19e8d87ce956d4c6e1c]
stable/5.15: [3bfbc00587dc883eaed383558ae512a351c2cd09]

CVE-2022-48756: drm/msm/dsi: invalid parameter check in msm_dsi_phy_enable

Announce: https://lore.kernel.org/linux-cve-announce/2024062007-CVE-2022-48756-fc26@gregkh/

Introduced by commit 5c82902 ("drm/msm/dsi: Split PHY drivers to
separate files") in v4.3-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e761a2287234bc402ba7ef07129f5103bcd775c]
stable/4.19: [ca63eeb70fcb53c42e1fe54e1735a54d8e7759fd]
stable/5.10: [79c0b5287ded74f4eacde4dfd8aa0a76cbd853b5]
stable/5.15: [56480fb10b976581a363fd168dc2e4fbee87a1a7]
stable/5.4: [581317b1f001b7509041544d7019b75571daa100]

CVE-2022-48757: net: fix information leakage in /proc/net/ptype

Announce: https://lore.kernel.org/linux-cve-announce/2024062007-CVE-2022-48757-c816@gregkh/

Introduced by commit 2feb27d ("[NETNS]: Minor information leak via
/proc/net/ptype file.") in v2.6.26-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [8f88c78d24f6f346919007cd459fd7e51a8c7779]
cip/4.4-rt: [8f88c78d24f6f346919007cd459fd7e51a8c7779]
cip/4.4-st: [8f88c78d24f6f346919007cd459fd7e51a8c7779]
mainline: [47934e06b65637c88a762d9c98329ae6e3238888]
stable/4.19: [b67ad6170c0ea87391bb253f35d1f78857736e54]
stable/5.10: [db044d97460ea792110eb8b971e82569ded536c6]
stable/5.15: [e43669c77cb3a742b7d84ecdc7c68c4167a7709b]
stable/5.4: [e372ecd455b6ebc7720f52bf4b5f5d44d02f2092]

CVE-2022-48758: scsi: bnx2fc: Flush destroy_work queue before calling
bnx2fc_interface_put()

Announce: https://lore.kernel.org/linux-cve-announce/2024062007-CVE-2022-48758-1500@gregkh/

Introduced by commit 0cbf32e ("[SCSI] bnx2fc: Avoid calling
bnx2fc_if_destroy with unnecessary locks") in v3.2-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4: [2a12fe8248a38437b95b942bbe85aced72e6e2eb]
cip/4.4-rt: [2a12fe8248a38437b95b942bbe85aced72e6e2eb]
cip/4.4-st: [2a12fe8248a38437b95b942bbe85aced72e6e2eb]
mainline: [847f9ea4c5186fdb7b84297e3eeed9e340e83fce]
stable/4.19: [de6336b17a1376db1c0f7a528cce8783db0881c0]
stable/5.10: [00849de10f798a9538242824a51b1756e7110754]
stable/5.15: [b11e34f7bab21df36f02a5e54fb69e858c09a65d]
stable/5.4: [bf2bd892a0cb14dd2d21f2c658f4b747813be311]

CVE-2022-48759: rpmsg: char: Fix race between the release of
rpmsg_ctrldev and cdev

Announce: https://lore.kernel.org/linux-cve-announce/2024062008-CVE-2022-48759-d017@gregkh/

Introduced by commit c0cdc19 ("rpmsg: Driver for user space endpoint
interface") in v4.11-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7fb2dad571d1e21173c06cef0bced77b323990a]
stable/4.19: [70cb4295ec806b663665e1d2ed15caab6159880e]
stable/5.10: [1dbb206730f3e5ce90014ad569ddf8167ec4124a]
stable/5.15: [85aba11a8ea92a8eef2de95ebbe063086fd62d9c]
stable/5.4: [da27b834c1e0222e149e06caddf7718478086d1b]

CVE-2022-48760: USB: core: Fix hang in usb_kill_urb by adding memory barriers

Announce: https://lore.kernel.org/linux-cve-announce/2024062008-CVE-2022-48760-b80e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.

Fixed status
cip/4.4: [5f138ef224dffd15d5e5c5b095859719e0038427]
cip/4.4-rt: [5f138ef224dffd15d5e5c5b095859719e0038427]
cip/4.4-st: [5f138ef224dffd15d5e5c5b095859719e0038427]
mainline: [26fbe9772b8c459687930511444ce443011f86bf]
stable/4.19: [5904dfd3ddaff3bf4a41c3baf0a8e8f31ed4599b]
stable/5.10: [e3b131e30e612ff0e32de6c1cb4f69f89db29193]
stable/5.15: [9340226388c66a7e090ebb00e91ed64a753b6c26]
stable/5.4: [9c61fce322ac2ef7fecf025285353570d60e41d6]

CVE-2022-48761: usb: xhci-plat: fix crash when suspend if remote wake enable

Announce: https://lore.kernel.org/linux-cve-announce/2024062008-CVE-2022-48761-51ee@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
Introduced by commit c1df456d ("PM: domains: Don't runtime resume devices
at genpd_prepare()") in 5.13-rc1.

Fixed status
mainline: [9df478463d9feb90dae24f183383961cf123a0ec]
stable/5.10: [20c51a4c52208f98e27308c456a1951778f41fa5]
stable/5.15: [d5755832a1e47f5d8773f0776e211ecd4e02da72]

CVE-2022-48762: arm64: extable: fix load_unaligned_zeropad() reg indices

Announce: https://lore.kernel.org/linux-cve-announce/2024062009-CVE-2022-48762-9a17@gregkh/

Introduced by commit 753b323 ("arm64: extable: add
load_unaligned_zeropad() handler") in v5.16-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3758a6c74e08bdc15ccccd6872a6ad37d165239a]

CVE-2022-48763: KVM: x86: Forcibly leave nested virt when SMM state is toggled

Announce: https://lore.kernel.org/linux-cve-announce/2024062009-CVE-2022-48763-862a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.

Fixed status
mainline: [f7e570780efc5cec9b2ed1e0472a7da14e864fdb]
stable/5.10: [080dbe7e9b86a0392d8dffc00d9971792afc121f]
stable/5.15: [e302786233e6bc512986d007c96458ccf5ca21c7]

CVE-2022-48764: KVM: x86: Free kvm_cpuid_entry2 array on post-KVM_RUN
KVM_SET_CPUID{,2}

Announce: https://lore.kernel.org/linux-cve-announce/2024062009-CVE-2022-48764-6de1@gregkh/

This CVE announce does not contain fixed commit in the mainline.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [811f95ff95270e6048197821434d9301e3d7f07c]

CVE-2022-48765: KVM: LAPIC: Also cancel preemption timer during SET_LAPIC

Announce: https://lore.kernel.org/linux-cve-announce/2024062009-CVE-2022-48765-ddb8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.

Fixed status
mainline: [35fe7cfbab2e81f1afb23fc4212210b1de6d9633]
stable/5.15: [54b3439c8e70e0bcfea59aeef9dd98908cbbf655]

CVE-2022-48766: drm/amd/display: Wrap dcn301_calculate_wm_and_dlg for FPU.

Announce: https://lore.kernel.org/linux-cve-announce/2024062010-CVE-2022-48766-3b8e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
Supporting dcn 3.01 was added by commit 3a83e4e64 ("drm/amd/display: Add dcn3.01
support to DC (v2)") in 5.11-rc1 so before this version is not affected.

Fixed status
mainline: [25f1488bdbba63415239ff301fe61a8546140d9f]

CVE-2022-48767: ceph: properly put ceph_string reference after async
create attempt

Announce: https://lore.kernel.org/linux-cve-announce/2024062010-CVE-2022-48767-e91d@gregkh/

Introduced by commit 9a8d03c ("ceph: attempt to do async create when
possible") in v5.7-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [932a9b5870d38b87ba0a9923c804b1af7d3605b9]
stable/5.10: [e7be12ca7d3947765b0d7c1c7e0537e748da993a]
stable/5.15: [36d433ae3242aa714176378850e6d1a5a3e78f18]

CVE-2022-48768: tracing/histogram: Fix a potential memory leak for kstrdup()

Announce: https://lore.kernel.org/linux-cve-announce/2024062010-CVE-2022-48768-afee@gregkh/

Introduced by commit d380dcd ("tracing: Fix now invalid var_ref_vals
assumption in trace action") in v5.6-rc1.
Fixed in v5.17-rc2.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [e629e7b525a179e29d53463d992bdee759c950fb]
stable/5.10: [d71b06aa995007eafd247626d0669b9364c42ad7]
stable/5.15: [e33fa4a46ee22de88a700e2e3d033da8214a5175]
stable/5.4: [8a8878ebb596281f50fc0b9a6e1f23f0d7f154e8]

CVE-2022-48769: efi: runtime: avoid EFIv2 runtime services on Apple x86 machines

Announce: https://lore.kernel.org/linux-cve-announce/2024062011-CVE-2022-48769-0ff7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v5.17-rc2.
Vulnerable code was added by commit 14fb420 ("efi: Merge EFI system table
revision and vendor checks") in 5.7-rc1.

Fixed status
mainline: [f5390cd0b43c2e54c7cf5506c7da4a37c5cef746]
stable/5.10: [b0f1cc093bc2493ac259c53766fd2b800e085807]
stable/5.15: [3df52448978802ae15dcebf66beba1029df957b4]

CVE-2022-48770: bpf: Guard against accessing NULL pt_regs in
bpf_get_task_stack()

Announce: https://lore.kernel.org/linux-cve-announce/2024062011-CVE-2022-48770-34e0@gregkh/

Introduced by commit fa28dcb ("bpf: Introduce helper
bpf_get_task_stack()") in v5.9-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b992f01e66150fc5e90be4a96f5eb8e634c8249e]
stable/5.10: [ff6bdc205fd0a83bd365405d4e31fb5905826996]
stable/5.15: [0bcd484587b3b3092e448d27dc369e347e1810c3]

CVE-2022-48771: drm/vmwgfx: Fix stale file descriptors on failed usercopy

Announce: https://lore.kernel.org/linux-cve-announce/2024062011-CVE-2022-48771-2c90@gregkh/

Introduced by commit c906965 ("drm/vmwgfx: Add export fence to file
descriptor support") in v4.14-rc1.
Fixed in v5.17-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0f90c8815706981c483a652a6aefca51a5e191c]
stable/4.19: [0008a0c78fc33a84e2212a7c04e6b21a36ca6f4d]
stable/5.10: [ae2b20f27732fe92055d9e7b350abc5cdf3e2414]
stable/5.15: [6066977961fc6f437bc064f628cf9b0e4571c56c]
stable/5.4: [84b1259fe36ae0915f3d6ddcea6377779de48b82]

CVE-2023-52883: drm/amdgpu: Fix possible null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024062030-CVE-2023-52883-0069@gregkh/

Introduced by commit 1802537 ("drm/ttm: stop allocating dummy
resources during BO creation") in v6.4-rc1.
Fixed in v6.6-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51b79f33817544e3b4df838d86e8e8e4388ff684]

CVE-2024-38620: Bluetooth: HCI: Remove HCI_AMP support

Announce: https://lore.kernel.org/linux-cve-announce/2024062047-CVE-2024-38620-64ef@gregkh/

Introduced by commit e7b0229 ("Bluetooth: Remove BT_HS") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [84a4bb6548a29326564f0e659fb8064503ecc1c7]
stable/6.6: [5af2e235b0d5b797e9531a00c50058319130e156]

CVE-2023-52884: Input: cyapa - add missing input core locking to
suspend/resume functions

Announce: https://lore.kernel.org/linux-cve-announce/2024062131-CVE-2023-52884-5b0d@gregkh/

Introduced by commit d69f0a4 ("Input: use input_device_enabled()") in v5.11-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b4e0b39182cf5e677c1fc092a3ec40e621c25b6]
stable/5.15: [f99809fdeb50d65bcbc1661ef391af94eebb8a75]
stable/6.1: [9400caf566f65c703e99d95f87b00c4b445627a7]
stable/6.6: [a4c638ab25786bd5aab5978fe51b2b9be16a4ebd]

CVE-2024-31076: genirq/cpuhotplug, x86/vector: Prevent vector leak
during CPU offline

Announce: https://lore.kernel.org/linux-cve-announce/2024062134-CVE-2024-31076-786e@gregkh/

Introduced by commit f0383c2 ("genirq/cpuhotplug: Add support for
cleaning up move in progress") in v4.13-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6c11c0a5235fb144a65e0cb2ffd360ddc1f6c32]
stable/4.19: [a40209d355afe4ed6d533507838c9e5cd70a76d8]
stable/5.10: [6752dfcfff3ac3e16625ebd3f0ad9630900e7e76]
stable/5.15: [9eeda3e0071a329af1eba15f4e57dc39576bb420]
stable/5.4: [f5f4675960609d8c5ee95f027fbf6ce380f98372]
stable/6.1: [e9c96d01d520498b169ce734a8ad1142bef86a30]
stable/6.6: [59f86a2908380d09cdc726461c0fbb8d8579c99f]

CVE-2024-33619: efi: libstub: only free priv.runtime_map when allocated

Announce: https://lore.kernel.org/linux-cve-announce/2024062134-CVE-2024-33619-8d3e@gregkh/

Introduced by commit f80d260 ("efi: libstub: avoid
efi_get_memory_map() for allocating the virt map") in v6.1-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b2543f7e1e6b91cfc8dd1696e3cdf01c3ac8974]
stable/6.1: [b8938d6f570f010a1dcdbfed3e5b5d3258c2a908]
stable/6.6: [9dce01f386c9ce6990c0a83fa14b1c95330b037e]

CVE-2024-33621: ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound

Announce: https://lore.kernel.org/linux-cve-announce/2024062134-CVE-2024-33621-d3a6@gregkh/

Introduced by commit 2ad7bf3 ("ipvlan: Initial check-in of the IPVLAN
driver.") in v3.19-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3dc6e8003b500861fa307e9a3400c52e78e4d3a]
stable/4.19: [0049a623dfbbb49888de7f0c2f33a582b5ead989]
stable/5.10: [1abbf079da59ef559d0ab4219d2a0302f7970761]
stable/5.15: [183c4b416454b9983dc1b8aa0022b748911adc48]
stable/5.4: [54768bacfde60e8e4757968d79f8726711dd2cf5]
stable/6.1: [cb53706a3403ba67f4040b2a82d9cf79e11b1a48]
stable/6.6: [54213c09801e0bd2549ac42961093be36f65a7d0]

CVE-2024-34777: dma-mapping: benchmark: fix node id validation

Announce: https://lore.kernel.org/linux-cve-announce/2024062150-CVE-2024-34777-34d1@gregkh/

Introduced by commit 65789da ("dma-mapping: add benchmark support for
streaming DMA APIs") in v5.11-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ff05e723f7ca30644b8ec3fb093f16312e408ad]
stable/5.15: [35d31c8bd4722b107f5a2f5ddddce839de04b936]
stable/6.1: [c57874265a3c5206d7aece3793bb2fc9abcd7570]
stable/6.6: [34a816d8735f3924b74be8e5bf766ade1f3bd10b]

CVE-2024-36244: net/sched: taprio: extend minimum interval restriction
to entire cycle too

Announce: https://lore.kernel.org/linux-cve-announce/2024062134-CVE-2024-36244-f88f@gregkh/

Introduced by commit b5b73b2 ("taprio: Fix allowing too small
intervals") in v5.9-rc7.
Fixed in v6.10-rc2.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [fb66df20a7201e60f2b13d7f95d031b31a8831d3]
stable/6.6: [b939d1e04a90248b4cdf417b0969c270ceb992b2]

CVE-2024-36270: netfilter: tproxy: bail out if IP has been disabled on
the device

Announce: https://lore.kernel.org/linux-cve-announce/2024062135-CVE-2024-36270-f7f7@gregkh/

Introduced by commit cc6eb43 ("tproxy: use the interface primary IP
address as a default value for --on-ip") in v2.6.37-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21a673bddc8fd4873c370caf9ae70ffc6d47e8d3]
stable/5.10: [07eeedafc59c45fe5de43958128542be3784764c]
stable/5.15: [6fe5af4ff06db3d4d80e07a19356640428159f03]
stable/5.4: [10f0af5234dafd03d2b75233428ec3f11cf7e43d]
stable/6.1: [caf3a8afb5ea00db6d5398adf148d5534615fd80]
stable/6.6: [570b4c52096e62fda562448f5760fd0ff06110f0]

CVE-2024-36281: net/mlx5: Use mlx5_ipsec_rx_status_destroy to
correctly delete status rules

Announce: https://lore.kernel.org/linux-cve-announce/2024062135-CVE-2024-36281-8446@gregkh/

Introduced by commit 94af50c ("net/mlx5e: Unify esw and normal IPsec
status table creation/destruction") in v6.7-rc6.
Fixed in v6.10-rc2.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [16d66a4fa81da07bc4ed19f4e53b87263c2f8d38]
stable/6.6: [b0a15cde37a8388e57573686f650a17208ae1212]

CVE-2024-36286: netfilter: nfnetlink_queue: acquire rcu_read_lock() in
instance_destroy_rcu()

Announce: https://lore.kernel.org/linux-cve-announce/2024062135-CVE-2024-36286-ebd5@gregkh/

Introduced by commit 9872bec ("[NETFILTER]: nfnetlink: use RCU for
queue instances hash") in v2.6.25-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc21c6cc3d6986d938efbf95de62473982c98dec]
stable/4.19: [8658bd777cbfcb0c13df23d0ea120e70517761b9]
stable/5.10: [e01065b339e323b3dfa1be217fd89e9b3208b0ab]
stable/5.15: [25ea5377e3d2921a0f96ae2551f5ab1b36825dd4]
stable/5.4: [3989b817857f4890fab9379221a9d3f52bf5c256]
stable/6.1: [68f40354a3851df46c27be96b84f11ae193e36c5]
stable/6.6: [8f365564af898819a523f1a8cf5c6ce053e9f718]

CVE-2024-36288: SUNRPC: Fix loop termination condition in
gss_free_in_token_pages()

Announce: https://lore.kernel.org/linux-cve-announce/2024062150-CVE-2024-36288-d24a@gregkh/

Introduced by commit bafa6b4 ("SUNRPC: Fix gss_free_in_token_pages()")
in v6.10-rc1.
Fixed in v5.4.278.
Bug introduced commit was backported to following branches.
cip/6.1 stable/4.19 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.6 stable/6.9

Fixed status
mainline: [4a77c3dead97339478c7422eb07bf4bf63577008]
stable/4.19: [57ff6c0a175930856213b2aa39f8c845a53e5b1c]
stable/5.10: [4cefcd0af7458bdeff56a9d8dfc6868ce23d128a]
stable/5.15: [b4878ea99f2b40ef1925720b1b4ca7f4af1ba785]
stable/5.4: [6ed45d20d30005bed94c8c527ce51d5ad8121018]
stable/6.1: [f9977e4e0cd98a5f06f2492b4f3547db58deabf5]
stable/6.6: [af628d43a822b78ad8d4a58d8259f8bf8bc71115]

CVE-2024-36477: tpm_tis_spi: Account for SPI header when allocating
TPM SPI xfer buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024062150-CVE-2024-36477-7063@gregkh/

Introduced by commit a86a42a ("tpm_tis_spi: Add hardware wait
polling") in v6.6-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [195aba96b854dd664768f382cd1db375d8181f88]
stable/6.6: [1547183852dcdfcc25878db7dd3620509217b0cd]

CVE-2024-36478: null_blk: fix null-ptr-dereference while configuring
'power' and 'submit_queues'

Announce: https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36478-d249@gregkh/

Introduced by commit 45919fb ("null_blk: Enable modifying
'submit_queues' after an instance has been configured") in v5.5-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2db328b0839312c169eb42746ec46fc1ab53ed2]

CVE-2024-36481: tracing/probes: fix error check in parse_btf_field()

Announce: https://lore.kernel.org/linux-cve-announce/2024062151-CVE-2024-36481-b416@gregkh/

Introduced by commit c440adf ("tracing/probes: Support BTF based data
structure field access") in v6.6-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e569eb34970281438e2b48a3ef11c87459fcfbcb]
stable/6.6: [ad4b202da2c498fefb69e5d87f67b946e7fe1e6a]

CVE-2024-36484: net: relax socket state check at accept time.

Announce: https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36484-375b@gregkh/

Introduced by commit 9406279 ("tcp: defer shutdown(SEND_SHUTDOWN) for
TCP_SYN_RECV sockets") in v6.9.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19
stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [26afda78cda3da974fd4c287962c169e9462c495]
stable/6.1: [c09ddc605893df542c6cf8dde6a57a93f7cf0adb]
stable/6.6: [87bdc9f6f58b4417362d6932b49b828e319f97dc]

CVE-2024-36489: tls: fix missing memory barrier in tls_init

Announce: https://lore.kernel.org/linux-cve-announce/2024062136-CVE-2024-36489-7213@gregkh/

Introduced by commit d5bee73 ("net/tls: Annotate access to sk_prot
with READ_ONCE/WRITE_ONCE") in v5.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91e61dd7a0af660408e87372d8330ceb218be302]
stable/5.10: [d72e126e9a36d3d33889829df8fc90100bb0e071]
stable/5.15: [2c260a24cf1c4d30ea3646124f766ee46169280b]
stable/6.1: [335c8f1566d8e44c384d16b450a18554896d4e8b]
stable/6.6: [ab67c2fd3d070a21914d0c31319d3858ab4e199c]

CVE-2024-37353: virtio: delete vq in vp_find_vqs_msix() when request_irq() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024062137-CVE-2024-37353-71d4@gregkh/

Introduced by commit 0b0f9dc ("Revert "virtio_pci: use shared
interrupts for virtqueues"") in v4.11-rc7.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89875151fccdd024d571aa884ea97a0128b968b6]
stable/4.19: [cb7a7c8144b434e06aba99b13b045a7efe859587]
stable/5.10: [7fbe54f02a5c77ff5dd65e8ed0b58e3bd8c43e9c]
stable/5.15: [42d30da50d5c1ec433fd9551bfddd6887407c352]
stable/5.4: [43a9aaf63254ab821f0f25fea25698ebe69ea16a]
stable/6.1: [abf001651acd1858252764fa39d79e3d0b5c86b2]
stable/6.6: [04207a9c64e0b16dac842e5b2ecfa53af25bdea7]

CVE-2024-37356: tcp: Fix shift-out-of-bounds in dctcp_update_alpha().

Announce: https://lore.kernel.org/linux-cve-announce/2024062137-CVE-2024-37356-cc7b@gregkh/

Introduced by commit e3118e8 ("net: tcp: add DCTCP congestion control
algorithm") in v3.18-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ebc46ca8675de6378e3f8f40768e180bb8afa66]
stable/4.19: [06d0fe049b51b0a92a70df8333fd85c4ba3eb2c6]
stable/5.10: [e9b2f60636d18dfd0dd4965b3316f88dfd6a2b31]
stable/5.15: [8602150286a2a860a1dc55cbd04f99316f19b40a]
stable/5.4: [6aacaa80d962f4916ccf90e2080306cec6c90fcf]
stable/6.1: [e65d13ec00a738fa7661925fd5929ab3c765d4be]
stable/6.6: [02261d3f9dc7d1d7be7d778f839e3404ab99034c]

CVE-2024-38381: nfc: nci: Fix uninit-value in nci_rx_work

Announce: https://lore.kernel.org/linux-cve-announce/2024062137-CVE-2024-38381-07fb@gregkh/

Introduced by commit d24b035 ("nfc: nci: Fix uninit-value in
nci_dev_up and nci_ntf_packet") in v6.9-rc2.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [e4a87abf588536d1cdfb128595e6e680af5cf3ed]
stable/4.19: [406cfac9debd4a6d3dc5d9258ee086372a8c08b6]
stable/5.10: [f80b786ab0550d0020191a59077b2c7e069db2d1]
stable/5.15: [ad4d196d2008c7f413167f0a693feb4f0439d7fe]
stable/5.4: [485ded868ed62ceb2acb3a459d7843fd71472619]
stable/6.1: [e8c8e0d0d214c877fbad555df5b3ed558cd9b0c3]
stable/6.6: [e53a7f8afcbd2886f2a94c5d56757328109730ea]

CVE-2024-38388: ALSA: hda/cs_dsp_ctl: Use private_free for control cleanup

Announce: https://lore.kernel.org/linux-cve-announce/2024062137-CVE-2024-38388-fb75@gregkh/

Introduced by commit 3233b97 ("ALSA: hda: hda_cs_dsp_ctl: Add Library
to support CS_DSP ALSA controls") in v6.0-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [172811e3a557d8681a5e2d0f871dc04a2d17eb13]
stable/6.1: [191dc1b2ff0fb35e7aff15a53224837637df8bff]
stable/6.6: [6e359be4975006ff72818e79dad8fe48293f2eb2]

CVE-2024-38390: drm/msm/a6xx: Avoid a nullptr dereference when
speedbin setting fails

Announce: https://lore.kernel.org/linux-cve-announce/2024062138-CVE-2024-38390-395e@gregkh/

Introduced by commit 76efc24 ("drm/msm/gpu: Fix crash during system
suspend after unbind") in v6.1-rc3.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [46d4efcccc688cbacdd70a238bedca510acaa8e4]
stable/6.1: [247849eeb3fd88f8990ed73e33af70d5c10f9aec]
stable/6.6: [a1955a6df91355fef72a3a254700acd3cc1fec0d]

CVE-2024-38391: cxl/region: Fix cxlr_pmem leaks

Announce: https://lore.kernel.org/linux-cve-announce/2024062138-CVE-2024-38391-c792@gregkh/

Introduced by commit f17b558 ("cxl/pmem: Refactor nvdimm device
registration, delete the workqueue") in v6.2-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c987cf22d6b65ade46145c03eef13f0e3e81d83]
stable/6.6: [24b9362c9fa57f9291b380a3cc77b8b5c9fa27da]

CVE-2024-38621: media: stk1160: fix bounds checking in stk1160_copy_video()

Announce: https://lore.kernel.org/linux-cve-announce/2024062138-CVE-2024-38621-d52e@gregkh/

Introduced by commit 9cb2173 ("[media] media: Add stk1160 new driver
(easycap replacement)") in v3.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faa4364bef2ec0060de381ff028d1d836600a381]
stable/4.19: [f6a392266276730bea893b55d12940e32a25f56a]
stable/5.10: [a16775828aaed1c54ff4e6fe83e8e4d5c6a50cb7]
stable/5.15: [7532bcec0797adfa08791301c3bcae14141db3bd]
stable/5.4: [ecf4ddc3aee8ade504c4d36b7b4053ce6093e200]
stable/6.1: [b504518a397059e1d55c521ba0ea2b545a6c4b52]
stable/6.6: [d410017a7181cb55e4a5c810b32b75e4416c6808]

CVE-2024-38622: drm/msm/dpu: Add callback function pointer check before its call

Announce: https://lore.kernel.org/linux-cve-announce/2024062139-CVE-2024-38622-a164@gregkh/

Introduced by commit c929ac6 ("drm/msm/dpu: allow just single IRQ
callback") in v5.19-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [530f272053a5e72243a9cb07bb1296af6c346002]
stable/6.6: [873f67699114452c2a996c4e10faac8ff860c241]

CVE-2024-38623: fs/ntfs3: Use variable length array instead of fixed size

Announce: https://lore.kernel.org/linux-cve-announce/2024062139-CVE-2024-38623-7c77@gregkh/

Introduced by commit 4534a70 ("fs/ntfs3: Add headers and misc files")
in v5.15-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1997cdc3e727526aa5d84b32f7cbb3f56459b7ef]
stable/5.15: [a2de301d90b782ac5d7a5fe32995caaee9ab3a0f]
stable/6.1: [3839a9b19a4b70eff6b6ad70446f639f7fd5a3d7]
stable/6.6: [1fe1c9dc21ee52920629d2d9b9bd84358931a8d1]

CVE-2024-38624: fs/ntfs3: Use 64 bit variable to avoid 32 bit overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024062139-CVE-2024-38624-4711@gregkh/

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e931f6b630ffb22d66caab202a52aa8cbb10c649]
stable/5.15: [2d1ad595d15f36a925480199bf1d9ad72614210b]
stable/6.1: [98db3155b54d3684ef0ab5bfa0b856d13f65843d]
stable/6.6: [109d85a98345ee52d47c650405dc51bdd2bc7d40]

CVE-2024-38625: fs/ntfs3: Check 'folio' pointer for NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024062140-CVE-2024-38625-2694@gregkh/

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1cd6c96219c429ebcfa8e79a865277376c563803]
stable/6.6: [6c8054d590668629bb2eb6fb4cbf22455d08ada8]

CVE-2024-38626: fuse: clear FR_SENT when re-adding requests into pending list

Announce: https://lore.kernel.org/linux-cve-announce/2024062140-CVE-2024-38626-88ea@gregkh/

Introduced by commit 760eac7 ("fuse: Introduce a new notification type
for resend pending requests") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [246014876d782bbf2e652267482cd2e799fb5fcd]

CVE-2024-38627: stm class: Fix a double free in stm_register_device()

Announce: https://lore.kernel.org/linux-cve-announce/2024062140-CVE-2024-38627-9b57@gregkh/

Introduced by commit 389b669 ("stm class: Fix stm device
initialization order") in v4.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [3df463865ba42b8f88a590326f4c9ea17a1ce459]
stable/4.19: [6cc30ef8eb6d8f8d6df43152264bbf8835d99931]
stable/5.10: [713fc00c571dde4af3db2dbd5d1b0eadc327817b]
stable/5.15: [7419df1acffbcc90037f6b5a2823e81389659b36]
stable/5.4: [a0450d3f38e7c6c0a7c0afd4182976ee15573695]
stable/6.1: [4bfd48bb6e62512b9c392c5002c11e1e3b18d247]
stable/6.6: [370c480410f60b90ba3e96abe73ead21ec827b20]

CVE-2024-38628: usb: gadget: u_audio: Fix race condition use of
controls after free during gadget unbind.

Announce: https://lore.kernel.org/linux-cve-announce/2024062140-CVE-2024-38628-e2db@gregkh/

Introduced by commit 8fe9a03 ("usb: gadget: u_audio: Rate ctl notifies
about current srate (0=stopped)") in v5.18-rc1.
Introduced by commit c565ad0 ("usb: gadget: u_audio: Support multiple
sampling rates") in v5.18-rc1.
Introduced by commit 02de698 ("usb: gadget: u_audio: add
bi-directional volume and mute support") in v5.15-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b739388aa3f8dfb63a9fca777e6dfa6912d0464]
stable/6.1: [89e66809684485590ea0b32c3178e42cba36ac09]
stable/6.6: [453d3fa9266e53f85377b911c19b9a4563fa88c0]

CVE-2024-38629: dmaengine: idxd: Avoid unnecessary destruction of file_ida

Announce: https://lore.kernel.org/linux-cve-announce/2024062141-CVE-2024-38629-47c6@gregkh/

Introduced by commit e6fd6d7 ("dmaengine: idxd: add a device to
represent the file opened") in v6.4-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76e43fa6a456787bad31b8d0daeabda27351a480]
stable/6.6: [9eb15f24a0b9b017b39cde8b8c07243676b63687]

CVE-2024-38630: watchdog: cpu5wdt.c: Fix use-after-free bug caused by
cpu5wdt_trigger

Announce: https://lore.kernel.org/linux-cve-announce/2024062141-CVE-2024-38630-3640@gregkh/

Introduced by commit e09d9c3 ("watchdog: cpu5wdt.c: add missing
del_timer call") in v3.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [573601521277119f2e2ba5f28ae6e87fc594f4d4]
stable/6.6: [9b1c063ffc075abf56f63e55d70b9778ff534314]

CVE-2024-38631: iio: adc: PAC1934: fix accessing out of bounds array index

Announce: https://lore.kernel.org/linux-cve-announce/2024062141-CVE-2024-38631-9637@gregkh/

Introduced by commit 0fb528c ("iio: adc: adding support for PAC193x")
in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51fafb3cd7fcf4f4682693b4d2883e2a5bfffe33]

CVE-2024-38632: vfio/pci: fix potential memory leak in vfio_intx_enable()

Announce: https://lore.kernel.org/linux-cve-announce/2024062142-CVE-2024-38632-eaf6@gregkh/

Introduced by commit 18c198c ("vfio/pci: Create persistent INTx
handler") in v6.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [82b951e6fbd31d85ae7f4feb5f00ddd4c5d256e2]
stable/6.6: [0bd22a4966d55f1d2c127a53300d5c2b50152376]

CVE-2024-38633: serial: max3100: Update uart_driver_registered on driver removal

Announce: https://lore.kernel.org/linux-cve-announce/2024062142-CVE-2024-38633-06d4@gregkh/

Introduced by commit 7831d56 ("tty: MAX3100") in v2.6.30-rc2.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [712a1fcb38dc7cac6da63ee79a88708fbf9c45ec]
stable/4.19: [21a61a7fbcfdd3493cede43ebc7c4dfae2147a8b]
stable/5.10: [e8e2a4339decad7e59425b594a98613402652d72]
stable/5.15: [361a92c9038e8c8c3996f8eeaa14522a8ad90752]
stable/5.4: [9db4222ed8cd3e50b81c8b910ae74c26427a4003]
stable/6.1: [b6eb7aff23e05f362e8c9b560f6ac5e727b70e00]
stable/6.6: [e8a10089eddba40d4b2080c9d3fc2d2b2488f762]

CVE-2024-38634: serial: max3100: Lock port->lock when calling
uart_handle_cts_change()

Announce: https://lore.kernel.org/linux-cve-announce/2024062142-CVE-2024-38634-5591@gregkh/

Introduced by commit 7831d56 ("tty: MAX3100") in v2.6.30-rc2.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77ab53371a2066fdf9b895246505f5ef5a4b5d47]
stable/4.19: [44b38924135d2093e2ec1812969464845dd66dc9]
stable/5.10: [cc121e3722a0a2c8f716ef991e5425b180a5fb94]
stable/5.15: [78dbda51bb4241b88a52d71620f06231a341f9ba]
stable/5.4: [ea9b35372b58ac2931bfc1d5bc25e839d1221e30]
stable/6.1: [8296bb9e5925b6634259c5d4daee88f0cc0884ec]
stable/6.6: [93df2fba6c7dfa9a2f08546ea9a5ca4728758458]

CVE-2024-38635: soundwire: cadence: fix invalid PDI offset

Announce: https://lore.kernel.org/linux-cve-announce/2024062143-CVE-2024-38635-a3b1@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if this bug was introduced by commit 807c15b ("soundwire:
intel: don't filter out PDI0/1") in 5.5-rc1.
Bug introduced commit was backported to following branches.
stable/5.4

Fixed status
mainline: [8ee1b439b1540ae543149b15a2a61b9dff937d91]
stable/5.10: [fd4bcb991ebaf0d1813d81d9983cfa99f9ef5328]
stable/5.15: [902f6d656441a511ac25c6cffce74496db10a078]
stable/5.4: [002364b2d594a9afc0385c09e00994c510b1d089]
stable/6.1: [2ebcaa0e5db9b6044bb487ae1cf41bc601761567]
stable/6.6: [7eeef1e935d23db5265233d92395bd5c648a4021]

CVE-2024-38636: f2fs: multidev: fix to recognize valid zero block address

Announce: https://lore.kernel.org/linux-cve-announce/2024062143-CVE-2024-38636-8c1e@gregkh/

Introduced by commit 1517c1a ("f2fs: implement iomap operations") in v5.17-rc1.
Introduced by commit 8d3c1fa ("f2fs: don't rely on F2FS_MAP_* in
f2fs_iomap_begin") in v6.3-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [33e62cd7b4c281cd737c62e5d8c4f0e602a8c5c5]
stable/6.1: [1a9225fdd0ec95fcf32936bcea9ceef0cf1512dc]
stable/6.6: [2b2611a42462c6c685d40b5f3aedcd8d21c27065]

CVE-2024-38637: greybus: lights: check return of get_channel_from_mode

Announce: https://lore.kernel.org/linux-cve-announce/2024062143-CVE-2024-38637-e38e@gregkh/

Introduced by commit 2870b52 ("greybus: lights: add lights
implementation") in v4.9-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1ba19a1ae7cd1e324685ded4ab563e78fe68648]
stable/4.19: [8f4a76d477f0cc3c54d512f07f6f88c8e1c1e07b]
stable/5.10: [eac10cf3a97ffd4b4deb0a29f57c118225a42850]
stable/5.15: [330f6bcdcef03f70f81db5f2ed6747af656a09f2]
stable/5.4: [e2c64246e5dc8c0d35ec41770b85e2b4cafdff21]
stable/6.1: [9b41a9b9c8be8c552f10633453fdb509e83b66f8]
stable/6.6: [518e2c46b5dbce40b1aa0100001d03c3ceaa7d38]

CVE-2024-38659: enic: Validate length of nl attributes in enic_set_vf_port

Announce: https://lore.kernel.org/linux-cve-announce/2024062118-CVE-2024-38659-d373@gregkh/

Introduced by commit f8bd909 ("net: Add ndo_{set|get}_vf_port support
for enic dynamic vnics") in v2.6.35-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e8021b94b0412c37bcc79027c2e382086b6ce449]
stable/4.19: [2b649d7e0cb42a660f0260ef25fd55fdc9c6c600]
stable/5.10: [3c0d36972edbe56fcf98899622d9b90ac9965227]
stable/5.15: [25571a12fbc8a1283bd8380d461267956fd426f7]
stable/5.4: [ca63fb7af9d3e531aa25f7ae187bfc6c7166ec2d]
stable/6.1: [7077c22f84f41974a711604a42fd0e0684232ee5]
stable/6.6: [f6638e955ca00c489894789492776842e102af9c]

CVE-2024-38662: bpf: Allow delete from sockmap/sockhash only if update
is allowed

Announce: https://lore.kernel.org/linux-cve-announce/2024062117-CVE-2024-38662-8e3e@gregkh/

Introduced by commit ff91059 ("bpf, sockmap: Prevent lock inversion
deadlock in map delete elem") in v6.9-rc3.
Fixed in v6.10-rc2.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [98e948fb60d41447fd8d2d0c3b8637fc6b6dc26d]
stable/5.10: [29467edc23818dc5a33042ffb4920b49b090e63d]
stable/5.15: [11e8ecc5b86037fec43d07b1c162e233e131b1d9]
stable/6.1: [6693b172f008846811f48a099f33effc26068e1e]
stable/6.6: [000a65bf1dc04fb2b65e2abf116f0bc0fc2ee7b1]

CVE-2024-38780: dma-buf/sw-sync: don't enable IRQ from sync_print_obj()

Announce: https://lore.kernel.org/linux-cve-announce/2024062119-CVE-2024-38780-d90f@gregkh/

Introduced by commit a6aa8fc ("dma-buf/sw-sync: Reduce
irqsave/irqrestore from known context") in v4.14-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b794918961516f667b0c745aebdfebbb8a98df39]
stable/4.19: [1ff116f68560a25656933d5a18e7619cb6773d8a]
stable/5.10: [ae6fc4e6a3322f6d1c8ff59150d8469487a73dd8]
stable/5.15: [9d75fab2c14a25553a1664586ed122c316bd1878]
stable/5.4: [165b25e3ee9333f7b04f8db43895beacb51582ed]
stable/6.1: [242b30466879e6defa521573c27e12018276c33a]
stable/6.6: [a4ee78244445ab73af22bfc5a5fc543963b25aef]

CVE-2024-39277: dma-mapping: benchmark: handle NUMA_NO_NODE correctly

Announce: https://lore.kernel.org/linux-cve-announce/2024062119-CVE-2024-39277-11f7@gregkh/

Introduced by commit 65789da ("dma-mapping: add benchmark support for
streaming DMA APIs") in v5.11-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e64746e74f717961250a155e14c156616fcd981f]
stable/5.15: [b41b0018e8ca06e985e87220a618ec633988fd13]
stable/6.1: [8e1ba9df9a35e8dc64f657a64e523c79ba01e464]
stable/6.6: [5a91116b003175302f2e6ad94b76fb9b5a141a41]

CVE-2024-38663: blk-cgroup: fix list corruption from resetting io stat

Announce: https://lore.kernel.org/linux-cve-announce/2024062457-CVE-2024-38663-a1bc@gregkh/

Introduced by commit 3b8cc62 ("blk-cgroup: Optimize
blkcg_rstat_flush()") in v6.2-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6da6680632792709cecf2b006f2fe3ca7857e791]
stable/6.6: [d4a60298ac34f027a09f8f893fdbd9e06279bb24]

CVE-2024-38384: blk-cgroup: fix list corruption from reorder of WRITE ->lqueued

Announce: https://lore.kernel.org/linux-cve-announce/2024062455-CVE-2024-38384-47e5@gregkh/

Introduced by commit 3b8cc62 ("blk-cgroup: Optimize
blkcg_rstat_flush()") in v6.2-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d0aac2363549e12cc79b8e285f13d5a9f42fd08e]
stable/6.6: [714e59b5456e4d6e4295a9968c564abe193f461c]

CVE-2024-39292: um: Add winch to winch_handlers before registering winch IRQ

Announce: https://lore.kernel.org/linux-cve-announce/2024062432-CVE-2024-39292-e5c2@gregkh/

Introduced by commit 42a359e ("uml: SIGIO support cleanup") in v2.6.23-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a0fbbd36c156b9f7b2276871d499c9943dfe5101]
stable/4.19: [66ea9a7c6824821476914bed21a476cd20094f33]
stable/5.10: [351d1a64544944b44732f6a64ed65573b00b9e14]
stable/5.15: [31960d991e43c8d6dc07245f19fc13398e90ead2]
stable/5.4: [dc1ff95602ee908fcd7d8acee7a0dadb61b1a0c0]
stable/6.1: [0c02d425a2fbe52643a5859a779db0329e7dddd4]
stable/6.6: [434a06c38ee1217a8baa0dd7c37cc85d50138fb0]

CVE-2024-38664: drm: zynqmp_dpsub: Always register bridge

Announce: https://lore.kernel.org/linux-cve-announce/2024062457-CVE-2024-38664-a9e3@gregkh/

Introduced by commit eb2d64b ("drm: xlnx: zynqmp_dpsub: Report HPD
through the bridge") in v6.2-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be3f3042391d061cfca2bd22630e0d101acea5fc]
stable/6.6: [6ead3eccf67bc8318b1ce95ed879b2cc05b4fce9]

CVE-2024-33847: f2fs: compress: don't allow unaligned truncation on
released compress inode

Announce: https://lore.kernel.org/linux-cve-announce/2024062458-CVE-2024-33847-6abc@gregkh/

Introduced by commit c614041 ("f2fs: introduce FI_COMPRESS_RELEASED
instead of using IMMUTABLE bit") in v5.14-rc1.
Fixed in v6.9.4.
Bug introduced commit was backported to following branches.
stable/5.10

Fixed status
mainline: [5268241b41b1c5d0acca75e9b97d4fd719251c8c]
stable/5.10: [b8962cf98595d1ec62f40f23667de830567ec8bc]
stable/5.15: [b8962cf98595d1ec62f40f23667de830567ec8bc]
stable/6.1: [8acae047215024d1ac499b3c8337ef1b952f160b]
stable/6.6: [3ccf5210dc941a7aa0180596ac021568be4d35ec]

CVE-2024-35247: fpga: region: add owner module and take its refcount

Announce: https://lore.kernel.org/linux-cve-announce/2024062459-CVE-2024-35247-713a@gregkh/

Introduced by commit 0fa20cd ("fpga: fpga-region: device tree control
for FPGA") in v4.10-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7c0e1ecee403a43abc89eb3e75672b01ff2ece9]
stable/5.10: [26e6e25d742e29885cf44274fcf6b744366c4702]
stable/5.15: [9b4eee8572dcf82b2ed17d9a328c7fb87df2f0e8]
stable/6.1: [75a001914a8d2ccdcbe4b8cc7e94ac71d0e66093]
stable/6.6: [4d7d12b643c00e7eea51b49a60a2ead182633ec8]

CVE-2024-36479: fpga: bridge: add owner module and take its refcount

Announce: https://lore.kernel.org/linux-cve-announce/2024062459-CVE-2024-36479-ef6c@gregkh/

Introduced by commit 21aeda9 ("fpga: add fpga bridge framework") in v4.10-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1da11f822042eb6ef4b6064dc048f157a7852529]
stable/6.6: [d7c4081c54a1d4068de9440957303a76f9e5c95b]

CVE-2024-37021: fpga: manager: add owner module and take its refcount

Announce: https://lore.kernel.org/linux-cve-announce/2024062459-CVE-2024-37021-13d4@gregkh/

Introduced by commit 654ba4c ("fpga manager: ensure lifetime with
of_fpga_mgr_get") in v4.4-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d4d2d4346857bf778fafaa97d6f76bb1663e3c9]
stable/6.6: [2da62a139a6221a345db4eb9f4f1c4b0937c89ad]

CVE-2024-37026: drm/xe: Only use reserved BCS instances for usm
migrate exec queue

Announce: https://lore.kernel.org/linux-cve-announce/2024062400-CVE-2024-37026-1d57@gregkh/

Introduced by commit a043fba ("drm/xe/pvc: Use fast copy engines as
migrate engine on PVC") in v6.8-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8ea2c31f5ea437199b239d76ad5db27343edb0c]

CVE-2024-34030: PCI: of_property: Return error for int_map allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024062458-CVE-2024-34030-48f1@gregkh/

Introduced by commit 407d1a5 ("PCI: Create device tree node for
bridge") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6f7d27df5d208b50cae817a91d128fb434bb12c]
stable/6.6: [b5f31d1470c4fdfae368feeb389768ba8d24fb34]

CVE-2024-32936: media: ti: j721e-csi2rx: Fix races while restarting DMA

Announce: https://lore.kernel.org/linux-cve-announce/2024062458-CVE-2024-32936-b157@gregkh/

Introduced by commit b4a3d87 ("media: ti: Add CSI2RX support for
J721E") in v6.7-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ad79c9ecea5baa7b4f19677e4b1c881ed89b0c3b]

CVE-2024-38667: riscv: prevent pt_regs corruption for secondary idle threads

Announce: https://lore.kernel.org/linux-cve-announce/2024062431-CVE-2024-38667-83a6@gregkh/

Introduced by commit 9a2451f ("RISC-V: Avoid using per cpu array for
ordered booting") in v5.17-rc1.
Introduced by commit 2875fe0 ("RISC-V: Add cpu_ops and modify default
booting method") in v5.7-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a638b0461b58aa3205cd9d5f14d6f703d795b4af]
stable/6.1: [ea22d4195cca13d5fdbc4d6555a2dfb8a7867a9e]
stable/6.6: [3090c06d50eaa91317f84bf3eac4c265e6cb8d44]

CVE-2024-39291: drm/amdgpu: Fix buffer size in gfx_v9_4_3_init_
cp_compute_microcode() and rlc_microcode()

Announce: https://lore.kernel.org/linux-cve-announce/2024062432-CVE-2024-39291-be2c@gregkh/

Introduced by commit 8630112 ("drm/amdgpu: split gc v9_4_3
functionality from gc v9_0") in v6.5-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [acce6479e30f73ab0872e93a75aed1fb791d04ec]
stable/6.6: [19bd9537b6bc1c882df25206c15917214d8e9460]

CVE-2024-34027: f2fs: compress: fix to cover
{reserve,release}_compress_blocks() w/ cp_rwsem lock

Announce: https://lore.kernel.org/linux-cve-announce/2024062458-CVE-2024-34027-b9ea@gregkh/

Introduced by commit ef8d563 ("f2fs: introduce
F2FS_IOC_RELEASE_COMPRESS_BLOCKS") in v5.8-rc1.
Introduced by commit c75488f ("f2fs: introduce
F2FS_IOC_RESERVE_COMPRESS_BLOCKS") in v5.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a4ed2d97cb6d044196cc3e726b6699222b41019]
stable/5.10: [a6e1f7744e9b84f86a629a76024bba8468aa153b]
stable/5.15: [b5bac43875aa27ec032dbbb86173baae6dce6182]
stable/6.1: [5d47d63883735718825ca2efc4fca6915469774f]
stable/6.6: [329edb7c9e3b6ca27e6ca67ab1cdda1740fb3a2b]

CVE-2021-4440: x86/xen: Drop USERGS_SYSRET64 paravirt call

Announce: https://lore.kernel.org/linux-cve-announce/2024062506-CVE-2021-4440-f8f1@gregkh/

5.10 is only vulnerable.
Introduced by commit cea750c9 ("x86/head/64: Re-enable stack
protection") in 5.10.y.

Fixed status
stable/5.10: [1424ab4bb386df9cc590c73afa55f13e9b00dea2]

CVE-2022-48772: media: lgdt3306a: Add a check against null-pointer-def

Announce: https://lore.kernel.org/linux-cve-announce/2024062546-CVE-2022-48772-8cbe@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It looks as if this bug was introduced by commit 2c4746cf ("media:
dvb-frontends:
Use kmemdup instead of duplicating its function") in 5.0-rc1.

Fixed status
mainline: [c1115ddbda9c930fba0fdd062e7a8873ebaf898d]
stable/5.10: [b479fd59a1f4a342b69fce34f222d93bf791dca4]
stable/5.15: [526238d32c3acc3d597fd8c9a34652bfe9086cea]
stable/5.4: [8915dcd29a82096acacf54364a8425363782aea0]
stable/6.1: [d082757b8359201c3864323cea4b91ea30a1e676]
stable/6.6: [7d12e918f2994c883f41f22552a61b9310fa1e87]

CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of
writeback flag waiting

Announce: https://lore.kernel.org/linux-cve-announce/2024062547-CVE-2024-37078-3aaa@gregkh/

Introduced by commit 9ff0512 ("nilfs2: segment constructor") in v2.6.30-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4ca369ca221bb7e06c725792ac107f0e48e82e7]
stable/6.1: [271dcd977ccda8c7a26e360425ae7b4db7d2ecc0]
stable/6.6: [614d397be0cf43412b3f94a0f6460eddced8ce92]

CVE-2024-37354: btrfs: fix crash on racing fsync and size-extending
write into prealloc

Announce: https://lore.kernel.org/linux-cve-announce/2024062547-CVE-2024-37354-ccfb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc3.

Fixed status
mainline: [9d274c19a71b3a276949933859610721a453946b]
stable/6.1: [1ff2bd566fbcefcb892be85c493bdb92b911c428]
stable/6.6: [3d08c52ba1887a1ff9c179d4b6a18b427bcb2097]

CVE-2024-38306: btrfs: protect folio::private when attaching extent
buffer folios

Announce: https://lore.kernel.org/linux-cve-announce/2024062547-CVE-2024-38306-c570@gregkh/

Introduced by commit 09e6cef ("btrfs: refactor alloc_extent_buffer()
to allocate-then-attach method") in v6.8-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f3a5367c679d31473d3fbb391675055b4792c309]

CVE-2024-38385: genirq/irqdesc: Prevent use-after-free in irq_find_at_or_after()

Announce: https://lore.kernel.org/linux-cve-announce/2024062548-CVE-2024-38385-4b3a@gregkh/

Introduced by commit 721255b ("genirq: Use a maple tree for interrupt
descriptor management") in v6.5-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b84a8aba806261d2f759ccedf4a2a6a80a5e55ba]
stable/6.6: [1c7891812d85500ae2ca4051fa5683fcf29930d8]

CVE-2024-38661: s390/ap: Fix crash in AP internal function modify_bitmap()

Announce: https://lore.kernel.org/linux-cve-announce/2024062548-CVE-2024-38661-44a9@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [d4f9d5a99a3fd1b1c691b7a1a6f8f3f25f4116c9]
stable/4.19: [2062e3f1f2374102f8014d7ca286b9aa527bd558]
stable/5.10: [7360cef95aa1ea2b5efb7b5e2ed32e941664e1f0]
stable/5.15: [67011123453b91ec03671d40712fa213e94a01b9]
stable/5.4: [7c72af16abf2ec7520407098360bbba312289e05]
stable/6.1: [8c5f5911c1b13170d3404eb992c6a0deaa8d81ad]
stable/6.6: [4c0bfb4e867c1ec6616a5049bd3618021e127056]

CVE-2024-39276: ext4: fix mb_cache_entry's e_refcnt leak in
ext4_xattr_block_cache_find()

Announce: https://lore.kernel.org/linux-cve-announce/2024062548-CVE-2024-39276-5205@gregkh/

Introduced by commit fb265c9 ("ext4: add ext4_sb_bread() to
disambiguate ENOMEM cases") in v5.0-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [0c0b4a49d3e7f49690a6827a41faeffad5df7e21]
stable/4.19: [9ad75e78747b5a50dc5a52f0f8e92e920a653f16]
stable/5.10: [76dc776153a47372719d664e0fc50d6355791abb]
stable/5.15: [681ff9a09accd8a4379f8bd30b7a1641ee19bb3e]
stable/5.4: [896a7e7d0d555ad8b2b46af0c2fa7de7467f9483]
stable/6.1: [e941b712e758f615d311946bf98216e79145ccd9]
stable/6.6: [a95df6f04f2c37291adf26a74205cde0314d4577]

CVE-2024-39293: Revert "xsk: Support redirect to any socket bound to
the same umem"

Announce: https://lore.kernel.org/linux-cve-announce/2024062548-CVE-2024-39293-d42a@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc3.
This fix reverts commit 2863d665 ("xsk: support redirect to any
socket bound to the same umem") in 6.9-rc1.

Fixed status
mainline: [7fcf26b315bbb728036da0862de6b335da83dff2]

CVE-2024-39296: bonding: fix oops during rmmod

Announce: https://lore.kernel.org/linux-cve-announce/2024062549-CVE-2024-39296-3976@gregkh/

Introduced by commit cc317ea ("bonding: remove redundant NULL check in
debugfs function") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a45835a0bb6ef7d5ddbc0714dd760de979cb6ece]
stable/6.6: [f07224c16678a8af54ddc059b3d2d51885d7f35e]

CVE-2024-39298: mm/memory-failure: fix handling of dissolved but not
taken off from buddy pages

Announce: https://lore.kernel.org/linux-cve-announce/2024062549-CVE-2024-39298-53e8@gregkh/

Introduced by commit ceaf8fb ("mm, hwpoison: skip raw hwpoison page in
freeing 1GB hugepage") in v6.0-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cf360b9d6a840700e06864236a01a883b34bbad]
stable/6.1: [00b0752c7f15dfdf129cacc6a27d61c54141182b]
stable/6.6: [bb9bb13ce64cc7cae47f5e2ab9ce93b7bfa0117e]

CVE-2024-39301: net/9p: fix uninit-value in p9_client_rpc()

Announce: https://lore.kernel.org/linux-cve-announce/2024062549-CVE-2024-39301-6610@gregkh/

Introduced by commit 348b590 ("net/9p: Convert net/9p protocol dumps
to tracepoints") in v3.2-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25460d6f39024cc3b8241b14c7ccf0d6f11a736a]
stable/4.19: [72c5d8e416ecc46af370a1340b3db5ff0b0cc867]
stable/5.10: [124947855564572713d705a13be7d0c9dae16a17]
stable/5.15: [89969ffbeb948ffc159d19252e7469490103011b]
stable/5.4: [2101901dd58c6da4924bc5efb217a1d83436290b]
stable/6.1: [ca71f204711ad24113e8b344dc5bb8b0385f5672]
stable/6.6: [6c1791130b781c843572fb6391c4a4c5d857ab17]

CVE-2024-39362: i2c: acpi: Unbind mux adapters before delete

Announce: https://lore.kernel.org/linux-cve-announce/2024062550-CVE-2024-39362-2d27@gregkh/

Introduced by commit 525e6fa ("i2c / ACPI: add support for ACPI
reconfigure notifications") in v4.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f858bbf04dbac934ac279aaee05d49eb9910051]
stable/6.1: [b1574c8c0a80bd587a7651bf64f00be1f5391d27]
stable/6.6: [90dd0592b3b005d6f15c4e23e1364d3ae95e588d]

CVE-2024-39371: io_uring: check for non-NULL file pointer in io_file_can_poll()

Announce: https://lore.kernel.org/linux-cve-announce/2024062550-CVE-2024-39371-42fb@gregkh/

Introduced by commit a76c0b3 ("io_uring: commit non-pollable provided
mapped buffers upfront") in v5.19-rc3.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5fc16fa5f13b3c06fdb959ef262050bd810416a2]
stable/6.1: [c2844d5e58576c55d8e8d4a9f74902d3f7be8044]
stable/6.6: [43cfac7b88adedfb26c27834386992650f1642f3]

CVE-2024-39461: clk: bcm: rpi: Assign ->num before accessing ->hws

Announce: https://lore.kernel.org/linux-cve-announce/2024062512-CVE-2024-39461-cdbc@gregkh/

Introduced by commit f316cdf ("clk: Annotate struct
clk_hw_onecell_data with __counted_by") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6dc445c1905096b2ed4db1a84570375b4e00cc0f]
stable/6.6: [9562dbe5cdbb16ac887d27ef6f179980bb99193c]

CVE-2024-39462: clk: bcm: dvp: Assign ->num before accessing ->hws

Announce: https://lore.kernel.org/linux-cve-announce/2024062513-CVE-2024-39462-f5ec@gregkh/

Introduced by commit f316cdf ("clk: Annotate struct
clk_hw_onecell_data with __counted_by") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9368cdf90f52a68120d039887ccff74ff33b4444]
stable/6.6: [0dc913217fb79096597005bba9ba738e2db5cd02]

CVE-2024-39463: 9p: add missing locking around taking dentry fid list

Announce: https://lore.kernel.org/linux-cve-announce/2024062513-CVE-2024-39463-42c8@gregkh/

Introduced by commit 154372e ("fs/9p: fix create-unlink-getattr
idiom") in v5.11-rc1.
Fixed in v6.10-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c898afdc15645efb555acb6d85b484eb40a45409]
stable/6.1: [cb299cdba09f46f090b843d78ba26b667d50a456]
stable/6.6: [f0c5c944c6d8614c19e6e9a97fd2011dcd30e8f5]

CVE-2024-39464: media: v4l: async: Fix notifier list entry init

Announce: https://lore.kernel.org/linux-cve-announce/2024062513-CVE-2024-39464-6214@gregkh/

Introduced by commit b8ec754 ("media: v4l: async: Set v4l2_device and
subdev in async notifier init") in v6.6-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d8acd02c4c6a8f917eefac1de2e035521ca119d]
stable/6.6: [a80d1da923f671c1e6a14e8417cd2f117b27a442]

CVE-2024-39465: media: mgb4: Fix double debugfs remove

Announce: https://lore.kernel.org/linux-cve-announce/2024062513-CVE-2024-39465-f827@gregkh/

Introduced by commit 0ab1367 ("media: pci: mgb4: Added Digiteq
Automotive MGB4 driver") in v6.7-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [825fc49497957310e421454fe3fb8b8d8d8e2dd2]

CVE-2024-39466: thermal/drivers/qcom/lmh: Check for SCM availability at probe

Announce: https://lore.kernel.org/linux-cve-announce/2024062514-CVE-2024-39466-3da4@gregkh/

Introduced by commit 53bca37 ("thermal/drivers/qcom: Add support for
LMh driver") in v5.15-rc1.
Fixed in v6.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d9d3490c48df572edefc0b64655259eefdcbb9be]
stable/5.15: [2226b145afa5e13cb60dbe77fb20fb0666a1caf3]
stable/6.1: [560d69c975072974c11434ca6953891e74c1a665]
stable/6.6: [0a47ba94ec3d8f782b33e3d970cfcb769b962464]

CVE-2024-39467: f2fs: fix to do sanity check on i_xattr_nid in
sanity_check_inode()

Announce: https://lore.kernel.org/linux-cve-announce/2024062514-CVE-2024-39467-b07d@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.

Fixed status
mainline: [20faaf30e55522bba2b56d9c46689233205d7717]
stable/5.10: [75c87e2ac6149abf44bdde0dd6d541763ddb0dff]
stable/5.15: [1640dcf383cdba52be8b28d2a1a2aa7ef7a30c98]
stable/5.4: [c559a8d840562fbfce9f318448dda2f7d3e6d8e8]
stable/6.1: [8c8aa473fe6eb46a4bf99f3ea2dbe52bf0c1a1f0]
stable/6.6: [be0155202e431f3007778568a72432c68f8946ba]

CVE-2024-39468: smb: client: fix deadlock in smb2_find_smb_tcon()

Announce: https://lore.kernel.org/linux-cve-announce/2024062500-CVE-2024-39468-11d2@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc3.
It seems as if it was introduced by commit e695a9ad ("cifs:
missed ref-counting smb session in find") in 5.14-rc1.

Fixed status
mainline: [02c418774f76a0a36a6195c9dbf8971eb4130a15]
stable/6.1: [b09b556e48968317887a11243a5331a7bc00ece5]
stable/6.6: [225de871ddf994f69a57f035709cad9c0ab8615a]

CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long
loop on I/O errors

Announce: https://lore.kernel.org/linux-cve-announce/2024062500-CVE-2024-39469-a1be@gregkh/

Introduced by commit 2ba466d ("nilfs2: directory entry operations") in
v2.6.30-rc1.
Fixed in v6.10-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7373a51e7998b508af7136530f3a997b286ce81c]
stable/6.1: [129dcd3e7d036218db3f59c82d82004b9539ed82]
stable/6.6: [d18b05eda7fa77f02114f15b02c009f28ee42346]

CVE-2024-39470: eventfs: Fix a possible null pointer dereference in
eventfs_find_events()

Announce: https://lore.kernel.org/linux-cve-announce/2024062500-CVE-2024-39470-5b25@gregkh/

Introduced by commit 8186fff ("tracefs/eventfs: Use root and instance
inodes as default ownership") in v6.8-rc1.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [d4e9a968738bf66d3bb852dd5588d4c7afd6d7f4]
stable/6.6: [5ade5fbdbbb1f023bb70730ba4d74146c8bc7eb9]

CVE-2024-39471: drm/amdgpu: add error handle to avoid out-of-bounds

Announce: https://lore.kernel.org/linux-cve-announce/2024062501-CVE-2024-39471-3dee@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.10-rc1.
It seems as if it was introduced by commit 667a482 ("drm/amdgpu: reorganize
sdma v4 code to support more instances") in 5.4-rc1.

Fixed status
mainline: [8b2faf1a4f3b6c748c0da36cda865a226534d520]
stable/5.10: [8112fa72b7f139052843ff484130d6f97e9f052f]
stable/5.15: [ea906e9ac61e3152bef63597f2d9f4a812fc346a]
stable/5.4: [5594971e02764aa1c8210ffb838cb4e7897716e8]
stable/6.1: [011552f29f20842c9a7a21bffe1f6a2d6457ba46]
stable/6.6: [5b0a3dc3e87821acb80e841b464d335aff242691]


* Updated CVEs

CVE-2021-38202: NFSD: Prevent a possible oops in the nfs_dirent() tracepoint

stable 5.10 was fixed.

Fixed status
mainline: [7b08cf62b1239a4322427d677ea9363f0ab677c6]
stable/5.10: [5610ed80e86022e13733715a381db75f724392e2]
stable/5.13: [7605bff387a9972038b217b6c60998778dbae931]

CVE-2021-4090: kernel: Overflow of bmval[bmlen-1] in
nfsd4_decode_bitmap function

stable 5.10 was fixed.

Fixed status
mainline: [c0019b7db1d7ac62c711cda6b357a659d46428fe]
stable/5.10: [1abf3ec5587741cbc248c756a1b1bf933ad79506]
stable/5.15: [10c22d9519f3f5939de61a1500aa3a926b778d3a]

CVE-2021-47107: NFSD: Fix READDIR buffer overflow

stable 5.10 was fixed.

Fixed status
mainline: [f5dcccd647da513a89f3b6ca392b0c1eb050b9fc,
7f87fc2d34d475225e78b7f5c4eabb121f4282b2]
stable/5.10: [b8658c947d540cf5d135176354da5c8f2811efa0,
37aa5e64022243e721b8334122997881177a4cfc]

CVE-2021-47316: nfsd: fix NULL dereference in nfs3svc_encode_getaclres

stable 5.10 was fixed.

Fixed status
mainline: [ab1016d39cc052064e32f25ad18ef8767a0ee3b8]
stable/5.10: [e79057d15d96ef19de4de6d7e479bae3d58a2a8d]

CVE-2022-43945: A buffer overflow bug was found in nfsd

stable 5.10 was fixed.

Fixed status
mainline: [00b4492686e0497fdb924a9d4c8f6f99377e176c,
640f87c190e0d1b2a0fcb2ecf6d2cd53b1c41991,
  401bc1f90874280a80b93f23be33a0e7e2d1f912,
fa6be9cc6e80ec79892ddf08a8c10cabab9baf38]
stable/5.10: [0e57d696f60dee6117a8ace0cac7c5761d375277,
57774b1526163766403167b7bf00b136fb103761,
  2007867c5874134f2271eb276398208070049dd3,
c23687911f82a63fa2977ce9c992b395e90f8ba0]
stable/5.15: [dc7f225090c29a5f3b9419b1af32846a201555e7,
071a076fd1b763aa6fe478efa047e0a549ba9c22,
  2be9331ca6061bc6ea32247266f45b8b21030244,
75d9de25a6f833dd0701ca546ac926cabff2b5af]
stable/6.0: [f59c74df82f6ac9d2ea4e01aa3ae7c6c4481652d,
279274e31270c28b86feffe5e166d4088f22317b,
  1868332032eccbab8c1878a0d918193058c0a905,
309f29361b6bfae96936317376f1114568c5de19]

CVE-2023-1652: NFSD: fix use-after-free in nfsd4_ssc_setup_dul()

stable 5.10 was fixed.

Fixed status
mainline: [e6cf91b7b47ff82b624bdfe2fdcde32bb52e71dd]
stable/5.10: [6ac4c383c39f8f2f955f868d1ad9365c2363e80b]
stable/5.15: [0a27dcd5343026ac0cb168ee63304255372b7a36]
stable/6.1: [32d5eb95f8f0e362e37c393310b13b9e95404560]

CVE-2024-26629: nfsd: fix RELEASE_LOCKOWNER

stable 5.10 was fixed.

Fixed status
mainline: [edcf9725150e42beeca42d085149f4c88fa97afd]
stable/5.10: [99fb654d01dc3f08b5905c663ad6c89a9d83302f]
stable/5.15: [c6f8b3fcc62725e4129f2c0fd550d022d4a7685a]
stable/6.1: [e4cf8941664cae2f89f0189c29fe2ce8c6be0d03]
stable/6.6: [b7d2eee1f53899b53f069bba3a59a419fc3d331b]
stable/6.7: [8f5b860de87039b007e84a28a5eefc888154e098]

CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and
AIO request complete

stable 6.1 was fixed.

Fixed status
mainline: [24729b307eefcd7c476065cd7351c1a018082c19]
stable/6.1: [a0fdccb1c9e027e3195f947f61aa87d6d0d2ea14]
stable/6.6: [73c05ad46bb4fbbdb346004651576d1c8dbcffbb]

CVE-2024-36973: misc: microchip: pci1xxxx: fix double free in the
error handling of gp_aux_bus_probe()

stable 6.1, 6.6, and 6.9 were fixed.

Fixed status
mainline: [086c6cbcc563c81d55257f9b27e14faf1d0963d3]
stable/6.1: [34ae447b138680b5ed3660f7d935ff3faf88ba1a]
stable/6.6: [86c9713602f786f441630c4ee02891987f8618b9]
stable/6.9: [1efe551982297924d05a367aa2b6ec3d275d5742]

CVE-2024-36974: net/sched: taprio: always validate TCA_TAPRIO_ATTR_PRIOMAP

stable 6.1, 6.6, and 6.9 were fixed.

Fixed status
mainline: [f921a58ae20852d188f70842431ce6519c4fdc36]
stable/6.1: [0bf6cc96612bd396048f57d63f1ad454a846e39c]
stable/6.6: [724050ae4b76e4fae05a923cb54101d792cf4404]
stable/6.9: [c37a27a35eadb59286c9092c49c241270c802ae2]

CVE-2024-36978: net: sched: sch_multiq: fix possible OOB write in multiq_tune()

stable 6.1, 6.6, and 6.9 were fixed.

Fixed status
mainline: [affc18fdc694190ca7575b9a86632a73b9fe043d]
stable/6.1: [0f208fad86631e005754606c3ec80c0d44a11882]
stable/6.6: [54c2c171c11a798fe887b3ff72922aa9d1411c1e]
stable/6.9: [d6fb5110e8722bc00748f22caeb650fe4672f129]

CVE-2024-38619: usb-storage: alauda: Check whether the media is initialized

stable 6.1, 6.6, and 6.9 were fixed.

Fixed status
mainline: [16637fea001ab3c8df528a8995b3211906165a30]
stable/6.1: [e0e2eec76920a133dd49a4fbe4656d83596a1361]
stable/6.6: [2cc32639ec347e3365075b130f9953ef16cb13f1]
stable/6.9: [24bff7f714bdff97c2a75a0ff6a368cdf8ad5af4]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

