Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F2C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 13:40:42 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.56])
 by mx.groups.io with SMTP id smtpd.web10.8000.1720791632740873578
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 06:40:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Pm50+f5x;
 spf=pass (domain: siemens.com, ip: 40.107.21.56, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwhU4BtBUIJWW8v2t/xwTnj5OtJN5bzSORhJ+9pGl9biQ7JHgRdFNvWCPtChGRVZHMj4Jvhr6rNqF3tjk+Ytr4atOASDaMLU5b5OyPYvinSXCiOSDTO0qyCrf1uzBAoCsVbiyO5VUdDLlcyfA+6kJA+bAgX0xSfhn6+hDl+uGbmOHdGpw8DhtSwnXkmT3DwWApa9tv6t+iLpEFYUIv4CEntkuzVIhZTfcY4F00XwYkq2Dp17u174xUWYqUp810+BTdhS/PV+23rzEHh252z//ZWuhB9eb+CpOoquqDTW12MFNLGYd9LU6VmKMJuep37Y1PsAdNlipK5BO72S8fRi5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IKGwkFXU/awQgLZurBIXRecVzIhW9diTNwl3NEnlYOk=;
 b=dO4PaGlK2MSAqZCCqTUJ4Q+vGChYjKM74d1hgoR0IhHzB9BJRrcKijb9PWwwQMoWojEsOQ8LN9Tj3NfHhEep/OMFbLiR+XsD9XucOznFD1RmIwY/I0YdL9dK3zKxFcL4CvcfwIyX3HwbtjPoL0mFIVt2nwPGiMkx5675rX9nea5SMYJ0ckptUIQrbq9cTg8Lb7zgO7de5tghB8ONPrqSe93Xd+1GrCO5zOdfJpGZzj6pwNAdCFLsi0H4aFFRwBpYgK7QdPdtCNquQQP4hGuoMqI18gtXF7+n5BGYUdrOK7gb4qigpDOMFoFj5CHEyizNNUXPFLquDcE64m6JWen1Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IKGwkFXU/awQgLZurBIXRecVzIhW9diTNwl3NEnlYOk=;
 b=Pm50+f5xVIKtv9MMManAx9SL561uEaT6ZuruPxWppJS5GRPdbell1pr1noBgy5pnkw7UJX/Bquqgk9fV5HiUYVNjgYgkZjWiDrSTunW6d/bRbtLX/jH5a4+6NJi5z1xAW4+csgtm75CF8IaaNHhFIn8M0zS1+7+v7Q8AU97tj7flHz5WBuLXSPxRk07rCIb5xJAT+O6MeYr1C8FyvItev5+TMRBlyeP80LThW+JyRm8Ol7ElC8hNH5EtNefgxWwcK9XwcJyLbMxo8F0MEw9/Ny7D22clcejAPOFaE73OctP/5YJc7ABd5quvCZrkNE3g5JbIpQ4XDtqDuzo/DgaxbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PR3PR10MB3998.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 13:40:28 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 13:40:28 +0000
Message-ID: <93e132c8-3229-434b-98ce-169138889a38@siemens.com>
Date: Fri, 12 Jul 2024 15:40:25 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Sai Sathujoda <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev <cip-dev@lists.cip-project.org>
Subject: Sporadic failures of swupdate tests
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0003.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PR3PR10MB3998:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e7f5a9-21b1-4c54-d818-08dca27830ea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?N0w4NUIzTDVTa29VSkRCVVdDY0h0akZTcWF2ajNYVzBUNzlCWElWRHNjUDZj?=
 =?utf-8?B?UDlvRWRGa3FWMUV6aDhxZnNQNVJNa0xPUGRXUXpkdDhkWi9FaHBHMGtFRjRH?=
 =?utf-8?B?NUFRT0dJUkJDcWxCMGwzZjJQTnhMUlZzcTZwOFlENkdrSXlBdEgrcFYxWmc1?=
 =?utf-8?B?VU5Dem00SVV0OVlvZ0pxclBQdjdmc2tPWjhxZ2VMOHpHOWxTcC8xdU9nTytT?=
 =?utf-8?B?bityV0paTHRNZHN5cG1kczB3NldRTjY1bU5RWUdSRFVUZzJxcFg5ZmFjdWRY?=
 =?utf-8?B?OXpUa0FWUlF2UDBRc3N6YWFNMlhvZmczbWhkV3h4Ri8raWpEVGZLOXdiU1hr?=
 =?utf-8?B?a1dBQVNFV2NzWVFlS2JTUXJTUEYzQzZSSERoUHBGU25SRitWakZvUTZrSnZi?=
 =?utf-8?B?VGlnTHliRzJzYWFnVDVZT3VIeGwvL2VXdE4xSS9pS0VjcTNxK0xUSUhyUE9a?=
 =?utf-8?B?dTRpWXF1bGZjL01vakFxeXJQMDRRVlZQNC9MNHVxMkRJUnRqbjVod1BSMXFQ?=
 =?utf-8?B?bDAxek45MU9STXVEL1ZlRkEydTdNSnM2V21hZXAxb29VSnAxMkxQYWl6VUpx?=
 =?utf-8?B?VVFFWjFjRnpySHlCamNtTWZRblhKNjVJVmp0RFdqTlFYS2ZTSUkrYWhwRndX?=
 =?utf-8?B?ekJWWmpmK1plTEhoVlU0dkFLaHYrSXJyMEVxcTFRSm9YbzBkS3AxbThwYmgy?=
 =?utf-8?B?RUUxVnB1SGdpYTdjT2NNdzAzLzFmeVQxbzFMSFhJRERRa0lBbnc4VDNrRTBG?=
 =?utf-8?B?ZENNdDlxT2R5Ny8ySVUwSWgrcTFucG9CNjRpNndTUlJhV245SWJRcVpKNVVh?=
 =?utf-8?B?UDVzeCs2akJMbVByMktvSVVJMDc2QzR2NlE2ZHJRdWJQaXBmQzVrNkNpMFBl?=
 =?utf-8?B?MG5YNStaL29HUHk1TVNjbHVjeUtzWUtKMXlOT2cvSUcraEZiSStxbHBNaDFp?=
 =?utf-8?B?UElNdEJyR1Q1bnp0Ujcwb2xFNjBEdlErem0zQkswL3lORnl2TUNaUlF5MzFM?=
 =?utf-8?B?cmpabzdIcStHVktZcE5QWGovU210U2s1cmtPUnl2U1FEeFN3ZXlWNVFYUHRJ?=
 =?utf-8?B?dU1tMVRmbmQ4cnRpWUprUG9tOXZjUlJUYnJkVVJNb01qTTBVZENWbHNiVDRt?=
 =?utf-8?B?TVJ6VXlPL1hjOG0rZzVDalRHRmdYYk9IY1kyc3VSODVlaGgwSTlpcnNTdWcw?=
 =?utf-8?B?WFBMT0JOR0R5cm1QK0xZN2gwZjdqNlJISjZHT016a1FEd1lmZmtqbGxlaEJG?=
 =?utf-8?B?alR3SE1VVHJqcTRKN0xobW1MNWhHVVV2U3hmYXRZOFAxOG9KVmhVNHRzdGlL?=
 =?utf-8?B?cXBHN1EzUFFFckgxYjJIazlrVzM4d09aUUNTSUwwYVFtdFUzdHNuQWRSWkNN?=
 =?utf-8?B?Y2JXL2dSTEtwZmJXUlhlcTZocnoyTmJ3eS9GQzBvbXJjd1k4bkRFQ2MvVVlM?=
 =?utf-8?B?ZWkrV2V0a1pxemI0MktXSG1SR2ZQaVRIdTFLTStpWHNaTVZYSnZTTzJwcFFa?=
 =?utf-8?B?TldKT3dNcXJmRTlyZ0FPa25sNkxBZlU5aVYyYnYvaHIzNVdGUU1MYzdzUmdL?=
 =?utf-8?B?UVhLZ2dYQUtORXMvMWo0T1Q5UUZIMFBxck41b3hZYnFsZityQmlES3lHQVlr?=
 =?utf-8?B?b2Nac0hYeW1iU3M1c3FXUkhvOWpIK2RmUThGK29zSm5jSkNRU3Byelgramg1?=
 =?utf-8?B?T0dOakhIVnBVWGh2OURFV28rVFowLzJ0YUZwU1duM2VtVVpubEpLY01rU2pH?=
 =?utf-8?Q?1qSyRUh6MJfd0J2/F0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ei9WS3NkcXFsZHZOSVVUOUpvLzNSbHJWRE1CLzBwVkptQ1FPMmZETEZaNThh?=
 =?utf-8?B?KzE1bkNqV1ZaNDl3U09wb0VtbzRDQ212S3J6bytnNVpGdXU4ZjJoaVhTOEFp?=
 =?utf-8?B?NWRRNGhNVGlFZ1cwRlBYdWU4WW15RmI5dHYzeGlYaWwvRG9tdlRiV0xjdU9u?=
 =?utf-8?B?dy9RbkhWMXFSdnRLSVQxUGYrN2RTQkt1eUw1ZnNhTkkwUzM4QVFLUCtwTVJY?=
 =?utf-8?B?N0N5NC9obW5SSzE3aU5IM04vVUNlQ3NNRDhsREEwMW5mY2JFRFNFNVIrVC9C?=
 =?utf-8?B?Yy81Z3BQT0lXeXpyTW9FclBTeVYvbXc1dXUrVW43UmdCSDdXc0FnVHUvbkRy?=
 =?utf-8?B?MXNaTk1zWURLSTk2ZkViZHZ4VW1FVWdTdDBlaVVGdml6dWhwSkc4NkNYUm10?=
 =?utf-8?B?N0llVEhXd3RrdVlrK1dIMUlvWWQyV21tZDN4UzVFU1JFQ3BUWWF4eEswTmlq?=
 =?utf-8?B?TzR4QzhOdkxjMlUzNHpzaEp5aXVocDVWcTc0VjU2NzF6UTlhZXB2T0gyUll4?=
 =?utf-8?B?aGt1YmxLVllwOS81MCtUR3BmYWdaZHE3bS8xSGp0djBGVmE5UTMzYzlDM0ZT?=
 =?utf-8?B?NmZHSnJDTlR6Z2k2aHZ4d0ViK3l1eU8xcHV4eWRCQ2lnaGptelZOK3VGV3pp?=
 =?utf-8?B?ZS91TC96MStyaGYxZ2FTa1IxTDJleHB2cEtUTlQ3dURZV2xjZmI3dnZiVTNh?=
 =?utf-8?B?a3VwcFlQa09lZE95UmVqK1M1YS9ObEwzdlA4dHk4b0RYMFJVVGo3eWxnWlhq?=
 =?utf-8?B?Qms1V29USXorUDNhK3lGY0JrN0RKYmcwbGF6dEdTQ1BjcWlVN3VhalkxVnRU?=
 =?utf-8?B?ZmdZY05OaDdteGgrdzhMZXM2cmtmRTR0UnVKUDVNTXRTTlZqNkxPU29UeEFN?=
 =?utf-8?B?MFVoQnEyL0F2bm1SMDhQUWRNVW9ZaWhyb0xoQ01tL0srSEh1TzU5a3RmdXFl?=
 =?utf-8?B?ZzlOL0ZNU0tkUmxNdXBiNTFSL2dOVnBzVmdkSVBDaFY5cThxdVNHd0dZOEtv?=
 =?utf-8?B?MmxiR2s0VWhwL3dmeXpvR0ZHRm5kN056ZmlpRWsrYXhlS0kwejNER1dxNThZ?=
 =?utf-8?B?bzVGckV4ejBSOEVWMFJ0OURObFNVVDBlWTNER1dKd2JVVGswNkJSSHJSa3c0?=
 =?utf-8?B?MXdnNEpkcGxVZ0plOXJQQ2RMMFBURzhBR3l0NXUvR0c2THlwRUtpank5Q2hO?=
 =?utf-8?B?cnRZTDB4VnFjR3lNVTZJMzh2cDlKOWZ3elhWMU1uVkpuWDZ5ZHZacWJJU1Bo?=
 =?utf-8?B?eGtmQWh3ZTV3aSs1QVFVam9odXRJdHRYNWJDT2pFS3Q3c09TaC9sODl3RDNP?=
 =?utf-8?B?bkhxSGl2NzNkYk0zYVRmZFQydXhxYUdZTTRLRzQyZkUwekxjcHd2eGJoSW5T?=
 =?utf-8?B?N2VIbkIxeGdJRXJGMUQ0MUx0bVRCZjF2azRBQXRJWER2R1QwaHJ5OU84aUlY?=
 =?utf-8?B?NjJST3pUSzVRUlRhZEpYT3NvTmtKZmZpYmg4b1hFek5wVnhaMVBPUkt4cXBt?=
 =?utf-8?B?bS9Ma29IZFBMcXhxeTJDVFFyaGZQMGt3eElGN3BqL1RqTnpyQVg1eTFkZDNm?=
 =?utf-8?B?U0ZNSmtLUmtoVmtuSjQrb3RFaVJqaFpVaUp1VEt1bEpSd3o3NldKd0VWa3c3?=
 =?utf-8?B?UC9rSy9YUS9BTHB6STlMWjNNdWNzZ291OFA3akgrTmw3cDRQMnVpQUlHZFU1?=
 =?utf-8?B?K0FIeTRjN2ZmL0Q5SC9tbUhPRmJGeWgvNEJtcjRVU25PQXAzeFMwWE9ibEtW?=
 =?utf-8?B?V2J1emxWUHpjNHI5N3I2WnZqY3FtK3ltaWhLckM5LzZGY2RIdGIzOGVOQUsz?=
 =?utf-8?B?aTRySmF0M0RMTGlDSUErRFVRWVQxeVNnWHhnVk0wWU1Vcy9aVWU1UlAzS0pT?=
 =?utf-8?B?Vmh3VHJkNlNyc0ExV0NIb1VZQW5HN21HT1BLQ2FXaVJIL1BWTWUvenQxYzZK?=
 =?utf-8?B?ZDl2WFFQa29yeGlTdXhxUVkwdGlSY2lLanJLSy9UMjJ1V296aW56SnZUWkFW?=
 =?utf-8?B?K2dlL1hkWHBJeStQMUkzM0hPeGlQZ3lBMGl1QU1kV2IzYzdIM0E3MjJoT2hD?=
 =?utf-8?B?N1BYaXg3QXhHS0hMeEFPZnFYQjVkQ2dmaE5UaFo3TzRkYjRleW1CTFVNMlJI?=
 =?utf-8?B?MWZvZnB4N29UYlAxRk1YQTdXZzAyMWdXY1libjlOTml1cGhiSXFTMjhxQlpq?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e7f5a9-21b1-4c54-d818-08dca27830ea
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 13:40:28.1347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vQZ6BKTz59sn4CE3feKJFIrDpKHIXJALPTeahh3/5tzh3j3ccGLzxqsjhn53D9EgJj2yYLUAY019gT1//zJbnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3998
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 13:40:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16483

Hi Sai,

where are these tests actually failing? The also reporting that they are
unable to clean up the jobs properly, but we rather seem to have TPM errors:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477317
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/7326477318

Retrying them sometimes "resolves" the issue. Can you check if there is
a way to improve reliability to avoid any false negatives? Or do we
really have problems here?

Thanks,
Jan

-- 
Siemens AG, Technology
Linux Expert Center

