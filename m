Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA3E9ECAAD1
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 00:13:09 +0000 (UTC)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by mx.groups.io with SMTP id smtpd.web12.6384.1661991182310791754
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 17:13:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112
 header.b=6+dk8deP;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.42,
 mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-11f34610d4aso17200280fac.9
        for <cip-dev@lists.cip-project.org>;
 Wed, 31 Aug 2022 17:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=xPj3YtdIa3HZdDsdIyyMji7E5QtOwWsk+xEb1FnCDEs=;
        b=6+dk8dePiStbFMOi9nJWGteK5VREoNtvZZwvKz2cGhGY9Ht/75BWJnrI6m7e/RrKFi
         4oXM65IHrrk7GzzMGwXNsYQQuw6MN4I9EJBVO/kP+qjZcrGB3kDGHA+dH7wiYLZEkCYC
         1/iW+ZZOUY7ZyVIg1q52aitVxUvl4QbP+w+7tKffMP4CJcJUsmJf0jfsThYu8Ke5hO9I
         WH6Mm8dnCJltL+P3PlgO3kdCJ5tZLvBe5tx/J+A5A0pvR3aWtGz4AtfgALT2vVCie59A
         Mn9y8AcHknFjceMnOY2Lak7FK42+xkbNuASihQ6hmZM/o/PlA5urbvjTswqFsvKwj7Qy
         rrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=xPj3YtdIa3HZdDsdIyyMji7E5QtOwWsk+xEb1FnCDEs=;
        b=J+E3DguELSesJ/k43Dvks1kPxWxvULGKBfmxEhj4QIWtYVSVJgjmgCFuob6N4aWuIe
         1jMSF/R3Hd0/c5C0h+5xjK8SwRzT1ZM4YPp4Qet48uExzBFTfeZhb7F1prvc080vn8RP
         n/ILff0Mn5slYbIpNCVSXQNHuo3ls/QXYKsWJwslP6rgjw2Hjbog0WnA/eYJCcrLHDrY
         71uZOhBXzSuVV5joou37o1BGiqJVGb/O2HDTyghYdLvMWyjqghS7kxGyfFAugL6yz/yi
         ZsNfMLrwHXtjG8As7G7m0m95anltha/eMKRhvakn0pUw8UkhQLv947qGpDU9Sl78nW7i
         yvCw==
X-Gm-Message-State: ACgBeo3nQCp1vPf7wyIhNPnwgC4tjNy+giZ4G1iQ8lQXID6GCcnHRQIc
	o6/Azw4YQk9e8fQ8s+kxi1PSnkI6oaMKSQ5OPXs+iYyS6vsDng==
X-Google-Smtp-Source: 
 AA6agR6GAX2jgscxY7t2Ou+tJ/snLWU3DMsX9xKQp3UdtiDFboBHTudNL+aLnVHVGXygZuU7zET3e6PvrnzvqlvXHF0=
X-Received: by 2002:a05:6870:e74c:b0:11e:4461:20f5 with SMTP id
 t12-20020a056870e74c00b0011e446120f5mr2687728oak.280.1661991180892; Wed, 31
 Aug 2022 17:13:00 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Sep 2022 09:12:25 +0900
Message-ID: 
 <CAODzB9r=vo=LTAvED+iQKu1+ORSvRDDNW_LNViHkaJcQ1V36kQ@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 00:13:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9397

Hi !

It's this week's CVE report.

This week reported 11 new CVEs and 7 updated CVEs.

* New CVEs

CVE-2022-2905: bpf: Don''t use tnum_range on array range checking for
poke descriptors

CVSS v3 score is not assigned.

A slab-out-of-bound read bug was found in the bpf subsystem. This bug
was introduced by commit d2e4c1e6c294 ("bpf: Constant map key tracking
forprog array pokes") was merged in 5.5-rc1.
This commit is not backported to 4.4, 4.9, 4.14, 4.19, and 5.4 kernels
so these kernels aren't affected.

Fixed status
mainline: [a657182a5c5150cdfacb6640aad1d2712571a409]
stable/5.10: [e8979807178434db8ceaa84dfcd44363e71e50bb]
stable/5.15: [4f672112f8665102a5842c170be1713f8ff95919]
stable/5.19: [a36df92c7ff7ecde2fb362241d0ab024dddd0597]

CVE-2022-2959: Linux Kernel Watch Queue Race Condition Privilege
Escalation Vulnerability

CVSS v3 score is not assigned.

A race condition bug was found in the watch queue feature due to a
missing lock in pip_resize_ring(). This bug allows an attacker to
escalate their privilege.

This bug was introduced by commit c73be61 ("pipe: Add general
notification queue support") that was merged in 5.8-rc1. The general
notification queue support isn't supported on 4.4, 4.14, 4.14, and
5.4.

Fixed status
mainline: [189b0ddc245139af81198d1a3637cac74f96e13a]

CVE-2022-2964: kernel: memory corruption in AX88179_178A based USB
ethernet device.

CVSS v3 score is not assigned.

An out-of-bound access vulnerability was found in linux kernel driver
for AX88179_178A based USB ethernet device.
The ax88179_rx_fixup() contains several out-of-bound access bugs. It
probably has out-of-bound write bug.

This bug was introduced by commit e2ca90c ("ax88179_178a: ASIX
AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver") which
was merged in 3.9-rc2.

Fixed status

CVE-2022-2977: kernel: use-after-free Read in put_device (/dev/vtpmx)

CVSS v3 score is not assigned.

A flaw was found in the kernel's implementation of proxied virtualized
TPM devices.

Commit 7e0438f8 ("tpm: fix reference counting for struct tpm_chip")
fixes following commits.

- fdc915f ("tpm: expose spaces via a device link /dev/tpmrm<n>")
- 8979b02 ("tpm: Fix reference count to main device")

Commit fdc915f and 8979b02 were merged in 4.12-rc1. Kernel 4.4 and 4.9
do not contain these commits.

Fixed status
mainline: [7e0438f83dc769465ee663bb5dcf8cc154940712]

CVE-2022-2991: kernel: heap-based overflow in LightNVM Subsystem may
lead to privilege escalation

CVSS v3 score is not assigned.

A heap-based buffer overflow was found in the Linux kernel's LightNVM
subsystem that an attacker will be able to escalate privileges.

The lightnvm subsystem was removed by commit 9ea9b9 ("remove the
lightnvm subsystem") in 5.15-rc1.
This fix disables CONFIG_NVM by default.

cip-kernel-config/4.4.y-cip-rt/x86/siemens_i386-rt.config enables CONFIG_NVM.

Fixed status
mainline: [9ea9b9c48387edc101d56349492ad9c0492ff78d]
stable/4.14: [a9ae9dc21233d3dbe165f5e3e33df3c8bf3c35d0]
stable/4.19: [455431805699e91c2fd66b7fe43db27643d9b3fd]
stable/4.9: [08cf860b84ff15d405f62d6d23ba3b7d194abb2e]
stable/5.10: [549209caabc89f2877ad5f62d11fca5c052e0e8f]
stable/5.4: [b2589647008f8086582055414bb914088bca4c78]

CVE-2022-XXXX: KVM instruction emulation doesn't clear
KVM_VCPU_PREEMPTED, breaking guest's TLB flushing

CVE ID hasn't been assigned yet.
CVSS v3 score is not assigned.

YAML file is CVE-2022-KVM_VCPU_PREEMPTED-guest-TLB-flush.yml.

The KVM_FEATURE_PV_TLB_FLUSH feature was introduced by commit 858a43a
("KVM: X86: use paravirtualized TLB Shootdown") was merged in
4.16-rc1. Therefore, 4.4, 4.9, and 4.14 are not affected.

This vulnerability is affected by x86/x86_64 architectures.

There is a flaw in TLB flush feature in KVM subsystem that an
unprivileged userspace inside a guest to compromise the guest kernel.

Fixed status
mainline: [6cd88243c7e03845a450795e134b488fc2afb736]
stable/5.15: [92343314d34e04da0923cefd3be67521d706fa35]

CVE-2022-XXXX: CVE-2022-race-VM_PFNMAP-stale-TLB-entry

CVE ID hasn't been assigned yet.
CVSS v3 score is not assigned.

YAML file is CVE-2022-race-VM_PFNMAP-stale-TLB-entry.yml.

A race between munmap() and unmap_mapping_range(), this will cause TLB
entries isn't flushed.

Fixed status
mainline: [b67fbebd4cf980aecbcc750e1462128bffe8ae15]

CVE-2022-21385: A flaw in net_rds_alloc_sgs() in Oracle Linux kernels
allows unprivileged local users to crash the machine.

CVSS V3 Score: 4.6 MEDIUM

A redundant copy_from_user() call will cause an unprivileged user crash machine.
Commit ea010070 ("net/rds: fix warn in rds_message_alloc_sgs") fixed
this bug. This commit was merged in 4.20.

Fixed status
mainline: [ea010070d0a7497253d5a6f919f6dd107450b31a]
stable/4.19: [5be4bb315de29ad3ae558a8f6b92f13a1b4bfb84]

CVE-2022-2663: netfilter: nf_conntrack_irc: Tighten matching on DCC message

CVSS v3 score is not assigned.

A bug in nf_conntrack_irc() that mishandles a message causes a
firewall may be able to be bypassed when users are using unencrypted
IRC with nf_conntrack_irc configured.

Fixed status
Patch is available in
https://lore.kernel.org/netfilter-devel/20220826045658.100360-1-dgl@dgl.cx/T/
but it hasn't been merged yet.

CVE-2022-3028: af_key: Do not call xfrm_probe_algs in parallel

A race condition bug was found in the XFRM subsystem when multiple
calls to xfrm_probe_algs occurred simultaneously.
This condition will cause out-of-bound write or out-of-bound read.

CVSS v3 score is not assigned.

Fixed status
mainline: [ba953a9d89a00c078b85f4b190bc1dde66fe16b5]
stable/5.10: [c5c4d4c9806dadac7bc82f9c29ef4e1b78894775]
stable/5.15: [103bd319c0fc90f1cb013c3a508615e6df8af823]
stable/5.19: [6901885656c029c976498290b52f67f2c251e6a0]

CVE-2022-3061: video: fbdev: i740fb: Error out if ''pixclock'' equals zero

CVSS v3 score is not assigned.

If a userspace application pass zero as pixclock value via ioctl, it
causes a divided zero error.

Fixed status
mainline: [15cf0b82271b1823fb02ab8c377badba614d95d5]

* Updated CVEs

CVE-2021-4159: bpf: Verifer, adjust_scalar_min_max_vals to always call
update_reg_bounds()

4.19 was fixed this week.

Fixed status
mainline: [294f2fc6da27620a506e6c050241655459ccd6bd]
stable/4.19: [6c6b84ef5ea8dc0ca3559ccf69810960e348c555]
stable/5.4: [7c1134c7da997523e2834dd516e2ddc51920699a]

CVE-2022-1679: Use-After-Free in ath9k_htc_probe_device() could cause
an escalation of privileges

4.14, 4.19, and 5.4 were fixed this week.

Fixed status
mainline: [0ac4827f78c7ffe8eef074bc010e7e34bc22f533]
stable/4.14: [62bc1ea5c7401d77eaf73d0c6a15f3d2e742856e]
stable/4.19: [ab7a0ddf5f1cdec63cb21840369873806fc36d80]
stable/5.10: [eccd7c3e2596b574241a7670b5b53f5322f470e5]
stable/5.15: [03ca957c5f7b55660957eda20b5db4110319ac7a]
stable/5.19: [b66ebac40f64336ae2d053883bee85261060bd27]
stable/5.4: [e9e21206b8ea62220b486310c61277e7ebfe7cec]

CVE-2022-2153: KVM: NULL pointer dereference in kvm_irq_delivery_to_apic_fast()

Added fixed commit to 4.14, 5.10, and 5.4.
Added 5cde0b9 and b8127a0 to 4.19.

Fixed status
mainline: [7ec37d1cbe17d8189d9562178d8b29167fe1c31a,
00b5f37189d24ac3ed46cb7f11742094778c46ce,
  b1e34d325397a33d97d845e312d7cf2a8b646b44]
stable/4.14: [a4bd692a950ada6d9757dbb78a6aea129ff8a943,
bcf0a450fbaabe7e14d71f885525805b4f86e855,
  3362843aa71898fc2850a90950debcef2897dd60]
stable/4.19: [2f4835b5188f3b73b2b048a761ae2553e845b027,
5cde0b9cc69fcbbf559674986c2d325ae4708036,
  b8127a0fd21d70ab42d8177f8bb97df74f503cc1]
stable/4.9: [95d51d058680766130098287f680474bc55f1679]
stable/5.10: [09c771c45c1243e295470225aaee726693fdc242,
ac7de8c2ba1292856fdd4a4c0764669b9607cf0a,
  4c85e207c1b58249ea521670df577324ad69442c]
stable/5.15: [569a229142e95610adc1041ae9ca1f417c4c6a3e,
0e5dbc0540baa89faf4c04ccc7e9c4fe6b1d7bf4,
  ba6e8c2df52047a32953588b49d9addbd843a098]
stable/5.4: [8fb5e77604442926db8b779fa590af7709d754e9,
8cdba919acefdd6fea5dd2b77a119f54fb88ce11,
  9e24d03dd4fee589da500861967d9fd9c0e6276d]

CVE-2022-2586: Linux kernel nf_tables cross-table reference UAF

4.19 and 5.4 were fixed.

Fixed status
mainline: [470ee20e069a6d05ae549f7d0ef2bdbcee6a81b2]
stable/4.19: [77d3b5038b7462318f5183e2ad704b01d57215a2]
stable/5.10: [1a4b18b1ff11ba26f9a852019d674fde9d1d1cff]
stable/5.15: [faafd9286f1355c76fe9ac3021c280297213330e]
stable/5.18: [f4fa03410f7c5f5bd8f90e9c11e9a8c4b526ff6f]
stable/5.19: [0d07039397527361850c554c192e749cfc879ea9]
stable/5.4: [fab2f61cc3b0e441b1749f017cfee75f9bbaded7]

CVE-2022-2588: Linux kernel cls_route UAF

Added fixed commit to 4.14, 4.19, 4.9, and 5.4.

Fixed status
mainline: [9ad36309e2719a884f946678e0296be10f0bb4c1]
stable/4.14: [d0cce31f328fa10e7256f314e6e044e13cdf6814]
stable/4.19: [73584dab72d0a826f286a45544305819b58f7b92]
stable/4.9: [34a475425612bef345634202dda8dac91820b6c8]
stable/5.10: [7018f03d97daf344e49b16200caf4363a1407cab]
stable/5.15: [57bbb691a93bd39d0644c5c879b354232d0e0eed]
stable/5.18: [e832c26e7edfa2ddbd2dcdd48016d13d747de6da]
stable/5.19: [ee3f18d90e80e79449d575fa3e7a6b775e9fc35e]
stable/5.4: [1fcd691cc2e7f808eca2e644adee1f1c6c1527fd]

CVE-2022-36946: kernel panic when sending nf_queue verdict with 1-byte
nfta_payload attribute

Added fixed commit to 4.14 and 4.9.

Fixed status
stable/4.14: [83636c64b796a7e44fa72f371777f803c1ef9e74]
stable/4.19: [f295d365b30626f82423a923695274024016380e]
stable/4.9: [3b3e2de462323d5fdeb85a3682334a4a3dd07400]
stable/5.10: [440dccd80f627e0e11ceb0429e4cdab61857d17e]
stable/5.15: [91c11008aab0282957b8b8ccb0707d90e74cc3b9]
stable/5.18: [883c20911d6261fc651820b63a77327b8c020264]
stable/5.4: [52be29e8b6455788a4d0f501bd87aa679ca3ba3c]

CVE-2022-2590: mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW

The mainline and 5.19 were fixed. This bug was introduced in 5.16 so
that less than 5.16 kernels aren't affected.

Fixed status
mainline: [5535be3099717646781ce1540cf725965d680e7b]
stable/5.19: [9def52eb10baab3b700858003d462fcf17d62873]

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

