Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C86EC54FB9
	for <webhook@archiver.kernel.org>; Wed, 15 Nov 2023 14:45:47 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.52])
 by mx.groups.io with SMTP id smtpd.web11.14890.1700059536931014906
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Nov 2023 06:45:37 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=knbBPYLf;
 spf=pass (domain: siemens.com, ip: 40.107.104.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekLfNnn9EuvUZMPiN96mkirCm5AFPT5xd/vjLkyDPJUL4YZNw04rx8DLoTBeGS0xsSIesFISfWpePL1JUyNY0g5LYp/L9obgauteud0gDjxNKISKKRyyPigR+wwQuanSVfIuaILHxLIkB9Kz7XHymYpuXilUsQYQjh0Go9WYV9P/D4CnWTAFiDs3ZamJxBJa4vxL1bNQJGrsOYwQiXuyS2NdvP8k311QGF//BGgBJCcHuUiZaYUFOh9mahg1eUQwAhp0XlV+AP8xgNscD/Mi9JxHeokX2+qkHCu+9vgriMeoVCXgH6urmN2EQF3tieers0zdrj1vtRBWjv/3/CMg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3MIaNxur1zcTWxZu/ct5QfY4ExnlLOAAvJVmznZjOA=;
 b=UjuVxoUsm9ns+rNVj5tFYolPEN1Gq9K3hSMg25ViKqA9t/cckTygDYpGT8sJzD2C8+DFzTDM+xtRHoBEgHdWVj1PAA0UaLQ33f8hKStOJz1K7S9mj2W0UdGWF6ZHsVV3QG/ZhkuJZQGme/MyUTs55TxMg0vruM+lJ6Pw1nPgNz/Ma4gUR/pNrtCCEBktR3VlWleFKY+MKb2YIl7VppW0hPmDXGK+/q62b9ZaBT3LwQ3fg/8aG37c/21EGtCrSx+N2kO3+/eMGWfB2kFvBMs3bYA8DQXy0SjC7LfPcnAswZLOO4yRtzZ2Bu1PzVOd6s4yOWfvRwbPrrFNOwErzpIWLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3MIaNxur1zcTWxZu/ct5QfY4ExnlLOAAvJVmznZjOA=;
 b=knbBPYLf+NFt8kHaJWHPRxeLagfXTet4VN7x58CWmEcRoYGqMOjWvjOb3610QUcmoM7raFBT1AZWdmy1rHs1TjwrOAceT/MBp9xY5l+xWCUpPrd02RFEbYislpg93uF2Tb9iNgaOQ1UoIROyU+eq2sGb3Z16HKwj7D+RkXcry9mJF22IY6I9D5rFbOHxLLAVTUM4zNrzx4U0NxdW6XIbYh7Q4BphmCAR0y7dpaiA6iUI+Ii+C+bRXbppeMZhXJcba+C0/oHD9qAKNDHTHPn+9ajCOdzl7Hh58BHFUB8f3frtqFW5t2U+aKet0Q41qRF8jGQ7CWygainyVYOOh5xe8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7434.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:422::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 14:45:33 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7002.019; Wed, 15 Nov 2023
 14:45:33 +0000
Message-ID: <6e0de253-9504-4de8-8b23-849d6dd2bdcf@siemens.com>
Date: Wed, 15 Nov 2023 15:45:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: Update debian folder to
 2023.05+dfsg-4
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231114163751.1199552-1-Quirin.Gylstorff@siemens.com>
 <eb98a52d-9bd0-4583-a148-81ef1253c6ab@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <eb98a52d-9bd0-4583-a148-81ef1253c6ab@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0424.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: a22f5a35-dcc3-4f71-95cd-08dbe5e98547
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IZEg8x9JEWpLKY4RuIjbOBbuMCiPyL4l0omFKLy/gtZxlKbL8MRnKW/FRGmCQLLqEwdclmuft3s1QOuvPS3ki3dfmzANbREzRyNKqqpBigehH2ATvMGIOVM7x5VrMSpCaRHVfNBWUMvEUF8SjoGw5iE5NQKeK6jPzwyZBF0J7YL4t0PpY4/J4MhN8yoSuiGS9nzOrmMKQUBqbSJjZvGoSg2miQMITxDbI7HstvuOhp/7PWHSRN9Zoix/I7I/N5kuDCX2WoAiseBG2AH2nfVFAhVN0KBJGkgIGKlETy+DTxYQQK979Jr9Kpxim0OHH+UanP2csS0PUtY48aZYTZXlR4zDjIAVkk6XSxhpbDGUDq0P4E0i28s7I8fX9URl4+EtSsetvLgDbp+UPcTFqP5L8Y9IM8PZjPFBa5gxamTu7JAlhuisLZ5zIeSu7uUPpjzLDwooGplmla8/f1gatIGF0K8dpttf1YcMwnkZQaWyL58seMVVjID32wN/G2o/9ReJSzOAMkRARYZnd1exWWo0gycmkc219E7s+7Et+AJ2BKqlnRgrWHD7/mFxeg+243lXEYX3Fm3VxodJAbet5ulWnVMC2CHk+FxwRFS5tPaUlYSJhIDonjvdGbvPDm3N+XNhc7GeRlX8lbdOhGPZC466EQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(66946007)(66556008)(66476007)(6486002)(31686004)(2616005)(478600001)(8936002)(316002)(8676002)(6506007)(53546011)(6512007)(31696002)(86362001)(82960400001)(41300700001)(83380400001)(5660300002)(38100700002)(36756003)(15650500001)(30864003)(26005)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V0R4NmRRZ1NhODhlWllDSmR2TEhBZGptYnU0ZEhFN3EyelFMWUFOYzlHdXR2?=
 =?utf-8?B?U0NFamR4T0hqbVhLOHJ1UytHNFFKZGdhTW95VXNSQzVOK2JzQTBMRUtWaUdJ?=
 =?utf-8?B?UU5POHFrNlp1UE1Xd1VtdWlJZHQ4b29BRUU4VXBSdXlVd3Z5Y3laQVRINDdo?=
 =?utf-8?B?ditYRklGYW8ydjd5eG03V1F1Mkp0VWFTUlZNS1JHUkpLa0p1VEdKckFPcHRI?=
 =?utf-8?B?ekwzeFFwRkJKSFpWNDJwbzB3WFJqU0xHa25kN2IybjdBbndPN0VnN2JOMVgr?=
 =?utf-8?B?UWhzV0JNa2FIOUdIS1dhM0pUYTRLbEtlWFFZQ0kxK3RaZUREY3FmN1NNVmda?=
 =?utf-8?B?T0FHRnVIMGdKZVFuYVMrejdkNDBobC81MisyVTAzWFV6YkdLSVpsWi93R0dO?=
 =?utf-8?B?TmNRYnJnRjg4ZE9CYjZlVnd4eitMcEw4RFZwZnpVNURSUWxac3ZKUjk5Y3ly?=
 =?utf-8?B?dTVUdTJqczAwZkNWQS82MDJIVjVnTm0xdFdzY2VSMTZzUEdRUEhpQ2hvQXBr?=
 =?utf-8?B?c3UybnhGUXB0Q0k1WStBL3pZVjVLLzhqS0xsNFRHZzUrYkJtRE9mWjdXNElJ?=
 =?utf-8?B?SVZZTW5kUXBZZVlQZDVTTUlIdGd1blJ5OW1rUC8vZExib2FUbDNhWkpyUlFR?=
 =?utf-8?B?cjd2YmpoZFdrYlc1VEw4NWtCcUNxSDBvTXhnMzFEWXh4U1c2Mzc2MTFUNXNY?=
 =?utf-8?B?a3RnUXlkS2dTdkhUenFyUWxvRWFtR2pTNXZjYzJodmdKc1hkckdHV24zYmhN?=
 =?utf-8?B?NlV2WVM4NWJmQVE5MEsyUXBvL1ZhbzF3cW9XSmozeDhtc04ybVM5TklSdVBy?=
 =?utf-8?B?RWdhcFBkU1JyTmRyZXhEVTJTTi9QZEx2aVViUEZ6eXcvd0FDQy9OTGN4TEg5?=
 =?utf-8?B?QW1HQ2pxYzREaElwcmpMTUw5bENvejRiT3czbTIvamtramUwTjBOS0FWYUtI?=
 =?utf-8?B?OGt0cEZoN1IraGdOT2RnU2c4T0x5Z0FocmtCOEd3eS80aFVYVDd0L0s0bFlj?=
 =?utf-8?B?UzdTaFdlRjdpYkx6bnRMOXVRaUx1bzhhZmFhS1hNSWhtQkV2Q3JrVGZtMHFD?=
 =?utf-8?B?Vk1jWkhNaXllQllFVnVYSVJySC83V05WOFVKU3FxWVY0TWdwUFQxekZraXF0?=
 =?utf-8?B?Y3NBazAzTFdXU2U1NTRaZEVnZlFTZXpMWERGelFxa2lqeWhiaGNISmw5NFMx?=
 =?utf-8?B?cDlEMWl3S0Z2Z1BVeS9JNzNYUFBicXlCY09yN1R0djFTLzhtSnB0WmZFTmEz?=
 =?utf-8?B?ZGZSazBUQnlHU2xGY3c5VG05ak5wZmlFN1llY2F6SnpGTitGOVRkY1IvenNC?=
 =?utf-8?B?c2J4VzV6TFZGNEJpNXh1WWFXVVNFZ3JEQnlaMFREZjhYZ3pHWmFVY1ZzS1hj?=
 =?utf-8?B?R25kanRpV1dIdnpMR1ZzZWpHT2VDb2xCSjgzU0JqREM2RXVTS3pUanhCZW4x?=
 =?utf-8?B?MnR0bXlMS1FLVVVYTnRaQzQ3RUtQRVAyNTBoc2VtQmxQeEp1TG4wdkt6ZEkz?=
 =?utf-8?B?WHZLWG10aE1BSHl3V1hhMmF6UDBJUnNUQjlnUHloUm9GTDBiOVB0NHhwZEJ2?=
 =?utf-8?B?dlc4bXMzVmlmVFhMQ3J6MzQ0NDhwK1ZNWWV1Znp3bHloWVJ0bmtVZ1JNa2FU?=
 =?utf-8?B?cDVGSGNhQ1pjQ1pWWDljSzhjUlhHWkJaTEpjNVNFUjFOYzVuL0JDdlRBckMr?=
 =?utf-8?B?enRBL1dOaDV6ZElKWVZ1c0tRTFBOK1dGRnR5RmNqQkNBckNzWXp2WGlLeXcw?=
 =?utf-8?B?MDBnRThWMUg4cmlVcFM5YlpsT3pVSWRPVHlRSVYyVHRKVS9jbndqM2Z2aG5l?=
 =?utf-8?B?dzlaNU5EQjVGeHdPOGpHSjNFZ3FyZmJDWklnNm1BSUFySU9hZ0dETGxSUkQ3?=
 =?utf-8?B?akpIdHJFSTFqVDAxVm5PQkUwblFpUEF3ektob01JZXVmYTlSdndFYW42NEZo?=
 =?utf-8?B?ZWUwWUhNV01VM28xWXU2cHdIdVpQRDIwRG5vR2xHM1FWTHdmUWExYnBoUlN4?=
 =?utf-8?B?YVlTYW92Vm1vWUNBSnBWQW5QNGZROFh0WGFjSERsREFWM3FWaUQ0TGpNb1Jp?=
 =?utf-8?B?OXNab21ONzBZaDlIOUNoWWNoTjkwMzdOMUNuWXZVQzcyU2pQYkNDSzdXRkNL?=
 =?utf-8?B?SlhYdEc2Ly9yRnEveEg0b2dDZTFFaEZkOEpXK0tRU1czTi9DTW9UZ3YzaFlo?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a22f5a35-dcc3-4f71-95cd-08dbe5e98547
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 14:45:33.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOj8rQ0wrUCSnQTIJwmQyvV0ajR8aepb0mWnGAg+f7qzKWPiX5+6nyf0OFd93qCmCvkhu6YwJv6ohbiDSQMeKRBqSggWqA+Nlb1tSfrMydI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7434
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Nov 2023 14:45:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13587



On 11/15/23 15:40, Jan Kiszka wrote:
> On 14.11.23 17:37, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This adds the system user swupdate and changes the permission
>> of the sockets to 0660 instead of world writable.
>>
> 
> Stefano had some concerns about the best aproach. Is this Debian
> revision already reflecting those?
> 
> Jan

This reflects the latest communication I know with mode=660 and an added 
swupdate group.

Quirin

> 
>> Also suricatta lua is now set automatically.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   ...d-rules-Add-option-for-suricatta_lua.patch | 30 -------------------
>>   ...ate-build_profile-option-for-delta-.patch} | 16 +++++-----
>>   ...ch-to-add-the-build-version-to-swup.patch} |  8 ++---
>>   ...-Add-option-to-enable-suricatta_wfx.patch} | 14 ++++-----
>>   recipes-core/swupdate/swupdate_2023.05.bb     | 15 ++++------
>>   5 files changed, 24 insertions(+), 59 deletions(-)
>>   delete mode 100644 recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
>>   rename recipes-core/swupdate/files/2023.05/{0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch => 0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch} (76%)
>>   rename recipes-core/swupdate/files/2023.05/{0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch => 0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch} (94%)
>>   rename recipes-core/swupdate/files/2023.05/{0004-d-rules-Add-option-to-enable-suricatta_wfx.patch => 0003-d-rules-Add-option-to-enable-suricatta_wfx.patch} (69%)
>>
>> diff --git a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
>> deleted file mode 100644
>> index 5aeb605..0000000
>> --- a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-for-suricatta_lua.patch
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -From f94f8c2f62ade7568fe8fafa106488761fc55f91 Mon Sep 17 00:00:00 2001
>> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -Date: Wed, 3 May 2023 16:02:37 +0200
>> -Subject: [PATCH 1/4] d/rules: Add option for suricatta_lua
>> -
>> -This allows to use lua plugins as suricatta backends. It is optional
>> -as it overrides the default HAWKBIT backend.
>> -
>> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ----
>> - debian/rules | 3 +++
>> - 1 file changed, 3 insertions(+)
>> -
>> -diff --git a/debian/rules b/debian/rules
>> -index 57da4ca7..91106fbd 100755
>> ---- a/debian/rules
>> -+++ b/debian/rules
>> -@@ -56,6 +56,9 @@ endif
>> - ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>> - endif
>> -+ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>> -+	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
>> -+endif
>> - ifneq (,$(LUA_VERSION))
>> - 	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>> - 	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>> ---
>> -2.39.2
>> -
>> diff --git a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>> similarity index 76%
>> rename from recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>> rename to recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>> index 4203061..d92860e 100644
>> --- a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>> @@ -1,7 +1,7 @@
>> -From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00 2001
>> +From 8d9d7b561f311b2bd2757ee3f14ca51b22563118 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Thu, 15 Jun 2023 18:48:25 +0200
>> -Subject: [PATCH 2/4] d/rules: Add seperate build_profile option for delta
>> +Subject: [PATCH 1/4] d/rules: Add seperate build_profile option for delta
>>    update
>>   
>>   Delta update need zchunk 1.3 to work on memory restricted
>> @@ -15,20 +15,20 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>   
>>   diff --git a/debian/control b/debian/control
>> -index e47c320c..d4b17972 100644
>> +index a389b2a9..2f0c0053 100644
>>   --- a/debian/control
>>   +++ b/debian/control
>> -@@ -26,7 +26,7 @@ Build-Depends: debhelper-compat (= 13),
>> +@@ -28,7 +28,7 @@ Build-Depends: debhelper-compat (= 13),
>>                   uuid-dev,
>>                   zlib1g-dev,
>>                   libzstd-dev,
>> --               libzck-dev (>= 1.2) <!pkg.swupdate.bpo>,
>> +-               libzck-dev (>= 1.3) <!pkg.swupdate.bpo>,
>>   +               libzck-dev (>= 1.3) <pkg.swupdate.delta>,
>>                   libp11-kit-dev <pkg.swupdate.p11>,
>> -                libwolfssl-dev <pkg.swupdate.p11>,
>> +                libwolfssl-dev (>= 5),
>>                   libmtd-dev [linux-any],
>>   diff --git a/debian/rules b/debian/rules
>> -index 91106fbd..8cac6359 100755
>> +index 05422d68..97afc92b 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>>   @@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
>> @@ -41,5 +41,5 @@ index 91106fbd..8cac6359 100755
>>    endif
>>    ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf riscv64 ia64))
>>   --
>> -2.39.2
>> +2.42.0
>>   
>> diff --git a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>> similarity index 94%
>> rename from recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>> rename to recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>> index 857b4ab..f6092af 100644
>> --- a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>> @@ -1,7 +1,7 @@
>> -From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00 2001
>> +From 81e9c0d781314bfff479bd5cb6a778f5d4e08ac3 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Fri, 16 Jun 2023 19:43:38 +0200
>> -Subject: [PATCH 3/4] d/patches: Add patch to add the build version to swupdate
>> +Subject: [PATCH 2/4] d/patches: Add patch to add the build version to swupdate
>>   
>>   The build version is only set if build in a git repository
>>   this patch allows to use the version information stored in
>> @@ -77,7 +77,7 @@ index 5638bbf5..12324569 100644
>>    use-gcc-compiler.diff
>>   +Makefile.flags-Set-version-if-git-returns-no-informa.diff
>>   diff --git a/debian/rules b/debian/rules
>> -index 8cac6359..566a21bd 100755
>> +index 97afc92b..18cd7643 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>>   @@ -17,6 +17,8 @@ export DH_WITH=--with lua
>> @@ -90,5 +90,5 @@ index 8cac6359..566a21bd 100755
>>    ifeq (linux,$(DEB_HOST_ARCH_OS))
>>    	BU_SWU += -VBuilt-Using="$(shell dpkg-query -f '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-dev)"
>>   --
>> -2.39.2
>> +2.42.0
>>   
>> diff --git a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
>> similarity index 69%
>> rename from recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
>> rename to recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
>> index 9c5ebd3..8a5bd82 100644
>> --- a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-enable-suricatta_wfx.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-suricatta_wfx.patch
>> @@ -1,7 +1,7 @@
>> -From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00 2001
>> +From 319f0d2f54781ef207bf16a4c85dc8de20796ed4 Mon Sep 17 00:00:00 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Fri, 16 Jun 2023 20:32:38 +0200
>> -Subject: [PATCH 4/4] d/rules: Add option to enable suricatta_wfx
>> +Subject: [PATCH 3/4] d/rules: Add option to enable suricatta_wfx
>>   
>>   Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
>>   suricattawfx lua module.
>> @@ -12,12 +12,12 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>    1 file changed, 3 insertions(+)
>>   
>>   diff --git a/debian/rules b/debian/rules
>> -index 566a21bd..fc122d0d 100755
>> +index 18cd7643..9635adb1 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>> -@@ -61,6 +61,9 @@ endif
>> - ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>> - 	echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
>> +@@ -58,6 +58,9 @@ endif
>> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
>> + 	echo CONFIG_PKCS11=y >> configs/debian_defconfig
>>    endif
>>   +ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
>>   +	echo CONFIG_SURICATTA_WFX=y >> configs/debian_defconfig
>> @@ -26,5 +26,5 @@ index 566a21bd..fc122d0d 100755
>>    	echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >> configs/debian_defconfig
>>    	echo CONFIG_LUASCRIPTHANDLER=y           >> configs/debian_defconfig
>>   --
>> -2.39.2
>> +2.42.0
>>   
>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-core/swupdate/swupdate_2023.05.bb
>> index 762fac2..8d50ec3 100644
>> --- a/recipes-core/swupdate/swupdate_2023.05.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>> @@ -22,16 +22,14 @@ FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
>>   SRC_URI += "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;name=upstream;destsuffix=${P}"
>>   SRC_URI += "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
>>   
>> -SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
>> +SRCREV_debian = "78cb6f20319d2b911e170eea5305f2cf0bd33030"
>>   SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
>>   
>>   # patches
>> -SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>> -            file://0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
>> -            file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
>> -            file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>> -
>> -
>> +SRC_URI += " file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch \
>> +            file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch \
>> +            file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch \
>> +            "
>>   # The option: "pkg.swupdate.nosigning" disables the required signing
>>   # of update binaries
>>   # DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> @@ -39,9 +37,6 @@ SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>>   # deactivate hardware compability for simple a/b rootfs update
>>   DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
>>   
>> -# suricatta wfx requires suricatta lua and the dependency
>> -# is not set automatically
>> -DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"
>>   # add suricatta wfx
>>   DEB_BUILD_PROFILES += "pkg.swupdate.suricattawfx"
>>   
> 

