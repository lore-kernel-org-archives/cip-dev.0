Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D806C0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 10:16:00 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web11.7731.1739441751331625005
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 02:15:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=f3vtk97C;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=7dEG7O/q;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1739441732; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OudHsPgq5iLYh8/Brg72ERpEKV1he0HlZtnpgbZOiEsnu6+4SR2eujtFRthLK8QzjD
    YOo0zHDOc8jued1wLnT0Xx2T71rM5fsxc99sFkxYx5sd72G3xZkuTM8gjBRYCvbmWpKq
    LtsLnGcch+pc9YWpdVRGkVq1iSfDehQEyttQBQOpc/A003HKlhXpyfjYIr4wLMe33H5t
    96S23vwjliZaUKgs8zdqHqlIJn3MR2Mjpqd0hEVB6qYsW1hULPSpDUFI+suiSyjSxV7k
    DWITH3tyEFimQASxqdTk/fIrZz/8YOuxNP6hXGQcZ3QR0h95FtpMBJKXvlUPI1HHHbyD
    bXvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1739441732;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=JQDQHS/HiP0/SqMSS7H2coRsMlGLOBJr29Z7hWnDI54=;
    b=Zc+wv+wpebOo3O5EFG/YtxhY/usAq3IQWhdeDuoY+d5UPjb4iYdTpZNRptNQaGGVja
    wBzDfU+esVCkxWmbLP4q7QtQJDHO0HmfpnEduhbvXgR9QYyNr8fh54uDifjCaO3UIrO1
    R0XHpGAPRJpin66zQILuGOCIOOC0Nir3eySYPjMuuvrGCtJz1CsO+8bXQM2trF59SNGi
    lYMljb5Euc/fYAvXyPJ3PP4zmvRmj3Jgh3Pv8kJQjTxEkg58G/U9/uyIq0USFSAs0f4/
    N7keSJzKZpIoRy7jONwKnAtinJQ49N7cVI7k6Gleutd2nLeVW+3zi8gXOe4XfXDlBfPA
    yfrA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1739441732;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=JQDQHS/HiP0/SqMSS7H2coRsMlGLOBJr29Z7hWnDI54=;
    b=f3vtk97Ct6QSyK3CRlRfkY99mkbsOH/OG3GmYw0IMwkUu37XNjny1f/ryA3BD5amZN
    BDXKaYKlZp0OanwY7oG1XcJr4XR3hAvhZK6AejRa43j4owTvFocuXJxNAaSFXPNYiBhI
    YMm3rkAkqY4oHLae656VW6MYYkY7i9Kx86N5zW9QT7mgcrNLm+Zr2TMwLMSRKA86aHYu
    07yvmtsyhAky58kD6Nh0Og6//vlDpTSzGGd8efSvDxMje7V990oAgIqlMvv6cVB3amCQ
    t5aspG1bTr46732QZ99MnSJAKWnigD/adzjXXAH1uEYVX4JQV8xQb6fOMe2ToLcm7akN
    E//w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1739441732;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=JQDQHS/HiP0/SqMSS7H2coRsMlGLOBJr29Z7hWnDI54=;
    b=7dEG7O/qmaZDiksAZw/2PDFEvhUMrXjY06X0+slTMBt24y+j9KBVMjZnJy4MYg/qtE
    thbo7P85iTrHwfBCH0Cg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411DAFVPzk
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 13 Feb 2025 11:15:31 +0100 (CET)
Date: Thu, 13 Feb 2025 11:15:31 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <910511258.1079584.1739441731937@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip96
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 10:16:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17827

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip96. The linux-4.4.y-cip tree's base version has been updated to v4.4-st61. The trees are up-to-date with kernel 4.19-st1. This is the first release based on the CIP-maintained 4.19 patch stream.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip96:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      8ad5b181aef5c015360b738860b42f15d23ea8fe
    Fixed CVEs:
      CVE-2024-50051: spi: mpc52xx: Add cancel_work_sync before module remove
      CVE-2024-52332: igb: Fix potential invalid memory access in igb_init_module()
      CVE-2024-53198: xen: Fix the issue of resource not being properly released in xenbus_dev_probe()
      CVE-2024-53680: ipvs: fix UB due to uninitialized stack access in ip_vs_protocol_init()
      CVE-2024-56574: media: ts2020: fix null-ptr-deref in ts2020_probe()
      CVE-2024-56587: leds: class: Protect brightness_show() with led_cdev->led_access mutex
      CVE-2024-56595: jfs: add a check to prevent array-index-out-of-bounds in dbAdjTree
      CVE-2024-56596: jfs: fix array-index-out-of-bounds in jfs_readdir
      CVE-2024-56597: jfs: fix shift-out-of-bounds in dbSplit
      CVE-2024-56598: jfs: array-index-out-of-bounds fix in dtReadFirst
      CVE-2024-56601: net: inet: do not leave a dangling sk pointer in inet_create()
      CVE-2024-56603: net: af_can: do not leave a dangling sk pointer in can_create()
      CVE-2024-56605: Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()
      CVE-2024-56606: af_packet: avoid erroring out after sock_init_data() in packet_create()
      CVE-2024-56619: nilfs2: fix potential out-of-bounds memory access in nilfs_find_entry()
      CVE-2024-56630: ocfs2: free inode when ocfs2_get_init_inode() fails
      CVE-2024-56637: netfilter: ipset: Hold module reference while requesting a module
      CVE-2024-56643: dccp: Fix memory leak in dccp_feat_change_recv
      CVE-2024-56650: netfilter: x_tables: fix LED ID check in led_tg_check()
      CVE-2024-56659: net: lapb: increase LAPB_HEADER_LEN
      CVE-2024-56670: usb: gadget: u_serial: Fix the issue that gs_start_io crashed due to accessing null pointer
      CVE-2024-56767: dmaengine: at_xdmac: avoid null_prt_deref in at_xdmac_prep_dma_memset
      CVE-2024-56769: media: dvb-frontends: dib3000mb: fix uninit-value in dib3000_write_reg
      CVE-2024-56779: nfsd: fix nfs4_openowner leak when concurrent nfsd4_open occur
      CVE-2024-56781: powerpc/prom_init: Fixup missing powermac #size-cells
      CVE-2024-57802: netrom: check buffer length before accessing it
      CVE-2024-57849: s390/cpum_sf: Handle CPU hotplug remove during sampling
      CVE-2024-57850: jffs2: Prevent rtime decompress memory corruption
      CVE-2024-57931: selinux: ignore unknown extended permissions
      CVE-2024-57938: net/sctp: Prevent autoclose integer overflow in sctp_association_init()

Best regards,
Ulrich Hecht

