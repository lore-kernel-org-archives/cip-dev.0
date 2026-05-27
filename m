Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC8CCD4F54
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 22:27:03 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.32633.1779920821864843801
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 15:27:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=P/AYxcI4;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.42, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-65c2cd216c9so10412995d50.3
        for <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 15:27:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779920821; cv=none;
        d=google.com; s=arc-20240605;
        b=MyP+41RUGqIUeP5AI+6a8YlsxvvesFCgafNGzW+y1waWvuUz4i1sTswr8oonN8ddmN
         bZ9Vh3uIEVzPIUcRb7uAric7KEqmHsiR5zgSCtjLJabnuPmbyFU3J2ZohmlqePAp1ab0
         uaiNcktzQ26LD2k6+XZlt+s4V/d2uCXLeqyd6fi1od1RJ4ofAGJl0FnChyzARW0LoD08
         BtPz+jIF4wJSnFjXSQjFdwGwuOMTW1CvO8Gicx61y916RMhmFlfBn+HmmHFKgAyGAnHd
         ybi9h1dWDkwBrlkmpDaAukg5Dj9pT+xVw2EG3Fa6YIJNurgeumQfkZPqR7/Dg7wqhLdW
         zv3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=JzA2X5VM4YL8rwbFVQuwX8FiPQqoIFnTQ6icQipXXWc=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=iMTSqBcgS0nE7VQZTAuTxlWwTYhC903guW2yWLZKiLbuwRu4/4v4wa2R8Jt9gkL/d4
         kMIM11w6wxL/u4DwtVk8g11/mVyb63T2Hr7oMTe8zoync8z6hR0NLNDYx3XAKYVZo/lO
         K4NtOgrbJh3dY1C6NUjdzB6GYD4xjE226yo8pGmqmjA8FEvj0xfjO42lNdTepivQYAHo
         Xpjd6I14TZ4JFPmLRM2wqJM3oudre7/CSruhg65F5JWP7YOR/5DxK/WFuYeAPprIUz2P
         e8s7fuj7pYpRnC1akmumzVNZbfKSFMsK/PsqgPeE26L9uaoW67aJ45NeUzFr23m85fjm
         zh0A==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1779920821; x=1780525621; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzA2X5VM4YL8rwbFVQuwX8FiPQqoIFnTQ6icQipXXWc=;
        b=P/AYxcI44VQMG69SpIfsy1wRHodbBm5SzJ0UWhLAMlZ16Fdk+o7FSDtQLlVR30dODY
         4Ax290y6+JpKBQWhrvSnEAVIzDjD7AyQMSWk3Qabs5L/BkIpJuSpJy8DhAr9Cgg/9E1n
         EJXJzBBh/9/YuD/cm/mpI2Z2alXjBfIpe0zium3HFuqnwTbFEGwyTnyBSFQ9+bCrOMdb
         3g2HIVOzfdvyFca56eXyO6wPExFLgqA/ZVsOsQFLplePMj3dXwhEgQXNtoLjQEagyi/o
         5/mCu+jcthFcyR2M8YWa+pUy87ZkqpwfSyd5UYqtwXCrK0AT9GIx/+YekmGQwkRWKKFb
         OZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779920821; x=1780525621;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzA2X5VM4YL8rwbFVQuwX8FiPQqoIFnTQ6icQipXXWc=;
        b=j/lFcwZ3oP6y56mm1wVbVeI8mYPIi0xsiPBwyLST6+kaOu3JbX1DkUxRnP/nXinZY/
         8ldBgaO38+PL6+gMKaVNQygU+BHI2aJXo95KWR2vzEdWymhFWRXqwhqKsQt6zQrbhePo
         K0ni57gjEcYOdocQAV8Nl0JIuKT+HpEf+sirzlw5DXEu0bkRA3HrV3+AmUk+/e4B5aHN
         13aqz8vGDTiN0ws0dSIrusunb5gpEHhIq0DQHZ0y3g/ki2Yx9zrfj350uC/QSdGnoCvF
         eXpZssfMeDyrW77xQMK98YL3cJueegnUoMexIS7W4SPeWCm5S0zcC+dRBuOjBFbgYm9t
         OVJw==
X-Gm-Message-State: AOJu0Yx8jJDXKlfjDuMdS0Aj4GdkocszYC1uU0IEBcIzY7Ibi2IMnaks
	OA0t9G9YsNqNGkLRf+ixBUy7PuslyxSjs5dyVFt/MMKtLbUlgn0h+B1bGglmTAoTLprcjTq6B42
	o1VePnOxyhvdzeJf4IkHwyTvyN43uSFB5GIBjkwYvAMZQNzs/iHd50D5qhA==
X-Gm-Gg: Acq92OFNxohgpaBmBfdPbuHMG2Meu2ili5Vi9xq69Rwn11qohaMIRAZMxh0enekvzvD
	oXCtiHadWl3H3Ff69Uvjg8aqW63EBY0XacbUm8Rub9IXZ6ZUP88YC9JR3H2PrNckeKO4atFBbG4
	C3I/GMkq2doS6mMFngzj/W0wOPctPz/4q85K91gqp0lfdFjaK9b6Cm3PJi1JxQAN7vuQMejTFr4
	QqDI3FyxKAY2TMcHqfjsQiiYrv6rSFvxxp8LIVVUQ8seGcMDaedTgiDmfD2PNM/rfigly5Oza0/
	pa5Bab5j73YdJffqpi4=
X-Received: by 2002:a05:690e:1589:20b0:650:16fb:e7e0 with SMTP id
 956f58d0204a3-65ec961abb8mr18481888d50.12.1779920818284; Wed, 27 May 2026
 15:26:58 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 28 May 2026 07:26:21 +0900
X-Gm-Features: AVHnY4LiLUMp3x0KKCvXoxswmiC9JtfWTPqAMwiSxF18qICur4xbVVHWx6OQyGM
Message-ID: <CAODzB9rK-_TSKrBMR+cMp7v2dEz0vrckW-UzoGWZDFWaJRJ83g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 22:27:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23028

Hi!

It's this week's CVE report.

This week reported 288 new CVEs and 8 updated CVEs.

CVE-2026-43494 is known as PinTheft.

* New CVEs
CVE-2026-43494: net/rds: reset op_nents when zerocopy page pin fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43494

Introduced by commit 0cebacc ("rds: zerocopy Tx support.") in v4.17-rc1.
Fixed in v7.1-rc4.
This bug as known as PinTheft.
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e174929793195e0cd6a4adb0cad731b39f9019b4]
stable/6.12: [0bbbff00a15b1df2cac9014d6cf4b6890f473353]
stable/6.18: [640e37f58f991546a87540d067279c2c1fa9fe51]
stable/6.6: [9115669faedccdda100428e2d26fd0aac8c50799]
stable/7.0: [290e833d1acb1093bc121fcdc97f5e6161157479]

CVE-2026-43495: net: wwan: t7xx: validate port_count against message
length in t7xx_port_enum_msg_handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43495

Introduced by commit da45d25 ("net: wwan: t7xx: Add control port") in v5.19-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0e7c074cfcd9bd93765505f9eb8b42f03ed2a744]
stable/6.12: [9855e063e063158cc5bded576382599dc3133202]
stable/6.18: [2b56d7903ab804481f5233a259d5f341e9fd513c]
stable/6.6: [f94450ce5053b36002995b72d1fa1db3bb08c5bf]
stable/7.0: [dd4f4c93c1488d7100b9964f2da4c8b3c29652f1]

CVE-2026-43496: net/sched: sch_red: Replace direct dequeue call with
peek and qdisc_dequeue_peeked

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43496

Introduced by commit 77be155 ("pkt_sched: Add peek emulation for
non-work-conserving qdiscs.") in v2.6.29-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [458d5615272d3de535748342eb68ca492343048c]
stable/6.12: [ce051eede433f876d322ac3550a36a3c6fc4c231]
stable/6.18: [8d09618840b99ef00154d3e731ce9b11e096196d]
stable/6.6: [36aa34f42cb6842cf371f3a2d3e855d24fd57a50]
stable/7.0: [587dcf970a525f543d8b5855d9f37a4ca97b76ef]

CVE-2026-43497: fbdev: udlfb: add vm_ops to dlfb_ops_mmap to prevent
use-after-free

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43497

According to the .vulnerable file, this bug was introduced by commit
7433914 in v4.19-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8de779dc40d35d39fa07387b6f921eb11df0f511]
stable/6.12: [18dd358de72d57993422cbb5dfb29ccd74efe192]
stable/6.18: [da9b065cedfd3b574f229d5be594e6aa47a27ae6]
stable/6.6: [4f312c30f0368e8d2a76aa650dff73f23490b5e7]
stable/7.0: [a2c53a3822ee26e8d758071815b9ed3bf6669fc1]

CVE-2026-43498: accel/ivpu: Disallow re-exporting imported GEM objects

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43498

Introduced by commit 5755796 ("accel/ivpu: Add support for userptr
buffer objects") in v6.19-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7dd57d7a6350770dfc283287125c409e995200e0]
stable/7.0: [3756043dd695bba34cc728cdc5688dcb49ac8043]

CVE-2026-43499: rtmutex: Use waiter::task instead of current in remove_waiter()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43499

Introduced by commit 8161239 ("rtmutex: Simplify PI algorithm and make
highest prio task get lock") in v2.6.39-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3bfdc63936dd4773109b7b8c280c0f3b5ae7d349]
stable/6.12: [6d52dfcb2a5db86e346cf51f8fcf2071b8085166]
stable/6.18: [3fb7394a837740770f0d6b4b30567e60786a63f2]
stable/6.6: [8a1fc8d698ac5e5916e3082a0f74450d71f9611f]
stable/7.0: [88614876370aac8ad1050ad785a4c095ba17ac11]

CVE-2026-43501: ipv6: rpl: reserve mac_len headroom when recompressed SRH grows

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43501

Introduced by commit 8610c7c ("net: ipv6: add support for rpl sr
exthdr") in v5.7-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9e6bf146b55999a095bb14f73a843942456d1adc]
stable/6.12: [4babc2d9fda2df43823b85d08a0180b68f1b0854]
stable/6.18: [c261d07a80576dc8ccf394ef8f074f8c67a06b37]
stable/6.6: [8e8be63465a5e80394c70324603dfea1bfdad48f]
stable/7.0: [7398ebefbfd4f8a31d4f665a4213302fa995494b]

CVE-2026-43502: net/rds: handle zerocopy send cleanup before the
message is queued

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43502

Introduced by commit 0cebacc ("rds: zerocopy Tx support.") in v4.17-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [44b550d88b267320459d518c0743a241ab2108fa]
stable/6.12: [3abc8983b2bae3f487f77d9da5527d7d6b210d46]
stable/6.18: [14ef6fd18db2494098b21e0471bf27a1d8e9993e]
stable/6.6: [21d70744e6d3bbf9293aa1ee6fba7c53ad75275e]
stable/7.0: [0f5c185fc79a59ee9991234dd6d2a3e5afa6e75b]

CVE-2026-43503: net: skbuff: propagate shared-frag marker through
frag-transfer helpers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-43503


Introduced by cef401de7be8 ("net: fix possible wrong checksum
generation") in v3.9-rc1 and f4c50a4034e6 ("xfrm: esp: avoid in-place
decrypt on shared skb frags") in 7.1-rc3.
Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.12 stable/5.10 stable/5.15 stable/6.1
stable/6.12 stable/6.18 stable/6.6 stable/7.0

Fixed status
mainline: [48f6a5356a33dd78e7144ae1faef95ffc990aae0]
stable/5.10: [fbeab9555564a1b98e8582cd106dfe46c4606991]
stable/5.15: [179f1852bdedc300e373e807cc102cd81feff196]
stable/6.1: [12401fcfb01f53ccc63ab0a3246570fe8f3105ee]
stable/6.12: [fc6eb39c55e97df2f94ad974b8a5bbcd019da2c8]
stable/6.18: [ff375cc75f9167168db38e0464a482d5fbc8d81d]
stable/6.6: [989214c66884d70716d83dc1d0bf5e16287bf349]
stable/7.0: [9bc9d6d6967a2239aa57af2aa53554eddd640d20]

CVE-2026-45834: Bluetooth: L2CAP: Fix null-ptr-deref in
l2cap_sock_state_change_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45834

Introduced by commit 89bc500 ("Bluetooth: Add state tracking to struct
l2cap_chan") in v3.1-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2ff1a41a912de8517b4482e946dd951b7d80edbf]
stable/6.12: [c88c185ae0a1067823661b220aeea613df2c127b]
stable/6.18: [1810e42ff6716f320c7269d5850eca48b07b7427]
stable/6.6: [5105f3e6b2df619c635b5f6a49fac131a36c7952]
stable/7.0: [a2dcf1a61d056aef15b63c6eae9441344d624389]

CVE-2026-45835: Bluetooth: L2CAP: Fix null-ptr-deref in
l2cap_sock_new_connection_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45835

Introduced by commit 80808e4 ("Bluetooth: Add l2cap_chan_ops
abstraction") in v3.1-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0a120d96166301d7a95be75b52f843837dbd1219]
stable/6.12: [bc3bb9f40da8e53896abc2d29c6d0c6686fe4ab9]
stable/6.18: [741e6024e31587b0c021b6616a9e428a4ea0b64a]
stable/6.6: [ab77c8bc30269bee15d917059a66bea48909f5f0]
stable/7.0: [76083fb80f5a38ac13326b2d810f66bd07771eea]

CVE-2026-45836: Bluetooth: L2CAP: Fix null-ptr-deref in
l2cap_sock_get_sndtimeo_cb()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45836

Introduced by commit 8d836d7 ("Bluetooth: Access sk_sndtimeo
indirectly in l2cap_core.c") in v3.13-rc1.
Fixed in v7.1-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [78a88d43dab8d23aeef934ed8ce34d40e6b3d613]
stable/6.12: [58dc5e3d8768e121907608e6e196a908512fb083]
stable/6.18: [32bd343803d4ba47cc516f9d5f037f01b855d767]
stable/6.6: [cf1fd517f892ded88168df878f834b625133f86d]
stable/7.0: [a93d66907dd4d29b65c9797a93784bf61906d6d6]

CVE-2025-71303: accel/amdxdna: Fix race condition when checking rpm_on

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71303

Introduced by commit 063db45 ("accel/amdxdna: Enhance runtime power
management") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [00ffe45ece80160aef446d74ded906352f21dd72]

CVE-2025-71304: smack: /smack/doi: accept previously used values

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71304

Introduced by commit e114e47 ("Smack: Simplified Mandatory Access
Control Kernel") in v2.6.25-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [67b8493a0b33a31b1acb73d961f01e541696e587]
cip/4.4-st: [3ea6dcc4c441de72eab68fa211a2f2851a1ab28d]
mainline: [33d589ed60ae433b483761987b85e0d24e54584e]
stable/5.10: [eb718a3c8181ada679340db34cd61bce48e44749]
stable/5.15: [6ec091c5c7eeabd249a7c46813cad1e9f555f859]
stable/6.1: [199452f22d2f74b897fe826f81ec402b0a8461a0]
stable/6.12: [f8071500177f38cff38892bd85ac631cc6e010b2]
stable/6.18: [5a247a84de0ba44edbbd6be851c8a6b2aa60ff85]
stable/6.6: [1c7ee23dfcd18d80770d8f90f2ab5bb1b2bfd8a3]

CVE-2025-71305: drm/display/dp_mst: Add protection against 0 vcpi

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71305

Introduced commit is not determined.Fixed in v7.0-rc1.
Affected code was added by 4d07b0b ("drm/display/dp_mst: Move all
payload info into the atomic state") in 6.1-rc1.

Fixed status
mainline: [342ccffd9f77fc29fe1c05fd145e4d842bd2feaa]
stable/6.1: [95dbd525efce2a9e9e1c50ad15213de644c85ad0]
stable/6.12: [3f44cdb5371faf225af37d5caba8f21ec0572469]
stable/6.18: [4d2ccdea18b564e3f73e3e543854acea64e6277d]
stable/6.6: [ac9a7c329a5610051fc476644c9b9145a5965ecb]

CVE-2025-71306: ima: Fix stack-out-of-bounds in is_bprm_creds_for_exec()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71306

Introduced by commit 95b3cda ("ima: instantiate the
bprm_creds_for_exec() hook") in v6.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [377cae9851e8559e9d8b82a78c1ac0abeb18839c]

CVE-2025-71307: drm/panthor: Fix NULL pointer dereference on panthor_fw_unplug

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71307

Introduced by commit 5140725 ("drm/panthor: Support GLB_REQ.STATE
field for Mali-G1 GPUs") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [920c6af98e98e6afedf6318a75bac95af8415c6c]

CVE-2025-71308: accel/amdxdna: Fix potential NULL pointer dereference
in context cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71308

Introduced by commit be462c9 ("accel/amdxdna: Add hardware context")
in v6.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [97f27573837ef96b4ba42af463cc800cab615c0e]

CVE-2025-71309: fs/ntfs3: fix deadlock in ni_read_folio_cmpr

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71309

Introduced by commit f35590e ("fs/ntfs3: remove ntfs_bio_pages and use
page cache for compressed I/O") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e37a75bb866c29da954b51d0dd7670406246d9ee]

CVE-2025-71311: fs/ntfs3: Initialize new folios before use

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71311

Introduced by commit 584f60b ("ntfs3: Convert ntfs_get_frame_pages()
to use a folio") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f223ebffa185cc8da934333c5a31ff2d4f992dc9]
stable/6.12: [dd6c81527d097b3b0bf5a15c2fdc9657d045144c]
stable/6.18: [5a30cc03bde169ad558695b26da6ea7e55f6194a]

CVE-2025-71312: fs/ntfs3: fix ntfs_mount_options leak in ntfs_fill_super()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-71312

Introduced by commit aee4d5a ("ntfs3: fix double free of
sbi->options->nls and clarify ownership of fc->fs_private") in
v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7edab0cee03a1cbe0e55a7bcab8d2d8b6b74278]

CVE-2026-45837: bpf: Fix use-after-free in arena_vm_close on fork

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45837

Introduced by commit 3174603 ("bpf: Introduce bpf_arena.") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4fddde2a732de60bb97e3307d4eb69ac5f1d2b74]
stable/6.12: [723b9fa930cc277c15ce6b9ec9feec828cfac9d7]
stable/6.18: [d18099f19e53250f8ad2801498b88cec29d9107a]
stable/7.0: [201128fcc7b213d27ab77bc4e89488b41796480f]

CVE-2026-45838: bpf: fix end-of-list detection in cgroup_storage_get_next_key()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45838

Introduced by commit de9cbba ("bpf: introduce cgroup storage maps") in
v4.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5828b9e5b272ecff7cf5d345128d3de7324117f7]
stable/6.12: [85a2f30e40f7468db732f55659bc6318874f49af]
stable/6.18: [32ce55d424395904986f5066f8755f6cb9993377]
stable/6.6: [b4b5a20bed82130da2f2818f04d52378952fbd0b]
stable/7.0: [fc39753b7f92e09177777e9c648afe5aa3abb81f]

CVE-2026-45839: bpf: reject negative CO-RE accessor indices in
bpf_core_parse_spec()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45839

Introduced by commit ddc7c30 ("libbpf: implement BPF CO-RE offset
relocation algorithm") in v5.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c22483a2c4bbf747787f328392ca3e68619c4dc]
stable/6.12: [36a9012f76ba8d9189ae56a1f8bb7c87c07a1f3a]
stable/6.18: [76f2ebaf79a9ae6d0737b87f045fe769e425d78f]
stable/6.6: [3ff85ae79e1a74baeb916b78a63d821f6d19a994]
stable/7.0: [99dbab7b5a12d8f58d5b0aa2f7a1fe656a70f4b2]

CVE-2026-45840: openvswitch: cap upcall PID array size and pre-size
vport replies

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45840

Introduced by commit 5cd667b ("openvswitch: Allow each vport to have
an array of 'port_id's.") in v3.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2091c6aa0df6aba47deb5c8ab232b1cb60af3519]
stable/6.12: [f99ac36b5d7c719d08a69fcdecce40f78a874e15]
stable/6.18: [fa6e90bc443bed8dc0d55bc5ea5b27ffdfe37704]
stable/6.6: [f9ef3db77a383d66847fd082c2b437d8ae4d9c63]
stable/7.0: [1d6c02b86329883aa467a3a61f8d34369db73a2f]

CVE-2026-45841: netfilter: nfnetlink_osf: fix divide-by-zero in OSF_WSS_MODULO

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45841

Introduced by commit 11eeef4 ("netfilter: passive OS fingerprint
xtables match") in v2.6.31-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2195574dc6d9017d32ac346987e12659f931d932]
stable/6.12: [c55940895245d8ef658ab381248a28755218d625]
stable/6.18: [fb965b1cfe92b28d28b5ebe3116b81dbef9f2d2f]
stable/6.6: [8def8fbd23f40e945febe913d04b731012ce0082]
stable/7.0: [9a05e195618a6d474f2bcd5b6376d0ffc2f00366]

CVE-2026-45842: slip: reject VJ receive packets on instances with no
rstate array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45842

Introduced by commit 4ab42d7 ("ppp, slip: Validate VJ compression slot
parameters completely") in v4.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e76607442d5b73e1ba6768f501ef815bb58c2c0e]
stable/6.12: [de42f86e2cf5028a97e74c25869d1a962b13c301]
stable/6.18: [9e1ff0eead073c4f46d874ad2526b7dda5465faf]
stable/6.6: [c6980e8b1a86288167f34966fa5219031999b6f1]
stable/7.0: [7b0d9e878ec2b21d99ae8051b3dda59cdb66c152]

CVE-2026-45843: slip: bound decode() reads against the compressed packet length

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45843

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c1367a2d7aad643a6f87c6931b13cc1a25e8ca7]
stable/6.12: [4cefe32639933d652614b0bd50f818f9af4af78f]
stable/6.18: [0511ecb00e61bf28e2fec4bb41fcce385c3a3b2d]
stable/6.6: [37537e42e6df387398bee85cb85070cc80bb1e10]
stable/7.0: [d42bec6e4f6d6d658be365539400b3314b76b2a7]

CVE-2026-45844: netfilter: arp_tables: fix IEEE1394 ARP payload parsing

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45844

Introduced by commit 6752c8d ("firewire net, ipv4 arp: Extend hardware
address and remove driver-level packet inspection.") in v3.10-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e8e3f449b1e73b73a843257635b9c50f0cc0f0a]
stable/6.12: [03ea11dbefaa55c502735ee551c89ef773fe753b]
stable/6.18: [1c55053f8ffdc060006df898fd3664e3d1bfac7b]
stable/6.6: [ad9973df8e0eeb123d9ec4d18828e05b7d44ff4b]
stable/7.0: [ac698d81fd6619c7504cee913f1cab5285fba1b7]

CVE-2026-45845: net/sched: taprio: fix NULL pointer dereference in class dump

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45845

Introduced by commit 665338b ("net/sched: taprio: dump class stats for
the actual q->qdiscs[]") in v6.6-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d07ca5c0fae311226f737963984bd94bb159a87]
stable/6.12: [d02e2fbf60de46678e2ea698a6a904fd21e1cc31]
stable/6.18: [48b26d48e76221dc90b02bf5428bab53643461ca]
stable/6.6: [ec2501e361b08b50bcb1e7b3253fc861abbda28d]
stable/7.0: [8f1ff8866cb9f655e5faea6994eb902960be8e04]

CVE-2026-45846: bareudp: fix NULL pointer dereference in
bareudp_fill_metadata_dst()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45846

Introduced by commit 571912c ("net: UDP tunnel encapsulation module
for tunnelling different protocols like MPLS, IP, NSH etc.") in
v5.7-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [aa6c6d9ee064aabfede4402fd1283424e649ca19]
stable/6.12: [35a115a204be08f97450b0389413e218268ef4a2]
stable/6.18: [74a02921c48fcd35a7881956c9e5c52b86595f5d]
stable/6.6: [a0f4e4e8e0f5e24ddd83e3d1221732621cf34636]
stable/7.0: [638905520fc4fae6a80991563f264131545ba3df]

CVE-2026-45847: net: remove WARN_ON_ONCE when accessing forward path array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45847

Introduced by commit ddb94ea ("net: resolve forwarding path from
virtual netdevice and HW destination address") in v5.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [008e7a7c293b30bc43e4368dac6ea3808b75a572]
stable/5.15: [548244c2f542aa0ad49453e9306e715a3877bc44]
stable/6.1: [dcf9b3c90e5560339649d088836529883fb509f3]
stable/6.12: [959ea349c7e2d4edf07b6838ca7e59345fe61a08]
stable/6.18: [50422613185d505201167e8bdd2f2700790d5db6]
stable/6.6: [9464ca7a6e56ad1ebf48b2ad5c16871edfad10c6]

CVE-2026-45848: apparmor: fix NULL sock in aa_sock_file_perm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45848

Introduced by commit 56974a6 ("apparmor: add base infastructure for
socket mediation") in v4.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [58607749a2ec80cd5bb900e8d11b1ffeb3f6601b]
mainline: [00b67657535dfea56e84d11492f5c0f61d0af297]
stable/5.10: [68538ec34fcb4194c7961dc4eca6f5537fec8067]
stable/5.15: [5121b7283f1c46e4c06b88b1dda7b064429d77de]
stable/6.1: [c11b7c3280d000376e27ebfed17ec7046699eab4]
stable/6.12: [3852eb9a0392eb435c03dcb47d581bcfe6a9a95b]
stable/6.18: [ccb66a3c6c8f51b3ed1bc003b70bb9ff99e8d835]
stable/6.6: [0dc19bca22606f7a61d5988408f74e3ae0ef3486]

CVE-2026-45849: net: mscc: ocelot: add missing lock protection in
ocelot_port_xmit_inj()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45849

Introduced by commit c5e12ac ("net: mscc: ocelot: serialize access to
the injection/extraction groups") in v6.11-rc5.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [026f6513c5880c2c89e38ad66bbec2868f978605]
stable/6.1: [0b217a40156f497e09dd20d3f7baec40c785f386]
stable/6.12: [7ac58d8832802ec89baa7539e13e6d58a88cce04]
stable/6.18: [51c32ae7fae14552d79f7139614b77c1bbd57a48]
stable/6.6: [cc1b179f778f98270bdbbb48d183b4b6427ae198]

CVE-2026-45850: ipvs: skip ipv6 extension headers for csum checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45850

Introduced by commit 2906f66 ("ipvs: SCTP Trasport Loadbalancing
Support") in v2.6.34-rc1.
Introduced by commit 0bbdd42 ("IPVS: Extend protocol DNAT/SNAT and
state handlers") in v2.6.28-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [05cfe9863ef049d98141dc2969eefde72fb07625]

CVE-2026-45851: efi: Fix reservation of unaccepted memory table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45851

Introduced by commit 8dbe339 ("efi/unaccepted: Make sure unaccepted
table is mapped") in v6.6-rc3.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0862438c90487e79822d5647f854977d50381505]
stable/6.12: [ba6b6f1502fa55621d1db23f253d54322bdbe4e0]
stable/6.18: [9b18bf59977f5c5bc3b11b210520f62500a7adf3]
stable/6.6: [b7bc182ec1846be437351e44164089d988f9d0dd]

CVE-2026-45852: RDMA/rxe: Fix double free in rxe_srq_from_init

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45852

Introduced by commit aae0484 ("IB/rxe: avoid srq memory leak") in v4.20-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [0beefd0e15d962f497aad750b2d5e9c3570b66d1]
stable/5.10: [22b8c23a3b92d023614bb00896fe364b2c1a31d3]
stable/5.15: [af5956243018918130d52c9f671efdb40bab3366]
stable/6.1: [d286f0d4e3ad3caf5f0e673cdad7bf89bf37d947]
stable/6.12: [ce6f8e007682f378279d4cf83b240f12d52c723b]
stable/6.18: [5c07aef09a121a4cd622a71eb0753a9e135c84a8]
stable/6.6: [26793db60925df1e88a29466813d586cbc190b8c]

CVE-2026-45853: drm/amdgpu: Use kvfree instead of kfree in
amdgpu_gmc_get_nps_memranges()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45853

Introduced by commit b194d21 ("drm/amdgpu: Use NPS ranges from
discovery table") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0c44d61945c4a80775292d96460aa2f22e62f86c]
stable/6.12: [16e7e7ad8cdc6b4c4af7f31e262f1494c1b2a55e]
stable/6.18: [9ae85b0c1909b6c6bfd2636b04cdaf7f520bf2b5]

CVE-2026-45854: crypto: inside-secure/eip93 - unregister only
available algorithm

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45854

Introduced by commit 9739f5f ("crypto: eip93 - Add Inside Secure
SafeXcel EIP-93 crypto engine support") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ceeadc7b53a041d89d5843f6bf0ccb7c98b0b4f]
stable/6.18: [243d642ff5809811208fa1707b7ab8a6ab4b1d68]

CVE-2026-45855: ata: libata-scsi: avoid Non-NCQ command starvation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45855

Introduced by commit bdb0130 ("scsi: Add host and host template flag
'host_tagset'") in v5.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0ea84089dbf62a92dc7889c79e6b18fc89260808]
stable/6.12: [ce22aaed011206fed9cbd8c9c2d44718607f31ee]
stable/6.18: [888cd7e40adb2ef4af1b4d3b6e2e83ad409ae8c2]

CVE-2026-45856: RDMA/uverbs: Validate wqe_size before using it in
ib_uverbs_post_send

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45856

Introduced by commit c3bea3d ("RDMA/uverbs: Use the iterator for
ib_uverbs_unmarshall_recv()") in v5.0-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1956f0a74ccf5dc9c3ef717f2985c3ed3400aab0]
stable/5.10: [9c15ec4cd4e7f57c6bbcb4e73e99290f150dd2a7]
stable/5.15: [9b5ac1c15334d46c0dbd49d64a2257b929500163]
stable/6.1: [01c9b152647dc70dc06a4a2eff86ebb3b3c76075]
stable/6.12: [d533425ac1f2925b4fc3e4ed9b9d72362cb23475]
stable/6.18: [bf4454da8b1e712714628c0a0d6e7845bb40790a]
stable/6.6: [bf1feed1a7886af945f92890493aefd2b5c9928a]

CVE-2026-45857: scsi: csiostor: Fix dereference of null pointer rn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45857

Introduced by commit a3667aa ("[SCSI] csiostor: Chelsio FCoE offload
driver") in v3.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [df377f5b4bceaa58c90e0feeb6cfd258eed38885]
cip/4.4-st: [1b4fd0ad8c2b5da142478625aa0ec6939b698bb5]
mainline: [1982257570b84dc33753d536dd969fd357a014e9]
stable/5.10: [16ccbfddcb32365138c806cf572e69b42a193c5c]
stable/5.15: [44ef9f81392de885883f73b9f5c43936a82ae9d7]
stable/6.1: [526ea3c0ccd495b0079db3e28fdddd51c1bf01f7]
stable/6.12: [6037124dbf675fbd0a6248aaf04cf07387b8c323]
stable/6.18: [25ab5e97d3c5f3ed594b4a65d1cc99dc24756681]
stable/6.6: [25d623f0d77c11a256a54e860d00c239aa9a2583]

CVE-2026-45858: ext4: don't zero the entire extent if
EXT4_EXT_DATA_PARTIAL_VALID1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45858

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [1bf6974822d1dba86cf11b5f05498581cf3488a2]
stable/6.1: [ddf854e59166533b0f46ba32cd6cd9aca3197d1b]
stable/6.12: [d17857b4fb9ba5745b59be0ef38fd532991fccbf]
stable/6.18: [d67c8ecf3d8fda9b8ef80e6f665d84b6d6ac9d88]
stable/6.6: [58ddae5d77b1db3a27b891c75a8fa120239ac092]

CVE-2026-45859: netfilter: nfnetlink_queue: do shared-unconfirmed
check before segmentation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45859

Introduced by commit 7d8dc1c ("netfilter: nf_queue: drop packets with
cloned unconfirmed conntracks") in v6.11-rc4.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1 stable/6.6

Fixed status
mainline: [207b3ebacb6113acaaec0d171d5307032c690004]
stable/6.12: [79b713ef4261a8ead96af4703f89d0b5f25532e2]
stable/6.18: [23901aa6b8a2f294c4b774436b4691f3ff863a8f]

CVE-2026-45860: netfilter: nf_conncount: increase the connection clean
up limit to 64

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45860

Introduced by commit d265929 ("netfilter: nf_conncount: reduce
unnecessary GC") in v5.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt stable/5.10 stable/5.15

Fixed status
cip/4.19-st: [ac7a01b06c4537def10aa53afcfbfd554f416dee]
mainline: [21d033e472735ecec677f1ae46d6740b5e47a4f3]
stable/5.10: [a5c9e14e0e8923218ae881d5e78c990c07694966]
stable/5.15: [13eede458fdf231f1bf96a398feea4ad1553f14c]
stable/6.1: [fa85432d58c8e74b39333edbf8d28df2985dfc79]
stable/6.12: [3d0994ed0aa1fc0a2c5e620b765e8defdd021bff]
stable/6.18: [6e5fa7add3e76da068a478d905be64be8fa4e80a]
stable/6.6: [0792ad077d776c2dcf20f0484e2461ded1b77a24]

CVE-2026-45861: gfs2: Fix slab-use-after-free in qd_put

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45861

Introduced by commit a475c5d ("gfs2: Free quota data objects
synchronously") in v6.6-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [22150a7d401d9e9169b9b68e05bed95f7f49bf69]
stable/6.12: [ca7c67bdd293089b3483f18886d6b2d0037d2ad9]
stable/6.18: [1d47922b98046b8070a77347fb883a6523792803]

CVE-2026-45862: iommu/vt-d: Flush cache for PASID table before using it

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45862

Introduced by commit 194b334 ("iommu/vt-d: Fix PASID directory pointer
coherency") in v6.3-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
mainline: [22d169bdd2849fe6bd18c2643742e1c02be6451c]
stable/5.10: [cd75e77125c8a51754ca4cd60b4ca083ed735d1d]
stable/5.15: [0616137b70e6d9a547d4b60df8e1b64e36d83661]
stable/6.1: [36990407cdd257473607e33802d00e978af2759e]
stable/6.12: [5962c30a6f05ea1ab73f039e235bb30716243517]
stable/6.18: [36244dfd3853f7bf89d03b8e90d56b23ce7fbc16]
stable/6.6: [c93f23375d8c410954b0df825e814b632fd62b9d]

CVE-2026-45863: i3c: dw: Fix memory leak in dw_i3c_master_i2c_xfers()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45863

Introduced by commit 62fe9d0 ("i3c: dw: Add power management support")
in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2537089413514caaa9a5fdeeac3a34d45100f747]
stable/6.12: [140a45bd4f6db7d1b30cab967d29689b946c52fa]
stable/6.18: [8e71414e252c1cb235911008a98fd47927d3a55c]

CVE-2026-45864: fs/ntfs3: prevent infinite loops caused by the next
valid being the same

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45864

Introduced by commit 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27b75ca4e51e3e4554dc85dbf1a0246c66106fd3]
stable/5.15: [50c822fcb36768f1fb356f05b02a2248ef81936d]
stable/6.1: [6d93239b4fc479f7c0a412dd196ec0ca2672d14a]
stable/6.12: [b97e371e5d1c13d722335d46eb8bc1a22b272a0e]
stable/6.18: [4bf3bafb8e0635ed93e3cd4156dcbcc0fb960cb4]
stable/6.6: [71c8b966ec56e13c02388c1312910588bb49be7a]

CVE-2026-45865: mctp i2c: initialise event handler read bytes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45865

Introduced by commit f5b8abf ("mctp i2c: MCTP I2C binding driver") in v5.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2a14e91b6d76639dac70ea170f4384c1ee3cb48d]
stable/6.1: [93e01e837e105299f1c259ef71f6e1ec4fe806e3]
stable/6.12: [fa9861e5c8af7651dddfa8d490aaada17ae33b6c]
stable/6.18: [6ff2ebfef75fbc57d937d8fbe738b967edf2d331]
stable/6.6: [11f83253244060b5de5eac787f61ae3f3e559d01]

CVE-2026-45866: serial: caif: fix use-after-free in caif_serial ldisc_close()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45866

Introduced by commit 56e0ef5 ("drivers/net: caif: fix wrong
rtnl_is_locked() usage") in v3.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8adeaccc29edb61079c607ec2d9d85266605c9e8]
cip/4.4-st: [752d013b6a0d6f504fd1b2fcf732ec8ba66cb233]
mainline: [308e7e4d0a846359685f40aade023aee7b27284c]
stable/5.10: [5e266ba8d330d3b8e5bc198f238cd8901826cfa1]
stable/5.15: [d3c75db4e0460641dbcd274b40867e252d801da1]
stable/6.1: [4e63d6f68544ae5269ac9735ae5b69b59b5b8725]
stable/6.12: [52731ef4438155cea782fac74e547a327ab9e7c5]
stable/6.18: [c8c197aaa56b25a2d54f3aa07e27e228d6c08546]
stable/6.6: [331e2b7051635780edea248dd08ae2026c126f4a]

CVE-2026-45867: power: supply: act8945a: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45867

Introduced by commit a09209a ("power: supply: act8945a_charger: Add
status change update support") in v4.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [69dd2e9614e5a107217e2c84ac75281e01e7c4d7]
mainline: [3291c51d4684d048dd2eb91b5b65fcfdaf72141f]
stable/5.10: [f2a0777b1e5a3cee1712c4d3e9095c0df8fc8cb3]
stable/5.15: [0768e8525a46df103647ca5059b32320d7fd17e4]
stable/6.1: [d023ef9f748b2090f7a9dbdd5c622b6ad99088ea]
stable/6.12: [76a42ba547a9b2e2337894f67a4d9247445007d5]
stable/6.18: [f27eb76def5c07e4d7cc468b40741f19dafc83ce]
stable/6.6: [697bb5dc0cb4791e244f3970b067bc1ef33be9d9]

CVE-2026-45868: pinctrl: single: fix refcount leak in pcs_add_gpio_func()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45868

Introduced by commit a1a277e ("pinctrl: single: create new gpio
function range") in v3.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [7a9286ab1d8cc7ec18ce252f7deba61ff87d79bc]
cip/4.4-st: [a9bfc223ce08b83935b28895446c4058192db146]
mainline: [353353309b0f7afa407df29e455f9d15b5acc296]
stable/5.10: [191bfd5710d6a7f48ba4315d8d3e908dcc15243c]
stable/5.15: [3e3b28bb0b6ddc521a4fdd1c1ba0d35017a0796b]
stable/6.1: [456a60d06c09a92680dc35fabca68024badcc28e]
stable/6.12: [7814b1431848854b56717086e2b61bea3c59753d]
stable/6.18: [e2e367e56bacb93ce5ac73f0b3297d5c83d38dd4]
stable/6.6: [99cc7352156c65201c675f750e0e77c4c73d93f5]

CVE-2026-45869: power: supply: wm97xx: Fix NULL pointer dereference in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45869

Introduced by commit 7c87942 ("wm97xx_battery: Use irq to detect
charger state") in v2.6.32-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [39fe0eac6d755ef215026518985fcf8de9360e9e]
stable/5.10: [3d7b5391bb95505b3581c1fb77150c467ab92864]
stable/5.15: [438f9a303ea8b55162b2d5376490c2ab3ec165a0]
stable/6.1: [9b7d77cb046b4487e8e511e04e62b6f416ce845c]
stable/6.12: [93bdf715d33cf5ee01c58e8546c2469c71ce082a]
stable/6.18: [c0def811ad8d642dca9b6d31a198cc39f5f90837]
stable/6.6: [86183153c299e8bb1839e717286d6c6f39508a59]

CVE-2026-45870: SUNRPC: auth_gss: fix memory leaks in XDR decoding error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45870

Introduced by commit 1d65833 ("SUNRPC: Add RPC based upcall mechanism
for RPCGSS auth") in v3.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [0ed31afc1d3baaead365e35e33f348703a32bfc5]
cip/4.4-st: [5d389fb9be0fd4d56c833f911ead53fb6a7929c5]
mainline: [3e6397b056335cc56ef0e9da36c95946a19f5118]
stable/5.10: [c81431b1b9fbd21e9a5a9211b5517b7295d18e6a]
stable/5.15: [caf7eff432e91a9eba1c79fa545c2f54be15d62b]
stable/6.1: [64303b92d94c0c7845a273acd8d84b796d6f1db7]
stable/6.12: [b4af3806846778799cd4ab0766dc18341e777264]
stable/6.18: [d79b9097a6a2b91471b40755f1225364be5d85ff]
stable/6.6: [df10f23defff22c8d55fe6db74f6e4ce927145bf]

CVE-2026-45871: tpm: st33zp24: Fix missing cleanup on get_burstcount() error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45871

Introduced by commit bf38b87 ("tpm/tpm_i2c_stm_st33: Split
tpm_i2c_tpm_st33 in 2 layers (core + phy)") in v4.1-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [d3808c5bd98013c299246f260d3b195a94ebd990]
cip/4.4-st: [d6f8587801d1d313ba51bc6405091dd6ac75c3f9]
mainline: [3e91b44c93ad2871f89fc2a98c5e4fe6ca5db3d9]
stable/5.10: [e0ce3da82341fcd6194175f1837946b2a894c625]
stable/5.15: [7687133509cf66ced120b667fefd21f80bf17993]
stable/6.1: [1256c6dc96d1e687e6e9b63088156ed07411b00c]
stable/6.12: [cc09d55f519e15355de343264a22ac6682b8305e]
stable/6.18: [ec15eb67fe9df87981b4829b901ec254273ca483]
stable/6.6: [a51cff9be046e13e1c1b2fe45d5c48b582ec9b8c]

CVE-2026-45872: scsi: smartpqi: Fix memory leak in pqi_report_phys_luns()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45872

Introduced by commit 28ca6d8 ("scsi: smartpqi: Add extended report
physical LUNs") in v5.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41b37312bd9722af77ec7817ccf22d7a4880c289]
stable/6.1: [f471ecfec093e39ef8fd08978413793087daa14d]
stable/6.12: [d52e13122d3771f753dd73ae6512fa01f58015cb]
stable/6.18: [e5579ebaadc7b699868dad0f591a7bf83cd647e1]
stable/6.6: [fdf1188cfa80f88c9f18d58cb33d57ff40e70e26]

CVE-2026-45873: netfilter: nft_set_rbtree: check for partial overlaps
in anonymous sets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45873

Introduced by commit c9e6978 ("netfilter: nft_set_rbtree: Switch to
node list walk for overlap detection") in v6.2-rc6.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt stable/5.10 stable/5.15 stable/6.1

Fixed status
cip/4.19-st: [80109d2147a5dbf1d105b2de6c2d047fa254b5fa]
mainline: [4780ec142cbb24b794129d3080eee5cac2943ffc]
stable/5.10: [7ca5813e1b21ef300e04593f47b073ef3217aac6]
stable/5.15: [029e5f6a95e905b12d6bc20421be32a01e0eb311]
stable/6.1: [f1381ce0a1dd013610985e1c4260908163a427df]
stable/6.12: [05feaf826390fd16f1deb89dd9412def3b2a280f]
stable/6.18: [dad14d22dff1a191612acb98facceb303d0524a2]
stable/6.6: [f1535d56fc3f6c625b7e0559c006bd0318791bb1]

CVE-2026-45874: phy: freescale: imx8qm-hsio: fix NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45874

Introduced by commit 82c56b6 ("phy: freescale: imx8qm-hsio: Add
i.MX8QM HSIO PHY driver support") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4dd5d4c0361af0a3fd24f45c815996abf4429770]
stable/6.12: [a771b386cb6c6e582e7b50f8eeff3347ff887f71]
stable/6.18: [dd8b9ba3d9701832cfb5dcefd8b43250df28dbc2]

CVE-2026-45875: mfd: arizona: Fix regulator resource leak on
wm5102_clear_write_sequencer() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45875

Introduced by commit 1c1c6bb ("mfd: wm5102: Ensure we always boot the
device fully") in v4.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [99d6d4af05d1cff91669f51a38555a2519917fd6]
cip/4.4-st: [cf221582edac9ffee401e1f4452912dd3fda9e08]
mainline: [4feb753ba6e5e5bbaba868b841a2db41c21e56fa]
stable/5.10: [54eafc1b0dbcf79c5f8b6dc8d9e92e56b9384c0a]
stable/5.15: [933c5463873582baaecf5c38401ec4095b1c6269]
stable/6.1: [445cec7b4fbb1546836ae8e332d158e8d37d0fb6]
stable/6.12: [e0527c09bcf1e6beeb685a7f4177683866b8609c]
stable/6.18: [5a4923726a165593d7601834a6fb2a10ab47b85d]
stable/6.6: [3ea01691738b0decb63ea2705d2cdf27f6f26fc0]

CVE-2026-45876: arm64/gcs: Fix error handling in arch_set_shadow_stack_status()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45876

Introduced by commit b57180c ("arm64/gcs: Implement shadow stack
prctl() interface") in v6.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [53c998527ffa60f9deda8974a11ad39790684159]
stable/6.18: [c787a235deb33be6eda40beee8f561da5fd8cb8c]

CVE-2026-45877: HID: intel-ish-hid: fix NULL-ptr-deref in
ishtp_bus_remove_all_clients

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45877

Introduced by commit 3703f53 ("HID: intel_ish-hid: ISH Transport
layer") in v4.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [56f7db581ee73af53cd512e00a6261a025bf1d58]
stable/6.12: [0b605e8ce60698c27a26f512968a597fd620d2e8]
stable/6.18: [feb4bcfd405282de60aba321f13a1272b30c5af4]

CVE-2026-45878: drm/amdkfd: Fix watch_id bounds checking in debug
address watch v2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45878

Introduced by commit e0f85f4 ("drm/amdkfd: add debug set and clear
address watch points operation") in v6.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a19302cab5cec7ae7f1a60c619951e6c17d8742]
stable/6.12: [a0d367e13db63a6ed76ee0d0a8c3a58c1fa98488]
stable/6.18: [2b36c0c1bcbbe15f6cfa9652084b3124c835a150]
stable/6.6: [971bf8e61e9b4abaacf9b35eaf76ec222758f9d6]

CVE-2026-45879: power: supply: bq25980: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45879

Introduced by commit 5069185 ("power: supply: bq25980: Add support for
the BQ259xx family") in v5.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5f0b1cb41906e86b64bf69f5ededb83b0d757c27]
stable/5.10: [86f93dfb23f5bf4f285c4256a7e909d222f7de56]
stable/5.15: [16875e3b7bc9e59bfa0acaf1e43f275a6f42a30f]
stable/6.1: [0560a4b09c92e2ecaa883965cf6f9ca51c158ff9]
stable/6.12: [4aeaf03c17260415c2fdd55992f9ad4188d5455a]
stable/6.18: [03d1e4ee4e6aa6d2966e883e4ca0e5be73bf1b7c]
stable/6.6: [0de95d29d847c6217b7d5845e24a71a4aee7b359]

CVE-2026-45880: PCI/P2PDMA: Release per-CPU pgmap ref when
vm_insert_page() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45880

Introduced by commit 7e9c7ef ("PCI/P2PDMA: Allow userspace VMA
allocations through sysfs") in v6.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6220694c52a5a04102b48109e4f24e958b559bd3]
stable/6.12: [51b7181cfbedf289ce794b6d97a1c596c309ec38]
stable/6.18: [e19cce88ec4c4877f4ff2469099b9cf23cc3e93e]
stable/6.6: [baa42b756d183a59572f3890981a3d32b8d05d40]

CVE-2026-45881: soc: mediatek: svs: Fix memory leak in svs_enable_debug_write()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45881

Introduced by commit 13f1bbc ("soc: mediatek: SVS: add debug
commands") in v6.0-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6259094ee806fb813ca95894c65fb80e2ec98bf1]
stable/6.1: [47a3e372f7d68776adb749a27c0ec9058ff1b4fd]
stable/6.12: [a58c97828911c0b6e25d6b556789da974003efda]
stable/6.18: [0f6498077faa9cd89bb787bcc57063494a6f0601]
stable/6.6: [06195456c4e4de3826c4ca60eca941c472f991d0]

CVE-2026-45882: power: supply: pm8916_bms_vm: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45882

Introduced by commit 098bce1 ("power: supply: Add pm8916 VM-BMS
support") in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62914959b35e9a1e29cc0f64cb8cfc5075a5366f]
stable/6.12: [b69bb88e20c6f8e998dff3e13a316207f49d3fa2]
stable/6.18: [a8b7117ae3a791c6a328674d05a06cd45d8241bd]

CVE-2026-45883: iio: sca3000: Fix a resource leak in sca3000_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45883

Introduced by commit 9a4936d ("staging:iio:accel:sca3000 Tidy up probe
order to avoid a race.") in v4.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [91162fef1c9622debca91c953860c0b5057fa3bf]
mainline: [62b44ebc1f2c71db3ca2d4737c52e433f6f03038]
stable/5.10: [55e13abf22c27a3b0ab5cf941dd07a2d9786736c]
stable/5.15: [40c860ece22542178cddcf01b08644bcdbc597b3]
stable/6.1: [597d749c5180f3e351837e851a6131b140324e9f]
stable/6.12: [103ac8e3a7f345a0966ef582b8a874ac31a92c7c]
stable/6.18: [517d9f2b963089b3d64c23accf7920d77f5a30c8]
stable/6.6: [e8e960c3d23fdb4882d70d34ce762368da0f1427]

CVE-2026-45884: apparmor: avoid per-cpu hold underflow in aa_get_buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45884

Introduced by commit ea9bae1 ("apparmor: cache buffers on percpu list
if there is lock contention") in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [640cf2f09575c9dc344b3f7be2498d31e3923ead]
stable/6.12: [202824a1f89a9786c20a3d646a7c88d223abb1b2]
stable/6.18: [80c334acc6d0bee8605a358a33e69b4aea1ffb92]

CVE-2026-45885: power: supply: cpcap-battery: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45885

Introduced by commit 874b2ad ("power: supply: cpcap-battery: Add a
battery driver") in v4.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [642f33e34b969eedec334738fd5df95d2dc42742]
stable/5.10: [c549dd3de4b3f6e726d1b8386d40ccf7d3abdbe4]
stable/5.15: [3ff75cba1c98349a23a8f9333981deba1972cc11]
stable/6.1: [2ce2334be155bd8bad6377e99984246ce4dbd08c]
stable/6.12: [f3fbe309c9bfe1aac1e2b26543e9dc4829f3275a]
stable/6.18: [2841bbb5a35c4449c0a0458e8e476b2a62f95147]
stable/6.6: [cbb9b07f88a9ef6518934c41eb3e8cf840d657d5]

CVE-2026-45886: bpf: Fix bpf_xdp_store_bytes proto for read-only arg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45886

Introduced by commit 3f36422 ("net: xdp: introduce bpf_xdp_pointer
utility routine") in v5.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6557f1565d779851c4db9c488c49c05a47a6e72f]
stable/6.1: [ffb5d1c5e3933b947fc7303ad68bf0c536d0c85e]
stable/6.12: [0db169a91381a473b7974021d1c02f8da72c5775]
stable/6.18: [d7b87adeb0eb539b9b824b101bb14fb01e41240b]
stable/6.6: [ddc34a1b85505c919026ddc82fafdada9a160b15]

CVE-2026-45887: af_unix: Fix memleak of newsk in unix_stream_connect().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45887

Introduced by commit fd0a109 ("net, pidfs: prepare for handing out
pidfds for reaped sk->sk_peer_pid") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6884028cd7f275f8bcb854a347265cb1fb0e4bea]
stable/6.18: [365996a2b14d07caa9e33d367b67ea26c09d89b4]

CVE-2026-45888: md/raid1: fix memory leak in raid1_run()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45888

Introduced by commit 97894f7 ("md/raid1: use the atomic queue limit
update APIs") in v6.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6abc7d5dcf0ee0f85e16e41c87fbd06231f28753]
stable/6.12: [c94fd6e8a71efd047ff36930e840f3c25679e136]
stable/6.18: [ec10e3dc93994b87adf7c759a4639fe34013989a]

CVE-2026-45889: mptcp: do not account for OoO in mptcp_rcvbuf_grow()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45889

Introduced by commit e118cdc ("mptcp: rcvbuf auto-tuning improvement")
in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b329393502e5857662b851a13f947209c588587]
stable/6.18: [fb7bf00b04a6b48859f52035d4e745848c2b4c79]

CVE-2026-45890: xen-netback: reject zero-queue configuration from guest

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45890

Introduced by commit 8d3d53b ("xen-netback: Add support for multiple
queues") in v3.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [311d876e64a13a1022c983bcab20679c7c106ef6]
cip/4.4-st: [9859c4a4b50d2859e8a98e3116f9c1e61ab60114]
mainline: [6d1dc8014334c7fb25719999bca84d811e60a559]
stable/5.10: [2993e0f904c45f8af12917344bb1cac7ccd05a60]
stable/5.15: [787bfa423228c4b02ba3368128f625d579085353]
stable/6.1: [ce66d6786de45b7ed9cbbdc0988054bf09e58f54]
stable/6.12: [ec4859ac5c933e3315543a61adc1ca4358006a41]
stable/6.18: [654780dee9eae419e1648ea58462c4efe54518fa]
stable/6.6: [88b0fced1bbbfdb356a007592604008ffc93a6a1]

CVE-2026-45891: net: hns3: fix double free issue for tx spare buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45891

Introduced by commit 907676b ("net: hns3: use tx bounce buffer for
small packets") in v5.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6d2f142b1e4b203387a92519d9d2e34752a79dbb]
stable/5.15: [fb6a4c376d454b425555b1b0bda36e99f56ec307]
stable/6.1: [43015461662d41dcfb3bb95fadd8a2a42ad8eacf]
stable/6.12: [d2c785733dfb853ea0b53984c75662a1af230a94]
stable/6.18: [fdbccddb7e7822016601829f95de4008e193f7bc]
stable/6.6: [6dc10494cfe27b6f1e9adb7e293293ae39c50b7c]

CVE-2026-45892: ext4: drop extent cache after doing PARTIAL_VALID1 zeroout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45892

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [6d882ea3b0931b43530d44149b79fcd4ffc13030]
stable/6.1: [9e79460b3aae6bbf33f5ccea6c44bf2eefa45daf]
stable/6.12: [d8ee559fccdef713f058cfe5f2c03dc9b18be3b1]
stable/6.18: [c2ee51d684adca7645e4aa74adca13f6750390bc]
stable/6.6: [f0931a5c17005a0c4fc35bd1a001245effc3354b]

CVE-2026-45893: apparmor: Fix & Optimize table creation from possibly
unaligned memory

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45893

Introduced by commit e6e8bf4 ("apparmor: fix restricted endian type
warnings for dfa unpack") in v4.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fc367bfd4c8886e6b1742aabbd1c0bdc310db3a]
stable/6.12: [47e351dfef60ab0e3285133556e1a9c7f646a969]
stable/6.18: [e027999049c493fb728ead5a90db76942181a935]

CVE-2026-45894: iommu/vt-d: Clear Present bit before tearing down PASID entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45894

Introduced by commit 0bbeb01 ("iommu/vt-d: Manage scalalble mode PASID
tables") in v5.0-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75ed00055c059dedc47b5daaaa2f8a7a019138ff]
stable/6.12: [a84d30e8d2bacd21782a6481158b7c9c552f4868]
stable/6.18: [821807c167b7b48a41b95b6607c6b9f97600f7d9]

CVE-2026-45895: quota: fix livelock between quotactl and freeze_super

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45895

Introduced by commit 576215c ("fs: Drop wait_unfrozen wait queue") in v6.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [77449e453dfc006ad738dec55374c4cbc056fd39]
stable/6.12: [414259caf81a397563fc9baca9c0ef856c4a97cf]
stable/6.18: [02bb1500f1479750e6557c8044f6a2d7e9d30c12]
stable/6.6: [37ccd48cf35f3c8b9f2ea961a7b486b91eb71a82]

CVE-2026-45896: mtd: intel-dg: Fix accessing regions before setting nregions

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45896

Introduced by commit ceb5ab3 ("mtd: add driver for intel graphics
non-volatile memory device") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [779c59274d03cc5c07237a2c845dfb71cff77705]
stable/6.18: [721bd22bcf45a63ebd9bd0f478ef721b45cc5383]

CVE-2026-45897: netfilter: nft_counter: serialize reset with spinlock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45897

Introduced by commit bd662c4 ("netfilter: nf_tables: Add locking for
NFT_MSG_GETOBJ_RESET requests") in v6.11-rc4.
Introduced by commit 3d483fa ("netfilter: nf_tables: Add locking for
NFT_MSG_GETSETELEM_RESET requests") in v6.8-rc1.
Introduced by commit 3cb03ed ("netfilter: nf_tables: Add locking for
NFT_MSG_GETRULE_RESET requests") in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [779c60a5190c42689534172f4b49e927c9959e4e]

CVE-2026-45898: RDMA/iwcm: Fix workqueue list corruption by removing work_list

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45898

Introduced by commit e1168f0 ("RDMA/iwcm: Simplify
cm_event_handler()") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7874eeacfa42177565c01d5198726671acf7adf2]
stable/6.12: [38c5b49fffa1b760959af74f11806eeb3ef4706d]
stable/6.18: [eb715133e0ae12514bba4d2d5ce1dee774476056]

CVE-2026-45899: ext4: drop extent cache when splitting extent fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45899

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [cc24452e8666b35f601c4124e7106e13eba01cb1]
cip/4.4-st: [8519b9b867c21ea906d5250877e880b46f7d924b]
mainline: [79b592e8f1b435796cbc2722190368e3e8ffd7a1]
stable/5.10: [6e54f8dfee359bbd58086c883ea8cffd5312999d]
stable/5.15: [337506dc652383c80839edb8d8dcdd8ff2129b4f]
stable/6.1: [de8e1b17e3876a44c4537bff0bc2dfd244efe8d9]
stable/6.12: [120c6bd7ca9d3e80a968b758cbb3fbd67570f132]
stable/6.18: [808f3191498f300174523c54cab101e18795ae4e]
stable/6.6: [dc7c9b9d03a59a7fe483574531327e650a4b4adc]

CVE-2026-45900: crypto: caam - fix netdev memory leak in dpaa2_caam_probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45900

Introduced by commit 0e1a4d4 ("crypto: caam: Unembed net_dev structure
in dpaa2") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d43252b3060b0ba4a192dce5dba85a3f39ffe39]
stable/6.12: [d5c6f254528caf78d5de7d9646dc21c81d351827]
stable/6.18: [d7decb572b55d2af33e59e9858fcee5d9ae69175]

CVE-2026-45901: netfilter: nf_tables: revert commit_mutex usage in reset path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45901

Introduced by commit bd662c4 ("netfilter: nf_tables: Add locking for
NFT_MSG_GETOBJ_RESET requests") in v6.11-rc4.
Introduced by commit 3d483fa ("netfilter: nf_tables: Add locking for
NFT_MSG_GETSETELEM_RESET requests") in v6.8-rc1.
Introduced by commit 3cb03ed ("netfilter: nf_tables: Add locking for
NFT_MSG_GETRULE_RESET requests") in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f261bb906bf527c4a6e2a646e2d5f3679f2a8bc]

CVE-2026-45902: power: supply: bq256xx: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45902

Introduced by commit 32e4978 ("power: supply: bq256xx: Introduce the
BQ256XX charger driver") in v5.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8005843369723d9c8975b7c4202d1b85d6125302]
stable/5.15: [81d3688c9a2158329391e08f2d0b8ba204216044]
stable/6.1: [74b5a88318db97d51bb40f774736553c2acd1514]
stable/6.12: [83c27fdd696ac13d023ef7a0345301be93209c53]
stable/6.18: [4b6fb0b6124f558131e502e3ffd03e6583b3ace6]
stable/6.6: [cb5c743936edcebc51880eeb6bf04979b5c9438b]

CVE-2026-45903: bpf: Fix memory access flags in helper prototypes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45903

Introduced by commit 37cce22 ("bpf: verifier: Refactor helper access
type tracking") in v6.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [802eef5afb1865bc5536a5302c068ba2215a1f72]
stable/6.18: [fdfe75161f6e8c41a7d3023fbb815b537107b806]

CVE-2026-45904: powerpc/eeh: fix recursive pci_lock_rescan_remove
locking in EEH event handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45904

Introduced by commit 1010b4c ("powerpc/eeh: Make EEH driver device
hotplug safe") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [815a8d2feb5615ae7f0b5befd206af0b0160614c]
stable/5.10: [89810e2d80281d42f855fac813786758ee16e323]
stable/5.15: [788dd28fd49610d6047cbb15dbf1186afffdfbaf]
stable/6.1: [f49faa4a64f8ac0e38983e606075b25dfcfc9ad4]
stable/6.12: [f8b16d5764ee1e78c1ef333017ad383ffe76fcdc]
stable/6.18: [6e6561231c6cfc32c5631aeecc0928ff2b14265c]
stable/6.6: [87a1f93986aa1500b85aeff16b0b71c29ea116ea]

CVE-2026-45905: xfrm: fix ip_rt_bug race in icmp_route_lookup reverse path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45905

Introduced by commit 8b7817f ("[IPSEC]: Add ICMP host relookup
support") in v2.6.25-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81b84de32bb27ae1ae2eb9acf0420e9d0d14bf00]
stable/6.1: [9a95ec9144eeff1fc6fbcc21b677e322c6f1430b]
stable/6.12: [b04061f89ffc6168e7ec3c71d0086ec3c3797228]
stable/6.18: [1c9ef28f643cce34a6a6c36c8f4d6d60a60db7e1]
stable/6.6: [2c1f59005da9dd4b07b26984fd719e36557dc57c]

CVE-2026-45906: power: supply: pf1550: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45906

Introduced by commit 4b6b643 ("power: supply: pf1550: add battery
charger support") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [838767f5074700552d3f006d867caed65edc7328]

CVE-2026-45907: net/mlx5e: Fix deadlocks between devlink and netdev
instance locks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45907

Introduced by commit 8f7b003 ("net/mlx5e: Convert mlx5 netdevs to
instance locking") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [83ac0304a2d77519dae1e54c9713cbe1aedf19c9]
stable/6.18: [4329514c61abefe4961541b128c549b017bab5ad]

CVE-2026-45908: accel/amdxdna: Fix memory leak in amdxdna_ubuf_map

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45908

Introduced by commit bd72d4a ("accel/amdxdna: Support user space
allocated buffer") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [84dd57fb0359500092f1101409ca32091731490d]
stable/6.18: [5a68d2c99c859e6e8e36fa4e32749abf6d1fb66a]

CVE-2026-45909: clk: mediatek: Drop __initconst from gates

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45909

Introduced by commit 8ceff24 ("clk: mediatek: clk-gate: Refactor
mtk_clk_register_gate to use mtk_gate struct") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [871afb43e41ad4e8246438de495a939cd0f8113c]
stable/6.18: [1debd9ba7eb18af8fb63dc93517c6bbcab0e31ee]

CVE-2026-45910: RDMA/rxe: Fix race condition in QP timer handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45910

Introduced by commit d946716 ("RDMA/rxe: Rewrite rxe_task.c") in v6.4-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87bf646921430e303176edc4eb07c30160361b73]
stable/6.12: [3c2ae79fb19dfd67341c14f1e78a5f1744eacfe2]
stable/6.18: [5ae9da022ee3c97e6469eabcddce9271501ddbad]
stable/6.6: [756c93d6df7c3bc599f6590b8e5afead6a41de1c]

CVE-2026-45911: usb: cdns3: fix role switching during resume

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45911

Introduced by commit 2cf2581 ("usb: cdns3: add power lost support for
system resume") in v5.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [87e4b043b98a1d269be0b812f383881abee0ca45]
stable/5.15: [ff02bd303d2d78051771db51119d66c0cf442f47]
stable/6.1: [94c742614899ff18a6b3e6f3cfbe7b9f36c865f3]
stable/6.12: [56289298431ed76700b9aac27a3b1d929fe61b8d]
stable/6.18: [fc086c0ce3db0eefbbeb66a5b1e626296336e33a]
stable/6.6: [d637f6ec149ffd2f8257bcc261561dc2e44dbb8c]

CVE-2026-45912: ext4: don't cache extent during splitting extent

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45912

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [3656ec552a870a4903159ad5a6f849b0be50cb1a]
cip/4.4-st: [4d73db6c36f19dca4cd4daf90def26157fc5e733]
mainline: [8b4b19a2f96348d70bfa306ef7d4a13b0bcbea79]
stable/5.10: [8302b5b4aacdbb378f7b1216bb2ee782b5142415]
stable/5.15: [692103feca376ae4298c92aa8828015d20f1d87b]
stable/6.1: [4c2d9dac4d328244f9365b0a1fa27ec802821820]
stable/6.12: [96007fd3c106aea773c1afae2d6f64cceb6da208]
stable/6.18: [5b1f4290453314e11cd8e15c7baa8a9b76c19b23]
stable/6.6: [93b2ebbbcb2e63cfc21a1946dfe91d3aa7952036]

CVE-2026-45913: net: bridge: mcast: always update mdb_n_entries for
vlan contexts

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45913

Introduced by commit b57e8d8 ("net: bridge: Maintain number of MDB
entries in net_bridge_mcast_port") in v6.3-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b769e311a86bb9d15c5658ad283b86fc8f080a2]
stable/6.12: [724a405ce0309676f1e993c173382b4c4a022beb]
stable/6.18: [fae260fc84e1eae8f590c7907e53e8768df2d986]
stable/6.6: [d0fdad1bdd21a358cc2c85da3681ae27b86ce6ce]

CVE-2026-45914: Revert "hwmon: (ibmpex) fix use-after-free in high/low store"

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45914

Introduced by commit 6946c72 ("hwmon: (ibmpex) fix use-after-free in
high/low store") in v6.19-rc2.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10
stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
cip/4.19-st: [befd26c92611aae8b323f5bb92dbc4c9e1e51ef9]
cip/4.4-st: [3dc2d2b29bbf0e5bcc3f04d1da935eefadc700bf]
mainline: [8bde3e395a85017f12af2b0ba5c3684f5af9c006]
stable/5.10: [05112ba67c824ab416cd54307c0b50aba9f0047a]
stable/6.1: [efd68429f23fb4015b0ebc2392334059e06fad18]
stable/6.12: [914b47c9b824d3d74f31c764163edf93302100b1]
stable/6.18: [14a38784e09aebc21207dc32fffa05247fc3dd64]
stable/6.6: [f448acd86835a650f9ea83460b9ca347d3aafba5]

CVE-2026-45915: fat: avoid parent link count underflow in rmdir

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45915

Introduced by commit 9a53c3a ("[PATCH] r/o bind mounts: unlink:
monitor i_nlink") in v2.6.20.16.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [31e8035b626c29413d787d71d299a1c5c6bc097e]
cip/4.4-st: [3a48d61672583f2e1d2b1a1894858971c78151e3]
mainline: [8cafcb881364af5ef3a8b9fed4db254054033d8a]
stable/5.10: [7fe0de287e931e07cb96ecf1f449b2ebdb0e1115]
stable/5.15: [9894c79fd9466612d0514be157b5c30cd93aa645]
stable/6.1: [cd569b87378b9c33ae13c23d6bb9d205d66f7c4b]
stable/6.12: [955c5d670b5ae07c78f4345e23a895638db96ce1]
stable/6.18: [17866f8a0822d414cb02e621cf003a7d04396ef8]
stable/6.6: [d3b7ffa90f613938128432c7b2f35b7aa4bdd86b]

CVE-2026-45916: power: supply: sbs-battery: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45916

Introduced by commit d2cec82 ("power: sbs-battery: Request threaded
irq and fix dev callback cookie") in v4.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [85d3f4fd090a3786a349132d9f363d141036f6e3]
mainline: [8d59cf3887fbabacef53bfba473e33e8a8d9d07b]
stable/5.10: [ca7dd71773e4e050b0fb98768b7eae60f8d1f38b]
stable/5.15: [f1f472b14ad56104ba228b8fbec60d5b21829913]
stable/6.1: [8010b745b436c3e1ca5dd960aa29fa3e0f6d8841]
stable/6.12: [82d3eb97a976c9d56bb92b241397610e57a9c629]
stable/6.18: [861dda7a9074c0ff67788928165ae39d7f647491]
stable/6.6: [2078830c32d1e49ac942c6f8c21f35c806ae5e94]

CVE-2026-45917: ipvs: do not keep dest_dst if dev is going down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45917

Introduced by commit 7a4f076 ("IPVS: init and cleanup restructuring")
in v2.6.39.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8fde939b0206afc1d5846217a01a16b9bc8c7896]
stable/6.12: [64af43033503458c46023e56d6ae7bb0f824b55f]
stable/6.18: [bae53b3baf2ff2f45f9205c438818fc055601a54]

CVE-2026-45918: ovpn: tcp - don't deref NULL sk_socket member after tcp_close()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45918

Introduced by commit 11851cb ("ovpn: implement TCP transport") in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [94560267d6c41b1ff3fafbab726e3f8a55a6af34]
stable/6.18: [f998b2c4bec487063a586695159f9a1856e81c56]

CVE-2026-45919: sched/rt: Skip currently executing CPU in rto_next_cpu()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45919

Introduced by commit 4bdced5 ("sched/rt: Simplify the IPI based RT
balancing logic") in v4.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
cip/4.19-st: [95ce8247de7ca958a03328513fdc99f63c7b5058]
cip/4.4-st: [1f0084ce242353b5d8a4fdcda3f9c6be8fab42cd]
mainline: [94894c9c477e53bcea052e075c53f89df3d2a33e]
stable/5.10: [d57d0746276a88ea43a2cc62b849fd8a95e32e41]
stable/5.15: [3b3c672a66db3de3b40f8a7057864bc1f874ede3]
stable/6.1: [16ca9f3117e9a294646c897daf08a5ab546c711b]
stable/6.12: [a6a73403733e86748421f2eeaf028c85683ef896]
stable/6.18: [52aeb1e07ec223caf212f036817976c98d2aa250]
stable/6.6: [8ad5577b2d4acfd83f03d97a0aece2d18aac5f07]

CVE-2026-45920: ext4: fix dirtyclusters double decrement on fs shutdown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45920

Introduced by commit 0087d9f ("ext4: Fix s_dirty_blocks_counter if
block allocation failed with nodelalloc") in v2.6.29-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [1c3cc44f4bfbbfcecace466e3a040df6fbfca2e8]
cip/4.4-st: [c7ff09d66ac8a037fc4bcd474d7b957943376f17]
mainline: [94a8cea54cd935c54fa2fba70354757c0fc245e3]
stable/5.10: [523d5a4df3c649fa305c89efb552ec62a1ce9d3d]
stable/5.15: [ca408af08544d96769c93a3d81a7f63f61129e95]
stable/6.1: [55576fa14771d33994c29a9ae960e07bb3f56c20]
stable/6.12: [61e372122b6d95aec940fdaea0a16f988f359897]
stable/6.18: [3924aea2c33df3864929c1acd178bfc29d8f005f]
stable/6.6: [dbc4e10619ed87a50e637b96f2e574df36a7a769]

CVE-2026-45921: mtd: parsers: Fix memory leak in
mtd_parser_tplink_safeloader_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45921

Introduced by commit 00a3588 ("mtd: parsers: add TP-Link SafeLoader
partitions table parser") in v6.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [980ce2b02dd06a4fdf5fee38b2e14becf9cf7b8b]
stable/6.12: [e97f5fac8ce9a6b9ec724c97d86b0985e915fdca]
stable/6.18: [ec121ad626c319085f6d40a52cd04e99b4554926]
stable/6.6: [0f5e62ea5c43146eacdc6861cb1022ffae1b79bc]

CVE-2026-45922: RDMA/mlx5: Fix memory leak in GET_DATA_DIRECT_SYSFS_PATH handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45922

Introduced by commit ec7ad65 ("RDMA/mlx5: Introduce
GET_DATA_DIRECT_SYSFS_PATH ioctl") in v6.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9b9d253908478f504297ac283c514e5953ddafa6]
stable/6.12: [ee998cdbff6680891b0efd9d6ce53a388e5342c3]
stable/6.18: [b2bc649c18fbe8a7fd38d17266da3dcbfbcc44d2]

CVE-2026-45923: net: usb: catc: enable basic endpoint checking

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45923

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [fb5824e8df6223af8620fdc255a5dd5175e1f902]
cip/4.4-st: [c7c41f8865f93a03cf14a7d128fa6d782f20d67c]
mainline: [9e7021d2aeae57c323a6f722ed7915686cdcc123]
stable/5.10: [eade522d3e6ac3f3bfb51bfa5b5b4b32bd0b846f]
stable/6.1: [ac7739b78ded519e1d9919a814da3b34120bec8c]
stable/6.12: [a488001a8197da4f9c413eec8f6acbff71c60145]
stable/6.18: [36c28b028efba0f42218d41fed12c47ce217c1f1]
stable/6.6: [163d04897e57633c5d2e69734e4e4b22bb63f50d]

CVE-2026-45924: ksmbd: call ksmbd_vfs_kern_path_end_removing() on some
error paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45924

Introduced by commit d5fc140 ("smb/server: avoid deadlock when linking
with ReplaceIfExists") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [a09dc10d1353f0e92c21eae2a79af1c2b1ddcde8]
stable/5.15: [8e3a3192ef78d8302916408d62813b1fddfc8972]
stable/6.1: [f221baa80e5959a0c08a7e34abbf2a4d3cf0e1c2]
stable/6.12: [34d6691933682f0516259a31b39d2cebcedec0a5]
stable/6.18: [0c578e8065c4b08d5635a4cbc0f6321df9d20f79]
stable/6.6: [cf29329a13df79c198b45dfc92577638d30b56fa]

CVE-2026-45925: thermal/of: Fix reference leak in thermal_of_cm_lookup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45925

Introduced by commit 423de5b ("thermal/of: Fix cdev lookup in
thermal_of_should_bind()") in v6.14-rc5.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [a1fe789a96fe47733c133134fd264cb7ca832395]
stable/6.12: [8af710156c53cdb392d529497ef2b3a10a1f9370]
stable/6.18: [8344d5da9df74fdbef676214d0c482fc822a01ca]

CVE-2026-45926: rust: pwm: Fix potential memory leak on init error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45926

Introduced by commit 7b3dce8 ("rust: pwm: Add Kconfig and basic data
structures") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2633dc243c35754a0c2270131d8a199c987c9bf]

CVE-2026-45927: bpf: Require frozen map for calculating map hash

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45927

Introduced by commit ea2e646 ("bpf: Return hashes of maps in
BPF_OBJ_GET_INFO_BY_FD") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a2c86aa621c22f2a7e26c654f936d65cfff0aa91]
stable/6.18: [7752d36343862323bbeea4ce3adf0ec2ed86e122]

CVE-2026-45928: media: chips-media: wave5: Fix memory leak on
codec_info allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45928

Introduced by commit 9707a62 ("media: chips-media: wave5: Add the v4l2
layer") in v6.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a519e21e32398459ba357e67b541402f7295ee1b]
stable/6.12: [52defdd4034db1a34bb48006f889d66a3629224b]
stable/6.18: [1de71556cbd6e1d0d26fb86b9b3bb8caa0df8495]

CVE-2026-45929: ovpn: fix possible use-after-free in ovpn_net_xmit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45929

Introduced by commit 08857b5 ("ovpn: implement basic TX path (UDP)")
in v6.16-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a5ec7baa44ea3a1d6aa0ca31c0ad82edf9affe41]
stable/6.18: [3e4fbcb4e078915367ba5576cd70d76dbc970f95]

CVE-2026-45930: net: mctp: ensure our nlmsg responses are initialised

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45930

Introduced by commit 831119f ("mctp: Add neighbour netlink interface")
in v5.15-rc1.
Introduced by commit 06d2f4c ("mctp: Add netlink route management") in
v5.15-rc1.
Introduced by commit 583be98 ("mctp: Add device handling and netlink
interface") in v5.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a6a9bc544b675d8b5180f2718ec985ad267b5cbf]

CVE-2026-45931: accel/amdxdna: Hold mm structure across
iommu_sva_unbind_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45931

Introduced by commit be462c9 ("accel/amdxdna: Add hardware context")
in v6.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a9162439ad792afcddc04718408ec1380b7a5f63]
stable/6.18: [f6b4c1d98a7b8040d4d02e89425b3942016a2c2c]

CVE-2026-45932: bpf: Fix tcx/netkit detach permissions when prog fd isn't given

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45932

Introduced by commit e420bed ("bpf: Add fd-based tcx multi-prog infra
with link support") in v6.6-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae23bc81ddf7c17b663c4ed1b21e35527b0a7131]
stable/6.18: [4e0772cded109c238411f2fac36ac39302758b81]

CVE-2026-45933: bpf: Preserve id of register in sync_linked_regs()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45933

Introduced by commit 98d7ca3 ("bpf: Track delta between "linked"
registers.") in v6.11-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [af9e89d8dd39530c8bd14c33ddf6b502df1071b6]
stable/6.12: [58059335e46537de682db84984f7716c813208c4]
stable/6.18: [92a8cb1806adefb263cf096eab6705705cf7eee1]

CVE-2026-45934: btrfs: fix EEXIST abort due to non-consecutive gaps in
chunk allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45934

Introduced by commit 1b98450 ("Btrfs: fix find_free_dev_extent()
malfunction in case device tree has hole") in v4.1-rc2.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b14c5e04bd0f722ed631845599d52d03fcae1bc1]
stable/6.18: [7d4eadee7042d27fcea659fcdd738f463a7d2e70]

CVE-2026-45935: fs/ntfs3: Fix slab-out-of-bounds read in DeleteIndexEntryRoot

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45935

Introduced by commit b46acd6 ("fs/ntfs3: Add NTFS journal") in v5.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2bc7c44ed1779fc9eaab9a186db0f0d01439622]
stable/5.15: [36c03f7f177b34d51f1cf1d2304b1074607bf4b0]
stable/6.1: [b271c9cb85927210b1b799e55ee7f702d12b4336]
stable/6.12: [c065541b71b79874c83d418a9acd18ad5826339b]
stable/6.18: [78942172d5bff4d4afed8674abc09cc560ce44a0]
stable/6.6: [a584b9d1059b29e97e17c919274e9adfb846f2a0]

CVE-2026-45936: power: supply: goldfish: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45936

Introduced by commit 84d7b76 ("power: Add battery driver for goldfish
emulator") in v3.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b2ce982e2e0c888dc55c888ad0e20ea04daf2e6b]
stable/5.10: [589d4fe56713c6344cd9f8939f9c7621c85f0966]
stable/5.15: [bad8b61eb5059acd88349680e47839342dc89e94]
stable/6.1: [33751e28842bf5aee5ef7b2b8d5e456a069095cb]
stable/6.12: [4350505e82b4f972ddb788e1c712c557c38859d0]
stable/6.18: [8c89aade8335e26a6a7dcda18992d15f51943927]
stable/6.6: [77ea437faa4c06362e3ecfd2d7264eaa7ac1e82c]

CVE-2026-45937: crypto: inside-secure/eip93 - fix kernel panic in driver detach

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45937

Introduced by commit 9739f5f ("crypto: eip93 - Add Inside Secure
SafeXcel EIP-93 crypto engine support") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b6e32ba6d32503440a3e3e16c8d0521cbb7e0c5d]
stable/6.18: [7530c3595d1e23bc5938cbd44b7e8f33457fc71f]

CVE-2026-45938: power: supply: pm8916_lbc: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45938

Introduced by commit f8d7a3d ("power: supply: Add driver for pm8916
lbc") in v6.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b7508129978ae1e2ed9b0410396abc05def9c4eb]
stable/6.12: [dbe579e620ef0f53db490ec79a8566e4ea8918ac]
stable/6.18: [08e674e9862a2db46fb234eb7c5442455ece0131]

CVE-2026-45939: gpib: Fix memory leak in ni_usb_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45939

Introduced by commit 4e127de ("staging: gpib: Add National Instruments
USB GPIB driver") in v6.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b89921eed8cf2d97250bac4be38dbcfbf048b586]
stable/6.18: [9c97fcfb7a62dea893104a046d544da8ac23370b]

CVE-2026-45940: net: stmmac: fix oops when split header is enabled

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45940

Introduced by commit ec22200 ("net: stmmac: Prepare to add Split
Header support") in v5.4-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [babab1b42ed68877ef669a08384becf281ad2582]
stable/6.18: [b1f23df09e7dbf4c86b6908dff7efb8cb2b7d609]

CVE-2026-45941: tpm: tpm_i2c_infineon: Fix locality leak on
get_burstcount() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45941

Introduced by commit aad628c ("char/tpm: Add new driver for Infineon
I2C TIS TPM") in v3.7-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [06b6c632f87cb35c492dd0e5f69829f82761bbd7]
cip/4.4-st: [449864e5eae0b21beeda22a71d0adbcff7139214]
mainline: [bbd6e97c836cbeb9606d7b7e5dcf8a1d89525713]
stable/5.10: [8f124c5582d443ac9fb690db26d08cab5d6ba76e]
stable/5.15: [c24c9c4cab11858f22f309521ba7ea5b1e7385f2]
stable/6.1: [1bb8f8826d0748b4b92a98fb6b6dfe52081739f5]
stable/6.12: [a61b8412e3eb8b71646dba867e8252d8560a1a27]
stable/6.18: [1a22048c1117cdfac185ba450aba67ed6b65dc87]
stable/6.6: [948966e546f29af04391d98b8e378e4a7670c1c1]

CVE-2026-45942: ext4: fix e4b bitmap inconsistency reports

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45942

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [bdc56a9c46b2a99c12313122b9352b619a2e719e]
stable/6.12: [c05033cfc5c7699cd4df8d48cef94d01da755f24]
stable/6.18: [29a07d691d282faf38c33d4b61839b89399110f9]
stable/6.6: [57e83bfbe1e412ac42daced2086f3c6f9a17bba0]

CVE-2026-45943: erofs: fix inline data read failure for ztailpacking pclusters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45943

Introduced by commit cecf864 ("erofs: support inline data
decompression") in v5.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c134a40f86efb8d6b5a949ef70e06d5752209be5]
stable/6.12: [ad07ea069f924465061cfee40ef2861bb99f4dd8]
stable/6.18: [5de1aa0bf3a5db0b3cbf61959da5ac61250833ed]

CVE-2026-45944: iommu/vt-d: Clear Present bit before tearing down context entry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45944

Introduced by commit ba39592 ("Intel IOMMU: Intel IOMMU driver") in v2.6.24-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c1e4f1dccbe9d7656d1c6872ebeadb5992d0aaa2]
stable/6.18: [d2138abc8f0a7fce4101b7229b43b06811ed083d]

CVE-2026-45945: iommu/vt-d: Fix race condition during PASID entry replacement

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45945

Introduced by commit 7543ee6 ("iommu/vt-d: Add pasid replace helpers")
in v6.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c3b1edea3791fa91ab7032faa90355913ad9451b]

CVE-2026-45946: power: supply: ab8500: Fix use-after-free in
power_supply_changed()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45946

Introduced by commit 1c1f13a ("power: supply: ab8500: Move to
componentized binding") in v5.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c4af8a98bb52825a5331ae1d0604c0ea6956ba4b]
stable/5.15: [43cbb78ee047b9b12d096d40e3be265969d4c1f8]
stable/6.1: [551672981fe227122258a25a385a05f5c0746ad6]
stable/6.12: [847eeb6c0efcd76c7def73857cf798a4fcd8f79b]
stable/6.18: [709db4b476e254579d9c48ec34d397a41ca0c407]
stable/6.6: [f50433f2603def08b21a4bf2fd238687fb5cbde9]

CVE-2026-45947: drm/amdgpu: Fix memory leak in amdgpu_acpi_enumerate_xcc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45947

Introduced by commit 4d5275a ("drm/amdgpu: Add parsing of acpi xcc
objects") in v6.5-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c9be63d565789b56ca7b0197e2cb78a3671f95a8]
stable/6.12: [18a7bbd11f17a7cd4c42fd5955d3675d68c692df]
stable/6.18: [d1370ef2ecf7d4df25e3e1e430cd191b1e7f8596]
stable/6.6: [e87c73a80a12d337cf5f493c0956f6c2c9eafd80]

CVE-2026-45948: ext4: fix memory leak in ext4_ext_shift_extents()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45948

Introduced by commit a18ed35 ("ext4: always check ext4_ext_find_extent
result") in v3.15-rc3.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6894a6cdec5734b43405543a1da2201d7d4b0971]
cip/4.4-st: [6a930dec1cc3a1482a97db188f0c72f60df335ea]
mainline: [ca81109d4a8f192dc1cbad4a1ee25246363c2833]
stable/5.10: [7e807cb8603b7664fa630a696cd891d9a03c248d]
stable/5.15: [afc5e61e1a07b2b833bd72cbee36ecce9cd901e2]
stable/6.1: [1bce219ee5512cf179ba40cf114945a14a16e21f]
stable/6.12: [2f4b1052246ca646bb17bfe0f53df2fdf9729b58]
stable/6.18: [12615ab4bfb69678e5d961b28bb70040299e51b1]
stable/6.6: [4a79fde8db7eba7f1128d971ceba4e3c9ac84aec]

CVE-2026-45949: hwrng: core - use RCU and work_struct to fix race condition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45949

Introduced by commit be4000b ("hwrng: create filler thread") in v3.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cc2f39d6ac48e6e3cb2d6240bc0d6df839dd0828]
stable/6.12: [d5b7730f06994499632026c30e38e0317c4569e2]
stable/6.18: [dcf416eb88eafe1e3c0f920a14bdffd10bc4d259]

CVE-2026-45950: crypto: starfive - Fix memory leak in
starfive_aes_aead_do_one_req()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45950

Introduced by commit 7467147 ("crypto: starfive - Use dma for aes
requests") in v6.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccb679fdae2e62ed92fd9acb25ed809c0226fcc6]
stable/6.12: [38d80307decc1132626a30e2a62af734630ecca5]
stable/6.18: [4869d0e4e48a5301b267d359b2561c4080791a55]

CVE-2026-45951: bpf: Fix a potential use-after-free of BTF object

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45951

Introduced by commit 76145f7 ("bpf: Refactor check_pseudo_btf_id") in v6.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccd2d799ed4467c07f5ee18c2f5c59bcc990822c]
stable/6.18: [eac65c272f3b49021a843cba5107d63627395e0e]

CVE-2026-45952: eth: fbnic: Add validation for MTU changes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45952

Introduced by commit 1b0a395 ("eth: fbnic: Add XDP pass, drop, abort
support") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ccd8e87748ad083047d6c8544c5809b7f96cc8df]
stable/6.18: [d7eaa006c0444a5d4671be7efe6dbb33ef8b515e]

CVE-2026-45953: md/raid5: fix IO hang with degraded array with llbitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45953

Introduced by commit 5ab829f ("md/md-llbitmap: introduce new lockless
bitmap") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cd1635d844d26471c56c0a432abdee12fc9ad735]
stable/6.18: [870b9f15867b0e70f3459ef3974b043e8b229690]

CVE-2026-45954: fbdev: au1200fb: Fix a memory leak in au1200fb_drv_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45954

Introduced by commit 4e88761 ("fbdev: au1200fb: Fix missing IRQ check
in au1200fb_drv_probe") in v6.5-rc3.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt cip/6.1 cip/6.1-rt stable/5.10 stable/5.15
stable/6.1

Fixed status
cip/4.19-st: [d90ffe410d77f9973708de3ee063dfbba1f7db45]
mainline: [ce4e25198a6aaaaf36248edf8daf3d744ec8e309]
stable/5.10: [81831d56b723bc1090ce3158feddaca88e85f939]
stable/5.15: [071d8fb757a8318f72c8e02898c2cf7e14e21fb6]
stable/6.1: [bd1ad63e11b2a568e98de536f319054d2de29f56]
stable/6.12: [762a26818934241b8b0172a229d2cf5d87260e40]
stable/6.18: [3d4202ee6494c0d576cdc104b12e0834ca8136a8]
stable/6.6: [3e5349e54113e2dce1a659c57935e18032742e56]

CVE-2026-45955: md/md-llbitmap: fix percpu_ref not resurrected on
suspend timeout

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45955

Introduced by commit 5ab829f ("md/md-llbitmap: introduce new lockless
bitmap") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d119bd2e1643cc023210ff3c6f0657e4f914e71d]
stable/6.18: [095417d6b669c2dec39a5842ccb94df915f97f54]

CVE-2026-45956: drm/exynos: vidi: use priv->vidi_dev for ctx lookup in
vidi_connection_ioctl()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45956

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
cip/4.19-st: [24dcd1c4171726a32c448cce00e71abde07c666b]
mainline: [d3968a0d85b211e197f2f4f06268a7031079e0d0]
stable/5.10: [2987642c5213508c6c9e718324c0d5289a92c474]
stable/5.15: [65d1213baffa363f2eb1117b1dc7acc573b890f8]
stable/6.1: [875fa28690e93ed5296c31d3344556c6bb867234]
stable/6.18: [b5fc86d753dd4c281a943b92f0eef02d31af03d7]
stable/6.6: [21ca24ba51a2c28bcc4df9d7e5a40b0eb66ab76d]

CVE-2026-45957: rcu: Fix rcu_read_unlock() deadloop due to softirq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45957

Introduced by commit 5f5fa7e ("rcu: Don't use negative nesting depth
in __rcu_read_unlock()") in v5.8-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d41e37f26b3157b3f1d10223863519a943aa239b]
stable/6.12: [1f16679a5aa60238466ce339c35f5e82ece60337]
stable/6.18: [4a4a6e12c9c829be3f74b7206fa8640fc4e1c566]
stable/6.6: [979c708e6c9d7fc461daef2dad8b45f22e23464c]

CVE-2026-45958: drm/exynos: vidi: fix to avoid directly dereferencing
user pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45958

Introduced commit is not determined.Fixed in v7.0-rc1.


Fixed status
mainline: [d4c98c077c7fb2dfdece7d605e694b5ea2665085]
stable/5.10: [13537f7f6d28a87ee2e496e071b6ad9541905f23]
stable/5.15: [c2914c0ca7557c6c5c845621cb6d6c9f26ab5a8c]
stable/6.1: [7efb6a4e6b1b523e744d17e6249757ed97caae7c]
stable/6.12: [4c4193829109f38b2855de77981adc2e066286c7]
stable/6.18: [4949e32387fe315b59ad5f422c9fc52836fbdd1e]
stable/6.6: [2e147aa3169b83eaf044776f81d86235bf147de1]

CVE-2026-45959: crypto: ccp - Fix a crash due to incorrect cleanup
usage of kfree

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45959

Introduced by commit a714755 ("crypto: ccp - reduce stack usage in
ccp_run_aes_gcm_cmd") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5abcc33ee76bc26d58b39dc1a097e43a99dd438]
stable/6.18: [9a3ace9b010ffd8c422c97844ae152f7c53d6b18]

CVE-2026-45960: hfsplus: return error when node already exists in
hfs_bnode_create

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45960

Introduced by commit 634725a ("[PATCH] hfs: cleanup HFS+ prints") in v2.6.20.16.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [f159703caf7244659069f3b3ef40b87ca4bd94b9]
cip/4.4-st: [43b88ebc498164c6f3b9e6f71fbef98099668499]
mainline: [d8a73cc46c8462a969a7516131feb3096f4c49d3]
stable/5.10: [1ca428769cb4737a25bd32fb4d1573cc09eeaeef]
stable/5.15: [507a1de58c21c95ad7c44afccaf1222d1c42246b]
stable/6.1: [986455135b95f32c1f142068e451098fc751749e]
stable/6.12: [51838112d9c22502333c3085ca0c0d691e7093c6]
stable/6.18: [2e6ff6a6fc69cc17ed10c9cb6242935d52acd52d]
stable/6.6: [7b57ada854b32310f224abd61bcfec2d5790ff0a]

CVE-2026-45961: gfs2: fix memory leaks in gfs2_fill_super error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45961

Introduced by commit 6c7410f ("gfs2: gfs2_freeze_lock_shared cleanup")
in v6.5-rc1.
Introduced by commit b66f723 ("gfs2: Improve gfs2_make_fs_rw error
handling") in v6.3-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da6f5bbc2e7902f578b503f2a4c3d8d09ca4b102]

CVE-2026-45962: ublk: Validate SQE128 flag before accessing the cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45962

Introduced by commit 71f28f3 ("ublk_drv: add io_uring based userspace
block driver") in v6.0-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da7e4b75e50c087d2031a92f6646eb90f7045a67]
stable/6.1: [4b4dff498f46e9802f71bc84258bf73065f51c6a]
stable/6.12: [dbe8e81a2ec608f87f79a34f6444cd62f6a243bb]
stable/6.18: [f75a5555e0049e7857eae25b60aee98b80e287ec]
stable/6.6: [31cac6acf77ece488f29fb8f79589d9298e969c8]

CVE-2026-45963: ASoC: nau8821: Cancel delayed work on component remove

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45963

Introduced by commit aab1ad1 ("ASoC: nau8821: new driver") in v5.16-rc1.
Introduced by commit ee70bac ("ASoC: nau8821: Avoid unnecessary
blocking in IRQ handler") in v6.18-rc2.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [dbd3fd05cddfdeec1e49b0a66269881c09eebd17]

CVE-2026-45964: SUNRPC: fix gss_auth kref leak in gss_alloc_msg error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45964

Introduced by commit 5940d1c ("SUNRPC: Rebalance a kref in
auth_gss.c") in v5.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [6d307f0dce6c6468cb949c610b39dc2e7b5dfa13]
mainline: [dd2fdc3504592d85e549c523b054898a036a6afe]
stable/5.10: [3b2b6c42070ce4204936288253baf101e995c2d3]
stable/5.15: [b559be2ec6cdb2e9c2c36c23fbbd4690d8a5c3f7]
stable/6.1: [a1bc9561b617ec7e2d09e6c134d1db8fcf9ca4a6]
stable/6.12: [e464e26b2457005c87e158570498274b9f3b90c7]
stable/6.18: [c20f925214249bb4fc04f7e197bea142a6438af6]
stable/6.6: [655c9ba9915f05266998dbbf4b76b3c79b8a70aa]

CVE-2026-45965: apparmor: fix invalid deref of rawdata when
export_binary is unset

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45965

Introduced by commit 1180b4c ("apparmor: fix dangling symlinks to
policy rawdata after replacement") in v4.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [481b6b31de88b39953030654938b4765850c44c2]
mainline: [df9ac55abd18628bd8cff687ea043660532a3654]
stable/5.10: [e6b2fc7e34d4e7ca6b8598c33a3d45d59e455d8d]
stable/5.15: [6d8c180c825cbc73eeffaa79591f8e142dacae70]
stable/6.1: [3c36b87fc2a4cf88eadea8cf13923bd2b4f9a3fa]
stable/6.12: [19f2e4055626a58842ddec3282ad4465a80c6625]
stable/6.18: [1d2b2b58fde9059a488bc25399e6c3d74e9b5548]
stable/6.6: [b25298e89a297c42eb4c4d6f081d60375b820abb]

CVE-2026-45966: apparmor: fix NULL pointer dereference in
__unix_needs_revalidation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45966

Introduced by commit 88fec35 ("apparmor: make sure unix socket
labeling is correctly updated.") in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e2938ad00b21340c0362562dfedd7cfec0554d67]
stable/6.18: [fea017a7f6abe179decf575a2d8464c74edb3964]

CVE-2026-45967: bpf: Return proper address for non-zero offsets in insn array

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45967

Introduced by commit 493d9e0 ("bpf, x86: add support for indirect
jumps") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3bd7bdf5ffe49d8381e42843f6e98cd0c78a1e8]

CVE-2026-45968: cpuidle: Skip governor when only one idle state is available

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45968

Introduced by commit dc2251b ("cpuidle: Eliminate the
CPUIDLE_DRIVER_STATE_START symbol") in v4.14-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [aac344983ab61913ac942bb107be03db3c135d89]
mainline: [e5c9ffc6ae1bcdb1062527d611043681ac301aca]
stable/5.10: [a0f7e804edc82e513d1ccb7c95ed8b351522ec81]
stable/5.15: [5d103a38e2ae96eca57fd17161bcd29bd4622d1c]
stable/6.1: [4da2b897283c39980d6ae09dc1560fcd937879e5]
stable/6.12: [8f6833d919bae915ead6c599a53e81e19b32da52]
stable/6.18: [63ae78336f40bcd9a44952a7c6bafb9c88a8effd]
stable/6.6: [5c577ac939bca486cb02069505cfe47a5312ce02]

CVE-2026-45969: HID: playstation: Add missing check for input_ff_create_memless

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45969

Introduced by commit 5115109 ("HID: playstation: add DualSense classic
rumble support.") in v5.12-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e6807641ac94e832988655a1c0e60ccc806b76dc]
stable/5.15: [496a345cc047a2c2d9d5a76956e1182525578bd5]
stable/6.1: [987dee1486e975e2baa6a5d062cfdf18bbe901c8]
stable/6.12: [d955aeb26e1210a018492b3b32cbdfaf017aaa25]
stable/6.18: [35301ca2a83d17aac2f3e8e35c696f0da2a13111]
stable/6.6: [33acf9a4d6eb1f6d01691faca96ad6b2ab0fcfc0]

CVE-2026-45970: bonding: alb: fix UAF in rlb_arp_recv during bond up/down

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45970

Introduced by commit 3aba891 ("bonding: move processing of recv
handlers into handle_frame()") in v3.0-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [8c280cccfbfad2e3f79e0077a6b1a9bf318342db]
cip/4.4-st: [8d88dd01136add611175737e02f3f48650fb8a55]
mainline: [e6834a4c474697df23ab9948fd3577b26bf48656]
stable/5.10: [fd54ddc929be1d6c3b3b7b35d6d4642a5d9e803c]
stable/5.15: [de7c097800f07f3c108185c7a38b53a530ba30ff]
stable/6.1: [db5435b5342e3aaa4521d0f3ccfe94316b253ca1]
stable/6.12: [c65cdf46ce340c9c00fbbaf84599d2daff43626e]
stable/6.18: [fef13c403be3fb685cb06419e6b3623106aab5ba]
stable/6.6: [f94a0de7b9f32745a14a1621c63087a092823587]

CVE-2026-45971: bpf: Limit bpf program signature size

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45971

Introduced by commit 3492715 ("bpf: Implement signature verification
for BPF programs") in v6.18-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ea1535e28bb3773fc0b3cbd1f3842b808016990c]
stable/6.18: [5835a077c6f5c565d525eaca9fac01572b97a9b9]

CVE-2026-45972: smb: client: fix potential UAF and double free in
smb2_open_file()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45972

Introduced by commit e3a4363 ("smb/client: fix memory leak in
smb2_open_file()") in v6.19.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [ebbbc4bfad4cb355d17c671223d0814ee3ef4eda]
stable/6.1: [96e53bb3ee2f354cf6b4ab07bcc56e500f8b3f74]
stable/6.12: [4d339b219004869e96c4ce56b8891f83a38da4c0]
stable/6.18: [e66dcf7bb9c4df5582c82bc3582725abcbfbea73]
stable/6.6: [7425453ea16dbc3bbb0f6cac4d60b537e5e4d151]

CVE-2026-45973: RDMA/mlx5: Fix UMR hang in LAG error state unload

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45973

Introduced by commit ede132a ("RDMA/mlx5: Move events notifier
registration to be after device registration") in v6.13-rc1.
Fixed in v7.0-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [ebc2164a4cd4314503f1a0c8e7aaf76d7e5fa211]
stable/6.12: [c8fb5c965ac7d0104872a8e4f6451f3bc6328199]
stable/6.18: [6d838873da9cb97551d42316967cc82bf8f8031b]

CVE-2026-45974: btrfs: fix invalid leaf access in btrfs_quota_enable()
if ref key not found

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45974

Introduced by commit 5223cc6 ("btrfs: drop the path before adding
qgroup items when enabling qgroups") in v5.10-rc2.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ecb7c2484cfc83a93658907580035a8adf1e0a92]
stable/5.10: [023545e272f369d487e6a986c1e321c6e04be1da]
stable/5.15: [fd4913a53e3b54ad7e161847291439fe445d6356]
stable/6.1: [b5b8ade9da452086e78f5d519b90d3769e354853]
stable/6.12: [0761447f6f51e1c7997960d8e6559337deed6729]
stable/6.18: [d7cf2314dd5e8661c05d076cd627eea9a7f76616]
stable/6.6: [1ee1d006c9fe4d6be5527ab1c84216b80cccbe40]

CVE-2026-45975: ublk: use READ_ONCE() to read struct ublksrv_ctrl_cmd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45975

Introduced by commit 87213b0 ("ublk: allow non-blocking ctrl cmds in
IO_URING_F_NONBLOCK issue") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ed9f54cc1e335096733aed03c2a46de3d58922ed]

CVE-2026-45976: drm/amdgpu: Fix memory leak in amdgpu_ras_init()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45976

Introduced by commit fdc94d3 ("drm/amdgpu: Rework pcie_bif ras
sw_init") in v6.4-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee41e5b63c8210525c936ee637a2c8d185ce873c]
stable/6.12: [c11cd77a18115d2cd3f4b6915c4a537b6042f950]
stable/6.18: [2fef8c2ac67e7c1b0409d23653300b134c63e54c]
stable/6.6: [f8a5426652bdadd4a5cb48326d48abbdfebe8153]

CVE-2026-45977: fbnic: close fw_log race between users and teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45977

Introduced by commit ecc53b1 ("eth: fbnic: Enable firmware logging")
in v6.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ee5492fd88cfc079c19fbeac78e9e53b7f6c04f3]
stable/6.18: [223cfef4812bdfa5ac5c1aa761cdba03cfe2c9cd]

CVE-2026-45978: staging: greybus: lights: avoid NULL deref

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45978

Introduced by commit 2870b52 ("greybus: lights: add lights
implementation") in v4.9-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [250f16e08b94d62f8c0b6294c6bce6dc6332c3e7]
mainline: [efcffd9a6ad8d190651498d5eda53bfc7cf683a7]
stable/5.10: [a118724d7641b832fa14323e2733e28ae4834552]
stable/5.15: [3cbe694d235d96f628ec7dc6ae4d8bdddb768699]
stable/6.1: [ba5022162da63059bae36c4fd84d7031f582c71f]
stable/6.12: [01b91cb3e748032fd96bbe0043812b426a52f091]
stable/6.18: [06162d85f830582da6e9e5fcf9c9504d6da9ae0b]
stable/6.6: [65f2c608096d766540953d9b170d216aa3b5eb95]

CVE-2026-45979: drm/amdgpu: clean up the amdgpu_cs_parser_bos

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45979

Introduced by commit 737da53 ("drm/amdgpu: update the functions to use
amdgpu version of hmm") in v6.19-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f025a2b8d93358467b8e8f4b3a617e88c5f02fab]

CVE-2026-45980: accel/amdxdna: Stop job scheduling across
aie2_release_resource()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45980

Introduced by commit 4fd6ca9 ("accel/amdxdna: Refactor hardware
context destroy routine") in v6.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f1370241fe8045702bc9d0812b996791f0500f1b]
stable/6.18: [b79d31dce49b50c79620389b3639280802a86960]

CVE-2026-45981: s390/cio: Fix device lifecycle handling in
css_alloc_subchannel()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45981

Introduced by commit e5dcf00 ("s390/css: move subchannel lock
allocation") in v3.10-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [998cb503a553dcaedcfbb0540dbb764250baa0e0]
cip/4.4-st: [b82b54eaf48f11db22c0278a0746ba79db39a941]
mainline: [f65c75b0b9b5a390bc3beadcde0a6fbc3ad118f7]
stable/5.10: [2b2ad7ad4a28ffdb9f94e6d979b88a5b12b71681]
stable/5.15: [b1d4e6fb241672850296956c4d782a69363a3807]
stable/6.1: [fd295a75d828c11acfcc6869c2a12cdaaf9b7722]
stable/6.12: [f96c5ccf95ae5f27218c1ce2d6a3ad2d3e105424]
stable/6.18: [6715560527e343a387e4a0d2e6c401748e89fa55]
stable/6.6: [abb6e07f46a740cda4f07d1b561ae4eaa7a1df42]

CVE-2026-45982: ACPICA: Fix NULL pointer dereference in
acpi_ev_address_space_dispatch()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45982

Introduced by commit 0acf24a ("ACPICA: Add support for PCC Opregion
special context data") in v5.17-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f851e03bce968ff9b3faad1b616062e1244fd38d]
stable/6.1: [7d99cbe717c1b15a66559215df32312d8cf7e525]
stable/6.12: [cce354524da4d10fd2c7eb835e2e4e8ab8c0ce97]
stable/6.18: [b24595b86920911d2b04f862422b896a0620e9ad]
stable/6.6: [f2cf475d23b8486dfa414f7ac09f918ffd3c32a5]

CVE-2026-45983: nfsd: never defer requests during idmap lookup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45983

Introduced by commit 2f42587 ("nfsd: don't use the deferral service,
return NFS4ERR_DELAY") in v2.6.30-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9c206cdc4266caad6a9a7f46341420a10f03ccb]
stable/5.10: [b9abb760db20504240a7147f27934d900cd80b23]
stable/5.15: [3a72c7dedc99b321e0f267e4e999e5baf07c4593]
stable/6.1: [99e17b20fddac19a228d213e00f6b9e1c10daff9]
stable/6.12: [063a6f22478ef929625000a2caf54667725c1dfd]
stable/6.18: [d75ec4504a4340b033b15cad0303988b3089dd93]
stable/6.6: [243f71ed873ff3feeb6f9b5cb145d63f7188b4c4]

CVE-2026-45984: gfs2: Fix use-after-free in iomap inline data write path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45984

Introduced by commit d0a22a4 ("gfs2: Fix iomap write page reclaim
deadlock") in v5.2-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [faddeb848305e79db89ee0479bb0e33380656321]
stable/5.10: [1403989d1b502f4a2c0d0b42ccf1c25748442eff]
stable/5.15: [1cae1bafdf9caa9b462b19af06b1a06902e4e142]
stable/6.1: [764c3c84b5683e608f43735c803a5f415046686c]
stable/6.12: [87d4954b5c59735a99ea98cb208d47130f6dce7d]
stable/6.18: [6d76febba07c40bcf358f63216d36ea68cf1c215]
stable/6.6: [d87268326b277af3665237ac76a73dd9fa8e21b4]

CVE-2026-45985: ext4: don't set EXT4_GET_BLOCKS_CONVERT when splitting
before submitting I/O

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45985

Introduced by commit b8a8684 ("ext4: Introduce FALLOC_FL_ZERO_RANGE
flag for fallocate") in v3.15-rc1.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [feaf2a80e78f89ee8a3464126077ba8683b62791]
stable/5.10: [77e407967cd872cd75d7e4a691908e49c8e6b4d4]
stable/5.15: [37555690f39f78ef69af347d9aff897e07445949]
stable/6.12: [2920ec61c98b9476781359f05b94da84e80f54d4]
stable/6.18: [2698731d25823267c29190cb578da9296a0c0d7b]
stable/6.6: [67cdb7bd7442bd3cdc6d6088bbb2df9be2fe936c]

CVE-2026-45986: crypto: ccree - fix a memory leak in cc_mac_digest()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45986

Introduced by commit 6389381 ("crypto: ccree - add ahash support") in v4.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [02c64052fad03699b9c6d1df2f9b444d17e4ac50]
stable/6.12: [22f1dd4ca3bfe77db52cc7df3cc353dc114aab8b]
stable/6.18: [910f335786a0a0f0b46c3c8c19a13d25cb4454b6]
stable/6.6: [3061c9bfb3f5b3522ab174e2fa7473b24422d1c6]
stable/7.0: [502440c235fe34cee02b24d7f893841f7565b3bc]

CVE-2026-45987: KVM: nSVM: Sync interrupt shadow to cached vmcb12
after VMRUN of L2

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45987

Introduced by commit cc440cd ("KVM: nSVM: implement
KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE") in v5.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [03bee264f8ebfd39e0254c98e112d033a7aa9055]
stable/6.12: [2f950eeb27af6885416232761700b8820cae0a61]
stable/6.18: [497f6af9679fc9c6ce2f438e11ed5d51b1aa8297]
stable/6.6: [1709418535a8df95532999d61b03d59975280258]
stable/7.0: [e0377e52f3c10ee572732d11b04625b7f517a862]

CVE-2026-45988: rxrpc: Fix re-decryption of RESPONSE packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45988

Introduced by commit 17926a7 ("[AF_RXRPC]: Provide secure RxRPC
sockets for use by userspace and kernel both") in v2.6.22-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0422e7a4883f25101903f3e8105c0808aa5f4ce9]
stable/6.12: [7b89868305052b94a91b708c462bc2281fa42a4a]
stable/6.18: [76cb9a2d252274adfae6e293a292434631a7d472]
stable/6.6: [d61482be4aae1835b78875761206241835a7510e]
stable/7.0: [f55b383070170e988e4dec28be2af1714d258521]

CVE-2026-45989: of: unittest: fix use-after-free in testdrv_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45989

Introduced by commit 26409dd ("of: unittest: Add pci_dt_testdrv pci
driver") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [07fd339b2c253205794bea5d9b4b7548a4546c56]
stable/6.12: [d68347b07b9801791c9eaab8f772770b52b8cd5c]
stable/6.18: [5b6122a67a295f8a08b7c18d908a1bd974dfaec8]
stable/6.6: [0ba03e06f037df704d9b032e36d417633e2326bc]
stable/7.0: [6b2023286d2c6ed3bf964fb92e34c9c14d42eb69]

CVE-2026-45990: slub: fix data loss and overflow in krealloc()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45990

Introduced by commit 2cd8231 ("mm/slub: allow to set node and align in
k[v]realloc") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [082a6d03a2d685a83a332666b500ad3966349588]
stable/6.18: [38387ccc0fbe38d14fb4c2ad7ee1d7404e5e59fd]
stable/7.0: [550fa6b5aabb096554536ac1e3ec96b76cbb35fd]

CVE-2026-45991: udf: fix partition descriptor append bookkeeping

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45991

Introduced by commit ee4af50 ("udf: Fix mounting of Win7 created UDF
filesystems") in v4.19-rc2.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [08841b06fa64d8edbd1a21ca6e613420c90cc4b8]
stable/6.12: [b5597bb83fc37b5b5da74a4453fa920b932cf39a]
stable/6.6: [058b451b1039f056d1362c4fec2229e522366ab0]
stable/7.0: [08fa5d818e5bf53c7ca234d88ba334f32004e9b6]

CVE-2026-45992: ALSA: caiaq: Fix potentially leftover ep1_in_urb at error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45992

Introduced by commit 28abd22 ("ALSA: caiaq: Handle probe errors
properly") in v7.1-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6 stable/7.0

Fixed status
mainline: [0a7b5221b5b51cc798fcfc3be00d02eade149d69]
stable/6.12: [e0fb842af7052f0ab9e709db0c59300aa4051fc0]
stable/6.18: [1d160e30aa42b7c41163e51366bb34432367260d]
stable/6.6: [be62c8bb03b6aec3790a943d4a7567d4d73b8be9]
stable/7.0: [438ab932dc6fef5b001dfeba08a18a491edc8f7b]

CVE-2026-45993: LoongArch: Add spectre boundry for syscall dispatch table

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45993

Introduced commit is not determined.Fixed in v7.1-rc1.
Affected function was added by be76964 ("LoongArch: Add system call
support") in v5.19-rc1.

Fixed status
mainline: [0c965d2784fbbd7f8e3b96d875c9cfdf7c00da3d]
stable/6.12: [07040904ad217545be096d4280ed33c02f6a3750]
stable/6.18: [85cbf7fb568af5358aae61925c4e66b8f5e1439d]
stable/6.6: [108f2cd13577a410c0ad6ea00708596d9d0dfc90]
stable/7.0: [bc84a109c2082dd0c4b38e8d923c046b41977533]

CVE-2026-45994: ibmasm: fix OOB reads in command_file_write due to
missing size checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45994

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0eb09f737428e482a32a2e31e5e223f2b35a71d3]
stable/6.12: [aefc1a97da17d8309974690c8a03e439a91ebb1c]
stable/6.18: [ee5737891464030a189837467df3b81a273718ad]
stable/6.6: [a672682d39dd34e2b5ba4feb436723bed65125ff]
stable/7.0: [d0fb4d1dc43f8d5179917a2daaa82680993d4cdf]

CVE-2026-45995: io_uring/zcrx: fix user_struct uaf

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45995

Introduced by commit 5c68645 ("io_uring/zcrx: add user_struct and
mm_struct to io_zcrx_ifq") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fcccfd87152f957fa8312b841f6efef42a05a20]
stable/7.0: [9feb88eeda6d288f93fcfb6bca563f89e316479d]

CVE-2026-45996: spi: imx: fix use-after-free on unbind

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45996

Introduced by commit 307c897 ("spi: spi-imx: replace struct
spi_imx_data::bitbang by pointer to struct spi_controller") in
v5.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1c78c2002380a1fe31bfb01a3d5f29809e55a096]
stable/6.12: [385a330083f8dd47c15b02e9a83aef9234a37003]
stable/6.18: [132e47030b0b5e398e0da6c59df5a5dae9b52cff]
stable/6.6: [f99165ef067723221472ce1aff632bc74f562643]
stable/7.0: [aa9025a498036b6012769f7af36d421385386c17]

CVE-2026-45997: scsi: sd: fix missing put_disk() when
device_add(&disk_dev) fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45997

Introduced by commit 265dfe8 ("scsi: sd: Free scsi_disk device via
put_device()") in v5.15-rc3.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [1e111c4b3a726df1254670a5cc4868cedb946d37]
stable/6.12: [b64b4f499801b12d0e2785447e4df6c164c608a9]
stable/6.18: [13e550fbfccdb311e76ec96892dfe35f0dba0657]
stable/6.6: [262152ec37101f9dc524743ccdbd6c7641d14573]
stable/7.0: [a95d38c5701431bfc826e7b18acc0785919d5c88]

CVE-2026-45998: rxrpc: Fix potential UAF after skb_unshare() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45998

Introduced by commit 2d1faf7 ("rxrpc: Simplify skbuff accounting in
receive path") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1f2740150f904bfa60e4bad74d65add3ccb5e7f8]
stable/6.12: [bf20f46d94f1db38e6ffc0ca204a5fe0de01b495]
stable/6.18: [996b0487b3cdda4c91811dbb1c9564626bc840bd]
stable/6.6: [e3bf143b1e98fb3d6d9e6825bcd683974d478e8c]
stable/7.0: [8fde6296c4d4da2be7ab761305ab7f232b94eefd]

CVE-2026-45999: erofs: fix unsigned underflow in z_erofs_lz4_handle_overlap()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-45999

Introduced by commit 598162d ("erofs: support decompress big pcluster
for lz4 backend") in v5.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [21e161de2dc660b1bb70ef5b156ab8e6e1cca3ab]
stable/6.12: [f1374fa6e57fd836623668d782ded9244cfd2938]
stable/6.18: [c9ce18e6bb2c467ec85756dc7989b547b7584fee]
stable/6.6: [43a878639b90e9721ffa5eb616a7e6d8454adef3]
stable/7.0: [bbbbb3f0d7864238a8da2a94cd6ec013fee06a2e]

CVE-2026-46000: rxrpc: Fix conn-level packet handling to unshare
RESPONSE packets

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46000

Introduced by commit 17926a7 ("[AF_RXRPC]: Provide secure RxRPC
sockets for use by userspace and kernel both") in v2.6.22-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24481a7f573305706054c59e275371f8d0fe919f]
stable/6.12: [98a2046d155f73f6cf5d2c493c5e09b4963e2e12]
stable/6.18: [ca71ac2de389b01eecdc48bfafbdf073ec232044]
stable/6.6: [c0428a22daf69714dc042b67ea759956b74c74e5]
stable/7.0: [d9b93a0f57ca5f6831bfaa34014b6cd705564a00]

CVE-2026-46001: hwmon: (pt5161l) Fix bugs in pt5161l_read_block_data()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46001

Introduced by commit 1b2ca93 ("hwmon: Add driver for Astera Labs
PT5161L retimer") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24c73e93d6a756e1b8626bb259d2e07c5b89b370]
stable/6.12: [7eccabff1c9ec15e4b6fe186d5c147b13a9cdb4e]
stable/6.18: [95d48e37a1304d6148406c799479c0fb505aefa7]
stable/7.0: [a11aa9c5fd9dfe62be7cfec1f2a7546afb77254c]

CVE-2026-46002: ext2: reject inodes with zero i_nlink and valid mode
in ext2_iget()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46002

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25947cc5b2374cd5bf627fe3141496444260d04f]
stable/6.12: [d3af04a43db86379df7438bf8bade71685b8a239]
stable/6.18: [2dde6377ab2e46bb80cf066c659ef016f3ad7a9b]
stable/6.6: [32e0b925572686399243834ec99e2a9d85c62eae]
stable/7.0: [470264bbec499e276a89a6431144ae58f411ea4d]

CVE-2026-46003: net: qrtr: ns: Limit the total number of nodes

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46003

Introduced by commit 0c2204a ("net: qrtr: Migrate nameservice to
kernel from userspace") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [27d5e84e810b0849d08b9aec68e48570461ce313]
stable/6.12: [4665a29c08e1b36bc9db4814f9dde3d23e8fd1b0]
stable/6.18: [5cf6d5e5e3b804a44692fbf548a5179442e2e923]
stable/6.6: [4c46413661431aa60fb134cd4ecdf8beaa39f824]
stable/7.0: [8022876894d09ae485b499058c3357da683bcc5d]

CVE-2026-46004: ALSA: caiaq: Handle probe errors properly

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46004

Introduced by commit 8e3cd08 ("[ALSA] caiaq - add control API and more
input features") in v2.6.25-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [28abd224db4a49560b452115bca3672a20e45b2f]
stable/6.12: [6251e3e256337a30160ef59ab1580dde4d1acd28]
stable/6.18: [e59ecd4ee3a450db6cb4e4ecaa3efdd593f80056]
stable/6.6: [f537e3ad69609f6924a4db6b4a7f6561f5288bdd]
stable/7.0: [096dd8519cf2f768e9e14f224b627f7aaee1a9c5]

CVE-2026-46005: xfs: fix a resource leak in xfs_alloc_buftarg()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46005

Introduced by commit 6f643c5 ("xfs: implement ->notify_failure() for
XFS") in v6.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29a7b2614357393b176ef06ba5bc3ff5afc8df69]
stable/6.12: [28a6c132b8c6e5eeefa889c4fb43d65b12989d48]
stable/6.18: [5c293a1e1ef0f838772d20ae8afae4cbd87cd3f9]
stable/6.6: [82fb9da6477d08bdab954dc7bc081a41f2f9cae6]
stable/7.0: [5804cb507233ed767a83ac70527b2f6c4566ec75]

CVE-2026-46006: drm/nouveau: fix u32 overflow in pushbuf reloc bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46006

Introduced by commit a1606a9 ("drm/nouveau: new gem pushbuf interface,
bump to 0.0.16") in v2.6.34-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2fc87d37be1b730a149b035f9375fdb8cc5333a5]
stable/6.12: [d749a9a0ee4014681487e7ae549901aa8c176637]
stable/6.18: [332884f5eb79dd60a7162b079d09d39208567a31]
stable/6.6: [fa297e919d1680c38ab268ff952b1698dac987f6]
stable/7.0: [e441d5c23ec644c8d27593db3b8928e8933512a9]

CVE-2026-46007: hwmon: (powerz) Avoid cacheline sharing for DMA buffer

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46007

Introduced by commit 4381a36 ("hwmon: add POWER-Z driver") in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3023c050af3600bf451153335dea5e073c9a3088]
stable/6.12: [270e5c576a6e30f6b337fa91d35b44c241297533]
stable/6.18: [1869da3efe703b016b23d4885f3fe6c1751959c6]
stable/7.0: [2fa2273016a0483217404cfe330967c4ac6832a9]

CVE-2026-46008: mm/damon/core: fix damos_walk() vs kdamond_fn() exit race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46008

Introduced by commit bf0eaba ("mm/damon/core: implement damos_walk()")
in v6.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [33c3f6c2b48cd84b441dba1ee3e62290e53930f4]
stable/7.0: [0ba956a239ba6e3fae8555d3660e22e675be63b5]

CVE-2026-46009: PCI: endpoint: pci-epf-ntb: Remove duplicate resource teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46009

Introduced by commit 8b821cf ("PCI: endpoint: Add EP function driver
to provide NTB functionality") in v5.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3446beddba450c8d6f9aca2f028712ac527fead3]
stable/6.12: [756ca5e7ed22d9045bb4de4c981f9149278d5cd3]
stable/6.18: [65fc57c8b8f0b31be62be291cb1bb01755cec85d]
stable/6.6: [72099f015d3c77bf2eb703d1aab113bd7a60915a]
stable/7.0: [e813c95e4c8edd31599081e6356e20ada30e266d]

CVE-2026-46010: rxrpc: Fix error handling in rxgk_extract_token()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46010

Introduced by commit 64863f4 ("rxrpc: Fix unhandled errors in
rxgk_verify_packet_integrity()") in v6.17-rc7.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3476c8bb960f48e49355d6f93fb7673211e0163f]
stable/6.18: [293095ef618818852bac5488c1bc223935e2ca17]
stable/7.0: [c52803e925604e2a17962ab0c99dce2d3f7238db]

CVE-2026-46011: media: mtk-jpeg: fix use-after-free in release path
due to uncancelled work

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46011

Introduced by commit 5fb1c23 ("mtk-jpegenc: add jpeg encode worker
interface") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34c519feef3e4fcff1078dc8bdb25fbbbd10303f]
stable/6.12: [0498b27a1542021d90269d58347501d4c3ccd84e]
stable/6.18: [26506a30e0e26d612f82a7bf0e395626968a44e6]
stable/6.6: [2209fdae5c2f615930c9af1379c1cfca199ec5d8]
stable/7.0: [e78c39f720679fcf3a2eacd82725ec3ea2648301]

CVE-2026-46012: rxrpc: Fix memory leaks in rxkad_verify_response()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46012

Introduced by commit 57af281 ("rxrpc: Tidy up abort generation
infrastructure") in v6.2-rc4.
Introduced by commit ec832bd ("rxrpc: Don't retain the server key in
the connection") in v5.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34f61a07e0cdefaecd3ec03bb5fb22215643678f]
stable/6.12: [852b9d64cea421336579b2de3d1338dfa677e2dd]
stable/6.18: [861b9a0a1823bf064a7b810d29502a9ef043f40f]
stable/6.6: [c4b8f32e73eafd4a5076be890c7c8506ec04567c]
stable/7.0: [c91f33fb8356dedc82bc56ce210f1a5dbee62a52]

CVE-2026-46013: mm/memfd_luo: fix physical address conversion in
put_folios cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46013

Introduced by commit b3749f1 ("mm: memfd_luo: allow preserving memfd")
in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3538f90ab89aaf302782b4b073a0aae66904cd67]
stable/7.0: [bd0d6bde286a2b8e3ae7975b0dcc2d43875d5fc9]

CVE-2026-46014: KVM: SVM: Add missing save/restore handling of LBR MSRs

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46014

Introduced by commit 24e09cb ("KVM: SVM: enable LBR virtualization")
in v2.6.26-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3700f0788da6acf73b2df56690f4b201aa4aefd2]
stable/6.18: [2b922a42b531a82d7881add14a7698dcdc5e1f0a]
stable/7.0: [13a89ada5dcfc2539514c83ba5a2c61157f1ec6c]

CVE-2026-46015: tcp: call sk_data_ready() after listener migration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46015

Introduced by commit 54b92e8 ("tcp: Migrate
TCP_ESTABLISHED/TCP_SYN_RECV sockets in accept queues.") in v5.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3864c6ba1e041bc75342353a70fa2a2c6f909923]
stable/6.12: [bebd058ef40c67a81fe6d9ee8beaa4ede90e0704]
stable/6.18: [83bb57635d7cbafde32f865b577ecfd969f02337]
stable/6.6: [ab5fdcd535645f6dbe6e9e21d96a08d141e88b4b]
stable/7.0: [12625b4da84caf4d84a04988710a7b9bcf702b18]

CVE-2026-46016: remoteproc: xlnx: Only access buffer information if
IPI is buffered

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46016

Introduced by commit 5dfb28c ("remoteproc: xilinx: Add mailbox
channels for rpmsg") in v6.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [38dd6ccfdfbbe865569a52fe1ba9fa1478f672e6]
stable/6.12: [7ddbf21116770b7011f2bb0a6056b7604b24c497]
stable/6.18: [06d0bed2552fd0dae27d374d4492a2b672e24eed]
stable/6.6: [5d1451cb2cf6f3d9884d76035a1460aa9bb4b053]
stable/7.0: [8242579859a78c801bb626e9aa4823aca93e28e7]

CVE-2026-46017: mm: fix deferred split queue races during migration

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46017

Introduced commit is not determined.Fixed in v7.1-rc1.


Fixed status
mainline: [3bac01168982ec3e3bf87efdc1807c7933590a85]
stable/7.0: [cbf75cf212ee6e499abc1757fb4b5ae6d70ed0aa]

CVE-2026-46018: ALSA: usb-audio: stop parsing UAC2 rates at MAX_NR_RATES

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46018

Introduced by commit 4fa0e81 ("ALSA: usb-audio: fix possible hang and
overflow in parse_uac2_sample_rate_range()") in v3.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3c318f97dcc50b2e0556a1813bd6958678e881fd]
stable/6.12: [ba036305323814ec1f8655313b2fa6a0f7048716]
stable/6.18: [4d7893a137eadb6163ea4298bf67d74b811d76ef]
stable/6.6: [ab5ba9fd138758ddc50222264ff246b31e397abf]
stable/7.0: [a0b78639ef09b2e77974a3de3b1c07f6de3c5e56]

CVE-2026-46019: crypto: atmel-aes - Fix 3-page memory leak in
atmel_aes_buff_cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46019

Introduced by commit bbe628e ("crypto: atmel-aes - improve
performances of data transfer") in v4.5-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3fcfff4ed35f963380a68741bcd52742baff7f76]
stable/6.12: [65b3589d39d05699c3850202f8333e5361033ea3]
stable/6.18: [61516b4a5b2647dc3f8f67b5dffaf038be997511]
stable/6.6: [b63f1e2f0e319ad3fe4a58eb3db4fd50cc98baca]
stable/7.0: [230ad8a78fe67266b1ba4685da1abdd61471c5b8]

CVE-2026-46020: mm/damon/core: validate damos_quota_goal->nid for
node_mem_{used,free}_bp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46020

Introduced by commit 0e1c773 ("mm/damon/core: introduce damos quota
goal metrics for memory node utilization") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [40250b2dded0604a112be605f3828700d80ad7c2]
stable/6.18: [b09958e235f2b9cd3898b85a8529172afa80d212]
stable/7.0: [bcad74078708f2330a45b55358ebc38f8f4b1127]

CVE-2026-46021: thermal: core: Fix thermal zone governor cleanup issues

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46021

Introduced by commit e33df1d ("thermal: let governors have private
data for each thermal zone") in v4.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [41ff66baf81c6541f4f985dd7eac4494d03d9440]
stable/6.12: [f412e541d25a3dfaf3d53e012ade6ff03cae8a45]
stable/6.18: [75f8f3c3e09122270986de9d7aa347d701676761]
stable/6.6: [37a430a2d4e66ec8238da6c7f7e48809bf265e13]
stable/7.0: [64d4ebf91d082034bbc5ae3ba2d7fd800bc02d06]

CVE-2026-46022: misc: ibmasm: fix OOB MMIO read in
ibmasm_handle_mouse_interrupt()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46022

Introduced by commit 278d72a ("[PATCH] ibmasm driver: redesign
handling of remote control events") in v2.6.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4b6e6ead556734bdc14024c5f837132b1e7a4b84]
stable/6.12: [07c4f18b303106e6b24492c12b95d48a4b985841]
stable/6.18: [22a16d3eafee92a165c756081587c95850127107]
stable/6.6: [fc7e9a74e32299d7e93e178ca482a0b59ef1595b]
stable/7.0: [1ca75f6b74ec7f685464e5745ecfcf3a76d284e9]

CVE-2026-46023: dm mirror: fix integer overflow in create_dirty_log()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46023

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4c788c6f921b22f9b6c3f316c4a071c05683e7de]
stable/6.12: [47dad9eea75d33212d3d2cea10e7ed6a1bfc0713]
stable/6.18: [87c99a50e0fdc68a5b9b52a94d49452cd3ff02ca]
stable/6.6: [35f6b3281efd44d19110574663bc17a610bc73b9]
stable/7.0: [17a08791d428885d00e510864283a7b839792368]

CVE-2026-46024: libceph: Prevent potential null-ptr-deref in
ceph_handle_auth_reply()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46024

Introduced commit is not determined.Fixed in v7.1-rc1.


Fixed status
mainline: [5199c125d25aeae8615c4fc31652cc0fe624338e]
stable/6.12: [927e4bd5692f2a4901808822981fb2c8d4456548]
stable/6.18: [016bc663657366d386993f63eb31072eb45a2b77]
stable/6.6: [4b2738b93edad661178340239de657d876b73d3d]
stable/7.0: [8f2be7285941a33a9f72579a23b96392f83c758e]

CVE-2026-46025: mm/damon/core: fix damon_call() vs kdamond_fn() exit race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46025

Introduced by commit 42b7491 ("mm/damon/core: introduce damon_call()")
in v6.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [55da81663b9642dd046b26dd6f1baddbcf337c1e]
stable/6.18: [2691332ad88b57179c38653e2cd613d5820a52cf]
stable/7.0: [e6a053a6f4b5048746c49432a5cc5b79fe4695fe]

CVE-2026-46026: net: qrtr: ns: Limit the maximum number of lookups

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46026

Introduced by commit 0c2204a ("net: qrtr: Migrate nameservice to
kernel from userspace") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5640227d9a21c6a8be249a10677b832e7f40dc55]
stable/6.12: [76adf8f69b0bb3ab20be7c58f5d555027332d113]
stable/6.18: [20855cef7e659ef84ac73251256fa530819b2346]
stable/6.6: [0dbec101a7076e9b1e4bd1876f7cf07c56ff4ce3]
stable/7.0: [2b930bc77e00cb27e1d6e1d497b3b596283465ef]

CVE-2026-46027: net/smc: avoid early lgr access in smc_clc_wait_msg

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46027

Introduced by commit 0cfdd8f ("smc: connection and link group
creation") in v4.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a8db80f721deee8e916c2cfdee78decda02ce4f]
stable/6.12: [6180a296ca65b08a81914805cbc0f78da5f10a1f]
stable/6.18: [ea0b5d0fe96356dce38f98375a57c52a04e13712]
stable/6.6: [f0858e1d5624bb120b198f2a8528f97a9b0ae069]
stable/7.0: [83bcf9228b0501694fb2589ed1d142855a2887f2]

CVE-2026-46028: crypto: algif_aead - snapshot IV for async AEAD requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46028

Introduced by commit d887c52 ("crypto: algif_aead - overhaul memory
management") in v4.14-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [732cdd28b4b03df1ba6ec9911b598b237932cdcb]
mainline: [5aa58c3a572b3e3b6c786953339f7978b845cc52]
stable/5.10: [08ea39a556ecd39b33c2b4888861001c6706a62e]
stable/5.15: [a920cabdb0b7cf1f4e11a20524253ae5bd09092b]
stable/6.1: [fa0fcec9b49d58e71df7ede91ecd86855f608e85]
stable/6.12: [46fdb39e83227b5d39f7c934a0947ea913f13c18]
stable/6.18: [ebc235675f24b0e3f8bc92b8419471d42f837d8f]
stable/6.6: [c2138c9bd02af19e0b407376140cd5435b0d81da]
stable/7.0: [3d72f8c6490dc79210b64270740cb2a8619361a4]

CVE-2026-46029: mm/slab: return NULL early from kmalloc_nolock() in NMI on UP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46029

Introduced by commit af92793 ("slab: Introduce kmalloc_nolock() and
kfree_nolock().") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5b31044e649e3e54c2caef135c09b371c2fbcd08]
stable/6.18: [a8d95d274be241ad21f6523bf2d6ba0d7d7e46b7]
stable/7.0: [d66553204a15bdb257d9ef8aca1e12f5fbb910b2]

CVE-2026-46030: EDAC/versalnet: Fix device_node leak in mc_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46030

Introduced by commit d5fe2fe ("EDAC: Add a driver for the AMD Versal
NET DDR controller") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5c709b376460ff322580c41600e31c02f7cc0307]
stable/6.18: [b6e61356ad24987be40bf25369d22dd8dd00a513]
stable/7.0: [17e136993b2b5111d1ee1c57bbd188ae0bb0e128]

CVE-2026-46031: net: ks8851: Reinstate disabling of BHs around IRQ handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46031

Introduced by commit e086363 ("net: ks8851: Queue RX packets in IRQ
handler instead of disabling BHs") in v6.9.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [5c9fcac3c872224316714d0d8914d9af16c76a6d]
stable/6.12: [518040324067d8efaa2da1992297b7e7bf5640f4]
stable/6.18: [be8aad558b4675f45b43080f81a9ffdeddea73a5]
stable/6.6: [640a7631d31db87d5fa1b34cea44a99b6e78854b]
stable/7.0: [21f1707a8e978558dcb11b053855521e32ac0eec]

CVE-2026-46032: KVM: nSVM: Triple fault if restore host CR3 fails on
nested #VMEXIT

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46032

Introduced by commit d82aaef ("KVM: nSVM: use nested_svm_load_cr3() on
guest->host switch") in v5.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5d291ef0585ed880ed4dd71ea1a5965e0a65fb53]
stable/7.0: [9a738cf170a4a2332ea3a15e23ec65b5757fe4a1]

CVE-2026-46033: crypto: authencesn - reject short ahash digests during
instance creation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46033

Introduced by commit f15f05b ("crypto: ccm - switch to separate cbcmac
driver") in v4.11-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5db6ef9847717329f12c5ea8aba7e9f588a980c0]
stable/6.12: [67f1f0933cc3d78dde222842bcad2778ec7a0b88]
stable/6.18: [b42821c15445f93daea3e76ada682b2b7181c476]
stable/6.6: [b69933e97efea238ebbfcf70c2b1be1cd03f13e3]
stable/7.0: [9aff81e8217e9de2929084b03b3c7f81988c112b]

CVE-2026-46034: vfio/cdx: Fix NULL pointer dereference in interrupt trigger path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46034

Introduced by commit 848e447 ("vfio/cdx: add interrupt support") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5ea5880764cbb164afb17a62e76ca75dc371409d]
stable/6.12: [51bf7638f33aece41cb3f4cbeb942cc52950e329]
stable/6.18: [5d6c349c9823eb819fed8b537b088cf38126018c]
stable/7.0: [338a736aaf15e8ba3635ce20b29af5b8fc15e66a]

CVE-2026-46035: mm/page_alloc: return NULL early from
alloc_frozen_pages_nolock() in NMI on UP

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46035

Introduced by commit d7242af ("mm: Introduce
alloc_frozen_pages_nolock()") in v6.18-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [620b46ed6ae17c8438d889c8c0cfddab36a1476c]
stable/6.18: [05b4ed8bef30bba4f559c8d835e2dd20c48cf8a4]
stable/7.0: [a6d57efeaae3f3b3656514f600eac96be713d90e]

CVE-2026-46036: vfio/cdx: Serialize VFIO_DEVICE_SET_IRQS with a per-device mutex

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46036

Introduced by commit 848e447 ("vfio/cdx: add interrupt support") in v6.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [670e8864b1a218d72f08db40d0103adf38fa1d9b]
stable/6.12: [ddf96e23c366c566283fce8377928851fa7f5e81]
stable/6.18: [7b436ade16cc81095d79b79f8efa3af0a4f5c5a2]
stable/7.0: [7530f34ec0ca1438d45a75dcb43183a1cc92eced]

CVE-2026-46037: ipv4: icmp: validate reply type before using icmp_pointers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46037

Introduced by commit d329ea5 ("icmp: add response to RFC 8335 PROBE
messages") in v5.13-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [67bf002a2d7387a6312138210d0bd06e3cf4879b]
stable/6.12: [bc64a66e0b9ad937d3d49934242ee62b01ba9a94]
stable/6.18: [c2178ff1c70ebfc2ab9651b230c58a34683db759]
stable/6.6: [92e7c209036dcc0e8ffdf806fdfd3645b263bea5]
stable/7.0: [d700c34a5d186b9ba0715bcb19e0ff80ffbfbfc1]

CVE-2026-46038: net: qrtr: ns: Free the node during ctrl_cmd_bye()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46038

Introduced by commit 0c2204a ("net: qrtr: Migrate nameservice to
kernel from userspace") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [68efba36446a7774ea5b971257ade049272a07ac]
stable/6.12: [65932f5102bb5377db36c8a4f0c28179a1967a9a]
stable/6.18: [154fc7fe3f62c46891c3c4302f4b5b5391c932e6]
stable/6.6: [ff78ed177a66763085e3214d6fbe13ca8f0b3f11]
stable/7.0: [076e4b162d6caba12c229e7f262df5b6881162b0]

CVE-2026-46039: rxgk: Fix potential integer overflow in length check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46039

Introduced by commit 2429a19 ("rxrpc: Fix untrusted unsigned
subtract") in v6.17-rc7.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6929350080f4da292d111a3b33e53138fee51cec]
stable/6.18: [43222ac484f93b3ec2d240a7575e1cedd31f5fa4]
stable/7.0: [183d37f12d1c8ed24a5bfc7addad05510da22a94]

CVE-2026-46040: inotify: fix watch count leak when
fsnotify_add_inode_mark_locked() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46040

Introduced by commit 1cce1ee ("inotify: Convert to using per-namespace
limits") in v4.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a320935fa4293e9e599ec9f85dc9eb3be7029f8]
stable/6.12: [73ddc8518a32baff6bc17afda4ee1ebae5b4ed12]
stable/6.18: [fdaa42ca370d056428e5e171247c8fdce8dff36a]
stable/6.6: [8bcc1cd237ab5ccfdd102869fa031c541943cf40]
stable/7.0: [9e48844f708eb48bae4e79cb21edc097c966306d]

CVE-2026-46041: greybus: gb-beagleplay: fix sleep in atomic context in
hdlc_tx_frames()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46041

Introduced by commit ec558bb ("greybus: Add BeaglePlay Linux Driver")
in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6b526dca0966f2370835765019a54319b78fca8d]
stable/6.12: [9f2b87bcdfed55145acbf932dc12f2c057145cad]
stable/6.18: [b2801647c203a38e013802e9e9616b5bfac64968]
stable/7.0: [51667fe2d9294d66e0228b9f51d1f01b6680a641]

CVE-2026-46042: mm/mempolicy: fix memory leaks in
weighted_interleave_auto_store()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46042

Introduced by commit e341f9c ("mm/mempolicy: Weighted Interleave
Auto-tuning") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fae274ce0e3109cbbc4c18b354eaace1f0af7d7]
stable/6.18: [c42a7efb9060d89b72708ffaf255d0002c2164a7]
stable/7.0: [39caa9ca863f96b3d00447c5aa200cabda489856]

CVE-2026-46043: RDMA/rxe: Validate pad and ICRC before payload_size() in rxe_rcv

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46043

Introduced by commit 8700e3e ("Soft RoCE driver") in v4.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7244491dab347f648e661da96dc0febadd9daec3]
stable/6.12: [f83519a4c122c9c7a850a2197648a9ff4c67c520]
stable/6.18: [9b924f3a26b21330a837cfe72e819b6393bbeeaa]
stable/6.6: [2fd4f8b749309a61c3f3f88ee8891d94f79e1240]
stable/7.0: [e8ee0e792d475b1067c199ef0af1b6221fa6f43d]

CVE-2026-46044: ipmi:ssif: Clean up kthread on errors

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46044

Introduced by commit 2593070 ("ipmi: Add SMBus interface driver
(SSIF)") in v3.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [75c486cb1bcaa1a3ec3a6438498176a3a4998ae4]
stable/6.18: [858bc8b9edb6eaf0522900128bb9053e2df6b0f6]
stable/6.6: [07f9bff69da84e462178d3f0ad1b32f19f13ad94]
stable/7.0: [800febc637d1c1974b1e899dea8a07e115d60766]

CVE-2026-46045: md/md-llbitmap: skip reading rdevs that are not in_sync

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46045

Introduced by commit 5ab829f ("md/md-llbitmap: introduce new lockless
bitmap") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7701e68b5072faa03a8f30b4081dc16df9092381]
stable/6.18: [98623c7e2a51eab1833c8628d33fa9c6ef3ce325]
stable/7.0: [3115fa2f62970d98f2a639145fb8e2767db8bbf9]

CVE-2026-46046: ext4: fix missing brelse() in ext4_xattr_inode_dec_ref_all()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46046

Introduced by commit c8e008b ("ext4: ignore xattrs past end") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/6.1 stable/6.12
stable/6.6

Fixed status
mainline: [77d059519382bd66283e6a4e83ee186e87e7708f]
stable/6.12: [097227f1ffe1a85bc3c359f81c71e3d40e06e920]
stable/6.18: [1e6b0a69bf2c9c819255c7566e4355536d81d9cf]
stable/6.6: [1bc1107a3a403a6d440673ed6666f7b07ef868a8]
stable/7.0: [f072906688933bf47fabbaf63560be03357c8298]

CVE-2026-46047: net: qrtr: ns: Fix use-after-free in driver remove()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46047

Introduced by commit 0c2204a ("net: qrtr: Migrate nameservice to
kernel from userspace") in v5.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7809fea20c9404bfcfa6112ec08d1fe1d3520beb]
stable/6.12: [db3c60ec772de30acae92d560dfcc5258e58dbe8]
stable/6.18: [2e127ceb1c415e246076d8e09e23e443a7a2038f]
stable/6.6: [0f313eb6a8f6dffa491373cf3afab979fa1c02f4]
stable/7.0: [f96779e916576e81430ebb326baff6e433fef8ae]

CVE-2026-46048: ALSA: caiaq: fix usb_dev refcount leak on probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46048

Introduced by commit 80bb50e ("ALSA: caiaq: take a reference on the
USB device in create_card()") in v7.1-rc1.
Fixed in v7.1-rc2.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6 stable/7.0

Fixed status
mainline: [7a5f1cd22d47f8ca4b760b6334378ae42c1bd24b]
stable/6.12: [da3b8fd6a202d94fef11a443abc9171c52426a1c]
stable/6.18: [6153878c5255bb69b7d0868105ca078ef13cbcf8]
stable/6.6: [50c6a1f05973f56d23280c9d7645a7a5734e0907]
stable/7.0: [21ca595aafa40d3ac70eab1f4cb62cc00ca21657]

CVE-2026-46049: ALSA: ctxfi: Add fallback to default RSR for S/PDIF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46049

Introduced by commit 8cc7236 ("ALSA: SB X-Fi driver merge") in v2.6.31-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7d61662197ecdc458e33e475b6ada7f6da61d364]
stable/6.12: [30f9494c6f2b53a78822cfb653ffbb1d092d44c8]
stable/6.18: [09496158f6ebba8830593f8972035c02f97124c1]
stable/6.6: [25ded535ee261161bcf19dafd525c542e606559d]
stable/7.0: [95b1ee8442cabbde83b2848e7c6100df90f3a00d]

CVE-2026-46050: md/raid10: fix deadlock with check operation and nowait requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46050

Introduced by commit 43806c3 ("raid10: cleanup memleak at
raid10_make_request") in v6.16-rc6.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [7d96f3120a7fb7210d21b520c5b6f495da6ba436]
stable/6.12: [42fe37c90184cd1568838b84b488934c3671c963]
stable/6.18: [cac2106bb9a2180b288079b49ed626414fb5bc45]
stable/6.6: [965d6162dd88cc7cc193cf7f5bfc132d8bbf0523]
stable/7.0: [1cdff2937c618f81058422bbdc4974a3e7ec9379]

CVE-2026-46051: md/raid5: fix soft lockup in retry_aligned_read()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46051

Introduced by commit 773ca82 ("raid5: make release_stripe lockless")
in v3.12-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7f9f7c697474268d9ef9479df3ddfe7cdcfbbffc]
stable/6.12: [80fc6ca2cbde018d52e13f305edcd643911bd94b]
stable/6.18: [1985cb3247e87ff6b8ca4bc5f9626f4f51024507]
stable/6.6: [09880592f5a9dc73377d6eb5ac123537b5f8df49]
stable/7.0: [883cc33b7af1c448663287f069ef9dfea001e90f]

CVE-2026-46052: ceph: only d_add() negative dentries when they are unhashed

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46052

Introduced by commit 2817b00 ("ceph: directory operations") in v2.6.34-rc2.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [803447f93d75ab6e40c85e6d12b5630d281d70d6]
stable/6.12: [4179cc390dacebc87079419ec92f86f3dc46294d]
stable/6.18: [b91e535f208c48a5e7464f1aa38338a30e7912df]
stable/6.6: [83ce43a21bb7df8dd52228afdd918d2d058eefde]
stable/7.0: [2010cb06b9df7d3c816c78358c566bdacbdf38ff]

CVE-2026-46053: net: rds: fix MR cleanup on copy error

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46053

Introduced by commit 0d4597c ("net/rds: Track user mapped pages
through special API") in v5.6-rc3.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8141a2dc70080eda1aedc0389ed2db2b292af5bd]
stable/6.12: [d95cea9298be1ba8876e3f156be96d3a492085ca]
stable/6.18: [033370ffb3c9c0264d19f8ba9ef769523266589a]
stable/6.6: [8fdbb6262a4a3ed44a0830a7793903b54bb27bdc]
stable/7.0: [b3cb8cae530b2727d8245684148bb49425f6765c]

CVE-2026-46054: selinux: fix overlayfs mmap() and mprotect() access checks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46054

Introduced commit is not determined.Fixed in v7.1-rc1.


Fixed status
mainline: [82544d36b1729153c8aeb179e84750f0c085d3b1]
stable/7.0: [cd0e707a927a70cdfd8bc5a512a9719a87f5ed51]

CVE-2026-46055: apparmor: Fix string overrun due to missing termination

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46055

Introduced by commit 93d4dbd ("apparmor: Replace deprecated strcpy in
d_namespace_path") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [828bf7929bedcb79b560b5b4e44f22abee07d31b]
stable/7.0: [4b877ef27adc8ec187b0418629169856e7264e01]

CVE-2026-46056: Bluetooth: hci_event: fix potential UAF in SSP passkey handlers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46056

Introduced by commit 92a2525 ("Bluetooth: mgmt: Implement support for
passkey notification") in v3.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85fa3512048793076eef658f66489112dcc91993]
stable/6.12: [01a6431766c35dfedb86e0cb5d3fc80c6d604a47]
stable/6.18: [e08d75753db17aa943d7622f09d9c217b5bfd3b8]
stable/6.6: [204028af77a265e31ceb4ba7f643349a3cca72b2]
stable/7.0: [8c6443bb9257b780986fb67ec08565bf48ecb8d7]

CVE-2026-46057: landlock: Fix LOG_SUBDOMAINS_OFF inheritance across fork()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46057

Introduced by commit ead9079 ("landlock: Add
LANDLOCK_RESTRICT_SELF_LOG_SUBDOMAINS_OFF") in v6.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [874c8f83826c95c62c21d9edfe9ef43e5c346724]
stable/6.18: [2fcde49092aac55d5beef43fdd3633217672f7d1]
stable/7.0: [1c513b8a00df13d231021e74ad92babb3fedf64a]

CVE-2026-46058: media: amphion: Fix race between m2m job_abort and device_run

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46058

Introduced by commit 3cd0845 ("media: amphion: add vpu v4l2 m2m
support") in v5.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8cd35ceadcfc8c5da2eb7f7ce24525ce9d4ee62e]
stable/6.12: [da4f46c5cf1d26e6b09418ad453e152f2e75a02c]
stable/6.18: [fdc150dac1adb9a98be9d6956cff0348838b024a]
stable/6.6: [42dc622776f3ce1a6c31b13bdc686f7295e3b323]
stable/7.0: [6be2cb75bc1300080cfc8051579f22efae9401f7]

CVE-2026-46059: KVM: nSVM: Always use NextRIP as vmcb02's NextRIP
after first L2 VMRUN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46059

Introduced by commit cc440cd ("KVM: nSVM: implement
KVM_GET_NESTED_STATE and KVM_SET_NESTED_STATE") in v5.8-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8d397582f6b5e9fbcf09781c7c934b4910e94a50]
stable/6.18: [3428ed1529a1af4cce5aff6c5bd2fcc39ad726bb]
stable/7.0: [69fe1411a5ce678b4da6489b5d2282b4e1d13acf]

CVE-2026-46060: crypto: qat - fix IRQ cleanup on 6xxx probe failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46060

Introduced by commit 17fd751 ("crypto: qat - add qat_6xxx driver") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [95aed2af87ec43fa7624cc81dd13d37824ad4972]
stable/6.18: [27f561bf894e46bdc2d6209c50884adad79d8277]
stable/7.0: [7cd651f1357dcc477e6483c3a4706836b46bdc92]

CVE-2026-46061: jbd2: fix deadlock in jbd2_journal_cancel_revoke()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46061

Introduced by commit f76d4c2 ("fs/jbd2: use sleeping version of
__find_get_block()") in v6.15-rc4.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [981fcc5674e67158d24d23e841523eccba19d0e7]
stable/6.12: [dff07cc98fdf6af57a7c054dc09b2050a9d5c287]
stable/6.18: [2b2fee890250ab647a601124471a334bb01a0790]
stable/7.0: [bbd943d6a2d566428324b516a37f98328dfb802d]

CVE-2026-46062: ntfs3: fix integer overflow in run_unpack() volume
boundary check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46062

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [984a415f019536ea2d24de9010744e5302a9a948]
stable/6.12: [60dab3e2931f3d792438a77a6cb0cb731c43300b]
stable/6.18: [f1af27cec07a9fd0847166bdb23c99e86b05bfdc]
stable/6.6: [a954061b334ec67c79ae9d0cadd83fa521396487]
stable/7.0: [6175d09c23bec4b60860ee9a0170308ff4b56e10]

CVE-2026-46063: x86/shstk: Prevent deadlock during shstk sigreturn

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46063

Introduced by commit 7fad2a4 ("x86/shstk: Check that signal frame is
shadow stack mem") in v6.6-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9874b2917b9fbc30956fee209d3c4aa47201c64e]
stable/6.12: [d042d69b417515959e49021fef008c9b04a99bd5]
stable/6.18: [4f3374c990fb2adec06d20fd6d780927811c9aa0]
stable/6.6: [e2c2b044458cbf22da05264fa707308e8d4f86f9]
stable/7.0: [3d29db827502067626062f5c74dd502d14ab15bc]

CVE-2026-46064: ibmasm: fix heap over-read in ibmasm_send_i2o_message()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46064

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9aad71144fa3682cca3837a06c8623016790e7ec]
stable/6.12: [fe31722b0194ff76bf8b461e8bf97a2081147787]
stable/6.18: [c1c2417c60dbdca5ebb00462f21ee71c2d7f7083]
stable/6.6: [fd19eb1c75047a4ed4e855f56cafd704dc3914e0]
stable/7.0: [9e8f6c9d4ecddda2f28baa1678340286cff3969c]

CVE-2026-46065: fbdev: defio: Disconnect deferred I/O from the
lifetime of struct fb_info

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46065

Introduced by commit 60b59be ("fbdev: mm: Deferred IO support") in v2.6.22-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9ded47ad003f09a94b6a710b5c47f4aa5ceb7429]
stable/6.12: [2b53d3a52e8e5403a4f4fb57ac6cad3fd2cb1066]
stable/6.18: [25c2b77bc463f29ee71a54b883548baf9386a0db]
stable/6.6: [2a40f8bc9bb713329f1c35ffc199ee961a7135b0]
stable/7.0: [a0aafb421dd15e935d81543152617f2742cefa70]

CVE-2026-46066: ceph: fix num_ops off-by-one when crypto allocation fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46066

Introduced by commit d552077 ("ceph: add encryption support to
writepage and writepages") in v6.6-rc1.
Introduced by commit cac190c ("ceph: fix write storm on fscrypted
files") in v7.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [a0d9555bf9eaeba34fe6b6bb86f442fe08ba3842]
stable/6.18: [6200f41d6fcf2ac7e24866431e381cbc914560e4]
stable/7.0: [ba12c1e578890f6337a415b7dedf476c6d455105]

CVE-2026-46067: mm/damon/core: validate damos_quota_goal->nid for
node_memcg_{used,free}_bp

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46067

Introduced by commit b74a120 ("mm/damon/core: implement
DAMOS_QUOTA_NODE_MEMCG_USED_BP") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a34dac6482e53e2c76944f25b1489b9b7da3a6e6]
stable/7.0: [da10db73ada26345244ea5dc52f974692bd05f66]

CVE-2026-46068: crypto: nx - fix bounce buffer leaks in
nx842_crypto_{alloc,free}_ctx

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46068

Introduced by commit ed70b47 ("crypto: nx - add hardware 842 crypto
comp alg") in v4.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [adb3faf2db1a66d0f015b44ac909a32dfc7f2f9c]
stable/6.12: [910bb34b801d39794e656f7d48414844b2bd354e]
stable/6.18: [5c07962fed66e1238fad7635fa150570bd38b4c5]
stable/6.6: [6923cde8dc1d501e79b312139819c88b54463803]
stable/7.0: [80fd99d7c30ea889662d21f1b44d8fea4c83138d]

CVE-2026-46069: wifi: mwifiex: fix use-after-free in mwifiex_adapter_cleanup()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46069

Introduced by commit 4636187 ("mwifiex: add wakeup timer based
recovery mechanism") in v4.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae5e95d4157481693be2317e3ffcd84e36010cbb]
stable/6.12: [63fe3389b3e092d6c0eeea9fc0318e7918b16618]
stable/6.18: [4e179a60a60c0a5aea245e8e67768343c0f070b8]
stable/6.6: [11869ce402d95519d49b25a2a97741f68d69d103]
stable/7.0: [030abbae49cf9fd1fba7aa08e15ec81efbeb78cf]

CVE-2026-46070: md/raid5: validate payload size before accessing
journal metadata

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46070

Introduced by commit b4c625c ("md/r5cache: r5cache recovery: part 1")
in v4.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b0cc3ae97e893bf54bbce447f4e9fd2e0b88bff9]
stable/6.12: [c3a1cf78bd1bbb51b2cc5189b4743056553c1e0e]
stable/6.18: [73ce72edd113374801045924d4417199963f73a3]
stable/6.6: [33698bd1b2db9764a29df7751533d33967ff5c98]
stable/7.0: [406aa86394ead347c47428fb51b6359bdaa2257d]

CVE-2026-46071: KVM: nSVM: Avoid clearing VMCB_LBR in vmcb12

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46071

Introduced by commit d20c796 ("KVM: x86: nSVM: implement nested LBR
virtualization") in v5.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b53ab5167a81537777ac780bbd93d32613aa3bda]
stable/6.18: [a3f0981a5a0e0bd51ad74cc7d9eed32294b24002]
stable/7.0: [9efe23568806d1cd06f7d146f9b3037b8d585a9f]

CVE-2026-46072: ntfs3: add buffer boundary checks to run_unpack()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46072

Introduced by commit 82cae26 ("fs/ntfs3: Add initialization of super
block") in v5.15-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b62567bca47408e6739dee75f02a2113548af875]
stable/6.12: [e64f7dfcaff79e7dfff9121a382dd77f9b462f62]
stable/6.18: [d3012690a7065d9ca86521a525ad11e8af491d45]
stable/6.6: [bf7ac4a1d3bfc6e56e54635c3d331a68170d37c9]
stable/7.0: [41aadf5cb482793a24e05aa136224e179a778586]

CVE-2026-46073: hwmon: (powerz) Fix missing usb_kill_urb() on signal interrupt

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46073

Introduced by commit 4381a36 ("hwmon: add POWER-Z driver") in v6.7-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b66437cb20a2d9ef201f40b675569f8ea7787c9f]
stable/6.12: [8b51277eec433d4e724b273a5a5c64e8acfbe405]
stable/6.18: [b6cb07f02253bdefd2339e57eaa1428a7b28cd0f]
stable/7.0: [d64458784036f5818e22781254b6be299d52a19c]

CVE-2026-46074: spi: ch341: fix memory leaks on probe failures

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46074

Introduced by commit 8846739 ("spi: add ch341a usb2spi driver") in v6.11-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b99e3ddb91b499d920e63a2daff8880be68cfe9e]
stable/6.12: [5c6518633702d7f7b1153e9d8e042af847f11ef3]
stable/6.18: [ff8a7996dc8bf433efe2126ffdaee5b374a89e30]
stable/7.0: [9bee2faf9e21c796d0d222c9d84a98f41bd303a0]

CVE-2026-46075: crypto: atmel-sha204a - Fix potential UAF and memory
leak in remove path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46075

Introduced by commit da001fb ("crypto: atmel-i2c - add support for
SHA204A random number generator") in v5.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bab1adf3b87e4bfac92c4f5963c63db434d561c1]
stable/6.12: [775c00d87c385b758da9504cf053acea00e2ed40]
stable/6.18: [1193c12126d39bf986a5a9214827b73707b193ab]
stable/6.6: [c5a45d14234bf26e28a89e3a5dcc08336595cf11]
stable/7.0: [31901371ccd16b42d2f167b1018ba9ae8bd5a6c7]

CVE-2026-46076: KVM: nSVM: Raise #UD if unhandled VMMCALL isn't
intercepted by L1

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46076

Introduced by commit 3f4a812 ("KVM: nSVM: hyper-v: Enable L2 TLB
flush") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c36991c6f8d2ab56ee67aff04e3c357f45cfc76c]
stable/6.12: [924d721fae95687acedbaf624a094ed0e8b67104]
stable/6.18: [009c0f726abeaa67aad1d96b883bdce01d405ce2]
stable/7.0: [5fb4a5f361565f5b629d8a8fe5288ce8463c5727]

CVE-2026-46077: crypto: atmel-tdes - fix DMA sync direction

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46077

Introduced by commit 1380200 ("crypto: atmel - add Atmel DES/TDES
driver") in v3.6-rc1.
Introduced by commit 1f85804 ("crypto: atmel-tdes - add support for
latest release of the IP (0x700)") in v3.10-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c8a9a647532f5c2a04180352693215e24e9dba03]
stable/6.12: [12a0adfe498cd5d87e6365d7ca5f6b3eed79e523]
stable/6.18: [863d11b3927703ad95077c81a8a6489c5c7872f7]
stable/6.6: [5281e6e2302362f6b75b70cbfe4098d2a25dafd9]
stable/7.0: [b5f5df801d161ba244f391519cbff2f4e5c6edc2]

CVE-2026-46078: erofs: fix the out-of-bounds nameoff handling for
trailing dirents

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46078

Introduced by commit 3aa8ec7 ("staging: erofs: add directory
operations") in v4.19-rc1.
Introduced by commit 33bac91 ("staging: erofs: keep corrupted fs from
crashing kernel in erofs_readdir()") in v5.1-rc3.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [d18a3b5d337fa412a38e776e6b4b857a58836575]
stable/6.12: [48b27a955d22391c7f30169fa7b6b2e1977f1ce4]
stable/6.18: [8ebb951a284b7446e025afc7dc5e9516ef9a7214]
stable/6.6: [222055e6b4063abd2d9e13c3d49bbd1724c50789]
stable/7.0: [1d55445226c75ddd4e78b09b3e7d99109b28c366]

CVE-2026-46079: rbd: fix null-ptr-deref when device_add_disk() fails

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46079

Introduced by commit 27c97ab ("rbd: add add_disk() error handling") in
v5.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d1fef92e414433ca7b89abf85cb0df42b8d475eb]
stable/6.12: [564cd8f4aeb9a938e470c5c91922fd02e4d41acc]
stable/6.18: [ad0126ffcba8777109852979eaaa6dca6703abdb]
stable/6.6: [2f4809a879f0750c7790bbeeae86c9505797a06f]
stable/7.0: [059fb7656723c1b77c2fc0e64b7aa99d6bb65e8e]

CVE-2026-46080: ocfs2: split transactions in dio completion to avoid
credit exhaustion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46080

Introduced commit is not determined.Fixed in v7.1-rc1.


Fixed status
mainline: [d647c5b2fbf81560818dacade360abc8c00a9665]
stable/6.12: [ea5bb1d20da756e4f41a48dad42b2e7d6e73f71e]
stable/6.18: [3c636a3edca9c3f180b3079f94fe7e115730d9c6]
stable/6.6: [886f97fa59d0bbfa9859fb1a66dd9e014b522d89]
stable/7.0: [069c3fb310e9336cf48cfdf8748a32c29fd0193d]

CVE-2026-46081: crypto: acomp - fix wrong pointer stored by acomp_save_req()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46081

Introduced by commit 64929fe ("crypto: acomp - Remove request
chaining") in v6.16-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d7e20b9bd6c990773cf0c09e2642250b8a70263d]
stable/6.18: [343a5bf68a8ff9affcf2b70677ea4cf40c195ee4]
stable/7.0: [1a2785e5985627f2265ba7775949601a29ba0d1e]

CVE-2026-46082: KVM: SVM: Inject #UD for INVLPGA if EFER.SVME=0

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46082

Introduced by commit ff09238 ("KVM: SVM: Implement INVLPGA") in v2.6.32-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d99df02ff427f461102230f9c5b90a6c64ee8e23]
stable/6.12: [643125b66ffc1147c66616b749475ba9efb15971]
stable/6.18: [c15392ed9e49c1a16b4d3a3ccf1b3bf2318a6c28]
stable/6.6: [3ac9d4241d205f5d0df06358349ca718ebb0fa12]
stable/7.0: [ee24928ecd85db4b68ed111e91fef36af0ca37b0]

CVE-2026-46083: spi: fix resource leaks on device setup failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46083

Introduced by commit c7299fe ("spi: Fix spi device unregister flow")
in v5.13-rc4.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/5.10 cip/5.10-rt stable/5.10

Fixed status
mainline: [db357034f7e0cf23f233f414a8508312dfe8fbbe]
stable/6.12: [1e774294b2f944f59e03a04eb438768a4b93c3ce]
stable/6.18: [11baa8b24bcb07ae2048f2566a220021d766abe0]
stable/6.6: [a2c817c629430fbbd54273525b472dac96e2c8fd]
stable/7.0: [dbcead54b12468d9aa54c0e1f0042d838ec3b0ae]

CVE-2026-46084: RDMA/mana_ib: Disable RX steering on RSS QP destroy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46084

Introduced by commit 0266a17 ("RDMA/mana_ib: Add a driver for
Microsoft Azure Network Adapter") in v6.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbeb256e8dd87233d891b170c0b32a6466467036]
stable/6.12: [f1ccc4d500a0b87a5599343fc2f798048836e184]
stable/6.18: [8ba804869382ce307f2a15f5f6f2adfd791f41dc]
stable/6.6: [6a2d6273b6c3581ce7b90ce17b5cbb4efd19438f]
stable/7.0: [3be5ed233de03b00ae868cfc06e95331d8d9007c]

CVE-2026-46085: rxrpc: Fix rxkad crypto unalignment handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46085

Introduced by commit f93af41 ("rxrpc: Fix missing error checks for
rxkad encryption/decryption failure") in v7.0.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.6

Fixed status
mainline: [def304aae2edf321d2671fd6ca766a93c21f877e]
stable/6.12: [440d20d95e844b657a93a0b2dcc2aae155efdce6]
stable/6.18: [f0d3efd03b2a9e0f1ffa6df8fcb264af3d494286]
stable/6.6: [f1c6bd0cc786a8fa74829ce3c4b3673944a308f4]
stable/7.0: [af9271eb666d07b6f65612dc160a47f7cb5220ed]

CVE-2026-46086: net: bridge: use a stable FDB dst snapshot in RCU readers

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46086

Introduced by commit 960b589 ("bridge: Properly check if local fdb
entry can be deleted in br_fdb_change_mac_address") in v3.14-rc3.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [df4601653201de21b487c3e7fffd464790cab808]
stable/6.12: [81af4137a30c4c2dc694dea8cacb180bd66000ef]
stable/6.18: [5424e678f9b304e148cf5dcc047cffc7a56a3bb5]
stable/6.6: [0b9e4bbfb7c949151e3acd44ed4aa33614d2e110]
stable/7.0: [9a2d9d4e657b23dc21f24cf139e3aeff0b61341f]

CVE-2026-46087: mm/damon/stat: fix memory leak on damon_start()
failure in damon_stat_start()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46087

Introduced by commit 369c415 ("mm/damon: introduce DAMON_STAT module")
in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e04ed278d25bf15769800bf6e35c6737f137186f]
stable/6.18: [8a62c58411cbd748d7aeab0e5b0963e33ff47a7a]
stable/7.0: [50bc1d7e0f3bb6932c8dc5da0907eead0790176b]

CVE-2026-46088: ALSA: control: Validate buf_len before strnlen() in
snd_ctl_elem_init_enum_names()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46088

Introduced by commit 8d44816 ("ALSA: control: add support for
ENUMERATED user space controls") in v3.2-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e0da8a8cac74f4b9f577979d131f0d2b88a84487]
stable/6.12: [8ba0214c3dd32b8ec652947e3f2bc5b8f6e6be9e]
stable/6.18: [654c818a69c21d2bea4e8fd9eae7da865df9a5c8]
stable/6.6: [1fbe46d2b72754d8bd580e13e59ccb5d3d0e8cb0]
stable/7.0: [82012fd3e78a14360fbc2f1a7491589896704f97]

CVE-2026-46089: zram: do not forget to endio for partial discard requests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46089

Introduced by commit 0120dd6 ("zram: make zram_bio_discard more
self-contained") in v6.4-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e3668b371329ea036ff022ce8ecc82f8befcf003]
stable/6.12: [35d3300f6357cfaa72db2721dc2b345b19bac5df]
stable/6.18: [a02363f71a79b755daa78a70d6b217f9c13c8c85]
stable/6.6: [2d1f18efccdb8b29552399d024c36b705447e975]
stable/7.0: [68ce397e8236088fc53b9532d383a722288c8194]

CVE-2026-46090: ALSA: aloop: Fix peer runtime UAF during format-change stop

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46090

Introduced by commit 597603d ("ALSA: introduce the snd-aloop module
for the PCM loopback") in v2.6.37-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e5c33cdc6f402eab8abd36ecf436b22c9d3a8aff]
stable/6.12: [03f52a9c170431e8f10e156b9dc0dae80b3e9198]
stable/6.18: [bdd9503c3d222d2735b56c7a8b4422ccf3de6e5c]
stable/7.0: [5d45e34bf001344e2966dabca1897561bbc9e913]

CVE-2026-46091: media: rc: igorplugusb: heed coherency rules

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46091

Introduced by commit b1c9719 ("[media] rc: port IgorPlug-USB to
rc-core") in v3.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eac69475b01fe1e861dfe3960b57fa95671c132e]
stable/6.12: [0be8fcd9005e3d3b5a61fe34b070a9663adbb4dc]
stable/6.18: [0adac0ee2c42027d80bac02ea9b576a88f8955d3]
stable/6.6: [18d6a7c9e4e63c57157e9a57dd9bf3cd38e4c45a]
stable/7.0: [a62ca67e3c72fb297dc7c86495ba8f7329d7f150]

CVE-2026-46092: wifi: rtw88: check for PCI upstream bridge existence

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46092

Introduced by commit 24f5e38 ("rtw88: Disable PCIe ASPM while doing
NAPI poll on 8821CE") in v5.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [eb101d2abdcccb514ca4fccd3b278dd8267374f6]
stable/6.12: [6c53d68e3bcfc8faccdd76c3383a9232b05c9ae6]
stable/6.18: [000134a20bbf89b1152520a2eef71f91fdb83a5b]
stable/6.6: [cc9b6303e7ea91bc360b42c7edc1fe9ceb2f47fe]
stable/7.0: [3bbbb56204f7359ce2139a9341b43b52a186261c]

CVE-2026-46093: mm/vmalloc: take vmap_purge_lock in shrinker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46093

Introduced by commit 7679ba6 ("mm: vmalloc: add a shrinker to drain
vmap pools") in v6.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ec05f51f1e65bce95528543eb73fda56fd201d94]
stable/6.18: [687ccdf582169cd680aeaf24cc953807c4cd4345]
stable/7.0: [12f2341b4c235d5593a433abac201c1c6725787f]

CVE-2026-46094: ext4: fix bounds check in check_xattrs() to prevent
out-of-bounds access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46094

Introduced by commit 3478c83 ("ext4: improve xattr consistency
checking and error reporting") in v6.3-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [eceafc31ea7b42c984ece10d79d505c0bb6615d5]
stable/6.12: [5a5314d2387633a272a04d1bd8727f99058e4e68]
stable/6.18: [537e065977022aa22f2c2503e8accaf16622e0fd]
stable/6.6: [ab6da97bc310db35d4e4ef5354bc3ff626b0698c]
stable/7.0: [520986722dbf869c122252123fc161c7302eab7d]

CVE-2026-46095: md/md-llbitmap: raise barrier before state machine transition

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46095

Introduced by commit 5ab829f ("md/md-llbitmap: introduce new lockless
bitmap") in v6.18-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ef4ca3d4bf09716cff9ba00eb0351deadc8417ab]
stable/6.18: [9142f00a9287ca38152717e3e88a033a27774e7f]
stable/7.0: [9701d51dd378380ba05293fa391e8ba01065ae8d]

CVE-2026-46096: tpm2-sessions: Fix missing tpm_buf_destroy() in
tpm2_read_public()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46096

Introduced by commit bda1cbf ("tpm2-sessions: Fix tpm2_read_public
range checks") in v6.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18

Fixed status
mainline: [f0f75a3d98b7959a8677b6363e23190f3018636b]
stable/6.18: [f8775d9d9062da662cc861f9ff7722a65896d4cd]
stable/7.0: [2f434be87e256fd58254f60ddf5d7d58e775ca0b]

CVE-2026-46097: Input: edt-ft5x06 - fix use-after-free in debugfs teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46097

Introduced by commit 68743c5 ("Input: edt-ft5x06 - use per-client
debugfs directory") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f5f9e07060519e2287e99019a6de1eb3ebb65c37]
stable/6.18: [a516d43886623e3cca5fa3446bed8fc7c7982be2]
stable/7.0: [9f6c5e7b747d40e1c65cbfcb975857d25154c075]

CVE-2026-46098: net: caif: clear client service pointer on teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46098

Introduced by commit 43e3692 ("caif: Move refcount from service layer
to sock and dev.") in v3.0-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f7cf8ece8cee3c1ee361991470cdb1eb65ab02e8]
stable/6.12: [3ac6db584d9d420267bb8413115707eeec76d9cf]
stable/6.18: [63d21a3aa0108b9dde4e99b0d3d5d679ac68c0f9]
stable/6.6: [914c6456fcfc21a3d553945dff62fd1621d6155d]
stable/7.0: [a4b191ddc12c55ddb62feb096536f819f384d6f1]

CVE-2026-46099: net: ipv6: fix NOREF dst use in seg6 and rpl lwtunnels

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46099

Introduced by commit af4a220 ("ipv6: sr: use dst_cache in seg6_input")
in v4.12-rc1.
Introduced by commit a7a29f9 ("net: ipv6: add rpl sr tunnel") in v5.7-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f9c52a6ba9780bd27e0bf4c044fd91c13c778b6e]
stable/6.12: [52f9db67f8f35f436366cf4980b4f0a2583d0ef0]
stable/6.18: [b778b6d095421619c331fd2d7751143cd5387103]
stable/6.6: [6bd17925bd6866027a6555db17905b9fc073d38d]
stable/7.0: [9dd5481f960e337b81d7dfe429529495c1c481c0]

CVE-2026-46100: fs: afs: revert mmap_prepare() change

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46100

Introduced by commit 9d5403b ("fs: convert most other
generic_file_*mmap() users to .mmap_prepare()") in v6.17-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbfc6578eaca12daa0c09df1e9ba7f2c657b49da]
stable/6.18: [f51f85c044809fbd39ac8ae07ac99bc43ce32bd5]
stable/7.0: [48c7a0eaeea41da17d1d84d2d7a4c40be122b246]

CVE-2026-46101: netfilter: reject zero shift in nft_bitwise

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46101

Introduced by commit 567d746 ("netfilter: bitwise: add support for
shifts.") in v5.6-rc1.
Fixed in v7.1-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe11e5c40817b84abaa5d83bfb6586d8412bfd07]
stable/6.12: [ca24f1243ad1a4d12d6a23876bbbe3ed02099853]
stable/6.18: [6f820139d16a4c9865a145d4a9cf9c92cc632c14]
stable/6.6: [bffef0acec9c3b837a785248a893137fb7f26c95]
stable/7.0: [f370205974f171a5868c13ff30d7642fed46e47b]

CVE-2026-46102: net: strparser: fix skb_head leak in strp_abort_strp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46102

Introduced by commit 43a0c67 ("strparser: Stream parser for messages")
in v4.9-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe72340daaf1af588be88056faf98965f39e6032]
stable/6.12: [5327dad2ffe9c1b49881dd6d51ff3c6893847568]
stable/6.18: [19ca9475f18f991735f98a22e735c43e95e6298d]
stable/6.6: [e9ae00490d474757c0f9c65073de83e6bb1e5a00]
stable/7.0: [56082f442023db9be1a5a29d4ee361de4017c0b7]

CVE-2026-46103: can: ucan: fix devres lifetime

Announce: https://www.cve.org/CVERecord?id=CVE-2026-46103

Introduced by commit 9f2d3ea ("can: ucan: add driver for Theobroma
Systems UCAN devices") in v4.19-rc1.
Fixed in v7.1-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fed4626501c871890da287bec62a96e52da1af89]
stable/6.12: [10b7b676b78a7bd888d19729b459aad7fc1f428b]
stable/6.18: [c524c124e3094d2de12235a513854c03d06a2b58]
stable/6.6: [4b7d07747400cfd7eff1ba7b8b5a7c8d5a58f705]
stable/7.0: [c0d3ccc6929e4509076df8f30a4fb1dc5018b0ae]


* Updated CVEs

CVE-2025-68251: erofs: avoid infinite loops due to corrupted subpage
compact indexes

stable/6.12 was fixed.

Fixed status
stable/6.12: [dbfac1b85d0753996ddfef636934d431b588dd1f]

CVE-2026-23272: netfilter: nf_tables: unconditionally bump set->nelems
before insertion

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [86bc4b1a0f672d47ac19f9022432cb6a2e01cb33]
stable/6.6: [e3ccb11fc8249759d23326038c8db987ddaabc77]

CVE-2026-31613: smb: client: fix OOB reads parsing symlink error response

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [20ac98f0eb6047edb73c9a27af782bdde08b3757]
stable/6.6: [d65a64755a3df68a2fd19d2a81395e9f723aca23]

CVE-2026-31707: ksmbd: validate response sizes in ipc_validate_msg()

stable/6.6 was fixed.

Fixed status
stable/6.6: [bf396208418371174869baba9434535cd3288e80]

CVE-2026-43137: ASoC: SOF: Intel: hda: Fix NULL pointer dereference

stable/6.6 was fixed.

Fixed status
stable/6.6: [a1d4f3d3c0dc86527da6a19f6901a6a48375500d]

CVE-2026-43245: ntfs: ->d_compare() must not block

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1be7ca86ce1794d966fda5d82181bc978b150fbc]
stable/6.6: [02ecc0978c459fd90bb24b2a946dd16d43e68fe5]

CVE-2026-43490: ksmbd: validate inherited ACE SID length

stable/6.6 was fixed.

Fixed status
stable/6.6: [a7fb771314fb3a265d30f8ac245869a367ab065c]

CVE-2026-46300: Fragnesia: the Dirty Frag vulnerability class

stable/5.10, stable/6.1, stable/6.12, stable/6.18, stable/6.6,
stable/7.0 were fixed.

Fixed status
stable/5.10: [3599e6b3cc1ada96883d496a50a210d3afbb6987]
stable/5.15: [2f2b16022a2e10ca7bccfb98db5ed2ec0f72641c]
stable/6.1: [9d3e5fd19fe1063bf607219e8562fbd567b8e8d5]
stable/6.12: [760e1addc27ba1a7beb4a0a7e8b3e9ec49e7a34e]
stable/6.18: [3bd9e113d50034db99d7ef69fd8e5242d15e414a]
stable/6.6: [78bf6b6bb19541d19fbda6242e7cfe2c682763c0]
stable/7.0: [3884358a9286b17f389a72b1426fc4547c23c111]

Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

