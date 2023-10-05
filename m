Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E50E8FDC8
	for <webhook@archiver.kernel.org>; Thu,  5 Oct 2023 10:35:37 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.20])
 by mx.groups.io with SMTP id smtpd.web10.12037.1696502132083832693
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Oct 2023 03:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=faId1lT2;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=8aWUeLUc;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.20, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1696502122; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ypa5sV6n+YtZYfHgj40OINPfGvSZ8O8ezVe+XE33G6nG5s7HjD1jRRYqFTbPFVDWKu
    gf9BhmfnCImv4Jvwedxew+E36xyEQTN9eIYDzV5VY63y/F04cwh3ZAQZNNw2dB6Aqp/p
    ojmiPLitW4mwqlCs1zNrGpDIrNO/xDai2HTUMQLGWZZu9NIhwIkx3SWwsBKDgdjQRiTH
    0gmGePtlw9TCX2hIRGu2b4MBCWHoeY1C23K1Pchc3WmjGx+OX3701Y2kRFWwtQ/fd0ym
    fN4qGTqeVHBmpKoe5qBPbiLU6xJrLA0ECtzwZg05rW7FaiQQGIEvoxQVlBX+Lnea+4aN
    KEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696502122;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=XWfCK4GURleqDjaOW1t1UlS/IInrlijkrRJc1Lg2ds0=;
    b=LKlasZi2zVpe1c7Z2+3yFv2DKDnSmzJoGfuDeAmEOaSnqiLgUp1Bw4LVHsaMkR9aGs
    5Mwf0tVVz27wu+tgUCfI503BBoWVoMWqjet3fBbHald/p95X6gn0waBbfH2nEcyuEfCf
    g76y1K7bMGp2vTb6PwJl9Qfsbg499AHwM5QjWSOUp1XC8ylfnOmh8AywQFqO0qMOy5PQ
    1Wk2cSgrzQs5qiNgk/Ejm6G+xeUfLSxY8OBC98eZ11xEhgH23igQ16KkpQg1XMQ2kO7U
    /sOUvmbCfKJyXIb1NiyK2CKloF5v9ZIXc+tbVTDz3A0NANnwoKuYgr04q5rOi/m0nAqp
    gN0Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696502122;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=XWfCK4GURleqDjaOW1t1UlS/IInrlijkrRJc1Lg2ds0=;
    b=faId1lT2RvPJbCkUYspcqHHl5QJpGqPjRdcswmVheWwkqcKb0vo/yEo1N9qISokTyT
    /KxxsUrtu6ijZ8eZczjsqvkt/RIrNumkfymEu7g9L+teZQqRvVAxfzaVT4bPmuQh9FUc
    QOzK2IqXJCwylpOGFDsHzAvx0qYysJ29Vyt0lgIMEQhCUU5JPhugfMgPqN3v9RLdLVJJ
    pHRFiWFY384QEYG2RkEYlUG+znkZMMjmPzDZJ7IBGl7Z0/62hR4Y10ZkeX3OZ8fMW+XS
    7k2rzptpXvh6AmOgfQUCadVsoVafkforLSOZrIFVK/DYrdEbOao8h4Dvj7HgJRx/FawT
    Ou7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696502122;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=XWfCK4GURleqDjaOW1t1UlS/IInrlijkrRJc1Lg2ds0=;
    b=8aWUeLUc6UnE5nEwfYY+cHVlxiZgSXgztz6XzfbRTTITrjEpyT2t3vAxAh/qna0Jhl
    PQal5tMAXvR1MDEsUcBw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x28jVM="
Received: from ox-live-app303.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.8.2 AUTH)
    with ESMTPSA id L04889z95AZMgLU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 5 Oct 2023 12:35:22 +0200 (CEST)
Date: Thu, 5 Oct 2023 12:35:22 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, pavel@denx.de
Message-ID: <1965412591.959365.1696502122196@webmail.strato.com>
In-Reply-To: <TYVPR01MB11245FA52A10B2B824B8E8B9692CAA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <809419142.671756.1696317771828@webmail.strato.com>
 <TYVPR01MB11245FA52A10B2B824B8E8B9692CAA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] Request for reviews for 4.4-st45, 4.4-cip80
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev52
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Oct 2023 10:35:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13293


> On 10/05/2023 8:57 AM CEST Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
> Hi Uli,
> 
> Thanks for your work.
> I reviewed the commits on the -st branch.

Thank you!

>   udf: merge bh free:
>     you forget upstream commit tag.
>     commit 02d4ca49fa222021988b2791c8efefd70d3228ac upstream.

OK, I'll fix it up.

CU
Uli

