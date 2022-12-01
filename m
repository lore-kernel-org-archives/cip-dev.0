Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CB4C4321E
	for <webhook@archiver.kernel.org>; Thu,  1 Dec 2022 00:37:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.30436.1669855030590878148
 for <cip-dev@lists.cip-project.org>;
 Wed, 30 Nov 2022 16:37:11 -0800
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 2B10b8vr014188; Thu, 1 Dec 2022 09:37:08 +0900
X-Iguazu-Qid: 2wHHDMt2Mq7Nn0Ywnn
X-Iguazu-QSIG: v=2; s=0; t=1669855027; q=2wHHDMt2Mq7Nn0Ywnn; m=hFoTDmNZPUZx3oL2VNnsvJT7iL+UnOvvF3u2e1P+HJo=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 2B10b6Xj039151
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 1 Dec 2022 09:37:07 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JOOvfqscfvvu1ioNkmMSGRyw9UbbaQ0OTJsrKTFLLaqD0wzT/dIBtxpAA0y/qrWoimhuZxYFx+fU/QSkWQtmeYnve6uecijm/I0fMSHLakR3OrYTMT/M4OvJDHAYhqNe0TRtyh02apyAYNXBZjLaNha6TMbkcM+51IHFZX+1Wtyf7oBlMdq0UMyAqi/kNAODnI8qW46cv2DK8XMD/mIXwXGEAqw2y1LlmIDdzvkUKWo1qh0GjA85hQq/nkY2dj8MmiPKt9AooBSL+d/6Mpb8kYL6b4TTefBjrjaBzM0PM2cqJ3ccOshykqFB5DrXXV1aexWsdH1grZD6FYTWkCtKAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEiJGf9agor10qaC7D7hY0GYOHUWWWP+VsVxnBbVvyk=;
 b=iO6c3TphiFyrpHm4Q3KmTf8WvjJl/Iyy8GOYEecxPEujvGQd9E8/qe/ERXEAu8RxhvxHN7zrPVlGyKIkH7N1d+xW15t0+lrA/kI7nOk4yanuelXxjWTA79+RCkQ2GH4LI1h6rSJ4ykyx13XJsw1ytruxpC/6a/uACw1HtPZsArE6XyuanDV+xS6OjCG+PlqQu7OkaaonDyNvFk+4DqwzJQnNbW86ocPGMMXRmsc7KOO8/V5O456kG/XtRl3HSAgVcoHM4+UOYbjWTb2FU6RCdVCtfr0R12Vk4wb271a6A7lqbGMCnv9BR3RNRvxzcMq+8fkJT2FLChvfDDJaw8nXJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [cip-dev] [ANNOUNCE] 4.4.302-cip71-rt41
Thread-Topic: [cip-dev] [ANNOUNCE] 4.4.302-cip71-rt41
Thread-Index: AQHZBQcDp43dGWRa/0yzFc8i/87KoK5YLoRg
Date: Thu, 1 Dec 2022 00:37:00 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB94201038D0EAE900A607518B92149@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <Y4fSIdKnyVeYN1+D@duo.ucw.cz>
In-Reply-To: <Y4fSIdKnyVeYN1+D@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB9320:EE_
x-ms-office365-filtering-correlation-id: cb024bf0-b072-4a34-4e88-08dad3342942
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tv/JzIOuwuB4K/Tqvh4NB4ql2jdMoCVINYejUTsTVgvvbXxrfKEx1+dJAJDidojTRc3C6/f4wpeh8SSAwZOEFEbo6CMSuQbrsZAKkaemYgapP1AukqTYFemuqbWoJUPsHJoNwBxo0r9Ffn6SzfRQOB/SMVclmNyKh/ZmCFAuQS9l65j7pp37YW8RVnqMS/TZm2F6k6CwNbryB6OHjeH6r+CtMuYiKrucUBQljFXRvEcWkvZN7jtyivJztG/rbI+Zn2OK9dqtJAPfSnFgNTVX8AGajG4XfVuNonvhrOnkLsTdtaPsleLSYUftnL2jZdg1NtAcAlgvqBud9x22CW2TVSUPgnkLJVC+FIclOFkFO8U34VUhQtxM+kcrdNFwy1XtJLPoA1Yj4G2aed/7ERdzwu/VQqz3Pbwk/WAPhfcjXLCOCilqusDvMUoWqd6s8f/aYl6cCHiBo8OBMpEupa/8osjJA00davmv0Q0/t8QCXJ4cOSqMBg5oVgi/IT1nx9fQ0jnEYMEYUWFjeGowOqS4MArRLWgMn7CZbi7VeFUGbIKMLqtIK+0g34UzdoDTKEEZWF50QQ9q9jk4Ir6+R+F8pfXBIDEuzZ2uVR289objA+jLsgY3xoTLON4bNuW+44uMe5TSfz96ZLry3ZKQHSb0IeWnkBBphWvPJijPcOaEUCAsijwzKX+/U8X5navnholPmuXDS98v++yqoac74fZp8ovAgVYLqWYD0HVIxa6eVE4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199015)(966005)(478600001)(71200400001)(6506007)(7696005)(41300700001)(186003)(66476007)(66946007)(76116006)(8676002)(52536014)(8936002)(66556008)(66446008)(316002)(26005)(9686003)(110136005)(53546011)(5660300002)(2906002)(83380400001)(38070700005)(86362001)(55016003)(33656002)(64756008)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?TEkyWE1Wam85bm1Xd0ZaYVlScXBMcXdkalV1TElZdlplTnpXMThVdTd4?=
 =?iso-2022-jp?B?Y2NtVCtjeURzN2F3dkczN2d2Tlk0b1NmNk55azZxbGZkOVllTVdXRlNT?=
 =?iso-2022-jp?B?UDVDRXo2TnR4QU13MU1paGtJT25BaEFhRTk1TVpwd2tSOTgwVFR2b21t?=
 =?iso-2022-jp?B?UW1ERHR3YjJRMDlPdFZjdDdIWUpvUEVNakNkU3hWeHFJckp4TzUwZ3NE?=
 =?iso-2022-jp?B?TkZqOHdNN2MzQ3lURnBwM2xBOUxQaVJ3MU9yZWFBQWZWaEhkajdjdlVV?=
 =?iso-2022-jp?B?N3psQi9QbE1YUDBJZmRTaWNKZTJ4SkN5bnhyZUdSZENFeWlyeS84VlJs?=
 =?iso-2022-jp?B?dm9EOTNmOFcwS0N0ZVlqTE84a3N4YW1ndG5yUEh3S3dBSnpWRlNxSE1h?=
 =?iso-2022-jp?B?dmlucGRWS1pwVXJiN0hLZmFQbUw4eCtEa0l1aGZqdFV0MWFwZXc0a3Bx?=
 =?iso-2022-jp?B?dkljYWM4c3BTcGk5MmUydDczQTVVNk10QnZHdGxvSS8vb1BmTkxZSU1x?=
 =?iso-2022-jp?B?QndYWlVIcEhLRENIcldDRmNVRVFzYk9QWk8wOE9uMUc4dUpnTkEwYWor?=
 =?iso-2022-jp?B?OW9SWWFUeFloWVdUOC9MOXQrZ0I0Vms4MEhXYzYxVi9nQmFqSWRkTVMx?=
 =?iso-2022-jp?B?c3FiY1RFMFhOSVVlSHd1UXp1MEdaTFdkekZETmQ1TGVJLzVMZytGeWRa?=
 =?iso-2022-jp?B?ME9mZ3VWOWg2K1kzSTZqWWlsVkdQNm5JOG16ZUxkOVRyUEQ4NzZEMUhz?=
 =?iso-2022-jp?B?eFlFOU4yVWNvSHY5amRIVEFiQWpUNm9qYUoxTTA1MUxyMGlobFI1SGM2?=
 =?iso-2022-jp?B?Y3RvVUNqNWc4aVBpUW5tR1hQTGg2KzZ1R0ZvR0NQL256TFpZWC9neTB2?=
 =?iso-2022-jp?B?aXhxRUIyTmx4Yk1JaEpJZHJ0d2x5b2ZRYVlNcHpFOUJHei9TNjVVVEhp?=
 =?iso-2022-jp?B?Y3BtMWVNZEkveXNmTTJ4bDEyOUp0SVV6eEZQbHI5QzV5VGs5WXJZMDRF?=
 =?iso-2022-jp?B?L3hlcDNyaW5xWisveTZId0wyTUlJN1cydVZmUXUrN0VhT2ZOZGNHd0Js?=
 =?iso-2022-jp?B?V1RrQnRTdWF6WlRSdEZLZ0tucTRZMTFuYmZsMVZmbzhITnJ3cG9QS2dL?=
 =?iso-2022-jp?B?ZkxCd05CcXgySndxUlZ4T1NHYWJPVDlMSTFnQnZjMTBWZTZJOURZWEMz?=
 =?iso-2022-jp?B?YnVsY2NzQm94aE5oaHdVSWVTcjNCSm0vMEFvUFpHRVZUbjVMS2VHY1hs?=
 =?iso-2022-jp?B?WVdqV1pDVHgyMXZ3WGVrSjh0YTlNYm9Ic1FJOXd6OU9yUEVxdC93dkJw?=
 =?iso-2022-jp?B?cFQwSGhOdkVBMFJTNm1sRzlEM1Y5OW4zZW5HNGFLdGdOdjdtcDBMUUtw?=
 =?iso-2022-jp?B?TndUSkMxdHM0SGpjaEkyTTdhM21tREwvL242WjNGL1FZb20rWDNYVmts?=
 =?iso-2022-jp?B?bm9TR3pKOFJtUnNWVms5N0tUNk54aXVhL3JpODF0czBxRldXMGc4d1Ns?=
 =?iso-2022-jp?B?MzQ5U3hLcDJlNFhBSWc2N25TYnlzcERQMjJRVzRXOE85dG1Hb0FiWVNu?=
 =?iso-2022-jp?B?SXVrTkhYTTBsRDJGQVQ2dUZGOXJabS9QSzdkbkloSGUraTNiTUl5Mm9j?=
 =?iso-2022-jp?B?YzF5U3h0aFJZYmNrem9Ccmh4czFMK2YraFZ4RGQvcHBMc0ExSjVpbzRO?=
 =?iso-2022-jp?B?MnFkTlkvaXVpbElhcWtWSk44TEozellheUZkTHpGREUrYnVPaVp2RXBs?=
 =?iso-2022-jp?B?S25EQmhnUStwTWRzM3o1cS9kTHErUWxVck8rMjUwL2pXWWV2NWJKWkhI?=
 =?iso-2022-jp?B?cDNBV3JTNnlzcEhGcnVsazYzSFVRYjJuT3RoWGZFVTNISHVRYndPMnFm?=
 =?iso-2022-jp?B?d2xmL3Npa25uWGhHU0gyVExSMU5CcG5aZXJsK0tHaWljZGQ0ZkFNY0d6?=
 =?iso-2022-jp?B?Uk1jWUYxU0ZnWHRVYi9xUnZObnkvK2ZXTEt0WUJiMlAvTmlkMDloTzdl?=
 =?iso-2022-jp?B?MkdiU2x3RStUTkxraytkVk8yQVVwRnlEVGZoejdScmNlZlZiZ1pNSFFX?=
 =?iso-2022-jp?B?MHZGY2dZeDRvV2JNWXd3NGpUUXl6Z3VJVVZzOWxvYjl3cE9vV3FJS1pl?=
 =?iso-2022-jp?B?Rjhjb0QrbTlxdTY2KzNTbHZvd2VjVWNpNGozWDk3OTVWbzVyRGJJZWJo?=
 =?iso-2022-jp?B?K0RBa0lnY1k0WU80WlNVOGM2WTF3YmpnY2pCdVlibktac1Z1OWFwTnhI?=
 =?iso-2022-jp?B?L0RHK2RCbnZNWTRVOWdjYW5BU2VVOVBDVGhwaDV5M1Z0bXRXaUNxWHN0?=
 =?iso-2022-jp?B?aUN1bnAxQ3ZxV3dxWWtQRHBBeC9BTWNTWkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb024bf0-b072-4a34-4e88-08dad3342942
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2022 00:37:00.9849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 40kvjgd67zt7ECAerY+eTrLUmtLAGjHRcjThcI+KRP/sfDfRIfiE+0SCfzDTfeFHjUuB0v7r/kuhNmXZFJmlZTGj/87AhXIRFFsg8kyQKjotWUT0ljEEeStv+xUuUvYw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9320
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Dec 2022 00:37:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10148

Hi Pavel,

Thanks for release work!

BTW, rt_x86_siemens_i386-rt.config is the build error.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/3405080634#L45=
19
I'm posting a patch to cip-dev that fixes this. Please check that.
   [RESEND][PATCH for 4.4.y] extcon: adc-jack: Fix incompatible pointer typ=
e warning

Best regards,
  Nobuhiro

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Thursday, December 1, 2022 6:59 AM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org;
> Chris.Paterson2@renesas.com
> Subject: [cip-dev] [ANNOUNCE] 4.4.302-cip71-rt41
>=20
> Hi!
>=20
> New realtime trees should be available at kernel.org.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.4.y-cip-rt
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-4.4.y-cip-rt-rebase
>=20
> And their content should be identical.
>=20
> Best regards,
>                                                                 Pavel
>=20
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


