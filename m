Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A11CCD68ED
	for <webhook@archiver.kernel.org>; Tue, 10 Oct 2023 07:01:46 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.77])
 by mx.groups.io with SMTP id smtpd.web11.85027.1696921297999323892
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Oct 2023 00:01:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=u0TvAIt2;
 spf=pass (domain: siemens.com, ip: 40.107.20.77, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YANNsmdbEP2unHX/JUzunWM41cF+/2rYKRlzdNVcbjkg0t6z0qur33sr/uVQ90WNXhT4BeJH/eB94F516CODfmG1III2ESjE0Aa5GiTZo7vBOSYKdW7AEfgeFtUJB0xevhVzDLbDSqyqsUiAgb9mS7uM473kICd9dTWf2N443MqzD8kVrUHbpg96VoRSjYFGkLSbcHrjE26sLLgYVadJM+rQyH2zIpXC54FBLRHIjRX1IOzgPrte+yQ5KD/EfbrJkmUM7UPyrktsCbmhE+0P9kDCWoBWHKXSzAw5TraHi26OEvckyVjsX2YNuNg1LekoL00a7AB4QddEZm/cxkh7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hgFr+VI1r4FJzNTDSfKQ2tYMsU3M/mrWBYQTQE00350=;
 b=gjBS5uP5jM5XUuFxcXUmk9gCtLq2xWGJ79hW6zNEkSRtsZqG/qJYl614IuqbZdX8gDVh3PYAFAn1uZEkiblAr9lG4OY3a95PXw+Uq662luqKV2Jg2e3TGbrH/NoSn4M1r2LevAYFPkaZDwpeZONlZGRHrjbmbwqn0TKTabdT4YDqcAiLtDVI8B/CiY7wIW/wpyKXDdghoLIuIu1Zdwicq8pisXnlI3EWBsTNSSwMi/eUL/Yzi9GmNdTADr9pZBZhULkHNMa08U88XchC2SLcHat9CA4KmtsyU3QVU/1WOk/1EtQb97CxuPIJTPNBB8KD+x2xbWq1xbVCIcxjh+EktA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgFr+VI1r4FJzNTDSfKQ2tYMsU3M/mrWBYQTQE00350=;
 b=u0TvAIt2bnaTD0brSfgZyzgamETK44EWZaBBtZlTUSLdvLwPmDJi8FHSC5JEBpXp8UkciqsveUSODr3tH9S9uhnzC4wDbFzU3Up37aQQ3OKdURKNSFs/WFBrg35giWAnUigKmH4mAT0wTGtPhd/Hcvf8tvLA1ZKGVXfEM+4yzmO9oUM2dtcnwTeXOYGovdi5oZZGeNdc+qylK2MqrwrSiCf03jRgMAkHwawRMjloOb0/4T9aEUf8E1dH92qYnkUkgwiCmBRehiW1ckQ5T4r1va5cIFLr2MP3IqDuJOcrXthJmH1fPT1bzKKUUf1EYcZAbcIfAVlfokjHo1yYgjw2qg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 07:01:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2a90:96cb:b3f:6e5%2]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 07:01:34 +0000
Message-ID: <f598eec3-31ee-4c3a-a961-24363e5f6a11@siemens.com>
Date: Tue, 10 Oct 2023 09:01:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core 2/2] reproducible.yml: Disable signed
 swupdate in reproducible tests
Content-Language: en-US
To: Venkata.Pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 quirin.gylstorff@siemens.com, christian.storm@siemens.com
References: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
 <20231006125845.2661-3-venkata.pyla@toshiba-tsip.com>
 <c6612b4c-b17d-484f-8cab-1f204567a456@siemens.com>
 <178BDEF1D76FA0E8.24994@lists.cip-project.org>
 <OS3PR01MB685635BA1CFBAC30375EAE11A4CDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS3PR01MB685635BA1CFBAC30375EAE11A4CDA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0141.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: b07a716f-42c7-44f3-a452-08dbc95ebd41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YvZfEfRHOkAfVHwIZaipqHN7dea5ngdCbLW8JxUp5AhqqspCzldez2r2VPuVSevTI6wBfIahvBDD+eMo5+6ccXDVTTBIIGOuuBr+qZSDJMPxAUy1fIIJO6V5fs2fXfqH075Z43vsdBBPJadaZpyf1D/QUUusAFBwCnXvdRQ2Mj34M573YDjRUp/He79EcNWsYvAHxFqL+9P74nuUjdqrdI0rHj7ZK6paWeL4ni0sNbGCwrm7/OV9eIcQOudX1T/SZNUzyU4DhzlwO0G4EzD1Nn8CUDBZBWbuHXasQFxc35yg3ug9c9tjWu+xwnUe96kjv+WTOe1xntcAwZja+s11TyIMq5RHJKDwblNV8rPExxSPU1ljb/1rRF1t2dpK0pGmu6x7RwwFiReMEYrEgGrs9eWH3OSLby9GEuSGck6S7/cepnKQ0iXlaVwgWUJtaWX0ZsRwpMg+347Tu7lEXQGLDzDL1t+sBI5MzfTkqbr6ALxpbMlkm5dlG4AOAMTL4RdsWd/Am09oRDYL3gz/oIr3jfGkIcjqzMrvMhsDhNFZxbWa6WxUDoJzM2+KKZU1PVgIpNJ9d6uX1zE2idWgkRZo7E3OfLx8oTcfpzvZ2Lvk9hgku74JuRyMpqFeGLAgiwY52Q6sj/8F6hdIc+uCKXs4TA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(8676002)(4326008)(5660300002)(44832011)(41300700001)(66946007)(8936002)(66556008)(66476007)(316002)(31696002)(86362001)(2906002)(83380400001)(38100700002)(6512007)(53546011)(26005)(36756003)(107886003)(2616005)(82960400001)(31686004)(478600001)(6486002)(6506007)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?5OfGWwJr4ZWXZbIpXeHRHbwXCx3247Ju6vuJ9b3ljGxMhDLMYmGHLWuzYnoF?=
 =?us-ascii?Q?BEnbx3Gr5ptJngq7OElMmTFUNyliptoSzTAgYsg8b2SsamEDC9bf3STlvqDm?=
 =?us-ascii?Q?+bixH9iSrSbbW2ScUS4nAmZSOmsjdiWJtGxtw39WB2yoY6BWfm+FDiPPjs3c?=
 =?us-ascii?Q?rQH4GOim6df90diqWtTvAz2QrAbvxfrbQOCmSHpZQL7YTo5DZcn0cdTWPLUm?=
 =?us-ascii?Q?hDUF3AO5Vg31Qq0F28gJoK4v2jj/7hI+lUmc9DudnmmHomxGNciN0mevVrUQ?=
 =?us-ascii?Q?DDMeGhIMzpYByLA6ukFt1jvr6iw2y7rmd3Oje+qlppOa7TZAsqzu1dGzPTbj?=
 =?us-ascii?Q?knFeqiLvFXUtd87j1de6AihxmcJShjrZTTlDB4/lzz6fzMibLrjYuyQlIJef?=
 =?us-ascii?Q?pGXMUxDGKVwD+PtLEs4e80q8NuKtFUOUnfrBqS1/6VLgSNL79XIXRGkIfFVV?=
 =?us-ascii?Q?5Hashuh7Bmw8QVht5MHjELO2i/4JvoNSSioPo9tQgmgHxfS2RZSAehhWkANs?=
 =?us-ascii?Q?ZKGZGBf7wuDXV60u02nao1npyudimmUb24V59VDPaiCKvp3aK+SvhqDXpJWK?=
 =?us-ascii?Q?ONjRRco4qKZZudP25Lil/SZguWmvF+Q6fdqTOVTx+cXJENRCpaqtGduQe5B3?=
 =?us-ascii?Q?20bbdBvsXl6TjbV9N3KSOI6idO17p81d/gZzneP+8cBTgHzdPjBW/6e4Moc1?=
 =?us-ascii?Q?1733tbzhLjzpM2IfSxDLfQ2Hr00xDDeaXZBMLqSVGd2Ka7y0EkotvEyGlYhV?=
 =?us-ascii?Q?IbWvZ5Qbux3O/MHiZB8L3Nak309FA6jM1No55FF3DOkfWCcrK6vDHYFdlkt9?=
 =?us-ascii?Q?J+BhFVk2s65z70A+15p945aBCimpCf2x9oOSiSeyATegWyvE2RhOMofk93M1?=
 =?us-ascii?Q?7dHhahBQPvrgE58tfKZ3C/aB2xHRKcgUF0naKsi4+09ZlbL0qkN/BG40Hcwh?=
 =?us-ascii?Q?tEytrZY5fySGJcd+hVX/6MLUQYjUyBtjbOprCwx1atkf+uPLoP4PC3OKjT86?=
 =?us-ascii?Q?ph+0STDeGKWCWvqWpWtl3WXVqJ2fT9n6BOdGZutwVc1PzLktN6kmQdEJ1N8S?=
 =?us-ascii?Q?46MRe3FsYbE7JwtS2fdT4EbBksQT+PCc5tCtDLAs8zu+6+xoqv7oU86aTC73?=
 =?us-ascii?Q?BngYnpxMx9QZnaxj5M03PWls7IsW1D8zWlGwhO2yvCZcu0odpYpznE80Orh2?=
 =?us-ascii?Q?SoG6T/s+IjGMZttSDmIUR091prqsVs92ThjWHW4jjvWz77FHe6cF6yrC/x17?=
 =?us-ascii?Q?tpPwpXL6CYI2Av4xFDNLO2ghde3koeNfK0yN0KIzRRrJ7Rbv3biUsfLPzV4H?=
 =?us-ascii?Q?p13FCT2HM3E+huLUK9JGFEiFqbgHok6XyF7TMUYHhBZcjYvLemiFBZE90usU?=
 =?us-ascii?Q?3wSMbW/nAOVqNxMQQBjWTfYDBPc+fl62uYYveYpoIBDOW2MOaT1A0bNVGHzs?=
 =?us-ascii?Q?zYgqoOHhbAZxXxcsROVkKdavMHHyUsj1N4tIxDp3I9igNPA/mxYIt/XQGl8u?=
 =?us-ascii?Q?+j+KZi7XBV/EFh7nxAQhJ2fxQOYCCbnYIl8rY9KzJTmvj9f7Rwsh67Efd48Z?=
 =?us-ascii?Q?siRd+FQ6a7tpt3dc76UvVKQBITokU0dTn0ptMTFKLuqRmSBUfqd9oFDMI9T6?=
 =?us-ascii?Q?yA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07a716f-42c7-44f3-a452-08dbc95ebd41
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 07:01:34.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ESUh+gH6aVisCJ2K52613k//010iFNBHcOjjJ1MyH5XOXsUsxTonsoKfPZWJTctJwvTOT9AqxiVAhA+OrpAGeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7635
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Oct 2023 07:01:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13338

On 10.10.23 06:59, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On B=
ehalf Of
>> Venkata Pyla
>> Sent: Saturday, October 7, 2023 9:37 PM
>> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <dinesh.kumar@toshiba-
>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=
=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=
=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>> <kazuhiro3.hayashi@toshiba.co.jp>; quirin.gylstorff@siemens.com;
>> christian.storm@siemens.com
>> Subject: Re: [cip-dev] [isar-cip-core 2/2] reproducible.yml: Disable sig=
ned
>> swupdate in reproducible tests
>>
>>
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: Friday, October 6, 2023 6:35 PM
>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting=
) <Venkata.Pyla@toshiba-
>>> tsip.com>; cip-dev@lists.cip-project.org
>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting=
) <dinesh.kumar@toshiba-
>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>> <kazuhiro3.hayashi@toshiba.co.jp>; Quirin Gylstorff
>>> <quirin.gylstorff@siemens.com>; Christian Storm
>>> <christian.storm@siemens.com>
>>> Subject: Re: [isar-cip-core 2/2] reproducible.yml: Disable signed
>>> swupdate in reproducible tests
>>>
>>> On 06.10.23 14:58, venkata.pyla@toshiba-tsip.com wrote:
>>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>
>>>> signed artifacts are not reproducible due to fact that the signature
>>>> can include some randomness for security reasons, so skip signature
>>>> verifications in reproducible tests.
>>>>
>>>> Fixes #80
>>>>
>>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>> ---
>>>>  kas/opt/reproducible.yml | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
>>>> index
>>>> 5d6a896..73dd4d5 100644
>>>> --- a/kas/opt/reproducible.yml
>>>> +++ b/kas/opt/reproducible.yml
>>>> @@ -15,3 +15,4 @@ local_conf_header:
>>>>    reproducible-builds: |
>>>>      SOURCE_DATE_EPOCH :=3D "${@bb.process.run("git -C
>>>> ${LAYERDIR_cip-core}
>>> log -1 --pretty=3D%ct | tr -d '\n'")[0]}"
>>>>      WIC_DEPLOY_PARTITIONS =3D "1"
>>>> +    SWU_SIGNED =3D "0"
>>>
>>> Shouldn't we rather or also check if everything except for the .sig
>>> element in a signed SWU is identical?
>>
>> If we have to skip the "sw-description.sig" file then it will also skip =
sw-description
>> file from reproducible verification.
>>
>> If I understand correctly, the difference between signed and unsigned sw=
update is
>> the sw-discription file and it will be signed in case of SWU_SIGNED=3D"1=
",
>> otherwise it is unsigned file.
>> So, if we disable SWU_SIGNED that will discard the signature.
>>
>=20
> (Sorry to jump in)
> Any comments on this approach (disabling signed swupdate)?
>=20

I would suggest to discuss with the diffoscope people if there is a way
to configure the tool for this scenario. I'm still concern that we are
not testing the right thing when we disable signing.

BTW, the same applies to other signed artifacts: It should be possible
to validate that you can rebuild things bit-identically, just minus any
included certificate or hash or you-name-it. We currently exploit that
we use a demo key, thus have access to its private part. But that should
not be a precondition to check reproducibility.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


