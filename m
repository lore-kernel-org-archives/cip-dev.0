Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CFDC77B60
	for <webhook@archiver.kernel.org>; Thu, 30 Mar 2023 11:44:01 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.216])
 by mx.groups.io with SMTP id smtpd.web11.22863.1680176632656464096
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Mar 2023 04:43:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=MvomCFT8;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.216, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1680176629; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hiAj/46vcsSNGDhE6Ck95v9y9dJeSLsaY9BvfdcJzopiwVe3jMvl/i7aJ+jrLQ9mLn
    f8dUwdgStT+DFNE+XsleWcotESkGQwu04yutQ2veWtz/UGOt03zXvc9tYvAfEdnWVASx
    mPGSPuo9sM9lJx5Ufdtgv16wXmyRkh6jvRaibRDOv5ZfKDjhbBWZ9c6IrN/JenX6teAO
    YVarFSfaEdZKDahqYVvyiOK4jSOiL3GbQdgtDWzB6pK1BrAmQYb/5vedaJLtwvZ8Dh4y
    7244MZH4HBvYRIziDWl5LByPi52USbELtGVAkw8IlFOS4/lZYLPwhg461UzHZZ+lC//Q
    tN6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1680176629;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=D3rfOavpeWPyaqn+KFUUsD/9JGcta7P3frgzeUjPHiQ=;
    b=PHzRTigJQ0FSpTHL7W0hgLo5U0Xcnhes4DYDOm6L6MqIViyLI52XET7YxMGd/GBg1a
    R9/QXJKAJzhSJNpRATnUA0zAxwJ3wy55E+IBIq7UxZdvfk1NsTD4XgLrHk0VlQi2ZJuh
    6WTfBA3NiELANBv6T48d+3NPTaiPNG8cJ6rBUoDiEMy6cQcKmuAvkr/FWEpleU0hGNO4
    zjLB5tZoAlbtsGwVc4hG554IIfnnDuzqHTRIRjplHL04NrQZ0xzdz9uNCQlnJCc0wyq8
    3e7R49ttSO9vsOxMCXaospMJRvEJeBUzHQNdzhhLYKGPVg+3qOyn+oYn0TL1rZshxMA0
    1CbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1680176629;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=D3rfOavpeWPyaqn+KFUUsD/9JGcta7P3frgzeUjPHiQ=;
    b=MvomCFT8pAsQCBq5nNjzYojU4PK8QbV+agGnNLv4Dn8rQt91Lule+58WFq2huUrf3e
    iC6SfabFEqBM3tUZhljDzDnqynftFLJFWVXhjzeD9H2nPNGAkgwR09afawckW3ocZmA6
    MfZTH8l8G2jwlbtT4w5WieyTx/l+vWmQU7E+BRHtSsJtPnVzrOuuuKLXz3mBt9PEmPgJ
    X+nw5OZiHX4+ThqJzQw+nsdQJvvh9RX9nFqPaGlAjxU3+g+wW9dldkUrzLEfInaEjksl
    wRs0Mw6IaQbGwbRIiEpWbHRrb17w91T5HA8LJSz6CRFfLpby0ga2q67DrgiJGRj+jAc9
    whZw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7VzVw=="
Received: from ox-live-app201.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.3.1 AUTH)
    with ESMTPSA id Uce81bz2UBhnloz
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 30 Mar 2023 13:43:49 +0200 (CEST)
Date: Thu, 30 Mar 2023 13:43:49 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@denx.de>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Message-ID: <585376205.1106587.1680176629311@webmail.strato.com>
In-Reply-To: <ZCVzQnoWvB/hIGnU@duo.ucw.cz>
References: <1611211333.1066638.1680166351379@webmail.strato.com>
 <ZCVzQnoWvB/hIGnU@duo.ucw.cz>
Subject: Re: Request for reviews for 4.4-st39, 4.4-cip74, 4.4-cip74-rt43
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
 <cip-dev@lists.cip-project.org>; Thu, 30 Mar 2023 11:44:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11136

Thanks for the reviews!

> On 03/30/2023 1:32 PM CEST Pavel Machek <pavel@denx.de> wrote:
>  | c075aa346 5d5aa2 o  | ARM: dts: exynos: Use Exynos5420
> 
> This one is wrong. Old compatible is used in
> drivers/phy/phy-exynos-mipi-video.c . Suggested new compatible is not
> used anywhere, so this would break things.
> 
>  | 9acadaf26 a98fc2    | staging: rtl8192e: Remove function ..dm_check_ac_dc_power calling a script
>  | 1c4293ded fe413a    | staging: rtl8192e: Remove call_usermodehelper starting RadioPower.sh
> 
> I'd not bother with staging stuff. Plus, these are not really
> bugfixes, they are really cleanups. I'd suggest we drop these.

I'll drop all of those then.

> > Not completely trivial backports, and/or stuff that touches important subsystems:
> > 
> a | 4e3b4b170 9a5571 o+ | f2fs: fix information leak in f2fs_move_inline_dirents()
> a | 5621f7a81 256fe4 o  | udf: Do not update file length for failed writes to inline files
> I assume this is preparation for next patch? | 11790a4fa b06730 o+ | irqdomain: Fix association race

It's also a fix for a tiny bug in its own right.

> a | 30b560087 3f883c o+ | irqdomain: Fix disassociation race

CU
Uli

