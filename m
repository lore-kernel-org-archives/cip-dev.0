Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB5FC76196
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 08:56:33 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web10.65344.1680512191253310976
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 01:56:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=JOt7Hf1/;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1680512188; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BuFwCLwoTzBA8Etau4GpNZQrcEPwrcs3aW7N4KA+zV97pNHOQVCxOJNfysPFvRzYjP
    yMdupq0iDjglKpiQE1/2dGKc8pqU+ihNjV87V14p1Bg686OQdZGQFoLZkxYqsvDMnEGQ
    qlADuMYAiLRkPGhFunEpfqAlTu2U0dWX+NStWY+IDX6WLXkRLc37fZzk+PGTI2fo8peM
    Hmn4Z7VcTVKNcDfHl8W/5wKF2wFiGFf+VERzMMn4JigddoNGtQ2P3WEdjL6FlyR1SnGn
    8v55ppSn846YmC1T2XRJc4ow3Nd4+CaIjbD9T0yuJMAxI1FZuYWXYB9wYepBpiyD1PDb
    8AyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512188;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=swECCOVxK8mKW+KGrk8KMfVjSWu8VGCJnzUwIKloIRU=;
    b=Ew7to/kC7jYSditpHA6zFnLbD6CcSix/5id1O+IPFQT1jB+0VDWA21ufgT9WkVKn0P
    RD6wZuEymPY7u2hlWfx1wcbIJhPLsC2v96hU6DbhywQUGbj3YNrSBgu+gO97QJWrOqQx
    UaERw8tw/lZJwPwIwyYZA7ObGMUP5aKpNv+FPUEvBdKWrFQ7lJn9YdhuFa+r5qmAxilQ
    DaZi2j8uJ13y1PO8y6tM79ulPfyQm5bUgLCOIU4yVHg0JvcAuTYDE0TGVHmMxisMNl6o
    lNpgH4wWEHUtJvtsT208sQb9rKmpShTO12/Q/WYC9ULHLNuenpKMpu9nGp63eTR1Kvu3
    nVyw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512188;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=swECCOVxK8mKW+KGrk8KMfVjSWu8VGCJnzUwIKloIRU=;
    b=JOt7Hf1/xBKCz/NYBToCDqfWr7rXgFE2AzlUVGfaLJGYD4L6gq8l0cB2gonHtLtTmF
    EkSWckYtVShXXJzE2chg/9N1DQllo5B9I03n7oHq47BmMf/BdPPsOhm300iqoyjROlNW
    a6M5npGNqCjjwOO4RhnA23wfrLod2uPeqjAc+r9gomoL/Fn9C61hkQWQ4FJkTDiw58Te
    zuBU4B0lZU7MsREwmLJ5wmNx7UZkYyvr2/j/h5FPmoVNGL++lARvICOnVZeUiYC1ciUp
    6tZlOyh2i+zDpeDfzomG35nklnaGfflwNX68AZtbknEAj5whgZs4NyvAIBLlPlZ5KJYz
    tSrQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpg+g="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.1 AUTH)
    with ESMTPSA id Uce81bz338uSvsB
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 3 Apr 2023 10:56:28 +0200 (CEST)
Date: Mon, 3 Apr 2023 10:56:28 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1298657203.1492790.1680512188236@webmail.strato.com>
In-Reply-To: <ZCmtowC1mia0A1Cx@duo.ucw.cz>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
 <ZCmtowC1mia0A1Cx@duo.ucw.cz>
Subject: Re: [cip-dev] [PATCH 4.4 0/3] ALSA: control: Fix locking around
 snd_ctl_elem_read/write
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev40
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 08:56:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11146


> On 04/02/2023 6:30 PM CEST Pavel Machek <pavel@denx.de> wrote:
> Second option is to cherry-pick these:
> 
> > Richard Fitzgerald (1):
> >   ALSA: control: Fix memory corruption risk in snd_ctl_elem_read
> > 
> > Takashi Sakamoto (2):
> >   ALSA: control: code refactoring for ELEM_READ/ELEM_WRITE operations
> >   ALSA: control: use counting semaphore as write lock for ELEM_WRITE
> >     operation
> 
> They are in 4.14, it is probably easiest to cherry-pick them from
> there.

They don't apply cleanly, though, so I'm happy to pick up Alexander's series.

CU
Uli

