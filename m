Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7278DCD8C9D
	for <webhook@archiver.kernel.org>; Mon,  8 Jun 2026 15:23:21 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.57239.1780932191030852538
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jun 2026 08:23:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=dOkc4CuB;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=ugctGeAg;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1780932177; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jEURHXogSVKeNtsF0ktXXW3US7h0NwqrWe+YUAMXAyqvhH+Fdb8D/7nx9KZqGSjkzJ
    uCdE3rGmE4SwwO4Re1rwGvJ7NauGclxKIYXZUkBC+UouxvuVxk6jM1lEQtD0RyKUNG0B
    yALp2YFYM97AsetBTppYbj1D6gQ02QWn7s1WJzR87J7w5h0xQEIWleW2nwxRJIB1HOiF
    p7h3yNXeKoKAVm3eTeClhzP4iDxjnYzZs3LjQxHRysDnPHHI/EQBjCPh03NrH0lueY16
    m1HBzX0I2IvVjiAk0CgQtMyCUq33+u8wvtgoq29xG3beZ8UihGVmXyW3nL06QCMF1wl1
    S60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1780932177;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Rr5RaAWEEDGCMImlXTSH7UtRrjwkfnKsWyPGr3C6/JQ=;
    b=e0sQ8NsoiP0THlG/wQOdlKHTeEEcBMHRLcj+py2wqVPSrhNZKgwgFasy6s+P0Rv6C0
    hJzV6nyA+auUYA8/maNpSVmiX+qDUPSUu3yHtE6KV73CDDGGexdCnm9TjFxasr0ha1Y7
    wAv6Khx8xoj6izIbtSNYciM2anab/LlcPMhU/6Dc3VaIREvVtT3t+rnMU8QYwr/dkp82
    O7DvOf6Hh2hOIYAZkCf3CRbzLfhFm7FtCCEfkOqSMAIT2zg/mjjH2LPglvnw+rEE4txm
    376tUxrMl3IeZY4h+/0yqR3t+lCCtEf4WSgqhlcKf7YyjtIeBTelz+51ZTvsOT4Cnd3E
    0AWQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1780932177;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Rr5RaAWEEDGCMImlXTSH7UtRrjwkfnKsWyPGr3C6/JQ=;
    b=dOkc4CuB0q9N0VDCAr+AQ2rN7qfnkQVoN/3jBeC+8d4993Op9x1xjC0Ry5NotAB+4n
    6P0x3g4nqlKZyCxtEhwZSG2e3v3g/kXBhKpZevj37XAmVviCPuME9BAOYMGRI6Zw+o9G
    22lV+FPtoaQy4PNGXefgfWwSwNDuKLRb/WUJ08PzmRnPgz/ub6JEoVa1ve3x+2qFOvLj
    ALoT4DfIHDvsUgfjGdsxY95VXlEpDsMrF+Ba1IqjPfp+uWCJPJHDZmFZEJoqeZQ4gtxO
    aOHODsnGQfQevuSVkRodCgMFamvy0L7a/Qb1MJ16fRJexMLFdmwxCVu3JNg770rtr4b1
    yLgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1780932177;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=Rr5RaAWEEDGCMImlXTSH7UtRrjwkfnKsWyPGr3C6/JQ=;
    b=ugctGeAgqDjS6iXLRF0S7qG9+NQA+Kz806aAjpyca5RdVGaWvdkbxIl7m6nH9BsMF8
    4fyBvlu+5tI7wN6oUVAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDK+NL2bA=="
Received: from open-xchange-core-mw-gw-13.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e258FMv7ro
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 8 Jun 2026 17:22:57 +0200 (CEST)
Date: Mon, 8 Jun 2026 17:22:56 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1985872946.840508.1780932177008@webmail.strato.de>
Subject: Request for review for 4.4-st77, 4.4-cip112
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.139
X-Originating-Port: 54806
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jun 2026 15:23:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23049

Hi!

Here are the manual backports for the upcoming 4.4 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

6e6dafcb73d7f x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache
8e98545170c1b x86/CPU/AMD: Add X86_FEATURE_ZEN1
5e0f887ad764d x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
6f2a036399e90 x86/CPU/AMD: Add ZenX generations flags
e379f10bd8fb5 ptrace: slightly saner 'get_dumpable()' logic

(All of these patches had to be manually backported to 4.19 and again to 4.4.)

Thanks for having a look!

CU
Uli

