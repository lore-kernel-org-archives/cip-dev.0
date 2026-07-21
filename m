Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DEFDC44512
	for <webhook@archiver.kernel.org>; Wed, 22 Jul 2026 03:32:48 +0000 (UTC)
Received: from galois.linutronix.de (galois.linutronix.de [193.142.43.55])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.22528.1784639750504567778
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2026 06:15:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linutronix.de header.s=2020 header.b=ry/sgQaZ;
 dkim=pass header.i=@linutronix.de header.s=2020e header.b=hgbro4Aj;
 spf=pass (domain: linutronix.de, ip: 193.142.43.55, mailfrom: bigeasy@linutronix.de)
Date: Tue, 21 Jul 2026 15:10:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784639403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mBraF0RfzEUQVxZj/6XRRqC3MDBHG5bBNNzjmYPivuw=;
	b=ry/sgQaZ8SG1LvJpJapC/JGGBXTH3B6xoeAUbL0CJvAxaeQ9Yvfjh6HB+wElCff/9wlXDJ
	wC9R28FJQHCypjymtO9pwP3HcACfqmnwflaAl//a+U+eY0YGa0Q1LmD5xbZplvbXRJHugR
	JWXgSZtuZjB8W6DlrdiIKx93HMl/OyNgoYrI9nfGxkJNyABgq49/F+uHsxDlYXJKVfig7L
	LTWZm+TzFJSzXgQaEbbessmCn8mIIzbawWnpUHTf8dpyhMhGRVoaraddWyhOmSFTaxw+HY
	LJgrgwT5XOMZ3DIATstBHkV4hkALcqx6FGRw5oMBDIXL+MOq58kEe7aVLBolVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784639403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mBraF0RfzEUQVxZj/6XRRqC3MDBHG5bBNNzjmYPivuw=;
	b=hgbro4AjDdANnY+wDH+SeBc0pT2nsjrNtKEyZ6Cif1N7NpL7e823WxriDeebZ5oU57eV/t
	WXoSzQuvQCAjo3Aw==
From: "bigeasy@linutronix.de" <bigeasy@linutronix.de>
To: Daniel Wagner <wagi@monom.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba, stable-rt@vger.kernel.org,
	cip-dev@lists.cip-project.org
Subject: Re: v6.12-rt arm updates
Message-ID: <20260721131002.4h77xeHc@linutronix.de>
References: <8a0f6ad1-0df7-4707-bcc4-83603cada945@monom.org>
 <20260717134624._f9g97lg@linutronix.de>
 <141ef3cb-361d-432c-a7ba-af010406283c@monom.org>
 <20260717140336.krBy6oQT@linutronix.de>
 <3706c5f1-53af-460e-9409-fa1b78706645@monom.org>
 <20260717142210._ukh1yBD@linutronix.de>
 <72dcc63c-9786-488e-a840-f383533f2fbc@monom.org>
MIME-Version: 1.0
In-Reply-To: <72dcc63c-9786-488e-a840-f383533f2fbc@monom.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jul 2026 03:32:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23707

On 2026-07-21 13:06:24 [+0000], Daniel Wagner wrote:
> It all runs fine in my test setup. Any objections to release this?

No. Go ahead.

Sebastian

