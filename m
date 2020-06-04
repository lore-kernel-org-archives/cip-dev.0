Return-Path: <SRS0=Op1M=7R=lists.cip-project.org=bounce+64572+4673+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90859C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 03:46:01 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F12EE205CB
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 03:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Qo8n8iZE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F12EE205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4673+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id exqaYY4521723xQ8QE92URgN; Wed, 03 Jun 2020 20:45:59 -0700
X-Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
 by mx.groups.io with SMTP id smtpd.web11.6865.1591242358495407135
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 20:45:58 -0700
X-Received: by mail-lj1-f169.google.com with SMTP id z9so5424281ljh.13
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2020 20:45:58 -0700 (PDT)
X-Gm-Message-State: rB9nY5E9izb0wigdKGfBdqdxx4520388AA=
X-Google-Smtp-Source: ABdhPJxLyfokLmx6VC+ACVDFH8Z8MQPW3h1nL1Z1DsSfpbuXx26O3amCK6pZj9zbTWjqaTOp4nUUYg==
X-Received: by 2002:a2e:8490:: with SMTP id b16mr1127928ljh.325.1591242356208;
        Wed, 03 Jun 2020 20:45:56 -0700 (PDT)
X-Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v28sm1145300lfd.35.2020.06.03.20.45.55
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 20:45:55 -0700 (PDT)
X-Received: by mail-lj1-f175.google.com with SMTP id c11so5482309ljn.2
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2020 20:45:55 -0700 (PDT)
X-Received: by 2002:a2e:6c07:: with SMTP id h7mr1150414ljc.125.1591242355543;
 Wed, 03 Jun 2020 20:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200604031829.3254-1-wens@csie.org>
In-Reply-To: <20200604031829.3254-1-wens@csie.org>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 4 Jun 2020 11:45:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HcOGwFSaqcb468aimDFvWBUVCF=wrWfDLXGnZPXK4nQ@mail.gmail.com>
Message-ID: <CAGb2v64HcOGwFSaqcb468aimDFvWBUVCF=wrWfDLXGnZPXK4nQ@mail.gmail.com>
Subject: Re: [cip-dev] [4.4.y-cip 00/15] PM / OPP v2 & cpufreq backports part 1
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>, Pavel Machek <pavel@denx.de>
Cc: cip-dev@lists.cip-project.org, 
	=?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= <JohnsonCH.Chen@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="ZMVrOgC6LtqwytICgvsJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591242359;
 bh=p/aS5VopqzoimZCuIENbqEjucGPdnu583oR0wc7ZlvU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Qo8n8iZEcW04URGTFsqRTgNlqwEtzfHuTIRtLRiwLvgU8P0rmB82Hz1Apulth/AJDS4
 0Ds9jwedXwDUf4vFHRJlNlwTsX9Q3bhNdpSCZU98zrRkwdLXju8UZTVJ0RAey2ogSMviD
 R+7y+zv9hUI48hH4iwbYl4jADYKtr9VY/+g=

--ZMVrOgC6LtqwytICgvsJ
Content-Type: text/plain; charset="UTF-8"

On Thu, Jun 4, 2020 at 11:26 AM Chen-Yu Tsai (Moxa) <wens@csie.org> wrote:
>
> Hi everyone,
>
> This is part 1 of MOXA's PM / OPP / cpufreq backport series. The whole
> series aims to backport patches related to PM / OPPv2 and cpufreq
> which were included in the v4.4 kernel from TI's SDK. The end goal is
> to include cpufreq-ti and convert am33xx to using it and OPPv2.

Looks like this didn't hit the mailing list. I will resend again.
Sorry for the noise.

ChenYu

--ZMVrOgC6LtqwytICgvsJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4673): https://lists.cip-project.org/g/cip-dev/message=
/4673
Mute This Topic: https://lists.cip-project.org/mt/74665338/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZMVrOgC6LtqwytICgvsJ--
