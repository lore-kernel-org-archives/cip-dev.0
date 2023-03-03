Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A2C678DB
	for <webhook@archiver.kernel.org>; Sun,  5 Mar 2023 22:49:40 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
 by mx.groups.io with SMTP id smtpd.web10.29401.1677863782907593778
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Mar 2023 09:16:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=InEDKuVk;
 spf=pass (domain: gmail.com, ip: 209.85.208.43, mailfrom: error27@gmail.com)
Received: by mail-ed1-f43.google.com with SMTP id f13so13099725edz.6
        for <cip-dev@lists.cip-project.org>; Fri, 03 Mar 2023 09:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677863781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0tI0lSbtCCvzReakyPxs9HaqgVhTnx5h3WqXQ7Jx8u0=;
        b=InEDKuVkBhx1glwkh/+LhwI8Q5ERfF8qq0AR1BsTUzNW6KUuE0509UI0xQVqScTqqK
         z3JzgNe0sPWabBoZMYNmCZ7O5k73VTaDLS8YKS//Pc2F+5iZ36cvTYRUkA+kBHXR0VDa
         aAwhJJ4QrUIH3C8dba3j2tbfSMMe289NuRWGFERcnX7d3zPPLDnBQgpni2UetezBQc6d
         lmfsmWWKXOYYcaIK5rP2DhKs+I1uA770de6ZyhwlEP9cC55IrVzxU7wUPQHE7HKouMgn
         PuXPmbgmBxN9Kf2zUb0IV1I2z4Cj+dayH09r1zOd7dvAOIuoXZa8KYfCyifqxktQ7fDz
         bI2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677863781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0tI0lSbtCCvzReakyPxs9HaqgVhTnx5h3WqXQ7Jx8u0=;
        b=EXQ6f3p6PZVkuqCjIFZWzkcXB7t03ISWN4kv+Zs1TvgnB5adBYNR0MR7wI5NWOD2J7
         00phn52oNtpOR9D4YF+FRl7hKs2Z9uq9cQyGqqFqhsdJ0wrqIJczTiHCL0hL94T06SdM
         t7x+LKsPHXDS7HWRDR1JMeo4NZgxdXFD5tK5WbtdwY7PcetltssvPxnfJY7sJZ5JcwR/
         Q022bCKWvGlojjz8x0RCtMEVIF1IWdmdZSWeJ7BogmyRZO0xF/ZDd0bpqjwfrsbXtI/8
         IsflGa0+2v7Fs+ff6LU09T0l0PuQ/JuPAk2tdlD5v83K5cHAbFx1N4olA8/YtFSV5KFD
         tlUw==
X-Gm-Message-State: AO0yUKUmUHEpbJaYFGLgZg98OS8iNdMigBm9ZMReXor+iTfYFXYWYYm0
	iTP82zyHWa3GYRo76FUhCOQ=
X-Google-Smtp-Source: AK7set9Si0NGXxqcYwtj6ZYX8W5tu7Nbeh8pSwJiFX6uAnb3B95YX+9w8WueaZiJNkLdYutuYO33kw==
X-Received: by 2002:a17:906:a3c3:b0:8f2:5c64:d53b with SMTP id ca3-20020a170906a3c300b008f25c64d53bmr6511051ejb.24.1677863781280;
        Fri, 03 Mar 2023 09:16:21 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090651c900b008b2e4f88ed7sm1147998ejk.111.2023.03.03.09.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 09:16:20 -0800 (PST)
Date: Fri, 3 Mar 2023 20:15:52 +0300
From: Dan Carpenter <error27@gmail.com>
To: Roger Heflin <rogerheflin@gmail.com>
Cc: neilb@suse.de, linux-raid@vger.kernel.org,
	cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: [bug report] md: range check slot number when manually adding a spare.
Message-ID: <ZAIrSD6q1Zy2oF0b@kadam>
References: <e664f254-90a0-42df-8fc8-ad808f6dedeb@kili.mountain>
 <CAAMCDedsGtWcwe4KY9SgdciXoHYeM+YO4U7v-QCRnL5PqQTs9A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAMCDedsGtWcwe4KY9SgdciXoHYeM+YO4U7v-QCRnL5PqQTs9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 05 Mar 2023 22:49:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10931

On Fri, Mar 03, 2023 at 10:09:50AM -0600, Roger Heflin wrote:
> On Fri, Mar 3, 2023 at 8:31 AM Dan Carpenter <error27@gmail.com> wrote:
> >
> > [ Ancient code, but you're still at the same email address...  -dan ]
> >
> > Hello NeilBrown,
> >
> > The patch ba1b41b6b4e3: "md: range check slot number when manually
> > adding a spare." from Jan 14, 2011, leads to the following Smatch
> > static checker warning:
> >
> > drivers/md/md.c:3170 slot_store() warn: no lower bound on 'slot'
> > drivers/md/md.c:3172 slot_store() warn: no lower bound on 'slot'
> > drivers/md/md.c:3190 slot_store() warn: no lower bound on 'slot'
> >
> > drivers/md/md.c
> >     3117 static ssize_t
> >     3118 slot_store(struct md_rdev *rdev, const char *buf, size_t len)
> >     3119 {
> >     3120         int slot;
> >     3121         int err;
> >     3122
> >     3123         if (test_bit(Journal, &rdev->flags))
> >     3124                 return -EBUSY;
> >     3125         if (strncmp(buf, "none", 4)==0)
> >     3126                 slot = -1;
> >     3127         else {
> >     3128                 err = kstrtouint(buf, 10, (unsigned int *)&slot);
> >
> > slot comes from the user.
> >
> >     3129                 if (err < 0)
> >     3130                         return err;
> >     3131         }
> 
> kstrtouint is string to unsigned int, it has this code:
> 
> if (tmp != (unsigned int)tmp)
> return -ERANGE;
> 
> And so will not return a negative number without an error, so 0 is the
> lower limit as enforced by the function.

Some of what you have written is correct, but your main conclusion is
wrong.  The kstrtouint() gives you unsigned ints.  If you take a very
large unsigned int and cast it to an int then you get a negative value
so the underflow issue is real.

Btw, in more modern code we would write:

	err = kstrtoint(buf, 10, &slot);
	if (err)
		return err;

It still has the underflow issue...  I have been wanting to say that and
resisted saying it because it was obvious to everyone.  However I am
only human and can only resist the temptation to point out the obvious
for so long.

regards,
dan carpenter


