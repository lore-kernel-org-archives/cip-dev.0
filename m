Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACDDC001B0
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 00:26:42 +0000 (UTC)
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
 by mx.groups.io with SMTP id smtpd.web11.2612.1689812795535933368
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jul 2023 17:26:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@miraclelinux-com.20221208.gappssmtp.com header.s=20221208 header.b=OKat9cNN;
 spf=pass (domain: miraclelinux.com, ip: 209.85.161.48, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5658573b1faso197523eaf.1
        for <cip-dev@lists.cip-project.org>; Wed, 19 Jul 2023 17:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20221208.gappssmtp.com; s=20221208; t=1689812794; x=1690417594;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J3yXbkSvNWXidvJtf6GdfQGobqpqahF9hRcB0IJgjQw=;
        b=OKat9cNNlC56KniiTZ84WukncOuBwRfI5jPLoPyj0K33Qd+BgQZxpcpC66gcj0gl9d
         XHHqIJ/t1Dww24REyCt0qV3rK+CFfRP/Wrnq5B9JZrhpDKZ4vX9+RLpCXFRjp7hnfLR+
         GHzCZ9ike6DsHgv70JsBtUc8o23zGy31uI/m3PyLMFVfqDdckHFfLhVi3ylbp1AUsdGb
         I09dQ74Zi6aam7dDACsm1PVRIoL6BwHPukxghqd0Qhwc9sCM5gtApp+3GAz7USX4UIj0
         pT4JyF6hdCVbGnXxaQKxHrXn9xrXFqI3HPzvDXTQMDqZgLCiAVwrEfGKedf/ia6RWmld
         kkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689812794; x=1690417594;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J3yXbkSvNWXidvJtf6GdfQGobqpqahF9hRcB0IJgjQw=;
        b=BSkOS8349M8IlilbB74WHIaLqQ0HMG6kpVGXhMLcYapPjbf8BUxk3lroT585wwJM8s
         o1vER3UI2UIQ7+8J+jZgDHa26Pt7T2h0QviLBMThdUDVYWPYcIT9QCp8g3po2YSH1CUV
         ZTMsBMHSrG8m3waQ6ajhn678gXB2rl6gQMEJtj9sKdha8nf5RbmGA5U1Pulj8F0CNeiK
         fdvBvSRAOdvE1DdEvwt1X3LfxHOn0Nld6W7m9mGNRf3gCNqtJqGXgcHXtoZmWnKdNJWg
         Had6s0ctHR7/QN2LxMnOsfAJPtJsttJuw39Ytivx+xH9H7nVNhHpItaNspvWPDHiZxYf
         5lbg==
X-Gm-Message-State: ABy/qLbeCk/Ug889gpjDZlxpALqMBayBIQEBqzqEGlDjVYsrOOleKmbY
	dtNbrvnN7EWNH3vibAlxQhfq/TJ0+p+VyUZkanPeAVh1lT2Jj/LQlCg=
X-Google-Smtp-Source: APBJJlGDHjPidQsP2x2A47Zy+zgrUUhmO7nhsnJXW1zpbFdld3YA6MjDSrDM58h/fyAV2H11ClGJXgDIFaAWcs4/9kI=
X-Received: by 2002:a4a:4993:0:b0:566:f5bb:7d40 with SMTP id
 z141-20020a4a4993000000b00566f5bb7d40mr907481ooa.6.1689812793981; Wed, 19 Jul
 2023 17:26:33 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Jul 2023 09:25:57 +0900
Message-ID: <CAODzB9pjCst+TmeEtVeNxab79Pdku=Xs2CVcKC2wv5gD5JzBpw@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 00:26:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12439

Hi !

It's this week's CVE report.

This week reported 12 new CVEs and 4 updated CVEs.

About half of CVEs are ksmbd's vulnerability this week. These have
been fixed in the mainline,
but some patches have failed to apply 5.15.

The io_uring system wide disable/enable setting
(https://www.phoronix.com/news/Linux-6.6-sysctl-IO_uring) is
interesting.
Google has been limiting io_uring recentry
(https://security.googleblog.com/2023/06/learnings-from-kctf-vrps-42-linux.html)
so
it seems good way to harden a system when user are sure they don't
need to be io_uring enabled.

* New CVEs

CVE-2023-3640: A per-cpu entry area leak was found in x86/mm subsystem

CVSS v3 score is not provided.

x86/mm: a per-cpu entry area leak was identified through the
init_cea_offsets function when prefetchnta and prefetcht2 instructions
being used for the per-cpu entry area mapping to the user space

Fixed status
Not fixed yet

CVE-2023-3106: crash in XFRM_MSG_GETSA netlink handler

CVSS v3 score is not provided (NIST).
CVSS v3 score is 6.6 MEDIUM (CNA).

A NULL pointer dereference vulnerability was found in netlink_dump.
This issue can occur when the Netlink socket receives the
message(sendmsg) for the XFRM_MSG_GETSA, XFRM_MSG_GETPOLICY type
message, and the DUMP flag is set and can cause a denial of service or
possibly another unspecified impact. Due to the nature of the flaw,
privilege escalation cannot be fully ruled out, although it is
unlikely.

This bug was introduced by commit d362309 ("ipsec: add support of
limited SA dump") in 3.15-rc1 and fixed by commit 1ba5bf9 ("xfrm: fix
crash in XFRM_MSG_GETSA netlink handler") in 4.8-rc7. So, It only
affects Linux 4.4.y.
It was fixed in 4.4.223.

Fixed status
cip/4.4: [0cbb0084fa2b444b7316a0967a0d93f5ae520216]
cip/4.4-rt: [0cbb0084fa2b444b7316a0967a0d93f5ae520216]
cip/4.4-st: [0cbb0084fa2b444b7316a0967a0d93f5ae520216]
mainline: [1ba5bf993c6a3142e18e68ea6452b347f9cb5635]

CVE-2023-3609: net/sched: cls_u32: Fix reference counter leak leading
to overflow

CVSS v3 score is not provided.

A double free bug was found in the net/sched subsystem. When failure
happens in the tcf_change_indev(), u32_set_params() doesn't decrement
the reference counter so that counter value will be incorrect in that
case. It leads to a double free bug.

It was introduced by commit 705c709 ("net: sched: cls_u32: no need to
call tcf_exts_change for newly allocated struct") in 4.14-rc1 and
fixed in 6.4-rc7. It doesn't affect Linux 4.4 series.

Fixed status
mainline: [04c55383fa5689357bcdd2c8036725a55ed632bc]
stable/5.10: [af6eaa57986e82d7efd81984ee607927c6de61e4]
stable/5.15: [0e1098d72fa462944c68262e1b5cca045dcb555e]
stable/5.4: [46305daf8064598a4008af1728651296815a74ed]
stable/6.1: [07f9cc229b44cbcee6385802d390091d915f38c3]

CVE-2023-3610: netfilter: nf_tables: fix chain binding transaction logic

CVSS v3 score is not provided.

The logic to deal with chain binding in nft_data_hold() and
nft_data_release() is not correct. The NFT_TRANS_PREPARE state needs a
special handling in case a chain is bound but next expressions in the
same rule fail to initialize as described by 1240eb9 ("netfilter:
nf_tables: incorrect error path handling with NFT_MSG_NEWRULE")

It was introduced by commit d0e2c7d ("netfilter: nf_tables: add
NFT_CHAIN_BINDING") in 5.9-rc1 and fixed in 6.4.
Linux 4.x are not affected.

Fixed status
mainline: [4bedf9eee016286c835e3d8fa981ddece5338795]
stable/5.15: [314a8697d08092df6d00521450d44c352c602943]
stable/6.1: [891cd2edddc76c58e842706ad27e2ff96000bd5d]

CVE-2023-38409: fbcon: set_con2fb_map needs to set con2fb_map

CVSS v3 score is not provided.

An issue was discovered in set_con2fb_map in
drivers/video/fbdev/core/fbcon.c in the Linux kernel before 6.2.12.
Because an assignment occurs only for the first vc, the
fbcon_registered_fb and fbcon_display arrays can be desynchronized in
fbcon_mode_deleted (the con2fb_map points at the old fb_info).

Introduced by commit d443d93 ("fbcon: move more common code into
nfb_open()") in 5.19-rc1.
This patch is not backported to older stable kernels. so, before 5.19
kernels aren't affected.

Fixed status
mainline: [fffb0b52d5258554c645c966c6cbef7de50b851d]
stable/6.1: [b15df140fe092c3ac28dab32c6b3acdda1a93c63]

CVE-2023-38426: OOB read bug was found in smb2_find_context_vals()

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.4. ksmbd has an
out-of-bounds read in smb2_find_context_vals when create_context's
name_len is larger than the tag length.
The ksmbd has been introduced in 5.15 so before this versions aren't affected.

Fixed status
mainline: [02f76c401d17e409ed45bf7887148fcc22c93c85]
stable/5.15: [865be1cff2c038984fe55c9deae5461a498cfdf9]
stable/6.1: [75378b03a90d75b1349bb03577ac8465194c883e]

CVE-2023-38427: OOB read bug was found in deassemble_neg_contexts()

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.8.
fs/smb/server/smb2pdu.c in ksmbd has an integer underflow and
out-of-bounds read in deassemble_neg_contexts.
The ksmbd has been introduced in 5.15 so before this versions aren't affected.

Applying this fix to 5.15 failed
(https://lore.kernel.org/stable/2023061216-striking-darkened-f7a5@gregkh/).

Fixed status
mainline: [f1a411873c85b642f13b01f21b534c2bab81fc1b]
stable/6.1: [bf12d7fb63b365fb766655cedcb5d5f292b0c35e]

CVE-2023-38428: OOB read bug was found in session_user()

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.4.
fs/ksmbd/smb2pdu.c in ksmbd does not properly check the UserName value
because it does not consider the address of security buffer, leading
to an out-of-bounds read.
The ksmbd has been introduced in 5.15 so before this versions aren't affected.

Fixed status
mainline: [f0a96d1aafd8964e1f9955c830a3e5cb3c60a90f]
stable/5.15: [7657321b2624197840ef2cfa4f29ccf873d7aa9b]
stable/6.1: [40d90ee0275a1bfcd26fa7690adc4330b4227a69]

CVE-2023-38429: OOB access bug was found in the ksmbd subsystem

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.4.
fs/ksmbd/connection.c in ksmbd has an off-by-one error in memory
allocation (because of ksmbd_smb2_check_message) that may lead to
out-of-bounds access.
The ksmbd has been introduced in 5.15 so before this versions aren't affected.

Fixed status
mainline: [443d61d1fa9faa60ef925513d83742902390100f]
stable/5.15: [61e043326e72b5abb02b5bc9132f2620a7faf8c5]
stable/6.1: [af7335a4b946f9f6f9d98398cbcea15cd9850409]

CVE-2023-38430: OOB read bug was found in the ksmbd subsystem

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.9. ksmbd does
not validate the SMB request protocol ID, leading to an out-of-bounds
read.
The ksmbd has been introduced in 5.15 so before this versions aren't affected.

Applying this patch to 5.15 failed
(https://lore.kernel.org/stable/2023061222-comic-platypus-831e@gregkh/).

Fixed status
mainline: [1c1bcf2d3ea061613119b534f57507c377df20f9]
stable/6.1: [e01fc7caac9ce9ad76df9f42f7f61ef4bf1d27c9]

CVE-2023-38431: OOB read bug was found in the ksmbd subsystem

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.8.
fs/smb/server/connection.c in ksmbd does not validate the relationship
between the NetBIOS header's length field and the SMB header sizes,
via pdu_size in ksmbd_conn_handler_loop, leading to an out-of-bounds
read.
The ksmbd has been introduced in 5.15 so before this versions aren't affected.

Applying this patch to 5.15 failed
(https://lore.kernel.org/stable/2023061233-omnivore-cardigan-93f8@gregkh/).

Fixed status
mainline: [368ba06881c395f1c9a7ba22203cf8d78b4addc0]
stable/6.1: [543c12c2644e772caa6880662c2a852cfdc5a10c]

CVE-2023-38432: OOB read bug was found in the ksmbd subsystem

CVSS v3 score is not provided.

An issue was discovered in the Linux kernel before 6.3.10.
fs/smb/server/smb2misc.c in ksmbd does not validate the relationship
between the command payload size and the RFC1002 length specification,
leading to an out-of-bounds read.

Applying this patch to 5.15 failed
(https://lore.kernel.org/stable/2023062128-record-unclog-7ccd@gregkh/).

Fixed status
mainline: [2b9b8f3b68edb3d67d79962f02e26dbb5ae3808d]
stable/6.1: [9650cf70ec9d94ff34daa088b643229231723c26]

* Updated CVEs

CVE-2023-1192: use-after-free in smb2_is_status_io_timeout()

The mainline, 5.15, and 6.1 were fixed.

Fixed status
mainline: [98bea253aa28ad8be2ce565a9ca21beb4a9419e5]
stable/5.15: [2a67f26f70ab344ae6ea78638890eebc1191a501]
stable/6.1: [a8eaa9a06addbd9cb0238cb1c729921ecbb6504c]

CVE-2023-2898: f2fs: fix to avoid NULL pointer dereference f2fs_write_end_io()

The mainline, 6.1, and 6.4 were fixed.

Fixed status
mainline: [d8189834d4348ae608083e1f1f53792cfcc2a9bc]
stable/6.1: [ebe83e9bb8a6b3db28603fe938ee80ccaa01ed53]
stable/6.4: [5619e9aabbd2b369cde2114ad6f55f6eb3e0b5be]

CVE-2023-31248: nf_tables UAF when using nft_chain_lookup_byid

Stable 6.1 and 6.4 were fixed.

Fixed status
mainline: [515ad530795c118f012539ed76d02bacfd426d89]
stable/6.1: [fc95c8b02c6160936f1f3d8d9d7f4f66f3c84b49]
stable/6.4: [5e5e967e8505fbdabfb6497367ec1b808cadc356]

CVE-2023-35001: nf_tables nft_byteorder_eval OOB read/write

Stable 6.1 and 6.4 were fixed.

Fixed status
mainline: [caf3ef7468f7534771b5c44cd8dbd6f7f87c2cbd]
stable/6.1: [40f83dd66a823400d8592e3b71e190e3ad978eb5]
stable/6.4: [b79c09c2bf2d7643902a6ef26152de602c5c5e4b]

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

