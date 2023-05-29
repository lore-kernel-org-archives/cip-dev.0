Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4CE6C77B7A
	for <webhook@archiver.kernel.org>; Mon, 29 May 2023 10:57:33 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.72])
 by mx.groups.io with SMTP id smtpd.web10.46974.1685357850521315487
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 May 2023 03:57:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mHnc+ddG;
 spf=pass (domain: siemens.com, ip: 40.107.22.72, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htoacuSZmUDFo3JyPDJ+5i7/mFaZ/jSjeq71J2jWIqdrUe6n6kvc5UMpN3d5Gs24XFC1PB+4OlkQ0961TS9AbU0AIftC9hSh2O6PSvVZU7xyIsBl33rBnA1W8JW4KtxzIGETcojHv0KjeUTZNfTn7GEsNoMj/UF5Hj5HrD7+Fxg4o1+kSSj0qZ2UsQTF21s19VOODh7O3gqeun+lFxOs89idBnjY0rAXzChuLRX5VfsnFU9lLoRJmK0bU0JdIAOyTmhIytRA2cbACS2OcBNSttD+ohX0J3JBg/bNNfhOb0iFejpYYS3IxqZhd6pshW8SuF5rAXJcTw8r4KKTRj9niw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cqrKIp7Phf7VVoHC3rVhwAX0IG3FX1B537H/dZ5bpwc=;
 b=ZGGZ8aFuktk1nD1E7FbeyF7DZXGYw494v+9+Fa8Hec6MMM5yDP4X1eXPBmo1pr6tD9QTIzw6DumQKqGAXgkAU2GAK6ZnayvHy3vG8246YyyLVW16GJj6TXfFYaFYOcG3j6M+DfVcdN5+fdGn9QxQnP55LGtTUfzUBfGBy82D2Vvvf8yMG5rahTjrIb8wdjwN3P8yG/BicZiulh9HKRgGtjvcNJxSAngaGmhJJSbhOBlm32MDqqpof1IYzXZBp8YctNJ9D7waDGMIOE3R4CyuPIT78nhHshvF9gb0BwitWeX/KJi4oziRGTEEvjFjoOInzwtOISMh5VoERMtZVKaRwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cqrKIp7Phf7VVoHC3rVhwAX0IG3FX1B537H/dZ5bpwc=;
 b=mHnc+ddG7caZ6jfCUl0KezSDL1dcabsoFSwC4Aj9uX26TVydWu7qLx7WBfGgFy9lH+MATVor5jTkBVnCsU8HM2cOCHKSfqK84QUjTM78/1AXlqHiTCvODdMZmcF1ltLxOCZZ4gKt5WUOqHRboG0dJtuWYoEvTZT3dabL7j18zZxiDRu/+QegcMMDlKfzsrk+WOBb7434TJ/ggUgaRFfGEZ/7ZRkOd0eBz82lZU1urFOME+M7+hiVqYibzri8+uFumWf/zHjHIh5im3xKbHnHVgnmoXcgU/u50CD44ySUGKS/EoVWAFqt3LX9Uw+ZAYX3WR5ohfgz8r4zh6pZfoIbBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6685.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Mon, 29 May
 2023 10:57:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d638:8333:21fb:5f18%7]) with mapi id 15.20.6433.022; Mon, 29 May 2023
 10:57:25 +0000
Message-ID: <54be2f38-e432-aaab-8df2-da2bbe791575@siemens.com>
Date: Mon, 29 May 2023 12:57:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH 2/2] initramfs: Add recipe for optee based
 ftpm hook
Content-Language: en-US
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>
Cc: "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <664ef5ea0fa832ff709718b249a93864f98714c6.camel@siemens.com>
 <92b92c22a0e0daa636398ebca60945fb087b5555.camel@siemens.com>
 <7047e533b93015d8be1b9ff6043f562a9cb8ba7c.camel@siemens.com>
 <e8ffddc06094fb8513ed49c40b9fcee5771fb4ed.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e8ffddc06094fb8513ed49c40b9fcee5771fb4ed.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6685:EE_
X-MS-Office365-Filtering-Correlation-Id: e72ca263-5f1a-451e-a132-08db60337c4e
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wcF237K0IhM6/x4jUI1f/eVplGkGQDPwvE73/H7j005GqpoREJWLh4LeChLbckhAK8w9i8/oLX6vt8b5sUH1VQyyrYIQjQuUTF1YVoVHHfcKsXxrSAt/s+wRw4GcIhGnCb3OUZaK9sqCw9GSqF/1R+hhIJlGcTArmLCjAsdO8v5X+Ka8geKkcOIEZ8GWSsTjo0fae/jcJIo9TjzqfDts2mblfaua3szStOn/tuiTNH03E1asedC3w+fGMeO3ddBPQo5CvhjnVq/EgqTdMnkzA10n+2XtAeFenq3WIEen4yAGDy53IY5YVZzRHxjSJi7qOYuTlhiiP3FeFXmNT52ySPg9bheWx5NhMFgNOfVnRAnoOeLCEOjQJa0iD7bwanDC9AVCU8Yj+qR+SiTF1YKg+q4Ua8az1KoYe2ZLc67gMUsuBId+GL9iuXIXH3lfpg0CxJu1/+PmhmNPx8r5Ww0P7j70srXKWOG+EgE38Nut4YYTb5Ir8m/45S47EXwDNp3LAkXA4Gwv5QnrNpBgvw1JjXSCmDNdG1tI6OINa8tHq+Zo7pq4hlyC3kk31oS1SRIxtZnt2rddVkl/bbyDpUl1F+H+8F0DV9gzeF+mFudpu4PbAuDbJT9h2YDJ/BSwChdnS+pYZwXVzqj3dhUbR8JLYA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199021)(966005)(107886003)(186003)(38100700002)(2616005)(41300700001)(31686004)(53546011)(6486002)(6506007)(6512007)(26005)(6666004)(478600001)(110136005)(54906003)(66556008)(66946007)(66476007)(6636002)(4326008)(82960400001)(316002)(5660300002)(8936002)(44832011)(8676002)(86362001)(31696002)(36756003)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?S2E4TXRYY3o5WWVnd1NWcVZJRCtUb2VYVE0xNVlibTZzRDdJQXVHTkhSUEpx?=
 =?utf-8?B?eU0yLzF3SjZBZUsvSS8yckNrb05vTXBmZGZ5Rmg1NnZzbW5CcS9tbUplbG1Y?=
 =?utf-8?B?dlkydkljeS9hVkZmcGw5MWhOS1JRYlUzMTV6TTFnem9kWUExVFg5VUVJaHUv?=
 =?utf-8?B?VTVwUXZ2dEdzd1RhcVJTUEtJanNrdElBTHU4b1J0Qmd6TmpKL29lWm15cUFa?=
 =?utf-8?B?enR4d3pOMjJRSG85YWwzRHVyL0dmbVlOeElLeHFRNjVzaWFSUUh4ekVHT2lI?=
 =?utf-8?B?MEN6OEhKQ3k1RWFhdlhKL3J6WFNCWGtLRWpRWGV4T1JMaGVXT3V5L1RnbmJw?=
 =?utf-8?B?dWozTDJ3Mi9SallNODN3WjFnL2NmOE9rbk9BcTlTdlhHcUp1RDRlekNOK2JO?=
 =?utf-8?B?N0NFd1g4eDZLVzVHM0tTamN4QjZsWEpMcklxaXdranlFeGdwYzBqcG12Snhi?=
 =?utf-8?B?Sm0ySFhFd2s2OXJqbDdvRXBOdzRWQkFOMUFDenRhTXp6aGRLYVdsY0VUNklQ?=
 =?utf-8?B?TjRNcFg2c2JEUzJYUDFIanpsUkpuNnNhMWN4VG9xUVlTdXFVN2daS28vOU53?=
 =?utf-8?B?a2RiM1VjajVxMVpKVFdWVDJHTzRNcG9wSUErckpjbzI2enQvMkN5TnRGcHZS?=
 =?utf-8?B?ZDRkc0krcnNCTmlsZm9Ha1FvZzV6Qzd0dXpkU1FUdmJ0OWg2cDBVQkVSRmpC?=
 =?utf-8?B?OWRHU0FGeXNEeE01bTZiQ3BxeXExazQzeC9jMVh6TEppVVdyQUNESGZQekZ3?=
 =?utf-8?B?OHU2T3hhcFl0bm9UZW9uOTlJSmFMcTd0YjB4QXFDRjN0WUhXMVcyd1V2aXc4?=
 =?utf-8?B?UHdnUDI4SzBNTWF0a1NsQm5aNVd0QkN5UUE4WW5naVJMNjNLOTIxL3oyZytl?=
 =?utf-8?B?aXd6WkpxVDduUmhCdnM2emtQb3JRWVNCV0l5bzhONjZ3eWhvc3RONnVWMHJF?=
 =?utf-8?B?d2xNa0oyL0xVcWh3T2dkU1pkZUxHeThVM1ZZQnpUeDcvdGNIRHpWNkI5Y3dm?=
 =?utf-8?B?VThTOHF2Ti9qa1FmRW5QMDR0c0FTc0VYS1pHTk9laFpGQk1YQktXNXhDMWZp?=
 =?utf-8?B?QlFTWHpERVVZbzlaWllRSHhJckRZYlg0Vkt0cldOMmxZMUdXbTVwc2k3WHkx?=
 =?utf-8?B?alZ1Nk1ONXVGWmI0Z29ySHhFdGNlSU0yNVFTb05LS3hHN0tyN1JNelh6elVw?=
 =?utf-8?B?ZUxxelhWTG41dEp3ZXhFdnVFaVdBVitnR1N3WkFWQXlpdnVWemJFNmJMSDJZ?=
 =?utf-8?B?aVc4bXhoeGtJRVlDb3l5WHZSbFExMDlaR0d6SmppMGRFUnp3LzJFdzcrL1Qy?=
 =?utf-8?B?SGFHcks1ZERRVTZRZm9DdkJPMnYvYXcyb2pyNWZxU0pGUExkMEF2c0t6Zm9L?=
 =?utf-8?B?UE5CWlBCRmxlRFY1bzdydVpRZnh4amo4WHV0WGgyN3hmVnM0UzJSVGNRU2tJ?=
 =?utf-8?B?UVBLZjVLQTdIQzNpaFY5WUJyc1YveFNGTkdrdmoyVnRaZEgrNGV0c3RVK2ZY?=
 =?utf-8?B?OTZVVzAxbmtLODJJaG1WdWtNNk1iQlp3ZWV5cHFUeWdFSjdCdnJoNWRJWDgx?=
 =?utf-8?B?dnIyWVNtNjhySDVtYjg2NFE1cW9ZSzBCQXRKT0tjUWhVRGFTdGl6Slcramds?=
 =?utf-8?B?U3VscXc3TlBKQ0lXZFdSZ25RR1QxSWsyKzdHUWVrWXF3L1lXTDYxZCtXNkFD?=
 =?utf-8?B?UVB0R0pWWitSTEZtdEdLY2x4Y3FqUTJUbXlFdEkrMko1N0xyT2xDb1BIV2pX?=
 =?utf-8?B?UXFSTnlYYjBXNUNndm5jcHo3a0RsUGJabEU5VGpTQUJiRFZKbGpmZm96T0pw?=
 =?utf-8?B?NHNMVEIyMnZIWDJMNjhzS25naVk2ZE9KQjY3UVhGSVAzYXJUK09ldzhBdU53?=
 =?utf-8?B?NE5uY2VnSzlsa3NvVzNFODlZS2s4YmxXNHJDV2dHSC82SzlNczlNQXJScHNa?=
 =?utf-8?B?N3NVV05UU2hFM0FpQzhob3R3dHUzT2ZlR0ZmOVVadElnOUx1WGhRWXlxc3Ba?=
 =?utf-8?B?YkFXcUc4NE51YzEzMVlqV240S2FheHZ5TWM4aUxBMThJMXg3RWRBNWdaWmpt?=
 =?utf-8?B?RUJxMVoxbThhZkg4TGJNQVVEU3k5ZmV3akdIWFN3KzYraEozbnpHdEtOcjk1?=
 =?utf-8?Q?8NQvuzB+gwAzMVlykTOV3D27V?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e72ca263-5f1a-451e-a132-08db60337c4e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2023 10:57:24.9333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +f9wbeayhPysXhfFqhx9Z1E9yVv2TehRBxvm5VDRCmZifvVW6QpJSJbz8YpGIiLslQUwlgVjJ8gFc8NEiMzvTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6685
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 May 2023 10:57:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11696

On 29.05.23 11:29, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Mon, 2023-05-29 at 16:03 +0800, Su, Bao Cheng (DI FA CTR IPC CN
> PRC4) wrote:
>> On Fri, 2023-05-26 at 14:42 +0800, MOESSBAUER, Felix (T CED INW-CN)
>> wrote:
>>> On Wed, 2023-05-24 at 03:15 +0000, Su, Bao Cheng wrote:
>>>> Prepare for initramfs applications replying on TPM, such as
>>>> clevis
>>>> or
>>>                                      ^^^^^^^^
>>> I guess it should be relying --------|
>>
>> Yep, :)
>>
>>>
>>> Felix
>>>
>>>> systemd-cryptsetup
>>>>
>>>> Signed-off-by: Baocheng Su <baocheng.su@siemens.com>
>>>> ---
>>>>  .../initramfs-ms-ftpm-hook/files/ms-ftpm.hook | 36
>>>> ++++++++++++++++
>>>>  .../files/ms-ftpm.script                      | 43
>>>> +++++++++++++++++++
>>>>  .../initramfs-ms-ftpm-hook_0.1.bb             | 30 +++++++++++++
>>>>  3 files changed, 109 insertions(+)
>>>>  create mode 100644 recipes-initramfs/initramfs-ms-ftpm-
>>>> hook/files/ms-ftpm.hook
>>>>  create mode 100644 recipes-initramfs/initramfs-ms-ftpm-
>>>> hook/files/ms-ftpm.script
>>>>  create mode 100644 recipes-initramfs/initramfs-ms-ftpm-
>>>> hook/initramfs-ms-ftpm-hook_0.1.bb
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-
>>>> ftpm.hook b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-
>>>> ftpm.hook
>>>> new file mode 100644
>>>> index 0000000..998ae62
>>>> --- /dev/null
>>>> +++ b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-ftpm.hook
>>>> @@ -0,0 +1,36 @@
>>>> +#!/bin/sh
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +PREREQ=""
>>>> +prereqs()
>>>> +{
>>>> +    echo "$PREREQ"
>>>> +}
>>>> +case $1 in
>>>> +prereqs)
>>>> +    prereqs
>>>> +    exit 0
>>>> +    ;;
>>>> +esac
>>>> +
>>>> +. /usr/share/initramfs-tools/hook-functions
>>>> +
>>>> +hook_error() {
>>>> +    echo "(ERROR): $2" >&2
>>>> +    exit 1
>>>> +}
>>>> +
>>>> +# Just in case these modules are not built-in
>>>> +manual_add_modules tee
>>>> +manual_add_modules optee
>>>> +manual_add_modules tpm_ftpm_tee
>>>
>>> Are these modules available in a stock Debian kernel as well?
>>
>> Are you referring to the official arm64 kernel of Debian? Haven't
>> checked it yet. For amd64, however, I don't expect the optee &
>> tpm_ftpm_tee in the stock debian kernel.
> 
> Yes, I was referring to the stock debian kernels for arm64.
> If not, that should not be a problem here, but we should at least
> document it. I hope the CIP kernel provides these modules.
> 
>>
>> AMD also provides a TEE, so tpm_ftpm_tee may be possible on amd64.
>>
>>>
>>>> +
>>>> +copy_exec /usr/sbin/tee-supplicant || hook_error "/usr/sbin/tee-
>>>> supplicant not found"
>>>> diff --git a/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-
>>>> ftpm.script b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-
>>>> ftpm.script
>>>> new file mode 100644
>>>> index 0000000..c6ee2dd
>>>> --- /dev/null
>>>> +++ b/recipes-initramfs/initramfs-ms-ftpm-hook/files/ms-
>>>> ftpm.script
>>>> @@ -0,0 +1,43 @@
>>>> +#!/bin/sh
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#  Su Bao Cheng <baocheng.su@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +#
>>>> +PREREQ=""
>>>> +
>>>> +prereqs()
>>>> +{
>>>> +       echo "$PREREQ"
>>>> +}
>>>> +
>>>> +case $1 in
>>>> +# get pre-requisites
>>>> +prereqs)
>>>> +       prereqs
>>>> +       exit 0
>>>> +       ;;
>>>> +esac
>>>> +
>>>> +FTPM_DEV=/dev/tpmrm0
>>>> +
>>>> +. /scripts/functions
>>>> +
>>>> +/usr/sbin/tee-supplicant -d
>>>> +
>>>> +# The fTPM TA would take some time to be discovered as well as
>>>> the
>>>> tee-supplicant
>>>> +# 10 seconds should be enough
>>>> +wait_sec=10
>>>> +until test $wait_sec -eq 0 || test -c "${FTPM_DEV}" ; do
>>>> +       wait_sec=$((wait_sec-1))
>>>> +       sleep 1
>>>> +done
>>>> +
>>>> +if ! test -c "${FTPM_DEV}"; then
>>>> +    panic "Can't discover the fTPM device ${FTPM_DEV}!"
>>>> +fi
>>>> diff --git a/recipes-initramfs/initramfs-ms-ftpm-hook/initramfs-
>>>> ms-
>>>> ftpm-hook_0.1.bb b/recipes-initramfs/initramfs-ms-ftpm-
>>>> hook/initramfs-ms-ftpm-hook_0.1.bb
>>>> new file mode 100644
>>>> index 0000000..fece6ff
>>>> --- /dev/null
>>>> +++ b/recipes-initramfs/initramfs-ms-ftpm-hook/initramfs-ms-ftpm-
>>>> hook_0.1
>>>
>>> Where is this package actually used? I can't see that it is added
>>> to
>>> the initramfs recipe.
>>>
>>
>> It would be used in the downstream meta-iot2050, see
>> https://github.com/siemens/meta-iot2050/pull/442.
> 
> This is unfortunately not sufficient. We need a user in cip-core as
> well to make sure the package does not break over time.

You are invited to either add qemu support for RPMB or suggest a
physical reference target that is both upstream supported and comes with
eMMC/RPMB ;). Right now we have none of them unfortunately. Therefore,
we already merged edk2-standalonemm-rpmb without in-tree user.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


