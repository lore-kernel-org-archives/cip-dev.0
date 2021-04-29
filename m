Return-Path: <SRS0=z4K+=J2=lists.cip-project.org=bounce+64572+6400+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D76C433ED
	for <cip-dev@archiver.kernel.org>; Thu, 29 Apr 2021 03:12:42 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE18D61411
	for <cip-dev@archiver.kernel.org>; Thu, 29 Apr 2021 03:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE18D61411
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6400+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Es8nYY4521723xtC3doD36lP; Wed, 28 Apr 2021 20:12:39 -0700
X-Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web08.1664.1619665949438994586
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Apr 2021 20:12:29 -0700
X-Received: by mail-lf1-f54.google.com with SMTP id x19so72212313lfa.2
        for <cip-dev@lists.cip-project.org>; Wed, 28 Apr 2021 20:12:29 -0700 (PDT)
X-Gm-Message-State: TUbpZ1l8DbcLjD0WrDdAate4x4520388AA=
X-Google-Smtp-Source: ABdhPJwM2B4o1idxDGhdfLvAWk4OHjc9xrnc2toWaHVPGWYAZJ4XstX2S1AGTV310g2S+qfvksgG4Q==
X-Received: by 2002:a19:354:: with SMTP id 81mr16929990lfd.174.1619665947372;
        Wed, 28 Apr 2021 20:12:27 -0700 (PDT)
X-Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id z22sm378501lfu.200.2021.04.28.20.12.27
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 20:12:27 -0700 (PDT)
X-Received: by mail-lj1-f179.google.com with SMTP id a13so20845813ljp.2
        for <cip-dev@lists.cip-project.org>; Wed, 28 Apr 2021 20:12:27 -0700 (PDT)
X-Received: by 2002:a2e:a692:: with SMTP id q18mr23044387lje.78.1619665946952;
 Wed, 28 Apr 2021 20:12:26 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 29 Apr 2021 11:12:16 +0800
X-Gmail-Original-Message-ID: <CAGb2v64xbANytUSdzOowMh=wJVue3B6UmtDcvmjqtyh31Hcz2Q@mail.gmail.com>
Message-ID: <CAGb2v64xbANytUSdzOowMh=wJVue3B6UmtDcvmjqtyh31Hcz2Q@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-04-29
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="yJV8q1ULscXfSNvgwrGt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619665959;
 bh=x4f6P3y6Ni4PieeOpF7xZPE0j2z/1Zp9o+3ODs3pWXQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=eejMrbfE4tG7hSGU4inXisqbVDLYjaFEYPUQqiMkVxe4wU7r1gMezFb5MWeb7wcRzw9
 AJNpgevTsDa1SH0B9oDKQ1cjZsckrkQl8BxFV/SboAIqn16qofDJA5W0xzehIsRs6DKYB
 yKI1hNHtXn64rUinbjwzGIJnp+pbkzZo5us=

--yJV8q1ULscXfSNvgwrGt
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

This was a quiet week. Only one new issue:

- CVE-2021-3501 [x86: KVM: VMX: data race condition] - fixed

Nothing else to report on.


Regards
ChenYu

--yJV8q1ULscXfSNvgwrGt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6400): https://lists.cip-project.org/g/cip-dev/message=
/6400
Mute This Topic: https://lists.cip-project.org/mt/82447430/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--yJV8q1ULscXfSNvgwrGt--
