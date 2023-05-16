Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA6C77B7A
	for <webhook@archiver.kernel.org>; Tue, 16 May 2023 10:46:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.18656.1684234008902031832
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 May 2023 03:46:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.156, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 34GAkegu024912; Tue, 16 May 2023 19:46:40 +0900
X-Iguazu-Qid: 2wHHJG9eNq8D7J8WPY
X-Iguazu-QSIG: v=2; s=0; t=1684234000; q=2wHHJG9eNq8D7J8WPY; m=DZeHphWZk+h7gQaQLqTgK19MAqwov9gJ0K0LsS4Zw/I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 34GAkceE039196
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 May 2023 19:46:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjxgEnAdtbcOjquXfmp8Hjgcx1tSXBc7hjQ9xS4CcaK44h/a5QhSDmZTGpl/PhrVnYTOgrQJti1Juq9VIYdG5BEkawOEx9LAJWnM/L3SHlTD9n+8mhVHnrv6GcHoxgU3UD5/z5TYHBaJrN85WPlr0NN6auR+UVutMj6D06E0oLXZtRPayf4gNFeyjQP/mpFZi0+8DLlBhtrgxB/Vo2o4qE98FJI+wYN+nI8NLaSBkEsTszsg4qFmqDApT/hTV+2FlOc9LinE9xKdxgqUyWfij0sX6F/Yu+qzKDifUpvDfobtV20gEv8ISXoWzr7qL88WFbrdPQoJzgEcQYBhb4O5lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xjnnnrsMnPt+CYw5ydtCqv0K3Ec81UrAzAEubFsleU=;
 b=CnvDAUvDdI5wDST1OSJBEtGe5V3kDoSn+UW7FkJ4w0ATIVgzfREu5i9qHWbghW5q3sTfZOIWTAgKwRkeizlPp/ObVzWXtrXTYkW6SnQ5kYB5eNnja1usLFXTzEdiGzbeiaYH4ZEMAoQYbr5J1jSJKwtzFrCFBnv5scpvbfq8aETx3L7G5h4HbNwNefnzZcD6ggOCKUYm7ixjl0j1OKX58pJmMSVCJwUCOPOwn/nq3i8GgEPqQtwBUBNNZP0kXY2N5zv8ajLNky+mjWDoB3QXtjiGZ59A7d2r+zNnflpQM9k0pk/8DhiCRSs5kHqMliCCruLncOCC8srkV12YTCPNew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <pavel@denx.de>,
        <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Topic: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for
 access control lists.
Thread-Index: AQHZhyaYkYJJH/WfUUqAtF70g0QBa69byMmAgAA63wCAALQGgA==
Date: Tue, 16 May 2023 10:46:36 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSAPR01MB4945B91ED2C0DE03C09899E8C2799@OSAPR01MB4945.jpnprd01.prod.outlook.com>
References: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
 <ZGKVe5ctFMEEnj/5@duo.ucw.cz>
 <TYWPR01MB94204EEB864167B2FB8E0DFF92789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB94204EEB864167B2FB8E0DFF92789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB4945:EE_|TYWPR01MB11828:EE_
x-ms-office365-filtering-correlation-id: 6be689c0-2e51-4555-d261-08db55fad29d
x-ld-processed: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f,ExtAddr,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 P1Mpzhf9SFWI//SpEO5GrdAh+OXsLQkIoY/aQs2uy/SAi454E3UBbMpsWiD87ztA7h0lDdVJPgjQ6JY9Rqj69fPfg8edt8JIEivtp2rbd70JQRvJgl3EUVKyG71Jp22EO5DnDgZKU34eyHNBR3JpF/r9RVNCNMgRFoiFlK+Y7W5uZufwEdWiPXE8JrZXjyVAthUwBZAnJpWStY1WkQavhzn/u26WEM66IHXI8RYDdXhy6Dyj+gi/wJMaOSav7z+UBpMybIn/ZQ98olAm+NX5aUv8WQBCXs/lJxZKeZU2jqjKyRzY3uTCNv+VauZBdGjbLr3VzctasDYPXXTJNCGAomLaTkvDWAQ3Nb1KjP1YE50U2GUZ7bHhZ7ngQiVA2IXvf6mLpoaUOZnSyc+FhFl2YF0OHQ0WgjcZteOKB5gCGsTLOnvmQSJ3Tv3s+rOThFnGdzpk+D9Y91/rgbA1iLYHK3EqfIC2YgmD0ab+ikUCdG7q0d90Qbn/vmmiuSRYifpRlBfh5tvzbKNGa0pAc9Am+hc4+50etOEzDIn19ls2McM/dw+N4PjTyJXfjzSyx0q33hD7IcLVDVc5oX983wLqykjOzYHYgPupodSz85JhdkwxkDd4eu/8iRkmt6l7y7lk
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB4945.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(366004)(39860400002)(136003)(451199021)(76116006)(66446008)(66946007)(64756008)(66476007)(41300700001)(66556008)(8936002)(8676002)(55016003)(52536014)(71200400001)(5660300002)(478600001)(110136005)(2906002)(316002)(4326008)(7696005)(38100700002)(9686003)(186003)(26005)(6506007)(107886003)(85182001)(83380400001)(53546011)(33656002)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WUwrYU5JU2gyK3ZnZmNQenZMeGladUVUTVVBMFNhaHVSS1doSEdRRTBQ?=
 =?iso-2022-jp?B?bk1aVEJhTEF3S2tWeW9Xd3JMRHo3alEvNElMV1dBUWhCellyWVdJdDRn?=
 =?iso-2022-jp?B?S1hRcTBJRG1hT1Z1ek1ubHhTczgzRTIrSmJTcVhUa01yTjZGeFk4OG00?=
 =?iso-2022-jp?B?aXp3bW9xUWphVlJCNldNcjV1NW5qTnFDV3Bldmt1bmpDcWpuVm80cTBO?=
 =?iso-2022-jp?B?b3p3RHlPN2xDeUN6MzVxeVNadVpvSjZndWxpZkJab1puRGNQN0RzRnJL?=
 =?iso-2022-jp?B?WldxeEZJSDI2RE0yaDlyaDFqajMzdjZIZ3V6d0wxaE1rL3plV0RnV3J0?=
 =?iso-2022-jp?B?WUtHL3ViTEVhRjIvd2tYcmJ2cmtxRFdFZzNPWGQ1OE5IL0xHNjhGK2FV?=
 =?iso-2022-jp?B?YXlLWnlJWlVQRklKSjFhb1liQWdmcTJhUitoMDFXL2hnbGZvWXdtSUtQ?=
 =?iso-2022-jp?B?eXBHMzZtOXJTZkhmUGh0RXl4NU1kc094R09SSHlDRjdLTWQ5Q3d5RndF?=
 =?iso-2022-jp?B?dWZjUVU0QWJ5bmpVT09BK012MjcxRDZOV015bWdKc1lURVVRLzBFd0g1?=
 =?iso-2022-jp?B?c1N5Q2JiWU91WGhGanhjUHRaTGZBdURQTzhFNExjRFVqWnRvSkZhNjRN?=
 =?iso-2022-jp?B?c1JkWDU5T0NUNm14TzVtSWRCQ1RGcXp5Z3NJWHA4b0tYeTNBWHpZay8r?=
 =?iso-2022-jp?B?Y1F0a2NrdEFWa0J6K3BiODFGcGYrT0VhN1ROWnVaWmJhZlJ1dkFCeWtu?=
 =?iso-2022-jp?B?dVFZUTJ5aVVFQWFxejlRRjB2Z1ZZVUo5UUV6RmxjR0hRd3hiZzVTSmtk?=
 =?iso-2022-jp?B?em5NNXRlTHRtWnN5MTFCUnQyb0czcGk1NnJidjQ0TjAxQW12UlBxengv?=
 =?iso-2022-jp?B?Z3ZFajQxYWVyUFRDU1E3bHdJTmJLZTV5L0QyZEhsUjE2Mlp6dVFiajhX?=
 =?iso-2022-jp?B?THhEaXp5VEpuclZpdnc0dE90SzRPeXZ5cVRidHhlZjhpZWFxR2ZhOHJi?=
 =?iso-2022-jp?B?RjdOQ3JPTkRxT2xzbGxVTmFuZ1VUNTNGUEM1YkI1M2lHTnJmUUswYzcx?=
 =?iso-2022-jp?B?M2FxVXZrb0xXV0MvTDhRdkU2dmkyL1JEdHY4dlFHUGJjUElLUjZTN2pU?=
 =?iso-2022-jp?B?SnA1VnNIUEJjTGc4L0ZPdW1JQ1BVczd4ZkE1WjlaVENSVlNxc2NMenhE?=
 =?iso-2022-jp?B?cVA2N0h6MG1XR2l3RVN2azJkZ2lQTG1Ybk1MOG40Y3BYZkg0STh3QmtI?=
 =?iso-2022-jp?B?aFJDNkVlWEFiV2QrZ2twbkhBY0h1bnFzU1UraGF5OW1OK0hmYmZkTEV1?=
 =?iso-2022-jp?B?ZStSS1A2RXFKaGVSejNYOE1OMDFQTmJ4YzJPSnhMWlhoMUxlem9LVVl5?=
 =?iso-2022-jp?B?UnZZcmZnUGZMSGo5eU9abGs3dWQ2clFqOEQvRGVDOEQ2K0FvUWhnb0JH?=
 =?iso-2022-jp?B?ZzZLWGZnWFhTSytRWVdmS1RjMyt2NS9ucXZJaDhFUkQ0YS85OGs1ZGV5?=
 =?iso-2022-jp?B?cWY1TVUzOVZzbzZqNzJpOVJjVWU0a2dkaDEybVVNSlAwZlIwaTF1Zmkr?=
 =?iso-2022-jp?B?bXpjY3pnZHdHRXpmZG9mbVBwYWNBRWhMSzc1N1lLR0FjaDJyWnlrRnQy?=
 =?iso-2022-jp?B?SDBPWXNYWE5FY3VqNnNBUm8rK3hkUkZvcUFLQ0FpVkdqVU1kbS9QRk1O?=
 =?iso-2022-jp?B?SENOMmRkVnZxL250TndybnE3UVRYM3BvdWNicElpSkpsSkNvZ0trZVhW?=
 =?iso-2022-jp?B?ZUd2bFVnRnRlcGViY20vZ2pKRzg0TFgybmd5akR3WS9aTXZwS29RenpJ?=
 =?iso-2022-jp?B?RVFDcERZRDUwVTZoQnBUeGNwK3lDR2MxU0Ywb2xHM3piYi9XemxzR3ZT?=
 =?iso-2022-jp?B?cDljZTFlb0RVMTBlTXlKOEdOOVF4bnRpQTdPaWRhNXlBNFgvSmNsM2Ja?=
 =?iso-2022-jp?B?VnlzZEd4N2pKTllTeDVBZWRYNmNuTXZXYjBhUVRPNzZRdkFMMEJTRHZw?=
 =?iso-2022-jp?B?N3d1Y050WkkwckowY3BzdFVOUXNKenRVZ1d4UHo1c0lMd0F6TGFsdnlr?=
 =?iso-2022-jp?B?cUFVUW1kMmxxeHgxOEFIcjVyZnJ6RGhsaE1KVEU5NHZ1NUxFK3hqOHFL?=
 =?iso-2022-jp?B?QUlON2w2M3BVZU4zMmlLTmp4TXFheURPWlkvS0FyeVhtd05MMTRNWE52?=
 =?iso-2022-jp?B?d09Vc1A0RFh3bys0Q2c4bStMVzBpYUZybGM3TGRrSlExUTdkSVF4SVRm?=
 =?iso-2022-jp?B?WFNWWnVRQnBYd3lmb3h2Q1QzQjdNL3RNME4zdGU0Rnh3STB4MkxtWWtT?=
 =?iso-2022-jp?B?ck8rQzhKUEV6S3JRaVVOcllYS2RlSHBnM3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2z1szuFgFw05kRFSBTcA7R2WPRxICNN4yjIc2RgJQSW9z1UrLrCKOybVijTIQxuJlHytUfaaQAlaNXiP/omcBfnomI+v7NF6rATtdJkdLwmjIBxsVlFyhJ2ius3hotHfoeyhoLnK/KiUGW1hdl8q6aXjr6SS3UUSwS/2vmtboHaaCBERNR98McMHGpaZE/kAm1gGcZHXUTMhXCRf08Pu6TXO0MxylCdM5PRjZVyQTWNNlODfdKPQog8K+P3P8FSNXn1JAeWWN5cK84qug6DKCl/7fWr/cFZdb3XT9rSvfsPGsrj7aEgQWrzWEbUbYpfLeMfgY+lkYnD2QycZ2HK/0rZBcKMpgDG5uvXbf0dfUBaylo2jkFmQQcVTKoysKG75zVNm58R61UqvCtI+kjjuEL2H0W5Tp2Ng0GJphA+3meahEvgIoYJkEBhKc11O53C4pRjC0NQKVTmf9n0M0foanLpY64K9EKyWyEoSAy5RGru3N5dn/lbyBedGS0+Sg+FaIaYLzoJoOir4Y/1qhRsVnaw0KJsHPnQWBrUK1t91/t7pIr0RjRvilgfFocbcatAWf+N27Ub4R5nnr7wv4WO5qbSRyxilfm5309xcBJsoORjPuTcyuVGGV8tT3fOIyQti0ZNXF3mx3li1//3ktCk3x0Z4UpyaT6GSfbrMNq2FrB0u0cdJQCPXWIyZPilX3y2UEkdtRKYDOxnxCALgsMok1KhgIQGuzhPEYwtrs82oxWfXL7x65xi4MIkqWOROSc10fZIZ+U283pyOh0AMVk3FtxW6d1o97nGxqsiMZWQXaCy1bJ5pAtWCOCcOJ9gGyMPIkbOcrOp1gLl+RbSd2l1rcw==
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB4945.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be689c0-2e51-4555-d261-08db55fad29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 10:46:36.6603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1GJ3duR4qwYiTfF0ITxEqn6cpHOo6wj/eeU9uoZ7Yk6n3IAAnl4qdCCvqyIYMTY3dwiC3BzJGvKLy2nJmisaQ1xEBh0F9Y07YVWeXuEW5UA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11828
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 May 2023 10:46:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11466

Hi all,

Based on the discussion, I got that we need to remove the below configs in =
5.10 arm defconfig and we need to just include ext4 configs. Is that right =
?

CONFIG_EXT2_FS=3Dy
CONFIG_EXT2_FS_XATTR=3Dy
CONFIG_EXT2_FS_POSIX_ACL=3Dy
CONFIG_EXT3_FS=3Dy

Please confirm.

Thanks and regards,
Sai Ashrith (T S I P)

-----Original Message-----
From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>=20
Sent: Tuesday, May 16, 2023 5:27 AM
To: Pavel Machek <pavel@denx.de>; cip-dev@lists.cip-project.org
Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; dines=
h kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
Subject: RE: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add support for=
 access control lists.

Hi,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, May 16, 2023 5:27 AM
> To: cip-dev@lists.cip-project.org
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; ashrith sai(=1B$B#T#S#I#P=1B(B)
> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC O=
DG
> Porting) <dinesh.kumar@toshiba-tsip.com>
> Subject: Re: [cip-dev] [cip-kernel-config] 5.10.y-cip/arm : Add=20
> support for access control lists.
>=20
> Hi!
>=20
> > From: Sai <Sai.Sathujoda@toshiba-tsip.com>
> >
> > These configs are required for acl package to work which is used for
> > IEC-62443-4-2 evaluation.
> >
> > Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> Seems okay to me. We'll need to apply similar changes to 6.1.
>=20
> If we have ext4, do we need ext2 and ext3? IIRC ext4 can serve as both of=
 those.

Agree. But IEC-62443-4-2 may require ext3, etc. I don't know the details of=
 this...
Or if we decide to only support ext4 as CIP/QEMU, I think we don't need to =
configure ext2/ext3.

Best regards,
  Nobuhiro


