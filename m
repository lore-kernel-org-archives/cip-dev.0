Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78830C433FE
	for <webhook@archiver.kernel.org>; Thu, 20 Oct 2022 00:48:42 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
 by mx.groups.io with SMTP id smtpd.web09.4527.1666226919405237491
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Oct 2022 17:48:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20210112.gappssmtp.com header.s=20210112 header.b=F7U/+QfZ;
 spf=pass (domain: miraclelinux.com, ip: 209.85.210.176, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-pf1-f176.google.com with SMTP id d10so18814637pfh.6
        for <cip-dev@lists.cip-project.org>; Wed, 19 Oct 2022 17:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=muUBMhjwQoMOHaGod4HDcheU3e40gRyzvDlXDrsY3/w=;
        b=F7U/+QfZAr3NPEGkKjXCLVMPR9UyVefdcIKirIwaoKVAJ1GGO2m0fnomEy++QQNg+H
         Bp/gvd+dQxm0Y5RxcKEA23PPSogDpLfNRKXWlG7ubayLnxVsq2mvRhVbWTl1TlSQvNIT
         pXJB7667Q1kmIwX1wM+c/7XPs9F1K8ZsTg7eqsfSV2YcjE6f/j2bezwkqYAgePeqM1QJ
         COdiXD9kOmp1m5vb8NFdvrPrfes8uizC1J3kbsJ54rskTpyhwzvWdVDrqQNOyWD+Btv7
         n7KScwYbSfmK1QCxFPpWgz0DfDzAgjBpqX1zFvA7f4zpkea2/BSDBUyGbG35Qqvo5UtS
         E5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=muUBMhjwQoMOHaGod4HDcheU3e40gRyzvDlXDrsY3/w=;
        b=6TK2JB8O0WP0FU4Uo6eO1nVlzp7gPYkaNi3SiBSQqEqTkLUuee0i6nOyB4+BZLCxO/
         2M8AjrPmop+3ovrtl9Y1wdm8lWfs7Txwn4D7YyntbfjYEMdhouDtQ6Zqjj9UwnDmFWLh
         a/dNMajhBNwnKRdu5GxuWdCHj/ek7NaBUFco0VVXQarc3VymKdNoMUZSo6z7e1giqfT5
         jozMg/EBztvWh+9Bk3gdelOxj/WPEG9ShszNb9usPLo5qa/FatuViPxmuxd6RUgODxK4
         kdL5RtyHz83VLbcuhW14bSIpE+Zr+GpdqZ2yX0uvYOMdaSp9mAZuBIC9sAaq6OWhgQzw
         t6zA==
X-Gm-Message-State: ACrzQf1xpEnCEVzYVgGczRVmhzEn65ojP33WYnhyX3o4yaun8f6lbdOs
	pJnn1KMM15KADBvAMSsscFNr+M6zhjtLrOev7l1gthYKIh18Pg==
X-Google-Smtp-Source: AMsMyM7V3/8QVsDChcHf+u7gUJocCINCSS1u8t1pYpLmC+Jl36KPHuDxuig+ADQRJmOuqu5NfN/XBfP3QLGAQKqBbDg=
X-Received: by 2002:a65:4c46:0:b0:460:f598:d038 with SMTP id
 l6-20020a654c46000000b00460f598d038mr9781674pgr.99.1666226917791; Wed, 19 Oct
 2022 17:48:37 -0700 (PDT)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 20 Oct 2022 09:48:01 +0900
Message-ID: <CAODzB9q+zmEqdu1=u7JESKbqgDvkAjXaeRPXELRm7Gyg+-76FA@mail.gmail.com>
Subject: New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Oct 2022 00:48:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9793

Hi !

It's this week's CVE report.

This week reported 23 new CVEs and 2 updated CVEs.
CVE-2022-41674, CVE-2022-42719, and CVE-2022-42720 are remote code
execution vulnerabilities. These CVEs are already fixed.

* New CVEs

CVE-2022-41674: fix u8 overflow in cfg80211_update_notlisted_nontrans

CVSS v3 score is 8.1 HIGH.

There is a buffer overflow bug in cfg80211_update_notlisted_nontrans()
which causes 2 bytes to be overwritten.
This overflow result leads to remote code execution.

This bug was introduced by commit 0b8fb82 ("cfg80211: Parsing of
Multiple BSSID information in scanning") in 5.1-rc1.
This commit isn't backported to 4.x kernels so 4.x kernels aren't
affected by this vulnerability.

Fixed status
mainline: [aebe9f4639b13a1f4e9a6b42cdd2e38c617b442d]
stable/5.10: [a6408e0b694c1bdd8ae7dd0464a86b98518145ec]
stable/5.15: [9a8ef2030510a9d6ce86fd535b8d10720230811f]
stable/5.19: [42ea11a81ac853c3e870c70d61ab435d0b09b851]
stable/5.4: [020402c7dd587a8a4725d32bbd172a5f7ecc5f8f]
stable/6.0: [fc1ed6d0c9898a68da7f1f7843560dfda57683e2]

CVE-2022-42719: wifi: mac80211: fix MBSSID parsing use-after-free

CVSS v3 score is 8.8 HIGH.

There is a use-after-free bug in the mac80211 subsystem. The result
will cause a remote code execution.

This vulnerability was introduced by commit 5023b14 ("mac80211:
support profile split between elements") in 5.2-rc1.
The commit 5023b14cf4df is not backported to 4.x kernels. so they
aren't affected by this vulnerability.

Fixed status
mainline: [ff05d4b45dd89b922578dac497dcabf57cf771c6]
stable/5.10: [31ce5da48a845bac48930bbde1d45e7449591728]
stable/5.15: [de124365a7d2deed22cf706583930f28d537ff0f]
stable/5.19: [e6d77ac0132da7e73fdcc4a38dd4c40ac0226466]
stable/6.0: [4afcb8886800131f8dd58d82754ee0c508303d46]

CVE-2022-42720: wifi: cfg80211: fix BSS refcounting bugs

CVSS v3 score is 7.8 HIGH.

There is a use-after-free bug in cfg80211 subsystem. The result will
cause a remote code execution.

Introduced by commit a3584f5 ("cfg80211: Properly track transmitting
and non-transmitting BSS") which is not backported to 4.x kernels. so
they aren't affected by this vulnerability.

Fixed status
mainline: [0b7808818cb9df6680f98996b8e9a439fa7bcc2f]
stable/5.10: [6b944845031356f3e0c0f6695f9252a8ddc8b02f]
stable/5.15: [bfe29873454f38eb1a511a76144ad1a4848ca176]
stable/5.19: [46b23a9559580a72d8cc5811b1bce8db099806d6]
stable/5.4: [785eaabfe3103e8bfa36aebacff6e8f69f092ed7]
stable/6.0: [e97a5d7091e6d2df05f8378a518a9bbf81688b77]

CVE-2022-42721: wifi: cfg80211: avoid non transmitted BSS list corruption

CVSS v3 score is 5.5 MEDIUM.

If there is an invalid BSS=EF=BC=88Basic Service Set=EF=BC=89, the cfg80211=
 subsystem
will loop the data forever. That causes DoS attacks.

Introduced by commit 0b8fb82 ("cfg80211: Parsing of Multiple BSSID
information in scanning") which is not backported to 4.x kernels. so
they aren't affected by this vulnerability.

Fixed status
mainline: [bcca852027e5878aec911a347407ecc88d6fff7f]
stable/5.10: [b0e5c5deb7880be5b8a459d584e13e1f9879d307]
stable/5.15: [0a8ee682e4f992eccce226b012bba600bb2251e2]
stable/5.19: [1d73c990e9bafc2754b1ced71345f73f5beb1781]
stable/5.4: [77bb20ccb9dfc9ed4f9c93788c90d08cfd891cdc]
stable/6.0: [377cb1ce85878c197904ca8383e6b41886e3994d]

CVE-2022-42722: wifi: mac80211: fix crash in beacon protection for P2P-devi=
ce

CVSS v3 score is 5.5 MEDIUM.

There is a NULL pointer dereference bug in ieee80211_rx_h_decrypt()
and ieee80211_rx_h_decrypt() when processing beacon protection for
P2P-device. This bug leads to DoS attacks.

This bug was introduced by commit 9eaf183 ("mac80211: Report beacon
protection failures to user space") which is not backported to 5.4 and
4.x kernels. so they aren't affected by this vulnerability.

Fixed status
mainline: [b2d03cabe2b2e150ff5a381731ea0355459be09f]
stable/5.10: [58c0306d0bcd5f541714bea8765d23111c9af68a]
stable/5.15: [93a3a32554079432b49cf87f326607b2a2fab4f2]
stable/5.19: [fa63b5f6f8853ace755d9a23fb75817d5ba20df5]
stable/6.0: [8ed62f2df8ebcf79c185f1bc3e4f346ea0905da6]

CVE-2022-3521: kcm: avoid potential race in kcm_tx_work

CVSS v3 score is 2.5 LOW(NIST).
CVSS v3 score is 2.6 LOW(VulDB).

A vulnerability has been found in Linux Kernel and classified as
problematic. This vulnerability affects the function kcm_tx_work of
the file net/kcm/kcmsock.c of the component kcm. The manipulation
leads to race conditions.

This bug was introduced by ab7ac4e ("kcm: Kernel Connection
Multiplexor module") in 4.6-rc1.
The kcm was introduced in 4.6 so 4.4 kernel is not affected by this issue.

Fixed status
mainline: [ec7eede369fe5b0d085ac51fdbb95184f87bfc6c]

CVE-2022-3522: mm/hugetlb: use hugetlb_pte_stable in migration race check

CVSS v3 score is 7.0 HIGH(NIST).
CVSS v3 score is 4.6 MEDIUM(VulDB).

A vulnerability was found in Linux Kernel and classified as
problematic. This issue affects the function hugetlb_no_page of the
file mm/hugetlb.c. The manipulation leads to race conditions.

Commit 2ea7ff1 ("mm/hugetlb: fix race condition of uffd missing/minor
handling") in 6.1-rc1 added a new function called
hugetlb_pte_stable(). Commit f9bf6c0 ("mm/hugetlb: use
hugetlb_pte_stable in migration race check") uses the function so
applying this patch requires commit 2ea7ff1.

Fixed status
mainline: [f9bf6c03eca1077cae8de0e6d86427656fa42a9b]

CVE-2022-3523: mm/memory.c: fix race when faulting a device private page

CVSS v3 score is not provided(NIST).
CVSS v3 score is 5.3 MEDIUM(VulDB).

A vulnerability was found in Linux Kernel. It has been classified as
problematic. Affected is an unknown function of the file mm/memory.c
of the component Driver Handler. The manipulation leads to use after
free.

Commit log said that.

```
When the CPU tries to access a device private page the migrate_to_ram()
callback associated with the pgmap for the page is called.  However no
reference is taken on the faulting page.  Therefore a concurrent migration
of the device private page can free the page and possibly the underlying
pgmap.  This results in a race which can crash the kernel due to the
migrate_to_ram() function pointer becoming invalid.  It also means drivers
can't reliably read the zone_device_data field because the page may have
been freed with memunmap_pages().
```

According to the above commit log, accessing invalid migrate_to_ram
pointer will cause a bug.
This migrate_to_ram pointer was added by commit 897e636 ("memremap:
add a migrate_to_ram method to struct dev_pagemap_ops") in 5.3-rc1.
Therefore, kernel versions from 5.3-rc1 to 6.1-rc1 are affected by
thid vulnerability.

This fix is based on Memory folios feature so that it cannot apply to
older kernels straightly.

- mm/migrate_device.c was introduced by commit 76cbbea ("mm: move the
migrate_vma_* device migration code into its own file") in 5.18-rc1.
- migrate_folio() was added into include/linux/migrate.h by commit
5418465 ("mm/migrate: Convert migrate_page() to migrate_folio()") in
6.0-rc1.
- Memory folios feature was introduced in 5.16.

Fixed status
mainline: [16ce101db85db694a91380aa4c89b25530871d33]

CVE-2022-3524: tcp/udp: Fix memory leak in ipv6_renew_options().

A vulnerability was found in Linux Kernel. It has been declared as
problematic. Affected by this vulnerability is the function
ipv6_renew_options of the component IPv6 Handler. The manipulation
leads to memory leak. The attack can be launched remotely.

CVSS v3 score is 7.5 HIGH(NIST).
CVSS v3 score is 4.3 MEDIUM(VulDB).

Kernel 4.4 is also affected by this issue. applying this fix needs to
modify the patch.

Fixed status
mainline: [3c52c6bb831f6335c176a0fc7214e26f43adbd11]

CVE-2022-3526: macvlan: Fix leaking skb in source mode with nodst option

CVSS v3 score is 7.5 HIGH(NIST).
CVSS v3 score is 5.3 MEDIUM(VulDB).

A vulnerability classified as problematic was found in Linux Kernel.
This vulnerability affects the function macvlan_handle_frame of the
file drivers/net/macvlan.c of the component skb. The manipulation
leads to memory leak. The attack can be initiated remotely.

Introduced by 427f0c8 ("macvlan: Add nodst option to macvlan type
source") in 5.13-rc1.
Before 5.13-rc1 kernels are not affected.

Fixed status
mainline: [e16b859872b87650bb55b12cca5a5fcdc49c1442]
stable/5.15: [8f79ce226ad2e9b2ec598de2b9560863b7549d1b]

CVE-2022-3531: selftest/bpf: Fix memory leak in kprobe_multi_test

CVSS v3 score is 5.7 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW(VulDB).

A vulnerability was found in Linux Kernel. It has been classified as
problematic. This affects the function get_syms of the file
tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c of the
component BPF. The manipulation leads to memory leak.

Introduced by commit 5b6c7e5c4434 ("selftests/bpf: Add attach bench
test") in 5.19-rc1. It isn't backported to older kernels.
btw, users shouldn't run kselftest on their production environment, anyway.

Fixed status
Fixed in bpf-next tree as of 2022-10-18.

CVE-2022-3532: selftests/bpf: Fix memory leak caused by not destroying skel=
eton

CVSS v3 score is 5.7 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW(VulDB).

A vulnerability was found in Linux Kernel. It has been declared as
problematic. This vulnerability affects the function
test_map_kptr_success/test_fentry of the component BPF. The
manipulation leads to memory leak.

Introduced by commit 0ef6740e9777 ("selftests/bpf: Add tests for
kptr_ref refcounting") in 5.19-rc1 and 1642a3945e22 ("selftests/bpf:
Add struct argument tests with fentry/fexit programs.") in 6.1-rc1.
These commits are not backported to stable kernels.
Users shouldn't run kselftest on their production environment, anyway.

4.4, 4.9, 4.14, 4.19, 5.4, and 5.10 kernels are not affected by this issue.

Fixed status
Fixed in bpf-next tree as of 2022-10-18.

CVE-2022-3535: net: mvpp2: fix mvpp2 debugfs leak

CVSS v3 score is not provided(NIST).
CVSS v3 score is 3.5 LOW(VulDB).

A vulnerability classified as problematic was found in Linux Kernel.
Affected by this vulnerability is the function mvpp2_dbgfs_port_init
of the file drivers/net/ethernet/marvell/mvpp2/mvpp2_debugfs.c of the
component mvpp2. The manipulation leads to memory leak.

Introduced by commit 21da57a ("net: mvpp2: add a debugfs interface for
the Header Parser") in 4.19-rc1.
4.4, 4.9, 4.10, and 4.19 kernels are not affected by this issue.

Fixed status
mainline: [0152dfee235e87660f52a117fc9f70dc55956bb4]

CVE-2022-3543: af_unix: Fix memory leaks of the whole sk due to OOB skb.

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW(VulDB).

A vulnerability, which was classified as problematic, has been found
in Linux Kernel. This issue affects the function
unix_sock_destructor/unix_release_sock of the file net/unix/af_unix.c
of the component BPF. The manipulation leads to memory leak.

Introduced by commit 314001f ("af_unix: Add OOB support") in 5.15-rc1.
This commit is not backported to older kernels.
4.4, 4.9, 4.14, 4.19, 5.4, and 5.10 kernels are not affected by this issue.

Fixed status.
mainline: [7a62ed61367b8fd01bae1e18e30602c25060d824]

CVE-2022-3564: Bluetooth: L2CAP: Fix use-after-free caused by
l2cap_reassemble_sdu

CVSS v3 score is not provided(NIST).
CVSS v3 score is 5.5 MEDIUM(VulDB).

A vulnerability classified as critical was found in Linux Kernel.
Affected by this vulnerability is the function l2cap_reassemble_sdu of
the file net/bluetooth/l2cap_core.c of the component Bluetooth. The
manipulation leads to use after free. I

Introduced by commit d2a7ac5d5d3a ("Bluetooth: Add the ERTM receive
state machine") in 3.6-rc1 and 4b51dae96731 ("Bluetooth: Add streaming
mode receive and incoming packet classifier") in 3.6-rc1.

Fixed status
fixed in bluetooth-next tree as of 2022-10-18

CVE-2022-3565: mISDN: fix use-after-free bugs in l1oip timer handlers

CVSS v3 score is not provided(NIST).
CVSS v3 score is 4.6 MEDIUM(VulDB).

A vulnerability, which was classified as critical, has been found in
Linux Kernel. Affected by this issue is the function del_timer of the
file drivers/isdn/mISDN/l1oip_core.c of the component Bluetooth. The
manipulation leads to use after free.

Fixed status
mainline: [2568a7e0832ee30b0a351016d03062ab4e0e0a3f]

CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.

CVSS v3 score is not provided(NIST).
CVSS v3 score is 4.6 MEDIUM(VulDB).

A vulnerability, which was classified as problematic, was found in
Linux Kernel. This affects the function tcp_getsockopt/tcp_setsockopt
of the component TCP Handler. The manipulation leads to race
conditions.

Fixed status
mainline: [f49cd2f4d6170d27a2c61f1fecb03d8a70c91f57]

CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.

CVSS v3 score is not provided(NIST).
CVSS v3 score is 4.6 MEDIUM(VulDB).

A vulnerability has been found in Linux Kernel and classified as
problematic. This vulnerability affects the function
inet6_stream_ops/inet6_dgram_ops of the component IPv6 Handler. The
manipulation leads to race conditions.

According to the commit log, commit 086d490 ("ipv6: annotate some
data-races around sk->sk_prot") fixes a race condition bug but it was
not enough.
Therefore it seems that both commit 086d490 and 364f997 need to fix this is=
sue.

Fixed status
mainline: [364f997b5cfe1db0d63a390fe7c801fa2b3115f6]

CVE-2022-2602: io_uring/af_unix: defer registered files gc to io_uring rele=
ase

CVSS v3 score is not provided.

A use-after-free bug was found in the io_uring subsystem. When
io_uring releasing registered fds, Unix socket Garbage Collection
process is used. If Unix GC is run before io_uring released fds, a
use-after-free bug will happen. That causes local privilege escalation
vulnerability.

Fixed status
mainline: [0091bfc81741b8d3aeb3b7ab8636f911b2de6e80]

CVE-2022-3542: bnx2x: fix potential memory leak in bnx2x_tpa_stop()

CVSS v3 score is 5.5 MEDIUM(NIST).
CVSS v3 score is 3.5 LOW(VulDB).

A vulnerability classified as problematic was found in Linux Kernel.
This vulnerability affects the function bnx2x_tpa_stop of the file
drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c of the component BPF.
The manipulation leads to memory leak.

This bug was in a driver for Broadcom NetXtremeII 10 gigabit Ethernet
cards (CONFIG_BNX2X).

Fixed status
mainline: [b43f9acbb8942b05252be83ac25a81cec70cc192]

CVE-2022-3545: nfp: fix use-after-free in area_cache_get()

CVSS v3 score is 7.8 HIGH(NIST).
CVSS v3 score is 5.5 MEDIUM(VulDB).

A vulnerability has been found in Linux Kernel and classified as
critical. Affected by this vulnerability is the function
area_cache_get of the file
drivers/net/ethernet/netronome/nfp/nfpcore/nfp_cppcore.c of the
component IPsec. The manipulation leads to use after free.

The nfp/nfpcore was added by 4cb584e0 ("nfp: add CPP access core") in
4.11-rc1. So, 4.4 and 4.9 are not affected.

Fixed status
mainline: [02e1a114fdb71e59ee6770294166c30d437bf86a]

CVE-2022-3541: eth: sp7021: fix use after free bug in
spl2sw_nvmem_get_mac_address

CVSS v3 score is 7.8 HIGH(NIST).
CVSS v3 score is 5.5 MEDIUM(VulDB).

A vulnerability classified as critical has been found in Linux Kernel.
This affects the function spl2sw_nvmem_get_mac_address of the file
drivers/net/ethernet/sunplus/spl2sw_driver.c of the component BPF. The
manipulation leads to use after free.

This issue was introduced by commit fd3040b ("net: ethernet: Add
driver for Sunplus SP7021") in 5.19-rc1.
Therefore, 4.x, 5.10, and 5.15 kernels are not affected by this issue.

Fixed status
mainline: [12aece8b01507a2d357a1861f470e83621fbb6f2]

CVE-2022-3594: r8152: Rate limit overflow messages

CVSS v3 score is not provided(NIST).
CVSS v3 score is 5.3 MEDIUM(VulDB).

A vulnerability was found in Linux Kernel. It has been declared as
problematic. Affected by this vulnerability is the function
intr_callback of the file drivers/net/usb/r8152.c of the component
BPF. The manipulation leads to logging of excessive data. The attack
can be launched remotely.

Fixed status
mainline: [93e2be344a7db169b7119de21ac1bf253b8c6907]

* Updated CVEs

CVE-2022-3303: ALSA: pcm: oss: Fix race at SNDCTL_DSP_SYNC

5.10 was fixed this week.

Fixed status
mainline: [8423f0b6d513b259fdab9c9bf4aaa6188d054c2d]
stable/5.10: [fce793a056c604b41a298317cf704dae255f1b36]
stable/5.15: [8015ef9e8a0ee5cecfd0cb6805834d007ab26f86]
stable/5.19: [723ac5ab2891b6c10dd6cc78ef5456af593490eb]
stable/5.4: [4051324a6dafd7053c74c475e80b3ba10ae672b0]

CVE-2022-40768: scsi: stex: properly zero out the passthrough command struc=
ture

stable 5.10, 5.15, 5.19, 5.4, and 6.0 were fixed this week.

Fixed status
mainline: [6022f210461fef67e6e676fd8544ca02d1bcfa7a]
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

