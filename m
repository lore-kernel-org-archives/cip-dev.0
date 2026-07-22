Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25FCC4453A
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 22:17:31 +0000 (UTC)
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11707.1784758648448870871
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jul 2026 15:17:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=y+V9DvVP;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.49, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6626b5ace23so6271376d50.0
        for <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 15:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784758647; cv=none;
        d=google.com; s=arc-20260327;
        b=sC9VoS67x6R6A8zp9dJCPVifkGbRx4ytMByyPHLIPhxqbpsgP0PBHVnyZGWAb4WKKk
         AGmqo8AYabJwf2tf5b43N/jU/iWlP2QIfYm7WkHflHgdBD4BV4Uj5i2TANo1JoumKlOI
         kncq3o8bvpOqcIKDOswotv5u4Y40pSCVTAkg83VGkUkgGvSi5QTYBjrpHvwWPubbb9zv
         W/PtFGks+IQntHKxRrvkOwzQqWmEPWiGr9bEKH9BaXkWugtbI7rdAt9eO4XEfR+q6R8r
         GADo/Z+HQb725aDIDeMJxOQZjj4RzGjrFrX79lEtnIby/2FqZ7dj4DnayZHo9xnZLATx
         eS4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=hImsn/xA7Fi7kO7VXvEVU8tKyqQCUigMIL86wIHX+NA=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=ZRBndSpyvwrxFHiA58ZP7Mjoxg5qL3YG+duxRSsWsX3XiFGMY40guBcu22wrpdmMLb
         cit6BZaK88dGcUIDGKx3LhQS77iF8KWxUn5QCRtsEkPV1IOG3v6yxQz4aBgou4C/coR+
         /a+KbnhSklBd1yXE+y36Ox/y8dZOgsFvc2nc7md5jmhL+gz16Reo9+CJ2XRyXdXcwQAI
         2qeXPfT0LcYUPvzIIDFRuh59jlwD+0uPJVxVKYQBVdZpDg0oTsON/EQ1Uc0vzJTZAfg5
         zHESFsBI1r6mItQ1exUcRYG4JAI4HNddmvp1SNDRdfkdktaK8Bndhzf/NynycOPLQ6bL
         AEdA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1784758647; x=1785363447; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hImsn/xA7Fi7kO7VXvEVU8tKyqQCUigMIL86wIHX+NA=;
        b=y+V9DvVPbAIRYilNZPNXwR/BQWVMKkYk5BLa0IIU358kd1Y32HyDRYuhC4QmmZCsl0
         AUGKCLisK+yoo2vz/JbHr/3XLkOLdoQuYdoFUzvI+saRyYoHMViLP2JSS4QZSGAgeOTl
         /dXA4jUrRskSC622MCX/amKaOXyD7qI1duydLXlsIY9inFZs1RKBG0r4bxk2dhnB3xTe
         MM77OlQt3SA1QOVe226k/C0om2Kj2d13jMVrKNqnr+JqgBiy/4BwsJN7ifaa+HeVMGpT
         R0k0szRFib6DGAYZkL4na7fwDlKHB/4MbIb7b4qbOxMK9QQGhHw2oVV7jjN0nzEE2Ofv
         n1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784758647; x=1785363447;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hImsn/xA7Fi7kO7VXvEVU8tKyqQCUigMIL86wIHX+NA=;
        b=f71R6wlFjZml2cXPLm0zLMOjaW7O1TajBqs7IUHaK68WG3FkUe+tnr8CCDlECzr7zn
         02+jLQEKAeS7xMl/5ZArBKpVCBad5XErgnalrWTdj526NXqUN6o4nktijDnYeQR0Sc8h
         LtaYhQXKJ0TBqvB5d5XqVdPlKDDuqmqfpXYeg+UP8hZc6WwxJ3/+n5qyo7PZP59gbFjh
         h5eqWrAThF8R4LhHo59h6DcLucJ7cg3pBDeKU/oA1o+EaOIwNMLryDmhwiZMcHmsw4vb
         LjI4x/sK0DxTc6A3tYbYF+R9gcu5KylzyJpCBRkeb1V3s/NW94Ng5lg8QmPRjf/ALJj3
         eTQw==
X-Gm-Message-State: AOJu0YxUQ/pnSt33fMKf7AtXdmvYLU/cWML8HHva7KfNCAyqA6g6E9GZ
	jjBETsQYG7gHZj9KhjLgkFbTAlFFSihp91tminocaTmoyVaCILqp711vam2glFU39U/Qoy0Es6J
	/JZPdJXTZhuU653ms9POFSftcZtwdAa5fIhhiDz6HURX/yV4/QOOAdsA8Lw==
X-Gm-Gg: AR+sD10eOTGF7NNRBiHqEjlRxg1C73wQdKsQA0G9seHtdJ64IOk5iJAs8cLdz4F6K3d
	k+eQ9g1ejqMUaNp+CIMPbZGVSRziVEz6XOQK7twmH7b1EJY/qSZonRiuXVBQ+OYEz5CYSHcHMz+
	97VdO6ITCLVrVUsCaPJGGPgldrHAI4zTYgIwvY4tNItoEd6WmWZQO9fUV3fhhpzL2Q7wgpFQzEQ
	dqiCE2sq7Td0LkzSq6tczAzuTDAsoJ39qroYESFo7Arc+G7BNA35cKmfI/YeptS4yXk1TAFWLqn
	xL6fn9STbA1CB4DrYPYPjGixdNy8+x/2zEd8GQXYeSJz
X-Received: by 2002:a05:690e:4381:b0:667:ef7f:c37e with SMTP id
 956f58d0204a3-668a60c7880mr24780d50.8.1784758642100; Wed, 22 Jul 2026
 15:17:22 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Jul 2026 07:16:45 +0900
X-Gm-Features: AUfX_my_csYsN0hz9trZenfj7c0BSIMobNyCyrb01qqPHanEND7ZeJ0403fX5R8
Message-ID: <CAODzB9rZBYjz-_4qpAVuwuV5tPxuAR+JdzmSAfyG382Ka-JHgw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 22:17:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23721

Hi!

It's this week's CVE report.

This week reported 442 new CVEs and 5 updated CVEs.

* New CVEs
CVE-2026-53366: ipv4: account for fraggap on the paged allocation path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53366

Introduced by commit 8eb77cc ("ipv4: avoid partial copy for zc") in v6.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eca856950f7cb1a221e02b99d758409f2c5cec42]
stable/6.12: [a9c24eda24bd15f432e37824e6fc440977cb241c]
stable/6.18: [77798d7be6ef71e72fb6fc8a2901bf74ebc9706f]
stable/6.6: [ce494707a9c07f27c219ca67f3e138061f53d9b3]
stable/7.1: [c04d9ece23deb9e26c19f9ca215e98b3295aa1bb]

CVE-2026-53367: selinux: fix avdcache auditing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53367

Introduced by commit dde3a5d ("selinux: move avdcache to per-task
security struct") in v6.18-rc7.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f92d542577db878acfd21cc18dab23d03023b217]
stable/6.18: [e3e722ea88e051ae5361dc540c01ba18f87b5ffd]

CVE-2026-53368: f2fs: fix fsck inconsistency caused by incorrect
nat_entry flag usage

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53368

Introduced by commit 88bd02c ("f2fs: fix conditions to remain recovery
information in f2fs_sync_file") in v3.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [019f9dda7f66e55eb94cd32e1d3fff5835f73fbc]
stable/6.18: [bedb710b63ae1bd617e65d0a8cf6cea1200b3753]

CVE-2026-53369: udf: reject descriptors with oversized CRC length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53369

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7a3af1243a444678071f421554e412059d981fc3]
cip/4.4-st: [fe106908ea39d779ed9d574db1c71e6dd9a6a0ad]
mainline: [55d41b0a20128e86b9e960dd2e3f0a2d69a18df7]
stable/5.10: [832ab4a882dc9b3c0155490d9993642ef545fd22]
stable/5.15: [7d1b6adbf90df6c8941090d5646fbeca25ba9770]
stable/6.1: [3dede76d525919bb966f9213e131af685de5ff99]
stable/6.12: [31605bbe94557bff721eaf041001169d44ac6f98]
stable/6.18: [1873eb81c65d3f849418d7386baa39c439c9fc38]
stable/6.6: [50dfaf4a027742b4fcdc3e9305e7199ece9bc6a6]

CVE-2026-53370: perf/x86/intel: Improve validation and configuration
of ACR masks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53370

Introduced by commit ec980e4 ("perf/x86/intel: Support auto counter
reload") in v6.16-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ad732a56be46aabf158c16aa0c095291727aaef]
stable/6.18: [aab56b95bee3ff79176b13443cd9d7cfe9747df0]

CVE-2026-53371: RDMA/ionic: bound node_desc sysfs read with %.64s

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53371

Introduced by commit 2075bbe ("RDMA/ionic: Register device ops for
miscellaneous functionality") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [654a27f25530d052eeedf086e6c3e2d585c203bd]
stable/6.18: [61df14f306f153bffa2f3c74a94ff5a85c99fa39]

CVE-2026-53372: iommu/vt-d: Block PASID attachment to nested domain
with dirty tracking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53372

Introduced by commit 67f6f56 ("iommu/vt-d: Add set_dev_pasid callback
for nested domain") in v6.13-rc1.
Introduced by commit 67f6f56 ("iommu/vt-d: Add set_dev_pasid callback
for nested  domain") in v6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc5bd898ff70710ffc41cd8e5c2741cb64750047]
stable/6.18: [3ea9ce757bd3de955b56e7bc5672fc479e40b045]

CVE-2026-53373: mm/vma: do not try to unmap a VMA if mmap_prepare()
invoked from mmap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53373

Introduced by commit ac0a3fc ("mm: add ability to take further action
in vm_area_desc") in v6.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [619eab23e1ce7c97e54bfc5a417306d94b3f6f13]

CVE-2026-53374: drm/amdgpu: zero-initialize GART table on allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53374

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6c2e6c2e1fa066968a16aca1cb66cd1bdde7741]
stable/6.1: [40df11255d71b02e20e70579f1b12b687e396e26]
stable/6.12: [8ae8b9e74bab94aab1d79f1688129bcc61c8b29a]
stable/6.18: [b17175d0a375b3ed5e81597dac4983fdb46e478d]
stable/6.6: [91fbb5e635c8fb1b49e15c19da06480089ef719f]

CVE-2026-53375: drm/amdgpu/vce: Prevent partial address patches

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53375

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de2a02cc28d6d5d37db07d00a9a684c754a5fd74]
stable/6.1: [2d66d1f5d8c0434e9a5ad21cc6eaf3a5e32141d5]
stable/6.12: [0ee17150763962671f43a62ddf8f6ea1feaff438]
stable/6.18: [b3d1a0a45c4aec484fa2a5b060b611e3d3064470]
stable/6.6: [944db9cfa5373f67eb94621d4c2eee572c05fa3f]

CVE-2026-53376: drm/amdkfd: Add upper bound check for num_of_nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53376

According to the .vulnerable file, this bug was introduced by commit
c7bcbfa in v4.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74b73fa56a395d46745e4f245225963e9f8be7f1]
stable/6.12: [6ba6ec5fcbb0d03ca11ed1cc38d57a7deb6c6b20]
stable/6.18: [44d5a450c04d3d734c13a03561c3131020d66edf]
stable/6.6: [4a8093c7def141cc6e854fbe3f9693867982418f]

CVE-2026-53377: drm/msm: always recover the gpu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53377

According to the .vulnerable file, this bug was introduced by commit
c8af219 in v5.19-rc4.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01a0d6cd7032e9993feea19fadb03ef9d5b488f2]
stable/6.18: [132b8d51f0ffbee6e4e1ebbe1a50330aaf2dbd5d]

CVE-2026-53378: drm/colorop: Fix blob property reference tracking in
state lifecycle

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53378

Introduced by commit cfc2768 ("drm/colorop: Introduce new drm_colorop
mode object") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [235b333e2878d791cee09e1e72f44611a9400114]

CVE-2026-53379: media: i2c: ov8856: free control handler on error in
ov8856_init_controls()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53379

Introduced by commit 879347f ("media: ov8856: Add support for OV8856
sensor") in v5.1-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f75e160745663ce9b13362ae6e90bd439c58df69]
stable/5.15: [c13721040a566d832ee8a20ecf04b7ef288a1525]
stable/6.1: [d1b3811c6b0f67fb7f0acfe09bf8244aa8b12465]
stable/6.12: [ba9e9274c4ecfc039c45752dd6055137eaa5f08e]
stable/6.18: [791598484fd558bb426ef5e051effa5c227d5390]
stable/6.6: [fd10fb4c33bdc9c25c9b9d5e7e39f635e34c44a3]

CVE-2026-53380: media: rzv2h-ivc: Fix concurrent buffer list access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53380

Introduced by commit f0b3984 ("media: platform: Add Renesas Input
Video Control block driver") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72773ff1cdfaebc593f53b1719b2c1773ecf8c43]

CVE-2026-53381: virtiofs: fix UAF on submount umount

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53381

Introduced by commit 26e5c67 ("fuse: fix livelock in synchronous file
put from fuseblk workers") in v6.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [06b41351779e9289e8785694ade9042ae85e41ea]
stable/5.10: [607a1d4c42f649e6197567c0448fd9ebb316cd42]
stable/5.15: [1cc0e3a0c6499aaaa2f21a4fcbba388486afb25e]
stable/6.1: [0b809199ff87c44487e516a725dd4be2185712ce]
stable/6.12: [97c4691653d145dcc699eca5d3aba3219a520f1f]
stable/6.18: [2abfd3ffbd9452f72535d96ff3982b3ab1f8f2f9]
stable/6.6: [2181a09ba980f142650fb053666350ead4471cfe]
stable/7.1: [e09412a714bcd49375198427bb4aa005037a9d6f]

CVE-2026-53382: media: vidtv: fix NULL pointer dereference in vidtv_mux_push_si

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53382

Introduced by commit f90cf60 ("media: vidtv: add a bridge driver") in v5.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d8bf3d8f91073f4db347ed3aa6302b56107499c]
stable/5.10: [455bc12e7b73ab5a2dfcb47822e91e772bc6c42e]
stable/5.15: [f0f5a1d7056980a0d512456fdb370cfb72bba86a]
stable/6.1: [6df7e16d4f742c80add58995a6e69385b97aa9e6]
stable/6.12: [353d9578951dd38bc9679308f5b618ceed1f20fa]
stable/6.18: [f965cf22dda7f512f4922415894c3e528269a4ae]
stable/6.6: [cd923dadefadb9671b5ac341b672ff424d429c39]
stable/7.1: [232e4b313ea342672edf8947e067c0de4328405b]

CVE-2026-53383: ksmbd: reject non-VALID session in compound request branch

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53383

Introduced by commit 5005bcb ("ksmbd: validate session id and tree id
in the compound request") in v6.4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [609ca17d869d04ba249e32cdcbf13c0b1c66f43c]
stable/5.15: [25ff12b82a376ff5c4583102a63d2456a6b9ebb9]
stable/6.1: [fc578523a72cb8b329d32070b95898e81613cc3f]
stable/6.12: [8f0302fb691537d33ec8f668565257ea9d340ffe]
stable/6.18: [7cad3ceaf679c55bc9946685dacafce78ce6b51a]
stable/6.6: [d2bbbb6c55812220fee5d801c275cc267ea3cbeb]
stable/7.1: [5f983b864d3d473ac533b2f4f44a1bbe5dcbccf4]

CVE-2026-53384: serial: 8250_dw: unregister 8250 port if
clk_notifier_register() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53384

Introduced by commit cc81696 ("serial: 8250_dw: Fix common clocks
usage race condition") in v5.9-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10fc708b4de7f86002d2d735a2dbf3b5b7f65692]
stable/6.1: [ccdf4510a3873b14e5e348cdb038717996f09fda]
stable/6.12: [07ffe414a708ae60551401cec5d727ed156b8caf]
stable/6.18: [3d205fe80f2181f0109150ad1fa06ee5bc046935]
stable/6.6: [511d2b92f8d20de04acafab676150d26fb5c67f4]
stable/7.1: [778b9dda4b24005a27bcd9c35c110bf8d7f259ca]

CVE-2026-53385: vc_screen: fix null-ptr-deref in vcs_notifier() during
concurrent vcs_write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53385

Introduced by commit 8fb9ea6 ("vc_screen: reload load of struct
vc_data pointer in vcs_write() to avoid UAF") in v6.4-rc3.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
mainline: [a287620312dc6dcb9a093417a0e589bf30fcf38a]
stable/5.10: [43a6281790273c1b0a9ab76609ff0245b968f1e6]
stable/5.15: [b6bbb85cf45bf0b070e741997fe0af3a772c5ad5]
stable/6.1: [ff4806202749a51938236214adc0281481a57366]
stable/6.12: [73049768ad57145acd337102c5aa3c788e6642c8]
stable/6.18: [7cc3dd79777f6ae4625ec37e84dd18a26dc88bde]
stable/6.6: [8232fca738011ca2ec865b46ec721d1796dc0580]
stable/7.1: [09a43e81279b8da15526da09877134b8bcf618b0]

CVE-2026-53386: iio: adc: ti-ads1298: add bounds check to pga_settings index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53386

According to the .vulnerable file, this bug was introduced by commit
00ef770 in v6.9-rc1.
Fixed in v7.2-rc1.
Affected function was added by 00ef770 ("iio: adc: ti-ads1298: Add
driver") in v6.9-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95e8a48d7a85d4226934020e57815a3316d3a14b]
stable/6.12: [d5793975fc3b1780ba576812158ef22e3104e60e]
stable/6.18: [d08d82d83ed45fd8c001a9df66ad7ebb86c9d6c6]
stable/7.1: [abd776ded3e256889610595290f6ca46cb6e91ab]

CVE-2026-53387: iio: light: veml6075: add bounds check to veml6075_it_ms index

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53387

According to the .vulnerable file, this bug was introduced by commit
3b82f43 in v6.8-rc1.
Fixed in v7.2-rc1.
Affected function was added by 3b82f43 ("iio: light: add VEML6075 UVA
and UVB light sensor driver") in v6.8-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [307dc4240bd41852d9e0912921e298160db1c109]
stable/6.12: [df9127a1d2d748e426c49c8fcd9b6801e4eb743d]
stable/6.18: [0a89002737ee34decc20fa232204dbe5fe83e0de]
stable/7.1: [e545936e06f1c7173ab41a5f33a77ff43ced3a8d]

CVE-2026-53388: fuse: re-lock request before replacing page cache folio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53388

Introduced by commit ce534fb ("fuse: allow splice to move pages") in
v2.6.35-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a078484921052d0badd827fcc2770b5cfc1d4120]
stable/5.15: [7c18691e0cfda29672f79bafde8abdb7710674f6]
stable/6.1: [5927b43a4f8d89e86930f524bf63e9c7e66f61b4]
stable/6.12: [46473ddccdc5065033e397d6e62c280dbcd3d9c2]
stable/6.18: [af2892249d982a1c036ca456cc135374e68b6677]
stable/6.6: [030fe3e9d8abdee303dd7e9e42f45082d382a407]
stable/7.1: [e28db6ac4792d065ab32565fd9f0a2361c3d4666]

CVE-2026-53389: net/tcp-ao: fix use-after-free of key in del_async path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53389

Introduced by commit d6732b9 ("net/tcp: Allow asynchronous delete for
TCP-AO keys (MKTs)") in v6.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ba9950bc9078e19b69cca1e56d1553b125c6857]
stable/6.12: [6ce7ef41743740ce15c2061561b784148b565b3f]
stable/6.18: [e77fbefd1269b5c123e7c651a1ebdce1b87d19a0]
stable/7.1: [7ddc29a094d96e9b3aa280433c6dc443df9eabf2]

CVE-2026-53390: ksmbd: fix out-of-bounds read in smb_check_perm_dacl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53390

Introduced by commit d07b26f ("ksmbd: require minimum ACE size in
smb_check_perm_dacl()") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [1ef06004ed4bd6d3ed8c840d9d1a376b66d4935b]
stable/6.1: [988c93d3bba066d8669143e6ec30bb2be9608d53]
stable/6.12: [d5c81a095c86fe507c032d08f3a8cfc518444927]
stable/6.18: [7627ff8c4f9919f14de562b0160ab4ec9d80b1f7]
stable/6.6: [36599894fa8536fefdf1e296c0af71b8b7226859]
stable/7.1: [e36e35660adb9b8ef1435ac359151dda5f094c55]

CVE-2026-53391: NFSv4/pNFS: reject zero-length r_addr in nfs4_decode_mp_ds_addr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53391

Introduced by commit 6b7f3cf ("nfs41: pull decode_ds_addr from file
layout to generic pnfs") in v4.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41fe0f7b84f0cb822ae10ab08592996a592b2a25]
stable/5.15: [76b94cbd32aacf36a641956385a852635c6802b9]
stable/6.1: [c8e4e0c701d0192a2efb6df059c0f9e19678c23d]
stable/6.12: [427ab81a811dab4bca9d19f82eec5847ae42646e]
stable/6.18: [012d37a568bfbb2c9686f03ade75560bc7139956]
stable/6.6: [6c344fff2feff9d4d716d8e4ad40e9b5040ee5ea]
stable/7.1: [30aae62e50b4e074a90a9a5e15246548fbdc1182]

CVE-2026-53392: NFSv4/flexfiles: reject zero filehandle version count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53392

Introduced by commit d67ae82 ("pnfs/flexfiles: Add the FlexFile Layout
Driver") in v4.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c6bb3c40bc24f6aa8dfbe6fe98c3ad6389203f2]
stable/6.12: [7779c85028a0676fb190cde4f0c540f4f8e97761]
stable/6.18: [d8c90c7cc061265d5f2813a1f5c82ef2f4707e67]
stable/7.1: [2131ed64b767ffa8bcdb3677d90f3964e39aabc8]

CVE-2026-53393: nfsd: reset write verifier on deferred writeback errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53393

Introduced by commit 555dbf1 ("nfsd: Replace use of rwsem with
errseq_t") in v5.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [2090b05803faab8a9fa62fbff871007862cac1b7]
stable/6.12: [1dd664b39774a9c89b72de8e59bf9ef4b3aaff2e]
stable/6.18: [4367afc119c51e17a616f6908772b7e2c2c4013f]
stable/7.1: [b027cca33c97354149fcc0ddeede4525c41093cd]

CVE-2026-53394: nfsd: avoid leaking pre-allocated openowner on
unconfirmed retry race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53394

Introduced by commit 23df177 ("nfsd: perform all
find_openstateowner_str calls in the one place.") in v6.10-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57aee7a35bb12753057c5b65d72d1f46c0e95b07]
stable/6.12: [c9aefb2b5f11337c9202c5bd0c45d71198449718]
stable/6.18: [017a6150106b054cc84d1b0582d97bd3a74d4281]
stable/7.1: [a10bf67fe06469a71a401f72f328237345d553c0]

CVE-2026-53395: nfsd: fix dead ACL conflict guard in nfsd4_create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53395

Introduced by commit d2ca506 ("NFSD: Add support for POSIX draft ACLs
for file creation") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a60f25a800846ab8e5a13f8a9d05111f2aee55a7]
stable/7.1: [8371cc5c0a2cc2a71b3dcfd47ff1f7fcfc526a5e]

CVE-2026-53396: nfsd: fix posix_acl leak and ignored error in nfsd4_create_file

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53396

Introduced by commit 7ab96df ("VFS/nfsd/cachefiles/ovl: add
start_creating() and end_creating()") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24c975bbdd564d7d0ad90294bfa69729830345de]
stable/7.1: [18cf006a08babec0bbac2a3784f8f28e56e47490]

CVE-2026-53397: nfsd: fix posix_acl leak on SETACL decode failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53397

Introduced by commit a257cdd ("[PATCH] NFSD: Add server support for
NFSv3 ACLs.") in v2.6.13-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0853ac544c590880d797b04daa33fcb72b6be0e1]
stable/5.10: [b2eb1ffd511d1b3c3e21122f97cbbccea411e277]
stable/5.15: [b94c4be77682aab06d65ca7296149e3bcfb37353]
stable/6.1: [887f92ceccf3eacd5f2402db21254d66372fae00]
stable/6.12: [bd69a825485168ef74e815ecb286754b570fdcc7]
stable/6.18: [136b416593f1349cf6f72c8e3d18f0f204ee8545]
stable/6.6: [1e96239fddcefacf6afe6c498357be68eacbcabc]
stable/7.1: [a5b42c1e4ff2befaa6b96f7cbf32174751eba083]

CVE-2026-53398: NFSD: Fix SECINFO_NO_NAME decode error cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53398

Introduced by commit 3fdc546 ("NFSD: Reduce amount of struct
nfsd4_compoundargs that needs clearing") in v6.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [9e18e83b8846a5c3fe13fc8a464b4865d33996c6]
stable/5.10: [8836405abdc53ca3dd5fc68b2cf6f8f012fad011]
stable/5.15: [49de5d31dd8fdebf78bdeaf196b0ca5cd5c75439]
stable/6.1: [5ec37edcb534f3fc92304be236d37f08e6545585]
stable/6.12: [161d1aaeb04d620d3692639700512bb5038c1e10]
stable/6.18: [c8a24effd96d4779e2ad779654682304491c55a5]
stable/6.6: [1e04be34cafae119e82bcaccd6d28a20f72a3647]
stable/7.1: [46eb17d45be69d28c7a23ea03283b207426a8232]

CVE-2026-53399: nfsd: release layout stid on setlease failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53399

Introduced by commit c5c707f ("nfsd: implement pNFS layout recalls")
in v4.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30d55c8aabb261bc3f427d6b9aae7ef6206063f9]
stable/6.12: [d369e5edfaaf83a448016e2f1da392b2174be801]
stable/6.18: [8dee7c278f1c2b5bb80e17a6281c3812fc8b0cdd]
stable/7.1: [83c2b7797742339bb768f83935f7ca33950db138]

CVE-2026-53400: i2c: core: fix adapter registration race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53400

Introduced by commit 6e13e64 ("i2c: Add i2c_add_numbered_adapter()")
in v2.6.22-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ba14d7cf2fe7284610a29854bdff22b2537d3ce6]
stable/6.12: [78793c75dc6d0ff2e4d50ad617349b328a99054e]
stable/6.18: [6a946038f2a5a8c29048c6af369d4e391448a5c5]
stable/7.1: [a4c8094bbf4c6fa68b17e3b16f6a0a1b7a14f3e0]

CVE-2026-53401: fbdev: omap2: fix use-after-free in omapfb_mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53401

According to the .vulnerable file, this bug was introduced by commit
078ff54 in v2.6.36-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7958e67375aa111522086286bba13cfc0816ce8d]
stable/7.1: [6eb6ebcc8590007ad59ddccc8b5f9201655b33f8]

CVE-2026-53402: fbdev: fbcon: fix out-of-bounds read in err_out of
fbcon_do_set_font()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53402

Introduced by commit a5a9230 ("fbdev: fbcon: Properly revert changes
when vc_resize() failed") in v6.0-rc3.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2]
stable/6.12: [b5bb2c696e140c399cb874def2feedf61dee27d6]
stable/6.18: [076b1aa65f77a49bce5a48a4a55a397cfcafa2b8]
stable/7.1: [39815715cbcfabb16fc8c5f4a23deeda20f5df62]

CVE-2026-53403: fbdev: Fix fb_new_modelist to prevent null-ptr-deref
in fb_videomode_to_var

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53403

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f08fc10fa3d3366dc3af723970bd03d7d6d10e3]
stable/5.10: [1458a4d804550b7101e8bb02c1cb941088e4c0c7]
stable/5.15: [8707f02ac9f5f632039b60df2c9f3dc914709f72]
stable/6.1: [0d8c7f21ad8529d5c181e61f86be35b887ae2e4d]
stable/6.12: [4f1a7fe8ba845cb7d39580755f78c3b7b9a0b61e]
stable/6.18: [eea16b6f805c0b1fb2f72f0f771088ea45356956]
stable/6.6: [7640b4f68acb54c2c4f6b4a8aee0e9849dacd929]
stable/7.1: [88913059c77e171f44ba829282d42dde0d458811]

CVE-2026-63793: ntfs: serialize volume label accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63793

According to the .vulnerable file, this bug was introduced by commit
9c87959 in v7.1-rc1.
Fixed in v7.2-rc1.
It looks as if this bug was instroduced by 9c87959 ("ntfs: update file
operations") in v7.1-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9e50ce4f13dc721014af622613409455c734942]
stable/7.1: [acd744019460bad22e43d4569a502f9c88d331ae]

CVE-2026-63794: KVM: SVM: Fix page overflow in sev_dbg_crypt() for ENCRYPT path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63794

Introduced by commit 24f41fb ("KVM: SVM: Add support for SEV
DEBUG_DECRYPT command") in v4.16-rc1.
Introduced by commit 7d1594f ("KVM: SVM: Add support for SEV
DEBUG_ENCRYPT command") in v4.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78ee2d50185a037b3d2452a97f3dad69c3f7f389]
stable/5.10: [f701ae476cb92a3a3d8844bb39bb63b4512684c8]
stable/5.15: [64f2449841ffc7d203183aa4c748c9c77951ecc5]
stable/6.1: [9349b50f4b11f135fe73b56cb2c2c872d8bc71d7]
stable/6.12: [e1a0fe288dee07b7da25a71e007c1ecd1080315b]
stable/6.18: [720949ed666f34ff28ffdfe1471a5861d1e41fdf]
stable/6.6: [889c2a9c59897ca912bf39df5bb92555a0a13df4]
stable/7.1: [2753a097d1fe24c4351c608048612c74108aa89f]

CVE-2026-63795: 9p: avoid putting oldfid in p9_client_walk() error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63795

Introduced by commit b48dbb9 ("9p fid refcount: add p9_fid_get/put
wrappers") in v6.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1a3860d46e3eb47dbd60339783cdad7904486b9f]
stable/6.1: [99c379ca1e221c3d75c7c804ebbf4e5ee37a3070]
stable/6.12: [a61bdcba4f64c2f90d01461913f429ab151f1ca6]
stable/6.18: [6dbe9443d9f5f7fb6d319a7b77108853ae6c6bea]
stable/6.6: [b84f46179c806450b89821221ea5bd9a1698aba8]
stable/7.1: [a7656d368265d085ac9bb85ab31b0cdb72ad8c38]

CVE-2026-63796: ocfs2: reject oversized group bitmap descriptors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63796

Introduced by commit ccd979b ("[PATCH] OCFS2: The Second Oracle
Cluster Filesystem") in v2.6.20.16.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9bd541e09dffff27e5bec0f9f45b0228173a5375]
stable/5.10: [336340a0f8a141df8a4eb21a5a86f8ffb87769f6]
stable/5.15: [296c6a42b1174395935ca4cfe8f393e37b698d54]
stable/6.1: [d2cd59fa848f9f13796ef214d3b1b5ca9a3fe21e]
stable/6.12: [8f9903b0cdbb3155a8899410330b4b4d583a7a5c]
stable/6.18: [4cd57ebee395041099fcdfcabb00749ce38d8b27]
stable/6.6: [c5a125eadba05ba421c4b55e68da22b4a40d32b4]
stable/7.1: [99c21e7263248c3f084756bfae08163cc5d6c62f]

CVE-2026-63797: rpmsg: char: Fix use-after-free on probe error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63797

Introduced by commit bc69d10 ("rpmsg: char: Introduce the "rpmsg-raw"
channel") in v5.18-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1ff3f528e67d20e2b1483dcaba899dc7832b2e6b]
stable/6.12: [c5ebb06c7e24d531b68707168e04698859d642bc]
stable/6.18: [104d100212396801f1d9d388282f746e23e2bfd6]
stable/6.6: [ddf13f91ca82c94ef7ad9c41a434a03313f8eb1b]
stable/7.1: [ff268cd9ccbce6472a0658791b417bf11c31ee39]

CVE-2026-63798: irqchip/imgpdc: Fix resource leak, add missing chained
handler cleanup on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63798

Introduced by commit b6ef916 ("irq-imgpdc: add ImgTec PDC irqchip
driver") in v3.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [37738fdf2ab1e504d1c63ce5bc0aeb6452d8f057]
stable/5.10: [8176773dfceae7978b01c20b233693e072053700]
stable/5.15: [c2c7733101bb8c0b29ac9ee41073eaf602821a59]
stable/6.1: [83d7ec14b0938ad8cae008058fd6f912f4a9a312]
stable/6.12: [41826e5297e67cd96a0a46fde06a5069a8ce436a]
stable/6.18: [b3a3831b2eb884641906fc5e46207b205b6aea13]
stable/6.6: [44567537a2623dcd2b4018a7f043cf8069579e5d]
stable/7.1: [0405a65e4ebd9eac13a765f9f02ac05851ca5421]

CVE-2026-63799: sched/mmcid: Fix OOB clear_bit when CID is
MM_CID_UNSET in fixup path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63799

Introduced by commit fbd0e71 ("sched/mmcid: Provide CID ownership mode
fixup functions") in v6.19-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de3ab9bd3133899efb92e4cd05ba4203e58fc0a3]
stable/7.1: [8d32856fb72ba976d9c87ba405fd17e80419934c]

CVE-2026-63800: pNFS: Fix use-after-free in pnfs_update_layout()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63800

Introduced by commit 2c8d5fc ("pNFS: Stricter ordering of layoutget
and layoutreturn") in v5.11-rc4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [13e198a90ca4050f4bee8a3f23680389a6563ccc]
stable/5.10: [4ad8b9a85dbf57ca532ee9e65ad7e6498bfbbf98]
stable/5.15: [1f24b8302c77dcaf79c64c073877a3b9f4dd25d2]
stable/6.1: [9c0fb5c09ae5bd68dc0038692af8127029cb0385]
stable/6.12: [2883ddd7542b4437a2ab4908fe2773f690e20889]
stable/6.18: [200e7637f4d6a1342987045eea72641524f909dc]
stable/6.6: [7e37e9b3e82ade881e1798e2f4fcc54aff7793c1]
stable/7.1: [9645aaf689aff57427ece3b9fa47d5b5399417f4]

CVE-2026-63801: tipc: fix slab-use-after-free Read in tipc_aead_decrypt_done

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63801

Introduced by commit fc1b6d6 ("tipc: introduce TIPC encryption &
authentication") in v5.5-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bda3348872a2ef0d19f2df6aa8cb5025adce2f20]
stable/5.10: [171d31245d11bf84836fad3b394cb465a4d008ec]
stable/5.15: [2d1f21419ec121232c916d3a3fc9b6766473a0e7]
stable/6.1: [0a780653b2a7569a7af9be7d0b00b1251baca63a]
stable/6.12: [dca7713fe044a2067387948557ea099056e1679e]
stable/6.18: [e18769616fd5a90ec1e12aabbba544c488284292]
stable/6.6: [eaca7dae02fab70c8d223cffe03cec1b93249ce2]
stable/7.1: [1eea5e1820a2f5164d706bd1277bc97ff31ce32d]

CVE-2026-63802: blk-cgroup: fix UAF in __blkcg_rstat_flush()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63802

Introduced by commit 20cb1c2 ("blk-cgroup: Flush stats before
releasing blkcg_gq") in v6.4-rc7.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ab5ee5a1badb58cbb2242617cb01a4972b1f2a2]
stable/6.12: [bbebd9425cad3573d1527441753899b926525a0f]
stable/6.18: [5e5b7f2ef854936e95dceb6a2fdfefcb7152d2c6]
stable/6.6: [96e545410c4f74c89d496c1d5d9ef8d08f14368b]
stable/7.1: [afebe44facc48a61761e885bbb7f0380d4a603ec]

CVE-2026-63803: hdlc_ppp: sync per-proto timers before freeing hdlc state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63803

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c78a4e41ab5ead6193ad8a2dd92e8906bae659fa]
stable/5.15: [8308122bc9c065b1f376e081ed300129a2ac9545]
stable/6.1: [ce8f9ddca0c9f217342a8b49efd309aa35b81a36]
stable/6.12: [c64dbef1c0fbd36f9530aa75112acdf6a6d3cfd8]
stable/6.18: [5a84398101bf9f11e84b176343e4e3ba83e668c0]
stable/6.6: [508a0139d3bf60f6a03d2fbfb63a89a9463d983a]
stable/7.1: [a594debfd4e7ec39413647458907f689ef57fd2f]

CVE-2026-63804: gfs2: fix use-after-free in gfs2_qd_dealloc

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63804

Introduced by commit a475c5d ("gfs2: Free quota data objects
synchronously") in v6.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9c9ec2c319f843b70ecdf939d48b52d189bc081]
stable/6.12: [8745d9f7e1682c39f0a1578895ac74205e2a6757]
stable/6.18: [b85ef03f726b15047a6fa6d11b639bdf6c0ee4f0]
stable/6.6: [4fe388218826df8607ae41a6305df67db08a9093]
stable/7.1: [9d0d5ba20cad661f7f287d4c66d2c19022ce2fd0]

CVE-2026-63805: crypto: nx - fix nx_crypto_ctx_exit argument

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63805

Introduced by commit bfd9efd ("crypto: nx - convert AES-ECB to
skcipher API") in v5.5-rc1.
Introduced by commit 9420e62 ("crypto: nx - Use API partial block
handling") in v6.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e67f504ee9ded15e256b64f4fde150e917381d7]
stable/6.18: [8d8507a457667f23477a15496b91908a5b5b7cf3]
stable/7.1: [833033e6e55acf11304ff7bbbdf18351d139c281]

CVE-2026-63806: KVM: Replace guest-triggerable BUG_ON() in ioeventfd
datamatch with get_unaligned()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63806

Introduced by commit d34e6b1 ("KVM: add ioeventfd support") in v2.6.32-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1edbed787ba67988ed34e0132ca128b052b6ce8]
stable/6.12: [bf89e3738480d33cd515b4a18900e8443d40cd2e]
stable/6.18: [5da9b1a87ec7cc3489c27016313524769f12d9e0]
stable/7.1: [5c87b47374682f69686068ad0a7779365a527b1c]

CVE-2026-63807: KVM: x86/mmu: Ensure hugepage is in by slot before
checking max mapping level

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63807

Introduced by commit 9eba50f ("KVM: x86/mmu: Consult max mapping level
when zapping collapsible SPTEs") in v5.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef057cbf825e03b63f6edf5980f96abf3c53089d]
stable/5.15: [7b52008023b7facf40fba3ebe92449bda8ea53b9]
stable/6.1: [5cab1c989f938f5e1b9a0de66486f1fc2c28479b]
stable/6.12: [c5c29b3c268332afe67d598a034c58344540ed92]
stable/6.18: [18587f9831612e24cd8f24be1ec15478feff7abc]
stable/6.6: [48b91ed7e22bb82571c34f8b80b6ecdc90a6fab8]
stable/7.1: [b2ae3245ea44dccaa9af676b6747476951883318]

CVE-2026-63808: exfat: fix potential use-after-free in exfat_find_dir_entry()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63808

Introduced by commit ca06197 ("exfat: add directory operations") in v5.7-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f5f8ee9917cc2b9076ac533492d8a200edcabb8]
stable/5.10: [e6f1a11cfb808441a43ffae9b476cc135732cd27]
stable/5.15: [e48f413c2815787b8cade2795e194e3c4cd782ef]
stable/6.1: [06c4e1e9967d332ac33ba38b7819851089ff9359]
stable/6.12: [4d101016d5e587f820b3ae2d5bb6770d86342649]
stable/6.18: [adfacfbaeae2cb760f492357cc36b41f84ef7f86]
stable/6.6: [8e0abc17fbd7e305802e84fe98b4950d50f9c433]
stable/7.1: [708b97e792945d3e4653939fd3405d71a61ad065]

CVE-2026-63809: bpf: use kvfree() for replaced sysctl write buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63809

Introduced by commit 4508943 ("proc: use kvzalloc for our kernel
buffer") in v5.12-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [4c21b5927d4364bfe7365f2700da5fea0ed0d004]
stable/5.10: [d0a81ed5ff5d0f9c3f63a4f9e5a4642c363ecd3e]
stable/5.15: [77355ef7a9f6b0d2bdf65be3b37f2c1f365e20d2]
stable/6.1: [e1d1e203a6000804c5d3b8a4aa4e52303c0c7ab2]
stable/6.12: [838fe9c28121777c59a9406710a68fcf77bb8017]
stable/6.18: [65bd0c0afb0e1bf3287458e342429b069624f7d4]
stable/6.6: [81fc9a13acae99966232f0e055eb2e445263b89a]
stable/7.1: [70df4de46577fab5e25418f014583155a147c902]

CVE-2026-63810: block: Avoid mounting the bdev pseudo-filesystem in userspace

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63810

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f73aa66dffcb8e61e78f01b56163ec16a15d06d2]
stable/6.12: [197971e6ffc0a6356b2ba2b22beb42bc0f7e412d]
stable/6.18: [3804e6de30ae7b053d53341d9d6944356cf23b40]
stable/7.1: [717f721eb67d2dacd3ed5f7495aef2f442e84ce4]

CVE-2026-63811: f2fs: read COW data with the original inode during atomic write

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63811

Introduced by commit 591fc34 ("f2fs: use cow inode data when updating
atomic write") in v6.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a41075acde0124d2f8a5f563068a5d63e8ffd57b]
stable/7.1: [a92332f32a8d31a7eee47b1dc1d751cb3319908f]

CVE-2026-63812: f2fs: fix incorrect FI_NO_EXTENT handling in
__destroy_extent_node()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63812

Introduced by commit ed78aee ("f2fs: fix node_cnt race between extent
node destroy and writeback") in v7.1-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [1f70ddb28a3c71df124da5fa4040c808116d6bb9]
stable/6.12: [58a5deb220bcac4c73bf58954c0845644c997487]
stable/6.18: [20190e498057997532c7f186d081011f18e0a462]
stable/6.6: [7e4d8f98be63f98856a5176b9188dada6e7ba9ee]
stable/7.1: [edf12cbeeeabe799bd2ee21fdb5c336cce6fbad7]

CVE-2026-63813: Revert "f2fs: remove non-uptodate folio from the page
cache in move_data_block"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63813

Introduced by commit 9609dd7 ("f2fs: remove non-uptodate folio from
the page cache in move_data_block") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [ccaba785821970f422c47770331c7e3271763f17]
stable/6.18: [1991d49433e90b2202de2fe90be3c24161873d7c]
stable/7.1: [6e035dae44154af4dd7bdb8ef7a1118c0b5f17b6]

CVE-2026-63814: f2fs: validate ACL entry sizes in f2fs_acl_from_disk()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63814

Introduced by commit af48b85 ("f2fs: add xattr and acl
functionalities") in v3.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4810ada31e80cbe4011467c4f3b1e93f94134f3]
stable/5.10: [733cd8474e6d763d75ed96f3f2b98a25480cf2b9]
stable/5.15: [4e2a96ec7236e248e706850568e0a925fd21b588]
stable/6.1: [442ca20c54038e2400cf28aaa944cf1de2c8e65d]
stable/6.12: [aba4f94ac1832c7299c33e1b4fe5f87eef6dc8f1]
stable/6.18: [ff83de56882cb8466184d322abece2589258ca56]
stable/6.6: [1ddf3fd21c4c652f9cab5552515c04a166662306]
stable/7.1: [5d8a39649947a4e86c8fbc682d7fc0041b8d109a]

CVE-2026-63815: f2fs: bound i_inline_xattr_size for non-inline-xattr inodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63815

Introduced by commit 6afc662 ("f2fs: support flexible inline xattr
size") in v4.15-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [378acf3cf19b6af6cba55e8dd1154c4e1504bae8]
stable/6.12: [2a9f9791653ba5ed3fb45bbffa8d63a7cd5cf706]
stable/6.18: [4ce2d52f680c1d8bfdad7cce05b815ea7ca9790d]
stable/7.1: [16bc237ce3c483b75575abea53cfb639745311ed]

CVE-2026-63816: f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63816

Introduced by commit 3db1de0 ("f2fs: change the current atomic write
way") in v5.19-rc1.
Introduced by commit f18d007 ("f2fs: use meta inode for GC of COW
file") in v6.11-rc1.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [e0288584baa5dc41df4a829a023c4c1b33fe53d7]
stable/6.12: [56038756aae68312df00d4aa1d97e51ef3aca725]
stable/6.18: [a499f77c06050a28c897bdbd86cd2f0721ae0743]
stable/7.1: [a805fec35c201c59643ddcde713bce4051c8ee27]

CVE-2026-63817: f2fs: validate compress cache inode only when enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63817

Introduced by commit 6ce19af ("f2fs: compress: add compress_inode to
cache compressed blocks") in v5.14-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5073c66a96a9c23c0c2533ed4ed06e42f9021208]
stable/6.1: [29115b8c9172d34e67ab26cc4f6c209b7a236d7a]
stable/6.12: [16161444c30d8dff9428abbae42b72ce4e32a932]
stable/6.18: [77f216ff9ce5cde8eed9f6d12707e906dffdc9f7]
stable/6.6: [13e4b59d3a9413f66f116fa6c4828519b960a5ea]
stable/7.1: [0969926d987bbde9a1aa49da317582ba37095805]

CVE-2026-63818: f2fs: validate orphan inode entry count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63818

Introduced by commit 127e670 ("f2fs: add checkpoint operations") in v3.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [846c499a65816d13f1186e3090e825e8bb8bcb8b]
stable/6.12: [550511a2470f6d204fa07b331f048bd2d3c51280]
stable/6.18: [8aad54746c251f2c2370118df766c0c82e2d2091]
stable/7.1: [2e12381d4495dc8b0ff042c6856022b2e359835c]

CVE-2026-63819: f2fs: fix to do sanity check on f2fs_get_node_folio_ra()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63819

According to the .vulnerable file, this bug was introduced by commit
e05df3b in v3.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8712353ed80f87271d732297567dcdbe4b84e8c7]
stable/6.18: [406c28af75123432d38cf9bbaa6f1476f7b14770]
stable/7.1: [0cc21c1ffe15b4156b0bf744f32fd1faef0b7c73]

CVE-2026-63820: f2fs: fix missing read bio submission on large folio error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63820

Introduced by commit a5d8b9d ("f2fs: fix to unlock folio in
f2fs_read_data_large_folio()") in v7.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74c8d2ec95c59a5651ecd975c466998af1961fd4]
stable/7.1: [48c92559e7b66fdc3cbc74f6e152e66ec0150a0a]

CVE-2026-63821: wifi: rtw88: usb: fix memory leaks on USB write failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63821

Introduced by commit a82dfd3 ("wifi: rtw88: Add common USB chip
support") in v6.2-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b964941bbfe6e0f18b1a5e008486dbb62df440a]
stable/6.12: [53fed4061a09755de99c89fdc7fae5b794da455f]
stable/6.18: [200d58c851b8f63f77a05570072dd20f79bc3681]
stable/6.6: [2b2060c2075a72bc2de43ce5e1b9347d6c5e27bb]
stable/7.1: [8206d173d18ef5a077423119f4e9a93cb3a6f4eb]

CVE-2026-63822: wifi: ath11k: fix warning when unbinding

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63822

Introduced by commit d5c6515 ("ath11k: driver for Qualcomm IEEE
802.11ax devices") in v5.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b7a26b6681922a38cd5a7829ace61f8e54df9b7]
stable/5.10: [e569a5cb401a267168621aa9a1e7f07fcc9612c3]
stable/5.15: [0aa097a370277deab5337030b9e2d395742f469c]
stable/6.1: [0a946abb82f29abe9a15173b707a449cb039b43e]
stable/6.12: [7b2e62b9080bf4a5f4e70cfe47156df8d93a4f13]
stable/6.18: [40aa3c2b0cb8e34e0576fc94cc70e4e33db03c0a]
stable/6.6: [318703b6f71d1a29ee0ac46c32a38f7734d4cfb2]
stable/7.1: [051f954b94479d72222c9fbc82a3eef4777bca01]

CVE-2026-63823: keys: Pin request_key_auth payload in instantiate paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63823

Introduced by commit b5f545c ("[PATCH] keys: Permit running process to
instantiate keys") in v2.6.20.16.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd15b457a86939c38aa12116adabd8ff686c5e51]
stable/5.10: [d8274181b0f28d450b42489723a5ba81042158d7]
stable/5.15: [4982bfabce6b33b3c9eddb4fb900fe5568b7cf91]
stable/6.1: [708709c65a1832a99b0eef8ae46e343ddaca3d06]
stable/6.12: [f9b68632ac93cc742f2e411021c4dbfe452ea0c2]
stable/6.18: [7216ce8cb12fee44e309503955bb83806b106129]
stable/6.6: [35ab4db86774d82389e4b9559e26ab7f68d8e395]
stable/7.1: [83c0a1cb296d955d5f4d1f0bd8a769ba8ed8c29f]

CVE-2026-63824: KEYS: fix overflow in keyctl_pkey_params_get_2()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63824

Introduced by commit 00d60fd ("KEYS: Provide keyctls to drive the new
key type ops for asymmetric keys [ver #2]") in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb481e59ea6cae3b7796ac1d7a22b6b24c3f3c0b]
stable/5.10: [622ec2dcd59f21623f2a7ab773c80ceb7d555e3a]
stable/5.15: [b1e247338bc71826a2d2def3e0874c34749df69a]
stable/6.1: [0f3058d7d26f81df9b68a18ddbe164bdc3c5eff3]
stable/6.12: [5165f1cc727f1322456735df212d8e26ec237a8d]
stable/6.18: [b11c1fa32667692a2c0566e10163758e786e430c]
stable/6.6: [5966e4e2ba213ab7ad559166152eb4f1f170dd2c]
stable/7.1: [670fc6a311ed321522b7fff92cf0fc376b4f6e78]

CVE-2026-63825: gcov: use atomic counter updates to fix concurrent
access crashes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63825

According to the .vulnerable file, this bug was introduced by commit
2521f2c in v2.6.31-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56cb9b7d96b28a1173a510ab25354b6599ad3a33]
stable/6.18: [49d893b9cbcfc5802a32e53a64c6c6956670d65b]
stable/7.1: [5b959c1dbb4522b9e3ac4e26ad638b8784869841]

CVE-2026-63826: fbdev: fix use-after-free in store_modes()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63826

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c1c805c65fb7dc7524e20376d6987721e73a0b1]
stable/6.12: [c6765f39ed27014ff877b00a2efa494233404e17]
stable/6.18: [0d35f9f194a858567a21017d69318a51e3a822b9]
stable/6.6: [5267eab88fa4c684459504b8be577ad64953b9a6]
stable/7.1: [70f1e000b88cfa8ca3fd7f4d082647fc089a7769]

CVE-2026-63827: apparmor: fix use-after-free in rawdata dedup loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63827

Introduced by commit a0b7091 ("apparmor: fix race on rawdata
dereference") in v7.0-rc4.
Fixed in v7.2-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [6f060496d03e4dc560a40f73770bd08335cb7a27]
stable/6.1: [a7a2890028f16e5b0af0bb005d80fcb32559cca3]
stable/6.12: [ce261a20b41db522e320a41bbf1292bf85af66df]
stable/6.18: [c3ca2631073b2cef06824fd2bfc452ff7a1023de]
stable/6.6: [15fd83a1e42ede15070968806bb6c8b1a5170688]
stable/7.1: [5e34fa9f6f7cd688ae153fff13139a5cf2d42339]

CVE-2026-63828: apparmor: mediate the implicit connect of TCP fast open sendmsg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63828

Introduced by commit cf60af0 ("net-tcp: Fast Open client -
sendmsg(MSG_FASTOPEN)") in v3.6-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d587cd8a72155089a627130bbd4716ec0856e21]
stable/6.1: [7f57428ce00891d26b0f087ef754a4d820ec83aa]
stable/6.12: [07b71c342382b854ab8030b244aeab6a7228ad7d]
stable/6.18: [4a69b83045d3195d5b9a9b053ad840ddb2998b4e]
stable/6.6: [faea60deaa05c76f0772650f42eafde12bd39d93]
stable/7.1: [45ebb934ea50b436ce49b2f159f090dab0d7fa28]

CVE-2026-63829: net: ip_gre: require CAP_NET_ADMIN in the device netns
for changelink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63829

Introduced by commit b57708a ("gre: add x-netns support") in v3.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8165f7ff57d9667d2bb477ef6af83ede7fed4ad7]
stable/6.12: [9831bc9ecb402957810c2045c663fbfe9b09e296]
stable/6.18: [1697957eb0971d420dde42862b88eb43506a1105]
stable/7.1: [47b5d3d506609b08b2e1f7c14f0b681a1953d572]

CVE-2026-63830: net: skmsg: preserve sg.copy across SG transforms

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63830

Introduced by commit d3b18ad ("tls: add bpf support to sk_msg
handling") in v4.20-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [406e8a651a7b854c41fecd5117bb282b3a6c2c6b]
stable/6.1: [9bb86d8184b37503816150c4a6ad3c17dfdbe827]
stable/6.12: [d22cc92bc41290e5783a72375e0843d9435f6001]
stable/6.18: [1acdd14c0990dd1cd4b6534f00366d2e6dfce05f]
stable/6.6: [0eb4c16c4adb262763bda870a8ed38a1a9dec7ec]
stable/7.1: [21ed9540a8e1906dfcbc1bb82ba9b4de4fa4bd6d]

CVE-2026-63831: mac802154: llsec: add skb_cow_data() before in-place crypto

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63831

Introduced by commit 4c14a2f ("mac802154: add llsec decryption
method") in v3.16-rc1.
Introduced by commit 03556e4 ("mac802154: add llsec encryption
method") in v3.16-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84a04eb5b210643bd67aab81ff805d32f62aa865]
stable/5.10: [3a2b378b3a9ca75d3518d879148d2ad25b5714a9]
stable/5.15: [7a831bcd0486788283ef35e396d4282ee01bb0d5]
stable/6.1: [ff976ef7c39199ebff33c18034636595016db9f0]
stable/6.12: [993fd674fe85d114e6a8d3963033d4fbbc2170a8]
stable/6.18: [bd968bdd568beacfdf98ec537a87527e85f1d0cf]
stable/6.6: [e28e7fd34c449028325322a3f5127b92594b7396]
stable/7.1: [86d531337ea1ba02d9f2bc830d07c683d9bfaade]

CVE-2026-63832: wifi: mt76: add wcid publish check in mt76_sta_add

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63832

According to the .vulnerable file, this bug was introduced by commit
4911e4c in v6.14-rc1.
Fixed in v7.2-rc1.
Affected function was added by e28487e ("mt76: replace sta_add/remove
ops with common sta_state function") in v5.0-rc1.
Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [20b126920a259df4d7dcae19fcfe2c57a74d6b2e]
stable/6.18: [3c499851753a24d2e148d4e9ca51764c0c51554e]
stable/7.1: [55e014aaec650ede08b693ba59c8d0443f13f11c]

CVE-2026-63833: ntfs3: reject direct userspace writes to reserved $LX* xattrs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63833

According to the .vulnerable file, this bug was introduced by commit
be71b5c in v5.15-rc1.
Fixed in v7.2-rc1.
Affected function was added by be71b5c ("fs/ntfs3: Add attrib
operations") in v5.15-rc1.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b08dccecf825cbf905f348bc6ccb497507e28e2]
stable/5.15: [e574af95234afc3c725988bbc1fdeb46b9f386a4]
stable/6.1: [2c3cd6da4a14380ef79e34bd9dff7caf46687477]
stable/6.12: [f8d420949b335a4b51d06ab276beee6b8dfdc909]
stable/6.18: [5e658b9245a52d838ef93729a7bc07de8e19deb7]
stable/6.6: [e8852ae29868e449fdb47eebc28f35fb80741a5f]
stable/7.1: [293a84fa40b3a1b3471c0545722724bc10973f76]

CVE-2026-63834: batman-adv: tp_meter: restrict number of unacked list entries

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63834

Introduced by commit 33a3bb4 ("batman-adv: throughput meter
implementation") in v4.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7c775110e1858e5a7471a23a9c9658c0af9df89]
stable/5.10: [31a88792bfba142be3c9521538c1db805677381f]
stable/5.15: [1111a3381bca2d1f084a07686bc783af5ab23df7]
stable/6.1: [1c616b0be4bd8399d485e25e91859373b95d6013]
stable/6.12: [c6231d628d06d841bc1617b2f7034f5f39876b16]
stable/6.18: [2233787658db859f0a9b83cb397cf783bb8be865]
stable/6.6: [f8c499fd275e59203b77fca76ae6ef2d096c2133]
stable/7.1: [1fb8762600a393d1caccd63be5d07e1756982d68]

CVE-2026-63835: batman-adv: v: prevent OGM aggregation on disabled hardif

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63835

Introduced by commit f89255a ("batman-adv: BATMAN_V: introduce per
hard-iface OGMv2 queues") in v5.4-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d11c00b95b2a3b3934007fc003dccc6fdcc061ad]
stable/5.10: [d462ced79dd430200cf888984e8005da77fc810b]
stable/5.15: [f79deaaf822ab0ee2424cf28781f9ab91576bea3]
stable/6.1: [d3569327fc7395b2b0461a0a0cb77a0bb74786c0]
stable/6.12: [f04dde74399431fb07abbdd9cd5d0ed624771d04]
stable/6.18: [3d4548c96d6f21ac1a9b06c5f82f3ef439c87023]
stable/6.6: [97644fdaaf6446ffbe182c5eb804fceb5b1a51b7]
stable/7.1: [86ab6b6fb5b82163bf6c45780bb72150021d7349]

CVE-2026-63836: batman-adv: tp_meter: avoid divide-by-zero for dec_cwnd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63836

Introduced by commit 33a3bb4 ("batman-adv: throughput meter
implementation") in v4.8-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33ccd52f3cc9ed46ce395199f89aa3234dc83314]
stable/5.10: [35264c4d46067d6312871488c810cef387f8c1f6]
stable/5.15: [1381b021bf886b793fa5ffb895a8efae7ba0318f]
stable/6.1: [d08b69da40a101df1e28bfe1e8fa7a09ffa41107]
stable/6.12: [ac229c86e49fdb96d91f51bc2fa37a9c4f58c44f]
stable/6.18: [7d2a44bc6bbe39aed03c68864aa0e54e04a50278]
stable/6.6: [cd74176cf1685f35a2e5f212d15748bbfecb53b6]
stable/7.1: [585616dab0aa9c45bc11b2c8082ca78533bc00e9]

CVE-2026-63837: net: ena: PHC: Check return code before setting timestamp output

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63837

Introduced by commit e0ea341 ("net: ena: Add PHC support in the ENA
driver") in v6.17-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24a08d7d6218d60c033015cf4870b6096446e734]
stable/6.18: [bddf59818ae5102e6d82a4dae5add6df8da38fb0]

CVE-2026-63838: ASoC: rsnd: Fix potential out-of-bounds access of
component_dais[]

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63838

Introduced by commit 547b02f ("ASoC: rsnd: enable multi Component
support for Audio Graph Card/Card2") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9e437cddf6cf9e603bdaefe148c1f4792aaf39c]
stable/6.12: [15e7b2ac2455995a6af02b9d3da7a432837aaf72]
stable/6.18: [134c61925e9e9ee0f4fdbab5c3984d5bb024f5f5]
stable/6.6: [9f1daac27ca28e98c8c0e4450de42bb68d547250]

CVE-2026-63839: platform/x86: lenovo-wmi-helpers: Fix memory leak in
lwmi_dev_evaluate_int()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63839

Introduced by commit e521d16 ("platform/x86: Add lenovo-wmi-helpers")
in v6.17-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c3887a134f191723b53e2a47e501b534c8723ee]

CVE-2026-63840: drm/amdgpu/jpeg: set no_user_fence for JPEG v5.3.0 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63840

Introduced by commit 4aeaf3c ("drm/amdgpu/jpeg: Add jpeg 5.3.0
support") in v7.0-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b0ea2021351b6b813b34fac940957f1f4fad85b]

CVE-2026-63841: drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.1 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63841

Introduced by commit b8f57b6 ("drm/amdgpu: Add JPEG5_0_1 support") in v6.14-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f8e3da71a1b469b6e157aa3972f1448b3157840]
stable/6.18: [d0f6ae14c0452be4fc3aa5cf81c74e68b3243050]

CVE-2026-63842: drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.0 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63842

Introduced by commit dfad65c ("drm/amdgpu: Add JPEG5 support") in v6.9-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea7c61c5f895e8f9ea0ffffa180498ef9c740152]
stable/6.12: [3a55ff19a6ff5e046d6a4a18e36deec5d95d9a2e]
stable/6.18: [a7e63bb93a7fde3c8920984c3deee9acfe461562]

CVE-2026-63843: drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.5 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63843

Introduced by commit 8f98a71 ("drm/amdgpu/jpeg: add jpeg support for
VCN4_0_5") in v6.7-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b65b7f3f3c18f797f81a2af7c97e2079900ad6db]
stable/6.12: [424510b60d4698a75a6ff71acdd88b528f0f39af]
stable/6.18: [f26e3f7186cd6ecc93e6af102744d64c798dea7e]

CVE-2026-63844: drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.3 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63844

Introduced by commit e684e65 ("drm/amdgpu/jpeg: add jpeg support for
VCN4_0_3") in v6.5-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83e37c0987ca92f9e87789b46dd311dcf5a4a6c8]
stable/6.12: [d6bd2a5fd611ec9c8a2411f084cff2435c709608]
stable/6.18: [8549b3933038e68dc61cb934b9a54223dd244a78]
stable/6.6: [b884ff67d62ef514eee9d5f605c03101c8b6bc98]

CVE-2026-63845: drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63845

Introduced by commit b13111d ("drm/amdgpu/jpeg: add jpeg support for
VCN4_0_0") in v5.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7e90b5839aeb8805ec83bb4da610b8dab8e184d]
stable/6.12: [a676f16ea9a7df96d69f405afb6eb349571b3382]
stable/6.18: [6876d05b899102f4dfdb9ad560132126144c1c72]
stable/6.6: [d4e0172a1b614373385e9b7111b580f8d2e0b98f]

CVE-2026-63846: drm/amdgpu/jpeg: set no_user_fence for JPEG v3.0 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63846

Introduced by commit dfd57db ("drm/amdgpu: add JPEG3.0 support for
Sienna_Cichlid") in v5.9-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2baf12eec41f246689e6a3f8619af1200031576]
stable/6.12: [303da8279f195cc741adc52c1b44d6b64de63bb0]
stable/6.18: [5ada37d7f736f9feeaa06a25e470a4c74e67a61a]
stable/6.6: [ee035a9d3eed3a9f5a3e83c31a10b321c9598861]

CVE-2026-63847: drm/amdgpu/jpeg: set no_user_fence for JPEG v2.5 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63847

Introduced by commit 14f43e8 ("drm/amdgpu: move JPEG2.5 out from
VCN2.5") in v5.6-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79405e774ede411c6b47ed41c651e40b92de64a2]
stable/6.12: [4d96e3cbfc66e4d66ea0096bde858e28ab62da00]
stable/6.18: [3a96fee676fc0caf08f03ad915bec6fcd144d551]
stable/6.6: [63691e396105611173072ad548fc2b68831ecf23]

CVE-2026-63848: drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63848

Introduced by commit 6ac2724 ("drm/amdgpu: add JPEG v2.0 function
supports") in v5.6-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5f612dc91650561fe2b5b76dd6d2898ec9ad480]
stable/6.12: [2e216c2ff159b2eb1da6e9c716d727efc73c64b5]
stable/6.18: [b41248d1c18384835f6532e68592ee07605da283]
stable/6.6: [f675801889b265634aefd30aa4503fc2b9e6ce1c]

CVE-2026-63849: drm/amdgpu/vcn: set no_user_fence for VCN v5.0.1 enc ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63849

Introduced by commit 346492f ("drm/amdgpu: Add VCN_5_0_1 support") in v6.14-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f4954722eab88e10c4ea0c0d3b1269c31421d3a]
stable/6.18: [081ef0e46c9cdd26c0db0ef721470393d36b6655]

CVE-2026-63850: drm/amdgpu/vcn: set no_user_fence for VCN v5.0.0 enc ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63850

Introduced by commit b6d1a06 ("drm/amdgpu: add VCN_5_0_0 IP block
support") in v6.9-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cae0ce77de492d7c31c1532a2e80c0c6e7e58cb]
stable/6.12: [9f5a1459ecc3195282be617639d710b54779c9dc]
stable/6.18: [139a8a52ef4349c62129703b3a3e3a6ae4d634eb]

CVE-2026-63851: drm/amdgpu/vcn: set no_user_fence for VCN v4.0.5 enc ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63851

Introduced by commit 547aad3 ("drm/amdgpu: add VCN4 ip block support")
in v6.7-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [589a254bf3e88204c8402b9cbccd5e23a0af990f]
stable/6.12: [75091030f07b7957cc0646cd52e2d9d15f611483]
stable/6.18: [6d9a98c5ed65ba92a09e4ca5a5f6941448145529]

CVE-2026-63852: drm/amdgpu/vcn: set no_user_fence for VCN v4.0.3 enc ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63852

Introduced by commit b889ef4 ("drm/amdgpu/vcn: add vcn support for
VCN4_0_3") in v6.5-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4532b52b34e4e4310386e6fdf6a643368599f522]
stable/6.12: [387b7c7667bd5c53549350ddad866d2fcf75a529]
stable/6.18: [9076a83e5adefd10dc5c967c7b8bde601c4c512a]
stable/6.6: [c12a5d35033c0640c57c10d7111c010c7b9c2c8e]

CVE-2026-63853: drm/amdgpu/vcn: set no_user_fence for VCN v4.0 enc ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63853

Introduced by commit 8da1170 ("drm/amdgpu: add VCN4 ip block support")
in v5.19-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [51f694221047c84fa185be98210eb2c354ffb8c6]
stable/6.18: [1286b6872de0aee1feeeaa6dbac86369806de9a5]

CVE-2026-63854: drm/amdgpu/vcn: set no_user_fence for VCN v3.0 enc/dec rings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63854

Introduced by commit cf14826 ("drm/amdgpu: add VCN3.0 support for
Sienna_Cichlid") in v5.9-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1e5a6660d7cbf006079126d9babbf0ccf538c6b]
stable/6.12: [26c4f38529ac78930c9c4713e16ebc5b689bb0a3]
stable/6.18: [2d6525e7b2504f5bbfe9417cddc1e8da858791dd]
stable/6.6: [e74fc9c72c1ba78d0de0b849f5929c3b39a8e20c]

CVE-2026-63855: drm/amdgpu/vcn: set no_user_fence for VCN v2.5 enc/dec rings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63855

Introduced by commit 28c17d7 ("drm/amdgpu: add VCN2.5 basic supports")
in v5.4-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4f317863a3ab212a027d8c8c3cc3af4e3fb95704]
stable/6.12: [8f0ea4524dc71c6c9ec97f2711f46e12f624140f]
stable/6.18: [602d4c5872b25ddd4d82fb2025efb9a05b187bb3]
stable/6.6: [2c6fb056567efb49f8674108b86088a1cfaa86d0]

CVE-2026-63856: drm/amdgpu/vcn: set no_user_fence for VCN v2.0 enc/dec rings

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63856

Introduced by commit 1b61de4 ("drm/amdgpu: add initial VCN2.0 support
(v2)") in v5.3-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d80b293b41fcb5e9396db93e788b0f4ebcbafb7]
stable/6.12: [5e777bc4cbe928ac0fd95e368fee1540f2ce4db2]
stable/6.18: [ac06ce5cac9e711281585d09d00c6efcd9b86396]
stable/6.6: [f264019be80de79f84f464846451445923bffea0]

CVE-2026-63857: net: airoha: Do not read uninitialized fragment
address in airoha_dev_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63857

Introduced by commit 23020f0 ("net: airoha: Introduce ethernet support
for EN7581 SoC") in v6.11-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bde34e84edc8b5571fbde7e941e175a4293ee1eb]
stable/6.18: [f670fa4b19ceddc6d215dda4997888ccba9bbc61]

CVE-2026-63858: netfilter: nf_tables: add hook transactions for device deletions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63858

Introduced by commit 7d937b1 ("netfilter: nf_tables: support for
deleting devices in an existing netdev chain") in v6.4-rc1.
Introduced by commit b6d9014 ("netfilter: nf_tables: delete flowtable
hooks via transaction list") in v5.19-rc2.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10f79dbd7719d1da9f5884d13060322d8729f091]

CVE-2026-63859: net: airoha: Add missing bits in airoha_qdma_cleanup_tx_queue()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63859

Introduced by commit 23020f0 ("net: airoha: Introduce ethernet support
for EN7581 SoC") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3309965fe44c00fd65af7cef5016e9e782c021a7]
stable/6.18: [c0cfce4d76702dba9601a4020df1a0bc35806efc]

CVE-2026-63860: RDMA/core: Prefer NLA_NUL_STRING

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63860

Introduced by commit 30dc5e6 ("RDMA/core: Add support for iWARP Port
Mapper user space service") in v3.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ac4901d4b1fdf4a50be6ccc0b944f1f926801abf]
cip/4.4-st: [fc4d1cdacd1fe6fa049bf0e88ecc69b973019874]
mainline: [6ed3d14fc45d3da6025e7fe4a6a09066856698e2]
stable/5.10: [fcd07d3b8ee7a39b344d73aed69c1a68cd9eacdf]
stable/5.15: [87111356d58d86edb221ba144d261ed83a5b8bbe]
stable/6.1: [abda65bdd13084c771842adaac1f652d0660dd82]
stable/6.12: [5877c043398d5fa0e93919a3d837e5cd7a98a961]
stable/6.18: [f2c7b39dde2e61df8157066969cc2a408cd3dcd9]
stable/6.6: [137b5918931d4d05aa8ea8d3adf67f7224eef63c]

CVE-2026-63861: spi: mtk-snfi: unregister ECC engine on probe failure
and remove() callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63861

Introduced by commit 764f1b7 ("spi: add driver for MTK SPI NAND Flash
Interface") in v5.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab00febad191d7a4400aa1c3468279fb508258d4]
stable/6.1: [6aea4a99410615912d80a4ba0827c4e8d4a8312d]
stable/6.12: [86357e1d0157d8408b78f8768a69ab263d010316]
stable/6.18: [e0b049bd7b279d7b6ad22a637cddced93198a51b]
stable/6.6: [3e79a563377a319d016ed0d3cd8c43171670c0f3]

CVE-2026-63862: PCI: mediatek-gen3: Prevent leaking IRQ domains when
IRQ not found

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63862

Introduced by commit 814ccee ("PCI: mediatek-gen3: Add INTx support")
in v5.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5573c44cb3fd01a9f62d569ae9ac870ef5f0e0ba]
stable/6.1: [abd3c1927d33766aef39c4640880e3d2637429c2]
stable/6.12: [946b31b5a699a2760ee52af0055e5ebf29c5f4cb]
stable/6.18: [0a2d60edc3e57c9512e239ebdfd12204d3368560]
stable/6.6: [07a5ecb94768cbf76fe659e9924000e9ced0c8a6]

CVE-2026-63863: drm/gpusvm: Fix unbalanced unlock in drm_gpusvm_scan_mm()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63863

Introduced by commit f1d08a5 ("drm/gpusvm: Introduce a function to
scan the current migration state") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d287dee565c3c32e1ed76ec1847af46809c29b90]

CVE-2026-63864: bpf: Propagate error from visit_tailcall_insn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63864

Introduced by commit e40f5a6 ("bpf: correct stack liveness for tail
calls") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bd96e40f31dde8f8cd79772b4df0f171cf8a915]

CVE-2026-63865: bpf: Drop task_to_inode and inet_conn_established from
lsm sleepable hooks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63865

Introduced by commit 423f161 ("bpf: Augment the set of sleepable LSM
hooks") in v5.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beaf0e96b1da74549a6cabd040f9667d83b2e97e]
stable/5.15: [452a927cddcd67478d030e646f41cb904a93156f]
stable/6.1: [f0fc2a9828171205244a28013f02889f50b71c9f]
stable/6.12: [0d918263c9bfc86078edb2e2f7302a0c6ce42b7c]
stable/6.18: [281f2a214565a5cbf8b7355a65738d80bd19b8c5]
stable/6.6: [26b380a3ca0b605fd8860995ed6a208f276dd316]

CVE-2026-63866: wifi: mt76: mt7996: Clear wcid pointer in
mt7996_mac_sta_deinit_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63866

Introduced by commit dd82a9e ("wifi: mt76: mt7996: Rely on
mt7996_sta_link in sta_add/sta_remove callbacks") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [88973240dc7c976dd320b36a9e6d925c9be083ae]
stable/6.18: [455a48685feebf2d9c1656caad77f9ba1da7b06e]

CVE-2026-63867: mptcp: close TOCTOU race while computing rcv_wnd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63867

Introduced by commit fa3fe2b ("mptcp: track window announced to peer")
in v5.11-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ab24fdebc369c0dfb90f82c1650b1e66662bb45]
stable/5.15: [301a33fd590c408a05c5df800e0cc1e6a8a2f8f8]
stable/6.1: [68364963e5baf03f16b4420292291f75c8f66497]
stable/6.12: [c4f4cf60797974873dbc8e100144682a6f2f861f]
stable/6.18: [3b8cbba7c0ed31189c89f90be247b8973ffa79ef]
stable/6.6: [907ac6b1658e0277f979fcdfae2a753b495c1510]

CVE-2026-63868: net: garp: fix unsigned integer underflow in garp_pdu_parse_attr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63868

Introduced by commit eca9eba ("net: Add GARP applicant-only
participant") in v2.6.27-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [16e408e607a94b646fb14a2a98422c6877ae4b3c]
stable/5.10: [29f28172afb2ae7b31e9bf3e978396f20b381688]
stable/5.15: [973cf7c433d27f4d9556d0b7c332543be7ed7a6e]
stable/6.1: [d8dcd14aa886b8effd83022c550669f4f262854b]
stable/6.12: [d4c86ea09ae3e63ee5aa86e941fcc38e0e39874a]
stable/6.18: [04e22fefac1af3e32f245e9045382348773b5d59]
stable/6.6: [74e02121be1dcc0efcd56ebdf0171d6129105659]

CVE-2026-63869: wifi: mac80211: limit injected antenna index in
ieee80211_parse_tx_radiotap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63869

Introduced by commit ef246a1 ("wifi: mac80211: support antenna control
in injection") in v6.7-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c0cf89f36ac0c0fd8687a4ccdce2efb23a9c663]
stable/6.12: [f6d3dc8e8492bf8435e0b23c99472af7bafd6b44]
stable/6.18: [9b40c59bab08f2a99abf969cc0bb92fa49de004b]

CVE-2026-63870: ieee802154: 6lowpan: only accept IPv6 packets in lowpan_xmit()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63870

Introduced by commit 4dc315e ("ieee802154: 6lowpan: move transmit
functionality") in v4.0-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3a5f3f7aff18bcc36a57839cf50cf0cc8de707f3]
stable/5.10: [af07fffbd53ddc3ec3c2a4ca914f27899fa89bca]
stable/5.15: [3150e6d3223dfc356308125cabf9c34169842d2a]
stable/6.1: [8da95cb6ad7d656c871e776a9c7b77e894d6d89c]
stable/6.12: [c1819c8defa235c7beda859bc185b1c429a55ecd]
stable/6.18: [285b0842f2e01c3edf805f1fd64da11d9b7f6b4c]
stable/6.6: [1a827b95e62b4cbe851ae7cc9c961cdfa769cca4]

CVE-2026-63871: Bluetooth: ISO: Fix data-race on iso_pi fields in
hci_get_route calls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63871

Introduced by commit 241f519 ("Bluetooth: ISO: Avoid circular locking
dependency") in v6.2-rc1.
Fixed in v7.1-rc7.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [9ca7053d6215d89c33f28893bfd1625a32919d3f]
stable/6.12: [9798f7d41d85ff763afd1f1cc0533b5c416c8348]
stable/6.18: [ab84fd7779a2a7ff5d2c8eac212c43733f56216e]

CVE-2026-63872: esp: fix page frag reference leak on skb_to_sgvec failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63872

Introduced by commit cac2661 ("esp4: Avoid skb_cow_data whenever
possible") in v4.11-rc1.
Introduced by commit 03e2a30 ("esp6: Avoid skb_cow_data whenever
possible") in v4.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2982e599fff6faa21c8df147d96fc7af6c1a2f24]

CVE-2026-63873: accel/amdxdna: Fix mm_struct reference leak in
aie2_populate_range()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63873

Introduced by commit e486147 ("accel/amdxdna: Add BO import and
export") in v6.16-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f41af638c92bac6f1f9275ea2d1901baef578f3]
stable/6.18: [e83fc4c28226be75fbc0c41f2846935ba2b5f949]

CVE-2026-63874: net: mctp: usb: fix race between urb completion and
rx_retry cancellation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63874

Introduced by commit 0791c03 ("net: mctp: Add MCTP USB transport
driver") in v6.15-rc1.
Fixed in v7.1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [54665dce982689e2fd99b32e9a0dcc204fda8a51]
stable/6.18: [9c46f3ee1837f6881cb99a52ffecb2760f11dc73]

CVE-2026-63875: arm64: tlb: Flush walk cache when unsharing PMD tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63875

Introduced by commit 8ce720d ("mm/hugetlb: fix excessive IPI
broadcasts when unsharing PMD tables using mmu_gather") in v6.19-rc7.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [c2ff4764e03e7a8d758352f4aceb8fe1be6ac971]
stable/5.10: [dced308d7d6a0de1c09d2058f38f1aaaf5cbb914]
stable/5.15: [47490bbb05c8c0e09cc3cfd237d8934ffc340583]
stable/6.1: [0199c9d57861f17b556b6cba1f765c7cce79745b]
stable/6.12: [8ca7284da0e67b3e71d90ec17f08286774245ad9]
stable/6.18: [fe93e907b1af03cc229a80aa64a570a103d2b279]
stable/6.6: [d766a49d9b55705c4737cd8bb5d3faa2d31330fd]

CVE-2026-63876: serial: zs: Convert to use a platform device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63876

Introduced by commit 84a9582 ("serial: core: Start managing serial
controllers to enable runtime PM") in v6.5-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7cac59d08a73cb866ec51a483a6f3fe0f531947c]
stable/6.12: [6a83d5e24a84e746425cd93539130e5f7381ef47]
stable/6.18: [237dc8c08de3cb293b6607aaee8b13b3a671e267]
stable/6.6: [bb2040484f90f91b717060e1a66026cc4287bcf0]

CVE-2026-63877: serial: dz: Convert to use a platform device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63877

Introduced by commit 84a9582 ("serial: core: Start managing serial
controllers to enable runtime PM") in v6.5-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d7a49d60b8fda66da60e240fd7315232fa1754f]
stable/6.12: [6f59646229490a93cda950017ad4bdfbfe770a1d]
stable/6.18: [2ff0401ffddaccc85f758c8259912d686d052b31]
stable/6.6: [c9e78361fe92fb64662fc3c8f34e2cdbb8c25bc6]

CVE-2026-63878: drm/amdgpu: check num_entries in GEM_OP GET_MAPPING_INFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63878

Introduced by commit 4d82724 ("drm/amdgpu: Add mapping info option for
GEM_OP ioctl") in v6.18-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a1ba4594232c87c3b8defd6f89a2e40f8b08395d]
stable/6.18: [f059b4c493df3e54fe3ffe4658009c31864275da]

CVE-2026-63879: drm/amdgpu: fix amdgpu_hmm_range_get_pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63879

According to the .vulnerable file, this bug was introduced by commit
c1420a5 in v6.2-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [962d684b5dc0741dcd93485d41b450de402d5592]

CVE-2026-63880: drm/amdgpu: fix lock leak on ENOMEM in
AMDGPU_GEM_OP_GET_MAPPING_INFO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63880

Introduced by commit 4d82724 ("drm/amdgpu: Add mapping info option for
GEM_OP ioctl") in v6.18-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2e7f55eb408c3f72ee1957a0d0ad11d8648a6379]
stable/6.18: [1eb86334e391695d4a40743b114afc15df4dc506]

CVE-2026-63881: drm/amdkfd: fix a vulnerability of integer overflow in
kfd debugger

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63881

According to the .vulnerable file, this bug was introduced by commit
a70a93f in v6.5-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93f5534b35a05ef8a0109c1eefa800062fee810a]
stable/6.12: [de70a80992396ee306ee3a2810ad28aa1608ba9b]
stable/6.18: [5cf4a41aa0d74e4c83f82d2ce233b5189ed4b43c]
stable/6.6: [4e5f808b454167cc58d7084a407a554d8ddc694d]

CVE-2026-63882: drm/amdkfd: fix NULL pointer bug in svm_range_set_attr

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63882

According to the .vulnerable file, this bug was introduced by commit
42de677 in v5.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e984d61d92e702096058f0f828f4b2b8563b88ce]
stable/6.1: [e4dcb5d6360319609bc5b05fb40e98b0af6bc674]
stable/6.12: [d4e73a047d4ea866b75ee4b879d0d787dfa2704c]
stable/6.18: [2f9c3c161692f5bf1436e869a651bed10936e071]
stable/6.6: [6495cc09f7e6c2af571b3e2e4640283b3792ebf2]

CVE-2026-63883: serial: qcom_geni: fix kfifo underflow when flush
precedes DMA completion IRQ

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63883

Introduced by commit 2aaa43c ("tty: serial: qcom-geni-serial: add
support for serial engine DMA") in v6.3-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [452d6fa37ae9b021f4f6d397dbae077f7296f6f4]
stable/6.12: [b1159dce10b38eb795e4c96cdc4d34b83cec81c5]
stable/6.18: [654f45a8569f3cd6ff20bd724a18e0cce65893ba]
stable/6.6: [c91ea13375f70f6271a0183445e34e83b8f4d8f7]

CVE-2026-63884: drm/i915: Fix potential UAF in TTM object purge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63884

Introduced by commit 7ae0345 ("drm/i915/ttm: add tt shmem backend") in
v5.17-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c4063c87a619e4df954c179d24628636f5db15f]
stable/6.1: [df73f3bc731af1c39ac5405bc59c4e7c6f8e9117]
stable/6.12: [073bcbc95e9648c976da1654c7590a8d6ee12c2d]
stable/6.18: [c9ae7e7e3bc98615364313b08d7acea5239ded0b]
stable/6.6: [28b22dbaf407598cb3bb1d2c586a6f8018690ac2]

CVE-2026-63885: drm/gem: fix race between change_handle and handle_delete

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63885

Introduced by commit 5e28b7b ("drm: Set old handle to NULL before
prime swap in change_handle") in v7.1-rc3.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [7164d78559b0ff29931a366a840a9e5dd53d4b7c]
stable/6.18: [0dfa42cfe4dbe114533480503934f43e33c1e83d]

CVE-2026-63886: scsi: target: iscsi: Validate CHAP_R length before base64 decode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63886

Introduced by commit 1e57338 ("scsi: target: iscsi: Support base64 in
CHAP") in v6.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85db7391310b1304d2dc8ae3b0b12105a9567147]
stable/6.1: [82454e6f21e56ea9a0a9de7d0ff7e1dfb83e34d6]
stable/6.12: [bf154c657828ed05399bca5d98cf1611bb048b12]
stable/6.18: [4a3a19c98a8207ad08bec554703d90f2c34a8cc6]
stable/6.6: [edd06675a02376ea8347dba7c29ad982ba5b36ee]

CVE-2026-63887: scsi: target: iscsi: Bound iscsi_encode_text_output()
appends to rsp_buf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63887

Introduced by commit e48354c ("iscsi-target: Add iSCSI fabric support
for target v4.1") in v3.1-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf33e01f88388c43e285492a63e539df6ffed64c]
stable/5.10: [cb84e974fb172bc71386289f37b78ea679410b39]
stable/5.15: [b19382dfc6e7dee6d3859ba44b6ca29e97a51627]
stable/6.1: [efe633e600a0ac68357206fede21b1ac8178f3b8]
stable/6.12: [30bf335e8fe170322080ee001f05ca29c50680b3]
stable/6.18: [594a40360012ce5f94c715d5e3b20fa3af7d525a]
stable/6.6: [4e9f0c4a645c995bc75c06c7b3644254ffb4c76b]

CVE-2026-63888: scsi: target: iscsi: Fix CRC overread and double-free
in iscsit_handle_text_cmd()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63888

Introduced by commit e48354c ("iscsi-target: Add iSCSI fabric support
for target v4.1") in v3.1-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [778c2ab142c625a8a8afa570e0f9b7873f445d99]
stable/5.10: [f7948af0dd03de84079dcd4dc215a69fd6fbb95d]
stable/5.15: [badf178b76b0690851df00f4ca9cf2eb8eb0f963]
stable/6.1: [6e22a1cdcc8277af4acc43710577157b77a02c5d]
stable/6.12: [ec9f19d52074a191ed1756ed4a7d39fff1a2085c]
stable/6.18: [89c81d1228c00fa6dd91de6c1c5aa1ef8a7875e3]
stable/6.6: [d3e9b79aa794f7a23e82de4d710e7d2df610e349]

CVE-2026-63889: scsi: scsi_transport_fc: Widen FPIN pname walker counter to u32

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63889

Introduced by commit 3dcfe0d ("scsi: fc: Parse FPIN packets and update
statistics") in v5.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9a39233ec1fc9f97ea1340a4d09bb7ec2be5153]
stable/5.15: [07776b7779c9426982c1ad74aad91bd531593790]
stable/6.1: [29f126f09e34a425b376b3646c89aa7cc18b142c]
stable/6.12: [ee57b89e5da9fffbe0d26647e4ff0750dacb9943]
stable/6.18: [35461d23744175a78b6280293892cca357c22793]
stable/6.6: [163bd704d7515c3df6c2e03bcba93d1db79edbff]

CVE-2026-63890: scsi: fcoe: Reject FIP descriptors with zero fip_dlen
in CVL walker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63890

Introduced by commit 97c8389 ("[SCSI] fcoe, libfcoe: Add support for
FIP. FCoE discovery and keep-alive.") in v2.6.30-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9eed1bd59937e6828b00d2f2dfef631d964f3636]
stable/5.10: [d179949d2175d2857d1c3a275a22bea58bcc5d36]
stable/5.15: [fda976f7390bb5d1e9b84ef11ebb17323038e0c6]
stable/6.1: [80a0cd307205236ca28aa49bc553f58edcb9bf3a]
stable/6.12: [549859a1131052b07dff11a448e9f3221a40f260]
stable/6.18: [14dd80a20a72ce334adcc2d67402360527065948]
stable/6.6: [0e3c6e5a8fc15a74dfb1e0c1df9f1da73600a81a]

CVE-2026-63891: thunderbolt: property: Cap recursion depth in
__tb_property_parse_dir()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63891

Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [928abe19fbf0127003abcb1ea69cabc1c897d0ab]
stable/5.10: [2b5f47a710172c962ef42d1b732b04d2ad0dce21]
stable/5.15: [95839a67ea56ca35732aad7f711404a3127cfe2d]
stable/6.1: [0a84ab9271936c11e84e511bb52fc5682f8b6726]
stable/6.12: [f31c6d220f455b5af63590302b30e1b932d14599]
stable/6.18: [830c8a9b467e7d3a158483d37fa7dc13892b293a]
stable/6.6: [b4621e5ef63405c317a84b711faf3bd75b3c6a94]

CVE-2026-63892: thunderbolt: property: Reject dir_len < 4 to prevent
size_t underflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63892

Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [de21b59c29e31c5108ddc04210631bbfab81b997]
stable/5.10: [37abc4504fa19d8f9f1e87792e8a2b8fdb308e40]
stable/5.15: [e2d4d51cf5785815fa4e91e0c019e3eb2506a84c]
stable/6.1: [de618299190b418291609e6921557253bd417e25]
stable/6.12: [542a13890b742099c461d70920e97b14e568f6ec]
stable/6.18: [d548179adcc87e1bc66b17e00352a1f536e76065]
stable/6.6: [5506c825f14d810f0690b1f4367cb7249ebb387a]

CVE-2026-63893: thunderbolt: property: Reject u32 wrap in
tb_property_entry_valid()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63893

Introduced by commit cdae7c0 ("thunderbolt: Add support for XDomain
properties") in v4.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01deda0152066c6c955f0619114ea6afa070aaec]
stable/5.10: [6a63623621639acbb39bc2d9fb09559681716695]
stable/5.15: [e8a0b0a93a6ef958e70b1dd4930beb6dc0026b36]
stable/6.1: [9fee50c4e1e42f6d3cbe30df584f9f648f626071]
stable/6.12: [5c06a3043ad944f087bb2ae0aae28d820bb9f460]
stable/6.18: [31b98e503ecca8077e5247253dd5425ab84bc96d]
stable/6.6: [8d4a758b407ab3de3be86d1ceadfa35d717d30c7]

CVE-2026-63894: usb: gadget: f_fs: serialize DMABUF cancel against
request completion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63894

Introduced by commit 7b07a2a ("usb: gadget: functionfs: Add DMABUF
import interface") in v6.9-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2796646f6d892c1eb6818c7ca41fdfa12568e8d1]
stable/6.12: [c872d8a065b3b499ce4c3ad168b5d34b68524f66]
stable/6.18: [c7d421123b98d5e9c1c84bd9957aba36f1cbb4ca]

CVE-2026-63895: usb: gadget: f_fs: copy only received bytes on short ep0 read

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63895

Introduced by commit ddf8abd ("USB: f_fs: the FunctionFS driver") in
v2.6.35-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4e036c10e7f4df5d951c69cc3697bc8e209c6d02]
stable/5.15: [90ccf5fb63243fae1b4b3200f3310500500ecf2e]
stable/6.1: [af32dbb2ca0b3d09271ab718d13857a457fa16f2]
stable/6.12: [88874a19b2b093bfaaa1c0090fa536c44da8c08b]
stable/6.18: [607730a414773a7cbe3037a64a6c64e72689ff5e]
stable/6.6: [e835bf9a055f71874065a40780ca5560b7df8b33]

CVE-2026-63896: usb: gadget: composite: fix integer underflow in
WebUSB GET_URL handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63896

Introduced by commit 93c4739 ("usb: gadget: add WebUSB landing page
support") in v6.3-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c5dbc104dadd79fc2923497c20bae759a18758c]
stable/6.12: [f5869dfaa89854dcf34121036294d42d6c7acb8f]
stable/6.18: [f8f5a8f48c7cae3fac85e04b593bd47939f9725f]
stable/6.6: [046870ff6b6f7b743c953c061043a9b30700d491]

CVE-2026-63897: USB: serial: mct_u232: fix missing interrupt-in
transfer sanity check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63897

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [245aba83e3c288e176ed037a1f6b618b09e92ed8]
stable/5.10: [82b48d70bced1ec8e5f676d1fd5eccc7a44dc418]
stable/5.15: [8b93ee5baeef6efabee2c3381907733ad2dbc883]
stable/6.1: [a093f3e0c03d25a86d747a655d4b9322ffb2ed87]
stable/6.12: [631b8b7c456567f7a8d26f6fc354c8dd9cc9f832]
stable/6.18: [f06bcaba29707f060706483b2020d3cafbe98f9f]
stable/6.6: [70bb9a2661d34b93a9b83cf83e2b76289a712ef0]

CVE-2026-63898: USB: serial: mct_u232: fix memory corruption with small endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63898

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [915b36d701950503c4ea0f6e314b10868e59fce3]
stable/5.10: [94edbbc5fe00d03cfe1d4e690d7d2cd36317a935]
stable/5.15: [bd2ddb3fe9052ad8703593bbec26ecc7ca92869e]
stable/6.1: [39e295a91e80f3b91f61c7ada2bde434dcaba20d]
stable/6.12: [6cb48f8890f9b2051d7c34823057296a536a31c5]
stable/6.18: [d8fdf33d6fcfb90cbec26299baf2352c84b2d768]
stable/6.6: [90dbad14b109e5fdfb4934ff61e561d11ba3742d]

CVE-2026-63899: USB: serial: mxuport: fix memory corruption with small endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63899

Introduced by commit ee467a1 ("USB: serial: add Moxa UPORT
12XX/14XX/16XX driver") in v3.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4085f0dbb1ce2251c9a5938d693de6593f0ab2bd]
stable/5.10: [086b858b5f5125bc9d967ea2bd825f83d9f8f29d]
stable/5.15: [2f3661eb2446e1ef593da45e01a3b21a906768ec]
stable/6.1: [ccbec56f2f9af008f1574335cc6a668f16603e47]
stable/6.12: [e906545641d34fb1a09a65b4b5cfdff40eb09681]
stable/6.18: [6c0cf56f00f280d72180bb6ce79741bc787a6269]
stable/6.6: [be3a1ed4ae51fa8dde57383277d336ce834f2cd9]

CVE-2026-63900: USB: serial: keyspan: fix missing indat transfer sanity check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63900

Introduced by commit 0ca1268 ("USB Serial Keyspan: add support for
USA-49WG & USA-28XG") in v2.6.23-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab8336a7e414f018430aa1af3a46944032f7ff96]
stable/5.10: [bd6c5fe59f374b63173afe5cf0ab38a9a370f2c1]
stable/5.15: [e124120e89b61a967e40dee6b5e1ecafc45c09d9]
stable/6.1: [41d9673941eebdde62ee73848fcfe4ae1105c979]
stable/6.12: [3759a40738b83bb61699c85f063202b514b94f77]
stable/6.18: [ea2b792330b44b6d7ce671c3e1d59d0c121f7ed1]
stable/6.6: [0bde5431037a076ff3750da2165fd77a6f5ff058]

CVE-2026-63901: USB: serial: digi_acceleport: fix memory corruption
with small endpoints

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63901

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cb3560e8eab1dfa1cac1ed52631adf8ec6ff2cd5]
stable/5.10: [fd34198c2e5d164b57a7dcd4692626fece319225]
stable/5.15: [25b93d0f229a115ab120106f37b9454170d4cfd4]
stable/6.1: [6ab1e9ae099577a1019312088309ecbad2da9a91]
stable/6.12: [41b645e791099f0038225da5e2ca3ca31f00d435]
stable/6.18: [062dcc0b324afd03b1406f157190804f105718bb]
stable/6.6: [8a65db5edd7b63365e9c5b7d9f4b8f314696dc49]

CVE-2026-63902: USB: serial: cypress_m8: validate interrupt packet headers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63902

Introduced by commit 3416eaa ("USB: cypress_m8: Packet format is
separate from characteristic size") in v2.6.26-rc1.
Introduced by commit 3416eaa ("USB: cypress_m8: Packet format is
separate from characteristic size") in v2.6.26-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9f9bfc80c67f35a275820da7e83a35dface08281]
stable/5.10: [fcef31a5a85ccf3c313449a866ec6ed7e4132425]
stable/5.15: [aaa66708bfb1dca2acd219d1c1582f9f6d5492cb]
stable/6.1: [44f9bab8df7750a1e2a4d6cc22d7c9c2dc096aed]
stable/6.12: [90664556916de22467097d4c8ceb716d597a5c32]
stable/6.18: [ae03453f2c809ca3cf73753269fa6184dea7160f]
stable/6.6: [be50533fe7068e86eb7adb81988e6d6a3f6dfe53]

CVE-2026-63903: USB: serial: belkin_sa: validate interrupt status length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63903

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ce058df2ee02cc2a0f0fd5cd64ce6f1482a0b65]
stable/5.10: [f1617539ab90e67da788959bfd314076f093a11a]
stable/5.15: [f361359a952da15e70e693c2d7dca5c5843eae3e]
stable/6.1: [37e54d1b986df35c936d81e5b59a7aa3ec6938f0]
stable/6.12: [6a4602221cba7a738442328d66a2f0b1c9bf6e17]
stable/6.18: [22823a319fb2afdf02cacafbed8b613b757efbc8]
stable/6.6: [ffb739a49186ea784bbd9cb91b647f062395b419]

CVE-2026-63904: usb: usbtmc: check URB actual_length for interrupt-IN
notifications

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63904

Introduced by commit dbf3e7f ("Implement an ioctl to support the
USMTMC-USB488 READ_STATUS_BYTE operation.") in v4.6-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [52f2ad3f7e5eb3b5908e1d685d4342519dc9cfcd]
stable/5.10: [e794bd67b3faf98af46f958897f6b91412c7d2a9]
stable/5.15: [e3eec3005de44e7f37d8d7724be636446516ab42]
stable/6.1: [ae87f505917e703ae3b487d9663d78826ff43608]
stable/6.12: [69020fa089f1bf0e1a10a15265f31b143a846409]
stable/6.18: [75f6d3da2cc646983f41807ef98851569c12bca9]
stable/6.6: [5de7df75ef3a2756b25fe3d582a4a2970444fe5a]

CVE-2026-63905: usbip: vudc: Fix use after free bug in vudc_remove due
to race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63905

Introduced by commit b6a0ca1 ("usbip: vudc: Add UDC specific ops") in v4.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d96209626a29ea64666be98c30b30ac82e5f1be6]
stable/5.10: [61704e5cf9cd7464b510eb606e7e2978b1160a64]
stable/5.15: [dcc1c90b28b28b7c493547506297e78653f81952]
stable/6.1: [1036ac6148995feaf486014d32bf26bf993c06a9]
stable/6.12: [d07ed707467ce05ea9c03412d0c5ee9d0fe386a6]
stable/6.18: [88d459e5b5a46da1ef9fd6f52d9439343edeec88]
stable/6.6: [a0638db2340ee053ab0450656a763fd111475e54]

CVE-2026-63906: usb: musb: omap2430: Fix use-after-free in omap2430_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63906

Introduced by commit ffbe2fe ("usb: musb: omap2430: Fix probe
regression for missing resources") in v6.2-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1

Fixed status
mainline: [e194ce048f5a6c549b3a23a8c568c6470f40f772]
stable/6.1: [632fd888fe33083927e29ef651ac1aba345edd9e]
stable/6.12: [27e62532228dc42367bb43ebbcd7bf49d8db2b0d]
stable/6.18: [69f9f2b30af03d9b6e83f78fb0f734b6066d4678]
stable/6.6: [b987f380620b38c84f054d5ff5c05861a7c2203b]

CVE-2026-63907: uio: uio_pci_generic_sva: fix double free of
devm_kzalloc() memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63907

Introduced by commit 3397c3c ("uio: Add SVA support for PCI devices
via uio_pci_generic_sva.c") in v6.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f74c8696f14149d5e43cc28b015326a759c48f00]

CVE-2026-63908: Input: atmel_mxt_ts - fix boundary check in mxt_prepare_cfg_mem

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63908

Introduced by commit 50a77c6 ("Input: atmel_mxt_ts - download device
config using firmware loader") in v3.17-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [baa0210fb6a9dc3882509a9411b6d284d88fe30e]
stable/5.10: [862a1a32b5190241fce7a7d20229539a3926f31e]
stable/5.15: [5c3681c3abc35cfac6b702251382312c60d96bc2]
stable/6.1: [1017e1c6c6c49cccbcda9bbcfa49e50b0b6dad39]
stable/6.12: [ae92e334544263a02d9f99e18385e718c44392c9]
stable/6.18: [7f95f4792c0dc767fcb8e405391e779ab419d55a]
stable/6.6: [e9b62996ba537774f68fecfd7eecb5aec1713952]

CVE-2026-63909: ksmbd: OOB read regression in smb_check_perm_dacl()
ACE-walk loops

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63909

Introduced by commit d07b26f ("ksmbd: require minimum ACE size in
smb_check_perm_dacl()") in v7.1-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [0e60dafe97eca61721f3db456f97d97a80c6c8ae]
stable/5.15: [5500ba1d410aed1eded3eb04a76b10cfb4409334]
stable/6.1: [f6324b4240cf0b26a84c33f68a1222d727ff4af2]
stable/6.12: [d333af32e4451285e427f2d9c29de3a39f6f6d48]
stable/6.18: [94215d55b09445993929f4fc966061d61de74929]
stable/6.6: [0fe08c5776a798f46df1fd74b331be26bdd644d6]

CVE-2026-63910: dma-buf: fix UAF in dma_buf_fd() tracepoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63910

Introduced by commit 281a226 ("dma-buf: add some tracepoints to
debug.") in v7.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ead6680f354f83966c796fc7f9463a3171789616]

CVE-2026-63911: xfrm: iptfs: reset runtime state when cloning SAs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63911

Introduced by commit 0e4fbf0 ("xfrm: iptfs: add user packet (tunnel
ingress) handling") in v6.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f83d174073234839aea176f265e517e0d50a1d2]
stable/6.18: [9327252e04626d4bb02ca8c0c108fbe8eabf0c5a]

CVE-2026-63912: xfrm: esp: restore combined single-frag length gate

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63912

Introduced by commit 5bd8baa ("esp: limit skb_page_frag_refill use to
a single page") in v5.18-rc4.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
mainline: [dfa0d7b0ff1eb6b2c416b8fdb9b4f2cefba57a40]
stable/5.10: [566295735530ee513326049b0540f32ec050bf2e]
stable/5.15: [5d7ab86e2b6bc23054616bf6ac562013bf60af8c]
stable/6.1: [36519e3d941fc99d3b52c134dbaf311f987a4708]
stable/6.12: [b84091ceddc9f133229dceab3ccc930bf27f9cba]
stable/6.18: [c093468aea8277f77272a4f199b2e15e19cabb59]
stable/6.6: [322e48187e0245ab2fff6fec2220b0cae677dbec]

CVE-2026-63913: netfilter: conntrack: tcp: do not force CLOSE on
invalid-seq RST without direction check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63913

Introduced by commit 9fb9cbb ("[NETFILTER]: Add nf_conntrack
subsystem.") in v2.6.20.16.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bed6e04be8e6b9133d8b16d5a42d0e0ce674fa9a]
stable/5.10: [2006979a15af5404bf932a325357683c0bac1656]
stable/5.15: [6476c17d536dbd321c073242e762ddb2713a1238]
stable/6.1: [f5547bebc416d56f56fb5b86dc20aabfa42165a0]
stable/6.12: [f206def4e86d810f927ba1d8e322ea72b29bce58]
stable/6.18: [b98ab51c45c5608a1c19ce7fd17a3032469bb83f]
stable/6.6: [2bb6d82b586ea5a4cb73bbdd6b7432e96096bc77]

CVE-2026-63914: xfrm: route MIGRATE notifications to caller's netns

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63914

Introduced by commit 5c79de6 ("[XFRM]: User interface for handling
XFRM_MSG_MIGRATE") in v2.6.21-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e2a4f7ca0952820731ef7bdadfc9a9e9d3571b4]
stable/5.10: [bafc7d0774b9bf52909c70ed990bc5ccf7ec4bad]
stable/5.15: [6df8157547347b5257bf640a0ae3dfc4411e06cd]
stable/6.1: [fe463798343382c8fe9416a95959f005a3c30aa5]
stable/6.12: [a306cf2ac8849c487791369fad6f216399d000f6]
stable/6.18: [448bb92ca101dde8a6e88b4dc824044b4e341604]
stable/6.6: [00f2c451e57df50b1151d9b2254878f106b7c892]

CVE-2026-63915: nfc: hci: fix out-of-bounds read in HCP header parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63915

Introduced by commit 8b8d2e0 ("NFC: HCI support") in v3.5-rc1.
Introduced by commit 11f54f2 ("NFC: nci: Add HCI over NCI protocol
support") in v4.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f040e590c035bfd9553fe79ee9585caf1b14d67b]
stable/5.10: [ed6d5d97dad0334a7f43d218753429cbe2f70a4f]
stable/5.15: [b99366d74b535d0cadb1ef73e04639415d9ff3b7]
stable/6.1: [37382293f174b82a0616c8295e32b1fc8e13d1ed]
stable/6.12: [1905f5ec3641b2b234bb63549c8ca11ab85466eb]
stable/6.18: [22d41b176b9989efd21c3b2d3abf6728f05b9d9a]
stable/6.6: [c4cc6b3b0013acb3ed0b2b60e57dfae98647fe98]

CVE-2026-63916: HID: wacom: Fix OOB write in wacom_hid_set_device_mode()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63916

Introduced by commit 5ae6e89 ("HID: wacom: implement the finger part
of the HID generic handling") in v3.18-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0a8899e02ddebd51e2589835182c239c2e224ae]
stable/5.10: [2add311d99646c9d235b2c44f9c169ba30f5db3a]
stable/5.15: [83bd8a5756a3c4a413ed8f6253f9eb2821e1ccaf]
stable/6.1: [5716a293fb19d382ca2336e08fd28a619a5f3c25]
stable/6.12: [43e7c02d6090a82fd60d63491f6871aec906345e]
stable/6.18: [b8338111e14183972359009c12d0dbd81d2e1e16]
stable/6.6: [ed598de9f61582902406d352d99f2073d8e00298]

CVE-2026-63917: ip6: vti: Use ip6_tnl.net in vti6_changelink().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63917

Introduced by commit 61220ab ("vti6: Enable namespace changing") in v3.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [11b326fb0a374f4654f9be22d0f0f7abd9f7d3fe]
stable/5.10: [0cdce7618464f7fb06f461e8f4ad575cb1d570f4]
stable/5.15: [f5c68875e25f331e497ddfbe81e2d8163a87f136]
stable/6.1: [d9c5eecdb3c740e65038651db7c686b10d76d1bc]
stable/6.12: [225b467e3b631f38be22e4b38062a1fed02fdd21]
stable/6.18: [fc32be9ac2788524c6b24efd681cce7a6e731a92]
stable/6.6: [f1e89a943ee574d0f2f16246eb3f2d7330fdeb03]

CVE-2026-63918: l2tp: use refcount_inc_not_zero in l2tp_session_get_by_ifname

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63918

Introduced by commit abe7a1a ("l2tp: improve tunnel/session refcount
helpers") in v6.12-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05f95729ca844704d15e49ce14868af4b403b32b]
stable/6.12: [ee80455feffb9cb62b5b58715cabeff495e666b2]
stable/6.18: [947013fd7c8c35dd5856557b215840098a3f67f8]

CVE-2026-63919: xfrm: input: hold netns during deferred transport reinjection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63919

Introduced by commit 7b38019 ("xfrm: introduce xfrm_trans_queue_net")
in v5.6-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c16f74dc1d75d0e2e7670076d5375deda110ebeb]
stable/5.10: [7ee59eda8820b758ed29e1cd3222359c7b97302c]
stable/5.15: [2df7059a18afb7d3aee6c36cad5d371c198111d4]
stable/6.1: [8dfabcba6a943a7a02ebe1e1637c361ba96acbaa]
stable/6.12: [55ddfc41451f01c588089cd74957a05311b6f202]
stable/6.18: [9f7ebb45a83afc3216e855e57d51bb4bc9b5232e]
stable/6.6: [48ce101cd630d6745b6923b5bad8358bc4c119da]

CVE-2026-63920: ipv6: validate extension header length before copying to cmsg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63920

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd433671fef381fdaf7b530c631e6b782d66e224]
stable/5.10: [81394827dfb72772c50d0ae3bdfa094428a5d76d]
stable/5.15: [931b4a1f13408c2507719890f78f7227c34a0282]
stable/6.1: [08464413e628803bd10cb1df68d0138665f2f885]
stable/6.12: [0d330eff318c0f44d4fb0ad2c2aef38f87f24c90]
stable/6.18: [a35daeabb433686234b010ebf7b53778dbd6c9b8]
stable/6.6: [a29768d56eb3798c052ad3281b05596e695a17af]

CVE-2026-63921: ip6: vti: Use ip6_tnl.net in vti6_siocdevprivate().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63921

Introduced by commit 61220ab ("vti6: Enable namespace changing") in v3.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b484efd5cb4eeef9021a661e198edc5349dacf6]
stable/5.10: [94ff740a7f9ef5c010784a325dca00cbf228f941]
stable/5.15: [df42ac708acc3399bbb6dc5ca16e0540adda7bbf]
stable/6.1: [44d2ff7d2178503b93151140a45dfa2ad49c9906]
stable/6.12: [d2236348414bdd6558385f35aa7fdc9bf5634011]
stable/6.18: [853f6ea482dfcd3404bbef458ab4d68364eed838]
stable/6.6: [1acfb7d9c6fc7e209ed7789392697e97e03edd33]

CVE-2026-63922: ipv6: exthdrs: refresh nh after handling HAO option

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63922

Introduced by commit a831f5b ("[IPV6] MIP6: Add inbound interface of
home address option.") in v2.6.20.16.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7b52afe3592eae66e160586b45a3f2242972c63]
stable/5.15: [f8aabed3ff3e986920cf02a2a2785e08e586b234]
stable/6.1: [1a11eb7431e3d2882f5bd5939c5a9bbc65ccf4d1]
stable/6.12: [ff375ed1cba81392346c5bfbf0bb7a13b2946f99]
stable/6.18: [751db1b802a067b7fff25880f4e9f9152a171538]
stable/6.6: [12d957979e4a800167842f1b42be6a606d227ebe]

CVE-2026-63923: octeontx2-af: validate body pcifunc in
rvu_mbox_handler_rep_event_notify

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63923

Introduced by commit b8fea84 ("octeontx2-pf: Add support to sync link
state between representor and VFs") in v6.13-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2156a29aecfffa2eb7c558255690084efbe9f3b0]

CVE-2026-63924: ipv6: exthdrs: refresh nh pointer after ipv6_hop_jumbo()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63924

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d47548a36639095939f4747d4c43f2271366f565]
stable/5.10: [b3ac54e5c905f86d22b502eacb5686a282c5659f]
stable/5.15: [645b99b1a185c91a79bdac4c5de0f91b212d64f0]
stable/6.1: [9e883eaa878f4337b5873c706efb5a192364ed18]
stable/6.12: [72af7beae774e46ed543f3f2f267bf0a141bfcdd]
stable/6.18: [c512e1c819dfbf6ae95ee7a44b65b9ad98979157]
stable/6.6: [bddaa4dfc7f36e1ee343a0622f69288af2b9ace9]

CVE-2026-63925: macsec: fix replay protection at XPN lower-PN wrap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63925

Introduced by commit a21ecf0 ("macsec: Support XPN frame handling -
IEEE 802.1AEbw") in v5.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e68842b3356471ba56c882209f324613dac47f64]
stable/5.10: [dd7306779c6ce1238f4cdc34f3c1f2246b854457]
stable/5.15: [d15130461df388136b62a7b0ce9f66e7e2fa9ff1]
stable/6.1: [23c0e230eab397d7f68be2538790ac41d3bb91fd]
stable/6.12: [79495a1b0944fe31ffd54b54b00211b493590d62]
stable/6.18: [6d00f5c7e5ff7ec4795b7f5f8ed88bd346641652]
stable/6.6: [679e13a65e68a67c8b3c0467c02ee89157ec6f0f]

CVE-2026-63926: bpf: sockmap: fix tail fragment offset in bpf_msg_push_data

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63926

Introduced by commit 6fff607 ("bpf: sk_msg program helper
bpf_msg_push_data") in v4.20-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f72eed9b84fb771019a955908132410a9ba9ea3f]
stable/5.10: [f14609d8146707452e0822f3c8154674ce677251]
stable/5.15: [d81b323af2dcee47573907ccb89c0df9b45cb2e2]
stable/6.1: [aeb95146848d12206e1b2cfacd4f40e21ce81d94]
stable/6.12: [3075c21d2d76c0067f4a382765b43d6cc10470f1]
stable/6.18: [5e19028667963fb371ebb00cecc2a473ef92056b]
stable/6.6: [96b72672ce849a1402730238e64d9b20bf06a96d]

CVE-2026-63927: usb: dwc2: Fix use after free in debug code

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63927

Introduced by commit 7359d48 ("staging: HCD files for the DWC2
driver") in v3.10-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ea06a3fbf9f16e0d98c52cb3b99642be15ec281]
stable/5.10: [d5fc183ed614aeba6779cc992325be560f9a4451]
stable/5.15: [63b0dafa676aad4d0c3f01a61ad8e2990907660c]
stable/6.1: [9fe1d84f7e2cf33634e8afb7f4b7f8de182dd913]
stable/6.12: [a15eeeceb94cbc04edef395e4d777ff554bdc27d]
stable/6.18: [84ea928ed584756e59c6ac09736f12d1db95ded0]
stable/6.6: [0584af4fe40fa5e254a05d69ce658746de641708]

CVE-2026-63928: USB: serial: omninet: fix memory corruption with small endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63928

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60df93d30f9bdd27db17c4d80ed80ef718d7226b]
stable/5.10: [180996f0ca774001944e4afa452d569ba2f6455c]
stable/5.15: [b496e25ead5976bce2891dacaed09beb53a54f9f]
stable/6.1: [4e7d32189d6219beb7db37cd0ea36b6bac7dfedb]
stable/6.12: [0bda1893e4cc4ad2b7dcdbaca246f2af688c6c2a]
stable/6.18: [0fee0ccac29e088d4bfab7e2d075725dcecd803d]
stable/6.6: [9a3860454bdfb765f936965e975c594352602ffc]

CVE-2026-63929: iio: buffer: Fix DMA fence leak in iio_buffer_enqueue_dmabuf()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63929

Introduced by commit 3e26d9f ("iio: core: Add new DMABUF interface
infrastructure") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a093999355084bdbfe6e97f1dd232e58a1525f0b]
stable/6.12: [9678aeed8b77d495a417dd057d479f3733094019]
stable/6.18: [3412a95afaa5d3262008dfc34f3c7be33d8151dc]

CVE-2026-63930: iio: buffer: hw-consumer: fix use-after-free in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63930

Introduced by commit 48b66f8 ("iio: Add hardware consumer buffer
support") in v4.16-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f5ed4f2c7c83f33344e0ba179f72a12e5dad4a4]
stable/5.10: [b71893c57730809c222766e5718bb33610f11963]
stable/5.15: [2ff615fc455acda5425c4900160cbe11cfea4449]
stable/6.1: [d2759d49860b9a39b5cde2fb88e4b822ddf5f58f]
stable/6.12: [e965627f0d442bfcae3f496c90cb653fb0917a61]
stable/6.18: [a3763ae33476328cf8d661742deb9daec78eac96]
stable/6.6: [29783e6b6ec0b7152a15e53a063f17537e81177d]

CVE-2026-63931: iio: chemical: scd30: fix division by zero in write_raw

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63931

Introduced by commit 64b3d8b ("iio: chemical: scd30: add core driver")
in v5.9-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5aba4f94b225617a55fed442a70329b2ee19c0a5]
stable/5.10: [4748bce423a363bb8a85a624faeb8f54fe331611]
stable/5.15: [6308b812acdcac38cbfe1af0b1524c3375f408a5]
stable/6.1: [c7a740bf75554b051fabb17596ca6e483d6e6d90]
stable/6.12: [d98c2e69aab905d1b19a69ffe584efa46a9efd42]
stable/6.18: [5e4d34092a5ebfbc3a45a180c76ecb1cdbbedd53]
stable/6.6: [e85bc501947f5ae16dd9adc01162b76d55ab7962]

CVE-2026-63932: iio: chemical: mhz19b: reject oversized serial replies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63932

Introduced by commit 4572a70 ("iio: chemical: Add support for Winsen
MHZ19B CO2 sensor") in v6.16-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [673478bc29cf72010faaf293c1c8c667393335a0]
stable/6.18: [a5a05410cb34bfa486d63684cdc1f87a3b13f20a]

CVE-2026-63933: iio: gyro: adis16260: fix division by zero in write_raw

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63933

Introduced by commit 089a419 ("staging: iio: adis16260 digital gyro
driver") in v2.6.35-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [761e8b489e6cf166c574034b70637f8a7eadd0ee]
stable/5.10: [d2b83995759cfe5d06567bbcb600fe16d4048da3]
stable/5.15: [19eb8565c4500f9af17ec65eaf952365e2893351]
stable/6.1: [59f80b945f2ca645064074d8507785c26ea16d2d]
stable/6.12: [aa8a5e118e97d2cfd0da5ea4f8f0f488efdea4b0]
stable/6.18: [aaf9d640e9ae1172d0a9c659ecb245a50a10850a]
stable/6.6: [86298fb6829cab983910810959f85d4b4fd0f5c1]

CVE-2026-63934: iio: gyro: itg3200: fix i2c read into the wrong stack location

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63934

Introduced by commit 9dbf091 ("iio: gyro: Add itg3200") in v3.9-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bdc3023d62ed5c7d591f0eb27a5adb37fb892ae]
stable/5.10: [90e809376b0f0d1ddec2eec954aecdd2a5b40b0e]
stable/5.15: [8654b5e2617819ff4f7c78071dfd0275e971a9b6]
stable/6.1: [b64dd5f3b38911054cbcc570df617e3e8e75e562]
stable/6.12: [63203bd072b613c18c237b906b1c9d2dc4527337]
stable/6.18: [15a0b3f33ffb6c78b3de6f69b026ceb09b973dd1]
stable/6.6: [31bbd4b87dd6701fa10e03ba7f6268e49e178d16]

CVE-2026-63935: iio: adc: nxp-sar-adc: fix division by zero in write_raw

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63935

Introduced by commit 4434072 ("iio: adc: Add the NXP SAR ADC support
for the s32g2/3 platforms") in v7.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9aba21a539c668a66b58eeb08ad3909e5a54c2a]

CVE-2026-63936: iio: adc: mt6359: fix unchecked return value in mt6358_read_imp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63936

Introduced by commit 3587914 ("iio: adc: Add support for MediaTek
MT6357/8/9 Auxiliary ADC") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9bbd943c34a9ad60e593a4b99ce2394e4e2381b]
stable/6.12: [6258bfec51e894ea97b8e69f3cde7af269b37de9]
stable/6.18: [944082fdb0284a31c0b37a88c8a1d4404da3a6d9]

CVE-2026-63937: KVM: SEV: Use READ_ONCE() when reading entries/indices
from PSC buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63937

Introduced by commit 9b54e24 ("KVM: SEV: Add support to handle Page
State Change VMGEXIT") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8cc238093ca6c99267032f6cfe78f59389f3157]
stable/6.12: [bd232801ef1d1fd985d2d4ca3cd1d888303ca86f]
stable/6.18: [b1dfaa6f7a957726a6800135be3659fbe4bbf2a4]

CVE-2026-63938: KVM: SEV: Check PSC request indices against the actual
size of the buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63938

Introduced by commit 9b54e24 ("KVM: SEV: Add support to handle Page
State Change VMGEXIT") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [121d88de56bc5c0ba0ce2f6381af67f948a7e7c1]
stable/6.12: [5198f70c09a5f6e9e5f5a0a2c6b388f24294b176]
stable/6.18: [75c8d1d7291268b479794fba5808971dc2f5eaf3]

CVE-2026-63939: KVM: SEV: Compute the correct max length of the
in-GHCB scratch area

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63939

Introduced by commit 9b54e24 ("KVM: SEV: Add support to handle Page
State Change VMGEXIT") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5867d7e202e09f037cefe77f7af4413c7c0fa088]
stable/6.12: [6ca9400d36005ffdca25f80186bea781c7e1dc4c]
stable/6.18: [9f0a9e780f02c02d025a190f1885e1d1d73b87bd]

CVE-2026-63940: KVM: SEV: Ignore Port I/O requests of length '0'

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63940

Introduced by commit 291bd20 ("KVM: SVM: Add initial support for a
VMGEXIT VMEXIT") in v5.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3988bd2723de407ae90fa7a6f6029b4e60238c58]
stable/6.12: [3b6035bc6bff20e89752ce4358bc4c9a9d5883f2]
stable/6.18: [2254972d4d69e279ba4e87bf0968eb08ad0d3c92]

CVE-2026-63941: KVM: arm64: Correctly cap ZCR_EL2 provided by a guest hypervisor

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63941

Introduced by commit b3d29a8 ("KVM: arm64: nv: Handle ZCR_EL2 traps")
in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83726330748981372bde86ed5411d7b306612991]

CVE-2026-63942: parport: Fix race between port and client registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63942

Introduced by commit 6fa45a2 ("parport: add device-model to parport
subsystem") in v4.2-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef15ccbb3e8640a723c42ad90eaf81d66ae02017]
stable/5.10: [f3378b0d7bd4605de89b083b2900788157a181cc]
stable/5.15: [290f515c5e3b3900bc2fe24f179999fd08d23bfa]
stable/6.1: [d16548be2ea5058227d79799e81dab61c9bca8ec]
stable/6.12: [51026cff1f4f3b762a0b5a07c727bd59cef45320]
stable/6.18: [74d6aae1df45d3414178986be743f946988fddf6]
stable/6.6: [15b1723c1472e802f9f7e69ae4e64f7dbf588848]

CVE-2026-63943: Input: xpad - fix out-of-bounds access for Share button

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63943

Introduced by commit 4ef4636 ("Input: xpad - fix Share button on Xbox
One controllers") in v6.15-rc6.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [6cdc46b38cf146ce81d4831b6472dbf7731849a2]
stable/6.12: [37ec54abfdd63a63fd50734a9c4e4cbc1e5795af]
stable/6.18: [9749db57233b396353ad5dee81eec9d9880c9246]
stable/6.6: [bcfb4833cd4078a1a356ef451838b75cd233099e]

CVE-2026-63944: Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63944

Introduced by commit c09b80b ("Bluetooth: hci_conn: Fix not waiting
for HCI_EVT_LE_CIS_ESTABLISHED") in v6.4-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bfea6091e0fffb270c20e74384b660910277eb6c]
stable/6.12: [a921957d39290143629eb38c4f74b9bef8035d0a]
stable/6.18: [d9019210c8c30d40eb20094274cc647e352f48f7]
stable/6.6: [a55618c0f4cead9e59c63f5ee030d393fd70d861]

CVE-2026-63945: Bluetooth: ISO: serialize iso_sock_clear_timer with socket lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63945

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b5f8e608749b7e8fa386c6e4301cf9272595859]
stable/6.1: [d9cbf7144ec589a3f0cc91f74a1a1af2d2b14afa]
stable/6.12: [996c2104d0726a8fe584f85b3d6327197374a348]
stable/6.18: [bc08c15746f25f41dd0508b25780d1e84acbb2ef]
stable/6.6: [35f68f36d9883d56dec21cf85f7556d4657fc393]

CVE-2026-63946: Bluetooth: ISO: fix UAF in iso_recv_frame

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63946

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [47f23a259517abbdb8032c057a1e8a6bf3734878]
stable/6.1: [c57ea90f203c8b8b41a474f19a09000d0f841436]
stable/6.12: [b04ec131325baf4ea4577d6c6e6b86cf092e3731]
stable/6.18: [c318aa51830a3d2cc1229968fe521441c97356cd]
stable/6.6: [119fb6f80c44dc1c65d604cf28e64c56bd9b6568]

CVE-2026-63947: Bluetooth: HIDP: fix missing length checks in
hidp_input_report()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63947

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a3ac9ee11dbb9845f3947cef4a79dba658cf6f6]
stable/5.15: [1f08a90013e1e632b34321334e861fcefc056505]
stable/6.1: [cc3832b19f863e3677c5651f001a2e3795f39eb8]
stable/6.12: [d7d6a81b8dd1a8d084a1b755db9406041d53adb5]
stable/6.18: [6348dfed5b0f9c6074f14322332e97493d32fef0]
stable/6.6: [d313683d6ccdd8c01e0562270a2ae25b86d8461d]

CVE-2026-63948: Bluetooth: L2CAP: fix chan ref leak in
l2cap_chan_timeout() on !conn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63948

Introduced by commit adf0398 ("Bluetooth: l2cap: fix null-ptr-deref in
l2cap_chan_timeout") in v6.9.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1 stable/6.6

Fixed status
mainline: [9dbd84990394c51f5cee1e8871bb5ff8af5ed939]
stable/5.10: [50f1bcaaaa3a80bb1c3472044bc146e8d49d51ee]
stable/5.15: [b5c59a5b469e2a809a2d57eda4ded94235971060]
stable/6.1: [8894c2010435a56ce7c6c2a8785860c13554df2f]
stable/6.12: [107c826e4ef9ec5ad8f60e6fe64d8d5325ba508f]
stable/6.18: [e8a5baff5be273ca07771fd2b9bb1f2a4152917b]
stable/6.6: [63cd225cc13d782a85e2a73c04d0d350153eada1]

CVE-2026-63949: auxdisplay: line-display: fix OOB read on zero-length
message_store()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63949

Introduced by commit 7e76aec ("auxdisplay: Extract character line
display core support") in v5.16-rc1.
Fixed in v7.1-rc7.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7511dcd9dd4bc55d123f9b800c8a4ed2662e5c6]
stable/6.1: [ca5b0781946d5083ceafa752141f47f085853620]
stable/6.12: [3859960daeb9b7b39b9847b5b0113bc6081eb735]
stable/6.18: [197476b126010bac1b3199833c6966cd6f54c2a9]
stable/6.6: [8776032fe989a9b5fc77f2de5e03e4adb44c630e]

CVE-2026-63950: mm/rmap: initialize nr_pages to 1 at loop start in
try_to_unmap_one

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63950

Introduced by commit 354dffd ("mm: support batched unmap for lazyfree
large folios during reclamation") in v6.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f8968e9cbf95d5d87d32218906cab0b9b9eddbe]
stable/6.18: [0fcc34d0d8fefca4fea349e45c10e3a3d90350eb]

CVE-2026-63951: zram: fix use-after-free in zram_writeback_endio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63951

Introduced by commit f405066 ("zram: introduce writeback bio
batching") in v6.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bf62f69574b19720ae5fbbbcdf24a0c4e3e05e43]

CVE-2026-63952: memfd: deny writeable mappings when implying SEAL_WRITE

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63952

Introduced by commit c4f75bc ("mm/memfd: add write seals when apply
SEAL_EXEC to executable memfd") in v6.3-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3b041514cb6eae45869b020f743c14d983363222]
stable/6.12: [3be2a24f7f72ad7321ed6ad1715b956a4527bcf4]
stable/6.18: [0995d1f79aed8ccbf62056189dd53fd19726ea08]
stable/6.6: [b3f4f82d1315f1439059a83d1c22c51a5b43d99e]

CVE-2026-63953: mm/migrate_device: fix pgtable leak in
migrate_vma_insert_huge_pmd_page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63953

Introduced by commit a30b48b ("mm/migrate_device: implement THP
migration of zone device pages") in v6.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c6f81d58741349298f51ff697d988cb42881453]

CVE-2026-63954: hpfs: fix a crash if hpfs_map_dnode_bitmap fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63954

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [974820a59efde7c1a7e1260bcfe9bb81f833cc9f]
stable/5.10: [010b08084000ef018f1a8de5197087f3b91d8cfe]
stable/5.15: [d98d8562b3284b5a5c8eb67e71b794508e46e288]
stable/6.1: [1648a3c7f4e18f46a4881920133fc4f2494185a0]
stable/6.12: [1d73a533760bc5abb83b3cc759133596f7bb708f]
stable/6.18: [0886c6f257fe3663f80218aa1919b0f3f21bf22c]
stable/6.6: [7c58c55a2a16f7274772507bd1637be609351b4f]

CVE-2026-63955: mm/vmalloc: do not trigger BUG() on BH disabled context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63955

Introduced by commit c630767 ("mm: kvmalloc: add non-blocking support
for vmalloc") in v6.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [04aa71da5f35aacdc9ae9cb5150947daa624f641]

CVE-2026-63956: USB: serial: cypress_m8: fix memory corruption with
small endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63956

Introduced by commit 3416eaa ("USB: cypress_m8: Packet format is
separate from characteristic size") in v2.6.26-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1a9d791fd66ab2431b9e6f6f835823809869047]
stable/5.10: [4fcb22218f0a7229b7ce3b3952fb644def293fa5]
stable/5.15: [ad3d1628a46134276546d7a12fedf04be9979158]
stable/6.1: [52e18ae0c47c5c89e18fcd8022f287f7cc8802ec]
stable/6.12: [1ef25704bd3b625fd151c09feee459479f71ee64]
stable/6.18: [284105c40fc31fff90cdab8a0377aaeb92f87f0e]
stable/6.6: [4bcaa59f403dbde6328604a500d65ee8d40975d9]

CVE-2026-63957: USB: serial: safe_serial: fix memory corruption with
small endpoint

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63957

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [438061ed1ad85e6743e2dce826671772d81089ec]
stable/5.10: [e3a1d6eee25dc96b1d2db0ecd9d8741e92056476]
stable/5.15: [c7336c0fba5c959249f3d793d33076b992ec3ee4]
stable/6.1: [161ea0e5236f5f051d2d85d6c54dd08ee9dc7ba4]
stable/6.12: [a550ed2117ca4709d38f713933ff924a83942e41]
stable/6.18: [f793b67d41e5fab719c5a90baa77cbd2fe259517]
stable/6.6: [9b3145b3001fb24de1da72d1deb0bea70e5a078b]

CVE-2026-63958: usb: typec: ucsi: validate connector number in
ucsi_connector_change()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63958

According to the .vulnerable file, this bug was introduced by commit
c1b0bc2 in v4.13-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [288a81a8507052bcfbf884d39a463c44c42c5fd9]
stable/6.1: [cea949203faef9cb783adc7b978cce056271e057]
stable/6.12: [bd24d92af4ae021b6209f28e9a57e1bf2260d4fd]
stable/6.18: [0edd1e21587b0483c7ceb993b9fb9668bbef7433]
stable/6.6: [156b6f0aec6108909b0c4aedc78865b12766b347]

CVE-2026-63959: usb: typec: tcpm/tcpci_maxim: validate header NDO
against RX_BYTE_CNT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63959

According to the .vulnerable file, this bug was introduced by commit
6f413b5 in v5.10-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa2f716327be1818e1cb156da8a2844804aaec2f]
stable/6.12: [dc17721d42e6d89f63572e63add8306a0e15eb3c]
stable/6.18: [9b496e3371c04f0a03b7faa5d2442536d00e3998]
stable/6.6: [0af00f1459f5dd757f0d392f8caa38039561ac62]

CVE-2026-63960: usb: typec: wcove: don't write past struct pd_message
in wcove_read_rx_buffer()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63960

According to the .vulnerable file, this bug was introduced by commit
3c4fb9f in v4.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4af7ad0e6d7aa4403dbb1dac7b9659b0421efcaa]
stable/5.10: [3e632098d0521257ea965bbd6fde807d9bee5c8a]
stable/5.15: [f2a1edc0bd142edabc6c85d88713f2bc178dd317]
stable/6.1: [6899f5b6d7b83ce79a3d331dc61dd31bf73f9c22]
stable/6.12: [d0e4b8b3c6b7607a16932556eaaca5d5cf69f192]
stable/6.18: [e94933dc41b87503bf585c8c6d53d740620eceb9]
stable/6.6: [5cd0e7ac4eefbdb330f8c72694fe74e63df65552]

CVE-2026-63961: usb: typec: altmodes/displayport: validate count
before reading Status Update VDO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63961

According to the .vulnerable file, this bug was introduced by commit
0e3bb7d in v4.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a18f896e667df491331371b55d4ad644dc51d60]
stable/5.10: [74aabe9ea30fdfba924fce9594e6aa69a596a4bb]
stable/5.15: [dd7118c010f324497c275e8fd7a35c9baaa2a00f]
stable/6.1: [6ffdbcd7a02f3af8fff9b6519830369f574ed44c]
stable/6.12: [64bd6ccc5799f8473d1f37d4d8f53093dfec5c02]
stable/6.18: [b10eff5abe6aa2a5af10ed17bddff76e3b6e6b9b]
stable/6.6: [70e7045849e954e56dcbf441b6330e66bc996306]

CVE-2026-63962: usb: typec: tcpm: bound altmode_desc[] per iteration
in svdm_consume_modes()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63962

According to the .vulnerable file, this bug was introduced by commit
4ab8c18 in v4.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3389c149c68c3fea61910ad5d34f7bf3bff44e32]
stable/6.12: [845598b154b9a92e9d279fafafa9405c121ae805]
stable/6.18: [4505f33dab56c274e82f47f94bf60a8cbf8f4b42]

CVE-2026-63963: usb: typec: tcpm: validate VDO count in Discover
Identity ACK handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63963

According to the .vulnerable file, this bug was introduced by commit
f0690a2 in v4.12-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fbc349e8383125dd2d8de1c1e926279d398ab17]
stable/6.12: [569f7971542eb10025d8a0989b83f28a29d8ba20]
stable/6.18: [f9d787fbe83127105e42088cca40e5118db0d810]

CVE-2026-63964: usb: typec: ucsi: ccg: reject firmware images without
a ':' record header

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63964

According to the .vulnerable file, this bug was introduced by commit
5c9ae5a in v5.2-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7486952bf74e546ee3748fb14b2d07881fa6273]
stable/5.10: [b41dfc033fe594e152648050e95b9489cd53e9e3]
stable/5.15: [2f395ca1263bd181995eb829f5943a83a20db213]
stable/6.1: [6526f8684f72391138353642af908803ba70795e]
stable/6.12: [c4ee519b06389e59ba2d6aa722fcc4a02a8bbcbb]
stable/6.18: [a38ed87818b2419090fb1a6338ddce6842b65dfa]
stable/6.6: [3f432b8203066c26770fe6ea591361f10021dd6b]

CVE-2026-63965: iio: pressure: bmp280: fix stack leak in bmp580 trigger handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63965

Introduced by commit 872c801 ("iio: pressure: bmp280: drop sensor_data
array") in v6.16-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [387c86b582e0782ab332e7bfcd4e6e3f93922961]
stable/6.18: [a58400f58f82f3d8de9c067aa7cda690228c1ecc]

CVE-2026-63966: iio: imu: adis16550: fix stack leak in trigger handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63966

Introduced by commit e4570f4 ("iio: imu: adis16550: align buffers for
timestamp") in v6.15-rc6.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [474f8928d50b09f7dcf507049f08732640b88b49]
stable/6.18: [ce582b22dd2ff15ac99101c22ec1559d1febe2ff]

CVE-2026-63967: iio: imu: st_lsm6dsx: fix stack leak in tagged FIFO buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63967

Introduced by commit c14edb4 ("iio:imu:st_lsm6dsx Fix alignment and
data leak issues") in v5.10-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9d8e9adaa63150ef7e833480b799d0bab83a276]
stable/5.10: [ff8d3c088b77b11782f2c3b97e37425be050e8de]
stable/5.15: [fe1a7f99e72ebd2880515332b79b8c256be22aca]
stable/6.1: [babf1943a40bb5669db57d30ca16c22504b18e07]
stable/6.12: [3147b303b8c7d9f91da4b849ece33b45048f5eaf]
stable/6.18: [e6bb3a49c5f9de870ea95e69775df785728e3366]
stable/6.6: [d42ac0bfb6a16617c62a59d53706579c7fadbfa6]

CVE-2026-63968: ipv6: fix possible infinite loop in fib6_select_path()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63968

Introduced by commit d9ccb18 ("ipv6: Fix soft lockups in
fib6_select_path under high next hop churn") in v6.13-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [9c7da87c2dc860bb17ca1ece942495d28b1ce3b9]
stable/6.1: [3948a7d92f7678e89e1776bb2d169afcad63b1ae]
stable/6.12: [0f7b73c3452635de83b8711b31abdda8e49aad7b]
stable/6.18: [ab9a10969a907b472a0196d999c08ff7144172e3]
stable/6.6: [c87cd3cb309634bc8f50a54e2079424f219ac21f]

CVE-2026-63969: ipv6: fix possible infinite loop in rt6_fill_node()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63969

Introduced by commit d9ccb18 ("ipv6: Fix soft lockups in
fib6_select_path under high next hop churn") in v6.13-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [9f72412bcf60144f252b0d6205106abf14344abc]
stable/6.1: [b014a63d2f2c2c767762b548381882dfb1655529]
stable/6.12: [c65b1f60237daac7c56c2652e064cc566a45dc81]
stable/6.18: [dc36a04621dcc2447dae428709207810b6c06e14]
stable/6.6: [279853aec9f58d5cd723e6e5617c1c3337b30383]

CVE-2026-63970: vsock/virtio: bind uarg before filling zerocopy skb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63970

Introduced by commit 581512a ("vsock/virtio: MSG_ZEROCOPY flag
support") in v6.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e584c304cfb94a759417130b1fc6d30b30c4cce]
stable/6.18: [b62e2b2b4a50953ca952f3cd3f77dd62dc50fd5d]

CVE-2026-63971: sctp: fix race between sctp_wait_for_connect and peeloff

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63971

Introduced by commit 668c9be ("sctp: implement assign_number for
sctp_stream_interleave") in v4.16-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f14fe6395a8b3d961a61e138ad7b36ba3626dd4e]
stable/5.10: [0e0d5bc76fd4267a71334fcc8f1a5fbcf997845d]
stable/5.15: [bcfeac79af740735ace44008b4a11b8e5add20f5]
stable/6.1: [8e9b56051d24540cfbf39194618708c4a7633549]
stable/6.12: [7d2038d4b80166f7bead8d07eba3b97405816c21]
stable/6.18: [68667ee4c7dadf7f63167234e2a1af09b3f7874e]
stable/6.6: [634a9af8a26a84d8b0d7b3b643204b344b42d9fb]

CVE-2026-63972: net: mana: Skip redundant detach on already-detached port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63972

Introduced by commit 3b19434 ("net: mana: Implement ndo_tx_timeout and
serialize queue resets per port.") in v7.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [5b05aa36ee24297d7296ca58dfd8c448d0e4cda3]
stable/6.18: [c4152b4e28b3e550ec99351bf900e2c24c2608cc]

CVE-2026-63973: net: mana: Add NULL guards in teardown path to prevent
panic on attach failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63973

Introduced by commit ca9c54d ("net: mana: Add a driver for Microsoft
Azure Network Adapter (MANA)") in v5.13-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17bfe0a8c014ee1d542ad352cd6a0a505361664a]
stable/6.1: [da7e4a1aaf397af6a094f640c92d6bc7564c10db]
stable/6.12: [26a96fa81496afe7d162d172ccdc8cb9dbc685d2]
stable/6.18: [da87896f34e0a51489811d1a684e2953099ca98f]
stable/6.6: [95e414f8324385771bdfd6d497a01d5593813ccb]

CVE-2026-63974: Bluetooth: hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE
during device close

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63974

Introduced by commit 877afad ("Bluetooth: When HCI work queue is
drained, only queue chained work") in v6.0-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [525daaea459fc215f432de1b8debbd9144bf97b0]
stable/6.12: [9cebe4680bb9a72f80c6541eb24af06db7a1fbc9]
stable/6.18: [47330cc875b36a1cf7b3543cb2cf90a7c603ce0e]

CVE-2026-63975: Bluetooth: L2CAP: Fix possible crash on l2cap_ecred_conn_rsp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63975

Introduced by commit 15f02b9 ("Bluetooth: L2CAP: Add initial code for
Enhanced Credit Based Mode") in v5.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41c2713b204e6cb6a94587bc6bf6935107df5479]
stable/5.10: [3c8eaa91eb433c450426539290be4ffe282e9f00]
stable/5.15: [ecfed1e0d8efecad6737a0d83e21d2fd021d8c48]
stable/6.1: [e6833e737a51db1e5ea0401322acf5e22abd8be6]
stable/6.12: [291eec1041c918c460dc9702e44edd17794b4a4b]
stable/6.18: [41e29548b5e8b5e5fcf708786b3bea67cab107fa]
stable/6.6: [6319b38fe69f56ed95680ade485b957a53fff642]

CVE-2026-63976: Bluetooth: l2cap: clear chan->ident on ECRED
reconfiguration success

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63976

Introduced by commit 15f02b9 ("Bluetooth: L2CAP: Add initial code for
Enhanced Credit Based Mode") in v5.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00e1950716c6ed67d74777b2db286b0fa23b4be9]
stable/5.10: [59f5ecf6ad5c4db6ae81965a96156954a3b0d89a]
stable/5.15: [ae0152d77d101c920769934fb102b18de0c6f526]
stable/6.1: [c2afd2613fda90107c5e2fe8e855627451749c78]
stable/6.12: [3b5b5f423b4fd23404a393bda8adba3cd6f74ef1]
stable/6.18: [f39049304ba655ffcbb92edbdf8c51a1f1210bed]
stable/6.6: [cc2b4f749de09975bfa06e58bbbad2f6acd4c79c]

CVE-2026-63977: dpll: zl3073x: use __dpll_device_change_ntf() and
remove change_work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63977

Introduced by commit 9363b48 ("dpll: zl3073x: Allow to configure phase
offset averaging factor") in v6.18-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d733f519f6443540f8359461a34e3b0042099bbe]

CVE-2026-63978: net/handshake: Drain pending requests at net namespace exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63978

Introduced by commit 3b3009e ("net/handshake: Create a NETLINK service
for handling handshake requests") in v6.4-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea5fe6a73ca57e5150b8a38b341aef2636eb72f0]
stable/6.12: [9ec20c9a5a04f2c3f1cf65d21f886d7aaa6189cd]

CVE-2026-63979: net/handshake: hand off the pinned file reference to accept_doit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63979

Introduced by commit 3b3009e ("net/handshake: Create a NETLINK service
for handling handshake requests") in v6.4-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4251190e58b209999c1ba9e6d2976136a1be055]

CVE-2026-63980: net/handshake: Use spin_lock_bh for hn_lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63980

Introduced by commit 675b453 ("nvmet-tcp: enable TLS handshake
upcall") in v6.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc993e0927ec8bd98ea33377ada03295fcda0f24]
stable/6.12: [06ab5978866fc2221b910347fd3e510ca8e7b1a4]
stable/6.18: [0866569fc36a56f568acd3900d354e3505932e09]

CVE-2026-63981: net/sched: act_mirred: Fix blockcast recursion bypass
leading to stack overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63981

Introduced by commit fe946a7 ("net/sched: act_mirred: add loop
detection") in v6.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [a005fa5d7502eefec7ee6e1c01adadc06de2f9ad]
stable/6.12: [25fc9352590f5ef21ebf290432bd768b336693bc]

CVE-2026-63982: net/sched: Fix ethx:ingress -> ethy:egress ->
ethx:ingress mirred loop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63982

Introduced by commit fe946a7 ("net/sched: act_mirred: add loop
detection") in v6.19-rc1.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [db875221ab08d213a83bf30196ae8b64d55a3403]
stable/6.12: [66f4607fe788fc7d81bce0e2f7b3726ed2f71284]

CVE-2026-63983: net/sched: fix packet loop on netem when duplicate is on

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63983

Introduced by commit 0afb51e ("[PKT_SCHED]: netem: reinsert for
duplication") in v2.6.12.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9552b11e3edabc97cfcd9f29103d5afbce7ae183]
stable/6.12: [1a298a514ce766c6d0c232991a390fec67af81ad]

CVE-2026-63984: ipv6: rpl: fix hdrlen overflow in ipv6_rpl_srh_decompress()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63984

Introduced by commit 8610c7c ("net: ipv6: add support for rpl sr
exthdr") in v5.7-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9d5e7a46a9f6d8f503b41bfefef70659845f1679]
stable/5.10: [75b3680047bf09af8e7e471a7a6ddf2ce5847f56]
stable/5.15: [fd238c51b0fa5390cceca9f1ac5a9ffda8063eed]
stable/6.1: [3618b34942b76471d044369bfd30d58c39068bf1]
stable/6.12: [de02fc049352af5a9595f015511222d0a85c326b]
stable/6.18: [6fe1cb312038516cb4d9fa089d700af7059f1a64]
stable/6.6: [97e06791368c01f0ad2a4b3269c2abe19485ca32]

CVE-2026-63985: ethtool: eeprom: add more safeties to EEPROM Netlink fallback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63985

Introduced by commit 96d971e ("ethtool: Add fallback to
get_module_eeprom from netlink command") in v5.13-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67cfdd9210b99f260b3e0afeb9525e0acc7be31e]
stable/5.15: [0e182689831277faf2ef683573a60474c208f690]
stable/6.1: [6ed7ebe22e9c3e3e946b6973c1ce43d3c38aeac1]
stable/6.12: [d81376053a00865c70b8d8506a1cb93f2943d413]
stable/6.18: [fd0de51c54fa8474a0ddeedd71c65ad09fada390]
stable/6.6: [65674d2489a12b8efd2ca0effb3de1d12224b596]

CVE-2026-63986: ethtool: tsinfo: don't pass ERR_PTR to genlmsg_cancel
on prepare failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63986

Introduced by commit b9e3f7d ("net: ethtool: tsinfo: Enhance tsinfo to
support several hwtstamp by net topology") in v6.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3fc9976f686f9a95baf87db9d387f218fd65394]
stable/6.18: [2008f9bb1ede9b688624a241228b8e54fc74f0f6]

CVE-2026-63987: ethtool: coalesce: cap profile updates at
NET_DIM_PARAMS_NUM_PROFILES

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63987

Introduced by commit f750dfe ("ethtool: provide customized dim profile
management") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7281b096b072f6c6e30420e3467d738f2e4c4b57]
stable/6.12: [d4c9cc7c47781c6f4fa29d80a1193a8bcd1525bc]
stable/6.18: [0c02c190bcd9822477038ff2cee10ea584ac1b1d]

CVE-2026-63988: bridge: Fix sleep in atomic context in sysfs path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63988

Introduced by commit 78cd408 ("net: add missing instance lock to
dev_set_promiscuity") in v6.15-rc6.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d34594cc619d0d4b07d5afcad8b5984f3526dcf]
stable/6.18: [e976e3f2f2005c6267089a1a3b6344f234a59a55]

CVE-2026-63989: bridge: Fix sleep in atomic context in netlink path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63989

Introduced by commit 78cd408 ("net: add missing instance lock to
dev_set_promiscuity") in v6.15-rc6.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5eec4427b89c2fb2beac54920101e55a2f1c0c21]
stable/6.18: [c9c2e609e8397bb57b4d73675f33a99183c4a0bd]

CVE-2026-63990: bonding: refuse to enslave CAN devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63990

Introduced by commit cd05acf ("[CAN]: Allocate protocol numbers for
PF_CAN") in v2.6.25-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ba68464e4787b6a7ec938826e16124df20fd23d]
stable/5.15: [69b78b5f3033272e53a2dc2dad675962654a5b38]
stable/6.1: [41e8478c4cd896d3abbe33d41afc90c84ac66602]
stable/6.12: [02f1c87ded33b43d48b4a1d665da15f2157b30d8]
stable/6.18: [9ea8a648d9120f7652bcde1ce2c4ad66871af707]
stable/6.6: [f4d78a81f57df82e9d82a2c07471fed1a1235893]

CVE-2026-63991: Bluetooth: 6lowpan: check skb_clone() return value in
send_mcast_pkt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63991

Introduced by commit 18722c2 ("Bluetooth: Enable 6LoWPAN support for
BT LE devices") in v3.14-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c40d381ce04f9575a5d8b542898183c3b4b38dc]
stable/5.10: [9afcb5ea080af13aab37930da627db43bd277665]
stable/5.15: [9903a04becf059e44cccf625e23689b7d4378384]
stable/6.1: [d630c4b25f36e0e68461561e4c70957ec37fdedd]
stable/6.12: [3d5d81d294ba09487c86bc4ba33dc4a4bec5d215]
stable/6.18: [e673889a35a5e4c586d0fae67d8755ca4367d3e2]
stable/6.6: [b06203ac5f12929d79146bb9f063c2af1d679e63]

CVE-2026-63992: tunnels: do not assume transport header in
iptunnel_pmtud_check_icmp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63992

Introduced by commit 4cb47a8 ("tunnels: PMTU discovery support for
directly bridged IP packets") in v5.9-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [509323077ef79a26ba0c60bb556e45c12c398b2d]
stable/5.10: [5a92cb45e34749865d03daf8d3500f77b5f6644c]
stable/5.15: [c7b7ec3e69e673c0d6b57f74d21da50c485c598e]
stable/6.1: [7f4f7efe7f30edd29c4988de01728bf2398217e4]
stable/6.12: [a096b6e34f602950af9a2b0856cd93a5f4c276d7]
stable/6.18: [43368636c663cff6e59dde93cf4b8e43ac28eb93]
stable/6.6: [e917d0c69f01af2bb4fbea2b66d560a53b3ac7ec]

CVE-2026-63993: vxlan: do not reuse cached ip_hdr() value after
skb_tunnel_check_pmtu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63993

Introduced by commit 4cb47a8 ("tunnels: PMTU discovery support for
directly bridged IP packets") in v5.9-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d9ef0cb271555d8cf39fefe6c981e1493b25ecf]
stable/5.10: [6b8bfce9d2f774d2c2243e0248e03efb99bba6c0]
stable/5.15: [9257f56ac47ef1976bcd056cf986a9988eeec67a]
stable/6.1: [8d435d68d71fb875876b722f4136caf74f2f48bd]
stable/6.12: [609e63312c29aad18026a1d3222e123d4b6b0feb]
stable/6.18: [5303925e360527243b46a440a04667826bbc72b7]
stable/6.6: [dc3bfa050f873371e745bdf478b1f5b738e5733d]

CVE-2026-63994: tunnels: load network headers after skb_cow() in
iptunnel_pmtud_build_icmp[v6]()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63994

Introduced by commit 4cb47a8 ("tunnels: PMTU discovery support for
directly bridged IP packets") in v5.9-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4bc94353050b1fa7b702bd4c6600710dd926cff]
stable/5.10: [95b6d772bfe788331d9742d73eaa12e113b2adc4]
stable/5.15: [7254aef4d1a7e18e887af9010e2f2dc34806789b]
stable/6.1: [bf8b3f34c37c162357138e7c0942723b8b94fed1]
stable/6.12: [50750d86a2e5266aba0c295483b3397843198b11]
stable/6.18: [6dff77899b9e9fe5d854abda3a98ad04e7229ef7]
stable/6.6: [76cd9398a0470257ab765bdf5f358a2af2e17934]

CVE-2026-63995: ethtool: cmis: validate start_cmd_payload_size from module

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63995

Introduced by commit c4f7813 ("ethtool: cmis_fw_update: add a layer
for supporting firmware update using CDB") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12c2496a71f82f63617971ca9b730dffa05cf58b]
stable/6.12: [63112b4515469d00008452d9cfe3fb3bf1aa2df3]
stable/6.18: [0696709e951be54c699664adf546d16e28974d53]

CVE-2026-63996: ethtool: cmis: require exact CDB reply length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63996

Introduced by commit a39c84d ("ethtool: cmis_cdb: Add a layer for
supporting CDB commands") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6c3f999a9d1338c6c89a9ff4549eafe72bc2e7b1]
stable/6.12: [2f818cc98fd2c63a08239cb48995f6c3bfe9d9b3]
stable/6.18: [4d42fb88ec61f2e98c33a9e3a2de371d5edbc6b1]

CVE-2026-63997: ethtool: module: avoid leaking a netdev ref on module
flash errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63997

Introduced by commit 32b4c8b ("ethtool: Add ability to flash
transceiver modules' firmware") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb7f511d62692661846c47f199e0afe25c2982db]
stable/6.12: [f7b4513e77f9571dc1041a798b93b5c4a4bfc191]
stable/6.18: [61848c83b9132ab839809fe415ba7802a0aca4f6]

CVE-2026-63998: ethtool: module: call ethnl_ops_complete() on module
flash errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63998

Introduced by commit 32b4c8b ("ethtool: Add ability to flash
transceiver modules' firmware") in v6.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84371fb58423f997939aacdcbc02d128d76a54e5]
stable/6.18: [d9defbf8b62bde89e206d74c2a2b445b9ed66108]

CVE-2026-63999: ethtool: rss: fix indir_table and hkey leak on get_rxfh failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-63999

Introduced by commit 4f038a6 ("net: ethtool: Don't call .cleanup_data
when prepare_data fails") in v6.15-rc2.
Fixed in v7.1-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [266297692f97008ca48bc311775c087c59bd7fe3]
stable/6.18: [33d05c22d6f227c5ae171c46df2f6f8bf48047ea]

CVE-2026-64000: net: hsr: fix potential OOB access in supervision frame handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64000

Introduced by commit eafaa88 ("net: hsr: Add support for redbox
supervision frames") in v5.16-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f229426072fc865654a60978bb7fda790a051ff3]
stable/6.1: [09a37dca090c55ffb1a33f52d8667f1c2367ef48]
stable/6.12: [71c986c0ba45b7dc574fae27c83e7b6671556f37]
stable/6.18: [fbd0662f9c9a66e8cc3df3099cca8ed6d3837cc7]
stable/6.6: [a4b64f3e9c7b8259f7dd251a0313420ba7c01852]

CVE-2026-64001: ALSA: pcm: oss: Fix setup list UAF on proc write error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64001

Introduced by commit 060d77b ("[ALSA] Fix / clean up PCM-OSS setup
hooks") in v2.6.20.16.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4cc54bdd54b337e77115be5b55577d1c58608eae]
stable/6.12: [8be4efd0dc0093eb7a02ad1aac936bca2a1f04ce]
stable/6.18: [e13922bb97b4e6f94f8ac02d034f2d4bd65eeb3c]

CVE-2026-64002: ipv4: free net->ipv4.sysctl_local_reserved_ports after
unregister_net_sysctl_table()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64002

Introduced by commit 122ff24 ("ipv4: make ip_local_reserved_ports per
netns") in v3.16-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87a1e0fe7776da7ab411be332b4be58ac8840d10]
stable/5.10: [ecf45080a4d3f4526cacb8b14060fe3b49a6913b]
stable/5.15: [a0ffc6081a8b27082dd5eae5aa1e3f59bbecf06c]
stable/6.1: [5b23a2ff379e70b6b9ff744a972b63e1f8f4d996]
stable/6.12: [6512c57c4638ddec113bf42439361ba85a12048d]
stable/6.18: [a7f4eefb6e1458431eef9fa20fb363320d185f76]
stable/6.6: [8e59d4d0dcde2dfb07a7ef855c849a2a0560aa57]

CVE-2026-64003: scsi: core: Run queues for all non-SDEV_DEL devices
from scsi_run_host_queues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64003

Introduced by commit 8b566ed ("scsi: core: Only kick the requeue list
if necessary") in v6.5-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7205b58702273baf21d6ba7992e6ba15852325f7]
stable/6.12: [d4dddfecdbb5467bef158d4e1486459808357fef]
stable/6.18: [475f2b37a78f4c698967a7f14f325f04e24c9175]
stable/6.6: [15fb19af49f2073ed77fad16aaabc648b0ca6800]

CVE-2026-64004: net/iucv: fix locking in .getsockopt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64004

Introduced by commit 51363b8 ("af_iucv: allow retrieval of maximum
message size") in v3.4-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3589d20a666caf30ad100c960a2de7de390fce88]
stable/5.10: [884eb247b74d86db97e3a37f0d6fc8e1e83590dd]
stable/5.15: [45bb8de8c95d8899f4b8f61bd9bceb8132af73cb]
stable/6.1: [1fc30bd4e55e2dd622d2d366cecd732c1841bbee]
stable/6.12: [6e792b8dd3002bbc4136745928a9605df1a72b8a]
stable/6.18: [9817369243380e287ebe5525411557eaa3aa2a79]
stable/6.6: [cd691beafea0dd779e69e81ccc26b0ab50efcb5e]

CVE-2026-64005: net/smc: Do not re-initialize smc hashtables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64005

Introduced by commit f16a7dd ("smc: netlink interface for SMC
sockets") in v4.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e4389b0038781f19f97895186ed941ff8ac1678]
stable/5.10: [cdc79c05cc375f68ae87b0c74fdaac1a5c93155a]
stable/5.15: [2006605006e5a4a11d93e1ebdbbe95764d24276f]
stable/6.1: [64c96e497d5ada0b90e99bf58f893aa2b73dcfbc]
stable/6.12: [0cc9d0ac22d02f1ba1884de5d6de9eaf8b45d82d]
stable/6.18: [55cba6b883b41e5922c00ba9d4e3262131f46f1b]
stable/6.6: [ed7a758313011885347b854e97cb95903ef3c3f7]

CVE-2026-64006: netfilter: nf_tables: fix dst corruption in same
register operation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64006

Introduced by commit 567d746 ("netfilter: bitwise: add support for
shifts.") in v5.6-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [18014147d3ee7831dce53fe65d7fc8d428b02552]
stable/6.18: [96bea2a7baac4a1137c188dc7610184487ab30a7]
stable/6.6: [b80ef316e978de2ef81d5bee9c19800b4cf96fb8]

CVE-2026-64007: netfilter: synproxy: refresh tcphdr after skb_ensure_writable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64007

Introduced by commit 48b1de4 ("netfilter: add SYNPROXY core/target")
in v3.12-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92170e6afe927ab2792a3f71902845789c8e31b1]
stable/5.10: [9902a1058992de5d95656b64a3bd95c077f7ba2c]
stable/5.15: [d3019c61799adc21811af4b521f11f3dc77f8e04]
stable/6.1: [dd206819f210522579010d889d45a9530bb494bc]
stable/6.12: [c7f945f7da097245a2f8ed7775ce48421047ee96]
stable/6.18: [f0fea2b6d5453a11ad11713bbf37561b9b3a7edf]
stable/6.6: [af2c22ccb1f621aff487ff47a040e38e058541e7]

CVE-2026-64008: accel/rocket: fix UAF via dangling GEM handle in create_bo

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64008

Introduced by commit 658ebea ("accel/rocket: Add IOCTL for BO
creation") in v6.18-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f706e6a4ce75585af979aec3dcbdce68bc76306b]
stable/6.18: [18abd88d19ea195e2e1547fca0970c2f91d77a42]

CVE-2026-64009: xfrm: Check for underflow in xfrm_state_mtu

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64009

Introduced by commit c5c2523 ("[XFRM]: Optimize MTU calculation") in
v2.6.22-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [742b04d0550b0ec89dcbc99537ec88653bd1ad90]
stable/5.10: [8014f70c4e6e5ab101ae3860a614e65e988372e3]
stable/5.15: [1021d2877b689a648b27815c854557a917122e93]
stable/6.1: [2a41b1b31c61c52b972278ce1732a1443f5e89ed]
stable/6.12: [820e501be8aee4b365d218d83227b314309c5fda]
stable/6.18: [82ac903e0b519849647657b8c48d21237ada06a2]
stable/6.6: [fccd685b32df5aaf6bad4381eeda216468e283f0]

CVE-2026-64010: nfc: llcp: Fix use-after-free race in nfc_llcp_recv_cc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64010

Introduced by commit a69f32a ("NFC: Socket linked list") in v3.6-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b493ea2765cc17cb8aa7e7544a4b6dcb05b6ed77]
stable/5.10: [dce85215a6c7b0fd753f577a4c487f647119884c]
stable/5.15: [bd08bb7443c501d2f2a71d529e4afcf11c9b07d2]
stable/6.1: [0b45c31746e1523d5d482fda8fcf54a35ac417f1]
stable/6.12: [ad8a27d63cac96bac441edd002209ebd996e12fb]
stable/6.18: [650bdd8fdfab64a09ee474150313dbc48c374795]
stable/6.6: [ee2d1a8a1833c5e56e9a1745e64b0b4edda732c2]

CVE-2026-64011: nfc: llcp: Fix use-after-free in llcp_sock_release()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64011

Introduced by commit b401123 ("NFC: llcp: Fix non blocking sockets
connections") in v3.11-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f4268b466190dae95a7585f69b4f1f8ad097632c]
stable/5.10: [89ba026747019ee643d29407435ddc118e6ca908]
stable/5.15: [fb29f6bbe433f3decad227588809636c25f2a287]
stable/6.1: [2dfdaaf7d933b676124aadec6698825e95f94fe9]
stable/6.12: [cdc17e09a636c7f936f771902535a7515a7608fc]
stable/6.18: [912ebc49d4406a17fe73e5671d674fbc2f6b2634]
stable/6.6: [e00f50f8697724a6f1d2d35744c1332c9912dac5]

CVE-2026-64012: net/sched: sch_sfb: Replace direct dequeue call with
peek and qdisc_dequeue_peeked

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64012

Introduced by commit e13e02a ("net_sched: SFB flow scheduler") in v2.6.39-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1b9bc71153b01dbde8045b9edede4240f4f5520e]
stable/5.10: [e5ea51e5f3fbba41d50cd84a530f33bc1c8f4d57]
stable/5.15: [1e70274d3b81de28973bcdbce40a512bcb181ff9]
stable/6.1: [e125f5980b730c67c92a30cf150ec8c3d6777318]
stable/6.12: [84bfbfc0c48731bcce74cdf4f9c497547ec525e0]
stable/6.18: [dbc560858da8b77dd9e4ef0cd93d421e0e4d7e0e]
stable/6.6: [6c153d97c100f5b282c424101d8ff63122306997]

CVE-2026-64013: ACPI: button: Fix ACPI GPE handler leak during removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64013

Introduced by commit a7e23ec ("ACPI: button: Install notifier for
system events as well") in v6.15-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe80251152fed5b185f795ef2cd9f7fe9c3162e0]

CVE-2026-64014: Input: usbtouchscreen - clamp NEXIO data_len/x_len to
URB buffer size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64014

Introduced by commit 5197424 ("Input: usbtouchscreen - add NEXIO (or
iNexio) support") in v2.6.34-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2905281cbda52ec9df540113b35b835feb5fafd3]
stable/5.10: [45c829e5eb3b974282bae50b7cca2cc891f74f0b]
stable/5.15: [e7cdcb266ba06d8480809b78ab8bb2bf8ff51ccb]
stable/6.1: [95f47331dfde243f93e679ce70bd0c24b37c683d]
stable/6.12: [103d2de9f505f56da173e43f12dba62f92620278]
stable/6.18: [0ca809ea8e0355299266c46e5f1755040aa8dcf3]
stable/6.6: [d883312061ccde8c536595998aaf687ec070077c]

CVE-2026-64015: security/keys: fix missed RCU read section on lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64015

According to the .vulnerable file, this bug was introduced by commit
b2a4df2 in v3.13-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43a1e3744548e6fd85873e6fb43e293eb4010694]
stable/6.1: [4c5d407ba3ff7f30561ff73ba1b07ed70c864edc]
stable/6.12: [5659e6923cb72f8e18e8b539109ab512455fe195]
stable/6.18: [50bb3435a5e627bfbdc52eb4536f49f88b3486b8]
stable/6.6: [cefa4265b11176c897a7d9e8e54d89e3701c5584]

CVE-2026-64016: ksmbd: fix durable reconnect error path file lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64016

Introduced by commit 1baff47 ("ksmbd: fix use-after-free in smb2_open
during durable reconnect") in v7.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [3515503322f4819277091839eed46b695096aca5]
stable/6.18: [a1a39f227c80cbf369767badc32cba2b225147d1]

CVE-2026-64017: blk-mq: pop cached request if it is usable

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64017

Introduced by commit b0077e2 ("blk-mq: make sure active queue usage is
held for bio_integrity_prep()") in v6.7-rc2.
Introduced by commit 7b4f36c ("block: ensure we hold a queue reference
when using queue limits") in v6.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [dc278e9bf2b9513a763353e6b9cc21e0f532954e]

CVE-2026-64018: net: mana: validate rx_req_idx to prevent
out-of-bounds array access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64018

Introduced by commit ca9c54d ("net: mana: Add a driver for Microsoft
Azure Network Adapter (MANA)") in v5.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b809d0409991b75a6cff846a5ac27c3062953f84]
stable/5.15: [5ddc715324badd7f2641bc177db1d027b402adae]
stable/6.1: [ff1d5af207bcea857d45fe81505f1bc4b29eaef0]
stable/6.12: [763a372d344fb12fae566d36ddb46e92454ad58c]
stable/6.18: [fa627a5eaa83fc0261f44ef3769693b886ca6e27]
stable/6.6: [01f7f893d5e1baae995beeb86cd0f3e6bb2a3b01]

CVE-2026-64019: nvme-pci: fix dma mapping leak on data setup error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64019

Introduced by commit b8b7570 ("nvme-pci: fix dma unmapping when using
PRPs and not using the IOVA mapping") in v6.17-rc1.
Introduced by commit 7ce3c1d ("nvme-pci: convert the data mapping to
blk_rq_dma_map") in v6.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bf86336e4b6cf40873fda47a7fe191446864937]

CVE-2026-64020: nvme-pci: fix dma_vecs leak on p2p memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64020

Introduced by commit b8b7570 ("nvme-pci: fix dma unmapping when using
PRPs and not using the IOVA mapping") in v6.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85686c72966c5ee637893f124ddb31a1cace7bee]

CVE-2026-64021: drm/xe/oa: Fix exec_queue leak on width check in stream open

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64021

Introduced by commit f0ed398 ("xe/oa: Fix query mode of operation for
OAR/OAC") in v6.13-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4d25342543c01310fc4e0cba7cb17c775e2421e2]
stable/6.12: [ede0dda8a3937899988a3f8826664e97c7925be4]
stable/6.18: [04ef7592eaadd9ca8f8f66e76452f73525cff819]

CVE-2026-64022: gpio: aggregator: remove the software node when
deactivating the aggregator

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64022

Introduced by commit 86f162e ("gpio: aggregator: introduce basic
configfs interface") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [61fef83f239ecace1cce716135762a2d9b7b1fc6]
stable/6.18: [3e657619cf7258cb53b1beaf0d02998297695cde]

CVE-2026-64023: gpio: aggregator: fix a potential use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64023

Introduced by commit 86f162e ("gpio: aggregator: introduce basic
configfs interface") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [30c073cab97afb31901f94de9605177b6b84367e]
stable/6.18: [ea28b286649b70618e9dd3e895812417a7712a11]

CVE-2026-64024: tcp: fix stale per-CPU tcp_tw_isn leak enabling ISN prediction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64024

Introduced by commit 41eecbd ("tcp: replace
TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field") in v6.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1bbf0ced1d9db73ac7893c2187f3459288603e0d]
stable/6.18: [e47f7060eaf60894e3e4d0e3c4fe6e1f2eacfbdd]

CVE-2026-64025: bpf, skmsg: fix verdict sk_data_ready racing with ktls rx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64025

Introduced by commit ef56592 ("bpf, sockmap: Allow skipping sk_skb
parser program") in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ddf8029623a1af20e984c040e89ff918158397ab]
stable/6.12: [7c8cf21bc4efb4af18d6096db3f8bd06d622251c]
stable/6.18: [1861d369efd62d67796563bf3e01fc22e5626f8b]
stable/6.6: [c9ea01768903ae47f210cd457af1dead6de7a9c3]

CVE-2026-64026: rxrpc: Fix DATA decrypt vs splice() by copying data to
buffer in recvmsg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64026

Introduced by commit d0d5c0c ("rxrpc: Use skb_unshare() rather than
skb_cow_data()") in v5.3-rc7.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d2bc90cf6c75cb96d2ce549be6c35efa3099d25b]
stable/6.12: [b94a6ccbaf1104dd980150a65fdeb2f69d17d2f5]
stable/6.18: [46cb765e2e5ad52303ea157e10d370bb6b7acbbf]
stable/6.6: [a05bf6d9e621fa71e89ccebe3047ba45218d7b38]

CVE-2026-64027: net: shaper: rework the VALID marking (again)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64027

Introduced by commit 93954b4 ("net-shapers: implement NL set and
delete operations") in v6.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8d7519352ba8c6df83259295d4a3bad093cae90]
stable/6.18: [2417df5e7bb4184b9d3a2988036bf2c46e594545]

CVE-2026-64028: tracing: Avoid NULL return from hist_field_name() on truncation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64028

Introduced by commit 5ec1d1e ("tracing: Rebuild full_name on each
hist_field_name() call") in v7.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12
stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
cip/4.19-st: [213cd4a5d711a95148e9fb763095e84cc623c5f0]
mainline: [576ec047d20b368b43c4d5db98c4f2e0f3c101ec]
stable/5.10: [e3f5d42cdc2f167719564693675f1eead81378ea]
stable/5.15: [37377b39ff86dacbc533275c1155210d4fd5dc91]
stable/6.1: [0402a1d3ddec565132867337ed44514a09d84728]
stable/6.12: [be4e99038c1603fa6b329d8ee3e364825e17c353]
stable/6.18: [d6c8b3ebdcdb12b59ad4212acb137cc56cae453d]
stable/6.6: [e91687643c440ca3997d67646e6f80b92edc6703]

CVE-2026-64029: ALSA: seq: Serialize UMP output teardown with event_input

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64029

Introduced by commit 81fd444 ("ALSA: seq: Bind UMP device") in v6.5-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [60a1969fae6209644698fca91c185d153674f631]
stable/6.12: [0cb1ad795570167558530d6194297ac2396a1991]
stable/6.18: [3aab4a58d23fb22dac5b558bbe5df1a8dad00b4b]
stable/6.6: [8ba1c4ddbb1c67d34bb440aecb9f5690ed3f64cb]

CVE-2026-64030: wifi: mac80211: bounds-check link_id in ieee80211_ml_epcs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64030

Introduced by commit de86c5f ("wifi: mac80211: Add support for EPCS
configuration") in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f718506edd2d9c6a308ded9d13c632bf7b7d5a2c]
stable/6.18: [2d8379834800c30602f24c71ab7c40f5fe84d200]

CVE-2026-64031: erofs: fix managed cache race for unaligned extents

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64031

Introduced by commit 7361d1e ("erofs: support unaligned encoded data")
in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [649932fc3815eda2f24eb4de4b3a5e94886ee0b9]
stable/6.18: [425d32d6288d7d845e486af9419bbedccd8c9103]

CVE-2026-64032: bridge: mcast: Fix a possible use-after-free when
removing a bridge port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64032

Introduced by commit 4b30ae9 ("net: bridge: mcast: re-implement
br_multicast_{enable, disable}_port functions") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [4df78ff02629c7729168f0696a7a2123c389818d]
stable/5.15: [ddefd1b8e5eb58933a697ab38334f0fd82e7fb8b]
stable/6.1: [ed3b69e60385a03df11c6d12e5d7bdf0f4a11b70]
stable/6.12: [ebe5561154c823b323bd06e350b55e0b8604d851]
stable/6.18: [a9224862d597d0eed0a34bbb27343f703fc4113f]
stable/6.6: [1900ca8acb92fbea8bf9abef9927c7fed03db7fc]

CVE-2026-64033: RDMA/rtrs: Fix use-after-free in path file creation cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64033

Introduced by commit ae4c816 ("RDMA/rtrs-srv: Rename rtrs_srv_sess to
rtrs_srv_path") in v5.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [5b74373390113fba798a76b483837029ab010fef]
stable/5.15: [01e42aabaf7632beb4bf235c7238b96c746d4144]
stable/6.1: [548f3956e53a7f7bde912d8129010b8986d5e602]
stable/6.12: [92060ab1c5115674cf319175550f85f68405121f]
stable/6.18: [eae62c5451e67e8b033c1681fd3b85d7e9a9a28f]
stable/6.6: [00904a73272b9f3ef3952fe69a833909dccad1ef]

CVE-2026-64034: net: mana: Fix TOCTOU double-fetch of hwc_msg_id from DMA buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64034

Introduced by commit ca9c54d ("net: mana: Add a driver for Microsoft
Azure Network Adapter (MANA)") in v5.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [35f0f0a2536a4d604b4dbad92c85c4a8fdebb870]
stable/5.15: [a201c66edf2ebc6cfdc3813a889ba20fecebfae3]
stable/6.1: [70ad2dff8d052a85dfef15715b531f38a29108cf]
stable/6.12: [6180a06bbc99fd9114b8db4be6c4d46e40f046ef]
stable/6.18: [09ec063d87c2dd3fa6f3561361a017bd882e9f37]
stable/6.6: [566f42fb67a7ebfed6650e407e5b72e6b3e83bf7]

CVE-2026-64035: igc: set tx buffer type for SMD frames

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64035

Introduced by commit 5422570 ("igc: add support for frame preemption
verification") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5acc641e590e008caaed480ed9ffae47cf7ecbdf]
stable/6.18: [1f83545f432d106d5fc71d3997b2d382104ebcc4]

CVE-2026-64036: cgroup/rstat: validate cpu before css_rstat_cpu() access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64036

Introduced by commit a319185 ("cgroup: bpf: enable bpf programs to
integrate with rstat") in v6.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8817005efbdfdf5d4e4814cb5dc52b53d12917d7]
stable/6.18: [6a01413a4e8fcb0263d7bef5075c5f8f4eb3a8b6]

CVE-2026-64037: wifi: iwlwifi: mld: fix TSO segmentation explosion
when AMSDU is disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64037

Introduced by commit d1e879e ("wifi: iwlwifi: add iwlmld sub-driver")
in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [92cee08dc4f00e77fd1317e4343c5d458b0abab7]
stable/6.18: [9e360e610a73f62432e986775023d5382773f045]

CVE-2026-64038: hwmon: (lm90) Stop work before releasing hwmon device

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64038

Introduced by commit f6d0775 ("hwmon: (lm90) Rework alarm/status
handling") in v6.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b09a45601094c7f4ec4db8090b825fa61e169d93]
stable/6.18: [c98107817b0f6cdf51adc5e84e75c39ee25d8b28]

CVE-2026-64039: drm/msm/snapshot: fix dumping of the unaligned regions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64039

Introduced by commit 9865948 ("drm/msm: add support to take dpu
snapshot") in v5.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [76824d2467feb1828b745d6add2541918d7be3da]
stable/5.15: [8fb070cf95847b29ef6cb15ec2c0de2bf4704676]
stable/6.1: [cecd34e046121d788a70b5c8b4f8a88916637953]
stable/6.12: [1ef79be774706dddcfcace0331fa7ff32a73c73e]
stable/6.18: [cdd1aaf0ee962f50810b9aef7928f2313989d55f]
stable/6.6: [070e40acc59ef7bedba0314f59971ba87fcc8ab0]

CVE-2026-64040: cachefiles: Fix error return when vfs_mkdir() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64040

Introduced by commit 406fad7 ("cachefiles: Fix oops in vfs_mkdir from
cachefiles_get_directory") in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a220d1c312c66194f4a33dd52d1fba42bc2b341]

CVE-2026-64041: ASoC: codecs: fs210x: fix possible buffer overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64041

Introduced by commit 7561177 ("ASoC: codecs: Add FourSemi FS2104/5S
audio amplifier driver") in v6.18-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0d435a7ebcd4e97e47673c1ab6fb27f973a053ec]
stable/6.18: [1ddf678bb75b6383c775ece61d40956c441d8a26]

CVE-2026-64042: vfio/pci: Check BAR resources before exporting a DMABUF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64042

Introduced by commit 5d74781 ("vfio/pci: Add dma-buf export support
for MMIO regions") in v6.19-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [702809dabdecca807bdd50cfdcc1c980feb2ba62]

CVE-2026-64043: ovpn: fix race between deleting interface and adding new peer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64043

Introduced by commit 80747ca ("ovpn: introduce the ovpn_peer object")
in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [982422b11e6f95f766a8cd2c2b1cbdb77e234a61]
stable/6.18: [097d62df38314c14b88fab9096f3461baf158e2b]

CVE-2026-64044: ovpn: respect peer refcount in CMD_NEW_PEER error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64044

Introduced by commit 11851cb ("ovpn: implement TCP transport") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1fef6614673ff0846d30acdeeaf3cf98bb5f6116]
stable/6.18: [8298834912d76dbc82c12b6b4ab7590ed2bb8ae5]

CVE-2026-64045: ovpn: tcp - use cached peer pointer in ovpn_tcp_close()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64045

Introduced by commit 11851cb ("ovpn: implement TCP transport") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [775d8d7ad02aa345e1588424a6a8b9ae49fb9012]
stable/6.18: [e5460eb7238c19d651a9b22b2378b587033a4095]

CVE-2026-64046: net: tls: prevent chain-after-chain in plain text SG

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64046

Introduced by commit 9aaaa56 ("bpf: Sockmap/tls, skmsg can have
wrapped skmsg that needs extra chaining") in v5.5-rc7.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ff26a0e8377dec07e4a7230db7675bed1b9a6d03]
stable/5.10: [49a5faaa471ddcd37b6893970c9916eb836e7c31]
stable/5.15: [91359966e247c0244c66d50bbb8e74aefa4321c3]
stable/6.1: [410351158dfef2d67fea6603680b3a6013c6ed9d]
stable/6.12: [929b1548e63ac72e104c07d8ee8cbbeeba2fa89a]
stable/6.18: [af855f4c966afafef74faf8390c7b86568c0d46d]
stable/6.6: [acdc12b71c9aa4be5dcd2c8062753c6d2033e235]

CVE-2026-64047: net: tls: fix off-by-one in sg_chain entry count for
wrapped sk_msg ring

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64047

Introduced by commit 9aaaa56 ("bpf: Sockmap/tls, skmsg can have
wrapped skmsg that needs extra chaining") in v5.5-rc7.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [285943c6e7ca309bbea84b253745154241d9788a]
stable/5.10: [73963a375885d5ccb7def39fd0b4f542e0f343dd]
stable/5.15: [47110c3a9ac247b688657337f5981efcfcb240dc]
stable/6.1: [84158c2997159df4a0d70cd9c46774512d32a522]
stable/6.12: [66339b71f105e6f83e0da3b9583d95077534fe1d]
stable/6.18: [eca989eab4b2599dcb02f72140a7c08f08838520]
stable/6.6: [131ef12057d92b77b636321b7849c69222405a97]

CVE-2026-64048: net/smc: reject CHID-0 ACCEPT that matches an empty ism_dev slot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64048

Introduced by commit a7c9c5f ("net/smc: CLC accept / confirm V2") in v5.10-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [277740023def559a4a2ddc3e8e784ee37a0f16a9]
stable/6.1: [6927cacf2b10d4fa80c1a2d407512ef9397c59c6]
stable/6.12: [53eb7bd09aace72fa17510d80e0caf5ca058c231]
stable/6.18: [afa9036b8c9963947b487c36e332df6a42c96fcb]
stable/6.6: [d38ba387244e5c5f7db3e11ea98bc2c7beccb0c0]

CVE-2026-64049: drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64049

Introduced by commit a452510 ("drm/msm/adreno: Switch to the common
UBWC config struct") in v6.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b4abf879360ea00a9e2b46d2d15dcdbc0687eed]
stable/6.18: [eea43d5ed45089705bc5d70971c39076962d5951]

CVE-2026-64050: drm/msm/dpu: don't mix devm and drmm functions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64050

Introduced by commit 0b37ac6 ("drm/msm/dpu: use
drmm_writeback_connector_init()") in v6.18-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0c70a11365cba7fba25a77463582bcec0f7846e]
stable/6.18: [ff58e5ef1b46ce614af048d2d04986df05ffab90]

CVE-2026-64051: accel/qaic: Add overflow check to remap_pfn_range during mmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64051

Introduced by commit ff13be8 ("accel/qaic: Add datapath") in v6.4-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa16b2bc0f02709919e2435f531406531e5bcc69]
stable/6.12: [8dd6edbe26770df147136c3f2ac976c873b82650]
stable/6.18: [97a8e89cdef36207a8776edc03d6931763a06ad0]
stable/6.6: [9baafc2fea096279e75480f93fd5942e8336b510]

CVE-2026-64052: block: bio-integrity: Fix null-ptr-deref in
bio_integrity_map_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64052

Introduced by commit 492c5d4 ("block: bio-integrity: directly map user
buffers") in v6.8-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8582792cf23b3d94674d4d838f7cde9a28d0fcaf]
stable/6.12: [77c059f41e9395793917d067476f549a911d77d3]
stable/6.18: [76410790f1491c8e06a451045ae223a61c652455]

CVE-2026-64053: block: don't overwrite bip_vcnt in bio_integrity_copy_user()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64053

Introduced by commit 3991657 ("block: set bip_vcnt correctly") in v6.11-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [637ad3a56a3b889527d1dacea6fea2a8bd648140]
stable/6.12: [d18160c9525c63c203656fefd847e94b538cd4a4]
stable/6.18: [0d48654af4d1390c888389206cc13b51b82c30e6]

CVE-2026-64054: net: shaper: reject duplicate leaves in GROUP request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64054

Introduced by commit 5d5d470 ("net-shapers: implement NL group
operation") in v6.13-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9a2fa1da619f276580b0d4c5d12efac89e8642b]
stable/6.18: [5098b223f0f0c5c18a3884a8b0ea5bd4a0c7bd75]

CVE-2026-64055: net: ethernet: cortina: Carry over frag counter

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64055

Introduced by commit 4d5ae32 ("net: ethernet: Add a driver for Gemini
gigabit ethernet") in v4.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [9c0a658066c3a24799b68565f71ab431dde3adaa]
mainline: [ebd8ec2b309e3a447851b456ccaf8fb39f3661e7]
stable/5.10: [df31e3b64455293df1ea89c7da7d5c9bfbcdd253]
stable/5.15: [7af1fabdee744b7995fe01b30b77dfc397657cb5]
stable/6.1: [75105fcf73f1ce7d9f769aaefec6e6d6645d5ac0]
stable/6.12: [7123cf481e21b54eb6adc4cb0d8dc2876aeaee41]
stable/6.18: [c373b34877afea61c89e0dd2e38948c624249b9b]
stable/6.6: [78cf08b3be47c28f07008a76c932bad7cdffa9d8]

CVE-2026-64056: net: ethernet: cortina: Make RX SKB per-port

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64056

Introduced by commit 4d5ae32 ("net: ethernet: Add a driver for Gemini
gigabit ethernet") in v4.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3a06c7204d6b5514c05692fd0c19ecf27fa5881d]
mainline: [06937db21ee311ed07eba47954447245041a982d]
stable/5.10: [27856d533eca3804008695f61c1e4d5ff984196b]
stable/5.15: [b6b22824b30e48ce1df3a2e80990f4b8505deb50]
stable/6.1: [6bba24e9ebe6f1c0b356cd471e36bdc7fa434897]
stable/6.12: [72158ea185b27afae163949b0e86164cb6b64e55]
stable/6.18: [cfd62907f3cdbc3b6da8f49ba907c0390018fe5e]
stable/6.6: [3b249988d774dacf13b203817e971934a42243c4]

CVE-2026-64057: afs: Fix the locking used by afs_get_link()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64057

Introduced by commit eae9e78 ("afs: Use netfslib for symlinks,
allowing them to be cached") in v6.14-rc1.
Introduced by commit 6698c02 ("afs: Locally initialise the contents of
a new symlink on creation") in v6.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0410adf3da6db46f3513411fcf95e63c2f1d1ad]

CVE-2026-64058: netfs: Fix netfs_read_folio() to wait on writeback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64058

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ded0c6f1606061148c202825f7e53d711f9f84cf]
stable/6.18: [f17b9121bb99f88188ec9be2db5da1d561f4c01b]

CVE-2026-64059: netfs: Fix folio->private handling in netfs_perform_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64059

Introduced by commit 8f52de0 ("netfs: Reduce number of conditional
branches in netfs_perform_write()") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccde2ac757c713535b224233a296de40efe5212d]
stable/6.12: [7f040243c74d72b45b22246c7d9e621fbeab44ac]
stable/6.18: [551b5c71ee312ca7646ddb605231c1016e8cbb18]

CVE-2026-64060: netfs: Fix leak of request in netfs_write_begin() error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64060

Introduced by commit 4090b31 ("netfs: Add a function to consolidate
beginning a read") in v5.18-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5046a34f0643441f05b0253ea64e1a3af87efe14]
stable/6.18: [22ae28aae43623be235ff455558cdd13fbe2daeb]

CVE-2026-64061: netfs: Fix early put of sink folio in netfs_read_gaps()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64061

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3e5dd91b87a8b1450217b56a336bee315f40da7d]
stable/6.12: [2a39d49c8d97df8cb8fa80c10859bc1ba7358c6b]
stable/6.18: [d4f4bc87c76511cf2532448b0fa40c25e894bd7d]

CVE-2026-64062: netfs: Fix potential deadlock in write-through mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64062

Introduced by commit 288ace2 ("netfs: New writeback implementation")
in v6.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6a4ae1634b3ad2aaa05222e53d36da532852faf]
stable/6.12: [1468f39243ccb155b6d97f9a9932f610d1205d75]
stable/6.18: [003aa0dd26c964025acd6d1213bcdbd674db2ca9]

CVE-2026-64063: netfs: Fix streaming write being overwritten

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64063

Introduced by commit 8f52de0 ("netfs: Reduce number of conditional
branches in netfs_perform_write()") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7b4dcf1b9455a6e52ac7478b4057dbe10359576d]
stable/6.12: [20195925c768626dc901a4781a51e508702c88ad]
stable/6.18: [ef9b521212e4863814ef7dfe19889abaf55ca840]

CVE-2026-64064: netfs: Fix netfs_invalidate_folio() to clear dirty bit
if all changes gone

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64064

Introduced by commit 9ebff83 ("netfs: Prep to use folio->private for
write grouping and streaming write") in v6.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [156ac2ec2ee77c44c4eb7439d6d165247ba12247]
stable/6.12: [31ba145faceb378fa01afcb8349e15ea7d95e542]
stable/6.18: [fb6ec883b48b8789e5e690dcd440d2db941e840c]

CVE-2026-64065: netfs: fix VM_BUG_ON_FOLIO() issue in netfs_write_begin() call

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64065

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dc7832d05deb4d632e8035e3299e31a3528fa0d0]
stable/6.12: [51ffb788f074c0a61953086f49008028c1e7b645]
stable/6.18: [b63971238beb79cf701dac33c6cefc56c07c89fa]

CVE-2026-64066: netfs: Fix netfs_read_to_pagecache() to pause on subreq failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64066

Introduced by commit ee4cdf7 ("netfs: Speed up buffered reading") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a8c0cfdf4658fc5b295b7fc87be56e0d76741f4]
stable/6.18: [884c4c4f35e577aba6a0593c80cbea9ca5e6e2b8]

CVE-2026-64067: netfs: Fix missing barriers when accessing
stream->subrequests locklessly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64067

Introduced by commit e2d46f2 ("netfs: Change the read result collector
to only use one work item") in v6.14-rc1.
Introduced by commit 288ace2 ("netfs: New writeback implementation")
in v6.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b5782e2d462c028096f922abca46318cec890670]

CVE-2026-64068: netfs: Fix missing locking around retry adding new subreqs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64068

Introduced by commit e2d46f2 ("netfs: Change the read result collector
to only use one work item") in v6.14-rc1.
Introduced by commit 288ace2 ("netfs: New writeback implementation")
in v6.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cce18c263e9623872327ba3c956012f73c1179cc]

CVE-2026-64069: netfs: Fix cancellation of a DIO and single read subrequests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64069

Introduced by commit e2d46f2 ("netfs: Change the read result collector
to only use one work item") in v6.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f0f7ac1915abc0d202f0eb4b003a6548a5ba60d]
stable/6.18: [5366199be46fb53de62861721d34ba816e7e440e]

CVE-2026-64070: powerpc/hv-gpci: fix preempt count leak in sysfs show paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64070

Introduced by commit 71f1c39 ("powerpc/hv_gpci: Add sysfs file inside
hv_gpci device to show processor bus topology information") in
v6.6-rc1.
Introduced by commit 1a160c2 ("powerpc/hv_gpci: Add sysfs file inside
hv_gpci device to show processor config information") in v6.6-rc1.
Introduced by commit 71a7ccb ("powerpc/hv_gpci: Add sysfs file inside
hv_gpci device to show affinity domain via virtual processor
information") in v6.6-rc1.
Introduced by commit a69a57c ("powerpc/hv_gpci: Add sysfs file inside
hv_gpci device to show affinity domain via domain information") in
v6.6-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbc30a57bd8e026995e9fa8e8c31cffd18542c01]

CVE-2026-64071: nvme-pci: fix use-after-free in nvme_free_host_mem()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64071

Introduced by commit 63a5c7a ("nvme-pci: use dma_alloc_noncontigous if
possible") in v6.13-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b35a13036755c5803168a7cb93bc66035c3e65b8]
stable/6.18: [9525e3a6fbb1d126a22ab2ee86ddea25af581a7c]

CVE-2026-64072: nvme: fix bio leak on mapping failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64072

Introduced by commit d0d1d52 ("blk-map: provide the bdev to bio if one
exists") in v6.18-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2279cd9c61a330e5de4d6eb0bc422820dd6fdf36]
stable/6.18: [fea4b46f84c50caf93c6c0f2a54b1be2edfb4491]

CVE-2026-64073: irq_work: Fix use-after-free in irq_work_single() on PREEMPT_RT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64073

Introduced by commit 8109796 ("irq_work: Allow irq_work_sync() to
sleep if irq_work() no IRQ support.") in v5.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [91840be8f710370607f949a627e070896faeddb8]
stable/6.1: [2dc79362302922cb18f35e262712b5e58de65442]
stable/6.12: [684a78183c54c23e70d1cba320f7fc184604210b]
stable/6.18: [18c0456ea2615b1a743a6db739c74411c3b42bc6]
stable/6.6: [eef4f71b46a9929ac33e968538c9dd5d96a02460]

CVE-2026-64074: fs/statmount: fix slab out-of-bounds write in
statmount_mnt_idmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64074

Introduced by commit 37c4a95 ("statmount: allow to retrieve
idmappings") in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a3bf0f28d4ba16e1f35f8c983bb04426b87e2a78]
stable/6.18: [e37ea2c6f17f273813ea4e8e94c102591d598ce1]

CVE-2026-64075: fprobe: Fix unregister_fprobe() to wait for RCU grace period

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64075

Introduced by commit 4346ba1 ("fprobe: Rewrite fprobe on
function-graph tracer") in v6.14-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [657b594b2084b39a4bc6d8493aa2140cb00cea49]
stable/6.18: [56b4cfcf1518245493c60fd39c56978f508f1816]

CVE-2026-64076: netfilter: bridge: eb_tables: close module init race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64076

Introduced by commit 5b53951 ("netfilter: ebtables: use net_generic
infra") in v5.13-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27414ff1b287ea9a2a11675149ec28e05539f3cc]
stable/6.18: [c647e2a21bbbaceda6cdb8a44a56f44d231dc4b4]

CVE-2026-64077: netfilter: ebtables: move to two-stage removal scheme

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64077

Introduced by commit 87663c3 ("netfilter: ebtables: do not hook tables
by default") in v5.15-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7f0544d86d439cb946515d2ef6a0a75e8626710]
stable/6.18: [739d5dac7b2da44a756aa4d758ee3f1ccf5a27f1]

CVE-2026-64078: netfilter: x_tables: add and use xtables_unregister_table_exit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64078

Introduced by commit fdacd57 ("netfilter: x_tables: never register
tables by default") in v5.15-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b4597d5fd7d2f8cebfffd40dffb5e003cc78964c]
stable/6.18: [86ee5bc9c0f0e652e19f395675a432de11b75514]

CVE-2026-64079: netfilter: x_tables: allocate hook ops while under mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64079

Introduced by commit f9006ac ("netfilter: arp_tables: pass table
pointer via nf_hook_ops") in v5.13-rc1.
Introduced by commit ee177a5 ("netfilter: ip6_tables: pass table
pointer via nf_hook_ops") in v5.13-rc1.
Introduced by commit ae68933 ("netfilter: ip_tables: pass table
pointer via nf_hook_ops") in v5.13-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b62eb8dcf2c47d4d676a434efbd57c4f776f7829]

CVE-2026-64080: firmware: arm_ffa: Snapshot notifier callbacks under lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64080

Introduced by commit 285a5ea ("firmware: arm_ffa: Add support for
handling framework notifications") in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38290b180a4d5746baed796d49f88d56d2f336cd]
stable/6.18: [d1e38551fadea230649bc428f0f35c9ee062a072]

CVE-2026-64081: firmware: arm_ffa: Validate framework notification
message layout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64081

Introduced by commit 285a5ea ("firmware: arm_ffa: Add support for
handling framework notifications") in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a1cc9e96b311d2609a6f963a5e35bd4ae730d97]
stable/6.18: [3c51d99449dc5a01c08a7fce6071d6721f5aac83]

CVE-2026-64082: riscv: Fix register corruption from uninitialized cregs on error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64082

Introduced by commit 4608c15 ("riscv: compat: ptrace: Add
compat_arch_ptrace implement") in v5.19-rc1.
Introduced by commit 7383ee0 ("riscv: compat: signal: Add rt_frame
implementation") in v5.19-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ebcbb53fc9bc30843054ed99fd60b8e542628f4]

CVE-2026-64083: hwmon: (pmbus/adm1266) reject short block-read
responses in the GPIO accessors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64083

Introduced by commit d98dfad ("hwmon: (pmbus/adm1266) Add support for
GPIOs") in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7232f68c43ca62f545049b7f5fbfc75137b843b]
stable/5.10: [fd9196aad9e5a3845cea17de3405ebc700382142]
stable/5.15: [ee4799becf7d2af3778007e22c2e55c4009a49c7]
stable/6.1: [c603b6c6840ac0c6285f5eefea0de6242710af21]
stable/6.12: [ae25cf2ea9ebd06d7ad416647dbdc7b5d0172946]
stable/6.18: [eb3cd9bb590460c6127145cb245be925d23f5232]
stable/6.6: [a2d1c819348b36fccbbfcf37c5fa7a50a9b4528f]

CVE-2026-64084: hwmon: (pmbus/adm1266) cap PDIO scan in get_multiple
at ADM1266_PDIO_NR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64084

Introduced by commit d98dfad ("hwmon: (pmbus/adm1266) Add support for
GPIOs") in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7834d92251baade796812876e95555e2066fa9f]
stable/5.10: [d0593e15fdeb56048a72c5c6e720f702759d0ccd]
stable/5.15: [17cee2f59029039416e8f6303050038eb59ba149]
stable/6.1: [299efd14c2eda7e5fd40025e54addd4151a01081]
stable/6.12: [b96c7f0bc0713dc6403912f6527d4ff9168d6fe6]
stable/6.18: [fa7ca363069a70b0d1aa51e8892e3095fe2ac1ec]
stable/6.6: [4d1da9a6be5a8156c532d571c2ed237169f99244]

CVE-2026-64085: hwmon: (pmbus/adm1266) bounce blackbox records through
a protocol-sized buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64085

Introduced by commit 407dc80 ("hwmon: (pmbus/adm1266) Add Block
process call") in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [43cae21424ff8e33894a0f86c6b80b840c049fd7]
stable/5.10: [7896d87cbb05e097efc113243d4e38f9f8cea16c]
stable/5.15: [9d5309500b4607b7198e19f0a3fa13eb864cd5fb]
stable/6.1: [6098634cfa711f11a8d65368dc51ec8f7c8241ba]
stable/6.12: [83e039f0a43e0708515b0479cb7690fb93faaaa0]
stable/6.18: [97a9cf2a8217ca1cdaf48cb9ab26e471632c7e7f]
stable/6.6: [60c4b9fe1a3dd012014b1f561a6928a0b5db1126]

CVE-2026-64086: hwmon: (pmbus/adm1266) include PEC byte in
pmbus_block_xfer read buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64086

Introduced by commit 407dc80 ("hwmon: (pmbus/adm1266) Add Block
process call") in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [487566cb1ccdf3756fdd7bf8d875e612ff3169bb]
stable/5.10: [397d3f523bfff2f4e3dacf9b1339bd76dc207f78]
stable/5.15: [472744f69d25a2d5111ad62f1d62579dce2c13c8]
stable/6.1: [528a9f88e88502d0c2f2052a279415074cd83715]
stable/6.12: [bd5be3fa5de6dbf61f1b3cec6b79c2c2f8065694]
stable/6.18: [2279c342d94eca225bf9f301c8806a05a1c81619]
stable/6.6: [d94ceb16e55b6d8019ab069e357c76ac42f0ffbc]

CVE-2026-64087: hwmon: (pmbus/adm1266) reject implausible blackbox record_count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64087

Introduced by commit 15609d1 ("hwmon: (pmbus/adm1266) read blackbox")
in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4afca954622d672ea65ed961bed01cf91caa034e]
stable/5.10: [adcb163ad7cacca317872fc62bd8885e842e45e3]
stable/5.15: [c2c56092710fe8a893b67b5a3d7e62808d02d84d]
stable/6.1: [5469e1e7c411acc15fdd8262c99c3ebd9defd594]
stable/6.12: [0e791cd0140fb136083565aadfbe0f705aa260d0]
stable/6.18: [75c862adf3d3caab4f49bb3530723c215376e37c]
stable/6.6: [f85c81e93dbd6915970bd5f3bffcf62633c4c54c]

CVE-2026-64088: batman-adv: tt: fix negative tt_buff_len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64088

Introduced by commit a73105b ("batman-adv: improved client
announcement mechanism") in v3.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b64cb98345b57f727bb1d978adf3b7e6b2b7086d]
cip/4.4-st: [3f4ac20e914a3a15e3d15e26b68358d9321e9e1c]
mainline: [b64963a2ceeb7529310b6cf253a1e540784422f4]
stable/5.10: [4c4c2f340f4c27373bfcac8dc5032ce7bb474e47]
stable/5.15: [33e5ede7ce6d92e531920d4bbd6d3e18ef1c6430]
stable/6.1: [3c96dff00998314983b68a3e7caac07a66ebe496]
stable/6.12: [4dab98961426d0cf6a1599cda6950b7596ca2fcd]
stable/6.18: [730de8733dd90f70d7580a9b329b971f8e1474a2]
stable/6.6: [32edd2a28e112064020a2f319a8cb8a9e5a09767]

CVE-2026-64089: batman-adv: tt: fix negative last_changeset_len

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64089

Introduced by commit a73105b ("batman-adv: improved client
announcement mechanism") in v3.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [636e1251d806b6289688aa1f4921f1623dc02d77]
cip/4.4-st: [ff9a9eb5ae396862b864afedcb5d1ba94db1e456]
mainline: [fc92cdfcb295cefa4344d71a527d61b638b7bfc4]
stable/5.10: [6314089acf0ddf64376fdc0b1420695504c73f52]
stable/5.15: [55dc41fe8821e9a849e147255ad572bc933a9d15]
stable/6.1: [c424e8519ac78eac5d9f4eecf06208a0d619ec14]
stable/6.12: [eb235472b52ef36981c5aad330485eaf2382c53b]
stable/6.18: [179eb62506a02d00370bd6478898cb632e10986c]
stable/6.6: [22d59c72f4a47ffec121d0610f70d0d70c3c11c8]

CVE-2026-64090: batman-adv: tt: avoid empty VLAN responses

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64090

Introduced by commit 7ea7b4a ("batman-adv: make the TT CRC logic VLAN
specific") in v3.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa1bd704940b5bcbc32c0b28db9167405c8ee5e0]
stable/5.10: [1f467d9a095211d3f77e8ff1bee90e73ffe01c64]
stable/5.15: [9a02c8fc963ddeecb5d8788be0740c1869fc54b7]
stable/6.1: [ea4f757641430bcc8322772e161453c4db5ecb64]
stable/6.12: [cfb30645280a2131e46cbd1b9a38cfd3ff893f12]
stable/6.18: [b93ca6012712ecab2b551e120d7c95038d6a89e5]
stable/6.6: [99f17d1cdb371cbd037975239b321f346d38f6d2]

CVE-2026-64091: batman-adv: tt: fix TOCTOU race for reported vlans

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64091

Introduced by commit 16116da ("batman-adv: prevent TT request storms
by not sending inconsistent TT TLVLs") in v4.17-rc7.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [94d27005016be15ffc638b2ecbc4d58805ad7b48]
stable/5.10: [e4236bf3ec8d6bb15d0d8d825dcf9933a7d6666b]
stable/5.15: [724a8eb4155669797c96b70d70e354284ae3b5a8]
stable/6.1: [211ea59988e1cba43cb0367ad65d379b56f9c3bd]
stable/6.12: [b4d4efd4e351593c81e9293d4b4408d244fa5ee7]
stable/6.18: [4cc85aec8d3c9ab4dc716dc9f1ed36fca16b227f]
stable/6.6: [65a1e67339aa8c95ac544b796946af388930ee23]

CVE-2026-64092: batman-adv: tp_meter: fix tp_vars reference leak in
receiver shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64092

Introduced by commit 3d3cf6a ("batman-adv: stop tp_meter sessions
during mesh teardown") in v7.1-rc4.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [77098e4bea37af51d3962efa88a5af2ea5e1ac57]
stable/5.15: [7715c73f33260af724d734c41b794457e9be8dbc]
stable/6.1: [297e1bc4a915b7cd3e65a79ed906b23fb3d7aaae]
stable/6.12: [a9f0bfd624ee8a286d6fd2bf0f796e730efb49b0]
stable/6.18: [b285bc0a97f43823a4967fb6d286de4c7f53d541]
stable/6.6: [0b1bedf114ea93fef929b31f0d70a9eedcc601de]

CVE-2026-64093: batman-adv: tp_meter: directly shut down timer on cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64093

Introduced by commit 33a3bb4 ("batman-adv: throughput meter
implementation") in v4.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5487249a81ea658717614009c8f46acc5b7101a]
stable/5.15: [00bf4bb9947b1190a8be8d9b6a1bcbfa3707785c]
stable/6.1: [74a76634055462833446684fd526d73c290ea43a]
stable/6.12: [f86b20ec8d17d77bddc02c5c86cfa2389d84ecff]
stable/6.18: [770bf0a35f0620b526fd4193889d1e77084e4c43]
stable/6.6: [5bc2d50fb66b46f86543d5153a188eb1486d0b6e]

CVE-2026-64094: batman-adv: bla: avoid NULL-ptr deref for claim via
dropped interface

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64094

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f80d3d98d2ff78d9e2fe5d68b1f45948c4f7bd24]
stable/5.10: [4f6266735a0ba6a568b6d4c9fa51c33a5a7f2d70]
stable/5.15: [53cb3511f6eda37d3bd923545fdba6013b6d7bb7]
stable/6.1: [efb62458c94db1fe3a287e7e89c31b0cfb03f938]
stable/6.12: [0f3ebd7bb417aabc44853cc7c2a184ebb0e05b45]
stable/6.18: [6921a7683ae9ad0208d829e71f725a9e25ccff49]
stable/6.6: [2a8c9e86529156c62d9187b9ed9454c31665ad33]

CVE-2026-64095: batman-adv: bla: avoid double decrement of bla.num_requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64095

Introduced by commit 2372138 ("batman-adv: add basic bridge loop
avoidance code") in v3.5-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83ab69bd12b80f6ea169c8bea6977701b53a043d]
stable/5.10: [1f013bc94154f2e78e97d0296175664224c796e0]
stable/5.15: [5328b95960774f2e189f22485616bc7b8eb2f7e3]
stable/6.1: [8ff9c59d1b7b48c2596878341a5310f32895d52b]
stable/6.12: [461f1e3dfb888701895b766446c55db2b10db705]
stable/6.18: [45384612f29692fbf0c770200361a7acff90125c]
stable/6.6: [a9393751ecf7e9096f93cb6eed02db4f79125765]

CVE-2026-64096: batman-adv: mcast: fix use-after-free in orig_node RCU release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64096

Introduced by commit ab49886 ("batman-adv: Add IPv4
link-local/IPv6-ll-all-nodes multicast support") in v3.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [089a0e2f02b7071766671e1f2cb9e2920d58c90b]
cip/4.4-st: [5409dc8ed77970e64fa6e14bf03655b4c229a795]
mainline: [20c2d6a20ca936f5aaa6dd40f73f262ac45c87cc]
stable/5.10: [ff3a4487ead475e27b43280b8ee3d8464fe280e1]
stable/5.15: [78a63fb2f7d5630d1c1f2859a20d4e4226863b41]
stable/6.1: [ced48f55bac73f0822eae90509e51b42b4f646c8]
stable/6.12: [aef897c9d2dd0d9339167fb82b62beff68d076cb]
stable/6.18: [8a3707653ab658e082ccd992e92594e01b09a3fc]
stable/6.6: [70bcb678561f0fb58f33270fc73f12f3be72b878]

CVE-2026-64097: drm/amd/display: Validate GPIO pin LUT table size
before iterating

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64097

According to the .vulnerable file, this bug was introduced by commit
ae79c31 in v4.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [86d2b20644b11d21fe52c596e6e922b4590a3e3f]
stable/6.1: [9900f6954be779011e7c2cd42addd87baf028bc5]
stable/6.12: [67461e0c15335894cc5d3b84cda823bf8cbdc886]
stable/6.18: [7ca695b3122297b06a3ed605bbe1cd32c85d9f5a]
stable/6.6: [fb30a3890d62fd50a95aef684faf64a307592e42]

CVE-2026-64098: drm/virtio: use uninterruptible resv lock for plane updates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64098

Introduced by commit 5cfd31c ("drm/virtio: fix
virtio_gpu_cursor_plane_update().") in v5.7-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9af1b6e175c82daf4b423da339a722d8e67a735a]
stable/6.1: [c86077d512ee980cc91322211d35dbcd3175f64c]
stable/6.12: [7930eee22cd3df61e85be8aa512032ab303b7167]
stable/6.18: [8fadd01cf461fee5bb11506621339c548447e5c7]
stable/6.6: [21ab64c77a30d56efc506c8fa2ad8959f8ce3d36]

CVE-2026-64099: drm/v3d: Fix use-after-free of CPU job query arrays on
error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64099

Introduced by commit 9ba0ff3 ("drm/v3d: Create a CPU job extension for
the timestamp query job") in v6.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0fe80c0b9250b35e2211bf3117e7aca814a21b0]
stable/6.12: [acd55ea40d03e06f20a9986363019e0e5173990e]
stable/6.18: [0f8efc45740b0628a787d1b0be8a0ddabd700625]

CVE-2026-64100: drm/msm: Fix shrinker deadlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64100

Introduced by commit fe4952b ("drm/msm: Convert vm locking") in v6.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3392291fc509d8ad6e4ad90f15b0a193f721cbc9]
stable/6.18: [942968260e61d4a5d7552b20814b6277f9c553df]

CVE-2026-64101: fwctl: pds: Validate RPC input size before parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64101

Introduced by commit 92c66ee ("pds_fwctl: add rpc and query support")
in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7537735028c3ad4b0bfc02ff8fa2a1a28aa04fe]
stable/6.18: [9e3f18883a98420a3b8873c6f894bc57e9b98e41]

CVE-2026-64102: RDMA/siw: Reject MPA FPDU length underflow before
signed receive math

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64102

Introduced by commit 8b6a361 ("rdma/siw: receive path") in v5.3-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ce1bc9e46ecabe84772bb561e373c0d9876d6f2]
stable/5.10: [683f7cfbf514193d63c0efa079f3352bde84c2e0]
stable/5.15: [4a331582011d9e8089af8aa2a61ec6b4443bb245]
stable/6.1: [33a8b5e971e294ec2a7b74211c545e09efd8e9ac]
stable/6.12: [c7c0c0f4379dedec12d24dbb9dded5d2db7fd9f2]
stable/6.18: [1012896f4225e8f801ff3c1648023845b66dfb11]
stable/6.6: [14553be882d9ce91749c9d64041de66e34ad8e70]

CVE-2026-64103: scsi: isci: Fix use-after-free in device removal path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64103

Introduced by commit 6f231dd ("isci: Intel(R) C600 Series Chipset
Storage Control Unit Driver") in v3.0-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0e4b32b2f1473cb0a13f692df3693d25cdca346c]
cip/4.4-st: [8ebd4a598d28ff9f84d87cf814e1d83795508525]
mainline: [b52a8d52c3125ec9a93106ed816582368de34426]
stable/5.10: [1412995e10c74644b47f242aea6e4f3d4180e806]
stable/5.15: [a83d3e4daba40d49324cec1c51ed261e1ea48cf1]
stable/6.1: [ab2266601a875982f2d2033f41e070a6d5e615e2]
stable/6.12: [cb9e72c50e6c81a5903f27e0b397ce8525d7539b]
stable/6.18: [b9ff8631006233ba246828ac70409d2cb2da38d3]
stable/6.6: [309c6058622d080fe8c2fab87c30da82d834d989]

CVE-2026-64104: virt: sev-guest: Explicitly leak pages in unknown state

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64104

Introduced by commit 3e385c0 ("virt: sev-guest: Move SNP Guest Request
data pages handling under snp_cmd_mutex") in v6.14-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd948c3f96b18ff9ba7d3e8eae13d196593e1aaf]
stable/6.18: [bee400ad4f4259c9c0758e4f1960a1eed6f6f9f0]

CVE-2026-64105: KVM: arm64: vgic: Free private_irqs when init fails
after allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64105

Introduced by commit 03b3d00 ("KVM: arm64: vgic: Allocate private
interrupts on demand") in v6.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f19c354dbd457759dfcf1195ab4bdba2bb568323]
stable/6.12: [173fb86e5519dbe7aabed1f5fa7456152a4a2e38]
stable/6.18: [7023900b4988fb6f4a59d304d878003ff562e98d]

CVE-2026-64106: KVM: arm64: vgic-its: Reject restored DTE with
out-of-range num_eventid_bits

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64106

Introduced by commit 57a9a11 ("KVM: arm64: vgic-its: Device table
save/restore") in v4.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ce754ed8e7ab4e3999767ce1505f85c449ccb07]
stable/6.1: [1716b7fea2ead941a0dfac06c4504a3437cdf00d]
stable/6.12: [b94538186a3eae3763b8f96dacd610920a865aa7]
stable/6.18: [0680f511926589206f81f57f76ce131d7741a316]
stable/6.6: [dab9f93251b2c86a033de6098d0c73afddd55d4a]

CVE-2026-64107: ASoC: codecs: pcm512x: fix null-ptr dereference in
pcm512x_overclock_xxx_put()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64107

Introduced by commit 02dbbb7 ("ASoC: codecs: pcm512x: convert to
snd_soc_dapm_xxx()") in v6.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09e8f9a9aa19aa8c1b0cc7a0ebc68f6ecf86a660]

CVE-2026-64108: cifs: Fix busy dentry used after unmounting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64108

Introduced by commit 340cea8 ("cifs: open files should not hold ref on
superblock") in v7.0-rc3.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [c68337442f03953237a94577beb468ab2662a851]
stable/6.1: [c7364cea52531534676b9f7dbc0a477c11f4c050]
stable/6.12: [f2deaa2f409a4598eaa10f2a93a676c0632af248]
stable/6.18: [5e7d9d0805e58fa3760894e73115b7a74024fd07]
stable/6.6: [bdc349a87f1fb02c18c4071858a06542bfea783d]

CVE-2026-64109: af_unix: Fix UAF read of tail->len in unix_stream_data_wait()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64109

Introduced by commit 2b51457 ("net: af_unix: implement splice for
stream af_unix sockets") in v4.2-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be309f8eae8b474a4a617eaae01324da996fc719]
stable/6.12: [38bccb927d83d7d52e5b20015a172a0b6101d11e]
stable/6.18: [acdff9907478e82208475b1151700d0b71dcdc63]
stable/6.6: [26342087fac93b3932e6af61dc91ec029cb8a623]

CVE-2026-64110: igc: fix potential skb leak in igc_fpe_xmit_smd_frame()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64110

Introduced by commit 5422570 ("igc: add support for frame preemption
verification") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e935c37b8a94bb256fada6395a5d05e1c0c6bdaf]
stable/6.18: [f1bafd35f11b3aca1c7bb38da173b8787364a04c]

CVE-2026-64111: lsm: hold cred_guard_mutex for lsm_set_self_attr()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64111

According to the .vulnerable file, this bug was introduced by commit
a04a119 in v6.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4a9b16541ad3faf8bccb398532bf3f8b6bbf1188]
stable/6.12: [82d3acee88593e3d9e71cad4b7d6b3cf70de9d07]
stable/6.18: [5b906f31e977286888a9e31282589b545b249139]

CVE-2026-64112: rbd: eliminate a race in lock_dwork draining on unmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64112

According to the .vulnerable file, this bug was introduced by commit
fd22aef in v4.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9fc75b71fdd38465c76c6f6a884cdd4ae3c72d90]
stable/6.12: [3427d7ae38337066ce88b68302e285d344ab756b]
stable/6.18: [9dcd4f5c99b491c37be90b0bd9988db48225fb75]

CVE-2026-64113: ixgbevf: fix use-after-free in VEPA multicast source pruning

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64113

Introduced by commit bad1723 ("ixgbevf: Change receive model to use
double buffered page based receives") in v3.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [540d8a7ec861cf490dc2bcdf73467428ef0ee071]
cip/4.4-st: [e495a734f5ae45ec8d40755a70425cd5e681e789]
mainline: [5d49b568c188dc77199d8d2b959c91da8cc27cf1]
stable/5.10: [3d931ac62411a7e43b85dba5fe45e1a4a91bd5cb]
stable/5.15: [6ef30384a50a50e4a484cddf341bc27de31aa3de]
stable/6.1: [55b3e91d62b2f7a24109b2d7c9f4c66d2e3b1ec1]
stable/6.12: [a244395d8c563ed1bb26c3ef708db6aeeaa08084]
stable/6.18: [dfef79e09ed2f5df975c98547f97f5d7f8982a24]
stable/6.6: [add70e2682c0ad3be2a5810bcf1bc13963ba4df9]

CVE-2026-64114: ipv4: raw: reject IP_HDRINCL packets with ihl < 5

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64114

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [42753cf1a38c18fcd85f7747f654aa1c601d5890]
cip/4.4-st: [1f1f647ed8fd63bb038ffd6bc9558c3da2ec5f24]
mainline: [915fab69823a14c170dbaa3b41978768e0fe62fc]
stable/5.10: [1065b9efa4126df559b03a849c139ecfae92cd25]
stable/5.15: [bc20dbd48c26e743f7e0845020c11ed2ce8b15ee]
stable/6.1: [5a564f737ec54d63e8ee221d3ff396d07586d464]
stable/6.12: [145e9afa5b905229b4788bb72c3255f5a5f77508]
stable/6.18: [7725cd3b471740fd23d25ed1da722c671fb2a5d3]
stable/6.6: [3c5411fa4944ed99af3d9d1de750ea8169b6dac9]

CVE-2026-64115: vsock/vmci: fix UAF when peer resets connection during handshake

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64115

Introduced by commit d021c34 ("VSOCK: Introduce VM Sockets") in v3.9-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [462a734ad6e4b46744d7f64f62a59f8c0abc941d]
cip/4.4-st: [7042ca53f417b9448d68fab910bdf8d57f489e55]
mainline: [99e22ddf4edb63dc8382bc028af928056d3450cf]
stable/5.10: [1e19f08552b90070ed18bafb1763c78297823af6]
stable/5.15: [1dd531e28f61edd286edc486ab068f135b5ae1eb]
stable/6.1: [ecda37f8faab3220da199335e42564cb7a9ad145]
stable/6.12: [47e63077605c6c2aa45b3df9847a8cdc1f1f6ef9]
stable/6.18: [440447699c681e26ed58e9c309cad718270a18b4]
stable/6.6: [cc27e989a5dfdfcfc1cca7c3be27a0c7532b46cb]

CVE-2026-64116: ipv6: ioam: add NULL check for idev in ipv6_hop_ioam()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64116

Introduced by commit 9ee11f0 ("ipv6: ioam: Data plane support for
Pre-allocated Trace") in v5.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4ea0dfd75011b78cebf3808f98ac4c4f51a6fb9]
stable/5.15: [c7e8971abd70e9d022f1c251ba2508f8dc7f2db8]
stable/6.1: [09cbfd4b81ae90963dadb1de99b63b702e73290a]
stable/6.12: [902daac307eb7e1955ce05b071950f3cba88c963]
stable/6.18: [abdd03229414b5a52943b65a60f34b84cea5ac59]
stable/6.6: [1dca7e491f070ac49b3d934f16ee953a53b37f38]

CVE-2026-64117: wifi: mac80211: capture fast-RX rate before mesh reuses skb->cb

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64117

Introduced by commit 3468e1e ("wifi: mac80211: add mesh fast-rx
support") in v6.4-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d71c841be5d9e586ee7f36c0dc8ed4db0d9a1349]

CVE-2026-64118: qed: fix double free in qed_cxt_tables_alloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64118

Introduced by commit fe56b9e ("qed: Add module with basic common
support") in v4.4-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2bccfb8476ca5f3548afbd623dc7a6980d4e77de]
stable/5.10: [9fe030719bd083b766602692ee96c8c985798e3c]
stable/5.15: [06fa8e69019fd3c41a7b0ea8c5f509c3a33dc227]
stable/6.1: [8cf5e4d2ca6b101d163c7423a426fb0aec34f7bb]
stable/6.12: [bdf678a273cadbccc347f331ae2e93ff4d14834c]
stable/6.18: [0e47fc1c9181ae029e0e35a865cbf2adcbae626c]
stable/6.6: [3904b993cc17ec5d7c5d3b57dbd0b775dafb9684]

CVE-2026-64119: l2tp: use list_del_rcu in l2tp_session_unhash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64119

Introduced by commit 89b768e ("l2tp: use rcu list add/del when
updating lists") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [979c017803c40829b03acd9e5236e354b7622360]
stable/6.12: [5e40919a40cb3e590ed45c2a54a4a2518aa88a99]
stable/6.18: [e0c3dd7b30cc5ee42ab502da140cda93d794a20b]

CVE-2026-64120: net: ethtool: fix NULL pointer dereference in phy_reply_size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64120

Introduced by commit 9dd2ad5 ("net: ethtool: phy: Convert the PHY_GET
command to generic phy dump") in v6.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4908f1395fb1b832ceec11584af649874a2732ea]
stable/6.18: [61f53c1e58d68723bc1db10912a53f1991f08719]

CVE-2026-64121: net: ifb: report ethtool stats over num_tx_queues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64121

Introduced by commit a21ee5b ("net: ifb: support ethtools stats") in v5.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5db89c99566fc4728cc92e941d8e1975711e24b5]
stable/6.1: [6afdb8113cb007f9332f59a9b7fd45731b8a9de5]
stable/6.12: [301a554e458e2f5ec47f2c336a7cb03b877f9fd6]
stable/6.18: [f8a5a76b4a683043c6eff2a060bcaa17f9316ad5]
stable/6.6: [16bd798cb6d8337d7c3eea1adc412f31b5181d5b]

CVE-2026-64122: net/mlx5e: Fix use-after-free in
mlx5e_tx_reporter_timeout_recover

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64122

Introduced by commit 83ac030 ("net/mlx5e: Fix deadlocks between
devlink and netdev instance locks") in v7.0-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [7d260c5d2d89eb2c8c528d54b576b3aae3e20231]
stable/6.18: [1604a2d68414aa4cc34faac0b7faa9c14455e8d3]

CVE-2026-64123: net: hsr: defer node table free until after RCU readers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64123

Introduced by commit b9a1e62 ("hsr: implement dellink to clean up
resources") in v5.3-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aaec7096f9961eb223b5b149abe9495525c205d9]
stable/5.10: [0ea70fb46940620848c08d9d399455c9e82fecdb]
stable/5.15: [8be6685cdd1255bcc85f9b59e4bfc313aefc5c1b]
stable/6.1: [c5580114e0492bcd2e0a37613ed4c311e3fa3d4d]
stable/6.12: [6324423a8e6591f41a16c09a8f9a84e554ac147c]
stable/6.6: [7713f4aafb577ff49fa67f0488d9c7dddc64d6ce]

CVE-2026-64124: net: devmem: reject dma-buf bind with non-page-aligned
size or SG length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64124

Introduced by commit bd61848 ("net: devmem: Implement TX path") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4eb82ba543421e9e38cc14e4e82058b78850df50]
stable/6.18: [134c517dfa63203287b2aad6558017f42435a02e]

CVE-2026-64125: net: bcmgenet: keep RBUF EEE/PM disabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64125

Introduced by commit 6ef398e ("net: bcmgenet: add EEE support") in v3.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [aec3740e12c3d9cace462bdb4b18a11aa041885d]
cip/4.4-st: [b807e916cc16765f472c19c244c503fd0964eb25]
mainline: [9a1730245e416d11ad5c0f2c100061d61cc43f60]
stable/5.10: [2040eb83f6ada148fb32dd98b943a498005d79f2]
stable/5.15: [f2782ddac82c70df313012da5f71f1f06b5553ca]
stable/6.1: [b579f3a73da7a7e74213558f4cc3d865c30aaa78]
stable/6.12: [a212fc08f5c48a16a94092bf0a9a8b7cf4483b11]
stable/6.18: [3d4ef05266ab16d8ef7dd21658a557801eb78704]
stable/6.6: [289499907399c5a9f2ed82cb34df49112bb8488f]

CVE-2026-64126: Bluetooth: MGMT: validate Add Extended Advertising Data length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64126

Introduced by commit 1241057 ("Bluetooth: Break add adv into two mgmt
commands") in v5.11-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3f7d17960ed50df3a6709c5158caff989c8c905]
stable/5.15: [0d5104390b445e7bd664ad583837e4c04d892c9d]
stable/6.1: [14b01b9cba04e6ce82825f68fc4c4322fa4ffa43]
stable/6.12: [a6c75a3fad226ccbd8ef9110dee87c92c299f2ab]
stable/6.18: [f1febe93ef075314615f970a87681d9ab86691d1]
stable/6.6: [a143ce77a5292f2c9285137433d879ce71d190a7]

CVE-2026-64127: Bluetooth: L2CAP: ecred_reconfigure: send packed pdu,
not stack pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64127

Introduced by commit 1c08108 ("Bluetooth: L2CAP: Avoid
-Wflex-array-member-not-at-end warnings") in v6.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3374ef8cf99368a40f7efd51a2a375a4c5dc6f0d]
stable/6.12: [ed5fcd2a26f0c16fc289c8cd6b03328a0582a687]
stable/6.18: [051922ab709c0a6917eae765c22481dfc68379e5]

CVE-2026-64128: Bluetooth: ISO: drop ISO_END frames received without
prior ISO_START

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64128

Introduced by commit ccf74f2 ("Bluetooth: Add BTPROTO_ISO socket
type") in v6.0-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84c24fb151fc1179355296d7ff29129ac7c42129]
stable/6.1: [1c3d1e1696b72579b970e17999c503a14535205b]
stable/6.12: [39f4a82e80c8f5ed2d6952d73fbafc895721a728]
stable/6.18: [61f2410a96dee808029e2ae4d6ef2dd635f3477f]
stable/6.6: [3af41ee7ebecb0d5c8a504861f6cfad31345310f]

CVE-2026-64129: mm/migrate_device: fix spinlock leak in
migrate_vma_insert_huge_pmd_page

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64129

Introduced by commit a30b48b ("mm/migrate_device: implement THP
migration of zone device pages") in v6.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [63451de16e0a08be40f9ab5e7c5c8f5c79676fb1]

CVE-2026-64130: mm/page_alloc: fix initialization of tags of the huge
zero folio with init_on_free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64130

Introduced by commit adfb660 ("mm/huge_memory: initialise the tags of
the huge zero folio") in v6.18-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a288a4ddb4a994490505ab5f41c445f8e6b6467]
stable/6.18: [738d18f1da3513d17b6f7bf30146cc4ac2480ffd]

CVE-2026-64131: mm/memory: fix spurious warning when unmapping
device-private/exclusive pages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64131

Introduced by commit 999dad8 ("mm/shmem: persist uffd-wp bit across
zapping for file-backed") in v5.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [be3f38d05cc5a7c3f13e51994c5dd043ab604d28]
stable/6.1: [e81446b559db4c98a6c2c5e039ac9cb23658432e]
stable/6.12: [a825691b804b35141aaf4eac91003a70846e316d]
stable/6.18: [2fff0cdd942261497fb8922a194b4da3315ae864]
stable/6.6: [e7af1b15c884ed12bb69da11aec095045d861ee8]

CVE-2026-64132: ipv6: ioam: refresh hdr pointer before ioam6_event()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64132

Introduced by commit f655c78 ("net: exthdrs: ioam6: send trace event")
in v6.9-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e46e6bc97fb1f339730ff1ba74267fbf48e7a422]
stable/6.12: [769723124b7c3b2bfea4cf68ad292698b87c8d01]
stable/6.18: [24de676da63c1122d2c13b0d546238b66d1b4e62]

CVE-2026-64133: ALSA: asihpi: Fix potential OOB array access at reading cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64133

According to the .vulnerable file, this bug was introduced by commit
719f82d in v2.6.35-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [3e269c8896330ae8f4d92893a11d6f850f7a66e1]
cip/4.4-st: [280bd8045c4fb6ccc42dcbb6a9f1449ae1ff2aa6]
mainline: [7b7d6572145c1dab2dd9bfb550b188e5f0ff3c3f]
stable/5.10: [e060e21fe9cca1e5eafd8a1c597026577771e8d9]
stable/5.15: [34d0d492a2812b9289af14bca3573a89275965b2]
stable/6.1: [ffa29cea7bf9a4ef2ea8084967f142e0301ac670]
stable/6.12: [8778386e4387b28f2bf8425d7ffc667c6294457f]
stable/6.18: [61c5017c64e2ac9e10b70b14b17a079dbc0a805f]
stable/6.6: [7b6f8c8eb93f02a74b1de8e521c0952af10d1f43]

CVE-2026-64134: ALSA: pcm: Don't setup bogus iov_iter for silencing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64134

Introduced by commit cf393ba ("ALSA: pcm: Add copy ops with iov_iter")
in v6.6-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e4d3386b74fba8e01280484b67ee481ece00201e]
stable/6.12: [ce836587e594af39ff048d9b29dee0f5f10692c9]
stable/6.18: [feff0251386aa6bb180a0a1cf7c1f91ba868113d]
stable/6.6: [41a766c647294842c9b17672449f8e011048cba9]

CVE-2026-64135: hwmon: (pmbus/adm1266) widen blackbox-info buffer to
I2C_SMBUS_BLOCK_MAX

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64135

Introduced by commit 15609d1 ("hwmon: (pmbus/adm1266) read blackbox")
in v5.10-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eee213daa1e1b402eb631bcd1b8c5aa340a6b081]
stable/5.10: [33251abb9c9dd62943be76f0427c5527ee39188f]
stable/5.15: [ba09f4baa5bd96c5d26c942defa546a72dbbe5bf]
stable/6.1: [6ed16a40b162e9d87d9ac8bed4d7f0e3e807700e]
stable/6.12: [2b7a698d5093b548c464828d984f05ced5f3fd2a]
stable/6.18: [ca560f7566df7e2826c2999e959e6b94eb938f76]
stable/6.6: [0dbf64c502443c08c2e28a77ecbfcc5479d93228]

CVE-2026-64136: smb: client: protect tc_count increment in
smb2_find_smb_sess_tcon_unlocked()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64136

Introduced by commit 96c4af4 ("cifs: Fix locking usage for tcon
fields") in v7.0-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [4d8690dace005a38e6dbde9ecce2da3ad85c7c41]
stable/6.12: [13fb413ae22a37c69341918a6d651d19a9b0b9b7]
stable/6.18: [bf4ebdb19ff9b3cdf992b50715fe61633327416a]
stable/6.6: [7df1df6f40c0720d30206aa35c0343b962350e0d]

CVE-2026-64137: smb: client: require net admin for CIFS SWN netlink

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64137

Introduced by commit fed979a ("cifs: Set witness notification handler
for messages from userspace daemon") in v5.11-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1ebfce2c1d161186a82e77590bf7da2ea1bce91]
stable/5.15: [9cf7eb8919344932f909b2fac76296f7656fda8d]
stable/6.1: [9919021a3b7974ae66a5f9915e3a48c10cfd409b]
stable/6.12: [a3238b09c58f323e40743ce174cd0ab81b5c09ed]
stable/6.18: [a8d17d22db591099519a89f14dd24810daba74c3]
stable/6.6: [969bc6370334a5b4720c5470783295d6484bbc95]

CVE-2026-64138: ksmbd: validate SID in parent security descriptor
during ACL inheritance

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64138

According to the .vulnerable file, this bug was introduced by commit
e2f3448 in v5.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [69f030cf95488ae1186c72ac8c66fd279664ea7f]
stable/6.12: [f0e5c9c663badc9982e6941322eef1cb17de0f11]
stable/6.18: [18d8db24b0a5b7be4829238dd4022236df02d421]

CVE-2026-64139: ksmbd: fix SID memory leak in
set_posix_acl_entries_dacl() on overflow

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64139

Introduced by commit 299f962 ("ksmbd: use check_add_overflow() to
prevent u16 DACL size overflow") in v7.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [af92ee994cc7f7e83a41c2025f32257a2f82a7ef]
stable/6.12: [519fb0a42ce5d7e46935577309fb282a5f2c6ea3]
stable/6.18: [0e198f09cb2a554c04de0fea4e790f1250a943ca]
stable/6.6: [9d378e17c864da08c3a4df41dae92cfa6468b00a]

CVE-2026-64140: ksmbd: fix null pointer dereference in proc_show_files()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64140

Introduced by commit b38f99c ("ksmbd: add procfs interface for runtime
monitoring and statistics") in v7.0-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [904901561e61a2b559070b20c74a8c95491f30aa]

CVE-2026-64141: ksmbd: fix null pointer dereference in compare_guid_key()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64141

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [4b83cbc4c15f09b000cc06f033f64b0824b6dc87]
stable/6.12: [0836081b394ca074d1b910f2b990ff7b4b4404c7]
stable/6.18: [cd5c1b75d2f454f625d7dc55bd3ae21d0855f6ad]
stable/6.6: [e43cb36d4d7827710cfcd48e95e29a507f0d87be]

CVE-2026-64142: ksmbd: close durable scavenger races against m_fp_list lookups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64142

Introduced by commit d484d62 ("ksmbd: add durable scavenger timer") in
v6.11-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [bf736184d063da1a552ffeff0481813599a182cc]
stable/6.12: [95f072ef934ca00711d510676b8792cbf59a5aae]
stable/6.18: [5da69a65b282d2276de22e5194ba0f88c836170c]
stable/6.6: [3a436932eb397e909d0607d76a8325abd9d85a35]

CVE-2026-64143: platform/x86: uniwill-laptop: Do not enable the
charging limit even when forced

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64143

Introduced by commit d050479 ("platform/x86: Add Uniwill laptop
driver") in v6.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [26cbe119f99c86dcb4a0136d2bc73c0c716d80e4]

CVE-2026-64144: Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64144

Introduced by commit a1c49c4 ("Bluetooth: btusb: Add protocol support
for MediaTek MT7668U USB devices") in v5.3-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd1dda6b8d6e1f4376a5b3055a04f0ecbdb4d6bd]
stable/6.12: [68c027c2003b0a8a1439d0301c59c6fd1eb3b844]
stable/6.18: [a0f5268c77eb73f84ba7c210ddfc54b1c73ff80c]
stable/6.6: [2a1905730e0c771b999906a7b509722f795563c6]

CVE-2026-64145: wifi: wilc1000: fix dma_buffer leak on bus acquire failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64145

Introduced by commit 1241c56 ("wifi: wilc1000: Fill in missing error
handling") in v6.13-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd7b6a8671939708cc4b7a46786d8c11297e8f69]
stable/6.18: [95c82d498d74c4e587db30021ca1aec90e29b5a5]

CVE-2026-64146: erofs: fix metabuf leak in inode xattr initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64146

Introduced by commit bb88e8d ("erofs: use meta buffers for xattr
operations") in v5.17-rc1.
Introduced by commit bb88e8d ("erofs: use meta buffers for xattr
operations") in v5.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [79b09c54c6563df9846ca3094bcfd72082c3e1d7]

CVE-2026-64147: pds_core: fix debugfs_lookup dentry leak and error handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64147

Introduced by commit bc90fbe ("pds_core: Rework teardown/setup flow to
be more common") in v6.8-rc3.
Fixed in v7.1-rc5.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [dc416e32baaeb620b9809e9e25fc7b30889686e9]
stable/6.12: [26e19622c485e53c3fdb299e822068a0542ddf0c]
stable/6.18: [91d13e92b983e6c6d7631012c2e20ae8057de9f2]
stable/6.6: [60ef1675b652e912f3eb064767af4432393291fd]

CVE-2026-64148: pds_core: fix error handling in pdsc_devcmd_wait

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64148

Introduced by commit 45d76f4 ("pds_core: set up device and adminq") in v6.4-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e46b6635b03d29807f810c3b415c4755a3f958d]
stable/6.12: [10ae3180095bbe2d378c5b1d6f2f2fd74dda3cc2]
stable/6.18: [784dd2bdc622ed3cc6ef8e113aa1852e252de36f]
stable/6.6: [3231aff8ab26111c54e630b1a200fc43a729dd14]

CVE-2026-64149: dma-mapping: move dma_map_resource() sanity check into
debug code

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64149

Introduced by commit f732619 ("dma-mapping: export new dma_*map_phys()
interface") in v6.18-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af0c3f05866237f7592219bfe05387bc3bfc99b5]
stable/6.18: [181e67bc11c5ec5b87c6c512c2078752b23ca8d4]

CVE-2026-64150: netfilter: nft_inner: release local_lock before
re-enabling softirqs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64150

Introduced by commit ba36fad ("netfilter: nft_inner: Use nested-BH
locking for nft_pcpu_tun_ctx") in v6.16-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6cb3ff979855f7f0ee9450a947fe8f96c2ba37a]
stable/6.18: [df19b6af171695a1352314597c9a4311d48d5171]

CVE-2026-64151: iommupt: Check for missing PAGE_SIZE in the pgsize_bitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64151

Introduced by commit dcd6a01 ("iommupt: Add map_pages op") in v6.19-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ef3f77c440005c7f04229a75976bfc078364247]

CVE-2026-64152: iommu: Handle unmap error when iommu_debug is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64152

Introduced by commit ccc2121 ("iommu: Add calls for
IOMMU_DEBUG_PAGEALLOC") in v7.0-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0735c54804c709d1b292f3b6947cfb560b2ce552]

CVE-2026-64153: drm/msm: Fix iommu_map_sgtable() return value check
and avoid WARN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64153

Introduced by commit ad8f36e ("iommu: return full error code from
iommu_map_sg[_atomic]()") in v5.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55e0f0d1c1a4ee1e46da7da4d443eb3044fb3851]
stable/5.15: [3c2cdb7c07f664b77e2a75b50793b845d5742efa]
stable/6.1: [3e3c3c95ef4fe17231a9149e27bcfc9dae2dd89f]
stable/6.12: [3457807aeb88077712f0a7cb65c3ca5120773d75]
stable/6.18: [f4e37f3df436c2bdd2621c21f9c72c8f149a221d]
stable/6.6: [7256e54583aee21e23929e7554278c2f5c1a08b1]

CVE-2026-64154: drm/msm/adreno: Fix a reference leak in a6xx_gpu_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64154

Introduced by commit 5a903a4 ("drm/msm/a6xx: Introduce GMU wrapper
support") in v6.5-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e64bca63647db1d5518198d6c5ca2dbcc66b182b]

CVE-2026-64155: wifi: ath11k: fix error path leaks in some WMI WOW calls

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64155

Introduced by commit 79802b1 ("ath11k: implement WoW enable and wakeup
commands") in v5.11-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55dda532bbc261aef495e403c8900c5e2ab5fa34]
stable/5.15: [d6c7b8d0dc22c0a8743435db8f42d98524b70df3]
stable/6.1: [cd43d587dd333517c806cd24696e6e1a26b9951e]
stable/6.12: [008955b1348452de25bc19d6e0f0f673d4cb9a3c]
stable/6.18: [acde4692afcdaea6de3e2996ddfaeaa7ae6b0130]
stable/6.6: [3d675896ea03aca631852a2a7e91e6cb8f664967]

CVE-2026-64156: netfs, afs: Fix write skipping in dir/link writepages

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64156

Introduced by commit 6dd8093 ("afs: Use netfslib for directories") in v6.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9871938f99cc6cb266a77265491660e2375271f5]
stable/6.18: [77bb293049d61e04c12b24ebbffafaf5ab36af90]

CVE-2026-64157: netfs: Fix partial invalidation of streaming-write folio

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64157

Introduced by commit cce6bfa ("netfs: Fix trimming of streaming-write
folios in netfs_inval_folio()") in v6.11-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d91acc7fb85d33ea58fca9b964a32a453937f4b]
stable/6.12: [f6b2569ae29b666fd15ff2848684c445ba442a39]
stable/6.18: [3d9601c029b934b5b6a10f99791467b10eb6b211]

CVE-2026-64158: netfs: Fix write streaming disablement if fd open O_RDWR

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64158

Introduced by commit c38f4e9 ("netfs: Provide func to copy data to
pagecache for buffered write") in v6.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70a7b9193bbbfceaab5974de66834c64ccc875dd]
stable/6.12: [9adf8e47d73d5e3c2fe77dea649dcde350ccd65c]
stable/6.18: [616578e40dcba3f94810d841c5a52b7e3bc8ede7]

CVE-2026-64159: netfs: Fix zeropoint update where i_size > remote_i_size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64159

Introduced by commit cce6bfa ("netfs: Fix trimming of streaming-write
folios in netfs_inval_folio()") in v6.11-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4543a4d737944134a1394afe797622546fbcc98a]

CVE-2026-64160: netfs: Fix potential for tearing in ->remote_i_size
and ->zero_point

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64160

Introduced by commit 4058f74 ("netfs: Keep track of the actual remote
file size") in v5.18-rc1.
Introduced by commit 100ccd1 ("netfs: Optimise away reads above the
point at which there can be no data") in v6.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2c8f4742bb76117d735f92a3932d85239b16c494]

CVE-2026-64161: net: ti: icssm-prueth: fix eth_ports_node leak in probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64161

Introduced by commit 511f6c1 ("net: ti: icssm-prueth: Adds ICSSM
Ethernet driver") in v6.18-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6635fa84403c3a59455b66007c019a7cc632db30]
stable/6.18: [994358adc0982d17731ffea7dfacd25afcc89773]

CVE-2026-64162: idpf: fix read_dev_clk_lock spinlock init in idpf_ptp_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64162

Introduced by commit 5cb8805 ("idpf: negotiate PTP capabilities and
get PTP clock") in v6.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da4f76b6a84ede14a71282ef841768299ead0221]
stable/6.18: [eb5991d4c8ba2e8153dfcda3e66a9608377b7dce]

CVE-2026-64163: test_kprobes: clear kprobes between test runs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64163

Introduced by commit e44e81c ("kprobes: convert tests to kunit") in v5.16-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef5581bb30efb939cc2bf093475c6cc85258e5cd]
stable/6.12: [accc0004c501a9918313142282b094d408af06fb]
stable/6.18: [1c24cf1fd67f6702c719ab73499392cb7af956ae]
stable/6.6: [08d355936fcf70c81c94f9fe7310450b65c53399]

CVE-2026-64164: btrfs: tracepoints: fix sleep while in atomic context
in btrfs_sync_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64164

Introduced by commit a85b46d ("btrfs: tracepoints: get correct
superblock from dentry in event btrfs_sync_file()") in v7.0-rc6.
Fixed in v7.1-rc4.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12
stable/5.10 stable/5.15 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
cip/4.19-st: [6eb52b6f2f8522da2bdda3e915f2d1d6ad20555a]
mainline: [c73370c677646e86fc4b1780fb07027bdf847375]
stable/5.10: [d78b0a80eac36879ef5478707135c446920e134b]
stable/5.15: [4361954f0e158af0530caa1e57f12b531be4658f]
stable/6.1: [6279992c9ba2774901c9d4dd4a481162e2534714]
stable/6.12: [12a0487945c09760a5968d9333383014ea294117]
stable/6.18: [c32a7e0e3c73c1c0768556a56bd78de9f7b83780]
stable/6.6: [26b2290baaf6da6add0f782a100766e686a33f4f]

CVE-2026-64165: ARM: integrator: Fix early initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64165

Introduced by commit bdb249f ("ARM: integrator: read counter using
syscon/regmap") in v4.9-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b78c5fef36d8e96c6faa95a28cd42011ba81e524]
mainline: [90d77b30a666049ad24df463f52e5d529c44e8cd]
stable/5.10: [22c738fb51f2d8b23ddff5cc0ccb2dd685bb39d3]
stable/5.15: [812103fb6da904bd03d62cf6a9826e537318ceed]
stable/6.1: [6624854554c4c2bdfed3559e5c11bb03b16e7bd1]
stable/6.12: [58a112b0973f6cd6bcb8c503d1ff88be411ed0f0]
stable/6.18: [e984dc22e2c24dc34d6728e338c82b1ce7862753]
stable/6.6: [508b1193d63b5e073a3fe103eeb785fcba2d368c]

CVE-2026-64166: firmware: arm_ffa: Check for NULL FF-A ID table while
driver registration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64166

Introduced by commit 9274307 ("firmware: arm_ffa: Ensure drivers
provide a probe function") in v5.14-rc2.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a5e695095c557d2380131b613dea4e8d90371be]
stable/5.15: [f98f131256beaddd51ad468e95d90d857fef12bf]
stable/6.1: [bc499d1acddbb75b5b4bce05f5296dd8ef9611fd]
stable/6.12: [34f59211984f66788390e7469f3e99d3796db4a8]
stable/6.18: [820245d86ce58898fb48b4fefc77d0cafc02801d]
stable/6.6: [adfff93d08a2e12ecf2a1eba272d18bc749f13c0]

CVE-2026-64167: kho: skip KHO for crash kernel

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64167

Introduced by commit d725595 ("kho: allow kexec load before KHO
finalization") in v6.19-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6715d7ec472a476db17787697a4abda62962284]

CVE-2026-64168: spi: sprd: fix error pointer deref after DMA setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64168

Introduced by commit 386119b ("spi: sprd: spi: sprd: Add DMA mode
support") in v5.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d67fffb74267772d461c02c67f1eff893ad547d]
stable/5.10: [be74e276111f3c23b8e040c8c5e308f67a573add]
stable/5.15: [a8f233fb0c7be29b97cd249f64120bf35ce72805]
stable/6.1: [0cdea166c1a07c200caf9d0b722224fca43b23ae]
stable/6.12: [b6f1acf4e57ccf708cdc0cb70f5bb5b65162963b]
stable/6.18: [be409d2bbe9ca7da7b05cc7dde7499bc481f0766]
stable/6.6: [450c319dd04d0eeff4184889768f7ada826a2e35]

CVE-2026-64169: spi: ep93xx: fix error pointer deref after DMA setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64169

Introduced by commit e79e7c2 ("spi: ep93xx: add DT support for Cirrus
EP93xx") in v6.12-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5e121a81667a83e9a01d62b429e340f5a4a84abc]
stable/6.12: [b6c0dabea07e25bd7db19a77ebfd0d02b9e2671a]
stable/6.18: [8e027db9fa310b1d5e7ad928510be800c4f004d9]

CVE-2026-64170: spi: qup: fix error pointer deref after DMA setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64170

Introduced by commit 612762e ("spi: qup: Add DMA capabilities") in v4.1-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a7e8f3efd50a165ba0189f6dc57f7e51a7d149db]
stable/5.10: [0bb3bd442f0bdad3932739a61dd6c580c9c1955e]
stable/5.15: [d577c55d189e7ae150973058d13e299b6855633f]
stable/6.1: [9e673affb92c29d9ba879bf4ea81c5e840166b56]
stable/6.12: [8f9b61d255b1e989b8913b06c8ebe0aba5e1b238]
stable/6.18: [4bb4764f2c51f03f657a28029eb0595d8223aab5]
stable/6.6: [45760b72e84c1a1498f1a8a9047184c85299da20]

CVE-2026-64171: i2c: tegra: fix pm_runtime leak on mutex_lock failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64171

Introduced by commit 6077cfd ("i2c: tegra: Add support for SW mutex
register") in v7.0-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57cf4e8d6a57dc2ef5810f4852a23ba4c71b74bb]

CVE-2026-64172: KVM: SVM: Disable AVIC IPI virtualization on Hygon
Family 18h (erratum #1235)

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64172

Introduced by commit 8de4a1c ("KVM: SVM: Disable (x2)AVIC IPI
virtualization if CPU has erratum #1235") in v6.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9a12fa5213cfc391e0eed63902d3be98f0913765]
stable/6.18: [94ade38f317ea086a181db0e6b69c574b3b70a5e]

CVE-2026-64173: tracing: Do not call map->ops->elt_free() if elt_alloc() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64173

Introduced by commit 2734b62 ("tracing: Add per-element variable
support to tracing_map") in v4.17-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [b154ce6905e52272b8c03f6d80ce684a1d358a06]
mainline: [8f0f5c4fb9df0e19a341e0c6ed8dc4fda9124f03]
stable/5.10: [49332e49ad5b20262cc719b03d4123b9362de701]
stable/5.15: [b559a218eece132de0c58d444877b5627cbee524]
stable/6.1: [b427e9f6d81c9341cba23ef92f860f99f830d91d]
stable/6.12: [1a150947f8480262a46c860f1acb9c6597ca7097]
stable/6.18: [798183376d9d3e278a270ea0e75a5769c8f145d9]
stable/6.6: [f383cff9fb382139980bac1bcd3f3f5d59f68435]

CVE-2026-64174: wifi: cfg80211: advance loop vars in cfg80211_merge_profile()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64174

Introduced by commit fe806e4 ("cfg80211: support profile split between
elements") in v5.2-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7666dbb1bacc4ba522b96740cba7283d243d16e1]
stable/5.10: [5817e1e5205498a5df66eba2b34e817f4210fd0f]
stable/5.15: [cedbb608494ba1e7a5c6c56b7f1d3fd470094f28]
stable/6.1: [c0bc4c8bd556cbe036a5b9ed333c0aab9aadfcb8]
stable/6.12: [67915715fd3874057457363c87c63e18829527df]
stable/6.18: [6cfae4914439878b8acb35c7e3b40096eeb2ad9c]
stable/6.6: [1ced0f5a851f9cae274545a42a06c459b7fd8881]

CVE-2026-64175: wifi: iwlwifi: mld: stop TX during firmware restart

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64175

Introduced by commit d1e879e ("wifi: iwlwifi: add iwlmld sub-driver")
in v6.15-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2becb38a3e217ef2b2f42fddd7db7a25905ec291]
stable/6.18: [dc31c69476520bb4c2a208211a8d3c310a62c4d0]

CVE-2026-64176: wifi: iwlwifi: mvm: fix driver-set TX rates on old devices

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64176

According to the .vulnerable file, this bug was introduced by commit
3592c00 in v6.18-rc6.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fb84b5cbcaab3ca0f4e961d92a40ed7f3aac483b]
stable/6.18: [6fe92651b44fd3cfc8dcfdaad0e82885c384dada]

CVE-2026-64177: phonet/pep: disable BH around forwarded sk_receive_skb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64177

Introduced by commit 9641458 ("Phonet: Pipe End Point for Phonet Pipes
protocol") in v2.6.28-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7b98b1005e507456797512f78400ef4578efc520]
cip/4.4-st: [df8938ff5ed30498620ad9d44888c83cea716de1]
mainline: [dbc81608e3a653dea6cf403f20cae35468b8ab9c]
stable/5.10: [f08c45076e4fd8b0adbc5eb186d6e6a3e7350d7b]
stable/5.15: [b2606c302d7f2b4ee48da05e32ed60aed1b0cd53]
stable/6.1: [02c04df84de709060f63e1d52ec67488c4f6f212]
stable/6.12: [bd795f106b3889fb0706c6e4831c4b27e2b5666b]
stable/6.18: [84bc87beb4cd77670939b446326788e4c9b3db37]
stable/6.6: [8420aa4900417797323dd567ba9d1512280c2dc3]

CVE-2026-64178: Bluetooth: bnep: Fix UAF read of dev->name

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64178

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [ea3587015b7aab1f7bd8fd4135026df71d3513fb]
cip/4.4-st: [4b16f3d58575454ccffb4c6af7c870c6514b5be3]
mainline: [59e932ded949fa6f0340bf7c6d7818f962fa4fd2]
stable/5.10: [a75bbcb10cb21acc169b785e9804f57d97873a9c]
stable/5.15: [4907596f25b1720fa948371ac5f6c1f8da10a5bc]
stable/6.1: [915a92182e2cda9cd7d2479020a44c6eda986f7c]
stable/6.12: [b21805258d7e926adfd455fc820a447b90da3b82]
stable/6.18: [5506aec795135cdd4cbf4e845929155663b25055]
stable/6.6: [fe69f634b076ae3ca81c5a5b845d9bba527036f7]

CVE-2026-64179: net: wwan: iosm: fix potential memory leaks in ipc_imem_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64179

Introduced by commit 3670970 ("net: iosm: shared memory IPC
interface") in v5.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c5d93b2c40355e999715262a824965aac025a427]
stable/5.15: [f1a4d57847813fae42fbb7eb35f2dd48b9cff8a9]
stable/6.1: [ba6d8643019c33428f7c0658863e80e0b04a70f4]
stable/6.12: [583fd5a8fc797c8ecf2e1a7b923740c5e5734e85]
stable/6.18: [ffb6dbb49c96be82f07c7b112e3ebc3e6fdd8dd5]
stable/6.6: [6f63a60580ebdd9a1f22f89a84814d1fefe16b1c]

CVE-2026-64180: mm/memory_hotplug: fix memory block reference leak on remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64180

Introduced by commit 6b8f079 ("mm/memory_hotplug: split
memmap_on_memory requests across memblocks") in v6.8-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [93866f55f7e292fe3d47d36c9efe5ee10213a06b]
stable/6.12: [b8ab30c79fc00147125b9c39f928561d9dd13d06]
stable/6.18: [09ce923071e7852ece60d7368e05249bf32c7967]

CVE-2026-64181: mm: fix __vm_normal_page() to handle missing support
for pmd_special()/pud_special()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64181

Introduced by commit af38538 ("mm/memory: factor out common code from
vm_normal_page_*()") in v6.18-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c0c6ccd9828c3a1950623b546fa57292a77b5c73]
stable/6.18: [62153767e8fc3889bc6508e9ffe927aaf64c4334]

CVE-2026-64182: drivers/base/memory: fix memory block reference leak
in poison accounting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64182

Introduced by commit 5033091 ("mm/hwpoison: introduce per-memory_block
hwpoison counter") in v6.2-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03a2cc1756a0570f887d624cd6c535ea0cbd4951]
stable/6.12: [ce60d9452a0f2effa72fd20ea270c59ca691d455]
stable/6.18: [24840b3139d7415144b81e4f9f4c44670d15bed9]
stable/6.6: [686b4283f82cd630fafd7ca9b03dfc080b3ec8fa]

CVE-2026-64183: efi: Allocate runtime workqueue before ACPI init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64183

Introduced by commit 5894cf5 ("acpi/prmt: Use EFI runtime sandbox to
invoke PRM handlers") in v6.6-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [13c6da02e767152c9ac4330962247a5e47011035]
stable/6.12: [6996e954ae830f5b793ba6cf449885ca519dbdd2]
stable/6.18: [c32a1fbe0f9a48453a552bb315cc4f1e7a74084e]
stable/6.6: [29cd94e678fcb3c4fd0f359deeac6d61334323fc]

CVE-2026-64184: mm/damon/sysfs-schemes: call missing mem_cgroup_iter_break()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64184

Introduced by commit 29cbb9a ("mm/damon/sysfs-schemes: implement
scheme filters") in v6.3-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d4e7b5c4cc353f154d5ab8bb2e1ce7714d77a6e9]
stable/6.12: [30a361be33f3793b9ecbd10ab7be6d0564819b79]
stable/6.18: [302e02f9ba49f81418ec2a749ae6f5cac1d424e9]
stable/6.6: [082351f9d40007414ad6af062b3a26fa02fd4b5f]

CVE-2026-64185: sysfs: don't remove existing directory on update failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64185

Introduced by commit c855cf2 ("sysfs: Fix internal_create_group() for
named group updates") in v4.19-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [4efdeb01074eeda129af946903aa515ebb67c3e0]
cip/4.4-st: [72bbcc601c34b6bcc976a0e0f60be1a56dab7ad9]
mainline: [237557b8a81ab948e8332f7c0058e758f081c0a3]
stable/5.10: [c5e125c828b701afaf7493b42a14aa89362ff36d]
stable/5.15: [ccadd32cc1263802a5969c9efe0e96225450428c]
stable/6.1: [14f2c14ae86c4af17a0a9f8ab46dacf2d5fd1d8a]
stable/6.12: [57b285e0368290aa55f79ba11419b96d0ebdb418]
stable/6.18: [48fa96538bd2868034d33429e4565fda384d0736]
stable/6.6: [31527d80234caf83dc96ad478645e57df9de4472]

CVE-2026-64186: iommu/amd: Remove latent out-of-bounds access in IOMMU debugfs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64186

Introduced by commit 7a4ee41 ("iommu/amd: Add debugfs support to dump
IOMMU MMIO registers") in v6.17-rc1.
Fixed in v7.1-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8dfd3d8d74435344ee8dc9237596959c8b2a6cbe]
stable/6.18: [488d2c76bd9f78433a70690d1054bfae3d39a407]

CVE-2026-64187: xfs: fail recovery on a committed log item with no regions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64187

Introduced by commit 89cebc8 ("xfs: validate transaction header length
on log recovery") in v4.3-rc1.
Fixed in v7.2-rc4.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2094dab19d45c487285617b7b68913d0cc0c1211]
stable/6.12: [d50b1fd066d66ceb548ba43e332cfe8a47e5e55a]
stable/6.18: [d98f22d2e11e0a36493aeb25b2933571ee90d9a4]
stable/7.1: [cccbabeb9a18fcb978d76d6047f2b59214aa7749]

CVE-2026-64188: net: qualcomm: rmnet: fix endpoint use-after-free in
rmnet_dellink()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64188

Introduced by commit ceed73a ("drivers: net: ethernet: qualcomm:
rmnet: Initial implementation") in v4.14-rc1.
Fixed in v7.1-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d00c953a8f69921f484b629801766da68f27f658]
stable/5.10: [c4e676c3505c5058922dc1a6f1ded795f6758135]
stable/5.15: [9918698cf3aee4032e12bb42fd5a951dc465339b]
stable/6.1: [310b93246bfec7d4452507e0c15477377ed9f025]
stable/6.12: [41e06fcc5df0774d212e70c5b503fc769492bce3]
stable/6.18: [8b17adf6d4fb6bf61fa4c3f58366a7c082799a71]
stable/6.6: [1078ae8175777e80c9637996fb4a46c55f0ce576]

CVE-2026-64189: netfilter: ipset: fix race between dump and ip_set_list resize

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64189

Introduced by commit 8a02bdd ("netfilter: ipset: Fix calling ip_set()
macro at dumping") in v4.20-rc2.
Fixed in v7.2-rc2.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [7cd9103283b26b917360ec99d7d2f2d761bcf1ab]
stable/6.12: [ff86ea9b7fdf70564e60436fbee68c96bc459943]
stable/6.18: [81d54c766337b923eec26da0a13406760b091093]
stable/7.1: [e8ee198bbc04a32d336e79160fde980e0235b39f]

CVE-2026-64190: net: team: fix NULL pointer dereference in team_xmit
during mode change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64190

Introduced by commit 3d249d4 ("net: introduce ethernet teaming
device") in v3.3-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25fe708bbc59289d3d1ea4b126fbc1b460a072a5]
stable/6.18: [03e9405c518c4d61f28079492f252d6d4e2bac5c]

CVE-2026-64191: i2c: stub: Reject I2C block transfers with invalid length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64191

Introduced by commit 4710317 ("i2c-stub: Implement I2C block support")
in v2.6.33-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6036b5067a8199ba7a2dc7b377d4b9dd276d5f9e]
stable/5.10: [7e9072dbd5f2f17934751873450d2c22080ead80]
stable/5.15: [21e87f336ac6303fed54a69b1d0d79a23b25c8d0]
stable/6.1: [3fd225f3e4cd67ec8ddab1afed9da03c7c43537c]
stable/6.12: [4bd8635f28c135a08aac6badcd7d9b5cdb34335f]
stable/6.18: [5f4d2bd028ebb6e4c09a9d64842546022321d4a7]
stable/6.6: [1c4ffe6b4f04365485ed58d64c9bb86b46fc9037]

CVE-2026-64192: bpf: Reject BPF_MAP_TYPE_INODE_STORAGE creation if BPF
LSM is uninitialized

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64192

Introduced by commit 8ea6368 ("bpf: Implement bpf_local_storage for
inodes") in v5.10-rc1.
Fixed in v7.2-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6f0643e4f63cfaa0d5d4a69de4f132eac4b8fe4]
stable/7.1: [c76b8abce575e0c6e4096957220b4515ed847d89]

CVE-2026-64205: i2c: i801: fix hardware state machine corruption in error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64205

Introduced by commit 1f760b8 ("i2c: i801: Call i801_check_pre() from
i801_access()") in v6.3-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [10dd1a736d557e310a77117832874729a0175d57]
stable/6.18: [bb5133a7d5f3fe5c387770e25f2e00e682ce11ed]
stable/7.1: [00904687b9c5527d569d9a1ca72119823e735a61]

CVE-2026-64206: Bluetooth: L2CAP: cancel pending_rx_work before taking
conn->lock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64206

Introduced by commit 7ab56c3 ("Bluetooth: Fix deadlock in
l2cap_conn_del()") in v3.16-rc3.
Fixed in v7.2-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2641a9e0a1dd4af2e21995470a21d55dd35e5203]
stable/6.18: [d5616beb3355b5fca2280d796c1cf7ada4ee6551]
stable/7.1: [e96fbac8d3a73b0bc165383c092a30628561d320]

CVE-2026-64207: net/sched: dualpi2: fix GSO backlog accounting

Announce: https://www.cve.org/CVERecord?id=CVE-2026-64207

Introduced by commit 8f9516d ("sched: Add enqueue/dequeue of dualpi2
qdisc") in v6.17-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05ed733b65ab977dd931e7f7ac0f62fdb81205c2]
stable/6.18: [c4b70c1512b8f9f33f23c2c8196dfd1210207681]
stable/7.1: [806586e33891066487db1f002be3d455cda6b516]

CVE-2026-64600: xfs: resample the data fork mapping after cycling ILOCK

Announce: no reference


Introduced by 3c68d44 ("xfs: allocate direct I/O COW blocks in
iomap_begin") in v4.11-rc1. Fixed in v7.2-rc4.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f4acd0fcd862e22eab45690ec2c08c80b6ef2e7]
stable/6.12: [e705d81a7193dd19e69b8e2bad4696d78a4ea075]
stable/6.18: [206c09b04dc5469c7ff14d8aceff2d47c88078d9]
stable/7.1: [44f891bc088958399eec27f7604928694aa35581]


* Updated CVEs

CVE-2025-21807: block: fix queue freeze vs limits lock order in sysfs
store methods

stable/6.12 was fixed.

Fixed status
stable/6.12: [1645cd7fd42c236c952e9228badcac4fea1829ea]

CVE-2026-45945: iommu/vt-d: Fix race condition during PASID entry replacement

stable/6.18 was fixed.

Fixed status
stable/6.18: [4718007870547e1efebbdd6745d9fce58f008fef]

CVE-2026-46093: mm/vmalloc: take vmap_purge_lock in shrinker

stable/6.12 was fixed.

Fixed status
stable/6.12: [c15ff206ba78820bf2873d0c668a882e99f4b631]

CVE-2026-53027: fs/ntfs3: fix missing run load for vcn0 in
attr_data_get_block_locked()

stable/6.12, stable/6.18 were fixed.

Fixed status
stable/6.12: [d68a14450783ecc5fddae957ac4e1c546dfcfb73]
stable/6.18: [08fad5d5a26cc55c0ecb68ac59ba3be5e31f4147]

CVE-2026-53226: gpio: rockchip: fix generic IRQ chip leak on remove

stable/6.12 was fixed.

Fixed status
stable/6.12: [50c7a6d2bf179588ba2daee97be93d19c96a94af]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

