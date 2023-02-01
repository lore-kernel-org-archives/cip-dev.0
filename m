Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC4C636CD
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 13:04:42 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
 by mx.groups.io with SMTP id smtpd.web11.18405.1675238981875715935
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 00:09:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=qSVe+BTb;
 spf=pass (domain: gmail.com, ip: 209.85.128.43, mailfrom: error27@gmail.com)
Received: by mail-wm1-f43.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso707521wmq.5
        for <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 00:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WqeQDDmSHxpAcyRA5iwxefwZV2xtgcG1SAs71mzU/Bc=;
        b=qSVe+BTbIygGRjyt8w6uvaolrWDTcoTK4mCyWgNMbA/1MHGwfLAK6OPsYghowLBbfm
         5cqEjDxdUAXZbLhxXfp4L6AvXPBBCGtKdai9OtSr2MeqWBUTpUIwFFjrR0DItgbjRJBR
         HqaPNu/hzqzXRuFH98LcqNiR9dYYLn+pRkF9WCaQZm4GG+z5U81NkfCXX5+K1tjmJdQe
         dpfvhicAHt126G4dejhr4zvZNrx25LsZeatzZ7tRtR5jQuyM+eYnmj2C1bWagonLd4RP
         MLEgxWxyryVWaB5VdU0oR7wFBeEQpON1H87yczdvpvpU0dRseKTmMtz/yUfD7uj8Yg8L
         RAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WqeQDDmSHxpAcyRA5iwxefwZV2xtgcG1SAs71mzU/Bc=;
        b=MZ6hyqN4IhBbPWJ1/16rrfDsIP6vRISl+G8ikNRqARjiCyjJJEvNTkyz8FikdiiBXQ
         Hrv6dflSUG9u89O8X6v5Io7Ozofno4Q+0lofCC59wyVaBqa3O4ZWEvcXmFrjfHiQSlkC
         uotosvi2lnIXY0sIn7848/zGbJ0x/K+oOI/XbbIJlaPolZbOSgri9hka9d3YUlAV0C2j
         8M/hySmx0YmbLbZS7iarjzbCPvVx8ZwAnBTSnL2GAowkEAly3S+gBqz//Cg3PTyxfMzy
         O5CbHOzIbwsytmQJx7ch7LQcbT7G8vFHr5PFovIX6SNVWkLrru36mzdedklVYt8ITM0i
         kysg==
X-Gm-Message-State: AO0yUKXyQAyVPXCSyt/S6e3Et08ckzhaJUO3YqvEk8w073FO5QyDfE9N
	aHx2uTYgjhduHvYG5VH8ux0=
X-Google-Smtp-Source: AK7set+UNOVq0m8bJIRyxxUGd2XOtwzFV9StW0MqPmvP/wAaggqw00B9XYKz1d6sGgSlrWVB5kA2Kg==
X-Received: by 2002:a05:600c:46c9:b0:3db:1d8:9f25 with SMTP id q9-20020a05600c46c900b003db01d89f25mr1072303wmo.2.1675238980240;
        Wed, 01 Feb 2023 00:09:40 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id z12-20020adff74c000000b00291f1a5ced6sm16818415wrp.53.2023.02.01.00.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 00:09:39 -0800 (PST)
Date: Wed, 1 Feb 2023 11:09:33 +0300
From: Dan Carpenter <error27@gmail.com>
To: Masami Ichikawa <masami.ichikawa@miraclelinux.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Re: New CVE entries this week
Message-ID: <Y9oePa50jnpgnutu@kili>
References: <CAODzB9phGdgNo0dOTHLyovXP7Gcj9EgR1QDHHaNrAXhBxrHQzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAODzB9phGdgNo0dOTHLyovXP7Gcj9EgR1QDHHaNrAXhBxrHQzg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 13:04:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10555

[ Still going through old stuff from the holiday season ]

On Thu, Dec 22, 2022 at 07:58:48AM +0900, Masami Ichikawa wrote:
> CVE-2022-47518: wifi: wilc1000: validate number of channels
> 
> CVSS v3 score is not provided
> 
> An issue was discovered in the Linux kernel before 6.0.11. Missing
> validation of the number of channels in
> drivers/net/wireless/microchip/wilc1000/cfg80211.c in the WILC1000
> wireless driver can trigger a heap-based buffer overflow when copying
> the list of operating channels from Wi-Fi management frames.
> 
> It looks like a vulnerable function is not present on 4.4 and 4.9.
> That function is present in 5.4 and 4.19 however, this driver is
> staging driver at that time.
> Also, implementation of wilc_wfi_cfg_parse_ch_attr() in 5.4 and 4.19
> are different from newer code. It seems as if they are not affected.
> 
> Fixed status
> mainline: [0cdfa9e6f0915e3d243e2393bfa8a22e12d553b0]
> stable/5.10: [3eb6b89a4e9f9e44c3170d70d8d16c3c8dc8c800]
> stable/5.15: [7aed1dd5d221dabe3fe258f13ecf5fc7df393cbb]
> stable/6.0: [6195b4838e10a557859862c4e7840dc0eafdd1cd]
> 
> CVE-2022-47519: wifi: wilc1000: validate length of
> IEEE80211_P2P_ATTR_OPER_CHANNEL attribute

This is probably something which could have been caught with static
analysis.  The first problem was that cfg80211_find_vendor_ie() takes
a struct and casts it to a char *.  Smatch correctly marks some of the
struct members as user data, but loses that information when the cast
happens.

It is easy to hard code cfg80211_find_vendor_ie() as returning user data
so we avoid this bug in the future.

diff --git a/smatch_points_to_user_data.c b/smatch_points_to_user_data.c
index 4267b85b53a7..f632d8c84452 100644
--- a/smatch_points_to_user_data.c
+++ b/smatch_points_to_user_data.c
@@ -49,7 +49,7 @@ STATE(user_data_set);
 static const char *returns_pointer_to_user_data[] = {
 	"nlmsg_data", "nla_data", "memdup_user", "kmap_atomic", "skb_network_header",
 	"cfg80211_find_elem_match", "ieee80211_bss_get_elem", "cfg80211_find_elem",
-	"ieee80211_bss_get_ie",
+	"ieee80211_bss_get_ie", "cfg80211_find_vendor_ie",
 };
 
 bool is_skb_data(struct expression *expr)

Then from there, I actually have an unpublished static checker warning
which would have triggered.

drivers/net/wireless/microchip/wilc1000/cfg80211.c:991 wilc_wfi_cfg_parse_ch_attr() warn: uncapped user loop: 'attr_size'

Currently it prints 178 warnings.  It warns for things like:

        for (i = 0; i < user_controlled_value; i++)

But it's kind of useless.  There are too many times where the loop is
uncapped but it doesn't result in an out of bounds access.  For example,
the user_controlled_value could be number of seconds instead of array
offsets.  I need to add to the check and cut down on the false
positives.  I will do that today.

Update on my employment situation:  I have been lazy about looking for
Smatch funding.  But a lot of the things I'm looking at are a
subscription model where people get the warnings instead of the source
code.  These emails are intended to help the Kernel security community
to understand better how to continue the work after I have moved on.
Please email me if you have questions, because right now I have time and
I want to help people take on this work.

regards,
dan carpenter

