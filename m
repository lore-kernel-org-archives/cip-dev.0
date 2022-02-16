X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by mx.groups.io with SMTP id smtpd.web08.11001.1645013505766718229
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 04:11:46 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@suse.com header.s=susede1 header.b=RqJkoLNF;
 spf=pass (domain: suse.com, ip: 195.135.220.29, mailfrom: mkoutny@suse.com)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9526C1F383;
	Wed, 16 Feb 2022 12:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1645013503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC0qP875Q1XxrqsRDTs/Ypp44fI0BKOxsPOdOcgRsww=;
	b=RqJkoLNFd86BZo/K4/zGSEEoKfyM5j3WJbUB4icAii6A05qEC+E40yZSXcQZmVk0ZlYpcZ
	l/Y3RGlad3/BtJkWvEd49RGRJdThzgfNeN2+VDSayieMh322JyAndiPK8rkaDCkH5qrD7S
	ZKccEqmXwUKsnZZzxSucJeL8t93ZrTQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 784B713AF3;
	Wed, 16 Feb 2022 12:11:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id XVjVHP/pDGLaRAAAMHmgww
	(envelope-from <mkoutny@suse.com>); Wed, 16 Feb 2022 12:11:43 +0000
Date: Wed, 16 Feb 2022 13:11:42 +0100
From: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To: Masami Ichikawa <masami256@gmail.com>
Cc: cip-dev@lists.cip-project.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Tabitha Sable <tabitha.c.sable@gmail.com>, stable@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Masami Ichikawa <masami.ichikawa@cybertrust.co.jp>
Subject: Re: [PATCH for 4.4.y-cip] cgroup-v1: Require capabilities to set release_agent
Message-ID: <20220216121142.GB30035@blackbody.suse.cz>
References: <20220215234036.19800-1-masami256@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20220215234036.19800-1-masami256@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>

Thanks for sharing this Masami, I've been looking into pre-cgroup_ns
backport too.

On Wed, Feb 16, 2022 at 08:40:37AM +0900, Masami Ichikawa <masami256@gmail.com> wrote:
> [masami: Backport patch from 4.9. Adjust to use current_user_ns() to get current user_ns.
> Fix conflict in cgroup_release_agent_write().]

The condition to allow modifying release_agent is two-fold:
a) caller is capabable(CAP_SYS_ADMIN),
b) cgroup_ns is owned by init_user_ns.

In pre-cgroup_ns kernels, it is IMO safer to consider all (=the only)
cgroup_ns owned by init_user_ns.

So the (positive) condition translates into capable(CAP_SYS_ADMIN) only.

[
Additionally, there's invariant/implication
  capable(CAP_XXX) -> (current_user_ns() == &init_user_ns) ,
so the expression
  (current_user_ns() != &init_user_ns) || !capable(CAP_SYS_ADMIN)
simplifies to
  !capable(CAP_SYS_ADMIN) .
]


> @@ -2839,6 +2856,14 @@ static ssize_t cgroup_release_agent_write(struct kernfs_open_file *of,
>  
>  	BUILD_BUG_ON(sizeof(cgrp->root->release_agent_path) < PATH_MAX);
>  
> +	/*
> +	 * Release agent gets called with all capabilities,
> +	 * require capabilities to set release agent.
> +	 */
> +	if ((of->file->f_cred->user_ns != &init_user_ns) ||
> +		!capable(CAP_SYS_ADMIN))
> +			return -EPERM;
> +

Following the reasoning above, the check simplifies too but it should be
be against the opener, not the writer:
  file_ns_capable(of->file, &init_user_ns, CAP_SYS_ADMIN)

(It seems to be to be incorrect even in the original commit.
So I'll send a patch there to rectify that.)


Michal



