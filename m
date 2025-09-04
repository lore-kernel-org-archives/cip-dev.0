Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4054CA1010
	for <webhook@archiver.kernel.org>; Thu,  4 Sep 2025 01:30:56 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
 by mx.groups.io with SMTP id smtpd.web11.29416.1756949454619203758
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 18:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=P+Dh02HG;
 spf=pass (domain: miraclelinux.com, ip: 209.85.219.179, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e9d6b6187e7so444654276.2
        for <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1756949453; x=1757554253; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0QOvj9eODfP0ApfKe3STbfd2m41rhNKieRGkkbiWh+4=;
        b=P+Dh02HGuAa6xBOu1X32wqdxJq8XJsty1vFw3Ajb3P7+YU9mUjYn/RXdSWX49dxckS
         bvonXX/ujOR4W7ic56Be555cJd0M2qnXJE5dWbeSDd7da1K/0FP94i2N1S5Qvx/cPUr5
         DA7RUymb8EgatDVgGLLi7uM9JDG0AO0XB7z63EC8PjG+ic2kIKTZ7BwblfhXI+ke3Ran
         HPqnhAu7N3627fvpfrvdEVMVKgn0/LiZZb1C8iFxyk56FOJjZnm+qcB1v6sJpjCTia5P
         Wyb76A+OhJUM1yEr6rkAwMqt/IP0MfIY7koxpsmCVFG8++e/nDVPVicbU+FsEb0z2ewo
         1R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949453; x=1757554253;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0QOvj9eODfP0ApfKe3STbfd2m41rhNKieRGkkbiWh+4=;
        b=GsQRED/im84PWElSUcajGGLbtNwdI5AYyvYqww0+dqEG9j5w6XBjhnPG1Xm8WDoW4h
         hbgdgdJUiHV1ZqUS3lgCxn127TunqW7DvrG0EqqAJ9P8jyGZfWmRvtCiibG0272AsuEC
         IhVsoRgTpw6CNGpANGPJOUCHPYq1GpPAaGjdk9c8Yo3RsuuxHaouIuvKXntBfnY5PNCK
         o0T/JWhJ3GMyHlZwjkcCROs04gu/n6ri+a/YsWVl8l7RZWA6fThbux9os8J+ofceBsXN
         CxaEDD92Tb2naES1Okfz5KQEfvnsj647Qk7SRYymicLsZycoVDBABX1NdLmY9VjnxhbC
         cUbQ==
X-Gm-Message-State: AOJu0YwWTLBT660K3ZepeDmIZknSAG9CCyhZ852V1i4DrA3gjGB2mXXB
	OyOOpsGSyLctOyG9JfsAR2E0p/pTKpXWNmeDs6rDXHojrIMaI6v5W/aw71jXQ6DpAeaj8TX87yq
	Z4AFkGEwz59kRQjXG6W+y3ZkHXl7TRVd5A8q++HSqtVvgZ4o1NpwF6DI=
X-Gm-Gg: ASbGnctcdLX6Jxb2tWrWNbuWYm+/oKYKmDtLCdw1k8aqBg/J6v20dD6ZT80m8cuGbQk
	Le42KRgGoueqYZklEifz/3wKpujASyPaBgloiYotEmbGGSNFsnI4JbEJaFPSa3p6oWCBFg34uoY
	JHHwszLVI7Z+ohxrBxvoXbuoxTFUNc6sK66Lkk03YJ2xCXdGfDavTqQIHjf1JLf32TwQxTDpGhq
	xznUKdCw7TD5zXFp1I=
X-Google-Smtp-Source: AGHT+IG123Ss9xAxy+UTSMrPff2o8aX6C3I4UVqOUIYrKVeaqhTbcjf/xT9FZ3O3/BirZVlzD69ZccqwCr8blHp1Pac=
X-Received: by 2002:a05:690e:d49:b0:600:65d0:bad with SMTP id
 956f58d0204a3-601756ab9e2mr1548787d50.3.1756949452615; Wed, 03 Sep 2025
 18:30:52 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 4 Sep 2025 10:30:16 +0900
X-Gm-Features: Ac12FXxwT9Ml6Ixt-e6XBZ2xHOyauRGneIGm_Q1L9UDaepxDZxb27JnDJ8OsD-U
Message-ID: <CAODzB9oNbKoZ4w84BKQVoi2iejsb-WR=zKZyw6Q5+PqF66M9wg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Sep 2025 01:30:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20003

Hi!

It's this week's CVE report.

This week reported 3 new CVEs and 103 updated CVEs.

* New CVEs
CVE-2024-58240: tls: separate no-async decryption request handling from async

Announce: https://www.cve.org/CVERecord?id=CVE-2024-58240

Introduced commit is not determined.Fixed in v6.8-rc7.
The kernel TLS support was added by 3c4d7559 ("tls: kernel TLS support") in
4.13-rc1. Affected function was introduced by c46234e ("tls: RX path for ktls")
in 4.17-rc1. Commit 94524d8 ("net/tls: Add support for async
decryption of tls records")
separated async and no-async operations. Commit 94524d8 was introduced
in 4.20-rc1.

Fixed status
mainline: [41532b785e9d79636b3815a64ddf6a096647d011]
stable/6.1: [48905146d11dbf1ddbb2967319016a83976953f5]
stable/6.6: [dec5b6e7b211e405d3bcb504562ab21aa7e5a64d]

CVE-2025-38677: f2fs: fix to avoid out-of-boundary access in dnode page

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38677

Introduced commit is not determined.Fixed in v6.17-rc1.
Affected function was added by e05df3b ("f2fs: add node operations") in 3.8-rc1.
The get_dnode_of_data is affcted function in the commit.

Fixed status
mainline: [77de19b6867f2740cdcb6c9c7e50d522b47847a4]
stable/5.10: [a650654365c57407413e9b1f6ff4d539bf2e99ca]
stable/5.15: [6b7784ea07e6aa044f74b39d6b5af5e28746fc81]
stable/5.4: [ee4d13f5407cbdf1216cc258f45492075713889a]
stable/6.1: [901f62efd6e855f93d8b1175540f29f4dc45ba55]
stable/6.12: [888aa660144bcb6ec07839da756ee46bfcf7fc53]
stable/6.6: [92ef491b506a0f4dd971a3a76f86f2d8f5370180]

CVE-2025-38678: netfilter: nf_tables: reject duplicate device on updates

Announce: https://www.cve.org/CVERecord?id=CVE-2025-38678

Introduced by commit 78d9f48 ("netfilter: nf_tables: add devices to
existing flowtable") in v5.8-rc1.
Introduced by commit b9703ed ("netfilter: nf_tables: support for
adding new devices to an existing netdev chain") in v6.4-rc1.
Fixed in v6.17-rc2.

Bug introduced commit is not backported to older stable kernels.

Fixed status
mainline: [cf5fb87fcdaaaafec55dcc0dc5a9e15ead343973]

* Updated CVEs

CVE-2021-46987: btrfs: fix deadlock when cloning inline extents and
using qgroups

stable/5.10 was fixed.

Fixed status
stable/5.10: [f8fbbd06fab9b75dcd68d850fe318ac3bc128974]

CVE-2021-47070: uio_hv_generic: Fix another memory leak in error handling paths

stable/5.10 was fixed.

Fixed status
stable/5.10: [261bbd90cc53d2835343f056770156cf1e82cf03]

CVE-2021-47076: RDMA/rxe: Return CQE error if invalid lkey was supplied

stable/5.10 was fixed.

Fixed status
stable/5.10: [a81e72d49b0648f68ab201163dbfc7841056d7a2]

CVE-2021-47183: scsi: lpfc: Fix link down processing to address NULL
pointer dereference

stable/5.10 was fixed.

Fixed status
stable/5.10: [04c1af683270e4709a594bb1691b8800b945035a]

CVE-2021-47193: scsi: pm80xx: Fix memory leak during rmmod

stable/5.10 was fixed.

Fixed status
stable/5.10: [0c4398f2ee030d5753f6b0ad83f0ed9077851d9a]

CVE-2021-47412: block: don't call rq_qos_ops->done_bio if the bio isn't tracked

stable/5.10 was fixed.

Fixed status
stable/5.10: [db60edbfff332a6a5477c367af8125f034570989]

CVE-2021-47421: drm/amdgpu: handle the case of pci_channel_io_frozen
only in amdgpu_pci_resume

stable/5.10 was fixed.

Fixed status
stable/5.10: [785cc093b6b5a93cc350421a55f3f1eda6585156]

CVE-2021-47455: ptp: Fix possible memory leak in ptp_clock_register()

stable/5.10 was fixed.

Fixed status
stable/5.10: [f1c96d8085588e1b997a96214b409ac3be20b524]

CVE-2021-47498: dm rq: don't queue request to blk-mq during DM suspend

stable/5.10 was fixed.

Fixed status
stable/5.10: [8050652810bf38241edec8717393d2446e8036f1]

CVE-2022-4269: kernel: net: CPU soft lockup in TC mirred
egress-to-ingress action

stable/5.4 was fixed.

Fixed status
stable/5.4: [6b1a3968fb6b33c0a6e7c1f2caef09dddd2f6a6a]

CVE-2022-50070: mptcp: do not queue data on closed subflows

stable/5.15 was fixed.

Fixed status
stable/5.15: [fb9c73ef2ac2ec816efdc8b9267bc04e1369c20b]

CVE-2023-33288: power: supply: bq24190: Fix use after free bug in
bq24190_remove due to race condition

stable/5.4 was fixed.

Fixed status
stable/5.4: [4a1b82ee331903aa56f4aeea33fb1244e63355f3]

CVE-2023-52572: cifs: Fix UAF in cifs_demultiplex_thread()

stable/5.4 was fixed.

Fixed status
stable/5.4: [fe87e2d0e6265859c659a3ef1e2559a83c5e8e68]

CVE-2024-26958: nfs: fix UAF in direct writes

stable/5.4 was fixed.

Fixed status
stable/5.4: [6cd3f13aaa62970b5169d990e936b2e96943bc6a]

CVE-2024-42085: usb: dwc3: core: remove lock of otg mode during gadget
suspend/resume to avoid deadlock

stable/5.10 was fixed.

Fixed status
stable/5.10: [8731a0b180f6b5d52397c7aeea6eda9511a467a7]

CVE-2024-53237: Bluetooth: fix use-after-free in device_for_each_child()

stable/5.4 was fixed.

Fixed status
stable/5.4: [6894717a1ea363c5a27010ba604f957c309d282d]

CVE-2024-57937: [REJECTED]: mm: reinstate ability to map write-sealed
memfd mappings read-only

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [b7cbdcf37d590a34f90092655298f0f3bdbb358e]
stable/5.15: [1c296cba6568ee9f16e4e0e4ff9f129efae2a10b]
stable/6.1: [54aeb486404fcfcc6316c9c09c25f3653ee4cd5f]
stable/6.6: [2e4179698f84f9b20a392b53b1a940713c56d6f0]

CVE-2024-57996: net_sched: sch_sfq: don't allow 1 packet limit

stable/5.4 was fixed.

Fixed status
stable/5.4: [e12f6013d0a69660e8b99bfe381b9546ae667328]

CVE-2025-21884: net: better track kernel sockets lifetime

stable/6.6 was fixed.

Fixed status
stable/6.6: [2668e038800b946d269f96ec1b258c01930a242c]

CVE-2025-21912: gpio: rcar: Use raw_spinlock to protect register access

stable/5.10 was fixed.

Fixed status
stable/5.10: [389891ac9f678baf68e13623ef1308493af4b074]

CVE-2025-37752: net_sched: sch_sfq: move the limit validation

stable/5.4 was fixed.

Fixed status
stable/5.4: [8fadc871a42933aacb7f1ce9ed9a96485e2c9cf4]

CVE-2025-37798: codel: remove sch->q.qlen check before
qdisc_tree_reduce_backlog()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [cc71a757da78dd4aa1b4a9b19cb011833730ccf2]
stable/5.15: [eda741fe155ddf5ecd2dd3bfbd4fc3c0c7dbb450]
stable/5.4: [7a742a9506849d1c1aa71e36c89855ceddc7d58e]

CVE-2025-37925: jfs: reject on-disk inodes of an unsupported type

stable/5.15 was fixed.

Fixed status
stable/5.15: [fa6ce4a9cc9fcc8150b80db6f65186c0ed2b3143]

CVE-2025-37932: sch_htb: make htb_qlen_notify() idempotent

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [32ae12ce6a9f6bace186ca7335220ff59b6cc3cd]
stable/5.15: [967955c9e57f8eebfccc298037d4aaf3d42bc1c9]

CVE-2025-37953: sch_htb: make htb_deactivate() idempotent

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a9945f7cf1709adc5d2d31cb6cfc85627ce299a8]
stable/5.15: [c2d25fddd867ce20a266806634eeeb5c30cb520c]

CVE-2025-38095: dma-buf: insert memory barrier before updating num_fences

stable/5.10 was fixed.

Fixed status
stable/5.10: [90eb79c4ed98a4e24a62ccf61c199ab0f680fa8f]

CVE-2025-38165: bpf, sockmap: Fix panic when calling skb_linearize

stable/5.15 was fixed.

Fixed status
stable/5.15: [4dba44333a11522df54b49aa1f2edfaf6ce35fc7]

CVE-2025-38177: sch_hfsc: make hfsc_qlen_notify() idempotent

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [72c61ffbeeb8c50f6d4d70c65d3283aa1bac57a7]
stable/5.15: [a5efc95a33bd4fcb879250852828cc58c7862970]
stable/5.4: [9a5fd5c2f4d4afdd5e405083ee53e0789ce76956]

CVE-2025-38193: net_sched: sch_sfq: reject invalid perturb period

stable/5.4 was fixed.

Fixed status
stable/5.4: [e0936ff56be4e08ad5b60ec26971eae0c40af305]

CVE-2025-38322: perf/x86/intel: Fix crash in icl_update_topdown_event()

stable/6.1 was fixed.

Fixed status
stable/6.1: [702ea6028032d6c1fe96c2d4762a3575e3654819]

CVE-2025-38335: Input: gpio-keys - fix a sleep while atomic with PREEMPT_RT

stable/5.15 was fixed.

Fixed status
stable/5.15: [664e5a6f541ff226621487d1280d2ec28e86be28]

CVE-2025-38347: f2fs: fix to do sanity check on ino and xnid

stable/5.10, stable/5.15, stable/5.4, stable/6.1 were fixed.

Fixed status
stable/5.10: [ecff54aa20b5b21db82e63e46066b55e43d72e78]
stable/5.15: [c4029044cc408b149e63db7dc8617a0783a3f10d]
stable/5.4: [44e904a1ad09e84039058dcbbb1b9ea5b8d7d75d]
stable/6.1: [e98dc1909f3d5bc078ec7a605524f1e3f4c0eb14]

CVE-2025-38351: KVM: x86/hyper-v: Skip non-canonical addresses during
PV TLB flush

stable/6.6 was fixed.

Fixed status
stable/6.6: [d5784ea45663330eaa868c518ea40e7a9f06aa2d]

CVE-2025-38375: virtio-net: ensure the received length does not exceed
allocated size

stable/5.10, stable/5.4 were fixed.

Fixed status
stable/5.10: [ddc8649d363141fb3371dd81a73e1cb4ef8ed1e1]
stable/5.4: [773e95c268b5d859f51f7547559734fd2a57660c]

CVE-2025-38468: net/sched: Return NULL when htb_lookup_leaf encounters
an empty rbtree

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [5c0506cd1b1a3b145bda2612bbf7fe78d186c355]
stable/5.15: [850226aef8d28a00cf966ef26d2f8f2bff344535]
stable/5.4: [fed3570e548a6c9f95c5f4c9e1a7afc1679fd90d]

CVE-2025-38470: net: vlan: fix VLAN 0 refcount imbalance of toggling
filtering during runtime

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [35142b3816832889e50164d993018ea5810955ae]
stable/5.15: [047b61a24d7c866c502aeeea482892969a68f216]
stable/5.4: [ba48d3993af23753e1f1f01c8d592de9c7785f24]

CVE-2025-38473: Bluetooth: Fix null-ptr-deref in l2cap_sock_resume_cb()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [2b27b389006623673e8cfff4ce1e119cce640b05]
stable/5.15: [3a4eca2a1859955c65f07a570156bd2d9048ce33]
stable/5.4: [262cd18f5f7ede6a586580cadc5d0799e52e2e7c]

CVE-2025-38474: usb: net: sierra: check for no status endpoint

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [5408cc668e596c81cdd29e137225432aa40d1785]
stable/5.15: [a6a238c4126eb3ddb495d3f960193ca5bb778d92]
stable/5.4: [0a263ccb905b4ae2af381cd4280bd8d2477b98b8]

CVE-2025-38476: rpl: Fix use-after-free in rpl_do_srh_inline().

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [c09e21dfc08d8afb92d9ea3bee3457adbe3ef297]
stable/5.15: [8ba6c2362b85089b8972ac5f20b24fc71a4b8ffc]

CVE-2025-38477: net/sched: sch_qfq: Fix race condition on qfq_aggregate

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d841aa5518508ab195b6781ad0d73ee378d713dd]
stable/5.15: [c6df794000147a3a02f79984aada4ce83f8d0a1e]
stable/5.4: [aa7a22c4d678bf649fd3a1d27debec583563414d]

CVE-2025-38478: comedi: Fix initialization of data for instructions
that write to subdevice

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [13e4d9038a1e869445a996a3f604a84ef52fe8f4]
stable/5.15: [020eed5681d0f9bced73970368078a92d6cfaa9c]
stable/5.4: [6f38c6380c3b38a05032b8881e41137385a6ce02]

CVE-2025-38480: comedi: Fix use of uninitialized data in insn_rw_emulate_bits()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [16256d7efcf7acc9f39abe21522c4c6b77f67c00]
stable/5.15: [c53570e62b5b28bdb56bb563190227f8307817a5]
stable/5.4: [4c2981bf30401adfcdbfece4ab6f411f7c5875a1]

CVE-2025-38481: comedi: Fail COMEDI_INSNLIST ioctl if n_insns is too large

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [c68257588e87f45530235701a42496b7e9e56adb]
stable/5.15: [69dc06b9514522de532e997a21d035cd29b0db44]
stable/5.4: [454d732dfd0aef7d7aa950c409215ca06d717e93]

CVE-2025-38482: comedi: das6402: Fix bit shift out of bounds

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [de8da1063cce9234d55c8270d9bdf4cf84411c80]
stable/5.15: [73f34d609397805c20d6b2ef5c07a4cbf7c4d63a]
stable/5.4: [a15e9c175f783298c4ee48146be6841335400406]

CVE-2025-38483: comedi: das16m1: Fix bit shift out of bounds

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d1291c69f46d6572b2cf75960dd8975d7ab2176b]
stable/5.15: [b3c95fa508e5dc3da60520eea92a5241095ceef1]
stable/5.4: [539bdff832adac9ea653859fa0b6bc62e743329c]

CVE-2025-38487: soc: aspeed: lpc-snoop: Don't disable channels that
aren't enabled

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [9e1d2b97f5e2a36a2fd30a8bd30ead9dac5e3a51]
stable/5.15: [166afe964e8433d52c641f5d1c09102bacee9a92]
stable/5.4: [62e51f51d97477ea4e78c82e7076a171dac86c75]

CVE-2025-38488: smb: client: fix use-after-free in crypt_message when
using async crypto

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [5d047b12f86cc3b9fde1171c02d9bccf4dba0632]
stable/5.15: [6550b2bef095d0dd2d2c8390d2ea4c3837028833]

CVE-2025-38491: mptcp: make fallback action and fallback decision atomic

stable/6.1 was fixed.

Fixed status
stable/6.1: [5586518bec27666c747cd52aabb62d485686d0bf]

CVE-2025-38494: HID: core: do not bypass hid_hw_raw_request

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [40e25aa7e4e0f2440c73a683ee448e41c7c344ed]
stable/5.15: [f10923b8d32a473b229477b63f23bbd72b1e9910]
stable/5.4: [dd8e8314f2ce225dade5248dcfb9e2ac0edda624]

CVE-2025-38495: HID: core: ensure the allocated report buffer can
contain the reserved report ID

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [9f2892f7233a8f1320fe671d0f95f122191bfbcd]
stable/5.15: [7fa83d0043370003e9a0b46ab7ae8f53b00fab06]
stable/5.4: [7228e36c7875e4b035374cf68ca5e44dffa596b2]

CVE-2025-38497: usb: gadget: configfs: Fix OOB read on empty string write

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d68b7c8fefbaeae8f065b84e40cf64baf4cc0c76]
stable/5.15: [15a87206879951712915c03c8952a73d6a74721e]
stable/5.4: [78b41148cfea2a3f04d87adf3a71b21735820a37]

CVE-2025-38499: clone_private_mnt(): make sure that caller has
CAP_SYS_ADMIN in the right userns

stable/5.15 was fixed.

Fixed status
stable/5.15: [36fecd740de2d542d2091d65d36554ee2bcf9c65]

CVE-2025-38527: smb: client: fix use-after-free in cifs_oplock_break

stable/5.15 was fixed.

Fixed status
stable/5.15: [4256a483fe58af66a46cbf3dc48ff26e580d3308]

CVE-2025-38528: bpf: Reject %p% format string in bprintf-like helpers

stable/5.15 was fixed.

Fixed status
stable/5.15: [97303e541e12f1fea97834ec64b98991e8775f39]

CVE-2025-38529: comedi: aio_iiro_16: Fix bit shift out of bounds

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [5ac7c60439236fb691b8c7987390e2327bbf18fa]
stable/5.15: [c593215385f0c0163015cca4512ed3ff42875d19]
stable/5.4: [a88692245c315bf8e225f205297a6f4b13d6856a]

CVE-2025-38530: comedi: pcl812: Fix bit shift out of bounds

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [0489c30d080f07cc7f09d04de723d8c2ccdb61ef]
stable/5.15: [29ef03e5b84431171d6b77b822985b54bc44b793]
stable/5.4: [374d9b3eb4b08407997ef1fce96119d31e0c0bc4]

CVE-2025-38535: phy: tegra: xusb: Fix unbalanced regulator disable in
UTMI PHY mode

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [ceb645ac6ce052609ee5c8f819a80e8881789b04]
stable/5.15: [cdcb0ffd6448f6be898956913a42bd08e59fb2ae]

CVE-2025-38538: dmaengine: nbpfaxi: Fix memory corruption in probe()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [aec396b4f736f3f8d2c28a9cd2924a4ada57ae87]
stable/5.15: [24861ef8b517a309a4225f2793be0cd8fa0bec9e]
stable/5.4: [84fff8e6f11b9af1407e273995b5257d99ff0cff]

CVE-2025-38539: tracing: Add down_write(trace_event_sem) when adding trace event

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [db45632479ceecb669612ed8dbce927e3c6279fc]
stable/5.15: [ca60064ea03f14e06c763de018403cb56ba3207d]
stable/5.4: [e70f5ee4c8824736332351b703c46f9469ed7f6c]

CVE-2025-38548: hwmon: (corsair-cpro) Validate the size of the
received input buffer

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [2e6f4d9cfbda52700c126c5a2b93dd2042e8680c]
stable/5.15: [4eb5cc48399f89b63acdbfe912fa5c8fe2900147]

CVE-2025-38550: ipv6: mcast: Delay put pmc->idev in mld_del_delrec()

stable/5.15 was fixed.

Fixed status
stable/5.15: [6e4eec86fe5f6b3fdbc702d1d36ac2a6e7ec0806]

CVE-2025-38552: mptcp: plug races between subflow fail and subflow creation

stable/6.1 was fixed.

Fixed status
stable/6.1: [c476d627584b7589a134a8b48dd5c6639e4401c5]

CVE-2025-38553: net/sched: Restrict conditions for adding duplicating
netems to qdisc tree

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [f088b6ebe8797a3f948d2cae47f34bfb45cc6522]
stable/5.15: [cab2809944989889f88a1a8b5cff1c78460c72cb]
stable/5.4: [ad340a4b4adb855b18b3666f26ad65c8968e2deb]

CVE-2025-38555: usb: gadget : fix use-after-free in composite_dev_cleanup()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [2db29235e900a084a656dea7e0939b0abb7bb897]
stable/5.15: [8afb22aa063f706f3343707cdfb8cda4d021dd33]
stable/5.4: [dba96dfa5a0f685b959dd28a52ac8dab0b805204]

CVE-2025-38563: perf/core: Prevent VMA split of buffer mappings

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d52451a9210f2e5a079ba052918c93563518a9ff]
stable/5.15: [3bd518cc7ea61076bcd725e36ff0e690754977c0]
stable/5.4: [e4346ffec2c44d6b0be834d59b20632b5bb5729e]

CVE-2025-38565: perf/core: Exit early on perf_mmap() fail

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [9b90a48c7de828a15c7a4fc565d46999c6e22d6b]
stable/5.15: [de85e72598d89880a02170a1cbc27b35a7d978a9]
stable/5.4: [5ffda7f3ed76ec8defc19d985e33b3b82ba07839]

CVE-2025-38569: benet: fix BUG when creating VFs

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [975e73b9102d844a3dc3f091ad631c56145c8b4c]
stable/5.15: [f80b34ebc579216407b128e9d155bfcae875c30f]
stable/5.4: [3697e37e012bbd2bb5a5b467689811ba097b2eff]

CVE-2025-38572: ipv6: reject malicious packets in ipv6_gso_segment()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [3f638e0b28bde7c3354a0df938ab3a96739455d1]
stable/5.15: [09ff062b89d8e48165247d677d1ca23d6d607e9b]
stable/5.4: [5dc60b2a00ed7629214ac0c48e43f40af2078703]

CVE-2025-38574: pptp: ensure minimal skb length in pptp_xmit()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [26672f1679b143aa34fca0b6046b7fd0c184770d]
stable/5.15: [5de7513f38f3c19c0610294ee478242bea356f8c]
stable/5.4: [97b8c5d322c5c0038cac4bc56fdbe237d0be426f]

CVE-2025-38576: powerpc/eeh: Make EEH driver device hotplug safe

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [502f08831a9afb72dc98a56ae6504da43e93b250]
stable/5.15: [f56e004b781719d8fdf6c9619b15caf2579bc1f2]

CVE-2025-38577: f2fs: fix to avoid panic in f2fs_evict_inode

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [9535e440fe5bc6c5ac7cfb407e53bf788b8bf8d4]
stable/5.15: [5cd99d5aa3d39086bdb53eb5c52df16e98b101a0]
stable/5.4: [15df59809c54fbd687cdf27efbd2103a937459be]

CVE-2025-38578: f2fs: fix to avoid UAF in f2fs_sync_inode_meta()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [4dcd830c420f2190ae32f03626039fde7b57b2ad]
stable/5.15: [1edf68272b8cba2b2817ef1488ecb9f0f84cb6a0]
stable/5.4: [37e78cad7e9e025e63bb35bc200f44637b009bb1]

CVE-2025-38579: f2fs: fix KMSAN uninit-value in extent_info usage

stable/5.15 was fixed.

Fixed status
stable/5.15: [08e8ab00a6d20d5544c932ee85a297d833895141]

CVE-2025-38581: crypto: ccp - Fix crash when rebind ccp device for ccp.ko

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [ce63a83925964ab7564bd216bd92b80bc365492e]
stable/5.15: [20c0ed8dd65834e6bab464f54cd6ff68659bacb9]
stable/5.4: [a25ab6dfa0ce323ec308966988be6b675eb9d3e5]

CVE-2025-38583: clk: xilinx: vcu: unregister pll_post only if
registered correctly

stable/5.15 was fixed.

Fixed status
stable/5.15: [7e903da71f8bec4beb7c06707900e1ed8db843ca]

CVE-2025-38601: wifi: ath11k: clear initialized flag for deinit-ed srng lists

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [3a6daae987a829534636fd85ed6f84d5f0ad7fa4]
stable/5.15: [eff3bb53c18c0ed4ab6f43d412b3ed3aecad52d5]

CVE-2025-38602: iwlwifi: Add missing check for alloc_ordered_workqueue

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b398120fbe0acfef60b16f6a0f69902d385d7728]
stable/5.15: [2e9f85ee3b46453a2f250a57d3a9f10c70c71202]
stable/5.4: [c80832d445653baba5ac80cd2c2637c437ac881b]

CVE-2025-38604: wifi: rtl818x: Kill URBs before clearing tx status queue

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [789415771422f4fb9f444044f86ecfaec55df1bd]
stable/5.15: [c73c773b09e313278f9b960303a2809b8440bac6]
stable/5.4: [e64732ebff9e24258e7326f07adbe2f2b990daf8]

CVE-2025-38608: bpf, ktls: Fix data corruption when using
bpf_msg_pop_data() in ktls

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [849d24dc5aed45ebeb3490df429356739256ac40]
stable/5.15: [73fc5d04009d3969ff8e8574f0fd769f04124e59]
stable/5.4: [6ba20ff3cdb96a908b9dc93cf247d0b087672e7c]

CVE-2025-38609: PM / devfreq: Check governor before using governor->name

stable/5.15 was fixed.

Fixed status
stable/5.15: [f0479e878d4beb45e73c03e574c59f0a23ccd176]

CVE-2025-38611: vmci: Prevent the dispatching of uninitialized payloads

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [b097d921efb5bb150066365287ff046b8c8b29f5]
stable/5.15: [a85dc83857497fa1f68a9b23e7213949d4cb51ea]
stable/5.4: [2c86366ce37f398e20fa09e7e9dc8788fbf6cf0c]

CVE-2025-38612: staging: fbtft: fix potential memory leak in
fbtft_framebuffer_alloc()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [c3b1c45c48117ed4d8797ee89d1155f16b72d490]
stable/5.15: [3290f62f23fae05f2ec34085eb86dfb3648ef91f]
stable/5.4: [83ea0c7b8d12c67f6c4703d6c458627a7fc45fc0]

CVE-2025-38614: eventpoll: Fix semi-unbounded recursion

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [71379495ab70eaba19224bd71b5b9b399eb85e04]
stable/6.1: [1b13b033062824495554e836a1ff5f85ccf6b039]
stable/6.6: [2a0c0c974bea9619c6f41794775ae4b97530e0e6]

CVE-2025-38616: tls: handle data disappearing from under the TLS ULP

stable/6.6 was fixed.

Fixed status
stable/6.6: [f1fe99919f629f980d0b8a7ff16950bffe06a859]

CVE-2025-38617: net/packet: fix a race in packet_set_ring() and
packet_notifier()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [7da733f117533e9b2ebbd530a22ae4028713955c]
stable/5.15: [ba2257034755ae773722f15f4c3ad1dcdad15ca9]
stable/5.4: [18f13f2a83eb81be349a9757ba2141ff1da9ad73]

CVE-2025-38618: vsock: Do not allow binding to VMADDR_PORT_ANY

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [d1a5b1964cef42727668ac0d8532dae4f8c19386]
stable/5.15: [cf86704798c1b9c46fa59dfc2d662f57d1394d79]
stable/5.4: [c04a2c1ca25b9b23104124d3b2d349d934e302de]

CVE-2025-38622: net: drop UFO packets in udp_rcv_segment()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [df6ad849d59256dcc0e2234844ef9f0daf885f5c]
stable/5.15: [4c1022220b1b6fea802175e80444923a3bbf93a5]
stable/5.4: [72f97d3cb791e26492236b2be7fd70d2c6222555]

CVE-2025-38623: PCI: pnv_php: Fix surprise plug detection and recovery

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [6e7b5f922901585b8f11e0d6cda12bda5c59fc8a]
stable/5.15: [2ec8ec57bb8ebde3e2a015eff80e5d66e6634fe3]

CVE-2025-38624: PCI: pnv_php: Clean up allocated IRQs on unplug

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [8c1ad4af160691e157d688ad9619ced2df556aac]
stable/5.15: [912e200240b6f9758f0b126e64a61c9227f4ad37]

CVE-2025-38630: fbdev: imxfb: Check fb_add_videomode to prevent null-ptr-deref

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [f00c29e6755ead56baf2a9c1d3c4c0bb40af3612]
stable/5.15: [cca8f5a3991916729b39d797d01499c335137319]
stable/5.4: [69373502c2b5d364842c702c941d1171e4f35a7c]

CVE-2025-38634: power: supply: cpcap-charger: Fix null check for
power_supply_get_by_name

stable/5.15 was fixed.

Fixed status
stable/5.15: [4ebbb9106aaa2fd58e0359bc3a2490953db2ef0c]

CVE-2025-38635: clk: davinci: Add NULL check in davinci_lpsc_clk_register()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [7843412e5927dafbb844782c56b6380564064109]
stable/5.15: [2adc945b70c4d97e9491a6c0c9f3b217a9eecfba]
stable/5.4: [77e9ad7a2d0e2a771c9e0be04b9d1639413b5f13]

CVE-2025-38639: netfilter: xt_nfacct: don't assume acct name is null-terminated

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [e021a1eee196887536a6630c5492c23a4c78d452]
stable/5.15: [b10cfa2de13d28ddd03210eb234422b7ec92725a]
stable/5.4: [66d41268ede1e1b6e71ba28be923397ff0b2b9c3]

CVE-2025-38645: net/mlx5: Check device memory pointer before usage

stable/5.15 was fixed.

Fixed status
stable/5.15: [9053a69abfb5680c2a95292b96df5d204bc0776f]

CVE-2025-38650: hfsplus: remove mutex_lock check in hfsplus_free_extents

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [fdd6aca652122d6e97787e88d7dd53ddc8b74e7e]
stable/5.15: [14922f0cc92e010b160121679c0a6ca072f4e975]
stable/5.4: [0807e4ac59a546f2346961c5e26a98901594b205]

CVE-2025-38652: f2fs: fix to avoid out-of-boundary access in devs.path

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [1cf1ff15f262e8baf12201b270b6a79f9d119b2d]
stable/5.15: [666b7cf6ac9aa074b8319a2b68cba7f2c30023f0]
stable/5.4: [dc0172c74bd9edaee7bea2ebb35f3dbd37a8ae80]

CVE-2025-38663: nilfs2: reject invalid file types when reading inodes

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [2cf0c4130bf340be3935d097a3dcbfefdcf65815]
stable/5.15: [98872a934ea6a95985fb6a3655a78a5f0c114e82]
stable/5.4: [dd298c0b889acd3ecaf48b6e840c9ab91882e342]

CVE-2025-38664: ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [435462f8ab2b9c5340a5414ce02f70117d0cfede]
stable/5.15: [7c5a13c76dd37e9e4f8d48b87376a54f4399ce15]
stable/5.4: [35370d3b44efe194fd5ad55bac987e629597d782]

CVE-2025-38666: net: appletalk: Fix use-after-free in AARP proxy probe

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [82d19a70ced28b17a38ebf1b6978c6c7db894979]
stable/5.15: [186942d19c0222617ef61f50e1dba91e269a5963]
stable/5.4: [b35694ffabb2af308a1f725d70f60fd8a47d1f3e]

CVE-2025-38668: regulator: core: fix NULL dereference on unbind due to
stale coupling data

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [6c49eac796681e250e34156bafb643930310bd4a]
stable/5.15: [ca9bef9ba1a6be640c87bf802d2e9e696021576a]
stable/5.4: [7574892e259bbb16262ebfb4b65a2054a5e03a49]

CVE-2025-38670: arm64/entry: Mask DAIF in cpu_switch_to(), call_on_irq_stack()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [407047893a64399f2d2390ff35cc6061107d805d]
stable/6.1: [a6b0cb523eaa01efe8a3f76ced493ba60674c6e6]

CVE-2025-38671: i2c: qup: jump out of the loop in case of timeout

stable/5.10, stable/5.15, stable/5.4 were fixed.

Fixed status
stable/5.10: [acfa2948be630ad857535cb36153697f3cbf9ca9]
stable/5.15: [d05ec13aa3eb868a60dc961b489053a643863ddc]
stable/5.4: [cbec4406998185e0311ae97dfacc649f9cd79b0b]

CVE-2025-38676: iommu/amd: Avoid stack buffer overflow from kernel cmdline

stable/5.10, stable/5.15, stable/6.1, stable/6.12, stable/6.16,
stable/6.6 were fixed.

Fixed status
stable/5.10: [a732502bf3bbe859613b6d7b2b0313b11f0474ac]
stable/5.15: [0ad8509b468fa1058f4f400a1829f29e4ccc4de8]
stable/6.1: [9ff52d3af0ef286535749e14e3fe9eceb39a8349]
stable/6.12: [4bdb0f78bddbfa77d3ab458a21dd9cec495d317a]
stable/6.16: [736db11c86f03e717fc4bf771d05efdf10d23acb]
stable/6.6: [8f80c633cba144f721d38d9380f23d23ab7db10e]



Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

