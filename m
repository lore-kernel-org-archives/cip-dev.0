Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A448C79F9F
	for <webhook@archiver.kernel.org>; Thu, 10 Sep 2026 08:09:54 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8834.1789027789900959544
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Sep 2026 01:09:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=elyI0dEA;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=qxtBiGoi;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1789027782; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UTL8nIflLVAmrLpXQZZMVdyF1gMG2ecKt3riGrPWANj6gJBX9WlbN1Fa4JBbR9uk+R
    OnmfdxzkGtE6e+JB96KfN8qO7FK77Ad9G2IrxhhVOfHLrJjoADXohpN76vkpixD84eaZ
    FwaDGUZABy6OBfqcT+GnGXWa2F1z9SrRY22cOqMn9W+bbIfWPY3TZy5VYtbQMoYR8pc+
    c8GbE/SDv3uS9t37dojIYt9pwj4CdNO1gRbM3jDKjppquQH7dAzGjiQfMHitlzWvinTl
    vvW5m0mHKCERDs00FCHmRJnL42Rqr2f+bPtLQ2rkUU3XaXhhekdBPItT7wKzNCF/pp7B
    0LEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789027782;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zI+xc5KHp/b3jRS5mBxGwNgRt1mRLthy1c7Cai1rGaE=;
    b=CPjXP7fvH6DTqcNu5FErxZxHd5LmF69U9RPjLWe3qaNdRbaC4Ug76ZP+UAjhpc7X+7
    cVaMtAer1O3xvnHPIt+LhaYxkJtml8PANcJcplYwiujHQw+I0BMgyZL82kHilqjMfaH+
    J+gpFy1RKPbtL3zyNhI6jZTkjKU+x1y+rUfXc5VF43vxbTS7aYtTFRQs4Xv1jRwtnyST
    QNez9M0/eBuaoxypKvWi2YE3KMa+UrGTKPYT7lhcYnLyoYCzxuVC/lilq2ZXh0T5dEG9
    4K4RTGNl+y43dJnCzLNCxuwTnoKHkf0aP1zOOpdo4Jao8vMqW3d1msAm62UcRxt2aON+
    rjHQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789027782;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zI+xc5KHp/b3jRS5mBxGwNgRt1mRLthy1c7Cai1rGaE=;
    b=elyI0dEApk5I0KiiwxOJf84aMxB0VQJa21wPXKVFBnFdoiE2wWM0YugtEKoBl+xs/V
    Mu7qf34cna3ySA+djua7lyHjW+Wq/G+rOvfmTRnUB+0PkEeZ3qRsHJQE+eP2lnla40yI
    /7KJ998BgF91T0V/xJb94weZFZyeal+7brRPFQ6Pf4f6Bx999Mv9p84p2yeLnT8KynuS
    MYK18TaYZFd8W265Eb3FUUwrEK7qF2JSC/Po07bAKN2lwA4p6DYMlTwxTZy8u2xZgo9E
    +g1+7r4NVittOg2lX9DHIj7OC/bKy3jKJScOr0Os2VyqHB0bzzuEddEJHWXxOrGhwadL
    m+LA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789027782;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=zI+xc5KHp/b3jRS5mBxGwNgRt1mRLthy1c7Cai1rGaE=;
    b=qxtBiGoi2QbyZuBDTkOHRkSIuNZZxMGmLqji3PXMu6z9ACDMkXAbnTQz1vFy+1emuR
    1/h20HmORWMxDpvdCkAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHK+AR2fLw="
Received: from open-xchange-core-mw-gw-14.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d928A89gbxS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 10 Sep 2026 10:09:42 +0200 (CEST)
Date: Thu, 10 Sep 2026 10:09:42 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1507273529.285330.1789027782094@webmail.strato.de>
In-Reply-To: <ap6aPwQoEtRazAe9@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
 <ap6aPwQoEtRazAe9@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st20, 4.19-cip136
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 59352
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Sep 2026 08:09:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24115


> On 09/07/2026 1:04 PM CEST Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> More reviews here.

Thank you!

> ! this is now completely different from mainline, and pretty non
> trivial; I don't know how to review this one  > 0ee0719ebd182 crypto: af_alg - Remove zero-copy support from skcipher and aead

It's almost identical to the 5.10 patch, with the only change being that ITER_SOURCE is replaced by "WRITE | ITER_BVEC" because 4.19 predates "iov_iter: Separate type from direction and use accessor functions".

This entire kernel tree is based on the assumption that 5.10 patches are (at least conceptually) correct for 5.10, and with the code being completely identical in 4.19 I'm inclined to believe that in this case the 5.10 patch is correct for 4.19 as well.

CU
Uli

