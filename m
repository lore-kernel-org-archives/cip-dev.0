Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB4FC3ABC9
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 12:44:44 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
 by mx.groups.io with SMTP id smtpd.web10.11524.1747313082571122712
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 05:44:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=DSCuVBSS;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=Gppypy2Q;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.50, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1747313065; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kZHNLyVBf4lIeMIeAC441myIEuRX2O8TziTlq3WzDTfOyJ4RBVO284sIt0azM3Rvlw
    UAuidWT6FgCdqyt7hh+VX19+tvtnvVhQzBfqHfnmL9gAaKqpcij9lTmIEzHM8rIVjHXo
    VusHOEzEXc+cVCLkDXaRYb3x37jC6P8lLGzuDY0pAxBQmnha7CFUW/XiwV0x8d9nIevk
    zWAQcNEc2QXfx7lRM93rtdfx8WSrBSF4jYIGgWM+5VHUMclspuAz3Hu79tghKWsYYkIa
    b4JkEu/P7B5F2G1dxOBK3fYRGjCXnWfbpXzNuk6FSXWD+7Xb+56wad8/ioO5j65+6stE
    ozuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1747313065;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=F8Ts6R2ZbYNmhcgTAZ08JwfLq7KTMD+upJ0v2IwpUog=;
    b=ToyLat5z2QNPAi7tQ4RTwTJH6gq/2CkHXROByYD/iCBelOUsz91P87zk7rlqTqr4oI
    p+13Vf1+j4BmpMrSNegJawwWN5IfwyXrS3PNwg2iVn78LOnv0PtFELBjemA7yu+lIY2S
    mA2GruEpq6usGTLTraEyyV3voF9CwW3voUE791lAyKvgn2XpgsrxtvU7Fd4yb903dUhg
    5X2+dGX/3DNydqOz5h5MptZfNO4y9GCETUJ9CI5jwlwAfd8Bm3L/rhxFuuKyXbSlsdwc
    i5aE/qOnUeEh6oKULDI39c81jxi+dRD5eWJiQYrih5jZVf2eyBOB8g07OV6jBtj5BpVY
    MU1Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1747313065;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=F8Ts6R2ZbYNmhcgTAZ08JwfLq7KTMD+upJ0v2IwpUog=;
    b=DSCuVBSS9l6DvEnlQVX61JlO88YIJb6DdO3jeWz5APpoEqRWmxqMVWFA/SQkIvHGSJ
    EWvXVdLMWcWRQUCgToGB3U2yjOLujpHT2N7E1VEsxu5FPa//Yq9eG6/7CUc9a/ROghxD
    ooSDsNjAR91RiDo50slD0EOpCKY/eIyothXpKjMIbsU7XXQ5903nerJPAjv3HO/Fd17Q
    2rjnYBV/j3n2toAmRwcGlBicW9BBPVJD4cGjxZnvuozjQR2I23PUa1+Ou+VYCFkPgMfY
    3k90rujJswotTEbXI8mn/J1yFojuEeuufQq/i7c3gUCjkEf4Sl8F+DFED7frZvfQztR2
    BTzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1747313065;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=F8Ts6R2ZbYNmhcgTAZ08JwfLq7KTMD+upJ0v2IwpUog=;
    b=Gppypy2QrO0KHdbTXrp2kcYYAeoa7wV+K0c4V+FsMRkyEC9lt/2jYAhsq1pNmXHjTZ
    YyiUPaL5x6QYBbDIJDCQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv30UF1hex6fd76vq"
Received: from open-xchange-core-mw-gw-14.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34014FCiPSq4
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 15 May 2025 14:44:25 +0200 (CEST)
Date: Thu, 15 May 2025 14:44:25 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: prabhakar.mahadev-lad.rj@bp.renesas.com, cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Message-ID: <1605143841.341243.1747313065539@webmail.strato.de>
In-Reply-To: <20250514094308.60634-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20250514094308.60634-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip] ARM: shmobile: smp: Enforce
 shmobile_smp_* alignment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.33.60
X-Originating-Port: 52930
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 12:44:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18913

Sorry, I forgot that. :(
Applied for the next release, see 5be7f3340a41ce6731855db578e36004dfe7d441.

CU
Uli

> On 05/14/2025 11:43 AM CEST Lad Prabhakar via lists.cip-project.org <prabhakar.mahadev-lad.rj=bp.renesas.com@lists.cip-project.org> wrote:
> 
>  
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> commit 379c590113ce46f605439d4887996c60ab8820cc upstream.
> 
> When the addresses of the shmobile_smp_mpidr, shmobile_smp_fn, and
> shmobile_smp_arg variables are not multiples of 4 bytes, secondary CPU
> bring-up fails:
> 
>     smp: Bringing up secondary CPUs ...
>     CPU1: failed to come online
>     CPU2: failed to come online
>     CPU3: failed to come online
>     smp: Brought up 1 node, 1 CPU
> 
> Fix this by adding the missing alignment directive.
> 
> Fixes: 4e960f52fce16a3b ("ARM: shmobile: Move shmobile_smp_{mpidr, fn, arg}[] from .text to .bss")
> Closes: https://lore.kernel.org/r/CAMuHMdU=QR-JLgEHKWpsr6SbaZRc-Hz9r91JfpP8c3n2G-OjqA@mail.gmail.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Link: https://lore.kernel.org/c499234d559a0d95ad9472883e46077311051cd8.1741612208.git.geert+renesas@glider.be
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Reviewed-by: Pavel Machek <pavel@denx.de>
> ---
> Note,
> - Just resending the patch with Reviewed-by from Pavel and Iwamatsu-san.
> - This patch needs applying for 4.4.y-cip only
> - Patch previoulsy posted https://patchwork.kernel.org/project/cip-dev/patch/20250404095757.58956-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  arch/arm/mach-shmobile/headsmp.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
> index cef8e8c555f84..49df98d8b459b 100644
> --- a/arch/arm/mach-shmobile/headsmp.S
> +++ b/arch/arm/mach-shmobile/headsmp.S
> @@ -139,6 +139,7 @@ ENDPROC(shmobile_smp_sleep)
>  	.long	shmobile_smp_arg - 1b
>  
>  	.bss
> +	.align	2
>  	.globl	shmobile_smp_mpidr
>  shmobile_smp_mpidr:
>  	.space	NR_CPUS * 4
> -- 
> 2.43.0
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18905): https://lists.cip-project.org/g/cip-dev/message/18905
> Mute This Topic: https://lists.cip-project.org/mt/113105617/6379558
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [uli@fpond.eu]
> -=-=-=-=-=-=-=-=-=-=-=-

