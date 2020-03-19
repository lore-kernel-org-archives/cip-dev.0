Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D25C4332B
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:07:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2D12072D
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 243B6880DF;
	Thu, 19 Mar 2020 21:07:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 17KXPghOE-54; Thu, 19 Mar 2020 21:07:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A0DA988089;
	Thu, 19 Mar 2020 21:07:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 89BF6C07FF;
	Thu, 19 Mar 2020 21:07:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE591C07FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:07:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id CB97088089
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:07:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dKR1W1FtQ-eg for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 21:07:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CAA4187EB8
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:07:33 +0000 (UTC)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
 by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1jF2Ny-0000x3-Gj; Thu, 19 Mar 2020 21:07:26 +0000
Message-ID: <5f2a3e394d6a5e9bc8b9e05df0b17c758c9c46fb.camel@codethink.co.uk>
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Pavel Machek <pavel@denx.de>
Date: Thu, 19 Mar 2020 21:07:24 +0000
In-Reply-To: <TYAPR01MB228523C8A226D17D38E7C3CDB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <20200319110524.GA8475@duo.ucw.cz>
 <TYAPR01MB2285F2D82C8049EE8E7F073DB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <TYAPR01MB228523C8A226D17D38E7C3CDB7F40@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Cc: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] realtime on de0-nano bisection
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

On Thu, 2020-03-19 at 16:13 +0000, Chris Paterson wrote:
> Hi Pavel,
> 
> > From: cip-dev <cip-dev-bounces@lists.cip-project.org> On Behalf Of Chris
> > Paterson
> > Sent: 19 March 2020 11:23
> > 
> > Hello Pavel,
> > 
> > > From: Pavel Machek <pavel@denx.de>
> > > Sent: 19 March 2020 11:05
[...]
> > > like tests are unreliable (and even my basic assumptions may be worth
> > > re-testing).
> > > 
> > > Can you help? I'll be away from console for a few hours now.
> > 
> > I'll get bisecting.
> 
> Last 'good' patch is: 2089f853a8c3 ("drm/i915: disable tracing on
> -RT")
> The first 'bad' path is: c82fe0af5e58 ("drm/i915: skip
> DRM_I915_LOW_LEVEL_TRACEPOINTS with NOTRACE")
> 
> Don't ask me why c82fe0af5e58 causes a boot issue on the de0-nano
> board but at least it's a starting point for you.
[...]

When bisection finds a commit touching code that you're not even
building, the answer should not be "don't ask me why" but "this is not
a reproducible bug".

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
