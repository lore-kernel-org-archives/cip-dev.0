Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5466EC282EC
	for <webhook@archiver.kernel.org>; Tue, 18 Mar 2025 07:59:23 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
 by mx.groups.io with SMTP id smtpd.web10.6464.1742284754733592853
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Mar 2025 00:59:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Kcjnkorh;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=YyHYRjgJ;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.217, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1742284743; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=dE/51rY0sFEPY7+RG5LuAhtNRiCfV/fS+cgmdniJ1UzdOZX1QRXOKPrMP3sL/ctHUS
    Q3RZth5nxBEUNUvSjmKwa93VwgLiMlXgIplyVhP1kEQq6etRnEvoO/2z3pS/ymAU4Tpd
    9+Dv+korKJjukiBTkkSpjv+6TY+IdGi+ngDNOmN3rrNFypNRl7RZRqzPOruOVUltvMJD
    BFSOW5czzrtYoAIIQTNaWonOJJkIUbqfau0H9zCk9ilBegSaWkaFJVYGkTTATKLxy75f
    d8k38xELbUWELkxcuXH/RJKqxrUU+tq500KrmiOIWJVtBCzvCgfGx0zkVZgem/i73p6K
    QRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742284743;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Minb+IJCfntlZZCVG0M4ysdqrSEGF+q1CaLb63ZNnVA=;
    b=r+l4JjMfD/tc8T8mKw7aaQ+0iVGdmu2M0Uf3ikMDNuaRJRnh49Xh+n66Z4BPAO9ol1
    b1z1dHw0fyCmCAMYafAXEkVqmQSTpKrhcgaRallryzSKrMfgAcoz6NUIyuJYt8DOSU7x
    FhmB3oUbqGzlVJrzDxFQo32NihxzjmnjzkLPtb0ERzwIPRDtUf/e+oEzVUmcTNT/GDYD
    VI7snNaTriBt46EnYNO5sn14O+Lpx3/MRHWnnsHLAsZwcuWET1FqIMZGHOy9oTKlMfQG
    aF8tV+7YsTze+dmPID2NRG1QLEtM+BRuBWLbhKb4HbTBzXI/z5Dn7lFBNdV0IHwzojqb
    +ZVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742284743;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Minb+IJCfntlZZCVG0M4ysdqrSEGF+q1CaLb63ZNnVA=;
    b=Kcjnkorh6+J8WDETpNQ9if7tavJrTAmqr11i9pUB+7ngkMFyUA2OWexhoOk+6KEuki
    vXYr3rDRa7AQwx2GV9Do5X1IorjRRn/h9oMb0f85zTRwaCTSTFaYWmNHlZ2tbsRfIaNF
    Vjet1WoZfBfDsDWQtTdEsZ/OaIKZxubmI+NAvX/EkdLQ9G+/24CdvifB3Q/K6oE1Cavy
    xyAGIh14b3HG6yx+RXEW2YuzWbI6D2ec65Ucqf1Jv7VpG0hjM2VxF7imF/FnbawZJUFS
    CG/r4IWPgsvseCOv/90V1+SRd/CX1qsjP2dF3tuXPBg2C21ItFFGOYYkR/2hBqFh+TXN
    YkLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742284743;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Minb+IJCfntlZZCVG0M4ysdqrSEGF+q1CaLb63ZNnVA=;
    b=YyHYRjgJ7wQHYhpqcqWbXcFfygAS1fRRWmBCWP+iWpCFroOGdm02bD7Zut7/HBJ9hb
    kr1AYwxDGfwXJXWPOsBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZsghGuyX3LvXid7Q=="
Received: from ox-live-app404.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34012I7x3v3B
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 18 Mar 2025 08:59:03 +0100 (CET)
Date: Tue, 18 Mar 2025 08:59:03 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, kazuhiro3.hayashi@toshiba.co.jp,
	"pavel@denx.de" <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1534737626.3397349.1742284743039@webmail.strato.de>
In-Reply-To: <Z9iSZXvdZiMmPX3e@duo.ucw.cz>
References: <1265902513.5463957.1741955689526@webmail.strato.de>
 <Z9iSZXvdZiMmPX3e@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st62, 4.4-cip97
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
 <cip-dev@lists.cip-project.org>; Tue, 18 Mar 2025 07:59:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18236


> On 03/17/2025 10:21 PM CET Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> > ed0c3fd887468 scsi: iscsi: Fix redundant response for
> > ISCSI_UEVENT_GET_HOST_STATS request
> 
> I'm not sure this causes real problems, but at least it is simple.
> 
> > 30e94a5d266d9 irqchip/gic-v3: Handle CPU_PM_ENTER_FAILED correctly
> 
> This looks ok to me.

Thanks for the reviews.

> Could we get
> 
> [PATCH 4.4 4.9 v1 1/2] init: Introduce system_scheduling flag for allocate_slab()
> [PATCH 4.4 4.9 v1 2/2] mm: slub: allocate_slab() enables IRQ right after scheduler starts
> 
> Merged into 4.4-st, too? They are simple enough and fix real problem
> for Toshiba.

I was assuming these are supposed to go into -rt only because they fail to apply to either -st or -cip.

CU
Uli

