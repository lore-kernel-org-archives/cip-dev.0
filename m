Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C0C7619A
	for <webhook@archiver.kernel.org>; Thu, 13 Apr 2023 00:20:09 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.928.1681345202303132755
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Apr 2023 17:20:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=kbjd+oB2;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f173.google.com with SMTP id bh10so9046628oib.1
        for <cip-dev@lists.cip-project.org>; Wed, 12 Apr 2023 17:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1681345200;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KM4GPDpgGVud20be6F2izbbBpzF/dQtxbTZaekzyP7M=;
        b=kbjd+oB2oCzqO1oE9zuL9sX127J5PgGKG9DDNbgHmYRPmWZYILOIWYTCERaU9pBmU6
         3gXRHu0rFlBJdu8aYXA5xrgPIj9OS0fjMI7cb+QGcmZUPvDDePu7C9YusaG2ozdlUtGG
         IR4WFsCmzl7nPA86hHaqs9i/ReaDIbUPiE4Ue8MyUCfUcp1o481DepilAN/Y8sSlHTL/
         jp7QVbbZC373ew4gccerhOtKv0dKEUSFxOpiPFnKaUDVrMi/OecziY3nkUqqZ/MIqmyD
         u2oCDS1pJg7x8WmsljBuw+VwvpV2svx7iXS/dkCxcT6v034iyt8hndQFPuKov9J55Zh+
         Z6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681345200;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KM4GPDpgGVud20be6F2izbbBpzF/dQtxbTZaekzyP7M=;
        b=fpADKYpfwjBRqW7MlCpYuh9cMWf53F5YSPZBHoii/TZ24/UWCtWM7aLAORVjxHwNOT
         O24GMdTn0C0plJr+PCnxx113ML+ztI/37ASQKpfBvFzyIrFu9Nd+lm6PuJPgEsEe8tjW
         ht28HSsPBpJ4BFBavFyk9nxEzFznZXpMtM9b6JVfIUfGZM1nQLvfmYXAUJPUnvDo8DJv
         Sw0zMGAxJQ9KHcbYEYSiYiswyjBwcLx7WE4Isr8PDlm5+y68sYDK1D3ooPRj2XKirndH
         3xYntY3Xclj+MuMpujz1gwMnys6KIGzX7uB2Dhpyhxn/E2BRKrn4q27SSCqC7kchVi1l
         EyDA==
X-Gm-Message-State: AAQBX9cA2ocKE3fjkMJc++ivIS6w44I9jbbRKrwVljM+T7DmcqFQEsWR
	PwTnwvk+8t4AxD4EIWQw3UR2xDJsO/gDJwGLNC3m1vQb53pWR/5oM18=
X-Google-Smtp-Source: AKy350a+Qd3Wmt/njuCq+69FHB3aJqPO00W/feH3s/R6tW2BVfN7KT7Ofe/Jxm94eYDrYmXLJ6vvYWT6yePWZBtrbg4=
X-Received: by 2002:aca:111a:0:b0:386:e7e7:d93d with SMTP id
 26-20020aca111a000000b00386e7e7d93dmr89603oir.5.1681345200231; Wed, 12 Apr
 2023 17:20:00 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 13 Apr 2023 09:19:23 +0900
Message-ID: <CAODzB9rOrS8F_1jXrxwTSV643XNNYNY4oTesEK9AvbbrNOH=6g@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Apr 2023 00:20:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11194

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2023-1855: Fix use after free bug in xgene_hwmon_remove due to
race condition

CVSS v3 score is not provided.

A use-after-free flaw was found in xgene_hwmon_remove in
drivers/hwmon/xgene-hwmon.c in the Hardware Monitoring Linux Kernel
Driver (xgene-hwmon).
This flaw could allow a local attacker to crash the system due to a
race problem. This vulnerability could even lead to a kernel
information leak problem.

Introduced by commit 2ca492e ("hwmon: (xgene) Fix crash when alarm
occurs before driver probe") in 4.9-rc1 so 4.4 kernels aren't
affected.

Fixed status
mainline: [cb090e64cf25602b9adaf32d5dfc9c8bec493cd1]
stable/4.14: [c809ed776e190edfc04f8d6b25a62855b1386a0d]
stable/4.19: [e0a37b43cd732038e37b4e7f6c6c0658fe0b6d73]
stable/5.10: [0a73c8b3cc99d214dff83c51805c844240c4f749]
stable/5.15: [7091951c2ca9d3fbec75ef1d677cbd89eeac9793]
stable/5.4: [26c176ce902861a45f8d699e057245ed7e0bcdf2]
stable/6.1: [b2ae1f15cd6fe0cb36e432a179ae7d479ae2e6e0]
stable/6.2: [eacd1f6bb43ac4b9de3bf886083a71c18d5f329f]

CVE-2023-1859: 9p/xen: Fix use after free bug in xen_9pfs_front_remove
due  to race condition

CVSS v3 score is not provided.

When a thread calls xen_9pfs_front_remove() priv variable will be
freed. However, if other thread runs p9_tag_lookup after the priv
variable was freed, use-after-free bug will occur.
The xen/9pfs was introduced in 4.12-rc1 so that 4.4 kernels aren't affected.

Fixed status
Patch was sent to netdev mailing list, but it hasn't been merged yet.

CVE-2023-30456: KVM: nVMX: add missing consistency checks for CR0 and CR4

An issue was discovered in arch/x86/kvm/vmx/nested.c in the Linux
kernel before 6.2.8. nVMX on x86_64 lacks consistency checks for CR0
and CR4.

The nested_vmx_check_guest_state() in arch/x86/kvm/vmx/nested.c was
first introduced by commit 55d2375 ("KVM: nVMX: Move nested code to
dedicated files ") in 5.0-rc1.

CVSS v3 score is not provided.

The nested_vmx_check_guest_state() in arch/x86/kvm/vmx/nested.c was
first introduced by commit 55d2375 ("KVM: nVMX: Move nested code to
dedicated files ") in 5.0-rc1. That time the function name was
check_vmentry_prereqs().
Then check_vmentry_prereqs() was renamed to
nested_vmx_check_vmentry_prereqs() by commit 16322a3 ("KVM: nVMX:
Prepend "nested_vmx_" to check_vmentry_{pre,post}reqs() ").
Finally, the nested_vmx_check_vmentry_prereqs() was renamed to
nested_vmx_check_host_state().

Before 5.0-rc1, vulnerable code is not found so they are not affected
by this issue.

Fixed status
mainline: [112e66017bff7f2837030f34c2bc19501e9212d5]
stable/5.10: [c54974ccaff73525462e278602dfe4069877cfaa]
stable/5.15: [9c2f09add608a505f0e5fb694805f4766801583f]
stable/5.4: [65e4c9a6d0c9a8c81ce75576869d46fff5d7964f]
stable/6.1: [4bba9c8adec804f03d12dc762e50d083ee88b6b0]
stable/6.2: [71d05b9fa0bfc131a6e2250dea045a818ff25550]

CVE-2023-1829: net/sched: Retire tcindex classifier

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux Kernel traffic control
index filter (tcindex) can be exploited to achieve local privilege
escalation.
The tcindex_delete function which does not properly deactivate filters
in case of a perfect hashes while deleting the underlying structure
which can later lead to double freeing the structure.
A local attacker user can use this vulnerability to elevate its
privileges to root.

To fix this issue the tcindex_classify(CONFIG_NET_CLS_TCINDEX) has been removed.
This bug affects the kernel 4.4 too.

Fixed status
mainline: [8c710f75256bb3cf05ac7b1672c82b92c43f3d28]
stable/4.14: [53af9c793f644d5841d84d8e0ad83bd7ab47f3e0]
stable/4.19: [01d0d2b8b4e3cf2110baba9371c0c3d04ad5c77b]
stable/5.10: [18c3fa7a7fdbb4d21dafc8a7710ae2c1680930f6]
stable/5.15: [7c183dc0af472dec33d2c0786a5e356baa8cad19]
stable/5.4: [7a6fb69bbcb21e9ce13bdf18c008c268874f0480]
stable/6.1: [3abebc503a5148072052c229c6b04b329a420ecd]
stable/6.2: [372ae77cf11d11fb118cbe2d37def9dd5f826abd]

CVE-2023-1872: A use-after-free bug was found in the io_uring

CVSS v3 score is not provided (NIST).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux Kernel io_uring system can
be exploited to achieve local privilege escalation. The
io_file_get_fixed function lacks the presence of ctx->uring_lock which
can lead to a Use-After-Free vulnerability due a race condition with
fixed files getting unregistered.

This bug was fixed in the 5.18 development cycle which is not
backported to old stable kernels. Therefore, kernel 5.10 has its own
fix.
Kernel 5.4 does not contain the vulnerable function
io_file_get_fixed() so it will not be affected.

Fixed status
mainline: [5106dd6e74ab6c94daac1c357094f11e6934b36f]
stable/5.10: [08681391b84da27133deefaaddefd0acfa90c2be,
da24142b1ef9fd5d36b76e36bab328a5b27523e8]

CVE-2023-1998: x86/speculation: Allow enabling STIBP with legacy IBRS

CVSS v3 score is not provided.

The vulnerability report said that "The Linux kernel allows userspace
processes to enable mitigations by calling prctl with
PR_SET_SPECULATION_CTRL which disables the speculation feature as well
as by using seccomp. We had noticed that on VMs of at least one major
cloud provider, the kernel still left the victim process exposed to
attacks in some cases even after enabling the spectre-BTI mitigation
with prctl. The same beahaviour can be observed on a bare-metal
machine when forcing the mitigation to IBRS on boot comand line.
This happened because when plain IBRS was enabled (not enhanced IBRS),
the kernel had some logic that determined that STIBP was not needed.
The IBRS bit implicitly protects against cross-thread branch target
injection. However, with legacy IBRS, the IBRS bit was cleared on
returning to userspace, due to performance reasons, which disabled the
implicit STIBP and left userspace threads vulnerable to cross-thread
branch target injection against which STIBP protects.".

This bug was introduced by commit Z7c693f5 ("x86/speculation: Add
spectre_v2=ibrs option to support Kernel IBRS") in 5.19-rc7.
This commit is not backported to 4.4 kernels.

Fixed status
mainline: [6921ed9049bc7457f66c1596c5b78aec0dae4a9d]
stable/4.14: [03bc360ce8896ef53ebcef83cccd9f24d9815160]
stable/4.19: [10543fb3c9b019e45e2045f08f46fdf526add593]
stable/5.10: [abfed855f05863d292de2d0ebab4656791bab9c8]
stable/5.15: [e7f1ddebd9f5b12de40bc37db9243957678f1448]
stable/5.4: [34c1b60e7a80404056c03936dd9c2438da2789d4]
stable/6.1: [08d87c87d6461d16827c9b88d84c48c26b6c994a]
stable/6.2: [ead3c8e54d28fa1d5454b1f8a21b96b4a969b1cb]

* Updated CVEs

CVE-2023-26544: KASAN: use-after-free Read in run_unpack

The mainline, 5.15, and 6.1 were fixed.

Fixed status
mainline: [887bfc546097fbe8071dac13b2fef73b77920899]
stable/5.15: [9c8471a17f1f15b18cb7b96cba86e6f9bd6aae1c]
stable/6.1: [d34485d40b6a263d65bc476554299c42b2ec0187]

CVE-2023-1611: Kernel: race between quota disable and quota assign
ioctls in fs/btrfs/ioctl.c

The mainline, 5.10, 5,15, 6.1, and 6.2 were fixed.

Fixed status
mainline: [2f1a6be12ab6c8470d5776e68644726c94257c54]
stable/5.10: [5f6347034341bf45056ca1ec3fa72040152ecf83]
stable/5.15: [c976f9233ef926e090db5614a837824a0bcab3fb]
stable/6.1: [a38ff2024805a30d9b96f52557c6ea0bbc31252a]
stable/6.2: [4caab245b0469ce9258ba099a41e909f5d307b33]

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

