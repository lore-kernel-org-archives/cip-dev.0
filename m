Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E8FC433EF
	for <webhook@archiver.kernel.org>; Tue, 12 Jul 2022 09:45:48 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web11.7086.1657619144058777933
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Jul 2022 02:45:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=UF8K52lJ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21,
 mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657619141;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Sa15qQ5Pj95NUM7IoBXohiCzgxyC/tVXYccJSF09BVk=;
    b=UF8K52lJtoyCtxsm5WFeecXvbn9XW/5G4fOdAWolfCy2dfUwUI7LBzGB8jDqr7E47t
    hg8hmzJNdpX0oBJOUyUaZX31wrHUy5ZoYTbGExnLyqYi2c9I27iAl9fsub54KU1+R184
    LgJH+V+BPE7hgbwuzlFkcusdjEmsr4GpCmZ/pZH7Js5kmPfvSlo7+tXBKOI/9ib5jUDz
    kYz8MPhuXKtakml+gvDtgCqjc4bKXyP+gt7F2XerJCLCSsQwlQfoxdMoIhFhNt7kkjRZ
    HUuzVPaombwR15TlQXoToy359GqkXzyO9qVtp9x8qlJS8HMFX9pgTkUp3eUvQzqT6xkK
    vJog==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2qthug="
X-RZG-CLASS-ID: mo00
Received: from oxapp03-01.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.46.1 AUTH)
    with ESMTPSA id Icd816y6C9jfds0
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve
 X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 12 Jul 2022 11:45:41 +0200 (CEST)
Date: Tue, 12 Jul 2022 11:45:41 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1646526217.744180.1657619141658@webmail.strato.com>
In-Reply-To: <20220712093552.GA23165@duo.ucw.cz>
References: <20220712093552.GA23165@duo.ucw.cz>
Subject: Re: [cip-dev] linux-4.4.y-st-rc moving forward
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev18
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Jul 2022 09:45:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8750


> On 07/12/2022 11:35 AM CEST Pavel Machek <pavel@denx.de> wrote:
> I've moved linux-4.4.y-st-rc forwards. Could I get some reviews
> (Uli?). Especially look at last two patches would be useful, as those
> were manually ported.

I will have a look.

> What will we do with the random changes?

I have so far found only these patches that make sense in the 4.4 context:

random: do not sign extend bytes for rotation when mixing
random: avoid arch_get_random_seed_long() when collecting IRQ randomness
random: remove preempt disabled region

CU
Uli

