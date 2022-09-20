X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web08.8688.1663654966783915502
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Sep 2022 23:22:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=IzCyRSBW;
 spf=pass (domain: gmail.com, ip: 209.85.214.182, mailfrom: imv4bel@gmail.com)
Received: by mail-pl1-f182.google.com with SMTP id jm5so412330plb.13
        for <cip-dev@lists.cip-project.org>; Mon, 19 Sep 2022 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NTji0+RBPiysZFHQBiYPWwLSVVlat0nxjjCKSq+cwbM=;
        b=IzCyRSBWX8YWf5Br/YwXc5rqkhD02O/1wdyWt2QvjSirUIgE9OL8KOrS571pwXVyWI
         jryYjbm3SHhgDmi96Z7u9TBpMpyViys5rBypNa7FnpwIjTwJ6NMz6AsmvXAteCuODwC0
         jmghsGOaczTH6ERjZF7nlv9M1M3bsiZxm6oUbAgyvxrk3LbpSs34kR+489mYsnmTAHg/
         ghGsg23SrecnoxEngcUGr4BnqFPkj6voCNKyN6uwWsw4gpnllWPGs0oZ7pTuuUlhFyuy
         ybowHEUmQKI8Yj04J/V/VDyUTTyJebuy/wL3fXhTgxxgYIOJ39BzbcgPTa/kIxru0gs7
         qOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NTji0+RBPiysZFHQBiYPWwLSVVlat0nxjjCKSq+cwbM=;
        b=XCdthjCxnDhz90AyLG+2b92kqswrT+o0gNNI1IHGm5bNOv7N5DVsAC4VcdRFvDc+lO
         SIRAsYsg7ondLLUKR2FNcQ3waOgMbENvXxJRkdfXZ9juuDtjkwwtgzPAja0ertInt2eA
         YP1n4CxhshINn1+T/V/LfKX8Unxg5tRteOP3hub7Eka8NQGkAamBzMRR/zp52tMdoU8j
         pjJqakMbjMSSRzR8bT8S6oZjC27/e/t8gyN+mmgygdA9QPM9uS99MMPWrJiOY2+dXa5b
         MMODz7bofFKiF2DUOuVGF5azONkouI/q+NesMnMqHRxUwDHU0TgoGx99/iMh5Oe8UJrl
         PFHQ==
X-Gm-Message-State: ACrzQf2lxqmtq8vrA4yEDkYsoICA2bsmQQnYuG5A06+klech+2H97xXF
	eWyznYaLTWfDTptlKfaaxp4=
X-Google-Smtp-Source: AMsMyM6pAFi14MIftTxpTT6kP/Mg8xeHEGdJ9k4i6zFuXXjUv/mmIhMQK/yQevcbjMJ2qjiEo6vt7w==
X-Received: by 2002:a17:902:c40e:b0:178:4931:cc4d with SMTP id k14-20020a170902c40e00b001784931cc4dmr3326380plk.97.1663654965979;
        Mon, 19 Sep 2022 23:22:45 -0700 (PDT)
Return-Path: <imv4bel@gmail.com>
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id w16-20020a170902e89000b001725d542190sm509896plg.181.2022.09.19.23.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 23:22:45 -0700 (PDT)
Date: Mon, 19 Sep 2022 23:22:41 -0700
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: deller@gmx.de, linux-fbdev@vger.kernel.org,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH] pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Message-ID: <20220920062241.GA321122@ubuntu>
References: <YylXes0RnFv97uKU@kili>
 <YylaC1wHHyLw22D3@kadam>
MIME-Version: 1.0
In-Reply-To: <YylaC1wHHyLw22D3@kadam>
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>

On Tue, Sep 20, 2022 at 09:13:31AM +0300, Dan Carpenter wrote:
> On Tue, Sep 20, 2022 at 09:02:34AM +0300, Dan Carpenter wrote:
> > On Mon, Jun 20, 2022 at 07:00:10AM -0700, Hyunwoo Kim wrote:
> > > In pxa3xx_gcu_write, a count parameter of
> > > type size_t is passed to words of type int.
> > > Then, copy_from_user may cause a heap overflow because
> > > it is used as the third argument of copy_from_user.
> > > 
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > ---
> > >  drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
> > > index 043cc8f9ef1c..c3cd1e1cc01b 100644
> > > --- a/drivers/video/fbdev/pxa3xx-gcu.c
> > > +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> > > @@ -381,7 +381,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
> > >  	struct pxa3xx_gcu_batch	*buffer;
> > >  	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
> > > 
> > > -	int words = count / 4;
> > > +	size_t words = count / 4;
> > 
> > The count variable is actually capped at MAX_RW_COUNT in vfs_write()
> > so "words" cannot be negative.  This patch helps clean up the code but
> > it does not affect run time.
> 
> Btw, the other thing which prevents this from being expliotable is that
> if you pass a negative value to copy_from_user() it will not copy
> anything because of the check in check_copy_size().  See commit
> 6d13de1489b6 ("uaccess: disallow > INT_MAX copy sizes").
> 
> Linus has sort of gotten annoyed with me before for pointing this stuff
> out because it seemed like maybe I wasn't properly grateful to people
> auditing the code and fixing bugs.  I am grateful.  This patch is
> totally the correct thing to do.  It's just that it's not really
> exploitable as described in the commit message.

I found the code that might have the vulnerability, and submitted a patch without actually debugging it.
This is entirely my fault. sorry.

Should I submit a fix patch that fixes the commit message?

Sorry again.


Regards,
Hyunwoo Kim.

