Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FB9FA3726
	for <webhook@archiver.kernel.org>; Fri,  2 Jan 2026 02:09:39 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11123.1767319773241995568
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jan 2026 18:09:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=f/d5IZsF;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=MQPt9Q9x;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1767319770; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aUoWt/jmQIcO9oUiHTvZpwme8kjO0NFUVChRj/8dwCIJwoghtAV6xRLlxr0n7oKTiF
    oslljd3dfueIBJIAGZ0QzqJbRSO+y2ejMBAUS1Rn8LYsm1D3tZDM5o9zdCZ77niQU70+
    c/Gy9aX5e+53SGkENsblgghakmwiYz0DLHtFWA+EXscmO8IBlpfL8gEutZ2YeHPtCtHG
    YdtKGgLh9Ru6PEmLT/6PWpBWmXg8LsSPmeMfDYBrEJr9Uhoa19HHi2aId5+2ful+rBMo
    yjVYkmFsJa+b5rxPaqqTfD4UQ5eJyF6bb5B63hOqfEy5qDgQ+4n/MczKMSB9GX5kZ7yC
    EgBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767319770;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Ii/NNVcw1qmGfo1K4hDSHsfrcWapQlLlElzaIeWnfyE=;
    b=KuApFAFG+i8lj4AohXG3T5mcbMNousWqLI0LPlUDbL8IUhWjtYZPrmKjJQTVTxGWCW
    OTMB5kBPal0Xqq9BV4HhmTLTUhwvS8mFrukRvhuJZHO+TSIIH3A+qvTxMx5YpRkWWOHM
    VOTlEiMUC6Goc3TgdgXUiVQTDqYMKVjwROLgmby7I1wFZE7S4c+ZtT0vmB2vhPd9d1dF
    v8KXeAmUew/xYGa6ZLku+0dZYy0+rv6kuwezugGUAM8ix9OQGIxligRTkLs119ogmwH+
    Zlz0MXueTk/ZnijdQ23fUnmmj5CMdg4LCFRiA2oDhXG03P/ScCF2xE0WdbddYxAsnoWg
    eaZA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767319770;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Ii/NNVcw1qmGfo1K4hDSHsfrcWapQlLlElzaIeWnfyE=;
    b=f/d5IZsFN/GXcgvqe5AoTkKnIgaSHJU3FRjz6utI7zhrE9jQd6hGZNovQ9zroi+9F+
    2k2GzJXsZy4/uEeIHi2EfBs77+Gk9cwb08NyjLDmliOtgSmJpq1hwEORzQTlwhLcQNRi
    kfWrMWJiEYGxenTALlyH+JVbWaGJ6Vb4nzUQ6suz3rEGd89RIB8K+nOsvQqhP3uWbQYe
    s4QeaYPZWdZH99qUqPgxQvbckabz9sWNsBrVKQnkvgI8p4axz8UEypjCv+4nOslRG9RT
    N8d0JuLRmgFHhgefeY+j/VfnOOv4JQ1CJfD2DfM+ZxBjLRcSaC1AONAWAFzOMsK4/4g4
    hmoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767319770;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=Ii/NNVcw1qmGfo1K4hDSHsfrcWapQlLlElzaIeWnfyE=;
    b=MQPt9Q9x74G+ncJyWVs6BMWezIeMM54fKnhDWVhsLQoolVOdaSsVz9UcL8pnHvKIVX
    6jaOxasoDCIeiJ1tn9Ag==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-11.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda1720229UAJS
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 2 Jan 2026 03:09:30 +0100 (CET)
Date: Fri, 2 Jan 2026 03:09:30 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Yann Sionneau <yann.sionneau@vates.tech>,
	cip-dev@lists.cip-project.org
Message-ID: <14848675.147487.1767319770628@webmail.strato.de>
In-Reply-To: <79338dfa-5f6f-4776-a006-20cac0036ab7@samsung.com>
References: <1151fc2f-6b21-419c-a655-7f68a6e54444@vates.tech>
 <1534957620.311452.1766834410980@webmail.strato.de>
 <CGME20251228212320eucas1p162cbc8f4aa9387db360048b481b292d5@eucas1p1.samsung.com>
 <0d89d301-20dd-42e6-a588-c7d2c616df2c@vates.tech>
 <79338dfa-5f6f-4776-a006-20cac0036ab7@samsung.com>
Subject: Re: [cip-dev] 4.19-y-cip missing backport?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 49522
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Jan 2026 02:09:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21298


> On 12/31/2025 8:23 AM CET Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >> 3. Do nothing. Least likely to introduce regressions but leaves the code in a known-bad state, although one that may not cause any real-life issue.
> 
> I think You can go with 3rd option. In 4.19 kernel this phy->calibrate 
> call affects only one legacy Exynos based board, which I don't think is 
> or will be ever used with this kernel branch. You can always apply a 
> revert (2nd option) if one complains.

I'll leave it as is then. Thanks for your help!

CU
Uli

