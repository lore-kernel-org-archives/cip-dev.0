Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEE0EDEC4E
	for <webhook@archiver.kernel.org>; Wed, 13 Sep 2023 12:52:25 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.89])
 by mx.groups.io with SMTP id smtpd.web10.11014.1694609536245534448
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Sep 2023 05:52:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ievKPOSo;
 spf=pass (domain: siemens.com, ip: 40.107.6.89, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImKLrRRQtUxmz89bEywDTZVtxGbzrl6TnkrQo48OFGoxL2YB1/RnJUJdGfg59aMXNceLh9XEYI/G2yjCYyJOoxItpEOUjJ1c69Vkc76MV5sccgJ4hEML1eflCT3Bbs9caHEKdIeRy5gzCq7tOrKv5GA5IUMEpqVk+ZK8DprGX1DHiVpoxKiqBED70hMEpgwuXICQx/2KGWEMHLKmi1g111y9d8V6zl8owm5SJ0Kflp7+MUkYJSnJUWKcJo55JqsvGTmsm2jIImQcUkJ9hDYvbP35MQZPfNtx225wzHDFQUyad6bHGC9cm8u05dm7Ofb49KdnuqcWov94dZ/obHa4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmIMXOBF59nNv1GjRn03qhok/3xb738LQZ0or0AGpWQ=;
 b=AgHkFhLSnm1+jXHtwBB+TGAEgktY56RSJAypexLbmXQQYWQ+E9UUCo9uMGJNPaKvJ9iodosA4RtI8yv3+nh2T3VpHlwTcm5G6dDgRRJeVkwQLv37FA1YPViIszrXm8FobbeushVLusqFwHsHz1Md47kV2VsasBhxOXrAmC8URI4TNfcCk8EnM/Gjz2+8CLYCtKwVP8AKSjuhPILk2djKKwsfETk0BlWB4GVBCdFcfaD8vyfkR282tnmKmmQMfqD/zEZf4oJmy4jo03cdXtS+qqNMUUHvkImPiVLv4jL/HbGEyr0eBCjgR7E9A7bUdG8Kr7yZdtAKJDSzXbm/je1vuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmIMXOBF59nNv1GjRn03qhok/3xb738LQZ0or0AGpWQ=;
 b=ievKPOSoEqSSy1himqawAr+gulhMexWpyLXsPth91lkxqBB8nhjolSmctFpJMkYOqAceSP8WMeSOHErPASG1b9mBSbF66/lQSRkEXtcQf2fznUYXbuDeFEWu14MJMJIEplhAz4IkvWwfoBXUzT6mVzsgoVRnv9je5q1p46o0NHKmGOP/3x+/lpvEULaf97lOf2GtPK1DnBXzngFSkYHx/dME+W5gCVErcSXFyTY6Ah59rG5N1OZSHxkpZF3ZliH6qyu980DEsYvBE2G/4BWzs1pG4YZzYs1gdgwIk1lW5ly7fmdKvxXeZYQ58JIGzRunbcphWbQnHsk8/CvwLBVEQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3196.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:fa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Wed, 13 Sep
 2023 12:52:13 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a940:1b51:4279:2219]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a940:1b51:4279:2219%6]) with mapi id 15.20.6792.019; Wed, 13 Sep 2023
 12:52:13 +0000
Message-ID: <595d5791-a08d-f08f-5dee-6f9ed5d472e0@siemens.com>
Date: Wed, 13 Sep 2023 14:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-verity-hook: Ensure
 sync on rebuild
Content-Language: en-US, de-DE
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
Cc: "Schmidt, Adriaan (T CED SES-DE)" <adriaan.schmidt@siemens.com>
References: <20230823132816.1011054-1-Quirin.Gylstorff@siemens.com>
 <5a4f1ebe-305d-409d-b142-49626877455a@siemens.com>
 <94deff88-b5ff-16e1-89cb-d5337b788b50@siemens.com>
 <c90ebb07-260e-496b-9280-c340ae41c26b@siemens.com>
 <cfe1f5d1076d50f409e6f2f6aea7728ca8f06695.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <cfe1f5d1076d50f409e6f2f6aea7728ca8f06695.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:610:4d::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3196:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eed1849-aa5a-4dbb-9883-08dbb4583fe1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lOb0zmnxPgEkvEGjaAFlyOtU3o9qzKUJULsxFQn6H+pMJ5zCXS7gUWvMrgQxpwRfO73M5P1V34xhX6QCk5wx5yTTTpuQBBDakAakMF5JlanRarwS3fxsYFFWqgFRHM/VRJqcStMILKWFFHwIFgScLCbw6eahlL+RKSo4Y67hYrk/wdYS64vXCeAmJ0eQONPpjZgHnBE82Kwyj6U4B6ayqqizIHC8iCQsojxu/kCT9dJt9SKpjgbUPh7cx852N7JqTVn5JqiRGUy6eIcOhjFEZR/tXINFZyg8jNeLEn3AsCPalYhxzRWfkuoFenGQClbNNnA/WwthiylYf6wYSzy+ROo58BQUok/7yriED17KMuHEtYrWxRoHRmvDQSwMxTPGTzcejwHAoUBEZx7JPo7Q8VnmR8mUgkfgYABA77/wh5+0ty4UQjBH6pNcRzKyC23+RmjwL8uc3W3P9KP68oCiGeOMAFcrgyY1C2UUPKep9bv1V72XT1fMMvRkltWtSB81rY1xJnoX9T05dCcvlo58kdiFgktt82kt9msCU5+e36Krb6ym72eQac0M52i0cP7iHmKDNV7n/ItzQObdAjaG6zr3YLpjoFh62mZ15OVlOXmc8Woe2etsWGh0vUaYo2Uaxl41yu/uF/zetbhO58VZ1Q==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(1800799009)(451199024)(186009)(53546011)(6506007)(6486002)(6512007)(6666004)(82960400001)(107886003)(2616005)(478600001)(26005)(66946007)(66556008)(316002)(6636002)(41300700001)(966005)(38100700002)(66476007)(110136005)(31686004)(83380400001)(2906002)(31696002)(86362001)(36756003)(5660300002)(4326008)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QTFibkFKUXJ5a1lNQzhtd3hQam9UdnlmSDRSU0s2U1I4UCtvTDdiVmU1Sk1i?=
 =?utf-8?B?VGM1TzNaODdreUNnN0VMTDVTb3lISnVCQ1ROMDF1OUE1aWJISHl3M1hxY0dF?=
 =?utf-8?B?cENNWmhNd2hCTTRmb3JNZTJKOFBjTm9GL09uRmRlVnY1YWZUWEI2aUlwYzV0?=
 =?utf-8?B?NzZKQTRVQllJWlp1YlhhbVhMM1BsVU1KOUxmTTBkczZ6bG5XN2xaekxUNUJ5?=
 =?utf-8?B?cHQzTjBRa2hHNmEwSVJrVDJRVzBXZXdiN1JjWWU4dFpjZGNnRDFvYlU1NEk1?=
 =?utf-8?B?QVo3VzdZY2VSSE82byt4Z0xHYlAzbzNVYjVmZ1VFc0lkNXFYTysxdVV0V2Fq?=
 =?utf-8?B?V1hHcXp3ejY4a1NRL2N0V3BxSitvM0xkU2l6cElVRy9lWnFkcEpwYnBOMUpB?=
 =?utf-8?B?UGtNYXNIOGdMbFE0SitoV1ZndXdHMzBvODhYb0c0YlliQ3V0TE8weENncTh4?=
 =?utf-8?B?bzBUWGNQc0RqQjMxVVVHZFR4aW1zRVR4VDQrZURtUFZoMVgzYlZxUjBJNm0r?=
 =?utf-8?B?RHRNbTZ2ajZCYXEwdVlTZ295bmQ0bkh2VjVBUTZHaW5mNmdEblZoaGdOQ3dz?=
 =?utf-8?B?V1hTUmZjUllMM1Z2WE0vQnZjZUlDTWw2SzNqT2huSklmQ0hPa0p6bWt3anVD?=
 =?utf-8?B?OUVnOGZZMVhuK2lXN2czVy9uWDhjdzcvRFFUNUFJeVFVMTNJMzd3WlZGTi9J?=
 =?utf-8?B?VVY4L0hIaTZMMmNWRDIyaHhYTFQrWWpPNlA4TFlMa0Z0dzZOUzJlS3ZJNkVG?=
 =?utf-8?B?UDltc3NtVDhJS0RFaER1OVVDbFhCZkpGZFFiT1hBWjNobVJPNFZwdHFnYkFY?=
 =?utf-8?B?UUxpNU5JOFNQNU40NGZMSTNVZTErQ2xFb0xidFZDcVFYUHlST1JkSzFWd2JD?=
 =?utf-8?B?SVZFRFNaUTI3bDFjS3RtZXRXdmVjMFN1bk42ZVptMFJFeTZpOHA2NWFsRThx?=
 =?utf-8?B?ZmplMW84Q1EwbGc4Zzh1T2srdVlEYlhOOFNVMktnNHUzWm14a0tCV1NTMG1m?=
 =?utf-8?B?MkdzUkhNVTljY3FIczB1RHJKNDlNN1ZKekUzNlU0Tk84WEhwOWFGcFVuR0N3?=
 =?utf-8?B?V1ZaN2RwRmxxZHB4M1QzMTZubkdqUTBFVFlJVnpYWUNRcXVlY1RZWVErNFlw?=
 =?utf-8?B?ZHppaTZXMTdSMk03Qm5xeXdIRmViUE9vTTlqUmt2Tmg5SnpTTkJoZTRuV012?=
 =?utf-8?B?ZW9Hbi9EWkluYm0vK1djQnpmTncveW83ZWJzVXg5bFpFd2lnMlBSWnhjb1JH?=
 =?utf-8?B?OVcxQ2xxZ3dTeFRWQ1gwZTBBL2w0b3FYUUZhaXZmTTJXNHVwYStXbUpZWmpK?=
 =?utf-8?B?dUZ0MDNzemsyK0lNekU3Ry9aZUUzSjgwVzNHRnVMdFBwYWRIMnlPYTRoVmZL?=
 =?utf-8?B?QXJUZTJVZ3F5UVlwYWo0Q0JtSFhUcElaNHdkTFNIMlJXdUpzVDU5cUxWbm45?=
 =?utf-8?B?STdxajRFK0JsSnQ2aWlhVGl0TjVVNEs4ZHRJczI3NXB6RzhUeE1ieTJjOVlB?=
 =?utf-8?B?ZDd2T1YrV2Mwa0hOc3psYVZDN1JFd24zSnYvL1hteGI1WGRHeVI0YnNRV3hk?=
 =?utf-8?B?WE9YMVZtWWdIbUowNDE5OWhIcnhOSC9YUkE4QmEwdnJTMEpRdk94akMyQmtj?=
 =?utf-8?B?OVpJRHJwN2V5TThQelJmY0lzNkRMb3Q5eFI3NDdPNXZoM1J2NjF6Q1c4U3JQ?=
 =?utf-8?B?NENxamd6UHVaa1lTRTFoZ3dnTlBVN1dpZm95QkNwYlhSUzF3aVdMbVE0UEpT?=
 =?utf-8?B?L3pGNWE3cXNPM3Vub1ZYUUN0WXNqR0EwdWVIUGJTb3FDS0VpaHJvUFdoMDhF?=
 =?utf-8?B?OCtFajJoNzNqSk1aUWNWMFZvOUtGbmhLWm0xR1d0SFh2WXVMZXdOVWNUTUx3?=
 =?utf-8?B?eElDeXh6R3V3cnUrMkNQYXJMQW1CQ3FrMUxnT3NYQktaZ3lkbUdzTnJRNDJH?=
 =?utf-8?B?SVZsSEJkNVBQK3I3andtOCtBYmY0bGlNdWFremU2cDdDTjlYZUN4VWFJWkcw?=
 =?utf-8?B?eldCN3ZJbml5RzhZK3BONW5PQ3NrVGpuUFdOd25sQ3Y5bXdNdkU2ZWlCa2li?=
 =?utf-8?B?K2VORHlsM2pGdEwrWnRQT3lNN3IrWkxlN2lGZmV3YWJyUjRZSk1zd3lQMUU1?=
 =?utf-8?B?b0hKbSt1cCtYNTNXSFllVFVtNERrU3lRUk5vN1NWTzBZZ0FNNFRxMzhGN3FH?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eed1849-aa5a-4dbb-9883-08dbb4583fe1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 12:52:13.0772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /K2TvyBd2OnZipmwunOaDGt/t6I3UPjxxeqoKw12kPVYAnH2VbLxXRldahYlZ+J03cSWs758Vj+Q1E5Amyp4jw4htJtyKjrYjH4LtzyjVLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3196
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 13 Sep 2023 12:52:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13097



On 9/13/23 03:26, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Tue, 2023-09-12 at 15:55 +0530, Jan Kiszka wrote:
>> On 12.09.23 15:37, Gylstorff Quirin wrote:
>>>
>>>
>>> On 8/28/23 08:47, Jan Kiszka wrote:
>>>> On 23.08.23 15:28, Quirin Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> Disable the timestamp of the do_install() task to
>>>>> re-execute when ever a dependency on do_install
>>>>> is executed.
>>>>>
>>>>> Without this change the sstate needs to be clean for
>>>>> every rebuild.
>>>>>
>>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>> ---
>>>>>    .../initramfs-verity-hook/initramfs-verity-
>>>>> hook_0.1.bb         | 3 +++
>>>>>    1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git
>>>>> a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-
>>>>> hook_0.1.bb b/recipes-initramfs/initramfs-verity-
>>>>> hook/initramfs-verity-hook_0.1.bb
>>>>> index 3fc63ed..7435649 100644
>>>>> ---
>>>>> a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-
>>>>> hook_0.1.bb
>>>>> +++
>>>>> b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-
>>>>> hook_0.1.bb
>>>>> @@ -40,6 +40,9 @@ do_install[cleandirs] += " \
>>>>>        ${D}/usr/share/initramfs-tools/scripts/local-top \
>>>>>        ${D}/usr/share/initramfs-tools/conf-hooks.d"
>>>>>    +# Ensure VERITY_ENV_FILE is updated also when rebuilding
>>>>> initramfs-verity-hook
>>>>> +do_install[nostamp] = "1"
>>>>> +
>>>>>    do_install() {
>>>>>        # Insert the veritysetup commandline into the script
>>>>>        if [ -f "${VERITY_ENV_FILE}" ]; then
>>>>
>>>> No other dpkg-raw packages require this, do they? What makes
>>>> initramfs
>>>> packages special here? And what about those in isar upstream?
>>>>
>>>
>>> This is necessary for the initramfs package which contain the
>>> checksum/uuid from the root file system build.
>>> This ensure that the checksum/uuid is refreshed.
>>>
>>> It fixes the problem that an rebuild of a verity image leads to a
>>> broken
>>> boot after the build.
>>
>> And what will happen when the user decides to pin the UUID to fix
>> value
>> in order to have reproducibility? Won't that cause a needless re-run?
>> Shouldn't this recipe rather make sure to depend on the UUID value?
>
Even with pinning and same salt and uuid veritysetup will generate a new 
roothash during the build.

Quirin


> This is a general reproducibility topic: The task checksums are
> computed at parsing time and by that the tasks that need to be re-run
> are selected. However, this is based on the assumption that tasks are
> deterministic, i.e. same input data also generates same output data.
> 
> Unfortunately we are still not 100% reproducible. By that this pre-
> condition is not met. For normal packages this does not really matter,
> but for the dm-verity checksum this very well matters.
> 

> I'm just wondering if we could work around that by making this
> component non-cacheable. Putting Adriaan in CC for the sstate part.

The same  solution as is used by meta-security for Yocto[1].

[1]: https://lists.yoctoproject.org/g/yocto/message/50624

Quirin

> 
> Felix
> 
>>
>> Jan
>>
> 

