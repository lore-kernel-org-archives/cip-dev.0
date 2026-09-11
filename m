Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B9AC88E4C
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 10:15:37 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.35978.1789121729935956098
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 03:15:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=CuBGSsuV;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=oOe/CYd6;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1789121721; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=moihfs2s70yiI648AC7DUcd/9OUCMHvtAHBWAzTOvhG0fTSPsirRm35GL04zJF8H32
    1VWumqsSxrNOHpo28b/eVEt0HOX99AdL17HeaGBNBxplCCb91qfrWJJsLiqEZK4N+xhe
    ObGa0mH8QeG004TuvvELouQxEdI9vmbE59UUTzmraIuhfQ1xkr5ikgQrvtb8KyUg1I7B
    qKel1nwOs3EmUFZEw8L1jXluSCfVdZ6A+5sFRixoNlWTirGOkTvRDxoK1eOrCwKwQW5c
    IsRgZ5ypk/Qp+gSeTsCNjlQPaiphF6ugoWIgmrR9H7FEPxU3ycIuuLxa/qICxmnlHCCp
    L/8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1789121721;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=I7P5koznylGZqSEFwyy2/N1DEkv+P0X3+PNLxbRga00=;
    b=Ia7hw6XKf+d6PaYPFLWLMicLW596nyhTubINH3td9Ld8Qg2GwqogeXkYzVJqunJ4S/
    QATUqG+Z2g7s85a0fV0c5zERbtlnCS6RSCpPzOrtVJpv2riUCS6wNRK4iDT3DBr8BfRz
    kW+zzJmYD+pE2j1y84noYQMOxYSmbVHYULHE5ESE/GnBDZgbKDW2aFRk09uxCuR9mJiN
    auKhUYpwgWpeElvuv/TlEiVc+4byfI7rXZIFIjyRNvSD3UppiwNYu9bs5fq8/sT3Bx/n
    mo0iVKxRptmQ6ccw4iKPfGfqEFKL2qDfuxP+sArudDVdk5CcGo5oq9TGLwdz25j085Tg
    Of/w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1789121721;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=I7P5koznylGZqSEFwyy2/N1DEkv+P0X3+PNLxbRga00=;
    b=CuBGSsuVm5BOVnha0Wx/GzHUQeVhZHFeYVu+/R7n6UpX8SzbpYrvL2cm6mW19mgBAf
    sU2QcQj7awnmKIUqplJz9TSVQ8izjIfke94dlBN3wn60akXhVPF1MZ/9miCXmqC6nWeC
    uv1hnx5+ltHRTR4LwOMGIq2mFGjrwlAFiWd6eet2tFT1r/oSW4Oj772uGoTIpPtzQDkp
    EUthB1wiYYsQi88j+Vped2P49mH3PEJB6eoA1A6gUPL1NBlCadTZyavKs+ZF91wLZl5T
    myTVq57v+Ft40pOQaLpEF2R0bWAkEoUS4R3iACvCuAXRkHTsUilL/K629tfgIyHp5fCC
    9w1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1789121721;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=I7P5koznylGZqSEFwyy2/N1DEkv+P0X3+PNLxbRga00=;
    b=oOe/CYd6kwQlesRq9205tXxtV0BiooMgiTrbXa5v0LdtOfpUeQe5rJ0wLk00QJxa+U
    KF8j6VqeoGo7LSWk7ADg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKHK+AR2fLw="
Received: from open-xchange-core-mw-gw-0.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d928BAFKjQo
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Sep 2026 12:15:20 +0200 (CEST)
Date: Fri, 11 Sep 2026 12:15:20 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <315575947.88377.1789121720672@webmail.strato.de>
In-Reply-To: <aqMF3bvKF4A-mzbV@duo.ucw.cz>
References: <588742173.259606.1788373971804@webmail.strato.de>
 <aqMF3bvKF4A-mzbV@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st20, 4.19-cip136
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 43312
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 10:15:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24129


> On 09/10/2026 9:32 PM CEST Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> Reviewed-by: Pavel Machek <pavel@nabladev.com>

Thanks again.

> Most of the patches look good to me, some questions are below.
> 
> Thanks and sorry that it took so long.

It was a lot...

> I guess I'm confused here. This one is not correct on its own, as it
> creates non-balanced situation. Is the 1c72d53630aa3 fixing it up?
> Where does 1c72d53630aa3 come from? Will it cause bisect problems?
> 
> !! > 1c72d53630aa3 NFS: Pin the 'struct nfs_server' during a FREE_STATEID call
> 
> This one does not have "upstream commit" annotation, and I could not
> find where it comes from. I checked 6.12-cip version, and it looks
> very different from this.

According to my notes the chain of bugs is as follows:

- "nfs4: take a reference on the nfs_client when running FREE_STATEID" is broken.
- It is fixed by "NFS: Decrement refcounts if allocating nfs_free_stateid_data fails" (which I have cherry-picked from mainline and forgot to annotate).
- The latter contains parts of the 5.10 version of "NFS: Pin the 'struct nfs_server' during a FREE_STATEID call" which are therefore omitted in the backport.

> !! no upstream annotation > f1f7d30dcdfaa NFS: Decrement refcounts if allocating nfs_free_stateid_data fails

Fixed.

CU
Uli

