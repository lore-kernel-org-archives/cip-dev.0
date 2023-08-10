Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C71C001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:18:25 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.42])
 by mx.groups.io with SMTP id smtpd.web10.14715.1691666295455439388
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:18:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=OaSab2VT;
 spf=pass (domain: siemens.com, ip: 40.107.104.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtmvLa+Bn/2XQkiaeSUjUWX4JBXTM4JnRT5nDndT4PpGIwmTKWtpm1LopfQY0ho5S8ZAPOWWynXsFc6qKmsprZb+aMZ8nEybDgBbrp2myQ4SA/GhzX0WrLRDIBBhd6gVgp/oNSyftQfrDUtGM1aFaOcBIny4DaXVzRyzOMqB0bIkBEvyTDdt0M3eh78Iwq2KETRXvMufYeRuppyiL+JlrMfFVbV5vUswgTLFmK3w4ZAlJWQ6FZ2Y+4AgX3cYbaQjLWiIWRj0CygyMHgmqAUKt3zWWqlhPEVUpXT7vJTCF/IeipEnMBFR59HGjlORpWahEzkrBsqH1baC8aSe83hENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HT/+0JQ1vgHHTRHMXbkv2rlbP9fPAWQ46A+YwMgp2t4=;
 b=oc/aTkKUemmi4z5bvM7ecXFyy+LhRL28UBU9C8IDRCkVRB+VUEdCdvdH5qSsXO2DHTwUePenS8jW92jXwj2MPbCXD7y0s5sYtx9YpESuaWB83SlNQ/hY7+DbMMHQz/weU97hP4C9jp9jYaBiHUXhQo0oyK/U1BGTbjeY+HaETUVgitpwJIIAtW6f95tFGBymM0+gkxLdVhjs/yTrXnBgKpeB371VbgxArhZGeFl8YKJlIgEzRcRzyEZVWNhoMfjpRt6o2SgK/VB/B3yADjNjB9gUmaKjbt/mpzDsNtMNAebRaxkp6c5JUiLxQaDNNkqV+awJdG5y4a98n3CarOQUxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HT/+0JQ1vgHHTRHMXbkv2rlbP9fPAWQ46A+YwMgp2t4=;
 b=OaSab2VTOX7eJritcOA0K/tkiiamA4casvf6nZtisrGAcObqEU1i7IqPQK6sqbR5XTXFXDDBQa5SFNIcn9Jo9hhoEGghJgdIQ3KipxPKyc917EWlm1nakDHG7BqEEDrZ7OTxbV2jR/HNCKvM7VNMWE0nmLW8u8MbinXEsgWJLcT0tMkHQkUcZBUVvW7oyi94vadxS2GuFlyKqhS9hkUTorPijjy/RiZF6HeJvJllTL3DAIGdRsf2Zx7rweQSYHcljss8mCAc8IWcSMBOMPtiH+AZQ5XPjPrrlpXPXVA3X77wXEPmaIdxXWmH138vlzqd7ofZgPAP2CGYSuhsO8ITJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:18:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:18:12 +0000
Message-ID: <a49cdd53-e2b9-52c3-ac40-b11264952b28@siemens.com>
Date: Thu, 10 Aug 2023 13:17:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org,
 "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-4-stefan-koch@siemens.com>
 <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0050.namprd07.prod.outlook.com
 (2603:10b6:610:5b::24) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7149:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e5ad3a-3049-47b6-e003-08db99937bf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	b6sKMiF3wQMkWDXyMLv1Y2BEDvlVcFTnU61xqfRxWYe7m5b7GFWymE5gzHwMbDb2LXZVIrPpxuzUq5qJZBPCX8lNWrw2MbzPeZUOyUcG1zkMjvRBgMHH0YI5xR/BqExbEBpGFw7wC/TjDrQ1vXVZiTgMQwyNVBZGRXSpSKJwSKAgErbpAHynExbVnyxLFpV3zMEtRu9BzZ4Xj0lrWNQncePWtNNvFyvzGERWVo0InM5cbQNyTwE9VI/3bIOJCrCeQPFrc9P7a2zu18j0scq/FUQpjRt2/9gevXF7Te2IiUBLpbFcmmxH53oz2pooti6YwusLs0wcj2J3+Pcdkh6dXTpLQ6dr+mjT89c/+SXb5/yWF0f490nWlDTFmzeVbQvmHgVGFeFPiaTnfRP+zny1SZ9iyCOmnJ0roNWxqRPxvBsAps5s/SR3Lff21HRwiQEExNWVQe1IQ84x5gD0+ktSUv88GmQemaTRZFA0a6dcuRlyJH6j3peP2EDYbufEDXLwPQpv+3jbfEAG8/hKjyRaJhNqDy2W1VIhB8DzW39RoY8gAfOrG3Gnmbf7fFZc5iCEhvc7clahVq6kTlxz7N2UvC5INi0eTNckpnk3ZWeA/GnktMfqfrK/QX/NPSkd1Lz6Brgr7Kt2YBBJhpd8qNR7Jg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199021)(1800799006)(186006)(6512007)(31686004)(54906003)(37006003)(966005)(6636002)(4326008)(5660300002)(66556008)(66476007)(66946007)(66899021)(316002)(478600001)(6486002)(6666004)(41300700001)(107886003)(8936002)(6862004)(8676002)(6506007)(53546011)(26005)(31696002)(86362001)(36756003)(38100700002)(82960400001)(2616005)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OW5JMTdkOHV2VlhyZFRzOCtjaVlTZkJsUC8zelhrQld1WnA3bjRtZTBwZ0Fi?=
 =?utf-8?B?SzIvNnpuUUVaV29Sa09RM2pxVUMrMWwvTEkyT2RxVm1FdkIxdXFTbk50L3h5?=
 =?utf-8?B?cWZmYklUOFBlQUhaUkdQMTNqRDFrK25mamUzNGtYTjkxaGhrR2FTQkJRZVBL?=
 =?utf-8?B?bVdYWGNxVjBBM211VTIrMlZQaDJsR0VNQ0E5MEorakpuWmZkazZOMGN4eVJK?=
 =?utf-8?B?Z3Q2bFdFZVpjQkZmYkdVOUIyRGhGZTlxWE52WDRPV3R5UFV2ZFp4QmlwRVA0?=
 =?utf-8?B?MmZRd3dEMGgzZi9od2tscWtSQ0grdWx0WjNnRmtOQ2lDVEYraG1hcE9KaXdq?=
 =?utf-8?B?bGZEWVQ4Q1VOWnRERkh6bVFxdGZPVnMwUGxQUitkL2lPM29ta1Y4YkZIeFZa?=
 =?utf-8?B?QjRROHk2Sk9naktmYVYrYm93U1ZJNW5rYmZTNFJ5ZU1qc2c2bTVWUUhsUFYx?=
 =?utf-8?B?UVorZ0k3UCtrbFlFd2s4bDU1UmZqSUlnbWsvemRYakpOTC9YRGxNNnZLL2Yx?=
 =?utf-8?B?aTNJT3g3VEdsKy8rOUx5aWRWTjVsa0RzdVVXWVNUeTVXcU1PTGVXNzQ3WVdl?=
 =?utf-8?B?SmcrQS9iejIwb3FrSkhQNHV0dkcyTVBicFhPcWF1L2hOZHVGMElzaHZsSTlN?=
 =?utf-8?B?SVFScDRRMFFJVUcxcVdMQ09zQ000Q200ZHNhQ2xpcDl0VWlXTnN5ZnZFb3Ba?=
 =?utf-8?B?SW84UmZnWXRTR2pUdHZTVVZjUGdrV1VCcjBPNTNDcExGd2trMzB1LytYcklo?=
 =?utf-8?B?cUFHMkY5YWNDdXhrMXRxTmc2NFJiTWV0WGlLeTBUQ1FkS1pEcERLa0drckFX?=
 =?utf-8?B?SGdtQkVJWjJqeGxyY1hlRTU1YXVxN0R2dXpCR3d6N1FHY21kNTlmUUhIVlkw?=
 =?utf-8?B?N1FLL1ZndlF4bFdCNm8yY0FsTDNkT0tLRkpTOGNhaGV4UXBUNDgyNmJoOTEy?=
 =?utf-8?B?NS9wS09hbk9IVVhrd0dTcVJTRHVPRUxQTFhTOFJNbEdyYzFGUDZkZlR3OTRY?=
 =?utf-8?B?bEFxTUVWNnFzOUkzbStrWWt4anhiemdHMUZUdXpNeU9ZbnA2NFh0VHhuNmlQ?=
 =?utf-8?B?eVgxeSsrMzJvWHN0QUVCN2ZCSWp3OFc2RDdwMTkxOCtLVCt5dFJpWXh0ck13?=
 =?utf-8?B?Tk9MK2czcE52Rkd0aDBlNzlOR2tyVjJGa21wcXFHeTc0UWlQY0preDN3bFpz?=
 =?utf-8?B?YlJwRjgzNDRIS2hxM2ZTWG95dWdxdmpONTBLUlZPL24zR3hSYmw5RHhiUU42?=
 =?utf-8?B?Z0E1UDBvdjdNRnlLRkNwMDZzNnE4RTVWcFJNVHdaNFRhY2U3b3dwWm9LOXJ1?=
 =?utf-8?B?cHBMTzhBblJlVmpzUlNrdGRjM0MvMVpJblNNM2xadU9pUWNrRlhUUGZuc1Fs?=
 =?utf-8?B?eDAwNjE3N0NLcDNCN3prRms3WHpJWDNkbVBobEZ1MitJR2doQVdNcjhwcFFF?=
 =?utf-8?B?R0l2aE50UDBhRFUyYUNiMjBEVDFBVUF6YTB1SUI2TEVDazNkanBab2ZtYWpr?=
 =?utf-8?B?aWRuRHVBN2MvV3lDZWY5NVIvalZOUTZjZjQ0MlBmd3FUZ002QmVOUStHc2g2?=
 =?utf-8?B?ZmJKSGRiLzF2a1F6S05hck5iaHA5aVlUZ3ZOcTB4OGFrYXY3Y1ZjbGRFZEhR?=
 =?utf-8?B?bklsMFd6NDlOcHhFMllsSlBjT2JSeHkva0p1cnF5bVlmeEVzQmZKbVFVZkxP?=
 =?utf-8?B?V0JUQ25iR1JaS3NBdGMzM0k3RHRaVFExak10UmRTbENKZ3I5Ui81VVM3Z2xM?=
 =?utf-8?B?VUhJWnNPWTlud0VqZXMwMW5qMnVuWnd1L2VXV2x3cGNuUk9XSXRERGl1STdZ?=
 =?utf-8?B?QVRML0tpUEs2WHo2ZmdSYWpNUE9hNnZFTVZmUW95dkVSMWlDbHJWNXdqUHNu?=
 =?utf-8?B?dFJGcnhMeWI5bXFIeEZMa2lSRnkzUk42S0RWNHNJTml0R2tIMXRKb25MZmg0?=
 =?utf-8?B?WHZCTmlSVEdmUkUva3IrcUxvM3AzZzZGOG45eERPTWhvM2JjUEEwWFJ1em0z?=
 =?utf-8?B?eTZ2N2xzMnlNRDdOL2ZCVlFJdnJOY1cvdWlsNlN4OHRDcXkvU0diZWwzSlMz?=
 =?utf-8?B?bVloNG4xclJuTVFrUkEzeDFhN0VXSWExMU5iSjNTMzJZSFVxQndmNTR1TVBq?=
 =?utf-8?B?ZXdmRWxKVklpQWN5VHpSQ2NUTDN2OFZCYmg0Mkc4bmliRXpsa0JxVmduL21V?=
 =?utf-8?B?Znc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e5ad3a-3049-47b6-e003-08db99937bf9
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:18:12.3310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocrP1OxOPDSmyAg69pbcPYIRd7boFJ2+V7GD1D5YHk5nBeJsoibamB2Bm66dqxO18NDHMLniDJ9s+hoOa9n+3b8qoiDAw1r61DpZZkSWnSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7149
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:18:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12597



On 8/10/23 12:36, Jan Kiszka via lists.cip-project.org wrote:
> On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
>> The tiny mke2fs does not support the used -t option.
>>
>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>> ---
>>   .../initramfs-crypt-hook/files/encrypt_partition.systemd.script | 2 +-
>>   .../initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb            | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
>> index b32b2f2..4e04d37 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
>> @@ -42,7 +42,7 @@ partition_sets="$PARTITIONS"
>>   create_file_system_cmd="$CREATE_FILE_SYSTEM_CMD"
>>   
>>   if [ -z "${create_file_system_cmd}" ]; then
>> -	create_file_system_cmd="mke2fs -t ext4"
>> +	create_file_system_cmd="/usr/sbin/mke2fs"
>>   fi
>>   
>>   service_watchdog() {
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> index 1c1bf3d..3c3f6bb 100644
>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>> @@ -32,7 +32,7 @@ SRC_URI += "file://encrypt_partition.env.tmpl \
>>   CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>>   # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to create the filesystem
>>   # in a newly formatted LUKS Partition
>> -CRYPT_CREATE_FILE_SYSTEM_CMD ??= "mke2fs -t ext4"
>> +CRYPT_CREATE_FILE_SYSTEM_CMD ??= "/usr/sbin/mke2fs -t ext4"
>>   # Timeout for creating / re-encrypting partitions on first boot
>>   CRYPT_SETUP_TIMEOUT ??= "600"
>>   # Watchdog to service during the initial setup of the crypto partitions
> 
> Do we have both already? Also in case of the isar-cip-core generated
> images, or only with additional customizations of the initramfs? Just to
> understand when this issue is currently visible.

cip-core does not include busybox in the initramfs - therefore this was 
overlooked.

Quirin

> 
> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12591): https://lists.cip-project.org/g/cip-dev/message/12591
> Mute This Topic: https://lists.cip-project.org/mt/100411235/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

