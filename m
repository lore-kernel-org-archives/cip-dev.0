Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0A3D14895
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 02:58:20 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.23665.1767841090672190908
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Jan 2026 18:58:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=tNIXi2Wf;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=0zUGIDhL;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1767841084; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZwKhRlu7C47XOHQNzNaJgUVSTnxqe6A+j788THjgEm5aU8huUYX/zxYK5nvX3rnzc7
    Y85vNSncRh2N7B+KRKMTvEdyOj79ATMyIumdzxaAa884fu0WCbZ3Iz5PKRn3l6IZc4Qq
    gBQThNBjkhdA4aEQnW3V/k5JgHMhkNFpOEdEj3X0hShgRlk0nRna40fxbuvXBjxkJCSN
    aOBDNeKtEJpT1OzHoCcgPCFaC5TMX3Vqxg0Ka6kooplhT00gb1fR4aQd/u82dFuNkfAi
    1g5XQAzRxAGxp+2mgYvz22NQyNUU+TxgwQtYhos5G87116TjCWlyUdIt4jJO5MaoCVFv
    aOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841084;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uBtOlgUG8KU5Dxqeo1YJww8R06N4qaNg347o52k2I2w=;
    b=Pwjz6VGrIu65QJ/rJI9D9nJpQ6IIM4D7MfvlS6xvBHZV71ICqbR+VaqbwDZXOFFQTo
    IPkf7oyNIpoc34z2j6kWQ75cRx+9g8jUEtpuHXKhXvVLFmd2nECV6IuU/QJy3mDoQcXY
    azzh+qjLyf90OOv4FkrfzpPPtUDqGHXe06RX0VCrBDqkR2tU72WLigwDUIHJcEgCGEAP
    j4R1lEVCaUHr1z5QOBNu2TSsvXck9L0I2xLrLXXd8DsTAG1YUesywYhY+zlUouZhkU3p
    /AO7mzfd3/BafJvpnWGPv4tcUMOINto5hClerUcH2E6IHL3WDUr0DQS/G/aSVSIpICME
    KOTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1767841084;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uBtOlgUG8KU5Dxqeo1YJww8R06N4qaNg347o52k2I2w=;
    b=tNIXi2Wfqds0B2GNsujOhcv6tiDjiPaBUuQ96eqOIH7B8/JPDJ8iVUq1yGTBtwonRj
    9vMmNAqPYbAd61hpDy88iR8OlR6z78iDZkWASW1raf4iXlzIpG/pMWW8SMLlP7GDiicC
    0csNa9pJuPKr20pFworWfnaoz+VkKXCkLn2wZAEgWsFFcaHO/w3k2CdiFHmtQU/WVgHN
    KCNg9NHtMriGUSpEmiVUdoW+goRXs5pyoshLbV0Vds+XXv189c7dgKMCFUL3EQQrH2aQ
    QvmwXu73jNnO0U/ljCLGnpgSgrQRuAJTY+x91vZ8lVDNaLZ8FNqTNBdyMb3tdtSgYCat
    hfUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1767841084;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=uBtOlgUG8KU5Dxqeo1YJww8R06N4qaNg347o52k2I2w=;
    b=0zUGIDhLhhFDL43YP8UGo4ZNK6UPStvawWLLV4ylTZDwKCMEgRBby33U+a/p+EtudD
    5fTORixtayUatTZfd7BQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaRxGvRy6JA=="
Received: from open-xchange-core-mw-gw-33.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 54.1.0 AUTH)
    with ESMTPSA id zfda172082w4VkA
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 8 Jan 2026 03:58:04 +0100 (CET)
Date: Thu, 8 Jan 2026 03:58:04 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: pavel@nabladev.com, "Pavel Machek via lists.cip-project.org"
 <pavel=nabladev.com@lists.cip-project.org>
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>
Message-ID: <1735019797.426254.1767841084204@webmail.strato.de>
In-Reply-To: <aVwzWx4vKyMEaIXL@duo.ucw.cz>
References: <512263003.35605.1766383683487@webmail.strato.de>
 <aVwzWx4vKyMEaIXL@duo.ucw.cz>
Subject: Re: [cip-dev] Request for review for 4.19-st11, 4.19-cip127
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.42.74
X-Originating-Port: 42622
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 02:58:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21428


> On 01/05/2026 10:55 PM CET Pavel Machek via lists.cip-project.org <pavel=nabladev.com@lists.cip-project.org> wrote:
> These patches look good to me. I did not take complete review of

Thanks!

> "80bf4633c7043 libceph: fix potential use-after-free in
> have_mon_and_osd_map()" as that one looks tricky.

I think I incorrectly marked that as a manual backport anyway...

CU
Uli

