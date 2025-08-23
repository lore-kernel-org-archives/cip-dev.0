Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D0CA0EE4
	for <webhook@archiver.kernel.org>; Sat, 23 Aug 2025 13:05:50 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
 by mx.groups.io with SMTP id smtpd.web11.6163.1755954344233702404
 for <cip-dev@lists.cip-project.org>;
 Sat, 23 Aug 2025 06:05:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=VEG9o6eo;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=e59CsVUC;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.24, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1755954319; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TUpTaspI9+v4MHxyQUyz2f4q+5B2BQDKwgqEr6TZfCoA6BUbRtShbRmsbTJTzT8f6q
    ambfvYoDI0J72LaV7WSFkSyK3sQWF/qZ91u3E6bLmlxYWCHMKujKGRnTMLUx2oBv3LGf
    L1rSymre8rNss4vkAljDvC0YWDH/EjKQ2c3sPTVglTPl/dqR+Rhol9W8dcMm1NKrFQEh
    Fpg1susq/d5XBZ6ItxuBksK/OV4Mkg2UmalEzOl/O4dPChyzRjBXY5bEb6M5eTuoEWO1
    jQTk15/zZXhKvzMNHib+QMlScWoum1ni3ZUQkZ2PPju+arQogqlhVYGfbdxfd2v2AUnw
    h0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1755954319;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lZrVQMAGWc/WKct5g7NN8q70uJpC66+JxjKnKIiRcsY=;
    b=A9BGIc2pTwHwTZ+/eRX+bo5apTRlkrmghHigRKxYHrbaTUtR3rOUqt9VOiDv50VTX7
    DW6hYI1CPczrHoW/KuwTK+b66g9KpJmGHIzTFRqY4ejdUe9xoXTbENK3LEXZaYZH8rWC
    bvvqFhz8JXHwItwwKA3ivLoqV9xPLhY13tpzJUsceDcAl910ulBnUsUtNOF/fiMXneIo
    Zd+6e4uZnYz2xW000sud4vv0cr/EZz7lC7OztuvISe0hwE6dHBjf4nz9Y8XY0ZoyWOMW
    pugGevf7LOWnRo0KkbUOgws1hz4vaZwfYk+sS5JxpE3DNj8ChNYwqYEPL68kfbE8riPg
    o7Fw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755954319;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lZrVQMAGWc/WKct5g7NN8q70uJpC66+JxjKnKIiRcsY=;
    b=VEG9o6eo+P15QUTsAnj0WifaFsDzFJDBJnwkW1PK10iW1mfFo2o7r/8fxdyuocC4wR
    1XsODd9NWXTgIBYcJ6mpaTTiCi6IttG6aKezCiJDirVIHrvASoY4TIuI47gClAdQC5tW
    Q6eBTA2zdvxt5PUx0nkwRdMRnl/Irn+zM6hO106AMwGQyarJ9vJQTB9iLkBvtVOPUfbg
    UUki8uHBl1sg3TqlTKFAchAzkSehzWbqzljV1VQINY2m9O9YGqbNBWcipvbmBo24GkIu
    Rfv+zcqiZrkOQV4ZN8Wzsp9UyRUQhLTrcEPGh9C/FqObN9rAo+jaijSXFsiA4sNsU96V
    osUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755954319;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=lZrVQMAGWc/WKct5g7NN8q70uJpC66+JxjKnKIiRcsY=;
    b=e59CsVUCDVwWU+2L+KOrTI7Khmuoxtn0EzpVc0iMji1tG5R/q61m6y7slNJZXUgxYn
    UM0g1pOq9not2RJoEUAw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKLG+KwQlg=="
Received: from open-xchange-core-mw-gw-31.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff6217ND5JA0M
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Sat, 23 Aug 2025 15:05:19 +0200 (CEST)
Date: Sat, 23 Aug 2025 15:05:18 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Pavel Machek <pavel@denx.de>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Ulrich Hecht <uli@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>
Message-ID: <2044519855.2076.1755954318987@webmail.strato.de>
In-Reply-To: <OSZPR01MB70191CC24A9467931A33E42CAA32A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250820141305.4841-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <aKb38+2Q49y8kzBl@duo.ucw.cz>
 <OSZPR01MB70191CC24A9467931A33E42CAA32A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Subject: RE: [PATCH 5.10.y-cip] gpio: rcar: Use raw_spinlock to protect
 register access
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 33952
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 23 Aug 2025 13:05:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19954


> On 08/21/2025 7:05 PM CEST Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> Agreed, I've a now submitted this patch to stable [0].
> 
> > Then we'll backport it to 4.19 and 4.4, provided it applies there, but I
> > assume it does? (If not, you should re-send those versions after 5.10-
> > stable accepts the patch).
> > 
> For 4.4 and 4.19 the patch doesn't apply cleanly. I will resend the 4.4 and 4.19
> Versions once the patch [0] hits stable.

Since landing the patch in 5.10 is not a guarantee that it will show up in 5.4 (which is the upstream for 4.4 and 4.19 ATM), I'm inclined to pick these up as posted for 4.4 and 4.19, unless there is a compelling reason not to.

CU
Uli

