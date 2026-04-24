Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4771FE51F3
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 09:19:23 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.17098.1777022358147743689
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Apr 2026 02:19:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=X9U1Bl9m;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=HUpXa+30;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.51, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1777022328; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PX+sWjfpYJ7R0kIc1G9nz5zEUUYj6TOuvEhQDpL+5zZ96kS+bEPV4Ux3r9z4+4JR2T
    G7FlwK9uYytxQ6R7xnyvOCL2hEr7ZVQgHADapn1oD2nPgFyetMlVT9zGB3heQ1xj4xl0
    iVDtf5OKlLehEts/dhWEq1M+n6ewQE9JolPwwTpVTyBbEgobfPyi8Mczi37Jnim4LgW7
    00VVsBghWI0+1JLACnwjLuf9m2kDf5e76K0dXZ+/P6rczImNX2YC7TiANJASVlFL10uU
    ZRFQ0GnsqAN6D5oiosKnEELHXtqgqoqDrZTGHj9XVMiI4JJZ430sf349g2qJEOzqX8JN
    ge3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1777022328;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=tVvYhQQmJBzPGxHQu5IFYsy0TUeQxSi6pcA5ljTTTXk=;
    b=lfDVByLPjW+hKPJl8OHd6qe993EcmFe+m0sJAkxA2dlpR5LrB6CVH4dAgcY1Y0VAze
    RTzqQuNc7XRukqYzemkQu0u6SUtZGDwK1GMOXSdfDG4fEMqvRqd2U6CiL4yMWF6S++DM
    KybH4uOma92GsnYlQ5M2qNj11NtiQAguJMCVtLFq8rL9OvU0KePLuYOBnHnCWD8Q8KYS
    0AKCo6Vjb921XvzLqfOOSDQpgw7PcO2agZ43U7MkehKATfyb4ViYXFOoPVczjog5o5/f
    I0KGc2SUNzmYqvoPDY9pnkmKVFL5oW8sWi+HtJ2BNbVx9f1FP5kQhbRBW7uwd1Qi+/r8
    kndg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1777022328;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=tVvYhQQmJBzPGxHQu5IFYsy0TUeQxSi6pcA5ljTTTXk=;
    b=X9U1Bl9mECjxPv4ZU/YTP7MIHifYk8mVM387MzRLXzQm0EA1YtJoItaSrMTxsTeQaS
    d82G8A/lZP0f8rVICuIvGAHILQSxudgeubz9eJlOIr8rJduBH5h0nujQNoGMgiUiv37J
    RGLUd/MLrGx5JbOR2Z3OY8TjvNgv98r60KN+QnsfzzVxvp0M2AMW3x3d8NaUn9qiyLLw
    xRUTGTsoWS4NjbsCBhiHcwnpzB1c0b8K479T2sYvbgGLP0YzQxDew06Nm2LQNnDQjZ4j
    pfvV/bcVL7mntSsNSlS70ImPMqjDr4lvjan1NVl5X7r7qfHDG6ytxGh+E/6pWRKJOhvE
    Xa8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1777022328;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=tVvYhQQmJBzPGxHQu5IFYsy0TUeQxSi6pcA5ljTTTXk=;
    b=HUpXa+30OsuBeUvM2HzxcwhdrnzUA3AsQPc9y0C0ExN4THNvst/RbHg938nW3kUXi4
    VMVpuFH5v2lQBPBhVyAQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKDG+LdTmA=="
Received: from open-xchange-core-mw-gw-10.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e23O9ImLSQ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 24 Apr 2026 11:18:48 +0200 (CEST)
Date: Fri, 24 Apr 2026 11:18:48 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <133228110.1250900.1777022328461@webmail.strato.de>
In-Reply-To: <71097281.1249841.1777021987756@webmail.strato.de>
References: <71097281.1249841.1777021987756@webmail.strato.de>
Subject: Re: [ANNOUNCE] Release v4.4.302-cip110
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 36844
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Apr 2026 09:19:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22808


> On 04/24/2026 11:13 AM CEST Ulrich Hecht <uli@fpond.eu> wrote:
> You can get this release via the git tree or (hopefully soon) as a tarball from https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/4.4/
> (Archive processing has succeeded, but the tarball has yet to show up. helpdesk@kernel.org has been notified.)

Now it's there.

CU
Uli

