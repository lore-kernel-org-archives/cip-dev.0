Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFE7D43369
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 14:32:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.61])
 by mx.groups.io with SMTP id smtpd.web10.73448.1730989953634682328
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Nov 2024 06:32:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GXmH9T+P;
 spf=pass (domain: siemens.com, ip: 40.107.22.61, mailfrom: alexander.heinisch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8+N0j0cRdR8AwGEe4cn2/qRIcSm8oUX5/PV2M5B+BA5ffUrOssKbUKKozmTcOMYr0OK5sgyqwX0+KQoij2P+rvsRKATKBYlAEc0s9RL+w8l6UavpLIY4u9vNsQ30ix1nWGYFebLcH5BaZMv7r5c4JdkFTuyjQOGm+jzJelOwm0pum4+7AFaNTjOx1ZiBcpEjKz6oQJy6V82IPgIbJtBkKNGtzs4TwUHQ1igQrFlgr+/JcQ35ry+TiOzDFfHbEuUWnGENLbMhURTcFH0zfTo1eIGAzKI0od3eYRuC6vEATgs3FW4ndsow0CUrEbEokyhJwhjWtgEzDee/edrjYUXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CB7apWjseTlCmdZ38XygXqXdUf9gnNR8ap0l+p8mRrA=;
 b=XYaJ/9CFNsQ7IHw/3DWUYmR/WY2yYE+5UWEEERzvoMPgRu0vakAkXmqEmePx46QjvN/blPvrm1iLoiwm2lrwBfg/oUDIU10Z29exiAUHFejRrSWI1sSKv/xBGtewrj64Yuj03QKWCqUfoDk5Q67ScGhC2CEf2Cl31/GXRgl9k7NVCK1zK/RZ/7DsihjlzUb5zB+Zg/GcN6Rg1eFrKU9gW6HqeKobQuKYvSMuXWK5BvocPuTKjx7uYOAAPW6QeIv0Oj/OHmXYMBoS2j4mPJ9dzyVXL6LJ5D4BUE6K2LyACfJ7mHT/sn5BK79g9QmKXlZvrj6WpCzqGxPwkTnY5ESb/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CB7apWjseTlCmdZ38XygXqXdUf9gnNR8ap0l+p8mRrA=;
 b=GXmH9T+PeUf6kj4uF4c/zZKAUguCsmZWr/K8iAw4+nsJq57N/6SFF5i+W8FqWKg6/Wk+5QPH1AYwkQDEy7DEzrWKK7Zqx8ygg3rtbEQPo8kNAgtUDX5ixZzxqzKn//sQHQZCT+HxAEfyUEmiQRbQy9dLMGbGfcsL28koVG0MNZTuHyTqFGlSOH+A8kdm64x0GUd+HK4xUNCeyrf6Vwvg9c6qlpBfTBQuwy9hQUZXKfNDHf7lbzQJfTu712YBP6CAMVKqUV+gZ5Wqh7ON/0teDNpb8ixKjxl9aFxva0i9urssGuDFwOHn49ROH1MGVZ9lb56o8zeCKcEfEFlM/TrMrg==
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10c::13)
 by PAVPR10MB7092.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:316::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.17; Thu, 7 Nov
 2024 14:32:27 +0000
Received: from AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0]) by AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3a6d:95dc:3ce2:6da0%7]) with mapi id 15.20.8137.018; Thu, 7 Nov 2024
 14:32:27 +0000
From: "Heinisch, Alexander" <alexander.heinisch@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Topic: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
Thread-Index: AQHbI+q4NaXgEhKYgkiz6PQsKD/HorKWEKyAgAAP2hCAFHuKAIABX72g
Date: Thu, 7 Nov 2024 14:32:27 +0000
Message-ID: 
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
In-Reply-To: <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
Accept-Language: de-AT, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=18fadf32-2cae-4521-90f6-7e0c2ef7432a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-11-07T14:32:05Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3320:EE_|PAVPR10MB7092:EE_
x-ms-office365-filtering-correlation-id: 4acd8acb-a25a-41f2-a079-08dcff39010d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?5/B1oLjWrZIGT02vNCCELT/8tRlqVvWybfdJYOLEnw8PfH15AS/tB1y8nolt?=
 =?us-ascii?Q?n5wMX1T/auLQx88BOEbWLrVh6CxOO2IAAzYKP6vpHf6QDfFyVUgvlopWwm/C?=
 =?us-ascii?Q?7TonVsqR/yhXBpbQ+KoaBq4uOleiccTbZZElxHmMSH6OEY35L/b5znnqgzaY?=
 =?us-ascii?Q?7n3EbX9SP1+XWcRatObuJZYELoHGMQPcHP9yPL5cZ+mtSQWskowjcF6WoyBg?=
 =?us-ascii?Q?bN7xSSHtgr58X4rRVeR9Ul08z47N9OzUDTw2n2gmwgxltrebkzDmrjuVbOno?=
 =?us-ascii?Q?mvKX3CyR14elq587WVhcZaQSTLroB1KndnIiKu+eEEs0zAozJTjlZAGcMdUT?=
 =?us-ascii?Q?fS6GiKZYh07wNL4AQMQ5YDe7+n0hw7FOFwfzhOrG/fhN/9bczH3KPBnPBRo1?=
 =?us-ascii?Q?ZkRcgB6Fb7A59bViJPnUzzQ9HCUiu2npEkcqaQbinZlJgovPCuojSFubQM40?=
 =?us-ascii?Q?S+ePiIWBUVvSleqAzJNLK+O0ePSjznKYYxvKdtld+HAg5Wq2qkg5si32Ewpq?=
 =?us-ascii?Q?uSdputjLVbqNVNkhfkz9lZE8xzdh19grCEaxL5mF1KQzEbjX+qi6YlQh2Xd1?=
 =?us-ascii?Q?zwQiHk/Hass3dMRSPQCLvXiORDqHXEpmXMrtz73z4bPr7/PlVo974gnNzhtU?=
 =?us-ascii?Q?n41e3d9bbBJ2g2xUH1J7IzkM7OduEjK0k9PO8RXzrgFqXFuP/uYQiMnRgWvJ?=
 =?us-ascii?Q?dXQSCkbAfwIqiuHQV+sYO9dKfipXuD/GrBovWcWqVCtpRMuQIM8Shs468zQQ?=
 =?us-ascii?Q?P6cszy6jti8m/95NpqvWkamFgijmNtvAGxrhu88WQM+xiGtpqzXJkfzDGrFT?=
 =?us-ascii?Q?PzLd6BMyd/BWXTzswkuQECi3H3vRP1v0Ub2iRbELQ9d/ScZz2XkehXzY9wRM?=
 =?us-ascii?Q?vcRSH5U4Hcd0T8oQIugX1BYLicFz3XeHfBYAvgcwiW3kHSWs9LPKoiCTu1Vc?=
 =?us-ascii?Q?flAVI+YV75Tmz0mW0cre16/CZtuxU2dhkXILw+tUo3tN7urbaVHdqiPf09SS?=
 =?us-ascii?Q?wCwdlsvIhhU8/wEXDDBOgHTdcrUFq+FlFboscfxlBZKAikpNsbdjJFeuxnCR?=
 =?us-ascii?Q?qJ91ImsJuiqE1uRRt+QtDG9TDPdoYhI/EjQE1QmQR3jvUgWa6Aqp/mQH+VmD?=
 =?us-ascii?Q?SHDoW/FE19NyYS3aWHjpcMcv/dkkOhEW09W81XdQq9mh5XUWauDIyJ/VovFE?=
 =?us-ascii?Q?YntaNx/TwEJtbiBVrQH5N4XHOvhnI9YvK8VrVRQKKCNquEfd62x8ZpT9bYjU?=
 =?us-ascii?Q?DttQx4i9eeaL5rLOIN50bq3+jZdGK28qRo7QsGTJ3QfKvr03+vTtGtkoMCtK?=
 =?us-ascii?Q?SpsjTC5uQxMKZJcBSZms1i5+?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+vmNT5tzpvtUN10UvdwOUEZUiY0GfsCEFMQRIqDSAS6B9XjXpiNiv/J7SxQx?=
 =?us-ascii?Q?6dWGzOymcSu07n8WP7O1jVterc5IIbt6dzVLHFZBEylrXZ5NstGyd+YHT0Cb?=
 =?us-ascii?Q?NUrTb5Y59apVJ8NnBaKLhARK/W7wSuFuAcb1ybF+z/ngJOE5okVpuK4u9IzB?=
 =?us-ascii?Q?UTyda3XnrFoK1K9z1NaN5abqw5KjmAltfrMeixT8sfE1EhtqVdra788Oye7i?=
 =?us-ascii?Q?lOLqESwMRrctGPyazDYnlQfoJxBhp4ymziHCSqE8DMIdH+CQWWy7nPzSeLPV?=
 =?us-ascii?Q?rJAXws34A/1ZakbHhavsyM42dZLiVqpfwWv1GiHK0F8tt8a3W4WH71wGBpF8?=
 =?us-ascii?Q?mzufQ3D/N+M5Gk90g+t8KZgTjlIb5PAVGlBXYY3vFkuyw4iqOB61mWXqpVrK?=
 =?us-ascii?Q?cfzKDWF8/7ns2E/tLcOeuJvtZk9cn5aN1xQUmjMhKDaZ8PqYG7ujtyur/2YB?=
 =?us-ascii?Q?YO34q+OqSlGDAFCa622ikLE1AqoQU9fzdDd8HSTp2mSgI8dvEyvZ27n9Aic4?=
 =?us-ascii?Q?NPXi4yhjRDpcnNc8eiWXSAcWnImPaFXThm9KqpaX+TcGBekZAbmlKhREbmtk?=
 =?us-ascii?Q?+X0/I06EaO9IZfmBSy6tIZuaAv2jrvjAWdgsXyxWN9ErZEdR/mBMjcyAuLER?=
 =?us-ascii?Q?zxTbP5famHET3emEeO05dn7C389Ou+w0OMMw7ArMyOW+SQjdmbMtTz828SZD?=
 =?us-ascii?Q?G2lzaRFmR0RWaWouNEMAd8UWwpw7ZWZnMgIpdjhRFaOs5jHgu4uqoGddzsz7?=
 =?us-ascii?Q?EiiI0vhVQ4/xz6b0zSsL+ZmEvO9GzAziW9r0PIbcS38rzeDrJlhLe+CLwXry?=
 =?us-ascii?Q?ZoPszXRqtwrbrTkz1Kg12oCzmvwuk0d0g68JQ9Ea92LvjKawraHW7y6mTQqJ?=
 =?us-ascii?Q?Oi60ad851DbwLSXhBiPk5aXNM7DiiAJrs7yHWxa+5Fh+rDfb8wZheDLxflZa?=
 =?us-ascii?Q?Xu6mdWWx3hzffDFZQsFrUOsymUFdgfedh5noSY/tW6lKfJOed5n5xy/uxcpl?=
 =?us-ascii?Q?uzANpWhg48Olakf9XiV60u0QntIgVvRcxhVsgm48U+fB7Ptm/i9Lu0Tizdcv?=
 =?us-ascii?Q?rU9pglKYuG4+lSQxsYr4m/lKnt7A1VFepo0OXJtp4eJxBBVEH2q00GVWiSGt?=
 =?us-ascii?Q?AhTstXnxIY8xzn59eSK4sGJ7OuJ51CAXy9mLXNB/VHtowVvide3thlxgCSDn?=
 =?us-ascii?Q?kZpmSezugjpibsVqa1m9/qeQUqFxz/93lHSK/byMWZo5dE78DcENqq19rj+z?=
 =?us-ascii?Q?kkAm3VFWHkGct8apzLbUCxZO+T25uIKETMPtPqUEm/anbi7TVYjVN0/v8xB/?=
 =?us-ascii?Q?9KCNPqffeGpuwmh+EWfzOAagHJhNgiBmc5ZS6YaRTX3eEuDyYTTutEEIpwPT?=
 =?us-ascii?Q?PCb2tcwenP/FfZPrMBi+Npd2067Sw/ctkXuhLYc7ijHdlpdLfhU9j6RDpfxq?=
 =?us-ascii?Q?tuvL7emJyPo8xRUY8Rz7zgJ51wuNPPG+cOTC0WVNBB+zIyNifz/xLYRWVHKo?=
 =?us-ascii?Q?OUUEGwpZoVnNDCQZSgCtHhDH5er0VmffeQ+Ew6mektUIEitiQ2/MZsdxgtAN?=
 =?us-ascii?Q?1LORlxChdKCFaqldbE9wl4oxRZinaaUjHAKP8udHFbszGoKKtyh5ysWrtey6?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4acd8acb-a25a-41f2-a079-08dcff39010d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 14:32:27.5198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brjXl2rYClWDI2eWcsKcf2zoWdndUtZsxMa1sE6JiTplqOwBBM5zksJaNFjAFkk9A7XgEbjcEXRiBaU9R6mcq+aLKMzP5iXGBtYk23Orpc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7092
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 14:32:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17221

> On 24.10.24 18:58, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> >>>    Unfortunately, I could not find such library anywhere! - Therefore=
, expand on first boot and similar,
> >>>    still won't work for current disk encryption implementations for b=
uster and bullseye.
> >>
> >> There is no clevis library as clevis is more or less a bunch of shell =
scripts. If you want use expand-on-first boot with clevis a solution would =
be to extract the passphrase, see [1],  from the tpm2 partition enter it vi=
a a environment variable.
> >>
> >> [1]:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
t
> >> lab.com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-%2Fblob%2Fmaster%
> >> 2Fdoc%2FREADME.tpm2.encryption.md%3Fref_type%3Dheads%23steps-to-conve
> >> rt-clevis-to-systemd&data=3D05%7C02%7Calexander.heinisch%40siemens.com=
%
> >> 7Ca83978638b104123b3a108dcfe891659%7C38ae3bcd95794fd4addab42e1495d55a
> >> %7C1%7C0%7C638665111935069295%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGk
> >> iOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoy
> >> fQ%3D%3D%7C0%7C%7C%7C&sdata=3DynIFg7PJa3BefAF9GN7s7rB0E2TeP6%2F4G%2BHD=
A
> >> vNBRxA%3D&reserved=3D0
> >>
> >=20
> > That means a bigger effort on `expand-on-first-boot` script than just=20
> > setting the correct package dependencies!
> >=20
> > Currently, we are using systemd based cryptenroll in our project.
> > So there is not too much motivation digging into clevis for that use ca=
se.
> >=20
> > Still, I think fixing the issue for bookworm (systemd-tmp2) is better t=
han not fixing it at all.
> >=20
>=20
> Quirin and I discussed this a bit longer today: We actually should remove=
 the need of expand-on-first-boot to access the key again. And that is also=
 due to an idea I picked up yesterday to lock the tpm secret after initramf=
s so that we reduce the risk of leaking it via the main OS.
>=20
> Our plan is now to convert expand-on-first-boot into an initramfs hook th=
at would then come before the crypt-hook, thus would only work against the =
unencrypted blank filesystem - problem solved, just differently.
>

Actually that's a good idea!
=20
> For now, also for trixie, we will just make the dependencies of initramfs=
-crypt-hook release-dependent in isar-cip-core.

I guess this is the patch [1] you are referring to?

Just to be sure, still, the implementation of the initramfs hook for expans=
ion will be in isar?

[1] https://lists.cip-project.org/g/cip-dev/topic/isar_cip_core_patch_5_9/1=
09441764


I am currently using parts of the expand-on-first-boot scripts in a=20
device bootstrapping [2] utility in isar-installer-image
Unfortunately, that utility is under heavy development right now, so there =
are=20
no patches ready to upstream at the moment.

Nevertheless, to reuse as much of the functionality I provided [3]
back then to reuse the image deploy scripts as much as possible in the boot=
strapper.

[2]: https://groups.google.com/g/isar-users/c/ta0G_KGS_yU/m/5HnEK09BCQAJ
[3]: https://github.com/ilbers/isar/commit/8a170f9d634b56fc1445b4e9674d73c9=
9257a9f4=20

Similar will apply to the expand on first boot scripts (among others)

If you agree on that, I can provide a patch for expand on first boot before=
 switching
to initramfs as well!

BR Alexander

