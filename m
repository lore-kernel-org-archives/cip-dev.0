Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8560C3ABC0
	for <webhook@archiver.kernel.org>; Wed,  7 May 2025 08:45:21 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
 by mx.groups.io with SMTP id smtpd.web10.3898.1746607519859451389
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 May 2025 01:45:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=l5hqi0Uk;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=r9JDO+5p;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.219, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1746607506; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=LgCkWNXb3hJ9MpMdcwSjCLOP/WMOUOdjWOOb9L+ilXOxN/lRTuGHWSh+ktExx+4xz5
    eW1EjiqLhc0mnK2wkcykmpdgCMCAzb6UomSW8AYiBooE3HX/sF0XoDg23RmajQ6wA5Ah
    i7gM22FmdSEmp32KYwa4Egqt9ZIDqydoHfKFUMXoFJVyo/NilohVQsQBy9CA42JtwKjF
    MmZT3wSKnoZJRkQWMrhUwVUbrzkH7ikv/zLRZAVqR4TGM2Wc55YAPsNLHm5GpTx8YyWa
    0a8XCoHI3J/oU2+QzBO/GbhbowqoqCobCoHPxs2KAlUNXgPpYN+rWLrS+rzW03GAne3W
    8uzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1746607506;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wzU6el7xq3chXvoiOpY+eW0mJn69AdElax4fVYtAuhE=;
    b=hUK5waU10tjSgY0ZknVp8DFazd2nRa3FcO9GQ++urWnlQ/I+ATIJr+UKaNX6rhO3SI
    xrpDKI1jw5lA72SpBGT2G4Tg9GQhZ3nXHd6ShhmIrijKVNCVSAbZ3tkJPbXyG/Gke3/f
    Y9ZndFG8n4gZQld93ZyxrI+8/cJm7c05yHMD0RGV5g4pV2QsNg7bvvY2U22hyqc8WEPF
    LatUk9wjAOytFTJUZcJxW8407Dl6iaG4Hpyge2R/ZW/6+ihfXCGRQEkyQ1d9iZh/7WEl
    tR/966OmPPGtxjdyqUFECwfuBpQiFiWD/uWOFY64oAp2kD2erV16a13k7VQ8Z/vp6BUA
    fNNQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1746607506;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wzU6el7xq3chXvoiOpY+eW0mJn69AdElax4fVYtAuhE=;
    b=l5hqi0Uk9k9SICyCJCQyiRAtj1Fb+0CVel8ylGNluMHj6NwGNxsOTdHb/mRdCGoVJu
    Uvz1nYH3E5pYOAvHoGjMfmkEnKRQd4yfQ17jGQJq1N/ka6UPj6y4RDb7tLurwht5XZgs
    H1omS72oRGpH5AuD6iRDBGi9ADzt38UfX08Ndo9rGiKic8GGsMYRm2VuipqvZX67yNJt
    bo4KRbQObdd5IME8tsPXgp/TONSu8e/Is/D7WAyrLlR/8zJL34PaJkUh2bBEX2k45Zv7
    v8zloH6Vjp1yavLEt94GOL6MrlPXWWY4j/am3mdTLGEDXlnI63a5G9Vtsc2IZpBxx1iC
    mefw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1746607506;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=wzU6el7xq3chXvoiOpY+eW0mJn69AdElax4fVYtAuhE=;
    b=r9JDO+5pM7VHosIi5HnNtUvfOCjxu9ujVcVehdh3PCrr9aeBdxbsAN4EHKmHD0BKeS
    cG5X4akgntXJKFV8ExBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-24.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a3401478j6vvu
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 7 May 2025 10:45:06 +0200 (CEST)
Date: Wed, 7 May 2025 10:45:06 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: nobuhiro1.iwamatsu@toshiba.co.jp,
	"Nobuhiro Iwamatsu via lists.cip-project.org"
 <nobuhiro1.iwamatsu=toshiba.co.jp@lists.cip-project.org>,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: biju.das.jz@bp.renesas.com, cip-dev@lists.cip-project.org, pavel@denx.de
Message-ID: <1012487320.262646.1746607506076@webmail.strato.de>
In-Reply-To: <TY7PR01MB1481851C84944731CC67B05D19288A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <1833151A32081021.4816@lists.cip-project.org>
 <TYYPR01MB7024C8C39B7B1226B7924447AABD2@TYYPR01MB7024.jpnprd01.prod.outlook.com>
 <TY7PR01MB14818A6DBF8C7D899210ED72592BC2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019C7990FA3543B1F69A6CFAA862@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <TY7PR01MB1481851C84944731CC67B05D19288A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] [PATCH 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 38590
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 07 May 2025 08:45:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18775


> On 05/07/2025 2:55 AM CEST Nobuhiro Iwamatsu via lists.cip-project.org <nobuhiro1.iwamatsu=toshiba.co.jp@lists.cip-project.org> wrote:
> > > > Gentle ping for review.
> > > LGTM.
> > >
> > > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > >
> > Thank you for the review. This patch is missing in 4.4-cip.
> 
> Perhaps Uli does not notice because he is not in TO and CC.

Yes, please include me when sending patches for 4.4 and 4.19 kernels.

> Uli, could you pick this patch to next 4.4.y-cip release?

Can do. Am I correct to assume that this is specifically for -cip and does not apply to -st?

CU
Uli

