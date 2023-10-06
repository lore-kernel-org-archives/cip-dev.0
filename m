Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A2DE81DF8
	for <webhook@archiver.kernel.org>; Fri,  6 Oct 2023 13:04:59 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web11.12125.1696597491143270039
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Oct 2023 06:04:51 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=d7z6JBtF;
 spf=pass (domain: siemens.com, ip: 40.107.21.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5/hjKau/icfKrHWZXVjBKrc959hkEUmiJSqYsuxvTEObnSgwADie7LdRSnx6qpvyaRdiP6SmGQCk3natfx7po8y6XbyBT+LrfpgOGt3XduzP9WufkNwDxC2u2p653/QEvpOZm/v3o54jngJLvXdwyTh7NRnTFgTkI7z7jYtrZDmvWSrtHPEXXIg3Tp/sw9zWH9iBb9xs7tCoWaS8QU3ZOOYcWaHVo35X7drzRIFHbc1H7uXOFbwQDGsipsHchJjnprPRDJVnSQAOn50u8N+Ns7xNAUA5dFc3P0myRF7h91pbaqn5rF+/ErCYm6FI5xuun0nd6SmxznpAdzmz5q0Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9obWhsNCD1UJy0FovAM4mFB2LyYa1x005QuSlSw2emM=;
 b=YCekBGJ9Sg5m5YLzBsQ+0W6wwuDFhkqJswt/2U/vfNznX8DfeeyMRHoCiAwZYB/xB+yqeWhHGYek+P89h8waKbHMOoFl/3AphLYBYNquQguvO+DJshSY+1Wm78WzWyUPHoDKaVB7ZRGZ4U4lrUgQK3oi3xZnuF/Q93p2WrugUApHV7Y1AjsiR+9TSmf6vrcjUC84oMRCCJ2LOPvkcnw3ZDOBzh1Vk5S+fX9OYIEXoMtvSQtS2aTaUuk6npbZulxF4OBI+UwhwttB274sK4CvfWrUXsX86MD+ZhPnPkW43YtK0JjKxFXGcrKugu9iD8T0p8uIhruchBFg2PgK0cN4BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9obWhsNCD1UJy0FovAM4mFB2LyYa1x005QuSlSw2emM=;
 b=d7z6JBtFavMejEZUq8jnvVUMX1M5f31s4+W40YFgPK8kQDS5wv6YhqgMOH1EO5y6n+NMMNDrp41H1CBoO66OACZqjVcZp6GiNQrwViSTOYxTdCpM6P2RiF/WcAcghsgSiaQtDCth19UwzIsN8HCEVMRlUQ6T5ABHxN16EIZm9YJsqjQ9G26gc2EnU3izsHvg9OateLij5JgLIpQy6vQ+T09f8LcHHzeKSoXHfMuJkDYGNeSqKccYQ5TuhPcNcGvbV57PtfFNPmrLt+UclmjJaG7IS1rMYApCbvFzuABmkw5kC+1xwuqO41HQFLuztb4McsDo6mK8j4RF+WWF6okRVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by AM0PR10MB3972.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 13:04:47 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10%6]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 13:04:47 +0000
Message-ID: <c6612b4c-b17d-484f-8cab-1f204567a456@siemens.com>
Date: Fri, 6 Oct 2023 15:04:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core 2/2] reproducible.yml: Disable signed swupdate in
 reproducible tests
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Christian Storm <christian.storm@siemens.com>
References: <20231006125845.2661-1-venkata.pyla@toshiba-tsip.com>
 <20231006125845.2661-3-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231006125845.2661-3-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR08CA0016.namprd08.prod.outlook.com
 (2603:10b6:610:5a::26) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|AM0PR10MB3972:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b8fd29a-8072-4d90-3ba0-08dbc66cd102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Yw9lA+qIp4f4S+EtqyGsH11efVK8uo0E73dBrQ0OG3wpnXApTNx7t1NkdXtvqLWmokLuxu4EFyrZB7avRK57aqJ4WSe9RuXqqHRSgDxGBM4kuB5yOIYypaGO+kANItb0618mXvqIfF4pwPGzQvELpM4q/LuvC+XUFIxuzCsEBR0yNoiekerF7Hy7Sh5JBehZ8Itz4ovyPpPMrxrF2r+D+0ix2i9mvMP+/7Kin4Un6+EvjV5bOjQgfhIxxb2ryXLOJQIFQnz2i1N4HrbHsghBrY0XioBHm6MJLJ+1nOZj8rSwbtKlxFHnRkj67rt4YKVAOt0RDmIhwfwwFrv4dPMQgZhke9MyVSJLjLPV5XbhtsO04aKRQVTcuAahyij7h06gPEpyVLAfZumoXtr1aoXzFpGVP6eBgO9FmFDGl1HzApCoaka7AlKMnXg9j5Bx7pWGqQEjIuz/3zqaki50Ya26RxkbKKFwIew1E5gN9niyIt3ZXU5z8j+vcZC8og9Op+ISzKdy9KrPofl7HtCvzP7oRkhXdjuYWoSGwNTa/IYQ4mvGsYbtBir2DKAFD6lIbPctzwgr3WNfTuw/6fQ6yw4EvwfCa6K5LO/kLOYj/kVpNstyHo+HECKWQDgHaGlsT5ZCsSLnXQN294Tevrrmo/q1xQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31696002)(83380400001)(82960400001)(2906002)(4744005)(86362001)(38100700002)(107886003)(36756003)(2616005)(26005)(53546011)(4326008)(5660300002)(6666004)(54906003)(6512007)(316002)(44832011)(6486002)(6506007)(8676002)(66946007)(66476007)(66556008)(41300700001)(478600001)(31686004)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NllZc2RNa243VHNNM2xZVkRWLzJielZpVURUS1Bxd0JSMXRkcTNKaUlSMFB1?=
 =?utf-8?B?R0F2RUEyT3pMRUxLMElabzE3YzBHRG9UOTFiWlVIbXhhT3RNV3Q5Nngra3lG?=
 =?utf-8?B?bUowRENOcmVVRXBobnFtQmVua2lhZkpxL1RiYkd1dlJtdkMySXMwUlNEVlBS?=
 =?utf-8?B?SGpGUHMyUEhkU3d5QXlOcXNtVHdOWnNpYkcvUmJMNDd5TTJIbU1RdEphQWxE?=
 =?utf-8?B?VWVQczI0cTJrY3lBU1RaY3JDWlVkTVd0MWgxRzB5K2J3UnhFSm5HdzF5Z1Q1?=
 =?utf-8?B?alQ1SXZFcnhWMnE5ejlGTU55a0dqbXFIYXp4cDFZWTJyaWlQQ00xTEUwSDVD?=
 =?utf-8?B?a0RTK2FjZ1pqL0hPRkF4QzhsdGNZOHZnRk5SVmp1ZklvaDZGaXhka3RwenRV?=
 =?utf-8?B?NXI2MkxuNDVNUGlQWmIraXVPRVMyMEEyOVk0SVllWTJ6Zm5OejVtTk9jSEpG?=
 =?utf-8?B?RkNldGxvSGJqYXdVeTcrNnNha2RmOVdROHdZMVIwK1pEekdJbTVSS1M5bDNs?=
 =?utf-8?B?NDRhT0FZVUhmK3YwMmJCM25nNHlEMXJocnRMaEsrZEZVNTZMSmRkcFF0R25i?=
 =?utf-8?B?WjhyOGZaZjVyQWZDejdEdkFaUkFBUThiNHpkc01GZldxZzFIWXRuYVdvdzRo?=
 =?utf-8?B?Z1pnbUdad0FNUW42OGoxem9Hc0lZZW80R0haQzkwNDVQMW41U3Rna20wZnRX?=
 =?utf-8?B?ZEdpLzg4ZmEvV0g5MEVWdWMveGgxbjI5S1NSeTkrV3o5aUlWSmZwUzBCTDRq?=
 =?utf-8?B?WElZMGExTDFzS0lhdXFQQ3N4Nkt5akJVR1lTamxMZTFkWUduYWFxY3NwSWlG?=
 =?utf-8?B?b0tHZWVyckMwUUlOVmcvaS9JcDg0KzBhRVVnRWNocHNSMTQ2YTVIdE1zdnZz?=
 =?utf-8?B?Y2hHU2xQR0dwOG9QU280eFJqUld4OGhTbUNBU3ZhT3VrekU2Qlh6K25sdWt1?=
 =?utf-8?B?TFNlMFFZV0dtelpaZWZLZnNDU2NLOWZFUW55b2tncjhOdUxGcVpyZEdsY1ZF?=
 =?utf-8?B?TllFajBXWXJMd0VJWnM0eDc2S2piTlNpbVNyd1lWSm1kamdWTThWSHkvbnZz?=
 =?utf-8?B?RENVSStEbk1LbzhpZER4YkNqMjRya3VuTTN4T0dVbGQxa2l5alJJVEJUaTBp?=
 =?utf-8?B?VzBhNFVHTkZiNEZHaXR3ZW1TdTA5Q0tabzNuYnNwMDVrQ2ZWQ2syNkpsUjFq?=
 =?utf-8?B?NHJFd2pQVEJDRVZvbS9nZ3ptZzlBUVNoSFpEcEEwQ3VGM0QwU2ZMNjJyREN0?=
 =?utf-8?B?b0VkT0lxUHVhTjNYL3JXUzdaendWL2RjZWNZRzJhajZNQWgrYkczMVVwci9l?=
 =?utf-8?B?WE1oTGwwVXhCRG5EdXhLbVhWYWcyMUJRamhCZy9PREJJRTBoNVpmUGJZUlNr?=
 =?utf-8?B?dzhtMlR5aDZHWWN4aXdDSEVXVVJCRThBQlk5M29WWndNWjZ3RENZdmsxTXor?=
 =?utf-8?B?NzlJR2dJbXJrMUVBRDFXUTdqSEFhQ3JQdkYxK1k5R0dyTWJoYS85WDZqR3Zy?=
 =?utf-8?B?SUNXeXRxNk0wejNNRXZxWFBQbDRLK1ZOY2RjM1dzckttNTViMHJNcGJhSEx2?=
 =?utf-8?B?M2g4VUgrait4dVYxMlZnYjllOW1UTGdzcFlCdzJySkM1UWZ1dzcwamNLT1gy?=
 =?utf-8?B?Z29PTm1VS1pJOGVOa1R5MEZ1dlFrTEh1MHp4UGZ4eitLUGRhZzRKL2pnWWlE?=
 =?utf-8?B?WnBYbWlhRnJ6TWVJUXBVVlRHa1R2R3EwVzZrY3U3VE5KTGRBV3JodXkxdkJQ?=
 =?utf-8?B?NmRmMmwyYmNYVWpLc3lXOWR0c0o2SHhnd1Q5YkhEWXpxTVdLVUltRW5taC9I?=
 =?utf-8?B?TjY3aFlMajBSSTg5dUd0WnJybmM3OG9GWUZCall4UTlnenAva0xzdFlTa3VN?=
 =?utf-8?B?c05qQnlsSDcwYVhCaGxjWWxhQVVyZCtlWk5hckhBa2x5dEVaUW1IZFFRSFBy?=
 =?utf-8?B?WmovVmQxditNMTRidElnWnAxb3Bobnh6K0UxbHE0NXUyZHFsMmo3ZzRnM1JO?=
 =?utf-8?B?T2VyUVNlbUdqc1RMcEZGYVR4ekE5bEhtM1FRZDR1QzNOOURud0Z4QjVpYnAv?=
 =?utf-8?B?a3RJUTBvUEVOTWE5TmtjWUdJNnQwSDF2ckxnWEQwN3NnaUNRM2ppbFU0Q2R0?=
 =?utf-8?B?dlVPSi92U0k3cWF6OUVWdCs0WmFWc1g0L0RiU0xUMWRiOWhpRkxySHhzOXhR?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8fd29a-8072-4d90-3ba0-08dbc66cd102
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 13:04:47.6658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHjGkTyjvuZHckDpzAc9CZm7lQ6d1FMkT533tUiFUJUHg4d6bVnqwMz5Q+WczBvgo8jVOl+WPqHs4TCE7baaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3972
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Oct 2023 13:04:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13299

On 06.10.23 14:58, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> signed artifacts are not reproducible due to fact that the signature
> can include some randomness for security reasons, so skip signature
> verifications in reproducible tests.
> 
> Fixes #80
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/opt/reproducible.yml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
> index 5d6a896..73dd4d5 100644
> --- a/kas/opt/reproducible.yml
> +++ b/kas/opt/reproducible.yml
> @@ -15,3 +15,4 @@ local_conf_header:
>    reproducible-builds: |
>      SOURCE_DATE_EPOCH := "${@bb.process.run("git -C ${LAYERDIR_cip-core} log -1 --pretty=%ct | tr -d '\n'")[0]}"
>      WIC_DEPLOY_PARTITIONS = "1"
> +    SWU_SIGNED = "0"

Shouldn't we rather or also check if everything except for the .sig
element in a signed SWU is identical?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


