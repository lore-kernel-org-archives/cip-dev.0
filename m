Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842FAE8FDD8
	for <webhook@archiver.kernel.org>; Sat, 27 Dec 2025 11:20:17 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.6330.1766834413227644989
 for <cip-dev@lists.cip-project.org>;
 Sat, 27 Dec 2025 03:20:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=UHHO7ojh;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=wwtKikBP;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.161, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1766834411; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hqlwUdu4mVWVpmKDzM5Z/VIi9oPxoKY3LCuJ40iBrs36SXIcrzhDj95MbL3tyfAW5B
    OTYHOpWvE1G/8OiClfVrqwh2bgAFgwyGHiuwlTFxvP3WXogK21mX498HgikN+xyJPPK8
    mPXTVG/HqHJ7kQmiFxzgIbd+gEhWzzxiqIOV0L5MSlYrBna/fm9WlzPoJTizQguNynf8
    8sJR0Isf61hY9sTH/aqfYqTGKsl8hK/gFDDB71kkALuNeHbeBRvEjfdfiKBsyGUJlDDg
    VtyggErQKs4MDTlk37Q7zzStfZPvUuETpykH9eLAd249FdjxkFrmZp03YV9I8AmklOpF
    qWZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1766834411;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DPhIKxf08+Tgzu1i9pSc3JwRK5gpMkLKz6HDEQTinMk=;
    b=loGtX472PBYzlvbhby2fRKtcBYGsdGiVJozeLggJ61JtolgCVlM3/iHGI6JBq6hfFr
    okfTfR5+w3dM3doPXfJFdFyD1vk2dWNZbJMO0w8SxbI38SycUK08Pe8ACwmg2m0Pg2hZ
    p94zlWKVrqJ7pwyQaSoUHBqM+MtungluSzDjKW8pEkFQV9tg3j30p8M0nknIdac4resH
    3FuwQhceackdyPMb2sFABuhwsZ4UtfS3wsplXiKJiKqg0tRJfBja9AepvnyYb+D9nn19
    GdO7OA749uJ42bX73OOc7NYfm9P/mMZbnoxu8bpOPfm/R/cyQyBlkCxhuU3p3Xl3evJD
    9zLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1766834411;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DPhIKxf08+Tgzu1i9pSc3JwRK5gpMkLKz6HDEQTinMk=;
    b=UHHO7ojhXK8e/nDGSl2OmCUO1sCzvAEVXl6cITePbfut7ADCRJoVGFB8NTEXugKsIe
    l4ti6Nj8N1cSEstBWlPXaZ+1O9dLlAFxuWi++jck/F0aH7mlffcQC38xIU9WrvnkCoAB
    DM30QclKq55hHhCCYYlpQHho7MvWkoR7uoeKfihKLZO70ZbnslHf+6X73d46PUfrdbMM
    huHPqtRFHpD0OWLVpJT0yBazk7p9OL75YUyIm66UAmdHcLp1pvtwXrjJDLP1VQxr3AX5
    Qvn5ZbsCGSttZc86fnybKmYAlUw6PRr2Qd4udx8YZadvVbSWEevm9rqOwAP8WajVk7g/
    H7+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1766834411;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=DPhIKxf08+Tgzu1i9pSc3JwRK5gpMkLKz6HDEQTinMk=;
    b=wwtKikBPjZ123sus/0gPs3x7whCE5TfXwW7I842S3WHp21aTatV+V0BEhlB2BA/T+Q
    V5IAKMs6OdE7M9ZS7UAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-36.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda171BRBKBxB1
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 27 Dec 2025 12:20:11 +0100 (CET)
Date: Sat, 27 Dec 2025 12:20:10 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: yann.sionneau@vates.tech, cip-dev@lists.cip-project.org
Message-ID: <1534957620.311452.1766834410980@webmail.strato.de>
In-Reply-To: <1151fc2f-6b21-419c-a655-7f68a6e54444@vates.tech>
References: <1151fc2f-6b21-419c-a655-7f68a6e54444@vates.tech>
Subject: Re: [cip-dev] 4.19-y-cip missing backport?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 40402
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 27 Dec 2025 11:20:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21220


> On 12/23/2025 3:19 PM CET Yann Sionneau via lists.cip-project.org <yann.sionneau=vates.tech@lists.cip-project.org> wrote:
> I noticed that 4.19.325 (as well as the latest -cip126 release) has this 
> backport:
> 
> commit 2b8f2afa311c722a90f00fb2960e6deb4f5100a5
> Author: Marek Szyprowski <m.szyprowski@samsung.com>
> Date:   Thu Aug 29 07:30:28 2019 +0200
> 
>      usb: dwc3: remove generic PHY calibrate() calls
> 
>      [ Upstream commit a0a465569b45e3690be155c96fb54603d6904f41 ]
> 
> 
> But it does not have this:
> 
> commit 34c7ed72f4f04e73901ca6ec2e1db6c040495935
> Author: Marek Szyprowski <m.szyprowski@samsung.com>
> Date:   Thu Aug 29 07:30:27 2019 +0200
> 
>      usb: core: phy: add support for PHY calibration
> 
> 
> So it seems nobody calls phy_calibrate() anymore.
> I must add to this report that I didn't notice any crash or debug anything.
> I was just skimming through the 4.19.323 ChangeLog when I noticed this.
> 
> So maybe someone needs to confirm that this is a real issue, but it's 
> suspicious at least.

Thank you for reporting this. I'm not quite sure what to do about it, though. The options are:

1. Backport "usb: core: phy: add support for PHY calibration". I like this one the least because it potentially affects all drivers, none of which have any issues ATM.
2. Revert "usb: dwc3: remove generic PHY calibrate() calls". Better in terms of regression risk, but still may have unwanted side effects for dwc3.
3. Do nothing. Least likely to introduce regressions but leaves the code in a known-bad state, although one that may not cause any real-life issue.

Any opinions, anyone?

CU
Uli

