Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148DECCD193
	for <webhook@archiver.kernel.org>; Thu, 23 Oct 2025 09:21:41 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.14])
 by mx.groups.io with SMTP id smtpd.web10.16006.1761211292216450194
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Oct 2025 02:21:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FNPyzeVM;
 spf=pass (domain: siemens.com, ip: 52.101.70.14, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/gTugAOsGHnN+CCHmOIFoAit4Ogf5CwURLDUFId0J/L+jBgLrOe8kN2oE19aOO4iTrNVclvNjed166wUgesTVSqMXQQKGkU+/ydkRizFtBobGv/3VbekukWnbztJfRxlemeUQhOe67cmnieHOKIEb/dOzl3jLgXkmVuigpErBEOckjHOdwK+T82IpdItSwSZC0PM/ERYws65BdtIPxPI4kYlq3NqHELUlz1DI+xnx8xoS37n3Uec3EsAneW7Ns/WGu2A167AbTjIoYoojbVyoiLP9X88SWjn8OpcV+v2CIUxxA21fcXqVMqltIbxsvzCPF8gh6xs/+PkvKgT1JB3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=audK7iYrNv4ttfjE3bzfVCuZcax/hsEy60ed4Ignv/E=;
 b=vXKcFdoH7OyDC2LIIQFlxtRpK1wUlGcAwVhWBBbWaxxiUNysTFW+Ec8WgMZ9XMs8TN+O2hfjHlqHrfcZdSqfcNp9FlRU7aMdKXiA6jTn6LOpC3W3z3lPWW8wk/nKd7M6ySpIeCraH++iHDnjY+ODIiNrjAOw4P1d6uM55lWFQQHpmIGBC2isIcFWiiB+j3I7Cep59HfsgBMgNE6d2Qy0rez5VjfLxLGLbxfcHc2wKT+CfML6A28jENyXMSDKH09VM00pcWI8zqu28/XCvSQcT2Y5IJDqCb/nxAMSNCP+raL76KzqksQSGVaQOlFBJLDOqrm0mwg3er1s9G4d5KuT8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=audK7iYrNv4ttfjE3bzfVCuZcax/hsEy60ed4Ignv/E=;
 b=FNPyzeVMYCxxBKBbb8X8oZdkKSEbcUHVbu7BZSlxrEE6lZxaclp+XGVjIpFebHq/liSXZhO2Qny+nDuWRb7Fg7Hn9xoxNFaUkGhTpOVpjBUE1/SuuZd4jRWIAlI7wXTUp6FngMyi7QikCiNsRloPSpfTc1kWliuEilJ2hlY72Erw7KOEvrjKFkVIQDMZnXAwSZzd5k8Ta4KYr+NfE/0KGPiOx76OIl4mWPD+8uyeqbexUFVEjDv3od2S0Tzg++Pwrf4h8vrV/5/pF5NBJiDi9jizoSs3LXSyq2cFnw1rn6BZyEYrlLOzzmAOyoFobJ+i1mGY3Eyn3VyjdpEHsPGd6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DB8PR10MB3848.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:160::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:21:28 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 09:21:28 +0000
Message-ID: <84afcb3e-1089-4c81-a682-c943a811b388@siemens.com>
Date: Thu, 23 Oct 2025 11:21:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Adithya.Balakumar@toshiba-tsip.com, Shivanand.Kunijadar@toshiba-tsip.com,
 cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com,
 dinesh.kumar@toshiba-tsip.com, nobuhiro.iwamatsu.x90@mail.toshiba,
 jan.kiszka@siemens.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <86499842-6098-43d0-8e45-caecb3fd18be@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <86499842-6098-43d0-8e45-caecb3fd18be@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0330.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::8) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DB8PR10MB3848:EE_
X-MS-Office365-Filtering-Correlation-Id: 69e21b26-8fe8-4be3-9888-08de12158b73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|4022899009|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wNH3HM3/x/f9bGLXuZgTU+MBdQ2+poWt7NxsC6Sy29U6W3n4nxLoFraXhfbJ?=
 =?us-ascii?Q?/9sDph+O09TA15YMtMKrkv21Avj9rNEYVWNNY/4Sz4Biw0sGsgeicMPs0YX1?=
 =?us-ascii?Q?WjS+Y3yaOx57IOXu+Ilbw+m9rwFYafNI0RS6pTfawl+8W9SGO/fmJeQeZlOS?=
 =?us-ascii?Q?f8UKE6G5UF4yPwtvuu/JQ3EPvjZvDyrx29XOu/XcQCEEKaNt8NkaheE4QXp8?=
 =?us-ascii?Q?KgSCB+bCugMilVoVfYTqAng2XDasn6mCTgkl8Wffd/jOD8ELRUPOoCCqdLLb?=
 =?us-ascii?Q?EnvrNljJzS0IPzGd82KsK6EnsOEWxGMYoseftN1Q9cHRYdH9J1MHM4Xy8lBS?=
 =?us-ascii?Q?5vKzmqQn10tc6BlQTk2ROjfyiBerN6/iUqSYqPCLq9b77Rsjoq5IbI/GW9HF?=
 =?us-ascii?Q?owXUHY8G7pSPu8qf6nQLS/Ro3Sg5zfwx1B+qVyR6o/+SY04DplgHgzSQhdnV?=
 =?us-ascii?Q?lOoykVmAHZNXdAYTdIqU18MYsBcCOBjeWRwPHMCTwLOvFcF10yMXUTZCwKzb?=
 =?us-ascii?Q?Ja21N7QM+aw2GfqQQiG63oL7qr0sO7bl+vb3X7fC3mLQVbxQn/mtAM6k5Ivx?=
 =?us-ascii?Q?jCafkzzXhAEuN497yVIYW8Zfal/Pv9kz9+kuxFP9l/yqz6IXYSIjHsUchm2t?=
 =?us-ascii?Q?K0R0RqoJwy4ENhBBtapeZnnXjP5az0fcpm4vilhBQ802A8/30ngjLWj4UQd6?=
 =?us-ascii?Q?QsBcIKKW/zlT662W2Ag/rKgCEjlQCI95lJKXvDQoJoLkrgX10f6nwAamMMhV?=
 =?us-ascii?Q?fGmBpNW2vRTnaOeA0iEjbb4+SS7SeJBPzymtwEXPp/Uh2UeVLOBpv0FhA/OH?=
 =?us-ascii?Q?0KA/lD4W3sDlBw14FvGIYDuoVej+u6Q34YAz8VV6lJJdcA8nZvbzs/PiSzYN?=
 =?us-ascii?Q?0Ednl3gvd+BFbn/0jNf+5RfN0my39n3LXtG11FXudV/Xutc3KssRkerdKRpD?=
 =?us-ascii?Q?WfH1+FINXIIVtF+5HmEBWWl7+clzVI0JSRtEb6G53vKucjnpjM+H/Lklhh4a?=
 =?us-ascii?Q?OzszcDi/MpVvlLPlEsv5Hj8rH06ncQa67xJYAXcxgI/k92+DBkaUOmV8g/3B?=
 =?us-ascii?Q?cQqz7vZPS3ZABaghXcXZ8LuAjjEfl57kagtb3hd8LOtd0XT1WEIaOFRoPG1B?=
 =?us-ascii?Q?C7VcFn4ol/eTwepHkhBk8/ATxTXvzRLidOLvJoYv8wlXP3oM+ZvEAyTIsm7m?=
 =?us-ascii?Q?93gaGl+YAHPC4kBl3gJZo+xJyqCZOV1qMDeVjYiUUrT22Ko3AMpLj7vjczY5?=
 =?us-ascii?Q?PIhXwXt4UkQw1nzlNJJzUt5t5aX+lOR7UgnzPYmzdjLtKxcbdOgnGkfH5/+r?=
 =?us-ascii?Q?Kgr+fjk/blkv5a0LjZbxOdw/iHLuobID26Fg4Ikl305KCB98AqLdZyT9JEwD?=
 =?us-ascii?Q?u0CMvtXiMpIY8HhvEgzRS9Pg0YxgOsUvbt+RUmdjISXOoJW3+g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(4022899009)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nudxZaiVnAksnXZusp9KnRFxVjDIKdT9Vh9ElvNhrFOy9K13WUM9HPseP4SD?=
 =?us-ascii?Q?t1mq20dr5HV3+l414TqFxBADC55wGczJGY/tm0mjKvP7uk6u6ft0SUAetFGL?=
 =?us-ascii?Q?3olKHuct8az2T1Y6cez6xTRecxBDcgP8xBw3xK3FHVtcwMiluTfGCcdNmbTc?=
 =?us-ascii?Q?6QQTO+3/uum+oqESqkpbbowb0W79LW/VbaeqAadgbnpi/fIyd+XF5kbyF+Ym?=
 =?us-ascii?Q?ZLLlIO8z8Tblxgof6zQdEKkaZU4PuBBSdXC6kfXj0NNZfMJupZ4h+R2S883F?=
 =?us-ascii?Q?1WkOymOGDFoZPxOmY5dHDCgtZs0oil6R6c5TZ7ulBPbK9X98cfeig5MJ7NSp?=
 =?us-ascii?Q?Q8LDFgSa9prepAexhRzEDmdXn//mYS0zhUG7zzA951iQcPybx+nh0wRN5puC?=
 =?us-ascii?Q?1o7PqhCcJLI45DUUI37yvQRZCViLh7bSAtWSEiaRXXNEK8D0ui8rsqqBLQVX?=
 =?us-ascii?Q?M8CvPSPP9J7fjMmsWgp1zFOZe63M2Wo6SS0PY8hzAay0X+ODB0KpYN+Tj/9n?=
 =?us-ascii?Q?AY8FmjNDRcEJ+hP5ORYrNaRi+p84QJW3dxz7sDIrs0DoVU3pLSCsTtYjy0H8?=
 =?us-ascii?Q?s4ORdYZS+hKUqFT6p8XPOl3HeZpxtYntEGXZO/Z4rIddFjoyPYj5JRDp4m+8?=
 =?us-ascii?Q?7Xgrx8xTScjkCnC9fxPZeALB/8LflXvxuK08ly+c+S+APV2Gqp/FhcDDtwWf?=
 =?us-ascii?Q?x3Qq6dixGc6gmlRrxtpQK8dPW1hVYXmq5etg8dMAQ2dxpsmdyM2O+JmdtbZO?=
 =?us-ascii?Q?utLwPwrPL7mGrxZxMoUsTYf2O2nRwxEFDCkyKvUNm1x8weFe/Vl439ALGi/Z?=
 =?us-ascii?Q?FprIWAfdvFV3bR+HbvqwMnGj1FJx9DoapHxL/ETKIxyqoLxA+kkwkdvX8O+w?=
 =?us-ascii?Q?vrbYQXZBnfJCoaFQfqt7GHRCWRWajBLrKiAkr8t/dVnZprJIYS8mKJcsxMa7?=
 =?us-ascii?Q?wTAze1+ElVZn+2SJhh1dC1ziUsI+gMBpqqXNvfdSWQ15S4eUfYeqslmitVHc?=
 =?us-ascii?Q?kf1SpZp4A5WEQL1ataljzn6qtUNBYw+dUIWy1cYVzPBBLIlFjQnQdKoiozQP?=
 =?us-ascii?Q?+9mDR9NbKOroznIa0csSM8BVAEg6kXskgJQzihlxmMA2MNJWANOnA4N5B9uC?=
 =?us-ascii?Q?9w9nXDItg15R/fAH6P+gLPC89BYPiooiK/5ws5oKSFde5Hgl6pRCMpdbS6aM?=
 =?us-ascii?Q?3hrfM2AtoyHfw5weudM1cazs6PeEE8+IzLJOT1DlMhXDSxtISXe1YtLx3Xwl?=
 =?us-ascii?Q?hrshi5P/cPn2a/lPtUe66FG8k30eMdXvriGvvS0rxkTJ3jD5xXESTstfWdf4?=
 =?us-ascii?Q?m53HCYmI2vp8YTM42LTJcqZMT2r41Aq3NjbLsndRas1ZwiOWdqc+rBStZwfJ?=
 =?us-ascii?Q?EBd4Q8zazxX5By+cPnn3S/W2RWTFdVYy/aJTbvz8Jw4iJmt47Z4ZFV30t5UT?=
 =?us-ascii?Q?vNnRAf4/IeTbjYHhUJCjHK1NtfZdjnvcl7cIHxwjacgUpyon7CntZl7VBx8B?=
 =?us-ascii?Q?eO7uK/ltKj5soikqAD9tIhOsdCwHn3+NCCTpm2XnipJre6DwKKF8NmY4CNjK?=
 =?us-ascii?Q?uKhy56X2n0pyJy7ebcsYS7tbNn6N5GxTkC2Ew8j03xEVB25F9EgSdsS7ljo8?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e21b26-8fe8-4be3-9888-08de12158b73
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:21:28.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 77f4+oITla66uXFR2NsgO49TrYPf98DOiLTwnXWic/0qTxP2j/GgCg5BILo3lNQj1ZOcdbpMSA0c9/01ylswuSU3sLkmC2ggErtqGO5xyso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3848
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Oct 2025 09:21:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20216

Hi

On 10/15/25 11:25, Quirin Gylstorff via lists.cip-project.org wrote:
>=20
> Hi,
> On 10/15/25 10:53, Adithya.Balakumar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>> Sorry to jump in here.
>>
>> =C2=A0>We may have a kernel configuration issue here - or a real CIP ker=
nel
>> =C2=A0>regression. Going back a month to a passing test, we got this bac=
k=20
>> then:
>>
>> =C2=A0>"The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>
>> =C2=A0>[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/=20
>> jobs/11344068159#L1724 <https://gitlab.com/cip-project/cip-core/isar-=20
>> cip-core/-/jobs/11344068159#L1724>
>>
> We still were faster - the last successful test on September https://=20
> lava.ciplatform.org/scheduler/job/1309843
>=20
> were the 1.9_5 test did take 298 which is faster then the now measured
> 712.

I test some kernel configurations and found a config[1] which working as=20
the previous version. I would like to find the reason for the=20
configuration mismatch and would therefore remove the mtda-mcom from the=20
testlab to test the kernel locally.

The main fix for the stall was to set:

# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=3Dy
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ_FULL=3Dy
CONFIG_CONTEXT_TRACKING_USER=3Dy
# CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
# CONFIG_NO_HZ is not set


[1]:=20
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/475783b65fef5d=
9d9f97099f7eb345177e69ff10/recipes-kernel/linux/files/mcom_additional.cfg

Quirin>
> Quirin
>=20
>> What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).
>> QEMU IEC test jobs have always been quicker and are even now.
>>
>>> "The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>
>> As far as I recall, I don't remember the IEC tests run this quick on=20
>> the LAVA M-COM. Apologies if I am mistaken.>
>> Thanks and Regards,
>> Adithya Balakumar
>=20
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20177): https://lists.cip-project.org/g/cip-dev/messa=
ge/20177
> Mute This Topic: https://lists.cip-project.org/mt/115411267/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylsto=
rff@siemens.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

