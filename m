Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906FFD5C0E4
	for <webhook@archiver.kernel.org>; Fri,  8 Nov 2024 15:02:15 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.77])
 by mx.groups.io with SMTP id smtpd.web10.14493.1731078126636072950
 for <cip-dev@lists.cip-project.org>;
 Fri, 08 Nov 2024 07:02:06 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=EcEgzFAh;
 spf=pass (domain: siemens.com, ip: 40.107.20.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VmN/9FS52LtRP2jOrgruLeV7zeP+PIeofqSd7RO22jhadtGu4O4yacANCNqZgMayjLUDQlo52evGTDNCwfhnAeqVwUSr1bFZNtEkrCD3GZDLMX7TOzVE4Wb+3XZQlBppt0iLDNLiMS4jBnHmIiwob4vf4I1FUF0owpzDY215aHadCgkXD2i1j7di8UDHXEDWlQYPAXDc1fhmMnlBF/K9rS87Hu15VMsGPXyde6YLfTxjJ4x5lQV/brpuYAHPmjNtwFtWI/EDRs6DYTwNW9NbELMKGckKBqHKkYgQi0HXl27r7zxRCri2E98yP0adtNl2+8RndoSAhKiI/ANmrtghCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GorAs0AG9psgwSm9cYtAGOVK6y+zz0u5JzcgNrjkaj8=;
 b=Uji9+pvoDoe1QSkK3AQtVHok+C6dSPbaBAfcE56lsCY+2xdC255usAaC7tROslrC/8kIgZpkaDnykk6anUZLUKiL0v5CkH2pkxtQuvX8ZoM4BjXkpE6nstt09FNRDVlLzK1LC2+quDnYujmHUTPdmzaacVnrZNgQsH+o19mBmvnRkLJnSGcly65WX9tvHmy//uLSbeHJoub8Tnt+aIwJd8RxNR3pP87II4CGKHLQssLxVUxmkABuseOB2Za3YLIyKY1EwfefDgMqA0V2i2zHwjjLKMf9QzqmsmS9+D7IDMqicg1pIFcLvE0ou81u13gFhBht2NUxPum08wIEZ3cY5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GorAs0AG9psgwSm9cYtAGOVK6y+zz0u5JzcgNrjkaj8=;
 b=EcEgzFAhqRGad6mt/ezgJVOkkQ/svIaxa3gAsAVdzA/1DnisSl+HqNcM+tiYbYbwdc8OlriGlRsDrIhf6cGrSKpUqy2vJwcPFBJF0NWBaxMTLIwEnvFny9oPTzxtRP7xcfOUyrTfUcxAE4Peh8dGwwfzuL5W7ErtYDmONR0owXK3Ya26gf2mnZYkHwHhXMUbSx+/gGcC9ypuzs4hpgj6ICLbB4MA2I36/GjeCIgirpJmQtpxBwF1bzngEHEJ7xVlXg3eVlJllOGQPxqvlwMFQH0iZob75g+CqpLzcct/EKLs9QrL9nyUTIk2VsGHavHwesOVro1VbpTAdlL/XYctjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7866.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:35f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 15:02:03 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8137.014; Fri, 8 Nov 2024
 15:02:03 +0000
Message-ID: <61d6c993-6bf9-498e-9952-d000868cdcaa@siemens.com>
Date: Fri, 8 Nov 2024 16:02:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/2] Fixing dependency of package
 expand-on-first-boot on cryptsetup and tss2 (tpm2) libraries when building
 with disk encryption enabled. (for bookworm)
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20241021185359.927395-1-alexander.heinisch@siemens.com>
 <20241021185359.927395-2-alexander.heinisch@siemens.com>
 <d4932ec9-d4c3-4be4-acac-b3957b710627@siemens.com>
 <AM7PR10MB33202B3696E06E47C3520679864E2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <47553bc7-816e-4f42-8745-d5992b6e650e@siemens.com>
 <AM7PR10MB3320E21C3DD427C0C85A3556865C2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <07bacbe5-4716-4dd8-88e1-f9fc3175b9f1@siemens.com>
 <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <AM7PR10MB332087B9AFC5DC69CEAEFE46865D2@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7866:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fd7937-fe5b-4a99-6d74-08dd00064d85
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dVR1Tm95N0xKNnY5bEd4UDhud0hxSld5TEt0ek5SakdWcFQ1SUI3TytXTEtC?=
 =?utf-8?B?a01McnJER08wVGptWFFwSkJpbkpOaGhXakNIVHBQTFNPRkFQWUxVenBtS3Ay?=
 =?utf-8?B?T1hmS0VZYzBETmM5N0Q1d0hWYTdEdzJxUU9POUlrTkZuTnZGanhMSE04NHRY?=
 =?utf-8?B?QXFIYlBiQ1plUlRNMGNQaXpsZ3hRbHpxR3JyellMTXpOZXlxVmQyZmdQTXFu?=
 =?utf-8?B?Um9qakNzOFphUXVKeHBVQzVnZmphU1BBZTFkTGhZVE1TdkRKZkp3d0FxVDRp?=
 =?utf-8?B?TEhFK3c2ZkZ2c1FJU2UwcnUyZzlUSjFKYU5taWV6ZW1aVkEyS3MxR2RVci9N?=
 =?utf-8?B?V0tIcVRJVXMwSU1Cai96UVgxU29hRWVtQ2dFdWFNUi9MWjFkOG5SakhZN3BY?=
 =?utf-8?B?Mm5tdnBTVXlxRFhMY1NNOVlSRmdicVRGR2Q0T3BiMktoVHAxckw2YlNOYWNI?=
 =?utf-8?B?Z3UyTktzSVJZeGk1THBPS0N1d1ljR1BQSW1aeFg3MXltcFJZZ3hvWEhSa1Qv?=
 =?utf-8?B?Z05GZnIwL3JLcUR4eXN5OTRRRXpLbUw5RGw1ZmRDMHJsbE5nekVISTRZN2hF?=
 =?utf-8?B?YktJd05aeFhuS1R3MW1FOTlRYTh4YkFiUnJiZGhNMFRoK3JuSDNJZXhpUDlK?=
 =?utf-8?B?RmQ4aUQ4VFRRL3lLcENEazdaL25DSFZvUFZOeTNqWFU2dzM1R1IrSnNOOTRT?=
 =?utf-8?B?ZnpKOE5QNVB0SzJ2dTNFTzc5aGhyYk9UT2lvN2Y5MU5seGpJMHUzdkpXUE5I?=
 =?utf-8?B?S251cjRRdlBtVWtFSXZTSHh1ZTVlM3lMbmpKNkVJSWM4WmdhMGdBOXEzOFJ0?=
 =?utf-8?B?Y0FGRC9BcHRTRi84cUp3VFpUZ01kNjhtdjNGeGlraWNmczAvK1d1ZTE1Y0Yw?=
 =?utf-8?B?V1RLVnpPenpYNGZRTWtJRTJRYVZxczVXWlhCUWhoa3k4VFBEclk0V0t6Lzc4?=
 =?utf-8?B?R2hFVi9maHZ0VWt4SkQxSWhWbCtWOU4xaTU2TldNenlRRjd6b0RBS2VydFlH?=
 =?utf-8?B?TXE1MWRxTCtFdmFmM2xBU0k2MHFXNmJVVFo1OVMrK2NvcmZUcGVseXU4c1da?=
 =?utf-8?B?eFIrWHg3MWg0YlB4dlhIUm1FcE5EMUhna1RkNzdWWnU1U1V6M1dOZHdIVUtO?=
 =?utf-8?B?ZjhzbnZjdmxFQXZ3bERLYmo2cHk0azMxVFZoQ1ppRkpJSjV3ZUJoQXQ5aXQy?=
 =?utf-8?B?UWdXZlFhaUlGUDQ1SUpsUGNQbUpoaFhTaVVFSFh5RnJQTWNWKzV6YXE3VU56?=
 =?utf-8?B?c2lhQ3hwazlCeUJYZy9Ba3dSVmNkWDZ1OU01ZXRNNzI5VHdDaXVqN1hzTk1P?=
 =?utf-8?B?VXZQcHdkNnVnL0ZxTldUcVhpaEdqRzVoamhXR2pLVnM5M2tzb1g4OXY1c0dU?=
 =?utf-8?B?ak5KMUt2R1ZwdTkrNUhGbHExczRNUmdsY01KM0FtVTRBc0tvVzVieHdmMEw1?=
 =?utf-8?B?dG5WUkQ4cGUzNC90cUJMMnFPMHZ6Z3AzNWM3QWl5YzNMZUlmcFdIN29ITmd6?=
 =?utf-8?B?TzMzeC8vT0owQ2RaeWtFVVRkT2sxZ1BPY3AxSnVDR2pXcmM1UDF2RWFWcWhI?=
 =?utf-8?B?cWJZRXFPTHhDcEMyS3JVTi9OVHk1TGNTZ3NBZGVNUCs0YjlzU1JQSDJORDI1?=
 =?utf-8?B?TFpqZ2NSdEpkZHFhN3JsSUJDckZJYWJDS0ZqblNYTFRkalpmYXBEWC9UNDZn?=
 =?utf-8?B?cytkVDJpME9mUEF2a3VPeFZGQS9FUlNQNCs2M1FGSHRXUW1obyszV2Q5Qzkr?=
 =?utf-8?Q?lM7l6xSeph8uCsBMiv3ZcZQR44xykzWh9fplVCE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eUx3U3hIakR5VjU3ZmdDUnVJQUhSdkFlSFJFaStQeTVkQ0dIVjJtL0ZLdHFt?=
 =?utf-8?B?cSt2S0VkekFuL1JUekNRRVNLdDBKWHRiN21ub1FXbCtQaHhTenI4c1BFWVd3?=
 =?utf-8?B?VWw0Z1RSR0c0T2lWZEwraWo3ZFVjOXVXRmlPZ1JmMjBYNHNqWW1WYmFkWWlu?=
 =?utf-8?B?Qmx4aXVoS255am1CU3FWZUlWc2RlbThjd0ttWHN3UGVvbXJ0b1hQK0Q2T3Jk?=
 =?utf-8?B?NlZnM3FENi9OQ0l6M25YRlArWjZQRHQzZ2FwdS9BaUtTMkpjUjFFaGZqQWE1?=
 =?utf-8?B?RU5iNjc1dldQaDJ1QSs4WVNxSmJMSExaWGVCam9RR1ZlN0NpMnNTZ3FWY3BU?=
 =?utf-8?B?SXVYa1kxY2pCeWpBaS9BTTRiZncweWU5L2c0dWJlZGphUktoTFFRdGZVMGpD?=
 =?utf-8?B?Zk1jcFF2TXVMOUtObVFvaXBJRVh5eEhnY29yRXJCb29vQXhEdWZWYTBlUDdJ?=
 =?utf-8?B?UEhDOGdnci9FWXRPRFVIa05qejhYQWo4bkMvSkJXMldWTDc0RjRlNlczR0NP?=
 =?utf-8?B?d0w4dUI0K0I1SC8vOUdtV2wveDNFT2lsMk5qRkFVY2Qxd0YzM3NRSmNXbCsv?=
 =?utf-8?B?dGpGd2JmMDVxWldWOFFJU1oyNXhqV2RyMjZ2Y3BJaUZ4RmhOTW92Zm9ZWWFQ?=
 =?utf-8?B?NS9UbW5Zemc1NWFOK3ViWTFjRzBvdWFLMmVUNElTbmFHWWtXR2dWVmVYTGVs?=
 =?utf-8?B?WU9oeHNBSG01Y3oxQXpwOUlJRk5HV3BtdVVLTDBRVmlqaUhjMEZ2TVE3SGxY?=
 =?utf-8?B?L0ZIdWpIMlhySmwyVkJiODBSMDBTMmpBZlcwajFnYmw4bm95VjhnMW9sd21p?=
 =?utf-8?B?TzZJWU0zV0l0SU9ZWm9KRDVoWE9uS2FvVm1FT3E4VWZLL3dhZ0Q4V0d0aGdO?=
 =?utf-8?B?RWQvWXJCWjA1UEdHT2tnemsxZ21MUEZJUXV1ZTBnbG1rZGNGbk9YaFBhb1Y1?=
 =?utf-8?B?NVdtY0ZqMlNXeExPaEo1MG9Yek5uNDA1eTlVTXdMT3Z1ajF3Tkh6dE9scDBQ?=
 =?utf-8?B?eUdaemhtR3cvS3VJbWFnempLUGxUV3dDeTNUemFENXVwS3dzQnpHZHFJZkxn?=
 =?utf-8?B?dFVBU2RHN3NBTjdrL0htSFpDaVEzZDQ2Rjg5UHdFeDlFaTlyOGprOWFGV1NB?=
 =?utf-8?B?MnkzUVY1NGVCMWp2M2tpbnV2RmdTY3dOVGg3YTVqMnJkWlU3bGdrekZJNmpq?=
 =?utf-8?B?M1FTZGlyeHBVY2RPKytDcUJ4Sm1ua1BLVVdaVmNGbnE3c3NpWnQwMDJxZERI?=
 =?utf-8?B?d1l5SnpLdmJDSmhGeWIxM205NDVCMXNFcXp5WlJiYkJRWkp2NytHOEo1TytS?=
 =?utf-8?B?c1YyZUx4VXJoQjRuT1NzaTlVUXhtQ1cvWHd6SG96V0lVSGhUTGx3N3EwQUlp?=
 =?utf-8?B?R20vT2w3NVAwTVBDeXBIS21iWWZiL2MraEp4NnZ6WjloOWJTUDJ6bmtvdnFU?=
 =?utf-8?B?YmtncDY1eHRBck8rby9OVllmaGxJUUdYdWdBQVM4Nm9hYzFSNXFpLzNIQXk0?=
 =?utf-8?B?UTRUVEZsQmRoY2k2NXRnZ2lWQ2ZQVW9qOXZDdUxpVXZ5U3ZZR1hZNGtSYTZ4?=
 =?utf-8?B?SE4vZ250YnVhMlFJTzgzNWVRNVE0Zzd4S1dXcFpJdGhuQXdmSGRzbFdlQVEx?=
 =?utf-8?B?c1NQZ1ZzaVNBOXNDN3d3bWhyUmNmamxiQnliNE9lUTdSUVRnWk10UURreWZm?=
 =?utf-8?B?ZFQ0UUdpVHB2RGdlcVNBS3k0M3o4cXQzZE83a3FoMDlSMVBPOXdha3NiZWlm?=
 =?utf-8?B?Z1VlTGgwRG4rZHYvMTNTM0ZabmNJaWhPY0ZzVnJ5cHlNVEFxRk5VSzhNc01l?=
 =?utf-8?B?anBpL2JXNi9TZ1g3b0tPTklBU0lHdFU2L1FQNnVnTm1sRGR1UjdqQ3RodmNJ?=
 =?utf-8?B?UWgrRDZBT0NYQkZhbHNkQWRwUnRwcTRxRTJjNUxqOFFsYkdTckZ4amJ1a0xz?=
 =?utf-8?B?VWZka3VSRjJnanZHUVFPQlFjb2lpK1Z6T2hISkpZdExBLzNEc3lLQTJ4MGpB?=
 =?utf-8?B?WEJKTDE3Q0trbDZOSzJCUHU0ai9oRWdlQ0kwQU1WYm9rM0NHdWtack5sbUN2?=
 =?utf-8?B?OW5tTUNhZ0NLbUc5YUpMNXpPMkdhL3dkb0JLeEVpeW9SNCtTUGY5UHZPeDBo?=
 =?utf-8?B?U1pFL2tUQzNVYWNQbkFtQmEzWUIvdzk3eGZSeW4wZUUwbDRsYnlhNzgrdmRI?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fd7937-fe5b-4a99-6d74-08dd00064d85
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 15:02:02.9595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jruP3mqOqcauiuGX0tgQUi9GPnCaszwItX6RVnIAo4nm2oMoCRJ+9HIBDSHg+0zyAxQfWRDU29GdQVLrH7guOqmv0SwNw4peNwKfo0dnLA4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7866
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 08 Nov 2024 15:02:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17227



On 11/8/24 15:53, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>>
>>>> Quirin and I discussed this a bit longer today: We actually should remove the need of expand-on-first-boot to access the key again. And that is also due to an idea I picked up yesterday to lock the tpm secret after initramfs so that we reduce the risk of leaking it via the main OS.
>>>>
>>>> Our plan is now to convert expand-on-first-boot into an initramfs hook that would then come before the crypt-hook, thus would only work against the unencrypted blank filesystem - problem solved, just differently.
>>>>
>>>
>>> Actually that's a good idea!
>>>   
>>>> For now, also for trixie, we will just make the dependencies of initramfs-crypt-hook release-dependent in isar-cip-core.
>>>
>>> I guess this is the patch [1] you are referring to?
>>>
>>
>> Correct.
>>
>>> Just to be sure, still, the implementation of the initramfs hook for expansion will be in isar?
>>>
>>
>> Nope, this ideas fell apart after trying to convert the current systemd unit into an early initramfs hook. We will need to split things:
>>
>>   - expansion for already or to-be encrypted partitions needs to go into
>>     the crypt-hook of cip-core
> 
> ad "expansion for already encrypted": I guess that covers cases like in VM/Cloud infra,
> where disks can be expanded after first-boot / installation?
> ---
> 
> In many use cases resizing the partition should be required during
> installation / or first boot only.
> That's why, I'd prefer having those steps separated and opting in for either!
> Although package dependencies might be tempting to combine those and reduce recipes + initramfs hooks,
> the use cases and options on combining those justify a split.
> 
> As an example to point out the combinatorial complexity of just those two recipes
> and probably there are even more combinations to come when keeping the systemd expand from isar.
> (which probably also makes sense for non (customized) initramfs use cases):
> My current approach to streamline that (downstream) is by utilizing a
> target-bootstrapper (kind of next-gen isar-installer).
> That means, expansion is not a use case after installation for me when running on
> target hardware, still, when deploying on vm! Similar combinations apply for encryption,
> not necessarily mapping the ones for expansion.
> I am aware of the target-bootstrapping/installer approach is not desired for many other scenarios
> (e.g. vm, sd-card based installs, ...) but it already shows a good amount of combinations.
> 
> Apart from that, not related to the initial problem, but maybe something to keep in mind when refactoring/reviewing
> the existing implementation: The current implementation will potentially break the rollback capability
> on upgrades from systems without encryption yet in case of full disk encryption.
> To mitigate such for upgrades of unencrypted systems to use encryption, we must
> encrypt the partition relating to the current initramfs only!

IHMO Rollback should not be supported - this open opens a can of ... .

Quirin
> 
> 
>>   - filesystem expansion may be doable via the existing
>>     expand-on-first-boot if we teach it to skip partition expansion if
>>     the disk is already full (currently, it bails out early in that case)
> 
> and also skip partition expansion if it is already encrypted.
> 
> 
> BR Alexander


