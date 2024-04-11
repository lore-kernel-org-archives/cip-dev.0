Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70808CD1284
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 09:03:55 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
 by mx.groups.io with SMTP id smtpd.web11.13041.1712826227184848053
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 02:03:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=KyLGvtfl;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=TbzJnuAv;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.165, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1712826218; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=l47BGSqyy3+XxhO/V+JhmpJA11VgIFkfDPD8OZeugBnrU5/4kjtZTO2bPTfu3tQTor
    fHpv04wZK8SwnEzsW7Msc5FX4Vd4V21ybJu/sSo8VkFXU42QbXSFSHvYcI0BRFE02zSZ
    zGnOrbm4+U6PcmzCYo3IX8WuzY5coffIe6UuvHs8IUD3nQvIIpmpum7G34PlGdyrAF6n
    a/vhplEr7/Ik7m0y1aLrN0p22x+E30pRYDbDY0C7gbd1ZIQmviNuGTxYD2Q8Hccpw+Fo
    i5XnQWD/jeoeFR9nUjHQRxMb3DRRb9LmMvNorZaHx5/g9l9SmmqEbQ+wp1b1AGRozTbP
    DNEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712826218;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bzuUOOHKxoZzm4rssxf9txNMNqajS9DHsMO3RsXPo1s=;
    b=mOlVQ5sWDK9HeH9/1omAGJGcm26Q8Bx2+0Ye8JjeADePzm6MCO69bUtjE3EadmEBgD
    AlJ4RUlXenjR3FjZUT7/aLqOS2DsPKBwhmvev4NE02hWFC5bJRbU3Ni8/MVcrvRCo4KV
    LGboIumK5Pdzg7CuSlU5t1KXc4knJnlPgfSJd3OKJBRKFyQEglmh+R67oe4b/Z7bj6+f
    295XbH1OarA6EqTa5htuWgPvY7HSUGc6T4sIkTheHT70EPpYTo6CHC1/dIqGSQsN+r8P
    5ZS/PQ8Hp1Gh5p4WaUDZXe23OHG9t/sD+OY2aRhg4jc4kPyUgL9ZzGx8YYwwmSxtOMhx
    vpjQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712826218;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bzuUOOHKxoZzm4rssxf9txNMNqajS9DHsMO3RsXPo1s=;
    b=KyLGvtflWeuBO0QrW7Gxv/eoqFMJoN3hZKgQ5UzQBKWLfvC+KuOdp8Cy40qqH5l7Gt
    051BHSZwvJ/CjD5Irklvipn14JsJdzqEWQJTzpkRI4D3Jq1QfPywYa2NDoGuk5//CpC2
    u0aLRN5p6WFJ8p5Pn4+L6FExLMPFilDh5aQfVkUMF6AVmUf/XVU0HF2q29V0WgwDn3cg
    e9X3edS2BEcUJLdh3JqRdB4TIWcpvP7NuGIgPE7cejkHVNZjfVSsmeO7sivM0G7lH6zI
    VpTslw6isrUliDRcSAZibIZDtxnCV+poTGHDjqiA8cAqI5UrS01OUBAajBNsz4BiRUxS
    cfIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712826218;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=bzuUOOHKxoZzm4rssxf9txNMNqajS9DHsMO3RsXPo1s=;
    b=TbzJnuAvG+sQZNtjYPI0HW30lrrRLodGzlyXLX4U+5v0ozhvoGD3Md6H7VODmlzrMv
    SlCPHSp4KGEqgazAv/Dw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRvGHqNa13GvhtWeC6CRd93ajscjvWFwDo3mP"
Received: from ox-live-app401.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.3.2 AUTH)
    with ESMTPSA id zaeee603B93c6bl
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 11 Apr 2024 11:03:38 +0200 (CEST)
Date: Thu, 11 Apr 2024 11:03:38 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <984010536.2074829.1712826218825@webmail.strato.com>
In-Reply-To: <ZhUHIa7hW+5VNtEY@duo.ucw.cz>
References: <1155634901.1549797.1712565256786@webmail.strato.com>
 <ZhUHIa7hW+5VNtEY@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st51, 4.4-cip86
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev61
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 09:03:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15541


> On 04/09/2024 11:15 AM CEST Pavel Machek <pavel@denx.de> wrote:
> > Here's the manual backports to review for the next 4.4 release which, as always, can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc :
> >
> 
> Thanks for patches, they look ok to me.

Thanks for the review.

> I'd not bother with GFP_KERNEL
> fails, printk and READ_ONCE stuff, as they are not user-triggerable
> or not really serious bugs, but this is within what stable does.

I prefer to backport such trivial patches as long as they are not likely to cause any issues because it keeps the code base closer to the stable kernel and thus makes it less difficult to fit in future patches.
Also, coming up with reasoning to ignore a trivial patch is usually more work than simply backporting it...

Some statistics for this release that might be of interest in this context:

- 309 patches from stable 4.19 were considered
- of those, 151 applied cleanly and did not cause any regressions that I'd be aware of
- of the remaining 158, 78 were skipped because they are not applicable for obvious reasons (most often because the patch in the "Fixes:" tag is not in 4.4, or the subsystem or driver is missing altogether)
- another 64 have been ignored at my discretion, usually because of a bad risk/reward ratio or a lack of relevance for our use case (unsupported architectures, fixes for consumer hardware etc.)
- the remaining 16 patches have been backported manually

CU
Uli

