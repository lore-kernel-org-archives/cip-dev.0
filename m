Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB510C25B74
	for <webhook@archiver.kernel.org>; Thu, 16 May 2024 06:56:35 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.220])
 by mx.groups.io with SMTP id smtpd.web10.7060.1715842591942167506
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 May 2024 23:56:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=MoNLAR3K;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=U+50APaI;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.220, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1715842590; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dbRYd3K70PpXnxV3t9cJavAUHJy8RQ8PhDxmkZpxmw3B3lXSjcbU7kDiYvA3736uRE
    NAwB4XQqJJEX0UyWJ16a22yOV57Ap2FMWMI9zEOZo6e3OI7eslml/eox0R0Obq10wJGR
    pFYNZ8Y9eRDB+EIP9pcGdZbnpxH3Vze99rsrVfVZDe9z6WhvdLjB7v9QOt7VK4OnFPvW
    D6TwKUP1bmleWCJLLZPTiumNkZYLKl1UhwVeT9FpsRGtszAWaiJ4g3R7E9DR4CPg7bvf
    0v3DCYefKUkCS4e1CxQo7EVjv04IuIyIU6zKDp7snU0TMlcwlYese3W+wXUFXomwjqEZ
    t0Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1715842590;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=47jEsHjMcxGHXcvL7cKMsXPQ0jS63wJo4dUiA7Ik6DU=;
    b=XV0dko+Fnq1m9L+Q65BPBTycD0VAd0rA19DSosimOTUzWM/phmuACDx9xoTXC87Ij/
    wdwu/uqSDXIZEbOSxj18gdSzYxPXyM+A50LhEH6D9uaFi3859kvt/a+z1BCdKcoNuwsZ
    qHI4EP8RrU4/Cg27tJQH2/DyMrS4qZsfmZyZpwdp4jYwAK5R7WAl1CAEDYzNM/o+dcaM
    KTO+NT1R71/rnJUP0hBJ27jdeYhkRhDzk8Sz2WVOLj4mANflgequluhrorQVt4Kk6aUf
    EgWfUm/LHRAppLUspNhuljBV64J0J7EXM1UJBBUrpP1wx3hstdgFhnfImku9HaYoGZWH
    bpEA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1715842590;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=47jEsHjMcxGHXcvL7cKMsXPQ0jS63wJo4dUiA7Ik6DU=;
    b=MoNLAR3KEJhBLc8VmliQRfZWSBNbygHQ4W4SYJ1o4FdxGdDP3z5+8xj3JTt1FvHnTF
    QcZHQBfhvy45qEccvrF+i/X5ZTZtiGGYSoFx4V+SWVYC/33Ko8NmNPpiLsXl23fGYZQF
    xzFhNcmWVc2awPvb22STkXyRBq6VAQjzZYg413o4+Nk3X2J6A3PLK3TuzyxnNmqiyUh6
    VKu/D87OkciSP+Z9ss0Z0brI2nSZSIwXM+I6roipD2xEus9AjdCFEer+EPcakttiZp/8
    JNkVserlQPxGmejfY6zZzWP4sjGxbwnQZSXfC1DaSBOh6BUjG2j4m1JCJgHbCroFI8XB
    cFRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1715842590;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=47jEsHjMcxGHXcvL7cKMsXPQ0jS63wJo4dUiA7Ik6DU=;
    b=U+50APaIZNtXtQcQcO3Q97qpA53dSfWU6pY1Y1xsl1iG/B1967geSisT6RpfRJCnbY
    WG927zwxbgkWeUxZGnCg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzms2ZmlbYqyyj8pJ4="
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z08c3e04G6uTKm6
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 16 May 2024 08:56:29 +0200 (CEST)
Date: Thu, 16 May 2024 08:56:29 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, "Jan Kiszka via lists.cip-project.org"
 <jan.kiszka=siemens.com@lists.cip-project.org>
Message-ID: <2094217631.313781.1715842589168@webmail.strato.de>
In-Reply-To: <00f28daa-1540-4e09-a476-32fd2570402d@siemens.com>
References: <00f28daa-1540-4e09-a476-32fd2570402d@siemens.com>
Subject: Re: [cip-dev] CIP IRC weekly meeting today on libera.chat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev62
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 May 2024 06:56:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15902


> On 05/16/2024 7:24 AM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss
> technical topics with CIP kernel today.

I'm currently on vacation so I won't be able to attend. No updates from me.

CU
Uli

