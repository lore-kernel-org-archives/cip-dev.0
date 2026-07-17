Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FDEC44515
	for <webhook@archiver.kernel.org>; Mon, 20 Jul 2026 13:43:19 +0000 (UTC)
Received: from mail-10626.protonmail.ch (mail-10626.protonmail.ch [79.135.106.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13760.1784295684974356263
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:41:25 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@monom.org header.s=protonmail header.b=PUnL97wM;
 spf=pass (domain: monom.org, ip: 79.135.106.26, mailfrom: wagi@monom.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org;
	s=protonmail; t=1784295682; x=1784554882;
	bh=jUnoLo9MY/iC54jYfcmPKDwmvYI8oBrPnAo02LLt6qQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=PUnL97wMIrWTcHGzlpdqzpqsYvB+yvCgv9vEqqc0/qFwn2Q5cZ/O4FsUove7eLDut
	 eUs18mVR43WoretwCzgiH++Z6sIhO1DZZCdSdFKqyTWIyWazx+NKhMY/39P0QPx0s9
	 NBVJiWJzGqoyv1paCWg/NbHse979n2OlzAyjh1dykWCeLKRsjfOJTNYhLdIHrwnHhV
	 +nhcK71GO/yJ6B93Q3STP6TJkSYMgGSsk4kTjGkdLxtv3hPcNjrypJeMUcw8skyYUE
	 pDlOWy+oNQaDwttzwBVCcNdyY02/Q9I/gb7+ZqEua6TOHxVY7vl8V9YT6bVf8Y/Rz8
	 Blt2IW6nqV/Sg==
Date: Fri, 17 Jul 2026 13:41:18 +0000
To: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
From: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com, nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org, cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <0a00b244-c91e-4cf8-9acd-a02aadd05d7f@monom.org>
In-Reply-To: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
Feedback-ID: 209527651:user:proton
X-Pm-Message-ID: bc470b5baa9dd7d8cde11e14db27e80aaaa34c51
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Jul 2026 13:43:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23680

On 7/17/26 3:30 PM, Daniel Wagner wrote:
> #########################################################################=
##
> # ARM
> #########################################################################=
##

> # Commits in upstream but not in v6.12-stable
> ARM__enable_irq_in_translation_section_permission_fault_handlers.patch
> #  59e4f3b45b96 ("ARM: ensure interrupts are enabled in __do_user_fault()=
")

I am replacing the stable-rt patch with the upstream commit here.



