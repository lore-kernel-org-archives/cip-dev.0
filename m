Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91045C6FD1F
	for <webhook@archiver.kernel.org>; Wed, 22 Mar 2023 23:11:16 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.59729.1679526672265166872
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Mar 2023 16:11:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=x5ELuu+y;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.48, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso20939451fac.12
        for <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112; t=1679526671;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VdAKWSxUP27r+1VKETW7W8Q1MnzQAbO50hnjPENKy2M=;
        b=x5ELuu+ySWDV1CXe/yZYo/j/HQFOUbr2DdUeDXWZiHtQPdh4BNBKPk9P0Zez7lKjZ/
         5zqsiDv3MzLHXhBYn7nuxHMLheFpTdroKn3eI63BFou0egWE8rXGzJ/0veBmkKjur4Vs
         XZQeV87SOWstNKTNynrbyXq2btZAL3fbwIIQhaJ7XIn0bQ9PakQwfhPsginBxDjxKI8M
         o7/sZqGoI4yOTztaAtI+2E3HM8BtxDjkJYBfjK3cc+7WWs+rFSlsBNkQBi4m0UNgO+dT
         TcDlFwH3tsIH53edViq7aC4eNjga0Td/fZ+/jJPZFcZrEuZ4aKE6Et+7rI88rEqLi2Hx
         ZOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679526671;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VdAKWSxUP27r+1VKETW7W8Q1MnzQAbO50hnjPENKy2M=;
        b=AilvSkNsgqYxriWBF2Z+U3sJgE3MHOVAokvwQpmrXKNZkhMRoM7EzqkM93Npdj7R1V
         y880LsdfD+w19lu/uaaOpNO6FKf2njdW6da4O6lrridwom2qPvIA2zJ6NuPAp1jfppC8
         lZarsBTCA0ouogUDFY6f4JIvpgFh0xRsFeM7LuL4FwM0YnwyMaVKK25txVQONfRv6WKC
         Yiix+4DqASJpW2j0wq9DDbtZjWJELCQqC/sKqOj8IxBu+lrwqm3RmwGGFOx53agcrW/O
         vBenoW3DA+IRarpP7rFe5Dae7XrZ9h27SYERxf8qtlR4ofhHsOiLXQ261IE3rrhFTF5M
         keuw==
X-Gm-Message-State: AAQBX9efHlNOS6lTvgBfNeEqdU4yaKR8Wc0yFvEyDAz07MDU/WzH0qtp
	ObvQFP6FRLdYPO+B9Jh2cWwsQsTNLpHbnZI7KVsmKBRH16FN4GaV12E=
X-Google-Smtp-Source: AKy350bNjURpoFugyH9y3FZ5gxAYEHXh3ZMDkL8BRfUII/sDu8zrve0vMt4EKKCun4dwO9g8j0YaJ+HdqY8JvR8FoEI=
X-Received: by 2002:a05:6871:85c2:b0:17a:d52e:77de with SMTP id
 xt2-20020a05687185c200b0017ad52e77demr531735oab.5.1679526670742; Wed, 22 Mar
 2023 16:11:10 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Mar 2023 08:10:34 +0900
Message-ID: <CAODzB9q+eAUeNM0FFxZ=OypyxugvfRUMy1GZvhJp0GhNPg38ag@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Mar 2023 23:11:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11096

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2023-28466: net: tls: fix possible race condition between
do_tls_getsockopt_conf() and do_tls_setsockopt_conf()

CVSS v3 score is 7.0 HIGH.

do_tls_getsockopt in net/tls/tls_main.c in the Linux kernel through
6.2.6 lacks a lock_sock call, leading to a race condition (with a
resultant use-after-free or NULL pointer dereference).
This bug was introduced by commit 3c4d755 ("tls: kernel TLS support")
in 4.13-rc1. The 4.4 kernels aren't affected.

Fixed status
mainline: [49c47cc21b5b7a3d8deb18fc57b0aa2ab1286962]
stable/6.1: [14c17c673e1bba08032d245d5fb025d1cbfee123]
stable/6.2: [5231fa057bb0e52095591b303cf95ebd17bc62ce]

CVE-2022-48423: An out-of-bounds was found in ntfs3 driver

CVSS v3 score is not provided.

In the Linux kernel before 6.1.3, fs/ntfs3/record.c does not validate
resident attribute names. An out-of-bounds write may occur.
The ntfs3 module was introduced in 5.15-rc1 so that before 5.15
kernels aren't affected.

Fixed status
mainline: [54e45702b648b7c0000e90b3e9b890e367e16ea8]
stable/5.15: [3a52f17867727818ae8dbcfd9425033df32f92e0]
stable/6.1: [2f041a19f4eb72bcc851f9e3a15f3cfd1ae1addf]

CVE-2022-48424: An oob memory access bug was found in ntfs3 driver

CVSS v3 score is not provided.

In the Linux kernel before 6.1.3, fs/ntfs3/inode.c does not validate
the attribute name offset. An unhandled page fault may occur.
The ntfs3 module was introduced in 5.15-rc1 so that before 5.15
kernels aren't affected.

Fixed status
mainline: [4f1dc7d9756e66f3f876839ea174df2e656b7f79]
stable/5.15: [c878a915bcb992c12a97ebae1013e377158f560a]
stable/6.1: [b343c40bb7ff9095430c3f31468a59f8a760dabd]

CVE-2022-48425: fs/ntfs3: Validate MFT flags before replaying logs

CVSS v3 score is not provided.

In the Linux kernel through 6.2.7, fs/ntfs3/inode.c has an invalid
kfree because it does not validate MFT flags before replaying logs.
The ntfs3 module was introduced in 5.15-rc1 so that before 5.15
kernels aren't affected.

Fixed status
Patch is available in the linux-next There

CVE-2023-1281: net/sched: tcindex: imperfect hash filters

CVSS v3 score is not provided(NIST).
CVSS v3 score is 7.8 HIGH(CNA).

A race condition bug will cause a use-after-free in net/sched subsystem.
This bug was introduced by commit 9b0d444 ("net: sched: avoid atomic
swap in tcf_exts_change") in 4.14-rc1 so that 4.4 is not affected.

Fixed status
mainline: [ee059170b1f7e94e55fa6cadee544e176a6e59c2]
stable/5.10: [eb8e9d8572d1d9df17272783ad8a84843ce559d4]
stable/5.15: [becf55394f6acb60dd60634a1c797e73c747f9da]
stable/6.1: [bd662ba56187b5ef8a62a3511371cd38299a507f]

CVE-2023-1513: kvm: initialize all of the kvm_debugregs structure
before sending it to userspace

CVSS v3 score is not provided.

A kernel information leak bug was found when processing
KVM_GET_DEBUGREGS ioctl in kvm_vcpu_ioctl_x86_get_debugregs() in the
kvm subsystem.
It may leak information from uninitialized kvm_debugregs structure value.

Kernel 4.4 might be affected by this issue.

Fixed status
mainline: [2c10b61421a28e95a46ab489fd56c0f442ff6952]
stable/4.14: [1d43de93b35d85981006ec3c52c0cad8af1f2f6a]
stable/4.19: [669c76e55de332fbcbce5b74fccef1b4698a8936]
stable/5.10: [6416c2108ba54d569e4c98d3b62ac78cb12e7107]
stable/5.15: [35351e3060d67eed8af1575d74b71347a87425d8]
stable/5.4: [9f95a161a7deef62d6d2f57b1a69f94e0546d8d8]
stable/6.1: [747ca7c8a0c7bce004709143d1cd6596b79b1deb]

* Updated CVEs

CVE-2022-38457: A use-after-free(UAF) vulnerability in vmxgfx driver

The mainline and stable 6.1 were fixed.
It was introduced by commit e14c02e ("drm/vmwgfx: Look up objects
without taking a reference") in 4.20-rc1 so before 4.20 kernels aren't
affected.

Fixed status
mainline: [a309c7194e8a2f8bd4539b9449917913f6c2cd50]
stable/6.1: [7ac9578e45b20e3f3c0c8eb71f5417a499a7226a]

CVE-2022-40133: A use-after-free(UAF) vulnerability in vmxgfx driver

The mainline and stable 6.1 were fixed.
It was introduced by commit e14c02e ("drm/vmwgfx: Look up objects
without taking a reference") in 4.20-rc1 so before 4.20 kernels aren't
affected.

Fixed status
mainline: [a309c7194e8a2f8bd4539b9449917913f6c2cd50]
stable/6.1: [7ac9578e45b20e3f3c0c8eb71f5417a499a7226a]

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

