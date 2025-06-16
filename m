Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C67DAC71136
	for <webhook@archiver.kernel.org>; Mon, 16 Jun 2025 11:12:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.40])
 by mx.groups.io with SMTP id smtpd.web10.27866.1750072317666409055
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jun 2025 04:11:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=geMWZpMq;
 spf=pass (domain: siemens.com, ip: 52.101.84.40, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvOTz2OLkMH+6wfax/Hi/FN2G6Z9929/4dB6gObXTEjrEEvHQxoUsqmrhE8TA3TxKaCJmEy7SWzSFB1tZzSi4LoG/+cI9kNVGCLC89rQAHar/WPCIiA8WEmQ9lLskktWFFsMlbucPMuiCko4OqTTr6j5FgAoDecQXb/LfXhg0Ocl/cT4Tvq4UuaX0E4I/ZZqq6KdRdWIa0CFVigPFJFyBJXcPq5G5V9rISbOLdcql1FIA+wngsEGTrV2wVPx2HNG9Ut4Q8SjwmTlUTf/c40Mya8wJmuPN3DfX7kzNQQMc2amar/YVzTpflS6TmCOw84e/Zk4TjAIDJYZ/2oFLYUeLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ad46HhDyZjbkQLwj/dh3E2ETLe0jOdc7MrBdSNN5WaY=;
 b=jAzkNG1tv763Uxvnzc5DhH4QXQ+zyR+frEPxMukuEh9aDTcKGBxw0x2T+C87A9AaJaV7jgDfLj9q88ANTJV23smbEYZBnViA40K5bt+Eydk5Wx7qPKmFE0x94Go8Q9mo+VfR7BeRcGsWe54lGoVEovCc40yPOvFQpwQhC+UFdlEMf+erl5JmBiSBirnrbas2DZ1/fmFE84H5Pfg61RZeUCID/wz9/B0x7cpwpqvcDVVdWXeYrqB95WMK8eBzzTcLyoQYAqHAa8hYV52kMZEa/PdyjUXbNQ/2hykUqWkmshJXWWFR2aXuZxxnguo2SLSb/+Mh7YQYq9qToVe32upGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ad46HhDyZjbkQLwj/dh3E2ETLe0jOdc7MrBdSNN5WaY=;
 b=geMWZpMqAEAgO50N7+PhyRHOzKPgYWk2cP7Gp1NAFys3XaO7QNITKMi8DDBOVRNRy/44ANoR5lLluhFdPpirZbirV+k9hN+jUgQgt7ghDBaUJIzU5ZjoXlwQTqpY6pPMpsXJmC91014t5Va6XtfBvVvwsNdowOiqQLiiW23qyWpuN09GdRIsz0uoQFFSsS317mxZSDnBBZXYLHYUzQvG6lzT+RglMO5ew/LGWRVr0DkUkwJ3nnXEFBJSarVvjZNEmTLlmeRCfO36t10W/YBV6oyNS9L8za1mcGWO1GiBKWo+fbbv8kV2ml/ETbBDa3Q9D9ZRCy8xOipLNyJKyhczNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM0PR10MB3297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 11:11:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 11:11:55 +0000
Message-ID: <201dcdc7-c272-4201-8180-ced6c0073c82@siemens.com>
Date: Mon, 16 Jun 2025 13:11:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/4] initramfs-crypt-hook patch
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander <alexander.heinisch@siemens.com>
References: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250320-initramfs-crypt-hook-patches-2-v6-0-ef10c11cad94@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM0PR10MB3297:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4a1db4-d897-4037-3aec-08ddacc69a31
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SmUxdUhENlhXWFcvd1lQK1JwRUo0REFUVHh4OFN4cXN1eko0MUZMT1hYdEMy?=
 =?utf-8?B?NzFtL1JaSCs1cVlhczlnYUtSU1ROTEdzanFlTVM4NlRwQjE4eGpKM2ZZNzdJ?=
 =?utf-8?B?RGlaMFNKWXlqSmRIVmQ1RVpoQklBUE5oM04xR0g1bFNlWG5SaDdBZ0lCQmQ4?=
 =?utf-8?B?QnBFWEgwYzBQWFUxenk3Nk5pR1JUcHVoOGVRSHE1ZFV5cFVoTzhuUnVwMkNx?=
 =?utf-8?B?dGxNL3hRc0ZseWZMM1ZVUTVxVUwxV2s3Wm1rWlpTQkNoaTh5VENkbnFqY0l2?=
 =?utf-8?B?aW96NHo5NllSSG45VFBuMGlEbXlFSEhWRjJwdnpCMWpFTTRncEdjY1RWaUNV?=
 =?utf-8?B?azI2MVAvOUJQVnppdVZWT3d1ekYwZE1NbzBVamNVSVBIRjZub21xM1hnVmtj?=
 =?utf-8?B?MU9YakNzRTJPbndHcjFZaUY5SW9vZlR3Z3pMVmZLOGtzREFmb2lGNmJoMm5a?=
 =?utf-8?B?QXA1MGw2ejZKdXMxY3pqcUlUNGNTWlMxTEFBS09rYUJQTWlIZFFpbVIxWG5k?=
 =?utf-8?B?dGdidlZkRFVQV3Jvck9UMjJMcjRzbmdyVXFHakFoNW9XNkNjWHZrZ1lGOFZz?=
 =?utf-8?B?YWFrd200eXNBYUh6MCtyWk04c2g4MUlsS3BSWjZUeVJLWThkWTN1aEhpNXIr?=
 =?utf-8?B?UCtCR2tZZ1krZ0M4ZFlFK1hqSURBV29RejZISCtpZHZTTmZ5ZUhhUkpNREJq?=
 =?utf-8?B?RnI0NEN1L1F6UUNDb0dkMEJXU0dBMTJpckE1R3ZzaXpObkcrRlhaZDBmdmd2?=
 =?utf-8?B?NTE0TTFWb01mRTRINDBjcmNwRU9pbzhLM2pINCtlS2IzWnMrMThPc1V3LzJB?=
 =?utf-8?B?dTNyQTljVXpNdGZ0VS9VU3UrdzE1NHQ3SUJ2TnFLVExJSnpwalg4eG84WWNM?=
 =?utf-8?B?d1RLTk5INnZ5WERWYUdWM0tVcEpRbWJGSGVNVlMraDYxNk1xK2xydjQzWDNJ?=
 =?utf-8?B?S3N1UWxFcTNwRUE1UXY2c214YjAwVU5CRVFsSndpTXpGNE1xK3ZLeDg2MXFM?=
 =?utf-8?B?RzdsR054dEVSQk5DTzhEeU5kakpxRHlGYWpaYUsvWFBDaG03S0R1WTJBRjhH?=
 =?utf-8?B?SGNUaEQ5WlhZbTRFWGxSN2NiT1ZEcHFES0VBS1lLbmZGNU5ERnRtbnFjcm4w?=
 =?utf-8?B?U1I4MzFSSGVyVkhHNWdNNU1uUVZZclMwSjJYenN1V3pmRWdtaDdONUpwVFVh?=
 =?utf-8?B?Nng2bXdqdHZmQWU2ODNzT0JPOTRKRCsrN0pEMEFmWjIrd0JMQnNweU1ZeHJh?=
 =?utf-8?B?N3JaeFZNWGh1aTl5ald5TTBzQzFZMlJoSlJuKzBwOVo0d1RZcnZVdnptOXN6?=
 =?utf-8?B?ejh0NFJ6alhwOThyT3FuTlQ0TGlUd3YwRFpjdHQ4ZDNwYnJ0bHV6YnJqWHFa?=
 =?utf-8?B?WXFWcFNHZVpkaGpvSFdiSGxlTDE5eFh3aFdlR0tzSXFha1FyZXE3d0JvQWV6?=
 =?utf-8?B?emVNN2w0ZEJRVzFobm5EVGYrYldZQXlMRXo2Y3E4TkRrM1IybG5ETXNEWEl5?=
 =?utf-8?B?VXZTS2tKVTVJTmtxZ2tOSTQvSnpMWUYzaEN4bzV4R3Q4clRVZzcva3p1NUE3?=
 =?utf-8?B?SklmblhZNFV6RnI4bm1tRDBIUUZja1BLLy90c2ZJd2F0QUxhVGhyQWl4Tkto?=
 =?utf-8?B?KzRpTlpadlAvY2R1TU5PdEtyLzRtR2JNUGwxMXRWUmNERXgwMDBYbHRGQ1pG?=
 =?utf-8?B?NkI3dzRzaDFueXN3UENTSHEvcG4rUHBFOTRUUkxORlhmeEVFNHY4a0xWMHlU?=
 =?utf-8?B?a041d0xtVy94aEgwem56SFAzMW1PVnJtK2lOUUpBYkNQNGw1OU9MVnpDait0?=
 =?utf-8?B?ZnJxNG9jaDdRTHp2WHNLVm9wdGJGZFBJa2ZyenI1aTNGMnY1RFlyWlRrZDIr?=
 =?utf-8?B?czdSeU91ZWF4eG83a2VKUEIveXpZbjBWSW9qeUpZNTJEU1daMTl2YmxOeEQy?=
 =?utf-8?Q?Q9Tw38bi5oM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2g3OU4rTnl0UGtGZ04vRFNJWGdwU3R1d3BKeUx0RW5QUWN0bHBVeU1vRWRj?=
 =?utf-8?B?djEvQXJlZGpXL3FzbGhucCtrb2xzYUcrWTltR0NpbS9SLzRFRG9nTFgwcDNE?=
 =?utf-8?B?WlE0bUVvZTVBdStreUE1UDRMQ1J1N0pPbU1MeVgrNlNWdDZDM2VDMUJVb0Zl?=
 =?utf-8?B?VURWREU3QkV4TEZIcFc5YkltN2w5ZmNtRm9wWnMwUXo5SmxES3hCb0NwT3Ny?=
 =?utf-8?B?Mi9tTzBVMXRaZXl2S08xd3NpK1R3L1NVRkdWSVF2NVB1V0NvQjdicW1zeGtL?=
 =?utf-8?B?NGhLR3NLTm5FYnZUU040WjJXeG1xTjQxTFRGUlVieXhCWUJQTlgzeTFpODZi?=
 =?utf-8?B?eU4wU2s3Vk5OYmJOWHBCTmVsTG12OFZwaEdVbVhKZFNQTVRFTlZxOTdsWTQ2?=
 =?utf-8?B?Z0RGTVU0U0ZpSWRKNUZHeWJkNEtuQ0diY3dWVFl2VXczL3l0SHViRmU5Qy9B?=
 =?utf-8?B?Tzkzcmpvb3I1NHp1ZE5EU01TTVZVMDRiS2x1Rno5U0MzVTk2cmpqR2M5eHJx?=
 =?utf-8?B?cEd2SDIyWE92RmdZaFVHYy8zV1IrTmlkK0NCZEljbTlxdFhOZTg1S2hCdHBa?=
 =?utf-8?B?aStha3V3cXUxWWladnVmT3Y2b08wUmlyUnlqQU4vRzhPTVI0NHJSUmFrYmRz?=
 =?utf-8?B?NnpTVEM1K292cHRYMmhNV0haQ3NPb3VVQ0RZMklNMW1SQk5WcHNFNzdOd3h3?=
 =?utf-8?B?dk01OHBZTHRBU3RldXNqQ055V3BUZnljWktWbE94OXlqK3Z3UHZ4dlZtTldS?=
 =?utf-8?B?VHVMU044M2pGa25SQmROWHFybnBTRDAxZUYzY1Z5dTdrWWp6TTdMN1loZW93?=
 =?utf-8?B?cnR4eEh0UzlBQ1pTQVE1enlueDliYUlvZUlQZTlmY1dVclVUR2NVVk1mREhs?=
 =?utf-8?B?anhseGpRQ0h5Q1lTUytYdUlWVVRTRHZXbER1UEJQUlRKZE9GNHRZb2k3N3dz?=
 =?utf-8?B?VGtuV29NV25BYmlLZHVMY3BBU2JxeVQ0SDF4OWRXS0swTktlMUNmTWlXKzJh?=
 =?utf-8?B?QzBSWUJBTzYyTk5pK2ZlbEQ5OC9PeWlwYUNvSHdOQ1RpNWpSMzZMNmFuTzcw?=
 =?utf-8?B?c1JIYlpocmRKRFVVdU9rMG1kaVNwZy80VzJxb2tDRFM5RnlsUkFRYXpWQ3RP?=
 =?utf-8?B?NU8rcG92TmxGeFpzWHdHbzBZUlpwTWhoUWUvU0dtQmcvZmorQm16Umw3SkJO?=
 =?utf-8?B?cmFKMWRySkp2bjFITFdWMG5KK25hN3paaHM5NVc0NzB2c0VERnNjc1JiZDBz?=
 =?utf-8?B?UzZVcnZ6ditPcm4rN1Q0MDdUZjFhdzMwWDJwblFjMDZDVEFESGdYNW04aU1j?=
 =?utf-8?B?SUdiUVVNTWp0U01BbENEY0IvY0tISkFPRStGMW9aUEUrTGhjL3lNR1RjRWgx?=
 =?utf-8?B?V01Tc2s1NGc2U3dsNHhDNzdFbFNOMUpQRFRiSlQ2REg0TDEvUXgxRU5LcWV2?=
 =?utf-8?B?TFRoVk1EdllKdDNsTzBINHFOdEtmTG1SaTgwVEFPa1l4bkVFRXFmZUYxOVpL?=
 =?utf-8?B?U3J6WWtrUkpXQVlKa29TNSsvZDF3KzZPZ2g3RVhLdWxIREZUT1R3bUNKKy8z?=
 =?utf-8?B?dEFnK0RhOGIyWWNlWWh1ZjRkWi83VWxzcnBsUTNoOWJTb3VJQ3NPMkU4Wk9D?=
 =?utf-8?B?TWoxcVVFbm1YM0ZUYUx0bjR1WXNKWHlXK3owNUFvUVkydzhCNjhmcVBEandQ?=
 =?utf-8?B?OVp1R2k0R1d3ZFY5Z3QyanNqYlpmdzQ3d3FpS0diOHB2SW42MDA1SzJCZTdp?=
 =?utf-8?B?LzRMN1J1RXpJL2tGbkdPTjg1WXNIMjY1RncxQmN0cE11WVNuUWNtTjlRR2Zu?=
 =?utf-8?B?ZUc3VmdiYjlyR0ZCVmtBWEpOcmpacGtQbnFYQTdIRzlsSy9yTzhjSHVhLytT?=
 =?utf-8?B?cG1BejdHYWFMRi80T0p2d0Z1TnZXZjZtSEJJajhMNnE1bURPN2ZDSVFtTE5a?=
 =?utf-8?B?dWZqL1pLcEF1a3dwS0REYVRpd3lyN1pkb1NsVlA4TE5TRlpLWjdmeFk3MWNO?=
 =?utf-8?B?Mmp5TUpMQUxNMFpRcm5tUUZrNS92UVZWcWt6bURNMUU1aVFwdG9UbG5uS2NR?=
 =?utf-8?B?VkdSMmorTFpLR1plQk9CazJIR1BlM1lyeFNmQmJnVm5uZU94L1J3N0ZDRm5N?=
 =?utf-8?B?cHFvUkpvRGJQZ3l1MHRUWk9IM2FlKzFKalcrcyt2b1FrVmY5NERidURCOFBM?=
 =?utf-8?B?TXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4a1db4-d897-4037-3aec-08ddacc69a31
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 11:11:54.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: On3X7I2n7mtcFTFET/foxIbVqAGxB2h3x5NVGwHgWXFxqbpvzN6W2tzlU3UTZk2Irr9+Fossqoa94mUiwYKb3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3297
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jun 2025 11:12:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19107

On 20.03.25 08:43, Claudius Heine wrote:
> Hi,
> 
> here is v6 of my patchset.
> 
> I fixed the issue I found in the last patchset, now the `format-if-empty` process is a bit more power-fail save.
> 
> But I suppose that if the luks header could not be written fully, and the `luks` fs type is not detected, it might still cause issues, but I am not sure I can prevent that effectively.
> 

Did you document that potential catch in README.tpm2.encryption.md?
Didn't spot it yet.

Please also bump the recipe version after your update (likely in the
last patch).

And please rebase on top of next - I just merged the tpm2_shutdown fix.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

