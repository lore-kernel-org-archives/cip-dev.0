Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF9C8C433EF
	for <webhook@archiver.kernel.org>; Tue, 24 May 2022 15:23:37 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.87])
 by mx.groups.io with SMTP id smtpd.web09.10696.1653405814561292028
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 May 2022 08:23:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oMPyfu8k;
 spf=pass (domain: siemens.com, ip: 40.107.22.87,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxkaWRGwtl5WRJe0Gb0xjLSj1HMIkOLwGgthKB8RrE/M4iTulnM9b6UGOf+26KttrpIm6pwp1SQx8vUFLOb/IPd5FKxfgEQwuVxa+HkTVzevpt162SdUh7aMWQR12M5aHY7Z96xmUFK1OjQmqEDpojhdXQPRMQK5rFdWEUYpK244wGYY3S4iPpAYi2C0ng3iRezsNFomSiEDTgTXhQ9Z7nDxeWlFQ1H1bdIRRF28541BmL9d0jNJr6aLWmsShHQ6z2Tz3k2w2HdsKtdr9cUAMRrvD5ir/GmmheEMzFmgyPkopmBcAw34DjVrzzKgaetRQGZXax/bkKL8ppJNEL5HJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KNI42/o15FvpdTztav05y4+xFUs+5TGekaX5QoI2BQ=;
 b=HZZVUe578e1tMnQetVZz5oAIoB+yNREtEdVmLiJwy+X47R7xBogsiN0FyyHuUDyM5WYFrxuI6BE+1In3Mkbe5KofzzuYNt0j65EZuTHu4ypQ2NK/lS3ClBY0b5eofVD+tPbJeQngyegX6usQA1xUXwJGwJpbKCP+Tp3bsKe43/uJTqQD/k9jZZMUTFqSU1WltQbqhpsVXq1BVWMyTYlxSIh7Da3b9wsEqn70cFPX/am1YYqID4bfgSbiZ5HmxZONJ+VhNk7XydcDGYe1f0vAipW3/NJsiC5P5YaU2AbXuqoaAU1dR8cdj2ZB9OGWlhlOUJqBzaKhprKGOUTWb3Yzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KNI42/o15FvpdTztav05y4+xFUs+5TGekaX5QoI2BQ=;
 b=oMPyfu8kCtFaIsbRXY65a7QeZc1R4gO6ZinMldickLmjWDqvjA7CEbNLyxcGGY6EHP7iCWWyHiVNAzO+ezkLWCey0S62iqj+2bqHGreFmedDYCfKkBs4OFn1DUWTHvdxBed1RlBQvBuXc4Sx9dMcMSh6RygAsp7jvFzkbHtC8XtJxDjg0DPYegKmdSuucvAETZZUY8oq5muzN+gXDnRk5hNOUn3DlDUahqdEEvEvjD76YCnvA1tns9KC5WFM93fzaWZfcYAt3OfyAahI3DPd1exzaQRnxmd4TDd/gkq53ogKd+vkfaMgYG7ysvrRfPftXKokS5wGQE4mPQ4k+NpYOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB6004.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:39f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 15:23:31 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e%2]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 15:23:31 +0000
Message-ID: <17b20d92-af97-5598-8733-f9c625414394@siemens.com>
Date: Tue, 24 May 2022 17:23:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
 <8827c44a-366e-59b3-8062-d2d4b1dd47af@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard-efi: Use correct
 search path for the efibinary
In-Reply-To: <8827c44a-366e-59b3-8062-d2d4b1dd47af@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS8PR04CA0064.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c27d3f05-cec6-470b-5f4e-08da3d995c35
X-MS-TrafficTypeDiagnostic: DB9PR10MB6004:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB60049BBD8A444F10F8DAB1F081D79@DB9PR10MB6004.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/kk/5x2o151yPN+50YK9ip3kT9fhRpxrXgsSOfNJ42s11B7pMBvjnWH3pp0AQzE92x3STbdBkhcdlgX5wWqK46ageSqqNBIFEJd3jB8+9ZXUIfUN5QjcXr7+Z7VdvbxcUGZcsFkve1elrwa6U2dhjgvfYKzq/f2xE9vehqFQgtsElFMvqPykt61o8Gt6N5R2RGuW7164YRLNAiMs2rKrHTWzhau9BkGX/+R3DDSwZ6n31YL4wccAMDq7XO3bU5tSbLXJUnyxj31p5eyozNJI/Z8oWseYB1ATZq7m5MPJXYgtZpf2/ISYMGIwoLv6cgzZn7XWgrg2Wc7WNngoIRyxlX+5fxOPj80GyQTVIGFs26R0ypykpqtd+r0WAnJ62asxnTzS3zlJxL1CZbf/7POhmvgmvlddo+KIYOVc/MqM77uLyyQpXY4WVPIuZF+doboYdB3BDUoQbHGCV6IuNIXzhndqv4IZNSSZ1r2lgXsDZkuVWrFiOVNWApyckxzApjLnWHBtaHGmU1DRVIjUfvQ8rgLAQUJ3UORAc5PI20rrWxGI27gPyZkbIrJazJyPGTnPULVVSLeOB+Kja4UrbJsbIDn4rl2Z054NQdF7EbgfadjWWHpBEcLGcLj3qFsHg7lRd6NUJ/Kb42JkyP8PS0cDBIavAA1kuPxsFjcFQrsv66xbM73shLLiemlobjuTx9Dw1PWI57gHQvrNprAyETMHDWzjME8yq3aODirPHu22liw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6512007)(6486002)(66946007)(36756003)(66476007)(66556008)(38100700002)(53546011)(2616005)(186003)(6666004)(83380400001)(5660300002)(508600001)(8936002)(36916002)(82960400001)(2906002)(31696002)(316002)(8676002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0lSaC9nZVFUMExHR1VNMnZBc3FHOXVXSFM3QUFISllVcnUyczhuSktiaUJU?=
 =?utf-8?B?U2IyMHZld2MwYlJhMU02djFqVGVrK3hGbnQ3bEl5Y1VjNnlPUTF3N29WK1hE?=
 =?utf-8?B?WnV2OE1VMkc5bkRxYS94VkpWdGRxdkVaZ2tmcGExTXlaOWFjdmo3WVZ5K0pS?=
 =?utf-8?B?TC9rZ2hJMStMMW9JcjVKRXRqTmdBZFVvYVR3RVBxbVJpWkdsUDIrN2VyY0dZ?=
 =?utf-8?B?UnVveGFVU3dFUTZFMzM4WDEyRDZ2U0MwUFM1TGhWekI4RW1SUGJNeUk0d2E4?=
 =?utf-8?B?aU1ZRzNpZlQvNDZEUGdGTW9CWURrV01QeTFkQXltOXIySnlTQnZaNDUvMFZs?=
 =?utf-8?B?enA2ZzdwS05nN0VZeEk4cS9IcHd0aWc5YjRHVThkOTAveDFKTDJyYTRjRW5L?=
 =?utf-8?B?RUxPMmkrbXFSVTVRRXEveGVKS2pMNFlLZGg0a1ZyTFhXUVRObXI4YVE4TmxJ?=
 =?utf-8?B?STQvMEJBUXFaUDExTTNhOXZQbk1BN0V1Vkg2NjVZVUlyQVdUUXJYSXk4dXBn?=
 =?utf-8?B?c2xZNExpWTZWVCthVnpjcjlvdVZicDEzRTY3V2VWYU9JelFGRG5RWmdJMzR0?=
 =?utf-8?B?bVRJd01MN0RTdTlIWU9taVpMYUQyRHdJcisvSGZUTElTaHZ4WklJWnVxL0RR?=
 =?utf-8?B?OHFyL3FFWUdhOVREYWZXNnB3aWlBblNYamt2YlZkdTlDMjZwaS9MK0RqK2JW?=
 =?utf-8?B?NkNibFZJV3IrSEJpUVh4aHFsTUczSmRUT2tES3cvSUdyT1N3VVJKbEZObFZs?=
 =?utf-8?B?TTk0WTFUOTIxTUNKWlE3enQ3NG4xeGJiUDExOU9GUithR3VkL3FGVnA0RGlx?=
 =?utf-8?B?KzI4ejRwRUtUNG1LVUZhTlFnZWlQTllqdkJIVFc0aXBNYVhETVFjWVBZUkl6?=
 =?utf-8?B?MmczVEVGLzBmRS9xWFNOYTNGUWZlNkQxYlN1UWtOUy9iQThacnN3ZmNSTm9U?=
 =?utf-8?B?dU5KclBTd1hVR1JWMktjZXVnNFpTaWRhVi9iRG1ySU1maFVaUVU1THVIL2ZJ?=
 =?utf-8?B?R3BoK2RWZUV3eFMxdytqMmVhamN3YVM3V2ZhN0dob0J5UzYrZXc0eHZwbit1?=
 =?utf-8?B?SnFmNHhZMGJidTdrd2RYV0NXOEp6Y0YxSHJ6UlE4U1VDUTdRcXgvSG1DSmFS?=
 =?utf-8?B?UVd3NG1MUk9EKzdtTWxIUmNRRzFiVWV4YW9nWjFRb3pyc0dXaDBvMmZhMFha?=
 =?utf-8?B?elVRL2Z1TG52SExRY285V0tzRU9SZFJzZkljNEFabjlEb1JZeTM0bGswM05I?=
 =?utf-8?B?clJwMmorR3FuT1RhcDZ2dTFXUWpMUkpWTllLc09uMVNndVZMc2JRUWlEQ3dK?=
 =?utf-8?B?ZzFMZ1NqWmc1MjljLzNJYnNIQTZaMjlpRlBDdVdNbk5aVkpDQzhhcUdvMEhp?=
 =?utf-8?B?ZHBaaXJ5TXJuQTBFRE0xZWFLdkc2VllTU3Y0MU85V2hoZTFXZ2F1ZXYxekdn?=
 =?utf-8?B?N2xGYlE0Q3BOOU41Ylp4cVRqL05qZTIrWndFLzUxSkxvWXNwRWV2aGUzUXF4?=
 =?utf-8?B?ekdpbTYyMWVUb2JaekdjZFpyNkk2L0g3d3FmclI5NUc5VWZ5WlhxRFVvT3pY?=
 =?utf-8?B?MVJ2ZlR2M2ZsdXk5RjJXRlJ5VHduRHNJeS9GdnBrRTR3SGhnQjMxTldsSm15?=
 =?utf-8?B?bHpuU2tKMUdtWGJWZnpWMnJYZy9YejcrNmc5MFo0N0YwN1dMQjArcEpNMUhY?=
 =?utf-8?B?M0pzcjRvVHloSTM1dHF5RXpJeXJ1blhqZzZIMGNUVkpPT2pRcDZOV2w5NUYz?=
 =?utf-8?B?QkIzNlpGOHY1MmhRelZKWXFoNEVFMzV5NHVGU0RJUFBYRzBNZVB5L2I1RXNN?=
 =?utf-8?B?YlMxSWpqZElKcnZrK2tRZ2UzM1JIYmVxMThwOWRERkZhaU9IaDUzQ1pjYWpx?=
 =?utf-8?B?bEllZFEwN3ZSdXBPM3k1WjE1MVZFbThvUDRHcEUvY21wQSt3TzkzU05pQnc5?=
 =?utf-8?B?ckF3YTRhWm9ta0JFR3N0YWJsOHdVaWVORU42WE5rSEZTOCt1dEU4d0JVcFhr?=
 =?utf-8?B?Ly9nZHFUaUhib3NnelF4M1BuQ3RscHBGdkpVTTQzQlByTUpuMU1mQzF6cEFi?=
 =?utf-8?B?OGRoZlZCQUd1VWIyUjlXSFRBL2ZXWmVrRDZBQ2xjZm13RGQyK2MrbG11RkhZ?=
 =?utf-8?B?dW1tcXBOTmdqb0RQaGhpQnRiRDM2dDNhNkhaUklDTUdIZUdRc3puYkZVOU11?=
 =?utf-8?B?TVhlbzZTZkVSQUVaa2haOTYxc0V6WnJGb3NqL0dzRHNUTkNjeDNXMkZMSVFU?=
 =?utf-8?B?L21JVzJtQUxySUtzaUZWd2g2aE16N2t1R1NYWENoOG8xVW44aHJ6REV0VHRy?=
 =?utf-8?B?T1BlV3FDVjJWRDR0RjkybjgrOGkwY0JnMjBVMVZPVEI4N1FjYzhuNjdwSkds?=
 =?utf-8?Q?0C5iFA4aNHmz3Y0rGKbs5TZFqUrU+rQQOO7eoXoIe91Ff?=
X-MS-Exchange-AntiSpam-MessageData-1: cWQwimwie8TnTKDzT/NNRtG+/z+JrwLYIy8=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c27d3f05-cec6-470b-5f4e-08da3d995c35
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:23:31.3576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 tvnNsN80jdtRS6H+EmTUlCoxxFvkubn+hr/5ObREe+qYj0WuUOzf7gss3kJCNzdgZdTbt38yXKjELUIlOEzEL3EQ2PHZLEOUPfpCZ0ke6fU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6004
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 May 2022 15:23:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8431



On 5/24/22 17:07, Jan Kiszka wrote:
> On 24.05.22 16:57, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This fixes the build error:
>> ```
>> ERROR: _exec_cmd: cp /usr/share/efibootguard/efibootguardx64.efi /tmp/tmp.1Y4utA1zC2/sentron-product-sentron-sentron.wic/tmp.wic.ampnawp6/bootx64.efi returned '1' instead of 0
>> output: cp: cannot stat '/usr/share/efibootguard/efibootguardx64.efi': No such file or directory
>> ```
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> index e1411cb..a01e484 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> @@ -59,8 +59,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>           }
>>   
>>           distro_arch = get_bitbake_var("DISTRO_ARCH")
>> -        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
>> -            distro_to_efi_arch[distro_arch])
>> +        rootfs_path = rootfs_dir.get('ROOTFS_DIR')
>> +        bootloader = "{rootfs_path}/usr/share/efibootguard/efibootguard{efiarch}.efi".format(
>> +            rootfs_path=rootfs_path,
>> +            efiarch=distro_to_efi_arch[distro_arch])
>>           part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>>                                                part.label,
>>                                                part.lineno)
> 
> Makes sense in first sight - but why did it work so far? Or did I miss
> to test one of the two cases (signed/unsigned)? Did you test both?
> 
> Jan
> 
I am still try to find the reason why it work in isar-cip-core. The 
error occured in a downstream project.

Quirin


