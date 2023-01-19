Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86AEC004D4
	for <webhook@archiver.kernel.org>; Thu, 19 Jan 2023 15:24:41 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
 by mx.groups.io with SMTP id smtpd.web10.47947.1674141857317168435
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Jan 2023 07:24:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=QbFJRKct;
 spf=pass (domain: gmail.com, ip: 209.85.128.41, mailfrom: error27@gmail.com)
Received: by mail-wm1-f41.google.com with SMTP id l8so1810480wms.3
        for <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 07:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+pkWEPRj2g8m9NnkcSpzrq1lx6deyY5rf5Yen5EQ66A=;
        b=QbFJRKctWrzAs654sBa1ZsUVHP+s+ftZG5EBvVMUwunpFH0GkcwD2ti5PVtj88Y4lx
         JKJOEOyz37O5y8mROHD9YXM8BjPheF3jJU/1oh4I7GVJdaB7uVuBh8aBgcP5/pDm6Lf3
         wPdtfPUBBhXJpex+pcqocY1h9/dfcHhWeu5Yb/U5YVpILtvMjDnf/pSi7nKJiLD8mzsS
         FwRQuHBl2c3qoFIhPl4TxcwpBZLvB+LD1fs3xHj24vRGB7Bk5yJn8lhlQNtjcZDFEHnU
         u/6QqoYbwPcJA8l7vpPHdy6w+cc9u1LzelQGgf0IcAMHwcCB8xawAlsMQJSCOHQ96dG9
         WMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pkWEPRj2g8m9NnkcSpzrq1lx6deyY5rf5Yen5EQ66A=;
        b=VkSlZUa3NRgVQcbxoPfcPiM6BwHfdLcsfEHsA5rwPMtbX/vXr+DpTCHY2xq4Zngfcw
         CMLq3zoz3slPZ/Y9oLIn7oOuL1g3mxf7CfJlwsTqp90/VwJr5SLray338jWlbciT7C7t
         anaNwdwGYmgP8Lx1N3sQlrJ0gPOnHzi4PgWBooVvvXg2+TJTiTgLYOMoaOnFjQzxk+gG
         bK90CyxP3glKBaA1T93dhjpd42oQAVF+AsyiLxzTcx2KRl6ievCqNNuRcc7hCRl6gw9S
         A0lW9XUguJksiRmlG30kZVMN8Xjv2/4H9+CNf2MS2ylj2E6rHuwPkwQGPuGbzHomjxxL
         JVrQ==
X-Gm-Message-State: AFqh2krZ//3rsSQMQOTwA5vjuPkZXnfxCsH8ya3bagfCwTBEV3Bc8pfa
	/a3tcZRd6iXWz2a3qkoSRlM=
X-Google-Smtp-Source: AMrXdXsa+hx9kpg/KLAraKX3RQy9up79bqP8l9kUg2gIoKqvEL1yWAeeX84qDXw9ZgmGv7g0YUfjEA==
X-Received: by 2002:a05:600c:4c21:b0:3cf:900c:de6b with SMTP id d33-20020a05600c4c2100b003cf900cde6bmr10372516wmp.15.1674141855726;
        Thu, 19 Jan 2023 07:24:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c165600b003da119d7251sm4789521wmn.21.2023.01.19.07.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:24:15 -0800 (PST)
Date: Thu, 19 Jan 2023 18:24:11 +0300
From: Dan Carpenter <error27@gmail.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: New CVE entries this week
Message-ID: <Y8lgm1a0n9kQc39o@kadam>
References: <CAODzB9oy2nCYdfa7vzG59nQ6owAKUv+jkqD4tpufn+k8_kjuaw@mail.gmail.com>
 <Y8j2dnYDZnw+DcEw@kili>
 <CAODzB9rHqzUTn1dmaP1j1SsiYh5UcJ5AKSjVL7PpxYE5ifRVCA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9rHqzUTn1dmaP1j1SsiYh5UcJ5AKSjVL7PpxYE5ifRVCA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 19 Jan 2023 15:24:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10449

So I went through the list again and those two were the only real bugs I
spotted.

The point is not really about this specific list of warnings, it's just
the process of thinking asking how we improve going forward.  This was
only one of the action items.  Another was why was Smatch not warning
about missing checks for kmalloc() failure?  I have fixed this, but
I forget what the fix was.  Also apparently I didn't publish the fix and
the released code still does not warn.

Another question was the Smatch check for this is very old and it
assumes that everything with a gfp_t flag is an allocation.  Which is
fine.  But alloc_workqueue() doesn't take a gfp_t flag and it also needs
to be checked for NULL so stuff like that needs to be added as well.

regards,
dan carpenter

