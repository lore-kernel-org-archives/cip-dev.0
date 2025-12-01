Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC72DD116F1
	for <webhook@archiver.kernel.org>; Mon,  1 Dec 2025 09:12:08 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.17565.1764580326836668940
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Dec 2025 01:12:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KqwnDXe5;
 spf=pass (domain: siemens.com, ip: 40.107.130.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eUlWv0W5p7s3xF6VIxveprT2LF7O82lNbr5HJaPRcBe/g9otd0PzpQxobRxL9/dJPo9lQsLjEPZfvRinW76tpX1PzLatUPbTszINTOtIRk98iPSQyS3okQDsbvcq7y8tF4L/cbwphTqmQLooSlIBSqW9pMWP3/GbWX/zcX7hf+r9ynpOD+/CTXW287Z6n5du0ICTamFzYTHHR0v08vR6defSv08+02GywRZnFPo8WLzkdHsoT7FLGYmW2oiWzvqx4ge0QLZ9UR7fBq5RXlhgmHCl/o6yizeT9Mjuf0nJqavgLYDnbOmMMF9kS2FcsRD+UMwnGH1rNajNoerTmqa+JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2uSm2G9SovK0fEUS7Q5fEWV+/usWhTd5MUEuP9h46k=;
 b=JdafmlSxmUSWhSu3gYZnaJGqCnwNjMYCaiw78JR2KGbeLP5Si3DpuK+DCOEp/BLu1n4f370abjFB0zQt6i8PRiYON5xX0Ko7AfKdU+/VHCTM4LQUqsrM3DT+wsIwscPlRti6blwVR/eXHy5r7u8kR1k+LDztFXgz/WuJVindjtHZGT55+l+3APT03iBnfhD9KjLi3M4rZXTxzO/vKC/z+MrNO4/W3oV8OrtwedP3cngu6ZGtUZ2/nVQf9ALSzZFKMpjnmueGZbZuof3KAqcN/pGSmxl+ysBKcHTSoqPkHNWUa2CGxKz/q1t+SzdAmpFvZDqG+/b5VYa/QKbrTUoz2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2uSm2G9SovK0fEUS7Q5fEWV+/usWhTd5MUEuP9h46k=;
 b=KqwnDXe5jFEqAlm06lYUt807wiD1a7gdBUMLZKfOK7TW/VPvy3a627ePdfossugswMqqCiDpf2i5QikampLjIu4Lk/fj8QWkUSsNkb6bAjCo8jDA8NfcWh5kaJP0wXP/df/XNB+lrokF6PkTzjk6yiyiq1sd1ppM7aExTIff1ScM2KmqLu5vJsKxsDmYECoOtoY+I1bDc9nyMSSXcD17KKIlw50iPjsuMaptYBSQSXztgUbZxH/gMOzWuciutmCm7BxwhnVZBhG02Kc2abUPLvk81MqucCqVJd5UIV2XPqshoe5UXjlux2SQKuDwcYBSMNfHYDzmfMCStiIRhZcN/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8800.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 09:12:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 09:12:02 +0000
Message-ID: <687ebce7-64c8-4bfb-8ed1-3b36ab1f2dad@siemens.com>
Date: Mon, 1 Dec 2025 10:12:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: 6.12-cip RT testing
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Chris Paterson <Chris.Paterson2@renesas.com>, Pavel Machek
 <pavel@denx.de>, cip-dev <cip-dev@lists.cip-project.org>,
 Arisu Tachibana <arisu.tachibana@miraclelinux.com>
References: <7f09f540-8d58-49bb-83f3-811eacc77a20@siemens.com>
 <TYYPR01MB15132251A0B56FB7ADB41CA1DB7D6A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
 <c2a68a07-435e-4a70-af85-0e34a7884946@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c2a68a07-435e-4a70-af85-0e34a7884946@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8800:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc89313-fc6e-4398-2275-08de30b9b0ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Ujd3T0Z5NkJ1M3hqd1ROdnM5MGtQcTQyeDRqdU5Hd0h5aGdiQm92cHdid051?=
 =?utf-8?B?alpvWXZMOXM5cWNVS0IzVkoreWFhbDhjV1hGdzlSUjNpeUNTY2JRWWtNZzVC?=
 =?utf-8?B?YjVEcVZsK3U0RVlSaG9TaDhySi93cUFTNkwzQzM5bW5tb1Y1YlBEZFVUUDFj?=
 =?utf-8?B?YWFOclc0Si9lcEpiK0V3MUpzVjE2MkZwM1VNcTI5VGVLR2VaRUFmMVFUczlF?=
 =?utf-8?B?eFRCckJ4T0NxZ0M0K1RuVUpabzV1RGwwTXVCNEhTRkhsVUw3Tyt4eUhoZGVj?=
 =?utf-8?B?RHZDcWZncHd0V1NvUEs3UzBPYXVUVHlJbTllZ2R0L3ExL1YxeS94V3RFbGFH?=
 =?utf-8?B?b3MrTTYweURZdGRPM2V5U04rdTBGbnI3Wk94V01yNHYvTG0zVlluWms1SklD?=
 =?utf-8?B?cXUrQjRkOC8vdjdMeFE3Njg0RHVTSU1HMlhtYzc1Vm5GQm1ac1B3VGRBSzNt?=
 =?utf-8?B?QjNwTFV1emhDMFk3SDlTbWxQYkJiaXVQQ1VrQ1phamdJZ0hHenRLV0JOY21K?=
 =?utf-8?B?eTZUdkt2RGRiNlg4Tk1VbVgrRk5Leit6aFNQV29vWUJFN2w4Nkh1Qi9Ob1Jj?=
 =?utf-8?B?blk3N2ttamZTbEszTncyQ29MYlNUTEFHMVB5SnNmalZLV3B2R0lKYTBEVisr?=
 =?utf-8?B?RTVNZlRJS21INVBYdVRUU2JsNFNwMDk3cjJheUptN2UvcC9QOFd0L1dsOFdl?=
 =?utf-8?B?YXR2Qi90bERXZzdmRnk0eDBSZ0lsMkdUcDQ2ZzNQcVhNNlJBWjBlZHBzODZE?=
 =?utf-8?B?cFVSUjd4K3lDTXhwaWFnUFg1VTBYa2dML2tQUVAwbnJPT25JdEc5b1Yvamho?=
 =?utf-8?B?d2dVRzBRQURyUGM2THZ4eTB3YmxQUHM3d2ppWUthQU9hR01wRm9RMWxmK2V2?=
 =?utf-8?B?TkE5Zm9OR1pFcWR6SVMwZjkyQUxNRUFBK25zcDRuNHY2SktSNDZ3WU42SWZW?=
 =?utf-8?B?UDNNR2lwUjd1a24wTk5yVXhWU1dqWmVhQ05uSjNYaXg5eVZqZGM5dmRvc3hm?=
 =?utf-8?B?dEQ3U0ZzSnFtcG0vVlR3RjZqeEN1Q0NhKzJKam5TWmlQNi9COVgwSk1LT0dv?=
 =?utf-8?B?V0srb2FMU0wza1R6TUhxTThSMy9OZVhvejIxNFhCUVNLaUUxZWhBUUNIdUdy?=
 =?utf-8?B?a2NhcExlZ3FwWVN5SVJScnVMZk12OVNxcVUwbEJ4eGFPZE95bnY5dDNhaWdE?=
 =?utf-8?B?ZWs3S05GLzZoSTltNmJEYzF1RG5ndTJwNDN0VGI3WjBNS2dOTklBQW54NVNM?=
 =?utf-8?B?amFVRFF6Znl5TGVSZHRWWSt0YzJTVDJtMUVBTlJmenJYNVYxcVBjNUplNTdX?=
 =?utf-8?B?UUljem14NUt1MkVnMlB6VE9RbDRPNFZaMnpma1NMMHV5UmZ2bW9icGdIMlB6?=
 =?utf-8?B?UEhxdDhuUHRjMVkyNGgvcWY5all2T0x1bjFIbTJtbnFQR1NySUtrOUhYallz?=
 =?utf-8?B?VVBUMU5IWVQwME1QRUFtLzZybXFId1FlTjhFMkR2dXNWU002UWYvdExQSTJ1?=
 =?utf-8?B?d1MyZVFJU3A3bERCc1UvcE52dTdqY2pRVVJJSlVLMU1GVzY3N0xweFpoQUxM?=
 =?utf-8?B?alFCMTRaSkE2TDhuc29FZ2ZhL2MyZWpyd2pxeUcwUTh6Wncwa1VNQTZicmVt?=
 =?utf-8?B?QmF0S2VaaGJrK25keWJzYTdGWXo4ZGRYNHVBMDFYSGgvNDM4RWZXbWhaL29Q?=
 =?utf-8?B?TFdZK3JUV01kOVRvOFNscmVDTzN0N0lBaHlxYklvVklzRzJlaityeVRvQVRT?=
 =?utf-8?B?OHdvY1JFQlYrN04wckEvNy9QdWJpbVpzalE2Ymo4dmxyY04vbVVrSEdhRjdF?=
 =?utf-8?B?RzdlSmlzbnZjWC9WU2VhRDVoSUFoQUd1RWwrVWNpaTlUZDc4SFJBSS9KUWcv?=
 =?utf-8?B?NVJvblovNFdIU2oycHdLdVBGS25kV1ZYNk5OZUZIa29XWWc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUdsSlpSS1UrT2FZWVA3YUxuajJLelhVZlFaVHB0QWVUb3ZKdzRLV2VxdlhX?=
 =?utf-8?B?YWR3Vi9HbG9IK08wZ2VWSmZSV0RVMVNMMTdlMnlTUXRVR2drWWt2aUpMR1Q4?=
 =?utf-8?B?WVVZN3E3U1ppSDlqaXgzQzdMU01oNy81VENUUmVsWXR2VWlzU3c0a2lMUUQ1?=
 =?utf-8?B?V3J1SEVZcUx3QW4xREtTTzI2N0dDODhmMThFb1JPOXY4TlRyazlLaFdXZlpO?=
 =?utf-8?B?VlFpeFpEb3k1VnljNXZnTWxpalRaOUlDcG5hQVcvd0VydHJLMDlMdm9FcEd5?=
 =?utf-8?B?RGkwZC9xQWxGSC82SloxL1pnQ2hxeldqano5aUkrVldrYitmK0VBdW4xV0dz?=
 =?utf-8?B?NFlTRWd4M3dxTlVPaFdxdVJsSXVIWVRKQlVLL3BseE9Cb2Jscjd6WDV4NCtr?=
 =?utf-8?B?Ni95bXRYYUpmc3Mwd0tBdFlEZDlZbFI0UFlBZkZpUkhGNUo1NWlYajFncGJz?=
 =?utf-8?B?TDVHeWN1QWdLYktETlVDMGxsYzhiMXpkUzIrTXFxellBWDdvZWgyYUlHeUl0?=
 =?utf-8?B?WDZYVkJXaW84Mzd5dXo2RzQ2aEFLTk1Ua3JvOWlOMHNxQlFhTFpnMmJCczgv?=
 =?utf-8?B?ZFZnMHV0TGRYbXN3ZUJiVGpFemRsVEE1ekdtbGFaUmo4QThGWFBmKzdDR0U2?=
 =?utf-8?B?bXZzK081UXFxd0paay9NazhsNFNUM0NSYjVpeDZuUmE4U2J0dThYRlpubTFh?=
 =?utf-8?B?dkVRWUV5WForTTMrdEZLSmxRbVB1UnVLcUVVMXBPek82T2lIKzJQVnhIVlh6?=
 =?utf-8?B?SmVSbXVlbUhBdndiWjFyRUM3Mldib0RZbGFmQXFHMjJnUitVZUhZak1aVFEy?=
 =?utf-8?B?NHdTZTFwcHEyUEZRM1RSZ1dOekdTMGdaMFVyVGxVZnArclY3ZkNDc3p2c2xO?=
 =?utf-8?B?dC9PNjNldWN3T29MaEpsS0RhUFFlZkpZT09FZUU0YU0zcjFyWm4zeEdYVklN?=
 =?utf-8?B?OTJIRnFFcUMzK3RMR280NVJUWW5rd2lYdnFOcm5mSGxYaXNnWHVxOG9TaWxS?=
 =?utf-8?B?RTVyTENVNElkT2NlUzZNN1dlbEVXQXNWd1U5ZytyTnJqNUwwa3ZqTkVFTDYv?=
 =?utf-8?B?QzB2S0IvSlBsTTFielF6YjhDV0I5VnFjODlQd1VXVDRPRG9maFg4QS8zUHZt?=
 =?utf-8?B?aitmR1NtRUZxTGt2Y00wclJwajZNbUpuRy95TkoxdUpHdVVST2p3Q3dMVGV2?=
 =?utf-8?B?dytoNnpQbU1GSHlTYVBkNk9sR0h3Q3lueGhtSjFEa1JhWFpJaERJMUU5Qkdz?=
 =?utf-8?B?dGNwVW9uMkFFelgybDBPSEpwYUVBVUNKOG92MWxTcExubk9YazNTUy9ucllF?=
 =?utf-8?B?bG1JZDlLdGhqejJpdVpWQkpzZlJRRHhjZXluQmZ4K0QrVmpjVkVOSlUxN1dD?=
 =?utf-8?B?djh1bE85YWxpUGRYTXhhYXMxUTZXbkhYWHlYUDJQM0tFaXh4YkRwa3FkOFdN?=
 =?utf-8?B?OG5Fa3hibW5QQ016SDl2NXRYd3hmcjBuSy9XRDlXVzZwaHZtaVNucUJrc2hz?=
 =?utf-8?B?YjJpWU1pVktTeXNLWXhPOE1MR2hlWGRWSFRGVGhjNFgzT2d4RGhSN3ljQ1lB?=
 =?utf-8?B?RUVvQ09rTi8wSE1zQWFMM2dJQ0IvaEFxQTBTbys1ekdlbHFiYk0zVWMxT3lI?=
 =?utf-8?B?QmE0ZTEwMy9VQTF5RXlKbno3bUN1aGFEdnhIdWVpcWprS0txNnpYN1BhM090?=
 =?utf-8?B?b3FtZm1MYmdnRDRWRkZhemtHQ0oxS2JnVC9iQm9ZZjI3UmsrQi9jUE9pUllN?=
 =?utf-8?B?NVQ3Z0hETVhYTUpIdk9DK2JxYURyOU55U3U2SUpGd295MUN0QkZwVlo3Q1Ey?=
 =?utf-8?B?UVQ2S2VQMDBMS0hYejF2N3NZU3AyR21VczB3UTc3VDRKS2lEU3dJdEk5eU1r?=
 =?utf-8?B?TWxmb3pHbG4xd0FYRmdCNWZQbngvNFU4SlBmM3Nwem1MVnZHcmlXeWFoSzhs?=
 =?utf-8?B?N1VIT3cyWnozVGpzUTBSdy9hbFV5bFd0b3NMNEhxUFJwazU0UjQvMThGa09s?=
 =?utf-8?B?WFBPVzRyVVMzM2dYWVBBYUxIZFQvSEZjZWR4S05pS1lyWjBDdnFOMEpCZzJw?=
 =?utf-8?B?QllxVlNlSFpjcVJORGs3OW5tdFU0STZWOTdIeldxcS9VM0U1ek9lNDRWMHNX?=
 =?utf-8?Q?V3AEwLxegyuMXjmpC/JRSXbB4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc89313-fc6e-4398-2275-08de30b9b0ca
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 09:12:02.8370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h5HTd7hmFgZXyIvhMtys/+MY41bsoiJdQ5y6B0T4hYgIXGcxOajAHGX+Un+kVTdohYLJDz8ISZ5pcXZOOppr/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8800
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Dec 2025 09:12:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20780

On 18.11.25 15:12, Jan Kiszka wrote:
> On 18.11.25 14:04, Chris Paterson wrote:
>> Hello Jan,
>>
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 18 November 2025 05:45
>>>
>>> Hi all,
>>>
>>> lost track about this topic: Are we testing by now a kernel
>>> configuration with PREEMPT_RT enabled on 6.12-cip? Initially, we didn't
>>> IIRC.
>>
>> Currently we're not testing RT on 6.12-cip.
>>
>> I've just started investigating how to enable this in KernelCI for all CIP trees, but I'll start with 6.12.
> 
> Thanks in advance!
> 
> Can we add [1] to cip-kernel-config, maybe even migrate it over? We
> already agreed on not trying to maintain separate configs for rt as that
> is doomed to cause even more config-rotting that we already have.
> 
> Jan
> 
> [1]
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/651c38c1c9d837331fb4c4a68a4a75c27163ced6/recipes-kernel/linux/files/preempt-rt.cfg
> 

Any news on this? Help needed?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

