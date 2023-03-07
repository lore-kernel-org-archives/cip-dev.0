Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1273C678D5
	for <webhook@archiver.kernel.org>; Tue,  7 Mar 2023 18:33:14 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.70])
 by mx.groups.io with SMTP id smtpd.web10.2073.1678213987286985107
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Mar 2023 10:33:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=W2RRzK4t;
 spf=pass (domain: siemens.com, ip: 40.107.241.70, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTNeBmSnPNcMGE/KMe7Mv3OYwvLT/tkl4xMa8ccMPOm8Bwl9gX9uLgld3Y2pZj0tLVzvmNhPY1GW+UyySxI5oSMdxUHkctgH/bnMtmx7joltuhd2TLkORRfGp0nZyTuJ/3M0GXDPvvLlY9wX5L/W8oAnJ5/8Idt5qce2/QLbcr1tUp/jMNVj/1IvkZCdnMmpZd/6+le7feyO7sQa5wnpNyBhp3Ss9DoPWsU6sDV/0jtdMPrB6VoT5kmW7yxKRadwrlEGFx+E+yIGAMcT+a2vnFJZUdP4Hto6NFdYnlMGKUeSNuLS9fAi1w0yvuHniHxWXWYw0wU+IR1tk3jtiy0xcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvlpD0nrutBoxFqPa9cADHIadsyt0xJg/OeAZ+ZagFg=;
 b=mAJuumdNoDgF4BSNR7F2qkUf0/abveUVd2W2FdoZBopBnbxZtqkvHLozgkQMZYY9J23X0t8PtMauZoxxmAVOEC+5Tqy6QEJOhg9LegZpLL3MSKfdB5IB8uq+GRzZEaJ4ZAb1q4W+v/vfHCOYzGQRvUiyYmxXDgsbzdgZ+IZ7Q7iDuBslwGjX1lWVxLYkgfzrXrn0OTVp1kJpOkpOBHBL5UTHLs1VHrcE3QF6aNCnsoWXf63zJUDAO069t/VPX5/xD9NSX9NZUizE1o0svrQCuFwtm4TR7wSVG4KbWikj2era7THAmFmSDYG8EtzsypXoDzZASRpnhpVVU247AsWFHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvlpD0nrutBoxFqPa9cADHIadsyt0xJg/OeAZ+ZagFg=;
 b=W2RRzK4tv7NuUCpB/PyGDNNKMlA6NSK0pfcZ+7/IoUT91v85uGwOSSIYDqctX7rhHyZ0XN12q8mksPyzsNKwgwFx32nvNXIbKTsqEDVc9psJjaAkYJVg8OZBPChIrtNOrGAzHC9R9+nuX/afy0C8jjBnEmEApeXB6N/y/2SqwQrNpNkm6vTzhqsR+D+HDypqUg+ZtSIfpp3LaGqS/GgDCLdSvDlPx7LhsAqpNMk4Bi0suXbFMMBMbFtGisMBHhp5mEbTLPvv3kXH654AJ7qGah75lUAY8NZI49cJSbOTh/0vMq5BBNAaMK0dIXXr0XgO9eimFKM1lOvshXGMLvzczA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB3613.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.16; Tue, 7 Mar
 2023 18:33:04 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::41d2:6320:6383:274e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::41d2:6320:6383:274e%3]) with mapi id 15.20.6178.016; Tue, 7 Mar 2023
 18:33:04 +0000
Message-ID: <9824f158-130d-6bd1-e0ae-6012a540d72c@siemens.com>
Date: Tue, 7 Mar 2023 19:32:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 2/7] KConfig: add tpm option
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 christian.storm@siemens.com
References: <20230306123926.243471-1-Quirin.Gylstorff@siemens.com>
 <20230306123926.243471-3-Quirin.Gylstorff@siemens.com>
 <3806f4ee-3a03-dfaf-72b9-fd40180be2a1@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <3806f4ee-3a03-dfaf-72b9-fd40180be2a1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:96::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB3613:EE_
X-MS-Office365-Filtering-Correlation-Id: e305a16d-1bae-4e34-265b-08db1f3a6399
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IR9a17O5yHlAgbNE6awoqBRxUeR64m5s/DGhF0SvWQamRJJmADC7PUz8rsAK8DSJyvK0EZwGNNDQW376g8WEUfRoe8IWDCOERe1qvOFLOv8olCztu0KySi67bY4fxO8Do6DROOU0eeZ0qQnn1EFkmMRCx0DSzC/MA+N8t1ZgPxY380vGzG5kDpVml2JAOCyfnIm/R8mxYUI2X9WaJjKHQX9FymZmn2BIZGi1lWvOJKzQhm+AeaVKP6blEGZobX2skrSrxc7ipjrJ308b3uQzm7x6O2F5wHMUG4C0j9qa+940FAjYi3aqIpw1dj1QDY5ObcG1J0BeF1yj88kpiJNKs7kySfXv+rbJdOCqTs4mUhRT5PTj9q4b/mvnjhYbwO5+0ex9QyJSwL6pWQy/ks1mhaIGkDIYE3qfNKXKMHasfm8JDwB/VPUEVQyXIj9oBw75K+RHI8vlIEETyuRWp0kot/HrPwL+kYJiAwdRUJJWGXmRUvl+YmrYM1QXbGFfUUqm4JBXS5sIn+LZjfpJM37NMAnNZXHiwgGsVOjTFeweWvCYHza6acrn47sLA3R5uYVcP+p5/LQ8ymU0fIwHrIdSungHpv39fGmc4KfVvU5Tv6fMxKQPPVYw38xcNbMyH5RSTqrWEaX1MvQMNyGfKoxLVf2cyN8K92X4hpAjSMsbdk0RUy0DFBznpNxTI6SXpDUYhahlkbBX5xjlE6DnqfjTsI1ucnO8BzlkomAtjMTo6y4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199018)(6666004)(31696002)(41300700001)(86362001)(83380400001)(36756003)(6636002)(8676002)(316002)(66946007)(8936002)(66556008)(478600001)(66476007)(5660300002)(6486002)(186003)(26005)(82960400001)(2906002)(38100700002)(2616005)(31686004)(6512007)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anVqUkhKQUxFNmJwWDNoR0tBdXUweThFSTZyTW9YdTlHMjU1bWxFVTAxUVph?=
 =?utf-8?B?T0wrMkRVSDJsTEVWQTIyWUFwOGx1UVdpZFZMK2pROGphQXYvSWRYWWxWUlJy?=
 =?utf-8?B?cHdsY1ZzUGdCYmhBYnNhbi9ZT1A4VzloSDdURHhrZWplSEcwT1V1R3VDditB?=
 =?utf-8?B?b0J5VDgxcmRKQlRzSXEySnJBV3VzR0JLa3ZCWWl6NlBhdkI4d2hVeWpGaDJW?=
 =?utf-8?B?aHRGdE9Na1cvMkhKWkt0bk4wVjJEWXo0S1JEUTdpN2xRaFk4MzU1TXZhVkNt?=
 =?utf-8?B?MnRNZTBST2RxUnptSmVhZFhvR3lFSUM0ZlFxbE0zN0dtN3FSa2lCeEZ2QmYr?=
 =?utf-8?B?bUliRlBHTUJOZ3NGSmRTQUZLSGFsV3JiRzFhdmpDUWVWNzVnczQ1aHpHN0VO?=
 =?utf-8?B?NEJ0T3o2SGxEZzRKUDFiVXVrTG1ZTEhjblF6cW5HVUMwZW91K1ZkQ2srZC9T?=
 =?utf-8?B?aFovZFZvM3JTTXJHbXFtc2VMRUZkMTNIUEVUK1dQMHdXc2txUlRxa3NqYnBC?=
 =?utf-8?B?a0t2YnE2aDdsSEhRTXZxN1lzL3Mwd0lia094Q1ZtdVpidTdaOXRPOFdQdVZH?=
 =?utf-8?B?cnFiNlNWN1dHaWtKU3ZXVCs5bUxsVW9BTms0b0hyQnF6L3VZdWpJeEVSbFRB?=
 =?utf-8?B?bGVnTEcvbDlUZ0ZRUnBURWl2ajRTM2x2U2FDc21CYTNEQmU1aS9iVXhkbWZz?=
 =?utf-8?B?NE9IOHhjb0NYR2xDZXVVb3R6Tm9yTHdWRkl6ZnV6OGhmSk9OZ1hDUVJMa2N2?=
 =?utf-8?B?YXFjalhvYXRIaWtuYmpMT2owZnhzYTlKV0pWblo2bmVveVF3UWMxRVJEYjFD?=
 =?utf-8?B?NXBWYUpQVTJZRHZSa0U5d0RoQnBCUm56Q3VhUFJQbFNFeFpaWmZFa3ArQXlT?=
 =?utf-8?B?WHpyeFV4bkE5dUQvS2JkRVVLZ2JYcnZQVGVlMEsvcDJ5ZHFLOVRJOU5tSTZ3?=
 =?utf-8?B?a3plU3lyOTlsUnFBVEhKbWNQOVRJRXVpZUtLVVZsTGdPRHlUdnZ3UVRMMUJt?=
 =?utf-8?B?R1g1cHowTEJ1NWlPZ0NjdjdCNVJsRVNma3dtbFZReWJYQTA3QnVLNlVORFZH?=
 =?utf-8?B?ckVNRmlBOUxvSzdZMG8yNTZaZms0OW52SXJtY2l5L3FqQkcxQTBhbkJHN0I3?=
 =?utf-8?B?MHBtZ282bEQyOHJuaHdGS3lMbk0xTDRFeXk5MXRPbFZtWnpUODJnL2lrakQw?=
 =?utf-8?B?V083cjVpNkY3M0JYMEMxZy9nS0s0elVQZTJPc1YrWmc3Ny9LSUtKQkx2Z3RP?=
 =?utf-8?B?dkZhTDhmUEx5Y3M0ajNOUVpMSmxrVVBheW5lSWFsTUlralNjbWdXT2ExVjVJ?=
 =?utf-8?B?cGduVEkzRlk1TXh0ODFseDVYSWxIaHlySEVuWDBFMUx1TUVqK2hCOGNEclZD?=
 =?utf-8?B?L2xpYkQzOVBKTE51dXEyK01JSkZMR3lydmVhOXNuVE44dG0zdG8xZTRZbVEw?=
 =?utf-8?B?TzE0Mm9COHNkWWhuak9RM0Y3Sld0SS9zVk9TbWMzTmo5MVdJUzNtNlBFaGFS?=
 =?utf-8?B?b2ZlSFhFSFBGbDRVdFF4b0svOTFEN0p1TytNRXlvSDJEVUlKV3BUZEhSNmhR?=
 =?utf-8?B?TkUwUndNYzdRQkZhaG42ZU9KYVRha2F4bDVaSG0zQnpEdVk3bE02cFpGK2dN?=
 =?utf-8?B?Uk5oTWJLQ2xWT2VybjYvc2NHYkhkb3FQU3NhcTZVdzdIQUd6R09vQVMyUTZE?=
 =?utf-8?B?QUJDM1JKSWt2clZvUlBhYVJJRks3cVhYS0tQSlhIaGgwempUZzBWa3ZLM3NY?=
 =?utf-8?B?djJMSEthZmt0TkYvdUVDb3FCcEdkRkU2Q3VkbDNhbStGZzVyc2xEeElhSkdp?=
 =?utf-8?B?cnVPRmhzR1BISDJtd0ZFWHZESllxYzBtMlRjM3JYQ0dLdHhUOTBwL0NvVExU?=
 =?utf-8?B?ZjFYalJXdHd1TmgwQXVkTHk3K0RJOHgzVzZodzRKWVhmSHhML2gycHBpb0VD?=
 =?utf-8?B?d2huQmVRYWF3YTF3NE8xK2RFaUZqV1Y1a1dOSjVNdDZNM3hXNzF0L2VNSXph?=
 =?utf-8?B?bHRpR1Z5OVdTTkZPWDZ4ZmlVWFlhMkF3bnlsOWlFRVdTSnRjRzhTcVFwZU5y?=
 =?utf-8?B?Y0pXUWNtazFobWFDODFXVjlvTHJJUnRTa0d5WnJPUEkzNlBhUk9qM0F6cXBS?=
 =?utf-8?B?ekxFUU0ybi96YVY1YlN3WGErUzlTTGpFWDF6SWFSV1hWWUJBci9CVEh4cFJJ?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e305a16d-1bae-4e34-265b-08db1f3a6399
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 18:33:04.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TD4KgEzJipwAhFuovwkwfbAeCZZVG7hNFFB4wI0mfMxvRAINxzX2tJn6y1nlhZb8ufubn9ZYGBJo7ySxQNIE//fTgYSFfDWhX5fLs89XfU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3613
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Mar 2023 18:33:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10949



On 3/6/23 18:27, Jan Kiszka wrote:
> On 06.03.23 13:39, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   Kconfig | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/Kconfig b/Kconfig
>> index 7d72094..7ce87d0 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -193,4 +193,15 @@ config KAS_INCLUDE_SWUPDATE_SECBOOT
>>   	default "kas/opt/ebg-swu.yml" if IMAGE_SWUPDATE && !IMAGE_SECURE_BOOT
>>   	default "kas/opt/ebg-secure-boot-snakeoil.yml" if IMAGE_SECURE_BOOT
>>   
>> +config IMAGE_TPM2_ENCRYPTION
>> +	bool "Encrypt partitions on first boot with TPM2 (Demo)"
> 
> Why "Demo"?

To mark it for  demonstration purpose only.
> 
>> +	depends on TARGET_QEMU_AMD64
>> +	help
>> +	  This enables TPM2 encryption for the partition given in the variable
>> +	  CRYPT_PARTITIONS from recipes-initramfs/initramfs-crypt-hook.
>> +
>> +config KAS_INCLUDE_TPM2_ENCRYPTION
>> +	string
>> +	default "kas/opt/tpm.yml" if IMAGE_TPM2_ENCRYPTION
>> +
>>   endif
> 
> I'm struggling a bit with the naming and description (throughout the
> series). The feature is actually data encryption. The fact that we use
> TPM2 for key storage on x86 (and possibly also some form on other archs)
> is an implementation aspect.
> 
> Let me think about it...

I can change it to:

config IMAGE_DATA_ENCRYPTION
         bool "Encrypt data partitions on first boot"
         depends on TARGET_QEMU_AMD64
         help
           This enables LUKS encryption for the partitions /var and /home.

config KAS_INCLUDE_DATA_ENCRYPTION
         string
         default "kas/opt/encrypt-partitions.yml"



> 
> Jan
> 
Quirin

