Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B264C433EF
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 23:52:05 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mx.groups.io with SMTP id smtpd.web10.21781.1643241123195687539
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 15:52:04 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=D079pJes;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.177,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f177.google.com with SMTP id s127so2777823oig.2
        for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 15:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=65iDMBiSSyRsfrS3ghQpVIbSx+mJjQm96Qzsd1Be2m0=;
        b=D079pJes+mjRQLypQwQDmFbg2jVEK7e/7vrYUzMtvRs9SmExRfuX2v9ynaBb+/T09q
         fN6ckHSd9SH4nXOhXiqYm76N/3zBy3HP9WgTj5CaCMrwR4CFPRyqidAWflGUULYpVbvC
         cJN3gde1uEq1YszAb5lvUPozJf3jc96KwYNgw+nF0d+4ZMeSEU4tWHeYDGptR2Bp+SHB
         bE5URMLg4WrUDa8gXueS+MzqOIFsrtMl+1J5FcmYeMlaU0CtNd8jEcX/e7PY2Y6d5OmE
         jrBO5Y5lL5IOsObST5NDQF2H9Am0L78bQ2aQQZ/KVnSjanoYhkrtlF6n3YlJ9NAxIPwE
         IzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=65iDMBiSSyRsfrS3ghQpVIbSx+mJjQm96Qzsd1Be2m0=;
        b=zmQNAm+hX75fpf7P+mMEcLC+8hslDFq1jm2CtuiEHvYVrb8J8xpzp4NmfxdjVDem/W
         cNc0RueJeCHT4GXlvpOXLAVo7YzADATd9vxpzPvOMPm0t7yKWnb6dQUKA+F8IyAJItsv
         JuqUOYS9/aQziUQnBgJXy2QzIEFmZQjqaLhBK7xWFuJIc2KeBISQql8QZYYwR0zn/85w
         PPWsz1XOciL75Dczdik4Y5HIQN1eAPMWTkmjsgYg3u2A14ghxADj/rQ5pT7N7OVqiaVt
         WJSBfNtSVPqVFxavctiadwhI0DA4AqR6LYRHzJsYXm/YnclraYA2nmHpN6qiQeJb3C1j
         BGbw==
X-Gm-Message-State: AOAM530Gmhe+oBRorqnJrmMBfL5yT560EBhbqIH6gqt3sM5u/00P67nQ
	Hedt5VjuA9w7OSUSAteTCnUcXWcKPz9wtfQejNjsqbwCp7I6Bg==
X-Google-Smtp-Source: 
 ABdhPJw+xOWTOyEqyz1abzH+hxLCtJFI3Npa0pmw5eabu7bP0+WdNs0WNALzAcqkUXPXo2C4oC1JFMlQO8Jc6ltWaiM=
X-Received: by 2002:aca:1c17:: with SMTP id c23mr5303401oic.137.1643241122076;
 Wed, 26 Jan 2022 15:52:02 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Jan 2022 08:51:26 +0900
Message-ID: 
 <CAODzB9oLrBx-866T7ywB4CT4o4Nvkk8WrH-X+DGzsSMt=NswGA@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 23:52:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7494

Hi !

It's this week's CVE report.

This week reported 4 new CVEs.

* New CVEs

CVE-2022-0322: sctp: account stream padding length for reconf chunk

CVSS v3 score is not provided

This issue was introduced by commit cc16f00 ("sctp: add support for
generating stream reconf ssn reset request chunk") at 4.11-rc1 so 4.9
and 4.4 aren't affected by this issue. All kernels have been fixed.

Fixed status

mainline: [a2d859e3fc97e79d907761550dbc03ff1b36479c]
stable/4.14: [41f0bcc7d9eac315259d4e9fb441552f60e8ec9e]
stable/4.19: [c57fdeff69b152185fafabd37e6bfecfce51efda]
stable/5.10: [d84a69ac410f6228873d05d35120f6bdddab7fc3]
stable/5.4: [d88774539539dcbf825a25e61234f110513f5963]

CVE-2022-0264: bpf: Fix kernel address leakage in atomic fetch

CVSS v3 score is not provided

A local user who has certain privileges is able to gather kernel
internal memory addresses.
This issue was introduced by commit 38086bf ("bpf: Propagate stack
bounds to registers in atomics w/ BPF_FETCH") that was merged in
5.12-rc1-dontuse. Fixed in 5.17-rc1. so before 5.12 kernels aren't
affected this issue.

Fixed status

mainline: [7d3baf0afa3aa9102d6a521a8e4c41888bb79882]
stable/5.15: [423628125a484538111c2c6d9bb1588eb086053b]

CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store

CVSS v3 score is not provided

Vulnerability in the i915 driver. Without an active IOMMU malicious
userspace can gain access (from the
code executing on the GPU) to random memory pages.

Fixed status

mainline: [7938d61591d33394a21bdd7797a245b65428f44c]

CVE-2021-22600: net/packet: rx_owner_map depends on pg_vec

CVSS v3 score: NIST: not provided
CVSS v3 score: CNA: 6.6 medium

A double free bug in packet_set_ring() in net/packet/af_packet.c can
be exploited by a local user through crafted syscalls to escalate
privileges or deny service.
This issue was introduced by commit 61fad68 ("net/packet: tpacket_rcv:
avoid a producer race condition"). This commit was merged in 5.6.
However, it was backported to 5.4, 4.19, and 4.14 so that these
kernels are also affected but 4.4 and 4.9 are not backported.

Fixed status

mainline: [ec6af094ea28f0f2dda1a6a33b14cd57e36a9755]
stable/4.14: [a829ff7c8ec494eca028824628a964cde543dc76]
stable/4.19: [18c73170de6719491f79b04c727ea8314c246b03]
stable/5.10: [7da349f07e457cad135df0920a3f670e423fb5e9]
stable/5.15: [feb116a0ecc5625d6532c616d9a10ef4ef81514b]
stable/5.4: [027a13973dadb64ef4f19db56c9b619ee82c3375]

* Updated CVEs

CVE-2022-0185: vfs: fs_context: fix up param length parsing in
legacy_parse_param

This issue was affected from 5.8 or later kernels so that all stable
kernels have been fixed.

Fixed status

mainline: [722d94847de29310e8aa03fcbdb41fc92c521756]
stable/5.10: [eadde287a62e66b2f9e62d007c59a8f50d4b8413]
stable/5.15: [e192ccc17ecf3e78a1c6fb81badf9b50bd791115]
stable/5.16: [8b1530a3772ae5b49c6d8d171fd3146bb947430f]
stable/5.4: [bd2aed0464ae3d6e83ce064cd91fc1a7fec48826]

CVE-2021-43976: mwifiex_usb: Fix skb_over_panic in mwifiex_usb_recv

An attacker who can connect a crafted USB device to cause a DoS by this issue.
Fixed in the mainline.

Fixed status

mainline: [04d80663f67ccef893061b49ec8a42ff7045ae84]

CVE-2021-45469: f2fs: fix to do sanity check on last xattr entry in
__f2fs_setxattr()

Fixed in the mainline this week. For 4.4, commit ba38c27 ("f2fs:
enhance lookup xattr") and commit 2777e65 ("f2fs: fix to avoid
accessing xattr across the boundary"), and more patches are also
needed.

Fixed status

mainline: [645a3c40ca3d40cc32b4b5972bf2620f2eb5dba6]
stable/4.14: [88dedecc24763c2e0bc1e8eeb35f9f2cd785a7e5]
stable/4.19: [f9dfa44be0fb5e8426183a70f69a246cf5827f49]
stable/5.10: [fffb6581a23add416239dfcf7e7f3980c6b913da]
stable/5.15: [a8a9d753edd7f71e6a2edaa580d8182530b68791]
stable/5.4: [b0406b5ef4e2c4fb21d9e7d5c36a0453b4279e9b]

CVE-2021-4204: eBPF Improper Input Validation Vulnerability

The mainline kernel was fixed this week.

A local attacker can escalate privileges via this bug.
This bug is affecting the 5.8 or later kernel. The commit 457f4436
("bpf: Implement BPF ring buffer and verifier support for it")
introduced this issue.

To mitigate this issue, set kernel.unprivileged_bpf_disabled to 1.


Fixed status

mainline: [be80a1d3f9dbe5aee79a325964f7037fe2d92f30,
d400a6cf1c8a57cdf10f35220ead3284320d85ff,
  6788ab23508bddb0a9d88e104284922cb2c22b77,
64620e0a1e712a778095bd35cbb277dc2259281f,
  a672b2e36a648afb04ad3bda93b6bda947a479a5,
722e4db3ae0d52b2e3801280afbe19cf2d188e91,
  37c8d4807d1b8b521b30310dce97f6695dc2c2c6]


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

