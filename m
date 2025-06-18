Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3CFC7115A
	for <webhook@archiver.kernel.org>; Wed, 18 Jun 2025 15:43:54 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
 by mx.groups.io with SMTP id smtpd.web11.2163.1750261424274005441
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Jun 2025 08:43:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=FoPTh8rQ;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Gc+hJTK7;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.51, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1750261421; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ppq3nsj9PoXXlI833nWeoRbkyzpPZwLiMmjazFhUPxFgdOeKRnX+NSQI9wcN8m1LRo
    kLxETgotaeCwbT2RvPDKxd0yEwK4vXRuU8w5mnUhPP0LtajOkJzSM6KKHc1ZGtD+M4ND
    PPlw6NZb03nCRbOdbioWi08ZeeTvXPuJGUgA1YKo5YjFWaOGav9PlVHcFq84oA7tGqel
    CGYtGsAhW5LYWmYViH87a0IljMeUex3E6DcAZ+atS++GDaTjdlsRV/dcsgpO6LVej/lh
    O63HRF+VGcLNBk9/SKzdAJ2vzNLUiFz6dOJnFAceQs2dR3qUitkET19BPgAkO/QZvyaE
    WL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1750261421;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=m6hpG0+K28I1xVgbGyWsUwCPbwXir8OUTYajyLeWM7c=;
    b=KaVCt3WQVEq05XU30TO/gUMqKMmVO4amnATjA5oQVhavnH5PmXCdorW/r8ClsNIhH0
    xgUb8reAQD7azjkYHaI9nJeAmioccSmk7AY3XkUKsqSWTIvdfxNto6xpE1mJ9ehCu68V
    N/G2GLMBvQT/UXy1PcbdzntuereJ6k7VRSPEO8I+WiMTSeuHEeSGVMEUdZHa3j9NEMir
    x3ByCrfdTmr4qzutsabUNi0osZ4jO1NJuBIJwZZuys6v1WuLysrg1o3hYLIO0Nk5EgYF
    b5L59ZBmvvp8PxZuJGY2pft2Z2U3GnDyRLRmQZ8IZABKC+6/OC5ZSqJFUC98gQ6gI1tt
    laoQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1750261421;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=m6hpG0+K28I1xVgbGyWsUwCPbwXir8OUTYajyLeWM7c=;
    b=FoPTh8rQmH4HN9lDqJY/6MPLOII5MDDGKerAI9picxxbqZ3It4Ge7jeVIpcgwXplXe
    bFXpu/qfHoeB7ScJgmldgK51x2YHQlJU+U+xezlUbJ70qVzu6hfxFRb++mNosrWEIuk6
    v+w3txxHdcwJ84a69OLZbwV9o/9KwPHy4EbN3CELJkgYyWGz1ysqtQ6nFlRXnen5vbOO
    fZJo72hayB+MD78QebHKu7qvwjjjRu+u6NrS+LroXcg1BMDGxG8ea9Y7pI9p9VecjGO6
    FYngSIVAP2X9PsWioHegtgZ/Px7dVKv6Sf6Dh2ZbDbLwPWb71XzoqUZcHra4gGT+xgWO
    0FTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1750261421;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=m6hpG0+K28I1xVgbGyWsUwCPbwXir8OUTYajyLeWM7c=;
    b=Gc+hJTK7kaN1evx7z0OozTz0YKrwVbYZaBxiTTl3flp5uLrExlXBwO/caT7v2/9sSI
    FisAd533LcD8vNpcZ5Cg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-27.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34015IFheUud
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Jun 2025 17:43:40 +0200 (CEST)
Date: Wed, 18 Jun 2025 17:43:40 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: christoph.steiger@siemens.com, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
Message-ID: <70209609.332983.1750261420929@webmail.strato.de>
In-Reply-To: <20250520122309.180558-1-christoph.steiger@siemens.com>
References: <20250520122309.180558-1-christoph.steiger@siemens.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 0/1] mmc: sdhci: Do not lock
 spinlock around mmc_gpio_get_ro()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 50528
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Jun 2025 15:43:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19134


> On 05/20/2025 2:23 PM CEST Christoph Steiger via lists.cip-project.org <christoph.steiger=siemens.com@lists.cip-project.org> wrote:
> This backport fixes a sleep-in-atomic-context bug we encountered on a
> 4.19.124-cip27 kernel:
> 

[...]

> The patch fixes 6d5cd068ee59 ("mmc: sdhci: use WP GPIO in sdhci_check_ro()")
> which was later introduced in 5.0, which is likely why this fix has been
> missed so far in 4.19. As it turns out it also fixes a very similar problem in
> some drivers like the sdhci-esdhc-imx, which is already relevant for 4.4 and
> 4.19.
> 
> I tested this for 4.19 on hardware, I can not verify it easily for 4.4.

Applied for the next 4.19. I'm holding off on this for 4.4 until somebody has the opportunity to test it there.

Please CC me for patches for 4.4 and 4.19 in the future, thanks.

CU
Uli

