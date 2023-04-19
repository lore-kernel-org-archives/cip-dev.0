Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C0C77B73
	for <webhook@archiver.kernel.org>; Wed, 19 Apr 2023 23:50:13 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web10.53770.1681948207042403927
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Apr 2023 16:50:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=kxxZGBzh;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6a5f03551fdso332861a34.0
        for <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 16:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1681948205; x=1684540205;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2DV3+KBArw62CoGA0NKKSIoOzxv9m2f5AJmhkWbL9CM=;
        b=kxxZGBzhEPGRWa9EplkivKu8N1aUNeCglQ6mQI0xh36xyUIa2p2GnOt6f1D7BNXTYu
         Zka4fVpNv608g5o2ZXiEfEXtlpzbtGbsjoGoZO+HYZRma5nFmkiBZrTSk5rDc5+pCJks
         WPQzm6tC0YUKvqEwVNmvBoAuwVEskQMFC70W9SNAslT2Jc4BCbx+Pj+u3P0eh3JF5Oiy
         7IAn+Z45a13yg9Y+DDkt2TMwQeianmZZV1Uqh25RD8KcHXnQpaNs943Siuhb3w15yRup
         GqJN98NXGNWLkD0fwx4x/N2lLvGYErlmyQrMxZQUMW2BM+K1QIpqKcL3OOlOZYVWI68D
         r51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681948205; x=1684540205;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2DV3+KBArw62CoGA0NKKSIoOzxv9m2f5AJmhkWbL9CM=;
        b=R1f8lxoBNK8+jRcYRBpBvwe9UZ8Wqhrij96gEPMvxYH9LbJ82Q2GSryAOWz9DQ45Ba
         npImQXz2is82CUZcvNDMiaitJH0FQF1DcGgkYI/BULzC9GWtByWYRIbSO/efes9fzOTg
         bJLW+ajpnJ+qht9GMTpQKCGPg92mrwQCVwe9LKys7yJVs9FIkwLes2hHA/yVcra6P5CT
         wCmnwA5+qUZ8uWlC3NfOV32U1OgkCZNW5F0SLQuS98QvgCwHofqQBm9QQoIuxaHqBCmL
         bdvZmA4vtkvWsXE6q/YS6F9IufoAUvl8CQZfAU7gNTsBiB9shFo1MHbmEQ+0ekvxul6A
         A/HA==
X-Gm-Message-State: AAQBX9dYsUcTd63uAj8vz7wwj5w+HzSaBJYUMq2wQrjl0Dtc0HfxzH2m
	/NzwMBM3/kBdXTU2plxbvg0tXLkOAQVAfRo049p0MlpHWYPmgwQGQi0=
X-Google-Smtp-Source: AKy350YrAAY4K7SaXFPZA7vq6kZoj9LZR9INz1CnkVdbranivhwbYTGV9/7Bdtf4UBQoPBXsFzE186AdxYta3GWYQUI=
X-Received: by 2002:a05:6870:c195:b0:18b:1d1a:87bc with SMTP id
 h21-20020a056870c19500b0018b1d1a87bcmr299258oad.10.1681948205378; Wed, 19 Apr
 2023 16:50:05 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Apr 2023 08:49:28 +0900
Message-ID: <CAODzB9p6MuyqPJeiEpun8CDR9+ZJ9PHhhWG-wyM7f7C0d=krwA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Apr 2023 23:50:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11237

Hi !

It's this week's CVE report.

This week reported 8 new CVEs and 2 updated CVEs.

* New CVEs

CVE-2023-1990: nfc: st-nci: Fix use after free bug in ndlc_remove due
to race condition

CVSS v3 score is 4.7 MEDIUM.

A use-after-free flaw was found in ndlc_remove in
drivers/nfc/st-nci/ndlc.c in the Linux Kernel. This flaw could allow
an attacker to crash the system due to a race problem.

This bug was introduced by commit 35630df ("NFC: st21nfcb: Add driver
for STMicroelectronics ST21NFCB NFC chip") in 3.17-rc1.
Kernel 4.4-cip, 4.4-cip-rt, and 4.4-st have been fixed.

Fixed status
mainline: [5000fe6c27827a61d8250a7e4a1d26c3298ef4f6]
stable/4.14: [2156490c4b7cacda9a18ec99929940b8376dc0e3]
stable/4.19: [3405eb641dafcc8b28d174784b203c1622c121bf]
stable/5.10: [43aa468df246175207a7d5d7d6d31b231f15b49c]
stable/5.15: [84dd9cc34014e3a3dcce0eb6d54b8a067e97676b]
stable/5.4: [b0c202a8dc63008205a5d546559736507a9aae66]
stable/6.1: [5e331022b448fbc5e76f24349cd0246844dcad25]
stable/6.2: [f589e5b56c562d99ea74e05b1c3f0eab78aa17a3]

CVE-2023-2002: bluetooth: Perform careful capability checks in hci_sock_ioctl()

CVSS v3 score is not provided.

An insufficient permission check bug was found in the Bluetooth
subsystem. This permission check logic checks task has proper
CAP_NET_ADMIN capability but not check socket opener's capability.
This insufficient permission check sets HCI sockets as trusted even if
the socket opener doesn't have proper capabilities.

This bug was exploitable by commit f81f5b2db869 ("Bluetooth: Send
control open and close messages for HCI raw sockets") in 4.9-rc1.
Kernel 4.4 doesn't contain this commit.

Fixed status
Patch is available on the linux-bluetooth mailing
list(https://lore.kernel.org/linux-bluetooth/20230416080251.7717-1-lrh2000@pku.edu.cn/)
but it hasn't been merged yet.

CVE-2023-30772: power: supply: da9150: Fix use after free bug in
da9150_charger_remove due to race condition

CVSS v3 score is not provided.

A use-after-free bug was found in the power subsystem. This bug
happened when removing the module which will call
da9150_charger_remove, there may be unfinished work which will make a
race condition bug then the use-after-free bug will occur.

Introduced by commit c1a281e ("power: Add support for DA9150 Charger")
in 4.1-rc1.

Fixed status
mainline: [06615d11cc78162dfd5116efb71f29eb29502d37]
stable/4.14: [bbf45f079f41efcf1e51bb65a0a45d2b31061bd5]
stable/4.19: [533d915899b4a5a7b5b5a99eec24b2920ccd1f11]
stable/5.10: [75e2144291e847009fbc0350e10ec588ff96e05a]
stable/5.15: [0fdb1cc4fe5255d0198c332b961bc4c1f8787982]
stable/5.4: [6fe078c2864b9defaa632733a5bae969b398b673]
stable/6.1: [47b2e1a67e6da172bb4cf69ef9dafde4458bde5f]
stable/6.2: [a7d686b36aa8021ee96128290ac3b58c4c1f6297]

CVE-2023-2008: Improper validation of array index was found in the
udmabuf device driver

CVSS v3 score is not provided.

A flaw was found in the Linux kernel's udmabuf device driver. The
specific flaw exists within a fault handler. The issue results from
the lack of proper validation of user-supplied data, which can result
in a memory access past the end of an array. An attacker can leverage
this vulnerability to escalate privileges and execute arbitrary code
in the context of the kernel.

This bug was introduced by commit 7b26e4e ("udmabuf: drop WARN_ON()
check.") in 4.20-rc1. This commit is not backported to 4.19, 4.14, and
4.4 so these kernels aren't affected.

Fixed status
mainline: [05b252cccb2e5c3f56119d25de684b4f810ba40a]
stable/5.10: [20119c1e0fff89542ff3272ace87e04cf6ee6bea]
stable/5.15: [5b45535865d62633e3816ee30eb8d3213038dc17]
stable/5.4: [c7bdaad9cbfe17c83e4f56c7bb7a2d87d944f0fb]

CVE-2023-0458: Half Spectre-v1 Gadget prlimit

CVSS v3 score is not provided.

A speculation bug was found in do_prlimit(). This bug will cause
leaking kernel memory to user space.
The CIP kernels and stable kernels were fixed.

Fixed status
mainline: [739790605705ddcf18f21782b9c99ad7d53a8c11]
stable/4.14: [291a0395bb298d0ef0bba21d2186f632e4b30053]
stable/4.19: [d3ee91e50a6b3c5a45398e3dcb912a8a264f575c]
stable/5.10: [9f8e45720e0e7edb661d0082422f662ed243d8d8]
stable/5.15: [f01aefe374d32c4bb1e5fd1e9f931cf77fca621a]
stable/5.4: [96b02125dd68d77e28a29488e6f370a5eac7fb1c]
stable/6.1: [91185568c99d60534bacf38439846103962d1e2c]

CVE-2023-0459: Spectre-v1 Usercopy Hardening

CVSS v3 score is not provided.

Missing speculation barriers causes a leaking kernel memory.
The 4.4 kernel _copy_from_user() implementation is different from
4.19 and later. So this patch can not be applied.
It seems as if the 4.4 kernel needs some barrier to prevent
speculation bug in other ways.

Fixed status
stable/4.14: [e0fbff18bbcee4f07d46bee172803fad63f6f4dd]
stable/4.19: [f8e54da1c729cc23d9a7b7bd42379323e7fb7979]
stable/5.10: [3b6ce54cfa2c04f0636fd0c985913af8703b408d]
stable/5.15: [41d8b591d70a7517293b23958a18452baf22588f]
stable/5.4: [6c750ed0367f6bf1b09c0c353a701781ee05dd22]
stable/6.1: [684db631a15779c8f3b2235d507efdfe6bb10278]
stable/6.2: [2c8ee21d78942cf48bc836612ad365fd6f06cfbb]

CVE-2023-2124: OOB access in the Linux kernel's XFS subsystem

CVSS v3 score is not provided.

A slab oob access bug was found in the XFS subsystem. It can cause a
DoS and potentially privilege
escalation.

The vulnerable function xlog_recover_buf_commit_pass2() has been
introduced by commit 1094d3f1 ("refactor log recovery buffer item
dispatch for pass2 commit functions") in 5.8-rc1. Before the commit
1094d3f1, this function was called xlog_recover_buffer_pass2().
In 4.4, 4.14, and 4.19,  the xlog_recover_buffer_pass2() is in the
fs/xfs/xfs_log_recover.c.

Fixed status
Patch is in the linux-next
tree(https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/fs/xfs?id=22ed903eee23a5b174e240f1cdfa9acf393a5210).
It hasn't been merged into the mainline yet.

CVE-2023-2162: scsi: iscsi_tcp: Fix UAF during login when accessing
the shost ipaddress

CVSS v3 score is not provided.

A use-after-free bug was found in the scsi driver code. When this bug
occured, kernel internal information will be leaked to the userspace.
4.4 kernels(-cip, -cip-rt, -st)  are already fixed.

Fixed status
mainline: [f484a794e4ee2a9ce61f52a78e810ac45f3fe3b3]
stable/4.14: [496af9d3682ed4c28fb734342a09e6cc0c056ea4]
stable/4.19: [6abd4698f4c8a78e7bbfc421205c060c199554a0]
stable/5.10: [9758ffe1c07b86aefd7ca8e40d9a461293427ca0]
stable/5.15: [0aaabdb900c7415caa2006ef580322f7eac5f6b6]
stable/5.4: [d4d765f4761f9e3a2d62992f825aeee593bcb6b9]
stable/6.1: [61e43ebfd243bcbad11be26bd921723027b77441]

* Updated CVEs

CVE-2023-1859: 9p/xen: Fix use after free bug in xen_9pfs_front_remove
due  to race condition

The mainline was fixed.

Fixed status
mainline: [ea4f1009408efb4989a0f139b70fb338e7f687d0]

CVE-2023-1380: wifi: brcmfmac: slab-out-of-bounds read in brcmf_get_assoc_ies()

Fixed in the mainline.

Fixed status
mainline: [0da40e018fd034d87c9460123fa7f897b69fdee7]

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

