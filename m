Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6168DEB64D9
	for <webhook@archiver.kernel.org>; Mon, 10 Jul 2023 16:47:11 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
 by mx.groups.io with SMTP id smtpd.web11.45028.1689007623438860709
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Jul 2023 09:47:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=fNqNRlVC;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.23, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1689007620; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=lHcaPqF3s5jbNJYcMQKS9/cYQ3D1RJ4nRsb9vbgUMX9JQz01jhHKdGNaiIHDAxmxin
    gcFcedvOiZOtqSsWH5Fx0kFPQOklRfDWFgu5MYh8nc6gUYfti7TdYDfDLy3R//cB26Wg
    RTXVH56fk/wJOfgFHQR9os7AxH+9dPiw9+0oioj1ouHcKK9Bz9AioPCBGquUIuWM+/of
    D7SYHT3YKFy4DzsvVWimZqFfbDPXq/rZBSC1ysgFHIVBNm7dHCPACBF1ZhPbv+Q7GvaX
    Viq7aAEs6bvVJJxW9p9BMp54CPfie+XCSncM3ttKWa3cCQrBjKkCcT+HVgoQCIl+H4Re
    VIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689007620;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=RenoW4Lo3LO7iyRxP2I/AxERcvQvh8SIapc4MRhrZWE=;
    b=K32JGtkD3Dg7F8P+tL914WctZ8A/iM9xYnu/Gt1rn7vyZDWmBPNIgJX+EFjc5uK9Kl
    kbi0YksmZKrw7yblsoH+7wRYrmeXMVi/a5R7J74Qilz8jazjstkl6urc61ADoEOCDt1O
    rnElABSkVORVXWsOQjHZ9VAGgNNxxDIagf7rGP9aYOfy7MEJ0Yd3adFerbXmEiP75A35
    G2nNEUlRLpjx3P0kobuOnZ6XdpAwj96xIF+MIn4V7J8wHOqlhKaaxV+H8XW0Un0LWOPh
    09hYecuTQImhytvM85NHxAdrnaOFQ3vgeNLHLcwPCd1fVNEybYtsoG4lVwsmZVsoiqhp
    06PQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689007620;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=RenoW4Lo3LO7iyRxP2I/AxERcvQvh8SIapc4MRhrZWE=;
    b=fNqNRlVC5KWCszC2TeMaqQvTcYJzcQWxF3/7Y2oeSb0VTZQhCp0rSKobTVR6xcsW+2
    iyC9pk6Q3xbELyAOrxgVyq7Dt7OQRTgkgB9B0hgpHaUce2fU5ORno3c3f1wVEWJAH97G
    oD8aBBWid3Jc++jE9MYq3Nd9okumdDmouRqLfzBEEBzaTuTvbfrwfLTOnr91d2cMTZtk
    Tgyq9rYb67VYRSvm4ejhmhoSaak8taGs7CuVCbH5oURfhBH8ANHynlgjeNMLbm3sRthV
    kM5DWiKY7kxN3ekz6xzFz4QZDRVrJqlAtguOeOYrdl2EzjcxLNY3e99o9LH8fTfGK2VJ
    AMfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689007620;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=RenoW4Lo3LO7iyRxP2I/AxERcvQvh8SIapc4MRhrZWE=;
    b=mdgzWsu4QuXD8Q/aj6VH6S48qnB44cXa3vfdQdVK2lwk78twSQbGTA7fzCVX2ZdSTA
    aHMK4jahmkmGncNDznBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCt/7N+P9k="
Received: from ox-live-app205.back.ox.d0m.de
    by smtp-ox.front (RZmta 49.6.0 AUTH)
    with ESMTPSA id K29863z6AGl0TvI
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 10 Jul 2023 18:47:00 +0200 (CEST)
Date: Mon, 10 Jul 2023 18:47:00 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1604792087.2619298.1689007620064@webmail.strato.com>
In-Reply-To: <ZKsPiq6+/Zx1CLHr@duo.ucw.cz>
References: <721088923.1980911.1688547506942@webmail.strato.com>
 <ZKsPiq6+/Zx1CLHr@duo.ucw.cz>
Subject: Re: [cip-dev] Request for reviews for 4.4-st42, 4.4-cip77
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev47
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 10 Jul 2023 16:47:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12299

Thanks for the reviews!

> On 07/09/2023 9:50 PM CEST Pavel Machek <pavel@denx.de> wrote:
> a| 61256d2d6 None o+ | netfilter: nft_dynset: do not reject set updates with NFT_SET_EVAL
> 
> Usual marking is "Commit xxx upstream.", this one has [ xxx ].

That's how the commits come in from stable. Are we using that in an automated way anywhere? If not, I'd rather not spend time fixing stuff like that.

CU
Uli

