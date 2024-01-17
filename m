Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAECC47258
	for <webhook@archiver.kernel.org>; Wed, 17 Jan 2024 23:22:54 +0000 (UTC)
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
 by mx.groups.io with SMTP id smtpd.web10.2382.1705533763062301371
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Jan 2024 15:22:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=Q0/KVxx/;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-20757468411so3079639fac.3
        for <cip-dev@lists.cip-project.org>; Wed, 17 Jan 2024 15:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1705533762; x=1706138562; darn=lists.cip-project.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W7TvHsLofO/o/H7hidOIaq3JjGiDYndj98sSIxTMVqA=;
        b=Q0/KVxx/INzxaQVkQjvodiH8TQT/elnnkJrUhCE16pMN9qeqeQK7sue+vpPEvA6nYa
         eT5gfLIUCE5wzNohl3GQ0FqdIZ0Ifc3T03bddx0JnXhJXgeBA73DlAzZwF/QtW6GBrU9
         ul0jXEH0C4UZ92wyJKU52mng3lOPvQAaQn3+e06f7bKGikUqEtQJOdMg+g6VQg5pwfj+
         l+VHQtddxotpCuRZi8XEYhIAQO2xHH8+7tBueApxkBWfi3fyf2aoC7bUO1qmMtlwKC4V
         43kee1pA3fE9X42pQl638DUPL5NeEZjt445FhMEhhSCcEpcKSmT2Xy/ApbkpLNNlXNOE
         45RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705533762; x=1706138562;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W7TvHsLofO/o/H7hidOIaq3JjGiDYndj98sSIxTMVqA=;
        b=vZ43obhGGQ8Drnq40QGzBOVMflsso6TsRBxaZpEQYMSHQJO0vOT7mR/YqmGfKZIic8
         UDt8tx7GRN/0IgDTSGanyOAcSUkFPX6c2zIZTPrkONf2uX6bKjP8NDjTKGrikETOxAjm
         QIZkhd2SMyFGaDIKPpzjuM8LLrOoDPIO/G3stsXiyyPk0//ETweoFrhPQhUS4MP9RsG+
         k93N7Z+Wcg3p2GVPka+sKjOhB/brXylGgmQTu87IfnhJXbFeLIjXtMmu+2ze4gLWQp1e
         +XUjOyFiqVxzUZuQkVl6Cr/YNYHb2/G/xcSGzX6UmM8G9T/trbOfFzv9/iQCnagmnVnC
         BQWQ==
X-Gm-Message-State: AOJu0YweTPmA0iquPukYkIok3N7JiSMSuACGx4czJm//voNpezyUy6Ie
	1dklzRMEsfjHO9cVnUuGTvBz/ywk4RitihU9Q8w7Cd3BvqkmFmuEHI1oGiN+wkI=
X-Google-Smtp-Source: AGHT+IFhKO1pJLlcPkxfeTONx/1CJhB9G82Z93bGyyrElV6L5OcJF1lPDQ4mdcOXc+bKbfvRJJw91TggkC/d34rTaSM=
X-Received: by 2002:a05:6870:23a4:b0:206:7ef1:2e6a with SMTP id
 e36-20020a05687023a400b002067ef12e6amr13244643oap.97.1705533761907; Wed, 17
 Jan 2024 15:22:41 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 18 Jan 2024 08:22:06 +0900
Message-ID: <CAODzB9ppVQbOoRXOiJ6LSYYQYGuvaqzCHEge3YxND2wStzumYA@mail.gmail.com>
Subject: subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Jan 2024 23:22:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14398

Hi!

It's this week's CVE report.

This week reported 10 new CVEs and 1 updated CVEs.

* New CVEs

CVE-2023-6040: An out-of-bounds access vulnerability in the netfilter
in the nf_tables

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

An out-of-bounds access vulnerability involving netfilter was reported
and fixed as: f1082dd31fe4 (netfilter: nf_tables: Reject tables of
unsupported family); While creating a new netfilter table, lack of a
safeguard against invalid nf_tables family (pf) values within
`nf_tables_newtable` function enables an attacker to achieve
out-of-bounds access.

This bug was fixed by commit f1082dd (" netfilter: nf_tables: Reject
tables of unsupported family") in 5.18-rc1.

Fixed status
mainline: [f1082dd31fe461d482d69da2a8eccfeb7bf07ac2]
stable/4.19: [087d38ae0fd5a9a41b949e97601b4b0d09336f19]
stable/5.10: [25d1e7be85cf0a5afca5555f90e4609c40480ece]
stable/5.15: [ab3a3aadb373b47a1f401c7626608b1b214cec9e]
stable/5.4: [8711fa0c06d49ad3a45b60cc10ae72980df89b00]

CVE-2024-0443: blk-cgroup: Flush stats at blkgs destruction path

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.5 (MEDIUM)

A flaw was found in the blkgs destruction path in block/blk-cgroup.c
in the Linux kernel, leading to a cgroup blkio memory leakage problem.
When a cgroup is being destroyed, cgroup_rstat_flush() is only called
at css_release_work_fn(), which is called when the blkcg reference
count reaches 0. This circular dependency will prevent blkcg and some
blkgs from being freed after they are made offline. This issue may
allow an attacker with a local access to cause system instability,
such as an out of memory error.

This bug was introduced by commit 3b8cc62 ("blk-cgroup: Optimize
blkcg_rstat_flush()") in 6.2-rc1 ant fixed in 6.4-rc7.

Fixed status
mainline: [20cb1c2fb7568a6054c55defe044311397e01ddb]

CVE-2022-48619: Input: add bounds checking to input_set_capability()

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An issue was discovered in drivers/input/input.c in the Linux kernel
before 5.17.10. An attacker can cause a denial of service (panic)
because input_set_capability mishandles the situation in which an
event code falls outside of a bitmap.

This bug was fixed in 5.18-rc1.

Fixed status
cip/4.4-st: [41f0ae4fd900e90ebf7257cbe04edffc4aeb8ab5]
mainline: [409353cbe9fe48f6bc196114c442b1cff05a39bc]
stable/4.19: [01d41d7e7fc7eef99ae5b1065d9186f91ff099e7]
stable/5.10: [d5e88c2d76efa9d7bb7ceffaec60fe6c76c748d7]
stable/5.15: [0211383109832103cfddfd5c5cc99b29d40bb749]
stable/5.4: [bb83a744bc671804016e23861a892e9db2aee73f]

CVE-2023-6915: ida: Fix crash in ida_free when the bitmap is empty

CVSS v3(NIST): N/A
CVSS v3(CNA): 6.5 (MEDIUM)

A Null pointer dereference problem was found in ida_free in lib/idr.c
in the Linux Kernel. This issue may allow an attacker using this
library to cause a denial of service problem due to a missing check at
a function return.

It was fixed in 6.7-rc7.

Fixed status
mainline: [af73483f4e8b6f5c68c9aa63257bdd929a9c194a]

CVE-2024-0565: smb: client: fix OOB in receive_encrypted_standard()

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.1 (HIGH)

An out-of-bounds memory read flaw was found in
receive_encrypted_standard in fs/smb/client/smb2ops.c in the SMB
Client sub-component in the Linux Kernel. This issue occurs due to
integer underflow on the memcpy length, leading to a denial of
service.

It was introduced by commit b24df3e ("cifs: update
receive_encrypted_standard to handle compounded responses") in
4.19-rc1, then fixed in 6.7-rc6.

Fixed status
mainline: [eec04ea119691e65227a97ce53c0da6b9b74b0b7]
stable/6.1: [9f528a8e68327117837b5e28b096f52af4c26a05]
stable/6.6: [534733397da26de0303057ce0b93a22bda150365]

CVE-2024-0562: A use-after-free was found when disk is removed

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

A use-after-free flaw was found in the Linux Kernel. When a disk is
removed, bdi_unregister is called to stop further write-back and waits
for associated delayed work to complete. However,
wb_inode_writeback_end() may schedule bandwidth estimation work after
this has completed, which can result in the timer attempting to access
the recently freed bdi_writeback.

Introduced by commit 45a2966 ("writeback: fix bandwidth estimate for
spiky workload") in 5.15-rc1 then fixed in 6.0-rc3.
Prior to 5.15 kernels aren't affected by this issue.

Fixed status
mainline: [f87904c075515f3e1d8f4a7115869d3b914674fd]
stable/5.15: [f96b9f7c1676923bce871e728bb49c0dfa5013cc]

CVE-2024-0582: io_uring/kbuf: defer release of mapped buffer rings

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

A memory leak flaw was found in the Linux kernel=E2=80=99s io_uring
functionality in how a user registers a buffer ring with
IORING_REGISTER_PBUF_RING, mmap() it, and then frees it. This flaw
allows a local user to crash or potentially escalate their privileges
on the system.

It was introduced by commit c56e022 ("io_uring: add support for user
mapped provided buffer ring") in 6.4-rc1 then fixed in 6.7-rc4.
Prior to 6.4 kernels aren't affected by this issue.

Fixed status
mainline: [c392cbecd8eca4c53f2bf508731257d9d0a21c2d]
stable/6.6: [7138ebbe65caf65f52b923d4ef819c77d04ea671]

CVE-2024-0584: ipv4: igmp: fix refcnt uaf issue when receiving igmp query p=
acket

CVSS v3(NIST): N/A
CVSS v3(CNA): 6.3 (MEDIUM)

A use-after-free issue was found in igmp_start_timer in
net/ipv4/igmp.c in the network sub-component in the Linux Kernel. This
flaw allows a local user to observe a refcnt use-after-free issue when
receiving an igmp query packet, leading to a kernel information leak.

This bug was introduced in 2.6.12 or prior, so all stable kernels are affec=
ted.

Fixed status
mainline: [e2b706c691905fe78468c361aaabc719d0a496f1]
stable/4.19: [6b6f5c6671fdfde9c94efe6409fa9f39436017e7]
stable/5.10: [772fe1da9a8d4dcd8993abaecbde04789c52a4c2]
stable/5.15: [c4a00c47a140c39a0497a40b0f54cf4586a2b1d7]
stable/5.4: [7ccf772a8bad7962d12d48723447c3605a6e23c1]
stable/6.1: [94445d9583079e0ccc5dde1370076ff24800d86e]
stable/6.6: [bf8601dabed0c134a7d58085824e3e466840c5d1]

CVE-2024-0607: netfilter: nf_tables: fix pointer math issue in
nft_byteorder_eval()

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the nft_byteorder_eval(), there is a loop and writing to an array
of dst to 8 bytes data but dst's type is u32. So that an oob write bug
occurs.
This bug was introduced by commit ce1e798 ("netfilter: nft_byteorder:
provide 64bit le/be conversion") in 4.5-rc1. Fixed in 6.7-rc2.
4.4-st, 4.4-cip, and 4.4-cip-rt are not affected.

Fixed status
mainline: [c301f0981fdd3fd1ffac6836b423c4d7a8e0eb63]
stable/5.15: [b8b514b2a6cdfac24911e4910461bcb9db15ca8d]
stable/6.1: [18a169810cff769a7a697b35058c756805f589e0]
stable/6.6: [013deed31ab15ef287b0045e4e7bd8f250e75b94]

CVE-2024-0646: net: tls, update curr on splice as well

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.0 (HIGH)

An out-of-bounds memory write flaw was found in the Linux kernel=E2=80=99s
Transport Layer Security functionality in how a user calls a function
splice with a ktls socket as the destination. This flaw allows a local
user to crash or potentially escalate their privileges on the system.

This bug was introduced by commit d829e9c ("tls: convert to generic
sk_msg interface") in 4.20-rc1. Fixed in 6.7-rc5.
Kernel 4.19 and 4.4 are not affected.

Fixed status
mainline: [c5a595000e2677e865a39f249c056bc05d6e55fd]
stable/5.10: [c6b2a6b827d4b2d0f36b520e54e083df9b330a7b]
stable/5.15: [ba5efd8544fa62ae85daeb36077468bf2ce974ab]
stable/5.4: [c67bf30baf261b467988fd40668bc893b71586b9]
stable/6.1: [9b3d3a7f3c4d710c1dd3f723851c3eeaf42642bc]
stable/6.6: [eb30a025982f61910f32e99778db3c0ceceaff5c]

* Updated CVEs

CVE-2023-39198: drm/qxl: fix UAF on handle creation

stable 5.10 was fixed.

Fixed status
mainline: [c611589b4259ed63b9b77be6872b1ce07ec0ac16]
stable/5.10: [03585b18b715621a64ced023ca8c1fc36b6b2119]
stable/5.15: [d578c919deb786b4d6ba8c7639255cb658731671]
stable/6.1: [a1fa8f0fc58e0ec972f718030710efc442d7304b]

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
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

