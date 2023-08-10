Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB0C001B0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:20:55 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web10.14738.1691666449110516621
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:20:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cH15RqfE;
 spf=pass (domain: siemens.com, ip: 40.107.21.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUUSgfBBOTBXUQ0CQ+b71NqBRtM6U3vqqv09/nDXayo2DsZ+kxxLaYDirD9U8WPz5Bd8WKq9V0h2t8n/F35hKEfmyhJnVb4XObT92zOskWYu2L9nmKfVuh43M1gwy8oFjBNy14fvH97761mXifiYza4Q9kK/mVRQTNixzjSuCWGhQITHl9zQJJ5xVE0SyHvmAKwo9nGAsE6A6lO9bb7AZRUK1fTGAIx0nA/IlsBUBTQkvCMwkSNKnWA/LyXMN6cI47fDvhIydGmz/SC8q35OH467bQYAdpgH6S2EQeMNOVl5QyED5g2+Ux+zh/X/FxV9t6uzaNY67jJMCUOpO7ZOWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7sLKQ0+n950u1i7pD5ElcgEygOsmtJNUmmPnpYa1JyQ=;
 b=AadkZ8qtw2FMiSsWj6Y1MqJF3hZwZ8QZ9tbgCnsUrx2aBJsKn/3VevCOKAFIG6izFIF6Q1OSD34/dfwwKX+IEcl5dYszqDzIv3+OB4uXxHnn11iadYZyVquoNn1Q/PAtscuz1DPHCPQFiqDm1qQbhsEYd5f6mVyF6jAvWBnXVwk89n0G2pEyccltwyJuVlHB6Ce3cOfDcPLvVjYaJW5CiyPzLQtKUOfVM9KMDBTk+uO7VGGFeN+qxrYPow55+vZKVf3gOn1IZxom0d/m796WOJm41MV73x0J2KfpGzyoQjU/+/7m/ILCp2BqrS6BIMvYEno+HSWufWi9mH5CFOtXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7sLKQ0+n950u1i7pD5ElcgEygOsmtJNUmmPnpYa1JyQ=;
 b=cH15RqfEAgdEl4WJYRASg4gZWsGLKT37UHjTcAxy9TUiWWwZUNpqDQNydo3IkilGWdzRa0TO6N1FfpK0KWs1iQY8T96oMmQ3lMkjvmLX/U9C9xD2fDC4Avf1rk9Swa3z20wKOtbbnooFJU+h8x5QdvcYbIwB1rlS9Yw/C9ec/xXKr9ooQKiCre7nWykfuYBk09wQZXWvlnTb8y60PxqB/FoEol6Y8XL6NkceDbKyzs2c5C9sbqLtn6fnFTwTxo3iFncmFuFypXql5dPDvQL1X+e5vkhJJ9veDE8vwYgiVnn413Wr2LMmEbShDSfVhIc2/fiGvhYsAHyVXlylTC1aqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB8047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:20:45 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:20:45 +0000
Message-ID: <8cd73965-61c6-f592-e5d6-ea090abc12dd@siemens.com>
Date: Thu, 10 Aug 2023 13:20:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH 4/4] initramfs-crypt-hook: Fix
 error with libcryptsetup-token-systemd-tpm2.so
Content-Language: en-US, de-DE
To: cip-dev@lists.cip-project.org,
 "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>,
 "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-5-stefan-koch@siemens.com>
 <42d2c7d5-184e-4cc0-b031-7fa50b0201b3@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <42d2c7d5-184e-4cc0-b031-7fa50b0201b3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0007.namprd02.prod.outlook.com
 (2603:10b6:610:4e::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d8b5660-a4aa-4383-df10-08db9993d71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AZLNUBCiMyEQAwA7HhG+EW73ZiVyqjSkiZkPHrU8weBa7tvvvsizNiiHMs9ZRxne88/O/5nrADcR6YYi+R3x2NW8KHk+G70+O/50eT9LrAgylR/IUKlZCfkjTR718CgB3YOE2EGVsk/HaBlal1E+cT/EoSu3CP2C7fpHAcnmvlfbAez3ZKGrDovuTPnon98zm4e/GnVPlVXMnKGtqvVAMH6CMnq0/dHqG9VmorDKatOH6sxzWaGTe+K0J+TFWOxJYPyV15o767+4e4GPPvWJV2k8yAgXrL2Lh9t43HokQ1mASGjQJo/MNa0VBFIhI9ZP33IJIi6LyWF0LuxfhTlX4JVCb/LO+7WpBY6+yP4GDaCPopg5nhgaYbrMPY3QEkdBkY+PnXSqiL7RVCmxu7xct1Awa0NKXKsPA19xniICaWggquG/oDiczfpITBhTLFirwMM52bW4lYxbTYXjRKF3D5fS7J3Ea92/51QBpBmLYij6gazCIaKo+Q/IA+xx1kmh4IonI8bw52ejDpxQssWrb7IdutTWeJ3WIcKR1RHMaBW9GUtgvg6d1aoC7kd1dHy9xgGzdllL8KzIEb934qpQX0f03zKbZtC4pyr55vtGDdE90xH6Hpyg9RYSFk92LBpJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(1800799006)(186006)(451199021)(6666004)(107886003)(31686004)(82960400001)(6512007)(966005)(2906002)(6486002)(38100700002)(478600001)(2616005)(36756003)(5660300002)(8676002)(8936002)(6862004)(66899021)(83380400001)(37006003)(54906003)(26005)(53546011)(41300700001)(6506007)(66946007)(86362001)(31696002)(66476007)(66556008)(6636002)(4326008)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K2haWXFjMmZjclZNb08ySVM5V1JCb2xMN3UvdmxTZ0Q5Qk5HdXZsRXBKdXZG?=
 =?utf-8?B?QzFJa2QvR1hOeFFOWHVLRXZPSEd5OS9aV0lOMitHUmh6MDBuNjROUTRVNW9m?=
 =?utf-8?B?QzdiSzRFL3g1NFIzQWNhdlVrektLbkJQQU9MNWxPTlJEcnpwLzNyd1p6T21C?=
 =?utf-8?B?aHZPTm1SMjhDVVlZQTJoL1ZDZEJqZU5xdFhHeDlIdFVQc3ZOM1I2UW45eXBZ?=
 =?utf-8?B?V202dFNZK3E5dk56d0xnSnFtcWFlMDRZR0xhcFlXOFhFMG9hNGxZYnNoMjJV?=
 =?utf-8?B?YjJ2aDI0cEZwRVI3dlVwQnpjQnBQQ2VzTHh2Vjg1YmFjZk9oU0N6VGpLeHBN?=
 =?utf-8?B?SVhDSUx6OWF4a09IYmc1K3Y2dU44TkZQQXd0elZxa255WlNEMDFEV3RLVTQr?=
 =?utf-8?B?V1NBcUx3ODNnNTJPSWQ1MTR5dUszcEdNdHBpM2RialZ6SkdhKzgxclZhUXFW?=
 =?utf-8?B?YzVtQnNNbjBackNaVHJoalIvQVF5Q2tGUnQ3d0w4RDVZdEVHalJlQ3c0Rkcy?=
 =?utf-8?B?NlMzd0ZYT3UwMDN0ZHRJYkV5elZqUjZKSTh4N2hCOFlYSnMzMlZJWWV2c29W?=
 =?utf-8?B?UEFGWnNmbXg3VkJCU0RlVWhVV25kUXJya2p2dFVheXB1MThMZkwvWmhIb1Vo?=
 =?utf-8?B?dXVRZGNCYkZZdmw5clZzWnVhL1RnbjlscytweXc3cXVoWmxjeVhzSnRHM3Zz?=
 =?utf-8?B?NFhMdkhpSjlNdnNhU0kzVVhwNXZCbk12b0wrNHhhT3B1VGkvWCsxcXRzRnR5?=
 =?utf-8?B?aVB2cG9kZGdpeEhWekl0UlJHOXBjV0Y5U0RGTU1LemhBelVXZitKQm1pMEwy?=
 =?utf-8?B?eTg0aWdZdHZNeC9Vd2NWanlkeS9sSEFPTmZLQm81WjRNMW91WUtCaDl3T245?=
 =?utf-8?B?WnN5Z09CbWJ4V2M4Ri9VSHA5emZ0OEhKNzhyU0l3aEhCdHFBVUNZWG9DYkZB?=
 =?utf-8?B?T2VYTTNwMUFiM1F2ckpTdUtHMW43clE1aE9YalN4SVB6ZkNWZFVyNUNuUFlT?=
 =?utf-8?B?V2hYVGh3WnhJWE14RlFyaTdiOUVYNE5LZHgvanJBN2ZYcVFINWVhYmgvVHZs?=
 =?utf-8?B?VGlkNmVOWjRNY1VkRDNNWU40T21yU0k1clUyOTZ0dVAwaVovYjBKZGE4NWJq?=
 =?utf-8?B?djR4Y0cxVy9HcCtsbkV6S2JxWHpjSmVuWllNVVVydGh3VXArUnZsSkxLb2pW?=
 =?utf-8?B?MndHdURzWmFaSndqaXMwZm5HWHBsVmFiSzQ1REVGUGNQTFMxL2Zia0RIKzdi?=
 =?utf-8?B?SDdrWk9RRUpQUW9HNng5L041QXpLdlhnRmtGWVJPbkR6Q0tSSVlwc3FLTDJE?=
 =?utf-8?B?bXN3aXVTcFE1TEFVZjV3ZzR5cjRSazliemRkNHE2QlJNQkhYNE5maXpDQ0ln?=
 =?utf-8?B?Mzd2N2dnV2ZOT3RyYXl4cFFXM3BPbC8rZHYxeStqVWw2bnpBRlBUOHgwU01J?=
 =?utf-8?B?SmZ5TC95b3d3VUFkQTB6K2E5bG40OFFLb29mcjZiRU55VUZPd3Rqa0h5OGpZ?=
 =?utf-8?B?UjVIZzRZaHhKVjVIM3RyWmxHclZLUytRUm1vNUZVZlo4SHQzQTVDbjVLMDVa?=
 =?utf-8?B?bU8reVJobTJWMkxTRDNxY0dtT1FxS21DdXJiajluUTBxOGEzZldkSWlwYzV3?=
 =?utf-8?B?cmUxOGFSMlhWRXkvNTlreU1rdXNFRUMwdW13Ylp0RkNCdWR4RHlkZEI1VkJG?=
 =?utf-8?B?ZWdOclVxNFl6dzYvVkVEb1pwaVlIS0srbjVhbjZnRzhqaHRycCtwRFdQNTVu?=
 =?utf-8?B?UWIvZzVVak1XSEZDdURWTndLbm5qUzFRRlVXMFZhekd0WkRDbm9RTTBpakM3?=
 =?utf-8?B?Wm5vUzRFdStWSEdMZXBRRVhySk8zVGEzS01PcTlxMSt4YlZLeVdvbThqamZh?=
 =?utf-8?B?VnNYM3hyU0xJT2dtdnZBVzByYm91RW9ZNnZWYzBFVFg2UmtwUUdvbkpaNGly?=
 =?utf-8?B?TmFHWENxTjl1V1JZaVYxekFnUWE5TE1heDFoRkNPM3RUMlV2YWpLUENXV2lD?=
 =?utf-8?B?VHNEaG55WGhzOG40RW1jNFh2eGtIdFM3OUl2ZUxDWFhFalY1Q2tLTmZhS3dw?=
 =?utf-8?B?Tk1XZDQwL0d3MVRFUVBZOER3dDB6NThzUmE3ak1iSW5JQUNseW9wWk9BVUsw?=
 =?utf-8?B?WFRTcjIxbU5HMGozSk5OSmF0STBxRE5PanBEamlrbVM5NGVlVGlIK0dWUXVa?=
 =?utf-8?B?bkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8b5660-a4aa-4383-df10-08db9993d71b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:20:45.3469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWhQ1A74X8csIr1ephaIkTtkmoUcm2bwuN1fCUqIWW4R36KsJU2Ar2ds+xmE7b1uw5JricydcBxfy2t7dm+vPUG++jP3FrT9JDGwa9/LwVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8047
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:20:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12598



On 8/10/23 12:39, Jan Kiszka via lists.cip-project.org wrote:
> On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
>> The library is missing and is not needed for systemd from bullseye-backports.
>>
>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>> ---
>>   .../initramfs-crypt-hook/files/encrypt_partition.systemd.hook   | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
>> index 08ea631..dac60e0 100755
>> --- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
>> @@ -44,7 +44,7 @@ copy_exec /usr/sbin/cryptsetup || hook_error "/usr/sbin/cryptsetup not found"
>>   copy_exec /usr/bin/systemd-cryptenroll || hook_error "/usr/bin/systemd-cryptenroll not found"
>>   copy_exec /usr/lib/systemd/systemd-cryptsetup || hook_error "/usr/lib/systemd/systemd-cryptsetup not found"
>>   
>> -copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || hook_error "/usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so not found"
>> +copy_exec /usr/lib/*/cryptsetup/libcryptsetup-token-systemd-tpm2.so || true
>>   if [ -x /usr/sbin/cryptsetup-reencrypt ]; then
>>       copy_exec /usr/sbin/cryptsetup-reencrypt
>>   fi
> 
> This recipe is not to be used by bullseye because we decided - for good
> reasons - against using systemd from backports for <bookworm.

cip-core only supports clevis in bullseye.

Quirin
> 
> Jan
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12592): https://lists.cip-project.org/g/cip-dev/message/12592
> Mute This Topic: https://lists.cip-project.org/mt/100411236/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

