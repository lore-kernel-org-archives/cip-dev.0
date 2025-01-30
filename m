Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B69C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 09:06:48 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.52])
 by mx.groups.io with SMTP id smtpd.web10.11745.1738228007677618133
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 01:06:48 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gV4BId/H;
 spf=pass (domain: siemens.com, ip: 40.107.247.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfWbe7jzVdDhrAwFuAFKjOeleI6eIrZPy4+sdUpAFv5+K2iYFbHxgbnYrlAZdLOrD/PKdXSSFNvzftqNcimLufJVgkUfh8oW/hLUXcl+ZTr6xMkjd8G58SLdHKuhNIyL2Xc1eu6TMyg+nHEFWFWMqdpab2Dfzm9evHex+hU87bWD/9kLLUSarhi1tSqBjO6+8LqjolRq3E11PYwbYTnRVtUnT/jLB/LqjUubhgD5oP8On+td8aZ0gzCW7y1MY4Siqvlio7ZGFGz/aNlOe8pOIteOVkV4QawvxTY4+oJJSAvOTF4GL+DonTRHJQcVHM9nLoUZ13+yXlEKFJjWQqRsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4J7Kr8AWmTNji2doqS1ib+yLY/2Km6QDKxWxqIa0SzA=;
 b=mIbgmsFWBK5/GyMsa1k21DS4sM7CQhF2mWYvyVfhG4u234F8RVc8DcUDrDsQ1/TsbHerQjL/4qhpLWG8I8wNOovtpKeW70UfsmLgzenk0QSRraBUqTnk15cFiAj9KggTSoGvhz7Vhyw24Z6SVVl9cnUdsVVnxNUJQjxV2/Bdhw9HyKNQIC98GGSJpGD6lhRlSRn3dUdOgITrLtT5GSrhV8ca5W9Am3qqjb/Ybc+/IZAFZxuz55+PrRkJ/hCF/KtTysfo6vX8WRW3xVrVfQZF1HZ9KrFecAC89Q4YIKPe3v4hcjhfMVSZ7a/2K/9jqHQdcubt9AfSFgCnSzLst+FUwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4J7Kr8AWmTNji2doqS1ib+yLY/2Km6QDKxWxqIa0SzA=;
 b=gV4BId/HBBbnOfyOz7aH/pJRq319RIAN7pTA3Df3mZr18qb9nWa3ClFV7jPkfrsQnPiiYpeXbMsV/oub+eDLvbcNlDWjhTL/62gYtwXbPeeiqB4D6BC+iRU8YPa6g6RrkFfTDpe8mJ6SPAjNUTIncB/C8ptqHL78XdE0zWV76smc6mFSz39kuYND4sApJwA4qZa/ayHn2t85Kty6+zB+9BPtI1YXumJbH6pU3iMdGXvMB9wMj7jLUXo6a5EJsdpaQSnlkMMyLAc5l0mgetI4jUlAHxcl8M5Bp+OXe0FHayBF1AmHR4ABEimLaQlMghD02BVdksrRvWFZPKCoh8/2/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:168::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.12; Thu, 30 Jan
 2025 09:06:44 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 09:06:44 +0000
Message-ID: <dbdeebd3-056d-4cb9-894c-543fefc01c6c@siemens.com>
Date: Thu, 30 Jan 2025 10:06:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security:
 add curl to download LAVA overlay
To: Sai.Sathujoda@toshiba-tsip.com
CC: jan.kiszka@siemens.com, cip-dev@lists.cip-project.org
References: <20250124132246.64738-1-Quirin.Gylstorff@siemens.com>
 <20250124132246.64738-4-Quirin.Gylstorff@siemens.com>
 <OS3PR01MB61036828512A1860892182A5C2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <OS3PR01MB61036828512A1860892182A5C2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0046.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3765:EE_
X-MS-Office365-Filtering-Correlation-Id: 17b99890-e407-46c7-88dc-08dd410d6b18
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OIRNZUV/Pm8fxciupFTs+gecOsrL7qYLpk/pYlAT8+Vh8FHpKmvtrkRArsA1?=
 =?us-ascii?Q?bIb/zoVfHzyV0eX4XFtf1cak+Rd5oPqITW6GorCYs0oUswd/17m7Z7bJUQqT?=
 =?us-ascii?Q?Dy9fu5bTRE1YXepzMiCwb1g4zwN08cKv3hn89GA1flqp6XzLftannJWBdNpC?=
 =?us-ascii?Q?BhRcJ3PbCV1OXOV/9GV9PML8mkQiqHFacZACfvtpgS6Py7a+ALOZ8TwaTMD0?=
 =?us-ascii?Q?1XQFmEI+eUCIIPUBXyMOn5p7lCV94k3dt6d+SIch9U3bg6+erKc0BC5+jGDR?=
 =?us-ascii?Q?GFTxswkLY0hkQK8XPytdROF5sYi0QbuHVP+cup/3VxvkcAR4O8mHUv8E1Pgv?=
 =?us-ascii?Q?Cv7J5D6LwssL5udxNAF7f3io5mXMTDAVkMcGnWkHx3svoSRJ2O0pKfMxCrnO?=
 =?us-ascii?Q?8p7rJDrD4YBehCqq6XIyq1R3m1rFJdCWxgPmhAGZPsH8v3HFG6mmjJUdKAD7?=
 =?us-ascii?Q?2AbxWIk/WutPIl1MYjg3et0DJ44SF4nnLp9zq5NICWoOeZYC6MoMPJ/BMS2U?=
 =?us-ascii?Q?kqMLgkPYgTv0zRWl9dzqoKswex8bJi8fR/aVQrDt4ylTsMCfjgvrEH/aYcQ+?=
 =?us-ascii?Q?UXVfTSrZNjsBVncDvkwqQbe0Hxzus3HweQQXu/YAD9DPGTL+IumKQAOAWKQ+?=
 =?us-ascii?Q?yOKrbo/UfkumxcV2CjEti6T3glT+edL6X/Ab0fK3cD9dedxyqtce2av3AI72?=
 =?us-ascii?Q?ZA6smSXSr9qy3yjaAyTkjdefpGejyqqV8wmI1mlwx6j7Wec7Xz6VE7/z9nmQ?=
 =?us-ascii?Q?TS4VfFJ67i2C6mjHQAcg2dzOMvaNDBNU5+c9msUSxbikWei1tgevLERW0LGf?=
 =?us-ascii?Q?Spx703Bcy69O/1mjYcetWJ9OlT4wUEVFqptmTBbbjxzY81Z0faSDPE50Sjki?=
 =?us-ascii?Q?+yp2u2KB8zavRJHa2GBy4YhfOnALVkNUi2NlVKAcCSRKP5hQyaUrrIszsCNc?=
 =?us-ascii?Q?y2V18/vL3TpyhTRGbsPsSU6YW4ajDY1YsNFV4/h54tZmjb8C6Rb9Lo0bnhvD?=
 =?us-ascii?Q?Aejhe61BOeV05GPXeljz1xDuGPDQQ6Ew6ZT7VDhphXStL1cXs3DroQ5L6SWZ?=
 =?us-ascii?Q?V9hVH+GwKCh99ZkVWOwMLQQbOetLdn2uW7ugrjl+L6MYNR2jbS3o+xp5qtLB?=
 =?us-ascii?Q?nkGmtugQ0NzTicSJUR6qMGjSCxLKzMniHg2j+Ze2y8UoxDUHySH20muhw+Q2?=
 =?us-ascii?Q?8TvhXGiimMBdIlFlGEJEn0LyG4nxADxYJ602DT2oa7SqtVG4S6SqlOotc5qk?=
 =?us-ascii?Q?eKTqp7tXGWvtDA+UEvRO3O1xYwHSrUupx1d2ZTemAqEMVUgwnjYT+CLdGG9C?=
 =?us-ascii?Q?e0AKP3e5JW7e+VYgYH3GTq/6KGzU298X0VlQRW8cH7ThfCMTkIxDxL54Nvk4?=
 =?us-ascii?Q?lMyiigEBflEwSdrvI3p81J5NKkbp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lZMqz0TYyyzuOwD070V5L/EuT2KfbR6NC2YHwJOa3IvkiqOgbAI/UgWi5XMD?=
 =?us-ascii?Q?oo2SA2M+wJvQHl4cY3bYUKsMR6eCeOjSuNsY6zMe4x8npg667JbT6Ui4gcij?=
 =?us-ascii?Q?PTBU529ziMCti9vaPMBUnsNBptUuow8j0eQOJbFLryq8/QJCpAu3dQrZgaum?=
 =?us-ascii?Q?wR7i0WMXcbYl3kDDFi7DMpOw/Y7jkbzHE7dfQL2XM9g+mDeZyhRxcw0cIqul?=
 =?us-ascii?Q?3CODzqPidUQQyAAPI+6/rmAUp/BEBYS1HGNFtYq+h/RYTOskztgCf7ao/cLG?=
 =?us-ascii?Q?C5oYI7m7tpwdZkYZknq3E9CXwtr0EGxQC7217MDn+k/9uEOiHVCOFPLCpZP1?=
 =?us-ascii?Q?lwUWULHuF9i2BufjAXlVryZliCEDnnSLhITrqscQWu0DamcsA2vdsQUVBaCQ?=
 =?us-ascii?Q?lF+dKr3ZXv7aqy5T9GwM730CJZgLPe//r3Kc1qIOj7ecF3wrdiKH7xV8SRvo?=
 =?us-ascii?Q?8kZtbnbkmBgKL2QVD4LfzeACRR0rZ2+IEGmc5csL/jxuPm9AWq0arBg87VwX?=
 =?us-ascii?Q?bUL3En4aWQ32F28x59oOFstC+H2MjkaTpbU51oE4z9HB5jriKcjGd2koKc1a?=
 =?us-ascii?Q?Y4vjNe9bA+mmiXYqRjYHWrp4Exc5JvLvrhrDmBAk+DRQj4n0YMGDgMSzp3nb?=
 =?us-ascii?Q?l8Q5gv42fkBhenr6UcKQ9PbIIVbUMZC5M/U3lKy8VBl0HSfy7nAmjuCGq5Zv?=
 =?us-ascii?Q?qBEgiypiO5Wl4GWNkB1w7tqPQpCwDGtTtL0O6JC+PRbtEpqXCCaPNhm+yU2O?=
 =?us-ascii?Q?qk8oczwNPr9ZAeLxmh7x85T1QVIIHToS5fMKTSlqHcyl8uTer1GdNSX0tZwM?=
 =?us-ascii?Q?uAoZvEs26aY7ABoDBN7a5j8jiRBt0v2NaA9snMhg2HIdcg5lK1bUzleEcSdw?=
 =?us-ascii?Q?k7Ubdu8EjRWIRHCWkblee7gXRt967fBfFbQvn3C/RWdL7Ez/1bS+Tpby7ETD?=
 =?us-ascii?Q?d85qevuFkepm6ikqon37YiWRJp24nTzWxJrFVuUMIwwvnOtLzAToAeVnG57j?=
 =?us-ascii?Q?aoLKgILtru88P+b3zJEjgP+TIDR8RWEVrPNHuoIhBFjdfOLFu49OLPcZbbiT?=
 =?us-ascii?Q?PIG5AHKNrK5Ao/6/GbYiky8BwpFxFSxZGNPLrVied2zIsK7ma0T98pNPMhvb?=
 =?us-ascii?Q?ODtu/sYamx4BfJDMjnI3e1b1gfv5zYLOsptkRp+VAoOOkgqpeUKA/PVCZSdc?=
 =?us-ascii?Q?BtfgOipr9M6PiRl+kzwJr3d9z6bR3Xe6G7ftnIf/aH6VYMp6p/QzsI8F/ypF?=
 =?us-ascii?Q?z96Q6bIGHylPQIC5Y/Nya+7nQI329CwZOeMYi9rr7T1YDNrhkXqS5an23Y/L?=
 =?us-ascii?Q?MCrAqxJF2Y0F1BhlzDt/c4Y6TbTj8aZ+rBtpX3tdF4EuYKs6M4X2mqsXIpAm?=
 =?us-ascii?Q?+RfCQnu5Yot3oxVtOJYt2Ypd1sjqQmuRNJZb3fIsL+TJjRTon4nVKHh4UvlH?=
 =?us-ascii?Q?oaCJ8fS8FtvUgedmhHNqB1rd4AfxRZ8sjh/If5dVbsX67o6pHfxRxN9Ox05f?=
 =?us-ascii?Q?N6WHTHP75ojhXx0DNh2TEv4apLIKrmwi9SnsbBgal1XF8Jtf6/hMET4cWe32?=
 =?us-ascii?Q?V90j5SWDc9gbWNDlTtmCCh0m3ScP21p3z273hwy7xmISOdDcgcOWjHemMovR?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17b99890-e407-46c7-88dc-08dd410d6b18
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 09:06:44.4664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JIsoyrRw+4BanrbEVyaM8c1IPefWfoPQk7+xzm+tGOLYUEylLihmEL5yPEjDKzc56XU715GD8pjWobnaOgQmShy7WuaKsbaXEKMOkm+dAXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3765
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 09:06:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17693



On 1/30/25 09:52, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Quirin,
>=20
> Including test extensions to security shall make the artifact name cip-co=
re-image-security-cip-core-bookworm-x86-uefi-test.wic. So, the artifact's u=
pload to s3 shall fail<https://gitlab.com/cip-project/cip-core/isar-cip-cor=
e/-/jobs/8943849473#L2128> due to current logic mentioned here<https://gitl=
ab.com/cip-project/cip-core/isar-cip-core/-/blob/master/scripts/deploy-cip-=
core.sh?ref_type=3Dheads#L22>.

Do we need that `-test` or can we drop it?

Best regards,
Quirin
>=20
> Regards,
> Sai Ashrith
>=20
> ________________________________
> From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
> Sent: Friday, January 24, 2025 6:52 PM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; jan.kiszka@siemens.com <jan.kiszka@siemens.com>; cip-dev@lis=
ts.cip-project.org <cip-dev@lists.cip-project.org>
> Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] customizations-security: =
add curl to download LAVA overlay
>=20
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> Lava generates an directory, in LAVA called overlay, which contains
> all scripts and tests of the test stage. The Device-under-test
> needs to be instrumented with with this overlay.  LAVA provides the
> possibility to download the overlay via http or NFS. We use curl
> to download to the overlay from a http server.
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .gitlab-ci.yml   | 3 ++-
>   kas/opt/test.yml | 3 +++
>   2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 686ce48..d63ef2e 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -65,6 +65,7 @@ default:
>       - if [ "${release}" =3D "trixie" ]; then base_yaml=3D"${base_yaml}:=
kas/opt/trixie.yml"; fi
>       - if [ "${encrypt}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:=
kas/opt/encrypt-data.yml"; fi
>       - if [ "${watchdog}" =3D "disable" ]; then base_yaml=3D"${base_yaml=
}:kas/opt/disable-watchdog.yml"; fi
> +    - if [ "${test}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:kas/=
opt/test.yml"; fi
>       - if [ "${swupdate_version}" =3D "2022.12" ]; then base_yaml=3D"${b=
ase_yaml}:kas/opt/swupdate-2022.12.yaml"; fi
>       - echo "Building ${base_yaml}"
>       - kas build ${base_yaml}
> @@ -250,8 +251,8 @@ build:x86-uefi-secure-boot:
>       extension: security
>       use_rt: disable
>       targz: disable
> -    encrypt: disable
>       watchdog: disable
> +    test: enable
>=20
>   build:qemu-amd64-swupdate:
>     extends:
> diff --git a/kas/opt/test.yml b/kas/opt/test.yml
> index 4a60ad4..b23f437 100644
> --- a/kas/opt/test.yml
> +++ b/kas/opt/test.yml
> @@ -17,3 +17,6 @@ local_conf_header:
>       IMAGE_PREINSTALL +=3D "rt-tests stress-ng"
>       DESCRIPTION:append =3D " with test packages"
>       IMAGE_FULLNAME:append =3D "-test"
> +  lava-testing-add-curl: |
> +    IMAGE_PREINSTALL +=3D "curl"
> +
> --
> 2.47.0
>=20


