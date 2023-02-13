Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831C1C636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 14:48:38 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.70])
 by mx.groups.io with SMTP id smtpd.web11.16124.1676299707126743326
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Feb 2023 06:48:28 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P8OFPGow;
 spf=pass (domain: siemens.com, ip: 40.107.14.70, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kx9jWxAL6R4LzTL1ZK4ltqPrC6ZWm1dEM8ntwSTPxD0Tx+cP29KsRKpRtFaYnSwiwcRMOukzbHlRtgCYRWCEnkn2MBZfqltAitX9XE0DolHd6hPKoo347W0mlRxq+se90dR34qyuUG+ANZjIA8ZWGgsXVSSWTAhTAedia1XyI+43gZ/mc9Z0D0W+wEUiK6Z3mdW29Fl/OENCOsfTwcW2rjv5MPDMNryuUinpGOK2HU3vdipOazSeun5UI25ZkWwMYxxK0n9m51+TPZS0jyuVRlUPfVvYNkpZqi/r01jjikpKfQ+rf1ViAmgE1Bxwjs6BJdztVzSca3QSuiCFcL5+4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HP7Es/vsLi8fq8HfuuN9qaTbBT0z8ESFfQ5QHrC4Oo=;
 b=n2bMtH+EHdX5NEXm3tRMkuNlx8C2TyVxfRS41hbTZvgpSK0OwmdvxfwA0fhAaijTguE/+Dj5HNK35Mo9aoR5y8vuenzXqpZGGYdxGaMo8qNffQxUPi9rWss229zP7Hoo4gUsPQeFp/lNMIsF9n0mE06QHHx4GQrerSdRCFVzkW+SlytyIFiikZu7hA+pqFYPk1bELStz2LaTyqqKc8v47VzilHzj5/0gEpPh3bhRtuopxKrJaNsMLmVsOi1Drq3ES3E4zWbH3znnJQY3HLuiZoQS+e8MbORV45Fb6Wo+RJWZVLDBcKsha6K9sOVp5sBeeIu7ar2acXfHzDCq2B1Kig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HP7Es/vsLi8fq8HfuuN9qaTbBT0z8ESFfQ5QHrC4Oo=;
 b=P8OFPGowY29PNwbXXNdXWNawWXZbUZKNuAqaIxh98k6G/EU1b9G5FMQUOTXD9gTB7c+p0wNiSHTgMequry4M+O55OaH/spttBw7augzlsEYQlQqHfbgMNMGe+CqkpT+XcQR/ql51q6k9Tw+OHUq12HLGxbOkpCfSPWGEUdGmf1HxZFtJj3cD+sPaRJly898mVN3HPYAFpgxKYmRDvqv2E8fkTx0boodesQxDyJjFq6Fe+4LXrXpfMT58ir7+0ImseMQXnc/plOs/7iQoBsbsRhC5Jwurt3VVckeVCPBLJwr+jLB6MwI2gvRhOSkXhs25Aypx5cuOqIDBMZD4qad3yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU2PR10MB7726.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:46f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Mon, 13 Feb
 2023 14:48:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:48:24 +0000
Message-ID: <71218736-861b-745a-6568-f424e343deec@siemens.com>
Date: Mon, 13 Feb 2023 15:48:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH 1/3] ebg: install for correct distro-arch
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Bovensiepen, Daniel (bovi) (T CED INW-CN)"
 <daniel.bovensiepen@siemens.com>
References: <20230213085741.1242658-1-felix.moessbauer@siemens.com>
 <f2a2f503-c85e-bd28-aae7-4624283f018d@siemens.com>
 <b0784e004e1ea88e77070d7e01ee048758b02605.camel@siemens.com>
 <be9f384b-113e-f5bb-fa85-51ce9f194860@siemens.com>
In-Reply-To: <be9f384b-113e-f5bb-fa85-51ce9f194860@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU2PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe42fc2-55d4-4dbc-d213-08db0dd15b67
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	dWNC+h1bAP2kFpitEx6DuePJAt5xQu9L2KW6kpZIcF6pdjwP1yXhM4h5VQY13ubNYRFqI4e+VUN2HtfUXzt+sgbKJ/LeGxOv/vYASm7VIJEGvoK2QnneGjcMNA6SrTMFdbWZ8jwQNZr7y5bvyXY5pPDnGlk4xh3Jmb28lVEahcfCa37azDDEvWH2vcmJzK7KVEF34NUPKxbQBeBO7exMPgOEK6mWYhio7f1+StQTX7nOlNoKbmrMN/t6lIhiwz+CzQ8SKvedq5DSQIzppFpf9esHyoktgoW6z4VaXvGSG8cu0HXysAhgmRdyk7UJGsrq33uAhUh6fHT9dTDiRNCqz4C6CCvkF4z2/qGLZSoX0sn/pYCrH6izM7kJQlGJIuwCtq2VmNzIeiqQ850laTYXpLI45QZnSttt3JTrtH+jXkuvwknGopv4cfaZBuUbSY0liu0MyN0z+IbVKgr39iltLmsZmjbrKJZbaI+pI6g5Nr49w8ibP6i5tbr0hOWrOj9WY06UL0nIEWDjxuPQxiLWz/k/5y94fjGBjyjjPKb2YWWPkstTMSIypDQFKSJl8R+FE7q4JeJv6V67lqtrJyjDW3Q7Ny20UXDEAjjq4YMvFLHqL6wY7b6CbwtfXcZ3Qp2E/5/ajF1jImW7v0tSBly5MwHUNfpEHtC0LypuwajrCdTvoNFSjJX1XjMN3htuvqs4ZRZ8dvzioBwIpzhmtY5i26RFLkAtuy1vEyb76+gnEVk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199018)(31686004)(31696002)(2616005)(83380400001)(2906002)(44832011)(186003)(6506007)(8676002)(66476007)(41300700001)(53546011)(107886003)(6666004)(6486002)(478600001)(4326008)(26005)(6512007)(86362001)(82960400001)(38100700002)(8936002)(66946007)(66556008)(5660300002)(36756003)(316002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L3RHaUtvSm1NcGl4dklRY0QwNHB4WnhNQ0pOdlZ5dHViOGN1SGgrYUNtb09s?=
 =?utf-8?B?NUplMlp2aFFDeVFJblJpRHdVczZJU3dvWlc3VnlLRUJ0WTExelRjdUFwUlFX?=
 =?utf-8?B?dUFMRGRBL2RpWmowaUFKNzVyR1NYUThOOEFtNzVPU3lOWU8vQnVRemVXNTdG?=
 =?utf-8?B?bFpwT3gvcmQ3UHQrMmtaTnozU1RleTRWTHhvZC8ycEQxREJuRVdYWFVKNlkr?=
 =?utf-8?B?Wll4bGR6blBJRVd5UnBiUndyTWtlZnQzblFQbE9uR2E5RTIvc2l0MlRrWVVx?=
 =?utf-8?B?ODB6WG15WEVpY084YUNyVzZGODBUTVNhMDZLWXgwMWdBZ1VRMXZPa0pETnlY?=
 =?utf-8?B?ZmJid1BQNVl4Q01yTjB6ZHVaNXdjS2s3M2FQMWdIemRuSkM1Y0R5enpIVEVs?=
 =?utf-8?B?Z3krTFhEWFFMb1FXcWEvYWhPOFBqNjN5YVhENHVkdWJzbmR5SVdhUmNlM2Zy?=
 =?utf-8?B?OWlvbHhnZ3owUTdocUs5QU1YVURub1ZvaUpmKy80aFBIbXpTYjlGd2pjanI1?=
 =?utf-8?B?TUVyRDNiWHVBYm5lVTFQWHl0Njc2Q1NTSmtwcDNsZHpaejVxWjVOTkFvM2RU?=
 =?utf-8?B?bHVpTTQyV04yQ3dNZ2xMdWg3T0JydGp5TEdQUDR2S1hEUnpXb0U2N09iMis5?=
 =?utf-8?B?SCtDWTUwQ09JbkVqYlhUNExPaFZoUXBOL3hUUlkxd1VBSjc5TWxnWEQxR01C?=
 =?utf-8?B?TGFGYWo2RTdGMnluQ2xzc1drZ2cza3gxUWlaZjcyOGZ6VE8vOHorY09WQWg1?=
 =?utf-8?B?ZzM4QkE5SGZ3K1hZN0lmV3ZLQ01sNlM0b3NNa3oyTFRUbXVrZzYzS05TVjlO?=
 =?utf-8?B?TnYyUkM5UFpFUVdGelc4cm1QakpObmxORHBPeGNaWG1RS0VCNUdPZmVxd1NJ?=
 =?utf-8?B?OGNLQTR5WGg3TWFJMSs0cWIxUFpiSER1MXEwVEJueVA4NWNId081d3BsRWt0?=
 =?utf-8?B?T0xabm5WUEJOS1lKLzU1dTUvMGxQb1gyMTVoTmF6QWp6cEJ6eHhrUU4rWFNP?=
 =?utf-8?B?YlNvZ1AwcmJ5RzZBL0RaVjlLR2lUZnp2N2U2Mlp1YXh0R0NrQitON3RqUS9X?=
 =?utf-8?B?bHYxZGkvNTduWXNGT1pKekJLQVJINERIREJ2aGpuNlI0c0JORjcxbzhPaUJW?=
 =?utf-8?B?NTVBbmhTRDE4TWNybDNHLzlkVDJEUU9kUVFMbERTckF1ajBvbGxHbjFCb1pM?=
 =?utf-8?B?VjdXd2FzdDQwVkJkdTg3U2NBbUVUVFBOYmRxM1pFd0JIeHI5ZXFQNzFTMHZQ?=
 =?utf-8?B?bjlYV2JFWjJOQmtCYzlQd3BpeWdlQnVrTTFFTzExMWY3elh6SlZjUTh6MUpt?=
 =?utf-8?B?ZzUxbjJ2NG40U1NlTmtUWHlYWUQzVlcwb1hxckpZaEVZNEpPdUlLMnlDSGlq?=
 =?utf-8?B?ejZLYllYSDFmOW45U29pMHZDbExZU0YzUU1udUZiVkp5bVNaekY5cWFMdXpH?=
 =?utf-8?B?TFJmbjN1UDExUnh1ckhMdlJDOEk1WnRHUGNUTzAxU2czWmtEZ25sajdDcXdG?=
 =?utf-8?B?ZTRCS1RyNzE3eGNiMlRGNWZnb3p2N2t2OFFlL3BBT0hWZFU0UXR4eng5VklN?=
 =?utf-8?B?cmR1dE5tMUNJSG13U0JHbFJTOURtVDlWRzh1UDFmSE9zSnBCc1NNeDZ0d1Ix?=
 =?utf-8?B?emNMU1UxVGZFWnR5UWtMbzlIdUsySDdpdnhZV1JmSVR5RTJEaFBwSU9Cc2cw?=
 =?utf-8?B?SGdtdVNuSzh5QWlFMDZKSmpxakxsRGk1NkwxOTlYUTRHa3pvVk5MWWRpQ0tZ?=
 =?utf-8?B?dExSdC9xOUR1eWs1ZFp3a00vcjI5T2x1RnB4dXpmUU45dnYrQjduc2NKU0Ju?=
 =?utf-8?B?dHVhaDlhY01Sa3M1TmxlZHZLei9DaUIzaXBHMWhxRHFhd24wcWxEU1NoUy9S?=
 =?utf-8?B?Y1hHTm55Z2U5ZWtzQkoyWWZnSnZ0SXo3cGt5cWhvTU1EZnpJaVk4SS9NTkpC?=
 =?utf-8?B?VHJMYnF0cWNadi9tcStYNmpVaVV2eGpPem5wUERaWVJ2OGRnbEZ5K1lhNE9q?=
 =?utf-8?B?bnl6akF2R1lDMnhicklZMkpkNmV0aEszL0hvb1BwdnF2b3V0OFhUWGd0ZmpE?=
 =?utf-8?B?Y212YWwvRVF2RFRiMFpWajc1MTNJZ2VmNlJRNm5STlVzWDdIVG1OWWxaK0N3?=
 =?utf-8?B?b0crSkxpUnpIMDBPWFVKcmNXQzFraVNFeWpBcTRCUDJTQi9EQVlJMVlhNDZx?=
 =?utf-8?B?TUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe42fc2-55d4-4dbc-d213-08db0dd15b67
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:48:23.7319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jn5Ua1nlWIuvVO3ASEdJzrfB2p9OkwwMXpnka74ha/7H+4LIHNBye1v/uI2KJCp46ooyxcKXNI5mF8tk+lo0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7726
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Feb 2023 14:48:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10681

On 13.02.23 15:43, Jan Kiszka wrote:
> On 13.02.23 13:09, Moessbauer, Felix (T CED INW-CN) wrote:
>> On Mon, 2023-02-13 at 12:29 +0100, Jan Kiszka wrote:
>>> On 13.02.23 09:57, Felix Moessbauer wrote:
>>>> The efibootguard package is architecture specific (similar to the
>>>> systemd-boot package). Hence, install it for the distro-arch, not
>>>> for
>>>> the host arch to make cross-imaging work.
>>>>
>>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>>> ---
>>>>  recipes-core/images/efibootguard.inc | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/recipes-core/images/efibootguard.inc b/recipes-
>>>> core/images/efibootguard.inc
>>>> index 26026dc..b3fe911 100644
>>>> --- a/recipes-core/images/efibootguard.inc
>>>> +++ b/recipes-core/images/efibootguard.inc
>>>> @@ -11,7 +11,7 @@
>>>>
>>>>  IMAGE_INSTALL:append = " efibootguard"
>>>>
>>>> -WIC_IMAGER_INSTALL:append = " efibootguard"
>>>> +WIC_IMAGER_INSTALL:append = " efibootguard:${DISTRO_ARCH}"
>>>>  WDOG_TIMEOUT ?= "60"
>>>>  WICVARS += "WDOG_TIMEOUT KERNEL_IMAGE INITRD_IMAGE DTB_FILES"
>>>>  IMAGE_FSTYPES += "wic"
>>>
>>> When does this bite us? Current master is not affected as it seems.
>>> Bookworm/sid, when all efibootguard archs are available at the same
>>> time?
>>
>> Yes, exactly. When we build it manually, only the "correct" package is
>> added to the isar-apt (because there is no other).
>>
>>>
>>> In any case, another regression from the switch to buildchroot-host
>>> in
>>> isar. I had fallouts from that as well, and they are all subtle to
>>> debug. Must be documented in upstream's RECIPE-API-CHANGLOG, with all
>>> its aspects - please fix (you caused it in the first place ;) ).
>>
>> Well... in my opinion this is not a regression but just a bug that
>> shows up because we "cross-image". But yes, that doesn't help our users
>> much. I'll add a changelog entry.
> 
> The original imager was built around the assumption that it runs as if
> it was on the target - hence buildchroot-target. That was changed, and
> it hopefully will never trigger any problems with Debian bootloader
> packagings themself. So far, it only requires downstream recipes to
> account for this new boundary condition. Thus, it broke the recipe API.
> 
> Jan
> 

That said, I've picked this as fix into next already. The rest still
needs clarification for me.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


