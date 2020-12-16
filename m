Return-Path: <SRS0=txC1=FU=lists.cip-project.org=bounce+64572+5967+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B2CC4361B
	for <cip-dev@archiver.kernel.org>; Wed, 16 Dec 2020 09:19:02 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8456230FF
	for <cip-dev@archiver.kernel.org>; Wed, 16 Dec 2020 09:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8456230FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5967+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jvRTYY4521723xaRqIF3BVcy; Wed, 16 Dec 2020 01:19:00 -0800
X-Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
 by mx.groups.io with SMTP id smtpd.web08.4858.1608110339579523197
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Dec 2020 01:18:59 -0800
X-Received: by mail-lf1-f47.google.com with SMTP id o17so43613023lfg.4
        for <cip-dev@lists.cip-project.org>; Wed, 16 Dec 2020 01:18:59 -0800 (PST)
X-Gm-Message-State: PKBrBmkCDlRa8RJr76BOuDrAx4520388AA=
X-Google-Smtp-Source: ABdhPJyaLC75vBOZEHeV9lOvySkQXxvmlYc4xR7X5uk1V1P+pqDIMyb9pv0fjdxWlO2rmFie9KHV1A==
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr14897863ljh.477.1608110337071;
        Wed, 16 Dec 2020 01:18:57 -0800 (PST)
X-Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a23sm155820lfm.125.2020.12.16.01.18.56
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Dec 2020 01:18:56 -0800 (PST)
X-Received: by mail-lf1-f51.google.com with SMTP id o19so20926454lfo.1
        for <cip-dev@lists.cip-project.org>; Wed, 16 Dec 2020 01:18:56 -0800 (PST)
X-Received: by 2002:a19:c783:: with SMTP id x125mr3953409lff.303.1608110336306;
 Wed, 16 Dec 2020 01:18:56 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 16 Dec 2020 17:18:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v673Bq3hfM0oa_M=gund_xCCz6dj5GfTLfEk2SpG9N8QPw@mail.gmail.com>
Message-ID: <CAGb2v673Bq3hfM0oa_M=gund_xCCz6dj5GfTLfEk2SpG9N8QPw@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2020-12-17
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="pGixqEREbCrrEgh4BstW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608110340;
 bh=dOQv/StWUMLZJGOLkZKG2iehLlVHKtbkk8lVKcXGTt0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=M/hWQGqEaGMw/OJR3DVpsjAbkcFbXkARQHzfHZxc44VxXrxb3ueysmChZJcWPbp7O9O
 nn8F6zltG+U83rqLOzrwLM1diQdDpaVHpyHRev6Mf3agMYiPJ1DCRyDWRoQpGXBt28TYZ
 YGXwQswJxV1t09pWWFBL/FjRCUvGRyHvY7o=

--pGixqEREbCrrEgh4BstW
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Here is the cip-kernel-sec report for this week.

This week we have four new issues:

- CVE-2020-27825 [UAF in kernel/trace/ring_buffer.c]
- CVE-2020-27835 [IF/hfi1: incorrect mm_struct usage]
- CVE-2020-29660 [tty: possible freed kernel memory leak to userspace]
- CVE-2020-29661 [tty: possible UAF]

All four have been fixed in all relevant stable kernel branches.

In addition, CVE-2020-27815 [jfs] is now fixed in Linus's tree.
Also, the fix for CVE-2020-28588 from last week is now backported
to v5.4 and v5.9.


Regards
ChenYu

--pGixqEREbCrrEgh4BstW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5967): https://lists.cip-project.org/g/cip-dev/message=
/5967
Mute This Topic: https://lists.cip-project.org/mt/78997024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pGixqEREbCrrEgh4BstW--
