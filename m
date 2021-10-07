Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B450C433EF
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 00:59:50 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web12.5203.1633568387678644373
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 17:59:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=X4zTXDtT;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.177,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f177.google.com with SMTP id n63so6590443oif.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 17:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=F7C7cJy5mmdc8/szrrcV50cHCZ9/TaSHHkD8sVHvTjY=;
        b=X4zTXDtTKGpx7WzEatvz1vOLkDk+k8xglQkpOpJOedKGHg0PzzS4mY3SwgxenpBLbK
         ycqe2aHYAXYOKPRR+UehIx4qT0L8eQNnwwuqAUHVhyq2FeO7aTH0yyIqKW8xVQsYbfIz
         slhxPh3DYadih1mS9mcJ2kdda4LO8kMMhK8+o1CpudPLQdLj2Y7pIK1kPaUmBuTQ3dTM
         aqMQSZX5KGfaLLDzcC6KD+xKKCcCLZixlUWBIjvZOR75RdFbklKJwZPVd6gHsBZFaFAH
         FzeNGAxC12l/ibNa+pjT7G4y8skG24z4cSd5aTckjKqH2EoRMayS0IbjaEIl6hMtIXos
         UVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=F7C7cJy5mmdc8/szrrcV50cHCZ9/TaSHHkD8sVHvTjY=;
        b=bxYEImWmTPkHtbAOqQQwlG/urL+neh05q6POavogHI5uiommoxNKrLRaL7grIO3ksT
         c9j/MBNY3Ljy5T0s8/7ISWPyjy1fgn/6Pzg2p5w21YCQ9UWZuSN0qpekVuugQ/0d57ZL
         8+4Bio7rCR/3V32FJJYG/XwENe5pppyzQgmjPjgcDRMnPkTTNA9DHBxcJBf8oojbquHg
         KkyUPEF8inkJ2mHulnaFvWeP5pAKNIsBD8yBBzWD4PYEn83ad1/60yciaNV3LRiJcGtR
         nHZg6LCpKr07nBH9KjAMei+eZd2Ml3mxAmVqlHv6v75wTyOJHO69Bwcdqr7VFmkysrDH
         k2Ow==
X-Gm-Message-State: AOAM531s5YdFdLVSRBfaLhlhrMnMWCVHP4pvFuc2X02VitRnh7ORCUxu
	6ksoG3Kn5lKTaulNOuJYUPwW97xXXurgb9YxaBoay2AbhdQDOA==
X-Google-Smtp-Source: 
 ABdhPJwWz8jF1/9Noo7VopuRQNr0CihE6RZKBjUVkiPTYm20GM+yyx/QCdhsiWeMUGQz3A6udKWxizCo54+DnxXAF1U=
X-Received: by 2002:aca:3192:: with SMTP id x140mr771397oix.66.1633568386341;
 Wed, 06 Oct 2021 17:59:46 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Oct 2021 09:59:10 +0900
Message-ID: 
 <CAODzB9rKixC0p_tFV=qR7sTgPqS1ZxuXJJnkPufW+z-m8NFHxA@mail.gmail.com>
Subject: New CVE entry this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Oct 2021 00:59:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6798

Hi !

It's this week's CVE report.

This week reported  new CVEs.

* New CVEs

CVE-2021-41864: bpf: Fix integer overflow in prealloc_elems_and_freelist()

CVSS v3 score is not provided.

Patch 30e29a9a2bc6 (bpf: Fix integer overflow in prealloc_elems_and_freelist()
) fixes commit 557c0c6e7df8 ("bpf: convert stackmap to
pre-allocation") which has been introduced in 4.6-rc1. Therefore 4.4
kernel isn't affected this issue.

For 4.19 and 5.4, patch can be applied by "git am". For 4.9, patch can
be applied by "git am -3".

Fixed status

Fix patch has been merged into bpf tree, but not in the mainline yet.

CVE-2021-42008: net: 6pack: fix slab-out-of-bounds in decode_data

The 6pack module has slab out-of-bounds vulnerability in decode_data()
which allow local attacker can gain their privileges.
This bug has been fixed since 5.14-rc7. All stable kernels have
already been fixed.

Fixed status

cip/4.19: [4e370cc081a78ee23528311ca58fd98a06768ec7]
cip/4.19-rt: [4e370cc081a78ee23528311ca58fd98a06768ec7]
cip/4.4: [d66736076bd84742c18397785476e9a84d5b54ef]
cip/4.4-rt: [d66736076bd84742c18397785476e9a84d5b54ef]
mainline: [19d1532a187669ce86d5a2696eb7275310070793]
stable/4.14: [5e0e782874ad03ae6d47d3e55aff378da0b51104]
stable/4.19: [4e370cc081a78ee23528311ca58fd98a06768ec7]
stable/4.4: [d66736076bd84742c18397785476e9a84d5b54ef]
stable/4.9: [de9171c1d9a5c2c4c5ec5e64f420681f178152fa]
stable/5.10: [85e0518f181a0ff060f5543d2655fb841a83d653]
stable/5.4: [a73b9aa142691c2ae313980a8734997a78f74b22]

* Updated CVEs

CVE-2019-19449: mounting a crafted f2fs filesystem image can lead to
slab-out-of-bounds read access in f2fs_build_segment_manager in
fs/f2fs/segment.c

This patch has been merged since 5.10-rc1.
For 5.4, patch can be applied via git-am. For 4.4 and 4.19, patch can
be applied via git-am with -3 option.

Fixed status

mainline: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]
stable/5.10: [3a22e9ac71585bcb7667e44641f1bbb25295f0ce]

CVE-2021-37159: net: hso: do not call unregister if not registered

4.14, 4.19, and 5.4 have been fixed. 4.4 and 4.9 haven't been fixed
yet. However, patch can be applied to 4.4 and 4.9 without any
modification. According to cip-kernel-config, no CIP member use HSO
module.

Fixed status

mainline: [a6ecfb39ba9d7316057cea823b196b734f6b18ca]
stable/4.14: [4c0db9c4b3701c29f47bac0721e2f7d2b15d8edb]
stable/4.19: [f6cf22a1ef49f8e131f99c3f5fd80ab6b23a2d21]
stable/5.10: [115e4f5b64ae8d9dd933167cafe2070aaac45849]
stable/5.13: [eeaa4b8d1e2e6f10362673d283a97dccc7275afa]
stable/5.4: [fe57d53dd91d7823f1ceef5ea8e9458a4aeb47fa]

CVE-2021-38300: bpf, mips: Validate conditional branch offsets

This vulnerability is only affected to MIPS architecture. No cip
member use MIPS architecture.

5.10 has been fixed. Applying this fix to 4.4, 4.9, 4.19, and 5.4, it
needs to modify the patch.

Fixed status

mainline: [37cb28ec7d3a36a5bace7063a3dba633ab110f8b]
stable/5.10: [c61736a994fe68b0e5498e4e84e1c9108dc41075]

Currently tracking CVEs

CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in
Bluetooth Core Specifications 4.0 through 5.2

There is no fix information.

CVE-2021-3640: UAF in sco_send_frame function

Fixed in bluetooth-next tree.

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/net/bluetooth/sco.c?id=99c23da0eed4fd20cae8243f2b51e10e66aa0951

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

