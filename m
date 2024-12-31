Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6879E77188
	for <webhook@archiver.kernel.org>; Tue, 31 Dec 2024 01:53:15 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web11.75776.1735609987827503686
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Dec 2024 17:53:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=d/YLT5dD;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=XPs/45qr;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1735609968; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qYRHVEurDPD8UdWpb5wFo9EXeUBJyfyNtZiIz/A0Xrr490nQnlt61f9a31Evzuk+Ty
    JjPkTlhZO+NORJTkBrIrGNL6HQVxqfAtkHxMvnCYrShIl+ULSdaeDz/EuPfjZLOUFjNp
    rsLbNPLRm/M8kdZnittBorsfg6v9I+Dmh7dD0pPdwJk9ddg4WzJq0zjTe7O4k41BxrwD
    w0vo4h+1PuLqGE4CF3Bjjdzs9147yy/bd45I47F/QVdvyhlfBzb9DFj9z5GqkXK2r9IX
    ad4uRcn3OW0DRhg3dEVZTFHDS6nzSUXhjRISdVWQm9o6cIw9D8HbrdWivev6hE/2XBOT
    EhLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1735609968;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=QHisESSl4paU2yXI200vVFD17rjjec4LsBbSmKkUV7A=;
    b=ADOp78uVCD5p9fjKfoH+4zAGS5ewAwhT78pg62q7RSmQxV5w2DkdwLXzk5xJPAqAdP
    8fAcOWVIgvayYKY89IpKJeJXzJwsnAlokkwwl3oC5OvLvfdDdgB85cNVyTbJBARRIXr3
    uCFj2wfBiQvgn0WjBnH6va37c1CUsn0jb5aZsfeh47bNHIQNVyrUrJfC6pNZFT57xA/s
    udJ8Kc8EKLyxFZ0MLM+CTHji24pDSD30+jxRPbq6a9WsCB9bjWv1v/biYHLLS1+40Ylj
    gNctVVkld4MKWkWjk2YmUb2/4SJDTI/FqDvG8uxMIq97U6MFb7L0+PNFbqnbc+r3hbH2
    8pHA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1735609968;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=QHisESSl4paU2yXI200vVFD17rjjec4LsBbSmKkUV7A=;
    b=d/YLT5dDJn/cstmB2WcoRcaTbntiDn9B7Tx+h2gZzPuCS3jtxdE+Lg3WQzg1gef8Wi
    PCiJzYUhrw0eyLrEb80bamVTTIH46bGB2xZ10Zv7q6A4wuttBmDCPgiITb8JQAOyYail
    GRr5bG/NfQMOBODDLjsi/RvU+SaZAMld8bJB9fdsEEqqQdGCMp0SVGIbsePS0nKItgD7
    RupqvkfksS9zznsuhtJJ4daPgD5o/M9QHGQ5VU0Js/1lITvS25TFD5Eg2HrP9FP/2+5v
    SDiQAsRQjyUiwpMCug4NgO5Yu0sUv2LfsqcjLDq/mLV6MTx6cxhfPi+3GQ2crP1dkFCK
    JE1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1735609968;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=QHisESSl4paU2yXI200vVFD17rjjec4LsBbSmKkUV7A=;
    b=XPs/45qrVYVkWVxzB2V4SfOBVb0GQ/kuO7Xa1O46wF9yBRcEu8m+OxyCVYSZMJsv7u
    PCTLIbWDgtiroHk1lYBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvtKuIw=="
Received: from ox-live-app203.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.16 AUTH)
    with ESMTPSA id zbe2f00BV1qmXT8
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 31 Dec 2024 02:52:48 +0100 (CET)
Date: Tue, 31 Dec 2024 02:52:48 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1770493541.577346.1735609968836@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip95
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev70
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 31 Dec 2024 01:53:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17499

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip95. The linux-4.4.y-cip tree's base version has been updated to v4.4-st60. The trees are up-to-date with kernel 4.19.325. This is the last release based on the 4.19 patch stream.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip95:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      e5854dd66f4cefaef834acb89a4c3eec0eb8f1f7
    Fixed CVEs:
      CVE-2022-49034: sh: cpuinfo: Fix a warning for CONFIG_CPUMASK_OFFSTACK
      CVE-2024-53112: ocfs2: uncache inode which has failed entering the group
      CVE-2024-53127: Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"
      CVE-2024-53130: nilfs2: fix null-ptr-deref in block_dirty_buffer tracepoint
      CVE-2024-53131: nilfs2: fix null-ptr-deref in block_touch_buffer tracepoint
      CVE-2024-53140: netlink: terminate outstanding dump on socket close
      CVE-2024-53141: netfilter: ipset: add missing range check in bitmap_ip_uadt
      CVE-2024-53142: initramfs: avoid filename buffer overrun
      CVE-2024-53156: wifi: ath9k: add range check for conn_rsp_epid in htc_connect_service()
      CVE-2024-53157: firmware: arm_scpi: Check the DVFS OPP count returned by the firmware
      CVE-2024-53165: sh: intc: Fix use-after-free bug in register_intc_controller()
      CVE-2024-53172: ubi: fastmap: Fix duplicate slab cache names while attaching
      CVE-2024-53173: NFSv4.0: Fix a use-after-free problem in the asynchronous open()
      CVE-2024-53183: um: net: Do not use drvdata in release
      CVE-2024-53184: um: ubd: Do not use drvdata in release
      CVE-2024-53194: PCI: Fix use-after-free of slot->bus on hot remove
      CVE-2024-53197: ALSA: usb-audio: Fix potential out-of-bound accesses for Extigy and Mbox devices
      CVE-2024-53214: vfio/pci: Properly hide first-in-list PCIe extended capability
      CVE-2024-53217: NFSD: Prevent NULL dereference in nfsd4_process_cb_update()
      CVE-2024-53227: scsi: bfa: Fix use-after-free in bfad_im_module_exit()
      CVE-2024-56531: ALSA: caiaq: Use snd_card_free_when_closed() at disconnection
      CVE-2024-56532: ALSA: us122l: Use snd_card_free_when_closed() at disconnection
      CVE-2024-56539: wifi: mwifiex: Fix memcpy() field-spanning write warning in mwifiex_config_scan()
      CVE-2024-56548: hfsplus: don't query the device logical block size multiple times
      CVE-2024-56690: crypto: pcrypt - Call crypto layer directly when padata_do_parallel() return -EBUSY
      CVE-2024-56700: media: wl128x: Fix atomicity violation in fmc_send_cmd()

Best regards,
Ulrich Hecht

