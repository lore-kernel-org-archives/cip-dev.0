Return-Path: <SRS0=ld8S=H2=lists.cip-project.org=bounce+64572+6193+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDE9C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 15:07:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98E764EF1
	for <cip-dev@archiver.kernel.org>; Wed, 24 Feb 2021 15:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98E764EF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6193+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id R7bXYY4521723xIb4mKW1mMF; Wed, 24 Feb 2021 07:07:36 -0800
X-Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
 by mx.groups.io with SMTP id smtpd.web10.8086.1614179255278739056
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Feb 2021 07:07:35 -0800
X-Received: by mail-lf1-f46.google.com with SMTP id d3so3482122lfg.10
        for <cip-dev@lists.cip-project.org>; Wed, 24 Feb 2021 07:07:34 -0800 (PST)
X-Gm-Message-State: 96onUAWIC6I43xzy0xNJbtOsx4520388AA=
X-Google-Smtp-Source: ABdhPJxAj+4R3CiPwWjbqvlxHlGEeV20DGWfuCp3FOmWp7x3FNrlu5vzMUyj6iBjCy/NomGPtcWD0w==
X-Received: by 2002:a05:6512:131c:: with SMTP id x28mr19467347lfu.387.1614179253285;
        Wed, 24 Feb 2021 07:07:33 -0800 (PST)
X-Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id r25sm529842lfn.213.2021.02.24.07.07.32
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Feb 2021 07:07:33 -0800 (PST)
X-Received: by mail-lf1-f49.google.com with SMTP id z11so3490739lfb.9
        for <cip-dev@lists.cip-project.org>; Wed, 24 Feb 2021 07:07:32 -0800 (PST)
X-Received: by 2002:a19:e53:: with SMTP id 80mr12819721lfo.618.1614179252213;
 Wed, 24 Feb 2021 07:07:32 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
In-Reply-To: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 24 Feb 2021 23:07:21 +0800
X-Gmail-Original-Message-ID: <CAGb2v66g1BC-8R_p=wU=H90LdQi83HfH1Wnz1zoi2EKdoNNzKw@mail.gmail.com>
Message-ID: <CAGb2v66g1BC-8R_p=wU=H90LdQi83HfH1Wnz1zoi2EKdoNNzKw@mail.gmail.com>
Subject: Re: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-11
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="dFfigT5yNoO1hqWTwLyU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614179256;
 bh=7X6HhSca9wFtGLrVodXkbKky3ZWFiSpbmwL0E1VxkuM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=wJPyIzieNhAY2lJrT3wcESGqdX2zuaYM1TpYMv70pis/Dfgdfpe8AwYmcC7rlR2o1ON
 ukAcS2rlDdMRbYeuXQxipTLiIPVHT7ObnePCJbZ+Aqd9u+w7Hd//P/+EWkwERd0p7cymU
 lGQKH59qFy1sZoZ53RhvNAgcy3ZtrnUcrPY=

--dFfigT5yNoO1hqWTwLyU
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Feb 11, 2021 at 4:50 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi everyone,
>
> Six new issues this week:
> - CVE-2020-12362, CVE-2020-12363, CVE-2020-12364:
>   CVEs from Intel Advisory affecting Intel Graphics Driver. Details unknown

So the fix for these three are a firmware update. However to use the newer
firmware, a kernel patch [1] is required.

Not sure how we should mark this in our repository... ignore or fixed by
said patch?


Thanks
ChenYu

[1] https://git.kernel.org/linus/c784e5249e773689e38d2bc1749f08b986621a26

> - CVE-2021-20194 [bpf heap overflow] - fixed for relevant kernels
> - CVE-2021-20226 [io_uring UAF] - likely a duplicate of
> CVE-2020-29534, already fixed
> - CVE-2021-26708 [AF_VSOCK: local priv. escalation] - fixed for relevant kernels
>
> Additionally, CVE-2021-3347 is fixed for 4.4 and 4.9.
> I still need to match patches for 4.4 against 4.9, but it looks like
> the fixes are there.
>
>
> Regards
> ChenYu

--dFfigT5yNoO1hqWTwLyU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6193): https://lists.cip-project.org/g/cip-dev/message=
/6193
Mute This Topic: https://lists.cip-project.org/mt/80553474/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dFfigT5yNoO1hqWTwLyU--
