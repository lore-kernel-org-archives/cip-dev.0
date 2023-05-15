Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58311C77B75
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 23:50:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.6963.1684194637024631584
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 16:50:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 34FNoZu2015379; Tue, 16 May 2023 08:50:35 +0900
X-Iguazu-Qid: 2wHHnX26C9b5Tl4uXr
X-Iguazu-QSIG: v=2; s=0; t=1684194634; q=2wHHnX26C9b5Tl4uXr; m=AOC8sRISLrY6zG9EFndqTYpfpBo1xYpfQUrxSo/o0hg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1111) id 34FNoX61022084
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 May 2023 08:50:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EL6arxwy7qETnSl4P8r8B7cPvuRJpN7D8Q5TXdHHK0qle97nIYhuvlaSQ1SaSKSnkRDELPy3LngKB6XIokxG7e7x40mcrp6+IzNpS+GIOSVS5l5PH3VhJXlccwwm6Rh4+heHkAUxY//GF8NYcxldehcnnYh2FqWRcehqrrbUM5FpD/7vlVHyAdxc3Vw2JxBD/1NMtMm+OmigDCLCiywgWteZc7GFydspxW1maG5yzRc291vjBnMS+HX5KblrAZnFeO/tJkCqjZif+t/8laa/svArlC0BflDiTa/aN4l9LPOTfFY5/cV2iQTUGuHek+Vtl8HfumFbP0KUdoRchjvIBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XXDASl5/tqoGXqIbyfY0DYbnZuvE9XZYdXNHinpL1tI=;
 b=KHeyKmly/wxZx+JYjTXt4fx90aN/YuPItiudaRA8tQeM+uyjKXrl5e66in5Da2pnCov+v++9DK6BHubiUEAG1VA3ykB2DKMx4OlISCgJbiwgK9qWqDW114MPxA/9jlt945FCaqVE9/8vzg3WxwZkmiGoM7PbB0vRr9iPrR0PVLpdAftdMpfgQcnPD0bvO3S9xniU7sbB1PDx6cZD+CapFhB+ykom2CvZ9qVAYAb+l/ntAfmCldj0h24cU2OlGyMSRXgfdgGXot7oXc4oju07q6dS3b0wGev0ChvvVoQtpgSBWmwhhOTvJ3CcyAQKMlgRRdxZl3myQnm0KmgdxPdRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-kernel-config] 5.10.y-cip/arm : Add support for access
 control lists.
Thread-Topic: [cip-kernel-config] 5.10.y-cip/arm : Add support for access
 control lists.
Thread-Index: AQHZhyaYEhLxnLSqV0SHzHYNF+SZp69cAHTQ
Date: Mon, 15 May 2023 23:50:32 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420490AC577279E31A925C892789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230515121256.14413-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYAPR01MB6139:EE_
x-ms-office365-filtering-correlation-id: d554b40c-7fe5-4e15-74d6-08db559f2bb2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 drKxW16KraPQvc0DT9PMQKapqj2+SxPpWHbYdPjdlosw9r/++XK6V6Yyv/Wg0KypKJjCTV9NgCvPvrJ0LP10sUHPQ2uSQkNXrIwD+L5yrPudC8AlI3zxUYlV7q6aKKaIIoPzBNLwwp+m9qszf4EEU+l6xl2oGhQfRjvFbZ61+2mKJUn7kPnJcMdkAQs1xHQVvd37KRbnpKR+F3Pv5T6r8PpjLzGcp+MEvYI0FMSrX0COk0HVu8631hzI176RyKwODwv6jyFKaM1KF9kp8hqFC+qb17frEpVDxpdp2Ts6xPr2U7vhMeP09Znqe9NewEu+WKtsXBS+qIxl5s6wlU3tWhvhkXrcxcvIpE1RSSm2PaIcupZmBP9qDkwoVg/6LnXVzCt5CnILpqSySoLNKk9q0xSZBznqVYsNhaZ/fD/9VtlurYB6PzWab4INTLtSXoGkt5bjFZnMWsHjtkPJYDm8HWUfejoBw/t59xxjq8ytUlHYr+LyPzLQCexxN8Ksc3CFInmLxyG/uHPKfheUvV+vqrKIaPXRh473dwcPHCMLRL0CSsBnBPLte3a9MN3DOY+9A9uko7wCEBi9xl6fWg2NAvB/WURGIytIJk6vD72KvIX+IglWu4HBJCXayAvJBF317piTbjNTCmY6Aq8ngKRcqg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(76116006)(66556008)(33656002)(64756008)(66446008)(66476007)(66946007)(107886003)(38100700002)(38070700005)(53546011)(7696005)(186003)(6506007)(71200400001)(26005)(9686003)(83380400001)(86362001)(122000001)(55016003)(54906003)(110136005)(52536014)(8936002)(8676002)(5660300002)(41300700001)(478600001)(2906002)(316002)(4326008)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?STZ6VE5rbE1ZY0grVkxYMzQ3dGJaVWNhRHpZc2p3WW10UXNEM05wREVx?=
 =?iso-2022-jp?B?RkNyZ2F1MVozVm1aU01hTjl1d25WSkJJbTI3ZUtZK0hCM1ViaEJ3cU5p?=
 =?iso-2022-jp?B?ODlGMitHcjNzMDRSSWZwa3U3ZmFndEhkY1dIcGZ2Wm5XOXZibTdMVzBV?=
 =?iso-2022-jp?B?SFpZSUo2L3EwMEFxM0NKbGJPYTZ4cE1oTUV1MG1HeHZ2STF2OFJJUDc5?=
 =?iso-2022-jp?B?SUM3MTh4SHRuVDYvWm1lQXVRRWVVdUhmVVFwKzl2YXZXTVN1TUdYLzR2?=
 =?iso-2022-jp?B?c3R6blpyZWlaZVBFSi9kV1BCR0wxbjh2MHp5QlVMNSt6UTh1RnZjZTUz?=
 =?iso-2022-jp?B?N2tkcjBHSjhCQlV0cTM1VHBlekE4bTdzSnFMYlczVE5RUVQ4MGgvOWI2?=
 =?iso-2022-jp?B?cGFHR0ZyWmwwcVVZNnZNSyt0L0k5eTlrSkZGL2x2bXpFVUltbWhQWmJt?=
 =?iso-2022-jp?B?M2FnN0V3L0R6Y3F2WTBJemxNTzNsUU8vZGtLOUhnVTVtTWhvK2RUSWJC?=
 =?iso-2022-jp?B?cnpLVWZEWE5NWW91anZFZDhlTmlBS05peGFmcW83TEdkZjBYaGpORGJx?=
 =?iso-2022-jp?B?c2hsRGVuMkZNN2NlckQzRWU2NjhORHJ4RGlNMU4rMXdPK3pNMUUyYkpt?=
 =?iso-2022-jp?B?OUsyR29zWVlKUm81UHlGZEtPSHEzeVF5NS9URTdmQTMzdnFTYUoyY2Np?=
 =?iso-2022-jp?B?UGoxSlV3aFBVSXhmZTU0K1JsNkttV1djTzdtOGVwdFExKzdVd2lMc3FZ?=
 =?iso-2022-jp?B?anA0c3RVdWl1UnRoUm8wbkdXTmJtcjVrU0wwYjd5VUxtMFdEZlgrL0tV?=
 =?iso-2022-jp?B?OEN0bFFMMi9laEd4bk1reDBzdmVnOGd6UkFua2VqVklBaGNlNTVlWE1t?=
 =?iso-2022-jp?B?a3FsTjMwNkxtYU9ZQzg1RXJKZG5QclJjVmFPNXlvSkpMSm9CY1Qxdk1M?=
 =?iso-2022-jp?B?UTg5Z0tUVGRNTEFlNDJwemZEUmlGZUdvdU9IZWlEd2tQTmR0dXRNWFpC?=
 =?iso-2022-jp?B?SjFPaUphZEFnMHZnRCtMT2ZDTDR6YkhSQnA4T2twZTMrQkIrank5UkF0?=
 =?iso-2022-jp?B?M1VGRys1MXFOVS9lSHZMWGM1cUVKOHlGNHIvNExJSFIySURIQXlEOXV3?=
 =?iso-2022-jp?B?UVFXYzF5V3NtQlJHNFdscWVCT1NHTzQvSUo3VXErcjdRRzRpRndJeUY3?=
 =?iso-2022-jp?B?d1FVcWdCWjY3T2RXR1dWM29tR2NRT3RNMFBqVTNmelh2ZXpQWCt0bFlx?=
 =?iso-2022-jp?B?YWJKSnpUL1U1d2VOV0dIeXBYb1h1T3ZNUW1uOCtLby9WTnhVSFRCcG00?=
 =?iso-2022-jp?B?a3dWT2EvQlR1TTBSM3RyMktqNm5IZE9jTVF5WHFLL1lyK3BhL0FVS3dl?=
 =?iso-2022-jp?B?dE9jL0NmbE5jVUhlblZ0ZVRBb2ZzWUNYWWZ0Ylh5bnQ2eDRET1JlSU5C?=
 =?iso-2022-jp?B?Q29zeWhVY3JjNmJNbFlJUFNYUjQvQXk5czFJaUxvYWdIY2RqREg2MFpu?=
 =?iso-2022-jp?B?OFlQa0ZUYkRxQjFabWZiU3ZGcjFyQ003amV2dTZHeC9rOXJPajE3R0Va?=
 =?iso-2022-jp?B?MXpiby9wQUcvdm4vVDNnS25mRUlpelNDZ1V5V1Y3NGh5d2tIVlZwRGtv?=
 =?iso-2022-jp?B?T3hUSDZxQktMUkZWNVRXL3BvQ0J6eHA0TWRQTWVmNHJYanByL2h2UHBR?=
 =?iso-2022-jp?B?MktuemdMME0xMkZFSVRhSG56a0pXKytyRzNmUW1OeHZZcmhOUS82M0F0?=
 =?iso-2022-jp?B?THFZYkxiSmY4aWFOUXpublZkVGRCcnZJcG9aaHFIUyszNDRLY0RHTUdo?=
 =?iso-2022-jp?B?bzJod2FsQkd6N2RLY0dlcmJoWERWU1lLODhLdzZiRVZYR0VoU1NBR05q?=
 =?iso-2022-jp?B?K3JxNU5NRWtSRmxxcXpMdzVZRWJ5Rk9BYTZuMG1keW9XZVNIZFhDNUg1?=
 =?iso-2022-jp?B?NURQaWtUWFVFTlRHRXdudDBuSmljSmZLenU3dnBQY0crb24yUkhFOURx?=
 =?iso-2022-jp?B?MThZNEFKRTVMT3dNWitXRVNDeWU3aldRRTVtUVpzYkxmck1zRFk0ZXU4?=
 =?iso-2022-jp?B?NWxKVWd0UGJEb0VPbkhvbkE0M284aGZPZ0hjakpXdTZzQm1PaEZVMThn?=
 =?iso-2022-jp?B?Y3dqbU5XVTROY29hbjZyWG55WHJjdzFHZHJiUE9taExyZnZDZ0lPM0xk?=
 =?iso-2022-jp?B?eE0xSmlzVXB3RndiZGozemFhMndGcEFkcTViVU5Ib2lFN0d5ajRPcmNF?=
 =?iso-2022-jp?B?eW53bVhrNGFjZjFwMmRPOEFJZFdUWXBPS0pYbjdFeS9weUdMYTBpWVFB?=
 =?iso-2022-jp?B?TjYvaWVSVDA2RDJKTUNZZEdTSW5rTXlSV0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eeGX93RVJ62iwd0bE1lXfn/+tR0zHAXgog/nysu0KJss7xyD/08iHFmXRfksRhvVLXq/VxamJLvzRwFnGnn3hgRj29Aye6mMXL9sOk25Dd5eOQ7MZE4qLRxZuvkgzqwTzHrG2WkljPOZWsxx9OvdzaJsT7df2QqRTnx877b+YQIIzZGtna7sHVk/DlAXestGgiHA9GH4A8ARnSjmVViH+gX78F+8nWlzaZxENFfOcH+X80yu9s+yPa42+MsUjzFeLekzaos7bC2ewLqEua2LXLy8/BDVg+Fc4W2/1g/c91wYR4XpoKZ3TsrboLFWXsGw+JyPe5l8wsZxlWATtbv34uJ1nznaSQ3kU5lRLbZz+C3lt8qwJywwH4fcxlTUkKaQMY5haV5mBtwhh9bW6aFuxWfgUHgv2qOrTt6KBhUQ/UC2de65m7lZHeQA0NTxoHiRpQ1WWCIUQDl1jlZkKetAOMjId9S0ZLOPb+eAz8xFn7QBAvfW7g7u8Do1zCTF4nTGrrv99FE/LzUmBAKTeW2T7y9ockwBEAEX+KzgUt26LIBNv+4WHvhKWNZ+t3strr8hH9rDvrMvPpMwIcdofswGeHSTM6lcrY99gl4fF9iiU78WQ6g5HZ+nog7gKXAojR46AhzNBsAppRT818ZBOPmKOwWWIGC/mIDQ9O7UDPDxSsqHFcodrOvhRoFLUfOoMSOKq3xgGrZOqSubuh903vtcpRybnImhOGTPhDpOWqTKD3+FMnp75yHUIo1F9Ig3jXeWNM8OmPkZYC2z/HuLmb9R1WsSu7I9H6+vQqE8te5qCxuqdd6BYworr9pzkweymYHq
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d554b40c-7fe5-4e15-74d6-08db559f2bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 23:50:32.4048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eH/HTyYWkYPxSFhcQQGCZUDZvegvvatINsRBxWx6F1FbAHdisQPL96gqwfqBNjeSwuKHUxi83hylSPVGlTMtYk8B3myTfwxWi+mmEaXwVbgrm6FlcpvT0N4SlNp1mTuw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6139
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 23:50:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11462

Hi,

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Monday, May 15, 2023 9:13 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
> Subject: [cip-kernel-config] 5.10.y-cip/arm : Add support for access cont=
rol
> lists.

Please set a more descriptive subject.
User don't know this is a change to ext4 and tmpfs.

>=20
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These configs are required for acl package to work which is used for
> IEC-62443-4-2 evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  5.10.y-cip/arm/qemu_arm_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/5.10.y-cip/arm/qemu_arm_defconfig
> b/5.10.y-cip/arm/qemu_arm_defconfig
> index 58ca273..2992fea 100644
> --- a/5.10.y-cip/arm/qemu_arm_defconfig
> +++ b/5.10.y-cip/arm/qemu_arm_defconfig
> @@ -149,6 +149,8 @@ CONFIG_EXT2_FS=3Dy
>  CONFIG_EXT2_FS_XATTR=3Dy
>  CONFIG_EXT2_FS_POSIX_ACL=3Dy
>  CONFIG_EXT3_FS=3Dy
> +CONFIG_EXT4_FS=3Dy
> +CONFIG_EXT4_FS_POSIX_ACL=3Dy
> +CONFIG_TMPFS_POSIX_ACL=3Dy
>  CONFIG_AUTOFS4_FS=3Dy
>  CONFIG_FUSE_FS=3Dm
>  CONFIG_OVERLAY_FS=3Dm
> --
> 2.20.1

I could not apply. Please recheck this patch.

Best regards,
  Nobuhiro



