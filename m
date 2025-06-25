Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F90BC7EE2A
	for <webhook@archiver.kernel.org>; Wed, 25 Jun 2025 13:45:50 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by mx.groups.io with SMTP id smtpd.web10.9562.1750835092018740967
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Jun 2025 00:04:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=korg header.b=Evu/Cd0V;
 spf=pass (domain: linuxfoundation.org, ip: 139.178.84.217, mailfrom: gregkh@linuxfoundation.org)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D7B8B5C6484;
	Wed, 25 Jun 2025 07:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D3FC4CEEA;
	Wed, 25 Jun 2025 07:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750835091;
	bh=wBhr6J56w/ZiNbviQOGGOWP7clZmcCBlwVCk5XVUESs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Evu/Cd0VvvDnAvdy19vDIRk9GB7+HykkwwyrbxFKPhAr+tto21bllHUpnZRZ5ErOJ
	 OcN5mipVpIh5ICDjpSqVIuSa66qUTnzCjjZyzhdC0Ta7UrDuos/cEMrLWvNTHFCV6W
	 MaXugj00PrVxP73dVKI5jQf331jrPghB1SJs+XJ0=
Date: Wed, 25 Jun 2025 08:04:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>,
	Pavel Machek <pavel@denx.de>, Bart Van Assche <bvanassche@acm.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Yi Zhang <yi.zhang@redhat.com>, stable@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
Message-ID: <2025062506-thimble-unwieldy-9c6c@gregkh>
References: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
In-Reply-To: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Jun 2025 13:45:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19233

On Wed, Jun 25, 2025 at 11:00:26AM +0900, Nobuhiro Iwamatsu wrote:
> From: Bart Van Assche <bvanassche@acm.org>
> 
> commit fc663711b94468f4e1427ebe289c9f05669699c9 upstream.

4.4.y is long out-of-support by us, and this is in all activly supported
kenrnels at this time, so why is this sent to us?

confused,

greg k-h

