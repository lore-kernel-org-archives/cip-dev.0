Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1939BC83F26
	for <webhook@archiver.kernel.org>; Wed, 30 Jul 2025 15:03:32 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web10.37709.1753887808510363607
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Jul 2025 08:03:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=bNi5qolS;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=lxPOhdtF;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1753887782; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UdWg6tl2Yva74+isxkmhq3LN/DRZFmnFY0Jq9EZ4OKY+70KbbhhJ4XN9Rcg+4sywcR
    qYGDbfColZNe0eDNCzgq2Ahv2JiJzPfE/XMt0b2HuLr9uB9gICjDJftu8WKRG45oBt/I
    bYv4P3tlyu3jpe+Xld+SxG3zIx6/5Y4twRfNSAAI5vpvqRohxi0PPd666saGIWfNjI52
    CxwCPe6o6eDzb1KnVmjcFHWa2BNoCxk2IkhTEppeVYgGjqok5bbcWboOzTnpJrHld72H
    o91UxPzKQhzThzPBHSj6/Dw/Fw6pzPmXiTg00i0PpPNkJ1zyIm6Wom9J1S3QlKdFVrqZ
    XfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1753887782;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lv0uA+BVJoAXtWIdSpHhBmTT+cj3lpUEh9gNDXuCqow=;
    b=K4QRSN0DLqdI8QY65GY6Aq9wGfn0V4zVrLNSQ26DII/qA8f69D8U0Yn8BXrTZAu0dn
    YSQdalh4pVVqIJ3fz5mOe2G7/pixwpyIg8V63dI5kCTLndd98qNnk4so9BEqM56Vcy/0
    wOvmc8neMTPSq7e0pe2zKxxANjafjMR9nhJjj/KWp36ZHon2+DQzfNXr3WiA/pVj1o1f
    PKwSVaofjXmtpl3jiekCGMBrfSBF81aa1xrUKl0kFeUVCVIfh9zVOXkeasGcu6stHREb
    JemFmmzOjXkqV1/L1JHhoI+B/2E6RuwAaMFTrvJt3UKzv388H60o9ANhkBYPARFe/kWk
    HOZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753887782;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lv0uA+BVJoAXtWIdSpHhBmTT+cj3lpUEh9gNDXuCqow=;
    b=bNi5qolS6f814qD2D89QYt4dhBw4q4ESgnMmUVWNqYNC12sVd2g2Ixh9vWUlOdAyyT
    rBh4A2M+TV87CB1sHbGhvTrqNIHTmCV+ojlqevv1PCFYM2SfEBpw+seGN1j5V3HePZKL
    3e9TZRnHVPmpjiiggUUtTrs9pdG/Y9ZrEHknIDiMiMMBiEyEA1gZ6+UuJ8DYczJNz3RD
    iZjjgPRbwRlUrR0c9q8jRCwVJW52nKgmtVTZRt3sZu80it358mj/V2OOlOmPRUvUtHRI
    Es/IC/YZoy5EJ6PaqcKotmkYqDxAzt/FGwy3E3YntH+cDG6K+DzRwa208PsZnXwqXbGl
    yY9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753887782;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=lv0uA+BVJoAXtWIdSpHhBmTT+cj3lpUEh9gNDXuCqow=;
    b=lxPOhdtFyok813kPgNIL+6G1Im+zSHU2L/AwuLcm3Z002+IvLGRJK3TOeMbDkogRXV
    ILvx8YIZDWgttyDb5vAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hewKXd5F4sJQ=="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6216UF32kcL
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 30 Jul 2025 17:03:02 +0200 (CEST)
Date: Wed, 30 Jul 2025 17:03:01 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <94393326.229891.1753887781950@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip101
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.55
X-Originating-Port: 51860
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 30 Jul 2025 15:03:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19622

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip101. The linux-4.4.y-cip tree's base version has been updated to v4.4-st66. The trees are up-to-date with kernel 4.19-st6.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip101:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      4668c6cf3c626dd03cd2211a68e6b01b322891d5
    Fixed CVEs:
      CVE-2023-53140: scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
      CVE-2024-49903: jfs: Fix uaf in dbFreeBits
      CVE-2022-21546: scsi: target: Fix WRITE_SAME No Data Buffer crash
      CVE-2022-48828: NFSD: Fix ia_size underflow
      CVE-2022-48829: NFSD: Fix NFSv3 SETATTR/CREATE's handling of large file sizes
      CVE-2025-37923: tracing: Fix oob write in trace_seq_to_buffer()
      CVE-2025-37990: wifi: brcm80211: fmac: Add error handling for brcmf_usb_dl_writeimage()
      CVE-2025-37995: module: ensure that kobject_put() is safe for module type kobjects
      CVE-2025-37998: openvswitch: Fix unsafe attribute parsing in output_userspace()
      CVE-2025-38037: vxlan: Annotate FDB data races
      CVE-2025-38051: smb: client: Fix use-after-free in cifs_fill_dirent
      CVE-2025-38058: __legitimize_mnt(): check for MNT_SYNC_UMOUNT should be under mount_lock
      CVE-2025-38061: net: pktgen: fix access outside of user given buffer in pktgen_thread_write()
      CVE-2025-38066: dm cache: prevent BUG_ON by blocking retries on failed device resumes
      CVE-2025-38075: scsi: target: iscsi: Fix timeout on deleted connection
      CVE-2025-38079: crypto: algif_hash - fix double free in hash_accept
      CVE-2025-38086: net: ch9200: fix uninitialised access during mii_nway_restart
      CVE-2025-38103: HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
      CVE-2025-38115: net_sched: sch_sfq: fix a potential crash on gso_skb handling
      CVE-2025-38157: wifi: ath9k_htc: Abort software beacon handling if disabled
      CVE-2025-38180: net: atm: fix /proc/net/atm/lec handling
      CVE-2025-38185: atm: atmtcp: Free invalid length skb in atmtcp_c_send().
      CVE-2025-38194: jffs2: check that raw node were preallocated before writing summary
      CVE-2025-38200: i40e: fix MMIO write access to an invalid page in i40e_clear_hw
      CVE-2025-38203: jfs: Fix null-ptr-deref in jfs_ioc_trim
      CVE-2025-38204: jfs: fix array-index-out-of-bounds read in add_missing_indices
      CVE-2025-38212: ipc: fix to protect IPCS lookups using RCU
      CVE-2025-38213: vgacon: Add check for vc_origin address range in vgacon_scroll()
      CVE-2025-38222: ext4: inline: fix len overflow in ext4_prepare_inline_data
      CVE-2025-38237: media: platform: exynos4-is: Add hardware sync wait to fimc_is_hw_change_mode()
      CVE-2025-38286: pinctrl: at91: Fix possible out-of-boundary access
      CVE-2025-38312: fbdev: core: fbcvt: avoid division by 0 in fb_cvt_hperiod()
      CVE-2025-38323: net: atm: add lec_mutex
      CVE-2025-38324: mpls: Use rcu_dereference_rtnl() in mpls_route_input_rcu().
      CVE-2025-38328: jffs2: check jffs2_prealloc_raw_node_refs() result in few other places
      CVE-2025-38336: ata: pata_via: Force PIO for ATAPI devices on VT6415/VT6330
      CVE-2025-38344: ACPICA: fix acpi parse and parseext cache leaks
      CVE-2025-38345: ACPICA: fix acpi operand cache leak in dswstate.c
      CVE-2025-38348: wifi: p54: prevent buffer-overflow in p54_rx_eeprom_readback()
      CVE-2025-38352: posix-cpu-timers: fix race between handle_posix_cpu_timers() and posix_cpu_timer_del()
      CVE-2025-38415: Squashfs: check return result of sb_min_blocksize
      CVE-2025-38416: NFC: nci: uart: Set tty->disc_data only in success path
      CVE-2025-38420: wifi: carl9170: do not ping device which has failed to load firmware
      CVE-2025-38428: Input: ims-pcu - check record size in ims_pcu_flash_firmware()

Best regards,
Ulrich Hecht

