Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBBDC3DA78
	for <webhook@archiver.kernel.org>; Mon, 16 Jan 2023 01:08:14 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.web10.155862.1673831285366146990
 for <cip-dev@lists.cip-project.org>;
 Sun, 15 Jan 2023 17:08:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=aEObgxZp;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1673831281; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IR/nzeXNfYfFsf2gYjgJB6/Hk7pftSPt++g3sQPoyKZb7yvbeX+h6m0nF7EnTUtKVl
    LMN6GfyQ3KJ0xrYQsTMkOP1frAmFoaKKNcCWx+P/L3W3Wtm+QPWYoFtyrCIg6SPXrkjy
    kHNiTDQI1US+KOHnhWI2X5xBNhclUDfzF9puzTUCgdYfBGXZ44IErLqr4FAGwM/0bliI
    thRiYkX4EBd9fT1bbo59NUpzauYrP+BayFP2NNN8UwmSj2Q5+QHl3N0KB+s8cj5HAHSq
    zprSz0yH9jYRJnu4On3BkAmjY+xvUdYQ1n0VWbRL3eyIpFoNPkSLeSj+BA3/RRYxJRXq
    W9eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1673831281;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=fi9eyqwk842gj5iLHUatP0yn2+11tRYLjj3VXk5ubCs=;
    b=GFNgfsB9C9+0/D5Xi+47GgSIPnPY3CwLyJKq7um+AzJa/Pa3LTgtscs80ZocPtGotS
    s6d2d3Nc+u+NWDzI9Z8pe3/Q47iAMx3CIswOqRafW4RSETCQfgiRE5dpbBn6bIR+J+/K
    lM+3+ugmKDQlmk0G7JECEdKW+ltP7cjOEKjyoTtD3QhJ5v625Craso3XM3PpIBxY7ZjX
    IBuELKUlhUi+NG02eyb/c5E+OOwUKZ1rBMTHhTo4013sOTCmO8FqCqbE4ttdjdqp/J5D
    0Y5Apdk8gxfAv6vUNVyBSXhlWgEJcZ8+0C7Zme25g4JqIocvmcrb+sumxv1COXLS1P1z
    mIbA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1673831281;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=fi9eyqwk842gj5iLHUatP0yn2+11tRYLjj3VXk5ubCs=;
    b=aEObgxZp9KCkDAkfEDhxiReo3qqct2JGGT+tAJ5Rx7dpQ7VjSbKgMVjg51v+7J/Dm4
    0jHfkfc7cgwgPpD5wicThgsqsJbjYjVIDV4izQcU2TfE6C/2J7OKPOuUdGkC/T9fD4GN
    ymS7bt5dXPHBn9or2W2F1GQO0ZoNg+8ScGj9OQEsvovEjqw58bkD5O5ltP2jg7rltXD9
    qigghoAjfuAeJodveYD6DT8lKytlQT+AsHZsZFfRdCGI5RmnIZ+DpsTPC5H1HE+wFS1b
    SQMRQZs8xzEObMP80exkF6QfFrgbt/mvFG30s4lN6c20KwvMWq3VkxgwRgod0OxQ+/Jb
    sJFQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x28jVM="
Received: from ox-live-app303.back.ox.d0m.de
    by smtp-ox.front (RZmta 48.6.2 AUTH)
    with ESMTPSA id x8c991z0G181AKw
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 16 Jan 2023 02:08:01 +0100 (CET)
Date: Mon, 16 Jan 2023 02:08:01 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1960108615.1128727.1673831281319@webmail.strato.com>
In-Reply-To: <Y8R5rSX/stuomgBP@duo.ucw.cz>
References: <Y7w4dfYgh7d10IdS@duo.ucw.cz>
 <588609118.480377.1673338487702@webmail.strato.com>
 <Y8R5rSX/stuomgBP@duo.ucw.cz>
Subject: Re: [cip-dev] 4.4 steps towards release
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev33
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jan 2023 01:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10369


> On 01/15/2023 11:09 PM CET Pavel Machek <pavel@denx.de> wrote:
> Ok, I'm a bit confused. I remember working these patches, and I do not
> see your sign-offs. If you checked them, I guess I don't need to go
> through them at this point.
> 
>  | 9cb1ee33e a36e50 .+ | drm/msm/hdmi: check return value after calling platform_get_resource_byname()
>  | c132f2ba7 ddbd89 o  | swiotlb: fix info leak with DMA_FROM_DEVICE
>  | fd97de9c7 901c72 o  | Reinstate some of "swiotlb: rework "fix info leak with DMA_FROM_DEVICE""
>  | 136b47994 190cc8 o  | tcp: change source port randomizarion at connect() time
>  | 05a12e5c4 c579bd o  | tcp: add some entropy in __inet_hash_connect()
>  | 576696ed0 b2d057 o  | secure_seq: use the 64 bits of the siphash for port offset calculation
>  | 2ed413f14 9e9b70 o  | tcp: use different parts of the port_offset for index and offset
>  | aa7722529 ca7af0 o  | tcp: add small random increments to the source port
>  | dd82067bd e92614 o  | tcp: dynamically allocate the perturb table used by source ports
>  | 3c78eea64 4c2c8f o  | tcp: increase source port perturb table to 2^16
>  | a81a6b204 e81613 o  | tcp: drop the hash_32() part from the index calculation

That's a cut-and-paste error on my side, these are in the current release already.

> I'll continue tommorow.

Thanks!

CU
Uli

