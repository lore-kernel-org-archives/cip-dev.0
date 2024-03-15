Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6265EC54E66
	for <webhook@archiver.kernel.org>; Fri, 15 Mar 2024 08:42:19 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.49])
 by mx.groups.io with SMTP id smtpd.web10.16704.1710492136396050112
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Mar 2024 01:42:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BKOL8vF+;
 spf=pass (domain: siemens.com, ip: 40.107.249.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFGoDBz5096rdTISsRpJsoa0wKWlXzK+iP0LAOcycKrnNRKxCWy5Te7FO2udm2lW7NFaJOgDX2Nbm8ZiBukk52kdsv9Cr6n4UsHZJ89C1asrxYi4apjuCONgADOGpMuRfN6PPP5CPcrhGHJiLkW0IIBNqGCnHow3Rh8tL+3r1BpzMP5eW0svk1Tjq/egxMHSPAhgispKGK/jMgUZ/1tnhaHFtM2jt2x+Jm0qfjxkXGbMiQE8ph55dBh2xCUY1XPIz/tNirkB1W/Fi8RSM8Fo7jqOvsXi908PNnX3JdGAM5BeoNJWd+23/mepUyAgKVyUGPWDsjhAxLHt2EOzpJyoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhInzEE4Tg+qZaJNlP1Tm59SvuOBKxf9GzuVC1XPKBI=;
 b=RJju6fK9te4snbX2vKd5y9Q6kWOZsjj/5kCBncLT9CJYD/coBQ4wg3f/n76VW1D52busv4xnrBa4zUqZDJHqy+rEma8LwpHgLHkVKu7x+WEVjCD4J7rxGApB/AA5vkZ9Dgd3mFIxLT0qwJII7NbkA+3tKXZvb2i+a/XFVMg1nXLSg/SmaIcpv7iWkauGgiNMGqQ+NM3XUg3S7PDAZuaZcm1+cINK0AN0+FhWqkdhtVuBS69gMoDoId78ghbW+KzZs62peEyCLy/dRxpqHar/UarYE5c7ePTwC9MOxZbIabyW3fLfV5PvIlXj4BAanpldgMEAjOY8VvDguuYEwR1KOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhInzEE4Tg+qZaJNlP1Tm59SvuOBKxf9GzuVC1XPKBI=;
 b=BKOL8vF+/C2ygk+CfVl9AwysPbL+hsUbByIZLoxjpv8oFp2Z2dy4MNfTN4NZqTMZb6lc0T0jS1lOfbK7QUWcCZ0kfC4YmAiih8JNpZvwxXEmEZLnn7hCLVuI+I63/UvHT8RHVkMjyBtG4qwIz7nEPMBxg0NRErfmCKt/j/vFhOtF8sv9JKf0ZiCQ4Bja7z+7ESDIXR0ZOhN2O1AMdahOfngZE9CCKI5s5qupGATSyJJDDNUc1YDlQ7tfIQumRyzRv2vXqa08PgpIHRv+1ERRM6+1w0SV2iI/P9C/Rps84GK46YbI6E/qtBgC5/lDIeW5E2rOPlKjQWOF7vbfp0xQ7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6557.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:406::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 15 Mar
 2024 08:42:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7386.021; Fri, 15 Mar 2024
 08:42:12 +0000
Message-ID: <415b8ba9-8609-4841-b28e-58bed3b7bd26@siemens.com>
Date: Fri, 15 Mar 2024 09:42:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate
 swu for delta updates
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com, jan.kiszka@siemens.com
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
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <TYCPR01MB96698E8364CFA2ECBF922185C4282@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0203.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: 20306dd7-eb49-42f6-9037-08dc44cbcf03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e+k5s/7nXi5agli//eIcawOzYgzt+Kln92AjUtgYptd4xI9IlGVNekS+35G1YequautVVA9CgP6/umEChvPERMPBDM/n4q9HigTMZ7JyS5oPnnd4VWiAZDnJHiL04mQSeVMg+pABGO2JPxGvi7/BKRGoyd1+uq8xjaeqOD+bQdFtbNpoi6ruxcIFtsK0iRqkZlMmLejE8howu6C2GADg9j8/LrilIdCWQCrxTHOt+uV44HFsP5An43rjkLWME+1s6yelKJgRvtNM2aU4UjQ3nwpWyMijhJmzCaKBCxU/t8zUwOG1xDZR4lDQSNSF40QrBlQymI5O/g5vQ7gu84n2Idh5pjGlIjh1FeUlNLeVjhcDFL87GgUBsJcwFLIFYt32gmdJIJCy9Z62rmTGQeHDeORXia5ZTHEx1ujI292jXyjbaNKq1tOjpfa81e25ciUFB13U5HfhBCr3YcCwoM4n2Trq9585Z3PtWzVhhM3t7jG5wed72Ug2mquNGMs7i6WLcPUq6CiilJ9jcO340uB+BHTduL00gvoGEayZZkn3GxUpitGNPtcA1QZ1E0Tu13AWtjeMgvu4m0cNgivh2BjGjLh50NI54JIHVPdwK07EIkU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?m+ExBDa/RguCPhiIHUfBtch/wo+DengQBj/X/kr3t+a7MAv5CripIUf+wIKi?=
 =?us-ascii?Q?XQPNFMROhXzvvo4QWeB8Nl9K1JgSPtdvJ3Q3evgjnhQcTwSqTZhih4Jd693o?=
 =?us-ascii?Q?KO0BEwoN0NEiMkvvMOJHGg+04quyfe98H4ZhQ8DBj8hlVzNYvUthKryC/vxl?=
 =?us-ascii?Q?B4kBhzCSzmr26VFRKFmtvJolV/hS+dMsWh5AB5xrj4U6646ivqOJtorVGQEP?=
 =?us-ascii?Q?FEzMmfmZhf8h0Lp5TyHiyzErF8m0NoXboaS5xl2qLwpGT9pTfClnSFMSnKM3?=
 =?us-ascii?Q?J7WB3LsC3d1J4lBUbrBwXWXWE3VjzZwPaTqtvMdLhvYFLAAFZ0zcyT6iDfHP?=
 =?us-ascii?Q?kRQGdlIwOcqLXR3wwBFwnAzV6ex/M9kc88GUb/McpNrvPtypeqPf6jUIeIQz?=
 =?us-ascii?Q?P0WXlgahwbqWcDfQGAChvg2sLqHqu8Jf4rgd6NGEmUbCkOMxjHUjzowbnQpr?=
 =?us-ascii?Q?K66AbhIBFB6l+sqUyeooRl57fEbf79LXRSwPRABa2RAsOl7Hm5chFPuU5tYU?=
 =?us-ascii?Q?WQ2zAFWAP1FdGQCwp5IZ9C0dv0+2Y5IegCWVG5DgEvQfndf5KVmxMQbbXJ9s?=
 =?us-ascii?Q?kHuOH2LPKt27Oib285vZHJK8PG0I+Fnk629NVBd0PI//ygrAzfwvJsaDzBjI?=
 =?us-ascii?Q?fM8zxkKUJtZE/aphjtJQ+u9GUKanEcZ0uBURPeq7vdQNo6WxLCzOEf8fEuYR?=
 =?us-ascii?Q?N+3nqOA+hftnKxGywH+2aKunPo4Z9WnsVsAKhvTcYYFFanr95jY4SL6HhuU6?=
 =?us-ascii?Q?rYjiFREVnZUwp3Y6Kw0zi70IeETmTvb8Qn24BQiE/b/vDHzB3+A7giB9unyO?=
 =?us-ascii?Q?RfkggtK+FS9iirGqhVd339HC1es/zlmWXMrjBGQU8e5xkMM4M4jSfluwf8N8?=
 =?us-ascii?Q?Om29KgFUlu+nBtVz6WVSbOkwrglt+sXVbjYaZnTwO1SdYU9knzhERdh83Dv+?=
 =?us-ascii?Q?bwIQ1doipij1LlO3xGjT21fAhXuCs7OY2b7MZdbh912/nMOR3Ftv+qHD8b0d?=
 =?us-ascii?Q?fCP1n3g6OKcdOcQKFiRuvAtEVkaMmw7p89RPZhNXZRtMWZT22ENexvZE/eCz?=
 =?us-ascii?Q?ruVPMLos+qZiO31pZjbFr+ODufU7oU3zAjrqoFUMlq2zdaZV3j3Ry/yDF34q?=
 =?us-ascii?Q?KbYcOJHpil3lcDEc2ErePjrcSKVRjVaUkVZW9JsNRiIBXandy6rBohFP1EbF?=
 =?us-ascii?Q?qSeMmj3FQS9HnssWtblGFzdaXViMJ4n6TlcdSZs1Io6kt1DkqKL3rgD2TOR5?=
 =?us-ascii?Q?KblUtEydsJscuA6kyg7JP6wIW8YLcDbMGT96yXzLLRn/uRyAEDx0JuLcbesl?=
 =?us-ascii?Q?JklTMXawRsU6925sO2kh9S1qZrCIvh7RBdnVq9+L4XYvWQYCbd23eelpViCy?=
 =?us-ascii?Q?DlYZt928fCmtR2i+eaodNlN55+vIqsxN7GMFl0gfDudPxU3q9h/3n6zZMIhg?=
 =?us-ascii?Q?GVmTvKS3ojP+vw0ZJ8RuefQB7GVfZRUcb297tzVyGKW+BZjUPj1JRN6n6a/y?=
 =?us-ascii?Q?6Z45NJyKBRudQxjCgDwBn8lY5MuBlaKknIOWnZbY3oCkSiWifQE0Jzeg2K4A?=
 =?us-ascii?Q?lJWkYGhtal+5SYLG5Q8ycvIYKahFNY28ecX18W155XGr5xWB/myWihlQPS6H?=
 =?us-ascii?Q?PQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20306dd7-eb49-42f6-9037-08dc44cbcf03
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 08:42:12.3127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Otoo3qoLCn8fgDKbi7vSp8gOK+UwcP+HLOyJYQfLuyGadCVO2rIh1lWxVFRh1PgUXZEgoBcvMHlhE0p/bKBYU7ttuSB+I8hxlGFif+CEgAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6557
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Mar 2024 08:42:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15323



On 3/15/24 7:45 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Quirin Gylstorff via lists.cip-project.org
> Sent: Thursday, March 14, 2024 2:57 PM
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
> On 3/14/24 8:41 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Quirin Gylstorff via lists.cip-project.org
>> Sent: Wednesday, March 13, 2024 10:46 PM
>> To: cip-dev@lists.cip-project.org; felix.moessbauer@siemens.com;
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
>> On 3/13/24 8:03 AM, Adithya Balakumar via lists.cip-project.org wrote:
>>> -----Original Message-----
>>> From: MOESSBAUER, Felix <felix.moessbauer@siemens.com>
>>> Sent: Friday, March 8, 2024 4:27 PM
>>> To: cip-dev@lists.cip-project.org; balakumar adithya(=EF=BC=B4=EF=BC=B3=
=EF=BC=A9=EF=BC=B0 TEUR)
>>> <Adithya.Balakumar@toshiba-tsip.com>; Kiszka, Jan
>>> <jan.kiszka@siemens.com>
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
>>> Subject: Re: [isar-cip-core][RFC v1 5/6] swupdate.bbclass: Generate
>>> swu for delta updates
>>>
>>> On Thu, 2024-03-07 at 13:16 +0530, Adithya Balakumar wrote:
>>>> This allows the creation of a swu file for delta update. The swu
>>>> file for delta update is only created when delta-update.yml file is
>>>> included at build time.
>>>>
>>>> Signed-off-by: Adithya Balakumar
>>>> <Adithya.Balakumar@toshiba-tsip.com>
>>>> ---
>>>>    =C2=A0classes/swupdate.bbclass | 35 +++++++++++++++++++++++++++++++=
++--
>>>>    =C2=A01 file changed, 33 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>>> index
>>>> 2c69892..2964024 100644
>>>> --- a/classes/swupdate.bbclass
>>>> +++ b/classes/swupdate.bbclass
>>>> @@ -26,10 +26,13 @@ SWU_EBG_UPDATE ?=3D ""
>>>>    =C2=A0SWU_EFI_BOOT_DEVICE ?=3D "/dev/disk/by-uuid/4321-DCBA"
>>>>    =C2=A0SWU_BOOTLOADER ??=3D "ebg"
>>>>    =C2=A0SWU_DESCRIPITION_FILE_BOOTLOADER ??=3D "${SWU_DESCRIPTION_FIL=
E}-
>>>> ${SWU_BOOTLOADER}"
>>>> +SWU_DESCRIPITION_FILE_DELTA_UPDATE ??=3D
>>>
>>> Hi, do we really need a dedicated file / variable for that?
>>>
>>> [Adithya Balakumar]
>>> Hi Felix,
>>>
>>> The sw-description file for a delta update is slightly different in
>>> terms of the image artifact inlcuded in the swu file and some additiona=
l delta update specific properties included in the sw-description file. Hen=
ce I chose to create a seperate sw-description file for delta update.
>>>
>>> Would like to understand if there is a better approach.
>>
>> A seperate sw-description file is not ideal, we should take the same abr=
oach as with scripts and other optional or malible fields by writing the co=
ntent to variable and use the template mechanism of ISAR. The sw-descriptio=
n can look like this:
>>
>> ```
>>         images: ({
>> -            filename =3D "${SWU_ROOTFS_PARTITION_NAME}";
>> +            filename =3D "${SWU_IMAGE_ARTIFACT}";
>>                 device =3D
>> "C:BOOT0:linux.efi->${ABROOTFS_PART_UUID_A},C:BOOT1:linux.efi->${ABROOTF=
S_PART_UUID_B}";
>>                 type =3D "roundrobin";
>>                 ${SWU_COMPRESSION_NODE}
>> -            properties: {
>> -                        subtype =3D "image";
>> -                        configfilecheck =3D
>> "/etc/os-release@not_match@IMAGE_UUID=3D${TARGET_IMAGE_UUID}";
>> -            };
>> +            ${SWU_IMAGE_PROPERTIES}
>>                 sha256 =3D "${SWU_ROOTFS_PARTITION_NAME}-sha256";
>>         });
>> ```
>>
>> an alternative would be generate the whole swu with the Variable[flag] s=
yntax, e.g.
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/feat/gene
>> rate-sw-description/classes/sw-description-generator.bbclass?ref_type=3D
>> heads
>>
>> Quirin
>>
>> [Adithya Balakumar]
>> Hi Quirin,
>>
>> Thanks for the quick response. I understand the approach you are suggest=
ing. But in a case where I have to create a swu file for both regular and a=
 delta update, I would need two different sw-description files right. Each =
with different filename in the images section and some additional propertie=
s for delta update in the properties section.
>=20
> What would be the use case to have both a regular and a delta update?
>=20
> If you have multiple swus the server has the additional responsibility to=
 select the correct swu.
>=20
> In the first version of the delta update I would use the either delta upd=
ate or full update.
>=20
> Quirin
>=20
> [Adithya Balakumar]
> Hi Quirin,
>=20
> I understand your opinion. But my thought was to have delta update swu as=
 an optional / additional artifact apart from the complete update swu. Delt=
a update artifact (atleast for rdiff) needs a reference artifact without wh=
ich a delta artifact cannot be created. So in a case where a reference arti=
fact is not provided, a delta artifact will not be created. But we could st=
ill create a complete update swu anyway.

Ok I see, then we should use a seperate sw-description file, similar to=20
the bootloader update case. , with the necessary VARIABLES and still=20
make the properties of the orginial sw-description modifiable. Also the=20
functions and setting of variables
should then be provided by your delta-update.bbclass like the=20
efibootguard class.

Quirin

>=20
> I am trying to address concerns on usability as in a user not having to m=
eddle with a yml to enable a delta update atleast for a initial test. One s=
uggestion was to have a default case without editing any yml files. If we w=
ere to build a swupdate image AND provide the artifact of a previous versio=
n at some defined spot, the second build should generate the delta image au=
tomatically along with full update swus.
>=20
> Would like your take on this.
>=20
> Thanks and Regards,
> Adithya
>=20
>>
>> As per my understanding of the template mechanism of ISAR, the do_transf=
orm_template task generates an output file for every .tmpl file provided in=
 the IMAGE_TEMPLATE_FILES variable.
>>
>> Please correct me if my understanding is wrong.
>>
>> Regards,
>> Adithya
>>
>>
>>>
>>>> "${SWU_DESCRIPTION_FILE}-delta"
>>>> +SWU_DELTA_UPDATE_ARTIFACT =3D
>>>> "${SWU_ROOTFS_NAME}.delta_update${@get_swu_compression_type(d)}"
>>>> +SWU_DELTA_UPDATE_ARTIFACT_TYPE =3D
>>>> "delta_update${@get_swu_compression_type(d)}"
>>>>    =20
>>>>    =C2=A0SWU_IMAGE_FILE ?=3D "${IMAGE_FULLNAME}"
>>>>    =C2=A0SWU_DESCRIPTION_FILE ?=3D "sw-description"
>>>> -SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}"
>>>> +SWU_ADDITIONAL_FILES ?=3D "linux.efi ${SWU_ROOTFS_PARTITION_NAME}
>>>> ${SWU_DELTA_UPDATE_ARTIFACT}"
>>>
>>> Does this mean the delta artifact is always added here?
>>> [Adithya Balakumar]  Apologies, I should have appended ${SWU_DELTA_UPDA=
TE_ARTIFACT} conditionally if delta update is enabled.
>>>
>>>>    =C2=A0SWU_SIGNED ??=3D ""
>>>>    =C2=A0SWU_SIGNATURE_EXT ?=3D "sig"
>>>>    =C2=A0SWU_SIGNATURE_TYPE ?=3D "cms"
>>>> @@ -37,6 +40,7 @@ SWU_SIGNATURE_TYPE ?=3D "cms"
>>>>    =C2=A0SWU_BUILDCHROOT_IMAGE_FILE ?=3D
>>>> "${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>>>    =20
>>>>    =C2=A0IMAGE_TYPEDEP:swu =3D
>>>> "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>>>> +IMAGE_TYPEDEP:swu +=3D "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' if
>>>> d.getVar('DELTA_UPDATE_TYPE') else ''}"
>>>>    =C2=A0IMAGER_BUILD_DEPS:swu +=3D "${@'swupdate-certificates-key' if
>>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>>    =C2=A0IMAGER_INSTALL:swu +=3D "cpio ${@'openssl swupdate-certificat=
es-key'
>>>> if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>>    =C2=A0IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>> @@ -46,6 +50,7 @@ IMAGE_SRC_URI:swu =3D
>>>> "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>>>    =C2=A0IMAGE_SRC_URI:swu +=3D
>>>> "file://${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>>>>    =C2=A0IMAGE_TEMPLATE_FILES:swu =3D "${SWU_DESCRIPTION_FILE}.tmpl"
>>>>    =C2=A0IMAGE_TEMPLATE_FILES:swu +=3D
>>>> "${SWU_DESCRIPITION_FILE_BOOTLOADER}.tmpl"
>>>> +IMAGE_TEMPLATE_FILES:delta_update +=3D
>>>> "${SWU_DESCRIPITION_FILE_DELTA_UPDATE}.tmpl"
>>>>    =C2=A0IMAGE_TEMPLATE_VARS:swu =3D " \
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 SWU_ROOTFS_PARTITION_NAME \
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 TARGET_IMAGE_UUID \
>>>> @@ -58,6 +63,8 @@ IMAGE_TEMPLATE_VARS:swu =3D " \
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 SWU_FILE_NODES \
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 SWU_BOOTLOADER_FILE_NODE \
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 SWU_SCRIPTS_NODE \
>>>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ARTIFACT \
>>>> +=C2=A0=C2=A0=C2=A0 SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES \
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 "
>>>>    =20
>>>>    =C2=A0# TARGET_IMAGE_UUID needs to be generated before completing t=
he
>>>> template @@ -136,6 +143,22 @@ python add_scripts(){
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 d.appendVar('SWU_SCRIPTS_NODE', swu_script=
s_node)
>>>>    =C2=A0}
>>>>    =20
>>>> +SWU_EXTEND_SW_DESCRIPTION +=3D "add_swu_delta_update_properties"
>>>> +python add_swu_delta_update_properties() {
>>>> +=C2=A0=C2=A0=C2=A0 delta_type =3D d.getVar('DELTA_UPDATE_TYPE')
>>>> +=C2=A0=C2=A0=C2=A0 swu_delta_update_properties =3D ""
>>>> +=C2=A0=C2=A0=C2=A0 if delta_type =3D=3D "rdiff":
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_propertie=
s =3D=C2=A0 'chainhandler =3D
>>>> "rdiff_image";'
>>>> +=C2=A0=C2=A0=C2=A0 elif delta_type =3D=3D "zchunk":
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zck_url =3D d.getVar('DELT=
A_ZCK_URL')
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_delta_update_propertie=
s =3D f"""
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 chain=
handler =3D "delta";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 url =
=3D "{zck_url}";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 zcklo=
glevel =3D "error";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 """
>>>> +=C2=A0=C2=A0=C2=A0 d.setVar('SWU_DELTA_UPDATE_ADDITIONAL_PROPERTIES',
>>>> swu_delta_update_properties)
>>>> +}
>>>> +
>>>>    =C2=A0# convert between swupdate compressor name and imagetype exte=
nsion
>>>>    =C2=A0def get_swu_compression_type(d):
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 swu_ct =3D d.getVar('SWU_COMPRESSION_TYPE'=
) @@ -154,13 +177,21
>>>> @@ FILESEXTRAPATHS:append =3D ":${LAYERDIR_cip-
>>>> core}/recipes-core/images/swu"
>>>>    =20
>>>>    =C2=A0do_image_swu[depends] +=3D "${PN}:do_transform_template"
>>>>    =C2=A0do_image_swu[stamp-extra-info] =3D "${DISTRO}-${MACHINE}"
>>>> -do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>>>> ${SWU_BOOTLOADER}"
>>>> +do_image_swu[cleandirs] +=3D "${WORKDIR}/swu ${WORKDIR}/swu-
>>>> ${SWU_BOOTLOADER} ${WORKDIR}/swu-delta"
>>>>    =C2=A0IMAGE_CMD:swu() {
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 rm -f '${DEPLOY_DIR_IMAGE}/${SWU_IMAGE_FIL=
E}'*.swu
>>>> +=C2=A0=C2=A0=C2=A0 if [ -z "${DELTA_UPDATE_TYPE}" ]; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rm -rf ${WORKDIR}/swu-delt=
a
>>>
>>> Why is this required if we already clear the ${WORKDIR}/swu-delta in cl=
eandirs?
>>>
>>> Felix
>>>
>>> [Adithya Balakumar] Apologies. I should add swu-delta to do_image_swu[c=
leandirs] only if a delta update is enabled.
>>> But even with the above change, in a case where we build with delta upd=
ate enabled and without cleaning the build directory if we build again with=
out enabling delta update, the swu-delta directory is retained in the WORKD=
IR.
>>>
>>> Thanks and Regards,
>>> Adithya
>>>
>>>>
>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>> +
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}'
>>>> '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FIL=
E_BOOTLOADER}' ];
>>>> then
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${S=
WU_DESCRIPITION_FILE_BOOTLOADER}'
>>>> '${WORKDIR}/swu-${SWU_BOOTLOADER}/${SWU_DESCRIPTION_FILE}'
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 fi
>>>> +=C2=A0=C2=A0=C2=A0 if [ -f '${WORKDIR}/${SWU_DESCRIPITION_FILE_DELTA_=
UPDATE}' ];
>>>> then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cp '${WORKDIR}/${SWU_DESCR=
IPITION_FILE_DELTA_UPDATE}'
>>>> '${WORKDIR}/swu-delta/${SWU_DESCRIPTION_FILE}'
>>>> +=C2=A0=C2=A0=C2=A0 fi
>>>> +
>>>>    =20
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0 for swu_file in "${WORKDIR}"/swu*; do
>>>>    =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 swu_file_base=3D$(=
basename $swu_file)
>>>
>>> --
>>>> Siemens AG, Technology
>>>> Linux Expert Center
>>>
>>>
>>>
>>>
>>>
>>>

