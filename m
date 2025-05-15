Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA7AC2D0CD
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 12:48:44 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
 by mx.groups.io with SMTP id smtpd.web11.11429.1747313321939256159
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 05:48:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VG73ilL9;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=wPBb4FzJ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.52, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1747313306; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=esxZnbhXAB8tUkeuX/hpoYQioY2NceKOHZ3XRafVN92CSXjJhPR94fRu7jcQplbhKY
    F2ayElxhT3NUvZD59kYJtns1t6xO95appL+vzMpbwSqIwx8LZlleVSxyHBrDq1VsFZWQ
    QpU6wLXaTDPn3uf17rjIRqFvtmyxwIXNtW1F4hdF6TFpTqwDC1N3FyHJIowlGYblAN2d
    rDnj9XOyk8f4N0pY7mY4trR5TG7KP72+qPeq1r1aWzMgtvjIfZBd5xlhr5mAM0y8v6eL
    NgNRst/1U3Z1uuWtFjRg2Anqh46VRQZSlz5q5uYt9OwIQmB+dq/7a1uX8TrUShzJUKYH
    K8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747313306;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=usc6mowpxF98fqiQqV/omU1LLxMFs0VFJ54jKguPfbg=;
    b=Q+4nd2jRPQD3B7t2HKOUFwcUVgDZY2Sy/c04XgFgha3nSrdWgVSs8ttChQeWp15/1l
    PGkBP6QLZUlYSQvbnOpH6RH8d9xl0fqeO7PBaNMzmlr98bw8rICuyraztkepYq+7VD5k
    6nP8n1x5+Sdb6Y+cbx2NUulhE0xw736nPBVU14gD9cBtu5C9YKaMtkQlEoZcehxb5Zbj
    XMefDSWtE4D+LSSgFwlXUiYgBwNR4BJV18LMd5zY18X7P+aqXAVoqmwoI41n0FCPSSHx
    R9jFMeREIF6+3ZD3yqSMci7h6nootJMhAeZQnv09P8JBBTwvb6uqHLNPZHtGY46MrZZN
    sR4A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747313306;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=usc6mowpxF98fqiQqV/omU1LLxMFs0VFJ54jKguPfbg=;
    b=VG73ilL9rSDr5yWPpcNHtSfB50HyncEqzj38PNjzf3MnSVkUFGMt0Da+n72g8jdl4g
    V/j2b3UML8eqWMDGyqH5W/lmpj1H0bfu2mhR9P3Mqu9NlSyUpAwxN4Sh47KBlgqGzPP4
    9yXDFqflIDeHP2iEHAYrLvBp2XWiqi+zQRYxApsfKTmpRwZ/kmdWC04ejSTTVEZR5aPj
    lyQkbh95zG0e8TNtsTpXuzIbpaC6fcQq4ix/0SyPP2fncB31UTvevDD3c9IJqYQ7F9cu
    PknmCDA6OH0r8OFSsogwsxqKegw6HZ74tNRUsu0XWPW5LlUveiUlb/v4fTjAADd38QfC
    jBgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747313306;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=usc6mowpxF98fqiQqV/omU1LLxMFs0VFJ54jKguPfbg=;
    b=wPBb4FzJq9SCB8wUYDverLj2JF96tB1uwlLh1RilREkJDZlQGicFSSG+xp1xKtT1Pq
    T4tOwylwGXFw5NwR2cAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-14.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34014FCmQSrD
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 May 2025 14:48:26 +0200 (CEST)
Date: Thu, 15 May 2025 14:48:26 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Message-ID: <1520612430.341765.1747313306566@webmail.strato.de>
In-Reply-To: <1605143841.341243.1747313065539@webmail.strato.de>
References: <20250514094308.60634-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1605143841.341243.1747313065539@webmail.strato.de>
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 46974
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 12:48:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18914


> On 05/15/2025 2:44 PM CEST Ulrich Hecht <uli@fpond.eu> wrote:
> Sorry, I forgot that. :(
> Applied for the next release, see 5be7f3340a41ce6731855db578e36004dfe7d441.

83583a7b639959b2461ae47f9548ece1f8821d04, actually.

CU
Uli

