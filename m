Return-Path: <venkata.pyla@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4948AC433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Feb 2022 19:35:31 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web08.39515.1644867328810546531
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Feb 2022 11:35:30 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.155,
 mailfrom: venkata.pyla@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 21EJZORp007578;
 Tue, 15 Feb 2022 04:35:24 +0900
X-Iguazu-Qid: 34tIXlwsceywkIqvOC
X-Iguazu-QSIG: v=2; s=0; t=1644867323; q=34tIXlwsceywkIqvOC;
 m=pjAN8Y1UuWsnA4Lfcvq4ca+/0n019KYpO9LdBNWrVLM=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 21EJZMk5013597
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 15 Feb 2022 04:35:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7qr8hzR7mkNg8PLa3yQo/dz9aqhK9b+zEJR3ktNZNgp1KgKQTQWVpU+0jda3qXNdBpEUBE+xq9+sgyFKjPmh/zeDNKerrCRq/OyaJru6bcvrUhjIcEL4kxjAdwK5bSXCrsFknD+Y5dc+7mHZSbxRFP3eHZvaNWIoOlfdVIjuysL5TYFj6AafvQIXBGYFIl7P1Crdl5YV91FlqowsQLUuMI7W84KD5v2TaGZGgx0jMWIkVQcsUOe2DHKU1gz3TOx8ew/hHCocjTeMN8ZqAwpxW7LDpD9K0USJ60Ax1DQXcCpmbQsU+QU/C74EnkpE+8IY3IsXnx+C6H+WE9RycbHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yk3Ip6TAO+eJkVt+Q2LxZ168YMe2inmMQwE4bAlmaTM=;
 b=Liod9uDS7pg0yae4Zhf31vDqVArQDzh+lUnaiy1cgjl7GqeTIVkf9BCXYdVOcgPFgfa1f7MVYnER6+GOSi+DnHEhTlL7i6iqWIQPCXwNmAp+st9N3+IWp+9iY41g6pwiHPvspYNh6zoXj0tRaAR4SwUL/Hv5mwCyp9Cau6KACo2nCRPxlZgbyEEtsIpFHqgKfYOcOe6Oz/1cI0hGaiNm8OKvtRok2atfoLZqJ7AaknPVJSPX13wBZTeHNknqV9Syi1k0T9Jo8hvn5IHSlhfDyPA33DDhG+Oe34Ed9t4AJE1hQT4PHiZrGUwDJ9NAgaoasa6tp/q4Nondr/c2nG6syw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
From: <Venkata.Pyla@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <henning.schild@siemens.com>, <jan.kiszka@siemens.com>,
        <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
        <isar-users@googlegroups.com>
Subject: RE: Is it safe to remove debconf cache files in isar system
Thread-Topic: Is it safe to remove debconf cache files in isar system
Thread-Index: Adfxn0ixO1l46sfHSPSUw0MzjTnehAwKE9/g
Date: Mon, 14 Feb 2022 19:35:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSYPR01MB55422F9AABFB4B49B632AFC5A4339@OSYPR01MB5542.jpnprd01.prod.outlook.com>
References: 
 <OSYPR01MB554254B35D37230B04195ED4A4779@OSYPR01MB5542.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSYPR01MB554254B35D37230B04195ED4A4779@OSYPR01MB5542.jpnprd01.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9df2be70-5b01-444d-7211-08d9eff122c2
x-ms-traffictypediagnostic: OS3PR01MB9591:EE_
x-microsoft-antispam-prvs: 
 <OS3PR01MB9591D52214041A849AFAC5B5A4339@OS3PR01MB9591.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 X4CTv/mEC9wamW/bGzKuLEJfA/xIo+d8DOeFrgJxVwh1clfk2qEvl6IIzY3nHMvTaJHKwsTuPouisxmgmCrrFKPjVZVim1FaBy/34nf/H6swf5181Glv/h40b8ABSTzbrxk+cUGMgTVHqHKZ7Zvm+Wv48ZblXHfZZ+Bg6oqnBXKnsYp6nNUVyii3LW3OjK8Kf1JstlCyUQRXFWtQ3YIVJWWKKd7UmYSmkxUDbbYfU2q1xwGWQ+d1klZpIIEuM/DBrAQvA22nqinXYkxP6jxOzHZlQZ5BMcE0dxD/JzhbYIaSeTX9WUek6EjhSfFCvFNMdVHbWAxvr8KFnrF/knXoo76oCyocwoSEXRAOpR1Ogy1E0dv62LxcsLG95awhjtw/FY4K7eAxv7j6+5MSa8hzSMwQDAnDmgIh07DqhfGmTOWYkF3ELbEBDVgRzwWI902mM7RvzlGxe0nEMHIC0sZkzb6EvgEPzVVKLhxURUY+HCkBRSpzQZx1crS8UgL/aIPXoxyEqs6Mu6/1kFVJ1VKLQ4JIzTHZB0+P9x7zdZvPpg9ivn1Q9rnFu8iIBQNRre5TlA2tZ8kAg4bTzxYeoHtR2vW1+7DELLOXJq4bqtDcj4OE2s3JNHmQ7Gsc/cKT9JIFCelanhGxYY2GrP9mFe7yWT1Xwa8YOgVqWUa7CgQaKExwWETBKzpAbkJh2W2wLKaJl5Wtq7VN4ymHMGT4wmswDA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSYPR01MB5542.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(6916009)(54906003)(64756008)(86362001)(7696005)(6506007)(66946007)(66476007)(66556008)(4326008)(38070700005)(8676002)(66446008)(76116006)(85182001)(5660300002)(8936002)(52536014)(508600001)(83380400001)(122000001)(55016003)(2906002)(71200400001)(26005)(186003)(9686003)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SmxOYThENHlGd2JnWncvOWRRVWRlRUJXWG1zN1V3UjhWdi8rWExWOWhQ?=
 =?iso-2022-jp?B?T2lBdEt1Wk8yWllHOWtZSnRqaEJKUmtpR29JWWFTZG0xOWRCOWo1YlZs?=
 =?iso-2022-jp?B?KzF1Rmt1SXpJeVdFaS9zaTZCMkFVWkc5T3RqY1pTZk82dytTVThVMzVw?=
 =?iso-2022-jp?B?WTU2eEZsa2M3TTFaNnNhdmRMb1gwTVNMd0hzSEIzQ3A2RFIxVmFrU0FJ?=
 =?iso-2022-jp?B?VnBra3dVTFlBa2lRU3lwblVMR3MvcWtXSFl2Q0h4Q0d1aHl5M0lKMVBh?=
 =?iso-2022-jp?B?WW5xY1l6MUtaNmxJcWxFeFJIRmZLN002L0tYRTRBdUFBUVc5d0h2LzRv?=
 =?iso-2022-jp?B?cGljSjhmZ2ZvVW1scWttTEtXaGJQWjV3b3FwK0VDYm1NcHNjMVZqT29B?=
 =?iso-2022-jp?B?akdBMkNHT0M3VyszbGZUbUROcEE2cjZ4QTRwSU5JMkJCcGJET0ZCZjVq?=
 =?iso-2022-jp?B?b0IwMGk3ZWo0T05wZjZNQkJmR2VXREw3NGFybnRWVDBTMVFKWDRqUHJB?=
 =?iso-2022-jp?B?dkppYVpTTmVTUmpQOWJuTkZlMFBpY056ai9WUE9xcHV2OTJJTk1KTXZ2?=
 =?iso-2022-jp?B?OXVHWVRjUzAwZHFHT0lHNGdWTFRFYjJCNFR6eXZpR2tPa3pUdmc1S3or?=
 =?iso-2022-jp?B?T0NwUkQ2TzFYVWZCZWJOL3IwN2lpM3d0NTJpcjM3aFRWWU1vSmZBa25w?=
 =?iso-2022-jp?B?K1NwckJPc2FhNFpJYWhHOVIrR1MvZ3pjbER1MWhPS3RDTENFSm9IL2RI?=
 =?iso-2022-jp?B?UkZmQnZ2V2YvOEdqOHVESHNDSjJXOG1mbE00Vk1OdURnUFA4R29XSEh4?=
 =?iso-2022-jp?B?K2x0dVErcjdacVFyWTRsekx1dkNiYWszU1NyQWJJZ1VGYkhGUTlKWXQ0?=
 =?iso-2022-jp?B?NmFHa0FTSnl5WDY2MSt2bkI0UWMwc0hhR2lsYUpHZ2lzeE9GNWdKNXdw?=
 =?iso-2022-jp?B?Mm5rN3BRMlpWdENVdXY4WU8wNENNSXJlZHlTZVhheVhmdC9zRWMrWC90?=
 =?iso-2022-jp?B?QSttc1cyWXpidEFlNkt5Y2N0Uk5rdTdVU3BnUU5oejBRcmlSRnNZUUp3?=
 =?iso-2022-jp?B?Tjg3RFFuZHNvL09EdXd6bUViK0F5T0V4Q0N1T3dpTTZiRHhaMERtenkz?=
 =?iso-2022-jp?B?ci9nblAyZmJQcDI2OUw4QUpjdlhoTmNnZDIxS3dienUzdURwVUJuU3RJ?=
 =?iso-2022-jp?B?aWFlR09YL1ZYV0VZYXNOdlRrbDhXakdQTmNJK3BZN3lYa3I0am9QTmRp?=
 =?iso-2022-jp?B?UFBLYUd3NkdQL2hHOG5FYjA2a0JYWml1L25CQjZxWnY5NkFKcEI1VHcr?=
 =?iso-2022-jp?B?a0xRbnRjY3RKT29DVkhVU053MlZTT0RoRG1lME12di8vVWt2YVd3UDFB?=
 =?iso-2022-jp?B?RGMrREpOaUZybEFSY2thNkhlbUlpdHkwM3FhSXU3YjBGZDJORlIyUWFh?=
 =?iso-2022-jp?B?ZzJNYm1FM08zMXdhTzAwZU1KdWJJMzVxTlBSZW5VV2tHckJFK1VnN0Ju?=
 =?iso-2022-jp?B?SW9WdmVJUFpxdlEzMGgvdFhiYjA4UjhZVVNMdkcvMXdlNEZXR2tSQWRu?=
 =?iso-2022-jp?B?eG1NOVJycEErN0tROWdiU3lnMlUwS1BYYWVPZG9TUnBBRmQrVnhJN0pn?=
 =?iso-2022-jp?B?dlFlOXZSenZEcmRYM2pzRTcvbThKM1hiOEZSakNOUmM3QkdtU0V0d3Vj?=
 =?iso-2022-jp?B?TStJalZSek54NXNwcm03L3RhL1EwaTFUY01IVUZBZzZMSFJCNFVkcFJC?=
 =?iso-2022-jp?B?SUZkN01NWkRocDdSS0JVWDhHUE02VGNJc0g0Rm9JYkpkdE9TaGFaVmxn?=
 =?iso-2022-jp?B?WXF4c1ZpWUcxK2tyUU5GSWhKWmxIcmkvYXZXakZYSkViMnRyRFRXRUNR?=
 =?iso-2022-jp?B?TGt6amwwd2I2ck01RkhCRFlhYkVzeC9UYm1RcEhqMjBRZE4zcno0aVR2?=
 =?iso-2022-jp?B?K2Jad2ZPMnpIRFZGQVRRNnRLWFoxK3ZyK1pZSUpIbHpRS090dy9aaStD?=
 =?iso-2022-jp?B?WW94U0ZiS0x2N0lKaVNVWTdmYVZoRzVLNURQQmxvSGFkY2dibmJqSXEr?=
 =?iso-2022-jp?B?b3R3UXNUeVV4U01aM1h0TlMxTzRkdWpHamdtYm1HU0RyWDdjc1RzWWhT?=
 =?iso-2022-jp?B?MCtUcnlNRGhwaEE0Nk1HQXhlMVJMdFZkL1BHcGhzRjNUdGh5U0pxSGhx?=
 =?iso-2022-jp?B?YWxPd1BKWUFqOGtMeS9OZHBuNlpXdldhTm9SNW45SSt3V3dIZHNzUDN5?=
 =?iso-2022-jp?B?OFJaTk9mdDhYenFzRmUxbHlSa0xlRnV6TW4wbk5rMFpTbTl5U0EyQnlM?=
 =?iso-2022-jp?B?a21xdnlMM1VEeThTeG84R3dkUFBTaFU3OE5BMDVyUlllT3p0OHVNUXY0?=
 =?iso-2022-jp?B?NkkveW85OXRDMDQ2bGovdk1NcjFaUHM2TEk5UkxRcXlTdTV5SE80YzFx?=
 =?iso-2022-jp?B?cXNuZ1JnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSYPR01MB5542.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9df2be70-5b01-444d-7211-08d9eff122c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 19:35:19.8336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 /gBKdPKehxhJwzeRmwKNPd/krcnBYMj/EJArgq+UEg2QSDdEaD87eum7le2IWRFeFQkQrW+T3un5Ul2Cz3DEI1HA1y9fGPWkND00Q/n+rpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9591
X-OriginatorOrg: toshiba-tsip.com
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Feb 2022 19:35:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7599

Hi,

Resending this question in cip-dev mailing list

Thanks,
Venkata.

>-----Original Message-----
>From: pyla venkata(=1B$B#T#S#I#P=1B(B)
>Sent: 16 December 2021 13:17
>To: isar-users@googlegroups.com
>Cc: henning.schild@siemens.com; Jan Kiszka <jan.kiszka@siemens.com>; dines=
h
>kumar(=1B$B#T#S#I#P=1B(B) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhir=
o(=1B$BNS=1B(B =1B$BOB9(=1B(B
>=1B$B""#S#W#C"~#A#C#T=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
>Subject: Is it safe to remove debconf cache files in isar system
>
>Hi,
>
>I am working to fix some reproducible build failures in isar system, as pa=
rt of
>this I wanted to know some ideas to fix it.
>
>I am checking the reproducible failures as below:
> $ cd isar
> $ . isar-init-build-env build1 && bitbake mc:qemuamd64-buster-tgz:isar-im=
age-
>base
> $ . isar-init-build-env build2 && bitbake mc:qemuamd64-buster-tgz:isar-im=
age-
>base
> $ mkdir -p rootfs1 rootfs2
> $ tar -xzvf ./build1/tmp/deploy/images/qemuamd64/isar-image-base-debian-
>buster-qemuamd64.tar.gz -C ./rootfs1/  $ tar -xzvf
>./build2/tmp/deploy/images/qemuamd64/isar-image-base-debian-buster-
>qemuamd64.tar.gz -C ./rootfs2/  $ rsync -nrclv ./rootfs1/ ./rootfs2/ >
>difference.txt
>
>Below is one reproducible problem I picked:
>In debconf db file the contents were different after two subsequent builds=
,
>
>Part of the debconf db file where the difference is found
>(/var/cache/debconf/config.dat)
>Build1:
>Name: ucf/changeprompt
>Template: ucf/changeprompt
>Value: keep_current
>Owners: ucf
>Variables:
> BASENAME =3D locale.nopurge
> FILE =3D /etc/locale.nopurge
> NEW =3D /etc/locale.nopurge.29308
>
>Build2:
>Name: ucf/changeprompt
>Template: ucf/changeprompt
>Value: keep_current
>Owners: ucf
>Variables:
> BASENAME =3D locale.nopurge
> FILE =3D /etc/locale.nopurge
> NEW =3D /etc/locale.nopurge.19132
>
>The probable solution I am thinking of is:
>1. remove the debconf cache files (rm -f /var/cache/debconf/*)
>2. Fix the debconf in such a way it generates same package configuration o=
n every build
>
>The first solution is easy, but I am worried if those package configuratio=
n files
>maybe required in future when the package is updating The second solution
>would need more investigation at debconf package side.
>
>Any ideas or suggestion would be very grateful.
>
>Thanks,
>Venkata.


