Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2ACCD1296
	for <webhook@archiver.kernel.org>; Thu,  4 Apr 2024 12:46:34 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.web10.37075.1712234783535335690
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Apr 2024 05:46:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=r75lEhJn;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=5VmwEZAr;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1712234781; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=VSnJqFT9km1Dnpk8mOC/4q/WyG/17ZgJlQ7lfISBA4pmCQkQyQOsbQfc9uB8O3Tjyh
    kRcll64m3P/HahWeUmbCGZT4kZ4oelgIzpKG6NemSR+xLtqaOJNroEuX/ZkRvMNRzqCL
    ax0SGE2DB5IO6lCe1+2lbU4AkY1+Rk1+Oo3JclndqhLZ0D4D1OoR6u3qkkhTuFk5Zpy7
    pO8mIvOBpXFyjsc5E+EO/1CWJ7WJX9+e5caCjYzpsrnaEOdDi3oC7rttyB5TqQ21Z7jr
    Clv5FKpJXTHNkSGirpbu/sDgP0GLFctc7gH5jXzlTttqb6bX1eRC6YmCH0dVwu1/DMB4
    T8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1712234781;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=garAh8/GY0ssIbqAiOl8tiexWWkbyXHP+F8y/nRiVJM=;
    b=DDjKehmUFg5+OTj22jAOM4DsLy3j8Sn+YyrT1GX8LBEWbf25kiOcuYWMsv/Y8Oo51J
    wHrxj5uqu3fo74+y+e/dxIDzsplc/dSa6lqsvrT5AFLBp+ngKWueKsywRrGwp1oSOLKS
    bFzrTi80nqpcJAwAJ0et7XFU0HPvHmx26Y4afE3sgaJUXiEKa+9rcNhKsDBb2kbqu2tI
    lBTTdou2Usx2VOoTh9FTYzueNCMFYzqD0mWJ5SEF7PgHHD5wU9MNdzPYFKm4iexnL4l2
    XAW/k1+19TrjJGu26ElU9cvGwAY8pOUrzP48BO9qfHzmQtTRFLUNXiweinIIQNe+euqs
    n8BQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1712234780;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=garAh8/GY0ssIbqAiOl8tiexWWkbyXHP+F8y/nRiVJM=;
    b=r75lEhJnNYTL5K1epyDGCR/gRyhkv3FBLnYehh5I5nGzWuWfic225c3teciLWLWFp4
    0Zgzsh4oAg1N4XFY/n6lcUtsYciiDUVZWxyGh36xbGfE53hHOeF0Te7sB9l64Jkbj5hc
    YtnuenI0T6gT4sHBG1tnYss8l1QtDmADSIdTWmQxW4CYXUw6GdZ+4MveWsjKISYIq43H
    b2hB8SYe8n5fNZkEbLQsJl1xW71BrsFYjlodiC61KO1S6Z9R/GAs/yppe9RxjGYLdA8L
    a5IY+oEY29r+t+cWPPPdK9sNw34r3Kf1S3F4Ge7jdzP057LgN+8D6pMjBAxbdSWsMrPt
    cftw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1712234780;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=garAh8/GY0ssIbqAiOl8tiexWWkbyXHP+F8y/nRiVJM=;
    b=5VmwEZAroTDD/rWxZcUucX5I1W+G1dfqNDmTAl8AwqEyj74VZ61/jYMSHH2VpzTsfm
    nE02HzQ4BcAq4qOrFJDg==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7sKNcZueM1/kk7cFJ9/ZpmwZW4gIWTSFIrn4w83ZMTG"
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.3.2 AUTH)
    with ESMTPSA id zaeee6034CkKiWk
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 4 Apr 2024 14:46:20 +0200 (CEST)
Date: Thu, 4 Apr 2024 14:46:20 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Alex Grund <flamefire89@gmail.com>
Message-ID: <907637768.1206318.1712234780581@webmail.strato.com>
In-Reply-To: <CAFm405kQcpwwY9i52V0CHtOem84ze_MOLfTxVJVUbG6MKt6zjQ@mail.gmail.com>
References: <CAFm405kQcpwwY9i52V0CHtOem84ze_MOLfTxVJVUbG6MKt6zjQ@mail.gmail.com>
Subject: Re: [cip-dev] [4.4] Broken GIV crypto
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev61
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 04 Apr 2024 12:46:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15491


> On 03/26/2024 7:38 PM CET Alex Grund <flamefire89@gmail.com> wrote:
> I need to report a bug against the linux-4.4.y-st branch caused by commit 24a1889c (crypto: api - Disallow identical driver names)
> 
> The upstream commit on which this is based is applied to a kernel tree that removed the GIV ciphers and the CRYPTO_ALG_TYPE_GIVCIPHER in upstream commit c79b411eaa (crypto: skcipher - remove remnants of internal IV generators)
> 
> However in 4.4 this is still present and after "something" registered a "cts(cbc(aes))" alg on the "cts(cbc(aes-ce))" driver the code in crypto_lookup_skcipher will dismiss it because of the missing GIVCIPHER flag (type is BLKCIPHER)
> It will then add a fitting alg through crypto_givcipher_default which ends up calling "__crypto_register_alg" which then fails (returns EEXISTS) because it is adding it with the same name and driver name, although the flag is different (GIVCIPHER instead of BLKCIPHER) which is actually fine: __crypto_alg_lookup checks for a matching type before checking the name.
> 
> Hence duplicate names are OK if the flags are different.
> 
> I hence argue that the commit should be reverted as it causes regressions. In my case the device doesn't boot at all anymore as it relies on that crypto alg.

Thanks for the report. I will revert this patch for the next release.

CU
Uli

