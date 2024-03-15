Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94134C54E58
	for <webhook@archiver.kernel.org>; Fri, 15 Mar 2024 10:00:19 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.54])
 by mx.groups.io with SMTP id smtpd.web10.18019.1710496813232144983
 for <cip-dev@lists.cip-project.org>;
 Fri, 15 Mar 2024 03:00:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WkTg+pvh;
 spf=pass (domain: siemens.com, ip: 40.107.6.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8oiEm65VjkqzJDaO4Updjp/hs1ofAsNacmM+9E5Rho698JTU5yEEGvkn0lS9cK32h5qRjumaHPyB8nXzlBi28tmu6ORijY85QPpSS2QR3rQoOByPqSm0Gle7WmXOWLyea/zQ/nFH9fhOKUiVdJkgZLbNAbh6Xtao8xI3RzveGo0UJP2L6N5kTKKXJvhda7QqLvRiuliHPVlSlUX6zcrhAkgh9wofZ64bwHBUHYEwdbKfKD3PPZl1zJcrELV3Ewv5wNzHyoM38saghxak6PbpPWt4sZA31qmg/KrS7ILofAi+RFNGd0NKi9ur/sg4pdKBiJlDDyqcPAXEjAJTwEgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4QguJxlz+37Ed/G+Zo7c0hcJF7U0/0vjKP60tCPspgc=;
 b=iKUeDe65obR75mc8bEAKHE8GERmNnXleAXy8OLRXFAyvgSzJw+BtkkxhnfjCT6D86qhUC0AC9JfuAUuc3OtbzV5S+e7MEhlrh4mThVnDYcgqrXWR3Y3aSuT9Pi5jO+u8TWuW5PZW3Wc9vL17YWRDOg4THMZU5uM/uFzLMg2ygkryCAr0gI1JsJN3+LJLal0RcjTTZvzjXHOYWMKXek5E6L8ygAkoJdNAttE5a5OHrPktbJw8op5pEe7gvnSshA3vJV1QGmihQVbMp2qCkB3lgV8iMFFTApIzgCz1PegBaZuA350Ia3eNgK3jeHSt94qFvOHxGUcTI4Aa9RkXUTXyBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4QguJxlz+37Ed/G+Zo7c0hcJF7U0/0vjKP60tCPspgc=;
 b=WkTg+pvhE6G++GSrNe0+3ZkfoJ2AToF3tqfK5AWdMqRwcL5ye2OCWAlikQnVndB0o26SgU52JFl+OB66X8RPxy1XdFni8d4sGUtV6JpxWieRz03JvxUFKx5bUKb/Go8J4RtKugqNNBxhBpkYwmIBXIAn3Pao7nA3pjzcPKxNAHDysuc2W3Ip6sqSDd7tK5O5yhxUGbYMoTr25WKC5EGewNYq//efkr+8xfo9W949jrzlpsyyqK3uy7W/TcpVwG7HKo7SaEzEqKxB7fF/0v0EKJT6RPqbYO/gIG0AsI1iUV8xeyBoM2Qh9mAbOXYYGdWlcZ0zQZJdVsNMJERzqDmLaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5512.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 10:00:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7386.020; Fri, 15 Mar 2024
 10:00:09 +0000
Message-ID: <115947c5-1b60-419f-9e4f-f4a7ba504263@siemens.com>
Date: Fri, 15 Mar 2024 11:00:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] recipes-initramfs/initramfs-crypt-hook:
 remove unwanted directory
Content-Language: en-US
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20240315095246.275065-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240315095246.275065-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5512:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f437461-3f4b-4738-a04f-08dc44d6b2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mhKAcTF1rfU/x3fgpJsmIyhh3PQo/xhy+fxhdMzZOLvogxBgwD5gRWtqh4JbWW57MXWb2QPWdpW20BeyBwgpG+CL4ieaaLf2Cr3SRToq/T+OX+0qQT3cYNPfSniVa3r4KlLa9s7E2LxfRPOzpJ++zdPjaPI6EREWvGFFNS2xGtUWN5dLywqzdf9HnO640ehk6uHAU5qwUiHRLevSb3MrUlRmQoUJ/pblOMAkWMLjcp45GCwcUb03FIBthPicc9e+iQss7i/rNOfCe7ZTMhpv9rKVj/mQUa7OjfW2VNVsKV3B6YlXxKaLdTX74pzGQh7WuiJKfsKqi5ZcOcktMEMRwpR+mqH3AoDKElFiFxHpM7cE2aqqDiCCSfrQk2sNpAcXgijdJuk2DOZ4gfrZglePfVavsEJq9a2cPGnXlt5YPnQcAIu39z3cHl9oa10t+5HyzcuCNFkv3L6z/61lmawQtX/8yluf3O7dJKJNAVezcfdO7PygKFtoive94ugQIYf2n8qaHKs/JC6QTt2ky1aInsf53pRfQbUlXEVALLiwOSE57/OTPWRDqQswLOSanOlOH1RkWnFXX7QB2naZHN+rU0w8S4UMy3GQ32OEailH7mtnJsQLq6pKt2Tg1TX2vk+J055zom/FQY3InCGHNfgNqO/V5F4oHCNlCDqV+gO/h3o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cHJtcEt5RlVoVC9zTjlhVW5GKzVyWkxDSlJMK0NuZHl4OThnejJXL29DTVVx?=
 =?utf-8?B?WXZJQy9pU3ZybTNhckp1V0djaWNqcE1TSFZtZG5VSURlVFBwZ3FNNUp0dDRH?=
 =?utf-8?B?Y3FydDRDNlQ1U1NGL2dqV1JnUjBrTkwxNFBaOHdscC9YMDQ3dlVrU1VsQTgw?=
 =?utf-8?B?MW9XM0R0Wis1MGFQWHZERWRxRUUyWnBDbHFUNzFMVGFPZHZubDAvMkwwY2xE?=
 =?utf-8?B?anRTT28wblBRMng3MzdkSDhnTjZ3Yy9jeXR5bTVTYXMwcUZ6alVOaWdhbTRm?=
 =?utf-8?B?Yi9hOGJPODVnR3EyRU1WNURVeUFTclJrN1REZGFoS0ZVR1orM1BZZklFOUw4?=
 =?utf-8?B?YXZFQkMrdUVUU2FqZndadjRzbUhCUmUwa3N6SU1WK3l1SmluOU1lcXJXN3B6?=
 =?utf-8?B?cktHR21FbDFkeTFUNGI5ZG5RbVhuSk5WeElqa3o2VktnMm5DRkQ4TXhURytM?=
 =?utf-8?B?bkthU1pUeVNuU0tkSGQ3WC9LYXozd0o5ek56akoyUWxLQ244KzliaEZob01U?=
 =?utf-8?B?cXNjYTRPSDZFdDkyb0JpK0lwT0p6NFZaOU5LWXU0R1RlQnJ1RGQ0Q3BHWmF3?=
 =?utf-8?B?NDZLeFdLb0pFUnRkL1lkNjNQSm1UYmxPN0duOGd1QmJwWStFbVc1UGhDbEox?=
 =?utf-8?B?dThnVHFHUmJ2QUcrL3Q1ejFUd1hxbVNOQm9nVWVTWTJkR2oxeVQwUzVqN3Ft?=
 =?utf-8?B?TzA0Qnp3UTFYVXdweGRRZVNJZThpa2tHSkNCeXh1TWdTYXdnMWZoQTVHOUVP?=
 =?utf-8?B?ZVJtSmlwWWZxRFJRd2hnRlFkMnVsdnJxWU1zeG5OVmlya0xVUlY5RVN0dlJT?=
 =?utf-8?B?OGxrbmwxTnpHbzd2eEk4d2hJQTBsODZlWmwrYnVGT3ZDd3hIWGhxOFkveE9D?=
 =?utf-8?B?aEkrdTNVejFNdk4zbjNHckhZNUpzWmV5TjJweENjV05IUC9qTG5oREpSV1dr?=
 =?utf-8?B?SlR3cDRCeTdWbDBhT2tNUXFDR1lndDI3TGlYS1FTQmkwdjA5UmVUK1RMZlcr?=
 =?utf-8?B?ZjMvNE0wV2NnSm1LdmdxWTFWSlk5QkFhYWhxRVlVOGRYRnRkYWlmSVg0bzFQ?=
 =?utf-8?B?aXpZb1IreGtncFcxZWpsTFU4SVFvVzRjM3Mxa1ZOZUx2Sm9jUlh2N05ldEFu?=
 =?utf-8?B?bTI1NW5QU2MwY1dmUlRHRlF1ZGxmUTFCZlhESWFBMnVkcGE5N3JldkxTTDBm?=
 =?utf-8?B?cThDWGE5K0tsQ1FROWdxa0wzM3NDYUZ0MnRuK1RPYlFkTzlMcmlJS1Z0c1hH?=
 =?utf-8?B?RTk1YjI5Rjg5eWx1YzFIOGtqK3dOL3JrSmI5TDQvT2RMd0llUGpYUFVGbGdQ?=
 =?utf-8?B?YVFNaE80TDdqRlpFZUFnMm9kVHpVR2srSzRyV1N5c1AyNE5wc1piWEFCVXNw?=
 =?utf-8?B?MytZSU8xYUZ1aUx5S1FCQmlJTEQwTVJuUTNJeURZRzh2cElrcHU2OERxcWxW?=
 =?utf-8?B?TEtHa0dVdVVvNG0vRk9kMXNPRTFFeVRUTEtlWlQyYzFMRjFiT2JLTVN5eGRR?=
 =?utf-8?B?VlBvaHlPZ1g5RnNjSEYxcldCa3FBZVhGbFVNa3doTW5Za0w3TldXaDUyVkNE?=
 =?utf-8?B?Ry9rbGsrN0wvbUwwVVdqTk1LZHF6bS81dmVDZ3RRYlBVNDBoeEQwNHMyWTF2?=
 =?utf-8?B?a25FQmhkOUNvMW1GbTlXaHFuekNUWkFHdmoyKzJXZU9VV25UckZMU29mTVA1?=
 =?utf-8?B?T2VNUUdDUWJrVC9tUzNtL2p4QkdvZzRkZFRVbHE1Z3BZdStlNjdUdXg5V05C?=
 =?utf-8?B?emJxRlh1TU5CMDFYYlpQYkl6bUQ4aGo3c0Nnd2h6Qy85cVcwT2wxSGlKSUd5?=
 =?utf-8?B?Nk9ORzFZRFBXZVlMdmdJbGF3eFVrd0RCSkZROUV6cER0aysvVmMxT1ZpOEMv?=
 =?utf-8?B?ajNYQmlYNXdBZkxvRXhtaCs5WGtGSTAyd1RHZVZrYjZvZVdZdGNsSmVEKzdl?=
 =?utf-8?B?Y1lyc1BKL3c4bnZrMVU2eElodGJMT2syaEphZE5QanNzLzRidHh2UlZocVhl?=
 =?utf-8?B?QkVQejBQZGd0TlNkeVlkb3JNYXNrSGJJRlJRL0Z2NmtOQjg2TnhYY2Ziang2?=
 =?utf-8?B?R0x6RFRPWXdLTk9YK1FhWmt4SUtMQXdSMFhOQUpWNklHUkhRSENRNTl0L1F6?=
 =?utf-8?Q?5Q5qb2eooFNNAUeUAfBBEhKgx?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f437461-3f4b-4738-a04f-08dc44d6b2bc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 10:00:09.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esWV2qhpHsCGkwN85O66g3v/cMUUUzLZslmJZR+bL9zxgHN8u2TsGXYZNzDzZPv+UoJZZJiYRsWb1pQ/dvhXAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5512
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 15 Mar 2024 10:00:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15324

On 15.03.24 10:52, srinuvasan.a@siemens.com wrote:
> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> We are not installing any file under "${D}/usr/lib/encrypt_partition",
> hence removed from the do_install[cleandirs] part.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb          | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> index 3b2e6fa..b275c0f 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
> @@ -48,8 +48,8 @@ TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>  do_install[cleandirs] += " \
>      ${D}/usr/share/initramfs-tools/hooks \
>      ${D}/usr/share/encrypt_partition \
> -    ${D}/usr/share/initramfs-tools/scripts/local-bottom \
> -    ${D}/usr/lib/encrypt_partition"
> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
> +
>  do_install() {
>      install -m 0600 "${WORKDIR}/encrypt_partition.env" "${D}/usr/share/encrypt_partition/encrypt_partition.env"
>      install -m 0755 "${WORKDIR}/encrypt_partition.${CRYPT_BACKEND}.script" \

This dates back to 98974a68ab9b644830be7f1325df9a22acd78cd3 - Quirin?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


