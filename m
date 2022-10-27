Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8684C433FE
	for <webhook@archiver.kernel.org>; Thu, 27 Oct 2022 00:56:35 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web09.1382.1666832187250323417
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Oct 2022 17:56:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=CzsI6/QI;
 spf=pass (domain: miraclelinux.com, ip: 209.85.218.47, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ej1-f47.google.com with SMTP id bj12so233537ejb.13
        for <cip-dev@lists.cip-project.org>; Wed, 26 Oct 2022 17:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fJu0sdB+MqVJLzfEpsffUD0EIS5bCeatc0L4ajZ18Vc=;
        b=CzsI6/QImnQ6II6KYsn7FJkkf0HTwCa2FU9XVeJUJmh+LuQBVvVdWyuIXlbtc5j1UK
         2eoEGAy8VRBQBUX7ePK+TZ3o4jmlrfPdpf6ITeeXH+TZfeymisrvz6q1+KoamC36AeC4
         3rm+dMvd6/x/OeHvmLQz8lbdxvnzfbMeTrKU7Pfgg6a5NvxgbQfMlgr+R7Lm3mmSRVhb
         Svjrt7DtdULJrXhNx7meF9HzkMcF3TH2KCJOGlQHFOHmmVh5kLhXEfq/XTz+0z9Q9nIb
         I7ZT6U44+6xgRkgqwt29ugslGQzCBp1iUeXOvfd4puypurS8m6mMrrOBq0erWUN1irD+
         qm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJu0sdB+MqVJLzfEpsffUD0EIS5bCeatc0L4ajZ18Vc=;
        b=W5PMQKXoqLzylyJlqjbjSKPaCaRzvSYst4yQRvptU2+gk/mM38uyUZxPvPABGc6EOf
         Pho+NRYnGb4vrMPInoBs3vgI6u27NwIWT7BIDc77oYruvD+iZSCmwd24p2amaaVhhFY8
         ZY8O1fwcY1g1AN92SxV6/9sxJzDr0FGcfaet1Ndc19u7+6MIuGfF9vLMcc0ppQsYBJgH
         bf5T+V9mQS++56Ion74O+8csJsZUoVP0n2xmhNCQiNnanU3lVFsy8R8DQCAJ2AxPOhkG
         I+t73iZPqsfVKouzaAqqEWB1DhBz7T4JrTHKbRXlEURCEKbomZJFn6FgMISc9+IcrFwK
         4CyA==
X-Gm-Message-State: ACrzQf0AfZuYlkF3zM0yIi4J4vJpcRNGEN2ko38x/d9H/vygFt5EniHu
	bit0IIm/XBPlvIv71O069+lrXmCtBerTQg49/GGuXw0YsyVgYw==
X-Google-Smtp-Source: AMsMyM5lbvxabhgYcT5bN2ZKaPFbiCnlPB1lIe8OBn1A/L+ravJZOkvPU1rVM/zWmrFSw0Fo/14AgjBIpYyPBF3YpVk=
X-Received: by 2002:a17:907:2cd8:b0:78d:9c3c:d788 with SMTP id
 hg24-20020a1709072cd800b0078d9c3cd788mr40369250ejc.327.1666832184866; Wed, 26
 Oct 2022 17:56:24 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 27 Oct 2022 09:55:49 +0900
Message-ID: <CAODzB9obukOOdyGvXJzSwbxg7N_Z76QB_aQ7Li=ongSjrB70rQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Oct 2022 00:56:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9873

Hi !

It's this week's CVE report.

This week reported 20 new CVEs and 8 updated CVEs.
Some of CVEs's NIST CVSS v3 score get HIGH, but these exploitability
score is low, so I think there is no real critical issues in this
week.

For example, CVE-2022-3649 NIST's CVSS v3 score is 9.8 (exploitability
is 3.9) by NIST but CNA's score is 3.1(exploitability is 1.6).

* New CVEs

CVE-2022-3344: KVM: SVM: nested shutdown interception could lead to host cr=
ash

CVSS v3 score is not assigned yet.

A flaw was found in the KVM's AMD nested virtualization (SVM). A
malicious L1 guest could purposely fail to intercept the shutdown of a
cooperative nested guest (L2), possibly leading to a page fault and
kernel panic in the host (L0).

Fixed status
Patch is available(https://lore.kernel.org/lkml/20221020093055.224317-5-mle=
vitsk@redhat.com/T/)
but not merged into the mainline yet.

CVE-2022-3619: Bluetooth: L2CAP: Fix memory leak in vhci_write

CVSS v3 score is 4.3 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW(CNA).

A vulnerability has been found in Linux Kernel and classified as
problematic. This vulnerability affects the function
l2cap_recv_acldata of the file net/bluetooth/l2cap_core.c of the
component Bluetooth. The manipulation leads to memory leak.

This issue was introduced by commit 4d7ea8ee90e4 ("Bluetooth: L2CAP:
Fix handling fragmented length") in 5.12-rc1-dontuse.
So, up to 5.12 kernels are not affected by this issue.

Fixed status
Patch has been merged into bluetooth-next tree but not merged in the
mainline yet.

CVE-2022-3621: nilfs2: fix NULL pointer dereference at
nilfs_bmap_lookup_at_level()

CVSS v3 score is 7.5(NIST).
CVSS v3 score is 4.3 MEDIUM(CNA).

If the i_mode field in the inode of metadata files is corrupted on
disk, initialization of the bmap structure process will not be called
which will cause a null pointer dereference bug in
nilfs_bmap_lookup_at_level().

kernel 4.4 may be affected by this issue.

Fixed status
mainline: [21a87d88c2253350e115029f14fe2a10a7e6c856]
stable/4.14: [1ce68de30b663b79073251162123e57cbed2dc84]
stable/4.19: [fe8015680f383ea1dadec76972894dfabf8aefaa]
stable/4.9: [bb63454b66f4a73d4b267fd5061aaf3a5657172c]
stable/5.10: [3f840480e31495ce674db4a69912882b5ac083f2]
stable/5.15: [1e512c65b4adcdbdf7aead052f2162b079cc7f55]
stable/5.19: [caf2c6b580433b3d3e413a3d54b8414a94725dcd]
stable/5.4: [792211333ad77fcea50a44bb7f695783159fc63c]
stable/6.0: [037e760a4a009e9545a51e87c98c22d9aaf32df7]

CVE-2022-3623: mm/hugetlb: fix races when looking up a CONT-PTE/PMD
size hugetlb page

CVSS v3 score is 7.5 HIGH(NIST).
CVSS v3 score is 5.0 MEDIUM(CNA).

A race condition issue was found in arm64 hugepage table feature.
This issue was introduced by commit 5480280 ("arm64/mm: enable HugeTLB
migration for contiguous bit HugeTLB pages") in 5.1-rc1.
So, kernel 4.x series are not affected by this issue

NIST's CVSS score is high but it's exploitability is 1.6 so I think
it's not critical as NIST's score says.

Fixed status
mainline: [fac35ba763ed07ba93154c95ffc0c4a55023707f]
stable/5.19: [86a913d55c89dd13ba070a87f61a493563e94b54]
stable/6.0: [7c7c79dd5a388758f8dfa3de89b131d5d84f25fd]

CVE-2022-3640: Bluetooth: L2CAP: fix use-after-free in l2cap_conn_del()

CVSS v3 score is 8.8 HIGH(NIST).
CVSS v3 score is 5.5 MEDIUM(CNA).

A vulnerability, which was classified as critical, was found in Linux
Kernel. Affected is the function l2cap_conn_del of the file
net/bluetooth/l2cap_core.c of the component Bluetooth. The
manipulation leads to use after free.

NIST's CVSS score is high but it's exploitability is 2.8 so I think
it's not critical as NIST's score says.

This issue was introduced by commit d0be8347c623 ("Bluetooth: L2CAP:
Fix use-after-free caused by l2cap_chan_put") in 5.19. This commit was
backported to stable kernels. CIP 4.4 kernels don't have this patch.

Fixed status
mainline: [d0be8347c623e0ac4202a1d4e0373882821f56b0]
stable/4.14: [5bb395334392891dffae5a0e8f37dbe1d70496c9]
stable/4.19: [bbd1fdb0e1adf827997a93bf108f20ede038e56e]
stable/4.9: [d255c861e268ba342e855244639a15f12d7a0bf2]
stable/5.10: [de5d4654ac6c22b1be756fdf7db18471e7df01ea]
stable/5.15: [f32d5615a78a1256c4f557ccc6543866e75d03f4]
stable/5.4: [098e07ef0059296e710a801cdbd74b59016e6624]

CVE-2022-3646: nilfs2: fix leak of nilfs_root in case of writer thread
creation failure

CVSS v3 score is 5.3 MEDIUM(NIST).
CVSS v3 score is 3.1 LOW(CNA).

A memory leak bug was found in nilfs2 subsystem. If
nilfs_attach_log_writer() faild to create log write thread, some data
are not freed by cleanup process.
This issue was introduced by commit e912a5b ("nilfs2: use root object
to get ifile") in v2.6.37-rc1 so that all stable kernels will be
affected by this issue.

Fixed status
mainline: [d0d51a97063db4704a5ef6bc978dddab1636a306]
stable/4.14: [a832de79d82ac8c9f445f99069e11b17c5d2224a]
stable/4.19: [4b748ef0f2afadd31c914623daa610f26385a4dc]
stable/4.9: [81fe58e4e7f61a1f5200898e7cd4c9748f83051f]
stable/5.10: [aad4c997857f1d4b6c1e296c07e4729d3f8058ee]
stable/5.15: [44b1ee304bac03f1b879be5afe920e3a844e40fc]
stable/5.19: [4755fcd844240857b525f6e8d8b65ee140fe9570]
stable/5.4: [b7e409d11db9ce9f8bc05fcdfa24d143f60cd393]
stable/6.0: [9dc48a360e7b6bb16c48625f8f80ab7665bc9648]

CVE-2022-3649: nilfs2: fix use-after-free bug of struct nilfs_root

CVSS v3 score is 9.8 CRITICAL(NIST).
CVSS v3 score is 3.1 LOW(CNA).

A use-after-free bug was found in nilfs2 subsystem. If inode bitmap
area is corrupted on disk, subsequent calls to nilfs_clear_inode()
will use a freed object which causes a use-after-free bug.

NIST's CVSS score is high but it's exploitability is 3.9 so I think
it's not critical as NIST's score says.

Fixed status
mainline: [d325dc6eb763c10f591c239550b8c7e5466a5d09]
stable/4.14: [26b9b66610d6f8f3333cb6f52e97745da875fee1]
stable/4.19: [bfc82a26545b5f61a64d51ca2179773706fb028f]
stable/4.9: [a9043a24c6e340d45b204d294a25044726fd2770]
stable/5.10: [21ee3cffed8fbabb669435facfd576ba18ac8652]
stable/5.15: [cb602c2b654e26763226d8bd27a702f79cff4006]
stable/5.19: [394b2571e9a74ddaed55aa9c4d0f5772f81c21e4]
stable/5.4: [d1c2d820a2cd73867b7d352e89e92fb3ac29e926]
stable/6.0: [6251c9c0430d70cc221d0bb907b278bd99d7b066]

CVE-2022-3238: ntfs3 local privilege escalation if NTFS character set
and remount and umount called simultaneously

CVSS v3 score is not assigned yet.

A double free bug found in ntfs3 file system. When character set is
set for ntfs3 file system at mount time, then remount and unmount will
release character set string twice that will cause system crash or
privilege escalation.
To exploit this bug, an attacker must have permission to mount a file
system(CAP_SYS_ADMIN).

The ntfs3 driver was introduced in 5.15 so before this versions are
not affected by this issue.

Fixed status
Not fixed yet.

CVE-2022-3577: An out-of-bounds memory write flaw was found in the
Linux kernel=E2=80=99s Kid-friendly Wired Controller driver

CVSS v3 score is 7.8 HIGH.

An out-of-bounds memory write flaw was found in the Linux kernel=E2=80=99s
Kid-friendly Wired Controller driver. This flaw allows a local user to
crash or potentially escalate their privileges on the system. It is in
bigben_probe of drivers/hid/hid-bigbenff.c. The reason is incorrect
assumption - bigben devices all have inputs. However, malicious
devices can break this assumption, leaking to out-of-bound write.

NIST's CVSS score is high but it's exploitability is 1.8 so I think
it's not critical as NIST's score says.

Commit fc4ef9d ("HID: bigben: fix slab-out-of-bounds Write in
bigben_probe") is the main fix for out-of-bounds memory write bug.
Commit 945a9a8 ("media: pvrusb2: fix memory leak in pvr_probe") and
9d64d24 ("binderfs: rework superblock destruction") fixes memory leak
issue it is reported by in CVE-2022-3577

The slab-out-of-bounds was in drivers/hid/hid-bigbenff.c was
introduced by commit 256a90e ("HID: hid-bigbenff: driver for BigBen
Interactive PS3OFMINIPAD gamepad") in 4.20-rc1. 4.4, 4.9, 4.14, and
4.19 are not affected by this issue.

Fixed status
mainline: [fc4ef9d5724973193bfa5ebed181dba6de3a56db,
945a9a8e448b65bec055d37eba58f711b39f66f0,
           9d64d2405f7d30d49818f6682acd0392348f0fdb]
stable/4.14: [ba7dd8a9686a61a34b3a7b922ce721378d4740d0,
ba7dd8a9686a61a34b3a7b922ce721378d4740d0]
stable/4.19: [491762b3250fb06a0c97b5198656ea48359eaeed]
stable/4.9: [2fe46195d2f0d5d09ea65433aefe47a4d0d0ff4d]
stable/5.10: [296f8ca0f73f5268cd9b85cf72ff783596b2264e,
bacb37bdc2a21c8f7fdc83dcc0dea2f4ca1341fb]
stable/5.15: [22e0b0b84c538b60bdf8eeceee7ab3cebf4a1a09,
f2f6e67522916f53ad8ccd4dbe68dcf76e9776e5]
stable/5.4: [00771de7cc28e405f5ae19ca46facd83a534bb8f,
466b67c0543b2ae67814d053f6e29b39be6b33bb]

CVE-2022-3586: A use-after-free bug was found in net/sched/sch_sfb.c

CVSS v3 score is 5.5 MEDIUM.

A flaw was found in the Linux kernel=E2=80=99s networking code. A
use-after-free was found in the way the sch_sfb enqueue function used
the socket buffer (SKB) cb field after the same SKB had been enqueued
(and freed) into a child qdisc. This flaw allows a local, unprivileged
user to crash the system, causing a denial of service.

This issue was introduced by commit e13e02a ("net_sched: SFB flow
scheduler") in v2.6.39-rc1 so kernel 4.4 will be affected too.

Fixed status
mainline: [9efd23297cca530bb35e1848665805d3fcdd7889]
stable/4.14: [a7af71bb5ee6e887d49f098e212ef4f2f7cfbaf6]
stable/4.19: [9245ed20950afe225bc6d1c4b9d28d55aa152e25]
stable/4.9: [b5aa83141aa97f81c8e06051e4bd925bfb5474fb]
stable/5.10: [2ee85ac1b29dbd2ebd2d8e5ac1dd5793235d516b]
stable/5.15: [1a889da60afc017050e1f517b3b976b462846668]
stable/5.4: [279c7668e354fa151d5fd2e8c42b5153a1de3135]

CVE-2022-3595: A double free bug was found in cifs subsystem

CVSS v3 score is 5.5 MEDIUM (NIST).
CVSS v3 score is 3.5 LOW (CNA).

A vulnerability was found in Linux Kernel. It has been rated as
problematic. Affected by this issue is the function sess_free_buffer
of the file fs/cifs/sess.c of the component CIFS Handler. The
manipulation leads to double free. It is recommended to apply a patch
to fix this issue. The identifier of this vulnerability is VDB-211364.

This issue was introduced by a4e430c ("cifs: replace kfree() with
kfree_sensitive() for sensitive data") in 6.1-rc1 and fixed by commit
b854b4e ("cifs: fix double-fault crash during ntlmssp") in 6.1-rc1. No
released kernels are affected by this issue.

Fixed status
mainline: [b854b4ee66437e6e1622fda90529c814978cb4ca]

CVE-2022-3624: A memory leak bug was found in drivers/net/bonding/bond_alb.=
c

CVSS v3 score is 3.3 LOW (NIST).
CVSS v3 score is 3.5 LOW (CNA).

A vulnerability was found in Linux Kernel and classified as
problematic. Affected by this issue is the function rlb_arp_xmit of
the file drivers/net/bonding/bond_alb.c of the component IPsec. The
manipulation leads to memory leak. It is recommended to apply a patch
to fix this issue. The identifier of this vulnerability is VDB-211928.

Commit d5410ac ("net:bonding:support balance-alb interface with vlan
to bridge") is not backported to stable kernels so they are not
affected by this issue.

Fixed status
mainline: [4f5d33f4f798b1c6d92b613f0087f639d9836971]

CVE-2022-3625: A use-after-free bug was found in  net/core/devlink.c

CVSS v3 score is 7.8 HIGH (NIST).
CVSS v3 score is 3.5 LOW (CNA).

A vulnerability was found in Linux Kernel. It has been classified as
critical. This affects the function
devlink_param_set/devlink_param_get of the file net/core/devlink.c of
the component IPsec. The manipulation leads to use after free. It is
recommended to apply a patch to fix this issue. The identifier
VDB-211929 was assigned to this vulnerability.

NIST's CVSS score is high but it's exploitability is 1.8 so I think
it's not critical as NIST's score says.

This issue was introduced by commit Commit fixes 98bbf70c1c41 ("mlxsw:
spectrum: add "acl_region_rehash_interval" devlink param") in 5.1-rc1.
This commit is not backported to 4.x kernels. so, these kernels aren't
affected by this issue.

Fixed status
mainline: [6b4db2e528f650c7fb712961aac36455468d5902]
stable/5.10: [0e28678a770df7989108327cfe86f835d8760c33]
stable/5.15: [c4d09fd1e18bac11c2f7cf736048112568687301]
stable/5.4: [1ad4ba9341f15412cf86dc6addbb73871a10212f]

CVE-2022-3629: A memory leak bug was found in net/vmw_vsock/af_vsock.c

CVSS v3 score is 3.3 LOW (NIST).
CVSS v3 score is 2.6 LOW (CNA).

A vulnerability was found in Linux Kernel. It has been declared as
problematic. This vulnerability affects the function vsock_connect of
the file net/vmw_vsock/af_vsock.c of the component IPsec. The
manipulation leads to memory leak. It is recommended to apply a patch
to fix this issue. VDB-211930 is the identifier assigned to this
vulnerability.

This issue was introduced by commit d021c34 ("VSOCK: Introduce VM
Sockets") in 3.9-rc1 so that 4.4 will be affected too.

Fixed status
mainline: [7e97cfed9929eaabc41829c395eb0d1350fccb9d]
stable/4.14: [ec0a5b730cc053202df6b6e6dd6c860977990646]
stable/4.19: [2fc2a7767f661e6083f69588718cdf6f07cb9330]
stable/4.9: [09fc7ffdf11d20049f3748ccdef57c9a49403214]
stable/5.10: [38ddccbda5e8b762c8ee06670bb1f64f1be5ee50]
stable/5.15: [e4c0428f8a6fc8c218d7fd72bddd163f05b29795]
stable/5.4: [f82f1e2042b397277cd39f16349950f5abade58d]

CVE-2022-3630: A memory leak bug was found in fs/fscache/cookie.c

CVSS v3 score is 5.5 MEDIUM (NIST).
CVSS v3 score is 3.1 LOW (CNA).

A vulnerability was found in Linux Kernel. It has been rated as
problematic. This issue affects some unknown processing of the file
fs/fscache/cookie.c of the component IPsec. The manipulation leads to
memory leak. It is recommended to apply a patch to fix this issue. The
associated identifier of this vulnerability is VDB-211931.

This issue was introduced by commit 85e4ea1 ("fscache: Fix
invalidation/lookup race") in 5.19-rc6. This commit is not backported
to stable kernels so that they are not affected by this issue.
The commit 85e4ea1 fixes d24af13 ("fscache: Implement cookie
invalidation") in 5.17-rc1. The commit d24af13 is not backported to
stable kernels too.

Fixed status
mainline: [fb24771faf72a2fd62b3b6287af3c610c3ec9cf1]

CVE-2022-3633: A memory leak bug was found in net/can/j1939/transport.c

CVSS v3 score is 3.3 LOW (NIST).
CVSS v3 score is 3.5 LOW (CNA).

A vulnerability classified as problematic has been found in Linux
Kernel. Affected is the function j1939_session_destroy of the file
net/can/j1939/transport.c of the component IPsec. The manipulation
leads to memory leak. It is recommended to apply a patch to fix this
issue. The identifier of this vulnerability is VDB-211932.

This issue was introduced by commit 9d71dd0 ("can: add support of SAE
J1939 protocol") in 5.4-rc1 which is not backported to older stable
kernels.

Fixed status
mainline: [8c21c54a53ab21842f5050fa090f26b03c0313d6]
stable/5.10: [a220ff343396bae8d3b6abee72ab51f1f34b3027]
stable/5.15: [98dc8fb08299ab49e0b9c08daedadd2f4de1a2f2]
stable/5.4: [04e41b6bacf474f5431491f92e981096e8cc8e93]

CVE-2022-3635: A use-after-free bug was found in drivers/atm/idt77252.c

CVSS v3 score is 7.0 HIGH(NIST).
CVSS v3 score is 5.5 MEDIUM (CNA).

A vulnerability, which was classified as critical, has been found in
Linux Kernel. Affected by this issue is the function tst_timer of the
file drivers/atm/idt77252.c of the component IPsec. The manipulation
leads to use after free. It is recommended to apply a patch to fix
this issue. VDB-211934 is the identifier assigned to this
vulnerability.

NIST's CVSS score is high but it's exploitability is 1.0 so I think
it's not critical as NIST's score says.

kernel 4.4 will be affected by this issue.

Fixed status
mainline: [3f4093e2bf4673f218c0bf17d8362337c400e77b]
stable/4.14: [3db3f3bf05a88635beb7391fca235fb0e5213e6f]
stable/4.19: [52fddbd9754b249546c89315787075b7247b029d]
stable/4.9: [acf173d9e27877ac1f4b0fc6614bf7f19ac90894]
stable/5.10: [a0ae122e9aeccbff75014c4d36d11a9d32e7fb5e]
stable/5.15: [a5d7ce086fe942c5ab422fd2c034968a152be4c4]
stable/5.4: [9a6cbaa50f263b12df18a051b37f3f42f9fb5253]

CVE-2022-3636: A use-after-free bug was found in
drivers/net/ethernet/mediatek/mtk_ppe.c

CVSS v3 score is 7.8 HIGH(NIST).
CVSS v3 score is 5.5 MEDIUM (CNA).

A vulnerability, which was classified as critical, was found in Linux
Kernel. This affects the function __mtk_ppe_check_skb of the file
drivers/net/ethernet/mediatek/mtk_ppe.c of the component Ethernet
Handler. The manipulation leads to use after free. It is recommended
to apply a patch to fix this issue. The associated identifier of this
vulnerability is VDB-211935.

This issue was introduced by commit 33fc42d ("net: ethernet:
mtk_eth_soc: support creating mac address based offload entries") in
5.19-rc1. This issue was introduced in 5.19-rc1 and fixed in 5.19-rc1.
Released kernels aren't affected by this issue.

NIST's CVSS score is high but it's exploitability is 1.8 so I think
it's not critical as NIST's score says.

Fixed status
mainline: [17a5f6a78dc7b8db385de346092d7d9f9dc24df6]

CVE-2022-3642: Using uninitialized data in rtl8188f_spur_calibration()
in drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW (CNA).

A vulnerability classified as problematic has been found in Linux
Kernel. This affects the function rtl8188f_spur_calibration of the
file drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_8188f.c of the
component Wireless. The manipulation of the argument
hw_ctrl_s1/sw_ctrl_s1 leads to use of uninitialized variable. It is
recommended to apply a patch to fix this issue. The associated
identifier of this vulnerability is VDB-211959.

This issue was found in wireless-next[0] tree and fixed in
wireless-next tree[1]. These code haven't been merged into mainline
yet.
So, mainline and stable kernels aren't affected.

0: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.g=
it/commit/?id=3D80e5acb6dd72b25a6e6527443b9e9c1c3a7bcef6
1: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.g=
it/commit/?id=3Dc888183b21f36a247bb166ca9365705611bea847

Fixed status
Fixed in the wireless-next tree. mainline and stable kernels aren't affecte=
d.

CVE-2022-43750: usb: mon: make mmapped memory read only

CVSS v3 score is not provided.

When user space application writing data via mmap(2) to /dev/usbmon ,
it can corrupt usb monitor's internal memory.
That result will be system crash, use-after-free, and etc.
Commit a659daf ("usb: mon: make mmapped memory read only") disallows
/dev/usbmon devices with VM_WRITE. Therefore, it will break an
existing user application if it uses mmap(2) with VM_WRITE flag.
This issue was introduced by commit 6f23ee1 ("USB: add binary API to
usbmon") in 2.6.21-rc1 so 4.4 will be affected.

Fixed status
mainline: [a659daf63d16aa883be42f3f34ff84235c302198]
stable/4.14: [b29f76fcf2db6615b416d98e28c7d81eff4c89a2]
stable/4.19: [bf7e2cee3899ede4c7c6548f28159ee3775fb67f]
stable/4.9: [1b5ad3786a2f2cdbfed34071aa467f80e4903a0b]
stable/5.10: [1b257f97fec43d7a8a4c9ada8538d14421861b0a]
stable/5.15: [5ff80339cdc3143b89eee2ad91ae44b4dbf65ad1]
stable/5.4: [21446ad9cb9844b90d7d8e73d8fff03160e51ebc]
stable/6.0: [08e2c70e549b77f5f3af9c76da00779d5756f997]

* Updated CVEs

CVE-2022-2602: io_uring/af_unix: defer registered files gc to io_uring rele=
ase

5.10, 5.15, 5.4, 5.19 and 6.0 were fixed.

Fixed status
mainline: [0091bfc81741b8d3aeb3b7ab8636f911b2de6e80]
stable/5.10: [c378c479c5175833bb22ff71974cda47d7b05401]
stable/5.15: [813d8fe5d30388f73a21d3a2bf46b0a1fd72498c]
stable/5.19: [b4293c01ee0d0ecdd3cb5801e13f62271144667a]
stable/5.4: [04df9719df1865f6770af9bc7880874af0e594b2]
stable/6.0: [75e94c7e8859e58aadc15a98cc9704edff47d4f2]

CVE-2022-3535: net: mvpp2: fix mvpp2 debugfs leak

4.19, 5.10, 5.15, 5.19 5.4, and 6.0 were fixed.

Fixed status
mainline: [0152dfee235e87660f52a117fc9f70dc55956bb4]
  stable/4.19: [84e2394b0be397f7198986aa9a28207f70b29bd4]
  stable/5.10: [29f50bcf0f8b9e49c3c9b0e08fcae2ec3a88cc9f]
  stable/5.15: [a624161ebe0c678c10c4c82b574fed6c04d552d8]
  stable/5.19: [169aa2664639de359a7c723ba55023ef57c0dc15]
  stable/5.4: [72c0d361940aec02d114d6f8f351147b85190464]
  stable/6.0: [218dbb2ef8597b837c1a8f248ad176c5f3f5b464]

CVE-2022-3541: eth: sp7021: fix use after free bug in
spl2sw_nvmem_get_mac_address

5.19 and 6.0 were fixed.

Fixed status
mainline: [12aece8b01507a2d357a1861f470e83621fbb6f2]
stable/5.19: [b47bc8202b31a2677a344322b3c4b7f8750c5e66]
stable/6.0: [99e229c7fe30a1661f9f306b3df06eaf1db064aa]

CVE-2022-3542: bnx2x: fix potential memory leak in bnx2x_tpa_stop()

4.14, 4.19, 4.9, 5.10, 5.15, 5.19, 5.4, and 6.0 were fixed.

Fixed status
mainline: [b43f9acbb8942b05252be83ac25a81cec70cc192]
stable/4.14: [f63e896e78c247d0be8165d99d543a28ca0be360]
stable/4.19: [70421f9708d4cf14c2bd15de58862a3d22e00bbe]
stable/4.9: [9ec3f783f08b57a861700fdf4d3d8f3cfb68f471]
stable/5.10: [6cc0e2afc6a137d45b9523f61a1b1b16a68c9dc0]
stable/5.15: [0b6516a4e3eb0e2dc88a538458f3f732940f44fd]
stable/5.19: [96c0c14135f5803f9e94e6da2ee9c4b012fdcb20]
stable/5.4: [71e0ab5b7598d88001762fddbfeb331543c62841]
stable/6.0: [a712737af79b4a9a75f9abbf812279062da75777]

CVE-2022-3543: af_unix: Fix memory leaks of the whole sk due to OOB skb.

5.19 and 6.0 were fixed.

Fixed status
mainline: [7a62ed61367b8fd01bae1e18e30602c25060d824]
stable/5.19: [e2e49822a0a16d306bf6fe0009fe3136a3318f36]
stable/6.0: [2f415ad33bc1a729fb1050141921b5a9ec4e062c]

CVE-2022-3565: mISDN: fix use-after-free bugs in l1oip timer handlers

4.14, 4.19, 4.9, 5.10, 5.15, 5.19, 5.4, and 6.0 were fixed.

Fixed status
mainline: [2568a7e0832ee30b0a351016d03062ab4e0e0a3f]
stable/4.14: [cbd342376a4e7ea481891181910e9e995390eb24]
stable/4.19: [27f74a47d5b1cf52d48af15993bb1caa31ad8f5b]
stable/4.9: [1ba21168faf881c23c270605834d01af260cbb72]
stable/5.10: [2a1d0363208528a3bacbc2c37264d60182efd482]
stable/5.15: [7bfa18b05f381162c9d38192bbf0179f1142dd38]
stable/5.19: [1f76323ac43fe0b00677794c930dee9f66ea2999]
stable/5.4: [466ed722f205c2cf8caba5982f3cd9729e767903]
stable/6.0: [5c9422e2d8563a3efe064493ff7ebbc2948441ea]

CVE-2022-3594: r8152: Rate limit overflow messages

4.14, 4.19, 4.9, 5.10, 5.15, 5.19, 5.4, and 6.0 were fixed.

Fixed status
mainline: [93e2be344a7db169b7119de21ac1bf253b8c6907]
stable/4.14: [f5d6c938d51217d6f0f534f1ee606d9c5eb22fdc]
stable/4.19: [88d2a93972c369eb812952aa15a25c1385506c1d]
stable/4.9: [3723658c287a98875f43cffc3245d0bf1d3ee076]
stable/5.10: [484400d433ca1903a87268c55f019e932297538a]
stable/5.15: [b3179865cf7e892b26eedab3d6c54b4747c774a2]
stable/5.19: [2e896abccf99fef76691d8e1019bd44105a12e1f]
stable/5.4: [61fd56b0a1a3e923aced4455071177778dd59e88]
stable/6.0: [21f2532974115026fdab1205aab275d6181fb89f]

CVE-2022-40768: scsi: stex: properly zero out the passthrough command struc=
ture

4.14, 4.19, and 4.9 were fixed.

Fixed status
mainline: [6022f210461fef67e6e676fd8544ca02d1bcfa7a]
stable/4.14: [5c8395d775ca9044b361af4a19b2ff223485be35]
stable/4.19: [a99c5e38dc6c3dc3da28489b78db09a4b9ffc8c3]
stable/4.9: [35db0282da84ad200054ad5af0fd6c2f693b17f8]
stable/5.10: [36b33c63515a93246487691046d18dd37a9f589b]
stable/5.15: [76efb4897bc38b2f16176bae27ae801037ebf49a]
stable/5.19: [6ae8aa5dcf0d7ada07964c8638e55d3af5896a86]
stable/5.4: [20a5bde605979af270f94b9151f753ec2caf8b05]
stable/6.0: [b9b7369d89924a366b20045dc26dc4dc6b0567a4]

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

