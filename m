Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37B55C55838
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 13:42:46 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.218])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16582.1785850957125740768
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2026 06:42:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=U15WAyT8;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=6anr2YTN;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.218, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1785850949; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=STJjnJ7AetP4d/bOIEgV1MBMdq20H9CzqyGSu8UTXwkW/ErERtdS/BtEUPvvCOH7R8
    B7WpHPH028EmcP6KBPAG+TMfWzoTIBPRN68ixQV5Fi1BzPx5yI1/UoSytRU8YjKzvl/I
    v89KHprx1XGPIbn3T6iyE7T9jhCuPv7evCfBGs2cd0Aa59WWDU36H5xkVyW5m7bOZiyF
    UzVROnZ60bh7ziIH8sq8CuArUxzeJU84KyzNSlUxfxssuy5McZ4IFRfRWqB4/G1ipy1J
    KRTaIOYoM6GTw3+abATbsIA1bYU6Dnz0/9xujK2UjBa2Ty74cQNJN6op+N35OZvGoavD
    aY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1785850949;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CIXp3HFEOtRDb04LH2xB+mcqCyiM5mwSsbaDZ61xcrM=;
    b=ZU/gk0fmjhvrAf6FOg6aBYUnTdZLp6Uj+GvR057XRm5HhRy7m/cz3sXvODwcXooUkU
    yfQId+D8667hZH+8xn6CXYR/7uFt1v6wlrNkiDjwFhT/Jie0vKxpRb1MWJC7XxJfiY8u
    58mDgRpbkkqZxfsOtMB+covbDpO9y1H3GPl0AWtF73ns5c+asvbEpOtIqn/YNVB9oPb9
    Byyy69xuR8PD40VQpgpTdF4uYbeUwBSZBbJP2S1f2USIqUKsdW0bAdOK0Hc87ko4XRak
    5TOKIm/8teOIC+vyIyjj1WkC8rTla3SfLg3X0Hv55DjBf/lAT+6OfoMhRBreAGxyBMID
    Ne8Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1785850949;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CIXp3HFEOtRDb04LH2xB+mcqCyiM5mwSsbaDZ61xcrM=;
    b=U15WAyT8ZGG8d7x3X2yL6Zcq0z0B173QOdxIR4jxaL9wyJoeizrE6CzPi01L1qZuwE
    YDJe7Efc1PvytulDmjd8HzouPOtgmAC6avaJEyKgW6LQqDoRaldoimNYXFtt+AMA4cEf
    knezyoOepQR5HBnRSmTT1tfA+4DOufYgVqX5OIy+B01UsOgcXFNx4kiyJTpoWwM9RkRC
    Izioc1CH7LINzj22RYL4Cjq+WtDnnuOszUZab9NKJwX6nsF7Kxu1SbaHE0NLlxblX6L2
    nfRLMCffu6Na1a/XbwNTyk1AwJSm4WBl2WjIRr+elN3YJwfJ9xQisuLtFmwuKetBLS3z
    t99g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1785850949;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=CIXp3HFEOtRDb04LH2xB+mcqCyiM5mwSsbaDZ61xcrM=;
    b=6anr2YTNK8YZAfJ6Lxawgc+pJPWbo3WH9c9lv6eORct4Mf2MyEXiGDaY9ARmNNAPWZ
    rjFezJXAsRmrHW+nwrDw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKfF+CjmMA=="
Received: from open-xchange-core-mw-gw-16.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.5.6 AUTH)
    with ESMTPSA id zec9ec274DgSBE7
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 4 Aug 2026 15:42:28 +0200 (CEST)
Date: Tue, 4 Aug 2026 15:42:28 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1585035542.888285.1785850948139@webmail.strato.de>
In-Reply-To: <amuzXTKnx-62O07s@duo.ucw.cz>
References: <527172097.345263.1785165473174@webmail.strato.de>
 <amuzXTKnx-62O07s@duo.ucw.cz>
Subject: Re: Request for review for 4.19-st19, 4.19-cip135
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.152
X-Originating-Port: 60164
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Aug 2026 13:42:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23863

Thanks for the reviews!

> On 07/30/2026 10:26 PM CEST Pavel Machek <pavel@nabladev.com> wrote:
> !! > 5ec48ec054322 arm64: errata: Mitigate TLBI errata on various Arm CPUs
> 
> There's something wrong here.
> 
> +config ARM64_ERRATUM_4193714
> 
> is unused in our tree, and not present in
> cfd391e74134db664feb499d43af286380b10ba8. Plus it looks like
> documentation is missing.

That's an editing error on my part; fixed.

> !! > b24d758d47d69 arm64: Add part number for Arm Cortex-A78AE
> 
> Again, something wrong here. It creates the define but never actually
> uses it.

It's used in the patch above; the fix itself is not one we need. In the end it all boils down to...

> Note to self -- we may need some kind of markup when only part of
> patch is applied.

...that. I changed the commit message to make it clear why this is only partial.

CU
Uli

