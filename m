Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1C3C61D85
	for <webhook@archiver.kernel.org>; Thu, 23 Nov 2023 10:24:56 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.48])
 by mx.groups.io with SMTP id smtpd.web10.87975.1700735092676157920
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Nov 2023 02:24:53 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LQVEFmUx;
 spf=pass (domain: siemens.com, ip: 40.107.8.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5WNHmxH7141uv7ttJxNFf7ARSZptx8cjeAwabo5R94WIuWxMHGhYQajOd3gdu81dnPPojqK12YSrZaCiJlF8rDcgsxErhymrBmS0tUnr4mnJQIreWZnL5Nl/YTfYMVJg7Z2ab9Ao/ux3TaPlAZjWfkUjr7qbmMx8qp2YcUrU/ofiamy2mqdlnoHUQOn07uqI+D8nCWAkSRkJKTZHO1ft4SOuc1RUylSute65SX1mkQxk7djDSNjImwA7ljSx/fdCHkaXJugM2KapEgQwzy4aGB78MGbBKsX44HOqFZNPRyke+BhmjmHbY1fNearHtFQ3K8gmwGsstebRdoael36rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUh9HEn0xmGFYJEA0+IR+PZ5BjssErUi2K5Y8j2flDY=;
 b=WyZBIeOaPZNHtteVMWmo1eqRgGz0kMXdOjDND8BPd23rK4X9uPA8hgCOCR25NuRHPlfGdIs03rBunxxeNLqYP3lm9Zlw4VRfDlUQYoiAhC+BFjv5e6hwGeD3Eh7BemI/S0zk+s/6v/AwJb2lRPjEB9uNdHiXtJzpTZ1+3U+NPtUEyzfKn94eTVa/SrvwOBhgxcag1tQw2JBxEUclAeRZgBHpnw2A2eQWreM6EF/5SY7//rx9Dygr76LniCeivzbkHstaFghA4S4pc2/x8BLIXEjghcZhnEwNSyc0I2VlNA4is9RFkUYOeQ7bGyZaaeocNPrsbBFkLGkFf81sDRHzag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lUh9HEn0xmGFYJEA0+IR+PZ5BjssErUi2K5Y8j2flDY=;
 b=LQVEFmUxecDGsw0mtjnYbqAa2L6+D9D7aXCZPmE6jnEKHSi5XyIW8FiD5mOo6N4NLpLkjkaVaxK4/SG3rajoLYF53BYo5Q424suzOvR6AbmMP1ih5ykyLaXu5uAgIWntPepJb0Zh1mFUHhaFst+RzOGJdOWod07TiYCI32bvkY1zVbmFoucwwFX74ydxITGhjmSMqKohkBK0LkMRePWR0HXXrXRPWqtyy05HxP8hBY9OedaMQY/LgRqx2YhVoxIwZY5SsFlVxHH0lUsfscEmZhFHn6a3bJS7w1DzeWhL27CpJnhGRKCMHfJl6CAnPzypd+XoCT/oJUZsjcnz8RZJOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS1PR10MB5532.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:477::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 10:24:49 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 10:24:48 +0000
Message-ID: <c5bbfddb-161e-4083-a36c-58d01cd4dace@siemens.com>
Date: Thu, 23 Nov 2023 11:24:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][Patch v2] swupdate: Update to
 2023.05+dfsg-4
Content-Language: en-US, de-DE
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20231120134225.1243400-1-Quirin.Gylstorff@siemens.com>
 <3b9137d350f9c7979fe6bac1aa7a79d71bd8a7ad.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <3b9137d350f9c7979fe6bac1aa7a79d71bd8a7ad.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0017.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS1PR10MB5532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebece18-af19-47a3-0b66-08dbec0e6bc3
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZjNZArheQfqY7BgtuDjLVWZvRpn9L7TTuVdv8yjanrFxJoyeQzt6uUaR8JFSkmCHx8H7ZSpfHcNQGmHo/qwzjiuIN2S7Amj5vVfMxQ9hwfrUqWkHr+fODzy2jOO0dWXKkqnDWsoVH8dChS5Jk1hJP/OK6ulf/Iym214cE/KaQ91T/xXZtpxiuDhueDUooS5TUYvya2try5jEsyqkKOMnYORq4ArgYwb1KESESyvoyxvgukQZMN7wFpLi54bkOKzpwh0z8nIh7zBFx0jDJJdtojU3nfHk9aIk+W4OfJw8nBq2kYCSzLC+WdaC2+AZW30pAj2pw5hxFr5J1B8+y/Rqu5SPd8rvjUQELBAoifJ+Y90UtdcsvcKnY2NhCEfqPKtm9BvkDaRazeM27X7lxsaHAf2apmzHO6IKlQMnX2tdjThowJG4yCJX5P/G+9yoMDPS5x5k/NYv2HE6BoewPb7vGaxHh+yQv10fIYRYZKw6nVHXLE93sOhQhFhd4PP7uSz2MvTxttK2jKTXVcZO6sj1xtiEXxLcQHthtuFmGRziq4TCLA+Xab0LR/R8Y1k7rKnEOPOT/lGOvkrBu4PG+IcvccDXshc0Vhze5IZdUKRqJ+jU7HL6aEweN/bXPXubciOSZzM8JsVhw2SO+GZV53NNaw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(38100700002)(82960400001)(15974865002)(86362001)(31696002)(36756003)(66556008)(6636002)(316002)(66946007)(66476007)(8936002)(41300700001)(8676002)(110136005)(5660300002)(15650500001)(4001150100001)(2906002)(30864003)(31686004)(53546011)(6512007)(26005)(2616005)(478600001)(6666004)(6486002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dzVuQnJVNVFGTmQwekJBMTRkTWI3UDVMaUJBTVRWcWhYUmZRd3VBQ0RWeUFL?=
 =?utf-8?B?UUVhbWMvZGxNQmp4QUR4dXoxbjNPRWlYM2FvUlBGc3FPdURZa1hsSU1vV2l5?=
 =?utf-8?B?Z1cwUkFYN05GOW5NdnBIbkJJRFlyUXZPQlp4dE9XcWJQSmdLUmFCZEVnUDBI?=
 =?utf-8?B?RUc3MHRVQjNUYVBaTUIxSXFsUXBUWFppY0pYLzNJbjFJcFdsQzY1ZzBvaE5x?=
 =?utf-8?B?cUVzNk5HbGw5MGZGdEFkYWUxc1NMYWk1RjBWZnJMTGxEM0phdzZkZlhON0xQ?=
 =?utf-8?B?SWxiYnFMV2RjTVExUGlZWllrdXpXZ05Lb0pVdm5WaG5QT3dkenlOOXBDOEZC?=
 =?utf-8?B?MklTaXlDTTl5QnNYazhEN2xvY3Q3MExuZzBGNWNyL2lKclJ6bzloUUJEazly?=
 =?utf-8?B?T2NFVlpTLzRPUlZ6Wi8vdE5weUh6S1d0aVVmbnp2NFVVL09VYzBZL1IwVTE1?=
 =?utf-8?B?QlFGSnhibTV4TnJnZXhTSVlUMXJsQ1h3WHdBbHBNdGFDUlVoekFCTlNSQTBw?=
 =?utf-8?B?T0gvKytoekxmSHI5NjZkTWJ2eHhJdWIyMnpONldzY0pxNERGamJtMndHczc1?=
 =?utf-8?B?aU83NFZ2UmllQysvZzJkOTg3d0FhNnVUS0gwVXdoaVFuQkxTN2VXS1R2YmJ1?=
 =?utf-8?B?MURJS09WNFcyME90QTR2WWRDMjlFRkpzQ3NRL1NtSVlvN0FlTmhoWWp3UXIr?=
 =?utf-8?B?a2RiY3F1K2N4dzlGRjlEODZnbFFmWC9xZEdrRHZ4WnIrWnRDZzc0WXFyVjJx?=
 =?utf-8?B?VUlMNXNNZWhRWE14UldwbU9MQzNWclpaa1hGSTJWMGlqcWRXMFlodjZrRXNZ?=
 =?utf-8?B?M2x4cDJ3cG5qMEFzei9LeURackdXeENrS2g1RUpmS0Q4bCtWdGR2NTdQakVr?=
 =?utf-8?B?TlBIQU9oVjQzSWJyT3J3eGkrUExRN1NxVmM3ZWNiRFhJRVdsL1hsaURGUkdV?=
 =?utf-8?B?d3htV3dJcTM5RGhhSmFxMUVYZVI3L0RRbnZxUVdqZEQweDRmQ1E5NEZTR2ZE?=
 =?utf-8?B?RTJ6UURBKzRMWEZIMUQwdDRaVGNnQ1hWb2d0OG5VbDdyN0pKaVoweDJXVWFZ?=
 =?utf-8?B?MHVaSHM2bDd4VkdqS2lxbFBPK2RTc2RvQTBOUTBoSTV3VWs3MFFsYWxQNkRX?=
 =?utf-8?B?cDJZNVZ3ck9zWW9NMUVtWkNCK0c4bDU5MXhCTk45U1htWHVQZ0l4YUlmTWVl?=
 =?utf-8?B?cmE5R3BJc0J6WHNxLzBkaGlZRVphVTZLeDkwZlJNSWkxMWZYa0RDdnFtLzlX?=
 =?utf-8?B?bjNDWk9WamowbkZMRU5maFlVOE9KUVlaMmd4bEJDNGpKREdFYU4wd2x2RU42?=
 =?utf-8?B?WWZwYldBb1Z2aVhXVUNpYm5wN2RQb0JTN3huTnJwc3hoNDlKU1UremQ0ZzNH?=
 =?utf-8?B?czdqUVJ1bkdyZnFpamRUc3Y3RGNpcG9oYzJHY1owRzgyQVFza1FWa0ZCWCtN?=
 =?utf-8?B?T3NNengvWFpKakc1eEcxcmFLVzErMDN0WVFHWTZNeGVCTkMrb2t1bXQxN2wy?=
 =?utf-8?B?TE9JbE50elJmK2pYZ3dRVUVnaHVvRkxFQUVpUWdIbnY3T3B4UEJ5QThxREdV?=
 =?utf-8?B?T0NCaFNsRENuRFBySjFla1hEVyswd3RpZXk3U1ZJaTRzWWI4TUwxbllFR0Q2?=
 =?utf-8?B?NDg3MXFSQlcvMjBsWFVKSXErUWgwaU5MSmpCbmhQR0V3ZTE1eVhFSzhab0ZY?=
 =?utf-8?B?bSsrQnlOYklzNE5uRWxwSUpHci9EclFpNkRlUjdIbFBIdmVnQkYrMDNidEdH?=
 =?utf-8?B?b2NvLzVCaUpxYjJlSW13Z2dCTlBiMml4NUFabVJnU2dGdWpBVVBNMjROSklI?=
 =?utf-8?B?U1BRVEdDczBNRElzL1lGWmcySVZGd0pkaXlaVWRybmNaOWZHNmlUVkFuTjRw?=
 =?utf-8?B?TFcxakdoaXV3aXlmQ0k3VkU5UUFNekRkTXpiS3ROc0tSQVIrU1Nsb0lJUXVU?=
 =?utf-8?B?Mm9jTE93T2MyYVBlZTFaWGJYQ3J2c2dlVWpXend1d2RpMkorbzlveldFWGNS?=
 =?utf-8?B?bGxxL1RnWDBFcThkbHl5dWRPQndIVEtsaWxCVGt4aDBPZ0lUZG9odGNqcnRW?=
 =?utf-8?B?WTR2U0F2OENuK2NYUUFDM0RQQVVZNFM4RERJOTNnbHdaSmxrQkRqQjlVRUJh?=
 =?utf-8?B?a1dPbVA3SlA0a0xFa3VNRUZGZUpNcGdSTUVRRDg0NFBNZGNIUkN4eU1PNVp6?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebece18-af19-47a3-0b66-08dbec0e6bc3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 10:24:48.6721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEXZ7FPoEFalZspPVpq+2nwzvWjudaCQj03GAq0y+MoAADBwhtKo8yz5MogKFmfNGy1IkO042hYXteu8NuR9RJvfi1OUUER68HRv2iekHuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5532
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Nov 2023 10:24:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13660



On 11/20/23 15:18, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Mon, 2023-11-20 at 14:38 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This adds the system user swupdate and changes the permission
>> of the sockets to 0660 instead of world writable.
>>
>> Also suricatta lua is now set automatically.
>>
>> swupdate uses  wolfssl (=< 5) instead of openssl for
>> certificate management. wolfssl(=< 5) is only available as backport
>> in debian bullseye.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   ...eferences.swupdate-bullseye-backports.conf | 10 +++++++
>>   ...d-rules-Add-option-for-suricatta_lua.patch | 30 -----------------
>> --
>>   ...ate-build_profile-option-for-delta-.patch} | 16 +++++-----
>>   ...ch-to-add-the-build-version-to-swup.patch} | 10 +++----
>>   ...-Add-option-to-enable-suricatta_wfx.patch} | 14 ++++-----
>>   ...install-Fix-path-for-debian-bullseye.patch | 24 +++++++++++++++
>>   recipes-core/swupdate/swupdate_2023.05.bb     | 10 +++----
>>   7 files changed, 59 insertions(+), 55 deletions(-)
>>   delete mode 100644 recipes-core/swupdate/files/2023.05/0001-d-rules-
>> Add-option-for-suricatta_lua.patch
>>   rename recipes-core/swupdate/files/2023.05/{0002-d-rules-Add-
>> seperate-build_profile-option-for-delta-.patch => 0001-d-rules-Add-
>> seperate-build_profile-option-for-delta-.patch} (76%)
>>   rename recipes-core/swupdate/files/2023.05/{0003-d-patches-Add-
>> patch-to-add-the-build-version-to-swup.patch => 0002-d-patches-Add-
>> patch-to-add-the-build-version-to-swup.patch} (93%)
>>   rename recipes-core/swupdate/files/2023.05/{0004-d-rules-Add-option-
>> to-enable-suricatta_wfx.patch => 0003-d-rules-Add-option-to-enable-
>> suricatta_wfx.patch} (69%)
>>   create mode 100644 recipes-core/swupdate/files/2023.05/0004-d-
>> swupdate-www.install-Fix-path-for-debian-bullseye.patch
>>
>> diff --git a/conf/distro/preferences.swupdate-bullseye-backports.conf
>> b/conf/distro/preferences.swupdate-bullseye-backports.conf
>> index a2377bb..e1cd1f4 100644
>> --- a/conf/distro/preferences.swupdate-bullseye-backports.conf
>> +++ b/conf/distro/preferences.swupdate-bullseye-backports.conf
>> @@ -1,3 +1,13 @@
>>   Package: dh-nodejs
>>   Pin: release n=bullseye-backports
>>   Pin-Priority: 801
>> +Package: libwolfssl-dev
>> +Pin: release n=bullseye-backports
>> +Pin-Priority: 801
>> +Package: libwolfssl35
>> +Pin: release n=bullseye-backports
>> +Pin-Priority: 801
>> +Package: libwolfssl-dev
> 
> Hi Quirin,
> 
> this is hard to maintain / read. Please put all wolfssl related
> packages into a single pin (e.g. Package: libwolfssl-dev libwolfssl35).

Sure will send a v3.

> 
>> +Pin: release n=bullseye
>> +Pin-Priority: -1
>> +
>> diff --git a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-
>> option-for-suricatta_lua.patch b/recipes-
>> core/swupdate/files/2023.05/0001-d-rules-Add-option-for-
>> suricatta_lua.patch
>> deleted file mode 100644
>> index 5aeb605..0000000
>> --- a/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-option-
>> for-suricatta_lua.patch
>> +++ /dev/null
>> @@ -1,30 +0,0 @@
>> -From f94f8c2f62ade7568fe8fafa106488761fc55f91 Mon Sep 17 00:00:00
>> 2001
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
>> -       echo CONFIG_PKCS11=y >> configs/debian_defconfig
>> - endif
>> -+ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>> -+      echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
>> -+endif
>> - ifneq (,$(LUA_VERSION))
>> -       echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >>
>> configs/debian_defconfig
>> -       echo CONFIG_LUASCRIPTHANDLER=y           >>
>> configs/debian_defconfig
>> ---
>> -2.39.2
>> -
>> diff --git a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-
>> seperate-build_profile-option-for-delta-.patch b/recipes-
>> core/swupdate/files/2023.05/0001-d-rules-Add-seperate-build_profile-
>> option-for-delta-.patch
>> similarity index 76%
>> rename from recipes-core/swupdate/files/2023.05/0002-d-rules-Add-
>> seperate-build_profile-option-for-delta-.patch
>> rename to recipes-core/swupdate/files/2023.05/0001-d-rules-Add-
>> seperate-build_profile-option-for-delta-.patch
>> index 4203061..0d0fc0a 100644
>> --- a/recipes-core/swupdate/files/2023.05/0002-d-rules-Add-seperate-
>> build_profile-option-for-delta-.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0001-d-rules-Add-seperate-
>> build_profile-option-for-delta-.patch
>> @@ -1,7 +1,7 @@
>> -From a5ab9aaa53acac4c4155b6c4cc8a86bc59278e53 Mon Sep 17 00:00:00
>> 2001
>> +From 03d455be74d439c7e2eb849e5acdfb494afb3d7c Mon Sep 17 00:00:00
>> 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Thu, 15 Jun 2023 18:48:25 +0200
>> -Subject: [PATCH 2/4] d/rules: Add seperate build_profile option for
>> delta
>> +Subject: [PATCH 1/4] d/rules: Add seperate build_profile option for
>> delta
>>    update
>>
>>   Delta update need zchunk 1.3 to work on memory restricted
>> @@ -15,20 +15,20 @@ Signed-off-by: Quirin Gylstorff
>> <quirin.gylstorff@siemens.com>
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
> 
> It looks like we diverge from upstream here (upstream does not know a
> pkg.swupdate.delta profile). What is the reason for this?
>
Yes this was introduced for enabling delta update for downstream.


>>                   libp11-kit-dev <pkg.swupdate.p11>,
>> -                libwolfssl-dev <pkg.swupdate.p11>,
>> +                libwolfssl-dev (>= 5),
>>                   libmtd-dev [linux-any],
>>   diff --git a/debian/rules b/debian/rules
>> -index 91106fbd..8cac6359 100755
>> +index 3b1cc0f6..2c91677c 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>>   @@ -38,7 +38,7 @@ ifeq (linux,$(DEB_HOST_ARCH_OS))
>> @@ -41,5 +41,5 @@ index 91106fbd..8cac6359 100755
>>    endif
>>    ifneq (,$(findstring $(DEB_HOST_ARCH),amd64 i386 arm64 armhf
>> riscv64 ia64))
>>   --
>> -2.39.2
>> +2.42.0
>>
>> diff --git a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-
>> patch-to-add-the-build-version-to-swup.patch b/recipes-
>> core/swupdate/files/2023.05/0002-d-patches-Add-patch-to-add-the-
>> build-version-to-swup.patch
>> similarity index 93%
>> rename from recipes-core/swupdate/files/2023.05/0003-d-patches-Add-
>> patch-to-add-the-build-version-to-swup.patch
>> rename to recipes-core/swupdate/files/2023.05/0002-d-patches-Add-
>> patch-to-add-the-build-version-to-swup.patch
>> index 857b4ab..8056818 100644
>> --- a/recipes-core/swupdate/files/2023.05/0003-d-patches-Add-patch-
>> to-add-the-build-version-to-swup.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0002-d-patches-Add-patch-
>> to-add-the-build-version-to-swup.patch
>> @@ -1,7 +1,7 @@
>> -From ed4e8b5d4ad6ffcddb755571303c077fff227ea3 Mon Sep 17 00:00:00
>> 2001
>> +From ad714bc12b03c148aadb3523f87cc14d42a477b0 Mon Sep 17 00:00:00
>> 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Fri, 16 Jun 2023 19:43:38 +0200
>> -Subject: [PATCH 3/4] d/patches: Add patch to add the build version
>> to swupdate
>> +Subject: [PATCH 2/4] d/patches: Add patch to add the build version
>> to swupdate
>>
>>   The build version is only set if build in a git repository
>>   this patch allows to use the version information stored in
>> @@ -77,10 +77,10 @@ index 5638bbf5..12324569 100644
>>    use-gcc-compiler.diff
>>   +Makefile.flags-Set-version-if-git-returns-no-informa.diff
>>   diff --git a/debian/rules b/debian/rules
>> -index 8cac6359..566a21bd 100755
>> +index 2c91677c..5d72987c 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>> -@@ -17,6 +17,8 @@ export DH_WITH=--with lua
>> +@@ -17,6 +17,8 @@ export DH_WITH=,lua
>>    export HAVE_LUA=y
>>    endif
>>
>> @@ -90,5 +90,5 @@ index 8cac6359..566a21bd 100755
>>    ifeq (linux,$(DEB_HOST_ARCH_OS))
>>          BU_SWU += -VBuilt-Using="$(shell dpkg-query -f
>> '$${source:Package} (= $${source:Version}), ' -W libmtd-dev libubi-
>> dev)"
>>   --
>> -2.39.2
>> +2.42.0
>>
>> diff --git a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-
>> option-to-enable-suricatta_wfx.patch b/recipes-
>> core/swupdate/files/2023.05/0003-d-rules-Add-option-to-enable-
>> suricatta_wfx.patch
>> similarity index 69%
>> rename from recipes-core/swupdate/files/2023.05/0004-d-rules-Add-
>> option-to-enable-suricatta_wfx.patch
>> rename to recipes-core/swupdate/files/2023.05/0003-d-rules-Add-
>> option-to-enable-suricatta_wfx.patch
>> index 9c5ebd3..87c60d7 100644
>> --- a/recipes-core/swupdate/files/2023.05/0004-d-rules-Add-option-to-
>> enable-suricatta_wfx.patch
>> +++ b/recipes-core/swupdate/files/2023.05/0003-d-rules-Add-option-to-
>> enable-suricatta_wfx.patch
>> @@ -1,7 +1,7 @@
>> -From ee401ba4d0d81fc244288e7e59a7bc5cfe2d1bf4 Mon Sep 17 00:00:00
>> 2001
>> +From fae97f0e23f945c1ab6e767451cda1d2798aa348 Mon Sep 17 00:00:00
>> 2001
>>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>   Date: Fri, 16 Jun 2023 20:32:38 +0200
>> -Subject: [PATCH 4/4] d/rules: Add option to enable suricatta_wfx
>> +Subject: [PATCH 3/4] d/rules: Add option to enable suricatta_wfx
>>
>>   Add the DEB_BUILD_PROFILE "pkg.swupdate.suricattawfx" to build with
>>   suricattawfx lua module.
>> @@ -12,12 +12,12 @@ Signed-off-by: Quirin Gylstorff
>> <quirin.gylstorff@siemens.com>
>>    1 file changed, 3 insertions(+)
>>
>>   diff --git a/debian/rules b/debian/rules
>> -index 566a21bd..fc122d0d 100755
>> +index 5d72987c..d7ff5510 100755
>>   --- a/debian/rules
>>   +++ b/debian/rules
>> -@@ -61,6 +61,9 @@ endif
>> - ifneq (,$(filter pkg.swupdate.suricattalua,$(DEB_BUILD_PROFILES)))
>> -       echo CONFIG_SURICATTA_LUA=y >> configs/debian_defconfig
>> +@@ -58,6 +58,9 @@ endif
>> + ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
>> +       echo CONFIG_PKCS11=y >> configs/debian_defconfig
>>    endif
>>   +ifneq (,$(filter pkg.swupdate.suricattawfx,$(DEB_BUILD_PROFILES)))
>>   +      echo CONFIG_SURICATTA_WFX=y >> configs/debian_defconfig
> 
> Upstream does not enable this, but I know that this currently breaks
> the swupdate-progress -> reboot logic when enabled in combination with
> a hawkbit backend. Christian already sent patches to upstream swupdate
> to fix this.
> 
> Felix

we use already the fixed version as we don't use the same origin commit 
as debian upstream.

Quirin
> 
>> @@ -26,5 +26,5 @@ index 566a21bd..fc122d0d 100755
>>          echo CONFIG_LUAPKG=\"lua$(LUA_VERSION)\" >>
>> configs/debian_defconfig
>>          echo CONFIG_LUASCRIPTHANDLER=y           >>
>> configs/debian_defconfig
>>   --
>> -2.39.2
>> +2.42.0
>>
>> diff --git a/recipes-core/swupdate/files/2023.05/0004-d-swupdate-
>> www.install-Fix-path-for-debian-bullseye.patch b/recipes-
>> core/swupdate/files/2023.05/0004-d-swupdate-www.install-Fix-path-for-
>> debian-bullseye.patch
>> new file mode 100644
>> index 0000000..b2d831d
>> --- /dev/null
>> +++ b/recipes-core/swupdate/files/2023.05/0004-d-swupdate-
>> www.install-Fix-path-for-debian-bullseye.patch
>> @@ -0,0 +1,24 @@
>> +From f2184e7573e705bad408cf1422599b967773d48e Mon Sep 17 00:00:00
>> 2001
>> +From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +Date: Thu, 16 Nov 2023 16:40:19 +0100
>> +Subject: [PATCH 4/4] d/swupdate-www.install: Fix path for debian-
>> bullseye
>> +
>> +Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +---
>> + debian/swupdate-www.install | 2 +-
>> + 1 file changed, 1 insertion(+), 1 deletion(-)
>> +
>> +diff --git a/debian/swupdate-www.install b/debian/swupdate-
>> www.install
>> +index 7e3d95c6..9c6113cc 100644
>> +--- a/debian/swupdate-www.install
>> ++++ b/debian/swupdate-www.install
>> +@@ -1,5 +1,5 @@
>> + web-app/css          /usr/share/swupdate/www
>> + web-app/images       /usr/share/swupdate/www
>> +-index.html           /usr/share/swupdate/www
>> ++web-app/index.html   /usr/share/swupdate/www
>> + web-app/js           /usr/share/swupdate/www
>> + web-app/node_modules /usr/share/swupdate/www
>> +--
>> +2.42.0
>> +
>> diff --git a/recipes-core/swupdate/swupdate_2023.05.bb b/recipes-
>> core/swupdate/swupdate_2023.05.bb
>> index 762fac2..5ead66e 100644
>> --- a/recipes-core/swupdate/swupdate_2023.05.bb
>> +++ b/recipes-core/swupdate/swupdate_2023.05.bb
>> @@ -22,19 +22,19 @@ FILESEXTRAPATHS:prepend :=
>> "${FILE_DIRNAME}/files/${PV}:"
>>   SRC_URI +=
>> "git://github.com/sbabic/swupdate.git;protocol=https;branch=master;na
>> me=upstream;destsuffix=${P}"
>>   SRC_URI +=
>> "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=deb
>> ian/master;name=debian;subpath=debian;destsuffix=${P}/debian"
>>
>> -SRCREV_debian = "aa9edf070567fa5b3e942c270633a8feef49dad8"
>> +SRCREV_debian = "78cb6f20319d2b911e170eea5305f2cf0bd33030"
>>   SRCREV_upstream = "c8ca55684c375937dbcdefb0563071a35137f4ba"
>>
>>   # patches
>> -SRC_URI += "file://0001-d-rules-Add-option-for-suricatta_lua.patch \
>> -
>> file://0002-d-rules-Add-seperate-build_profile-option-for-delta-.patch
>>   \
>> -
>> file://0003-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>>   \
>> -
>> file://0004-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>> +SRC_URI +=
>> "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.pat
>> ch \
>> +
>> file://0002-d-patches-Add-patch-to-add-the-build-version-to-swup.patch
>>   \
>> +
>> file://0003-d-rules-Add-option-to-enable-suricatta_wfx.patch"
>>
>>
>>   # The option: "pkg.swupdate.nosigning" disables the required signing
>>   # of update binaries
>>   # DEB_BUILD_PROFILES += "pkg.swupdate.nosigning"
>> +SRC_URI:append:bullseye = "
>> file://0004-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch
>> "
>>
>>   # deactivate hardware compability for simple a/b rootfs update
>>   DEB_BUILD_PROFILES += "pkg.swupdate.nohwcompat"
> 

