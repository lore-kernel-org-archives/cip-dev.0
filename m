Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADC0C00140
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 05:04:09 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web08.38655.1660799046198273469
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Aug 2022 22:04:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 27I53wKP030132;
 Thu, 18 Aug 2022 14:03:58 +0900
X-Iguazu-Qid: 34tKqchBWzUezWZK5o
X-Iguazu-QSIG: v=2; s=0; t=1660799038; q=34tKqchBWzUezWZK5o;
 m=MP5uF/9LwQ3rt7HIbBqu2n2U+jLM7Wgy23Jj6oYzyPk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 27I53u3i027078
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 18 Aug 2022 14:03:57 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkgUsHQ3ZkXzaU8pSvv/ySbPNOK86m9wwl2g0VdaTxnRZRQrvNWvdJxbtOg++vt5EYf90SrKVnlXzbrrOYe+MP+7r9VlafTiNlFaCDZu+rhEnGUMI2PwissWFaJf3LjRyImuNpg3o/+jfLVhL93IehER4X/wT4HsVRRc5vTd4F+s9O48iOdO5UUyY+lgAlJSX8DVRArA8U//F24I/Vy28WXrDU34vD9RydJ5LdYqAekaOHA96+RXEFGg8Xdpc2jg650zJqoui17ii260QsBxNrQls+IpK33z36l3+6qDxvGMRGNBtz4Wy+PifCxFzD46fbYDk/ZZViZRSOQYhGZx7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73TsOylxjXGmyn+IkagU/7k0cMNccWTVZ8rJRGxYmaM=;
 b=dc7TtpfvqIPnpmikVlBbtG8G1W0FSPhuRnFzNdkPVqKApdIFwlvRAtAjia2+uL6j1guy0gEwh8yvZ+7Ti/9/VJ2OT1LzS/I0OrPDJsrJMnuVUsomWmLeKfxDS1aGeIw8Sv5KTX8qkzyKyqhlW3LkvxWj3NBwSzpwCgiOTKfSp31fK1LwBC0a2fedaoqtfBPxynib3Pp76V1YnrSExp4dRCXNwPxrhiA1lkq9+5IFQqyppK4O9X7yZYVtHRvYkJiFC1COMEZtZYGMXn8YSAtQQCh012bmgGGHqElkAQvhifPqURuFUcXQgzbQi34KUiYiYBUovZeBNk7x0riiodSn1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <pavel@denx.de>,
        <Chris.Paterson2@renesas.com>
CC: <tho1.nguyendat@toshiba.co.jp>
Subject: RE: [cip-dev] Root filesystem for risc-v board
Thread-Topic: [cip-dev] Root filesystem for risc-v board
Thread-Index: AQHYriStNfx8pBBSWkm9PaS5DlRMra2z+jRggAAnpuA=
Date: Thu, 18 Aug 2022 05:03:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB1013643AC251163B981EB14BCE16D9@OS3PR01MB10136.jpnprd01.prod.outlook.com>
References: <20220812082204.GA16699@duo.ucw.cz>
 <170C50D82759C5F9.6839@lists.cip-project.org>
In-Reply-To: <170C50D82759C5F9.6839@lists.cip-project.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2be336b6-2bc7-4487-9cc3-08da80d70ca9
x-ms-traffictypediagnostic: OSBPR01MB1832:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tpkeM78HrIX62SO7CV4jMuMxX3z6v8y0jv73SI8fGLa44lqLbonSN6jN+dfOqkpXwkMLTmty+DRiL8q9tgT5GxKp/wo3QcznKqURQ1kMvA/NwXV01zh7l+WlcnPaRuNMHDEpcbN4ps8vUFcwhKEXaglijKFv8RFC3rFbAw4VoPTut4QhYp11lAwfQiM7QEDuV6/YHcoVa0uyXUd1mElrI5ErsEvN+V8OdEJOF4LSG0xlQYTSI44hyA4Nu5Xo7CMdHf9/vskJg+Twj8+zZrTUUkkf2X42iVPnJ87FTIhX2OqvI8T+SqaqdS5O5D6BggVbYPMizd4+0WJRNTz46mQzzsgqD3BY+8pcpY754VlxQLrv3S+hGUBOVIITbrQaLItMOx69WU/sM6Xh2zGW+m95t4kM//Eknqe0BoBKFcsnPEwSNAc49dh3xJBdlXAxzWCclS2d13S7qgcQtb+bSDsBsu7szxKP+RaZdK0M2FBEuP2qemiHWIKh3y/erraxysV+czkKvMCZhnwvt7vAyrBxqgTg//aubJUQZ6/TEjbF6vVcQSpc5mEtqy30RmIqOm0Iy6ffK2bUDCvGZERuJ0dnzR3osCKn/61IGsa//WPxKIRuHq2JEKwwfFYmiHjH5jF8AVjJHUbXV7wGhT/sH2HymEbNSH8lG6PSuXNidXv0diH1mLneRDoIfFanrtRYMZVkqeGqiIIKIgS3ikXgX+1dDsiVOqDjFLpA2KDmvIytHodz1RXTGytjOCf3LTxlYDYqoZYKUiokHPh7I538pXuGAhKcS77+Ep+C6JiiNVM9McXWXOdKrdkLw4kDG3TULwpjaBKRGMEym8cE1IbJ6h/xeg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB10136.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(6506007)(76116006)(38070700005)(5660300002)(52536014)(316002)(41300700001)(66556008)(64756008)(110136005)(9686003)(86362001)(66476007)(4326008)(8676002)(66946007)(33656002)(7696005)(2906002)(122000001)(26005)(8936002)(53546011)(66446008)(55016003)(107886003)(186003)(83380400001)(966005)(38100700002)(478600001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?QVBMaUYwV0N2NnkvQTZvMlltbjRBZVh2OUFrTjdUMWpqU0c2bmV4Z2JW?=
 =?iso-2022-jp?B?M3pjR1FqN2QzdEErbzNJNjhIcDd1enN6ZTNjZnBOK3lrNGxCRmRROEkz?=
 =?iso-2022-jp?B?ZVRncFY1ekNTY0hTeTl4U1E5NUt6QnpkbkxYVlU1SmpKc0NSRmUzT0s3?=
 =?iso-2022-jp?B?TW55eTEycVMwQzB0MkhSS1NRdjR2QS9ZUTVCN1d0d2RMZXlHUmNvazhn?=
 =?iso-2022-jp?B?WFN6WTNxL3JxOXBvWXRWZU9XNVNvN1JzcmlMMXY5NHRUd2poY0hFNjhu?=
 =?iso-2022-jp?B?eWdXM3pRV2JHdE5hczdMd1dUaUNaMnExVjlsc25UQU1HVHBJUHFJMGkr?=
 =?iso-2022-jp?B?QkFGRU1RbHhKL2lQOVJKcjZrQWdpNktQakRzdVRJSS9NUVhEUnp6V1Bx?=
 =?iso-2022-jp?B?My8xc0wxYzcrQjRQR2NIS0VTbVFjY09FMEd2ZzQ0MjN1Q2RMb2FQeTRM?=
 =?iso-2022-jp?B?cjdVZ2k2NXc4S2tEQ1dXbDFZUlJrWXdhUWxkMStUbU5lZmY3a241WmZB?=
 =?iso-2022-jp?B?OHVseWc3MFFTUnYxVW9KZGh4Yms4bDBkT0RGWnl3OTRlTEtNZEtJaUxQ?=
 =?iso-2022-jp?B?OTA3VHhHMVI0bWQyR01tZWg4bTR6K0VnaHNHekZGY1Rmc2pJeUQ1NVpk?=
 =?iso-2022-jp?B?NWFjc29hUkR1MlMzYlBxVEZwbkFMcHdKNWtUVUw3OHU1UGNTUmtaWXZq?=
 =?iso-2022-jp?B?TVFiOXR3L21TZ0E0WlVoak1FT0FMMjlvVnp3S2UzZjZXZUF0KzAxTk5Y?=
 =?iso-2022-jp?B?aEdwVUlkWnc4ZG5oWG1iNzRIZXptc1RKN1Z0dDZJNWR6b1Z0bkhmam1Y?=
 =?iso-2022-jp?B?azVmQVF6ak9lNGlVQkNOdVBFZWVPeElnMHhPeStQbDhSZkZQMExpYkxN?=
 =?iso-2022-jp?B?c3ZldlpwejhhdUo3SmIzNlpBU0pITWNOWmdsRnphaFM4cGE2YVJqU1lF?=
 =?iso-2022-jp?B?QTAzWEFxck5iNVY0S1g1ZFcrb0tNeC9BNU54VTM2ZVJpZGFXeG16ckYz?=
 =?iso-2022-jp?B?RXJJQnVxZlVOMFhoVjh3NTk2RUd0Um5iREF3cjIrWGdCOEdKdm0xb1VG?=
 =?iso-2022-jp?B?c09CTnFOaytIcnpiZWw0WE5yWlRYdWYyeSs3V0ZCSkx1K2RjaGZXbHp6?=
 =?iso-2022-jp?B?dDgzZWRvckoyV0pSSGg3SGI0QkJwL3BLblg3cjVPSW4xb2Y5UTRWMDZt?=
 =?iso-2022-jp?B?WjdESXNwWEFWbktjVzI0RVR0SThUU1pVbkc2Z1BUUG54OFBTM0NxbWtG?=
 =?iso-2022-jp?B?SzFvTEwwMExLK1lKWXV2VUtQSXliSzlPMm9maEw4NDVVU0JMbGlzQUhU?=
 =?iso-2022-jp?B?ZW1tcGx3OW5wdTNCVVk2TSsreFJYOGR0eHFMTDVKMlRHYkFTZlU0YTd4?=
 =?iso-2022-jp?B?eis3TmZRRnd0RGNZTWVjRFJ0UGUxL0VkdmNWdEtGS0kyMzFjM1hqa3Vr?=
 =?iso-2022-jp?B?dUdNb1VRLzJJWW5lTVViSHlTNGVCdkRUVEIrSDE4OG5UUnAxN3BrSUVo?=
 =?iso-2022-jp?B?bEs4M0UyOUsxb051KzRLK3QvdThETlVydkQrRDVoWk55eHRRb0lOMmVV?=
 =?iso-2022-jp?B?UFJ1Y3hpVWEyMmVZVjcvMTZDUm4zYjhvZ1RGd08wU1RURnVnSHIzUWpD?=
 =?iso-2022-jp?B?MkpzWExLTkFBZ2JJOUE0elJzQ2d5S3VzaHcrbGg2d1RxK2dqTTZFejNI?=
 =?iso-2022-jp?B?ZmNTV2VLMFJ6QXRucDZvcnNZRWdncVNjME1jSzFQdHBOeUo0cy9UZ0Y5?=
 =?iso-2022-jp?B?OXZiUjJpRVFYWnZKdXI2dDc2ZDEwVHJWUlo1aHB0d0Z0azhFSnRQcXlB?=
 =?iso-2022-jp?B?ZU11azdBQkE5Vm9jTnZtR0RpcW5sanlaTGZHUE1ab1RKV2VKTFZlSXNP?=
 =?iso-2022-jp?B?aTVnNk8rK1E1Z3o2M3czdWpwUnNlejVhdG4zeGdTNGFhYWtXbFo2MG5H?=
 =?iso-2022-jp?B?d2pqYVVCWDF1NGJyWFJIMUpGekx5cllBZENnaWQvQUd1b3Y5NlRoOGdk?=
 =?iso-2022-jp?B?QjlqR1U3dDFzSlFTWHVpeCtyR0hzYUFVUE8wRk84UjJycERxVlAvZGhS?=
 =?iso-2022-jp?B?SzUyMURUdWpERUpLeHhrL1F3Uktod3pzWlBQNHVlbVFZelhPS0pGUnE1?=
 =?iso-2022-jp?B?Y1BmdElsN0NLYXZ0b0RpeFVhZi9waG1NRktGbVI4ZldnUVdGb3JtbFhk?=
 =?iso-2022-jp?B?YUxRRldNTC9YVTQxeWt4ajExMW54eEJaRnQ4QVZWVEZnTjNNYzZaYU5y?=
 =?iso-2022-jp?B?ek9zT2tvTkpQUDlIczN1T0tOemFKRVhTSDBwZkk3WE83di9GZDZLOXl2?=
 =?iso-2022-jp?B?VzEzcnRMMllGQkVjTzViTTQvWGQrVk1ydGc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB10136.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 2be336b6-2bc7-4487-9cc3-08da80d70ca9
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 05:03:54.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 Z1TQZVVqkXPANDnedeq5NxIX8oBg/Cp1lnPP5Dzmv7KSr0sih/uYUeZpMMThUT1O2XVv38RAqkBYCLUUEZLqFEF7hvMMWMyq+q2+/7oughY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB1832
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 05:04:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9289

Hello Pavel,

> then you can see the rootfs tarball at:
> build/tmp/deploy/images/qemu-riscv64/cip-core-image-cip-core-sid-ports-qe=
mu-riscv64.tar.gz

Sorry, it seems the image is generated as .ext4 by default:
build/tmp/deploy/images/qemu-riscv64/cip-core-image-cip-core-sid-ports-qemu=
-riscv64.ext4

> > Unfortunately, I can't get debootstrap --second-stage to work (I get
> > sigsegv in ldconfig, I guess testing may be too experimental?). Is it
> > possible to debootstrap stable or testing distributions?

My understanding is debian ports only provides packages for sid/experimenta=
l suites
so there is no package provided as stable/testing.
http://ftp.ports.debian.org/debian-ports/dists/

Best regards,
Kazu

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Kazuhiro Hayashi
> Sent: Thursday, August 18, 2022 11:54 AM
> To: pavel@denx.de; cip-dev@lists.cip-project.org; Chris.Paterson2@renesas=
.com
> Cc: nguyen dat tho(=1B$B#T#S#D#V=1B(B =1B$B#E#n#g!!#1=1B(B) <tho1.nguyend=
at@toshiba.co.jp>
> Subject: Re: [cip-dev] Root filesystem for risc-v board
>=20
> Hello Pavel,
>=20
> We have a development branch in isar-cip-core, by which
> we can generate a rootfs for QEMU riscv64.
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/thond/riscv-=
dev
>=20
> Please note that this is not an official recipes of isar-cip-core and
> there is no plan to be merged into master because it uses sid-ports repos=
itory.
>=20
> Step to build rootfs (tarball):
>=20
> $ git clone -b thond/riscv-dev https://gitlab.com/cip-project/cip-core/is=
ar-cip-core
> $ cd isar-cip-core
> $ wget https://raw.githubusercontent.com/siemens/kas/3.0.2/kas-container
> $ chmod a+x kas-container
> $ ./kas-container build kas-cip.yml:kas/board/qemu-riscv64.yml:kas/opt/si=
d-ports.yml:kas/opt/debian-kernel.yml
>=20
> then you can see the rootfs tarball at:
> build/tmp/deploy/images/qemu-riscv64/cip-core-image-cip-core-sid-ports-qe=
mu-riscv64.tar.gz
>=20
> By the latest CI, the rootfs image (tarball) was uploaded to S3:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/2702654409#L=
1586
>=20
> Please let me know if you need more information.
>=20
> Best regards,
> Kazu
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On =
Behalf Of Pavel Machek
> > Sent: Friday, August 12, 2022 5:22 PM
> > To: cip-dev@lists.cip-project.org; Chris.Paterson2@renesas.com
> > Subject: [cip-dev] Root filesystem for risc-v board
> >
> > Hi!
> >
> > So... how do you get root filesystem for RISC-V board? Ideally I'd
> > like to get something Debian based.
> >
> > Best I could try is debootstrap for Debian testing:
> >
> > sudo debootstrap --no-check-gpg --foreign --arch=3Driscv64 --keyring
> > /usr/share/keyrings/debian-ports-archive-keyring.gpg
> > --include=3Ddebian-ports-archive-keyring unstable /some/suitable/dir
> > http://deb.debian.org/debian-ports
> >
> > Unfortunately, I can't get debootstrap --second-stage to work (I get
> > sigsegv in ldconfig, I guess testing may be too experimental?). Is it
> > possible to debootstrap stable or testing distributions?
> >
> > I don't think CIP project provides binary images somewhere. What is
> > recommended way to get a root filesystem? Is there suitable
> > documentation I should follow?
> >
> > Thanks and best regards,
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany



