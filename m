Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4690AC25B67
	for <webhook@archiver.kernel.org>; Thu, 26 Oct 2023 04:33:44 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web11.63476.1698294815848643306
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Oct 2023 21:33:36 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 39Q4XXZT1741340; Thu, 26 Oct 2023 13:33:33 +0900
X-Iguazu-Qid: 2yAafrZ6fvViqC5Prk
X-Iguazu-QSIG: v=2; s=0; t=1698294813; q=2yAafrZ6fvViqC5Prk; m=rjXRkrlrTSxTLgay9c1zkoHqYIP3FDUYYsq1XzTaZis=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 39Q4XVaK3498701
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 26 Oct 2023 13:33:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGydO/PE72fDeEdW3uNyzSd3HQuDMBCssyv+f+daPVEL2uT/sSyoFOEybpP4FK9mDIMPI8soMXeyzTu8w0eRbdZEIDW8WBl3vjX8tQLp3t6P8VYTzZkLm7fVfaR0Cm4oTzlyAyP2csZBi3t7Vaxb4HOV1tMwzDqhk03IZRM7XjKwAUdu5fh7VBBLvNmlnrReDuA+4EIRx1rnYt6kANzdeplZfIbf1lLEYUend6ZO/BxlSZnsdy5TbKwOf1TnBgicdzI6qYD2ndPm4q2N56onosMrdjSny1eOs1D3LcWR1DMo9YqESjLcz6GCz3KXR8NL45lkkL4KnqWEk/6DK+G/4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37ZY7wcZ12g4yVB5G/eULtxgklEKcahF0NoD14pwyw8=;
 b=IV8bX9+de7k1zknxhGyKPDF4jo5Ttr2gVG4HXAAEjJqItqnP8smVjpoxxPlh/c7L5ZkTi5RJ/04OSMFPg1DB9slNfqKTK2AD/SmrlyxEmRhRE1NHrmNIzlqYFcq8iJVi/dKxST/DXVSouujRlf6Hmk2AEyf+KWkjMUF4ZAZzCNt6I70loNuoqbBSs4PdoUEr7Or6B/oFiZVXw0JvN4ndj8iDx4oSBA8rbPvCX6IzNooYeRNl03+ToJclXRm67UnRMiRZ6n6gXbSOTGAERdKE0n4tayR6SE+yQrTbpHzjECvYm6cHtO0R6pdcXiO/12Qms18XsbEivHBYFQjYSjXtaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <Quirin.Gylstorff@siemens.com>, <jan.kiszka@siemens.com>,
        <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: Move
 packages to security-customization
Thread-Topic: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: Move
 packages to security-customization
Thread-Index: AQHaBcIELJTbwFkaOkGXJqq0MorzmbBbeRrA
Date: Thu, 26 Oct 2023 04:33:29 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB68561590E077CB11799AA56FA4DDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
References: <20231023150243.3990309-1-Quirin.Gylstorff@siemens.com>
 <20231023150243.3990309-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20231023150243.3990309-8-Quirin.Gylstorff@siemens.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6856:EE_|TYCPR01MB11042:EE_
x-ms-office365-filtering-correlation-id: 4650499f-900b-4fa5-c0bb-08dbd5dcb467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 QAcgEa+qEnjxcIwql/u5w4p5t8HTTWPhe49iW965wiNP7aJ/ELVXPsyAXVjOZPkh2uR1oWCDCNsLO5DDbggVS0RYTGh/RKN1B+mON4UlqNAFlo6MJ2t7ijnJAsqJap5kk0utFKI9sJhnzy7klfKIFG0l+MHOHrA4vuyjqMu6+bnagW1nEm9SFEmmnaQqupKPe1FBcik969mi6sID9AUyyG0PmfTmBnG/C3fOfWo1yYFNejSaBXaDuLFhzeiNkNqusx8WoUCCG9dPxEUjun4z/448UTCiGeRlKnby89/gsSWFt5DoVKoA5B6e1bmDCNBkztLemf+vdXLc8Rqdc/IXbPW3iPqbkEXNBqj9JLXY/nlt8lxJ6OWdZJH9nF7Iq3F2aPzxpst5SGO4OpoFufpGJMurAF84dCnk0+tFUMrj03SlGFYQGy9+uABrbSAzqjI8Rm8cEfuYrpihUOv/pAAAPGwFYvj1gmv6GkHJNVrkaZHJqVaZNJMh0TRemA1yxd7psNQPEBTfxLRuYR5th94PmE+GV7RUvSnguqk9JoSthpf8rtZvlVbCY/xrmwfkCaamYKb8pSlvFTm5XXdZrjpNZlZgd/lFhjMbMgkf/zB2pSlzJmrF/MKkBGEQe2lM+rVm
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6856.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(26005)(122000001)(38070700009)(38100700002)(5660300002)(83380400001)(55016003)(41300700001)(76116006)(110136005)(66556008)(66476007)(66446008)(64756008)(66946007)(8936002)(478600001)(6506007)(2906002)(316002)(86362001)(33656002)(15650500001)(71200400001)(53546011)(7696005)(52536014)(8676002)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?b1h6QWRjbnE4ejhEc1lEb3ZvY0JMcFlVUVl5MUhwNHJCSnQ5WjBXV1JV?=
 =?iso-2022-jp?B?cjIyMW9HSm05YStWMXVRODM5SFBYOHphVUhrdXdDMmZNU3pOc0h6SVk5?=
 =?iso-2022-jp?B?NC9pcEFRYVU2SjBQNkp0bUNhVWFMQUFQTENld1JpcjliYkhVQkNoUmZ4?=
 =?iso-2022-jp?B?bW9YZytVWnd4TUpvTXovbWNvVEFJcTZ2SHF0NnJPNGJYQXlRK2FtL08z?=
 =?iso-2022-jp?B?ZXl4QUlqRE5HbE5SdE95S2RxdzdJdmIxTUtuRlZibU9qSUxINlJyN2xv?=
 =?iso-2022-jp?B?TmQxYWhXVmdaRWcyZU1GSkgzeVZKcTZpNk9jL1J5ZmJ2SjZSQVpYYWFS?=
 =?iso-2022-jp?B?R3FSc2xMR0l3R2d3NVcyMmM4MFd4d09jMXAyRlBjOHJ0cnBlM2ZkbHlY?=
 =?iso-2022-jp?B?ZHAxSCtDaGsvY1VqTlFEZ29ETU92S0FGSlBwZzBZK2dNQXpBbWg5b3cx?=
 =?iso-2022-jp?B?ZXJmaGhSclZjdzBta3d3WkhZVUZENHhOV29qQk1PR0dKZzNteGQwU24w?=
 =?iso-2022-jp?B?c0QvY1N5RWRRMUVMeXloRGFwZDdVOWlTMlhEUnpSUTRINFpEVVFmZkV3?=
 =?iso-2022-jp?B?QU04MkpDY3pDcHM3MzZQSU02Vi9GUlh0alJGQllWZVVaRnlRano4cWJC?=
 =?iso-2022-jp?B?VDgzVzBDb0VCdk5YNWxUemxVVnYySTNIZXk1VDJkSzFvWU5icEtFNUNV?=
 =?iso-2022-jp?B?ejBkdUJieEpvWE4zUnMwQlYzdnpMcUtmczhhMlBVOVZwa254Q2FCUXZm?=
 =?iso-2022-jp?B?TTBGSld3RHVldFVoZk1wVFlaUGY4WlhhRkZIeVVPTS83NndHaFRoZXgx?=
 =?iso-2022-jp?B?TURzTmlvR1M5UytpcDgvdndpZHI1Q1pJYUR4T2JLUjRESC8rdkhEZW9s?=
 =?iso-2022-jp?B?Z29MU00vZENpRnB4YzdBOE1kekJuZjF0L3pxUyszWGpqdmhpZ0lSTm9t?=
 =?iso-2022-jp?B?WVZSSmlvSXZvdnE3WVo1MEZSSk1sc3A4TFpLYzZXbzRDSUY5dG9ObEZB?=
 =?iso-2022-jp?B?M1FyZm95Mnh5aGxsL0ZnQVNXZDV4dTJ4L1R2b0hUWWFINXdjYVJWNkh6?=
 =?iso-2022-jp?B?MXR0Wk5zME5TR1hndkRycUZvdmFWcUFDU1hsY1U3ejBJUnZXdmRQcDdu?=
 =?iso-2022-jp?B?M0FML0VsNmNvUDl6ZS96bGswUlNCMmFndXBKOWJ0Q283NFQ3R1lGaU9s?=
 =?iso-2022-jp?B?Y00zYklMRmdsZGdpcmlNdDJhL05WWEdHcVN5R2c2TkxWdHdwbEhjMGZZ?=
 =?iso-2022-jp?B?ZTJ1bkFGNkpVSXg5bGpXL0JkYWxHbGo2VmJqNlRYeFNxcGMxWk1HQmZQ?=
 =?iso-2022-jp?B?U2FmT2pqbCtlTU9UaUt3UlRjbFh6bUZBZWMxRTFISFlMK3pKaks0K0xO?=
 =?iso-2022-jp?B?Y3RBZ3lpNkJ5OVI2cWJHRU50ZEorOXk4dWtkOGdJQWxITi9CQWtxeXU5?=
 =?iso-2022-jp?B?S1BnRmluNnNlb0d1dWlsRFV0WTRpejl6czI5L1N0QjZJRnU2STZPdU1u?=
 =?iso-2022-jp?B?MW4wWFoyOUpaajhFMkNnczJvT3VvK3JsWVhVRkgrOGl3ckdKbXJGa3BP?=
 =?iso-2022-jp?B?b25LRU9mYThCeEpWZllrWVE1enJVWGRWTkdGQnVMeUV0N2hIWU1Fdkxk?=
 =?iso-2022-jp?B?NG5MT25ZN2s2b0luN1pzQW5iM2p3RkpxdDRveE5wY3cyQmhLamFYWXU0?=
 =?iso-2022-jp?B?YVBacndBc25kNzVmaTlJdUhCYzRVLzNrN0dacnRjNTF3Zk5vZ0VoRi9I?=
 =?iso-2022-jp?B?blRmQTFLSHlKeEUvRG5GWVdxR2dzb2VBZW90SDRNRUxTM1FoNU05c2xj?=
 =?iso-2022-jp?B?Yjg0YmNObGZ3d0R4MjE4WUE4TUx3MWxadEJLSmVEdFB1QjY2dkRKZXdT?=
 =?iso-2022-jp?B?MWpNMXoyL2xvVjZLNVpzZnJxaTdMVXFXeTlOV1R6U0RWUnp3TWVkZ29n?=
 =?iso-2022-jp?B?NDg1b3RPVlBOeGd3WDllQWdTZEZBSERCNFVrZjRKeHE3U1JSVk9KcmUz?=
 =?iso-2022-jp?B?ZTBwWFBkTzU3VDNGTks1bVAwa0VTeUZVVWlxYjgxRnN4cjE1Y3hxMmYy?=
 =?iso-2022-jp?B?M1NaeFBmYXFyd1FuQnBlT2tUWHZiZFB3TnZST0JCbHErc3pKc3lneDRt?=
 =?iso-2022-jp?B?dEtiV3A4Z0NFUE4zUG0xZ0M1Y1ZPb1YzdjlzT01aaVc3bkxsQlh3d1lM?=
 =?iso-2022-jp?B?QklveGlqdmViUDRodE0raU9OT1FYZ2FEekdVNVc2YVVWSURtYWx5d1Zh?=
 =?iso-2022-jp?B?VTkzUUJDdC8xamRpL1NNaysvN0Yyc2JDcmxmdzhOeGJEaUt4VkZ1MW9R?=
 =?iso-2022-jp?B?MEI0d0FCSEpqd1BqMitZYkw3eldWdWtBVUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6856.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4650499f-900b-4fa5-c0bb-08dbd5dcb467
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 04:33:29.9326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fW09E4Al7CRXlLyZ1v1mYLS/C17I51b8zM37s5NZWUagwFXc37ghQWVbMHUl5sqJibnGE86R21E3xqqmgfk7vabxl9i0fENpb5jWa0Xt9mY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11042
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 26 Oct 2023 04:33:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13454



> -----Original Message-----
> From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
> Sent: Monday, October 23, 2023 8:30 PM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org; pyla
> venkata(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Venkata.Pyla@toshiba-tsip.=
com>;
> dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-
> tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =
=1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B)
> <kazuhiro3.hayashi@toshiba.co.jp>
> Subject: [cip-dev][isar-cip-core][RFC 7/9] cip-core-image-security: Move
> packages to security-customization
>=20
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> To ensure that the package security-customizations is installable move
> packages from cip-core-image-security as dependencies to security-paackge=
s.

Thanks for improving this, earlier the security packages are installed at o=
ne place to make sure all security packages are installed, later when the s=
ecurity configurations are added, the dependencies are not added.

With this patch the dependencies are well created, the security customizati=
ons for which the packages are required are added to DEBIAN_DEPENDS.
but few packages (libtss2*) which don't have any security customization are=
 also added to security-customizations dependencies, do you want to keep th=
is in security-customizations itself ?

This is to have understanding that all the security packages that have cust=
omizations are added with DEBIAN_DEPENDS in security-customizations.bb, and=
 all other security packages with no customizations are added with IMAGE_PR=
EINSTALL in cip-core-image-security.bb,=20

>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/cip-core-image-security.bb     | 12 +-----------
>  .../security-customizations.bb                     | 14 +++++++++++---
>  2 files changed, 12 insertions(+), 14 deletions(-)
>=20
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-
> core/images/cip-core-image-security.bb
> index 3421ce5..525a346 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -28,24 +28,14 @@ IMAGE_PREINSTALL +=3D " \
>  	tpm2-tools \
>  	tpm2-abrmd \
>  	acl \
> -	audispd-plugins auditd \
> +	audispd-plugins \
>  	uuid-runtime \
>  	sudo \
>  	aide-common \
> -	libpam-google-authenticator \
>  	passwd \
>  	login \
> -	libpam-runtime \
>  	util-linux \
>  "
>=20
> -# Package names based on the distro version -
> IMAGE_PREINSTALL:append:buster =3D " libtss2-esys0 \
> -                                   libpam-cracklib"
> -IMAGE_PREINSTALL:append:bullseye =3D " libtss2-esys-3.0.2-0 \
> -                                     libpam-cracklib"
> -IMAGE_PREINSTALL:append:bookworm =3D " libtss2-esys-3.0.2-0 \
> -                                     libpam-passwdqc"
> -
>  CIP_IMAGE_OPTIONS ?=3D ""
>  require ${CIP_IMAGE_OPTIONS}
> diff --git a/recipes-core/security-customizations/security-customizations=
.bb
> b/recipes-core/security-customizations/security-customizations.bb
> index d3cede8..162d2f6 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -11,14 +11,22 @@
>=20
>  inherit dpkg-raw
>=20
> -DESCRIPTION =3D "CIP Security image for IEC62443-4-2 evaluation"
> +DESCRIPTION =3D "CIP Security configuration for IEC62443-4-2 evaluation"
>=20
>  SRC_URI =3D "file://postinst \
>             file://ssh-remote-session-term.conf \
>             file://ssh-pam-remote.conf"
>=20
> -DEPENDS =3D "customizations, sshd-regen-keys"
> -DEBIAN_DEPENDS =3D "customizations , sshd-regen-keys, libpam-google-
> authenticator"
> +DEPENDS =3D "customizations sshd-regen-keys"
> +DEBIAN_DEPENDS =3D "customizations, sshd-regen-keys, libpam-google-
> authenticator, libpam-modules, libpam-runtime, auditd"
> +
> +# Package names based on the distro version
> +DEBIAN_DEPENDS:append:buster =3D ", libtss2-esys0, \
> +                                   libpam-cracklib"
> +DEBIAN_DEPENDS:append:bullseye =3D ", libtss2-esys-3.0.2-0, \
> +                                     libpam-cracklib"
> +DEBIAN_DEPENDS:append:bookworm =3D ", libtss2-esys-3.0.2-0, \
> +libpam-passwdqc"
>=20
>  do_install[cleandirs] +=3D "${D}/etc/ssh/sshd_config.d/"
>  do_install () {
> --
> 2.42.0


