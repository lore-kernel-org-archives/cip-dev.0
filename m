Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE80C433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 01:16:57 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by mx.groups.io with SMTP id smtpd.web11.5634.1642641414144066670
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jan 2022 17:16:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ss+eHP8G;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.53,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f53.google.com with SMTP id
 z25-20020a0568301db900b005946f536d85so5628112oti.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jan 2022 17:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=drW3bsgPclEi8ejUGjq8v5ofDVPOA/SRKgKBzM4Tg0I=;
        b=ss+eHP8GYP9sh5eyL3+9K29SR0Q5tHMFxQvlOFrzIlreoyU85Hj0SJ3NDDqsXc6GPc
         jUpyLyw4I/wTmBDxgfiD96i8+0MTuHhE9oJZ455zbEDpIq03R/fPow5tGhHRAMIoBHLp
         mM8Gp6Ns2AKceGzv+0AMwLjTI24+n6lVtUzHSgMVjWfaZ1Cdp/VVFIUpLeEqE5A898m9
         8NTUnmhMGl1jy7D/v81XTv5Z0pDDgzK1QTQ/ThomC/uG0TE5mRxPqb/HvZkIZvbHCT1c
         K2RCdjKX1RY/Akvu4HB82bZoNfSORadqec9ChIxGiiU3aXZfEERlN1b97pNdojv/5ApT
         a5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=drW3bsgPclEi8ejUGjq8v5ofDVPOA/SRKgKBzM4Tg0I=;
        b=ZltM1uOoFpc28hJZALBIBCiEDPH74FuL4mp3hGgS/qs8hYRR4fLjvxGPvzdvA1scUt
         DKpUtkWCYKnnQLz3LD50F99XUpXeFxlMz7qWCdnxevQO408ojQcD3AO1kvY8KIYcwYo5
         l5xXWdl4DmEdDAl/iDK9ztN/Ubl3ZWIV4l+EKG2q92jff+6WusIhAUwkXDO5m2YCgwpe
         e2g5sBaQMhE5fYQsddSYFDqW4ackca69qjlZeTUSFtRO38mpEOkKfuCEYBFjP2N9ktUg
         wxdN/HI4K3OEylBj90gjyhhQ1ifCTpqSQaYooM11hl76GXkyYN41S29X+okPO2UoBqZB
         b6ew==
X-Gm-Message-State: AOAM532HaUBWgsGzacp8jZjU2XgPWZkuJ3daHsv2QQhZHRMPZ63Hjaik
	r/cMSWGp7IDIYoHJ8I6KtHpro/MUsCQ6q3dAzGxqoZ1dAjITxA==
X-Google-Smtp-Source: 
 ABdhPJyjH8vqTg9IhHH+w32As5QlgSYVWRhqTZoTcfx/6Etw1LGc6Am7fAGK0PgTbzoGYpopZIwYADWn4JLfP3KIKUo=
X-Received: by 2002:a05:6830:2045:: with SMTP id
 f5mr25707332otp.67.1642641413106;
 Wed, 19 Jan 2022 17:16:53 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Jan 2022 10:16:17 +0900
Message-ID: 
 <CAODzB9pRmJELdQHUS50MgS=9O+LSy9Z9B7cOQuqq+H2fJB+ghQ@mail.gmail.com>
Subject: New CVE in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jan 2022 01:16:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7468

Hi !

It's this week's CVE report.

This week reported 2 new CVEs.

* New CVEs

CVE-2022-23222: bpf: Fix out of bounds access from invalid *_or_null
type verification

CVSS v3 score is not provided

The adjust_ptr_min_max_vals() in kernel/bpf/verifier.c didn't handle
proper input validation that led a local attacker can escalate his
privilege. This bug affects 5.8 or later kernel.
There is a mitigation that set kernel.unprivileged_bpf_disabled to 1.
So, disabled unprivileged bpf is good way for eBFP as usual :)

Fixed status

mainline: [c25b2ae136039ffa820c26138ed4a5e5f3ab3841]
stable/5.10: [35ab8c9085b0af847df7fac9571ccd26d9f0f513]
stable/5.15: [e8efe8369944c6199f124e3b50662ad05a048b60]
stable/5.16: [931e56be527fb2672556e3c00c57ff2a5f5de43e]

CVE-2022-0185: vfs: fs_context: fix up param length parsing in
legacy_parse_param

CVSS v3 score is not provided

It was introduced by commit 3e1aeb0 ("vfs: Implement a filesystem
superblock creation/configuration context") which was merged in
5.1-rc1. This bug's root cause is an integer underflow which makes a
heap overflow bug. If an unprivileged user can use unshare operation
with CAP_SYS_ADMIN, user will be able to exploit the system via this
bug.

Fixed status

mainline: [722d94847de29310e8aa03fcbdb41fc92c521756]

* Updated CVEs

CVE-2021-4095: 'KVM: NULL pointer dereference in kvm_dirty_ring_get()
in virt/kvm/dirty_ring.c'

This issue was fixed in the mainline this week. It introduced at
commit 629b534 ("KVM: x86/xen: update wallclock region") which was
merged in 5.12-rc1-dontuse.

Fixed status

mainline: [55749769fe608fa3f4a075e42e89d237c8e37637]

CVE-2021-4197: cgroup: Use open-time creds and namespace for migration
perm checks

Commit 1756d79 ("cgroup: Use open-time credentials for process
migraton perm checks") failed to apply to 4.4, 4.9, 4.14, 4.19,
5.4,and 5.10. This commit fixes 187fe84 ("cgroup: require write perm
on common ancestor when moving processes on the default hierarchy")
which was merged in 4.2-rc1.

Commit 0d2b595 ("cgroup: Allocate cgroup_file_ctx for
kernfs_open_file->priv") failed to apply to 4.14, 4.19, 5.4, and 5.10.

Commit e574576 ("cgroup: Use open-time cgroup namespace for process
migration perm checks") was failed to apply to 4.14, 4.19, 5.4, and
5.10. This commit fixes 5136f63 ("cgroup: implement "nsdelegate" mount
option") which was merged in 4.13-rc1.

Fixed status

mainline: [1756d7994ad85c2479af6ae5a9750b92324685af,
0d2b5955b36250a9428c832664f2079cbf723bec,
  e57457641613fef0d147ede8bd6a3047df588b95]
stable/5.15: [c6ebc35298848accb5e50c37fdb2490cf4690c92,
50273128d640e8d21a13aec5f4bbce4802f17d7d,
  43fa0b3639c5fd48c96b19d645d0c7ff2327651a]


Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2020-26555: BR/EDR pin code pairing broken

No fix information

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

