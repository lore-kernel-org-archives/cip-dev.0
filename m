Return-Path: <SRS0=4uhc=GQ=lists.cip-project.org=bounce+64572+6070+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65516C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 14:46:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DE6C2313C
	for <cip-dev@archiver.kernel.org>; Wed, 13 Jan 2021 14:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE6C2313C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6070+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id ZpoXYY4521723xJgMWoLQusZ; Wed, 13 Jan 2021 06:46:44 -0800
X-Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
 by mx.groups.io with SMTP id smtpd.web10.8934.1610549203306027293
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Jan 2021 06:46:43 -0800
X-Received: by mail-vs1-f46.google.com with SMTP id k30so1235517vsp.6
        for <cip-dev@lists.cip-project.org>; Wed, 13 Jan 2021 06:46:43 -0800 (PST)
X-Gm-Message-State: 0szWdq5xKFEp0ni5VxTbFTZJx4520388AA=
X-Google-Smtp-Source: ABdhPJywF5B4C51yhOn5zznv7SE5WjYkNkUoFYnu61Obj/95iYV+LRyo8zSTIdwIguYUSUCpIHIkpQ==
X-Received: by 2002:a67:3142:: with SMTP id x63mr2421509vsx.37.1610549201846;
        Wed, 13 Jan 2021 06:46:41 -0800 (PST)
X-Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id j3sm271011vsr.16.2021.01.13.06.46.40
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 06:46:41 -0800 (PST)
X-Received: by mail-ua1-f44.google.com with SMTP id k47so764171uad.1
        for <cip-dev@lists.cip-project.org>; Wed, 13 Jan 2021 06:46:40 -0800 (PST)
X-Received: by 2002:a9f:21f8:: with SMTP id 111mr2059739uac.115.1610549200588;
 Wed, 13 Jan 2021 06:46:40 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 13 Jan 2021 22:46:28 +0800
X-Gmail-Original-Message-ID: <CAGb2v67zgGqdh0CbiP1dsWYLZC9v21WHqd+QKaZ7zg0KAU_dFQ@mail.gmail.com>
Message-ID: <CAGb2v67zgGqdh0CbiP1dsWYLZC9v21WHqd+QKaZ7zg0KAU_dFQ@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-14
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="FPFKqTYtpoa3le6CEdko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610549204;
 bh=TbvDjaHTjKgdNh4xMxNyKYTm2pEw0CK6VqhIEVvmQXI=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZD+SDuH9VEncYVt2L3oIcjSzGqqQyJCLCVuZDNKZ4apvQ/sEWhS6o9JAdb24c9miPNK
 zsEojZTGQ+iJ/unGQzxlaaHIYvOgVlwPhsS51IKDJKIHLiKXBJ96lROnNdXCvu44A3KVt
 kLUxp/inQpSj2cRVl5VRslTdXnh8PCD2Y8k=

--FPFKqTYtpoa3le6CEdko
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Three new issues this week:

- CVE-2020-28374 [target/xcopy] - fixed
  Fix is missing from 4.4 and 4.9; notified Sasha on IRC
- CVE-2020-35508 [fork copy_process race] - fixed for all kernels
- CVE-2021-20177 [netfilter kernel panic] - fixed for all kernels
  Findings were also reported back to Debian


Regards
ChenYu

--FPFKqTYtpoa3le6CEdko
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6070): https://lists.cip-project.org/g/cip-dev/message=
/6070
Mute This Topic: https://lists.cip-project.org/mt/79651977/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--FPFKqTYtpoa3le6CEdko--
