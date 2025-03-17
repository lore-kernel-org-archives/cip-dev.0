Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1235C28B28
	for <webhook@archiver.kernel.org>; Mon, 17 Mar 2025 10:02:48 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.162])
 by mx.groups.io with SMTP id smtpd.web11.48723.1742205760993881674
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Mar 2025 03:02:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=iUgBWWJn;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=+k90IpnY;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.162, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1742205750; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kUP/3VnAvJWtX8erGSxsH2lCEHzggv3q1RxjYYaehICGbyWzSJ0+NoInS3uslRDMZ3
    keAMoI72SRY8NRYVBG784O5E3sNMnLkGMj0iJGVT6kkA1DdOUU9QpxYXav039bZpcy+E
    YHeI+ZWG5Enunjr/9vo4EDhYei3EbRnFjc6WUj90cpVqx3apz1L04JgPnTBh5XP4zcV3
    d+3OVyp0bLQnTJqZStnFfHiaVxuK2ZuywPdqw2i1Yhy0gdI7liCy4IY67JSn9R8VsgxS
    Vn6sY1Jtl7/xxDDgDSG2pFmkFRUdJZIB6fQu6hewJXDoV29MZ1q7vyVsoNcpjBwDPP5e
    omCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1742205750;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=UqdhupULGPu60ZQJMCTL3kZwdsOM4OeqZqNg+XINOP8=;
    b=VJeWzPX9eQjzz4vDOrfnquEq8i6KuL1jR4BQO7pb7C1BbmBFC10rrbTPpSnPtVmCS9
    t/bYNKpHqISxaxE9lwIaau7qj8eosm5OcmEjYS5ix3tJihGbX5yVSkd1cAauxVT6pmdZ
    IUbJXJXxz54LT+bAxzaVhlDLzY/QV7Qwxc/tThM7XGr6bIgnZQ3v+wdjPipX9osL2TMN
    II97SCE1kAAL3aZjqTnAh8ieboJ5Vt69+h0SXYL2duK8i1OaPR3LL12Bbp5UQ+daW3AP
    bdhIlNF4p5yv/t23UVMatO9AUj5at0KGwDiZt96+jXTfVboQmP1rcfnxk2jAEEj7apLW
    Z9/g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1742205750;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=UqdhupULGPu60ZQJMCTL3kZwdsOM4OeqZqNg+XINOP8=;
    b=iUgBWWJnCPA3M2IH9XvkKTfYeGhYT/j5f7uAhHrBi02vsqA5EoxOdNxwhgxHZmCPgc
    7ZzYOv79HdCPe1GnpFHD0cwkoKP1LhOhN8YLbgauBj/laqUbYbixXOsQ1XM0QMxFlnNf
    vZ+rW7iwcbbqn96taGdZckTxM2sVYB6z2a7YlJRMZzSQElG7P7a/XEQlaMuL9pM+hEHM
    tKlPw3670uVod+LEA9McNvfs0taak+11SlZ08yqIp9KU+qdbEqoKG9zQpzLr+YUOjnV0
    7QcHlPCpvenMUVcgSNsSPHSim/FlvPeq6BVvSqqEPBHWBDD5VqzV9IEuSG91Vyc5psVG
    KDuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1742205750;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=UqdhupULGPu60ZQJMCTL3kZwdsOM4OeqZqNg+XINOP8=;
    b=+k90IpnY0wxLsMPhCiXDJPWojkTEtl2N2BznUM0loYcfI0dYCGgtHsb9OhK8tC98gE
    sO73cszOF3/s8yi4lCCw==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZsghGuyX3LvXid7Q=="
Received: from ox-live-app404.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.3.0 AUTH)
    with ESMTPSA id z2a34012HA2TqZg
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 17 Mar 2025 11:02:29 +0100 (CET)
Date: Mon, 17 Mar 2025 11:02:29 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
	cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <969782407.3230737.1742205749339@webmail.strato.de>
In-Reply-To: <b3ce7d24-9264-4d00-8c78-2501dc827b7c@bp.renesas.com>
References: <20250221165755.357838-1-paul.barker.ct@bp.renesas.com>
 <1074551120.2807839.1740450494914@webmail.strato.de>
 <b3ce7d24-9264-4d00-8c78-2501dc827b7c@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip] watchdog: renesas_wdt: support
 handover from bootloader
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
 <cip-dev@lists.cip-project.org>; Mon, 17 Mar 2025 10:02:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18227


> On 03/17/2025 10:21 AM CET Paul Barker <paul.barker.ct@bp.renesas.com> wrote:
> I don't see this commit in v4.19.325-cip118, is this expected to be
> included in -cip119?

Sorry, that was a mistake. This is the first patch that only goes to -cip, not to -st, and I forgot that my merge script dumps all local modifications to the -cip tree before merging -st...

It's fixed now, and the commit Will be included in -cip119.

CU
Uli

