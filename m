Return-Path: <SRS0=VVqz=IX=lists.cip-project.org=bounce+64572+6331+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4487C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 08:55:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E050861A02
	for <cip-dev@archiver.kernel.org>; Thu, 25 Mar 2021 08:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E050861A02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6331+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id jhcSYY4521723xwpkuQD2Gw8; Thu, 25 Mar 2021 01:55:27 -0700
X-Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
 by mx.groups.io with SMTP id smtpd.web09.5381.1616662526528936027
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Mar 2021 01:55:26 -0700
X-Received: by mail-lf1-f54.google.com with SMTP id b83so1341413lfd.11
        for <cip-dev@lists.cip-project.org>; Thu, 25 Mar 2021 01:55:26 -0700 (PDT)
X-Gm-Message-State: cHU2LF8t9qORe4GKGU3kXzYyx4520388AA=
X-Google-Smtp-Source: ABdhPJxHLcqzYxEQdgY8pZlIdObDGNYm267jsB1WMex2+dh5jalKQr+2umVMQKSh+RuAmZd8i8yLBg==
X-Received: by 2002:a19:7d0:: with SMTP id 199mr4646213lfh.390.1616662524407;
        Thu, 25 Mar 2021 01:55:24 -0700 (PDT)
X-Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id g3sm476637lfb.94.2021.03.25.01.55.24
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Mar 2021 01:55:24 -0700 (PDT)
X-Received: by mail-lj1-f171.google.com with SMTP id 15so2203235ljj.0
        for <cip-dev@lists.cip-project.org>; Thu, 25 Mar 2021 01:55:24 -0700 (PDT)
X-Received: by 2002:a2e:800b:: with SMTP id j11mr5083912ljg.94.1616662523869;
 Thu, 25 Mar 2021 01:55:23 -0700 (PDT)
MIME-Version: 1.0
Reply-To: cip-dev@lists.cip-project.org
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 25 Mar 2021 16:55:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Mk4ULqU40qT4ktb-VeW5Sv=D8nOpq9bgKBZiuwZL1Uw@mail.gmail.com>
Message-ID: <CAGb2v65Mk4ULqU40qT4ktb-VeW5Sv=D8nOpq9bgKBZiuwZL1Uw@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-03-25
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Content-Type: multipart/mixed; boundary="pPttODKPmlZexAYixAko"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616662527;
 bh=+jsbUS4H0n0s3+FPJ2c7/4DqvNaLsdSUBQ1Kwfzb+to=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nZjkMCV456aTS+HxCDv+z2RjjKH80n0ueRnnZlWLCyIM8KM43iycwwP1O9wq48/wIWH
 L5yWyYvNC6jopl5jbAbBYp0mTy9iWekSyZkD1MsQqJRwyZ2TUdab1kSfKNs2t9O1FGssB
 1MbdnzaleyYPVF5J3Eq5qmPjpI32OV+sIKA=

--pPttODKPmlZexAYixAko
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Ten new issues this week:

- CVE-2020-27170 [bpf: alu ops on pointer types] - fixed

- CVE-2020-27171 [bpf: mask off-by-one] - fixed

- CVE-2021-3444 [bpf: truncation handling mod32] - fixed but
  needs backport to 4.19.

- CVE-2021-20292 [drm: tt] - fixed
  Need to verify if backport to 4.4 is needed

- CVE-2021-28950 [fuse: live lock] - fixed

- CVE-2021-28951 [io_uring] - fixed

- CVE-2021-28952 [ASoc: sdm845] - fixed (ignore for CIP)

- CVE-2021-28964 [btrfs: race] - fixed

- CVE-2021-28971 [perf/x86/intel] - fixed

- CVE-2021-28972 [PCI: rpadlpar: drc_name corruption] - fixed


Regards
ChenYu

--pPttODKPmlZexAYixAko
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6331): https://lists.cip-project.org/g/cip-dev/message=
/6331
Mute This Topic: https://lists.cip-project.org/mt/81597678/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--pPttODKPmlZexAYixAko--
