Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3ABC83F1B
	for <webhook@archiver.kernel.org>; Thu, 17 Jul 2025 11:04:54 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
 by mx.groups.io with SMTP id smtpd.web11.46429.1752750287553937998
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Jul 2025 04:04:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Zv7ErG2R;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=R6xUu/kK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.54, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1752750267; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=DS2tb20A2TEcnh0iouNX+1rR6Wu25cZtmWUp4erTjx2Aqj6OyFSPMZHNLng+rNmfbj
    /lvTgr6rOdd2E21SCFUY7Y9QnDLiYB1SYuSo19EDLLG8KBkoQYPlpEwyxAhjqC11IFt5
    NxYa/DOflhQ/kmTmAAbkWWtVzdhwuhaDX/bqeU/rt5VhtRD/5V/kkfVvdgdesh5g9wzD
    pxXPtnWO7ecRUFk+e6KdCGQkbRc2EK7s05nmXKkIEagnYyJTioGZ+51DUnfnIByq8umu
    crM4bU8akDZlIK+ZB6AZJQ6xWK6WbsR23so9Ly9YLycM56eKC0Cpsu4jYrvcDyK3hCeW
    mVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1752750267;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=w8p4eU+J9qLA3i8Mei2ZviwnFaYucem6K5s/y48tZxY=;
    b=WGO1lTYIBntl7v3IVYO2acZB0lGrdBG3Yihgs/jyS8wrNTfNcNdyvTxX791jWO341E
    bCC5XgCuP+KchouZ6Kemw00HpjJzBLAJaDkoUienTxlW14F9CdlvujaKhkbkQ+8S6asb
    5mnbgejgIU63zC2k21syFO32K39vi10MF9IrNIuS37SHSqrbPX7Q4YegG1WnkC3hpAtZ
    Bv5k0fmSZ4hkjCNh2mwxlzHYg346Ecx5SEMecF7Yt3nlT2sRmfG7wFe/+U7c3LVL+1uC
    xqGyby8kYBEKHMBJMILEKl/gxKE6sns34p1hLk1kA2FlQUHmA/X4v8qilFEr2fckj/kW
    cFCQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1752750267;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=w8p4eU+J9qLA3i8Mei2ZviwnFaYucem6K5s/y48tZxY=;
    b=Zv7ErG2RZVkIkZEfHGzp4UX2IjbAM2W+781s2kdrc4tlZ1Jp3dB0xZeAwQtC/4pEAh
    ytzj6Hd8sb721XLZo3sNYOIhyMt7yAbk/G+1GhaIXSf0shnO861+lIocGD2eOH/818b5
    QLiXDNOyMdlFGZMDsWu64yVZqoA1EdLSrjqjaVEEmq0zvF4WO1UfAilHQuX9r9i8brPS
    kCmyT8bVB307ljkGm5o1D1UcXkzEI5REoYc9lwQRVMJ536zZkMa8GYoS4tMiBsBoRulw
    3rfvXR2TZO6S8DtvQDg8CcaKutVIQIZ0L/3tPxHIZvPXwpiz3UGapmfuzBHGr3T1rd5d
    NPlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1752750267;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=w8p4eU+J9qLA3i8Mei2ZviwnFaYucem6K5s/y48tZxY=;
    b=R6xUu/kKbm2W7knG7BHZo8x+MqVtjIjG6/zCoOUps5r/OeAOxerVPxnRiYbDLdgUp9
    ODZJ7KzGWOQJvR4MHSAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z1af2716HB4RFF9
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 17 Jul 2025 13:04:27 +0200 (CEST)
Date: Thu, 17 Jul 2025 13:04:27 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <112595047.38932.1752750267361@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip122
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.55
X-Originating-Port: 44972
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Jul 2025 11:04:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19555

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip122. The linux-4.19.y-cip tree's base version has been updated to v4.19-st6. The trees are up-to-date with kernel 5.4.295.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip122:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      019ba39c16cf7bf1e244899b97634f11923d4aa7
    Fixed CVEs:
      CVE-2024-49903: jfs: Fix uaf in dbFreeBits
      CVE-2022-21546: scsi: target: Fix WRITE_SAME No Data Buffer crash
      CVE-2022-48828: NFSD: Fix ia_size underflow
      CVE-2022-48829: NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      CVE-2024-38541: of: module: add buffer overflow check in of_modalias()
      CVE-2024-56655: netfilter: nf_tables: do not defer rule destruction via call_rcu
      CVE-2025-37923: tracing: Fix oob write in trace_seq_to_buffer()
      CVE-2025-37927: iommu/amd: Fix potential buffer overflow in parse_ivrs_acpihid
      CVE-2025-37949: xenbus: Use kref to track req lifetime
      CVE-2025-37953: sch_htb: make htb_deactivate() idempotent
      CVE-2025-37970: iio: imu: st_lsm6dsx: fix possible lockup in st_lsm6dsx_read_fifo
      CVE-2025-37990: wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()
      CVE-2025-37995: module: ensure that kobject_put() is safe for module type kobjects
      CVE-2025-37998: openvswitch: Fix unsafe attribute parsing in output_userspace()
      CVE-2025-38003: can: bcm: add missing rcu read protection for procfs content
      CVE-2025-38004: can: bcm: add locking for bcm_op runtime updates
      CVE-2025-38023: nfs: handle failure of nfs_get_lock_context in unlock path
      CVE-2025-38024: RDMA/rxe: Fix slab-use-after-free Read in rxe_queue_cleanup bug
      CVE-2025-38034: btrfs: correct the order of prelim_ref arguments in btrfs__prelim_ref
      CVE-2025-38044: media: cx231xx: set device_caps for 417
      CVE-2025-38051: smb: client: Fix use-after-free in cifs_fill_dirent
      CVE-2025-38058: __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
      CVE-2025-38061: net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
      CVE-2025-38066: dm cache: prevent BUG_ON by blocking retries on failed device resumes
      CVE-2025-38075: scsi: target: iscsi: Fix timeout on deleted connection
      CVE-2025-38078: ALSA: pcm: Fix race of buffer access at PCM OSS layer
      CVE-2025-38079: crypto: algif_hash - fix double free in hash_accept
      CVE-2024-46855: netfilter: nft_socket: fix sk refcount leaks
      CVE-2025-37932: sch_htb: make htb_qlen_notify() idempotent
      CVE-2025-37958: mm/huge_memory: fix dereferencing invalid pmd migration entry
      CVE-2025-38000: sch_hfsc: Fix qlen accounting bug when using peek in hfsc_enqueue()
      CVE-2025-38037: vxlan: Annotate FDB data races
      CVE-2025-38086: net: ch9200: fix uninitialised access during mii_nway_restart
      CVE-2025-38090: drivers/rapidio/rio_cm.c: prevent possible heap overwrite
      CVE-2025-38103: HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
      CVE-2025-38111: net/mdiobus: Fix potential out-of-bounds read/write access
      CVE-2025-38115: net_sched: sch_sfq: fix a potential crash on gso_skb handling
      CVE-2025-38145: soc: aspeed: Add NULL check in aspeed_lpc_enable_snoop()
      CVE-2025-38147: calipso: Don't call calipso functions for AF_INET sk.
      CVE-2025-38157: wifi: ath9k_htc: Abort software beacon handling if disabled
      CVE-2025-38163: f2fs: fix to do sanity check on sbi->total_valid_block_count
      CVE-2025-38173: crypto: marvell/cesa - Handle zero-length skcipher requests
      CVE-2025-38174: thunderbolt: Do not double dequeue a configuration request
      CVE-2025-38180: net: atm: fix /proc/net/atm/lec handling
      CVE-2025-38181: calipso: Fix null-ptr-deref in calipso_req_{set,del}attr().
      CVE-2025-38184: tipc: fix null-ptr-deref when acquiring remote ip of ethernet bearer
      CVE-2025-38185: atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      CVE-2025-38190: atm: Revert atm_account_tx() if copy_from_iter_full() fails.
      CVE-2025-38194: jffs2: check that raw node were preallocated before writing summary
      CVE-2025-38200: i40e: fix MMIO write access to an invalid page in i40e_clear_hw
      CVE-2025-38203: jfs: Fix null-ptr-deref in jfs_ioc_trim
      CVE-2025-38204: jfs: fix array-index-out-of-bounds read in add_missing_indices
      CVE-2025-38212: ipc: fix to protect IPCS lookups using RCU
      CVE-2025-38213: vgacon: Add check for vc_origin address range in vgacon_scroll()
      CVE-2025-38219: f2fs: prevent kernel warning due to negative i_nlink from corrupted image
      CVE-2025-38222: ext4: inline: fix len overflow in ext4_prepare_inline_data
      CVE-2025-38237: media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()
      CVE-2025-38285: bpf: Fix WARN() in get_bpf_raw_tp_regs
      CVE-2025-38286: pinctrl: at91: Fix possible out-of-boundary access
      CVE-2025-38312: fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()
      CVE-2025-38313: bus: fsl-mc: fix double-free on mc_dev
      CVE-2025-38320: arm64/ptrace: Fix stack-out-of-bounds read in regs_get_kernel_stack_nth()
      CVE-2025-38323: net: atm: add lec_mutex
      CVE-2025-38324: mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      CVE-2025-38328: jffs2: check jffs2_prealloc_raw_node_refs() result in few other places
      CVE-2025-38336: ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
      CVE-2025-38337: jbd2: fix data-race and null-ptr-deref in jbd2_journal_dirty_metadata()
      CVE-2025-38344: ACPICA: fix acpi parse and parseext cache leaks
      CVE-2025-38345: ACPICA: fix acpi operand cache leak in dswstate.c
      CVE-2025-38346: ftrace: Fix UAF when lookup kallsym after ftrace disabled
      CVE-2025-38348: wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()

Best regards,
Ulrich Hecht

