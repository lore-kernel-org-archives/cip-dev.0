Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E23E95A9E
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 15:44:00 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web11.65711.1696866231446375096
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Oct 2023 08:43:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=huX/d4bg;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=yeaiMl0j;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1696866228; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BOjn0Sk1i8lE0BWCjrH94R2l3D4cD7Spnk20YRpu+z1iLmhhO536wX/gy+jmC3YWYx
    sgZR/O0Y5mB/CBO8RyWQy5eq8S9deeC7Mk5W64x1XXVPYplv3vywL1fahLG/M1Vi6wG/
    jyKPzPcGUqDgXrZ9xSWEVptl+6SDoORYFtqMY2vdx2VcykoJie8SndO316fkHWlfp69Y
    3CLq6jCZ/ITM4i/LhdM23KQ4kVDSQ72ilinlje8ZmaoBbtj6pJEJr0TKecIwalPYRsXJ
    ZzLbRbP7h9kiz4a2S61TehaDTi7XPmtQAfiXsImGc+eK9GBgztc5QPOvYPFb/6ef9rp+
    jRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696866228;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=m/opiCqBjfyv0kk7TcR8HqKbaSSDSd4WjfwOJj1mAaY=;
    b=eYs/R6uuBMZUMPw9T0UQu/ptjRzzSOWayzY+eIdXVUvfIvy/VzIk+/mi3JeVeKeEx3
    Uik0f/8EWldke+66pnIuoTsVh66tcup3GaV1PHQfQWKpviA6qr8UTErb0NOHaUXIkBLc
    Twl7wQxfXOqJkMi0Vwgi3Ds8GJf0v6+PVKKTZuZa74o+/hwdMLt7C4BLjV8Jza+pUTY1
    +ltx+CbycPILXJ0I7ok3JvcnsNNbd8ln45z7joBoFpdZGUYDqOqtUVEtbEjH/0amoUBg
    Z9e1lEq6MmeT7ZhFVz6ZEUSRDZqg+txXEKLrxdrhX+P0oX9mYrAhRE03/w7bRX3/Cga3
    weyA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696866228;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=m/opiCqBjfyv0kk7TcR8HqKbaSSDSd4WjfwOJj1mAaY=;
    b=huX/d4bg6o4fZh5JvgNwcGYW0wCU0uOX3/qoshHyD6Vc2RECV4hnkDMUH1bN6L3u+j
    qN5rB6FCcqT+ilFY8WHaNNIzwKps2kmeZ1rNcQqhQZ4NBtYGX1q+0Ikxdwt2SzcT+RNU
    PLDiKA4b80ndApELVlMa8YGfGf1vr5EJQeBPX4QEAcM6Gd9+K9h2MrS5siK+9yBTcKXR
    uCsGYXuD6GG58XhGZDVUp0dhS/P6IwfZRHEs1LNTHvby2CcMztJC6MZzeNcWVhzdpmNm
    EtuqpGJwRmiIy5NC0R8+9SYrXKvjz4GMcu/0F/39RW0DvvxyGZkt6eU5MlOBQXyebdb4
    dBIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696866228;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=m/opiCqBjfyv0kk7TcR8HqKbaSSDSd4WjfwOJj1mAaY=;
    b=yeaiMl0jgWW97tgRqlmjV66lZh3/k6cY5Qp52bY3dpVgTrM+LSJFpvQG1pRv933G/2
    nzvcuLKnXON9aikfQGAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B/oo="
Received: from ox-live-app204.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id L04889z99Fhmsl0
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 9 Oct 2023 17:43:48 +0200 (CEST)
Date: Mon, 9 Oct 2023 17:43:48 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <465211865.1460951.1696866228455@webmail.strato.com>
In-Reply-To: <ZR6U9Hx0wHasJ1Y7@duo.ucw.cz>
References: <809419142.671756.1696317771828@webmail.strato.com>
 <ZR6U9Hx0wHasJ1Y7@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st45, 4.4-cip80
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev52
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 15:44:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13322

Thank you for the reviews!

> On 10/05/2023 12:50 PM CEST Pavel Machek <pavel@denx.de> wrote:
> There's additional patch, 67c786df30255e5d38e62852bcfd434168ed1e6e
> "udf: merge bh free", 02d4ca49fa222021988b2791c8efefd70d3228ac
> upstream, but does not seem to have upstream marking.

Fixed.

> > ** m-| dbcfa782d 1b90af o+ | ipvs: Improve robustness to the ipvs sysctl
> 
> I don't see this patch when going from 48d33e0df7175b69a683cece4408dc61d3daf8dc.

I guess I forgot to delete this from my list when I dropped it.

> -- ** m-| 69197b2b2 30188b o+ | rtnetlink: Reject negative ifindexes
>       in RTM_NEWLINK
> 
> It should do "goto errout" for consistency with rest of the
> code... but it will not cause any problem as errout: simply returns.
> 
> But... it looks like wrong function is patched..? I see a place in
> rtnl_newlink() where I'd expect the patch to go?

Yeah, that's what it looks like in 6.1. Perhaps the 4.14 patch has been backported incorrectly?
I'll leave that one out for now.

> !! |
>    b2f54ed77 7bf744 .  | media: dvb-usb-v2: af9035: Fix null-ptr-deref
>    in af9035_i2c_master_xfer
> 
> This patch is wrong for two reasons:
> 
> 1) it puts if () statement before declarations, that's not valid C89.
> 
> 2) it returns with a lock held. It needs to drop the log before
> returning.
> 
> Both problems exist upstream.

Dropped.

CU
Uli

