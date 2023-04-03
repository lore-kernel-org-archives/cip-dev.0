Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34F6C76196
	for <webhook@archiver.kernel.org>; Mon,  3 Apr 2023 08:57:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web11.65446.1680512220723282578
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Apr 2023 01:57:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=J7hY6yAW;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1680512218; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=rE+5irNJdkr6V5x1CIzdOnN/V5X3QSmERPjf0Az+1QHFU/+TTkcZ/BOHTAFXtDK40n
    aYdPvrgzJY3irMwqJ0Fk82lpGPuoMi17nZGEP+5+p5fdI5EnCPMHxUQzBIRe5XUn6r7N
    /IKbo4rL7dKawlW2CQpkcIBAi6LHXgXJ7xg31Py9qRCAu2Bgv8R2LAVBPTRYYo+CUSU7
    bGEbYe7u7pmRoux/qYoymDv4Dh2gxXSmn3RMMZJar2bRPyoOJK1kG0RdHosvlell6ab0
    APjTlwC637deajtY293a5HfWB5yZG4dgvREWVOCSA+oih6tx1ibL3hKD7w1KHCisZGhD
    1kiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512218;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=/u9IN67IA9Sr1sfStN58Kn0q2GZkExTU+HL3Lzs8dxc=;
    b=eGTe7bvZHLuV3dsbBEJYcLNXyV5XKyD6Hj9PT86NIFUjrKaoUZdAGDdWrD1bp+ehCH
    Y3GiaGe4GtGZ7RAbOI97aLQGJloQtuET/g6qhz3IK31/ZUe3rFz8glhcEaRGMTWoApgF
    lPeXdVZRS4yoJpRoMGPaacOZ+QZKsHJl/W8laHo+lVqXlL+EOjWuUznUF7qw3qsPOncn
    K+Q+yesVUoJBHbcNDcM3f6bSdV6OT7URD7ISwQMUF29Esy5CQlOofwIW58R7LZ/h5oHI
    ofgeIlLuIQMEZosUAl93lwjMJ7GaM4Iay33nW5996wH/hSYVeZ2UwvuHQ+xxmCjdAYIa
    uCvw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680512218;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=/u9IN67IA9Sr1sfStN58Kn0q2GZkExTU+HL3Lzs8dxc=;
    b=J7hY6yAWL7ap6PhXKZOz18EsxsrXvuJD0PapWAX+joktmcszFPjDVGDfz2+X+K6WV+
    HeRMOPmP4qNBoykAzu2ZiFOxXTVcxeqMJE4aFZnb9+YPbThfImNKXIIWrFrFWQ0N8ZGP
    IbOKfA6ALR6hvUcZZSBuKY1dDb8d8RwYAwik8HoOjIhUCafXrgODY3JwqG3yykm74W15
    7em0TOoJuktQvfp/NRUJlsP+2+vky0FxmpZORnuW9Dbnlw8BVVAJxXQhCDmtWEZZCZAx
    judgLdXdW/DahnQRttqX5MxZKM5GpzdxZ4eXWew1TuuI9exrYgqyGCDuC6BunBfhOSLR
    jUZA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGk/2mpg+g="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.1 AUTH)
    with ESMTPSA id Uce81bz338uwvsU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 3 Apr 2023 10:56:58 +0200 (CEST)
Date: Mon, 3 Apr 2023 10:56:58 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	Alexander Grund <theflamefire89@gmail.com>
Message-ID: <913352448.1492969.1680512218678@webmail.strato.com>
In-Reply-To: <13330.1680277887470577775@lists.cip-project.org>
References: <TYWPR01MB942097E72E616833130EAAB292899@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <13330.1680277887470577775@lists.cip-project.org>
Subject: Re: [cip-dev] [PATCH 4.4 3/3] ALSA: control: use counting semaphore
 as write lock for ELEM_WRITE operation
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
 <cip-dev@lists.cip-project.org>; Mon, 03 Apr 2023 08:57:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11147


> On 03/31/2023 5:51 PM CEST Alexander Grund <theflamefire89@gmail.com> wrote:
> Do I need to submit the updated patch as a new mail? If so how'd I do that, e.g. with git send-mail? 

Normally, even for small changes, you would re-format the whole series with "git format-patch --cover-letter --subject-prefix 'PATCH v2'" and send it all again with git send-mail, adding a note to the cover letter on what has changed in this revision.

CU
Uli

