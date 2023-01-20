Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9761CC27C7C
	for <webhook@archiver.kernel.org>; Fri, 20 Jan 2023 14:14:28 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web10.67759.1674192131150558289
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 21:22:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=YBIwhB60;
 spf=pass (domain: gmail.com, ip: 209.85.128.50, mailfrom: error27@gmail.com)
Received: by mail-wm1-f50.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so2839467wms.2
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 21:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPUNBOEvi+EfT+XJWJvekQT2sNWEjQ5PxX/U+WoCuzc=;
        b=YBIwhB603yUqIdel1BN1aQ2kRRXRXqB2ePnBo3AkabEKkIGyDyo6TflF9PCi7R+hXF
         uM7KoCMnU6bNghykefMWau8xbi8kmQEoq0eKHop8Onk0DBVr0FMBryV2/DhXMkUxVxyW
         +25pM8oejnfFKv2WQMqpFfhuNf+U+R7cRkBTKzRS9Ng0t/RojLDy6qWw6EkKgyf4PkPT
         B2XYSyWpzPB9g9N21dEcnHRVUJwkRPSEsgEo5PUsnNMF1+YfJkhVuxfLSEFilB4J2Mtk
         EohULOeh+ymbakO1zDxwI+oXnMV/seI/uIkLI/7sPHX5TxRBoO190pVfz9VszRXppNYv
         aKXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPUNBOEvi+EfT+XJWJvekQT2sNWEjQ5PxX/U+WoCuzc=;
        b=fDfsftlrBiIoRxBi5iaIAxewPc9xDawjoVGiKREYNqjwmBJor157qrdWsRWyIXUmzI
         c1qdrNMndQVIhXlDH8Q7dMRXKGb7qIvoTXJw14nSJzIB8SJyqOsFChoqgz26zIPKhtuw
         Hn0BghLHy+6NJlINAKFGQa2DuZBVvVSwZozZWlcw223RIsVB5+ZrvjZV9RxMsXfKzsMf
         7Av7O5tCQ1h9/b1UOEy4Jno1tAb1J1kWMzdwaTBjMavbhSPjDb4YZkJAeeK9m5ckz0Qa
         BYcO6QC+oBhLizafxadPZi+nlQ++F0+abEc/64BxSq1f62Bdd47F+4RRFEcRj742pH8O
         F45w==
X-Gm-Message-State: AFqh2kqDFBKhY1P5zjKWZAisr/3KtTEFFbs+aP8Xlt5z8gZZk13q9+Mz
	GKqEkT60gwYrXYEAxRfioZY=
X-Google-Smtp-Source: AMrXdXvzl4+RN1WjgYUz4tRPCvty5ZKlP8ibxlgMTYBueXvwytqo0rr34srYHacHIL0AlSzaowxE1A==
X-Received: by 2002:a05:600c:3b1b:b0:3da:11d7:dba3 with SMTP id m27-20020a05600c3b1b00b003da11d7dba3mr12497450wms.5.1674192129466;
        Thu, 19 Jan 2023 21:22:09 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id k16-20020a05600c0b5000b003db0a08694bsm1118757wmr.8.2023.01.19.21.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 21:22:09 -0800 (PST)
Date: Fri, 20 Jan 2023 08:22:06 +0300
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
Message-ID: <Y8ok/oCxzOhFDEQ+@kadam>
References: <Y8ldQn1v4r5i5WLX@kadam>
 <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
In-Reply-To: <x49y1py5wcd.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 20 Jan 2023 14:14:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10453

On Thu, Jan 19, 2023 at 11:21:22AM -0500, Jeff Moyer wrote:
> Dan Carpenter <error27@gmail.com> writes:
> 
> > The concern here would be that "family" is negative and we pass a
> > negative value to test_bit() resulting in an out of bounds read
> > and potentially a crash.
> 
> I don't see how this can happen.  Do you have a particular scenario in
> mind?
> 

This is from static analysis.  My main thinking was:

1) The static checker says that this comes from the user.
2) Every upper bounds check should have a lower bounds check.
3) family is passed to array_index_nospec() so we must not trust it.

But looking closer today here is what the checker is concerned about:

	func = cmd_to_func(nfit_mem, cmd, call_pkg, &family);

Assume "nfit_mem" is NULL but "call_pkg" is non NULL (user input from
__nd_ioctl() or ars_get_status().  In that case family is unchecked user
input.

But probably, it's not possible for nfit_mem to be NULL in those caller
functions?

regards,
dan carpenter


