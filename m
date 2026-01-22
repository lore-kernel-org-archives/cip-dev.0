Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62622C44536
	for <webhook@archiver.kernel.org>; Thu, 22 Jan 2026 10:20:38 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34299.1769077230978235081
 for <cip-dev@lists.cip-project.org>;
 Thu, 22 Jan 2026 02:20:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MdX6g6t2;
 spf=pass (domain: siemens.com, ip: 52.101.66.57, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8Lxcd9T+rMKgLa3qBupcQGM0xmQXJiEKNXb6yHD519h3uIvSQl2u4ggQZZLPbSQnbBUr1O08z0pRZ6WtPOMZw9K4rYQaMdKdCbLMVL4Cbhm61OHC295KCfUSGu4jC5/M9s9Kd7dj27SQ+XONTxRtikIsp3tw/yFwx3qzcWuf3AUdJpoMEPpTLjoxq09eZTdh8FKJPYo+8H23n60RZJnUsgFiegYZIqj2smq2fF2KnStU+KpfFbkDtiR4HKwOOOQu6HWO1z12mDi3z97JgQCteoiAjX+wd0SiBu2QP2O6VGNVSmnyF2LQJgOBJxVDW6nGUTxZv+6sb4brhLdzlBBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C8u0ruJdbW5vvGrJ/lR+MV18J+euBF1XFcxlztvatEk=;
 b=j5k7CFySAQsqGl8K7yX184xJIO+HC0YqBHkFDWCMcJBn2XNjz02pa70lVk7QracrSZTmEKE85yYcmrdNSfWccEiMKlDec/j2ELZ/yDpuFzIX+AW97ALN4uJuAvHVJgkmcZFcuikT3wkyPlK0JRc+ohkk5Ah6AuKjHB0ATjDake2AEg5WpMh5/twOwQ6UTva0A4ST+C3wNShB04IcRP5337n+q2ZrWHLAB/WoiSbxEJis0mJJumry/cmv0hykTvoVPbsnRgz84zcTC6++TYrNuyK8Zzs3h615FFTc2k1AoHCl5IFqoiBHVmyYK8t2he9FBeyPHHMDYniae+mKMNmntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C8u0ruJdbW5vvGrJ/lR+MV18J+euBF1XFcxlztvatEk=;
 b=MdX6g6t2CrXQsZK+6YkenxL8hp99wbXLyoO0F+otct6pktxPbLeqajCOz7B/Wtjj8Th4UQDFTO7W0ddB1rghig8fDOZXerOCj8mbZa+Gj207hsErxEWvzoXegjZte2SRRdyh5Y7Ib+03TMElVT8BzXDhr8NFKErsL9LVI9vDdk1UAMyDVMTv1Mupy+pW4OHowLDUghqsaacj3Li2Ihxrd+cvKdj/TrRbF4tSBUsqhbgyI1RUIpbOvjgQoygd+ekrGVGer4kHQldIhG1sHUAGNbLR2Rgt0LBUXTp2rU7cufXD4e+9EAPdyzSDs3wixgru8J0suNgtWcqLJ9QopRHZkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAVPR10MB7379.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 10:20:26 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9542.009; Thu, 22 Jan 2026
 10:20:26 +0000
Message-ID: <129e336e-e74d-422d-93c3-ea3d63c66658@siemens.com>
Date: Thu, 22 Jan 2026 11:20:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 3/4] swupdate.inc: Enable wfx
 based updates if WFX_URL is set
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260116120347.1733494-4-Adithya.Balakumar@toshiba-tsip.com>
 <38c0e8b1-4340-4991-8c01-9b7cf5c51d14@siemens.com>
 <188B3C54C2BB568A.3242018@lists.cip-project.org>
 <TYCPR01MB9669482AEDEEBBE66196C416C496A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <c9a3d41d-0491-4c4a-b1e6-ef92b726a7eb@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c9a3d41d-0491-4c4a-b1e6-ef92b726a7eb@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0044.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAVPR10MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e563424-b305-4be1-17cd-08de599fdbe1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dk8yZTBvUnR3R0V6Z1h0aitFRXdHb1o2eitHNkVZTVlzMEdESzdsZmZaLy9n?=
 =?utf-8?B?NW4ySWM3M2xGSGVTb3ZKMjI3c3grdTJQSmRKZ0FnTjlpdjBYWnlZbk8wWjM5?=
 =?utf-8?B?UTNpMG9sekZPVG5CQS9NVXpaVzJhWHpVVDUxYmplcmtJRVdQZC9pZlZVTGQr?=
 =?utf-8?B?TmJKT2hNOGpESTJpM0dDalptYkpFUEFRZWtMYnBkOWF6OWNyN0ZGeGZNekN0?=
 =?utf-8?B?c0huN0RpN281SkZ4UndobjR3VEVBbk9OeEU5RlZJcENGZXFLWlV6YmkzamF6?=
 =?utf-8?B?UFVlSWRHWDFmM3RDemZKbUFUTGFOR3BwQUdvbXR4dWxrd3J1SDVlM0N4V3pZ?=
 =?utf-8?B?aEt0ZVNYdGV0TUV1S204YjBSN2pNbzFmanYyV2k3Rk1HQmhIRXhPQWJpL2Zj?=
 =?utf-8?B?dDVCMjRabkZITTB4MGZCT2xrMVJWM0lOTEw1MjlrUE1FWG5lOHBZYUxFSXZE?=
 =?utf-8?B?SDFXUTJsKzA2eDZaazl3STBLS0RkcXkrWHdWKzR4NkJFVndwbS9TVkEzTGE0?=
 =?utf-8?B?R0lRMnU3WVIxM3A3bS9rL1VxcjN4WFZRVmhxK29LOURDZytiTUthM1ZsWVFN?=
 =?utf-8?B?aGZTNFBhanh6eC81Yis5L2RkQ0V0V1daOHBBNUNMOUp1NVE0SkVHMWI3ZnpH?=
 =?utf-8?B?TFpmaHZEZDFteGVLYWtIR0c1M2JmMU1CVTVPdlVyYnF3RUNhME9TZTlrVzJT?=
 =?utf-8?B?NXdqalJMZm5aYVVTMUUrWHR1N0FYelZ4UXFnMlp3Rml6aFV3cWdjK21MWmI5?=
 =?utf-8?B?M085SCtZTjBCNFptYStmWTlTQzlmRFhpd2tObHEraTZRQitsMmpsTkd2WmhB?=
 =?utf-8?B?Nmd3SEhlYmZ4N29ZZ094Q1dkU0ZRdjU0cEgvK0g1VkpuSzEvem9aRWdaa1Yr?=
 =?utf-8?B?Mkl2a0Z0TithN0FTb2p4OWhXUHVuMWNvQVJiZWpTcFAzZkJCNndsR3lDVkpQ?=
 =?utf-8?B?eE9wSE8ycDJwc0Mya0dvOXRwN2ZZZ2RSQXpDTWp0NWRhQzBZbmMzOFFOWFRn?=
 =?utf-8?B?UUNHRXVkQWhqSC9MZWE2V3RZWnVXMlV4Si93cGExa1ZzSWxtR1BnUFJHV2dN?=
 =?utf-8?B?emk3eWM1LzdDM0ZhY09DeFh0aW1Lbzc2dElsT0JsRWtROXNjajFqOFVxUStq?=
 =?utf-8?B?UkRSSjRPa1ZyR2FQekVZREkvZlp2aEdwT3JSdjhyZUNDUmdibnpaZkt2TW5E?=
 =?utf-8?B?Skd6WmpBMmh5ZGJDa3VTTklZMHlMUk80V0d6WHlRQU1LaGNuRUZoczZqNVZQ?=
 =?utf-8?B?UURBOTFZSmhRVGlsdThTci9SbGxpZWhnbW1QK2tqSCtJV2Z5TWVHazA1bGdq?=
 =?utf-8?B?aEZaZjA2NTB4OHZIc1l5MlIrSTJ6cGlBaC9tRTJCcGlBYldhNkVTdHJWTTBD?=
 =?utf-8?B?SjFPU0V2a1ZPZDQzVkZxcTBieVVuWW9WNEtKRkNuNlJSZ291emx4dmlPTXYr?=
 =?utf-8?B?NFpTemMxTEtmR0dzaVFBZmdtRzk2blhNbEZVL29FSDRRM0JLMGtvWVNiVkxu?=
 =?utf-8?B?b2JBcVYvSVpyczErbU12RVV3Tm9BMXpzT2VEekRPSnVDRTB5WUR3MkUyemto?=
 =?utf-8?B?OWNpejloUi9KcndicDlVREtoTnVOMnY0Tk41WmdCVXRKamtOOWZWNkVCZmVx?=
 =?utf-8?B?dWU0NXVWR2hTTFlkRm1hbDl2anQrKytRWUxkNUFHc2Z4K0hjRlhCeEZ6M25k?=
 =?utf-8?B?K3lXZ1ppKzJlamN3UEdObjRMTU8yNXRRN05KcnZrM2ZIMGdFZHJlUFFob2F4?=
 =?utf-8?B?UlYyYVB6bHVFNDJTQ1NXZTlqZEZmdkU3b3ZneU1KeXUyeTFub0JmZUg2TXk2?=
 =?utf-8?B?bWVrWnl1WGwxeGlJVVgzaVpEcU1BM0NiZG1lWjI4WEhKRTVRZGFOV29QTFdh?=
 =?utf-8?B?N2pnNFJUeG80U3g0TFVtYXI2VHR1bGZ0YW1RSmpSSTlJV1JhR2pXMDY5cHR3?=
 =?utf-8?B?djVHQ2tKQTJxd0JiVzRFMjhzYnF6RmlubU00MThEa1lGZUNiVmhUdXFmL0E2?=
 =?utf-8?B?TVpFeFZjOThJWEpKVU5nMXYzZGRWS1ZObnc0czBocU1iTFVsZGJvQmV1bGFi?=
 =?utf-8?B?QXR0eFpzekRtMDFtQjlXaWllRlNpb1hHUktjNlE5WnBmdnBaY25RTnlOUEp6?=
 =?utf-8?Q?WYR8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzI3cjJFakJOMjhaQ29QUERmelE5VzI0NEY1NWY1VFlDZ0RJbUlZVW5QU2ps?=
 =?utf-8?B?S2JZNC80eU5uUUpRNDh1R0J0NE03SHVEZUhuYXpSdFU2b2FRbWlyck1FZkZt?=
 =?utf-8?B?cFFzUFpyeVh3RG9GdURRSy9YOTdKUGRUd1lQNVNYZXFGYXZUQnVRcm5TQXJI?=
 =?utf-8?B?N2lHaGMzUzI1dEFTNElDbmJDL3lYZDlTV21mM3ZjNC9DT0FLenV3ZkdJZzNG?=
 =?utf-8?B?TEY3U3hQUVFNY01NbnkxUU80Z1NTOGwwbUZvZlhUNjZpU1ZudGxONXg4eTM0?=
 =?utf-8?B?cUg5UEFmbVltdFQrdWhVL1dXWHdZcS9qTXRCd1g3YURvMGFqcE1KSS9qa2xO?=
 =?utf-8?B?YzgwMnh3S3daTFdhQjcyenRCNm5iUTVEaUFoTUQ0QVQ2WFpKRXJLbzh2ckpZ?=
 =?utf-8?B?ZGFBdjg4V3IrUXZXbHBxclJJSHFjbXNSeXlaSnZrMDFxS3ExMHZVLzVPWTZk?=
 =?utf-8?B?VEw3ZXVYT2hQaU9PaHZ0dGdzRmFxZC9MS1ExRWdyS2xhQ1VadThIWjV4Zk5Q?=
 =?utf-8?B?eWQxUDBZZXBFQ1R4K21JdE5LWllXa1BaejlRNjJ1cXdGWGRyR0JGUzBQV29D?=
 =?utf-8?B?UVpBUy8rTWM0QnBDa3drelNPcWdSV3hrdlU0Qmh6MGtkcEI0eXJvQnlURWJT?=
 =?utf-8?B?R241MzB4VldWK09CN1NPRGtuM3lSTUtIN2hyRG5mSDNWVUdtVFpkbnZLbTNk?=
 =?utf-8?B?WGdqUGNTU20rOWpvN0txUVNJbzFLODhQcUNxbHF5MTRreTFIckE3YVl1UVps?=
 =?utf-8?B?V05ra1JoVCs5aFg3MDZ1d3ZwNTBoa3lBV0Vack5IUk1KZEtEcVdYTThlSFA2?=
 =?utf-8?B?N2M0dTdYMzY5Nmk3bzZ6VnkrRFdwalJMVWJBQTFzMTQrdTZVZldRVXVYVHFC?=
 =?utf-8?B?WHdIYjVWL3Jjc0JkWTBmRUgvaEZ5SjlmazNlVkMyM0h0UkVrSUQwUTBHeHIv?=
 =?utf-8?B?d3BhU1RqeDhVTXZtZzVqVzFUQ05QUWVGOHErMXBMM1BDSnhmdGI5dVFVTmtB?=
 =?utf-8?B?aGc5Wng2cTZZRU5tWTRvaVFkWkVKVUtNKzJQT08xWW8yVU02Z3Q0Y0lMMGh3?=
 =?utf-8?B?NHp2b2JXN3pJSmFla2hISUs3ZEFCTm1LTlU4TWtwYVNsRmhBenhNZy9zUzlp?=
 =?utf-8?B?d1ZVNUN6QlVzRHhmMVJwNWFpRFcyQ1BHaFlNUEJXRVY3bHl6T1RGdVVwL2xQ?=
 =?utf-8?B?YWNuWUZjV1V6bkh3N2trcSt1T2ZKb0VzVFJuRjlXeG5ockNVdWR3ck1Xc3NU?=
 =?utf-8?B?T3VDdnJneUNXQi9pZ2ZzR3JnMHFFTzZ6cjZRME9EVGdkcDhUcmN0cS9BUmZp?=
 =?utf-8?B?L09XSXZVQVNiSEVIWXY0WDRoaHA2V1kyMTZ1NUtJNEY3MFNKbUFmVFM0V0RY?=
 =?utf-8?B?QlV1OUpPM2pzMVJEYjZ2UmtsczFzRXYvemF2K3A5cTI1K2lnYlRTVnNLSlds?=
 =?utf-8?B?ZGFGZUtmZ1A2ZEhuMGZqcDZBR0haOTZaT3cybjVxbi8yUGJaNm83UXVQVHdM?=
 =?utf-8?B?UE9UYjQyNjM4STYzbmxQSEJqVE1rVkVaYks3cEw0eHM5YVVDNElscjFRdUNm?=
 =?utf-8?B?NXhvNWxmNXllNnE1Q3dOUDJiVjR1aTlkQzRxKzgvQVBVMmM0T3hRMlFXTWJT?=
 =?utf-8?B?TkFqK1Z1WGIyQzR0bk16aDlKN3M4NkdHNngwRXplMTU2b2YwMStlTHVyS21q?=
 =?utf-8?B?WWcxK3pmVjdZZ2xqWG05V1hpbVVSbnlKRTBUNWgyNkhZRUYvSlBnc2xRb2tN?=
 =?utf-8?B?bnJmd0pGeUZmMTRmYzFxcUhyZjF4a0FrWTlCM2I4UDg4ODFOeGxyc01sem1Q?=
 =?utf-8?B?VldpS0hhNUNxeHpnakgxVUNHUjgrN3N6KzF1YXN3aWJxN0gzd08wdGFLYTdF?=
 =?utf-8?B?NHB1Yi8wZVcxaTEvbFd0SXA5SE5YaFMzWG9YKzVhWFpVR1BhbzExQTg4SDhj?=
 =?utf-8?B?bThBUFpnUGkxSEQ2V2gyM0tsbWoyY1kxYWQvaXJYL3VHU1JLcnV6b3pOa0ov?=
 =?utf-8?B?UE1iOGx6MjVFUDFQNzBDanhJcFFRWjc2dDE1N2hFdFlJUTdyWDdidUw2N0I4?=
 =?utf-8?B?ZWdhZ1NHd2p4VnpOcDhpUW92aFR0U3djTElDdHArY0w0Y2JGTE9hV2VUWnpl?=
 =?utf-8?B?YzBqR0lVc1YzNkFMcjVDZTZLWU1vRzR0ZWQ5RmFxUExkSE1jMmtqS2p4ZC92?=
 =?utf-8?B?aDRpMmhpU0FONVhHcDVkcVF6c1cxUUtPeGNEM2JFOVUvUy9CNWRNTGlhakwz?=
 =?utf-8?B?a2Q0Q24wLzRCNjFTVWJEZUZpdi82d0lZSVdlRk9JMTlsYjhDVWFYRjMxdjhW?=
 =?utf-8?B?WFlFUmtNM1FlZzRPNTQvZ01rR1d6K2VpOHdmZHlvVXV4Y2E2RGIyTTZlRVkw?=
 =?utf-8?Q?N7NrbIbsnaVW+qgA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e563424-b305-4be1-17cd-08de599fdbe1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 10:20:26.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sBMo9+v+pZGLndNh5/fezu8Z0sOP9Qntul7UchSqGETdE7BS5ZuNx1YDsbldzO700dvGdTwUl66pm2ih20lf0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 22 Jan 2026 10:20:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21696

On 21.01.26 16:32, Quirin Gylstorff wrote:
> 
> 
> On 1/21/26 9:14 AM, Adithya.Balakumar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>> Any thoughts on this? Do we stick with the current approach or switch
>> over to a file in kas/opt ?
>>
> Alternative drop the unnecessary `overrides`. And use WFX_URL direct to
> install swupdate-config-wfx.
> 

Right, the value of overrides is primarily in controlling more than one
variable via it. If there are more case already foreseeable, we can keep
it (but please name them), otherwise fold the override creation logic
into IMAGE_INSTALL:append.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

