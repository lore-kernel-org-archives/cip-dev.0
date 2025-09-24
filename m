Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE80DCAC5AE
	for <webhook@archiver.kernel.org>; Wed, 24 Sep 2025 22:50:51 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.web11.27935.1758754243662220766
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Sep 2025 15:50:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=dO0etTvT;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d60110772so3393097b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 24 Sep 2025 15:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1758754243; x=1759359043; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L8/rXVlL39eIuoFBU99Ft6EeRMm6KyByHcw99PNjN0k=;
        b=dO0etTvT2I0QurPG5yb2s6oWIypeAkAc+wYiohxvI2KlPtVwW9HQoAV6hIh/LgHtum
         /etp/KfmQCfldENlxeSQ7eQ68mMa1sVdyhST8vehPWD1jlmYl+IG98qWhk1voxfXvw0t
         3OJsZgYfd7FnPLTDFFg/bCcbU9GOo+JRoY1hVP4tgZVoLN5jh+5XQDtdwgH3t4Je3kry
         RZMWATF0GWGcUGGQwHBq/QNj+FBJA6pXZrCjq+VXd016XfjeCRrLAyWTqCna2gDKaA5U
         9RepbNVwxzt+vni4UJgAXNNdsBD+lCtsKFPCYn2VDxs1tvDiwm6v7ToIbojkttQ9h6qq
         cDCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758754243; x=1759359043;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8/rXVlL39eIuoFBU99Ft6EeRMm6KyByHcw99PNjN0k=;
        b=s1OIOa6tkTWzWCOtAl8MtOqcSvQieBGWoeo0dkUJ8Jo9VLWnZc0kiKySUPlQSJx5Kf
         OzFfoI81x60Xy08CzflqPGCfBv/LHDTxW6azr3/jVFnBr0+0wmeaUZW2I0Pj5MDMe4ZB
         4iyk3cozaDHDbygLL1kIfqJrGG17V25Ckzt24nU1+vs0io9vM+xkiMVkQDMZSFGgED5S
         BBA4GIEYh8hGKPrdN0Kl6xfLlu56Y1DDroMo3FzMn496+pbB16vv0/f7CvRQ6xZS7Apj
         AlNGBlMMndU5j4cqQPDdfMHyBmaQNfwYusHEAmUGc2bNK0wukjdPRUaYxQJSKiiF7U/A
         56Ag==
X-Gm-Message-State: AOJu0YyBOCvkJwVz3T2MkhuA5SdkmMMV2Wg1ldOQUbKqgXw3+8JcT2YA
	rQOC9c02hl0Lw6vpsvgk02Vy1uWUZFUYy3QK07RytiVm1X3NBzcRDj0GxcfQ8p0HlPx8b97imga
	RJpjRFXVNp4wT+j/VD8wOGUoPnfbO37leafrJa0ZKCK4rcPLJPGO019c=
X-Gm-Gg: ASbGncuhrZqPWke+2FRUCKpzZvgKPvt9v4Jqo35lNhqzL0eIIczZbz8UjFEHTRIPHuU
	Wqf6ttBDv8fgpaX92CFSBm2VaDnyng/k/21lJIhX2Vvkcqr+4mhCVnxTXgLs9+L7y3cXvX1lXUA
	QUGqeSmR9HIXPqH6zZRCCBCSOwQENpt9sFZ/4A/A9ZMcavmQfwynqvktOy3/RVcDF2NysQEfV7o
	JYObZhd
X-Google-Smtp-Source: AGHT+IHckZsVAYJmqgrrG1C4zYrZydv+hyqmbkElRhkS6oD6VOhFsSvK73XQH6CvssVa9v3MXlq9N3gbqrONu+evTy8=
X-Received: by 2002:a05:690c:7010:b0:762:9a58:b334 with SMTP id
 00721157ae682-7640500ffbdmr14563117b3.42.1758754240594; Wed, 24 Sep 2025
 15:50:40 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 25 Sep 2025 07:50:03 +0900
X-Gm-Features: AS18NWB-f8HxMe0Ip98sY1wGa1Ll0COzQ-Ux9B8XcAuuSpUGCsIJdf_Er13_awo
Message-ID: <CAODzB9pOtzqJNumqgAsefkwf_4sJMvJEg+BFvCsE8kpSUsJFSg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Sep 2025 22:50:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20120

Hi!

It's this week's CVE report.

This week reported 179 new CVEs and 3 updated CVEs.

* New CVEs
CVE-2022-50375: tty: serial: fsl_lpuart: disable dma rx/tx use flags
in lpuart_dma_shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50375

Introduced by commit 6250cc3 ("tty: serial: fsl_lpuart: Use
scatter/gather DMA for Tx") in v4.9-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [316ae95c175a7d770d1bfe4c011192712f57aa4a]
stable/5.10: [9a56ade124d4891a31ab1300c57665f07f5b24d5]
stable/5.15: [c4293def8860fd587a84400ccba5b49cec56e2c3]
stable/5.4: [29b897ac7b990882c74bd08605692214e7e58b83]
stable/6.1: [316ae95c175a7d770d1bfe4c011192712f57aa4a]

CVE-2022-50376: orangefs: Fix kmemleak in orangefs_{kernel,client}_debug_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50376

Introduced commit is not determined.Fixed in v6.2-rc1.
The orangefs_client_debug_init(previous name was
pvfs2_client_debug_init) was introduced by 274dcf5 ("Orangefs: kernel
client part 3") in4.6-rc1. The orangefs_kernel_debug_init was
introduced by 44f4641 ("orangefs: clean up debugfs globals") in
4.9-rc1.

Fixed status
mainline: [31720a2b109b3080eb77e97b8f6f50a27b4ae599]
stable/5.10: [a076490b0211990ec6764328c22cb744dd782bd9]
stable/5.15: [c8853267289c55b1acbe4dc3641374887584834d]
stable/5.4: [bdc2d33fa2324b1f5ab5b701cda45ee0b2384409]
stable/6.1: [0cd303aad220fafa595e0ed593e99aa51b90412b]

CVE-2022-50377: [REJECTED]: ext4: check and assert if marking an
no_delete evicting inode dirty

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50377

This CVE was rejected. Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
mainline: [318cdc822c63b6e2befcfdc2088378ae6fa18def]
stable/5.10: [9020f56a3cad1c97b81c7dab2aa67027b59c8f73]
stable/5.15: [91009e361e8cb2cbd1dc9496cb5fb4f8de3f4b11]
stable/6.1: [f1ec687ebd1bf146333955b7e209d21508c3ba9f]

CVE-2022-50378: drm/meson: reorder driver deinit sequence to fix
use-after-free bug

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50378

Introduced commit is not determined.Fixed in v6.1-rc1.
Calling the component_unbind_all was added by e78ad18b ("drm/meson:
Unbind all connectors on module removal") in 5.11-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [31c519981eb141c7ec39bfd5be25d35f02edb868]
stable/5.15: [d76ff04a72f90767455059c8239b06042cd0ed23]
stable/6.1: [31c519981eb141c7ec39bfd5be25d35f02edb868]

CVE-2022-50379: btrfs: fix race between quota enable and quota rescan ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50379

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [c97f6d528c3f1c83a6b792a8a7928c236c80b8fe]
mainline: [331cd9461412e103d07595a10289de90004ac890]
stable/5.10: [47b5ffe86332af95f0f52be0a63d4da7c2b37b55]
stable/5.15: [4b996a3014ef014af8f97b60c35f5289210a4720]
stable/5.4: [26b7c0ac49a3eea15559c9d84863736a6d1164b4]
stable/6.1: [331cd9461412e103d07595a10289de90004ac890]

CVE-2022-50380: mm: /proc/pid/smaps_rollup: fix no vma's null-deref

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50380


According to the mailing list, mainline was fixed by c4c84f0
("fs/proc/task_mmu: stop using linked list and highest_vm_end") in
6.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4c84f06285e48f80e9843d0775ad92714ffc35a]
stable/4.19: [dbe863bce7679c7f5ec0e993d834fe16c5e687b5]
stable/5.10: [a50ed2d28727ff605d95fb9a53be8ff94e8eaaf4]
stable/5.15: [33fc9e26b7cb39f0d4219c875a2451802249c225]

CVE-2022-50381: md: fix a crash in mempool_free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50381

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [b5be563b4356b3089b3245d024cae3f248ba7090]
cip/4.4-st: [779785788a82fdec73367d87410228ba454f2819]
mainline: [341097ee53573e06ab9fc675d96a052385b851fa]
stable/5.10: [ae7793027766491c5f8635b12d15a5940d3b8698]
stable/5.15: [91bd504128a51776472445070e11a3b0f9348c90]
stable/5.4: [384ef33d37cefb2ac539d44597d03f06c9b8975c]
stable/6.1: [97ce99984be12b9acb49ddce0f5d8ebb037adbb6]

CVE-2022-50382: padata: Always leave BHs disabled when running ->parallel()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50382

Introduced by commit 4611ce2 ("padata: allocate work structures for
parallel jobs from a pool") in v5.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34c3a47d20ae55b3600fed733bf96eafe9c500d5]
stable/5.10: [8e0681dd4eee029eb1d533d06993f7cb091efb73]
stable/5.15: [17afa98bccec4f52203508b3f49b5f948c6fd6ac]
stable/6.1: [6cfa9e60c0f88fdec6368e081ab968411cc706b1]

CVE-2022-50383: media: mediatek: vcodec: Can't set dst buffer to done
when lat decode error

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50383

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected code was added by 7b182b8 ("media: mediatek: vcodec: Refactor
get and put capture buffer flow") in 5.19-rc1.

Fixed status
mainline: [3568ecd3f3a6d133ab7feffbba34955c8c79bbc4]
stable/6.1: [66d26ed30056e7d2da3e9c14125ffe6049a4f907]

CVE-2022-50384: staging: vme_user: Fix possible UAF in tsi148_dma_list_add

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50384

Introduced by commit b2383c9 ("vme: tsi148: fix first DMA item
mapping") in v4.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [e6b0adff99edf246ba1f8d464530a0438cb1cbda]
cip/4.4-st: [967d1df0a758a75d27512140549eeb4f93e04d99]
mainline: [357057ee55d3c99a5de5abe8150f7bca04f8e53b]
stable/5.10: [5d2b286eb034af114f67d9967fc3fbc1829bb712]
stable/5.15: [1f5661388f43df3ac106ce93e67d8d22b16a78ff]
stable/5.4: [a45ba33d398a821147d7e5f16ead7eb125e331e2]
stable/6.1: [85db68fc901da52314ded80aace99f8b684c7815]

CVE-2022-50385: NFS: Fix an Oops in nfs_d_automount()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50385

Introduced by commit 2b0143b ("VFS: normal filesystems (and lustre):
d_inode() annotations") in v4.1-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35e3b6ae84935d0d7ff76cbdaa83411b0ad5e471]
stable/5.10: [5458bc0f9df639d83471ca384152cc62dbee0aeb]
stable/5.15: [f12377abac15fb4e8698225ac386894f8ae63598]
stable/6.1: [6f3d56783fbed861e483736a7001bdafd0dddd53]

CVE-2022-50386: Bluetooth: L2CAP: Fix user-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50386

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [d91fc2836562f299f34e361e089e9fe154da4f73]
cip/4.4-st: [bfaf5fa3f338f8293b977fe562bd1d059a1da130]
mainline: [35fcbc4243aad7e7d020b7c1dfb14bb888b20a4f]
stable/5.10: [0c108cf3ad386e0084277093b55a351c49e0be27]
stable/5.15: [d1e894f950ad48897d1a7cb05909ea29d8c3810e]
stable/5.4: [7d6f9cb24d2b2f6b6370eac074e2e6b1bafdad45]
stable/6.1: [35fcbc4243aad7e7d020b7c1dfb14bb888b20a4f]

CVE-2022-50387: net: hinic: fix the issue of CMDQ memory leaks

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50387

Introduced by commit 72ef908 ("hinic: add three net_device_ops of vf")
in v5.8-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [363cc87767f6ddcfb9158ad2e2afa2f8d5c4b94e]
stable/5.10: [6603843c80b16957f5d7d14d897faf13cef2b8b9]
stable/5.15: [6016d96a6adf66d61655d85da02e1a4c1deccbd6]
stable/6.1: [363cc87767f6ddcfb9158ad2e2afa2f8d5c4b94e]

CVE-2022-50388: nvme: fix multipath crash caused by flush request when
blktrace is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50388

Introduced commit is not determined.Fixed in v6.2-rc2.
Affected code was added by 35fe0d1 ("nvme: trace bio completion") in 5.4-rc1.

Fixed status
mainline: [3659fb5ac29a5e6102bebe494ac789fd47fb78f4]
stable/5.10: [f13301a69ababa6c2236fb4f0393b7e914e7e1e0]
stable/5.15: [4df413d46960f11c8c105238cfc3f5ff4c95c003]
stable/6.1: [183c2aaef40a91acbaae45c3824d6cde7bb62b10]

CVE-2022-50389: tpm: tpm_crb: Add the missed acpi_put_table() to fix memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50389

Introduced by commit 30fc8d1 ("tpm: TPM 2.0 CRB Interface") in v4.0-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1af2232b13837ce0f3a082b9f43735b09aafc367]
mainline: [37e90c374dd11cf4919c51e847c6d6ced0abc555]
stable/5.10: [0bd9b4be721c776f77adcaf34105dfca3007ddb9]
stable/5.15: [986cd9a9b95423e35a2cbb8e9105aec0e0d7f337]
stable/5.4: [927860dfa161ae8392a264197257dbdc52b26b0f]
stable/6.1: [b0785edaf649e5f04dc7f75533e810f4c00e4106]

CVE-2022-50390: drm/ttm: fix undefined behavior in bit shift for
TTM_TT_FLAG_PRIV_POPULATED

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50390

Introduced by commit 3312be8 ("drm/ttm: move populated state into page
flags") in v5.10-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [387659939c00156f8d6bab0fbc55b4eaf2b6bc5b]
stable/6.1: [6528971fdce0dfc0a28fec42c151a1eccdabadf5]

CVE-2022-50391: mm/mempolicy: fix memory leak in
set_mempolicy_home_node system call

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50391

Introduced by commit c6018b4 ("mm/mempolicy: add
set_mempolicy_home_node syscall") in v5.17-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38ce7c9bdfc228c14d7621ba36d3eebedd9d4f76]
stable/6.1: [0ce4cc6d269ddc448a825955b495f662f5d9e153]

CVE-2022-50392: ASoC: mediatek: mt8183: fix refcount leak in
mt8183_mt6358_ts3a227_max98357_dev_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50392

Introduced by commit 11c0269 ("ASoC: Mediatek: MT8183: Add machine
driver with TS3A227") in v5.2-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38eef3be38ab895959c442702864212cc3beb96c]
stable/5.15: [82f7c814edda353b4781f356d3ab90e943d5eac4]
stable/6.1: [156b0c19c1a44153e34cfdfa5937546a93dcb288]

CVE-2022-50393: drm/amdgpu: SDMA update use unlocked iterator

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50393

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected code was added by 8bb3158  ("drm/ttm: remove bo->moving") in 5.19-rc1.

Fixed status
mainline: [3913f0179ba366f7d7d160c506ce00de1602bbc4]
stable/6.1: [3913f0179ba366f7d7d160c506ce00de1602bbc4]

CVE-2022-50394: i2c: ismt: Fix an out-of-bounds bug in ismt_access()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50394

Introduced by commit 13f35ac ("i2c: Adding support for Intel iSMT
SMBus 2.0 host controller") in v3.9-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [bfe41d966c860a8ad4c735639d616da270c92735]
cip/4.4-st: [101c52af02ebcf4beb1d456f3299af3e239df814]
mainline: [39244cc754829bf707dccd12e2ce37510f5b1f8d]
stable/5.10: [9ac541a0898e8ec187a3fa7024b9701cffae6bf2]
stable/5.15: [96c12fd0ec74641295e1c3c34dea3dce1b6c3422]
stable/5.4: [cdcbae2c5003747ddfd14e29db9c1d5d7e7c44dd]
stable/6.1: [233348a04becf133283f0076e20b317302de21d9]

CVE-2022-50395: integrity: Fix memory leakage in keyring allocation error path

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50395

Introduced by commit 2b6aa41 ("KEYS: Use structure to capture key
restriction function and data") in v4.12-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39419ef7af0916cc3620ecf1ed42d29659109bf3]
stable/5.10: [3bd737289c26be3cee4b9afaf61ef784a2af9d6e]
stable/5.15: [29d6c69ba4b96a1de0376e44e5f8b38b13ec8803]
stable/5.4: [9b7c44885a07c5ee7f9bf3aa3c9c72fb110c8d22]
stable/6.1: [c591c48842f08d30ec6b8416757831985ed9a315]

CVE-2022-50396: net: sched: fix memory leak in tcindex_set_parms

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50396

Introduced by commit b9a24bb ("net_sched: properly handle failure case
of tcf_exts_init()") in v4.9-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [399ab7fe0fa0d846881685fd4e57e9a8ef7559f7]
stable/5.10: [b314f6c3512108d7a656c5caf07c82d1bbbdc0f1]
stable/5.15: [6c55953e232ea668731091d111066521f3b7719b]
stable/5.4: [55ac68b53f1cea1926ee2313afc5d66b91daad71]
stable/6.1: [facc4405e8b7407e03216207b1d1d640127de0c8]

CVE-2022-50397: net/ieee802154: reject zero-sized raw_sendmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50397

Introduced by commit fd18942 ("bpf: Don't redirect packets with
invalid pkt_len") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [3a4d061c699bd3eedc80dc97a4b2a2e1af83c6f5]
stable/5.10: [67cb80a9d2c83edac0e42aaa91ed4dd527cec284]
stable/5.15: [77bfd26cbb61a9f49ecb83729f0fd1352c17ddd8]
stable/5.4: [03ac583eefc9bc980213c53a79abc32a5539756e]
stable/6.1: [3a4d061c699bd3eedc80dc97a4b2a2e1af83c6f5]

CVE-2022-50398: drm/msm/dp: add atomic_check to bridge ops

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50398

Introduced by commit 8a3b4c1 ("drm/msm/dp: employ bridge mechanism for
display enable and disable") in v5.17-rc1.
Fixed in v6.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a661247967a6f3c99a95a8ba4c8073c5846ea4b]
stable/6.1: [3a661247967a6f3c99a95a8ba4c8073c5846ea4b]

CVE-2022-50399: media: atomisp: prevent integer overflow in
sh_css_set_black_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50399

Introduced by commit a49d253 ("staging/atomisp: Add support for the
Intel IPU v2") in v4.12-rc1.
Fixed in v6.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ad290194bb06979367622e47357462836c1d3b4]
stable/5.15: [a560aeac2f2d284903b5900774765d7fc61547bc]
stable/6.1: [3ad290194bb06979367622e47357462836c1d3b4]

CVE-2022-50400: staging: greybus: audio_helper: remove unused and
wrong debugfs usage

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50400

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected code was introduced by 510e340 ("staging: greybus: audio: Add
helper APIs for dynamic audio modules") in 5.9-rc1.

Fixed status
mainline: [d517cdeb904ddc0cbebcc959d43596426cac40b0]
stable/5.10: [d0febad83e29d85bb66e4f5cac0115b022403338]
stable/5.15: [4dab0d27a4211a27135a6899d6c737e6e0759a11]
stable/6.1: [d517cdeb904ddc0cbebcc959d43596426cac40b0]

CVE-2022-50401: nfsd: under NFSv4.1, fix double svc_xprt_put on
rpc_create failure

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50401

Introduced by commit a4abc6b ("nfsd: Fix svc_xprt refcnt leak when
setup callback client failed") in v5.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
cip/4.19-st: [9b4ae8c42d2ff09ed7c5832ccce5684c55e5ed23]
cip/4.4-st: [daa240a4525e24df446e28988a5529ab4a2fe046]
mainline: [3bc8edc98bd43540dbe648e4ef91f443d6d20a24]
stable/5.10: [c1207219a4bfa50121c9345d5d165470d0a82531]
stable/5.15: [a472f069ced8601979f53c13c0cf20236074ed46]
stable/5.4: [fddac3b4578d302ac9e51e7f03a9aae6254ae2a3]
stable/6.1: [d843ebd860c58a38e45527e8ec6516059f4c97f3]

CVE-2022-50402: drivers/md/md-bitmap: check the return value of
md_bitmap_get_counter()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50402

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected code was added by d60b479 ("md/bitmap: add bitmap_resize
function to allow bitmap resizing.") in 3.5-rc1.

Fixed status
cip/4.19-st: [21e9aac9a74d30907d44bae0d24c036cb3819406]
mainline: [3bd548e5b819b8c0f2c9085de775c5c7bff9052f]
stable/5.10: [100caacfa0ed26e061954c90cdc835d42f709536]
stable/5.15: [b621d17fe8b079574c773800148fb86907f3445d]
stable/5.4: [5d8d046f3dba939e74e2414f009df426700430ed]
stable/6.1: [99bef41f8e8d1d52b5cb34f2f193f1346192752b]

CVE-2022-50403: ext4: fix undefined behavior in bit shift for
ext4_check_flag_values

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50403

Introduced by commit 9a4c801 ("ext4: ensure Inode flags consistency
are checked at build time") in v3.8-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [743e9d708743d98464ccbd56e820d87dc6d1d629]
cip/4.4-st: [5afdf818e11a86838b070eb9e5f4b6cda342131e]
mainline: [3bf678a0f9c017c9ba7c581541dbc8453452a7ae]
stable/5.10: [f9cd6980800bbfd11bf94eb5f942049d4d4eaa52]
stable/5.15: [205ac16628aca9093931fcbdb4bcd00d0eb94132]
stable/5.4: [4690a4bdcf1470cb161aff1be30bd143b9dffd89]
stable/6.1: [7753d6657873a2523a9989e6c09090cd503bbcda]

CVE-2022-50404: fbdev: fbcon: release buffer when fbcon_do_set_font() failed

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50404

Introduced by commit a5a9230 ("fbdev: fbcon: Properly revert changes
when vc_resize() failed") in v6.0-rc3.
Fixed in v6.2-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3c3bfb8586f848317ceba5d777e11204ba3e5758]
stable/5.15: [88ec6d11052da527eb9268831e7a9bc5bbad02f6]
stable/6.1: [a609bfc1e644a8467cb31945ed1488374ebdc013]

CVE-2022-50405: net/tunnel: wait until all sk_user_data reader finish
before releasing the sock

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50405

Introduced by commit 6a93cc9 ("udp-tunnel: Add a few more UDP tunnel
APIs") in v3.18-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [be34e79e0ae6adbf6e7e75ddaee9ad84795ab933]
cip/4.4-st: [9b99fe011dd07a8a0904876835664e7d20e55da7]
mainline: [3cf7203ca620682165706f70a1b12b5194607dce]
stable/5.10: [91f09a776ae335ca836ed864b8f2a9461882a280]
stable/5.15: [9a6544343bba7da929d6d4a2dc44ec0f15970081]
stable/5.4: [303000c793f705d07b551eb7c1c27001c5b33c8d]
stable/6.1: [588d0b8462f5ffed3e677e65639825b2678117ab]

CVE-2022-50406: iomap: iomap: fix memory corruption when recording
errors during writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50406

Introduced by commit e735c00 ("iomap: Convert iomap_add_to_ioend() to
take a folio") # 5.17 onward in v5.17-rc1.
Introduced by commit 598ecfb ("iomap: lift the xfs writeback code to
iomap") # 5.5-5.16, needs backporting in v5.5-rc1.
Introduced by commit 150d5be ("xfs: remove xfs_cancel_ioend") #
4.6-5.4, needs backporting in v4.6-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d5f3ba1ac28059bdf7000cae2403e4e984308d2]
stable/6.1: [3d5f3ba1ac28059bdf7000cae2403e4e984308d2]

CVE-2022-50407: crypto: hisilicon/qm - increase the memory of local variables

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50407

Introduced commit is not determined.Fixed in v6.2-rc1.
Affected code was added by 488f30d ("crypto: hisilicon/qm - some
optimizations of ths qos write process") in 5.17-rc1.

Fixed status
mainline: [3efe90af4c0c46c58dba1b306de142827153d9c0]
stable/6.1: [fc521abb6ee4b8f06fdfc52646140dab6a2ed334]

CVE-2022-50408: wifi: brcmfmac: fix use-after-free bug in
brcmf_netdev_start_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50408

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [d79f4d903e14dde822c60b5fd3bedc5a289d25df]
mainline: [3f42faf6db431e04bf942d2ebe3ae88975723478]
stable/5.10: [e01d96494a9de0f48b1167f0494f6d929fa773ed]
stable/5.15: [232d59eca07f6ea27307022a33d226aff373bd02]
stable/5.4: [49c742afd60f552fce7799287080db02bffe1db2]
stable/6.1: [3f42faf6db431e04bf942d2ebe3ae88975723478]

CVE-2022-50409: net: If sock is dead don't access sock's sk_wq in
sk_stream_wait_memory

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50409

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [5fe03917bb017d9af68a95f989f1c122eebc69a6]
mainline: [3f8ef65af927db247418d4e1db49164d7a158fc5]
stable/5.10: [65029aaedd15d9fe5ea1a899134e236d83f627bb]
stable/5.15: [124b7c773271f06af5a2cea694b283cdb5275cf5]
stable/5.4: [a76462dbdd8bddcbeec9463bc9e54e509b860762]
stable/6.1: [3f8ef65af927db247418d4e1db49164d7a158fc5]

CVE-2022-50410: NFSD: Protect against send buffer overflow in NFSv2 READ

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50410

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
mainline: [401bc1f90874280a80b93f23be33a0e7e2d1f912]
stable/5.10: [2007867c5874134f2271eb276398208070049dd3]
stable/5.15: [2be9331ca6061bc6ea32247266f45b8b21030244]
stable/6.1: [401bc1f90874280a80b93f23be33a0e7e2d1f912]

CVE-2022-50411: ACPICA: Fix error code path in acpi_ds_call_control_method()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50411

Introduced commit is not determined.Fixed in v6.2-rc1.


Fixed status
cip/4.19-st: [2deb42c4f9776e59bee247c14af9c5e8c05ca9a6]
cip/4.4-st: [b1d708461fa0ca39e24b65e683b996aa4158ee1d]
mainline: [404ec60438add1afadaffaed34bb5fe4ddcadd40]
stable/5.10: [b0b83d3f3ffa96e8395c56b83d6197e184902a34]
stable/5.15: [5777432ebaaf797e24f059979b42df3139967163]
stable/5.4: [9ef353c92f9d04c88de3af1a46859c1fb76db0f8]
stable/6.1: [799881db3e03b5e98fe6a900d9d7de8c7d61e7ee]

CVE-2022-50412: drm: bridge: adv7511: unregister cec i2c device after
cec adapter

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50412

Introduced by commit 3b1b975 ("drm: adv7511/33: add HDMI CEC support")
in v4.15-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40cdb02cb9f965732eb543d47f15bef8d10f0f5f]
stable/5.10: [3747465c5da7a11957a34bbb9485d9fc253b91cc]
stable/5.15: [f369fb4deed7ab997cfa703dc85ec08b3adc1af8]
stable/6.1: [40cdb02cb9f965732eb543d47f15bef8d10f0f5f]

CVE-2022-50413: wifi: mac80211: fix use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50413

Introduced by commit 81151ce ("wifi: mac80211: support MLO
authentication/association with one link") in v6.0-rc1.
Fixed in v6.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40fb87129049ec5876dabf4a4d4aed6642b31f1a]
stable/6.1: [40fb87129049ec5876dabf4a4d4aed6642b31f1a]

CVE-2022-50414: scsi: fcoe: Fix transport not deattached when
fcoe_if_init() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50414

Introduced by commit 78a5824 ("[SCSI] fcoe: convert fcoe.ko to become
an fcoe transport provider driver") in v2.6.39-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [cf74d1197c0e3d2f353faa333e9e2847c73713f1]
cip/4.4-st: [028c3642ebed98d33d2d424c26304cb3abdca8b7]
mainline: [4155658cee394b22b24c6d64e49247bf26d95b92]
stable/5.10: [22e8c7a56bb1cd2ed0beaaccb34282ac9cbbe27e]
stable/5.15: [09a60f908d8b6497f618113b7c3c31267dc90911]
stable/5.4: [be5f1a82ad6056db22c86005dc4cac22a20deeef]
stable/6.1: [aef82d16be5a353d913163f26fc4385e296be2b8]

CVE-2022-50415: parisc: led: Fix potential null-ptr-deref in start_task()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50415

Introduced by commit 3499495 ("[PARISC] Use work queue in LED/LCD
driver instead of tasklet.") in v2.6.20.16.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fc307b2905a3dd75c50a53b4d87ac9c912fb7c4e]
cip/4.4-st: [97e089a03c6ee36fface47854f3cc610c026d2e1]
mainline: [41f563ab3c33698bdfc3403c7c2e6c94e73681e4]
stable/5.10: [3505c187b86136250b39e62c72a3a70435277af6]
stable/5.15: [ac838c663ba1fd6bff35a817fd89a47ab55e88e0]
stable/5.4: [5e4500454d75dd249be4695d83afa3ba0724c37e]
stable/6.1: [67c98fec87ed76b1feb2ae810051afd88dfa9df6]

CVE-2022-50416: irqchip/wpcm450: Fix memory leak in wpcm450_aic_of_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50416

Introduced by commit fead4dd ("irqchip: Add driver for WPCM450
interrupt controller") in v5.13-rc1.
Fixed in v6.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4208d4faf36573a507b5e5de17abe342e9276759]
stable/5.15: [740efb64ca5e8f2b30ac843bc4ab07950479fed4]
stable/6.1: [773c9d7f127f7a599d42ceed831de69f5aa22f03]

CVE-2022-50417: drm/panfrost: Fix GEM handle creation ref-counting

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50417

Introduced by commit f3ba912 ("drm/panfrost: Add initial panfrost
driver") in v5.2-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4217c6ac817451d5116687f3cc6286220dc43d49]
stable/5.10: [0b70f6ea4d4f2b4d4b291d86ab76b4d07394932c]
stable/5.15: [4f1105ee72d8c7c35d90e3491b31b2d9d6b7e33a]
stable/6.1: [ba3d2c2380e7129b525a787489c0b7e819a3b898]

CVE-2022-50418: wifi: ath11k: mhi: fix potential memory leak in
ath11k_mhi_register()

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50418

Introduced commit is not determined.Fixed in v6.1-rc1.
Affected file was added by 1399fb8 ("ath11k: register MHI controller
device for QCA6390") in 5.10-rc1.

Fixed status
mainline: [43e7c3505ec70db3d3c6458824d5fa40f62e3e7b]
stable/6.1: [43e7c3505ec70db3d3c6458824d5fa40f62e3e7b]

CVE-2022-50419: Bluetooth: hci_sysfs: Fix attempting to call
device_add multiple times

Announce: https://www.cve.org/CVERecord?id=CVE-2022-50419

Introduced commit is not determined.Fixed in v6.1-rc1.


Fixed status
cip/4.19-st: [671fee73e08ff415d36a7c16bdf238927df83884]
cip/4.4-st: [c4d5d8283d7488ff7ee6277bbb12b4f38bfa3edd]
mainline: [448a496f760664d3e2e79466aa1787e6abc922b5]
stable/5.10: [7b674dce4162bb46d396586e30e4653427023875]
stable/5.15: [3423a50fa018e88aed4c900d59c3c8334d8ad583]
stable/5.4: [6e85d2ad958c6f034b1b158d904019869dbb3c81]
stable/6.1: [448a496f760664d3e2e79466aa1787e6abc922b5]

CVE-2023-53369: net: dcb: choose correct policy to parse DCB_ATTR_BCN

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53369

Introduced by commit 859ee3c ("DCB: Add support for DCB BCN") in v2.6.29-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [31d49ba033095f6e8158c60f69714a500922e0c3]
stable/5.10: [8e309f43d0ca4051d20736c06a6f84bbddd881da]
stable/5.15: [a0da2684db18dead3bcee12fb185e596e3d63c2b]
stable/5.4: [5b3dbedb8d4a0f9f7ce904d76b885438af2a21f9]
stable/6.1: [ecff20e193207b44fdbfe64d7de89890f0a7fe6c]

CVE-2023-53370: drm/amdgpu: fix memory leak in mes self test

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53370

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [31d7c3a4fc3d312a0646990767647925d5bde540]
stable/6.1: [ce3288d8d654b252ba832626e7de481c195ef20a]

CVE-2023-53371: net/mlx5e: fix memory leak in mlx5e_fs_tt_redirect_any_create

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53371

Introduced by commit 0f575c2 ("net/mlx5e: Introduce Flow Steering ANY
API") in v5.13-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3250affdc658557a41df9c5fb567723e421f8bf2]
stable/6.1: [75df2fe6d160e16be880aacacd521b135d7177c9]

CVE-2023-53372: sctp: fix a potential overflow in sctp_ifwdtsn_skip

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53372

Introduced by commit 0fc2ea9 ("sctp: implement validate_ftsn for
sctp_stream_interleave") in v4.16-rc1.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4fbd094d4131a10d06a45d64158567052a35b3f4]
mainline: [32832a2caf82663870126c5186cf8f86c8b2a649]
stable/5.10: [79b28f42214a3d0d6a8c514db3602260bd5d6cb5]
stable/5.15: [6109f5b13ce3e3e537db6f18976ec0e9118d1c6f]
stable/5.4: [ad831a7079c99c01e801764b53bc9997c2e9c0f7]
stable/6.1: [5c9367ac5a22d71841bcd00130f9146c9b227d57]

CVE-2023-53373: crypto: seqiv - Handle EBUSY correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53373

Introduced by commit 0a27032 ("[CRYPTO] seqiv: Add Sequence Number IV
Generator") in v2.6.25-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1effbddaff60eeef8017c6dea1ee0ed970164d14]
cip/4.4-st: [5df18176cd3c85135a15d8712c7cd95a7a1c1c7c]
mainline: [32e62025e5e52fbe4812ef044759de7010b15dbc]
stable/5.10: [ae849d2f48019ff9c104e32bf588ccbfb200e971]
stable/5.15: [36ec108b7bd7e280edb22de028467bd09d644620]
stable/5.4: [63551e4b7cbcd9914258827699eb2cb6ed6e4a16]
stable/6.1: [4d497e8b200a175094e0ac252ed878add39b8771]

CVE-2023-53374: Bluetooth: hci_conn: fail SCO/ISO via hci_conn_failed
if ACL gone early

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53374

Introduced by commit ca1fd42 ("Bluetooth: Fix potential double free
caused by hci_conn_unlink") in v6.4-rc4.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3344d318337d9dca928fd448e966557ec5063f85]
stable/6.6: [3344d318337d9dca928fd448e966557ec5063f85]

CVE-2023-53375: tracing: Free error logs of tracing instances

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53375

Introduced by commit 2f754e7 ("tracing: Have the error logs show up in
the proper instances") in v5.2-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3357c6e429643231e60447b52ffbb7ac895aca22]
stable/5.10: [6e36373aa5ffa8e00fe7c71b3209f6f17081e552]
stable/5.15: [33d5d4e67a0e13c3ca6257fa67bf6503bc000878]
stable/5.4: [987f599fc556a4e64c405d8dde32c70311e8c278]
stable/6.1: [c0cf0f55be043ef67c38f492aa37ed1986d2f6b6]

CVE-2023-53376: scsi: mpi3mr: Use number of bits to manage bitmap sizes

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53376

Introduced by commit c5758fc ("scsi: mpi3mr: Gracefully handle online
FW update operation") in v5.17-rc1.
Introduced by commit e844adb ("scsi: mpi3mr: Implement SCSI error
handler hooks") in v5.14-rc1.
Introduced by commit c1af985 ("scsi: mpi3mr: Add Event acknowledgment
logic") in v5.17-rc1.
Introduced by commit 824a156 ("scsi: mpi3mr: Base driver code") in v5.14-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [339e61565f81a6534afdc18fd854b2e2628bf5db]
stable/6.1: [6a675a6d57d31da43d8da576465c1cd5d5b0bd3d]

CVE-2023-53377: cifs: prevent use-after-free by freeing the cfile later

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53377

Introduced by commit 76894f3 ("cifs: improve symlink handling for
smb2+") in v6.1-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33f736187d08f6bc822117629f263b97d3df4165]
stable/6.1: [4fe07d55a5461e66a55fbefb57f85ff0facea32b]

CVE-2023-53378: drm/i915/dpt: Treat the DPT BO as a framebuffer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53378

Introduced by commit 0dc987b ("drm/i915/display: Add smem fallback
allocation for dpt") in v6.0-rc1.
Fixed in v6.3-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3413881e1ecc3cba722a2e87ec099692eed5be28]
stable/6.1: [c781c107731fc09ce4330c8c636b8446d0f72aa4]

CVE-2023-53379: usb: phy: phy-tahvo: fix memory leak in tahvo_usb_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53379

Introduced by commit 0d45a13 ("usb: phy: tahvo: add IRQ check") in v5.15-rc1.
Fixed in v6.5-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10 stable/5.4

Fixed status
cip/4.19-st: [4da9edeccf77d7b4c6dbcb34d5908acdaa5bd7e3]
cip/4.4-st: [fe4c889e196d23e0449eca0b86883bdd95ae8083]
mainline: [342161c11403ea00e9febc16baab1d883d589d04]
stable/5.10: [56901de563359de20513e16a9ae008ae2c22e9a9]
stable/5.15: [ecf26d6e1b5450620c214feea537bb6ce05c6741]
stable/5.4: [fe9cdc19861950582f077f254a12026e169eaee5]
stable/6.1: [dd9b7c89a80428cc5f4ae0d2e1311fdedb2a1aac]

CVE-2023-53380: md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53380

Introduced by commit ee37d73 ("md/raid10: Fix raid10 replace hang when
new added disk faulty") in v4.20-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34817a2441747b48e444cb0e05d84e14bc9443da]
stable/5.10: [2990e2ece18dd4cca71b3109c80517ad94adb065]
stable/5.15: [f4368a462b1f9a8ecc2fdb09a28c3d4cad302a4f]
stable/5.4: [45fa023b3334a7ae6f6c4eb977295804222dfa28]
stable/6.1: [222cc459d59857ee28a5366dc225ab42b22f9272]

CVE-2023-53381: NFSD: fix leaked reference count of nfsd4_ssc_umount_item

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53381

Introduced by commit f4e44b3 ("NFSD: delay unmount source's export
after inter-server copy completed.") in v5.14-rc1.
Fixed in v6.3-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [34e8f9ec4c9ac235f917747b23a200a5e0ec857b]
stable/5.10: [2da50149981d05955e51c28e982e9ac29bd73417]
stable/5.15: [80a15dc4a0214b55ca42675bb0bb2a8d857eb1d0]
stable/6.1: [9f0df37520a27ad99eaacf38418b3d2bb5023105]

CVE-2023-53382: net/smc: Reset connection when trying to use SMCRv2 fails.

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53382

Introduced by commit e49300a ("net/smc: add listen processing for
SMC-Rv2") in v5.16-rc1.
Fixed in v6.4-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35112271672ae98f45df7875244a4e33aa215e31]
stable/6.1: [9540765d1882d15497d880096de99fafabcfa08c]

CVE-2023-53383: irqchip/gicv3: Workaround for NVIDIA erratum T241-FABRIC-4

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53383

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [35727af2b15d98a2dd2811d631d3a3886111312e]
stable/6.1: [86ba4f7b9f949e4c4bcb425f2a1ce490fea30df0]

CVE-2023-53384: wifi: mwifiex: avoid possible NULL skb pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53384

Introduced by commit 838e4f4 ("mwifiex: improve uAP RX handling") in v3.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [139d285e7695279f030dbb172e2d0245425c86c6]
cip/4.4-st: [182a75be3959c86a29a2acf17c67814aeac022c9]
mainline: [35a7a1ce7c7d61664ee54f5239a1f120ab95a87e]
stable/5.10: [bef85d58f7709896ed8426560ad117a73a37762f]
stable/5.15: [d7fd24b8d1bb54c5bcf583139e11a5e651e0263c]
stable/5.4: [231086e6a36316b823654f4535653f22d6344420]
stable/6.1: [7e7197e4d6a1bc72a774590d8765909f898be1dc]
stable/6.6: [35a7a1ce7c7d61664ee54f5239a1f120ab95a87e]

CVE-2023-53385: media: mdp3: Fix resource leaks in of_find_device_by_node

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53385

Introduced commit is not determined.Fixed in v6.6-rc1.
Affected function was added by 61890cc ("media: platform: mtk-mdp3:
add MediaTek MDP3 driver") in 6.1-rc1.

Fixed status
mainline: [35ca8ce495366909b4c2e701d1356570dd40c4e2]
stable/6.1: [8ba9d91c8f21f070af2049f114c206a8f2d5c71e]
stable/6.6: [35ca8ce495366909b4c2e701d1356570dd40c4e2]

CVE-2023-53386: Bluetooth: Fix potential use-after-free when clear keys

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53386

Introduced by commit d7d4168 ("Bluetooth: Fix Suspicious RCU usage
warnings") in v5.7-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3673952cf0c6cf81b06c66a0b788abeeb02ff3ae]
stable/5.10: [e87da6a0ac6e631454e7da53a76aa9fe44aaa5dd]
stable/5.15: [942d8cefb022f384d5424f8b90c7878f3f93726f]
stable/6.1: [94617b736c25091b60e514e2e7aeafcbbee6b700]
stable/6.6: [3673952cf0c6cf81b06c66a0b788abeeb02ff3ae]

CVE-2023-53387: scsi: ufs: core: Fix device management cmd timeout flow

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53387

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
mainline: [36822124f9de200cedc2f42516301b50d386a6cd]
stable/6.1: [cf45493432704786a0f8294c7723ad4eeb5fff24]

CVE-2023-53388: drm/mediatek: Clean dangling pointer on bind error path

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53388

Introduced by commit 119f517 ("drm/mediatek: Add DRM Driver for
Mediatek SoC MT8173.") in v4.7-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9a48f99aa7bea15e0b1d8b0040c46b4792eddf3b]
mainline: [36aa8c61af55675ed967900fbe5deb32d776f051]
stable/5.10: [6a89ddee1686a8872384aaa9f0bcfa6b675acd86]
stable/5.15: [49cf87919daeeeeeb9e924c39bdd9203af434461]
stable/5.4: [a161f1d92aabb3b8463f752bdc3474dc3a5ec0e5]
stable/6.1: [7b551a501fa714890e55bae73efede1185728d72]

CVE-2023-53389: drm/mediatek: dp: Only trigger DRM HPD events if
bridge is attached

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53389

Introduced by commit f70ac09 ("drm/mediatek: Add MT8195 Embedded
DisplayPort driver") in v6.1-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36b617f7e4ae663fcadd202ea061ca695ca75539]
stable/6.1: [6524d3d58797975cc40b85be1e9b89721b4e8d0b]

CVE-2023-53390: drivers: base: dd: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53390

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 2942df6 ("driver core: dd: remove
deferred_devices variable") in 5.13-rc1.

Fixed status
mainline: [36c893d3a759ae7c91ee7d4871ebfc7504f08c40]
stable/5.15: [7f1e53f88e8babf293ec052b70aa9d2a3554360c]
stable/6.1: [5a7a9efdb193d3c8a35821548a8e99612c358828]

CVE-2023-53391: shmem: use ramfs_kill_sb() for kill_sb method of
ramfs-based tmpfs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53391

Introduced by commit c3b1b1c ("ramfs: add support for "mode=" mount
option") in v2.6.30-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [36ce9d76b0a93bae799e27e4f5ac35478c676592]
stable/5.10: [5fada375113767b3b57f1b04f7a4fe64ffaa626f]
stable/5.15: [487f229efea80c00dd7397547ec4f25fb8999d99]
stable/6.1: [1f34bf8b442c6d720e7fa6f15e8702427e48aea9]

CVE-2023-53392: HID: intel-ish-hid: Fix kernel panic during warm reset

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53392

Introduced by commit f155dfe ("platform/x86: isthp_eclite: only load
for matching devices") in v5.16-rc3.
Introduced by commit facfe0a ("platform/chrome: chros_ec_ishtp: only
load for matching devices") in v5.16-rc3.
Introduced by commit 0d0cccc ("HID: intel-ish-hid: hid-client: only
load for matching devices") in v5.16-rc3.
Introduced by commit 44e2a58 ("HID: intel-ish-hid: fw-loader: only
load for matching devices") in v5.16-rc3.
Fixed in v6.3-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38518593ec55e897abda4b4be77b2ec8ec4447d1]
stable/6.1: [6c8cc40c588f8080a164d88336b1490279e0f1da]

CVE-2023-53393: RDMA/mlx5: Fix mlx5_ib_get_hw_stats when used for device

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53393

Introduced by commit aac4492 ("IB/mlx5: Update counter implementation
for dual port RoCE") in v4.16-rc1.
Fixed in v6.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38b50aa44495d5eb4218f0b82fc2da76505cec53]
stable/5.15: [8d89870d63758363b07ace5c2df82d6bf865f78b]
stable/6.1: [e597b003c736217b0c99ccf1b240c25009105238]

CVE-2023-53394: net/mlx5e: xsk: Fix crash on regular rq reactivation

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53394

Introduced by commit 082a9ed ("net/mlx5e: xsk: Flush RQ on XSK
activation to save memory") in v6.1-rc1.
Fixed in v6.5-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39646d9bcd1a65d2396328026626859a1dab59d7]

CVE-2023-53395: ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53395

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
cip/4.19-st: [23c67fa615c52712bfa02a6dfadbd4656c87c066]
cip/4.4-st: [13de36c541e87d1a9617b74940dbced116a19c85]
mainline: [3a21ffdbc825e0919db9da0e27ee5ff2cc8a863e]
stable/5.10: [625c12dc04a607b79f180ef3ee5a12bf2e3324c0]
stable/5.15: [430787056dd3c591eb553d5c3b2717efcf307d4e]
stable/5.4: [3bf4463e40a17a23f2f261dfd7fe23129bdd04a4]
stable/6.1: [e1f686930ee4b059c7baa3c3904b2401829f2589]
stable/6.6: [3a21ffdbc825e0919db9da0e27ee5ff2cc8a863e]

CVE-2023-53396: ubifs: Fix memory leak in do_rename

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53396

Introduced by commit 278d9a2 ("ubifs: Rename whiteout atomically") in v5.18-rc1.
Fixed in v6.4-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3a36d20e012903f45714df2731261fdefac900cb]
stable/5.15: [43b2f7d690697182beed6f71aa57b7249d3cfc9c]
stable/6.1: [9f565752b328fe53c9e42b7d4e4d89a1da63d738]

CVE-2023-53397: modpost: fix off by one in is_executable_section()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53397

Introduced by commit 52dc059 ("modpost: handle relocations mismatch in
__ex_table.") in v4.1-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.4-st: [19a80ba643e34d983ec9cd7fb6fd35a14f2c42fe]
mainline: [3a3f1e573a105328a2cca45a7cfbebabbf5e3192]
stable/5.10: [cb0cdca5c979bc34c27602e2039562932c2591a4]
stable/5.15: [5e0424cd8a44b5f480feb06753cdf4e1f248d148]
stable/5.4: [02dc8e8bdbe4412cfcf17ee3873e63fa5a55b957]
stable/6.1: [dd872d5576cc94528f427c7264c2c438928cc6d2]

CVE-2023-53398: mlx5: fix possible ptp queue fifo use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53398

Introduced by commit 58a5189 ("net/mlx5e: Add resiliency for PTP TX
port timestamp") in v6.0-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a50cf1e8e5157b82268eee7e330dbe5736a0948]
stable/6.1: [52e6e7a0bc04c85012a9251c7cf2d444a77eb966]

CVE-2023-53399: ksmbd: fix NULL pointer dereference in
smb2_get_info_filesystem()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53399

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected code was added by e2f34481 ("cifsd: add server-side
procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [3ac00a2ab69b34189942afa9e862d5170cdcb018]
stable/5.15: [227eb2689b44d0d60da3839b146983e73435924c]
stable/6.1: [a70751dd7b60eab025e97e19b6b2477c6eaf2bbb]

CVE-2023-53400: ALSA: hda: Fix Oops by 9.1 surround channel names

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53400

Introduced commit is not determined.Fixed in v6.4-rc3.


Fixed status
cip/4.19-st: [b5694aae4c2d9a288bafce7d38f122769e0428e6]
cip/4.4-st: [1fa3d510d02d65fb8e5fc0ea8ba48e7d42429ddf]
mainline: [3b44ec8c5c44790a82f07e90db45643c762878c6]
stable/5.10: [546b1f5f45a355ae0d3a8041cdaca597dfcac825]
stable/5.15: [e8c7d7c43d5edd20e518fe1dfb2371d1fe6e8bb8]
stable/5.4: [4ef155ddf9578bf035964d58739fdcd7dd44b4a4]
stable/6.1: [dc8c569d59f17b17d7bca4f68c36bd571659921e]

CVE-2023-53401: mm: kmem: fix a NULL pointer dereference in
obj_stock_flush_required()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53401

Introduced by commit bf4f059 ("mm: memcg/slab: obj_cgroup API") in v5.9-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b8abb3239530c423c0b97e42af7f7e856e1ee96]
stable/6.1: [33d9490b27e5d8da4444aefd714a4f50189db978]

CVE-2023-53402: kernel/printk/index.c: fix memory leak with using
debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53402

Introduced commit is not determined.Fixed in v6.3-rc1.
Affcted code was added by 3370155 ("printk: Userspace format indexing
support") in 5.15-rc1.

Fixed status
mainline: [55bf243c514553e907efcf2bda92ba090eca8c64]
stable/5.15: [2e07fa2e30d48d24a791483774a3d4b76769e0cf]
stable/6.1: [c578a68ffcdc2e8c72556bebdaae2b7500398e81]

CVE-2023-53403: time/debug: Fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53403

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 44511ab ("time/debug: Remove dentry pointer
for debugfs") in 5.13-rc1.

Fixed status
mainline: [5b268d8abaec6cbd4bd70d062e769098d96670aa]
stable/5.15: [dc39fbd865a9819db4b622f610ba17b2ebc294f4]
stable/6.1: [15cffd01ed80e3506e29ba9f441e2358413b7317]

CVE-2023-53404: USB: fotg210: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53404

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 0f60203 ("USB: fotg210-hcd: remove dentry
storage for debugfs file") in 5.14-rc1.

Fixed status
mainline: [6b4040f452037a7e95472577891d57c6b18c89c5]
stable/5.15: [4a71b15744b8f286718722f80b663c06ed909d8a]
stable/6.1: [7d2d3bef6d700eb4261fb6761de2c95a9e3c0ac8]

CVE-2023-53405: USB: gadget: gr_udc: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53405

Introduced commit is not determined.Fixed in v6.3-rc1.
Affcted code was added by 425de31 ("USB: gr_udc: remove dentry storage
for debugfs file") in 5.14-rc1.

Fixed status
mainline: [73f4451368663ad28daa67980c6dd11d83b303eb]
stable/5.15: [30f9ba2396a1130eef7f2d3ee7ee8037b7c25be9]
stable/6.1: [be21a66e17ee0ab5f3513b6c86659e60cec5e981]

CVE-2023-53406: USB: gadget: pxa25x_udc: fix memory leak with using
debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53406

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 1d50071 ("USB: gadget: pxa25x_udc: remove
dentry storage for debugfs file") in 5.14-rc1.

Fixed status
mainline: [7a038a681b7df78362d9fc7013e5395a694a9d3a]
stable/5.15: [6236a6d2cdfb710bd8a82c4b179d0a034d0d99cb]
stable/6.1: [78d9586d8e728be1e360d3d0da7170c791d1d55e]

CVE-2023-53407: USB: gadget: pxa27x_udc: fix memory leak with using
debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53407

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 8efd88f ("USB: gadget: pxa27x_udc: remove
dentry storage for debugfs file") in 5.14-rc1.

Fixed status
mainline: [7a6952fa0366d4408eb8695af1a0578c39ec718a]
stable/5.15: [8da78a60f3323ce7aac589d49fb82f71a04bc835]
stable/6.1: [b14d188d0d0b86e2180525aefd570dbb6ebd6aa9]

CVE-2023-53408: trace/blktrace: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53408

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 3093929 ("blktrace: fix use after free for
struct blk_trace") in 5.17-rc7.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [83e8864fee26f63a7435e941b7c36a20fd6fe93e]
stable/5.15: [a2e4b48d6f9b39aa19bafe223f9dd436a692fc80]
stable/6.1: [3036f5f5ae5210797d95446795df01c1249af9ad]

CVE-2023-53409: drivers: base: component: fix memory leak with using
debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53409

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by c654cea ("driver core: component: remove
dentry pointer in \"struct master\"") in 5.13-rc1.

Fixed status
mainline: [8deb87b1e810dd558371e88ffd44339fbef27870]
stable/5.15: [09709a49283f79184c998d6dafcc01590e4d654d]
stable/6.1: [79ac2b01e033181e21cc84216ace1f4160eb8950]

CVE-2023-53410: USB: ULPI: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53410

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by bd0a0a0 ("usb: ulpi: Add debugfs support")
in 5.18-rc1.

Fixed status
mainline: [8f4d25eba599c4bd4b5ea8ae8752cda480a9d563]
stable/6.1: [dcbe69f4f743a938344b32e60531ea55355e0c08]

CVE-2023-53411: PM: EM: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53411

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 1bc138c ("PM / EM: add support for other
devices than CPUs in Energy Model") in 5.9-rc1.

Fixed status
mainline: [a0e8c13ccd6a9a636d27353da62c2410c4eca337]
stable/5.10: [e974e8f1e37d22c0de07374f8ddc84073fef2f1d]
stable/5.15: [84e4d4885d0ae011860fb599d50d01b8fdca2b87]
stable/6.1: [5100c4efc30636aa48ac517dece3c3b7f84fe367]

CVE-2023-53412: USB: gadget: bcm63xx_udc: fix memory leak with using
debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53412

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 0cac357 ("USB: gadget: bcm63xx_udc: remove
dentry storage for debugfs file") in 5.14-rc1.

Fixed status
mainline: [a91c99b1fe5c6f7e52fb932ad9e57ec7cfe913ec]
stable/5.15: [b0a2663ecbe8f65cd3bab2b34dd90156ceb0dbb8]
stable/6.1: [31de0b70ae5661a407e9d578bbc41de2d83ac25d]

CVE-2023-53413: USB: isp116x: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53413

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 7c7b971 ("USB: host: isp116x: remove dentry
pointer for debugfs") in 5.13-rc1.

Fixed status
mainline: [a95f62d5813facbec20ec087472eb313ee5fa8af]
stable/5.15: [6f12097467ea1ef57f29dd29c1d082e4752cef37]
stable/6.1: [542a99cd6eadfb543bf190431c3fb520f3da0bbc]

CVE-2023-53414: scsi: snic: Fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53414

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 1be4ec2 ("scsi: snic: debugfs: remove local
storage of debugfs files") in 5.14-rc1.

Fixed status
mainline: [ad0e4e2fab928477f74d742e6e77d79245d3d3e7]
stable/5.15: [5a46d8bdaf03e8a4bb83f0c363326d9aa66cc122]
stable/6.1: [3dec769caf337c55814fbf79ec8c91a3cce23bf3]

CVE-2023-53415: USB: dwc3: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53415

Introduced commit is not determined.Fixed in v6.3-rc1.
Affcted code was added by 8562d5b ("USB: dwc3: remove debugfs root
dentry storage") in 5.14-rc1.

Fixed status
mainline: [be308d68785b205e483b3a0c61ba3a82da468f2c]
stable/5.15: [cf52c320cf74245ce1c12b0bd48f77b87d77fbc9]
stable/6.1: [ce234af49d103d95e3fdca59b25e0d0242f41bb4]

CVE-2023-53416: USB: isp1362: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53416

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 7347f4b ("USB: host: isp1362: remove dentry
pointer for debugfs") in 5.13-rc1.

Fixed status
mainline: [c26e682afc14caa87d44beed271eec8991e93c65]
stable/5.15: [fb284bee1e213c94be9131d1aca7c16bd6ba259d]
stable/6.1: [b0a8195a84a725ca7936c213b5e056d2a3ab2a94]

CVE-2023-53417: USB: sl811: fix memory leak with using debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53417

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 82d4afc ("USB: host: sl811: remove dentry
pointer for debugfs") in 5.13-rc1.

Fixed status
mainline: [e1523c4dbc54e164638ff8729d511cf91e27be04]
stable/5.15: [bb4d5eefb67095d7c3b70b08498b23b7f2895f76]
stable/6.1: [54166af8941d0cf46b65cfa2fbce76e38d82fadf]

CVE-2023-53418: USB: gadget: lpc32xx_udc: fix memory leak with using
debugfs_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53418

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by e3d59ef ("USB: gadget: lpc32xx_udc: remove
debugfs dentry variable") in 5.14-rc1.

Fixed status
mainline: [e3965acaf3739fde9d74ad82979b46d37c6c208f]
stable/5.15: [036ada6ca9eea926abc0b0ef550b10488d66d4d8]
stable/6.1: [7a5fdd8660174a8056de57d1fdce3a7e9f77f60e]

CVE-2023-53419: rcu: Protect rcu_print_task_exp_stall() ->exp_tasks access

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53419

Introduced commit is not determined.Fixed in v6.4-rc1.


Fixed status
mainline: [3c1566bca3f8349f12b75d0a2d5e4a20ad6262ec]
stable/5.10: [a7d21b8585894e6fff973f6ddae42f02b13f600f]
stable/5.15: [e30a55e98ae6c44253d8b129efefd5da5bc6e3bc]
stable/6.1: [d0a8c0e31a09ec1efd53079083e2a677956b4d91]

CVE-2023-53420: ntfs: Fix panic about slab-out-of-bounds caused by
ntfs_listxattr()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53420

Introduced by commit be71b5c ("fs/ntfs3: Add attrib operations") in v5.15-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c675ddffb17a8b1e32efad5c983254af18b12c2]
stable/5.15: [f3380d895e28a32632eb3609f5bd515adee4e5a1]
stable/6.1: [c86a2517df6c9304db8fb12b77136ec7a5d85994]

CVE-2023-53421: blk-cgroup: Reinit blkg_iostat_set after clearing in
blkcg_reset_stats()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53421

Introduced by commit 3b8cc62 ("blk-cgroup: Optimize
blkcg_rstat_flush()") in v6.2-rc1.
Introduced by commit f733164 ("blk-cgroup: reimplement basic IO stats
using cgroup rstat") in v5.5-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d2af77e31ade05ff7ccc3658c3635ec1bea0979]

CVE-2023-53422: wifi: iwlwifi: fw: fix memory leak in debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53422

Introduced by commit 36dfe9a ("iwlwifi: dump api version in yaml
format") in v5.8-rc1.
Fixed in v6.4-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d90d2f4a018fe8cfd65068bc6350b6222be4852]
stable/5.10: [89496d6cff297c88fe0286a440c380ceb172da2b]
stable/5.15: [e302e9ca14a86a80eadfb24a34d8675aadaf3ef3]
stable/6.1: [37f64bc8e001f216566d17ef9fd5608c762ebcd4]

CVE-2023-53423: objtool: Fix memory leak in create_static_call_sections()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53423

Introduced by commit 1e7e478 ("x86/static_call: Add inline static call
implementation for x86-64") in v5.10-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3da73f102309fe29150e5c35acd20dd82063ff67]
stable/5.10: [a1368eaea058e451d20ea99ca27e72d9df0d16dd]
stable/5.15: [3a75866a5ceff5d4fdd5471e06c4c4d03e0298b3]
stable/6.1: [a8f63d747bf7c983882a5ea7456a5f84ad3acad5]

CVE-2023-53424: clk: mediatek: fix of_iomap memory leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53424

Introduced by commit c58cd0e ("clk: mediatek: Add
mtk_clk_simple_probe() to simplify clock providers") in v5.15-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3db7285e044144fd88a356f5b641b9cd4b231a77]

CVE-2023-53425: media: platform: mediatek: vpu: fix NULL ptr dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53425

Introduced commit is not determined.Fixed in v6.5-rc1.
Affected code was added by 3003a18 ("[media] VPU: mediatek: support
Mediatek VPU") in 4.8-rc1.

Fixed status
cip/4.19-st: [1b3f25d3894a091abc247eadab266a2c9be64389]
mainline: [3df55cd773e8603b623425cc97b05e542854ad27]
stable/5.10: [2caeb722f0ea5d2d24af30bb1753a89d449b6aa0]
stable/5.15: [776b34615a29551d69d82a0082e7319d5ea284bd]
stable/5.4: [c1c5826223ae05a48d21f6708c6f34ee9006238c]
stable/6.1: [b7bd48f0be84e24d21aa3a8f59a8a9cb8633a1c4]

CVE-2023-53426: xsk: Fix xsk_diag use-after-free error during socket cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53426

Introduced by commit 18b1ab7 ("xsk: Fix race at socket teardown") in v5.18-rc1.
Fixed in v6.6-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3e019d8a05a38abb5c85d4f1e85fda964610aa14]
stable/5.15: [5979985f2d6b565b6cf0f79a62670a2855c0e96c]
stable/6.1: [6436973164ea5506a495f39e56be5aea375e7832]
stable/6.6: [3e019d8a05a38abb5c85d4f1e85fda964610aa14]

CVE-2023-53427: cifs: Fix warning and UAF when destroy the MR list

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53427

Introduced by commit c739858 ("CIFS: SMBD: Implement RDMA memory
registration") in v4.16-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [275a3d2b9408fc4895e342f772cab9a89960546e]
mainline: [3e161c2791f8e661eed24a2c624087084d910215]
stable/5.10: [cfd85a0922c4696d768965e686ad805a58d9d834]
stable/5.15: [7cbd5bdb5bd4404a5da4309521134b42c65846c0]
stable/5.4: [3524d6da0fe88aee79f06be6572955d16ad76b39]
stable/6.1: [41832c62a75dad530dc5a2856c92ae5459d497e5]

CVE-2023-53428: powercap: arm_scmi: Remove recursion while parsing zones

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53428

Introduced by commit b55eef5 ("powercap: arm_scmi: Add SCMI Powercap
based driver") in v6.2-rc1.
Fixed in v6.6-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e767d6850f867cc33ac16ca097350a1d2417982]
stable/6.6: [3e767d6850f867cc33ac16ca097350a1d2417982]

CVE-2023-53429: btrfs: don't check PageError in __extent_writepage

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53429

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [3e92499e3b004baffb479d61e191b41b604ece9a]

CVE-2023-53430: wifi: mt76: dma: fix memory leak running mt76_dma_tx_cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53430

Introduced by commit 52546e2 ("wifi: mt76: add WED RX support to dma
queue alloc") in v6.2-rc1.
Fixed in v6.3-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f7dda36e0b6dfa2cd26191f754ba061ab8191f2]

CVE-2023-53431: scsi: ses: Don't attach if enclosure has no components

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53431

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [feefd5232ecb788f0666f75893a7a86faec8bbcc]
cip/4.4-st: [f908a1df2e4e816b01ddb6e1e64d678657d95905]
mainline: [3fe97ff3d94934649abb0652028dd7296170c8d0]
stable/5.10: [d68937dfc73ee7f61cf3424fa3225be93cacaa00]
stable/5.15: [6fce2307650a190e343a84537c278d499fa37c26]
stable/5.4: [6069e04a922a0488bcf4f1017d38d18afda8194c]
stable/6.1: [5ca5470b33e5221dd3e5be81108697c22dd38b56]

CVE-2023-53432: firewire: net: fix use after free in
fwnet_finish_incoming_packet()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53432

Introduced commit is not determined.Fixed in v6.5-rc1.


Fixed status
mainline: [3ff256751a2853e1ffaa36958ff933ccc98c6cb5]
stable/5.15: [2ea70379e4f4efa95c9daa7f3f9bdd4d40aec927]
stable/6.1: [9040adc38cf6bfbb77034d558ac2c52f70d840ac]

CVE-2023-53433: net: add vlan_get_protocol_and_depth() helper

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53433

Introduced by commit 469aced ("vlan: consolidate VLAN parsing code and
limit max parsing depth") in v5.8-rc5.
Fixed in v6.4-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st stable/5.4

Fixed status
mainline: [4063384ef762cc5946fc7a3f89879e76c6ec51e2]
stable/5.10: [34a5ee69ec6273f0aee79e7ce4d14afc83ca8122]
stable/5.15: [9dd9ffe118415b4ac1cebac43443000072bc8f46]
stable/5.4: [4188c5269475ac59d467b5814c5df02756f6d907]
stable/6.1: [55caf900e13cd04466def08173a14b41d18c19c3]

CVE-2023-53434: remoteproc: imx_dsp_rproc: Add custom memory copy
implementation for i.MX DSP Cores

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53434

Introduced commit is not determined.Fixed in v6.4-rc1.
Affected driver was added by ec0e554 ("remoteproc: imx_dsp_rproc: Add
remoteproc driver for DSP on i.MX") in 5.16-rc1.

Fixed status
mainline: [408ec1ff0caa340c57eecf4cbd14ef0132036a50]
stable/6.1: [44361033a8806aabd0f49b24e5a2fc07232cc5ff]

CVE-2023-53435: cassini: Fix a memory leak in the error handling path
of cas_init_one()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53435

Introduced by commit fcaa406 ("cassini: use request_firmware") in v2.6.28-rc1.
Fixed in v6.4-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [60d8e8b88087d68e10c8991a0f6733fa2f963ff0]
cip/4.4-st: [575b98c5abf937bcf08038ed012c114b50c68c42]
mainline: [412cd77a2c24b191c65ea53025222418db09817c]
stable/5.10: [dc61f7582cc92d547d02e141cd66f5d1f4ed8012]
stable/5.15: [234e744d86bd95b381d24546df2dba72804e0219]
stable/5.4: [e20105d967ab5b53ff50a0e5991fe37324d2ba20]
stable/6.1: [172146c26f0c1b86ab4e9ebffc7e06f04229fa17]

CVE-2023-53436: scsi: snic: Fix possible memory leak if device_add() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53436

Introduced by commit c8806b6 ("snic: driver for Cisco SCSI HBA") in v4.2-rc1.
Fixed in v6.5-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f830968d464f55e11bc9260a132fc77daa266aa3]
cip/4.4-st: [e982eb3c0de9e9666e8b4353d3cfa165c7786358]
mainline: [41320b18a0e0dfb236dba4edb9be12dba1878156]
stable/5.10: [58889d5ad74cbc1c9595db74e13522b58b69b0ec]
stable/5.15: [461f8ac666fa232afee5ed6420099913ec4e4ba2]
stable/5.4: [cea09922f5f75652d55b481ee34011fc7f19868b]
stable/6.1: [7723a5d5d187626c4c640842e522cf4e9e39492e]

CVE-2023-53437: media: uvcvideo: Handle cameras with invalid descriptors

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53437

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [2914259fcea23971c6fed8b2618d3a729a78c365]
cip/4.4-st: [734eaeb881baaa366d1f92964ad4250eb9799974]
mainline: [41ddb251c68ac75c101d3a50a68c4629c9055e4c]
stable/5.10: [d8aa2e1ae6426d7cbddf1735aed1a63ddf0e6909]
stable/5.15: [31a8d11d28b57656cebfbd4c0b8b76f6ad5b017d]
stable/5.4: [4e4e6ca62e77539d4df8d13137e2683b10baddd9]
stable/6.1: [11196ee3916e50a5da3c1e6ecda19a02dca14ba3]

CVE-2023-53438: x86/MCE: Always save CS register on AMD Zen IF Poison errors

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53438

Introduced commit is not determined.Fixed in v6.6-rc1.


Fixed status
mainline: [4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67]
stable/6.1: [e6e6a5f50f58fadec397b23064b7e4830292863d]
stable/6.6: [4240e2ebe67941ce2c4f5c866c3af4b5ac7a0c67]

CVE-2023-53439: net: skb_partial_csum_set() fix against transport
header magic value

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53439

Introduced by commit 66e4c8d ("net: warn if transport header was not
set") in v5.19-rc1.
Fixed in v6.4-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [424f8416bb39936df6365442d651ee729b283460]
stable/6.1: [3e785c8deb046305c61b9fa02265d0cb900c4a45]

CVE-2023-53440: nilfs2: fix sysfs interface lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53440

Introduced by commit dd70edb ("nilfs2: integrate sysfs support into
driver") in v3.17-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [5fe0ea141fbb887d407f1bf572ebf24427480d5c]
cip/4.4-st: [c8a6b7fae70702ccbc6ec0a6c1910127c5989f71]
mainline: [42560f9c92cc43dce75dbf06cc0d840dced39b12]
stable/5.10: [3dbee84bf9e3273c4bb9ca6fc18ff22fba23dd24]
stable/5.15: [d540aea451ab5489777a8156560f1388449b3109]
stable/5.4: [83b16a60e413148685739635901937e2f16a7873]
stable/6.1: [1942ccb7d95f287a312fcbabfa8bc9ba501b1953]

CVE-2023-53441: bpf: cpumap: Fix memory leak in cpu_map_update_elem

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53441

Introduced by commit 6710e11 ("bpf: introduce new bpf cpu map type
BPF_MAP_TYPE_CPUMAP") in v4.15-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4369016497319a9635702da010d02af1ebb1849d]
stable/5.15: [d26299f50f5ea8f0aeb5d49e659c31f64233c816]
stable/6.1: [b11a9b4f28cb6ff69ef7e69809e5f7fffeac9030]

CVE-2023-53442: ice: Block switchdev mode when ADQ is active and vice versa

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53442

Introduced by commit fbc7b27 ("ice: enable ndo_setup_tc support for
mqprio_qdisc") in v5.16-rc1.
Fixed in v6.5-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43d00e102d9ecbe2635d7e3f2e14d2e90183d6af]
stable/6.1: [1c82d1b736ce85e77fd4da05eca6f1f4a52a2bc3]

CVE-2023-53443: mfd: arizona: Use pm_runtime_resume_and_get() to
prevent refcnt leak

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53443

Introduced commit is not determined.Fixed in v6.3-rc1.
Affected code was added by 247fa19 ("mfd: arizona: Fully support the
use of MCLK1 as the 32kHz clock source") in 3.10-rc1.

Fixed status
mainline: [4414a7ab80cebf715045e3c4d465feefbad21139]
stable/5.10: [754e81ff44061dda68da0fd4ef51bd1aa9fbf2cf]
stable/5.15: [5a47bb71b1a94a279144fc3031d3c4591b38dd16]
stable/5.4: [7195e642b49af60d4120fa1b45bd812ba528174f]
stable/6.1: [9893771097b22a8743a446e45994a177795ca4da]

CVE-2023-53444: drm/ttm: fix bulk_move corruption when adding a entry

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53444

Introduced by commit fee2ede ("drm/ttm: rework bulk move handling v5")
in v5.19-rc1.
Fixed in v6.5-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4481913607e58196c48a4fef5e6f45350684ec3c]
stable/6.1: [70a3015683b007a0db4a1e858791b69afd45fc83]

CVE-2023-53445: net: qrtr: Fix a refcount bug in qrtr_recvmsg()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53445

Introduced by commit 0a7e0d0 ("net: qrtr: Migrate node lookup tree to
spinlock") in v5.6-rc1.
Fixed in v6.3-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44d807320000db0d0013372ad39b53e12d52f758]
stable/5.10: [98a9cd82c541ef6cbdb829cd6c05cbbb471e373c]
stable/5.15: [b9ba5906c42089f8e1d0001b7b50a7940f086cbb]
stable/6.1: [aa95efa187b4114075f312b3c4680d050b56fdec]

CVE-2023-53446: PCI/ASPM: Disable ASPM on MFD function removal to
avoid use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53446

Introduced by commit b5a0a9b ("PCI/ASPM: Read and set up L1 substate
capabilities") in v4.11-rc1.
Fixed in v6.5-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [456d8aa37d0f56fc9e985e812496e861dcd6f2f2]
stable/5.10: [7badf4d6f49a358a01ab072bbff88d3ee886c33b]
stable/5.15: [9856c0de49052174ab474113f4ba40c02aaee086]
stable/5.4: [666e7f9d60cee23077ea3e6331f6f8a19f7ea03f]
stable/6.1: [7aecdd47910c51707696e8b0e045b9f88bd4230f]

CVE-2023-53447: f2fs: don't reset unchangable mount option in f2fs_remount()

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53447

Introduced commit is not determined.Fixed in v6.5-rc1.
Introduced commit is imported from CVE-2023-53447.vulnerable file.

Fixed status
mainline: [458c15dfbce62c35fefd9ca637b20a051309c9f1]
stable/6.1: [e2fb24ce37caeaecff08af4e9967c8462624312b]

CVE-2025-39837: platform/x86: asus-wmi: Fix racy registrations

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39837

Introduced by commit feea7bd ("platform/x86: asus-wmi: Refactor Ally
suspend/resume") in v6.16-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5549202b9c02c2ecbc8634768a3da8d9e82d548d]

CVE-2025-39838: cifs: prevent NULL pointer dereference in UTF16 conversion

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39838

Introduced commit is not determined.Fixed in v6.17-rc5.
Affected function was addedby 2503a0d ("CIFS: Add SMB2 support for
is_path_accessible") in 3.6-rc1.

Fixed status
mainline: [70bccd9855dae56942f2b18a08ba137bb54093a0]
stable/6.1: [65b98a7e65e7a8f3894d8760cd194eaf20504c99]
stable/6.12: [1f797f062b5cf13a1c2bcc23285361baaa7c9260]
stable/6.6: [1cfa5dd05847137f0fb3ce74ced80c0b4858d716]

CVE-2025-39839: batman-adv: fix OOB read/write in network-coding decode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39839

Introduced by commit 2df5278 ("batman-adv: network coding - receive
coded packets and decode them") in v3.10-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d77b6ff0ce35a6d0b0b7b9581bc3f76d041d4087]
stable/5.10: [1e36c6c8dc8023b4bbe9a16e819f9998b9b6a183]
stable/5.15: [5d334bce9fad58cf328d8fa14ea1fff855819863]
stable/5.4: [30fc47248f02b8a14a61df469e1da4704be1a19f]
stable/6.1: [dce6c2aa70e94c04c523b375dfcc664d7a0a560a]
stable/6.12: [20080709457bc1e920eb002483d7d981d9b2ac1c]
stable/6.6: [bb37252c9af1cb250f34735ee98f80b46be3cef1]

CVE-2025-39840: audit: fix out-of-bounds read in audit_compare_dname_path()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39840

Introduced by commit e92eebb ("audit: fix suffixed '/' filename
matching") in v6.14-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4540f1d23e7f387880ce46d11b5cd3f27248bf8d]

CVE-2025-39841: scsi: lpfc: Fix buffer free/clear order in deferred receive path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39841

Introduced by commit 472e146 ("scsi: lpfc: Correct upcalling nvmet_fc
transport during io done downcall") in v5.1-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9dba9a45c348e8460da97c450cddf70b2056deb3]
stable/5.10: [baa39f6ad79d372a6ce0aa639fbb2f1578479f57]
stable/5.15: [95b63d15fce5c54a73bbf195e1aacb5a75b128e2]
stable/5.4: [ab34084f42ee06a9028d67c78feafb911d33d111]
stable/6.1: [55658c7501467ca9ef3bd4453dd920010db8bc13]
stable/6.12: [367cb5ffd8a8a4c85dc89f55e7fa7cc191425b11]
stable/6.6: [d96cc9a1b57725930c60b607423759d563b4d900]

CVE-2025-39842: ocfs2: prevent release journal inode after journal shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39842

Introduced by commit da5e7c8 ("ocfs2: cleanup journal init and
shutdown") in v5.16-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f46e8ef8bb7b452584f2e75337b619ac51a7cadf]
stable/6.1: [42c415c53ad2065088cc411d08925effa5b3d255]
stable/6.12: [f4a917e6cd6c798f7adf39907f117fc754db1283]
stable/6.6: [e9188f66e94955431ddbe2cd1cdf8ff2bb486abf]

CVE-2025-39843: mm: slub: avoid wake up kswapd in set_track_prepare

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39843

Introduced by commit 5cf909c ("mm/slub: use stackdepot to save stack
trace in objects") in v5.19-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [850470a8413a8a78e772c4f6bd9fe81ec6bd5b0f]
stable/6.1: [994b03b9605d36d814c611385fbf90ca6db20aa8]
stable/6.12: [243b705a90ed8449f561a271cf251fd2e939f3db]
stable/6.6: [522ffe298627cfe72539d72167c2e20e72b5e856]

CVE-2025-39844: mm: move page table sync declarations to linux/pgtable.h

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39844

Introduced by commit 8d40091 ("x86/vmemmap: handle unpopulated sub-pmd
ranges") in v5.13-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cc183f2e67d19b03ee5c13a6664b8c6cc37ff9d]
stable/5.15: [732e62212f49d549c91071b4da7942ee3058f7a2]
stable/6.1: [eceb44e1f94bd641b2a4e8c09b64c797c4eabc15]
stable/6.12: [4f7537772011fad832f83d6848f8eab282545bef]
stable/6.6: [6797a8b3f71b2cb558b8771a03450dc3e004e453]

CVE-2025-39845: x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and
arch_sync_kernel_mappings()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39845

Introduced by commit 8d40091 ("x86/vmemmap: handle unpopulated sub-pmd
ranges") in v5.13-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6659d027998083fbb6d42a165b0c90dc2e8ba989]
stable/5.15: [744ff519c72de31344a627eaf9b24e9595aae554]
stable/6.1: [5f761d40ee95d2624f839c90ebeef2d5c55007f5]
stable/6.12: [b7f4051dd3388edd30e9a6077c05c486aa31e0d4]
stable/6.6: [26ff568f390a531d1bd792e49f1a401849921960]

CVE-2025-39846: pcmcia: Fix a NULL pointer dereference in
__iodyn_find_io_region()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39846

Introduced by commit 49b1153 ("pcmcia: move all pcmcia_resource_ops
providers into one module") in v2.6.35-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44822df89e8f3386871d9cad563ece8e2fd8f0e7]
stable/5.10: [5ff2826c998370bf7f9ae26fe802140d220e3510]
stable/5.15: [4bd570f494124608a0696da070f00236a96fb610]
stable/5.4: [b990c8c6ff50649ad3352507398e443b1e3527b2]
stable/6.1: [ce3b7766276894d2fbb07e2047a171f9deb965de]
stable/6.12: [fafa7450075f41d232bc785a4ebcbf16374f2076]
stable/6.6: [2ee32c4c4f636e474cd8ab7c19a68cf36072ea93]

CVE-2025-39847: ppp: fix memory leak in pad_compress_skb

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39847

Introduced by commit b3f9b92 ("[PPP]: add PPP MPPE encryption module")
in v2.6.20.16.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4844123fe0b853a4982c02666cb3fd863d701d50]
stable/5.10: [87a35a36742df328d0badf4fbc2e56061c15846c]
stable/5.15: [0b21e9cd4559102da798bdcba453b64ecd7be7ee]
stable/5.4: [9ca6a040f76c0b149293e430dabab446f3fc8ab7]
stable/6.1: [1d8b354eafb8876d8bdb1bef69c7d2438aacfbe8]
stable/6.12: [631fc8ab5beb9e0ec8651fb9875b9a968e7b4ae4]
stable/6.6: [85c1c86a67e09143aa464e9bf09c397816772348]

CVE-2025-39848: ax25: properly unshare skbs in ax25_kiss_rcv()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39848

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8156210d36a43e76372312c87eb5ea3dbb405a85]
stable/5.10: [5b079be1b9da49ad88fc304c874d4be7085f7883]
stable/5.15: [2bd0f67212908243ce88e35bf69fa77155b47b14]
stable/5.4: [42b46684e2c78ee052d8c2ee8d9c2089233c9094]
stable/6.1: [01a2984cb803f2d487b7074f9718db2bf3531f69]
stable/6.12: [89064cf534bea4bb28c83fe6bbb26657b19dd5fe]
stable/6.6: [7d449b7a6c8ee434d10a483feed7c5c50108cf56]

CVE-2025-39849: wifi: cfg80211: sme: cap SSID length in
__cfg80211_connect_result()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39849

Introduced by commit c38c701 ("wifi: cfg80211: Set SSID if it is not
already set") in v6.3-rc1.
Fixed in v6.17-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [62b635dcd69c4fde7ce1de4992d71420a37e51e3]
stable/6.1: [8e751d46336205abc259ed3990e850a9843fb649]
stable/6.12: [31229145e6ba5ace3e9391113376fa05b7831ede]
stable/6.6: [e472f59d02c82b511bc43a3f96d62ed08bf4537f]

CVE-2025-39850: vxlan: Fix NPD in {arp,neigh}_reduce() when using
nexthop objects

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39850

Introduced by commit 1274e1c ("vxlan: ecmp support for mac fdb
entries") in v5.8-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f5d2fd1ca04a23c18b1bde9a43ce2fa2ffa1bce]
stable/6.12: [e211e3f4199ac829bd493632efcd131d337cba9d]

CVE-2025-39851: vxlan: Fix NPD when refreshing an FDB entry with a
nexthop object

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39851

Introduced by commit 1274e1c ("vxlan: ecmp support for mac fdb
entries") in v5.8-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ead38147ebb813f08be6ea8ef547a0e4c09559a]
stable/6.12: [4ff4f3104da6507e0f118c63c4560dfdeb59dce3]

CVE-2025-39852: net/tcp: Fix socket memory leak in TCP-AO failure
handling for IPv6

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39852

Introduced by commit 06b22ef ("net/tcp: Wire TCP-AO to request
sockets") in v6.7-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa390321aba0a54d0f7ae95ee4ecde1358bb9234]
stable/6.12: [46d33c878fc0b3d7570366b2c9912395b3f4e701]

CVE-2025-39853: i40e: Fix potential invalid access when MAC list is empty

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39853

Introduced by commit e3219ce ("i40e: Add support for client interface
for IWARP driver") in v4.6-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a556f06338e1d5a85af0e32ecb46e365547f92b9]
stable/5.10: [3c6fb929afa313d9d11f780451d113f73922fe5d]
stable/5.15: [1eadabcf5623f1237a539b16586b4ed8ac8dffcd]
stable/5.4: [971feafe157afac443027acdc235badc6838560b]
stable/6.1: [e2a5e74879f9b494bbd66fa93f355feacde450c7]
stable/6.12: [66e7cdbda74ee823ec2bf7b830ebd235c54f5ddf]
stable/6.6: [fb216d980fae6561c7c70af8ef826faf059c6515]

CVE-2025-39854: ice: fix NULL access of tx->in_use in ice_ll_ts_intr

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39854

Introduced by commit 82e71b2 ("ice: Enable SW interrupt from FW for LL
TS") in v6.8-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6486338fde3f04ed0ec59fe67a69a208c32734f]
stable/6.12: [2cde98a02da958357fe240a6ba269b69d913b6ba]

CVE-2025-39855: ice: fix NULL access of tx->in_use in ice_ptp_ts_irq

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39855

Introduced by commit f9472aa ("ice: Process TSYN IRQ in a separate
function") in v6.15-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [403bf043d9340196e06769065169df7444b91f7a]

CVE-2025-39856: net: ethernet: ti: am65-cpsw-nuss: Fix null pointer
dereference for ndev

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39856

Introduced by commit 9a369ae ("net: ethernet: ti: am65-cpsw: remove
am65_cpsw_nuss_tx_compl_packets_2g()") in v6.15-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6099f263e1f408bcc7913c9df24b0677164fc5d]

CVE-2025-39857: net/smc: fix one NULL pointer dereference in
smc_ib_is_sg_need_sync()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39857

Introduced by commit 0ef69e7 ("net/smc: optimize for
smc_sndbuf_sync_sg_for_device and smc_rmb_sync_sg_for_cpu") in
v6.0-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba1e9421cf1a8369d25c3832439702a015d6b5f9]
stable/6.1: [0cdf1fd8fc59d44a48c694324611136910301ef9]
stable/6.12: [eb929910bd4b4165920fa06a87b22cc6cae92e0e]
stable/6.6: [f18d9b3abf9c6587372cc702f963a7592277ed56]

CVE-2025-39858: eth: mlx4: Fix IS_ERR() vs NULL check bug in
mlx4_en_create_rx_ring

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39858

Introduced by commit 8533b14 ("eth: mlx4: create a page pool for Rx")
in v6.15-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e580beaf43d563aaf457f1c7f934002355ebfe7b]

CVE-2025-39859: ptp: ocp: fix use-after-free bugs causing by ptp_ocp_watchdog

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39859

Introduced by commit 773bda9 ("ptp: ocp: Expose various resources on
the timecard.") in v5.15-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8bf935cf789872350b04c1a6468b0a509f67afb2]

CVE-2025-39860: Bluetooth: Fix use-after-free in l2cap_sock_cleanup_listen()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39860

Introduced by commit 1728137 ("Bluetooth: L2CAP: Fix use-after-free in
l2cap_sock_ready_cb") in v6.5-rc1.
Fixed in v6.17-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [862c628108562d8c7a516a900034823b381d3cba]
stable/5.10: [83e1d9892ef51785cf0760b7681436760dda435a]
stable/5.15: [47f6090bcf75c369695d21c3f179db8a56bbbd49]
stable/5.4: [964cbb198f9c46c2b2358cd1faffc04c1e8248cf]
stable/6.1: [2ca99fc3512a8074de20ee52a87b492dfcc41a4d]
stable/6.12: [306b0991413b482dbf5585b423022123bb505966]
stable/6.6: [6077d16b5c0f65d571eee709de2f0541fb5ef0ca]

CVE-2025-39861: Bluetooth: vhci: Prevent use-after-free by removing
debugfs files early

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39861

Introduced by commit ab4e438 ("Bluetooth: Add vhci devcoredump
support") in v6.4-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28010791193a4503f054e8d69a950ef815deb539]
stable/6.12: [1503756fffe76d5aea2371a4b8dee20c3577bcfd]
stable/6.6: [bd75eba88e88d7b896b0c737b02a74a12afc235f]

CVE-2025-39862: wifi: mt76: mt7915: fix list corruption after hardware restart

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39862

Introduced by commit 8a55712 ("wifi: mt76: mt7915: enable full system
reset support") in v6.2-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [065c79df595af21d6d1b27d642860faa1d938774]

CVE-2025-39863: wifi: brcmfmac: fix use-after-free when rescheduling
brcmf_btcoex_info work

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39863

Introduced by commit 61730d4 ("brcmfmac: support critical protocol API
for DHCP") in v3.10-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cb83d4be0b9b697eae93d321e0da999f9cdfcfc]
stable/6.12: [3e789f8475f6c857c88de5c5bf4b24b11a477dd7]
stable/6.6: [f1150153c4e5940fe49ab51136343c5b4fe49d63]

CVE-2025-39864: wifi: cfg80211: fix use-after-free in cmp_bss()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39864

Introduced by commit 3ab8227 ("cfg80211: refactor
cfg80211_bss_update") in v5.4-rc1.
Fixed in v6.17-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26e84445f02ce6b2fe5f3e0e28ff7add77f35e08]
stable/5.10: [a97a9791e455bb0cd5e7a38b5abcb05523d4e21c]
stable/5.15: [ff040562c10a540b8d851f7f4145fa112977f853]
stable/5.4: [a8bb681e879ca3c9f722aa08d3d7ae41c42a8807]
stable/6.1: [6854476d9e1aeaaf05ebc98d610061c2075db07d]
stable/6.12: [5b7ae04969f822283a95c866967e42b4d75e0eef]
stable/6.6: [b7d08929178c16398278613df07ad65cf63cce9d]

CVE-2025-39865: tee: fix NULL pointer dereference in tee_shm_put

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39865

Introduced by commit dfd0743 ("tee: handle lookup of shm with
reference count 0") in v5.16-rc7.
Fixed in v6.17-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [e4a718a3a47e89805c3be9d46a84de1949a98d5d]
stable/5.10: [f266188603c34e6e234fb0dfc3185f0ba98d71b7]
stable/5.15: [4377eac565c297fdfccd2f8e9bf94ee84ff6172f]
stable/6.1: [25e315bc8ad363bd1194e49062f183ad4011957e]
stable/6.12: [963fca19fe34c496e04f7dd133b807b76a5434ca]
stable/6.6: [add1ecc8f3ad8df22e3599c5c88d7907cc2a3079]

CVE-2025-39866: fs: writeback: fix use-after-free in __mark_inode_dirty()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39866

Introduced commit is not determined.Fixed in v6.17-rc3.


Fixed status
mainline: [d02d2c98d25793902f65803ab853b592c7a96b29]
stable/5.15: [b187c976111960e6e54a6b1fff724f6e3d39406c]
stable/6.1: [1edc2feb9c759a9883dfe81cb5ed231412d8b2e4]
stable/6.12: [e63052921f1b25a836feb1500b841bff7a4a0456]
stable/6.6: [bf89b1f87c72df79cf76203f71fbf8349cd5c9de]

CVE-2025-39867: netfilter: nft_set_pipapo: fix null deref for empty set

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39867

Introduced by commit d8d871a ("netfilter: nft_set_pipapo: merge
pipapo_get/lookup") in v6.17-rc1.
Fixed in v6.17-rc2.

Bug introduced commit was backported to following branches.
stable/6.12 stable/6.16

Fixed status
mainline: [30c1d25b9870d551be42535067d5481668b5e6f3]
stable/6.12: [44b2be6d5994ddf07ecc86c01d3279bfa13e9ef6]

CVE-2025-39868: erofs: fix runtime warning on
truncate_folio_batch_exceptionals()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39868

Introduced by commit bde708f ("fs/dax: always remove DAX page-cache
entries when breaking layouts") in v6.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [181993bb0d626cf88cc803f4356ce5c5abe86278]

CVE-2025-39869: dmaengine: ti: edma: Fix memory allocation size for
queue_priority_map

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39869

Introduced by commit 2b6b3b7 ("ARM/dmaengine: edma: Merge the two
drivers under drivers/dma/") in v4.4-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e63419dbf2ceb083c1651852209c7f048089ac0f]
stable/6.1: [5e462fa0dfdb52b3983cf41532d3d4c7d63e2f93]
stable/6.12: [069fd1688c57c0cc8a3de64d108579b31676f74b]
stable/6.6: [1baed10553fc8b388351d8fc803e3ae6f1a863bc]

CVE-2025-39870: dmaengine: idxd: Fix double free in idxd_setup_wqs()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39870

Introduced by commit 3fd2f4b ("dmaengine: idxd: fix memory leak in
error handling path of idxd_setup_wqs") in v6.15-rc7.
Fixed in v6.17-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [39aaa337449e71a41d4813be0226a722827ba606]
stable/6.1: [25e6146c2812487a88f619d5ff6efbdcd5b2bc31]
stable/6.12: [ec5430d090d0b6ace8fefa290fc37e88930017d2]
stable/6.6: [df82c7901513fd0fc738052a8e6a330d92cc8ec9]

CVE-2025-39871: dmaengine: idxd: Remove improper idxd_free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39871

Introduced by commit d5449ff ("dmaengine: idxd: Add missing idxd
cleanup to fix memory leak in remove call") in v6.15-rc7.
Fixed in v6.17-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [f41c538881eec4dcf5961a242097d447f848cda6]
stable/6.12: [dd7a7e43269711d757fc260b0bbdf7138f75de11]
stable/6.6: [0e95ee7f532b21206fe3f1c4054002b0d21e3b9c]

CVE-2025-39872: hsr: hold rcu and dev lock for hsr_get_port_ndev

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39872

Introduced by commit 9c10dd8 ("net: hsr: Create and export
hsr_get_port_ndev()") in v6.14-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [847748fc66d08a89135a74e29362a66ba4e3ab15]

CVE-2025-39873: can: xilinx_can: xcan_write_frame(): fix
use-after-free of transmitted SKB

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39873

Introduced by commit 1598efe ("can: xilinx_can: refactor code in
preparation for CAN FD support") in v4.19-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef79f00be72bd81d2e1e6f060d83cf7e425deee4]
stable/6.1: [1139321161a3ba5e45e61e0738b37f42f20bc57a]
stable/6.12: [725b33deebd6e4c96fe7893f384510a54258f28f]
stable/6.6: [94b050726288a56a6b8ff55aa641f2fedbd3b44c]

CVE-2025-39874: macsec: sync features on RTM_NEWLINK

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39874

Introduced by commit 7e4d784 ("net: hold netdev instance lock during
rtnetlink operations") in v6.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f82c3ba66c6b2e3cde0f255156a753b108ee9dc]

CVE-2025-39875: igb: Fix NULL pointer dereference in ethtool loopback test

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39875

Introduced by commit 2c61960 ("igb: Add AF_XDP zero-copy Rx support")
in v6.14-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75871a525a596ff4d16c4aebc0018f8d0923c9b1]

CVE-2025-39876: net: fec: Fix possible NPD in
fec_enet_phy_reset_after_clk_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39876

Introduced by commit 64a632d ("net: fec: Fix phy_device lookup for
phy_reset_after_clk_enable()") in v5.10-rc1.
Fixed in v6.17-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st stable/5.4

Fixed status
mainline: [03e79de4608bdd48ad6eec272e196124cefaf798]
stable/6.1: [5f1bb554a131e59b28482abad21f691390651752]
stable/6.12: [4fe53aaa4271a72fe5fe3e88a45ce01646b68dc5]
stable/6.6: [fe78891f296ac05bf4e5295c9829ef822f3c32e7]

CVE-2025-39877: mm/damon/sysfs: fix use-after-free in state_show()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39877

Introduced by commit a61ea56 ("mm/damon/sysfs: link DAMON for virtual
address spaces monitoring") in v5.18-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3260a3f0828e06f5f13fac69fb1999a6d60d9cff]
stable/6.1: [3858c44341ad49dc7544b19cc9f9ecffaa7cc50e]
stable/6.12: [26d29b2ac87a2989071755f9828ebf839b560d4c]
stable/6.6: [60d7a3d2b985a395318faa1d88da6915fad11c19]

CVE-2025-39878: ceph: fix crash after fscrypt_encrypt_pagecache_blocks() error

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39878

Introduced by commit ce80b76 ("ceph: introduce
ceph_process_folio_batch() method") in v6.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [249e0a47cdb46bb9eae65511c569044bd8698d7d]

CVE-2025-39879: ceph: always call ceph_shift_unused_folios_left()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39879

Introduced by commit ce80b76 ("ceph: introduce
ceph_process_folio_batch() method") in v6.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cce7c15faaac79b532a07ed6ab8332280ad83762]

CVE-2025-39880: libceph: fix invalid accesses to ceph_connection_v1_info

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39880

Introduced by commit cd1a677 ("libceph, ceph: implement msgr2.1
protocol (crc and secure modes)") in v5.11-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cdbc9836c7afadad68f374791738f118263c5371]
stable/6.1: [591ea9c30737663a471b2bb07b27ddde86b020d5]
stable/6.12: [35dbbc3dbf8bccb2d77c68444f42c1e6d2d27983]
stable/6.6: [23538cfbeed87159a5ac6c61e7a6de3d8d4486a8]

CVE-2025-39881: kernfs: Fix UAF in polling when open file is released

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39881

Introduced by commit 34f26a1 ("sched/psi: Per-cgroup PSI accounting
disable/re-enable interface") in v6.1-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c9ba2777d6c86025e1ba4186dc5cd930e40ec5f]
stable/6.1: [34d9cafd469c69ad85e6a36b4303c78382cf5c79]
stable/6.12: [7e64474aba78d240f7804f48f2d454dcca78b15f]
stable/6.6: [854baafc00c433cccbe0ab4231b77aeb9b637b77]

CVE-2025-39882: drm/mediatek: fix potential OF node use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39882

Introduced by commit 1f40369 ("drm/mediatek: Fix device/node reference
count leaks in mtk_drm_get_all_drm_priv") in v6.17-rc4.
Fixed in v6.17-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.16 stable/6.6

Fixed status
mainline: [4de37a48b6b58faaded9eb765047cf0d8785ea18]
stable/6.12: [b58a26cdd4795c1ce6a80e38e9348885555dacd6]
stable/6.6: [b2fbe0f9f80b9cfa1e06ddcf8b863d918394ef1d]

CVE-2025-39883: mm/memory-failure: fix
VM_BUG_ON_PAGE(PagePoisoned(page)) when unpoison memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39883

Introduced by commit f1dd2cd ("mm, memory_hotplug: do not associate
hotadded memory to zones until online") in v4.13-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d613f53c83ec47089c4e25859d5e8e0359f6f8da]
stable/6.1: [e4ec6def5643a1c9511115b3884eb879572294c6]
stable/6.12: [7618fd443aa4cfa553a64cacf5721581653ee7b0]
stable/6.6: [3d278e89c2ea62b1aaa4b0d8a9766a35b3a3164a]

CVE-2025-39884: btrfs: fix subvolume deletion lockup caused by inodes
xarray race

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39884

Introduced by commit 310b2f5 ("btrfs: use an xarray to track open
inodes in a root") in v6.11-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f6a6c280059c4ddc23e12e3de1b01098e240036f]
stable/6.12: [9ba898c9fcbe6ebb88bcd4df8aab0f90090d202e]

CVE-2025-39885: ocfs2: fix recursive semaphore deadlock in fiemap call

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39885

Introduced by commit 00dc417 ("ocfs2: fiemap support") in v2.6.28-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04100f775c2ea501927f508f17ad824ad1f23c8d]
stable/6.1: [36054554772f95d090eb45793faf6aa3c0254b02]
stable/6.12: [1d3c96547ee2ddeaddf8f19a3ef99ea06cc8115e]
stable/6.6: [0709bc11b942870fc0a7be150e42aea42321093a]

CVE-2025-39886: bpf: Tell memcg to use allow_spinning=false path in
bpf_timer_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39886

Introduced by commit b00628b ("bpf: Introduce bpf timers.") in v5.15-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d78b4473cdb08b74662355a9e8510bde09c511e]
stable/6.12: [cd1fd26bb13473c1734e3026b2b97025a0a4087b]
stable/6.6: [449682e76f32601f211816d3e2100bed87e67a4c]

CVE-2025-39887: tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39887

Introduced by commit 17f8910 ("tracing/osnoise: Allow arbitrarily long
CPU string") in v6.16-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1628c00c4351dd0727ef7f670694f68d9e663d8]

CVE-2025-39888: fuse: Block access to folio overlimit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39888

Introduced by commit 3568a95 ("fuse: support large folios for
retrieves") in v6.16-rc1.
Fixed in v6.17-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d81ba6d49a7457784f0b6a71046818b86ec7e44]

CVE-2024-58241: Bluetooth: hci_core: Disable works on hci_unregister_dev

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58241

Introduced by commit 0d151a1 ("Bluetooth: hci_core: cancel all works
upon hci_unregister_dev()") in v6.10-rc7.
Fixed in v6.12-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [989fa5171f005ecf63440057218d8aeb1795287d]

CVE-2025-39889: Bluetooth: l2cap: Check encryption key size on
incoming connection

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39889

Introduced by commit 288c069 ("Bluetooth: Enforce key size of 16 bytes
on FIPS level") in v5.11-rc1.
Fixed in v6.15-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [522e9ed157e3c21b4dd623c79967f72c21e45b78]
stable/5.15: [24b2cdfc16e9bd6ab3d03b8e01c590755bd3141f]
stable/6.1: [c6d527bbd3d3896375079f5dbc8b7f96734a3ba5]
stable/6.12: [d49798ecd26e0ee7995a7fc1e90ca5cd9b4402d6]
stable/6.6: [9e3114958d87ea88383cbbf38c89e04b8ea1bce5]

CVE-2025-39890: wifi: ath12k: fix memory leak in ath12k_service_ready_ext_event

Announce: https://www.cve.org/CVERecord?id=CVE-2025-39890

Introduced by commit d889913 ("wifi: ath12k: driver for Qualcomm Wi-Fi
7 devices") in v6.3-rc1.
Fixed in v6.16-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [89142d34d5602c7447827beb181fa06eb08b9d5c]
stable/6.12: [3a392f874ac83a77ad0e53eb8aafdbeb787c9298]
stable/6.6: [99dbad1b01d3b2f361a9db55c1af1212be497a3d]


* Updated CVEs

CVE-2025-21751: net/mlx5: HWS, change error flow on matcher disconnect

stable/6.12 was fixed.

stable/6.12: [5682aad0276ff9b9b0eff3188eb6a1f504d6b436]

CVE-2025-22037: ksmbd: fix null pointer dereference in alloc_preauth_hash()

stable/6.6 was fixed.

stable/6.6: [cce57cd8c5dead24127cf2308fdd60fcad2d6ba6]

CVE-2025-23160: media: mediatek: vcodec: Fix a resource leak related
to the scp device in FW initialization

stable/6.1 was fixed.

Fixed status
stable/6.1: [69dd5bbdd79c65445bb17c3c53510783bc1d756c]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

