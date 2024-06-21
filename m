Return-Path: <biju.das.jz@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B68C2BB85
	for <webhook@archiver.kernel.org>; Fri, 21 Jun 2024 06:51:17 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.89])
 by mx.groups.io with SMTP id smtpd.web11.67026.1718952668068585168
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jun 2024 23:51:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=eQSSd1eE;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.89, mailfrom: biju.das.jz@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSqQGokFiHbdQLtI0s37f/62JA1eYjFluHdBKv1MWXFZqCUSpXggbFcPj8nEvqIXgU3q1B93322J/gTaANfP2RUivXeOeFDdhmNl1fYmcYo1JZqB+JGP3qjCx/6wNlLC6JggwiYZsxqxw8kOj+2bXGdsm7tV0OCS4HsDWKyhIbMWzUmBmS4KpO0C19mZ5fuLd3vO/3KJ7Jj5CwaVUaEuJAcaYXLu09RFZkyq6pRsHa34y3uSyQ3FjLdT1YS5abLhWiAztCJVc0BUUCSVWkCy7k1lnVQKHhjGts8ceJLPjaRrWNcLXIfsBUP0ttY0uQOIecmESq1zs9RFIeYAtcae+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8Is4mnbb/GzEX9Wz7J5x34wUA3HjdKXWLHAa6uwTDo=;
 b=df3XB5f234TMncHd7sXhdNtsp8In3SLs6rB3UwJdWo0QjP3gPjjKC9VTRTH8MFeJCi/TaPhe5YgNTKZROo2NaYNZLqveJs7pS6biBLIRdIBbIGVsSXGNnHTGZkCXZav02RrPnpmfiMBPlST8sEQyQYwA7UbCUDYQAR2uxXNzSSJHJh/Vy/SfWMo9F6aHL0H0x1uJ6E7tq/R0K7+kkd/n7JzmW4gw7z30l9dLzANAv9l31RDmiFSdVtMjmQdoENCU1+Skz3A/RJcGRov0KFSzT8EGndwfPhGcuup0D5A8A1ZvVL2bvq2DWRd95juHSrXIoxjm6EwrTlIOevgm/IU+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Is4mnbb/GzEX9Wz7J5x34wUA3HjdKXWLHAa6uwTDo=;
 b=eQSSd1eExKEV2VwXj3DCcfERTGy+LVLnhC573hj+FmZCEf8fM97KktjvPcsYjiYHLcoCjWylcosO4hpOorI9Qw9WiegzQZOah9xarm/YIIvRbitD7dLzCOtFb6sQWPT90bXI2xffWrfMcVZqa7e0e8Bm8fmEG2FM3kMasJR9gNo=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by OS3PR01MB8842.jpnprd01.prod.outlook.com (2603:1096:604:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 06:51:02 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%4]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:50:55 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: Pavel Machek <pavel@denx.de>
Subject: RE: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the
 atomic flag
Thread-Topic: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the
 atomic flag
Thread-Index: AQHaw351dIlWuyV8gU2U7swIp7/B/rHRxo/Q
Date: Fri, 21 Jun 2024 06:50:55 +0000
Message-ID: 
 <TY3PR01MB11346BC663CF26EE6E197A05086C92@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: 
 <1718935080-25727-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: 
 <1718935080-25727-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|OS3PR01MB8842:EE_
x-ms-office365-filtering-correlation-id: 88738fdf-13ab-47f5-9c2d-08dc91be7ff6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Q9I0JxqxJ7IyP5bGj2GhIk+cIDkSGetwfZpsa0P65QqlZivqROYTa1FdyOzq?=
 =?us-ascii?Q?wizgvwUlz3pmHLSWDGkGv8v3Dtm6Ef/6B/PmzKeTlE1xIiQEEGnYZh/PKuIo?=
 =?us-ascii?Q?en2ttNTlF8qSwfEn9gD43RVWwZUpkcs5NGHh1Ct2HYhB/waFZJroLffGXZzJ?=
 =?us-ascii?Q?WGsG4SUxv9Jgi+vGN558Pa7Aze5XZIq3fGTZ9VdLcpcHg/h+Q+E9qZfly3Mi?=
 =?us-ascii?Q?/fk6F/HwfGtsfZHR1AfZLk+bPyPUr2RYupYa52azi5qVOie8urzoPtMKiLLt?=
 =?us-ascii?Q?qD6Zfw+Q/XQu4UqaWAENFVU03T3nKXB/dYFn+2vkBDha7MnFhvqL/LkCrS3E?=
 =?us-ascii?Q?2QRMYCEyFKmaIobY9IHYfCN0CU1O6e9/y5YKwwvQvix9iqkLnAgxjtdSh915?=
 =?us-ascii?Q?O4YuC8Eam62AKodSXbAdKAb3IU5Kkgvi0O0+gVM9Pw99d/6faijLZ8eQIpH/?=
 =?us-ascii?Q?b21iXQv+JzlNdVOxdeSFgYZZOfKIBUmoTdH7N1jLHGNv9N5OYyw3onXdMaXy?=
 =?us-ascii?Q?v/8v2ni9ksnLyCgks1ix0jUR2BONUaL5h/siia/YGwTNreFkZFQQOByRpGOK?=
 =?us-ascii?Q?X/4Lljc2s/MuTPC23PZkowu9JpFYp9GjLa3JA4gBL5SqRbDuheiKov6COR31?=
 =?us-ascii?Q?kbIje96hFdB6LfvNUpG8AGCI0NKs6Lnk19puC/9a9p3YQGqlfJeiPH7h9pUQ?=
 =?us-ascii?Q?ionPKsLTZ4b9F91lFj5tBJ/fOW93cLkn7BqZDymXZHMEGJEHpReR78O4zjhx?=
 =?us-ascii?Q?iodyb3flIyXjI5bqrQWc/oBcNMalhtbrrZ4cqiXZVpE/3lciEciVAaFHuALq?=
 =?us-ascii?Q?dHBQJiFBuB68R3csOgTotPbAsGZbTSDwno3K4OF0ArUnlFl2zVi2GscQxz+m?=
 =?us-ascii?Q?+wkx51kZgcN6iCleOWLmS9C/Ovc6lDl9q7i5TVn52gflFegfZyNDWIwFqAv7?=
 =?us-ascii?Q?ScYjs6ZKv6FxMfShFY9BXKBMv5ZMXCrnWCCs1po2MJ7ZZz5X/XHm7R2x+n1F?=
 =?us-ascii?Q?urDtlITSQoOuHl2H3gI1/AY2tnhtft2/qVuazViR+3UlorPCQxIfZ9pYSLch?=
 =?us-ascii?Q?m8tgr6vIFnc7Ar5P+nPyHcBrw4/3nwuzjqn1ZapbuU4ogWZqXCG2EI4e4Bi8?=
 =?us-ascii?Q?HcRF9q+wU3jTrfTIlP6qBht9fKjIYsq54UsSi4CH1jTAxcy1Yhh/P9ZYF3qA?=
 =?us-ascii?Q?QjvDG4Bkpx++dMPsIy/2TyWErtkVCgVOIBxp4tk7F7/gTFUGbCcZ1O9CZROv?=
 =?us-ascii?Q?Z3ryCI88VVySM0iUK+XX3sJRcFGrWgQonq5oNACNZJaVRQbaiYz6NT1dlcPw?=
 =?us-ascii?Q?iobuTBTxGxolmGoGxPBA5xmn?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+BYMKoOLX9V/XK+hjWflO4ok6L126sgiDLAJ4wADOAJMicI6Ew2c0FR8yh1L?=
 =?us-ascii?Q?YS/rPcNdPgVdU9QpIl9oUArr+jHoLUYU0lTKFvw/Y2TkXEk4lKiC1wZ7dV9z?=
 =?us-ascii?Q?W3Z1JUOhswOeNKb2DCK8SRs/GiIFHXnxQyrtBHHxi6yXEkoUA6RfBJzt+9Qw?=
 =?us-ascii?Q?S31Gauv+ddzWTJ6HMXrY8BDBK7lMJO4rFERoz+I2GR6VtV7+m0OVlGfwov3z?=
 =?us-ascii?Q?pSJZDjNDcPmiEDZGsUt3vk/ZsGKur1Rk1E0GWDS9t6/y3RhUJiC8OiU6C9vC?=
 =?us-ascii?Q?2VPEV6P6EwvhSrZoblwlwcG2EdN9zSoeZ6v2XBrulTZ4uNNY/4UiUNhYPQqL?=
 =?us-ascii?Q?G/gZcIbtZxeyb/w5MgL2FfBAjF4LLzCnhGL51MLvvBHJZEsfhZAX2FcEoRmj?=
 =?us-ascii?Q?z5hCw9VFFlM5mQt0Wmgew9XUGFyYqkvek9xxTGn+LVMq5GPAjsBaopCKAqCA?=
 =?us-ascii?Q?bBpuXCTlAsCs/z4Bc4UccSQfx0n1n3SYVsXk1KUed0fYjMRfZpXGX0IjzdMb?=
 =?us-ascii?Q?dsPwDHBlliV7G0zyrKh5s1GHIGvpF4oMfn17dwOVZBmvaj/n3zf2mYUYHIgl?=
 =?us-ascii?Q?e7Knkv8UPc8jqAn4IngSpLHqaEEWvYie7Lp5ExB5Q11ho/PzvJJLTUAFQ0KP?=
 =?us-ascii?Q?49AAL/Fpo1Jkwrolr+Iq/Dti4FjrFLSk3+ziLB1tm7ruaqzZP0eEt+iak4G/?=
 =?us-ascii?Q?FLA+eNCyn8lxJeqAdlJF4DbP7UH0oEURKyAZVibY6ylUdr3JIBCS2v9gVjVT?=
 =?us-ascii?Q?cmnH3kkc1/5dkDd1dukmhR9+LuqRDNR5dgTyDGqmvqVkxuNSKzyPHzy0J+x2?=
 =?us-ascii?Q?wuRRf96TGf4R8y69I+eDnINYdOnB94NZz4+MpHDWD0u6l3XbACWHxyek9zyH?=
 =?us-ascii?Q?aZhDQhSITsoOD2Pzt/oDQ4XPBuzgOEjfaemLg8rAx1X6zvaRomgJbh3oIlQb?=
 =?us-ascii?Q?Tzosz/umwSMneqCg7pA+tWRf2Km0luFixJzU6JGxodiwnhvzq1biAGrFZUrq?=
 =?us-ascii?Q?o8upPPmev33eKcKFDX4mRDnMk2lrgvJaYtpJbrY8e+IDHu/n86D7iDnz25nu?=
 =?us-ascii?Q?6E7iMo7f4BciSBgI2heMBi5NZapeYwcta2B9QQ8J8zNFp9uMwqkfu8snQP3t?=
 =?us-ascii?Q?607moe2hxzYl6vjdGsQ6uT0UT4bAcE9VnP7cE15YJvNCvkO1yN4bpUldhKl5?=
 =?us-ascii?Q?N0vzlAgKl+Dgz7pl8PBC4w12UHXa1/VYaodtQ8VgbLZwSrrP4dxDgko3IHSr?=
 =?us-ascii?Q?pAMZPDyGAJdLNrQkaWx+clq6uvBDJ5s+zb6ifBtzlyRktPk7Sqv8rwV91xqM?=
 =?us-ascii?Q?sGk8w7XqHX4qj526Oao19qVwWwjs/llyKAJIpXWlv4972vcI7t9/r4QQ6PmJ?=
 =?us-ascii?Q?uztPzJR+RGBesi2siP3KeGax1K/PDQBodeDdkq/Rha/h+kJcIs3I7rXhJPWz?=
 =?us-ascii?Q?uTiQeOfEHyy3RVuxGiJV3IuED5ptPn5Y/65A/kRbqOv7oOiMZbTSmV/qqFoK?=
 =?us-ascii?Q?C58NXT/OySruJ4018dkBmsNGkHKBN9bigBrjaEDC3aLOjhhjN6dqXz4/5fQM?=
 =?us-ascii?Q?PXuM731L38gQ/hyDQOO26ZFOYVYo4BaUnpER5j4C08tpDPczAZPyXf935DC5?=
 =?us-ascii?Q?ag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88738fdf-13ab-47f5-9c2d-08dc91be7ff6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2024 06:50:55.6161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb99cN502hfm1YO4nerqVLwnM9MeY60KUm3yjUZchYRGC502rSOn0ZFNv5mRjWi/K5CFcMfcg84wxhR7N0JZrtQWbz/5TFeygAUf2p2LMe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Jun 2024 06:51:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16310

Hi Nobuhiro Iwamatsu,

Thanks for the patch.

> -----Original Message-----
> From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Friday, June 21, 2024 2:58 AM
> Subject: [PATCH for 5.10.y-cip] drm/amdgpu/virt: fix handling of the atom=
ic flag
>=20
> From: Alex Deucher <alexdeucher@gmail.com>
>=20
> commit e431eb8089eef1477082d6ae072ac252699b231f upstream.
>=20
> Use the per device drm driver feature flags rather than the global one.  =
This way we can make the
> drm driver struct const.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Link: https://patchwork.freedesktop.org/patch/msgid/20201104100425.192235=
1-3-daniel.vetter@ffwll.ch
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406210812.Au5U3OkG-lkp@i=
ntel.com/
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

I guess this issue is introduced due to [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/commi=
t/?h=3Dlinux-5.10.y-cip&id=3D2a78ff0b0ab60ac2fb3cc6ea6b4895e2a7e7e769

Cheers,
Biju

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_virt.c
> index d6f295103595..a95ada001b0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> @@ -47,11 +47,13 @@ bool amdgpu_virt_mmio_blocked(struct amdgpu_device *a=
dev)
>=20
>  void amdgpu_virt_init_setting(struct amdgpu_device *adev)  {
> +	struct drm_device *ddev =3D adev_to_drm(adev);
> +
>  	/* enable virtual display */
>  	if (adev->mode_info.num_crtc =3D=3D 0)
>  		adev->mode_info.num_crtc =3D 1;
>  	adev->enable_virtual_display =3D true;
> -	adev_to_drm(adev)->driver->driver_features &=3D ~DRIVER_ATOMIC;
> +	ddev->driver_features &=3D ~DRIVER_ATOMIC;
>  	adev->cg_flags =3D 0;
>  	adev->pg_flags =3D 0;
>  }
> --
> 2.43.0
>=20


