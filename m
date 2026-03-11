Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957BEFD0658
	for <webhook@archiver.kernel.org>; Wed, 11 Mar 2026 08:24:09 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15782.1773217444557510075
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Mar 2026 01:24:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=REQfK8OY;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=SKQ+lddq;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.164, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1773217415; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=iQ0d7AxEhuUSftkrGtt61UlFDAr4nnGpKsHrsc1Mv3Hy6Tm/c8BLtjQqHAsy7cUAdr
    Cow0EDDVWDt936vcw3A85U0bSoOQb8OtAwGMh5F8HZ4i29jOm4zgQtnZ+YQ6wFy20sV/
    SJ7D/6FD5goRdbWqlgYbkds48fq4O0v4J3yiLaX+tVJ8J7MElk0iIJiBGPpnqHjlyXtH
    XNRNPqlD92MCavXdnhLkKknUa2xcI28zjbybkWmfnxC/JauGbKPGHrFw2whc0Ql+BOzE
    YMLZIgZlwwmePCTkAUxePRnUJAqwRqMUS+cYUs+qg7lu04xRLhiYr8IktPuiU5e9QQKa
    foiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773217415;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=s2tShar90RFV+Xv3Gad0bXvNvm33Ds+/rfCu/Q6TvU4=;
    b=EavoGuP+iv44C6QK90eCB6jV+QvgjYhTLo6iqD8aYDhtxIocJf+YzHW9P6lA4TL70t
    +26Szt9pVu+rzeKYrYqHM4bkLervEuR3e+lnh0XDvcnBGQz72Ves4uHN9kwxqpRNZU2U
    4zaRu3McVkgj7Vf5O+HJCOGT5f2MaLQxy+NJe8d0Zpg/vxy8jpZt57wOQvtKigtydfBT
    DZIcxQ7VJ4s8sPyOdEUmY4CwQ+SM3F7Kc54YsKjT0NewtDE5fPRYbnDlfsVRHJEClV4O
    j1vIx88gYXKDZKqDDu2wp9WPAOSKZa2605NH64+TlGQ8Scth1JH4zoRpZxNX8+sdsY7g
    9HOg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773217415;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=s2tShar90RFV+Xv3Gad0bXvNvm33Ds+/rfCu/Q6TvU4=;
    b=REQfK8OY1WSSaJT8Z3VSxnGG1zzoAxoGgCr3SeMaiwfWGRG/+MX+6twsIVHdTjQ+48
    skU4PetqiWWaZbmOYC2YxbNmMBbEDWIRUMAJ0wAQsedCWqxWS9vYW41ACIhBr5y+/iXy
    on/sMEhzQ3NYZ/qADKkjaiiZE8NUtBVDjQMusbYFsvQZR1c/sud8HQc4SI5V0A2TTqci
    rebxTyO5oioJtvyeDRD9edqPnlgQrv+Y8SIdJR24L3ZdyvCNMKnw3M69EBLVDOuDUChu
    Kh745vduZvFf2ki7OE3vjqzmxQIkaZ00zI6sEiZskSlF4hpGuhza3W9nIstN6jJpKI3Z
    Gjeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773217415;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=s2tShar90RFV+Xv3Gad0bXvNvm33Ds+/rfCu/Q6TvU4=;
    b=SKQ+lddq1AU/p8RXChxPkjRSFgfNZte72WnXhLN1wt5OVSoNK+XMRP87H/owa0pENI
    2kn+701RCQNPZRLBQGAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRJGu7Yb"
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e22B8NZPyk
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 11 Mar 2026 09:23:35 +0100 (CET)
Date: Wed, 11 Mar 2026 09:23:34 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <124056954.96482.1773217415015@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.4.302-cip109
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 50674
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Mar 2026 08:24:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22245

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip109. The linux-4.4.y-cip tree's base version has been updated to v4.4-st74. The trees are up-to-date with kernel 4.19-st14.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip109:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      4f7b18c72006c50d045431830deba2f7600d3c03
    Fixed CVEs:
      CVE-2022-50516: fs: dlm: fix invalid derefence of sb_lvbptr
      CVE-2025-71237: nilfs2: Fix potential block overflow that cause system hang
      CVE-2026-23237: platform/x86: classmate-laptop: Add missing NULL pointer checks

Best regards,
Ulrich Hecht

