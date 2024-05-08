Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522A4C04FFE
	for <webhook@archiver.kernel.org>; Wed,  8 May 2024 23:46:39 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web11.2121.1715211995635596996
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 May 2024 16:46:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=BlB5W09x;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.54, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f04ec1b501so149627a34.2
        for <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1715211994; x=1715816794; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MZSK+/XjftUNOUFghcxPaPCmUzgeBCEX8WuU0eLdnhM=;
        b=BlB5W09xAQ50dXbGlBXszgueQc0AdaigyK5/XJqkzC2Zq7QffO7E3gH8udVo9bshsF
         7IPpJLl+nl/tWF4U3vvVBteg3W9Ure9Fb++W0k+Bovvs9Wl22V+81kHS9FfxVIMwsmyO
         +aLz5Vmhuij5pHT2Vfx1QLMXIz5J/GSilwpAqr4cJKcnT+9N7awy9i77ahvyR4ZP19L3
         no9f+dYTON1mKLclmH1XEe736Fd0uhqMnIUp2yNU4xV6vGkN2DCzxufEUo34TF4fypM+
         2PYqEb3I3i9SgpcXYcQgB3ZdTdvtWykOzXaPCWnwrNmLdsI2x4zqaJBvXSfnZ1DXp67p
         fqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715211994; x=1715816794;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZSK+/XjftUNOUFghcxPaPCmUzgeBCEX8WuU0eLdnhM=;
        b=XfcMGPAMYJH6c7WYz9KvbXjkxsP+QLAEUxa/6ZutQitNmqFhtJ3SAuEBzmRRveFj8R
         aQ2t/oKrdJBEaU1bVedveUQL3X5K65nqyfE8zIlsY5r2QzDQz9CK3SnxiWozosbZgZze
         5TNibqww4diWH+VcLR5kt1j3Xeqqk+dtEBNvhy9XQ51K/yv976idkaOFmGhUiq9P7YWZ
         AqIyUzkzNiA9Jh41+J7zgwZNvyH4kX40kQ775/PDIzspJ35Sc7Sha/NE6zVaqgii2o1U
         SEXnceJRIlS5SRkm4/EurtjVLH8F68yxBVH9TmCFBjbW8J4LyvOrO+oH5qDZoK4OU/wa
         GrDA==
X-Gm-Message-State: AOJu0Ywkde3af4/S+BV7oFqGV/uiDOqtEUoGqaeYYLqJrfRmctJl5qdG
	qZOaBpC2cWR6AxBe6xWhXGOEMlMQZR0i1USjNLR8IqgUBCJLF1JSm4ioYjcvlntwGjtXsrLZEKa
	4BBUI9l+yoUUYLS3B8AeYgWt+WA3vfJtvZV0JGCvQYgiNDpRZTkc=
X-Google-Smtp-Source: AGHT+IGscESO1Fkh5SS7bN/q4F3Gc/bBB/x42sRVCggYcqTtTNd58W34hRASGeq/+M7gq/oMTBM65qD2JnxYotnXGp0=
X-Received: by 2002:a05:6870:944d:b0:229:a2a4:58b7 with SMTP id
 586e51a60fabf-240985a4a36mr4265272fac.40.1715211993955; Wed, 08 May 2024
 16:46:33 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 May 2024 08:45:57 +0900
Message-ID: <CAODzB9qV9pzGnF+X7ScxPc8=gRq8j_FqEk3fj765Pn2jvLJVDA@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 May 2024 23:46:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15867

Hi!

It's this week's CVE report.

This week reported 32 new CVEs and 28 updated CVEs.

* New CVEs

CVE-2022-48670: peci: cpu: Fix use-after-free in adev_release()

Announce: https://lore.kernel.org/linux-cve-announce/2024050314-CVE-2022-48670-f9f1@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc4.
It seems to be commit 93e1821 ("peci: Add peci-cpu driver") in
5.18-rc1 introduced this bug.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [1c11289b34ab67ed080bbe0f1855c4938362d9cf]

CVE-2022-48671: cgroup: Add missing cpus_read_lock() to cgroup_attach_task_all()

Announce: https://lore.kernel.org/linux-cve-announce/2024050317-CVE-2022-48671-fbdd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This bug was introduced by commit 4f7e723 ("cgroup: Fix
threadgroup_rwsem <-> cpus_read_lock() deadlock") in 6.0-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [43626dade36fa74d3329046f4ae2d7fdefe401c6]
stable/4.19: [321488cfac7d0eb6d97de467015ff754f85813ff]
stable/5.10: [07191f984842d50020789ff14c75da436a7f46a9]
stable/5.15: [9f267393b036f1470fb12fb892d59e7ff8aeb58d]
stable/5.4: [321488cfac7d0eb6d97de467015ff754f85813ff]

CVE-2022-48672: of: fdt: fix off-by-one error in unflatten_dt_nodes()

Announce: https://lore.kernel.org/linux-cve-announce/2024050318-CVE-2022-48672-b6d9@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 78c44d9 ("drivers/of: Fix depth when unflattening
devicetree") in v4.7-rc1.
Fixed in v6.0-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [2f945a792f67815abca26fa8a5e863ccf3fa1181]
stable/4.19: [2566706ac6393386a4e7c4ce23fe17f4c98d9aa0]
stable/5.10: [ee4369260e77821602102dcc7d792de39a56365c]
stable/5.15: [ba6b9f7cc1108bad6e2c53b1d6e0156379188db7]
stable/5.4: [e0e88c25f88b9805572263c9ed20f1d88742feaf]

CVE-2022-48673: net/smc: Fix possible access to freed memory in link clear

Announce: https://lore.kernel.org/linux-cve-announce/2024050318-CVE-2022-48673-1692@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit bd4ad57 ("smc: initialize IB transport incl. PD,
MR, QP, CQ, event, WR") in v4.11-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [e9b1a4f867ae9c1dbd1d71cd09cbdb3239fb4968]

CVE-2022-48674: erofs: fix pcluster use-after-free on UP platforms

Announce: https://lore.kernel.org/linux-cve-announce/2024050318-CVE-2022-48674-b876@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 73f5c66 ("staging: erofs: fix
`erofs_workgroup_{try_to_freeze, unfreeze}'") in v5.0-rc1.
Fixed in v6.0-rc5.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt stable/4.19

Fixed status
mainline: [2f44013e39984c127c6efedf70e6b5f4e9dcf315]
stable/5.15: [8ddd001cef5e82d19192e6861068463ecca5f556]

CVE-2022-48675: IB/core: Fix a nested dead lock as part of ODP flow

Announce: https://lore.kernel.org/linux-cve-announce/2024050319-CVE-2022-48675-6ff4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 36f30e4 ("IB/core: Improve ODP to use
hmm_range_fault()") in v5.10-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [85eaeb5058f0f04dffb124c97c86b4f18db0b833]
stable/5.10: [e8de6cb5755eae7b793d8c00c8696c8667d44a7f]
stable/5.15: [819110054b14d7272b4188db997a3d80f75ab785]

CVE-2022-48686: nvme-tcp: fix UAF when detecting digest errors

Announce: https://lore.kernel.org/linux-cve-announce/2024050342-CVE-2022-48686-5e8e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 3f2304f ("nvme-tcp: add NVMe over TCP host
driver") in v5.0-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [160f3549a907a50e51a8518678ba2dcf2541abea]
stable/5.10: [5914fa32ef1b7766fea933f9eed94ac5c00aa7ff]
stable/5.15: [13c80a6c112467bab5e44d090767930555fc17a5]
stable/5.4: [19816a0214684f70b49b25075ff8c402fdd611d3]

CVE-2022-48687: ipv6: sr: fix out-of-bounds read when setting HMAC data.

Announce: https://lore.kernel.org/linux-cve-announce/2024050344-CVE-2022-48687-b82e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 4f4853d ("ipv6: sr: implement API to control SR
HMAC structure") in v4.10-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [84a53580c5d2138c7361c7c3eea5b31827e63b35]
stable/4.19: [f684c16971ed5e77dfa25a9ad25b5297e1f58eab]
stable/5.10: [076f2479fc5a15c4a970ca3b5e57d42ba09a31fa]
stable/5.15: [55195563ec29f80f984237b743de0e2b6ba4d093]
stable/5.4: [3df71e11a4773d775c3633c44319f7acdb89011c]

CVE-2022-48688: i40e: Fix kernel crash during module removal

Announce: https://lore.kernel.org/linux-cve-announce/2024050345-CVE-2022-48688-7306@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0ef2d5a ("i40e: KISS the client interface") in v4.12-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [fb8396aeda5872369a8ed6d2301e2c86e303c520]
stable/4.19: [c49f320e2492738d478bc427dcd54ccfe0cba746]
stable/5.10: [342d77769a6cceb3df7720a1e18baa4339eee3fc]
stable/5.15: [2ed94383f3a2693dbf5bc47c514b42524bd8f9ae]
stable/5.4: [5332a094514852d5e58c278cf4193adb937337fc]

CVE-2022-48689: tcp: TX zerocopy should not sense pfmemalloc status

Announce: https://lore.kernel.org/linux-cve-announce/2024050345-CVE-2022-48689-5ee7@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c07aea3 ("mm: add a signature in struct page") in
v5.14-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [3261400639463a853ba2b3be8bd009c2a8089775]
stable/5.15: [8527c9a6bf8e54fef0a8d3d7d8874a48c725c915]

CVE-2022-48690: ice: Fix DMA mappings leak

Announce: https://lore.kernel.org/linux-cve-announce/2024050346-CVE-2022-48690-53bc@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 617f3e1 ("ice: xsk: allocate separate memory for
XDP SW ring") in v5.16-rc7.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [7e753eb675f0523207b184558638ee2eed6c9ac2]

CVE-2022-48691: netfilter: nf_tables: clean up hook list when offload
flags check fails

Announce: https://lore.kernel.org/linux-cve-announce/2024050346-CVE-2022-48691-5f16@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit d54725c ("netfilter: nf_tables: support for
multiple devices per netdev hook") in v5.5-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [77972a36ecc4db7fc7c68f0e80714263c5f03f65]
stable/5.10: [910891a2a44cdc49efcc4fe7459c1085ba00d0f4]
stable/5.15: [1ce55ec5cb7c573c983dffbe290b8d17caf1f157]

CVE-2022-48692: RDMA/srp: Set scmnd->result only when scmnd is not NULL

Announce: https://lore.kernel.org/linux-cve-announce/2024050346-CVE-2022-48692-6bc3@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit ad215aa ("RDMA/srp: Make struct scsi_cmnd and
struct srp_request adjacent") in v5.14-rc1.
Fixed in v5.19.9.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [f2c70f56f762e5dc3b0d7dc438fbb137cb116413]
stable/5.10: [f022576aa03c2385ea7f2b27ee5b331e43abf624]
stable/5.15: [f022576aa03c2385ea7f2b27ee5b331e43abf624]

CVE-2022-48693: soc: brcmstb: pm-arm: Fix refcount leak and __iomem leak bugs

Announce: https://lore.kernel.org/linux-cve-announce/2024050347-CVE-2022-48693-3e82@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0b741b8 ("soc: bcm: brcmstb: Add support for
S2/S3/S5 suspend states (ARM)") in v4.15-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [1085f5080647f0c9f357c270a537869191f7f2a1]
stable/4.19: [0284b4e6dec6088a41607aa3f42bf51edff01883]
stable/5.10: [6dc0251638a4a1a998506dbd4627f8317e907558]
stable/5.15: [43245c77d9efd8c9eb91bf225d07954dcf32204d]
stable/5.4: [57b2897ec3ffe4cbe018446be6d04432919dca6b]

CVE-2022-48694: RDMA/irdma: Fix drain SQ hang with no completion

Announce: https://lore.kernel.org/linux-cve-announce/2024050347-CVE-2022-48694-f0e8@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 81091d7 ("RDMA/irdma: Add SW mechanism to
generate completions on error") in v5.19-rc1.
Fixed in v5.19.9.
Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [5becc531a3fa8da75158a8993f56cc3e0717716e]

CVE-2022-48695: scsi: mpt3sas: Fix use-after-free warning

Announce: https://lore.kernel.org/linux-cve-announce/2024050348-CVE-2022-48695-8a9e@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc5.

Fixed status
cip/4.4: [e34e499d527c3e227991fec1b3e352dc3ec047ee]
cip/4.4-rt: [e34e499d527c3e227991fec1b3e352dc3ec047ee]
cip/4.4-st: [e34e499d527c3e227991fec1b3e352dc3ec047ee]
mainline: [991df3dd5144f2e6b1c38b8d20ed3d4d21e20b34]
stable/4.19: [82efb917eeb27454dc4c6fe26432fc8f6c75bc16]
stable/5.10: [ea10a652ad2ae2cf3eced6f632a5c98f26727057]
stable/5.15: [6229fa494a5949be209bc73afbc5d0a749c2e3c7]
stable/5.4: [5682c94644fde72f72bded6580c38189ffc856b5]

CVE-2022-48696: regmap: spi: Reserve space for register address/padding

Announce: https://lore.kernel.org/linux-cve-announce/2024050348-CVE-2022-48696-b671@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit f231ff3 ("regmap: spi: Set regmap max raw r/w
from max_transfer_size") in v5.16-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [f5723cfc01932c7a8d5c78dbf7e067e537c91439]

CVE-2022-48697: nvmet: fix a use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024050348-CVE-2022-48697-1df4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit a07b497 ("nvmet: add a generic NVMe target") in v4.8-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [6a02a61e81c231cc5c680c5dbf8665275147ac52]
stable/4.19: [17f121ca3ec6be0fb32d77c7f65362934a38cc8e]
stable/5.10: [be01f1c988757b95f11f090a9f491365670a522b]
stable/5.15: [ebf46da50beb78066674354ad650606a467e33fa]
stable/5.4: [8d66989b5f7bb28bba2f8e1e2ffc8bfef4a10717]

CVE-2022-48698: drm/amd/display: fix memory leak when using debugfs_lookup()

Announce: https://lore.kernel.org/linux-cve-announce/2024050349-CVE-2022-48698-ac39@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc5.
It seems to be commit 86bc2219 ("drm/amd/display: Support crc on
specific region") in 5.13-rc1 introduced this bug.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [cbfac7fa491651c57926c99edeb7495c6c1aeac2]
stable/5.15: [58acd2ebae034db3bacf38708f508fbd12ae2e54]

CVE-2022-48699: sched/debug: fix dentry leak in update_sched_domain_debugfs

Announce: https://lore.kernel.org/linux-cve-announce/2024050349-CVE-2022-48699-8b9b@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc5.
It seems to be commit 3b87f136 ("sched,debug: Convert sysctl
sched_domains to debugfs") in 5.13-rc1 introduced this bug.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [c2e406596571659451f4b95e37ddfd5a8ef1d0dc]
stable/5.15: [26e9a1ded8923510e5529fbb28390b22228700c2]

CVE-2022-48700: vfio/type1: Unpin zero pages

Announce: https://lore.kernel.org/linux-cve-announce/2024050349-CVE-2022-48700-c756@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc5.
It seems to be commit 4b6c33b3 ("vfio/type1: Prepare for batched
pinning with struct vfio_batch") in 5.12-rc1dontuse introduced this
bug.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [873aefb376bbc0ed1dd2381ea1d6ec88106fdbd4]
stable/5.10: [578d644edc7d2c1ff53f7e4d0a25da473deb4a03]
stable/5.15: [5321908ef74fb593e0dbc8737d25038fc86c9986]

CVE-2022-48701: ALSA: usb-audio: Fix an out-of-bounds bug in
__snd_usb_parse_audio_interface()

Announce: https://lore.kernel.org/linux-cve-announce/2024050350-CVE-2022-48701-eadb@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc5.

Fixed status
cip/4.4: [5d45c78c420aeba3d2240644baca7a338e5d80b3]
cip/4.4-rt: [5d45c78c420aeba3d2240644baca7a338e5d80b3]
cip/4.4-st: [5d45c78c420aeba3d2240644baca7a338e5d80b3]
mainline: [e53f47f6c1a56d2af728909f1cb894da6b43d9bf]
stable/4.19: [2a308e415d247a23d4d64c964c02e782eede2936]
stable/5.10: [6123bec8480d23369e2ee0b2208611619f269faf]
stable/5.15: [98e8e67395cc6d0cdf3a771f86ea42d0ee6e59dd]
stable/5.4: [0492798bf8dfcc09c9337a1ba065da1d1ca68712]

CVE-2022-48702: ALSA: emu10k1: Fix out of bounds access in
snd_emu10k1_pcm_channel_alloc()

Announce: https://lore.kernel.org/linux-cve-announce/2024050350-CVE-2022-48702-47dd@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc5.

Fixed status
cip/4.4: [992267de945e60186027b8e9a9924a160acce5c7]
cip/4.4-rt: [992267de945e60186027b8e9a9924a160acce5c7]
cip/4.4-st: [992267de945e60186027b8e9a9924a160acce5c7]
mainline: [d29f59051d3a07b81281b2df2b8c9dfe4716067f]
stable/4.19: [88aac6684cf8bc885cca15463cb4407e91f28ff7]
stable/5.10: [39a90720f3abe96625d1224e7a7463410875de4c]
stable/5.15: [45814a53514e10a8014906c882e0d0d38df39cc1]
stable/5.4: [45321a7d02b7cf9b3f97e3987fc1e4d649b82da2]

CVE-2022-48703: thermal/int340x_thermal: handle data_vault when the
value is ZERO_SIZE_PTR

Announce: https://lore.kernel.org/linux-cve-announce/2024050351-CVE-2022-48703-3099@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc3.
It seems to be commit 0ba13c7 ("thermal/int340x_thermal: Export GDDV")
in 5.8-rc1 introduced this bug.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [7931e28098a4c1a2a6802510b0cbe57546d2049d]

CVE-2022-48704: drm/radeon: add a force flush to delay work when radeon

Announce: https://lore.kernel.org/linux-cve-announce/2024050351-CVE-2022-48704-e1ea@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced commit is not determined.Fixed in v6.0-rc3.
Bug introduced commit is not backported to older stable kernels

Fixed status
cip/4.4: [e9d399fd4f22f833d6cb991feb14a8a3b0d4847d]
cip/4.4-rt: [e9d399fd4f22f833d6cb991feb14a8a3b0d4847d]
cip/4.4-st: [e9d399fd4f22f833d6cb991feb14a8a3b0d4847d]
mainline: [f461950fdc374a3ada5a63c669d997de4600dffe]
stable/4.19: [c0a45f41fde4a0f2c900f719817493ee5c4a5aa3]
stable/5.10: [826b46fd5974113515abe9e4fc8178009a8ce18c]
stable/5.15: [5a7a5b2edac4b05abd744eeaebda46d9dacd952d]
stable/5.4: [c72d97146fc5a4dff381b1737f6167e89860430d]

CVE-2022-48705: wifi: mt76: mt7921e: fix crash in chip reset fail

Announce: https://lore.kernel.org/linux-cve-announce/2024050351-CVE-2022-48705-a5c4@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0efaf31 ("mt76: mt7921: fix MT7921E reset
failure") in v5.17-rc1.
Fixed in v6.0-rc5.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [fa3fbe64037839f448dc569212bafc5a495d8219]

CVE-2023-52654: io_uring/af_unix: disable sending io_uring over sockets

Announce: https://lore.kernel.org/linux-cve-announce/2024050833-CVE-2023-52654-1ae1@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 0091bfc ("io_uring/af_unix: defer registered
files gc to io_uring release") in 6.1-rc1.
Fixed in 6.7-rc5.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15 stable/5.4 stable/6.1 stable/6.6

Fixed status
mainline: [705318a99a138c29a512a72c3e0043b3cd7f55f4]
stable/5.10: [3fe1ea5f921bf5b71cbfdc4469fb96c05936610e]
stable/5.15: [bcedd497b3b4a0be56f3adf7c7542720eced0792]
stable/5.4: [18824f592aad4124d79751bbc1500ea86ac3ff29]
stable/6.1: [f2f57f51b53be153a522300454ddb3887722fb2c]
stable/6.6: [5a33d385eb36991a91e3dddb189d8679e2aac2be]

CVE-2024-27393: xen-netfront: Add missing skb_mark_for_recycle

Announce: https://lore.kernel.org/linux-cve-announce/2024050835-CVE-2024-27393-b804@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 6c5aa6f ("xen networking: add basic XDP support
for xen-netfront") in 5.9-rc1.
Fixed in 6.9-rc3.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [037965402a010898d34f4e35327d22c0a95cd51f]
stable/5.15: [4143b9479caa29bb2380f3620dcbe16ea84eb3b1]
stable/6.1: [7c1250796b6c262b505a46192f4716b8c6a6a8c6]
stable/6.6: [27aa3e4b3088426b7e34584274ad45b5afaf7629]
stable/6.8: [c8b7b2f158d9d4fb89cd2f68244af154f7549bb4]

CVE-2024-27394: tcp: Fix Use-After-Free in tcp_ao_connect_init

Announce: https://lore.kernel.org/linux-cve-announce/2024050836-CVE-2024-27394-4277@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 7c2ffaf ("net/tcp: Calculate TCP-AO traffic
keys") in 6.7-rc1. Fixed in 6.9-rc6
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [80e679b352c3ce5158f3f778cfb77eb767e586fb]
stable/6.8: [ca4fb6c6764b3f75b4f5aa81db1536291897ff7f]

CVE-2024-27395: net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Announce: https://lore.kernel.org/linux-cve-announce/2024050836-CVE-2024-27395-573e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 11efd5c ("openvswitch: Support conntrack zone
limit") in 4.18-rc1.
Fixed in 6.9-rc6.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [5ea7b72d4fac2fdbc0425cd8f2ea33abe95235b2]
stable/4.19: [2db9a8c0a01fa1c762c1e61a13c212c492752994]
stable/5.10: [35880c3fa6f8fe281a19975d2992644588ca33d3]
stable/5.15: [9048616553c65e750d43846f225843ed745ec0d4]
stable/5.4: [589523cf0b384164e445dd5db8d5b1bf97982424]
stable/6.1: [bca6fa2d9a9f560e6b89fd5190b05cc2f5d422c1]
stable/6.6: [eaa5e164a2110d2fb9e16c8a29e4501882235137]
stable/6.8: [edee0758747d7c219e29db9ed1d4eb33e8d32865]

CVE-2024-27396: net: gtp: Fix Use-After-Free in gtp_dellink

Announce: https://lore.kernel.org/linux-cve-announce/2024050837-CVE-2024-27396-e9af@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 94dc550 ("gtp: fix an use-after-free in
ipv4_pdp_find()") in 5.5-rc3.
Fixed in 6.9-rc6.
Bug introduced commit was backported to following branches.
cip/4.19 stable/4.19 stable/5.4

Fixed status
mainline: [f2a904107ee2b647bb7794a1a82b67740d7c8a64]
stable/4.19: [07b20d0a3dc13fb1adff10b60021a4924498da58]
stable/5.10: [0caff3e6390f840666b8dc1ecebf985c2ef3f1dd]
stable/5.15: [2e74b3fd6bf542349758f283676dff3660327c07]
stable/5.4: [718df1bc226c383dd803397d7f5d95557eb81ac7]
stable/6.1: [25a1c2d4b1fcf938356a9688a96a6456abd44b29]
stable/6.6: [2aacd4de45477582993f8a8abb9505a06426bfb6]
stable/6.8: [cd957d1716ec979d8f5bf38fc659aeb9fdaa2474]

CVE-2024-27397: netfilter: nf_tables: use timestamp to check for set
element timeout

Announce: https://lore.kernel.org/linux-cve-announce/2024050837-CVE-2024-27397-fd1e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit c3e1b00 ("netfilter: nf_tables: add set element
timeout support") in 4.1-rc1.
Fixed in 6.8-rc4.
Bug introduced commit is not backported to older stable kernels

Fixed status
mainline: [7395dfacfff65e9938ac0889dafa1ab01e987d15]

* Updated CVEs

CVE-2023-52429: dm: limit the number of targets and parameter size area

stable/5.4 was fixed.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]
stable/5.10: [a891a0621e725e85529985139cada8cb5a74a116]
stable/5.15: [888a0a46b80fa37eacfe81faf47ba0b83876251d]
stable/5.4: [86f4a49f32e2392c97296e89da8c25e8fb482c0d]
stable/6.1: [c5d83ac2bf6ca668a39ffb1a576899a66153ba19]
stable/6.6: [438d19492b7f002334573bae43276297eb234c80]
stable/6.7: [cd70175481f63af31901dd463e44386f033c3f4c]

CVE-2023-52614: PM / devfreq: Fix buffer overflow in trans_stat_show

stable/5.10 was fixed.

Fixed status
mainline: [08e23d05fa6dc4fc13da0ccf09defdd4bbc92ff4]
stable/5.10: [087de000e4f8c878c81d9dd3725f00a1d292980c]
stable/5.15: [796d3fad8c35ee9df9027899fb90ceaeb41b958f]
stable/6.1: [8a7729cda2dd276d7a3994638038fb89035b6f2c]
stable/6.6: [a979f56aa4b93579cf0e4265ae04d7e9300fd3e8]
stable/6.7: [eaef4650fa2050147ca25fd7ee43bc0082e03c87]

CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate
memory more than INT_MAX bytes

stable/5.4 was fixed.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]
stable/5.10: [a891a0621e725e85529985139cada8cb5a74a116]
stable/5.15: [888a0a46b80fa37eacfe81faf47ba0b83876251d]
stable/5.4: [86f4a49f32e2392c97296e89da8c25e8fb482c0d]
stable/6.1: [c5d83ac2bf6ca668a39ffb1a576899a66153ba19]
stable/6.6: [438d19492b7f002334573bae43276297eb234c80]
stable/6.7: [cd70175481f63af31901dd463e44386f033c3f4c]

CVE-2024-26922: drm/amdgpu: validate the parameters of bo mapping
operations more clearly

stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
mainline: [6fef2d4c00b5b8561ad68dd2b68173f5c6af1e75]
stable/4.19: [d4da6b084f1c5625937d49bb6722c5b4aef11b8d]
stable/5.10: [1fd7db5c16028dc07b2ceec190f2e895dddb532d]
stable/5.15: [8b12fc7b032633539acdf7864888b0ebd49e90f2]
stable/5.4: [f68039375d4d6d67303674c0ab2d06b7295c0ec9]
stable/6.1: [212e3baccdb1939606420d88f7f52d346b49a284]
stable/6.6: [ef13eeca7c79136bc38e21eb67322c1cbd5c40ee]
stable/6.8: [b1f04b9b1c5317f562a455384c5f7473e46bdbaa]

CVE-2024-26923: af_unix: Fix garbage collector racing against connect()

stable/5.10 and stable/5.4 were fixed.

Fixed status
mainline: [47d8ac011fe1c9251070e1bd64cb10b48193ec51]
stable/5.10: [2e2a03787f4f0abc0072350654ab0ef3324d9db3]
stable/5.15: [e76c2678228f6aec74b305ae30c9374cc2f28a51]
stable/5.4: [343c5372d5e17b306db5f8f3c895539b06e3177f]
stable/6.1: [b75722be422c276b699200de90527d01c602ea7c]
stable/6.6: [507cc232ffe53a352847893f8177d276c3b532a9]
stable/6.8: [dbdf7bec5c920200077d693193f989cb1513f009]

CVE-2024-26924: netfilter: nft_set_pipapo: do not free live element

stable/5.10 was fixed.

Fixed status
mainline: [3cfc9ec039af60dbd8965ae085b2c2ccdcfbe1cc]
stable/5.10: [e3b887a9c11caf8357a821260e095f2a694a34f2]
stable/5.15: [7a1679e2d9bfa3b5f8755c2c7113e54b7d42bd46]
stable/6.1: [41d8fdf3afaff312e17466e4ab732937738d5644]
stable/6.6: [ebf7c9746f073035ee26209e38c3a1170f7b349a]
stable/6.8: [14b001ba221136c15f894577253e8db535b99487]

CVE-2024-26926: binder: check offset alignment in binder_get_object()

stable/5.10 and stable/5.4 were fixed.

Fixed status
mainline: [aaef73821a3b0194a01bd23ca77774f704a04d40]
stable/5.10: [48a1f83ca9c68518b1a783c62e6a8223144fa9fc]
stable/5.15: [a2fd6dbc98be1105a1d8e9e31575da8873ef115c]
stable/5.4: [68a28f551e4690db2b27b3db716c7395f6fada12]
stable/6.1: [a6d2a8b211c874971ee4cf3ddd167408177f6e76]
stable/6.6: [1d7f1049035b2060342f11eff957cf567d810bdc]
stable/6.8: [f01d6619045704d78613b14e2e0420bfdb7f1c15]

CVE-2024-26981: nilfs2: fix OOB in nilfs_set_de_type

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [5c5723287db65ce57c5d5b36f6d7de718051806d]
cip/4.4-st: [5c5723287db65ce57c5d5b36f6d7de718051806d]
mainline: [c4a7dc9523b59b3e73fd522c73e95e072f876b16]
stable/4.19: [054f29e9ca05be3906544c5f2a2c7321c30a4243]
stable/5.10: [7061c7efbb9e8f11ce92d6b4646405ea2b0b4de1]
stable/5.15: [bdbe483da21f852c93b22557b146bc4d989260f0]
stable/5.4: [90f43980ea6be4ad903e389be9a27a2a0018f1c8]
stable/6.1: [897ac5306bbeb83e90c437326f7044c79a17c611]
stable/6.6: [2382eae66b196c31893984a538908c3eb7506ff9]
stable/6.8: [90823f8d9ecca3d5fa6b102c8e464c62f416975f]

CVE-2024-26982: Squashfs: check the inode number is not the invalid
value of zero

stable/6.6 was fixed.

Fixed status
mainline: [9253c54e01b6505d348afbc02abaa4d9f8a01395]
stable/6.6: [be383effaee3d89034f0828038f95065b518772e]
stable/6.8: [7def00ebc9f2d6a581ddf46ce4541f84a10680e5]

CVE-2024-26984: nouveau: fix instmem race condition around ptr stores

stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
mainline: [fff1386cc889d8fb4089d285f883f8cba62d82ce]
stable/4.19: [bba8ec5e9b16649d85bc9e9086bf7ae5b5716ff9]
stable/5.10: [13d76b2f443dc371842916dd8768009ff1594716]
stable/5.15: [3ab056814cd8ab84744c9a19ef51360b2271c572]
stable/5.4: [1bc4825d4c3ec6abe43cf06c3c39d664d044cbf7]
stable/6.1: [ad74d208f213c06d860916ad40f609ade8c13039]
stable/6.6: [a019b44b1bc6ed224c46fb5f88a8a10dd116e525]
stable/6.8: [21ca9539f09360fd83654f78f2c361f2f5ddcb52]

CVE-2024-26988: init/main.c: Fix potential static_command_line memory overflow

stable/5.10 was fixed.

Fixed status
mainline: [46dad3c1e57897ab9228332f03e1c14798d2d3b9]
stable/5.10: [2ef607ea103616aec0289f1b65d103d499fa903a]
stable/5.15: [0dc727a4e05400205358a22c3d01ccad2c8e1fe4]
stable/6.1: [76c2f4d426a5358fced5d5990744d46f10a4ccea]
stable/6.6: [81cf85ae4f2dd5fa3e43021782aa72c4c85558e8]
stable/6.8: [936a02b5a9630c5beb0353c3085cc49d86c57034]

CVE-2024-26993: fs: sysfs: Fix reference leak in sysfs_break_active_protection()

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [f3ae929f687a1b687dab720c39807998cdc31979]
cip/4.4-st: [f3ae929f687a1b687dab720c39807998cdc31979]
mainline: [a90bca2228c0646fc29a72689d308e5fe03e6d78]
stable/4.19: [f28bba37fe244889b81bb5c508d3f6e5c6e342c5]
stable/5.10: [84bd4c2ae9c3d0a7d3a5c032ea7efff17af17e17]
stable/5.15: [43f00210cb257bcb0387e8caeb4b46375d67f30c]
stable/5.4: [57baab0f376bec8f54b0fe6beb8f77a57c228063]
stable/6.1: [5d43e072285e81b0b63cee7189b3357c7768a43b]
stable/6.6: [ac107356aabc362aaeb77463e814fc067a5d3957]
stable/6.8: [a4c99b57d43bab45225ba92d574a8683f9edc8e4]

CVE-2024-26994: peakup: Avoid crash on very long word

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [6b94a00ec8d153f2417401c4a4abb515ec31a5f4]
cip/4.4-st: [6b94a00ec8d153f2417401c4a4abb515ec31a5f4]
mainline: [c8d2f34ea96ea3bce6ba2535f867f0d4ee3b22e1]
stable/4.19: [756c5cb7c09e537b87b5d3acafcb101b2ccf394f]
stable/5.10: [6401038acfa24cba9c28cce410b7505efadd0222]
stable/5.15: [0d130158db29f5e0b3893154908cf618896450a8]
stable/5.4: [8f6b62125befe1675446923e4171eac2c012959c]
stable/6.1: [89af25bd4b4bf6a71295f07e07a8ae7dc03c6595]
stable/6.6: [8defb1d22ba0395b81feb963b96e252b097ba76f]
stable/6.8: [0efb15c14c493263cb3a5f65f5ddfd4603d19a76]

CVE-2024-26997: usb: dwc2: host: Fix dereference issue in DDMA completion flow.

stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
mainline: [eed04fa96c48790c1cce73c8a248e9d460b088f8]
stable/4.19: [257d313e37d66c3bcc87197fb5b8549129c45dfe]
stable/5.10: [26fde0ea40dda1b08fad3bc0a43f122f6dd8bddf]
stable/5.15: [8aa5c28ac65cb5e7f1b9c0c3238c00b661dd2b8c]
stable/5.4: [75bf5e78b2a27cb1bca6fa826e3ab685015165e1]
stable/6.1: [9de10b59d16880a0a3ae2876c142fe54ce45d816]
stable/6.6: [8a139fa44870e84ac228b7b76423a49610e5ba9a]
stable/6.8: [55656b2afd5f1efcec4245f3e7e814c2a9ef53f6]

CVE-2024-26999: serial/pmac_zilog: Remove flawed mitigation for rx irq flood

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [8f624cbe0eae01914b01734382b640c4bf1a9736]
cip/4.4-st: [8f624cbe0eae01914b01734382b640c4bf1a9736]
mainline: [1be3226445362bfbf461c92a5bcdb1723f2e4907]
stable/4.19: [69a02273e288011b521ee7c1f3ab2c23fda633ce]
stable/5.10: [ab86cf6f8d24e63e9aca23da5108af1aa5483928]
stable/5.15: [7a3bbe41efa55323b6ea3c35fa15941d4dbecdef]
stable/5.4: [d679c816929d62af51c8e6d7fc0e165c9412d2f3]
stable/6.1: [bbaafbb4651fede8d3c3881601ecaa4f834f9d3f]
stable/6.6: [52aaf1ff14622a04148dbb9ccce6d9de5d534ea7]
stable/6.8: [ca09dfc3cfdf89e6af3ac24e1c6c0be5c575a729]

CVE-2024-27000: serial: mxs-auart: add spinlock around changing cts state

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, stable/5.15, and
stable/5.4 were fixed.

Fixed status
cip/4.4: [4db82a6153a12db64503e59b101b6cac4b9dcffd]
cip/4.4-st: [4db82a6153a12db64503e59b101b6cac4b9dcffd]
mainline: [54c4ec5f8c471b7c1137a1f769648549c423c026]
stable/4.19: [56434e295bd446142025913bfdf1587f5e1970ad]
stable/5.10: [0dc0637e6b16158af85945425821bfd0151adb37]
stable/5.15: [479244d68f5d94f3903eced52b093c1e01ddb495]
stable/5.4: [21535ef0ac1945080198fe3e4347ea498205c99a]
stable/6.1: [2c9b943e9924cf1269e44289bc5e60e51b0f5270]
stable/6.6: [5f40fd6ca2cf0bfbc5a5c9e403dfce8ca899ba37]
stable/6.8: [94b0e65c75f4af888ab2dd6c90f060f762924e86]

CVE-2024-27001: comedi: vmk80xx: fix incomplete endpoint checking

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [677cc6c0fd70b59c6c98e2f667b0ae904a691f96]
cip/4.4-st: [677cc6c0fd70b59c6c98e2f667b0ae904a691f96]
mainline: [d1718530e3f640b7d5f0050e725216eab57a85d8]
stable/4.19: [3a63ae0348d990e137cca04eced5b08379969ea9]
stable/5.10: [f15370e315976198f338b41611f37ce82af6cf54]
stable/5.15: [b0b268eeb087e324ef3ea71f8e6cabd07630517f]
stable/5.4: [a3b8ae7e9297dd453f2977b011c5bc75eb20e71b]
stable/6.1: [ac882d6b21bffecb57bcc4486701239eef5aa67b]
stable/6.6: [59f33af9796160f851641d960bd93937f282c696]
stable/6.8: [6ec3514a7d35ad9cfab600187612c29f669069d2]

CVE-2024-27004: clk: Get runtime PM before walking tree during disable_unused

stable/5.10 and stable/5.4 were fixed.

Fixed status
mainline: [e581cf5d216289ef292d1a4036d53ce90e122469]
stable/5.10: [4af115f1a20a3d9093586079206ee37c2ac55123]
stable/5.15: [a29ec0465dce0b871003698698ac6fa92c9a5034]
stable/5.4: [253ab38d1ee652a596942156978a233970d185ba]
stable/6.1: [a424e713e0cc33d4b969cfda25b9f46df4d7b5bc]
stable/6.6: [60ff482c4205a5aac3b0595ab794cfd62295dab5]
stable/6.8: [115554862294397590088ba02f11f2aba6d5016c]

CVE-2024-27008: drm: nv04: Fix out of bounds access

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [6c19bd70caf2861a71fffd340b78ef6292a52c97]
cip/4.4-st: [6c19bd70caf2861a71fffd340b78ef6292a52c97]
mainline: [cf92bb778eda7830e79452c6917efa8474a30c1e]
stable/4.19: [c2b97f26f081ceec3298151481687071075a25cb]
stable/5.10: [097c7918fcfa1dee233acfd1f3029f00c3bc8062]
stable/5.15: [df0991da7db846f7fa4ec6740350f743d3b69b04]
stable/5.4: [5050ae879a828d752b439e3827aac126709da6d1]
stable/6.1: [5fd4b090304e450aa0e7cc9cc2b4873285c6face]
stable/6.6: [6690cc2732e2a8d0eaca44dcbac032a4b0148042]
stable/6.8: [26212da39ee14a52c76a202c6ae5153a84f579a5]

CVE-2024-27013: tun: limit printing rate when illegal packet received by tun dev

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [87478afa3b5609e994a53fcfca8b134032de52c4]
cip/4.4-st: [87478afa3b5609e994a53fcfca8b134032de52c4]
mainline: [f8bbc07ac535593139c875ffa19af924b1084540]
stable/4.19: [68459b8e3ee554ce71878af9eb69659b9462c588]
stable/5.10: [14cdb43dbc827e18ac7d5b30c5b4c676219f1421]
stable/5.15: [a50dbeca28acf7051dfa92786b85f704c75db6eb]
stable/5.4: [4b0dcae5c4797bf31c63011ed62917210d3fdac3]
stable/6.1: [62e27ef18eb4f0d33bbae8e9ef56b99696a74713]
stable/6.6: [40f4ced305c6c47487d3cd8da54676e2acc1a6ad]
stable/6.8: [52854101180beccdb9dc2077a3bea31b6ad48dfa]

CVE-2024-27020: netfilter: nf_tables: Fix potential data-race in
__nft_expr_type_get()

cip/4.4, cip/4.4-st, stable/4.19, stable/5.10, and stable/5.4 were fixed.

Fixed status
cip/4.4: [148d903916f26f7143ab04116a093708c992b81e]
cip/4.4-st: [148d903916f26f7143ab04116a093708c992b81e]
mainline: [f969eb84ce482331a991079ab7a5c4dc3b7f89bf]
stable/4.19: [939109c0a8e2a006a6cc8209e262d25065f4403a]
stable/5.10: [934e66e231cff2b18faa2c8aad0b8cec13957e05]
stable/5.15: [0b6de00206adbbfc6373b3ae38d2a6f197987907]
stable/5.4: [b38a133d37fa421c8447b383d788c9cc6f5cb34c]
stable/6.1: [8d56bad42ac4c43c6c72ddd6a654a2628bf839c5]
stable/6.6: [a9ebf340d123ae12582210407f879d6a5a1bc25b]
stable/6.8: [01f1a678b05ade4b1248019c2dcca773aebbeb7f]

CVE-2024-27022: fork: defer linking file vma until vma is fully initialized

stable/6.1 and stable/6.6 were fixed.

Fixed status
mainline: [35e351780fa9d8240dd6f7e4f245f9ea37e96c19]
stable/6.1: [0c42f7e039aba3de6d7dbf92da708e2b2ecba557]
stable/6.6: [cec11fa2eb512ebe3a459c185f4aca1d44059bbf]
stable/6.8: [abdb88dd272bbeb93efe01d8e0b7b17e24af3a34]

CVE-2023-6535: NULL pointer dereference in nvmet_tcp_execute_request

mainline, stable/5.10, stable/5.15, stable/5.4, stable/6.1, and
stable/6.6 were fixed.

Fixed status
mainline: [efa56305908ba20de2104f1b8508c6a7401833be,
0849a5441358cef02586fb2d60f707c0db195628,
  9a1abc24850eb759e36a2f8869161c3b7254c904]
stable/5.10: [f775f2621c2ac5cc3a0b3a64665dad4fb146e510,
39669fae69f302961d89f38d969c6fcc1d07eb02,
  0de2e62067d2a6733a5b8ca24066d9bbdfefaf47]
stable/5.15: [4cb3cf7177ae3666be7fb27d4ad4d72a295fb02d,
0613a2fbdf8d32c3f8f1e62d704e92251a100795,
  a300f741f692fce244e050b2cf4fe1ea3562a30f]
stable/5.4: [ee5e7632e981673f42a50ade25e71e612e543d9d,
9638beb4e10ac116c6a4fc13315e9c3608055ac0,
  40d171ef2389c46e375a428c2a13594f82849625]
stable/6.1: [2871aa407007f6f531fae181ad252486e022df42,
83ccd15717ee2b6143df72df39685f0c832e3451,
  11923a8df8edd9f85481490882a8abd50851df40]
stable/6.6: [24e05760186dc070d3db190ca61efdbce23afc88,
2f00fd8d50a7d5eedc85e62efdc1a29213168998,
  2ed3d35328901ed81baeebc3a7f4502c3dfd95f0]

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

