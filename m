Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F41BCCD199
	for <webhook@archiver.kernel.org>; Thu, 16 Oct 2025 13:54:13 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
 by mx.groups.io with SMTP id smtpd.web10.9185.1760622846615368513
 for <cip-dev@lists.cip-project.org>;
 Thu, 16 Oct 2025 06:54:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Defb4aaX;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.24, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1760622836; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fgW8PcuwSE2UXKd8ubMiRtSLBpemCq/orFT7m4uZRAC0j2/ohoy3gGjfsYlOGfO6m/
    LDYin+HJoqLZNUaTgP5aA1FhwkyNPXICY9lEJo7Cz81dl647w1wIs57rGMgqUVXNh12u
    vfXpqOwD384wt+KRZdt/f3RRtenNJ8kO85rA8qDs/OUr/pSG82mPCSEiV3xB/ftFMXgc
    JXOhDXteGfDD3z0EhyynuxvgG4HZu5JFQGqGjhOOmmov3lH4ER8X/EzHSyXd2m5C+9IT
    BC7X85LaPpz4qA4tFSifPmvZ8EC89eT3TUDdlVeAQkE+yFQBmO7KwrrUk8mjjUC7SLy9
    FPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1760622836;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=FuRz5QmQDoMyo5qiXQF9tz296z/rJUTPrFdyeOPPLdo=;
    b=P0ifxrFz8nYO1/rPcqulorULNJYBOLza3C1RJmerVSw2+kHlGaxUXyczPg4FFH207W
    rsTWWwRYkybdQAIDc4hNl9GacVDOJHSX+aV1F0vY9xMjw+Admd1mseRsvZsSVy1+fk1z
    w0anHSOpvStlQmLzrZy8JXjDtbkGQQca15gGULIerBoxDsYkzXfGFQP0gQGYWtAwW3bN
    vo2znERS10ep0aCcYlfuwhivFv7IP1ZVAOlJd474UvfsxL/+to2LwGVzsfFqmZNK+1Pf
    98FwykRZv9QGna16CyTDCq6LQgBxoowxonhcYASa3eJiVJkhRhGITtGS4KUYfWVCye2W
    Ie0Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1760622836;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=FuRz5QmQDoMyo5qiXQF9tz296z/rJUTPrFdyeOPPLdo=;
    b=Defb4aaXWmuMynrCl2DyhSNYcqSHS0DE2Wv/lkEwCV5QvBg/D7RXii7cruoa7/qSRB
    EGX9TXE0STOeluA0EL1Y6VWOsbCYpsPdWGYF6MYIieGjr+2eRep4VdWIT050k54CzQET
    ptCHzVVlEw37zChcas2c/fQoUcc+w3Nf+jpwOWoqb0OcZu9n6nivD+cIbzQGgpwUdqLW
    K5IN8657/Y49n6dv8U99o+tdOVK2SGXhTJMF/W5TF+F55jeMAgIydEXPiX8pvDZyab+h
    Y4reTNmL7AHzvH5DTJKLCV9xKTdrteLkPBml2tlpH6oEboGOQZwZyJ/bBU4g+YxvpGXt
    19Tg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hewKDd5BNnyw=="
Received: from open-xchange-core-mw-gw-1.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 53.4.2 AUTH)
    with ESMTPSA id z2815319GDrtVVJ
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 16 Oct 2025 15:53:55 +0200 (CEST)
Date: Thu, 16 Oct 2025 15:53:55 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1987113732.203443.1760622835166@webmail.strato.de>
Subject: Request for review for 4.19-st9, 4.19-cip125
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.93
X-Originating-Port: 38722
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Oct 2025 13:54:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20188

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

c7b36525554e4 mm/khugepaged: fix ->anon_vma race
b91c123855d13 i40e: fix IRQ freeing in i40e_vsi_request_irq_msix error path

Thanks for having a look!

CU
Uli

