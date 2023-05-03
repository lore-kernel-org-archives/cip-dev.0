Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19DC77B78
	for <webhook@archiver.kernel.org>; Wed,  3 May 2023 22:54:22 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
 by mx.groups.io with SMTP id smtpd.web11.36447.1683154461771247060
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 May 2023 15:54:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=4WX/9z+h;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.53, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-546de76c23eso3052643eaf.0
        for <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 15:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1683154460; x=1685746460;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nh/f2U3iaX5bRh4aNBMOjClWckpadL5C2sk3LgxIj10=;
        b=4WX/9z+hnaGWRhc0C4ODmS4PKrmZfmFtkxc9rl5H1aJZDydebQZNpzBXEZMguoHmPU
         o0k9x6F8+xrr67lDoI865be6JK1LBuvU3mf3boSNGZkDrfI8wD/0RCHIdBYOoISB9FOg
         rev1cXRqfyAETEHn+v8k5fqdH7NJXEXlPVzGWFeBs24z+p1q3w2JFDYhLkcoyYG3gavA
         /xh2RbuyPCgmUPXRRGcd5YLWAIaw7xNiV3w7rdQ/Xjl8zQgI8BdxQVsBpVgGhf3rI2uo
         gF7KiDuQsqY4QOXPvPRVnbAEypy5Ba86fs0B7pCtk0YE5wevyL2L2P3b/PqwBBpINyq6
         KQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683154460; x=1685746460;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nh/f2U3iaX5bRh4aNBMOjClWckpadL5C2sk3LgxIj10=;
        b=ZiPTCCeT5dZKJlvAFGbBIb7Fn9eIZbFA3QI8nduZbItwrwv6dkvNx59lR3k5jYp3qh
         +jiW67VsdQZ1w2Hr6GnsVulVCVi3muFZx3IiUnVoXynrCqOKjm6CcnSt0moJelUza8eO
         /vIhUdltHjBf7lJO7WJR0Gd526auqfUXI0yhjWY4pswrt7z4mBycpGTUOlg5K2rFniRE
         Yn5qVwcPk+DYfFdaa9wiNwxsJUA8EEp8rGuJQgyi/a5RJs3Ft41rKOk75VUiywoIFh9j
         TuTg3SkqyKp9d0uEEhxyT/xHNqnRPQsBVwBo3VdT17bm01n+5sSdhQa5zgAzcSpq/+z3
         VmLA==
X-Gm-Message-State: AC+VfDywWpVaaKsecC3v9I+Ars+0d50qAh+gPWICoxGw8eFW1SYMCQPh
	rVOt695al5vAOhggfo1YDy21hwIm1AySK2CR5gDqyjgfGuvD9RCWCCE=
X-Google-Smtp-Source: ACHHUZ6ysZzXEegnMi2VbDblqc2FbNsQ09pGg5d/hyYjgK+gEEno/wmLcTGU7QqiJe5jGRT95MYktLSWrEByTzdBH7Q=
X-Received: by 2002:a05:6808:140d:b0:38d:e403:e318 with SMTP id
 w13-20020a056808140d00b0038de403e318mr783231oiv.52.1683154460165; Wed, 03 May
 2023 15:54:20 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 May 2023 07:53:43 +0900
Message-ID: <CAODzB9pABvLcMN8TKA1SBLi3D=qHuDG+nBGqn532zd12wwONcQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 May 2023 22:54:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11409

Hi !

It's this week's CVE report.

This week reported 5 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-31436: net: sched: sch_qfq: prevent slab-out-of-bounds in
qfq_activate_agg

CVSS v3 score is not provided.

qfq_change_class in net/sched/sch_qfq.c in the Linux kernel before
6.2.13 allows an out-of-bounds write because lmax can exceed
QFQ_MIN_LMAX.

This bug was introduced by commit 3015f3d ("pkt_sched: enable QFQ to
support TSO/GSO") in 3.7-rc5.

Fixed status
mainline: [3037933448f60f9acb705997eae62013ecb81e0d]
stable/4.14: [0616570ce23bbcc1ac842e97fb8e167235f1582d]
stable/4.19: [6ef8120262dfa63d9ec517d724e6f15591473a78]
stable/5.10: [ddcf35deb8f2a1d9addc74b586cf4c5a1f5d6020]
stable/5.15: [1ffc0e8105510cb826cb9d27ed1820a1131c82d4]
stable/5.4: [35dceaeab97c9e5f3fda3b10ce7f8110df0feecd]
stable/6.1: [ce729b06dc33b01f8a6ac84da5ef54154326bf7e]
stable/6.2: [420d014b19ff119e210ecc075ff611fe7844690c]

CVE-2023-2248: net: sched: sch_qfq: prevent slab-out-of-bounds in
qfq_activate_agg

CVSS v3 score is not provided (NVD).
CVSS v3 score is 7.8 HIGH (CNA).

A heap out-of-bounds read/write vulnerability in the Linux Kernel
traffic control (QoS) subsystem can be exploited to achieve local
privilege escalation.
The qfq_change_class function does not properly limit the lmax
variable which can lead to out-of-bounds read/write.
If the TCA_QFQ_LMAX value is not offered through nlattr, lmax is
determined by the MTU value of the network device.
The MTU of the loopback device can be set up to 2^31-1 and as a result,
it is possible to have an lmax value that exceeds QFQ_MIN_LMAX

It is a duplicate of CVE-2023-31436.

Fixed status
mainline: [3037933448f60f9acb705997eae62013ecb81e0d]
stable/4.14: [0616570ce23bbcc1ac842e97fb8e167235f1582d]
stable/4.19: [6ef8120262dfa63d9ec517d724e6f15591473a78]
stable/5.10: [ddcf35deb8f2a1d9addc74b586cf4c5a1f5d6020]
stable/5.15: [1ffc0e8105510cb826cb9d27ed1820a1131c82d4]
stable/5.4: [35dceaeab97c9e5f3fda3b10ce7f8110df0feecd]
stable/6.1: [ce729b06dc33b01f8a6ac84da5ef54154326bf7e]
stable/6.2: [420d014b19ff119e210ecc075ff611fe7844690c]

CVE-2023-2430: io_uring/msg_ring: fix missing lock on overflow for IOPOLL

CVSS v3 score is not provided.

A vulnerability due to missing lock on overflow for IOPOLL bug in
io_cqring_event_overflow() which causes a denial of service.
This bug is in the io_uring subsystem, so kernel 4.x aren't affected.

Fixed status
mainline: [e12d7a46f65ae4b7d58a5e0c1cbfa825cf8d830d]

CVE-2023-2235: A use-after-free bug was found in the perf subsystem

CVSS v3 score is not provided (NVD).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux Kernel Performance Events
system can be exploited to achieve local privilege escalation. The
perf_group_detach function did not check the event's siblings'
attach_state before calling add_event_to_groups(), but remove_on_exec
made it possible to call list_del_event() on before detaching from
their group, making it possible to use a dangling pointer causing a
use-after-free vulnerability.

It was introduced by commit 2e498d0 ("perf: Add support for event
removal on exec") in 5.13-rc1.
Before Linux 5.13 kernels aren't affected by this bug.

Fixed status
mainline: [fd0815f632c24878e325821943edccc7fde947a2]
stable/5.15: [de3ef7ba684a25313c4b7405d007ab22912ef95a]
stable/6.1: [529546ea2834ce58aa075837d57918740accf713]
stable/6.2: [2c6d1b32838d8cf0114dfdbbb93f4d808e498760]

CVE-2023-2236: a use-after-free bug was found in the io_uring subsystem

CVSS v3 score is not provided (NVD).
CVSS v3 score is 7.8 HIGH (CNA).

A use-after-free vulnerability in the Linux Kernel io_uring subsystem
can be exploited to achieve local privilege escalation. Both
io_install_fixed_file and its callers call fput in a file in case of
an error, causing a reference underflow which leads to a
use-after-free vulnerability.

This bug was introduced by commit 61c1b44 ("io_uring: fix deadlock on
iowq file slot alloc") in 5.19-rc1.
Before Linux 5.19 kernels aren't affected by this bug.

Fixed status
mainline: [9d94c04c0db024922e886c9fd429659f22f48ea4]

* Updated CVEs

CVE-2023-1281: net/sched: tcindex: imperfect hash filters

stable 4.19 was fixed.

Fixed status
mainline: [ee059170b1f7e94e55fa6cadee544e176a6e59c2]
stable/4.19: [01d0d2b8b4e3cf2110baba9371c0c3d04ad5c77b]
stable/5.10: [eb8e9d8572d1d9df17272783ad8a84843ce559d4]
stable/5.15: [becf55394f6acb60dd60634a1c797e73c747f9da]
stable/6.1: [bd662ba56187b5ef8a62a3511371cd38299a507f]

CVE-2023-2002: bluetooth: Perform careful capability checks in hci_sock_ioctl()

Fixed in the mainline, 5.15, 6.1, and 6.2.

Fixed status
mainline: [25c150ac103a4ebeed0319994c742a90634ddf18]
stable/5.15: [f1e6a14d5ae879d6ab6d90c58d2fde1b5716b389]
stable/6.1: [47e6893a5b0ad14c0b1c25983a1facb1cf667b6e]
stable/6.2: [727b3ea80f3fdda6c686806ce3579face0415c76]
stable/6.3: [dd30f9da333748488d96b7cb3c5a17bbaf86b32d]

CVE-2023-1380: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

5.15, 6.1, and 6.2 were fixed.

Fixed status
mainline: [0da40e018fd034d87c9460123fa7f897b69fdee7]
stable/5.15: [936a23293bbb3332bdf4cdb9c1496e80cb0bc2c8]
stable/6.1: [e29661611e6e71027159a3140e818ef3b99f32dd]
stable/6.2: [228186629ea970cc78b7d7d5f593f2d32fddf9f6]
stable/6.3: [21bee3e649d87f78fe8aef6ae02edd3d6f310fd0]

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

