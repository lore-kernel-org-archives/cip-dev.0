Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F19C433EF
	for <webhook@archiver.kernel.org>; Fri, 19 Nov 2021 13:32:31 +0000 (UTC)
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
 by mx.groups.io with SMTP id smtpd.web12.8931.1637328750245836056
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Nov 2021 05:32:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: siemens.com, ip: 192.35.17.2, mailfrom: christian.storm@siemens.com)
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id 1AJDWRxV013434
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 14:32:28 +0100
Received: from localhost ([139.22.47.12])
	by mail3.siemens.de (8.15.2/8.15.2) with ESMTPS id 1AJDWRxY028729
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 14:32:27 +0100
Date: Fri, 19 Nov 2021 14:34:36 +0100
From: Christian Storm <christian.storm@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: Re: [cip-dev][isar-cip-core]RFC v2 9/9] swupdate: Backport patches
 from SWUpdate Master
Message-ID: <20211119133436.vlwiytmdjpomgbrv@MD1ZFJVC.ad001.siemens.net>
Mail-Followup-To: cip-dev@lists.cip-project.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87b21575-eba4-e45e-3dfd-84dd44af51de@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by thoth.sbs.de id
 1AJDWRxV013434
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Nov 2021 13:32:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6961

> >>> Backport the following patches to detect the correct partition to
> >>> update.
> >>> 388f1777 util: Add get_root source /proc/self/mountinfo
> >>> 3914d2b7 util: Extend get_root to find LUKS devices
> >>
> >> Why not upgrade to a newer version of SWUpdate instead of backportin=
g
> >> stuff? There's no real advantage to stay on a "release" as SWUpdate
> >> follows rolling releases -- granted, you have to do the qualificatio=
n
> >> but that applies to "releases" as well...
> >>
> >=20
> > The build of SWUpdate uses dpkg-gbp to follow the Debian build of
> > SWUpdate with sources from [1].
> >=20
> > As Debian only follows fixed release , currently 2021.04, I patched t=
he
> > version.
> > This patchset is no longer necessary after Debian uses the next Relea=
se
> > SWUpdate version.
> >=20
>=20
> I agree that a single backport is better in this case. But as 2021.11 i=
s
> to appear soon, it may resolve this automatically for v3 already.

The old version doesn't give you any advantage as there's nothing that
qualifies a "release" that other shas don't give you, except that it's
tagged at some point in time as "release". But sticking to Debian's
recipes is of course beneficial from a maintenance perspective as long
as the patch queue to be put on top is not too large....


Kind regards,
   Christian

--=20
Dr. Christian Storm
Siemens AG, Technology, T RDA IOT SES-DE
Otto-Hahn-Ring 6, 81739 M=FCnchen, Germany

