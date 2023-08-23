Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44644C27C40
	for <webhook@archiver.kernel.org>; Wed, 23 Aug 2023 22:47:51 +0000 (UTC)
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
 by mx.groups.io with SMTP id smtpd.web10.347.1692830869575903399
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Aug 2023 15:47:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=2hpEoECn;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3a7d7de894bso4346175b6e.3
        for <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 15:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1692830868; x=1693435668;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gr5tAC7CHVRUclZOxT3m3xB+VUZXi9q658phQOS4vlI=;
        b=2hpEoECnNZgq7fzXA0C1V1u24tCuGe+NbSEPJ8JZeH7l6IWDgnXT+GcOtJEcW42rIS
         xQNUKWv8eeb0UdJeKaK8ovKtYzNqWCHFSg1eiySGBGu6y1uweTRTAdsHpv+KV51b8z4n
         JDxXnK3d1h8ZxA/za5Ru1QBo6pLZlNntavZJqtsGnEagMk/RybMMAUi2NfhlnpaEOYEV
         E7cE3x6jp8HxZMuZmcJIzTLgw9a0bjqAN8mqPJiyahURD1s5+LC/iSh/rwezAXnAN+Bp
         1eOXmhqyh44iE1yoGWiwC1JwcAtjBJzrNvWnS3cnlcex6dtvhNNehulSCLo5Azd0SOBF
         P2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692830868; x=1693435668;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gr5tAC7CHVRUclZOxT3m3xB+VUZXi9q658phQOS4vlI=;
        b=AnKXVxvKR911Wt83m2t3adeTQXRRFjeolV2eJ8p0zY4awS+8FnV35JMGqLUJXqS+47
         W72Xiw0KFyxDDQNueQeEEbQRA5UePnIuXVVXWk3nxZeC/aBJ4KXP1m38Zx5ft3uxgH1H
         AFMfOKp//VvjpHftK+uEJlxSiKiRRHRHN9qhyQwCQeDzwUfLh8MR1yyRgqMAdK0d98/m
         PJR/jj4Lis6p3v+AyCr7btL8cASEBEzaFQ+Ju+00I59CbVLRvNanZwxJcmc7TSxGn0PQ
         TDNd1iqJyZEa3ZafZ7b8hzxdOv+nhmUBss/+U3/aqXERbJ02ynY+fz2qRPWqLTQ0xZ/r
         WG1g==
X-Gm-Message-State: AOJu0YyAWpeF7I9Hlv+AOc7z2CD6RxpYEhV1pYeyT2+zsD9HsElhqIMT
	F6FY4r0KAF+UEytldoFZVolKKSB6qauV07WwI0jKkmdqaJGRHKkO688=
X-Google-Smtp-Source: AGHT+IEK6lo1oRe1BVjsHVd0S8x8l4wgrsTUjk/xCk4EupD+kGU08GUsnCDRFElkSh8UIyk+kdlXv82mEeQMwFEHllo=
X-Received: by 2002:a05:6870:b295:b0:1c0:fe16:90fa with SMTP id
 c21-20020a056870b29500b001c0fe1690famr16597099oao.56.1692830867907; Wed, 23
 Aug 2023 15:47:47 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 24 Aug 2023 07:47:11 +0900
Message-ID: <CAODzB9orgFUeGCfjL4BeDmEazgTDSJg_SNrtCxbvOSDcoFiviw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Aug 2023 22:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12842

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 3 updated CVEs.

When I was reviewing CVE-2022-40307, I found commit
7f7838c92740fa423a5a3f12c00ed02d92851254
("efi: capsule-loader: Fix use-after-free in efi_capsule_write") is
not in the cip/4.4-st.
However, this commit exists in both cip/4.4 and cip/4.4-rt.

* New CVEs

CVE-2023-4385: A NULL pointer dereference bug was found in jfs file system

CVSS v3 score is not provided (NIST).
CVSS v3 score is 5.5 MEDIUM (CNA).

A NULL pointer dereference flaw was found in dbFree in
fs/jfs/jfs_dmap.c in the journaling
file system (JFS) in the Linux Kernel. This issue may allow a local
attacker to crash the
system due to a missing sanity check.

All stable kernels and cip kernels are fixed.

Fixed status
mainline: [0d4837fdb796f99369cf7691d33de1b856bcaf1f]
stable/4.14: [070ddf59cf17faf6aae7d89f78e0510c94d07940]
stable/4.19: [c381558c278a540c61dfef1f2b77ab817d5d302d]
stable/5.10: [9dfa8d087bb854f613fcdbf1af4fb02c0b2d1e4f]
stable/5.15: [4b9380d92c66cdc66987f65130789abad5c1af6f]
stable/5.4: [e54fd01178ebd5b13ef9e2fc0f3006765f37ee3c]

CVE-2023-4387: A use-after-free bug was found in vmxnet3 driver

CVSS v3 score is 7.1 HIGH (NIST).
CVSS v3 score is 6.6 MEDIUM (CNA).

A use-after-free flaw was found in vmxnet3_rq_alloc_rx_buf in
drivers/net/vmxnet3/vmxnet3_drv.c
in VMware's vmxnet3 ethernet NIC driver in the Linux Kernel.
This issue could allow a local attacker to crash the system due to a
double-free while cleaning
up vmxnet3_rq_cleanup_all, which could also lead to a kernel
information leak problem.

All stable kernels and cip kernels are fixed.

Fixed status
mainline: [9e7fef9521e73ca8afd7da9e58c14654b02dfad8]
stable/4.14: [2bee202d0649cb53b9860fe15d0642167bffd6bf]
stable/4.19: [3adaaf3472e8ea410cb1330e5dd8372b0483dc78]
stable/5.10: [a54d86cf418427584e0a3cd1e89f757c92df5e89]
stable/5.15: [4ad09fdef55b70f16f8d385981b864ac75cf1354]
stable/5.4: [32f779e6fbbe0c0860a00777b7e3dee6b5ec0c1c]

CVE-2023-4389: A mishandling reference count flaw causes system crash
or kernel information leak

CVSS v3 score is 7.1 HIGH (NIST).
CVSS v3 score is 7.0 HIGH (CNA).

A flaw was found in btrfs_get_root_ref in fs/btrfs/disk-io.c in the
btrfs filesystem in the Linux
Kernel due to a double decrement of the reference count. This issue
may allow a local attacker
with user privilege to crash the system or may lead to leaked internal
kernel information.

This bug was introduced by commit bc44d7c ("btrfs: push
btrfs_grab_fs_root into btrfs_get_fs_root")
in 5.7-rc1 and fixed in 5.18-rc3. So, before Linux 5.7 are not
affected by this issue.

All stable kernels and cip kernels are fixed.

Fixed status
mainline: [168a2f776b9762f4021421008512dd7ab7474df1]
stable/5.10: [1d2eda18f6ffbd9902594469c6e1a055014eb2ac]
stable/5.15: [252db93fd0bd5ca07c9b933ed94e93a4a43e8901]

CVE-2023-4394: A use-after-free bug was found in fs/btrfs/volumes.c

CVSS v3 score is 6.0 MEDIUM (NIST).
CVSS v3 score is 6.7 MEDIUM (CNA).

A use-after-free flaw was found in btrfs_get_dev_args_from_path in
fs/btrfs/volumes.c in btrfs file-system in the Linux Kernel. This flaw
allows a local attacker with special privileges to cause a system
crash or leak internal kernel information

This bug was introduced by commit faa775c ("btrfs: add a
btrfs_get_dev_args_from_path helper") in 5.16-rc1 and fixed in
6.0-rc3.
The commit faa775c was backported to 5.15 so that it was affected by
this vulnerability. before Linux 5.15 doesn't contain the commit so
they are not affected.

All stable kernels and cip kernels are fixed.

Fixed status
mainline: [9ea0106a7a3d8116860712e3f17cd52ce99f6707]
stable/5.15: [5f52402c77013e4a826394b807dd5ea4dc83bd72]

CVE-2023-4459: net: vmxnet3: fix possible NULL pointer dereference in
vmxnet3_rq_cleanup()

CVSS v3 score is not provided (NIST).
CVSS v3 score is 6.5 MEDIUM (CNA).

A NULL pointer dereference flaw was found in vmxnet3_rq_cleanup in
drivers/net/vmxnet3/vmxnet3_drv.c in
the networking sub-component in vmxnet3 in the Linux Kernel. This
issue may allow a local attacker with
normal user privilege to cause a denial of service due to a missing
sanity check during cleanup.

This bug was fixed in 5.18. All stable kernels and CIP kernels have been fixed.

Fixed status
mainline: [edf410cb74dc612fd47ef5be319c5a0bcd6e6ccd]
stable/4.14: [5fd9a74bf04a1eae5dbde8ca8585106d4410427f]
stable/4.19: [248a37ffd81c7121d30702d8caa31db48450680d]
stable/5.10: [6e2caee5cddc3d9e0ad0484c9c21b9f10676c044]
stable/5.15: [e35387a91318ccdec4a30b58d967391e011e34fa]
stable/5.4: [dc64e8874e87dc1c1c723a1c6da7efc3305c18da]

* Updated CVEs

CVE-2023-0160: possibility of deadlock in libbpf function sock_hash_delete_elem

This bug was introduced by commit 604326b ("bpf, sockmap: convert to
generic sk_msg interface") in 4.20-rc1.
This commit is not backported to old stable kernels so 4.19, 4.14,
4.9, and 4.4 are not affected.

Fixed status
mainline: [ed17aa92dc56b6d8883e4b7a8f1c6fbf5ed6cd29]
stable/5.10: [2f9307222227410453e33654f5d9ed6459351455]
stable/5.15: [f333854dce4a079783f00c201869b9ee8f7ff3c3]
stable/5.4: [c229821510dfe35e89899b00ec34f9f5876fbbd2]
stable/6.1: [1d4ac7b0ffc9dc683b8dafc78b8b93177071a02c]

CVE-2023-3772: xfrm: add NULL check in xfrm_update_ae_params

The mainline and stable/6.1, stable/6.4 were fixed.

Fixed status
mainline: [00374d9b6d9f932802b55181be9831aa948e5b7c]
stable/6.1: [87b655f4936b6fc01f3658aa88a22c923b379ebd]
stable/6.4: [53df4be4f5221e90dc7aa9ce745a9a21bb7024f4]

CVE-2023-3773: xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

The mainline and stable/6.1, stable/6.4 were fixed.

Fixed status
mainline: [5e2424708da7207087934c5c75211e8584d553a0]
stable/6.1: [a442cd17019385c53bbddf3bb92d91474081916b]
stable/6.4: [a9020514f175ef15bb68eea9345782abfd9afea3]

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

