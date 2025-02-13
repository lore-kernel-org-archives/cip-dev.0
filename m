Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8501EC0219D
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 10:16:40 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
 by mx.groups.io with SMTP id smtpd.web10.7818.1739441796637428684
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Feb 2025 02:16:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=nGY121Xk;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=OWggQPDs;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.164, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1739441787; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aPzs9JpgVKU+worlOC6z6sUUh6hnaLDwhiyBBReNla8bOKunowFAREgs1siEWPmsaS
    1A4ELDqx88WkgNwY+hRAVyoug2sskJg+PilsZxBN52V30VudTYnZ1ywZddkrcLt5DiDE
    Q0p3aXzMPOVLVZk5gjkA4GzT/mW3z0OINfrcrmJpbC8vOD0xU/NCJpTFbEZv6aAyvqRS
    RN3zdYveenSBTrIoaWDHiA2zpEXi1MzxAGDxFlb4Y84vANOibPQtDYgYYstuJawwXVsu
    q6hU/+0fjBqcc5l+eez49UYLPepTXu7yX9BlrkaFVg8yfVfhsHvRfLw0lEipUAXTYKZs
    ugIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1739441787;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=cvnYl9n69dyD2kCdzrcqFTlUsW59xyZPYV0S2fCndgk=;
    b=X7FgEazcEH78U652gzfuU8/ORGzW4qfvbgxTwYgn1IXOTx0KrqoEq6bhX1wjwQ0JZW
    NImqPHhweRlfeUiCUvEMVrtfJxYaxUm3Guea1TDC4Fakc+FAf+lCixX7c6Ut+gkuHt05
    WspkAwDU59dpusk/zeKXpRfuYqIH9ITBi3j8tyhgAZsaQODBCcmuYSafjEGIJPjdMwgV
    9k9lzwk7s/dtMQOWl5KLu45WK5m+K0lpt8BN56V8dQKDp2YubBz3ZHNy7aYDADvxP01k
    fOXemC/IMcYGPFvvXG+H3f6CBeb+w5fBywDAox/ordvgu6B6PfUd6N5WcdGfEnU8jUyV
    kxVA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1739441787;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=cvnYl9n69dyD2kCdzrcqFTlUsW59xyZPYV0S2fCndgk=;
    b=nGY121Xk+4SHu5jMPlty8ZPV74k1RZQBNernogQhiFFqmj+Amb+XcpIYW1pmldApWD
    j4TexI6wMFcbh8uYmWED6XKvfVijGR5yuzUXrthOYEWygQOFmbGtVvSmoDeo9aDWDPS4
    7xE9LVMdQMiCTJCg8yiPyluDSxqCWBDRW4HQwYGrB8nY/0uLY2QXXJm5kydCMPINfEWc
    TOC5WnFhLzNJW2bXpxcSCym/2hmypSpP9NkPGdGD+Z6o9jErH53Too7sVxIi2fKNJQCi
    V3S/T60d26+59eQk0XfwEVzl3t+hUmLiGwkj8f+LttQT67Ug6doZgI5vEjmdmZrhDxCV
    CqNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1739441787;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=cvnYl9n69dyD2kCdzrcqFTlUsW59xyZPYV0S2fCndgk=;
    b=OWggQPDs3qAyYwWud/aM1gmUkCMB8qsRYVy08xlJ5BwDP3yQiutFGDVyTIZ4sbYm3o
    5gB2JiOYw3Lp7nbtd9AA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app301.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.23 AUTH)
    with ESMTPSA id z0a38411DAGRQ0I
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 13 Feb 2025 11:16:27 +0100 (CET)
Date: Thu, 13 Feb 2025 11:16:27 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Finn Thain <fthain@linux-m68k.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Michael Schmitz <schmitzmic@gmail.com>,
	cip-dev@lists.cip-project.org, linux-m68k@lists.linux-m68k.org
Message-ID: <960544762.1079819.1739441787128@webmail.strato.de>
In-Reply-To: <72a512bd5463ee04f4840f49cee2f3c3@linux-m68k.org>
References: <72a512bd5463ee04f4840f49cee2f3c3@linux-m68k.org>
Subject: Re: [PATCH 4.4.y-cip] signal/m68k: Use force_sigsegv(SIGSEGV) in
 fpsp040_die
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
 <cip-dev@lists.cip-project.org>; Thu, 13 Feb 2025 10:16:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17828

Sorry, I saw these five minutes too late. Applied for the next release.

CU
Uli

> On 02/13/2025 8:22 AM CET Finn Thain <fthain@linux-m68k.org> wrote:
> 
>  
> From: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> [ Upstream commit a3616a3c02722d1edb95acc7fceade242f6553ba ]
> 
> In the fpsp040 code when copyin or copyout fails call
> force_sigsegv(SIGSEGV) instead of do_exit(SIGSEGV).
> 
> This solves a couple of problems.  Because do_exit embeds the ptrace
> stop PTRACE_EVENT_EXIT a complete stack frame needs to be present for
> that to work correctly.  There is always the information needed for a
> ptrace stop where get_signal is called.  So exiting with a signal
> solves the ptrace issue.
> 
> Further exiting with a signal ensures that all of the threads in a
> process are killed not just the thread that malfunctioned.  Which
> avoids confusing userspace.
> 
> To make force_sigsegv(SIGSEGV) work in fpsp040_die modify the code to
> save all of the registers and jump to ret_from_exception (which
> ultimately calls get_signal) after fpsp040_die returns.
> 
> v2: Updated the branches to use gas's pseudo ops that automatically
>     calculate the best branch instruction to use for the purpose.
> 
> v1: https://lkml.kernel.org/r/87a6m8kgtx.fsf_-_@disp2133
> Link: https://lkml.kernel.org/r/87tukghjfs.fsf_-_@disp2133
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> [ Pass 'current' to force_sigsegv() as was done prior to v5.3 ]
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
>  arch/m68k/fpsp040/skeleton.S | 3 ++-
>  arch/m68k/kernel/traps.c     | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/fpsp040/skeleton.S b/arch/m68k/fpsp040/skeleton.S
> index 31a9c634c81e..081922c72daa 100644
> --- a/arch/m68k/fpsp040/skeleton.S
> +++ b/arch/m68k/fpsp040/skeleton.S
> @@ -502,7 +502,8 @@ in_ea:
>  	.section .fixup,"ax"
>  	.even
>  1:
> -	jbra	fpsp040_die
> +	jbsr	fpsp040_die
> +	jbra	.Lnotkern
>  
>  	.section __ex_table,"a"
>  	.align	4
> diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
> index 35f706d836c5..c6f18dc5884b 100644
> --- a/arch/m68k/kernel/traps.c
> +++ b/arch/m68k/kernel/traps.c
> @@ -1155,7 +1155,7 @@ asmlinkage void set_esp0(unsigned long ssp)
>   */
>  asmlinkage void fpsp040_die(void)
>  {
> -	do_exit(SIGSEGV);
> +	force_sigsegv(SIGSEGV, current);
>  }
>  
>  #ifdef CONFIG_M68KFPU_EMU

