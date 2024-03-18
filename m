Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8F6C54E58
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 09:31:23 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.70])
 by mx.groups.io with SMTP id smtpd.web10.39114.1710754273906115032
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 02:31:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=pJySBarj;
 spf=pass (domain: siemens.com, ip: 40.107.20.70, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj6YoxtdMEfwswG1p9CuHlnIYuyLeeAmeD5awDW/r6BHBDScmR7HRTDWZyMuHcVrJX+xf5YnUSx0A6A8Kl1HHwhMo/+eYj64x4XfNhhjPK3yX3WDxNOn2vQejA/9YMztbz+7R0q5orrV/X6AIWysEPF1+iSOW6zuLWHCxsFNfiaUlETogt1fVIQMQuv1txx15rAOFv0nvcchSa6uXn4VOU2Kfbtaidcv36zmqIjF6HdlTHKxnnzTp+r8zF4iZe5ZoViPDmdU655u3jjzNCtQNbU2f57WDTVEdlWK2ljEffl0bmYpsXFxnJShq5lWa9PL0IoL3ynxPNjL5lFfQgKXPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/vhqN7GKmuiGCVWATvLH91buZt9GFQ2op8v/kg6Z8CY=;
 b=h5Cl9vEo5uFmRPnfGb6VtksUfoY8ltP3vPvNnMrZdIfWmNL31y9a1+7yVxklwHtortYS3G9CPUAh64Yjx/DxlGXl1SlFWqxzKjt9NojhJTFQePZmnZzXbsD3yJEEYijMG9ci9iHExThmcLFLwh1lEDp+itmVyKE+ByeFXMieGY1fmMAJwpSxp6se0o8RXDcilhay21fPPNYJZI9yrsdCu7JfXJPQac9R8SCBF5sZeqYjtNs7uiLarghIWtNEv7YU7NMa0PR8qV3lk4M5XTBOAj86byJZ/WHr0rkjVwN2H5bQkJOO9k2xaqHCeMKvQRvcs84HLzJfoWtdGYSvhiPyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/vhqN7GKmuiGCVWATvLH91buZt9GFQ2op8v/kg6Z8CY=;
 b=pJySBarj+mEVvPgo2qGiU94WRlxqpmm2Z3KtvUXr0mCfZfOgwFLJ6q9hPwtizB8+/7MWMRg2giG/ot4jKShEP0jVsugXSL3TC+BCjmZI1HJ6NG9pfqzJWuvCmnFDwVedemCvmKhNJTUmWRVTGeNspfvqVzGuWqOGz7bmiic8J4X7Rj9w8x9KKNFpQh0VoRw3ohsfig4Cv0FePfiNLaKmCVZWVLbgoDAkQHHuo4c4SwT3zvEBmzFXG2L5iij9/HSiiMqlFHxpvJ50yZVfaoa9wFx9mrN4Ukb8uLyi7/nKT1WLdGldxGsJQCjmQYggrxFEp4S193Qr+gfTAGQiKKXBmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PRAPR10MB5226.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:31:10 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 09:31:10 +0000
Message-ID: <5fce6db5-e84e-4848-b298-d29386c7028f@siemens.com>
Date: Mon, 18 Mar 2024 10:31:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/6] conf: Use bookworm
 backports for enabling delta handler in swupdate
Content-Language: en-US, de-DE
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-2-Adithya.Balakumar@toshiba-tsip.com>
 <7a8e08bb-0d82-49c2-be8c-03ecb9511304@siemens.com>
 <9924d25c-a95b-4c63-ae89-98076ce75c38@siemens.com>
 <TYCPR01MB9669ED46F3B0AB77E7B49B65C42D2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYCPR01MB9669ED46F3B0AB77E7B49B65C42D2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DUZPR01CA0192.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PRAPR10MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: b71df75b-3b23-4dbc-a468-08dc472e25a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xGV8CRX2pIya8fb0knYgXZrMxsxLj6D2K9z8navODlJE1x6wyII8mGag5kWYa6FgM7qKqdjdYoCjQou+bgyp2lQKR1ZvlISLYc98UiaLDHgRGePHVYLxK/n97qjrF/BUcoSjGDJOcphtbOgX4yKGKCxbOoUwBiToptiXJs54cmwbb2z3VJIMpgZiyAi4P4C5vhwkaBLJQzC8iRzrZy2LzBA6mXqzWzh2lQTz849Esutoxs5BO/j/D36XOTCNUda0oXaZc7+VrUh243b0N0Qj0gW2yIPH8PpfiJHIz9sJwJ7UdIXmSUkGgVuNo0cEMHkwnTm+Mqmkl59HUkSPKogvVlELD3Dsxe0Cf70pDLjed94y1xAFQ/4EFLWsMOEq7eeLgFV/qc+8dmS8Pm7/wftz3WKrnrfiB2BZhDfQTp2U/ICBAn445qmVDPoIzDnWrQe4suP4qLhRzl1ItVYyD7CbIwQQfDD6Hpo3OLmtuD7k0hcfB1METL/Vaug+xSH4vg8ogUo8Mgiwm/sGsoC7QNPr/TboyI6cmmOJtEiNvFtWGP1no91huUWuE7VsAg8mdyXFweOkxMKSdB3YdQDH1qmhaFkaGFcnxMnY/TcHUkFLsAM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/5gHdt3nGrYrFtokb8cFwDJPCRwfbE2QaGuNu31nkGxgd+88Yt7cdzT+YeCT?=
 =?us-ascii?Q?GLDfT+WZd20KeSLsJpfiAqBNsZIuvTjLUq4cBhZxJ4/Lh/aXzaI9qrXVty+T?=
 =?us-ascii?Q?Nb+jiCgkz9KM/L1I/7I6OAfD+edSWMjQrfCb8WvL/SpwK4aa7MVUOvYK1ruN?=
 =?us-ascii?Q?Ms8HJcaRtF5HllNdWSKlYjg+0UCg3NgblKseCTIFAnmt3ScOani3QU7oL49g?=
 =?us-ascii?Q?cmUrI0kdeEykMyhrQbQK3GMUojY8H3U9WjiJKfhMrqsOUyXsbNIJ0d3Wn29/?=
 =?us-ascii?Q?Iau9tjCmWN/OKommnIRLvE292gF5+wqp6bX99pi7nYtclDjQhzFksmA3/PcA?=
 =?us-ascii?Q?/CGwu2VYOBxzOsSiAvEV0YMog/prrvhJQEJaCh130Ry3Xae3ylNWK00bQLnH?=
 =?us-ascii?Q?Q7Mwa6PRkM5IqwJhhsiCqNf03rLpXRtqMLpkwIvFgM+GhNaJI7vbTNwOwyoW?=
 =?us-ascii?Q?5ZXJTJtLyb/5Cf5XWMBcXS05CCsQPxa08tmAk+/IvToD675lgkg47VXBG/0V?=
 =?us-ascii?Q?kwrw2dT6R05SxlL70Ngci2cibqn2hvTzGaDESu3Edlj/SZbJbyCJxQH1lrnm?=
 =?us-ascii?Q?nj7lBY+X15oDA71dn09af0JM1lV62HEkq14yIwPQc+2/cwklbApbPGhC+pHW?=
 =?us-ascii?Q?sxTGVMSaX3dj5gCjsqrQcbvrhWjcjRO4IAQRM60uysYWrEfxvZ5eopKf+YeZ?=
 =?us-ascii?Q?dsDAbceCCLgfbDYZjV574JPYZU6hDYKC9T8oBC5Mv1oKFEbLBfzzGNiTi6Nt?=
 =?us-ascii?Q?yA7D506nTWP4mGBbXvQ3OJEa9reDi+kTHh/kI37YOZXIfsvkA1GpkGLX38ib?=
 =?us-ascii?Q?W8cs2RI33JbE4quFtI48Jj4h1PfvFxE0T8xZw7nmaTDFhJbTLVxma9J/aG+b?=
 =?us-ascii?Q?qyUegA/7iQxbbNB+ERYnlQnZFGnwPuTVEX3KJ8eQG0rSZCLVoAxxkw4W3RaM?=
 =?us-ascii?Q?FIyhzNmrCMSgJpOQt/ENeabmdUbj3uPWszP3awbfwcRAazYJT+3XzQsTJpaS?=
 =?us-ascii?Q?vNO9umKW6d3FdIiLi7enpktegKuT8xk5SzeoVGx8M9AuTXRz0jbo1HAugHcr?=
 =?us-ascii?Q?Ewdm+KoFMrJ397+wux+jmzZmzhVMvEcSMe2k+Ece9IjhGi7RwgFCU6IJodC6?=
 =?us-ascii?Q?dJyJ2JvUTVQqf6+TOLhvkccrXAbMrmr/wlrUItUnvBIJdZzrxgfE/ICvu9aa?=
 =?us-ascii?Q?FoyFwyqOGzBWSRZA4fYkASNZ26lfscvDiO8liIHPXtmJcdDQdPM52bsocffP?=
 =?us-ascii?Q?az4Gs2wjl6DuvCfay3TLrP08eyxUTLVKt2KiH/DxIk6s21hu+39PrcxYyk21?=
 =?us-ascii?Q?QVw8oGlEP6vbB5TKg+L9w6LD4JnKDCzCVPJW9FiFqt8YLMsCor1+wDlbPNKR?=
 =?us-ascii?Q?+kjRMAmLUy3e0+Am+DLsI2HGbJR/aSoNXJAl/ebM2Wca9J+ryvOVV7/fgKik?=
 =?us-ascii?Q?y9EPW5x8gIDpQLWM5sn2461231UJ45Vmun+nhxYzq0IX6ps7dN0geDpt4ahp?=
 =?us-ascii?Q?75Zu4Rm2Kj85plYHYk73AqECYkl+ZCP2nASBcphHXzLIncy5TMUMBKMNxn+P?=
 =?us-ascii?Q?81TfFD+l0RQy3vjFj5q5jRAR00rVbFVr6Vk2pMadI8TZC+EYMEpWO+eUs4WD?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b71df75b-3b23-4dbc-a468-08dc472e25a8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:31:10.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+UVEq27XPuAikVzVoqp/7LblJvbIcZevY05lrxAgQP8K1qWMb0c0cke/IKQKZzoEynxvyWHXEINwD0iOs1fALnxoKZ1J8Wl8OVS019F5f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5226
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 09:31:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15336



On 3/18/24 6:02 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
>=20
>=20
> -----Original Message-----
> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
> Sent: Thursday, March 14, 2024 1:26 PM
> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR) <Adithya.Balakumar@toshiba-tsip.com>
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/6] conf: Use bookworm bac=
kports for enabling delta handler in swupdate
>=20
>=20
>=20
> On 3/8/24 12:35 PM, Jan Kiszka via lists.cip-project.org wrote:
>> On 07.03.24 08:46, Adithya Balakumar wrote:
>>> Delta handler requires zchunk > 1.3, but the required version is only
>>> available in bookworm backports
>>>
>>> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
>>> ---
>>>    conf/distro/cip-core-bookworm.conf                   |  3 +++
>>>    conf/distro/debian-bookworm-backports.list           |  1 +
>>>    .../preferences.swupdate-bookworm-backports.conf     | 12 ++++++++++=
++
>>>    3 files changed, 16 insertions(+)
>>>    create mode 100644 conf/distro/debian-bookworm-backports.list
>>>    create mode 100644
>>> conf/distro/preferences.swupdate-bookworm-backports.conf
>>>
>>> diff --git a/conf/distro/cip-core-bookworm.conf
>>> b/conf/distro/cip-core-bookworm.conf
>>> index 9bcf559..e0a4f7f 100644
>>> --- a/conf/distro/cip-core-bookworm.conf
>>> +++ b/conf/distro/cip-core-bookworm.conf
>>> @@ -12,6 +12,9 @@
>>>    require conf/distro/debian-bookworm.conf
>>>    require cip-core-common.inc
>>>   =20
>>> +DISTRO_APT_SOURCES:append:swupdate =3D " conf/distro/debian-bookworm-b=
ackports.list"
>>> +DISTRO_APT_PREFERENCES:append:swupdate =3D " conf/distro/preferences.s=
wupdate-bookworm-backports.conf"
>>> +
>>>    PREFERRED_VERSION_swupdate ?=3D "2023.05%"
>>>    PREFERRED_VERSION_linux-cip ?=3D "6.1.%"
>>>    PREFERRED_VERSION_linux-cip-rt ?=3D "6.1.%"
>>> diff --git a/conf/distro/debian-bookworm-backports.list
>>> b/conf/distro/debian-bookworm-backports.list
>>> new file mode 100644
>>> index 0000000..c4873b4
>>> --- /dev/null
>>> +++ b/conf/distro/debian-bookworm-backports.list
>>> @@ -0,0 +1 @@
>>> +deb http://deb.debian.org/debian bookworm-backports main contrib
>>> +non-free
>>> diff --git a/conf/distro/preferences.swupdate-bookworm-backports.conf
>>> b/conf/distro/preferences.swupdate-bookworm-backports.conf
>>> new file mode 100644
>>> index 0000000..b6efffc
>>> --- /dev/null
>>> +++ b/conf/distro/preferences.swupdate-bookworm-backports.conf
>>> @@ -0,0 +1,12 @@
>>> +Package: libzck-dev
>>> +Pin: release n=3Dbookworm-backports
>>> +Pin-Priority: 801
>>> +
>>> +Package: libzck1
>>> +Pin: release n=3Dbookworm-backports
>>> +Pin-Priority: 801
>>> +
>>> +Package: zchunk
>>> +Pin: release n=3Dbookworm-backports
>>> +Pin-Priority: 801
>>> +
>>
>> Backports are bad when it comes to use in production (they receive
>> best-effort updates only). It this the only options?
>>
>=20
> As we need only backports for zchunk i would propose that we support only=
 rdiff based image for distros <=3D bookworm. The zchunk support can be act=
iviated for trixie and later.
>=20
> Quirin
>=20
> [Adithya Balakumar]
> Hi Quirin,
>=20
> Since we currently support creating sid images in isar-cip-core, would it=
 be ok to enable zchunk support only for sid images currently?

sure that also would work.

Quirin
>=20
> Regards,
> Adithya
>=20
>> Jan
>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#15264):
>> https://lists.cip-project.org/g/cip-dev/message/15264
>> Mute This Topic: https://lists.cip-project.org/mt/104783336/1753640
>> Group Owner: cip-dev+owner@lists.cip-project.org
>> Unsubscribe:
>> https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/14052693
>> 26/xyzzy [quirin.gylstorff@siemens.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

