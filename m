Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EAFC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 09:50:20 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.4])
 by mx.groups.io with SMTP id smtpd.web11.4646.1740477018221255262
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Feb 2025 01:50:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=duwfyrUr;
 spf=pass (domain: siemens.com, ip: 40.107.159.4, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5WYVDy/SKklDuhjFjwzVfHsVjpyejQEq/Pm+GPN/smjIH/6pwhneLukdyNHzQFYp31fKy6BsTrxkC+NNQ1BDH6haf6rTVcVFviv6x+MHp+0I5m02q7MqmkiJ2SxezFsQmWOzAnTUmowJyxravRXbWlfLZncOjP1PxvjGLqZgPR8M4M+8+D/XKsDzOrgxSm1knfDIUXF8EfQZiRhDwHt0cAyYgpzT4nIibCJvADg6j6g2qpyt0mvBJhdadentTe9febwZ7ljle6YKzkI7TmLjzVw2/KMFCoKQvUveiOVo5QhDkM2ZsTmWomQW29srba8+3Xz2iSPcuPZV8U/GkLZtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezuP9q4yBpsBSqcLiOR/6Ika6anW5dHw3YU/BuGnuNk=;
 b=VAux227/wf+ctLSMW26psb+swrJqqexGmUE3FYZow7+4jDFi+TF2Ecxje/M0CNNg4twplWKHkF5h3oSz6WqOxcSj1l0tGI8/Dusv5wQJEj5/F2vE1UZHexuoCKaLWGkt8aKtWjmXTgdwxQ7rq8FbxtX92XKInJW7WirNOyoMbWCFLQWhuz/JUwr7GKLFm1pa+8UVQCwUY150GXqkdPEYQRlkllrZfD0J7vVZ3xWPo9GtEKsaNSoFApkW2aRivX/DOwukOGDlHnO4UeQ47H6Z/+n3+GleQW2McvSWHFSLXt6kLkt3tijc+mTyfxe4Xuk3kU23RXGvjnxJcYQKonvSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezuP9q4yBpsBSqcLiOR/6Ika6anW5dHw3YU/BuGnuNk=;
 b=duwfyrUrhFhflMQm9+ih4gnJM+rZnq7YZu/ToXUnHbK64b8j0VveksEqxIkgF8sVxvmfJo5kvOxyMj1Q2ROsMbSAi0qcSQkImRHibZWSr0avocN22yqBJghshvv2szjA1gy87d3OO5EZ5goOCgmYGvkER/dF+GHFZa2hwSoVAelbBdaXnsIWFFb636HSQhocvBTP2PDi6YRqRF10NC0Cr4+gZkPOf1m8ASGOwwRsdoNJQOJI7qYPIU92/didXokKMy4XKbqzKSrSwAr8P404TKq65VgrAth/i0UWGKoH8WUdtdPrccZAO5QLrd4ismwtc/m9OaC5+SYltsorMHNl7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:348::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Tue, 25 Feb
 2025 09:50:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 09:50:14 +0000
Message-ID: <ef4331c3-2142-46e8-9503-2c2f04dd376b@siemens.com>
Date: Tue, 25 Feb 2025 10:50:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v1 0/2] Test reproducibility of wic images
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, sai.sathujoda@toshiba-tsip.com,
 dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250224090052.260495-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0007.namprd07.prod.outlook.com
 (2603:10b6:610:32::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5196:EE_
X-MS-Office365-Filtering-Correlation-Id: 07f7d13f-6af4-4560-11e3-08dd5581cd99
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Z0k3ZFUvNEpRQTlGWUdnRU9pWFZDSm9mcDRRSjJYMjMwWjhtWERjSmxvZCs5?=
 =?utf-8?B?MFlDZm52VHF1aEFTTWJMV25uQ1dGTHo5ZlBoWU1ZQ2VIZ2d6aU5FL1A2OGRk?=
 =?utf-8?B?ZUJJZkJacjJqTmV6dy8zR0dURU8zaEdxaldCNkNmelMyOFhycW0wY0dBYjNj?=
 =?utf-8?B?Y0FyV1hzbzMwQlVBV3k5RSsvSEROL0RFRWJySnBjN1IrUkJyZGlVcWtqc1k4?=
 =?utf-8?B?Znk3aldQeTUyQXNPNG5oRVd5TndDTmtyakNPd0xsRnZmTUx2WkVlT0Vxc2JI?=
 =?utf-8?B?TEZrM09Wek1yczZvTHhjN0EzcE05bkNwWGhDVE5uS3o4T0pIajBpMjc0dTFG?=
 =?utf-8?B?aGNudW13NkZYVDIyTG04cWk0K1pSdGwyRENvTVdDTDJEcnFkZUtHS1lXZWtI?=
 =?utf-8?B?TS9oOUtSWHJESElyWnBHN2hUenJQcGZmUy9LWVJqcXZJMHl0UTVBK1FpekZn?=
 =?utf-8?B?dm5WZkQ2Mm9wVmk0UnhYVDlUM2N2TS9YMHNYUjkvR24wMlNsbTdlMzRzTDFF?=
 =?utf-8?B?eUdKL3Y2SlUrbVJPN0dzK3d1a3dWS3NzcnN2dUFieVpTZTAyQjJIa2xrQ1RT?=
 =?utf-8?B?TFdtSDJqcEFrZlorSXRzSVFDY1pYV25qU3BaSlNEMmw3dWxVTTBZdTdScEhw?=
 =?utf-8?B?UERSS2QyYlVBbjhQaDJHQXFjRUwwYkRidG83bnJ1VDdFK3oxQ2hlMnc0YUVG?=
 =?utf-8?B?R1Rud3A0dkpudktnalNVaFNVWTRUbTExcTJlaDRiMUFReURiT0xuMXg5ZkNN?=
 =?utf-8?B?Vy83RVlielNhTmZ5WHgzRGU2TXJ0dzNCM0Z3UTE1TGE3V3c3SmJUV01iOEJB?=
 =?utf-8?B?WFBnZG1sRjhXYTltandBSklYeFlhMzJ1czBvdmhOanRubkpJNHdXQUlhcm1I?=
 =?utf-8?B?dEJSTTZkcndLeFYvZ2l0NGlyeDZDS1dCTDlUelpJZFRPajFieDEzTldMOFlI?=
 =?utf-8?B?Y3hHN1ErRDF6QTZUYXpVazNZMUxGT05VZ0Y2cHpkRUNxOEF2RGpNeTJZbldL?=
 =?utf-8?B?WFRGekdZS3Mwc0IyUUZDbVRBQ0l0VWRvZEVvdjEzanFGVFFKMVRhd0s0SDNs?=
 =?utf-8?B?UFJ0M1ZnT3ROOThCd1hkSWpSRGMwRHljdldvTnBmZm1mRVNLWTUzTFJFWVIw?=
 =?utf-8?B?UDFCQkd1MjJlbVEzV1AzbmMrZ0pmMzA1MThPZ2xYb2dKNlgwdTRzVHFuMWhp?=
 =?utf-8?B?dFZtb2l3TmpVYk1mUUZtNStXMHJQMUpibEVMOUQvSDFsejF6emdzdEFDYXZm?=
 =?utf-8?B?bzJ2bnBkUFV2YlBsMExYNWZSTXZpRnUybyt2UXcwYmI2dzkrVGFnYm90d05F?=
 =?utf-8?B?WW9hNVFBMFlWRjRYNWRRUXhVc2NPMVh3aThMaW5XZ0FHdnlCMlUyYmdxb3ZR?=
 =?utf-8?B?NHZCOVhZeE5nay9QajA5TGpqcGpMa1hnRlZDanduS1hJTytEUmxxUWhFNVQw?=
 =?utf-8?B?Skh0UXBtbDRoczNBUmRHWDB2Mmk3Qm4ySjRRVnZCdldaSEpVbDIrRGNZNHRz?=
 =?utf-8?B?ay9VQ2xhZ2dxMDBaNVpFalpDa09pcW5TdE93ZHBZcmJseDd3Wlc1L2VkSnBt?=
 =?utf-8?B?VERRemc4ZGVDT1ZEanlKQTFVbWoyT1pDUVY2OXFobWd6bjB0TDhwZjBjZmtn?=
 =?utf-8?B?dEl4NTA0NmR1M21sS1RueGM5VHZHaXFVNjBiLzJINy9UcXJ2WjlpN3l6Rk0y?=
 =?utf-8?B?UnlBdXJyeVN4UklrVjMzS0ovTnZQU01WMW14cXZ1SEhvdzVLZ3BqR0xTbFQ2?=
 =?utf-8?B?RGlRVkF3UnNmZkdXYTE0MjFPT3grTHpjV29zbkFRa1h0N0hWVFJmQTZVTnpY?=
 =?utf-8?B?NmQ5MWcvOTNvVFR6ZThFRXo3ZzNtcGQxRzJTZ0dzM3UxUjJrMStZL2tHTGM1?=
 =?utf-8?Q?kjWMcAUAw/7bS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R1JuaXFoSHFmOFovcVl5UUxIYitzNTNtYVRyV2Jxa3pHMXlYcFd2TTNSS0J6?=
 =?utf-8?B?STc2N3FCbkJTZldISURBRlFTRGhDc3JLd3J3cHJlQjVNZTR6a2drS2t2Q3VK?=
 =?utf-8?B?NzlZRk1KT0oyZUYxY2p5ZFlwdk9iK1NMVlRPb0w3eW1JVXVXMnFadU1aNWY5?=
 =?utf-8?B?MTBIcUFnWVArb2dRd0loVWlrcGlvTU0relc0UEc0THQ5OWZoQmc1Mm9FWnhx?=
 =?utf-8?B?S2pyYUFxS2p5UWJtVzBPSzg1cEZYQ0ZHU3ZVNWRiYXU3WDFqeFVmMUxNSnFZ?=
 =?utf-8?B?TEp4VEQ3QTIza1RQT3JoVmtLbnRpbDZSRmQrUHlDVHJ5UlRkQXhLWjZPZkM4?=
 =?utf-8?B?Y2w5am5tM2o5Q09vcmxYZkd1SVFWRXdJSWh4UmpQa0had2NNdjJUVG1zK3l2?=
 =?utf-8?B?eU82OXMzaythcWM4SW1EaEZvbnJkU1dWUVBmWUt5WEpsblNQTkpQZ2IxMktZ?=
 =?utf-8?B?UHJQMmdnZG5uSW94ckc0NjBSM1pJckRkL1VxWWFVcXRGNFdLYzVWUlg0Y29k?=
 =?utf-8?B?eGRSSGRXbGNRTFRlVzIvaGdQaHVhb1BHcjNpNGdmZGlNVzQwc1hBNDJwQjJO?=
 =?utf-8?B?cFE2d1NtaW0rRjl6aHR3WDFoVG4ycU93WnFDR2krRXZXK241ektTVVVoUXps?=
 =?utf-8?B?aStvMncwVTVZenc2VUZMYXdnRTJRTjhQbEJ2MmlCdWRFS2pzcnVDaUFnQ1RS?=
 =?utf-8?B?ek1mSllUamQ4SXhZa1ViVDlSdU9oWnQwdHAzam56ZFBKamxROSs1QVVnMjJq?=
 =?utf-8?B?MkNRWkU4VXVXdmZqRDllSTBINGpVVWluanY1UEEwL0RYa0JEUklrZ3BaRmtn?=
 =?utf-8?B?eGI3aXBVSEJka082ZUVHV0k2TlluVDlqRUJUeTlCR3JUOWFLaEt6Vkk4S0wv?=
 =?utf-8?B?a1lqUmpudEFIRFZXRUFlUGdJeGswS3R3bDlIOG1FbDc4eDY2SU8vdm4xa2k5?=
 =?utf-8?B?NFR5TFEzL05lYmUrZXFCUmRxNWxaNGx4TFpZQktGNDBQbXEzMVQ0ZkdlM2VU?=
 =?utf-8?B?cFF6aHdNd3BqR29kT3Q4VDMxWXB3Mmw1VmxsMERERjlMSjltUHNlSkY2R3dp?=
 =?utf-8?B?NjdLUnh3TzdRaVFpK3Zzcms3bkRwUmdDMHZqR2FJSVJhZmdrQ1VzaDA3TTd3?=
 =?utf-8?B?NVFodWxTYXVIQkpwZHhtdmVKU24zaUs5MDJDNThHYjlNclBTMHFRaXJhVitR?=
 =?utf-8?B?cHBpYnh5YVgxYnJzc0dEblBNMU5oRUFJdGlTZmJZQzQ1SVliQ1RGZ2QyZ1Nl?=
 =?utf-8?B?Q3FqR0NYRFRyV2hSU3NOVzVmUXo3U3drV2lFRTA5NVRPaFpkZGswL05wWk5M?=
 =?utf-8?B?bWpNUlg0OVlzaWFBdmRyMUtxczhqcWlHZ1RlZ1NZNm4wQTJ4SHhQRHdxRitp?=
 =?utf-8?B?TFlBYTI5YnpuNmNPdTNZQ3MwZ2N4VWhkUnR5RDkxTDlldm1UNXRkVWFES0Q0?=
 =?utf-8?B?Sy9xUmFCUEFhNVNpd3pRVkJvY2xJRlAxNTQ2RndxTGtKUEc3YWJYd3dnbmRD?=
 =?utf-8?B?bGVDWXFsTmFrZmh3bXA5TUhmTmlmejFleHFqZHJBdnZSQ0t0RmEyclpseVQx?=
 =?utf-8?B?N1daaXFjUm9Oa2cyMmNsbWFuSVZsZldlNkM2OGVERlZUR3l2bEh6YnVZNzN1?=
 =?utf-8?B?cnBwa1pQazRmN2pxd3BzVTB2QW1iVVRPbWd1ZVRHb0JBQnJ2ckFLeU14aW1w?=
 =?utf-8?B?OHFGMlNQblI4WEczc0dEUmZBY2JFMDJsd0Ftc3hENFVJT0VwV1h4RXdYdWwx?=
 =?utf-8?B?eURiek9NdkljSG5KUW5XM0pkR0p3WlVQNFZUN1o0ejF2V1hhQjMyUHRSRXRR?=
 =?utf-8?B?SDRhNTBTSERxWDE4elNEV0xyMUt5K29UU1FzMXQ4azByRmhSeENSOCt4dUJj?=
 =?utf-8?B?VHduYUFzYjhpTy9kMnlHaXdCZzRiQzRaWG1KbXgrNUJjSXFkMExJMXNNL09J?=
 =?utf-8?B?QUxCVTMwNXpmR205NFRxWkYraWZySzdrZ2xkWFFmOEZidEZLQjN4d3lzQnI0?=
 =?utf-8?B?WXBsTlQ1YzV6c2JjVGZVcVluUUx5eEZiMCtPclg4MDBOUGphOVd0aTNBUmdS?=
 =?utf-8?B?bW04c2YvUlRJNGRSZENBYjJWV0Z6S1NNcVI4aFdLY2pPanFXMUZlRm5NaVFo?=
 =?utf-8?B?SkI2UjE0c2FvNkduNlROYWQ5TStpcWtGZHBuWjd1VHNEOURHMnRuaEovV1Vl?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f7d13f-6af4-4560-11e3-08dd5581cd99
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 09:50:14.7212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0RwhklImvxa1ZZayCchg1scK7wwIc8m2frsHLF15keh/CQRBR2eeK2vWwdi53pl+74SWFX8vatqplw+zazxrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Feb 2025 09:50:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17907

On 24.02.25 10:00, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> Currently only the individual partition images are checked in the
> reproducibility test. This patch set tests reproducibility of entire
> disk image too.
> 

Are we now testing both, partitions and full images? Or are we rather
moving from partition testing to image testing with these patches?

Jan

> Adithya Balakumar (2):
>   .reproducible-check-ci.yml: Upload wic files for reproducibility test
>   scripts/repro-tests.sh: Update script to check wic file
>     reproducibility
> 
>  .reproducible-check-ci.yml | 10 ++++-
>  scripts/repro-tests.sh     | 92 +++++++++++++++++++++++++-------------
>  2 files changed, 68 insertions(+), 34 deletions(-)
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

