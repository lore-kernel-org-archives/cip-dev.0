Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48401C4332F
	for <webhook@archiver.kernel.org>; Thu,  3 Nov 2022 12:44:02 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.84])
 by mx.groups.io with SMTP id smtpd.web09.18903.1667479431393949618
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Nov 2022 05:43:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=X0tq3i9B;
 spf=pass (domain: siemens.com, ip: 40.107.14.84, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LdmfQObQa6oL38FYd4f+IQHXd68IOyo3Ex9cRXgG/XLrnIcby9fso3eR1SDHdGfrE3Aa1/HTYI4Wn7jWlUIViq+pLqwuGpDkvynLtRb71oq/mE6ipjNlroHFZ/2eHn8BY9YVk0lwj51P8jHek8qTAINl0x7qnt2vxFLnUoH9S+bEFhhcaQ8w4B72Ha7VmZjco5KGOh0s82GRmDyDPkILZCUo9+wYoYbvpYQg3D90LBaSbqGprjMTYLNwQnWZ4LKI0Nl3dKFjZUWnx+LdXc58oiqvEflxfqWIAZjMICOVNUsPmnkzzyL0noF40xoOkxS/oDtGui/3nLD+hzaiLoKYFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsA2hPqk6asEj34FyyVx3/m1K0xHjXzFVaEUcpLKEYI=;
 b=FVV8I2x3tBiD8629rsf1yN7Zr9Qn3JBHY+UtJhJB6fxNTCm4Cs4KCFVyQ5ovHSzSzAcbasVxQImxs56E6F7jMXKUBYq5tQKuNf8OK8jmiBSGPId55EG/oyxQsDO9s4sIonC0BGel40lLwL6GgFfQsN0jrYIABRYtzNLcpq90eMoQPSafp4aWXjOuTem2nf547+BtHdrRztPpqtV5VsrHK6vWBa/UUXCbOj7PQ0PN6M3xDwiZeOnDD/G+VfgrITgUkj2o3xsVl1jQAUHJezBX2rDeUn3ShYVOqYMnI2Xbo4yNxO1zzFYfSMuo6X208AxcR4g6ELSwh34pmKkHtiYmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsA2hPqk6asEj34FyyVx3/m1K0xHjXzFVaEUcpLKEYI=;
 b=X0tq3i9BkBFN9C85ViLPLwxyA4gM702r0rV3pA8D9DpfC9X+6WpaKdk6zwdHokfCrsajeHh+okV1kiQWr054CFDMIMK549c8vfLtRmTL498fldV/HvNm1jG49HFvK7nqI6IsKCqLOCo3fn3kfCtgtV7visz8m+sPYNPMVuyPrar3HHJZ5YHSpnb5M9RturIKg+6pinNKVh7O57t5YLAs55EnjuRLuuTKv5rtVYcr7ffTzClcTwrgukk2NEGMSRnCbBpvuZDOMgEXBfZkkt9pIVl3/fMYN3wkxzjpS+2QPgEZLQgkFFOrB1PJhdDDAdILxWWofTgVqoYcNfRtPXm+bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB7343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Thu, 3 Nov
 2022 12:43:48 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d3e:984a:ea8d:4c34]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d3e:984a:ea8d:4c34%3]) with mapi id 15.20.5769.021; Thu, 3 Nov 2022
 12:43:48 +0000
Message-ID: <a2e8a677-1b89-e7cb-9300-22cd6a711f12@siemens.com>
Date: Thu, 3 Nov 2022 13:43:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Adapt installation
 to Debian upstream
To: Jan Kiszka <jan.kiszka@siemens.com>, felix.moessbauer@siemens.com,
 cip-dev@lists.cip-project.org
References: <20221103083643.14912-1-Quirin.Gylstorff@siemens.com>
 <2fd34818-509d-567e-0de8-1eaddfb2d975@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <2fd34818-509d-567e-0de8-1eaddfb2d975@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::22) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB7343:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c63901-0931-478a-aadf-08dabd990d70
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nIJB2ilMXtwFKXB+1p7iFgH5f+MtZCCqzBmGhKUKLoIVIFZ0VE5ODyFs16WgYYuDnI0eALhr2vEx1H1RGxMkAR9ja5nZTq4u6Uwct8Yyj/dappO6rSwKdvgkPPmAy8F6eNyvJon62eOJnfmtVqm47Vy2osbOSyB3a+2gOqjq9xopXeIEIXTvVmHG3qWjQ5y8i8YnM+CrAlwjnVMiUXPPJRyMXbkHZI7VMQz9woaqX/d9ZRkGKYwK7gHI94jcaMFLRouoyaYTvLKB/qgg+OJRVyMlkPOKFdbkhKQhGMtsrrEveQSWh6iYZzQCRnRUWDQe3dqqH3zsLqQtiTjyTne7SQUnNjP/ds/xZVF7D+j6xUIjouhIMo0DuY3/zYGCBwoU9stzf1u+jzCyCw6aR8+pO/96HfOSwKHyOgh1wVpgBQoo9xdNg47E/pcc4fwbRYeOA9QuesKK0+mUPVFCEjLKqbl4sMF5pK94Dw8wnvnrolODFFzlqe5nqGY9U2/8yExoMek271K60VVu6jLUZD+rk0GrbwEFXlm+q3C/xEilqijtkH63iRl/x19GV2Kqs2sTY1J6xig+xhz47tHpiDTvAhQPur3Yp2gx/CCUptNdDddlHlRvx+Y/5Vdl+bAjHum7P6Wnkh0sIQAtGtZe3cu1xVLu9W4l/jmHdo1vMCm079L1rQP6yMyVMJjBzQgThMgrhCvDkJldc1FIhh/hU+QiqJzTXyiTht4kvHG3HAa8Xlnh4sI2N2tXX8/IyP66dHXXzevqvLe0ZgMz5f1N+3945sgb9Lk3WnqwhNUHuZgH8Ngm2ScUa06Nav3REIJqvmsdPobVgzyIP3byUOpaJAZrs/VJF9NAYaoBHIQo6NMNCVs1jPzVWdHRbAyT8q5rhsQD
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199015)(6506007)(36916002)(31686004)(53546011)(6666004)(966005)(8676002)(66946007)(66556008)(66476007)(36756003)(82960400001)(2906002)(86362001)(83380400001)(186003)(38100700002)(6486002)(6512007)(2616005)(316002)(5660300002)(478600001)(8936002)(41300700001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0JCNml4dVVGd1VQZVdvdmxBZGlBQjBIWlpURzhoUDhzcXNHaFNGMitKVm51?=
 =?utf-8?B?dElmQmRnWWJlZU4vYXRlNHRVaWErZXpPb3BsUytLZzU4bGxyMHBwWDdidksx?=
 =?utf-8?B?Y0w5SFgrZENTV2IwNW5kUXlBK3RNYXhsRzcvaDI2L0dMWjN6N3B0RXlpOWZD?=
 =?utf-8?B?Z2pKU21pUU0zVzIwbmRYL1lNa2NYRllJSHF1ZFd1cmVNMEV1bUdtUVY5ZFFE?=
 =?utf-8?B?WFI3WGtMZkJTMzVPSlQyVC9XWHcxM3FZQkp5Tm44WGZQcWxhQU0weDkzMy9l?=
 =?utf-8?B?WkhEbURIaUFJTTBQZGRRZ3d4dTllRUZkcHpFejdZTklvc3RWT2hUM1dEcmxl?=
 =?utf-8?B?bmN6bTZtTUJDVGNIOTl4VEZNTUR3SW52OFAwZWs4b0lyR1dDcjBOUEJKbURB?=
 =?utf-8?B?dGFLbzZYSkxDckZDMmlxK201VkZ6cnZ0bG9JQjBCSyt1b1ZXdDdsU1J3bFdo?=
 =?utf-8?B?NnE0WFIyNjdIaG9sbUIvTWN2dlB3VW52RURPZnRjTml5TlIwUXF4dXNLUkk5?=
 =?utf-8?B?Ym9tY2xleTFockUxQXVwY0dORkQ5Ym0zeVBPWFc3ZXJuQnc4YVVCalBqSXlU?=
 =?utf-8?B?Tk5kalNSZUVQeE10MzZkV0IwYU9IN1ptU29ydjhrYWJOakVPem1DL0FqS1hI?=
 =?utf-8?B?aFhCQUhsaUVyRWQ2WlJNNm9jVWxRRXpGV1BtSHVNcXRhekJBVDFCL1EyRnRL?=
 =?utf-8?B?RVI0cHBUbHZRYlRPNEJLWlJIV1loNEdBMmRsN2o3UVpJQktCb3NLb3RRb1lh?=
 =?utf-8?B?NTgrOTZ2c3J3ZDlDcHY0Lzkrc2ZwdXZMaTdFbDJmdmdQVnozc2Evam8zVjh5?=
 =?utf-8?B?V0lvK0lTTHBKWkg5NFhHa2tLU1NXYm5qNCtkb3JaY3Z5UzhET0FRZFlXSFpl?=
 =?utf-8?B?dEhVMTJ1bkdISG94bDV6SGg0SS80TkNvNWc2ZVAyNE1oUG1QZitsTVp3b1p5?=
 =?utf-8?B?YmtkL0VKdzFWRXIwT1VuM0ZsN2pYdHdNNGo3RzBlUUQ3bmpZSGpSU0tzREx2?=
 =?utf-8?B?UG82WExQaEVIU2dpWWRqZTRZNGpUWkMrYTNWMDU4OUREbG5UQi8xa3ovM1R1?=
 =?utf-8?B?cU1HZXBaV0FreFpjU2VIS3FXeXRLT2VKUzJSNXJmaTZNb1prUVVnU29SNldJ?=
 =?utf-8?B?QXk5KzhmYmVjMW84M0svRUlFWisrbkRudFlUM1AvRjNnNEJYTHROUkdieTVa?=
 =?utf-8?B?Y0ZPN1BpZUsyL3JaVW9YaW9YYmZ2QnBETzRWRWdBYTRCd0dRNGxEcE1CZytu?=
 =?utf-8?B?VG1OcCtOVmtFK1R6Rm5ZRU1QV3pkTlU5My9wMlpQd3JxZ0RTT0czQjVpcjBj?=
 =?utf-8?B?bW9OQXZYd0ZzWVZsQVBrcytyd2x0bGhpNTNlTTk1amoxT1lMeEFvZU9OUEZJ?=
 =?utf-8?B?L2YwamdSMnNzUVNVc1A5RTAzdHRkMHkzbFE2L0JNdi9WbW5Hd095WlhtT0J0?=
 =?utf-8?B?MVVvUXRTZGUrYWk1UTVuQnpFVUhIUmxhbUJQQkVuRU5lTXQ0ZExxMWVGb0Jq?=
 =?utf-8?B?V29kRmEzTDRVZkw4WUoxQW4yaVE4cjMvNjcySVg0UG01bXROc2ZacVB1QS9i?=
 =?utf-8?B?a3dqUkxieUwzTHpDaUNpeWMybFNqSGllYnFQSVZiSmJ2VjJJaG0zK1cra0pN?=
 =?utf-8?B?cUxFTnJRU3lpbHF5MlpUVlNIdEdNMjcwaW1nQzZBTDZkMWhEUGNpQTRtS3hN?=
 =?utf-8?B?RXBEKzUyY09KNnlIVkhibGFTZnZyNUNoK0JveHUrSnIxdTZEcEd1MGt5TTkv?=
 =?utf-8?B?VWZLaVNTUGlGSDNRNC9zdFFjdmxGKzcyb3ZYUDlhZ0hXWHB2N2ZQRUZ0VnR5?=
 =?utf-8?B?eEN4UHgyaWlRejVMQlBpN2RKMlBJNE5jbVR0R0VWVjRoMlk4U0NwV05Pb2w1?=
 =?utf-8?B?NnpsQmo1WUx1SUszOUt4NUtNQzlPM2tVVG92bHU0c3lPQUVTZjVOR2s2OEtH?=
 =?utf-8?B?NUNuSjYwZERFSk9jeGlKR3QvdmlBeUJ0ejk2NDlVVXV2WXVBbkMxZEtYc3hO?=
 =?utf-8?B?L2VsS2VWbDVpS0x6SlZWVTNkTzg5dzBlRFJtcTR1M1cyamR3eW5iN2Myenli?=
 =?utf-8?B?NUdncGEybXhvR2N4MXZlY2dnQThuNGUwbXdycHMzMGEzMHBrS1RGNWJMUDRn?=
 =?utf-8?B?djdTWDdPbzFKamVZdDdyNVpnSFB3UFg1SFZMdFZCaFdHSS9UMmk2MjNUbThk?=
 =?utf-8?B?VFltbjM0d1dpZHNQd3NYaS8xVG9Ia1RSK0ZyVWxLcUhOL21DdTFOdnNYZEw4?=
 =?utf-8?Q?SgKM+j5sO1rNDKJeCmicnWfcO6By3fepy915j8uZAc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c63901-0931-478a-aadf-08dabd990d70
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 12:43:48.0729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLXlOvB/3oH92mmAo9btM8hxySwUNZUBErOh3f4XXfQMxD8qpKkdzqJgnQDS/MHqM+ga28Y/eRim4+fqjYRvn+2ESjgzjHvZavFDzKUHFbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7343
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 03 Nov 2022 12:44:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9916

Hi,

On 11/3/22 13:07, Jan Kiszka wrote:
> On 03.11.22 09:36, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows using the Debian upstream version of efibootguard
>> in place.
>>
>> Also add the new libebgenv to the installation.
>> This fixes the missing library from issue #47[1].
>>
>> [1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/47
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   recipes-bsp/efibootguard/efibootguard_0.12.bb        |  2 +-
>>   .../efibootguard/files/debian/efibootguard.install   | 12 +++++-------
>>   recipes-bsp/efibootguard/files/debian/rules          | 10 ++--------
>>   scripts/lib/wic/plugins/source/efibootguard-boot.py  | 12 ++++++++++--
>>   scripts/lib/wic/plugins/source/efibootguard-efi.py   | 12 ++++++++++--
>>   5 files changed, 28 insertions(+), 20 deletions(-)
>>   mode change 100755 => 100644 recipes-bsp/efibootguard/files/debian/efibootguard.install
>>
>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.12.bb b/recipes-bsp/efibootguard/efibootguard_0.12.bb
>> index 88dc2ed..721b9dc 100644
>> --- a/recipes-bsp/efibootguard/efibootguard_0.12.bb
>> +++ b/recipes-bsp/efibootguard/efibootguard_0.12.bb
>> @@ -26,7 +26,7 @@ PROVIDES = "${PN}"
>>   PROVIDES += "${PN}-dev"
>>   
>>   DEPENDS = "python3-shtab"
>> -BUILD_DEB_DEPENDS = "dh-exec,autoconf-archive,gnu-efi,libpci-dev,check,pkg-config,python3-shtab"
>> +BUILD_DEB_DEPENDS = "debhelper,autoconf-archive,check,gnu-efi,libpci-dev,pkg-config,python3-shtab,zlib1g-dev"
>>   BUILD_DEB_DEPENDS_append_amd64 = ",libc6-dev-i386"
>>   BUILD_DEB_DEPENDS_append_i386 = ",libc6-dev-i386"
>>   
>> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> old mode 100755
>> new mode 100644
>> index d3ea007..01cf974
>> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
>> @@ -1,7 +1,5 @@
>> -#!/usr/bin/dh-exec
>> -bg_setenv usr/bin
>> -bg_printenv usr/bin
>> -tools/bg_gen_unified_kernel usr/bin
>> -*.efi usr/share/efibootguard
>> -completion/bash/bg_printenv.bash => usr/share/bash-completion/completions/bg_printenv
>> -completion/bash/bg_setenv.bash => usr/share/bash-completion/completions/bg_setenv
>> +usr/bin
>> +usr/lib/*/efibootguard/kernel-stub*.efi
>> +usr/lib/*/efibootguard/efibootguard*.efi
>> +usr/lib/*/libebgenv.so.0*
>> +usr/share/efibootguard/completion
>> diff --git a/recipes-bsp/efibootguard/files/debian/rules b/recipes-bsp/efibootguard/files/debian/rules
>> index 82e9e0e..9c3b916 100755
>> --- a/recipes-bsp/efibootguard/files/debian/rules
>> +++ b/recipes-bsp/efibootguard/files/debian/rules
>> @@ -1,21 +1,15 @@
>>   #!/usr/bin/make -f
>>   export DH_VERBOSE=1
>> -export DEB_BUILD_OPTIONS=hardening=-stackprotector
>> -export DPKG_EXPORT_BUILDFLAGS=1
>> -include /usr/share/dpkg/default.mk
>> +export DEB_BUILD_MAINT_OPTIONS=hardening=+all,-stackprotector
>> +include /usr/share/dpkg/pkg-info.mk
>>   
>>   override_dh_auto_test:
>>   	# we do not run the tests; that avoids having to pull the fff submodule
>>   
>> -override_dh_auto_install:
>> -	# install using Debian's .install files rather than
>> -	# make install in order to have a proper package split.
>> -
>>   override_dh_installchangelogs:
>>   	# we're not interested in changelogs
>>   
>>   override_dh_installdocs:
>>   	# we're not interested in docs
>> -
>>   %:
>>   	dh $@ --with autoreconf
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index f9b232b..3d6b2d7 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -187,10 +187,18 @@ class EfibootguardBootPlugin(SourcePlugin):
>>               "armhf": "arm",
>>               "i386": "ia32"
>>           }
>> +        distro_to_lib_arch = {
>> +            "amd64": "x86_64-linux-gnu",
>> +            "arm64": "aarch64-linux-gnu",
>> +            "armhf": "arm-linux-gnueabihf",
>> +            "i386": "i386-linux-gnu"
>> +        }
>>           rootfs_path = rootfs_dir.get('ROOTFS_DIR')
>> -        efistub = "{rootfs_path}/usr/share/efibootguard/kernel-stub{efiarch}.efi"\
>> +        distro_arch = get_bitbake_var("DISTRO_ARCH")
>> +        efistub = "{rootfs_path}/usr/lib/{libpath}/efibootguard/kernel-stub{efiarch}.efi"\
>>               .format(rootfs_path=rootfs_path,
>> -                    efiarch=distro_to_efi_arch[get_bitbake_var("DISTRO_ARCH")])
>> +                    libpath=distro_to_lib_arch[distro_arch],
>> +                    efiarch=distro_to_efi_arch[distro_arch])
>>           uefi_kernel_name = "linux.efi"
>>           uefi_kernel_file = "{deploy_dir}/{uefi_kernel_name}"\
>>               .format(deploy_dir=deploy_dir, uefi_kernel_name=uefi_kernel_name)
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> index a754ee1..2d16fe3 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
>> @@ -59,9 +59,17 @@ class EfibootguardEFIPlugin(SourcePlugin):
>>               "i386": "ia32"
>>           }
>>   
>> +        distro_to_lib_arch = {
>> +            "amd64": "x86_64-linux-gnu",
>> +            "arm64": "aarch64-linux-gnu",
>> +            "armhf": "arm-linux-gnueabihf",
>> +            "i386": "i386-linux-gnu"
>> +        }
>> +
>>           distro_arch = get_bitbake_var("DISTRO_ARCH")
>> -        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
>> -            distro_to_efi_arch[distro_arch])
>> +        bootloader = "/usr/lib/{libpath}/efibootguard/efibootguard{efiarch}.efi".format(
>> +            libpath=distro_to_lib_arch[distro_arch],
>> +            efiarch=distro_to_efi_arch[distro_arch])
> 
> These arch name changes look suspicious - or does Debian do the same
> for, say, systemd-boot?

You mean the move to `/usr/lib/{libpath}/...` according to this quick 
search [1]. It is a pattern in Debian, see 
https://packages.debian.org/bookworm/efitools.

[1]: 
https://packages.debian.org/search?suite=bookworm&arch=any&searchon=contents&keywords=efi

Quirin

> 
> Jan
> 
>>           part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>>                                                part.label,
>>                                                part.lineno)
> 


