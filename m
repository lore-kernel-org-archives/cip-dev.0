Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8E6C4167B
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 05:53:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.web11.115763.1699509175643414562
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Nov 2023 21:52:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Dzs8cevT;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=IyFfUy9W;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1699509156; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qu1svmy1XXFlpmowfha5w6qCXiDWenlXkxpSHDZSb4o5dgnTAmlN7nChPsOvB7n43U
    I+Hwx7QH91WeUUqrTJvoZIHJ9Gs7C2KlvpXLOCug/Vu69gCyrgN1FTNYddi2R7jy6yvj
    ZSa4Ll6RJhERKN1cW9ijDkzVd4j+venvQ4/KwSBNVFCxb2sQgVbdUKYOhQQ/ALjOLx/6
    2a6GzdysB3trc3fstFg8Eb6N6Mpi+BU6CWfD5Ivf12gcF9BiULoCiki9iYO9wmYFSjxq
    i+ah4uVrfvdUwmFayKFEGMPNla5AEmzF7NLovFJxX57hsRpguwZ1lt5ZJ2b6XBFJPK63
    +y7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1699509156;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=doBUmBK3rqF6kFjlxmANi+QOGMeTpK7Y7n6U+hKVyms=;
    b=V5jNkGDGsHYklK2cEb2Fq4P/7FoFDsDrzVXoueT6csVQAJYysHH69N8L1Dr+JJMjtT
    2FLD0d7PUymOJbXXKagxDjxH9++3xwoQ7bSJCybqiKdizufbjdrCGtY4lnp9K+aWg9mO
    nf41vuEOrUgieO2zYQPsT5WeDdlCNwW12Uk2SGMzZiiCMwgVBsM6aeeb2SlOkm/zybYn
    giVjWbLGyjs4It/oDpgC1GEhyBM9/qlrgbHLbnIuyN7p89FKm2Mfj3pS2Xk4OPc6b1H9
    m8b4Hf9I7WwU4lr3nJfOG6kXpa0OO0vTLtBPVLT3t4RBS5s+I1zBAPEgYVD+QD5sV0iA
    jzZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1699509156;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=doBUmBK3rqF6kFjlxmANi+QOGMeTpK7Y7n6U+hKVyms=;
    b=Dzs8cevTcj/YlfPK0Ev/pXN49Zk1pNEeRlkALeHglJ5FedPNi4fa9Vh3ny2ox0f5ca
    o6mwu4Y6dNbUx4AgYkJ1w9daa/XHuiOp/pWfdb/9q4mtg2jdX1jJvXj3KQXIrzr/vcdG
    Xy9ISMbDrMJ8t5cDKax797/RWSrPYs8oE+tQMYcmBAs6sZykQ1bewmAc46MaovcdqdXT
    +43pOnVpvQJAwL9zUoPtCW128pdo8dLAGS7Wqn/2bdeoNOh3Rwr9UCUQfsXISSAGM9sj
    nXLfpYeiqCVHN3loBnOPheI0WLxUixN5k02HBzCuU0BNb0vUIozkAf9tfPWDtwIwSR17
    F4Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1699509156;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=doBUmBK3rqF6kFjlxmANi+QOGMeTpK7Y7n6U+hKVyms=;
    b=IyFfUy9WtAhXaEoUy3yWItluV3LBV7RMw6RszwljC90R9qiVyg/GUhOTDHD/bXrRSl
    RhM0j0Xb8ITqJ4GhlRAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x64iFM="
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.9.1 AUTH)
    with ESMTPSA id V6209fzA95qaoAu
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 9 Nov 2023 06:52:36 +0100 (CET)
Date: Thu, 9 Nov 2023 06:52:36 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <967877257.878482.1699509156640@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip81
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev54
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Nov 2023 05:53:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13544

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip81. The linux-4.4.y-cip tree's base version has been updated to v4.4-st46.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip81:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      dfd9dc42c1b5ac6ff9a77d6ab0dc2d2c2d64e6e0
    Fixed CVEs:
      CVE-2023-31085: BUG: divide error in ubi_attach_mtd_dev
      CVE-2023-34324: xen/events: replace evtchn_rwlock with RCU
      CVE-2023-42754: null pointer dereference in Linux kernel ipv4 stack
      CVE-2023-4623: net/sched: sch_hfsc: Ensure inner classes have fsc curve
      CVE-2023-5717: perf: Disallow mis-matched inherited group reads

Best regards,
Ulrich Hecht

