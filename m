Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5F9C44501
	for <webhook@archiver.kernel.org>; Wed,  8 Jul 2026 22:31:27 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.20154.1783549878693898876
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jul 2026 15:31:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20251104.gappssmtp.com header.s=20251104 header.b=KjZn0lBW;
 spf=pass (domain: miraclelinux.com, ip: 209.85.128.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81062fdeaf5so5273537b3.0
        for <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 15:31:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783549878; cv=none;
        d=google.com; s=arc-20260327;
        b=loZwAtHDIGW0KNUmhUYfVRJwz5F7K/2IP8lquGykVSfRXxEoJHMKSZhwZnLHFKwmUD
         qVCuezbS148RSu8ZyAt4zRbHx1+0jS+Pxbg+sQaIY/B5Z2B7wkDmvofy5TrE5NtBU/iN
         VbHptd0HvSTBoqav4nOdDOrA//Rv42lc7SQa5bXvAcLKrAE9W5VuM2MHPkukbYM/SKzb
         sEpmX2dzYXEsZrE6kPY0mLc1P7bx9Mtfg+cMK3cHPy9lKahLdlmhAZ9LNTwgh8RBAm49
         7bcWjR/vrGKxgpvnni7C+mqROhiSRjWOZDQPYBPZcdti5qtNm8fmm49Zpj36EooCyNBC
         fbdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CUGzBT3VJJD9OH8itdLJUVXYyZlAKvJqIENlBKP6zEE=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=YKUUasFHR5nBe33I2Cb3PSLLc2xkTx3gy0sJSAo+kZkBGFJiK8qYGDLqpIwc66uq5s
         jfYloKTNQw3S2nzgBdfZuSYsRzdYXrv5mLT5jyAygoWN5bFuVKR8cMA/wA8Z1mjJBktU
         ZwwnmUWkE9K5n8/VGrdIBFZC9QhKVT0XeKyYvdvP4Z7ZKhrFFMZkHK3gdIDzL44C+FSt
         Pw4aQRuxvu7bN95umYMNDoPgdch1GVX4duXzQaQWj3HdS710r9ttmrkbzF/vOAszg6hr
         yZHQ4hiHOSFijFdx/ljUpSYTezYPjqEtpbzOG2z2EpVhLWUFd5R3vMMhU9bAd49R0QFO
         GJLw==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20251104.gappssmtp.com; s=20251104; t=1783549878; x=1784154678; darn=lists.cip-project.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=CUGzBT3VJJD9OH8itdLJUVXYyZlAKvJqIENlBKP6zEE=;
        b=KjZn0lBWA8ylFtB6XHsLA+feEACSFQ4tWPgOL8fP5vrQjBei/bQYxxK9fOUqWqV2z9
         nYHExrF9eBawdveh1/+VRGSQGQwT02RCAxnpaTFr+m3u8lGrzmv/u1mupYVcfJVcPMcf
         srC4zMr0luYCBs60TMG/8VA6oZ2K9gOj1uwoOeeSdCtpBxEvaN9pqg0qfP0OMaqCimnA
         Cv6FrmEkwUs3rX2vfj8zj2FcKpsAHjUCU8kfJPhAOXeqSN7/AcJlbYAg9JckkCox1b+e
         noOOPQsE2VseHP9EicjGfaDcxvLnNXF1v0WW34QVGH7T9PmacIplkXcYb5TjfaTopB34
         7txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549878; x=1784154678;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CUGzBT3VJJD9OH8itdLJUVXYyZlAKvJqIENlBKP6zEE=;
        b=U1lH+U3TGGf6KpuLpd4zGmcd53mruBzRfE7jnAbP7aVt3NqtT1Hz8sLJVm9bO2x8ze
         zKJqLA9dgn/8HCJ6wu45i8ji3PsFI/7g736MCdasSg2TEwqvyzxYnePi7kpeC/KFkPFA
         vV8YvJne9Yyg0wAexg77L5ilet1yNUfEpZ+uJRj2YuFwSAK6wU802Jpy3yzpmbmcAjIC
         MRqcesMXiWZItX8LhEOvIfWdmdjZR7IrSqgnBKzDfbWQQdbv7b2t+9AUUBwl3IpcSy4c
         EDzVZ4Nl82jtQPwCYkO7oyvRagnwjSFBtGhVIuhnP5m1wakX4xQjHntgl7PPfdIHNmTU
         ka1g==
X-Gm-Message-State: AOJu0Yz7a+kRvdWDiMjIqRVjhaGAgXZHGgdU8qK7QWQ6nn4PGbdEfFjC
	Vs3cuUhJ2wg1cwnxUMug8AySJtGCxHl0tvQyUbLjiO6qnn0XlAFuZJBTcUc5QKuwzGs2iXQsW0c
	62Few/A/Ly08FJ1w3bqoGS8Hx9iDzBQXkzoPDKUQn1lbSndzMh8rFaIarQg==
X-Gm-Gg: AfdE7cmwgCI3pl5alvpFUV8k78go07caU7aJffah2nISpRo/TxnyhHJhHoHdsKgut7K
	pAloOAsV+HVlBPtF+S4wsOcDvrtecyftLDedkY1DQGUMYohkZXHVyeN6qTrejrLvQe1sW7J68xG
	Mx6u0W2lv4ji+jMaolOfc3+TBjdy+ANy5OVF61G8KIIX7+WM2gQgS2BSNiS/3wS1Gady7ZvhQ66
	6AniwROOnv7dW572VLP3FU0tcGxm8tbPP4aVbl6gKjnH9NTXRPqY/LrTuGeWgRyQV/cr4MJf7bb
	L37bvp5kc7M5kghWcdLJBeaWkEA6EpgzMJK6UUIGCwLqZb2AjdUaC5M=
X-Received: by 2002:a05:690c:e3e3:b0:80e:3b:17 with SMTP id
 00721157ae682-81e6cfc7327mr1921437b3.26.1783549877245; Wed, 08 Jul 2026
 15:31:17 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 9 Jul 2026 07:30:41 +0900
X-Gm-Features: AVVi8Cea_jnZ5B7uDKm4CxQLbdQG26rvGVI6uznRR_vH9iXPPz_QKcfC3RwvEh8
Message-ID: <CAODzB9pLibaKm8=9hi0GmzLFd0PKwi+6M9DDqN07u7-y7eVCaw@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jul 2026 22:31:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23551

Hi!

It's this week's CVE report.

This week reported 6 new CVEs and 44 updated CVEs.

* New CVEs
CVE-2026-53357: Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs
l2cap_conn_del()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53357

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [ab1513597c6cf17cd1ad2a21e3b045421b48e022]
stable/5.10: [751de6ec671fe75ad9cf65a0638d2a06b6a5984d]
stable/5.15: [407217734835d21d4e0105ebf347860dc1806f88]
stable/6.1: [7eebd4c2c86f573af87ff165d08a83432eb0b919]
stable/6.12: [87c543e2f78d0871f271df92dab98901bbd5b6f5]
stable/6.18: [added1213395071470a900cc845a042fb51882a6]
stable/6.6: [5d86d2f1b4d9a508c441d3e45277ae1a73cfed57]

CVE-2026-53358: Bluetooth: L2CAP: use chan timer to close channels in
cleanup_listen()

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53358

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [8c8e620467a7b51562dbcefbd1f09f288d7d710d]
stable/5.10: [3634cbdc2eb414b69ffa752ddbe5e0458518e321]
stable/5.15: [e1c100e2d61bd8c718b7d91fe3e050780a9bf72d]
stable/6.1: [deb8493a8fa599f6c95e2465b12bfdfb7f94a1d9]
stable/6.12: [50dfec218808b148ab4247b1858031b7a32015c5]
stable/6.18: [859d3ace791ed878ae9ba5522c7844d960da8f88]
stable/6.6: [89dec92041717b027216e110599e4f6d6c921b79]

CVE-2026-53359: KVM: x86: Fix shadow paging use-after-free due to
unexpected role

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53359

Introduced by commit 2032a93 ("KVM: MMU: Don't allocate gfns page for
direct mmu pages") in v2.6.36-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [81ccda30b4e83d8f5cc4fd50503c44e3a33abfeb]
stable/6.1: [b1337aae5e194324e4810d561764e7793f8b3864]
stable/6.12: [2ad3afa40ac6aa340dada122f9abfa46c0a6eb35]
stable/6.18: [5e470998a23e4c3d89ed24e8172cb22747e61efa]
stable/6.6: [9291654d69e08542de37755cebe4d5b02c3170d1]
stable/7.1: [1ae7d5a6db6c190ce183e3098ca0e0846e14d462]

CVE-2026-53360: KVM: SEV: Require in-GHCB scratch area if GHCB v2+ is in use

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53360

Introduced by commit 4af663c ("KVM: SEV: Allow per-guest configuration
of GHCB protocol version") in v6.10-rc1.
Fixed in v7.1-rc6.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [db3f2195d29344a3cf1e9dd9ab7f21ced7308cf7]
stable/6.12: [bf9ba093fbb83c0c9a3dedd50efec29424eca2fc]
stable/6.18: [c9b4198fbc6ed99a9da4bee9f74bb730f926c9ae]

CVE-2026-53361: af_unix: Set gc_in_progress to true in unix_gc().

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53361

Introduced by commit 8b90a9f ("af_unix: Run GC on only one CPU.") in v6.9-rc1.
Fixed in v7.1-rc3.

Bug introduced commit was backported to following branches.
cip/6.1 cip/6.1-rt stable/6.1 stable/6.6

Fixed status
mainline: [d82ba05263c69fa2437fe93e4e561cc40f4c03af]
stable/6.12: [591f1ac217428a6d2b32a8ac14aac0fab44f155a]
stable/6.18: [0cfa78c050662784fc8e3ab26dbfd1dc632b2082]
stable/6.6: [82c17e13d404f686e164590483fd6c1abaa675d0]

CVE-2026-53362: ipv6: account for fraggap on the paged allocation path

Announce: https://www.cve.org/CVERecord?id=CVE-2026-53362

Introduced by commit 773ba4f ("ipv6: avoid partial copy for zc") in v6.0-rc1.
Fixed in v7.2-rc1.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [736b380e28d0480c7bc3e022f1950f31fe53a7c5]
stable/6.1: [14200d435af9a9eeb444f529fc2f689a236b7962]
stable/6.12: [46f201f8b4c39633a1fa3dc12459f506d470993d]
stable/6.18: [6374fb9edf72c67a118a2c214a0dddd04c921e0a]
stable/6.6: [65fb14cbebb0cd0eff903a22d33537ddc8b95769]
stable/7.1: [e9eacf19281ea2498b36291b56c9606118c2d74e]

* Updated CVEs
CVE-2022-49803: netdevsim: Fix memory leak of nsim_dev->fa_cookie

stable/5.10 was fixed.

Fixed status
stable/5.10: [7d79725a7073d86b9185f87718e22f3d65115801]

CVE-2022-50114: net: 9p: fix refcount leak in p9_read_work() error handling

stable/5.10 was fixed.

Fixed status
stable/5.10: [9bc63a124cc20a69a126e45e3d593d5807bb5258]

CVE-2025-23131: dlm: prevent NPD when writing a positive value to event_done

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [a1c41aebb184d9228a440dcb6761224e65b0e49a]
stable/5.15: [ee28d99d789b077565cbe0377374d1e826c64d93]
stable/6.1: [c7837e2c96559663c33f43da403d9cf3cf77cfa7]
stable/6.12: [10b7a59814765d18d43555c9cef4eb3048b7e8a3]
stable/6.6: [7109d69bec6edce546dc870e66bd2b668a3d5549]

CVE-2025-39931: crypto: af_alg - Set merge to zero early in af_alg_sendmsg

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [28f6f37abca7c5c9eb3959c66310f1d4d98b8aaf]
stable/5.15: [db2b42425dfbde4983b0c20fb7cfa05f70e6a745]

CVE-2026-23052: ftrace: Do not over-allocate ftrace memory

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [23936d19e4383c8dfb03931f032473d4baf92533]
stable/6.6: [bf802b936a7b269917e4dc233e49f6a928db8286]

CVE-2026-23204: net/sched: cls_u32: use skb_header_pointer_careful()

stable/5.10 was fixed.

Fixed status
stable/5.10: [66e4b63d61c15de6ca5332d9ca6db59a404d7136]

CVE-2026-23272: netfilter: nf_tables: unconditionally bump set->nelems
before insertion

stable/6.1 was fixed.

Fixed status
stable/6.1: [25fcaef7948912652905e96922f36583a84fffed]

CVE-2026-23278: netfilter: nf_tables: always walk all pending catchall elements

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [c4d4e86fda707d89eaba80e343321737375f8582]
stable/6.6: [4830fb44d12f586f3f544609e086933649a9175a]

CVE-2026-23302: net: annotate data-races around sk->sk_{data_ready,write_space}

stable/6.1 was fixed.

Fixed status
stable/6.1: [279f2b67d1c44ee139bd3fdb221850daa9358449]

CVE-2026-31451: ext4: replace BUG_ON with proper error handling in
ext4_read_inline_folio

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3462a3f0716d27af51896dc8688bcf0628fb17ee]
stable/5.15: [636e8d85a36ab6c31aafd04ee66a69b18eebee7b]
stable/6.1: [af25a6affeac4919e8d8c5cccc01a9d53478447e]

CVE-2026-31732: gpio: Fix resource leaks on errors in
gpiochip_add_data_with_key()

stable/6.12 was fixed.

Fixed status
stable/6.12: [a500e1837c4266ddb05b39b3e1cc71f49a43ffa5]

CVE-2026-31755: usb: cdns3: gadget: fix NULL pointer dereference in ep_queue

stable/5.10 was fixed.

Fixed status
stable/5.10: [3cf0580a09d417eab41ce914a11f9cde3a121871]

CVE-2026-43010: bpf: Reject sleepable kprobe_multi programs at attach time

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [d97b19fe5265f7901b2c862f88a4eb1b129a0b61]
stable/6.6: [89327ed787746a7aa4db3c97f91d2e294228932b]

CVE-2026-43216: net: Drop the lock in skb_may_tx_timestamp()

stable/6.12 was fixed.

Fixed status
stable/6.12: [c770217044d9cbe16a1f7c385cf080ed06a2fc04]

CVE-2026-43219: net: cpsw_new: Fix potential unregister of netdev that
has not been registered yet

stable/5.10 was fixed.

Fixed status
stable/5.10: [da8e1623a3028e1d8c75eec7898d94c6f17dce40]

CVE-2026-43355: iio: light: bh1780: fix PM runtime leak on error path

stable/5.15, stable/6.12 were fixed.

Fixed status
stable/5.15: [4228f7f053b452be625919ccbb605912bae0dc98]
stable/6.12: [ad58fa1cb11e4ceb702786a494352c7ff2eca1ed]

CVE-2026-46054: selinux: fix overlayfs mmap() and mprotect() access checks

stable/6.12, stable/6.18, stable/6.6 were fixed.

Fixed status
stable/6.12: [8bacd09f12c27710228562e4d13163e58c5f4a45]
stable/6.18: [d844702198395d3f80222777030f69db6be6b709]
stable/6.6: [bc6c380c1159de52a252ed11f19a42c47f60a735]

CVE-2026-46135: nvmet-tcp: fix race between ICReq handling and queue teardown

stable/6.6 was fixed.

Fixed status
stable/6.6: [5f0b95ef68ab9afba75b20eebf436130f80c161a]

CVE-2026-46140: Bluetooth: btmtk: validate WMT event SKB length before
struct access

stable/6.6 was fixed.

Fixed status
stable/6.6: [36c85f7029484d5ede769f8873d16e9c8e35533c]

CVE-2026-46242: eventpoll: fix ep_remove struct eventpoll / struct file UAF

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9324de74a3a59b9fde9b62ee45ebaa71458ba2e5]
stable/6.6: [2de4db145b2992da496fea6c51f9839be678ae24]

CVE-2026-46252: regulator: core: fix locking in
regulator_resolve_supply() error path

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [e77357dc2293283fc08a485b1e2e571d91d02622]
stable/5.15: [a8a2eab1166bc33ee38ca371cff425bdb5681e47]
stable/6.1: [60747114fd2a38739130b715e7b2d40ce848f0be]
stable/6.12: [3b7fffd7a8984a1c009f668765ee7631fd6b87c8]
stable/6.6: [c84860dac7af7dc3c3e3c9ae86d65e222c2f3b0c]

CVE-2026-46331: net/sched: fix pedit partial COW leading to page cache
corruption

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [544d857b42a1734b923040e13aa61a6fd4746cf2]
stable/5.15: [d5d01d35a5a7d36f7cb679b67d9cbdd5205672dc]
stable/6.1: [a071e057518decc5e3bec89855758f5f8786f2c5]
stable/6.6: [b685d6ef6f07a3b5ce814565a25f39f2157538a5]

CVE-2026-52909: ip6_vti: set netns_immutable on the fallback device.

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [12acc977838c943636fb01e2f3087d2e4cc3b7cc]
stable/5.15: [7f28e3948c59481f8db9c9638e204258d26b4e41]
stable/6.1: [12c65e2c7fef507551bd7b52123598a761662c01]
stable/6.12: [c5dbd669db5a426b3025512322e1bf2cdbe14305]
stable/6.6: [f4b6b4af7ef0661ac153c6f7eb1030aa8482c1a3]

CVE-2026-52928: af_unix: Reject SIOCATMARK on non-stream sockets

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [ec123873fdc83e7244c8ed6d17b8f8ea6c416a67]
stable/6.1: [f085971de6d6b8ef946a5e0bcd73ff24509a0f85]

CVE-2026-52975: bonding: 3ad: implement proper RCU rules for port->aggregator

stable/6.12 was fixed.

Fixed status
stable/6.12: [5fb9ea4e8ebf514d92df2b6c9d0db25ba02ac735]

CVE-2026-53070: sctp: disable BH before calling udp_tunnel_xmit_skb()

stable/6.12 was fixed.

Fixed status
stable/6.12: [be3bfcb34bda04f6a350710db471d4133f950f2c]

CVE-2026-53101: wifi: mt76: mt7921: fix potential deadlock in
mt7921_roc_abort_sync

stable/6.12 was fixed.

Fixed status
stable/6.12: [b4faaa617af3f4173e64169b0ec1af8f9c5bca10]

CVE-2026-53138: drm/amd/display: Bound VBIOS record-chain walk loops

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [e94f5323c41f32a74160378c3b19850d1f203ad5]
stable/5.15: [04e271a952b8863bbafc99bd51aca4c32bff0e0d]
stable/6.1: [6723188c42ca3b34a9fce634d7a0ecc9ccd5cd56]
stable/6.6: [499c6b43a79dd684bddbd18fe8b2235aa2764db4]

CVE-2026-53139: drm/v3d: Skip CSD when it has zeroed workgroups

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [b3a8dd72b0d008ff142880b4dbe5ca37dcf962b4]
stable/6.1: [8b51c5406ad748c3d5575b66b6009b5dbbc08b80]
stable/6.12: [ad166139d123dc162e8636f0c7962516d04074e1]
stable/6.6: [abb069fdf51a9ddabcc1ed125dafe54e2089900b]

CVE-2026-53142: drm/xe/display: fix oops in suspend/shutdown without display

stable/6.12 was fixed.

Fixed status
stable/6.12: [ddf1fe4c043aa42e46aef87b815d5deeed2fcd7b]

CVE-2026-53151: rxrpc: Fix the ACK parser to extract the SACK table for parsing

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [775c5e89272a2615b72bb84f611ba66fa3b7493e]
stable/6.6: [5d1ae4e17a3ecd8561cdb4f4f70152f41039c4e1]

CVE-2026-53157: net: phonet: free phonet_device after RCU grace period

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [d59794337ea496042288c7c68356d9b9ca7f46a9]
stable/5.15: [6cd7067d6e4b0b2033ba2f918ecbd54dc2af3763]
stable/6.1: [2ec8011cce0cd0fc7a5068585d867fc08d508578]
stable/6.12: [bd2ab4d800fc26814d89328d87b5f97ef6aa906a]
stable/6.6: [09c9b92c2010481160245244ea8fa1d06d5d4ae0]

CVE-2026-53158: misc: fastrpc: Fix NULL pointer dereference in rpmsg callback

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a3d91218ccca1e990bfb737b5a6da23f0afba22b]
stable/5.15: [0d8c64511fd45690c5326f013710efcb4f73a97e]
stable/6.1: [150bf6f1193c69252580c19d3b3cd631ddce61d7]

CVE-2026-53159: misc: fastrpc: fix DMA address corruption due to find_vma misuse

stable/5.10 was fixed.

Fixed status
stable/5.10: [d43afc412d439ffca1567e7ca8652be22f272b3b]

CVE-2026-53163: locking/rtmutex: Skip remove_waiter() when waiter is
not enqueued

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [4afda3a1da02129568a3a2f1898aa13e6763bcba]
stable/6.12: [5799f9bd7fee40370b93ab1ddf001cdc7017c14d]
stable/6.6: [6707d7e0b71748cb3cd95bad81dae5fe1b3c8f48]

CVE-2026-53167: fuse: limit FUSE_NOTIFY_RETRIEVE to uptodate folios

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [feafe8ccb1584254f59fbd4946d6ca7ef1e3e99c]
stable/5.15: [651801d75ad0897dbd331b3cc6a4da3e78f60d42]
stable/6.1: [4e14f29473eda18fb2af082dd2fd4c12139862cd]
stable/6.12: [68a9282d5ea5b8780d59122505ad633e6daede90]
stable/6.6: [8bef2f840b43e0879478fe3aaa9ff2f0b80798a5]

CVE-2026-53177: bnxt_en: Fix NULL pointer dereference

stable/5.10 was fixed.

Fixed status
stable/5.10: [1449177b87f768353909e930a99b902675119b2b]

CVE-2026-53179: staging: rtl8723bs: fix buffer over-read in
rtw_update_protection

stable/6.12 was fixed.

Fixed status
stable/6.12: [c35ce55b12bb8fcd365daeb516e9782048119b36]

CVE-2026-53325: agp/amd64: Fix broken error propagation in agp_amd64_probe()

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.10: [ce800993af477fc24187349c6a20d3073140b759]
stable/5.15: [1d7d45050e14083c1de1460c93f4063c1f0bca7b]
stable/6.1: [3e844a63668d1c3d10a9d347d7ebf161b2f91c84]
stable/6.12: [564b3b3f6565313eb6fa5355ffd037d6fb27897f]
stable/6.6: [eb045714bc6a2bbb0befb7a31b996a196e188869]

CVE-2026-53326: debugobjects: Don't call fill_pool() in early boot
hardirq context

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [3cc90ea0dd0fb1f8db577dcdc027fc46c06049f6]
stable/6.12: [27335c50014102e9077b784ebd314954286afcab]
stable/6.6: [5d95f6b267f3d7fe54f42a3b224bb4a3d3990b41]

CVE-2026-53327: debugobjects: Do not fill_pool() if pi_blocked_on

stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.1: [8a680d54f1adf3e3aa815578684556716fda6f0c]
stable/6.12: [3f6a3b24ab7b9d51f6f4778254bef0e5847beb55]
stable/6.6: [a3383df76f0d7a597066df018409eb9e5e698064]

CVE-2026-53329: drm/amd/display: Use krealloc_array() in dal_vector_reserve()

stable/5.10 was fixed.

Fixed status
stable/5.10: [9540b0a4d13e4ede64ae1197d66a176d2149daa9]

CVE-2026-53332: slimbus: qcom-ngd-ctrl: Register callbacks after
creating the ngd

stable/5.10 was fixed.

Fixed status
stable/5.10: [946b97d632f0f58a705dafac644c1e9346e01f35]

CVE-2026-53341: fhandle: fix UAF due to unlocked ->mnt_ns read in
may_decode_fh()

stable/6.12 was fixed.

Fixed status
stable/6.12: [15ea8dc42a02259d49dee38a658d40f60fcd75ed]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

