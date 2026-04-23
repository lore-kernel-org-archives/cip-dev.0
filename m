Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4B5FB44A6
	for <webhook@archiver.kernel.org>; Fri, 24 Apr 2026 04:59:08 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.18025.1776946202549563202
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Apr 2026 05:10:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=korg header.b=fOxPqJZ5;
 spf=pass (domain: linuxfoundation.org, ip: 172.105.4.254, mailfrom: gregkh@linuxfoundation.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4C9A86001A;
	Thu, 23 Apr 2026 12:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834FAC2BCAF;
	Thu, 23 Apr 2026 12:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776945717;
	bh=KM2UWxJdDtbafNJCdvc9QOth2uvBdUVM62K2HwN8lNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOxPqJZ5wZhAIIJUFr+0WAhXKV4CDwc23++xvSzIv3L9zwTC5jtTssQt5dXWnatkj
	 kZAja9MlFhVucdq9Yl8xtAywM2dekjMidwIP1CAUqGL2b1evuH4KYc6mhnXDF/5IOl
	 gCEZZ1pj0goDqXqCg2CPQt6nli26qtRt7NYbUoqY=
Date: Thu, 23 Apr 2026 14:01:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: nobuhiro.iwamatsu.x90@mail.toshiba
Cc: sashal@kernel.org, stable@vger.kernel.org,
	cip-dev@lists.cip-project.org, pavel@nabladev.com,
	chris.paterson2@renesas.com
Subject: Re: [for 5.10.y] Please revert "8af1c121b0102 riscv: Sparse-Memory/vmemmap out-of-bounds fix"
Message-ID: <2026042343-recoil-retriever-8076@gregkh>
References: <TY7PR01MB1481866BE80F41418D964AE61CD4EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TY7PR01MB1481866BE80F41418D964AE61CD4EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Apr 2026 04:59:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22806

On Wed, Mar 18, 2026 at 02:03:44AM +0000, nobuhiro.iwamatsu.x90@mail.toshiba wrote:
> Hi Greg and Sasha,
> 
> Please revert "8af1c121b0102 riscv: Sparse-Memory/vmemmap out-of-bounds fix" in Linux-5.10.y branch.
> Since `phys_ram_base` is not defined in riscv, a build error will occur if `CONFIG_SPARSEMEM_MANUAL=y`.


Can you send a revert with this information in it?

thanks,

greg k-h

