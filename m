Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC40C3600C
	for <webhook@archiver.kernel.org>; Tue,  8 Apr 2025 08:02:18 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.web11.69612.1744099334202030356
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Apr 2025 01:02:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=H0MG3v6X;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=RMcxQiG3;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1744099286; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pfpr7THxgP4FwRQBk+AnX5rRGqfTx6QVSSjldW3T2RVGGiHAPlQk7qSd4fYxVeP932
    AtndDImBW2gzOz2MPAK6j5iZ+b0EZirKrV47sh9GnoQNFW4m6ZXX0x9AoYH8TcT+F0YY
    2AoizZTNqbXJj+ytHXycuEyBfYF7kLuH+2RVxwjvV8oVSdH7+sGnz7l9b2jtujO/Euki
    8p3Fl25bWUMgvL2xBDUPvPL2LXl81+dBX2L+lkh0BniPxD/JmMCnwPwVv1LImU28Qvnx
    c/Gxb5EZn5DsgtFz+ZvRCH4QKtG97CqZQ6OQ1g+lcKlWVRxR4tyqtmhAgGDXVUs6ph2k
    bwTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744099286;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=k8jr4mGRDkFy3rW8NQ9/VzwdRFnDHFuThnJHnX2c09A=;
    b=N6XVMzOmIYqD3wV9m4iWihh8DPpv89Ctvarn5kdrDJPMMfmlm0yLDvgCBt5sgAXF8/
    AYS8F5aeDE5CkjLLjReVsgs7stGMhdGjylGtdEpAVYEmIApaSmFqhER2P90KaWqusYX4
    NIwYdRsZG7XvmytFOlUwS/I1t86DxxxCWmxGLt9ICVfufGZhqjW9JS5kHaajXnonde2h
    IHXjUcEbrcSwC7l5ujKHp5LtYgC//eZYa2jc6sthsBnhGWShE+W9MM8HfsziARqE11YM
    uVLDLmfjUtqIzWtq33sO3+opca8NbDoiG3NxnX2CqyLqpZ5FH9G0JF+mNMj7QqWOgF64
    O5JA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744099286;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=k8jr4mGRDkFy3rW8NQ9/VzwdRFnDHFuThnJHnX2c09A=;
    b=H0MG3v6Xa/nPNHNM93O3xqWu1f6c84G+YtXCQJHFigjp3Z/WcRBVfBlM2QCtnQ7l0X
    bfeo0KLVKA/2biJ4gD5Mh/s+EcSDYIOeP66RQ220ZgHY/FaxNBmnzRFLfa3KV6kyfiXT
    PxfoQRSniaR3ICrfe4QxxJr36NNY9mVe0CFgymtvrs9au2lSV0WVvaESkxCahRCnGl0G
    SGmzjJLqxvjMUS1FSoGrcbxeYgLHtJsnuVaHcKEVansTSPmdCee5vt4KJzyiXMwNPbbY
    My+QoVNQxMPB5YaDEhkFbk9f0QXq4qyrPZ3zVaFP7RENRVl/D5WcCNMHIlbGM2RjN6a8
    ZAUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744099286;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=k8jr4mGRDkFy3rW8NQ9/VzwdRFnDHFuThnJHnX2c09A=;
    b=RMcxQiG3CYSpEZHj+zoBCDs88qrKsxQG5c9O7IeicEhWsG0Z0I8eJUfnoRna3QnQA5
    lNsKN4gLyX+0/NvNiQAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKbK+LsAASc="
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34013881QJuJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 8 Apr 2025 10:01:26 +0200 (CEST)
Date: Tue, 8 Apr 2025 10:01:26 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <981560811.506108.1744099286218@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip119
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev75
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Apr 2025 08:02:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18492

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip119. The linux-4.19.y-cip tree's base version has been updated to v4.19-st3. The trees are up-to-date with kernel 5.4.291.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip119:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      c63e0d34ca9af8eb01e494e06579a11141a23715
    Fixed CVEs:
      CVE-2022-49636: vlan: fix memory leak in vlan_newlink()
      CVE-2024-26982: Squashfs: check the inode number is not the invalid value of zero
      CVE-2024-50055: driver core: bus: Fix double free in driver API bus_register()
      CVE-2024-57973: rdma/cxgb4: Prevent potential integer overflow on 32bit
      CVE-2024-57979: pps: Fix a use-after-free
      CVE-2024-57980: media: uvcvideo: Fix double free in error path
      CVE-2024-57981: usb: xhci: Fix NULL pointer dereference on certain command aborts
      CVE-2024-58001: ocfs2: handle a symlink read error correctly
      CVE-2024-58002: media: uvcvideo: Remove dangling pointers
      CVE-2024-58009: Bluetooth: L2CAP: handle NULL sock pointer in l2cap_sock_alloc
      CVE-2024-58010: binfmt_flat: Fix integer overflow bug on 32 bit systems
      CVE-2024-58014: wifi: brcmsmac: add gain range check to wlc_phy_iqcal_gainparams_nphy()
      CVE-2024-58017: printk: Fix signed integer overflow when defining LOG_BUF_LEN_MAX
      CVE-2024-58020: HID: multitouch: Add NULL check in mt_input_configured
      CVE-2024-58052: drm/amdgpu: Fix potential NULL pointer dereference in atomctrl_get_smc_sclk_range_table
      CVE-2024-58055: usb: gadget: f_tcm: Don't free command immediately
      CVE-2024-58058: ubifs: skip dumping tnc tree when zroot is null
      CVE-2024-58063: wifi: rtlwifi: fix memory leaks and invalid access at probe error path
      CVE-2024-58071: team: prevent adding a device which is already a team device lower
      CVE-2024-58083: KVM: Explicitly verify target vCPU is online in kvm_get_vcpu()
      CVE-2024-58090: sched/core: Prevent rescheduling when interrupts are disabled
      CVE-2025-21678: gtp: Destroy device along with udp socket's netns dismantle.
      CVE-2025-21700: net: sched: Disallow replacing of child qdisc from one parent to another
      CVE-2025-21702: pfifo_tail_enqueue: Drop new packet when sch->limit == 0
      CVE-2025-21703: netem: Update sch->q.qlen before qdisc_tree_reduce_backlog()
      CVE-2025-21704: usb: cdc-acm: Check control transfer buffer size before access
      CVE-2025-21715: net: davicom: fix UAF in dm9000_drv_remove
      CVE-2025-21718: net: rose: fix timer races against user threads
      CVE-2025-21721: nilfs2: handle errors that nilfs_prepare_chunk() may return
      CVE-2025-21722: nilfs2: do not force clear folio if buffer is referenced
      CVE-2025-21735: NFC: nci: Add bounds checking in nci_hci_create_pipe()
      CVE-2025-21736: nilfs2: fix possible int overflows in nilfs_fiemap()
      CVE-2025-21744: wifi: brcmfmac: fix NULL pointer dereference in brcmf_txfinalize()
      CVE-2025-21749: net: rose: lock the socket in rose_bind()
      CVE-2025-21753: btrfs: fix use-after-free when attempting to join an aborted transaction
      CVE-2025-21760: ndisc: extend RCU protection in ndisc_send_skb()
      CVE-2025-21761: openvswitch: use RCU protection in ovs_vport_cmd_fill_info()
      CVE-2025-21762: arp: use RCU protection in arp_xmit()
      CVE-2025-21763: neighbour: use RCU protection in __neigh_notify()
      CVE-2025-21764: ndisc: use RCU protection in ndisc_alloc_skb()
      CVE-2025-21765: ipv6: use RCU protection in ip6_default_advmss()
      CVE-2025-21772: partitions: mac: fix handling of bogus partition table
      CVE-2025-21776: USB: hub: Ignore non-compliant devices with too many configs or interfaces
      CVE-2025-21781: batman-adv: fix panic during interface removal
      CVE-2025-21782: orangefs: fix a oob in orangefs_debug_write
      CVE-2025-21785: arm64: cacheinfo: Avoid out-of-bounds write to cacheinfo array
      CVE-2025-21787: team: better TEAM_OPTION_TYPE_STRING validation
      CVE-2025-21791: vrf: use RCU protection in l3mdev_l3_out()
      CVE-2025-21811: nilfs2: protect access to buffers with no active references
      CVE-2025-21814: ptp: Ensure info->enable callback is always set
      CVE-2025-21823: batman-adv: Drop unmanaged ELP metric worker
      CVE-2025-21835: usb: gadget: f_midi: fix MIDI Streaming descriptor lengths
      CVE-2025-21846: acct: perform last write from workqueue
      CVE-2025-21848: nfp: bpf: Add check for nfp_app_ctrl_msg_alloc()
      CVE-2025-21858: geneve: Fix use-after-free in geneve_find_dev().
      CVE-2025-21859: USB: gadget: f_midi: f_midi_complete to call queue_work
      CVE-2025-21865: gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
      CVE-2025-21866: powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC
      CVE-2025-21871: tee: optee: Fix supplicant wait loop
      CVE-2025-21877: usbnet: gl620a: fix endpoint checking in genelink_bind()
      CVE-2025-21898: ftrace: Avoid potential division by zero in function_stat_show()
      CVE-2025-21904: caif_virtio: fix wrong pointer check in cfv_probe()
      CVE-2025-21909: wifi: nl80211: reject cooked mode if it is set along with other flags
      CVE-2025-21910: wifi: cfg80211: regulatory: improve invalid hints checking
      CVE-2025-21914: slimbus: messaging: Free transaction ID in delayed interrupt scenario
      CVE-2025-21916: usb: atm: cxacru: fix a flaw in existing endpoint checks
      CVE-2025-21920: vlan: enforce underlying device type
      CVE-2025-21922: ppp: Fix KMSAN uninit-value warning with bpf
      CVE-2025-21925: llc: do not use skb_get() before dev_queue_xmit()
      CVE-2025-21926: net: gso: fix ownership in __udp_gso_segment
      CVE-2025-21928: HID: intel-ish-hid: Fix use-after-free issue in ishtp_hid_remove()
      CVE-2025-21934: rapidio: fix an API misues when rio_add_net() fails
      CVE-2025-21935: rapidio: add check for rio_add_net() in rio_scan_alloc_net()
      CVE-2025-21948: HID: appleir: Fix potential NULL dereference at raw event handle

Best regards,
Ulrich Hecht

