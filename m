Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CFCE7717D
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 10:14:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.47])
 by mx.groups.io with SMTP id smtpd.web11.7563.1733912087738917789
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Dec 2024 02:14:48 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=efXcfuLx;
 spf=pass (domain: siemens.com, ip: 40.107.20.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAwNnBFLUUFt9SccGUo4QT4wRCul3d8WPcHpa065lE/WSMEOTEg1hrD8t4c7GLLJPzP5tknC6FX5dE9MSgLWr5IKwVVN/0nHXaEwGzvSGZ9SO0RqEfg2Qv4k4rBZaFOj2P49dAbVRtXoJA8muGkiBJoNRGRvIhigHxOuYwMiL85hbQz7UAkmAINAaCduPyZfSHkBv87XKzodBc5ZF5ZOezJXEnXMRvOUfZ8XxyqO3d6cXCshx2vpurlICEi1Xvhqtg/48wKf1YvTK4HOyeCyxDUDhAQwYg64AG7Uo2rsMThk5Cqx4s8mYQtvohAEMYHGaKrmLfKAqM3eO4wQ+7kpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/La4R5sA43NNGcXOz8GHMS1d5V756Djo0IhFPd/ceSM=;
 b=DcHVB5P7rjzpS4jToNCROs5ZS47w4aWHWS3UuMupa94fpsrC7MJir0nN/qH7xPMVg8MM3w0oEMZI00lXvge0OyajT6STu9YAcWwOv4RNt0ZZIRQOEAcO3Z8H9VbVD7fCuCuLAjYdQQ72pAlR2K5DLjzwLO4/4oMdXVxvUpy0qirGgj3lQVSnVk7XlRWFlevAEyQyeGNcp/VgYdt31oWIR70rOmdXHGhEIRb9vugCGiRshy3sjeuxUitaYfXLiaOJejhhBOGa6/PwbObETwErByylMxBOJkv3RQyMeKxMRRju6+eK3uDqQKucQ2bNONvEvR1wseyRa8NbIOehNnnmPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/La4R5sA43NNGcXOz8GHMS1d5V756Djo0IhFPd/ceSM=;
 b=efXcfuLxitTyieoJC+z01DnZpcERZosTUzukVRODwd8eZLyGvwthDCEMIoK5bWst9DZjlY/LPBYmtUw8UEcN6rA8iJGFFN6YTJvEJ4BiZ3+gwmBsDQIbLmXJtK5ZmXGhqkJJ0Gqppb44tAoqDyLXcnHxTMceeZvCPiZJoWwf/lhhp38GXhcSbzjqjxkxXAoisk+6SDUik2w7mXLlh4MMo3TRbMoHdRsnkjW4AJIDfAspVettLqVfLC4XKEsRz2Su1yxG4GknFtqbXJS+Gw6Z0XjnyYe6KIE1Iy1gAQKROCK+Xq99d7zG+aeADcNfXQw8jxcYuyE6bJbGoczmrV5BWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB5241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:349::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.12; Wed, 11 Dec
 2024 10:14:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8251.011; Wed, 11 Dec 2024
 10:14:45 +0000
Message-ID: <4e3dece2-fbd9-43a9-b018-4db8dfb68d10@siemens.com>
Date: Wed, 11 Dec 2024 11:14:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 2/3] erofs: ensure only dir prefixes are
 excluded
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20241211095456.2735691-1-felix.moessbauer@siemens.com>
 <20241211095456.2735691-2-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20241211095456.2735691-2-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB5241:EE_
X-MS-Office365-Filtering-Correlation-Id: b821dce1-9060-4263-045f-08dd19cca295
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?azFYd1Jkd29rMW50dnlVdDlkK2RJaURmTUZaUUFSMFlQa3B1U05mTm9kSVBm?=
 =?utf-8?B?L3JIaDBsVHBuUFRZYTNJQkZ3ZUF5N0xrbjNaT3c0QW1ZK3dGeWh3eGRPMDRV?=
 =?utf-8?B?K00wNlptYXFQdTZrc0Y4NU9NL3BSdERVanZjOThiY1JkdlZSL3Fud2JtM1cy?=
 =?utf-8?B?YzhKTlVHbzJWV09tNm1hVmxBakl3TE5NcTF4aUJsczJCcUduWFRITmNneW5I?=
 =?utf-8?B?R296WEZJbTRMZDVsM05BTmJ3TzNjZ0w4L2VBZllPT2xHTGFtbjEwazdlY1Np?=
 =?utf-8?B?UFB2YlFnWHhsbXNOaHlKQWlBcWkzMW5FOUdiZFgyUXlUMittaVZEMnAyWXEz?=
 =?utf-8?B?a1FOSlFzdmEyWXhrenRmMGQzYmw4Z004TkJSYmtjejEvd2dlczZuYjB2Y200?=
 =?utf-8?B?VVlDV21PUENObGZYWmJ0V2Jpb1hmOWhHMmhURnFlcmM3UEIzcEVPNUVHSDNH?=
 =?utf-8?B?L1FhenF3WlFTeXZCZjg5U2lQeTMyWC9iL3lZeGxmd2FwTERLcUtYN0x4cWVC?=
 =?utf-8?B?UHBzYlZNL3pNUkwzNkpZdE15NC8yc2JIdTNXUVAxN01uY0k0QW5jQlhIbEFu?=
 =?utf-8?B?dWhsWlpDVkQ5SFpYeEFVZnY5ZHRoSE4xWTlKbEF0NVV2WnZhVnNBY2hjV1FK?=
 =?utf-8?B?UE92RmVQR05RYW5pUzVMR1Q5SC90SDBHMWdiUWI5RnNYVHNPUG53RVZTVjB2?=
 =?utf-8?B?bW10YzVxOG4rUlRXZFNFdGJ6YnQ4UjdJRXFlejd1TDZuRitGSFIyeCtOQUR3?=
 =?utf-8?B?WTVCMDlyOVB4bkRNdGgrZFpLV0VOT3hQUUwwamIzVm9kQmVEVzlJWFpEN012?=
 =?utf-8?B?eVg3d2Q0YjFybENFNEV1dHRjK3dGbmJLMWhEZjJVNEZBTnZDSWkyV0lFYTFq?=
 =?utf-8?B?M0N2bVVGVTJUMGtpUnN1enpubHRkUTg3ZU82YldmVWF1a3VoNU1mUnlGelhG?=
 =?utf-8?B?dzlIUHJZUTM5TmFQSGx1SWdwOWRLczZnQmJiQ0Y1LytNZzRIMVNpenRRQ25l?=
 =?utf-8?B?aHg5ZDJVUE8rcWMrNjdpNmtWQUJ1a09GNi8zd1QyMk9Zd3NtNVpBVmllQzd3?=
 =?utf-8?B?R0tzSzFyTEoyelVqQmVhc0s5enFha09CMlFPZlBFZkF5VXpJRFVCTVArV3pX?=
 =?utf-8?B?SXV3OGJDMFc5NDE3ZGtXYnRnQThsNlNvczVoUThsdDJ6SndEUUpEMFIvZFBj?=
 =?utf-8?B?T2Qydjk1S3pBYVpsd2o3MHBET2Vja2xTbXczOWxMZjV5TU44ai8zakpZSVVQ?=
 =?utf-8?B?dWJTSzFCb1IxSWRWcWQvMXNjRWkvcXg0SHRRVHJibUR5Q1gwYmp1c1FrQk5M?=
 =?utf-8?B?azBmQjFCYWpVbmg5dFdCbmRpZUtKQy9la0RwamJlMVZPOXNkQXJWb0ZtK1dN?=
 =?utf-8?B?L1BSclk5WVNJcHJTM01UWFJvUVdDQWQ2ZWxXbzFoVU9aWE9nU2JaZG9paEdt?=
 =?utf-8?B?V0NSc0Q4b29DTE9GZFZNWjJhZkNSQnlKZjdha3c1azFKNnZsdEFxUGJkK081?=
 =?utf-8?B?ZFNSMmpQVnFKM3pNWkg3OVhjWUpnOUE5NXFzb1Z6cmw1WXAwQ0lpbkJpaFRB?=
 =?utf-8?B?eCs2ZjhtTUc3eFJhU3lkOGp0a2xFV3hHMDNtemJIdjgrT3E3TUdUMTd6S0cw?=
 =?utf-8?B?YTZmdjM3a1hkeEZIVWlOZWY1cXpRN2R4TGlJZ0JlekhtNWNWRFNQVkE2amZV?=
 =?utf-8?B?TmdrQ0JjMWJXUHBBKzZCUk9IOWIzNnpuSk4rcXJmbnpTZmMzWmNHbHNaUHRi?=
 =?utf-8?B?ODI2ZkFrUHhMN0FocHYyUVRPVFhGVTZ3QTJ0aEY4ZXh6UldhazN0TG5wZ09v?=
 =?utf-8?B?cUZBRTRXUzNadFFVNG0yZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U1ZvaVRhVWJTYVBxM2I2YlJsNHFQQm1Mbkl4aE1sa0krMTJLTDdQUjFrakgz?=
 =?utf-8?B?enpCL2VZU2F5Y3pkcWRDMFh5NGQzMUlSMkFabnl5bkxhek9KcTJKcENJaWV4?=
 =?utf-8?B?OWx6L3QrTUlnZWpsZzlEMWJRUzFlSWtVZGtWYnA1SERROWFHM0dNSEJxbHZa?=
 =?utf-8?B?N3RpNEtDSVVvaG55WkRBNG1VRTJ2TWpRUWVIelAzMjN4bVhNV1lKelRHSmt6?=
 =?utf-8?B?QUJMajNKNmRBQmRWWnpCaDU2V1RxeEl6WFBUWGRIMzNvcCtQdmxqbjQzYU5T?=
 =?utf-8?B?cC9NMkZjYnpQZmt2Z1p5di94WW5FbFpmSU5wUnJHY0l4V1UyQnJLeEx2d3Mz?=
 =?utf-8?B?OHdWcmR6NHVuK2Jxd0JQMnlucW1BU3RaT3k5TzkwUjVQWmQ1dXBLaHVQQ3RU?=
 =?utf-8?B?Y2JwaDE3Y3dxbE5TMWdRdkdtd095cHVsaTFnM0lRMXpIeHBONSsrOHJnM0dn?=
 =?utf-8?B?ODBYZndSRTF0cXA2cmQ2Z215RjNJUjFuWnZYajIxMnc0RDNWT3lVUVMvcGsv?=
 =?utf-8?B?UGw0TUxwYW5WckRkUXAyZmYwaUxud0dsNlNqeUNjekhKR0gzNzNEOVRUeGg1?=
 =?utf-8?B?bUxWOXlaMTJuaXdsQVZDTDlPeXh4REUrWnlUOU9raEdma2VST0lDSlc1blNZ?=
 =?utf-8?B?ZzlNdktndkxMbERsWi91MUx2Q3NjTUJxZjliMXJSTGxtMDRldTZHRE9tL0pR?=
 =?utf-8?B?b1ZKWVVHU2Juc2dHWEhWTDNMOHpLdU56WE4vYWNOeVVrSXpuL2tBWTFBcURo?=
 =?utf-8?B?cW5WcFlhVW5uWEpqTmlZS0xrdHRpeWw0TEFoN09BVkphcE13MGtraEMrSm9G?=
 =?utf-8?B?SlNYUU9sRjlSa2NoZEt0N2Z5VlRVRW9tNmtoWUVnK2JHbGZIckZIbzRXRzJ3?=
 =?utf-8?B?amkzWi9LRDdpR0RId0hqWS9DTExCQ3hMYlIzbXhGWWdiQ0JoNzVxbkI3dGNy?=
 =?utf-8?B?N3h1bU9nWFRhR3Z4cHN4UkJoZnJ3MDBQTG8rVE5lRGQ1bmlOai9FeWorc0N2?=
 =?utf-8?B?dEdzZmtzNnIxQnI3RFJnU3hFc1dNaHRydnVYWE9pQVJITUdnMVBNbDd4RUtG?=
 =?utf-8?B?cktybmtLdVV3K0cvSUthdTRMZmY4QnUxT0xCK0k0aStxcGVmQSt4ZSswWER4?=
 =?utf-8?B?L1FJVHFtVFNaTTZEbGcySFRUMG13cXFOVHo0NGNlQzhxLzZycUJ3enZoc1gr?=
 =?utf-8?B?aGdWVy82WSswUWVsVDBxdG9ONXN3ZWREbk1YbW1RUjJyTjBiSEU3UFpYSm5I?=
 =?utf-8?B?UEZiWWl5aHpKbExHK1NMV3N0WlM3ZnJYZ1lNOVZYaWRCWlFuY3FOMWUxK0h1?=
 =?utf-8?B?RmVPMVdzb0JBbVp2dlVHbEFJQ2luOFhTYkZjSUc4aXVGL2wyUENSYldrUmFR?=
 =?utf-8?B?OHhqZWZSYUdGdDdkcEI2c010VVJ4YktHRWd1d0pnNnkvZnowdFBaS1NvWldh?=
 =?utf-8?B?aFhCcjFtN05zTEREVmI1YzlJMW51ZE05MGd1MkxyU3JXNW56Yk5icEc1YWxu?=
 =?utf-8?B?VkVscjdtczB0Sm05YXI1RG5qV3RNTWNwR2xmZTBHTlJkT2VFTFoyNEtLQ1gy?=
 =?utf-8?B?UGxOZ1BzVG9GRnRaaUo1Zk5ZWnF3OWNtR1ZkOGFoVXlTL0R1K0U0ODBIUWVz?=
 =?utf-8?B?VFhiUEx6UDhTZFNEOGo2bC9uUDJVZ0h3YklZdi8ycExrai9UQzh6S3pyWk51?=
 =?utf-8?B?aUdGcUx0TmpZVzcveHRsUzJyb01DNU5ORU9iZC9leForYmN0KzhUMUhNRVpm?=
 =?utf-8?B?MXZXV2Q3MzJBZGhVSmZnNlkxRWV0Z2puOEtTcEFHYnN0U0UvNWdwazJ4amZo?=
 =?utf-8?B?aUsrdFFBNGVHSlpnNThoSm82NzFRS0pRcXc1UU51OTFUTjNwV0RIQXR0K3Fm?=
 =?utf-8?B?N3Z2c1I0RzAxcWVVWFNtamo1Q0xpSHo5ZmVnUDVYdTdqN0dPaDNsa0J6MnR3?=
 =?utf-8?B?L2YwcTVpeWFCOXlTVFU4Nk5na3VtQm5SK3o2N2JkZXlEQzJKYzYzU3JmSkxR?=
 =?utf-8?B?NnIwUjZ6RWNxNVJnenl1cjFaMXgrSStqaS9jVHVoWVo4bXhHRy9OSk9oMGF5?=
 =?utf-8?B?QUdmRWRnSEVXbXVjUmx4VW0yNFNqV3k1Y25QY0ZURFVLV0M2Vk5wUk1Mb3BB?=
 =?utf-8?B?NUptZVhJUzhHK0xzbUpJOG80d3piZlRSS2VjeVo2a0pORllRaHovcjZoNDVT?=
 =?utf-8?B?L3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b821dce1-9060-4263-045f-08dd19cca295
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 10:14:44.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngw2PU60006POZAD3VYf07MFdiP0RzDNN6+0xA1i0WUVlFeTPXtTg1qx0XlAxj9vSuBTeCyceFIY807JqWBLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 11 Dec 2024 10:14:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17401

On 11.12.24 10:54, Felix Moessbauer wrote:
> The regex used to implement the path exclusions in erofs needs to be
> "anchored" to only match path prefixes but not arbitrary sections of the
> path. Previously, also paths that contained an excluded part were
> excluded as well. Further, we must single-quote the regex to ensure that
> the '*' is not expanded by bash-globbing.
> 
> I further considered to use --exclude-path, but this is not an option as
> it excludes the excluded directory as well. In case of /var and /boot
> the directories (not the content) needs to be present as mountpoint.
> These semantics differ from the equally named parameter in squashfs.
> 
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  classes/erofs.bbclass | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
> index 189c1ea..72458bb 100644
> --- a/classes/erofs.bbclass
> +++ b/classes/erofs.bbclass
> @@ -23,7 +23,7 @@ python __anonymous() {
>      # Use regex to exclude only content of the directory.
>      # This allows to use the directory as a mount point.
>      for dir in exclude_directories:
> -        args += " --exclude-regex {dir}/.* ".format(dir=dir)
> +        args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
>      d.appendVar('EROFS_CREATION_ARGS', args)
>  }
>  

Applied patch 1 and 2 of this series. After v1.6, also patch 3 will go in.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

