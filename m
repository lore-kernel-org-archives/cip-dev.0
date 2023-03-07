Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB10C6FA99
	for <webhook@archiver.kernel.org>; Tue,  7 Mar 2023 12:57:04 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by mx.groups.io with SMTP id smtpd.web10.12200.1678189326595449512
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Mar 2023 03:42:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@suse.cz header.s=susede2_rsa header.b=jxnOzSkk;
 spf=pass (domain: suse.cz, ip: 195.135.220.29, mailfrom: vbabka@suse.cz)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2776A1FE1A;
	Tue,  7 Mar 2023 11:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1678189324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfCj1neJmCfrUUT47ZTKFAGgBx7IRsC7B39zh/pZjJY=;
	b=jxnOzSkkr5lkAr9qQ5rP6QSJxhoITzp3JhsC5Ul3YRJoDOKIG7W3hfXM1dA/htQNqqp5vp
	3KyKQcUtPkSTmnSMdfG4eikDYQT9Dp2wY0VNy9qVGykhugTBuczRxARXzDFgF8/FMYRHWA
	MsZ7rcFab88U9sENderRWcdjhWY/SRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1678189324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PfCj1neJmCfrUUT47ZTKFAGgBx7IRsC7B39zh/pZjJY=;
	b=ZsSdeVP/rqguQhmuE0vDQX9SWmwCIFY4m6IHGs0t9wlZvK/HXfMOvkmNFXe8CcrZmXhte0
	sHbpXFiLf1M/5/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0513D13440;
	Tue,  7 Mar 2023 11:42:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id iMo+OwsjB2TqEgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Tue, 07 Mar 2023 11:42:03 +0000
Message-ID: <b27c7950-873a-f0e9-d7b4-322bb941a11f@suse.cz>
Date: Tue, 7 Mar 2023 12:42:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Who is looking at CVEs to prevent them?
To: Hillf Danton <hdanton@sina.com>, Dan Carpenter <error27@gmail.com>
Cc: Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@kernel.org
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
 <20230307110029.1947-1-hdanton@sina.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230307110029.1947-1-hdanton@sina.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Mar 2023 12:57:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10947

On 3/7/23 12:00, Hillf Danton wrote:
> On 7 Mar 2023 12:51:14 +0300 Dan Carpenter <error27@gmail.com>
>> On Thu, Jan 19, 2023 at 09:14:53AM +0900, Masami Ichikawa wrote:
>> > CVE-2023-0210: ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
>> > ksmbd_decode_ntlmssp_auth_blob
>> > 
>> > 5.15, 6.0, and 6.1 were fixed.
>> > 
>> > Fixed status
>> > mainline: [797805d81baa814f76cf7bdab35f86408a79d707]
>> > stable/5.15: [e32f867b37da7902685c9a106bef819506aa1a92]
>> > stable/6.0: [1e7ed525c60d8d51daf2700777071cd0dfb6f807]
>> > stable/6.1: [5e7d97dbae25ab4cb0ac1b1b98aebc4915689a86]
>> 
>> Sorry, I have kind of hijacked the cip-dev email list...  I use these
>> lists to figure out where we are failing.
>> 
>> I created a static checker warning for this bug.  I also wrote a blog
>> stepping through the process:
>> https://staticthinking.wordpress.com/2023/03/07/triaging-security-bugs/
>> 
>> If anyone wants to review the warnings, just email me and I can send
>> them to you.  I Cc'd LWN because I was going to post the warnings but I
>> chickened out because that didn't feel like responsible disclosure. The
> 
> Given the syzbot reports only in the past three years for instance, the
> chickenout sounds a bit over reaction.
> 
>> instructions for how to find these yourself are kind of right there in
>> the blog so it's not too hard to generate these results yourself...  I
>> don't really have enough time to review static checker warnings anymore
>> but I don't know who wants to do that job now.
> 
> If no more than three warnings you will post a week after filtering, feel
> free to add me to your Cc list, better with the leading [triage smatch
> warning] on the subject line the same way as the syzbot report.
> 
> Thanks
> Hillf

Why do you keep adding linux-mm to the Cc list of random threads that are
not about MM?


