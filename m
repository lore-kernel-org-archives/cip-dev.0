Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E9DC77B62
	for <webhook@archiver.kernel.org>; Tue, 28 Mar 2023 15:00:56 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web11.69112.1680015356730656324
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Mar 2023 07:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=AnEidLE4;
 spf=pass (domain: gmail.com, ip: 209.85.221.51, mailfrom: error27@gmail.com)
Received: by mail-wr1-f51.google.com with SMTP id j24so12574609wrd.0
        for <cip-dev@lists.cip-project.org>; Tue, 28 Mar 2023 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680015355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUCiRdt4G6e+AfKReFCxGYN4w7zp8icsBzsXAHuEF9Y=;
        b=AnEidLE4LsraW87Q5tXYHYA5Ys+pGCCc9NsTQXztWYS7KfP0rtHSBjPdDzCPcul1og
         XELjf9zZ/Ms/zQ0pafho6jHMsg1nH3aMdm7wdpgxuRZ6kbGRw4au/66oE8Lb/fKm0j7J
         +zc7MS3DN/xKThJhGNbLGMcqzNza8rFIp+TBqxXD2bWnvWqrAYAb9BUXE3K805LX2HFJ
         EONzt2P/PjRZ4gQeprxZGQWQUMXRx6PzH7jyU8+2Mm12q0/F5ZeIomd5uAj9PKq6iYwq
         iCDZ8ZqZXdEFRZWeYVX1ZSWCYKcPOKi3oQ9AdLnWXmDXXrUTrFDbEblNK5uU0jMwCIh7
         Zevg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680015355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VUCiRdt4G6e+AfKReFCxGYN4w7zp8icsBzsXAHuEF9Y=;
        b=mE695j6lTRtPx4AhQJirrtfx/aVjGqv47lrzX/iRwQw38VRrtGnfhIVmSJusFtgLmX
         4E9/nlf3qtVU+NavJ8TetTsbkP40gpdBdSoNrBR+ra1gD8WNYq9RzvO3Q+UsLJO9qews
         qr/+2dR9jWXFi/nbfyMZREcEPEQ2zRWtyJ36U6VYG4C3yUi3FshdnB1eBkyd+gt53vuU
         sLUmaY5VEnBJhpwJ0m2xNTLkSu505MIKH5TNGwJTy3R4N7/PdZqnEulxN+p/GBhEn6ur
         O8rFf4divPMl9ESv7RukINXjln6f0mePM/0/Cbytb6sio+n+Io3dzYLFRhp4jfJx1M++
         CFnw==
X-Gm-Message-State: AAQBX9fHZIVC9Aqf/UnKfNHlsm2esAmELMW3GmeT3mUM6ANOhY25QAMn
	tgh0B3aIFJhhCUaKE8rAdes=
X-Google-Smtp-Source: AKy350bMs0DBch9jE/m8/eX8EMBCWAe6OoNpwHgERBBzX5jfQ21HXjQ39PxugNSyKZ6Geg4jFjE/8Q==
X-Received: by 2002:a5d:40cd:0:b0:2ce:da65:1e1d with SMTP id b13-20020a5d40cd000000b002ceda651e1dmr15466308wrq.24.1680015354964;
        Tue, 28 Mar 2023 07:55:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000100600b002c8ed82c56csm27836188wrx.116.2023.03.28.07.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:55:54 -0700 (PDT)
Date: Tue, 28 Mar 2023 17:55:40 +0300
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
Message-ID: <8a425108-3480-4a58-ba4f-727146a0cef7@kili.mountain>
References: <Y8ldQn1v4r5i5WLX@kadam>
 <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
 <Y8ok/oCxzOhFDEQ+@kadam>
MIME-Version: 1.0
In-Reply-To: <Y8ok/oCxzOhFDEQ+@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Mar 2023 15:00:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11122

On Fri, Jan 20, 2023 at 08:22:06AM +0300, Dan Carpenter wrote:
> On Thu, Jan 19, 2023 at 11:21:22AM -0500, Jeff Moyer wrote:
> > Dan Carpenter <error27@gmail.com> writes:
> > 
> > > The concern here would be that "family" is negative and we pass a
> > > negative value to test_bit() resulting in an out of bounds read
> > > and potentially a crash.
> > 
> > I don't see how this can happen.  Do you have a particular scenario in
> > mind?
> > 
> 
> This is from static analysis.  My main thinking was:
> 
> 1) The static checker says that this comes from the user.
> 2) Every upper bounds check should have a lower bounds check.
> 3) family is passed to array_index_nospec() so we must not trust it.
> 
> But looking closer today here is what the checker is concerned about:
> 
> 	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);
> 
> Assume "nfit_mem" is NULL but "call_pkg" is non NULL (user input from
> __nd_ioctl() or ars_get_status().  In that case family is unchecked user
> input.
> 
> But probably, it's not possible for nfit_mem to be NULL in those caller
> functions?

Did we ever figure out if it's possible for nfit_mem to be NULL?

regards,
dan carpenter


