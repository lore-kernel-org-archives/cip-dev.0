Return-Path: <SRS0=2lLH=CE=lists.cip-project.org=bounce+64572+5259+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FADC433E8
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802902087C
	for <cip-dev@archiver.kernel.org>; Wed, 26 Aug 2020 11:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="dkHkkXIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802902087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5259+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 69ArYY4521723xtU7uwjknyZ; Wed, 26 Aug 2020 04:35:16 -0700
X-Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
 by mx.groups.io with SMTP id smtpd.web12.8420.1598431542068274731
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2020 01:45:42 -0700
X-Received: by mail-lj1-f173.google.com with SMTP id g6so1384652ljn.11
        for <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2020 01:45:41 -0700 (PDT)
X-Gm-Message-State: my2NsNshY4CSuLxzJfWCMKRZx4520388AA=
X-Google-Smtp-Source: ABdhPJwO3rQw0BYsaahxGw4M89BZNU1TGcTovDx142sLsQQ/q/J6tuaiq+5/wKVigMRX83W+ORDazA==
X-Received: by 2002:a2e:3817:: with SMTP id f23mr6119737lja.118.1598431539950;
        Wed, 26 Aug 2020 01:45:39 -0700 (PDT)
X-Received: from localhost (h-209-203.A463.priv.bahnhof.se. [155.4.209.203])
        by smtp.gmail.com with ESMTPSA id w6sm395588lfn.73.2020.08.26.01.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 01:45:39 -0700 (PDT)
Date: Wed, 26 Aug 2020 10:45:38 +0200
From: Niklas <niklas.soderlund@ragnatech.se>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Pavel Machek <pavel@denx.de>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Chris Paterson <Chris.Paterson2@renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [cip-dev] [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove temperature bound
Message-ID: <20200826084538.GL594558@oden.dyn.berto.se>
References: <20200825132156.7839-1-biju.das.jz@bp.renesas.com>
 <20200825132156.7839-3-biju.das.jz@bp.renesas.com>
 <20200826072132.GA7244@amd>
 <TYBPR01MB5309A40EDFAF9156799B296886540@TYBPR01MB5309.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <TYBPR01MB5309A40EDFAF9156799B296886540@TYBPR01MB5309.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="8I2IDN9OMzbKifOUZElG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598441716;
 bh=rKbeyHBi7+pp+3aD6fV8s2iLHuB4nAhZTU4HkLD9ZuA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=dkHkkXIrPDXYES73gj0KLjzxLPmM31djBW3fQf+R4BMDlOwd4kqfUAiKjVHT+ofTctG
 zdTG/bF5x/cbKUyA+q8s1rFP3bpwd+PX6yH/wAnry5BEMspsuereP88WvWfvsSuY+oZxs
 38YMC3hqqzV/ivK9VMOuE1DlZXofRDKcQu0=

--8I2IDN9OMzbKifOUZElG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Biju,

On 2020-08-26 07:40:46 +0000, Biju Das wrote:
> Hi Pavel,
> 
> Thanks for the feedback.
> 
> > Subject: Re: [PATCH 4.19.y-cip 02/10] thermal: rcar_gen3_thermal: Remove
> > temperature bound
> >
> > On Tue 2020-08-25 14:21:48, Biju Das wrote:
> > > From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
> > >
> > > commit 0f510a2457cbbba18a98492bab1bf540be57ebd1 upstream.
> > >
> > > The hardware manual states that the operation of the sensor is not
> > > guaranteed with temperatures above 125°C, not that the readings are
> > > invalid. Remove the bound check and try to deliver temperature
> > > readings even if we are outside the guaranteed operation range.
> >
> > I'm tempted to ask "how was this tested?" :-).
> >
> > Sometimes sensors have glitches producing very high values in normal
> > temperatures, and it such case clamping can be useful, but I'll assume your
> > sensor works ok.
> 
> Niklas,  Can you please clarify?

IIRC I was asked to remove the clamp as the hardware team had tested the 
sensors in a wider range and it was judged better to report a reading 
even if it was not guaranteed then to clamp it. I have not been able 
myself to test this change myself and rely on the report from the 
hardware team.

> 
> Cheers,
> Biju
> 
> 
> 
> >
> > > +++ b/drivers/thermal/rcar_gen3_thermal.c
> > > @@ -182,9 +182,7 @@ static int rcar_gen3_thermal_get_temp(void
> > *devdata, int *temp)
> > >  tsc->coef.a2);
> > >  mcelsius = FIXPT_TO_MCELSIUS(val);
> > >
> > > -/* Make sure we are inside specifications */
> > > -if ((mcelsius < MCELSIUS(-40)) || (mcelsius > MCELSIUS(125)))
> > > -return -EIO;
> > > +/* Guaranteed operating range is -40C to 125C. */
> > >
> > >  /* Round value to device granularity setting */
> > >  *temp = rcar_gen3_thermal_round(mcelsius);
> >
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> 
> 
> Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647

-- 
Regards,
Niklas Söderlund

--8I2IDN9OMzbKifOUZElG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5259): https://lists.cip-project.org/g/cip-dev/message=
/5259
Mute This Topic: https://lists.cip-project.org/mt/76406706/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8I2IDN9OMzbKifOUZElG--
