Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD005C02185
	for <webhook@archiver.kernel.org>; Fri, 17 Jan 2025 09:25:37 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.43])
 by mx.groups.io with SMTP id smtpd.web10.7220.1737105927197904406
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jan 2025 01:25:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Y7fso5pQ;
 spf=pass (domain: siemens.com, ip: 52.101.69.43, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY1b6MfV7/cZXI1vzk3DxSdF60uCZu7S/lno/pgsTEvWdApwVZkNTHuSJPliQzLU6R4Y9qn2yA/GNt7s5TfEvtg5zlKKZaklPir/Cg+U/WDpYqBU6RSloswrdOpeqH8AZBj/e9vLbAKFwMxm9aHxFS3akjetYNeFXw9FwbERk5XGfX9vI+x4MP62M+2d4ocR0gBSmrHVLQMBdOb6sOY7xNznmf2Grf0Kl7HKBLPDFkVh3bF3QDx8Pl+8LYnOy+FZiAueiz7iekz73szzEsJOUMkF1sHTRn0zkyXCM/8vPaXlZlQ/3ETxyEX3MC2b0lhkEiSYM4iBtsrfwALFqXh8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/lscwcrVX+2fhBO+M3sjjH5VRn27tJbog+uIugMEbw=;
 b=R7fEU94U8AFFZqe0gmqoSvlU+aBXRzH1ofC7kMgMHQ7AQrKPMUMCTKCspB5EtytsE1fGnWeJkzj93rW6HbN0vZQan0I5wxtsJOxgPPS+oeRx78UppwWv3xx0At/PM6cyS/5L+y35kXPkFmjQdCeRxNqYgt4y3tGqAFXNQZRIlB168Zz8o/e1omVAqlfBhNmfMwVzb/Kjs97i2pPiHjvAL9U6d0orFumxZhJHTmWh/jn66d8FUZsUBArAjXsQfDEMOQPkR1coBYCuFIQai+lu1I/tOkZmldxUj+dOvwbcjG3bxfIn8XiMh8OWTf0y8OXHFib8qZEFRK/dD2BH8oCVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y/lscwcrVX+2fhBO+M3sjjH5VRn27tJbog+uIugMEbw=;
 b=Y7fso5pQ4XxMA+N9m+xDgpW+fSpNJkI3YnDe3CJIfqzqJWGT2PZIGtcpVUMbWudFuY5zPEjwswDSdmJNfOjncXtjdEaweE7GthUlm7auW7r2ErPHTLouXa7y1qX4AlKcTFUkORE9YCCwmmkYJ8yhvLC2PI3eAg7xlnga1IJs9+hAvtWT3UD93LnakKqc3Qx+xKzKnZtRYyszKaEhSdLyyJE798TNKEkmWqgscg23TYhAuHKVhd/Phv0IgGWwFbMj6fniFpuwokVCqyAIYaPAjZV5tvFIOW42JR3hsPnI5XrHSxmPA9FQAHFQ+xx9Yy+NAMd5zXN4RhxBQuc4zY2T1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB8096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 09:25:11 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8377.004; Fri, 17 Jan 2025
 09:25:11 +0000
Message-ID: <2cdda104-b4da-40ee-bc5a-f837967807e6@siemens.com>
Date: Fri, 17 Jan 2025 10:25:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC][PATCH] Add security policy
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>,
 Kazuhiro Hayashi <kazuhiro3.hayashi@toshiba.co.jp>
Cc: Christian Storm <christian.storm@siemens.com>,
 "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 KOBAYASHI Yoshitake <yoshitake.kobayashi@toshiba.co.jp>
References: <1086822b-1cd7-4424-a1d3-5ae0ce8371ad@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1086822b-1cd7-4424-a1d3-5ae0ce8371ad@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR04CA0093.eurprd04.prod.outlook.com
 (2603:10a6:208:be::34) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d46371b-3c1f-4615-96c2-08dd36d8d776
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?blp6dVpMTEJVNk80R3o5emNTNVdyaHhZQ1ZoR2ttS2FKSWgweEZNYnY5ZWs0?=
 =?utf-8?B?bGpwdldrQk90M2ZlMHVCTHY4Uy9hekUrZVpKQ1laellHcTgrTW00Mlp1VHpE?=
 =?utf-8?B?TGp0NFRVbEpicmJkTk5jblA0TVlkMWU5MThhTzF4S3J0TEdiTy84aWpTQThC?=
 =?utf-8?B?Y1FqSXBkSFZGUkhYSWt3WFdaL1B0WUduK1ZvSVV0S2JnTk4zNUNWNHd0ZGpa?=
 =?utf-8?B?bmF6amM0Y3pVV0NWcFZ3a1lENm9yYlBrU0VmSk9STFJ2SUhaTGZVaGJUbCt6?=
 =?utf-8?B?NHgyWmphTjNYNk1JVXVPamt1M0wrMjBIOW95YURLV0Y0NDBCYm10RjVuV0Qw?=
 =?utf-8?B?TTdJZUZLTmZlWG04TTI4SUpHdVo4V0s2KzJ6dzBOMEdQc3VzZVNKdTAyM0Iw?=
 =?utf-8?B?R0pyWFRzZUd5UzMyZUZkNHkxZnpUcng1Q2M5UXBGVXZvd21tckVRMzZ6NDhv?=
 =?utf-8?B?OXRLWXB1WXQ4ZzVJK0o5a3dpaENoRmpLdVlIdW9pblFhUU91OWt2MkxUNEov?=
 =?utf-8?B?V0dQZWRSZkgwOVB2dDlNODJJYUJ6cDZSekt0YmMwQ1lwUVFwc2tMNGpRc1c4?=
 =?utf-8?B?MElqT2wxN1JWWW5Icnh6OFlDZnFSVkpkVnlSbTcvS3YreFg3anVDdmxWbkNh?=
 =?utf-8?B?TXVOTlNQcmIxV0N4TmJlM01EelR1TDJXRnFHS0ZtMzkza0FkNWJ1TEN4YTlZ?=
 =?utf-8?B?VDBSQVk0b1psTG5Pd1RDYU9BSVdrcmxYVnlrUnlYYmIyU1MySlUyNWhUQVN2?=
 =?utf-8?B?c2h5NHJhMk0yNi9aRFplbkIrTVNXSStaU3c3dm5yeEdYUUpwb0VGOW9ObVd3?=
 =?utf-8?B?ZWNKZzJyUExMTVZNcVd1U2tJejZNNkwySUVyTDJqMGhzcTJsWHc4N25XYlZs?=
 =?utf-8?B?clJ0ejRtcnEvcGtBM1dxRW5aL2JNazl1Qk9CTG9ibkpLUmRrTWhzQVEyRDMy?=
 =?utf-8?B?TGtqL0s1aTNKRmRKVWxlNUFNMGZFc2dWVU5HNytqdktJdmZveU1KeCtaSk5W?=
 =?utf-8?B?b2VGK3gyTFFGTkpOb0hITFdJNDdzMXBEWksrbVZDd2REUkZOWmVZVnNHS1RY?=
 =?utf-8?B?M25ZOFRLVXMxUGRYOC9lRlR6blVVZ0dyTi9NSDYwNnZHYXhkSTE4ZHY2SkZF?=
 =?utf-8?B?K1QwUys2VnFwUXQvN1Y3dTc3QTBFZGlwc21sWXljblRmS0FQY0FKWXI0cEpV?=
 =?utf-8?B?MStCdGxpcUcvTTJqb1ErS0EvcEh0YW1BdzVUaEZnR3c3VVIvZjhrL3pzWXFQ?=
 =?utf-8?B?UXg2S1hrdGhldjJkMFN2dXFHd0xHMUxkWSszbEl5cW01ajdKVDVaalVra0U2?=
 =?utf-8?B?N2dPOVMrM0lEYk5iZ1ZoUFBSVG9zQVpIREtsNWgzSXQwZkU2OUdnYkpXRUlu?=
 =?utf-8?B?NjlQeGNBTzhUU2ZkYjZDR1htcHRJL1FnMGVjN1RDYTdkaEcrckV6cWZ5WkVB?=
 =?utf-8?B?N3U5OTRVQlNIYzZ2K2tGbllUY0JmMnRhZE9yY3pFalptQkcxZ3NQeUR3L3RW?=
 =?utf-8?B?QXozVG10VGpIa3RWYnJtazd6UmtCR0dwOG9vUzVPU1VmZGJ4Z2tiQzl1RTJC?=
 =?utf-8?B?bjk4R1N3bXIrQVNIKzZZYUxOMDZBb3kvUW1CZGE2QVBKbnU1TGNZc1JFVStI?=
 =?utf-8?B?WmI5cklmU3d2UHpsNEwrQWN0SGliZzZNVEVxZFFHcXRkRm5VazIrSkdrZXJH?=
 =?utf-8?B?eVdzcFY1QTlUeVA0aGpNTGZZT3ZGNnNEaHh4UmNnQ2czOFBuU3lPY2pjdHhY?=
 =?utf-8?B?SUR3R2VTV2RtYURXa1FpRVREQzNGY3BkUW1zU2hRN3YvSGl1bEJDVGlyUEg3?=
 =?utf-8?B?QkdIeWtoL0lvV3ZDWDh2UT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SzA4OSs3MnUyTDI1bEFhdTNFaEVsS3RGOGRvSmVPNnVkbFMvL3MrcVhNcTY1?=
 =?utf-8?B?QmEwT2FIQ2plOEdkb084SFYwZlVCN0VkaGgxWlRuK3U5Sk4wZ1VyM2swTXdj?=
 =?utf-8?B?cHc1YzhSa2MxQWg3eWZXNmRlZW5ubDd4QlNRVkhtLzREenBob0l3Z1ZlZyto?=
 =?utf-8?B?K3RvWE04NVlnWHVoS3UrSHhFWVEzWUZrNzV4Q29mMVdZdHBkNFNsK3lWaVRS?=
 =?utf-8?B?QnI4NVBNWXZ2QVBvL01FRk5DdUk4OEdoS0x2MGNaQUpKdHRmTCs1b0RSdGs1?=
 =?utf-8?B?Z2F4cUtjRFNXTHFOd29LSU1ya2RiMDBMR2t2THlSQ1RraTI5NDdzUUF2NmQ2?=
 =?utf-8?B?ajZra3d0bmhpZGV5N1d3cll2RHpxV2Q4RkpBN2ZBK2p0K3hINzI1ci9QaUQv?=
 =?utf-8?B?VVVNQjI1UzBpSk5iTVl4eVlZUTREY1ZBZDZFdEduSHBYNkZVYVNVNUZkZk5T?=
 =?utf-8?B?bkxVKzBvQU5aR2kyQmtBTWw1RG45MW9MQ0hneWhXZitsVXJtU2tuN25EQkM3?=
 =?utf-8?B?RXpKYXNpSmd5RkpGWlM5NUtURTdYcEFLN2Q0bzBOYVp6SGY5bW9ZUFFoV05h?=
 =?utf-8?B?c2VlaXkxWitWMlpwQTY4MDhndHV3ZEhKWlVwZENnUUlEL0pENFY2VTlHTTFV?=
 =?utf-8?B?L2hFRFJlU0F5VGpNL2UrUWVlTnJOWExGZW1nUjJEbUhEQXZ6QlZyZFRTeE1Z?=
 =?utf-8?B?NWFrQUJ3ZVFVcTRqVGR1NG93U2QzcW5QdVdBVzlCazBwVjdOQ1dkd1RLcEU3?=
 =?utf-8?B?VHpWRm9ySGtybEswZlcwOE9GYUJ4MGszUFlReVhqWmxaZUdRZWNEM3dJOGFa?=
 =?utf-8?B?R3l2MlFMZy9qdmxsd04zMlRVTTFyTDR5djM1S3ZHZ3ExODh0MVI1RVZEVFdn?=
 =?utf-8?B?YjlzY1g4dmFqU3V6R2xPTTJGS01rNHBWQWIrc1U3WXlUbElBR1pwRGJ0d3FI?=
 =?utf-8?B?ZTR4eTUwWU5RTnozVGwrRnZsQUNiREk2MTdWOXRvc1NpZXg1VE85b05MdHRU?=
 =?utf-8?B?ZlU3ZFV2OVZYc2FCUERVQThYOGRPL04wZFJIaVJlSlljNTlUL282b3lGUjhR?=
 =?utf-8?B?L1lTNkZkbHNVanFHV0Rjc2lGRmY2Z3FuTEhQREx3bTZmZXhqYlZ1SFZFZzhs?=
 =?utf-8?B?dEZ3bUk3VjEyKy9DQjBxRHgxQmNrd2hyVXkwLzNXRlpuRTdVdFIzLzQwbDY0?=
 =?utf-8?B?NXY1dUxBcVB6ZElZV2JxYzdKbU1MdTNRSGdkc20vKzF3cVNibGg5eW1YRnVX?=
 =?utf-8?B?ZjBoUHBobzRqUk80WXFQcUdmdU9naGNZZ1kwUlMzanJKV2pnVUNyM1RnU1Aw?=
 =?utf-8?B?NWZkUnl3OU5Vd01oRXAyb042cTZ4M2lBQnEyQWl6TnMyVG1VT0hyenR5RFd6?=
 =?utf-8?B?NHhUdDlRQWV6SFRCbzdWYU9zNHU3OERDdFAvNnM0OXk0eVovZ2FXdmc3U2NL?=
 =?utf-8?B?Q0RycVZsdDlaK1lxT0NMcmF6Y1UxT2drK1c2V0xCc05FTFJLRnBnUkZ6OUJx?=
 =?utf-8?B?eTE3eHpPdFNqbUx1dE4yTGlSbFRLY2xVbFkwWTdBMDNDOHR2RkZaWEFRcklS?=
 =?utf-8?B?dTBXVjZVL2tZQlZoV2QvcFBndHZ1L2V5M3RaMVVHSlhpQyt0YlB4alNUVDNI?=
 =?utf-8?B?dWUwNU41MzRENUJUckZmSGp5MXpEVUwzMENka1VLcGNUaHJoZUxvOVRHYXoy?=
 =?utf-8?B?TE43RDYvSWxCNVVJRm8zNWNoTU1aVTJXcFZxNHloQWt6d3hYSU5uTHFFOVJE?=
 =?utf-8?B?Y0RmQXl4RGtqeEZKYmhqdG82SlFJRUNSSnNNNUplNUE3WmNYazVReWMzOVE4?=
 =?utf-8?B?a0Z5bGRwakJMVnExZ3U5aEs3ZWprRExxUHhuRlY2TDhidHN2aFRkM1dsS0Yz?=
 =?utf-8?B?WjUvSGtyQkVZZFprOWdrWEQ5TlpTK1UvMHUwYllRckNEblViN2QvajBFeE1D?=
 =?utf-8?B?YzVuZldsTk1tSFdCTGlZQU8rT1VwRFhwYWhPekJYRWRFRjZTaFd2Yi9HYkVP?=
 =?utf-8?B?S1hrR204R3A3OHp0SUlPeFRzUkJWeXJKK2ZWZTJvS0hQV0hFM21CaThqMUxn?=
 =?utf-8?B?UGV0MWtzblpVM0o3TktvUWlVdE5zSEdjYkNNT2kxUVAzakQybDVreEpaM09I?=
 =?utf-8?Q?ZKr6T6S0bU7Xfzd0v29+HIPm4?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d46371b-3c1f-4615-96c2-08dd36d8d776
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 09:25:11.3349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ZW5VQrWGSrSpQVRSi93uin0XRk5YVCaN45zF44Q8I3UuG5leZCNLXDiwMUV3X5kX2Kz6TAn67Yt4rLZ6TtGXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8096
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jan 2025 09:25:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17545

On 15.01.25 19:21, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Try to define isar-cip-core's security context and what is considered in
> scope. Furthermore define the reporting process options and our handling
> of reports.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Kazu, are you fine with being a second direct contact? At least as long 
> as we do not know your successor as WG chair.
> 
> There is one TODO left: reference to a reporting procedure for our CIP 
> kernel. The kernel WG will discuss this soon.
> 

We discussed that yesterday in the IRC meeting, and a possibly common
solution for all CIP subprojects could be to create a private
security@lists.cip-project.org list, provided we can configure it to
permit postings from non-members. To be discussed in the next TCP
meeting, I would say.

Jan

> @all: Please provide feedback if this is accurate and sufficient. I 
> won't merge this soon, at least not before the next CIP Core WG and TSC 
> meetings.
> 
>  SECURITY.md | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 SECURITY.md
> 
> diff --git a/SECURITY.md b/SECURITY.md
> new file mode 100644
> index 00000000..60619a7d
> --- /dev/null
> +++ b/SECURITY.md
> @@ -0,0 +1,47 @@
> +# Security Policy
> +
> +The Civil Infrastructure Project takes the security of its code seriously. If
> +you think you have found a security vulnerability, please read the next
> +sections and follow the instructions to report your finding.
> +
> +## Security Context
> +
> +Open source software can be used in various contexts that may go far beyond
> +what it was originally designed and also secured for. Therefore, we describe
> +here how the CIP Core integration layer is currently expected to be used in
> +security-sensitive scenarios and what aspects are covered elsewhere.
> +
> +The isar-cip-core layer provides several recipes and configurations to build
> +Debian packages, and to install and configure them to create bootable images.
> +Not all configurations have security in scope, and downstream integrations may
> +further modify the security properties of isar-cip-core deliverables. The CIP
> +project considers security bugs in scope for addressing via isar-cip-core:
> +
> + - issues in on-device logic generated by recipes or scripts
> +   (e.g. initramfs hooks)
> + - issues imported via hard-coded versions of external dependencies
> +   (e.g. SWUpdate)
> + - incomplete, incorrect or misleading integration guidelines for
> +   security-sensitive recipes and configurations
> +
> +Not in scope are:
> +
> + - issues of upstream Debian packages (please report to Debian directly)
> + - issues of CIP kernels (handled via the CIP kernel process, TODO:reference!)
> +
> +However as there remain grey areas, do not hesitate to open a report for
> +isar-cip-core if you are unsure whether a finding is or is not in scope for
> +this project. CIP maintainers will help clarifying the situation then.
> +
> +## Reporting a Vulnerability
> +
> +Please DO NOT report any potential security vulnerability via a public channel
> +(mailing list, gitlab issue etc.). Instead, create a **confidential** issue via
> +https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/new?issue[confidential]=true
> +or contact jan.kiszka@siemens.com and kazuhiro3.hayashi@toshiba.co.jp via email
> +directly. Please provide a detailed description of the issue, the steps to
> +reproduce it, the affected versions and, if already available, a proposal for a
> +fix. You should receive a response within 5 working days. If the issue is
> +confirmed as a vulnerability by us, we will request a CVE for it, publish a
> +security advisory via the project's channels and give credits for your report
> +if desired. This project follows a 90 day disclosure timeline.

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

