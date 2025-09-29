Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD5BCAC5B5
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 09:39:34 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.24])
 by mx.groups.io with SMTP id smtpd.web11.49629.1759138771060575802
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Sep 2025 02:39:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=tcu2XcoM;
 spf=pass (domain: siemens.com, ip: 52.101.65.24, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHxlUudw1pc/4hC0JD444ygPBfrWuDNkGZfLkPJY9Qz4lfkElyhDxFkaRfWe9UyZxRc3qIzTiLVaKgelcMdWZpsuNNTWEtWFQlZCjHYfiZirYxEyWpkPj+1n9wz6dcHgYXlcJxuXWn1YC7JY5Zh38CXs28wE7nQ4nhZbnkbZx1yNx5hiBi1Q8RZb0QY3rEI4zF1dN7rv9Hz/6m8S8A3eueNewOFEBi8Q91EPm1GbnZDnTFiY3bjnL97N1yopqWrCDnJAzUKWB8PdstY9xIlKzm6XUFepJkxrjJnqVOqxOxX3gIqIUiITujv/NCZKQ6Nea1gWowwvnHu4+1edtIpr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02YGsOPNRerMlnVGsXipqE7wmXrVIRJmxHY18AB/6sY=;
 b=inrLUvBR04U7INxOox2/ryT3Hv0wgL9hKWs9t8DV8bgqEsdXRGhgjih4dFjMvu3eofu2GW5+FcwBb/6lIbLA/CVWyRP+n4m2xyYHzixX8jVCtAFo0OwZ+o01kGidtd8QisEt9jxORWzPoNCpzEA/JrPV2cKXPXKwyYFVSiBt393d7UpboEoIUJ5fONdlt0ycgWHrnjMQS3pg12DLnUyua9nCDmj+2i7Twd4H5by8gnlAvz3J7XYscBOlZiEGWtg64T610PSbBGV2Zf6Xy0fLn3rDqOTxMZoIea+QamrQM8ch63dyqSHA5/upvlVNuKfwvZW1ptw0xe/bYS8I9v5Hvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02YGsOPNRerMlnVGsXipqE7wmXrVIRJmxHY18AB/6sY=;
 b=tcu2XcoMXearu32nGb3IDdJqUkCsa7F3xudQTHbUcdKwih4UfEFSEUH9MvNAELHCnKsS0dR69FhcFQ39jptw1I65WqL4VADH0Pab2xM09zJwgE8QC38WiU4x5y7dbC4GKSEqUD3F8+SExPO6WuH0CuoT9uF7xUqauqr2keS9/l5BfNp/WMUwkN7v9bB2xcI0ru/drCDp+BaGGhd+x6HUUh5ePMQE8QXc2kcOb0EuGZDapOszDTy7yZWMI/7NMZmEdqovbqe+9wg1aS8LyrqdWici1Xt5WTdztwPo0vLImRncVEM4Kqc8hRrtAFs+riX+NTYOmH/FI3XdwUR0xykAiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 09:39:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 09:39:22 +0000
Message-ID: <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
Date: Mon, 29 Sep 2025 11:39:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e8a53c-94b8-40f0-4788-08ddff3c11e3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?M1JzR0RhWlhSWTRHZDBTd0tyVUQ4OWFQYTBLS1dWVHFjdlM4OEE4dFdGc2RJ?=
 =?utf-8?B?QTJzMk9aTjNIUnRLcTRXdXdwS0VycExOWjlkbmx2QUpta3JacFN2UHhRRWRC?=
 =?utf-8?B?TmJ5ZDNpVjZ2SE9oSCs2SndpRVlzeFdIKzdMSCtnWGJjN3N4VkhzNHpRekxu?=
 =?utf-8?B?UXUwN3k4bDNOdWFPSXlIQm44ZlZBSmpOczFKOW14QklJVkYzclJJcjdJY2Zu?=
 =?utf-8?B?ejVPQ2Y1alhySkQrajFGK2ltRnpLODk1WnJJT2FweEZLcDNueGE0UWtzdVhq?=
 =?utf-8?B?eXZsWjRPVVY2T2hNSzhiV0NPdTVqV3lSbUVQNFpkamI2MHhoeGFLd01XNVFR?=
 =?utf-8?B?NDdFQzdCRVcvNExTNVU2RXNlSURkV0FIZTBsNEExaVl2QjFmT1BWckdCWXRh?=
 =?utf-8?B?L1RNTGpzSEFKS1RiNFZwRXVzVDl4MUtYV2RZdkNqVXJWNmdlYzg5cUtQdVhy?=
 =?utf-8?B?OUxaU0lDMTBHMExKTm8yY1BFU1YwWFNBYUNUaWZtY0M2VVFmVlZzZXlNTVpF?=
 =?utf-8?B?aWQ2ZFB1Z0NQWm82TkRnTUdpTzZYRmlHeFVWeUZ1cCtMTTRGd09uT0hQclNF?=
 =?utf-8?B?SDRuZ0ltc3VPWGNZTytneWJib2ZtditsUmxHa2kxdFlFYUxPdnlhUUovc1lE?=
 =?utf-8?B?R2VXemJOYWVjOXZGMWxaWkNGN2hDcWtNMFdPV2MvelQzcTFPek5YbkFoMDIr?=
 =?utf-8?B?dklkcS9OZEtFRjlpU2krZ2FBZkpqRHZUenhhbGk0c0dCb1lKYUFUVzdEU2ty?=
 =?utf-8?B?aWV2MXJ4Q3dBaUlHU1NoL1BFay93dXcySnZCNXJ6TXlJdFhHS201blNZN1Yv?=
 =?utf-8?B?UDdvbXZtYXRjRU9BVXNJOExJMCs1M2R5aUNiT3l3bVlTN013NmpUVmhmUWtr?=
 =?utf-8?B?dis4YTQvWTFVTXZLNkJIMEtsNnpZakZ6bHlhcG91eEpOaFpueWFJK0VUUENH?=
 =?utf-8?B?cjBaRGRZZXg0aGRHVDluSUlwM1hrMjlrNnZHVUlwZ0dMNVN1WE8yVGloMUNI?=
 =?utf-8?B?aHhKOXVlZUowUTZiM2ZKU2VwZmZDWFI5ZXJwQmJsc0h1LzlHRUUwMFdsd0Rx?=
 =?utf-8?B?TStGT3RqMjluWHAxZlYzeGsrQU5TWFp2eStTM3Nwd1ZybTJLOHJmVTFoZ2Ix?=
 =?utf-8?B?WUZIbTBtVkNhL3lBMDV3bUthczJrck1LTmpjeE9LU1V3U2sxVzY1aEJHQ2F4?=
 =?utf-8?B?TU1pcEY2VktKKzJod0JzZzJGMlV3VmY3MGZTMHBKMDFXaVBNOE5FOW1XR3F4?=
 =?utf-8?B?QzUvcjJSVFhKSXlZQmxZbFlhbjlMV2NaQTc2NTQ2VHpnWmtaUnJnb1dYLzgv?=
 =?utf-8?B?M1FOVHBNSkdHckpmdmVLTUIwOUZwenNNNlNxd1pkL2tiT2JNc0Nkb2lUYTZo?=
 =?utf-8?B?U2FUaGZTTzZvKzRRQ29hS1dGd0hZNUt5ZlhXNzlMNEJmM0hXaVl1aDE0ZW1o?=
 =?utf-8?B?Lyt5VU5UNCtnWjFNTDFvWFlEWTRoUHBWN1dDb21KV2sxY3JWR1FVWTRaQXNr?=
 =?utf-8?B?SG5xcXJoN1FCKzhRRXRzeWNrblZ1Y01hNE4rUVhSSnZNOTZRbnZHd1lkTGxW?=
 =?utf-8?B?eVJZSnZ4Rm8vVkdqN0o4ZXFyeG84aVQ1THl4aUI0eFFUOWVEV0o4bHdFRVBW?=
 =?utf-8?B?Q3Q2cWlIM0FiK1NVTk82ZG9NQmNoOTZvcXQ4NFhNRmQ5WFUvOVZocFhHUGZv?=
 =?utf-8?B?U1ErYXNyNkFBSklUeHA4aWE1QmNhSG12dEdGRks1V0NoUEpGcTlCU3g3NzZs?=
 =?utf-8?B?UFY2b2pOU1kzV2l6ajR5OStDU2x3Q1BuMjgvVXFlTHF1MkZjTjRRbG9tOHZQ?=
 =?utf-8?B?dTB6M1ArRWkrcXd6empyNWVQVHRWSVRSSzZlUEtJdnllczFXc1hDaVhmSmwv?=
 =?utf-8?B?VXFmdUptVHYzd01VaXFTVjQ5RWFrNDRTaTh0NlJpZVBHTmc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bWRVSTIxTlExdkFRVHJKS1YyK1lsZjdkYVRteWR4WWxVMVdHMDdHWDM3bzVW?=
 =?utf-8?B?MkNTT1Y1VGNnQUt6S2d6dGozaGdXNkJkR2xjMEJtc2JaRUNpbzcya2NOUnZ5?=
 =?utf-8?B?S3VnZW1tRWRqNDk2ay9YQ21yL1F4RVBUeEdPN0lFNDJTaHNwcnpZMjc5YnVk?=
 =?utf-8?B?MlVTWFpvRnVGNzg0U1lUUmZSQjJ2MU5aREEvWFZBSkNQTlhmalFnSGFpL0k4?=
 =?utf-8?B?dDRVUi9YdXJ2N1lsOERrL1lGaitnR3piRDJnYVBQcHRqaXpmZDRrdUZFWGpr?=
 =?utf-8?B?b3pzL2lxNHIyY042SkdhMDdMeG1RR2lnSjJMMDNlTjdvRnpIOXJYakxabkVB?=
 =?utf-8?B?QVhQR3JkS1hpUXhFSkJkbi9HbDdFVVFiSnRxVTR0YzVybWdKUmxydUdORHR2?=
 =?utf-8?B?bFROeUFhOFFtN0o3NndqbDBMTnMwTC85a0dxSXorRDhEOGxkY2hXbjBzeGk0?=
 =?utf-8?B?cW1ZMk5hRk5mZHhCd0hNZnJjUUwxVDZCRlFWMGcyd2Iva2l6V0E2MVVMRWcx?=
 =?utf-8?B?T0dsekdSLzBYRjZmN0c2T3pkU0VNcDMzUmtMODdOSkFRQVRBUnRhUmYzV29i?=
 =?utf-8?B?UWJ4bC9oaHYrb05CTC9udGZRbTgxM1d4ZnBvODNhV2JoNzBhSjg0K1ZVbGJD?=
 =?utf-8?B?YXROOUpyb2x6cW1RaElPNnFTb2NtZytWSmtZUUtQTGxSR1NXdTByV1l6cUsr?=
 =?utf-8?B?SFJncXBicWgzbk1ZcW9uc1dZUnNUdG9GR2R2N3hMSEtlbE1HbmIvV0tnVUo2?=
 =?utf-8?B?TjFXZ1dRdmpRaTNCM3ZaMTZvcXhyekJ5dm84eXRaRWh5c20rZWFvcG5hR1gw?=
 =?utf-8?B?bWo0U2JGSUJva2NnNXJqRElMeFgzNHFmL3QyNVVJTmJ5cThkS2ptZ0czeXhQ?=
 =?utf-8?B?cStaeFBNUjZLMVBZYmREZmluZzVMOTgrdEptZlU4MXB3YU1SZEFBd25yVHFJ?=
 =?utf-8?B?dlhienlwUUU0Y0hhVW9zdU5wNlQrTTBBNWZoVW5VQTFpeUxQbitOSmJSSEtm?=
 =?utf-8?B?c2NXZUhzRy9aZGRvKy9DbGdoQ0hTeUNFa3J0MGxhRzFDaHZGaThHMjB6NG04?=
 =?utf-8?B?b3NXZWhLQ1RRdDJWTkcwcGZrak5EdjdYWXhJckJzb1hsMWRkU012SDd4UE5p?=
 =?utf-8?B?QTZRTFhxWGlPdEcxU3MwQ2UraDdSNUtmTWZaVi9FZkZ1L28zZUFYTXJEanpB?=
 =?utf-8?B?cFBDY00zaTZReUZwTlZMSWZGbmV4OUJmV0FxV1hXR2o3T2ZKYWFnREpvajVQ?=
 =?utf-8?B?Mkw0VFprZTdPWlJoTHhVM0orQjVOaW9nMHZOUUJodzN5eTF2VGQ5Mi85a0pm?=
 =?utf-8?B?K0VxRExSOG16VmpZR0NjVWVYT1o5cTBtWlNidTloWjJSRlZnd1FiWVQxeFFM?=
 =?utf-8?B?R0JjQ1RTMnBXcGp0d1FpTG9FV3hvOGRhdjhvZGRURXVTc0pTZlU3WEdaSkFT?=
 =?utf-8?B?cXRPZ1E5WUdLei9iN2JmczNPWlpwQTNBZzFWSTA1ekZ5d2RPRTFhUzZEdFRC?=
 =?utf-8?B?ZjdxWDFCNkhWc0w0a3pxeEFYd3IxZWJ2UjFJVURLZU9KdzZqanJodmpSNGZv?=
 =?utf-8?B?UVk4VDVlVkVXcFE5NmZBUkJSM3ZCcmo5Um1PUmswcUlaUjJpOVhiaWZBTDBY?=
 =?utf-8?B?bHhNUjZPYThib2RvQUwvVCtQWDBqK29GZFJGUzRDcDNGN3Z2OTJjRDd4Z1dz?=
 =?utf-8?B?U3pUSFF0aCsxRGYvSDZ0WVZlNmZSNU55M3hkd3FYMDVRU2NDL0NzZGVIVG83?=
 =?utf-8?B?ZFJEV2VhSGpoK3ZBTWNsVXJTWEtjeEtIZUxmZ3pRcXFWUGdxRVVpREhlN29p?=
 =?utf-8?B?SlRsMnoxQ0JwMExYeGhta0VwYzZxelMzZEtvWGoxNU5WbTVzSDdlcEt0ZVFT?=
 =?utf-8?B?dWpYamVVWEZ4V3RYREZZOTIvN1FzQ3Fmb2llcVg3YmRJRGM4SmU4ZHE0N3Mx?=
 =?utf-8?B?ZTBYVXlWR1VsUWhwVlk3bFhkUW5JN3lwRTdiTkZDYlQ5Z0VBNGFXKys4aDdE?=
 =?utf-8?B?Zk1XUjRwUlU4a3VrNDlmU0FqVmZjcVZybW43SFg0RVg5OW1VR0tXTG9RTDhl?=
 =?utf-8?B?TkpCM0pCMDc4YUNueUx3amVXYlE4OWgyYmlWUHQwSnB3OUNJaDM0TnJlY0tD?=
 =?utf-8?B?NElaVTdwTUdGMTBCZmlpeDdDejlUTXRQd3g2QldKdW1Vbm9Cdi9oNldPbGlw?=
 =?utf-8?B?Nnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e8a53c-94b8-40f0-4788-08ddff3c11e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 09:39:22.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lc8ALBGcAHiwsJT2h1U1RyhPC0+kOriZaHcWg3tovt8TlCc1Jd7wjOJkMCWAij0+Vmvv8SSHUGBBGmp0jswyBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5618
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Sep 2025 09:39:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20149

On 25.09.25 17:26, Jan Kiszka wrote:
> On 25.09.25 13:34, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>> Hi Jan, 
>>
>>> I'm already running a test with
>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/e4cf71701983e3cb12f19efe9c217f500b9b0868
>>
>> Ah, ok. Thanks. Hope it solves the current timeout issue.
>>
> 
> Not all issues yet: https://lava.ciplatform.org/scheduler/job/1310661
> 
> Will retry once more, bit it feels like our target became "slower",
> could this be the case?
> 

We have a problem with the on-device IEC test now. Retry didn't help,
and it rather seems we are handing during the TC_CR2.6_1 test:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11513053235#L2101

This is a release blocker until we can rule out a regression in
isar-cip-core. Please help identifying the reason!

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

