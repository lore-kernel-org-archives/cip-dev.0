Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA07ED5B161
	for <webhook@archiver.kernel.org>; Tue, 16 Dec 2025 06:26:22 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16109.1765866379663051975
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Dec 2025 22:26:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=knWUlP3v;
 spf=pass (domain: siemens.com, ip: 52.101.70.25, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQt1jY3fAHudvgPqyw59NrEgHIqdVfb8r5b1BI7ob2mQOTGZ3vfG1jdaHWnF7R5cmKZ4gL9fjMDJdcXekEHcnn/RXA+PJmNw0k1WFmG9VD+Zt4ioj9I6GsYtSRIVmlSew7iTyCYAtPUQYx0i85CJoytFwRLQDoP83IsbA+DWbyBCgO0lAzcuj3Eowfxak5hgYIDz9xXiKz9Uywc4E2KEnpcEc3Pr/hupnzqPV/7c6AmvqopvHW6J43Y40Bewq2FkzLIbWuB2w85WII0I07YiXpYDaGG8PtRVo15j14+tuOPHHeEEIudFwwVYqqBaXd784ONxIbKKYqrIRzwD52sPCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfNLCf+lCObummgMa+SwvYMprlNxvjsQq20cCs1w1O4=;
 b=Sq4qovGO4bEhIkmhU30V3VqlxBDNI1A0wnNVyiQch/RKjLX4AAFyYZkSemIYWiBjElLf+NPt+oaf+P+7xLlhQUg7FUowZhN7kvazrw4PzB5a421xkg9TXan4xvRHvzErq3IIcPwIq/E7+efGVu16bY2mYoLWOcY+eDEgtiF5eKO6cYRlr9BAM0gsJSOtOHODhdZcDYoQ5PSmEoR18Ex3cjfii28Ag9ZL8pDfbdfhpr4bYhlIibCP0Jyo+BoyTQCNiNM9SX8xOcHOJ9VXB4vWrq4/NwUnWPk3ziQYFvB+rC2DS+qziPG3rrCiQAZkbkwOq2z/jR6Z3LbagZ0oUo+r6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfNLCf+lCObummgMa+SwvYMprlNxvjsQq20cCs1w1O4=;
 b=knWUlP3vAyNTR7NO70RCA58rx964ZAK6Ve7F44+v5Wl8//ejzCQtuZvPOSL14BG6yV1buTvRgdaVy68eQvuKfCsRLPdRsL97mETSIlyV1cC3ifNTAAn09xq24lBIEmWDP7oEK/k2Y7knY2IwREpn5TMzxACufi8YceBOhSc3aA+2X2roei/OdiXPBhSVRjpwM5SLXLuVW7Fk69K9Fioy76I/1G3d7ZA84emfXyprZgbqhCb9sjz/u1ryySunOs27OoI8m7qDodFw2hL7026Xy2OSr6v/HVxdTnfEy2nyiPI7tpdoW0vyW3nlwppmqeLSy5c6SbW9SG/O24L091C/yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5151.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4c2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:26:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 06:26:15 +0000
Message-ID: <e1f25494-dbf5-42b1-8d0f-8fe05c6457c8@siemens.com>
Date: Tue, 16 Dec 2025 07:26:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/4] fix: ensure separate root
 home dir is recreated after factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20251215162823.308471-1-Quirin.Gylstorff@siemens.com>
 <20251215162823.308471-5-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251215162823.308471-5-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0010.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ab2979f-3e46-4fc5-97a8-08de3c6c03fe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WXBMMEl5ZXJ2THdnQjdPMkViWXcrTjBoWGRRU2xaNGhTdmZZZnBrdjJFRTJr?=
 =?utf-8?B?ckVubWVwdi9UVk1aUE9YRU9QUlhLdVJOR3diZC9WTzJIcDdZWFYzOWFFVDhj?=
 =?utf-8?B?SU1FYkRJRGQ2U0UxNk14L1gyYkh5SVE0cjJjaXV4aUNrTjlvZzRoeEdocEtm?=
 =?utf-8?B?b2tmUktxWGVvZDZMZWRtMFl3bHNvOVBDcGJhTWZCbE1EMGsvT00wcDhrMjU0?=
 =?utf-8?B?YUJRTmdyeHhYREpoT0lwTWlZQXJlNEptUVlvM2NIWHpwMTNseDZBc1doTkxk?=
 =?utf-8?B?MkJnMlpDY3FBbTZqeEZjY25sbWN1SlZraUZ6TmU5ekJENnJ3czdUQlpOdjRM?=
 =?utf-8?B?dk1CUWVYMFl6bU9TdXNJZUJsMXM1b2F0Mlp1SnliMFhjQUZRVHQyc2U1ajR2?=
 =?utf-8?B?UkJTeHRtTk5xNWVlWGdzb01PWEdGWWQ2cE5HR3NzbEhLOTllY2RvcE5nUzRW?=
 =?utf-8?B?bzB0cmUyNXdsRlBNVmlJVVUyQUExbzcwcTNlemN4NzgxUjFtSE45V3ROLzVF?=
 =?utf-8?B?OE1BdmFVeGQ5SjV5cGxyQThLaDBFZjJjVnNNV005dmtTUDVla2FqZVNRVVlD?=
 =?utf-8?B?b1R5bVpuSUEzOEZoNlVZTFUrWjY0N1pXdXM3Yk5TM1BxMWZ1ckc2OHdUTlhn?=
 =?utf-8?B?c2Myd25kc0dud3A4MFdCRWpaWC80NmhySmovb2RwWCttWEV6TzJXdGpOL0pI?=
 =?utf-8?B?WVZWYlliYy9VUjlPL016ejNHUXlaTE5NYjV6VWN5V0YxSk0wNkNDRmJJTkNG?=
 =?utf-8?B?S3g1UmRlTmpPOWNFV3BGOGJrMDhvQUpTeHpxMGZKcDNXQTk3Nkw2dVlsclk5?=
 =?utf-8?B?VWRRL0RNcitTZ0hMa21nb0xNaEkzVjZwbzhNK3ZxWllUbkQzcXN2dFBhanpW?=
 =?utf-8?B?RjJLbnQ1M3d1RlJNY3BZRmF0VUE3YzJOUUZkazZtR1pLbFhmSTNJS1hGZ0N6?=
 =?utf-8?B?dEE3QmNZeHphNVJ0bE9zVHhpRlB6bWUxSGx1YnYzUU5uMk5uaGlzOVRpbVVN?=
 =?utf-8?B?cnBmVzNnY0hKb2tOK1JCb0NTY1BzQXhNWmlIejZBSDJQZittdFlmcVdpUi96?=
 =?utf-8?B?UldoU1IrRnAybWorSm1ZRXY5VFdzamphVUF4d2NkdndmM0pBREdKSXMrMEU5?=
 =?utf-8?B?US80MkxxTHlKQzBkSWNuK0ZHME1iZmRwWmdkZTArYXVoL3RCRVZYRm1kL1lM?=
 =?utf-8?B?aXRFUzhUbnFDaFgrZkZ3WGN4cFlxL1VCbWxqbTRQeUk0dHRqVmNJcW96RThx?=
 =?utf-8?B?WnlCV1dPcnN0eFRVVEVWN0w1ckFBT204c21lT3ZsWjl5aks5bVhxampGNFcx?=
 =?utf-8?B?eFB6STduREhtaXRjTGNZMGNSY0dVcTN3bUNvL0oxMXZGSGh2anlEZmVHVWRO?=
 =?utf-8?B?YjRBL1Z2b1cvdUZzcTZMWHBDcHFJeXJLT0dSYUtZZStxa09OYTRwV3g2VGRO?=
 =?utf-8?B?TEl6bjB1eGsrTDBkR3VMRStjeXNLU1NzcEo4bVlza0xEbllVVk5PeEs4Mlp1?=
 =?utf-8?B?VHBSa3dFbzA3bU56RDA5SVVMZE8xSFo5cElqRldsYS9XZHh3MUR6UlROT0ZX?=
 =?utf-8?B?YXpQMDdiMDFlSCtWQ2NOWHBWYUlYWVhSQkk4Y3NhaHpsaTh4cHBLbDU0VENS?=
 =?utf-8?B?aG5jZGhsbnpnMzQrVHNHWTdVSDJwUENNeEdLSElVK20rRUl3K29YSzJnMjZt?=
 =?utf-8?B?VjZEK2hhblUycGt5SEhiZVh4ZHZ5T01VUVk3ZGNhK1U0UzZxd2JxQlRqVGFB?=
 =?utf-8?B?MmlKekhQZUdVYXRvUUdHeG1naDBCOVp2Z0hrTjdyS011cHlDMmlNcUh4QkdB?=
 =?utf-8?B?ZmZZdFlJVUpVVXl1TmVuclBheWZTT1I5Uzk3ZkRYSE5vUTJEQ2pHM3VBOVd4?=
 =?utf-8?B?THhMUHEva1RvSmpyZExxaDNRcFBBQk9maEZRU0tZSEVOcDgwV2F4azN1dGRV?=
 =?utf-8?Q?EpD3E5uX+9J6lbOLilsilCiORROGeiqn?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bmlaTlUwMUZ0d0IwN0hFbDdBckRJWDRNcDhyUkh1d2hUSE1UMUMvaVJSWWRE?=
 =?utf-8?B?MDBQVnByNDFlcmQyeXN3amo3dFdNdDhYT1NyYjZiVHJONEdzTkQrVEFJR3po?=
 =?utf-8?B?MXdxZkowTmU4Ynk4OWJYOEZkL1hqNGRpNm10WjRWRmRiZHhHKzBhdTlQdVgx?=
 =?utf-8?B?TFpuMG45Y3A5WExrQ3dBbjE1dkZGVjN5KzVYRTQxcWxIUzRZL2FIZm0zZ3Rr?=
 =?utf-8?B?VytlbUZwWWtldHVlQ1RORlR3bVdYdmdEd1ZaRXRleTZEd2QrRDRlKyt2WkRR?=
 =?utf-8?B?U1c4ZEN6ZEo0YWVuVmY5bXppNVp2LzBYd0RLYVg4Tm5qa1JOVjRrL3o1RDdP?=
 =?utf-8?B?Q1FidDBnM3JIZXB3WFNPSVROWTZULyt4MWMyUTF2QWlCWDNDSU1sU0FiSnZL?=
 =?utf-8?B?UlR1dVFxeFBNSEV2ZUJ3cEE1S3JYL1ZUOW55STRIK0ZmaVZPbUhpQzVTQkpt?=
 =?utf-8?B?SnVLUGZTR2xaZElFSUJkY010Y3VmZnp2YjdpRmREdTRobXdmRDdtQ3JHcFFl?=
 =?utf-8?B?ajJGeDJwY2F5eUdFd1luS05jMWJGeGJVTnZ6NmIrVW5oV1RuZFMrZVNzbndE?=
 =?utf-8?B?RnIyY01oY2dXRUQ5bFpQZi8wc3QyenpBRUd4YW00Sk1ocEVNSHlSRVc0THNt?=
 =?utf-8?B?bnpjNktHUjBHZU4wZUpacjhKclNSRVBYM0w3WGs5L3ZXOTlXQ3VwNnpZTmRW?=
 =?utf-8?B?eXZuaVNyZ2tjZXNqM3hrOTFNWDFYYXRBWC9iZFA1ZTlIN2xreXU3ZG14WXlF?=
 =?utf-8?B?ZVl0MkRJN0o2YWN5ZCtwOEx3dXVUT1g2Yk1pT1l4NUZsTVJKZk5hSGxEcnQr?=
 =?utf-8?B?eEVRQkEvOHlUMmMxVWpQV2R5d3Y0ZWM5c1c1c0dRZk1QbEhOZzlMNmRQaG0w?=
 =?utf-8?B?ZGVCc3BLTllEUHdyRDExVStNNzd3MG92bjFOdmJMNHZQZ04yYVlqa3BDUFQ5?=
 =?utf-8?B?cHdJa2VBV3lYREhBV05xWWFFWmZvdWtEdCtGTzhseDVmLzJ1NUNLVS9tbG04?=
 =?utf-8?B?VGxkRmNkNEZ3cEtHZmtBVHYvTTYvcGZ4cXcyYVJ6RFYvUEZMZW0zZmdnK3Jh?=
 =?utf-8?B?QThmZnpxOGdQWThSN2tzQTdUT2lzUFREZm1RVFFzdXowOXk0MHZnSnUvNGlV?=
 =?utf-8?B?VmtERUU1Q0U0WUxwdUNFS2gydVhXcFBCOVVpRlVzZjRaVlJMYTc3UTZrQXdk?=
 =?utf-8?B?aEFJMm5WT0lzM0ZkeG1DRWJySnJBRFJUbWtibnlkczJqZ1JHUW9UZWYzZksy?=
 =?utf-8?B?Y0FEd2NidlBFTmQxM3lqVXJqRWFlVlFPaVVXNGFsbUFORlZodVRlcUM1MGpL?=
 =?utf-8?B?VmFaK1V3OEZFN3BqYzVxSFltcUxrNlp0amp6VFdtL2dqdHJuVERHN3VGT3lJ?=
 =?utf-8?B?QkVxcml6K05NTUQ0WnRtQXZQa0V4NDVJck5JeVVEUDVKN3JuNUdxRXp4dTlk?=
 =?utf-8?B?K29HYStUNkVwWXVYSmxxMTd6S1hFcWh0M3lLZ2xxajkzZTN3OEdEZG5GOEZD?=
 =?utf-8?B?Kzl4TlhkMFBZUVIzUzBEL241RVBqKzJPL3FuNmwrUUJOUXdGWGF6c0g0WlRw?=
 =?utf-8?B?ejlmNG52b0I1NVFEc2NHcWpPNlFFWVlhTXlIalFkRjdDUEhRUzVaVUhWYU1r?=
 =?utf-8?B?dVB0ekQ2YTZVZkU3ME9xaVVPaVAwUFFDL21RSXRSMmF6Y2REUGltSEZPVmFW?=
 =?utf-8?B?anlvS0pENTRQSTcvVGJKSXYwWXFia25sTlkvanF2RjBtc1hFN0pFM3d3Y0Qy?=
 =?utf-8?B?K0FpdzJEZWtyZmhST1RIdVhHTE00QmxUM0xYd1RRNHgyTnVQRHUxcUpDYnhI?=
 =?utf-8?B?SnNrY2hqaEFRREFSaUptSWlxeWV3Z0tuTk5vdndOVkRPMmVSK3lKaTFPcXc0?=
 =?utf-8?B?ZUtXMnJHSFRRUk1TbUdZQjR6YkZiZHlGVWRnVU9TZGQ2SnJ0QTR2R28yYWpu?=
 =?utf-8?B?dDV4S0k5RENsL1dwVkJwNDJhUVZldXdKdk42VFNTbjhnM1EyMm56SW1jSHJG?=
 =?utf-8?B?UGJxNUdyQXE2MC9QVGp1ZmFxNTI3c2hENUdlVzhnTDRyc0lWL3FQaEVDRjl1?=
 =?utf-8?B?SVQxWEpGMlhMY25hVXNnd0FNaGo2c2VOdWw4eHArSUhveEkySldCNmJMbXho?=
 =?utf-8?Q?odXaCQdiCq4hAUF4azQgrmzlg?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ab2979f-3e46-4fc5-97a8-08de3c6c03fe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:26:15.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FQDRkkfsWxi5YWPm6jRFH2MUhHnQ+fe9lM6pJ9lCmL/pjbsO9CvsvWE1DZqCs8cdCo7rSO0UMIkolxj4b2c7TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5151
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Dec 2025 06:26:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21072

On 15.12.25 17:28, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If the option `separate-home-part` is used the home partition is deleted
> during a factory-reset. To ensure that the root home directory is
> available recreate the directory via tmpfiles.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../change-root-homedir_0.1.bb                | 15 -----------
>  .../change-root-homedir_0.2.bb                | 25 +++++++++++++++++++
>  .../files/change-root-homedir.tmpfiles        |  0
>  3 files changed, 25 insertions(+), 15 deletions(-)
>  delete mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.1.bb
>  create mode 100644 recipes-core/change-root-homedir/change-root-homedir_0.2.bb
>  create mode 100644 recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
> 
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb b/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> deleted file mode 100644
> index 79c7e67..0000000
> --- a/recipes-core/change-root-homedir/change-root-homedir_0.1.bb
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -#
> -# CIP Core, generic profile
> -#
> -# Copyright (c) Siemens AG, 2021-2023
> -#
> -# Authors:
> -#  Henning Schild <henning.schild@siemens.com>
> -#
> -# SPDX-License-Identifier: MIT
> -
> -inherit dpkg-raw
> -
> -DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> -
> -SRC_URI = "file://postinst"
> diff --git a/recipes-core/change-root-homedir/change-root-homedir_0.2.bb b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> new file mode 100644
> index 0000000..0e356cb
> --- /dev/null
> +++ b/recipes-core/change-root-homedir/change-root-homedir_0.2.bb
> @@ -0,0 +1,25 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2021-2023
> +#
> +# Authors:
> +#  Henning Schild <henning.schild@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +
> +DESCRIPTION = "Move roots homedir to /home for read-only rootfs"
> +
> +SRC_URI = "file://postinst \
> +           file://${BPN}.tmpfiles"
> +
> +do_prepare_build:append:separate-home-part() {
> +    if ! grep -q /home/root ${WORKDIR}/${BPN}.tmpfiles; then
> +        echo "d /home/root 0700 root root -" >> ${WORKDIR}/${BPN}.tmpfiles
> +    fi
> +}
> +do_prepare_build:append() {
> +    cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
> +}
> diff --git a/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles b/recipes-core/change-root-homedir/files/change-root-homedir.tmpfiles
> new file mode 100644
> index 0000000..e69de29

You didn't address my other comments on this patch.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

