Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE84C021B0
	for <webhook@archiver.kernel.org>; Wed, 19 Feb 2025 16:32:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.44])
 by mx.groups.io with SMTP id smtpd.web11.26856.1739982774299314726
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Feb 2025 08:32:54 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wU4XZ5vW;
 spf=pass (domain: siemens.com, ip: 40.107.20.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KA3S3H/qSGeGfa6IFbCwGluMU2C1bEocVy14/7p8J4MHJ8E7g9agDeLbH6XHFHrnkSwKhsDMv8CpnP1OQKW9NxDYZL7S1P1ZHT7e3OqzZ3U1JVOYSCcoZ17bcyIYI404Y+c4o6eaN5Vpk+yz7Nudps7tlnHyY4+SF6E8tmgMFOSF3cH8suKo5vkvAxYMr9q7KN6bF7Bj10byD5MKLttPHS9rwfb/nLxgxlVlrFkvnpVyGMsKsyg5s6EM7+DzrCsksba8mTPxQdMFvU6AbjE2+sZSj3GD2MRRjcjoW1FeLYo+McQf2TcMZrJh7Uah2K2rKF8whDMNvMdTfvz+93geEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0l0HX/8UEhD6FcLLU19txzCSq4TgPrFNuOhhi2U6L28=;
 b=n3Fe5G4oo12Q8AMPy/Tn1zDiSrkoYZOeF7o+Um051e1Ya7UOpG8hFK5nfYbyOs+qsmRobEIPPoGI6fqcc/dNdlFNgJXIWgweDqCSADpmM1WVVjum5cfyCPX/mPML6KGE5JVaBVN4atyvc1nwhMzTO4jjnyW7JWaXfS7X7AO2SYJu0MpRf40gtnY5iFgjFimrwn/1IK3D2fi/k77/tJ3Rw97pZFCv+bBEPj+Sd1Ty2qzA05/xiMbL1N2ujhopCXalg79oyXT3E3wL5QeppZ8dfsyudTNafhvdjSlijWxBlsZqTyB32tBmO8XJWRaMhX8GZ7zBWftX6r67IVjPN5cROg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0l0HX/8UEhD6FcLLU19txzCSq4TgPrFNuOhhi2U6L28=;
 b=wU4XZ5vWlZVx/L3jflK7EnnHNJ+Y/ekvKmNTOO+BPvL/8xdAqDqTTLTAPgburE7AVm8gBxR2p0xB4qy2s1/ghS9rU3jI8p34fyWaaQ0jXpnziyZUxmbtbSUA2LiVH5ONIRkhH+2chNb4ShidYy0aBGQwTD0who4Wz/mM5JUXn3phVxwmxnfAGXb94pQ6Xhq/0jVg87bACfzRO8OcuM1RX2QtzfgNKXvfflYBm7CN0VVwR8zLMf6iTPRZYa1D2Y5F+GBvVdUUhHeKbXsuq/46r5BiIrVGy4XE0HpAVecZVGVu+3jsGgISSOpaBYWiOMgkgbmS5YViSnE++uGQ4IZIIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAXPR10MB5759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 16:32:50 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8466.009; Wed, 19 Feb 2025
 16:32:50 +0000
Message-ID: <b2fe24f5-f8fa-4cd7-bc5e-996758275cd6@siemens.com>
Date: Wed, 19 Feb 2025 17:32:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] crypt: remove e2fsck.config
 option system_broken_clock
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250219161331.1669565-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250219161331.1669565-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0305.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::14) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAXPR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 045afac3-9147-4f51-c3b0-08dd51030d0f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Vzl0ZDE4Sm10UFFZWUxCbGtxMHpYZ1I2a0hGWDNPeTZVM1VYT2drR2lQYjlW?=
 =?utf-8?B?MkRNQmF5NVBVSHNTMFR3Z3AvVWdCSk1TZFB3VlFHTDZUQ205SkNXQmdBYW1a?=
 =?utf-8?B?Ly8wcVVYbVQvbU14R25nMXhhZUR1Kzk0MUU5OW1uRS8xclZVc3hZQ0pOYTBX?=
 =?utf-8?B?RnBNamp6dmRyMFFDSC9rdUdxUnRSOVBHN3ZETU9NRjdaNmhHa2dwN0ZLZE9q?=
 =?utf-8?B?cG5CcUtYSkNoU3VKVG5qcTJPWURCVW1uSEc4ZlZ2a245SURGTGdMSFZpMzNi?=
 =?utf-8?B?VjEyUVMxMDRtbHFTaTNmVFU2Rk5mRFFIanN5L2VjVUptRGJaMnhVSElUc1My?=
 =?utf-8?B?VjB6L3VXM0VuM0s5Y2ttWmJIdkZPc2x5bGlsaEVtRnZCYWVRVWI2RWlTb1px?=
 =?utf-8?B?OHFKUjBPS2lOWVNpRHREOHlPeWVubyt4dHhwZmFoZFZoVE5kSERJTHB3MUdG?=
 =?utf-8?B?NU1JQ01XN1k2aUNUTHlYYStSTFAwS0ZXMitCN2VMdnJ0dW9JUUtDUDhnR2tr?=
 =?utf-8?B?SzkzVWRmdEgzQUJhVC9LYzRkWXkvSHdwNzhtbVJHLzJMRHBhQ1dTdzdGemhr?=
 =?utf-8?B?YmxodnNRN1pjTzU4NWhSa1FXc1hrQ282YmEwdUFoK1lRb1RxOGRKOFpCUVB3?=
 =?utf-8?B?RlFLaVJ5OCtmUm15dFh1V2tMMHFsbXlCUlRMMXIrN2c1Ujk1YzB0Y2NjazEv?=
 =?utf-8?B?Njd1bmtVOFhFalJaaTZuTDErZWluYU9lNXg3RzN6bHFyVTdIMFFwQlRCSmkx?=
 =?utf-8?B?aWpyaHdHd1N4NWpTUTNaSlRacURtZ0k4dHB6Njk0a2szYUZielhKREU2NXFx?=
 =?utf-8?B?T2MwVktucjRPSWNXaEFkRGllUm1idTcrWWpiaHg4WnVtazhoNG1PaGFPMEFs?=
 =?utf-8?B?Q3hkWE1JSzlqRlBidlJ1N09Ic2doN2VHRGNjR0pFU2ovKzhYWEtRa3Vldi81?=
 =?utf-8?B?YzJFajgvNVJSSEwvTnVKcjRHNzYxaXNCcytWeHVXSXEvUHZ1aGE5WGRnTTVM?=
 =?utf-8?B?cExiWmVaTU1PZ3FmTXNmYUJTdVlJSW9aSWhFSXNOVytvWlBIVGN6L0Z0WGdt?=
 =?utf-8?B?NVROZUVhZnNCLytGcjBPV1IxM0wzQ3V6RGhzWFMxVHNnNmhNM0Y3N0xCbUlL?=
 =?utf-8?B?S1ZCWnp5MzVScmFtbW9BUyt3cjNKWU03Q0o0WXk1RmROMHAvSjhCK28rKzl3?=
 =?utf-8?B?WDJSNGZOaWZ3Vk5aUHlKN252dzBwNG0vaTY3Tm90b3U3YjJKZGlMYVJHK1Bm?=
 =?utf-8?B?T3JLNUEvejJWMHlpQXNJUzRSdDFubTNxL2o2b2VFV2tHNk5CQmt2YWd4UzRR?=
 =?utf-8?B?NUcxZEZOMzdpRzdzaW5iQXBHYzk4MmdrdUZCYXBxZC9MV2RYWU53QXU0aFYr?=
 =?utf-8?B?UWZ3TXN0ZDlhUDZDZERFY20xejVuYm1yNmY0cE44NHkvSzFYdmFTekdZamVW?=
 =?utf-8?B?YnlIRlptS2IrWm11UjJIS0FkU2lDcEFLRkl2bVFlUnNEWU5wOGoyaCt0NUxI?=
 =?utf-8?B?QTVLeW1nMWkyYk9CNFlqSG9GS1B0ZGtWbW5kWEErZGYyQlJKY0hGVW9DaHVj?=
 =?utf-8?B?Q2laSi95WElVeXl4NXB4RmV5dnJPUEtreDRaTVFOaE1EYjZxakNWUTNaMUFU?=
 =?utf-8?B?eUJUZ0U1WTNGZEZZL1hXaEdDcHNSekhEaEhOSEI3NC8yejJaYk9lUE1RWHp3?=
 =?utf-8?B?bjc3cUJoaXNjYkJwWGNXd3ZZdWszd2tZbTRCWkNtYzlVdVZpQU1MUmJMcUlC?=
 =?utf-8?B?dUk1NXBOa0t3RTJxVHdoajdocEpmTUhjaE91MDBqQTEyU0pTQ1BnSERMSzNC?=
 =?utf-8?B?U2syN3BYVVhJQVh6YVBFNm4ranNiQUtidUE2MDcvM2lacmV6NWRxYW9weTEv?=
 =?utf-8?Q?pVDnVCCyFhNv6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eEJwRVRVbGpVZHNQUUUzQWNpb1JLdWlGY0pxTGxOLytxY05sYzM4NDBRS3N4?=
 =?utf-8?B?eTUxNXl0RlZCaTFYdGFCdFRib1ZwN283MVJxKzJTUW52UEYrNGFxNXN1WTZQ?=
 =?utf-8?B?aVBqZ003WlJnU3Q4S25BUG5sOHlDZGNJZlVPOFlhQ0xGWm9DTk9vTkE2em9T?=
 =?utf-8?B?MWxvZ3V0V2N3WWRJeC9vZUk4VVVXa0tzVUZtSlQ1eXRGRVFQSzltK0tuMEJG?=
 =?utf-8?B?ek0rZklQZ3o0MWFYLzVheTFSVy9kWjU1Wm8rYVpsWUxyU2FvSkYvQ1l4Mlpu?=
 =?utf-8?B?RnZES1BHd0RxWUFrZ3NpUnJocWJqQXVQL1Z0cjZ4VWhtdnhmRkhnWDRNbUF2?=
 =?utf-8?B?bjRXbnhDMjdKOWdDMlljL2tDcGlhekh5QWxJNWFaK1ZMT1o1TXYxTnBDRzhJ?=
 =?utf-8?B?RDFGSmhKQWJ6YTN4L1V0Nm8rcWlMaFc3OGM2L2l2MFU0dEpIUFhKVlVpTGdY?=
 =?utf-8?B?TkhWUktNc3Q0NXNFTUhnTlVxUnFZUHo1NHJGTHpqWTE1VE9MUkF2VklhM2pu?=
 =?utf-8?B?YnNiaCt1bXh6cUdNTExscHpPNWRIZTNtUXM0QkRaOTl4YTJrQVJZYUlRMmlN?=
 =?utf-8?B?TGtJdXhLTXpnTzJjbTYyVEx3Y2JENXBjUjY0dnhsSjdiVVlIS2t3NjZMUElT?=
 =?utf-8?B?RVc4YXRSWjYxVnBTOFNSVE96YW1GdlBMREE5b2RieUxxQjkzK1FBTkVmNUR4?=
 =?utf-8?B?Q0VGeTNHZlFnaEpPL2VGSVZrMmtNRDByWWRsWFY2d2hudlF5NWhLWGhVTTBB?=
 =?utf-8?B?cE5MYUgvMTJSZG10UmJyczBzeng1eVIrZ0htRFRJeE1mckZQdnFkWmE3R3Js?=
 =?utf-8?B?K0M2ZVNJRkxXMnhjRWgwZzdxMVRydDhoNzdkWnFhQWNIRmU3eEp6YXQrUmZu?=
 =?utf-8?B?RzdvOG1JMGs2bnIvN3FXT2JWazE3TnNuYWNsNXI4aUNhYU9URWVaYWs5OHZq?=
 =?utf-8?B?RkpGa1dvVXg4b0lkVXFvVzY5QmZnbVlhU0xYQndTYUV6YklxSWo2SElkVW1B?=
 =?utf-8?B?c0o2clovOXR2cWI4NEQ5MUd5NGR2T1NBZThKYm1XZ05CNXJuY0NkV0E3ZGZs?=
 =?utf-8?B?Kzc1VlZFRG1NQlBDNkNmWHN1MzF1b0RKMUZlQjBVWGREWlhZaEhYZzUwbTB2?=
 =?utf-8?B?cGVSbzFiMHR6dElZZkFLOEZsQTZSZnN2VldYb0ZtdTVGajlTVHJhWWlzWkNE?=
 =?utf-8?B?TzJTQkNuY21MMGFEdUNuMjYwTmo5NWFSSHMrL09yR25xUVN3NmtJdkR4OVN0?=
 =?utf-8?B?N1h0NFZCNjl4UWZxWjk5MUsxQ3p3bmxyMW5zS0FxVmUyM3U3SWc4V3h2cmhx?=
 =?utf-8?B?bXZrbE43VHVnNEhTTDk4MExqdUFGU3FPclIxWDdMRkV2SVpGSWZvYml3UXRz?=
 =?utf-8?B?Mmd3UlFMbjR2NFMvMWdOcCthNENnTnBoZ0RWa09WOFpwY0h6WWdhVCtYdU4w?=
 =?utf-8?B?OHhZUjF0ZGtESFg0QWowVjZVVW4rcXF5WnluMnZCZVhXV3h3TmgxbWRiL1ls?=
 =?utf-8?B?Vi9TREpXS1dVdDJTbnhYNWJHdGhsTUIzZnhTekdwZUJ3MVdxVWp5RjNWOUww?=
 =?utf-8?B?RFZNWFFwS3BwM29zNjNLRGgwUTE2TkxobXRwM0lwZFFoazM5N3Q0M1k3Yndn?=
 =?utf-8?B?WFdyUGtjQUhab2JUS3VMUEQ1Ni9kZDNMTTRqaldsOWtWUTBYOTlITUVna0hK?=
 =?utf-8?B?a1J3RHdaQWFOM3ZBZ1ZyQWFwbFovMWtoRVVJVExmcTdYSlJpWHFRWGZWRlVQ?=
 =?utf-8?B?S1hxekFDUkp5ZlpFZUVycFloMlZpeXVCR29rTUI3SjRNZXp2eXlwd0hzNElG?=
 =?utf-8?B?cERzRVJCdGtlOHRnSmpFMFNMZHZiMVVyZ2taTGlkMWxKOW1pVmpiWW84Sm0x?=
 =?utf-8?B?OXRLSWljd09QOVZ5djRCb2YvRHQxUXZRN3REcGJhN2YrWURnZUlpUEp2SWZz?=
 =?utf-8?B?N2NGNWJpU2ZoRHBnaWl0dFNkYjlORDIzT3VBVlpWcjRJTFZNb1A3cUlIMzkr?=
 =?utf-8?B?V0ttS0dLU2VnTDFBZ3JaWFpQMXpDb09zL2tYMFhDSjQwN3VGa3Uvamp2clI3?=
 =?utf-8?B?VDlEYlRCWmkxYTB4cVQ0aFU4TW5mUlZZSHIwcDdRNFhTTzR1VjNmNmpUSm9n?=
 =?utf-8?B?cXY5M0FmRm1vazZXenovTE4wUERCc1k0ZzRhRFZGTnpFVnBFWE5hUkZkbGVy?=
 =?utf-8?B?Snc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045afac3-9147-4f51-c3b0-08dd51030d0f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 16:32:50.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ongFHgFzC7YTffBkXw1v3ZdUN3hTqhvpE4sZzbfDd1DLO4B4FwUtkUsAho/ipgrRM51W/iqi6H/nLQ8r/dW2oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5759
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Feb 2025 16:32:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17869

On 19.02.25 17:13, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> In case of enabling disk encryption after the first boot( e.g. enabling
> encryption after a firmware update) setting
> the option `system_broken_clock` to true will lead to a panic in
> the initrd as resize2fs will fail with the message:
> 
> ```
> + resize2fs /dev/sda6 1330380K
> resize2fs 1.47.0 (5-Feb-2023)
> Please run 'e2fsck -f /dev/sda6' first
> ```
> 
> resize2fs checks if the time stamp of the last mount is before the
> last check. The e2fsck option `-p`(prune) repairs this mismatch on
> systems with a unbuffered system clock.
> 
> If the encryption occurs during first boot, mount timestamp is not set,
> the system boots.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> was: crypt: do not assume that all system clocks are broken
> Changes v2:
>  - drop setting the e2fsck option instead optional enabling.
> 
>  .../initramfs-crypt-hook/files/local-top-complete            | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 54b8a6e..5ef7ca4 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -75,11 +75,6 @@ reencrypt_existing_partition() {
>  	case $partition_fstype in
>  	ext*)
>  		# reduce the filesystem and partition by 32M to fit the LUKS header
> -		export E2FSCK_CONFIG=/tmp/e2fsck.conf
> -		cat > "$E2FSCK_CONFIG" << EOF
> -[options]
> -	broken_system_clock=true
> -EOF
>  		e2fsck -p -f "$1"
>  		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
>  			panic "reencryption of partition $1 cannot continue - resizing of the partition failed!"

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

