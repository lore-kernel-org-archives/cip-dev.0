Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C342EC531D0
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 08:06:44 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.4])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.26328.1785139603928076948
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 01:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oxmQTlXA;
 spf=pass (domain: siemens.com, ip: 52.101.65.4, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dDL+JeXWHUlLdG5KeB/BoMUGz/RnxdLa6aRnAd+IF9Ko6PAfHgA5NPchirlnrvhCjrX43dDIr9hKjEFmakCTx2e0dgbblQhviyOTjEA1p9YNfUvkeQfIZRaP4g76xmMgqWEtqAeVxqdbBsm9Kbma0t9E1xT5dd+8NlQG9dUCDirx7jMTM9YvznvcnLkFkijxW5VVb9GrNIp9kx72T1YYqltkbudvf9BnbG/Q8ylYD9Mpue/MqmdNaCiQj1UuTPQeQEPcTfaSg2N04/ryk0/BIXy/FAgXMKtDIbVKtSXoz3zTfUP2zoQQ/Aji/Zac8jmQocsoEIM73d11OTRq1FlgJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ln6FNDd8PiW5FGZuE/Gh4MZlRlgUAWpC2CIm4f2IDKY=;
 b=mdtV25gpIHr/sc74TeHSVzviOVNXdSuDWosRWBA9+nXg4SljEt8FDDqXkLI1h+TQus4zJ152OLKaFNaWYxhLBI7/7Xch5uM9a2y+07TN0UkkhB4pnGTaY2ppgKqr8SKmHUj01Rhmz2f2KheHEjkGnZTb9HJy8mbFTqfFrBnsbzw8HKEN3vZ3PcI1zUStaomFwKueFWrUzLW59awPivD/BTn89jEJw6HUDCA5OEjnHGvpHqPmQ09CkRNOoCD/3yL+LZnxDA69HOWmS6yPp7rnUGr/fzBv+Z1WDjuVXpaqMN1sq9E+1kxR077+8LihsSgnR4+GWVALkShtKl1gjVZTVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ln6FNDd8PiW5FGZuE/Gh4MZlRlgUAWpC2CIm4f2IDKY=;
 b=oxmQTlXAHYjNq/0JsZ3ZSMpJvaZder7/CmDwkXSfVPkubCYHNOCJA+h/GJqOGINfF78LoadSigLZGRfDCgZq/xMNY6A12xJV3O+EqdQ0yCdV8j/ZHcmfaljrpx+VVFStl/40z7i/qKb4WUZLK49j5vwbD2W8W5CTmG/39v4QBcHW8vinIYckjqcOgN/MD7C3vDbGDjwXz8T7//jNCoa+3uhnwCOJJ3uJlQuSTpwBRmRMsZC7j35TS/jNRO/7oufnuCmrqBr9uWwNpCHykpCOaOyuY0mSaz2CBJZPKHeqnxOgeVE9xNXOegMPP2uDPwKup1z7bMT+w5U3psAAqyan1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GVXPR10MB5934.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Mon, 27 Jul
 2026 08:06:38 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 08:06:38 +0000
Message-ID: <9daedbba-44e8-4cfe-9f0b-34f087b87d25@siemens.com>
Date: Mon, 27 Jul 2026 10:06:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC cip-dev][isar-cip-core][PATCH 0/4] switch to rootless build
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 felix.moessbauer@siemens.com
References: <20260724105116.3575045-1-Quirin.Gylstorff@siemens.com>
 <d307dc69-ab0b-42e1-9e48-f78cae03bdfd@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <d307dc69-ab0b-42e1-9e48-f78cae03bdfd@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0164.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36c::7) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GVXPR10MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcd2115-f549-409d-7e14-08deebb5fbd9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|55112099003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	cHiOF1UFlAKuc10idkQei4LYq+5MoGQ9O5kL1QnFSxACP4HK411edLXBq9XkMcEVswj0IujPbtDD1E5Tc/gF18kFbi+fuEisfpi6cZPZnkPFUMvMTTj3Rz7CozdGOgvA56GsuKWu+EtAFn+Rjz+dvOOUPfBGpmbLRu0loMnu5bn4MaZ9PGGl8elfkJzBEh9a2ppO4Hb/OcM1kcFRMFfPH6lnFo9C1wMM2UHMXF4KwH7CTFfjh0Hs94BiFUIVlS0mcrtV+8YWhPt3zruJ9Hr6kHjcDqxJiwn/V/n441926BQGrY7+zRdiTWPln2kGmyPkob8RdLkbEmLo/mKsyTt7Xb6gnhb3Ime4O1rkUxiJIgAIcetEWU3KJCQvd+PjSo1lAr7yfA7xUzp/kHJh6Avf9oo9Lg4K7Fthybhqn7FYbwKa+lmyOOqg7uOcAD7QpDIPDj8gx+XBePZI0We8VIyFbk7iqPEYDBjddBIz9ApTt3ah8YKrW5a75BhbmwaJylQbrghTaVhdtueMQayYMEcJxAFmcdQruYW3TaCNAE9ce2MQhZ8rbEa0t87hsP90+dKQ9i+AOmT7rXbWc9hKww7UDG7z55CLCwa1a1kRGHK3HlIs+WE59RVNe/sZxFld8K6dM7gA0/2j45M+0mSp6YoTn8KXMY94li9I6xI98SVz0wo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(55112099003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?czcraDEwZ0F5K1RVUEJLWEZ3TkxobVJ3cTltRGpFeDBJTVZBckh4RmtFNG9r?=
 =?utf-8?B?K2hxZDJ1d3k4eDkzL2NrT3krTWlCSml5MDR3TXlOMXlTNnpLK2ZDblNpbmtT?=
 =?utf-8?B?UTFuMXJNU2RjU2FxeFJ1NnptNmNBWThic0l3b0FTL3ZhQ1lIL1Y1QjJmSTBX?=
 =?utf-8?B?dm90VGhTUk8wV2NVQnBMNWNUU0Q5TVhTRVVMSkNiRkZxMlR6aFBVelFOZEhz?=
 =?utf-8?B?RlFGa0c3RmlGMDAwZkZmWHFYMittN3o1ampweEhVcENSeUZPS25Ja0RuYVNm?=
 =?utf-8?B?YWcwZDdDVmgwVnNhUTdoc3pnVHRRQ0JZQW9FbWNEYWhHd3hSM3k2N2xRWUtn?=
 =?utf-8?B?Y1YwNE9NU0ZwRjVwNSs1TUg2M2Z1Q1pqd2VnSVFmUDR0dkM0Ylo2ZE5RZ1hq?=
 =?utf-8?B?Um9XRERicGpNSEVLUFE2UERad2o1N2IxM1QrdHJlZTVpa3pDQVlqK0oyazlm?=
 =?utf-8?B?d2F0V2RIUHJ2a0JBenAxMkFNbVV2OW10Y2h0ME1IUWozc0RVamVwZmlZeXVX?=
 =?utf-8?B?Z2lNbHpJcWZ6eVJtYUI2Uk5lUmt2NEl5eGZsa0xMSldZM2txNHUvQmU1UjJm?=
 =?utf-8?B?d20yUUJ5QXZlSmpzTlhSeUVYUU5KcWx0SHUvN3hybHQ1My9GT2luVWhOY2R6?=
 =?utf-8?B?c0tMNnRpbjJWSHd6TENjdngrNlVBdTluRDhqeEErM3RBZGtOS3J3Umx0UzBn?=
 =?utf-8?B?N1ZHVWpTYzdid3p1aFM1S0dmTUcyUmVzWlozbTVKcHM4Y3BvWGdud2I5T0N1?=
 =?utf-8?B?bkdITUFxbUFWb1cxUjZVSjJWcWFDT2VtQXE3V3EyWkN6M09kdnl2emQ2SFRO?=
 =?utf-8?B?Y1l4SEU1NVdXcS9CQXFSZUQzMEJkSy91RGMwaldET1R4QXRLYnZTQm1wRWh2?=
 =?utf-8?B?MGZ5Uk5zMWxST2UyN2lIUnFLbjZOSU4rNkVtQlgrQ0FSMFhoNGVLTlFjRFhK?=
 =?utf-8?B?M2xyVWJWSTI0dHJQSnlIU0VHeFVObFhGT3JTNDdyajc5S0lTZzZsNVFIODdB?=
 =?utf-8?B?UjN3OHo3bi9lUnRncHp2QnM3RTJOaVJ5alFIc09maXNUbVNpQjRnOE4yeEx4?=
 =?utf-8?B?eGFhUUI3bVZiMlJEQjVUd2xPcWxrbkpQSlB1dFlyYlFOOTBXUXk4SmJoMTFv?=
 =?utf-8?B?SnpXVzV2QmFGM3BQbm5paW96eFAzRzlKQ2RrR1pqWnM1eTEzSnNJUGdzSW92?=
 =?utf-8?B?TkJPbDFEZndyMlpZZVRFN1ZOeEdKbW8xazZORUlXbnBFQ2xKY1I2VHV5NUI4?=
 =?utf-8?B?cEhRUUNnMklBc1V4Z3g2YTRsQnVwWGNDT2Jia2FmMEJIRjZsRXBYWE1tdGhI?=
 =?utf-8?B?WmR1MDNVRDVLNEhXeklCSStSaEJGMGxLR3NnNGk0aFMxZ1dJd1d2MCtUUjRz?=
 =?utf-8?B?amR0NVVkV3QrRUEvMUdCL1BQQjlJdzdIQ05uL2YwVzBXa2NmUERaaGhSODhM?=
 =?utf-8?B?dTZickJTS3RoMkVBOXhhTERoK1pIbjQ4bENtY200WXRkMGNITnVXNzE3SVox?=
 =?utf-8?B?aTVKZURkVS94NFNqdjAwWHZtNlhHRlVrQThXeCsrbUJGOVJRNFBjQm1DMGNj?=
 =?utf-8?B?Wis2ay9EYTFDTWJEblVIUVBqaGJyL2NPV2tvTVh6TkxFUDlmUG15a0NGYitF?=
 =?utf-8?B?TGI0ejgvRTg3UDBscm42bldLVlNKSWwvL0J5eUJ6RFdsSDErM1hwOHJNZ2ht?=
 =?utf-8?B?WVExeUUxMzVVZGJIcVhoSUNJQ2lNTkdFTkloN2JCbGdVdTQ3bEJlcHBUZ2Vx?=
 =?utf-8?B?REZmZWQvTzhWMEdWclcvanhPS29xTmJYcFdWT3NGT2tzcDJ3a01DZmppV2NZ?=
 =?utf-8?B?SC9sRnQwV1oyNGRoYnNUTVZsSExqNzFNb1k3Qjd1dVpBOEFkWnFDKzduWVJn?=
 =?utf-8?B?WFdxT1hRYVRIa2JYazZ0Q2ovL2tkLzFCVnNoWjV0Y3ZJTEVFUjMrTUlXdllK?=
 =?utf-8?B?cUFScHpZVk9sUUdnWlVsNytMdVE5cTROb1k4dHFYNVRIK3AyUVpKYnBUYXVE?=
 =?utf-8?B?Q1dtQTk5U0w0VUpVL2l2cEZrbWpKb2thUXFVK2xka2pSQXZmUW83SFVhTmN5?=
 =?utf-8?B?bEtqTW9WTStMRG1qWTFMSGFyUEpaWDUvMFY2OU85Ny9tWmVBN3BLaXRuNVVD?=
 =?utf-8?B?dmlaWnI5THZnQ1dKemwzVVo2RnEzTVpkUU5PUlRwNU52VDlHL2lMMEpYQkNj?=
 =?utf-8?B?UXBWUGU5aEtXWjIzNnNXWWFqWGF6UU8zMHMwUzY3dmdMTmpWNUpMYW43eXZQ?=
 =?utf-8?B?ejlZdVdEay8vd252TDhXR082V1AvVTI0amQxbTFSNFVTYmMxYlNNT3ZJNGFi?=
 =?utf-8?B?UEtObTJPTFRhQkdWRGRUQjFrVmNqM29LZS9uL0d4ZnoxR05nSWZnS3N2Vi80?=
 =?utf-8?Q?2g06X/wmaQyvRDw8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcd2115-f549-409d-7e14-08deebb5fbd9
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 08:06:38.1071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4m+VgnfhHzqbgIupNzlF8M4lJ63V9WapNZbwFmwHeqEw+60IjMchbMK+XaHf8w1uuB77bUwrUQUnfAMF5hTbXDIDHO3vPtyGlg5r4kSbus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5934
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 08:06:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23755



On 7/27/26 8:13 AM, Jan Kiszka wrote:
> On 24.07.26 12:51, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This patchset contains the necessary changes to switch
>> isar-cip-core to the new rootless build.
>>
>> This has an impact on downstream as the classes need the new
>> rootless changes. So this is no longer compatible with isar before
>> the rootless merge.
> 
> But this remains opt-in for downstream, except for updating Isar to a
> compatible revision. That alone is not new to isar-cip-core. However,
> this change also demands kas to be very recent. That is a not so often
> the case. But we need to do this step at some point, and we are still
> early enough in the release of the next version to move forward, I would
> say.
> 
>>
>> The patchset is build with the following pipeline
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/2702946001
> 
> And that means our cluster is recent enough to host this. Downstream may
> not yet, maybe worth to point out in the README.md as well (if Isar has
> some info on that, just link there).

I have not seen anything in Isar. Has it even an impact on existing 
builds with priviledged containers?

Quirin

> 
> Jan
> 


