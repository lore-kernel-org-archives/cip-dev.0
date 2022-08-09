Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0E9C19F2D
	for <webhook@archiver.kernel.org>; Tue,  9 Aug 2022 07:51:46 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.75])
 by mx.groups.io with SMTP id smtpd.web09.9138.1660031505180877687
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Aug 2022 00:51:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iqV0Enjd;
 spf=pass (domain: siemens.com, ip: 40.107.13.75,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/90kc83uy8zU7wl/wf7rqLoq184IKg2jK7QM/LInCyUDYdSWBLHMlmH1bniENqGNWO/YIgBkRtYkBroPTXJpXD1IRtOVy4sIuOqvwNV1tcVJABQFaQeTDMvqMDHfGOjHIG69r0SiHW5ekpJizLx+BnNAe59mjllSx8zziV9Mg6cJVQE8xwtmWJZ0Y2NOfMwm/UhVN4U0d9aYJSJ436e7V1kwET6/+kbigJuxAran9K9q5C12NHCQ/KjgcGfHbVElaoE4I3LLcktsWU4qDZC79PzVplOeTU3pVnFx+2xSZl9wDz6dhxG2iWnvOXUXPGv6vcSvHQsLfTgMK7uOA124g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ixhc6Z/axYsf3T7OIuYFmXGORBoVyWNoaTXRZagHzh0=;
 b=g8ILWFFyFCpoaw0/R6uP9n27ZWaArIobU0u5kVHmX4/Lgy7ValcO8f4Jr5Tai53TLNustNOj8DQ5BrR4dxhDPvCHtQrEdf9ILxChL4bHo/z2XKo+AUuKWWYXpQel6+hSnYG8ku7a2Ce4hmCIyVTAOd2wTXbpCnq8Eao+p7O9G7zpOHsXG9e3iobD4GFi6y3nMCrbi1lL6GqrE7U2Xc6dZuk9qs46076Z8D0bmEtHm9PrTzRzW9192xhtpTr7ezCNEynhhAxHDgj1qxVpkJ4eGZCc1f4JfGIFWJOF0k1zMkxBO3RB5jYGR1zeTzsxK5AT30Xh8eX0LqjJtIQ/2I591A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixhc6Z/axYsf3T7OIuYFmXGORBoVyWNoaTXRZagHzh0=;
 b=iqV0Enjdw93IB5my30gZKO3MtqxmXRUQQ00rWq0mmZ+jrPWZDxtWYgAHMRazfpaEwk3sjGWNx2pb6Rht/FkK2LuzMASlxPnJ0c/6Ju+ODcS9JL+paHOgLbTdkKavbGJXdkRQm6TULaLAs58CSJs4F+aKjQpts4JcXZpBlLOLE/j/akyy6YBsn4MuhCHB+B71/NBq88HHlahub9lXQjEXJsXNd8uFskiO1SoY+KtUTXLbRrRokMkY+WF7MLDPM6crjIs3KdiYxedhYyQj4zUVzrHUIFjGjwKK+U+s63eFZTjWBI/rzjLmKr3oMTyiOFlkdukBsb9cPyv0lByR0+1jsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by AS1PR10MB5416.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:48d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 07:51:41 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::210c:7451:eac2:3c38]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::210c:7451:eac2:3c38%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 07:51:41 +0000
Message-ID: <fb2b0459-a98c-9139-cfe4-a3b623119a8d@siemens.com>
Date: Tue, 9 Aug 2022 09:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/2] kas: Remove
 efibootguard.yml
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220805152623.2155519-1-Quirin.Gylstorff@siemens.com>
 <20220805152623.2155519-2-Quirin.Gylstorff@siemens.com>
 <02b6c4fc-3b33-a7d1-8353-22002545d92e@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <02b6c4fc-3b33-a7d1-8353-22002545d92e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::35) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35246aaa-4d04-44b0-18da-08da79dbff59
X-MS-TrafficTypeDiagnostic: AS1PR10MB5416:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YfxDQ5Ri/sWysBxe02h1XPQJRLlUm7e4u9soxoI18gYyEGbtCbqBln3UggV787YFFmvbR/fgG18ABWRa/2jB2Ok/TvHsxd752RRPDgqE6szq/4wJ5sc5RF4EahTNQ6nXnynn0IRZeq2hMUtm1LpTKp8jRUGpTDLJn83PXMaUa18BGbjpQLOUkmlyt8ndKMSf2sgzuyPJxKdPzakNqiRH/mb8oOw+KCQ65BoJNMD6VD8sgP6j/eroh58ht8fAwn7kX6o/FGR5PUqyfLSPe1bUSgPdgmwZ+6JwcvfcEQnSRA9O2YldiVdC7G9/e7z+nZgD8LZqYd8y3DnLhxeCwgV/R56gY8kBtaTDHd+XuPn2fvUJVW5w0xwNt9aVYTnYtZQHLQ+mMO3sRAZGsw12FcoqHi7jFQSgAF87jFfk6UbOJ0Ll3LXYNY7zDgJ71ny+RwfT+LSK72qwqqBYF/J+m4Mr3Q6mVTRbAEuUGteQl+4wah8bCM5bEYnxjO0P99naZVGen6DQNiADRj3SechRcfrNhaHdmSM2rxP6d4vbJvhSjjxW8wZCDOxJSHLrCzYTIFmmiIfhOqzNJel7e72wfD7wYyIKOKRdWqtURKU1yEJi8I5cBmfGzvOTXMV7qYjbyWEn90U+oOYfoChzyZWPFhCcJyohntOVT3ER1026Mmj6VzIfirdvyaltvNynIZSFjZs8SXSySwfFngAwaRs48cSDlh/JVhRyR9FYX9IIbIMn8bkfVguOAkmhGKIgruDM40y607gKYHJunfkNRLkz8LuQ4Lqw5Yh6dF7WXIju0dhihKhjMy6NriXnRchNDyy4HakPS/sR87PRc9Ay3snQaSz20A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(31686004)(316002)(66946007)(66556008)(66476007)(36756003)(8676002)(31696002)(6486002)(8936002)(478600001)(5660300002)(83380400001)(86362001)(2906002)(36916002)(6506007)(38100700002)(41300700001)(6666004)(53546011)(82960400001)(2616005)(186003)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Si8wSHEwT3JIbGxpSGRSVG5TNWkyOFUxQ2Viayt2RFAxNGFzUEtxdXdSZDlR?=
 =?utf-8?B?SE9WZGVMVmxTUC80NXluWGx3Y2hiMm9tbnpFeU9DVkxucWlSUFViVlZoQTFr?=
 =?utf-8?B?WHl1QUZhNVQ5SHRIYmxrdW9SRlZraUE2YS9QN1diTDV4ZisydHpnQTdhbmxU?=
 =?utf-8?B?bkhEMHhtQkN6RUpBZUlNY24zV2pCb1RwM3R1c2xaYkd4NWF4WXlvbWU0WUJH?=
 =?utf-8?B?d1AxcVkremNEbjFlejNoT2Y2OGQzMVpLbnNwZGVHMWpOeHl1OG8vNnNGTllF?=
 =?utf-8?B?cDVVZW1DZE5Qak1GbDk0YUxRbmVObHVOSmRFTG1TYklqZDk1cGpLMDJNK0Qv?=
 =?utf-8?B?SGMzMkFhUWdEZWpLNmcyM1VIZlhUMy9mMGpuQitGV1FadC8ya2lBVUp4WXdT?=
 =?utf-8?B?RDdzQUorQjVZRURqQm5nMUtXanliMXdMc1hNaGxRZzVmRDFPMGowTVB3bXJm?=
 =?utf-8?B?emZ1b3VJeTB5MEljYkx1blFlNzBsVDhmUkQ5aW04TTRFWDQ5VVBpMlpBVWUr?=
 =?utf-8?B?NC9WTzJ5UzJmYjVta3l2ODJJdU1LMjZSM0dXV045TmU3VVdMRU53VENMaytD?=
 =?utf-8?B?MWtLZ2tDbVBkMjRaRHNtU1ljVVFTNlR2ampmVG5xalFKOFlITzBoNitBVWNS?=
 =?utf-8?B?MWE1dFB4L1hUSUFkVUZpT1pRSkRaN28wUDBUc3dzbHhoMkx5SFBHUjVHZEVT?=
 =?utf-8?B?WmZ3VTJLTEJmNnJMSzBrQ2p1a3Y5azhzeStkWG5rZys4TnVwTFphekdINS9Y?=
 =?utf-8?B?UFBad1BnTStSejhuYnUyUDdJRDBMelZWWHF5dlp6bTlaMzVhV0Jkenp4b2RI?=
 =?utf-8?B?QmZLZHlvdzN6R3ZBK2JlL2tidjVJd1hEeWFVSWV6dVpQdGJteldpaGxOZllM?=
 =?utf-8?B?K1JvMitVN0VPNHlKcElFU3l1K0VGV2lxNDZLdFk3ekV2a0JBYm15WDRBYlg5?=
 =?utf-8?B?Tk5RS290UzVtNnpYMWc5U0lhTk9EczRZQ1UxZm1FOHB0SEVVUWtsdDBZaXEr?=
 =?utf-8?B?QTNsV0JEZG9JcG9XRFA1Q3d2enpGUzVQZ0hZMTR0dEpjRE5mclpGcWM5dTh6?=
 =?utf-8?B?aG8vWUlKQnhDTFI1V2U3V2lXUk1RUVB1UU1yMkhCSk16UzR0eGlYN09hUGpF?=
 =?utf-8?B?U2VBNm9ldUJzYi9YaVJobFpBbDlkYk5hU25tTEJMWVdPK2NsdE5JRVNFbG1V?=
 =?utf-8?B?OGh4MmdKLysxTU1nQnMzdkk4WGsyK3kxeHBkQnBOM3B0eTlqV1JFUHBmcmJM?=
 =?utf-8?B?QWJCZXVCZjY0b3VRNTZTbTFTZnN1MXdieVBqb0NpcG9sQ1d0dHVtdnZvV2Zo?=
 =?utf-8?B?L2Z6L2VPOHNQT1NmTmpudmxQN2tVMVMwOWlTbmdMSWRWaXJrblJscGphOVVw?=
 =?utf-8?B?QWZmTjNBUVdnUTl4MkhkQ253UDUwc0Y3aVFrOHF4WmZCWWpvS3pvNkJhWXJk?=
 =?utf-8?B?Z2VtLy9rTmRGQktnN3piRENYNnJsQzc2NDdOQ1JKSGZPdU13R2ZpenBHSkN4?=
 =?utf-8?B?OU9UbzNwUHNsMzh5WTk4SE9GVFgzV0VJa3ZMendObjNoRU1WSlgxczdVZElB?=
 =?utf-8?B?L2lnalIwN1Z1Y3dsdlNXTEJReXdyRG1nelV3MTk0V2pGdUhtVlZTZ0tpazY3?=
 =?utf-8?B?RUd4cnE3R05mOGpqZU5vZnVuazdiRFhSbDZFampTcUd2SVl1dWZjd3Z3NTdC?=
 =?utf-8?B?UENPNmlleWNtWEZKSWxLZTVDS05ISHJMeFVocUFubklRM01maUJCQ3VLWnYw?=
 =?utf-8?B?Ty96U2dtU0FTK2FrT1c4TUsyTjZoMjBNeDBOYmpLOEVJSWg4Mi9QdVI0MFZE?=
 =?utf-8?B?Y1JkUzRvS0JvcVFLSnByMGdJOGh5c01nMmNHTDFuem5JNGRtbU9GMnplTkFn?=
 =?utf-8?B?blB6THkrZ0RBZUZOL2UrS0ZVL3VnVFkySUIxcFBiOTRPVzFzZk5xSzdpYU9V?=
 =?utf-8?B?cE5ISEswTVJoZFNmRzY3L2RYVTdhdjVFSGhGcFppVEQ5V0JmWFF0SWgyZHo3?=
 =?utf-8?B?WHpFNU5EaCtnZEJ4bEx4QU9CbzhaVlFLWGJTcmVRS2R6ekYzVjltRVJnUjZk?=
 =?utf-8?B?cUJSam1Hd1BUcitjR0grUE80MmNkWnVqbm9LZDg0RElKak1NbGUyUzM2b0Qw?=
 =?utf-8?B?bHFocFVYUTlEbUdVZjBMQm83QW9BdnV2N1NlYktTWlhOTG9xM1dDOXAvd1dY?=
 =?utf-8?B?aFlHQ0szbC9Vc1pId2RTQjZqWEhSZkc5endiTVhGaHFIdkhOamxBVUUzZ1Vq?=
 =?utf-8?B?SmRqYnBvQTU1VXFZUklYdkRVTjV3PT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 35246aaa-4d04-44b0-18da-08da79dbff59
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 07:51:41.6892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 zt0hp0oJD4coOsfF37/QpEWZdIQa0lHzGTT+OpKdZl2faFlYzVe/0aaRMcScv6VenvDdLGmwkaNktjB0a8N4IYqJ9UCAXbsB/WcbWPh6atA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5416
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Aug 2022 07:51:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9140



On 8/6/22 08:19, Jan Kiszka wrote:
> On 05.08.22 17:26, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> A build with only the option `kas/efibootguard.yml` will not succeed.
>> Move the content to a include in the image directory and the adapt the kas
>> files.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   conf/distro/cip-core-common.inc      |  2 +-
>>   kas/opt/ebg-secure-boot-snakeoil.yml |  9 +++----
>>   kas/opt/ebg-swu.yml                  |  7 ++---
>>   kas/opt/efibootguard.yml             | 39 ----------------------------
>>   recipes-core/images/efibootguard.inc | 28 ++++++++++++++++++++
>>   5 files changed, 37 insertions(+), 48 deletions(-)
>>   delete mode 100644 kas/opt/efibootguard.yml
>>   create mode 100644 recipes-core/images/efibootguard.inc
>>
>> diff --git a/conf/distro/cip-core-common.inc b/conf/distro/cip-core-common.inc
>> index 5cd1603..20a30d2 100644
>> --- a/conf/distro/cip-core-common.inc
>> +++ b/conf/distro/cip-core-common.inc
>> @@ -11,4 +11,4 @@
>>   
>>   KERNEL_NAME ?= "cip"
>>   
>> -WKS_FILE ?= "${MACHINE}.wks"
>> +WKS_FILE ??= "${MACHINE}.wks"
>> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
>> index 2822cef..0791ea3 100644
>> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
>> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
>> @@ -11,16 +11,15 @@
>>   
>>   header:
>>     version: 10
>> -  includes:
>> -   - kas/opt/efibootguard.yml
>>   
>>   local_conf_header:
>> -  image-options-swupdate: |
>> -    CIP_IMAGE_OPTIONS_append = " swupdate.inc"
>> +  ebg_secureboot_bootloader: |
>> +    SWUPDATE_BOOTLOADER = "efibootguard"
>>   
>> -  swupdate: |
>> +  image-options-swupdate: |
>>       IMAGE_INSTALL_append = " swupdate"
>>       IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>> +    CIP_IMAGE_OPTIONS_append = " swupdate.inc efibootguard.inc"
>>   
>>     secure-boot-image: |
>>       IMAGE_CLASSES += "verity"
>> diff --git a/kas/opt/ebg-swu.yml b/kas/opt/ebg-swu.yml
>> index 5e4e771..9c50358 100644
>> --- a/kas/opt/ebg-swu.yml
>> +++ b/kas/opt/ebg-swu.yml
>> @@ -12,12 +12,13 @@
>>   header:
>>     version: 10
>>     includes:
>> -   - kas/opt/efibootguard.yml
>>      - kas/opt/swupdate.yml
>>   
>>   local_conf_header:
>> +  ebg_swu_bootloader: |
>> +    SWUPDATE_BOOTLOADER = "efibootguard"
>> +  ebg_swu_image_options: |
>> +    CIP_IMAGE_OPTIONS_append = " efibootguard.inc image-uuid.inc"
>>     initramfs: |
>>       INITRAMFS_INSTALL_append = " initramfs-abrootfs-hook"
>>   
>> -  image-option-uuid: |
>> -    CIP_IMAGE_OPTIONS_append = " image-uuid.inc"
>> diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
>> deleted file mode 100644
>> index cee9c78..0000000
>> --- a/kas/opt/efibootguard.yml
>> +++ /dev/null
>> @@ -1,39 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2020
>> -#
>> -# Authors:
>> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -#
>> -# This kas file adds efibootguard as the bootloader to the image
>> -
>> -header:
>> -  version: 10
>> -
>> -local_conf_header:
>> -  efibootguard: |
>> -    IMAGE_INSTALL_append = " efibootguard"
>> -
>> -  efibootguard-swupdate: |
>> -    SWUPDATE_BOOTLOADER = "efibootguard"
>> -
>> -  efibootguard-wic: |
>> -    WIC_IMAGER_INSTALL_append = " efibootguard"
>> -    WDOG_TIMEOUT ?= "60"
>> -    WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
>> -    IMAGE_FSTYPES ?= "wic"
>> -    WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
>> -
>> -  firmware-binaries: |
>> -    # Add ovmf binaries for qemu
>> -    IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
>> -    # not needed for Debian 11 and later
>> -    OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
>> -    DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
>> -    DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
>> -    # Add U-Boot for qemu
>> -    IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
>> -    IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
>> diff --git a/recipes-core/images/efibootguard.inc b/recipes-core/images/efibootguard.inc
>> new file mode 100644
>> index 0000000..d6a7db6
>> --- /dev/null
>> +++ b/recipes-core/images/efibootguard.inc
>> @@ -0,0 +1,28 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2020
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +IMAGE_INSTALL_append = " efibootguard"
>> +
>> +WIC_IMAGER_INSTALL_append = " efibootguard"
>> +WDOG_TIMEOUT ?= "60"
>> +WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
>> +WKS_FILE ?= "${MACHINE}-efibootguard.wks.in"
>> +IMAGE_FSTYPES += "wic"
>> +
>> +# Add ovmf binaries for qemu
>> +IMAGER_BUILD_DEPS_append_qemu-amd64 += "ovmf-binaries"
>> +# not needed for Debian 11 and later
>> +OVERRIDES_append_qemu-amd64 = ":${BASE_DISTRO_CODENAME}"
>> +DISTRO_APT_SOURCES_append_qemu-amd64_buster = " conf/distro/debian-buster-backports.list"
>> +DISTRO_APT_PREFERENCES_append_qemu-amd64_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
>> +# Add U-Boot for qemu
>> +IMAGER_BUILD_DEPS_append_qemu-arm64 += "u-boot-qemu-arm64"
>> +IMAGER_BUILD_DEPS_append_qemu-arm += "u-boot-qemu-arm"
> 
> This block is only for testing purposes in isar-cip-core. Therefore, it
> was not part of any image but of a overwritable kas config section.
> 

Ok then I move it to kas/opt/ebg-swu.

Quirin

> Jan
> 





