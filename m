Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088F2CA0FFD
	for <webhook@archiver.kernel.org>; Mon,  1 Sep 2025 12:43:10 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.30])
 by mx.groups.io with SMTP id smtpd.web11.50297.1756730586494262019
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Sep 2025 05:43:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=jSr7AVOq;
 spf=pass (domain: siemens.com, ip: 52.101.72.30, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DMaxiz/h5R0tyovL5ZDjjqZJuHVO7jolE+nuoVUBuizLzlkGsZ+fjP0qqsKkpsPfwBIw6qSS3wzBpkJtTFWEyZM5yhpngzR9Ps7tOiUJaQdPsbw/5GSlh+53ITpUv66RICuRthwOGh+AHs8Lb4nXpNV2kspwKfncqLYyAdbgZjM65M87ZHW316MlgTCA9IpV+OlmhFcEu1eLhXLqRn5d+Y+EqFJdUSe/Hh/4uXCd0TLX7X1FN5ixLB5CtJn6u4VDvoXlNx9PNUha3AOwdKTE/UrgkFlhTTxyiyjXxVx1FDsqtGy25m5pF6U0E7Ayx1mVlxdfWjEtE4jp+E5OS+NfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAP1IZlDtz4LQuUbxZbIF8mHC16w/6JD2TWmM44oKM0=;
 b=EhMH7PlGgaHrwSHC1tJEEHhUWPVhaIW6SrOMusMSgW/e+7o2wM2VNPYcwIL3Rj17mqVYJ18oc4BsS1LQe3aTUrYjmOp10ec0ThKmhLNdOWRkFG9/cTPkAPmOhptntpR94wRgvDq4NbRGvTRg3uMIr9vAIyoyOPMXi4iZNXTU08fnoQ0z520wjDNmFqFjCLXTRtPjxOB/EdpFJrCBlttgZ02dVvNGaMfyg+cWYk4RwcAg9OL11YJ5iw96MM5s+IBLwBFTOWZSOXF3+4NUHi0cpRg5AZzzk1jZxs1T3qBmBXXs4snx06j9tdNEbBsIaQhmgDKvYFAWPZ13NlC/OeOZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAP1IZlDtz4LQuUbxZbIF8mHC16w/6JD2TWmM44oKM0=;
 b=jSr7AVOqJba5nY7jlgPypx604GQmN1nWEWgeppENoI9w/ni/AusaE8JrW3X5Jtk8f7d4p80GLLX376qTi8M+2TdFZv4HpML03Q1kkqr4AuTl++W1+5c2KrHqWjDK7W4DdroSEq+CcRgdrxtHNH5BjnHf8yvjIUTDRThCLZVMWb9dqV1QzLPrbA6p5US+jF6kRK7KMi/zs3uGi/KJAvlWBCLRUNaNscf989mTkfbKsCXZh/fJOO7xe0RoIEwHxueCInJkbeojDMRVC2T3uSAqW/s+4CAnWrR0nQJ5Sbey2P475+QGJfFt3mP79L2+StLHby97b+Q1wj8JIZJzoFU/QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DB3PR10MB6908.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:431::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 12:43:02 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%3]) with mapi id 15.20.9073.021; Mon, 1 Sep 2025
 12:43:01 +0000
Message-ID: <5fa10a39-0fe0-4b82-8ff8-951ac4896e7c@siemens.com>
Date: Mon, 1 Sep 2025 14:42:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/7] Add factory-reset
 initramfs hook
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 gokhan.cetin@siemens.com
References: <20250828110712.392641-1-Quirin.Gylstorff@siemens.com>
 <20250828110712.392641-3-Quirin.Gylstorff@siemens.com>
 <ccd932f7-27e7-48fa-b0b6-5e19881a8f8b@siemens.com>
 <37ffa0d6-9591-467f-922f-4201358e9d48@siemens.com>
 <7daa0b69-64c1-425d-b090-e6b694ea4cc3@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <7daa0b69-64c1-425d-b090-e6b694ea4cc3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::17) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DB3PR10MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 23fee1ec-34a7-4f3d-300d-08dde95515cd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RmVyZ2w2bENZMjJteUhRL2Q5RFpDVkRYbytOOHJ5NWhrYnByNlcwbkYyZklX?=
 =?utf-8?B?SW1lTERNZmxFNzFGM3ZRRHJpTThyS3hmMGVLZ0MvTnNHa1duK2prdXo2VFht?=
 =?utf-8?B?Q21tRVgxU3daVzl1K0xnbUxlNWxZRDUraklVeUFJaUdYbUl0QlFvRG5vRkI0?=
 =?utf-8?B?UWh0eDJLWnFSQWc5MmQzUGpXRGNhYTl4VDF3VWNleWNzRy9hTC9pQVo2Z2xp?=
 =?utf-8?B?Y2ZVYUliZWFucTcyY0kzMWJjSDRQZXptT3NpZi9RQmVGaTdrRnRoWDhqL0pq?=
 =?utf-8?B?SFhmTmVkSFppejlSNDNXZmJYNjVMeTV4SUxWOTAwZ2ZmVHZOTFdHMzFNM3Q3?=
 =?utf-8?B?ekZhT1JrRldCR3d0Vms4empNR0QvaThRdzFidmlwb09ZUmx3UGFXR3RvN2Vq?=
 =?utf-8?B?N3N4YVhrQ2xta29YTW9wZmtjZS9Dd2NiNy9ORlZvL3pjN0RSVWdGeUo2cHVw?=
 =?utf-8?B?OTFuM1B5UUlUQy9UemQzNUpWYnRkaU9oYnpFejRiRGJWNWI1dExCZEdpRGdo?=
 =?utf-8?B?OHRuSEZTd29oSjRmWk5LU1VOUU5QdFlWc0JxRFgxbUc4Tm9hR2E4MmZIMWJS?=
 =?utf-8?B?VFFPeGtyS25MUVpQRmVrN3JJdjdIZ2dSUFRnUmFrWFlhSmErOWxWSzlGd2hL?=
 =?utf-8?B?OXhFQnZZWjJra1AwbFdqRUN3bU03MFFkWlpWTGozT0JuWVI2eldrWm1URjlK?=
 =?utf-8?B?MDFHcjF5RnZjZlZVOGxBendKc0ZZT2JJaUVRcE5tZjBDLzlwTDJLaWdmRG83?=
 =?utf-8?B?ZUhXdy9oNG1qV0lLRmJwYTJWRk5rdFkycWtHZUYzd092U0s3amR4MVhha1BF?=
 =?utf-8?B?YUVxRUU5d1dURldlWTYyaHZLTlZNZkZiZ2ZaR0RSdGtCdjd3R0ZDZTFicUNv?=
 =?utf-8?B?TXUxVUNJbERUWUtXWUhkb25nOFAxampYODF2NkNDdEpQRGdOWUc2bC9DR0R0?=
 =?utf-8?B?aHJ2UW9DeWRvTEgzb0V6Mjd4MVMwRlhoVDZUMXlmcVRmZGprZWUyTWhtYzFQ?=
 =?utf-8?B?NUdiRzlkNlZtWUZaU2s3NkNoVnFweVlMN3NNVDRjRVNnTDJvNFhQNjdCSFU5?=
 =?utf-8?B?eVB1WWJLMFRzcHBXeXlQMXdPWDFyM1MwQjVlaFZ2K0N6VEh4enEyTXg4UTVm?=
 =?utf-8?B?UE54V08wY2R2TXl0bk9mRHFwNlREMGc4WjMxeU80TTVBTmc3RFVWdUZ5UFJS?=
 =?utf-8?B?SWZHeHg4WWFSekZvSEdDWHpNUDNkSm5QM1BheDljUWljY2llb05pclVSSGIv?=
 =?utf-8?B?RW1BeGlRYjB1TUV6aVByWmdzNzJ3MjkwV3FXRDQrakQxb3lTbW9SSmZRUlo5?=
 =?utf-8?B?MWR5SitQTGlvNUlQVnlGL2NwSDJ4YTJnRkNDQnpzcmplZW1OT2Z5TWhzMy9F?=
 =?utf-8?B?ZnIyQjJqKzVaM0dRQmRwZTZPT0xqV1U4TkxQaCtiWjhoTWlnejRUVk1lMS9S?=
 =?utf-8?B?SzJQZ3EyQUdNbDRRTzJQYkgxTlUzWVB6MDFpdHNvSmU4T2UzTkIxdmtka25a?=
 =?utf-8?B?YUxXOFhEVCs3ZEIxTWtXdlQ4Njh4SUMxeUpNMllJRUoyNzMwRGVuRnMxSTll?=
 =?utf-8?B?NHBNeTZ5TW15cEhjV0ZEQjRJZkFDQ0d4eVdMZVcwR2FqczJJU1lRQ2pJVHhM?=
 =?utf-8?B?OE5MVWNzK1JkcmdkSHZ4UVNHQ3NGRW5KSkIvcTV2Q2kwNzhsa0cwUFBDUjFR?=
 =?utf-8?B?VWtnYS95cVpPMHVWUThCNHJOQTArOGw3SGs2S1NWQjlWc01vTWdTakhITjM3?=
 =?utf-8?B?S1d0ako2aFhsSHlIaEdxQXpCN204Ti9qYmlwSXF2VnJWMCtGU29MZ293MjR3?=
 =?utf-8?B?b0Y1RWdpWE5HQ2FHK3Z6VTlyQ2VDM2N4YnJyU0tWWGRkVnQ4aHYwODYvK3VV?=
 =?utf-8?B?ckJMSGMzamtCR0o0OUZQY01uaGRvakY0eXVoVXJoMjF4VjYxZG9wTmVqWXg1?=
 =?utf-8?Q?++oe4yXsg3w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eXVOUlNqMGJUeWRhOTRWU01VcDVaTXRlaGxqbDB0K1lwNWtIOXFYNWwwajQ0?=
 =?utf-8?B?N2dvdFdEZklVSHg2S1VXUDF6LzhwTFNvZG9qd2M1cFJjejM1QTFBUmdPYXNs?=
 =?utf-8?B?Q1JhVDAyZlhsRUlKMGxKL2FHRllGVEc4VXRCajJ0Uyt6V2pGblJla3hDQlhE?=
 =?utf-8?B?NUdpdjJ2NHNrNDdFazI0WUd0UzU3Z3lwMDlVd1RXV1FraTk1b1VpaEEyYkFL?=
 =?utf-8?B?SXg2anVWM0dMNGIzT2sySWpMN214NWdGeVl3cDNLaVYvdHhFazdFUXgrL00v?=
 =?utf-8?B?SVBObERMclRYcEZEcWtBUW1ZcnRJVDlTakpPejVUbGZKZDhLZ25GMm5zK3Vr?=
 =?utf-8?B?VnJGUWQwVGJ3NU5iYkhQbFRvc2tRZjBUZ2Z0VGxOUEp6eW9NYWI5VE1VSWxa?=
 =?utf-8?B?cmNyVHdYTkJQWXM2bWhCdnd3M2ZMektyZFUzR01McUVyL1MxOVBnYmF5Wk52?=
 =?utf-8?B?YlJ0VXJvamtIL3pZQ2EwbHAwdCsyVTBaSjRsTUhzbk9IMCtzc3ZYeFRIcDVy?=
 =?utf-8?B?Y05RY0dtc2ZqdDVBMks1czF0SC83bWwzNmVtSmQ0ZCsxRFBuSkRmQzZNZXJY?=
 =?utf-8?B?Um1UV2JLd2tTSEozTlZpV2NMSGpwaWpRZlR5QTNRZzBidmJhMmpBUHVYWSsv?=
 =?utf-8?B?UVUvYVQyR2VORmxtcEdrUWozU2lwUkw1L2R2amY4Vi9rZmdwSTdvRUYrakpk?=
 =?utf-8?B?MkNoS1psM2FMN1ZWN21wWWN5RUZueDNscnFYbkdNemVnLzRPc0RQWlBLK2lz?=
 =?utf-8?B?Mm95Tm5jc0ZaTUtnOHdVY2xlL1FnL0UzVEFhQ2dJVEQ5ZUlmQ0dXc3RxWTli?=
 =?utf-8?B?YmJsU2hyUzBpR0w3QUR0NnYzT0JjZXc1empyUGVHdUJCTTJpT1lrUUdVeVdV?=
 =?utf-8?B?MnZ6WStvMWlyT2VXN0pnUGZvVDBkWWJUVTcwMnlIRDRsNjhpbmlJclFNREd3?=
 =?utf-8?B?UEJJeFZHR2V2YlVMYjRBajJtdUFIWEpsdWZQdlliQitFTkgzK1dOOFUxVDdK?=
 =?utf-8?B?WlgzVDBmV1d2YzZmWEF1MDRTRkZqdVdlY0htY0VXdGdQR2o5M1RhRHBCeHA1?=
 =?utf-8?B?b00vUjlrSG1HSjhYelhPYUpjUkV6TVh4c1ZLd0kzbXZBYitodzZ3ZHhySlVv?=
 =?utf-8?B?c1YxMVlWZVFCQ2U5NHJHQXZCYm9FSGFJdjNoc2F1WjRTU2R6VEQxaHc1ZFdX?=
 =?utf-8?B?djN6TjdWRFd2bUV6L2NsTll5dEs4bmpRdWJrK29XV2ZyMjJlNEV4NXRabkJV?=
 =?utf-8?B?L1NvaXc2Vms0RjlXR01JL3Nhc3NQU2J4WmR0cngyUlB2M2dyV05wM1p6RnhN?=
 =?utf-8?B?ZkhrUG5VTm85VzVRQWh3MzF3eWorMEd2alZYN3dZM3E1NEllSXVYYU9Pamla?=
 =?utf-8?B?YUdYemU5dlovTFFhNHZpbE9zN0NScG5xYTVHRUU5OWRTVGUxVHNlT1kvOHdj?=
 =?utf-8?B?VEFvQ2UwVXVaVkZkVHZNQWppWG5RdUxpYStPZkNMQW5rZ0xUMmZSaVBnQ2Ry?=
 =?utf-8?B?OWZjQmFVb1Bnc2gvOXlqSEpISWhwWDJGV0VVR2dUTEFSYUpBcFFSOVQ2dWhP?=
 =?utf-8?B?L3pEOGxrMmlZM3RmN3JEcmJKS1JQTHJnRmw4aTRJZm83M2Q5N0JzZXFEcnd1?=
 =?utf-8?B?NWhIc2tLOWM2anlLVVRvdGd4bmIrUmlGV2lSUFRTa0s0ZFdEbnFhcEUyNU8w?=
 =?utf-8?B?d25NdldRUXByYUxCWXp6NGo2N2Z2WEdPeCtZdVZ5UFpzZ2NDZldacG53bENz?=
 =?utf-8?B?ZE1WZ29NKzd5ZW5vVUE2NlFlNXp6YWRQNWpaSUtXRENVcGJRR3BZMTVtdnhz?=
 =?utf-8?B?WVhwaEd2T1lBRkUzT3hVNzltSnloaDJlYTREZUxWZ0hNcGhrWk9lMER6SEg5?=
 =?utf-8?B?Z0tCdHZ2bmlxWktTakl0UHRMaVNlemMwalNGdjJVUkNlQXNpNEppL1ViVFUw?=
 =?utf-8?B?ekNPcDJkcEZrYnFhMGFPRUtZWnhPdWlSRWx5MVNDcUkvVVVQMW9kdFJSekZK?=
 =?utf-8?B?S1dVTFFPSEJlVWVubnVLR2FHelhuT1ZMVm13V0pFb0tGYUo1ZVhoRm9VTzhr?=
 =?utf-8?B?M1hjTGpKOGZhbDdLUW9obzJjcDV2eEhOUkxRS05KcXpscDg0UHBhZkNuTHRV?=
 =?utf-8?B?bkRjcGRaMVhzc1dZbkI2eEZjLzAwV0U5YlVlREcrL0E0MCtGdjJLa085MThM?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23fee1ec-34a7-4f3d-300d-08dde95515cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 12:43:01.5363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fT7+I1j0mEoUSf5HmnDo2RsODAtp0qOZ71vLFWYRyCVf7OS23pVWf/hZfTg7MwxEcvJSAaIgkfb54ipMvlzQUzBEITNlTTG7rNPHqc+70c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6908
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Sep 2025 12:43:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19992



On 9/1/25 11:32, Jan Kiszka wrote:
> On 01.09.25 11:29, Quirin Gylstorff wrote:
>>
>>
>> On 8/31/25 15:10, Jan Kiszka wrote:
>>> On 28.08.25 13:06, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This allows to reset the device back to first boot by
>>>> formatting the persistent partitions.
>>>>
>>>> The reset occurs if a file defined by the variable
>>>> INITRAMFS_FACTORY_RESET_MARKER
>>>> exists in the device INITRAMFS_FACTORY_RESET_MARKER_DEVICE.
>>>>
>>>> In case of disk encryption it will invalidate the keys
>>>> stored in the TPM.
>>>
>>> I wonder if this needs some finer control: We only clear the TPM in case
>>> that :encrypt-partitions override is set. What if a user if this
>>> infrastructure would clearing also in other cases? And what if only the
>>> encryption key should be wiped from the TPM?
>>>
>>> I'm a little bit concerned about what "factory reset" may imply for
>>> users. In some cases, it may actually mean to wipe anything that made
>>> the device "unique". In others, it may be needed to return to the state
>>> that was programmed in the factory, and that may include bits in the TPM
>>> that should be kept in such a case.
>>
>> Ok this would be more of a data-reset functionality, then a factory-
>> reset. I can add that functionality as a separate option or in a
>> separate MR. It needs a separate script as it requires a change in the
>> ordering.
> 
> It really depends; If the TPM is leaving the device manufacturer's
> factory blank, then this here is fine. If not, this tool may not produce
> the desired result.

We currently do not have an model for this option in isar cip core. We 
can provide a version where the encryption keys are not delete but in 
the end somebody needs to select the correct package for use case.

Quirin
> 
> Jan
> 


