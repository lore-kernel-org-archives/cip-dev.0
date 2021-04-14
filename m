Return-Path: <SRS0=mUru=JL=lists.cip-project.org=bounce+64572+6376+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86AFC433ED
	for <cip-dev@archiver.kernel.org>; Wed, 14 Apr 2021 11:43:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC13A611F2
	for <cip-dev@archiver.kernel.org>; Wed, 14 Apr 2021 11:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC13A611F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6376+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id nbttYY4521723xyeE2WOs9Ab; Wed, 14 Apr 2021 04:43:36 -0700
X-Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
 by mx.groups.io with SMTP id smtpd.web10.11708.1618400615332525590
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Apr 2021 04:43:35 -0700
X-Received: by mail-lf1-f44.google.com with SMTP id r128so5650006lff.4
        for <cip-dev@lists.cip-project.org>; Wed, 14 Apr 2021 04:43:35 -0700 (PDT)
X-Gm-Message-State: zUNjS7gNF4CKNXN4nUXMbBFMx4520388AA=
X-Google-Smtp-Source: ABdhPJykzKq0gZrbqgwL7NLOn/h25w07Vj/QXCWEE5db+GDnae7FKCEnG/hU7njgmgNNMjUoRSRV3A==
X-Received: by 2002:a19:f802:: with SMTP id a2mr17883405lff.545.1618400612681;
        Wed, 14 Apr 2021 04:43:32 -0700 (PDT)
X-Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id e9sm2996106lft.150.2021.04.14.04.43.32
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 04:43:32 -0700 (PDT)
X-Received: by mail-lj1-f176.google.com with SMTP id o16so22931461ljp.3
        for <cip-dev@lists.cip-project.org>; Wed, 14 Apr 2021 04:43:32 -0700 (PDT)
X-Received: by 2002:a2e:8992:: with SMTP id c18mr14168567lji.74.1618400612204;
 Wed, 14 Apr 2021 04:43:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Wed, 14 Apr 2021 19:43:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v66BJ0YYy+8m=hMufL-UpX8BM60zh_7WXX1JnGqQFDNu7A@mail.gmail.com>
Message-ID: <CAGb2v66BJ0YYy+8m=hMufL-UpX8BM60zh_7WXX1JnGqQFDNu7A@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-04-15
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
Content-Type: multipart/mixed; boundary="NISWliFn743MmVNAPgC4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618400616;
 bh=hni8UFvU0yCgE0SOoIdEJJ7Fy60zl4zV/ULXsHZUX44=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=v3nZOd5T+VhTfolQ3PA03TcB3218PSUarza/sQfSSNoGf9qqqEBTIf77W4UT3FTRFQh
 Mlj4kNIlEqjM6mgsXakWJgQYojFTX5vCV1HwxZ3IGBxEGQSJJIFBysCxh1O81rZE6QIOe
 D8MKHCnMelga5nyHJTLXiMxf8MngsrOgKWA=

--NISWliFn743MmVNAPgC4
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Two new issues this week:

- CVE-2020-36322 [fuse: bad inode] - fixed
  Needs backport to kernels earlier than 5.4.

- CVE-2021-29154 [x86: bpf: jit: incorrect computation of branch
displacement] - fixed
  Fixed in latest stable 4.4.y, though not yet in CIP 4.4.y.

In other news, the following old CVEs have been fixed:

- CVE-2020-25670 [net/nfc/llcp res. leak]
- CVE-2020-25671 [net/nfc/llcp res. leak]
- CVE-2020-25672 [net/nfc/llcp res. leak]

In addition, a possible fix for this one was merged:

- CVE-2020-25673 [net/nfc/llcp res. leak]

Fixes for these still need to be backported to kernels earlier than 4.19.
All four are ignored for CIP kernels.


Regards
ChenYu

--NISWliFn743MmVNAPgC4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6376): https://lists.cip-project.org/g/cip-dev/message=
/6376
Mute This Topic: https://lists.cip-project.org/mt/82088841/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NISWliFn743MmVNAPgC4--
