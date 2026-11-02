Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.65])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9585.1793615635991658864
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 02:33:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mPoaBZcf;
 spf=pass (domain: siemens.com, ip: 40.107.130.65, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZCcsaMdJusUJpux4h9EyIC7tb0DmDbxWV83G5Sd7Vrd8eDFmydJ2qlQUdTqOJn3mfuf/BOXgvnYu0QGVI38q8wSwylmCIjfP9zWVLE9hvEGe+XTtt7XMiV+1oJudT+jj64CG/Htxuae9tvZHWdV4iBiYxCdLEa5nj4vki9JHpZ6g2qZKHsQ47TOzKOoucJV6BfAQMjFIFVSBgJ4OjNU2J4mKfXh82HQLWUH0hUV6vgEFjaRP4HKAPCTLJcchsIDSbi9eTHUT4+2j2FluY0lD9EZjK9rXREpiom7a3s7C+EBc9xPtkb/ii8i4tCg8pMumi0GPbjUdgm0qXGhTyqEIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxNfp7nIGW+2cFMfepeaeAdEs8mnZGrNK8An193Nnno=;
 b=tlTaEdYVazS3nErjJdhLgrwiS79OFszRpBAocy/hASraYG//Db5Twsw4G3mjayl3KzJOHCy37kyu9CdjbLinR/7p+KRaoqQkyQnM+RKPKsWub1FTH4THfzjhzdW2x3wWosv/mqSIx8EGF0tgyuui5SVROY45+UFSsIavfcmdR/VssYzYA2Qre+Zmb8m8fkQzpaj/WPPxW8wq8A9BM0op1I8nrNbnM8qM+j9hjIsGMc11yJBZ95IvyLIr+LWFH7XCgl2XXWh+XBlHhIgaip0y+IWJXSxQnPCGdBzxROoVd3PpVzyIejGpLJvTH8iQ5fRdlOF6mDpXiMigpZB4bDOlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxNfp7nIGW+2cFMfepeaeAdEs8mnZGrNK8An193Nnno=;
 b=mPoaBZcfLRPET0DglIz1MStvSLRKt84D+x7TIuOaqCXrHi1QTM/5/jsN47FGPDvA3KkQxnG5H6nGYVjUR5K10m0Qi4fA4B4ttdP6pBMAOG8t/s2qNR4YJnjRmx2gKljSGOOJAd/2zSNbUOS9iwLck+UwMtdpBNV2W2dQmprZF5QBp/u9cS61tUT/fm4JUbcEXnajQGGj4UKWtuYmfwa/lODUAXE1sidRtCd78hw4ALby3n/m5sCTuU0NZ7cNznZz9ZMvQ4W0M7awkKRYJfhQHRN6vtX9Aa7ZnWekYdTzefO5E1dK4Rwtrn2F6e3vCjyHL3LhyNomTPo4Cp+0zhWpPw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AS1PR10MB5192.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4a6::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 10:33:49 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 10:33:49 +0000
Message-ID: <809963cd-5bb2-4955-8585-28deab6f9cec@siemens.com>
Date: Mon, 2 Nov 2026 11:33:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-cip: Update to 6.12.114-cip34
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20261102103219.387901-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20261102103219.387901-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0274.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AS1PR10MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bf92e1-6a89-40ef-af1c-08df38ccc86f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|10067099003|55112099003|22082099003|18002099003|56012099006|11063799006|261021121427099003|261021123027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 0XQF7HLYsQCKvwJoat1++ISxTCfvUHeaPxn2A8HLpzuAg/iv5jZfE/s1LlKt/V358mj09Ddz0EG4g2zGLc9SeDSTTAYx3I+wmh4ZsOfu5aZSfVagjn2blSb+GxIZyzAv3lq+7/Uq4cOmH+5KBU36Uekrh2RkDKW3gf2qwf4p0aq9YZsssLbWQP9oYD0ekr5LVg4ZZCFX5+AXIuLR7zGTnCWCvaRH7PKczVGZzvHBMohs0MD1Grc7zEtSN8eUFhUJ1yzYQyNQX9DHpZ9qnN++LqT9FdAI3ohXkfdFbFvLOB2xi/It+NG8S32eYTf7jG1iNfKXkXmlpqJ3pPhLcxLG6GMokkM93yTNuXhcdDqpKHADReyo4Rgz7AHMp1lKOaMVW9X7Z5iHnLwk88N/IaJ8IxOXFIpjpRhXJAMmpa1vdb4Yy2m0w07K5j1MEODHVyPo/6AVAsunT1DRVQZD0PLedh2dwJNdxm9ALK9KlAudSeIZ1YLOzNNXw5EjzsHnZiOVbivQhRutnd8H6q81L4mGuEAvsgL0poBXo5QO3D0HCuoHUDL87t1yMTTth4JJKbEgRI6fAbwTBNjWBejljr3HEfYJptU1DqBXVb8vAE9Cu7K7M5Jbouwi9lklw97SnaiSEfTx1DXzqLKW1qHClGaPPDecsA5NfGZd/+Gf7m2QlDw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(10067099003)(55112099003)(22082099003)(18002099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFuZ2t5bHhld3lpRXE0NWU0cWQ5bEdYQ0liajRaRHRQVHVjR2REMDJpQTYv?=
 =?utf-8?B?NmpvTjMvZnJPTW0vNVV5bFB4Rnp0bjkvM1o4aFBmSXlhemNFZ0RsR1JiZjhr?=
 =?utf-8?B?a1FheXhwY244WGdiRnBpdXUxV0dhVDRFNzIwWkdzKzk0M0Q4TjNHZlZFSjY2?=
 =?utf-8?B?ZWJsWGZZUWp5V0pSS3lpdFMzWS9wejgvZlR2VlJYNWhLcHVLdGpsRFV1emJx?=
 =?utf-8?B?V0RucTl1c01WZmpEWVNHdmdUNHZ2TG9aSXRRWUJacnoyTi94K3ZiNlpzRysv?=
 =?utf-8?B?ZUtmaEtPZ2JISXZBall2SzhhNEFmNDlOUVZnak1DdUxrRElISTJYR3pQb2Fk?=
 =?utf-8?B?VXJqMnRXa05mVGQ0ZXFvQm9QaWVab2dZRC9HMW9jRjZqc3lNTkJTNEF3b2pI?=
 =?utf-8?B?SDZPQUw5amlLTmxCSE1lM29QdnZvMGtQQzNuVmhIOWpBU2pnSEN6RnJXVWlR?=
 =?utf-8?B?QkI0V1hRYlYvcTlpVnRHQzZBZGZ6bDY0LytBYUFaZVFURUp6Q2RBd0E3Zyts?=
 =?utf-8?B?WDlZVFRqWnNlcFNNczdMY0t5L0NKN3YzbHBEbXA5T3NFeUlCWUV5VkxVU2c4?=
 =?utf-8?B?dHJQbWM1TDJ6WWR6Q1k4Q1Z1SWxhc0tFa3YwMDAwZVZxdGloUitsQjB2bEx6?=
 =?utf-8?B?SG45TnJIcVBQcE51MnNBMVJuWnRBSGhhUEQzQWx1eGdZd095MVBlVEZrOHFN?=
 =?utf-8?B?UVZBem9zK0ZhZVIyVjd2S1FWRThCdDlERTNwUk9qT1llTmwvRmtlRWNrdlhX?=
 =?utf-8?B?WXVOd0ZnS0NKYlo2OC9FZVVxK1QxNVh0bnM1QzNoaFhpOGtiVHlOMmQ2anZU?=
 =?utf-8?B?VlJMVUlXcXp1SVBhL2kzeUVDRTRmdThGUXNXS2NTRmwveWhldklrMjFCUmtv?=
 =?utf-8?B?bW94TWhaSjJEcWZyWjFoMWJ5bG1nN0p3aEpuSVRob1d1OUN6UnlwN0JEUmJw?=
 =?utf-8?B?dXdnTytPdWJBWVpza2Q1emlIL3VhbGxmUnRNV1FqMmwwd0owSjV5ZVBRVm9P?=
 =?utf-8?B?QW5PT0xlZUNiS3BYYWJCRWNhUnNMUG1aRm1LVm5wajl5b3F2c0gzb09UdTU3?=
 =?utf-8?B?bzVZVzJLUXlNaHR6dmxmVTQ3YitMdkxzYlZ3SVhhUzFpbERnRlJnSVRCcUxl?=
 =?utf-8?B?d3l2NVBkdWhVK29BRi93bHAvQ1NsYWhqc3gyT3NhRVFOSER5S0VUd1QwZ3N2?=
 =?utf-8?B?TTJXK2RMUmRBMkRzYUdzc0ZJZnlCOE5nK1ltNWZpaEZHZWtrUzBqaFNRYmty?=
 =?utf-8?B?MjAyUkpnNFJTNmdIMkVsR3BXZFdhWmJKZmJoOWMzQlZ4VC8xY2VKOVdQQ1Fz?=
 =?utf-8?B?dHQzYkgvRGdoZzRIQ0l6VlFkV0JBMlF6VzFOV0FtUlgvSjQrVzJ6U052YURl?=
 =?utf-8?B?STZkR3RnZi8vOFhJVW0ycW43dzh0SFdhR25VSHNKcXB1MEJvYWdSaVdqYU1j?=
 =?utf-8?B?UWJDYm1EcUhlVitqa2RrRFpBT3NhRTVoUmorcjFYcUsyeFZ0R3VJNEw5Sllm?=
 =?utf-8?B?R243bXpWRlVTTndnNzRkVGtNaTlqZ2FrWmt1aUkvdHJ6SGtFdm5LbmVpQ1lL?=
 =?utf-8?B?aEtqVmFhcDdDeWltSU1nU3Jsc0N6dG02Z3NONndwT0E1Y1JBT3RiRkRiYklp?=
 =?utf-8?B?TkkxYkJrUGtIRmQ5QmVOMVJsMDJQSmdFMGtqd052elN5dHJkQldoVCtsMFQr?=
 =?utf-8?B?Tms5MW1abEtrNXVDSVMwM3Q2SFA3TWtRd0c1VEZ6VUNteGRKR1RNN3pKVG14?=
 =?utf-8?B?OFNmNDhlZXlGcFpjamg0eDRGN21kTXd1LzJkZW42S1lkNHFxWjZQRDRsR2x6?=
 =?utf-8?B?S3I0ZGtsU1paeW9rbEFtd1RhdnNubHZWSm9oNjVxdDFzNzNydTh5d0RqbUF5?=
 =?utf-8?B?dVVWS3RTR0g5d1B4MXFPeDVSWEVua2V1OXFxNHB4Z1Y5RGpteUJKbm5qdWtY?=
 =?utf-8?B?T1YrTytmVkFTeDUrOThxdDY4MEo2Z3V6RVZPMXJsVzVFQUZ4OFduYXkyVjhp?=
 =?utf-8?B?LzJvNkluaks0QzdPd1dGWWovMFgrSjRQYkxoL3JZZDdZVjhpR0V2Smwwd2pp?=
 =?utf-8?B?aDNxNVE4SVNWak9Oa25lU2ZBTitabW9Ua1FCajNKa2JUaWpvekhSNmhQV25m?=
 =?utf-8?B?V0ZtMllWNHB2WkxoMEpqbzZiSWo4VDljNHArMzhJN0lxOGZnQXp4ZEZXdkY4?=
 =?utf-8?B?NXFjaXRHTFV1dXpSUE9CZ1FneUk3dndvbWZCYzhCRDBtVFQzS0ErSngxa2dD?=
 =?utf-8?B?cWx0ZE1iSzBuWjhJSTRlUTB0UkFxa21GTzBmRlNlMEN0RFFLR01SSU9CTVhH?=
 =?utf-8?B?c1RqZkZTbnVCc0hZcXVKcW5HckJQKytIeWJuSnFNNkZIZ0Y5L2lZZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bf92e1-6a89-40ef-af1c-08df38ccc86f
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 10:33:49.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3mdu825jFxogdBEthHYYR4XPk/wRREcXtSG2LGdSuZ7mqcHYv1WEtBpWv4db1KURpz1oEv0nCvqSxoSOImF3Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5192
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 10:34:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24599

On 02.11.26 11:32, Badrikesh Prusty wrote:
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb             | 1 -
>  recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb             | 1 +
>  ...{linux-cip_6.12.112-cip33.bb => linux-cip_6.12.114-cip34.bb} | 2 +-
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
>  create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
>  rename recipes-kernel/linux/{linux-cip_6.12.112-cip33.bb => linux-cip_6.12.114-cip34.bb} (59%)
> 
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb b/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
> deleted file mode 120000
> index 16111eb..0000000
> --- a/recipes-kernel/linux/linux-cip-rt_6.12.112-cip33.bb
> +++ /dev/null
> @@ -1 +0,0 @@
> -linux-cip_6.12.112-cip33.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb b/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
> new file mode 120000
> index 0000000..91a3ca2
> --- /dev/null
> +++ b/recipes-kernel/linux/linux-cip-rt_6.12.114-cip34.bb
> @@ -0,0 +1 @@
> +linux-cip_6.12.114-cip34.bb
> \ No newline at end of file
> diff --git a/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb b/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
> similarity index 59%
> rename from recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
> rename to recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
> index 0d708db..95cd7b2 100644
> --- a/recipes-kernel/linux/linux-cip_6.12.112-cip33.bb
> +++ b/recipes-kernel/linux/linux-cip_6.12.114-cip34.bb
> @@ -7,4 +7,4 @@
>  
>  require linux-cip-release.inc
>  
> -SRC_URI[sha256sum] = "522caf8dd5a07904705691ba07440d8a557d74eab39a938b95b0c69ad27eed3a"
> +SRC_URI[sha256sum] = "801ba01e82a8e25738d4f30d2640e537cc06bb13f9dbf0f6fce5095f3fb1f168"

thanks, applied

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center
