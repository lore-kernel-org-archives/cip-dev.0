Return-Path: <SRS0=/GW9=JT=lists.cip-project.org=bounce+64572+6382+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4230EC433ED
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 07:04:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555DA613D8
	for <cip-dev@archiver.kernel.org>; Thu, 22 Apr 2021 07:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555DA613D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6382+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id fyHiYY4521723x8keYrDurzI; Thu, 22 Apr 2021 00:04:45 -0700
X-Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
 by mx.groups.io with SMTP id smtpd.web12.8991.1619075084523696665
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Apr 2021 00:04:44 -0700
X-Received: by mail-lj1-f178.google.com with SMTP id m7so39793940ljp.10
        for <cip-dev@lists.cip-project.org>; Thu, 22 Apr 2021 00:04:44 -0700 (PDT)
X-Gm-Message-State: a0YgWpQavmdKegHy1mT3SEZ6x4520388AA=
X-Google-Smtp-Source: ABdhPJwwhLzlHirx4oRbhjKDDdjCN9fddMY/WaaDQ6cGnk9ErUgCou86QuyawZhm6iGa+gxz7OIFhA==
X-Received: by 2002:a2e:9741:: with SMTP id f1mr1514367ljj.226.1619075082380;
        Thu, 22 Apr 2021 00:04:42 -0700 (PDT)
X-Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q25sm176395lfb.168.2021.04.22.00.04.41
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Apr 2021 00:04:42 -0700 (PDT)
X-Received: by mail-lf1-f42.google.com with SMTP id g8so70568313lfv.12
        for <cip-dev@lists.cip-project.org>; Thu, 22 Apr 2021 00:04:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3910:: with SMTP id a16mr1491392lfu.303.1619075081653;
 Thu, 22 Apr 2021 00:04:41 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 22 Apr 2021 15:04:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v662tfa68d6areLEJV=RA3Gwn751-uT7t99uvRe3PN6KKg@mail.gmail.com>
Message-ID: <CAGb2v662tfa68d6areLEJV=RA3Gwn751-uT7t99uvRe3PN6KKg@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-04-22
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
Content-Type: multipart/mixed; boundary="ZHDn6BYTLV8t3ANM7rxK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619075085;
 bh=hwBU3MtU/wPeSQyagRNPmELY7na9WVZGC+DnFCk60xg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=F8hDbAPlw2HOXE1qRe0ZZ/opedLTISo//s87ai1AKyr+zll2rj7LqcZED+dVfJCBW3d
 JprR57WYXGCAgp3CTIQ7+UcDE0kueyzoVCac5Ez1dqZGDnIgzLLVmaWG4NmsN+LaWXZas
 RFSdCZaz+pRjYfQ2sPA41demQJEkCuYTgqE=

--ZHDn6BYTLV8t3ANM7rxK
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Seven new CVEs this week, though three can be ignored.

- CVE-2021-1076 [nvidia out-of-tree driver DoS] - ignore
- CVE-2021-1077 [nvidia out-of-tree driver DoS] - ignore
- CVE-2021-23133 [net/sctp: race in sctp_destroy_sock] - fixed
  Needs backport to kernels before 5.4

- CVE-2021-29155 [bpf: kernel memory content leak] - fixed
  Debian notes this likely only affects 5.8 and later.
  I intend to mark it as such if no one objects.

- CVE-2021-3492 [shiftfs: double free] - ignore Ubuntu specific
- CVE-2021-3493 [overlayfs: privilege escalation] - fixed
- CVE-2021-3506 [f2fs: out-of-bounds access] - fix queued up for -next

Regarding CVE-2021-29650 from 4/1, it seems Pavel's backport
still didn't hit the stable mailing list. Guenter ended up
posting backports [1] for all the old LTS kernels, but there
were some other issues and he asked Greg to drop them.


Regards
ChenYu

[1] https://lore.kernel.org/stable/1780f159-140b-231f-8af5-ccec049dc8b0@roeck-us.net/

--ZHDn6BYTLV8t3ANM7rxK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6382): https://lists.cip-project.org/g/cip-dev/message=
/6382
Mute This Topic: https://lists.cip-project.org/mt/82280293/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ZHDn6BYTLV8t3ANM7rxK--
