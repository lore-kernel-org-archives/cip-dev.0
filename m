Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A125C433EF
	for <webhook@archiver.kernel.org>; Mon, 27 Sep 2021 10:44:06 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web08.29636.1632739434435040140
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 03:44:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="no key for verify" header.i=@fpond.eu
 header.s=strato-dkim-0002 header.b=kFgz95gh;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 85.215.255.22,
 mailfrom: uli@fpond.eu)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1632739431;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:References:In-Reply-To:Message-ID:To:From:Date:Cc:Date:From:
    Subject:Sender;
    bh=hgix3NThBAZqUwOoPEyVwxXuRojbHc+ZCp6Bvdlmfno=;
    b=kFgz95ghQtwJ90v22W8tW4QC2CH9KKkPltXpq18h66ZoWUx1D5EGS26WHBPl2tCKcD
    qM9ejL1hImkeWV4kvNaENVfqzl0TToW0Gmashl7jlx1FXkYOSA1lsvZKJgneVAA4thO9
    6b6fXnoc2B3aKLNYb9Mv+96WdKAvlCnmT8lXqCpDboD+x3U7WuNPukuUlsvCLuKl/AKl
    xtAnc1xWBFK80RHmlRqBiaoAQTkWfSK3pE55UxpAOBZKwwulQwzrqP9JiaZcRJrqA+Ad
    +qZtn/fKqSdYZRBjyzn4TQTJvtATdU1U7iXkOqBiXhADXIrATceylBne09by0CA44hNO
    j/UQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B+Io="
X-RZG-CLASS-ID: mo00
Received: from oxapp02-03.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.33.8 AUTH)
    with ESMTPSA id c00f85x8RAhpYWo
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve
 X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 27 Sep 2021 12:43:51 +0200 (CEST)
Date: Mon, 27 Sep 2021 12:43:51 +0200 (CEST)
From: Ulrich Hecht <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1532955493.576116.1632739431463@webmail.strato.com>
In-Reply-To: <20210927100950.GA11971@amd>
References: <20210927100950.GA11971@amd>
Subject: Re: [cip-dev] Coordinating stable reviews
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev24
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Sep 2021 10:44:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6753


> On 09/27/2021 12:09 PM Pavel Machek <pavel@denx.de> wrote:
> Unfortunately, we don't have good system for coordinating reviews in
> -rc phase.
> 
> There's a script (commit.py) that produces one-line-per-patch output
> suitable for review. One possibility would be to have shared place
> somewhere reviewers could tag "I'm working on these patches".
> 
> I don't believe lts-commit-list.git repository is suitable for that;
> format suitable for review is different from what we have in
> lts-commit-list, and there is going to be multiple updates per day in
> busy periods.
> 
> We don't really need commit messages for this. Actually, we don't
> really need to keep history, either. It would be good if system could
> be controlled from command line for easy scripting.
> 
> Any ideas what kind of service could be used for this?

gitlab comes to mind. IIUC, wiki pages are part of the project, but
contained in a separate git repository.

The output of commit.py is practically markdown already; just add a
table header and some extra "|"'s, and you're good.

There will be a history, but I think that can be safely ignored.

CU
Uli

