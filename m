Return-Path: <SRS0=JvWd=HN=lists.cip-project.org=bounce+64572+6170+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DC5C433E0
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 09:49:08 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2556664E00
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 09:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2556664E00
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6170+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id BoE6YY4521723xPSKPJRsRsX; Thu, 11 Feb 2021 01:49:06 -0800
X-Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
 by mx.groups.io with SMTP id smtpd.web08.6314.1613036945467242094
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Feb 2021 01:49:05 -0800
X-Received: by mail-lj1-f177.google.com with SMTP id s18so6603601ljg.7
        for <cip-dev@lists.cip-project.org>; Thu, 11 Feb 2021 01:49:05 -0800 (PST)
X-Gm-Message-State: OxAMIC1x2cKc91sro3mQfqB2x4520388AA=
X-Google-Smtp-Source: ABdhPJyteqZeAQ8+hINlSmDBR9TAaUx/vTJEU7vxD6oOhhRZAKM2nfWxtW8c02iD9AAVBcl7bT6YUw==
X-Received: by 2002:a2e:b710:: with SMTP id j16mr838604ljo.270.1613036943437;
        Thu, 11 Feb 2021 01:49:03 -0800 (PST)
X-Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u25sm851810ljo.98.2021.02.11.01.49.03
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 01:49:03 -0800 (PST)
X-Received: by mail-lj1-f172.google.com with SMTP id g21so53323ljl.3
        for <cip-dev@lists.cip-project.org>; Thu, 11 Feb 2021 01:49:03 -0800 (PST)
X-Received: by 2002:a2e:8998:: with SMTP id c24mr731081lji.74.1613036942947;
 Thu, 11 Feb 2021 01:49:02 -0800 (PST)
MIME-Version: 1.0
References: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
In-Reply-To: <CAGb2v64SEFQBXfGhC_WDP-2SyJbtAdzmsdZjbiygUhP9pE4a0g@mail.gmail.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 11 Feb 2021 17:48:50 +0800
X-Gmail-Original-Message-ID: <CAGb2v67Pwbpn6gTTfLzUrNQE2Ubph_LMGC_VZUNRb_BWrneAAg@mail.gmail.com>
Message-ID: <CAGb2v67Pwbpn6gTTfLzUrNQE2Ubph_LMGC_VZUNRb_BWrneAAg@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="AXT7FsOrz9IOyebRjE2o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613036946;
 bh=1HRdUK2TEGxbjmRrtwtCg+IaIMNcn+HGjhi1Wchozl8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=m1sQx6G/CcCeNC8cIRZz58Ib0Ef/D/Zz/dvyj+o1QZsrixtFRLR2ZyC5SW9q+SJ6cVj
 aLD5js08H7SapLQTDgOWhtKlhMMIQ7qjY5BbKIO/+GAgoF7vyCHtHzqJlreqvzXHXDK1K
 X5rizciXsc7OMPTZtQy4PuzxzDll2hWIEdw=

--AXT7FsOrz9IOyebRjE2o
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 11, 2021 at 4:50 PM Chen-Yu Tsai <wens@csie.org> wrote:
>
> Hi everyone,
>
> Six new issues this week:
> - CVE-2020-12362, CVE-2020-12363, CVE-2020-12364:
>   CVEs from Intel Advisory affecting Intel Graphics Driver. Details unknown
>
> - CVE-2021-20194 [bpf heap overflow] - fixed for relevant kernels
> - CVE-2021-20226 [io_uring UAF] - likely a duplicate of
> CVE-2020-29534, already fixed
> - CVE-2021-26708 [AF_VSOCK: local priv. escalation] - fixed for relevant kernels
>
> Additionally, CVE-2021-3347 is fixed for 4.4 and 4.9.
> I still need to match patches for 4.4 against 4.9, but it looks like
> the fixes are there.

Based on fixes for 4.9 reported by Debian, CVE-2021-3347 is now fixed for 4.4 by
6510e4a2d04f33e4bfd221760faab23e55d8772b..46358277b2da868763517f79aa0ac25ce78c4f68
inclusive.

Lee Jones just posted a few follow-up fixes for futexes for 4.9 [1]. I
wonder if they
would also be posted for 4.4.


Regards
ChenYu

[1] https://lore.kernel.org/stable/20210211092700.11772-1-lee.jones@linaro.org/

--AXT7FsOrz9IOyebRjE2o
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6170): https://lists.cip-project.org/g/cip-dev/message=
/6170
Mute This Topic: https://lists.cip-project.org/mt/80553474/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--AXT7FsOrz9IOyebRjE2o--
