Return-Path: <SRS0=HIDv=NK=lists.cip-project.org=bounce+64572+6700+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F12C4338F
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:19:22 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C19C610FE
	for <cip-dev@archiver.kernel.org>; Thu, 19 Aug 2021 09:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C19C610FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 6szsYY4521723x70mtAaBWzr; Thu, 19 Aug 2021 02:19:21 -0700
X-Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
 by mx.groups.io with SMTP id smtpd.web12.67495.1629364759386794291
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Aug 2021 02:19:21 -0700
X-Received: by mail-oi1-f182.google.com with SMTP id r26so7701646oij.2
        for <cip-dev@lists.cip-project.org>; Thu, 19 Aug 2021 02:19:19 -0700 (PDT)
X-Gm-Message-State: gcWDzxVV9iZpPJBEOn392IW6x4520388AA=
X-Google-Smtp-Source: ABdhPJyInoHWt8cSfIiRmiqHqHwJw4aCIrXhrE1ctT+q0R1itEJhHrS68Cd3VrEAluCwUAE/MMI1WWJL+4pgeMHpVWI=
X-Received: by 2002:a54:4182:: with SMTP id 2mr1946875oiy.66.1629364758561;
 Thu, 19 Aug 2021 02:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAODzB9ra5A_NkvqgPMhXc8PR17gaC+R3FU4mfA-_scKGo1Mspw@mail.gmail.com>
 <20210819072312.GC32099@amd>
In-Reply-To: <20210819072312.GC32099@amd>
From: "Masami Ichikawa" <masami.ichikawa@miraclelinux.com>
Date: Thu, 19 Aug 2021 18:18:42 +0900
Message-ID: <CAODzB9rwfLcxAp8hX8ug_CL_LNN2EDxUt2y_ndoOfWjnX_XTng@mail.gmail.com>
Subject: Re: Old CVE entries worth watching -- was Re: [cip-dev] New CVE entries this week
To: cip-dev <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="bhhtrU13bivqQQ5aqEoD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1629364761;
 bh=sC1THaqbJKPSTy76/CVW3nL6F3Rk8p8wp4+I//fL6WA=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=hkBRA2zFELA0C9x2iG4YThXRHflHchOKK7QdifCMtQGDFR7OCDC2xqakfzhO7UXKN/M
 idqSFZJ7UcJ0KxPPZBShtZG5GTBVHNLwpwPy4XTmU8eWFQQ5VxLVG1pdlZdBkQFHCTi/q
 8pWCeSdCuWxP94CzWIW3HSQb/6GUO4eynIY=

--bhhtrU13bivqQQ5aqEoD
Content-Type: text/plain; charset="UTF-8"

Hi !

On Thu, Aug 19, 2021 at 4:23 PM Pavel Machek <pavel@denx.de> wrote:
>
> Hi!
>
> I was going through CVE entries for a month or so and these
> accumulated in that time. Would it make sense to add them to the
> current "watch list"?
>
> ** Bluetooth
>
> Unfortunately, not enough info is present here:
>
> CVE-2020-26555 -- BR/EDR pin code pairing broken
> CVE-2020-26556 CVE-2020-26557 CVE-2020-26559 CVE-2020-26560 -- bluetooth mesh
>
> ** BPF
>
> CVE-2021-3600 -- More eBPF  issues. 4.19+, but we still may need to
> fix 4.19
>

Thank you for the information.
I'll add these CVEs to tracking list.

> Best regards,
>                                                                 Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
>
> 
>

Regrads,
-- 
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--bhhtrU13bivqQQ5aqEoD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6700): https://lists.cip-project.org/g/cip-dev/message/=
6700
Mute This Topic: https://lists.cip-project.org/mt/84991735/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--bhhtrU13bivqQQ5aqEoD--
