Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FC7C433EF
	for <webhook@archiver.kernel.org>; Fri, 24 Jun 2022 05:14:25 +0000 (UTC)
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
 by mx.groups.io with SMTP id smtpd.web10.4070.1656047654896799869
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jun 2022 22:14:15 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.252, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.92,218,1650960000";
   d="scan'208";a="77785746"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa4.mentor.iphmx.com with ESMTP; 23 Jun 2022 21:14:11 -0800
IronPort-SDR: 
 IV0/9XpDu9K9O8IPxjTbYyJuNyAJLHMWI0pdT8Pkp9WmV/wssu415S/7JOUJk6XbppZAmqzKGM
 yGz0/UZA0td5LTngS+aCWGh8IOymJOsd2sxV0iYVOU09UUcYiOZ6Qu81zXgHoY5aXJPVZnPzBu
 ExbQ9TkjpsV35KVDtA8qxAciHH63J/COdrJko6xDB9OksaOYvLBUSbslJz7RBXjDfV/2OI5BWo
 nqZfXCexFO7s4A3AYKbgwtfngDGqk/vG/PGnahbfLHSNZ9Obs95gmxfW4Qm2oUtr27RTEIKq7f
 KL0=
From: "Kanagarajan, Vijaikumar" <Vijaikumar_Kanagarajan@mentor.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: How to increase the size of the rootfs in the isar-cip-core image
Thread-Topic: How to increase the size of the rootfs in the isar-cip-core
 image
Thread-Index: AdiHLEE60rWXvhuPQIiktp+GultvCgAXCMZg
Date: Fri, 24 Jun 2022 05:14:08 +0000
Message-ID: <72b772df9e9842c38814b902671d88d3@mentor.com>
References: 
 <OSYPR01MB5542D88313015EC03720450DA4B59@OSYPR01MB5542.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSYPR01MB5542D88313015EC03720450DA4B59@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.34.91.1]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Jun 2022 05:14:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8588



From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Beha=
lf Of Venkata Pyla
Sent: 23 June 2022 23:46
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] How to increase the size of the rootfs in the isar-cip-c=
ore image

Hi,
=A0
For my experiment, I am trying to increase the rootfs size in isar-cip-core=
 image, but I am unable to do.
=A0
I have tried the below variables but no luck:
=A0
+local_conf_header:
+=A0=A0=A0 rootfs-image: |
+=A0=A0=A0=A0=A0=A0=A0 IMAGE_ROOTFS_SIZE =3D "8392704"
+=A0=A0=A0=A0=A0=A0=A0 IMAGE_OVERHEAD_FACTOR =3D "1.0"
=A0
and also below variable is not helpful.
+=A0=A0=A0=A0=A0=A0 =A0IMAGE_ROOTFS_EXTRA_SPACE =3D "8392704"
=A0
Could anyone guide me how to do this.=20

Hi Venkata,

Can you try setting ROOTFS_EXTRA? Units are in MB.

https://github.com/ilbers/isar/blob/1000df8e98b9a5849a7897698039687fd0cdd7d=
3/meta/classes/image.bbclass#L88

Thanks,
Vijai Kumar K


Thanks for your help.
=A0
Venkata.

