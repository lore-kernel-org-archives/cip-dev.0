Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCF0C46CC5
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 13:46:43 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.81])
 by mx.groups.io with SMTP id smtpd.web11.8495.1702302395531528882
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 05:46:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RMG7iWkH;
 spf=pass (domain: siemens.com, ip: 40.107.22.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKUONqeNGQDq//jKOHPuUJbj/A07jMR7dYUolQi7bvw7rrZE1yN4303Ek7t27WB1DFjWlpniQKMgECffjNlTqFeR1N7O1jBVE1OaQwzzR1J0kaPabRaMVvAI1FbqH2SzYW0I/7X0F9PjmcjsloFOXzI/gP2BzwKGyJa8YvPwCuAt77oNVuyQ6ToG3IpB3KjtDQTdLB4MllRdEfRLhXrBJ7MkpjvkcO2DZkxsrIUf/CGBr7zOdsxdkcbuNc9wDae99yD4nAyIhckGmZY9jJ5S4w+wIE4F1upK3PnD3ZJmIfjllD4qsdN/pZBRP/nhCjmjsJcTYJzpbb3RIbZFa/ypGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW3jhHoOVLM6o7sWKPXW/ClJ1f9jm7qFNe2dZvF7wYw=;
 b=G/+lSTksgwUC6TZ5xrNABuGVnHRfUIQy6TL7H8C01sSh0oKXjZAL4UGmqw9dDEeP+2ey3V48ya1UlXXvOqb1DZsQX9ObfRMG80hCo53wqk3uwjGoTSKsXAqx5+AM1qx1VpL5kpDrooJRlSP8H/mdXODER9YOxYqDH8GAMlKChYo7dzTKfJOQI6GPbj0AEE/jm63c978hSGWwjJzvGBwg9echzZ4Hb9Pl0NT4Z2btnllSDE6Tgtceprvkbn3+UryK5MEkc2WF4aysPvUB6QgtN5Ezl1j75RO+WPUY/EqCebXALI46V6N/9Y+J3YiXwX0mrV0fni3H3ZK3W66hDCodBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW3jhHoOVLM6o7sWKPXW/ClJ1f9jm7qFNe2dZvF7wYw=;
 b=RMG7iWkHM8KGrIZu9mIXnNOJ1mQfqSwGIrz4dBphfLQO0Hc2JMFUSgiL3Hqg0SOmOxa7jqNUXv2TJ6uudLO7e4SjzT4wKk93vvXOT0iFxaDNZmUy8h56buV9hNIJ98ZsgwOIL2CNTngpeTkkCodqi//zhwtCG6xiSqpLCgICWcq8zeu/74jxpuubnEOB30RnAapyDT9J+bj7vVmomuDH9eiB0bFNrUZCZojehdcESfCHaxr2C0a4PkBG7h/govF8Vy08ASHzsc0KG0LfNl1l1m/5PMJ3WtKsD6iI/2XWyqZUZw+S1smS0TMs66EQhXFevqVZNlgOs5PCDj+xJsF29A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5379.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:334::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 11 Dec
 2023 13:46:31 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 13:46:31 +0000
Message-ID: <b53a426e-b5f9-4ba7-b76c-e4020ca1a1b5@siemens.com>
Date: Mon, 11 Dec 2023 14:46:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 3/3] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
 <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
In-Reply-To: <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5379:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f06e991-45bb-4bbf-00ca-08dbfa4f94c8
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+VevteYWdImtQCp1LgeapegT7hsSrxFpPOyOt26oAVdifUfKfgCJFyFB55uIV0eLKRlkEQyB63S6yR+1+BSI50Oy/XTz9iuqXWkRkXNDW5vzHnjFNHXMSFKDY9bcqTAJJpccFJRImtXoVH14ukXSBD7as4PBUdm+rA2ykpMhzg+ciA2bfgxbl0qOoq7Npq06p3oy7P107G/b1xhdSlzU5sl1p+GuwrHCHw+TMu4ldZ6ov66vrxLxE1koCz0QVTfxaYXV4D/h6q/r5PJzbJldYqbQrTjaqeud9yJ+UhOd0vX65/Dwueiec3Qa55YpQxYWwsWU5tAi0dTY8qg5ITdPvmLihiG6Lsjkv+g+SGFyYttTKjyE8K2BQMmaPoAhvIYtz+D60KaunddOS+xoS+oxX9C+bQNRFukx88/rI60PGQQT5V0lGYWW+x0e1BxsJ87gSlh/E53RK2N7E6NNUxhhy1I1a+WlbUXGzozoreGLybRsyni8PgyrTbQzrRXe2uqu44rHGwvYTXXBSTz0paJRNFFCVZ33CnxosP3FUkVyqGokL6nisdKvGoK6CTvqovG//ucE9Fye2+8ATDfkfMwI0/p/pJcumbZ0X1QBQ4IN4EhdJeXIjtWYJkVE97pQ9mDinAABEDc6ox+/GReEumDw5AH8UrJyfB7q/U8RSiEL/K8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(6486002)(478600001)(6512007)(53546011)(2616005)(6506007)(26005)(966005)(31696002)(316002)(66476007)(66556008)(8936002)(86362001)(41300700001)(66946007)(8676002)(36756003)(15650500001)(2906002)(44832011)(38100700002)(31686004)(5660300002)(82960400001)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?KzRUejVkKzhRVTVkVXRYRlF2d2ovNURBYlJ1SittYjBmRU1NbVBaZnZMa0Zm?=
 =?utf-8?B?aTNsNytsdlF4SVl2RVQ0QUowUGhkMjVTd1FSejZDY25ORGx1OHE5Y0NIMlNZ?=
 =?utf-8?B?S2xTem1tYmZpVHdyd2UwWGJWd29Sa25tYmp0Y1BXYkNGYUQvRGpwdXdVY3c1?=
 =?utf-8?B?SWhIaU0xL1VyZlA1dmpHV0dtVnJldElzYkFWaFV0bDhWVm9LZ2tsNHJ0clg2?=
 =?utf-8?B?YnovNTNGcmQzb3k4ZWp3VFkzcWM1MGE3T0hqMGV4OUVIMnlhVTFaMXBGSHQw?=
 =?utf-8?B?RWpZcjZUVTlGTkpCSFJPODNiQlplNjYxb2xQQWlnell5aU10WmFyNTZLYkJW?=
 =?utf-8?B?WnMvYjdLdTZqdEExWDdiOEdwU0xFQmNnek1OeGdZTEJjdThzOHhKdEtaNlY2?=
 =?utf-8?B?TlFEdWlNK2NSYTQxWjNDNkxZRlByMWlSMHQyYlZ1VnBuTkJSN3hvOUp2VkY3?=
 =?utf-8?B?TDRpWHVQUGFybEhXUThLa0NqeGJVem8wOEJuQ1RsVmJCNUlESWloeW1lcytZ?=
 =?utf-8?B?Zmo5MlRiUWNzei9mNGdOWk52VlBlbXlnUFBwVXVMc1hoYnBwYzZSN0FaZlk1?=
 =?utf-8?B?d09OZU1tMFhaSUhYY05OazNxUU5lZVMxbEVscU5nWVFsM2I0TVMxR3EzMmRo?=
 =?utf-8?B?c0pkaWNzRWtSVGVIY1VsdTZVNGR2NS81YW5IWVppNUlHd3FUM0pqN3FkQnZK?=
 =?utf-8?B?NjhHM1ZDTm5xK2dqT2VncHNGY0lhUGhlUFFIM2JJT3BpUm9IdHlxOVFJNHVD?=
 =?utf-8?B?N3ZDNVNGOGZGYjF0dlBaWnlEQ1h4OG8yK2VrY1JNbENEQnRLWjFjeEZKK0Yw?=
 =?utf-8?B?YUlqeWhEMzFSUmxoWW9ibnpvOW9Odjd1OERXRU1pWjI0NjF3c2YzVEJ4Vk1w?=
 =?utf-8?B?Mm1JYWpnUjh6eXlPWHdoSkh0NXdHYy9zLzlxRHRjTGR4MmZhWlJ5MldhMkJn?=
 =?utf-8?B?eldrY2RFV1ZaSnhSVmNQYkRwUlhxQjRBaHpTQVhIb3YzTk5DajRlMy9PcUc0?=
 =?utf-8?B?dk5LdW50a2M1RUdIamx1M2dNWEFrR1JlL3F1L2JTRGh4VkNjTkJMRlpBS3hh?=
 =?utf-8?B?QUNFL0QwTDZlQXFqTGN2T3BCeld2WE9LZ1FNK2RwVzVUclY5UGpvbmpmTUFO?=
 =?utf-8?B?WW9scjFOTkQ5bE02K2xoM1FpNi9WK21DcXNuWC9IOWsvSDZQb2dpeUdnZ1Y3?=
 =?utf-8?B?RzZ2K1ZVOG40UjZ6T2pYTkdCUE13d0YxOTdvRG93cllIc0JVcDVhcmtUUnVR?=
 =?utf-8?B?b3ZoK1R4cHFMd1JjZnFiTDhQSUgvRldsa0JiNUo2ZTY2UFIzTksvQjdSQlZH?=
 =?utf-8?B?dXlWeHVyTDhLWXQ4TXVjM0xCQjZlNGhxMFVBTnBQZGR3MHRDSWtuVXFRcFJk?=
 =?utf-8?B?N241bUM4c3hxNGhaSUx4QnpRUEE4ZDlQWVVkRW90MU5FNkREditSekdqRzM2?=
 =?utf-8?B?cittU3dvN2RSUjk0RW5senhIRGlPQm9rdzNEQmd5TURPcUszUVRNSnBHODJ1?=
 =?utf-8?B?WEh1VGg1QkxSWVovbmovVk1MaUlnanZLN1ZiTURySVpLWkFsL1NsaEtMZ0U5?=
 =?utf-8?B?WExoeW42OGlIQ3ZTSkFKdEo3Qyt1bGgycWdXYUo3bG9JakxxamtCVWdTYW9D?=
 =?utf-8?B?RFdkMllCcDlTYVpWellrSU5iQjgvaXpaQVR6dWh2SGRicllmeDRtNlgwaXRI?=
 =?utf-8?B?MDVLSlJVQzVWN2ZNN1N4RG80V2YrQXpkbm95YkZtZGJNOGdzajVGQ1BqaTB2?=
 =?utf-8?B?K3M5d0w2eG1pRTMvMGZDdVd2dk5wMDlUMGxTdmJ5UXNldjFOczlDLzBSaEpE?=
 =?utf-8?B?S1hEd01pVzFOUnFUdHZQRFptRTdJNUtqeXJxZzJtQVVDYUNaMC9wTjdXTDha?=
 =?utf-8?B?U25JbGdQVHNKaFNwVmV0Ui9XbGpuaU1NdWU0VGN0cjhHRUJHblRlZ2prcWNI?=
 =?utf-8?B?U3V0bzBDU3cvc3R1NkpJUmQvMlV1aDl5NjE0WmlUSW9NNkZXMTUzR0pCUjJC?=
 =?utf-8?B?eFRSMGZxVTFwSlFkWittbjBaQ0dyeXQvd0ZuRUtnUDNSVVRDS1Zwa3A1Z0pC?=
 =?utf-8?B?MnZ1VDVScVFFLzlOMzRncjgxTFZaRDhCT1RiNzM2bEdNWHhxNnVxK2J6ZnR1?=
 =?utf-8?B?SVcwaEdzZTV6UmpRbGI4QThWMFFacFJiZDN4QXJXSU1CK0NVWGg1NTNIaGto?=
 =?utf-8?B?dUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f06e991-45bb-4bbf-00ca-08dbfa4f94c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 13:46:30.9919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1F83oxTwwhEH8Dc9LijdLOXYgoqXxNoz7opjR2qfQ2vtQVrMJux31XtgeWqXOLtSvk9gHUFXN4+0N1kqEhHQRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 13:46:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14025

On 11.12.23 14:45, Jan Kiszka wrote:
> On 11.12.23 13:19, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
>> element is added to the sw-description to replace the ebg.
>>
>> Use python as newlines are part of the sw-description syntax an
>> therefore cannot be hold in a bitbake variable, see note in[1].
>>
>> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
>> support atomic writes or renames so a powercut can still corrupt the
>> system[1].
> 
> "system[2]".
> 
> But you are not implementing option B described there, just the even
> more risky option C. Doing flushes before the renaming and after it
> should reduce - though not eliminate - the corruption window.
> 
>>
>> [1]: https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#line-joining
>> [2]: https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  classes/swupdate.bbclass                    | 35 +++++++++++++++++++--
>>  recipes-core/images/swu/sw-description.tmpl |  2 +-
>>  2 files changed, 34 insertions(+), 3 deletions(-)
>>
>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>> index 0e95e3c..99a4c6f 100644
>> --- a/classes/swupdate.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -21,7 +21,8 @@ SWU_VERSION ?= "0.2"
>>  SWU_NAME ?= "cip software update"
>>  # space separated list of supported hw. Leave empty to leave out
>>  SWU_HW_COMPAT ?= ""
>> -
>> +SWU_EBG_UPDATE ?= ""
>> +SWU_EFI_BOOT_DEVICE ?= "/dev/disk/by-uuid/4321-DCBA"

Oh, and where does this UUID come from? Is it a wic default?

Jan

>>  
>>  SWU_IMAGE_FILE ?= "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.swu"
>>  SWU_DESCRIPTION_FILE ?= "sw-description"
>> @@ -48,7 +49,9 @@ IMAGE_TEMPLATE_VARS:swu = " \
>>      SWU_HW_COMPAT_NODE \
>>      SWU_COMPRESSION_NODE \
>>      SWU_VERSION \
>> -    SWU_NAME"
>> +    SWU_NAME \
>> +    SWU_FILE_NODES \
>> +    "
>>  
>>  # TARGET_IMAGE_UUID needs to be generated before completing the template
>>  addtask do_transform_template after do_generate_image_uuid
>> @@ -84,6 +87,34 @@ python add_swu_compression(){
>>          d.setVar('SWU_COMPRESSION_NODE', '')
>>  }
>>  
>> +SWU_EXTEND_SW_DESCRIPTION += "${@ 'add_ebg_update' if d.getVar('SWU_EBG_UPDATE') == '1' else ''}"
>> +python add_ebg_update(){
>> +    distro_arch = d.getVar('DISTRO_ARCH')
>> +    distro_to_efi_arch = {
>> +            "amd64": "x64",
>> +            "arm64": "aa64",
>> +            "armhf": "arm",
>> +            "i386": "ia32",
>> +            "riscv64": "riscv64"
>> +    }
>> +    efi_boot_loader_file = "boot{}.efi".format(distro_to_efi_arch[distro_arch])
>> +    efi_boot_device = d.getVar('SWU_EFI_BOOT_DEVICE')
>> +    swu_ebg_update_node = f""",
>> +    {{
>> +           filename = "{efi_boot_loader_file}";
>> +           path = "EFI/BOOT/{efi_boot_loader_file}";
>> +           device = "{efi_boot_device}";
>> +           filesystem = "vfat";
>> +           sha256 = "{efi_boot_loader_file}-sha256";
>> +           properties: {{
>> +                atomic-install = true;
>> +           }};
>> +    }}
>> +    """
>> +    d.appendVar('SWU_FILE_NODES', swu_ebg_update_node)
>> +    d.appendVar('SWU_ADDITIONAL_FILES', " " + efi_boot_loader_file)
>> +}
>> +
> 
> Unneeded newline here.
> 
>>  
>>  # convert between swupdate compressor name and imagetype extension
>>  def get_swu_compression_type(d):
>> diff --git a/recipes-core/images/swu/sw-description.tmpl b/recipes-core/images/swu/sw-description.tmpl
>> index 6b53a3c..c52372c 100644
>> --- a/recipes-core/images/swu/sw-description.tmpl
>> +++ b/recipes-core/images/swu/sw-description.tmpl
>> @@ -34,5 +34,5 @@ software =
>>                          subtype = "kernel";
>>              };
>>              sha256 = "linux.efi-sha256";
>> -    });
>> +    }${SWU_FILE_NODES});
>>  }
> 
> Jan
> 

-- 
Siemens AG, Technology
Linux Expert Center


