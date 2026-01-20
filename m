Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F95FD2ED11
	for <webhook@archiver.kernel.org>; Tue, 20 Jan 2026 03:36:59 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.792.1768880212699181371
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 19:36:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Tkna1JH3;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=+LKdWj7s;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.166, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1768880211; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VxlCqEE8Dn6sp9bQTfgjpHajxKXxMlj2zFwGEStvNfclmVfN3tBEy3CK0ajEHot6Kl
    BIHVLsoUwD4vIGDQRCj2dM079ccy7t8ILJRB7Ui3j0vGDIKd5SHyL9bCtyjRWq0PDGuU
    93qNmvqJpC8bvGPEtWY89jaFvzUdHnw3nWf7JAamS3x+mRNJLDljfOwJ+Utszzkm7+xF
    bgg8EMUgy18gyKiTpPzpD2OaZSQEGXUzV91WdAe4d9lP706erDI30nZ/lwFkpSGzI8cG
    GZUVLz9xs+3QpALWwrXK3t7rJ5cu0+CPMpo/i9oqmSZFW8BwkGzrzHJv4TYvSKHH+nGv
    0xzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1768880211;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9BhxhL4hXJ4YVBzpRBP8oNbje7dVyPMADmmdsEk5VoM=;
    b=GtTdMa+ywB+4829uFub1QbMs0kEnkVRvGCC4m5ThIp6vgzfUicCjVnX5nd88oxZyXL
    /Anu4f56nciD+90wFTDLTCXIaHZIQxRoV+o3fI1ExyBEKmiRs6agMkDhs8cnC3cGyaDw
    ykpeydfybyQpmGgg4H12KEIPpxoePCS+pL+40Z5lswBkqYztg+p2lGy/jND2C+0n52De
    p4+4tP6Z8xsf4ckaNAea2Pjcw+9795e+RlPLcwK1qpvaFZWirSFT6hiB/MxMP2G+EiWW
    LZJuUbCI6z62Gb3zGSSYVX2A1ofwXH1RvhLjE97wR4kmexhIdXtQnxtjAwN7/dVbPiu9
    2nkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1768880211;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9BhxhL4hXJ4YVBzpRBP8oNbje7dVyPMADmmdsEk5VoM=;
    b=Tkna1JH32sdhB1b7aAeSgKOb4Y741Tmfx6QXsHPtiRqht/FfU0+kDpNGeGwWLiI3wY
    WTOJ0gSFNm17yvd/hAC54lkkgAC/IWf86Go5lR41/+Q8KgWuoPIiX0nxpMNuemY7PngH
    KbOD+rhAPMG+5buyQ9ave4n/Gq2yeShh4wNDrlhEOdtpJ9X6FbrDvAzlTTHaWoqmP/bk
    nz/PUfH1VJVudh+cEHeG+CKZvxqECguN9Qd8KYggwmHPY422paPe9PcGtcnm0sI68AsO
    WBm1zjmfrBRnO3mD3m2vtk2QsqmDNbV8ZbXDHaeKgHH81yl7QdjnkNNNWS/PVo/Z86xf
    9FgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1768880211;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=9BhxhL4hXJ4YVBzpRBP8oNbje7dVyPMADmmdsEk5VoM=;
    b=+LKdWj7sqBwKB8IOVK8eOVhoxxTeIbwZMOST3GQuEwYiAaGqqJz819458RRVTXg7ma
    Uo5wKIu+k/PTY2XJNBBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvsqHiA=="
Received: from open-xchange-core-mw-gw-31.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda1720K3apGIy
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 20 Jan 2026 04:36:51 +0100 (CET)
Date: Tue, 20 Jan 2026 04:36:50 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: claudiu beznea <claudiu.beznea@tuxon.dev>, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Cc: cip-dev@lists.cip-project.org
Message-ID: <1078868029.118356.1768880210995@webmail.strato.de>
In-Reply-To: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260115083604.1064260-1-claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 6.12.y-cip v3 00/19] RZ/{G2L, G2LC, G2UL, G3S,
 Five, V2L}: Backport MSTOP support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 50720
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Jan 2026 03:36:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21679


> On 01/15/2026 9:35 AM CET claudiu beznea <claudiu.beznea@tuxon.dev> wrote:
> 
>  
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series backports the MSTOP (Module Stop) support for the Renesas
> RZ/G2L, RZ/G2LC, RZ/G2UL, RZ/G3S, RZ/Five, RZ/V2L SoCs.

For the whole series:
Reviewed-by: Ulrich Hecht <uli@fpond.eu>

CU
Uli

