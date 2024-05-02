Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DA6C10F1A
	for <webhook@archiver.kernel.org>; Thu,  2 May 2024 03:11:01 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web10.4897.1714619457071217668
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 May 2024 20:10:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=gVoHXd/S;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6ef9dee5bddso301311a34.1
        for <cip-dev@lists.cip-project.org>; Wed, 01 May 2024 20:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1714619456; x=1715224256; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SEeMW/mesHJwfuIXuddvEyiWSkqrl+RcRJ293qdjFGw=;
        b=gVoHXd/S+AEDh/yMcohEuzHsofG8/P+cqs3H9wELIBu7MYIznIdum9vz2aDzkrna1f
         q1eVn+qAzFVg8NS6JUvEck6Icq9C2Zps0npdpF1jO4uLrmBr15WGj2v7QTyTCRKfhQP5
         x6rLufn1u0qTB5B1dJ1uVUlorKlMn8McYAd2NU4iZAwgRQXZGvEUsLG0oHG9U1yT89Qc
         Skm3varTeewpiHhh6FPu+bc6D1WNmC8UvqFUaLdTL8VL1I90q34pkQCv4/rjNvTeTnDr
         CCuwJV9ZkIvgLV5edqsnotnWpGk4cFOZ4iDVyOYeYzUmwAqucoNzfOF+bA3THp01pLRl
         frLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714619456; x=1715224256;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SEeMW/mesHJwfuIXuddvEyiWSkqrl+RcRJ293qdjFGw=;
        b=gR+DS8i+iseaNncqizERvVKq+hIRXg+1E/Oc5nyc1kygV/xnRQJkaRaubXSXz5FfGq
         MaPbH67m4LPzjoiUW4Z5XU9xTUWFFEnS6hizUjh6PuSUgM33PDHjod/9ncwtPdXIRoxc
         5xq/JdGpVAjymI3/jhSbrUHHpG9Yvcot+9loJa6ByMp0VI7v/8lcDTHFvfecD6nzfDpE
         NQ8meDfh7tqpr3nOn/DXk37lmcLOEkZ7Vhk9FIGcCyZu/lgeSKX84rYEto83pqt/qmTo
         Zhzb8vSevhJRvq4vKm3yq6yifPHjenFnWKfbFBgdArR5WVDvZxjxDCZ08M6SCizy4XWG
         actw==
X-Gm-Message-State: AOJu0YwNkXOZ3QPZItaZwT7oy9tgAD2u45FyMswvFTL4A2K97E2wa7BA
	5vdHAupNtYALITMZS7XP3OdOe+xDE5AHe2LIiv4r/zW/saU1fWgw9th3asxR3Y/+KFyjCzaxaKz
	WLPnMu84uraoNSfGpDPgReNpbjyo1RVLq1zdUFSgfIwPkm6HArGQ=
X-Google-Smtp-Source: AGHT+IE6S0iZY0dXgHmbq4VfvJYUm66YedMBvcUlNHxy4sf7ykqDTl1c5sWfBOw0535h7A04Qfb5FuhlN/aLO5XP0rE=
X-Received: by 2002:a05:6871:3a2b:b0:22e:b96a:375 with SMTP id
 pu43-20020a0568713a2b00b0022eb96a0375mr5227844oac.30.1714619453588; Wed, 01
 May 2024 20:10:53 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 2 May 2024 12:10:17 +0900
Message-ID: <CAODzB9qRaX1K2KCngUL5DZEfaMgyHTBLonS7DrUdzgBKQo5PLg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 May 2024 03:11:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15791

Hi!

It's this week's CVE report.

This week reported 207 new CVEs and 10 updated CVEs.

* New CVEs

CVE-2024-26926: binder: check offset alignment in binder_get_object()

Announce: https://lore.kernel.org/linux-cve-announce/20240424232709.718930-2-lee@kernel.org/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6d98eb9 ("binder: avoid potential data leakage
when copying txn") in v5.17-rc1.
This commit was backported to 5.10, 5.15, and 5.4. Linux 4.x is not affected.
Fixed in v6.9-rc5.

Fixed status
mainline: [aaef73821a3b0194a01bd23ca77774f704a04d40]

CVE-2023-52646: aio: fix mremap after fork null-deref

Announce: https://lore.kernel.org/linux-cve-announce/2024042655-CVE-2023-52646-3ebb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e4a0d3e ("aio: Make it possible to remap aio
ring") in v3.19-rc1.
All stable kernels are fixed.
Fixed in v6.2.

Fixed status
cip/4.4: [1cb8592e28e1a99474a831820b9c8f4ba67f5e7a]
cip/4.4-rt: [1cb8592e28e1a99474a831820b9c8f4ba67f5e7a]
cip/4.4-st: [1cb8592e28e1a99474a831820b9c8f4ba67f5e7a]
mainline: [81e9d6f8647650a7bead74c5f926e29970e834d1]
stable/4.19: [d8dca1bfe9adcae38b35add64977818c0c13dd22]
stable/5.10: [c261f798f7baa8080cf0214081d43d5f86bb073f]
stable/5.15: [178993157e8c50aef7f35d7d6d3b44bb428199e1]
stable/5.4: [4326d0080f7e84fba775da41d158f46cf9d3f1c2]
stable/6.1: [af126acf01a12bdb04986fd26fc2eb3b40249e0d]

CVE-2022-48631: ext4: fix bug in extents parsing when eh_entries == 0
and eh_depth > 0

Announce: https://lore.kernel.org/linux-cve-announce/2024042851-CVE-2022-48631-cab6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc7.
It seems as if 4.x may be affected.

Fixed status
mainline: [29a5b8a137ac8eb410cc823653a29ac0e7b7e1b0]
stable/5.10: [958b0ee23f5ac106e7cc11472b71aa2ea9a033bc]
stable/5.15: [be4df018c0be5ebecf1ca510feacc23be415cefc]
stable/5.4: [bb7eb3ca4b3b0d2c7872cf1a41c30f5e5bd65df0]

CVE-2022-48632: i2c: mlxbf: prevent stack overflow in
mlxbf_i2c_smbus_start_transaction()

Announce: https://lore.kernel.org/linux-cve-announce/2024042854-CVE-2022-48632-465f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b5b5b32 ("i2c: mlxbf: I2C SMBus driver for
Mellanox BlueField SoC") in v5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [de24aceb07d426b6f1c59f33889d6a964770547b]
stable/5.10: [48ee0a864d1af02eea98fc825cc230d61517a71e]
stable/5.15: [dc2a0c587006f29b724069740c48654b9dcaebd2]

CVE-2022-48633: drm/gma500: Fix WARN_ON(lock->magic != lock) error

Announce: https://lore.kernel.org/linux-cve-announce/2024042854-CVE-2022-48633-f726@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc6.

Fixed status
mainline: [b6f25c3b94f2aadbf5cbef954db4073614943d74]

CVE-2022-48634: drm/gma500: Fix BUG: sleeping function called from
invalid context errors

Announce: https://lore.kernel.org/linux-cve-announce/2024042854-CVE-2022-48634-af99@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc6.
It looks as if commit f76c22ce ("drm/gma500: Add page flip support on
psb/cdv") in 5.6-rc1 is the first introduced commit.

Fixed status
mainline: [63e37a79f7bd939314997e29c2f5a9f0ef184281]
stable/5.10: [c5812807e416618477d1bb0049727ce8bb8292fd]
stable/5.15: [e5ae504c8623476e13032670f1a6d6344d53ec9b]

CVE-2022-48635: fsdax: Fix infinite loop in dax_iomap_rw()

Announce: https://lore.kernel.org/linux-cve-announce/2024042854-CVE-2022-48635-6286@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca289e0 ("fsdax: switch dax_iomap_rw to use
iomap_iter") in v5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [17d9c15c9b9e7fb285f7ac5367dfb5f00ff575e3]
stable/5.15: [929ef155e1da41c06f4d8ca86ae12b851a83a744]

CVE-2022-48636: s390/dasd: fix Oops in dasd_alias_get_start_dev due to
missing pavgroup

Announce: https://lore.kernel.org/linux-cve-announce/2024042855-CVE-2022-48636-52a7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8e09f21 ("[S390] dasd: add hyper PAV support to
DASD device driver, part 1") in v2.6.25-rc1.
Fixed in v6.0-rc7.

Fixed status
mainline: [db7ba07108a48c0f95b74fabbfd5d63e924f992d]
stable/4.19: [aaba5ff2742043705bc4c02fd0b2b246e2e16da1]
stable/5.10: [f5fcc9d6d71d9ff7fdbdd4b89074e6e24fffc20b]
stable/5.15: [d3a67c21b18f33c79382084af556557c442f12a6]
stable/5.4: [2e473351400e3dd66f0b71eddcef82ee45a584c1]

CVE-2022-48637: bnxt: prevent skb UAF after handing over to PTP worker

Announce: https://lore.kernel.org/linux-cve-announce/2024042855-CVE-2022-48637-d149@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 83bb623 ("bnxt_en: Transmit and retrieve packet
timestamps") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [c31f26c8f69f776759cbbdfb38e40ea91aa0dd65]
stable/5.15: [08483e4c0c83b221b8891434a04cec405dee94a6]

CVE-2022-48638: cgroup: cgroup_get_from_id() must check the looked-up
kn is a directory

Announce: https://lore.kernel.org/linux-cve-announce/2024042855-CVE-2022-48638-e1bd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6b658c4 ("scsi: cgroup: Add
cgroup_get_from_id()") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [df02452f3df069a59bc9e69c84435bf115cb6e37]
stable/5.15: [8484a356cee8ce3d6a8e6266ff99be326e9273ad]

CVE-2022-48639: net: sched: fix possible refcount leak in tc_new_tfilter()

Announce: https://lore.kernel.org/linux-cve-announce/2024042855-CVE-2022-48639-be80@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7d5509f ("net: sched: extend proto ops with 'put'
callback") in v5.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [c2e1cfefcac35e0eea229e148c8284088ce437b5]
stable/5.10: [8844c750eeb03452e2b3319c27a526f447b82596]
stable/5.15: [f8162aed962be8fa07445b2b5928e84ab40dd8d7]
stable/5.4: [903f7d322c17d8e306d766404b4604e81653902a]

CVE-2022-48640: bonding: fix NULL deref in bond_rr_gen_slave_id

Announce: https://lore.kernel.org/linux-cve-announce/2024042855-CVE-2022-48640-feee@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 848ca91 ("net: bonding: Use per-cpu
rr_tx_counter") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [0e400d602f46360752e4b32ce842dba3808e15e6]
stable/5.15: [ec3a6f4ffe556a28f6f5028bf7c4412557e7051b]

CVE-2022-48641: netfilter: ebtables: fix memory leak when blob is malformed

Announce: https://lore.kernel.org/linux-cve-announce/2024042856-CVE-2022-48641-531f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This bug was introduced by commit 7997eff8 ("netfilter: ebtables:
reject blobs that don't provide all entry points") in 6.0-rc3.
This commit was backported to older stable kernels except 4.4.
Fixed in 6.0-rc7.

Fixed status
mainline: [62ce44c4fff947eebdf10bb582267e686e6835c9]
stable/4.19: [1e98318af2f163eadaff815abcef38d27ca92c1e]
stable/5.10: [ebd97dbe3c55d68346b9c5fb00634a7f5b10bbee]
stable/5.15: [d5917b7af7cae0e2804f9d127a03268035098b7f]
stable/5.4: [11ebf32fde46572b0aaf3c2bdd97d923ef5a03ab]

CVE-2022-48642: netfilter: nf_tables: fix percpu memory leak at
nf_tables_addchain()

Announce: https://lore.kernel.org/linux-cve-announce/2024042856-CVE-2022-48642-b65b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3bc158f ("netfilter: nf_tables: map basechain
priority to hardware priority") in v5.3-rc6.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [9a4d6dd554b86e65581ef6b6638a39ae079b17ac]
stable/5.10: [b043a525a3f5520abb676a7cd8f6328fdf959e88]
stable/5.15: [08d7524f366a886b99b1630a24a27dd6e0d7f852]

CVE-2022-48643: netfilter: nf_tables: fix nft_counters_enabled
underflow at nf_tables_addchain()

Announce: https://lore.kernel.org/linux-cve-announce/2024042856-CVE-2022-48643-7d4b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This bug was introduced by commit 43eb8949 ("netfilter: nf_tables: do
not leave chain stats enabled on error") in Fixed in 6.0-rc3.
This commit was backported to 5.10 and 5.15.
Fixed in 6.0-rc7.

Fixed status
mainline: [921ebde3c0d22c8cba74ce8eb3cc4626abff1ccd]
stable/5.10: [710e3f526bd23a0d33435dedc52c3144de284378]
stable/5.15: [91aa52652f4b37089aff3cb53e83049d826fef6d]

CVE-2022-48644: net/sched: taprio: avoid disabling offload when it was
never enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024042856-CVE-2022-48644-757e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9c66d15 ("taprio: Add support for hardware
offloading") in v5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [db46e3a88a09c5cf7e505664d01da7238cd56c92]
stable/5.10: [586def6ebed195f3594a4884f7c5334d0e1ad1bb]
stable/5.15: [f58e43184226e5e9662088ccf1389e424a3a4cbd]
stable/5.4: [d12a1eb07003e597077329767c6aa86a7e972c76]

CVE-2022-48645: net: enetc: deny offload of tc-based TSN features on
VF interfaces

Announce: https://lore.kernel.org/linux-cve-announce/2024042857-CVE-2022-48645-2325@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 34c6adf ("enetc: Configure the Time-Aware
Scheduler via tc-taprio offload") in v5.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [5641c751fe2f92d3d9e8a8e03c1263ac8caa0b42]
stable/5.15: [510e703e4ed0e011db860bc21228aff48fc9eea7]

CVE-2022-48646: sfc/siena: fix null pointer dereference in efx_hard_start_xmit

Announce: https://lore.kernel.org/linux-cve-announce/2024042857-CVE-2022-48646-35f2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1280479 ("sfc: decouple TXQ type from label") in v5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [589c6eded10c77a12b7b2cf235b6b19a2bdb91fa]

CVE-2022-48647: sfc: fix TX channel offset when using legacy interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2024042857-CVE-2022-48647-4a4d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c308dfd ("sfc: fix wrong tx channel offset with
efx_separate_tx_channels") in v5.19-rc1.
This commit was backported to 5.10 and 5.15.
Fixed in v6.0-rc7.

Fixed status
mainline: [f232af4295653afa4ade3230462b3be15ad16419]
stable/5.10: [b4afd3878f961d3517f27b3213730fceef77945c]
stable/5.15: [360910b88d1466a90644a4e0533803b594344a2b]

CVE-2022-48648: sfc: fix null pointer dereference in efx_hard_start_xmit

Announce: https://lore.kernel.org/linux-cve-announce/2024042857-CVE-2022-48648-eaf8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1280479 ("sfc: decouple TXQ type from label") in v5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [0a242eb2913a4aa3d6fbdb86559f27628e9466f3]
stable/5.10: [b3b41d4d95d3822b2e459ecbc80d030ea6aec5e7]
stable/5.15: [8547c7bfc0617e7184e4da65b9b96681fcfe9998]

CVE-2022-48649: mm/slab_common: fix possible double free of kmem_cache

Announce: https://lore.kernel.org/linux-cve-announce/2024042858-CVE-2022-48649-82c3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0495e337b ("mm/slab_common: Deleting kobject in
kmem_cache_destroy() without holding slab_mutex/cpu_hotplug_lock") in
6.0-rc4.
This commit is not backported to older stable kernels.
Fixed in 6.0-rc7.

Fixed status
mainline: [d71608a877362becdc94191f190902fac1e64d35]

CVE-2022-48650: scsi: qla2xxx: Fix memory leak in __qlt_24xx_handle_abts()

Announce: https://lore.kernel.org/linux-cve-announce/2024042858-CVE-2022-48650-c4f0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8f394da ("scsi: qla2xxx: Drop
TARGET_SCF_LOOKUP_LUN_FROM_TAG") in v5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [601be20fc6a1b762044d2398befffd6bf236cebf]
stable/5.15: [89df49e561b4a8948521fc3f8a013012eaa08f82]

CVE-2022-48651: ipvlan: Fix out-of-bound bugs caused by unset skb->mac_header

Announce: https://lore.kernel.org/linux-cve-announce/2024042858-CVE-2022-48651-ac9e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2ad7bf3 ("ipvlan: Initial check-in of the IPVLAN
driver.") in v3.19-rc1.
Fixed in v6.0-rc7.

Fixed status
cip/4.4: [764ab4e0a887160281881a9496f3b2704f4450a0]
cip/4.4-rt: [764ab4e0a887160281881a9496f3b2704f4450a0]
cip/4.4-st: [764ab4e0a887160281881a9496f3b2704f4450a0]
mainline: [81225b2ea161af48e093f58e8dfee6d705b16af4]
stable/4.19: [bffcdade259c05ab3436b5fab711612093c275ef]
stable/5.10: [ab4a733874ead120691e8038272d22f8444d3638]
stable/5.15: [8d06006c7eb75587d986da46c48ba9274f94e8e7]
stable/5.4: [346e94aa4a99378592c46d6a34c72703a32bd5be]

CVE-2022-48652: ice: Fix crash by keep old cfg when update TCs more than queues

Announce: https://lore.kernel.org/linux-cve-announce/2024042858-CVE-2022-48652-438f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a632b2a ("ice: ethtool: Prohibit improper channel
config for DCB") in v5.19-rc4.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [a509702cac95a8b450228a037c8542f57e538e5b]

CVE-2022-48653: ice: Don't double unplug aux on peer initiated reset

Announce: https://lore.kernel.org/linux-cve-announce/2024042858-CVE-2022-48653-b6e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f9f5301 ("ice: Register auxiliary device to
provide RDMA") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [23c619190318376769ad7b61504c2ea0703fb783]
stable/5.15: [34447d64b8d28e4d6a73d73f07c879959d68fbfe]

CVE-2022-48654: netfilter: nfnetlink_osf: fix possible bogus match in
nf_osf_find()

Announce: https://lore.kernel.org/linux-cve-announce/2024042859-CVE-2022-48654-e107@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 22c7652 ("netfilter: nft_osf: Add version option
support") in v5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [559c36c5a8d730c49ef805a72b213d3bba155cc8]
stable/5.10: [5d75fef3e61e797fab5c3fbba88caa74ab92ad47]
stable/5.15: [816eab147e5c6f6621922b8515ad9010ceb1735e]
stable/5.4: [721ea8ac063d70c2078c4e762212705de6151764]

CVE-2022-48655: firmware: arm_scmi: Harden accesses to the reset domains

Announce: https://lore.kernel.org/linux-cve-announce/2024042859-CVE-2022-48655-5feb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc7.
It looks like this bug was introduced by commit 95a15d80 ("firmware:
arm_scmi: Add RESET protocol in SCMI v2.0") in 5.4-rc1.

Fixed status
mainline: [e9076ffbcaed5da6c182b144ef9f6e24554af268]
stable/5.15: [1f08a1b26cfc53b7715abc46857c6023bb1b87de]

CVE-2022-48656: dmaengine: ti: k3-udma-private: Fix refcount leak bug
in of_xudma_dev_get()

Announce: https://lore.kernel.org/linux-cve-announce/2024042859-CVE-2022-48656-1d7a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d702419 ("dmaengine: ti: k3-udma: Add glue layer
for non DMAengine users") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [f9fdb0b86f087c2b7f6c6168dd0985a3c1eda87e]
stable/5.10: [aa11dae059a439af82bae541b134f8f53ac177b5]
stable/5.15: [dd5a6c5a08752b613e83ad2cb5133e72a64b876d]

CVE-2022-48657: arm64: topology: fix possible overflow in amu_fie_setup()

Announce: https://lore.kernel.org/linux-cve-announce/2024042859-CVE-2022-48657-d23e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cd0ed03 ("arm64: use activity monitors for
frequency invariance") in v5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [d4955c0ad77dbc684fc716387070ac24801b8bca]
stable/5.10: [904f881b57360cf85de962d84d8614d94431f60e]
stable/5.15: [3c3edb82d67b2be9231174ac2af4af60d4af7549]

CVE-2022-48658: mm: slub: fix flush_cpu_slab()/__free_slab()
invocations in task context.

Announce: https://lore.kernel.org/linux-cve-announce/2024042800-CVE-2022-48658-4c9c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5a836bf ("mm: slub: move flush_cpu_slab()
invocations __free_slab() invocations out of IRQ context") in
v5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [e45cc288724f0cfd497bb5920bcfa60caa335729]
stable/5.15: [61703b248be993eb4997b00ae5d3318e6d8f3c5b]

CVE-2022-48659: mm/slub: fix to return errno if kmalloc() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024042800-CVE-2022-48659-8ccb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81819f0 ("SLUB core") in v2.6.22-rc1.
Fixed in v6.0-rc7.

Fixed status
cip/4.4: [e5377a5cc97a1a8d6357b42aafa06e2713930828]
cip/4.4-rt: [e5377a5cc97a1a8d6357b42aafa06e2713930828]
cip/4.4-st: [e5377a5cc97a1a8d6357b42aafa06e2713930828]
mainline: [7e9c323c52b379d261a72dc7bd38120a761a93cd]
stable/4.19: [e996821717c5cf8aa1e1abdb6b3d900a231e3755]
stable/5.10: [379ac7905ff3f0a6a4e507d3e9f710ec4fab9124]
stable/5.15: [2d6e55e0c03804e1e227b80a5746e086d6c6696c]
stable/5.4: [016b150992eebc32c4a18f783cf2bb6e2545a3d9]

CVE-2022-48660: gpiolib: cdev: Set lineevent_state::irq after IRQ
register successfully

Announce: https://lore.kernel.org/linux-cve-announce/2024042800-CVE-2022-48660-4fb8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4682427 ("gpiolib: cdev: refactor lineevent
cleanup into lineevent_free") in v5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [69bef19d6b9700e96285f4b4e28691cda3dcd0d1]
stable/5.10: [657803b918e097e47d99d1489da83a603c36bcdd]
stable/5.15: [97da736cd11ae73bdf2f5e21e24446b8349e0168]

CVE-2022-48661: gpio: mockup: Fix potential resource leakage when
register a chip

Announce: https://lore.kernel.org/linux-cve-announce/2024042800-CVE-2022-48661-1b6c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6fda593 ("gpio: mockup: Convert to use software
nodes") in v5.15-rc6.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [02743c4091ccfb246f5cdbbe3f44b152d5d12933]
stable/5.15: [9b26723e058faaf11b532fb4aa16d6849d581790]

CVE-2022-48662: drm/i915/gem: Really move i915_gem_context.link under
ref protection

Announce: https://lore.kernel.org/linux-cve-announce/2024042801-CVE-2022-48662-3a84@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f8246cf ("drm/i915/gem: Drop free_work for GEM
contexts") in v5.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [d119888b09bd567e07c6b93a07f175df88857e02]
stable/5.15: [713fa3e4591f65f804bdc88e8648e219fabc9ee1]

CVE-2022-48663: gpio: mockup: fix NULL pointer dereference when removing debugfs

Announce: https://lore.kernel.org/linux-cve-announce/2024042801-CVE-2022-48663-397d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 303e6da ("gpio: mockup: remove gpio debugfs when
remove device") in 6.0-rc4.
This commit was backported to 5.10 and 5.15.
Fixed in 6.0-rc7.

Fixed status
mainline: [b7df41a6f79dfb18ba2203f8c5f0e9c0b9b57f68]
stable/5.10: [bdea98b98f844bd8a983ca880893e509a8b4162f]
stable/5.15: [18352095a0d581f6aeb1e9fc9d68cc0152cd64b4]

CVE-2022-48664: btrfs: fix hang during unmount when stopping a space
reclaim worker

Announce: https://lore.kernel.org/linux-cve-announce/2024042801-CVE-2022-48664-d281@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d6fd0ae ("Btrfs: fix missing delayed iputs on
unmount") in v4.20-rc2.
This commit was backported to 4.19.
Fixed in v6.0-rc7.

Fixed status
mainline: [a362bb864b8db4861977d00bd2c3222503ccc34b]
stable/5.10: [6ac5b52e3f352f9cb270c89e6e1d4dadb564ddb8]
stable/5.15: [d8a76a2e514fbbb315a6dfff2d342de2de833994]

CVE-2022-48665: exfat: fix overflow for large capacity partition

Announce: https://lore.kernel.org/linux-cve-announce/2024042801-CVE-2022-48665-527d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1b61383 ("exfat: reduce block requests when
zeroing a cluster") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc7.

Fixed status
mainline: [2e9ceb6728f1dc2fa4b5d08f37d88cbc49a20a62]

CVE-2022-48666: scsi: core: Fix a use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024042801-CVE-2022-48666-4916@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 65ca846 ("scsi: core: Introduce
{init,exit}_cmd_priv()") in v5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc5.

Fixed status
mainline: [8fe4ce5836e932f5766317cb651c1ff2a4cd0506]

CVE-2022-48667: smb3: fix temporary data corruption in insert range

Announce: https://lore.kernel.org/linux-cve-announce/2024042802-CVE-2022-48667-0aa2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7fe6fe9 ("cifs: add FALLOC_FL_INSERT_RANGE
support") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc4.

Fixed status
mainline: [9c8b7a293f50253e694f19161c045817a938e551]

CVE-2022-48668: smb3: fix temporary data corruption in collapse range

Announce: https://lore.kernel.org/linux-cve-announce/2024042802-CVE-2022-48668-3790@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5476b5d ("cifs: add support for
FALLOC_FL_COLLAPSE_RANGE") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.0-rc4.

Fixed status
mainline: [fa30a81f255a56cccd89552cd6ce7ea6e8d8acc4]

CVE-2024-26927: ASoC: SOF: Add some bounds checking to firmware data

Announce: https://lore.kernel.org/linux-cve-announce/2024042844-CVE-2024-26927-3374@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d2458ba ("ASoC: SOF: ipc3-loader: Implement
firmware parsing and loading") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [98f681b0f84cfc3a1d83287b77697679e0398306]
stable/6.1: [d133d67e7e724102d1e53009c4f88afaaf3e167c]
stable/6.6: [ced7df8b3c5c4751244cad79011e86cf1f809153]
stable/6.8: [9eeb8e1231f6450c574c1db979122e171a1813ab]

CVE-2024-26928: smb: client: fix potential UAF in cifs_debug_files_proc_show()

Announce: https://lore.kernel.org/linux-cve-announce/2024042849-CVE-2024-26928-e543@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc3.
It looks as if commit dfe33f9abc ("smb3: allow more detailed protocol
info on open files for debugging") in 4.20-rc1 is first introduced
commit.
This commit added cifs_debug_files_proc_show().

Fixed status
mainline: [ca545b7f0823f19db0f1148d59bc5e1a56634502]
stable/6.1: [229042314602db62559ecacba127067c22ee7b88]
stable/6.6: [a65f2b56334ba4dc30bd5ee9ce5b2691b973344d]
stable/6.8: [3402faf78b2516b0af1259baff50cc8453ef0bd1]

CVE-2022-48669: powerpc/pseries: Fix potential memleak in papr_get_attr()

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2022-48669-15cf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3c14b73 ("powerpc/pseries: Interface to represent
PAPR firmware attributes") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [cda9c0d556283e2d4adaa9960b2dc19b16156bae]
stable/6.1: [a3f22feb2220a945d1c3282e34199e8bcdc5afc4]
stable/6.6: [1699fb915b9f61794d559b55114c09a390aaf234]
stable/6.8: [d0647c3e81eff62b66d46fd4e475318cb8cb3610]

CVE-2023-52647: media: nxp: imx8-isi: Check whether crossbar pad is
non-NULL before access

Announce: https://lore.kernel.org/linux-cve-announce/2024050119-CVE-2023-52647-82e4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cf21f32 ("media: nxp: Add i.MX8 ISI driver") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [eb2f932100288dbb881eadfed02e1459c6b9504c]
stable/6.6: [c95318607fbe8fdd44991a8dad2e44118e6b8812]
stable/6.8: [91c8ce42fcde09f1da24acab9013b3e19cb88a4e]

CVE-2023-52648: drm/vmwgfx: Unmap the surface before resetting it on a
plane state

Announce: https://lore.kernel.org/linux-cve-announce/2024050122-CVE-2023-52648-4e0d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 485d98d ("drm/vmwgfx: Add support for CursorMob
and CursorBypass 4") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [27571c64f1855881753e6f33c3186573afbab7ba]
stable/6.6: [0a23f95af7f28dae7c0f7c82578ca5e1a239d461]
stable/6.8: [75baad63c033b3b900d822bffbc96c9d3649bc75]

CVE-2023-52649: drm/vkms: Avoid reading beyond LUT array

Announce: https://lore.kernel.org/linux-cve-announce/2024050109-CVE-2023-52649-4614@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit db1f254 ("drm/vkms: Add support to 1D gamma LUT")
in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [2fee84030d12d9fddfa874e4562d71761a129277]
stable/6.6: [9556c167673057d48ce4a0da675026fe046654c1]
stable/6.8: [92800aaeff51b8358d1e0a7eb74daf8aa2d7ce9d]

CVE-2023-52650: drm/tegra: dsi: Add missing check for of_find_device_by_node

Announce: https://lore.kernel.org/linux-cve-announce/2024050109-CVE-2023-52650-e2d1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e94236c ("drm/tegra: dsi: Add ganged mode
support") in v3.19-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [a51b1e781aff4fae622e1c1d24d6ae3391e06a97]
cip/4.4-st: [a51b1e781aff4fae622e1c1d24d6ae3391e06a97]
mainline: [afe6fcb9775882230cd29b529203eabd5d2a638d]
stable/4.19: [47a13d0b9d8527518639ab5c39667f69d6203e80]
stable/5.10: [92003981a6df5dc84af8a5904f8ee112fa324129]
stable/5.15: [93128052bf832359531c3c0a9e3567b2b8682a2d]
stable/5.4: [f05631a8525c3b5e5994ecb1304d2d878956c0f5]
stable/6.1: [50c0ad785a780c72a2fdaba10b38c645ffb4eae6]
stable/6.6: [52aa507148c4aad41436e2005d742ffcafad9976]
stable/6.8: [3169eaf1365541fd8e521091010c44fbe14691fc]

CVE-2023-52651: wifi: ath10k: fix NULL pointer dereference in
ath10k_wmi_tlv_op_pull_mgmt_tx_compl_ev()

Announce: https://lore.kernel.org/linux-cve-announce/2024050110-CVE-2023-52651-5907@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dc40515 ("ath10k: handle mgmt tx completion
event") in v4.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [ad25ee36f00172f7d53242dc77c69fff7ced0755]
stable/4.19: [0cd3b0a1dc987697cba1fe93c784365aa1f8a230]
stable/5.10: [e1dc7aa814a95aeeb1b2c05be2b62af8423b15cc]
stable/5.15: [4c4e592266b6eec748ce90e82bd9cbc9838f3633]
stable/5.4: [88a9dffaec779504ab3680d33cf677741c029420]
stable/6.1: [90f089d77e38db1c48629f111f3c8c336be1bc38]
stable/6.6: [10a342fa2fe4c4dd22f2c8fe917d3b1929582076]
stable/6.8: [835c5d37f4b0ba99e9ec285ffa645bc532714191]

CVE-2023-52652: NTB: fix possible name leak in ntb_register_device()

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2023-52652-9e84@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a1bd3ba ("NTB: Add NTB hardware abstraction
layer") in v4.2-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [aebfdfe39b9327a3077d0df8db3beb3160c9bdd0]
stable/5.15: [a62b9f3d7bbfac874cc0c638bc1776dcf1f8ec06]
stable/6.1: [6632a54ac8057cc0b0d789c6f73883e871bcd25c]
stable/6.6: [a039690d323221eb5865f1f31db3ec264e7a14b6]
stable/6.8: [913421f9f7fd8324dcc41753d0f28b52e177ef04]

CVE-2023-52653: SUNRPC: fix a memleak in gss_import_v2_context

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2023-52653-a5c2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 47d8480 ("gss_krb5: handle new context format
from gssd") in v2.6.35-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [e67b652d8e8591d3b1e569dbcdfcee15993e91fa]
stable/6.6: [99044c01ed5329e73651c054d8a4baacdbb1a27c]
stable/6.8: [d111e30d9cd846bb368faf3637dc0f71fcbcf822]

CVE-2024-26929: scsi: qla2xxx: Fix double free of fcport

Announce: https://lore.kernel.org/linux-cve-announce/2024050122-CVE-2024-26929-07f0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.
The qla2x00_els_dcmd_sp_free(), qla24xx_els_dcmd_iocb(), and
qla24xx_els_dcmd_iocb() were
introduced by commit 6eb54715 ("qla2xxx: Added interface to send
explicit LOGO.") in 4.5-rc1 so Linux 4.4 is not affected.
Other stable kernels might be affected.

Fixed status
mainline: [82f522ae0d97119a43da53e0f729275691b9c525]
stable/5.15: [b03e626bd6d3f0684f56ee1890d70fc9ca991c04]
stable/6.1: [282877633b25d67021a34169c5b5519b1d4ef65e]
stable/6.6: [f85af9f1aa5e2f53694a6cbe72010f754b5ff862]
stable/6.8: [846fb9f112f618ec6ae181d8dae7961652574774]

CVE-2024-26930: scsi: qla2xxx: Fix double free of the ha->vp_map pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024050122-CVE-2024-26930-4f3e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.
The fail_free_vp_map label was introduced by commit 430eef0 ("scsi:
qla2xxx: Relocate/rename vp map") in 6.3-rc1.

Fixed status
mainline: [e288285d47784fdcf7c81be56df7d65c6f10c58b]
stable/6.6: [f14cee7a882cb79528f17a2335f53e9fd1848467]
stable/6.8: [825d63164a2e6bacb059a9afb5605425b485413f]

CVE-2024-26931: scsi: qla2xxx: Fix command flush on cable pull

Announce: https://lore.kernel.org/linux-cve-announce/2024050123-CVE-2024-26931-01d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.

Fixed status
mainline: [a27d4d0e7de305def8a5098a614053be208d1aa1]
stable/4.19: [b73377124f56d2fec154737c2f8d2e839c237d5a]
stable/5.10: [67b2d35853c2da25a8ca1c4190a5e96d3083c2ac]
stable/5.15: [a859f6a8f4234b8ef62862bf7a92f1af5f8cd47a]
stable/5.4: [d7a68eee87b05d4e29419e6f151aef99314970a9]
stable/6.1: [09c0ac18cac206ed1218b1fe6c1a0918e5ea9211]
stable/6.6: [8de1584ec4fe0ebea33c273036e7e0a05e65c81d]
stable/6.8: [ec7587eef003cab15a13446d67c3adb88146a150]

CVE-2024-26932: usb: typec: tcpm: fix double-free issue in
tcpm_port_unregister_pd()

Announce: https://lore.kernel.org/linux-cve-announce/2024050123-CVE-2024-26932-587d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cd099cd ("usb: typec: tcpm: Support multiple
capabilities") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [b63f90487bdf93a4223ce7853d14717e9d452856]
stable/6.8: [242e425ed580b2f4dbcb86c8fc03a410a4084a69]

CVE-2024-26933: USB: core: Fix deadlock in port "disable" sysfs attribute

Announce: https://lore.kernel.org/linux-cve-announce/2024050123-CVE-2024-26933-c18d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.
Vulnerable functions were introduced by commit f061f43d ("usb: hub:
port: add sysfs entry to switch port power") in 6.0-rc1.
This commit is not backported to older stable kernels.

Fixed status
mainline: [f4d1960764d8a70318b02f15203a1be2b2554ca1]
stable/6.1: [9dac54f08198147f5ec0ec52fcf1bc8ac899ac05]
stable/6.6: [f51849833705dea5b4f9b0c8de714dd87bd6c95c]
stable/6.8: [73d1589b91f2099e5f6534a8497b7c6b527e064e]

CVE-2024-26934: USB: core: Fix deadlock in usb_deauthorize_interface()

Announce: https://lore.kernel.org/linux-cve-announce/2024050123-CVE-2024-26934-e2fc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 310d2b4 ("usb: interface authorization: SysFS
part of USB interface authorization") in v4.4-rc1.
Fixed in v6.9-rc2.

Fixed status
mainline: [80ba43e9f799cbdd83842fc27db667289b3150f5]
stable/4.19: [8cbdd324b41528994027128207fae8100dff094f]
stable/5.10: [e451709573f8be904a8a72d0775bf114d7c291d9]
stable/5.15: [1b175bc579f46520b11ecda443bcd2ee4904f66a]
stable/5.4: [12d6a5681a0a5cecc2af7860f0a1613fa7c6e947]
stable/6.1: [ab062fa3dc69aea88fe62162c5881ba14b50ecc5]
stable/6.6: [122a06f1068bf5e39089863f4f60b1f5d4273384]
stable/6.8: [07acf979da33c721357ff27129edf74c23c036c6]

CVE-2024-26935: scsi: core: Fix unremoved procfs host directory regression

Announce: https://lore.kernel.org/linux-cve-announce/2024050124-CVE-2024-26935-8b4e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit be03df3 ("scsi: core: Fix a procfs host directory
removal regression") in v6.3-rc3.
This commitwas backported to 5.10, 5.15, 5.4, and 6.1. So 4.x is not affected.
Fixed in v6.9-rc2.

Fixed status
mainline: [f23a4d6e07570826fe95023ca1aa96a011fa9f84]
stable/5.10: [5c2386ba80e779a92ec3bb64ccadbedd88f779b1]
stable/5.15: [cea234bb214b17d004dfdccce4491e6ff57c96ee]
stable/5.4: [0053f15d50d50c9312d8ab9c11e2e405812dfcac]
stable/6.1: [3678cf67ff7136db1dd3bf63c361650db5d92889]
stable/6.6: [d4c34782b6d7b1e68d18d9549451b19433bd4c6c]
stable/6.8: [f4ff08fab66eb5c0b97e1a24edac052fb40bf5d7]

CVE-2024-26936: ksmbd: validate request buffer size in smb2_allocate_rsp_buf()

Announce: https://lore.kernel.org/linux-cve-announce/2024050141-CVE-2024-26936-0264@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc6.
The ksmbd was introduced in 5.10 so prior to 5.15 kernels aren't affected.

Fixed status
mainline: [17cf0c2794bdb6f39671265aa18aea5c22ee8c4a]
stable/6.1: [21ff9d7d223c5c19cb4334009e4c0c83a2f4d674]
stable/6.6: [5c20b242d4fed73a93591e48bfd9772e2322fb11]
stable/6.8: [2c27a64a2bc47d9bfc7c3cf8be14be53b1ee7cb6]

CVE-2024-26937: drm/i915/gt: Reset queue_priority_hint on parking

Announce: https://lore.kernel.org/linux-cve-announce/2024050124-CVE-2024-26937-3d21@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 22b7a42 ("drm/i915/execlists: Preempt-to-busy")
in v5.4-rc1.
Thic commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [4a3859ea5240365d21f6053ee219bb240d520895]
stable/5.10: [fe34587acc995e7b1d7a5d3444a0736721ec32b3]
stable/5.15: [ac9b6b3e8d1237136c8ebf0fa1ce037dd7e2948f]
stable/5.4: [67944e6db656bf1e986aa2a359f866f851091f8a]
stable/6.1: [7eab7b021835ae422c38b968d5cc60e99408fb62]
stable/6.6: [3b031e4fcb2740988143c303f81f69f18ce86325]
stable/6.8: [8fd9b0ce8c26533fe4d5d15ea15bbf7b904b611c]

CVE-2024-26938: drm/i915/bios: Tolerate devdata==NULL in
intel_bios_encoder_supports_dp_dual_mode()

Announce: https://lore.kernel.org/linux-cve-announce/2024050124-CVE-2024-26938-b3f9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.
It seems to be commit 044cbc7 ("drm/i915/bios: Nuke
DEVICE_TYPE_DP_DUAL_MODE_BITS") in 5.18-rc1 is suspicious.

Fixed status
mainline: [32e39bab59934bfd3f37097d4dd85ac5eb0fd549]
stable/6.1: [72e4d3fb72e9f0f016946158a7d95304832768e6]
stable/6.6: [a891add409e3bc381f4f68c2ce9d953f1865cb1f]
stable/6.8: [94cf2fb6feccd625e5b4e23e1b70f39a206f82ac]

CVE-2024-26939: drm/i915/vma: Fix UAF on destroy against retire race

Announce: https://lore.kernel.org/linux-cve-announce/2024050124-CVE-2024-26939-5314@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d939397 ("drm/i915: Remove the vma refcount") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [0e45882ca829b26b915162e8e86dbb1095768e9e]
stable/6.1: [704edc9252f4988ae1ad7dafa23d0db8d90d7190]
stable/6.6: [5e3eb862df9f972ab677fb19e0d4b9b1be8db7b5]
stable/6.8: [59b2626dd8c8a2e13f18054b3530e0c00073d79f]

CVE-2024-26940: drm/vmwgfx: Create debugfs ttm_resource_manager entry
only if needed

Announce: https://lore.kernel.org/linux-cve-announce/2024050125-CVE-2024-26940-1785@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit af4a25b ("drm/vmwgfx: Add debugfs entries for
various ttm resource managers") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [4be9075fec0a639384ed19975634b662bfab938f]
stable/6.1: [016119154981d81c9e8f2ea3f56b9e2b4ea14500]
stable/6.6: [042ef0afc40fa1a22b3608f22915b91ce39d128f]
stable/6.8: [eb08db0fc5354fa17b7ed66dab3c503332423451]

CVE-2024-26941: drm/dp: Fix divide-by-zero regression on DP MST unplug
with nouveau

Announce: https://lore.kernel.org/linux-cve-announce/2024050125-CVE-2024-26941-7c68@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c1d6a22 ("drm/dp: Add helpers to calculate the
link BW overhead") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [9cbd1dae842737bfafa4b10a87909fa209dde250]
stable/6.8: [828862071a6ca0c52655e6e62ac7abfef3e5c578]

CVE-2024-26942: net: phy: qcom: at803x: fix kernel panic with at8031_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024050125-CVE-2024-26942-2f72@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 25d2ba9 ("net: phy: at803x: move specific at8031
probe mode check to dedicated probe") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [6a4aee277740d04ac0fd54cfa17cc28261932ddc]
stable/6.8: [a8a296ad9957b845b89bcf48be1cf8c74875ecc3]

CVE-2024-26943: nouveau/dmem: handle kcalloc() allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024050125-CVE-2024-26943-9ea5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2498812 ("nouveau/dmem: evict device private
memory during release") in v6.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [16e87fe23d4af6df920406494ced5c0f4354567b]
stable/6.1: [9acfd8b083a0ffbd387566800d89f55058a68af2]
stable/6.6: [2a84744a037b8a511d6a9055f3defddc28ff4a4d]
stable/6.8: [3e82f7383e0b82a835e6b6b06a348b2bc4e2c2ee]

CVE-2024-26944: btrfs: zoned: fix use-after-free in do_zone_finish()

Announce: https://lore.kernel.org/linux-cve-announce/2024050125-CVE-2024-26944-598c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.

Fixed status
mainline: [1ec17ef59168a1a6f1105f5dc517f783839a5302]
stable/6.8: [34ca809e055eca5cfe63d9c7efbf80b7c21b4e57]

CVE-2024-26945: crypto: iaa - Fix nr_cpus < nr_iaa case

Announce: https://lore.kernel.org/linux-cve-announce/2024050126-CVE-2024-26945-bf47@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc2.
It looks as if commit f57bf3f7 ("crypto: iaa - Add per-cpu workqueue
table with rebalancing") in 6.8-rc1 introduced this bug.

Fixed status
mainline: [5a7e89d3315d1be86aff8a8bf849023cda6547f7]
stable/6.8: [a5ca1be7f9817de4e93085778b3ee2219bdc2664]

CVE-2024-26946: kprobes/x86: Use copy_from_kernel_nofault() to read
from unsafe address

Announce: https://lore.kernel.org/linux-cve-announce/2024050126-CVE-2024-26946-ad5d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cc66bb9 ("x86/ibt,kprobes: Cure sym+0 equals
fentry woes") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [4e51653d5d871f40f1bd5cf95cc7f2d8b33d063b]
stable/6.1: [6417684315087904fffe8966d27ca74398c57dd6]
stable/6.6: [f13edd1871d4fb4ab829aff629d47914e251bae3]
stable/6.8: [b69f577308f1070004cafac106dd1a44099e5483]

CVE-2024-26947: ARM: 9359/1: flush: check if the folio is reserved for
no-mapping addresses

Announce: https://lore.kernel.org/linux-cve-announce/2024050126-CVE-2024-26947-c9b8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a4d5613 ("arm: extend pfn_valid to take into
account freed memory map alignment") in v5.14-rc1.
This commit was backported to 5.10 and 5.4. Linux 4.x is not affected.
Fixed in v6.9-rc1.

Fixed status
mainline: [0c66c6f4e21cb22220cbd8821c5c73fc157d20dc]
stable/6.6: [0c027c2bad7f5111c51a358b5d392e1a695dabff]
stable/6.8: [fb3a122a978626b33de3367ee1762da934c0f512]

CVE-2024-26948: drm/amd/display: Add a dc_state NULL check in dc_state_release

Announce: https://lore.kernel.org/linux-cve-announce/2024050126-CVE-2024-26948-43bb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It looks as if commit 09a4ec5da ("drm/amd/display: Refactor dc_state
interface") in 6.8-rc1 was introduced this bug.

Fixed status
mainline: [334b56cea5d9df5989be6cf1a5898114fa70ad98]
stable/6.8: [d37a08f840485995e3fb91dad95e441b9d28a269]

CVE-2024-26949: drm/amdgpu/pm: Fix NULL pointer dereference when get power limit

Announce: https://lore.kernel.org/linux-cve-announce/2024050127-CVE-2024-26949-cf74@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7968e97 ("drm/amdgpu/pm: Fix the power1_min_cap
value") in v6.8-rc7.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [08ae9ef829b8055c2fdc8cfee37510c1f4721a07]
stable/6.8: [b8eaa8ef1f1157a9f330e36e66bdd7a693309948]

CVE-2024-26950: wireguard: netlink: access device through ctx instead of peer

Announce: https://lore.kernel.org/linux-cve-announce/2024050127-CVE-2024-26950-4424@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e7096c1 ("net: WireGuard secure network tunnel")
in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [71cbd32e3db82ea4a74e3ef9aeeaa6971969c86f]
stable/5.10: [493aa6bdcffd90a4f82aa614fe4f4db0641b4068]
stable/5.15: [4be453271a882c8ebc28df3dbf9e4d95e6ac42f5]
stable/6.1: [09c3fa70f65175861ca948cb2f0f791e666c90e5]
stable/6.6: [c991567e6c638079304cc15dff28748e4a3c4a37]
stable/6.8: [d44bd323d8bb8031eef4bdc44547925998a11e47]

CVE-2024-26951: wireguard: netlink: check for dangling peer via
is_dead instead of empty list

Announce: https://lore.kernel.org/linux-cve-announce/2024050127-CVE-2024-26951-5cbe@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e7096c1 ("net: WireGuard secure network tunnel")
in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [55b6c738673871c9b0edae05d0c97995c1ff08c4]
stable/5.10: [f52be46e3e6ecefc2539119784324f0cbc09620a]
stable/5.15: [710a177f347282eea162aec8712beb1f42d5ad87]
stable/6.1: [b7cea3a9af0853fdbb1b16633a458f991dde6aac]
stable/6.6: [13d107794304306164481d31ce33f8fdb25a9c04]
stable/6.8: [302b2dfc013baca3dea7ceda383930d9297d231d]

CVE-2024-26952: ksmbd: fix potencial out-of-bounds when buffer offset is invalid

Announce: https://lore.kernel.org/linux-cve-announce/2024050127-CVE-2024-26952-7f65@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It looks as if this bug was introduced by commit e2f34481b ("cifsd:
add server-side procedures for SMB3") in 5.15-rc1.

Fixed status
mainline: [c6cd2e8d2d9aa7ee35b1fa6a668e32a22a9753da]
stable/6.8: [0c5541b4c980626fa3cab16ba1a451757778bbb5]

CVE-2024-26953: net: esp: fix bad handling of pages from page_pool

Announce: https://lore.kernel.org/linux-cve-announce/2024050128-CVE-2024-26953-8304@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6a5bcd8 ("page_pool: Allow drivers to hint on SKB
recycling") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [c3198822c6cb9fb588e446540485669cc81c5d34]
stable/6.6: [8291b4eac429c480386669444c6377573f5d8664]
stable/6.8: [f278ff9db67264715d0d50e3e75044f8b78990f4]

CVE-2024-26954: ksmbd: fix slab-out-of-bounds in smb_strndup_from_utf16()

Announce: https://lore.kernel.org/linux-cve-announce/2024050128-CVE-2024-26954-18d5@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It looks as if commit d10c7787 ("ksmbd: fix slab-out-of-bounds in
smb_strndup_from_utf16()") in 6.7-rc8 introduced this bug.
This commit was backported to 5.15, 6.1, and 6.6.

Fixed status
mainline: [a80a486d72e20bd12c335bcd38b6e6f19356b0aa]
stable/6.8: [4f97e6a9d62cb1fce82fbf4baff44b83221bc178]

CVE-2024-26955: nilfs2: prevent kernel bug at submit_bh_wbc()

Announce: https://lore.kernel.org/linux-cve-announce/2024050128-CVE-2024-26955-3205@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1f5abe7 ("nilfs2: replace BUG_ON and BUG calls
triggerable from ioctl") in v2.6.30-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [000f2bf0e2d314ae3c76a4f8f845b3056d6374ca]
cip/4.4-st: [000f2bf0e2d314ae3c76a4f8f845b3056d6374ca]
mainline: [269cdf353b5bdd15f1a079671b0f889113865f20]
stable/4.19: [91e4c4595fae5e87069e44687ae879091783c183]
stable/5.10: [f0fe7ad5aff4f0fcf988913313c497de85f1e186]
stable/5.15: [ca581d237f3b8539c044205bb003de71d75d227c]
stable/5.4: [32eaee72e96590a75445c8a6c7c1057673b47e07]
stable/6.1: [192e9f9078c96be30b31c4b44d6294b24520fce5]
stable/6.6: [0c8aa4cfda4e4adb15d5b6536d155eca9c9cd44c]
stable/6.8: [76ffbe911e2798c7296968f5fd72f7bf67207a8d]

CVE-2024-26956: nilfs2: fix failure to detect DAT corruption in btree
and direct mappings

Announce: https://lore.kernel.org/linux-cve-announce/2024050128-CVE-2024-26956-94b7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c3a7abf ("nilfs2: support contiguous lookup of
blocks") in v2.6.31-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [bde10c01a7966debaaba115700bc3de40d3d40ef]
cip/4.4-st: [bde10c01a7966debaaba115700bc3de40d3d40ef]
mainline: [f2f26b4a84a0ef41791bd2d70861c8eac748f4ba]
stable/4.19: [b67189690eb4b7ecc84ae16fa1e880e0123eaa35]
stable/5.10: [c3b5c5c31e723b568f83d8cafab8629d9d830ffb]
stable/5.15: [2e2619ff5d0def4bb6c2037a32a6eaa28dd95c84]
stable/5.4: [9cbe1ad5f4354f4df1445e5f4883983328cd6d8e]
stable/6.1: [46b832e09d43b394ac0f6d9485d2b1a06593f0b7]
stable/6.6: [f69e81396aea66304d214f175aa371f1b5578862]
stable/6.8: [82827ca21e7c8a91384c5baa656f78a5adfa4ab4]

CVE-2024-26957: s390/zcrypt: fix reference counting on zcrypt card objects

Announce: https://lore.kernel.org/linux-cve-announce/2024050129-CVE-2024-26957-9e6b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
The zcrypt_pick_queue() was introduced by commit e28d2af
("s390/zcrypt: add multi domain support") in 4.10-rc1.

Fixed status
mainline: [50ed48c80fecbe17218afed4f8bed005c802976c]
stable/4.19: [7e500849fa558879a1cde43f80c7c048c2437058]
stable/5.10: [6470078ab3d8f222115e11c4ec67351f3031b3dd]
stable/5.15: [a55677878b93e9ebc31f66d0e2fb93be5e7836a6]
stable/5.4: [9daddee03de3f231012014dab8ab2b277a116a55]
stable/6.1: [b7f6c3630eb3f103115ab0d7613588064f665d0d]
stable/6.6: [a64ab862e84e3e698cd351a87cdb504c7fc575ca]
stable/6.8: [394b6d8bbdf9ddee6d5bcf3e1f3e9f23eecd6484]

CVE-2024-26958: nfs: fix UAF in direct writes

Announce: https://lore.kernel.org/linux-cve-announce/2024050129-CVE-2024-26958-6c15@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It looks all stable kernels are affected. However, nfs_commit_begin()
and nfs_commit_end() are introduced
by commit af7cf0579 ("NFS: Allow multiple commit requests in flight
per file") in 4.5-rc1.
So, backporting this fix to 4.4 also needs backport commit af7cf0579 too.

Fixed status
mainline: [17f46b803d4f23c66cacce81db35fef3adb8f2af]
stable/5.10: [4595d90b5d2ea5fa4d318d13f59055aa4bf3e7f5]
stable/5.15: [80d24b308b7ee7037fc90d8ac99f6f78df0a256f]
stable/6.1: [3abc2d160ed8213948b147295d77d44a22c88fa3]
stable/6.6: [e25447c35f8745337ea8bc0c9697fcac14df8605]
stable/6.8: [cf54f66e1dd78990ec6b32177bca7e6ea2144a95]

CVE-2024-26959: Bluetooth: btnxpuart: Fix btnxpuart_close

Announce: https://lore.kernel.org/linux-cve-announce/2024050129-CVE-2024-26959-cbbc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 689ca16 ("Bluetooth: NXP: Add protocol support
for NXP Bluetooth chipsets") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [664130c0b0309b360bc5bdd40a30604a9387bde8]
stable/6.6: [d4e2365b07f1ae1f811a915b514caef5b2d6581e]
stable/6.8: [74bcf708775c405f7fb6ed776ccd3e1957f38a52]

CVE-2024-26960: mm: swap: fix race between free_swap_and_cache() and swapoff()

Announce: https://lore.kernel.org/linux-cve-announce/2024050129-CVE-2024-26960-ad6b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7c00baf ("mm/swap: free swap slots in batch") in v4.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [82b1c07a0af603e3c47b906c8e991dc96f01688e]
stable/5.10: [d85c11c97ecf92d47a4b29e3faca714dc1f18d0d]
stable/5.15: [2da5568ee222ce0541bfe446a07998f92ed1643e]
stable/6.1: [1ede7f1d7eed1738d1b9333fd1e152ccb450b86a]
stable/6.6: [0f98f6d2fb5fad00f8299b84b85b6bc1b6d7d19a]
stable/6.8: [363d17e7f7907c8e27a9e86968af0eaa2301787b]

CVE-2024-26961: mac802154: fix llsec key resources release in
mac802154_llsec_key_del

Announce: https://lore.kernel.org/linux-cve-announce/2024050129-CVE-2024-26961-408d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5d637d5 ("mac802154: add llsec structures and
mutators") in v3.16-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [e8a1e58345cf40b7b272e08ac7b32328b2543e40]
stable/5.10: [068ab2759bc0b4daf0b964de61b2731449c86531]
stable/5.15: [d3d858650933d44ac12c1f31337e7110c2071821]
stable/6.1: [dcd51ab42b7a0431575689c5f74b8b6efd45fc2f]
stable/6.6: [20d3e1c8a1847497269f04d874b2a5818ec29e2d]
stable/6.8: [49c8951680d7b76fceaee89dcfbab1363fb24fd1]

CVE-2024-26962: dm-raid456, md/raid456: fix a deadlock for dm-raid456
while io concurrent with reshape

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-26962-cbb0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc1.
It seems as if commit c467e97 (" md/raid6: use valid sector values to
determine if an I/O should wait on the reshape") in 6.7-rc5 introduced
this bug.
This commit was backported to 6.1 and 6.8.

Fixed status
mainline: [41425f96d7aa59bc865f60f5dda3d7697b555677]
stable/6.8: [a8d249d770cb357d16a2097b548d2e4c1c137304]

CVE-2024-26963: usb: dwc3-am62: fix module unload/reload behavior

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-26963-3eac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e8784c0 ("drivers: usb: dwc3: Add AM62 USB
wrapper driver") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [6661befe41009c210efa2c1bcd16a5cc4cff8a06]
stable/6.1: [6c6a45645a2e6a272dfde14eddbb6706de63c25d]
stable/6.6: [7dfed9855397d0df4c6f748d1f66547ab3bad766]
stable/6.8: [3895780fabd120d0fbd54354014e85207b25687c]

CVE-2024-26964: usb: xhci: Add error handling in xhci_map_urb_for_dma

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-26964-54c8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2017a1e ("usb: xhci: Use temporary buffer to
consolidate SG") in v5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [be95cc6d71dfd0cba66e3621c65413321b398052]
stable/5.15: [4a49d24fdec0a802aa686a567a3989a9fdf4e5dd]
stable/6.1: [b2c898469dfc388f619c6c972a28466cbb1442ea]
stable/6.6: [620b6cf2f1a270f48d38e6b8ce199c1acb3e90f4]
stable/6.8: [7b6cc33593d7ccfc3011b290849cfa899db46757]

CVE-2024-26965: clk: qcom: mmcc-msm8974: fix terminating of frequency
table arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-26965-a43f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d8b2120 ("clk: qcom: Add support for MSM8974's
multimedia clock controller (MMCC)") in v3.14-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [3cca1982cbcd70f6656e47339e497041d62f8322]
cip/4.4-st: [3cca1982cbcd70f6656e47339e497041d62f8322]
mainline: [e2c02a85bf53ae86d79b5fccf0a75ac0b78e0c96]
stable/4.19: [99740c4791dc8019b0d758c5389ca6d1c0604d95]
stable/5.10: [3ff4a0f6a8f0ad4b4ee9e908bdfc3cacb7be4060]
stable/5.15: [8f562f3b25177c2055b20fd8cf000496f6fa9194]
stable/5.4: [86bf75d9158f511db7530bc82a84b19a5134d089]
stable/6.1: [537040c257ab4cd0673fbae048f3940c8ea2e589]
stable/6.6: [7e9926fef71e514b4a8ea9d11d5a84d52b181362]
stable/6.8: [ca2cf98d46748373e830a13d85d215d64a2d9bf2]

CVE-2024-26966: clk: qcom: mmcc-apq8084: fix terminating of frequency
table arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2024-26966-1afc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2b46cd2 ("clk: qcom: Add APQ8084 Multimedia Clock
Controller (MMCC) support") in v3.17-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [b112d88ea7c5551b113e4712f42815a94fcac58c]
cip/4.4-st: [b112d88ea7c5551b113e4712f42815a94fcac58c]
mainline: [a903cfd38d8dee7e754fb89fd1bebed99e28003d]
stable/4.19: [5533686e99b04994d7c4877dc0e4282adc9444a2]
stable/5.10: [a09aecb6cb482de88301c43bf00a6c8726c4d34f]
stable/5.15: [3aedcf3755c74dafc187eb76acb04e3e6348b1a9]
stable/5.4: [b2dfb216f32627c2f6a8041f2d9d56d102ab87c0]
stable/6.1: [185de0b7cdeaad8b89ebd4c8a258ff2f21adba99]
stable/6.6: [9b4c4546dd61950e80ffdca1bf6925f42b665b03]
stable/6.8: [5638330150db2cc30b53eed04e481062faa3ece8]

CVE-2024-26967: clk: qcom: camcc-sc8280xp: fix terminating of
frequency table arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2024-26967-3ccc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ff93872 ("clk: qcom: camcc-sc8280xp: Add sc8280xp
CAMCC") in v6.8-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [6a3d70f7802a98e6c28a74f997a264118b9f50cd]
stable/6.8: [93ff48729211dae55df5d216023be4528d29babb]

CVE-2024-26968: clk: qcom: gcc-ipq9574: fix terminating of frequency
table arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2024-26968-bd35@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d75b82c ("clk: qcom: Add Global Clock Controller
driver for IPQ9574") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [bd2b6395671d823caa38d8e4d752de2448ae61e1]
stable/6.6: [0204247cf3669b6021fb745c3b7f37ae392ab19c]
stable/6.8: [604f2d7c46727c5e24fc7faddc980bc1cc0b1011]

CVE-2024-26969: clk: qcom: gcc-ipq8074: fix terminating of frequency
table arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2024-26969-13cf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9607f62 ("clk: qcom: ipq8074: add PCIE, USB and
SDCC clocks") in v4.16-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [1040ef5ed95d6fd2628bad387d78a61633e09429]
stable/4.19: [e117c6e2d1617520f5f7d7f6f6b395f01d8b5a27]
stable/5.10: [851cc19bdb02556fb13629b3e4fef6f2bdb038fe]
stable/5.15: [9de184d4e557d550fb0b7b833b676bda4f269e4f]
stable/5.4: [83fe1bbd9e259ad109827ccfbfc2488e0dea8e94]
stable/6.1: [dd92b159c506804ac57adf3742d9728298bb1255]
stable/6.6: [b6b31b4c67ea6bd9222e5b73b330554c57f2f90d]
stable/6.8: [be9e2752d823eca1d5af67014a1844a9176ff566]

CVE-2024-26970: clk: qcom: gcc-ipq6018: fix terminating of frequency
table arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-26970-ad9a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d9db07f ("clk: qcom: Add ipq6018 Global Clock
Controller support") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [cdbc6e2d8108bc47895e5a901cfcaf799b00ca8d]
stable/5.10: [ae60e3342296f766f88911d39199f77b05f657a6]
stable/5.15: [b4527ee3de365a742215773d20f07db3e2c06f3b]
stable/6.1: [852db52b45ea96dac2720f108e7c7331cd3738bb]
stable/6.6: [421b135aceace99789c982f6a77ce9476564fb52]
stable/6.8: [db4066e3ab6b3d918ae2b92734a89c04fe82cc1d]

CVE-2024-26971: clk: qcom: gcc-ipq5018: fix terminating of frequency
table arrays

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-26971-6e28@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e3fdbef ("clk: qcom: Add Global Clock controller
(GCC) driver for IPQ5018") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [90ad946fff70f312b8d23226afc38c13ddd88c4b]
stable/6.6: [b0cf3d200e8a72b6d28e6e088c062b4a98cb5eaf]
stable/6.8: [50c3acd460551cdf9d8ac6fe0c04f2de0e8e0872]

CVE-2024-26972: ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-26972-bf6c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2c58d54 ("fscrypt: cache decrypted symlink target
in ->i_link") in v5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [6379b44cdcd67f5f5d986b73953e99700591edfa]
stable/6.8: [62b5ae00c2b835639002ce898ccb5d82c51073ae]

CVE-2024-26973: fat: fix uninitialized field in nostale filehandles

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-26973-54a3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ea3983a ("fat: restructure export_operations") in
v3.10-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [3dee18ecb83d8f2881438721a9f519a07fabe35f]
cip/4.4-st: [3dee18ecb83d8f2881438721a9f519a07fabe35f]
mainline: [fde2497d2bc3a063d8af88b258dbadc86bd7b57c]
stable/4.19: [9840d1897e28f8733cc1e38f97e044f987dc0a63]
stable/5.10: [a276c595c3a629170b0f052a3724f755d7c6adc6]
stable/5.15: [b7fb63e807c6dadf7ecc1d43448c4f1711d7eeee]
stable/5.4: [f52d7663a10a1266a2d3871a6dd8fd111edc549f]
stable/6.1: [c8cc05de8e6b5612b6e9f92c385c1a064b0db375]
stable/6.6: [03a7e3f2ba3ca25f1da1d3898709a08db14c1abb]
stable/6.8: [cdd33d54e789d229d6d5007cbf3f53965ca1a5c6]

CVE-2024-26974: crypto: qat - resolve race condition during AER recovery

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-26974-13eb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d8cba25 ("crypto: qat - Intel(R) QAT driver
framework") in v3.17-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [e30f053113cfc576201b3b666d9258466e692ffb]
cip/4.4-st: [e30f053113cfc576201b3b666d9258466e692ffb]
mainline: [7d42e097607c4d246d99225bf2b195b6167a210c]
stable/4.19: [daba62d9eeddcc5b1081be7d348ca836c83c59d7]
stable/5.10: [d03092550f526a79cf1ade7f0dfa74906f39eb71]
stable/5.15: [4ae5a97781ce7d6ecc9c7055396535815b64ca4f]
stable/5.4: [8e81cd58aee14a470891733181a47d123193ba81]
stable/6.1: [226fc408c5fcd23cc4186f05ea3a09a7a9aef2f7]
stable/6.6: [8a5a7611ccc7b1fba8d933a9f22a2e76859d94dc]
stable/6.8: [bb279ead42263e9fb09480f02a4247b2c287d828]

CVE-2024-26975: powercap: intel_rapl: Fix a NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-26975-d184@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1488ac9 ("powercap: intel_rapl: Allow probing
without CPUID match") in v6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [2d1f5006ff95770da502f8cee2a224a1ff83866e]
stable/6.6: [0641908b906a133f1494c312a71f9fecbe2b6c78]
stable/6.8: [2f73cf2ae5e0f4e629db5be3a4380ff7807148e6]

CVE-2024-26976: KVM: Always flush async #PF workqueue when vCPU is
being destroyed

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-26976-60d4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit af585b9 ("KVM: Halt vcpu if page it tries to
access is swapped out") in v2.6.38-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [b795785f4f94c38971e329d43d6cbaab7f2a0b82]
cip/4.4-st: [b795785f4f94c38971e329d43d6cbaab7f2a0b82]
mainline: [3d75b8aa5c29058a512db29da7cbee8052724157]
stable/4.19: [ab2c2f5d9576112ad22cfd3798071cb74693b1f5]
stable/5.10: [f8730d6335e5f43d09151fca1f0f41922209a264]
stable/5.15: [83d3c5e309611ef593e2fcb78444fc8ceedf9bac]
stable/5.4: [82e25cc1c2e93c3023da98be282322fc08b61ffb]
stable/6.1: [b54478d20375874aeee257744dedfd3e413432ff]
stable/6.6: [a75afe480d4349c524d9c659b1a5a544dbc39a98]
stable/6.8: [caa9af2e27c275e089d702cfbaaece3b42bca31b]

CVE-2024-26977: pci_iounmap(): Fix MMIO mapping leak

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-26977-cf63@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 316e8d7 ("pci_iounmap'2: Electric Boogaloo: try
to make sense of it all") in v5.15-rc2.
This commit is not backported to older kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [7626913652cc786c238e2dd7d8740b17d41b2637]
stable/5.15: [5e4b23e7a7b33a1e56bfa3e5598138a2234d55b6]
stable/6.1: [6d21d0356aa44157a62e39c0d1a13d4c69a8d0c8]
stable/6.6: [b5d40f02e7222da032c2042aebcf2a07de9b342f]
stable/6.8: [af280e137e273935f2e09f4d73169998298792ed]

CVE-2024-26978: serial: max310x: fix NULL pointer dereference in I2C
instantiation

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-26978-cc0d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2e1f2d9 ("serial: max310x: implement I2C
support") in v6.0-rc1.
This commit was backported to 5.10 and 5.4.
Fixed in v6.9-rc1.

Fixed status
mainline: [0d27056c24efd3d63a03f3edfbcfc4827086b110]
stable/5.10: [c45e53c27b78afd6c81fc25608003576f27b5735]
stable/5.4: [7d271b798add90c6196539167c019d0817285cf0]
stable/6.1: [12609c76b755dbeb1645c0aacc0f0f4743b2eff3]
stable/6.6: [2160ad6861c4a21d3fa553d7b2aaec6634a37f8a]
stable/6.8: [aeca49661fd02fd56fb026768b580ce301b45733]

CVE-2024-26979: drm/vmwgfx: Fix possible null pointer derefence with
invalid contexts

Announce: https://lore.kernel.org/linux-cve-announce/2024050134-CVE-2024-26979-43e8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9c079b8 ("drm/vmwgfx: Adapt execbuf to the new
validation api") in v4.20-rc1.
This commit was backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [517621b7060096e48e42f545fa6646fc00252eac]
stable/5.10: [c560327d900bab968c2e1b4cd7fa2d46cd429e3d]
stable/5.15: [899e154f9546fcae18065d74064889d08fff62c2]
stable/6.1: [07c3fe923ff7eccf684fb4f8c953d0a7cc8ded73]
stable/6.6: [ff41e0d4f3fa10d7cdd7d40f8026bea9fcc8b000]
stable/6.8: [585fec7361e7850bead21fada49a7fcde2f2e791]

CVE-2024-26980: ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf

Announce: https://lore.kernel.org/linux-cve-announce/2024050141-CVE-2024-26980-4b16@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc6.
It looks this bug was introduced by commit 0626e66 ("cifsd: add server
handler for central processing and tranport layers") in 5.15-rc1.

Fixed status
mainline: [c119f4ede3fa90a9463f50831761c28f989bfb20]
stable/6.1: [b80ba648714e6d790d69610cf14656be222d0248]
stable/6.6: [3160d9734453a40db248487f8204830879c207f1]
stable/6.8: [0977f89722eceba165700ea384f075143f012085]

CVE-2024-26981: nilfs2: fix OOB in nilfs_set_de_type

Announce: https://lore.kernel.org/linux-cve-announce/2024050141-CVE-2024-26981-db53@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2ba466d ("nilfs2: directory entry operations") in
v2.6.30-rc1.

Fixed in v6.9-rc5.

Fixed status
mainline: [c4a7dc9523b59b3e73fd522c73e95e072f876b16]
stable/5.15: [bdbe483da21f852c93b22557b146bc4d989260f0]
stable/6.1: [897ac5306bbeb83e90c437326f7044c79a17c611]
stable/6.6: [2382eae66b196c31893984a538908c3eb7506ff9]
stable/6.8: [90823f8d9ecca3d5fa6b102c8e464c62f416975f]

CVE-2024-26982: Squashfs: check the inode number is not the invalid
value of zero

Announce: https://lore.kernel.org/linux-cve-announce/2024050141-CVE-2024-26982-8675@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc5.
It seems to be all stable kernels are affected.

Fixed status
mainline: [9253c54e01b6505d348afbc02abaa4d9f8a01395]
stable/6.8: [7def00ebc9f2d6a581ddf46ce4541f84a10680e5]

CVE-2024-26983: bootconfig: use memblock_free_late to free xbc memory to buddy

Announce: https://lore.kernel.org/linux-cve-announce/2024050142-CVE-2024-26983-9424@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 40caa12 ("init: bootconfig: Remove all bootconfig
data when the init memory is removed") in v5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [89f9a1e876b5a7ad884918c03a46831af202c8a0]
stable/6.1: [1e7feb31a18c197d63a5e606025ed63c762f8918]
stable/6.6: [e46d3be714ad9652480c6db129ab8125e2d20ab7]
stable/6.8: [5a7dfb8fcd3f29fc93161100179b27f24f3d5f35]

CVE-2024-26984: nouveau: fix instmem race condition around ptr stores

Announce: https://lore.kernel.org/linux-cve-announce/2024050142-CVE-2024-26984-3028@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit be55287 ("drm/nouveau/imem/nv50: embed
nvkm_instobj directly into nv04_instobj") in v4.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [fff1386cc889d8fb4089d285f883f8cba62d82ce]
stable/5.15: [3ab056814cd8ab84744c9a19ef51360b2271c572]
stable/6.1: [ad74d208f213c06d860916ad40f609ade8c13039]
stable/6.6: [a019b44b1bc6ed224c46fb5f88a8a10dd116e525]
stable/6.8: [21ca9539f09360fd83654f78f2c361f2f5ddcb52]

CVE-2024-26985: drm/xe: Fix bo leak in intel_fb_bo_framebuffer_init

Announce: https://lore.kernel.org/linux-cve-announce/2024050142-CVE-2024-26985-37ac@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 44e6949 ("drm/xe/display: Implement display
support") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [652ead9b746a63e4e79d7ad66d3edf0a8a5b0c2f]
stable/6.8: [7d8ac0942c312abda43b407eff72d31747a7b472]

CVE-2024-26986: drm/amdkfd: Fix memory leak in create_process failure

Announce: https://lore.kernel.org/linux-cve-announce/2024050142-CVE-2024-26986-4650@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0ab2d75 ("drm/amdkfd: prepare per-process debug
enable and disable") in v6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [18921b205012568b45760753ad3146ddb9e2d4e2]
stable/6.6: [aa02d43367a9adf8c85fb382fea4171fb266c8d0]
stable/6.8: [0dcd876411644da98a6b4d5a18d32ca94c15bdb5]

CVE-2024-26987: mm/memory-failure: fix deadlock when
hugetlb_optimize_vmemmap is enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024050143-CVE-2024-26987-507c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a6b4085 ("mm: hugetlb: replace
hugetlb_free_vmemmap_enabled with a static_key") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [1983184c22dd84a4d95a71e5c6775c2638557dc7]
stable/6.1: [5ef7ba2799a3b5ed292b8f6407376e2c25ef002e]
stable/6.6: [882e1180c83f5b75bae03d0ccc31ccedfe5159de]
stable/6.8: [49955b24002dc16a0ae2e83a57a2a6c863a1845c]

CVE-2024-26988: init/main.c: Fix potential static_command_line memory overflow

Announce: https://lore.kernel.org/linux-cve-announce/2024050143-CVE-2024-26988-c304@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f5c7310 ("init/main: add checks for the return
value of memblock_alloc*()") in v5.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [46dad3c1e57897ab9228332f03e1c14798d2d3b9]
stable/5.15: [0dc727a4e05400205358a22c3d01ccad2c8e1fe4]
stable/6.1: [76c2f4d426a5358fced5d5990744d46f10a4ccea]
stable/6.6: [81cf85ae4f2dd5fa3e43021782aa72c4c85558e8]
stable/6.8: [936a02b5a9630c5beb0353c3085cc49d86c57034]

CVE-2024-26989: arm64: hibernate: Fix level3 translation fault in swsusp_save()

Announce: https://lore.kernel.org/linux-cve-announce/2024050143-CVE-2024-26989-851d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a7d9f30 ("arm64: drop pfn_valid_within() and
simplify pfn_valid()") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [50449ca66cc5a8cbc64749cf4b9f3d3fc5f4b457]
stable/5.15: [813f5213f2c612dc800054859aaa396ec8ad7069]
stable/6.1: [f7e71a7cf399f53ff9fc314ca3836dc913b05bd6]
stable/6.6: [31f815cb436082e72d34ed2e8a182140a73ebdf4]
stable/6.8: [022b19ebc31cce369c407617041a3db810db23b3]

CVE-2024-26990: KVM: x86/mmu: Write-protect L2 SPTEs in TDP MMU when
clearing dirty status

Announce: https://lore.kernel.org/linux-cve-announce/2024050143-CVE-2024-26990-0a1f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5982a53 ("KVM: x86/mmu: Use kvm_ad_enabled() to
determine if TDP MMU SPTEs need wrprot") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [2673dfb591a359c75080dd5af3da484b89320d22]
stable/6.6: [cdf811a937471af2d1facdf8ae80e5e68096f1ed]
stable/6.8: [e20bff0f1b2de9cfe303dd35ff46470104a87404]

CVE-2024-26991: KVM: x86/mmu: x86: Don't overflow lpage_info when
checking attributes

Announce: https://lore.kernel.org/linux-cve-announce/2024050144-CVE-2024-26991-f6d3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 90b4fe1 ("KVM: x86: Disallow hugepages when
memory attributes are mixed") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [992b54bd083c5bee24ff7cc35991388ab08598c4]
stable/6.8: [048cc4a028e635d339687ed968985d2d1669494c]

CVE-2024-26992: KVM: x86/pmu: Disable support for adaptive PEBS

Announce: https://lore.kernel.org/linux-cve-announce/2024050144-CVE-2024-26992-4f0e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c59a1f1 ("KVM: x86/pmu: Add IA32_PEBS_ENABLE MSR
emulation for extended PEBS") in v6.0-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [9e985cbf2942a1bb8fcef9adc2a17d90fd7ca8ee]
stable/6.1: [0fb74c00d140a66128afc0003785dcc57e69d312]
stable/6.6: [037e48ceccf163899374b601afb6ae8d0bf1d2ac]
stable/6.8: [7a7650b3ac23e5fc8c990f00e94f787dc84e3175]

CVE-2024-26993: fs: sysfs: Fix reference leak in sysfs_break_active_protection()

Announce: https://lore.kernel.org/linux-cve-announce/2024050144-CVE-2024-26993-fe52@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2afc916 ("scsi: sysfs: Introduce
sysfs_{un,}break_active_protection()") in v4.19-rc1.
This commit was backported to 4.4.
Fixed in v6.9-rc5.

Fixed status
mainline: [a90bca2228c0646fc29a72689d308e5fe03e6d78]
stable/5.15: [43f00210cb257bcb0387e8caeb4b46375d67f30c]
stable/6.1: [5d43e072285e81b0b63cee7189b3357c7768a43b]
stable/6.6: [ac107356aabc362aaeb77463e814fc067a5d3957]
stable/6.8: [a4c99b57d43bab45225ba92d574a8683f9edc8e4]

CVE-2024-26994: speakup: Avoid crash on very long word

Announce: https://lore.kernel.org/linux-cve-announce/2024050144-CVE-2024-26994-43c6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c6e3fd2 ("Staging: add speakup to the staging
directory") in v2.6.37-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [c8d2f34ea96ea3bce6ba2535f867f0d4ee3b22e1]
stable/5.15: [0d130158db29f5e0b3893154908cf618896450a8]
stable/6.1: [89af25bd4b4bf6a71295f07e07a8ae7dc03c6595]
stable/6.6: [8defb1d22ba0395b81feb963b96e252b097ba76f]
stable/6.8: [0efb15c14c493263cb3a5f65f5ddfd4603d19a76]

CVE-2024-26995: usb: typec: tcpm: Correct the PDO counting in pd_set

Announce: https://lore.kernel.org/linux-cve-announce/2024050144-CVE-2024-26995-ac9b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit cd099cd ("usb: typec: tcpm: Support multiple
capabilities") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [c4128304c2169b4664ed6fb6200f228cead2ab70]
stable/6.8: [f3da3192cdd3fefe213390e976eec424a8e270b5]

CVE-2024-26996: usb: gadget: f_ncm: Fix UAF ncm object at re-bind
after usb ep transport error

Announce: https://lore.kernel.org/linux-cve-announce/2024050145-CVE-2024-26996-ff2f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.9-rc5.
It looks as if all stable kernels are affected.

Fixed status
mainline: [6334b8e4553cc69f51e383c9de545082213d785e]
stable/5.15: [7f67c2020cb08499c400abf0fc32c65e4d9a09ca]
stable/6.1: [0588bbbd718a8130b98c54518f1e0b569ce60a93]
stable/6.6: [f356fd0cbd9c9cbd0854657a80d1608d0d732db3]
stable/6.8: [7250326cbb1f4f90391ac511a126b936cefb5bb7]

CVE-2024-26997: usb: dwc2: host: Fix dereference issue in DDMA completion flow.

Announce: https://lore.kernel.org/linux-cve-announce/2024050145-CVE-2024-26997-b8bf@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b258e42 ("usb: dwc2: host: Fix ISOC flow in DDMA
mode") in v6.9-rc2.
This commit was backported to stable kernels except 4.4.
Fixed in v6.9-rc5.

Fixed status
mainline: [eed04fa96c48790c1cce73c8a248e9d460b088f8]
stable/5.15: [8aa5c28ac65cb5e7f1b9c0c3238c00b661dd2b8c]
stable/6.1: [9de10b59d16880a0a3ae2876c142fe54ce45d816]
stable/6.6: [8a139fa44870e84ac228b7b76423a49610e5ba9a]
stable/6.8: [55656b2afd5f1efcec4245f3e7e814c2a9ef53f6]

CVE-2024-26998: serial: core: Clearing the circular buffer before NULLifying it

Announce: https://lore.kernel.org/linux-cve-announce/2024050145-CVE-2024-26998-2262@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 43066e3 ("serial: port: Don't suspend if the port
is still busy") in v6.8.
This commit was backported to 6.6.
Fixed in v6.9-rc5.

Fixed status
mainline: [9cf7ea2eeb745213dc2a04103e426b960e807940]
stable/6.6: [7ae7104d54342433a3a73975f6569beefdd86350]
stable/6.8: [bb1118905e875c111d7ccef9aee86ac5e4e7f985]

CVE-2024-26999: serial/pmac_zilog: Remove flawed mitigation for rx irq flood

Announce: https://lore.kernel.org/linux-cve-announce/2024050145-CVE-2024-26999-057f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.9-rc5.

Fixed status
mainline: [1be3226445362bfbf461c92a5bcdb1723f2e4907]
stable/5.15: [7a3bbe41efa55323b6ea3c35fa15941d4dbecdef]
stable/6.1: [bbaafbb4651fede8d3c3881601ecaa4f834f9d3f]
stable/6.6: [52aaf1ff14622a04148dbb9ccce6d9de5d534ea7]
stable/6.8: [ca09dfc3cfdf89e6af3ac24e1c6c0be5c575a729]

CVE-2024-27000: serial: mxs-auart: add spinlock around changing cts state

Announce: https://lore.kernel.org/linux-cve-announce/2024050146-CVE-2024-27000-c789@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4d90bb1 ("serial: core: Document and assert lock
requirements for irq helpers") in v3.18-rc1.
Fixed in v6.9-rc5.

Fixed status
mainline: [54c4ec5f8c471b7c1137a1f769648549c423c026]
stable/6.1: [2c9b943e9924cf1269e44289bc5e60e51b0f5270]
stable/6.6: [5f40fd6ca2cf0bfbc5a5c9e403dfce8ca899ba37]
stable/6.8: [94b0e65c75f4af888ab2dd6c90f060f762924e86]

CVE-2024-27001: comedi: vmk80xx: fix incomplete endpoint checking

Announce: https://lore.kernel.org/linux-cve-announce/2024050146-CVE-2024-27001-16ca@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 49253d5 ("staging: comedi: vmk80xx: factor out
usb endpoint detection") in v3.9-rc1.
Fixed in v6.9-rc5.

Fixed status
mainline: [d1718530e3f640b7d5f0050e725216eab57a85d8]
stable/5.15: [b0b268eeb087e324ef3ea71f8e6cabd07630517f]
stable/6.1: [ac882d6b21bffecb57bcc4486701239eef5aa67b]
stable/6.6: [59f33af9796160f851641d960bd93937f282c696]
stable/6.8: [6ec3514a7d35ad9cfab600187612c29f669069d2]

CVE-2024-27002: clk: mediatek: Do a runtime PM get on controllers during probe

Announce: https://lore.kernel.org/linux-cve-announce/2024050146-CVE-2024-27002-3b11@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit acddfc2 ("clk: mediatek: Add MT8183 clock
support") in v5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [2f7b1d8b5505efb0057cd1ab85fca206063ea4c3]
stable/6.1: [165d226472575b213dd90dfda19d1605dd7c19a8]
stable/6.6: [c0dcd5c072e2a3fff886f673e6a5d9bf8090c4cc]
stable/6.8: [b62ed25feb342eab052822eff0c554873799a4f5]

CVE-2024-27003: clk: Get runtime PM before walking tree for clk_summary

Announce: https://lore.kernel.org/linux-cve-announce/2024050146-CVE-2024-27003-c862@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1bb294a ("clk: Enable/Disable runtime PM for
clk_summary") in v5.17-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [9d1e795f754db1ac3344528b7af0b17b8146f321]
stable/6.1: [83ada89e4a86e2b28ea2b5113c76d6dc7560a4d0]
stable/6.6: [2c077fdfd09dffb31a890e5095c8ab205138a42e]
stable/6.8: [b457105309d388e4081c716cf7b81d517ff74db4]

CVE-2024-27004: clk: Get runtime PM before walking tree during disable_unused

Announce: https://lore.kernel.org/linux-cve-announce/2024050147-CVE-2024-27004-c429@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9a34b45 ("clk: Add support for runtime PM") in v4.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [e581cf5d216289ef292d1a4036d53ce90e122469]
stable/5.15: [a29ec0465dce0b871003698698ac6fa92c9a5034]
stable/6.1: [a424e713e0cc33d4b969cfda25b9f46df4d7b5bc]
stable/6.6: [60ff482c4205a5aac3b0595ab794cfd62295dab5]
stable/6.8: [115554862294397590088ba02f11f2aba6d5016c]

CVE-2024-27005: interconnect: Don't access req_list while it's being manipulated

Announce: https://lore.kernel.org/linux-cve-announce/2024050147-CVE-2024-27005-e630@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit af42269 ("interconnect: Fix locking for runpm vs
reclaim") in v6.6-rc1.
This commit is backported to 5.15 and 6.1.
Fixed in v6.9-rc5.

Fixed status
mainline: [de1bf25b6d771abdb52d43546cf57ad775fb68a1]
stable/6.6: [d0d04efa2e367921654b5106cc5c05e3757c2b42]
stable/6.8: [4c65507121ea8e0b47fae6d2049c8688390d46b6]

CVE-2024-27006: thermal/debugfs: Add missing count increment to
thermal_debug_tz_trip_up()

Announce: https://lore.kernel.org/linux-cve-announce/2024050147-CVE-2024-27006-3b6f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7ef01f2 ("thermal/debugfs: Add thermal debugfs
information for mitigation episodes") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [b552f63cd43735048bbe9bfbb7a9dcfce166fbdd]
stable/6.8: [9c8215d32e730b597c809a9d2090bf8ec1b79fcf]

CVE-2024-27007: userfaultfd: change src_folio after ensuring it's
unpinned in UFFDIO_MOVE

Announce: https://lore.kernel.org/linux-cve-announce/2024050147-CVE-2024-27007-686b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit adef440 ("userfaultfd: UFFDIO_MOVE uABI") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [c0205eaf3af9f5db14d4b5ee4abacf4a583c3c50]
stable/6.8: [df5f6e683e7f21a15d8be6e7a0c7a46436963ebe]

CVE-2024-27008: drm: nv04: Fix out of bounds access

Announce: https://lore.kernel.org/linux-cve-announce/2024050148-CVE-2024-27008-5964@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2e5702a ("drm/nouveau: fabricate DCB encoder
table for iMac G4") in v2.6.38-rc1.
Introduced by commit 670820c ("drm/nouveau: Workaround incorrect DCB
entry on a GeForce3 Ti 200.") in v2.6.38-rc3.
Fixed in v6.9-rc5.

Fixed status
mainline: [cf92bb778eda7830e79452c6917efa8474a30c1e]
stable/5.15: [df0991da7db846f7fa4ec6740350f743d3b69b04]
stable/6.1: [5fd4b090304e450aa0e7cc9cc2b4873285c6face]
stable/6.6: [6690cc2732e2a8d0eaca44dcbac032a4b0148042]
stable/6.8: [26212da39ee14a52c76a202c6ae5153a84f579a5]

CVE-2024-27009: s390/cio: fix race condition during online processing

Announce: https://lore.kernel.org/linux-cve-announce/2024050148-CVE-2024-27009-d63d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2297791 ("s390/cio: dont unregister subchannel
from child-drivers") in v5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [2d8527f2f911fab84aec04df4788c0c23af3df48]
stable/5.15: [3076b3c38a704e10df5e143c213653309d532538]
stable/6.1: [559f3a6333397ab6cd4a696edd65a70b6be62c6e]
stable/6.6: [2df56f4ea769ff81e51bbb05699989603bde9c49]
stable/6.8: [a4234decd0fe429832ca81c4637be7248b88b49e]

CVE-2024-27010: net/sched: Fix mirred deadlock on device recursion

Announce: https://lore.kernel.org/linux-cve-announce/2024050148-CVE-2024-27010-5a68@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3bcb846 ("net: get rid of spin_trylock() in
net_tx_action()") in v4.8-rc1.
Introduced by commit e578d9c ("net: sched: use counter to break
reclassify loops") in v4.2-rc1.
Fixed in v6.9-rc5.

Fixed status
mainline: [0f022d32c3eca477fbf79a205243a6123ed0fe11]
stable/6.8: [e6b90468da4dae2281a6e381107f411efb48b0ef]

CVE-2024-27011: netfilter: nf_tables: fix memleak in map from abort path

Announce: https://lore.kernel.org/linux-cve-announce/2024050148-CVE-2024-27011-2c70@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5910544 ("netfilter: nf_tables: revisit
chain/object refcounting from elements") in v4.12-rc3.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [86a1471d7cde792941109b93b558b5dc078b9ee9]
stable/6.8: [49d0e656d19dfb2d4d7c230e4a720d37b3decff6]

CVE-2024-27012: netfilter: nf_tables: restore set elements when delete set fails

Announce: https://lore.kernel.org/linux-cve-announce/2024050148-CVE-2024-27012-5564@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 628bd3e ("netfilter: nf_tables: drop map element
references from preparation phase") in v6.4.
This commit was backported to 5.10, 5.15, 5.4, and 6.1.
Fixed in v6.9-rc5.

Fixed status
mainline: [e79b47a8615d42c68aaeb68971593333667382ed]
stable/6.8: [86658fc7414d4b9e25c2699d751034537503d637]

CVE-2024-27013: tun: limit printing rate when illegal packet received by tun dev

Announce: https://lore.kernel.org/linux-cve-announce/2024050149-CVE-2024-27013-2c26@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ef3db4a ("tun: avoid BUG, dump packet on GSO
errors") in v2.6.35.
Fixed in v6.9-rc5.

Fixed status
mainline: [f8bbc07ac535593139c875ffa19af924b1084540]
stable/5.15: [a50dbeca28acf7051dfa92786b85f704c75db6eb]
stable/6.1: [62e27ef18eb4f0d33bbae8e9ef56b99696a74713]
stable/6.6: [40f4ced305c6c47487d3cd8da54676e2acc1a6ad]
stable/6.8: [52854101180beccdb9dc2077a3bea31b6ad48dfa]

CVE-2024-27014: net/mlx5e: Prevent deadlock while disabling aRFS

Announce: https://lore.kernel.org/linux-cve-announce/2024050149-CVE-2024-27014-d2dc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 45bf454 ("net/mlx5e: Enabling aRFS mechanism") in v4.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [fef965764cf562f28afb997b626fc7c3cec99693]
stable/6.1: [46efa4d5930cf3c2af8c01f75e0a47e4fc045e3b]
stable/6.6: [48c4bb81df19402d4346032353d0795260255e3b]
stable/6.8: [0080bf99499468030248ebd25dd645e487dcecdc]

CVE-2024-27015: netfilter: flowtable: incorrect pppoe tuple

Announce: https://lore.kernel.org/linux-cve-announce/2024050149-CVE-2024-27015-9ce1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 72efd58 ("netfilter: flowtable: add pppoe
support") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [6db5dc7b351b9569940cd1cf445e237c42cd6d27]
stable/5.15: [e719b52d0c56989b0f3475a03a6d64f182c85b56]
stable/6.1: [f1c3c61701a0b12f4906152c1626a5de580ea3d2]
stable/6.6: [4ed82dd368ad883dc4284292937b882f044e625d]
stable/6.8: [e3f078103421642fcd5f05c5e70777feb10f000d]

CVE-2024-27016: netfilter: flowtable: validate pppoe header

Announce: https://lore.kernel.org/linux-cve-announce/2024050149-CVE-2024-27016-5114@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 72efd58 ("netfilter: flowtable: add pppoe
support") in v5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [87b3593bed1868b2d9fe096c01bcdf0ea86cbebf]
stable/5.15: [d06977b9a4109f8738bb276125eb6a0b772bc433]
stable/6.1: [8bf7c76a2a207ca2b4cfda0a279192adf27678d7]
stable/6.6: [a2471d271042ea18e8a6babc132a8716bb2f08b9]
stable/6.8: [cf366ee3bc1b7d1c76a882640ba3b3f8f1039163]

CVE-2024-27017: netfilter: nft_set_pipapo: walk over current view on
netlink dump

Announce: https://lore.kernel.org/linux-cve-announce/2024050150-CVE-2024-27017-d867@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 2b84e21 ("netfilter: nft_set_pipapo: .walk does
not deal with generations") in v6.4.
This commit was backported to 5.10, 5.15, and 6.1.
Fixed in v6.9-rc5.

Fixed status
mainline: [29b359cf6d95fd60730533f7f10464e95bd17c73]
stable/6.8: [721715655c72640567e8742567520c99801148ed]

CVE-2024-27018: netfilter: br_netfilter: skip conntrack input hook for
promisc packets

Announce: https://lore.kernel.org/linux-cve-announce/2024050150-CVE-2024-27018-d8a7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 62e7151 ("netfilter: bridge: confirm multicast
packets before passing them up the stack") in v6.8-rc7.
This commit was backported to 5.15, 6.1, and 6.6.
Fixed in v6.9-rc5.

Fixed status
mainline: [751de2012eafa4d46d8081056761fa0e9cc8a178]
stable/5.15: [dceb683ab87ca3666a9bb5c0158528b646faedc4]
stable/6.1: [b13db0d16bc7b2a52abcf5cb71334f63faa5dbd6]
stable/6.6: [3f59ac29dea0921637053908fe99268d157bbb9d]
stable/6.8: [43193174510ea4f3ce09b796e559a2fd9f148615]

CVE-2024-27019: netfilter: nf_tables: Fix potential data-race in
__nft_obj_type_get()

Announce: https://lore.kernel.org/linux-cve-announce/2024050150-CVE-2024-27019-e3d4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e500924 ("netfilter: nf_tables: add stateful
objects") in v4.10-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [d78d867dcea69c328db30df665be5be7d0148484]
stable/5.15: [379bf7257bc5f2a1b1ca8514e08a871b7bf6d920]
stable/6.1: [df7c0fb8c2b9f9cac65659332581b19682a71349]
stable/6.6: [ad333578f736d56920e090d7db1f8dec891d815e]
stable/6.8: [4ca946b19caf655a08d5e2266d4d5526025ebb73]

CVE-2024-27020: netfilter: nf_tables: Fix potential data-race in
__nft_expr_type_get()

Announce: https://lore.kernel.org/linux-cve-announce/2024050150-CVE-2024-27020-5158@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ef1f7df ("netfilter: nf_tables: expression ops
overloading") in v3.13-rc1.
Fixed in v6.9-rc5.

Fixed status
mainline: [f969eb84ce482331a991079ab7a5c4dc3b7f89bf]
stable/5.15: [0b6de00206adbbfc6373b3ae38d2a6f197987907]
stable/6.1: [8d56bad42ac4c43c6c72ddd6a654a2628bf839c5]
stable/6.6: [a9ebf340d123ae12582210407f879d6a5a1bc25b]
stable/6.8: [01f1a678b05ade4b1248019c2dcca773aebbeb7f]

CVE-2024-27021: r8169: fix LED-related deadlock on module removal

Announce: https://lore.kernel.org/linux-cve-announce/2024050151-CVE-2024-27021-6a83@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 18764b8 ("r8169: add support for LED's on
RTL8168/RTL8101") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc4.

Fixed status
mainline: [19fa4f2a85d777a8052e869c1b892a2f7556569d]
stable/6.8: [53d986f39acd8ea11c9e460732bfa5add66360d9]

CVE-2024-27022: fork: defer linking file vma until vma is fully initialized

Announce: https://lore.kernel.org/linux-cve-announce/2024050143-CVE-2024-27022-4325@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 8d9bfb2 ("hugetlb: add vma based lock for pmd
sharing") in v6.1-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc5.

Fixed status
mainline: [35e351780fa9d8240dd6f7e4f245f9ea37e96c19]
stable/6.8: [abdb88dd272bbeb93efe01d8e0b7b17e24af3a34]

CVE-2024-27023: md: Fix missing release of 'active_io' for flush

Announce: https://lore.kernel.org/linux-cve-announce/2024050105-CVE-2024-27023-4810@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit fa2bbff ("md: synchronize flush io with array
reconfiguration") in 6.8-rc1.
This commit was backported to 6.1 and 6.6.
Fixed in 6.8-rc6.

Fixed status
mainline: [855678ed8534518e2b428bcbcec695de9ba248e8]
stable/6.1: [6b2ff10390b19a2364af622b6666b690443f9f3f]
stable/6.6: [02dad157ba11064d073f5499dc33552b227d5d3a]

CVE-2024-27024: net/rds: fix WARNING in rds_conn_connect_if_down

Announce: https://lore.kernel.org/linux-cve-announce/2024050107-CVE-2024-27024-efbd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 584a827 ("RDS: RDMA: return appropriate error on
rdma map failures") in v4.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8.

Fixed status
mainline: [c055fc00c07be1f0df7375ab0036cebd1106ed38]
stable/4.19: [786854141057751bc08eb26f1b02e97c1631c8f4]
stable/5.10: [9dfc15a10dfd44f8ff7f27488651cb5be6af83c2]
stable/5.15: [b562ebe21ed9adcf42242797dd6cb75beef12bf0]
stable/5.4: [997efea2bf3a4adb96c306b9ad6a91442237bf5b]
stable/6.1: [998fd719e6d6468b930ac0c44552ea9ff8b07b80]
stable/6.6: [2b505d05280739ce31d5708da840f42df827cb85]
stable/6.8: [c055fc00c07be1f0df7375ab0036cebd1106ed38]

CVE-2024-27025: nbd: null check for nla_nest_start

Announce: https://lore.kernel.org/linux-cve-announce/2024050107-CVE-2024-27025-babd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 47d902b ("nbd: add a status netlink command") in v4.12-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [31edf4bbe0ba27fd03ac7d87eb2ee3d2a231af6d]
stable/5.10: [4af837db0fd3679fabc7b7758397090b0c06dced]
stable/5.15: [98e60b538e66c90b9a856828c71d4e975ebfa797]
stable/5.4: [44214d744be32a4769faebba764510888f1eb19e]
stable/6.1: [96436365e5d80d0106ea785a4f80a58e7c9edff8]
stable/6.6: [b7f5aed55829f376e4f7e5ea5b80ccdcb023e983]
stable/6.8: [ba6a9970ce9e284cbc04099361c58731e308596a]

CVE-2024-27026: vmxnet3: Fix missing reserved tailroom

Announce: https://lore.kernel.org/linux-cve-announce/2024050108-CVE-2024-27026-189b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 54f00cc ("vmxnet3: Add XDP support.") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [e127ce7699c1e05279ee5ee61f00893e7bfa9671]
stable/6.6: [aba8659caf88017507419feea06069f529329ea6]
stable/6.8: [91d017d19d5a9ad153e2dc23ed3c0e2e79ef5262]

CVE-2024-27027: dpll: fix dpll_xa_ref_*_del() for multiple registrations

Announce: https://lore.kernel.org/linux-cve-announce/2024050108-CVE-2024-27027-ba6a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9431063 ("dpll: core: Add DPLL framework base
functions") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [b446631f355ece73b13c311dd712c47381a23172]
stable/6.8: [b27e32e9367dac024cd6f61f22655714f483fd67]

CVE-2024-27028: spi: spi-mt65xx: Fix NULL pointer access in interrupt handler

Announce: https://lore.kernel.org/linux-cve-announce/2024050110-CVE-2024-27028-42f0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1ce2486 ("spi: mediatek: Only do dma for 4-byte
aligned buffers") in v4.11-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [a20ad45008a7c82f1184dc6dee280096009ece55]
stable/4.19: [2342b05ec5342a519e00524a507f7a6ea6791a38]
stable/5.10: [bcfcdf19698024565eff427706ebbd8df65abd11]
stable/5.15: [c10fed329c1c104f375a75ed97ea3abef0786d62]
stable/5.4: [55f8ea6731aa64871ee6aef7dba53ee9f9f3b2f6]
stable/6.1: [766ec94cc57492eab97cbbf1595bd516ab0cb0e4]
stable/6.6: [62b1f837b15cf3ec2835724bdf8577e47d14c753]
stable/6.8: [1784053cf10a14c4ebd8a890bad5cfe1bee51713]

CVE-2024-27029: drm/amdgpu: fix mmhub client id out-of-bounds access

Announce: https://lore.kernel.org/linux-cve-announce/2024050110-CVE-2024-27029-69f0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit aba2be4 ("drm/amdgpu: add mmhub 3.3.0 support")
in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [6540ff6482c1a5a6890ae44b23d0852ba1986d9e]
stable/6.8: [1f24b3040f2b6ffcb97151fabb3070328254d923]

CVE-2024-27030: octeontx2-af: Use separate handlers for interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2024050110-CVE-2024-27030-d75a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7304ac4 ("octeontx2-af: Add mailbox IRQ and msg
handlers") in v4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [50e60de381c342008c0956fd762e1c26408f372c]
stable/5.10: [766c2627acb2d9d1722cce2e24837044d52d888a]
stable/5.15: [772f18ded0e240cc1fa2b7020cc640e3e5c32b70]
stable/5.4: [94cb17e5cf3a3c484063abc0ce4b8a2b2e8c1cb2]
stable/6.1: [29d2550d79a8cbd31e0fbaa5c0e2a2efdc444e44]
stable/6.6: [dc29dd00705a62c77de75b6d752259b869aac49d]
stable/6.8: [4fedae8f9eafa2ac8cdaca58e315f52a7e2a8701]

CVE-2024-27031: NFS: Fix nfs_netfs_issue_read() xarray locking for
writeback interrupt

Announce: https://lore.kernel.org/linux-cve-announce/2024050110-CVE-2024-27031-2e85@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 000dbe0 ("NFS: Convert buffered read paths to use
netfs when fscache is enabled") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [fd5860ab6341506004219b080aea40213b299d2e]
stable/6.6: [ad27382f8495f8ef6d2c66c413d756bfd13c0598]
stable/6.8: [8a2e5977cecd3cde6a0e3e86b7b914d00240e5dc]

CVE-2024-27032: f2fs: fix to avoid potential panic during recovery

Announce: https://lore.kernel.org/linux-cve-announce/2024050111-CVE-2024-27032-97a9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 956fa1d ("f2fs: fix to check return value of
f2fs_reserve_new_block()") in v6.8-rc1.
This commit was backported to older stable kernels except 4.4.
Fixed in v6.9-rc1.

Fixed status
mainline: [21ec68234826b1b54ab980a8df6e33c74cfbee58]
stable/6.1: [fe4de493572a4263554903bf9c3afc5c196e15f0]
stable/6.6: [8844b2f8a3f0c428b74672f9726f9950b1a7764c]
stable/6.8: [f26091a981318b5b7451d61f99bc073a6af8db67]

CVE-2024-27033: f2fs: fix to remove unnecessary f2fs_bug_on() to avoid panic

Announce: https://lore.kernel.org/linux-cve-announce/2024050111-CVE-2024-27033-d152@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 18792e6 ("f2fs: support fault injection for
f2fs_is_valid_blkaddr()") in v6.2-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [b896e302f79678451a94769ddd9e52e954c64fbb]
stable/6.6: [0386408036bfc8b50296d9e544ff91c4d52af2db]
stable/6.8: [abe98a05e7162f64759bf9111108ebcb11322dec]

CVE-2024-27034: f2fs: compress: fix to cover normal cluster write with cp_rwsem

Announce: https://lore.kernel.org/linux-cve-announce/2024050111-CVE-2024-27034-5872@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4c8ff70 ("f2fs: support data compression") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [fd244524c2cf07b5f4c3fe8abd6a99225c76544b]
stable/5.15: [7d420eaaa18ec8e2bb4eeab8c65c00492ef6f416]
stable/6.1: [542c8b3c774a480bfd0804291a12f6f2391b0cd1]
stable/6.6: [75abfd61392b1db391bde6d738a30d685b843286]
stable/6.8: [52982edfcefd475cc34af663d5c47c0cddaa5739]

CVE-2024-27035: f2fs: compress: fix to guarantee persisting compressed
blocks by CP

Announce: https://lore.kernel.org/linux-cve-announce/2024050111-CVE-2024-27035-1628@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4c8ff70 ("f2fs: support data compression") in v5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [8a430dd49e9cb021372b0ad91e60aeef9c6ced00]
stable/6.1: [e54cce8137258a550b49cae45d09e024821fb28d]
stable/6.6: [82704e598d7b33c7e45526e34d3c585426319bed]
stable/6.8: [57e8b17d0522c8f4daf0c4d9969b4d7358033532]

CVE-2024-27036: cifs: Fix writeback data corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024050111-CVE-2024-27036-6ba3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d08089f ("cifs: Change the I/O paths to use an
iterator rather than a page list") in v6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c]
stable/6.6: [e45deec35bf7f1f4f992a707b2d04a8c162f2240]
stable/6.8: [844b4e132f57f1333dc79feaa035075a096762e4]

CVE-2024-27037: clk: zynq: Prevent null pointer dereference caused by
kmalloc failure

Announce: https://lore.kernel.org/linux-cve-announce/2024050112-CVE-2024-27037-d54a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0ee52b1 ("clk: zynq: Add clock controller
driver") in v3.11-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [7938e9ce39d6779d2f85d822cc930f73420e54a6]
stable/5.15: [01511ac7be8e45f80e637f6bf61af2d3d2dee9db]
stable/6.1: [8c4889a9ea861d7be37463c10846eb75e1b49c9d]
stable/6.6: [0801c893fd48cdba66a3c8f44c3fe43cc67d3b85]
stable/6.8: [58a946ab43501f2eba058d24d96af0ad1122475b]

CVE-2024-27038: clk: Fix clk_core_get NULL dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024050112-CVE-2024-27038-3af3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit dde4eff ("clk: Look for parents with clkdev based
clk_lookups") in v5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [e97fe4901e0f59a0bfd524578fe3768f8ca42428]
stable/5.10: [239174535dba11f7b83de0eaaa27909024f8c185]
stable/5.15: [0efb9ef6fb95384ba631d6819e66f10392aabfa2]
stable/5.4: [d7ae7d1265686b55832a445b1db8cdd69738ac07]
stable/6.1: [a8b2b26fdd011ebe36d68a9a321ca45801685959]
stable/6.6: [a5d9b1aa61b401867b9066d54086b3e4ee91f8ed]
stable/6.8: [6f073b24a9e2becd25ac4505a9780a87e621bb51]

CVE-2024-27039: clk: hisilicon: hi3559a: Fix an erroneous devm_kfree()

Announce: https://lore.kernel.org/linux-cve-announce/2024050112-CVE-2024-27039-3730@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6c81966 ("clk: hisilicon: Add clock driver for
hi3559A SoC") in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [64c6a38136b74a2f18c42199830975edd9fbc379]
stable/5.15: [3f8445f1c746fda180a7f75372ed06b24e9cefe2]
stable/6.1: [e0b0d1c46a2ce1e46b79d004a7270fdef872e097]
stable/6.6: [95d1f1228c1bb54803ae57525b76db60e99b37e4]
stable/6.8: [d575765b1b62e8bdb00af11caa1aabeb01763d9f]

CVE-2024-27040: drm/amd/display: Add 'replay' NULL check in
'edp_set_replay_allow_active()'

Announce: https://lore.kernel.org/linux-cve-announce/2024050112-CVE-2024-27040-e45b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c7ddc0a ("drm/amd/display: Add Functions to
enable Freesync Panel Replay") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [f6aed043ee5d75b3d1bfc452b1a9584b63c8f76b]
stable/6.6: [f610c46771ef1047e46d61807aa7c69cd29e63d8]
stable/6.8: [d0e94f4807ff0df66cf447d6b4bbb8ac830e99c3]

CVE-2024-27041: drm/amd/display: fix NULL checks for adev->dm.dc in
amdgpu_dm_fini()

Announce: https://lore.kernel.org/linux-cve-announce/2024050112-CVE-2024-27041-7bf4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81927e2 ("drm/amd/display: Support for DMUB AUX")
in v5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [2a3cfb9a24a28da9cc13d2c525a76548865e182c]
stable/6.6: [e040f1fbe9abae91b12b074cfc3bbb5367b79811]
stable/6.8: [1c62697e4086de988b31124fb8c79c244ea05f2b]

CVE-2024-27042: drm/amdgpu: Fix potential out-of-bounds access in
'amdgpu_discovery_reg_base_init()'

Announce: https://lore.kernel.org/linux-cve-announce/2024050113-CVE-2024-27042-e812@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a0ccc71 ("drm/amdgpu/discovery: validate VCN and
SDMA instances") in v5.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [cdb637d339572398821204a1142d8d615668f1e9]
stable/6.6: [8f3e68c6a3fff53c2240762a47a0045d89371775]
stable/6.8: [8db10cee51e3e11a6658742465edc21986cf1e8d]

CVE-2024-27043: media: edia: dvbdev: fix a use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024050113-CVE-2024-27043-f2fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b619010 ("V4L/DVB (5244): Dvbdev: fix illegal
re-usage of fileoperations struct") in v2.6.21-rc2.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [d87c1e726012e3ef1f738814267fd6f4bd5bc22b]
cip/4.4-st: [d87c1e726012e3ef1f738814267fd6f4bd5bc22b]
mainline: [8c64f4cdf4e6cc5682c52523713af8c39c94e6d5]
stable/4.19: [d0f5c28333822f9baa5280d813124920720fd856]
stable/5.10: [096237039d00c839f3e3a5fe6d001bf0db45b644]
stable/5.15: [0d3fe80b6d175c220b3e252efc6c6777e700e98e]
stable/5.4: [f20c3270f3ed5aa6919a87e4de9bf6c05fb57086]
stable/6.1: [437a111f79a2f5b2a5f21e27fdec6f40c8768712]
stable/6.6: [779e8db7efb22316c8581d6c229636d2f5694a62]
stable/6.8: [b7586e902128e4fb7bfbb661cb52e4215a65637b]

CVE-2024-27044: drm/amd/display: Fix potential NULL pointer
dereferences in 'dcn10_set_output_transfer_func()'

Announce: https://lore.kernel.org/linux-cve-announce/2024050113-CVE-2024-27044-7e0e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ddef02d ("drm/amd/display: add null checks before
logging") in v5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [9ccfe80d022df7c595f1925afb31de2232900656]
stable/5.10: [330caa061af53ea6d287d7c43d0703714e510e08]
stable/5.15: [6ac7c7a3a9ab57aba0fe78ecb922d2b20e16efeb]
stable/5.4: [e019d87e02f1e539ae48b99187f253847744ca7a]
stable/6.1: [29fde8895b2fcc33f44aea28c644ce2d9b62f9e0]
stable/6.6: [2d9fe7787af01188dc470a649bdbb842d6511fd7]
stable/6.8: [7874ab3105ca4657102fee1cc14b0af70883c484]

CVE-2024-27045: drm/amd/display: Fix a potential buffer overflow in
'dp_dsc_clock_en_read()'

Announce: https://lore.kernel.org/linux-cve-announce/2024050113-CVE-2024-27045-6680@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c06e09b ("drm/amd/display: Add DSC parameters
logging to debugfs") in v5.9-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [4b09715f1504f1b6e8dff0e9643630610bc05141]
stable/5.10: [ff28893c96c5e0927a4da10cd24a3522ca663515]
stable/5.15: [440f059837418fac1695b65d3ebc6080d33be877]
stable/6.1: [d346b3e5b25c95d504478507eb867cd3818775ab]
stable/6.6: [ad76fd30557d6a106c481e4606a981221ca525f7]
stable/6.8: [cf114d8d4a8d78df272116a745bb43b48cef65f4]

CVE-2024-27046: nfp: flower: handle acti_netdevs allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024050113-CVE-2024-27046-4694@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bb9a8d0 ("nfp: flower: monitor and offload LAG
groups") in v4.18-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [84e95149bd341705f0eca6a7fcb955c548805002]
stable/4.19: [d746889db75a76aeee95fb705b8e1ac28c684a2e]
stable/5.10: [928705e341010dd910fdece61ccb974f494a758f]
stable/5.15: [0d387dc503f9a53e6d1f6e9dd0292d38f083eba5]
stable/5.4: [3b1e8a617eb0f4cdc19def530047a95b5abde07d]
stable/6.1: [c9b4e220dd18f79507803f38a55d53b483f6c9c3]
stable/6.6: [408ba7fd04f959c61b50db79c983484312fea642]
stable/6.8: [9d8eb1238377cd994829f9162ae396a84ae037b2]

CVE-2024-27047: net: phy: fix phy_get_internal_delay accessing an empty array

Announce: https://lore.kernel.org/linux-cve-announce/2024050114-CVE-2024-27047-8aad@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 92252ee ("net: phy: Add a helper to return the
index for of the internal delay") in v5.9-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [4469c0c5b14a0919f5965c7ceac96b523eb57b79]
stable/5.10: [06dd21045a7e8bc8701b0ebedcd9a30a6325878b]
stable/5.15: [0e939a002c8a7d66e60bd0ea6b281fb39d713c1a]
stable/6.1: [2a2ff709511617de9c6c072eeee82bcbbdfecaf8]
stable/6.6: [589ec16174dd9378953b8232ae76fad0a96e1563]
stable/6.8: [0307cf443308ecc6be9b2ca312bb31bae5e5a7ad]

CVE-2024-27048: wifi: brcm80211: handle pmk_op allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024050114-CVE-2024-27048-016f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a96202a ("wifi: brcmfmac: cfg80211: Add support
for PMKID_V3 operations") in v6.4-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [b4152222e04cb8afeeca239c90e3fcaf4c553b42]
stable/6.6: [df62e22c2e27420e8990a4f09e30d7bf56c2036f]
stable/6.8: [6138a82f3bccfc67ed7ac059493579fc326c02e5]

CVE-2024-27049: wifi: mt76: mt7925e: fix use-after-free in free_irq()

Announce: https://lore.kernel.org/linux-cve-announce/2024050114-CVE-2024-27049-a5a1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c948b5d ("wifi: mt76: mt7925: add Mediatek Wi-Fi7
driver for mt7925 chips") in v6.7-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [a5a5f4413d91f395cb2d89829d376d7393ad48b9]
stable/6.8: [6d9930096e1f13cf6d9aabfbf95d0e05fb04144f]

CVE-2024-27050: libbpf: Use OPTS_SET() macro in bpf_xdp_query()

Announce: https://lore.kernel.org/linux-cve-announce/2024050114-CVE-2024-27050-b829@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 13ce2da ("xsk: add new netlink attribute
dedicated for ZC max frags") in v6.6-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [92a871ab9fa59a74d013bc04f321026a057618e7]
stable/6.6: [fa5bef5e80c6a3321b2b1a7070436f3bc5daf07c]
stable/6.8: [cd3be9843247edb8fc6fcd8d8237cbce2bc19f5e]

CVE-2024-27051: cpufreq: brcmstb-avs-cpufreq: add check for
cpufreq_cpu_get's return value

Announce: https://lore.kernel.org/linux-cve-announce/2024050114-CVE-2024-27051-07ce@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit de322e0 ("cpufreq: brcmstb-avs-cpufreq: AVS
CPUfreq driver for Broadcom STB SoCs") in v4.10-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [f661017e6d326ee187db24194cabb013d81bc2a6]
stable/5.10: [9127599c075caff234359950117018a010dd01db]
stable/5.15: [d951cf510fb0df91d3abac0121a59ebbc63c0567]
stable/6.1: [e72160cb6e23b78b41999d6885a34ce8db536095]
stable/6.6: [b25b64a241d769e932a022e5c780cf135ef56035]
stable/6.8: [e6e3e51ffba0784782b1a076d7441605697ea3c6]

CVE-2024-27052: wifi: rtl8xxxu: add cancel_work_sync() for c2hcmd_work

Announce: https://lore.kernel.org/linux-cve-announce/2024050115-CVE-2024-27052-fb6d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit e542e66 ("rtl8xxxu: add bluetooth co-existence
support for single antenna") in v5.5-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [1213acb478a7181cd73eeaf00db430f1e45b1361]
stable/5.10: [dddedfa3b29a63c2ca4336663806a6128b8545b4]
stable/5.15: [ac512507ac89c01ed6cd4ca53032f52cdb23ea59]
stable/6.1: [3518cea837de4d106efa84ddac18a07b6de1384e]
stable/6.6: [156012667b85ca7305cb363790d3ae8519a6f41e]
stable/6.8: [58fe3bbddfec10c6b216096d8c0e517cd8463e3a]

CVE-2024-27053: wifi: wilc1000: fix RCU usage in connect path

Announce: https://lore.kernel.org/linux-cve-announce/2024050115-CVE-2024-27053-a8e9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c460495 ("staging: wilc1000: fix incorrent type
in initializer") in v5.1-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [205c50306acf58a335eb19fa84e40140f4fe814f]
stable/5.10: [b4bbf38c350acb6500cbe667b1e2e68f896e4b38]
stable/5.15: [d80fc436751cfa6b02a8eda74eb6cce7dadfe5a2]
stable/5.4: [e556006de4ea93abe2b46cba202a2556c544b8b2]
stable/6.1: [745003b5917b610352f52fe0d11ef658d6471ec2]
stable/6.6: [4bfd20d5f5c62b5495d6c0016ee6933bd3add7ce]
stable/6.8: [dd50d3ead6e3707bb0a5df7cc832730c93ace3a7]

CVE-2024-27054: s390/dasd: fix double module refcount decrement

Announce: https://lore.kernel.org/linux-cve-announce/2024050115-CVE-2024-27054-b0ff@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c020d72 ("s390/dasd: fix panic during offline
processing") in v4.9-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [c3116e62ddeff79cae342147753ce596f01fcf06]
stable/5.15: [edbdb0d94143db46edd373cc93e433832d29fe19]
stable/6.1: [ad999aa18103fa038787b6a8a55020abcf34df1a]
stable/6.6: [ec09bcab32fc4765e0cc97e1b72cdd067135f37e]
stable/6.8: [ebc5a3bd79e54f98c885c26f0862a27a02c487c5]

CVE-2024-27055: workqueue: Don't call cpumask_test_cpu() with -1 CPU
in wq_update_node_max_active()

Announce: https://lore.kernel.org/linux-cve-announce/2024050115-CVE-2024-27055-449e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 5797b1c ("workqueue: Implement system-wide
nr_active enforcement for unbound workqueues") in 6.9-rc1.
This commit was backported to 6.6 and 6.8.
Fixed in 6.9-rc1.

Fixed status
mainline: [15930da42f8981dc42c19038042947b475b19f47]
stable/6.6: [7df62b8cca38aa452b508b477b16544cba615084]
stable/6.8: [a75ac2693d734d20724f0e10e039ca85f1fcfc4e]

CVE-2024-27056: wifi: iwlwifi: mvm: ensure offloading TID queue exists

Announce: https://lore.kernel.org/linux-cve-announce/2024050115-CVE-2024-27056-98c0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc7.

Fixed status
mainline: [78f65fbf421a61894c14a1b91fe2fb4437b3fe5f]

CVE-2024-27057: ASoC: SOF: ipc4-pcm: Workaround for crashed firmware
on system suspend

Announce: https://lore.kernel.org/linux-cve-announce/2024050116-CVE-2024-27057-c0fb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8-rc5.
It seems as if it was introduced by commit 2d271af ("ASoC: SOF:
ipc4-pcm: Use the PCM stream's pipeline_info during trigger") in
6.3-rc1.
This commit is not backported to older stable kernels.

Fixed status
mainline: [c40aad7c81e5fba34b70123ed7ce3397fa62a4d2]
stable/6.6: [3cac6eebea9b4bc5f041e157e45c76e212ad6759]

CVE-2024-27058: tmpfs: fix race on handling dquot rbtree

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-27058-e8f6@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit eafc474 ("shmem: prepare shmem quota
infrastructure") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc2.

Fixed status
mainline: [0a69b6b3a026543bc215ccc866d0aea5579e6ce2]
stable/6.6: [c7077f43f30d817d10a9f8245e51576ac114b2f0]
stable/6.8: [f82f184874d2761ebaa60dccf577921a0dbb3810]

CVE-2024-27059: USB: usb-storage: Prevent divide-by-0 error in
isd200_ata_command

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-27059-baaa@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.8.

Fixed status
cip/4.4: [3b252232c2204c18e7c75b33f1c3725cf9239512]
cip/4.4-st: [3b252232c2204c18e7c75b33f1c3725cf9239512]
mainline: [014bcf41d946b36a8f0b8e9b5d9529efbb822f49]
stable/4.19: [9968c701cba7eda42e5f0052b040349d6222ae34]
stable/5.10: [284fb1003d5da111019b9e0bf99b084fd71ac133]
stable/5.15: [6c1f36d92c0a8799569055012665d2bb066fb964]
stable/5.4: [eb7b01ca778170654e1c76950024270ba74b121f]
stable/6.1: [f42ba916689f5c7b1642092266d2f53cf527aaaa]
stable/6.6: [871fd7b10b56d280990b7e754f43d888382ca325]
stable/6.8: [014bcf41d946b36a8f0b8e9b5d9529efbb822f49]

CVE-2024-27060: thunderbolt: Fix NULL pointer dereference in
tb_port_update_credits()

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-27060-8a1c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81af295 ("thunderbolt: Add support for asymmetric
link") in v6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8.

Fixed status
mainline: [d3d17e23d1a0d1f959b4fa55b35f1802d9c584fa]
stable/6.8: [d3d17e23d1a0d1f959b4fa55b35f1802d9c584fa]

CVE-2024-27061: crypto: sun8i-ce - Fix use after free in unprepare

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-27061-fef2@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4136212 ("crypto: sun8i-ce - Remove
prepare/unprepare request") in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.8.

Fixed status
mainline: [183420038444547c149a0fc5f58e792c2752860c]
stable/6.6: [dc60b25540c82fc4baa95d1458ae96ead21859e0]
stable/6.8: [183420038444547c149a0fc5f58e792c2752860c]

CVE-2024-27062: nouveau: lock the client object tree.

Announce: https://lore.kernel.org/linux-cve-announce/2024050130-CVE-2024-27062-3291@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.8.
It looks as if commit 110cccf ("drm/nouveau/core/object: support
lookup of specific object types") in 4.11-rc1 introduced this bug.
Linux 4.4 doesn't have vulnerable functions.

Fixed status
mainline: [b7cc4ff787a572edf2c55caeffaa88cd801eb135]
stable/6.6: [6887314f5356389fc219b8152e951ac084a10ef7]
stable/6.8: [b7cc4ff787a572edf2c55caeffaa88cd801eb135]

CVE-2024-27063: leds: trigger: netdev: Fix kernel panic on interface
rename trig notify

Announce: https://lore.kernel.org/linux-cve-announce/2024050131-CVE-2024-27063-c356@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d5e0126 ("leds: trigger: netdev: add additional
specific link speed mode") in v6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [415798bc07dd1c1ae3a656aa026580816e0b9fe8]
stable/6.6: [10f2af1af8ab8a7064f193446abd5579d3def7e3]
stable/6.8: [3f360227cb46edb2cd2494128e1e06ed5768a62e]

CVE-2024-27064: netfilter: nf_tables: Fix a memory leak in nf_tables_updchain

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-27064-8046@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b9703ed ("netfilter: nf_tables: support for
adding new devices to an existing netdev chain") in v6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [7eaf837a4eb5f74561e2486972e7f5184b613f6e]
stable/6.6: [79846fdcc548d617b0b321addc6a3821d3b75b20]
stable/6.8: [e77a6b53a3a547b6dedfc40c37cee4f310701090]

CVE-2024-27065: netfilter: nf_tables: do not compare internal table
flags on updates

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-27065-8c9d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 179d9ba ("netfilter: nf_tables: fix table flag
updates") in v5.13-rc5.
This commit was backported to 5.10 and 5.4.
Fixed in v6.9-rc1.

Fixed status
mainline: [4a0e7f2decbf9bd72461226f1f5f7dcc4b08f139]
stable/5.10: [fcf32a5bfcb8a57ac0ce717fcfa4d688c91f1005]
stable/5.15: [640dbf688ba955e83e03de84fbdda8e570b7cce4]
stable/5.4: [2531f907d3e40a6173090f10670ae76d117ab27b]
stable/6.1: [9683cb6c2c6c0f45537bf0b8868b5d38fcb63fc7]
stable/6.6: [4d37f12707ee965d338028732575f0b85f6d9e4f]
stable/6.8: [df257c435e51651c43b86326d112ddadda76350e]

CVE-2024-27066: virtio: packed: fix unmap leak for indirect desc table

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-27066-686a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b319940 ("virtio_ring: skip unmap for premapped")
in v6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [d5c0ed17fea60cca9bc3bf1278b49ba79242bbcd]
stable/6.6: [e142169aca5546ae6619c39a575cda8105362100]
stable/6.8: [51bacd9d29bf98c3ebc65e4a0477bb86306b4140]

CVE-2024-27067: xen/evtchn: avoid WARN() when unbinding an event channel

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-27067-38e7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 9e90e58 ("xen: evtchn: Allow shared registration
of IRQ handers") in v6.7-rc1.
This commit is backported to 6.6.
Fixed in v6.9-rc1.

Fixed status
mainline: [51c23bd691c0f1fb95b29731c356c6fd69925d17]
stable/6.6: [99e425032c6ec13584d3cd33846e0c7307501b47]
stable/6.8: [9e2d4b58c1da48a32905802aaeadba7084b46895]

CVE-2024-27068: thermal/drivers/mediatek/lvts_thermal: Fix a memory
leak in an error handling path

Announce: https://lore.kernel.org/linux-cve-announce/2024050132-CVE-2024-27068-c844@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f5f633b ("thermal/drivers/mediatek: Add the Low
Voltage Thermal Sensor driver") in v6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [ca93bf607a44c1f009283dac4af7df0d9ae5e357]
stable/6.6: [2db869da91afd48e5b9ec76814709be49662b07d]
stable/6.8: [9b02197596671800dd934609384b1aca7c6ad218]

CVE-2024-27069: ovl: relax WARN_ON in ovl_verify_area()

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-27069-5b70@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ca7ab48 ("ovl: add permission hooks outside of
do_splice_direct()") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [77a28aa476873048024ad56daf8f4f17d58ee48e]
stable/6.8: [c3c85aefc0da1e5074a06c682542a54ccc99bdca]

CVE-2024-27070: f2fs: fix to avoid use-after-free issue in f2fs_filemap_fault

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-27070-a43e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 87f3afd ("f2fs: add tracepoint for
f2fs_vm_page_mkwrite()") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [eb70d5a6c932d9d23f4bb3e7b83782c21ac4b064]
stable/6.8: [8186e16a766d709a08f188d2f4e84098f364bea1]

CVE-2024-27071: backlight: hx8357: Fix potential NULL pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-27071-3b1b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7d84a63 ("backlight: hx8357: Convert to agnostic
GPIO API") in v6.8-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [b1ba8bcb2d1ffce11b308ce166c9cc28d989e3b9]
stable/6.8: [67e578c8ff2d7df03bf8ca9a7f5436b1796f6ad1]

CVE-2024-27072: media: usbtv: Remove useless locks in usbtv_video_free()

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-27072-301d@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c838530 ("media: media videobuf2: Be more
flexible on the number of queue stored buffers") in v6.8-rc1.
Introduced by commit f3d27f3 ("[media] usbtv: Add driver for Fushicai
USBTV007 video frame grabber") in v3.11-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [65e6a2773d655172143cc0b927cdc89549842895]
stable/6.8: [3e7d82ebb86e94643bdb30b0b5b077ed27dce1c2]

CVE-2024-27073: media: ttpci: fix two memleaks in budget_av_attach

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-27073-967c@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.9-rc1.

Fixed status
mainline: [d0b07f712bf61e1a3cf23c87c663791c42e50837]
stable/5.10: [910363473e4bf97da3c350e08d915546dd6cc30b]
stable/5.15: [24e51d6eb578b82ff292927f14b9f5ec05a46beb]
stable/5.4: [af37aed04997e644f7e1b52b696b62dcae3cc016]
stable/6.1: [55ca0c7eae8499bb96f4e5d9b26af95e89c4e6a0]
stable/6.6: [7393c681f9aa05ffe2385e8716989565eed2fe06]
stable/6.8: [656b8cc123d7635dd399d9f02594f27aa797ac3c]

CVE-2024-27074: media: go7007: fix a memleak in go7007_load_encoder

Announce: https://lore.kernel.org/linux-cve-announce/2024050133-CVE-2024-27074-a9b3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 95ef394 ("[media] go7007: remember boot
firmware") in v3.10-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [01173c381edc48d33487a9f6a1e306ed41fda472]
cip/4.4-st: [01173c381edc48d33487a9f6a1e306ed41fda472]
mainline: [b9b683844b01d171a72b9c0419a2d760d946ee12]
stable/4.19: [7f11dd3d165b178e738fe73dfeea513e383bedb5]
stable/5.10: [b49fe84c6cefcc1c2336d793b53442e716c95073]
stable/5.15: [790fa2c04dfb9f095ec372bf17909424d6e864b3]
stable/5.4: [291cda0b805fc0d6e90d201710311630c8667159]
stable/6.1: [e04d15c8bb3e111dd69f98894acd92d63e87aac3]
stable/6.6: [f31c1cc37411f5f7bcb266133f9a7e1b4bdf2975]
stable/6.8: [7405a0d4442792988e9ae834e7d84f9d163731a4]

CVE-2024-27075: media: dvb-frontends: avoid stack overflow warnings with clang

Announce: https://lore.kernel.org/linux-cve-announce/2024050134-CVE-2024-27075-5e4f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3cd890d ("media: dvb-frontends: fix i2c access
helpers for KASAN") in v4.16-rc1.
This commit was backported to 4.4
Fixed in v6.9-rc1.

Fixed status
mainline: [7a4cf27d1f0538f779bf31b8c99eda394e277119]
stable/4.19: [c073c8cede5abd3836e83d70d72606d11d0759d4]
stable/5.10: [fb07104a02e87c06c39914d13ed67fd8f839ca82]
stable/5.15: [d20b64f156de5d10410963fe238d82a4e7e97a2f]
stable/5.4: [fa8b472952ef46eb632825051078c21ce0cafe55]
stable/6.1: [107052a8cfeff3a97326277192b4f052e4860a8a]
stable/6.6: [8fad9c5bb00d3a9508d18bbfe832e33a47377730]
stable/6.8: [ed514ecf4f29c80a2f09ae3c877059b401efe893]

CVE-2024-27076: media: imx: csc/scaler: fix v4l2_ctrl_handler memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024050134-CVE-2024-27076-5a2e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a8ef048 ("media: imx: add csc/scaler mem2mem
device") in v5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [4797a3dd46f220e6d83daf54d70c5b33db6deb01]
stable/5.10: [5d9fe604bf9b5b09d2215225df55f22a4cbbc684]
stable/5.15: [b1d0eebaf87cc9ccd05f779ec4a0589f95d6c18b]
stable/5.4: [8c2e4efe1278cd2b230cdbf90a6cefbf00acc282]
stable/6.1: [8df9a3c7044b847e9c4dc7e683fd64c6b873f328]
stable/6.6: [d164ddc21e986dd9ad614b4b01746e5457aeb24f]
stable/6.8: [6c92224721a439d6350db5933a1060768dcd565e]

CVE-2024-27077: media: v4l2-mem2mem: fix a memleak in v4l2_m2m_register_entity

Announce: https://lore.kernel.org/linux-cve-announce/2024050134-CVE-2024-27077-3482@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit be2fff6 ("media: add helpers for memory-to-memory
media controller") in v4.19-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [8f94b49a5b5d386c038e355bef6347298aabd211]
stable/4.19: [3dd8abb0ed0e0a7c66d6d677c86ccb188cc39333]
stable/5.10: [afd2a82fe300032f63f8be5d6cd6981e75f8bbf2]
stable/5.15: [dc866b69cc51af9b8509b4731b8ce2a4950cd0ef]
stable/5.4: [0175f2d34c85744f9ad6554f696cf0afb5bd04e4]
stable/6.1: [0c9550b032de48d6a7fa6a4ddc09699d64d9300d]
stable/6.6: [90029b9c979b60de5cb2b70ade4bbf61d561bc5d]
stable/6.8: [9c23ef30e840fedc66948299509f6c2777c9cf4f]

CVE-2024-27078: media: v4l2-tpg: fix some memleaks in tpg_alloc

Announce: https://lore.kernel.org/linux-cve-announce/2024050134-CVE-2024-27078-6a54@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 63881df ("[media] vivid: add the Test Pattern
Generator") in v3.18-rc1.
Fixed in v6.9-rc1.

Fixed status
mainline: [8cf9c5051076e0eb958f4361d50d8b0c3ee6691c]
stable/4.19: [0de691ff547d86dd54c24b40a81f9c925df8dd77]
stable/5.10: [94303a06e1852a366e9671fff46d19459f88cb28]
stable/5.15: [770a57922ce36a8476c43f7400b6501c554ea511]
stable/5.4: [8269ab16415f2065cd792c49b0475543936cbd79]
stable/6.1: [6bf5c2fade8ed53b2d26fa9875e5b04f36c7145d]
stable/6.6: [4c86c772fef06f5d7a66151bac42366825db0941]
stable/6.8: [622b1cf38521569869c8f7b9fbe9e4f1a289add7]

CVE-2024-27079: iommu/vt-d: Fix NULL domain on device release

Announce: https://lore.kernel.org/linux-cve-announce/2024050134-CVE-2024-27079-f478@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 586081d ("iommu/vt-d: Remove
DEFER_DEVICE_DOMAIN_INFO") in v5.18-rc1.
This commit is not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [81e921fd321614c2ad8ac333b041aae1da7a1c6d]
stable/6.8: [333fe86968482ca701c609af590003bcea450e8f]

CVE-2024-27080: btrfs: fix race when detecting delalloc ranges during fiemap

Announce: https://lore.kernel.org/linux-cve-announce/2024050135-CVE-2024-27080-46f0@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit b0ad381 ("btrfs: fix deadlock with fiemap and
extent locking") in v6.8-rc6.
This commit was backported to 6.6.
Fixed in v6.9-rc1.

Fixed status
mainline: [978b63f7464abcfd364a6c95f734282c50f3decf]
stable/6.6: [49d640d2946c35a17b051d54171a032dd95b0f50]
stable/6.8: [ced63fffd63072c0ca55d5a451010d71bf08c0b3]

CVE-2024-27388: SUNRPC: fix some memleaks in gssx_dec_option_array

Announce: https://lore.kernel.org/linux-cve-announce/2024050135-CVE-2024-27388-04eb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 1d65833 ("SUNRPC: Add RPC based upcall mechanism
for RPCGSS auth") in v3.10-rc1.
Fixed in v6.9-rc1.

Fixed status
cip/4.4: [fd2507f998926b304ebe36d812747858526148b9]
cip/4.4-st: [fd2507f998926b304ebe36d812747858526148b9]
mainline: [3cfcfc102a5e57b021b786a755a38935e357797d]
stable/4.19: [b97c37978ca825557d331c9012e0c1ddc0e42364]
stable/5.10: [bb336cd8d5ecb69c430ebe3e7bcff68471d93fa8]
stable/5.15: [dd292e884c649f9b1c18af0ec75ca90b390cd044]
stable/5.4: [bfa9d86d39a0fe4685f90c3529aa9bd62a9d97a8]
stable/6.1: [934212a623cbab851848b6de377eb476718c3e4c]
stable/6.6: [5e6013ae2c8d420faea553d363935f65badd32c3]
stable/6.8: [996997d1fb2126feda550d6adcedcbd94911fc69]

CVE-2024-27389: pstore: inode: Only d_invalidate() is needed

Announce: https://lore.kernel.org/linux-cve-announce/2024050135-CVE-2024-27389-fb3a@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 609e28b ("pstore: Remove filesystem records when
backend is unregistered") in v5.8-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [a43e0fc5e9134a46515de2f2f8d4100b74e50de3]
stable/6.1: [db6e5e16f1ee9e3b01d2f71c7f0ba945f4bf0f4e]
stable/6.6: [4cdf9006fc095af71da80e9b5f48a32e991b9ed3]
stable/6.8: [340682ed1932b8e3bd0bfc6c31a0c6354eb57cc6]

CVE-2024-27390: ipv6: mcast: remove one synchronize_net() barrier in
ipv6_mc_down()

Announce: https://lore.kernel.org/linux-cve-announce/2024050135-CVE-2024-27390-e55f@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f185de2 ("mld: add new workqueues for process mld
events") in v5.13-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [17ef8efc00b34918b966388b2af0993811895a8c]
stable/5.15: [9d159d6637ccce25f879d662a480541ef4ba3a50]
stable/6.1: [a03ede2282ebbd181bd6f5c38cbfcb5765afcd04]
stable/6.6: [26d4bac55750d535f1f0b8790dc26daf6089e373]
stable/6.8: [5da9a218340a2bc804dc4327e5804392e24a0b88]

CVE-2024-27391: wifi: wilc1000: do not realloc workqueue everytime an
interface is added

Announce: https://lore.kernel.org/linux-cve-announce/2024050135-CVE-2024-27391-6014@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 09ed8bf ("wilc1000: Rename workqueue from
"WILC_wq" to "NETDEV-wq"") in v5.17-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [328efda22af81130c2ad981c110518cb29ff2f1d]
stable/6.1: [515cc676dfbce40d93c92b1ff3c1070e917f4e52]
stable/6.6: [4041c60a9d543b3ad50225385b072ba68e96166e]
stable/6.8: [9ab0c303ccabfd6bdce14432792d41090070008c]

CVE-2024-27392: nvme: host: fix double-free of struct nvme_id_ns in
ns_update_nuse()

Announce: https://lore.kernel.org/linux-cve-announce/2024050136-CVE-2024-27392-b84b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a1a825a ("nvme: add csi, ms and nuse to sysfs")
in v6.8-rc1.
This commit was not backported to older stable kernels.
Fixed in v6.9-rc1.

Fixed status
mainline: [8d0d2447394b13fb22a069f0330f9c49b7fff9d3]
stable/6.8: [534f9dc7fe495b3f9cc84363898ac50c5a25fccb]

* Updated CVEs

CVE-2024-26605: PCI/ASPM: Fix deadlock when enabling ASPM

stable 6.1 and 6.6 were fixed.

Fixed status
mainline: [1e560864159d002b453da42bd2c13a1805515a20]
stable/6.1: [0f7908a016c092cfdaa16d785fa5099d867bc1a3]
stable/6.6: [b0f4478838be1f1d330061201898fef65bf8fd7c]
stable/6.7: [ef90508574d7af48420bdc5f7b9a4f1cdd26bc70]

CVE-2024-26811: ksmbd: validate payload size in ipc response

stable 5.15 was fixed.

Fixed status
mainline: [a677ebd8ca2f2632ccdecbad7b87641274e15aac]
stable/5.15: [88b7f1143b15b29cccb8392b4f38e75b7bb3e300]
stable/6.1: [51a6c2af9d20203ddeeaf73314ba8854b38d01bd]
stable/6.6: [a637fabac554270a851033f5ab402ecb90bc479c]
stable/6.8: [76af689a45aa44714b46d1a7de4ffdf851ded896]

CVE-2024-26922: drm/amdgpu: validate the parameters of bo mapping
operations more clearly

stable 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [6fef2d4c00b5b8561ad68dd2b68173f5c6af1e75]
stable/5.15: [8b12fc7b032633539acdf7864888b0ebd49e90f2]
stable/6.1: [212e3baccdb1939606420d88f7f52d346b49a284]
stable/6.6: [ef13eeca7c79136bc38e21eb67322c1cbd5c40ee]
stable/6.8: [b1f04b9b1c5317f562a455384c5f7473e46bdbaa]

CVE-2024-26924: netfilter: nft_set_pipapo: do not free live element

stable 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [3cfc9ec039af60dbd8965ae085b2c2ccdcfbe1cc]
stable/5.15: [7a1679e2d9bfa3b5f8755c2c7113e54b7d42bd46]
stable/6.1: [41d8fdf3afaff312e17466e4ab732937738d5644]
stable/6.6: [ebf7c9746f073035ee26209e38c3a1170f7b349a]
stable/6.8: [14b001ba221136c15f894577253e8db535b99487]

CVE-2024-26926: binder: check offset alignment in binder_get_object()

stable 5.15, 6.1, 6.6, and 6.8 were fixed.

Fixed status
mainline: [aaef73821a3b0194a01bd23ca77774f704a04d40]
stable/5.15: [a2fd6dbc98be1105a1d8e9e31575da8873ef115c]
stable/6.1: [a6d2a8b211c874971ee4cf3ddd167408177f6e76]
stable/6.6: [1d7f1049035b2060342f11eff957cf567d810bdc]
stable/6.8: [f01d6619045704d78613b14e2e0420bfdb7f1c15]

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

