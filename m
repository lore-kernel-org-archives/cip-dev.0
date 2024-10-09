Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA98CED630
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 08:51:39 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
 by mx.groups.io with SMTP id smtpd.web10.11624.1728463891359153972
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Oct 2024 01:51:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=SKKGuFJ+;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=F+E1pwhg;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.160, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1728463883; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IApUyS8dCPkpTo0+uLkn30rMhn1h2yR2Ekz6nEhLfLXU618E7xMtsXaIvmSpoIQd7a
    sKAREOzJPLO4T+w8IgIPMa/Zkl8ubIZb5wwOXD2E0JIOOXm+Z5aDNzj/j54hPsDXwsHh
    bepGX58VJlgsnqM/BsW2jRVdEWVca4aYcseMCkpV4nfTkam4+1Lk2tkQx4biVwQEey4n
    cC4fx8im72/GUH9vY84I1dXZ7QisOq/a6sp39kfn1jgTQuPSvFLKLsb5UfuEXU4M8cM6
    HZFLe471biSfAkUH9/ITHfO1RKEPDQKB7f1ts4v7v4Mi5oN+IAtMy158mrv/rs/arU8b
    pqnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1728463883;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xeVvU0vBhYXH0Tx25fEHuPIogU6d2x5m8d7GRsvGVzs=;
    b=JIV+6gMENHpzgopAxhanxQc04Yfssnm0t1MYqPl7LvFTpE/hyjxEQEg948JBr9cynT
    35G6BM12tYICNHQhTEcKfWZpwt7l9kocxFxMeUmGNVf8X7jvBaTbymgTt69Nn0l4tywu
    eYRffTOmhGrM0FBFbGvCiBLPnu1PKHI770etLdDlGP+2n+VVb+8XNQKTDRdaOptp3XFs
    jbN+GRsFFMgtLl3j8f5Stf1kU9mNRXP2gh39VYTXEqobsa7oVyuC7n4p8w8hi6K5ie28
    0zBnM4/xHStYGmyXeQ00qPqyJGr/IW1iElDsSfvM3GskErcBIDfaSTd0069rrUDUODQz
    nuSA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1728463883;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xeVvU0vBhYXH0Tx25fEHuPIogU6d2x5m8d7GRsvGVzs=;
    b=SKKGuFJ+W5Gqoy8uogB9r7BYpVX2lUPtm01IdPlh4pgwxPnwELskXJvRd5xIv0QH/l
    YnxBeSg6bjJocGIPbGzz8XlkMwkvepVBY1xW7MpRO7mAdbtbeuie3WlP04AgdPS2gKMH
    JtHXSODAMnR0mzLgZkNVMYQ/PpWeMWstIfLfSDE21/qRzkffw+if4lp6CIZBhb5KCaYB
    TxBzcqpoAV4TbQpDRP62izLA5In5VvzQ/65Rjm5e0cjIdvu6BpOrU+OIcSj7Ws6CZeQr
    Ee3ALAMlINGrQGMFtU8oPlCk358vBuUQtVkWVxVb0Sp1ZuNMeOut95n+/NCx+gsQLDVs
    x8iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1728463883;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=xeVvU0vBhYXH0Tx25fEHuPIogU6d2x5m8d7GRsvGVzs=;
    b=F+E1pwhgtM+/tjbG1gRyc6qo6kmUX0S4G3gxL+Grpo3BSjl6IvVNt6ppyBNT/wPn03
    ZInYbUG3Thialxmh5kAA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app303.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.8 AUTH)
    with ESMTPSA id z0d2fd0998pN4vU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 9 Oct 2024 10:51:23 +0200 (CEST)
Date: Wed, 9 Oct 2024 10:51:23 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <2106895704.3199145.1728463883187@webmail.strato.de>
In-Reply-To: <ZwQ8tc+9S/gDDy5/@duo.ucw.cz>
References: <1841375864.2314304.1727945930345@webmail.strato.de>
 <ZwQ8tc+9S/gDDy5/@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st57, 4.4-cip92
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev68
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Oct 2024 08:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17017

Thank you for the review!

> On 10/07/2024 9:55 PM CEST Pavel Machek <pavel@denx.de> wrote:
> ! missing locks[level] = ? > f6a9c01857b6ce btrfs: clean up ourhandling of refs == 0 in snapshot delete
> 
> I'd expect path->locks[level] = 0;, but if it is a problem, then
> problem exists in mainline too.

I left that in. If it's actually a problem we'll hear about it anyway.

> !! adds a WARN > be060e6fdb11b1 quota: Remove BUG_ON from dqget()
> 
> This converts BUG_ON to WARN.. which would be ok, but BUG was #ifdef
> DEBUG, and WARN is not. I'd just drop this one. (Plus, I'm not sure
> condition is correct one for 4.4 kernel, and it will not be easy to
> check.)

Dropped.

CU
Uli

