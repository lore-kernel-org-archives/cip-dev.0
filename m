Return-Path: <masami.ichikawa@miraclelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E71ECD6F7
	for <webhook@archiver.kernel.org>; Wed, 11 Feb 2026 22:25:30 +0000 (UTC)
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.31571.1770848725776933080
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Feb 2026 14:25:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@miraclelinux-com.20230601.gappssmtp.com header.s=20230601 header.b=LmmZp2F5;
 spf=pass (domain: miraclelinux.com, ip: 74.125.224.52, mailfrom: masami.ichikawa@miraclelinux.com)
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64a28af2f4cso2222898d50.1
        for <cip-dev@lists.cip-project.org>; Wed, 11 Feb 2026 14:25:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770848725; cv=none;
        d=google.com; s=arc-20240605;
        b=IMlmOIvYhc7/BcDB+TYJh2YV7kkOJldrkysXEL2ow3OCxDEN/op4r7WkkSjTLuO6UZ
         O9EeacJbXq8sC+ptNMxEKtJENyNienhiL4oq7OlqEeQEjz+vLYsvCBpQGABk7NoXayJV
         AAgXCinRp0dcuUS9TT4Ye5wEkkstle6N2xFz0bLAHqOsslLYYIKKR0q7DAskcW24jW9N
         +rpa/ptM8No+b7zAZqTzO34kx0bayEdMYb0ttmh39u87xVUTpqxUUABLtYZWfBvFXAFJ
         kK+7ZTEciwNvuhC7BxqDLN3eT3ag4oMtobOTaYJvhpSRneQAlnZnLVTnkJyR4OEQH9PY
         u1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=UJqHzeycPhq8AXCPmknEeWKV9nONT2zvwZyCUWRaSos=;
        fh=pMdhRv1kyG5MNR0BUSVIPLHum9zPZW2mYB9oYwYp5mc=;
        b=QH+yeoIPuDeNTYMwoTULzkl2rvkO6DWOm8YI16ScujTMsIaagU3lQ8FZGFZP5igX73
         5S0KNXtZkcnNPI0RSWs0T2x7o4P7wY1Rhwz6aqRNNpEp6w5j5P/jbdECKi1pQ2kDWKmi
         w8bEllN3hyD5rVmnstwKE9UnIz/qHVKhPjTgG9efOaV0iQaTFNUefcMfL3SwyLhgW8cM
         BOrMXC75KqwvPCOqOk383Z6blf1bUVZoTKb2ZAYoZ8VPtMRNUx+v2uxR7JFTfy83nPLf
         Qr6QmcLoiekQT21JspyEpcTQhqWPHCJxIVbC87wcBlj0VYMSGD5kr4rCvRV3AJ7gMjpN
         TMJQ==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=miraclelinux-com.20230601.gappssmtp.com; s=20230601; t=1770848725; x=1771453525; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UJqHzeycPhq8AXCPmknEeWKV9nONT2zvwZyCUWRaSos=;
        b=LmmZp2F5GyyfkORgg8kFovrBPgaH5ALULhCvF+5BwLCLaPC9VyjS4RmG2a3fGNzDoI
         WlLqanZJh5v8fpypAawTP2jY4PnQyZf2wqqEi3VsDnCEZS5qxsMu0WNbW+GuqfQsnCqu
         HLxRM6e7jd5197UBXEFucAsxSjeCAtcJs9kKrL+/A7A5kQ5ZAfV/aoc3Zl3bNVHy9AZL
         8/mM/Oa99k94db862LkGO/gqa5q3pYrN7OEYjaL92z+puBCvVMCCD80kB7rsHeOeVSuN
         Ic28i0GJEW0ek4WoEnjCinzVLVH+UKwSPCx6JkI85X5+VUFX+2dpoXNYTPZq9sl3u5He
         r5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770848725; x=1771453525;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJqHzeycPhq8AXCPmknEeWKV9nONT2zvwZyCUWRaSos=;
        b=CicR1qvwjIxh09bJ/2vhPoApbwa8suDmq0y1lcS9uQ8GF2cWuqobzKH5dn9SVRqicK
         lVZOI1xJeGURxpGMkfbihrfzAKA2kk7lfpkyFHtsa9ni1VYcgf0GzQK+owuM3K0trECD
         0eJLZ/ZhNQhx51TIzcx/pCRjdwBy6OJCvbrAC+nYYX6GcxRf1WL2bfW3hyKJQIP1M3wC
         shv4i9Zu6HjxZp4+LFeMINLNoQzLHXCMdPw1UNF/PARhucXrm9oobC3i3MWzzk7DgTtK
         +jqBGAbNsYlVcmx//ZQpBWlKvK6z3H4+KfhdcdRTx0/dgMXTDIoY8904ZqSpKQI1XCky
         GCbQ==
X-Gm-Message-State: AOJu0YyNojVkgs2CK4HrDC+VDwPO3s+3QGTMkF1oxNvstLGP5y03+AVA
	F03dOX7zihSaQJYK540bcjx+6sXBs7n0sdp4aENYx5twtvSEE+OLm/uK7QpD3Umt1YwM+9P76QP
	/lkni5UoRWdZFPRYWVKzL6sXOSPb29pUtnzmIpmn8i62sGkfllKAXlO0=
X-Gm-Gg: AZuq6aLSaKm/HSPZDqRLwEuxuF9XGNgwzkSryOnybY/lG6fw3tBmSf1yGSzNqHtVLrP
	SC2+WABXXDCDPutWzt6nVUNxlA0lAo+fJ0DhoJQAbP7CuaYg5u0zNPCt2qJQE9/fF64i8vm0+Do
	H+RE1yM3MSJn7PujGqj3Pr18MUAn6iQpiL+frxsDGBlFOFgrtvP7dclP2VVRNZw7W9NWKkBj4Nx
	rQZ7lyEqdboQzo8JWvTgO6chEDbFSCnQ4kq+UNFlDVkC3eJwAT5vD9scZzuQnzHcqWwcAozr4Tx
	UHMxziUs
X-Received: by 2002:a05:690e:b48:b0:64a:dfe6:c37b with SMTP id
 956f58d0204a3-64bdf300fe7mr465285d50.14.1770848724322; Wed, 11 Feb 2026
 14:25:24 -0800 (PST)
MIME-Version: 1.0
From: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Date: Thu, 12 Feb 2026 07:24:48 +0900
X-Gm-Features: AZwV_Qgwx_cJQvh_7GPC7UuYgS9YrPMYjAHndw1L16Rpt08xR7FsPatO02TUzsU
Message-ID: <CAODzB9q9T+65rpeuZg3_AK3OqQsd-GeKvbNfVFhy8Bt-OoV30g@mail.gmail.com>
Subject: [kernel-cve-report] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Feb 2026 22:25:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21857

Hi!

It's this week's CVE report.

This week reported 0 new CVEs and 116 updated CVEs.

* New CVEs

No new CVEs.

* Updated CVEs

CVE-2022-3526: macvlan: Fix leaking skb in source mode with nodst option

stable/5.10 was fixed.

Fixed status
stable/5.10: [ed97d37c271ac6064638a3ccb4211799af8a4d8b]

CVE-2022-50404: fbdev: fbcon: release buffer when fbcon_do_set_font() failed

stable/5.10 was fixed.

Fixed status
stable/5.10: [5a341810a22e51c3a7a108f7896b5fd58d44d127]

CVE-2023-52658: Revert "net/mlx5: Block entering switchdev mode with
ns inconsistency"

stable/6.1 was fixed.

Fixed status
stable/6.1: [136ccb2041a5d1a475f845d3bc138550be6f5daa]

CVE-2023-53421: blk-cgroup: Reinit blkg_iostat_set after clearing in
blkcg_reset_stats()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [0561aa6033dd181594116d705c41fc16e97161a2]
stable/6.1: [892faa76be894d324bf48b12a55c7af7be2bad83]

CVE-2023-53520: Bluetooth: Fix hci_suspend_sync crash

stable/5.15 was fixed.

Fixed status
stable/5.15: [e1fa25a91091bbed691ba2996a6cee809e3309a2]

CVE-2023-53662: ext4: fix memory leaks in
ext4_fname_{setup_filename,prepare_lookup}

stable/5.15 was fixed.

Fixed status
stable/5.15: [98fc9c2cc45cfcb56961a73de3ec69b474063fc0]

CVE-2023-54207: HID: uclogic: Correct devm device reference for
hidinput input_dev name

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [f78bb490b16ecb506d4904be4b00bf9aad6588f9]
stable/5.15: [51f49e3927ad545cec0c0afb86856ccacd9f085d]

CVE-2023-54285: iomap: Fix possible overflow condition in
iomap_write_delalloc_scan

stable/6.1 was fixed.

Fixed status
stable/6.1: [0c6cf409093f307ee05114f834516730c0da5b21]

CVE-2023-54321: driver core: fix potential null-ptr-deref in device_add()

stable/5.10 was fixed.

Fixed status
stable/5.10: [97aa8fb74bbe9aaf4ed5962a784f73b071bd16bf]

CVE-2024-26655: Fix memory leak in posix_clock_open()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f845cfa1a5ae697782bfcb843c9d06d3bc0cbbb6]
stable/5.15: [62a5adf57b56ee94075c889abea518b9dc66895d]
stable/6.1: [375abf52353ca5e1a2e5f763629a870f91d0c38a]

CVE-2024-26798: fbcon: always restore the old font data in fbcon_do_set_font()

stable/5.10 was fixed.

Fixed status
stable/5.10: [ae68f57df3335679653868fafccd8c88ef84ae98]

CVE-2024-42079: gfs2: Fix NULL pointer dereference in gfs2_log_flush

stable/5.15 and stable/6.1 were fixed.

Fixed status
stable/5.15: [c3c5cfa3170c0940bc66a142859caac07d19b9d6]
stable/6.1: [5f6a84cfb33b34610623857bd93919dcb661e29b]

CVE-2024-57994: ptr_ring: do not block hard interrupts in
ptr_ring_resize_multiple()

stable/6.6 was fixed.

Fixed status
stable/6.6: [572777a258c048e0d0fb3a0c47430eadcefe80c0]

CVE-2024-58096: wifi: ath11k: add srng->lock for ath11k_hal_srng_* in
monitor mode

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [1d2178918efc928e11bed9631469ef79ff0a862a]
stable/6.6: [27ca8004ba93a0665faa6d477eaeb551e03de6c8]

CVE-2025-21979: wifi: cfg80211: cancel wiphy_work before freeing wiphy

stable/5.15 was fixed.

Fixed status
stable/5.15: [8930a3e1568cf534f86c8ed2def817c6d0528fc1]

CVE-2025-22083: vhost-scsi: Fix handling of multiple calls to
vhost_scsi_set_endpoint

stable/6.1 was fixed.

Fixed status
stable/6.1: [451c72f5e7cf5d339a6410a635cee0825687c3dc]

CVE-2025-22119: wifi: cfg80211: init wiphy_work before allocating rfkill fails

stable/5.15 was fixed.

Fixed status
stable/5.15: [7e6040853f5b5f067a18c52286e676bc298fe6a2]

CVE-2025-37920: xsk: Fix race condition in AF_XDP generic RX path

stable/6.6 was fixed.

Fixed status
stable/6.6: [b6978c565ce33658543c637060852434b4248d30]

CVE-2025-37926: ksmbd: fix use-after-free in ksmbd_session_rpc_open

stable/6.1 was fixed.

Fixed status
stable/6.1: [a4348710a7267705b75692dc1a000920481d1d92]

CVE-2025-38007: HID: uclogic: Add NULL check in uclogic_input_configured()

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [a9f58479a1a2c6f72907679c4df2f4ed92b05b39]
stable/5.15: [00d52b2fa6083dd0f5c44f3604cd1bad1f9177dc]

CVE-2025-38057: espintcp: fix skb leaks

stable/5.15 was fixed.

Fixed status
stable/5.15: [05db2b850a2b8b17f3d1799f563ea1d550e05ed5]

CVE-2025-38104: drm/amdgpu: Replace Mutex with Spinlock for RLCG
register access to avoid Priority Inversion in SRIOV

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [dd450b513718dfeb4c637c9335d51a55ebcd4320]
stable/6.6: [d1bda2ab0cf956a16dd369a473a6c43dfbed5855]

CVE-2025-38125: net: stmmac: make sure that ptp_rate is not 0 before
configuring EST

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b15c9a21950e1af6d440ce5a8edfa8a94b9acb9b]
stable/6.1: [d6b0f7ed3e9b6c5e2e3a006c8f72c95aa4ac4b74]

CVE-2025-38232: NFSD: fix race between nfsd registration and exports_proc

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [49b57b98fa601ae6cc7897bab4515129da8290f7]
stable/6.1: [88d6785c173a7c4de05bef8c4fd8a9b42ead02d5]

CVE-2025-38361: drm/amd/display: Check dce_hwseq before dereferencing it

stable/6.1 was fixed.

Fixed status
stable/6.1: [5e1482ae14b03b9fca73ef5afea26ede683f4450]

CVE-2025-38408: genirq/irq_sim: Initialize work context pointers properly

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [186df821de0f34490ed5fc0861243748b2483861]
stable/6.1: [c71aa4bb528ae6f8fd7577a0a39e5a03c60b04fb]

CVE-2025-38591: bpf: Reject narrower access to pointer ctx fields

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [7847c4140e06f6e87229faae22cc38525334c156]
stable/5.15: [feae34c992eb7191862fb1594c704fbbf650fef8]
stable/6.1: [33660d44e789edb4f303210c813fc56d56377a90]

CVE-2025-38718: sctp: linearize cloned gso packets in sctp_rcv

stable/6.1 was fixed.

Fixed status
stable/6.1: [4506bcaabe004d07be8ff09116a3024fbd6aa965]

CVE-2025-39702: ipv6: sr: Fix MAC comparison to be constant-time

stable/5.10 was fixed.

Fixed status
stable/5.10: [ff55a452d56490047f5233cc48c5d933f8586884]

CVE-2025-39721: crypto: qat - flush misc workqueue during device shutdown

stable/6.1 was fixed.

Fixed status
stable/6.1: [fa4c14a82747886d333d8baef0d26da86ba1ccf7]

CVE-2025-40039: ksmbd: Fix race condition in RPC handle list access

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [69674b029002b1d90b655f014bdf64f404efa54d]
stable/6.6: [6b615a8fb3af0baf8126cde3d4fee97d57222ffc]

CVE-2025-40090: ksmbd: fix recursive locking in RPC handle list access

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [5493571f4351f74e11db9943e98a07c56467cf7e]
stable/6.6: [1891abe832cbf5a11039e088766131d0f1642d02]

CVE-2025-40149: tls: Use __sk_dst_get() and dst_dev_rcu() in
get_netdev_for_sock().

stable/5.15 was fixed.

Fixed status
stable/5.15: [2b1bef126bbb8d0da51491357559126d567c1dee]

CVE-2025-40164: usbnet: Fix using smp_processor_id() in preemptible
code warnings

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [65d04291adf7c59338f87aab9c6fe0bfa9993e64]
stable/6.1: [f45fffae5e2549bd0a4670cc52a15ad54c9f121e]

CVE-2025-68211: ksm: use range-walk function to jump over holes in
scan_get_next_rmap_item

stable/5.10, stable/5.15 were fixed.

Fixed status
stable/5.10: [220cb3e425e17587f560335924cba9f16a842c64]
stable/5.15: [10644e8839544dd5699c03c8fb1aeeefc41602fd]

CVE-2025-68223: drm/radeon: delete radeon_fence_process in
is_signaled, no deadlock

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [d40a72d7e3bad4dfb311ef078f5a57362f088c7f]
stable/6.6: [9d0ed508a9e2af82951ce7d834f58c139fc2bd9b]

CVE-2025-68340: team: Move team device type change at the end of team_port_add

stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.15: [c8b15b0d2eec3b5c7f585e5a53dfc8d36c818283]
stable/6.1: [a74ab1b532ecc5f9106621a8f75b4c3d04466b35]
stable/6.6: [e26235840fd961e4ebe5568f11a2a078cf726663]

CVE-2025-68365: fs/ntfs3: Initialize allocated memory before use

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [bdf38063fd15f2fc7361dc0b5d3c259741eab835]
stable/6.1: [a58e29849aef8d26554a982989a2190b49aaf8ed]

CVE-2025-68725: bpf: Do not let BPF test infra emit invalid GSO types to stack

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [bb7902ed7d7f6d6a7c6c4dc25410d6127ce1085f]
stable/5.15: [e0ffb64a2d72c6705b4a4c9efef600409f7e98a0]
stable/6.1: [768376ece7036ecb8604961793a1b72afe6345dd]

CVE-2025-68817: ksmbd: fix use-after-free in ksmbd_tree_connect_put
under concurrency

stable/5.15 was fixed.

Fixed status
stable/5.15: [446beed646b2e426dd53d27358365f8678e1dd01]

CVE-2025-71162: dmaengine: tegra-adma: Fix use-after-free

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [5f8d1d66a952d0396671e1f21ff8127a4d14fb4e]
stable/5.15: [76992310f80776b4d1f7f8915f59b92883a3e44c]
stable/6.1: [ae3eed72de682ddbba507ed2d6b848c21a6b721e]

CVE-2025-71163: dmaengine: idxd: fix device leaks on compat bind and unbind

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b7bd948f89271c92d9ca9b2b682bfba56896e959]
stable/6.1: [b2d077180a56e3b7c97b7517d0465b584adc693b]

CVE-2025-71185: dmaengine: ti: dma-crossbar: fix device leak on am335x
route allocation

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [1befa553f1ecc045dc9ff56107ff50162f63f3c0]
stable/5.15: [c933aa74d9f8d35e6cda322c38c4a907d37a9a2b]
stable/6.1: [43725bd47d984937c429919ae291896d982d1f17]

CVE-2025-71186: dmaengine: stm32: dmamux: fix device leak on route allocation

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3b42020e6790a5e19b36c187ed5b488a5716f97f]
stable/5.15: [6393da54dcb3488c080a183c4182ddec71ba8d7f]
stable/6.1: [1dda2a32303df0091896b01a9d09070d61fa344c]

CVE-2025-71188: dmaengine: lpc18xx-dmamux: fix device leak on route allocation

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3d396ebfb3049a2b5fac51d2c967db5114b685e8]
stable/5.15: [499ddae78c4baa9b94df76b2d2eb6b150d15377f]
stable/6.1: [adef147a8d8c3d767abf88ad2c381ffab2993086]

CVE-2025-71189: dmaengine: dw: dmamux: fix OF node leak on route
allocation failure

stable/6.1 was fixed.

Fixed status
stable/6.1: [6b87288581a0fcbe54b39da5c10e1aee2df8776e]

CVE-2025-71190: dmaengine: bcm-sba-raid: fix device leak on probe

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4316e4c4fd2c09f68a262365f21847cafa8fe9dd]
stable/5.15: [4730f12a192d7314119b3d8331611ab151b87bdf]
stable/6.1: [bc98e68adfef3b25c06ff08f0808bb59f787420c]

CVE-2025-71191: dmaengine: at_hdmac: fix device leak on of_dma_xlate()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [49d964cde422dc66fea514b7ab24aa729df7081d]
stable/5.15: [4c67b4f45c8540ee4e62e24ca4608c6a9a81ee0f]
stable/6.1: [48b2d7f530b83cb149dbf0e48f95ccadb2d90da9]

CVE-2025-71194: btrfs: fix deadlock in wait_current_trans() due to
ignored transaction type

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e563f59395981fcd69d130761290929806e728d6]
stable/5.15: [dc84036c173cff6a432d9ab926298850b1d2a659]
stable/6.1: [d7b04b40ac8e6d814e35202a0e1568809b818295]

CVE-2025-71196: phy: stm32-usphyc: Fix off by one in probe()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a9eec890879731c280697fdf1c50699e905b2fa7]
stable/5.15: [fb9d513cdf1614bf0f0e785816afb1faae3f81af]
stable/6.1: [c06f13876cbad702582cd67fc77356e5524d02cd]

CVE-2025-71197: w1: therm: Fix off-by-one buffer overflow in alarms_store

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [49ff9b4b9deacbefa6654a0a2bcaf910c9de7e95]
stable/5.15: [060b08d72a38b158a7f850d4b83c17c2969e0f6b]
stable/6.1: [b3fc3e1f04dcc7c41787bbf08a6e0d2728e022cf]

CVE-2025-71199: iio: adc: at91-sama5d2_adc: Fix potential
use-after-free in sama5d2_adc driver

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4c83dd62595ee7b7c9298a4d19a256b6647e7240]
stable/5.15: [fdc8c835c637a3473878d1e7438c77ab8928af63]
stable/6.1: [919d176b05776c7ede79c36744c823a07d631617]

CVE-2026-22997: net: can: j1939: j1939_xtp_rx_rts_session_active():
deactivate session upon receiving the second rts

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a73e7d7e346dae1c22dc3e95b02ca464b12daf2c]
stable/5.15: [adabf01c19561e42899da9de56a6a1da0e6b8a5b]
stable/6.1: [b1d67607e97d489c0cfbbf55f48a76b00710b0e4]

CVE-2026-22998: nvme-tcp: fix NULL pointer dereferences in
nvmet_tcp_build_pdu_iovec

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [baabe43a0edefac8cd7b981ff87f967f6034dafe]
stable/5.15: [76abc83a9d25593c2b7613c549413079c14a4686]
stable/6.1: [7d75570002929d20e40110d6b03e46202c9d1bc7]

CVE-2026-22999: net/sched: sch_qfq: do not free existing class in
qfq_change_class()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [2a64fb9b47afffeb5dbab5fd3a518e1436dcc90e]
stable/5.15: [cff6cd703f41d8071995956142729e4bba160363]
stable/6.1: [f06f7635499bc806cbe2bbc8805c7cef8b1edddf]

CVE-2026-23001: macvlan: fix possible UAF in macvlan_forward_source()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8133e85b8a3ec9f10d861e0002ec6037256e987e]
stable/5.15: [484919832e2db6ce1e8add92c469e5d459a516b5]
stable/6.1: [232afc74a6dde0fe1830988e5827921f5ec9bb3f]

CVE-2026-23003: ip6_tunnel: use skb_vlan_inet_prepare() in __ip6_tnl_rcv()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f9c5c5b791d3850570796f9e067629474e613796]
stable/5.15: [64c71d60a21a9ed0a802483dcd422b5b24eb1abe]
stable/6.1: [9e1c8c2a33d0a7b1f637b5d0602fe56ed10166af]

CVE-2026-23005: x86/fpu: Clear XSTATE_BV[i] in guest XSAVE state
whenever XFD[i]=1

stable/6.1 was fixed.

Fixed status
stable/6.1: [b5995c01ba53d84182ecb9492fc4d91cfe8a362d]

CVE-2026-23006: ASoC: tlv320adcx140: fix null pointer

stable/6.1 was fixed.

Fixed status
stable/6.1: [954260a32c21d5072d8e7253c0a8b1627927cb02]

CVE-2026-23010: ipv6: Fix use-after-free in inet6_addr_del().

stable/6.1 was fixed.

Fixed status
stable/6.1: [6e89d60b4f03014f7d412ce64b17a840840d490e]

CVE-2026-23011: ipv4: ip_gre: make ipgre_header() robust

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [eeb9a521de40c6fadccc12fa5205e5a1b364d5a8]
stable/5.15: [8d5b6b2d79c1c22a5b0db1187a6439dff375a022]
stable/6.1: [2ecf0aa7cc262472a9599cc51ba02ada0897a17a]

CVE-2026-23025: mm/page_alloc: prevent pcp corruption with SMP=n

stable/6.1 was fixed.

Fixed status
stable/6.1: [68688fc4eab007834b4c2d740214423ba2a335a8]

CVE-2026-23026: dmaengine: qcom: gpi: Fix memory leak in gpi_peripheral_config()

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [4532f18e4ab36def1f55cd936d0fc002b2ce34c2]
stable/6.1: [694ab1f6f16cb69f7c5ef2452b22ba7b00a3c7c7]

CVE-2026-23030: phy: rockchip: inno-usb2: Fix a double free bug in
rockchip_usb2phy_probe()

stable/6.1 was fixed.

Fixed status
stable/6.1: [b97b2c9808c9a97e0ce30216fa12096d8b0eaa75]

CVE-2026-23031: can: gs_usb: gs_usb_receive_bulk_callback(): fix URB memory leak

stable/6.1 was fixed.

Fixed status
stable/6.1: [ec5ccc2af9e5b045671f3f604b57512feda8bcc5]

CVE-2026-23033: dmaengine: omap-dma: fix dma_pool resource leak in error paths

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8d66cb05b8b76396387a7b3a91f9284225c87f04]
stable/5.15: [2b29f38f4f9660595e8272b8e8b82ffcca7ce592]
stable/6.1: [6b867a98699657c2a698bbc9e60656349b39b905]

CVE-2026-23037: can: etas_es58x: allow partial RX URB allocation to succeed

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [97250eb05e4b6afe787290e8fd97d0675116c61b]
stable/6.1: [aec888f44853584b5a7cd01249806030cf94a73d]

CVE-2026-23038: pnfs/flexfiles: Fix memory leak in nfs4_ff_alloc_deviceid_node()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e2dde5dafb80f1af4028ed10ad255f42af71c784]
stable/5.15: [27c90d8ed81e7a289c9fe41b5e31d8bb609a3385]
stable/6.1: [34b9dd179818ff7af2b36410985fd8166573c62d]

CVE-2026-23049: drm/panel-simple: fix connector type for DataImage
SCF0700C48GGU18 panel

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f4c330b4499e7334ec6fce535574e09d55843d71]
stable/5.15: [bb309377eece5317207d71fd833f99cca4727fbd]
stable/6.1: [83e0d8d22e7ee3151af1951595104887eebed6ab]

CVE-2026-23054: net: hv_netvsc: reject RSS hash key programming
without RX indirection table

stable/6.1 was fixed.

Fixed status
stable/6.1: [8288136f508e78eb3563e7073975999cf225a2f9]

CVE-2026-23056: uacce: implement mremap in uacce_vm_ops to return -EPERM

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [78d99f062d42e3af2ca46bde1a8e46e0dfd372e3]
stable/5.15: [ebfa85658a39b49ec3901ceea7535b73aa0429e6]
stable/6.1: [75b29bdc935ff93b8e8bf6f6b4d8a4810b26e06f]

CVE-2026-23058: can: ems_usb: ems_usb_read_bulk_callback(): fix URB memory leak

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e2c71030dc464d437110bcfb367c493fd402bddb]
stable/5.15: [f48eabd15194b216030b32445f44230df95f5fe0]
stable/6.1: [61e6d3674c3d1da1475dc207b3e75c55d678d18e]

CVE-2026-23060: crypto: authencesn - reject too-short AAD (assoclen<8)
to match ESP/ESN spec

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [df22c9a65e9a9daa368a72fed596af9d7d5876bb]
stable/5.15: [fee86edf5803f1d1f19e3b4f2dacac241bddfa48]
stable/6.1: [767e8349f7e929b7dd95c08f0b4cb353459b365e]

CVE-2026-23061: can: kvaser_usb: kvaser_usb_read_bulk_callback(): fix
URB memory leak

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [d9d824582f2ec76459ffab449e9b05c7bc49645c]
stable/5.15: [40a3334ffda479c63e416e61ff086485e24401f7]
stable/6.1: [c1b39fa24c140bc616f51fef4175c1743e2bb132]

CVE-2026-23063: uacce: ensure safe queue release with state management

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b457abeb5d962db88aaf60e249402fd3073dbfab]
stable/5.15: [8b57bf1d3b1db692f34bce694a03e41be79f6016]
stable/6.1: [336fb41a186e7c0415ae94fec9e23d1f04b87483]

CVE-2026-23064: net/sched: act_ife: avoid possible NULL deref

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4ef2c77851676b7ed106f0c47755bee9eeec9a40]
stable/5.15: [dd9442aedbeae87c44cc64c0ee41abd296dc008b]
stable/6.1: [1440d749fe49c8665da6f744323b1671d25a56a0]

CVE-2026-23068: spi: spi-sprd-adi: Fix double free in probe error path

stable/6.1 was fixed.

Fixed status
stable/6.1: [bddd3d10d039729b81cfb0804520c8832a701a0e]

CVE-2026-23069: vsock/virtio: fix potential underflow in
virtio_transport_get_credit()

stable/6.1 was fixed.

Fixed status
stable/6.1: [d96de882d6b99955604669d962ae14e94b66a551]

CVE-2026-23071: regmap: Fix race condition in hwspinlock irqsave routine

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e1a7072bc4f958c9e852dc7e57e39f12b0bb44b5]
stable/5.15: [766e243ae8c8b27087a4cc605752c0d5ee2daeab]
stable/6.1: [f1e2fe26a51eca95b41420af76d22c2e613efd5e]

CVE-2026-23073: wifi: rsi: Fix memory corruption due to not set vif
driver data size

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [49ef094fdbc3526e5db2aebb404b84f79c5603dc]
stable/5.15: [0d7c9e793e351cbbe9e06a9ca47d77b6ad288fb0]
stable/6.1: [7c54d0c3e2cad4300be721ec2aecfcf8a63bc9f4]

CVE-2026-23074: net/sched: Enforce that teql can only be used as root qdisc

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [73d970ff0eddd874a84c953387c7f4464b705fc6]
stable/5.15: [ae810e6a8ac4fe25042e6825d2a401207a2e41fb]
stable/6.1: [dad49a67c2d817bfec98e6e45121b351e3a0202c]

CVE-2026-23075: can: esd_usb: esd_usb_read_bulk_callback(): fix URB memory leak

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [93b34d4ba7266030801a509c088ac77c0d7a12e9]
stable/5.15: [dc934d96673992af8568664c1b58e13eb164010d]
stable/6.1: [92d26ce07ac3b7a850dc68c8d73d487b39c39b33]

CVE-2026-23076: ALSA: ctxfi: Fix potential OOB access in audio mixer handling

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [6524205326e0c1a21263b5c14e48e14ef7e449ae]
stable/5.15: [afca7ff5d5d4d63a1acb95461f55ca9a729feedf]
stable/6.1: [8c1d09806e1441bc6a54b9a4f2818918046d5174]

CVE-2026-23078: ALSA: scarlett2: Fix buffer overflow in config retrieval

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [d5e80d1f97ae55bcea1426f551e4419245b41b9c]
stable/6.1: [51049f6e3f05d70660e2458ad3bb302a3721b751]

CVE-2026-23080: can: mcba_usb: mcba_usb_read_bulk_callback(): fix URB
memory leak

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [8b34c611a4feb81921bc4728c091e4e3ba0270c0]
stable/5.15: [b5a1ccdc63b71d93a69a6b72f7a3f3934293ea60]
stable/6.1: [59153b6388e05609144ad56a9b354e9100a91983]

CVE-2026-23082: can: gs_usb: gs_usb_receive_bulk_callback(): unanchor
URL on usb_submit_urb() error

stable/6.1 was fixed.

Fixed status
stable/6.1: [aa8a8866c533a150be4763bcb27993603bd5426c]

CVE-2026-23083: fou: Don't allow 0 for FOU_ATTR_IPPROTO.

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c7498f9bc390479ccfad7c7f2332237ff4945b03]
stable/5.15: [611ef4bd9c73d9e6d87bed57a635ff1fdd8c91ea]
stable/6.1: [6e983789b7588ee59cbf303583546c043bad8e19]

CVE-2026-23084: be2net: Fix NULL pointer dereference in be_cmd_get_mac_from_list

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [4cba480c9b9a3861a515262225cb53a1f5978344]
stable/5.15: [92c6dc181a18e6e0ddb872ed35cb48a9274829e4]
stable/6.1: [6c3e00888dbec887125a08b51a705b9b163fcdd1]

CVE-2026-23085: irqchip/gic-v3-its: Avoid truncating memory addresses

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e332b3b69e5b3acf07204a4b185071bab15c2b88]
stable/5.15: [e2f9c751f73a2d5bb62d94ab030aec118a811f27]
stable/6.1: [85215d633983233809f7d4dad163b953331b8238]

CVE-2026-23086: vsock/virtio: cap TX credit to local buffer size

stable/6.1 was fixed.

Fixed status
stable/6.1: [fef7110ae5617555c792a2bb4d27878d84583adf]

CVE-2026-23087: scsi: xen: scsiback: Fix potential memory leak in
scsiback_remove()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [a8bb3ec8d85951a56af0a72d93ccbc2aee42eef9]
stable/5.15: [427b0fb30ddec3bad05dcd73b00718f98c7026d2]
stable/6.1: [4a975c72429b050c234405668b742cdecc11548e]

CVE-2026-23089: ALSA: usb-audio: Fix use-after-free in snd_usb_mixer_free()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [51b1aa6fe7dc87356ba58df06afb9677c9b841ea]
stable/5.15: [56fb6efd5d04caf6f14994d51ec85393b9a896c6]
stable/6.1: [7009daeefa945973a530b2f605fe445fc03747af]

CVE-2026-23090: slimbus: core: fix device reference leak on report present

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [b1217e40705b2f6d311c197b12866752656217ff]
stable/5.15: [948615429c9f2ac9d25d4e1f1a4472926b217a9a]
stable/6.1: [02b78bbfbafe49832e508079148cb87cdfa55825]

CVE-2026-23091: intel_th: fix device leak on output open()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [af4b9467296b9a16ebc008147238070236982b6d]
stable/5.15: [64015cbf06e8bb75b81ae95b997e847b55280f7f]
stable/6.1: [b71e64ef7ff9443835d1333e3e80ab1e49e5209f]

CVE-2026-23093: ksmbd: smbd: fix dma_unmap_sg() nents

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [f569f5b8bfd5133defdf9c7f8a72c63aa11f54ec]
stable/6.1: [6ececffd3e9fe93a87738625dc0671165d27bf96]
stable/6.12: [70ba85e439221a5d6dda34a3004db6640f0525e6]
stable/6.6: [4d1e9a4a450aae47277763562122cc80ed703ab2]

CVE-2026-23095: gue: Fix skb memleak with inner IP protocol 0.

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [886f186328b718400dbf79e1bc8cbcbd710ab766]
stable/5.15: [380a82d36e37db49fd41ecc378c22fd29392e96a]
stable/6.1: [536f5bbc322eb1e175bdd1ced22b236a951c4d8f]

CVE-2026-23096: uacce: fix cdev handling in the cleanup path

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [c94c7188d325bc5137d447d67a2f18f7d4f2f4a3]
stable/5.15: [1bc3e51367c420e6db31f41efa874c7a8e12194a]
stable/6.1: [819d647406200d0e83e56fd2df8f451b11290559]

CVE-2026-23097: migrate: correct lock ordering for hugetlb file folios

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [e7396d23f9d5739f56cf9ab430c3a169f5508394]
stable/5.15: [ad97b9a55246eb940a26ac977f80892a395cabf9]
stable/6.1: [5edb9854f8df5428b40990a1c7d60507da5bd330]

CVE-2026-23098: netrom: fix double-free in nr_route_frame()

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [25aab6bfc31017a7e52035b99aef5c2b6bde8ffb]
stable/5.15: [6e0110ea90313b7c0558a0b77038274a6821caf8]
stable/6.1: [7c48fdf2d1349bb54815b56fb012b9d577707708]

CVE-2026-23099: bonding: limit BOND_MODE_8023AD to Ethernet devices

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [72925dbb0c8c7b16bf922e93c6cc03cbd8c955c4]
stable/6.1: [5063b2cd9b27d35ab788d707d7858ded0acc8f1d]

CVE-2026-23101: leds: led-class: Only Add LED to leds_list when it is
fully ready

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [f7a6df659af777058833802c29b3b7974db5e78a]
stable/5.15: [d117fdcb21b05c0e0460261d017b92303cd9ba77]
stable/6.1: [e90c861411fc84629a240384b0a72830539d3386]

CVE-2026-23102: arm64/fpsimd: signal: Fix restoration of SVE context

stable/6.1, stable/6.6 were fixed.

Fixed status
stable/6.1: [9bc3adba8c35119be80ab20217027720446742f2]
stable/6.6: [ce820dd4e6e2d711242dc4331713b9bb4fe06d09]

CVE-2026-23103: ipvlan: Make the addrs_lock be per port

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [3c149b662cbb202a450e81f938e702ba333864ad]
stable/5.15: [70feb16e3fbfb10b15de1396557c38e99f1ab8df]
stable/6.1: [88f83e6c9cdb46b8c8ddd0ba01393362963cf589]

CVE-2026-23105: net/sched: qfq: Use cl_is_active to determine whether
class is active in qfq_rm_from_ag

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [fac2c67bb2bb732eae4283e45fc338af7e08c254]
stable/5.15: [b8c24cf5268fb3bfb8d16324c3dbb985f698c835]
stable/6.1: [f27047abf7cac1b6f90c3ad60de21ef9f717c26d]

CVE-2026-23107: arm64/fpsimd: signal: Allocate SSVE storage when restoring ZA

stable/6.1 was fixed.

Fixed status
stable/6.1: [c5a5b150992ebab779c1ce54f54676786e47e94c]

CVE-2026-23108: can: usb_8dev: usb_8dev_read_bulk_callback(): fix URB
memory leak

stable/5.10, stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.10: [feb8243eaea7efd5279b19667d7189fd8654c87a]
stable/5.15: [ef6e608e5ee71eca0cd3475c737e684cef24f240]
stable/6.1: [60719661b4cbd7ffbed1a0e0fa3bbc82d8bd2be9]

CVE-2026-23110: scsi: core: Wake up the error handler when final
completions race against each other

stable/5.10, stable/6.1 were fixed.

Fixed status
stable/5.10: [cc872e35c0df80062abc71268d690a2f749e542e]
stable/6.1: [6d9a367be356101963c249ebf10ea10b32886607]

CVE-2023-53673: Bluetooth: hci_event: call disconnect callback before
deleting conn

stable/5.15 was fixed.

Fixed status
stable/5.15: [1ecf6dc2676ead4b927c50b1be0851fa4d756574]

CVE-2025-37822: riscv: uprobes: Add missing fence.i after building the
XOL buffer

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [be6d98766ac952d38241d5a5b213f363afa421c3]
stable/6.1: [b6d8d4d01ca8514fa89b05355f296758a91e2297]

CVE-2025-38201: netfilter: nft_set_pipapo: clamp maximum map bucket
size to INT_MAX

stable/5.10, stable/5.15, stable/6.1, stable/6.6 were fixed.

Fixed status
stable/5.10: [1fe27f97944017a9d3c5af4d6d95282bff0f1147]
stable/5.15: [4abccfb61f422300be014b8e734c63344306f009]
stable/6.1: [80417057ac60dd80f4816eb426e4e4a5bf696534]
stable/6.6: [df524a68d9021c1401965d610bb6e42ee5d9611e]

CVE-2025-38234: sched/rt: Fix race in push_rt_task

stable/6.6 was fixed.

Fixed status
stable/6.6: [9f6022b2573ae068793810db719e131df3ded405]

CVE-2025-40082: hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()

stable/5.15, stable/6.1, stable/6.12, stable/6.6 were fixed.

Fixed status
stable/5.15: [343fe375a8dd6ee51a193a1c233b999f5ea4d479]
stable/6.1: [782acde47e127c98a113726e2ff8024bd65c0454]
stable/6.12: [5b5228964619b180f366940505b77255b1a03929]
stable/6.6: [c3db89ea1ed3d540eebe8f3c36e806fb75ee4a1e]

CVE-2025-68214: timers: Fix NULL function pointer race in timer_shutdown_sync()

stable/5.15 was fixed.

Fixed status
stable/5.15: [ba43ac025c4318241f8edf94f31d2eebab86991b]

CVE-2025-68358: btrfs: fix racy bitfield write in btrfs_clear_space_info_full()

stable/6.6 was fixed.

Fixed status
stable/6.6: [d4a81b8ec639895999275ea2472c69825cd67ea4]

CVE-2025-68823: ublk: fix deadlock when reading partition table

stable/6.12, stable/6.6 were fixed.

Fixed status
stable/6.12: [9bcc47343ee0ef346aa7b2b460c8ff56bd882fe7]
stable/6.6: [64c0b7e2293757e8320f13434cd809f1c9257a62]

CVE-2025-71089: iommu: disable SVA when CONFIG_X86 is set

stable/5.15, stable/6.1 were fixed.

Fixed status
stable/5.15: [b34289505180a83607fcfdce14b5a290d0528476]
stable/6.1: [7cad37e358970af1bb49030ff01f06a69fa7d985]


Regards,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

