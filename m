Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2B0D358E8
	for <webhook@archiver.kernel.org>; Thu, 29 Jan 2026 09:10:45 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11396.1769677843619047698
 for <cip-dev@lists.cip-project.org>;
 Thu, 29 Jan 2026 01:10:44 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=HvyG8uCy;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=+804CM2p;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1769677812; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WG1m8UHOoqvSipOnWg7GViA+BzhNnmV2aMnF9Jw7sr7DjOj8TCjPBendvU2MiNpXVG
    BYmW5Vx1kVN8VEWQbQ1mmMRBQ57qQco0QF83DrhjjrS8NMS20K50pkWTf1GChrc0bfxO
    Do2tnKhycVou7tyGfF+vVBGAFMHoFYqr5OMjhrVdzss8JMnWWPcdFv61tkpbzaulO4Ug
    S2sLdq27nuBOr1xokYy7WKRIzxWTmUhGGeY0KZ9ScMJU9aYid05jn7LwhcXihOHQoPj5
    LoETyyqKckw2ftDZfuDXI/6dULbQhWo0mHuzxofmlNb2Dvg0Ew5+etJFkYw0/vP89t3a
    37ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769677812;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mdl5u6k8tJMEhSfsyCeedaTYlnAU8nXK3Sv2+CkA89k=;
    b=OLKFHguFTbgrqRy1HVhv+jAuEuFgUYW8hIO3HI5J+sJElUI3PYnmq6Areqm8t4baqb
    8SR+kg1LxR1w/CoAxlM3JIUH6T1jXbiZz3o/2CoYaO7fezMw3Q0pOME86J/bBImdSm14
    feTZ/W3khrQe+xjBfry4dIyuFT8DCC7T5hS2IjfydSbiP61LRUhPVz0wzcmj8zTNuq8b
    XqwCEsTDI87HvvdHcAsz0UZrFCzKN+lXX50/nWAmaoUvxAA15RcnpRbS5/ZuSnBVFh2E
    FC8Wf2PBWAZa6H9ZRRPA/naSog3riTDUA5yhxDiwt5ZluHIA0WQBF/6+NLfYm7OJM8U+
    y/Zw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769677812;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mdl5u6k8tJMEhSfsyCeedaTYlnAU8nXK3Sv2+CkA89k=;
    b=HvyG8uCyFD2AKBhgw83V6AnD39tIlHsLzvh/pM9lcI84aTKbPXR/KopXRWpXY1iSah
    p+ohmeeBwFKCgjBRvdsHXK1gh21+eTnBpTcuuvYqMTTUjHcu5gSfewTdM17lPqm+ogpk
    Uqf4PuK2lGCNX1PN+J9lgfOs5PcowZGI0HMyUFm72HorGuS3eH2VbpvycFgwYidfhEWM
    7J9b1BtPCePtS9Ot6bgizmqJQaso3r8M2lQ0ddMJ89Td5xFwkeBuULFr/5SgQrihJ6wt
    dW1SZqQGDMSO07obUMz82/lNgZ1FIWS9QzmV9Wa75ajAq6beSWX/xmimIebW0Setf2f2
    FO3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769677812;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=mdl5u6k8tJMEhSfsyCeedaTYlnAU8nXK3Sv2+CkA89k=;
    b=+804CM2pYs6Vi+t/af7ngRlDMLkMAaAa7ygQhsu9Bg0B6NdLOCl9EWH0JhcUPyCnfM
    eORabJLSV3RNRDx1ZYDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGtr3BjA=="
Received: from open-xchange-core-mw-gw-38.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda1720T9ACtu2
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Jan 2026 10:10:12 +0100 (CET)
Date: Thu, 29 Jan 2026 10:10:11 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <886397605.315312.1769677811930@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip128
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 46896
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 29 Jan 2026 09:10:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21789

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip128. The linux-4.19.y-cip tree's base version has been updated to v4.19-st12. The trees are up-to-date with kernel 5.10.248.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip128:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      8665174e4bc9923fa55a22e1b4b3717e7b335404
    Fixed CVEs:
      CVE-2022-49711: bus: fsl-mc-bus: fix KASAN use-after-free in fsl_mc_bus_remove()
      CVE-2023-52975: scsi: iscsi_tcp: Fix UAF during logout when accessing the shost ipaddress
      CVE-2024-36903: ipv6: Fix potential uninit-value access in __ip6_make_skb()
      CVE-2024-36927: ipv4: Fix uninit-value access in __ip_make_skb()
      CVE-2025-22121: ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()
      CVE-2025-38556: HID: core: Harden s32ton() against conversion to 0 bits
      CVE-2025-40215: xfrm: delete x->tunnel as we delete x
      CVE-2025-40256: xfrm: also call xfrm_state_delete_tunnel at destroy time for states that were never added
      CVE-2025-68255: staging: rtl8723bs: fix stack buffer overflow in OnAssocReq IE parsing
      CVE-2025-68258: comedi: multiq3: sanitize config options in multiq3_attach()
      CVE-2025-68261: ext4: add i_data_sem protection in ext4_destroy_inline_data_nolock()
      CVE-2025-68264: ext4: refresh inline data size before write operations
      CVE-2025-68266: bfs: Reconstruct file type when loading from disk
      CVE-2025-68282: usb: gadget: udc: fix use-after-free in usb_gadget_state_work
      CVE-2025-68325: net/sched: sch_cake: Fix incorrect qlen reduction in cake_drop
      CVE-2025-68332: comedi: c6xdigio: Fix invalid PNP driver unregistration
      CVE-2025-68336: locking/spinlock/debug: Fix data-race in do_raw_write_lock
      CVE-2025-68337: jbd2: avoid bug_on in jbd2_journal_get_create_access() when file system corrupted
      CVE-2025-68344: ALSA: wavefront: Fix integer overflow in sample size validation
      CVE-2025-68346: ALSA: dice: fix buffer overflow in detect_stream_formats()
      CVE-2025-68349: NFSv4/pNFS: Clear NFS_INO_LAYOUTCOMMIT in pnfs_mark_layout_stateid_invalid
      CVE-2025-68354: regulator: core: Protect regulator_supply_alias_list with regulator_list_mutex
      CVE-2025-68362: wifi: rtl818x: rtl8187: Fix potential buffer underflow in rtl8187_rx_cb()
      CVE-2025-68364: ocfs2: relax BUG() to ocfs2_error() in __ocfs2_move_extent()
      CVE-2025-68366: nbd: defer config unlock in nbd_genl_connect
      CVE-2025-68367: macintosh/mac_hid: fix race condition in mac_hid_toggle_emumouse
      CVE-2025-68372: nbd: defer config put in recv_work
      CVE-2025-68724: crypto: asymmetric_keys - prevent overflow in asymmetric_key_generate_id
      CVE-2025-68733: smack: fix bug: unprivileged task can create labels
      CVE-2025-68757: drm/vgem-fence: Fix potential deadlock on release
      CVE-2025-68767: hfsplus: Verify inode mode when loading from disk
      CVE-2025-68769: f2fs: fix return value of f2fs_recover_fsync_data()
      CVE-2025-68771: ocfs2: fix kernel BUG in ocfs2_find_victim_chain
      CVE-2025-68773: spi: fsl-cpm: Check length parity before switching to 16 bit mode
      CVE-2025-68774: hfsplus: fix missing hfs_bnode_get() in __hfs_bnode_create
      CVE-2025-68777: Input: ti_am335x_tsc - fix off-by-one error in wire_order validation
      CVE-2025-68782: scsi: target: Reset t_task_cdb pointer in error case
      CVE-2025-68783: ALSA: usb-mixer: us16x08: validate meter packet indices
      CVE-2025-68785: net: openvswitch: fix middle attribute validation in push_nsh() action
      CVE-2025-68787: netrom: Fix memory leak in nr_sendmsg()
      CVE-2025-68789: hwmon: (ibmpex) fix use-after-free in high/low store
      CVE-2025-68796: f2fs: fix to avoid updating zero-sized extent in extent cache
      CVE-2025-68797: char: applicom: fix NULL pointer dereference in ac_ioctl
      CVE-2025-68799: caif: fix integer underflow in cffrml_receive()
      CVE-2025-68801: mlxsw: spectrum_router: Fix neighbour use-after-free
      CVE-2025-68813: ipvs: fix ipv4 null-ptr-deref in route error path
      CVE-2025-68816: net/mlx5: fw_tracer, Validate format string parameters
      CVE-2025-68819: media: dvb-usb: dtv5100: fix out-of-bounds in dtv5100_i2c_msg()
      CVE-2025-68820: ext4: xattr: fix null pointer deref in ext4_raw_inode()
      CVE-2025-71069: f2fs: invalidate dentry cache on failed whiteout creation
      CVE-2025-71075: scsi: aic94xx: fix use-after-free in device removal path
      CVE-2025-71079: net: nfc: fix deadlock between nfc_unregister_device and rfkill_fop_write
      CVE-2025-71085: ipv6: BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()
      CVE-2025-71086: net: rose: fix invalid array index in rose_kill_by_device()
      CVE-2025-71091: team: fix check for port enabled in team_queue_override_port_prio_changed()
      CVE-2025-71093: e1000: fix OOB in e1000_tbi_should_accept()
      CVE-2025-71096: RDMA/core: Check for the presence of LS_NLA_TYPE_DGID correctly
      CVE-2025-71097: ipv4: Fix reference count leak when using error routes with nexthop objects
      CVE-2025-71098: ip6_gre: make ip6gre_header() robust
      CVE-2025-71104: KVM: x86: Fix VM hard lockup after prolonged inactivity with periodic HV timer
      CVE-2025-71108: usb: typec: ucsi: Handle incorrect num_connectors capability
      CVE-2025-71111: hwmon: (w83791d) Convert macros to functions to avoid TOCTOU
      CVE-2025-71113: crypto: af_alg - zero initialize memory allocated via sock_kmalloc
      CVE-2025-71114: via_wdt: fix critical boot hang due to unnamed resource allocation
      CVE-2025-71116: libceph: make decode_pool() more resilient against corrupted osdmaps
      CVE-2025-71118: ACPICA: Avoid walking the Namespace if start_node is NULL
      CVE-2025-71120: SUNRPC: svcauth_gss: avoid NULL deref on zero length gss_token in gss_read_proxy_verf
      CVE-2025-71121: parisc: Do not reprogram affinitiy on ASP chip
      CVE-2025-71123: ext4: fix string copying in parse_apply_sb_mount_options()
      CVE-2025-71125: tracing: Do not register unsupported perf events
      CVE-2025-71127: wifi: mac80211: Discard Beacon frames to non-broadcast address
      CVE-2025-71131: crypto: seqiv - Do not use req->iv after crypto_aead_encrypt
      CVE-2025-71136: media: adv7842: Avoid possible out-of-bounds array accesses in adv7842_cp_log_status()
      CVE-2025-71146: netfilter: nf_conncount: fix leaked ct in error paths
      CVE-2025-71154: net: usb: rtl8150: fix memory leak on usb_submit_urb() failure
      CVE-2026-22977: net: sock: fix hardened usercopy panic in sock_recv_errqueue
      CVE-2026-22978: wifi: avoid kernel-infoleak from struct iw_point
      CVE-2026-22988: arp: do not assume dev_hard_header() does not change skb->head
      CVE-2026-22990: libceph: replace overzealous BUG_ON in osdmap_apply_incremental()
      CVE-2026-22991: libceph: make free_choose_arg_map() resilient to partial allocation

Best regards,
Ulrich Hecht

