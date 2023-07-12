Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D50EB64DD
	for <webhook@archiver.kernel.org>; Wed, 12 Jul 2023 06:04:10 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.73])
 by mx.groups.io with SMTP id smtpd.web10.1290.1689141848636596725
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Jul 2023 23:04:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=iJswXSD0;
 spf=pass (domain: siemens.com, ip: 40.107.7.73, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTpxQTdOAgNWagBqgBxL19hbzIc4fViNOCrpmcWQ0+BLTUnGfG+qMBvd0bjccxgC+t7wkjjAIwyKWdQiNEWfH7wxHPHwi41vHcD+g0RHNM8nyLLn5HPgqYWseBLX+XuLcHG6IWJMg5bFdOKlsr2OLLcmcRJtbbsvmkD+TEjKp49AZd3R/IglgZ4XbDG8ldzHtqK1ZglnkrviYCGqJr5A239E5CKf0stmaMO89mpzhpUofEab76hHTik5ghknDnYPF2CqaC8UhxKNznkEYDnAT9Sf+jvS1FVQ64PvqJzgVXQLLslOU8HrYMDyFdIJtt3hkbaOHM0uieXsC+vh4/TamA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJMZfQl/Op46nRegKuRnZWHOwMla6HUCGwfDhj0I2LM=;
 b=IUVFMjGHQ1gtIfr2fMvmA8KKwN6cnDVzuFGzlgPuZ5vUy6v3jAHvfuaqZaGcMK41pLJ1hDbthEDVknXMKT92LUNSo7/MSdWVH3DLAgQv6QA37Jihwy4dwbC/l3Jn0EsQHh831ILQv36iRSmjrnTN6VogZc48YNW3wT3jEbChUW/BAuNwy5ZluDWmsMpuQ35qaRVOY3vuHeHTIDmuAOJePRP0zcxRr91dXvYwODGw5gTCRvwozLyVKotVJ5ZZJnVu0ZXflVpbSjT67UQXIpmbS1zsIKZJgNlv4lcdzGAHAtf1ig0fxlpBuNoKOEiPYmn51fdkc0WFmiWaOddscCPKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJMZfQl/Op46nRegKuRnZWHOwMla6HUCGwfDhj0I2LM=;
 b=iJswXSD0mWO59W1d8MIsPCRcwkYdcSzzGA8qeQTeL6q+2fRYLbpxYrsaJy+2WjziszrLjz4EzzeA7uyaPVtvJCKWiEbWSynqq/vI0gZiVcMmu7qbepihnNYf95w+DCUEjWhuWC8O8MuhvQEnoBNfGUga/kZAIkfDfxFmgldOHfro6faFhSzBcQh+6+R73+KxcthzWhE/ldqiVD1rATu0BwVF//kcCgOx5QJGTiBcBP4Nudmcrr6EEJv818grYb1zWLT+eTVSkw9TMTrYaJUVaukw61I+kR92pz5O5XHUUfZaGOP0qRA/hOulA7yMj5Sly3arfDvczi6TTrAyPu9wiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7479.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 06:04:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 06:04:05 +0000
Message-ID: <3b49adb6-c792-94d2-f53f-f91e64dd0436@siemens.com>
Date: Wed, 12 Jul 2023 08:04:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: RE: [cip-dev] [isar-cip-core] Kconfig: Add additional features to
 security image
Content-Language: en-US
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
CC: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230711133838.437045-1-Sai.Sathujoda@toshiba-tsip.com>
 <36842105-2853-624d-eec2-98e81108acd3@siemens.com>
 <OSAPR01MB49455B886FB98BD977456C36C236A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OSAPR01MB49455B886FB98BD977456C36C236A@OSAPR01MB4945.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FRYP281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::27)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: ffdae80e-8d6f-4338-5245-08db829dcc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y/6LPdIEzyuCxZiFa8OR0xV+VtrpMikCTZVBJjhd0F+AHtL7LPsUioFKB/JC+h8xpv1ijudZNYmlb5U6cCalcV9NDB8K+xffo54WbvOejK2eAACg6z2cEBsbXGF/lcjB5GAggU6N5vyS8vPXyeYFY4R4J5akdbtXfYrofT6Ba+iZvyNVMxd7C/O18ZXoLwVWfYx6Xe723h1IVdt/NuaAd6+wTZ0chheH9SGfhYYLL4VVZzMUiaYfEPDd7O2ynDubqzrh/5DQsc62Lk6t4c0U4HgW2+WWGNUlx9C6Eo7xTo6dG9MgN0Si210Mw7uZkKgXU0skug7k5S5wnmK+Yr8va1kcaFNhVy/Ezl351/CiyXqUMj8P7JwJdNuEEDPLzfs0XBqgrBk2TUOuZRSYXBQGXD5SE1TfaM06x0ktODOmBLkbrlCF+KGzXVHjp6yq/nPu4FZ7PtEg3pvcfYJF8T/0y8Y4gT/p0QXdjIfv5OCF+jTFaa7LfjU0VuCY9bePUDtQzkhrmZM9hWNxVwK+XTCojhbwyS41vMy8OjjzlSe+0O0uJ1mZmtr9NvPPDr4Dwwx+av6AZo5lj9mo5eQSzgZo4bjnIR8YsAIduLIUtQ5iCbcRUuLxJKaOLhxDHvMBx3d/LJZ5LawNdN/5+XJcsAGB8g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(451199021)(38100700002)(82960400001)(31696002)(86362001)(31686004)(36756003)(6666004)(6486002)(66946007)(2616005)(6506007)(186003)(6512007)(53546011)(26005)(44832011)(2906002)(66476007)(15650500001)(5660300002)(66556008)(8676002)(8936002)(478600001)(4326008)(83380400001)(316002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oNwZBKIZDVNXTaEsvkHSUgvXhuLOjhFQ2AApoYTd0xgslffgAbDsO5z8eedJ?=
 =?us-ascii?Q?7rMBiRlfYjWFmsfewrg6T2PsLSBNQUpaf/3//VNUXIb3fvXqXk4QAu12CPFy?=
 =?us-ascii?Q?IFVCohULFeFN1grCnBPYlr+8hlSJrPRGvijbrRqwg+hFNE+7aGgH6DSagBXY?=
 =?us-ascii?Q?ePsS8e75J2ofs4bkwEdX31zc9iR6Yu5csS798eBpJ6K760/SpWPhXsOlViz0?=
 =?us-ascii?Q?k92cugN+e0ZguWyeBUIIjmOd0AWueIcdDBhTOVJRSs/iwevyMGqNkR8UJowL?=
 =?us-ascii?Q?Ykn65YM3AyGvNVv8k/OTtqxRiY3k4w4qyONWcagAMy8HhbR6hIe4TlL3Qzor?=
 =?us-ascii?Q?fcHa4WmrSOvd31gEl2ZJdHRbb0ipSDlON5Ty7XabVM6T3ulr9fFNQafSrn9a?=
 =?us-ascii?Q?iOZI6h1UEoU4mI577VJ3gHRB0MDYITYqxd79nPKH/srH/EzFnw46iGwegzwL?=
 =?us-ascii?Q?R+alg6NoEshVfFRSzcLUGJsEzQNMDGMRIgXwY3V+dTO2GgUUIn9zvIj+cqY8?=
 =?us-ascii?Q?poh7ThKXmuExHT4H1sxTpm3jy3ETxVv0saqEpcMaO0tBqVyFxW2jG5UQuDLR?=
 =?us-ascii?Q?0pPbygR5ql1AxRc8pZX2Sv/wxBRxzCX8o+Fbq7TswW99HAXeaZmNxd6eQenZ?=
 =?us-ascii?Q?DZjBACQH84ak644zswFniw9C0xjEzdJaq6JAoFWc80TK8cIoQoBbOSYKCtHc?=
 =?us-ascii?Q?wZ8uRazVgNL+8y7/DbbrpgruixSYtStxBR53keLaAUliElvFN8IuHcwISc7+?=
 =?us-ascii?Q?RemNZwhXmqLfhUIi+HACO5roiA6tpQ+TSguPxaXQCuulLO3yEOfr2OXAc7AO?=
 =?us-ascii?Q?ZZ3SAB5bcTEj2E+kqJDA+0rOzFRVzwqCUzPeAer+NbsVvPvQmZEImcYqt/LE?=
 =?us-ascii?Q?F8FdVf/Fnn9MsgRyvdgjyJT/WoD5+xFu4XQDrPguJuowGEsTn9bn2asenR8J?=
 =?us-ascii?Q?GSBuq99xfbcEAQf8g1xm6m2btaKRvGJBafHo9vVFKIfMmdL4vy1Z+7QyYhP6?=
 =?us-ascii?Q?/7KCZr56vmDINsme82n0ngcCMhkrvfeBJt3BTk/FoKjMGSvw20O07CAZ0EsQ?=
 =?us-ascii?Q?0vrR1qEZVQlLQv087d0Aoge2XwVXJCbuKjwVmwDxPjAIGXyhUPc4xjRYru2s?=
 =?us-ascii?Q?Ql2mjbkd+BHXQI26WDUxC3dfZu1Yehi7/yaSkx8aBzJPGP9PHXsoydtXytJH?=
 =?us-ascii?Q?ppN8cp5zcYylNgNuCdoNRXJ+x913kuWiNxTwMqOcEvMUcvZ+GsJaWhBEM/AB?=
 =?us-ascii?Q?9u6qiM2xK1yZDIDMQV8FRHBVd/ew27iwwDYZmcQ1dDbHGL1wiAIjDCDGaQ9s?=
 =?us-ascii?Q?0dSms6Kn+BNz7vdnaK3/toGmVYn7IP2XczuQs9GBIdsYpZba5Qt668kDZ9HP?=
 =?us-ascii?Q?bGGaz4V5O4RfPwrTkphfBDK6DjJv7U2YVtCmOTCVNRw52POZgLFGXZqsusfA?=
 =?us-ascii?Q?HkU5AJ/LodartolGVZy7aLdOhbkV0BfEgLhmn5zBQM85hy5T0xVOaiE3XURR?=
 =?us-ascii?Q?zOjbM4MAxOYZzhY+JyUcrPupMYGKc6a6zgts+gCJbUa9I62uF0F3Vzbmsj5/?=
 =?us-ascii?Q?apySMUQAsIOBFr216grSkVsqm9k73AMURzWomajmUfVaAMdS6ETbxShRyp6S?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffdae80e-8d6f-4338-5245-08db829dcc2f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 06:04:05.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8jodPBN3y2SU9qdMB1UCsCnuZxnet+fYbZSFMWlYioUD59hUesD+xu+ljZ9kWhTOT7CLtCnzePCEupXrRNpwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7479
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Jul 2023 06:04:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12326

On 12.07.23 07:11, Sai.Sathujoda@toshiba-tsip.com wrote:
> Hi Jan.
>=20
> We chose this approach because the kas-menu will help user to understand =
what features are included in the image when security extensions is selecte=
d. Your suggestion is also good.
>=20
> Do you think there are any drawbacks in modifying kas-menu approach, Jan.

Yes, because now the Kconfig choices deviate from the default you get
when calling

kas-container build kas-cip.yml:kas/board/...:kas/opt/security.yml

Jan

>=20
> Thanks & Regards,
> Sai Ashrith (T S I P)
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: Tuesday, July 11, 2023 9:39 PM
> To: ashrith sai(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@tosh=
iba-tsip.com>; cip-dev@lists.cip-project.org
> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) =
<dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=
=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=
=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhi=
ro3.hayashi@toshiba.co.jp>
> Subject: Re: [cip-dev] [isar-cip-core] Kconfig: Add additional features t=
o security image
>=20
> On 11.07.23 15:38, Sai.Sathujoda@toshiba-tsip.com wrote:
>> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>>
>> From IEC certification perspective, a security image is needed which=20
>> has the below features along with security customizations.
>> 1. Data encryption (CR4.1)
>> 2. Secure boot (EDR 3.14)
>> 3. SWupdate (NDR 3.10)
>>
>> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
>> ---
>>  Kconfig | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 94e807a..a9c3425 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -171,6 +171,9 @@ config KAS_INCLUDE_IMAGE_FORMAT
>> =20
>>  config IMAGE_SECURITY
>>  	bool "Security extensions"
>> +	select IMAGE_DATA_ENCRYPTION
>> +	help
>> +	  This enables security customizations, data encryption, Secureboot an=
d SWupdate, all in need for IEC certification perspective.
>> =20
>>  config KAS_INCLUDE_SECURITY
>>  	string
>=20
> I rather think kas/opt/security.yml should include kas/opt/encrypt-partit=
ions.yml and any other kas option needed.
>=20
> Jan
>=20
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>=20

--=20
Siemens AG, Technology
Competence Center Embedded Linux


