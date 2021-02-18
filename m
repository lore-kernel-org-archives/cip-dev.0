Return-Path: <SRS0=lD1N=HU=lists.cip-project.org=bounce+64572+6182+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3755C433DB
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 09:22:13 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E876664E5F
	for <cip-dev@archiver.kernel.org>; Thu, 18 Feb 2021 09:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E876664E5F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6182+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tfkfYY4521723xmlKGisx7yz; Thu, 18 Feb 2021 01:22:12 -0800
X-Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
 by mx.groups.io with SMTP id smtpd.web11.4582.1613640131132561733
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Feb 2021 01:22:11 -0800
X-Received: by mail-lj1-f171.google.com with SMTP id k22so3202563ljg.3
        for <cip-dev@lists.cip-project.org>; Thu, 18 Feb 2021 01:22:10 -0800 (PST)
X-Gm-Message-State: rDhPqyXHAasvafTNjwxqSq5Gx4520388AA=
X-Google-Smtp-Source: ABdhPJzXCHn4Nkf9/G7jlWg91gK9kxyssy3DFQNKUmHzZL5gmRkmOhZFXJ9Au48cDi3WRv6yGEoLpw==
X-Received: by 2002:a2e:8519:: with SMTP id j25mr2004676lji.137.1613640128861;
        Thu, 18 Feb 2021 01:22:08 -0800 (PST)
X-Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id y27sm538229lfg.273.2021.02.18.01.22.08
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Feb 2021 01:22:08 -0800 (PST)
X-Received: by mail-lj1-f174.google.com with SMTP id c8so3111726ljd.12
        for <cip-dev@lists.cip-project.org>; Thu, 18 Feb 2021 01:22:08 -0800 (PST)
X-Received: by 2002:a2e:141e:: with SMTP id u30mr2084673ljd.282.1613640128357;
 Thu, 18 Feb 2021 01:22:08 -0800 (PST)
MIME-Version: 1.0
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 18 Feb 2021 17:21:57 +0800
X-Gmail-Original-Message-ID: <CAGb2v67v7o16fV4s7GTgO96P5=g3icjNUNGNs0mDdcm2BZYm=w@mail.gmail.com>
Message-ID: <CAGb2v67v7o16fV4s7GTgO96P5=g3icjNUNGNs0mDdcm2BZYm=w@mail.gmail.com>
Subject: [cip-dev] Cip-kernel-sec Updates for Week of 2021-02-18
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>, Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="dTW6wmQGxXI6n5nYtpL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613640132;
 bh=+EGu8u8V9dcKTfUZiovHSoT6flHrxQqsqXx8CQZYU8Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=aBe8SebPRMNjj7V3ZlfYwARvzvwekds9iHXNrJ5kWc+Ji4SJrRxw/qV8R8WWfuqhChd
 Nm3yMA0pSIvlfxgvvoaFzei9NTVaFoLLva5j34lz9eUKTRGwWNJhUBlZZs8QHyJ04/NMQ
 x1XdGPDhvFIm20MZ3CWxm+OgpdeXjXvNuCg=

--dTW6wmQGxXI6n5nYtpL2
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

Five new issues this week:

CVE-2021-20239 [setsockopt copy_from_user error] - fixed in 5.4 and
removed from 5.10
CVE-2021-26930 [xen-blkback error handling] - PR sent
CVE-2021-26931 [xen backends: BUG_ON in error handling] - PR sent
CVE-2021-26932 [xen grant mapping error handling] - PR sent
CVE-2021-26934 [xen unsupported driver] - Xen documentation change
stating be-alloc display driver is unsupported

Linus doesn't seem to be processing PRs for the new merge window yet,
so we might have to wait a while before the Xen ones are fixed and
backported.


ChenYu

--dTW6wmQGxXI6n5nYtpL2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6182): https://lists.cip-project.org/g/cip-dev/message=
/6182
Mute This Topic: https://lists.cip-project.org/mt/80725760/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--dTW6wmQGxXI6n5nYtpL2--
