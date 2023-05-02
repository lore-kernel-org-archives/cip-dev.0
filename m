Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43490C77B73
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 08:51:09 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.web10.124118.1683017462691008196
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 01:51:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=mBnsL07K;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1683017459; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UgkbhPThZtpJLl/mBTWh3+RLpCD+oDiAhtL6dgKJ0TxFBl9mh4a1elzwFAHdxzhUmo
    cIjRDR20PAeic7WrY3UY5t1FUfw2fHIKEoJDQkHi76GjykJLlVn0XCpkHf8/ex4Gnehs
    jjjhGLwsgUPlhgizyVb40nJ3m53Sf3+5iPRT7m7m1f9mzWE8LCts+QEyLL1Bzas6Wbd7
    Z1KNQWyP2i8M1Ioc9VkFsLzuZqXtOw2pXn0dYTjV0qshXwub4jQsz90BMlnYNIXdP78u
    0iK5SKNjwdkZ0m5neI0wlFDn2owTgyH/h+f8gXiPkuKfwcCVdpQhJAiJcnAXa76PV/Vc
    2meQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1683017459;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=YHZCFksINNkjtIqdt6aMLBwyyZJKr8KSULSC/gnpw1g=;
    b=ATRX1IZxbf41GyHJIN9IC2CxvZXKCLebk+LScFGvhxkJHPhUlP6tbXjm8ygNirrqOZ
    8IoZarENNK/20CQoLkCu6/xIURgoFtk4LNQziausg17F2ch4H16c4t4MDOIWt4byZkAM
    OHTmXom+IDLB+i5p7BFaG0aMfBh+h1mcObfVN2QvE+GAgCmUU43bv3tOpMkHhoMiyoqg
    Wsvqb4UryeEbhB4U0moiwC4d6w8Od0hpv6zWMTZjjPn9sE3XiAxjXUUO/nEQM05691De
    XbqeyaeKV6aG2nBQdP9cc1GUg+gs9C2ftlFEOfwfMYPX0fVBpGW22qPbD3hM00k+Jim2
    /BbQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1683017459;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=YHZCFksINNkjtIqdt6aMLBwyyZJKr8KSULSC/gnpw1g=;
    b=mBnsL07KBs0aJa6BJZGefp3KwhnKqVS4sPlzbLlhurtIvWkG8d7d/hF92TRJxWge6B
    bv2cAXMvSlgRsV88MPm8G5DFs7y9j3XmnDrEzJ0ytSp4exUCWU1Q1072jwAEJZ0y6UJR
    sScujqEsoml2FJhXiOymaDcJpXsIodtaxjbTKlZBaDnO1qRaByoMoiyDwcyfU+SZCOzP
    NFr63zcGNi18yxcmM2jIKF3+fUH5A2QjvpQQWvkrZWIwngp1cVO6hMKmcNOrptM+Br+/
    M10DtLglqdcVZrIxfhb9RxnlGM9yvSK6cU7Fly1n/B/35T+0mT+zu2xFqmaeNKQYqiXt
    9ZTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1683017459;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=YHZCFksINNkjtIqdt6aMLBwyyZJKr8KSULSC/gnpw1g=;
    b=b4C3W+di95j7INorMx3hgxa1q0EIawsYYJBgkcjKruca68tbZqlXypbxXUw2JDhaeD
    OdmHegyBM4HMIWASGzDw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/wuMlg=="
Received: from ox-live-app101.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.4.0 AUTH)
    with ESMTPSA id N2af97z428oxNgm
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Tue, 2 May 2023 10:50:59 +0200 (CEST)
Date: Tue, 2 May 2023 10:50:59 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <2033971969.2306363.1683017459015@webmail.strato.com>
In-Reply-To: <ZE46zUIujMJ+7/dI@duo.ucw.cz>
References: <1785763423.1934045.1682608850821@webmail.strato.com>
 <ZE46zUIujMJ+7/dI@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st40, 4.4-cip75
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev41
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 08:51:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11373

Thanks for the reviews.

> On 04/30/2023 11:54 AM CEST Pavel Machek <pavel@denx.de> wrote:
> > ** m | e10703fd5 5d8d4a o+ | arm64: KVM: Fix system register enumeration
> 
> AFAICT kvm_arm_copy_core_reg_indices() does not have the problem
> described in the changelog, so no change is
> neccessary. copy_timer_indices() in 4.4 always return 0 or -EFAULT, so
> it does not need changing, either.

Indeed; I'll drop it.

> > ** m | 3d081d862 c86c00 o+ | i40e: fix i40e_setup_misc_vector() error handling
> 
> AFAICT this should be going to end_unlock.

There is no end_unlock, because their is no lock here in 4.4.
(That's why it needed a backport in the first place.)

CU
Uli

