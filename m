Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F7C7619A
	for <webhook@archiver.kernel.org>; Wed,  5 Apr 2023 09:38:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.85])
 by mx.groups.io with SMTP id smtpd.web10.125881.1680687536480996788
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Apr 2023 02:38:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gAUBCAXp;
 spf=pass (domain: siemens.com, ip: 40.107.13.85, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHa2mdBSq1RmOXwSFfdMtO1AWI5jIAKKkwD6bZnSZi1QnhrkHn9cgXNZk6oytguoQGIcw0i/6dXQQxMuPNRL3dwXpcr0lmxvW2EcJYHx84nuqo8zyRwtKijbZkxTk7HAHJ/LxhkdUj1ldemWdT0MuNE5d9AcbTOm5R8dpuwOkImL9py7fOS9Adlt1TTGxWKmH7WUXikokp0r8DHpso0aRBHRMDPME3yrE71uGL8j7HTSzUqsc/rmEW2ODBfV6cNG3x52jE/vjOADubQK52SiY9aOFvsdQYyhves2KJhPInkfjw9NR56ZtezgwpNWXdXXtpfqUtKE4UPkaUFlYBhIaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKEDGhcmGp1o5QqEGD++vvMTIzB4Pps0EaeBmpcJ2cM=;
 b=OiTT5IAoUBC2hVCFq4ZenxCwqUto4OGTey0Zoz6dj2JiHhQmu6hb4j6p7vNBZNSBBQ0x5qYcmPgTpP/2u4gDOaDLHqg7kKYd+1ffcVx6u1cU8PsglZuy++ToeuGOgWRF1/9ykbJA0FbQqkgIUz0XRyoq8bQHjDDCZtt8TbeYX2GpBWSM7U64qKX/x5yGARsClaxIZa/CFuwH7WIg+e+TTLE+g3Tgj/64Ey6R4RsdW428pI7KAiDKVXZeRr8vUwrmnYP2yiHYRCDEJKJWbQCwAw6KSM8KPrfp7y0vXOvwV/rURXiU+NNeueuVpi/9zqz0j5pIH+W9OXUUDN8VDKkKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKEDGhcmGp1o5QqEGD++vvMTIzB4Pps0EaeBmpcJ2cM=;
 b=gAUBCAXpJa75s7VyJBvqWISVN/nSQDBAATMn99ngfXNbNXBOwoDXffoEjmh61oUfggJ9cqJypzVIPFjdVQ/2wsebg3w7OYBXTeli7ODCs+cW3eYi8zSURnaJQvgeNpLvDnsqxqkUtyS50/eMuqZVYfC8+WKYdJPGBQr3zvzkFLjqFehdKZs4N/nfk31SnQY6lzYCd0ud15ThErnQe/7m1tOIutQlWUmWIf0ZVJ0hUevmc1rlx+C2DLo81qkwJ1nz0SoozSU2Kkpm/k4w0dudiqK5Y7mhZxNcxPNlqcnXPdDoeMgMP57son3EknAeHCFZf0yqSyb9xYTVoAPHbfYydg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.26; Wed, 5 Apr
 2023 09:38:53 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6277.012; Wed, 5 Apr 2023
 09:38:52 +0000
Message-ID: <a6a0ea89-ffbc-a2fa-94ac-596e635f9687@siemens.com>
Date: Wed, 5 Apr 2023 11:38:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [isar-cip-core][PATCH] make script report all potential errors
Content-Language: en-US
To: Srinuvasan Arjunan <srinuvasan_a@mentor.com>,
 cip-dev@lists.cip-project.org
References: <20230405074756.600213-1-srinuvasan_a@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230405074756.600213-1-srinuvasan_a@mentor.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::21) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: d6707a6f-563e-4344-6975-08db35b990f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sIp1+RTf1IKPAH+Dfix0E77R9WVD2JInQ1d0e/2PbvgcaokX0oSvMk9a1nwnVZRroSkeZb/Hu803X0X/bsR1NTL+k4xEy9Yo6L57y+f0vPbYnl/WFv8HVsmbF5j7mO0slFZOtA4hDRRt6/eGqp3GqRWwr+g9GgB5V9PPx40tmW01Qodsc6utv1FssJjxkzBx1h5NMO0txHtU4HBm4Y+V/ewfSxVxUu3MG5R1G4xMmQmDte17AgeUfaPvq9FI5lHF0qJvoGzEIv92sZDEapHdVnDAwlQhrIPvbXF+8dzdSMHjObMipvnpoHqkDZEvwSnD3LZMxRPCZ4MGX4ep/4z2SYIYVRg/9rIPNUgwyiPYiKaOEjWJqJQ5ojmlDQNTZRAJTuPhGJMqg94N4e9cx801Vc84K0/yotfXcYM7NReoA+UVtHyJbH/qKYiW2RZMH39Shz4Og4C6Y/74kNor22ZfseNpIVNCX5SeYZzLcIgzy3o9XtaIHruX+pyHHn32cTwlK29Mdna+FK7oz5LUbQOp+uUvjWsmqqvymhdgTDE6I9z/y+FB1rBMhxY/Sr1xxaI+YhIO4YPGkhB4TvkrynUyhxQoFYjZWjXnbTOolzIV6q7IkrcYvXxOeoNpLXoMKpXo555hSfgxPN5MmytMzbZjBA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(186003)(36756003)(6666004)(2616005)(6512007)(53546011)(26005)(6506007)(6486002)(5660300002)(38100700002)(8936002)(316002)(82960400001)(31686004)(44832011)(66946007)(8676002)(66556008)(66476007)(41300700001)(31696002)(478600001)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anhBYmtta2tVamV5R3NDZUkxOWM5aStxYjRUMlVKNXF5dkt2YmpJdmVna3l4?=
 =?utf-8?B?Q3lIamdCSDJMSDRtSm1XcjJzcmE3em5tKzFwak14SGRpY3VzYnBkMmY3QnVC?=
 =?utf-8?B?NEE1RnpVMTM3ZkQ2bVNYS0h6cHB3R3BPWGFrUytKZVpxeW56YXNlM0c5ZTZi?=
 =?utf-8?B?SEdKNkJ1cmxaNTBvU25Sd0k4TlRYQm5CR3oxMi9oaDVkVGViTUt2d01CUnVP?=
 =?utf-8?B?ekpGWWxrNEJpRlhuZ2NjcmVoanE1Z3JoSmY2Si9mQUZzTnZnck80NTlvaU81?=
 =?utf-8?B?alY5aU03OFprU3VKSlpOWENyK2RJSmhrbUE4NHFQUXJUdjlFaHFUdm9ZOHBn?=
 =?utf-8?B?eTJFeWV1NFBPZGtwamIyeTFPVVhhbVF3RHJhbExZWUFIcnJFZVQ1MWNVNDh1?=
 =?utf-8?B?MlpNalFNREVBTWphY2lOTVJ2TDdtdWlUdVA4ZkpjYnZ3WnJqWnZocVRjb2wr?=
 =?utf-8?B?bHdwZkNwT2tNdWgycmFyMlpZMUw0Q0xNOG9XVDRHeVA2V1E1eEdTZ2g5OS9N?=
 =?utf-8?B?cW1vc1laTG0zZWhzOFdZNlMyT1BWTXlrZm0wUThYclhoeCtyZnh5MnAyYjUx?=
 =?utf-8?B?Mm1vY0kzWC9aM203S2p4N1NpWlhUZTMrYzBsQ3ZOaUxnOGlTR2tLcnFsb2hB?=
 =?utf-8?B?OG4xNFZ1OGxnMnZhWE1iSWZEM0RycDZxZURjaHVoZ3dlYnU5Z1d3ZFVwYTMv?=
 =?utf-8?B?R1lmc0FHK3R2Wi9FbVA5cHE2L0xLVnpvbGZlbmErS1FxNzhhQVFQclVkZ3Np?=
 =?utf-8?B?WGtCMlJWL1MxYUJ4TnYzSFVGSTNNRlZHVks5TVRsaXdJMlc3YTJKeHB4aDMw?=
 =?utf-8?B?TkpJZ1FEYXVrYjhwVVBvS3phWnJTcUV4VmthdWI2d1JuKzVsUzZhaXhHNXhh?=
 =?utf-8?B?dVNQdXgwRE51c3F6K0FnMXd3aVgwZGdSWFpFTUIySkpOMDZVang2U29kc3BB?=
 =?utf-8?B?dVcyanJFSm02SnlqWkJGbGZucW1YZExzV0xObFhYeWI5Q0VUQkluRFpCT3Rm?=
 =?utf-8?B?QUZMeWdFOGZwWHQ0YkxsaHFHM0trdHkvZHZFcEJ3NGI0K2twd3pYTXNoUkNM?=
 =?utf-8?B?NzFSblgzRlZVQjlpTnJVUkNvRlhaWkxmZ212d00yZE5qNnU5b3FRMEQzS2ht?=
 =?utf-8?B?YjNZaWpGU3VucnBhRHBBV0EzY1dPMTdWM1k1ZlF3bXRPOEtiRGRDTm1UTVox?=
 =?utf-8?B?WmIxd3VIMTRmQ2FaNGU2WnRua2Qrblh4aG01Wk51K3dRY214YWlVZ0xIWmZr?=
 =?utf-8?B?aGt4Ni9LeTkvdDJ5aHl6Y3BJWVBuS0k5Wjhaa0g5UFJqeGhGNm96WGxrRVlC?=
 =?utf-8?B?YlpkTXgzVVAzK1N5a0tlc0FTeXNYcFVpaTRWdmU0RWlaNXhINzJhdEZnYnRz?=
 =?utf-8?B?RWpWRklMYjBKbDB1V0FSVEZHalFRbEdQV3Bwd1lXem85NmdDMTd0VG1TQ3Vj?=
 =?utf-8?B?MWdUMDBZRlNaNCtPRkptWHV1U1ZXZy90b0F1RHBpdlVmYWU1UmtNTDFwU09u?=
 =?utf-8?B?WVB3UFYxdGp4SzJsMk54bHRvSHVqUVk0cUZ6UVlaNlpwQzN5aG93VVBZNXZv?=
 =?utf-8?B?VW9sSHpxQVNqeEFVN01JYnd3bWYySEJjNGhaSDZxdkVGNHRMMlJPRTErWklH?=
 =?utf-8?B?MlM1Z2txWGNEYlBYbVBkdURpTEhWZ3hJSEE0Zi94RWdJeUZUSHM4NDE1Rm4r?=
 =?utf-8?B?QnpPOURnbkNiVXQ0bGFweHUzM3JCL2RHeHUvQ0lPdGp3ZVBTNmpMSzQ4WnEy?=
 =?utf-8?B?WmVLMHBYb1VoTmFmcFlXZVVVcVRXTkhRbnd3VFZPWG1Jb3MxREVOSWk4WHd6?=
 =?utf-8?B?L0ZSUFE4cmMwQ1pGMjZDaVdZNnVTWjE3aUxDWFhKa2lOYWg4K0tNdWFJcFdj?=
 =?utf-8?B?QldaZWQxWURXWGxQaEVOS3M4VktGSUpiQXZMaGw5eFk4VjRCTkxnNDQ2Y1Uw?=
 =?utf-8?B?cGZDeHpVSWJreXEvR3dRMlpENHNvbGVNSUJ4TDNUSjF0VlNQb1RSQ0x2YWR0?=
 =?utf-8?B?Qk9kOVg1a2ZPVzVPVXJVVE9nYnhQQmM0ei81eGNYeU9ieGFkRE5sYnNSdkhH?=
 =?utf-8?B?eXl0dE9hbytKM3A1ZDhRWmFYK0FBWnpzRGxhc2VjbG5WeWhNWTdJdXVKdmVs?=
 =?utf-8?B?MjB2Y3JQRHZrczJDTGsyckxqUGs2NnFReE9teUl0TE82ZnFsdm4ycWlWcEVs?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6707a6f-563e-4344-6975-08db35b990f8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 09:38:52.1471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12X1Y/QjcbLttNMB8jJx3H1zFbZrCVnUUgVb8qDIwAmqaY84jG8NrCDcKQWLx0VjJRNpF6R0jfIH6WAnvQgAcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 05 Apr 2023 09:38:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11177

On 05.04.23 09:47, Srinuvasan Arjunan wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
> 
> Let us try and make sure that all bits we have are executed as expected.
> 
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  scripts/generate-sb-db-from-existing-certificate.sh | 3 +++
>  scripts/generate_secure_boot_keys.sh                | 3 +++
>  scripts/start-efishell.sh                           | 3 +++
>  3 files changed, 9 insertions(+)
> 
> diff --git a/scripts/generate-sb-db-from-existing-certificate.sh b/scripts/generate-sb-db-from-existing-certificate.sh
> index 035f189..ddaf4c9 100755
> --- a/scripts/generate-sb-db-from-existing-certificate.sh
> +++ b/scripts/generate-sb-db-from-existing-certificate.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +
> +set -e
> +
>  name=${SB_NAME:-snakeoil}
>  keydir=${SB_KEYDIR:-./keys}
>  if [ ! -d  ${keydir} ]; then
> diff --git a/scripts/generate_secure_boot_keys.sh b/scripts/generate_secure_boot_keys.sh
> index 8d3f8c0..4988a68 100755
> --- a/scripts/generate_secure_boot_keys.sh
> +++ b/scripts/generate_secure_boot_keys.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +
> +set -e
> +
>  name=${SB_NAME:-demo}
>  keydir=${SB_KEYDIR:-./keys}
>  if [ ! -d  ${keydir} ]; then
> diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
> index 980b9cc..cc8dc58 100755
> --- a/scripts/start-efishell.sh
> +++ b/scripts/start-efishell.sh
> @@ -1,4 +1,7 @@
>  #!/bin/sh
> +
> +set -e
> +
>  ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE_4M.secboot.fd}
>  ovmf_vars=${OVMF_VARS:-./OVMF_VARS_4M.fd}
>  DISK=$1

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


