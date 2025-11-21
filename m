Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5A3CFA75F
	for <webhook@archiver.kernel.org>; Fri, 21 Nov 2025 09:17:55 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.7926.1763716670919138936
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Nov 2025 01:17:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=EiHltfvb;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=BJh1ajTc;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1763716647; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rkQfcRuBQHRIVnddE2aI/lyP5jwzeHon5webZRyR6WyIOC5ml4Df+jUEeO+NrjAjKE
    KLtYXMfW8g5lyH+/zoCm5KXE9+nV31L0kJp4hoTd3OZpOjHHND35ISDvmbiPzfizaeLn
    au6yizN/2408hW9aJiCw9nrlVILWCABsyIiYzdczKS02FHDF7Z4Wj79Yrg4kvTE5fT61
    qavMezPvXYnFP/L5LDSfp6ai/BuYxl1/zmBH9jslI0U0SmWredQXWjyGLgot0B3zuuz4
    Q2tjSI+mbkv7EGAVUh97aCgo7G6HkRg8SnhROuHLrgNI53H3B0xrvgk00r/aH09501V6
    IwaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763716647;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rLtoab5FBGdOM0lNa46aGX1M5MDnC6twn3PbEKvziFs=;
    b=jfoM/YqnIgVQBXHZwGXLpglmAX0QFPNtLy+18iou+1xLa+l11jgHkyNTXwloVJqrvB
    v6WFmHrlas9EEXesuyBo1eRuXwXAwdKR1ZlVIEs6y2n74B3RZEr4f416wKpko+lSKW7V
    cvioI8v+oYrW8Iaa4LeL365K1u7lIPGgrd3i/JrsjT5msMESK12Znhvbhs5Xy+OxJcie
    r0qxDpw25ji9suqKlzSUEOSh5MUwa8IHnq2Pw35ac8L6PoU3phXw3zj4bf8YveifHnse
    p4PhRnQFpRHpsJj5UDtUiYfTmvCMmQpj9/5oS0VjFONM+KRJgrwJbXJ8/H6Iw7SBCmkF
    3cBw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763716647;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rLtoab5FBGdOM0lNa46aGX1M5MDnC6twn3PbEKvziFs=;
    b=EiHltfvbqxswtKzOwSbJiP4iaduPEnQk7wgBe/KKJZe2Mw93uccDhWkEBQhMM0czdm
    GcMyf/0a/CkWNse/TX8IUZ1BopBGmrStNgnyX/ArDT7gB+/gQvqnIxti1aAWDJZvEzT5
    hfvwfPYpKolzC2kA5wElrd7OMXVcJvB6q8RdkEHiq9RBPkSUOZ47OmWaUVlXh1o0agkv
    NPWB8RwgRYDgBtzhGELYvTc5tnI0+uO580S53Eo1JQ6fMxnpzDEN4IWVgA8UB1uVKtIk
    R4OdB6UBeexxYxynIFaLjSkI+9aqmV/P080NFX8I2J3Ycp5kqAPHQXlzq10Au5F4M/nh
    491A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763716647;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rLtoab5FBGdOM0lNa46aGX1M5MDnC6twn3PbEKvziFs=;
    b=BJh1ajTcS6S8/zpddmuN6lLyz/BsblN/ZEN6Pn1VAC79Yl+SPN9OUs1WC1ivvr0g86
    o61QFYyYhPQSUsrODADg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKPA+Dxtkn4="
Received: from open-xchange-core-mw-gw-21.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.0.0 AUTH)
    with ESMTPSA id zd62e41AL9HQ1Io
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 21 Nov 2025 10:17:26 +0100 (CET)
Date: Fri, 21 Nov 2025 10:17:26 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1877695858.116167.1763716646423@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip126
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 39622
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Nov 2025 09:17:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20676

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip126. The linux-4.19.y-cip tree's base version has been updated to v4.19-st10. The trees are up-to-date with kernel 5.4.301.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip126:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      f67c504655343a57dc76388946d47cbb487e7649
    Fixed CVEs:
      CVE-2025-22058: udp: Fix memory accounting leak.
      CVE-2025-39993: media: rc: fix races with imon_disconnect()
      CVE-2025-39994: media: tuner: xc5000: Fix use-after-free in xc5000_release
      CVE-2025-39995: media: i2c: tc358743: Fix use-after-free bugs caused by orphan timer in probe
      CVE-2025-39996: media: b2c2: Fix use-after-free causing by irq_check_work in flexcop_pci_remove
      CVE-2025-39998: scsi: target: target_core_configfs: Add length check to avoid buffer overflow
      CVE-2025-40001: scsi: mvsas: Fix use-after-free bugs in mvs_work_queue
      CVE-2025-40018: ipvs: Defer ip_vs_ftp unregister during netns cleanup
      CVE-2025-40026: KVM: x86: Don't (re)check L1 intercepts when completing userspace I/O
      CVE-2025-40027: net/9p: fix double req put in p9_fd_cancelled
      CVE-2025-40030: pinctrl: check the return value of pinmux_ops::get_function_name()
      CVE-2025-40035: Input: uinput - zero-initialize uinput_ff_upload_compat to avoid info leak
      CVE-2025-40042: tracing: Fix race condition in kprobe initialization causing NULL pointer dereference
      CVE-2025-40044: fs: udf: fix OOB read in lengthAllocDescs handling
      CVE-2025-40049: Squashfs: fix uninit-value in squashfs_get_parent
      CVE-2025-40055: ocfs2: fix double free in user_cluster_connect()
      CVE-2025-40070: pps: fix warning in pps_register_cdev when register device fail
      CVE-2025-40081: perf: arm_spe: Prevent overflow in PERF_IDX2OFF()
      CVE-2025-40087: NFSD: Define a proc_layoutcommit for the FlexFiles layout type
      CVE-2025-40088: hfsplus: fix slab-out-of-bounds read in hfsplus_strcasecmp()
      CVE-2025-40105: vfs: Don't leak disconnected dentries on umount
      CVE-2025-40106: comedi: fix divide-by-zero in comedi_buf_munge()
      CVE-2025-40112: sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
      CVE-2025-40115: scsi: mpt3sas: Fix crash in transport port remove by using ioc_info()
      CVE-2025-40116: usb: host: max3421-hcd: Fix error pointer dereference in probe cleanup
      CVE-2025-40118: scsi: pm80xx: Fix array-index-out-of-of-bounds on rmmod
      CVE-2025-40121: ASoC: Intel: bytcr_rt5651: Fix invalid quirk input mapping
      CVE-2025-40124: sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
      CVE-2025-40125: blk-mq: check kobject state_in_sysfs before deleting in blk_mq_unregister_hctx
      CVE-2025-40126: sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
      CVE-2025-40140: net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
      CVE-2025-40153: mm: hugetlb: avoid soft lockup when mprotect to large memory area
      CVE-2025-40154: ASoC: Intel: bytcr_rt5640: Fix invalid quirk input mapping
      CVE-2025-40167: ext4: detect invalid INLINE_DATA + EXTENTS flag combination
      CVE-2025-40173: net/ip6_tunnel: Prevent perpetual tunnel growth
      CVE-2025-40178: pid: Add a judgment for ns null in pid_nr_ns
      CVE-2025-40186: tcp: Don't call reqsk_fastopen_remove() in tcp_conn_request().
      CVE-2025-40187: net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
      CVE-2025-40188: pwm: berlin: Fix wrong register in suspend/resume
      CVE-2025-40190: ext4: guard against EA inode refcount underflow in xattr update
      CVE-2025-40198: ext4: avoid potential buffer over-read in parse_apply_sb_mount_options()
      CVE-2025-40200: Squashfs: reject negative file sizes in squashfs_read_inode()
      CVE-2025-40204: sctp: Fix MAC comparison to be constant-time
      CVE-2025-40205: btrfs: avoid potential out-of-bounds in btrfs_encode_fh()

Best regards,
Ulrich Hecht

