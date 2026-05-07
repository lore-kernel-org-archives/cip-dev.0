Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE62CD3427
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 11:03:07 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9102.1778151783728467091
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 04:03:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=GB3NaQ5P;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=+ohY6mWb;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1778151775; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=j4X7bEStsnJeGW1dKH0UoH6xWNtPdqj6tROg4D8UgTtKVcj+tqjAlilgSosJdQmfXD
    mVpYuCoGIFN3r2YKloV5zCMMtGw7noTcOIryJTJU4ejFfQCi7zDpkWFGO60+fRHhkFDi
    Gqxaar4iuQxmo/u55XA2Uo8EJEvmPyQCGWa8XsLlkxwhlnAFtFVyA9DL8Xt0c5BSK8ds
    6Zqrj1Mk+VEIZ5y8qXWzKD5irdRqSIIoCmmv5+MtnnwcatjU+1am4owWQPlBsVPKrNds
    to2vsR1vnee15SQtOmrYWivlVmfNqS6ppKjD/nhhWRpBoeGK/kA+tjS0a+KYIQmnFjf1
    7pPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1778151775;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NzzL0DaxQ4bDPqPEw4pdmMduNYVlO2Mn0j1CsIZ+LAU=;
    b=Wvrp17U22vEvbkh/do0RPz1/khX/2rtQqwhefiqrvLyr2IVk4g90rwUFzdqdLCCKlT
    6Vv1bo7f2y2Y4E7fQOcVb5zvKygGk8R9jLicvwnXNxUQ36Asg3Ql2zUU/gyU8krvcyvK
    wSUq3jHb3OVidR6a68dchqoIBF1N7pP2RRH5aXsFX7PDJ11CvRIuIej+rq8n5VfqtPDK
    ikA20weLX6nsWAICn20TREsM6HQSyn9vZ5SIXKp2yslSgS/57/skYq8FDBtHh25aXTD2
    vjzVR5rRB68cVYt8XR8Q2Vuk23XUtLJgOgUBL5Uk4xKvLTTFWproj2zrK1zHXUe4UQ0m
    GgEQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1778151775;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NzzL0DaxQ4bDPqPEw4pdmMduNYVlO2Mn0j1CsIZ+LAU=;
    b=GB3NaQ5PDREbf7jqmN8h0a+LtCBYrIm2k/wLO5AquywmcBovaJLr842wUZrY+riXqC
    SuZfsYriPVlAj0WbPN0WQZ/duGhoeZi6K5/hse3oXZHUMzGCQzdSlxdxJSdqxmFoudiB
    OJ8WJjgH1tfG8eXgqFaZdnBMy1q28+6fmVRhPdznMepOjYa/5EYojZ+bV6s5XFOtpbTZ
    nJLuN1V2n7gdemiDK5JF8HJjokVVCyfD+JvOUj/za8BClcvOKBNW8Ai3ac9tl6QDjOlJ
    iVYCqGkG8gcIhSFu9wry0DwH5MQunmUdjJEY7a+NEXA5xNzWGT7zdBm35jvFkrdhgMAo
    /Eog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1778151775;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NzzL0DaxQ4bDPqPEw4pdmMduNYVlO2Mn0j1CsIZ+LAU=;
    b=+ohY6mWbGZLAsKh8UfCHYyBXJhSZMQ0sZtJIAalesma9Uhv6XKxrDI9Y1Dod02Wqd1
    QxeENPBNbdSILZ+RqJBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-8.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e247B2tLLA
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 7 May 2026 13:02:55 +0200 (CEST)
Date: Thu, 7 May 2026 13:02:54 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <875572153.700814.1778151774840@webmail.strato.de>
In-Reply-To: <afuVgh5KX9J4UrcZ@duo.ucw.cz>
References: <483138290.348854.1777919283323@webmail.strato.de>
 <afuVgh5KX9J4UrcZ@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st16, 4.19-cip132
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 46508
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 11:03:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22902

Thanks for the reviews.

> On 05/06/2026 9:24 PM CEST Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> 
>  
> Hi!
> 
> > Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc
> > 
> !a just a hw bug workaround. sure? > c2d401e101f6f x86/CPU: Fix FPDSS on Zen1
> 
> AFAICT mainline triggers on zen1, while this triggers on family ==
> 0x17, which may be different. Hmm. Your backport is same as -stable,
> so maybe that's ok?

I think it's fine.

> a > 5b3a91c42591d xen/privcmd: fix double free via VMA splitting
> 
> You normally put [uli: backport to 4.19], Signed-off-by: Ulrich Hecht
> <uli@kernel.org> headers, but I don't see one here.

Fixed.

CU
Uli

