Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCECD5BD1
	for <webhook@archiver.kernel.org>; Thu, 28 May 2026 08:13:01 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6064.1779955979847615956
 for <cip-dev@lists.cip-project.org>;
 Thu, 28 May 2026 01:13:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=HJguBBwQ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=bMxgY9rM;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1779955950; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Pnc2vEf0OtiroGdZMbiXgdgXX44ugyF6moX16thmvzo6ln43JYKCn2k72o3ZtJ0yBl
    iGzxARoOdiiF5o/qL7oz9rZR3NnSKUOYGnjM8IgD0LEhIyvyi9Cce6WpL+i0hgztOTez
    MH/qhkietAz3qF3owJ5Sc0PkJt9OeAmCiyOfPXD+eMEB6YMWWN4j0cjOjjplT9rnwZz1
    NKtEeplkKqX3bZE5p4Og+XmffwlWj4nZh8bXq9PFufBV1gQH2V93pExGjViIasNRJ9Vn
    H52uu6PIY1em6Z0IviptpJWAsdesr/s91wmi1BaFoj2q0Ro8V4HSAKbZuarRPq0f33G8
    voJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779955950;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=m5xPjYALzv99Isoyz3ScffFDQ8D9kK4FC/Aw1UlJolo=;
    b=GGJda/B63I0rAo7pylbc51NK6epFmY58vFOdzrN+aI68cqXiAoi0K8TXptUnJT52i4
    SKoXjv2Ab0Geck7uMuv+s6IfU7e5naLS6wJzRdibil+O6CkTHc0y+VEuKLmSlFajwe+P
    odkTevOuzyIJls1XySGD8jfNvNZFiaTGze3sxNljppHFrSzcaHkb4ix7UbjBtuRXwr/1
    boLhapSV8ZO7QEQLdAWnWR+CCBfSrTLdjYK2dmdleYKptP43nfAZpS/979W6H2meGrO2
    5xXOr8SHNUtYWmKpNP7HdReGsmWQK0kycPyfJmqtTEi21xe2H0dDtlME4BlWjowCsfLz
    hLXQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779955950;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=m5xPjYALzv99Isoyz3ScffFDQ8D9kK4FC/Aw1UlJolo=;
    b=HJguBBwQIJtSyH9eRGt6Cpjx/bp3wOxh0r0bDwaglhmBygq1YJbMA1t8ES2SMhhV5f
    U8UlVMH6fA+sDt7EQinPzltGU8ziQfaoCYUlmdnEvSjjKVygL8cEZivSJWNPGxhdtQQQ
    f6ZlGZqZfOKVJ82d2TLsyWB1fn6e7TR6GoklROCRIHnVAPykR4FGhMGzQTeYCThR4k5x
    B5ms363ogcoZXhc5a7vCxqOeC5a6/Ih8Nr0aIfNeKvFSrLQhiPbn8hQwhL7RQH2CoLtR
    iXSZMlPtY9ZeJPFuuILRtrB5WNq2aZmfNHM7UgEyh1hIqzSgNkUxF185Sn10XZmOvTRS
    NF2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779955950;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=m5xPjYALzv99Isoyz3ScffFDQ8D9kK4FC/Aw1UlJolo=;
    b=bMxgY9rM/udPUEvg/2PFHCNS38mWAhOtymE6SdhJ9q+hY2bE/O9G7Q/vdO3E5XytMe
    RMiw2mtNQRxYunQa4FAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzmtmY+tLVdXCxtaPNEIQ=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e24S8CTUwU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 28 May 2026 10:12:29 +0200 (CEST)
Date: Thu, 28 May 2026 10:12:29 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <544459812.21401.1779955949494@webmail.strato.de>
Subject: [ANNOUNCE] Release v4.19.325-cip133
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.139
X-Originating-Port: 38266
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 28 May 2026 08:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23035

Hi,

the CIP kernel team has released Linux kernel v4.19.325-cip133. The linux-4.19.y-cip tree's base version has been updated to v4.19-st17. The trees are up-to-date with kernel 5.10.256.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.19/

  v4.19.325-cip133:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      9cd7882c4ff1122842b29191a5913970c5159ecc
    Fixed CVEs:
      CVE-2026-43284: xfrm: esp: avoid in-place decrypt on shared skb frags
      CVE-2026-46333: ptrace: slightly saner 'get_dumpable()' logic

Best regards,
Ulrich Hecht

