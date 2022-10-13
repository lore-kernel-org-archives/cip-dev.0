Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B663C4332F
	for <webhook@archiver.kernel.org>; Thu, 13 Oct 2022 08:36:51 +0000 (UTC)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
 by mx.groups.io with SMTP id smtpd.web10.5235.1665650209199640086
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Oct 2022 01:36:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=SrqtThEL;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.54, mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1665650194;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=m09tmj0BgQaFnoJgRSSKHmSYlXr53FK5qmZxikiw5Bg=;
    b=SrqtThELL88roDifemThigjcW9BmU/BluoP0/MYmxxVO3x541YAKMbiLjWG5r5BglM
    neymmOL9c+5dVg6GMDH+zgwWaZA/nSEs5mTqBc3E1I8y8bk76zmlP3eYsekjbOCMXpri
    TOuBwz4Hv4AasaQG1+q6eJYdqcXgISPxdqCyCXHg8O0HDT9pgCk7VWfZ7+e6nEwiK2pl
    WYLQv/U4P5be/AV776NQJENQ0uR+MUoe1nuYhutQUtXbxCQZ1ne5Izmw4JQeGiLjcn7V
    fo9HSgHBmw29yZthoPTFIk9GE9DOHKsFq8/DXTuSaNck5uWWy6irn+6d57vqPX5uycJ6
    nFWQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fCv/x64iFM="
X-RZG-CLASS-ID: mo00
Received: from oxapp06-03.back.ox.d0m.de
    by smtp-ox.front (RZmta 48.2.0 AUTH)
    with ESMTPSA id L73d6ay9D8aXCMH
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Thu, 13 Oct 2022 10:36:33 +0200 (CEST)
Date: Thu, 13 Oct 2022 10:36:33 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Hung Tran <hung.tran.jy@renesas.com>
Cc: Pavel Machek <pavel@denx.de>
Message-ID: <1263180941.78238.1665650193479@webmail.strato.com>
In-Reply-To: <OSZPR01MB7019463C819F66866FBCED43AA229@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <20221006114326.GA21855@duo.ucw.cz>
 <4d6db8d8-3d96-6969-f551-baa94f865fa3@siemens.com>
 <20221006220740.GA7670@duo.ucw.cz> <20221006223251.GB7670@duo.ucw.cz>
 <95aed7d4-b775-7273-9478-b0d9ca77938c@siemens.com>
 <20221007101932.GB25429@duo.ucw.cz>
 <66be9e25-7b51-14f1-6a48-352eb748f689@siemens.com>
 <8492e784-1af5-5584-1109-63c9aee53cab@siemens.com>
 <OS0PR01MB59228F2E10391C505F8C8CB586219@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <d0ace49c-29a7-baf8-ba7b-bc385df68492@siemens.com>
 <OS0PR01MB59225BD41E0A32CBD136C68386239@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <af98d87b-b1cb-9123-fd61-c0e06004b7c4@siemens.com>
 <e93e0736-cb18-f42f-9c22-e9825b82cc5c@siemens.com>
 <OSZPR01MB7019765C0F247A3854D4380EAA239@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019463C819F66866FBCED43AA229@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Subject: Re: [cip-dev] ldconfig segfault on RZ/Five was Re: Preparing
 isar-cip-core for RZ/Five
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev29
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Oct 2022 08:36:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9750


> On 10/12/2022 11:50 AM CEST Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> I did a quick test with the patches pointed by Florian but unfortunately ldconfig still fails.

I did some experiments on RZ/Five with this issue, and I'm almost positive that there is something wrong (or doesn't work as documented) with the icache handling on this SoC.

1. The issue only affects non-PIE executables (there are very few of those, basically just ldconfig, gcc, cpp and gcov* on the Debian system), and it occurs very early during the execution of the program. According to the datasheet, the cache on the ax45mp-1c core is virtually indexed, so it is unlikely that a PIE executable will ever hit anything in the cache when newly loaded, but it is much more likely with non-PIE executables.

2. Setting a breakpoint before the illegal/segfaulting instruction doesn't work, and what is executed is clearly not what we're seeing through the dcache (the offending instructions are neither illegal, nor are they able to cause segfaults), so instruction fetches must see something different.

3. Neither manually calling __vdso_flush_icache() from gdb (which executes a "fence.i" instruction) nor patching a "fence.i" into the ldconfig binary seem to do anything. According to the ax45mp-1c datasheet "fence.i" should flush the dcache and invalidate the icache.

My educated guess is that, in spite of the claims in the core manual, the "fence.i" instruction is not implemented, or not implemented correctly. (The datasheet does acknowledge that "fence", without the ".i", is a nop.)

The RISC-V ISA manual says that "fence.i" is part of the optional "Zifencei" extension, which I don't see mentioned in the core datasheet anywhere. (And at least at first glance, I couldn't find any other mechanism to invalidate the icache there either.)

CU
Uli

