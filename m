Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF56C678D5
	for <webhook@archiver.kernel.org>; Wed,  8 Mar 2023 13:42:11 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by mx.groups.io with SMTP id smtpd.web11.2032.1678261936303454264
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Mar 2023 23:52:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@suse.cz header.s=susede2_rsa header.b=yJWtV8Qq;
 spf=pass (domain: suse.cz, ip: 195.135.220.28, mailfrom: vbabka@suse.cz)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D8392219CB;
	Wed,  8 Mar 2023 07:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1678261933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajLJgfxVW7toycKUmqFHYGhNrFyJxe76oJOYl0j9fF4=;
	b=yJWtV8QqKc/IUYslYDebBr+swXwwAaEjnkg/dULLsk7E2Jg6BgtZ56eOmdrvgtFkfyHWrF
	8fpLROVh7eW0zbN4m1dGAnbY9JmlwdMJxc5KMLEebj0EjyOFW6acfHeqrXzJoLS5LqxPcX
	VH83sRJZe6sJH73cfp1vNaAtachqLRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1678261933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ajLJgfxVW7toycKUmqFHYGhNrFyJxe76oJOYl0j9fF4=;
	b=SpWznofVbE8h/bHADY7wN1pEKYEVByRT1rFyCYQ8JDeq12nPH3Jo/qN4n1JbPAQNH/cHhO
	UGskiNJ2aSz3mLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2D451391B;
	Wed,  8 Mar 2023 07:52:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id B6apJq0+CGSQAwAAMHmgww
	(envelope-from <vbabka@suse.cz>); Wed, 08 Mar 2023 07:52:13 +0000
Message-ID: <651ee4e5-b298-606e-938f-0e49fdf295c3@suse.cz>
Date: Wed, 8 Mar 2023 08:52:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Who is looking at CVEs to prevent them?
To: Dan Carpenter <error27@gmail.com>, oe-kbuild@lists.linux.dev,
 lkp@intel.com
Cc: Hillf Danton <hdanton@sina.com>,
 Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
 cip-dev <cip-dev@lists.cip-project.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@vger.kernel.org
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
 <20230307110029.1947-1-hdanton@sina.com>
 <b27c7950-873a-f0e9-d7b4-322bb941a11f@suse.cz>
 <6d1ad8e9-2bec-4cd4-b4dd-595c88855274@kili.mountain>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6d1ad8e9-2bec-4cd4-b4dd-595c88855274@kili.mountain>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Mar 2023 13:42:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10951



On 3/7/23 12:53, Dan Carpenter wrote:
> On Tue, Mar 07, 2023 at 12:42:03PM +0100, Vlastimil Babka wrote:
>> Why do you keep adding linux-mm to the Cc list of random threads that are
>> not about MM?
> 
> That's kbuild-bot stuff.  The kbuild-bot generates those emails and I
> just look them over and hit send.

Sorry, wasn't clear that I was asking Hillf who did the Cc on this
thread and other threads (not only kbuild bot threads).

> I don't why the kbuild bot CCs linux-mm either...  Let me ask the devs
> about that.  A lot of the -mm warning are correct but just the CC list
> is weird.

Sure, it's fine if a bug is suspected to be mm related that linux-mm is
Cc'd, even if it turns out a wrong guess in the end.

> The kbuild-bot stuff is really nice for me.  The kbuild-bot doesn't use
> the cross function DB so everything is local to the function and easy to
> review.
> 
> regards,
> dan carpenter
> 
> 

