Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A86C27C53
	for <webhook@archiver.kernel.org>; Wed,  5 Jun 2024 10:54:56 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.24])
 by mx.groups.io with SMTP id smtpd.web11.12358.1717584889573230856
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jun 2024 03:54:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=LE51JtQs;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=w6kyjWmK;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.24, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1717584880; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gRsd677hHS3Nep03XkkIJChD6IDHSzvi7F2Li4BBS6FN1ncCkJq2by5wHdNfV25iWi
    i2cmxGxCe7PVriY2LGR0uQ5iTqgBNYjZCwglimGzJpLn0Zm3Jn28n+dCZIJwZjA5+3tw
    B5BgukSKgLl6Cgub7T1fUu0qGC8p4YVVegXm/ouuZ6QIg/TlWPCZN8rcb0tROej1X93s
    gFBFLHwCroftEOscKxwaeJkDMkM5tCoQtN0i4d8h3nNi7pttOjVz1lmti/g68h65SQiF
    poT/jQr4HDT7L7OqpgL5IoAzuTxlyRKn3/j2Y9C5Lp2Ff9Z3KzKnQDKgZjYv5A7CZgxN
    qCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1717584880;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2OjPhEqWsBRCpLiici/ogNy984TBbDj4CB4urGL1l0o=;
    b=oNFfaLRZPE+rkjs4V5fUqI7DO54G9BOhIHnToStcm7IZ/BubGA52+ocpbPMqawZhHb
    vureRYzDpYIcOgoGn370sIRls3koOe/BhH6ZJi1R0gMO7ey1nNftNEK/Ji8L2W2N2G3z
    57KUmzm3cdoSJ7VPnDHUacrD2aGLhCrmZxzWipP9GT52DYVrRmJ75I4erldBz23r3RSJ
    AjxWW/QXZr0JOrTugW8pchmn9AH11J+300F8XVbIK+3eAqeXHAvUaD1eP9kVMhwTGGEx
    r/TZJZvG78yY2Exyik1krS4od0OJcpOq816iOLm3IUal/NeN6MTFPkE5jqbWnecwXwEh
    sSug==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1717584880;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2OjPhEqWsBRCpLiici/ogNy984TBbDj4CB4urGL1l0o=;
    b=LE51JtQsSK5J5uf3XKTBcxgr/bMUybE/Ey6eg5eq8VBzggIzMppAhbLuJgZlQ5QpnU
    ukCXMKE2QptUCWh7XRjBCFJOl2SuRj3O4o1t6wqTEHjBpWHIU5g0EXtfhJULLbu3hWao
    oa4gjxgo0nLRwQJKlDvQiWME4t/oGF24EkxeQGON5QADaurkGmiYVAN8U9wNcQVdPbBD
    amaXVFLF0maoFdceF4Upe6QyWthUzfky8JFEiJC8jSKZHp/1rpYoyO2EIg818epgAKqH
    ILrpNR7LGkh+5b6eZLROrdDeiG9xm1phgre1Q/WdsWlLxBXJdv/BdowKd4/A1I/iHhRm
    2TDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1717584880;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2OjPhEqWsBRCpLiici/ogNy984TBbDj4CB4urGL1l0o=;
    b=w6kyjWmKmHdkmElvkwB6AxkkA5u3drkjw3iFkJ3biu85nm8SsmNk+g5xd67VBgSf3d
    AKf0ageQNGnJS8lK8tBw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzstnjV5GU9c7sKNcZuec1/lEjXyi1DCFOscFCe8bGtzH2tsY51y9cL"
Received: from ox-live-app403.back.ox.d0m.de
    by smtp-ox.front (RZmta 50.5.0 AUTH)
    with ESMTPSA id z08c3e055AsdQdV
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 5 Jun 2024 12:54:39 +0200 (CEST)
Date: Wed, 5 Jun 2024 12:54:39 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Cc: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <675504318.1133851.1717584879907@webmail.strato.com>
In-Reply-To: <Zl8HRY8DFKE/PxlQ@duo.ucw.cz>
References: <1638796688.696518.1717408079442@webmail.strato.com>
 <Zl8HRY8DFKE/PxlQ@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st53, 4.4-cip88
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev64
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Jun 2024 10:54:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16113


> On 06/04/2024 2:23 PM CEST Pavel Machek <pavel@denx.de> wrote:
> Ok, so the patches look good to me.

Thanks for the review.

> I'd not mind moving ecbb82ce18d073400afead62c777e18a6b64ef28 ("new
> helper: memdup_user_nul()") before commit
> 5631da623a09e27d57a088411ababe1e44f9a428 ("scsi: bfa: Ensure the
> copied buf is NUL terminated") where it is actually used, to preserve
> bisectability.

True, I'll fix it up.

> Bigger concern is that "x86/insn: Fix PUSH instruction in x86
> instruction decoder opcode map" is in in 4.19-stable-rc, but not yet
> in 4.19-stable. I believe we need to wait for 4.19-stable release
> here, and ensure commits we picked were not dropped, before we release
> this. -stable-rc commits are too experimental.

I guess we can wait it out for a few days.

CU
Uli

