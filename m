Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C32B6C0218A
	for <webhook@archiver.kernel.org>; Thu, 30 Jan 2025 15:38:30 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.89])
 by mx.groups.io with SMTP id smtpd.web10.18090.1738251501575368486
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jan 2025 07:38:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OIQsXX0N;
 spf=pass (domain: siemens.com, ip: 40.107.21.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHii6vZziSHVfSrkTRQ+aecPcyYmnr7bi02kkBeU7/10xj/WYuzclKlOxxN2+UyFmNh1Rw9es1jHxQjG/tDLg0ff6rdCDDHVAJplJCBgOu4i3DShmpHtnhKJ1XF1JKPnY2RcQqRg4irWMZ+ixnkQ0iZQmyUiZPBpKN8QN0BEU/xc9di9KX+GRhQ542Tpc5tGK9niXQvyN/bT+Rm8v0VhHhJZ17TrCurS2ED8VUL+psDyWZ0mlJ58DXAifI2hDKySAS2eOWKj1B+4eOWbgAbwwzhIQdi3dFdPJGYVl0b4shSr4A9Xlhb3M8tQ48fLAvIQMnakkF3ZBEZGHB3PZ2k3/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukEjpqZhsgoDEBvnL7S/n4b4zOtxuAdU7q3xm3TDZk4=;
 b=rCG59QSCkmrpfXjYZGwhE90fj4Y2oO6ZxraoVgzKqkSumRq8oijAREc05MPTJz9OCScDOo9GKKNNJAaBtSt9hpP9TEmYdmwGWTbZUvZKf5df+hST6NLlQWzoYcvEWnPhS2hjB1yNEeOjQMZAhXmRz8VEGVLpEd6ZKUmSMPIIur86WvxMbjbvhq44C2nOmS1pgb+FoD7u8L4swENx+WL/tLPnXatnjnFHPW5WFwuyo07YHyMwGykLuNORhl4yrYK1dapfwpwl/uxXqWoWUxa2OINw48YhOojjsC5n8JJAvkUBZEBxcqb0YUsdHg4Vrzll+ZFuOr+LmPkx9JZCIBOfjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukEjpqZhsgoDEBvnL7S/n4b4zOtxuAdU7q3xm3TDZk4=;
 b=OIQsXX0NLoPfuEj/9ZlXtIAl5hZ2Z3kwmj2+YnQcxM7oCYH9E7x7mM0QZ5IgrNZ4Y1KzLZCqj4FeT93hxsHOMnHtZgIb/MliZQ3KTjD+EqO/pi4AZjVYkXqBy/okXo8LPqi1keQfkyNKazwLMG24MaWp8PV4sZmPLSnug5QAGsILLqW87A2WznsRyvDo3HnNC9l476m/MagoPC53UOUAOOa90AK7LYUtxCXbTPdGw1xC8bdYS7CAG4Cxk4A9DemqtwjmzL0gW1mqhNKnOSEka81kuHProWb2xm5QmyfvSskV+zjFSHPviT9nyMqKb48fmAmBvIIpbBR7ONfUFo4nLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3824.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:167::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 15:38:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Thu, 30 Jan 2025
 15:38:15 +0000
Message-ID: <2977e475-7bde-44f1-bff6-82b2953b6acc@siemens.com>
Date: Thu, 30 Jan 2025 16:38:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC][PATCH 10/10] Enable A/B snapshot for /var on
 x86 and qemu-arm64
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Storm, Christian (FT RPD CED)" <christian.storm@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <cover.1738229957.git.jan.kiszka@siemens.com>
 <39b2a0d2ec39701f76a2b6b800f34ba3c123b0e8.1738229957.git.jan.kiszka@siemens.com>
 <96b0e4ca59368ace7192648c5db288db0ebc9610.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <96b0e4ca59368ace7192648c5db288db0ebc9610.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3824:EE_
X-MS-Office365-Filtering-Correlation-Id: 51fc2c28-9ffb-4667-5e08-08dd41441ce5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cWtyOVdSU2YwMnpZNFNZdkVsMVJzQkdXVjZiK052TGNWZFRSMFFTQlVBNWFw?=
 =?utf-8?B?UllGSm9TL2czaVlJRzhtWHNVdXo2U2ZSSmtBKytNZ1Q0dzk0ektKSTEwNWlM?=
 =?utf-8?B?UTNpTzRkaGo1ei95eGJXUjRYL2dvS1NSSzQ4SHZJaUpkZTlLaCt5d0FUQ3VD?=
 =?utf-8?B?di82aUcyUklDRFFRY2lvUmM4NmEzTk0vNWdzekF0NSs1T29MVkpSWEVVdlZo?=
 =?utf-8?B?WDhaNHJvUzc5VHFpSDRSUklBaWFqRGtnSEpQeHp3a3JlR29nR1VUSVkxV1VK?=
 =?utf-8?B?V3BiQ1FVVG5CQVJ6SGVleHhuazJka2ZXc0RBbGlQMjZaQThKZ2xMRWwwZU5H?=
 =?utf-8?B?alY2NWVOZHZlLyszUHlLNFY2bStxYjcxSDc2ZmI5bFk2K2Q0b25TZDFXQVlz?=
 =?utf-8?B?c2N6UFlWUzJZWjBXK1cwdlVRV2tRbEdJaE5uaUxvUW9yMXdDNnR5STRqSnpi?=
 =?utf-8?B?UXcrcmZyWTJabjI1Qld2R2hLVlNuTE91MjZtUnpWaTlBUjIzaUo2UWhkaHc3?=
 =?utf-8?B?dU1yaFVvLzlyNkQzd250ZnJZT244T2VSQUFXdDRydmNFQU52MENIM2I0MTBZ?=
 =?utf-8?B?YkRCbmlEcUo0ZzJWSXA0OFZCOWRCdWNXUUZTSVBRVWlHV00xcGpqa2xXMEg0?=
 =?utf-8?B?bUR0WVpUTlpKcS9YSk44eTRUYklOYTdzT0NRWWx1MFhlQzBZQU83SHlkOVYz?=
 =?utf-8?B?cVh4ZGV1aDVPOTJFUmtMMTRaOEw3WjVZcGJTWVRYWHdSU3VsOCtqV0kyUUlI?=
 =?utf-8?B?bDhzbng5KysvS000ZGtkTXEwR3d2cVkwS1Y5TlZQRmxsYUpiMUp0NVNxV2hH?=
 =?utf-8?B?cy9JUm9rR1JLaktFbkpidVcwWTdMLzVsamNRWlJoRDV1YlZMcWtaWjdKeHc4?=
 =?utf-8?B?NkZLejVZREJyVER6Q0F1MVBwUkVWT3RaUEdnUjc0MjJGYWxjaTlJOUtIeFVn?=
 =?utf-8?B?WGU1Y05BWUUvNEY3R2RzU1M1dDZZVUVyL1g1eUYzdU8rM3l4R1c5RFBneStp?=
 =?utf-8?B?WXJIUVIrYlVXN0NyMTJkZitEaTlONFBQVUV4bVNNY0xaT3ZHOWFXOENJTDZQ?=
 =?utf-8?B?YzkzUjgrKzkvZzJ3TG9vZ0U5UlpRbTBjQmVIUHptdXpYMGNZQk5PcXYvQjB5?=
 =?utf-8?B?YXhEQ0NHTVJOS2U0d29rOWxJdlJrbitDb01ITC9Oc0dMRjNCMStLVHNGazVX?=
 =?utf-8?B?dWo5aU5xaU9EcEtSbHZqMFFtbjhnYW42elI3KzluQjB2NE9jc2FPUVgzM0d6?=
 =?utf-8?B?Q3BQSlZyNi9GbS8yNXhUdW5rajdxZ1B1bVFtSGs4RzRaYnd4c0N0VEt2WnFN?=
 =?utf-8?B?ZUxaWUE3QjlveFpBckF0SmZWaXpmUERVT05DajVabVFudDA4cUJJem1yWlIx?=
 =?utf-8?B?clBnN25SbVVjYkx2b2VoU2xqL3JOdVZMZEVscGxYbGxnQmQ5TmZlSWpoaGtO?=
 =?utf-8?B?cXp2Z0V5MTA0OStPSTFkRnhOeXhnYXovYW05L0ptamg2MWpRbk8wZDZYano5?=
 =?utf-8?B?SXdWOHNUNWUyeVJDeXpIVkVYOFN2RlloaG9LRmNTUTM5bVNjcDZEUTRMWWpm?=
 =?utf-8?B?OFM5L2I4bUhmZVJSL1JDMVZEZGRtcHZ1ZHlDbWYxRUo5S09qVmxtR3NYd0FH?=
 =?utf-8?B?Y0xsK0paaGNrZFBuV2wwYmI0UjlQQmlmTGJzOW1KYUp1cXFPZ0l6bEpieWhK?=
 =?utf-8?B?VHNrYkU0K0NMcDlJdVlIRDJkeTVpVzV5WGxJRWRpaStlVzFOalVNNkQxWWpR?=
 =?utf-8?B?MFJwRXlqTXoxUmsvUnVsMVNJTEgvK2hIajBtSERXNWJjTHhmYTdPNitNM0Rl?=
 =?utf-8?B?SDZuWVk1em1qRHRHUlpyaVRYcDVSMjFIblBTbERZVFBLcUVaTGFCUGVqbDhI?=
 =?utf-8?Q?nzvKlVD0q8nhJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y2VZWUptTk1pOTVPQ3c3ZU5lOVZXSmV2QWNIZ1FXVlNMNjdMcU5sZTRVaS9P?=
 =?utf-8?B?Q2NHTEl0blhkT0tpNlorenJkK01YTWFpNW03SS91OWpHNU5JeUx0dmVzVVNW?=
 =?utf-8?B?V245UzBOeCt4UVVrRjJyOTkzSENvcUV5Y2VMS1RBR3N2UzFKWUhnNkpkUjB5?=
 =?utf-8?B?cmtWVm02dGpqSWhOVkowdmx2QUdmNk1FRUlielFmZEpzNmtmK2Y2VkQ5Qmt6?=
 =?utf-8?B?RVJ0ZVZJeHZ1ZDBvc2JTMW9sbmhyRkw3Qk8wdFNQY2ZkYTVoenlUWkY4RGFr?=
 =?utf-8?B?SG5Zd21PbS9EbkozaHZXWStoMjRlQTFXeDFJSStrYi9ESnYrdFFTWVRpaWZW?=
 =?utf-8?B?UGc3WXRUelpZSjhiNzM2VUtOaVZILzdvaS92aG9IeEVXSldjeXRjVXR0VDJK?=
 =?utf-8?B?cFpNSFk4QkRnZEpnYVVsalZLbm5HdjBjUnpyVFp6OHZtQ203Zml3MG5tVW5Y?=
 =?utf-8?B?SXFGRGlDeHA5RHRpV2I0d1NIRmJzY1NsQlkxUCsrS2E2OXp0OWNNUG5qR05P?=
 =?utf-8?B?L1I1bUZmRFJJQzFuWklQc2hjUVp2anZyRmEwbFBxZ3lQUHBOalFXU3pCSjNI?=
 =?utf-8?B?dlpzcm16OXowWlNyQ2U1WnFEREgxajhVWmJZQ1dKS0JXYndCUEREZUlYbjEv?=
 =?utf-8?B?MnRqN0F3VmVLMXhvcEViSldyZkFsc0R0b0FwZzVyZmk4KzMvVmE0cDhIKzln?=
 =?utf-8?B?ZE9vMUNhUjE0UUlmcDFCNTdjVDI4RXptN0IyanA0bmNjcDJXck5kZmdta0hB?=
 =?utf-8?B?YXp5RHZtOHRvMG1ZZkswWE8xaFRqckRqU0N6N2JaMGxmVCt6T3Bxa0tyUGwz?=
 =?utf-8?B?MWZNd0tvU0N3RFhJWmdoL0tvdXVNL3BGcXRWOVBWVUt4clhWdXhpRXJPUit4?=
 =?utf-8?B?M2x6R3E0bWVrQXZNZTF0THk1YmFSNk5UT2JmVGlEWisrK0tSQkhETDl0dFlz?=
 =?utf-8?B?enF2aUVhUWlKMmtGWkhqSXZhQm16b3VqOWl0TkVJMEs1aVpXVXBnclZha3dk?=
 =?utf-8?B?enp2SXdSWTZLb3ExK2tpUkhYbG9sa2J1d1owZzZPZzB4Z2ZiWUp4Ukd4a0R5?=
 =?utf-8?B?M0hrMFNsTmlwUlVtZU1FUVNDVitPakhKcGlpclBnaEpkSklSbXJwTmN3L1RI?=
 =?utf-8?B?YlYzTzZBVk1uV3MwRjRkelRtSmE1U1ZjQzZkUjRjQjZ2N2duVnlxRWplK1J2?=
 =?utf-8?B?U3Q5bUs3VHZTSGllbVNFYmRjaDdqcDkvRSt1ODVWUXgreWN5Y2lRM1dzUWpH?=
 =?utf-8?B?NklRSzhOenZjMXg1clovVDY5UGtuS1BqR0gralVkR2VUVjEySlNwa3BvQkJV?=
 =?utf-8?B?Z2pvRmJqcFRUUEc2bnhNYnFyUlh5R1hxTStZQTUydzhsdjF5eVJFdDE5Z3Vh?=
 =?utf-8?B?a1NXRjJIdkFxblBQVE5zT2lQZzV2V3dTQ0JoTWFQZ05WeUR0MzM5bHpyVDN1?=
 =?utf-8?B?aFJVVG1IZXhsaS9EdGJkRllXYUlSeVF4TEtRTUF0Y2grY1MzVkxudXRXV3BC?=
 =?utf-8?B?dk0xUExGY1FzK2xBdkh3UW45NGlkMHZJNUNrUDNyTHNIWFBCSllPaWlja2U1?=
 =?utf-8?B?NDhkV0N6anR4eitqanFDOE5US2NtVTE1bjlBR2NMM2RQU25LRVg0ai84ZXVh?=
 =?utf-8?B?SS9pYXdrOXVSWmsyeGpZS2JmcFU1Mit0NEUzcCtCakNTdjRvSXV4dHE5ci9n?=
 =?utf-8?B?T3poYzFMZDk5RlQxYnllZ1ppOXJRdmNoWHNZcVJsOFR2UHRNM1hUbDEwaHZY?=
 =?utf-8?B?TDZ1WWpwdXJsVkVqUml3YkpaSXlwaUpxMHJqaFg1SGtIcXpyUVc4WkpFZE4y?=
 =?utf-8?B?SnhhcUJiR0VWckQ4WVp0ajY2L3hkRlBTZDFyL0ZadDI2YUx5eCsrQUxhakRn?=
 =?utf-8?B?Yml0SlpDR1JRMkZTZ2RLbXl2WlNwQUd3U2VocTdYcExSZ1Y4ajYvdElYK0d1?=
 =?utf-8?B?UHRaSnF5UWNvUEFxWkc2RHRncXE2SmNXbE16WllYOTQ4dFFvVCtaMlRJM1JX?=
 =?utf-8?B?Q0c1WkIyRktlaU1raWY0UVcrRkxWTFhuZS9MaTdFSDZ6ZGlVU2VPRkE0MVd4?=
 =?utf-8?B?MXZucW1jZTFQMURDMnV6TjJYOCtTMlpTUGI4eWppUFk1ekJibThxYzkyc3Fw?=
 =?utf-8?B?cU91Q0xmOUkwQlg3R1I2U25IUWFNd2FHU0JXcjFPb1BEQ05oZjQvaitYbThN?=
 =?utf-8?B?UUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51fc2c28-9ffb-4667-5e08-08dd41441ce5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 15:38:15.6257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vodKzTEBN2FG9LdkPznDV1XRh/uW9o4G+j0GZ5Y0SIW3XOUYRS/f0GMsZzx2R/AsPokiZnndJWbnCR1ltQgudg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3824
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 30 Jan 2025 15:38:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17711

On 30.01.25 15:06, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Thu, 2025-01-30 at 10:39 +0100, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Other targets still need testing, some even kernel config tuning.
> 
> Hi,
> 
> do we have a target that uses docker / podman? The containers are
> usually stored on /var and this is not necessarily compatible with
> BTRFS OOTB. In general, docker does not play nicely with a COW
> filesystem. That's one of the reasons the docker-btrfs driver was
> invented. However, I'm unsure how that works together with our A/B
> logic.
> 
> For details, please also see
> https://docs.docker.com/engine/storage/drivers/btrfs-driver/
> 

Yes, there is more to think about when it comes to production use. E.g.,
you may also not want to rollback your logs in /var/log on failed
updates. That pattern we may address later on by creating a carveout
from var on a separate partition again.

In the end, this here is just a proposal that may need further tuning
when further requirements need to be fulfilled.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

