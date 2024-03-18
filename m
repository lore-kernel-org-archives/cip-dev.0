Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4CFC54E5D
	for <webhook@archiver.kernel.org>; Mon, 18 Mar 2024 09:35:03 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.81])
 by mx.groups.io with SMTP id smtpd.web11.39018.1710754499835002534
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Mar 2024 02:35:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=G+o97L7G;
 spf=pass (domain: siemens.com, ip: 40.107.8.81, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXvB/GRKYKmlzQiraB8rQPR6Xm1KTZWPtjyClb4EAuH0blPq+yXDZ5jsqQHskdVg2BvjMsDZ1SeErPAK5iZnAJtM2C7PBsozYbWo0ah96FW2GNYkPhg7BjKjj6T99Z56U+PpqYBCplnYDKg4eDD5+fYsj13L3cp9uiwQArqR1kzv0LJVxVgCJm+q4FW9r3RDQnEi470ng8wInium0vP+kQbbdAJU4X1RoZVU4GpKtaN2wIRbr8rIpEsJHwd7DOddoTHQASVMBF3/N2f/nUzSqWfooBWmWham42B919FbUiBBzc4VBTx/hKcay0RyCcLfgW7IPImEhrw3juvpORt2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS39i7706JRwCp0eF3quZFagVN0O5P9uWQowNPxWB/c=;
 b=b3ILEK6YhFuwawtAqR6vCKNw319U/XHPHcUANzClSHr0/uXA7E9zYTN7C3RGp9EFGBiC+0vnEV/rmipeTvfBr5xAjj0ax2guz4vEgo81Q13H8eYjQ9j6EDiPlpfERamv01mGABL4LLpqbiqbd+X9xF0I8NWF567/MCW3prRZVNqbTk0UAvh9/WGmkTmtRekNawWglvDOj6KHCsPlwHXnffNbpgq6HrbyhbMCVP3jhZL07gxKOBWWLGtB3/8QdGVZ7CzVo7OHne4s6UgWq/pX8fxUArzUl2NUpz92vCvQ2oCiB+VH2Uc1piGeqW2RVGQpSkOQ1yBPIsf7aYDFBjxeUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS39i7706JRwCp0eF3quZFagVN0O5P9uWQowNPxWB/c=;
 b=G+o97L7GeWF8Vn6iSW+PAyqu01OuYW3h3t1M/lvS7mZpjdnNHCCkfKHocG30LmtNicxM5F2sFvXVLg+EjuAuPp1EcITBJyeSjfnotjAKAxIi1DHkJWzPoFhN/2PVXgADXhoujsdOJD8nijipKIrIjrnaAfAEOzXgmOIR8x/282Q/dUWCrhB2wAjJGczcQYlm5QExqL6AMZQ7hba0r10T08rSC/fNeYaDZ2cx2619YBhxeO+iHCeuRTR+yjSq5f8V9xDvtHzEREbEvnk1p80o/0sddwzUkHAlK5NUhjVOuKkJFMqbT2gNvD+2NCDwXBZWdYsh/8q2w/9DrBhNIjGABQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS1PR10MB5580.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:34:55 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 09:34:55 +0000
Message-ID: <ef7a2a8b-e169-4937-93b8-3dc6d18086fe@siemens.com>
Date: Mon, 18 Mar 2024 10:34:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate
 swu for delta updates
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 jan.kiszka@siemens.com
CC: Shivanand.Kunijadar@toshiba-tsip.com, Sai.Sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240307074612.1996609-1-Adithya.Balakumar@toshiba-tsip.com>
 <20240307074612.1996609-6-Adithya.Balakumar@toshiba-tsip.com>
 <4fb765ea54765e58a93b6aa0d19f0054a0e680f1.camel@siemens.com>
 <TYCPR01MB96694682086B4F651CE7C8FDC42A2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <d9b9a979-41b3-4348-8171-14727d79d7c7@siemens.com>
 <TYCPR01MB966952366AB5AB0D4D749D31C4292@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <2f7b1523-39c1-4645-bb60-4f130a20a119@siemens.com>
 <TYCPR01MB96698E8364CFA2ECBF922185C4282@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <415b8ba9-8609-4841-b28e-58bed3b7bd26@siemens.com>
 <TYCPR01MB9669DC96E27E15CE192A6E9EC42D2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYCPR01MB9669DC96E27E15CE192A6E9EC42D2@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0207.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS1PR10MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: e0197505-3e0c-4638-8d11-08dc472eabb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Pu+UFFC3gh/gAdtDlRssojheEPb9tGLY3uCvdRMQQn4S/IqBacxUherDOBiSk5dxtAdYrVbxF1qNRqm5IMswknMFiJLfaUbZ02oUbtSu0WveF3h55iZqDA+B9wfgqbPkybjp/K6dV6wlguO5vy9ho6VVC8tT5ptjnD8ZiEbIAkGN4zcMEmRj2/HrgcOH4mT8lYc5vjWu7NPhdXzlsoRfMp2FviFNM5qyfMvtKaoeyq6RH41K1HQ6P7NxiOVm+rHdW2EqYYPLKhCV337r/nbe0z6Jl8y0ctHMLRF2BOVthQXuL4THD6yyxFOlKwMWM5KoNqnVcR0kF/2JPivC9BlGv8QBttmixPFLu9GZBQBeU1n+0sn8e4OqPPWlI06htFCIZH7xroGKCgqDfcXPRWF8cohkCJnw7l0DkN05vDlsoI2z1r7ftDrhVqRXQdRy1SKLd5uyuu5I5YF1uzHRZRit4Ji8WZdVrOJg8AHaBrOa6BFsFDLSgSYURgDtybuh3huvBwGF37VeYNRkvirtGCMuyMdLAZ2NcKGAZ1vsYSjcjUGB2Kk9jEPwLuXK4Ni4KtZRCtHgkXh03iBo8c8RAWvU1QqkJk7EA1mYPbtvlp+lSWQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?akkmOP/5uBu2OLLbP91+B8Q8xYR+MgnOp60VPni2kWsd6NmQrr3Qh6kTqoN0?=
 =?us-ascii?Q?DoJaEUNdgomkQUEATiEBe8uY//fzfyl8flvHxlqGseh83F6p59IbCSjA/fvq?=
 =?us-ascii?Q?1iSo7onE58KX79k1aFHCTq5JfXKES2zTFIficnfVo7bjjtfjRcSsaItPmWk8?=
 =?us-ascii?Q?pp1wSgev5G2SAbXliKruq1Y8d0LvcTYuAzajFUoRQaMvCpMIRAZmpixVl6UU?=
 =?us-ascii?Q?N7Ffur5FngAI1P9zoA2sJnbaiupHDozEeVxLFg29NeOoS7yJc2Ov/Fg7vtl8?=
 =?us-ascii?Q?zAuO4E2GgNdoeQhJXauYsWmAi+KabZlBskSYY2Z6s+jAVWYFtplK2j+bjfDi?=
 =?us-ascii?Q?6sAe92FIdWp+0d8+0SoBZIrSi8gejAN0zfTjDOu2SZoH6scijGiVEw1pS/bR?=
 =?us-ascii?Q?BDZQZw85yhh94hGhHCPP6rLs9tc4kGWFFejt+1gK1T87JJMKmTpFyIlIZRmh?=
 =?us-ascii?Q?RbvKJW8FTRLlv1QeQvCo3GOhQ11UqLjlEqtnv8f37sRM2QBQQT871TRlgVOT?=
 =?us-ascii?Q?L+1ZSjlMlk6ldwaqOEHoBP9CUEBf6m/9xF3slqt4wCzepkQ6F1qZzmrPwTYP?=
 =?us-ascii?Q?iNas8hY8hLNJzDaAtOmcpllnSTXNZzFe83ICOnr56CisqnBViY5Z4arg3l9K?=
 =?us-ascii?Q?LJwCUlVGRaOarVc1dhayHFZgmkyNBQ0rw5ZDVCp5CbSKSYNcu6yKe71hBdkT?=
 =?us-ascii?Q?SJ/DbFGi/8K+BKeviJJ6Hmd5QvJnPBSPYr5yFVwRJi+srB2SV1j56vfUU06a?=
 =?us-ascii?Q?4WC36tpAJgv8zsZVkWnxcRXymmpJ3n9nqo7fGkW3df4Sa6sB0y5CZmXhAaVj?=
 =?us-ascii?Q?NUxOkY4ZPoyD+EEjpZaFdnottE3ub3dnzXjS8LhZtTNsMFqIEP7AOuoVrF0+?=
 =?us-ascii?Q?GJF5FL5+kytLAH4exlVfFkz1UqLyrHFH2t9mAYeJvje5K2QG/eCoaZVEr+dI?=
 =?us-ascii?Q?RVPfYgC+kPk/8LUzD3n7iLPp+f9RPiPK0L4w9VS/ITGyyROVhK2+fFHqzRz2?=
 =?us-ascii?Q?1tNDA1HlEB0JdhnYA3NAx6z9HArCAupy5sN4nfZyLb79+VnLX6J3ImQReVe2?=
 =?us-ascii?Q?/qVg31UQHNxfNl31E/YqXOQCji1CxSlZ2rf4BuRUsp+iQQQD+/996qKaOANn?=
 =?us-ascii?Q?eOitVuJIT42nkazM7P8ua5NnuEazYhHJy2Qf/5CgsoVbOqHfLEWmZczsA06W?=
 =?us-ascii?Q?YJMG+XBbs2SxMgT0z/8OLaQGizdZqGSWGCSkin1wzHPa397gzrvvldjJholZ?=
 =?us-ascii?Q?Ry7Ixng5EWXvTthwOtefSP5tb2NnYMypt1LzENwlKLzdcpbJFN19u1YUnSZ2?=
 =?us-ascii?Q?fAYnVs0S6aP4MIcLJOOOFmBT5Td3B5Odq3qy7uugCfuELOpZ74/onDR22lJ6?=
 =?us-ascii?Q?M7PhhiI0r9bX7EpmB5hRz+IeXUESQN88U/SxLIcd9Tq5PxeMtqUX518RtyCt?=
 =?us-ascii?Q?l04asI6KgnIEptixuPs8u0WmF8vJxhRAQbJqw9jeJPeMWgJd1DfT3DBWXE+i?=
 =?us-ascii?Q?DGjYkYxNuriLmwAaiBehiLo5ouq9Vl5RC1rorTV4M6cd0DqhLaPzfPyMZu/l?=
 =?us-ascii?Q?F5r+N9WxxodJP3Nc3lxxxUEV7yyKIDvUPcsBdFpZXewwFkHvPrqJ2rLbk7XL?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0197505-3e0c-4638-8d11-08dc472eabb0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:34:55.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FFYppLm/aY5UbYqhycJiFYVImvMHChZzofnNmQJMkgQRtgNXyBA3gMnrFfU9nuQlMCda4WitDJU4+fmfba2nAyOiLwU2FZAl0GBA1iRn1+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5580
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Mar 2024 09:35:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15337



On 3/18/24 5:59 AM, Adithya Balakumar via lists.cip-project.org wrote:
>=20
>=20
> -----Original Message-----
> From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
> Sent: Friday, March 15, 2024 2:12 PM
> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithya=
.Balakumar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; felix.moessbau=
er@siemens.com; jan.kiszka@siemens.com
> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Po=
rting) <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0) <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=
=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting) <dinesh.kumar@toshiba-=
tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=
=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=
=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.c=
o.jp>
> Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Gene=
rate swu for delta updates
>=20
>=20
>=20
> On 3/15/24 7:45 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Quirin Gylstorff via lists.cip-project.org
>> Sent: Thursday, March 14, 2024 2:57 PM
>> To: balakumar adithya(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TEUR) <Adithy=
a.Balakumar@toshiba-tsip.com>;
>> cip-dev@lists.cip-project.org; felix.moessbauer@siemens.com;
>> jan.kiszka@siemens.com
>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG P=
orting)
>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)
>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG Porting)
>> <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=
=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5
>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=B3=
=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>> Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass:
>> Generate swu for delta updates
>>
>>
>>
>> On 3/14/24 8:41 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
>>> -----Original Message-----
>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>> On Behalf Of Quirin Gylstorff via lists.cip-project.org
>>> Sent: Wednesday, March 13, 2024 10:46 PM
>>> To: cip-dev@lists.cip-project.org; felix.moessbauer@siemens.com;
>>> jan.kiszka@siemens.com
>>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG =
Porting)
>>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)
>>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=
=A9=EF=BC=B0 TMIEC ODG
>>> Porting) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =
=E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5
>>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=
=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>>> Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass:
>>> Generate swu for delta updates
>>>
>>>
>>>
>>> On 3/13/24 8:03 AM, Adithya Balakumar via lists.cip-project.org wrote:
>>>> -----Original Message-----
>>>> From: MOESSBAUER, Felix <felix.moessbauer@siemens.com>
>>>> Sent: Friday, March 8, 2024 4:27 PM
>>>> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=
=B3=EF=BC=A9=EF=BC=B0 TEUR)
>>>> <Adithya.Balakumar@toshiba-tsip.com>; Kiszka, Jan
>>>> <jan.kiszka@siemens.com>
>>>> Cc: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG=
 Porting)
>>>> <Shivanand.Kunijadar@toshiba-tsip.com>; ashrith sai(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0)
>>>> <Sai.Sathujoda@toshiba-tsip.com>; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=
=BC=A9=EF=BC=B0 TMIEC ODG
>>>> Porting) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=E6=9E=97 =
=E5=92=8C=E5=AE=8F =EF=BC=A4=EF=BC=AD=EF=BC=A5
>>>> =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=BC=B0=EF=BC=
=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94) <kazuhiro3.hayashi@toshiba.co.jp>
>>>> Subject: Re: [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate
>>>> swu for delta updates
>>>>
>>>> On Thu, 2024-03-07 at 13:16 +0530, Adithya Balakumar wrote:
>>>>> This allows the creation of a swu file for delta update. The swu
>>>>> file for delta update is only created when delta-update.yml file is
>>>>> included at build time.
>>>>>
>>>>> Signed-off-by: Adithya Balakumar
>>>>> <Adithya.Balakumar@toshiba-tsip.com>
>>>>> ---
>>>>>     =C2=A0classes/swupdate.bbclass | 35 +++++++++++++++++++++++++++++=
++++--
>>>>>     =C2=A01 file changed, 33 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>>>> index
>>>>> 2c69892..2964024 100644
>>>>> --- a/classes/swupdate.bbclass
>>>>> +++ b/classes/swupdate.bbclass
>>>>> @@ -26,10 +26,13 @@ SWU_EBG_UPDATE ?=3D ""
>>>>>     =C2=A0SWU_EFI_BOOT_DEVICE ?=3D "/dev/disk/by-uuid/4321-DCBA"
>>>>>     =C2=A0SWU_BOOTLOADER ??=3D "ebg"
>>>>>     =C2=A0SWU_DESCRIPITION_FILE_BOOTLOADER ??=3D "${SWU_DESCRIPTION_F=
ILE}-
>>>>> ${SWU_BOOTLOADER}"
>>>>> +SWU_DESCRIPITION_FILE_DELTA_UPDATE ??=3D
>>>>
>>>> Hi, do we really need a dedicated file / variable for that?
>>>>
>>>> [Adithya Balakumar]
>>>> Hi Felix,
>>>>
>>>> The sw-description file for a delta update is slightly different in
>>>> terms of the image artifact inlcuded in the swu file and some addition=
al delta update specific properties included in the sw-description file. He=
nce I chose to create a seperate sw-description file for delta update.
>>>>
>>>> Would like to understand if there is a better approach.
>>>
>>> A seperate sw-description file is not ideal, we should take the same ab=
roach as with scripts and other optional or malible fields by writing the c=
ontent to variable and use the template mechanism of ISAR. The sw-descripti=
on can look like this:
>>>
>>> ```
>>>          images: ({
>>> -            filename =3D "${SWU_ROOTFS_PARTITION_NAME}";
>>> +            filename =3D "${SWU_IMAGE_ARTIFACT}";
>>>                  device =3D
>>> "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOT=
FS_PART_UUID_B}";
>>>                  type =3D "roundrobin";
>>>                  ${SWU_COMPRESSION_NODE}
>>> -            properties: {
>>> -                        subtype =3D "image";
>>> -                        configfilecheck =3D
>>> "/etc/os-release@not_match@IMAGE_UUID=3D${TARGET_IMAGE_UUID}";
>>> -            };
>>> +            ${SWU_IMAGE_PROPERTIES}
>>>                  sha256 =3D "${SWU_ROOTFS_PARTITION_NAME}-sha256";
>>>          });
>>> ```
>>>
>>> an alternative would be generate the whole swu with the Variable[flag] =
syntax, e.g.
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/feat/gen
>>> e
>>> rate-sw-description/classes/sw-description-generator.bbclass?ref_type
>>> =3D
>>> heads
>>>
>>> Quirin
>>>
>>> [Adithya Balakumar]
>>> Hi Quirin,
>>>
>>> Thanks for the quick response. I understand the approach you are sugges=
ting. But in a case where I have to create a swu file for both regular and =
a delta update, I would need two different sw-description files right. Each=
 with different filename in the images section and some additional properti=
es for delta update in the properties section.
>>
>> What would be the use case to have both a regular and a delta update?
>>
>> If you have multiple swus the server has the additional responsibility t=
o select the correct swu.
>>
>> In the first version of the delta update I would use the either delta up=
date or full update.
>>
>> Quirin
>>
>> [Adithya Balakumar]
>> Hi Quirin,
>>
>> I understand your opinion. But my thought was to have delta update swu a=
s an optional / additional artifact apart from the complete update swu. Del=
ta update artifact (atleast for rdiff) needs a reference artifact without w=
hich a delta artifact cannot be created. So in a case where a reference art=
ifact is not provided, a delta artifact will not be created. But we could s=
till create a complete update swu anyway.
>=20
> Ok I see, then we should use a seperate sw-description file, similar to t=
he bootloader update case. , with the necessary VARIABLES and still make th=
e properties of the orginial sw-description modifiable. Also the functions =
and setting of variables should then be provided by your delta-update.bbcla=
ss like the efibootguard class.
>=20
> Quirin
>=20
> [Adithya Balakumar]
> Hi Quirin,
>=20
> When you say a separate sw-description file, do you mean a separate .tmpl=
 file for delta update (ex: sw-description-delta.tmpl) ?

Yes.

Quirin

>=20
> There would only be a few changes in the sw-description for the delta upd=
ate case when compared to the complete update case.
>=20
> Hence in the first patch, I created a separate sw-description file (copie=
d the existing sw-description.tmpl as sw-description-delta.tmpl) for delta =
update in the recipe itself and only modified/added certain variables in th=
e new .tmpl file with the sed command and let the ISAR template system crea=
te the final sw-description file.



>=20
> Regards,
> Adithya
>=20
>>
>> I am trying to address concerns on usability as in a user not having to =
meddle with a yml to enable a delta update atleast for a initial test. One =
suggestion was to have a default case without editing any yml files. If we =
were to build a swupdate image AND provide the artifact of a previous versi=
on at some defined spot, the second build should generate the delta image a=
utomatically along with full update swus.
>>
>> Would like your take on this.
>>
>> Thanks and Regards,
>> Adithya
>>
>>>
>>> As per my understanding of the template mechanism of ISAR, the do_trans=
form_template task generates an output file for every .tmpl file provided i=
n the IMAGE_TEMPLATE_FILES variable.
>>>
>>> Please correct me if my understanding is wrong.
>>>
>>> Regards,
>>> Adithya
>>>
>>>
>>>>
>>>>> "${SWU_DESCRIPTION_FILE}-delta"
>>>>> +SWU_DELTA_UPDATE_ARTIFACT =3D
>>>>> "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
>>>>> +SWU_DELTA_UPDATE_ARTIFACT_TYPE =3D
>>>>> "delta_update${@get_swu_compression_type(d)}"
>>>>>     =20
>>>>>     =C2=A0SWU_IMAGE_FILE ?=3D "${IMAGE_FULLNAME}"
>>>>>     =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>>>>> -SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
>>>>> +SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}
>>>>> ${SWU_DELTA_UPDATE_ARTIFACT}"
>>>>
>>>> Does this mean the delta artifact is always added here?
>>>> [Adithya Balakumar]  Apologies, I should have appended ${SWU_DELTA_UPD=
ATE_ARTIFACT} conditionally if delta update is enabled.
>>>>
>>>>>     =C2=A0SWU_SIGNED ??=3D ""
>>>>>     =C2=A0SWU_SIGNATURE_EXT ?=3D "sig"
>>>>>     =C2=A0SWU_SIGNATURE_TYPE ?=3D "cms"
>>>>> @@ -37,6 +40,7 @@ SWU_SIGNATURE_TYPE ?=3D "cms"
>>>>>     =C2=A0SWU_BUILDCHROOT_IMAGE_FILE ?=3D
>>>>> "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>>>>     =20
>>>>>     =C2=A0IMAGE_TYPEDEP:swu =3D
>>>>> "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>>>>> +IMAGE_TYPEDEP:swu +=3D "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if
>>>>> d.getVar('DELTA_UPDATE_TYPE') else ''}"
>>>>>     =C2=A0IMAGER_BUILD_DEPS:swu +=3D "${@'swupdate-certificates-key' =
if
>>>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>>>     =C2=A0IMAGER_INSTALL:swu +=3D "cpio ${@'openssl swupdate-certific=
ates-key'
>>>>> if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>>>     =C2=A0IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>>>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>>> @@ -46,6 +50,7 @@ IMAGE_SRC_URI:swu =3D
>>>>> "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>>>>     =C2=A0IMAGE_SRC_URI:swu +=3D
>>>>> "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>>>>>     =C2=A0IMAGE_TEMPLATE_FILES:swu =3D "${SWU_DESCRIPTION_FILE}.tmpl"
>>>>>     =C2=A0IMAGE_TEMPLATE_FILES:swu +=3D
>>>>> "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>>>>> +IMAGE_TEMPLATE_FILES:delta_update +=3D
>>>>> "${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>>>>>     =C2=A0IMAGE_TEMPLATE_VARS:swu =3D " \
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 SWU_ROOTFS_PARTITION_NAME \
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 TARGET_IMAGE_UUID \
>>>>> @@ -58,6 +63,8 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 SWU_FILE_NODES \
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 SWU_BOOTLOADER_FILE_NODE \
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 SWU_SCRIPTS_NODE \
>>>>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ARTIFACT \
>>>>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES \
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 "
>>>>>     =20
>>>>>     =C2=A0# TARGET_IMAGE_UUID needs to be generated before completing=
 the
>>>>> template @@ -136,6 +143,22 @@ python add_scripts(){
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_SCRIPTS_NODE', swu_scri=
pts_node)
>>>>>     =C2=A0}
>>>>>     =20
>>>>> +SWU_EXTEND_SW_DESCRIPTION +=3D "add_swu_delta_update_properties"
>>>>> +python add_swu_delta_update_properties() {
>>>>> +=C2=A0=C2=A0=C2=A0 delta_type =3D d.getVar('DELTA_UPDATE_TYPE')
>>>>> +=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =3D ""
>>>>> +=C2=A0=C2=A0=C2=A0 if delta_type =3D=3D "rdiff":
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properti=
es =3D=C2=A0 'chainhandler =3D
>>>>> "rdiff_image";'
>>>>> +=C2=A0=C2=A0=C2=A0 elif delta_type =3D=3D "zchunk":
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zck_url =3D d.getVar('DEL=
TA_ZCK_URL')
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_properti=
es =3D f"""
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ch=
ainhandler =3D "delta";
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ur=
l =3D "{zck_url}";
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zc=
kloglevel =3D "error";
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>>> +=C2=A0=C2=A0=C2=A0 d.setVar('SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES'=
,
>>>>> swu_delta_update_properties)
>>>>> +}
>>>>> +
>>>>>     =C2=A0# convert between swupdate compressor name and imagetype ex=
tension
>>>>>     =C2=A0def get_swu_compression_type(d):
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 swu_ct =3D d.getVar('SWU_COMPRESSION_TYP=
E') @@ -154,13
>>>>> +177,21 @@ FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-
>>>>> core}/recipes-core/images/swu"
>>>>>     =20
>>>>>     =C2=A0do_image_swu[depends] +=3D "${PN}:do_transform_template"
>>>>>     =C2=A0do_image_swu[stamp-extra-info] =3D "${DISTRO}-${MACHINE}"
>>>>> -do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>>>>> ${SWU_BOOTLOADER}"
>>>>> +do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>>>>> ${SWU_BOOTLOADER} ${WORKDIR}/swu-delta"
>>>>>     =C2=A0IMAGE_CMD:swu() {
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_F=
ILE}'*.swu
>>>>> +=C2=A0=C2=A0=C2=A0 if [ -z "${DELTA_UPDATE_TYPE}" ]; then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -rf ${WORKDIR}/swu-del=
ta
>>>>
>>>> Why is this required if we already clear the ${WORKDIR}/swu-delta in c=
leandirs?
>>>>
>>>> Felix
>>>>
>>>> [Adithya Balakumar] Apologies. I should add swu-delta to do_image_swu[=
cleandirs] only if a delta update is enabled.
>>>> But even with the above change, in a case where we build with delta up=
date enabled and without cleaning the build directory if we build again wit=
hout enabling delta update, the swu-delta directory is retained in the WORK=
DIR.
>>>>
>>>> Thanks and Regards,
>>>> Adithya
>>>>
>>>>>
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>>> +
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}'
>>>>> '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_F=
ILE_BOOTLOADER}' ];
>>>>> then
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/$=
{SWU_DESCRIPITION_FILE_BOOTLOADER}'
>>>>> '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>>> +=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA=
_UPDATE}' ];
>>>>> then
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESC=
RIPITION_FILE_DELTA_UPDATE}'
>>>>> '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
>>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>>> +
>>>>>     =20
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0 for swu_file in "${WORKDIR}"/swu*; do
>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_file_base=3D=
$(basename $swu_file)
>>>>
>>>> --
>>>>> Siemens AG, Technology
>>>>> Linux Expert Center
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>> Links: You receive all messages sent to this group.
>>>> View/Reply Online (#15334): https://lists.cip-project.org/g/cip-dev/me=
ssage/15334
>>>> Mute This Topic: https://lists.cip-project.org/mt/104783341/1753640
>>>> Group Owner: cip-dev+owner@lists.cip-project.org
>>>> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/175=
3640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
>>>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>>>

