Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A16CCF9EB
	for <webhook@archiver.kernel.org>; Thu, 30 Oct 2025 00:16:12 +0000 (UTC)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
 by mx.groups.io with SMTP id smtpd.web11.17166.1761783365976627354
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Oct 2025 17:16:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=UHD4qmnQ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.178, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-781014f4e12so8037177b3.1
        for <cip-dev@lists.cip-project.org>; Wed, 29 Oct 2025 17:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1761783365; x=1762388165; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v3RIUT2W8MlHE7bDlAnVIs+1Tw4xaNd91su8XfBGhps=;
        b=UHD4qmnQt3dm0N/51hk3EhgFVoME15yArGEyviXhGApmbjUPG1+3jj1VzlFkbLZbCO
         FJJeiwVwJtg56LK3ovN83GyRySaesJuloSaATg49DRRk6OR3kXPj/PJ+r+rQsEpIWuKH
         q8grxJOb4U/t8uKccl3VID6is4PuXFTwxYfDPvu75uxCBPe3hWOQLLbA+/7TmdHmlUhq
         LXvO1X4HmJgIP5zwtIU0GM7c5KGzHyRTQsaUSMV8NmXkxlLJu13enuVQ4+ICrLAbEhTe
         oUF6dh0zagv064gwjfet890M0BqSORxp5KXEDFtvcZ0R88aihyv0asBMygZTrAhZ3d+q
         ePIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761783365; x=1762388165;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v3RIUT2W8MlHE7bDlAnVIs+1Tw4xaNd91su8XfBGhps=;
        b=QoVn16fa+jvKNAY95RLMOU2wYam9rpbERGlXK7vJ+to3rA3AyiHO7ExklEWYqh+wA1
         Hpgg4LOGHaS7cRrH+XI93aqLst4MllIrFgh0oxa//Tbm8dJPofcEyedPLR+ZXUar0dzX
         9gTvt60aDtSkwd7M3yU1k9x+uG4sEI8TSlxr51qJ5gtfLB0G4lcgspINY3n7Jfzpg6lm
         6Ox/DP1i2fLAca5HA1P5xQYt77CxG6qritGwKCtbRWC+BVPhZs8b40xmaKYBheM1HtrX
         CUmoEpNSpdl2OqNUZ0owgFiRfRyGnhskhB1+frKYWGT7y4gCsLs9hfHEfWyJ4GiGt3Px
         6iqg==
X-Gm-Message-State: AOJu0Yy2BRWUR1e9JdwCe5+Jtvkas7ki726/Mh5PafMytjDVKiEKRKLj
	Cl5U26riLRbB06Y2I/2AZWElWS2qFifZdyCUCmWo+T6DBjCIOsMtoW6lLVm0PXZe0TajnD2oeok
	g+JN2mjR+FKxGr3E+p19yB53YAsT+kWWOJPCqpJyr/pCfxUbIo3TknJY=
X-Gm-Gg: ASbGncsjs9UZVdqulekjOsKJPl/kxP0LNXCtr95RRWWldwnzqypERph+IxxG3IeKmtF
	Q0/Yc550rAMX+zk3VmVN5wJD57oJwjt08ymRr3fJNJIx6/rH/QhqiMx3i/giYbSnN1o/XTp+4kE
	JOMHo7Zuaup99lh5zCHqBRw3GxXyrBhuJyXHz142DbA0BLUQV6FldGHM/3DVjZ6jKju2iMQIzS4
	INtESt3Gizr7PN+EThoMckYWZL3ten20O8YcjjuhnzdTUIwDYijMrD63Llt6Q==
X-Google-Smtp-Source: AGHT+IFYVc7yNzxKuODWzbRoywTj8Gel/vAPXGS8RDoh2v6yhhSxEDaJllVFTDBFXBVcbaZMHNXqPjFsd6PVQX5o/NA=
X-Received: by 2002:a05:690c:610b:b0:785:cc3e:12f3 with SMTP id
 00721157ae682-7863901aa67mr16351327b3.11.1761783363946; Wed, 29 Oct 2025
 17:16:03 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 30 Oct 2025 09:15:28 +0900
X-Gm-Features: AWmQ_bl6g634uvWMf-KVtYO8Cul88yWmB4mNpbKuweASFo45GMd_iil_oasP7Ps
Message-ID: <CAODzB9o6q5gXPPwXGJwjW8zphQhMV9CTJ5NTb=6K5CfM7NBWng@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Oct 2025 00:16:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20277

Hi!

It's this week's CVE report.

This week reported 70 new CVEs and 32 updated CVEs.

* New CVEs
CVE-2023-53733: net: sched: cls_u32: Undo tcf_bind_filter if
u32_replace_hw_knode

Announce: https://www.cve.org/CVERecord?id=CVE-2023-53733

Introduced by commit d34e3e1 ("net: cls_u32: Add support for skip-sw
flag to tc u32 classifier.") in v4.7-rc1.
Fixed in v6.5-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cb36faedeafb9720ac236aeae2ea57091d90a09]
stable/6.1: [a9345793469b65ee5ba7b033239916c2a67d3dd4]

CVE-2025-40018: ipvs: Defer ip_vs_ftp unregister during netns cleanup

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40018

Introduced by commit 61b1ab4 ("IPVS: netns, add basic init per
netns.") in v2.6.39-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [134121bfd99a06d44ef5ba15a9beb075297c0821]
stable/5.10: [421b1ae1574dfdda68b835c15ac4921ec0030182]
stable/5.15: [1d79471414d7b9424d699afff2aa79fff322f52d]
stable/5.4: [8a6ecab3847c213ce2855b0378e63ce839085de3]
stable/6.1: [53717f8a4347b78eac6488072ad8e5adbaff38d9]
stable/6.12: [dc1a481359a72ee7e548f1f5da671282a7c13b8f]
stable/6.6: [8cbe2a21d85727b66d7c591fd5d83df0d8c4f757]

CVE-2025-40019: crypto: essiv - Check ssize for decryption and
in-place encryption

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40019

Introduced by commit be1eb7f ("crypto: essiv - create wrapper template
for ESSIV generation") in v5.4-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bb73db6948c2de23e407fe1b7ef94bf02b7529f]
stable/5.10: [71f03f8f72d9c70ffba76980e78b38c180e61589]
stable/5.15: [df58651968f82344a0ed2afdafd20ecfc55ff548]
stable/5.4: [29294dd6f1e7acf527255fb136ffde6602c3a129]
stable/6.1: [248ff2797ff52a8cbf86507f9583437443bf7685]
stable/6.12: [dc4c854a5e7453c465fa73b153eba4ef2a240abe]
stable/6.6: [f37e7860dc5e94c70b4a3e38a5809181310ea9ac]

CVE-2025-40020: can: peak_usb: fix shift-out-of-bounds issue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40020

Introduced by commit bb47855 ("can: usb: PEAK-System Technik USB
adapters driver core") in v3.4-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
cip/4.19-st: [354300200ce02b2d2ddbbb2c92313ee1a1a70f3f]
mainline: [c443be70aaee42c2d1d251e0329e0a69dd96ae54]
stable/5.10: [61b1dd4c614935169d12bdecc26906e37b508618]
stable/5.15: [48822a59ecc47d353400d38b1941d3ae7591ffff]
stable/5.4: [572c656802781cc57f4a3231eefa83547e75ed78]
stable/6.1: [176c81cbf9c4e348610a421aad800087c0401f60]
stable/6.12: [eb79ed970670344380e77d62f8188e8015648d94]
stable/6.6: [17edec1830e48c0becd61642d0e40bc753243b16]

CVE-2025-40021: tracing: dynevent: Add a missing lockdown check on dynevent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40021

Introduced by commit 17911ff ("tracing: Add locked_down checks to the
open calls of files created for tracefs") in v5.4-rc3.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [456c32e3c4316654f95f9d49c12cbecfb77d5660]
stable/5.10: [f3ac1f4eaba58e57943efa3e8b8d71fa7aab0abf]
stable/5.15: [0d41604d2d53c1abe27fefb54b37a8f6642a4d74]
stable/6.1: [07b1f63b5f86765793fab44d3d4c2be681cddafb]
stable/6.12: [573b1e39edfcb7b4eecde0f1664455a1f4462eee]
stable/6.6: [3887f3814c0e770e6b73567fe0f83a2c01a6470c]

CVE-2025-40022: crypto: af_alg - Fix incorrect boolean values in af_alg_ctx

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40022

Introduced by commit 1b34cbb ("crypto: af_alg - Disallow concurrent
writes in af_alg_sendmsg") in v6.17-rc7.
Fixed in v6.17.

Bug introduced commit was backported to following branches.
cip/5.10 cip/6.1 cip/6.1-rt cip/6.12 stable/5.10 stable/5.15
stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [d0ca0df179c4b21e2a6c4a4fb637aa8fa14575cb]
stable/5.10: [3a21698ace915a445bce2d0dcfc84b6d2199baf7]
stable/5.15: [d382d6daf0184490f366562469a5673f65ee2662]
stable/6.1: [54506c6335690f4ef1b9f154e34f5a604c72c1ed]
stable/6.12: [316b090c2fee964c307a634fecc7df269664b158]
stable/6.6: [8703940bd30b5ad94408d28d7192db2491cd3592]

CVE-2025-40023: drm/xe/vf: Don't expose sysfs attributes not applicable for VFs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40023

Introduced by commit 0e414bf ("drm/xe: Expose PCIe link downgrade
attributes") in v6.16-rc1.
Introduced by commit cdc36b6 ("drm/xe: Expose fan control and voltage
regulator version") in v6.17-rc1.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [500dad428e5b0de4c1bdfa893822a6e06ddad0b5]

CVE-2025-40024: vhost: Take a reference on the task in struct vhost_task.

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40024

Introduced by commit f9010db ("fork, vhost: Use CLONE_THREAD to fix
freezer/ps regression") in v6.4-rc5.
Fixed in v6.17.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [afe16653e05db07d658b55245c7a2e0603f136c0]
stable/6.12: [d2be773a92874a070215b51b730cb2b1eaa8fae2]
stable/6.6: [82a1463c968b1a6ae598a4f2fcef17b71bb7d3a0]

CVE-2025-40025: f2fs: fix to do sanity check on node footer for non inode dnode

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40025

Introduced commit is not determined.Fixed in v6.18-rc1.


Fixed status
mainline: [c18ecd99e0c707ef8f83cace861cbc3162f4fdf1]

CVE-2025-40026: KVM: x86: Don't (re)check L1 intercepts when
completing userspace I/O

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40026

Introduced by commit 8a76d7f ("KVM: x86: Add x86 callback for
intercept check") in v3.0-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e750f85391286a4c8100275516973324b621a269]
stable/5.10: [00338255bb1f422642fb2798ebe92e93b6e4209b]
stable/5.15: [e0ce3ed1048a47986d15aef1a98ebda25560d257]
stable/5.4: [a908eca437789589dd4624da428614c1275064dc]
stable/6.1: [ba35a5d775799ce5ad60230be97336f2fefd518e]
stable/6.12: [e7177c7e32cb806f348387b7f4faafd4a5b32054]
stable/6.6: [3d3abf3f7e8b1abb082070a343de82d7efc80523]

CVE-2025-40027: net/9p: fix double req put in p9_fd_cancelled

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40027

Introduced by commit afd8d65 ("9P: Add cancelled() to the transport
functions.") in v3.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [674b56aa57f9379854cb6798c3bbcef7e7b51ab7]
stable/5.10: [5c64c0b7b3446f7ed088a13bc8d7487d66534cbb]
stable/5.15: [c1db864270eb7fea94a9ef201da0c9dc1cbab7b8]
stable/5.4: [a5901a0dfb5964525990106706ae8b98db098226]
stable/6.1: [0e0097005abc02c9f262370674f855625f4f3fb4]
stable/6.12: [716dceb19a9f8ff6c9d3aee5a771a93d6a47a0b6]
stable/6.6: [284e67a93b8c48952b6fc82129a8d3eb9dc73b06]

CVE-2025-40028: binder: fix double-free in dbitmap

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40028

Introduced by commit 15d9da3 ("binder: use bitmap for faster
descriptor lookup") in v6.11-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3ebcd3460cad351f198c39c6edb4af519a0ed934]
stable/6.12: [c301ec61ce6f16e21a36b99225ca8a20c1591e10]

CVE-2025-40029: bus: fsl-mc: Check return value of platform_get_resource()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40029

Introduced by commit 6305166 ("bus: fsl-mc: Add ACPI support for
fsl-mc") in v5.9-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [25f526507b8ccc6ac3a43bc094d09b1f9b0b90ae]
stable/5.10: [58dd05070b57a20f22ff35a34ef9846bdf49a1d0]
stable/5.15: [8a4dd74fe413d4a278e649be1d22d028e1667116]
stable/6.1: [e60d55692e6c8e951000343c39f3fc92cab57efc]
stable/6.12: [84ec0482ed9c9ed0aee553a5e7e7458ad79c021f]
stable/6.6: [78e87b8a3cf8a59671ea25c87192d16e8d710e1c]

CVE-2025-40030: pinctrl: check the return value of
pinmux_ops::get_function_name()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40030

Introduced commit is not determined.Fixed in v6.18-rc1.
Affected code was added by 2744e8a ("drivers: create a pin control
subsystem") in 3.2-rc1.

Fixed status
mainline: [4002ee98c022d671ecc1e4a84029e9ae7d8a5603]
stable/5.10: [e7265dc4c670b89611bcf5fe33acf99bc0aa294f]
stable/5.15: [d77ef2f621cd1d605372c4c6ce667c496f6990c3]
stable/5.4: [1a7fc8fed2bb2e113604fde7a45432ace2056b97]
stable/6.1: [ba7f7c2b2b3261e7def67018c38c69b626e0e66e]
stable/6.12: [688c688e0bf55824f4a38f8c2180046f089a3e3b]
stable/6.6: [1a2ea887a5cd7d47bab599f733d89444df018b1a]

CVE-2025-40031: tee: fix register_shm_helper()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40031

Introduced by commit 7bdee41 ("tee: Use iov_iter to better support
shared buffer registration") in v6.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5cf5b37064b1699d946e8b7ab4ac7d7d101814c]
stable/6.12: [9338093db954918558677a468d32e77041c65167]

CVE-2025-40032: PCI: endpoint: pci-epf-test: Add NULL check for DMA
channels before release

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40032

Introduced by commit 8353813 ("PCI: endpoint: Enable DMA tests for
endpoints with DMA capabilities") in v6.0-rc1.
Introduced by commit 5ebf3fc ("PCI: endpoint: functions/pci-epf-test:
Add DMA support to transfer data") in v5.7-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [85afa9ea122dd9d4a2ead104a951d318975dcd25]
stable/6.1: [6411f840a9b5c47c00ca8e004733de232553870d]
stable/6.12: [fb54ffd60064c4e5139a3eb216e877b1acae1c8b]
stable/6.6: [0c5ce6b6ccc22d486cc7239ed908cb0ae5363a7b]

CVE-2025-40033: remoteproc: pru: Fix potential NULL pointer
dereference in pru_rproc_set_ctable()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40033

Introduced by commit 1028534 ("remoteproc: pru: Add
pru_rproc_set_ctable() function") in v6.3-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d41e075b077142bb9ae5df40b9ddf9fd7821a811]
stable/6.12: [c9b6d789591f2bd57b0cbd59592493e11e029ed4]
stable/6.6: [66821fdb723d55b25482a76b92d17d416efeae6b]

CVE-2025-40034: PCI/AER: Avoid NULL pointer dereference in aer_ratelimit()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40034

Introduced by commit a57f2bf ("PCI/AER: Ratelimit correctable and
non-fatal error logging") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [deb2f228388ff3a9d0623e3b59a053e9235c341d]

CVE-2025-40035: Input: uinput - zero-initialize
uinput_ff_upload_compat to avoid info leak

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40035

Introduced by commit 2d56f3a ("Input: refactor evdev 32bit compat to
be shareable with uinput") in v2.6.29-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3366a04770eea807f2826cbdb96934dd8c9bf79]
stable/5.10: [877172b97786ed1678640dff0b2d35abb328844c]
stable/5.15: [e63aade22a33e77b93c98c9f02db504d897a76b4]
stable/5.4: [1b317796013f666ae5040edbf0f230ec61496d42]
stable/6.1: [933b87c4590b42500299f00ff55f555903056803]
stable/6.12: [48c96b7e9e03516936d6deba54b5553097eae817]
stable/6.6: [fd8a23ecbc602d00e47b27f20b07350867d0ebe5]

CVE-2025-40036: misc: fastrpc: fix possible map leak in fastrpc_put_args

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40036

Introduced by commit c68cfb7 ("misc: fastrpc: Add support for context
Invoke method") in v5.1-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da1ba64176e0138f2bfa96f9e43e8c3640d01e1e]
stable/6.1: [a085658264d0c8d4f795d4631f77d7289a021de9]
stable/6.12: [78d33a041555db03903e8037fd053ed74fbd88cb]
stable/6.6: [3ad42dc66445df6977cf4be0c06f1a655299ce6c]

CVE-2025-40037: fbdev: simplefb: Fix use after free in simplefb_detach_genpds()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40037

Introduced by commit 92a511a ("fbdev/simplefb: Add support for generic
power-domains") in v6.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [da1bb9135213744e7ec398826c8f2e843de4fb94]
stable/6.12: [b1deb39cfd614fb2f278b71011692a8dbf0f05ba]

CVE-2025-40038: KVM: SVM: Skip fastpath emulation on VM-Exit if next
RIP isn't valid

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40038

Introduced by commit b439eb8 ("Revert "KVM: SVM: Skip WRMSR fastpath
on VM-Exit if next RIP isn't valid"") in v6.5-rc4.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0910dd7c9ad45a2605c45fd2bf3d1bcac087687c]
stable/6.12: [f994e9c790ce97d3cf01af4d0a1b9add0c955aee]
stable/6.6: [cd3efb93677c4b0cf76348882fb429165fee33fd]

CVE-2025-40039: ksmbd: Fix race condition in RPC handle list access

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40039

Introduced by commit a1f46c9 ("ksmbd: fix use-after-free in
ksmbd_session_rpc_open") in v6.15-rc5.
Introduced by commit b685757 ("ksmbd: Implements sess->rpc_handle_list
as xarray") in v6.3-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [305853cce379407090a73b38c5de5ba748893aee]
stable/6.12: [5cc679ba0f4505936124cd4179ba66bb0a4bd9f3]

CVE-2025-40040: mm/ksm: fix flag-dropping behavior in ksm_madvise

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40040

Introduced by commit 7677f7f ("userfaultfd: add minor fault
registration mode") in v5.13-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f04aad36a07cc17b7a5d5b9a2d386ce6fae63e93]
stable/6.1: [41cb9fd904fe0c39d52e82dd84dc3c96b7aa9693]
stable/6.12: [ac50c6e0a8f91a02b681af81abb2362fbb67cc18]
stable/6.6: [92b82e232b8d8b116ac6e57aeae7a6033db92c60]

CVE-2025-40041: LoongArch: BPF: Sign-extend struct ops return values properly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40041

Introduced by commit 6abf17d ("LoongArch: BPF: Add struct ops support
for trampoline") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8b51b11b3d81c1ed48a52f87da9256d737b723a0]

CVE-2025-40042: tracing: Fix race condition in kprobe initialization
causing NULL pointer dereference

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40042

Introduced by commit 50d7805 ("tracing/kprobes: Add probe handler
dispatcher to support perf and ftrace concurrent use") in v2.6.33-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9cf9aa7b0acfde7545c1a1d912576e9bab28dc6f]
stable/5.10: [9c4951b691bb8d7a004acd010f45144391f85ea6]
stable/5.15: [95dd33361061f808d1f68616d69ada639e737cfa]
stable/5.4: [07926ce598a95de6fd874a74fb510e2ebdfd0aae]
stable/6.1: [a6e89ada1ff6b70df73f579071ffa6ade8ae7f98]
stable/6.12: [0fa388ab2c290ef1115ff88ae88e881d0fb2db02]
stable/6.6: [1a301228c0a8aedc3154fb1a274456f487416b96]

CVE-2025-40043: net: nfc: nci: Add parameter validation for packet data

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40043

Introduced by commit 6a2968a ("NFC: basic NCI protocol
implementation") in v3.2-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9c328f54741bd5465ca1dc717c84c04242fac2e1]
stable/5.15: [8fcc7315a10a84264e55bb65ede10f0af20a983f]
stable/6.1: [bfdda0123dde406dbff62e7e9136037e97998a15]
stable/6.12: [74837bca0748763a77f77db47a0bdbe63b347628]
stable/6.6: [0ba68bea1e356f466ad29449938bea12f5f3711f]

CVE-2025-40044: fs: udf: fix OOB read in lengthAllocDescs handling

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40044

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3bd5e45c2ce30e239d596becd5db720f7eb83c99]
stable/5.10: [d2ed9aa8ae50fb0d4ac5ab07e4c67ba7e9a24818]
stable/5.15: [1d1847812a1a5375c10a2a779338df643f79c047]
stable/5.4: [14496175b264d30c2045584ee31d062af2e3a660]
stable/6.1: [918649364fbca7d5df72522ca795479edcd25f91]
stable/6.12: [b57f2d7d3e6bb89ed82330c5fe106cdfa34d3e24]
stable/6.6: [a70dcfa8d0a0cc530a6af59483dfca260b652c1b]

CVE-2025-40045: ASoC: codecs: wcd937x: set the comp soundwire port correctly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40045

Introduced by commit 82be8c6 ("ASoC: codecs: wcd937x: add basic
controls") in v6.11-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66a940b1bf48a7095162688332d725ba160154eb]
stable/6.12: [abcd537aae3b84c6d10ad147e99a204bcb56b234]

CVE-2025-40046: io_uring/zcrx: fix overshooting recv limit

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40046

Introduced by commit 6699ec9 ("io_uring/zcrx: add a read limit to
recvzc requests") in v6.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [09cfd3c52ea76f43b3cb15e570aeddf633d65e80]

CVE-2025-40047: io_uring/waitid: always prune wait queue entry in
io_waitid_wait()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40047

Introduced by commit f31ecf6 ("io_uring: add IORING_OP_WAITID
support") in v6.7-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2f8229d53d984c6a05b71ac9e9583d4354e3b91f]
stable/6.12: [696ba6032081e617564a8113a001b8d7943cb928]

CVE-2025-40048: uio_hv_generic: Let userspace take care of interrupt mask

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40048

Introduced by commit 95096f2 ("uio-hv-generic: new userspace i/o
driver for VMBus") in v4.10-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b15b7d2a1b09ef5428a8db260251897405a19496]
stable/5.10: [65d40acd911c7011745cbbd2aaac34eb5266d11e]
stable/5.15: [a44f61f878f32071d6378e8dd7c2d47f9490c8f7]
stable/5.4: [540aac117eaea5723cef5e4cbf3035c4ac654d92]
stable/6.1: [01ce972e6f9974a7c76943bcb7e93746917db83a]
stable/6.12: [37bd91f22794dc05436130d6983302cb90ecfe7e]
stable/6.6: [2af39ab5e6dc46b835a52e80a22d0cad430985e3]

CVE-2025-40049: Squashfs: fix uninit-value in squashfs_get_parent

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40049

Introduced by commit 1226014 ("Squashfs: export operations") in v2.6.29-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [74058c0a9fc8b2b4d5f4a0ef7ee2cfa66a9e49cf]
stable/5.10: [382a47fae449e554ef1e8c198667fd2f3270b945]
stable/5.15: [61d38b5ce2782bff3cacaacbb8164087a73ed1a5]
stable/5.4: [f81a5bc9e924ee1950e0dd82bd10749048390f6e]
stable/6.1: [81a2bca52d43fc9d9abf07408b91255131c5dc53]
stable/6.12: [1b3ccd0019132880c94bb00ca7088c1749308f82]
stable/6.6: [c28b0ca029edf5d0558abcd76cb8c732706cd339]

CVE-2025-40050: bpf: Skip scalar adjustment for BPF_NEG if dst is a pointer

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40050

Introduced by commit aced132 ("bpf: Add range tracking for BPF_NEG")
in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [34904582b502a86fdb4d7984b12cacd2faabbe0d]

CVE-2025-40051: vhost: vringh: Modify the return value check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40051

Introduced by commit 309bba3 ("vringh: iterate on iotlb_translate to
handle large translations") in v6.0-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [82a8d0fda55b35361ee7f35b54fa2b66d7847d2b]
stable/6.1: [db042925a5ab7a550b710addeadbf6f72e3a8a4b]
stable/6.12: [baa37b1c7e29546f79c39bef0d18c4edc9f39bb1]
stable/6.6: [78dc7362662fedaa1928fb8e4f27401c8322905d]

CVE-2025-40052: smb: client: fix crypto buffers in non-linear memory

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40052

Introduced by commit d08089f ("cifs: Change the I/O paths to use an
iterator rather than a page list") in v6.3-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [998a67b954680f26f3734040aeeed08642d49721]
stable/6.12: [7a8a8c15468f0c99685e9964451feffd1a3cc859]
stable/6.6: [ba905a567105dde21cdb8e6d3a87110fa434b393]

CVE-2025-40053: net: dlink: handle copy_thresh allocation failure

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40053

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8169a6011c5fecc6cb1c3654c541c567d3318de8]
stable/5.10: [84fd710a704f3d53d4120e452e86cea558cf73a8]
stable/5.15: [5aa9b885602811a026a3f45c92ea2b4b04c54f09]
stable/6.1: [9d49e4b14609e1a20d931e718962c4b6b5485174]
stable/6.12: [7ed5010fef0930f4322d620052edc854ef3ec41f]
stable/6.6: [ea87151df398d407a632c7bf63013290f01c5009]

CVE-2025-40054: f2fs: fix UAF issue in f2fs_merge_page_bio()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40054

Introduced by commit 0b20fce ("f2fs: cache global IPU bio") in v5.5-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [edf7e9040fc52c922db947f9c6c36f07377c52ea]

CVE-2025-40055: ocfs2: fix double free in user_cluster_connect()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40055

Introduced by commit c994c2e ("ocfs2: use the new DLM operation
callbacks while requesting new lockspace") in v3.14-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8f45f089337d924db24397f55697cda0e6960516]
stable/5.10: [f992bc72f681c32a682d474a29c2135a64d4f4e5]
stable/5.15: [827c8efa0d1afe817b90f3618afff552e88348d2]
stable/5.4: [283333079d96c84baa91f0c62b5e0cbec246b7a2]
stable/6.1: [bfe011297ddd2d0cd64752978baaa0c04cd20573]
stable/6.12: [694d5b401036a614f8080085a9de6f86ff0742dc]
stable/6.6: [7e76fe9dfadbc00364d7523d5a109e9d3e4a7db2]

CVE-2025-40056: vhost: vringh: Fix copy_to_iter return value check

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40056

Introduced by commit 309bba3 ("vringh: iterate on iotlb_translate to
handle large translations") in v6.0-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [439263376c2c4e126cac0d07e4987568de4eaba5]
stable/6.1: [bd71e7e0a612740e4de5524880c7cd40293af5f7]
stable/6.12: [b3a950d236e98440c07405ba597b11bce56a8050]
stable/6.6: [781226e11d5bdea0d69c7b5aa3cda874093c73b8]

CVE-2025-40057: ptp: Add a upper bound on max_vclocks

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40057

Introduced by commit 73f3706 ("ptp: support ptp physical/virtual
clocks conversion") in v5.14-rc2.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e9f35294e18da82162004a2f35976e7031aaf7f9]
stable/6.12: [8dd446056336faa2283d62cefc2f576536845edc]

CVE-2025-40058: iommu/vt-d: Disallow dirty tracking if incoherent page walk

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40058

Introduced by commit f35f22c ("iommu/vt-d: Access/Dirty bit support
for SS domains") in v6.7-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [57f55048e564dedd8a4546d018e29d6bbfff0a7e]
stable/6.12: [ebe16d245a00626bb87163862a1b07daf5475a3e]

CVE-2025-40059: coresight: Fix incorrect handling for return value of
devm_kzalloc

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40059

Introduced by commit 4277f03 ("coresight: trbe: Add a representative
coresight_platform_data for TRBE") in v6.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [70714eb7243eaf333d23501d4c7bdd9daf011c01]
stable/6.12: [8c4e7e646d5d9050b374baf5c6bb3a00fb79e206]

CVE-2025-40060: coresight: trbe: Return NULL pointer for allocation failures

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40060

Introduced by commit 3fbf7f0 ("coresight: sink: Add TRBE driver") in v5.13-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a55c161f7f9c1aa1c70611b39830d51c83ef36d]
stable/5.15: [cef047e0a55cb07906fcaae99170f19a9c0bb6c2]
stable/6.1: [fe53a726d5edf864e80b490780cc135fc1adece9]
stable/6.12: [296da78494633e1ab5e2e74173a9c8683b04aa6b]
stable/6.6: [9768536f82600a05ce901e31ccfabd92c027ff71]

CVE-2025-40061: RDMA/rxe: Fix race in do_task() when draining

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40061

Introduced by commit 9b4b7c1 ("RDMA/rxe: Add workqueue support for rxe
tasks") in v6.5-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8ca7eada62fcfabf6ec1dc7468941e791c1d8729]
stable/6.12: [52edccfb555142678c836c285bf5b4ec760bd043]
stable/6.6: [85288bcf7ffe11e7b036edf91937bc62fd384076]

CVE-2025-40062: crypto: hisilicon/qm - set NULL to qm->debug.qm_diff_regs

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40062

Introduced by commit 8be0913 ("crypto: hisilicon/debugfs - Fix debugfs
uninit process issue") in v6.10-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [f0cafb02de883b3b413d34eb079c9680782a9cc1]
stable/6.1: [a7836260d5121949ba734e840d42a86ab4a32fcc]
stable/6.12: [a87a21a56244b8f4eb357f6bad879247005bbe38]
stable/6.6: [1750f1ec143ebabdbdfa013668665c9d5042c430]

CVE-2025-40063: crypto: comp - Use same definition of context alloc and free ops

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40063

Introduced by commit 42d9f6c ("crypto: acomp - Move scomp stream
allocation code into acomp") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f75f66683ded09f7135aef2e763c245a07c8271a]

CVE-2025-40064: smc: Fix use-after-free in __pnet_find_base_ndev().

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40064

Introduced by commit 0afff91 ("net/smc: add pnetid support") in v4.19-rc1.
Introduced by commit 1619f77 ("net/smc: add pnetid support for SMC-D
and ISM") in v4.19-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3d3466878afd8d43ec0ca2facfbc7f03e40d0f79]

CVE-2025-40065: RISC-V: KVM: Write hgatp register with valid mode bits

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40065

Introduced by commit fd7bb4a ("RISC-V: KVM: Implement VMID allocator")
in v5.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b351e3d04be9e1533f26c3464f1e44a5beace30]

CVE-2025-40066: wifi: mt76: mt7996: Check phy before init msta_link in
mt7996_mac_sta_add_links()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40066

Introduced by commit dd82a9e ("wifi: mt76: mt7996: Rely on
mt7996_sta_link in sta_add/sta_remove callbacks") in v6.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fe5fffadc6c77c56f122cf1042dc830f59e904bf]

CVE-2025-40067: fs/ntfs3: reject index allocation if $BITMAP is empty
but blocks exist

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40067

Introduced by commit d99208b ("fs/ntfs3: cancle set bad inode after
removing name fails") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [0dc7117da8f92dd5fe077d712a756eccbe377d40]
stable/6.12: [be66551da203862c689c12e1d35ce87217c017c1]
stable/6.6: [978aac54e93ea35aab20b32ae393d3d33964e7ae]

CVE-2025-40068: fs: ntfs3: Fix integer overflow in run_unpack()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40068

Introduced by commit 4342306 ("fs/ntfs3: Add file operations and
implementation") in v5.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [736fc7bf5f68f6b74a0925b7e072c571838657d2]
stable/5.15: [f6b36cfd25cbadad63447c673743cf771090e756]
stable/6.1: [3ac37e100385b59ac821a62118494442238aaac4]
stable/6.12: [9378cfe228c2c679564a4116bcb28c8e89dff989]
stable/6.6: [a86c8b9d03f7101e1750233846fe989df6f0d631]

CVE-2025-40069: drm/msm: Fix obj leak in VM_BIND error path

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40069

Introduced by commit 2e6a8a1 ("drm/msm: Add VM_BIND ioctl") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [278f8904434aa96055e793936b5977c010549e28]

CVE-2025-40070: pps: fix warning in pps_register_cdev when register device fail

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40070

Introduced by commit c79a39d ("pps: Fix a use-after-free") in v6.14-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/5.10 cip/5.10-rt cip/6.1
cip/6.1-rt cip/6.12 stable/5.10 stable/5.15 stable/5.4 stable/6.1
stable/6.12 stable/6.6

Fixed status
mainline: [b0531cdba5029f897da5156815e3bdafe1e9b88d]
stable/5.10: [2a194707ca27a3b0523023fa8b446e5ec922dc51]
stable/5.15: [125527db41805693208ee1aacd7f3ffe6a3a489c]
stable/5.4: [38c7bb10aae5118dd48fa7a82f7bf93839bcc320]
stable/6.1: [4cbd7450a22c5ee4842fc4175ad06c0c82ea53a8]
stable/6.12: [f01fa3588e0b3cb1540f56d2c6bd99e5b3810234]
stable/6.6: [cf71834a0cfc394c72d62fd6dbb470ee13cf8f5e]

CVE-2025-40071: tty: n_gsm: Don't block input queue by waiting MSC

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40071

Introduced by commit 4847380 ("tty: n_gsm: fix missing update of modem
controls after DLCI open") in v5.18-rc5.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [3cf0b3c243e56bc43be560617416c1d9f301f44c]
stable/6.12: [5416e89b81b00443cb03c88df8da097ae091a141]
stable/6.6: [c36785f9de03df56ff9b8eca30fa681a12b2310d]

CVE-2025-40072: fanotify: Validate the return value of
mnt_ns_from_dentry() before dereferencing

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40072

Introduced by commit 58f5fbe ("fanotify: support watching filesystems
and mounts inside userns") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [62e59ffe8787b5550ccff70c30b6f6be6a3ac3dd]

CVE-2025-40073: drm/msm: Do not validate SSPP when it is not ready

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40073

Introduced by commit 3ed12a3 ("drm/msm/dpu: allow sharing SSPP between
planes") in v6.16-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fc616723bb5fd4289d7422fa013da062b44ae55]

CVE-2025-40074: ipv4: start using dst_dev_rcu()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40074

Introduced by commit 4a6ce2b ("net: introduce a new function
dst_dev_put()") in v4.13-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6ad8de3cefdb6ffa6708b21c567df0dbf82c43a8]

CVE-2025-40075: tcp_metrics: use dst_dev_net_rcu()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40075

Introduced by commit 4a6ce2b ("net: introduce a new function
dst_dev_put()") in v4.13-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [50c127a69cd6285300931853b352a1918cfa180f]

CVE-2025-40076: PCI: rcar-host: Pass proper IRQ domain to
generic_handle_domain_irq()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40076

Introduced by commit dd26c1a ("PCI: rcar-host: Switch to
msi_create_parent_irq_domain()") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d3fee10e40a938331e2aae34348691136db31304]

CVE-2025-40077: f2fs: fix to avoid overflow while left shift operation

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40077

Introduced by commit 3265d3d ("f2fs: support partial truncation on
compressed inode") in v5.8-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0fe1c6bec54ea68ed8c987b3890f2296364e77bb]

CVE-2025-40078: bpf: Explicitly check accesses to bpf_sock_addr

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40078

Introduced by commit 1cedee1 ("bpf: Hooks for sys_sendmsg") in v4.18-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6fabca2fc94d33cdf7ec102058983b086293395f]
stable/5.10: [76e04bbb4296fb6eac084dbfc27e02ccc744db3e]
stable/5.15: [6d8b1a21fd5c34622b0c3893c61e4a38d8ba53ec]
stable/5.4: [de44cdc50d2dce8718cb57deddf9cf1be9a7759f]
stable/6.1: [4f00858cd9bbbdf67159e28b85a8ca9e77c83622]
stable/6.12: [fe9d33f0470350558cb08cecb54cf2267b3a45d2]
stable/6.6: [cdeafacb4f9ff261a96baef519e29480fd7b1019]

CVE-2025-40079: riscv, bpf: Sign extend struct ops return values properly

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40079

Introduced by commit 25ad106 ("riscv, bpf: Adapt bpf trampoline to
optimized riscv ftrace framework") in v6.6-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fd2e08128944a7679e753f920e9eda72057e427c]
stable/6.12: [92751937f12a7d34ad492577a251c94a55e97e72]

CVE-2025-40080: nbd: restrict sockets to TCP and UDP

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40080

Introduced by commit cf1b232 ("nbd: verify socket is supported during
setup") in v5.4-rc5.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [9f7c02e031570e8291a63162c6c046dc15ff85b0]
stable/6.1: [c365e8f20f4201d873a70385bd919f0fb531e960]
stable/6.12: [37ad11f20e164c23ce827dd455b42c0fdd29685c]
stable/6.6: [4f9e6ff6319dbcebea64b50af0304cf0ad7e97e7]

CVE-2025-40081: perf: arm_spe: Prevent overflow in PERF_IDX2OFF()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40081

Introduced by commit d5d9696 ("drivers/perf: Add support for ARMv8.2
Statistical Profiling Extension") in v4.15-rc1.
Fixed in v6.18-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a29fea30dd93da16652930162b177941abd8c75e]
stable/5.10: [9c045d4501f7f70724a3bbb561f4f22d292bbfe6]
stable/5.15: [5d01f2b81568289443d22f1e13a363f829de6343]
stable/5.4: [656e9a5d69acdd1b20462f4a33378b90ddcb9626]
stable/6.1: [7500384d3c9587593d75ded3b006835e7aa73ef8]
stable/6.12: [1a19ba8e1f4ff24ece8ca69b79df8442c431db90]
stable/6.6: [379cae2cb982f571cda9493ac573ab71125fd299]

CVE-2025-40082: hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40082

Introduced by commit 9445878 ("hfsplus: fix slab-out-of-bounds read in
hfsplus_uni2asc()") in v6.17-rc1.
Fixed in v6.18-rc1.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-st cip/5.10
cip/5.10-rt cip/6.1 cip/6.1-rt cip/6.12 stable/5.10 stable/5.15
stable/5.4 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [bea3e1d4467bcf292c8e54f080353d556d355e26]

CVE-2023-7324: scsi: ses: Fix possible addl_desc_ptr out-of-bounds accesses

Announce: https://www.cve.org/CVERecord?id=CVE-2023-7324

Introduced commit is not determined.Fixed in v6.3-rc1.


Fixed status
cip/4.19-st: [a156a262c543fa5ff30bcb2fc6ad1a95cb4ab57a]
cip/4.4-st: [96f40948d621213506e0d113ba8ebe47ef88c503]
mainline: [db95d4df71cb55506425b6e4a5f8d68e3a765b63]
stable/5.10: [2ecd344173a5663d523433819da0484cb268b186]
stable/5.15: [384aa697d8f2a28b5e962f5292cdfd2e528b5df7]
stable/5.4: [8e454aba72805241239caf8ba9b8e5a6be772b96]
stable/6.1: [27067c672980b497cc34048b69b12820851ac6b9]

CVE-2025-40083: net/sched: sch_qfq: Fix null-deref in agg_dequeue

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40083

Introduced commit is not determined.Fixed in v6.16-rc6.


Fixed status
mainline: [dd831ac8221e691e9e918585b1003c7071df0379]

CVE-2025-40084: ksmbd: transport_ipc: validate payload size before
reading handle

Announce: no reference


According to the commit log, this bug was introduced by commit 0626e66
("cifsd: add server handler for central processing and tranport
layers") in 5.15-rc1."
Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6f40e50ceb99fc8ef37e5c56e2ec1d162733fef0]
stable/6.1: [a02e432d5130da4c723aabe1205bac805889fdb2]
stable/6.12: [898d527ed94c19980a4d848f10057f1fed578ffb]
stable/6.6: [2dc125f5da134c0915a840b62565c60a595673dd]

CVE-2025-40085: ALSA: usb-audio: Fix NULL pointer deference in
try_to_register_card

Announce: https://www.cve.org/CVERecord?id=CVE-2025-40085

Introduced by commit 39efc9c ("ALSA: usb-audio: Fix last interface
check for registration") in v6.1-rc1.
Fixed in v6.18-rc2.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [28412b489b088fb88dff488305fd4e56bd47f6e4]
stable/5.15: [736159f7b296d7a95f7208eb4799639b1f8b16a0]
stable/6.1: [8d19a7ab28c7b9c207db5c5282afa8cc8595bcdb]
stable/6.12: [bba7208765d26e5e36b87f21dacc2780b064f41f]
stable/6.6: [576312eb436326b44b7010f4d9ae2b698df075ea]


* Updated CVEs

CVE-2025-38073: block: fix race between set_blocksize and read paths

stable/6.6 was fixed.

Fixed status
stable/6.6: [a0caf1de97e1edd7f3451f1818ea6cb970495fc5]

CVE-2022-48635: fsdax: Fix infinite loop in dax_iomap_rw()

stable/5.10 was fixed.

Fixed status
stable/5.10: [463f36137c40342fb03bba380c1bf703c40d89a6]

CVE-2023-53498: drm/amd/display: Fix potential null dereference

stable/5.10 was fixed.

Fixed status
stable/5.10: [624a60911b71af08a912ee8a296b271b3e7b34ab]

CVE-2024-36890: mm/slab: make __free(kfree) accept error pointers

stable/5.10 was fixed.

Fixed status
stable/5.10: [edca32f87329d6e341d2143a3b58ec254e8f6b88]

CVE-2024-43876: PCI: rcar: Demote WARN() to dev_warn_ratelimited() in
rcar_pcie_wakeup()

stable/5.15 was fixed.

Fixed status
stable/5.15: [59c78e8fddc1fe68f14011450a09b3418127d2ad]

CVE-2024-43877: media: pci: ivtv: Add check for DMA map result

stable/5.10 was fixed.

Fixed status
stable/5.10: [38f72c7e7c6b55614f9407555fd5ce9d019b0fa4]

CVE-2024-50143: udf: fix uninit-value use in udf_get_fileshortad

stable/5.10 was fixed.

Fixed status
stable/5.10: [0ce61b1f6b32df822b59c680cbe8e5ba5d335742]

CVE-2025-22058: udp: Fix memory accounting leak.

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [d9c8266ce536e8314d84370e983afcaa36fb19cf]
stable/5.4: [13550273171f5108b1ac572d8f72f4256ab92854]

CVE-2025-39678: platform/x86/amd/hsmp: Ensure sock->metric_tbl_addr is non-NULL

stable/6.12 was fixed.

Fixed status
stable/6.12: [782977c0d8ba432b6fd3d5d0d87016a523ec1c69]

CVE-2025-39993: media: rc: fix races with imon_disconnect()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [b03fac6e2a38331faf8510b480becfa90cea1c9f]
stable/5.4: [9348976003e39754af344949579e824a0a210fc4]

CVE-2025-39994: media: tuner: xc5000: Fix use-after-free in xc5000_release

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [e2f5eaafc0306a76fb1cb760aae804b065b8a341]
stable/5.4: [bc4ffd962ce16a154c44c68853b9d93f5b6fc4b8]

CVE-2025-39995: media: i2c: tc358743: Fix use-after-free bugs caused
by orphan timer in probe

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [70913586c717dd25cfbade7a418e92cc9c99398a]
stable/5.4: [9205fb6e617a1c596d9a9ad2a160ee696e09d520]

CVE-2025-39996: media: b2c2: Fix use-after-free causing by
irq_check_work in flexcop_pci_remove

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [bde8173def374230226e8554efb51b271f4066ec]
stable/5.4: [607010d07b8a509b01ed15ea12744acac6536a98]

CVE-2025-39998: scsi: target: target_core_configfs: Add length check
to avoid buffer overflow

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [764a91e2fc9639e07aac93bc70e387e6b1e33084]
stable/5.4: [e6eeee5dc0d9221ff96d1b229b1d0222c8871b84]

CVE-2025-40001: scsi: mvsas: Fix use-after-free bugs in mvs_work_queue

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [aacd1777d4a795c387a20b9ca776e2c1225d05d7]
stable/5.4: [a6f68f219d4d4b92d7c781708d4afc4cc42961ec]

CVE-2025-40018: ipvs: Defer ip_vs_ftp unregister during netns cleanup

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [421b1ae1574dfdda68b835c15ac4921ec0030182]
stable/5.4: [8a6ecab3847c213ce2855b0378e63ce839085de3]

CVE-2025-40019: crypto: essiv - Check ssize for decryption and
in-place encryption

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [71f03f8f72d9c70ffba76980e78b38c180e61589]
stable/5.4: [29294dd6f1e7acf527255fb136ffde6602c3a129]

CVE-2025-40026: KVM: x86: Don't (re)check L1 intercepts when
completing userspace I/O

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [00338255bb1f422642fb2798ebe92e93b6e4209b]
stable/5.4: [a908eca437789589dd4624da428614c1275064dc]

CVE-2025-40027: net/9p: fix double req put in p9_fd_cancelled

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [5c64c0b7b3446f7ed088a13bc8d7487d66534cbb]
stable/5.4: [a5901a0dfb5964525990106706ae8b98db098226]

CVE-2025-40029: bus: fsl-mc: Check return value of platform_get_resource()

stable/5.10 was fixed.

Fixed status
stable/5.10: [58dd05070b57a20f22ff35a34ef9846bdf49a1d0]

CVE-2025-40030: pinctrl: check the return value of
pinmux_ops::get_function_name()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [e7265dc4c670b89611bcf5fe33acf99bc0aa294f]
stable/5.4: [1a7fc8fed2bb2e113604fde7a45432ace2056b97]

CVE-2025-40035: Input: uinput - zero-initialize
uinput_ff_upload_compat to avoid info leak

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [877172b97786ed1678640dff0b2d35abb328844c]
stable/5.4: [1b317796013f666ae5040edbf0f230ec61496d42]

CVE-2025-40040: mm/ksm: fix flag-dropping behavior in ksm_madvise

stable/6.1 was fixed.

Fixed status
stable/6.1: [41cb9fd904fe0c39d52e82dd84dc3c96b7aa9693]

CVE-2025-40042: tracing: Fix race condition in kprobe initialization
causing NULL pointer dereference

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [9c4951b691bb8d7a004acd010f45144391f85ea6]
stable/5.4: [07926ce598a95de6fd874a74fb510e2ebdfd0aae]

CVE-2025-40044: fs: udf: fix OOB read in lengthAllocDescs handling

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [d2ed9aa8ae50fb0d4ac5ab07e4c67ba7e9a24818]
stable/5.4: [14496175b264d30c2045584ee31d062af2e3a660]

CVE-2025-40048: uio_hv_generic: Let userspace take care of interrupt mask

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [65d40acd911c7011745cbbd2aaac34eb5266d11e]
stable/5.4: [540aac117eaea5723cef5e4cbf3035c4ac654d92]

CVE-2025-40049: Squashfs: fix uninit-value in squashfs_get_parent

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [382a47fae449e554ef1e8c198667fd2f3270b945]
stable/5.4: [f81a5bc9e924ee1950e0dd82bd10749048390f6e]

CVE-2025-40053: net: dlink: handle copy_thresh allocation failure

stable/5.10 was fixed.

Fixed status
stable/5.10: [84fd710a704f3d53d4120e452e86cea558cf73a8]

CVE-2025-40055: ocfs2: fix double free in user_cluster_connect()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [f992bc72f681c32a682d474a29c2135a64d4f4e5]
stable/5.4: [283333079d96c84baa91f0c62b5e0cbec246b7a2]

CVE-2025-40070: pps: fix warning in pps_register_cdev when register device fail

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [2a194707ca27a3b0523023fa8b446e5ec922dc51]
stable/5.4: [38c7bb10aae5118dd48fa7a82f7bf93839bcc320]

CVE-2025-40078: bpf: Explicitly check accesses to bpf_sock_addr

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [76e04bbb4296fb6eac084dbfc27e02ccc744db3e]
stable/5.4: [de44cdc50d2dce8718cb57deddf9cf1be9a7759f]

CVE-2025-40081: perf: arm_spe: Prevent overflow in PERF_IDX2OFF()

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [9c045d4501f7f70724a3bbb561f4f22d292bbfe6]
stable/5.4: [656e9a5d69acdd1b20462f4a33378b90ddcb9626]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

