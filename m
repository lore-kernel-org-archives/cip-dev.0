Return-Path: <SRS0=FaRX=LW=lists.cip-project.org=bounce+64572+6587+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4A3C49EAB
	for <cip-dev@archiver.kernel.org>; Mon, 28 Jun 2021 07:53:18 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D44F61990
	for <cip-dev@archiver.kernel.org>; Mon, 28 Jun 2021 07:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D44F61990
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6587+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id veyYYY4521723xXHP8TtVDde; Mon, 28 Jun 2021 00:53:16 -0700
X-Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
 by mx.groups.io with SMTP id smtpd.web10.8221.1624866794665244241
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jun 2021 00:53:16 -0700
X-Received: by mail-ot1-f41.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so17865279oti.2
        for <cip-dev@lists.cip-project.org>; Mon, 28 Jun 2021 00:53:14 -0700 (PDT)
X-Gm-Message-State: 1ppVaEUHIKc3Glik4UYJ2dsJx4520388AA=
X-Google-Smtp-Source: ABdhPJwZJuzAZzbDzFfyhqV2/qCzaHPM15RU9JSZfn/QpXqhqkzu/B/w2gLYOwwvz/PlHn8nNcLpkDtUUbUFJ1Td7zg=
X-Received: by 2002:a05:6830:40b4:: with SMTP id x52mr19462188ott.117.1624866793747;
 Mon, 28 Jun 2021 00:53:13 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Mon, 28 Jun 2021 16:52:38 +0900
Message-ID: <CAODzB9pWQDn9QZfJXOTdFk4ko_exC+FxVhr4vxf_YK0yzQ8PWQ@mail.gmail.com>
Subject: [cip-dev] cannot push to cip-kernel-sec repository
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp
Cc: masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="QY5bi4xB89pr2g7WM5FY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1624866796;
 bh=jLQDHsv2jZOS7bu9Js2rUXiSsOJ8BAnYZoaMo7omkKU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hFpQmV/304Rsvl9vkd/LM1kUZHfVGpxTB+31bcfqYgO/h9cw066kDey1jIFvVJjRBaW
 SVPwpOi7rAXN4PRLfjnR92BDtkRGuOSCdbskEMkRzUB18vug9QgiyIkWRz3tvqK9mbXYI
 DGk3oVGV+3NWbR++KLdo/xzSaVwntCfQ6fs=

--QY5bi4xB89pr2g7WM5FY
Content-Type: text/plain; charset="UTF-8"

Hi, Iwamatsu-san

When I push commit to the cip-kernel-sec repository,  I get the following error.

masami@debian:~/cip/cip-kernel-sec$ git push -u origin master
Enumerating objects: 1557, done.
Counting objects: 100% (1557/1557), done.
Delta compression using up to 2 threads
Compressing objects: 100% (811/811), done.
Writing objects: 100% (811/811), 186.14 KiB | 6.89 MiB/s, done.
Total 811 (delta 742), reused 0 (delta 0)
remote: Resolving deltas: 100% (742/742), completed with 741 local objects.
remote: GitLab: You are not allowed to push code to protected branches
on this project.
To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
 ! [remote rejected] master -> master (pre-receive hook declined)

It looks like I don't have permission to push the master branch.
Would you mind giving me permission to push, please?

Regards,

-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--QY5bi4xB89pr2g7WM5FY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6587): https://lists.cip-project.org/g/cip-dev/message=
/6587
Mute This Topic: https://lists.cip-project.org/mt/83840144/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QY5bi4xB89pr2g7WM5FY--
