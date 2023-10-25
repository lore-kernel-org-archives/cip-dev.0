Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B5CC25B6E
	for <webhook@archiver.kernel.org>; Wed, 25 Oct 2023 08:24:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.42])
 by mx.groups.io with SMTP id smtpd.web10.168848.1698222288489605650
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Oct 2023 01:24:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=O4cYTmuo;
 spf=pass (domain: siemens.com, ip: 40.107.13.42, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJj03idLTsv5kk46fL4SuZB/3yiKFGj7AiQiigHp46D5auhVo7Q5q1MMteB2TMKEXDP/HmWMnfqmTBDPKQjWTaL5Ch/CAsf5lTqNmDSgbrYKX0gXue6VBDjycotoF+w3KzsvyQWd4/ZJt4n0L7voKQXbJEojfPHzu/BKmiI5zYKRdKv1PdgwLzUgZuTzIACLikWwYKokwGkHLavxqYTiVmGgaFKf97yCTExvPzVLDTI5g4lb8zskwZeHK2skiNd+0shfFux2p5bDaxa6oarDyz20CqIy/P122riMnG+s9w7iiaxbQs5TzWf1sFbdnXUTpjS5c/synEPVSpVt6VWXtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fVW+FLFxxdCZGggdfRf4IKcHF7r9HH4oFuI6dRiJ7I=;
 b=Q7IIq66bbl7AHMTW6Nfypsp1UGrk4VPux7o4GFy7Kv/wJMsMPGEB6rWketOsg9UOGCZnnR5XK+ruTHh+r3QE67lEOnFdOs59bx92uSAjOHykXTsKfM2gy2CtM12y1M8i2P+G1MBVOeNrHbzwPTNyI3KqsTepcweCizBIpu+ln6fAsrDonbHb/FcOXlE6dDytDtMbN2Z69kKaCVnAWb0DHq2A7nZi2Un61RfzPqo9MCGDgqcQFTsvcrzTS0t+UtqvZWXofaz65V5BBz3ZrKANA4hhgR0bkOHsjK/0VCkqcyKgtbgvOVwB8kWrsAL+eemm5rTWdeBYrIsWvYSJWBJbFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fVW+FLFxxdCZGggdfRf4IKcHF7r9HH4oFuI6dRiJ7I=;
 b=O4cYTmuonCOOKZHp+fD4Yi5U0Ed3zb2/8zzLO5aX081OePNVR8+wbMVxmuKSUe6CvUOSmwBhtC2hWCSucSvBEecNKLOlVuvQ6T+NuG/TDbJ6ZdD2ngnlSoi4nViemn/j/4csVHoJf7WcVBRQdTXcsl+keTW46lIGxsbLAeRbVOUiAD9sdbygX7mbp9Jza8DE0G45EUW15RXUgOEnA4o7gSc6VJhBSMcBJmu/bmh8PxS3bH6wc6JMyyduYqw0loS2Fxn5uFeLvOclwpKytdtZTudvYwIgZGDC3JXroANJl2ndJyf8z/S3hdhL1g46Lneq18frtLj9DjhXAifsqHH61Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ef::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 08:24:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ce06:5d24:9896:669c%6]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 08:24:44 +0000
Message-ID: <92324ead-e15c-48fd-876c-41398d15a956@siemens.com>
Date: Wed, 25 Oct 2023 10:24:23 +0200
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
 <f598eec3-31ee-4c3a-a961-24363e5f6a11@siemens.com>
 <OS3PR01MB685652135A62356BBEF463B4A4DFA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <OS3PR01MB685652135A62356BBEF463B4A4DFA@OS3PR01MB6856.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8166:EE_
X-MS-Office365-Filtering-Correlation-Id: 347266d6-a079-44e6-9563-08dbd533d7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9BVRRqtDWXQPjcW4YEHaAj2k5hjkP4Sh7iHbst/Y+nwfIi0iuv3tHg3gBM3XWhkovUZS5F/4MVrUL4r2zS9Mca3hkBAsM4rACVOGNqpuioCSXHXUKX42nvQgXXZT3wr47Ge5ZKWCWY121rKZpFOEWjnOoq2+PDRGUhiEBQPuI3uCRAJXUd8LpOO/hAFlYDtVL1N3B41466n9aedMMO4iPM8rcw24CFAX9MICC22VgIPhxv1l0Asn0hasWcSrTPMvltar74SEC7wATJ4tgLFhk7m2Y36+XQAG1vDYpyoFwFc65Lyy73u0cs9jJyOkSVPVBqEFhf0iikjqj2qwgGSa6cOeg0ctAqgvQ87NqWMsLxpSQD0UULvJYntbLzOHVzJBqTRHI3eudZYHk0QFjuPdxcEP8cscmzFy69SFtvOs7IEBqS5TdZItr8UY90hIixkH1PofwGpui7yMpiO5Z23KXDjNUhkZ9EaW4DR+/uyNDiLrvTvrCA6P8PDzQdZxj6HOogadoBWFEkey+GJ4FM5y/LibsnHND1FYaj6mFqS+2b/jxmkT+R8UPXJW03+tze3Fj5t4rBwaoE17/C4apG6a8SfTWEa036hc/h79me99BQreNvi6dV8GZikKY91cEDTDciIIZ0mGnbW8g4+DYq2Gng==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(44832011)(86362001)(38100700002)(41300700001)(66476007)(66556008)(316002)(82960400001)(6666004)(6506007)(478600001)(107886003)(6486002)(6512007)(53546011)(83380400001)(31696002)(5660300002)(36756003)(4326008)(2616005)(8676002)(8936002)(66946007)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ukdZfsnvouLjZSzeMGRhDJq82Ltk3Py7NEnVmBPZ6TUd1pmUcHy/9lZLdI83?=
 =?us-ascii?Q?OaVwvSvID3F/Lb7D1Iegv1O1xn9HMoQTgGKaN1vQHve0QIyHqL5vhy9+Iud3?=
 =?us-ascii?Q?D1viH0nw/0UwYnMcRxxHaCyHzq2+UCdFEngMWSToobpPrr6N2w42u19h0Lgx?=
 =?us-ascii?Q?IH+d8jQygjZgcjZiOfGRQfVN+wzNGk7BpZml4dnbUl63cU3k45Y6oXppCC4D?=
 =?us-ascii?Q?kY9NKGd/k+HfAZOeO4QN+7ikdvuodne1dbXnaBWA5efm3dZLLRAJmG6DCQkX?=
 =?us-ascii?Q?spiLQhp2SigKIrxU1W6l7XwwPD9M5X8gb89DVHY3KLGzv0ItYpbNxDPlRQ0B?=
 =?us-ascii?Q?OKo3Jtw0+qfjdqK6+upzKSy4BdZ54eF2p2bTtURoAQo7eKCkiCgnD798NLTc?=
 =?us-ascii?Q?WoItn5lyrZOK0cbUz50frUHFcbbR8iF0oTN4bszopNj38EiUTXjUyJBOZf+o?=
 =?us-ascii?Q?mEIKYO/gDb4a5DI70FcqUjkIVlRF4uVHLFkATFqcJEXw0bSimOeY17zXWYAE?=
 =?us-ascii?Q?dkaWHwVqppRVcYVztm+cHHjXMLfKtT9hrnSJA+RXVuKOMZDKSo2knZytpfFN?=
 =?us-ascii?Q?jGbU5WtCCz2GcSL8uv7KAxQT6SP8xxyD6ovAcHswCnhJzlcDXmMK4GJzANpU?=
 =?us-ascii?Q?4lJDrPN6IfdmDFSnBm1sA4jPh0nNw8SmM4RmA2yX+aWZDhf24+mPG7tsC5Z7?=
 =?us-ascii?Q?NdcInB6LKxmu1Cq2dIeA7Pafd+/b+Qq1J3kiqPIiBtlUzmNxVeE+YJDcb8K5?=
 =?us-ascii?Q?Z+d0E4Vdiu10CWKxLXLaqVQ+NB+CR17KSl2aOheEqG0SQIUp+S7lVf4GljSc?=
 =?us-ascii?Q?cw9RI50QL3q/1ekubMPbBx+bqBDPi5gtuUmGLl0WH4bZ/hZozYYr6d75/TiB?=
 =?us-ascii?Q?ywLOiQgXWdcF/keVcqF/kiEj9Yog5Cuu0Ke0vIWLBr7+At7CK1g9JIg8S2/K?=
 =?us-ascii?Q?kihiBA6kJe1911OrcTnQSVNPEoq8/H3cRrWaHNyf3i9HvGr6nNTYSdOmsJ+C?=
 =?us-ascii?Q?7wYm3SY+u14iy7sZOaWN1kEmOKVGh4icTH1y2c4OGfYY8SiKro9HTrST9R1y?=
 =?us-ascii?Q?q9PHxUgOjyhZmenOzjVMivuyjQdmMJDQbCu3kbHS4Zl91tZ7dJXMjwYPIeVs?=
 =?us-ascii?Q?CxOBsUcBG8SKHGkoLV1gLOCv5sFxYOo6Uypo2DF/qS1vHpSZ2N1u9jhXGKHg?=
 =?us-ascii?Q?R34MZj/eBTL9ZKJNCnVzn97ZxnfrHKonLk3HTEDjkYuiUsB+BlqCbQlCdSLw?=
 =?us-ascii?Q?owabeMfSAeCwUBy8ql+oWAyrhQNmllmq9Xm2JeG205UXbm04ual4TKspxePJ?=
 =?us-ascii?Q?+XY1s5BHnWX+uAz5eMXNIHeQtPs9BJFGReGDeMUmBTQtYa+ejKXhm51i33v1?=
 =?us-ascii?Q?6kROMlAftomSm2PcO6aRldIoNAGXMplmDxa1Ya3Qq63+6YTuUxxgjepQFBia?=
 =?us-ascii?Q?9C/BjUBvZiNIZAJMdjfEMu67Tx0bu7tg+BJSJrf/cPnvQE3o38YvA7y24LeE?=
 =?us-ascii?Q?EV7es3mpBhsAgfrDAoqbfJndbixk7qaGux6Jbmapp3WDKPn4PT+CKYHqkhtn?=
 =?us-ascii?Q?w/8kYwyIDtgvZM6rwEGmZRS+nejAY/3avtX6+by15DKcd1pfQRBd8KmLQlJy?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347266d6-a079-44e6-9563-08dbd533d7f5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 08:24:44.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mGyHE9asqOa1KA+GdFhLxlVY/jdMHIWIBlF8A5Jl4+5JeQgNl+6nGL65ZquSMPiqncE7LUniNru9YYrFTay1Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8166
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Oct 2023 08:24:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13445

On 24.10.23 18:36, Venkata.Pyla@toshiba-tsip.com wrote:
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, October 10, 2023 12:32 PM
>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porting)=
 <Venkata.Pyla@toshiba-
>> tsip.com>; cip-dev@lists.cip-project.org
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
>> On 10.10.23 06:59, Venkata.Pyla@toshiba-tsip.com wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>> On Behalf Of Venkata Pyla
>>>> Sent: Saturday, October 7, 2023 9:37 PM
>>>> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org
>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Portin=
g) <dinesh.kumar@toshiba-
>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>> <kazuhiro3.hayashi@toshiba.co.jp>; quirin.gylstorff@siemens.com;
>>>> christian.storm@siemens.com
>>>> Subject: Re: [cip-dev] [isar-cip-core 2/2] reproducible.yml: Disable
>>>> signed swupdate in reproducible tests
>>>>
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>> Sent: Friday, October 6, 2023 6:35 PM
>>>>> To: pyla venkata(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porti=
ng) <Venkata.Pyla@toshiba-
>>>>> tsip.com>; cip-dev@lists.cip-project.org
>>>>> Cc: dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 TMIEC ODG Porti=
ng)
>> <dinesh.kumar@toshiba-
>>>>> tsip.com>; hayashi kazuhiro(=E6=9E=97 =E5=92=8C=E5=AE=8F =EF=BC=A4=EF=
=BC=AD=EF=BC=A5 =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=A7=E2=96=A1=EF=BC=AD=EF=
=BC=B0=EF=BC=B3=E2=97=8B=EF=BC=AD=EF=BC=B0=EF=BC=94)
>>>>> <kazuhiro3.hayashi@toshiba.co.jp>; Quirin Gylstorff
>>>>> <quirin.gylstorff@siemens.com>; Christian Storm
>>>>> <christian.storm@siemens.com>
>>>>> Subject: Re: [isar-cip-core 2/2] reproducible.yml: Disable signed
>>>>> swupdate in reproducible tests
>>>>>
>>>>> On 06.10.23 14:58, venkata.pyla@toshiba-tsip.com wrote:
>>>>>> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>>>
>>>>>> signed artifacts are not reproducible due to fact that the
>>>>>> signature can include some randomness for security reasons, so skip
>>>>>> signature verifications in reproducible tests.
>>>>>>
>>>>>> Fixes #80
>>>>>>
>>>>>> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
>>>>>> ---
>>>>>>  kas/opt/reproducible.yml | 1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
>>>>>> index
>>>>>> 5d6a896..73dd4d5 100644
>>>>>> --- a/kas/opt/reproducible.yml
>>>>>> +++ b/kas/opt/reproducible.yml
>>>>>> @@ -15,3 +15,4 @@ local_conf_header:
>>>>>>    reproducible-builds: |
>>>>>>      SOURCE_DATE_EPOCH :=3D "${@bb.process.run("git -C
>>>>>> ${LAYERDIR_cip-core}
>>>>> log -1 --pretty=3D%ct | tr -d '\n'")[0]}"
>>>>>>      WIC_DEPLOY_PARTITIONS =3D "1"
>>>>>> +    SWU_SIGNED =3D "0"
>>>>>
>>>>> Shouldn't we rather or also check if everything except for the .sig
>>>>> element in a signed SWU is identical?
>>>>
>>>> If we have to skip the "sw-description.sig" file then it will also
>>>> skip sw-description file from reproducible verification.
>>>>
>>>> If I understand correctly, the difference between signed and unsigned
>>>> swupdate is the sw-discription file and it will be signed in case of
>>>> SWU_SIGNED=3D"1", otherwise it is unsigned file.
>>>> So, if we disable SWU_SIGNED that will discard the signature.
>>>>
>>>
>>> (Sorry to jump in)
>>> Any comments on this approach (disabling signed swupdate)?
>>>
>>
>> I would suggest to discuss with the diffoscope people if there is a way =
to
>> configure the tool for this scenario. I'm still concern that we are not =
testing the
>> right thing when we disable signing.
>>
>> BTW, the same applies to other signed artifacts: It should be possible t=
o
>> validate that you can rebuild things bit-identically, just minus any inc=
luded
>> certificate or hash or you-name-it. We currently exploit that we use a d=
emo
>> key, thus have access to its private part. But that should not be a prec=
ondition
>> to check reproducibility.
>=20
> I investigated little more and found that the signatures of the swupdate =
file is not deterministically created because in "cms" method it adds signi=
ng time in the attributes section of the signature data,
> This can be avoided by passing "-noattr" to the openssl-cms command, then=
 it creates the signatures deterministically.
>=20
> Also, when signing method is used as "rsa" then also the signed swupdate =
files are reproducible.
>=20
> I will resend the patch with "-noattr" option used in openssl-cms command=
.
>=20

While that is great news, we would still benefit from some "ignore the
signature" filter because you may not have the private key in hands in
other setups.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


