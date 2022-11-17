Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDEEC433FE
	for <webhook@archiver.kernel.org>; Thu, 17 Nov 2022 00:12:29 +0000 (UTC)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
 by mx.groups.io with SMTP id smtpd.web11.1595.1668643948809485195
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Nov 2022 16:12:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=Za7/9ue0;
 spf=pass (domain: miraclelinux.com, ip: 209.85.166.174, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-il1-f174.google.com with SMTP id 7so146202ilg.11
        for <cip-dev@lists.cip-project.org>; Wed, 16 Nov 2022 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=57nYXafkeqn0W/XE9oGDXdO7jG97YoyiEXg0cM6prEY=;
        b=Za7/9ue0jsht1m/1tM+WOezt03shmYgKUwyInk9fI3BVLMQO8QnNGb77oNCyBBFj4K
         QMV9Fks/f3V1EwPB5D7qjQBFyJSemWAayASZUPbqZHcXi+0v6Z0KXUx8t0gZ6gUbPUug
         8TvCpPxMydGItCXi9jwxUQCc9apLre+UXvWTE4Vw4pp0JJeeNfHiGa2y5H/n51+lsuZN
         iMmqLTk/z4SfozPfp1AZPXC/BRE+/j5FpfoUTJ9DiLcF7xzHxBMSEx9C0aTw8XSM0e0I
         zTbhZdj8nVqKoC8uvdOpMr0rA29ka/+lNnkwg7yHuV8CUVyqyFh4Abd4EzUDG1h6beMn
         onCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=57nYXafkeqn0W/XE9oGDXdO7jG97YoyiEXg0cM6prEY=;
        b=HBDMuZxLkA5+cmwo7rEyKp2+lrAmf4nrIS/RNT2Vzsvh8e1Jn+HoXxwB90r4QXwwzu
         SzDKzk3Zn1qa4LEu1PbX8uMkiiTqrHLzuPlsG4V9kolwQjATUkx9SVNar5tOp/A0jPrR
         RWhvj5wAjoKyhULyTSkGJJY2/gANdW+25GpWFuiSrrjL45pmqO7OuvZA7t2m33uN515m
         FLL7tfXJZKkvkhCFfVeEDHeTKrfVnJ02NUcO8QWL1ibrlYQiSWjdic4RpuGhzlkvA7lw
         DPTocx2lV/UdxZjazpyWcvrFLHDurJv9DzJxM7GNBcauHB7Uer4UvskVG++toE3USYRA
         hG9A==
X-Gm-Message-State: ANoB5pkaBMOjj7J/bpOR8Uo4NLs+P6Dv8f+c/Ww+ai99L641No2O/qt7
	gWzDRgn+nm9zUypDUPwFER6/4FFQnZgaSujucf1Wf1OQZswWbw==
X-Google-Smtp-Source: AA0mqf7vOKwbVj/cqNaxfNL/xldOCN/Sz3gNGRTCqvWV4vNxhhCYoHZvIPcCmFtDYGgx7MHPGe49Lnu/ydDv6vhEC8I=
X-Received: by 2002:a05:6e02:4a3:b0:2fa:b811:ed3b with SMTP id
 e3-20020a056e0204a300b002fab811ed3bmr156504ils.288.1668643947347; Wed, 16 Nov
 2022 16:12:27 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 17 Nov 2022 09:11:50 +0900
Message-ID: <CAODzB9rSUrrApYp2RT2DbcE6ra4LViRMqVhv15M56i1BCzy-ig@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Nov 2022 00:12:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10050

Hi !

It's this week's CVE report.

This week reported 2 new CVEs and 15 updated CVEs.

* New CVEs

CVE-2022-3903: An invalid pipe direction in the mceusb driver cause
the kernel to DOS

CVSS v3 score is not provided.

When mceusb driver sends an invalid read request on endpoint 0 without
setting USB_DIR bit in the bRequest type field will lead to an
invalid pipe direction warning in the driver.

Commit 41fd1cb ("media: mceusb: Use new usb_control_msg_*() routines")
requires usb_control_msg_recv() and usb_control_msg_send() both
functions are introduced by commit 719b8f2 ("USB: add
usb_control_msg_send() and usb_control_msg_recv()") in 5.10-rc1.

Fixed status
mainline: [41fd1cb6151439b205ac7611883d85ae14250172]
stable/5.10: [587f793c64d99d92be8ef01c4c69d885a3f2edb6]

CVE-2022-3977: A use-after-free bug that was found in the
mctp_sk_unhash in Linux kernel=E2=80=99 net/mctp/af_mctp.c

CVSS v3 score is not provided.

There was a race where DROPTAG ioctl and socket close that leads
remove a key from lists twice, and perform an unref for each removal
operation. This causes a use-after-free bug. It allows an attacker to
local privilege escalation.

This bug was introduced by 63ed1aa ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG
ioctls for tag control") in 5.18-rc1.
The MCTP module was added by commit bc49d81 ("mctp: Add MCTP base") in 5.15=
-rc1.

Fixed status
mainline: [3a732b46736cd8a29092e4b0b1a9ba83e672bf89]
stable/6.0: [3c7c84319833259b0bb8c879928700c9e42d6562]

* Updated CVEs

CVE-2021-3759: memcg: charge semaphores and sem_undo objects

5.10 and 5.4 were fixed.

Fixed status
mainline: [18319498fdd4cdf8c1c2c48cd432863b1f915d6f]
stable/5.10: [836686e1a01d7e2fda6a5a18252243ff30a6e196]
stable/5.4: [bad83d55134e647a739ebef2082541963f2cbc92]

CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().

5.10 and 5.4 were fixed.

Fixed status
mainline: [3c52c6bb831f6335c176a0fc7214e26f43adbd11]
stable/5.10: [818c36b988b82f31e4be8ad8415e1be902b8e5f8]
stable/5.15: [1401e9336bebaa6dd5a320f83bddc17619d4e3a6]
stable/5.4: [92aaa5e8fe90a008828a1207e66a30444bcb1cbd]
stable/6.0: [0c5d628f1e1d049c33595693fab1b6e9baf25795]

CVE-2022-3543: af_unix: Fix memory leaks of the whole sk due to OOB skb.

5.15 was fixed.

Fixed status
mainline: [7a62ed61367b8fd01bae1e18e30602c25060d824]
stable/5.15: [3975affcf55f93814a8ae14333d7fc7f183e60a4]
stable/5.19: [e2e49822a0a16d306bf6fe0009fe3136a3318f36]
stable/6.0: [2f415ad33bc1a729fb1050141921b5a9ec4e062c]

CVE-2022-3623: mm/hugetlb: fix races when looking up a CONT-PTE/PMD
size hugetlb page

5.15 was fixed.

Fixed status
mainline: [fac35ba763ed07ba93154c95ffc0c4a55023707f]
stable/5.15: [3a44ae4afaa5318baed3c6e2959f24454e0ae4ff]
stable/5.19: [86a913d55c89dd13ba070a87f61a493563e94b54]
stable/6.0: [7c7c79dd5a388758f8dfa3de89b131d5d84f25fd]

CVE-2022-3628: wifi: Fix potential buffer overflow in
''brcmf_fweh_event_worker''

4.14, 4.19, 4.9, 5.10, 5.15, 5.4, and 6.0 were fixed.

Fixed status
mainline: [6788ba8aed4e28e90f72d68a9d794e34eac17295]
stable/4.14: [b23665bbd39224e15aab89df4a4b60c0ab2ad09d]
stable/4.19: [5e7d546917431400b7d6e5e38f588e0bd13083c9]
stable/4.9: [b1477d95e967bf626b8c5e3838bb885c47381b24]
stable/5.10: [c6678c8f4f3f8383fe2dff3455de3d504382638f]
stable/5.15: [7038af4ce95105146d22e461eaa450829f28eeaf]
stable/5.4: [a16415c8f156bec5399ef0345715ee4b90e5bb83]
stable/6.0: [631f73deedeb0fbc92ca5037d5a71c9fcae7974d]

CVE-2022-42895: Bluetooth: L2CAP: Fix attempting to access uninitialized me=
mory

4.14, 4.19, 4.9, 5.10, 5.15, 5.4, and 6.0 were fixed.

Fixed status
mainline: [b1a2cd50c0357f243b7435a732b4e62ba3157a2e]
stable/4.14: [999d99c8de09537bd4f4a4a7db2be6b55c6ed817]
stable/4.19: [36919a82f335784d86b4def308739559bb47943d]
stable/4.9: [63e3d75298fac7fa50906454603dd5bb4ef22a23]
stable/5.10: [26ca2ac091b49281d73df86111d16e5a76e43bd7]
stable/5.15: [3e4697ffdfbb38a2755012c4e571546c89ab6422]
stable/5.4: [6949400ec9feca7f88c0f6ca5cb5fdbcef419c89]
stable/6.0: [e1aada9b71493b2e11c2a239ece99a97e3f13431]

CVE-2022-42896: Bluetooth: L2CAP: Fix accepting connection request for
invalid SPSM

5.10, 5.15, and 6.0 were fixed.

Fixed status
mainline: [711f8c3fb3db61897080468586b970c87c61d9e4]
stable/5.10: [6b6f94fb9a74dd2891f11de4e638c6202bc89476]
stable/5.15: [81035e1201e26d57d9733ac59140a3e29befbc5a]
stable/6.0: [d7efeb93213becae13c6a12e4150ce1e07bd2c49]

CVE-2022-2978: fs: fix UAF/GPF bug in nilfs_mdt_destroy

The mainline and stable kernels were fixed.
Patch can be applied to 4.4-st.

Fixed status
mainline: [2e488f13755ffbb60f307e991b27024716a33b29]
stable/4.14: [c0aa76b0f17f59dd9c9d3463550a2986a1d592e4]
stable/4.19: [ec2aab115eb38ac4992ea2fcc2a02fbe7af5cf48]
stable/4.9: [d1ff475d7c83289d0a7faef346ea3bbf90818bad]
stable/5.10: [1e555c3ed1fce4b278aaebe18a64a934cece57d8]
stable/5.15: [64b79e632869ad3ef6c098a4731d559381da1115]
stable/5.4: [70e4f70d54e0225f91814e8610477d65f33cefe4]
stable/6.0: [2a96b532098284ecf8e4849b8b9e5fc7a28bdee9]

CVE-2022-3169: Request to NVME_IOCTL_RESET and NVME_IOCTL_SUBSYS_RESET
may cause a DOS

The mainline was fixed.

Fixed status
mainline: [1e866afd4bcdd01a70a5eddb4371158d3035ce03]

CVE-2022-3435: ipv4: Handle attempt to delete multipath route when
fib_info contains an nh reference

The mainline was fixed.
Kernel less than 5.3 aren't affected by this CVE.

Fixed status
mainline: [61b91eb33a69c3be11b259c5ea484505cd79f883]

CVE-2022-3564: Bluetooth: L2CAP: Fix use-after-free caused by
l2cap_reassemble_sdu

The mainline and stable kernels were fixed.
Backporting this fix to 4.4 needs to fix merge conflict.

Fixed status
mainline: [3aff8aaca4e36dc8b17eaa011684881a80238966]
stable/4.14: [03af22e23b96fb7ef75fb7885407ef457e8b403d]
stable/4.19: [6c7407bfbeafc80a04e6eaedcf34d378532a04f2]
stable/4.9: [dc30e05bb18852303084430c03ca76e69257d9ea]
stable/5.10: [cb1c012099ef5904cd468bdb8d6fcdfdd9bcb569]
stable/5.15: [8278a87bb1eeea94350d675ef961ee5a03341fde]
stable/5.4: [4cd094fd5d872862ca278e15b9b51b07e915ef3f]
stable/6.0: [9a04161244603f502c6e453913e51edd59cb70c1]

CVE-2022-3619: Bluetooth: L2CAP: Fix memory leak in vhci_write

The mainline, 5.15, and 6.0 were fixed.
kernel less than 5.15 aren't affected by this CVE.

Fixed status
mainline: [7c9524d929648935bac2bbb4c20437df8f9c3f42]
stable/5.15: [aa16cac06b752e5f609c106735bd7838f444784c]
stable/6.0: [5b4f039a2f487c5edae681d763fe1af505f84c13]

CVE-2022-3640: Bluetooth: L2CAP: fix use-after-free in l2cap_conn_del()

4.19 and 5.10 were fixed. 4.4 is not affected by this CVE.

Fixed status
mainline: [42cf46dea905a80f6de218e837ba4d4cc33d6979]
stable/4.19: [7f7bfdd9a9af3b12c33d9da9a012e7f4d5c91f4b]
stable/5.10: [d9ec6e2fbd4a565b2345d4852f586b7ae3ab41fd]

CVE-2022-41849: video: fbdev: smscufx: Fix use-after-free in ufx_ops_open()

The mainline and stable kernels were fixed.
Patch can be applied to 4.4-st.

Fixed status
mainline: [5610bcfe8693c02e2e4c8b31427f1bdbdecc839c]
stable/4.14: [fa008859983d9231b9241a4b9eac7aabfbb45155]
stable/4.19: [6d8dbefc4de96d35d68c723e2e75b5a23173c08c]
stable/4.9: [347a969b130c2a496f471f14b354119b82664f0a]
stable/5.10: [e50472949604f385e09ce3fa4e74dce9f44fb19b]
stable/5.15: [2b0897e33682a332167b7d355eec28693b62119e]
stable/5.4: [3742e9fd552e6c4193ebc5eb3d2cd02d429cad9c]
stable/6.0: [e2e5264dcf5796559869750a2d6943ac88fe3918]

CVE-2022-41850: HID: roccat: Fix Use-After-Free in roccat_read

The mainline and stable kernels were fixed.
Patch can be applied to 4.4-st.

Fixed status
mainline: [cacdb14b1c8d3804a3a7d31773bc7569837b71a4]
stable/4.14: [fb8b43b7721786f551ec95542e07cf9a909f3e56]
stable/4.19: [13de81c7ea0fd68efb48a2d2957e349237905923]
stable/4.9: [84607bd3a8542b84b450d19a3579172f96c2bb47]
stable/5.10: [dbcca76435a606a352c794956e6df62eedd3a353]
stable/5.15: [c61786dc727d1850336d12c85a032c9a36ae396d]
stable/5.4: [e30c3a9a88818e5cf3df3fda6ab8388bef3bc6cd]
stable/6.0: [8a251549ab577d64ece210a11c404354479bd635]

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

