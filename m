Return-Path: <SRS0=MDoX=IC=lists.cip-project.org=bounce+64572+6209+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21EB7C433E0
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 14:22:00 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54EFB64F02
	for <cip-dev@archiver.kernel.org>; Thu,  4 Mar 2021 14:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54EFB64F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6209+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id UQhPYY4521723xSH2sWUBh5l; Thu, 04 Mar 2021 06:21:58 -0800
X-Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
 by mx.groups.io with SMTP id smtpd.web12.52.1614818059552960189
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Mar 2021 16:34:21 -0800
X-Received: by mail-pj1-f54.google.com with SMTP id e9so5529755pjj.0
        for <cip-dev@lists.cip-project.org>; Wed, 03 Mar 2021 16:34:19 -0800 (PST)
X-Gm-Message-State: ibFuz4HnOfijknaiUQtezLIHx4520388AA=
X-Google-Smtp-Source: ABdhPJzW+mvjlDbV/OWDlNzHzLQye3oyZsLIkId2peRm+CGvivM6ot2UGzOAyar5xp8X8XMUR4kMHpzWf2XINXX+ia8=
X-Received: by 2002:a17:90a:c201:: with SMTP id e1mr1684645pjt.30.1614818058826;
 Wed, 03 Mar 2021 16:34:18 -0800 (PST)
MIME-Version: 1.0
References: <TY2PR01MB4972737CBAC08ADD098C39BDA09E9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <CADPJy8U47sQxvLxBmAeL1xE5O7k9X1XpZFo5gS1eB5JD4q-oPQ@mail.gmail.com>
 <TY2PR01MB49727FFEB629F632BA4F3FEFA09C9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <CADPJy8WCxn77esfumUcvgGdNLQdgK5UcHdstiVg70Rarr_8X4w@mail.gmail.com>
 <TY2PR01MB497230B3FA2ED24EA4D50650A0989@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <CACe6DC7Wkn61GzKmQg2-XZeaMR4eT2=pKigNf4RVkVbSvppbrg@mail.gmail.com>
In-Reply-To: <CACe6DC7Wkn61GzKmQg2-XZeaMR4eT2=pKigNf4RVkVbSvppbrg@mail.gmail.com>
From: Hiraku Toyooka <hiraku.toyooka@miraclelinux.com>
Date: Thu, 4 Mar 2021 09:33:42 +0900
Message-ID: <CADPJy8UTJ86ZRUShjNnCZ15Pw+nOOhbG0-yt5yTAkcZbckja-g@mail.gmail.com>
Subject: Re: [cip-dev] [cip-members] [Reminder] Due date [26th Feburary]: Reference Platforms for 5.10
To: Nobuhiro Iwamatsu <iwamatsu@gmail.com>
Cc: cip-members@lists.cip-project.org, jan.kiszka@siemens.com, 
	yoshihiro.okada@cybertrust.co.jp, cip-dev@lists.cip-project.org
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="z8oekFCIboBHZu9OvSWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1614867718;
 bh=XO24UWkQBP2T9CngpWDO7Jyy4WeqonNF30QzUdmwO6Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=tx9DyYYHMbips16fwC7WtgZJs/SxMBffjVyBgOrv0dssnVZGriEgQ7NuuqYyhb+ZiQ/
 JnuFy1DTEMBaEvY+2I1KJ6FHtgb8H27wwlH44LGZI1QWQKkxE+Z2sbdRvPYT3U4h3tnVQ
 VAVmhNs4//oIQ1vAz2c1UfkACOMiZvaGMRA=

--z8oekFCIboBHZu9OvSWt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kudo-san, Iwamatsu-san,
(CC: cip-dev)

Thank you for letting me know that.
I will send MR for this config.

Best regards,
Hiraku Toyooka

On Wed, Mar 3, 2021 at 7:50 PM Nobuhiro Iwamatsu <iwamatsu@gmail.com> wrot=
e:
>
> Hi,
>
> 2021=E5=B9=B43=E6=9C=883=E6=97=A5(=E6=B0=B4) 16:37 masashi.kudo@cybertru=
st.co.jp
> <masashi.kudo@cybertrust.co.jp>:
> >
> > Hi, Toyooka-san,
> >
> > Thanks for your response.
> >
> > > > > > Also, regarding the corresponding config, please send your
> > > > > > config to cip-dev so that Iwamatsu-san can submit it.
> >
> > I would appreciate it if you can send this to cip-dev in order to trac=
k this request.
>
> or please send MR via gitlab.
>
> Best regards,
>   Nobuhiro
>
> >
> > Best regards,
> > --
> > M. Kudo
> >
> > > -----Original Message-----
> > > From: Hiraku Toyooka <hiraku.toyooka@miraclelinux.com>
> > > Sent: Wednesday, March 3, 2021 2:11 PM
> > > To: =E5=B7=A5=E8=97=A4=E3=80=80=E9=9B=85=E5=8F=B8=EF=BC=88CTJ=E3=80=
=80OSS=E4=BA=8B=E6=A5=AD=E6=8E=A8=E9=80=B2=E5=AE=A4=EF=BC=89 <masashi.kudo=
@cybertrust.co.jp>
> > > Cc: cip-members@lists.cip-project.org; jan.kiszka@siemens.com; =E5=
=B2=A1=E7=94=B0=E3=80=80=E7=BE=A9=E5=BC=98
> > > =EF=BC=88CTJ=E3=80=80OSS=E3=83=BBIoT=E4=BA=8B=E6=A5=AD=E9=83=A8=E3=
=80=80IoT=E6=8A=80=E8=A1=93=E6=9C=AC=E9=83=A8=E3=80=80=E3=82=AF=E3=83=A9=
=E3=82=A4=E3=82=A2=E3=83=B3=E3=83=88=E3=82=B5=E3=83=BC=E3=83=93=E3=82=B9=
=E9=96=8B=E7=99=BA=E9=83=A8=EF=BC=89
> > > <yoshihiro.okada@cybertrust.co.jp>
> > > Subject: Re: [Reminder] Due date [26th Feburary]: Reference Platform=
s for 5.10
> > >
> > > Hi Kudo-san,
> > >
> > > I'm sorry to have kept you waiting.
> > > We prepared the zynqmp defconfig from Cybertrust.
> > >
> > > https://gist.github.com/hiraku-wfs/80f56520369c88b5889f69cfe4c5b614
> > >
> > > If I should make a merge request to the cip-kernel-config, please le=
t me know.
> > >
> > > Best regards,
> > > Hiraku Toyooka
> > >
> > > On Sat, Feb 27, 2021 at 6:19 PM <masashi.kudo@cybertrust.co.jp> wrot=
e:
> > > >
> > > > Hi, Toyooka-san,
> > > >
> > > > Thanks very much!
> > > >
> > > > Best regards,
> > > > --
> > > > M. Kudo
> > > >
> > > > > -----Original Message-----
> > > > > From: Hiraku Toyooka <hiraku.toyooka@miraclelinux.com>
> > > > > Sent: Friday, February 26, 2021 10:43 PM
> > > > > To: =E5=B7=A5=E8=97=A4=E3=80=80=E9=9B=85=E5=8F=B8=EF=BC=88CTJ=E3=
=
=80=80OSS=E4=BA=8B=E6=A5=AD=E6=8E=A8=E9=80=B2=E5=AE=A4=EF=BC=89 <masashi.k=
udo@cybertrust.co.jp>
> > > > > Cc: cip-members@lists.cip-project.org; jan.kiszka@siemens.com; =
=E5=B2=A1=E7=94=B0=E3=80=80=E7=BE=A9
> > > =E5=BC=98
> > > > > =EF=BC=88CTJ=E3=80=80OSS=E3=83=BBIoT=E4=BA=8B=E6=A5=AD=E9=83=A8=
=E3=80=80IoT=E6=8A=80=E8=A1=93=E6=9C=AC=E9=83=A8=E3=80=80=E3=82=AF=E3=83=
=A9=E3=82=A4=E3=82=A2=E3=83=B3=E3=83=88=E3=82=B5=E3=83=BC=E3=83=93=E3=82=
=B9=E9=96=8B=E7=99=BA=E9=83=A8=EF=BC=89
> > > > > <yoshihiro.okada@cybertrust.co.jp>
> > > > > Subject: Re: [Reminder] Due date [26th Feburary]: Reference
> > > > > Platforms for 5.10
> > > > >
> > > > > Kudo-san,
> > > > >
> > > > > We'd like to propose zynqmp defconfig for zcu102. But I'm sorry,=
 we
> > > > > need more time (within 1 week) to verify cybertrust's zynqmp def=
config.
> > > > >
> > > > > By the way, in the current CIP's defconfig, we found some config=
s
> > > > > that seem to not exist in linux 5.10.
> > > > >
> > > > > https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/bl=
ob/m
> > > > > aster/5.10
> > > > > .y-cip/arm64/ctj_zynqmp_defconfig
> > > > >
> > > > > -CONFIG_SND_SOC_XILINX_DP=3Dy
> > > > > -CONFIG_XILINX_DMA_ENGINES=3Dy
> > > > > -CONFIG_XILINX_DPDMA=3Dy
> > > > > -CONFIG_XILINX_FCLK=3Dy
> > > > >
> > > > > Best regards,
> > > > > Hiraku Toyooka
> > > > >
> > > > > On Thu, Feb 25, 2021 at 11:12 AM <masashi.kudo@cybertrust.co.jp>=
 wrote:
> > > > > >
> > > > > > Hi, All,
> > > > > >
> > > > > > > Also, regarding the corresponding config, please send your
> > > > > > > config to cip-dev so that Iwamatsu-san can submit it.
> > > > > >
> > > > > > Regarding 5.10 supported boards, the deadline is tomorrow.
> > > > > > So far, I don't see any email traffics for configs in cip-dev
> > > > > > except for
> > > > > siemens_ipc227e.
> > > > > > If no configs are proposed, the boards won't be supported.
> > > > > > If you need more time, please let us know.
> > > > > >
> > > > > > Best regards,
> > > > > > --
> > > > > > M. Kudo
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: =E5=B7=A5=E8=97=A4=E3=80=80=E9=9B=85=E5=8F=B8=EF=BC=88=
CTJ=E3=80=80OSS=E4=BA=8B=E6=A5=AD=E6=8E=A8=E9=80=B2=E5=AE=A4=EF=BC=89
> > > > > > > Sent: Thursday, January 28, 2021 6:45 PM
> > > > > > > To: cip-members@lists.cip-project.org; Kiszka, Jan
> > > > > > > <jan.kiszka@siemens.com>; Hiraku Toyooka
> > > > > > > <hiraku.toyooka@miraclelinux.com>
> > > > > > > Subject: Due date [26th Feburary]: Reference Platforms for 5=
.10
> > > > > > >
> > > > > > > Hi, All,
> > > > > > >
> > > > > > > As was discussed at the last TSC call, I would like to surve=
y cip-members'
> > > > > > > intention about reference platforms for 5.10.
> > > > > > >
> > > > > > > I made a table as follows. Please fill in the corresponding
> > > > > > > blank with 'Y' and with your name so that we can know who wa=
nts it.
> > > > > > >
> > > > > > >
> > > > >
> > > https://docs.google.com/presentation/d/1wUQpFTuq96bwcMhU8kxA7oPQFyq1
> > > > > > > Yn5LCBbPWvLKB9s/edit#slide=3Did.gb470c24647_0_16
> > > > > > >
> > > > > > > Also, regarding the corresponding config, please send your
> > > > > > > config to cip-dev so that Iwamatsu-san can submit it.
> > > > > > >
> > > > > > > I would like to ask the above to be done by February 26th (F=
ri).
> > > > > > > The platforms which no one flags will be dropped from the 5.=
10 support
> > > list.
> > > > > > > If it takes more than that, please feel free to let me know.
> > > > > > >
> > > > > > > Best regards,
> > > > > > > --
> > > > > > > M. Kudo
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Hiraku Toyooka
> > > > > Cybertrust Japan Co., Ltd.
> > >
> > >
> > >
> > > --
> > > Hiraku Toyooka
> > > Cybertrust Japan Co., Ltd.
> >
> >
> >=20
> >
> >
>
>
> --
> Nobuhiro Iwamatsu



--=20
Hiraku Toyooka
Cybertrust Japan Co., Ltd.

--z8oekFCIboBHZu9OvSWt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6209): https://lists.cip-project.org/g/cip-dev/message=
/6209
Mute This Topic: https://lists.cip-project.org/mt/81077460/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--z8oekFCIboBHZu9OvSWt--
