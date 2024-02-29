Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD96C5475B
	for <webhook@archiver.kernel.org>; Thu, 29 Feb 2024 00:03:09 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
 by mx.groups.io with SMTP id smtpd.web10.12868.1709164983017924507
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Feb 2024 16:03:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=qqCh3NPq;
 spf=pass (domain: miraclelinux.com, ip: 209.85.160.44, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-21e45ece781so197947fac.0
        for <cip-dev@lists.cip-project.org>; Wed, 28 Feb 2024 16:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1709164982; x=1709769782; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=S5H2QWxjyyi4FZ0XQwFwKvkPASGvHlHNIgnEVEdRSk8=;
        b=qqCh3NPqMpTdV5tJiJvYQFDwEMjCM2QSZZj3VodGHMA0sewA6qRnbLzWitEcsepMDf
         cgjg7RtCODLwFusojivQUi5Nlk+nwfV1/C9wy+Vc9hkICe7v0V4Z1WLELUHHC9jTK+mp
         ViE9evVUEWRFfJS9YDatPdpWWyZntu4HMj5yoEdmrLJqGQUw8BJbA1DKpKNywM/fGnsH
         R7WK2W4X4C8CUCY5DDrIH6Vm6SYEOkR5p7TdyECCzMI48Di8cTnOfjadhW7AnF09P7tN
         EhJviBnvqRQvq1dXc9K+HbDIyxaitPr6pOSL/KeBj1lgQut+VO1YvuAAA+Dis2Uo8uM9
         mWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709164982; x=1709769782;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S5H2QWxjyyi4FZ0XQwFwKvkPASGvHlHNIgnEVEdRSk8=;
        b=l97hFaqx0hLUWPsbNAX3YEnPB+nyTiLPO5aR8NdrMRK6+ccXbaZUwzDWACqja+WAhD
         PrX75tz8FEjMlVmnLehswYHtqxpRIfHQX513vgqwLhgInajdEhEZQLyy5yzp9BbhVFuL
         6hrQYUgAuoA90Zh1sNBcKNxPB1pj21OJeDE+4HIIakwUvNzZaYO3KEHlSErarie3Sj5/
         V+20b5Z/Fr4EdNVclLzCbBmotW7YBRzAG8YL794TvtxBkHBkV1rm8ho8czzPzVQkYEza
         u3hpsiwJiaHSKkZ56uK1gZ0VOohaAwBDmuhw8QK0C0BWHcza3r3s3DLChIR0SMgDdHkR
         kN2g==
X-Gm-Message-State: AOJu0YzKSExTdsDeOz79gA+53eg9mdaS70NQQiWolmuywKop3NGXvuZp
	oQFNvT3db7M8v9qMZDXOmsV2u3u7mb2xcgrx4MKwvkENkti8YZqMyt53HbqyfpXvn4QyX+Q5KsF
	E/w5b3Kjgtr6s4dwfWhiXw0umTzdtbaphG81uz2fpOIic/fYLFOU=
X-Google-Smtp-Source: AGHT+IGypOUzcMtXpHvSI+CU2/EcmIc7gFdbH0pXOCXll3mrooeXBXAeK/PUZHwC0LGYFHqnrsqbOaKw99aYkbRjxkY=
X-Received: by 2002:a05:6871:4e4c:b0:21f:1705:d5b2 with SMTP id
 uj12-20020a0568714e4c00b0021f1705d5b2mr470815oab.30.1709164979606; Wed, 28
 Feb 2024 16:02:59 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 29 Feb 2024 09:02:23 +0900
Message-ID: <CAODzB9pjy0TLHQN0yHWc8MoTDk+azCAFiUxvLGHSBe3LWELERg@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Feb 2024 00:03:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15099

Hi!

It's this week's CVE report.

This week reported 130 new CVEs and 21 updated CVEs.

* New CVEs

CVE-2023-52443: apparmor: avoid crash when parsed profile name is empty

Announce: https://lore.kernel.org/linux-cve-announce/2024022245-CVE-2023-52443-e920@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
apparmor: avoid crash when parsed profile name is empty
When processing a packed profile in unpack_profile() described like
 "profile :ns::samba-dcerpcd /usr/lib*/samba/{,samba/}samba-dcerpcd {...}"
a string ":samba-dcerpcd" is unpacked as a fully-qualified name and then
passed to aa_splitn_fqname().

aa_splitn_fqname() treats ":samba-dcerpcd" as only containing a namespace.
Thus it returns NULL for tmpname, meanwhile tmpns is non-NULL. Later
aa_alloc_profile() crashes as the new profile name is NULL now.

Introduced by commit 04dc715 ("apparmor: audit policy ns specified in
policy load") in 4.11-rc1.
Linux 4.4 is not affected.
Fixed in 6.8-rc1.

Fixed status
mainline: [55a8210c9e7d21ff2644809699765796d4bfb200]
stable/4.19: [9286ee97aa4803d99185768735011d0d65827c9e]
stable/5.10: [5ff00408e5029d3550ee77f62dc15f1e15c47f87]
stable/5.15: [0a12db736edbb4933e4274932aeea594b5876fa4]
stable/5.4: [1d8e62b5569cc1466ceb8a7e4872cf10160a9dcf]
stable/6.1: [9d4fa5fe2b1d56662afd14915a73b4d0783ffa45]
stable/6.6: [5c0392fdafb0a2321311900be83ffa572bef8203]
stable/6.7: [77ab09b92f16c8439a948d1af489196953dc4a0e]

CVE-2023-52444: f2fs: fix to avoid dirent corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024022252-CVE-2023-52444-f7ee@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A dirent corruption bug was found in the f2fs.

Introduced by commit 7e01e7a ("f2fs: support RENAME_WHITEOUT") in 4.2-rc1.
Fixed in 6.8-rc1.

Fixed status
mainline: [53edb549565f55ccd0bdf43be3d66ce4c2d48b28]
stable/4.19: [02160112e6d45c2610b049df6eb693d7a2e57b46]
stable/5.10: [6f866885e147d33efc497f1095f35b2ee5ec7310]
stable/5.15: [f100ba617d8be6c98a68f3744ef7617082975b77]
stable/5.4: [5624a3c1b1ebc8991318e1cce2aa719542991024]
stable/6.1: [f0145860c20be6bae6785c7a2249577674702ac7]
stable/6.6: [d3c0b49aaa12a61d560528f5d605029ab57f0728]
stable/6.7: [2fb4867f4405aea8c0519d7d188207f232a57862]

CVE-2023-52445: media: pvrusb2: fix use after free on context disconnection

Announce: https://lore.kernel.org/linux-cve-announce/2024022253-CVE-2023-52445-07a6@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
media: pvrusb2: fix use after free on context disconnection Upon
module load,
a kthread is created targeting the pvr2_context_thread_func function,
which may call pvr2_context_destroy and thus call kfree() on the
context
object. However, that might happen before the usb hub_event handler is
able to notify the driver. This patch adds a sanity check before the
invalid read reported by syzbot, within the context disconnection call stack.

Introduced by commit e5be15c ("V4L/DVB (7711): pvrusb2: Fix race on
module unload") in 2.6.26-rc1.
Fixed in 6.8-rc1.

Fixed status
mainline: [ded85b0c0edd8f45fec88783d7555a5b982449c1]
stable/4.19: [ec36c134dd020d28e312c2f1766f85525e747aab]
stable/5.10: [3233d8bf7893550045682192cb227af7fa3defeb]
stable/5.15: [ec3634ebe23fc3c44ebc67c6d25917300bc68c08]
stable/5.4: [47aa8fcd5e8b5563af4042a00f25ba89bef8f33d]
stable/6.1: [30773ea47d41773f9611ffb4ebc9bda9d19a9e7e]
stable/6.6: [2cf0005d315549b8d2b940ff96a66c2a889aa795]
stable/6.7: [437b5f57732bb4cc32cc9f8895d2010ee9ff521c]

CVE-2023-52446: bpf: Fix a race condition between btf_put() and map_free()

Announce: https://lore.kernel.org/linux-cve-announce/2024022254-CVE-2023-52446-2812@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A race condition bug was found between btf_put() and map_free().

Introduced by commit 958cf2e ("bpf: Introduce bpf_obj_new") in 6.2-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [59e5791f59dd83e8aa72a4e74217eabb6e8cfd90]
stable/6.6: [d048dced8ea5eac6723ae873a40567e6f101ea42]
stable/6.7: [f9ff6ef1c73cd9e1a6bb1ab3e57c5d141a536306]

CVE-2023-52447: bpf: Defer the free of inner map when necessary

Announce: https://lore.kernel.org/linux-cve-announce/2024022255-CVE-2023-52447-e074@gregkh/
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
bpf: Defer the free of inner map when necessary When updating or
deleting an
inner map in map array or map htab, the map may still be accessed by
non-sleepable program or sleepable program. However
bpf_map_fd_put_ptr()
decreases the ref-counter of the inner map directly through
bpf_map_put(), if the ref-counter is the last one (which is true for
most cases), the
inner map will be freed by ops->map_free() in a kworker. But for now,
most .map_free() callbacks don't use synchronize_rcu() or its variants
to
wait for the elapse of a RCU grace period, so after the invocation of
ops->map_free completes, the bpf program which is accessing the inner
map
may incur use-after-free problem. Fix the free of inner map by
invoking bpf_map_free_deferred() after both one RCU grace period and
one tasks
trace RCU grace period if the inner map has been removed from the
outer map before. The deferment is accomplished by using call_rcu() or
call_rcu_tasks_trace() when releasing the last ref-counter of bpf map.
The newly-added rcu_head field in bpf_map shares the same storage
space
with work field to reduce the size of bpf_map.

Introduced by commit 638e4b8 ("bpf: Allows per-cpu maps and map-in-map
in sleepable programs") in 5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [876673364161da50eed6b472d746ef88242b2368]
stable/6.1: [62fca83303d608ad4fec3f7428c8685680bb01b0]
stable/6.6: [f91cd728b10c51f6d4a39957ccd56d1e802fc8ee]
stable/6.7: [bfd9b20c4862f41d4590fde11d70a5eeae53dcc5]

CVE-2023-52448: gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump

Announce: https://lore.kernel.org/linux-cve-announce/2024022255-CVE-2023-52448-7bf2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump Syzkaller
has reported
a NULL pointer dereference when accessing rgd->rd_rgl in
gfs2_rgrp_dump(). This can happen when creating rgd->rd_gl fails in
read_rindex_entry().
Add a NULL pointer check in gfs2_rgrp_dump() to prevent that.

Introduced by commit 72244b6 ("gfs2: improve debug information when
lvb mismatches are found") in 4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [8877243beafa7c6bfc42022cbfdf9e39b25bd4fa]
stable/5.10: [5c28478af371a1c3fdb570ca67f110e1ae60fc37]
stable/5.15: [ee0586d73cbaf0e7058bc640d62a9daf2dfa9178]
stable/5.4: [efc8ef87ab9185a23d5676f2f7d986022d91bcde]
stable/6.1: [d69d7804cf9e2ba171a27e5f98bc266f13d0414a]
stable/6.6: [067a7c48c2c70f05f9460d6f0e8423e234729f05]
stable/6.7: [c323efd620c741168c8e0cc6fc0be04ab57e331a]

CVE-2023-52449: mtd: Fix gluebi NULL pointer dereference caused by ftl notifier

Announce: https://lore.kernel.org/linux-cve-announce/2024022256-CVE-2023-52449-5a7e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A NULL pointer dereference caused by ftl notifier in the mtd driver.

Introduced by commit 2ba3d76 ("UBI: make gluebi a separate module") in
2.6.31-rc1.
Fixed in 6.8-rc1.

Fixed status
mainline: [a43bdc376deab5fff1ceb93dca55bcab8dbdc1d6]
stable/4.19: [aeba358bcc8ffddf9b4a9bd0e5ec9eb338d46022]
stable/5.10: [001a3f59d8c914ef8273461d4bf495df384cc5f8]
stable/5.15: [d8ac2537763b54d278b80b2b080e1652523c7d4c]
stable/5.4: [1bf4fe14e97cda621522eb2f28b0a4e87c5b0745]
stable/6.1: [5389407bba1eab1266c6d83e226fb0840cb98dd5]
stable/6.6: [cfd7c9d260dc0a3baaea05a122a19ab91e193c65]
stable/6.7: [b36aaa64d58aaa2f2cbc8275e89bae76a2b6c3dc]

CVE-2023-52450: perf/x86/intel/uncore: Fix NULL pointer dereference
issue in upi_fill_topology()

Announce: https://lore.kernel.org/linux-cve-announce/2024022256-CVE-2023-52450-48ba@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
perf/x86/intel/uncore: Fix NULL pointer dereference issue in
upi_fill_topology()
Get logical socket id instead of physical id in
discover_upi_topology() to avoid out-of-bound access on 'upi =
&type->topology[nid][idx];'
line that leads to NULL pointer dereference in upi_fill_topology().

Introduced by commit f680b6e ("perf/x86/intel/uncore: Enable UPI
topology discovery for Icelake Server") in 6.2-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [1692cf434ba13ee212495b5af795b6a07e986ce4]
stable/6.6: [bf1bf09e6b599758851457f3999779622a48d015]
stable/6.7: [3d6f4a78b104c65e4256c3776c9949f49a1b459e]

CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of drmem array

Announce: https://lore.kernel.org/linux-cve-announce/2024022257-CVE-2023-52451-7bdb@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
powerpc/pseries/memhp: Fix access beyond end of drmem array
dlpar_memory_remove_by_index() may access beyond the bounds of the
drmem lmb array when the LMB lookup fails to match an entry with the
given
DRC index. When the search fails, the cursor is left pointing to
&drmem_info->lmbs[drmem_info->n_lmbs], which is one element past the
last valid
entry in the array.

Introduced by commit 51925fb ("powerpc/pseries: Implement memory
hotplug remove in the kernel") in 4.1-rc1.
Fixed in 6.8-rc1.

Fixed status
mainline: [bd68ffce69f6cf8ddd3a3c32549d1d2275e49fc5]
stable/4.19: [bb79613a9a704469ddb8d6c6029d532a5cea384c]
stable/5.10: [b582aa1f66411d4adcc1aa55b8c575683fb4687e]
stable/5.15: [999a27b3ce9a69d54ccd5db000ec3a447bc43e6d]
stable/5.4: [9b5f03500bc5b083c0df696d7dd169d7ef3dd0c7]
stable/6.1: [026fd977dc50ff4a5e09bfb0603557f104d3f3a0]
stable/6.6: [df16afba2378d985359812c865a15c05c70a967e]
stable/6.7: [708a4b59baad96c4718dc0bd3a3427d3ab22fedc]

CVE-2023-52452: bpf: Fix accesses to uninit stack slots

Announce: https://lore.kernel.org/linux-cve-announce/2024022258-CVE-2023-52452-7904@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Privileged programs are supposed to be able to read uninitialized
stack memory (ever since 6715df8d5) but, before this patch, these
accesses
were permitted inconsistently. In particular, accesses were permitted
above state->allocated_stack, but not below it. In other words, if the
stack was already "large enough", the access was permitted, but
otherwise the access was rejected instead of being allowed to "grow
the stack".
This undesired rejection was happening in two places:
- in check_stack_slot_within_bounds()
- in check_stack_range_initialized()

Introduced by commit 01f810a ("bpf: Allow variable-offset stack
access") in 5.12-rc1-dontuse.
This patch is backported to 5.10.
Fixed in 6.8-rc1.

Fixed status
mainline: [6b4a64bafd107e521c01eec3453ce94a3fb38529]
stable/6.6: [0954982db8283016bf38e9db2da5adf47a102e19]
stable/6.7: [fbcf372c8eda2290470268e0afb5ab5d5f5d5fde]

CVE-2024-26586: mlxsw: spectrum_acl_tcam: Fix stack corruption

Announce: https://lore.kernel.org/linux-cve-announce/2024022253-CVE-2024-26586-6632@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When tc filters are first added to a net device, the corresponding
local port gets bound to an ACL group in the device. The group
contains a list
of ACLs. In turn, each ACL points to a different TCAM region where the
filters are stored. During forwarding, the ACLs are sequentially
evaluated until a match is found.
One reason to place filters in different regions is when they are
added with decreasing priorities and in an alternating order so that
two
consecutive filters can never fit in the same region because of their key usage.
In Spectrum-2 and newer ASICs the firmware started to report that the
maximum number of ACLs in a group is more than 16, but the layout of
the
register that configures ACL groups (PAGT) was not updated to account
for that. It is therefore possible to hit stack corruption in the
rare case where more than 16 ACLs in a group are required.

Introduced by commit c3ab435 ("mlxsw: spectrum: Extend to support
Spectrum-2 ASIC") in 4.19-rc1.
This commit is not backported to 4.4.
Fixed in 6.8-rc1.

Fixed status
mainline: [483ae90d8f976f8339cf81066312e1329f2d3706]
stable/5.10: [56750ea5d15426b5f307554e7699e8b5f76c3182]
stable/5.15: [348112522a35527c5bcba933b9fefb40a4f44f15]
stable/6.1: [6fd24675188d354b1cad47462969afa2ab09d819]
stable/6.6: [2f5e1565740490706332c06f36211d4ce0f88e62]
stable/6.7: [a361c2c1da5dbb13ca67601cf961ab3ad68af383]

CVE-2024-26587: net: netdevsim: don't try to destroy PHC on VFs

Announce: https://lore.kernel.org/linux-cve-announce/2024022255-CVE-2024-26587-db74@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A NULL pointer dereference bug was found in the netdevsim.

Introduced by commit b63e78f ("net: netdevsim: use mock PHC driver") in 6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [ea937f77208323d35ffe2f8d8fc81b00118bfcda]
stable/6.6: [08aca65997fb6f233066883b1f1e653bcb1f26ca]
stable/6.7: [c5068e442eed063d2f1658e6b6d3c1c6fcf1e588]

CVE-2024-26588: LoongArch: BPF: Prevent out-of-bounds memory access

Announce: https://lore.kernel.org/linux-cve-announce/2024022256-CVE-2024-26588-d6d5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An OOB access bug was found in BPF on LoongArch architecture when
building instructions in build_insn().

Introduced by commit bbfddb9 ("LoongArch: BPF: Avoid declare variables
in switch-case") in 6.1-rc3.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [36a87385e31c9343af9a4756598e704741250a67]
stable/6.1: [4631c2dd69d928bca396f9f58baeddf85e14ced5]
stable/6.6: [9aeb09f4d85a87bac46c010d75a2ea299d462f28]
stable/6.7: [7924ade13a49c0067da6ea13e398102979c0654a]

CVE-2024-26589: bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS

Announce: https://lore.kernel.org/linux-cve-announce/2024022257-CVE-2024-26589-0ee1@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

For PTR_TO_FLOW_KEYS, check_flow_keys_access() only uses fixed off for
validation. However, variable offset ptr alu is not prohibited
for this ptr kind. So the variable offset is not checked.

Introduced by commit d58e468 ("flow_dissector: implements flow
dissector BPF hook") in 4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [22c7fa171a02d310e3a3f6ed46a698ca8a0060ed]
stable/5.15: [29ffa63f21bcdcef3e36b03cccf9d0cd031f6ab0]
stable/6.1: [4108b86e324da42f7ed425bd71632fd844300dc8]
stable/6.6: [e8d3872b617c21100c5ee4f64e513997a68c2e3d]
stable/6.7: [1b500d5d6cecf98dd6ca88bc9e7ae1783c83e6d3]

CVE-2024-26590: erofs: fix inconsistent per-file compression format

Announce: https://lore.kernel.org/linux-cve-announce/2024022259-CVE-2024-26590-85a4@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When invalid algorithm type for specific inodes is used in a crafted
image, that causes a NULL pointer dereference bug in the erofs.

Introduced by commit 622cead ("erofs: lzma compression support") in 5.16-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [118a8cf504d7dfa519562d000f423ee3ca75d2c4]
stable/6.6: [823ba1d2106019ddf195287ba53057aee33cf724]
stable/6.7: [eed24b816e50c6cd18cbee0ff0d7218c8fced199]

CVE-2024-26591: bpf: Fix re-attachment branch in bpf_tracing_prog_attach

Announce: https://lore.kernel.org/linux-cve-announce/2024022258-CVE-2024-26591-8b42@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

The following case can cause a crash due to missing attach_btf:

1) load rawtp program
2) load fentry program with rawtp as target_fd
3) create tracing link for fentry program with target_fd = 0
4) repeat 3

Introduced by commit f3a9507 ("bpf: Allow trampoline re-attach for
tracing and lsm programs") in 5.13-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [715d82ba636cb3629a6e18a33bb9dbe53f9936ee]
stable/5.15: [a7b98aa10f895e2569403896f2d19b73b6c95653]
stable/6.1: [6cc9c0af0aa06f781fa515a1734b1a4239dfd2c0]
stable/6.6: [8c8bcd45e9b10eef12321f08d2e5be33d615509c]
stable/6.7: [50ae82f080cf87e84828f066c31723b781d68f5b]

CVE-2024-26592: ksmbd: fix UAF issue in ksmbd_tcp_new_connection()

Announce: https://lore.kernel.org/linux-cve-announce/2024022259-CVE-2024-26592-58f7@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ksmbd: fix UAF issue in ksmbd_tcp_new_connection().
The race is between the handling of a new TCP connection and its
disconnection. It leads to UAF on `struct tcp_transport` in
ksmbd_tcp_new_connection() function.

The ksmbd was introduced in 5.15 so prior to the 5.15 kernels aren't affected.
Fixed in 6.8-rc1.

Fixed status
mainline: [38d20c62903d669693a1869aa68c4dd5674e2544]
stable/5.15: [999daf367b924fdf14e9d83e034ee0f86bc17ec6]
stable/6.1: [380965e48e9c32ee4263c023e1d830ea7e462ed1]
stable/6.6: [24290ba94cd0136e417283b0dbf8fcdabcf62111]
stable/6.7: [69d54650b751532d1e1613a4fb433e591aeef126]

CVE-2024-26593: i2c: i801: Fix block process call transactions

Announce: https://lore.kernel.org/linux-cve-announce/2024022315-CVE-2024-26593-9d89@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

According to the Intel datasheets, software must reset the block
buffer index twice for block process call transactions: once before
writing the outgoing data to the buffer, and once again before reading
the incoming data from the buffer.
The driver is currently missing the second reset, causing the wrong
portion of the block buffer to be read.

Introduced by commit 315cd67 ("i2c: i801: Add Block Write-Block Read
Process Call support") in 5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc5.

Fixed status
mainline: [c1c9d0f6f7f1dbf29db996bd8e166242843a5f21]
stable/5.10: [7a14b8a477b88607d157c24aeb23e7389ec3319f]
stable/5.15: [1f8d0691c50581ba6043f009ec9e8b9f78f09d5a]
stable/5.4: [d074d5ff5ae77b18300e5079c6bda6342a4d44b7]
stable/6.1: [491528935c9c48bf341d8b40eabc6c4fc5df6f2c]
stable/6.6: [6be99c51829b24c914cef5bff6164877178e84d9]
stable/6.7: [609c7c1cc976e740d0fed4dbeec688b3ecb5dce2]

CVE-2023-52453: hisi_acc_vfio_pci: Update migration data pointer
correctly on saving/resume

Announce: https://lore.kernel.org/linux-cve-announce/2024022325-CVE-2023-52453-9f24@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
hisi_acc_vfio_pci: Update migration data pointer correctly on
saving/resume
When the optional PRE_COPY support was added to speed up the device
compatibility check, it failed to update the saving/resuming data
pointers
based on the fd offset. This results in migration data corruption

Introduced by commit d9a871e ("hisi_acc_vfio_pci: Introduce support
for PRE_COPY state transitions") in 6.2-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [be12ad45e15b5ee0e2526a50266ba1d295d26a88]
stable/6.6: [45f80b2f230df10600e6fa1b83b28bf1c334185e]
stable/6.7: [6bda81e24a35a856f58e6a5786de579b07371603]

CVE-2023-52454: nvmet-tcp: Fix a kernel panic when host sends an
invalid H2C PDU length

Announce: https://lore.kernel.org/linux-cve-announce/2024022330-CVE-2023-52454-5cf0@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

If the host sends an H2CData command with an invalid DATAL, the kernel
may crash in nvmet_tcp_build_pdu_iovec().

Introduced by commit 872d26a ("nvmet-tcp: add NVMe over TCP target
driver") in 5.0-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [efa56305908ba20de2104f1b8508c6a7401833be]
stable/5.10: [f775f2621c2ac5cc3a0b3a64665dad4fb146e510]
stable/5.15: [4cb3cf7177ae3666be7fb27d4ad4d72a295fb02d]
stable/5.4: [ee5e7632e981673f42a50ade25e71e612e543d9d]
stable/6.1: [2871aa407007f6f531fae181ad252486e022df42]
stable/6.6: [24e05760186dc070d3db190ca61efdbce23afc88]
stable/6.7: [70154e8d015c9b4fb56c1a2ef1fc8b83d45c7f68]

CVE-2023-52455: iommu: Don't reserve 0-length IOVA region

Announce: https://lore.kernel.org/linux-cve-announce/2024022331-CVE-2023-52455-a28f@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
iommu: Don't reserve 0-length IOVA region When the bootloader/firmware
doesn't setup the framebuffers, their address and size are 0 in
"iommu-addresses" property. If IOVA region is reserved with 0 length,
then
it ends up corrupting the IOVA rbtree with an entry which has pfn_hi <
pfn_lo. If we intend to use display driver in kernel without
framebuffer
then it's causing the display IOMMU mappings to fail as entire valid
IOVA space is reserved when address and length are passed as 0.
An ideal solution would be firmware removing the "iommu-addresses"
property and corresponding "memory-region" if display is not present.
But the kernel should be able to handle this by checking for size of
IOVA region and skipping the IOVA reservation if size is 0. Also, add
a
warning if firmware is requesting 0-length IOVA region reservation.

Introduced by commit a5bf3cf ("iommu: Implement
of_iommu_get_resv_regions()") in 6.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [bb57f6705960bebeb832142ce9abf43220c3eab1]
stable/6.6: [98b8a550da83cc392a14298c4b3eaaf0332ae6ad]
stable/6.7: [5e23e283910c9f30248732ae0770bcb0c9438abf]

CVE-2023-52456: serial: imx: fix tx statemachine deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2024022331-CVE-2023-52456-f9dd@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
serial: imx: fix tx statemachine deadlock When using the serial port
as RS485 port,
the tx statemachine is used to control the RTS pin to drive the RS485
transceiver TX_EN pin. When the TTY port is closed in the middle of a
transmission
 (for instance during userland application crash), imx_uart_shutdown
disables the interface and disables the Transmission Complete
interrupt. afer that,
 imx_uart_stop_tx bails on an incomplete transmission, to be
retriggered by the TC interrupt. This interrupt is disabled and
therefore the tx statemachine
 never transitions out of SEND. The statemachine is in deadlock now,
and the TX_EN remains low, making the interface useless.
imx_uart_stop_tx now checks
 for incomplete transmission AND whether TC interrupts are enabled
before bailing to be retriggered. This makes sure the state machine
handling is reached,
 and is properly set to WAIT_AFTER_SEND.

Introduced by commit cb1a609 ("serial: imx: implement rts delaying for
rs485") in 5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [78d60dae9a0c9f09aa3d6477c94047df2fe6f7b0]
stable/5.10: [6e04a9d30509fb53ba6df5d655ed61d607a7cfda]
stable/5.15: [ff168d4fdb0e1ba35fb413a749b3d6cce918ec19]
stable/6.1: [63ee7be01a3f7d28b1ea8b8d7944f12bb7b0ed06]
stable/6.6: [763cd68746317b5d746dc2649a3295c1efb41181]
stable/6.7: [9a662d06c22ddfa371958c2071dc350436be802b]

CVE-2023-52457: serial: 8250: omap: Don't skip resource freeing if
pm_runtime_resume_and_get() failed

Announce: https://lore.kernel.org/linux-cve-announce/2024022332-CVE-2023-52457-c7b9@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
serial: 8250: omap: Don't skip resource freeing if
pm_runtime_resume_and_get()
failed Returning an error code from .remove() makes the driver core
emit the little helpful error message: remove callback returned a
non-zero value.
This will be ignored. and then remove the device anyhow. So all
resources that were not freed are leaked in this case. Skipping
serial8250_unregister_port() has the potential to keep enough of the
UART around to trigger a use-after-free. So replace the error return
(and with it the little helpful error message) by a more useful error
message and continue to cleanup.

Introduced by commit e3f0c63 ("serial: 8250: omap: Fix unpaired
pm_runtime_put_sync() in omap8250_remove()") in 6.1-rc6.
This commit is not backported to 4.x kernels.
Fixed in 6.8-rc1.

mainline: [ad90d0358bd3b4554f243a425168fc7cebe7d04e]
stable/5.10: [bc57f3ef8a9eb0180606696f586a6dcfaa175ed0]
stable/5.15: [828cd829483f0cda920710997aed79130b0af690]
stable/5.4: [b502fb43f7fb55aaf07f6092ab44657595214b93]
stable/6.1: [d74173bda29aba58f822175d983d07c8ed335494]
stable/6.6: [887a558d0298d36297daea039954c39940228d9b]
stable/6.7: [95e4e0031effad9837af557ecbfd4294a4d8aeee]

CVE-2023-52458: block: add check that partition length needs to be
aligned with block size

Announce: https://lore.kernel.org/linux-cve-announce/2024022332-CVE-2023-52458-d1cd@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
block: add check that partition length needs to be aligned with block
size Before
calling add partition or resize partition, there is no check on
whether the length is aligned with the logical block size. If the
logical block size of
the disk is larger than 512 bytes, then the partition size maybe not
the multiple of the logical block size, and when the last sector is
read,
bio_truncate() will adjust the bio size, resulting in an IO error if
the size of the read command is smaller than the logical block size.If
integrity
data is supported, this will also result in a null pointer dereference
when calling bio_integrity_free.

Fixed in 6.8-rc1.

Fixed status
mainline: [6f64f866aa1ae6975c95d805ed51d7e9433a0016]
stable/5.15: [5010c27120962c85d2f421d2cf211791c9603503]
stable/6.1: [ef31cc87794731ffcb578a195a2c47d744e25fb8]
stable/6.6: [cb16cc1abda18a9514106d2ac8c8d7abc0be5ed8]
stable/6.7: [bcdc288e7bc008daf38ef0401b53e4a8bb61bbe5]

CVE-2023-52459: media: v4l: async: Fix duplicated list deletion

Announce: https://lore.kernel.org/linux-cve-announce/2024022333-CVE-2023-52459-f653@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
media: v4l: async: Fix duplicated list deletion The list deletion call
dropped here
is already called from the helper function in the line before. Having
a second list_del() call results in either a warning (with
CONFIG_DEBUG_LIST=y):
list_del corruption, c46c8198->next is LIST_POISON1 (00000100) If
CONFIG_DEBUG_LIST is disabled the operation results in a kernel error
due to NULL
pointer dereference.

Introduced by commit 28a1295 ("media: v4l: async: Allow multiple
connections between entities") in 6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [3de6ee94aae701fa949cd3b5df6b6a440ddfb8f2]
stable/6.6: [b7062628caeaec90e8f691ebab2d70f31b7b6b91]
stable/6.7: [49d82811428469566667f22749610b8c132cdb3e]

CVE-2023-52460: drm/amd/display: Fix NULL pointer dereference at hibernate

Announce: https://lore.kernel.org/linux-cve-announce/2024022333-CVE-2023-52460-a52b@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
drm/amd/display: Fix NULL pointer dereference at hibernate During
hibernate sequence the source context
might not have a clk_mgr. So don't use it to look for DML2 support.

Introduced by commit 7966f31 ("drm/amd/display: Introduce DML2") in 6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [b719a9c15d52d4f56bdea8241a5d90fd9197ce99]
stable/6.7: [6b80326efff093d037e0971831dca6ebddba9b45]

CVE-2023-52461: drm/sched: Fix bounds limiting when given a malformed entity

Announce: https://lore.kernel.org/linux-cve-announce/2024022334-CVE-2023-52461-a619@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
drm/sched: Fix bounds limiting when given a malformed entity If we're
given a malformed
entity in drm_sched_entity_init()--shouldn't happen, but we
verify--with out-of-bounds priority value, we set it to an allowed
value. Fix the expression
which sets this limit.

Introduced by commit 56e4496 ("drm/sched: Convert the GPU scheduler to
variable number of run-queues") in 6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [2bbe6ab2be53858507f11f99f856846d04765ae3]
stable/6.7: [1470d173925d697b497656b93f7c5bddae2e64b2]

CVE-2023-52462: bpf: fix check for attempt to corrupt spilled pointer

Announce: https://lore.kernel.org/linux-cve-announce/2024022335-CVE-2023-52462-b663@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
bpf: fix check for attempt to corrupt spilled pointer When register is
spilled
onto a stack as a 1/2/4-byte register, we set slot_type[BPF_REG_SIZE -
1] (plus potentially few more below it, depending on actual spill
size).
So to check if some stack slot has spilled register we need to consult
slot_type[7], not slot_type[0]. To avoid the need to remember and
double-check
this in the future, just use is_spilled_reg() helper.

Introduced by commit 27113c5 ("bpf: Check the other end of slot_type
for STACK_SPILL") in 5.16-rc1.
This commit is not backported to 5.4 and 4.x kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [ab125ed3ec1c10ccc36bc98c7a4256ad114a3dae]
stable/5.10: [2757f17972d87773b3677777f5682510f13c66ef]
stable/5.15: [67e6707f07354ed1acb4e65552e97c60cf9d69cf]
stable/6.1: [fc3e3c50a0a4cac1463967c110686189e4a59104]
stable/6.6: [8dc15b0670594543c356567a1a45b0182ec63174]
stable/6.7: [40617d45ea05535105e202a8a819e388a2b1f036]

CVE-2023-52463: efivarfs: force RO when remounting if SetVariable is
not supported

Announce: https://lore.kernel.org/linux-cve-announce/2024022335-CVE-2023-52463-6195@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
efivarfs: force RO when remounting if SetVariable is not supported If
SetVariable
at runtime is not supported by the firmware we never assign a callback
for that function. At the same time mount the efivarfs as RO so no one
can
call that. However, we never check the permission flags when someone
remounts the filesystem as RW. As a result this leads to a crash.

Introduced by commit f88814c ("efi/efivars: Expose RT service
availability via efivars abstraction") in 5.8-rc7.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [0e8d2444168dd519fea501599d150e62718ed2fe]
stable/5.10: [94c742324ed7e42c5bd6a9ed22e4ec6d764db4d8]
stable/5.15: [2aa141f8bc580f8f9811dfe4e0e6009812b73826]
stable/6.1: [d4a9aa7db574a0da64307729cc031fb68597aa8b]
stable/6.6: [0049fe7e4a85849bdd778cdb72e51a791ff3d737]
stable/6.7: [d4a714873db0866cc471521114eeac4a5072d548]

CVE-2023-52464: EDAC/thunderx: Fix possible out-of-bounds string access

Announce: https://lore.kernel.org/linux-cve-announce/2024022336-CVE-2023-52464-b17c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Enabling -Wstringop-overflow globally exposes a warning for a common
bug in the usage of strncat().
Apparently the author of this driver expected strncat() to behave the
way that strlcat() does, which uses the size of the destination buffer
as its third argument rather than the length of the source buffer. The
result is that there is no check on the size of the allocated buffer.

Introduced by commit 4100339 ("EDAC, thunderx: Add Cavium ThunderX
EDAC driver") in 4.12-rc1.
This commit is not backported to 4.4.
Fixed in 6.8-rc1.

Fixed status
mainline: [475c58e1a471e9b873e3e39958c64a2d278275c8]
stable/4.19: [71c17ee02538802ceafc830f0736aa35b564e601]
stable/5.10: [6aa7865ba7ff7f0ede0035180fb3b9400ceb405a]
stable/5.15: [700cf4bead80fac994dcc43ae1ca5d86d8959b21]
stable/5.4: [5da3b6e7196f0b4f3728e4e25eb20233a9ddfaf6]
stable/6.1: [9dbac9fdae6e3b411fc4c3fca3bf48f70609c398]
stable/6.6: [e1c86511241588efffaa49556196f09a498d5057]
stable/6.7: [426fae93c01dffa379225eb2bd4d3cdc42c6eec5]

CVE-2024-26594: ksmbd: validate mech token in session setup

Announce: https://lore.kernel.org/linux-cve-announce/2024022325-CVE-2024-26594-1cbc@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

If a client send invalid mech token in a session setup request, ksmbd
validates and makes the error if it is invalid.

The ksmbd was introduced in 5.15.
Fixed in 6.8-rc1.

Fixed status
mainline: [92e470163d96df8db6c4fa0f484e4a229edb903d]
stable/5.15: [dd1de9268745f0eac83a430db7afc32cbd62e84b]
stable/6.1: [6eb8015492bcc84e40646390e50a862b2c0529c9]
stable/6.6: [a2b21ef1ea4cf632d19b3a7cc4d4245b8e63202a]
stable/6.7: [5e6dfec95833edc54c48605a98365a7325e5541e]

CVE-2024-26595: mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference
in error path

Announce: https://lore.kernel.org/linux-cve-announce/2024022336-CVE-2024-26595-9a8d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When calling mlxsw_sp_acl_tcam_region_destroy() from an error path
after failing to attach the region to an ACL group, we hit a NULL
pointer
dereference upon 'region->group->tcam'

Introduced by commit 22a6776 ("mlxsw: spectrum: Introduce ACL core
with simple TCAM implementation") in 4.11-rc1.
This commit is not backported to 4.4.
Fixed in 6.8-rc1.

Fixed status
mainline: [efeb7dfea8ee10cdec11b6b6ba4e405edbe75809]
stable/6.6: [817840d125a370626895df269c50c923b79b0a39]
stable/6.7: [d0a1efe417c97a1e9b914056ee6b86f1ef75fe1f]

CVE-2024-26596: net: dsa: fix netdev_priv() dereference before check
on non-DSA netdevice events

Announce: https://lore.kernel.org/linux-cve-announce/2024022336-CVE-2024-26595-9a8d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

An out-of-bound access bug was found in the net/dsa subsystem.

Introduced by commit 4c3f80d ("net: dsa: walk through all changeupper
notifier functions") in 6.1-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [844f104790bd69c2e4dbb9ee3eba46fde1fcea7b]
stable/6.7: [dbd909c20c11f0d29c0054d41e0d1f668a60e8c8]

CVE-2024-26597: net: qualcomm: rmnet: fix global oob in rmnet_policy

Announce: https://lore.kernel.org/linux-cve-announce/2024022337-CVE-2024-26597-be75@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Introduced by commit 14452ca ("net: qualcomm: rmnet: Export mux_id and
flags to netlink") in 4.17-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [b33fb5b801c6db408b774a68e7c8722796b59ecc]
stable/4.19: [093dab655808207f7a9f54cf156240aeafc70590]
stable/5.10: [2295c22348faf795e1ccdf618f6eb7afdb2f7447]
stable/5.15: [3b5254862258b595662a0ccca6e9eeb88d6e7468]
stable/5.4: [02467ab8b404d80429107588e0f3425cf5fcd2e5]
stable/6.1: [ee1dc3bf86f2df777038506b139371a9add02534]
stable/6.6: [c4734535034672f59f2652e1e0058c490da62a5c]
stable/6.7: [17d06a5c44d8fd2e8e61bac295b09153496f87e1]

CVE-2024-26598: KVM: arm64: vgic-its: Avoid potential UAF in LPI
translation cache

Announce: https://lore.kernel.org/linux-cve-announce/2024022338-CVE-2024-26598-24f4@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
KVM: arm64: vgic-its: Avoid potential UAF in LPI translation cache
There
is a potential UAF scenario in the case of an LPI translation cache
hit racing with an operation that invalidates the cache, such as a
DISCARD
ITS command. The root of the problem is that vgic_its_check_cache()
does not elevate the refcount on the vgic_irq before dropping the lock
that serializes refcount changes. Have vgic_its_check_cache() raise
the refcount on the returned vgic_irq and add the corresponding
decrement
after queueing the interrupt.

Fixed in 6.8-rc1.

Fixed status
mainline: [ad362fe07fecf0aba839ff2cc59a3617bd42c33f]
stable/5.10: [ba7be666740847d967822bed15500656b26bc703]
stable/5.15: [12c2759ab1343c124ed46ba48f27bd1ef5d2dff4]
stable/5.4: [d04acadb6490aa3314f9c9e087691e55de153b88]
stable/6.1: [dba788e25f05209adf2b0175eb1691dc89fb1ba6]
stable/6.6: [65b201bf3e9af1b0254243a5881390eda56f72d1]
stable/6.7: [dd3956a1b3dd11f46488c928cb890d6937d1ca80]

CVE-2024-26599: pwm: Fix out-of-bounds access in of_pwm_single_xlate()

Announce: https://lore.kernel.org/linux-cve-announce/2024022338-CVE-2024-26599-cd65@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
pwm: Fix out-of-bounds access in of_pwm_single_xlate()
With args->args_count == 2 args->args[2] is not defined. Actually the
flags are contained in args->args[1].

Introduced by commit 3ab7b6a ("pwm: Introduce single-PWM of_xlate
function") in 5.17-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [a297d07b9a1e4fb8cda25a4a2363a507d294b7c9]
stable/6.1: [7b85554c7c2aee91171e038e4d5442ffa130b282]
stable/6.6: [e5f2b4b62977fb6c2efcbc5779e0c9dce18215f7]
stable/6.7: [bae45b7ebb31984b63b13c3519fd724b3ce92123]

CVE-2024-26600: phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Announce: https://lore.kernel.org/linux-cve-announce/2024022405-CVE-2024-26600-44a2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

If the external phy working together with phy-omap-usb2 does not
implement send_srp(), we may still attempt to call it.
It causes a NULL pointer dereference bug.

Introduced by commit 657b306 ("usb: phy: add a new driver for omap
usb2 phy") in 3.7-rc1.
Fixed in 6.8-rc3.

Fixed status
mainline: [7104ba0f1958adb250319e68a15eff89ec4fd36d]
stable/4.19: [486218c11e8d1c8f515a3bdd70d62203609d4b6b]
stable/5.10: [be3b82e4871ba00e9b5d0ede92d396d579d7b3b3]
stable/5.15: [8cc889b9dea0579726be9520fcc766077890b462]
stable/6.1: [0430bfcd46657d9116a26cd377f112cbc40826a4]
stable/6.6: [14ef61594a5a286ae0d493b8acbf9eac46fd04c4]
stable/6.7: [396e17af6761b3cc9e6e4ca94b4de7f642bfece1]

CVE-2024-26601: ext4: regenerate buddy after block freeing failed if
under fc replay

Announce: https://lore.kernel.org/linux-cve-announce/2024022411-CVE-2024-26601-b6ac@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ext4: regenerate buddy after block freeing failed if under fc replay
This
mostly reverts commit 6bd97bf273bd ("ext4: remove redundant
mb_regenerate_buddy()") and reintroduces mb_regenerate_buddy(). Based
on code in
mb_free_blocks(), fast commit replay can end up marking as free blocks
that are already marked as such. This causes corruption of the buddy
bitmap so we need to regenerate it in that case.

Introduced by commit 6bd97bf ("ext4: remove redundant
mb_regenerate_buddy()") in 5.11-rc1.
This commit was backported to 5.10. However, 5.4, 4.19, and 4.4 are
not affected.
Fixed in 6.8-rc3.

Fixed status
mainline: [c9b528c35795b711331ed36dc3dbee90d5812d4e]
stable/6.1: [78327acd4cdc4a1601af718b781eece577b6b7d4]
stable/6.6: [ea42d6cffb0dd27a417f410b9d0011e9859328cb]
stable/6.7: [6b0d48647935e4b8c7b75d1eccb9043fcd4ee581]

CVE-2024-26602: sched/membarrier: reduce the ability to hammer on sys_membarrier

Announce: https://lore.kernel.org/linux-cve-announce/2024022414-CVE-2024-26602-5e76@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
sched/membarrier: reduce the ability to hammer on sys_membarrier On
some systems,
sys_membarrier can be very expensive, causing overall slowdowns for
everything. So put a lock on the path in order to serialize the
accesses to
prevent the ability for this to be called at too high of a frequency
and saturate the machine.

Introduced by commit c5f58bd ("membarrier: Provide GLOBAL_EXPEDITED
command") in 4.16-rc1.
Linux 4.4 is not affected.
Fixed in 6.8-rc6.

Fixed status
mainline: [944d5fe50f3f03daacfea16300e656a1691c4a23]
stable/4.19: [3cd139875e9a7688b3fc715264032620812a5fa3]
stable/5.10: [db896bbe4a9c67cee377e5f6a743350d3ae4acf6]
stable/5.15: [50fb4e17df319bb33be6f14e2a856950c1577dee]
stable/6.1: [24ec7504a08a67247fbe798d1de995208a8c128a]
stable/6.6: [b6a2a9cbb67545c825ec95f06adb7ff300a2ad71]
stable/6.7: [c5b2063c65d05e79fad8029324581d86cfba7eea]

CVE-2024-26603: x86/fpu: Stop relying on userspace for info to fault
in xsave buffer

Announce: https://lore.kernel.org/linux-cve-announce/2024022415-CVE-2024-26603-42c2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Before this change, the expected size of the user space buffer was
taken from fx_sw->xstate_size. fx_sw->xstate_size can be changed
from user-space, so it is possible construct a sigreturn frame where:

 * fx_sw->xstate_size is smaller than the size required by valid bits in
   fx_sw->xfeatures.
 * user-space unmaps parts of the sigrame fpu buffer so that not all of
   the buffer required by xrstor is accessible.

In this case, xrstor tries to restore and accesses the unmapped area
which results in a fault. But fault_in_readable succeeds because buf +
fx_sw->xstate_size is within the still mapped area, so it goes back and
tries xrstor again. It will spin in this loop forever.

Instead, fault in the maximum size which can be touched by XRSTOR (taken
from fpstate->user_size).

Introduced by commit fcb3635 ("x86/fpu/signal: Handle #PF in the
direct restore path") in 5.14-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc4.

Fixed status
mainline: [d877550eaf2dc9090d782864c96939397a3c6835]
stable/6.1: [627339cccdc9166792ecf96bc3c9f711a60ce996]
stable/6.6: [b2479ab426cef7ab79a13005650eff956223ced2]
stable/6.7: [627e28cbb65564e55008315d9e02fbb90478beda]

CVE-2024-26604: Revert "kobject: Remove redundant checks for whether
ktype is NULL"

Announce: https://lore.kernel.org/linux-cve-announce/2024022416-CVE-2024-26604-71a3@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
Revert "kobject: Remove redundant checks for whether ktype is NULL"
This reverts commit 1b28cb81dab7c1eedc6034206f4e8d644046ad31. It is
reported to cause problems, so revert it for now until the root cause
can be found.

Introduced by commit 1b28cb8 ("kobject: Remove redundant checks for
whether ktype is NULL") in 6.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc5.

Fixed status
mainline: [3ca8fbabcceb8bfe44f7f50640092fd8f1de375c]
stable/6.6: [7f414d306320f837cc3df96cf52161cb8290fb1b]
stable/6.7: [b746d52ce7bcac325a2fa264216ead85b7fbbfaa]

CVE-2024-26605: PCI/ASPM: Fix deadlock when enabling ASPM

Announce: https://lore.kernel.org/linux-cve-announce/2024022419-CVE-2024-26605-7b06@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A last minute revert in 6.7-final introduced a potential deadlock when
enabling ASPM during probe of Qualcomm PCIe controllers as reported by
lockdep.

Introduced by commit f93e71a ("Revert "PCI/ASPM: Remove
pcie_aspm_pm_state_change()"") in 6.7.
This commit was backported to 5.15 and 6.1. 5.10, 5.4, 4.19, 4.4 are
not affected.
Fixed in 6.8-rc3.

Fixed status
mainline: [1e560864159d002b453da42bd2c13a1805515a20]
stable/6.7: [ef90508574d7af48420bdc5f7b9a4f1cdd26bc70]

CVE-2023-52465: power: supply: Fix null pointer dereference in smb2_probe

Announce: https://lore.kernel.org/linux-cve-announce/2024022539-CVE-2023-52465-2e75@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

devm_kasprintf and devm_kzalloc return a pointer to dynamically
allocated memory which can be NULL upon failure.

Introduced by commit 8648aeb ("power: supply: add Qualcomm PMI8998
SMB2 Charger driver") in 6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [88f04bc3e737155e13caddf0ba8ed19db87f0212]
stable/6.6: [e2717302fbc20f148bcda362facee0444b949a3a]
stable/6.7: [bd3d2ec447ede9da822addf3960a5f4275e3ae76]

CVE-2023-52466: PCI: Avoid potential out-of-bounds read in
pci_dev_for_each_resource()

Announce: https://lore.kernel.org/linux-cve-announce/2024022544-CVE-2023-52466-fea5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Coverity complains that pointer in the pci_dev_for_each_resource() may be
wrong, i.e., might be used for the out-of-bounds read.

There is no actual issue right now because we have another check afterwards
and the out-of-bounds read is not being performed. In any case it's better
code with this fixed, hence the proposed change.

As Jonas pointed out "It probably makes the code slightly less performant
as res will now be checked for being not NULL (which will always be true),
but I doubt it will be significant (or in any hot paths)."

Introduced by commit 09cc900 ("PCI: Introduce
pci_dev_for_each_resource()") in 6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [3171e46d677a668eed3086da78671f1e4f5b8405]
stable/6.6: [5b3e25efe16e06779a9a7c7610217c1b921ec179]
stable/6.7: [bd26159dcaaa3e9a927070efd348e7ce7e5ee933]

CVE-2023-52467: mfd: syscon: Fix null pointer dereference in
of_syscon_register()

Announce: https://lore.kernel.org/linux-cve-announce/2024022544-CVE-2023-52467-434b@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

kasprintf() returns a pointer to dynamically allocated memory which
can be NULL upon failure.

Introduced by commit e15d7f2 ("mfd: syscon: Use a unique name with
regmap_config") in 5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [41673c66b3d0c09915698fec5c13b24336f18dd1]
stable/5.10: [927626a2073887ee30ba00633260d4d203f8e875]
stable/5.15: [c3e3a2144bf50877551138ffce9f7aa6ddfe385b]
stable/6.1: [527e8c5f3d00299822612c495d5adf1f8f43c001]
stable/6.6: [3ef1130deee98997275904d9bfc37af75e1e906c]
stable/6.7: [7f2c410ac470959b88e03dadd94b7a0b71df7973]

CVE-2023-52468: class: fix use-after-free in class_register()

Announce: https://lore.kernel.org/linux-cve-announce/2024022545-CVE-2023-52468-59a2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

The lock_class_key is still registered and can be found in
lock_keys_hash hlist after subsys_private is freed in error
handler path.A task who iterate over the lock_keys_hash later may
cause use-after-free.So fix that up and unregister
the lock_class_key before kfree(cp).

On our platform, a driver fails to kset_register because of creating
duplicate filename '/class/xxx'.With Kasan enabled,
it prints a invalid-access bug report.

Introduced by commit dcfbb67 ("driver core: class: use lock_class_key
already present in struct subsys_private") in 6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [93ec4a3b76404bce01bd5c9032bef5df6feb1d62]
stable/6.6: [b57196a5ec5e4c0ffecde8348b085b778c7dce04]
stable/6.7: [0f1486dafca3398c4c46b9f6e6452fa27e73b559]

CVE-2023-52469: drivers/amd/pm: fix a use-after-free in kv_parse_power_table

Announce: https://lore.kernel.org/linux-cve-announce/2024022546-CVE-2023-52469-5141@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When ps allocated by kzalloc equals to NULL, kv_parse_power_table
frees adev->pm.dpm.ps that allocated before. However, after the control
flow goes through the following call chains:

kv_parse_power_table
  |-> kv_dpm_init
        |-> kv_dpm_sw_init
          |-> kv_dpm_fini

The adev->pm.dpm.ps is used in the for loop of kv_dpm_fini after its
first free in kv_parse_power_table and causes a use-after-free bug.

Introduced by commit in a2e73f5 ("drm/amdgpu: Add support for CIK
parts") in 4.2-rc1.
Fixed in 6.8-rc1.

Fixed status
mainline: [28dd788382c43b330480f57cd34cde0840896743]
stable/4.19: [8a27d9d9fc9b5564b8904c3a77a7dea482bfa34e]
stable/5.10: [520e213a0b97b64735a13950e9371e0a5d7a5dc3]
stable/5.15: [b6dcba02ee178282e0d28684d241e0b8462dea6a]
stable/5.4: [8b55b06e737feb2a645b0293ea27e38418876d63]
stable/6.1: [35fa2394d26e919f63600ce631e6aefc95ec2706]
stable/6.6: [95084632a65d5c0d682a83b55935560bdcd2a1e3]
stable/6.7: [3426f059eacc33ecc676b0d66539297e1cfafd02]

CVE-2023-52470: drm/radeon: check the alloc_workqueue return value in
radeon_crtc_init()

Announce: https://lore.kernel.org/linux-cve-announce/2024022546-CVE-2023-52470-44d1@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

check the alloc_workqueue return value in radeon_crtc_init() to avoid
null-ptr-deref.

Introduced by commit fa7f517 ("drm/radeon: rework page flip handling
v4") in 3.16-rc1.
Fixed in 6.8-rc1.

Fixed status
mainline: [7a2464fac80d42f6f8819fed97a553e9c2f43310]
stable/4.19: [21b1645660717d6126dd4866c850fcc5c4703a41]
stable/5.10: [57ca7984806d79b38af528de88fd803babf27feb]
stable/5.15: [14bbfaa5df273b26cde6707f6e655585700e6fe1]
stable/5.4: [5d12c5d75f7c78b83a738025947651ec5c95b4d4]
stable/6.1: [c4ff55408187f2595066967047363ca84e76db85]
stable/6.6: [0b813a6a0087451cb702b6eb841f10856f49d088]
stable/6.7: [fb2d8bc9b5e55848b8a7c3c028e2ee8d49f28f97]

CVE-2023-52471: ice: Fix some null pointer dereference issues in ice_ptp.c

Announce: https://lore.kernel.org/linux-cve-announce/2024022546-CVE-2023-52471-ab29@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ice: Fix some null pointer dereference issues in ice_ptp.c
devm_kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure.

Introduced by commit d938a8c ("ice: Auxbus devices & driver for E822
TS") in 6.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [3027e7b15b02d2d37e3f82d6b8404f6d37e3b8cf]
stable/6.7: [3cd9b9bee33f39f6c6d52360fe381b89a7b12695]

CVE-2023-52472: crypto: rsa - add a check for allocation failure

Announce: https://lore.kernel.org/linux-cve-announce/2024022547-CVE-2023-52472-fa03@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
crypto: rsa - add a check for allocation failure Static checkers
insist that the mpi_alloc() allocation can fail so add a check to
prevent a NULL dereference. Small allocations like this can't actually
fail in current kernels, but adding a check is very simple and makes
the static checkers happy.

Introduced by commit 6637e11 ("crypto: rsa - allow only odd e and
restrict value in FIPS mode") in 6.5-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [d872ca165cb67112f2841ef9c37d51ef7e63d1e4]
stable/6.6: [2831f4d3bfa68e64c5f83e96688be779c87b3511]
stable/6.7: [95ad8b6879e2e49d02e3bfc0e1fb46421633fe2a]

CVE-2023-52473: thermal: core: Fix NULL pointer dereference in zone
registration error path

Announce: https://lore.kernel.org/linux-cve-announce/2024022547-CVE-2023-52473-c3cc@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
thermal: core: Fix NULL pointer dereference in zone registration error
path If device_register() in thermal_zone_device_register_with_trips()
returns an error, the tz variable is set to NULL and subsequently
dereferenced in kfree(tz->tzp). Commit adc8749b150c
("thermal/drivers/core: Use put_device() if device_register() fails")
added the tz = NULL
assignment in question to avoid a possible double-free after dropping
the reference to the zone device. However, after commit 4649620d9404
("thermal: core: Make thermal_zone_device_unregister() return after
freeing the zone"), that assignment has become redundant, because
dropping
the reference to the zone device does not cause the zone object to be
freed any more. Drop it to address the NULL pointer dereference.

Introduced by commit 3d439b1 ("thermal/core: Alloc-copy-free the
thermal zone parameters structure") in 6.4-rc1.
This commit is not backported to older stable kernels.
Fixed in 6.8-rc1.

Fixed status
mainline: [04e6ccfc93c5a1aa1d75a537cf27e418895e20ea]
stable/6.6: [335176dd8ebaca6493807dceea33c478305667fa]
stable/6.7: [02871710b93058eb1249d5847c0b2d1c2c3c98ae]

CVE-2021-46904: net: hso: fix null-ptr-deref during tty device unregistration

Announce: https://lore.kernel.org/linux-cve-announce/2024022555-CVE-2021-46904-d49f@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
net: hso: fix null-ptr-deref during tty device unregistration Multiple
ttys
try to claim the same the minor number causing a double unregistration
of the same device. The first unregistration succeeds but the next one
results in a null-ptr-deref. The get_free_serial_index() function
returns an available minor number but doesn't assign it immediately.
The assignment is done by the caller later. But before this
assignment, calls to get_free_serial_index() would return the same
minor number.
Fix this by modifying get_free_serial_index to assign the minor number
immediately after one is found to be and rename it to obtain_minor()
to
better reflect what it does. Similary, rename set_serial_by_index() to
release_minor() and modify it to free up the minor number of the
given hso_serial. Every obtain_minor() should have corresponding
release_minor() call.

Introduced by commit 72dc1c0 ("HSO: add option hso driver") in 2.6.27-rc1.
Fixed in 5.12-rc7.

Fixed status
cip/4.4: [a462067d7c8e6953a733bf5ade8db947b1bb5449]
cip/4.4-rt: [a462067d7c8e6953a733bf5ade8db947b1bb5449]
cip/4.4-st: [a462067d7c8e6953a733bf5ade8db947b1bb5449]
mainline: [8a12f8836145ffe37e9c8733dce18c22fb668b66]
stable/4.14: [caf5ac93b3b5d5fac032fc11fbea680e115421b4]
stable/4.19: [92028d7a31e55d53e41cff679156b9432cffcb36]
stable/4.4: [a462067d7c8e6953a733bf5ade8db947b1bb5449]
stable/4.9: [145c89c441d27696961752bf51b323f347601bee]
stable/5.10: [dc195928d7e4ec7b5cfc6cd10dc4c8d87a7c72ac]
stable/5.4: [4a2933c88399c0ebc738db39bbce3ae89786d723]

CVE-2021-46905: net: hso: fix NULL-deref on disconnect regression

Announce: https://lore.kernel.org/linux-cve-announce/2024022557-CVE-2021-46905-6507@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
net: hso: fix NULL-deref on disconnect regression Commit
8a12f8836145 ("net: hso: fix null-ptr-deref during tty device
unregistration") fixed the racy minor allocation reported by syzbot,
but introduced an unconditional NULL-pointer dereference on every
disconnect instead. Specifically, the serial device table must no
longer
be accessed after the minor has been released by hso_serial_tty_unregister().

Introduced by commit 8a12f88 ("net: hso: fix null-ptr-deref during tty
device unregistration") in v5.12-rc7.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [5871761c5f0f20d6e98bf3b6bd7486d857589554]
cip/4.4-rt: [5871761c5f0f20d6e98bf3b6bd7486d857589554]
cip/4.4-st: [5871761c5f0f20d6e98bf3b6bd7486d857589554]
mainline: [2ad5692db72874f02b9ad551d26345437ea4f7f3]
stable/4.14: [24b699bea7553fc0b98dad9d864befb6005ac7f1]
stable/4.19: [5c17cfe155d21954b4c7e2a78fa771cebcd86725]
stable/4.4: [5871761c5f0f20d6e98bf3b6bd7486d857589554]
stable/4.9: [0c71d4c89559f72cec2592d078681a843bce570e]
stable/5.10: [90642ee9eb581a13569b1c0bd57e85d962215273]
stable/5.4: [d7fad2ce15bdbbd0fec3ebe999fd7cab2267f53e]

CVE-2022-48626: moxart: fix potential use-after-free on remove path

Announce: https://lore.kernel.org/linux-cve-announce/2024022558-CVE-2022-48626-8a90@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
moxart: fix potential use-after-free on remove path It was reported
that
the mmc host structure could be accessed after it was freed in
moxart_remove(), so fix this by saving the base register of the device
and using
it instead of the pointer dereference.

Fixed in 5.17-rc4.

Fixed status
cip/4.4: [f86b87424a132623dd8d15801c578b2d5e351060]
cip/4.4-rt: [f86b87424a132623dd8d15801c578b2d5e351060]
cip/4.4-st: [f86b87424a132623dd8d15801c578b2d5e351060]
mainline: [bd2db32e7c3e35bd4d9b8bbff689434a50893546]
stable/4.14: [e6f580d0b3349646d4ee1ce0057eb273e8fb7e2e]
stable/4.19: [9c25d5ff1856b91bd4365e813f566cb59aaa9552]
stable/4.9: [f5dc193167591e88797262ec78515a0cbe79ff5f]
stable/5.10: [be93028d306dac9f5b59ebebd9ec7abcfc69c156]
stable/5.15: [af0e6c49438b1596e4be8a267d218a0c88a42323]
stable/5.4: [3a0a7ec5574b510b067cfc734b8bdb6564b31d4e]

CVE-2020-36775: f2fs: fix to avoid potential deadlock

Announce: https://lore.kernel.org/linux-cve-announce/2024022602-CVE-2020-36775-1cbe@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Using f2fs_trylock_op() in f2fs_write_compressed_pages() to avoid
potential deadlock like we did in f2fs_write_single_data_page().

Fixed in 5.7-rc1.

Fixed status
mainline: [df77fbd8c5b222c680444801ffd20e8bbc90a56e]
stable/5.4: [0478ccdc8ea016de1ebaf6fe6da0275c2b258c5b]

CVE-2023-52474: IB/hfi1: Fix bugs with non-PAGE_SIZE-end multi-iovec
user SDMA requests

Announce: https://lore.kernel.org/linux-cve-announce/2024022603-CVE-2023-52474-6691@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is bugs in hfi1 user SDMA request processing causing data
corruption due to mishandling iovec lengths and incorrect advancement
across iovecs,
alongside issues in SDMA pin cache management, including overlapping
pinnings and refcount mismanagement, necessitating fixes to prevent
data loss.

Introduced by commit 7be8567 ("IB/hfi1: Don't remove RB entry when not
needed.") in 4.14-rc1 and 7724105 ("IB/hfi1: add driver files") in
v4.3-rc1.
Fixed in 6.4-rc1.

Fixed status
mainline: [00cbce5cbf88459cd1aa1d60d0f1df15477df127]
stable/5.10: [9c4c6512d7330b743c4ffd18bd999a86ca26db0d]
stable/5.15: [a2bd706ab63509793b5cd5065e685b7ef5cba678]
stable/6.1: [dce59b5443700fbd0d2433ec6e4d4cf063448844]

CVE-2024-26606: binder: signal epoll threads of self-work

Announce: https://lore.kernel.org/linux-cve-announce/2024022620-CVE-2024-26606-64b6@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
binder: signal epoll threads of self-work In (e)poll mode, threads
often depend
on I/O events to determine when data is ready for consumption. Within
binder, a thread may initiate a command via BINDER_WRITE_READ without
a
read buffer and then make use of epoll_wait() or similar to consume
any responses afterwards. It is then crucial that epoll threads are
signaled
via wakeup when they queue their own work. Otherwise, they risk
waiting indefinitely for an event leaving their work unhandled. What
is worse,
subsequent commands won't trigger a wakeup either as the thread has
pending work.

Introduced by commit 457b9a6 ("Staging: android: add binder driver")
in 2.6.29-rc1.
Fixed in 6.8-rc3.

Fixed status
mainline: [97830f3c3088638ff90b20dfba2eb4d487bf14d7]
stable/4.19: [dd64bb8329ce0ea27bc557e4160c2688835402ac]
stable/5.10: [a423042052ec2bdbf1e552e621e6a768922363cc]
stable/5.15: [82722b453dc2f967b172603e389ee7dc1b3137cc]
stable/5.4: [42beab162dcee1e691ee4934292d51581c29df61]
stable/6.1: [90e09c016d72b91e76de25f71c7b93d94cc3c769]
stable/6.6: [a7ae586f6f6024f490b8546c8c84670f96bb9b68]
stable/6.7: [93b372c39c40cbf179e56621e6bc48240943af69]

CVE-2019-25160: netlabel: fix out-of-bounds memory accesses

Announce: https://lore.kernel.org/linux-cve-announce/2024022657-CVE-2019-25160-e487@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There are two array out-of-bounds memory accesses, one in
cipso_v4_map_lvl_valid(), the other in netlbl_bitmap_walk().  Both
errors are embarassingly simple, and the fixes are straightforward.

As a FYI for anyone backporting this patch to kernels prior to v4.8,
you'll want to apply the netlbl_bitmap_walk() patch to
cipso_v4_bitmap_walk() as netlbl_bitmap_walk() doesn't exist before Linux v4.8.

Introduced by commit 446fda4 ("[NetLabel]: CIPSOv4 engine") in 2.6.19-rc1 and
3faa8f9 ("netlabel: Move bitmap manipulation functions to the NetLabel
core.") in 4.8-rc1.
Fixed in 5.0.

Fixed status
cip/4.4: [dc18101f95fa6e815f426316b8b9a5cee28a334e]
cip/4.4-rt: [dc18101f95fa6e815f426316b8b9a5cee28a334e]
cip/4.4-st: [dc18101f95fa6e815f426316b8b9a5cee28a334e]
mainline: [5578de4834fe0f2a34fedc7374be691443396d1f]
stable/4.19: [e3713abc4248aa6bcc11173d754c418b02a62cbb]

CVE-2019-25161: drm/amd/display: prevent memory leak

Announce: https://lore.kernel.org/linux-cve-announce/2024022601-CVE-2019-25161-f77d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This CVE is rejected.

In the Linux kernel, the following vulnerability has been resolved:
drm/amd/display: prevent memory leak In dcn*_create_resource_pool
the allocated memory should be released if construct pool fails.

Fixed in 5.4-rc1.

Fixed status
mainline: [104c307147ad379617472dd91a5bcb368d72bd6d]
stable/4.19: [60e1b411bf0fd9fda2d2de7f45dc3b1d9960b85e]

CVE-2019-25162: i2c: Fix a potential use after free

Announce: https://lore.kernel.org/linux-cve-announce/2024022602-CVE-2019-25162-70ae@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
i2c: Fix a potential use after free Free the adap structure only
after we are done using it. This patch just moves the put_device()
down a bit to avoid the use after free. [wsa: added comment to
the code, added Fixes tag]

Introduced by commit 611e12e ("i2c: core: manage i2c bus device
refcount in i2c_[get|put]_adapter") in 4.3-rc1.
Fixed in 6.0-rc1.

Fixed status
mainline: [e4c72c06c367758a14f227c847f9d623f1994ecf]
stable/4.19: [23a191b132cd87f746c62f3dc27da33683d85829]
stable/5.10: [81cb31756888bb062e92d2dca21cd629d77a46a9]
stable/5.15: [35927d7509ab9bf41896b7e44f639504eae08af7]
stable/5.4: [871a1e94929a27bf6e2cd99523865c840bbc2d87]

CVE-2021-46906: HID: usbhid: fix info leak in hid_submit_ctrl

Announce: https://lore.kernel.org/linux-cve-announce/2024022603-CVE-2021-46906-636c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
HID: usbhid: fix info leak in hid_submit_ctrl In hid_submit_ctrl(),
the way of calculating the report length doesn't take into account
that report->size can be zero. When running the syzkaller reproducer,
a report of size 0 causes hid_submit_ctrl() to calculate
transfer_buffer_length as 16384. When this urb is passed to the usb
core layer,
KMSAN reports an info leak of 16384 bytes. To fix this, first modify
hid_report_len() to account for the zero report size case by using
DIV_ROUND_UP for the division. Then, call it from hid_submit_ctrl().

Fixed in 5.13-rc1.

Fixed status
cip/4.4: [c5d3c142f2d57d40c55e65d5622d319125a45366]
cip/4.4-rt: [c5d3c142f2d57d40c55e65d5622d319125a45366]
cip/4.4-st: [c5d3c142f2d57d40c55e65d5622d319125a45366]
mainline: [6be388f4a35d2ce5ef7dbf635a8964a5da7f799f]
stable/4.19: [0e280502be1b003c3483ae03fc60dea554fcfa82]
stable/5.10: [b1e3596416d74ce95cc0b7b38472329a3818f8a9]
stable/5.4: [7f5a4b24cdbd7372770a02f23e347d7d9a9ac8f1]

CVE-2020-36776: thermal/drivers/cpufreq_cooling: Fix slab OOB issue

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-1-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Slab OOB issue is scanned by KASAN in cpu_power_to_freq(). If power is
limited below the power of OPP0 in EM table,
it will cause slab out-of-bound issue with negative array index.
Return the lowest frequency if limited power cannot found a suitable
OPP in EM table to fix this issue.

Introduced by commit 371a3bc ("thermal/drivers/cpufreq_cooling: Fix
wrong frequency converted from power") in 5.8-rc4.
This patci is backported to 5.4 and 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [34ab17cc6c2c1ac93d7e5d53bb972df9a968f085]
stable/5.10: [c24a20912eef00587416628149c438e885eb1304]

CVE-2020-36777: media: dvbdev: Fix memory leak in dvb_media_device_free()

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-2-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
media: dvbdev: Fix memory leak in dvb_media_device_free()
dvb_media_device_free() is leaking memory. Free
`dvbdev->adapter->conn` before setting it to NULL, as documented in
include/media/media-device.h: "The media_entity instance itself must
be freed explicitly by the driver if required."

Introduced by commit 0230d60 ("[media] dvbdev: Add RF connect0or if
needed") in 4.5-rc1.
This patch is not backported to 4.4.
Fixed in 5.13-rc1.

Fixed status
mainline: [bf9a40ae8d722f281a2721779595d6df1c33a0bf]
stable/4.19: [cd89f79be5d553c78202f686e8e4caa5fbe94e98]
stable/5.10: [43263fd43083e412311fa764cd04a727b0c6a749]
stable/5.4: [9185b3b1c143b8da409c19ac5a785aa18d67a81b]

CVE-2021-46925: net/smc: fix kernel panic caused by race of smc_sock

Announce: https://lore.kernel.org/linux-cve-announce/2024022748-CVE-2021-46925-c422@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A crash occurs when smc_cdc_tx_handler() tries to access smc_sock but
smc_release() has already freed it.

Introduced by commit 5f08318 ("smc: connection data control (CDC)") in 4.11-rc1.
This patch is not backported to 4.4.
Fixed in 5.16-rc8

Fixed status
mainline: [349d43127dac00c15231e8ffbcaabd70f7b0e544]
stable/5.10: [e8a5988a85c719ce7205cb00dcf0716dcf611332]
stable/5.15: [b85f751d71ae8e2a15e9bda98852ea9af35282eb]

CVE-2021-46926: ALSA: hda: intel-sdw-acpi: harden detection of controller

Announce: https://lore.kernel.org/linux-cve-announce/2024022748-CVE-2021-46926-9967@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ALSA: hda: intel-sdw-acpi: harden detection of controller The
existing code currently sets a pointer to an ACPI handle before
checking that it's actually a SoundWire controller. This can lead
to issues where the graph walk continues and eventually fails, but the
pointer was set already. This patch changes the logic so
that the information provided to the caller is set when a controller is found.

Introduced commit is not determined.
The sdw_intel_acpi_cb() is introcued by commit d62a7d41 ("soundwire:
intel: Add Intel init module") in 4.16-rc1.
Fixed in 5.16-rc7.

Fixed status
mainline: [385f287f9853da402d94278e59f594501c1d1dad]
stable/5.15: [cce476954401e3421afafb25bbaa926050688b1d]

CVE-2021-46928: parisc: Clear stale IIR value on instruction access rights trap

Announce: https://lore.kernel.org/linux-cve-announce/2024022748-CVE-2021-46926-9967@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
parisc: Clear stale IIR value on instruction access rights trap
When a trap 7 (Instruction access rights) occurs, this means the CPU
couldn't execute an instruction due to missing execute permissions
on the memory region. In this case it seems the CPU didn't even
fetched the instruction from memory and thus did not store it in the
cr19 (IIR) register before calling the trap handler. So, the trap
handler will find some random old stale value in cr19. This patch
simply overwrites the stale IIR value with a constant magic "bad food"
value (0xbaadf00d), in the hope people don't start to try to
understand the various random IIR values in trap 7 dumps.

Introduced commit is not determined.
Patch may be able to apply to 4.19 and 4.4.
Fixed in 5.16-rc7.

Fixed status
mainline: [484730e5862f6b872dca13840bed40fd7c60fa26]
stable/5.10: [d01e9ce1af6116f812491d3d3873d204f10ae0b8]
stable/5.15: [e96373f0a5f484bc1e193f9951dcb3adf24bf3f7]

CVE-2021-46938: dm rq: fix double free of blk_mq_tag_set in dev remove
after table load fails

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-3-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When loading a device-mapper table for a request-based mapped device,
and the allocation/initialization of the blk_mq_tag_set for the device
fails, a following device remove will cause a double free.

Introduced by commit 1c357a1 ("dm: allocate blk_mq_tag_set rather than
embed in mapped_device") in 4.6-rc1.
This patch is not backported to 4.4.
Fixed in 5.13-rc1.

Fixed status
mainline: [8e947c8f4a5620df77e43c9c75310dc510250166]
stable/4.19: [772b9f59657665af3b68d24d12b9d172d31f0dfb]
stable/5.10: [1cb02dc76f4c0a2749a02b26469512d6984252e9]
stable/5.4: [a992a283c0b77d0a7c2c348add0e6a21fb1dab67]

CVE-2021-46939: tracing: Restructure trace_clock_global() to never block

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-4-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It was reported that a fix to the ring buffer recursion detection
would cause a hung machine when performing suspend / resume testing.

Introduced by commit b02414c ("ring-buffer: Fix recursion protection
transitions between interrupt context") # started showing the problem
in 5.10-rc3
and 14131f2 ("tracing: implement trace_clock_*() APIs") in 2.6.30-rc1.
The commit b02414c is backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [91ca6f6a91f679c8645d7f3307e03ce86ad518c4]
cip/4.4-rt: [91ca6f6a91f679c8645d7f3307e03ce86ad518c4]
cip/4.4-st: [91ca6f6a91f679c8645d7f3307e03ce86ad518c4]
mainline: [aafe104aa9096827a429bc1358f8260ee565b7cc]
stable/4.19: [d43d56dbf452ccecc1ec735cd4b6840118005d7c]
stable/5.10: [a33614d52e97fc8077eb0b292189ca7d964cc534]
stable/5.4: [c64da3294a7d59a4bf6874c664c13be892f15f44]

CVE-2021-46940: tools/power turbostat: Fix offset overflow issue in
index converting

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-5-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
tools/power turbostat: Fix offset overflow issue in index converting
The idx_to_offset() function returns type int (32-bit signed), but
MSR_PKG_ENERGY_STAT is u32 and would be interpreted as a negative
number.
The end result is that it hits the if (offset < 0) check in
update_msr_sum() which prevents the timer callback from updating the
stat in
the background when long durations are used. The similar issue exists
in offset_to_idx() and update_msr_sum(). Fix this issue by converting
t
he 'int' to 'off_t' accordingly.

Introduced by commit 9972d5d ("tools/power turbostat: Enable
accumulate RAPL display") in 5.10-rc4.
This patch is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [13a779de4175df602366d129e41782ad7168cef0]
stable/5.10: [ea6803ff2cd1a2d7d880256bf562172b708a76ff]

CVE-2021-46941: usb: dwc3: core: Do core softreset when switch mode

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-6-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A lockup issue was found in HiKey960 platform because lacks of do
required steps  to switch mode for DRD controller.

Introduced by commit 41ce145 ("usb: dwc3: core: make dwc3_set_mode()
work properly") in 4.12-rc1.
This commit is not backported to 4.4.
Fixed in 5.13-rc1.

Fixed status
mainline: [f88359e1588b85cf0e8209ab7d6620085f3441d9]
stable/5.10: [fce7bbcd07d59ac30dba8ce225316b3b4c1c7b50]

CVE-2021-46942: io_uring: fix shared sqpoll cancellation hangs

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-7-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

We call io_uring_cancel_sqpoll() one by one for each ctx either in
sq_thread() itself or via task works, and it's intended to cancel all
requests of a specified context. However the function uses per-task
counters to track the number of inflight requests, so it counts more
requests than available via currect io_uring ctx and goes to sleep for
them to appear (e.g. from IRQ), that will never happen.
Cancel a bit more than before, i.e. all ctxs that share sqpoll and
continue to use shared counters. Don't forget that we should not
remove ctx from the list before running that task_work sqpoll-cancel,
otherwise the function wouldn't be able to find the context and will
hang.

Introduced by commit 37d1e2e ("io_uring: move SQPOLL thread io-wq
forked worker") in 5.12-rc1dontuse.
This patch is not backported to 5.10. The io_uring is introcued in 5.1
so 4.x kernels are not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [734551df6f9bedfbefcd113ede665945e9de0b99]

CVE-2021-46943: media: staging/intel-ipu3: Fix set_fmt error handling

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-8-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

If there in an error during a set_fmt, do not overwrite the previous
sizes with the invalid config.
Without this patch, v4l2-compliance ends up allocating 4GiB of RAM and
causing the following OOPs
[   38.662975] ipu3-imgu 0000:00:05.0: swiotlb buffer is full (sz: 4096 bytes)
[   38.662980] DMA: Out of SW-IOMMU space for 4096 bytes at device 0000:00:05.0
[   38.663010] general protection fault: 0000 [#1] PREEMPT SMP

Introduced by commit 6d5f26f ("media: staging/intel-ipu3-v4l: reduce
kernel stack usage") in 5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [ad91849996f9dd79741a961fd03585a683b08356]
stable/5.10: [c6b81b897f6f9445d57f8d47c4e060ec21556137]
stable/5.4: [a03fb1e8a110658215a4cefc3e2ad53279e496a6]

CVE-2021-46944: media: staging/intel-ipu3: Fix memory leak in imu_fmt

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-9-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
media: staging/intel-ipu3: Fix memory leak in imu_fmt We are losing
the reference to an allocated memory if try. Change the order of the
check to avoid that.

Introduced-by commit 6d5f26f ("media: staging/intel-ipu3-v4l: reduce
kernel stack usage") in 5.2-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [3630901933afba1d16c462b04d569b7576339223]
stable/5.10: [517f6f570566a863c2422b843c8b7d099474f6a9]
stable/5.4: [ff792ae52005c85a2d829c153e08d99a356e007d]

CVE-2021-46945: ext4: always panic when errors=panic is specified

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-10-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ext4: always panic when errors=panic is specified Before commit
014c9caa29d3
("ext4: make ext4_abort() use __ext4_error()"), the following series
of commands would trigger a panic: 1. mount /dev/sda -o
ro,errors=panic
test 2. mount /dev/sda -o remount,abort test After commit
014c9caa29d3, remounting a file system using the test mount option
"abort" will no
longer trigger a panic. This commit will restore the behaviour
immediately before commit 014c9caa29d3. (However, note that the Linux
kernel's
behavior has not been consistent; some previous kernel versions,
including 5.4 and 4.19 similarly did not panic after using the mount
option "abort".)
This also makes a change to long-standing behaviour; namely, the
following series commands will now cause a panic, when previously it
did not:
1. mount /dev/sda -o ro,errors=panic test
2. echo test > /sys/fs/ext4/sda/trigger_fs_error
However, this makes ext4's behaviour much more consistent, so this is
a good thing.

Introduced by commit 014c9ca ("ext4: make ext4_abort() use
__ext4_error()") in 5.11-rc1.
Thix commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [ac2f7ca51b0929461ea49918f27c11b680f28995]

CVE-2021-46946: ext4: fix check to prevent false positive report of
incorrect used inodes

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-11-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Commit <50122847007> ("ext4: fix check to prevent initializing
reserved inodes") check the block group zero and prevent initializing
reserved
inodes. But in some special cases, the reserved inode may not all
belong to the group zero, it may exist into the second group if we
format
filesystem below.
  mkfs.ext4 -b 4096 -g 8192 -N 1024 -I 4096 /dev/sda
So, it will end up triggering a false positive report of a corrupted
file system. This patch fix it by avoid check reserved inodes if no
free
inode blocks will be zeroed.

Introduced by commit 5012284 ("ext4: fix check to prevent initializing
reserved inodes") in 4.18-rc7.
This commit is backported to 4.4.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [539ba4ebc467260225898e67ea53cbb73308f894]
cip/4.4-rt: [539ba4ebc467260225898e67ea53cbb73308f894]
cip/4.4-st: [539ba4ebc467260225898e67ea53cbb73308f894]
cip/5.10: [098b257563b959f4ca6c1d82fde0ee727792cb19]
cip/5.10-rt: [098b257563b959f4ca6c1d82fde0ee727792cb19]
mainline: [a149d2a5cabbf6507a7832a1c4fd2593c55fd450]
stable/4.19: [7687f5aba0f50c7ff8040e506bae184e59c8e7b8]
stable/5.10: [098b257563b959f4ca6c1d82fde0ee727792cb19]
stable/5.4: [9c61387630a54e35b96a90608aafd369ffb86f39]

CVE-2021-46947: sfc: adjust efx->xdp_tx_queue_count with the real
number of initialized queues

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-12-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

efx->xdp_tx_queue_count is initially initialized to
num_possible_cpus() and is later used to allocate and traverse
efx->xdp_tx_queues lookup array. However,
we may end up not initializing all the array slots with real queues
during probing. This results, for example, in a NULL pointer
dereference, when running
"# ethtool -S <iface>".

Introduced by commit e26ca4b ("sfc: reduce the number of requested xdp
ev queues") in 5.12-rc1dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [99ba0ea616aabdc8e26259fd722503e012199a76]

CVE-2021-46948: sfc: farch: fix TX queue lookup in TX event handling

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-13-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

We're starting from a TXQ label, not a TXQ type, so
efx_channel_get_tx_queue() is inappropriate (and could return NULL,
leading to panics).

Introduced by commit 1280479 ("sfc: decouple TXQ type from label") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [83b09a1807415608b387c7bc748d329fefc5617e]
stable/5.10: [bf2b941d0a6f2d3b9f5fa3c4c21bdd54f71ce253]

CVE-2021-46949: sfc: farch: fix TX queue lookup in TX flush done handling

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-14-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

We're starting from a TXQ instance number ('qid'), not a TXQ type, so
efx_get_tx_queue() is inappropriate (and could return NULL, leading to
panics).

Introduced by commit 1280479 ("sfc: decouple TXQ type from label") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [5b1faa92289b53cad654123ed2bc8e10f6ddd4ac]
stable/5.10: [fb791572d6747ef385f628450f8d57cd132e6e5a]

CVE-2021-46950: md/raid1: properly indicate failure when ending a
failed write request

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-15-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This patch addresses a data corruption bug in raid1 arrays using
bitmaps. Without this fix, the bitmap bits for the failed I/O end up
being cleared.
Since we are in the failure leg of raid1_end_write_request, the
request either needs to be retried (R1BIO_WriteError) or failed
(R1BIO_Degraded).

Introduced by commit eeba680 ("md/raid1: end bio when the device
faulty") in 5.4-rc1.
This commit is backported to 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [2417b9869b81882ab90fd5ed1081a1cb2d4db1dd]
stable/4.19: [a6e17cab00fc5bf85472434c52ac751426257c6f]
stable/5.10: [661061a45e32d8b2cc0e306da9f169ad44011382]
stable/5.4: [6920cef604fa57f9409e3960413e9cc11f5c5a40]

CVE-2021-46951: tpm: efi: Use local variable for calculating final log size

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-16-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When tpm_read_log_efi is called multiple times, which happens when one
loads and unloads a TPM2 driver multiple times, then the global
variable efi_tpm_final_log_size will at some point become a negative
number due to the subtraction of final_events_preboot_size occurring
each time. Use a local variable to avoid this integer underflow.

Introduced by commit 166a280 ("tpm: Don't duplicate events from the
final event log in the TCG2 log") in 5.3-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [48cff270b037022e37835d93361646205ca25101]
stable/5.10: [60a01ecc9f68067e4314a0b55148e39e5d58a51b]
stable/5.4: [2f12258b5224cfaa808c54fd29345f3c1cbfca76]

CVE-2021-46952: NFS: fs_context: validate UDP retrans to prevent shift
out-of-bounds

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-17-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Fix shift out-of-bounds in xprt_calc_majortimeo(). This is caused by a
garbage timeout (retrans) mount option being passed to nfs mount,
in this case from syzkaller.
If the protocol is XPRT_TRANSPORT_UDP, then 'retrans' is a shift value
for a 64-bit long integer, so 'retrans' cannot be >= 64.
If it is >= 64, fail the mount and return an error.

Introduced by commit 9954bf9 ("NFS: Move mount parameterisation bits
into their own file") in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [c09f11ef35955785f92369e25819bf0629df2e59]
stable/5.10: [96fa26b74cdcf9f5c98996bf36bec9fb5b19ffe2]

CVE-2021-46953: ACPI: GTDT: Don't corrupt interrupt mappings on
watchdow probe failure

Announce: https://lore.kernel.org/linux-cve-announce/20240227184057.2368370-18-gregkh@linuxfoundation.org/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
When failing the driver probe because of invalid firmware properties,
the GTDT driver unmaps the interrupt that it mapped earlier. However,
it never checks whether the mapping of the interrupt actially
succeeded. Even more, should the firmware report an illegal interrupt
number
that overlaps with the GIC SGI range, this can result in an IPI being
unmapped, and subsequent fireworks (as reported by Dann Frazier).
Rework the driver to have a slightly saner behaviour and actually
check whether the interrupt has been mapped before unmapping things.

Introduced by commit ca9ae5e ("acpi/arm64: Add SBSA Generic Watchdog
support in GTDT driver") in 4.12-rc1.
This commit is not backported to 4.4.
Fixed in 5.13-rc1.

Fixed status
mainline: [1ecd5b129252249b9bc03d7645a7bda512747277]
stable/4.19: [7b2162db1498c71962a4bb2f776fa4e76d4d305b]
stable/5.10: [e0f2d86481eaa83df33b0793f75212919db7a19d]
stable/5.4: [504632a3577a049dd9bb7aabae5b4476f9c586b4]

CVE-2021-46954: net/sched: sch_frag: fix stack OOB read while
fragmenting IPv4 packets

Announce: https://lore.kernel.org/linux-cve-announce/2024022715-CVE-2021-46954-b856@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A stack-out-of-bounds error in the Linux kernel's handling of IPv4
packet fragmentation, specifically when act_mirred attempts to
fragment
packets that have been reassembled using act_ct.

Introduced by commit c129412 ("net/sched: sch_frag: add generic packet
fragment support.") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [31fe34a0118e0acc958c802e830ad5d37ef6b1d3]

CVE-2021-46955: openvswitch: fix stack OOB read while fragmenting IPv4 packets

Announce: https://lore.kernel.org/linux-cve-announce/2024022718-CVE-2021-46955-b50b@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When running Open vSwitch on kernels built with KASAN, testing IPv4
packet fragmentation reveals a stack-out-of-bounds bug in
ip_do_fragment.

Introduced by commit d52e5a7 ("ipv4: lock mtu in fnhe when received
PMTU < net.ipv4.route.min_pmt") in 4.16-rc7.
This commit is backported 4.4.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [b1d7280f9ba1bfdbc3af5bdb82e51f014854f26f]
cip/4.4-rt: [b1d7280f9ba1bfdbc3af5bdb82e51f014854f26f]
cip/4.4-st: [b1d7280f9ba1bfdbc3af5bdb82e51f014854f26f]
mainline: [7c0ea5930c1c211931819d83cfb157bff1539a4c]
stable/4.19: [df9e900de24637be41879e2c50afb713ec4e8b2e]
stable/5.10: [a1478374b0bda89b4277a8afd39208271faad4be]
stable/5.4: [490ad0a2390442d0a7b8c00972a83dbb09cab142]

CVE-2021-46956: virtiofs: fix memory leak in virtio_fs_probe()

Announce: https://lore.kernel.org/linux-cve-announce/2024022718-CVE-2021-46956-df60@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

When accidentally passing twice the same tag to qemu, kmemleak ended
up reporting a memory leak in virtiofs.

Introduced by commit a62a8ef ("virtio-fs: add virtiofs filesystem") in 5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [c79c5e0178922a9e092ec8fed026750f39dcaef4]
stable/5.10: [d19555ff225d0896a33246a49279e6d578095f15]
stable/5.4: [310efc95c72c13faf855c692d19cd4d054d827c8]

CVE-2021-46957: riscv/kprobe: fix kernel panic when invoking sys_read
traced by kprobe

Announce: https://lore.kernel.org/linux-cve-announce/2024022718-CVE-2021-46957-90af@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Installing a kprobe at the entry of sys_read in kernels built with
KASAN can trigger a BUG_ON()
in __find_get_block, leading to a kernel bug report when testing IPv4
packet fragmentation.

Introduced by commit c22b0bc ("riscv: Add kprobes supported") in
5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [b1ebaa0e1318494a7637099a26add50509e37964]

CVE-2021-46958: btrfs: fix race between transaction aborts and fsyncs
leading to use-after-free

Announce: https://lore.kernel.org/linux-cve-announce/2024022718-CVE-2021-46958-53ff@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

There is a race between a task aborting a transaction during a commit,
a task doing an fsync and the transaction kthread, which leads to an
use-after-free of the log root tree.

Introduced by commit ef67963 ("btrfs: drop logs when we've aborted a
transaction") in 5.7-rc4.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [061dde8245356d8864d29e25207aa4daa0be4d3c]
stable/5.10: [a4794be7b00b7eda4b45fffd283ab7d76df7e5d6]

CVE-2021-46960: cifs: Return correct error code from smb2_get_enc_key

Announce: https://lore.kernel.org/linux-cve-announce/2024022718-CVE-2021-46960-f5ac@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Avoid a warning if the error percolates back up

Introduced by commit 61cfac6 ("CIFS: Fix possible use after free in
demultiplex thread") in 4.11-rc1.
This commit is not backported to 4.4.
Fixed in 5.13-rc1.

Fixed status
mainline: [83728cbf366e334301091d5b808add468ab46b27]
stable/4.19: [e486f8397f3f14a7cadc166138141fdb14379a54]
stable/5.10: [aaa0faa5c28a91c362352d6b35dc3ed10df56fb0]
stable/5.4: [93f3339b22ba17e66f0808737467b70ba087eaec]

CVE-2021-46961: irqchip/gic-v3: Do not enable irqs when handling
spurious interrups

Announce: https://lore.kernel.org/linux-cve-announce/2024022719-CVE-2021-46961-6212@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Running a 4.19 kernel with backported pseudo-NMI patches, a BUG_ON()
error was triggered due to spurious interrupts causing nested
Non-Maskable Interrupts (NMIs), which are unmanageable.

Introduced by commit 3f1f323 ("irqchip/gic-v3: Switch to PMR masking
before calling IRQ handler") in 5.1-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [a97709f563a078e259bf0861cd259aa60332890a]
stable/5.10: [7be4db5c2b59fa77071c93ca4329876fb9777202]
stable/5.4: [e7ea8e46e3b777be26aa855fe07778c415f24926]

CVE-2021-46962: mmc: uniphier-sd: Fix a resource leak in the remove function

Announce: https://lore.kernel.org/linux-cve-announce/2024022719-CVE-2021-46962-e081@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
mmc: uniphier-sd: Fix a resource leak in the remove function A
'tmio_mmc_host_free()'
call is missing in the remove function, in order to balance a
'tmio_mmc_host_alloc()' call in the probe. This is done in the error
handling path of
the probe, but not in the remove function. Add the missing call.

Introduced by commit 3fd784f ("mmc: uniphier-sd: add UniPhier SD/eMMC
controller driver") in 4.20-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [e29c84857e2d51aa017ce04284b962742fb97d9e]
stable/5.10: [25ac6ce65f1ab458982d15ec1caf441acd37106a]
stable/5.4: [0d8941b9b2d3e7b3481fdf43b1a6189d162175b7]

CVE-2021-46963: scsi: qla2xxx: Fix crash in qla2xxx_mqueuecommand()

Announce: https://lore.kernel.org/linux-cve-announce/2024022719-CVE-2021-46963-32a8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Fix incorrect call to free srb in qla2xxx_mqueuecommand(), as srb is
now allocated by upper layers. This fixes smatch warning of srb
unintended free.

Introduced by commit af2a0c5 ("scsi: qla2xxx: Fix SRB leak on switch
command timeout") in 5.5-rc1.
This commit is backported to 4.19 and 5.4. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [6641df81ab799f28a5d564f860233dd26cca0d93]
stable/4.19: [c5ab9b67d8b061de74e2ca51bf787ee599bd7f89]
stable/5.10: [702cdaa2c6283c135ef16d52e0e4e3c1005aa538]
stable/5.4: [77509a238547863040a42d57c72403f7d4c89a8f]

CVE-2021-46964: scsi: qla2xxx: Reserve extra IRQ vectors

Announce: https://lore.kernel.org/linux-cve-announce/2024022719-CVE-2021-46964-da8c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

The commit a6dcfe0 to the qla2xxx SCSI driver limits MSI-X vector
allocation to the CPU count, disrupting assumptions in several
functions and
setting max_qpairs to zero for two CPUs in initiator mode. This
results in ha->queue_pair_map being NULL, causing a crash in
qla2xxx_queuecommand() due to a NULL pointer dereference when the
driver attempts to access queue pairs that it believes are available.

Introduced by commit a6dcfe0 ("scsi: qla2xxx: Limit interrupt vectors
to number of CPUs") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [f02d4086a8f36a0e1aaebf559b54cf24a177a486]

CVE-2021-46965: mtd: physmap: physmap-bt1-rom: Fix unintentional stack access

Announce: https://lore.kernel.org/linux-cve-announce/2024022719-CVE-2021-46965-3b74@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
mtd: physmap: physmap-bt1-rom: Fix unintentional stack access Cast
&data
to (char *) in order to avoid unintentionally accessing the stack.
Notice that data is of type u32, so any increment to &data will be in
the order of 4-byte chunks, and this piece of code is actually
intended to be a byte offset. Addresses-Coverity-ID: 1497765
("Out-of-bounds access")

Introduced by commit b3e79e7 ("mtd: physmap: Add Baikal-T1 physically
mapped ROM support") in 5.10-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [683313993dbe1651c7aa00bb42a041d70e914925]
stable/5.10: [34ec706bf0b7c4ca249a729c1bcb91f706c7a7be]

CVE-2021-46966: ACPI: custom_method: fix potential use-after-free issue

In the Linux kernel, the following vulnerability has been resolved:
ACPI: custom_method: fix potential use-after-free issue In cm_write(),
buf is always freed when reaching the end of the function. If the
requested count is less than table.length, the allocated buffer will
be
freed but subsequent calls to cm_write() will still try to access it.
Remove the unconditional kfree(buf) at the end of the function and set
the buf to NULL in the -EINVAL error path to match the rest of function.

Introduced by commit 03d1571 ("ACPI: custom_method: fix memory leaks")
in 5.4-rc1.
This commit is backported to 4.19 and 4.4.
Fixed in 5.13-rc1.

Fixed status
cip/4.4: [1d53ca5d131074c925ce38361fb0376d3bf7e394]
cip/4.4-rt: [1d53ca5d131074c925ce38361fb0376d3bf7e394]
cip/4.4-st: [1d53ca5d131074c925ce38361fb0376d3bf7e394]
mainline: [e483bb9a991bdae29a0caa4b3a6d002c968f94aa]
stable/4.19: [a5b26a2e362f572d87e9fd35435680e557052a17]
stable/5.10: [62dc2440ebb552aa0d7f635e1697e077d9d21203]
stable/5.4: [72814a94c38a33239793f7622cec6ace1e540c4b]

CVE-2021-46967: vhost-vdpa: fix vm_flags for virtqueue doorbell mapping

Announce: https://lore.kernel.org/linux-cve-announce/2024022720-CVE-2021-46967-c991@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
vhost-vdpa: fix vm_flags for virtqueue doorbell mapping
The virtqueue doorbell is usually implemented via registeres but we
don't provide the necessary vma->flags like VM_PFNMAP. This may
cause several issues e.g when userspace tries to map the doorbell via
vhost IOTLB, kernel may panic due to the page is not backed
by page structure. This patch fixes this by setting the necessary
vm_flags. With this patch, try to map doorbell via IOTLB will
fail with bad address.

Introduced by commit ddd89d0 ("vhost_vdpa: support doorbell mapping
via mmap") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [3a3e0fad16d40a2aa68ddf7eea4acdf48b22dd44]
stable/5.10: [3b8b6399666a29daa30b0bb3f5c9e3fc81c5a6a6]

CVE-2021-46968: s390/zcrypt: fix zcard and zqueue hot-unplug memleak

Announce: https://lore.kernel.org/linux-cve-announce/2024022720-CVE-2021-46968-8c71@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Tests with kvm and a kmemdebug kernel showed, that on hot unplug the
zcard and zqueue structs for the unplugged card or queue are not
properly freed because of a mismatch with get/put for the embedded kref counter.
This fix now adjusts the handling of the kref counters. With init the
kref counter starts with 1. This initial value needs to drop to zero
with the unregister of the card or queue to trigger the release and
free the object.

Introduced by commit 29c2680 ("s390/ap: fix ap devices reference
counting") in 5.10-rc3.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [70fac8088cfad9f3b379c9082832b4d7532c16c2]
stable/5.10: [026499a9c2e002e621ad568d1378324ae97e5524]

CVE-2021-46970: bus: mhi: pci_generic: Remove WQ_MEM_RECLAIM flag from
state workqueue

Announce: https://lore.kernel.org/linux-cve-announce/2024022720-CVE-2021-46970-de08@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A recent change created a dedicated workqueue for the state-change
work with WQ_HIGHPRI (no strong reason for that) and WQ_MEM_RECLAIM
flags,
but the state-change work (mhi_pm_st_worker) does not guarantee
forward progress under memory pressure, and will even wait on various
memory
allocations when e.g. creating devices, loading firmware, etc... The
work is then not part of a memory reclaim path...
Moreover, this causes a warning in check_flush_dependency() since we
end up in code that flushes a non-reclaim workqueue:

Introduced by commit 8f70397 ("bus: mhi: core: Move to using high
priority workqueue") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [0fccbf0a3b690b162f53b13ed8bc442ea33437dc]

CVE-2021-46971: perf/core: Fix unconditional security_locked_down() call

Announce: https://lore.kernel.org/linux-cve-announce/2024022721-CVE-2021-46971-9534@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
perf/core: Fix unconditional security_locked_down() call Currently,
the lockdown state is queried unconditionally, even though its result
is used only if the PERF_SAMPLE_REGS_INTR bit is set in
attr.sample_type.
While that doesn't matter in case of the Lockdown LSM, it causes
trouble with the SELinux's lockdown hook implementation. SELinux
implements
the locked_down hook with a check whether the current task's type has
the corresponding "lockdown" class permission ("integrity" or
"confidentiality")
allowed in the policy. This means that calling the hook when the
access control decision would be ignored generates a bogus permission
check and audit
 record. Fix this by checking sample_type first and only calling the
hook when its result would be honored.

Introduced by commit b0c8fdc ("lockdown: Lock down perf when in
confidentiality mode") in 5.4-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [08ef1af4de5fe7de9c6d69f1e22e51b66e385d9b]
stable/5.10: [4348d3b5027bc3ff6336368b6c60605d4ef8e1ce]
stable/5.4: [b246759284d6a2bc5b6f1009caeeb3abce2ec9ff]

CVE-2021-46974: bpf: Fix masking negation logic upon negative dst register

Announce: https://lore.kernel.org/linux-cve-announce/2024022721-CVE-2021-46974-0852@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
bpf: Fix masking negation logic upon negative dst register The
negation
logic for the case where the off_reg is sitting in the dst register is
not correct given then we cannot just invert the add to a sub or vice
versa. As a fix, perform the final bitwise and-op unconditionally into
AX from the off_reg, then move the pointer from the src to dst and
finally use AX as the source for the original pointer arithmetic
operation such that the inversion yields a correct result. The single
non-AX mov in between is possible given constant blinding is retaining
it as it's not an immediate based operation.

Introduced by commit 979d63d ("bpf: prevent out of bounds speculation
on pointer arithmetic") in 5.0-rc1.
This commit is backported to 4.19. Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [b9b34ddbe2076ade359cd5ce7537d5ed019e9807]
stable/4.19: [0e2dfdc74a7f4036127356d42ea59388f153f42c]
stable/5.10: [2cfa537674cd1051a3b8111536d77d0558f33d5d]
stable/5.4: [53e0db429b37a32b8fc706d0d90eb4583ad13848]

CVE-2021-46975: netfilter: conntrack: Make global sysctls readonly in
non-init netns

Announce: https://lore.kernel.org/linux-cve-announce/2024022721-CVE-2021-46975-248d@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
netfilter: conntrack: Make global sysctls readonly in non-init netns
These sysctls point to global variables: - NF_SYSCTL_CT_MAX
(&nf_conntrack_max) - NF_SYSCTL_CT_EXPECT_MAX (&nf_ct_expect_max) -
NF_SYSCTL_CT_BUCKETS (&nf_conntrack_htable_size_user) Because their
data pointers are not updated to point to per-netns structures,
they must be marked read-only in a non-init_net ns. Otherwise, changes
in any net namespace are reflected in (leaked into) all other net
namespaces. This problem has existed since the introduction of net
namespaces. The current logic marks them read-only only if the net
namespace
is owned by an unprivileged user (other than init_user_ns). Commit
d0febd81ae77 ("netfilter: conntrack: re-visit sysctls in unprivileged
namespaces") "exposes all sysctls even if the namespace is
unpriviliged." Since we need to mark them readonly in any case, we can
forego the
unprivileged user check altogether.

Introduced by commit d0febd8 ("netfilter: conntrack: re-visit sysctls
in unprivileged namespaces") in 5.7-rc1.
Linux 4.4 is not affected.
Fixed in 5.13-rc1.

Fixed status
mainline: [2671fa4dc0109d3fb581bc3078fdf17b5d9080f6]
stable/4.19: [9b288479f7a901a14ce703938596438559d7df55]
stable/5.10: [d3598eb3915cc0c0d8cab42f4a6258ff44c4033e]
stable/5.4: [baea536cf51f8180ab993e374cb134b5edad25e2]

CVE-2021-46907: KVM: VMX: Don't use vcpu->run->internal.ndata as an array index

Announce: https://lore.kernel.org/linux-cve-announce/2024022703-CVE-2021-46907-85de@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
KVM: VMX: Don't use vcpu->run->internal.ndata as an array index
__vmx_handle_exit() uses vcpu->run->internal.ndata as an index for an
array access. Since vcpu->run is (can be) mapped to a user address
space with a writer permission, the 'ndata' could be updated by the
user process at anytime (the user process can set it to outside the
bounds of the array). So, it is not safe that __vmx_handle_exit() uses
the 'ndata' that way.

Introcued by commit 1aa561b ("kvm: x86: Add "last CPU" to some
KVM_EXIT information") in 5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [04c4f2ee3f68c9a4bf1653d15f1a9a435ae33f7a]
stable/5.10: [7f64753835a78c7d2cc2932a5808ef3b7fd4c050]

CVE-2021-46908: bpf: Use correct permission flag for mixed signed
bounds arithmetic

Announce: https://lore.kernel.org/linux-cve-announce/2024022706-CVE-2021-46908-5030@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

We forbid adding unknown scalars with mixed signed bounds due to the
spectre v1 masking mitigation. Hence this also needs bypass_spec_v1
flag instead of allow_ptr_leaks.

Introduced by commit 2c78ee8 ("bpf: Implement CAP_BPF") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [9601148392520e2e134936e76788fc2a6371e7be]
stable/5.10: [4f3ff11204eac0ee23acf64deecb3bad7b0db0c6]

CVE-2021-46909: ARM: footbridge: fix PCI interrupt mapping

Announce: https://lore.kernel.org/linux-cve-announce/2024022707-CVE-2021-46909-8fb6@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ARM: footbridge: fix PCI interrupt mapping Since commit
30fdfb929e82 ("PCI: Add a call to pci_assign_irq() in
pci_device_probe()"), the PCI code will call the IRQ mapping function
whenever
a PCI driver is probed. If these are marked as __init, this causes an
oops if a PCI driver is loaded or bound after the kernel has
initialised.

Introduced by commit 30fdfb9 ("PCI: Add a call to pci_assign_irq() in
pci_device_probe()") in 4.13-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [30e3b4f256b4e366a61658c294f6a21b8626dda7]
stable/4.19: [2643da6aa57920d9159a1a579fb04f89a2b0d29a]
stable/5.10: [1fc087fdb98d556b416c82ed6e3964a30885f47a]
stable/5.4: [871b569a3e67f570df9f5ba195444dc7c621293b]

CVE-2021-46911: ch_ktls: Fix kernel panic

Announce: https://lore.kernel.org/linux-cve-announce/2024022708-CVE-2021-46911-2a14@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
ch_ktls: Fix kernel panic Taking page refcount is not ideal and causes
 kernel panic sometimes. It's better to take tx_ctx lock for the
complete skb transmit, to avoid page cleanup if ACK received in
middle.

Introduced by commit 5a4b9fe ("cxgb4/chcr: complete record tx
handling") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

mainline: [1a73e427b824133940c2dd95ebe26b6dce1cbf10]
stable/5.10: [8d5a9dbd2116a852f8f0f91f6fbc42a0afe1091f]

CVE-2021-46912: net: Make tcp_allowed_congestion_control readonly in
non-init netns

Announce: https://lore.kernel.org/linux-cve-announce/2024022708-CVE-2021-46912-d07b@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
net: Make tcp_allowed_congestion_control readonly in non-init netns
Currently,
tcp_allowed_congestion_control is global and writable; writing to it
in any net namespace will leak into all other net namespaces.
tcp_available_congestion_control and tcp_allowed_congestion_control
are the only sysctls in ipv4_net_table (the per-netns sysctl table)
with
a NULL data pointer; their handlers
(proc_tcp_available_congestion_control and
proc_allowed_congestion_control) have no other way of referencing
a struct net. Thus, they operate globally. Because ipv4_net_table does
not use designated initializers, there is no easy way to fix up this
one
"bad" table entry. However, the data pointer updating logic shouldn't
be applied to NULL pointers anyway, so we instead force these entries
to be
read-only. These sysctls used to exist in ipv4_table (init-net only),
but they were moved to the per-net ipv4_net_table, presumably without
realizing that tcp_allowed_congestion_control was writable and thus
introduced a leak. Because the intent of that commit was only to know
(i.e. read)
"which congestion algorithms are available or allowed", this read-only
solution should be sufficient. The logic added in recent commit
31c4d2f160eb: ("net: Ensure net namespace isolation of sysctls") does
not and cannot check for NULL data pointers, because other table
entries (e.g. /proc/sys/net/netfilter/nf_log/) have .data=NULL but use
other methods (.extra2) to access the struct net.

Introduced by commit 31c4d2f: ("net: Ensure net namespace isolation of
sysctls") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [97684f0970f6e112926de631fdd98d9693c7e5c1]
stable/5.10: [35d7491e2f77ce480097cabcaf93ed409e916e12]

CVE-2021-46910: ARM: 9063/1: mm: reduce maximum number of CPUs if
DEBUG_KMAP_LOCAL is enabled

Announce: https://lore.kernel.org/linux-cve-announce/2024022707-CVE-2021-46910-ba92@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

The debugging code for kmap_local() doubles the number of per-CPU
fixmap slots allocated for kmap_local(), in order to use half of them
as guard
regions. This causes the fixmap region to grow downwards beyond the
start of its reserved window if the supported number of CPUs is large,
and collide
with the newly added virtual DT mapping right below it, which is
obviously not good.

Introduced by commit 2a15ba8 ("ARM: highmem: Switch to generic kmap
atomic") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [d624833f5984d484c5e3196f34b926f9e71dafee]

CVE-2021-46914: ixgbe: fix unbalanced device enable/disable in suspend/resume

Announce: ixgbe: fix unbalanced device enable/disable in suspend/resume
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

pci_disable_device() called in __ixgbe_shutdown() decreases
dev->enable_cnt by 1. pci_enable_device_mem() which increases
dev->enable_cnt by 1, was removed from ixgbe_resume() in commit
6f82b2558735 ("ixgbe: use generic power management"). This caused
unbalanced increase/decrease. So add pci_enable_device_mem() back.

Introdcued by commit 6f82b25 ("ixgbe: use generic power management") in 5.9-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [debb9df311582c83fe369baa35fa4b92e8a9c58a]
stable/5.10: [be07581aacae7cd0a073afae8e8862032f794309]

CVE-2021-46915: netfilter: nft_limit: avoid possible divide error in
nft_limit_init

Announce: https://lore.kernel.org/linux-cve-announce/2024022709-CVE-2021-46915-7ded@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

nft_limit_init() wants to divide u64 by u64, use the appropriate math
function (div64_u64).

Introduced by commit c26844e ("netfilter: nf_tables: Fix nft limit
burst handling") in 4.13 and
3e0f64b ("netfilter: nft_limit: fix packet ratelimiting") in 4.17.
Linux 4.4 is not affected.
Fixed in 5.12-rc8.

Fixed status
mainline: [b895bdf5d643b6feb7c60856326dd4feb6981560]
stable/4.19: [fadd3c4afdf3d4c21f4d138502f8b76334987e26]
stable/5.10: [dc1732baa9da5b68621586bf8636ebbc27dc62d2]
stable/5.4: [01fb1626b620cb37a65ad08e0f626489e8f042ef]

CVE-2021-46913: netfilter: nftables: clone set element expression template

Announce: https://lore.kernel.org/linux-cve-announce/2024022708-CVE-2021-46913-eeef@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

memcpy() breaks when using connlimit in set elements. Use
nft_expr_clone() to initialize the connlimit expression list,
otherwise
connlimit garbage collector crashes when walking on the list head copy.

Introduced by commit 4094445 ("netfilter: nf_tables: add elements with
stateful expressions") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [4d8f9065830e526c83199186c5f56a6514f457d2]
stable/5.10: [e51ff3ffc316377cca21de8b80404eed0c37b3c3]

CVE-2021-46917: dmaengine: idxd: fix wq cleanup of WQCFG registers

Announce: https://lore.kernel.org/linux-cve-announce/2024022710-CVE-2021-46917-99a4@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A pre-release silicon erratum workaround where wq reset does not clear
WQCFG registers was leaked into upstream code. Use wq reset command
instead of blasting the MMIO region. This also address an issue where
we clobber registers in future devices.

Introduced by commit da32b28 ("dmaengine: idxd: cleanup workqueue
config after disabling") in 5.8-rc6.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [ea9aadc06a9f10ad20a90edc0a484f1147d88a7a]
stable/5.10: [e5eb9757fe4c2392e069246ae78badc573af1833]

CVE-2021-46918: dmaengine: idxd: clear MSIX permission entry on shutdown

Announce: https://lore.kernel.org/linux-cve-announce/2024022710-CVE-2021-46918-1dd0@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Add disabling/clearing of MSIX permission entries on device shutdown
to mirror the enabling of the MSIX entries on probe. Current code left
the
MSIX enabled and the pasid entries still programmed at device shutdown.

Introduced by commit 8e50d39 ("dmaengine: idxd: Add shared workqueue
support") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [6df0e6c57dfc064af330071f372f11aa8c584997]

CVE-2021-46916: ixgbe: Fix NULL pointer dereference in ethtool loopback test

Announce: https://lore.kernel.org/linux-cve-announce/2024022709-CVE-2021-46916-9f19@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

The ixgbe driver currently generates a NULL pointer dereference when
performing the ethtool loopback test. This is due to the fact that
there
isn't a q_vector associated with the test ring when it is setup as
interrupts are not normally added to the test rings.
To address this I have added code that will check for a q_vector
before returning a napi_id value. If a q_vector is not present it will
return a
value of 0.

Introduced by commit b02e5a0 ("xsk: Propagate napi_id to XDP socket Rx
path") in 5.11-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [31166efb1cee348eb6314e9c0095d84cbeb66b9d]

CVE-2021-46920: dmaengine: idxd: Fix clobbering of SWERR overflow bit
on writeback

Announce: https://lore.kernel.org/linux-cve-announce/2024022711-CVE-2021-46920-062e@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Current code blindly writes over the SWERR and the OVERFLOW bits.
Write back the bits actually read instead so the driver avoids
clobbering the
OVERFLOW bit that comes after the register is read.

Introduced by commit bfe1d56 ("dmaengine: idxd: Init and probe for
Intel data accelerators") in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [ea941ac294d75d0ace50797aebf0056f6f8f7a7f]
stable/5.10: [a5ad12d5d69c63af289a37f05187a0c6fe93553d]

CVE-2021-46919: dmaengine: idxd: fix wq size store permission state

Announce: https://lore.kernel.org/linux-cve-announce/2024022710-CVE-2021-46919-950c@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

WQ size can only be changed when the device is disabled. Current code
allows change when device is enabled but wq is disabled. Change the
check
to detect device state.

Introduced by commit c52ca47 ("dmaengine: idxd: add configuration
component of driver") in 5.6-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.12-rc8.

Fixed status
mainline: [0fff71c5a311e1264988179f7dcc217fda15fadd]
stable/5.10: [4ecf25595273203010bc8318c4aee60ad64037ae]

CVE-2021-46921: dmaengine: idxd: add configuration component of driver

Announce: https://lore.kernel.org/linux-cve-announce/2024022732-CVE-2021-46921-91dc@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A concurrency issue in epoll was identified where a writer, while
holding the wait_lock, checks a value using atomic_cond_read_acquire()
but only acquires the lock upon a successful compare-and-exchange
(cmpxchg) operation, which isn't ordered. This creates a vulnerability
to an A-B-A problem, allowing readers to observe speculative values
before the write lock is fully secured.

Introduced by commit b519b56 ("locking/qrwlock: Use
atomic_cond_read_acquire() when spinning in qrwlock") in 4.15-rc1.
Linux 4.4 is not affected.
Fixed in 5.12.

Fixed status
mainline: [84a24bf8c52e66b7ac89ada5e3cfbe72d65c1896]
stable/4.19: [5902f9453a313be8fe78cbd7e7ca9dba9319fc6e]
stable/5.10: [82fa9ced35d88581cffa4a1c856fc41fca96d80a]
stable/5.4: [82808cc026811fbc3ecf0c0b267a12a339eead56]

CVE-2021-46922: KEYS: trusted: Fix TPM reservation for seal/unseal

Announce: https://lore.kernel.org/linux-cve-announce/2024022736-CVE-2021-46922-39b5@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This is backport issue. Backporting commit 67118bb ("KEYS: trusted:
Reserve TPM for seal and unseal operations") to 5.10 introduced this
issue.

Fixed status
stable/5.10: [bf84ef2dd2ccdcd8f2658476d34b51455f970ce4]

CVE-2021-46924: NFC: st21nfca: Fix memory leak in device probe and remove

Announce: https://lore.kernel.org/linux-cve-announce/2024022748-CVE-2021-46924-3483@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

'phy->pending_skb' is alloced when device probe, but forgot to free in
the error handling path and remove path, this cause memory leak.

Introduced by commit 6895730 ("NFC: ST21NFCA: Add driver for
STMicroelectronics ST21NFCA NFC Chip") in 3.16-rc1.
Fixed in 5.16-rc8.

Fixed status
mainline: [1b9dadba502234eea7244879b8d5d126bfaf9f0c]
stable/4.19: [a1e0080a35a16ce3808f7040fe0c3a8fdb052349]
stable/5.10: [e553265ea56482da5700f56319fda9ff53e7dcb4]
stable/5.15: [238920381b8925d070d32d73cd9ce52ab29896fe]
stable/5.4: [1cd4063dbc91cf7965d73a6a3855e2028cd4613b]

CVE-2021-46933: usb: gadget: f_fs: Clear ffs_eventfd in ffs_data_clear

Announce: https://lore.kernel.org/linux-cve-announce/2024022750-CVE-2021-46933-2103@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

ffs_data_clear is indirectly called from both ffs_fs_kill_sb and
ffs_ep0_release, so it ends up being called twice when userland closes
ep0
and then unmounts f_fs.  If userland provided an eventfd along with
function's USB descriptors, it
ends up calling eventfd_ctx_put as many times, causing a refcount underflow.
NULL-ify ffs_eventfd to prevent these extraneous eventfd_ctx_put
calls. Also, set epfiles to NULL right after de-allocating it, for
readability.
For completeness, ffs_data_clear actually ends up being called thrice,
the last call being before the whole ffs structure gets freed, so when
this
specific sequence happens there is a second underflow happening (but
not being reported):

Introduced by commit 5e33f6f ("usb: gadget: ffs: add eventfd
notification about ffs events") in 4.0-rc1.
Fixed in 5.16-rc8.

Fixed status
cip/4.4: [f976dd7011150244a7ba820f2c331e9fb253befa]
cip/4.4-rt: [f976dd7011150244a7ba820f2c331e9fb253befa]
cip/4.4-st: [f976dd7011150244a7ba820f2c331e9fb253befa]
mainline: [b1e0887379422975f237d43d8839b751a6bcf154]
stable/4.19: [33f6a0cbb7772146e1c11f38028fffbfed14728b]
stable/5.10: [1c4ace3e6b8575745c50dca9e76e0021e697d645]
stable/5.15: [ebef2aa29f370b5096c16020c104e393192ef684]
stable/5.4: [240fc586e83d645912accce081a48aa63a45f6ee]

CVE-2021-46934: i2c: validate user data in compat ioctl

Announce: https://lore.kernel.org/linux-cve-announce/2024022750-CVE-2021-46934-79c8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Wrong user data may cause warning in i2c_transfer(), ex: zero msgs.
Userspace should not be able to trigger warnings, so this patch adds
validation checks for user data in compact ioctl to prevent reported warnings

Introduced by commit 7d5cb45 ("i2c compat ioctls: move to
->compat_ioctl()") in 4.15-rc1.
Linux 4.4 is not affected.
Fixed in 5.16-rc8.

Fixed status
mainline: [bb436283e25aaf1533ce061605d23a9564447bdf]
stable/4.19: [407c8708fb1bf2d4afc5337ef50635cf540c364b]
stable/5.10: [8d31cbab4c295d7010ebb729e9d02d0e9cece18f]
stable/5.15: [f68599581067e8a5a8901ba9eb270b4519690e26]
stable/5.4: [9e4a3f47eff476097e0c7faac04d1831fc70237d]

CVE-2021-46935: binder: fix async_free_space accounting for empty parcels

Announce: https://lore.kernel.org/linux-cve-announce/2024022751-CVE-2021-46935-f8f4@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
binder: fix async_free_space accounting for empty parcels In 4.13,
commit 74310e06be4d ("android: binder: Move buffer out of area shared
with user space") fixed a kernel structure visibility issue.
As part of that patch, sizeof(void *) was used as the buffer size for
0-length data payloads so the driver could detect abusive clients
sending 0-length asynchronous transactions to a server by enforcing
limits on async_free_size. Unfortunately, on the "free" side,
the accounting of async_free_space did not add the sizeof(void *)
back. The result was that up to 8-bytes of async_free_space were
leaked on every async transaction of 8-bytes or less. These small
transactions are uncommon, so this accounting issue has gone
undetected
for several years. The fix is to use "buffer_size" (the allocated
buffer size) instead of "size" (the logical buffer size) when updating
the async_free_space during the free operation. These are the same
except for this corner case of asynchronous transactions with payloads
< 8 bytes.

Introduced by commit 74310e0 ("android: binder: Move buffer out of
area shared with user space") in 4.14-rc1.
Linux 4.4 is not affected.
Fixed in 5.16-rc8.

Fixed status
mainline: [cfd0d84ba28c18b531648c9d4a35ecca89ad9901]
stable/4.19: [7c7064402609aeb6fb11be1b4ec10673ff17b593]
stable/5.10: [1cb8444f3114f0bb2f6e3bcadcf09aa4a28425d4]
stable/5.15: [17691bada6b2f1d5f1c0f6d28cd9d0727023b0ff]
stable/5.4: [103b16a8c51f96d5fe063022869ea906c256e5da]

CVE-2021-46936: net: fix use-after-free in tw_timer_handler

Announce: https://lore.kernel.org/linux-cve-announce/2024022751-CVE-2021-46936-2f8a@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

A panic issue in Linux 5.4 related to a page fault in tw_timer_handler
was reported, persisting despite DCCP fixes. The problem originates
from ipv4_mib_exit_net being called before tcp_sk_exit_batch due to
the order of operations in the destruction of a net namespace,
leading to a use-after-free error. This issue, introduced by a change
that allocated net statistics to struct net, was fixed by adjusting
the initialization order of IPv4 MIBs relative to TCP and changing a
critical error reporting to a panic for failure in init_ipv4_mibs.

Introduced by commit 61a7e26 ("mib: put net statistics on struct net")
in 2.6.27-rc1.
Fixed in 5.16-rc8.

Fixed status
cip/4.4: [15579e1301f856ad9385d720c9267c11032a5022]
cip/4.4-rt: [15579e1301f856ad9385d720c9267c11032a5022]
cip/4.4-st: [15579e1301f856ad9385d720c9267c11032a5022]
mainline: [e22e45fc9e41bf9fcc1e92cfb78eb92786728ef0]
stable/4.19: [a8e1944b44f94f5c5f530e434c5eaee787254566]
stable/5.10: [2386e81a1d277f540e1285565c9d41d531bb69d4]
stable/5.15: [08eacbd141e2495d2fcdde84358a06c4f95cbb13]
stable/5.4: [fe5838c22b986c1190f1dce9aa09bf6a491c1a69]

CVE-2021-46937: mm/damon/dbgfs: fix 'struct pid' leaks in
'dbgfs_target_ids_write()'

Announce: https://lore.kernel.org/linux-cve-announce/2024022751-CVE-2021-46937-3ae8@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

DAMON debugfs interface increases the reference counts of 'struct
pid's for targets from the 'target_ids' file write callback
('dbgfs_target_ids_write()'), but decreases the counts only in DAMON
monitoring termination callback ('dbgfs_before_terminate()').
Therefore, when 'target_ids' file is repeatedly written without DAMON
monitoring start/termination, the reference count is not decreased and
therefore memory for the 'struct pid' cannot be freed.  This commit
fixes this issue by decreasing the reference counts when 'target_ids'
is
written.

Introduced by commit 4bc0595 ("mm/damon: implement a debugfs-based
user space interface") in 5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.16-rc8.

Fixed status
mainline: [ebb3f994dd92f8fb4d70c7541091216c1e10cb71]
stable/5.15: [ffe4a1ba1a82c416a6b3a09d46594f6a885ae141]

CVE-2021-46927: nitro_enclaves: Use get_user_pages_unlocked() call to
handle mmap assert

Announce: https://lore.kernel.org/linux-cve-announce/2024022749-CVE-2021-46927-ae70@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

After commit 5b78ed24e8ec ("mm/pagemap: add mmap_assert_locked()
annotations to find_vma*()"), the call to get_user_pages() will
trigger
the mmap assert.

Introduced by commit 5b78ed2 ("mm/pagemap: add mmap_assert_locked()
annotations to find_vma*()") in 5.15-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.16-rc8.

Fixed status
mainline: [3a0152b219523227c2a62a0a122cf99608287176]
stable/5.15: [90d2beed5e753805c5eab656b8d48257638fe543]

CVE-2021-46929: sctp: use call_rcu to free endpoint

Announce: https://lore.kernel.org/linux-cve-announce/2024022749-CVE-2021-46929-9369@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This patch is to delay the endpoint free by calling call_rcu() to fix
another use-after-free issue in sctp_sock_dump().

Introduced by commit d25adbe ("sctp: fix an use-after-free issue in
sctp_sock_dump") in 4.14-rc1.
Linux 4.4 is not affected.
Fixed in 5.16-rc8.

Fixed status
mainline: [5ec7d18d1813a5bead0b495045606c93873aecbb]
stable/4.19: [af6e6e58f7ebf86b4e7201694b1e4f3a62cbc3ec]
stable/5.10: [769d14abd35e0e153b5149c3e1e989a9d719e3ff]
stable/5.15: [75799e71df1da11394740b43ae5686646179561d]
stable/5.4: [831de271452b87657fcf8d715ee20519b79caef5]

CVE-2021-46930: usb: mtu3: fix list_head check warning

Announce: https://lore.kernel.org/linux-cve-announce/2024022749-CVE-2021-46930-99ca@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

This is caused by uninitialization of list_head.
BUG: KASAN: use-after-free in __list_del_entry_valid+0x34/0xe4

Introduced by commit 83374e0 ("usb: mtu3: add tracepoints to help
debug") in 5.2-rc1.
Linux 4.4 is not affected.
Fixed in 5.16-rc8.

Fixed status
mainline: [8c313e3bfd9adae8d5c4ba1cc696dcbc86fbf9bf]
stable/5.10: [3b6efe0b7ba03cc2acf0694b46d6ff33c5b4c295]
stable/5.15: [249ddfbe00570d6dc76208e88017937d4d374c79]
stable/5.4: [585e2b244dda7ea733274e4b8fa27853d625d3bf]

CVE-2021-46931: net/mlx5e: Wrap the tx reporter dump callback to extract the sq

Announce: https://lore.kernel.org/linux-cve-announce/2024022750-CVE-2021-46931-a468@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Function mlx5e_tx_reporter_dump_sq() casts its void * argument to
struct mlx5e_txqsq *, but in TX-timeout-recovery flow the argument is
actually
of type struct mlx5e_tx_timeout_ctx *.

Introduced by commit 5f29458 ("net/mlx5e: Support dump callback in TX
reporter") in 5.7-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.16-rc8.

Fixed status
mainline: [918fc3855a6507a200e9cf22c20be852c0982687]
stable/5.10: [73665165b64a8f3c5b3534009a69be55bb744f05]
stable/5.15: [07f13d58a8ecc3baf9a488588fb38c5cb0db484f]

CVE-2021-46932: Input: appletouch - initialize work before device registration

Announce: https://lore.kernel.org/linux-cve-announce/2024022750-CVE-2021-46932-3a36@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Syzbot has reported warning in __flush_work(). This warning is caused
by work->func == NULL, which means missing work initialization.
This may happen, since input_dev->close() calls
cancel_work_sync(&dev->work), but dev->work initalization happens
_after_
input_register_device() call.  So this patch moves dev->work
initialization before registering input device.

Introduced by commit 5a6eb67 ("Input: appletouch - improve powersaving
for Geyser3 devices") in 2.6.23-rc1.
Fixed in 5.16-rc8.

Fixed status
cip/4.4: [d2cb2bf39a6d17ef4bdc0e59c1a35cf5751ad8f4]
cip/4.4-rt: [d2cb2bf39a6d17ef4bdc0e59c1a35cf5751ad8f4]
cip/4.4-st: [d2cb2bf39a6d17ef4bdc0e59c1a35cf5751ad8f4]
mainline: [9f3ccdc3f6ef10084ceb3a47df0961bec6196fd0]
stable/4.19: [a02e1404e27855089d2b0a0acc4652c2ce65fe46]
stable/5.10: [9f329d0d6c91142cf0ad08d23c72dd195db2633c]
stable/5.15: [e79ff8c68acb1eddf709d3ac84716868f2a91012]
stable/5.4: [975774ea7528b489930b76a77ffc4d5379b95ff2]

CVE-2021-46923: fs/mount_setattr: always cleanup mount_kattr

Announce: https://lore.kernel.org/linux-cve-announce/2024022745-CVE-2021-46923-a1ec@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Make sure that finish_mount_kattr() is called after mount_kattr was
succesfully built in both the success and failure case to prevent
leaking any references we took when we built it.  We returned early if
path lookup failed thereby risking to leak an additional reference we
took when building mount_kattr when an idmapped mount was requested.

Introduced by commit 9caccd4 ("fs: introduce MOUNT_ATTR_IDMAP") in
5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.16-rc8.

Fixed status
mainline: [012e332286e2bb9f6ac77d195f17e74b2963d663]
stable/5.15: [47b5d0a7532d39e42a938f81e3904268145c341d]

CVE-2021-46969: bus: mhi: core: Fix invalid error returning in mhi_queue

Announce: https://lore.kernel.org/linux-cve-announce/2024022720-CVE-2021-46969-3263@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

In the Linux kernel, the following vulnerability has been resolved:
bus: mhi: core: Fix invalid error returning in mhi_queue mhi_queue
returns an error when the doorbell is not accessible in the current
state. This can happen when the device is in non M0 state, like M3,
and needs to be waken-up prior ringing the DB. This case is managed
earlier by triggering an asynchronous M3 exit via controller
resume/suspend
callbacks, that in turn will cause M0 transition and DB update. So,
since it's not an error but just delaying of doorbell update, there is
no
reason to return an error. This also fixes a use after free error for
skb case, indeed a caller queuing skb will try to free the skb if the
queueing fails, but in that case queueing has been done.

Introduced by commit a8f75cb ("mhi: core: Factorize mhi queuing") in
5.12-rc1-dontuse.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [0ecc1c70dcd32c0f081b173a1a5d89952686f271]

CVE-2021-46972: ovl: fix leaked dentry

Announce: https://lore.kernel.org/linux-cve-announce/2024022721-CVE-2021-46972-2ec2@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

Since commit 6815f479ca90 ("ovl: use only uppermetacopy state in
ovl_lookup()"), overlayfs doesn't put temporary dentry when there is a
metacopy error, which leads to dentry leaks when shutting down the
related superblock.

Introduced by commit 6815f47 ("ovl: use only uppermetacopy state in
ovl_lookup()") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [eaab1d45cdb4bb0c846bd23c3d666d5b90af7b41]
stable/5.10: [71d58457a8afc650da5d3292a7f7029317654d95]

CVE-2021-46973: net: qrtr: Avoid potential use after free in MHI send

Announce: https://lore.kernel.org/linux-cve-announce/2024022721-CVE-2021-46973-20ce@gregkh/T/#u
CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

It is possible that the MHI ul_callback will be invoked immediately
following the queueing of the skb for transmission, leading to the
callback decrementing the refcount of the associated sk and freeing the skb.
As such the dereference of skb and the increment of the sk refcount
must happen before the skb is queued, to avoid the skb to be used
after free
and potentially the sk to drop its last refcount..

Introduced by commit 6e728f3 ("net: qrtr: Add MHI transport layer") in 5.8-rc1.
This commit is not backported to older stable kernels.
Fixed in 5.13-rc1.

Fixed status
mainline: [47a017f33943278570c072bc71681809b2567b3a]
stable/5.10: [48ec949ac979b4b42d740f67b6177797af834f80]

* Updated CVEs

CVE-2019-12379: consolemap: Fix a memory leaking bug in
drivers/tty/vt/consolemap.c

Added mainline fixed commit. It was fixed in 5.3-rc1.

Fixed status
mainline: [84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac]

CVE-2019-12455: clk-sunxi: fix a missing-check bug in sunxi_divs_clk_setup()

Added mainline fixed commit. It was fixed in 5.3-rc1.

Fixed status
mainline: [fcdf445ff42f036d22178b49cf64e92d527c1330]

CVE-2021-3542: media: firewire: firedtv-avc: fix a buffer overflow in
avc_ca_pmt()

Add mainline, 4.19, 5.10, 5.15, and 5.4 fixed commit.

Fixed status
mainline: [35d2969ea3c7d32aee78066b1f3cf61a0d935a4e]
stable/4.19: [53ec9dab4eb0a8140fc85760fb50effb526fe219]
stable/5.10: [d7fc85f6104259541ec136199d3bf7c8a736613d]
stable/5.15: [cb667140875a3b1db92e4c50b4617a7cbf84659b]
stable/5.4: [2461f38384d50dd966e1db44fe165b1896f5df5a]

CVE-2022-3642: wifi: rtl8xxxu: Fix reads of uninitialized variables
hw_ctrl_s1, sw_ctrl_s1

Added mainline fixed commit. It was fixed in 6.2-rc1.

Fixed status
mainline: [80e5acb6dd72b25a6e6527443b9e9c1c3a7bcef6]

CVE-2021-33630: net/sched: cbs: Fix not adding cbs instance to list

4.19 was fixed.

Fixed status
mainline: [3e8b9bfa110896f95d602d8c98d5f9d67e41d78c]
stable/4.19: [bbd8e460c478adbc88e2ec4e2414931a59791348]

CVE-2023-52429: dm: limit the number of targets and parameter size area

stable 5.10, 5.15, 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]
stable/5.10: [a891a0621e725e85529985139cada8cb5a74a116]
stable/5.15: [888a0a46b80fa37eacfe81faf47ba0b83876251d]
stable/6.1: [c5d83ac2bf6ca668a39ffb1a576899a66153ba19]
stable/6.6: [438d19492b7f002334573bae43276297eb234c80]
stable/6.7: [cd70175481f63af31901dd463e44386f033c3f4c]

CVE-2023-52434: smb: client: fix potential OOBs in smb2_parse_contexts()

stable 6.1 was fixed.

Fixed status
mainline: [af1689a9b7701d9907dfc84d2a4b57c4bc907144]
stable/6.1: [1ae3c59355dc9882e09c020afe8ffbd895ad0f29]
stable/6.6: [17a0f64cc02d4972e21c733d9f21d1c512963afa]

CVE-2023-52435: net: prevent mss overflow in skb_segment()

stable 5.10, 5.15, 5.4, and 6.1 were fixed.

Fixed status
mainline: [23d05d563b7e7b0314e65c8e882bc27eac2da8e7]
stable/5.10: [8f8f185643747fbb448de6aab0efa51c679909a3]
stable/5.15: [6c53e8547687d9c767c139cd4b50af566f58c29a]
stable/5.4: [cd1022eaf87be8e6151435bd4df4c242c347e083]
stable/6.1: [989b0ff35fe5fc9652ee5bafbe8483db6f27b137]
stable/6.6: [95b3904a261a9f810205da560e802cc326f50d77]

CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

stable 4.19, 5.10, and 5.4 were fixed.

Fixed status
mainline: [bed9e27baf52a09b7ba2a3714f1e24e17ced386d]
stable/4.19: [1e8c1c2a92692881ac7ec92dcf1c8a846584251b]
stable/5.10: [88ec9bbcd33c21d30becd9d2949e8158f47660cd]
stable/5.15: [0ee3ded745ca8ce68e107d9b5e5d33938e091003]
stable/5.4: [7f71d9817cea3582daa2e903596461f5f5d0c022]
stable/6.1: [bed0acf330b2c50c688f6d9cfbcac2aa57a8e613]
stable/6.6: [e16a0bbdb7e590a6607b0d82915add738c03c069]
stable/6.7: [0de40f76d567133b871cd6ad46bb87afbce46983]

CVE-2024-0340: vhost: use kzalloc() instead of kmalloc() followed by memset()

stable 4.19, 5.10, 5.15, and 5.4.

Fixed status
mainline: [4d8df0f5f79f747d75a7d356d9b9ea40a4e4c8a9]
stable/4.19: [95eab1039625d54d1770665756dd34e9fe926638]
stable/5.10: [cda4ca038cafe016bd8dcac8cac83d771dfdcbf0]
stable/5.15: [be38f291fd4d106be66370debd23d625c576023e]
stable/5.4: [88c7e1e7a6b82d38ff82ca446862f3d5de34192a]
stable/6.1: [4675661672e3730597babf97c4e9593a775c8917]

CVE-2024-0607: netfilter: nf_tables: fix pointer math issue in
nft_byteorder_eval()

stable 4.19, 5.10, and 5.4.

Fixed status
mainline: [c301f0981fdd3fd1ffac6836b423c4d7a8e0eb63]
stable/4.19: [fca41e5b687e029f69e3a35a2fa31e2560e538dc]
stable/5.10: [9a865a11d6890d4a789db1eaafebdc8bd092b12c]
stable/5.15: [b8b514b2a6cdfac24911e4910461bcb9db15ca8d]
stable/5.4: [25b42be4e067e107a2559266b54bf07fa5b094fb]
stable/6.1: [18a169810cff769a7a697b35058c756805f589e0]
stable/6.6: [013deed31ab15ef287b0045e4e7bd8f250e75b94]

CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict parameters

stable 4.19, 5.10, 5.15, and 5.4.

Fixed status
mainline: [f342de4e2f33e0e39165d8639387aa6c19dff660]
stable/4.19: [8365e9d92b85fda975a5ece7a3a139cb964018c8]
stable/5.10: [55a60251fa50d4e68175e36666b536a602ce4f6c]
stable/5.15: [960cf4f812530f01f6acc6878ceaa5404c06af7b]
stable/5.4: [4e66422f1b56149761dc76030e6345d1cca6f869]
stable/6.1: [8e34430e33b8a80bc014f3efe29cac76bc30a4b4]
stable/6.6: [6653118b176a00915125521c6572ae8e507621db]
stable/6.7: [f05a497e7bc8851eeeb3a58da180ba469efebb05]

CVE-2024-1151: net: openvswitch: limit the number of recursions from action sets

stable 5.10, 5.15 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [6e2f90d31fe09f2b852de25125ca875aabd81367]
stable/5.10: [55cfccb658fc142d7fbfeae2d0496b7841d128c3]
stable/5.15: [c45f2fa92cb273f77be33b60a120ff7cf6df8085]
stable/6.1: [65ded4eb220695909eee657758e824fc30f0b561]

CVE-2024-23849: net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

stable 4.19, 5.10, 5.15, and 5.4.

Fixed status
mainline: [13e788deb7348cc88df34bed736c3b3b9927ea52]
stable/4.19: [344350bfa3b4b37d7c3d5a00536e6fbf0e953fbf]
stable/5.10: [5ae8d50044633306ff160fcf7faa24994175efe1]
stable/5.15: [00d1ee8e1d02194f7b7b433e904e04bbcd2cc0dc]
stable/5.4: [a37ae111db5e0f7e3d6b692056c30e3e0f6f79cd]
stable/6.1: [71024928b3f71ce4529426f8692943205c58d30b]
stable/6.6: [7a73190ea557e7f26914b0fe04c1f57a96cb771f]
stable/6.7: [0b787c2dea15e7a2828fa3a74a5447df4ed57711]

CVE-2024-23850: btrfs: do not ASSERT() if the newly created subvolume
already got read

stable 5.10, 5.15, 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [e03ee2fe873eb68c1f9ba5112fee70303ebf9dfb]
stable/5.10: [3f5d47eb163bceb1b9e613c9003bae5fefc0046f]
stable/5.15: [e31546b0f34af21738c4ceac47d662c00ee6382f]
stable/6.1: [66b317a2fc45b2ef66527ee3f8fa08fb5beab88d]
stable/6.6: [833775656d447c545133a744a0ed1e189ce61430]
stable/6.7: [5a172344bfdabb46458e03708735d7b1a918c468]

CVE-2024-23851: Kernel crash in drivers/md/dm-ioctl.c when allocate
memory more than INT_MAX bytes

stable 5.10, 5.15, and 6.1 were fixed.

Fixed status
mainline: [bd504bcfec41a503b32054da5472904b404341a4]
stable/5.10: [a891a0621e725e85529985139cada8cb5a74a116]
stable/5.15: [888a0a46b80fa37eacfe81faf47ba0b83876251d]
stable/6.1: [c5d83ac2bf6ca668a39ffb1a576899a66153ba19]
stable/6.6: [438d19492b7f002334573bae43276297eb234c80]
stable/6.7: [cd70175481f63af31901dd463e44386f033c3f4c]

CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval element from gc

stable 5.10, 5.15, 5.4, 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [60c0c230c6f046da536d3df8b39a20b9a9fd6af0]
stable/5.10: [4cee42fcf54fec46b344681e7cc4f234bb22f85a]
stable/5.15: [2bab493a5624444ec6e648ad0d55a362bcb4c003]
stable/5.4: [10e9cb39313627f2eae4cd70c4b742074e998fd8]
stable/6.1: [1296c110c5a0b45a8fcf58e7d18bc5da61a565cb]
stable/6.6: [b734f7a47aeb32a5ba298e4ccc16bb0c52b6dbf7]
stable/6.7: [6eb14441f10602fa1cf691da9d685718b68b78a9]

CVE-2024-26582: net: tls: fix use-after-free with partial reads and
async decrypt

stable 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [32b55c5ff9103b8508c1e04bfa5a08c64e7a925f]
stable/6.1: [20b4ed034872b4d024b26e2bc1092c3f80e5db96]
stable/6.6: [d684763534b969cca1022e2a28645c7cc91f7fa5]
stable/6.7: [754c9bab77a1b895b97bd99d754403c505bc79df]

CVE-2024-26583: tls: fix race between async notify and socket close

stable 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [aec7961916f3f9e88766e2688992da6980f11b8d]
stable/6.1: [7a3ca06d04d589deec81f56229a9a9d62352ce01]
stable/6.6: [86dc27ee36f558fe223dbdfbfcb6856247356f4a]
stable/6.7: [6209319b2efdd8524691187ee99c40637558fa33]

CVE-2024-26584: net: tls: handle backlogging of crypto requests

stable 6.6 and 6.7 were fixed.

Fixed status
mainline: [8590541473188741055d27b955db0777569438e3]
stable/6.6: [13eca403876bbea3716e82cdfe6f1e6febb38754]
stable/6.7: [ab6397f072e5097f267abf5cb08a8004e6b17694]

CVE-2024-26585: tls: fix race between tx work scheduling and socket close

stable 6.6 and 6.7 were fixed.

Fixed status
mainline: [e01e3934a1b2d122919f73bc6ddbe1cdafc4bbdb]
stable/6.6: [6db22d6c7a6dc914b12c0469b94eb639b6a8a146]
stable/6.7: [e327ed60bff4a991cd7a709c47c4f0c5b4a4fd57]

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

