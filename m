Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D5C6FD18
	for <webhook@archiver.kernel.org>; Wed, 29 Mar 2023 22:29:47 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.11603.1680128978058686404
 for <cip-dev@lists.cip-project.org>;
 Wed, 29 Mar 2023 15:29:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 32TMTOCo021059; Thu, 30 Mar 2023 07:29:26 +0900
X-Iguazu-Qid: 2wHH8MjPZOJslhfsZc
X-Iguazu-QSIG: v=2; s=0; t=1680128964; q=2wHH8MjPZOJslhfsZc; m=3Tks4iLfEm/FjU37XWIzqFvgpX177Ije4ouCEk176ZI=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 32TMTMXW037326
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 30 Mar 2023 07:29:23 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxw1prvfrEP8Xtw9Z7cZlf63Vf28F8egqHcTRSIt1iaUeDsP+d0ae6XucFxQHcQo0ks14sQxTW1L3yj1XdTwFURhTEB2vedVkf1V9q4pTIBfo25Sxz8Asa7fV0D6aLlfX+cJRVnEd6APo8tpy0eVyQH2IQvWsalfqdQWDUKfvD0MDFJDg9p+ZCtZN36vOFzqYwvx2snmOY6xJp+8CkWG/9Ip7DppyuQNgTgm0VW/WZ0Qwg5nNOAHC09yMKE+biQImSYAICLHoK1ZxINiMMefO6wdMWFIehHFwglnMQEc2tT724RXXoIr59vfgDMcYW+I0JUMXjsDRTHLqBsEAo31Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qantzo/rnJ6Uc/3/1WYZM0Z+HotDQDDNPpYKYsisT7s=;
 b=M9uq1/LKxSmbrVsyMfFaGE2xXN8RyRy1yMRuTT/b2dSGFDULsVyGb5y76dSq2QwJvE52JaT1GW2oTF5FPt5cCzCHKzeuZxn3mffRRbaMv/HtCFi/O9YKmJUmIVcraFcXFMsD2pS6VKBEmKkVehlsdnsxuhxnwMXpy2Xa8EIFoj2INaVORU7HFXpGZQKqcqTAhcrtohgAZTrHrxhDoPhs9CTFpIdycbccJrQXMvgDPhamRd/UkhPR//KLHWjtYnz6OwsSwlZeAgHQeNBubR/RhL4t2J8A+dR6WevzzynR/Bzb3BgrBt58upsWxuqY99a1jiuPACYdmSJqmPKTXofhtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <uli+cip@fpond.eu>
Subject: RE: [cip-dev] [PATCH 4.4 1/3] ALSA: control: code refactoring for
 ELEM_READ/ELEM_WRITE operations
Thread-Topic: [cip-dev] [PATCH 4.4 1/3] ALSA: control: code refactoring for
 ELEM_READ/ELEM_WRITE operations
Thread-Index: AQHZXnS9AZNQegOHgEq2R5sUh0AQO68SXO4w
Date: Wed, 29 Mar 2023 22:29:19 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420EB2622E1AE6641A9F0C192899@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230324171812.221086-1-theflamefire89@gmail.com>
 <20230324171812.221086-2-theflamefire89@gmail.com>
In-Reply-To: <20230324171812.221086-2-theflamefire89@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB11235:EE_
x-ms-office365-filtering-correlation-id: 49b436c3-e54a-4dd6-940f-08db30a50a01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xDTCFjaiVst5sZGbBkh6KKA5p9qUaoFg5QwdzIvWIvOTOfXG42emlPj/zyUIhW+4DoU1GkAD7tfP4Pg+kK51TNrhFsC294PkEDIkhHhf70TkDvN3WaXkq3J9YONmGylrAwWa0eOEGN/ZQLpJYsKIH1UYAJ26Ach5qPugZRdxdCceqE5QKEAVs7YTEgDPhzlFB2r2U2rfV4ESD0W3XtehEdIS40svDfFNmXbN9rTZy+npnHKE1QvcwYqD2+x8sk5RiuR/3LPA6jLNw+FM/pzndEsTjYd9ZXOxIy13p1ktHk2+DxIWNUyrIc7XQwNpv5zRJj86l1uV5Sf7WVPDbZMH5XVZDAHmQPjKOBRLmtJbr4gGMtd3d/vjUjdbxWX8jP8ReBZ8tEzUmLKLCNoaBIlT2VQoIKO7TZjMPT4cglGytpQqJl5bTn1NZmCSzsTvNu2l5FLgqoRThvs4yUPdbi3sfR7zZw6S3/7ZYCyBLZICANlxrUmKpwXYtGpLV37jjVZ3/V59CaK5kIF9YLjWPFYY1bVyISWEhKjWc4CKeyp/oCalR4HSpLIl4mGfkWu9R0JGeQrU74WwBgzlfzl5r4D+YU1zoH3cv6finRB809S+ZyRMfhazQ/dmt1HJNtohIc6j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(451199021)(2906002)(38100700002)(8936002)(41300700001)(4326008)(52536014)(5660300002)(55016003)(38070700005)(86362001)(33656002)(122000001)(478600001)(6916009)(316002)(7696005)(71200400001)(66476007)(26005)(9686003)(53546011)(6506007)(76116006)(66946007)(66556008)(66446008)(64756008)(8676002)(83380400001)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?VUczSmdlWlIvc2ZPbXgramgzR1ZpQUg0dlRiaXFtSXpSYitMR2loQWRD?=
 =?iso-2022-jp?B?Qmw5VkFLZ2pXM2d4RUQzbzNrVmV1QWxwQmFCT3dWeFk1WENPRlB5NXU1?=
 =?iso-2022-jp?B?UGdsNEJSN244bFdYWXFzV29jMjNodXhiSWNqU2Q3UDdZMkxoT3pGUDZ3?=
 =?iso-2022-jp?B?UHlQOUZNZ3RhQ2wxYlhqZVU0Tm5LSXBDbUsvd2Z3Lyt6cmZJejV6ckwz?=
 =?iso-2022-jp?B?QnQ4WmlwVEJENTZYUzFDbFB4anlNMXVjcVU5UmI1QUdDZHN6bFFkeHoz?=
 =?iso-2022-jp?B?YnRwWm1uQnhrY0tldnZqRTdOenIvM2RCN2QvZ3dkMUZtbDBvd0dXTldt?=
 =?iso-2022-jp?B?ajlFV1IzeGxSNkJlWkZQSUJiRGtPR3duRS81VkZqV3J3ZXh1QnBCcXVU?=
 =?iso-2022-jp?B?cGc4UjdxakpXYVQxS0tTdWVnRTY3dExOaVRwbkl1aEFodG5WTmJ1WnFK?=
 =?iso-2022-jp?B?UXIzczdPTy9nU0ZzZXozZGZveHhmKzAwRUZxZXpPN2haQ0ZsZjIvbHhQ?=
 =?iso-2022-jp?B?bm9YOU8yMzVMbnNWNkxPcUwxTHkvemtkZkg3dXlPU0l3RWJ3NHd1LytW?=
 =?iso-2022-jp?B?ZkNPdDBaM3FTOFQ4LzNkZ0FNTUR4aCtzUUdkTTMyd3k1dkMyL0g5dXNk?=
 =?iso-2022-jp?B?ZTk1N0dXYXNOZ3lFK2NGcDNTV25mSjhHWDFzcHlHT1Z2blh2bjRnWUtC?=
 =?iso-2022-jp?B?MjJOUngrQ2xrNm45V1RpakIwNTRjVHNaWXV1U1pNYzZHMHBrZVZuM3Zu?=
 =?iso-2022-jp?B?N0lPQitIVldyT0RLK3VnbWN1UFJpK21peGIxcXFHbVpUZzJhWmVEYlZl?=
 =?iso-2022-jp?B?ZU5aZVJDUjkxRFFNWHphYlliS01oS3QrSS8vWHdaaEpxdEtaQlFXbGF3?=
 =?iso-2022-jp?B?UEQwVXk2c2ZPSnhQMWUyZzlFUlZmQlg5VGJPQjlTbVFLQ2tkOFFyTFlN?=
 =?iso-2022-jp?B?M3ZLNStyTnJCRE1XdWNuZWpubXd3LzFhajlKVEROZjF5ZXJtSEt1YTJR?=
 =?iso-2022-jp?B?WjZBTzNwbXZYVTJVQWFqRXowRG5UVDVGWlBYYWNTUUJwVks5d1dkc3dj?=
 =?iso-2022-jp?B?VWpkd01ZKzl1ZHdTUmJzTmtwdnJsZ0tjMm1MRGw2cGN5RU1jWERQeFY0?=
 =?iso-2022-jp?B?N3hSZVZYOHpsVGpKVG9MTEVUTEJ0anhyQms1Nm9nMzhCY3RobFB3aHZJ?=
 =?iso-2022-jp?B?Y0dMRXhmT1pxMU9qbml1NEg4ZmNld1pvd2ZPWUxXZmVmcnVPRFd3T3Bk?=
 =?iso-2022-jp?B?NVZ6ZWdPZmtKUENobE9GaFZYNVRidjhGc2JOMVlkOEtTMHc3T3NMelVz?=
 =?iso-2022-jp?B?MEswcVp0aWh6UDcyQXY3blVQQTB3QlU1OWQvOVhwdTVxK3ZWZGRYN2c5?=
 =?iso-2022-jp?B?RDFXYVNTUi9OUk5kQzdWOWtRdDBNZXF1Ymp0K1lDSHZNN1FlTW9iUy9C?=
 =?iso-2022-jp?B?cDRaMVF2ZGVHdDFERXM4RVhPOXR4WElUNzVGT1NYaHBtZ25yVXd6VkFW?=
 =?iso-2022-jp?B?VUpxbndhYWQ1QXVZa3VwOEtCcFNFTkMxdTBDczFTOVdqbDhqWHYyRkFi?=
 =?iso-2022-jp?B?ckh4dU1mNWtjeGo4cS9MV0hMVkV6aGJha2k0bHBjNWhXL3JhRzgxRElD?=
 =?iso-2022-jp?B?eTlGMVpKRXo3d3MveHlCQTB6SlNSNnpBV2hDRGJyNmJOWHJTbFZBZVNR?=
 =?iso-2022-jp?B?anM4Sjhqczk5eVk5MnVLL2pVQjVQUVEyREhabXlWZWRDZzZqUWxXSktE?=
 =?iso-2022-jp?B?YTlBcTVXd1NNWWlvVEJUa3Q2MWVmS2x6T1JWcVJMc1ZBVVZSTTBydjRq?=
 =?iso-2022-jp?B?RGVyeXBVcU8zU3FLNTY3S2Y0T2tsWkxIOEhzOWluTzlnblRtUitTdS9C?=
 =?iso-2022-jp?B?cjVjcG5XRHhMWjdVS0ZKV3J0TlhqV25DTjMycFo1aTc5ejNTNWlTOTc5?=
 =?iso-2022-jp?B?bncyZENXM1dRYVpiT1NQYzBmZEs5MTcya1ZIazZHTHFiS2tGNzdNQmNh?=
 =?iso-2022-jp?B?cjMyZGxvT3JtMjNMOG5UU3FtV1JjWEMvTU5JZjM3VkJyeS9LTGlCa1Mv?=
 =?iso-2022-jp?B?Rk9GVDJ5Mlc0QnplNFRkUGczT1hqdlFSaDdGWS9CalJ5MWhxdjlsOTdZ?=
 =?iso-2022-jp?B?clR5dmVVNnpCVHQrNDZHV0lhVnB4NFZ4UVFrNGZvOUNqRHFMK1BjMDhI?=
 =?iso-2022-jp?B?bDlhSDJ3QzV1M2k2MCtjZlVsQndqdXg0WldlRnJSVDBod1czQ3NnWjQy?=
 =?iso-2022-jp?B?cWQzRll1OWwzWkY3TzVValBNVEVhb1p3SkpzbVFBc1l1UUJwVXJDcmIw?=
 =?iso-2022-jp?B?NUE0TmhwYTkydGt0ZkVtQ0d0Mkcxc1NQTlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b436c3-e54a-4dd6-940f-08db30a50a01
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 22:29:19.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WYxUvPmNBoCnOOP3kIimKcOJFmsM59D6BEq8gPTuAqwV7aQ2uvaYBbLKWqhbFS0hdzobuip7JkzOLQGXPVoLP/pMDXOGxDDkasZKQ09Av8abN2ju6y3dBJg4Ke/g72Kj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11235
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 Mar 2023 22:29:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11130

Hi,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Alexander Grund
> Sent: Saturday, March 25, 2023 2:18 AM
> To: cip-dev@lists.cip-project.org
> Cc: uli+cip@fpond.eu
> Subject: [cip-dev] [PATCH 4.4 1/3] ALSA: control: code refactoring for
> ELEM_READ/ELEM_WRITE operations
>=20
> From: Takashi Sakamoto <o-takashi@sakamocchi.jp>

Please add original commit id.

>=20
> ALSA control core handles ELEM_READ/ELEM_WRITE requests within lock
> acquisition of a counting semaphore. The lock is acquired in helper funct=
ions
> in the end of call path before calling implementations of each driver.
>=20
> ioctl(2) with SNDRV_CTL_ELEM_READ
> ...
> ->snd_ctl_ioctl()
>   ->snd_ctl_elem_read_user()
>     ->snd_ctl_elem_read()
>       ->down_read(controls_rwsem)
>       ->snd_ctl_find_id()
>       ->struct snd_kcontrol.get()
>       ->up_read(controls_rwsem)
>=20
> ioctl(2) with SNDRV_CTL_ELEM_WRITE
> ...
> ->snd_ctl_ioctl()
>   ->snd_ctl_elem_write_user()
>     ->snd_ctl_elem_write()
>       ->down_read(controls_rwsem)
>       ->snd_ctl_find_id()
>       ->struct snd_kcontrol.put()
>       ->up_read(controls_rwsem)
>=20
> This commit moves the lock acquisition to middle of the call graph to sim=
plify
> the helper functions. As a result:
>=20
> ioctl(2) with SNDRV_CTL_ELEM_READ
> ...
> ->snd_ctl_ioctl()
>   ->snd_ctl_elem_read_user()
>     ->down_read(controls_rwsem)
>     ->snd_ctl_elem_read()
>       ->snd_ctl_find_id()
>       ->struct snd_kcontrol.get()
>     ->up_read(controls_rwsem)
>=20
> ioctl(2) with SNDRV_CTL_ELEM_WRITE
> ...
> ->snd_ctl_ioctl()
>   ->snd_ctl_elem_write_user()
>     ->down_read(controls_rwsem)
>     ->snd_ctl_elem_write()
>       ->snd_ctl_find_id()
>       ->struct snd_kcontrol.put()
>     ->up_read(controls_rwsem)
>=20
> Change-Id: I6b39209aaf08afcbeca7c759b77bc96c67db4c77

The original commit doesn't seem to have this tag.

> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>=20
> Fixes: e8064dec769e6 "ALSA: pcm: Move rwsem lock inside
> snd_ctl_elem_read to prevent UAF"
> Signed-off-by: Alexander Grund <theflamefire89@gmail.com>
> ---
>  sound/core/control.c | 78
> +++++++++++++++++++++-----------------------
>  1 file changed, 38 insertions(+), 40 deletions(-)
>=20
> diff --git a/sound/core/control.c b/sound/core/control.c index
> 43c8eac250b8a..a042a30d6a728 100644
> --- a/sound/core/control.c
> +++ b/sound/core/control.c
> @@ -877,24 +877,18 @@ static int snd_ctl_elem_read(struct snd_card *card,
>  	struct snd_kcontrol *kctl;
>  	struct snd_kcontrol_volatile *vd;
>  	unsigned int index_offset;
> -	int result;
>=20
> -	down_read(&card->controls_rwsem);
>  	kctl =3D snd_ctl_find_id(card, &control->id);
> -	if (kctl =3D=3D NULL) {
> -		result =3D -ENOENT;
> -	} else {
> -		index_offset =3D snd_ctl_get_ioff(kctl, &control->id);
> -		vd =3D &kctl->vd[index_offset];
> -		if ((vd->access & SNDRV_CTL_ELEM_ACCESS_READ) &&
> -		    kctl->get !=3D NULL) {
> -			snd_ctl_build_ioff(&control->id, kctl, index_offset);
> -			result =3D kctl->get(kctl, control);
> -		} else
> -			result =3D -EPERM;
> -	}
> -	up_read(&card->controls_rwsem);
> -	return result;
> +	if (kctl =3D=3D NULL)
> +		return -ENOENT;
> +
> +	index_offset =3D snd_ctl_get_ioff(kctl, &control->id);
> +	vd =3D &kctl->vd[index_offset];
> +	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_READ) && kctl->get
> =3D=3D NULL)
> +		return -EPERM;
> +
> +	snd_ctl_build_ioff(&control->id, kctl, index_offset);
> +	return kctl->get(kctl, control);
>  }
>=20
>  static int snd_ctl_elem_read_user(struct snd_card *card, @@ -909,8 +903,=
11
> @@ static int snd_ctl_elem_read_user(struct snd_card *card,
>=20
>  	snd_power_lock(card);
>  	result =3D snd_power_wait(card, SNDRV_CTL_POWER_D0);
> -	if (result >=3D 0)
> +	if (result >=3D 0) {
> +		down_read(&card->controls_rwsem);
>  		result =3D snd_ctl_elem_read(card, control);
> +		up_read(&card->controls_rwsem);
> +	}
>  	snd_power_unlock(card);
>  	if (result >=3D 0)
>  		if (copy_to_user(_control, control, sizeof(*control))) @@
> -927,30 +924,28 @@ static int snd_ctl_elem_write(struct snd_card *card,
> struct snd_ctl_file *file,
>  	unsigned int index_offset;
>  	int result;
>=20
> -	down_read(&card->controls_rwsem);
>  	kctl =3D snd_ctl_find_id(card, &control->id);
> -	if (kctl =3D=3D NULL) {
> -		result =3D -ENOENT;
> -	} else {
> -		index_offset =3D snd_ctl_get_ioff(kctl, &control->id);
> -		vd =3D &kctl->vd[index_offset];
> -		if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) ||
> -		    kctl->put =3D=3D NULL ||
> -		    (file && vd->owner && vd->owner !=3D file)) {
> -			result =3D -EPERM;
> -		} else {
> -			snd_ctl_build_ioff(&control->id, kctl, index_offset);
> -			result =3D kctl->put(kctl, control);
> -		}
> -		if (result > 0) {
> -			struct snd_ctl_elem_id id =3D control->id;
> -			up_read(&card->controls_rwsem);
> -			snd_ctl_notify(card,
> SNDRV_CTL_EVENT_MASK_VALUE, &id);
> -			return 0;
> -		}
> +	if (kctl =3D=3D NULL)
> +		return -ENOENT;
> +
> +	index_offset =3D snd_ctl_get_ioff(kctl, &control->id);
> +	vd =3D &kctl->vd[index_offset];
> +	if (!(vd->access & SNDRV_CTL_ELEM_ACCESS_WRITE) || kctl->put
> =3D=3D NULL ||
> +	    (file && vd->owner && vd->owner !=3D file)) {
> +		return -EPERM;
>  	}
> -	up_read(&card->controls_rwsem);
> -	return result;
> +
> +	snd_ctl_build_ioff(&control->id, kctl, index_offset);
> +	result =3D kctl->put(kctl, control);
> +	if (result < 0)
> +		return result;
> +
> +	if (result > 0) {
> +		struct snd_ctl_elem_id id =3D control->id;
> +		snd_ctl_notify(card, SNDRV_CTL_EVENT_MASK_VALUE,
> &id);
> +	}
> +
> +	return 0;
>  }
>=20
>  static int snd_ctl_elem_write_user(struct snd_ctl_file *file, @@ -967,8
> +962,11 @@ static int snd_ctl_elem_write_user(struct snd_ctl_file *file,
>  	card =3D file->card;
>  	snd_power_lock(card);
>  	result =3D snd_power_wait(card, SNDRV_CTL_POWER_D0);
> -	if (result >=3D 0)
> +	if (result >=3D 0) {
> +		down_read(&card->controls_rwsem);
>  		result =3D snd_ctl_elem_write(card, file, control);
> +		up_read(&card->controls_rwsem);
> +	}
>  	snd_power_unlock(card);
>  	if (result >=3D 0)
>  		if (copy_to_user(_control, control, sizeof(*control)))
> --
> 2.40.0

Best regards,
  Nobuhiro


