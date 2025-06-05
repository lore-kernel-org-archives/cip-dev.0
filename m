Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DBCC5AE59
	for <webhook@archiver.kernel.org>; Thu,  5 Jun 2025 11:19:09 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web11.5016.1749122347568018416
 for <cip-dev@lists.cip-project.org>;
 Thu, 05 Jun 2025 04:19:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=XWwGPYMg;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=A13bq/3d;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1749122340; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eQX+NhEfvC1nDWHuVkPo+968R4D6JdGMwVJYC80xwBLSoTaXEPt65hERyWqk9EHEJ1
    fmiykw+OPduTykvhClgxZrmPbo+rXp1QEAuNT1l4Kyri/j6Z4k8VbmS9G9fH3mwosD3I
    Tzts+pMvxRHVPS5vDD62fmR4eUBYNoo4GPuIN52J/u8etZ7YO+PEZuA/hKa9EaWiDgvP
    tdvnk7TjGGhXqU7L4+PbIN2xtLjaYHpfXhCQyRcWGJFAZYjafl+LC4VgM+UYxJkvxmZ0
    Y+YWHnC0ZORzTxa22NJgLApmTNrOgRKeecIIwOYq4FsCSw/kq7iT9O1F5MlPatlqnhhu
    ou7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1749122340;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nO6KRGE7iXKdXLCHxoKLLpP27bvkkr5wFMCXgggqY5o=;
    b=A9nvvmEdzrHUy+bY0vnVrZjoZkO/jkCSWmXmdVBbVxX8Rj8XXr8OfANIGdzPWDnXXu
    aOumDPUp2r4hSPq3WW7eFFqXBR8hz/akgVWibSb7zlBX6VLTOUtl3+XxStBEOckzB0v+
    TROyvIE18sDj/o692aALk6pAvIFPgFqthYQG7Yic3O7x/dwb5uq8nYNAhLYsdsV63w+j
    ow+bzNUBOZOsM1qyZbHCx/TPbHpXisZ4RCO9euv4XYApjvfMyDUMp6Vng3xfX5pLM5Ox
    /mdYj22lqZsYcRY+TmtE96eZoML74norHS5ohbKQ1L9qVuJA+W732c2jZXXq4a07XtiO
    5djg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1749122340;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nO6KRGE7iXKdXLCHxoKLLpP27bvkkr5wFMCXgggqY5o=;
    b=XWwGPYMgJjW8uG/wuClo3/PqdbK2MDAG8QVvWV4bCo+tGufXaipCTXVDhLTulsxUrO
    PF7M+iI7TavU2gEPmxPXgTwyZlXP6YUNrJwVwIIkXliB8hK4yIL4ql6Z5nWRPjb6RJQC
    3XLGHN6bI4/eAwXFrWTH6UB0iWJgYQxMziM8QPE5ubLNdYpJIrVct1QT5/dgVte2tnvX
    LzaXrdCzw9W2adQQcHkN81X4BVAUahH7vyvMb7fGVNp9hYRHpUHFrQ5VcjjxkIApGecF
    8wer1JVLLixlgJJFoqr4xA/KpnncF0BPc8doUoKaIdGwFliVKXUHo0NUM794CSUaXKzN
    z53w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1749122340;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nO6KRGE7iXKdXLCHxoKLLpP27bvkkr5wFMCXgggqY5o=;
    b=A13bq/3dD/TykWoMy5uiHkJrKWqGw/1hvgBlWTztwN+AxcdMpKLITtfZ3HATpjQzlY
    qyVoqQjSabk1AB9cZaDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-32.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a340155BJ0l1S
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 5 Jun 2025 13:19:00 +0200 (CEST)
Date: Thu, 5 Jun 2025 13:19:00 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@denx.de, "Pavel Machek via lists.cip-project.org"
 <pavel=denx.de@lists.cip-project.org>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <302216723.180352.1749122340254@webmail.strato.de>
In-Reply-To: <aEF4GNNiA2JOWcxQ@duo.ucw.cz>
References: <1295692742.168185.1749115407487@webmail.strato.de>
 <aEF4GNNiA2JOWcxQ@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st5, 4.19-cip121
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.36.53
X-Originating-Port: 42914
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Jun 2025 11:19:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19023

Thanks for the review!

> On 06/05/2025 12:57 PM CEST Pavel Machek via lists.cip-project.org <pavel=denx.de@lists.cip-project.org> wrote:
> > Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc
> > 
> > 4e1c5d6453080 x86/bugs: Don't fill RSB on VMEXIT with
> > eIBRS+retpoline
> 
> This one is wrong, AFAICT. Mainline does not have
> 
> -       case SPECTRE_V2_EIBRS_LFENCE:
> 
> line, and neither should we AFAICT.

Correct, I'll fix it.

CU
Uli

