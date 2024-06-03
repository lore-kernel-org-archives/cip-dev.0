Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DB6C25B75
	for <webhook@archiver.kernel.org>; Mon,  3 Jun 2024 08:28:46 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.46])
 by mx.groups.io with SMTP id smtpd.web10.78448.1717403320724818538
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Jun 2024 01:28:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SjGF8vVP;
 spf=pass (domain: siemens.com, ip: 40.107.8.46, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJXTXsgfBIMrP4EA5jHxAHPSrHy6Q8QrjTtelGsuPIMKKM7rMVtiwzFjAPcm5J78kYBDwhtiv4nNltrs5WCnDj1e9CXWPZV8jZkP+fByB2wjayryk4/XFvP2UwTqtF9b/BPYLH9w8NMwHGXJcgrqu1lElRwdaOtYCBYJktp40MDK7BOVneWhpTvD3A2JKaKS6m17P6l6U3f2MVU0Z49Vh7rY81eO93g32WMnoXXhKtM9+od1QavpEXqttFAQo2vSpqzLkYvoyafp2ERcmjYbiHdb0mX9lRGHFopD3EsdNTGd9pgf97wtFsuhgCkCdC+lxQk/6W/Yd46CqeM3bNcLkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5gQFVYA8EmaN6lJG2ni4tBebuY+rUGxvrScDoT+Hks=;
 b=ZF/HaH9wjEMvbgYuQJx1Mhrm3eqlTLc7hzxuMIcgBPMGOz7ZA5ezTEZhJoPJnuOLgaI9wzFkDWVEqCgB5L1kef3BcOJKR/njF6Zu2nXz/iBbd+wCa/mSK5Hpx/QDdQzjBY11tibT+jEfiWf33sCjVDfB+zaKUL7JtbOC6FpBKaLsrtpvppIUEYma9Cblgw/WjZssS2XfqokQlZMTdJACm+mvumDLowJ9vksh5xnUNmLXzK03zL9fAqCSZlJ15cWh8bMrNKXwGfDoZ4nFLnnHS2hnwjAQFzWPm0QzjXdlNL1dB5e58Sh+eTnAguKOqvekMrLFm3zZpEFnwELeLwEDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5gQFVYA8EmaN6lJG2ni4tBebuY+rUGxvrScDoT+Hks=;
 b=SjGF8vVPdqDlBV1LS4Tne/rfG2u2bmyQgr9F2tQVqcoOIL/nyJi/OsDDul8g2/UisxvcX6DXt7tg3PCHxSdnWl7uybP9VYn0S3z6/vlrSGbOSWkXSHL+kTCKCZutrLecZvNlghsm9lmlk8TSRcWdW5ixTBDxIogngf04kF0kWu5v+uqtlZ9yjeBKsS+Y9SA4Zxem7G9HKOAG+iKbjE899rXftJh6tNC6u8AjTwYh7+y8hUbJBwrQevUzovhpjvXgCR8a7TZrjfFs8Qjo9Btsu0vN6CjBKq8clAMpCJtfqQJgvCAxd22zDa5pBs7s26xawSLA5ZyKMULk+yKbKJ0p+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB7107.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Mon, 3 Jun
 2024 08:28:37 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 08:28:37 +0000
Message-ID: <1ca5451b-4929-406a-a985-570eb5562f34@siemens.com>
Date: Mon, 3 Jun 2024 10:28:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Siemens targets timing out?
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>,
 cip-dev@lists.cip-project.org, Claudius Heine <ch@denx.de>
Cc: Chris.Paterson2@renesas.com
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB11862A1D29648613FB34FD137B7F52@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <ZlDjWu5tzsNV4dqE@duo.ucw.cz>
 <OS0PR01MB6388374CDAD1095B2F98A9DD92F32@OS0PR01MB6388.jpnprd01.prod.outlook.com>
 <ZlhfLfL7fmsHShTx@duo.ucw.cz>
 <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <99f545b1-ee28-4a23-be6b-68999d8218c3@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::14) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB7107:EE_
X-MS-Office365-Filtering-Correlation-Id: b6166012-bfeb-41ce-283b-08dc83a72a1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OG5qTGlGc1oyRU9iVGc1bzNvUFU2WXBxeC9rRkZJS01VYi9KWmJOdUdXbVVF?=
 =?utf-8?B?R3ljd3ozK0NlUEJXMmZQOTlhdTh2eW8wT0NjNkxGa2pRSzlQaDdmdzh2amxO?=
 =?utf-8?B?Q0h0Q0lmRVFSZ0JUc1lBNlhOaXk5NnFHdmZ3TzNkUU1xN0diQnhjYmprbVE0?=
 =?utf-8?B?SHlCSTcxVkdXNUFTVjFJRFZRK2Z4NHE2NXF2VGpHSzZ2NmVpU0o0c00xRUow?=
 =?utf-8?B?cnFNODgrNmkxY0crZ3FGb2lId0dJeGZBMGVzdVUzNU10UHBQaVR3dndGZlFv?=
 =?utf-8?B?TUorUmpHMnJESkRBdUU4SFpvbXdZQ2gwOEpVRXFUK0JQdHRlWi8wTUdkbnVM?=
 =?utf-8?B?dTFySzdvU1dqa0Y0anY4QkxqREhRd1pWWUZBRFhMUnB2QzFnT2h2NzRpUjEy?=
 =?utf-8?B?aFRwNHMyNlI1U2pYZmVFQ2tIeUpab3h1YkJvc1hMNW1HVzhhdU1palVIb1ZQ?=
 =?utf-8?B?c2s2d3hPUnZiWFdLelV5NGJEcmVpQ3JCK3M3ZGVONkQ5eldPTUFUcHduWllI?=
 =?utf-8?B?NWZtTFNReDVCVXlJaXhzZGtFZm1scU43OXVFdDd6VUIySW5TMSs2Q25GWHFZ?=
 =?utf-8?B?VU9HUUVxQ29EQ0xaUEZrQjY2c1NyM0wyVXAweU93QUIvQ1RFR2F4VTFBZTVF?=
 =?utf-8?B?ajFINDllR25xaGhWcmhXRnFNNVlEckorTFpDT2E5RnlaQnU5QmJvcFkrQkU3?=
 =?utf-8?B?SitITy9QUjVmU3I3MGp2MFlrTlUrRlh4L1NlT2NzMldzWGhOdUd0UFgzeUo4?=
 =?utf-8?B?MzZqdFcyUzdzcEJJOWhLOEdpWEZPZEFQbStFUXV0MTMvYVJGdjRGTUJhY1hz?=
 =?utf-8?B?VWRmU0VNWXd6T1RSZmhMR3c5S0loNUlzWkdiaDhFOFNQQkFGWEFmd0RvaHpJ?=
 =?utf-8?B?bVZsbTMrQzIrSTUzY0RyMEtBVjFpKzZXaDFyNUZLQTRVbWw1OVZoR05YZlZE?=
 =?utf-8?B?d0RROGhtdTBtbGlmZXBtUWQ1NEY5WEx4cFFYU2d6N0xLUENZTWhmNEJWRysx?=
 =?utf-8?B?bGtTamZHNzQyMWxmMVQxMjZJNmc4ZHoxM1FKUktHMEVqZ3g1YW9PckxSTk92?=
 =?utf-8?B?by9kQlFkUFg5YkJ1ak01V1hRMGFPaEI5eHd3Vkc2andVZUJNSlMrbmlOT2Jv?=
 =?utf-8?B?azlvdjBrMDBiSFVxNGNwM2UxOTYwOElLd0pVTGIzR2tpSFdWTlJNR0dwOFQ4?=
 =?utf-8?B?a2s0NU41MnZYQ1dGMkZ5SXE2OEpOc2tTdVEveGJidFE3bU5xNlQrZy9uMG44?=
 =?utf-8?B?RzN2ZTI0d2RxWjlCaU5abTRuSDg3TjFOVUNMQUtWblhLR3RmbzNPTkJQY1Bk?=
 =?utf-8?B?K000ajFzYmFQbXhiMzE4bjNiMDNyN2F0MTVHSUhIVVpDOFRKMVdqcE1IOTZG?=
 =?utf-8?B?ckdTbm5Ba21CNlZoa3ZCS2dPZzFuM0toY2RXUHk3ZTB2VUEyc1pUNkpkTzJs?=
 =?utf-8?B?c29ldmMzVmdHVW9yaUo4VXByOGZkT3cycHQxTllWcVJUV3FSb3p0YmZtM0FI?=
 =?utf-8?B?Ulh2WmZ3UU5ZdE9iTHo3aGYwVGRDcHpUNlo1RmFTYkJyS3FTd1BRNDdmalp0?=
 =?utf-8?B?QUtCN1QveWxIdHN3S0MxODdXWktKYXpTUVAva05rT2h0V2o0Ky91VnMyUFc0?=
 =?utf-8?B?WXhldit5UkhRV0l6ZHBzcXZEL0JzMUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnJVbjdLdUF5SGEzd2ovOTN2TTlEZ3NObC9GQjk4OVQxdTBYR1V0cXZzTVJK?=
 =?utf-8?B?bUlqNzdEVWhVT3lJSTlVbmhPcUgvRzNZck1DVTNLcmlVcTNsNFdqYXg4cjRF?=
 =?utf-8?B?Rk5CNmptQzNoa2Z5Tk9YMFQyek1zOWhMT2lsVnVCbllEdnRaYzFRZzBDWXF3?=
 =?utf-8?B?Y2xucWF3M2xSQU9MY1lHY3RCa2JPZ0JmTi9MM0JnNXpNcUFvTHp4cmtLMXEr?=
 =?utf-8?B?UTVYZWZPZjR5dWp1YjhwaTlPY0d4RllZUVh4UkF5OGxtcGNOM2tmV0M0aEdV?=
 =?utf-8?B?L2ZHdHNCV1VPbDhEY0hGa3I4MEdEYU1nTnpvRmE4Z0ZiWEVYclNXdFFUNi9u?=
 =?utf-8?B?OVNVeWNMTk1GODJQZExqbkZGb0lXdVFPZFFnRDZnSnNJTlVPSWZreEJZNWhZ?=
 =?utf-8?B?RDh6ZnJWbXdNbUt6Z0lWQVNwVGV5T1oyTjlIbzB0Sk13RForWWNBc2UrYms5?=
 =?utf-8?B?VGg0Vzk1Wm1ld2ttN2xoMmZSNVFGZW9JY1J4RTV4eHh2UDZTbUtHSzArbFho?=
 =?utf-8?B?QjdENjRRUlNMQjVBdGhnMFViRzRTTzNkeU41YTZYTENmUzdjREFmaWxtcStZ?=
 =?utf-8?B?Nnk0elk3RFBQS0lkaFB6QkhEYVprYlBGQWlJWGk4RHJwTDQrN1RvN1VoSlNq?=
 =?utf-8?B?QVdpRFBsalAzMjFGSnR6K2s0RVFHRlJzM29MRlR6c1pncXpsU3MxdzFjNjBI?=
 =?utf-8?B?SzRmYjBkWFhXN3F3S0dJV2tZb2FJeGR4RFpDR00wV1pRTlF3dERwUVJubGt1?=
 =?utf-8?B?RTlvcmFPSEtXVGlndWIwQkE2b2JRa1RiZFZTNE02MFAwVWthcXMxUDA2cWcw?=
 =?utf-8?B?VzUwMTdGOXFBR2NwckV6Z29JT1BISXlXZGxwemZheUJkZjdXVDhrb0E1eEFr?=
 =?utf-8?B?RVk3a1Joc3JEL282RGJ4bmRKcCttZHJ6cHhiTjFxcGduam83TVdicU8weC9T?=
 =?utf-8?B?SDZJMms0c3VGSXhnci83UjdQRU9zWVNzbmhRcjdsZjBoTm85RjB5dEJsZW1t?=
 =?utf-8?B?SzlHdlR5aFBVc004OEVIOWxHb3VjTWpsT2hzVEgyMnVseDZid3BkNjZ2cmJY?=
 =?utf-8?B?SkpDbDBjRWNKcHF1eFVvYU9UeVYxVmYxdTVBSVVoTE43ZlNGMWZOV2hIRXNo?=
 =?utf-8?B?Y0srQ3FxRmpvTDlLRkpMd1V2Y2h1V1p4alJmeXFRcDVQUFhqbHk3aHlvdHdr?=
 =?utf-8?B?c3J4V3RmbDR4TENSSVlsRUVqRHZxMjJ0aDFSUmNpNUxlUzdTR1R5VXFtZUEy?=
 =?utf-8?B?em1hYlpHcWNpR1NvWWdVdy9Na1Y4TVhwUytjVXBLQzcvNVlTR0hoUGlqVVA4?=
 =?utf-8?B?dmhjRmNxc00xbFJkY1Z0M1FJei8zd2xST212aEJMejlmb09iUW5sSzBId0xC?=
 =?utf-8?B?MVRwaVNOQnBpYkVRU3ZrYmlLUTN3WitrY210NlFMSmtDUFcvYnQ3R1A5blZH?=
 =?utf-8?B?WVNGcUY1eFhYVDl1TUw4cTlxM3dWMFBPdlJLWjU0T0RaZGx3aGlkKzRyd3pr?=
 =?utf-8?B?WklNZ3AxWWhjbnlzejJ1clB2d2NKQUY0c0tKYTZZWGZvYlFvcmxuVFYxNFFE?=
 =?utf-8?B?TWhpd0xKY0l3V2xHalYzN0tBMTJWbFlEQXN2VmRpMFNjLzFjbFBzN3BWUGhi?=
 =?utf-8?B?WStqTlQxOEdhbFlkNHkva012MUY1cWV4S1Y3akErb3MvdmllbmN2SlcvbzAw?=
 =?utf-8?B?Q3RLSGxCeFBwd1ZwMlN1MVB3YWxKRDQvRTRiWUxmWlRhVjFJeFBNTlFnSllO?=
 =?utf-8?B?QWJ0ejBqNitwYWRRL2pHZlFZb24xNXJQdEQ0RTRUQlpGbjRtbE56d21iVHlt?=
 =?utf-8?B?LzdvMkluNVB6OHZyQUc1ZysyeXZoekdDRllCaXZQWDlEYU5ySkVZM3BGcEN6?=
 =?utf-8?B?aHIvNG9rS2U2OXBJdW5sMFd3RzJQOWFIVFVnb0Y5YTBBVmhvWmgrL0h1aHJT?=
 =?utf-8?B?Q0xLR1U2NTF6RUlPZlBCbkRWcHVFRUJHTHk0RUZWb0FxUWFob2U4aDRDaGlX?=
 =?utf-8?B?bWlJb3FGVXpIaU9XQlk3K2ZlNnJxSDR3bjV5ZURBRXJqVEliTHNxa3pKTk9y?=
 =?utf-8?B?eGZkWmZpbUpiaHl1ejlCRGxkT3FFamFmdGRtREJBMjh0cWRpbklXZHdaU1I4?=
 =?utf-8?B?NnBBeGJKdE5sUTNybm5oeGZZRzJSa2FYbHFSR3ZzTGFYVm5FaVpMc2IvVEly?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6166012-bfeb-41ce-283b-08dc83a72a1b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 08:28:37.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E6ZaKNsVPTCYB0/VIS1ODQYNIQ4tZUhio6hk8TGQqE1hZKclMcIHTHPMWZP/3OQ75AYyg7qjIy3f+cflBNTKO6mTp6JALVVUC0aGpblfpCE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7107
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Jun 2024 08:28:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16085

Our Lab is still not launched, the lab of denx is offline.

https://lava.ciplatform.org/scheduler/worker/lab-cip-denx


Best regards
Quirin	

On 6/3/24 6:46 AM, Jan Kiszka wrote:
> On 30.05.24 13:12, Pavel Machek wrote:
>> Hi!
>>
>> I'm trying to test Renesas Ethernet changes, but Siemens targets cause
>> timeouts. Can anyone take a look?
>>
>> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1310801626
>>
> 
> I thought our lab was still offline (internal IT...) and only about to
> be relaunched. Quirin?
> 
> Jan
> 

