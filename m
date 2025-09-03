Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BE3CA0FF2
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 14:47:23 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
 by mx.groups.io with SMTP id smtpd.web10.14527.1756910835835842668
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 07:47:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=jL49J5f/;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=aCOn4Rc4;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.166, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1756910806; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=qUJk8DxxTNgw5JRrWMGh2e5iBrgJywabwayODE5V4Zy0r5cRLxDKPChkKPrGgdz7dz
    8SDeZOWqqYoytHwXWLXngIl65aljm0ZE9/eYZuoWPmSGWRdzsujHAPPQcyFDiRaF1ipN
    sRT9nKuraTFEz9TrxXy57Ewplqwdq32d2Iqe+Mi7pYiArcXIU2EHLZBSOnvuK5ZpLKHG
    /WWEvSs1WctvTHhU4Z/Bf2ZdHt+tITSpwRRQwfpEeEKPWkMyCDpR00HvErLwjq/f67xM
    nmim7kDC/o62re3f9mH+IxLTmuFZZyCmdDBg+aUO4oTWy+igMjQ258FPYLMCf7MsCvSf
    cYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1756910806;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=7fSz3J5Xzxh8o9AEswLdOcJic3qbIUjnv8JSVzUlLtI=;
    b=kHsYxgxMxt2xrcu6ovdA4GckZRoKV44hMBnGbSG9Z+NFKWsG3GZql8x7rmvloMUkyS
    tf/LlHN1qvADIu8wSn/bqpkZuakaderPMncqS7nvlcZltuOJB6YzP4Y14sbsmaCYlSeT
    z6MvUzdGI6tn6HEiKqUCcmtaOBDK4Kw32J/sdTGTpBLJFK6nTMyXDQh5cI60OIIXBpxl
    AJEOLPxTrX3gsmvxg2DzrANK/wnvoWVVT1bUukhy6u+n786482XYQPG4NWuSJqNmzGwS
    MZUu63krj+W44v79nAl5pKR7IH8X+kqqemY+IEvipE8cTJHNUY5E4+fkEbfWReW8Q4nn
    mMwg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1756910806;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=7fSz3J5Xzxh8o9AEswLdOcJic3qbIUjnv8JSVzUlLtI=;
    b=jL49J5f/J8db5cSttZCjyMxm3vErmufmmwIh6CznPgYhghbTuYfeaNQEhMDX//FRXD
    /V0RF0BWQnOw9rCTE341NgQ66hCxL26w6/4YUl+oEi0RHRMMo2nLOMSN/UAxovQ8O3wf
    Oibhc31jsVoFG15+NlAIIbCDbB5t/VA/OTYVYkzjYz/2BOeopqQ2m79rD1UVMTftt3wh
    kjRlw65eGlbE72typ2kntb3UQ4tMjwV/mhPrhst6eH21UxxB2MFuLTHOSOVJsPTvUzBL
    TIYAFdu1Ytu4pgObmINb60a9stzdlCsfthboWdVNj/qabhK8oUIibm3qsdZfC+eDPQOb
    jEjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1756910806;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=7fSz3J5Xzxh8o9AEswLdOcJic3qbIUjnv8JSVzUlLtI=;
    b=aCOn4Rc46Zjh3hO4zODwls+8gM6T8yzIxeWVet+mPjjuRujmJfbqHbumcFHgNu7mVG
    D/vUAXQIQDcX0t/mQfBQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hexKzK+A+UOEY="
Received: from open-xchange-core-mw-gw-18.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 52.1.2 AUTH)
    with ESMTPSA id z5ff62183Ekjp35
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 3 Sep 2025 16:46:45 +0200 (CEST)
Date: Wed, 3 Sep 2025 16:46:45 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: jan.kiszka@siemens.com,
	Kazunori Kobayashi <kazunori.kobayashi@miraclelinux.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>,
	"chris.paterson2@renesas.com" <chris.paterson2@renesas.com>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1208303079.251954.1756910805287@webmail.strato.de>
In-Reply-To: <7a864d4e-3051-493c-a64a-cfda61c92936@siemens.com>
References: <1602384696.84101.1755530487321@webmail.strato.de>
 <42de8250-d98b-40e5-9e8a-d6bbb1ca8b6b@miraclelinux.com>
 <7a864d4e-3051-493c-a64a-cfda61c92936@siemens.com>
Subject: Re: [cip-dev] [ANNOUNCE] Release v4.19.325-cip123
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.38.83
X-Originating-Port: 50472
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 14:47:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19998


> On 09/03/2025 12:36 PM CEST Jan Kiszka via lists.cip-project.org <jan.kiszka=siemens.com@lists.cip-project.org> wrote:
> General question: Is that build breakage above not triggerable via the
> cip-kernel-configs?

CONFIG_VIDEO_OMAP3 is not enabled in any CIP configs.

> If so, you likely want to make sure that it is. If
> it was triggerable already, then we should try to understand why it was
> missed.

We could enable all the defconfigs; I think that discussion has already happened some time ago, though I don't remember the outcome. :)

I keep a bunch of local configs that cover all sorts of unsupported stuff (m68k etc.) that I build before pushing a kernel to make sure nothing breaks needlessly. I have added omap2plus_defconfig to that.

CU
Uli

