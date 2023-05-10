Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC84C77B7C
	for <webhook@archiver.kernel.org>; Wed, 10 May 2023 23:48:22 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
 by mx.groups.io with SMTP id smtpd.web11.33080.1683762491685062704
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 May 2023 16:48:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=Vl1baclk;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.171, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3940f546923so1621288b6e.2
        for <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1683762490; x=1686354490;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QpjbNC8o+/G4q2M33WH89npXMCTatYIUDh03xpCFurY=;
        b=Vl1baclk6lU+Qg1y81CtG3VNKWctR3pIdyXVR6u8bwspp1s4TIGy6DlXr2K1JWDmWD
         iQgoKttsq7yJdzk4IqQM02uenbaN0Xln3M64l4OIG/ueb6/NXalE86eB9JCLyw4oOrqy
         /ILATPZkJPti67uBCcwLz5L71Uy8zJUWM4rNIVqmf3OmDnl3DnCc9Ds18hZDaSToIvSw
         nxYpwr4BTo++4OcEX6g9BTA18jQUzuECt4uqetqWfl1/CXAtI144FMzfReu7VifBJ525
         6B7LH8Sjc4BFj5Fy6i/awFpSwqkQsNn3m+/Te/0hgxyZrHlWtCTw6EQm75UqJpHrmA04
         e7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683762490; x=1686354490;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpjbNC8o+/G4q2M33WH89npXMCTatYIUDh03xpCFurY=;
        b=BvjSgOSyLx2X94M2CZLf/X4EcHQ177ms6bl1cjmasLL93EUUU/qZn5+70LLxoOBS3S
         Hyo2BaWnYAo3Nga3MjoMoJnV3f4/uNeM359kxVvReu4ivLz2FE4bTnLN/6bG3XmrVHg4
         F4HDPNfATHs4R8peLGVzwZjuqn/+ee2OQuqp0o6m7njJXwQ/gm830CuBeIaFXOQIUlYz
         Grdc0zH6+eDuXs4gkCYH8EoCkKNfmE2TKdYZAwXRdMNmETZ3a83hFKzYBnCAQ6hwbG/s
         0VQ6p66wFeDQloVfsPuf9i5NQl6Qw0AHmrVmaddpuVHcuQIX1DrJlOCKNneVTZgwcZ3I
         FXuw==
X-Gm-Message-State: AC+VfDx/QNW3aDf60txSY53u1M2F3UKXU97+6RQvOmJ1fFplctYvGNJs
	U7SbkkbNoJ7kNeItvAwu6/jI1O9EVbF6waizmVb/eAhEll6ED0p/G4I=
X-Google-Smtp-Source: ACHHUZ4iJtPMi2BSWtEvnkkJ75O1A/CJi9J9Wx9wlY4gnCk3nAOoOiPX528GeFXSXgwJ2y4L1o9dtoQIT3hO6tGM+vg=
X-Received: by 2002:aca:1712:0:b0:38c:3cfd:e3a6 with SMTP id
 j18-20020aca1712000000b0038c3cfde3a6mr3982048oii.31.1683762490005; Wed, 10
 May 2023 16:48:10 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 11 May 2023 08:47:33 +0900
Message-ID: <CAODzB9pCfEBNnW2c9SC8=S5-sU1SHQgcCr0UP+Nq4caLNTLsWQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 May 2023 23:48:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11436

Hi !

It's this week's CVE report.

This week reported 9 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2023-21102: arm64: efi: Execute runtime services from a dedicated stack

CVSS v3 score is not provided.

A local privilege escalation bug was found in the EFI code for ARM64
architecture.

Actual security fix is commit ff7a167 ("arm64: efi: Execute runtime
services from a dedicated stack").
The commit 18bba18 adds the missing header file which the commit ff7a167 ne=
eds.

Fixed status
mainline: [ff7a167961d1b97e0e205f245f806e564d3505e7,
18bba1843fc7f264f58c9345d00827d082f9c558]
stable/5.10: [4012603cbd469223f225637d265a233f034c567a,
d6544bccc1967cd6a883d6abac71fc7d863e8baa]
stable/5.15: [de2af657cab92afc13a4ccd8780370481ed0eb61,
7a993c1be595835acf578d0382bfd8f83475f301]
stable/6.1: [f75a91c82dc805af8f718ff106ec9c090234b37b,
72b0e5faa5149f09c6a7a74e4012f29e33509bab]

CVE-2023-2156: Linux Kernel IPv6 RPL Protocol Reachable Assertion
Denial-of-Service Vulnerability

CVSS v3 score is not provided.

This vulnerability allows remote attackers to create a
denial-of-service condition on affected installations of Linux Kernel.
Authentication is not required to exploit this vulnerability.
The specific flaw exists within the handling of the RPL protocol. The
issue results from the lack of proper handling of user-supplied data,
which can result in an assertion failure. An attacker can leverage
this vulnerability to create a denial-of-service condition on the
system.

According to the ZDI advisory(ZDI-23-547), it said that "Given the
nature of the vulnerability, the only salient mitigation strategy is
to restrict interaction with the application.".

Fixed status
Not fixed yet

CVE-2023-21106: drm/msm/gpu: Fix potential double-free

CVSS v3 score is not provided.

A double free bug was found in the drm/msm/gpu driver.
It was introduced by commit d4726d770068 ("drm/msm: Add a way to
override processes comm/cmdline") in 5.19-rc1.
This commit is not backported to older stable kernels so that before
5.19 kernels aren't affected.

Fixed status
mainline: [a66f1efcf748febea7758c4c3c8b5bc5294949ef]
stable/6.1: [8103d53f25ec7b9aa99c134642c6e840e896be71]

CVE-2023-2483: net: qcom/emac: Fix use after free bug in emac_remove
due to race condition

CVSS v3 score is not provided.

A use-after-free bug was found in the drivers/net/ethernet/qualcomm/emac/em=
ac.c.
Introduced by commit b9b17de ("net: emac: emac gigabit ethernet
controller driver") in 4.9-rc1.
This commit is not present in 4.4 so 4.4 kernels are not affected.

Fixed status
mainline: [6b6bc5b8bd2d4ca9e1efa9ae0f98a0b0687ace75]
stable/4.14: [aee129c0096e479eae92e2127f96f9d08f16ad8f]
stable/4.19: [4bbc59ec4feb1ea8d5cb3d9d38d4cb1317943ea4]
stable/5.10: [cb5879efde4f9b4de4248b835890df7b6c49ffbc]
stable/5.15: [8c4a180dc12303159592d15e8f077c20deeb1e55]
stable/5.4: [0e5c7d00ec4f2f359234044b809eb23b7032d9b0]
stable/6.1: [5fc2c4e311a9341a2b0e044ab5f33afa37b56226]
stable/6.2: [514dc3d0f176d280dc2d3cd25e898a7ec329e878]

CVE-2023-2513: ext4: fix use-after-free in ext4_xattr_set_entry

CVSS v3 score is not provided.

A use-after-free vulnerability was found in the Linux kernel's ext4
filesystem in the way
it handled the extra inode size for extended attributes. This flaw
could allow a privileged
local user to cause a system crash or other undefined behaviors.
It looks like 4.4 is affected.

Fixed status
mainline: [67d7d8ad99beccd9fe92d585b87f1760dc9018e3]
stable/4.14: [fb8b3aa9dae22b2184d31fd63ed44d3215fcb41f]
stable/4.19: [c3ecf16b410fd88c15eb8353369a1943c3da5101]
stable/5.10: [bb8592efcf8ef2f62947745d3182ea05b5256a15]
stable/5.15: [21f6bd5cbdab8ac7f7e9321de53668e1ef8f22a6]
stable/5.4: [9d1468732118ec402095451e67b2781ac3a39502]

CVE-2023-32233: netfilter: nf_tables: deactivate anonymous set from
preparation phase

CVSS v3 score is not provided.

In the Linux kernel through 6.3.1, a use-after-free in Netfilter
nf_tables when processing batch
requests can be abused to perform arbitrary read and write operations
on kernel memory.
Unprivileged local users can obtain root privileges. This occurs
because anonymous sets are mishandled.

Fixed status
mainline: [c1592a89942e9678f7d9c8030efa777c0d57edab]

CVE-2023-32269: A use-after-free bug was found in net/netrom/af_netrom.c

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.1.11. In
net/netrom/af_netrom.c, there is
a use-after-free because accept is also allowed for a successfully
connected AF_NETROM socket.
However, in order for an attacker to exploit this, the system must
have netrom routing configured
or the attacker must have the CAP_NET_ADMIN capability.
It affected 4.4 kernels.

Fixed status
mainline: [611792920925fb088ddccbe2783c7f92fdfb6b64]
stable/4.14: [35d5bb094bc7529c15561289a1ea995f897bf2e6]
stable/4.19: [2c1984d101978e979783bdb2376eb6eca9f8f627]
stable/5.10: [dd6991251a1382a9b4984962a0c7a467e9d71812]
stable/5.15: [c27e0eac568a008cdf04ae7e4ea2d3c18717e627]
stable/5.4: [20355b9569bd1fd5a236898524b6dd4117e660d0]
stable/6.1: [5c2227f3f17782d5262ee0979ad30609b3e01f6e]

CVE-2023-2598: An OOB access bug was found in the io_uring subsystem

CVSS v3 score is not provided.

This vulnerability in the fixed buffer registration code of io_uring
that allows for out-of-bounds access to physical memory beyond the end
of the buffer, enabling complete local privilege escalation.
This bug was introduced by commit 57bebf8 ("io_uring/rsrc: optimise
registered huge pages") in 6.3-rc1 so that  before 6.3 kernels aren't
affected.

Fixed status
mainline: [776617db78c6d208780e7c69d4d68d1fa82913de]

CVE-2023-28410: A potential security vulnerability in some Intel=C2=AE i915
Graphics drivers for linux may allow escalation of privilege

CVSS v3 score is not provided (NIST)
CVSS v3 score is 8.8 HIGH (CNA)

Improper restriction of operations within the bounds of a memory
buffer in some Intel(R) i915 Graphics drivers for linux before kernel
version 6.2.10 may allow an authenticated user to potentially enable
escalation of privilege via local access.

Fixed status
Intel Security advisory(https://www.intel.com/content/www/us/en/security-ce=
nter/advisory/intel-sa-00886.html)
said that "Intel recommends updating Intel=C2=AE i915 Graphics for linux to
kernel version 6.2.10 or later."

v6.2.10 contains the following commits in drivers/gpu/drm/i915.

8fc3207 ("drm/i915: Move CSC load back into .color_commit_arm() when
PSR is enabled on skl/glk")
278647c ("drm/i915: Split icl_color_commit_noarm() from
skl_color_commit_noarm()")
5624743 ("drm/i915: Disable DC states for all commits")
5390a02 ("drm/i915/dpt: Treat the DPT BO as a framebuffer")
1c9faad ("drm/i915/gem: Flush lmem contents after construction")
1ca9c29 ("drm/i915/perf: Drop wakeref on GuC RC error")
3ee0c45 ("drm/i915/tc: Fix the ICL PHY ownership check in TC-cold state")
3891994 ("drm/i915/pmu: Use functions common with sysfs to read actual freq=
")

It looks 5390a02 ("drm/i915/dpt: Treat the DPT BO as a framebuffer")
and 1c9faad ("drm/i915/gem: Flush lmem contents after construction")
fix memory related bug. But not sure which commit/both fix this CVE,
nor neither.

* Updated CVEs

CVE-2023-2124: OOB access in the Linux kernel's XFS subsystem

The mainline was fixed.

Fixed status
mainline: [22ed903eee23a5b174e240f1cdfa9acf393a5210]

CVE-2022-48425: fs/ntfs3: Validate MFT flags before replaying logs

The mainline was fixed.

Fixed status
mainline: [98bea253aa28ad8be2ce565a9ca21beb4a9419e5]

CVE-2023-28464: Bluetooth: hci_conn_cleanup function has double free

The mainline, 6.1, and 6.2 were fixed.

Fixed status
mainline: [5dc7d23e167e2882ef118456ceccd57873e876d8]
stable/6.1: [8c4b65f6c707bc07cbcd871667b5056821c5685d]
stable/6.2: [dba0f922d57408fdbd32b9964fcca1d3f1acc9c2]

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

