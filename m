Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD58C3DA6E
	for <webhook@archiver.kernel.org>; Wed,  3 Jan 2024 06:50:43 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web10.12676.1704264641578061962
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Jan 2024 22:50:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=KDCsuPC/;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Q5rAO25D;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1704264617; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=a9QoUoGGARANCbqNC8k+iazYD4Y94tayVMB/v7rxYrwDfMOAZ7ynCIXNqhRFQuEOS/
    LE/WDtpOQBlpqlaVv62stkWTmzZvlv/mdk0wqcCabcZdq/ED+LM32uMMHPBlSULvxxED
    lJd0UhOP2uDcqixTRFOj4AnOO0yFiyKkSbN2FPbfHHuYCaJ/l8eBG+96wKcRNZbaVSKn
    r4Utej2p5VjzJh5g1VsLaXV9p+DpIBKaYIpIZlMWlxdEh4l7vj78dnLFaicEujxKIJRC
    g+Ssp612SOf6Weaub76bT5hXzAo/WdSY69kqyfKsMhGkCWX+msIyrBmoV/6PdP3lc2AY
    364A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1704264617;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=PJ5OyU6EAdU9f8psvnOh4kg+MR0p4dcsZlf+Q9R9Sjc=;
    b=rx2hljF4szHygerGaq4VNIDmJdUdM1U66Kx0RNMHXys2vujY66+ym5rsVlfaxXE0Aa
    jAczqSkrPjkxJodGmjSZ8VwYpvAbKTqwuXXLJXvI368ubIFqMNcxwimCV+OL80zDeMVd
    TzqxwiHq4Oq7dr/9BL41cwlUEsXqlJJJA8acaWQ6T4zCnas3hOOelY4Z5h52oM1HRqmg
    qTk48dMYkZzOdgzf9zm9Tcs/QAyaGEwv9N4e+43eWEDe53ydVonNIcl6tSIj7aQPR68z
    EpnyK6vNjOX7fyIC1grBVjl2br2LzIHeMwWntplelmrgKruIpapP0VmkTBj+Z9OdR52M
    mTqg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1704264617;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=PJ5OyU6EAdU9f8psvnOh4kg+MR0p4dcsZlf+Q9R9Sjc=;
    b=KDCsuPC/UryY2Hxg9WwLRCB1b924XsUNMvA4qCKPru8b0MHTIJRUcETTEPByIeqW9O
    GDqvu1MyznOq3Hhp63r7oYX+UrHTY6m6nI0ExAv1oFrZ+6oQcT73QdJ4iHBvUauo1RYu
    MjQzHzabL1TcchdFc97NQR6H2rn/PpPNoUA26LFuCMpJTASDXt35Y9dJ3Agr+aWiG++B
    OhccmcysSxz8kyBWzWpdEhtytt+XlIRMK971p3Ux3PgQK6zsKIoLjDVrVf33WOyDJEk9
    Co/D3Nnait98fGlmt+Lp4Up7IiszTk76H9qvkDwQmyGWad532DPM+pA3zdaHSU0CV4ur
    I1Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1704264617;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:Cc:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=PJ5OyU6EAdU9f8psvnOh4kg+MR0p4dcsZlf+Q9R9Sjc=;
    b=Q5rAO25D+d6F+0p6/7PaiqQvNoV0Z3LBcOwsPOOmJlK6qq4+r0UBVKpAGzk4Ug1Fk2
    YBdWHos5u/tNGHQeGYBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCs/87J3I0="
Received: from ox-live-app203.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.10.0 AUTH)
    with ESMTPSA id d26e780036oGf6G
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 3 Jan 2024 07:50:16 +0100 (CET)
Date: Wed, 3 Jan 2024 07:50:16 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "pavel@denx.de" <pavel@denx.de>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <388403084.1872261.1704264616877@webmail.strato.com>
Subject: [ANNOUNCE] Release v4.4.302-cip83
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev56
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Jan 2024 06:50:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14236

Hi,

the CIP kernel team has released Linux kernel v4.4.302-cip83. The linux-4.4.y-cip tree's base version has been updated to v4.4-st48.

You can get this release via the git tree or as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/

  v4.4.302-cip83:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.4.y-cip
    commit hash:
      a0ac575eeff89882d3aa16d67979a86e668f5d1d
    Fixed CVEs:
      CVE-2023-51780: atm: Fix Use-After-Free in do_vcc_ioctl
      CVE-2023-51781: appletalk: Fix Use-After-Free in atalk_ioctl
      CVE-2023-51782: net/rose: Fix Use-After-Free in rose_ioctl

Best regards,
Ulrich Hecht

