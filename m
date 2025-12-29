Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7DBD3B7E5
	for <webhook@archiver.kernel.org>; Mon, 29 Dec 2025 05:57:00 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38383.1766987815528675700
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Dec 2025 21:56:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=nC2o4eiL;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=+vrpxAFt;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1766987804; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Uyc99pVlQ2eBU0b/FyzsH493SibSxrTM2xzFtw5KlPe1JPL2gbk2/60/Y3yWwahaBh
    zo+t7jjCIGutA6WdnTapEyiMvZsVM4UxoXBYdw+flvT9AI8BrqOEIeYwkHlPSmEiAwCL
    +bjoFkJ46uY+deHK46vBFeA/CGIXYZNaqWHMdYi6Te6WSxhvMLIMqnRiSWAnIY2tYVle
    jGsayE/rOqxkEn9muQ8ISMVjUhbNtv7ueICAHQLlaVbwU+gKKHgoTdQYDVSiTBdv7JrT
    xilK/0SkI5qElNnl2lWKCbU92PyY1Op2M7/L51DqpukJj2wOZKwNWOhoVagJtVIjfN6k
    98dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766987804;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YCPO3BiZesVWDDDx4Df2IL1mUir6DQ4/Zk8rl3bCpKg=;
    b=H0SwyoPzeFc/+NLXi9342STnRz2AD3NCA0hLAsXgmH52ZVXbCPDnzDIAujScjQ14ka
    tLx8wIdnL1nJFNfLGgZa2afncIPJn2xkY+vSz7xP1Dmdo+GkfXkF3GpKuZKdigG7QboG
    XEIwzuP8GWHJFsqkn010/COMuCMi8XERXV7dvUZSjLkHeJV3QwKryT9csJ0XruBwA3Fd
    WUlZiV+cQhzJ/CEoo1WUK6mqrQZoF4Xb9I1NA6Mr5bPEjmjMt7RtT9DVhbAIIQw7g+BA
    q8vmig/5tMZKYrFE03emnI1XVcoqHMb3GYO5GNeo6CxvHUJzAR91+RIk0+HNK2xSy2hm
    xxLw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766987804;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YCPO3BiZesVWDDDx4Df2IL1mUir6DQ4/Zk8rl3bCpKg=;
    b=nC2o4eiLO4rQFk9TgQO50ldU/3DeEeIFc+nnOmsm16SmiWhrwoESlFsex9V0SJGd84
    Ug4t8gZ64iXPLL0xwOBp1tjZVzLGm9cIsVMvOaKRSDxFI41YjohyDO56hkYiS71fXglW
    LfywVuOT37+1oSMxxfYeN0m44JqOyW2EfLAH6kynKCtKeZ4z9u5ELpeTgqS5p/Ky/Gvh
    Lg3hR9mDYFzsGKRj8ZjNHMtt97tRLjAFVcihLBjqNLrnEhIDHSXfoheabPSQ4ownuh/z
    6Vrvw3s31mpXWBWZJF5uAfa2k0YrKoajYks+fMuGfeWmJZQ2UAQkJy7EuEbY6FsKqPyF
    cnlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766987804;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=YCPO3BiZesVWDDDx4Df2IL1mUir6DQ4/Zk8rl3bCpKg=;
    b=+vrpxAFtiK7IZ25Kd2xx9Q7IYnHcAOAsApfzndcNflnrYJ3sOM6ErHHJWdaaLwiIfY
    VauCjZ2hmVMeGgguydBg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-11.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda171BT5ui0oQ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 29 Dec 2025 06:56:44 +0100 (CET)
Date: Mon, 29 Dec 2025 06:56:44 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1675394165.12181.1766987804067@webmail.strato.de>
Subject: Request for review for 4.4-st71, 4.4-cip106
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 46500
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Dec 2025 05:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21222

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

eec045863d21a wifi: ath10k: Fix connection after GTK rekeying
a48589643bfdd iommu/amd: Skip enabling command/event buffers for kdump
ff08d7a8c5806 net: netpoll: fix incorrect refcount handling causing incorrect cleanup
713eab81a91ae net: ravb: Enforce descriptor type ordering
e5614027881ba net/sched: sch_qfq: Fix null-deref in agg_dequeue
05a9484527b6c ata: libata-scsi: Fix system suspend for a security locked drive
7af6c5e760217 fs/proc: fix uaf in proc_readdir_de()
a3c1eb2bab5a6 Bluetooth: 6lowpan: Don't hold spin lock over sleeping functions
648881139872a Bluetooth: bcsp: receive data only if registered
a84ba2b7b6f69 nfs4_setup_readdir(): insufficient locking for ->d_parent->d_inode dereferencing
31db58f15a066 net/cls_cgroup: Fix task_get_classid() during qdisc run
2711f9d9013eb usb: gadget: f_ncm: Fix MAC assignment NCM ethernet
9d0655d33b789 net: usb: asix_devices: Check return value of usbnet_get_endpoints
8299fa5409dc6 Bluetooth: btusb: reorder cleanup in btusb_disconnect to avoid UAF

Thanks for having a look!

CU
Uli

