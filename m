Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF8E7717D
	for <webhook@archiver.kernel.org>; Thu, 12 Dec 2024 03:06:17 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.web11.11973.1733972771580693679
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 19:06:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=Je763sKI;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=2HsAn4BK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1733972768; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fPd0A51muNXLM00EAGqtTfMH7hK7KAu1IEucPaNHdfcOenrSEjyXzihxfVTLIKHGuo
    zdfsijcCDvpdut6CyODbNakWw6LFLia3jYCEmBz5xy1Uj9UyBThBNCpMz9y6gozboq//
    JFYmSO7oSAFVT9Pm6ac0sS5JnZ0iQ5ecy0cBoWLpKVok45LWP68NDrdDz1r96kt9Sd4E
    +loJWVpgFkM8B98hF2chjyHaxKmJ1PNPopXtsKu41js8BBs3iZ3b2UhlFD9OWNS/6W35
    oQ/ubL6dY7RxnmyEiuHw2s/s9OIgYsFozmV23DMuDf81j/q6Mm7rOanA/agpZcEu6Y0C
    JuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733972768;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=I0LMOx2L3+EMu55Ium5e6UMHoVqOJ70Lhh3ovK18S+8=;
    b=V1LtUbD1mXKgmY8HWi/q2/AI13BuoTykMQDTFzIcDqTUKnaFY/goNRFFqCjDmaZz1A
    67XxRJSp00zbLQm6EXPJWxWjWhlQYocn2i9DI0KliyHucHV7PPmfp65wOiElU54tAD/o
    msCvhJTQocrfGV66OLc9Vu0djfyF3JzwXay3GIkSLuH84LwgY2h2Hc40q8XjPyzdqCMf
    mFsp1kdVP36+zrJlnCw/8SFbVoDKCHbHnjb4t0sAS3zHSMQFRE7QaSRYLGTkhGt8+Omf
    utb+qmTgqVoYQSE/BbhFAey4HpMlSddiKV/PL6akZFszr++MoJga+bnk0jkk/oP/ETdp
    btCA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733972768;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=I0LMOx2L3+EMu55Ium5e6UMHoVqOJ70Lhh3ovK18S+8=;
    b=Je763sKI9IFMT9OdJ4RgHSe84jk/SLOsGJyjmRVKxNp/vKWEhIMwptEdUz9tw2J4Ye
    0XiS6t4Qu3+H8N1Q6Uo3UJpUnUkLLlqNgERLS7VsZ234HKoagqhoyGDWUEVf3TRVeuJA
    ghMy5IOxmvSBtAFXaaJJkd3Y69aLHfYODFrcEjNxt5F8MChUdj1W2ZDWUEGx0Hteg7uS
    TyIlImy1paWYVgsI3J7ivRfltsI0u+G0ehRN7ERy6lYbo++OGXBsK94GttQ9v2tbFz78
    5PLYzn3pzQA4e9psrOuP7dBZDR+dmqE2yN3OP6v8wQzLaoHJdnxJNtZ4o5k7g3j/S9HM
    x0wQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733972768;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=I0LMOx2L3+EMu55Ium5e6UMHoVqOJ70Lhh3ovK18S+8=;
    b=2HsAn4BKD9XsqYAqyBSiH4GxpUtdRHz2lLFKyuFSAkDUlqPAZFCtCSwVGoKcllAzrw
    GyIvaycic5fRWKUtMTAg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app405.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.11 AUTH)
    with ESMTPSA id z9fbae0BC368af6
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 12 Dec 2024 04:06:08 +0100 (CET)
Date: Thu, 12 Dec 2024 04:06:08 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org
Message-ID: <83580734.2136174.1733972768709@webmail.strato.de>
In-Reply-To: <Z1oKlyKZkSw0Bhq0@duo.ucw.cz>
References: <Z1oKlyKZkSw0Bhq0@duo.ucw.cz>
Subject: Re: 4.4-rt nilfs problem
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev70
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Dec 2024 03:06:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17410


> On 12/11/2024 10:56 PM CET Pavel Machek <pavel@denx.de> wrote:
> This 4.4-rt release is proving more "fun" then average. Last problem I
> hit is this one:
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/8612057735
> 
> fs/nilfs2/dir.c: In function 'nilfs_find_entry':
> 2705
> fs/nilfs2/dir.c:350:31: error: initialization of 'char *' from incompatible pointer type 'struct page *' [-Werror=incompatible-pointer-types]
> 2706
>   350 |                 char *kaddr = nilfs_get_page(dir, n);
> 2707
>       |                               ^~~~~~~~~~~~~~
> 2708
> 
> And I believe it is caused by 3ab089df2d67491785a5bdaab01cfab8eb35dab5
> :
> 
>     nilfs2: propagate directory read errors from nilfs_find_entry()
> 
> @@ -345,25 +347,26 @@ nilfs_find_entry(struct inode *dir, const struct qstr *qstr,
>                 start = 0;
>         n = start;
>         do {
> -               char *kaddr;
> -               page = nilfs_get_page(dir, n);
> -               if (!IS_ERR(page)) {
> -                       kaddr = page_address(page);
> ...
> +               char *kaddr = nilfs_get_page(dir, n);
> 
> Compiler does not like page * assigned into char *, and I don't blame
> him.

It seems this is missing a dependency, namely ea2ac9238d4919bdc6963a2b487a65ccdaa11c78 ("nilfs2: return the mapped address from nilfs_get_page()"), which in turn has more dependencies...

> I could probably hack something up -- like below -- but it raises
> questions such as
> 
> a) "should kaddr by checked for IS_ERR like that"?

AFAICT, no. page_address() returns NULL on error.

> b) "am I comfortable changing code we are not testing"?

Given that that is what this backport does and how well that worked, I guess the answer is no...

When maintaining file systems for 4.4, nilfs2 is the biggest effort by a mile. From what I can tell it's used in only one config (moxa_mxc_defconfig). Is there any way to find out if it is actually used or just happens to be enabled?

CU
Uli

