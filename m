Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AC9C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 14:57:23 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.14])
 by mx.groups.io with SMTP id smtpd.web10.17768.1737471439619142912
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jan 2025 06:57:20 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FHmBcX9Y;
 spf=pass (domain: siemens.com, ip: 52.101.69.14, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBCEAlCwpXKupy2Y43U9kbfGw995qNRsOWdH4jiIuHwYV0SikvV4VLn1xk4Kmzjs1nvnKqkXyO1JJhFLHz0IJATcrmJO7/MgGMbjWOgCmvObZbZpK0KOPXh2WcdVBltKjI1DqPXbupsxZ0ogrfdM2Ym2HxcWA69xmHOWs5aIiVw/QBMbNE1F3oDfUYhbJT6+kDGp+80xTCWUHaaCVY3H9AYB2RuJYaMJ7FD36n1zCc6odM7d4SM8Tu2j3DMKmDFKdhq0rJ70jAQSJBBNDXG8d2n+PKreCm6cIQ2iEIUAoe91Mrs8V6v339R5exXsUy956arIATTIUFySKZg4Sv64Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu/3j7rxOEE+80swYzhRV7e9u5q/d56VIo3LAvE9SYM=;
 b=wLurJLgfq2bKL9Nr9BSPlPl30Y8t4q8ayVLgOxeUKeQBbcUT7eOUH5DdYE+vI8cqTQmSUxFVGnpEuZ2SiVYmT3BZBGCJT47DBxiqNWPMXxGMc47XI8PbWpIRQT/2f+P3L+ko1+d3li6glqxtiArsQjUpzllhUBFy9hHpk1LcvBjz/JrRNuVUUGRyNWHOsjfdJxwl5LA+S7Fiz9gyWSQFAMXQuj/nEK7mKzB49V8nSizWv1u16+4sPnrs0jg0qPKuGyn2BvEsuuFo7AdmYiYwlX0n8A5Q8tTuX/8egGw3Mj/PJQbDRNc9qUHXQ0o88JSWdmmMbYTsoc0ByiUQoHQU6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gu/3j7rxOEE+80swYzhRV7e9u5q/d56VIo3LAvE9SYM=;
 b=FHmBcX9YApgD3DbT/44TjThHUUhrS/dGxnShx35DQlxQg6QDgjXJpt5K3AaHj1wc5fyZFtRLYTG42WIFlMrE/E9twGSA5nVJaOh828DWWHsTYXMNZ5FCOgVT3eMlAr9qNoz2vqJTD+lPD9VOvHn8ZugFSJA+P3Y2+HrHPBUbfMAXDVG1Ac62r0UUTI4q3UgeGtXHBzxqJoIdow/zBmjzGKteH7pcX1uLrHJbZMHeS0zvUYd2uiZzcrj+YEiLX4i7aGb1esfd9u+8w460w/Zat3YmDY4Gfe0u2BxALWVgwD+UknwrKVC+hRkgev/lF9K81qGL5Zk3KXESFTuMjmbEZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB8314.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.13; Tue, 21 Jan
 2025 14:57:16 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%3]) with mapi id 15.20.8377.009; Tue, 21 Jan 2025
 14:57:16 +0000
Message-ID: <a3ffa917-f2e6-4f2c-9c4d-b655c0febdd5@siemens.com>
Date: Tue, 21 Jan 2025 15:57:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: ltp (syscall) failed test in CIP Security image with
 isar-cip-core v1.6 on M-COM
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "Sai.Sathujoda@toshiba-tsip.com" <Sai.Sathujoda@toshiba-tsip.com>
CC: "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <OS3PR01MB6103AAC4C7533384E6C3CE8CC2072@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OSZPR01MB85159B1B29203FFAC3458D6ABF072@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <OSZPR01MB84010B4C962BC73DD1466779B7192@OSZPR01MB8401.jpnprd01.prod.outlook.com>
 <OSZPR01MB85158D80663768F0ECD9D96CBF1B2@OSZPR01MB8515.jpnprd01.prod.outlook.com>
 <OSZPR01MB8401759CA7B581E1C8D0BE2AB7E62@OSZPR01MB8401.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <OSZPR01MB8401759CA7B581E1C8D0BE2AB7E62@OSZPR01MB8401.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB8314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1269d181-0eaf-4904-5d13-08dd3a2be548
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BPa0TiZSUWiWXuGnolikxN1cQGLneLY6MpWSTaUmyGJb4r3rs0rnYnFE84i6?=
 =?us-ascii?Q?HBma9du00tA6S8vzRWWsjk0LswVeWVvixNHDIjKmuPoyfeEbebUMOyIiRfEl?=
 =?us-ascii?Q?oPlBQY+9DBiZgooypqliY4AISviPRiKN42/INgkIeOp7Tex8hkLijDvwZak3?=
 =?us-ascii?Q?Kj3BZLpdHFj2r7QLIn8hAKcCIU+qLr1babcZ/4jvx7WZ52nqQ6v6uYjwHgFo?=
 =?us-ascii?Q?g8TLuPG/4IQJrwmWtwVRDZLMagsoudy5iI6N9TT0qXnoMH9HJAnSECwOitqa?=
 =?us-ascii?Q?EzzDWcxCGmrTAbUfB3Tr3nhZZ6iW1EcdtpHsZBnWVL7kgskTFQMvlX9nIF/e?=
 =?us-ascii?Q?n5afG48smfuVvR1eu0Qnnu9pc3sX31qrzJ9r3Q3lEdaLPdZyH5SCBasQxIEn?=
 =?us-ascii?Q?9LuvKUQQA/XAo4T5QNqJBhtmqHacLJREYR5FqCuFOrR2TJsYph+uG9u09wCP?=
 =?us-ascii?Q?WjEwvrjj1++umDlaP/aM1GOuc/2qvp9m0dZlfQExQeYGE6mosrOS+6tessvX?=
 =?us-ascii?Q?oXp5aoW80psegKxlDv3Pghzto8BuzjITZxxAAx0ZFk/cf0VCsDjNw234u0xi?=
 =?us-ascii?Q?LJkFGtn8ebYYKclKDBTwmdJWG+Chk3uNLdOIjt1HlqIvp+uwa4YOhcA/xUhP?=
 =?us-ascii?Q?eqc5bWpCNt7G+MDk3NCWP0ljb9CXeeHmbWtnr/3aAifjMY06epuu3GOT8NoH?=
 =?us-ascii?Q?A6b+XEegrgyEDtsujVD2I/WTVLsw0C6Ok60+jNt8mNfmjZ0ZSpvK6dyt/v5k?=
 =?us-ascii?Q?VpvMpjJ0W5bcmtfeKDbRsgInjmiSWl0U87yNTc8x1qtFRR8kiK3xeMTRB6RE?=
 =?us-ascii?Q?GSEj/qkldfLsHaIJCQML+kIp0pg0tAR7wxkZ8/g4nYS/14lCSQcvsS4xfV7g?=
 =?us-ascii?Q?+cCyTQc4+aURX3O6M1YbzcYKa6DIByIlOUS4BF9NfxquYsXHecVxeoX1g1UN?=
 =?us-ascii?Q?Jv2n0cDj+a69lxyDxCnIRh/dIkH6Zs9S9y8hy464WI3zVYhXKHAso9tI6ZKd?=
 =?us-ascii?Q?+StQOJ3Pzgh3AftSVIWHSYfYF+7jnYXh0X4t8VYKhDwtrtZ1KK/NKfOXQj61?=
 =?us-ascii?Q?vCiVSuaIl6hnsWOnce55mMEUY9gQsGTsq6l9ENy4Yi0bT3Kt7eg4XQ7mXa3+?=
 =?us-ascii?Q?g0rFcNfGzNRmhLBEKtA3Rs0YL+5GnTDJUswY/qGcAYDiblMxEA1ONR/VnFlZ?=
 =?us-ascii?Q?6PrfsUfbJteDSM6a/LLmTvZ3TwWGE2TY9GaMTyMHxCoM6sVS5dfpQszA7cva?=
 =?us-ascii?Q?rVkCU819U/GOI/humqNriijp4YatHJygB0aqQ/UAcTSGq/hDRCUttvNhJEj7?=
 =?us-ascii?Q?fVpbB+f12dfY8UpIlv/u5JseTlVNXhHvY2NE0oN5fj4FnQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FCDZWoRNuIsm1+ZDNEp1zb5RfFEtF34he6y2gnLRS96IDgZ7JRyKqzN//ldU?=
 =?us-ascii?Q?6SdLb1uro1G9psFZhZmMFW1fQUq0hiNXQazi3QJHCIzHr0MaNPYZms/ifarx?=
 =?us-ascii?Q?AjL1FwAqUJlpGS2r4LVTBoAuVFi8hxnrCZK9Ps8oBPMV3gmyxHoRyHlEvbJW?=
 =?us-ascii?Q?i+UKe54OZEJVYa46ST81ScN3Snh8/ps5UPTsNKv1QvV/RYyyJubmKAiktMcF?=
 =?us-ascii?Q?oI6CiDHWG5+BPO1ys0H4EQ+2PXHt5ClVdT9Pb17tVdHVaQVwIu+7XjjxObyY?=
 =?us-ascii?Q?a4M5tXhjbPaJzOhhU/rBQct10j/x/hykSgSRxQQSCfZblw0gkxaRGDGuar1w?=
 =?us-ascii?Q?nWAaZC8Heq9vVHpMvT/I9MhKZYK531KvuGGF3m4YvIRFkm8afODurYSSUZ83?=
 =?us-ascii?Q?/HspfoIJhEODBq5scJ7mmS/xZl/6hOgJXPu11WcHeqzXSx3ettmie5hsJS0u?=
 =?us-ascii?Q?9f/K10T1YzlZOYr4ueL9lDOt+YGq0jUFR9CihZZSK469lwQKWTwI3zmRkExZ?=
 =?us-ascii?Q?wtXpsYtOiSNXtliUSVgYCu8vODduQiiAm9LGYjq+f3CLQ2HKoQtkCuPKb4O+?=
 =?us-ascii?Q?2iw1niJmla5nHlayho1hT6+qhbmWLQemFvc09IVa8loEwkrrpIh8eYqGVCPA?=
 =?us-ascii?Q?XFtpAienl6wBe5srHdUb7QRWThnwBC7MPm7kB4aVDD2vEQuGu5l/bbmrxN4N?=
 =?us-ascii?Q?mi+OaurEQZWOWGBDImiU3fnTt7ltDwQY5WOYhOzDK391PAxH5eF4hxXi1IKZ?=
 =?us-ascii?Q?d39u6YcfJtaSAHYptO1YocwBhPv15kKS+/eldTKNafw4CuoCkAUjRc+NsSAf?=
 =?us-ascii?Q?1MNbSlUSCSGbYRIGkeQTYw0+rP18VUjnD5h4k40Jf4EJwsXbv5EXfFzDdZIu?=
 =?us-ascii?Q?lfEEzHfSunwPoJESBL1G+NQkd62z5D3QmRz+hntNvpc/J9IZrODXR3L2NuaB?=
 =?us-ascii?Q?hKFQHsIWwLL+1RhDppCpIMY7ltaqiubyvVNxU7RbH6RvQlI2t6KtkUxxBtg6?=
 =?us-ascii?Q?mXF2hWI27ThJcKN0XVl6a7JUGyX+Vk3zPVMNtEsNSTQhuiOI7kx0Lf98V9fa?=
 =?us-ascii?Q?RUwCzGn6jv0mNA1i2rGI9XpU0VfJAlHBwABrK7/xurxmscb8ngPwnkuz+L6v?=
 =?us-ascii?Q?gjIn/WHcKtU5gYBT/EL0BWFSyuaYfxfjMxM01pfIDAUJkFvrLq/0fnfg3aup?=
 =?us-ascii?Q?Wt0nWClGB7azS68AhUYdmPkWMXJ1eNZtXbYNYmu7AbO6DQqcfi9NZH16JlQe?=
 =?us-ascii?Q?cLcjBC75Zfh3x3g+U7FodCOhOCerjhFVcgFbkwvwMpFeGtX2o23K3FmvwrcX?=
 =?us-ascii?Q?9aLuyGysg8FHpcgz619q104AKBILrMDeauyul8RV6q2VlDcs1Zfl4l46nvMb?=
 =?us-ascii?Q?QXtMNJ6XVPz83oY5cDO9uVO+JTDQIxjSjlLjL8rSsZk6FjmZiBq6AJ/lBret?=
 =?us-ascii?Q?fW8V2SonpoFakPPxKgFMPeRqVwNIuXRo/YrxvFp59B5TSSI4qINifBfh1KJ3?=
 =?us-ascii?Q?7EusHZt3tjMdOIBHV+PH9iFWpcUVGSulXC/SnpubzjnzB8tpL4BmVXKXJKU+?=
 =?us-ascii?Q?17RO+mp7PFtHClHvsc850PyHirwilmCoSLhejMXyQY6XK6iVIZVyxiVdZc+p?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1269d181-0eaf-4904-5d13-08dd3a2be548
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2025 14:57:16.2536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdH+CHk2aV4EULPyMsU9sep0I1gIMoW8cU+8OQ1kbDJ3ZFahUy36u9WeK9VWXilDrNRRWzB2jjQL3vjZ+wNr2JgLagv3tCs4mVEg6L1xN5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8314
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jan 2025 14:57:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17560



On 1/21/25 12:37, Chris Paterson wrote:
> Hello Sai, Quirin,
>=20
> Currently there are two MCOM =E2=80=9Cdevice-types=E2=80=9D in LAVA: x86-=
siemens-mcom [0] and mcom-mtda [1].
> It looks like the latter is being used for the SWG testing.
>=20
> Is there a physical difference that means =E2=80=9Cstandard=E2=80=9D test=
ing cannot be run on the mtda-4-mcom device?
The difference between `mtda-mcom` and 'x86-siemens-mcom' is the how the=20
image can be deployed:

- `mtda-mcom` boots a disk from a virtual USB provided by an=20
mtda-device(rpi4). During testing this device flashes a shared disk with=20
a image and the tests are the executed on the image. Due to this setup=20
NFS based test are not support on the `mtda-mcom`.

- `x86-siemens-mcom` is directly connected to the LAVA Worker and boots=20
via TFTP and NFS.


         +-------------------+=20

          |                   |=20

          |                   |=20

          |                   |=20

          |   LAVA-WORKER     |=20

          |                   |=20

          |                   |=20

          +----/----------\---+=20

              |            -\=20

              /              -\=20

             |                 -\=20

             /                   -\=20

            |                   +---------+=20

+-----------------------+      |   MTDA  |=20

|   x86-siemens-mcom    |      +---------+=20

+-----------------------+          \=20

                                +----\---+=20

                                |  mcom  |=20

                                +--------+=20



I am currently writing the setup guide for the mtda-mcom.
Best regards,

Quirin

>=20
> Ideally, I=E2=80=99d like us to move to having a single =E2=80=9Cx86-siem=
ens-mcom=E2=80=9D device-type for all MCOM devices, and if specific SWG job=
s can only run on the mtda-4-mcom [2] device then we make use of =E2=80=9Ct=
ags=E2=80=9D in the LAVA job definition.
>=20
> [0] https://lava.ciplatform.org/scheduler/device_type/x86-siemens-mcom
> [1] https://lava.ciplatform.org/scheduler/device_type/mcom-mtda
>=20
> Thanks, Chris
>=20
> From: dinesh.kumar@toshiba-tsip.com <dinesh.kumar@toshiba-tsip.com>
> Sent: 17 January 2025 10:42
> To: Chris Paterson <Chris.Paterson2@renesas.com>
> Cc: kazuhiro3.hayashi@toshiba.co.jp; cip-dev@lists.cip-project.org; Sai.S=
athujoda@toshiba-tsip.com
> Subject: RE: ltp (syscall) failed test in CIP Security image with isar-ci=
p-core v1.6 on M-COM
>=20
> Hi Chris,
>=20
> Thanks for your response.
>=20
> Sai has added comments in the MR. Please review them.
>=20
> Please refer my response inline.
>=20
> Thanks & Regards,
> Dinesh Kumar
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@=
renesas.com>>
> Sent: Wednesday, January 15, 2025 7:27 PM
> To: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
> Cc: hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=
=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=
=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.j=
p<mailto:kazuhiro3.hayashi@toshiba.co.jp>>; cip-dev@lists.cip-project.org<m=
ailto:cip-dev@lists.cip-project.org>; ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-=
tsip.com>>
> Subject: RE: ltp (syscall) failed test in CIP Security image with isar-ci=
p-core v1.6 on M-COM
>=20
> Hello Dinesh, Sai,
>=20
> I=E2=80=99ve created a MR that adds build/test support for the x86 merged=
 config [0]. Please look for exactly what=E2=80=99s been done.
> Currently it adds support to all the CIP kernels.
> Do you also want support added for the stable kernel versions?
> [Dinesh] I have reviewed the changes you have made. It=E2=80=99s good now=
 merged configs are being tested at least on some targets.
>                  As of now can you please also enable running ltp tests o=
n x86-siemens-mcom target? With kernel 6.1
>                 At the moment our primary focus is from IEC perspective s=
o running only 6.1 kernel is sufficient, but if other CIP members have requ=
irements to run other stable kernel versions that can should be discussed i=
n TSC meeting,
>=20
>                 However, please note that as this setup is not running CI=
P security image so we will explore options to run ltp tests on M-COM devic=
e with merged config with kernel 6.1 via isar-cip-core pipeline. (This is s=
till not discussed with all members)
>                 But this setup is also important in case if we want to co=
mpare any failure cases etc.
>                 If you have any ideas how to run ltp tests on security im=
ages on M-COM using Linux-cip-ci pipeline please let us know.
>=20
> I=E2=80=99ve kicked off various pipelines to test these changes. Links ca=
n be found in [1].
>=20
> [0] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merg=
e_requests/65
> [1] https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-/merg=
e_requests/65#note_2298307207
>=20
> Kind regards, Chris
>=20
> From: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>=
 <dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>
> Sent: 20 December 2024 16:56
> To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
> Cc: kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@toshiba.co.j=
p>; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-project.org>; Sa=
i.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>
> Subject: RE: ltp (syscall) failed test in CIP Security image with isar-ci=
p-core v1.6 on M-COM
>=20
> Hi Chris,
>=20
> Please reply to this email as by mistake Ashrit included SWG.
>=20
> Regards,
> Dinesh Kumar
>=20
> From: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@to=
shiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
> Sent: Friday, December 20, 2024 7:43 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>; cip-members@lists.cip-project.org<mailto:cip-members@lists.cip=
-project.org>
> Cc: hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=
=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=
=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.j=
p<mailto:kazuhiro3.hayashi@toshiba.co.jp>>; dinesh kumar(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.com<mailto=
:dinesh.kumar@toshiba-tsip.com>>; cip-security@lists.cip-project.org<mailto=
:cip-security@lists.cip-project.org>; cip-dev@lists.cip-project.org<mailto:=
cip-dev@lists.cip-project.org>
> Subject: ltp (syscall) failed test in CIP Security image with isar-cip-co=
re v1.6 on M-COM
>=20
> Hello Chris,
>=20
> Hope you are doing great.
>=20
> SWG locally executed LTP tests on M-COM x86 device booted with CIP securi=
ty image. The kernel used in this image is built with cip x86 merged defcon=
fig<https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/blob/mast=
er/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dheads>. After generating t=
he results, we found some failed tests in the syscalls suite.
>=20
> We wanted to compare them with kernel test results in LAVA and noticed th=
at cip x86 merged  defconfig<https://gitlab.com/cip-project/cip-kernel/cip-=
kernel-config/-/blob/master/6.1.y-cip/x86/cip_merged_defconfig?ref_type=3Dh=
eads> is not being used to run LTP tests on x86 targets. Can you please loo=
k into that ?
>=20
> I am attaching a document with the results summary of LTP tests when run =
on M-COM x86 device with v1.6 security image. Please have a look at it. I a=
m also attaching the failed test cases in syscalls suite.
>=20
> We need opinion from members if we need to hold back from sharing the v1.=
6 x86 generic isar-cip-core evaluation to BV members in case those LTP test=
 failures are effective.
>=20
> Thanks and regards,
> Sai Ashrith
>=20
>=20


