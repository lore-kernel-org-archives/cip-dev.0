Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1865DC6379F
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 16:22:39 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.54])
 by mx.groups.io with SMTP id smtpd.web11.19043.1676305351203400955
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 08:22:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=H0p9vP7s;
 spf=pass (domain: siemens.com, ip: 40.107.105.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XsBDapWX5CXnOVPrP9CVp4Hovpw4V66VqFQ/atwzB7fL3rsRZZgNbL9RkuRvwN4pcbzLzGSIx3GvxLbUO4CZZO+TomzIjb1PHKhibEoS5LYCTqg5/tGXN/nmFv7CKuJPisRs71BLjhaRbNpxFQf7NXQEhpSIVQzD9GPlU3ATQcPURxCQZVoPjrQHh76jr/Mg5U+KmnRmwOQJqOOL9Iqi3MrQ186wdVq55Jy4HFA0XR8quOhOLMmymQtjnVAxaAYd5dASPRs77AdErv/vUd0wCGX53mnY1X/C+qbQIAy90UPTcUX/L6vvpXpsMwSmi/jKWbdy5M9JFCFcA3Mj3ipvrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f876d4b5zofn5w6995adqR4OWQW1tw1vYrX5lFX5sDg=;
 b=KfekD+xlQo1+MAVS837CwiXYE7vaUWMZCtd+wF1bTi0yYQimRGl6lf+sp30XPKI5pKwvHeMHQv9VdwaJhxIuQv7VxYowIqGIKpHnrxjT7gbk77xCSfCC/WNuhTkICvrJPvMQl+34nXSu5zRcoMoJrglx7km9qp2jAsFtiTqA7Ep0/ffDYcBAcvYoul/ws5fzYEHEZtiXJmfwppDS7JODyRun5lcyNagiI7s/fCfYhrJQx6ybXxmGPj8+ozipnoSRfAEFlBLJXsCBAeG7zdXq11+DVVmg9yamE8+1SVQjIi77SyWTDtE+gAh2XhPvOxZiCoHEoErkkuNhUsGfUml9OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f876d4b5zofn5w6995adqR4OWQW1tw1vYrX5lFX5sDg=;
 b=H0p9vP7satKO1GM//agiLFM4gt+omXb1ZpgKmc/ICwBH7FbVvBdx1436c+6s6A93GcGvWpGW4/ZHnOb8UTj2RPe+Ap0sZcv/YEB+UJXHUoDAH4OU8mBrXT87KHZey8AxFXDEQgvNGhw+w795E2N3PvYpXcbarZHEO6qo62YEsrLmB1qxoqfZuQfUPfjGeUHazGh5vhVPjqoqEiGM/rJRGkaFvQnPnbaG7rxV+mS6YN2KkzPRahx/WmYby8Hez7iGXBRLyvUl42M4FuTawaUC2W+4pyxdcuie9GvR2jMz24yYjIZvoQHmwA7SsEgT+xodYKXfKMQWCngHeL2ZHr9gsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4095.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Mon, 13 Feb
 2023 16:22:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 16:22:22 +0000
Message-ID: <a38e6230-7c0f-f03c-d2ba-fe888e43a72f@siemens.com>
Date: Mon, 13 Feb 2023 17:22:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH 3/3] wic(ebg): add support for riscv64
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Bovensiepen, Daniel (bovi) (T CED INW-CN)"
 <daniel.bovensiepen@siemens.com>
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
 <20230213085741.1242658-3-felix.moessbauer@siemens.com>
 <938b99f4-a7c9-ed00-1005-0b2f0a489fbe@siemens.com>
 <679d812c0080ab414f9167b00abed1fc080e897b.camel@siemens.com>
 <ae5644ca-b817-23c1-050e-01aa3f0eb171@siemens.com>
In-Reply-To: <ae5644ca-b817-23c1-050e-01aa3f0eb171@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: 4854fde1-e427-42fe-9f43-08db0dde7c1a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	xa3NsXJMU3HYxHZpu/F7SLyxnzlfEHxtu2nvw/GHJX3C5KQEFLuIDr4eST9IOsb2/tOyL32yhzSatGDxGj5T9TRJfGixHXI+qOsHnZLQMqisC/6dUWufuR84eW3jlWug9PffSIV5X149BCvTM7uJXJzgolgeB9AY88oH8Kl1eLNyP5LNV+Nqw1Tk+IXjU0JJbBu86EQaFZLT8P+o0VQuwVYcanjDN/Mo36hLpDwixPufdqxt5VreHWavYXj5iQLiCbYpE74Udx+4TGtRree1zTlvE6oTiOiTfZEL/OQq2RZqnrFgWaexWNPi3ZRV7KWZ+ILrVRnnc9nw2v89VnxcYylKMzvEZ20xFkgQdxAlNQQLIyJScnmB8OtlHyVO74D6vR9ZkCsTDegiGd9GmPUsvTf5HmYPpwTxCcdm5RwmtaTL7RgsayLvI6EeA7i3vEAZjbeDvZD6xdC6pbg086EhQetOhWn021z12oKkrGo0mTiUL0ZbEvJY52BLiRYTI2W2NHGxpM2F8WEsYx9q1gwTLLweGSj547PwPn/vPlLubUr9i6cPvLNl7ZNDABfZAhV1ESGRzOwwgOl8LF+e44Ub3WbdF3hCCR/eoOnnUqjA5l+JJvn/J55h30AtSv/TxMKgUjU8jeK68BpIbs41M+CjGoGmlKWyWlfh+KG1VCauD+ve1zzwDjFpq+ivvHc+olqS30mZM/s9WL4/MRZ0oxq25NjnqHwxTv+aX4/Cvdgzgdo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(6512007)(6666004)(44832011)(186003)(26005)(36756003)(6506007)(6486002)(478600001)(107886003)(31686004)(53546011)(2906002)(82960400001)(8936002)(41300700001)(2616005)(5660300002)(8676002)(4326008)(66476007)(66946007)(83380400001)(66556008)(86362001)(110136005)(31696002)(38100700002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXk1ZEYyajd5bm9nVGNXNHhwWENTUE93S2x0c1k0RFFpSzZvZzZ4cEtGQUhs?=
 =?utf-8?B?ZXptUFFEV1F5THhObHl0T0JRKzlEdHdhVStzWVlQMUFRLzJScThqUGVMVG40?=
 =?utf-8?B?SU84YkZ3aUowWmw0K3g2Ykg4OFlsSEMyd3pQMzBYQ1VOZ0ZEeTF4eDRQSTBI?=
 =?utf-8?B?bnZsZndLelhPWHRCYWpZTFBZWVN2Y1lDejRVSVJEa3ZQTXIwTmNpM2QrTjB6?=
 =?utf-8?B?K3paZ0dackdETHJ2dm5UUTh2cURhQXlWSUxhSWtwZ3VtVG9rbXJkS2VKaXg3?=
 =?utf-8?B?UU8yZVdaTkpmQTBTbittUlIyZ2QvMno5bFVTSFFWWEpNbjVoQ2tnREExaktk?=
 =?utf-8?B?M0EvWG9BRVFUL2RLejRJOVpsUHdoS3RkUmo2UGxwWVhROC95TUxidngzUXhD?=
 =?utf-8?B?WGs3bVlPdWV0Mnd0b2o4WEtKeHprT28xbjhWdHd2UzZiU0VEVklWbTl1K3BH?=
 =?utf-8?B?UlQxcWI3S3ExakJaTUs4c055MnZLN1dCRzVXZGorRzE5Y0Z5cER4MU9vVzNw?=
 =?utf-8?B?Q0E5eHhOMENrb3ZxUi85cDk5RWtUc2RMU1doZXhDZHhIRDJ1cUh0eWdxMnEv?=
 =?utf-8?B?MVhldVdTQ3dBZjdNcUt0VDZTTm51YmVtRStiWG5neGZ2SHVOMHIrUHBqbko0?=
 =?utf-8?B?bU1oZ3l6YVp3OGhtcGVmM1FrZGNxTTV1M2RoSW9taEw1OEhtYlVaZ0EyeWsz?=
 =?utf-8?B?Uk9JZVAwSWZkL05IbERoVjQ0TzZVTUJ3YkZiUlRCY1l0RGF6RXp6R2tobkx4?=
 =?utf-8?B?c0NWWklYWGE5MFlHQTVmNG5NTXg0SDB4d3JEY2szcnovMUhpd2tEdWlUMGIv?=
 =?utf-8?B?SkkxV3dPYmNoNGtQMGZBUEZmdkt6WEpiSElROVhiSkUrTWxLbUdKK3RnbFEy?=
 =?utf-8?B?UUZnODlaRzlSdWU1TitDekFDc1dOODdxeWRvVnhlLzVpdW0xUWFrNDMrWkpQ?=
 =?utf-8?B?Z2ZJMSswazRGVG4wSmcxTk9ReGxrMTdpc0YxYmtSNDlRbmhXSm54eHVhV3gx?=
 =?utf-8?B?bkt0a3JTWE9JRzZ0RUNKNDEyR1VQQThqeUNTc05zRlZubjNpZThOSitTTyt0?=
 =?utf-8?B?VkRvOFhkTmpIZkR2Y1dxSTQxcno1RzhOaXQzSjc3OTRuKzlpU2tKa3RBa3RT?=
 =?utf-8?B?bGJ6WEZZNnhueC9aQytVQk1Ldm5TNTcxbkY2ZE9BdFVrQmNoY1BucU14QjZx?=
 =?utf-8?B?YkRJc3BEbjYwa0EzeGFDb1Z6b3dldWRZczczdi9ldG0rTVQvSFZ5bjJ2ZEwv?=
 =?utf-8?B?VEd3aGJJUjljY0VlZk8rQU1PclpMbnZQS0tnUldwOFFReW8rRzNpUkYyK2ZS?=
 =?utf-8?B?UkE4MzV4QURWV1lIb0Y2NndUTFR4cUdJK095N3ZpeTVKRDVmZS8vajdRazRX?=
 =?utf-8?B?Qk1sTjB4RkMxRVpvRHJvNHRIQmNWV1VBeXJHK3VGd2xrc1gzS092dHdBM3Z0?=
 =?utf-8?B?enR6WE9PNGpBTzArMm1VTy91eXZDYXFCN05IMmIvUWFCYjY0SldVaHVxR2lL?=
 =?utf-8?B?RXMxT2traVVkcUZXU3M5YzQ4cTU0UHZnWDRMME1RZWtCTG1qbDIzOVRIUlhT?=
 =?utf-8?B?NGd6bkJ0Vzl2NXkxSDNmQTlqeWJLMU04RE1pUVhoTDZmZnB3bElldUlQMHZL?=
 =?utf-8?B?Q2E2UVFvYjlZVTc0UmpwMlZLelpvLzJaSEJLYlBwbC9nYVdOOGFDdm4xZjdX?=
 =?utf-8?B?OVBRZHIzcDk1NklLYmxrYXU0U25ITlI5TzRzalJvWmhQb0xOR3FDS1RqbXF1?=
 =?utf-8?B?YVBnanVjYkVvRTR5SEp4eXhuU0F2czdVZFlaWU5nVDZQaEpjNk55Y3NId3pY?=
 =?utf-8?B?Q3VWNW8reGdvVEZOWUlFaUFMUVpBK1pXT2V5eHRNZ0tGZzVwWFJVandhM250?=
 =?utf-8?B?am90Nm5uWDRMN200WS9XdHhZKzJhU2xrb3BvS2phcU5RZFRSS016VXBaVk9m?=
 =?utf-8?B?RnN0RUpDNmhHNXZRRERmMG1NRmg4YnFMRVR5ckZQU0JNVkpUbmRkZkhjV1py?=
 =?utf-8?B?cUZodlZ3eGd5QjA5aVh0eDFpK09xNXcwSzFvUjg4YTNaSzhBME01OG9RRmo5?=
 =?utf-8?B?VDM5RWd2MWhEWWpCOW5lUkFJWTZBNW1Xa1pMc09DRHJtUXh4bFBLanF4dEpO?=
 =?utf-8?B?NWFMUHhuQ21uZFdSYzROZUdEb0tpUlk3WmNXdFJ3Q1p4R2xWS3pmbmZaUS9X?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4854fde1-e427-42fe-9f43-08db0dde7c1a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:22:22.0171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VDDy5tZCoyCEanvjYSXG/EcsIUMxDoR4sycl3cwosf3H7gWOEcY0p3zNa09CmbKVYzvHmpjz0PmFQeJ/zYiOIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4095
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 16:22:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10686

On 13.02.23 17:21, Jan Kiszka wrote:
> On 13.02.23 16:15, Moessbauer, Felix (T CED INW-CN) wrote:
>> On Mon, 2023-02-13 at 15:45 +0100, Jan Kiszka wrote:
>>> On 13.02.23 09:57, Felix Moessbauer wrote:
>>>> This patch adds the mapping between the efi architecture and the
>>>> distro
>>>> architecture for riscv64.
>>>>
>>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>>> ---
>>>>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 6 ++++--
>>>>  scripts/lib/wic/plugins/source/efibootguard-efi.py  | 6 ++++--
>>>>  2 files changed, 8 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>>> b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>>> index 3d6b2d7..0de28ca 100644
>>>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>>>> @@ -185,13 +185,15 @@ class EfibootguardBootPlugin(SourcePlugin):
>>>>              "amd64": "x64",
>>>>              "arm64": "aa64",
>>>>              "armhf": "arm",
>>>> -            "i386": "ia32"
>>>> +            "i386": "ia32",
>>>> +            "riscv64" : "riscv64"
>>>>          }
>>>>          distro_to_lib_arch = {
>>>>              "amd64": "x86_64-linux-gnu",
>>>>              "arm64": "aarch64-linux-gnu",
>>>>              "armhf": "arm-linux-gnueabihf",
>>>> -            "i386": "i386-linux-gnu"
>>>> +            "i386": "i386-linux-gnu",
>>>> +            "riscv64": "riscv64-linux-gnu",
>>>>          }
>>>>          rootfs_path = rootfs_dir.get('ROOTFS_DIR')
>>>>          distro_arch = get_bitbake_var("DISTRO_ARCH")
>>>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> index 2d16fe3..d6cdf0f 100644
>>>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>>>> @@ -56,14 +56,16 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>>>              "amd64": "x64",
>>>>              "arm64": "aa64",
>>>>              "armhf": "arm",
>>>> -            "i386": "ia32"
>>>> +            "i386": "ia32",
>>>> +            "riscv64" : "riscv64"
>>>>          }
>>>>
>>>>          distro_to_lib_arch = {
>>>>              "amd64": "x86_64-linux-gnu",
>>>>              "arm64": "aarch64-linux-gnu",
>>>>              "armhf": "arm-linux-gnueabihf",
>>>> -            "i386": "i386-linux-gnu"
>>>> +            "i386": "i386-linux-gnu",
>>>> +            "riscv64": "riscv64-linux-gnu",
>>>>          }
>>>>
>>>>          distro_arch = get_bitbake_var("DISTRO_ARCH")
>>>
>>> Now, does the swupdate image work with that already? Can we enabled
>>> it
>>> in Kconfig then? Or are there more changes still needed?
>>
>> Given that patch 2 of this series is also applied, this works.
>> It has been tested on the StarFive VisionFive2 board.
>>
> 
> Great, then please add patch 4 as well ;)
> 

...targeting qemu-riscv64, obviously.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


