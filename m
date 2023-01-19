Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A8AC38159
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 00:15:37 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web10.33657.1674087330678204078
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Jan 2023 16:15:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=HPfrDgIl;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.48, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f48.google.com with SMTP id t14-20020a4ad0ae000000b004f51f61de9fso154976oor.13
        for <cip-dev@lists.cip-project.org>; Wed, 18 Jan 2023 16:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vB/4fD6leyoTF3oT0GFgqahyNH3wOsbeSVv2ljK5J8Q=;
        b=HPfrDgIlZnC9EW98KIEuGD2eyJbBPa1/puOap85euWteFjpahRDrhp401PN+i3quk6
         +9ihjP5pu/vw0cxvp5zrifocmMOC+kI5bsXGw7AobWbmsTN4i0r9sETBLkH6ODI34nfw
         PO2HZHuQp6fQQi0bP1JQVRkOVe6YkiBA/7bPzqutIEgaRuj+5JU14F04FXgi53O00QNw
         opirA/JX/qh0cB4B5OQYZ4GSdtu6pOAE8QK5B/0r8yZz/M6+X3I2pf3pAvhZYL0sxUAz
         Pm+q26K4k7Foa/mRvU5QGGyuDOmomCLUACPfnhoBbiHhmLd7Plyy5+RXeY3xslk+bz70
         CIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vB/4fD6leyoTF3oT0GFgqahyNH3wOsbeSVv2ljK5J8Q=;
        b=qz/fdCdnUlsOASVEPXPQy7hiIDl9u+Aou6XnIdiYY2Ca74iw2drd2rDEHkq5plSPa4
         rkoQLkrINDuyIYEcTgB5HRLzQYkXg0b+0htFdwRDwtmVisRVaNrMrsNw0TUfkr6ZQNZE
         E0zWaNlXcEwgrroop7KLR6dJsre+P4Ny/RidddxgdPzBTk59BZKpSRA0IIjF2BdsqyKg
         dmVED1bkTOyaANKdc1WsgJ64vBec2u+9NR3L9TG9Ic4JlU4s98NpAfTAstxaOX6XT5Dz
         SAGMJZeja4LX2u5Xf7MIL/bFxD0VN47BtfKMCY3rdxCV1vimXQlt3EtlB6xRQ9bvrgEt
         J/tw==
X-Gm-Message-State: AFqh2kryvmcLJFAbT1u7Y6NIT4ehkortJ3R+m7p3XTMcPqKHDgo4FgTc
	0RrePaC6a3BXCMmn8IrSTzgU4Oh5v/E14Ea0lbue8g0wNnbeGwmL
X-Google-Smtp-Source: AMrXdXsiV6w0RbUcxDKU9fFLd4MNriyKtCSGy9jjyXYbCk1xE/LZVqJvfvnDPhNG7Ba0QQecSsOZ3q2AGiC2lD6pmq8=
X-Received: by 2002:a4a:d027:0:b0:4a3:f067:1aea with SMTP id
 w7-20020a4ad027000000b004a3f0671aeamr394265oor.34.1674087329307; Wed, 18 Jan
 2023 16:15:29 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Jan 2023 09:14:53 +0900
Message-ID: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 00:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10415

Hi !

It's this week's CVE report.

This week reported 7 new CVEs and 8 updated CVEs.

* New CVEs

CVE-2023-23454: net: sched: cbq: dont intepret cls results when asked to drop

CVSS v3 score is not provided

atm_tc_enqueue in net/sched/sch_atm.c in the Linux kernel through
6.1.4 allows attackers to cause a denial of service
because of type confusion (non-negative numbers can sometimes indicate
a TC_ACT_SHOT condition rather
than valid classification results).

This bug was introduced in 2.6.12-rc2 or before so that 4.4 will be
affected by this issue as well.
Applying this fix to 4.4 needs to modify the patch.

Fixed status
mainline: [caa4b35b4317d5147b3ab0fbdc9c075c7d2e9c12]
stable/5.10: [b2c917e510e5ddbc7896329c87d20036c8b82952]
stable/5.15: [04dc4003e5df33fb38d3dd85568b763910c479d4]
stable/5.4: [6b17b84634f932f4787f04578f5d030874b9ff32]
stable/6.0: [cde7091efe3fcc0b19f736acd0163499d1fd6d31]
stable/6.1: [dc46e39b727fddc5aacc0272ef83ee872d51be16]

CVE-2023-23455: net: sched: atm: dont intepret cls results when asked to drop

CVSS v3 score is not provided

This bug was introduced by commit b0188d4 ("[NET_SCHED]: sch_atm:
Lindent") in 2.6.23-rc1.

Fixed status
mainline: [a2965c7be0522eaa18808684b7b82b248515511b]
stable/4.14: [db49adc5aff0c84ef0439a666f494a0d57c98bc7]
stable/4.19: [5374c455ebe6102e3d5f1842c6d8ff72b3ca659f]
stable/5.10: [5f65f48516bfeebaab1ccc52c8fad698ddf21282]
stable/5.15: [f02327a4877a06cbc8277e22d4834cb189565187]
stable/5.4: [63e469cb54a87df53edcfd85bb5bcdd84327ae4a]
stable/6.0: [bbb870c88576239842602b0f7cc58c361dc8e061]
stable/6.1: [85655c63877aeafdc23226510ea268a9fa0af807]

CVE-2023-0179: netfilter: nft_payload: incorrect arithmetics when
fetching VLAN header bits

CVSS v3 score is not provided

The vulnerability consists of a stack buffer overflow due to an integer
underflow vulnerability inside the nft_payload_copy_vlan function, which is
invoked with nft_payload expressions as long as a VLAN tag is present in
the current skb.

This bug was introduced by commit f6ae9f1 ("netfilter: nft_payload:
add C-VLAN support") in 5.5-rc1

Fixed status
mainline: fixed in netfilter-next tree but not merged into the mainline yet.
stable/5.10: [550efeff989b041f3746118c0ddd863c39ddc1aa]
stable/5.15: [a8acfe2c6fb99f9375a9325807a179cd8c32e6e3]
stable/6.1: [76ef74d4a379faa451003621a84e3498044e7aa3]

CVE-2023-0266: ALSA: pcm: Move rwsem lock inside snd_ctl_elem_read to
prevent UAF

CVSS v3 score is not provided

A use-after-free bug was found in the ALSA subsystem. Taking rwsem
lock in snd_ctl_elem_read_user will cause a use-after-free bug.

This bug was introduced by commit 1fa4445 ("ALSA: control - introduce
snd_ctl_notify_one() helper")
in 5.13-rc1.

Fixed status
mainline: [56b88b50565cd8b946a2d00b0c83927b7ebb055e]
stable/4.19: [5b2ea7e91352165054c5b3f8e5442cd31c3e73f9]
stable/5.10: [df02234e6b87d2a9a82acd3198e44bdeff8488c6]
stable/5.15: [26350c21bc5e97a805af878e092eb8125843fe2c]
stable/6.1: [d6ad4bd1d896ae1daffd7628cd50f124280fb8b1]

CVE-2023-23559: rndis_wlan: Prevent buffer overflow in rndis_query_oid

CVSS v3 score is not provided

In rndis_query_oid in drivers/net/wireless/rndis_wlan.c in the Linux
kernel through 6.1.5, there is an integer overflow in an addition.

This bug was introduced by 80f8c5b434f9 ("rndis_wlan: copy only useful
data from rndis_command respond") in 2.6.35-rc1.

Fixed status
Patch is in the patchwork but not merged into the mainline yet.

CVE-2022-47929: Null pointer dereference bug in traffic control subsystem.

CVSS v3 score is not provided

In the Linux kernel before 6.1.6, a NULL pointer dereference bug in
the traffic control subsystem allows an unprivileged user to trigger a
denial of service (system crash)
via a crafted traffic control configuration that is set up with "tc
qdisc" and "tc class" commands.
This affects qdisc_graft in net/sched/sch_api.c.

This fix uses the NL_SET_ERR_MSG macro to create an error message
which was merged in 4.12-rc1. Kernel 4.4 doesn't have this macro.

Fixed status
mainline: [96398560f26aa07e8f2969d73c8197e6a6d10407]
stable/4.14: [4574e32cbf652d7efcaa6076558752f770b01757]
stable/4.19: [0195d5ad539382a83e1bfaab51b93b8685f0b7c7]
stable/5.10: [9f7bc28a6b8afc2274e25650511555e93f45470f]
stable/5.15: [04941c1d5bb59d64165e09813de2947bdf6f4f28]
stable/5.4: [9b83ec63d0de7b1f379daa1571e128bc7b9570f8]
stable/6.1: [e8988e878af693ac13b0fa80ba2e72d22d68f2dd]

CVE-2023-0394: ipv6: raw: Deduct extension header length in
rawv6_push_pending_frames

CVSS v3 score is not provided

A null pointer dereference bug was found in
rawv6_push_pending_frames() in net/ipv6/raw.c.
Introduced by commit 357b40a ("[IPV6]: IPV6_CHECKSUM socket option can
corrupt kernel memory") in 2.6.12-rc3.

Patch can be applied to 4.4 by git am with -3 option.

Fixed status
mainline: [cb3e9864cdbe35ff6378966660edbcbac955fe17]
stable/4.14: [35ed8ba485544a31a4ab9b92a1c68e406ab66a47]
stable/4.19: [f487d636e49bc1fdfbd8105bc1ab159164e2d8bd]
stable/5.10: [6c9e2c11c33c35563d34d12b343d43b5c12200b5]
stable/5.15: [456e3794e08a0b59b259da666e31d0884b376bcf]
stable/5.4: [3998dba0f78a59922b0ef333ccfeb58d9410cd3d]
stable/6.1: [0afa5f0736584411771299074bbeca8c1f9706d4]

* Updated CVEs

CVE-2022-36280: An out-of-bounds(OOB) memory access vulnerability was
found in vmwgfx driver in drivers/gpu/vmxgfx/vmxgfx_kms.c

4.14, 4.19, 5.4, 5.10 and 5.15 were fixed.

Fixed status
mainline: [4cf949c7fafe21e085a4ee386bb2dade9067316e]
stable/4.14: [50d177f90b63ea4138560e500d92be5e4c928186]
stable/4.19: [6b4e70a428b5a11f56db94047b68e144529fe512]
stable/5.10: [439cbbc1519547f9a7b483f0de33b556ebfec901]
stable/5.15: [6948e570f54f2044dd4da444b10471373a047eeb]
stable/5.4: [94b283341f9f3f0ed56a360533766377a01540e0]
stable/6.0: [4d54d11b49860686331c58a00f733b16a93edfc4]
stable/6.1: [622d527decaac0eb65512acada935a0fdc1d0202]

CVE-2022-3707: Double-free in split_2MB_gtt_entry when function
intel_gvt_dma_map_guest_page failed

6.0 and 6.1 were fixed.

Fixed status
mainline: [4a61648af68f5ba4884f0e3b494ee1cabc4b6620]
stable/6.0: [bb84f2e119accfc65d5fa6ebe31751cdc3bca9fb]
stable/6.1: [1022519da69d99d455c58ca181a6c499c562c70e]

CVE-2022-41218: media: dvb-core: Fix UAF due to refcount races at releasing

4.14, 4.19, 5.4, 5.10, and 5.15 were fixed.

Fixed status
mainline: [fd3d91ab1c6ab0628fe642dd570b56302c30a792]
stable/4.14: [8d904e99c10e2e443c6c7c418541880513eb9790]
stable/4.19: [8f537a1282cd877f132643ef8f9e9d6032f90025]
stable/5.10: [3df07728abde249e2d3f47cf22f134cb4d4f5fb1]
stable/5.15: [8b45a3b19a2e909e830d09a90a7e1ec8601927d9]
stable/5.4: [a29d6213098816ed4574824b6adae94fb1c0457d]
stable/6.0: [55870fc9e45faa9a65860bcd6b0f8ca8c99afe44]
stable/6.1: [530ca64b44625f7d39eb1d5efb6f9ff21da991e2]

CVE-2023-0210: ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
ksmbd_decode_ntlmssp_auth_blob

5.15, 6.0, and 6.1 were fixed.

Fixed status
mainline: [797805d81baa814f76cf7bdab35f86408a79d707]
stable/5.15: [e32f867b37da7902685c9a106bef819506aa1a92]
stable/6.0: [1e7ed525c60d8d51daf2700777071cd0dfb6f807]
stable/6.1: [5e7d97dbae25ab4cb0ac1b1b98aebc4915689a86]

CVE-2022-2873: an out-of-bounds vulnerability in i2c-ismt driver

4.19 and 5.10 were fixed.

Fixed status
mainline: [690b2549b19563ec5ad53e5c82f6a944d910086e]
stable/4.19: [bfe41d966c860a8ad4c735639d616da270c92735]
stable/5.10: [9ac541a0898e8ec187a3fa7024b9701cffae6bf2]
stable/5.15: [24c6fc6e7453f64cf6cbb4218c62aafdecc16ee1]

CVE-2022-3424: misc: sgi-gru: fix use-after-free error in
gru_set_context_option, gru_fault and gru_handle_user_call_os

4.14, 4.19, 5.4, and 5.10 were fixed.

Fixed status
mainline: [643a16a0eb1d6ac23744bb6e90a00fc21148a9dc]
stable/4.14: [3eec37e223fabedaf90191e8a0cc61d46a96ab8d]
stable/4.19: [bcda4624e87d6b922e94f5c0fd0bd5f027b8b226]
stable/5.10: [0f67ed565f20ea2fdd98e3b0b0169d9e580bb83c]
stable/5.15: [d5c8f9003a289ee2a9b564d109e021fc4d05d106]
stable/5.4: [0078dd8758561540ed30b2c5daa1cb647e758977]
stable/6.0: [dbc1bb8c8ea930f188b7ce45db162807b3f4b66a]
stable/6.1: [4e947fc71bec7c7da791f8562d5da233b235ba5e]

CVE-2022-3545: nfp: fix use-after-free in area_cache_get()

4.14 and 4.19 were fixed.

Fixed status
mainline: [02e1a114fdb71e59ee6770294166c30d437bf86a]
stable/4.14: [60537e23e40f7ca9e07679fec28af79d43d9e8f6]
stable/4.19: [6ff23e9b9a04b833388862246838bb38ac0c46b6]
stable/5.10: [eb6313c12955c58c3d3d40f086c22e44ca1c9a1b]
stable/5.15: [9d933af8fef33c32799b9f2d3ff6bf58a63d7f24]
stable/5.4: [3c837460f920a63165961d2b88b425703f59affb]

CVE-2022-45934: Bluetooth: L2CAP: Fix u8 overflow

4.14, 4.19, and 5.4 were fixed.

Fixed status
mainline: [bcd70260ef56e0aee8a4fc6cd214a419900b0765]
stable/4.14: [95f1847a361c7b4bf7d74c06ecb6968455082c1a]
stable/4.19: [ad528fde0702903208d0a79d88d5a42ae3fc235b]
stable/5.10: [f3fe6817156a2ad4b06f01afab04638a34d7c9a6]
stable/5.15: [19a78143961a197de8502f4f29c453b913dc3c29]
stable/5.4: [9fdc79b571434af7bc742da40a3405f038b637a7]
stable/6.0: [5550bbf709c323194881737fd290c4bada9e6ead]

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

