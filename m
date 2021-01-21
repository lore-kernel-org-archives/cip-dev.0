Return-Path: <SRS0=tXT2=GY=lists.cip-project.org=bounce+64572+6122+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7580C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD9D5238D7
	for <cip-dev@archiver.kernel.org>; Thu, 21 Jan 2021 03:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD9D5238D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6122+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id uor4YY4521723xKRDFpdjBuj; Wed, 20 Jan 2021 19:51:12 -0800
X-Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
 by mx.groups.io with SMTP id smtpd.web10.2437.1611201071125447191
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Jan 2021 19:51:11 -0800
X-Received: by mail-lf1-f53.google.com with SMTP id q8so586139lfm.10
        for <cip-dev@lists.cip-project.org>; Wed, 20 Jan 2021 19:51:10 -0800 (PST)
X-Gm-Message-State: MCMxpJliv1DKbuIZTYV0oRuJx4520388AA=
X-Google-Smtp-Source: ABdhPJy31ZoeGE/e1DGpeH1dvKYIICmGD4Ru80TvvqjxqBxhSUipjBPIyA7qN7N50gp7vjtR/0H2TQ==
X-Received: by 2002:a19:e004:: with SMTP id x4mr5271192lfg.419.1611201068955;
        Wed, 20 Jan 2021 19:51:08 -0800 (PST)
X-Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id q14sm424191ljm.11.2021.01.20.19.51.08
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 19:51:08 -0800 (PST)
X-Received: by mail-lj1-f181.google.com with SMTP id f4so42947ljo.11
        for <cip-dev@lists.cip-project.org>; Wed, 20 Jan 2021 19:51:08 -0800 (PST)
X-Received: by 2002:a2e:8852:: with SMTP id z18mr6285534ljj.94.1611201068433;
 Wed, 20 Jan 2021 19:51:08 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 21 Jan 2021 11:50:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v66bGEX3sCBNnYdv07cuojOjNe1Gf-D3Mb4Kik-He3nt0w@mail.gmail.com>
Message-ID: <CAGb2v66bGEX3sCBNnYdv07cuojOjNe1Gf-D3Mb4Kik-He3nt0w@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-01-21
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="iBa4yiSVRjlMol3L0544"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611201072;
 bh=5oO2TEVdKtpaQnvYauQgG740xhWIZeBGrsPjuk3kzks=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=TTo4VPUkspUeKlUeKb9S6IF3DeWK400NytBb6GgmrMNasp+4EOmOX0MA/aceCGTrKL3
 bonkC5OxpRk9Uhh0a2BZqMIdH0ortN6H2rIR0FDdKT/HJLHZCfopqq/cWsCI7hDIsz/lW
 J7/Tx6QeeyC5Sljqcp+NIHGaSJ6FOkOY6eg=

--iBa4yiSVRjlMol3L0544
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

One new issue this week:
- CVE-2021-3178 [nfsd4: readdirplus returns parent of export] - fixed
in mainline

The fix was only merged into Linus's tree a couple days ago, so we should
see the backports in a few days.

I've also added the 5.10-cip branch to the tracker.


Regards
ChenYu

--iBa4yiSVRjlMol3L0544
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6122): https://lists.cip-project.org/g/cip-dev/message=
/6122
Mute This Topic: https://lists.cip-project.org/mt/79996445/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--iBa4yiSVRjlMol3L0544--
