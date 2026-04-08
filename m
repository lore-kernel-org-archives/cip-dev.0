Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BE610FC45F
	for <webhook@archiver.kernel.org>; Wed,  8 Apr 2026 22:37:27 +0000 (UTC)
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.118744.1775687836668697329
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Apr 2026 15:37:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=fELvz4xI;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.43, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-650789b22e3so306564d50.1
        for <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 15:37:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775687836; cv=none;
        d=google.com; s=arc-20240605;
        b=IzPjbjLzJ9YqX5perGnUCuya0BvBCCY+7KoFtT3ro+K5Vg1bj2WWg5IGhNlywaGz8O
         gp9Fz3YoFzkRHJJpYu0qTByxSR8YkAztxvSbXJSnw6ooCBLmUNLWr4/pqAidSXSM35YG
         D/XwE4SgcGQItlgOX0cijw8XRtL4skbgOkCJ5/eTNOh2Em7t83NLjZtf0Ue4CM3mNEkG
         kjKRuZjhstqA/Xx4birBZ8zKZM6Vf0e2iFjSXPwmGbqRCOcSPSyVU7477A1eCaNepMaE
         ltRdvTyQO7tyK88gB8eNWsFKoue4zacEPUlEzVOxtZvaxjfzxJio/YOAkGhnKMOiuQ63
         jvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=YyWje6Ia8bgTTOmENjX6oWcq8yafGTCV8RIxS1PJiPU=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=lH7uDqx9A7FhGyY/2N7HgvaGltqSlf+bAopO8OT1POQpdORyG4nEIju5AbM7DvQ9mN
         jL6gGdncJkiOT0B896MNaG5Ij4KNWnmk9yXFp3AQS6YHks8OzMbo6jUT+L9QqP99a1Ap
         D47/YetycCT9zFuDd6HnuhzYVMde1vC/6K06bwvSsYzo24nNolI5kbo8TP9B3Ux0b/LN
         YW49nppvC+bBOmYueplhZKcdIe+J0Gdi48cMdoAiXRjO5qF1/wU1SOYYvFGs+kgNMIiq
         AVmz0gFAegr/RUR9NIT+NLF4GgqJgGWWK0tEset0hNlZ7jzCcZpUOXPUPcH0Yw/A8/Fh
         MTPA==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1775687836; x=1776292636; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YyWje6Ia8bgTTOmENjX6oWcq8yafGTCV8RIxS1PJiPU=;
        b=fELvz4xIV7EAe/h2um9Kcwy35RhhmOKI+FnwEjvrrIWnpk2lqJDmEXNCrVvgnrz0A5
         sZh6dHKqNUxuyqARrM+oVUlgOo9VbNGZE0zs+GdP4/q+Cp/2Lh70KhPdFExwcI9p9FNx
         zK1o0JTRagD1jp3PMQVk2I+Kgk4USy5ITc7DAnThRV7ZZcHwwfMvvXYwhsUxlx915N3H
         Hs7F7WB2bhIWm9r8PGH9B95AF08ljXhPuAVwj5e1I+HT0EBWJrB2XKBp3dDuGQrzSdkD
         rb1Xh+0/0fPia+8QBDzxXkdgVesB21rFFFf3NE3pvr2YeVx2QFmieYEGcCAnMQxfoqJh
         NzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775687836; x=1776292636;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YyWje6Ia8bgTTOmENjX6oWcq8yafGTCV8RIxS1PJiPU=;
        b=IiZ4uZGXxWef1lQLG9pf9g/QVnkk7jd8k+c+KnJBy4Md3hBg85yMCAOewFU1343/Kx
         Y1iAg4AvAM517M/fSgUBImivLtwf41BDicVmMDCtXMPT55fHqhEkK2wBL2QfnTLu/aoz
         c/laO9CqcTtBtdGm1NDVXhFWo5jizybwZFtIIFnq5rWoQ8ALDDS0oWCOjUiOR4ZOWQ5M
         Uerx6ryJ6JnEDTSPF+c4/+/IHovp7qF01EMpAaxOgHIltbZkqIiFBlGFpR2yM3XI0ZsV
         5RnFR1j3xdeeqgNh/T3L3HH20JEwBf52q57ryNfBC/Rzdn1cD81Fxy5cVy6Cpmh2ZVpT
         QCbg==
X-Gm-Message-State: AOJu0YyJ42A3vJtjytGQiq3WbPjmxxkqZOhpnrUrCMDMD/waZYnFZYlU
	MyCl6LUl6RKXLsKrfmCVmFB2QqOc8D9LReXx8khb1O5KazGMcqcFtUbSOO/soKKewqLqwF6t1go
	PzHH6nNodloALszBYW3BQW+8VDkzUBPXQjSgJDLjeb8LRtxy748e9Iod01Q==
X-Gm-Gg: AeBDietxmC1FAk5BctatLvCUAeJomucjkRGEG75S89R9jzZvukXbntzi1R48xulVv16
	GNVCsgGRybD5IIwoUiIllx/3kejWQpEsuG3oULoQi/lXBqIr4L2TNaM8Tt6eUuWSuhiq5FhXo4y
	kD2oQ3y8WfRYGm6s8lCJAfOgZNL5Kp5EtmGPAtSbCKoXk9buwr9KfiamHnz7iYVFJzGn0NWLnLL
	kgQbd+a4zTR7YQaEGI02bTWoZMaJvAIwVtGSUWOKETzwXWqnnjoREM+XRb1HpSkAdxFnuFfaik2
	u6wTd0h4
X-Received: by 2002:a53:ba8c:0:b0:650:776a:781a with SMTP id
 956f58d0204a3-6518783c442mr894950d50.67.1775687834525; Wed, 08 Apr 2026
 15:37:14 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Apr 2026 07:36:38 +0900
X-Gm-Features: AQROBzCS8SjnHVf2EuFSc3xaNblisSSwzydiomv0QZRvei-HC34IEGDNbvkyfoU
Message-ID: <CAODzB9pnZbdWYyBtyEENfmQ0UY7Z-0+uu0zyMMJqoynTR2mRig@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Apr 2026 22:37:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22655

Hi!

It's this week's CVE report.

This week reported 87 new CVEs and 16 updated CVEs.

* New CVEs
CVE-2026-23412: netfilter: bpf: defer hook memory release until rcu
readers are done

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23412

Introduced by commit 84601d6 ("bpf: add bpf_link support for
BPF_NETFILTER programs") in v6.4-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24f90fa3994b992d1a09003a3db2599330a5232a]
stable/6.12: [cb2bf5efdb02a2a59faf603604a1066e8266f349]
stable/6.18: [c25e0dec366ae99b7264324ce3c7cbaea34691f9]
stable/6.19: [54244d54a971c26a0cd0a9073460ff71f3c51b32]
stable/6.6: [d016c216bc75c45128160593a77b864a04dbe7c0]

CVE-2026-23413: clsact: Fix use-after-free in init/destroy rollback asymmetry

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23413

Introduced by commit 1cb6f0b ("bpf: Fix too early release of
tcx_entry") in v6.10.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [a0671125d4f55e1e98d9bde8a0b671941987e208]
stable/6.12: [37bef86e5428d59f70a4da82b80f9a8f252fecbe]
stable/6.18: [4c9af67f99aa3e51b522c54968ab3ac8272be41c]
stable/6.19: [0509b762bc5e8ea7b8391130730c6d8502fc6e69]
stable/6.6: [a73d95b57bf9faebdfed591bcb7ed9292062a84c]

CVE-2026-23414: tls: Purge async_hold in tls_decrypt_async_wait()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23414

Introduced by commit b8a6ff8 ("tls: wait for pending async decryptions
if tls_strp_msg_hold fails") in v6.18-rc2.
Fixed in v7.0-rc6.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/6.1 stable/6.12 stable/6.6

Fixed status
mainline: [84a8335d8300576f1b377ae24abca1d9f197807f]
stable/6.12: [6dc11e0bd0a5466bcc76d275c09e5537bd0597dd]
stable/6.18: [9f557c7eae127b44d2e863917dc986a4b6cb1269]
stable/6.19: [fd8037e1f18ca5336934d0e0e7e1a4fe097e749d]
stable/6.6: [2dcf324855c34e7f934ce978aa19b645a8f3ee71]

CVE-2026-23415: futex: Fix UaF between futex_key_to_node_opt() and
vma_replace_policy()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23415

Introduced by commit c042c50 ("futex: Implement FUTEX2_MPOL") in v6.16-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [190a8c48ff623c3d67cb295b4536a660db2012aa]
stable/6.18: [853f70c67d1b37e368fdcb3e328c4b8c04f53ac0]
stable/6.19: [7e196194ea27bd49adf3551e2aceb83498eb73fe]

CVE-2026-23416: mm/mseal: update VMA end correctly on merge

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23416

Introduced by commit 6c2da14 ("mm/mseal: rework mseal apply logic") in
v6.17-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2697dd8ae721db4f6a53d4f4cbd438212a80f8dc]
stable/6.18: [40b3f4700e5535fbe74738cebb9379a40ec66bed]
stable/6.19: [83737e34b83a23b2a9bcf586b058b2c2a54c7c6b]

CVE-2026-23417: bpf: Fix constant blinding for PROBE_MEM32 stores

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23417

Introduced by commit 6082b6c ("bpf: Recognize addr_space_cast
instruction in the verifier.") in v6.9-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2321a9596d2260310267622e0ad8fbfa6f95378f]
stable/6.12: [56af722756ed82fee2ae5d5b4d04743407506195]
stable/6.18: [ccbf29b28b5554f9d65b2fb53b994673ad58b3bf]
stable/6.19: [de641ea08f8fff6906e169d2576c2ac54e562fbb]

CVE-2026-23418: drm/xe/reg_sr: Fix leak on xa_store failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23418

Introduced by commit e5283bd ("drm/xe/reg_sr: Remove register pool")
in v6.14-rc1.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12

Fixed status
mainline: [3091723785def05ebfe6a50866f87a044ae314ba]
stable/6.12: [549b68ba830ff0c5bc848179ddf7ccce582842b4]
stable/6.18: [05e3f01974d09d1b746dedf4144f708b5033e76f]
stable/6.19: [4f461da14c7b226d1c4c179ae69956ccb8e134e2]

CVE-2026-23419: net/rds: Fix circular locking dependency in rds_tcp_tune

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23419

Introduced by commit 3a58f13 ("net: rds: acquire refcount on TCP
sockets") in v5.18-rc6.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6a877ececd6daa002a9a0002cd0fbca6592a9244]
stable/6.12: [8519e6883a942e510f33a0e634e27bcc3a844a40]
stable/6.18: [6ce948fa54599f369ff7fe8b793a6aae4b0762b2]
stable/6.19: [026bbaeeab9e04534ee58882b6447300629b42f6]
stable/6.6: [8babb271403378ba6836f6c8599c5313d0e2355d]

CVE-2026-23420: wifi: wlcore: Fix a locking bug

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23420

Introduced by commit 45aa7f0 ("wlcore: Use generic runtime pm calls
for wowlan elp configuration") in v4.19-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [72c6df8f284b3a49812ce2ac136727ace70acc7c]
stable/6.1: [7ab511003c5ae3bf5364d7699a2e3ab1db513680]
stable/6.12: [5feeea59ed142e15c3284d0b1a364c6786bf3487]
stable/6.18: [fcef983ad88832f3aa83491a174c345de57afbbd]
stable/6.19: [1a1c28a08d74716f3f8e3a21c86b30d0ff13521a]
stable/6.6: [aca4c9e4901b01b8b985993dc7df80bd1d1338bd]

CVE-2026-23421: drm/xe/configfs: Free ctx_restore_mid_bb in release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23421

Introduced by commit b30d5de ("drm/xe/configfs: Add mid context
restore bb") in v6.18-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e377182f0266f46f02d01838e6bde67b9dac0d66]
stable/6.18: [7f971dfd48983074adc7bbcea3ee95ce7aad47cb]
stable/6.19: [3557359ea3df32430ea7c30f7a708ca9a91d7e0e]

CVE-2026-23422: dpaa2-switch: Fix interrupt storm after receiving bad
if_id in IRQ handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23422

Introduced by commit 31a7a0b ("dpaa2-switch: add bounds check for
if_id in IRQ handler") in v6.19.
Fixed in v7.0-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt cip/6.12 stable/5.15 stable/6.1 stable/6.12
stable/6.18 stable/6.6

Fixed status
mainline: [74badb9c20b1a9c02a95c735c6d3cd6121679c93]
stable/6.1: [b5bababe7703a7322bc59b803ab1587887a2a5e4]
stable/6.12: [fa4412cdc5178a48799bafcb8af28fd2fbf3d703]
stable/6.18: [00f42ace446f1e4bf84988f2281131f52cd32796]
stable/6.19: [28fd8ac1d49389cb230d712116f54e27ebec11b8]
stable/6.6: [c7becfe3e604d138bd53b8ac3111b2b3e8ec6b0e]

CVE-2026-23423: btrfs: free pages on error in btrfs_uring_read_extent()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23423

Introduced by commit 34310c4 ("btrfs: add io_uring command for encoded
reads (ENCODED_READ ioctl)") in v6.13-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [3f501412f2079ca14bf68a18d80a2b7a823f1f64]
stable/6.18: [d4f210de01eaccac61eee657f676045ef9771d07]
stable/6.19: [628895890b0c9ac9129129e89455da7db95ba343]

CVE-2026-23424: accel/amdxdna: Validate command buffer payload count

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23424

Introduced by commit aac2430 ("accel/amdxdna: Add command execution")
in v6.14-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [901ec3470994006bc8dd02399e16b675566c3416]
stable/6.18: [3464e751755172ddbb849c1bd92f5f59e95c59a1]
stable/6.19: [3ed2ae6b3fe869f99b75afd02045ba5c0c0773e2]

CVE-2026-23425: KVM: arm64: Fix ID register initialization for
non-protected pKVM guests

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23425

Introduced by commit 41d6028 ("KVM: arm64: Convert the SVE guest vcpu
flag to a vm flag") in v6.14-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [7e7c2cf0024d89443a7af52e09e47b1fe634ab17]
stable/6.18: [bce3847f7c51b86332bf2e554c9e80ca3820f16c]
stable/6.19: [858620655c1fbff05997e162fc7d83a3293d5142]

CVE-2026-23426: drm/logicvc: Fix device node reference leak in
logicvc_drm_config_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23426

Introduced by commit efeeaef ("drm: Add support for the LogiCVC
display controller") in v6.0-rc1.
Fixed in v7.0-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fef0e649f8b42bdffe4a916dd46e1b1e9ad2f207]
stable/6.1: [b88f49910be147b7974098b9172b0d3873142d6a]
stable/6.12: [871630255ecd2d9b64ad1d75a7dfc0567d7d9989]
stable/6.18: [f8a6eba20edb938166b26e133cc61306e1bc6de9]
stable/6.19: [78e91e49d28e05ccaa6b445bafb5e367d57c9583]
stable/6.6: [0bd326dffd9e103335d77d9c31275c0d5a7979eb]

CVE-2026-23427: ksmbd: fix use-after-free in durable v2 replay of
active file handles

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23427

Introduced by commit c8efcc7 ("ksmbd: add support for durable handles
v1/v2") in v6.9-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
stable/6.6

Fixed status
mainline: [b425e4d0eb321a1116ddbf39636333181675d8f4]
stable/6.12: [568a25fd7bcdfb2790f7d42aa2a440dca4435c96]
stable/6.18: [a5828c14a9e3d5eeed0bcc0a58f0f3fbca0cdcb2]
stable/6.19: [9b0792c3eacf01e67f356d6ef9707b0ae5022419]
stable/6.6: [b0158d9d6f4ec5941e49a0b812735db2844f9975]

CVE-2026-23428: ksmbd: fix use-after-free of share_conf in compound request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23428

Introduced by commit 5005bcb ("ksmbd: validate session id and tree id
in the compound request") in v6.4.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/5.15 stable/6.1

Fixed status
mainline: [c33615f995aee80657b9fdfbc4ee7f49c2bd733d]
stable/6.1: [eae0dc86f71e6f3294c0cd7ffc05039258d243af]
stable/6.12: [c742b46a153d3ff95ff0825ab1950c87b9e14470]
stable/6.18: [7f7468fd2a7554cea91b7d430335a3dbf01dcc09]
stable/6.19: [a5929c2020ce54e1dcbd1078c0f30b8aaf73c105]
stable/6.6: [806f13752652216db0c309392b4db3e64eeed4f2]

CVE-2026-23429: iommu/sva: Fix crash in iommu_sva_unbind_device()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23429

Introduced by commit e37d5a2 ("iommu/sva: invalidate stale IOTLB
entries for kernel address space") in v6.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [06e14c36e20b48171df13d51b89fe67c594ed07a]
stable/6.18: [58abeb7b9562f25bdfa2f5ae5ce803eb02e74433]
stable/6.19: [f5daaa2c959d9f894fb5b1ab76da8612dd220a0d]

CVE-2026-23430: drm/vmwgfx: Don't overwrite KMS surface dirty tracker

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23430

Introduced by commit 9655441 ("drm/vmwgfx: Refactor cursor handling")
in v6.16-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [c6cb77c474a32265e21c4871c7992468bf5e7638]
stable/6.18: [3f300a41a3668095688aa4551214e8080829fa93]
stable/6.19: [354c8bbf8d1e4aa61e580dbe160591feda504e4f]

CVE-2026-23431: spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23431

Introduced by commit cef9991 ("spi: Add Amlogic SPISG driver") in v6.17-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b8db9552997924b750e727a625a30eaa4603bbb9]
stable/6.18: [bec21d97c968a4806939eb2946df49ea6c341bde]
stable/6.19: [8e28a01b69f7ea8df7ceb15470cfe643b2828f4f]

CVE-2026-23432: mshv: Fix use-after-free in mshv_map_user_memory error path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23432

Introduced by commit b9a66cd ("mshv: Add support for movable memory
regions") in v6.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6922db250422a0dfee34de322f86b7a73d713d33]
stable/6.19: [34861bdc0c0196b6c2dd48f7454029407704ff6e]

CVE-2026-23433: arm_mpam: Fix null pointer dereference when restoring
bandwidth counters

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23433

Introduced by commit 41e8a14 ("arm_mpam: Track bandwidth counter state
for power management") in v6.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [4ad79c874e53ebb7fe3b8ae7ac6c858a2121f415]
stable/6.19: [ac3e12bc195786d3d44d730b5b2259fd36191848]

CVE-2026-23434: mtd: rawnand: serialize lock/unlock against other NAND
operations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23434

Introduced by commit 9227008 ("mtd: rawnand: Add support for
manufacturer specific lock/unlock operation") in v5.7-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [bab2bc6e850a697a23b9e5f0e21bb8c187615e95]
stable/6.1: [ce5229e78078e437704157eb542f43a6f83b429b]
stable/6.12: [f71ce0ae5aefe39dd5b2f996c0e08550d2153ad2]
stable/6.18: [5fd5c078af23cb353507aa522e09d557d7eaef04]
stable/6.19: [f25446e2c28939753d3b62d34dfda49952b2557d]
stable/6.6: [a80291e577b44593a724d6cd64c14337c78f194d]

CVE-2026-23435: perf/x86: Move event pointer setup earlier in x86_pmu_enable()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23435

Introduced by commit 7e772a9 ("perf/x86: Fix NULL event access and
potential PEBS record loss") in v6.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
stable/6.18

Fixed status
mainline: [8d5fae6011260de209aaf231120e8146b14bc8e0]
stable/6.18: [886fa869153917d902784098922defa20c3a2fe5]
stable/6.19: [c1dd1e2b722d3f1f2e4977dad8d1be78fdfb30cb]

CVE-2026-23436: net: shaper: protect from late creation of hierarchy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23436

Introduced by commit 93954b4 ("net-shapers: implement NL set and
delete operations") in v6.13-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d75ec7e8ba1979a1eb0b9211d94d749cdce849c8]
stable/6.18: [719f6784f918f9e32f3ff3b197f900e852223f9d]
stable/6.19: [d22921727023e7852704965e935f4d1fc83a5ec9]

CVE-2026-23437: net: shaper: protect late read accesses to the hierarchy

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23437

Introduced by commit 4b623f9 ("net-shapers: implement NL get
operation") in v6.13-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0f9ea7141f365b4f27226898e62220fb98ef8dc6]
stable/6.18: [581eee0890a8bde44f1fb78ad3e70502a897d583]
stable/6.19: [348758ba74e6a348299965b16a97cfb817545cc0]

CVE-2026-23438: net: mvpp2: guard flow control update with
global_tx_fc in buffer switching

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23438

Introduced by commit 3a616b9 ("net: mvpp2: Add TX flow control support
for jumbo frames") in v5.12-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8a63baadf08453f66eb582fdb6dd234f72024723]
stable/6.1: [da089f74a993f846685067b14158cb41b879ff29]
stable/6.12: [7bd20f4b3ef3044dc55acd5b8ef748a70d29d03f]
stable/6.18: [7df2b50cae1a76cbb90b294f3edb61e3e10bf2e9]
stable/6.19: [8baced53a35fc9710f80d6ca016a2c418dc3231f]
stable/6.6: [ff0c54f088f7ab91dbbf47cf8244460f99122750]

CVE-2026-23439: udp_tunnel: fix NULL deref caused by udp_sock_create6
when CONFIG_IPV6=n

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23439

Introduced by commit fd38441 ("udp_tunnel: Seperate ipv6 functions
into its own file.") in v3.18-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [b3a6df291fecf5f8a308953b65ca72b7fc9e015d]
stable/6.1: [ba7c9ddcdd077942b798979edb035207374d4096]
stable/6.12: [9f036aa0fe46c19e938f03d10e02c23f4fffae5e]
stable/6.18: [003343985f26dfefd0c94b1fe1316a2de74428b9]
stable/6.19: [12aa4b73a67d95bc739995a2d6943aec2f9785c9]
stable/6.6: [a05a2149386f6dfb4245f522acdbef892acafc84]

CVE-2026-23440: net/mlx5e: Fix race condition during IPSec ESN update

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23440

Introduced by commit fef0667 ("net/mlx5e: Fix ESN update kernel panic") in v6.4.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [beb6e2e5976a128b0cccf10d158124422210c5ef]
stable/6.12: [2051c709dce92da3550040aa7949cd5a9c89b14e]
stable/6.18: [96c9c25b74686ac2de15921c9ad30c5ef13af8cd]
stable/6.19: [8d625c15471fb8780125eaef682983a96af77bdc]
stable/6.6: [3dffc083292e6872787bd7e34b957627622f9af4]

CVE-2026-23441: net/mlx5e: Prevent concurrent access to IPSec ASO context

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23441

Introduced by commit 1ed78fc ("net/mlx5e: Update IPsec soft and hard
limits") in v6.2-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [99b36850d881e2d65912b2520a1c80d0fcc9429a]
stable/6.12: [c3db55dc0f3344b62da25b025a8396d78763b5fa]
stable/6.18: [2c6a5be0aee5a44066f68a332c30650900e32ad4]
stable/6.19: [6834d196107d5267dcad31b44211da7698e8f618]
stable/6.6: [99aaee927800ea00b441b607737f9f67b1899755]

CVE-2026-23442: ipv6: add NULL checks for idev in SRv6 paths

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23442

Introduced by commit 1ababeb ("ipv6: implement dataplane support for
rthdr type 4 (Segment Routing Header)") in v4.10-rc1.
Introduced by commit bf355b8 ("ipv6: sr: add core files for SR HMAC
support") in v4.10-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [06413793526251870e20402c39930804f14d59c0]
stable/6.19: [a25853c9feea7bbf31d157ff6e004d2d3b4f7f13]

CVE-2026-23443: ACPI: processor: Fix previous acpi_processor_errata_piix4() fix

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23443

Introduced by commit f132e08 ("ACPI: processor: Fix NULL-pointer
dereference in acpi_processor_errata_piix4()") in v7.0-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.12 stable/5.15 stable/6.1 stable/6.12 stable/6.18
stable/6.19 stable/6.6

Fixed status
mainline: [bf504b229cb8d534eccbaeaa23eba34c05131e25]
stable/6.1: [2e369ba9eb7b8a06e9cc35a3e7fe73e59272f8c2]
stable/6.12: [e0c470049344e9346fff79d7e2362212c216665e]
stable/6.18: [98473309a36acc271009b85e0bb53a4c0dddf5c2]
stable/6.19: [8583f62259e1b315d5239371adfb36939cdab741]
stable/6.6: [edf4c2aaee08e8fd503fbae705c801e92a0b55d7]

CVE-2026-23444: wifi: mac80211: always free skb on
ieee80211_tx_prepare_skb() failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23444

Introduced by commit 06be6b1 ("mac80211: add
ieee80211_tx_prepare_skb() helper function") in v3.13-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d5ad6ab61cbd89afdb60881f6274f74328af3ee9]
stable/6.18: [06e769dddcbeb3baf2ce346273b53dd61fdbecf4]
stable/6.19: [50f1b690b4868923fbd242298def2fb88662f108]

CVE-2026-23445: igc: fix page fault in XDP TX timestamps handling

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23445

Introduced by commit 15fd021 ("igc: Add Tx hardware timestamp request
for AF_XDP zero-copy packet") in v6.10-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [45b33e805bd39f615d9353a7194b2da5281332df]
stable/6.12: [5e4c90c94eb766d70e30694b7fe66862aabaf24b]
stable/6.18: [31521c124e6488c4a81658e35199feb75a988d86]
stable/6.19: [b02fa17d1744d19cd3820bdbf6ec5d85547977bf]

CVE-2026-23446: net: usb: aqc111: Do not perform PM inside suspend callback

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23446

Introduced by commit e58ba45 ("net: usb: aqc111: Add support for wake
on LAN by MAGIC packet") in v5.0-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [069c8f5aebe4d5224cf62acc7d4b3486091c658a]
stable/6.1: [621f2f43741b51f62d767eb4752fbcefe2526926]
stable/6.12: [3267bcb744ee8a2feabaa7ab69473f086f67fd71]
stable/6.18: [d3e32a612c6391ca9b7c183aeec22b4fd24c300c]
stable/6.19: [98e8aed64614b0c199d5f0391fbe1a4331cb5773]
stable/6.6: [4de6a43e8ecf961feabddf0e9d6911081d2ed218]

CVE-2026-23447: net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23447

Introduced by commit 0fa81b3 ("cdc_ncm: Implement the 32-bit version
of NCM Transfer Block") in v5.7-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st

Fixed status
mainline: [77914255155e68a20aa41175edeecf8121dac391]
stable/6.12: [af0d1613d6751489dbf9f69aac1123f0b1e566e5]
stable/6.18: [a5bd5a2710310c965ea4153cba4210988a3454e2]
stable/6.19: [de70da1fb1d152e981ecb3157f7ec2b633005c16]
stable/6.6: [125f932a76a97904ef8a555f1dd53e5d0e288c54]

CVE-2026-23448: net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23448

Introduced by commit ff06ab1 ("net: cdc_ncm: splitting rx_fixup for
code reuse") in v3.8-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2aa8a4fa8d5b7d0e1ebcec100e1a4d80a1f4b21a]
stable/6.12: [789204f980730258c983102c027c375238009c80]
stable/6.18: [403f94ddcb36c552fbef51dea735b131e3dcde8b]
stable/6.19: [dce9dda0e3707e887977db44407989e9ead26611]
stable/6.6: [f1c7701d3ac91b62d672c13690cf295821f0d5c3]

CVE-2026-23449: net/sched: teql: Fix double-free in teql_master_xmit

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23449

Introduced by commit 96009c7 ("sched: replace __QDISC_STATE_RUNNING
bit with a spin lock") in v4.18-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [66360460cab63c248ca5b1070a01c0c29133b960]
stable/6.1: [4e8ebc4c18ea8213d28e6cb867d18fcc67daca21]
stable/6.12: [afbc79a7770b230a9f24bd39271209d6b3682c5f]
stable/6.18: [e9c66d3e7d8557b3308e55c613aa07254fe97611]
stable/6.19: [4a233447b941db451ea5f5a0942cffd0f7f7eaae]
stable/6.6: [21c89a0a8de7eadad8d385645a95b3233f23130e]

CVE-2026-23450: net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23450

Introduced by commit 8270d9c ("net/smc: Limit backlog connections") in
v5.18-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
stable/5.15

Fixed status
mainline: [6d5e4538364b9ceb1ac2941a4deb86650afb3538]
stable/6.1: [1e4f873879e075bbd4eb1c644d6933303ac5eba4]
stable/6.12: [cadf3da46c15523fba90d80c9955f536ee3b4023]
stable/6.18: [fd7579f0a2c84ba8a7d4f206201b50dc8ddf90c2]
stable/6.19: [1fab5ece76fb42a761178dcd0ebcbf578377b0dd]
stable/6.6: [f00fc26c8a06442b225a350fe000c0a11483e6a3]

CVE-2026-23451: bonding: prevent potential infinite loop in bond_header_parse()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23451

Introduced by commit 950803f ("bonding: fix type confusion in
bond_setup_by_slave()") in v7.0-rc4.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.18 stable/6.19

Fixed status
mainline: [b7405dcf7385445e10821777143f18c3ce20fa04]
stable/6.12: [946bb6cacf0ccada7bc80f1cfa07c1ed79511c1c]
stable/6.18: [4172a7901cf43fe1cc63ef7a2ef33735ff7b7d13]
stable/6.19: [9b49c854f14f5e2d493e562a1e28d2e57fe37371]

CVE-2026-23452: PM: runtime: Fix a race condition related to device removal

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23452

Introduced by commit 5e928f7 ("PM: Introduce core framework for
run-time PM of I/O devices (rev. 17)") in v2.6.32-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29ab768277617452d88c0607c9299cdc63b6e9ff]
stable/6.1: [5649b46af8b167259e8a8e4e7eb3667ce74554b5]
stable/6.12: [c6febaacfb8a0aec7d771a0e6c21cd68102d5679]
stable/6.18: [bb081fd37f8312651140d7429557258afe51693d]
stable/6.19: [cf65a77c0f9531eb6cfb97cc040974d2d8fff043]
stable/6.6: [39f2d86f2ddde8d1beda05732f30c7cd945e0b5a]

CVE-2026-23453: net: ti: icssg-prueth: Fix memory leak in XDP_DROP for
non-zero-copy mode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23453

Introduced by commit 7a64bb3 ("net: ti: icssg-prueth: Add AF_XDP zero
copy for RX") in v6.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [719d3e71691db7c4f1658ba5a6d1472928121594]
stable/6.19: [d16d57dedcb69c1a1257e0638f8698ce1f0ccbe5]

CVE-2026-23454: net: mana: fix use-after-free in
mana_hwc_destroy_channel() by reordering teardown

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23454

Introduced by commit ca9c54d ("net: mana: Add a driver for Microsoft
Azure Network Adapter (MANA)") in v5.13-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fa103fc8f56954a60699a29215cb713448a39e87]
stable/6.1: [e23bf444512cb85d76012080a76cd1f9e967448e]
stable/6.12: [2b001901f689021acd7bf2dceed74a1bdcaaa1f9]
stable/6.18: [afdb1533eb9c05432aeb793a7280fa827c502f5c]
stable/6.19: [05d345719d85b927cba74afac4d5322de3aa4256]
stable/6.6: [249e905571583a434d4ea8d6f92ccc0eef337115]

CVE-2026-23455: netfilter: nf_conntrack_h323: check for zero length in
DecodeQ931()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23455

Introduced by commit 5e35941 ("[NETFILTER]: Add H.323 conntrack/NAT
helper") in v2.6.20.16.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f173d0f4c0f689173f8cdac79991043a4a89bf66]
stable/6.1: [495e97af9e7249ee02b72bb1d0848a6efc3700f4]
stable/6.12: [633e8f87dad32263f6a57dccdb873f042c062111]
stable/6.18: [9d00fe7d6d7c5b5f1065a6e042b54f2e44bd6df8]
stable/6.19: [b652b05d51003ac074b912684f9ec7486231717b]
stable/6.6: [f5e4f4e4cdb75ec36802059a94195a31f193da60]

CVE-2026-23456: netfilter: nf_conntrack_h323: fix OOB read in
decode_int() CONS case

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23456

Introduced by commit 5e35941 ("[NETFILTER]: Add H.323 conntrack/NAT
helper") in v2.6.20.16.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [1e3a3593162c96e8a8de48b1e14f60c3b57fca8a]
stable/6.1: [41b417ff73a24b2c68134992cc44c88db27f482d]
stable/6.12: [774a434f8c9c8602a976b2536f65d0172a07f4d2]
stable/6.18: [6bce72daeccca9aa1746e92d6c3d4784e71f2ebb]
stable/6.19: [fb6c3596823ec5dd09c2123340330d7448f51a59]
stable/6.6: [52235bf88159a1ef16434ab49e47e99c8a09ab20]

CVE-2026-23457: netfilter: nf_conntrack_sip: fix Content-Length u32
truncation in sip_help_tcp()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23457

Introduced by commit f5b321b ("netfilter: nf_conntrack_sip: add TCP
support") in v2.6.34-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fbce58e719a17aa215c724473fd5baaa4a8dc57c]
stable/6.1: [b75209debb9adab287b3caa982f77788c1e15027]
stable/6.12: [75fcaee5170e7dbbee778927134ef2e9568b4659]
stable/6.18: [865dba58958c3a86786f89a501971ab0e3ec6ba9]
stable/6.19: [d4f17256544cc37f6534a14a27a9dec3540c2015]
stable/6.6: [528b4509c9dfc272e2e92d811915e5211650d383]

CVE-2026-23458: netfilter: ctnetlink: fix use-after-free in
ctnetlink_dump_exp_ct()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23458

Introduced by commit e844a92 ("netfilter: ctnetlink: allow to dump
expectation per master conntrack") in v3.10-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5cb81eeda909dbb2def209dd10636b51549a3f8a]
stable/6.1: [bdf2724eefd4455a66863abb025bab8d3aa98c57]
stable/6.12: [f025171feef2ac65663d7986f1d5ff0c28d6b2a9]
stable/6.18: [04c8907ce4e3d3e26c5e1a3e47aa5d17082cbb56]
stable/6.19: [cd541f15b60e2257441398cf495d978f816d09f8]
stable/6.6: [f04cc86d59906513d2d62183b882966fc0ae0390]

CVE-2026-23459: ip_tunnel: adapt iptunnel_xmit_stats() to
NETDEV_PCPU_STAT_DSTATS

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23459

Introduced by commit 6fa6de3 ("geneve: Handle stats using
NETDEV_PCPU_STAT_DSTATS.") in v6.14-rc1.
Introduced by commit be22635 ("vxlan: Handle stats using
NETDEV_PCPU_STAT_DSTATS.") in v6.14-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8431c602f551549f082bbfa67f3003f2d8e3e132]
stable/6.19: [0d087d00161f562d5047cc4009bb0c6a19daf9f1]

CVE-2026-23460: net/rose: fix NULL pointer dereference in
rose_transmit_link on reconnect

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23460

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e1f0a18c9564cdb16523c802e2c6fe5874e3d944]
stable/6.1: [c2ab74c12932e52cfa1e7e4582d42b0c8bec96c7]
stable/6.12: [508f49ccbe0329641bb681f7d0052bb4e5943252]
stable/6.18: [0c3e8bff808f17ad37a51d8e719eed22c7863120]
stable/6.19: [a12254050e3050f1011cd24f3b880a6882d0139d]
stable/6.6: [0c9fb70a206a8734e10468ecc24d57c7596cf64e]

CVE-2026-23461: Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23461

Introduced by commit ab4eedb ("Bluetooth: L2CAP: Fix corrupted list in
hci_chan_del") in v6.14-rc3.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/6.12 stable/6.12 stable/6.6

Fixed status
mainline: [752a6c9596dd25efd6978a73ff21f3b592668f4a]
stable/6.12: [c22a5e659959eb77c2fbb58a5adfaf3c3dab7abf]
stable/6.18: [da3000cbe4851458a22be38bb18c0689c39fdd5f]
stable/6.19: [71030f3b3015a412133a805ff47970cdcf30c2b8]
stable/6.6: [11a87dd5df428a4b79a84d2790cac7f3c73f1f0d]

CVE-2026-23462: Bluetooth: HIDP: Fix possible UAF

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23462

Introduced by commit b4f34d8 ("Bluetooth: hidp: add new
session-management helpers") in v3.10-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dbf666e4fc9bdd975a61bf682b3f75cb0145eedd]
stable/6.1: [21a47a119f33df9bb157326846390d7e8e1b45ba]
stable/6.12: [7c805b7d1e580eececcc92470292e3dbc42bc3f5]
stable/6.18: [f8b6ed2f06d3baa44f347a0fa2af52433f386463]
stable/6.19: [4d37fa7582aa960ba23e10a7a2596a29f37ad281]
stable/6.6: [45ebe5b900200ac3e01f3470506a44a447825721]

CVE-2026-23463: soc: fsl: qbman: fix race condition in qman_destroy_fq

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23463

Introduced by commit c535e92 ("soc/fsl: Introduce DPAA 1.x QMan device
driver") in v4.9-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [014077044e874e270ec480515edbc1cadb976cf2]
stable/6.1: [9e3d47904b8153c8c3ad2f9b66d5008aad677aa8]
stable/6.12: [751f60bd48edaf03f9d84ab09e5ce6705757d50f]
stable/6.18: [85dbbf7dc88b0a54f2e334daedf6f3f31fd004fa]
stable/6.19: [265e56714635c5dd1e5964bfd97fa6e73f62cde5]
stable/6.6: [d21923a8059fa896bfef016f55dd769299335cb4]

CVE-2026-23464: soc: microchip: mpfs: Fix memory leak in
mpfs_sys_controller_probe()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23464

Introduced by commit 742aa6c ("soc: microchip: mpfs: enable access to
the system controller's flash") in v6.8-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5a741f8cc6fe62542f955cd8d24933a1b6589cbd]
stable/6.12: [da4b44c42f40501db35f5d0a6243708a061490a0]
stable/6.18: [e3dd5cffba07de6574165a72851471cd42cc6d15]
stable/6.19: [17c84fb7cf3971cc621646185d785670e9530ca1]

CVE-2026-23465: btrfs: log new dentries when logging parent dir of a
conflicting inode

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23465

Introduced by commit a3baaf0 ("Btrfs: fix fsync after succession of
renames and unlink/rmdir") in v5.1-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [9573a365ff9ff45da9222d3fe63695ce562beb24]
stable/6.12: [f556b1e09d054e31f464c0fd37280c2b5a393fee]
stable/6.18: [1cf30c73602c69d750c9345c47f2c0e9d0cfb578]
stable/6.19: [6f5a51969b1deb79aefd2194b48fe7e78e72ff7e]
stable/6.6: [56e72c8b02d982be775d9df025357c152383ee84]

CVE-2026-23466: drm/xe: Open-code GGTT MMIO access protection

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23466

Introduced by commit 919bb54 ("drm/xe: Fix missing runtime outer
protection for ggtt_remove_node") in v6.12-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [01f2557aa684e514005541e71a3d01f4cd45c170]
stable/6.12: [e2b424aadecb640f9e037b2891191cf8fd4c64cf]
stable/6.18: [1e9e2640d870d4837bcfdc220cb2c99ae5ee119f]
stable/6.19: [76326dc06d8793c2c81c31cc0115dbc348de2f88]

CVE-2026-23467: drm/i915/dmc: Fix an unlikely NULL pointer deference at probe

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23467

Introduced by commit 88c1f9a ("drm/i915/dmc: Create debugfs entry for
dc6 counter") in v6.16-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ac57eb3b7d2ad649025b5a0fa207315f755ac4f6]
stable/6.18: [0b35d11fbbcfd1079c8489282a341944228835e3]
stable/6.19: [631317825d44283abfe7a8374f13a76ce2032bb8]

CVE-2026-23468: drm/amdgpu: Limit BO list entry count to prevent
resource exhaustion

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23468

According to the .vulnerable file, this bug was introduced by commit
d38ceaf in v4.2-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6270b1a5dab94665d7adce3dc78bc9066ed28bdd]
stable/6.18: [5ce4a38e6c2488949e373d5066303f9c128db614]
stable/6.19: [f462624a6e4b5f1ec2664c2c53e408b2f4fb53e9]

CVE-2026-23469: drm/imagination: Synchronize interrupts before
suspending the GPU

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23469

Introduced by commit cc1aeed ("drm/imagination: Implement firmware
infrastructure and META FW support") in v6.8-rc1.
Introduced by commit 96822d3 ("drm/imagination: Handle Rogue safety
event IRQs") in v6.16-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2d7f05cddf4c268cc36256a2476946041dbdd36d]
stable/6.18: [772f3653eef50ea7cf721b05d8e275f93bc460f3]
stable/6.19: [8e0c15e426a056b9fb604cf87a1dfdec4d61e407]

CVE-2026-23470: drm/imagination: Fix deadlock in soft reset sequence

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23470

Introduced by commit cc1aeed ("drm/imagination: Implement firmware
infrastructure and META FW support") in v6.8-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a55c2a5c8d680156495b7b1e2a9f5a3e313ba524]
stable/6.12: [f99e8b813ae5ce8ffd62c33f5753bf0a008af4b1]
stable/6.18: [9497b1f309436971726e229aa6026954ea7c28e9]
stable/6.19: [6f39b48a2d3b1fe83f99477250cd0cd67ca1e1c6]

CVE-2026-23471: drm: Fix use-after-free on framebuffers and property
blobs when calling drm_dev_unplug

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23471

Introduced by commit bee330f ("drm: Use srcu to protect
drm_device.unplugged") in v4.18-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [6bee098b91417654703e17eb5c1822c6dfd0c01d]
stable/6.1: [54df178324b268c62f847381e2813a1b0f971384]
stable/6.12: [7e3ec3bf4015156dcc5bafed13f26a587cc37f5c]
stable/6.18: [074d06d3724ccab0c5bb779db594a82b6405e501]
stable/6.19: [e493c135980f90c20308d1a98f2e0d1223951e94]
stable/6.6: [eec4d5758f33925e0bdb4a32b45d86a68afa4516]

CVE-2026-23472: serial: core: fix infinite loop in handle_tx() for PORT_UNKNOWN

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23472

According to the .vulnerable file, this bug was introduced by commit
1da177e in v2.6.12.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [455ce986fa356ff43a43c0d363ba95fa152f21d5]
stable/6.18: [efe85a557186b7fe915572ae93a8f3f78bfd9a22]
stable/6.19: [bc70f2b36cf474d5cc8ecbcaf57f3e326fdec67c]

CVE-2026-23473: io_uring/poll: fix multishot recv missing EOF on wakeup race

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23473

Introduced by commit dbc2564 ("io_uring: let fast poll support
multishot") in v5.19-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [a68ed2df72131447d131531a08fe4dfcf4fa4653]
stable/6.18: [0f4ce79b8db7b040373fc664c8bc6c5fd74bd196]
stable/6.19: [bf33554b6abf7e7faeadd8af1b82037ea755a6bb]

CVE-2026-23474: mtd: Avoid boot crash in RedBoot partition table parser

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23474

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8e2f8020270af7777d49c2e7132260983e4fc566]
stable/6.1: [0b08be5aca212a99f8ba786fee4922feac08002c]
stable/6.12: [2025b2d1f9d5cad6ea6fe85654c6c41297c3130b]
stable/6.18: [c4054ad2d8bff4e8e937cd4a1d1a04c1e8f77a2c]
stable/6.19: [75a4d8cfe7784f909b3bd69325abac8e04ecb385]
stable/6.6: [d8570211a2b1ec886a462daa0be4e9983ac768bb]

CVE-2026-23475: spi: fix statistics allocation

Announce: https://www.cve.org/CVERecord?id=CVE-2026-23475

Introduced by commit 6598b91 ("spi: spi.c: Convert statistics to
per-cpu u64_stats_t") in v6.0-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dee0774bbb2abb172e9069ce5ffef579b12b3ae9]
stable/6.1: [80c5bd0dca1cc5526ae0f4b273ccd163ed4caa4e]
stable/6.12: [df30056c78e8bead02d4be020199cabdbec0fef1]
stable/6.18: [378b295f67102eef78cf2c28105f60ae1dab5cc1]
stable/6.19: [118ce777d39f03cac99231196f820e4f998613a8]
stable/6.6: [f13100b1f5f111989f0750540a795fdef47492af]

CVE-2026-31389: spi: fix use-after-free on controller registration failure

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31389

Introduced by commit 6598b91 ("spi: spi.c: Convert statistics to
per-cpu u64_stats_t") in v6.0-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8634e05b08ead636e926022f4a98416e13440df9]
stable/6.1: [0e23f50086da7d0b183dfeac26021acfcdee086b]
stable/6.12: [afe27c1f43aa57530011f419be6ddf71306565d2]
stable/6.18: [80f3e8cd2b4ad355b2ad2024cf423f6d183404f7]
stable/6.19: [23b51bad2eb8787aa74324cfccefb258515ae5ba]
stable/6.6: [6bbd385b30c7fb6c7ee0669e9ada91490938c051]

CVE-2026-31390: drm/xe: Fix memory leak in xe_vm_madvise_ioctl

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31390

Introduced by commit 293032e ("drm/xe/bo: Update atomic_access
attribute on madvise") in v6.18-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [0cfe9c4838f1147713f6b5c02094cd4dc0c598fa]
stable/6.18: [c3aa7b837920c844d5ae0dd3dbaeb465a461de40]
stable/6.19: [1c87b48a0ff040723f84a67b32892af7e6a3634f]

CVE-2026-31391: crypto: atmel-sha204a - Fix OOM ->tfm_count leak

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31391

Introduced by commit da001fb ("crypto: atmel-i2c - add support for
SHA204A random number generator") in v5.3-rc1.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [d240b079a37e90af03fd7dfec94930eb6c83936e]
stable/6.1: [66ee9c1c3575b5d6afc340faca00fd40ed5b7ad9]
stable/6.12: [1ab70c260cf16f931a728b2cb63fff5f38c814d8]
stable/6.18: [6f502049a96b368ea6646c49d9520d6f69a101fa]
stable/6.19: [fd262dc6d758232511127372eba866b7600739ba]
stable/6.6: [2bfc83cee05f8b9604502df27d94e8e2b4a3dbf1]

CVE-2026-31392: smb: client: fix krb5 mount with username option

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31392

According to the .vulnerable file, this bug was introduced by commit
4ff67b7 in v2.6.36-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [12b4c5d98cd7ca46d5035a57bcd995df614c14e1]
stable/6.1: [fd4547830720647d4af02ee50f883c4b1cca06e4]
stable/6.12: [d33cbf0bf8979d779900da9be2505d68d9d8da25]
stable/6.18: [9ee803bfdba0cf739038dbdabdd4c02582c8f2b2]
stable/6.19: [6e9ff1eb7feedcf46ff2d0503759960ab58e7775]
stable/6.6: [9229709ec8bf85ae7ca53aeee9aa14814cdc1bd2]

CVE-2026-31393: Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload
length before access

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31393

Introduced by commit 4e8402a ("[Bluetooth] Retrieve L2CAP features
mask on connection setup") in v2.6.24-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [dd815e6e3918dc75a49aaabac36e4f024d675101]
stable/6.1: [3b646516cba2ebc4b51a72954903326e7c1e443f]
stable/6.12: [9aeacde4da0f02d42fd968fd32f245828b230171]
stable/6.18: [e7ff754e339e3d5ce29aa9f95352d0186df8fbd9]
stable/6.19: [db2872d054e467810078e2b9f440a5b326a601b2]
stable/6.6: [807bd1258453c4c83f6ae9dbc1e7b44860ff40d0]

CVE-2026-31394: mac80211: fix crash in ieee80211_chan_bw_change for
AP_VLAN stations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31394

According to the .vulnerable file, this bug was introduced by commit
b275123 in v6.11-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [672e5229e1ecfc2a3509b53adcb914d8b024a853]
stable/6.12: [65c25b588994dd422fea73fa322de56e1ae4a33b]
stable/6.18: [5a86d4e920d9783a198e39cf53f0e410fba5fbd6]
stable/6.19: [3c6629e859a2211a1fbb4868f915413f80001ca5]

CVE-2026-31395: bnxt_en: fix OOB access in DBG_BUF_PRODUCER async event handler

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31395

Introduced by commit 84fcd94 ("bnxt_en: Manage the FW trace context
memory") in v6.13-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [64dcbde7f8f870a4f2d9daf24ffb06f9748b5dd3]
stable/6.18: [19aa416eed9e4aaf1bbe8da0f7bd9a9be31158c8]
stable/6.19: [b7c7a275447c6d4bf4a36a134682e2e4e20efd4b]

CVE-2026-31396: net: macb: fix use-after-free access to PTP clock

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31396

Introduced by commit c2594d8 ("macb: Common code to enable ptp support
for MACB/GEM") in v4.11-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8da13e6d63c1a97f7302d342c89c4a56a55c7015]
stable/6.1: [341d01087f821aa0f165fb1ffc8bfe4e50776da7]
stable/6.12: [0bb848d8c64938024e45780f8032f1f67d3a3607]
stable/6.18: [1f4714065b2bcbb0a4013fd355b84b848e6cc345]
stable/6.19: [eb652535e9ec795ef5c1078f7578eaaed755268b]
stable/6.6: [5653af416a48f6c18f9626ae9df96f814f45ff34]

CVE-2026-31397: mm/huge_memory: fix use of NULL folio in move_pages_huge_pmd()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31397

Introduced by commit e3981db ("mm: add folio_mk_pmd()") in v6.16-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [fae654083bfa409bb2244f390232e2be47f05bfc]
stable/6.18: [f3caaee0f9e489fd2282d4ce45791dc8aed2da62]
stable/6.19: [e3133d0986dc5a231d5419167dbac65312b28b41]

CVE-2026-31398: mm/rmap: fix incorrect pte restoration for lazyfree folios

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31398

Introduced by commit 354dffd ("mm: support batched unmap for lazyfree
large folios during reclamation") in v6.15-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [29f40594a28114b9a9bc87f6cf7bbee9609628f2]
stable/6.18: [99888a4f340ca8e839a0524556bd4db76d63f4e0]
stable/6.19: [a0911ccdba41b0871abbf8412857bafedec3dbe1]

CVE-2026-31399: nvdimm/bus: Fix potential use after free in
asynchronous initialization

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31399

Introduced by commit b6eae0f ("libnvdimm: Hold reference on parent
while scheduling async init") in v4.20-rc1.
Fixed in v7.0-rc5.

Bug introduced commit was backported to following branches.
cip/4.19 cip/4.19-rt cip/4.19-st cip/4.4 cip/4.4-rt cip/4.4-st

Fixed status
mainline: [a8aec14230322ed8f1e8042b6d656c1631d41163]
stable/6.1: [9a0fb16ba5b372465a3a1ecd761c6fa911a4ab4d]
stable/6.12: [2c638259ad750833fd46a0cf57672a618542d84c]
stable/6.18: [a226e5b49e5fe8c98b14f8507de670189d191348]
stable/6.19: [84af19855d1abdee3c9d57c0684e2868e391793c]
stable/6.6: [e48bf8f1d2b12c1c5ba1f609edbd4cde5dadc20e]

CVE-2026-31400: sunrpc: fix cache_request leak in cache_release

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31400

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [17ad31b3a43b72aec3a3d83605891e1397d0d065]
stable/6.1: [7bcd5e318876ac638c8ceade7a648e76ac8c48e1]
stable/6.12: [301670dcd098c1fe5c2fe90fb3c7a8f4814d2351]
stable/6.18: [be5c35960e5ead70862736161836e2d1bc7352dc]
stable/6.19: [373457de14281c1fc7cace6fc4c8a267fc176673]
stable/6.6: [41f6ba6c98a618043d2cd71030bf9a752dfab8b2]

CVE-2026-31401: HID: bpf: prevent buffer overflow in hid_hw_request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31401

Introduced by commit 8bd0488 ("HID: bpf: add HID-BPF hooks for
hid_hw_raw_requests") in v6.11-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [2b658c1c442ec1cd9eec5ead98d68662c40fe645]
stable/6.12: [d6efaa50af62fb0790dd1fd4e7e5506b46312510]
stable/6.18: [73c5b5aea1c443239c8cb4191b4af7a4bd6fd7b1]
stable/6.19: [eb57dae20fdf6f3069cdc07821fa3bb46de381d7]

CVE-2026-31402: nfsd: fix heap overflow in NFSv4.0 LOCK replay cache

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31402

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [5133b61aaf437e5f25b1b396b14242a6bb0508e2]
stable/6.1: [c9452c0797c95cf2378170df96cf4f4b3bca7eff]
stable/6.12: [dad0c3c0a8e5d1d6eb0fc455694ce3e25e6c57d0]
stable/6.18: [0f0e2a54a31a7f9ad2915db99156114872317388]
stable/6.19: [ae8498337dfdfda71bdd0b807c9a23a126011d76]
stable/6.6: [8afb437ea1f70cacb4bbdf11771fb5c4d720b965]

CVE-2026-31403: NFSD: Hold net reference for the lifetime of
/proc/fs/nfs/exports fd

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31403

Introduced by commit 96d851c ("nfsd: use proper net while reading
"exports" file") in v3.9-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [e7fcf179b82d3a3730fd8615da01b087cc654d0b]
stable/6.1: [c7f406fb341d6747634b8b1fa5461656e5e56076]
stable/6.12: [e3d77f935639e6ae4b381c80464c31df998d61f4]
stable/6.18: [db4a9f99b12a7ee1c19d86c83a3b752c7effa6c6]
stable/6.19: [6a8d70e2ad6aad2c345a5048edcb8168036f97d6]
stable/6.6: [d1a19217995df9c7e4118f5a2820c5032fef2945]

CVE-2026-31404: NFSD: Defer sub-object cleanup in export put callbacks

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31404

Introduced by commit c224edc ("nfsd: no need get cache ref when
protected by rcu") in v6.14-rc1.
Introduced by commit 1b10f0b ("SUNRPC: no need get cache ref when
protected by rcu") in v6.14-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [48db892356d6cb80f6942885545de4a6dd8d2a29]
stable/6.18: [2829e80d29b627886d12b5ea40856d56b516e67d]
stable/6.19: [f5ab1bec5fa18731e0b1b1e60c9a68667ac73ea2]

CVE-2026-31405: media: dvb-net: fix OOB access in ULE extension header tables

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31405

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc3.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [24d87712727a5017ad142d63940589a36cd25647]
stable/6.1: [29ef43ceb121d67b87f4cbb08439e4e9e732eff8]
stable/6.12: [145e50c2c700fa52b840df7bab206043997dd18e]
stable/6.18: [8bde543d2a5f935ba2a6a6325a2e02f8a9256fbe]
stable/6.19: [f2b65dcb78c8990e4c68a906627433be1fe38a92]
stable/6.6: [1a6da3dbb9985d00743073a1cc1f96e59f5abc30]

CVE-2026-31406: xfrm: Fix work re-schedule after cancel in
xfrm_nat_keepalive_net_fini()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31406

Introduced by commit f531d13 ("xfrm: support sending NAT keepalives in
ESP in UDP states") in v6.11-rc1.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [daf8e3b253aa760ff9e96c7768a464bc1d6b3c90]
stable/6.12: [32d0f44c2f14d60fe8e920e69a28c11051543ec1]
stable/6.18: [2255ed6adbc3100d2c4a83abd9d0396d04b87792]
stable/6.19: [21f2fc49ca6faa393c31da33b8a4e6c41fc84c13]

CVE-2026-31407: netfilter: conntrack: add missing netlink policy validations

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31407

Introduced by commit 076a0ca ("netfilter: ctnetlink: add NAT support
for expectations") in v3.4-rc1.
Introduced by commit a258860 ("netfilter: ctnetlink: add full support
for SCTP to ctnetlink") in v2.6.27-rc1.
Fixed in v7.0-rc5.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [f900e1d77ee0ef87bfb5ab3fe60f0b3d8ad5ba05]
stable/6.19: [0fbae1e74493d5a160a70c51aeba035d8266ea7d]

CVE-2026-31408: Bluetooth: SCO: Fix use-after-free in sco_recv_frame()
due to missing sock_hold

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31408

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [598dbba9919c5e36c54fe1709b557d64120cb94b]
stable/6.12: [108b81514d8f2535eb16651495cefb2250528db3]
stable/6.18: [7197462e90b8ce15caa1ae15d4bc2bb8cd21b11e]
stable/6.19: [e76e8f0581ef555eacc11dbb095e602fb30a5361]
stable/6.6: [45aaca995e4a7a05b272a58e7ab2fff4f611b8f1]

CVE-2026-31409: ksmbd: unset conn->binding on failed binding request

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31409

Introduced commit is not determined.Fixed in v7.0-rc5.


Fixed status
mainline: [282343cf8a4a5a3603b1cb0e17a7083e4a593b03]
stable/6.1: [d073870dab8f6dadced81d13d273ff0b21cb7f4e]
stable/6.12: [89afe5e2dbea6e9d8e5f11324149d06fa3a4efca]
stable/6.18: [9feb2d1bf86d9e5e66b8565f37f8d3a7d281a772]
stable/6.19: [6260fc85ed1298a71d24a75d01f8b2e56d489a60]
stable/6.6: [6ebef4a220a1ebe345de899ebb9ae394206fe921]

CVE-2026-31410: ksmbd: use volume UUID in FS_OBJECT_ID_INFORMATION

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31410

Introduced commit is not determined.Fixed in v7.0-rc5.


Fixed status
mainline: [3a64125730cabc34fccfbc230c2667c2e14f7308]
stable/6.12: [ce00616bc1df675bfdacc968f2bf7c51f4669227]
stable/6.18: [3d80ebe6d1b7bc9ad20fd9b0c1a0c56d804f8a0a]
stable/6.19: [c283a6ffe6d5d6e5594d991286b9ce15951572e1]

CVE-2026-31411: net: atm: fix crash due to unvalidated vcc pointer in
sigd_send()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-31411

Introduced by commit 1da177e ("Linux-2.6.12-rc2") in v2.6.12.
Fixed in v7.0-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ae88a5d2f29b69819dc7b04086734439d074a643]
stable/5.10: [c96549d07dfdd51aadf0722cfb40711574424840]
stable/5.15: [1c8bda3df028d5e54134077dcd09f46ca8cfceb5]
stable/6.1: [3e1a8b00095246a9a2b46b57f6d471c6d3c00ed2]
stable/6.12: [21c303fec138c002f90ed33bce60e807d53072bb]
stable/6.18: [69d3f9ee5489e6e8b66defcfa226e91d82393297]
stable/6.19: [440c9a5fc477a8ee259d8bf669531250b8398651]
stable/6.6: [e3f80666c2739296c3b69a127300455c43aa1067]



Fixed status

* Updated CVEs

CVE-2024-14027: xattr: switch to CLASS(fd)

stable/6.6 was fixed.

Fixed status
stable/6.6: [5a1e865e51063d6c56f673ec8ad4b6604321b455]

CVE-2025-22116: idpf: check error for register_netdev() on init

stable/6.12 was fixed.

Fixed status
stable/6.12: [1ca996324eacab8fdb7c8ac231eebe5ef0c3c454]

CVE-2025-22117: ice: fix using untrusted value of pkt_len in
ice_vc_fdir_parse_raw()

stable/6.12 was fixed.

Fixed status
stable/6.12: [363377af2c9e874fbba3a199408f8ec7b37906f7]

CVE-2025-40242: gfs2: Fix unlikely race in gdlm_put_lock

stable/6.6 was fixed.

Fixed status
stable/6.6: [4913592a3358f6ec366b8346b733d5e2360b08e1]

CVE-2025-68175: media: nxp: imx8-isi: Fix streaming cleanup on release

stable/6.12 was fixed.

Fixed status
stable/6.12: [a2008925ed7361d69f92f63f0a779c300432610a]

CVE-2025-68736: landlock: Fix handling of disconnected directories

stable/6.12 was fixed.

Fixed status
stable/6.12: [426d5b681b2f3339ff04da39b81d71176dc8c87c]

CVE-2026-22981: idpf: detach and close netdevs while handling a reset

stable/6.12 was fixed.

Fixed status
stable/6.12: [9ad3d0836d8bc1a0f0b4bf56efc56312a9e64b97]

CVE-2026-22985: idpf: Fix RSS LUT NULL pointer crash on early ethtool operations

stable/6.12 was fixed.

Fixed status
stable/6.12: [df2790b5228fbd3ed415b70a231cffdad0431618]

CVE-2026-22993: idpf: Fix RSS LUT NULL ptr issue after soft reset

stable/6.12 was fixed.

Fixed status
stable/6.12: [a09380354d2f14759b9dd45de1bc2f6bf49e651b]

CVE-2026-23207: spi: tegra210-quad: Protect curr_xfer check in IRQ handler

stable/6.12 was fixed.

Fixed status
stable/6.12: [84e926c1c272a35ddb9b86842d32fa833a60dfc7]

CVE-2026-23210: ice: Fix PTP NULL pointer dereference during VSI rebuild

stable/6.12 was fixed.

Fixed status
stable/6.12: [ba0c7fff6616025a7d3a9e887e7ce16b06dc34b9]

CVE-2026-23255: net: add proper RCU protection to /proc/net/ptype

stable/6.12 was fixed.

Fixed status
stable/6.12: [dcefd3f0b9ed8288654c75254bdcee8e1085e861]

CVE-2026-23360: nvme: fix admin queue leak on controller reset

stable/6.6 was fixed.

Fixed status
stable/6.6: [2efbc838a26d3da72d8fe05770bdf869d4ca3ac5]

CVE-2026-23401: KVM: x86/mmu: Drop/zap existing present SPTE even when
creating an MMIO SPTE

stable/6.12, stable/6.18, stable/6.19, stable/6.6 were fixed.

Fixed status
stable/6.12: [459158151a158a6703b49f3c9de0e536d8bd553f]
stable/6.18: [695320de6eadb75aaed8be1787c4ce4c189e4c7b]
stable/6.19: [bce7fe59d43531623f3e43779127bfb33804925d]
stable/6.6: [fd28c5618699180cd69619801e9ae6a5266c0a22]

CVE-2026-23402: KVM: x86/mmu: Only WARN in direct MMUs when
overwriting shadow-present SPTE

stable/6.18, stable/6.19 were fixed.

Fixed status
stable/6.18: [bab090e8fd5607f77379ea78b9d0c683cb1538a9]
stable/6.19: [a1e0f7150639bc30a8e75476d1c7daab77d44992]

CVE-2025-40219: PCI/IOV: Add PCI rescan-remove locking when
enabling/disabling SR-IOV

stable/6.18, stable/6.19 were fixed.

Fixed status
stable/6.18: [bea1d373098b22d7142da48750ce5526096425bc]
stable/6.19: [f3015627b6e9ddf85cfeaf42405b3c194dde2c36]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

