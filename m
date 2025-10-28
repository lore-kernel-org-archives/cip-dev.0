Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83BF7CCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 15:17:29 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.28])
 by mx.groups.io with SMTP id smtpd.web11.11626.1761664642725286249
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 08:17:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=fVOPeSYw;
 spf=pass (domain: siemens.com, ip: 40.107.162.28, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r41bN2ZKwDmZHlGcAlvNK3xfPET/ly/24Hq7tg3B5XpsHUkoPIKQ+lruZdSJR25AdFt0ED4s/c46WjzK/rWcbIwieuoudOepd4TKgq+mTaqNTO1VRz0qtAuk78UkysNlPB1JJ9UnlsPvisFZGRNtO4BPk2GGhaCkUmD/sBwoO4XCLMIRem0t1A2qaLWpRwdDnpbkwFQVJ72fHja98vJO97Qc3qlX3a92GMns5gvLddkCQ7DZuqtvCE1bsqKSERyJ9jWpWHzVPwzqUOYIBhgEv3Pv6Lf3qOSdAcghGnNAaER9Ta8pG/fxGcwUmfGH7hnYD2ocQyspfTpMZuGg3QP/Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa8DOhvt1kwOEVvBmsPJGM8C37S2H9QGn+9PkIZO7Xg=;
 b=aT0Ck2eaqUOC/J9V4qvcTAwRI9kAyAreAFA/AdN+a24lCDu8jqADN7HzOjjv/TVX7s90e7JN9cVgaCswBUq2iG8Z2gfdQlluh5Cd+9KCeLsrLUl44/MUYBGkDdyAGQpVdGiz+bohUm6DWe6jYkV7zows3gX67UMaB77WzrB3YQhDQ0vAe+hwfGadEAhCqSjTYHEGtAqBVtbEnAkqV2pt2qywBWfbLgVigGqFf4tOSxxXOz5jSv3xan7d0hts6dnUSv4xO5LomTdfJSpjGX/PR5HoXj0fmwAcfuPuprbE7Xs4OD23z8F6x23Y4kIfTi2AEadyWO1xWYUZV0UcQ0PBJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa8DOhvt1kwOEVvBmsPJGM8C37S2H9QGn+9PkIZO7Xg=;
 b=fVOPeSYw5HnS2n/1H5H+VTp82Jszc5IZ2AjdK3IPAtqsm/VCp1dxC0CRkTQhPfx7OUuQlqokTo9z/U6uTmcV115kBOdTBV2cOv4ZJwgQbh7IgpEOBlraXIaoXIQtTHVCsFKaoStA2TBoC95QSLfIWXXd41lJgsEZF6qvDBnoJV0dE/bq0jvzBGZ/WcXtNc03JNw92pqGMw/7qqp8wCWUaCXUv4ChCpCKv5gyN4loP9r/CMY46bGIAMOJKBW0f8Q0hF2kEP1bcdDSorN7xYYDgClHs1WkJXGCdtcPUqXqu1YHF8xobrlrFxNw7UewYx0dxftdf8QiIUGopyIjvqRxTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7118.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 15:17:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 15:17:20 +0000
Message-ID: <ab42b06f-32f9-4471-b07a-e640098fa78c@siemens.com>
Date: Tue, 28 Oct 2025 16:17:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC v3 4/5] kas/opt/wfx.yml: Set wfx specific
 variables
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251028122042.2355451-5-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251028122042.2355451-5-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P223CA0007.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::31) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9e96b3-fbbb-471c-0b1d-08de1635168e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|3122999009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aVZCclVoLzRsV20yNnNVazMzaGRXbkFvZ2JYTG9JM1NWeWNVWTBCQXN2elhm?=
 =?utf-8?B?ek5LSXN2dzg0SGFZRFJNUzlRV1daMjVjcm40VEpVOGNmUzU1Lyt5OWNkTkhS?=
 =?utf-8?B?RHlCZlBZcUUzbWhhTUhDZG15cnpuSDlkSHM1RE9ZMFJncWdwQ0w2TVYvaWJv?=
 =?utf-8?B?Rmt1S2w4UWhCTlFSSnNpTmZqeFhjVEYvVWF3SUF1Qk1hT2t4SUJQS01BNjVL?=
 =?utf-8?B?NGhvRmd3YzJaTXIxYUVQUy9iRGpZTzdEQWNpQkpGZDdWOHIxdWFzQW84emRB?=
 =?utf-8?B?a2NyNFVyWithQk9lKzBPVkdJVnkyUVJIK1JpNGNQcVdOR0VCd2NiTVhPbWJx?=
 =?utf-8?B?OWRaTEJnWEUrYnI0bUN3WDZMbFRoQURNZ0VuSG4wRzNmanNpVkNGSWx6VGxH?=
 =?utf-8?B?bmtGNURjeU81akRYUmNpMitlZncrUmVweGFSa3JWdVRXRi9UMXovU3pZbW9q?=
 =?utf-8?B?ZE1menhpRXRQRUxsY3ZuVVp1Z255REFXMldXSEZDTVI5V2lXNDZvZUQrTHpE?=
 =?utf-8?B?VUVRVHFGVS9qTlREVmNlR2Q0WG9ySnpxWHNDQ1FFM3A2U01WWkxLaHFMbTVu?=
 =?utf-8?B?VmFPaWxhRFBlTWVHQ0pLUk9pTjJ2S29XemwrQ2NZQlZkTG1JeTdLV2FKRlNU?=
 =?utf-8?B?dmt4TDBYbnQ3cTk2QXZ5eFZhTlFOTTlTK096bng5RGQ3blc3bWxzM1hsRHZa?=
 =?utf-8?B?ZTU2aXQ4ZFZKTXZ5eGo5aGdWNkxRNXRYcXBROWZta3J4b3lrWkc3dFF0ak5F?=
 =?utf-8?B?ZWY1THErZjhyUzBmNXEzTTh6aEREbXNhcC9RTzBHeGpCWUloOWZubVNVSVJD?=
 =?utf-8?B?WitnSDBtUVovR05GL2lqUURtSlB3VlZUZkhERHdtRE5jZ1g3K3JmZ0sxWkZ5?=
 =?utf-8?B?V2tLT05wYnpYVXp5cmtWQlVXaHBoL2ZGdmc4SmxaRm1lU3gvNWZqWk55Q3dm?=
 =?utf-8?B?SC9jekNFaHc0SFl2R2E3NGMrYXFETlo0T0RucG9jRjZPeUxERlUxYjkxMVZh?=
 =?utf-8?B?VzBJa1JveW9XVm9jRTdxdFVtQWhicDRBdWhScEJzK0FGT0R5MUtHUVpTMHhh?=
 =?utf-8?B?OXdTYzJOenAvZTRTTlJhbnB6M1cyeXBwb1BEK1Zqb0FUYmlqU09pS1laUnNK?=
 =?utf-8?B?UFlraFRaYXJad0FoM29YRUw3ZFJ2ZmpHektzczR1Y0RSYnIrZHVjcHc5dXhB?=
 =?utf-8?B?aVRwV1puUWJzMmJhaXhUSmZwRmJaWWV3ZTh1SXJXN3IrWnZQSW1DZFppa0Rq?=
 =?utf-8?B?OUZWbVQydy95a3RndlErWEVJZUM3cUIvQlpNcHJ4WWRoRFRDNWtZWE1ZUzJE?=
 =?utf-8?B?RDhqR2p5TEp5d1h0bzRMWkNvM3pvQnhldnJWT0haOW8vNUJQcVV2aGYvZjhM?=
 =?utf-8?B?WWorNzdMdnY2VWlZSWExbmt6R1h0UkRaaXVoNjlISys0OXRzQlZVRUhOR09R?=
 =?utf-8?B?U1cwZk14c2JiTEJMUzF2NGhaUFY5N0tabUI5REZpQWtvWnhRMXhScG8wNWxH?=
 =?utf-8?B?ZTNHVHJkdWNkclRKWGVWUXc4MUU4RkplOU8vTFc3VlZVdXFyQ09XNWVqWVkz?=
 =?utf-8?B?V21JUEJZVVVyRGNzTDFENE9mbUhlTkMyVmxMQVpVVUdsL1MrVkRVVlpqS21I?=
 =?utf-8?B?M0UwMzR6c2gvZk9XNWY1WElzdHJvSE4wdFhXTjdTc3JmZkpkREFRTkFOeVRD?=
 =?utf-8?B?OGx6RTIrY2c5VjVuYjZuUnlldS9qTTlCZFhDalJxM0FEZC9ZSkZxTExqYnVW?=
 =?utf-8?B?V1FieXYrMlIzU0VrSS96OFEyY250QVNadStMM1gyUWJrWXpDS2p3ejZGUklF?=
 =?utf-8?B?dHZIelVGVGFjcklmVE9YTTNJWUxSN0VXWldsMmNBSTNXUU1wNlA2ZUFodUxU?=
 =?utf-8?B?L2psOHhweXZsdFBaTjFDeUkrT2JMMmZHVFRPTVpOb2kvNUppMmNvSVI3YmJE?=
 =?utf-8?Q?QWuJqIUwtrmaI6ol3e1l4wHuGz56nmEh?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(3122999009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VHl1NFczSGplTGJCY1ZXaUk5eVdsbmJ4SDFhQWhWdVh3Mjc4WSt3M2FkUFlX?=
 =?utf-8?B?cUNQajZFVjF0SnhlNndQMnNXZ3ZLekFOZkhJaTNvT3NHd1NMdXVTU0JXbEtj?=
 =?utf-8?B?MXZPMFRDK2VWSmxhR2V6ZTBITHZieGd5TEFLTlZVTGVZb0ptQmhSQmdJVlVm?=
 =?utf-8?B?WjVObllGMlVpbE5EdGkvWHM2N3QvZEh5bjErMzBveTZuK1BCNUJFU1VQRGxq?=
 =?utf-8?B?R0dVNkpiZ280cmNZdHlLUmkxUjA0TXJqV3lEUzRKOWJkbFJ6RG54YlBUVVpD?=
 =?utf-8?B?Sm12WTFXTE16YWlTYzMxemt2MWZvZUREblFJaGVKazlsTy9wWmNEc3h4b3Br?=
 =?utf-8?B?RHh5cUwrS3RyN1VaRUZuZmZEcWxTOW4vbDBONkhxZ3AxaisvVDdDTEtMRmI2?=
 =?utf-8?B?RnhFTDczMDRETWFCM2pNb0oxZVZ2RW92M3ljSm1OOGVmTTJFU0NIOFovTjNm?=
 =?utf-8?B?TGw0Z0hkbVkrZGFZRHcrWjQ3S3pCQmJlUzFFMmZhT25idWdYZHBmdEFKU3Bi?=
 =?utf-8?B?TEQ3bmhScHY1WlZnd0ZCdklsUFVLUEV5ck1pNmp1aXR3Y2RkaEtWYkpFbURh?=
 =?utf-8?B?MnJYa0Rzd0FEM0FiMmdTbzQwcFEvRThyNSt3c1VtMXhWTndJRG51TVFqU2Qw?=
 =?utf-8?B?QVJ3TWZ5cU92bHNhNk41WC9GOFkxNGhDRHFCeHgyMkJkelRUTmxPL3hKYm9h?=
 =?utf-8?B?MGcwKzVKenRidjI0QWJiclBDWE5YMkNpRUs5RzVSbm9RMWlHb0tKS1BDVERt?=
 =?utf-8?B?Q1ZMSi9zaEROMXgyaWJ6UGM4REJ0a0RYV0JHajBFS1dWLy93dUdvRkM4SE1B?=
 =?utf-8?B?eFhVOVNNUFZvaEV4b1lSajh0V3hxVS9MN0dka0I2a1JaZ2dJdGxoRmZSV0Ja?=
 =?utf-8?B?YXVHM0VMWWd6cWJXbUlWbDhqRlk4ZmhKNFFRZU05dkVPaDRHdmd2MDM4bFZQ?=
 =?utf-8?B?NUUxdmJ1QlVOWGtwTW1ZSUlYUElzbWZ1WnBtOUg0SmNYd3BkYjlsSGRNRnZ6?=
 =?utf-8?B?dS9LY2p3QlZLeVhzT3dqUjZDVXh6U3dybExBN2JaRXF3TmkwcGhSRzNCYmQ4?=
 =?utf-8?B?cE9OT1BWSmxncitvR2RHc3k0VGxsMXBpZS94UTVxZ2NlUG1QNmNWNVVjT3dO?=
 =?utf-8?B?TFdQL3N2UkVVSTY3RXRhMVVuZ0RTUWFjdWpDbmRDMWNzL2d0THNvRWh3UHd6?=
 =?utf-8?B?MTJGWEFZVWN3OWF6bXBad01xeUF2WXMzTFFOVC9UQXZCQ2RqbUk5ZUlWelcz?=
 =?utf-8?B?anlwN2FWZTVhb3V2TU4zbmlsVmFuT3pPczNPc05wamNiVDdISlViNVhCZEsv?=
 =?utf-8?B?ZEV4NytxOWxwQnFreFViVVpPU0FsaHpocnY5aUV3N3VyanhkcjdIcmVXOERI?=
 =?utf-8?B?UEowYVp4SXRBbHppSDdsWUxCbHcyVkJNOFpjdWtvN1Z4ZytjdzJPWlRvWU9Y?=
 =?utf-8?B?aktUOEFiRlh2WUFSZmpRcCsvM0tQekQwLysvZ0M1MHVPeXpkTlpVM3MvckNu?=
 =?utf-8?B?YXQzZHFwNmhUUnl6QlRrTkRZVFNYN2pWeHRCQlUwaTBPUCs4MWRXQzVYeHFy?=
 =?utf-8?B?NEFRMUthSG5UQmNRMmZtQWplZEV0aGYrdGkzUVZoVWlqWUY3eHJ6SmVzRFpx?=
 =?utf-8?B?ZC9WR2lid3ZqRWUvNFdVeER6SXpxcnhnVGVIeFFGTjAyejhpZGovanVxTDMv?=
 =?utf-8?B?MElUd2EwcXNWTDNITnZpYlNUZ1pxRW9TYTVDSTJiblFnOFlwOHJ2RC9NVlZG?=
 =?utf-8?B?RkZYU3Q3dzZDVzJvcm9wZEpWanhPT0ZoQ2RHUVk3a2RnVGJNUk5Ea2FCcUw0?=
 =?utf-8?B?UmpnTjdPMDlobWxzdzExOThRT1ZVa0ZlZUl1Y01pZW5yNjJ3aVlpeHJJL3g3?=
 =?utf-8?B?eFNKNUNub2RUVzI1S0pvVGQxazQwM01iY1psVmcwNFFUUlBkb1dXcnc3MkRF?=
 =?utf-8?B?bDlSVXMzV3FGM3RIYmpNN0RmL3RFUHNGUVhGYW5PbFcxZkF3RlhUTncxUEcr?=
 =?utf-8?B?TGZpREdVZ3lYaDVUQ01pT3h5d3VUajB5SUtnUXlQb2NqSmdOVEk3RGYvSDV4?=
 =?utf-8?B?Y1RRUldvNG9JU2p2ZDFoRGNBTDJSTUVSUmE5M3RnTEdFRGdZL2YxdUpGV0Uz?=
 =?utf-8?B?SlZBUTRjaksvMDJRcW9FbU1PL2xmdUpmZTc5YklxaEg3MGlSVmdvd1liaDFh?=
 =?utf-8?B?K2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9e96b3-fbbb-471c-0b1d-08de1635168e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 15:17:20.2470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yGyQb9B+Cvr5XGdm+U+wFqBO2k8xGyMtA0sZRFMcjuPQlSye9zY/0r4tPmWC5+ghV0rkF+s9ENZQTlzh+e7MJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7118
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 15:17:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20264

On 28.10.25 13:20, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> This brings in a new .yml file for wfx specific variables

What would be the downside for existing users and non-wfx deployments if
we make this unconditionally?

I see in patch 5 that some URL has to be set. Can't we use an empty
WFX_URL string as opt-out indicator? Maybe even during runtime (if needed)?

Jan

> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>  kas/opt/wfx.yml | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 kas/opt/wfx.yml
> 
> diff --git a/kas/opt/wfx.yml b/kas/opt/wfx.yml
> new file mode 100644
> index 0000000..978b406
> --- /dev/null
> +++ b/kas/opt/wfx.yml
> @@ -0,0 +1,20 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation 2025
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +# This kas file adds wfx backend options
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  wfx: |
> +    OVERRIDES .= ":wfx"
> +    WFX_URL ?= ""
> +    IMAGE_INSTALL:append = " wfx-customizations"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

