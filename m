Return-Path: <SRS0=vnkh=HH=lists.cip-project.org=bounce+64572+6164+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BDEC433E0
	for <cip-dev@archiver.kernel.org>; Fri,  5 Feb 2021 02:32:53 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A100664FBE
	for <cip-dev@archiver.kernel.org>; Fri,  5 Feb 2021 02:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A100664FBE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6164+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id SZBMYY4521723xxbLItQsaVR; Thu, 04 Feb 2021 18:32:52 -0800
X-Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
 by mx.groups.io with SMTP id smtpd.web09.2803.1612492371148848275
 for <cip-dev@lists.cip-project.org>;
 Thu, 04 Feb 2021 18:32:51 -0800
X-Received: by mail-lj1-f172.google.com with SMTP id a17so5973899ljq.2
        for <cip-dev@lists.cip-project.org>; Thu, 04 Feb 2021 18:32:50 -0800 (PST)
X-Gm-Message-State: uGMpfC7qxxGO9dN9YVZuvBrdx4520388AA=
X-Google-Smtp-Source: ABdhPJzO7DHsiQOWFLmoBWopCRTaswuZqAeAQyRrin6dt74xisWkHDJKidl8lVRmNgRQy9p1jL0ONA==
X-Received: by 2002:a2e:9d96:: with SMTP id c22mr1336557ljj.109.1612492369079;
        Thu, 04 Feb 2021 18:32:49 -0800 (PST)
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 134sm819269lfm.205.2021.02.04.18.32.48
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Feb 2021 18:32:48 -0800 (PST)
X-Received: by mail-lj1-f178.google.com with SMTP id s18so5949730ljg.7
        for <cip-dev@lists.cip-project.org>; Thu, 04 Feb 2021 18:32:48 -0800 (PST)
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr1436375ljk.74.1612492368281;
 Thu, 04 Feb 2021 18:32:48 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v664ebkxydSr3f8hHUUFx0t=FyGDpyJjhgwtdNe0OBaL3w@mail.gmail.com>
In-Reply-To: <CAGb2v664ebkxydSr3f8hHUUFx0t=FyGDpyJjhgwtdNe0OBaL3w@mail.gmail.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Fri, 5 Feb 2021 10:32:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v641Q0KowVBJ_srZRdLMXjXi9OaAi43-nGSs9eeOHYqj3A@mail.gmail.com>
Message-ID: <CAGb2v641Q0KowVBJ_srZRdLMXjXi9OaAi43-nGSs9eeOHYqj3A@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-04
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="7VhTIHJKNHnaywZFhGzA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612492372;
 bh=PCYmziua+OjpnoUkqOiaRbjtk75mM348t7fNfvnN9cg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=n9s6pm99jCGxxSlBKyE1smc/8bJjuUIJAIwNlZqrMMtBJORKL7PPtCc9fZH51H/Zi05
 CsBziahaFqDPH+OiCDVs5qTx4z9HommYERetH+PyffQAZsVExJ4mpSzN/gtle5tRYHGeL
 U3+SHsTM+Z7I2V4MuHgZ8o5n+jZNCzoeap8=

--7VhTIHJKNHnaywZFhGzA
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 4, 2021 at 1:26 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi everyone,
>
> Two new issue this week:
> - CVE-2021-3347 [UAF in futex]: fixed for 4.14 and later [1]
> - CVE-2021-3348 [nbd: UAF when adding connections while operations are
> running]: fixed in all kernels
>
> For CVE-2021-3347, based on [1], more patches are needed for 4.4 and 4.9.
> The second batch:
>
> 12bb3f7f1b03d5913b3f9d4236a488aa7774dfe9..34b1a1ce1458f50ef27c54e28eb9b1947012907a
> inclusive
>
> has not been included yet. Lee Jones seems to be handling it [2].

FTR, a second backport series for 4.4 was also posted:

https://lore.kernel.org/stable/20210204172903.2860981-1-lee.jones@linaro.org/


ChenYu

> For CVE-2020-27825 from two weeks ago, the fix has been backported to
> all stable kernels.
>
> For CVE-2020-16120, Ubuntu mentions a regression due to the backported fix [3].
> We probably don't care either way since this requires unprivileged
> user namespace
> is enabled.
>
>
> Regards
> ChenYu
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/pending/futex_issues.txt
> [2] https://lore.kernel.org/stable/20210203134539.2583943-1-lee.jones@linaro.org/
> [2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1900141

--7VhTIHJKNHnaywZFhGzA
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6164): https://lists.cip-project.org/g/cip-dev/message=
/6164
Mute This Topic: https://lists.cip-project.org/mt/80374042/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7VhTIHJKNHnaywZFhGzA--
