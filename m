Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA911EE369D
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 15:55:55 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48327.1770911748247139216
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 07:55:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t9FRaEEj;
 spf=pass (domain: siemens.com, ip: 52.101.66.37, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwE7xjnmpIly22hbNrh9MVfVWieVhlZRVKf6zVttAOoWwUtONdvi0fTKFnxoj6Tl4RGv0NYD2eqGjQdvXvWnWUdx2pYGHqQexv7lmwaHsgnXr8p5N8Gy0HUFCgfyX3XzIWr12BgXC7gz8d8Kh1lXAGTW7vf9Zu/SXHR34wDbPnj4qcDXcKB9Z+vP4/OzEbF9R8O4mt4di0Z+1UIr2uePbyAnLgdtW4cGclhHUPqcsiTVPZPjM3/Lj086e35tgvVymp0SMEAanxgNt1KXFpeYckPucbpS8SIYatsXVDVsE0bVxIAgVzE+8dKtLQ13K4iFstcmqwSNMb6OqLK2htNi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEomAiG67a61AJdpDXUHovs5EnKCJQ5GC3rh5WR6kj4=;
 b=uxhGF0ShIxyxLS4zJzTBwHA1841qR+bg/YEwf8Q68xmlQS6fNNfTBRocKEmzZ+0MO7UC2uuhrTnYvq8JE20OHJYcuOp+FJaT7oFCFG0faYg989/aTypqOHYBrRx5aNFND8rRQ3dVNq3FwlymZL2jHrElsQGlRR0rpmG+MC35a8iSpQtxjARm2xF+NJSxGLB17cTTwm/Va8pAnJe5SbVi3JDsr5yJhvVZ9AGBKX++qbdsDC+EKjcSbFGfpf/2yAX+pZEvnmUZN453fN74giUO2C83s799MKc9Fnel8cRpj7bIAh9KW03htE+tQ+m7MWbeZYMViEHHRC3ri/c8LgxeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEomAiG67a61AJdpDXUHovs5EnKCJQ5GC3rh5WR6kj4=;
 b=t9FRaEEjD1Lar9xk4pJYqvOcbgJMS/duEh6GMyTnhavOESLdyk90sOr5rMF1F3M46fn04/KVoOBv/ksiwrNsncPHOmQwSh1F5R8duqjlOlXtOUz3EnvpfFCt8SXVhUMKGraJYJtuV7+L8TNMo1GpnfFUJWBSA1fwtXhAR0z+9Xhla3ARHNIHXLDo+3M2nFCWhW7MMtmxbt5T+9JHvlmXr7Zgjf/++WOrFMbK/VVcZFLIPDX2HN2Bfi0qho1GX/MEqdma7jvhwLnaXJdmZ17sY+tRCOZYm+btbZcLQjfvfqzoLrZ8NVEe+29k4ZYhIvlKHUxzCXykPe18vKkA+FjauA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7982.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 15:55:44 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9587.013; Thu, 12 Feb 2026
 15:55:43 +0000
Message-ID: <6d2c269e-cb7f-420c-ae68-b6debc1ceb0f@siemens.com>
Date: Thu, 12 Feb 2026 16:55:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 1/1] swupdate: Enforce signing and
 verification for swupdate by default.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20260212130141.709378-1-alexander.heinisch@siemens.com>
 <20260212130141.709378-2-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260212130141.709378-2-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fc12c78-f038-4985-4165-08de6a4f2d67
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L2xFUjZjbDljdE4rSlZKQ2JVWFdadTNmY2hmcTFZVTV5dUVYd0Y4b3piQkpD?=
 =?utf-8?B?QnVuQjYydkYzaEdGRVhGSnkxSVlJSlZRMUEvdmp5TzI1eG4wTklwcVZjWTdU?=
 =?utf-8?B?WTBERnFoMmZ2QjQzMUxKQXZXV0U0aFc3blY5b2VEUW45d20zM2Exdi9yUmdn?=
 =?utf-8?B?Y0hNY2piSStUN3VZenhIbDlIaXZiemoydGlKcmVUdTN1TE1OUE92eHpTOTV1?=
 =?utf-8?B?M2NlaWxPZmxMZEI4MWFneUVHY0RQOEpaZFE5NzhlZ3c0dXE0R3dHSFpKR1kx?=
 =?utf-8?B?Z0tVWG4vTEhJWU5WVGIvK2dFYmlUaW9WaTV1YUszSHJLSXVEZ25WSCsxUE43?=
 =?utf-8?B?L1lpL0kzVzRDK1dVdXY1YzVtdDg1Y0lORWVvYnVqU2RoNm9nd1dnaGEzMU5m?=
 =?utf-8?B?bjRoMkZCUlc5a3AwZ2RqaVg2RHVpWVdHR2ttd09KRFRzUk8xU2ZwU1VTYnZK?=
 =?utf-8?B?bkhtNkZoSGcwMXB2bm92ZE9jTm9wMG5rbEpuN0c4b2lXQjVOcFFqd3ZodmZX?=
 =?utf-8?B?MDcvV2d5cFR0UFVWMUd4eCtwNDJDY0RreEVHZERVM2I5eWF3ZnFpNFJzNjVN?=
 =?utf-8?B?eGlaNGJTYWVwTHNxTzQ1dVk4TnVoS1REbTlYQmdHcnVHYy9NMzZFY1BpTmFl?=
 =?utf-8?B?RUZDa1VPRXV3V29nQXowMCtJNHBHSzZNbk05cTNhSlhZMmNNeGU1VHdkb3BI?=
 =?utf-8?B?UlNDay9lRm1ET0tQK1p0R1lMYzloWlJPZFRIa3g1cEMweVVqUlEydGx6ZHRL?=
 =?utf-8?B?NFNVakZLV3NZc0RVbmYrM1NGTGxSVVpOMzBzOGpDbExFVjBjcm1hVDluTXhi?=
 =?utf-8?B?N2I3OHVDUFhnMWpRalBHbm1iS3F4TWRXWXpvQ2Fra3RDcUNkcDRySDdRYTE3?=
 =?utf-8?B?eHdSdVQ3dndxVCtoN1ZUZkhoSXhhaStZMmROUnZ0eHp1UWl2bXFPT0lJbmRV?=
 =?utf-8?B?emVnZnAxRzhhQk93cmsxY240Q2dzUkQrQzVqbnAvQndMRXZwaTl2ZEdjV213?=
 =?utf-8?B?UTJ5azMyMGxBbU5xSjhmaFg4cU1QK2ZITjdZcHg4RWROaW9zcWRzN3FjVG5G?=
 =?utf-8?B?VSszTFRPdjV6WHE4M3MrUHBvcHFKeTQxK01TbTVQenNUc1I5eGtsTVVFN01E?=
 =?utf-8?B?eldoOUNHcXkzOWZzMzM5WlA3Vm1ZUkxoQk5wTXMyZ1BEVHRrRUFvUTQyYTJE?=
 =?utf-8?B?Yk44emh5RXR0Vm5zby9hQlMrL0w4OGR5ejNlQzRIQklpMmxpZWdMSFRzQ21K?=
 =?utf-8?B?NmF5ZUwzSFZ0RGlVcklVYlhueHBRbDlkUzl4YVg0RUI2N0VKY3RPRGdad3FY?=
 =?utf-8?B?cGY1ZVo5TVR3ZzI1dVM4VW5tWVdqK3dLTy9CVzd5Zm9rd1Y5Tk9FZXZVb0V1?=
 =?utf-8?B?WVRxZ2RTTlFHS3UvNGJHZm5BdFllWDZ2YXhYZUJtdWRpS2M5dnN1VG9FR3Rm?=
 =?utf-8?B?WnJSaGZQdXdiUW82eEpWbVVsWW1yYTN6OVJzc3Q4bGc4SWpyUm9JZWp6YTdI?=
 =?utf-8?B?NWFEWnhFQ2RCdzlVTjNsa0tSakpuQS9EWWUvZUZIN0VJd3loSkpxTU1Kdjhn?=
 =?utf-8?B?cUpheVMwM1RCVVhQNGJhd1VTL2wrTmt1SHhFVS9ma3ZmMlZJU3R5dFAwRmFH?=
 =?utf-8?B?NjlTSDdMaFQ4SVdxSUhkNnBvRlhIV0dubFRuTkk4ZGx1eFBTeEJMQXZyNGtn?=
 =?utf-8?B?c2lPbnVuSlFkOHZ5UVVWTVdCVTF2V0Ftc2N4L0VNZGVmQU5NdG9sS0dublFv?=
 =?utf-8?B?TUVmOCsra1h2aDRoeU92M1pCQ00zdmtDbkxRYmxrRFFGNUF6dzhsUk9Kd1pp?=
 =?utf-8?B?dENiQ3ArZis3Qy90L1dTaFp2VUcwS3NUWXlSRFJKMXI5bEcvTUpMZ3l1L0lV?=
 =?utf-8?B?TUZRbWVRRUMzSXo2b2JrSy9FRy95WlRpK3lETDNLckpaazdlMEgvcFNTTFFO?=
 =?utf-8?B?RG9rMlhPZDJiK0tWcEpWZTZmcEFnK3Z5ejFoRDltdDRkNnFJbUNDRzdkNDIz?=
 =?utf-8?B?NU9iMGRJNEFUcU9CR2owb1VpN3VHdzVSZ3U0T0wxSit4RzVENXFwb1lBSjZK?=
 =?utf-8?B?RlE1b3dCTlAwa2c5bmN1Q1p5R3doUjZOVFd1MTd2VG9IcGtOTG1hV1d4Y0dh?=
 =?utf-8?Q?WiCI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWlSNUZ3WjA5R2U5ajhHSzNZZXN4aGJCdDdpQmNxWUxlL2tQc3k3TGJwaWRo?=
 =?utf-8?B?TXVtbGROTTZUcTdtVWFoU2MyVCs2a0dkbk91MWwwVXN4NkJDaTNSS3R3N2pk?=
 =?utf-8?B?OGJCcm4wV01kRi9IeDBkY3BOMzF5cnR6NGx0YWM4OXlTN1ZhUlVmOGorWUtL?=
 =?utf-8?B?Q2NDdUhIamVPMTNkL1VGc0ZqdkVxbkYzNHJXbjJLZnBLQVkzUG9tWFNISzhK?=
 =?utf-8?B?RThLSkpxdmc5aE5UZUs0cmZjVTdRVFR0amhQdnFxakZMNnZsUkRiYWZwUHNL?=
 =?utf-8?B?aVJxY2Q5ZEg1UVpxSDJwQUd6L3lYVDYyWHJIUzhJWTRWRHgxM0d1R1YrakNn?=
 =?utf-8?B?TUpZME5yMUg0REx2Q0NtNUFNWUhEZ0ZFeEl1QXlsYUNYNExwTi81VTBsOHcx?=
 =?utf-8?B?NGFpOTV0Vkk0VWI1ZXhoN3dVcU5udXFZcjFUK0dKY1RaZVVJaUxSOGt2c3pG?=
 =?utf-8?B?MEVjM0JQTU9zVkx5L1p6SVluSnphMVIwK1pPbVlIUU1qRWM1MTRZVE5vayto?=
 =?utf-8?B?K2EraUVDalBWelhzcGdhc3RPa1ROeXNXYmIrdEVFd2JiL1VRNXFKaU1QNmtr?=
 =?utf-8?B?UjhUY01DSldseUxMZ0tNdVp4QWExQk5FNTRvZ3kxSTMyYTMwdEhnNmZBUVVl?=
 =?utf-8?B?SnMxa2FBUU5rSTMvbkFLMlJlT0pNTjF0MG4wYUNWbDczQ1RwVWhwQkdiZG1a?=
 =?utf-8?B?V29jYTRqUHZGOGJOQ3RhakI0UlAveUVQbnVFbkJCQUdOZkxldDJqWGV5RjBH?=
 =?utf-8?B?VGY2L0dLaUVnaCtLVTh2WUFIdEs1bUF3VzNVNDFUcXZoanRMMm5Ga3ExK1lk?=
 =?utf-8?B?WDd0SE85N2dkTkFCUUxWUXkvTlBZaUtnTi9EMmtFWUJ5NHdDcWwrOFdoWjhD?=
 =?utf-8?B?WnpEOFpkWVh1QjNOeWZHbmJvYUFRNHBLcnJtb1pLZlVVOUJpdkw0aEsvdEtx?=
 =?utf-8?B?Qnl0OGU2ZEhBTHhTQ0JUOWRTOTV5TDl1NkQ5V1ZZdURUdW50dFdWL0FSbkx4?=
 =?utf-8?B?cWltRnBjcnFqVVpacW42RGFtSzlpbXRHZXBvVVJIQWdHMHhJZndFRTFJSzgy?=
 =?utf-8?B?RmxvM1BtMGNud3Rzc255M00rTnh4cWdHQ0p4QjE3clNCVTVKS1g3NWZzUmpL?=
 =?utf-8?B?eE9aL1JGTDA2SVhkajFLVGJLQWovTGhxc0FYZ3dJd3ZIbDdmZmJXS3BTbTFl?=
 =?utf-8?B?YmRXYThoWE0zaXRjcVVpK0pBbGtKRmxlQVQrUWZXdngvU2JFWk5BbWxodHo5?=
 =?utf-8?B?T0RrdW5pWW4xUFo1azBhZEJFNlhWVjAxcnhEWGlUVC9taitnTnVQb0NISkI1?=
 =?utf-8?B?R2x6dHcxN1ZoaXhIZytNL3YxUk5Sd25tWC9yb3BidU9CZDBwMndQejFYQjV3?=
 =?utf-8?B?S3hWSUI1QjVGVkFGNlRNUVRicDJqN1VicmtrYUxzYWVsWUVGcWJ2L0N0cnd1?=
 =?utf-8?B?NDVFZFJrRFFUSU5wcU5RR2RtT0x2dVMxR1MxaG5xUnBCTzc4TTNqZkVwM2lr?=
 =?utf-8?B?UWRkZUtzK0s1TkFvaUVqLzFoWDBmT2FkMFUyNVErdkV4V2FRMjFUTXExeUt2?=
 =?utf-8?B?UVdFTituZ0JvSVhKMy9ueE1jNWMrQm1KNTBYSFJwR1ZQb1FXRGxVa29yT1hT?=
 =?utf-8?B?UHM4ZmxGVkVJYVJTVVNOVzZ6aXBiR1d5bjVwNFVCSDQxVU5jakI1SXdiN0RD?=
 =?utf-8?B?OFJIR0VzclAxaWxBc2hMQy9BZ3BXbndvaTNjSEFsblVKN1lPN21JRlZxMGlF?=
 =?utf-8?B?TUQ2aVFVWmFQTmE3K3pOS05EME9pcFFOU1ZCbDZ6MEdDQ1hrT0tYbEVvcFdV?=
 =?utf-8?B?aEw2bkVML3VsS2lGdXdyMHhyVStqd1d3b1d4VFh2a3FPQlJ1eUNBNTcybFZr?=
 =?utf-8?B?SC8zcU1DMWsxTE5hVERZbFYxZTNDbGRPcVlXalA1Z2VOQUMzSDdKdTRkN0xG?=
 =?utf-8?B?UGcrZ0p4QmE5WnYyUm9FUGRUV0d4QjAvNUxuVkhOZjEreDVIMGM5N01Vdmx1?=
 =?utf-8?B?eGtiVlpidWJPeXlFMDRGVGVaWndaeDhiclJNV3pZc1FrRm1hdU4wQlovY2Ns?=
 =?utf-8?B?MVVUZW03cUV5dlZnb3BmRW1VR3B1elpQZS8xWjJ0cFhnYWFneExMZHJEdTRh?=
 =?utf-8?B?eTZhRzJqeGkzVVlGaW1UY3I5b1JRc21kL0tSSUMrRVFhOUVGRTlNUGNrM0ZT?=
 =?utf-8?B?ekI2dEFLbk85OWFPL0JZMk45WTA4ck1ENG9JTExnZDE2QkpvWDIvcktGRmov?=
 =?utf-8?B?a2FsRFhsamJRVVJJODNlTXZMVm5OZmgwMnlNbytwTjJDRVRRV01Wdk9yRDNO?=
 =?utf-8?B?cnNEcC9xZjJ5QVlGa28zTW1nUDZxNG9zU2NFUXk1Vk40STdLWTdBYjZEV2h1?=
 =?utf-8?Q?H2K5E1dx7Bsay660=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc12c78-f038-4985-4165-08de6a4f2d67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 15:55:43.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4MDHK+4n98zXUHnMEgeq2bRZr0Wzfq/tz6f615Hct76m5kTDQHoo1AwVyzzPWvfn4rirEpIypPDxo25q62pGtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7982
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 15:55:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21864

On 12.02.26 14:01, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> Aligned defaults for SWU_SIGNED to enforce signing of swu files
> as well as verification in swupdate binary.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>  classes-recipe/swupdate.bbclass    | 2 +-
>  recipes-core/images/swupdate.inc   | 2 +-
>  recipes-core/swupdate/swupdate.inc | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/classes-recipe/swupdate.bbclass b/classes-recipe/swupdate.bbclass
> index 59dab9f..962e526 100644
> --- a/classes-recipe/swupdate.bbclass
> +++ b/classes-recipe/swupdate.bbclass
> @@ -39,7 +39,7 @@ SWU_KERNEL_ARTIFACT_NAME = "${@ '${SWU_DELTA_UPDATE_KERNEL_ARTIFACT}' \
>  SWU_IMAGE_FILE ?= "${IMAGE_FULLNAME}"
>  SWU_DESCRIPTION_FILE ?= "sw-description"
>  SWU_ADDITIONAL_FILES ?= "${SWU_KERNEL_ARTIFACT_NAME} ${SWU_ROOTFS_ARTIFACT_NAME}"
> -SWU_SIGNED ??= ""
> +SWU_SIGNED ??= "1"
>  SWU_SIGNATURE_EXT ?= "sig"
>  SWU_SIGNATURE_TYPE ?= "cms"
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 00e972e..2f06081 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -32,7 +32,7 @@ SWU_COMPRESSION_TYPE = ""
>  # is used. This images are stored in separate partitions.
>  RO_ROOTFS_EXCLUDE_DIRS = "boot var home"
> 
> -SWU_SIGNED ?= "1"
> +SWU_SIGNED ??= "1"
>  SWU_HW_COMPAT ?= "cip-core-1.0"
>  IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-core/swupdate/swupdate.inc
> index c92b14a..4f953b8 100644
> --- a/recipes-core/swupdate/swupdate.inc
> +++ b/recipes-core/swupdate/swupdate.inc
> @@ -32,6 +32,7 @@ def get_bootloader_dependencies(d):
>  DEPENDS += "${@get_bootloader_dependencies(d)}"
>  DEPENDS += "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d)}"
> 
> +SWU_SIGNED ??= "1"
>  DEB_BUILD_PROFILES += "${@'pkg.swupdate.nosigning' if not bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> 
>  # add cross build and deactivate testing for arm based builds
> --
> 2.47.3
> 

Tried to apply, but all a got is CI fireworks:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2322072912

Pulling out again - please address.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

