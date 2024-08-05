Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF56C3DA7F
	for <webhook@archiver.kernel.org>; Mon,  5 Aug 2024 12:18:56 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
 by mx.groups.io with SMTP id smtpd.web11.6559.1722860330400370186
 for <cip-dev@lists.cip-project.org>;
 Mon, 05 Aug 2024 05:18:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=dRYM6KqK;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=i1Zs/iX2;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.221, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1722860321; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=SFIBLWsdyBpzFJnZXXBKoiPT4ZG98Rl8ZhRITuljPaceGPFLADRerPeQl1r93idkpQ
    5ASIgcLekKnUKqVi/RW4ZbLXt0eSyul7jh7AuoxZLqZucZrsDy+58TMbJM8g1kX5/vNg
    fHfGInssjO8CCCxJPSwxpnx0ARWh3ZChv1Ac82pSZMOFF1t3woHHwLRMBdtxIXiCVZZs
    A+TWFm7mYkMtwiLmPi4FiNn90cszkyNdg5q4+nQEpfJ3BVTfT+x1s4za5B1WBZfaS4Ty
    iwGMfAQltF7XLAYNLnyN/9x5EgTxA4ih56l8/nN8m23LKvLag/g6cXlvMV0sEMfqT3T/
    4wWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1722860321;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GS6i2dOzuhjAMYc0QHnffd1T9fzLtzEb1Nz8TBauUhQ=;
    b=mDDLQ+Xd82QMtJTlDmkJQtNtAl4fcg26UKrNP0jlzen/r6FT/WS0xG40XBoXk4mi3V
    OI4bGyAAOa9ayPzl2NGI8p9884CsNzJ+bBvOQnxnz9+mvlClJavit2mRYNDtC9OXZE5X
    bgZcdhj8iiAaqnnGFBXlMZpdmWELZA0N4Rw0vppL02GXbCT+DOO4wYZCNH/zqepLxEZ2
    oMa7r79aeyIwuJROJb2XwPq5JZ2q3ylRzgC6JgUSyXNnLIHzlfhWZKPKLnwukYxtXsDr
    STT8Mq0Nwy31V8N/Fh1qMogj0QS0V9fyn8lrCp30n2p9F79r4B2dDRPvYkEuMnsbZYdc
    kC8Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1722860321;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GS6i2dOzuhjAMYc0QHnffd1T9fzLtzEb1Nz8TBauUhQ=;
    b=dRYM6KqKbCObHFm/t6l/ZJTB69vHLiu2o0fT8lZ9C6jCUkQ7aUBrm/Gr3eAEaD+IlD
    xD/NhxWPXMn5suFghRbR1dTKSJRKUdR1XApXpC9JCF9jz2XZ2lZQfGAI8RVEc09RpYeM
    8fF5wTRXduyNYMB6YLgguz4xdN84C1GczkT6j7MFkHgLb1aGxpDhrb2Inw1kbO++x4gG
    w+zqSy1W8NDoiEzplcosBVv+rP7Q7oE1ArOmE4i0v6JFqfwIQjRk6GHP86CRNgmsNjrv
    NxUTVdAbutiQ8Rr7RuJsZ39VhVwNmJArrTQDD9oQs8koDvSbOVVITDcBBnwLYdoOsQI3
    XtBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1722860321;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=GS6i2dOzuhjAMYc0QHnffd1T9fzLtzEb1Nz8TBauUhQ=;
    b=i1Zs/iX2wdLLvlx1aXSms4+maUcO5yg5PTX1ZXM1u6HdNwEjq87RXM61JOd9v0/qcj
    xYVuQ7pzjd5FAqNWWtBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7oKNYMuRfGHqdez7mZQjqCOMPS13Ww2eFsaIxefx6BY"
Received: from ox-live-app104.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.1.0 AUTH)
    with ESMTPSA id z5d8cb075CIfvpV
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 5 Aug 2024 14:18:41 +0200 (CEST)
Date: Mon, 5 Aug 2024 14:18:41 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <420384684.3548220.1722860321407@webmail.strato.com>
In-Reply-To: <Zq/HU+sxyEa4gEQy@duo.ucw.cz>
References: <706736547.3348482.1722609934265@webmail.strato.com>
 <Zq/HU+sxyEa4gEQy@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st55, 4.4-cip90
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
 <cip-dev@lists.cip-project.org>; Mon, 05 Aug 2024 12:18:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16716


> On 08/04/2024 8:24 PM CEST Pavel Machek <pavel@denx.de> wrote:
> Thanks for series.

Thank you for the review.

> Most of these look good, but I believe we should just drop
> "5e5344dac2f00 usb: misc: uss720: check for incompatible versions of
> the Belkin F5U002". First, it simply drops support for some hardware
> without really understanding the problem.

It looks more like the commit message and the comment are misleading.
The patch doesn't actually special-case a specific incompatible device, it just bails out if get_1284_register() fails.

> Second, AFAICT error
> handling is wrong, there's probe_abort label that does some kind of
> cleanup but this just returns directly.

Yes, that actually looks like a bug.

> Problem likely exists in
> mainline, too. Should I try to report it?

I think so.

CU
Uli

