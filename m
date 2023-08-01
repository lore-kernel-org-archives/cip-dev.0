Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B1AC0015E
	for <webhook@archiver.kernel.org>; Tue,  1 Aug 2023 15:25:01 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web10.15788.1690903491905411314
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Aug 2023 08:24:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=IdGfEonc;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=EDxMkodK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1690903488; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=c1Q+UmBayw63gakoq3m50Ko0SV0X8JJtw99OEWvDiZXpKZiH7gSMG5iKcssmQs0OEB
    ZZMHZjbMTow1rzqtaVgvEhJWuC88wp8iBwDGfxnqSzzbm87YkPJ4S0Br7LzPJbcUYwk1
    5ujG1qpaF32nKguGJNvQ68EPMWvwstZORrqIatkggvEo+HnhSebg1a2/k2WPG84utlMj
    LTDV+uRcsMamXDy4U2FcJHwz3xFRZgWVLH1Z91UFVxp5Ypets2HqXn3bKfRGgP3b4rLQ
    TXjgQnsx263GGoYH1zb/RrNmtuFX2a5tRiuMyNNaEdRXTcmT8iS4d62XidUpEmKRH9Vr
    b9BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690903488;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=0k2XnnUXBjMvDIXiefBWsaaA6U7PjM9uCAVz5L6cclI=;
    b=iu3tEG54O9Mi9OCbmNKxlJpjONk1hUjWJwmCSbG4B4UBpdkrB6QDglDpl3QcrFkgnU
    /fX5E8urDWdVhzeCmxP8jY52JbPBWlSra6JMgFfTARDJB880vS9xzTNi1WFAGVxguxD0
    t9yFwGOfOFvLBPrvgIUA6vcpiuhSMPcMfB+bpe/OWnvrqdJzoWcYY+fhf/o77LOdeOzL
    8T92Jbc6Sx5v5AMn4EICD8AFojmf4i+StF6cSCAJM/6cjreInrqis/jIG+8w0sqpx8bK
    +b+076M+Gtwt3r6K8HsHhtMTjKlKlt8filOgYs/WTtCbRaaEr27c4FQDlgEm7n6EnA5J
    WETg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690903488;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=0k2XnnUXBjMvDIXiefBWsaaA6U7PjM9uCAVz5L6cclI=;
    b=IdGfEoncH0JZuttt3P0cvMUlYs09AqyjKaFYDkt56B7E/r9xo8eEC5s69j9WhSzt0o
    /9BxSveV8oa0uMb1PjM9e/zTdLLVSLy2IEVHWuwwrSv1JZ/eax+/ISMC0aPwsZiVCDjv
    b2C2AsalRABciHRpGkJJUfS4O/FuEfQrZyvnd86GWkU7lPwsnUQQFkx1/uM1BzktJfz+
    MNheZX+PRCFoPgPrqaqv7MtZY6kUJRP1E61IK4cUEhSSkxhAdFa9Ck/8vTVw7nLE6eO4
    kK5fQvTx3u4Z7kBu1/LgceQV/nmooKb+wJubkIDkZc0d3/5axe+VNpAyAGc4GFQLU1rR
    ocrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690903488;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=0k2XnnUXBjMvDIXiefBWsaaA6U7PjM9uCAVz5L6cclI=;
    b=EDxMkodKiaZcfBrFrZKspryNITmLLDbKbjknMFZouu/uGCoxoXDrAesO05cxFZOtV+
    R/4YwzQ0nqvdsSyO+rCg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+P9k="
Received: from ox-live-app205.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.6.6 AUTH)
    with ESMTPSA id wba236z71FOlSwe
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 1 Aug 2023 17:24:47 +0200 (CEST)
Date: Tue, 1 Aug 2023 17:24:47 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <978219175.1863495.1690903487741@webmail.strato.com>
In-Reply-To: <17708F7C47443676.32062@lists.cip-project.org>
References: <721088923.1980911.1688547506942@webmail.strato.com>
 <ZKsPiq6+/Zx1CLHr@duo.ucw.cz>
 <17708F7C47443676.32062@lists.cip-project.org>
Subject: Upstream hash format in commit messages; was: Re: [cip-dev] Request
 for reviews for 4.4-st42, 4.4-cip77
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev48
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Aug 2023 15:25:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12531


> On 07/10/2023 6:47 PM CEST Ulrich Hecht <uli@fpond.eu> wrote:
> > On 07/09/2023 9:50 PM CEST Pavel Machek <pavel@denx.de> wrote:
> > a| 61256d2d6 None o+ | netfilter: nft_dynset: do not reject set updates with NFT_SET_EVAL
> > 
> > Usual marking is "Commit xxx upstream.", this one has [ xxx ].
> 
> That's how the commits come in from stable. Are we using that in an automated way anywhere? If not, I'd rather not spend time fixing stuff like that.

[For those playing along: Off-list discussion revealed that there are indeed automated ways in which these things are used, so we need to fix them in some way.]

I have come across the following variations in the previous and the next release:

[ Upstream commit {hash} ]
commit {hash} upstream.
Upstream commit: {hash}
[ {hash} ]
(cherry picked from upstream {hash})
(backported from upstream {hash})

Which one of those work, and which need to be fixed up?

CU
Uli

