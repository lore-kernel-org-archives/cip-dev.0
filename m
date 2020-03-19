Return-Path: <SRS0=K/mb=5E=lists.cip-project.org=cip-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057C9C4332D
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:19:34 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8E5620776
	for <cip-dev@archiver.kernel.org>; Thu, 19 Mar 2020 21:19:33 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cip-dev-bounces@lists.cip-project.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A161924AFE;
	Thu, 19 Mar 2020 21:19:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TuK8In9Ubwr; Thu, 19 Mar 2020 21:19:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 4F77D23528;
	Thu, 19 Mar 2020 21:19:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 343D1C07FF;
	Thu, 19 Mar 2020 21:19:32 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E199C07FF
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:19:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0D0C28851E
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:19:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NQXgWxhsdoGi for <cip-dev@lists.cip-project.org>;
 Thu, 19 Mar 2020 21:19:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 1DD3188517
 for <cip-dev@lists.cip-project.org>; Thu, 19 Mar 2020 21:19:29 +0000 (UTC)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
 by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
 id 1jF2ZX-00017n-6m; Thu, 19 Mar 2020 21:19:23 +0000
Message-ID: <b69e07c1d0a7d24676934d1b2e7bd9bf0083a621.camel@codethink.co.uk>
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: vijai kumar <vijaikumar.kanagarajan@gmail.com>, 
 nobuhiro1.iwamatsu@toshiba.co.jp
Date: Thu, 19 Mar 2020 21:19:21 +0000
In-Reply-To: <CALLGG_J1dHZqFKLQvUszh35-ZO3d_w7m4SQuAcqSYbyNAQH8LQ@mail.gmail.com>
References: <CALLGG_Juuz3wktbc71uo68shAU4ZpaxKzAqycKtzKd0R4Meemg@mail.gmail.com>
 <8cc7afeb-409b-3dee-df4b-e6a63f979723@siemens.com>
 <OSAPR01MB36676897A7976E3D6079ECDE92F90@OSAPR01MB3667.jpnprd01.prod.outlook.com>
 <CALLGG_J1dHZqFKLQvUszh35-ZO3d_w7m4SQuAcqSYbyNAQH8LQ@mail.gmail.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Cc: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
Subject: Re: [cip-dev] Linux-cip: Kselftest plans
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

On Tue, 2020-03-17 at 13:30 +0530, vijai kumar wrote:
> On Tue, Mar 17, 2020 at 4:19 AM <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
[...]
> > I am now implementing LAVA's kselftest. This kselftest uses kseflftest included in the latest kernel.
> > There are no plans to backport tests to 4.4 or 4.19. I believe that ksefltest included in the CIP kernel
> > is inadequate in function and difficult to use as it is.
> > I suggest using a new kernel test that incorporates the latest tests.
> > 
> 
> Thank you Nobuhiro-San. Our original idea was to use the kselftest
> from 4.19/4.4 cip tree. We faced some issues with
> out-of-tree compilation while debianizing it. Also we faced some
> compilation issues.
> 
> If that is the case, that we are going to use kselftest from the
> latest kernel, how can we track the kselftest binaries for a
> particular
> cip kernel release? I am not sure if all the test cases would pass for
> 4.19/4/4. Do you have any plans to maintain a branch and release
> kselftest binaries and/or testcases that have been tested with a
> particular cip kernel release?

Some self-tests will fail on older kernel versions due to missing
features or bugs that might not be practically fixable.  Test cases can
report "skip" rather than "fail" for missing features, but this is not
done consistently.

The way I've used kselftest with stable branches has been to look for
regressions rather than any failures.  The Linaro folks are doing that
(reporting regressions only) when sending test results to the stable
list, but I don't know how or how much they have automated that.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom

_______________________________________________
cip-dev mailing list
cip-dev@lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
