Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E105FC4332F
	for <webhook@archiver.kernel.org>; Thu,  7 Apr 2022 15:41:13 +0000 (UTC)
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by mx.groups.io with SMTP id smtpd.web10.531.1649289070111600049
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 16:51:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=ot+VHE5v;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.44,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f44.google.com with SMTP id
 o20-20020a9d7194000000b005cb20cf4f1bso2801924otj.7
        for <cip-dev@lists.cip-project.org>;
 Wed, 06 Apr 2022 16:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=YMj4gBarHc+UI6xcHj/F0ZkNBAJGCxjYzh9xmoYOkio=;
        b=ot+VHE5vUITWSjYcWqweh5BJWe2s+9RApmFEnTKtSGb7bkreR5hEIrIdYtxZUYcOAE
         fVnRrdjf/ESX5LjCtHeZsFnejcveqgJX7cbYKOaiLL0I0d1hSGP3+d6oCPSm6pjMwmKb
         0Iju2m/H9CVoRXgnxR/ainDYWx81A544DqM3/hCX8BTkDneBXtOxSBoum9Y3yJfJhfGG
         xoMARuedPMpplsSwZcRkI6Fo8GidINbiocovPc4Trw6HZW2lYS3lw0LZUW9boBDCgK4L
         loTmyxa+YZrjwDNQ/n1C3UydZj96A/oIzabiAvTTQ+HkSV2285mdzNj1Ig5oT1sKINvl
         qW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=YMj4gBarHc+UI6xcHj/F0ZkNBAJGCxjYzh9xmoYOkio=;
        b=A+xsJjK2aR3yYckAc+cjmPz9eatM2R9RJfovTHKdvqM2neEUBavYpati9jWplDD0+r
         AI19+9klt6qK43MHvq/PBZPTzUApSEo/ZpWQl/DFTRDoyNj/eoAew6ip6LysTcHIKOha
         VKF5PL9VLpsO9cPRQzkcqkyancDBmgSLYpK4hXP0W8SNygk8eEvRBegnTrQaPbc8u3ih
         OwJBrldWkLF6t2aZgKE6FDZSeEZYFvuifZfRDT2bsynvOchtMOlwfYa/K8WPTFY4zsta
         rd5KDhfhnVv3T29kwvLX3tLZdOxQbR1LcWhm3OAKX1h4go0sNCvAJ3QCRqqPS5QcVMcH
         FPaw==
X-Gm-Message-State: AOAM530JVzXmoWlx1SN1hOuMqljwSSVnzohvTIvBU5OYh1gEYgB6B4b4
	FNaTeCdfBv1ZWdunVa9FOEiWmop6RblmxxvdD9SmY5fNOP3wrQ==
X-Google-Smtp-Source: 
 ABdhPJzQ/URHmDOKk9TpAr9MMw+cFkXPs2BvCOsT9FAVrZm6b0O3ydOfuMbFsd+5D2RgrGR6+Wzx5mi3K0Ad9BTU+08=
X-Received: by 2002:a05:6830:1b74:b0:5e6:97b2:4173 with SMTP id
 d20-20020a0568301b7400b005e697b24173mr3820053ote.336.1649289068800; Wed, 06
 Apr 2022 16:51:08 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 7 Apr 2022 08:50:33 +0900
Message-ID: 
 <CAODzB9pYw3mGHfhfD2cxh5UV-QnmZXr3+J2wDTuVC_5m4c8d5Q@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Apr 2022 15:41:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8016

Hi !

It's this week's CVE report.

This week reported 11 new CVEs and 1 updated CVE.
There are three can/usb driver bugs and three ax25 protocol bugs.

* New CVEs

CVE-2021-3714: Remote Page Deduplication Attacks

CVSS v3 score is not provided

Red hat bugzilla describes that an attacker can leak information via this issue.

Fixed status

Not fixed yet.

CVE-2022-1198: use-after-free in drivers/net/hamradio/6pack.c

CVSS v3 score is not provided

An UAF bug was found in drivers/net/hamradio/6pack.c . An attacker is
able to crash system by this vulnerability.
This bug looks to exist in 5.10, 4.19, and 4.4 kernels. However,
backpoting this patch requires fixing conflicts.

Fixed status

mainline: [efe4186e6a1b54bf38b9e05450d43b0da1fd7739]
stable/5.16: [4356343fb70c899901bce33acedf4fede797d21f]

CVE-2022-1199: Null pointer dereference and use-after-free in ax25_release()

CVSS v3 score is not provided

An UAF bug was found in net/ax25/af_ax25.c. An attacker is able to
crash system by this vulnerability.

Patches were merged in the mainline by following order.

2022-03-09: ax25: Fix NULL pointer dereference in
ax25_kill_by_device(71171ac8eb34ce7fe6b3267dce27c313ab3cb3ac)
2022-02-09: ax25: fix NPD bug in
ax25_disconnect(7ec02f5ac8a5be5a3f20611731243dc5e1d9ba10)
2022-01-28: ax25: improve the incomplete fix to avoid UAF and NPD
bugs(4e0f718daf97d47cf7dec122da1be970f145c809)

Commit 7ec02f5 ("fix NPD bug in ax25_disconnect") changed releasing
order to sock struct to avoid NULL pointer dereference if sk is NULL.
- release_sock(sk);
  ax25_disconnect(s, ENETUNREACH);
+ release_sock(sk);

However, commit 71171ac ("ax25: Fix NULL pointer dereference in
ax25_kill_by_device") added NULL pointer check before releasing sock
struct.

+ if (!sk) {
+ spin_unlock_bh(&ax25_list_lock);
+ s->ax25_dev = NULL;
+ ax25_disconnect(s, ENETUNREACH);
+ spin_lock_bh(&ax25_list_lock);
+ goto again;
+ }

So, it looks like commit 7ec02f5 ("fix NPD bug in ax25_disconnect") is
not needed to fix this CVE to older kernels.
Additionally commit 7ec02f5 is the route cause of CVE-2022-1205.

v4.4 looks to be affected by this CVE.

Fixed status

mainline: [4e0f718daf97d47cf7dec122da1be970f145c809,
7ec02f5ac8a5be5a3f20611731243dc5e1d9ba10,
  71171ac8eb34ce7fe6b3267dce27c313ab3cb3ac]
stable/4.19: [3072e72814de56f3c674650a8af98233ddf78b19,
5ab8de9377edde3eaf1de9872e2f01d43157cd6c]
stable/4.9: [851901d339b2ba766ffcf754d37a6f52fa07cea2,
cad71f1094834eb69f7ceec8100d300c26b43053]
stable/5.10: [b9a229fd48bfa45edb954c75a57e3931a3da6c5f,
e2201ef32f933944ee02e59205adb566bafcdf91]


CVE-2022-1204: UAF caused by binding operation when ax25 device is detaching

CVSS v3 score is not provided

An UAF bug was found in net/ax25/af_ax25.c. An attacker is able to
crash system by this vulnerability.

Patches were merged in the following order.

2022-03-29: ax25: fix UAF bug in
ax25_send_control(5352a761308397a0e6250fdc629bb3f615b94747) fixes
9fd75b6
2022-03-21: ax25: Fix refcount leaks caused by
ax25_cb_del(9fd75b66b8f68498454d685dc4ba13192ae069b0) fixes d01ffb9,
87563a0, and feef318
2022-02-09: ax25: fix UAF bugs of net_device caused by rebinding
operation(feef318c855a361a1eccd880f33e88c460eb63b4)
2022-02-03: ax25: fix reference count leaks of
ax25_dev(87563a043cef044fed5db7967a75741cc16ad2b1) fixes d01ffb9
2022-01-28: ax25: add refcount in ax25_dev to avoid UAF
bugs(d01ffb9eee4af165d83b08dd73ebdf9fe94a519b)

It looks like the route cause is commit d01ffb ("ax25: add refcount in
ax25_dev to avoid UAF bugs"). It was merged in 5.17-rc3. This commit
isn't backported to stable kernels. So, stable kernels seem not to be
affected by this CVE.

Fixed status

mainline: [d01ffb9eee4af165d83b08dd73ebdf9fe94a519b,
87563a043cef044fed5db7967a75741cc16ad2b1,
  feef318c855a361a1eccd880f33e88c460eb63b4,
9fd75b66b8f68498454d685dc4ba13192ae069b0,
  5352a761308397a0e6250fdc629bb3f615b94747]


CVE-2022-1205: Null pointer dereference and use-after-free in
net/ax25/ax25_timer.c

CVSS v3 score is not provided

A Null pointer dereference and use after free in net/ax25/ax25_timer.c.
An attacker is able to crash the system by this vulnerability.

This bug was introduced by commit 7ec02f5 ("ax25: fix NPD bug in
ax25_disconnect") which was merged in 5.17-rc4. This commit isn't
backported to stable kernels so that this bug only affects the
mainline kernel.

Fixed status

mainline: [fc6d01ff9ef03b66d4a3a23b46fc3c3d8cf92009,
82e31755e55fbcea6a9dfaae5fe4860ade17cbc0]

CVE-2022-28356: llc: fix netdevice reference leaks in llc_ui_bind()

CVSS v3 score is not provided

A refcount leak bug was found in net/llc/af_llc.c.

This bug was introduced before git era.
Patch can be applied to 4.4-st.

Fixed status

mainline: [764f4eb6846f5475f1244767d24d25dd86528a4a]
stable/4.14: [0f294bc04be87f1c9e1d1a908db9fcc84ce94210]
stable/4.19: [d14193111c436fc5de33206c67c7afd45c730099]
stable/4.9: [0a7aad979bfb43c4a78d33a5f356caf4ceb28bca]
stable/5.10: [571df3393f523b59cba87e2f3e80a3a624030f9c]
stable/5.15: [e9072996108387ab19b497f5b557c93f98d96b0b]
stable/5.16: [6f5bf395c60ed2643de51f2b1041cb0882e9d97f]
stable/5.17: [ef1a6fe3563cf47ce4fd555727ca80085cf18884]
stable/5.4: [572f9a0d3f3feb8bd3422e88ad71882bc034b3ff]

CVE-2022-28388: can: usb_8dev: usb_8dev_start_xmit(): fix double
dev_kfree_skb() in error path

CVSS v3 score is not provided

A double free bug was found in usb_8dev_start_xmit() in
drivers/net/can/usb/usb_8dev.c.

Applying this fix to 4.4, it needs to modify the patch to fix conflict.

Fixed status

mainline: [3d3925ff6433f98992685a9679613a2cc97f3ce2]

CVE-2022-28389: can: mcba_usb: mcba_usb_start_xmit(): fix double
dev_kfree_skb in error path

CVSS v3 score is not provided

A double free bug in mcba_usb_start_xmit() in drivers/net/can/usb/mcba_usb.c.
This bug was introduced by commit 51f3baa ("can: mcba_usb: Add support
for Microchip CAN BUS Analyzer") which was merged in 4.12-rc1.
So, 4.9 and 4.4 kernels aren't affected by this issue.

Fixed status

mainline: [04c9b00ba83594a29813d6b1fb8fdc93a3915174]

CVE-2022-28390: can: ems_usb: ems_usb_start_xmit(): fix double
dev_kfree_skb() in error path

CVSS v3 score is not provided

A double free bug in ems_usb_start_xmit() in drivers/net/can/usb/ems_usb.c.
This patch can be applied to 4.4.y without any errors.

Fixed status

mainline: [c70222752228a62135cee3409dccefd494a24646]

CVE-2021-39802: The most severe vulnerability in this section could
lead to local escalation of privilege with no additional execution
privileges needed. User interaction is not needed for exploitation

CVSS v3 score is not provided

ac44888: Revert "FROMGIT: mm: improve mprotect(R|W) efficiency on
pages referenced once"
b44e46b: FROMGIT: mm: improve mprotect(R|W) efficiency on pages referenced once
67d075d: Revert "FROMGIT: mm: improve mprotect(R|W) efficiency on
pages referenced once"
6f9aba5: FROMGIT: mm: improve mprotect(R|W) efficiency on pages referenced once

Commit ac44888 reverts b44e46b and commit 67d075d reverts 6f9aba5.
These commits aren't in the mainline.
It seems as if this vulnerability android kernel specific.

Fixed status

Fixed in android kernel

CVE-2021-0707: dmabuf: fix use-after-free of dmabuf's file->f_inode

CVSS v3 score is not provided

An UAF bug was found in dma_buf_release().
This bug was introduced by commit 4ab59c3 ("dma-buf: Move
dma_buf_release() from fops to dentry_ops") which was merged in
v5.8-rc4.
The commit 4ab59c3 ("dma-buf: Move dma_buf_release() from fops to
dentry_ops") fixes bb2bb90 ("dma-buf: add DMA_BUF_SET_NAME ioctls")
which was merged in 5.3-rc1. Therefore, kernel 4.4, 4.9, and 4.19 are
not affected by this vulnerability.
This vulnerability was fixed in 5.11-rc3. The mainline and stable
kernels are fixed.

Fixed status

mainline: [05cd84691eafcd7959a1e120d5e72c0dd98c5d91]
stable/5.10: [a19dae4254c434a1ac8937a809fe08fd15ad3be5]
stable/5.4: [ef8133b1b47ed67873c291e9248fafd428d1767d]

* Updated CVEs

CVE-2021-33061: Intel(R) 82599 Ethernet Controllers and Adapters may
allow an authenticated user to potentially
enable denial of service via local access

Fixed in 5.18-rc1.

This patch can't be applied to 4.4.y because it modifies
ixgbe_priv_flags_strings(), ixgbe_get_priv_flags(), and
ixgbe_set_priv_flags() in
drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c but 4.4.y doesn't
have these functions and drivers/net/ethernet/intel/ixgbe/ixgbe.h
doesn't contain IXGBE_FLAG2_ macros in it.

Fixed status

mainline: [008ca35f6e87be1d60b6af3d1ae247c6d5c2531d]

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

