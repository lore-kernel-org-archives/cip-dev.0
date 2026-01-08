Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F163D14893
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 02:58:20 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23668.1767841097819829559
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 18:58:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=BwIUY832;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=K6Ty8Pk8;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.54, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1767841091; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=O6bbHSppeVzJAkxcs+RcSUgfJc/+FXYpawv22YwkGqV9+EPyU7tQuuv1kSaLj6fOfR
    CxwtgxbWrOOVr14JkBSGZ4HNNDs0zs2K4NN81o+4jfIU+peIlwpBIBJqAeQAqVM3CJEE
    CauBZTVYetA57GyNp9QN2nTI4BTJR3rUAXZuAOiXIlNXvuGuPH2WyRI0jkUxlG2bIlP1
    OKftYpDAYbHW9L9f/Kmt1HkbgU+IZwNSezsfqN9ihwR+WdzR197yQguorfgmgAwk76pd
    bQn3tc46B8EsDtC6gapw/MxnlujPZdWNIfiz9IMo8nxxZs/NKrtJL527TlYV1uol2Z9b
    Pavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841091;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BR5p2UlqHyN5zR7ILokxpbJ80tcg2j2Qer5TfykSnpY=;
    b=Nst8L6wJ5g17AZa9LDSRNP64Xj6mD78+hPEIlvTBWPnJ5wiln13N6LsE+tznyye28Q
    5TxuHUg5q04cm1dexDpMmq9T644DFDpWtt4ih491Cvx8z9BghPXgR1cHkRVV4ABAEZhb
    cd4Ah4lcHPcMLl2ltyfavSf0PzYxhlJkNft9MnRLj3HY5+QtH7SgUQ6/ZBi+7KUzjx/x
    /irHVwMjNsWeCNmjAP7wsvtoI4X8BSxKHRebLS7No3SD0LudY+1yw4hOIX5TNAICiyas
    FZA5C1SL/P4lv0WOeVvVifalg+l0sqq3TFWQmpdCNLosiQ7JKX3JfYsH4+E5D/VDJpRZ
    6aDA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841091;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BR5p2UlqHyN5zR7ILokxpbJ80tcg2j2Qer5TfykSnpY=;
    b=BwIUY832VvBreq6ybrnZpfwonkF+u5mB79wXCdufXupEyEig7pRAMGtftV4RjFOqj0
    ZA8Ns+gvOioz20EVHnwtB5tVcTwRNgWLlL/Z3Q4TQTkhc4ZYu+qN5s66k4eOjRy1c4MC
    snaA8WAmzRRjGo9Hbb12lxOpasYkXbFRRRwOuoerjFbQUXl1yGhimJMwHJ7OFhQKTR9F
    iyyGe2sJ5Dx601bYtDmDvpfDEGawQWgIXjIrBqa+8W5kqMI88Xl7TbcGKGwTN0J2P2Lt
    4s6RLRpquAyWPtImcB6hjjy0L6KMw4+n75wEscUPhCGju8jCmxWiTzrLJfUYV+er3zz4
    QngQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767841091;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BR5p2UlqHyN5zR7ILokxpbJ80tcg2j2Qer5TfykSnpY=;
    b=K6Ty8Pk8w8n/45ms2p8pXaFESB+ATfROE18Ixk/H8lBKdciBbSy4lby5gHqXQf1dR9
    gRbPlvBosSBHBa24gpBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-33.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda172082wBVkC
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 03:58:11 +0100 (CET)
Date: Thu, 8 Jan 2026 03:58:11 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@nabladev.com>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1226344655.426256.1767841091628@webmail.strato.de>
In-Reply-To: <aVz34wWa/HJhamyg@duo.ucw.cz>
References: <1675394165.12181.1766987804067@webmail.strato.de>
 <aVz34wWa/HJhamyg@duo.ucw.cz>
Subject: Re: Request for review for 4.4-st71, 4.4-cip106
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 42670
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 02:58:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21429


> On 01/06/2026 12:54 PM CET Pavel Machek <pavel@nabladev.com> wrote:
> These patches look ok to me. I'm not sure about iommu/amd change -- it
> will only work if config matches between normal and kdump
> kernel. Likely noone uses this in 4.4-cip, and mainline would have the
> same bug, so I believe we can keep 4.4-st71 as it is.

Dropped it, thanks!

CU
Uli

