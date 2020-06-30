Return-Path: <SRS0=gcus=AL=lists.cip-project.org=bounce+64572+4868+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFD7C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 00:26:11 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9CD720781
	for <cip-dev@archiver.kernel.org>; Tue, 30 Jun 2020 00:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="wZCAKJ//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CD720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4868+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id p5dsYY4521723xAZir2fPnWv; Mon, 29 Jun 2020 17:26:10 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.4998.1593476767573557755
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2020 17:26:09 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 05U0Q5YF024018; Tue, 30 Jun 2020 09:26:05 +0900
X-Iguazu-Qid: 34trcFcTTyFvSiYsHa
X-Iguazu-QSIG: v=2; s=0; t=1593476765; q=34trcFcTTyFvSiYsHa; m=HhVA9kT5wUCyQ6+98bsXVS0msqdzLFIh5sELCF8i9IA=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 05U0Q4nn039137;
	Tue, 30 Jun 2020 09:26:05 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 05U0Q4Ep007233;
	Tue, 30 Jun 2020 09:26:04 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 05U0Q4pC024204;
	Tue, 30 Jun 2020 09:26:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9/yB2tChbdNpR5Q9WVqP+0jZHQnF+YdJR9E19z4fHjdkawhjDRmeG5Kbx6V/OwoBLp4wGl17nTTj5V9+raNiWVPbFUOuCviromUutl7ZgokcHAfHpgcfKFCr18kiwrH5ypBPMv257oO71XxjsGWjgmlzegN8CX42PUkTdSrismrFVehFhNnf5UKdweJxcMckHDLwlmQ11AJUatgcMCiGWPuvQwknWggyBB6AK6m/s8EN7idQkd30QxK9I/rmxdF4Q2WMeinl9yEhWgVd4t5Ysl0xSBLaIYLsCJyBcFKhbpktmfncAsRO1imfEDmj5Be+thPv/2ERaYoxkCF/K45lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvgtN2dZrZgqUfICgb+4Cdr0IVnHVEsxm1VlkA8FfnM=;
 b=SKiHXCZU71TNCp3YhJzktyNb0fY8UDXNak1vzNqcKUyScv8IlqApc3to3VXtZdh4QkueLIuOxFVpz0HAlu5xN6spdnpSWsSnw6xa2rg8+asxLXr5cQgT9PAIgLnCRuzYVnOcrDGDhhyDSVyH67TKXXwFmDxwc8dECcy30U4I5qOwcbpanFGIQYlFc9XUu/lwU7MsL3WvV4SzKMojA7buNTCbFcczmP1rIszuhcZ3Zf6lgaftgvdB/hzYPT2PDeRjzFAsoGEW7s7gUGHlmIIVIbemVfY1uKMmH/IoOCgSFClyBSlW6+yhSfh4CA2+gxQUFOGdhbMNdmeNikdozkycYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <Venkata.Pyla@toshiba-tsip.com>
CC: <cip-security@lists.cip-project.org>
Subject: Re: [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sample settings to install security
Thread-Topic: [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sample
 settings to install security
Thread-Index: AdZLgw09VZScIMwHQ0+wrCRdhfQsygAI0f0AALN6tSA=
Date: Tue, 30 Jun 2020 00:26:02 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB20536DA16CE083A714433D8AD06F0@OSBPR01MB2053.jpnprd01.prod.outlook.com>
References: <3ec242c02a3948fe9194df2517cbe0ad@toshiba-tsip.com>
 <c6c696ce-2ed6-4ce8-9c02-687ffbfc206b@siemens.com>
In-Reply-To: <c6c696ce-2ed6-4ce8-9c02-687ffbfc206b@siemens.com>
Accept-Language: en-US
x-originating-ip: [103.91.184.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92cc7999-4f91-4ed4-58e2-08d81c8c2b73
x-ms-traffictypediagnostic: OSAPR01MB1681:
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr
x-microsoft-antispam-prvs: <OSAPR01MB1681A3302159AC923DD5CD5DD06F0@OSAPR01MB1681.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: M5aUKKTkgyGBI+b1ycq+DpD13/+/OlFJFIqkgesm5EWx2mKrrIRrE//3+Um3ge7YShdlhBH9OLauz1Q071Hmazywmk04164U9CtTdhHXqjuMHfsnZzjRo9OUezXCnbw1jgQK8o1sBU1dPbD9erzkM+n/KmoY4OA6ql9mNXC2wZQOPzYWu/vYXrGq1V8H6SvQUfh3LG4M31w+a+oaY6hnPF7jyMh1xbtGC2YIHTSxOkcG4fIU1c/k751jq4NYbSsRg6Yb1a+cwCApOqfWnElppokjLkOArtFfAH0X3wGE53+OsMZfad4hp0MrzzWUkCuaQENwFR5hlxn+3v+sHQvM36VUXBAhtQpHuXP96GPxLCABTKLiLiYvXC7CQwIevD4NGlWhX6Q7i6aw+FdWqITvDI7rvUQRmlsr9f6xe6swRNIpCUmcaQgCMtsQtX1NuZygRyvBow4LccElk2vSi58Hdw==
x-ms-exchange-antispam-messagedata: LicMKF34E/6l3M+KsvdocRFM9EaPoKnglUIkmDGHILE92wHjN6ZWqUDaWqCz3hKKPTXP3D88dRFzQ2e6sJH0RFpBHdeIY69+oQVF4sgEFq7MHlGU/w2g/idfaoQzSyw+EqN0HvoRQDUDN2LqyOgcQVrOb/NXrd3qR3Ylh2NXWzV9777w9RC7eDSNtNoHJrqBqxwVzhvPdYLsrFMI11oeGNbJ9uu+DLUm6rQe/lbkSsDm9ECP+Ye3LZCXBM86oEP0ASxd/QefgceOZGqVcYxiu4V0fzWKbpTKhtUlFATntM9nSTmeYMvXRENQUtcQsY8UebubYaURe6oT9P5OK6EoXbR4o1JfuVVM36LN9XJlVG/W4Vph5HOJCOBfPHF4PH66CUQqpNV9vRc9fjVnsdY4e+JUikIXwGIHPXFgegjY9BXJ+5WkyCw8zGwV+2ZtBavXAbtEEd1I7S6oJg12vTb5FDpG/N2REz5SoUMatjYXK/I=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2053.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92cc7999-4f91-4ed4-58e2-08d81c8c2b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 00:26:02.1804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S4UK8Q52mZg5EwAQU97xYxiOXJiBf6jJYmvXnDAUACyNinskxtkUBsCJ2MQkGni/nxkQ/WUwiFlpY8eOf3/oAzF/AefStJHa48U7js7R3GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1681
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: QlqS5tGLyIEx5hOEwbklqMBqx4520388AA=
Content-Type: multipart/mixed; boundary="NVUmRMsid6QbeQGTfOiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1593476770;
 bh=XjozQDr714xkh5xmdB1qlI+SKOKltCF4NeeQkTvRM3w=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=wZCAKJ///JUdCDe4sT7bIP2yNtCagbdKQ3GP68U1uSRoNVwyGCg+bvBLMzaJlernlAd
 c9MOcUAQt49p9ym3nwRziws/huICLlrmMXfDP9pdw9uyuzz1S86cJs5vfypkUhbMFKEna
 /RKM7cbjNAXCb4iYCFe1fAhzow7bZBHz1OU=

--NVUmRMsid6QbeQGTfOiT
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: cip-dev@lists.cip-project.org [mailto:cip-dev@lists.cip-project.org=
] On Behalf Of Jan Kiszka
> Sent: Friday, June 26, 2020 7:41 PM
> To: cip-dev@lists.cip-project.org; pyla venkata(=1B$B#T#S#I#P=1B(B) <Venk=
ata.Pyla@toshiba-tsip.com>
> Cc: cip-security@lists.cip-project.org
> Subject: Re: [cip-dev][isar-cip-core PATCH 1/6] opt-security.yml: Sample =
settings to install security
>=20
> On 26.06.20 08:44, venkata wrote:
> > From: Kazuhiro Hayashi
> > kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.jp
> > >
> >
>=20
> This line seems to have been mangled. It should be in line with the Signe=
d-off-by.
>=20
> > opt-security.yml: Sample settings to install security packages
> >
> > Signed-off-by: Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
> > ---
> > SECURITY.md      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
> > opt-security.yml | 34 +++++++++++++++++++++++++++++++
> > 2 files changed, 86 insertions(+)
> > create mode 100644 SECURITY.md
> > create mode 100644 opt-security.yml
> >
> > diff --git a/SECURITY.md b/SECURITY.md new file mode 100644 index
> > 0000000..a8bccc7
> > --- /dev/null
> > +++ b/SECURITY.md
> > @@ -0,0 +1,52 @@
> > +How to customize images for security features
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +This is the "temporal" document about how to create and use the CIP
> > +Core generic profile images for security feature evaluation.
> > +
> > +Official manuals
> > +----------------
> > +
> > +* isar-cip-core:
> > +https://gitlab.com/zuka0828/isar-cip-core/-/blob/master/README.md
> > +* ISAR User Manual:
> > +https://github.com/ilbers/isar/blob/master/doc/user_manual.md
> > +
> > +Assumed environment
> > +-------------------
> > +
> > +* isar-cip-core: master branch
> > +* Host: Debian 10 buster amd64
> > +    * Installed packages: `docker-ce`, `qemu-system`
> > +    * Users who does the following actions must be in the groups
> > +`docker` and `kvm`
> > +
> > +Create kas file
> > +---------------
> > +
> > +Create a kas file named `opt-security.yml` to add security settings.
>=20
> That file is added by this patch already.
>=20
> > +
> > +Add security packages to rootfs
> > +-------------------------------
> > +
> > +Set `IMAGE_PREINSTALL` to the list of packages required to enable the
> > +security features. This variable can be set through the kas file.
> > +
> > +Example:
> > +
> > +```
> > +local_conf_header:
> > +  security: |
> > +    IMAGE_PREINSTALL =3D "openssl"
> > +```
> > +
> > +Build images
> > +------------
> > +
> > +Build images for QEMU x86 64bit machine:
> > +
> > +    $ ./kas-docker --isar build
> > + kas.yml:board-qemu-amd64.yml:opt-security.yml
> > +
> > +Run on QEMU
> > +-----------
> > +
> > +Run the generated images on QEMU (x86 64bit).
> > +
> > +    $ ./start-qemu.sh amd64
> > diff --git a/opt-security.yml b/opt-security.yml new file mode 100644
> > index 0000000..7c6b39c
> > --- /dev/null
> > +++ b/opt-security.yml
> > @@ -0,0 +1,34 @@
> > +#
> > +# KAS configuration for CIP Core generic profile to enable security
> > +features # # Copyright (c) Toshiba Corporation, 2020 # # Authors:
> > +#  Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp> # #
> > +SPDX-License-Identifier: MIT #
> > +
> > +header:
> > +  version: 8
> > +
> > +local_conf_header:
> > +  security: |
> > +    # TODO: Add sudo or sudo-ldap
> > +    IMAGE_PREINSTALL =3D "\
> > +      openssl libssl1.1 \
> > +      fail2ban \
> > +      openssh-server openssh-sftp-server openssh-client \
> > +      syslog-ng-core syslog-ng-mod-journal \
> > +      aide aide-common \
> > +      libnftables0 nftables \
> > +      libpam-pkcs11 \
> > +      chrony \
> > +      tpm2-tools \
> > +      tpm2-abrmd \
> > +      libtss2-esys0 libtss2-udev \
> > +      libpam-cracklib \
> > +      acl \
> > +      libauparse0 audispd-plugins auditd \
> > +      uuid-runtime \
> > +    "
>=20
> Shouldn't we target for a security image (recipe) instead?
>=20
> General question: What is this series targeting? Seems patch 2 and 3 are =
left-overs from the development. Is this an RFC series only?
>=20
> Jan

It seems that opt-security.yaml was already removed in the security branch:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/security/iec-e=
valuation

Venkata-san: could you rebase your patches for the master branch?

For example, instead of sending one patch where you add opt-security.yaml a=
nd then another patch where you remove it (which may have happened in your =
branch, but we don't care), just send the patch that uses core-image-securi=
ty. That will make things easier to review.

Also, as we have talked in the meetings, it looks like the security layer a=
t the moment is just adding some packages but don't you need to add configu=
ration files to harden the final file system? For example, you may want to =
change the configuration of the ssh server so that passwords are not accept=
ed (only ssh keys). And the same for the rest of packages. In that case, yo=
u probably want to create a new kas-security.yaml.

Thanks,
Daniel







--NVUmRMsid6QbeQGTfOiT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4868): https://lists.cip-project.org/g/cip-dev/message=
/4868
Mute This Topic: https://lists.cip-project.org/mt/75119562/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--NVUmRMsid6QbeQGTfOiT--
