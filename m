Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DB9C04A95
	for <webhook@archiver.kernel.org>; Wed, 28 Sep 2022 23:43:02 +0000 (UTC)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 by mx.groups.io with SMTP id smtpd.web10.4587.1664408572007471491
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Sep 2022 16:42:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=q3AEkECv;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.175,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f175.google.com with SMTP id t62so17105664oie.10
        for <cip-dev@lists.cip-project.org>;
 Wed, 28 Sep 2022 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=Y6uYYihc4rsJ11RqXKfdB0zgdV1gMYNestvZJblf/xY=;
        b=q3AEkECvb5RWaoUfHS4X/ZYbwZ/e7N13BoYzXxyBkTPkDlpJ7YyFZT4k9iy0U5vOT+
         Ve2RnvZeL4sZwOGYJbdLJnDXQPWw0PaUDhWzTXBS6sebVJrTSgR4z1cu4Cinvolwnhhb
         kL7fb/gL4ExzcKNUJ/M6lLzqG8BWIGhm/csiH4veM629juvMvZ5p0OoOxG1EEzqxmqYZ
         py2RCvL77QM+w/s0cnZLXkztsOSgPlo4jKp6JaiKeBCIZ/MJGTHJYP7yLXxpXVSSs75l
         nWequhMLD+5TlUKrvGenFq6u5glUiraGLxFu/2dKAjLpC+rCxDdosFVxOcanBEh8cdhH
         wcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=Y6uYYihc4rsJ11RqXKfdB0zgdV1gMYNestvZJblf/xY=;
        b=ZyJHyRGVpSmF6x3xblJuTksaDuH6lSaswctF0g1UjjSNVrAswlFv4EUByDLOCM5qUf
         NC20XGPWNO8B6VFJJMmV5wpwxi6KYEmb4DL9QvWUvs3pGlfBnN6lPMbWLcQX2LB0yOyJ
         i5vFMU7ALFCkt/QRIKzw6piBXzyJVx316LQlIdReXL+ixmID9F+Fuz6MEZ90fGW/MWpT
         WpHHq9Cqxp5rAGaTqM2ZNrlDwEpyqPP5PBLh/lN9eBa8zs3R2NO6Q/DnlMbljSIRSzqp
         AAwRo8/U06vyAsevXbZ8batPtCxrthYyUJ7RWSYPWGXB498qr4Lw3K1Mw6PL3V+b26Eg
         VAQA==
X-Gm-Message-State: ACrzQf0Yy7dBZRmmr95HQ+Ud5wPDF0zPPnLqSYtY5pkwVN4P8LC3CLlV
	Zctdn9U2tHgmhNoqofIJLZ3zsdpPk2GBuPeqgM+TuMqv5s0FbA==
X-Google-Smtp-Source: 
 AMsMyM4vXGcBUL9L5qYKTG2Hj8JNAP09F++I/2CNv1ErvGj4oY7HW4E5e6YIG4nvFBShE14zL2oQ8sShehNH8fjp5Vo=
X-Received: by 2002:aca:90a:0:b0:350:20a0:52ff with SMTP id
 10-20020aca090a000000b0035020a052ffmr5574816oij.94.1664408570671; Wed, 28 Sep
 2022 16:42:50 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Sep 2022 08:42:14 +0900
Message-ID: 
 <CAODzB9p_KZnt1p9Baw=0ouMCxm9DmvtsNZk5fWJznPRSm7bqLw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 28 Sep 2022 23:43:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9573

Hi !

It's this week's CVE report.

This week reported 6 new CVEs and 5 updated CVEs.

* New CVEs

CVE-2022-2785: bpf: Disallow bpf programs call prog_run command.

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 6.7 MEDIUM(CNA).

There exists an arbitrary memory read within the Linux Kernel BPF -
Constants provided to fill pointers in structs passed in to
bpf_sys_bpf are not verified and can point anywhere, including memory
not owned by BPF. An attacker with CAP_BPF can arbitrarily read memory
from anywhere on the system.

This vulnerability was introduced by commit b1d18a7574d0 ("bpf: Extend
sys_bpf commands for bpf_syscall programs.") in 5.18-rc1.
LTS kernels don't have this commit so they aren't affected by this issue.

Fixed status
mainline: [86f44fcec22ce2979507742bc53db8400e454f46]
stable/5.19: [b429d0b9a7a0f3dddb1f782b72629e6353f292fd]

CVE-2022-3103: io_uring: fix off-by-one in sync cancelation file check

CVSS v3 score is 7.8 HIGH.

There is a wrong validation check in io_uring/cancel.c.  It will cause
an off-by-one.

This bug was introduced by commit 78a861b ("io_uring: add sync
cancelation API through io_uring_register()") in 6.0-rc1. This commit
is not backported to stable kernels so it only affected from 6.0-rc1
to 6.0-rc2.

Fixed status
mainline: [47abea041f897d64dbd5777f0cf7745148f85d75]

CVE-2022-3239: A use-after-free bug was found in video4linux driver
for the Empia 28xx based TV cards

CVSS v3 score is 7.8 HIGH

A flaw use after free in the Linux kernel video4linux driver was found
in the way user triggers em28xx_usb_probe() for the Empia 28xx based
TV cards. A local user could use this flaw to crash the system or
potentially escalate their privileges on the system.
This bug was introduced by commit 47677e5 ("[media] em28xx: Only
deallocate struct em28xx after finishing all extensions") in 3.15-rc1.

No CIP member enables CONFIG_VIDEO_EM28XX.

Fixed status
mainline: [c08eadca1bdfa099e20a32f8fa4b52b2f672236d]
stable/4.14: [1f6ab281f218c3a2b789eb976c5b1ef67139680a]
stable/4.19: [0113fa98a49a8e46a19b0ad80f29c904c6feec23]
stable/5.10: [ec8a37b2d9a76a9443feb0af95bd06ac3df25444]
stable/5.15: [332d45fe51d75a3a95c4a04e2cb7bffef284edd4]
stable/5.4: [92f84aa82dfaa8382785874277b0c4bedec89a68]

CVE-2022-36402: An integer overflow vulnerability was found in vmwgfx driver

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 6.3 MEDIUM(CNA).

An integer overflow vulnerability was found in vmwgfx driver in
drivers/gpu/vmxgfx/vmxgfx_execbuf.c in GPU component of Linux kernel
with device file '/dev/dri/renderD128 (or Dxxx)'. This flaw allows a
local attacker with a user account on the system to gain privilege,
causing a denial of service(DoS).

Fixed status
Not fixed yet.

CVE-2022-3303: ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC

CVSS v3 score is not assigned.

A race condition bug was found in snd_pcm_oss_sync() in the
sound/core/oss/pcm_oss.c. This race condition triggers a NULL pointer
dereference that results in a system crash. It looks as if 4.4 is
affected too.

Fixed status
mainline: [8423f0b6d513b259fdab9c9bf4aaa6188d054c2d]
stable/5.15: [8015ef9e8a0ee5cecfd0cb6805834d007ab26f86]
stable/5.19: [723ac5ab2891b6c10dd6cc78ef5456af593490eb]
stable/5.4: [4051324a6dafd7053c74c475e80b3ba10ae672b0]

CVE-2022-3170: ALSA: control: Re-order bounds checking in get_ctl_id_hash()

CVSS v3 score is 7.8 HIGH.

An out-of-bounds access issue was found in the Linux kernel sound
subsystem. It could occur when the 'id->name' provided by the user did
not end with '\0'. A privileged local user could pass a specially
crafted name through ioctl() interface and crash the system or
potentially escalate their privileges on the system.

This vulnarability's root cause is commit c27e1ef ("ALSA: control: Use
xarray for faster lookups"). This commit was merged in 6.0-rc1. The
commit c27e1ef is not backported to stable kernels. So, it affected
6.0-rc1 to 6.0-rc4.

Fixed status
mainline: [5934d9a0383619c14df91af8fd76261dc3de2f5f,
6ab55ec0a938c7f943a4edba3d6514f775983887]

* Updated CVEs

CVE-2022-0171: KVM: cache incoherence issue in SEV API may lead to
kernel crash

stable 5.10 and 5.15 was fixed. This vulnerability is affected to 5.10
or later version.

Fixed status
mainline: [683412ccf61294d727ead4a73d97397396e69a6b]
stable/5.10: [a60babeb60ff276963d4756c7fd2e7bf242bb777]
stable/5.15: [39b0235284c7aa33a64e07b825add7a2c108094a]

CVE-2022-3061: video: fbdev: i740fb: Error out if ''pixclock'' equals zero

5.10 and 5.15 were fixed.

Fixed status
mainline: [15cf0b82271b1823fb02ab8c377badba614d95d5]
stable/5.10: [e00582a36198888ffe91ed6b097d86556c8bb253]
stable/5.15: [59b756da49bfa51a00a0b58b4147ce2652bc3d28]

CVE-2022-39842: video: fbdev: pxa3xx-gcu: Fix integer overflow in
pxa3xx_gcu_write

4.14, 4.10, 4.9, 5.4, 5.10 and 5.15 were fixed.

Fixed status
mainline: [a09d2d00af53b43c6f11e6ab3cb58443c2cac8a7]
stable/4.14: [9556a88a16e381dbd6834da95206742d0973afc6]
stable/4.19: [a34547fc43d02f2662b2b62c9a4c578594cf662d]
stable/4.9: [a0dcaa48042a56a9eee2efed19563866a0ddbce2]
stable/5.10: [06e194e1130c98f82d46beb40cdbc88a0d4fd6de]
stable/5.15: [ab5140c6ddd7473509e12f468948de91138b124e]
stable/5.4: [1878eaf0edb8c9e58a6ca0cf31b7a647ca346be9]

CVE-2022-40307: efi: capsule-loader: Fix use-after-free in efi_capsule_write

This vulnerability was introduced by commit 65117f1 ("efi: Add misc
char driver interface to update EFI firmware") was merged in 4.7-rc1.
4.4.y-cip and linux-4.4.y-rt have this commit but 4.4.y-st doesn't.

Fixed status
mainline: [9cb636b5f6a8cc6d1b50809ec8f8d33ae0c84c95]
stable/4.14: [233d5c4d18971feee5fc2f33f00b63d8205cfc67]
stable/4.19: [021805af5bedeafc76c117fc771c100b358ab419]
stable/5.10: [918d9c4a4bdf5205f2fb3f64dddfb56c9a1d01d6]
stable/5.15: [dd291e070be0eca8807476b022bda00c891d9066]
stable/5.19: [d46815a8f26ca6db2336106a148265239f73b0af]
stable/5.4: [8028ff4cdbb3f20d3c1c04be33a83bab0cb94997]

CVE-2021-4037: kernel: security regression for CVE-2018-13405

5.10 was fixed.

Fixed status
mainline: [01ea173e103edd5ec41acec65b9261b87e123fc2]
stable/5.10: [e811a534ec2f7f6c0d27532c0915715427b7cab1]

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

