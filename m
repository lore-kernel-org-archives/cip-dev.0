Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFE3C27C53
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 23:39:17 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
 by mx.groups.io with SMTP id smtpd.web10.1175.1717630746262891960
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 16:39:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=G8LLVdGL;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.181, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c9b74043b1so178034b6e.1
        for <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 16:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1717630745; x=1718235545; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UPvak8tOyckpdSOrpdBm0nkJDdUEbhXv1cLvBgN4TBM=;
        b=G8LLVdGLtG3ZheBRQDCMRTsBm//zCkw/EhLaVYpulmxO1SJex7GYrhdbZV1iSCjdva
         YjRytXbto0NRCzY6RNluEiO0llRv9xJymPEwVh1XoarSwVG3BQ+lIEbKIbtfni3WSDKV
         HiZmm1N8rAsUij4RsH0Ssupz7vkVWy/RSa0yeQKaNafu8pC9E3fPa474NV8P3CEvf4Wv
         ZebTaThfcg5KOGrjOdfoSeawGcZoXQUVo19hDRag4lP3kiXV0J6PrU2TGzgzXsolouIa
         jiBylI3jLnTk/eARFDUSNKFBi/gcEpXnWTHSgwJ+SDoQf2GP1TYXDOkblzJS/wv57NAq
         rrZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717630745; x=1718235545;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UPvak8tOyckpdSOrpdBm0nkJDdUEbhXv1cLvBgN4TBM=;
        b=YoHwOzj45l7lalCQBXt9TT8PNkWNVtH/7blEjCvGcZ5A+S9fotIlk7whN5XJvfNCwd
         ZnfKNYrSIc9LvvrBi8f91+tU38Z7ImoT9xeg2Ot8RC3neM8uAazKq1R+JMpp6dmyZCWX
         PC8Oy7qmtGCtmH9b1EoteKpqG0CELIPi+K53fGVgOw0DpXF3T1yERSkBPr7gpILoHNpp
         xkJRSRwjcFl2tRul6pkrauR+JOCFqWTPC/nlvD1iF1QxCs31gHPHZdL4urB0MLAo4hxp
         YyKlQdoTEApzioQqhVoDHwOwwyondKMTHFrYsFLijylP2dtl8IYkOhP9v4soCe0cGFwt
         rWkg==
X-Gm-Message-State: AOJu0Yzbeeu7KhZ2PbNA2dTFafrlhTUQv6zvfutqnjpPxmT5GAjcSy9u
	qb42P6oaX4jVcL3c6jUyMRfI21tcKGtB7zSd+G1j0YzDkejENYWINTwhWIb+ineT2gO/wMaLKs9
	QHvsye64LoflUE8TmTPOVh4HngxT80sZbipV7FetMUaHVqr+ZULc=
X-Google-Smtp-Source: AGHT+IGf9+mjAzQothF6B4WfpBGsXTM6LB+zZ3jY489+ZasiimQLLPYoMeZYWTzqwkXe+K3UBHtM+2uQicvTyFMQPfc=
X-Received: by 2002:a05:6870:8188:b0:24d:9c68:4e9e with SMTP id
 586e51a60fabf-25121fed15cmr4610713fac.45.1717630743867; Wed, 05 Jun 2024
 16:39:03 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 6 Jun 2024 08:38:27 +0900
Message-ID: <CAODzB9p2PPqHJw24RNzEa1CPDa79eWRkP_3Av4eYstisSWJYaw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 23:39:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16120

Hi!

It's this week's CVE report.

This week reported 103 new CVEs and 0 updated CVEs.

* New CVEs
CVE-2023-52882: clk: sunxi-ng: h6: Reparent CPUX during PLL CPUX rate change

Announce: https://lore.kernel.org/linux-cve-announce/2024053059-CVE-2023-52882-9b44@gregkh/

Introduced by commit 524353e ("clk: sunxi-ng: add support for the
Allwinner H6 CCU") in v4.17-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e91ed763dc07437777bd012af7a2bd4493731ff]
stable/5.10: [bfc78b4628497eb6df09a6b5bba9dd31616ee175]
stable/5.15: [f1fa9a9816204ac4b118b2e613d3a7c981355019]
stable/5.4: [fe11826ffa200e1a7a826e745163cb2f47875f66]
stable/6.1: [70f64cb29014e4c4f1fabd3265feebd80590d069]
stable/6.6: [0b82eb134d2942ecc669e2ab2be3f0a58d79428a]

CVE-2024-36017: rtnetlink: Correct nested IFLA_VF_VLAN_LIST attribute validation

Announce: https://lore.kernel.org/linux-cve-announce/2024053015-CVE-2024-36017-bf96@gregkh/

Introduced by commit 79aab09 ("net: Update API for VF vlan protocol
802.1ad support") in v4.9-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1aec77b2bb2ed1db0f5efc61c4c1ca3813307489]
stable/4.19: [8ac69ff2d0d5be9734c4402de932aa3dc8549c1a]
stable/5.10: [6c8f44b02500c7d14b5e6618fe4ef9a0da47b3de]
stable/5.15: [f3c1bf3054f96ddeab0621d920445bada769b40e]
stable/5.4: [5e7ef2d88666a0212db8c38e6703864b9ce70169]
stable/6.1: [6e4c7193954f4faab92f6e8d88bc5565317b44e7]
stable/6.6: [206003c748b88890a910ef7142d18f77be57550b]

CVE-2024-36018: nouveau/uvmm: fix addr/range calcs for remap operations

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36018-d6b8@gregkh/

Introduced by commit b88baab ("drm/nouveau: implement new VM_BIND
uAPI") in v6.6-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be141849ec00ef39935bf169c0f194ac70bf85ce]
stable/6.6: [692a51bebf4552bdf0a79ccd68d291182a26a569]

CVE-2024-36019: regmap: maple: Fix cache corruption in regcache_maple_drop()

Announce: https://lore.kernel.org/linux-cve-announce/2024053044-CVE-2024-36019-59fb@gregkh/

Introduced by commit f033c26 ("regmap: Add maple tree based register
cache") in v6.4-rc1.
Fixed in v6.9-rc3.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00bb549d7d63a21532e76e4a334d7807a54d9f31]
stable/6.6: [3af6c5ac72dc5b721058132a0a1d7779e443175e]

CVE-2024-36020: i40e: fix vf may be used uninitialized in this function warning

Announce: https://lore.kernel.org/linux-cve-announce/2024053044-CVE-2024-36020-5da7@gregkh/

Introduced by commit 52424f9 ("i40e: Fix VF hang when reset is
triggered on another VF") in v6.1-rc3.
Fixed in v6.9-rc3.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/5.10 cip/5.10-rt stable/4.19 stable/5.10
stable/5.15 stable/5.4

Fixed status
mainline: [f37c4eac99c258111d414d31b740437e1925b8e8]
stable/4.19: [cc9cd02dd9e8b7764ea9effb24f4f1dd73d1b23d]
stable/5.10: [b8e82128b44fa40bf99a50b919488ef361e1683c]
stable/5.15: [951d2748a2a8242853abc3d0c153ce4bf8faad31]
stable/5.4: [9dcf0fcb80f6aeb01469e3c957f8d4c97365450a]
stable/6.1: [3e89846283f3cf7c7a8e28b342576fd7c561d2ba]
stable/6.6: [0dcf573f997732702917af1563aa2493dc772fc0]

CVE-2024-36021: net: hns3: fix kernel crash when devlink reload during
pf initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024053044-CVE-2024-36021-f196@gregkh/

Introduced by commit b741269 ("net: hns3: add support for registering
devlink for PF") in v5.15-rc1.
Fixed in v6.9-rc2.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93305b77ffcb042f1538ecc383505e87d95aa05a]
stable/6.1: [50b69054f455dcdb34bd6b22764c7579b270eef3]
stable/6.6: [1b550dae55901c2cc9075d6a7155a71b4f516e86]

CVE-2024-36022: drm/amdgpu: Init zone device and drm client after
mode-1 reset on reload

Announce: https://lore.kernel.org/linux-cve-announce/2024053013-CVE-2024-36022-fe0e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc1.

Fixed status
mainline: [f679fd6057fbf5ab34aaee28d58b7f81af0cbf48]

CVE-2024-36023: Julia Lawall reported this null pointer dereference,
this should fix it.

Announce: https://lore.kernel.org/linux-cve-announce/2024053013-CVE-2024-36023-0202@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc1.
It looks as if this bug was introduced by commit ac2c6375 ("
orangefs: Fix sb refcount leak when allocate sb info failed.") in
5.16-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bf93dcfc453fae192fe5d7874b89699e8f800ac]
stable/6.1: [2e2177f94c0e0bc41323d7b6975a5f4820ed347e]
stable/6.6: [214a6c4a28c11d67044e6cf3a0ab415050d9f03a]

CVE-2024-36024: drm/amd/display: Disable idle reallow as part of
command/gpint execution

Announce: https://lore.kernel.org/linux-cve-announce/2024053014-CVE-2024-36024-85b6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc1.
It looks as if this bug was introduced by commit 8892780 ("drm/amd/display:
Wake DMCUB before sending a command") in 6.8-rc1.

Fixed status
mainline: [6226a5aa77370329e01ee8abe50a95e60618ce97]

CVE-2024-36025: scsi: qla2xxx: Fix off by one in qla_edif_app_getstats()

Announce: https://lore.kernel.org/linux-cve-announce/2024053034-CVE-2024-36025-95e0@gregkh/

Introduced by commit 7878f22 ("scsi: qla2xxx: edif: Add getfcinfo and
statistic bsgs") in v5.15-rc1.
Fixed in v6.9-rc4.

Fixed status
mainline: [4406e4176f47177f5e51b4cc7e6a7a2ff3dbfbbd]
stable/5.15: [8c820f7c8e9b46238d277c575392fe9930207aab]
stable/6.1: [9fc74e367be4247a5ac39bb8ec41eaa73fade510]
stable/6.6: [60b87b5ecbe07d70897d35947b0bb3e76ccd1b3a]

CVE-2024-36026: drm/amd/pm: fixes a random hang in S4 for SMU v13.0.4/11

Announce: https://lore.kernel.org/linux-cve-announce/2024053034-CVE-2024-36026-4730@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.
It looks as if this bug was introduced by commit 526e6ca ("drm/amdgpu/pm:
remove the repeated EnableGfxImu message sending") in 6.0-rc1.

Fixed status
mainline: [31729e8c21ecfd671458e02b6511eb68c2225113]
stable/6.1: [bd9b94055c3deb2398ee4490c1dfdf03f53efb8f]
stable/6.6: [1e3b8874d55c0c28378beb9007494a7a9269a5f5]

CVE-2024-36027: btrfs: zoned: do not flag ZEROOUT on non-dirty extent buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024053021-CVE-2024-36027-2bf9@gregkh/

Introduced by commit aa6313e ("btrfs: zoned: don't clear dirty flag of
extent buffer") in v6.8-rc1.
Fixed in v6.9-rc5.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68879386180c0efd5a11e800b0525a01068c9457]

CVE-2024-36028: mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when
dissolve_free_hugetlb_folio()

Announce: https://lore.kernel.org/linux-cve-announce/2024053057-CVE-2024-36028-e4a3@gregkh/

Introduced by commit 32c8771 ("hugetlb: do not clear hugetlb dtor
until allocating vmemmap") in v6.5-rc6.
Fixed in v6.9-rc6.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [52ccdde16b6540abe43b6f8d8e1e1ec90b0983af]
stable/6.1: [2effe407f7563add41750fd7e03da4ea44b98099]
stable/6.6: [7e0a322877416e8c648819a8e441cf8c790b2cce]

CVE-2024-36029: mmc: sdhci-msm: pervent access to suspended controller

Announce: https://lore.kernel.org/linux-cve-announce/2024053057-CVE-2024-36029-e157@gregkh/

Introduced by commit 67e6db1 ("mmc: sdhci-msm: Add pm_runtime and
system PM support") in v4.10-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f8def10f73a516b771051a2f70f2f0446902cb4f]
stable/5.15: [1200481cd6069d16ce20133bcd86f5825e26a045]
stable/6.1: [a957ea5aa3d3518067a1ba32c6127322ad348d20]
stable/6.6: [56b99a52229d7f8cd1f53d899f57aa7eb4b199af]

CVE-2024-36030: octeontx2-af: fix the double free in rvu_npc_freemem()

Announce: https://lore.kernel.org/linux-cve-announce/2024053057-CVE-2024-36030-51dc@gregkh/

Introduced by commit dd78428 ("octeontx2-af: Add new devlink param to
configure maximum usable NIX block LFs") in v6.8-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6e965eba43e9724f3e603d7b7cc83e53b23d155e]

CVE-2024-36031: keys: Fix overwrite of key expiration on instantiation

Announce: https://lore.kernel.org/linux-cve-announce/2024053000-CVE-2024-36031-46f2@gregkh/

Introduced by commit 39299bd ("keys, dns: Allow key types (eg. DNS) to
be reclaimed immediately on expiry") in v6.7-rc7.
Fixed in v6.10-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [9da27fb65a14c18efd4473e2e82b76b53ba60252]
stable/5.10: [ad2011ea787928b2accb5134f1e423b11fe80a8a]
stable/5.15: [ed79b93f725cd0da39a265dc23d77add1527b9be]
stable/6.1: [e4519a016650e952ad9eb27937f8c447d5a4e06d]
stable/6.6: [25777f3f4e1f371d16a594925f31e37ce07b6ec7]

CVE-2024-36032: Bluetooth: qca: fix info leak when fetching fw build id

Announce: https://lore.kernel.org/linux-cve-announce/2024053000-CVE-2024-36032-1631@gregkh/

Introduced by commit c0187b0 ("Bluetooth: btqca: Add support to read
FW build version for WCN3991 BTSoC") in v5.12-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cda0d6a198e2a7ec6f176c36173a57bdd8af7af2]
stable/6.1: [57062aa13e87b1a78a4a8f6cb5fab6ba24f5f488]
stable/6.6: [6b63e0ef4d3ce0080395e5091fba2023f246c45a]

CVE-2024-36033: Bluetooth: qca: fix info leak when fetching board id

Announce: https://lore.kernel.org/linux-cve-announce/2024053000-CVE-2024-36033-0dd9@gregkh/

Introduced by commit a7f8ded ("Bluetooth: qca: add support for
QCA2066") in v6.7-rc1.
Fixed in v6.6.31.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [ba307abed5e09759845c735ba036f8c12f55b209]
stable/6.1: [bcccdc947d2ca5972b1e92d0dea10803ddc08ceb]
stable/6.6: [ba307abed5e09759845c735ba036f8c12f55b209]

CVE-2024-36880: Bluetooth: qca: add missing firmware sanity checks

Announce: https://lore.kernel.org/linux-cve-announce/2024053031-CVE-2024-36880-c961@gregkh/

Introduced by commit 83e8196 ("Bluetooth: btqca: Introduce generic QCA
ROME support") in v4.3-rc1.
Fixed in v6.9.

Fixed status
mainline: [2e4edfa1e2bd821a317e7d006517dcf2f3fac68d]
stable/5.15: [ed53949cc92e28aaa3463d246942bda1fbb7f307]
stable/6.1: [1caceadfb50432dbf6d808796cb6c34ebb6d662c]
stable/6.6: [427281f9498ed614f9aabc80e46ec077c487da6d]

CVE-2024-36881: mm/userfaultfd: reset ptes when close() for wr-protected ones

Announce: https://lore.kernel.org/linux-cve-announce/2024053032-CVE-2024-36881-24d0@gregkh/

Introduced by commit f369b07 ("mm/uffd: reset write protection when
unregister with wp-mode") in v6.0-rc3.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c88033efe9a391e72ba6b5df4b01d6e628f4e734]
stable/6.6: [377f3a9a3d032a52325a5b110379a25dd1ab1931]

CVE-2024-36882: mm: use memalloc_nofs_save() in page_cache_ra_order()

Announce: https://lore.kernel.org/linux-cve-announce/2024053032-CVE-2024-36882-79ff@gregkh/

Introduced by commit 793917d ("mm/readahead: Add large folio
readahead") in v5.18-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30153e4466647a17eebfced13eede5cbe4290e69]
stable/6.1: [7629ef6dda1564098aadeef38e5fbd11ee8627c4]
stable/6.6: [468971c3f4b8187f25334503b68050a0e1370147]

CVE-2024-36883: net: fix out-of-bounds access in ops_init

Announce: https://lore.kernel.org/linux-cve-announce/2024053032-CVE-2024-36883-b892@gregkh/

Introduced by commit 073862b ("netns: fix net_alloc_generic()") in v3.3-rc2.
Fixed in v6.9.

Fixed status
mainline: [a26ff37e624d12e28077e5b24d2b264f62764ad6]
stable/4.19: [3cdc34d76c4f777579e28ad373979d36c030cfd3]
stable/5.10: [0c3248bc708a7797be573214065cf908ff1f54c7]
stable/5.15: [9518b79bfd2fbf99fa9b7e8e36bcb1825e7ba030]
stable/5.4: [7b0e64583eab8c1d896b47e5dd0bf2e7d86ec41f]
stable/6.1: [2d60ff5874aefd006717ca5e22ac1e25eac29c42]
stable/6.6: [b6dbfd5bcc267a95a0bf1bf96af46243f96ec6cd]

CVE-2024-36884: iommu/arm-smmu: Use the correct type in
nvidia_smmu_context_fault()

Announce: https://lore.kernel.org/linux-cve-announce/2024053032-CVE-2024-36884-c00b@gregkh/

Introduced by commit e097633 ("iommu/arm-smmu: Pass arm_smmu_domain to
internal functions") in v6.8-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [65ade5653f5ab5a21635e51d0c65e95f490f5b6f]

CVE-2024-36885: drm/nouveau/firmware: Fix SG_DEBUG error with
nvkm_firmware_ctor()

Announce: https://lore.kernel.org/linux-cve-announce/2024053032-CVE-2024-36885-cb0b@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc7.
The nvkm_firmware_dtor() and nvkm_firmware_ctor() were introduced by
commit 0e44c21
("drm/nouveau/flcn: new code to load+boot simple HS FWs (VPR
scrubber)") in 6.2-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52a6947bf576b97ff8e14bb0a31c5eaf2d0d96e2]
stable/6.6: [1a88c18da464db0ba8ea25196d0a06490f65322e]

CVE-2024-36886: tipc: fix UAF in error path

Announce: https://lore.kernel.org/linux-cve-announce/2024053033-CVE-2024-36886-dd83@gregkh/

Introduced by commit 1149557 ("tipc: eliminate unnecessary
linearization of incoming buffers") in v4.1-rc1.
Fixed in v6.9-rc7.

Fixed status
mainline: [080cbb890286cd794f1ee788bbc5463e2deb7c2b]
stable/4.19: [e19ec8ab0e25bc4803d7cc91c84e84532e2781bd]
stable/5.10: [367766ff9e407f8a68409b7ce4dc4d5a72afeab1]
stable/5.15: [66116556076f0b96bc1aa9844008c743c8c67684]
stable/5.4: [93bc2d6d16f2c3178736ba6b845b30475856dc40]
stable/6.1: [21ea04aad8a0839b4ec27ef1691ca480620e8e14]
stable/6.6: [ffd4917c1edb3c3ff334fce3704fbe9c39f35682]

CVE-2024-36887: e1000e: change usleep_range to udelay in PHY mdic access

Announce: https://lore.kernel.org/linux-cve-announce/2024053033-CVE-2024-36887-6a66@gregkh/

Introduced by commit 6dbdd4d ("e1000e: Workaround for sporadic MDI error on
Meteor Lake systems") in 6.9-rc3. Fixed in 6.9-rc7.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [387f295cb2150ed164905b648d76dfcbd3621778]
stable/6.6: [f8a139656c95db893a543159873c57a470d7376d]

CVE-2024-36888: workqueue: Fix selection of wake_cpu in kick_pool()

Announce: https://lore.kernel.org/linux-cve-announce/2024053033-CVE-2024-36888-3543@gregkh/

Introduced by commit 8639ece ("workqueue: Implement non-strict
affinity scope for unbound workqueues") in v6.6-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57a01eafdcf78f6da34fad9ff075ed5dfdd9f420]
stable/6.6: [c57824d4fe07c2131f8c48687cbd5ee2be60c767]

CVE-2024-36889: mptcp: ensure snd_nxt is properly initialized on connect

Announce: https://lore.kernel.org/linux-cve-announce/2024053033-CVE-2024-36889-222d@gregkh/

Introduced by commit 8fd7380 ("mptcp: fallback in case of simultaneous
connect") in v5.9-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb7a0d334894206ae35f023a82cad5a290fd7386]
stable/5.10: [99951b62bf20cec9247f633a3bea898338b9e5b4]
stable/5.15: [dc941fec0719d0471a5902424d6b2a17df233193]
stable/6.1: [39ca83ed73db9edcc6d70c0dc7a73085a4725012]
stable/6.6: [aa0c07c1f20e05b30019bff083ec43665536f06f]

CVE-2024-36890: mm/slab: make __free(kfree) accept error pointers

Announce: https://lore.kernel.org/linux-cve-announce/2024053033-CVE-2024-36890-b999@gregkh/

Introduced by commit 54da6a0 ("locking: Introduce __cleanup() based
infrastructure") in v6.5-rc1.
Fixed in v6.9.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [cd7eb8f83fcf258f71e293f7fc52a70be8ed0128]
stable/6.1: [9f6eb0ab4f95240589ee85fd9886a944cd3645b2]
stable/6.6: [ac6cf3ce9b7d12acb7b528248df5f87caa25fcdc]

CVE-2024-36891: maple_tree: fix mas_empty_area_rev() null pointer dereference

Announce: https://lore.kernel.org/linux-cve-announce/2024053033-CVE-2024-36891-aada@gregkh/

Introduced by commit 54a611b ("Maple Tree: add new data structure") in v6.1-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [955a923d2809803980ff574270f81510112be9cf]
stable/6.6: [6c9c7c1e63b198a8b979ad963eb21410f10ccb00]

CVE-2024-36892: mm/slub: avoid zeroing outside-object freepointer for
single free

Announce: https://lore.kernel.org/linux-cve-announce/2024053034-CVE-2024-36892-9469@gregkh/

Introduced by commit 284f17a ("mm/slub: handle bulk and single object
freeing separately") in v6.8-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f828aa48812ced28aa39cb3cfe55ef2444d03dd]

CVE-2024-36893: usb: typec: tcpm: Check for port partner validity
before consuming it

Announce: https://lore.kernel.org/linux-cve-announce/2024053034-CVE-2024-36893-476e@gregkh/

Introduced by commit c97cd0b ("usb: typec: tcpm: set initial svdm
version based on pd revision") in v6.6-rc1.
Fixed in v6.9-rc7.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [ae11f04b452b5205536e1c02d31f8045eba249dd]
stable/6.1: [d56d2ca03cc22123fd7626967d096d8661324e57]
stable/6.6: [789326cafbd1f67f424436b6bc8bdb887a364637]

CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and
AIO request complete

Announce: https://lore.kernel.org/linux-cve-announce/2024053034-CVE-2024-36894-b44b@gregkh/

Introduced by commit 2e4c755 ("usb: gadget: f_fs: add aio support") in
v3.15-rc1.
Fixed in v6.9-rc7.

Fixed status
mainline: [24729b307eefcd7c476065cd7351c1a018082c19]
stable/6.6: [73c05ad46bb4fbbdb346004651576d1c8dbcffbb]

CVE-2024-36895: usb: gadget: uvc: use correct buffer size when parsing
configfs lists

Announce: https://lore.kernel.org/linux-cve-announce/2024053034-CVE-2024-36895-c67c@gregkh/

Introduced by commit 0df2860 ("usb: gadget: uvc: Generalise helper
functions for reuse") in v6.3-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [650ae71c80749fc7cb8858c8049f532eaec64410]
stable/6.6: [7a54e5052bde582fd0e7677334fe7a5be92e242c]

CVE-2024-36896: USB: core: Fix access violation during port device removal

Announce: https://lore.kernel.org/linux-cve-announce/2024053034-CVE-2024-36896-783f@gregkh/

Introduced by commit f061f43 ("usb: hub: port: add sysfs entry to
switch port power") in v6.0-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a4b46d450c49f32e9d4247b421e58083fde304ce]
stable/6.1: [5f1d68ef5ddac27c6b997adccd1c339cef1e6848]
stable/6.6: [63533549ff53d24daf47c443dbd43c308afc3434]

CVE-2024-36897: drm/amd/display: Atom Integrated System Info v2_2 for DCN35

Announce: https://lore.kernel.org/linux-cve-announce/2024053035-CVE-2024-36897-55ba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc7.
It seems as if this bug was introduced by commit fcffbcf ("drm/amd/display:
Add DCN3.1 BIOS parser support") in 5.14-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a35d205f466501dcfe5625ca313d944d0ac2d60]
stable/5.15: [3c7013a87124bab54216d9b99f77e8b6de6fbc1a]
stable/6.1: [02f5300f6827206f6e48a77f51e6264993695e5c]
stable/6.6: [7e3030774431eb093165a31baff040d35446fb8b]

CVE-2024-36898: gpiolib: cdev: fix uninitialised kfifo

Announce: https://lore.kernel.org/linux-cve-announce/2024053035-CVE-2024-36898-942c@gregkh/

Introduced by commit 65cff70 ("gpiolib: cdev: support setting
debounce") in v5.10-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee0166b637a5e376118e9659e5b4148080f1d27e]
stable/6.1: [1a51e24404d77bb3307c1e39eee0d8e86febb1a5]
stable/6.6: [883e4bbf06eb5fb7482679e4edb201093e9f55a2]

CVE-2024-36899: gpiolib: cdev: Fix use after free in lineinfo_changed_notify

Announce: https://lore.kernel.org/linux-cve-announce/2024053035-CVE-2024-36899-bfb1@gregkh/

Introduced by commit 51c1064 ("gpiolib: add new ioctl() for monitoring
changes in line info") in v5.7-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02f6b0e1ec7e0e7d059dddc893645816552039da]
stable/6.6: [95ca7c90eaf5ea8a8460536535101e3e81160e2a]

CVE-2024-36900: net: hns3: fix kernel crash when devlink reload during
initialization

Announce: https://lore.kernel.org/linux-cve-announce/2024053035-CVE-2024-36900-8d85@gregkh/

Introduced by commit cd62429 ("net: hns3: add support for registering
devlink for VF") in v5.15-rc1.
Introduced by commit 93305b7 ("net: hns3: fix kernel crash when
devlink reload during pf initialization") in v6.9-rc2.
Fixed in v6.9.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [35d92abfbad88cf947c010baf34b075e40566095]
stable/6.1: [72ede790f5a03c3957487400a1b72ebce293a2e7]
stable/6.6: [5c623fe0534806b627054da09b6f51b7b2f7b9cd]

CVE-2024-36901: ipv6: prevent NULL dereference in ip6_output()

Announce: https://lore.kernel.org/linux-cve-announce/2024053035-CVE-2024-36901-fb16@gregkh/

Introduced by commit 778d80b ("ipv6: Add disable_ipv6 sysctl to
disable IPv6 operaion on specific interface.") in v2.6.27-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4db783d68b9b39a411a96096c10828ff5dfada7a]
stable/6.1: [ea0cb87402f774b0e1214ffba0f57028b27cf155]
stable/6.6: [e31b25cc2066d3f2b6c38579253882008d4469b0]

CVE-2024-36902: ipv6: fib6_rules: avoid possible NULL dereference in
fib6_rule_action()

Announce: https://lore.kernel.org/linux-cve-announce/2024053036-CVE-2024-36902-70de@gregkh/

Introduced by commit 5e5f3f0 ("[IPV6] ADDRCONF: Convert
ipv6_get_saddr() to ipv6_dev_get_saddr().") in v2.6.26-rc1.
Fixed in v6.9.

Fixed status
mainline: [d101291b2681e5ab938554e3e323f7a7ee33e3aa]
stable/4.19: [4a5a573387da6a6b23a4cc62147453ff1bc32afa]
stable/5.10: [674c951ab8a23f7aff9b4c3f2f865901bc76a290]
stable/5.15: [35297fc68de36826087e976f86a5b1f94fd0bf95]
stable/5.4: [ddec23f206a944c73bcc2724358b85388837daff]
stable/6.1: [7e3242c139c38e60844638e394c2877b16b396b0]
stable/6.6: [8745a8d74ba17dafe72b6ab461fa6c007d879747]

CVE-2024-36903: ipv6: Fix potential uninit-value access in __ip6_make_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2024053036-CVE-2024-36903-4a60@gregkh/

Introduced by commit ea30388 ("ipv6: Fix an uninit variable access bug
in __ip6_make_skb()") in v6.3-rc6.
Fixed in v6.9.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [4e13d3a9c25b7080f8a619f961e943fe08c2672c]
stable/6.6: [68c8ba16ab712eb709c6bab80ff151079d11d97a]

CVE-2024-36904: tcp: Use refcount_inc_not_zero() in tcp_twsk_unique().

Announce: https://lore.kernel.org/linux-cve-announce/2024053036-CVE-2024-36904-2273@gregkh/

Introduced by commit ec94c26 ("tcp/dccp: avoid one atomic operation
for timewait hashdance") in v4.16-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f2db7230f73a80dbb179deab78f88a7947f0ab7e]
stable/4.19: [84546cc1aeeb4df3e444b18a4293c9823f974be9]
stable/5.10: [1d9cf07810c30ef7948879567d10fd1f01121d34]
stable/5.15: [27b0284d8be182a81feb65581ab6a724dfd596e8]
stable/5.4: [1796ca9c6f5bd50554214053af5f47d112818ee3]
stable/6.1: [13ed7cdf079686ccd3618335205700c03f6fb446]
stable/6.6: [6e48faad92be13166184d21506e4e54c79c13adc]

CVE-2024-36905: tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets

Announce: https://lore.kernel.org/linux-cve-announce/2024053036-CVE-2024-36905-5884@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.9.

Fixed status
mainline: [94062790aedb505bdda209b10bea47b294d6394f]
stable/4.19: [34e41a031fd7523bf1cd00a2adca2370aebea270]
stable/5.10: [413c33b9f3bc36fdf719690a78824db9f88a9485]
stable/5.15: [2552c9d9440f8e7a2ed0660911ff00f25b90a0a4]
stable/5.4: [ed5e279b69e007ce6c0fe82a5a534c1b19783214]
stable/6.1: [3fe4ef0568a48369b1891395d13ac593b1ba41b1]
stable/6.6: [f47d0d32fa94e815fdd78b8b88684873e67939f4]

CVE-2024-36906: ARM: 9381/1: kasan: clear stale stack poison

Announce: https://lore.kernel.org/linux-cve-announce/2024053036-CVE-2024-36906-736b@gregkh/

Introduced by commit 5615f69 ("ARM: 9016/2: Initialize the mapping of
KASan shadow memory") in v5.11-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4238686f9093b98bd6245a348bcf059cdce23af]
stable/5.15: [20ac71bee028ffbae4fc14ed679b23b4d3e95726]
stable/6.1: [ad702338fe423cb1e79745787090317256a98dab]
stable/6.6: [ee0ce7573e5083031960faf602c9db693ab5b477]

CVE-2024-36907: SUNRPC: add a missing rpc_stat for TCP TLS

Announce: https://lore.kernel.org/linux-cve-announce/2024053037-CVE-2024-36907-2e49@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc1.
Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/5.4
stable/6.1 stable/6.6

Fixed status
mainline: [1548036ef1204df65ca5a16e8b199c858cb80075]
stable/5.10: [afdbc21a92a0cdc497d8879aeff7b284094fae02]
stable/5.15: [7ceb89f4016ea6ed3e59b015d4200739d45c790e]
stable/5.4: [19f51adc778fb84c2eb07eb71800fb0d9f0ff13a]
stable/6.1: [2b7f2d663a965943e8820b6a40cc2abe2eee7431]
stable/6.6: [260333221cf0b2ec946001fb1c0b5a06ca41d14d]

CVE-2024-36908: blk-iocost: do not WARN if iocg was already offlined

Announce: https://lore.kernel.org/linux-cve-announce/2024053037-CVE-2024-36908-031c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc5.
It seems as if this bug was introduced by commit c421a3eb ("blk-iocost:
revamp debt handling") in 5.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01bc4fda9ea0a6b52f12326486f07a4910666cf6]
stable/6.6: [1c172ac7afe4442964f4153b2c78fe4e005d9d67]

CVE-2024-36909: Drivers: hv: vmbus: Don't free ring buffers that
couldn't be re-encrypted

Announce: https://lore.kernel.org/linux-cve-announce/2024053037-CVE-2024-36909-7e38@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.
It looks as if this bug was introduced by commit ae6935e ("vmbus:
split ring buffer allocation from open") in 4.20-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30d18df6567be09c1433e81993e35e3da573ac48]
stable/6.1: [2f622008bf784a9f5dd17baa19223cc2ac30a039]
stable/6.6: [82f9e213b124a7d2bb5b16ea35d570260ef467e0]

CVE-2024-36910: uio_hv_generic: Don't free decrypted memory

Announce: https://lore.kernel.org/linux-cve-announce/2024053037-CVE-2024-36910-6949@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.

Fixed status
mainline: [3d788b2fbe6a1a1a9e3db09742b90809d51638b7]
stable/6.1: [dabf12bf994318d939f70d47cfda30e47abb2c54]
stable/6.6: [6466a0f6d235c8a18c602cb587160d7e49876db9]

CVE-2024-36911: hv_netvsc: Don't free decrypted memory

Announce: https://lore.kernel.org/linux-cve-announce/2024053037-CVE-2024-36911-5ef6@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.

Fixed status
mainline: [bbf9ac34677b57506a13682b31a2a718934c0e31]
stable/6.6: [a56fe611326332bf6b7126e5559590c57dcebad4]

CVE-2024-36912: Drivers: hv: vmbus: Track decrypted status in vmbus_gpadl

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36912-b637@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.

Fixed status
mainline: [211f514ebf1ef5de37b1cf6df9d28a56cfd242ca]
stable/6.1: [1999644d95194d4a58d3e80ad04ce19220a01a81]
stable/6.6: [8e62341f5c45b27519b7d193bcc32ada416ad9d8]

CVE-2024-36913: Drivers: hv: vmbus: Leak pages if set_memory_encrypted() fails

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36913-aaba@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.

Fixed status
mainline: [03f5a999adba062456c8c818a683beb1b498983a]
stable/6.6: [6123a4e8e25bd40cf44db14694abac00e6b664e6]

CVE-2024-36914: drm/amd/display: Skip on writeback when it's not applicable

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36914-40cd@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.

Fixed status
mainline: [ecedd99a9369fb5cde601ae9abd58bca2739f1ae]
stable/6.6: [951a498fa993c5501994ec2df97c9297b02488c7]

CVE-2024-36915: nfc: llcp: fix nfc_llcp_setsockopt() unsafe copies

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36915-611e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.
It seems as if this bug was intrdocued by commit a7b75c5 ("net:
pass a sockptr_t into ->setsockopt") in 5.9-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7a87441c9651ba37842f4809224aca13a554a26f]

CVE-2024-36916: blk-iocost: avoid out of bounds shift

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36916-ebf8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.
It seems as if this bug was introduced by commit 5160a5
("blk-iocost: implement delay adjustment hysteresis") in 5.10-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beaa51b36012fad5a4d3c18b88a617aea7a9b96d]
stable/5.10: [62accf6c1d7b433752cb3591bba8967b7a801ad5]
stable/5.15: [844fc023e9f14a4fb1de5ae1eaefafd6d69c5fa1]
stable/6.1: [f6add0a6f78dc6360b822ca4b6f9f2f14174c8ca]
stable/6.6: [ce0e99cae00e3131872936713b7f55eefd53ab86]

CVE-2024-36917: block: fix overflow in blk_ioctl_discard()

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36917-f9e3@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc3.
It seems all stable kernels need to check overflow in blk_ioctl_discard().

Fixed status
mainline: [22d24a544b0d49bbcbd61c8c0eaf77d3c9297155]
stable/6.1: [8a26198186e97ee5fc4b42fde82629cff8c75cd6]
stable/6.6: [e1d38cde2b7b0fbd1c48082e7a98c37d750af59b]

CVE-2024-36918: bpf: Check bloom filter map value size

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36918-f8bc@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.

Fixed status
mainline: [a8d89feba7e54e691ca7c4efc2a6264fa83f3687]
stable/6.1: [fa6995eeb62e74b5a1480c73fb7b420c270784d3]
stable/6.6: [608e13706c8b6c658a0646f09ebced74ec367f7c]

CVE-2024-36919: scsi: bnx2fc: Remove spin_lock_bh while releasing
resources after upload

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36919-9b97@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.

Fixed status
mainline: [c214ed2a4dda35b308b0b28eed804d7ae66401f9]
stable/4.19: [468f3e3c15076338367b0945b041105b67cf31e3]
stable/5.10: [ad498539dda0816aadef384ec117bfea304c75c3]
stable/5.15: [93aa5ccc44781bdfef1bf0bc4c2c292d45251312]
stable/5.4: [acd370c1fb86b7302c1cbb354a7c1cd9953768eb]
stable/6.1: [1150606d47d711d5bfdf329a1a96ed7027085936]
stable/6.6: [c885ab23206b1f1ba0731ffe7c9455c6a91db256]

CVE-2024-36920: scsi: mpi3mr: Avoid memcpy field-spanning write WARNING

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36920-b4a7@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.
It seems as if this bug was intrdocued by commit 429846b4 ("scsi: mpi3mr:
Add support for MPT commands") in 5.19-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [429846b4b6ce9853e0d803a2357bb2e55083adf0]
stable/6.1: [5f0266044dc611563539705bff0b3e1545fbb6aa]
stable/6.6: [f09318244c6cafd10aca741b9c01e0a2c362d43a]

CVE-2024-36921: wifi: iwlwifi: mvm: guard against invalid STA ID on removal

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36921-9f90@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.
It seems as if this bug was introduced by commit 87f7e2435 ("wifi: iwlwifi: mvm:
add sta handling flows for MLD mode") in 6.4-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17f64517bf5c26af56b6c3566273aad6646c3c4f]
stable/6.6: [94f80a8ec15e238b78521f20f8afaed60521a294]

CVE-2024-36922: wifi: iwlwifi: read txq->read_ptr under lock

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36922-f0df@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.
It looks this bug was introduced by commit 413be83 ("wifi: iwlwifi:
add a validity check of queue_id in iwl_txq_reclaim") in 6.4-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c2ace6300600c634553657785dfe5ea0ed688ac2]
stable/6.6: [b83db8e756dec68a950ed2f056248b1704b3deaa]

CVE-2024-36923: fs/9p: fix uninitialized values during inode evict

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36923-7fc8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.

Fixed status
mainline: [6630036b7c228f57c7893ee0403e92c2db2cd21d]

CVE-2024-36924: scsi: lpfc: Release hbalock before calling lpfc_worker_wake_up()

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36924-6326@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.

Fixed status
mainline: [ded20192dff31c91cef2a04f7e20e60e9bb887d3]
stable/6.1: [6503c39398506cadda9f4c81695a9655ca5fb4fd]
stable/6.6: [e8bf2c05e8ad68e90f9d5889a9e4ef3f6fe00683]

CVE-2024-36925: swiotlb: initialise restricted pool list_head when
SWIOTLB_DYNAMIC=y

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36925-4b72@gregkh/

Introduced by commit 1aaa736 ("swiotlb: allocate a new memory pool
when existing pools are full") in v6.6-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75961ffb5cb3e5196f19cae7683f35cc88b50800]
stable/6.6: [f2a6b3ed20f2dea4cb645abc6a73c4595662adca]

CVE-2024-36926: powerpc/pseries/iommu: LPAR panics during boot up with
a frozen PE

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36926-c3a3@gregkh/

Introduced by commit b1fc44e ("pseries/iommu/ddw: Fix kdump to work in
absence of ibm,dma-window") in v6.0-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [49a940dbdc3107fecd5e6d3063dc07128177e058]
stable/6.1: [7fb5793c53f8c024e3eae9f0d44eb659aed833c4]
stable/6.6: [802b13b79ab1fef66c6852fc745cf197dca0cb15]

CVE-2024-36927: ipv4: Fix uninit-value access in __ip_make_skb()

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36927-976e@gregkh/

Introduced by commit 99e5aca ("ipv4: Fix potential uninit variable
access bug in __ip_make_skb()") in v6.4-rc1.
Fixed in v6.9-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt stable/4.19 stable/5.10 stable/5.15
stable/5.4 stable/6.1

Fixed status
mainline: [fc1092f51567277509563800a3c56732070b6aa4]
stable/6.6: [5db08343ddb1b239320612036c398e4e1bb52818]

CVE-2024-36928: s390/qeth: Fix kernel panic after setting hsuid

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36928-845b@gregkh/

Introduced by commit 1cfef80 ("s390/qeth: Don't call
dev_close/dev_open (DOWN/UP)") in v6.5-rc5.
Fixed in v6.9-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [8a2e4d37afb8500b276e5ee903dee06f50ab0494]
stable/5.15: [8792b557eb50b986f2496156d486d0c7c85a1524]
stable/6.1: [10cb803aff3b11fe0bd5f274fc1c231a43e88df6]
stable/6.6: [e28dd1e1bf3ebb52cdb877fb359e8978a51576e3]

CVE-2024-36929: net: core: reject skb_copy(_expand) for fraglist GSO skbs

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36929-0329@gregkh/

Introduced by commit 3a1296a ("net: Support GRO/GSO fraglist
chaining.") in v5.6-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d091e579b864fa790dd6a0cd537a22c383126681]
stable/5.10: [faa83a7797f06cefed86731ba4baa3b4dfdc06c1]
stable/5.15: [c7af99cc21923a9650533c9d77265c8dd683a533]
stable/6.1: [989bf6fd1e1d058e73a364dce1a0c53d33373f62]
stable/6.6: [cfe34d86ef9765c388f145039006bb79b6c81ac6]

CVE-2024-36930: spi: fix null pointer dereference within spi_sync

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36930-8906@gregkh/

Introduced by commit ae7d234 ("spi: Don't use the message queue if
possible in spi_sync") in v6.0-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4756fa529b2f12b7cb8f21fe229b0f6f47190829]
stable/6.1: [e005d6754e3e440257006795b687c4ad8733b493]
stable/6.6: [a30659f1576d2c8e62e7426232bb18b885fd951a]

CVE-2024-36931: s390/cio: Ensure the copied buf is NUL terminated

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36931-3201@gregkh/

Introduced by commit a4f17cc ("s390/cio: add CRW inject
functionality") in v5.13-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da7c622cddd4fe36be69ca61e8c42e43cde94784]
stable/5.15: [c9d48ce163305595ae20aee27774192476d5e6a5]
stable/6.1: [10452edd175fcc4fd0f5ac782ed2a002e3e5d65c]
stable/6.6: [84b38f48836662c4bfae646c014f4e981e16a2b2]

CVE-2024-36932: thermal/debugfs: Prevent use-after-free from occurring
after cdev removal

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36932-c22d@gregkh/

Introduced by commit 755113d ("thermal/debugfs: Add thermal cooling
device debugfs information") in v6.8-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d351eb0ab04c3e8109895fc33250cebbce9c11da]

CVE-2024-36933: nsh: Restore skb->{protocol,data,mac_header} for outer
header in nsh_gso_segment().

Announce: https://lore.kernel.org/linux-cve-announce/2024053042-CVE-2024-36933-444e@gregkh/

Introduced by commit c411ed8 ("nsh: add GSO support") in v4.14-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b911a9690d72641879ea6d13cce1de31d346d79]
stable/4.19: [a7c2c3c1caabcb4a3d6c47284c397507aaf54fe9]
stable/5.10: [bbccf0caef2fa917d6d0692385a06ce3c262a216]
stable/5.15: [5a4603fbc285752d19e4b415466db18ef3617e4a]
stable/5.4: [46134031c20fd313d03b90169d64b2e05ca6b65c]
stable/6.1: [37ed6f244ec5bda2e90b085084e322ea55d0aaa2]
stable/6.6: [696d18bb59727a2e0526c0802a812620be1c9340]

CVE-2024-36934: bna: ensure the copied buf is NUL terminated

Announce: https://lore.kernel.org/linux-cve-announce/2024053042-CVE-2024-36934-cc8b@gregkh/

Introduced by commit 7afc5db ("bna: Add debugfs interface.") in v3.3-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c34096c7fdf272fd4c0c37fe411cd2e3ed0ee9f]
stable/4.19: [bd502ba81cd1d515deddad7dbc6b812b14b97147]
stable/5.10: [6f0f19b79c085cc891c418b768f26f7004bd51a4]
stable/5.15: [0f560240b4cc25d3de527deb257cdf072c0102a9]
stable/5.4: [80578ec10335bc15ac35fd1703c22aab34e39fdd]
stable/6.1: [06cb37e2ba6441888f24566a997481d4197b4e32]
stable/6.6: [e19478763154674c084defc62ae0d64d79657f91]

CVE-2024-36935: ice: ensure the copied buf is NUL terminated

Announce: https://lore.kernel.org/linux-cve-announce/2024053042-CVE-2024-36935-4e4a@gregkh/

Introduced by commit 96a9a93 ("ice: configure FW logging") in v6.8-rc1.
Introduced by commit 73671c3 ("ice: enable FW logging") in v6.8-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [666854ea9cad844f75a068f32812a2d78004914a]

CVE-2024-36936: efi/unaccepted: touch soft lockup during memory accept

Announce: https://lore.kernel.org/linux-cve-announce/2024053042-CVE-2024-36936-3116@gregkh/

Introduced by commit 50e782a ("efi/unaccepted: Fix soft lockups caused
by parallel memory acceptance") in v6.6-rc7.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c5a1627f48105cbab81d25ec2f72232bfaa8185]

CVE-2024-36937: xdp: use flags field to disambiguate broadcast redirect

Announce: https://lore.kernel.org/linux-cve-announce/2024053042-CVE-2024-36937-be12@gregkh/

Introduced by commit e624d4e ("xdp: Extend xdp_redirect_map with
broadcast support") in v5.14-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5bcf0dcbf9066348058b88a510c57f70f384c92c]
stable/5.15: [12481f30128fbebc2eeb55eb2d56390fdfa30c5e]
stable/6.1: [272bfb019f3cc018f654b992115774e77b4f3ffc]
stable/6.6: [e22e25820fa04ea5eaac4ef7ee200e9923f466a4]

CVE-2024-36938: bpf, skmsg: Fix NULL pointer dereference in
sk_psock_skb_ingress_enqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024053043-CVE-2024-36938-7242@gregkh/

Introduced by commit 604326b ("bpf, sockmap: convert to generic sk_msg
interface") in v4.20-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6648e613226e18897231ab5e42ffc29e63fa3365]
stable/5.15: [5965bc7535fb87510b724e5465ccc1a1cf00916d]
stable/6.1: [39dc9e1442385d6e9be0b6491ee488dddd55ae27]
stable/6.6: [b397a0ab8582c533ec0c6b732392f141fc364f87]

CVE-2024-36939: nfs: Handle error of rpc_proc_register() in nfs_net_init().

Announce: https://lore.kernel.org/linux-cve-announce/2024053043-CVE-2024-36939-8453@gregkh/

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24457f1be29f1e7042e50a7749f5c2dde8c433c8]
stable/5.10: [d4891d817350c67392d4731536945f3809a2a0ba]
stable/5.15: [ea6ce93327bd2c8a0c6cf6f2f0e800f3b778f021]
stable/5.4: [b33ca18c3a1190208dfd569c4fa8a2f93084709f]
stable/6.1: [8ae63bd858691bee0e2a92571f2fbb36a4d86d65]
stable/6.6: [8a1f89c98dcc542dd6d287e573523714702e0f9c]

CVE-2024-36940: pinctrl: core: delete incorrect free in pinctrl_enable()

Announce: https://lore.kernel.org/linux-cve-announce/2024053043-CVE-2024-36940-0c83@gregkh/

Introduced by commit 6118714 ("pinctrl: core: Fix
pinctrl_register_and_init() with pinctrl_enable()") in v4.11-rc6.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5038a66dad0199de60e5671603ea6623eb9e5c79]
stable/4.19: [735f4c6b6771eafe336404c157ca683ad72a040d]
stable/5.10: [288bc4aa75f150d6f1ee82dd43c6da1b438b6068]
stable/5.15: [41f88ef8ba387a12f4a2b8c400b6c9e8e54b2cca]
stable/5.4: [cdaa171473d98962ae86f2a663d398fda2fbeefd]
stable/6.1: [ac7d65795827dc0cf7662384ed27caf4066bd72e]
stable/6.6: [558c8039fdf596a584a92c171cbf3298919c448c]

CVE-2024-36941: wifi: nl80211: don't free NULL coalescing rule

Announce: https://lore.kernel.org/linux-cve-announce/2024053043-CVE-2024-36941-b3a3@gregkh/

Introduced by commit be29b99 ("cfg80211/nl80211: Add packet coalesce
support") in v3.12-rc1.
Fixed in v6.9-rc6.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [801ea33ae82d6a9d954074fbcf8ea9d18f1543a7]
stable/4.19: [327382dc0f16b268950b96e0052595efd80f7b0a]
stable/5.10: [5a730a161ac2290d46d49be76b2b1aee8d2eb307]
stable/5.15: [ad12c74e953b68ad85c78adc6408ed8435c64af4]
stable/5.4: [97792d0611ae2e6fe3ccefb0a94a1d802317c457]
stable/6.1: [b0db4caa10f2e4e811cf88744fbf0d074b67ec1f]
stable/6.6: [244822c09b4f9aedfb5977f03c0deeb39da8ec7d]

CVE-2024-36942: Bluetooth: qca: fix firmware check error path

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36942-9730@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9.

Fixed status
mainline: [40d442f969fb1e871da6fca73d3f8aef1f888558]
stable/5.15: [580bcd6bf24f9975f97d81d5ef1b64cca9240df9]
stable/6.1: [064688d70c33bb5b49dde6e972b9379a8b045d8a]
stable/6.6: [7bcba557d5c37cd09ecd5abbe7d50deb86c36d3f]

CVE-2024-36943: fs/proc/task_mmu: fix loss of young/dirty bits during
pagemap scan

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36943-de68@gregkh/

Introduced by commit 52526ca ("fs/proc/task_mmu: implement IOCTL to
get and optionally clear info about PTEs") in v6.7-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c70dce4982ce1718bf978a35f8e26160b82081f4]

CVE-2024-36944: Reapply "drm/qxl: simplify qxl_fence_wait"

Announce: https://lore.kernel.org/linux-cve-announce/2024053038-CVE-2024-36944-9d15@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9.
Fixing this issue by revert commit 07ed11a.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [3628e0383dd349f02f882e612ab6184e4bb3dc10]
stable/5.15: [4a89ac4b0921c4ea21eb1b4cf3a469a91bacfcea]
stable/6.1: [b548c53bc3ab83dc6fc86c8e840f013b2032267a]
stable/6.6: [148ed8b4d64f94ab079c8f0d88c3f444db97ba97]

CVE-2024-36945: net/smc: fix neighbour and rtable leak in smc_ib_find_route()

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36945-18ae@gregkh/

Introduced by commit e5c4744 ("net/smc: add SMC-Rv2 connection
establishment") in v5.16-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ddc0dd7fec86ee53b8928a5cca5fbddd4fc7c06]
stable/6.1: [d5a466ab6e78d6f2e0f64435f1e17246c8e941ff]
stable/6.6: [5df93c029a907b0ff5a4eeadd77ba06ff0a277d2]

CVE-2024-36946: phonet: fix rtm_phonet_notify() skb allocation

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36946-3087@gregkh/

Introduced by commit f062f41 ("Phonet: routing table Netlink
interface") in v2.6.33-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d8cac8568618dcb8a51af3db1103e8d4cc4aeea7]
stable/4.19: [ec1f71c05caeba0f814df77e0f511d8b4618623a]
stable/5.10: [f085e02f0a32f6dfcfabc6535c9c4a1707cef86b]
stable/5.15: [4ff334cade9dae50e4be387f71e94fae634aa9b4]
stable/5.4: [dc6beac059f0331de97155a89d84058d4a9e49c7]
stable/6.1: [728a83160f98ee6b60df0d890141b9b7240182fe]
stable/6.6: [ee9e39a6cb3ca2a3d35b4ae25547ee3526a44d00]

CVE-2024-36947: qibfs: fix dentry leak

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36947-e69f@gregkh/

Introduced by commit e41d237 "qib_fs: switch to
simple_recursive_removal()" in v5.13-rc1.
Fixed in v6.9.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa23317d0268b309bb3f0801ddd0d61813ff5afb]
stable/5.15: [24dd9b08df718f20ccf2dd1519909fefd8c233ee]
stable/6.1: [bd8f78c71defbcb7a9ed331e7f287507df972b00]
stable/6.6: [db71ca93259dd1078bcfea3afafde2143cfc2da7]

CVE-2024-36948: drm/xe/xe_migrate: Cast to output precision before
multiplying operands

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36948-972c@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.

Fixed status
mainline: [9cb46b31f3d08ed3fce86349e8c12f96d7c88717]

CVE-2024-36949: amd/amdkfd: sync all devices to wait all processes being evicted

Announce: https://lore.kernel.org/linux-cve-announce/2024053039-CVE-2024-36949-04a4@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc4.

Fixed status
mainline: [d06af584be5a769d124b7302b32a033e9559761d]
stable/6.6: [b6f6626528fe724b512c34f3fb5946c36a135f58]

CVE-2024-36950: firewire: ohci: mask bus reset interrupts between ISR
and bottom half

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36950-9f0e@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc3.
According to the commit log, this bug was introduced by commit a007bb857e
("firewire: fw-ohci: conditionally log busReset interrupts") in 2.6.26-rc1.

Fixed status
mainline: [752e3c53de0fa3b7d817a83050b6699b8e9c6ec9]
stable/4.19: [b3948c69d60279fce5b2eeda92a07d66296c8130]
stable/5.10: [fa273f312334246c909475c5868e6daab889cc8c]
stable/5.15: [4f9cc355c328fc4f41cbd9c4cd58b235184fa420]
stable/5.4: [31279bbca40d2f40cb3bbb6d538ec9620a645dec]
stable/6.1: [6fafe3661712b143d9c69a7322294bd53f559d5d]
stable/6.6: [5982887de60c1b84f9c0ca07c835814d07fd1da0]

CVE-2024-36951: drm/amdkfd: range check cp bad op exception interrupts

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36951-d3cb@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.

Fixed status
mainline: [0cac183b98d8a8c692c98e8dba37df15a9e9210d]
stable/6.6: [41dc6791596656dd41100b85647ed489e1d5c2f2]

CVE-2024-36952: scsi: lpfc: Move NPIV's transport unregistration to
after resource clean up

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36952-f8f8@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc2.

Fixed status
mainline: [4ddf01f2f1504fa08b766e8cfeec558e9f8eef6c]
stable/5.15: [f2c7f029051edc4b394bb48edbe2297575abefe0]
stable/6.1: [0936809d968ecf81e0726fbd02ff2a5732d960c3]
stable/6.6: [76337eb8daee32bcc67742efab3168ed4ca299d0]

CVE-2024-36953: KVM: arm64: vgic-v2: Check for non-NULL vCPU in
vgic_v2_parse_attr()

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36953-fc12@gregkh/

Introduced by commit 7d450e2 ("KVM: arm/arm64: vgic-new: Add userland
access to VGIC dist registers") in v4.7-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ddb4f372fc63210034b903d96ebbeb3c7195adb]
stable/5.10: [4404465a1bee3607ad90a4c5f9e16dfd75b85728]
stable/5.15: [17db92da8be5dd3bf63c01f4109fe47db64fc66f]
stable/6.1: [3a5b0378ac6776c7c31b18e0f3c1389bd6005e80]
stable/6.6: [8d6a1c8e3de36cb0f5e866f1a582b00939e23104]

CVE-2024-36954: tipc: fix a possible memleak in tipc_buf_append

Announce: https://lore.kernel.org/linux-cve-announce/2024053040-CVE-2024-36954-b1b8@gregkh/

Introduced by commit b7df21c ("tipc: skb_linearize the head skb when
reassembling msgs") in v5.13-rc4.
Fixed in v6.9-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.4

Fixed status
mainline: [97bf6f81b29a8efaf5d0983251a7450e5794370d]
stable/4.19: [01cd1b7b685751ee422d00d050292a3d277652d6]
stable/5.10: [adbce6d20da6254c86425a8d4359b221b5ccbccd]
stable/5.15: [42c8471b0566c7539e7dd584b4d0ebd3cec8cb2c]
stable/5.4: [2f87fd9476cf9725d774e6dcb7d17859c6a6d1ae]
stable/6.1: [d03a82f4f8144befdc10518e732e2a60b34c870e]
stable/6.6: [614c5a5ae45a921595952117b2e2bd4d4bf9b574]

CVE-2024-36955: ALSA: hda: intel-sdw-acpi: fix usage of
device_get_named_child_node()

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36955-312f@gregkh/

Introduced by commit 08c2a4b ("ALSA: hda: move Intel SoundWire ACPI
scan to dedicated module") in v5.12-rc2.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c158cf914713efc3bcdc25680c7156c48c12ef6a]
stable/5.15: [bd2d9641a39e6b5244230c4b41c4aca83b54b377]
stable/6.1: [722d33c442e66e4aabd3e778958d696ff3a2777e]
stable/6.6: [7db626d2730d3d80fd31638169054b1e507f07bf]

CVE-2024-36956: thermal/debugfs: Free all thermal zone debug memory on
zone removal

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36956-59d8@gregkh/

Introduced by commit 7ef01f2 ("thermal/debugfs: Add thermal debugfs
information for mitigation episodes") in v6.8-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72c1afffa4c645fe0e0f1c03e5f34395ed65b5f4]

CVE-2024-36957: octeontx2-af: avoid off-by-one read from userspace

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36957-5919@gregkh/

Introduced by commit 3a2eb51 ("octeontx2-af: Fix an off by one in
rvu_dbg_qsize_write()") in v5.12-rc1.
Fixed in v6.9-rc7.
Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [f299ee709fb45036454ca11e90cb2810fe771878]
stable/5.10: [bcdac70adceb44373da204c3c297f2a98e13216e]
stable/5.15: [ec697fbd38cbe2eef0948b58673b146caa95402f]
stable/6.1: [8f11fe3ea3fc261640cfc8a5addd838000407c67]
stable/6.6: [0a0285cee11c7dcc2657bcd456e469958a5009e7]

CVE-2024-36958: NFSD: Fix nfsd4_encode_fattr4() crasher

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36958-541a@gregkh/

Introduced by commit 83ab867 ("NFSD: Add struct nfsd4_fattr_args") in v6.7-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18180a4550d08be4eb0387fe83f02f703f92d4e7]

CVE-2024-36959: pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()

Announce: https://lore.kernel.org/linux-cve-announce/2024053041-CVE-2024-36959-ade5@gregkh/

Introduced by commit 91d5c50 ("pinctrl: devicetree: fix null pointer
dereferencing in pinctrl_dt_to_map") in v6.1-rc6.
Fixed in v6.9-rc7.
Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.4 cip/4.4-rt cip/4.4-st cip/5.10
cip/5.10-rt stable/4.19 stable/5.10 stable/5.15 stable/5.4

Fixed status
mainline: [a0cedbcc8852d6c77b00634b81e41f17f29d9404]
stable/4.19: [06780473cb8a858d1d6cab2673e021b072a852d1]
stable/5.10: [35ab679e8bb5a81a4f922d3efbd43e32bce69274]
stable/5.15: [76aa2440deb9a35507590f2c981a69a57ecd305d]
stable/5.4: [47d253c485491caaf70d8cd8c0248ae26e42581f]
stable/6.1: [518d5ddafeb084d6d9b1773ed85164300037d0e6]
stable/6.6: [026e24cf31733dbd97f41cc9bc5273ace428eeec]

CVE-2024-36960: drm/vmwgfx: Fix invalid reads in fence signaled events

Announce: https://lore.kernel.org/linux-cve-announce/2024060341-CVE-2024-36960-d1bf@gregkh/

Introduced by commit 8b7de6a ("vmwgfx: Rework fence event action") in v3.4-rc1.
Fixed in v6.9-rc7.

Fixed status
mainline: [a37ef7613c00f2d72c8fc08bd83fb6cc76926c8c]
stable/4.19: [2f527e3efd37c7c5e85e8aa86308856b619fa59f]
stable/5.10: [3cd682357c6167f636aec8ac0efaa8ba61144d36]
stable/5.15: [b7bab33c4623c66e3398d5253870d4e88c52dfc0]
stable/5.4: [cef0962f2d3e5fd0660c8efb72321083a1b531a9]
stable/6.1: [0dbfc73670b357456196130551e586345ca48e1b]
stable/6.6: [7b5fd3af4a250dd0a2a558e07b43478748eb5d22]

CVE-2024-36961: thermal/debugfs: Fix two locking issues with thermal zone debug

Announce: https://lore.kernel.org/linux-cve-announce/2024060344-CVE-2024-36961-58bb@gregkh/

Introduced by commit 7ef01f2 ("thermal/debugfs: Add thermal debugfs
information for mitigation episodes") in v6.8-rc1.
Fixed in v6.9-rc7.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c7f7c37271787a7f77d7eedc132b0b419a76b4c8]

CVE-2024-36962: net: ks8851: Queue RX packets in IRQ handler instead
of disabling BHs

Announce: https://lore.kernel.org/linux-cve-announce/2024060344-CVE-2024-36962-c630@gregkh/

Introduced by commit be0384b ("net: ks8851: Handle softirqs at the end of
IRQ thread to fix hang") in 6.9-rc4. Fixed in 6.9.
Bug introduced commit be0384b was backported to 6.1 and 6.6.
Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [e0863634bf9f7cf36291ebb5bfa2d16632f79c49]
stable/6.1: [8a3ff43dcbab7c96f9e8cf2bd1049ab8d6e59545]
stable/6.6: [ae87f661f3c1a3134a7ed86ab69bf9f12af88993]

CVE-2024-36963: tracefs: Reset permissions on remount if permissions are options

Announce: https://lore.kernel.org/linux-cve-announce/2024060344-CVE-2024-36963-b8cc@gregkh/

Introduced by commit 8186fff ("tracefs/eventfs: Use root and instance
inodes as default ownership") in v6.8-rc1.
Fixed in v6.9-rc7.
Bug introduced commit 8186fff was backported to 6.6.
Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [baa23a8d4360d981a49913841a726edede5cdd54]
stable/6.6: [5f91fc82794d4a6e41cdcd02d00baa377d94ca78]

CVE-2024-36964: fs/9p: only translate RWX permissions for plain 9P2000

Announce: https://lore.kernel.org/linux-cve-announce/2024060345-CVE-2024-36964-d557@gregkh/

There is no mention of the commit that introduced the bug in the CVE
announcement.Fixed in v6.9-rc5.
It seems as if it introduced by commit df345c6 ("fs/9p: v9fs_stat2inode
should update suid/sgid bits.") in 3.3-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd25e15e57e68a6b18dc9323047fe9c68b99290b]
stable/4.19: [e90bc596a74bb905e0a45bf346038c3f9d1e868d]
stable/5.10: [5a605930e19f451294bd838754f7d66c976a8a2c]
stable/5.15: [ad4f65328661392de74e3608bb736fedf3b67e32]
stable/5.4: [df1962a199783ecd66734d563caf0fedecf08f96]
stable/6.1: [ca9b5c81f0c918c63d73d962ed8a8e231f840bc8]
stable/6.6: [e55c601af3b1223a84f9f27f9cdbd2af5e203bf3]

* Updated CVEs

No updated.

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

