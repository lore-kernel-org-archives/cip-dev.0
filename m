Return-Path: <SRS0=fgwH=7R=lists.cip-project.org=bounce+64572+4692+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC42C433DF
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:55:09 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959212072E
	for <cip-dev@archiver.kernel.org>; Thu,  4 Jun 2020 06:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="iVgyME87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959212072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4692+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cZgJYY4521723xjGIChTuNFI; Wed, 03 Jun 2020 23:55:08 -0700
X-Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
 by mx.groups.io with SMTP id smtpd.web10.8795.1591253706774071554
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Jun 2020 23:55:07 -0700
X-Received: by mail-lf1-f68.google.com with SMTP id x27so2876670lfg.9
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2020 23:55:06 -0700 (PDT)
X-Gm-Message-State: RSnznPd4ZwOCELZRzwAefvDhx4520388AA=
X-Google-Smtp-Source: ABdhPJyNCEgFwz6afCZ+wr85Jx+pNMSvAjx6SvprCAyt4BoUlxNYan7dCMN9mXRecrvwWo1agVEOmQ==
X-Received: by 2002:a05:6512:2ed:: with SMTP id m13mr1655280lfq.43.1591253704587;
        Wed, 03 Jun 2020 23:55:04 -0700 (PDT)
X-Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id n14sm1243077lfi.97.2020.06.03.23.55.04
        for <cip-dev@lists.cip-project.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 23:55:04 -0700 (PDT)
X-Received: by mail-lj1-f170.google.com with SMTP id s1so5905906ljo.0
        for <cip-dev@lists.cip-project.org>; Wed, 03 Jun 2020 23:55:04 -0700 (PDT)
X-Received: by 2002:a2e:9246:: with SMTP id v6mr1438780ljg.47.1591253704011;
 Wed, 03 Jun 2020 23:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200604041745.28886-1-wens@csie.org> <20200604041745.28886-11-wens@csie.org>
 <OSBPR01MB2983010E7127D8E9E981397792890@OSBPR01MB2983.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB2983010E7127D8E9E981397792890@OSBPR01MB2983.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai (Moxa)" <wens@csie.org>
Date: Thu, 4 Jun 2020 14:54:54 +0800
X-Gmail-Original-Message-ID: <CAGb2v65s0fFj__bSbrGfBFULH+bCKN6hRT7GbwkayAocoscf5w@mail.gmail.com>
Message-ID: <CAGb2v65s0fFj__bSbrGfBFULH+bCKN6hRT7GbwkayAocoscf5w@mail.gmail.com>
Subject: Re: [cip-dev] [PATCH RESEND 4.4.y-cip 10/15] PM / OPP: Set cpu_dev->id in cpumask first
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org, 
	=?UTF-8?B?Sm9obnNvbiBDSCBDaGVuICjpmbPmmK3li7Mp?= <JohnsonCH.Chen@moxa.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="zOkhl9YHpps9MMlE1nXB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1591253708;
 bh=oVP450ILRt0p9vOP66x/u7f/8jVYx28PGWhW0PAREyU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=iVgyME87Ef9bzdR7Zvzy2TqSIrZ4VlP1sRIExYXcwtzginvKETbunDXIoKFDPu7gvnl
 KPpz2kzQOn8iG5raVjDYEWOR5MUFo14Ju9Y3G153/sivy4ZznI0JP4gMlP4ksj8xNqfvS
 fHT9EPF+C4APQkDXY00r+4WcZ1O+P+D/GyI=

--zOkhl9YHpps9MMlE1nXB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2020 at 2:43 PM <nobuhiro1.iwamatsu@toshiba.co.jp> wrote:
>
> Hi,
>
> > -----Original Message-----
> > From: Chen-Yu Tsai (Moxa) [mailto:wens@csie.org]
> > Sent: Thursday, June 4, 2020 1:18 PM
> > To: iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=
=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=A1=EF=BC=A3=EF=BC=B4) <nobuhiro1=
.iwamatsu@toshiba.co.jp>; pavel@denx.de
> > Cc: cip-dev@lists.cip-project.org; JohnsonCH.Chen@moxa.com
> > Subject: [PATCH RESEND 4.4.y-cip 10/15] PM / OPP: Set cpu_dev->id in cp=
umask first
> >
> > From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> >
> > Set cpu_dev->id in cpumask first when setting up cpumask for CPUs that
> > share the same OPP table. This might be helpful when handling cpumask
> > without the original CPU bitfield set.
> >
> > Signed-off-by: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> You forgot adding your signed-off-by tag and upstream commit id.

Oops...

FWIW, this is commit d9de19b1cc013433ad293365b5b3902ec73dfd60 upstream.

Signed-off-by: Chen-Yu Tsai (Moxa) <wens@csie.org>

Will resend after a round of reviews.

ChenYu


> Best regards,
>   Nobuhiro
>
> > ---
> >  drivers/base/power/opp/cpu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.=
c
> > index 1a2e8f260b060..a0db8b3575f38 100644
> > --- a/drivers/base/power/opp/cpu.c
> > +++ b/drivers/base/power/opp/cpu.c
> > @@ -218,7 +218,6 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
> >  /*
> >   * Works only for OPP v2 bindings.
> >   *
> > - * cpumask should be already set to mask of cpu_dev->id.
> >   * Returns -ENOENT if operating-points-v2 bindings aren't supported.
> >   */
> >  int dev_pm_opp_of_get_sharing_cpus(struct device *cpu_dev, cpumask_var=
_t cpumask)
> > @@ -234,6 +233,8 @@ int dev_pm_opp_of_get_sharing_cpus(struct device *c=
pu_dev, cpumask_var_t cpumask
> >               return -ENOENT;
> >       }
> >
> > +     cpumask_set_cpu(cpu_dev->id, cpumask);
> > +
> >       /* OPPs are shared ? */
> >       if (!of_property_read_bool(np, "opp-shared"))
> >               goto put_cpu_node;
> > --
> > 2.27.0.rc0
>

--zOkhl9YHpps9MMlE1nXB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4692): https://lists.cip-project.org/g/cip-dev/message=
/4692
Mute This Topic: https://lists.cip-project.org/mt/74665640/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--zOkhl9YHpps9MMlE1nXB--
