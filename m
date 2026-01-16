Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4417AD48994
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:57:26 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.71])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4460.1768564638054461608
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:57:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hfh8FYFx;
 spf=pass (domain: siemens.com, ip: 52.101.84.71, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wrIhTaRmjgjcfS2Thmgc1UQFTTmhRMpbQ3oNEj2trCIL5GeeID/7nTYZAeSKThMUinDsV3rgklKeP1tpfj1fmlUEzkXUtL9LPkyZvvRJK2o4G5j5hz+mzHTt76MpOydc9MYEVr8lTGaKlwufIknSCs3tAs0zdaGdtSwDUTjEp7sGlr7/soThk74Lw2Nt05qsbFBYl4ESJONfDSJTL2W38ZU+5j1PjbTZdD+5FEOO0qkfrFT9/ujepgMdS1tcNhjzVqIZveTq1qKwQgCivsGyEvyh3S7QSV/cuEctTisK+blyQMWHS7ePUYY0IUStxYBbGuFjow7Q6N4I4TMiacwBfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BWqc1XhGDYlKLlyfBymb2HZH9j144ft5fuLUTXHsWzU=;
 b=dBr5vtRJz1bEsoFohKAWyTDwr97Bg4hXhvdV8UUqXHXI5Xqsa+RoaGuqrMASN7BtbGgBzmMjFxi0DCaYvvvsFO8Ys1O9AKNMaZotxk3H/IO6V9nMcXYXbGe7xcNZagtmPiUQDDqF2w+ezjRR78uNnqMskJzvR8vhse3dhxce7A1JCgiiTpeqrkz1HpYT/qJ85fx8XBBN6A6fmL8N7vAdinSE9AXCLMi1k1UxXnTubyBuwHucucEwKXeP4GW49u5fbLRt7JTmk5OKpO9Bt0B4ytTxZmpZpK5mntnB9yn+KFFNyzHE70eklyrILQnNAf8ljtKBIDF52kpObwf9kVttKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BWqc1XhGDYlKLlyfBymb2HZH9j144ft5fuLUTXHsWzU=;
 b=hfh8FYFx1e+df+Ry9dLo4RfWWN65yMeL2bAvQMaYhKGyqr1oX1DOFDMBzPOOcuw9+HTfc7d4sTYO1JIO7VPFMsL/uvFKZjv7cFf3DBME9rFUB7lxqljyHyfKUO0i1uC4EPnYJg6YCVfdOBa1hiqQwc+z4NBm/NLo5FShAp3dQm5vMnJj4n4NMDTmyMDaVhg0t+JzpfNOV18QsdYnSchB3fOTsBf99JzEZvFtE3szvGlqIXqz+gyk5BPiBq1bsStEom3tt9VXa2ODA8QbD86OLK/Tp1tgBpLQYG+pqx7Ze5qEfVPy5KZTSHJW0NGzxc3CUuqnI9DND8IpS4lU1SnwzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d3::11)
 by DU0PR10MB5947.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 11:57:14 +0000
Received: from AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3f3c:7681:f3df:d236]) by AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3f3c:7681:f3df:d236%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 11:57:14 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Jan 2026 12:56:43 +0100
Message-Id: <DFPZTUSSY5B1.1ARCL3PJZFE92@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v5 0/4] Enable support for wfx
 backend based software updates
From: "Michael Adler" <michael.adler@siemens.com>
To: "Adithya Balakumar" <adithya.balakumar@toshiba-tsip.com>,
 <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
Cc: "Adithya Balakumar" <Adithya.Balakumar@toshiba-tsip.com>,
 <shivanand.kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
 <akunuri.sahithi@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
 <michael.adler@siemens.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
X-ClientProxiedBy: DX0P273CA0099.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:5c::15) To AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:d3::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2467:EE_|DU0PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: de09f5fd-f32e-47df-c37a-08de54f66397
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RUE2Q3drODIvL0g5VStNazYvSFh0NVdIQ1VjV3liU1ZORXpEZmVNcHJ1REFY?=
 =?utf-8?B?dGZlUnEvTjBRN1NheTIrU01DOCtwYzlaSXBEZzZMZVk3cVpYL29CYy9XZ0Yx?=
 =?utf-8?B?MXltcEpobmlQek5sTTdJNi93aDhsNzNmR2Fib3JMUjFaK0ZJOXBZV0EwaEtm?=
 =?utf-8?B?WkNhU0JTMDNkcnU2NnNjN2lrTGlqaGxQUG5kRUxudTk5RlNaeTVjQVhnWGRa?=
 =?utf-8?B?dC85bUhzbGZRazdGWnovakxCZXpDR0F3cTdxUjVSYUpKTkozbEFFRDR0VUMw?=
 =?utf-8?B?RTg0Q0VHMEVuSFpOZm5FZDZiaW5FQUNXc0ZQdVdiS0tJVXQ5eG5zKzN3RUFt?=
 =?utf-8?B?dDRYVmhKSkRHN3lQeUJIV0VLMmdHcHpSN0ErVmUrWlZzQzAydVR3R2pjOHF6?=
 =?utf-8?B?TlFwWU5DQ0Q0MVI4V3FxNGxIVHhqQlFPQk5Ia0ZkZ29EbWttUms2MzN0dVNa?=
 =?utf-8?B?UEtzOVNvM1ZlUTlCTjZFUnZ5aURtd1VCZElnNXhxYWRxdWdKRjJrN09keWYw?=
 =?utf-8?B?NGRkeUdwTnNkSDZKVm13WSsxRkZRMFRaKzkxSk5tZlJqNUVzTnZFUkd0U3gr?=
 =?utf-8?B?U0ZmcXlsMHo5RTZ1NHdXKzZLNUtneXo5Z01OdGl2Z0tGSm9NUVJWdVp3TUxy?=
 =?utf-8?B?RkdTcXlqZk5vbTlxdGFFZHNycGV4WUgxQVdGMENuMTdjM0NGUUpsTXVLK1Ez?=
 =?utf-8?B?KzVwaHRLV1lvTkFkWkIrTnYxWW00T1BxaE9yOGJiK1o5azYySVhEdlpFdFVT?=
 =?utf-8?B?R1QrSTY3V2x0bXFxaklKUlk0YURKaDRBaEFHYjZtdzd2T3JPdm1FVE93bVB0?=
 =?utf-8?B?Vm1NS2VRUVBDRFpVMVNMVE82ZGw1YUd0OTU1ZVhFQ2tqVFdkRjBZOFZCdVAr?=
 =?utf-8?B?bVdDcGVsZHErNG51bUQ5eEVSRW9haDF1MkdHNkdhbVhyczlCNDlMUVU3SGVG?=
 =?utf-8?B?V1l4QmxKeHZraVd0NE0zc3k1WWdyYnVuU3JOdjBUZWc0TlVTaTE5R2RZUUZW?=
 =?utf-8?B?c21xS3ZRYjJ5bWZqbnBySUw3T3RKYlFhZVFCOVZTVmpHMjVudVh5ZkM3cGtF?=
 =?utf-8?B?Z0pQS2c5TXltWWVyWkI4VjFScEUvdlJ5QlFwcnZYa1kwTUJHUTFHTTEvNU11?=
 =?utf-8?B?NkhEd25UblQ4UFV4S3ZGdjVyb3h0RGxrWVVSSVlYK3pVT0cxa3doQVNmOU43?=
 =?utf-8?B?amU3d1JDdy9vellkMVNFVkZ1cGxvaFVMSjVaYTZxY0ZqV0VObWVOZ2paSnVk?=
 =?utf-8?B?ZFJjZmJXcFY5Q1hLVnFxUzZxb1pQbE5CREZ6NXRDVFZiSUNYUGxKT0tHelZ6?=
 =?utf-8?B?c2pGR0x3VklFRDB4dTN1SmlPUWFJU0k2RTJVTXdRVC80UUE5TGJmc0dqT1Ew?=
 =?utf-8?B?RC9CS2t3bHdzOEFJRU1DY2NQWnljZEIwdzI2RFFiVlhkcVhTYUZNYzBuUjds?=
 =?utf-8?B?bVA4MUdHZGFpaitZMldiZGR6U05DRHRlTURQVzlERm5JSFhRdmdtY1ZJeVl0?=
 =?utf-8?B?UkNZSk4vTG1WV00ybHh1blgySFlveFNtVUZZM0srZ0ZmMy9ZZ1hWWTIrSGFD?=
 =?utf-8?B?ejY1UVdkRmx6UTFUUnZncldhR3VES29JMHhsVTFDVVg3S2JSN3V4NzcwYnZJ?=
 =?utf-8?B?MTJjbG9mWVRBdVhxWndlZGtzZXEyQjFXaUhpYlBnOUFsNjFZUTIwV0F2c0xK?=
 =?utf-8?B?N1kzeHBWVHVEZ0xQQVh0amc1UzVIOWYycXZJVk9NVEhSVkdPNHBRRGpsMWNE?=
 =?utf-8?B?VjJBbWg5VE1ndEFWU1cxeGVsaFV4eDVLOGZHMzdReHRJcGhybFNoMlZHblk2?=
 =?utf-8?B?RU5WOE81ZVRpL2RRRlB3U092dE9pREozVUZ3d0E5amRRdjFWYUE4QWRVdkgy?=
 =?utf-8?B?R0hhbDlrd0R0STNwV3RSbWlWT3pnVmRuc2gwNkpxdWZYQWlpU0pBeVRhOGh5?=
 =?utf-8?B?Y2JVdWtKU0pBN1pTUkI0QUNIQnEvQnNLZzhUZGlieXBRRWlmcFgrMVJKakZB?=
 =?utf-8?B?eW1LMW93aW5Rd29BWFNVOS9Ddm1nYWZLdlh0RHNEVHU0bU5aekVzUi9DMmxq?=
 =?utf-8?B?UDFxS0t2aGZ2WUFnOVZqNnQ2cXlJVVQ2Zml5anhSZHVTY0xSZklUTmtyeGoy?=
 =?utf-8?Q?LrOc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b3NkaFRqLy9scFdIRWJEY1ZaVG1GbzJOejE4Rk1FZ2JWU3I1WXpxd3V0dktQ?=
 =?utf-8?B?NkpvYjVTWXQ3aXhrbHB2U1RiT1Jnd09QdW1ja3daRmdVM0JrVDJaV1l1b1dH?=
 =?utf-8?B?eVJlcVN0a0t4NjBlVEkzZnQ3bVZLSk53M1RpS2ZGamtybmN5WUhWVVIyWnY0?=
 =?utf-8?B?Vk5SUkF1TEphV21oZkVVM2FuL0diL2lPUVpVck9aZzhoYTlET3Q0Q0ZucUw3?=
 =?utf-8?B?Q1cwcVdsaFQvRVIwVk1PV0piWHVUQ0haazhDenlOeWVaRHEwRG1LSUVTc1pB?=
 =?utf-8?B?cW0yaWxvM3doR1lPMnlPTjIwWklocnNsSDRZbkFpazB0SUI3V0pvcWsxWlh3?=
 =?utf-8?B?NHdER0pVR0ZXK3hzSUZNaTVPd1BrZDJBZklha0VMcVdQTE9NUUh0QW41amsx?=
 =?utf-8?B?WHlJczZJb2NMVjRJbW1Vdnc3UlFLdFRpZzJyYU43VmVzbVB1eUg2bmNCRHls?=
 =?utf-8?B?OG1lUnBtTnpyMlFPNWgraERadm13NGlnZ0RIR1hrSkVxRDR2THRUQVh5RjNq?=
 =?utf-8?B?bmlZZVBOVWloaGVUUEEzUmFlN1ZTZUpDeFdVTlVSQmVNeE5rbVZKNHk5TWN4?=
 =?utf-8?B?enMycHJQQVFaT1E3VXdPanBxUkd0NUd6a3U0bzNSbzNKcWpHaFVCekswdUN5?=
 =?utf-8?B?V1hhdEtVbUUwZG1xaXlpMTRFaHpuZFgzREFvbzNaN2ZEZlUxVll3WXpwczJI?=
 =?utf-8?B?S1VIRGlvTnJtUTZEcXJON040S3diSWw3WmhxZk5Ebm1kMXhNNERxcTNhbG8r?=
 =?utf-8?B?TXpRcnpzOVh3THI0bVRpNWdPNnEwM012bE1SbmVDdlRydFY3Q0ZDMVNDK3lU?=
 =?utf-8?B?aVdtU1dGQWU3c0tUcmNTcEdxWTNZakk1d2JSTEoyMEo4RDZXZ2RnTTZIOWlw?=
 =?utf-8?B?SjVucDEwT1FSaDR4SEFTWDBNam4zcTQvK2Uxd2pQWjBzY2Vkc01Db3FJWGZK?=
 =?utf-8?B?am5LeEVCd0U4Q0dISjQ3c2ptUlBrUWlNdXVka1k5ZVlmcXM1bVpTNzZnUHBu?=
 =?utf-8?B?akpuQzNEeERjcEEwbTNaWldjZnB2eDBBMTRvSysrSVB4bEtDbGx0Q3RuYS96?=
 =?utf-8?B?bEhoUDVKV0tZUVRlUFlkTklKV1lDRHVMOEJKSlBrWTcyV3dUSmloSHY3VGYy?=
 =?utf-8?B?OTFmMjlWM0JHamNvZk84NFJGZ2wrREFKV1NtL1hkWUlpR29ER05OS2o4RWlx?=
 =?utf-8?B?aVBTaVZ0bTlpK0JEZlc3QmU0cWFGSGNITkQ1NmJGc1JPTFE2b1NUNEwvaUVE?=
 =?utf-8?B?MkRGK3o2elBlb2FqUXJvU1JHaTQ0Q082T1RVUDNmOEVMVkdRaDF0K3VEdFNT?=
 =?utf-8?B?YS9NYURBc0x2U2o3TzRvd21DMlljeTNKR0lXbko4Ukl4dzlSQmFCQlBINGFH?=
 =?utf-8?B?RVFrbDBXWVdJNWlCK0IrNy9Bc1F2SXFzYys1dHJoMlpxSndRcW5ZeDdBQURN?=
 =?utf-8?B?UXIyMzhwYysrZ0VZMDVNVmtKS09OaWxIeXRaQzFCSjB3UkpYL1VKdG9Ta2FT?=
 =?utf-8?B?UmJpRzVNN2hkZzU3ZFJvaVBLWXRwQWRxSjFLanpYbmh3QXJPNzA5T1cwR2xL?=
 =?utf-8?B?T3JFMXVGdUJvZjl1WjBLNUVySWlDMVp4OW5zU2NvMDBCYSttU3VWV1lHY3hB?=
 =?utf-8?B?QTd2ek5pakZEem1CRUFJV3Y5RmR0ZVFibDNGOGgybFpxZFI3U29oeHpsYnNW?=
 =?utf-8?B?QUFycGxTZGQraTMvTys2MEhES1lpUHp6ZlBCekhVckZpWUxWQm9uWnpRNUNH?=
 =?utf-8?B?VGxoZ0kvejEvd0tqWlVkK0g4dWJtYUU0MkNtRENJWjVWWDVlNzlrM0FqWU1s?=
 =?utf-8?B?WGwrTDVxYkFvNVpmK3pqRGMxbUJYbVhnZWlmQTBua1pMejJtc2d0dklVZDY2?=
 =?utf-8?B?MGpIM3dRa3gzWGlYaEE4OTNJU05IdE1tZFhNL2RQSzZ0NkVWNjhFSUk3T0c1?=
 =?utf-8?B?QzRmdGQrR1lJUjA3OXhudXUzNXBvWTBxRVpmWFkrNzJRYTcyVUtZUllXa1Jy?=
 =?utf-8?B?UkFVV0FVL3d3TExkSEkvb3NTejRvbzEzTEo0K2FVcmJuei9SQmI0eWxsVXBj?=
 =?utf-8?B?Q1I4NGFkS25BUlVCcGNUVFBFVnZDMDRFZm5aL24xZVNLZlJqNHU5OWQxMktZ?=
 =?utf-8?B?R3hVRHN3eDU5alpFWGZIaGxueDNVa1dqUTRueDRoem5TblM1ZTQyb2lRYUh1?=
 =?utf-8?B?ZjdkNDNVUlljem5jRjh6WkZJUUdrQi9tWS9BMW80cGJZcXVRNnovUDk4L25q?=
 =?utf-8?B?WnFkN3Y4Wkxza3ZtUEI4YkNsVGU5UGk3MVZkS0ZlUkhmRkI3Q2hiMjFxaVYw?=
 =?utf-8?B?ZTU3WENLZC9sRXRNN0gwSUNlSTRNUkVaMkpUUzJrbk5VbGZSYUo5MXdIQmdt?=
 =?utf-8?Q?3xkspq4Nkv1QhThM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de09f5fd-f32e-47df-c37a-08de54f66397
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 11:57:14.4264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OZnV08V8grVS/AIfCin51mYbQsM0d7iTim0DtXY3rwe4W2ov5gJa/4rgfM7oRAdWWZoYDy/m0jmwN6TrjRPN/NSc6G6i7FCmOQ+hkznlkJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5947
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:57:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21637

LGTM!

Reviewed-by: Michael Adler <michael.adler@siemens.com>


--=20
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
FT RPD CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executiv=
e
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 236913=
22


