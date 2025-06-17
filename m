Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F8DC71136
	for <webhook@archiver.kernel.org>; Tue, 17 Jun 2025 15:05:42 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web10.21477.1750172732914162578
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Jun 2025 08:05:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VzuKebmj;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=WOzDjSFT;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1750172726; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NcnTaflvsHei7l0zZnP8Ob9mR6sPRawkJNZDijC8IvHkPoJJDY8q90Dh+kb5Rdy43N
    NjVvvq9bqhqjxIwl74XbRi2mFE5dCUYhxT2FGNUvsu2rCvRFYplipw3D5ptBMlP1Jm+s
    Cek1+FuhVK08+zKlPtIWQVdue+ZKnOHnA0pXYG6n6FCuPlVR/VbB9Ft27WkcNOSmzhLY
    x9DaQy1ss8Zo49fLvMqrasGCkONi2AJJ2aPTcHjCkCmcIGnN7mWa/wwf0bNustue3upg
    TNlA/UfvJJ3vtJi2Wml+nowdmjq6nIjwHosW58Fm6WywkVXwV5LXATkcglntUQgEidJx
    aj4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1750172726;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=C1FT13uYAONwtlLA6GP1ebP9tKU7daQ3XZ118bF/hOM=;
    b=QmWs4/S8hje2HTXdWeyawGE3qihsl1Cd9rp/xPpYI3oEuS0+1crjcwZfIzarIZqymc
    KuNeD+wZVw6MoRmohKJM2HHgLHbQUXp2vsd1W0xyE7HT8G882SXN1xkdbittgvShBr2J
    KtlMkMJrrSVBsjHgnIAiRGlRt0n5TjOx1K1G7YX1UH7ZH+GjajwMh4KiUNrOS2oQFdTG
    FwlklZN9hVEYF8donipX9C5xa/r1kH34Rlx/V+DVxmY7IRg/wuCD7Y0l4XryoyNgN66D
    KRZSdYlSdXhehcF8RD2i6zi4v5dkZQGqU/EPxFWwIoRaTEGepl8vnd3JmXUYb5o/IF31
    zJog==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1750172726;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=C1FT13uYAONwtlLA6GP1ebP9tKU7daQ3XZ118bF/hOM=;
    b=VzuKebmjKJX1olo5mvO3AOiYCcsHsSgw16QP9UcP1yr0/uGY3A7PrANoc5QZ9wHk7L
    r91QcunjvpOADo18OVex4JlbdaCd6MdoyeOZE1KGieTCc5aa8sM5FvlcRG+NP/wz9KT1
    jWI4qbOzN6fjWnt8hfp2Oc1dK1Wz5zQ7lH3JBEAtxGgedhhKTMNT/l/IOFvyS+4NU765
    wgN50N8jEPbTpyR1kVjAkb60fldSwiCOwGkHaIn5kHJ7+PZL25PLdccTeRxpvXnjJz6C
    JBWiRIU9+LBooI39Pl6z7ZwG6OhDbxzP8Nat3Hq3rRllVYQanTjOIuDmK4BkjFkFAz2N
    PHAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1750172726;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=C1FT13uYAONwtlLA6GP1ebP9tKU7daQ3XZ118bF/hOM=;
    b=WOzDjSFT1vO21iNL1xo/hWbB0NRAuE0rNvWqVFMkPZwPaQmIiDP/sV6+bdFowy7+kr
    5e7odMyRE2KiOCTDOeDA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-27.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34015HF5PQZM
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Jun 2025 17:05:25 +0200 (CEST)
Date: Tue, 17 Jun 2025 17:05:25 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@denx.de
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <551448465.231192.1750172725438@webmail.strato.de>
In-Reply-To: <aFFBeZA4Tnlf3d35@duo.ucw.cz>
References: <1652754680.135113.1750092922654@webmail.strato.de>
 <aFFBeZA4Tnlf3d35@duo.ucw.cz>
Subject: Re: [cip-dev] Indirect Target Selection (CVE-2024-28956) Re:
 Request for review for 4.4-st65, 4.4-cip100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 55736
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 17 Jun 2025 15:05:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19122


> On 06/17/2025 12:20 PM CEST Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> Should we add something like this?
> 
[...]
> ---
> 
> Document that ITS workarounds are not present in 4.4-cip.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> 
> diff --git a/KNOWN-BUGS b/KNOWN-BUGS
> index ec2de4aab685e..b268e54bc96e4 100644
> --- a/KNOWN-BUGS
> +++ b/KNOWN-BUGS
> @@ -19,6 +19,10 @@ architectures.
>  Random rewrite from 4.9.320 was not backported. We have seen no good
>  explanation why it is needed, and it is rather intrusive.
>  
> +Workarounds for Intel Indirect Target Selection (CVE-2024-28956) bugs
> +were not backported to 5.10-stable and older, and so are not present
> +in here, either.
> +

I guess that can't hurt. I'll add it.

CU
Uli

