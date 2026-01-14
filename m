Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A1D37E43
	for <webhook@archiver.kernel.org>; Wed, 14 Jan 2026 15:21:55 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12708.1768404107007049414
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Jan 2026 07:21:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u7BMRriK;
 spf=pass (domain: siemens.com, ip: 52.101.72.42, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsgtCBPH8+L9nq2z/eAfHoc97CccrPXB51S7wzgBvYyuxweXAwoH+kS18N6asVQ5WT+/h/ihNqUvPq/3OEgNALinTmyBIdXKVcurbZD3YI/W2aI9C5X2ZVvAzYbwhEpCoeIRkXnrcjTr3b6WjPtZmm92yRdNF6c+0ed1mLHhZoM0D+A9pB9izrG9OWToKdhvju6egAO9U00rpRTixKaHPmJ1gLBTTOfniumuksTlvAgUyeU0PcUEJa+EmL1CqWltW6KTxd9kAuxTq22asvvpSZ7A8Sy9qcnISNlEYST2k5iTSaeru+iUP9UeTQdozdo+WLvsj7pw2M4tXPs39PrpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vkwmB5ZWkcESPqOIngmS4e+BeI9LxBzc1B3XiQ8NntE=;
 b=bo1WVhxYqTF7xdDJ3dsnReVH82GcMg988NncT/aCY/6aL4eds3GUHxLIhN7uGRJ9nMjhWNbewhrV6CzTKzjEEQ/cBq8+rxThdvwi/+cjFkNZ9us6Cmaef7e11+5Y8FARSZi9WAm8NVzpWvhM8v4i6d45+lpqPxkWpFQLvZDUoClbYYqy1+QGhpllV6pTIKvtfAc+7NIZk7rezhwIo8g96hOb6YrMRzIinQcbsb2+rfKxO7GxFh17mNPXBtlfMkBnjkM6miAC3HkcNIgwCvQ41xUd7TI/iWyxOXJu67TLD7HfmhZ8dgZfyoWp2EiWxLqV/wdMiVh+uayeNGdarisW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkwmB5ZWkcESPqOIngmS4e+BeI9LxBzc1B3XiQ8NntE=;
 b=u7BMRriK4L+jQeDDzCqbo3Mha/IsCXmxdWvvha+50JxPlICGeVGznSZxkvwJLf+FA3fc3ovTjz59bekkM/zPHPeij0JEjmqgrvcXSDpDz/QCua/sqttcmfM11KmAEcn8F9wXvw6Jw5kmCOymZfGzDN6mPjjIY0NnGEnaWncXGBu2b7F+oIVtOtQE6ZkkeE8TyEaFQGXfehqGElmmawg/h0d9ncPOL7ViMfsN9ea3u3+OYaSdj7e6VM93Y25Z9DqSHjXIpyxV6ENLTni2CyBVKzXBYCjO0vCUdBLMUGTP51U0MMmp44B+7Ia+2SuZpz6puAYrH2AwJFMvkpnU+Pc0TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:d3::11)
 by DU0PR10MB7214.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:44a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Wed, 14 Jan
 2026 15:21:42 +0000
Received: from AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3f3c:7681:f3df:d236]) by AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3f3c:7681:f3df:d236%4]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 15:21:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Jan 2026 16:19:35 +0100
Message-Id: <DFOEW2YQP65R.323L1O3Q5XG02@siemens.com>
Cc: "Adithya Balakumar" <Adithya.Balakumar@toshiba-tsip.com>,
 <shivanand.kunijadar@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>,
 <akunuri.sahithi@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [cip-dev] [isar-cip-core][PATCH v4 4/4] doc/README.swupdate.md:
 Add section for software update with wfx
From: "Michael Adler" <michael.adler@siemens.com>
To: "Adithya Balakumar" <adithya.balakumar@toshiba-tsip.com>,
 <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260114122517.1716929-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260114122517.1716929-5-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20260114122517.1716929-5-Adithya.Balakumar@toshiba-tsip.com>
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:d3::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB2467:EE_|DU0PR10MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f86365-42e7-4b08-ce1d-08de53809efa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SFVzaENkeStXOE9TcVFhQVQzTXhrNEdOY3hZUHF0akRqNE5Fai9LTlhXaGEx?=
 =?utf-8?B?TmVocXI4N1RhaXpObkEwS1Yxa3IrdUdRcGFHRjBNY2l5K3hpbHdVNk1ocXdK?=
 =?utf-8?B?M3BEc0VXcDRYUHdoTGdqS0lVK2wwRWFSYjBQZWhZRGJKbHdxLzVPUC94N09Q?=
 =?utf-8?B?V3R4VEM0b3JUeGxUam5LR3M0bVhRaWVNcU1sVmNFUkJSQ3RmaFhjV1YwTmho?=
 =?utf-8?B?QjNKT2NsL2xXSEhsVDRqYk1pOExJUXFIRG40RExLQmNoZGVsSTlZK0w4YVcy?=
 =?utf-8?B?TmNWYzZ2S0F3bGFaL3c0Y3BqbEs2K2liVjhWWHd4VWJVdDhlWDR6VnFTVUo0?=
 =?utf-8?B?Z3RDbElpNkNHVjNST0pKdmQxb0lSUTgraW13akt5SE1MTjYybUUya3kvejVt?=
 =?utf-8?B?NjZJSzhZQ3R4bGVRWnBSdWVUQVpGUXB1OURaRW1FNk9ldHIwK3VpWTJMWmY4?=
 =?utf-8?B?bk1KMEk4R3JLdWV1UXhoUEU2cTFWV0Ntemg4cm1VVlBPMnJEWG8xcGt6SExt?=
 =?utf-8?B?enNYUmNKQ05Vb2o0eUJ3QTRPOGZPMUh6NGEwTVp6Q2JoQjY4YXA1dVBWQUYw?=
 =?utf-8?B?V2N1WDd0U0srMlhwY3UvOW1WaUVScUx3MURzNTJzNlZaNWhKV2o0bURPbHpQ?=
 =?utf-8?B?Nzl5ZDgyUStBSmVEb2hVNUlZV3FyY1Q1ZVYrb3RyY3pIQ3MrYXIrQkJoSG9k?=
 =?utf-8?B?dlEvckQ5Y3l4NzV3bi9EeDh5S2JObTZibFlyUmtwZnJNWnpoNHV3ZHFUVUZl?=
 =?utf-8?B?eWR5eFlxNXpNOS9iVzVxN2RwMEZWczBqV3FwdzRLMkhkakVDaC8yb1Yzb2RJ?=
 =?utf-8?B?MWNKOXAzZStZdTEzaDNDMkU5UmRqL1lTd3UxSVc0Yk9kZlZrcUtIOGx0Rlhx?=
 =?utf-8?B?U2xTU0t3L2xkTFF3ckNKaFpHeVZSU1pNaUg4bmtmYksyc25aN3ptNHozMzlX?=
 =?utf-8?B?Q3A5QmFRbUxIZURveW1HWXZGSlMxRDlxRHVIek8yNXdQMjkyN082bExja3E0?=
 =?utf-8?B?V2crSTVHN2x6Y0h4T0NUUmNITFQvWllzMVM3cVdFZFpnL24zcmR2V2VLMWV1?=
 =?utf-8?B?UTlOYS9QVXV0MENmMFI2WkUxdXZZMFVMNG9zalZ3OUlyT2N0UkVpbXBScEFP?=
 =?utf-8?B?WlA0T1hublhoVlpaUUVrNWZBRE9EbnFyK2EwejJETk8wTUIvRm9oeW5COWcv?=
 =?utf-8?B?bkRsTGlOS0RCYnNFR2dsSjczZ21HU0wyY2E1OTFuSk5BQnlERTNRRW5VQlMv?=
 =?utf-8?B?bmZabDcyMWN6K0p1eGZyMllNeWRhSXVoeWltTkQ4d1Nqb1ZRSzViSE5VOGVa?=
 =?utf-8?B?TzN2TGIzczlDSHpFd2VyRjgwbjBWVFViRVBRZXhiNWVDcU1wZkpsUzFLTVpj?=
 =?utf-8?B?UmpRcDdYT3FiRGYxVjdvWWhzNitRbEhId0lwenpHVUdqRVI1bUFYNDFTUUFY?=
 =?utf-8?B?SUJPS0dNbm1pV0J2SWFoMVZtZEZ3RFQxUjRiM05FSDB4SU9pbEVmbjVuZVFU?=
 =?utf-8?B?U2R4dXhsbTJjSG5JUG81Nmdpa3hscEZ5R1BxOWMvVXFUa0VReGlOelVjSVJL?=
 =?utf-8?B?bVhvVWg4Nm9La3FZWTBuTEhVemo4Y29ZNDVhMW9YYTkwd3lnZEQ1NStYYzRh?=
 =?utf-8?B?NW9MSGV5dHFLRzQvbWNXUHlVU0owQjJ2dEpTZ1NaTnhVVWxGZUZBTlNSWW1G?=
 =?utf-8?B?L2tlUmdQa1MrcXRpWXNwVFJRdS8wd2xVc1hveDh2L1JmQnBQN29DRU1UOEc1?=
 =?utf-8?B?UTAzTldEenpjUExzcU5LeW1CTCtEUjZwRW0xMkgwZ1lzU1JJK0pJZFNTK1p6?=
 =?utf-8?B?aTBvU3dYbElHbDRmeDJuM1VIZmJOYk12OGVXc05PS0FxUmlJQTR6UmFiamdv?=
 =?utf-8?B?b3NjTnRGTUU3dzBSR1BrTkpsUCtoeXBEdDNHYlhTNHphRTZORDBDa05iYU02?=
 =?utf-8?B?SHA0d09MV0ppcUJTd0QyS2FOOGQyWXpScDE3Y245Rldma0tmTFgyZ0xOUnBP?=
 =?utf-8?B?NkRML3JPdzJHOWpGdXZMUkk0VW91a3pwcGRCNzlIczZ1MjRudXQ5VFFwd1hn?=
 =?utf-8?Q?ItLyFI?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UCsvRVpPTzRVZlZJM2dpQUJLbTVyK3V6K1YyL01BMll2YjFXdll5R2RDZG16?=
 =?utf-8?B?UWdHaC9OK2hVQTVnRzdTdEZQdlI3d3FXSENKazFJbEVISklkOGNTK1RaVXZy?=
 =?utf-8?B?RjB4bkQ0RndBejY2MytONnRhc1NZczV1V21EdWNNd293enZhYlk0OEkvWTdD?=
 =?utf-8?B?RkhWMnRSWElJOFBSNWxUc0E1Y3BDMlVCOFhjWkJqRFBCdmwwZ1o4d1BkNXM5?=
 =?utf-8?B?alora2lEOG1rRVFWdGZxV3lMOFpsMkFibHU2bUR4Z1p0bFV0TnZTTnd0K3pI?=
 =?utf-8?B?TVQxM0ZiYjVQcGpaamdGSnE5a0lWNEc1cjRmTXBDQzVTd3V1VS9YUEVzdTdT?=
 =?utf-8?B?VlJkTnlCUXd1ZWIxRVZmYnBoZnpzeitmOFRkMFc3QzBrMUFEKzNjTnJHZWEr?=
 =?utf-8?B?ajJqbXhnNXRINjg4eStGaTVlTE1UTzI4cXFZbzJCTjJObjdkai84NGxycmt0?=
 =?utf-8?B?cmpLenErd0Y4QWorc0NneVBzSnhBays2anYrY0pGb1Z3R0pYSktjanhROGNu?=
 =?utf-8?B?QzhBRlAyQUwvSGZXbDdqSHRyanlBTkNlVzhBOGtBcnkvUGcyNTI4d3BObC9Y?=
 =?utf-8?B?NlF1NE0zOXp3UVBiQlU0VjRKTGxTSGhvWHI1cWJkbmRYdVovMER1VTlCcDBs?=
 =?utf-8?B?NkEwYlFCbXVSRjhXbmRQclBobkZ6bTJ0RnlWeUYxV3dmNnMzL1VXZ1oyZGJ5?=
 =?utf-8?B?aVNZRjNrZ1h4NUtTcUpwaGpRNWt1UEdDVDRKYzRiQlFRamRUMU9mSFNkMFo5?=
 =?utf-8?B?UGUyNVNhWGs5TFZiLzBzamxjRE5rM0hzSW1QUzlrM3ZFQlpheHVwVmlLK1c3?=
 =?utf-8?B?eFJzRmh0dXliS1dYYWRVYUQ1YjVnUGxodFc1bTN2NVRKalJsSUV0M0VWNTFv?=
 =?utf-8?B?MjhmMFV6VHdRS251QzdUd2FJdG5UdHZ3NE4rbVVIUnlWNkE1Q1pWd3RrbEd0?=
 =?utf-8?B?d2xxdzgxRmFnK3B5V1U3WlZoY3FMOHdtQmVZcTVSNFI3YmNxbWkxd2NHWXBp?=
 =?utf-8?B?dXlERlJIL0RZTDd1ZzM2TUZPL3NqWWlrUnZ5WUNUQXFkUmtsTEdiZnIxRVNI?=
 =?utf-8?B?cWYwNXZ0eUtUdndBRHExR2dPeldad1pVN0c1eDJWS1hLS3NZUmFwTElIOTVH?=
 =?utf-8?B?MDJvN3NocDVVR1dLWlNQcElSRXgvZFpJSlhOcE04eVFOMCtENjVwcC9Qcm4z?=
 =?utf-8?B?ejdUOENtaGdVSXJYN2V0NFZWa1Y4cUJLWmVrSDVZaGhiSTZwcmJvVEN0d2Rj?=
 =?utf-8?B?YXJPR1NIWTllVnVqVnNoSjE4cTV1TkRtMStTZnBLSTRuaFZLbEc2ZjBrdk5p?=
 =?utf-8?B?SFVNaS9weUlTS0pCYWl1bWdhdmgyVCtHeFZMTG5JOEhFN1FmYXQ4UlhCcTg4?=
 =?utf-8?B?UjlZMlZEMTlWRDgrMWpYN0xQWjBXYks5NHYwQ2c1a2NCZWg4WVVVU0JCUXlv?=
 =?utf-8?B?WGlkblRrWlNMMUJUZkNsOUFzOThjQmwxUUdDR3JvMm1qMjFqOFNSSmEvL0JB?=
 =?utf-8?B?a1BKSldLVDdaekdIYksyUXBhbDB0WFNTK24yNFk1Y29HNldtbUk1UVBkb0pj?=
 =?utf-8?B?Vk12dUNheTkydXZGc3VRUE1Ub1l4U25QcXIzRnlITXQ2djZ4RzdCRzk3YTl4?=
 =?utf-8?B?RFBBUUVPazd4VjdxOWFteFBIZms1OHFBdHAzNXZDanM3TStrQXBFMmRpdWNV?=
 =?utf-8?B?S1ZjeVFBa2pzaUZXcFg3aC9vSHJKZUJjRXVIRkcwZnJZVDMzYU1pNEdFbW43?=
 =?utf-8?B?ejZMUFJXOEwzaGQ3eHZCeWh2SThBWjgzbTVNZEE5dEJNRk9tLzVnS2hnSzhO?=
 =?utf-8?B?LzI0S0tSN0lNVWxXaDRsbWpLNEs4Si9rbXZ6MStOVDJiRGY5QjNvODdwd0V0?=
 =?utf-8?B?K3ZTU3pESHhxeWxqa3h0L0NXaHUyZmlWZTRMbUtRbmY4TFNXUk5WZ1hsN2V1?=
 =?utf-8?B?RlJNa1Q3UzJmVzM3ZFJDSTY0dys2bGtGWHFtQXplWm5EV2lLeTRDVHUyRGRT?=
 =?utf-8?B?dGxuNDJrMVkzRnE4UnI2TTVpajU0UmJJRXBBaEtsT0pYM2V2RzRDaTBhcTI2?=
 =?utf-8?B?Y1UrQ2hmT3JraFJ6K3NFTGZaODN3bEczZTgvVkhCWU9va21DODkrSDQ1MlIx?=
 =?utf-8?B?TEV6RkZpVWFGeS9LaUlGM0czem54Z3RIV1M0eUF0SGZHT0tMcFpzQWdDVmpw?=
 =?utf-8?B?UmdOQ2hNa1lQd0FuTTBCRDJoY1E1TERLTTFrcW05Wms5Nmd2eXIwWmFRUUN5?=
 =?utf-8?B?Qkk0V2Y1Slova0Z0VFdzalM3ZFpoUWpoSFZEbDg4NTdvSmp2TDk0ZjBZZG55?=
 =?utf-8?B?TEJ3NEhNTGNBdzBLRkZrL09XR3pPQkhUaHpxZkJkTmdxK0kxZkUwSWhrYnlJ?=
 =?utf-8?Q?fYGtM69G7tqQDT7g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f86365-42e7-4b08-ce1d-08de53809efa
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2467.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 15:21:42.2589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ue0QfOLMx1U0628LRcOkSiIaRgju4173mdElCJdBVD4N1P5cQRAsAF2+0U2gifiBfcMH75S1GTWkA2qDiWabL7yoBwAQ8DSpTy/dEB26kMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7214
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Jan 2026 15:21:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21557

Hi Adithya,

just some minor comments and nit-picking (overall this looks good to me, th=
anks for the effort):

> +**NOTE**: In the following sections, please replace `WFX_HOST` with the
> IP address of the `wfx` server. `WFX_HOST` can be an IP or a
> DNS-resolvable server name.

To avoid repetition, maybe a note like this instead:

**NOTE**: In the following sections, `WFX_HOST` refers to the IP address or
DNS-resolvable name of your `wfx` server. Please substitute `WFX_HOST` with
the appropriate value wherever it appears.

> +host$ curl -LO
> https://github.com/siemens/wfx/releases/download/v0.4.1/wfxctl-0.4.1-linu=
x-x86_64.tar.zst
> +host$ tar --use-compress-program=3Dunzstd -xvf
> wfxctl-0.4.1-linux-x86_64.tar.zst -C wfx
> +host$ rm wfxctl-0.4.1-linux-x86_64.tar.zst

This assumes x86-64. Maybe add a note stating that binaries for other
architectures are also available for download.

> +Start a docker container running the `wfx` server:
> +```
> +docker run -d -it --rm \
> + -p 8080:8080 \
> + -p 8081:8081 \
> + -v /tmp/artifacts:/var/artifacts \
> + --entrypoint wfx \
> + ghcr.io/siemens/wfx:v0.4.1 \
> + --client-port 8080 \
> + --mgmt-port 8081 \
> + --mgmt-host 0.0.0.0 \
> + --simple-fileserver /var/artifacts

You might as well download the (statically linked) wfx binary the same way =
you
downloaded wfxctl, leaving docker (or podman) out of the equation.

> +Create `wfx.workflow.dau.direct` wofkflow:
> +```
> +host$ curl -L https://raw.githubusercontent.com/siemens/wfx/refs/heads/m=
ain/workflow/dau/wfx.workflow.dau.direct.yml
> -o wfx/wfx.workflow.dau.direct.yml
> +host$ ./wfx/wfxctl --client-port '8080' workflow create
> wfx/wfx.workflow.dau.direct.yml

No need to override the client-port (it's the default) and not even used fo=
r creating workflows (the mgmt port is used instead).
You can also avoid the intermediate copy by feeding curl's stdout to wfxctl=
's stdin:

curl -L https://raw.githubusercontent.com/siemens/wfx/refs/heads/main/workf=
low/dau/wfx.workflow.dau.direct.yml
    | wfxctl workflow create -


Best regards,
Michael

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

