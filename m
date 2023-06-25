Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1913EB64DC
	for <webhook@archiver.kernel.org>; Sun, 25 Jun 2023 08:32:23 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.46])
 by mx.groups.io with SMTP id smtpd.web11.8049.1687681933235516651
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Jun 2023 01:32:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FOKm6WIZ;
 spf=pass (domain: siemens.com, ip: 40.107.21.46, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=glmVLVkvopHNNbWzXWh5hraoGJEJUByEZJVUp5voB+M4Y2vgAhF4cnSr+MH/P0Eg2is3u4PUIlTmQlNvbZnaYE2qr3u/dPHxNpi40g/yGcOF/mgxCNByM829jF6epbC0HYeZtjAcdtapIVPrmvh3wuhCb+7wvwpRDofG7qClyiskrCtdUpSI/GWiYt87QPAboQo/IoCrQu9+VSoOFfc75fyx+FwWYhEMKV0JQd49n++vjUk3YN5oP2FNRpo3aOcvmI9lLFZKAqdf3C56pGkaCmTq5YUdnu3M/YlrfsT1trgfdaWeeBDq0I7b70DjUxaXiHNXf2VbvLlILGzwourYJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMMh2mxXs1PDJaJJUmGIXbp9186d55tTQOAp/S8SMLE=;
 b=IEaZxVHkYUpg2yMkuFZLvTgEMosNz9zoEQmkhLxK5cF8uLvKjOFTSvW7BRz6PPkTy8ecPNMLqWsLwa2F+tsFHjZloltsmlTZJupZONqmAYy8eCnEmskf+FtXKsQekZ8toIyDZybfaG3VNovJy+2FYfkL+siHljkqpvc9Nx+zCt+SLZ65nGy5VH0cn7IK5TSLywqJpB/2jv/mlbKFnBQcpIf/sZavMhq0J4Ys62nd2VSBraKINhKC79sJ7CpSAQx/1ReutFq/lcEB94/v8PzpkFN21udmiVMBDVXSLrLvELQa3D1vqwVuPSwu1iL3oiDOMQDrHUMGpCs3B7Mq/lxHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMMh2mxXs1PDJaJJUmGIXbp9186d55tTQOAp/S8SMLE=;
 b=FOKm6WIZ1HdJXcbKiWa6IevFmaURkah6SEnf5uPqbwRlLGpyQoX7YY5RPQY9f9OX1HcTP866pBps4FEAFBHCqTWrGbNWaVQEJ2VE/JdZTc9Z1NcUVzq6462DaezCQu2XjB0+s1swXvxH3GeAdUmf/lVHhoabh/e7nadbSbXVCooFDKpoKAQ7ayom2ce9HSWvYCsZuKjw0E4zwXClMjKNQtFiWjuoSebKOH4L16OAGuJQX9+DvjqiYtD+kCiVRGBIHHlQDcyP4PSChvLGdqu3kGO29Lpe1IfFF4oAO4F7xzSQV78YVn+4J8jltia97H2ZLBbC7QwQwL4wgcHvsGIU/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DUZPR10MB8266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Sun, 25 Jun
 2023 08:32:09 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::53c2:174a:8b13:ce94%3]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 08:32:09 +0000
Message-ID: <3b7b1d9e-01fa-e9c8-063b-d44c4636dbe0@siemens.com>
Date: Sun, 25 Jun 2023 10:32:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [isar-cip-core 1/3] .reproducible-check-ci.yml: Add swupdate
 targets in reproducible check
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230623140555.11428-1-venkata.pyla@toshiba-tsip.com>
 <20230623140555.11428-2-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230623140555.11428-2-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0049.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::7) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DUZPR10MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: bcdf5e06-f1c4-4d93-02d0-08db7556aad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HmDOcHZLOnhofw6WKwYExw2rtiVHvbxx4D895TomBnFOveP+bnbImU1cCOCf+kiumtQ26dGaox0hIsvASY/cypI7kqWIFhjUOKuxDXamdn48UHpobEnR0ZmlDDAEacaRR4WpjgZZ8+KBGvN4qVCENN/XVrEMI8Y3JDGRwVVWP3/dpaW2DGrjV8oK2i7xkjUX3AvN+my5Z1tQFwQ7Zzq8ZJ9nJqt3Npargm9nG7Dyk3lBSviGVC7m4+ghRIcZhlobNEcJ96JevWVNuDNMHT7ghf0hztN8AZz5xY3Qp5ARi0Vl/BUCWvbkvdgGBcN6lty+uiGGuQ0ajTjc/GiWbEejGAo84X9UfjbT0MuprirGtNJm+ZTesZ/tL+VI3rlQ+O+mw5WWjyVjvYzrYIJcpqq6qjOfNS8vjAGhbLmOvkx00PSanPGG+4z7r6GkoeZa489pTp6PouR/V37YnOG6TI7xoTtyy7ybs/lu2bVuM2PGny6v7WbapuUrQDP82d8IbNIdsgbqDg8ejCCA3JSSmfDnBPkvKDjsfC5nhrMj9QpOr3UxHBAWvNapruHtcDFSlTVzUtJGV0THA/vJKiURkKPHcEPL7UgMTnfKuAhfzATpOvQGOH5S7fzfTCUFmDZDFAzGlav62RLEEntQRy+EOT+Lyg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(2906002)(6486002)(6666004)(38100700002)(82960400001)(2616005)(83380400001)(6512007)(6506007)(26005)(186003)(53546011)(41300700001)(31696002)(86362001)(478600001)(316002)(66946007)(66556008)(66476007)(36756003)(4326008)(8936002)(31686004)(44832011)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RzlKVzFPZE1jVTlsVENQYTM0dlp2RktBZU5EdHVFUjhQQ0VGclFKVllzdVRH?=
 =?utf-8?B?Tnp2eWpDS0tQMytLYitkd0E5eTZMRjJkOXhZK2V6UU9HZzdVKzZucFNsTXRt?=
 =?utf-8?B?T3BCTGx3Z1F2Z1UvdVEvSWhaM1dxRHVvc2YwanQ0am92QnB5TDk2cmR1VGNx?=
 =?utf-8?B?amhSZ0w5bkVLMUNnd0JXeGprbmNudWtSNEJDZ0pESlAyUTVHVUZDVjdKYjg2?=
 =?utf-8?B?WHJueCtRV0lUN3lkMjJVZGpVL3FFNWJ1TlpvMjI1OGZQTTk3L2d3TC9oNm1t?=
 =?utf-8?B?aVEyMDZTdG9TZUh2Rm9tUCt3cmZZU0d5ZUJSVndnV0NPTmh0YnBsVUZRRzJo?=
 =?utf-8?B?bXBkWGR4dWNROVVRajBRNEo5M0FiS3ZGYVlLeGMvUTZpclE5cUg5MVBtME1G?=
 =?utf-8?B?TFdoaDV5MHp3Vi9ETWQ0ZUhzZFVPRVNENnhyNW9iNlRIcm9nUlJKd2o5Nnhi?=
 =?utf-8?B?SHdmM0k4b09jRXZGQXovaldlOWdCdzFIeTNzZVNWc0Q3NjJqZkFsZ2FWc0lr?=
 =?utf-8?B?YTZDaUIwb0dMRER2ZE9TWE44dnMyYlJkd0JvbHd1UUpraS9CU0E3SmhOcjdO?=
 =?utf-8?B?TFM3ZDhsUGw3QTRDbDlLRHR3Vm9TVXM1UFRWWnJtUHRkV0FNdGNXaDQreThJ?=
 =?utf-8?B?NzV3c3BHTUsyYUVsai9oYXRiQXR6UHEvVHpsM2syWHJTclJMY3hDYVEwdGJM?=
 =?utf-8?B?L1ZrTkNLWTZrZlZvMUUvMmQyTmlpWGIyRjJPNWNLTElzVTBIaGo1ekxNTnNU?=
 =?utf-8?B?ME9VRmtScXV0VU8xSkNyQnF0VzV2RDFPVkludlVHdnZaL2RzT1BBYktDbG01?=
 =?utf-8?B?V29DbE9WSSsxVWhrQ2tvYW5SNGkvR0s5eXl6cUxGWTE2b3JJV0NQQ1JCM2Vl?=
 =?utf-8?B?NkVCVHA5UWt5VUIwWUdjdFBUTERRUmIrSDhrOUZxYkZtSXAxMGR4NkJkQmdC?=
 =?utf-8?B?TE9mOUoxdmU2UUxudVZDMmJDMUl2UmZGTVp5QTVjZ0dXQ29pNWgrMDRRcE1u?=
 =?utf-8?B?YlBlQ2FyUXNQaUZYaEN6VWllSjlWSThzVVJjaG92VUNPRlFlU3lqQVFQRUxZ?=
 =?utf-8?B?emwrVEs0Y0VuVGZzZHhJMVNRa2lWT3ZWdDZCaWNTaTlpN25RZmdrM2t6RUZ0?=
 =?utf-8?B?NFN2TTJVdUZzV0h5ZUlTU0NHUndDamJ5cm95SHJ2Umo0Sk1ZTUdLakhpOXBk?=
 =?utf-8?B?YjNKZHZQR1RMSGNhSWFVTzRPalM0V0x0RGc1WndkSTF4UXI5TGQ3S1Qrc2ZR?=
 =?utf-8?B?Sm0vVHBsUmx3TU1KOTJEem00ZmJ6Zm80ZlVwWVkraFNWK3Y3bko0aUY1d014?=
 =?utf-8?B?NERvK0JwdTlJUmhSUk1rNDZnbmxWa3dEaGNjOWFpMWEyMS9NWlhEb25BUlpo?=
 =?utf-8?B?Q1VueE5PZFNVZ0VVWDVqdzRrZ01YZ3FQbk8rQnpHT3RlV0c2MEZxOC9vYXlI?=
 =?utf-8?B?ZXM5ZmFSTmx2QVVYemhFSVUzNWxmL2hrcjV1V0NLc1FOcG9qYzFpQWgwTWI4?=
 =?utf-8?B?UGg1RXBpMnVrZThtditnQzlmTkJFSEdmR2RoL2hrZDN5ODlXUXZJL3Rhd25W?=
 =?utf-8?B?UFhMTzlzQ2dGNFBqN3h2WWhRRXdOZStrNmpzYXBVandvU1pjcEIvb2dEV0c0?=
 =?utf-8?B?R3BOWTZyaWZhdTUvdGs5NGxsSzdONVc1NXIrSlNLdnYzMnVqU3dya2VLUm0w?=
 =?utf-8?B?UG9HQWpXajcyRXIzRjRtVUJ5SCtibDA2Q1NvUTdNZWtjUTJpakFLSGN6SVEv?=
 =?utf-8?B?cjdwblpTczFVb3I1MDdHTU1WWjlGdmtGUUFOQjlxRlJycXkwaGl0Q3Y4aElW?=
 =?utf-8?B?YWFvNU5nWm1zVGVSRExRMzZYU2hnMVRsMnBDeWgySndTVUlWTCtuaTBVYVEy?=
 =?utf-8?B?b3J6dTY1cU5xS0taUE5Xdnc0aGt6eWhvaWFBb2RVOUJ6RHpDc0tBUTV3UzIx?=
 =?utf-8?B?OFlOeDNhQ3hRZGNheEpwQlB5c2lIWEg0QUR2bHhxUDI3M3RQcnF1T1pTVzBv?=
 =?utf-8?B?c3BjcDRKVWkrc05PeC9SdnhXbXNxUVJ5OVZsZUlIaFRhRnI0cnlkTlIzaXgw?=
 =?utf-8?B?OFkrY21YUDNGdGNSTEN0TFhEdDdLd0I0U2xrczAxQy9oR3I1QVE0WGZyWDlX?=
 =?utf-8?Q?IKO7FnDq4lH0mu501yaVGXj7G?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdf5e06-f1c4-4d93-02d0-08db7556aad4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 08:32:09.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ubCqu5LG9Ei6aVEdLZqA0vn6J8mEdQtObBpNxqRgJN2MJplHtCnsrI7YlGgb+Ub/ySzt6umdRW09GnA6EkyvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8266
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 25 Jun 2023 08:32:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12151

On 23.06.23 16:05, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .reproducible-check-ci.yml | 49 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
> index d8bfb40..5ea7857 100644
> --- a/.reproducible-check-ci.yml
> +++ b/.reproducible-check-ci.yml
> @@ -82,6 +82,30 @@ build:qemu-arm-base-repro-build:
>    variables:
>      target: qemu-arm
>  
> +build:qemu-amd64-swupdate-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: qemu-amd64
> +    extension: ebg-swu
> +    wic_targz: enable
> +
> +build:qemu-arm64-swupdate-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: qemu-arm64
> +    extension: ebg-swu
> +    wic_targz: enable
> +
> +build:qemu-arm-swupdate-repro-build:
> +  extends:
> +    - .repro-build
> +  variables:
> +    target: qemu-arm
> +    extension: ebg-swu
> +    wic_targz: enable
> +
>  # repro build test
>  test:qemu-amd64-base-repro-test:
>    extends:
> @@ -106,3 +130,28 @@ test:qemu-arm-base-repro-test:
>      target: qemu-arm
>    dependencies:
>      - build:qemu-arm-base-repro-build
> +
> +test:qemu-amd64-swupdate-repro-test:
> +  extends:
> +    - .repro-test
> +  variables:
> +    target: qemu-amd64
> +  dependencies:
> +    - build:qemu-amd64-swupdate-repro-build
> +
> +test:qemu-arm64-swupdate-repro-test:
> +  extends:
> +    - .repro-test
> +  variables:
> +    target: qemu-arm64
> +  dependencies:
> +    - build:qemu-arm64-swupdate-repro-build
> +
> +test:qemu-arm-swupdate-repro-test:
> +  extends:
> +    - .repro-test
> +  variables:
> +    target: qemu-arm
> +  dependencies:
> +    - build:qemu-arm-swupdate-repro-build
> +

To keep an eye on our number of builds: Do these new targets happen to
include aspect of existing ones and could therefore supersede them?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


