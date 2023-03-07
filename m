Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA94C678D5
	for <webhook@archiver.kernel.org>; Tue,  7 Mar 2023 12:56:54 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
 by mx.groups.io with SMTP id smtpd.web11.10962.1678183052512975258
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Mar 2023 01:57:32 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=k/vFYgRI;
 spf=pass (domain: gmail.com, ip: 209.85.208.44, mailfrom: error27@gmail.com)
Received: by mail-ed1-f44.google.com with SMTP id u9so50048794edd.2
        for <cip-dev@lists.cip-project.org>; Tue, 07 Mar 2023 01:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678183050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TFfKfYm0N3LqI8J25elWBtfff5jc/IewGs/5ZXYbR2Y=;
        b=k/vFYgRI98XywIxfj6etk9eZK/GVCsBdkpfc2n830ZoUNYN70vLMXrdPpyp6Xixy2f
         PnXogX/1ic6pQAzaJziIPKpGGC1V0OavKzBzXhOnW1askbYrC2BZOHPGS7pR728a/5ME
         VTUZtASbT9xpvwVOMvHejY+iAaV0sT9NHAhpDDqLesymV4Bb8NpYexKvzKdEJGkGIF90
         2sdLCgKptczVcCk7Jy5vP0quDNXcmlJuNK7Xq2/VGH0ZYyHv/qbq5JM8uq5th831itak
         yhtmCHkqMuEe/elS4BnDDeO6TcBsPhdbuGIeUAXC035FDWCJ3yGPIZaH70fwBhFZtp8N
         NZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678183050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFfKfYm0N3LqI8J25elWBtfff5jc/IewGs/5ZXYbR2Y=;
        b=K2WZkS0OW8ARvcXoJIEqObNJ5XJt8xX7GvkYfXCgG6vpSYjUX/nu3Nyq5Aw9xUG7AP
         Zf1tvta9orlN+6PV0I7IS11OjdHG+drQ7KXlXgEWPJsLlGLw+qDiSqsmon5FZ91QJVtI
         3ryzatOl9jtBX9aJ4OM091HCY6MpGtHn7ubZtA2FbiOgdHoo2EtfsJjw6An6qrlPeREc
         luPu54m5Esl2TeDnibuWN/NEGQa90r2JOFdC2hbpEVfh3Hbjroy65TvmnHGs9RPS3McO
         1fM7QeAHX2tbuSPtkm0bBRZacpVYGeYulkGAjYLytUIotGO8q+Sur1MxBNt54XKwcj0s
         HWtg==
X-Gm-Message-State: AO0yUKWVj4CylyeYSCpXHoEDGA/b6bZxNbQI1cPFx2RyfepmeiJ3YSsB
	x/cupnJcUBnaaFABIeKADa4=
X-Google-Smtp-Source: AK7set+RY1Ebp/m623hHdxsxRhKyzketswA64mEzoss9/AfYZunkCdB5cDSdwxc8t78rEGjMAWFzhg==
X-Received: by 2002:a05:6402:105a:b0:4ea:a9b0:a518 with SMTP id e26-20020a056402105a00b004eaa9b0a518mr3351386edu.17.1678183050330;
        Tue, 07 Mar 2023 01:57:30 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id fx14-20020a1709069e8e00b008e56a0d546csm5787189ejc.123.2023.03.07.01.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 01:57:29 -0800 (PST)
Date: Tue, 7 Mar 2023 12:51:14 +0300
From: Dan Carpenter <error27@gmail.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
	linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@kernel.org
Subject: Who is looking at CVEs to prevent them?
Message-ID: <59f7f076-a9d5-4bfb-a6da-bbe0a7567688@kili.mountain>
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Mar 2023 12:56:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10945

On Thu, Jan 19, 2023 at 09:14:53AM +0900, Masami Ichikawa wrote:
> CVE-2023-0210: ksmbd: check nt_len to be at least CIFS_ENCPWD_SIZE in
> ksmbd_decode_ntlmssp_auth_blob
> 
> 5.15, 6.0, and 6.1 were fixed.
> 
> Fixed status
> mainline: [797805d81baa814f76cf7bdab35f86408a79d707]
> stable/5.15: [e32f867b37da7902685c9a106bef819506aa1a92]
> stable/6.0: [1e7ed525c60d8d51daf2700777071cd0dfb6f807]
> stable/6.1: [5e7d97dbae25ab4cb0ac1b1b98aebc4915689a86]

Sorry, I have kind of hijacked the cip-dev email list...  I use these
lists to figure out where we are failing.

I created a static checker warning for this bug.  I also wrote a blog
stepping through the process:
https://staticthinking.wordpress.com/2023/03/07/triaging-security-bugs/

If anyone wants to review the warnings, just email me and I can send
them to you.  I Cc'd LWN because I was going to post the warnings but I
chickened out because that didn't feel like responsible disclosure. The
instructions for how to find these yourself are kind of right there in
the blog so it's not too hard to generate these results yourself...  I
don't really have enough time to review static checker warnings anymore
but I don't know who wants to do that job now.

regards,
dan carpenter


