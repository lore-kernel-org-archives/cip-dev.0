Return-Path: <SRS0=NceT=7T=lists.cip-project.org=bounce+64572+4729+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F75C433DF
	for <cip-dev@archiver.kernel.org>; Sat,  6 Jun 2020 13:48:24 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A400F2073E
	for <cip-dev@archiver.kernel.org>; Sat,  6 Jun 2020 13:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="NdbsWnOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A400F2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=moxa.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4729+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7TFqYY4521723xEccIf5jsna; Sat, 06 Jun 2020 06:48:23 -0700
X-Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com [209.85.222.68])
 by mx.groups.io with SMTP id smtpd.web10.10418.1591451300119732919
 for <cip-dev@lists.cip-project.org>;
 Sat, 06 Jun 2020 06:48:20 -0700
X-Received: by mail-ua1-f68.google.com with SMTP id b10so3130366uaf.0
        for <cip-dev@lists.cip-project.org>; Sat, 06 Jun 2020 06:48:20 -0700 (PDT)
X-Gm-Message-State: UbNQ12Qxvy826QEdtTOOCa8cx4520388AA=
X-Google-Smtp-Source: ABdhPJz6LIZjuXFTZgourE/P+U47mnwHPMPOptNoD1uuQW3yVeXWxokKoBSUCeloBjqmWDA/e0wYqA==
X-Received: by 2002:ab0:64c1:: with SMTP id j1mr11045485uaq.75.1591451298967;
        Sat, 06 Jun 2020 06:48:18 -0700 (PDT)
X-Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id t196sm151421vkb.43.2020.06.06.06.48.18
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 06:48:18 -0700 (PDT)
X-Received: by mail-vs1-f47.google.com with SMTP id r11so7222869vsj.5
        for <cip-dev@lists.cip-project.org>; Sat, 06 Jun 2020 06:48:18 -0700 (PDT)
X-Received: by 2002:a67:1006:: with SMTP id 6mr11029025vsq.126.1591451298319;
 Sat, 06 Jun 2020 06:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <HK2PR01MB32816B8BCBF222E046FE5524FA860@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
 <20200605211813.GA8852@amd> <HK2PR01MB3281A7EA2FB6A6F76A592234FA870@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
In-Reply-To: <HK2PR01MB3281A7EA2FB6A6F76A592234FA870@HK2PR01MB3281.apcprd01.prod.exchangelabs.com>
From: "SZ Lin" <sz.lin@moxa.com>
Date: Sat, 6 Jun 2020 21:48:07 +0800
X-Gmail-Original-Message-ID: <CAFk6z8OgsWsezUOtojAe0bToP7L5+dP38KKK2cU0VGox1n65VQ@mail.gmail.com>
Message-ID: <CAFk6z8OgsWsezUOtojAe0bToP7L5+dP38KKK2cU0VGox1n65VQ@mail.gmail.com>
Subject: Re: [cip-dev][PATCH 4.4.y-cip 1/2] ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
To: =?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= <JohnsonCH.Chen@moxa.com>
Cc: Pavel Machek <pavel@denx.de>, 
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>, 
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="0X5vtzXQWncBo1Omg0f6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591451303;
 bh=zwXqhZI1jz/Nkz/aRB+3htb5wPVT3/74oIxIvXLLHdE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=NdbsWnOebS07M3/riTZ2qX5MYDEeOx+OVfynzn67m/+Q3KRIY3nBvcNSyPYshhAADdS
 D1whhK4g2eL0rvtRLxrCgWg/yEK+LexzjAFXthKJGokthIuzgNl4iHuiF55bjVtztzReI
 styL8YiCfdqlbRHzDHZUIR8D8pxJTBjMA2I=

--0X5vtzXQWncBo1Omg0f6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johnson,

johnsonch.chen@moxa.com <JohnsonCH.Chen@moxa.com> =E6=96=BC 2020=E5=B9=B46=
=
=E6=9C=886=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=887:49=E5=AF=AB=E9=
=81=93=EF=BC=9A

<snip>

> Thanks your respone!
>
> I am sorry about this problem. I find the same failed situations with my=
 local part. This problem is similar to commit patch again, but I can copy =
this problem with editor's operation with Windows.

Please avoid using the editor in the Windows environment. AFAIK, some
editors in Windows OS add CRLF character to the line endings automatically=
.

SZ

>
> I apologize for your inconvenience, could I re-send correct patch series=
 again? So many thanks!
>
> > Thanks and best regards,
> >                                                                 Pavel
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> >
>
> Best regards,
> Johnson
>=20

--0X5vtzXQWncBo1Omg0f6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4729): https://lists.cip-project.org/g/cip-dev/message=
/4729
Mute This Topic: https://lists.cip-project.org/mt/74689397/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--0X5vtzXQWncBo1Omg0f6--
