Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96C8C433EF
	for <webhook@archiver.kernel.org>; Thu, 23 Dec 2021 00:49:06 +0000 (UTC)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by mx.groups.io with SMTP id smtpd.web11.27240.1640220544587727296
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 16:49:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=YSlXqQbA;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.52,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f52.google.com with SMTP id
 j3-20020a056830014300b0058f4f1ef3c2so1001937otp.13
        for <cip-dev@lists.cip-project.org>;
 Wed, 22 Dec 2021 16:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=JTRLOHZFfn35s8KV6EF9zGCviAJ2CGEsspFqnHTGR3c=;
        b=YSlXqQbAjej18+UKflH08pgpuUzxBQ2WK9b/G0SMLyAyXtLdX3oqmzAdEyylkCoHot
         DyCsYcV6XEXpKWEnuzPENYIrJrixsoRPxNEdz30lIeWfTOz6mccVTsf0Q9eBLV73dzEx
         v9vpIPtUWu3+fRzxIRh9Ptdp7awpf+LbbUdTjcOxVG4PSheAZ8fRRQehJ3lIOuwIDeIV
         ZNYAiEEW98MMCnSQefhM9/E5HI78ArEVqJra47aq7LfNxBhoHgd2miSV5NH+WGy13OhX
         xm9cdctnUK9Tfm5kFVCMpzOD894I5leTFCNF/eYxSqBPfJUihwnJQBCDSvIIa04sQk3I
         g5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JTRLOHZFfn35s8KV6EF9zGCviAJ2CGEsspFqnHTGR3c=;
        b=hAdfWIJ2kzbK2nAtSvNN6+LY5u1NpErgu4j+7qTzdWQe7g8N9AFCacZeYVkfauKNGT
         14D+R58moeRCWKVGubYsKz0K63Mils08VoU7w+ZX3hlH+EofJ4Iad6x9/lJeFkprJo2g
         G83Fr2XGqHi6s5y89s5in+8xjobkGSqT3RsbDM6lVcAAmOwEf9FUyoyBl4+boouLxffx
         B9t0VFTrNp5ir8rz3AY1/StakkpG3/UjGpWj5rPALrUUuRq9o1v3+k0twoKosHKAZ14Z
         mRszn48ouORLj09+SG0l/mGIyFHPf9FbEh8nneCDq7mAwST1KpzLUDoyqnY3DDjTdHEI
         Mwmw==
X-Gm-Message-State: AOAM533nUGowU8dzgwjcnVxBuFfAwLSQ3XVG73x20nHDIvMffGycEeOi
	utSZd3XsnjJtHrSeZqtJyUx6t/rp7V2tcOaaQl6ziXLYHmruOw==
X-Google-Smtp-Source: 
 ABdhPJzAWEu2xdTzkTMQhHEnZ+GDpJn6VwP+DBuVID5f5H06eE9WR8MFrKHkvARCG06vunz6pMo0tBBZaqG4ZGWN2vY=
X-Received: by 2002:a05:6830:1e48:: with SMTP id
 e8mr22001otj.232.1640220543495;
 Wed, 22 Dec 2021 16:49:03 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 23 Dec 2021 09:48:27 +0900
Message-ID: 
 <CAODzB9o_D8pjO0Y5r=Nv1+TyHcfjjPAKM-Vsjuo8QKEVzDXT0A@mail.gmail.com>
Subject: New CVE entries in this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Dec 2021 00:49:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7260

Hi !

It's this week's CVE report.

This week reported 12 new CVEs. Some of them aren't fixed yet.

* New CVEs

CVE-2021-44733: tee: handle lookup of shm with reference count 0

CVSS v3 score is not provided

UFA bug in TEE subsystem. This bug will cause a local attacker could
do privilege escalation.
Patch is being reviewed. This bug was introduced by 967c9cca2cc5
("tee: generic TEE subsystem") which has been merged since 4.12-rc1.
The tee driver was merged since 4.12-rc1 so before this version aren't affected.

Fixed status

not fixed yet.

CVE-2021-45095: phonet: refcount leak in pep_sock_accep

CVSS v3 score is not provided

This issue is a refcount leak in pep_sock_accep(). It's been fixed in
the mainline.

Fixed status

mainline: [bcd0f93353326954817a4f9fa55ec57fb38acbb0]

CVE-2021-45100: ksmbd: disable SMB2_GLOBAL_CAP_ENCRYPTION for SMB 3.1.1

CVSS v3 score is not provided

The ksmbd server sometimes communicates in cleartext even through
encryption is enabled.
A patch was acked but not merged into mainline yet as of 2021/12/17.
The fs/ksmbd was moved/renamed from fs/cifs since 5.15-rc1 by commit
1a93084 ("ksmbd: move fs/cifsd to fs/ksmbd").

The patch modifies init_smb3_11_server() and decode_compress_ctxt().
However these functions aren't found in stable/5.10, stable/4.19, and
stable/4.4 trees.

Fixed status

not fixed yet.

CVE-2021-28711: Rogue backends can cause DoS of guests via high
frequency events (blkfront)
CVE-2021-28712: Rogue backends can cause DoS of guests via high
frequency events (netfront)
CVE-2021-28713: Rogue backends can cause DoS of guests via high
frequency events (hvc_xen(console))

CVSS v3 scores are not provided

CVE-2021-28711, CVE-2021-28712, and CVE-2021-28713 are Xen subsystem
bugs that are related to XSA-319.
Each backend is assigned to a CVE and has its own patch.

- blkfront: CVE-2021-28711
- netfront: CVE-2021-28712
- hvc_xen(console): CVE-2021-28713

Above CVEs are fixed in mainline and all stable kernels.

Fixed status

CVE-2021-28711
mainline: [0fd08a34e8e3b67ec9bd8287ac0facf8374b844a]
stable/4.14: [5ac3b68b79c9e964dd6f3cf80ff825518e502b79]
stable/4.19: [269d7124bcfad2558d2329d0fe603ca20b20d3f4]
stable/4.4: [3e04b9e6aa7d77287e70a400be83060d2b7b2cfe]
stable/4.9: [25898389795bd85d8e1520c0c75c3ad906c17da7]
stable/5.10: [8ac3b6ee7c9ff2df7c99624bb1235e2e55623825]
stable/5.15: [caf9b51829a50590b84daea924a0fd62d32bc952]
stable/5.4: [4ed9f5c511ce95cb8db05ff82026ea901f45fd76]

CVE-2021-28712
mainline: [b27d47950e481f292c0a5ad57357edb9d95d03ba]
stable/4.14: [4bf81386e3d6e5083c93d51eff70260bcec091bb]
stable/4.19: [3559ca594f15fcd23ed10c0056d40d71e5dab8e5]
stable/4.4: [81900aa7d7a130dec4c55b68875e30fb8c9effec]
stable/4.9: [99120c8230fdd5e8b72a6e4162db9e1c0a61954a]
stable/5.10: [d31b3379179d64724d3bbfa87bd4ada94e3237de]
stable/5.15: [a29c8b5226eda52e6d6ff151d9343558ea3ad451]
stable/5.4: [3e68d099f09c260a7dee28b99af02fe6977a9e66]

CVE-2021-28713
mainline: [fe415186b43df0db1f17fa3a46275fd92107fe71]
stable/4.14: [68b78f976ca47d52c03c41eded207a312e46b934]
stable/4.19: [57e46acb3b48ea4e8efb1e1bea2e89e0c6cc43e2]
stable/4.4: [c7eaa5082bccfc00dfdb500ac6cc86d6f24ca027]
stable/4.9: [728389c21176b2095fa58e858d5ef1d2f2aac429]
stable/5.10: [8fa3a370cc2af858a9ba662ca4f2bd0917550563]
stable/5.15: [153d1ea3272209fc970116f09051002d14422cde]
stable/5.4: [560e64413b4a6d9bd6630e350d5f2e6a05f6ffe3]

CVE-2021-28714, CVE-2021-28715: Guest can force Linux netback driver
to hog large amounts of kernel memory

CVSS v3 scores are not provided

CVE-2021-28714 and CVE-2021-28715 are Xen subsystem bugs that are
related to XSA-392.
These CVEs are fixed in mainline and all stable kernels.

Fixed status

CVE-2021-28714
mainline: [6032046ec4b70176d247a71836186d47b25d1684]
stable/4.14: [eae85b8c6e17d3e3888d9159205390e8dbcff6a8]
stable/4.19: [1de7644eac41981817fb66b74e0f82ca4477dc9d]
stable/4.9: [1f66dc775092e5a353e0155fc3aca5dabce77c63]
stable/5.10: [525875c410df5d876b9615c44885ca7640aed6f2]
stable/5.15: [88449dbe6203c3a91cf1c39ea3032ad61a297bd7]
stable/5.4: [8bfcd0385211044627f93d170991da1ae5937245]

CVE-2021-28715
mainline: [be81992f9086b230623ae3ebbc85ecee4d00a3d3
stable/4.14: [9bebb2eedf679b3be4acaa20efda97f32c999d74]
stable/4.19: [c9f17e92917fd5786be872626a3928979ecc4c39]
stable/4.4: [0928efb09178e01d3dc8e8849aa1c807436c3c37]
stable/4.9: [b4226b387436315e7f57465c15335f4f4b5b075d]
stable/5.10: [88f20cccbeec9a5e83621df5cc2453b5081454dc]
stable/5.15: [bd926d189210cd1d5b4e618e45898053be6b4b3b]
stable/5.4: [0d99b3c6bd39a0a023e972d8f912fd47698bbbb8]

CVE-2021-4135: netdevsim: Zero-initialize memory for new map''s value
in function nsim_bpf_map_alloc

CVSS v3 score is not provided

This bug was introduced in 4.16-rc1 commit 395cacb5f1a0 ("netdevsim:
bpf: support fake map offload") so before this kernel was not
affected. This bug has been fixed in mainline since 5.16-rc6.

Fixed status

mainline: [481221775d53d6215a6e5e9ce1cce6d2b4ab9a46]
stable/4.19: [d861443c4dc88650eed113310d933bd593d37b23]
stable/5.10: [1a34fb9e2bf3029f7c0882069d67ff69cbd645d8]
stable/5.15: [27358aa81a7d60e6bd36f0bb1db65cd084c2cad0]
stable/5.4: [699e794c12a3cd79045ff135bc87a53b97024e43]

CVE-2021-4148: Improper implementation of block_invalidatepage()
allows users to crash the kernel

CVSS v3 score is not provided

This issue causes a local user can do a DoS attack to the system. The
route cause has been analyzed but not fixed yet.

Fixed status

Not fixed yet.

CVE-2021-4149: Improper lock operation in btrfs

CVSS v3 score is not provided

There is a deadlock problem in fs/btrfs/extent-tree.c. This problem
causes a local attacker can do a DoS attack to the system.
The patch specifies the vulnerable kernel version is 5.4 or later.
stable/4.4, stable/4.9, and buf value is not locked in
btrfs_init_new_buffer(). However, stable/4.19 takes a lock in
btrfs_init_new_buffer()
(https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/fs/btrfs/extent-tree.c?h=linux-4.19.y#n8145)
so it seems 4.19 has same issue.

Fixed status

mainline: [19ea40dddf1833db868533958ca066f368862211]
stable/5.10: [206868a5b6c14adc4098dd3210a2f7510d97a670]
stable/5.4: [005a07c9acd6cf8a40555884f0650dfd4ec23fbe]

CVE-2021-4150: Block subsystem mishandles reference counts

CVSS v3 score is not provided

This fix added a return statement in out_put label to not go through
the out_put_disk label. The out_put_disk label was added by commit
9d3b881 ("block: change the refcounting for partitions") since
5.15-rc1. So it looks like before 5.15 kernel doesn't affect this
issue.

Fixed status

mainline: [9fbfabfda25d8774c5a08634fdd2da000a924890]


* Updated CVEs

CVE-2021-3752: UAF in bluetooth

The mainline and stable kernels have been fixed.

Fixed status

mainline: [1bff51ea59a9afb67d2dd78518ab0582a54a472c]
stable/4.14: [cd76d797a690969186c0c100e8a301c4480e4e7f]
stable/4.19: [72bb30165337b7bce77578ad151fbfab6c8e693c]
stable/4.4: [88aed7d67197d155260f09078835290adfa1debd]
stable/4.9: [d19ea7da0eeb61be28ec05d8b8bddec3dde71610]
stable/5.10: [c10465f6d6208db2e45a6dac1db312b9589b2583]
stable/5.15: [7e22e4db95b04f09adcce18c75d27cbca8f53b99]
stable/5.4: [67bd269a84ce29dfc543c1683a2553b4169f9a55]

CVE-2021-4028: use-after-free in RDMA listen()

Fixed in mainline and stable kernels. This bug was introduced since
5.10-rc1 so before this version wasn't affected.

Fixed status

mainline: [bc0bdc5afaa740d782fbf936aaeebd65e5c2921d]
stable/5.10: [0a16c9751e0f1de96f08643216cf1f19e8a5a787]

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

