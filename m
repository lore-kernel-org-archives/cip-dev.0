Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92189C41513
	for <webhook@archiver.kernel.org>; Mon,  7 Aug 2023 14:58:33 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web10.36628.1691420305256094560
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Aug 2023 07:58:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=lhY0GDEW;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=t/NNkQMy;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1691420287; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EWGp2fTBuxv1cVz5mHF+sBfClvBAikSTHk9A1YxIelatFDyppopfM88ay+m4FSS6xR
    9M0ecsoeknorWfn2v0DPm/uItYFOUrQDfBPW0qMrR5xKsZLyCROJwvbmbnT13jE2y4HV
    4JY1RdCEZVYWD36vD0NUM9PdcoXov3+UkeHma2jQea9j0Y6Qu4VurobxeLzyvSjVct8q
    njAn9vEwr+p98tYS97oxSkJZk1kaNXt1eAoGmdBBpawZyZ6BiubaXYqyGZHAx6Guhkco
    IpNeYuXYg9w1c6sEf1FFxHnsd0NmtkoWexu2d3Q66meZ3+FG9Nv55ol2/werRUCG0/p9
    MCFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691420287;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yuwnsyPCI0Qqzfd91mvG8UMngCiqDqB8/du4uVJ3Rjk=;
    b=Wkp0mhj8/pEogHij0aU3xNQy7X8VgHsEL92uMP96QksgjPvQOqxHrY7n/pso0C5ZZL
    HoaNTa8kYrulUFornGmo9b/GqQ/HRQ9zvM5FiuoMdt2b7otatXM7hpNhM8jevztlq71i
    rVetOFDhTlM3V2L3a8O4HK17Ep0O81H8YzHsjGpFPUNjAWYC7J5G0HMjWGTHZKmzpMiP
    uAuvOiXyYTFhftT642HGVj1EtCFYehweO7BU13pdOM/En/CWp1b+Vx1cPUUPhJO8xypt
    XkLH4H9CAwEuMabc1z0kwlrM0kDbDgEBYj0PgToy67bTz0MoyxvGJIF6zPU/8PHh7+eA
    yaKQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691420287;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yuwnsyPCI0Qqzfd91mvG8UMngCiqDqB8/du4uVJ3Rjk=;
    b=lhY0GDEW27i6ZyNTkBd79seF+EXCzHrFkJnBg6fsYPvrOlq10nfyFb6EfuQQfhmnDK
    do3XHAfnrrWtNP3lLcnQV6c4PaDAeYHSsQ1BcvbUxspMbrzsLmOI5CUSnHIm6iRJNE1/
    KzEw1mXzpEbt+fC7lDitjM28WFJjRQ3vuNGcoiwonKdUafGuQ/goeYa1S+JgMEssQIJn
    SllxDR4NC1XVEiAQuCf1kUCGEGX01f4v0R2s+OGBOEDsEMK2cfl4JR6tE5rH4mGmNqJ1
    64jADLmTuW0J6ZSBb9R2laofz1+OugiIP3KFHq7KppdGApHYUA2jzorSi0D1Xvc4XoIW
    q6bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691420287;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=yuwnsyPCI0Qqzfd91mvG8UMngCiqDqB8/du4uVJ3Rjk=;
    b=t/NNkQMyfZg3w3zC6RPzpTZjhTr6j8w8D1mKJPD4Y9R+t0AThQ49hgJhX/zSEtFe7r
    fDXDluByxguUd5Wes8BQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+P9k="
Received: from ox-live-app205.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.6.6 AUTH)
    with ESMTPSA id wba236z77Ew6qyJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 7 Aug 2023 16:58:06 +0200 (CEST)
Date: Mon, 7 Aug 2023 16:58:06 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <340949293.366318.1691420286693@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip78
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev49
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Aug 2023 14:58:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12555

[ANNOUNCE] Release v4.4.302-cip78

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip78. The linux-4.4.y-cip tree's base version has been updated to v4.4-st43.

You can get this release via the git tree at:

  v4.4.302-cip78:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      bfc57fcad0ac581f1b39110b5847f3e579e7888a
    Fixed CVEs:
      CVE-2023-20593: Fix Zenbleed

Best regards,
Ulrich Hecht

