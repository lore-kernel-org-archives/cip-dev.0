Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DE7C77B61
	for <webhook@archiver.kernel.org>; Tue, 28 Mar 2023 15:00:56 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web11.69175.1680015479494887722
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Mar 2023 07:57:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=ogWMrlr7;
 spf=pass (domain: gmail.com, ip: 209.85.128.51, mailfrom: error27@gmail.com)
Received: by mail-wm1-f51.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso7703219wmo.0
        for <cip-dev@lists.cip-project.org>; Tue, 28 Mar 2023 07:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680015478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DE5xgbwhRQpkJgfP8sEL5gZw3SNhWz8a/RrIbBfg2gk=;
        b=ogWMrlr7I27p4FwSejAr7Q2c1/kXf0NR8Ec5k4be40g439cNGZ3OUCBDTwj2+EJLBS
         +CVfoC11xm9nD86Y42TyBgqgb+BStWr/kyeLZir9gjK/HlHbgRrEkflNOaz65ZHPxbmi
         BtgH1xfl3hZvUenIpKCRqNlBc8BQ8gLlNyiclLGWqIKb6rooabZlKaaDAncJ6Tgy5Eh4
         0tz2uj+3IDTc6XqK5A0tMkM/SXWUDK687xJtClyW9GENsIrdj63nsd8OtjFVHRRcuOuB
         64pbM0vG8buKzrZ3TeB+Ax78GJoerauv979g8hang2NObPVtppPe4vv+cfBz9CvdK8dT
         ISuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DE5xgbwhRQpkJgfP8sEL5gZw3SNhWz8a/RrIbBfg2gk=;
        b=GvEjkpsgdIPGRoXuFTUX4eKzuuUUdw1dP/1u2MLS0dB/h5qsP5nTJNgzgz3Ix74erm
         7QqVGenM4gd4O9bpsG8Vdb0oEyTEZ5vHJjqwbngm6oYowqR78YrbqBNSa/KKmo93Dpyg
         F4wzH3+Z4FRpoeQ9XHsgtyWlv1wPtDpe3lXv321Xo9fVNPKYBX+jS+stHAitUT6UxZ91
         lkevmUn/FQs1VdqlhATgwXNsSo6q3fnepxd2ncjUwVe/4N9B9dotVwo3q19dIKIIndjG
         klBt3W25ybhuEr0z+EF1ILWG2L8W9Acz6oQxt/hjchf4XZfapbyzYJBGLt5wIZ+bTKnM
         RdaA==
X-Gm-Message-State: AO0yUKVLqVnk5aDiKLOD+P2Xhv+8FGTOL/NqfF8UO09CwmR6dKwlWPRB
	B2VDA9zhl4o43b4yRX4bU+c=
X-Google-Smtp-Source: AK7set/I8CH/86E0q7PQNOZAnX2C+ynZld6z0EVam7znB2FfZDfuDS4nv55P+mN8t5DQ9YTt9sfnew==
X-Received: by 2002:a05:600c:21da:b0:3ed:346d:452f with SMTP id x26-20020a05600c21da00b003ed346d452fmr13068122wmj.26.1680015477838;
        Tue, 28 Mar 2023 07:57:57 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c3b0f00b003ee91eda67bsm12949511wms.12.2023.03.28.07.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:57:57 -0700 (PDT)
Date: Tue, 28 Mar 2023 17:57:54 +0300
From: Dan Carpenter <error27@gmail.com>
To: Jeff Moyer <jmoyer@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, nvdimm@lists.linux.dev,
	linux-acpi@vger.kernel.org, kernel-janitors@vger.kernel.org,
	cip-dev <cip-dev@lists.cip-project.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] ACPI: NFIT: prevent underflow in acpi_nfit_ctl()
Message-ID: <ad63258f-cc13-4f6c-a2a7-aea783f60931@kili.mountain>
References: <Y8ldQn1v4r5i5WLX@kadam>
 <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
 <Y8ok/oCxzOhFDEQ+@kadam>
 <8a425108-3480-4a58-ba4f-727146a0cef7@kili.mountain>
MIME-Version: 1.0
In-Reply-To: <8a425108-3480-4a58-ba4f-727146a0cef7@kili.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Mar 2023 15:00:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11123

On Tue, Mar 28, 2023 at 05:55:40PM +0300, Dan Carpenter wrote:
> On Fri, Jan 20, 2023 at 08:22:06AM +0300, Dan Carpenter wrote:
> > On Thu, Jan 19, 2023 at 11:21:22AM -0500, Jeff Moyer wrote:
> > > Dan Carpenter <error27@gmail.com> writes:
> > > 
> > > > The concern here would be that "family" is negative and we pass a
> > > > negative value to test_bit() resulting in an out of bounds read
> > > > and potentially a crash.
> > > 
> > > I don't see how this can happen.  Do you have a particular scenario in
> > > mind?
> > > 
> > 
> > This is from static analysis.  My main thinking was:
> > 
> > 1) The static checker says that this comes from the user.
> > 2) Every upper bounds check should have a lower bounds check.
> > 3) family is passed to array_index_nospec() so we must not trust it.
> > 
> > But looking closer today here is what the checker is concerned about:
> > 
> > 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
> > 
> > Assume "nfit_mem" is NULL but "call_pkg" is non NULL (user input from
> > __nd_ioctl() or ars_get_status().  In that case family is unchecked user
> > input.
> > 
> > But probably, it's not possible for nfit_mem to be NULL in those caller
> > functions?
> 
> Did we ever figure out if it's possible for nfit_mem to be NULL?

Another idea is I could send this patch as a static checker fix instead
of a security vulnerability.  That way we would be safe going forward
regardless.

regards,
dan carpenter


