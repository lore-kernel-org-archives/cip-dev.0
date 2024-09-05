Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECBCCD5BB7
	for <webhook@archiver.kernel.org>; Thu,  5 Sep 2024 12:41:07 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web10.8175.1725540057304738917
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Sep 2024 05:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=SChPDwkd;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=5OPwl6Vy;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1725540048; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UXX6C1GgFDy0zdmfBBTbGArxjIptfmvFmiNOOAJy6fTmT+txx/qr8xwJH/0ylVDlMP
    Pp8bnSNtGuPo0+1r89M1C1exez33sVFI7DQltkWkTQwKRvZz91Dl9AolS1az9dqAydEd
    xIF/7oRTBrjRARMXHNx/Zwdzu2LANiQG9z8YPsBdLiJaee1I3N55Kz/RvRzmEviHGogc
    Oszea0GZfnEn+5svBt8j0zt8Ri0fPGWuEFwZmFpfqV6fqpul4F2Jk0vR54aso9BXCk8i
    MHOvtJhxTKXbTb4fSIEVcN4w4APBk/0G5F0B2TV05LNhOlCIXvmp7QSNYmXHGiNQIjVZ
    bSKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1725540048;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tmmXyNH8LZUvCbvC8zXThusI27MJQm+7dcHnjCFe8aI=;
    b=s7kJcft95XLX/RgdQSfEZEK+2/3If4J7/hOMvvWmhVF0JYr6OnU5i0p2X+/zaBM42M
    FXoP+OADcv5IhmHP9g/vVKw9Ybef+AxeeMTiH3Ni1eyrlErEcZXCx4PfuKRtAP/6VJiv
    BN78n4lpc4/Il8/npCIPkWfS6Yl3MhevjvzycMh2ujdQJhcusNnEGzuXPzZ5OWLVIxLU
    HqMRkK6PU2yB6859lMIKKCQlYSMNHqcAGnHEIebBW1xAyIHnAtETLzU6iYWoqSbEdhzV
    mDNkOtKmd+n0jVCMj+JcR8W1BEOGxJPF7Ep5MbXMiAfEtvHxtTa4kDRI2XazJR6+xVKC
    nSeA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1725540048;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tmmXyNH8LZUvCbvC8zXThusI27MJQm+7dcHnjCFe8aI=;
    b=SChPDwkdvUiP5eFcwHzZz+34SgPnw5cUjSNXrLT28Wj9mqXrvBXkMp89/ETxlhDw0X
    EyPAfe1t0tZp1rOUsearcGGbB+aNxi15loHkQb1JtIu5nAZeAlNiU0MSFCf8gR0VxPA8
    m6BDve4YP/yd8Gy8skvGg3Ior95a7LFgKMdmF2xLTU3PwRZL8ZbnrTMK5o0Q9fppN1KO
    tS8HE1LLZNwea0FRqzXoSzzNvG4ZPoPEd5lS1GxAjiliRlrlwpH7pVvZICevBXypeAYl
    wA0+pzdURkYyvhM4vx8/GGK8jHsVUKZ2ksXLD78eynAsCfFUV5xT47hMLSNi1WrEtmkp
    Yb4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1725540048;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=tmmXyNH8LZUvCbvC8zXThusI27MJQm+7dcHnjCFe8aI=;
    b=5OPwl6Vysa5LLIl/0ksc72bsi6d+RvCpinBnWik/7XGACrFGXZ0wndFLPwNnzlvNpx
    scYWSeVizUCVV/57npDw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqIHiuLmP1Lpd+UesJUZWVaudd1Gjb1n0"
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.3 AUTH)
    with ESMTPSA id z960a6085CemD1t
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 5 Sep 2024 14:40:48 +0200 (CEST)
Date: Thu, 5 Sep 2024 14:40:48 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <210611616.6336210.1725540048124@webmail.strato.de>
In-Reply-To: <Zthc0X8oAPukA+bf@duo.ucw.cz>
References: <1429823644.5400616.1725385132328@webmail.strato.com>
 <Zthc0X8oAPukA+bf@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st56, 4.4-cip91
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev67
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Sep 2024 12:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16853


> On 09/04/2024 3:12 PM CEST Pavel Machek <pavel@denx.de> wrote:
> > Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc
> >
> 
> Thanks for the heads-up. Your backports look good.

Thanks for the review.

> The parport change... "9f1f1bc701217 dev/parport: fix the array
> out-of-bounds risk": I believe this is still not correct.
> 
>         if ((str = info->class_name) != NULL)
> -               len += sprintf (buffer + len, "CLASS:%s;\n", str);
> +               len += snprintf (buffer + len, sizeof(buffer) - len, "CLASS:%s;\n", str);
>  
>         if ((str = info->model) != NULL)
> -               len += sprintf (buffer + len, "MODEL:%s;\n", str);
> +               len += snprintf (buffer + len, sizeof(buffer) - len, "MODEL:%s;\n", str);
> 
> snprintf will return "how much it would like to write". So
> sizoeof(buffer) - len will be < 0, AFAICT. But snprintf takes unsigned
> value, so it will see huge space available and overwrite.

You are right, this looks like it was meant to use scnprintf().

CU
Uli

