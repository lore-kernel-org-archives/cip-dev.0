Return-Path: <srinuvasan.a@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FFCCD37B4
	for <webhook@archiver.kernel.org>; Wed,  4 Sep 2024 14:32:18 +0000 (UTC)
Received: from APC01-PSA-obe.outbound.protection.outlook.com (APC01-PSA-obe.outbound.protection.outlook.com [40.107.255.52])
 by mx.groups.io with SMTP id smtpd.web10.51702.1725460331919809458
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Sep 2024 07:32:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=y8n/5SLw;
 spf=pass (domain: siemens.com, ip: 40.107.255.52, mailfrom: srinuvasan.a@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNy/JKrOJcZgQJpMnP4lDXaXxQhle3UFTInKGLRzn5XUSRPqC9BkKyq8r6S1PUTFiiyumRl0fhOU2S9SSErMR6X3LB3bAKVOIUnIBth6Z8zLTriEAg4qi9TS9rTZO4jQKZK7puhvktLr6HKSXV8InBJRs5OIwlWJNtwhhCM+XjGpE3FNPOojGGzAXxkT6swrzoZpcbLZDTzc1a6VdlnQoGl/FNSfSftcErFathBfioPgiAByD27XmuXueXs77gdZ4j60Fed0BLA5kMuRU3vlJt8Yrn18CZP0CV5ij0anJqp5JHmsA72JHw0NytRgBVZrFVVUCKdvPOaPv8GG9bbg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j45Ny9bsgxrWWfFkZHVgyPG+EyXeTZNRm+KQvmGFQSM=;
 b=yO7grjy8IsLMzP/NZmGzcamAqvlYTu7uB0JATyV+tGfDJwgTEEWqjUfak1GWZzRGRh62mgKEyD8LuMfriaJUIg45SB+CRQfYctbRYEFrwTE+w6RLz7tMMVHIrbziWm1XL0eKEObN4Q6Tj5od4b3xCw2u9b3Jn5STg87M5mOi/GAW9lPwWA2YAgPa/lXJi5Ns073sU/nwJB/q3OS+eXEhTWdA28n/LzEpR58vuVISmRxuTPR4B17ggV41mIPwtKKMiN2ZfIVjx/8X8v3FCGSoRX1lA+2oEDUw6MQRdaTKkArBggXTHVFYOaSFft5ykhXcbXaqPjIemTev596j6SeLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j45Ny9bsgxrWWfFkZHVgyPG+EyXeTZNRm+KQvmGFQSM=;
 b=y8n/5SLwcVfHW2so8VZOjomiOAsNI3V171MjUOlp3Qp/IHM3LlSTENLEhZoSRNMPzrhZYF5u11K0t8Q6Um778MrZMOejmjQ95WejVRtm0ZnXlf860p8nMjPcjVncwGHvaYAIolPMWuSvsnuLvv4fjIhqWi0Hr9vHkXoZ0Oz68KshQ9MKnqmCHfofbm0J7nGv8yduj3CCO0jehNd37WWkwXefaDsAhiQqMu9ill4bttLbLSz0eQOIqUdBbl8w2dOei3aZi6gjGZO9I2HhrKZ4KtJdpxmdVWVD0sOOM1b5BM2/s59KwZ7k4Mzyohm/4p43luzb4933/L9uBsiwCo3lvg==
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com (2603:1096:301:f4::12)
 by SEYPR06MB5112.apcprd06.prod.outlook.com (2603:1096:101:58::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Wed, 4 Sep
 2024 14:32:05 +0000
Received: from PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5]) by PUZPR06MB5747.apcprd06.prod.outlook.com
 ([fe80::d3a4:b94e:29d0:29e5%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 14:32:05 +0000
From: "Arjunan, Srinu" <srinuvasan.a@siemens.com>
To: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] [PATCH][isar-cip-core] scripts/lib/wic/plugins/source:
 Use F-string instead of traditional .format() method
Thread-Topic: [cip-dev] [PATCH][isar-cip-core] scripts/lib/wic/plugins/source:
 Use F-string instead of traditional .format() method
Thread-Index: AQHa/pWQyTCz2m7pJ0WOr7v0H9Tf3rJHncuAgAATPnA=
Date: Wed, 4 Sep 2024 14:32:05 +0000
Message-ID: 
 <PUZPR06MB57474F628AA2AB635E61BE59889C2@PUZPR06MB5747.apcprd06.prod.outlook.com>
References: <20240904064223.869919-1-srinuvasan.a@siemens.com>
 <f7a92fdc-894c-417e-b999-16f0c3b1c405@siemens.com>
In-Reply-To: <f7a92fdc-894c-417e-b999-16f0c3b1c405@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2024-09-04T14:32:03Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=578d87e0-f85a-454e-9813-70deb53cb21a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5747:EE_|SEYPR06MB5112:EE_
x-ms-office365-filtering-correlation-id: 4d709651-99fc-4033-9398-08dcccee5942
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|4022899009|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?4yAdbGzNQkXkevXD7sno5uTPGFE/I1tX3ljuDZF6TUPIoatVkejm2XdwQ90F?=
 =?us-ascii?Q?P2c4qikzt087D1NrRh/BVJJJUbM02TBAfSuNIUXkfJTSkfZImQi+hJnY5tSa?=
 =?us-ascii?Q?YttlLTmGws7OyWQgj8mYv13KU1QcidfDYdhelXZlrsb7E2jKhSv0jZ2JnAAx?=
 =?us-ascii?Q?S1951n7dPWZSQjZ+b4/sdQrpPGpC9p76lVHurUzHHrPl/fnEJnM8wHTtTlKC?=
 =?us-ascii?Q?Qmbc3RmtgW1+A2XtLONAILf6H4VoiyYk11tIf1byYPM7lxO1fUX7eyziBAf8?=
 =?us-ascii?Q?qGaGlLBS2SUh6gMBRznpQY6AEVmHpZ2iPW53n8106F6Zhu83YLxgJeL40qoe?=
 =?us-ascii?Q?FFka9uuMeuLkiImA+SpOQAKL4TUMpD+GustrJILE+y7glFCmTG5NjstN/Ra3?=
 =?us-ascii?Q?d04hoVqmDWgHp9+dQmmeCIbv7wl2z1yL7S9f+CjrpDQoRP5uQlCT7haEby4J?=
 =?us-ascii?Q?0wa2S6Lq8vQcgvmcaEG9p0NDUpz0nj/PrKTE8+nYdnbmeJIuWyRnI/w+BICy?=
 =?us-ascii?Q?hiol3DPByrNoJhevOZgJ06wJiSNNe5zNWFpJcWiPFBAS3GnTLuMsS5t4FyGq?=
 =?us-ascii?Q?DNrFTKaiYCYHzovi+1fMRFZBk9OLv9Rz1kXhkgqWme+wZE5l6uAiSet4CV5W?=
 =?us-ascii?Q?nTbN0L5Ge9we6ph8kCQIqrpc5E059dqXoN7jScIj3tzzL1Hb8hspJIghxBbc?=
 =?us-ascii?Q?Bln5Y7hMxLoJ52MgKMZuK95ODeqf91B5D7H1sUvsUlFG4dHG9cOSIPeprNsr?=
 =?us-ascii?Q?XutDnU15DFZIpuVtS+I2tF71PBuEA4QMbjGEXkGt5DPVGMA+JV79+/PfZk4J?=
 =?us-ascii?Q?D4nPnQpK9kKxc+wPKx9fxds2RY9JWac6DTIGgQz9BQdP6grHdgGRsIhpVq/6?=
 =?us-ascii?Q?60rsLkGqmJgo51CgDutxglalLVswoGAiiCUaei9Y/k3lOwjyryo0Ct0mO7z6?=
 =?us-ascii?Q?1mfoBQhqemf5tf8QcqjZY+84Ugpx4CXFQGJANnOnzXL0Pz2WCz9VLV+lb/87?=
 =?us-ascii?Q?TPUfaWuHCYRC/aXjG3TRk9uTmiWXLwEMonVlNXBaiM0nY/lwHjqNlGBRo3CX?=
 =?us-ascii?Q?jcKiAADndj4La/0pByUm0PMDyoQu8QDGyd1ciQMBSIymSh5e8dv4/kUrw+cV?=
 =?us-ascii?Q?2TB8QlGfwS7LWwCU3Jbqks58XUnMLFIQHfOsWzfQsO2v8l29l1VKHSz/u/RG?=
 =?us-ascii?Q?4Bo9XC2Q7POfyoEih9neEfXSuYprjnsPV8nUT6LX8+JKH321DkFZ4uHBxz7k?=
 =?us-ascii?Q?Rr5skTcIevWwgjyN8eD6X/pt9rCWbD19TZglOl8HkPYqbwn66D+p3bRzhArd?=
 =?us-ascii?Q?GMy/NuI8hgPMEBGR77Bvnrv0Hl8RwXVpH4ugJeGQjaJdNqNDGfaWarcEXBEH?=
 =?us-ascii?Q?zlUctQzxuG4aid6K0dtHyKz8bJOVf4LOXG2wj6udWKrwLpRr7A=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5747.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(4022899009)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?PKSpVyTtc/x/xz3kCd3wwFpfS6ZbO9O+byHAiC7Z4yl2z4DW9aEDi/KIYdMu?=
 =?us-ascii?Q?bqWFNN8d2q22uE9v+3rBHZmq+CFKSvhQVIShFEq1ZxxuFHGKjcl37PQ4Z78a?=
 =?us-ascii?Q?8417HzTdjib7I2QfWcoUF2GgrgGVpooXaWH7k9qEqIqaTH//efTx2F+qRO1V?=
 =?us-ascii?Q?40UStcT2Qm1eDJS6cFvQO5YsFSuU76u52irRqu1Y1k/086KvHX8WFVKZPLVd?=
 =?us-ascii?Q?11QEQlOh1oHGXABwNHfG+dIWeJAaMGUe0cUxJCBcrHjWS/PoTeDg8ynI3H/x?=
 =?us-ascii?Q?H+8GmkYZ+anpvzPPrkuH9w7pa6njXoERCM5awpPOl0DL8SlUJ5R3UaAQJp50?=
 =?us-ascii?Q?z/0WPyHXod+T3PW5KXisToVwWXpaCnEQcc7gP3CT7dof+11+SrkiXp20n5c4?=
 =?us-ascii?Q?+oYbXr5LWX0VM/Z4ko3u4bAbhpJyOC2gHOFj+7ns6A1yperunrBbWC937Rme?=
 =?us-ascii?Q?ixeF/OqeepqTfQShn4qz2Ks7MYm4uTAZYxXqZA1ZQNAoOmNngWsA16rnHvhQ?=
 =?us-ascii?Q?sORhRsC8jRkGd9IsofOH9XlSuFSOwIk2HmhuhQlfQvJ13AyMVOiX9YZWpDFt?=
 =?us-ascii?Q?KtUBPaPxweay+rUOC3RrF67LzB3EUJ91thsLeMxaAtS9LLposfWYYLm/6qXS?=
 =?us-ascii?Q?Ik0gfjohADEQ5dF1UlPx2J9wkISzWFGTOhX33EoyRnLZZv7erY/CJITgs4hq?=
 =?us-ascii?Q?v0zoiWGuaowDqGFfOgW4E1gOI03n2lNiI+pqxCDsFNineyutz4wWmSTxIhq7?=
 =?us-ascii?Q?uefLVHpQLiIrfaF5QpJfaqmyeThUmWUNEDtjXYtyAQEIwKN9Ug0olKu34ZbC?=
 =?us-ascii?Q?UPGTiKNCEcgsYVZyiRiYpU7gQ/B2aCv5ox/9Ct4PXzxsT4jyITr6WePPPEGS?=
 =?us-ascii?Q?MEE1oBjZrm3uy+8XaOBuJdyhN9dOb3VKaNhR4893D5hvbx+qOl4ndKoPA2jy?=
 =?us-ascii?Q?8+wHvuxwg6kf32K/s8QViQjo0bUSs515fVoSrO6T2BKYspcXxcjr5sdEZKqA?=
 =?us-ascii?Q?YJWb25P9x6ZMJ4ny5n5Scbi3HeAGhYwp1JyNzy6hHh51gy1ZaBfIeAzX+wgS?=
 =?us-ascii?Q?ZUVSQZB5N7nJf3ILAh7IgCJdgU/87Kd8llQvhWxETPhPCeIWrQW6HWv9NTka?=
 =?us-ascii?Q?P8Qhj2vh2ocb2nVmp43QSxxi5u7jyRv+wOJTcFxIbUHEA/P9c/GF5hZVRbBb?=
 =?us-ascii?Q?wuqyR05c9pmiPgfGnP1ruoKeIOE3N6LTizglYx7svXy+KUPkcbqk23dhO0A9?=
 =?us-ascii?Q?UYTcYayKoKn1Av9HC5lt41vKA4watykJiHVkQxb56LWSwlQzay1lntc348oR?=
 =?us-ascii?Q?mREUkWjG1LpDsqk/PH+20MzHqsXemLoTwyyBQ+tF18VR+6JzJFOigSaITjYi?=
 =?us-ascii?Q?LWjRg+57wo3BQ6Wt/HyQCnN2SccWujjMZTkBZHtiQErzVE568WydFfgqfv5M?=
 =?us-ascii?Q?lfbkxu2K+DW1YQeQuSL72jNeIcunb1j5f0wLqfQyGxQYSfyhO5Q6rNkNHmGR?=
 =?us-ascii?Q?KpncF9jbKYKHNSO9vQuWSF/p4Zthwzpurd2EmbM2Z7AR1XLkDOUM+aJhaAYe?=
 =?us-ascii?Q?K32oY29nlIQIFQELKNCXC+pyQeQApCgkwOvcGflO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5747.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d709651-99fc-4033-9398-08dcccee5942
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 14:32:05.1528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EkZhvp34Ruew9P6Z7YNFBT4E+2+eNBHk82DftnjKvSPJre0iLp9ch5sTyukKWDJJdEFYWM0nlvSLXjC5PF2/+Spro09GwuTPLRHIQeIvr/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5112
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Sep 2024 14:32:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16848

Let me check and replace that as well, thanks for the suggestion.

Many thanks,
Srinu

-----Original Message-----
From: Gylstorff, Quirin (T CED OES-DE) <quirin.gylstorff@siemens.com>=20
Sent: 04 September 2024 18:52
To: cip-dev@lists.cip-project.org
Cc: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>; Arjunan, Srinu (DI CTO FD=
S CES LX PBU 2) <srinuvasan.a@siemens.com>
Subject: Re: [cip-dev] [PATCH][isar-cip-core] scripts/lib/wic/plugins/sourc=
e: Use F-string instead of traditional .format() method

Hi,

On 9/4/24 8:42 AM, Srinuvasan A via lists.cip-project.org wrote:
> From: srinuvasan <srinuvasan.a@siemens.com>
>=20
> Use f string for string interpolation and formatting instead of=20
> traditional .format() method.
>=20
> f-strings are generally preferred due to their readability,simplicity=20
> and efficiency, and moreover there is no functional changes apart from th=
e optimization.
>=20
> Signed-off-by: srinuvasan <srinuvasan.a@siemens.com>
> ---
>   .../wic/plugins/source/efibootguard-boot.py   | 31 +++++--------------
>   .../wic/plugins/source/efibootguard-efi.py    | 17 +++-------
>   2 files changed, 12 insertions(+), 36 deletions(-)
>=20
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py=20
> b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> index 2b06fd1..ad749fb 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
> @@ -170,29 +170,16 @@ class EfibootguardBootPlugin(SourcePlugin):
>               msger.error("Bitbake variable 'EFI_LIB_ARCH' not set, exiti=
ng\n")
>               exit(1)
>  =20
> -        efistub =3D "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel=
-stub{efiarch}.efi"\
> -            .format(rootfs_path=3Drootfs_path,
> -                    libpath=3Dlibarch,
> -                    efiarch=3Defiarch)
> +        efistub =3D f'{rootfs_path}/usr/lib/{libarch}/efibootguard/kerne=
l-stub{efiarch}.efi'
>           uefi_kernel_name =3D "linux.efi"
> -        uefi_kernel_file =3D "{deploy_dir}/{uefi_kernel_name}"\
> -            .format(deploy_dir=3Ddeploy_dir, uefi_kernel_name=3Duefi_ker=
nel_name)
> -        kernel =3D "{deploy_dir}/{kernel_image}"\
> -            .format(deploy_dir=3Ddeploy_dir, kernel_image=3Dkernel_image=
)
> -        initrd =3D "{deploy_dir}/{initrd_image}"\
> -            .format(deploy_dir=3Ddeploy_dir, initrd_image=3Dinitrd_image=
)
> -        cmd =3D 'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_f=
ile} \
> -            -c "{cmdline}" -i {initrd}'.format(
> -                cmdline=3Dcmdline,
> -                kernel=3Dkernel,
> -                initrd=3Dinitrd,
> -                efistub=3Defistub,
> -                uefi_kernel_file=3Duefi_kernel_file)
> +        uefi_kernel_file =3D f'{deploy_dir}/{uefi_kernel_name}'
> +        kernel =3D f'{deploy_dir}/{kernel_image}'
> +        initrd =3D f'{deploy_dir}/{initrd_image}'
> +        cmd =3D f'bg_gen_unified_kernel {efistub} {kernel} {uefi_kernel_=
file} -c "{cmdline}" -i {initrd}'
>           if dtb_files:
>               for dtb in dtb_files:
> -                cmd +=3D ' -d {deploy_dir}/{dtb_file}'.format(
> -                    deploy_dir=3Ddeploy_dir,
> -                    dtb_file=3Dos.path.basename(dtb))
> +                dtb_file=3Dos.path.basename(dtb)
> +                cmd +=3D f' -d {deploy_dir}/{dtb_files}'
>           exec_cmd(cmd, as_shell=3DTrue)
>  =20
>           cls._sign_file(signee=3Duefi_kernel_file,=20
> source_params=3Dsource_params) @@ -206,9 +193,7 @@ class EfibootguardBoot=
Plugin(SourcePlugin):
>               msger.info("sign with script %s", sign_script)
>               orig_signee =3D signee + ".unsigned"
>               os.rename(signee, orig_signee)
> -            sign_cmd =3D "{sign_script} {orig_signee} {signee}"\
> -                .format(sign_script=3Dsign_script, orig_signee=3Dorig_si=
gnee,
> -                        signee=3Dsignee)
> +            sign_cmd =3D f'{sign_script} {orig_signee} {signee}'
>               exec_cmd(sign_cmd)
>           elif sign_script and not os.path.exists(sign_script):
>               msger.error("Could not find script %s", sign_script)=20
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py=20
> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 48f7523..c443d14 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -73,16 +73,14 @@ class EfibootguardEFIPlugin(SourcePlugin):
>           creator.deploy_dir =3D deploy_dir
>  =20
>           distro_arch =3D get_bitbake_var("DISTRO_ARCH")
> -        bootloader =3D "/usr/lib/{libpath}/efibootguard/efibootguard{efi=
arch}.efi".format(
> -                        libpath=3Dlibarch,
> -                        efiarch=3Defiarch)
> +        bootloader =3D f'/usr/lib/{libarch}/efibootguard/efibootguard{ef=
iarch}.efi'
>           part_rootfs_dir =3D "%s/disk/%s.%s" % (cr_workdir,
>                                                part.label,
>                                                part.lineno)

Why did you not replace the old string format in this patch? I see only the=
 str.format calls replaced.

Quirin
>           create_dir_cmd =3D "install -d %s/EFI/BOOT" % part_rootfs_dir
>           exec_cmd(create_dir_cmd)
>  =20
> -        name =3D "boot{}.efi".format(efiarch)
> +        name =3D f'boot{efiarch}.efi'
>  =20
>           signed_bootloader =3D cls._sign_file(name,
>                                              bootloader, @@ -116,11=20
> +114,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
>           sign_script =3D source_params.get("signwith")
>           if sign_script and os.path.exists(sign_script):
>               work_name =3D name.replace(".efi", ".signed.efi")
> -            sign_cmd =3D "{sign_script} {signee} \
> -            {cr_workdir}/{work_name}".format(sign_script=3Dsign_script,
> -                                             signee=3Dsignee,
> -                                             cr_workdir=3Dcr_workdir,
> -                                             work_name=3Dwork_name)
> +            sign_cmd =3D f'{sign_script} {signee} {cr_workdir}/{work_nam=
e}'
>               exec_cmd(sign_cmd)
>           elif sign_script and not os.path.exists(sign_script):
>               msger.error("Could not find script %s", sign_script) @@=20
> -128,9 +122,6 @@ class EfibootguardEFIPlugin(SourcePlugin):
>           else:
>               # if we do nothing copy the signee to the work directory
>               work_name =3D name
> -            cp_cmd =3D "cp {signee} {cr_workdir}/{work_name}".format(
> -                signee=3Dsignee,
> -                cr_workdir=3Dcr_workdir,
> -                work_name=3Dwork_name)
> +            cp_cmd =3D f'cp {signee} {cr_workdir}/{work_name}'
>               exec_cmd(cp_cmd)
>           return work_name
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16844):=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.cip-project.org%2Fg%2Fcip-dev%2Fmessage%2F16844&data=3D05%7C02%7Csrinu
> vasan.a%40siemens.com%7C2b791d8d80fb409a588808dccce49fee%7C38ae3bcd957
> 94fd4addab42e1495d55a%7C1%7C0%7C638610529547457682%7CUnknown%7CTWFpbGZ
> sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7C0%7C%7C%7C&sdata=3Dw0S9%2Fzn3oLOjcZuru1osrrlqdvroI3bXwRK%2Fi7B0ers%3
> D&reserved=3D0 Mute This Topic:=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.cip-project.org%2Fmt%2F108260811%2F1753640&data=3D05%7C02%7Csrinuvasan
> .a%40siemens.com%7C2b791d8d80fb409a588808dccce49fee%7C38ae3bcd95794fd4
> addab42e1495d55a%7C1%7C0%7C638610529547465838%7CUnknown%7CTWFpbGZsb3d8
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0
> %7C%7C%7C&sdata=3DwHajkf9omQfI%2BQ9s80G1KD2vT7kZaBdotW28aXQh0zQ%3D&reser
> ved=3D0 Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe:=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flist
> s.cip-project.org%2Fg%2Fcip-dev%2Fleave%2F8129121%2F1753640%2F14052693
> 26%2Fxyzzy&data=3D05%7C02%7Csrinuvasan.a%40siemens.com%7C2b791d8d80fb409
> a588808dccce49fee%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C6386105
> 29547471543%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMz
> IiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DyUF8iqhVghchVMDdKf
> zKlJ5J1eAfvomgFH3ty%2FSNVJg%3D&reserved=3D0=20
> [quirin.gylstorff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

