Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF719C9830E
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:59:54 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6134.1790251187757175723
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:59:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Vvp+w74z;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=GSx075dz;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.166, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1790251179; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HN97PscWrRjQ7VIAoJ1PQTm47AwZkWUKswaSuxsiFzgoTbWEsi37c6eL8eYrNk3cxV
    e1RYekfPgUjUMGqtxoGR+kywARHZUBdYUU/w6H1mrefQv6dyVKhcPkBa7hcVYClA/b/J
    wDSoaENWOj3piw5q+TPGOsax0PJZIQzuoz/akBLyUkybsQTwlK825GNNunY4clW3qs/b
    2HenKRlXwg2yZRxZccYoOuepcds18WkcAUCVr8l0sO92JYJULTvzgHBWYa8fvQh4+6ct
    4TekOCQ/dDhzNqgEvcu8xoXHM9+rMcN9cBwNAZB7N1qcjU3PuUhiDmaKhxgEIgQT8b7T
    um5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1790251179;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/gk8vQdt7Dy3ZKq7aGJs//WZoCrEZmH5qfro8cVptaQ=;
    b=oDkfF1dGc8Ksaej8JijNCpXNb8AObQJYlhfw7kuONQ5MJHhL7S8ReJXZWhj/mElW6p
    N/zuTIM7FDyOTzIVOHLLnsRV/PU/I8sQC9OcZC/4R5+S2nk+p2OTsYlawyR+FYDCK9SS
    21eMRP5rUnvEjyIwojKpTnm/powVl6j8ChlxBr2ObQ3PbgMZIHHDhAyZhqvALk8XHNhI
    WPr5o0MB7SU136FU8dtRit9XxmsMTIds0lTVLMvNTecMK2ICih5WseEvQgvZM5b+YAPZ
    ywuMOj4uTEdrt5yWm/V9vpdhAhCY8KLDCTa1lo3ZxFa84cpjARDQ1kuOejvyOynundvP
    DXsA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1790251179;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/gk8vQdt7Dy3ZKq7aGJs//WZoCrEZmH5qfro8cVptaQ=;
    b=Vvp+w74zKRxge54ojwnFK40zsLtB6//Yc11rhS1uZ5dEjHqzpO9lYSWSc59ECfLB9J
    yV90BSgZJ3iRPvTBO+Yg5QZemku58ZiLgl5BwvUKYGx5ik1+duO1sK2cY0Be8QN6iEBr
    2lDT7A6HyzyrLMv0oVJU8TcDt8yXORQ9bqNsepCf7zYkV4WFYtrHs0yz56OJv5+AGQY4
    nk6rujKIqsEkz2UdhHDhFH/GXZpISNRBxlYWdkAX6qTV2i+zT9VkjDhmu9svQHUqr5j+
    mMuF4DtlLLbWLK9BwSpRYc2IfO+J8FiF1X59BIBu6hxIqSlI/AgHxMKWeWPBoy6cSJWX
    Hskw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1790251179;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=/gk8vQdt7Dy3ZKq7aGJs//WZoCrEZmH5qfro8cVptaQ=;
    b=GSx075dzc8N0E7VAylpHb3lYEQXTwp16t5mMXQ2gJ74tDiQO9CtUJZdmK2DLtdKolr
    VPxYA5MGvbBlChi6cJDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKbL+BrLItU="
Received: from open-xchange-core-mw-gw-8.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.2 AUTH)
    with ESMTPSA id ze24d928OBxdeyE
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 24 Sep 2026 13:59:39 +0200 (CEST)
Date: Thu, 24 Sep 2026 13:59:39 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com, "Pavel Machek via lists.cip-project.org"
 <pavel=nabladev.com@lists.cip-project.org>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <259947304.47633.1790251179429@webmail.strato.de>
In-Reply-To: <arUPTC54RINDdYlb@duo.ucw.cz>
References: <1957665225.34596.1790092309178@webmail.strato.de>
 <arUPTC54RINDdYlb@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.4-st80, 4.4-cip115 (sit down
 for this one)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 33628
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:59:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24337

Thanks for reviewing!

> On 09/24/2026 1:53 PM CEST Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> It seems commit ids no longer match what is in the tree.

I don't see that anywhere. I have

commit d482fcdcb9cf5510101a9f26cf5e94fdba037725 (HEAD -> linux-4.4.y-st, origin/linux-4.4.y-st-rc

https://web.git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

also starts with exactly this commit:

> a an API change, hopefully noone depends on that bug > d482fcdcb9cf5 net: ipip: require CAP_NET_ADMIN in the device netns for changelink

CU
Uli

