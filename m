Return-Path: <SRS0=uTea=HG=lists.cip-project.org=bounce+64572+6162+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D0DC433DB
	for <cip-dev@archiver.kernel.org>; Thu,  4 Feb 2021 05:26:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD1AF64F47
	for <cip-dev@archiver.kernel.org>; Thu,  4 Feb 2021 05:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD1AF64F47
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6162+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id dXGHYY4521723xIYZAppOs2s; Wed, 03 Feb 2021 21:26:44 -0800
X-Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
 by mx.groups.io with SMTP id smtpd.web10.3699.1612416403240080388
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Feb 2021 21:26:43 -0800
X-Received: by mail-vk1-f170.google.com with SMTP id e1so403266vkd.10
        for <cip-dev@lists.cip-project.org>; Wed, 03 Feb 2021 21:26:43 -0800 (PST)
X-Gm-Message-State: zvbIQu7UOV90PXuwZwYEP7uPx4520388AA=
X-Google-Smtp-Source: ABdhPJxI96RGLhQZu2BOvoFSJvFrkG+FizUSkuGw1zdWOjZBmqkLhV6g7UWaZsIBuewaQLDUREzL6w==
X-Received: by 2002:ac5:cb79:: with SMTP id l25mr4256323vkn.20.1612416401956;
        Wed, 03 Feb 2021 21:26:41 -0800 (PST)
X-Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id q8sm585557vkd.33.2021.02.03.21.26.41
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 21:26:41 -0800 (PST)
X-Received: by mail-ua1-f46.google.com with SMTP id g5so546700uak.10
        for <cip-dev@lists.cip-project.org>; Wed, 03 Feb 2021 21:26:41 -0800 (PST)
X-Received: by 2002:ab0:7250:: with SMTP id d16mr4272330uap.115.1612416401105;
 Wed, 03 Feb 2021 21:26:41 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 4 Feb 2021 13:26:29 +0800
X-Gmail-Original-Message-ID: <CAGb2v664ebkxydSr3f8hHUUFx0t=FyGDpyJjhgwtdNe0OBaL3w@mail.gmail.com>
Message-ID: <CAGb2v664ebkxydSr3f8hHUUFx0t=FyGDpyJjhgwtdNe0OBaL3w@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-04
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="AhZxGpMjygFjnS3yzDfz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1612416404;
 bh=YTliOMPWp0QYR9GoiQ3XTdiNGT+bqcI4N4YWT/jb3y0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VRTuUNi+noBAeoPxSGBlV6D79Qgp0HqnQLPqZLIsYxeDnjr3IkmCRBLq6h2hM/7dG8Y
 aeuo1rbxIqyir09UtDrDnJ9QB9RdR4yD97Rvl96XLV6C/+RMD4UzuNeRzotRMPnLseLyZ
 2sE+urdU3YVcDhZEeKsMeViCQUCyHqUgdXw=

--AhZxGpMjygFjnS3yzDfz
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Two new issue this week:
- CVE-2021-3347 [UAF in futex]: fixed for 4.14 and later [1]
- CVE-2021-3348 [nbd: UAF when adding connections while operations are
running]: fixed in all kernels

For CVE-2021-3347, based on [1], more patches are needed for 4.4 and 4.9.
The second batch:

12bb3f7f1b03d5913b3f9d4236a488aa7774dfe9..34b1a1ce1458f50ef27c54e28eb9b1947012907a
inclusive

has not been included yet. Lee Jones seems to be handling it [2].

For CVE-2020-27825 from two weeks ago, the fix has been backported to
all stable kernels.

For CVE-2020-16120, Ubuntu mentions a regression due to the backported fix [3].
We probably don't care either way since this requires unprivileged
user namespace
is enabled.


Regards
ChenYu

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/pending/futex_issues.txt
[2] https://lore.kernel.org/stable/20210203134539.2583943-1-lee.jones@linaro.org/
[2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1900141

--AhZxGpMjygFjnS3yzDfz
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6162): https://lists.cip-project.org/g/cip-dev/message=
/6162
Mute This Topic: https://lists.cip-project.org/mt/80374042/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AhZxGpMjygFjnS3yzDfz--
