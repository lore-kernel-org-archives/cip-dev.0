Return-Path: <SRS0=t3iT=7J=lists.cip-project.org=bounce+64572+4649+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186A9C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 09:42:06 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8F472075A
	for <cip-dev@archiver.kernel.org>; Wed, 27 May 2020 09:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bDp1VsAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F472075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4649+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Ou3vYY4521723xScKT8iKtKY; Wed, 27 May 2020 02:42:05 -0700
X-Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by mx.groups.io with SMTP id smtpd.web12.2819.1590572524654983741
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2020 02:42:04 -0700
X-Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id D1D3420888
	for <cip-dev@lists.cip-project.org>; Wed, 27 May 2020 09:42:03 +0000 (UTC)
X-Received: by mail-lf1-f41.google.com with SMTP id 202so14075727lfe.5
        for <cip-dev@lists.cip-project.org>; Wed, 27 May 2020 02:42:03 -0700 (PDT)
X-Gm-Message-State: m9BJBS061R3JE3E0SMtXG72cx4520388AA=
X-Google-Smtp-Source: ABdhPJzb/Ly4ljZwqSTNHf0gq9pQgycsw74VML3srhYSzpzy5PXaYsu+hDRTCRUkB6tZMX9lsEV3H99BUVvI2T0SbD0=
X-Received: by 2002:a19:cb05:: with SMTP id b5mr2701381lfg.108.1590572521907;
 Wed, 27 May 2020 02:42:01 -0700 (PDT)
MIME-Version: 1.0
References: <TY2PR01MB497299162A4205C540691913A0B70@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <TY2PR01MB497220F7BDB51660FF9B221FA0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
 <e6529e13-4bb7-1105-9bc8-f84bc0b3132f@siemens.com> <TY2PR01MB4972ECA4D0B47CE664EFB2F8A0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
In-Reply-To: <TY2PR01MB4972ECA4D0B47CE664EFB2F8A0B10@TY2PR01MB4972.jpnprd01.prod.outlook.com>
From: "Chen-Yu Tsai" <wens@kernel.org>
Date: Wed, 27 May 2020 17:41:49 +0800
X-Gmail-Original-Message-ID: <CAGb2v64EEec7JfOVLOJY05SxStz0PK3QbcqtobfXvo98FgSAVA@mail.gmail.com>
Message-ID: <CAGb2v64EEec7JfOVLOJY05SxStz0PK3QbcqtobfXvo98FgSAVA@mail.gmail.com>
Subject: Re: [cip-dev] FW: Needs of security patches on reference platforms
To: cip-dev@lists.cip-project.org, Jan Kiszka <jan.kiszka@siemens.com>
Cc: hiroshi.mine.vd@hitachi.com
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="Zax8U1n9bL5mkGkw7ZIR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1590572525;
 bh=FwCN5wLektkK2eKFSV1VTkCkT+r7ICEFHM2kak6pMUs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bDp1VsAcsp0LNyiDEwMIM3485zdQ/iAl9+sg010UKgcdMzA4/Vq9eD8dMIfTxFFx5A/
 1KSAkYlcfryK4fQdLLb6LXlIjoBUKhXEf0b2Fh3URIzvGHIu1K6nsc+oRDvnXTBO3/CGZ
 6+VNcCXQ9U6r6B7HcPE1g0wyLnQI+3iUiFI=

--Zax8U1n9bL5mkGkw7ZIR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jan,

On Wed, May 27, 2020 at 5:15 PM masashi.kudo@cybertrust.co.jp
<masashi.kudo@cybertrust.co.jp> wrote:
>
> Hi, Jan-san,
>
> Thanks very much for your comments and pointers.
>
> > Why did not stable pick them up? Because they require active backporti=
ng work to make them apply?
>
> Can anybody from Kernel Team respond to this?
>
> > >  a. CVE related to KVM SVM on x86,
> (snip)
> > That said, I'm not aware of active use on our side at this point, but =
I may not have the full overview, and I can't speak for other members.

This was not CC-ed to stable, and neither did Sasha's bot pick it up.

Ben has requested its inclusion in 4.19 and 5.4, and it is in this
week's stable review bunch from Greg.

> Thanks for your comment.
>
> CIP-Members,
> Please speak up if you need this patch. Otherwise, we will *NOT* backpor=
t the patch.
>
> > >  b. XDP sockets enabled for Cyclone V
> (snip)
> > XDP plays an essential role in deterministic networking, thus is absol=
utely an embedded thing as well. But that usually goes along with TSN, thou=
gh it may not be limited to it.
> > For the Cyclone V, you likely need to ask the config contributor for t=
he concrete background.
>
> Thanks for your comment and a pointer.

The fix for this is already in stable kernels. This feature is relatively =
new
and so I was wondering what the use-cases were in CIP, given that the feat=
ure
was touted mainly by web technology companies, such as Facebook and Cloudf=
lare.
(Or maybe that's due to my sysadmin background.)


Regards
ChenYu


> CIP-Members, (or maybe Mine-san?)
> Please speak up if you use XDP on Cyclone V. Otherwise, we will *NOT* ba=
ckport the patch.
>
> Best regards,
> --
> M. Kudo
>
> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Wednesday, May 27, 2020 5:56 PM
> To: =E5=B7=A5=E8=97=A4=E3=80=80=E9=9B=85=E5=8F=B8=EF=BC=88CTJ=E3=80=80OS=
S=E4=BA=8B=E6=A5=AD=E6=8E=A8=E9=80=B2=E5=AE=A4=EF=BC=89 <masashi.kudo@cyber=
trust.co.jp>; cip-dev <cip-dev@lists.cip-project.org>
> Subject: Re: FW: Needs of security patches on reference platforms
>
> Hi Kudo-san,
>
> On 27.05.20 10:34, masashi.kudo@cybertrust.co.jp wrote:
> > Hello, Jan-san,
> >
> > I wonder whether you can respond to the following query.
> > If you know an appropriate person to answer the below, I would appreci=
ate it if you can point him/her.
>
> Just CC me on the list. I'm not receiving all emails of the list directl=
y.
>
> >
> > Best regards,
> > --
> > M. Kudo
> >
> > -----Original Message-----
> > From: =E5=B7=A5=E8=97=A4=E3=80=80=E9=9B=85=E5=8F=B8=EF=BC=88CTJ=E3=80=
=80OSS=E4=BA=8B=E6=A5=AD=E6=8E=A8=E9=80=B2=E5=AE=A4=EF=BC=89
> > Sent: Thursday, May 21, 2020 9:52 AM
> > To: cip-dev@lists.cip-project.org
> > Subject: Needs of security patches on reference platforms
> >
> > Hi, board owners,
> >
> > At the IRC meeting (May 14th), the following two security patches were=
 discussed.
> >
> >  a. CVE related to KVM SVM on x86,
> >  b. XDP sockets enabled for Cyclone V
> >
> > They were recently ported to upstream, and we would like to decide whe=
ther they should be backported to CIP or not.
>
> Why did not stable pick them up? Because they require active backporting=
 work to make them apply?
>
> >
> > Regarding a., SVM is for AMD CPUs only, so it might not actually be us=
ed.
> > If it is the case, we would like to ignore this patch.
>
> In general, KVM on AMD was surely a niche over the past years. Since Ryz=
en, this changed again, also for embedded.
>
> That said, I'm not aware of active use on our side at this point, but I =
may not have the full overview, and I can't speak for other members.
>
> >
> > Regarding b., XDP (express data path) is used for network intensive wo=
rkloads to bypass certain parts of the network stack So, it may be used by =
big tech / web stuff, not embedded.
>
> XDP plays an essential role in deterministic networking, thus is absolut=
ely an embedded thing as well. But that usually goes along with TSN, though=
 it may not be limited to it.
>
> For the Cyclone V, you likely need to ask the config contributor for the=
 concrete background.
>
> Jan
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE Corporate Competence=
 Center Embedded Linux
>=20

--Zax8U1n9bL5mkGkw7ZIR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4649): https://lists.cip-project.org/g/cip-dev/message=
/4649
Mute This Topic: https://lists.cip-project.org/mt/74496040/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Zax8U1n9bL5mkGkw7ZIR--
