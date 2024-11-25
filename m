Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1458CD3B7E5
	for <webhook@archiver.kernel.org>; Mon, 25 Nov 2024 07:50:52 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web10.14213.1732521043176851768
 for <cip-dev@lists.cip-project.org>;
 Sun, 24 Nov 2024 23:50:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ke8yUxkv;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=mfdT7QA7;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1732521028; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SdAFP6EEWulzLVcTffnQQ0E6C9gWRUi1YSp/teVfgzwPzPLXWPsx/kNuHkKOyczhl2
    +LX5yMsKJV6mCWkLHcfwzXfhc9nTnS/p6KxfnqF3AxIji8WCfRmj5qgjbATYm9nFpKbK
    TGbXbWyGpi7UKtVNQM0Yqwx4FMuIMTAy160sGPDTmMJV71CV1UXbPqGxTosZ7nuhdnQc
    e3nkj0clDyO8Bmp6C9Oet+m/FKD+GwNFQsEQrprjeUXsOIMWdoRUbo6iffnlg9U0DmdY
    gQ6mUw4uq7DTm6YUwA6ccrBLweNwNVLaSKEwNWkDSBvqjaruNSkdEHhVBS2MeeBhkidK
    3/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1732521028;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yxBDy3wkG6WTYQz7rDor+5YtC28SJpOR0W+lyW+POec=;
    b=scKxdfZE3VIR5qFELmqDCI23pCC5+haXBdGUbf41Ow2DR2UYRq8hCRaK2iIgi6eD4j
    YN+bXYVOJMJrPVyF5PWniRS8FZVhH/TKvkzl+AcWan7UQIPJQnCPKKtNF5Wsx25YSlpV
    Esmsz6QrmSkx90EtAXsDBjRbF0BMk/DkQmbv/4rzZlclA4kcaPTx3N6013qBlEufDKSm
    cz7Um14/n4lzbMJU1/3cT89tyb4HBcx4M1OQPrYOsVrQGk8wv59ZMepj5KhrXaoCXR7A
    nazdDXdtSDB/PLB78TsS4cZ5WaLcGZgEnaGqb92BYJUDzl25x/XyyZBxbICPQ2Uo4J9B
    QwFQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1732521028;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yxBDy3wkG6WTYQz7rDor+5YtC28SJpOR0W+lyW+POec=;
    b=ke8yUxkv3kPwYPYc2H9b/wtFI52oxJO+w3lMNnXGGHXx9bqDYKqpF41QfE7YUnk5ju
    48Mlf+C4LtasdV93AKzIyupAjed8bnq9RfM8+swUcyHq5cCBv7ryfMyE54tN8mozV38G
    jVlGrnp3R8nDApmwhhRLP+mt3Il00GptzM4+pMU6CQZ6Yw3bpeuPmnodaoUszaVhYPXe
    n/t5J2iF8UB/R6At/hPlQZpZjA2BmgkqceKtF7GulvXWdIyrlapFk6KBn2D0SSOhDSQo
    3wfd7eBetaPwKEe29j+4sRBS5nyU6BRSUezvSFjKGLXGXaZsMY9/6xFQV9XOGQcEypuf
    juXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1732521028;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yxBDy3wkG6WTYQz7rDor+5YtC28SJpOR0W+lyW+POec=;
    b=mfdT7QA7nxuYT/4APMGn15aa5HSq4b9Y9JLfDbV0YtzMgCJcfsdaNaL21NLNmDQ0I/
    aW1RFN857hBEXC+PJSAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRNGvSKC"
Received: from ox-live-app405.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.11 AUTH)
    with ESMTPSA id z9fbae0AP7oRSk9
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 25 Nov 2024 08:50:27 +0100 (CET)
Date: Mon, 25 Nov 2024 08:50:27 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <180861014.5482474.1732521027383@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip93
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev69
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Nov 2024 07:50:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17271

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip93. The linux-4.4.y-cip tree's base version has been updated to v4.4-st58. The trees are up-to-date with kernel 4.19.323.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip93:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      aff4b8627185bd8c90c772c56528bcd5639a6c33
    Fixed CVEs:
      CVE-2022-48910: net: ipv6: ensure we call ipv6_mc_down() at most once
      CVE-2022-48938: CDC-NCM: avoid overflow in sanity checking
      CVE-2023-52917: ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
      CVE-2024-40953: KVM: Fix a data race on last_boosted_vcpu in kvm_vcpu_on_spin()
      CVE-2024-41016: ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()
      CVE-2024-42229: crypto: aead,cipher - zeroize key buffer after use
      CVE-2024-44931: gpio: prevent potential speculation leaks in gpio_device_get_desc()
      CVE-2024-47670: ocfs2: add bounds checking to ocfs2_xattr_find_entry()
      CVE-2024-47679: vfs: fix race between evice_inodes() and find_inode()&iput()
      CVE-2024-47685: netfilter: nf_reject_ipv6: fix nf_reject_ip6_tcphdr_put()
      CVE-2024-47697: drivers: media: dvb-frontends/rtl2830: fix an out-of-bounds write error
      CVE-2024-47698: drivers: media: dvb-frontends/rtl2832: fix an out-of-bounds write error
      CVE-2024-47699: nilfs2: fix potential null-ptr-deref in nilfs_btree_insert()
      CVE-2024-47701: ext4: avoid OOB when system.data xattr changes underneath the filesystem
      CVE-2024-47723: jfs: fix out-of-bounds in dbNextAG() and diAlloc()
      CVE-2024-47737: nfsd: call cache_put if xdr_reserve_space returns NULL
      CVE-2024-47740: f2fs: Require FMODE_WRITE for atomic write ioctls
      CVE-2024-47747: net: seeq: Fix use after free vulnerability in ether3 Driver Due to Race Condition
      CVE-2024-47749: RDMA/cxgb4: Added NULL check for lookup_atid
      CVE-2024-47757: nilfs2: fix potential oob read in nilfs_btree_check_delete()
      CVE-2024-49860: ACPI: sysfs: validate return type of _STR method
      CVE-2024-49867: btrfs: wait for fixup workers before stopping cleaner kthread during umount
      CVE-2024-49877: ocfs2: fix possible null-ptr-deref in ocfs2_set_buffer_uptodate
      CVE-2024-49881: ext4: update orig_path in ext4_find_extent()
      CVE-2024-49882: ext4: fix double brelse() the buffer of the extents path
      CVE-2024-49883: ext4: aovid use-after-free in ext4_ext_insert_extent()
      CVE-2024-49884: ext4: fix slab-use-after-free in ext4_split_extent_at()
      CVE-2024-49900: jfs: Fix uninit-value access of new_ea in ea_buffer
      CVE-2024-49902: jfs: check if leafidx greater than num leaves per dmap tree
      CVE-2024-49903: jfs: Fix uaf in dbFreeBits
      CVE-2024-49924: fbdev: pxafb: Fix possible use after free in pxafb_task()
      CVE-2024-49944: sctp: set sk_state back to CLOSED if autobind fails in sctp_listen_start
      CVE-2024-49948: net: add more sanity checks to qdisc_pkt_len_init()
      CVE-2024-49952: netfilter: nf_tables: prevent nf_skb_duplicated corruption
      CVE-2024-49957: ocfs2: fix null-ptr-deref when journal load failed.
      CVE-2024-49958: ocfs2: reserve space for inline xattr before attaching reflink tree
      CVE-2024-49959: jbd2: stop waiting for space when jbd2_cleanup_journal_tail() returns error
      CVE-2024-49962: ACPICA: check null return of ACPI_ALLOCATE_ZEROED() in acpi_db_convert_to_package()
      CVE-2024-49963: mailbox: bcm2835: Fix timeout during suspend mode
      CVE-2024-49965: ocfs2: remove unreasonable unlock in ocfs2_read_blocks
      CVE-2024-49967: ext4: no need to continue when the number of entries is 1
      CVE-2024-49975: uprobes: fix kernel info leak via "[uprobes]" vma
      CVE-2024-49982: aoe: fix the potential use-after-free problem in more places
      CVE-2024-49995: tipc: guard against string buffer overrun
      CVE-2024-49997: net: ethernet: lantiq_etop: fix memory disclosure
      CVE-2024-50006: ext4: fix i_data_sem unlock order in ext4_ind_migrate()
      CVE-2024-50007: ALSA: asihpi: Fix potential OOB array access
      CVE-2024-50008: wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_cmd_802_11_scan_ext()
      CVE-2024-50024: net: Fix an unsafe loop on the list
      CVE-2024-50035: ppp: fix ppp_async_encode() illegal access
      CVE-2024-50040: igb: Do not bring the device up after non-fatal error
      CVE-2024-50044: Bluetooth: RFCOMM: FIX possible deadlock in rfcomm_sk_state_change
      CVE-2024-50045: netfilter: br_netfilter: fix panic with metadata_dst skb
      CVE-2024-50076: vt: prevent kernel-infoleak in con_font_get()
      CVE-2024-50116: nilfs2: fix kernel bug due to missing clearing of buffer delay flag
      CVE-2024-50117: drm/amd: Guard against bad data for ATIF ACPI method
      CVE-2024-50142: xfrm: validate new SA's prefixlen using SA family when sel.family is unset
      CVE-2024-50143: udf: fix uninit-value use in udf_get_fileshortad
      CVE-2024-50148: Bluetooth: bnep: fix wild-memory-access in proto_unregister
      CVE-2024-50167: be2net: fix potential memory leak in be_xmit()
      CVE-2024-50168: net/sun3_82586: fix potential memory leak in sun3_82586_send_packet()
      CVE-2024-50171: net: systemport: fix potential memory leak in bcm_sysport_xmit()
      CVE-2024-50179: ceph: remove the incorrect Fw reference check when dirtying pages
      CVE-2024-50180: fbdev: sisfb: Fix strbuf array overflow
      CVE-2024-50195: posix-clock: Fix missing timespec64 check in pc_clock_settime()
      CVE-2024-50202: nilfs2: propagate directory read errors from nilfs_find_entry()
      CVE-2024-50218: ocfs2: pass u64 to ocfs2_truncate_inline maybe overflow
      CVE-2024-50230: nilfs2: fix kernel bug due to missing clearing of checked flag
      CVE-2024-50234: wifi: iwlegacy: Clear stale interrupts before resuming device
      CVE-2024-50237: wifi: mac80211: do not pass a stopped vif to the driver in .get_txpower
      CVE-2024-53057: net/sched: stop qdisc_tree_reduce_backlog on TC_H_ROOT

Best regards,
Ulrich Hecht

