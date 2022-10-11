X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
 by mx.groups.io with SMTP id smtpd.web12.12988.1665522557206964564
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 14:09:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Ns/i9oYf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.222.176, mailfrom: konstantin@linuxfoundation.org)
Received: by mail-qk1-f176.google.com with SMTP id 8so1883684qka.1
        for <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 14:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WShmLYUoXzlt00T+/O2GjwTxK1K56Mbk5TPyL+kzKNk=;
        b=Ns/i9oYfFf46UDxVMxedwY1Ju9VIaVymhg4UtX+IHS6ocgljCGvGRz8gxylZI+BWhR
         tfRARLizq8IWvKhk2zvqvQxQlaSElRItzJPqsDHb9//mFDkRxZ2KTRpsmHOYAPe2j/Dy
         vGtE4kjCasJ7RDLKMM4vQcp2IwZ/PNEVpYGU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WShmLYUoXzlt00T+/O2GjwTxK1K56Mbk5TPyL+kzKNk=;
        b=h1BEIEEo/5SvMm5icuvg2hpGExMC9T5bjxubES2rOTzX+gCeCxzLX6qJuyzsnfYjK0
         iAtnVyrxfVpd74oQNEIkZDbquc4X/Xm7h5ceqtZw5mXT66SDHY8uRFH4g7dvXGImwAXp
         i0UYdVBfsKa2XqRaKQVRbWmTwHEICi7jbe1Znyx/FT/Aj6s5Nm7+/ka3WqVVHVfwtKrd
         J3iqTXGsfVm99pu7AOZI7lm+2cxVYC4gP35Vk2XScFnn1nH/9oLnFydQ8tBY97Mkz7Nd
         trw2h81cV7N9wngxNfnzlXQlcdTEK9o1KqgqPlpPtM8TnI/Bj29Yxn8qCm7NyZBP/Th0
         l1Cw==
X-Gm-Message-State: ACrzQf1GStZjmacUqH8u0IGZZpc/cYAHq/G2/EB0yxxWOthyIwL3TXa1
	OSBsouFiWmvkVtEikAtA/yxQJgeBBxSxow==
X-Google-Smtp-Source: AMsMyM5GAVqcV6tFk6pJdoOB+g9yh6RVeXf0tikUhqGVy7rbFEE3YHfxq9FsM5xcFwWVEP8CPLvbWg==
X-Received: by 2002:a37:bc3:0:b0:6ee:7931:9e5a with SMTP id 186-20020a370bc3000000b006ee79319e5amr4322946qkl.105.1665522555897;
        Tue, 11 Oct 2022 14:09:15 -0700 (PDT)
Return-Path: <konstantin@linuxfoundation.org>
Received: from meerkat.local ([142.113.79.147])
        by smtp.gmail.com with ESMTPSA id dm26-20020a05620a1d5a00b006ed99931456sm5504196qkb.88.2022.10.11.14.09.15
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:09:15 -0700 (PDT)
Date: Tue, 11 Oct 2022 17:09:11 -0400
From: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
To: cip-dev@lists.cip-project.org
Subject: Troubleshooting missing lore messages
Message-ID: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>

Hi, all:

I am aware of the problem with occasional missing message on the
lore.kernel.org archive. Due to the way groups.io operates, the messages are
actually delivered via the web hook (otherwise groups.io mangles DKIM and,
occasionally, patch content).

In order to troubleshoot the problem, I've added a lot of debugging calls and
side-dumping of incoming messages, and I'm basically going to use this thread
to spam the list with some messages that let me make sure that everything is
working as intended. Once that is done, I'll wait for the actual 500-error
message to arrive, so I can narrow down what is actually happening.

I apologize for the noise.

-K

