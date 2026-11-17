Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.1249.1794931909380596524
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Nov 2026 08:11:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=g/Pyx0DP;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=ye9F8k0E;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.52, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1794931899; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H2Wd9berviofah6FgNZWOfDJ6E2sYH1f5ivkiRWK11QEUffTG961G3XZG+kGnWFTW/
    lur31ys0Apujn1kY6J5LNi/Re7wG9tXlC10bvD6oKJVcu4EAdQIUyooleWcEPTKZadlc
    m9dKkOq+wH2J+G553zoTZ8F8vSZBWJlP7HymDNRxgb58K/JTy9eCx/Hw0h3dwaCUNIsw
    6LNYqVli8DWnpMFOvAVC8jup+n3BBW3vWwiHkTxBiY8slEer18zHRrS5MGYuMspI23Y5
    xdsTuUb3uc3jPYacMzlm93FMrDKnZF8iVddE7maNzEFoIcHRod5qcvRMtrcA+QNnlevV
    S/XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794931899;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=VY8OcxMZ1nR6ZHwZFCquz+zakbVGmjauz3OYKJ6tHnA=;
    b=OM9CYZJ/MoCy7IcxI3sIIHedR48yXejAzsM/8jYKMs/A6QmIzQ+BS2nGmurM2m9Zo9
    Kj422YSFkgRYnskd2TeTtJH50hguxCytzsiv4tiDWLIHgaCgSXsyDqUK+ttF8dou2515
    IT2L7Wr4m5buw2uguSUuMTn/2SB6kme5v1nef3vHHCKA+Y4BJgacPH47KRDGe2AC92nW
    gcugfA5JZBm4TXecUCNWM0LmwN/B6YhRBU6lqPSheamaYiXod4ul0Te5Hee33AjQJoHv
    C4WMUUq1nNF1+JUhwW6QvhUCI/z29S6TSVh9y26P4LnOAQ2y00x+zkDzQ8tPt8XYWu8T
    kjEw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794931899;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=VY8OcxMZ1nR6ZHwZFCquz+zakbVGmjauz3OYKJ6tHnA=;
    b=g/Pyx0DPY/fJ6WlcfLitJaDYdo7Lx3ax/HYO7kXnMPvhqM/+szRJqNNciYscCXA4Do
    pwwV1SzJOlqMaa3zsDEblgFxF8GMFXqoAB1j+LSQw6jmid1Av+jP0zHuj9jEmNkeUUjl
    iusUNDQj470VszsUy7OPAZTXpHCwzWQV3Lw08N5BBwT8/qjjxo1Mg/n/i9tt1SuWzzI4
    93zuQFGFrsG9BIGfSvmi2BEsmkWeZSrurF/CBRfxMFKjb2pQQtkfJ/ywC/HmVjKWLDaT
    ogCCSh85hlCx7rkzB+wBb6dPQnDl8XaotU950mLQBxAB47dTx3iGRtRQvJxfEueGMjJM
    Tx4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794931899;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=VY8OcxMZ1nR6ZHwZFCquz+zakbVGmjauz3OYKJ6tHnA=;
    b=ye9F8k0Ea4d4ufONjKv4MAG8R92vgJWXbBmKGChyX6bXNDFZEBo2QKVkTTmZyvMahC
    m+TGeP48Bxa3XkypCKDQ==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzotGZvghOuyX/LuaP4"
Received: from open-xchange-core-mw-gw-7.open-xchange-core-mw-hazelcast-headless.open-xchange.svc.cluster.local
    by smtp-ox.front (RZmta 55.6.3 AUTH)
    with ESMTPSA id z81ed22AHGBdVAu
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:11:39 +0100 (CET)
Date: Tue, 17 Nov 2026 17:11:39 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: nobuhiro.iwamatsu.x90@mail.toshiba, cip-dev@lists.cip-project.org,
	pavel@nabladev.com
Message-ID: <1854696130.1239098.1794931899510@webmail.strato.de>
In-Reply-To: <TY7PR01MB14818A05E3A9CE2B63F7846FDCD7B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <179686212.779511.1794480813521@webmail.strato.de>
 <TY7PR01MB14818A05E3A9CE2B63F7846FDCD7B2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] Request for review for 4.4-st81, 4.4-cip116
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v8.46.154
X-Originating-Port: 54752
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 17 Nov 2026 16:11:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24945


> On 11/17/2026 3:28 PM CET Nobuhiro Iwamatsu via cip-dev <nobuhiro.iwamatsu.x90=mail.toshiba@lists.cip-project.org> wrote:
> I reviewed this update, looks good to me.
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Thanks!

CU
Uli
