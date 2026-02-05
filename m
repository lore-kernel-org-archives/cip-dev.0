Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E5DE91286
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 07:04:39 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15442.1770275069113420804
 for <cip-dev@lists.cip-project.org>;
 Wed, 04 Feb 2026 23:04:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r5HP6jx6;
 spf=pass (domain: siemens.com, ip: 52.101.84.68, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KqeHyV43RyWrcL3XxV/qilBVDlw6zKbCPngTWqifUSTEqCDnTgERwy3hEDRRosTIfr7eYZ1S4ZNGYLa2QdNmEBiPmU4zDGW5nTIA4y8ns5ia+wGfh6VziKTeezRMpek8aQdfHrD1vGiOWf4LuMbKYz0VnoKu8R79XxVWPGMyFmHcuvSV7yzaqUJ05XV1Qsd5X5u8V3sb3gXtleIJnEwqCQ5AYAPgtjyB3HDYRKQEOCIHmk7wZNmALmli9ZYjHgK6xplqnZ5j5l8wUuV4Ar5zLjlHChhxwkJx1a1QzEmC/4EW5VjHqxRYXKFI35PaxB7trjQ5xwnqNBuQD0gBU0rOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v3Wpeexdufi9s68Fdmf6MXxC4/k2+SKTlPJSrCDhdtQ=;
 b=CA6i1PXllLePh93YqibNENagKyOyRTt1COCwIvlDahtBCtEC++sZxuKAcc04t4mGNizzFSNNHnJHM8D9WqW/PbfKDedsAoEWXabgwHQ31PtDI0iyauUwbqBdtsEMeWmLpQdGY6XjMwruIEK3UWRJTL7U7ooEqXlI72w/NAnJTeTmPMaac+EVRTvH1tXNvRI1ekXH3cLTWOnkdXK7rA0lKCp2pygwMRROJxr35tAeU/0n3d4fkuxLeCJl61FAhRtt8copCiK8ANF2RaZlN89K27UOKwYbjKqEgHe6HWDzrvnMNWNHJE2KZuxFOKaoIOCVkbt1q980m723UpT0cMdKqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3Wpeexdufi9s68Fdmf6MXxC4/k2+SKTlPJSrCDhdtQ=;
 b=r5HP6jx6zGT4e554ts7nhGnLmOxUs/7b4wXyx+xGXhtnIV++NG1usij2FAg5T/sW+kR1/Ih9P92+sfgHWeiMVpJ3HrjFXbO+DeMH2P8FitG8ljneq9+58IOhBhItehSCATBZ7Oq3kqSt3iLBqjE+OA481M+kuUdrfGmyBM0g9qaiT/ctGgaiYOJp7cpx8wyjur1p/JMy3JiCXcA6p5kVQeoUxIBm8kI4rDdZY9p6C2ACTduBu9cMQtBUzCKYHXsfvmzIssVqBpESnJYlnaeb61rsTnNk/V7uHSDc9+BpwI662ad+MLGbfulTTqLsPYwkkdyb+whXRr++2mb5eqkK4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM4PR10MB9422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:6cd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 07:04:26 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%5]) with mapi id 15.20.9564.014; Thu, 5 Feb 2026
 07:04:26 +0000
Message-ID: <cb7e3704-4503-4ff4-aebc-64a64b398fc3@siemens.com>
Date: Thu, 5 Feb 2026 08:04:25 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update kernel config revision
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM4PR10MB9422:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af7111d-79d0-4ddd-d9c5-08de6484cc69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZS9KZXpxdXpDYUVicGZZaC8wc0ovZkpsa1M1cFRwMFFBVkc0UENCTEdNTEMv?=
 =?utf-8?B?K0FyRGxsZytQQ2pvelViQjlrVGhUNXlEMkpITnMvcm9Kb0wvb2QvR2d2bkY2?=
 =?utf-8?B?N0Z4aEs5MHVkcUlsVjhpbmtqU0cvUGxxTzA1VzZvbEdoK09adEZra2lqb3Nm?=
 =?utf-8?B?WVdnQUozMVMyb2FoQTFNeGRtVnJiei9QbFJXc2JvdDZVSjhTWkg5aUlEOG1o?=
 =?utf-8?B?aENpcG9NbUI4NncwajFXbzA4L0pQZmxpcDg3SDFQNEFmV2ZpZHJCakVRUXgz?=
 =?utf-8?B?c1NaUlJKdC9LQ1FvSGs1T0p3SkZkUGsyVkUwVi9UbVR0TE00dWZzeGFCYnd3?=
 =?utf-8?B?U2VrVEJnajg1QkNXMkYvNUNXbVpvS2tPZVRLeVJIbWk3bUxsQUZheDdxZ0VD?=
 =?utf-8?B?cG5rc1E5c1BmMFZCbjU5VjFOdjJQdExQS2d1WkZ3Nk00UmM5RXVtRzZ2UUFS?=
 =?utf-8?B?Q1NmRDd6Tm95b0VBOGR1TXZyRHB1VkVzbmt6N290c2hmWW85Z0l0Y1Iyajht?=
 =?utf-8?B?SmNRQmhUS1V1MUtaVmQ4bzdVNWZKY0Q2T0x5RnJqcDR0b2czdzl2dmM1TGNQ?=
 =?utf-8?B?Y1F3ZTNMdDUyNTlNMVZQR0Z0YkdHY1hwZ2dsK0wzVnloUEg5QUJQcUZMSDRW?=
 =?utf-8?B?Vk9tcUE1TnRVVTRFZkgzaUczSWxkaWQwTWZQYjEvRzY0ZG1vS2VXYjhKR2FM?=
 =?utf-8?B?RWZnYzBSUUM0U1BHVENaWm02Z2c5dVprUjNoV1Jic1pFc29zbUN2NnRhYVFK?=
 =?utf-8?B?OTNyRWp4a2xaM3lxZWtaakRQNG4vOEZrZkhnbjZTbWM5UkgxaXA1OEFvNm9U?=
 =?utf-8?B?RW5UYS8wYWlSVzNpaThqVzJDMU1ENEJZcWlCMmhzZU55VGhMWHFOTFNDNHpo?=
 =?utf-8?B?cWNQSFNTL1RienBYSWNzbmVXSzY0VWdJK01XR3VnKzN6NG4zNXNSN1RJVjZL?=
 =?utf-8?B?cEVScExIbmtGTnBxaFVNM3N5SS9xTEc4S2hxYm5QeW44dHNuRTZ5bS9lQXlt?=
 =?utf-8?B?cmd4Z25ZWFlWTFlIR1VnckV1UHhjODl0TVU5Mmg1QjlhS2N0UGdCZzE4blEz?=
 =?utf-8?B?OHAwcnZNWkVmL2o3cksrcjVyRDZoWDhNc2NaUit6eXVpaGw5dkkzdGJ3Q3Nn?=
 =?utf-8?B?R1FReEltS1crMW1aVU8zUnd2MUo1NlhxNVRrOFJuajAwQ3dLSjM4UWMwNjda?=
 =?utf-8?B?SGRHOHJQclVaNmNKdGszelpmTkRUZm94cVhKSVhPMW0vaVN3MGVtVXRnb2h0?=
 =?utf-8?B?VWthaVEyTFd3T3diMU5qRjNSTWV4UTU2dEVwTkU5dTFCUGdoOThhd2NEQnNl?=
 =?utf-8?B?SjNEWmw4Z0FjOTB2SXVhQ2xQQjFka2ZDbUlJY0xOVkRpZHA5Z1RKRkVoT04x?=
 =?utf-8?B?a042bzY4YVBrN1B5NUhiYUlmb0FTcVpxTVVFTW5mNkQxTTY2T29FbEpKSVlh?=
 =?utf-8?B?NnljbWUxNjJjblZkOTk2S1Q0ZC9QSmMvMnNvQ2ZqQWdoQk5MVFQwU3g1VXpz?=
 =?utf-8?B?OGR0WThHZFlkN0xNOEtTL2Rma1RVOVVaMWpKaGt1SGZ2U3A2S3V0UmU0ZkhP?=
 =?utf-8?B?bDRGUFZoNllUTmJyV2ZLSUN6VG43Q1ZxTnhIQ0I1SkozZGtqaDFoZFZuY3Yz?=
 =?utf-8?B?RVVtM1BkUXRlbHFMTmVHcnNDT0pneGNwaGhSenJ4TStRcllXVjZOSXEwQXk2?=
 =?utf-8?B?Wlpmc3UrRHBLOEZtYXYyOE5UZ0lCR001VXJQOHV5eE9hMUZaY3RHYlN6Ykp2?=
 =?utf-8?B?Z2lHaXY5Q3phTUUyYUV5UzQ1cHVtY0ZBeDl1M04rUHFONThGeDFuUjBib3dE?=
 =?utf-8?B?Yk5uZ3gwb1E0bWdncDFlTG8yeitrSkZCSUw1SWNQZHBZT05GZm51V0tMWW14?=
 =?utf-8?B?S1BnRmx6bnkzelBVQmsvaG9vN013RE8rU3lOK3BYd2Nra3BVZzhKQm5LTDZT?=
 =?utf-8?B?c1RIVzhPeCs0UU1wdHI2TFY1Ymx2R0d3WmVyWHQvU2d6Qi91cDZNWlRzK3hk?=
 =?utf-8?B?aXZGT0x3RlNkS3NUOEpRWDNFYk1iRUhqQXUxMW43Qmh5SjBFY204dzNVUHVK?=
 =?utf-8?B?V0lzNWt5a1FhdVdTbEhFOFB5cVVTQ1padkw4T25YYVczTVE3U0kzWFV5RnpB?=
 =?utf-8?Q?pj7E=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0p6Yy9SRzkxdTJRNDVBbDZzM3FZdCtKY0cyZTh1dGxEVngxSlpNeGI3MXN2?=
 =?utf-8?B?bzcvNjIxanUxazdVSEJzY2svYTF0c0E0OGRrby9Eb0lGUVE5WVVXSXJPVGh2?=
 =?utf-8?B?ODg1K0xSUlpDMjhDWUtOMHdGZ1pxcVptRFFLWXduUHhzUUNySmt2eTFGTUFM?=
 =?utf-8?B?UzFzWE9MTGlMNFp3Q3pmM1JEUFBvU1RqYVhIN0NOVmtIeGtYMmZPdk5sOTdP?=
 =?utf-8?B?OW9OVDhrVEs0c0txVExBblpCUVBaS2ZuUDFVSkZVWnNwYkRXaXRrOGF2eUUw?=
 =?utf-8?B?bXRLdk1zb0pPZ3FyTmMxekVuUlZPdjU5MkdJMWc5SlN2OEw3QkdzOWNYSXFq?=
 =?utf-8?B?TmRaaVltTm1kQVZVQUNNMkduU0RFZnBJMDJteWpQaUMzR3FTa000QUNtK0p6?=
 =?utf-8?B?NU1kRTlHVVJLdmsrUnZJVlM3S3RaRCswclZRN3crdWVRSnlwU0JrcFV1KzVT?=
 =?utf-8?B?VkQ1TjZDbDVlSnd3UndSZzY4OXZwL0c3dm5vRTZNcXg4TUpLR3U5Ujh4ZFd0?=
 =?utf-8?B?VVdrRGZ5VkVVd29ybVhKTG9TazU1bjlTb3g4Z2JjWkhTcDhXQ2V2cTVJeElz?=
 =?utf-8?B?MHBqZlVncW9sZm50WnBJUFRuRy9CZzdUTTA1cXg2bWdtbFFJcUZNVEVjS1BV?=
 =?utf-8?B?b3RLeUU3bjk3SEt1QnJlYjU1Mm1RSFFURSsxekJRTXUrTHF6anl4SXQwRC9J?=
 =?utf-8?B?ZGFDdDZpandQZGNIaTE0Z3F6UkhpUkw3c3J2bEpsNTU0Y1FMWVgwcVpmWitq?=
 =?utf-8?B?aUtZZXZtOU9QdExYYjY2VWRrNFJJdzhEQzFScnJNMFhVWWxEcGFYeWlFSjc3?=
 =?utf-8?B?VkxRVmRKOFJVOUVBczc3K0JLMmtqalVYWlpOL1AyMnY1NGV1RTBBRU9GV3RM?=
 =?utf-8?B?eFdFZ0syY1VSVWNqMzdhYlo5em43V2RvaVVmTVlEeUR6azhQWVJyRFNPTWg4?=
 =?utf-8?B?dnNqOFc4cmhtc01XQjdFdEdhNllVMTZjOGtWYlNlK1BocC9NUWFBcjk4b1Fv?=
 =?utf-8?B?R0MyMkN0MVZuMkdFWmtCYW5vdmEzbGk0OXBOMW53SkJ6WkRjd3lKWDU3d0pZ?=
 =?utf-8?B?Vk9ILzVKTDZ6RFoxSjZZUXpnU3c2RzhMUWI2WE4zMERDcy9EeER0QkprN3Fh?=
 =?utf-8?B?NkRlajJuN2ZQV2h1V0JneVR2aXpDVnUwaTFYMWYxeEppNUkwaUxCY091bExG?=
 =?utf-8?B?NHY2NlhhN3BMT0dUb3B5QVd1ZGs0VlRFU3NxVk50K1h6S1grV3ZrN1c2bmJl?=
 =?utf-8?B?M1ZyZXFVUHp4UWZNOEhqNTd0dG5UeXlUSE80YmJsMGg2WGpQTUlzMkhqWjVt?=
 =?utf-8?B?NDJZSlJCejZvWjljOGNhSDhsY3lQZUhXTUtRR0FWT0Z2SEZ1TWxhbVFuTEFh?=
 =?utf-8?B?VWV6ZU9YMVdMMm9SVjVuWGtBWkE0cU9kRlg5VktWVkdaMVVpcm4rdzdPcEQ3?=
 =?utf-8?B?TjZKNENzRmtLanQrNkNBN0p0eWFuY0lqNklWcENoVVNLRk5FTXNsM1RrZEMw?=
 =?utf-8?B?WkdLbUJBd3R4RlBDbVRZWWNlb251WGVEWUhTS1RkYkhvZUZ0ZS9PYk1KRkVC?=
 =?utf-8?B?S2huOThESG1UbzZEVG5rSVRMWXhGUEVwWnNLNXdteDhpUUdtM3p0QWxPTzlL?=
 =?utf-8?B?OGI4a0tjMXpDbWNQcCtTMk81MGhkQzlnVUxXQlNZakhwYXEvMkRLRXpzeVJm?=
 =?utf-8?B?cUd5a29zbE43WWlZSHIxR2VzRE5lWXRIQXZQYk9hRHEwcnJCQm1WdENsWFBk?=
 =?utf-8?B?REZyZ2hHUjE2UTZuUHJWQzJwajlvRnRvcFhPemlvUnRic0hVQW40cFBYVmlp?=
 =?utf-8?B?em83dndvRlN0WDJpakhvNG1GZ3o2SmhOZXRNTWkycE9qQ3cwVzc1VGsxS1B4?=
 =?utf-8?B?U3EyNmhOM2NEbjhsYUJIZUR5akNBQUtlSmFJR21sWE1MakVTUDcxR3dwUk5j?=
 =?utf-8?B?UEkxK2lraExIODRJRHlwSW9MbStpZ3B1ZUhEYVcyQkZja25aQ3ZvbjYzYWE2?=
 =?utf-8?B?ZFlPQ2pNOERjb0xqRmE0NTVDek1nazZ1MnZ0MlJQRWhFWUFmdkNFN25oNDdj?=
 =?utf-8?B?VlA5dTVDSW9LeTEvMFQ4S0lJbldLL0YyTnE5SlRVd0RrbnJwSk9DOTlxUWdo?=
 =?utf-8?B?N0RlMnlwVDR2Tm0vY3QxUjZLUVFZanU0RlQ0VEpsUE5wT1EwdXViMjNhNG9U?=
 =?utf-8?B?V3E4MG5zc28zeHJpZDdJYXBvUWV3UHhNdVNydDM5WEtKL296Szd6M1BPVkJo?=
 =?utf-8?B?L052TzIxZUVLOWpHQ3o3QnVjelIxa3E3c3h4aUpKS29VcUYwKzRnRFFlazY1?=
 =?utf-8?B?Q3cvdG9VRDR2QnJZU2lQOWZzbXVKSUJsNzJCVGRNQTRMS3NyUDNRZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af7111d-79d0-4ddd-d9c5-08de6484cc69
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 07:04:26.2978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+pYDXmVhkInQHDCAMpAp6xXUlhS68TCNvxJ8UVoqd6RYuZO734MdkGjfVQfM9LbXNj9cuYMNho788Zr9gYnDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR10MB9422
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 05 Feb 2026 07:04:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21835

From: Jan Kiszka <jan.kiszka@siemens.com>

This fixes the watchdog pick-up by Linux on the BeagleBone Black with
5.10 and 6.1 which was broken due to a software watchdog taken the place
in the first row.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/cip-kernel-config.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/recipes-kernel/linux/cip-kernel-config.inc b/recipes-kernel/linux/cip-kernel-config.inc
index 05a0f4a4..5bff1805 100644
--- a/recipes-kernel/linux/cip-kernel-config.inc
+++ b/recipes-kernel/linux/cip-kernel-config.inc
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2022-2025
+# Copyright (c) Siemens AG, 2022-2026
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -15,7 +15,7 @@ SRC_URI:append = " ${@ \
     if bb.utils.to_boolean(d.getVar('USE_CIP_KERNEL_CONFIG')) else '' \
     }"
 
-SRCREV_cip-kernel-config ?= "1dc986a03d529225404696a5169c29b6958f453c"
+SRCREV_cip-kernel-config ?= "7742c0f098a3bae264dcb7db8128e99954249bb8"
 
 do_fetch[vardeps] += "SRCREV_cip-kernel-config"
 
-- 
2.51.0


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

