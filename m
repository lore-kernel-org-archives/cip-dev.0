X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
 by mx.groups.io with SMTP id smtpd.web08.13064.1665523945923529698
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Oct 2022 14:32:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WjJ0yrKb;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.160.171, mailfrom: konstantin@linuxfoundation.org)
Received: by mail-qt1-f171.google.com with SMTP id a24so1571215qto.10
        for <cip-dev@lists.cip-project.org>; Tue, 11 Oct 2022 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqLkop0RAYBDppvX+eiM3Wkp20pEZk1YQbaObW8HJ4o=;
        b=WjJ0yrKbQ3XzXGhuPuMPvQaT0fRt42bBO1sOm2KNrAe5oNUs6/tvSeywr5dp+SeY33
         jWvvsAXJrfWqPMEnIAS1SE56qUt6AIzALNoGFaqHw0DJl3Ckl52rw2P4d/z+xpqWI2Vs
         7Ih3+HDL2PRUMQ/CiNt7D62rteE3EgaAR+1wY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UqLkop0RAYBDppvX+eiM3Wkp20pEZk1YQbaObW8HJ4o=;
        b=w5AU0Q27ZPyYx7/97rSUZy8KHgg+we0CwS5fMO4YyKrvirjdeGObPRjq0VNUdUbvzi
         XFoBLzCCGXJEZeI5fBaTOhzlhzWgC2ruZQ8fnZqXB/QimtyfUOt/s5lKvtRkJ3FGgpJB
         SxLItNAc+mqHGe3Z24O+kF+kQCA8pD7Alt0cd+oeaLjyLFsCw78i85rTT5nW7qWfrNLS
         DK4h1u6wC9NCc3ZaSxzDt/GUWfMvgJsb06xGY8UWjwBSWPeBCSvboADHC0KRbFsBNtrK
         jprMfkfCYA4Jc809d+/dJnQuNF5OwkoZvG1bLmTTybU7/Ig0QnQF2GB4YNMf9DJMUK3g
         gIBQ==
X-Gm-Message-State: ACrzQf0uRT7TJzlwM27CoFoc1Q9fwHz70n259GQG8TBLOI4QtFbvvWKo
	0+vECcfOJQl3LCGhUbBIaQGcNlZ1WqrY2A==
X-Google-Smtp-Source: AMsMyM4CQ67iAjAa0ID6WGOMdMuFQ+FLSXiRiIpmJelNxBVFijnjhEydgxc9Lk/RMTxkCGRGITFc5Q==
X-Received: by 2002:a05:622a:551:b0:35d:5237:1781 with SMTP id m17-20020a05622a055100b0035d52371781mr21119055qtx.566.1665523944839;
        Tue, 11 Oct 2022 14:32:24 -0700 (PDT)
Return-Path: <konstantin@linuxfoundation.org>
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id u5-20020a05620a454500b006b640efe6dasm13575849qkp.132.2022.10.11.14.32.23
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 14:32:24 -0700 (PDT)
Date: Tue, 11 Oct 2022 17:32:22 -0400
From: "Konstantin Ryabitsev" <konstantin@linuxfoundation.org>
To: cip-dev@lists.cip-project.org
Subject: Re: Troubleshooting missing lore messages
Message-ID: <20221011213222.bdkip4nhqfz6xkjg@meerkat.local>
References: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
MIME-Version: 1.0
In-Reply-To: <20221011210911.2ufn3yqpg43habc4@meerkat.local>
Content-Disposition: inline
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <cip-dev.lists.cip-project.org>

On Tue, Oct 11, 2022 at 05:09:11PM -0400, Konstantin Ryabitsev wrote:
> I apologize for the noise.

Following up and keeping all the noise in the same thread.

-K

