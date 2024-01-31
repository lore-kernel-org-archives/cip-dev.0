Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8117CC47258
	for <webhook@archiver.kernel.org>; Wed, 31 Jan 2024 23:19:07 +0000 (UTC)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
 by mx.groups.io with SMTP id smtpd.web11.2659.1706743137280018302
 for <cip-dev@lists.cip-project.org>;
 Wed, 31 Jan 2024 15:18:57 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=mfsux9lb;
 spf=pass (domain: miraclelinux.com, ip: 209.85.167.173, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3becd4658e1so188093b6e.1
        for <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 15:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1706743136; x=1707347936; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iENW8fn2WADtvhZoZTAst122oc8YoYT7puanBt0usI8=;
        b=mfsux9lbeqAxEBa7dMhzOl/nGkJkywbkj12OuRFNdmeCM2kKMyC3BvWHB/YluCPuhS
         XKy9FXC5BWmRdHBnitfilpZjpOjm2PZT20euXVEJC7u3XMQS8VSp+y8p4uaBBgIM+C0o
         5XzIc/dt7WE1zqGnUZaynvb2Gp6K4cCCmP+hmoMstV/TolP/5OYDLvbTPL0D2bGt4mkj
         FeW48EtGOBKRhZBUEZ8shrBVbd3TtvJrYZnW3Q0GdfjXlDs23ccuqQyhPO5VvMov8QXX
         HM4UZ0c16kwaKxY5WwRJqy49YXy5DXPpVHFSyzvH2vkRhJ0YBnsJ9x2F7WkZDBqXigwZ
         Nikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743136; x=1707347936;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iENW8fn2WADtvhZoZTAst122oc8YoYT7puanBt0usI8=;
        b=Nz4KAje9vcqDusZjuZ8Qck9WqOyctcTV7gt/ix9hAlF/JECRSkhud6b9LjCrC22wvY
         xPaigjCn1E9jHdPhxVqU1vfTykuIOrxkozxjdCyMsehw8FFCPEtHTHU/p0y69+BNYohO
         PMOEyanxd7Cco2Rr7FQIWhFgjObqOL4U+QKQTcTrEM+SnuWHTlisKE0sjSlWPY5Z55tG
         5DXW0fGUi3Og9kUBZVpWj5N4x/+Y52+pMl8BsBpEkh68it5sgULq4yFG2zfQjSJDRqIo
         X/ShBxvButawEoP7B8lyDhsn6VRzO3Tq3Eau15T8aA2ewIPsEz+gg5Mw+fU2fdLmAieV
         JTXw==
X-Gm-Message-State: AOJu0Yz+NHa+vg5etNQVCllbrymfoOAAocLdWIOYgLq1e445t1huOPlI
	OxC3jzqH3DeXezAI2nB4SJIhyZKqOK9tuvvw7hPgYuVBg/c4uqtNqtcblUXgWcFV8Kr4WftP168
	0Kdxe8RrZb5ea/4FsLx89joF45Dpl57eG/u28xtUDGrN2vjl44eI=
X-Google-Smtp-Source: AGHT+IGEPOu6OsB+VxdfR3K2NW6lceGsX/GJKg83JEn/6WbdLJ4g5CbR81q9HSxz1UOaUU3IMZtI+JXNPsAe7uahAPY=
X-Received: by 2002:a05:6870:9111:b0:218:d17c:3435 with SMTP id
 o17-20020a056870911100b00218d17c3435mr2711309oae.44.1706743135937; Wed, 31
 Jan 2024 15:18:55 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 1 Feb 2024 08:18:20 +0900
Message-ID: <CAODzB9obeotwQ55tcyzBvqztxh_7JRi-a9smktOgHHiUYcK6yQ@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 31 Jan 2024 23:19:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14570

Hi!

It's this week's CVE report.

This week reported 10 new CVEs and 3 updated CVEs.

* New CVEs

CVE-2021-33630: net/sched: cbs: Fix not adding cbs instance to list

CVSS v3(NIST): N/A
CVSS v3(CNA): 5.5 (MEDIUM)

NULL Pointer Dereference vulnerability in openEuler kernel on Linux
(network modules) allows Pointer Manipulation. This vulnerability is
associated with program files net/sched/sch_cbs.C. This issue affects
openEuler kernel: from 4.19.90 before 4.19.90-2401.3.

It was introduced by commit e0a7683 ("net/sched: cbs: fix port_rate
miscalculation") in 5.2-rc1. This commit was backported to 4.19 so
that 4.19 is affected too.
This bug was fixed in 5.4-rc1.

Fixed status
mainline: [3e8b9bfa110896f95d602d8c98d5f9d67e41d78c]

CVE-2024-22099: NULL pointer dereference bug and buffer overflow
vulnerabilities was found in the bluetooth subsystem

CVSS v3(NIST): 5.5 (MEDIUM)
CVSS v3(CNA): 6.3 (MEDIUM)

NULL Pointer Dereference vulnerability in Linux Linux kernel kernel on
Linux, x86, ARM (net, bluetooth modules) allows Overflow Buffers. This
vulnerability is associated with program files
/net/bluetooth/rfcomm/core.C. This issue affects Linux kernel:
v2.6.12-rc2.

Fixed status
Not fixed yet

CVE-2024-23307: Integer Overflow bug was found md/raid/raid5 modules

CVSS v3(NIST): 7.8 (HIGH)
CVSS v3(CNA): 4.4 (MEDIUM)

Integer Overflow or Wraparound vulnerability in Linux Linux kernel
kernel on Linux, x86, ARM (md, raid, raid5 modules) allows Forced
Integer Overflow.

Fixed status
Not fixed yet

CVE-2024-0841: hugetlbfs: Null pointer dereference in
hugetlbfs_fill_super function

CVSS v3(NIST): N/A
CVSS v3(CNA): 6.6 (MEDIUM)

A null pointer dereference flaw was found in the hugetlbfs_fill_super
function in the Linux kernel hugetlbfs (HugeTLB pages) functionality.
This issue may allow a local user to crash the system or potentially
escalate their privileges on the system.

It seems as if all stable kernels are affected.

Fixed status
Not fixed yet

CVE-2023-52340: ipv6: remove max_size check inline with ipv4

CVSS v3(NIST): N/A
CVSS v3(CNA): N/A

According to the Amazon Linux Security Center
(https://alas.aws.amazon.com/cve/html/CVE-2023-52340.html), it
describes following that.

When a router encounters an IPv6 packet too big to transmit to the
next-hop, it returns an ICMP6 "Packet Too Big" (PTB) message to the
sender. The sender caches this updated Maximum Transmission Unit (MTU)
so it knows not to exceed this value when subsequently routing to the
same host.
In Linux kernels prior to 6.3, garbage collection is run on the IPv6
Destination Route Cache if the number of entries exceeds a threshold
when adding the destination to the cache. This garbage collection
examines every entry in the cache while holding a lock. In these
affected kernel versions, a flood of the IPv6 ICMP6 PTB messages could
cause high lock contention and increased CPU usage, leading to a
Denial-of-Service.
The fix backports the garbage collection improvements from Linux
kernel 6.3 by bringing the IPv6 code closer to the IPv4 code, which
does not have this issue.

This bug was fixed by commit af6d103 ("ipv6: remove max_size check
inline with ipv4") in 6.3-rc1. The patch doesn't have a fixed-by tag
however, it looks as if 4.4 might be affected too.

Fixed status
mainline: [af6d10345ca76670c1b7c37799f0d5576ccef277]
stable/4.19: [95372b040ae689293c6863b90049f1af68410c8b]
stable/5.10: [dd56c5790dc3484f3c89fd4e21735c796a82b40d]
stable/5.15: [b8a5308feedda10d4875a912e2e1f6be215a4ead]
stable/5.4: [584756c3d75a1722a868a1d22602251385bee798]
stable/6.1: [0f22c8a6efe63c16d1abf1e6c0317abbf121f883]

CVE-2023-6200: A use-after-free bug causes arbitrary code execution
when processing ICMPv6 router advertisement packet

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.5 (HIGH)

A race condition was found in the Linux Kernel. Under certain
conditions, an unauthenticated attacker from an adjacent network could
send an ICMPv6 router advertisement packet, causing arbitrary code
execution.

This bug was introduced by commit 3dec89b ("net/ipv6: Remove expired
routes with a separated list of routes") in 6.6-rc1. This commit is
not backported to older stable kernels.
It is fixed in 6.7-rc1.

Fixed status
mainline: [dade3f6a1e4e35a5ae916d5e78b3229ec34c78ec]
stable/6.6: [b577b9aa1340ee7f36441b0740691550abaad5f2]

CVE-2024-21803: A use-after-free bug was found in the bluetooth subsystem

CVSS v3(NIST): N/A
CVSS v3(CNA): 3.5 (LOW)

Use After Free vulnerability in Linux Linux kernel kernel on Linux,
x86, ARM (bluetooth modules) allows Local Execution of Code. This
vulnerability is associated with program files
https://gitee.Com/anolis/cloud-kernel/blob/devel-5.10/net/bluetooth/af_bluetooth.C.
This issue affects Linux kernel: from v2.6.12-rc2 before v6.8-rc1.

According to the CVE description, it was fixed in 6.8-rc1 but there is
no information about this fix.

Fixed status
No information

CVE-2024-0564: Kernel information leak bug was found in the KSM feature

CVSS v3(NIST): N/A
CVSS v3(CNA): 4.7 (MEDIUM)

A flaw was found in the Linux kernel's memory deduplication mechanism.
The max page sharing of Kernel Samepage Merging (KSM), added in Linux
kernel version 4.4.0-96.119, can create a side channel. When the
attacker and the victim share the same host and the default setting of
KSM is "max page sharing=256", it is possible for the attacker to time
the unmap to merge with the victim's page. The unmapping time depends
on whether it merges with the victim's page and additional physical
pages are created beyond the KSM's "max page share". Through these
operations, the attacker can leak the victim's page.

This bug was fixed by commit 2c653d0e ("ksm: introduce
ksm_max_page_sharing per page deduplication limit") in 4.13-rc1.

Ubuntu applied the following patch for xenial Linux 4.4.0-96.119 package.

ksm: introduce ksm_max_page_sharing per page deduplication limit:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/xenial/commit/?h=Ubuntu-4.4.0-96.119&id=731b565d8abadebb649c78fbb45983ecae7b1463


Fixed status
mainline: [2c653d0ee2ae78ff3a174cc877a057c8afac7069]

CVE-2024-1085: netfilter: nf_tables: check if catch-all set element is
active in next generation

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

A use-after-free vulnerability in the Linux kernel's netfilter:
nf_tables component can be exploited to achieve local privilege
escalation. The nft_setelem_catchall_deactivate() function checks
whether the catch-all set element is active in the current generation
instead of the next generation before freeing it, but only flags it
inactive in the next generation, making it possible to free the
element multiple times, leading to a double free vulnerability. We
recommend upgrading past commit
b1db244ffd041a49ecc9618e8feb6b5c1afcdaa7.

This bug was introduced by commit aaa3104 ("netfilter: nftables: add
catch-all set element support") in 5.13-rc1.
The commit aaa3104 is not backported to before 5.13 so that 5.10, 5.4,
and 4.x are not affected.
Fixed in 6.8-rc1.

Fixed status
mainline: [b1db244ffd041a49ecc9618e8feb6b5c1afcdaa7]
stable/5.15: [c9ed30eea4f7bfa2441235ce23abd339ee671f50]
stable/6.1: [a372f1d01bc11aa85773a02353cd01aaf16dc18e]
stable/6.6: [7baa33837ee2473eb0afd9755e29a25cd3771eac]
stable/6.7: [7e0f5f8ae3e5f17e367f7040ade7a467f1f0e3b9]

CVE-2024-1086: netfilter: nf_tables: reject QUEUE/DROP verdict parameters

CVSS v3(NIST): N/A
CVSS v3(CNA): 7.8 (HIGH)

A use-after-free vulnerability in the Linux kernel's netfilter:
nf_tables component can be exploited to achieve local privilege
escalation. The nft_verdict_init() function allows positive values as
drop error within the hook verdict, and hence the nf_hook_slow()
function can cause a double free vulnerability when NF_DROP is issued
with a drop error which resembles NF_ACCEPT. We recommend upgrading
past commit f342de4e2f33e0e39165d8639387aa6c19dff660.

This bug was introduced by commit e0abdad ("netfilter: nf_tables:
accept QUEUE/DROP verdict parameters") in 3.15-rc1. Fixed in 6.8r-c2.

Fixed status
mainline: [f342de4e2f33e0e39165d8639387aa6c19dff660]

* Updated CVEs

CVE-2023-46838: xen-netback: don''t produce zero-size SKB frags

All stable kernels were fixed.

Fixed status
stable/4.19: [5bb8270789c88c0e4ad78c0de2f274f2275c7f6c]
stable/5.10: [cce8ba6fa4ec43ad778d64823a2f8ca120d362c1]
stable/5.15: [e03023fcdb5e959d4252b3a38e1b27afb6c1c23c]
stable/5.4: [4404c2b832cf0a842b6e3c63fb5749e97dc618ea]
stable/6.1: [437360133cbd1e9fb88b122e84fff0df08f18e23]
stable/6.6: [78376d4415602d97773f20b49f4aa5fc8666f7a9]
stable/6.7: [0179c6b07f7ed2f3ea7309596169e15a59e7ee0e]


CVE-2023-6915: ida: Fix crash in ida_free when the bitmap is empty

stable 5.10, 5.15, and 5.4 were fixed.

Fixed status
mainline: [af73483f4e8b6f5c68c9aa63257bdd929a9c194a]
stable/5.10: [dbf8b0d9387fa02de0aa047ce23eb3a7bd134e03]
stable/5.15: [5dbcdaf4dbfe074e9142991c5c28eef789c1f6c6]
stable/5.4: [ef7152f8705fed11796641d7644acc3c950b5967]
stable/6.1: [9efdc0081ccae62c44a929e21d32bacc5f2e113f]
stable/6.6: [ffcaafdb8be64555e9928d943a3655c755dba92b]

CVE-2023-50431: habanalabs: fix information leak in sec_attest_info()

stable 6.1, 6.6, and 6.7 were fixed.

Fixed status
mainline: [a9f07790a4b2250f0140e9a61c7f842fd9b618c7]
stable/6.1: [6d98d249175e568f72ca94cbd6f959bc4476414e]
stable/6.6: [975aaaddc226303d382baa0d0ece84e8bec1fcf5]
stable/6.7: [db43f2eabdceedc41b8c3e0621ac42ca19b13b7d]

CVE-2023-5633: drm/vmwgfx: Keep a gem reference to user bos in surfaces

stable 6.1 was fixed.

Fixed status
mainline: [91398b413d03660fd5828f7b4abc64e884b98069]
stable/6.1: [104f95698cad038caa8f7496be67f738d8ace9cb]
stable/6.5: [1474b39f961703d0bb33833a6d6b112826839781]

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

