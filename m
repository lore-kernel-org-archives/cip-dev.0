Return-Path: <claudiu.beznea@tuxon.dev>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC51EC5B555
	for <webhook@archiver.kernel.org>; Wed,  4 Jun 2025 10:13:50 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web10.13112.1749032020801925935
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Jun 2025 03:13:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@tuxon.dev header.s=google header.b=MvpbJ0Om;
 spf=pass (domain: tuxon.dev, ip: 209.85.221.45, mailfrom: claudiu.beznea@tuxon.dev)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a0ac853894so6101004f8f.3
        for <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749032019; x=1749636819; darn=lists.cip-project.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FEqyAryvSU2LKQBzodTUdGD1yIcQAy85U5Usnhj+zA4=;
        b=MvpbJ0OmGMOKA4VBm0CwG99bS75uuwJwW+CyFcc/M+4vc1DQaGImU0kjiyv/gxBMaJ
         9hyiPCC3SvRQiDeVThyI5r26SX7FayaTD4Hc3TGhOHaVYowBiRTucytikrk22NTM2oUy
         NBOvxv+JC8M6tMu61tMk73AO40ewhNX8aBeu+Pa0fOwHXvLezzs9TUx13b4gZaMZBkMS
         mnEOznPAlpZBKAPy4MYwKNrDPkcWf7Y2+bgFmQF4I6mLnGm9EY2nRUcogURBRM1PJ0b8
         WIUQSaU6E0QT+tQ8AVWoHXsS0rNW2QxXIml0lIRdeaciC70iP3NT/449ahWJSVR4g1Js
         6U1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749032019; x=1749636819;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEqyAryvSU2LKQBzodTUdGD1yIcQAy85U5Usnhj+zA4=;
        b=CE4rAka7KdlQJxoEK+uhONcbIqr2VriJThmkYelTe9btKYCmNvDiDE6q0Bey83Ks+z
         FqdpFa4J9PhbepWX7+guMB+tndOKDZZO3ksZ/InCLDb9WOJlZJYE+YtWcUfy7XyfsKOP
         B2RIt1dxRl+TvH8mnkbTNm9roLG5dWXD6mj8ftkG1oqN9MIdV8+ekHCxy1nPmwXG4elE
         d4Yz15aoASC+7oFpGBDJisVjqT+G3c+lfelJqGg6k3CkamXBJwGPA4LeEakCCrdUZDJW
         OopSdHrhCtZgWbrcaJ0ITcnInTkGI+U7/2NdeQf7EmE8/6M363aA6Gi8fILomZC+Qfhv
         Mmyg==
X-Gm-Message-State: AOJu0YxKK6A/BHpYkRjAxeFnm6/1jcJ7kmAWwhGy51aTNhHIeNuo+292
	HDATiaaXekY0oiTcpow2VXvhvXDzQ4QofW7plWxcccfpgOOT6CMURCcPmIPphkTDOaM=
X-Gm-Gg: ASbGnctZvQxDQBjOwcq7cp4XD3uguH983+vFy/9gN418IpoDbe7cQy4SmO3xQHMH8gj
	HDbZMYi0G9EW0Q4mUUyuRV7BAEwZYWXUU1oB1muWC2vQDryyAzQJDuBSZTLG12ZB9BznYDneTGB
	+HcVITKDvEgdVMUd8q0hBc9O8hH2qfh76+k8cr7fxQUtmyoW5GkUKCnJhn4sWSxfhNrfyNqYW5R
	LAVH9oHFfrIUAraf2RZL6z9GL1CMMaYvND1fPmiylouH5YJS4i/JwJE8banHoeZlJCopbW6ZrfW
	6T3NNsakx1LuPJDT+zyqnTb2q1pRnHVrUdQy3kiBHkSlq2irXh5dmqRMufnq
X-Google-Smtp-Source: AGHT+IG5/NtfpkGM+844sNqhej3Tz60hXl2jFaPYMAaR6KoOM52AUDSUkebX1AIaUxx2cnigFD1KEA==
X-Received: by 2002:a5d:588a:0:b0:3a4:d5e8:e352 with SMTP id ffacd0b85a97d-3a51d924837mr1719234f8f.7.1749032018730;
        Wed, 04 Jun 2025 03:13:38 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c9d4sm21488961f8f.38.2025.06.04.03.13.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 03:13:38 -0700 (PDT)
Message-ID: <f94936b3-024e-41e4-be8e-077d0419100c@tuxon.dev>
Date: Wed, 4 Jun 2025 13:13:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, pavel@denx.de
References: <20250603091940.3917581-1-claudiu.beznea.uj@bp.renesas.com>
 <TY7PR01MB1481886E2F4073789E4561908926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <TY7PR01MB148184237F8FF84BEAA62DC62926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <TY7PR01MB148184237F8FF84BEAA62DC62926CA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Jun 2025 10:13:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19000

Hi, Nobuhiro,

On 04.06.2025 11:27, Nobuhiro Iwamatsu via lists.cip-project.org wrote:
> Hi Claudiu,
> 
>>> Claudiu Beznea (7):
>>>   clk: renesas: r9a08g045: Add clock, reset and power domain for the
>>>     remaining SCIFs
> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/10246798017#L8834
> 
> The build fails with this patch. It cannot create dtbo from dtso file. The filename of r9a08g045s33-smarc-pmod1-type-3a.dtso needs to changed to
> r9a08g045s33-smarc-pmod1-type-3a.dts.

Apologies for that. I'll fix it and post a new version.

Thank you,
Claudiu

> 
> Best regards,
>   Nobuhiro
> 
>> -----Original Message-----
>> From: iwamatsu nobuhiro(岩松 信洋 □ＤＩＴＣ○ＣＰＴ)
>> Sent: Wednesday, June 4, 2025 3:10 PM
>> To: Claudiu <claudiu.beznea@tuxon.dev>; pavel@denx.de
>> Cc: cip-dev@lists.cip-project.org
>> Subject: RE: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
>>
>> HI all,
>>
>>> -----Original Message-----
>>> From: Claudiu <claudiu.beznea@tuxon.dev>
>>> Sent: Tuesday, June 3, 2025 6:20 PM
>>> To: iwamatsu nobuhiro(岩松 信洋 □ＤＩＴＣ○ＣＰＴ)
>>> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de
>>> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
>>> Subject: [PATCH 6.1.y-cip 0/8] RZ/G3S: Backport SCIF support
>>>
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Hi,
>>>
>>> Series backports the Renesas RZ/G3S SCIF support to v6.1.y CIP.
>>>
>>> Thank you,
>>> Claudiu Beznea
>>>
>>> Claudiu Beznea (7):
>>>   clk: renesas: r9a08g045: Add clock, reset and power domain for the
>>>     remaining SCIFs
>>>   serial: sh-sci: Update the suspend/resume support
>>>   arm64: dts: renesas: r9a08g045: Add the remaining SCIF interfaces
>>>   arm64: dts: renesas: rzg3s-smarc: Fix the debug serial alias
>>>   arm64: dts: renesas: rzg3s-smarc-switches: Add a header to describe
>>>     different switches
>>>   arm64: dts: renesas: rzg3s-smarc: Enable SCIF3
>>>   arm64: dts: renesas: r9a08g045s33-smarc-pmod: Add overlay for SCIF1
>>>
>>> Geert Uytterhoeven (1):
>>>   serial: sh-sci: Save and restore more registers
>>>
>>>  arch/arm64/boot/dts/renesas/Makefile          |  3 +
>>>  arch/arm64/boot/dts/renesas/r9a08g045.dtsi    | 90
>>> +++++++++++++++++
>>>  .../r9a08g045s33-smarc-pmod1-type-3a.dtso     | 48 ++++++++++
>>>  .../boot/dts/renesas/rzg3s-smarc-som.dtsi     | 25 +----
>>>  .../boot/dts/renesas/rzg3s-smarc-switches.h   | 40 ++++++++
>>>  arch/arm64/boot/dts/renesas/rzg3s-smarc.dtsi  | 20 +++-
>>>  drivers/clk/renesas/r9a08g045-cpg.c           | 10 ++
>>>  drivers/tty/serial/sh-sci.c                   | 96
>>> ++++++++++++++++++-
>>>  8 files changed, 305 insertions(+), 27 deletions(-)  create mode
>>> 100644
>>> arch/arm64/boot/dts/renesas/r9a08g045s33-smarc-pmod1-type-3a.dtso
>>>  create mode 100644
>> arch/arm64/boot/dts/renesas/rzg3s-smarc-switches.h
>>
>> I reviewed this series, looks good to me.
>> I can apply these, if there are no other comments.
>>
>> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>>
>> Test:
>>
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1852349697
>>
>> Best regards,
>>   Nobuhiro
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18999): https://lists.cip-project.org/g/cip-dev/message/18999
> Mute This Topic: https://lists.cip-project.org/mt/113444271/8377987
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [claudiu.beznea@tuxon.dev]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


