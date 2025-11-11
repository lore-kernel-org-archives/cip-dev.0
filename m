Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA897CCF9E3
	for <webhook@archiver.kernel.org>; Tue, 11 Nov 2025 06:00:15 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.22])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11446.1762840814828194625
 for <cip-dev@lists.cip-project.org>;
 Mon, 10 Nov 2025 22:00:15 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bDYpu5JA;
 spf=pass (domain: siemens.com, ip: 52.101.66.22, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsEKBmjnbC7LENGDEQBPGlCRavzBUUG9PE08ZT4kUn0ksTYxJ9ahIUMrdO8SiPtIvQikgtwjLsbC/Ob/N44Rh1cw8BIFJFz9G8vGB5wpd5rodON9YzaYxIFStdXfZ4rdwVG8TZXnwXSX/1VBQngpRpS4ymYajur+IljS5ijXR7tBOzx/lU0bnRJpDkE1nvXyRynE36NTmmMjYGHjoDKgz6rCL2/UHGMslyaQHdVZGp4uvjDhWgo+Kh2TtJUub7NjfZweXctS9n00XHgbmD3qF7qJ/aUCpO9zYIzLsIKqDH91kh8iZjic/sffpzt8VTx1gg4XD/I8sSa6uLY26FgLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yA3H1IW1byHst/DoDyr8JDvCATi2qSRlq1sxSo6u0X4=;
 b=hDwG2i5m2E4MISHItQ80rDCWBAn1UkDhUuCPBYGlEgp+LYtEf65och9GYIG3gftZMJzWVrsf06mocGQnr8qojY1MM1bo22sI4eCTjhxoY1Ppk2GbvkmnZBurMoIetLPs8hMtHoFdDtdaqKoexrWuaWWW6psDdChIta0BG0EnhOqcRzeKChBgZmqgw3T1TrieKKiSxspfg+8racZB/WpRBylnbW4ZJwUqyNNWHRdgxt1sVSJ4XsXgK6cEH0NBt2pSngt1QuDLHqDLfY8yOULhzeI1wONDB9qHHpAIwlQq14zpWChK5HGLXWlltqX3zBJTMdTdljK0FBDsVjWwAe0adg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yA3H1IW1byHst/DoDyr8JDvCATi2qSRlq1sxSo6u0X4=;
 b=bDYpu5JAeRuKD0TRQ80QGCa8AdzONYEuyDz34f0o3qI6eyQQ7tpqzZM9Mf/Jk2muc5XfrWOk4Kv6ujIw7Qxlfpu9+3b4Vd8oGI68xwoFqANfcZH1bPEwpAKB4lrKpetB252Jd+sWFOPCO9Ky2hlW30FyhYqpRFHtgBYnkFtYjtuTzmQwpnmK9Fh256/s/lXrpd0AnpNoeT/UUQfxT7Pl33nI2AN0nMcGLw1mh2ELHCCojbS+N3vhslIXhYDmRkWS4zFqj7YiGgqPhaawXidXlxG5Ti12WfXNa0XXNDjQJmuRroH2sj53QyCvOrhts5Zo0GkbV0GUM5/j+yr1dRh7yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB7536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 06:00:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 06:00:11 +0000
Message-ID: <36d4a0cb-93fe-47aa-8d68-84ce07fc3700@siemens.com>
Date: Tue, 11 Nov 2025 07:00:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/2] Use S3 for RB test artifacts
To: Adithya.Balakumar@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
References: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251111044720.778805-1-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0096.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d37ede-7f12-4371-d62d-08de20e79300
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SEtMQjM4WWpjQnl6cE4zNEtsQXNlOUQ4Vm9WdGszMVlTcWhXd3R5dXlCTEVE?=
 =?utf-8?B?OXI5RnBxbS9naWY1c2pMSVU5UDFDcVVZY2ZlQ1FoYjRlYUd3b0JadVcxSHJx?=
 =?utf-8?B?K0h5WWMyYmdwUjZlc1ExTEJCNUthcGRFdmlNNm5laVE4RzdXU2xUcGI2a1g3?=
 =?utf-8?B?WjE5MHlYcmhQNmlockJIcFNyZkhabjRHak45eUlueGkzclp4RVZQVkh3SzdW?=
 =?utf-8?B?Vkd4aVR3NEpJNXkyTnZpU21DdW9lVFNEYjl4TXlGcjRvVkVRMS9NZ1lkK0Fm?=
 =?utf-8?B?VTBkZEdnRVBYWC9aQlIwMXk1M0xNNlVtYmZrYXk5RS9UdktaTkcwdFRleWFz?=
 =?utf-8?B?bmp1ZGhxU3pWdTVGWG5BL2hpdUdUT1ZZdkFUbW9NWXRoVkxGTjZGM21xMklC?=
 =?utf-8?B?d0JQaXVEVjBMSkt2QjBaSlZsL0IwQWxpYkNKanFIbzhuVURVWGZHUnFtWXlp?=
 =?utf-8?B?Tmp4ODdvZjFtUnc4aXhRWWhUeWVTS3VoU29Zd3QvNWZaWXVyVzROK0dIR0VH?=
 =?utf-8?B?akRVVjBxZkprcVpib0pLMHc4SS9DaGxFZHpZa1I3cEpodjI5MlBrOVNPd3lQ?=
 =?utf-8?B?QVZ6UUpQSG52MkFEVEc4LzRsaVNXcTVxT2wxOVpieWFRS1BVZUEwTVJFTlRG?=
 =?utf-8?B?TTdzbEhrcDZySDRkR3M5ODRoTVcvc3RUZkRrVE5EWFVCTFV0MWFtVWJEdmk5?=
 =?utf-8?B?MVZMRGd4OVN6aW05MmZQYXhTekpVM0hiMCt3RkJhRy8wT3Z5d3ZwbWtHUG1F?=
 =?utf-8?B?Tkttc0VwVzE2K0hBRS94VmwwNDFFZGZPSEIvRExaeWd4Z1REU01kTTNSK2JP?=
 =?utf-8?B?RWVOSUVnaHNoM0graGhWLzhQd1hKWXRXMjB5UE9hbVpWUVgrNXV2anlhZGxo?=
 =?utf-8?B?UmZwN0hOdTA0ZzdtdVlMK2tpOGl5WGZ6dDMwNitsQ3hJU21ab2VEc3JkcWFB?=
 =?utf-8?B?MDNRVXdmRGZFSnZOZUtOZHRDcXMzZ1RwVDFEdUoweHZsb0ZOVXhTWjhHc1J4?=
 =?utf-8?B?TVVMcHJySXZTV205bW5wejNTS1IvbHNJSGNodS8zcGVhSk51RWl0b1FGL3ln?=
 =?utf-8?B?dlBwNDZ0Ymk2UHV3RWh2OXBtNkRyOEVRS0RqZnY4ZUkvakkwdnBSME1kejcz?=
 =?utf-8?B?UGJCQUgxd1o4TFdqbmY0RTNwd0tLTy91ZzJVUkZ2b1I3c1A3emtMSEtUaGJB?=
 =?utf-8?B?VTRPYjZhZXBYdWFVWGgvdElFNWMyY3Zid2pUNEkxN1FTZTdoMnY5TGN0MEdi?=
 =?utf-8?B?L2c2RDhLcmRLM1hqdDlVWlpNV092czlGd2MzQkcyZS8veVVYbStFVW5OdnM1?=
 =?utf-8?B?N0dhN1krZFBUZiswcG1wclBXbjRhYmpvSzBnOHA1cXJyRXJBQ2p0RnZIYWRY?=
 =?utf-8?B?NGVQM09UZ2FMZG9sOW16SnlmNXJ2ZzZPM3FKWWZvR2dBUmVVY0xWbDZEU3Q4?=
 =?utf-8?B?Z2o3c2QvL1lEZFV4TGh4enFqN2RQVXhPUTdzWW03ZGsxd3R0OE1LK214VmEw?=
 =?utf-8?B?TUJuNkZaVkhNMWZGaFk3YjExS1lWcytod3psRWI1bWtuZ3hldER4ZEU2dUx0?=
 =?utf-8?B?cU83ellBSWtsbHBDbysvZEpDSmJxbUY1b2VmaC9aUEUvaUZ5REtxTXNmYkdv?=
 =?utf-8?B?UHVsVkhWUlZQaGFpMmJyWmxRbFU0WldVRXR1aTRXUVR5VC9xZGw4K29zeDVU?=
 =?utf-8?B?VnFHOUhtbW9JaVczK3oyNGwzbjI4dnEwaXVTeU56aUR4dm1JejBFVmV5Yzlm?=
 =?utf-8?B?eVc4OWh2dzd3ZDAzRGxaaHk1NXByTnFnNk9lYzZxZHVhN29RMi93WVFiWTRp?=
 =?utf-8?B?a3pCdVh4Y1ExdU5MaFhLbGI3YUZDL0lUYmNwekNCemJmaDJDL1VLZHlWYUUw?=
 =?utf-8?B?U1F6RS8rNW5vRDdRMWVnblBwM242eG45azFFUzhhQUJBY2ZGcXZxelNOaUdj?=
 =?utf-8?B?cG5kdVZZU0NRVXVXRlhjcTlqS3pCMmE3cVQxV2VvMVZpZWNNT3I5RWNNQmwy?=
 =?utf-8?B?VFFoenJxc0ZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDU4ekdQRDVaU1pSOGh4Mm5GMWV0MU8xS1FpNEk5a1BmVHBuTmhyLzBnajJu?=
 =?utf-8?B?TVJjZS9ON3hJaXJHcUJiVzdyVDNCRStwMzN2dEpFTm1BRHV3NVE2TWkvdnM1?=
 =?utf-8?B?Y09YeGNDeVZlbG1wMkV3TnZlZnFHcTV6ZXJUU1Zpd1RnckpxdnJ5OGdnRUp0?=
 =?utf-8?B?cWhIZ2NJdS9YZXlJSzVJV25mY3lMOEdMLzZUK1orRldKZFhQejhuUjhSSnMr?=
 =?utf-8?B?amxJWnUrdEl6b005V0JTWlJPZHNBODJPQWpGSjF2VlBrV1VWbmdMZG1XUlEy?=
 =?utf-8?B?cGJHa2RrRlBRcllGRzJtdE9VUmpIWERjc1JNaDZBUm1uU2tCUXVvVmdzZHZo?=
 =?utf-8?B?K0JDTGtDZVYrMWFIWTU0NDZuTUNKK0VwaEwvT0lFWmFXdW42SzFXLzZkR3Zu?=
 =?utf-8?B?cVJVVytwZGpzSy9McDhmYWVuVHZlMU5vd21wOEdXOEx2U3dLZU5OWG9Lc0VR?=
 =?utf-8?B?b00vSXNMUXJuN1N5eGl3Z0tLNDdYZmZXUEpTdFQrTzBZVTE4MlhySElXc1hL?=
 =?utf-8?B?czBvTVhjQUk5KzlYOWFsa3Q0eVgzdVdYYUNFNG1DNzlNMGp1S2JTM24zeE9Q?=
 =?utf-8?B?M3lRVTRFUWlMRUF4RWF2eWF5TWw0ci9XcGdPUXliSXdtS0ZnZDR5RjF2Wjha?=
 =?utf-8?B?U3BkOWxFWHl2V1Q0WHpRMm5ldG1ja21wdmh4elFJb1g1OVNmNXRWL0s2S2pT?=
 =?utf-8?B?ZkJ5RjNHMGFJSWJSUUI1RWgwcU40bzBhNk5aNE90MmIvb05CNTBIMGlUeUpz?=
 =?utf-8?B?aWZQcmVleEcwS0pWQU5xM0tIYU9mOWovVlBQSkNrQjBGSU15RSs5S3AwOFNz?=
 =?utf-8?B?dElSVktmVGJzTllicFQwM0pHQWdZRVBkaHIvYmNiRThyUExpTnl3c0NjYTZ4?=
 =?utf-8?B?enIxckRKeGF5b1NaRDZYVXpUQWVUQW9pV1BxYWFrdGZMTGJwSzVESTRzMFpC?=
 =?utf-8?B?ZEw0aHVTdWRMYm16Nnd2eDVZd3ZWRGQxdWRLSDcvOFZ0QXdWeHlOaDR3dVJZ?=
 =?utf-8?B?TTlSK2VLTks4WXQ3N0ZqL045RVlMSlFNQ0Nya3Vvb3ZmejJrTjNEbE9EK2Zy?=
 =?utf-8?B?VlRzOEdhem1QaXNhNlhmV3RUeFEwZGovT01mNnNwalgxdGM2QjU0N1hwWmkw?=
 =?utf-8?B?bDRVOXpjemkrSE5GbjJad05FN1BaUTRJbDVGa1JCMEVKQ3IwY2czVTJrQ2Qv?=
 =?utf-8?B?dGJ2YThVUWNPd1JwM2VlY3cyUnlBMVNORnpsUjlBQXNLbmFTaDluSnUydDda?=
 =?utf-8?B?YkIxOExKM1d4dE9rM3lJL1M2QWVNeHVPMExGTHFFMi85SXlWblpnTXVFNTdR?=
 =?utf-8?B?OTFyWjlXQ0J6ZFJCdGJRMWhpMnA1Zzh4Q3M4akxUdjl3Y1J0NzlvWlRMT3Vy?=
 =?utf-8?B?cFczZWEwSTNYVm5nOUFyVWMxaWd3dUgwemU1bkduYm95WW4zTHdYZUhhNWJp?=
 =?utf-8?B?ajVoUjNmamdIdWR5RzdBSGtjZndLQmx3cXF5cytiOVRpRmc2V1d4UHNrTTBO?=
 =?utf-8?B?WjlkRzNrRkdrbkZobFFNYnBzV3ozOHEvV2EvR1pPNTRwUWVsRTNlK1U2WG5C?=
 =?utf-8?B?bzdMaitMaUVRMXZNYmF1S083R3RRNmt4RDRpRmROMGpZUkpHWnY0a1MxVWNp?=
 =?utf-8?B?MGFoR0d0RVRpNTdpR2w4RHFnUE1NeHZUM1hlQ0FDeWxEelhoQXkzLzhqdzNS?=
 =?utf-8?B?SDVSSThRUlVnd29RVTBPOGRzRW5vNWI3RXY2eHVsZkVQOVFsQ0Vjdks2QW5r?=
 =?utf-8?B?emNXTkJoRmEzMTI3ZkZwUUQvTUFaV0RBK1Y4dlR2eUczK1VRamdhVndmQks1?=
 =?utf-8?B?Y096d1BkOXhNUnJlU3Q2aURPWldGK3JIY2lOZE8vNFlvRjRNNHdXS1I5Ui9x?=
 =?utf-8?B?ZmVmZ2VrMjQ4ZEc2WmpKdXMwOG5sQUw0V2N0cSt1VzZHV1owY2QzM3hnWUJU?=
 =?utf-8?B?dERkQlU4SXloL1VvNUVlUDJXZXluZ2FKY1c4M2RoeUJBZjJrMGtEQi9abTRG?=
 =?utf-8?B?TEY2TDJKRGR0bFNtSjU4WmMwUXdYekl6dGxEUkpXc1ZKM2UyWmFVRkU1eG9Q?=
 =?utf-8?B?eHlrWVVvV0hxbWxmOEF4cEduM1JsUmVScm5QRmpWT0hvb1F4bDYvZUJBYjZX?=
 =?utf-8?B?ZWpMa0RnaGNJVDlYUi9JbXdieTZvVTJrcmJKVHUzejhlL0kvZ0NWWk9kKy95?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d37ede-7f12-4371-d62d-08de20e79300
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 06:00:11.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSYVLKyETBWwouTyEDPp/+5tYUF5EeELGiRa1CFEwiDLIzc4kBJHlkABrnfmY5PNRKKAgbfjiBxFtXTPUMmHbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7536
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Nov 2025 06:00:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20491

On 11.11.25 05:47, Adithya.Balakumar@toshiba-tsip.com wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> So far we have been using the gitlab artifact storage for the build artifacts
> from the RB tests. But this has the max artifact size per job set to 1 GB and
> lately our builds seem to slightly go over this mark.
> 
> We have been using S3 for storing artifacts from the CI for quite sometime now.
> Let's use S3 to store the RB build artifacts and later fetch from the same during
> the test stage.
> 
> Changes since v1:
> - Control RB artifacts deployment with an optional 8th argument to
>   deploy-cip-core.sh
> - Drop patch 3 as its no longer required
> 
> Adithya Balakumar (2):
>   scripts/deploy-cip-core.sh: Support deploying artifacts for RB tests
>   .reproducible-check-ci.yml: Use S3 instead of the gitlab artifact
>     storage
> 
>  .reproducible-check-ci.yml | 66 ++++++++++++++++++++++++++------------
>  scripts/deploy-cip-core.sh | 21 +++++++++++-
>  2 files changed, 65 insertions(+), 22 deletions(-)
> 

Thanks, applied. And pipeline triggered:
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2151391468

Please remove your own test schedule when no longer needed.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

