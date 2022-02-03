Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5B7C433F5
	for <webhook@archiver.kernel.org>; Thu,  3 Feb 2022 00:29:20 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com
 [209.85.210.54])
 by mx.groups.io with SMTP id smtpd.web08.2648.1643848157940123011
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Feb 2022 16:29:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=r1EREkPS;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.54,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-ot1-f54.google.com with SMTP id
 q14-20020a05683022ce00b005a6162a1620so1144438otc.0
        for <cip-dev@lists.cip-project.org>;
 Wed, 02 Feb 2022 16:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=ALYHkllKd4YCsd/75vsQTQJEKqAxAv0Fhh3UTOUzLms=;
        b=r1EREkPSqxKx/9lGLKAAnmBu9c35G5c/wHga9YxA7xFp8mxqV+2uMgBDuQE1yRcnJf
         XMg8PGmep3gOZFLhGG5/9zH5U5s1pF0dhTIBsogHyUqbgtPub2JlSOj0Fiehpe0yDrN8
         bsDguDRVMz51h+W/gINDvMaLbC2NqJzReNgWjrAf9K5obXa0ifLMXBXbkgxEtguMauFY
         o+UMg1T8kP9ScN0Me4MG47SKKJV8EP3sOsP4IXQ8eueHNo1HX7vK9teRutmzfSygDm2R
         AYINu7UIxdP1g02LUlHSjCDa0IUpleCDnLOMJ5NxFL4xaeqeUzbioUZVQh1RLHqEieXp
         h+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=ALYHkllKd4YCsd/75vsQTQJEKqAxAv0Fhh3UTOUzLms=;
        b=Q6CS+Jg822iKQ7KgGad3afAMEn27IfLiBQUHyVK7xb/ASKtK9TAaZHqkTVf5Q+Hv87
         NMAZk3BXZF/xIXZWq5pIVSH5s6Dp1wIsU8EFLucuyBRAxfPfx2L2rv3wLrhA5wZvSzRM
         k+uGDAIuWtGOkPaIrNOQ+mFZi3KBlAmC8utBZF3DV1j5NPelxn39nioDdTCmAOcr7+UA
         594rkXVj9Cgx8ZML8JyLWnv2jdOh2UBkyl2CsxKnYKbLT8phznupoOjZqmSqeT/66bs6
         pF+OP1uaFbW4g27JA+/QPWaVJ4OQ40jCeLcSC6vexDJn49+EEHAODnLop5/mjcM4QMWE
         lNlQ==
X-Gm-Message-State: AOAM533Cj7pAzP26LPKRJCqfU3OgGopUmyovp5MHS0alhaiJA8VuL+iw
	Lq3B2xlKFEVWaSCCrm7XrVSt4hrCAJnHDZ6goUackBrP2KKvtA==
X-Google-Smtp-Source: 
 ABdhPJxyuvFENSKjQ2ExjMOlxKv2IEFL62kCgexu+t9UEaIIGYdENad465iEApyl/unWK6jzJQZttUwNHcyd29iE/hI=
X-Received: by 2002:a9d:4b0d:: with SMTP id q13mr17612624otf.67.1643848156708;
 Wed, 02 Feb 2022 16:29:16 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 3 Feb 2022 09:28:40 +0900
Message-ID: 
 <CAODzB9rf6tg7mz5Wn9KvG5yBBryrjxkeZemA=ow5H5zbtn_21A@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Feb 2022 00:29:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7565

Hi!

It's this week's CVE report.

This week reported 8 new CVEs.

* New CVEs

CVE-2022-22942: drm/vmwgfx: Fix stale file descriptors on failed usercopy

CVSS v3 score is not provided

A local attacker who is able to access to /dev/dri/card0 or
/dev/dri/rendererD128 will be able to gain access to files opened by
other processes on the system.
This issue was introduced by commit c906965 ("drm/vmwgfx: Add export
fence to file descriptor support") which was merged at 4.14-rc1.

Fixed status

mainline: [a0f90c8815706981c483a652a6aefca51a5e191c]

CVE-2021-4159: bpf: Verifer, adjust_scalar_min_max_vals to always call
update_reg_bounds()

CVSS v3 score is not provided

Kernel pointer leak vulnerability in eBPF. If a user have a permission
to insert eBPF code, user will be able to expose internal kernel
memory details.

Fixed status

mainline: [294f2fc6da27620a506e6c050241655459ccd6bd]

CVE-2022-0382: net ticp:fix a kernel-infoleak in __tipc_sendmsg()

CVSS v3 score is not provided

An infoleak vulnerability was found in __tipc_sendmsg(). A local user
can read some kernel memory (no more than 7 bytes and cannot control
what is read).

Fixed status

mainline: [d6d86830705f173fca6087a3e67ceaf68db80523]
stable/5.15: [d57da5185defccf383be53f41604fd5f006aba8c]

CVE-2022-24122: ucount:  Make get_ucount a safe get_user replacement

CVSS v3 score is not provided

A use-after-free vulnerability was found. This bug was introduced by
following commits.

- d646969 ("Reimplement RLIMIT_SIGPENDING on top of ucounts")
- 6e52a9f ("Reimplement RLIMIT_MSGQUEUE on top of ucounts")
- d7c9e99 ("Reimplement RLIMIT_MEMLOCK on top of ucounts")

These commits were merged since 5.14-rc1. so before 5.14 kernels were
not affected.

Fixed status

mainline: [f9d87929d451d3e649699d0f1d74f71f77ad38f5]
stable/5.15: [348a8501e6029f9308ea7675edfa645b5e669c9e]
stable/5.16: [aec8904396dc6c34a104f42b02d50ca9de58ab13]

CVE-2022-0286: bonding: fix null dereference in bond_ipsec_add_sa()

CVSS v3 score is not provided

A flaw was found in the Linux kernel. A null pointer dereference in
bond_ipsec_add_sa() may lead to local denial of service.
This issue was intoduced by 18cb261 ("bonding: support hardware
encryption offload to slaves") which was merged at 5.9-rc1.

Fixed status

mainline: [105cd17a866017b45f3c45901b394c711c97bf40]
stable/5.10: [ba7bfcdff1ad4ea475395079add1cd7b79f81684]

CVE-2022-0400: Out of bounds read in the smc protocol stack

CVSS v3 score is not provided

There is no information as of 2022/02/03.

Fixed status

Not fixed yet.

CVE-2022-0433: bpf: Add missing map_get_next_key method to bloom filter map.

CVSS v3 score is not provided

A NULL pointer dereference bug was found in map_get_next_key() in the
BPF subsystem. A local attacker will be able to crash the system.
This issues was introduced with 9330986c0300 ("bpf: Add bloom filter
map implementation") in 5.16-rc1.

Fixed status

mainline: [3ccdcee28415c4226de05438b4d89eb5514edf73]
stable/5.16: [f7a6dd58e0817b063252d7c5bec88e588df34b31]

CVE-2021-4218: sysctl: pass kernel pointers to ->proc_handler

CVSS v3 score is not provided

This issue allows a local user with local access to cause a DoS while
the system reboot.
It was fixed in 5.8-rc1.

Fixed status

mainline: [32927393dc1ccd60fb2bdc05b9e8e88753761469]

* Updated CVEs

CVE-2020-29374: gup: document and work around "COW can break either way" issue

4.14 and 4.19 were added following patches to fix bug in
get_user_pages_fast(), which need to fix CVE-2020-29374 correctly.

4.14: 70b5928 ("mips,s390,sh,sparc: gup: Work around the "COW can
break either way" issue")
4.19: 294c7a9 ("mips,s390,sh,sparc: gup: Work around the "COW can
break either way" issue")

It seems that 4.4.y also needs this patch too.

Fixed status

mainline: [17839856fd588f4ab6b789f482ed3ffd7c403e1f]
stable/4.14: [407faed92b4a4e2ad900d61ea3831dd597640f29,
70b5928f5cd289b2ccf34384ca83b1d9ee7a0fad]
stable/4.19: [5e24029791e809d641e9ea46a1f99806484e53fc,
294c7a9fb608c29a9e49010b515228e20ccbec8f]
stable/4.4: [58facc9c7ae307be5ecffc1697552550fedb55bd]
stable/4.9: [9bbd42e79720122334226afad9ddcac1c3e6d373]
stable/5.4: [1027dc04f557328eb7b7b7eea48698377a959157]

CVE-2020-36322: fuse: fix bad inode

4.14, 4.19, and 4.9 were fixed this week.

Fixed status

mainline: [5d069dbe8aaf2a197142558b6fb2978189ba3454]
stable/4.14: [2cd45139c0f28ebfa7604866faee00c99231a62b]
stable/4.19: [1e1bb4933f1faafc68db8e0ecd5838a65dd1aae9]
stable/4.9: [3a2f8823aa565cc67bdd00c4cd5e1d8ad81e8436]
stable/5.10: [36cf9ae54b0ead0daab7701a994de3dcd9ef605d]
stable/5.4: [732251cabeb3bfd917d453a42274d769d6883fc4]

CVE-2021-20292: drm/ttm/nouveau: don''t call tt destroy callback on
alloc failure.

4.14 and 4.9 were fixed this week.

Fixed status

mainline: [5de5b6ecf97a021f29403aa272cb4e03318ef586]
stable/4.14: [4a2cec066dc8d099d30c649ae7ed26771029e0b5]
stable/4.19: [10c8a526b2db1fcdf9e2d59d4885377b91939c55]
stable/4.9: [70f44dfbde027f444412cfb4ea9b485a4c1dec0e]
stable/5.4: [c6d2ddf1a30d524106265ad2c48b907cd7a083d4]

CVE-2021-20317: lib/timerqueue: Rely on rbtree semantics for next timer

4.9 was fixed this week.

Fixed status

mainline: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
stable/4.14: [0135fcb86a0bc9e4484f7e1228cadcc343c5edef]
stable/4.19: [b9a1ac8e7c03fd09992352c7fb1a61cbbb9ad52b]
stable/4.9: [ef2e64035f074bfeef14c28347aaec0b486a9e9f]
stable/5.10: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
stable/5.14: [511885d7061eda3eb1faf3f57dcc936ff75863f1]
stable/5.4: [511885d7061eda3eb1faf3f57dcc936ff75863f1]

CVE-2021-22543: KVM through Improper handling of VM_IO|VM_PFNMAP vmas
in KVM can bypass RO checks and can lead to pages being freed while
still accessible by the VMM and guest

4.9 was fixed this week.

Fixed status

mainline: [f8be156be163a052a067306417cd0ff679068c97]
stable/4.14: [46d75ff2c1beebe90e7af8887256d8f0323679e4]
stable/4.19: [117777467bc015f0dc5fc079eeba0fa80c965149]
stable/4.9: [f4b2bfed80e8d0e91b431dd1c21bc3c2c4d5f07e]
stable/5.10: [dd8ed6c9bc2224c1ace5292d01089d3feb7ebbc3]
stable/5.12: [c36fbd888dcc27d365c865e6c959d7f7802a207c]
stable/5.4: [bb85717e3797123ae7724751af21d0c9d605d61e]

CVE-2021-28950: fuse: fix live lock in fuse_iget()

4.14, 4.19, and 4.9 were fixed this week.

Fixed status

mainline: [775c5033a0d164622d9d10dd0f0a5531639ed3ed]
stable/4.14: [f78d626801194ffac2c140de72e5b7937fac33f6]
stable/4.19: [8a8908cb82568c71b672e83d834e8b59ccf75f8e]
stable/4.9: [fde32bbe9a540af28579da6480fc55cc50099ece]
stable/5.10: [d955f13ea2120269319d6133d0dd82b66d1eeca3]
stable/5.11: [5676df54d7d44f497b8dbf7bff04f2f1b165da93]
stable/5.4: [187ae04636531065cdb4d0f15deac1fe0e812104]

CVE-2021-29264: gianfar: fix jumbo packets+napi+rx overrun crash

4.14 and 4.9 were fixed this week.

Fixed status

mainline: [d8861bab48b6c1fc3cdbcab8ff9d1eaea43afe7f]
stable/4.14: [93e83b226a16bcc800013c6e02c98eef7ba9868c]
stable/4.19: [9943741c2792a7f1d091aad38f496ed6eb7681c4]
stable/4.9: [2cf34285e6eac396a180762c5504e2911df88c9a]
stable/5.10: [b8bfda6e08b8a419097eea5a8e57671bc36f9939]
stable/5.11: [5b54b18449d8f7302bc2e16d52121f6f87a81c3c]
stable/5.4: [ec7ce1e337ec2b5641dcc639396e04a28454f21a]

CVE-2021-33033: cipso,calipso: resolve a number of problems with the
DOI refcounts

4.9 was fixed this week.

Fixed status

mainline: [ad5d07f4a9cd671233ae20983848874731102c08]
stable/4.14: [ab44f7317c16ddcf9ee12ba2aca60771266c2dc6]
stable/4.19: [a44af1c69737f9e64d5134c34eb9d5c4c2e04da1]
stable/4.9: [f49f0e65a95664b648e058aa923f651ec08dfeb7]
stable/5.10: [85178d76febd30a745b7d947dbd9751919d0fa5b]
stable/5.11: [00d566df2cceb8591913b3ea3b43d2918915f7e3]
stable/5.4: [b4800e7a1c9f80a1a0e417ab36a1da4959f8b399]

CVE-2021-38199: NFSv4: Initialise connection to the server in
nfs4_alloc_client()

4.14 was fixed this week.

Fixed status

mainline: [dd99e9f98fbf423ff6d365b37a98e8879170f17c]
stable/4.14: [d5e6dff8c92943a2719fa5415cc3d333e57d5d90]
stable/4.19: [743f6b973c8ba8a0a5ed15ab11e1d07fa00d5368]
stable/5.10: [ff4023d0194263a0827c954f623c314978cf7ddd]
stable/5.13: [b0bfac939030181177373f549398ba94c384713d]
stable/5.4: [81e03fe5bf8f5f66b8a62429fb4832b11ec6b272]

CVE-2021-43976: mwifiex_usb: Fix skb_over_panic in mwifiex_usb_recv

All stable kernels were fixed this week.

Fixed status

mainline: [04d80663f67ccef893061b49ec8a42ff7045ae84]
stable/4.14: [8c9261b84c9b90d130d97fc7d13727706253af87]
stable/4.19: [2f4b037bf6e8c663a593b8149263c5b6940c7afd]
stable/4.4: [7d5e12e452771509d94db391a3b5e428325ed268]
stable/4.9: [b233d7395cd104398dd83f130df5f0d57036c95e]
stable/5.10: [6036500fdf77caaca9333003f78d25a3d61c4e40]
stable/5.15: [b2762757f4e484f8a164546f93aca82568d87649]
stable/5.16: [9d3989c5050f10ae9bbec9f32492b500420d04a1]
stable/5.4: [ae56c5524a750fd8cf32565cb3902ce5baaeb4e6]

CVE-2021-45469: f2fs: fix to do sanity check on last xattr entry in
__f2fs_setxattr()

5.16 was fixed this week.

Fixed status

mainline: [645a3c40ca3d40cc32b4b5972bf2620f2eb5dba6]
stable/4.14: [88dedecc24763c2e0bc1e8eeb35f9f2cd785a7e5]
stable/4.19: [f9dfa44be0fb5e8426183a70f69a246cf5827f49]
stable/5.10: [fffb6581a23add416239dfcf7e7f3980c6b913da]
stable/5.15: [a8a9d753edd7f71e6a2edaa580d8182530b68791]
stable/5.16: [258b26a34778cde43f228a392e242d3d0420624a]
stable/5.4: [b0406b5ef4e2c4fb21d9e7d5c36a0453b4279e9b]

CVE-2021-38198: KVM: X86: MMU: Use the correct inherited permissions
to get shadow page

4.9 was fixed this week.

Fixed status

mainline: [b1bd5cba3306691c771d558e94baa73e8b0b96b7]
stable/4.14: [cea9e8ee3b8059bd2b36d68f1f428d165e5d13ce]
stable/4.19: [4c07e70141eebd3db64297515a427deea4822957]
stable/4.9: [e262acbda232b6a2a9adb53f5d2b2065f7626625]
stable/5.10: [6b6ff4d1f349cb35a7c7d2057819af1b14f80437]
stable/5.4: [d28adaabbbf4a6949d0f6f71daca6744979174e2]

CVE-2021-38199: NFSv4: Initialise connection to the server in
nfs4_alloc_client()

4.9 was fixed this week.

mainline: [dd99e9f98fbf423ff6d365b37a98e8879170f17c]
stable/4.14: [d5e6dff8c92943a2719fa5415cc3d333e57d5d90]
stable/4.19: [743f6b973c8ba8a0a5ed15ab11e1d07fa00d5368]
stable/4.9: [993892ed82350d0b4eb7d321d2bb225219bd1cfc]
stable/5.10: [ff4023d0194263a0827c954f623c314978cf7ddd]
stable/5.13: [b0bfac939030181177373f549398ba94c384713d]
stable/5.4: [81e03fe5bf8f5f66b8a62429fb4832b11ec6b272]

CVE-2021-42739: media: firewire: firedtv-avc: fix a buffer overflow in
avc_ca_pmt()

4.9 was fixed this week.

Fixed status

mainline: [35d2969ea3c7d32aee78066b1f3cf61a0d935a4e]
stable/4.14: [8d6c05da808f8351db844b69a9d6ce7f295214bb]
stable/4.19: [53ec9dab4eb0a8140fc85760fb50effb526fe219]
stable/4.9: [1795af6435fa5f17ced2d34854fd4871e0780092]
stable/5.10: [d7fc85f6104259541ec136199d3bf7c8a736613d]
stable/5.14: [02a476ca886dc8155025fe99cbbad4121d029fa7]
stable/5.15: [cb667140875a3b1db92e4c50b4617a7cbf84659b]
stable/5.4: [2461f38384d50dd966e1db44fe165b1896f5df5a]

CVE-2022-0330: drm/i915: Flush TLBs before releasing backing store

All stable kernels were fixed this week.

Fixed status

mainline: [7938d61591d33394a21bdd7797a245b65428f44c]
stable/4.14: [eed39c1918f1803948d736c444bfacba2a482ad0]
stable/4.19: [b188780649081782e341e52223db47c49f172712]
stable/4.4: [db6a2082d5a2ebc5ffa41f7213a544d55f73793a]
stable/4.9: [84f4ab5b47d955ad2bb30115d7841d3e8f0994f4]
stable/5.10: [6a6acf927895c38bdd9f3cd76b8dbfc25ac03e88]
stable/5.15: [8a17a077e7e9ecce25c95dbdb27843d2d6c2f0f7]
stable/5.16: [ec1b6497a2bc0293c064337e981ea1f6cbe57930]
stable/5.4: [1b5553c79d52f17e735cd924ff2178a2409e6d0b]

CVE-2022-22942: drm/vmwgfx: Fix stale file descriptors on failed usercopy

stable kernels were fixed this week. 4.4 and 4.9 are not affected this issue.

Fixed status

mainline: [a0f90c8815706981c483a652a6aefca51a5e191c]
stable/4.14: [e8d092a62449dcfc73517ca43963d2b8f44d0516]
stable/4.19: [0008a0c78fc33a84e2212a7c04e6b21a36ca6f4d]
stable/5.10: [ae2b20f27732fe92055d9e7b350abc5cdf3e2414]
stable/5.15: [6066977961fc6f437bc064f628cf9b0e4571c56c]
stable/5.16: [1d833b27fb708d6fdf5de9f6b3a8be4bd4321565]
stable/5.4: [84b1259fe36ae0915f3d6ddcea6377779de48b82]

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

