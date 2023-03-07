Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EADBC678D5
	for <webhook@archiver.kernel.org>; Tue,  7 Mar 2023 12:57:04 +0000 (UTC)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
 by mx.groups.io with SMTP id smtpd.web11.12391.1678189995299451214
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Mar 2023 03:53:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=VMsLXhpZ;
 spf=pass (domain: gmail.com, ip: 209.85.208.50, mailfrom: error27@gmail.com)
Received: by mail-ed1-f50.google.com with SMTP id i34so51105880eda.7
        for <cip-dev@lists.cip-project.org>; Tue, 07 Mar 2023 03:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678189994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5NkdPSyehjwKYmLvWLkyPWmKGiOtGMMxDEWqdtEMk4c=;
        b=VMsLXhpZayP8av0KcebtmV+lU0hOJuTRojCWn+9pk5nmzH9R9I+3OeUbQXz3aMdCwb
         MlFO6+EHcrLLWtMJ5N1O0iwyUsgEchwt6StnLScRiRSTMRrYbkmLh2m3TP9dqBdQ6Xr2
         Vq8McnoiwXGBHXIAIk6QJRaVGbntENzC0XqX1TKIMHJQHlYX8N2u1W7b/3QyJoOWCpfB
         phT4SC3gCrMAJs//kE/1rY1aA2EADr08SsuLY7U4s81yTACO1fP7xRd/80mehMpfSMhC
         4lmSXf3YjeWJVBk2J/UETyDazViIbCZie6WdLdhYU3blisefvwHBxeT6VTG/3H1v82Nm
         piJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5NkdPSyehjwKYmLvWLkyPWmKGiOtGMMxDEWqdtEMk4c=;
        b=kKaGj82VqhVHxYtkXrnR77zJNlTNkDzu+kBO/+uWF0l7iY//veWvnkNcXYyr07h0/3
         QR6G7bAk2PNrPbVNaNqC8jVh5TQPqGDiZ/tXd9s7jQ9TUCjgP4FMarfh2zAuBG7SgOOd
         W/IF8J3hJoy8B+CcV03+8ZuF8rfBZihsmFzAzBpW1mKUCIl4kNjAJbj9+vauWleC0zUI
         3YOgdiodvVn0/2//GbWnkz3Z1LeSOQmUM6z2DjYS/9eX/zQBJeuRYhgNZNnSUG7Gj9Nn
         KEoJJDghJVilFJVWU74KBlfBdApOM+2Mth6tdzwkjKKOrX+vs65XSvZ1lE5IdoUfqiPM
         kBCA==
X-Gm-Message-State: AO0yUKU9dXz7PwpnYjT5jH+/jhImhQVInELQoQRkvL/Jet9zY49R9A2B
	K8RcDXBa5uBcs40lv6i2CPI=
X-Google-Smtp-Source: AK7set9QlVQN6PT52JS2bYSSrKReY8tkz33LHDy5O0ZVgpczcuJmrynGdrhAh9fM2uNmqgyvfhPnjQ==
X-Received: by 2002:aa7:c396:0:b0:4bc:f925:5dbe with SMTP id k22-20020aa7c396000000b004bcf9255dbemr12560259edq.42.1678189993725;
        Tue, 07 Mar 2023 03:53:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s30-20020a508d1e000000b004c5d1a15bd5sm2586002eds.69.2023.03.07.03.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 03:53:13 -0800 (PST)
Date: Tue, 7 Mar 2023 14:53:04 +0300
From: Dan Carpenter <error27@gmail.com>
To: Vlastimil Babka <vbabka@suse.cz>, oe-kbuild@lists.linux.dev,
	lkp@intel.com
Cc: Hillf Danton <hdanton@sina.com>,
	Masami Ichikawa <masami.ichikawa@miraclelinux.com>,
	cip-dev <cip-dev@lists.cip-project.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, lwn@lwn.net, smatch@vger.kernel.org
Subject: Re: Who is looking at CVEs to prevent them?
Message-ID: <6d1ad8e9-2bec-4cd4-b4dd-595c88855274@kili.mountain>
References: <CAODzB9qjdhQkZ+tALHpDLHoK7GAf8Uybfzp8mxXt=Dwnn_0RjA@mail.gmail.com>
 <20230307110029.1947-1-hdanton@sina.com>
 <b27c7950-873a-f0e9-d7b4-322bb941a11f@suse.cz>
MIME-Version: 1.0
In-Reply-To: <b27c7950-873a-f0e9-d7b4-322bb941a11f@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Mar 2023 12:57:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10948

On Tue, Mar 07, 2023 at 12:42:03PM +0100, Vlastimil Babka wrote:
> Why do you keep adding linux-mm to the Cc list of random threads that are
> not about MM?

That's kbuild-bot stuff.  The kbuild-bot generates those emails and I
just look them over and hit send.

I don't why the kbuild bot CCs linux-mm either...  Let me ask the devs
about that.  A lot of the -mm warning are correct but just the CC list
is weird.

The kbuild-bot stuff is really nice for me.  The kbuild-bot doesn't use
the cross function DB so everything is local to the function and easy to
review.

regards,
dan carpenter



