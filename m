Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.5])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6099.1792567759433830988
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Oct 2026 00:29:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BPZFV/sv;
 spf=pass (domain: siemens.com, ip: 52.101.69.5, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MFQZo/3D93PoaQAoeonDh1xUq7vBhI1ehOhPCwa3wwpSfP9D3dENiHl4PggauUZqYT31FVDJIm8sKbwFDJ5BTlRze+XFvTCtd7PD+z9qr6xg5Acx9azSOA4DicTF0RAlEE20ikh9nxonRkJIeOOaYTA+cBrEv/iANmKdAgi9qAdQy55PTZlNav+hbJIlVW1eioG02zd5To2VWIGvY2JFqfqCsx0UMU/YvR6NjXiaKyd2xGpuiIVQCrUqMlAnt50oSmznBrFG6y3vnd6L6ZrWIQl3bsZ0+lucHm6sbWOAyWrEU6Gy9iy3WWM8b1xmR1/btWdPFNXrnwyuX3Vrip4qYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AM8Eerovkboadsg8o+8DZW7U8sNV7I4Rpp5Taz87gQU=;
 b=h5cxhYrRGPyL4sHgVDu7Z843bA3bqKIVI9SIcON61sq6GYUXPA8HLOFoLyYZT/oS6cDbwHGRjvKC5nQLlQ/iwr+hdxyokXI3PgRS1YGspFymaHDYhOgwof+PP6JltAf3oYGDRX5scX/9u+LD1CYjTqbauCwX/wUeBsI2K0fYKOr42MDvBE3cEqOxzvW39bmbdriB1yQtebAxAdpCy0JM3NqYrwmbbw5lU22z2EElxVAtfVueDZKcJ3kOrDs0rDwoUgEUi+tC8pfT0RAEL8+X+B8yQ29joLAZAhIGkGpanv2TJT7f6zsRHsJ/N89cLWvUgFZGk8gw9m3ypnLWT4Sn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM8Eerovkboadsg8o+8DZW7U8sNV7I4Rpp5Taz87gQU=;
 b=BPZFV/svWVlubLABDgsh2+YkHOi4aTtt/yCCSglFFTO7lmpq0cBWADG/+OjArETllPNU7lGmivuvC59uACgiqYnsNkijalnbAKfgQYf94CPuGSbT32lP2WokW+993vB8fhoa4CynT1l1CHodRQE43CjZPfwm81Q8FVvRk9DZsVom23CtFB8KPvKH4X3WoNyg2v1GrFDybEcmOi6Qm8Y+ENKmbYszBJbVxVsBfOBjikJ+zHcgOTombK3dana3aE//iud/N4RlBse6m2lNm/bVytzEssToKc2AYF9QaKZKCPEZ3wYJhxQW/RGZVZdUtJf4Xg7GMZKPVFHeXL9iIXd+1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB5306.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:338::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 07:29:14 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0569.000; Wed, 21 Oct 2026
 07:29:14 +0000
Message-ID: <d7cfb3ba-635c-401d-9eed-bb2581c342aa@siemens.com>
Date: Wed, 21 Oct 2026 09:29:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 0/2] Split swupdate signing and
 verification configuration
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
References: <20261020122932.470811-1-alexander.heinisch@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20261020122932.470811-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0264.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::19) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d6b289-676b-4e14-8ef5-08df2f4501fc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|4022899009|366016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|55112099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9TjrEyhtxJK1s3R74P8GlNH6KIxZTRIm/G1zO4wsr8BSAsSR1ubbfKCq3QD7y6yn/3XMMysoOxalxZz2n9FwTCiTN1fq//mLhcINwURFsJlL/5Q1kgBE9vmJmusrKcQE6pu63cLoR1++019yNIHbK8IK5bcDhXQU45dOLn5AMqInemWQRcLDdkyRq+hERjcTRcbPwsDn7+WVW6R/8tmYfve7jBsVHyXYAGx0drH/qTb3vtZF1FxfRy0QZU/PkZYZoTbPSXSXANtPLEhSV0jIZXIVFpgFYyB6qGr9iigqN1sMFFEqwrFnMkYjQTRN0BvmskU7NHeKxJtWRGrSGDs992x+l7QD7tZ5r4uZ6LhLZBO8hiOlErK28Yz4cYbDYoYCA3Y2PcrR4QJD9V/6vGArbS64Z9TYS5ciWyQDXzuuBVvcqm9yJSkLDMym5nxkMPYXP84Rr7Rgj6kqCXr2mULRWihgHVWFIW+2WNWPwsMY1sMv5PdjxcmwzP7GS7nm88nyofpuKuRw90h0TTFt7M8StJBvbibMm4ga08sbe6MPbh0c8VjqsoQyb81CW1f1E9igwOVC109bKUOpZFC8X0O8J+dli8chNzzfVWi/Pc237/rqDts4HNA1wCMkCWP1crC9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(4022899009)(366016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(55112099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzVDZnJtZ0s0VE13TzRjSlpvS25yazF1TEtBRStURVlnRXJPYnBpVG1SbFZQ?=
 =?utf-8?B?VDN4Q2ZET0tISUpoWnJKYVBUM2wvVVFHdUszNTNwTjFzSTY5Z0NsOU1XbVdi?=
 =?utf-8?B?RUhBTUJ5R3NuQU4xUHN6Szlhbk5tUWNyNU9WSlhWV0JPSXR5RVFvWDRhSEpW?=
 =?utf-8?B?UngzTHlSck1IdTlCWWwzd1A5SkV2NnNvbjNpaUdudHdzNnJVUGszNFQxQ25a?=
 =?utf-8?B?YWwwRENNTlMySEY5VVVKZWJtYmpnNEMzQ1VVNXpMV0laT3VGdzIyNGxKdVVC?=
 =?utf-8?B?RDNFU1VLeUtONnBTdkVmZWI0WnZkVU5oanlsVGJ5dTVMa2NQYzBoT3Byc1Mw?=
 =?utf-8?B?YWlJc0pTSWlGbUVldzBuMXJGQTZPcUJ6SDVYbnB3eENKUGpYazlxdmRSMXRZ?=
 =?utf-8?B?bDBzR2hGWGVNSkkwS2trNnFUTnlUclhCbk52TUFkQzRXMDY3OU02Q2ZwNSty?=
 =?utf-8?B?VE44Zi9zamxLRFRRV1lmSjRlU0p6SW1nUzN5N3A2WGFZbXRTRzBaSkxka29G?=
 =?utf-8?B?Q1AwekNCYkV5WTQ4bmphZ2QxNEFtYXJPOFdLRG40MkpYcG4xNWkzZ0tXT09s?=
 =?utf-8?B?Vk9OaUlxMDlIdzB0aWE1Nnh0SXYzUXZObm1QeE1sTGREbGVTQ2tuNlZlUHh1?=
 =?utf-8?B?RE13bTVFWFpLMC9lN1lVRFMyRzdMcGM2eWNCUmpQRld3bmJxUVJRN1hVajJM?=
 =?utf-8?B?b211Lzk3cDA3Ukhza1EzWDlYS3lMOWNnRmFDZm9XWWhwYkdHZitySkFGeEdD?=
 =?utf-8?B?eHFrdVpHdTVsejNIQm4yQzlWWVlsa2JzVHV6OXpmMm83YVZ0VjRKZndRb3Mw?=
 =?utf-8?B?L1BtcmlwL0FjdHdSd0RVdzVzcStLb3pvUHZtZi83U29XNHFmY1o2bmFIcVZi?=
 =?utf-8?B?U3VlSG9TaGVnR2VMbTRLdFNaZkg2RTdWalJvckg4MWZEeHpOVW9kRzRGWGZT?=
 =?utf-8?B?NTcxUjg4eUJPV0wvSG9NN1UzNWhMblZiY1d3UThPNmtMQWxSQVYvUnc4YVBa?=
 =?utf-8?B?NjIxVXQvc2kxNEZDUE9CRW9kVVZvaE5zUHlUWFZPQmJjNTJoYUxnbzRObURG?=
 =?utf-8?B?ZWFlKzVIVXVJbGYyd2R6TmpGcXFUUlBZaU0zZzdlOFVpSGNweUhEb01jOTFo?=
 =?utf-8?B?eHVaVkg5RWU4M01FQzREd3FITUM0VHJtRk1JRENTMHlpWFl1VDhDUTkyNnM5?=
 =?utf-8?B?UldXMUdudG9NN0VTMmJ5QVVPMjVNalRuNjd4bGtCQzZhWWROZmdSMG1Ic2Qy?=
 =?utf-8?B?dGhpQ0dOY3ZaU1dTbW9YZ1ZOOXNIajgwdWZLT1EvUlB5ODEvYmFhbXFCSnd4?=
 =?utf-8?B?aGsyQ1dhZ3dZZTB5Z1Q2RkhTbXRidzlPQW9pVkhNRzdRcGx4MDhnSmczUUw0?=
 =?utf-8?B?QnNMRk5RbklDbXBWT0JyZnAvMFRGZU1TdG9kQnNUdENCVk9INnkra2lqT2xq?=
 =?utf-8?B?MVI2SDNGNlhGSUxwWFRyMTFFczAzRFJCNXphVks0ampoUTZ6TFMyMUsyUmo0?=
 =?utf-8?B?TG83Q0hwbnpyblhXVTRuR2RpRFE5V3daOFl4d01EdkNoUCtRd1BqRjNTck9p?=
 =?utf-8?B?WVdNSnBsR1oxR0N4U0pYZ0w0cmxra25CUUdTZWMyN3preXNUTlRSVkFtYzM0?=
 =?utf-8?B?YWs3b2VpQ3RVNjEwRDYrNFZFaGk2bkpWRmFweUZzYzIwelU5c1lRODF1T0J1?=
 =?utf-8?B?anhlWURFY0JaNStjaWFLaUVSNXB0UjBYQkVuNHVEbzEvd1RCaHZTekI2aHVn?=
 =?utf-8?B?NEoyVjN4Zml3b1VTdXl4WVNJZXlyRStoWlplanU1aVdFUW1wNHNJKzlEZXEy?=
 =?utf-8?B?SHlUWGRrUk1Hek5jYXZTNWxXMTRVcFBNWDcrQmRHM1JPbEpyN1ZuQ1I5YkRv?=
 =?utf-8?B?TzI4RnZTdUx1QjFQdXBIeGdXODV4U08rWHVteC9waGdTSm5GVDFyRkw2cW9R?=
 =?utf-8?B?aDl0SkV3UXJKQUdDNWRET3BHdHJEQmF5SlY1eHpqV2RIMU5SMWF3RjYxOTdn?=
 =?utf-8?B?VjdCckpBWVFXZ2lDb05FV0tONTJ3REU5TVBoSWlLSm8yamdTYXNJQXZyRG9L?=
 =?utf-8?B?OUs5alBRcVhPVkQxUnluRnlWaGUyelA2TlVKUDBXQi8vQ0xHRXNMVEpIY091?=
 =?utf-8?B?cG9KeXRIR0k2TCt3UTNvenhwZmhPRUJJbUk3bGR0c1pKRkZpb3RjZU13bFJL?=
 =?utf-8?B?dUlyMlU0alBQeENzUTZqZGNLUE5YWGJxQ2dTR0lsZWF1d1BucEY1dzJMc2Vn?=
 =?utf-8?B?N1BoUk9jNlNKTWNOR2JqS3VQOXB3Tk1UeXhFenBNbHN2QmZlYS9wU1MzZ1dh?=
 =?utf-8?B?eFZMZ3RvajlCUkk3Z2xvdnNzOWpnbHVzVFBUbFRIM2w0TngzV0JpeTMzTkdO?=
 =?utf-8?Q?FSP1fBy2dkXfW5+k=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d6b289-676b-4e14-8ef5-08df2f4501fc
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 07:29:14.4887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rN2AoQcLaC34Hm8U32qRGKyJTmwVqRR/NwH1Sx/3yiBH4ORL5qFnz7dmIMmUx7Mvy5EDICWLycZq8auDXtHPmJ37RYkUTBwVSvNuw7axYj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5306
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 21 Oct 2026 07:29:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24504



On 10/20/26 2:29 PM, Heinisch, Alexander via lists.cip-project.org wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> This allows downstreams to sign artifacts out of tree (excluding
> signing done by swu-IMAGER) while still enforcing signature
> verification at runtime.
> 
> The patchset splits SWU_SIGNED into separate configuration switches
> for signing and verification that allows for independent control of each,
> while keeping the default behavior consistent with the previous SWU_SIGNED
> setting.
> 

Looks good to me.

The out of build signing sounds painful as you need to extract and 
rebuild the swu, but that is another discussion.

Quirin

> Alexander Heinisch (2):
>    swupdate: Separate config switches for swu signing and verifiction
>    docs: Removed obsolete IMAGE_INSTALL from README.swupdate.md
> 
>   classes-recipe/swupdate.bbclass    |  3 ++-
>   doc/README.swupdate.md             |  1 -
>   recipes-core/images/swupdate.inc   | 12 +++++++-----
>   recipes-core/swupdate/swupdate.inc |  3 ++-
>   4 files changed, 11 insertions(+), 8 deletions(-)
> 
> 
> 

> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#24498): https://lists.cip-project.org/g/cip-dev/message/24498
> Mute This Topic: https://lists.cip-project.org/mt/121847885/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

