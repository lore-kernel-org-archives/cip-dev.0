Return-Path: <SRS0=3drx=5F=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47644C4332B
	for <cip-dev@archiver.kernel.org>; Fri, 20 Mar 2020 21:42:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 202AC2072C
	for <cip-dev@archiver.kernel.org>; Fri, 20 Mar 2020 21:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0C32387D69;
	Fri, 20 Mar 2020 21:42:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LkqeZgILsEni; Fri, 20 Mar 2020 21:42:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 25A088669A;
	Fri, 20 Mar 2020 21:42:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 059B0C07FF;
	Fri, 20 Mar 2020 21:42:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86717C07FF
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 21:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 73D8720463
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 21:42:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id i8s6HF+CCwsu for <cip-dev@lists.cip-project.org>;
 Fri, 20 Mar 2020 21:42:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk
 [78.40.148.184])
 by silver.osuosl.org (Postfix) with ESMTPS id 507E420371
 for <cip-dev@lists.cip-project.org>; Fri, 20 Mar 2020 21:42:36 +0000 (UTC)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
 by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1jFPPN-0004O8-Nt; Fri, 20 Mar 2020 21:42:25 +0000
Message-ID: <429a5416450240c08907d5e7bfc772f326b0c4e4.camel@codethink.co.uk>
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: nobuhiro1.iwamatsu@toshiba.co.jp, pavel@ucw.cz, 
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Date: Fri, 20 Mar 2020 21:42:24 +0000
In-Reply-To: <OSAPR01MB366764C9C68FDC11C0D5EFAC92160@OSAPR01MB3667.jpnprd01.prod.outlook.com>
References: <20200215195407.GA10344@amd>
 <OSAPR01MB366764C9C68FDC11C0D5EFAC92160@OSAPR01MB3667.jpnprd01.prod.outlook.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Subject: Re: [cip-dev] [backport 4.4] mac80211: Fix TKIP replay protection
 immediately after key setup
X-BeenThere: cip-dev@lists.cip-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: <cip-dev.lists.cip-project.org>
List-Unsubscribe: <https://lists.cip-project.org/mailman/options/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=unsubscribe>
List-Archive: <http://lists.cip-project.org/pipermail/cip-dev/>
List-Post: <mailto:cip-dev@lists.cip-project.org>
List-Help: <mailto:cip-dev-request@lists.cip-project.org?subject=help>
List-Subscribe: <https://lists.cip-project.org/mailman/listinfo/cip-dev>,
 <mailto:cip-dev-request@lists.cip-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: cip-dev-bounces@lists.cip-project.org
Sender: "cip-dev" <cip-dev-bounces@lists.cip-project.org>

On Mon, 2020-02-17 at 23:14 +0000, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Pavel,
> 
> > -----Original Message-----
> > From: cip-dev [mailto:cip-dev-bounces@lists.cip-project.org] On Behalf
> > Of Pavel Machek
> > Sent: Sunday, February 16, 2020 4:54 AM
> > To: cip-dev@lists.cip-project.org; Chris.Paterson2@renesas.com
> > Subject: [cip-dev] [backport 4.4] mac80211: Fix TKIP replay protection
> > immediately after key setup
> > 
> > Hi!
> > 
> > So... this is first backport patch. I'll need to reformat a changelog.
> > 
> > The patch should pass our tests on gitlab, but I somehow don't think those
> > tests involved wifi at all... At least it compiles.
> > 
> > Can someone test it easily? Should I just submit it to stable explaining
> > I did not test it?
> 
> If testing is difficult, how about sending a patch to stable ML as RFC?
> We may get reviews from the patch authors.
> 
> > Do you have other patches that should go to 4.4/4.19?
> > 
> 
> I don't think there are other patches.

The security tracker shows a lot of fixes missing from 4.4.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
