Return-Path: <konstantin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B546EC433FE
	for <webhook@archiver.kernel.org>; Wed, 12 Oct 2022 17:52:50 +0000 (UTC)
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
 by mx.groups.io with SMTP id smtpd.web12.312.1665597163877060354
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Oct 2022 10:52:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=O4jKw2Dd;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.222.173, mailfrom: konstantin@linuxfoundation.org)
Received: by mail-qk1-f173.google.com with SMTP id f8so3539737qkg.3
        for <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 10:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1H14ZOTx9sMcYCBTEdWZxv+OHGm4Qk+oQtEt5BuL0eU=;
        b=O4jKw2DdAhjIMH9XPRrznHT7sKyN0TtM0Nvw7YDb3JQfLP80C8FWaX38EmqloOi7dY
         TlYtIhUWaG14XF7oiOyLbZXV18KbKqPn6VBTpLtNAF8EYpt/1eSHLJUTxL7IrGiuwJyj
         r/PvzKLUYiynuiEkpH5kAm3AENsq3+vmrQmGI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1H14ZOTx9sMcYCBTEdWZxv+OHGm4Qk+oQtEt5BuL0eU=;
        b=XcVu+uYd4JdLRa4trctExPzzNMUPZ3mXG0dYsL9EV0L8miyFBeZv6OYO2LmBUBBwD9
         ZL8e1r3NtUNVtasQVD5aIwK/GbYL0H3qGLf7PlawDbKWWH8xS0CJEPY/lq3mJZRrfrbT
         xvz09lheowr0BoXVR68TZYjM1gE/qwCklRudDBifiXu5nI9Sa3QoM1VtbIA5OCUwgcxb
         RRe5hfcKviEZq1JMABzmcJUuRZ7/n0RiSCVOUhnlip1q/spuVjsw1rCLce882S48ZgJg
         44OPbpAVzA7fUSjA4BhyYW23l7Yqx2fU0Xf2mzsaOwco2JPQxInyJUtdPpVlKR0wnepj
         3lxQ==
X-Gm-Message-State: ACrzQf27AGvLXWg0/vI5EiMO/tmykfYwhYbtu7G5d2jOZ0CGcJPFpF19
	AjSZxe/f0508r731KWPQHndy9xRNppBvLw==
X-Google-Smtp-Source: AMsMyM4KCqTGdLJum64ZexdCCnqLeeHvPZY2KhblZpF+XdKm7E4lUgImJ9iXXy4HRcI2U9/FoY3BAg==
X-Received: by 2002:a05:620a:d8a:b0:6bc:b32:177c with SMTP id q10-20020a05620a0d8a00b006bc0b32177cmr21324448qkl.396.1665597162650;
        Wed, 12 Oct 2022 10:52:42 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id bs10-20020ac86f0a000000b0038d9555b580sm9952189qtb.44.2022.10.12.10.52.42
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 10:52:42 -0700 (PDT)
Date: Wed, 12 Oct 2022 13:52:40 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: cip-dev@lists.cip-project.org
Subject: Re: Troubleshooting missing lore messages
Message-ID: <20221012175240.c4bek2kewebfykae@meerkat.local>
References: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Oct 2022 17:52:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9746

On Tue, Oct 11, 2022 at 05:09:11PM -0400, Konstantin Ryabitsev wrote:
> Hi, all:
> 
> I am aware of the problem with occasional missing message on the
> lore.kernel.org archive. Due to the way groups.io operates, the messages are
> actually delivered via the web hook (otherwise groups.io mangles DKIM and,
> occasionally, patch content).
> 
> In order to troubleshoot the problem, I've added a lot of debugging calls and
> side-dumping of incoming messages, and I'm basically going to use this thread
> to spam the list with some messages that let me make sure that everything is
> working as intended. Once that is done, I'll wait for the actual 500-error
> message to arrive, so I can narrow down what is actually happening.

Okay, we've identified a few issues already (like groups.io not redelivering
messages on a 500-error), and I've re-fed all missing messages from the
archive so there should no longer be any gaps on lore.kernel.org. This will be
my last test message, but it's possible that we're still missing some fixes.

If you notice future missing messages from the lore.kernel.org archive, please
alert us via helpdesk@kernel.org.

-K

