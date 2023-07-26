Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C0CC0015E
	for <webhook@archiver.kernel.org>; Wed, 26 Jul 2023 23:15:58 +0000 (UTC)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web10.1373.1690413356655764793
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jul 2023 16:15:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=hVnpSO/s;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.182, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3a5a7e7cd61so201279b6e.0
        for <cip-dev@lists.cip-project.org>; Wed, 26 Jul 2023 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1690413355; x=1691018155;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=N0M5pn+/a2kVt9mudbVCCvWm+aIUMhIwW9uq3vVXboo=;
        b=hVnpSO/sT35tqaSpbLAjAnUw1TE84gu0TFrL6HRJ06DI99WYRPcq11+L5FDgyYfrhU
         mEDoFtQR6FqfhR1qIPuhhS3cCRBYAE6VnxIyZEJ3SIL8tCrsmIUD+kHg7qZis8TNf0Ml
         Rvgedqac1GtRfwqYOaSaGMp6dPQcbpqpOpsDSFQYCQLzyqhsPovmBg2AwI0H7ojJGuXr
         sdU8GExgqz25c/wvmKSgOzyxu02ujs3xvx3yo+XUnpMGKDH4Xn962k48/RY9brfvLc0m
         hvm5zQI/Kkcs257TY2yuUrxrSvkUQtRWj5vCvaeXhUipkRNdPMaGC/LP1ddgyGBm/j0S
         qMdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690413355; x=1691018155;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0M5pn+/a2kVt9mudbVCCvWm+aIUMhIwW9uq3vVXboo=;
        b=cKTntSVe4Rz8OhortWt7nJ0XQfiEEe2LpRp0QRSK8qwYtq/4rw6saGdc24OjGCwBcj
         4PoeEW6Mtl6atIT/HMiyDO5KY1mhJdNyIcHLvnCltysifBC3Pxhj/o6i7tWzEBFTNTbT
         X84u5i7h0kfJuSeZ91whHsrPfxUL3nNvC984Q0OT+pHyRgyJKwROk7g0hZjs4I3mCdiL
         wlWGv0jS9zLi9BcIRFDr/yYs5qve4a+Vg7ujr7pqhtx4P/3ESxsqg3aHm9ic83sQip5h
         PK0B56G9rI7e4EWYuJPO+HqeEojw1iUZoJJ0W8uAGWDMc8M/8xLqovunfAETgHozrujD
         sRVw==
X-Gm-Message-State: ABy/qLbOuxG7dWS5YOCMSYpa8eCnE5HHaJadaB4+12S6A24F6QULDUB2
	GL3/82yyLQG92d/HaqbK/MX88wVg8HjBr9/sW9DitiespWq2n7DYgc4=
X-Google-Smtp-Source: APBJJlETN1/IECSwprHjmD7s5V3Wy5NqgotCd7HAYKlGvwqY/1NHTAVjeozbiPF7nQidd+Lj9DMVpwmbRT/1YTWgMHs=
X-Received: by 2002:a05:6808:16ab:b0:3a4:4993:eef9 with SMTP id
 bb43-20020a05680816ab00b003a44993eef9mr716215oib.28.1690413355204; Wed, 26
 Jul 2023 16:15:55 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Jul 2023 08:15:18 +0900
Message-ID: <CAODzB9p4_fh21bZoSMyMiF2QKDqE09kZ0b7mHR99LEw0mCF=ww@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jul 2023 23:15:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12506

Hi !

It's this week's CVE report.

This week reported 8 new CVEs and 5 updated CVEs.

CVE-2023-20593 is the Zenbleed vulnerability which is not a kernel
vulnerability.  However, the Linux kernel added mitigation code.
CVE-2023-2640 and CVE-2023-32629 are Ubuntu kernel specific
vulnerabilities, so mainline/stable/cip kernels aren't affected.

* New CVEs

CVE-2023-3611: net/sched: sch_qfq: account for stab overhead in qfq_enqueue

CVSS v3 score is not provided(NVD).
CVSS v3 score is not 7.8 HIGH(CNA).

An out-of-bounds write vulnerability in the Linux kernel's net/sched:
sch_qfq component can be exploited to achieve local privilege
escalation.
The qfq_change_agg() function in net/sched/sch_qfq.c allows an
out-of-bounds write because lmax is updated according to packet sizes
without bounds checks.

This bug was introduced by commit 462dbc9 ("pkt_sched: QFQ Plus
fair-queueing service at DRR cost") in 3.8-rc1.

Fixed status
mainline: [3e337087c3b5805fe0b8a46ba622a962880b5d64]
stable/5.15: [91d3554ab1fc2804c36a815c0f79502d727a41e6]
stable/6.1: [70feebdbfad85772ab3ef152812729cab5c6c426]
stable/6.4: [bd2333fa86dc520823e8c317980b29ba91ee6b87]

CVE-2023-3776: net/sched: cls_fw: Fix improper refcount update leads
to use-after-free

CVSS v3 score is not provided(NVD).
CVSS v3 score is not 7.8 HIGH(CNA).

A use-after-free vulnerability in the Linux kernel's net/sched: cls_fw
component can be exploited to achieve local privilege escalation.
If tcf_change_indev() fails, fw_set_parms() will immediately return an
error after incrementing or decrementing the reference counter in
tcf_bind_filter().
If an attacker can control the reference counter and set it to zero,
they can cause the reference to be freed, leading to a use-after-free
vulnerability.

This bug was introduced before 2.6.12. So all stable kernels are affected.

Fixed status
mainline: [0323bce598eea038714f941ce2b22541c46d488f]
stable/5.15: [5b55f2d6ef403fcda93ae4eb4d8c1ba164c66e92]
stable/6.1: [c91fb29bb07ee4dd40aabd1e41f19c0f92ac3199]
stable/6.4: [0a2e3f49febda459252f58cec2d659623d582800]

CVE-2023-3863: net: nfc: Fix use-after-free caused by nfc_llcp_find_local

CVSS v3 score is not provided(NVD).
CVSS v3 score is not 6.4 MEDIUM(CNA).

A use-after-free flaw was found in nfc_llcp_find_local in
net/nfc/llcp_core.c in NFC in the Linux kernel.
This flaw allows a local user with special privileges to impact a
kernel information leak issue.

This patch fixes 52feb44 ("NFC: Extend netlink interface for LTO, RW,
and MIUX parameters support") in 3.8-rc1 and
c7aa122 ("NFC: Take a reference on the LLCP local pointerwhen creating
a socket") in 3.6-rc1.
So all stable kernels affect this bug.

Fixed status
mainline: [6709d4b7bc2e079241fdef15d1160581c5261c10]
stable/5.15: [fc8429f8d86801f092fbfbd257c3af821ac0dcd3]
stable/6.1: [425d9d3a92df7d96b3cfb7ee5c240293a21cbde3]
stable/6.4: [e5207c1d69b1a9707615ab6ff9376e59fc096815]

CVE-2023-20593: =E2=80=9CZen 2=E2=80=9D CPUs, under specific microarchitect=
ural
circumstances, may allow an attacker to potentially access sensitive
information

CVSS v3 score is not provided.

An issue in =E2=80=9CZen 2=E2=80=9D CPUs, under specific microarchitectural
circumstances, may allow an attacker to potentially access sensitive
information. This bug is added a name called Zenbleed.
You can find more details from https://lock.cmpxchg8b.com/zenbleed.html .

This is not a kernel issue. However, linux kernel mitigates zenbleed
vulnerability.

Fixed status
mainline: [522b1d69219d8f083173819fde04f994aa051a98]
stable/4.19: [cfef7bbf0dca27209ea5d82d7060d4fc2c0d72ea]
stable/5.10: [93df00f9d48d48466ddbe01a06eaaf3311ecfb53]
stable/5.15: [be824fdb827dc06f77a31122949fe1bc011e3e1e]
stable/5.4: [00363ef30797211c247605464dc3daaa988531a2]
stable/6.1: [ed9b87010aa84c157096f98c322491e9af8e8f07]
stable/6.4: [9b8bb5c4e25678af895dc9dd4a1e82b2f948cacc]

CVE-2023-3772: xfrm: add NULL check in xfrm_update_ae_params

CVSS v3 score is not provided(NVD).
CVSS v3 score is not 5.5 MEDIUM(CNA).

A flaw was found in the Linux kernel=E2=80=99s IP framework for transformin=
g
packets (XFRM subsystem).
This issue may allow a malicious user with CAP_NET_ADMIN privileges to
directly dereference a
NULL pointer in xfrm_update_ae_params(), leading to a possible kernel
crash and denial of service.

This bug was introduced by commit d8647b79c3b7 ("xfrm: Add user
interface for esn and big anti-replay windows") in 2.6.39-rc1.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/netdev/20230721145103.2714073-1-linma@zju.edu.cn/

CVE-2023-3773: xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH

CVSS v3 score is not provided(NVD).
CVSS v3 score is not 5.5 MEDIUM(CNA).

A flaw was found in the Linux kernel=E2=80=99s IP framework for transformin=
g
packets (XFRM subsystem).
This issue may allow a malicious user with CAP_NET_ADMIN privileges to
cause a 4 byte out-of-bounds
read of XFRMA_MTIMER_THRESH when parsing netlink attributes, leading
to potential leakage of sensitive
heap data to userspace.

This bug was introduced by commit 4e484b3e969b ("xfrm: rate limit SA
mapping change message to user space") in 5.17-rc1.
This patch was backported to 5.15 and 5.10, so these kernels are also affec=
ted.
Linux 5.4, 4.19, 4.14 and 4.4 are not affected.

Fixed status
Patch is available but it hasn't been merged yet.
https://lore.kernel.org/all/20230723074110.3705047-1-linma@zju.edu.cn/T/#u

CVE-2023-2640: An unprivileged user may set privileged extended
attributes on the mounted files in ubuntu kernels

CVSS v3 score is not provided(NVD).
CVSS v3 score is not 7.8 HIGH(CNA).

On Ubuntu kernels carrying both c914c0e27eb0 and "UBUNTU: SAUCE:
overlayfs: Skip permission checking for trusted.overlayfs.* xattrs",
an unprivileged user may set privileged extended attributes on the
mounted files, leading them to be set on the upper files
without the appropriate security checks.

This CVE is ubuntu kernel specific, so mainline/stable/cip kernels
aren't affected.

CVE-2023-32629: Local privilege escalation vulnerability in Ubuntu
Kernels overlayfs

CVSS v3 score is not provided(NVD).
CVSS v3 score is not 7.8 HIGH(CNA).

Local privilege escalation vulnerability in Ubuntu Kernels overlayfs
ovl_copy_up_meta_inode_data skip permission checks when calling
ovl_do_setxattr on Ubuntu kernels.

This CVE is ubuntu kernel specific, so mainline/stable/cip kernels
aren't affected.

* Updated CVEs

CVE-2022-48502: fs/ntfs3: Check fields while reading

Stable 5.15 and 6.1 were fixed.

Fixed status
mainline: [0e8235d28f3a0e9eda9f02ff67ee566d5f42b66b]
stable/5.15: [333feb7ba84f69f9b423422417aaac54fd9e7c84]
stable/6.1: [000a9a72efa4a9df289bab9c9e8ba1639c72e0d6]

CVE-2023-2898: f2fs: fix to avoid NULL pointer dereference f2fs_write_end_i=
o()

Stable 5.15 was fixed.

Fixed status
mainline: [d8189834d4348ae608083e1f1f53792cfcc2a9bc]
stable/5.15: [982c29e0d27a48d65fd0fa0d1bcee501eeb06e76]
stable/6.1: [ebe83e9bb8a6b3db28603fe938ee80ccaa01ed53]
stable/6.4: [5619e9aabbd2b369cde2114ad6f55f6eb3e0b5be]

CVE-2023-31248: nf_tables UAF when using nft_chain_lookup_byid

Stable 5.15 was fixed.

Fixed status
mainline: [515ad530795c118f012539ed76d02bacfd426d89]
stable/5.15: [041e2ac88caef286b39064e83e825e3f53113d36]
stable/6.1: [fc95c8b02c6160936f1f3d8d9d7f4f66f3c84b49]
stable/6.4: [5e5e967e8505fbdabfb6497367ec1b808cadc356]

CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write

Stable 5.15 was fixed.

Fixed status
mainline: [caf3ef7468f7534771b5c44cd8dbd6f7f87c2cbd]
stable/5.15: [870dcc31c0cf47cb15a568ade4168dc644b3ccfb]
stable/6.1: [40f83dd66a823400d8592e3b71e190e3ad978eb5]
stable/6.4: [b79c09c2bf2d7643902a6ef26152de602c5c5e4b]

CVE-2023-38432: OOB read bug was found in the ksmbd subsystem

Stable 5.15 was fixed.

Fixed status
mainline: [2b9b8f3b68edb3d67d79962f02e26dbb5ae3808d]
stable/5.15: [35f450f54dca1519bb24faacd0428db09f89a11f]
stable/6.1: [9650cf70ec9d94ff34daa088b643229231723c26]

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

