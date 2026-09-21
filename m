Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58A5C982ED
	for <webhook@archiver.kernel.org>; Mon, 21 Sep 2026 08:11:22 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44298.1789978279717209749
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Sep 2026 01:11:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CK8JrQg+;
 spf=pass (domain: siemens.com, ip: 40.107.130.1, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJ1XJ7km3TynNX3iuz9ywqalOnLMb/e86DzCi4KIIprWBSJVvYXHyjEyz5X//NK4xfrt84kOAFMbDth8EYCKPJwNfI6rsnhX+psyFjy8xk3P6lWXo24DKYrzNlbqbuIrvFbHghl1Qja2fVwYEifoM41L6PwDlhP8FZ01IeV7gJArAyVy5TsfTDcR8vEun//5GYJ8QWu/fEUmbRn5A8GuM8rt+3WlAnM9fIIcaVD7IaJXUaXRBHa6t1RA86JJjGXWksZirGt9T8TJHTCQcnX4wg8Yb59FPBuYjx6CcLV8VcXOmXB6GEdI9PqsT5rFvJkKw/Zq8e0T28TiZ0leSVZNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNT+F2eEosjv6clWVwVRW98reRxzaU/TrDQi+ZJ5CTA=;
 b=qJqZHEfqFvGZhKT/BoXRqynwnHgSPREaB00JVR7IN3js+/QEFzA01RYuxfE5dSsOcsEa6LyqZshaDkVVi9IuQStgprmdHEnT+pDbX/gCWajbXC6t9CQTzswtGsyAFhm+F4LxikSuMhpQUeyemThf0OcsykZsLx8LLCEkVBxXHcuYA+JfV9/oTpXEWsnAcCxgcMoPm8XKp3Si+KdQDV/GOU38Ok9FM91LeSubal2ueapTVDPsVACCFa9bvs31X9Zo4Ode/9sVOTlkhQ1jtW0k8kKJGAL4FfKHUxDR6fRdqS3tbFcWa/ue2kn0CM5xz2USQ+C/jRMeRRiamU4hS02vzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNT+F2eEosjv6clWVwVRW98reRxzaU/TrDQi+ZJ5CTA=;
 b=CK8JrQg+6UgXE7VQWkMC1ENvm3/pA+2myiiy5vR/92wZWidtqsSBEwakf/mPmT4mg2DZPEKcWPuYIclizpSgPxvCiCysNx2BrdPMAlOofYgwAqK68rW2u3zFWZR+yaLmswEm6pH9xgbVTkxHtTb/Rw3MAU/4jhgFcwkfHsTxuHQE07CGYPgqc7yzkT/pGiMSquIDcgVehFA10GP/i8K1ehmLC9HLUjyFbLuZw1LDylmv0kGQRteVzrUuii8WxhZb507z4YJD4tlT3F9ecA7UAydrw7eqs+lkp4EkFTQl7w/ZNqiA4y4CrzSTNKmPUv71DFG+eJFVy85mWyYYtI8Edw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5272.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:11:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 08:11:15 +0000
Message-ID: <1c5e7681-7a22-4b4b-89dd-c533ad992c62@siemens.com>
Date: Mon, 21 Sep 2026 10:11:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Fix file timestamps are not
 reproducible for EFI certificates
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 Kunijadar Shivanand <Shivanand.Kunijadar@toshiba-tsip.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "kazuhiro.hayashi.f74@mail.toshiba" <kazuhiro.hayashi.f74@mail.toshiba>,
 "kumar.dinesh.h95@mail.toshiba" <kumar.dinesh.h95@mail.toshiba>
References: <20260918085031.2464429-1-Shivanand.Kunijadar@toshiba-tsip.com>
 <88b6f524427c6415422dc6dba589b4cafb4cd439.camel@siemens.com>
 <868cc7cb-d990-42a9-a759-05f7cfc22e36@siemens.com>
 <004d186545ac4db6066399ccbc21cfe43a27cd66.camel@siemens.com>
 <37f91186-518b-400f-a3b1-c61e0207630e@siemens.com>
 <1b02da51fde7d2c2e71f33473ce6c933335df8fd.camel@siemens.com>
 <9ac58ab7-f555-443a-b866-6ee083eeb1fe@siemens.com>
 <639005687857cd59d75b22b7833f47bc68badefb.camel@siemens.com>
 <545bf5e3-17e4-4092-8278-fbea9b293cb9@siemens.com>
 <0fd15951a33172c365dd49862f371b3d6f533ca8.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <0fd15951a33172c365dd49862f371b3d6f533ca8.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: 6523246b-19ba-4205-8ec6-08df17b7e82e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|6133799003|22082099003|18002099003|55112099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: 
	o/u9ZlEhOmAj2aaA4+M7vexANAfkmTGGfvas2QpWDLQM6MHr/iZmsjfhe5cBEbScEMZIh9IOWW0xoAo/cDfRwtyO+x2O/qkWy3lbMjMV88oK1tq+4xXbAIpovCq1g9Zu23t8lJs4OzYLoASEyAc9xMR6DLv7OKJozco8iYekoADqfEMcEkGMbcxBP+BXDL8tBFqMQa7SUcTHFfBoYjRXTRfdd9HJUWPDvLjyTojs4WDfjLKbwJjVJ342EHQmdqZ4us8p3sA7lOYCrYRRMBCnXwKn3vCDfIRNnqfl31jYHnY6jAMZJGrJyY+Ivok130aMjTYISsaBUnJInRYJHd3DpJSmg88WagwYIMOiS3I2BrmjDUDiSV1HFYPgKRHl2GX1Z0uslQLVo+Nq3gqvB7cpNd5JZwhtqhzcSlZmQwHebsiMEokuT7Jc8ZbndYBaoJsBDX3C3EgNjXK6+CXOelOxXh7Yd3IDu/bWAMxnz7oTQ6zhZU5qlF4zF5SFBJTJfW8T6rd8JixDjV0ArdGNWKHwPbOAsYp0qzyqvVdjGrYbCX6e4WKxVoREGwyWD1ErP9viI7FLgZtWTuB9+Jn7j5FkCwN6t7TCHvV/0jXojibEOyw+xeNla5fG2AREjFo4GulM
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QXVkcXNXMHd3eXZ5Y2ZvRG5mWGFtbjFudDdoRVVySHc1VStTYldhZENvQndu?=
 =?utf-8?B?dnhGT2JjS1Q2VURWVGwwdTV1UXJKQlFsTXJ0ZkQ4WUx2RmhIWUMyWnhYNDRO?=
 =?utf-8?B?SjYybHRzclRxQlBzMzJocEtJbGpBeC9ZUkJTVEJwVy9IMUtDQVB2L1NHQ1Zz?=
 =?utf-8?B?TjRNWlhlQUg3Ukx3bHpvRDQwWkR0aHJQR2xZQVpONityWXhuQjFOYTFBLzcz?=
 =?utf-8?B?aVFNNkxtQUFmYWttTDRobjc4NjJPMHZWRDB1RTliazhlTVN3SnFjN2NJdjBL?=
 =?utf-8?B?WHByVEEwVjF1TXVJdDF0UGQrNHRtR3VXYW1vOGtXY3FTYjFCbWZWbEZoN2k3?=
 =?utf-8?B?VGNjbDlsRXNrS3BZeXVsWHdwd0dIQ0grdU9qakRsRFBwc3RQV05WcFpJeUEz?=
 =?utf-8?B?dng4dGdVRmtEdCtFVmlybGZadVp4bDRDR3VoVENBYm5NajFtY1pzb2xSaDh5?=
 =?utf-8?B?WVlrVGFLVWs2ZVlQUExTcHNmeG1BSGFXY1d5NmtCQ1JmZmZxQnBFdlhXYmov?=
 =?utf-8?B?VURDMmFYam1xbkdYYlV2UDZPa0s1b1NQU1grYU55QnU4S3RQbElybDVWb3hB?=
 =?utf-8?B?QmZXQjQzKzhydWNDbXhuVXg1VnUxSlBaWEJFSDV1UVJ0WGdxaFFHcmw1Nzdt?=
 =?utf-8?B?NE5Kdzg5VWhYOUUrS3dHVlEvUVd2NkMzMldYUjEzM1lOMG9aczVXcXduQjg4?=
 =?utf-8?B?MUNiWElrVFNTWHNWN1hEMW9xSFhYdUlCVzgrb21YWndVdUl6bk9SdWFXU05L?=
 =?utf-8?B?LzNlWkZwMXFzUzVCYmROMTdGVkg5VzBkVTBTMFYyWWVRclhIZ09oNFhqQ1Fk?=
 =?utf-8?B?c3dzMHhxTDdPNGFiQWQ3NXpSd0hGNmtWNXJ0M2I0UTEzK1JnR0tTTThqMks3?=
 =?utf-8?B?VGF1eVFlMlJEUkpPWDByekxwSW5JRmxpMkpPUFo5czUyTDNQczYwSHNYOFJ3?=
 =?utf-8?B?OTh6dVpaYmdVKzFrd2dJUjBhVmtIa2kxTS9yUzlJMHFPTzJDY1IxOWUrUDkv?=
 =?utf-8?B?MjVIUFZWN3laYVk1STB0NjJHTjhJT3I1VTJnZUZYMnFCRG16cVBibVRqbjEx?=
 =?utf-8?B?SkNjcmlubEoyM3NIM2tuN1RLaklBY01uVEhSU3Z0emxEQ0ZHNU9WeUpWUWM0?=
 =?utf-8?B?alphcktyOXo5c0liY2NpVGFDcmRyK3VFeHhFUnJsbUYvWlp6cjhJL2YrMUpS?=
 =?utf-8?B?dURpOHh3dG9YbXZKZUJsN3MxSGp6NC80TjUrVUZYTGNBSXdraUdiRmlwOHFB?=
 =?utf-8?B?eHhqcHNPSTBQcjkwc2xiTjVoT0k4cnJuRU16Z3dyUVpNRmlvdzZNd1p2SFoz?=
 =?utf-8?B?ZnRVRTFmTmtPZVhwaWtXWnp2Z3VRWXlPK3FmREo3UEZpcnNOSHlVS2ZFSUxV?=
 =?utf-8?B?L2FhQnRpRlczQkVzUzhXbTlSL0k2Y3RTNk9UV3kxQTNESFI2MlEzY2xoam9a?=
 =?utf-8?B?bGFrVFdjejlnd0FNZjUxQlhKb0xiVXZnNWF3S2FiSzFlcy9ScjBiNWRXSXU5?=
 =?utf-8?B?OVZlS3o1VkNJNUNKNTRZSXVUVDkwbmJxOTlRTVpwOHByY0ZFOVpSems1WEhl?=
 =?utf-8?B?RXlRSXRsZ3NZOFhZUjlXcUh5NHk4VlZONXhXbEFZTi9VbmllUTM3dk9sQXZB?=
 =?utf-8?B?QkNPblhnS0lGdnhrb3RUOHIzNWtLMUgrMnNKODVKSVk4QUVINkJRUzE2Z0Zz?=
 =?utf-8?B?Rnh3Nk9WYzFiUkJEdWZxUWRmUmRwZXllSmxXVFl5STlzSUZBWkZMeEtnRVhD?=
 =?utf-8?B?TzA5RGR6QUJCY0VTQk9MRjVMOGtpTUsxVlVJVGRGUXRxeXRaeTZiK0pOK1hx?=
 =?utf-8?B?RlAzL2F6ZDFYYU5UWEdSWGE3eWtFMk03ejhoa1k2VW5oOGhFSDVPbEl4Y2Iw?=
 =?utf-8?B?RDZUZEtyTVZGN2NBa0tkbFI0TTFwNmhMUmhCbXM1MUZMUDUzUWtjSVJkVW9a?=
 =?utf-8?B?VjV6Smd5UjdWckQzeTNZQ1lab1FFeG1xa3NzM0J2Nlc5NjdjamIzdDByNnRO?=
 =?utf-8?B?endTWXlsaFk3cDI2Sm9sNDlGMnl3QlNWYTQrbnF6S0tBblA1SitzM0RWUTE2?=
 =?utf-8?B?MUNQOXQ1Z3B0eGNIWkNBaWppdWxtMklBbXRZdUp5bUtKVWRxbXg4eTl4emFY?=
 =?utf-8?B?ZU4rc01yMjAydnVOa3pXWGZ6R05XUFdEL2VpZzcyWi81YXp2T0NKMitFQUx4?=
 =?utf-8?B?eDRLcERpQTIralZsa3M5MXJFRmMvdkdSM2djMkFiMkM5dXUybkNJTGxBdTh6?=
 =?utf-8?B?UnRiVThFcTlKUkdEajdDZ1RibXc5ZWdDYjVYZVpiQWxCelVVVWhTRkdsdjI4?=
 =?utf-8?B?bmxBcEVIZnhiM1E4S3RsTlNwc3FuTTY5dkRCZndkdytSOWVQalc1UT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6523246b-19ba-4205-8ec6-08df17b7e82e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:11:15.2831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Syd+7WcyJoB7lYp7FIwbLP2csIQblf6Lsn7yEc9Gl/r0lAC/X96zLvwaZbaAf4XfmWyVC6erkdMMh8NRl0hzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5272
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Sep 2026 08:11:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24255

On 21.09.26 10:07, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Mon, 2026-09-21 at 09:59 +0200, Jan Kiszka wrote:
>> On 21.09.26 09:53, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>> On Mon, 2026-09-21 at 09:49 +0200, Jan Kiszka wrote:
>>>> On 21.09.26 09:37, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>>>> On Mon, 2026-09-21 at 07:16 +0200, Jan Kiszka wrote:
>>>>>> On 18.09.26 13:21, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>>>>>> On Fri, 2026-09-18 at 13:01 +0200, Jan Kiszka wrote:
>>>>>>>> On 18.09.26 12:54, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>>>>>>>> On Fri, 2026-09-18 at 14:20 +0530, Kunijadar Shivanand wrote:
>>>>>>>>>> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>>>>>>>
>>>>>>>>>> Closes https://gitlab.com/cip-project/cip-core/isar-cip-core/-/work_items/162
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>>>>>>>>>> ---
>>>>>>>>>>  .../secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb  | 8 +++++++-
>>>>>>>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>>>>>> index 263f794..6a5357d 100644
>>>>>>>>>> --- a/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>>>>>> +++ b/recipes-devtools/secure-boot-efi-certs/single-key-to-efi-certs_0.1.bb
>>>>>>>>>> @@ -24,6 +24,12 @@ DPKG_ARCH = "all"
>>>>>>>>>>  
>>>>>>>>>>  do_prepare_build() {
>>>>>>>>>>      deb_debianize
>>>>>>>>>> +    if [ -n "${SOURCE_DATE_EPOCH}" ]; then
>>>>>>>>>
>>>>>>>>> Good catch! Thanks for debugging this. Please just use
>>>>>>>>> DEBIAN_CHANGELOG_TIMESTAMP instead of the SDE. This variable is always
>>>>>>>>> available and aligns the timestamp of SB parts with the one from the
>>>>>>>>> changelog.
>>>>>>>>>
>>>>>>>>
>>>>>>>> And simpler code - even better.
>>>>>>>>
>>>>>>>> Thanks for debugging my bug! :)
>>>>>>>
>>>>>>> While thinking about it, I'm wondering if the timestamp actually has
>>>>>>> security relevance (e.g. for checking the freshness of the DB). I know
>>>>>>> that timestamps in general are pointless in this context, but I'm
>>>>>>> wondering why it can be set in the first place.
>>>>>>>
>>>>>>> The DEBIAN_CHANGELOG_TIMESTAMP usually is set to 1h after unix epoch
>>>>>>> (for technical reasons 0 cannot be used as this is "magic").
>>>>>>>
>>>>>>> If we need a proper timestamp here, we should provide a way to set the
>>>>>>> DEBIAN_CHANGELOG_TIMESTAMP just for that package (e.g. by introducing a
>>>>>>> variable).
>>>>>>>
>>>>>>> But still, the code should use DEBIAN_CHANGELOG_TIMESTAMP to align the
>>>>>>> changelog timestamp with the SB one.
>>>>>>>
>>>>>>
>>>>>> This has security implication because the timestamping of the signature
>>>>>> may be compared to the revocation time in case the signer's cert is
>>>>>> revoked. Signatures that happened before the revocation time will then
>>>>>> still be accepted, those afterwards won't. Therefore, this timestamp may
>>>>>> have to reflect the actual signature time. And this is obviously
>>>>>> complicating reproducibility.
>>>>>
>>>>> This is not just complicating reproducibility, but is in general
>>>>> problematic:
>>>>>
>>>>> The packages we generate must at least be "logically reproducible" i.e.
>>>>> the behavior must not change across builds - which it clearly does in
>>>>> this case. Otherwise this package must be excluded from sstate caching,
>>>>> which also means all downstream tasks cannot be cached (until we have
>>>>> hash equivalence support, which then partially heals this).
>>>>>
>>>>>>
>>>>>> I would vote for making this package (and possibly similar ones)
>>>>>> reproducible to become an opt-in feature that we enable only for the
>>>>>> related test. Or only for snakeoil keys. Maybe the latter is simplest.
>>>>>
>>>>> No. Please just add variables which can be set from local.conf to pin
>>>>> the DEBIAN_CHANGELOG_TIMESTAMP of exactly these packages to a user
>>>>> chosen timestamp. Updates of the timestamp must be explicit. This
>>>>> means, we are still 100% reproducible and perfectly cachable until this
>>>>> value is explicitly changed by the user.
>>>>>
>>>>> This of course also needs to be documented.
>>>>
>>>> Sure, but I disagree on having such a variable for production. It's most
>>>> often wrong if a user ever runs it with a pinned timestamp for real key.
>>>> So better not even expose what will be security-wise incorrect.
>>>
>>> Hmm... A user that adds secure boot support to his image MUST know what
>>> he is doing. We can't "hide" all the complexity.
>>>
>>> What are the alternatives? We can't safely use a floating timestamp.
>>> This makes things even more incorrect in most cases. Along with the
>>> global variable, we could issue a notice regarding the used timestamp.
>>
>> As I proposed: Demo keys can be signed with pinned timestamp. Regular
>> signing must have the timestamp of the action to reflect when this
>> happened. Otherwise, you risk to resign something with a date that is
>> older than the meanwhile declared revocation time.
> 
> Fully agree, but my point is that the time of the action is not
> predictable if you build with sstate cache (if the artifact is taken
> from the cache, it has the old date). This time explicitly needs to be
> set somewhere to end up in the bitbake hashes. And as only the user can
> know what time is desired, we must make it explicit.

IOW: Production-signing packages must not be cached.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

