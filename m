Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB46C001B0
	for <webhook@archiver.kernel.org>; Thu, 13 Jul 2023 17:03:51 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.71])
 by mx.groups.io with SMTP id smtpd.web11.2285.1689267826424554377
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jul 2023 10:03:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UDLXrUsQ;
 spf=pass (domain: siemens.com, ip: 40.107.8.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZY/6Yx+V0BpFisJNNrA2/Iz3s0mS63IZmX3G83hVTSOE1ojWmos5u7+hAThEtcYmDaWtgoJPzgZV0GxoN5l0J3qrXNkwh1H3pW+8ZEbmG678ZEGW0W7Zk/Z191RKXDPgWBcjQRRNKLBAYVpr70uwfS5bYwgl06ivlvSZ2U+PW6DEvSNyDqbtPVtd8YtesPZLxpawO/XmGTFWD1OCaRcCaqPkTK/Q7oQrTszgbPc3ulT3wW8ywEMprpeFrdABHzR+uZKQj3i7iNXXoIMAIskKmQtDEZLruhn3YWxFIKW+uEjS7HjR+PnFI+Q2GKqK9X0JDjsv5NcfDOxJkk902sSq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmixYdFBF/MwuvPTLHOsbxR/R6NL7Zo8T09kOnlWEgc=;
 b=VF5h5pNxlT+X/1BWZN1oYyJCEgQ62UWH/SjBaWO7TdYxqNoU6iZkjNEFlv/Ix4eJLlLwfuwpCsAqD7sgF8xvj6UzLAyok91G0iFaLXGTMSTw7pac+M7EShn/Nek3Mu7KCBfVDmKJHoA1e0ANRD1mHpB28ipUioMYQODPpPpEBIpv33ZHxiFW/veZ0JMtmQ9PDDRqTQZWf6kDdLhk9/rHjTf7G+0Gek4Ito+MrozhpA8zIqXHLjzNVqp3KGl4BoIwZRS8QXZYUr5AkTDV9BD/w6aEZCOhqqdX1mEd5vYY8lY3o0FWO7OsPATiU0QJ2akaIUIvQNt+0t0KHGqfP+irpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HmixYdFBF/MwuvPTLHOsbxR/R6NL7Zo8T09kOnlWEgc=;
 b=UDLXrUsQmzq8SwiAiGrGAHtH1hzMwFlqzYsmUau4bnvxJkCRJDkxuW/uQW8cjaoY87DQbWbromgivZmQ35SBYW1RUQ6VQbJ/pHk95n9Djm3SWR1elcbQyemQnVo991iwKGia+J4qpfNt8jwwFuUwpLnZV9bOp3QGV0YWsvn+0MgM4rwqYBk+7MitMxSA/n05lucmPeJG9et/njmjGIM7vIFW/MgkPrlhNmYVBjCHVZQfdmXk9Z2RO3rPyFcjj7Cdh/UL5EX9wZcC2aWnGscXT4tAfJ8lA9AjAVc5c57hpMYm4QLUJ9Qvdfr+V+VBoHlUwlmF/KN4KWXO0SdvFHlogg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6177.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 17:03:42 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%6]) with mapi id 15.20.6565.028; Thu, 13 Jul 2023
 17:03:42 +0000
Message-ID: <02bb2692-307c-b19f-8d47-69fbd59acbb8@siemens.com>
Date: Thu, 13 Jul 2023 19:03:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [cip-dev][isar-cip-core][RFC 1/3] recipe-devtools: Add recipe to
 sign SWUpdate update binaries
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230713164055.2786350-1-Quirin.Gylstorff@siemens.com>
 <20230713164055.2786350-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230713164055.2786350-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6177:EE_
X-MS-Office365-Filtering-Correlation-Id: ba825ea3-f323-410b-fe99-08db83c31c46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pS+JSzwWCkZzG1S34/UfwlOBzxxaeC8GH3QIilJ6LiwFn3OxiknCLxjCneL8ZIOLAz6nytPGMIjFEprOc1rJ0SVaugeEhOoI2wh31thdL/wkUPnCTbWcHMgAFBgJPREVEmZ2iJCmJIFwePk4+FpYotrzifzLSAuy5aipZLnL2tP1yi+B3I+Nu5Xa4GBMesI/ssUV+ZGmneqW5MDXRjep0c6D3TP0HHlayKc4F1KE847lPAclahZrXhp2INhXTF6R4RBZwroTX5uMd62d3a3F3kHokSEzWHKpoiIK2i92ZVW7Ouh1PkbInpRBtqi0CtUhklgCYRXaBicjKpZKF4bO9cf+98MvTPGGThC8Br8qpL2JTIWRp+e41Uk+dIvlTfMVUXuRdtde52Z/EfJIRVM6osIUJxUqPWwaw6TdBSuz7ac6i7OaA1WiDbVCBsiCAVeOJd1O5TURTvutsdc5hU34ukVfHBBQxUNIth+G0aZ7qU9EH2HlCMVkqSQn68tluGRR7qENDdTEASk/dADb7uoBLQqJ6EtF+/n9X70cku1v7HVy7hAz92Z1TmjHny7mwAM8d0Q3Wur5Ivn+SXhn+1zKwgW+4/3/0TO5Zy2YMn6xHhAY7u6MC9PZ4xp82evOg0nJvQ2Wdw4Q33k1zAtp+d7FaA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199021)(44832011)(30864003)(15650500001)(2906002)(41300700001)(2616005)(36756003)(6506007)(5660300002)(186003)(53546011)(8936002)(8676002)(31696002)(86362001)(6666004)(478600001)(82960400001)(38100700002)(31686004)(316002)(6512007)(966005)(83380400001)(66946007)(6486002)(66476007)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bzhYWmNYRHNLczNJbmJsUFVzYW5yb3J6R0M5WnV2NkRsYUFpRmJxQmg4cEU3?=
 =?utf-8?B?WGNvTUFuNjR4cU54aU1pK0l1V0h1VFJNcENDU0dQVVhwc3RENU1Sd2JRNVNZ?=
 =?utf-8?B?eFM3MDJ2SW1SZFQ3YnRySUZmeVZyVWtHU2NCakQzRHZoSlcrREk4WXAxNnN2?=
 =?utf-8?B?eXFUdXVOUy9WUE90LzFEUEpHdDl1ZnFDMC9ybEtEUW1jVW1JRGF6Ym1mc05P?=
 =?utf-8?B?eFBNeHFKdHZLZTBlc1B5a1BtYVpPZGExS3VGZFZxeVQwTGkvVzJqaVhjY1Nv?=
 =?utf-8?B?MnA3dittNm83U3JLSkxxODQ0eHFJNVBhNXp2aklrajNjV3VpWEkwOWFYUExw?=
 =?utf-8?B?KzY3N2ZRMlJ1Njhna0RsMXArUmdabVhHL25FUDlOUkpaQjZyMjA4Nk9BVG5H?=
 =?utf-8?B?WkJTaFBuYm5La281Y3FPOTFUNjJaanVucUwyU3VuYUdXUjByV0lrK1BRbXpY?=
 =?utf-8?B?cktlSmlZSXFpc0h4VXRReE5WUC9XMFJaMnFKUW4zQjhNVjFLT0hUaUtsSnZk?=
 =?utf-8?B?NlRqUEh2MWFRa04ybk5WSjJ2ZFBXL2RMWU5QTnVsd20wbEhaTWd4Ym1vVFB1?=
 =?utf-8?B?VU1ERFlhMy9LMlI4OG9Bd0FaL3Fqd3BhOGNwSHZnS2Nhdk1nYnJDdVZaMG42?=
 =?utf-8?B?RlM3T0dEeXFCOUJ1eEI2d1ByUXpEUzgwcmdQRTYwL05vbDRsT2JWUHNJSmFR?=
 =?utf-8?B?ZzFqc1hvWG9RZjUrOVl3RzllUEMrdGdLRzVTTXRUQWQwOFNlUGErekdOUGpK?=
 =?utf-8?B?dnZSdTg4RkhERitVR1ZsUngrQXRBYUR1QlBSQUMwQzgwWC9RR2FvblpkREZ5?=
 =?utf-8?B?bytWTDJETlNCTTNsczlZZFlyckxrMnlXa2FvY2pYZG9KZ2xTcjJzc2s1cmN3?=
 =?utf-8?B?bkhCM0c1VEtFdHFWMGFKeUxLZllJbHNMSHdPNnM5YWxUMmxZU3FPc09saWpm?=
 =?utf-8?B?ZURTajRUTWpMOXV1MWh6a2I3TFdURFNNZmpTVzE1cW9KN0ZIdWk0cklvdnZQ?=
 =?utf-8?B?enpScTBFSGlaNzhnckppMTlqNzU5bS9GUjhjTC9pL01TTHdZS2tWZ2NQM1kz?=
 =?utf-8?B?d2R1RkJuaEk2RndHUk1XUlpwbG9lRUt4REFweG5KRmtGVTdiUTlHTjFVTVlW?=
 =?utf-8?B?SjJhU0tJVjlDUkl6QzgzWGIzQjdRWmVRMEhoSkpOZVNpVTdwUU5EMnBrbDA2?=
 =?utf-8?B?cEx6SVJROW1XN1BqMnhpUFRsMDloM0F5RE1BT1pjamRVK1dxU2VpMndvVGJX?=
 =?utf-8?B?alhLK2lyakk3YVpYK1VGeURSWjhSZGZia21NMzdRS08yYjZDTDZPVEtibWxt?=
 =?utf-8?B?eVhnM3hNZDJHZFRIOXdmOWhnaW5YeE50RnJneVhSQWduK09QYm4yZ0ltcXFH?=
 =?utf-8?B?V3pta0xEcC9GMTRmNXI2bEpWYXoxTVpjVGVoSWJMYjJOQUJOWTcxRGJlejVm?=
 =?utf-8?B?VjhIaEhkM0NJRTRGU2RJOWdCbFlJR1ZoQ3dYUTdVb0w0YzRiaW9pT0l2RW9o?=
 =?utf-8?B?YlU3VW02MVF5TlFGTDJ1UW5NLzVhUzkzNGlueUc1NTgwNHpNampVb0E4ZGxi?=
 =?utf-8?B?ajdQSlhCY3VRbUV6VkVVN3p2Q1U1a1JKbndkYldCQ3BacnFydTlQWWZqMHBN?=
 =?utf-8?B?UTdRejhHNWVvZEZDSXl1MmpYVE5pVFR3MUxFaW45OTBuOUhnMm9DdzdqeVhn?=
 =?utf-8?B?cXNaSWNrSkN6bDNYMU9ZVFJzT0l1L1MybGg1bk5Pd3dRNzVRUGE3aU5JeG05?=
 =?utf-8?B?ZzBBZzdZRHBMSHVkY1RWMFp6MzBnQzNEQ3FnYm4rMWNiRm41dHJRRXZXRWlT?=
 =?utf-8?B?RVY0bjkvMDZBVGhBL1VBS1prMnpuSDI4ZkgvcEhSNTdMR2FFUlRHdnp3WUJq?=
 =?utf-8?B?cUEyeFZjREhPd0dzT0ZoMk5tNXhMdEJ1akVjUUYyWDdxSkhZWkFnQXhrMkNP?=
 =?utf-8?B?bUZpdElrcmZlWVg5VWp4SmxESzBzTzh0VysySlJkVzZtSXdoSHZsVForbXZm?=
 =?utf-8?B?S0NFR1k4V0syRGphdHNWL2U0cVlZLy94WWxUUDVacWU4VWNSR1ZkZVBjc29N?=
 =?utf-8?B?Z3FLWjdvK3RQRDg2NUR2RXlWbnMrK3VGZVFZSEs2NWdMeFNVVEhRSGp5bzd5?=
 =?utf-8?B?cWRkejQwRTlhMkxXRFgzcmNIUmtMK2dmeDJHbVYyd2MwQ2g3aTFvUUhDTEhZ?=
 =?utf-8?B?dDFMREY3T0U0QkJ2NnB3YTFnK01YNElmb3RoZ2xIRHZRWHlPYWRFN0VlZ0c1?=
 =?utf-8?B?bHpXMUVsV3lWeHpPdmMxU1VIUDV3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba825ea3-f323-410b-fe99-08db83c31c46
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 17:03:42.4532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j/gDN4Cj07E5JcWfcgdkzxjhMXo8NadJawEdp/7xOn2Xv6X7iTbRjI6DNUhG7sIcqAhe1BmhRI8kz7LUhDmW+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6177
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jul 2023 17:03:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12338

On 13.07.23 18:40, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This adds the necessary recipes to provide a snakeoil for testing
> sign updates and a recipe to for offical certificates.

Several typos / wrong words here.

> 
> The certificates creation can be found at [1].
> 
> [1]: https://sbabic.github.io/swupdate/signed_images.html?highlight=signing#usage-with-certificates-and-cms
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../files/cip-swupdate-snakeoil.cert.pem      | 30 +++++++++++
>  .../files/cip-swupdate-snakeoil.key.pem       | 52 +++++++++++++++++++

Are these different from the Debian snakeoil keys? I suspose they are
for the reasons you mentioned offlist. Please document them in the
commit message.

>  .../swupdate-certificates-key-snakeoil_0.1.bb | 17 ++++++
>  .../swupdate-certificates-key.inc             | 31 +++++++++++
>  .../swupdate-certificates-key_0.1.bb          | 15 ++++++
>  .../swupdate-certificates-snakeoil_0.1.bb     | 16 ++++++
>  .../swupdate-certificates.inc                 | 31 +++++++++++
>  .../swupdate-certificates_0.1.bb              | 14 +++++
>  8 files changed, 206 insertions(+)
>  create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
>  create mode 100644 recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates.inc
>  create mode 100644 recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> 
> diff --git a/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
> new file mode 100644
> index 0000000..a44cb7d
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.cert.pem
> @@ -0,0 +1,30 @@
> +-----BEGIN CERTIFICATE-----
> +MIIFKzCCAxOgAwIBAgIUEA0euuQB7ulZBzoFaG+/Fps82oEwDQYJKoZIhvcNAQEL
> +BQAwJTESMBAGA1UECgwJU1dVcGRhdGUgMQ8wDQYDVQQDDAZ0YXJnZXQwHhcNMjMw
> +NjIzMDk1NDA4WhcNMjMwNzIzMDk1NDA4WjAlMRIwEAYDVQQKDAlTV1VwZGF0ZSAx
> +DzANBgNVBAMMBnRhcmdldDCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIB
> +ALO14EDb7Q/hXCJZbrl/UD2RytUb8Phh49iPpIOryJKqDEyGNhc03XzpkB5qMYEt
> +vMN+UXRTLFvBIfrtukLzrpEm5jTPaSAciKD+nIGqNFbPXWl+KIy2lMTEqD9Se7lQ
> +4u4fupZQp4adlsdjya0i9u9fnNbK25jCrPjQHf698eS1VR0YpXOqAqB9VFLeLdlj
> +BCCmVBkhMTF/z7CvF7XsL7rqBG8F1yTg9qKTf/2C9Odc9sCtjy0wGt8NBSV2Cua3
> +ifPNQtYdxPLR9ohyariMEsS3s0WVclUvctD6SwCmP0RNvwmKDyzlWerRTSvODw+8
> ++laD0vI2KIkgegzDiJGBF0DrfBrePqCHLeZztQHpHfTkcSAEP4hgg4ev2p5XV7lC
> +1ed9UTHjhW+mmKJuJODgfsS7sQs8CqRGHYj95RrK14CG5PHebRWpSH3KcmROpsSl
> +fUXQTSqth01welrL9/OEpO0vRlnL0FNrhjQFtgIR3djgxosoRuOL43g/ep1CtIwc
> +ypFDemhgMKoUzc7KnQvGpG5FeqUSqqAlqclAKEfFNs4pvpc5mz3LUwdNkyIGkgqL
> +Xuhnf1OkMDtMlZ5wvi+CTqYMX2KqXU8yz2Csf9uN54ojIGbWN73wCZA5JH7R8FqN
> +PoKJ8csQTayQK5XBYP7XQV1CgnAJDxa/pEnMf4zLotG/AgMBAAGjUzBRMB0GA1Ud
> +DgQWBBR2lBlS17x7xqB2kaLwEg1lJXpoLDAfBgNVHSMEGDAWgBR2lBlS17x7xqB2
> +kaLwEg1lJXpoLDAPBgNVHRMBAf8EBTADAQH/MA0GCSqGSIb3DQEBCwUAA4ICAQCe
> +WK2TcfszS5EPeO4K6o7Zsr6tNkyAfP0oHm4gqAOfverfITctws/SIOdwLI79ljMq
> +vUuSEzWRnx16TfzqBlnFNFEUPBknnk/KeHCXgz4XdyyLdS8cga1lCHc+yRVIcq53
> +Z9KaLjbg/OmyJwVTehlJGnDF4QCOIzMO4Ha+O6Eyxu3ARp/x2QrzsfQ1U3KtMhAy
> +NcBG/mupj8mwg3cfo10MmzzN4ioQUCIf5M6eg/8iDITgA51XqFpjf2fX1xusSBBe
> +zuoy4Rz+Df1rGsUabAd7jKVXghS1+AE22ZPy6bnmV810ONb1H8MExFbGgdulYhmo
> +zoH6H7h6LtKP0xVOZ6H87X4Hoi7YitQqCl+oaHUE2GzA97fm+rNXe84ekJvjUiEz
> +Js3q1wXaegMr4LFmu9MPBSycJw54KtLfg2U0tIW6SD7dFlvD2f/qo7RtyEiE/Wfu
> +Cm8ZvMUr+OuNAvQL/Ig08JgUKisTK3ARHFxMu9sEMsWoB7bTGvyiZ9mS/G2VIet4
> +1pucvi89d9qXeZZ8PByHOEo0c7cu8lCmtIZoh0rdV3t8mxOZA1kFwYK2xahA6DT3
> +J2me41iKb9l2aCbGBbUKiesu3CRLpPG8Ic8X5PPkbRlX5/Zza21AbM8jxX14ZAL8
> +mkgMhzaLWIGo8ixvA8i7Fm/JunrIimDZaRjJrKuoMg==
> +-----END CERTIFICATE-----
> diff --git a/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
> new file mode 100644
> index 0000000..5dd3d3b
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/files/cip-swupdate-snakeoil.key.pem
> @@ -0,0 +1,52 @@
> +-----BEGIN PRIVATE KEY-----
> +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
> +nFtyUBqMFy+r+QlyRfQbhfXxs7cW1/M=
> +-----END PRIVATE KEY-----
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
> new file mode 100644
> index 0000000..fa2ce23
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key-snakeoil_0.1.bb
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Jan Kiszka <quirin.gylstorff@siemens.com>

Did you change your name? Or should I now use your email address? ;)

> +#
> +# SPDX-License-Identifier: MIT
> +#
> +DEBIAN_DEPENDS += "swupdate-certificates-snakeoil"
> +
> +require swupdate-certificates-key.inc
> +
> +SWU_SIGN_KEY = "cip-swupdate-snakeoil.key.pem"
> +
> +DEBIAN_CONFLICTS = "swupdate-certificates-key"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> new file mode 100644
> index 0000000..3fafce0
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -0,0 +1,31 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES += "swupdate-certificates-key"
> +
> +SWU_SIGN_KEY ??= ""
> +
> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
> +
> +do_install() {
> +    if [ -z ${SWU_SIGN_KEY} ] ]; then
> +        bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
> +    fi
> +    TARGET=${D}/usr/share/swupdate-signing/
> +    install -d -m 0700 ${TARGET}
> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_KEY} ${TARGET}/swupdate-sign.key
> +}
> +
> +do_prepare_build:append() {
> +    echo "Provides: swupdate-certificates-key" >> ${S}/debian/control
> +}
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
> new file mode 100644
> index 0000000..45864fa
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key_0.1.bb
> @@ -0,0 +1,15 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +DEBIAN_DEPENDS += "swupdate-certificates"
> +
> +require swupdate-certificates-key.inc
> +
> +DEBIAN_CONFLICTS = "swupdate-certificates-key-snakeoil"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
> new file mode 100644
> index 0000000..4e45b6b
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-snakeoil_0.1.bb
> @@ -0,0 +1,16 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require swupdate-certificates.inc
> +
> +SWU_SIGN_CERT = "cip-swupdate-snakeoil.cert.pem"
> +
> +DEBIAN_CONFLICTS = "swupdate-certificates"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> new file mode 100644
> index 0000000..92f9715
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates.inc
> @@ -0,0 +1,31 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +inherit dpkg-raw
> +
> +PROVIDES += "swupdate-certificates"
> +
> +SWU_SIGN_CERT ??= ""
> +
> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_CERT') if d.getVar('SWU_SIGN_CERT') else '' }"
> +
> +do_install() {
> +    if [ -z ${SWU_SIGN_CERT} ] ]; then
> +        bbfatal "You must set SWU_SIGN_CERT and provide the required file as artifacts to this recipe"
> +    fi
> +    TARGET=${D}/usr/share/swupdate-signing/
> +    install -d -m 0700 ${TARGET}
> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_CERT} ${TARGET}/swupdate-sign.crt
> +}
> +
> +do_prepare_build:append() {
> +    echo "Provides: swupdate-certificates" >> ${S}/debian/control
> +}
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> new file mode 100644
> index 0000000..41d07a5
> --- /dev/null
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates_0.1.bb
> @@ -0,0 +1,14 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2023
> +#
> +# Authors:
> +#  Jan Kiszka <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require swupdate-certificates.inc
> +
> +DEBIAN_CONFLICTS = "swupdate-certificates-snakeoil"

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


