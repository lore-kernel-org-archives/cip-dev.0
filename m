Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5265C53210
	for <webhook@archiver.kernel.org>; Thu,  5 Jan 2023 01:05:27 +0000 (UTC)
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
 by mx.groups.io with SMTP id smtpd.web11.2308.1672880723392874440
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jan 2023 17:05:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=sgd0d2Na;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.46, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1441d7d40c6so41690237fac.8
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jan 2023 17:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QzN9eZBMlW28NEuliJ/T8Fh0ezsbpeEeJa2PcZfc7jo=;
        b=sgd0d2NaKM1/CDKoUA+LFKWAn1BrJO4aaGtn6ju+rRtnfSPmLwtgYFc9qNJjfoZspT
         xYgWF9oU3OULdxpl97GvcSfXIEIY4LO96onAbJCMmR5lwgNxhhWTTeMjdK92+43ghSwj
         QB7kGflMsK3i376niVzzJnFqwveCJMyb4qQfeggzs8UDCBK32wKODWyeWNS8HhtPGUyH
         sQx7ZPXiJmYMnQHCeBbHIn0gWcjDiJRtiXh6B/oW4+9y39HbRm3HbiDOvG78ZlfThaCm
         155clJbsnkBDOsYiXrXbMoahxJ+CZ693Lazvq0EkxCJm9fLa3c7o8B28IATRfNbpCbgG
         9RgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QzN9eZBMlW28NEuliJ/T8Fh0ezsbpeEeJa2PcZfc7jo=;
        b=xLMyS/Su3ysMytST9+aWyA8Z9r5adi6rUQJxELmX/FJ3iXkwR9LpFGpQc6z8LYOisc
         sU+yng9pfQ/nHX7dt8Ff06taIu18MUdk4weuzx7eMZBOgCmUPQIFSpSYea0zpeHgJcjN
         GYuUbpos/AACR+FQ9eiAWgL+cLi7VLdm72mCwrp08oe18MhNiDc2Op3gcGoVskREoyXY
         ZmJX0UZxgcHCza0AzC5f3WjZnlPC6NvL95I1Kfa3wNIGJgVoR9+6mtt7QnphwPFAR/iZ
         HoXH+FSJO7Yjsl9Vvk+DjTlOr1xtpWilhLiwqZQsTBhSVRIzx0+O7/6GlTzKvrk0kueQ
         n+Uw==
X-Gm-Message-State: AFqh2koKuZRiD7iC4hEf4GAeXaJ03xIFQWfsylw266vYjydtoCvUNf4E
	j/hGActXdqMfvtj+yzeWGh6kGU1i1V1a4BqumcBO1nKhRoYCNUh/
X-Google-Smtp-Source: AMrXdXujzLszAyLiqDvtQmMqKt+KL2p0zaV27gjX4/LOzpJsh2EFNguKMllCWczh2KhGxIFirGKHF7v8zWIgAIfssCI=
X-Received: by 2002:a05:6870:1e86:b0:148:43a2:188 with SMTP id
 pb6-20020a0568701e8600b0014843a20188mr3084593oab.58.1672880722220; Wed, 04
 Jan 2023 17:05:22 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 5 Jan 2023 10:04:46 +0900
Message-ID: <CAODzB9onLeCLi6YiBa7hjdYzF+qw8FiZPzaYS0eYsrw6PMwHVA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jan 2023 01:05:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10319

Hi !

It's this week's CVE report.

This week reported 3 new CVEs and 6 updated CVEs.

* New CVEs

CVE-2022-4842: fs/ntfs3: Fix attr_punch_hole() null pointer dereference

CVSS v3 score is not provided

A Null pointer dereference bug was found in attr_punch_hole() in the
ntfs3 driver.
It was introduced by commit be71b5c ("fs/ntfs3: Add attrib
operations") in 5.15-rc1.
The ntfs3 driver has been added since 5.15 so that less than 5.15
kernels aren't affected by this issue.
It was fixed in 6.2-rc1.

Fixed status
mainline: [6d5c9e79b726cc473d40e9cb60976dbe8e669624]

CVE-2023-0030: drm/nouveau/mmu: add more general vmm free/node
handling functions

CVSS v3 score is not provided

A use-after-free bug was found in nvkm_vmm_pfn_map. This bug will let
system crash or potentially escalate their privileges on the system.
Commit 729eba3 ("drm/nouveau/mmu: add more general vmm free/node
handling functions") was merged in 5.0-rc1.
The nvkm_vmm_pfn_map() was introduced by commit a5ff307
("drm/nouveau/mmu: add a privileged method to directly manage PTEs")
in 5.1-rc1.

This bug happens when nvkm_vma_tail returns NULL, which means kzalloc
returns NULL.

Fixed status
Debian security tracker said that it was fixed in 5.2.6 but I couldn't
find a related commit in the change log
(https://lore.kernel.org/stable/20190804101415.GA27152@kroah.com/).

CVE-2023-20928: android: binder: stop saving a pointer to the VMA

CVSS v3 score is not provided

A use-after-free bug was found in the Android binder driver.
According to the android's commit
(https://android.googlesource.com/kernel/common/+/201d5f4a3ec1) it
said "Note this patch is specific to stable branches 5.4 and 5.10.
Since in newer kernel releases binder no longer caches a pointer to
the vma.
Instead, it has been refactored to use vma_lookup() which avoids the
issue described here. This switch was introduced in commit
a43cfc87caaf ("android: binder: stop saving a pointer to the VMA")."

binder_alloc.[ch] are not present in 4.4 and 4.9.

Fixed status
mainline: [a43cfc87caaf46710c8027a8c23b8a55f1078f19]
stable/5.10: [015ac18be7de25d17d6e5f1643cb3b60bfbe859e]
stable/5.15: [622ef885a89ad04cfb76ee478fb44f051125d1f1]

* Updated CVEs

CVE-2022-3424: misc: sgi-gru: fix use-after-free error in
gru_set_context_option, gru_fault and gru_handle_user_call_os

stable 5.15, 6.0, and 6.1 were fixed.

Fixed status
mainline: [643a16a0eb1d6ac23744bb6e90a00fc21148a9dc]
stable/5.15: [d5c8f9003a289ee2a9b564d109e021fc4d05d106]
stable/6.0: [dbc1bb8c8ea930f188b7ce45db162807b3f4b66a]
stable/6.1: [4e947fc71bec7c7da791f8562d5da233b235ba5e]

CVE-2022-3531: selftest/bpf: Fix memory leak in kprobe_multi_test

stable 6.0 and 6.1 were fixed.

Fixed status
mainline: [6d2e21dc4db3933db65293552ecc1ede26febeca]
stable/6.0: [78b772629cc5adec02ab4182b62abe916f2254a0]
stable/6.1: [661e952bc9ef798d1d33ba67f2950a3e0bea455f]

CVE-2022-3532: selftests/bpf: Fix memory leak caused by not destroying skeleton

stable 6.0 was fixed.

Fixed status
mainline: [0ef6740e97777bbe04aeacd32239ccb1732098d7,
1642a3945e223a922312fab2401ecdf58b3825b9]
stable/6.0: [0ef6740e97777bbe04aeacd32239ccb1732098d7,
cd7bccc8887787f47d0d82528c4c98e209b442b7]

CVE-2022-3595: A double free bug was found in cifs subsystem

stable 6.0 was fixed.

Fixed status
mainline: [b854b4ee66437e6e1622fda90529c814978cb4ca]
stable/6.0: [983ec6379b9bab7bf790aa7df5dc3a461ebad72a]

CVE-2022-4379: NFSD: fix use-after-free in __nfs42_ssc_open()

Fixed in mainline and 6.1.

Fixed status
mainline: [75333d48f92256a0dec91dbf07835e804fc411c0]
stable/6.1: [650b69b17cfd79f51476d93c2c63bfb73280a77a]

CVE-2022-45888: char: xillybus: Fix use-after-free in xillyusb_open()

Fixed in mainline.

Fixed status
mainline: [282a4b71816b6076029017a7bab3a9dcee12a920]

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

