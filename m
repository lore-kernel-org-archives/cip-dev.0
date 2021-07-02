Return-Path: <SRS0=qBo9=L2=lists.cip-project.org=bounce+64572+6591+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BBEC11F67
	for <cip-dev@archiver.kernel.org>; Fri,  2 Jul 2021 00:11:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8E46135C
	for <cip-dev@archiver.kernel.org>; Fri,  2 Jul 2021 00:11:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8E46135C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=miraclelinux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6591+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hZa0YY4521723xHLQQYtYH0M; Thu, 01 Jul 2021 17:11:47 -0700
X-Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
 by mx.groups.io with SMTP id smtpd.web08.3085.1625184705983378810
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Jul 2021 17:11:47 -0700
X-Received: by mail-ot1-f50.google.com with SMTP id c12-20020a9d684c0000b029047762db628aso4416530oto.13
        for <cip-dev@lists.cip-project.org>; Thu, 01 Jul 2021 17:11:45 -0700 (PDT)
X-Gm-Message-State: SXsmrPnJ8zHcrQ9B7q1psu3Kx4520388AA=
X-Google-Smtp-Source: ABdhPJykuYXDDdpkC9Wna2cdGOSpD0taUyrYT8N6pljejz98vgWh/fwaO2hhKPZ70mB2rFA4eZDfSeSNAKqCVq08WUc=
X-Received: by 2002:a05:6830:60b:: with SMTP id w11mr2082804oti.117.1625184705306;
 Thu, 01 Jul 2021 17:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <168CAFBE1BE94C78.17502@lists.cip-project.org> <CAODzB9rLz=+TJLgR+FQ2F+1yKpJjitGMhqK4G4zVn45PcXDytg@mail.gmail.com>
 <TYAPR01MB62526A8771F8EE626C4599C392009@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB62526A8771F8EE626C4599C392009@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: =?UTF-8?B?5biC5bed5q2j576O?= <masami.ichikawa@miraclelinux.com>
Date: Fri, 2 Jul 2021 09:11:09 +0900
Message-ID: <CAODzB9rsG+K2apgVTssRsiNtDXW6wuZzjcAhMMk5PvyRoYqdow@mail.gmail.com>
Subject: Re: [cip-dev] cannot push to cip-kernel-sec repository
To: nobuhiro1.iwamatsu@toshiba.co.jp
Cc: cip-dev@lists.cip-project.org, masashi.kudo@cybertrust.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
Content-Type: multipart/mixed; boundary="7e8uJ4ZpkIayt99wDjnH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1625184707;
 bh=ZnwEPSxsJO/zfrDu/A/8aTOojnbH2wnnEPeM2BlUfwo=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=ZZaa9CCdtJh1/itxZ2ybK9QlN1QzVew/lVGQIQGPvx9S7Ll4cco/JUq7ezFcvwfXUs3
 g4gvBC/jXMeuZTL6gpWvUwv1uKpOi8VQLnuAPPKzYkxWXXHXI7ER7SQ8MuZlx6N33Kn3t
 iVn4ik1/TkqLtpKLdaAJ3y0kzst/fcnfIMY=

--7e8uJ4ZpkIayt99wDjnH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Iwamatsu-san

2021=E5=B9=B47=E6=9C=882=E6=97=A5(=E9=87=91) 8:18 <nobuhiro1.iwamatsu@tosh=
iba.co.jp>:
>
> Hi,
>
> We needed Maintainer role to push master.
> So, I update your role from Developer to Maintainer.
> Could you re-push to maseter?
>

Thank you! I could push without any errors.

> Best regards,
>   Nobuhiro
>
> > -----Original Message-----
> > From: Masami Ichikawa [mailto:masami.ichikawa@miraclelinux.com]
> > Sent: Thursday, July 1, 2021 6:26 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=
=BE =E4=BF=A1=E6=B4=8B =E2=96=A1=EF=BC=B3=EF=BC=B7=EF=BC=A3=E2=97=AF=EF=BC=
=
=A1=EF=BC=A3=EF=BC=B4) <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Cc: masashi.kudo@cybertrust.co.jp
> > Subject: Re: [cip-dev] cannot push to cip-kernel-sec repository
> >
> > Hi, Iwamatsu-san
> >
> > Would you mind taking a look it, please?
> >
> > 2021=E5=B9=B46=E6=9C=8828=E6=97=A5(=E6=9C=88) 16:53 =E5=B8=82=E5=B7=9D=
=
=E6=AD=A3=E7=BE=8E via lists.cip-project.org
> > <masami.ichikawa=3Dmiraclelinux.com@lists.cip-project.org>:
> > >
> > > Hi, Iwamatsu-san
> > >
> > > When I push commit to the cip-kernel-sec repository,  I get the foll=
owing error.
> > >
> > > masami@debian:~/cip/cip-kernel-sec$ git push -u origin master
> > > Enumerating objects: 1557, done.
> > > Counting objects: 100% (1557/1557), done.
> > > Delta compression using up to 2 threads
> > > Compressing objects: 100% (811/811), done.
> > > Writing objects: 100% (811/811), 186.14 KiB | 6.89 MiB/s, done.
> > > Total 811 (delta 742), reused 0 (delta 0)
> > > remote: Resolving deltas: 100% (742/742), completed with 741 local o=
bjects.
> > > remote: GitLab: You are not allowed to push code to protected branch=
es
> > > on this project.
> > > To gitlab.com:cip-project/cip-kernel/cip-kernel-sec.git
> > >  ! [remote rejected] master -> master (pre-receive hook declined)
> > >
> > > It looks like I don't have permission to push the master branch.
> > > Would you mind giving me permission to push, please?
> > >
> > > Regards,
> > >
> > > --
> > > Masami Ichikawa
> > > Cybertrust Japan Co., Ltd.
> > >
> > > Email :masami.ichikawa@cybertrust.co.jp
> > >           :masami.ichikawa@miraclelinux.com
> > >
> > >=20
> > >
> >
> > Regards,
> > --
> > Masami Ichikawa
> > Cybertrust Japan Co., Ltd.
> >
> > Email :masami.ichikawa@cybertrust.co.jp
> >           :masami.ichikawa@miraclelinux.com


Regards,
--=20
Masami Ichikawa
Cybertrust Japan Co., Ltd.

Email :masami.ichikawa@cybertrust.co.jp
          :masami.ichikawa@miraclelinux.com

--7e8uJ4ZpkIayt99wDjnH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6591): https://lists.cip-project.org/g/cip-dev/message=
/6591
Mute This Topic: https://lists.cip-project.org/mt/83840144/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--7e8uJ4ZpkIayt99wDjnH--
