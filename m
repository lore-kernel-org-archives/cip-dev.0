Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5668CAC598
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 15:11:36 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.17])
 by mx.groups.io with SMTP id smtpd.web10.1038.1758035494474991447
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 08:11:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FK0aEr3y;
 spf=pass (domain: siemens.com, ip: 52.101.84.17, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BfxtDX4d3PmW+n4La9YoXT2N+EbZkOJF9D9i23VkUXGNDHv1zbCR2SscrxyNX95VnAMGCHMO+CuB2xF+S8vmgKZ9f4sQRVrT23ZyBq2C/uX9rhcUw0xROut/q43Fn4Abt+B6Op8MqyvffmL2auDISt/kuWgTjgVY9K7UY0Yt6XlcVzs07kE3KulydjGom3jNHCui0075QnQ6neqBgCy5HFDVFHFnr/XeQ4XomSDTtg5f1Q0QvtEBVv74cYnp7+vMedk3kPt3n72XGMdKGbW2hOIyin3wDjOCv1dsBEWattwk6Thez2tB6LUJPd05bIH8dMRhfvYIBX+p6ee23IGn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf7K/WmJtR34VClLJMtVFEgd4z2Mne6hb+1I/Jze+9M=;
 b=BRD/cGOPe+hkb27JMWyNFe5Jqoy98ftsgPszZAd8VG57z4Me0B8/+2a99bmaaVFe+SvZsSjhKZtRzHGa4P3EV10gAxMxYR/NUHo1peb3KnqMuBcklLwzfzyb8N/6F0oF/Z39KF2Us0x8goBiQKbGTTXx6c+XfE+VRSghcTqI9+h/hPWJUTyMgGBC6eryk23NGQoWTpF61G/p9XKgzhyVyIHXiRlsoDjEe+s03ZiFJqnZoGf5E5mf4V01pied7XVHKf6sb39VRwj9wClmAFivdPEB5uWX7hniPEHs++hAy/FNiUNHuhn1uY306hB/2caabnbFTsXI3N9EJ5gZYdDfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf7K/WmJtR34VClLJMtVFEgd4z2Mne6hb+1I/Jze+9M=;
 b=FK0aEr3y53AKZ1PoCpGh7jkcmpxitm7Ncl0J6fw3JK77l3nAhZibPwZ4EMchZmtTNOBIbbKRIrFuPPvOppxL8qnue9l/iSgZYJqhKS6Y7PDM1FCZQaXZOfTATgcRzs6YLkIR8vE+d/Uf+CMcKcsZCLDaakD2Y+lqKmgFSyJSTammeGQwweBi1BcPaMiTdax5+YNurpTa5Jrm+4qsvwx2b1jbneGrdhUv9yFdKteUAU+Txxba7VYJu8FwYoOlQuvXIt1M53U8oocVocxrNp3nXCxKJT6kcbhYzbiScVgryoZNxXEXAAs5TYEIczlXMaVzwrE7hef9fzNdIbEh3bLciA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB9039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 15:11:31 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 15:11:31 +0000
Message-ID: <e8832410-a07c-4475-83ca-c867421f81e1@siemens.com>
Date: Tue, 16 Sep 2025 17:11:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate.bbclass: Ensure
 coreutils are installed
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250916134524.1778500-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250916134524.1778500-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:610:b3::25) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: c6042cdd-4442-4d0c-2cae-08ddf5335115
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OHpuVmZvRTZJbEE5MzFSQlNqTkIrUk0xNWFQOThGOWlBZk9Qa3NJRXRUMTNL?=
 =?utf-8?B?bWR4UFBiRFVmcmN0MHVGL0piemdHRGp5VVRPenpITjhaTE9vRnlxWk5ad2hv?=
 =?utf-8?B?eDlPTzFrWkZHSVNXK21pc2d3a0JmcWtqYlN1N0FRalFJUzAxNkNhdHY4RjVI?=
 =?utf-8?B?a1c1bm5Hd2FhTTVwL203SE5GK0UvTlp3ZW5zY09JSjB2blBmVHQyd3lnZzZO?=
 =?utf-8?B?enNpanVqOTRrdzFxS1RkZGFmc0hhSnNMZ1pmL3NHMGpZc21ubGw3QzZiT1Bs?=
 =?utf-8?B?bVJpZ3A4eDJBdHhuWkxhMkl1RFdkdW05dUphVkZDbDY0ZjNQTjgyTmtVOVFu?=
 =?utf-8?B?azVZUnNvOWdtUjdMWE1keEhJWElURzZQWTQ3Qm5QQnJqS0krVHJISTAvOGtz?=
 =?utf-8?B?cEZOdG56VTNzeFAyYVNMcU1kRHJsSGwvM1UzalVwKzV2VXgvai8yWCs4ajdJ?=
 =?utf-8?B?UU9NcjU0cUVpNkdqTnNyYVg0NUwxRVlvQ004UGFoS2xSWFQ2OXpPTjcyYXhq?=
 =?utf-8?B?VUtyeW85dkVaQi9CaTR0YUZTa3ZjL0tQSzNGZi8rMkgvVU05ZnJ3Sk9JdGJh?=
 =?utf-8?B?SnNsalZFOWFpVitwMUdwcnI1c2ZkajVSTU13UDdZTG9rZlNaSGZlVWVVaXgy?=
 =?utf-8?B?aDZVZVhRWVlUdnhzWW0rQ21ya0xnZDJxejNqR1RZZDBNS3RnUzFiMEZRUXo5?=
 =?utf-8?B?Ykc5eVlYdDB0MlFhU1p3VkZkNmpMbFMySGRXTkZ6d1Zwd0lndnovUU0za3M2?=
 =?utf-8?B?YS9HV3dyem45ZHR5Q3dqK3dkaEh6czI3OVF6VDhtQ3FSejJiMlJYYTNodm51?=
 =?utf-8?B?bmNXUHhjaTdqc2pUMXByRy9sVXp4VkU4VmF5QWVCaHZMWHA2dVJ3SE5yTklK?=
 =?utf-8?B?azFOYTNNcGNqSXR5M0FtNE85N05pODcvWnE1L3A5SVM2QTVUQWtsL1RMTHVy?=
 =?utf-8?B?YTNKSkRYMnArWDdlS3lGeENjM2RBdTFkQmVSall3QVdoTktsSU5hV0FES25W?=
 =?utf-8?B?NTRNbHRac3pPbktXcEFuVmlJK1ZUVWJiWFZQU3o1TTJjazl2R3JtcFFtK0Fy?=
 =?utf-8?B?TE0rQ2lmYzhFbURndWNPK0xDbTRnMG9DdXBxQmx1dHhCVUFVeWJQNFJ1aXM1?=
 =?utf-8?B?blA0bWw2TVR4L2hYUTl4R0FwcGZYTk5ySWRLeThSV3I4QkUwOFZZMHpOb0ht?=
 =?utf-8?B?cmExOG1leU91RzN5RWlQQ2VOeWF5YTJIT1pRdUdxaU5xM0xTRHJ0OGVDdmFD?=
 =?utf-8?B?c0tRQ3p4b2Zqa2FqYktYV2xRWDJUS08xRS9EV1ZGOERMYjhxUUxvTFRqTHNS?=
 =?utf-8?B?UG9kdTZIMlVScENQaUdYWjRlZnNqdWhJd2FieWNtUzM5RHA0MGVyV0ppQ1Nn?=
 =?utf-8?B?Y1RuMCtSYms0S0xiYkwxTVVzT0NCRzZNZEpicWdBaEp6N0lWZHNRa0hheldm?=
 =?utf-8?B?c3lZS00ycThKNGdvMVE3d3VPN2liMzZUckxSTFBCajM0Sm92RzY2QWF0WnFL?=
 =?utf-8?B?b3V0eGlNeEd3T0E2UnAybE5mOElGblN4VityTitmc0c4MnE4UWZoTG9tT0hC?=
 =?utf-8?B?OVlHcjVDSUZvRkJ1YVpWMktGeWdCTEcxRmFRcnVMVDdPaU1RQUxXWFVYRVli?=
 =?utf-8?B?TUxLRk1NSC9IUXVHd1l4OTZwaFk0Qk52OHUwakFQRE9mM2NHZ2Z3bTcrODFC?=
 =?utf-8?B?NkdNSVhuZEZmU2FieXFmV3lxVHZSeGQ4aTBGcFc3U3FLb0dMR0dsdFlwUVAz?=
 =?utf-8?B?M1M3OWs4WnFBSUFmREhCUEZ4a2dKaVFjanZVMWMzbkdpQ1BrL2lzOG1TY0F2?=
 =?utf-8?B?RWhWOTlaVUh2MVViMktHNHkvUUdoWVRCcmRtQmYxSG9YRVRiZnVpQ2JQQUNv?=
 =?utf-8?B?U2Q1YjFONkRKTGRmNFN2bkRTNXJOeldxK3F3a1dPYWQyemcwdng2VVBqRk13?=
 =?utf-8?Q?z6CPk8LhhA8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGtuRmNkQzhiVDZWQzJXaXhJZFlxbXVlRWpYYjNaZDVXRWFaSjBZQ1dOTEZw?=
 =?utf-8?B?MDdXcysyL0g4S1l5cG0yS3BoRXluUWRQY2VzL0NWZEowRmdUNWkyMDZpWXA0?=
 =?utf-8?B?OE95bDdlUzZpTDJibEhsUUloMzNOWlVrclhLdWJNNDduVThTaFhGN0tZUnA2?=
 =?utf-8?B?Nko4UGFjMTNiYkJXN2ZSSnR4TnRDdXRVc3MyKzN2K2tZd1ZrMmJMcUc1UWlw?=
 =?utf-8?B?VmJINThYZVNEWWlCTnlkSkNHZW9tU1J2RVdnOTR1VTVOZXc4ZkhYZlgzWVJ4?=
 =?utf-8?B?MkFmMHI0aElnbjJ1WGFWRE9WODczSkI0aWhpMzM2b3I2aDkyN1orc2t2ZzBJ?=
 =?utf-8?B?d0VLb3BQR0pqZlFHKzZqdW9lS1ByanlFVERqV2ZzYkdFNGJGcktaQUVmMVhX?=
 =?utf-8?B?T3kyWnhac1UxR1BZY2p1SVc2K0NCbjNDRk9VSDA3S1N0clRsOUFJS3c4bThw?=
 =?utf-8?B?VXlNZGJsRkxxZEZZVm9hVFBjTUhBZGtIOWltOU1VMEorT3o1UnB5VC9RZytL?=
 =?utf-8?B?NWlWYWM2c291dytMeG9GbU9yYmlCQWQ1WWVVTEhzeURod0hEV0FSY3ozbGNP?=
 =?utf-8?B?c04xWTR1N2xpZ1ZWU0pMeGEycVBtYUFqK1B0OFNUaEN1dTVTNlNIUUplTWJ5?=
 =?utf-8?B?a2lwVUJoSHZzbk85aDRNbUZwY0lFTUcxbE94clAwYkVQeXErREdPNnIvMjMr?=
 =?utf-8?B?cWNBamQ0Y1hzOVBDYnIvWVNTRGdOS2gvT3RXSVZFY2oxWjZRQkUxMFQ5TVpH?=
 =?utf-8?B?K2ttMVZZaXZHb2FDZWFrSktZT3Q2UGtlV01vWllXUi9TMU0xWXdTeWJPd3hq?=
 =?utf-8?B?K2J1N2M5L21kWjlJc2R0RHFDZjhLVEppYUN0S1U4ellyQjVHQTI4eEtpMHFy?=
 =?utf-8?B?V0lQb1RXaUI3OGYxaTNGanZPWElIZDlMbzZ2RmhPOFdDQ01TWGRkeFdHdGpx?=
 =?utf-8?B?RjNudDYzR1pTd0ZCNkF6UEtEdjhaOXdpYXVyMUF3QkpiaDZLUzF3SFpwRG0w?=
 =?utf-8?B?QzNwYVRZRFV2SHpXUnR2YU5OeTl5aGhlOFZ6QlJQbGFqTy9jQWZGbWVNMlhy?=
 =?utf-8?B?V0J0eDFrRUtWdU93RmJYaFRiRWJ5aFVxUm1pOWZzNWpCZWpwZm1aOUNiSlhV?=
 =?utf-8?B?U0JlSzRPSXBZUlBobklyZ3BmY3BPVmdNdXlwZ0pmc1hESHpVdm9raitqWCtG?=
 =?utf-8?B?dFRKNVJiREpla2hyVnloVmR4b3pEQjBGK1h1dGl5ZGRoZnFzS3NBeDMzbEVC?=
 =?utf-8?B?N2paakJkVlNReDdkb1FoOHpPOFQxQ2dSWlhLNGlEQzNTOGlYTmFKQlFudVZF?=
 =?utf-8?B?SklxcXVmT2VuZ0lSLzEva3ZYYlIwUGUyM1RMU0liN01tc3ZDMklXTDRaNlRK?=
 =?utf-8?B?TnFLRnF0MG5VY09KTm5TUnlBUWhZUFRNQmtHWk5QNjNqUWFrMGFMK1FrOFI4?=
 =?utf-8?B?NFU4VWZCendUKzJjQ3V3dFY1ZkpDNFlQVGcvZmc1SWNpSWU4Z3lDSG9GWHhM?=
 =?utf-8?B?ZXJaQUo5YkdRSzl1ajdseGtvUkVOMnNYUUpuTDExVmIxemx2Z0hScFY3bmp0?=
 =?utf-8?B?dDEva2NjdzM0VHRjT1E2L28xUVJaQVFqakl0US9iK3RmZC9zalA4TFVuYWlK?=
 =?utf-8?B?QzR5cURFbDhpS1BGSVk2TktmS1FienRXR0daY2NveGN0ZEJ4UW4yTXMzUlZz?=
 =?utf-8?B?RWY0bVl0RCs3NVBpMUcvcDJnVGkxdGxBNVZxSVZ3NUFWdWJJeXFra3JNSXEv?=
 =?utf-8?B?SVZEN0ltc2JXNzFlMDRhMURzTVd1Wnp2WkNBbDFEVC92aVUvSml3WlFEZWlN?=
 =?utf-8?B?Z0pLMWFGeWNNbE03bDJzMG5SNDFUc1FwZ0NLYS9RcDV1Z3hqM2pESUNSQlhK?=
 =?utf-8?B?NjdickRrMitzcmlRUVh2MXVDS0FrUFE0MUEvYlpUWmJQVEplQVYrY1daSTJp?=
 =?utf-8?B?b1lNOVY2M3dFNDV6MVZTWTBkL0t1YWk5L1ZyWVFEMEV0SkcwdGVJM3laL1hQ?=
 =?utf-8?B?cG1SaE5rMGZmVEovVFE4bW84bDhVYWZjS1gvNWdSeEFobHd4TExwck5RK21I?=
 =?utf-8?B?NkFkWEdoRmV0M1VWVUxQdWJ2UHhjVFBNSUZtZnpiUkdYYjVNTGl4YWRkTmFq?=
 =?utf-8?B?UytuNXNVdGdRMFFsejJrclU0eXFpM1B2a3hOM3hKVXgxNkZFdjBvVGRUaDZq?=
 =?utf-8?B?YlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6042cdd-4442-4d0c-2cae-08ddf5335115
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:11:31.1674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydU83cSvZjITHIOjs58KJY3UjbzqYegEIU1b4Ljg7xxD3yUOQyLn/kvSyrtra63toVIZMFfu4FN4aYjw+jnpSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 15:11:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20061

On 16.09.25 15:45, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This should avoid the following error:
> 
> 2025-09-16 13:03:48 - INFO     - | /bin/bash: line 25: file_size: command not found
> 2025-09-16 13:03:48 - INFO     - | /bin/bash: line 26: [: : integer expression expected
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index c18aaa9..64ae58a 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -53,7 +53,7 @@ IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
>      if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
>      else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
>  
> -IMAGER_INSTALL:swu += "cpio"
> +IMAGER_INSTALL:swu += "cpio coreutils"
>  IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

