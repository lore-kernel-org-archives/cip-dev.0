Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BC3CE8D6B
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 16:22:14 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.54])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13359.1763396521413395730
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 08:22:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fx1BwUkc;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.69.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qY981rLr+5dVj9OALCU+6rQL/My0oCtBU3b9+Jr1TGGDbQM0qfU9/YwhRssYQ+6dV0xk/Da2mTv2SNo1xu7Tn6KWCPZ8BSMGZnHPOP1v6wZHBxF6OuZ7/jTVBNNR8IEpKqBiPDhf48uLKeSn2Fb5MXFwHM4X+Uz8z1OomATx6ryOnMRtjcm20ZNIsNDBMGdWlwf/32W9lodXE1OEdJxqbI1FqQ6a1njjrE7Aezo65YwIqo7PKmGcoqZa5VFCFuSLUbkKOWjDmzgHGfbRWRuO+duA0XuavW/HGEufLk/kX9DobA+0cMEpWN263TLAcHlD6BaU0LKcI1h/4qZc7Rgbog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KkWRBaBEBow1CN5xTWY1W+ec9HK1IZwPkWUVs02AD0=;
 b=qlhYO/ygKre/PfSHsJk91uCFThePWoQG4Zr3VS+wZgcKoRxkrixx1/vI1HGoyOgBZsDIhFtYEVpWz6684xgZHViqNNbwBV78ZkzTHZ7E16TT5S25nP6t9xf7SMPaNZFZPok70IZd5qPLvHDz5AMroHeVDaXazOFXzD548XeiQZJgYJpJfTl87aT8kfDNt3pwlrUE95A0VnbdXCzhADj4hbgiOagUHK/EFr1uSkVJv9E4mgs8ngK/Jw6PJlk5W0lVPTRdzouS9f0avFj5o98xBisM6JbD3Iyq2nmTqDMlU5HMXQc48/3GdvWAtST/3AFPfVGgZlrvZBLvKC/jLzIITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KkWRBaBEBow1CN5xTWY1W+ec9HK1IZwPkWUVs02AD0=;
 b=fx1BwUkcAnze7QESqR5pOLI4YSaoo8Wk1enXCY7EP24t0LyjsQC7n7HZf2O/blP4jHnWXfFKhxrJc0+6bHLm4R9j6+OGrcuU5bn7vDSYZkeDriKpQIrUAOKX4ZdfjCo2/9urr/cOks6IkGpSOuGWvZ+I3/3SPF5qIZgUObsSZwmHv6Zhm/JI6f9wmq1nExpfuE5177aw91PsHl39NIUg8yp2KawmjOfxnT6kLgUJE+5GvulVpAn8Ot9Nebbau2I5ko0TsP6Fcx/2CkXiJi0FXICBziJ5I9aiduvKVMNMeOrW0yB+t/zlgJjQqxcydrY0h/RSC5r0sqnhMlB/p/ReRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:386::16)
 by DU0PR10MB7436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:424::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 16:21:56 +0000
Received: from DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3]) by DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fa4b:dd2d:9aea:d5b3%6]) with mapi id 15.20.9298.010; Mon, 17 Nov 2025
 16:21:56 +0000
Message-ID: <6249b2d3-4c17-4a2f-a9a8-877a56ba90b4@siemens.com>
Date: Mon, 17 Nov 2025 17:21:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
 <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
 <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <70790d7a-1ac9-4c7b-acc6-2ee4edc4a472@siemens.com>
 <1877EA27D24C204E.1114802@lists.cip-project.org>
 <TY3PR01MB1134685CE8A4BD38F73A0C1D386CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
 <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
 <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
 <TY3PR01MB113469A4BD6FE4943F03F6D8B86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB113469A4BD6FE4943F03F6D8B86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::15) To DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:386::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB4PR10MB6190:EE_|DU0PR10MB7436:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc1678d-0926-4199-b4a4-08de25f56ced
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?REV5ZDVDbHY5eUV1aWg3UXgxTEhCV2tEbXJpNHBNckVWQmR5bk9McDc3VmZq?=
 =?utf-8?B?cnJTQlpEM1h3K09jV2NtbG84S09hM0VMY0F6VFVrcUFKSnpQTWlZSzV3Q3g4?=
 =?utf-8?B?QmJhSkYwekZCTWZqL0JwWi8vS1JaRUNjREsxSytaVFZVZFpmalhUSEtXTXZn?=
 =?utf-8?B?UEFKRFdiVDBINGpXeXEzMTBNS3djMFVLdUJzUTNhZlZEV1J2RlBHRTVuQmdx?=
 =?utf-8?B?bldNK1NMZlhJVHZKZGw1YURkM1FLbGhFNEx1c3I5Wnh4OTBNZlVCL1o5Rm1p?=
 =?utf-8?B?SnZOTk5vLzNGVjZ3Qnp1TGd5MDlBcGg3c3R1c1R6UE9nRDN6SkRYMzA3dEhx?=
 =?utf-8?B?dUVRMDlJcWNZanpUV3lTd2VyQmd5eHo5Y2tNa1JzTXRaR251bzRKVWd4RE13?=
 =?utf-8?B?UGRyUG5sM3BBYUVlS0NkU1NpR1ZrMnBHTDJmU0JmVTFncWNQa1dRRkhET0hF?=
 =?utf-8?B?dUU2bHYybmkxT2hFV3podHN3dDFGa0hIaVo4SFdmenpjTG1ESnNkbjVtSFFl?=
 =?utf-8?B?UitIS1BlYzhNV2RqaXpkbHhTMEVrR0VKWi8weUpCZDFMUlI5Sy8zL0JsNDda?=
 =?utf-8?B?ZTFac0dlK1ArcXFTZ0dhaUprOC9JOVlFM0lUSnNFeFNyVzBscGhWQkF5SHNy?=
 =?utf-8?B?eW1qbTZZZC9FSjFJaGh3NlU4UnV0dklyM3pBQlVDZkVDQ1Q0V1MxcjloSi8z?=
 =?utf-8?B?RFZldit0bDlsb2tKKzhUOS9HTWF6Ty9kRXp4R2phODdTRk9aSlZuaXM0TDZ6?=
 =?utf-8?B?eS9ud29BVEtrTTFkVWpLcGQ0dzB0V1lMQk9oVWkyUy9YdUxWUDVRbi96Wmo4?=
 =?utf-8?B?Wkt4VjFWTGY5MHhFZVRvcFhJU0xualI1aHk0d0l6RUx6OWtLSHBBMnRxNjFu?=
 =?utf-8?B?Ly91Mzh4WW9MUHBJT091czNqcUUrbitieHY1d2JvY09JN1VSSGhwdjlhMTJ3?=
 =?utf-8?B?L3hPN2k2NHJDWlJRSlRCL1R0YXFabHhjTVJ5TzNtZnU5YlBTdnJUYjlEa0ov?=
 =?utf-8?B?K2pxL0dQY2ROTGI3M2JoekFMMkQzYjc4WmJUYy9rcUlKSFpLS2FoOWdLMDNu?=
 =?utf-8?B?MVZrY09yVzlVRFJOTVFmVXNOMFc0UmRBQTNzbXE4OVV3WFdiK01ZTW51NGNv?=
 =?utf-8?B?aXV0SEVRd2RTS1lxNTFXbE85Ti9pU2xWUkZVTUN6QnF2TkpvblA1dDZ3OGlx?=
 =?utf-8?B?YXgwQmY1cndTWHBPTnN3Y3drbG5qN2FSQ0owZFJWNUdIc24rZXY5WXBpWUtM?=
 =?utf-8?B?enJHYlVwWXFKVjErRXZBTjdHZWo3ZlowdkNJTjNsZjl2THVKRDRCeUNNYkN3?=
 =?utf-8?B?cjYxMnJzWFoxQmFZaVNqMHFRUVBZTnVyWXliZHZpVWJBNmFCZVlrbElsOUFK?=
 =?utf-8?B?QmkxemJuUG9vcFRmOVlXZ3dPcVBpZnNXQjdWUzE2YnZFWUtrSUhtczdiNFdt?=
 =?utf-8?B?QWFvNkU0UUdKMGNnclY0YmlYWkoyc0lRVWJBVlQ1MlNYUVJ3aEpJNUpSd0lG?=
 =?utf-8?B?YjVUTmVnaVc1THo3MThMRHRwVCt6bE83b2dWYWJsaGR1TnVsTzcxcExpSkZ3?=
 =?utf-8?B?bjhOUmdONWlUQWMxMU9rWUhhR3hrVUQ5RWRvRDFMOHZ2MzV4UmppWUZjanZp?=
 =?utf-8?B?RHgvNlNtendnMmRERGJnYWpad3pzSWVTWk1hcXhZMG45bU5Vc0ViM3NSSjZr?=
 =?utf-8?B?REFXQzFubEZzeXNOSFJ3R0x4L3NtVjhzOGxUQXBrRisxZk5VNWdJSE41dzVZ?=
 =?utf-8?B?azdpV1lHelNpd1p5b2JzRDZDeTI1ZTQ4YkpseWRORE1oelYyMVZHeEJESHRN?=
 =?utf-8?B?OWNZY2dtazRIL3IxNXl6RlZIeVQ3aEl4c05TUlFlK1UzbEl4M2RTQSt1RXlw?=
 =?utf-8?B?T0RsZHJ5Smhxd2puejdWNzhzb25kTG8vTzhhaERJcExFODFacHBDREMzQmxk?=
 =?utf-8?Q?WPuFVdW6lVzNeayO8vMvJpPq41EqG96j?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NUJrbDNVcllaWDBWZVQ0ZDQ3RElGaE5RclFPVVlFSmxwMFZCUHFReTZxT3Ry?=
 =?utf-8?B?UzV0aGJnM1ZLR25PUzdRd1FuWXcyODVWVzNVYkNWemZLT0ppcmhadTRIdExy?=
 =?utf-8?B?ZGh3VGI4ejRaS0pyais4dkxVeEovUWJKaUgvcWJYa1ZPWEgzSnIvY09ZRE5v?=
 =?utf-8?B?SVNTWVFwdE1IOWpkOHJYZHB2T28ydVpuMG15NUUrWTYyUVdtbWQwVi9OblZJ?=
 =?utf-8?B?bU4xWDFWRXZSbWJLVldsU1laYTN1ZTkxRVZCM2FCUXk3U29TbWZya0ppOHNt?=
 =?utf-8?B?OVhlbytlOGtDRmpzU1hNaWpVcjlRbDNQRnVZaGpseHpjSy9kaEJNcUVxQnE0?=
 =?utf-8?B?bUZZSjU4YkFwWTlrK0U5QjFYK1NvZlI3SlBlWmtvNFd4a2NkNS92eUMzZEJZ?=
 =?utf-8?B?MjJGbkxIMHZHbGtLeGRRcjJOemhuVVVmcS9tQWtVdWFWY0tCRHE1OUZsM3hD?=
 =?utf-8?B?SnlzVXZIZXhTd1dBTGZHaFJmRTdHdkdtbHRRbUpjZDhRaVpqSjAxVUxram1C?=
 =?utf-8?B?bXNFYi9GWTB2a2VxT282dUpGTG4zVFBjSFRiQ0Nyem90WjZJTm9LRnoxajV4?=
 =?utf-8?B?QjNaVDlEVmNGNnJSSDBwT1BOeVFGYU1HOVBLTmkrbFhuUUcvVjFOcGJUQ2lz?=
 =?utf-8?B?bThFdkpPbGdNMUM3aWI4dXhKZVFyYzFmbVBYS3g3Zmt0U0VIZ3RqWUNlNWlv?=
 =?utf-8?B?QklKZ1c4ajRIVzBpdEVGbGgvQmZxMTlFVDJNVVE1QTdwTVZaYzJqT3AwcmZO?=
 =?utf-8?B?azJGdU5pdmErbFU0dGo2dFMvVWl1VVZBOUVtMzBmdkk1WkdWRHlwU0VDUEtC?=
 =?utf-8?B?QWRTUXhvSFNhWjlJWUVYZWMweW00REF2UllXbis0Nnk4RVNBaXZPelJlUDRN?=
 =?utf-8?B?R1dlbXh6aTBmVVJBdml5M3E2ODMzMXRHU3ZwMjhoU0pYWE41U0hUaFBpV0hw?=
 =?utf-8?B?bXZtOENzM05lVW1XMzZvRDFHQlVLdXdVUi9sdEUxeG04R2owbVdYSVBhYWx4?=
 =?utf-8?B?S3FGbnJZQVc2VTlPNGJ1ZEZ5ZVRIalhaY0VGOUZpS0RGb3lNdkFIdEtyMzlP?=
 =?utf-8?B?UjNCc0hGME1aakRyQWRMRHBaUXl6S0lrV0M4TE5ydUlmWlIyb1JUdW9rQ0FZ?=
 =?utf-8?B?ZCtldGg4eEJQY3ROcXZiZXlJRWR0U3pUemhGZmRTZVZLbm1QbDVwdzFEaDdI?=
 =?utf-8?B?UkIxUlY1d2NyT3IrY3IyZW1HMnMrUXNjVGhydDRud1c0WDdmOVZpbjJnUE50?=
 =?utf-8?B?WDFQQU1xTjZZUlg4dEtVSDJnbkFOS2ZvMGRTclJ3VjVyT05KU2REOTBTdEZF?=
 =?utf-8?B?aHp2RHRoOTc1VFY1ZWc2dTFkMTlVakJ3MFhySDh0ZmdsREVub2NJM0lkUXNn?=
 =?utf-8?B?WVgzUElKKzBhVmM5MlM2RTdEV2V5QVl0eUtvMFZFaUwxL2lyb2h0MXBuRWt6?=
 =?utf-8?B?N0NuRDVqT2FQVUgxdi9tVnpPMlZIUkJpcCttWWZlM3BEQTBPOVRlMTEwQ1Rm?=
 =?utf-8?B?Q1Nwb3FuNlhGc3NYdGxGRmhLSXBiQlN5cW9NQlVaOHNtZkFoc3RuRkpaMVRZ?=
 =?utf-8?B?NUtyUU9VendyaGJOZ29sWGMzZ1dSL1FNUFRWSDRKTW9xQkNRb0x6OVZZeTlz?=
 =?utf-8?B?TklxMmVpSmplY1ZLaE85OSs1Y0lsYXBVdnVCTG5jcUZRQ0h5c0JhVzNLVndo?=
 =?utf-8?B?NXVZVUdxYzVMM2pIbjBuNHp5TlBuRS94dmhpZVg0ZWZMMENUODluVE5qeTJO?=
 =?utf-8?B?c1FNREJKdDh0OHpNT3c3U05zYXRTUEYxQzdaRE5vd1J0aXJQWHZYTGowNGFR?=
 =?utf-8?B?MSszTDFJcEF6allPQmdJMUhwU2MvQkJib1I4MmNiVEtCbzYwVWlmcFZMQmw4?=
 =?utf-8?B?ZHp1YmljNVVMU0x5L3hta05PQ2tHbDFpSVFRY0x0cUE0eVArbzQyVXZIVVln?=
 =?utf-8?B?K2hKcmNmREhucHBJU2lRQW4vRzZYK25qQXJBZ2FZZmNZc1NwVWNPWVVKRHRC?=
 =?utf-8?B?MkJramRDNXFpdGFrckkvcDY3dFFjOW5jczhlSWJSY1JXays1cTBSMjUrcFlx?=
 =?utf-8?B?bXMvYURjVUxrUC8vUE9HNjhsOHZCRDZ0Z09BdzJPZENUOHViVHZRSCtzZkNz?=
 =?utf-8?B?ZWo5NC9pcy9Qb3pQOXRhUlRISFhXR3RSajJoSFo4TWVxNE1iMTBTSTkwNlR5?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc1678d-0926-4199-b4a4-08de25f56ced
X-MS-Exchange-CrossTenant-AuthSource: DB4PR10MB6190.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 16:21:56.2898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dA9qDtNOLXom271WY8a8zZOHvW+SUQCYgAA0A01bKIwJRrkgVFvRCC+cBRP9ORAmfEAyag4c99FEQf7LEFDnvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7436
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 16:22:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20596

On 17.11.25 14:39, Biju Das wrote:
> 
> 
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: 17 November 2025 12:23
>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev <cip-
>> dev@lists.cip-project.org>
>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>
>> On 17.11.25 10:19, Biju Das wrote:
>>>
>>>
>>> I have attached u-boot.
>>>
>>> Please check
>>
>> Will have a look, thanks. Can you confirm I received it correctly?
>>
>> sha256sum:
>> 224c1cff35b672c886afa94e3c857c7218bc75db179c97f48ad53b6592e5a167
> 
> sha256sum /mnt/vm_share/u-boot-iwg20m-g1m-v2013.01.01+gitfe16aa4fb779567d1b7da7c3cf22eaa9555fb483-r0.bin 
> 224c1cff35b672c886afa94e3c857c7218bc75db179c97f48ad53b6592e5a167  /mnt/vm_share/u-boot-iwg20m-g1m-v2013.01.01+gitfe16aa4fb779567d1b7da7c3cf22eaa9555fb483-r0.bin
> 

But this is still a historic u-boot from 2013. No EFI boot, not even
distro-boot. And not difference when starting the kernel (no output).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

