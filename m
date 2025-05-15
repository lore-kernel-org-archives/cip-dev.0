Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02D2C2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 12:38:14 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
 by mx.groups.io with SMTP id smtpd.web11.11190.1747312690799097251
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 05:38:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=nSl6CUhf;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=JVsyc4cx;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.54, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1747312684; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=bXHSJCpzU43LSt/BSaKaaltL/bwnAh9hklt2W4s7vU6GgCWhvtgDeskRI5f4sgDaIq
    GeTDT3/oGrxf3CKcCrJeloTjcaJVXJojk4MLJqeWbTDbGRnfV7pouXpA/RRqmP6p+2Wf
    0Q1U4vaW3v3WrYJ2BgVsGU7n2wKp/CP/5oXHfEFdlNXvZx7tM03QxkEJsJm4H+tvOfS4
    kIHrJnL5ckn/30ASX7L929zRaXNTZDvA6uBa172AiPoenU1ET1L8UHSIlitMOx64dIqI
    15ERSBcfWRKdpePG46rpoMWwr2bOntw/+jocfr1sMpDmYg69JYehuM7d5PH1kpF4dOHh
    i74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747312684;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1xef6Kt2KS1Qeeijh2h6TIulCEAyxXq13KGbCmDeIFo=;
    b=CC3AORAzDvXWw/MNJDP6DQiD7o5jvQiLBAxk0RLo8J1yrZqjf5j8yVKMTZwga3o0O7
    tpcFxiZS1Qlq1md665QM51NpQX0BCk1SnJ3EnWmSgMm21KFc78IW0dMyH9qfw9Yysp3H
    ei2t1Mpt0sKCPKotvpyRM35raIs9WfRu5G5Mf78oPVxgign/V8sGQ/IZo5sHmIoiZW3G
    VzQvvRO2dXmdVrAZESd1LfnmJ5dv2uOahzrczD6YkaDMP3Rid+eObQTzGtofHoU+1kND
    elZ40xLcgllH0wZY6BKobiFzGWasCDClYHxsB+yghfQJr/lJnRg2mQichV4ojYw3l6e/
    yUSQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747312684;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1xef6Kt2KS1Qeeijh2h6TIulCEAyxXq13KGbCmDeIFo=;
    b=nSl6CUhfFDObJ2K6gZlDWD26kgWJthgd1tjaT85bRP198zROf2wgGRj2XjPoH3MrrR
    qIYkrP1T+q2PFhHT3MhkH7F24xSfnXeqW1DdWyDYNaQyzLguzBk1yDpMkVb2p2kRTSnr
    GgaZwwg/re1wxXjwlWWLBuSGv20xLa3PLhblxSha0VZZRIA9SMEJSoHr9QiX5HHLl1zM
    3Pr2WTrkpCIx5RBaU9zqo7wkPuK1yPf8u78LCd4J+l/e+zDd2DTcmy80Q7+zFgllOG1A
    kS8PoPhYXxq8VnZvlQ7Odd4QbMIAKruXjuqT2LKPDNO8LqZ2xiZvW2zcVCQsncldYcQh
    Zjqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747312684;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=1xef6Kt2KS1Qeeijh2h6TIulCEAyxXq13KGbCmDeIFo=;
    b=JVsyc4cx7MO+gdqNc/cMMQjrPepoFCfrQEWi+XYxrdaK5FIUo9YtcNhW+wwY+AqZOT
    kO7iSjE7oqCIJ9eMadBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-14.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34014FCc4Snb
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 May 2025 14:38:04 +0200 (CEST)
Date: Thu, 15 May 2025 14:38:04 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@denx.de
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1131286918.340542.1747312684534@webmail.strato.de>
In-Reply-To: <aCRqMeCYmmC2pFVm@duo.ucw.cz>
References: <594897735.236352.1747215068214@webmail.strato.de>
 <aCRqMeCYmmC2pFVm@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.4-st64, 4.4-cip99
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 58420
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 12:38:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18912

Hi!

Thanks for the reviews.

> On 05/14/2025 12:02 PM CEST Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> Are you sure about this one?
> 
> !! > ece0f8e21aa7f net_sched: Prevent creation of classes with TC_H_ROOT
> 
> Unlike newer kernels, out: has non-trivial cleanup, so we probably
> want to goto there.

Good point. Fixed.

> > 18a3ce42a20f0 mm/sparsemem: silence "'mem_section' will never be NULL" warning
> 
> Looks good. I'd quote commit id in the log ...

Likewise.

CU
Uli

