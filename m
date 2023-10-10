Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C02CD6915
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 09:30:56 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
 by mx.groups.io with SMTP id smtpd.web11.86909.1696930251310964049
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 02:30:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=glTJ7En4;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=wDnaoELg;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.165, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1696930232; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jh8L2RNZ9op7KcyZm/aBnnP9h/LyzC5kvHIjmHYMxT6ABzWr/zcJQFH9O4ABL4Yp3r
    orGUJ7MPJSnruvWd7YSgEGd5aWXBQAAU2DO6qEKGbPWQlNDVJE56KxzzJ+ZdB7tneW1f
    5z4viJHLltsyv2IoVi2MNyP1/kq5YZ6XNhjNt+jDdOUWrO0pF5BfHIATbUa5MhjaWCVh
    +YMnbTZIYP7e3i/2KiEAvd8U8BAe/XVO4Z7NinHh2liiHBZ/plWnrxKgshOheXf8W4D8
    DTiKHrSJd1TPzCdxdqe8IBuX4sboyNHp7klYoA4ne5cf3Lf9hg4qeZBc6ZwGC0lz+vQ+
    fGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696930232;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4eSx4yirK/soTOwGVR4n3EbfDQzxbeEdANnLy/pXsV8=;
    b=EyHVgdnO9jfFO35zX5yGWH2eLYUKbmnRepCAg9QgLkDFR1a5xXgEixt7OyackJ2eiN
    ADPHp8kOOu1G4AvUbcGztCK7ufycgnVl2dn2ZBrA9pN74z9j1iuGKX5ugpPqfsPh5dMf
    bhhnFSkog5N8Zwbzs0k1AIenz2dCGj0LiKEjy3BCsyN+MO9TVynsd1J2reXXwX6LxYr8
    BDe6kIvQgmNRwqPy1WP47BHLpNPEfoboI6ZgeM8Wdzl7N0rMDaXu+YpPt9YEioq5VTG3
    mQRueVMiyTUKHL6d7baSJKI9RLmBrWaaNJtkkDqtpEML5px9psLq80DSzsvvwZxMAyMk
    TJyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696930232;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4eSx4yirK/soTOwGVR4n3EbfDQzxbeEdANnLy/pXsV8=;
    b=glTJ7En4LR2kiBNnhxy/l47MO7x9OlaA0al6ZLHzOCH5TkGgwwNlKA70r0X322WWMs
    +kW864QSodlJEw6DwwTlRsfzJEjo8qiF/wZ5YnuqcrC+XSPcGqVKnan/o84Jg7Yj/DG9
    Ue5g8kd9Goc+69CdTB65nccdBya0op0JQK3uAdJY7cQ8KGBoY7Ha/doBz6uc8RuKKPzk
    6Ac11dZ/5qPlDEookbDeO+U3ed4Lsqvt213Q0xl8BYWKKcY7w+eurRwjt5dLoMoeWUJN
    0YYXMzUagqiHFjz9b0iUP4SQTOVlZrMkTCwW4W6ln4TgtQvp8dyphTjny3YEwuMBQeEd
    dEWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696930232;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=4eSx4yirK/soTOwGVR4n3EbfDQzxbeEdANnLy/pXsV8=;
    b=wDnaoELgPJi5l4YxzGF2/ljYjaDRz+NC+L07AGWueBPBjrbr21a9WKLMZy8uHgoNpJ
    7DIa6HkDZWIrP2r7LSAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B/oo="
Received: from ox-live-app204.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id L04889z9A9UVv3m
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 10 Oct 2023 11:30:31 +0200 (CEST)
Date: Tue, 10 Oct 2023 11:30:31 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1080488313.1558493.1696930231259@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip80
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev52
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 09:30:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13347

[ANNOUNCE] Release v4.4.302-cip80

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip80. The linux-4.4.y-cip tree's base version has been updated to v4.4-st45.

You can get this release via the git tree at:

  v4.4.302-cip80:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      9d8a98baf1746169e44d49ee6955a14ae35cc993
    Fixed CVEs:
      CVE-2023-1989: Bluetooth: btsdio: fix use after free bug in btsdio_remove due to unfinished work
      CVE-2023-4128: net/sched: Use-after-free vulnerabilities in the net/sched classifiers: cls_fw, cls_u32 and cls_route

Best regards,
Ulrich Hecht

