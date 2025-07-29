Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6941C83F26
	for <webhook@archiver.kernel.org>; Tue, 29 Jul 2025 09:23:09 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web10.2980.1753780987102960054
 for <cip-dev@lists.cip-project.org>;
 Tue, 29 Jul 2025 02:23:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=PcRmVNLG;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=4CIx+XMS;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1753780980; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KWNNrtmy+fRznfPlrTrPPQhQI9WWAqQ8xg5KcCQCDfZPzmI9xoKmck9Bk6OgRRAkIN
    v3sVwOXu2935eZUkkKI6N9/SSP5RqZQoLxUdqmIeuHtPiVpcjzWYzCyyQboh2sJWhKEJ
    f/UjFs1xeqbkR01ocxBMdvg4gePfz7vWAte5nlkbPQHfYOunOKBh6ZS94kWguExslTAi
    QD96b7AiEjWTNboCzrpXG1hhzkO+k+nytRMunF+NKaDVbNFbX2kBJen457BQq4W1LBsD
    JzMQS/KnWtbarEPcrI5y9P8s09+rKlbssR6YBtUc2zs2P7m4CKvCXfQWc6/6Uu/Zvafe
    gg3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1753780980;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SHKSDxuqWthg2G9LAM38gfDG9sC63ywIFwmNz4ozmUQ=;
    b=JIfSHSulBHL2i4qtD96eRfeMEde4iifkd673qOK6jlHBY0s+TJ7VjjElYsAhDPJ2fe
    4Gh+ohFDVChuNafgrV6bgL2SZJJQ416JgUUwZCawBzRjHgl0wM0frKKvMO5wOVjEkfUE
    2YCi8ikXi4fVYBsgTdmghafX8HJSHiX21Ck0biyp5syXRcueAD0WUs8FdGih2I5F5c8o
    CX0T2yArhKWqZYJB5nTr9RJebtDZ+iBHr3Gwsme/cKdptF4VFOOVzuZiMLkd70P44iBF
    raUf3lu8bzP14gngbFwmt2nTDHlzp/oISFVdE+BC5VOFXi5xpwW1I90jzPrMabggxgkR
    bUng==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1753780980;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SHKSDxuqWthg2G9LAM38gfDG9sC63ywIFwmNz4ozmUQ=;
    b=PcRmVNLGYpNYbGhXQ3V2xtRvtAyYTCOUHKjDksNmOStdnGsKCe4YO/UXX7CTIKRopN
    Y70qF9xdn9CDGluGnifmvhut2xBVvMnEDk+irEyEo1VAUNdcXHMLXUvVW8SArIFC7EG8
    RLL4TM8DctGI3AvBA5hAJwZsNWJ681KwlZVh3CJEcXH1gtBotZd/Al6K5rTjb3M1rQaW
    i4AwyVKvQfe0SwkNXXdJ2awiOs79rkwFOmKhUz34jqEuxgIG5LEotPpExzCaChItrcWi
    SlTPTPKnbP0pVqJUW38uF1TiVTQSzj3pfafZ0a/vckHSrD6FNfKsih+HkRGvlR3oMG/u
    opLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1753780980;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=SHKSDxuqWthg2G9LAM38gfDG9sC63ywIFwmNz4ozmUQ=;
    b=4CIx+XMSj3PYIun5w2XDAwUTZev7rV9nn3ZiBFD3HedzuPZM9sGSuzySS92itbSEYz
    cUJP1+KKoYHoK5PmBDBg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hewKXd5F4sJQ=="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6216T9N0eay
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 29 Jul 2025 11:23:00 +0200 (CEST)
Date: Tue, 29 Jul 2025 11:23:00 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@denx.de
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2017185100.131820.1753780980104@webmail.strato.de>
In-Reply-To: <aIZud744QJhijzln@duo.ucw.cz>
References: <158891858.150095.1753458928281@webmail.strato.de>
 <aIZud744QJhijzln@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.4-st66, 4.4-cip101
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.55
X-Originating-Port: 36514
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 29 Jul 2025 09:23:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19613

Thanks for the reviews!

> On 07/27/2025 8:22 PM CEST Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> !! > 47ba411d24712 can: bcm: add locking for bcm_op runtime updates
> 
> Dunno. Code is quite different in 4.4, in particular it misses
> "op->flags = msg_head->flags". As this is quite complex and not
> tested, I'd be inclined to drop it.

Dropped it.

> a > 945b6360fe7eb x86/nmi: Add an emergency handler in nmi_desc & use it in nmi_shootdown_cpus()
> !! > 1e212aea72d77 rtc: ds1307: stop disabling alarms on probe
> 
> This is behaviour change. Someone could be relying on the old
> one. OTOH, -stable is taking it...

Good point. Dropped.

CU
Uli

