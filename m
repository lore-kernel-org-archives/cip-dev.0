Return-Path: <iwamatsu@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6402CD3424
	for <webhook@archiver.kernel.org>; Mon,  4 May 2026 00:52:50 +0000 (UTC)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5684.1777855963144288298
 for <cip-dev@lists.cip-project.org>;
 Sun, 03 May 2026 17:52:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20251104 header.b=e5kWFSOe;
 spf=pass (domain: gmail.com, ip: 209.85.160.175, mailfrom: iwamatsu@gmail.com)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso39873881cf.1
        for <cip-dev@lists.cip-project.org>; Sun, 03 May 2026 17:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777855962; cv=none;
        d=google.com; s=arc-20240605;
        b=SPO6v9amtoic5z41aP9hjW1JYXS37l4qAjfcOJUeNOKiNlduQPyeC3BOT9RBaZkpFU
         lCGWGEgahXtxSzwLq9MXsYn7chGLgJX5MYDl3FMG3J+TKxalJ6pFNsskrQxk5Wvx4ZoV
         YJ48CH9oM45kGl1tiEWpmfbqDEGMkCbgGADgOjqiy6MEQ5c6mhGmXXxBEmqkTS+iVy53
         eZsGt1/+4MLToumRzGBrmbiNy2LLF30BOL0ZyQzW0fHunx8LLP8Xx7mzlYGTFXO3ud3w
         P1O2py0DfX9k0U5fXcdP6cAATgJ0ymKPIRDok4L6c15UA8Dx93E9rRQDjLBPaxmIoEgY
         B70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Y8uVjlyiYmai1qp4k7RzHmheQYrkR37cRtu374b6+Xw=;
        fh=iHUz2LXfheHJbrMNy1k0ULtwTRN21Sb3rP+9X7WcnYg=;
        b=cf3V3o2opKce9G0jaEyZsXIBlvZfN+m3WzhwkK7jKKbNZy71kkxOO/LrqakRHHphb9
         bNGQ1CAClkck0UwB/pH3grWQZcjQxevlowXQ1K99hO3eONjPT9MzIRpMearw3GvZSBrY
         VNKPdfqWGZju1ckF/+QRzqhG9q13CrWGVsFibCqnRLWDJbP1A/idAZcdcWr5RKJ1j8hV
         w1qpGioCtHJm6P4kLjzzpVIuNwBLlHWmSKLi7I/YoG3TZsJN+lLslKlKTKY7qG0aQnVG
         VMLriJJk7naBuqWrDV6jjoR8pUfPPBkMm51y+ZxvOq3a7GFBmSn3ke25mTo7J/QcQ46b
         x76w==;
        darn=lists.cip-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777855962; x=1778460762; darn=lists.cip-project.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y8uVjlyiYmai1qp4k7RzHmheQYrkR37cRtu374b6+Xw=;
        b=e5kWFSOexs+3aPJ3NDmcVP9ElN2X6NukkXRxjemL0t8uUtgBNRuGcrxC7IFPW7XzvP
         L5TAx2b4DhDPcNHrjHj4wov+z2tefaR3O6JVt1tE3X3jBMYEE0mz67Mak11TQKIUmaxo
         +tsiNl0M+uYQ3r36ksf6xSA3suVWLZCr5AwHOek8sIl8iYObalS4oUjpuoHYdZAjezcd
         Np42SpVnPLd6GY11YAnLCTKG6ySLIobFbP2nyIq8HJ7RRvcVwNYUjWpISrxx8YbgcWKQ
         orcDI6rCuvO0x+DXzOGFcHfKPmfm5hkvqcSjE7PCQ57zLKq5VH9SD8duApEljzGbVJie
         w6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777855962; x=1778460762;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8uVjlyiYmai1qp4k7RzHmheQYrkR37cRtu374b6+Xw=;
        b=UcJV1zBYYSfjNFfLU2f4NRsxw0qyUftROSgNwS5bNv8Ig8FV4zHHk397hECFPBmzUz
         EO1+t83plLIiYG3CXOa67uT2h88M6ql9KlqZBc87d36iXGYxfoGr2bhxhkLBn37za/56
         oStAFI3VojNm1MXBlEiKPorO129zRN8lgfEUkkHVx1TW2+rwhwgVlUH6XKF45wIDNEUo
         R8K8Or21TyHQe40lpRta4Vc8ntdCeCrgAFDIaNtlR16oamo/6KWwEtOaoN/fN5cdDxn6
         +ZX5J3aV0Kaw7aUD2iqHDcfa5Q9L21mLNeSIr7/h2iMm+E7w7Te0sKFBQBthm+OSRmkm
         ncGw==
X-Gm-Message-State: AOJu0YymfNHJohRWBET9spZ+UO5bW/wonGyH7rciZ+r7R35TeNIoz8Ec
	/DQizr9uj0XsukRXl/z/nWX+C/ORJbvrHVXlIgqvUcbFOL5nHnGR3Q4UJtB9jlHxEPGNh0Ws+wQ
	P/NCwW1UDwQSpwgTBsKblfwyus8Sdfih0/zvB
X-Gm-Gg: AeBDiet/3UwUjdOH9m0UNZD7Q3cAUjW79TwkTZM+dEhm6EF7QuVVH6ROlh1mhbgegdf
	FUD5+WF/icvqNIVmq5Fy3+QkB074ootYwjVOG4zsixtOLN09N3CRyHR6J3dTzMWf+s8IFDdIXxF
	09mhnFW1xzqHFKk119hg7sMuCjZQT6df8baNRzbCs6x8J86Z26BBIcmJQ5FV7bJLNNSArPswvRN
	RmZNbzGdqRcipkMzTHRfrw0gV8YRwXLfL3cES8fUBHWAhue5X02iy2PqDKBn3b+MAvKIG5qRPBs
	xKHBwSisQU0RPDo=
X-Received: by 2002:ac8:5a0c:0:b0:50f:ade2:2e0 with SMTP id
 d75a77b69052e-5104bf3b91cmr117100291cf.39.1777855961558; Sun, 03 May 2026
 17:52:41 -0700 (PDT)
MIME-Version: 1.0
From: "Nobuhiro Iwamatsu (Toshiba)" <iwamatsu@gmail.com>
Date: Mon, 4 May 2026 09:52:30 +0900
X-Gm-Features: AVHnY4Lyv4KZ6pFh333kAbTqnD8t1TxDTAjfwPSjtTzzv2CSY882A08m_5hH_7Q
Message-ID: <CACe6DC5eaf6BktnNHPP1YdY-wPifA-BjMRtv6Jtn08eAERhGhw@mail.gmail.com>
Subject: [ANNOUNCE] Release v5.10.254-cip72
To: cip-dev <cip-dev@lists.cip-project.org>, masami.ichikawa@cybertrust.co.jp, 
	Jan Kiszka <jan.kiszka@siemens.com>, Chris Paterson <Chris.Paterson2@renesas.com>, 
	Pavel Machek <pavel@nabladev.com>, uli@fpond.eu
Content-Type: text/plain; charset="UTF-8"
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 04 May 2026 00:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22836

Hi all,

This is a special release addressing CVE-2026-31431.

CIP kernel team has released Linux kernel v5.10.254-cip72.
The linux-5.10.y-cip tree has been updated base version from v5.10.252
to v5.10.254.
Additionally, this release has an issue with the backporting for
Renesas ARM64 SoCs
in the LTS v5.10.254. Therefore, it is known that it will not function
correctly on Renesas
ARM64 SoCs.

Information about this release is as follows:

  v5.10.254-cip72:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      92920c8e0d5950e6665486f1dcd53cd06c682ad2
    fixed CVEs:
      CVE-2022-49752: device property: fix of node refcount leak in
fwnode_graph_get_next_endpoint()
      CVE-2024-26849: netlink: add nla be16/32 types to minlen array
      CVE-2024-56584: io_uring/tctx: work around xa_store() allocation
error issue
      CVE-2025-39748: bpf: Forget ranges when refining tnum after JSET
      CVE-2025-39764: netfilter: ctnetlink: remove refcounting in
expectation dumpers
      CVE-2025-54505: x86/CPU: Fix FPDSS on Zen1
      CVE-2025-68206: netfilter: nft_ct: add seqadj extension for
natted connections
      CVE-2026-23100: mm/hugetlb: fix hugetlb_pmd_shared()
      CVE-2026-23113: io_uring/io-wq: check IO_WQ_BIT_EXIT inside work run loop
      CVE-2026-23227: drm/exynos: vidi: use ctx->lock to protect
struct vidi_context member variables related to memory alloc/free
      CVE-2026-23245: net/sched: act_gate: snapshot parameters with
RCU on replace
      CVE-2026-23253: media: dvb-core: fix wrong reinitialization of
ringbuffer on reopen
      CVE-2026-23268: apparmor: fix unprivileged local user can do
privileged policy management
      CVE-2026-23269: apparmor: validate DFA start states are in
bounds in unpack_pdb
      CVE-2026-23274: netfilter: xt_IDLETIMER: reject rev0 reuse of
ALARM timer labels
      CVE-2026-23277: net/sched: teql: fix NULL pointer dereference in
iptunnel_xmit on TEQL slave xmit
      CVE-2026-23279: wifi: mac80211: fix NULL pointer dereference in
mesh_rx_csa_frame()
      CVE-2026-23281: wifi: libertas: fix use-after-free in lbs_free_adapter()
      CVE-2026-23286: atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
      CVE-2026-23289: IB/mthca: Add missed mthca_unmap_user_db() for
mthca_create_srq()
      CVE-2026-23290: net: usb: pegasus: validate USB endpoints
      CVE-2026-23291: nfc: pn533: properly drop the usb interface
reference on disconnect
      CVE-2026-23293: net: vxlan: fix nd_tbl NULL dereference when
IPv6 is disabled
      CVE-2026-23298: can: ucan: Fix infinite loop from zero-length messages
      CVE-2026-23300: net: ipv6: fix panic when IPv4 route references
loopback IPv6 nexthop
      CVE-2026-23303: smb: client: Don't log plaintext credentials in
cifs_set_cifscreds
      CVE-2026-23304: ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
      CVE-2026-23307: can: ems_usb: ems_usb_read_bulk_callback():
check the proper length of a message
      CVE-2026-23312: net: usb: kaweth: validate USB endpoints
      CVE-2026-23318: ALSA: usb-audio: Use correct version for UAC3
header validation
      CVE-2026-23336: wifi: cfg80211: cancel rfkill_block work in
wiphy_unregister()
      CVE-2026-23339: nfc: nci: free skb on nci_transceive early error paths
      CVE-2026-23351: netfilter: nft_set_pipapo: split gc into unlink
and reclaim phase
      CVE-2026-23352: x86/efi: defer freeing of boot services memory
      CVE-2026-23356: drbd: fix "LOGIC BUG" in drbd_al_begin_io_nonblock()
      CVE-2026-23357: can: mcp251x: fix deadlock in error path of mcp251x_open
      CVE-2026-23362: can: bcm: fix locking for bcm_op runtime updates
      CVE-2026-23365: net: usb: kalmia: validate USB endpoints
      CVE-2026-23367: wifi: radiotap: reject radiotap with unknown bits
      CVE-2026-23368: net: phy: register phy led_triggers during probe
to avoid AB-BA deadlock
      CVE-2026-23372: nfc: rawsock: cancel tx_work before socket teardown
      CVE-2026-23379: net/sched: ets: fix divide by zero in the offload path
      CVE-2026-23381: net: bridge: fix nd_tbl NULL dereference when
IPv6 is disabled
      CVE-2026-23382: HID: Add HID_CLAIMED_INPUT guards in raw_event
callbacks missing them
      CVE-2026-23388: Squashfs: check metadata block offset is within range
      CVE-2026-23391: netfilter: xt_CT: drop pending enqueued packets
on template removal
      CVE-2026-23395: Bluetooth: L2CAP: Fix accepting multiple
L2CAP_ECRED_CONN_REQ
      CVE-2026-23396: wifi: mac80211: fix NULL deref in mesh_matches_local()
      CVE-2026-23397: nfnetlink_osf: validate individual option
lengths in fingerprints
      CVE-2026-23398: icmp: fix NULL pointer dereference in
icmp_tag_validation()
      CVE-2026-23403: apparmor: fix memory leak in verify_header
      CVE-2026-23404: apparmor: replace recursive profile removal with
iterative approach
      CVE-2026-23405: apparmor: fix: limit the number of levels of
policy namespaces
      CVE-2026-23406: apparmor: fix side-effect bug in match_char() macro usage
      CVE-2026-23407: apparmor: fix missing bounds check on DEFAULT
table in verify_dfa()
      CVE-2026-23408: apparmor: Fix double free of ns_name in
aa_replace_profiles()
      CVE-2026-23409: apparmor: fix differential encoding verification
      CVE-2026-23410: apparmor: fix race on rawdata dereference
      CVE-2026-23411: apparmor: fix race between freeing data and fs
accessing it
      CVE-2026-23420: wifi: wlcore: Fix a locking bug
      CVE-2026-23434: mtd: rawnand: serialize lock/unlock against
other NAND operations
      CVE-2026-23439: udp_tunnel: fix NULL deref caused by
udp_sock_create6 when CONFIG_IPV6=n
      CVE-2026-23446: net: usb: aqc111: Do not perform PM inside
suspend callback
      CVE-2026-23452: PM: runtime: Fix a race condition related to
device removal
      CVE-2026-23455: netfilter: nf_conntrack_h323: check for zero
length in DecodeQ931()
      CVE-2026-23456: netfilter: nf_conntrack_h323: fix OOB read in
decode_int() CONS case
      CVE-2026-23457: netfilter: nf_conntrack_sip: fix Content-Length
u32 truncation in sip_help_tcp()
      CVE-2026-23458: netfilter: ctnetlink: fix use-after-free in
ctnetlink_dump_exp_ct()
      CVE-2026-23460: net/rose: fix NULL pointer dereference in
rose_transmit_link on reconnect
      CVE-2026-23462: Bluetooth: HIDP: Fix possible UAF
      CVE-2026-23463: soc: fsl: qbman: fix race condition in qman_destroy_fq
      CVE-2026-23474: mtd: Avoid boot crash in RedBoot partition table parser
      CVE-2026-31391: crypto: atmel-sha204a - Fix OOM ->tfm_count leak
      CVE-2026-31393: Bluetooth: L2CAP: Validate L2CAP_INFO_RSP
payload length before access
      CVE-2026-31396: net: macb: fix use-after-free access to PTP clock
      CVE-2026-31399: nvdimm/bus: Fix potential use after free in
asynchronous initialization
      CVE-2026-31400: sunrpc: fix cache_request leak in cache_release
      CVE-2026-31402: nfsd: fix heap overflow in NFSv4.0 LOCK replay cache
      CVE-2026-31403: NFSD: Hold net reference for the lifetime of
/proc/fs/nfs/exports fd
      CVE-2026-31405: media: dvb-net: fix OOB access in ULE extension
header tables
      CVE-2026-31415: ipv6: avoid overflows in ip6_datagram_send_ctl()
      CVE-2026-31416: netfilter: nfnetlink_log: account for netlink header size
      CVE-2026-31417: net/x25: Fix overflow when accumulating packets
      CVE-2026-31418: netfilter: ipset: drop logically empty buckets
in mtype_del
      CVE-2026-31421: net/sched: cls_fw: fix NULL pointer dereference
on shared blocks
      CVE-2026-31422: net/sched: cls_flow: fix NULL pointer
dereference on shared blocks
      CVE-2026-31423: net/sched: sch_hfsc: fix divide-by-zero in rtsc_min()
      CVE-2026-31424: netfilter: x_tables: restrict
xt_check_match/xt_check_target extensions for NFPROTO_ARP
      CVE-2026-31425: rds: ib: reject FRMR registration before IB
connection is established
      CVE-2026-31427: netfilter: nf_conntrack_sip: fix use of
uninitialized rtp_addr in process_sdp
      CVE-2026-31428: netfilter: nfnetlink_log: fix uninitialized
padding leak in NFULA_PAYLOAD
      CVE-2026-31447: ext4: reject mount if bigalloc with
s_first_data_block != 0
      CVE-2026-31450: ext4: publish jinode after initialization
      CVE-2026-31452: ext4: convert inline data to extents when
truncate exceeds inline size
      CVE-2026-31454: xfs: save ailp before dropping the AIL lock in
push callbacks
      CVE-2026-31455: xfs: stop reclaim before pushing AIL during unmount
      CVE-2026-31464: scsi: ibmvfc: Fix OOB access in
ibmvfc_discover_targets_done()
      CVE-2026-31466: mm/huge_memory: fix folio isn't locked in
softleaf_to_folio()
      CVE-2026-31469: virtio_net: Fix UAF on dst_ops when
IFF_XMIT_DST_RELEASE is cleared and napi_tx is false
      CVE-2026-31473: media: mc, v4l2: serialize REINIT and REQBUFS
with req_queue_mutex
      CVE-2026-31483: s390/syscalls: Add spectre boundary for syscall
dispatch table
      CVE-2026-31485: spi: spi-fsl-lpspi: fix teardown order issue (UAF)
      CVE-2026-31494: net: macb: use the current queue number for stats
      CVE-2026-31495: netfilter: ctnetlink: use netlink policy range checks
      CVE-2026-31497: Bluetooth: btusb: clamp SCO altsetting table indices
      CVE-2026-31498: Bluetooth: L2CAP: Fix ERTM re-init and zero
pdu_len infinite loop
      CVE-2026-31504: net: fix fanout UAF in packet_release() via NETDEV_UP race
      CVE-2026-31507: net/smc: fix double-free of smc_spd_priv when
tee() duplicates splice pipe buffer
      CVE-2026-31508: net: openvswitch: Avoid releasing netdev before
teardown completes
      CVE-2026-31509: nfc: nci: fix circular locking dependency in
nci_close_device
      CVE-2026-31510: Bluetooth: L2CAP: Fix null-ptr-deref on
l2cap_sock_ready_cb
      CVE-2026-31512: Bluetooth: L2CAP: Validate PDU length before
reading SDU length in l2cap_ecred_data_rcv()
      CVE-2026-31515: af_key: validate families in pfkey_send_migrate()
      CVE-2026-31518: esp: fix skb leak with espintcp and async crypto
      CVE-2026-31523: nvme-pci: ensure we're polling a polled queue
      CVE-2026-31524: HID: asus: avoid memory leak in asus_report_fixup()
      CVE-2026-31545: NFC: nxp-nci: allow GPIOs to sleep
      CVE-2026-31546: net: bonding: fix NULL deref in bond_debug_rlb_hash_show
      CVE-2026-31550: pmdomain: bcm: bcm2835-power: Increase ASB control timeout
      CVE-2026-31552: wifi: wlcore: Return -ENOMEM instead of -EAGAIN
if there is not enough headroom
      CVE-2026-31555: futex: Clear stale exiting pointer in
futex_lock_pi() retry path
      CVE-2026-31570: can: gw: fix OOB heap access in cgw_csum_crc8_rel()
      CVE-2026-31628: x86/CPU: Fix FPDSS on Zen1
      CVE-2026-31649: net: stmmac: fix integer underflow in chain mode
      CVE-2026-31651: mmc: vub300: fix NULL-deref on disconnect
      CVE-2026-31658: net: altera-tse: fix skb leak on DMA mapping
error in tse_start_xmit()
      CVE-2026-31659: batman-adv: reject oversized global TT response buffers
      CVE-2026-31660: nfc: pn533: allocate rx skb before consuming bytes
      CVE-2026-31661: wifi: brcmsmac: Fix dma_free_coherent() size
      CVE-2026-31662: tipc: fix bc_ackers underflow on duplicate GRP_ACK_MSG
      CVE-2026-31665: netfilter: nft_ct: fix use-after-free in timeout
object destroy
      CVE-2026-31667: Input: uinput - fix circular locking dependency
with ff-core
      CVE-2026-31668: seg6: separate dst_cache for input and output
paths in seg6 lwtunnel
      CVE-2026-31670: net: rfkill: prevent unlimited numbers of rfkill
events from being created
      CVE-2026-31671: xfrm_user: fix info leak in build_report()
      CVE-2026-31672: wifi: rt2x00usb: fix devres lifetime
      CVE-2026-31674: netfilter: ip6t_rt: reject oversized addrnr in
rt_mt6_check()
      CVE-2026-31679: openvswitch: validate MPLS set/set_masked payload length
      CVE-2026-31680: net: ipv6: flowlabel: defer exclusive option
free until RCU teardown
      CVE-2026-31682: bridge: br_nd_send: linearize skb before parsing
ND options
      CVE-2026-31683: batman-adv: avoid OGM aggregation when skb
tailroom is insufficient
      CVE-2026-31788: In the Linux kernel, the following vulnerability
has been resolved: xen/privcmd: ...
      CVE-2026-31431: crypto: algif_aead - Revert to operating out-of-place
      CVE-2026-31786: Buffer overflow in drivers/xen/sys-hypervisor.c
      CVE-2026-31787: xen/privcmd: fix double free via VMA splitting
    added commits:
      CIP: Bump version suffix to -cip72 after merge from stable
      clk: renesas: Add missing log message terminators
      clk: renesas: rzg2l: Remove DSI clock rate restrictions
      clk: renesas: rzg2l: Select correct div round macro
      math64: New DIV_U64_ROUND_CLOSEST helper
      clk: renesas: rzg2l: Fix intin variable size
      clk: renesas: Use IS_ERR() for pointers that cannot be NULL
      drm: renesas: rz-du: mipi_dsi: Set DSI divider
      drm: renesas: rz-du: mipi_dsi: fix kernel panic when rebooting
for some panels
      drm: renesas: rz-du: Implement MIPI DSI host transfers
      drm: renesas: rz-du: Add atomic_pre_enable

Best regards,
  Nobuhiro

