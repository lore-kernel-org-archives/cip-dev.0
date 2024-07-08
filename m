Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC70BC3271E
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 12:59:07 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
 by mx.groups.io with SMTP id smtpd.web10.79033.1720443544886677266
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jul 2024 05:59:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=hZYPhfn3;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=dilPHene;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.164, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1720443529; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=p54bFAzvlSfzfMJMAyKY2EDCU0l0S/U2zhV2IFBNx6JWDxmwdrlVxMsmsEX2EsOs2O
    DpJI/NYjT93J8JYfuJOs2ESrffoQ+gk4AtNDS8bo24lQJxwRpjG7MAIo7FQYpmUXMSyH
    z1G76JDB3Aka8of0S8RR2gVeeIFHGZ/Wn+Ga1eVbbZNBBssdfmVoxlp3dbSL9WHeQlK4
    CrThmB88fcUz7Q+3nOQLBtBEuoZYPTIHJPEjNYJltmLdfINtlhvys5O4xmigZ3e94uw4
    gQYp9wQF5sgjzz46vwXE5yhlvKTwvQ7H5FHQ6uXVSyABedIQ/XMjmmy8p5dUva8uvI27
    jy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1720443529;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rmHxuVgqLRa3Emf039hHCRtiumoXLHSknDUXVoThTY8=;
    b=L8B0R+sE8EtBJXSQHn1ewEEDcmZkztWJqtygxaY3wjIkegsqxm1sMcBKSS6I4Rgw/1
    YiiZiF7lkxxjlW2TuHKIYxthBbf/GhDyvsfWOa+2ImpNvugTYpl1LfadmRC7U7zrxouM
    QXmfUjxOFekbcPPtM2oLXt4nE11/ehesMgV5f152z228HUy0QeiLsMjySi5Mh7jZMFN9
    wf9UR8oz9UP8pW3aow7W5vfnKhlrl7eacPKAVSOk2oPm5ZPVn3u7bNj+c0nv2YY2Am4E
    iqGzVv/5WFl1BfUJje6Hk6kJfjrroqDK+52or24zGdHMM4QazxhUDEcFy2JvblVfGg9P
    5gZg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1720443529;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rmHxuVgqLRa3Emf039hHCRtiumoXLHSknDUXVoThTY8=;
    b=hZYPhfn3HSAvGCdbNBDNaOi9y7M8fdz0YOxVKut1Ggf8MwblyVW8EzXiYwIGyZY3sA
    5Vq/+TFAGhBIwco6IksFdLE2Af0MYYl22E0hwajLwoXDriZMwEU+WkcWuRJYAEPpoX8o
    0jsVVeSSljdBNbu3U9dDg4xwRISJFqyXmolTPs/mbZrnYLH4aq3c2SAR4Ov9fxjc/2v0
    Uf5NH0mMhESA2LGhN5SMI6mRYwKc+1fhRUDnqCCZzYNWHz1ZJrOEauG/Tl6MsCpPgp1h
    yXmAhRJVNvJISoIrCWX8eb9KvpKMnn/Wu2x5P9KHAZOfoCdd5ji7V8EvnNQLu01bSuSa
    z1Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1720443529;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=rmHxuVgqLRa3Emf039hHCRtiumoXLHSknDUXVoThTY8=;
    b=dilPHene4Cpn8jmoTO6vv8734bB4gtGbexi9Gk+XP+C6KAowtUmP3MfPS0L8Y/NHQq
    Oj0TlR976r+1xc2nOjCA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqtq89k3mYUlHMXIUnKaGpnZCxmxho2QT"
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z07fa7068CwmtPE
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 8 Jul 2024 14:58:48 +0200 (CEST)
Date: Mon, 8 Jul 2024 14:58:48 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <874031301.1546525.1720443528671@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip89
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev66
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 12:59:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16434

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip89. The linux-4.4.y-cip tree's base version has been updated to v4.4-st54. The trees are up-to-date with kernel 4.19.316.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip89:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      66bc7bd5b1c1d589edc9f96367624555b4684837
    Fixed CVEs:
      CVE-2024-33621: ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_outbound
      CVE-2024-36286: netfilter: nfnetlink_queue: acquire rcu_read_lock() in instance_destroy_rcu()
      CVE-2024-37356: tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
      CVE-2024-38381: nfc: nci: Fix uninit-value in nci_rx_work
      CVE-2024-38583: nilfs2: fix use-after-free of timer for log writer thread
      CVE-2024-38621: media: stk1160: fix bounds checking in stk1160_copy_video()
      CVE-2024-38627: stm class: Fix a double free in stm_register_device()
      CVE-2024-38633: serial: max3100: Update uart_driver_registered on driver removal
      CVE-2024-38634: serial: max3100: Lock port->lock when calling uart_handle_cts_change()
      CVE-2024-38659: enic: Validate length of nl attributes in enic_set_vf_port
      CVE-2024-39292: um: Add winch to winch_handlers before registering winch IRQ
      CVE-2024-39301: net/9p: fix uninit-value in p9_client_rpc()
      CVE-2024-39475: fbdev: savage: Handle err return when savagefb_check_var failed
      CVE-2024-39480: kdb: Fix buffer overflow during tab-complete

Best regards,
Ulrich Hecht

