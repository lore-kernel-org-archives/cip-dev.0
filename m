Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72B7CE79AC
	for <webhook@archiver.kernel.org>; Wed, 20 Sep 2023 05:46:40 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.52])
 by mx.groups.io with SMTP id smtpd.web10.30583.1695188797411606453
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Sep 2023 22:46:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LempS9dt;
 spf=pass (domain: siemens.com, ip: 40.107.14.52, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDJvGE2YwVS0i2fEx7E+lBRngiWigxkwVLlPEBdcgp12GGWIuInapYYppfRmwUPQCvPPH3lr6MRNMVnz/m7ldcKwcEPYXBZIRG3Pn2mjQJT5XAanMtXriQBEXobHVe5+lf3Q8hWOMArZNTsnLw8X7c0sPmnTZSaXOR5g8ESug1tiJY1/qdTG4Z24yK/wzFBICN5CJKxDWxNZXDzDpdoNO0fGDL/Bg8s4BEX71TcEY2QNB8avj7NfzdGJsuuHj9VRs0y6WMgvwyv0T7V5/3aWhtykw9ooVghIsbKHJkakYaM+2w7k4Fse3k/Z+3ZWhcIsNOZTMqnYo7OH02m8b5HkyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DlSHyoiu89tDmWBYOiuMMQhFudgu+6PcInDRuE6D6M=;
 b=mp9t9NHdHp4oO02jGJoiFBMuewlLUxeG6kI9GmIfQDSxDCsRNaLvu65WQ7oSKtbnDWN8yTVp4ceEYNTYVfEbJ6M4HuUF8GmdvWNHO/89R6lUSaelZggZwftoBkaH+s3xwunTxVMH4+sy19+qX0UmiQYXfsciCq0mgzNzp8FkwErdH2jHtISxPz8D4aWRvjlg6HEEsTOLRsIfu7cCHxAPILkL4mSoy7QbELldrllC+WUfi5zMLBURLPzGlf/ZOEv7hblxmvnMGecbmA7aKpziPI+TWDGubCPrPi5/MtXuJatzitT3cBHrFgAQn8YYazFlBNj6wFqSD/CBwtutA+5Q2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DlSHyoiu89tDmWBYOiuMMQhFudgu+6PcInDRuE6D6M=;
 b=LempS9dtGUPEXxPOg4XkG2KfTiGFlUcpcwn4qiOKWgVKpQn8I7OD5Jjl6pnkA6y/TCq04MuI1MHUdVjYfvwI2GNiHQLsuqfGBu9l6n0dwMOmp7wquoVi5/GzDNS56bDXSGQojCXTomPCSg/tQLBj2TrJS41bYPH8cIXR4fK1ZK2iF1oMGPBhLO9uE1kMwEfVpNN30s7JAEckhDyn/0Ex+arG5HtnHI0pjfzgr6aaFGXEp7oe97mOdajO3eAGRSxSRppaHFBygrE3g7ggDL8mNP5EqXEVV25mU7zbyyd/wdlCGS+/CQHA+94XxlSOJfmurCYGJQuq74SwHkQfZUxP4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3831.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Wed, 20 Sep
 2023 05:46:33 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6792.021; Wed, 20 Sep 2023
 05:46:33 +0000
Message-ID: <4a535981-86f8-40c0-88c6-be079e1c6593@siemens.com>
Date: Wed, 20 Sep 2023 07:46:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] bbb.wks: Add fsuuid value to the rootfs device
Content-Language: en-US
To: venkata.pyla@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20230920054357.7957-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230920054357.7957-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::27) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3831:EE_
X-MS-Office365-Filtering-Correlation-Id: 8db446dd-84ee-4b77-8741-08dbb99cf1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QU3DDWfGSxhSxie6BH4YSTu0VVwlQhJAj+fGkQwcqvyUordCryz9Mv2f8bWkWh2DCKiyQnGgsH6IdZiRtfSWnI+hUSH/fXkuFZ4+85nzdb1sPzRS6zm94o1ljjnEqzywgzGVCo++gVUO719Bsq7TYwhQA4M/T/mioyT+pF9yNDpRvdxGh2mOOMQB2gyuIgKnUtYKV2CSxdknZ50jM0cZ/o4+w8r46yQ5wn0nULYTSQsutQUQSw/SBqOmFZjUEzAER6Ynh2PkYsWpthJcmvuBx93SBfyzSlWYkV+YhpAJhRcUDhhxeKNB5SVuKEYBjz4ElDfF8WMCBJ4P7qtVA5aLfcZoZ7ROPwxZQRjNxXiBGK68NoUdQWafeA3j8qOn2ryDbrOswek7pZqGtXfvohAN6NANBiwf5bEOpMNe9S3ZjcHPTe3t75BzhROlMGZ7B+QLbW3ztoxXXC8qgcsjqUesR8tH1WE8rR9ANjs2JsAwNbVmcE9y+dbdQQ/RT0CZpyj67jw616dAsMqGOJZ8S3WAXQ0oqzM7b4qynPpJWcPUyJTzcqhENTOFsAX8Wo2BdMigIKnyh7BH+Nn+IB+I9Mx65iIAixPFd4ROTD6c+4ltKEjBhTX0MNKK6Z94YOuPMRw+gAEcvuR2EknjR7u7NC/BBA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(6512007)(2616005)(6506007)(53546011)(6486002)(6666004)(83380400001)(82960400001)(38100700002)(31696002)(36756003)(86362001)(26005)(316002)(66476007)(66556008)(66946007)(41300700001)(2906002)(5660300002)(44832011)(4326008)(8936002)(8676002)(31686004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MVBHS3FLMWl5RjMwdHdTcitxemF4aUw1ZytIRzhCZ2V4dHorY0M4ekVxa1ov?=
 =?utf-8?B?UXJUam44L3o1M1ZGc2xoQ05Zejd6MlF6YnZ5UWJ3eFpnZjdpU1ptOGxlMVJ2?=
 =?utf-8?B?QXRiTTJ2Ulc3Nk0wMFFhTXRsSXl2ZElHUXJGV2tqTlFSTFB0dldqeUFVVXZJ?=
 =?utf-8?B?dDYvNEJRK0kxUG5mY1haSGk3czNVMVBNNVhmdERXd1RGQktqbDFqUTBoUkg2?=
 =?utf-8?B?L3hBcHJwRDJWRTA5ZUMyV1oySFNXdEhoOGkvUCtPd0xIZ04ybWY4VUlqdWR4?=
 =?utf-8?B?QlVGZ0lKaGs3Qk1HSk93QVpGNHhGQnBCVGdGYWtsYXU3ZkE1VFFmb2Qvczg0?=
 =?utf-8?B?YnFVMFFRSDBubHA1c3dxTk1zS3JrOTFBUE5jMm5OeXhhR1NXVXU0ZkdSMDMw?=
 =?utf-8?B?S0I5QXg1UmFFeEp4UEw2aVhkWlZMV29iT2liTVRkNFhVSVBQRnYxOGJwZXZp?=
 =?utf-8?B?aDVaYVdQak90VlN4cnpsTnFka01NVGdTUmNzZUs4WmpvSktkVTFHVDRRRmRi?=
 =?utf-8?B?U1VUODJQRDI0RW1zQnVxdHJMZXM2MFpURi9lUXNYcHZFUWVFR0ZKYlVpRlBy?=
 =?utf-8?B?SlhwMENFOU55MkduN053RzIvaEk3emdaM1pzMnBlakhWTVA3RktieVJ6N04r?=
 =?utf-8?B?Ny9odmdReGU4c3YxMGJLcU9yVFhQWUFuUHVDa0VEcnA1ZlBOemxyYW5CelA3?=
 =?utf-8?B?VDNWNnU3Zzk0TEM1eS9LVEs5SFljR2hTOS9lQi9TTDgrWVV6cDJTZ0dBMU1R?=
 =?utf-8?B?cGxpR3lubVRSSjR1L2pueDBQMVFzOUExNzhJTy9ZTlZieHdOSDU5cjdnNW4z?=
 =?utf-8?B?bnUybzUzWmdwMGpGSUhUQWN2akRZZEdmbXpCTHRLcm9UN2xZYTBQS2t4eEVW?=
 =?utf-8?B?bVRLRlNJdGtaeVAvZE9MZjJWcGV0a3VYYzZLSVpleTY0cGgzS2Zld29BQ3pt?=
 =?utf-8?B?Sk1lOHNMai9wU1FTNDllbFZaeDN1SWFtVXhheGkyZjNNMDRucW1jZ25mOGxk?=
 =?utf-8?B?YWtYNVZCYTltdlhWVDNFRmRtd0lBRXRydWl5YjRGY3VQVlR2NjlMOXhzZWMz?=
 =?utf-8?B?QXZGdlNKb1BNODZzZGZ3dXd3eFJQRVVzZzA4NzExbDFIcVJoYlA5dkszVmdN?=
 =?utf-8?B?RHpncmRTV0kyTFUzRDhYQ1MzMEVySVpoMmpzcUlYRUdGM2N3T21aYW03aVVj?=
 =?utf-8?B?cEEwRWxETEVkbXIxaFRQbUEwRHFMT29WWUR1ZytoNE1ydFYxZHBHaEJKOHM2?=
 =?utf-8?B?U0tqck1LT3NsbEw5a1N6L0dpaXVhZDBRZGUzVWpjbjdqZ1A2cnVycWUwVVgy?=
 =?utf-8?B?cmxkcEhWSWU2MWJwY1FLbEZ5YzdkbVhITjZIS3pjOGFCMGtwSWNzQ2tFOWFR?=
 =?utf-8?B?M1d3anNPQXJkMm81dUlZS0JOUElLYS9YbXl6WE9UOFJQR3JBOE04WnpHZXhC?=
 =?utf-8?B?NSs2eFNsbVF2WDZxemw4c0gzLzRQTi9iaGNQR1NTcStUMTNWa3AyNXlNYTdo?=
 =?utf-8?B?K0JMOWxxeUw3RkNaRVBPeUM1enJmSXl0MnMvUlJ5UXhKaHJsTUw5T3JqUkVu?=
 =?utf-8?B?MkV0anM5ZmVleTNkTitTKzRYcEhwQ3ZMQnRtakxsUmZMbHpDM0Zoc1ZPNlJQ?=
 =?utf-8?B?bXIrVTZUYW9uQ2E5SVRsSEVTUXF2dHBYMGh6dHRIS2x6WU1CcGhMZ1B5RG5r?=
 =?utf-8?B?Y3lpTFN6a1FCbzVaMTMvZ1pmOE9IMXNNSG1BY2IyVy93dGtrWklzdUdmQUdy?=
 =?utf-8?B?bGZYcTJJMWxyTjhyRCs3c2oyL1F2bzVkbUp6em5DbEFmekRlRkMvQ3E0Zk5u?=
 =?utf-8?B?ZjlvYk1sVWVTSWZ6YW1ZbVVHbVVJR21GcWtFdmpIOUQ3TXlOd3d6YW9VTHU0?=
 =?utf-8?B?eWtyRE5jVDNpQ0dGald2djlQYnFmaWVnU2ZpQyttQnhqRUNIQmZXSzBaTDRy?=
 =?utf-8?B?ekV0Y09tZm03V3c0MGdCTzdxRkNQM2I3RzIvU1Q1MmhUc3RGQndoSnRuand4?=
 =?utf-8?B?bFp0ZHVGaUZmNk44K3JISWFlWHFhVjBoVjd0NVFBV01rNEF3TSttYy9lSkJR?=
 =?utf-8?B?QmluM1FLdlpHWTJJeEFIY0c3ZUNiTC9vQzNQaTYyRFlLYVQxQU91TU8ya2g0?=
 =?utf-8?B?Mk5MUitmQXVJVTF5aUhIWTh2UlBrV3hLU0ZlTTAwaXdxUlRpaktYTHJydFVW?=
 =?utf-8?B?amc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db446dd-84ee-4b77-8741-08dbb99cf1f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 05:46:33.5696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZgr/xzHGUakYcIl3pwZ5qHv+YGVffW8WNdRA0NB6KDYNjbfX6ABGCYd/A51QubqN4C6pfq2CoKgacl0zK1+vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3831
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Sep 2023 05:46:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13176

On 20.09.23 07:43, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> The filesystem images are not reproducible because the partition UUID
> values is generated randomly.
> 
> To fix this assigned fixed UUID value to partition.
> 
> Fixes: #77
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  wic/bbb.wks | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/wic/bbb.wks b/wic/bbb.wks
> index 6131c78..a797e95 100644
> --- a/wic/bbb.wks
> +++ b/wic/bbb.wks
> @@ -9,6 +9,6 @@
>  part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/MLO" --no-table --align 128
>  part --source rawcopy --sourceparams "file=/usr/lib/u-boot/bbb/u-boot.img" --no-table --align 384
>  
> -part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active
> +part / --source rootfs-u-boot --ondisk mmcblk0 --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --active --fsuuid 1f55d66a-40d8-11ee-be56-0242ac120002
>  
>  bootloader --append "rootwait console=ttyO0,115200"

Thanks, applied.

But at that pace, we may see many more such patches. Should be do this
once now for all our targets?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


