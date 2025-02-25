Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515C0C021B6
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 02:26:23 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.165])
 by mx.groups.io with SMTP id smtpd.web11.2569.1740450374124860069
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 18:26:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=rlKmtT2i;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=jTydBpIb;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.165, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1740450343; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IxRsw+Yjqr4bP7eEwMjcNf1rSgEfHGXUCJgM/ztT2N/wczjwhxMtHOac0gaT5vL6dS
    E3DHWy/395VPSAIg6R5yungNfrvjchN52VHkagEiPJiLVtqrPEcN7SL87UtIPm5k5jh/
    ur3004C4OoJHTVGHr5wPgO1CesMSKbvrRRJx1lhol4gByMxh/jkJCcr6drViY/NJg8yB
    MCdnBKt6SVzeTonQLwmo2tIXjVBK/IlNy047C3zxMSSDgzVwJOxvp5O3hW4546aelK0b
    XQWJBq9k4tb72/oHNRqHrcaAw33L8iDg3u6KKe11tBqEhvsAoc8GsWpOTbaita9v+tKh
    T/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450343;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Z/ejiFMZaw4RXzfCcX4M7EajvJv8IOA5QPmYL8qXPvY=;
    b=bOmB9KDY4GNJND9JIp1gNxN0IT1nvJ/2NrGc3ToQFpMddMK1e49Z6/8PR0dOYDoyVH
    HjUcck+q5CwBXT/9V/MoWzWMCu38CQtV8KXY+WM2jgXYfb2nVQR6T1IapsZMyS0ilbBd
    VbdV7ywWglGdT9TXYNmeQ24Os54RDdqJDv/FNk5K5gBjT6jksXPlUnzSZ4K4zcg8Vgj2
    5N6dw+jcBrKTB7F6NsgU5c3QSAbxzN7Jswyp76lx4p9+ZqerWqFYtGgsEj7dKtCvFyxG
    vQo78l2uOgG94kyRTcrLwgc4QfUbit/rvS+faTmOvYjPhgJLq/hvcWGnsg9q283LCrUq
    66ew==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1740450343;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Z/ejiFMZaw4RXzfCcX4M7EajvJv8IOA5QPmYL8qXPvY=;
    b=rlKmtT2i3bOzyidbROi4BEApJUfqxi3ETQn4KSmKUt4nvbKnjSUxRYqfbwKXHtePaK
    9t4ertbifF2o2xE7XAhadjfas6z+VksrSnRKawT6kkkF0fFVT1Z1Pdduc6yPEu+kHQt9
    1oYfAfJlhY1IGliCPS+tm3Ne9fzr/7sBRaRGoHCeTVXnXtkMHgNglbvFSp2J90Nu0G6y
    zQckUYNbWeTAznWBuxA3nbze2FgDTtUV/1POnMCTYS1O49bYgD7bjPYw7Dz+pncvmhq1
    jZ/LJBsHQaICPLXqRg/arkxQnvOZQE2Jn5dPFvvbNH0xSWqh4SCnCtmkitvwbPSxlMpj
    +org==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1740450343;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Z/ejiFMZaw4RXzfCcX4M7EajvJv8IOA5QPmYL8qXPvY=;
    b=jTydBpIbSD5Wr1Giy07VpHmKZPxBQhvs+vTlW6dnFi455hxI85P4rHPp3h2dF7BpD6
    /xVW36gISz19+woHJFAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411P2PhB4W
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 25 Feb 2025 03:25:43 +0100 (CET)
Date: Tue, 25 Feb 2025 03:25:43 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, "Pavel Machek via lists.cip-project.org"
 <pavel=denx.de@lists.cip-project.org>
Cc: Finn Thain <fthain@linux-m68k.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	linux-m68k@lists.linux-m68k.org
Message-ID: <532628536.2807829.1740450343294@webmail.strato.de>
In-Reply-To: <Z7mb7+BXBDSD4a5G@duo.ucw.cz>
References: <72a512bd5463ee04f4840f49cee2f3c3@linux-m68k.org>
 <960544762.1079819.1739441787128@webmail.strato.de>
 <Z7mb7+BXBDSD4a5G@duo.ucw.cz>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] signal/m68k: Use
 force_sigsegv(SIGSEGV) in fpsp040_die
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev73
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 02:26:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17902


> On 02/22/2025 10:42 AM CET Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> > Sorry, I saw these five minutes too late. Applied for the next release.
> 
> I guess these should go to 4.4-st, but I don't see them there. Did you
> forget to push?

I don't push the tree unless there is a release or an rc. I don't think we get enough external input ATM to warrant queue branches or something like that.

CU
Uli

