Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EAAE9DE5B
	for <webhook@archiver.kernel.org>; Thu,  9 Apr 2026 07:29:03 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.126861.1775719736778060557
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Apr 2026 00:28:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=lTXDTydu;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=DCMpc/qU;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.21, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1775719722; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aTzV3pS99oiVHuLNx+w/KczGVN3K0SWhe5cCEhoXS6jGtT6tVOK2YI/PA7fvmZfcL2
    ZAIibiR4K4fIonplg2ty8hi9UKXJ/hlUjjJA32is8nNb11pcH+kQ/r1WTj7V60odNnsA
    GK5HNIzfnXTL9n55z/4pI35tAscmRG4ibgFVvU3NmAg4XoWSyPzDleNE/PuNExx6PohA
    KLY+zQNS5PI7KY1WxA8aK/MAI53PNSm/GromMpraVrVKThR45JW/gywTJ11KxGYK/rS6
    z9fLKsiRooC5AL4Kwwli04TgIh8ae8Afu2182eD43q5FaLAsqCpftIEoR5Wat3yIojXX
    tqfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1775719722;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hF6N3WApx4CnQN2CYBlPiQicZdH0a3rs3SA2jwDmlN8=;
    b=PF/S+jHOpS1dY25hIXioKF1bNyhvyv8uqs/SBcjookHzVxRISqE0R0ccyg+SN4RNvS
    KCbZIeKpYW9D9gfKUQdfyfiDH8WnR7dToiX5F6HFC1DOzxr+PTkZj7bz3aCppNM7rw9R
    xzGiBEJMbuh+O69m3PsEbPqhzuYH0tdDsy85mMdbC2H7It7r2TlmWx2Emyp+umwf3tV1
    eTnuDZhTeN3fAN8fu4B+wMwHvWzNFZ530PpVZdgWXyww/aZe8jWJMRujPd2d74ZM8+f7
    ewK1pRRHqZW4eR3vjyMNhuUPppv6X6NDbgMaPRq1vPLOiBbGCP2XHlmAxHf72FZnxyh/
    jwtw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1775719722;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hF6N3WApx4CnQN2CYBlPiQicZdH0a3rs3SA2jwDmlN8=;
    b=lTXDTyduQDSp3OXlSXj4C5onr2gS5yY9rpBaefOGi4M9ov+35Nj+XoxAWk4yBxZggA
    zaxD53/eJtr+KbKP31TU79M4TgnzhqoM+dUtudwfuiSnfQEJamBec5TpVbJmZqh1cwyJ
    siAUMx9xPe75QIjP8nnrp7j7COXJWGpHFNW+ONpLGhc35oZ7ofUZM4TgqFOJq3+fu+Nm
    kNDiyiLMqWgzoh0cmI/ZTkX6QQ4OSH2B93gu9CmMIfitH0k4OSMX+o/8JHZBlAQ6eEw3
    nBVkGw7bwVz6PPWYPaBWYmh7pvHAv5GOzfZ/Y/zeo1gGyC7GGc6nz6zrfOtCe9OtO/Sd
    yfaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1775719722;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=hF6N3WApx4CnQN2CYBlPiQicZdH0a3rs3SA2jwDmlN8=;
    b=DCMpc/qU4uNljOnmS6VB6CMTE+y9/eVtXm+SzDr2pbWifZPmP2JCGbl77Cel2WpnEV
    lSWrVhXEwMMlhLzyuDBA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRJGvTrR9Q=="
Received: from open-xchange-core-mw-gw-17.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.0.1 AUTH)
    with ESMTPSA id z7806e2397SfIxU
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 9 Apr 2026 09:28:41 +0200 (CEST)
Date: Thu, 9 Apr 2026 09:28:41 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@nabladev.com" <pavel@nabladev.com>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1933779544.248038.1775719721901@webmail.strato.de>
Subject: Request for review for 4.19-st15, 4.19-cip131
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.88
X-Originating-Port: 41376
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Apr 2026 07:29:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22659

Hi!

Here are the manual backports for the upcoming 4.19 kernel release. As always they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.19.y-st-rc

630e7903d2418 nfsd: fix return error code for nfsd_map_name_to_[ug]id
96e0a5c848e8c net: usb: pegasus: enable basic endpoint checking
963b4ef89d7d6 Bluetooth: L2CAP: Fix not checking l2cap_chan security level
a973f99e737ba Bluetooth: Enforce key size of 16 bytes on FIPS level
bcdd464658030 xfrm6: fix uninitialized saddr in xfrm6_get_saddr()
8906907dd0fae netfilter: nf_conntrack: Add allow_clash to generic protocol handler
13c736b3eb26c ext4: don't cache extent during splitting extent
cb6f09dc9ae18 apparmor: fix rlimit for posix cpu timers

Thanks for having a look!

CU
Uli

