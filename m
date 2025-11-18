Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BDCED603
	for <webhook@archiver.kernel.org>; Tue, 18 Nov 2025 10:42:59 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9543.1763462560542655179
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Nov 2025 02:42:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xhwSbpye;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 40.107.159.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fneFluwa66+ZtYPOF5cHERmC+6JC4iKATnrp24O4YyRH/sAiGYep4eFxKobozfd1Hwg5rcxV6RFrhErNxg22Gumh5j80g7lBSsuPPmsDpt29RLDkF2JZ8gBMfGdyPX/Tik8A6aDRWnduT+hIKKMx8YX93pWtA6NqFyGEph9SxwNMghIAygnav/akOKaMZDPWTOnvXjfY8xYUN15eAHSI9clqZ/JL/nYFnHyA7EOf7H8Jz3ypIudVe45DFm8whipd7wzD9qhfLv4Rll6Ex9pODmUlP+zHk3P+3l2ddIky3ea8k4wNG7gwvSm158FvKYvJ52XdbQIcr7hzSnDlepS1xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omymIy2I2ZKyC9i1kHwGHs5p9vk1hl2POvetG8WbR9c=;
 b=x3a9oLBtYiicA7rotjyVbIyz1ElctLEMdk4jCkaMkdCvAZnRSwz4qi/key7lNCaXcLNVC5mrR4bSVY834TOBV+j6KbjzhStWCLmCQY4c4xgX9Vgf4TmKrMwFeOOMrfxjUg2bNkqi+ezisxbOw1fIdeZRlMqzEr2tvcmhivlBb2KmPwPcWXVakXGqZQnfjU/sa2WbcusJlsVH+y6jqeh8tKTl5F5Jrl4T/Kj+thIjZne8BJWK97f2/quvgmge5T19DxOHhPpESMSVUFmszamrxCFmZSBz7Po77a9fxN8Ju7ufUgolCfjrdePFLPyCbICKl0oYrqf0Dz79zeKkp4Kk1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omymIy2I2ZKyC9i1kHwGHs5p9vk1hl2POvetG8WbR9c=;
 b=xhwSbpyesvKE2zEXFK0kRKaDCE+2Eq6/FcSt4xDs0nUyX5RP8yHi5mjqi2fGNpKOrVD9B7fagzq5+d8R36mtGyrtexznohs+v6HMxgXpBTLElN9xrg4t46W1TNRFXLp4FBuIawlFD/RCJK6b+iTsE9K/3hMyj2cHx+Ysd8WWwsF84iMrnjHnfGX+8SQh9+NaHAsb2V7VkeC5enM12NvsQoSVClwcBOt6OPGmZILlZVwBuSm5Rshq8mNbKnIdt6Vy83wLmin58/Kan/4RpR1XW5vN/Di5X+Pfy6YKBFr57lNCcF41NBvJXbVLbnJa7UPHwOES/tQQN5s/TEKuho0teA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 10:42:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.018; Tue, 18 Nov 2025
 10:42:35 +0000
Message-ID: <6fb11f6c-d909-401c-b479-70e9271418f9@siemens.com>
Date: Tue, 18 Nov 2025 11:42:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] fix(security): add libpam-passwdqc for
 debian trixie
To: Gourav Singh <gourav.singh.ext@siemens.com>, cip-dev@lists.cip-project.org
References: <20251118094737.4613-1-gourav.singh.ext@siemens.com>
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251118094737.4613-1-gourav.singh.ext@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0169.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5693:EE_
X-MS-Office365-Filtering-Correlation-Id: 6873bfa2-c839-480a-ce34-08de268f2f72
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U2tkS1VSRnJIOTQ5dFltK05BMFFhRnA3RlowT3JVNFlzaXZKU2R3NVdRZGI0?=
 =?utf-8?B?ZzNXdldheFVvRzl2VWRIbWM3dVZ2bDJSV0hsQ25PT2Nkek1ScFhvRVowWVJ0?=
 =?utf-8?B?aWZjNlRMV0EvZjJZeE9Rd3BRVzlqeVVTb2xOYnFIUDdYNUw2UHlQcW1heUkv?=
 =?utf-8?B?U3A3c2kxQ2IvZ2ZVWFZCWi84OHZsU3BwMWplNjRWcnNFbXM4empKbEJOWGo5?=
 =?utf-8?B?dWlKU2wxSDhtWUk1bjZ1VG0xSC82c1ViL1hUVlhNMWVQK0NKTWl6TDlUMEJ3?=
 =?utf-8?B?NEU4TFpreUZKcFZ2cDVvUnZoejduNjhIYXR4bGhTZVY0eFpFVW1tT29oRzhj?=
 =?utf-8?B?b1lIc1laaHc0MGhnenM0UTFUY3dndnlYck56SUtrak5FSVBxem9JeUU0N0ZQ?=
 =?utf-8?B?SHNTWmFKbzRzVmFjM2RHc29tenVkOXh6YUc3ZGZiU2t3eUhNWmJZTlh2OW8r?=
 =?utf-8?B?SEhTK3RUWHpIbDJjbzhtWmxoY0tHNjkyeWRieGN0c25zSEFTNCtOS3l4Y0t0?=
 =?utf-8?B?NVBsZmx0R0dJN1JnSFdkOFFIcUZiZDg0elg5Nmc1WXF5akRFV0JyRUtXRkR1?=
 =?utf-8?B?TjU3eVVwMkRZMFlWanF6VnVEY3M3UkJ5Q0g5bUwwRC9obWp0Unc1RHpqUStV?=
 =?utf-8?B?ZjdZOEZ1cS8ycVVZNFdKTjViNWxiaG9UOUNlYjhmTVREQ0pCQkJLbWQ4SnFL?=
 =?utf-8?B?L0ZOMHlsZkxMNml6U3oxWnRMUjAvUXk4NzFiQXJESCsxMjh5cGozTkNBSklM?=
 =?utf-8?B?aVpzdUwyT0xUU3FhYVZMZGs1SHlTdWJBd29tSzdjOEtuaTYvd1I3dVdKU1Yy?=
 =?utf-8?B?bGpNNWJERTdKc2MrZ0tqeFR1MDFHRjlBRnNYNjIxRFZ4eFA4NWZIK2haK0wz?=
 =?utf-8?B?ZndueFE3WjlhTTFZbVdVcGMyazBwZjcxcHRvTjF1Z0Y2SkNEWGRQcTRZSEFZ?=
 =?utf-8?B?LzlBK2JpZnZwNUZxR2YwYU9LUDNuWVZDdUc5aFpNSWdCVTZXL1BxU2lWQTYr?=
 =?utf-8?B?bEMwUmdVNjZ1SDFvd0hTbndwMlErWENHTFlsOENUcEFWL05CdWM5YWNjdWpC?=
 =?utf-8?B?M21DV0VFUTI1ZlZhdTk0SW5jSUdpaU9FaEVhejg1VWY4UnpoQ3h2a2ZpQUpJ?=
 =?utf-8?B?Q1hFa2FYSkI4V0REd0lYcmJSQndPeFJLc3FGWHhWY2UxRk1jQWExelVzMUFS?=
 =?utf-8?B?WExnNm84Z2VOVGt4TkxQeU9naUN1NU9YY0pBVkFCZGJya2RKNmRzMTlHYWIz?=
 =?utf-8?B?UnQ0b0VUdWJDc08zM3ZueDlWUE1xbGJWMWY3RUEzUUxMQUF5OTVJWVJFRitG?=
 =?utf-8?B?cU43bXBvZWpPN09aT2p2ekpqeWROamlIajJYNjdtQ3pCYTFuM3RJdUNaaHVP?=
 =?utf-8?B?MDR5TUFOZERmanhraXJxUVoybU1VUnA5SVFmdmd5VllrZ2VHM3A5R1FqMjha?=
 =?utf-8?B?akh3dnNLR0h0OEZRNFQzQUg2TEdudUVPQUtWOGc0TDhVNDVoWVhxRE1qckQv?=
 =?utf-8?B?cEkwRXRwa0k1UW95WkE2dTYzQXJISU5hd3NBTjNUOGQ1SnRrMXdJQmp3a3Mr?=
 =?utf-8?B?emxIaFNjSExiTzY0cHFvanNkSktIbnlBbHRDNjVycWdBNlJHeHFVa0w4MHhx?=
 =?utf-8?B?MkRsRUxvdDdsbWlZSWplSFB6Z2tBb0tPQU5NMmpKV0NvM0pKdnFIQXZVMUxy?=
 =?utf-8?B?M2tMK1ZZNlJ4THJ1RnVKOE1tVUFLUEtET0R3VlVuMGJ0dU1hblFjWG5oeFd6?=
 =?utf-8?B?VjViVFBRc05WUFVwMGJ2TWc3ZVQrU2hGUmNsSms3OHdVNTE5WGl4bTFiTlJn?=
 =?utf-8?B?ejh0Qk1Kcy9WNUgyTGRmbmVRdnpSeDk4cjBaWGVCd0hTcHNXN0laQ1BDVEgr?=
 =?utf-8?B?aGJCaU1kTStXMm5KMnhqT1RoR21oaDV0TEE0MTRKdUNraS83YWhWSXRnT1Fv?=
 =?utf-8?Q?dZgEv5mBv3PhZNWY1sepLPbmcqeAR4Ih?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dkhFR0hyaGdGcjUvazA3ZUdla3pBNTZNeDQxUG5GY2x3TXF6Nm5CM2ZScEl2?=
 =?utf-8?B?OTNqZVV4Y0VKQktyY0R2ajJqNHI5RWNnTEFvV2tVbEtvMnlHTUJZRTVwUnVq?=
 =?utf-8?B?NXpnMUJReGwwblhGUjlFbVFQYTNBdER0c1BKZXlndU00eDluQllyOVV4RW5O?=
 =?utf-8?B?TktQZzVwNzFXQ3RYRVdteXFmdVZaV1FUd2FmK0hLQ0I2M2RaaXJ4VXlQdkg2?=
 =?utf-8?B?NlZGOXpxWDZVblpkNDZvSjdmYXNZQS92UEYzQ1RweEYzNUVUMVpqQ0F4ZThz?=
 =?utf-8?B?S0d3dU9KWWxZQzNMWnlDRkFhVFdJSHQrUDFTNFFwZmhST1RaL1d4SmpWWWcr?=
 =?utf-8?B?Q0dXRW12TG9UTjZCSTB5VThGMldEc2V4VjJoUlNKNkRWbVZaNWs4bS9ZR0Nw?=
 =?utf-8?B?ZDJ0T0ZBcE0vb3kyWHlmVTgwaGovY1Nzc2lBTDBVblB4ZU8yVGhOdUNuakx1?=
 =?utf-8?B?SlRsY2NXQWZDWWh6aDJ5dUE1b1VzdXowenQ4L2h4YUFOcGYzV3l1UDEwR0xo?=
 =?utf-8?B?VHo0ejEvdmFKRlN0OU9obUE3L2ZOQjZia0s2YnphZFB1ZWZPTUlacCtpUFd0?=
 =?utf-8?B?cld3VkEyZzFZUS83RUt6STgvM3B4RDFlWFJFUXNTYWtYYXpoV3Z6RlJKWUc4?=
 =?utf-8?B?cmpjUjRqY0tLZGJWQTJ5VFJ4R29rKzB5N0dkdDZoY3d6ZHF1N1Y4ZXlra09D?=
 =?utf-8?B?Q2hXK2YwVkhQQjhxWnk4d2lpalpqNGZHOEkxd016M3JLaFJRMWp2SHQvTXJt?=
 =?utf-8?B?N0VqZ0NaUTZVQkRpYmd6U2xXR296Tkw1Skx0Ymg0SFlmaVJPOStiQm5YdVd1?=
 =?utf-8?B?ZWExalNwSTIzc0Jya3NZYnRjb2JIS0I5U2Z3UTVWcWVWRlk4TUdEdVpkNUdB?=
 =?utf-8?B?b0hJaCtxNTUxMFlwRFFTZ1ZmakFtZzRDdG5VUlN5R0F5aFEraTgyUG5IbnZl?=
 =?utf-8?B?S1A5OW9zUjF1amoxcVJzNzB0NGd1akdUT0JNNFVpN3NuWVRWTXM3OUorWVBY?=
 =?utf-8?B?ZjhGc2g3QTBtTVFaekw5Z3Rta0pzQTZwTmo3a0tySFluN1VxUit6bjRwYWRu?=
 =?utf-8?B?K0Y2NGM4ekdxVjlqS2tkZXZLSmUvamFFSDk3UVBxcU5UKzloTUxHQkRmRUhQ?=
 =?utf-8?B?Vk5LODNkVC9hbWRVaHEzZm05UzZWQW9rcG9BMGxSOXpxR0drMWt3MnVadmdl?=
 =?utf-8?B?RXE0M2ZyQjJXOCtoTnFxcit4VWU2bXdpYTR1bW1FZlN0aFFjUkxyTkhqY1U0?=
 =?utf-8?B?RnRmVDdIWSs1b1BkSCszcGZIOVJnc3Y5UTZMMkx3ZERRVit3bVUwcnJEejlF?=
 =?utf-8?B?R0FicDhwNE1SWitXWXluSlpRanF6aGFyZEVGZ1Q3SW85RVlzaFdrVTdlMW1C?=
 =?utf-8?B?ZnVpS01YYVFyUlFXUU9JL2tKb0lTMTFwUU12SitBc0dpUExGa21BalRqaTBU?=
 =?utf-8?B?NDl6TDNteGVCbldycHp3bDJhTHN1MWVKRkk3SHpzZG5GRUVNTk16QUU4N1Nm?=
 =?utf-8?B?T2o1SXozQURxbnJLMkl1b1drelVxZldPck9SR3FYa3NVdmZBR0U2SDc4U3Ez?=
 =?utf-8?B?WklEVXE0UkZJNEEwV1BBbVhCbS9JWVRZcytsNUVkZ054bmpIb2xINnN4ZGc2?=
 =?utf-8?B?MTkvM3MwY3Y2aGJzb1FVMlBodjdXY3huYWpabmRuMHZzRGxxbXBhTzBSUVRp?=
 =?utf-8?B?RVdVaGxnZTFIUThLYVNMaDFhSFlsYVNDVVF1eHpFekc3dXgweDZWRmxrMFhq?=
 =?utf-8?B?VDlNWTh2TVB1clVuOW4rcnJSRStEaXhIYlZ0WlhsTDVwcDZ1MGVqS3lIVE1V?=
 =?utf-8?B?dDdtcm1xQjhNOVkzM05KcllNY2Nsakd6TFZpazdKTEVTaytwcElvNjY5MVVh?=
 =?utf-8?B?dXJjY2NIL0ozLzdMT25jM1R2OW0rUjE0TzBIVC90V2dtNDZBRHMzTGIxNDc1?=
 =?utf-8?B?RmpqTGxMaWhZaDk4Mlh5dXJHbytWUTZRMnd2Q3JyUUNETGU1aWlhOHlKRlQ2?=
 =?utf-8?B?ajY0VFUwc0pYaXJISHpWQnZtUkNyUkJvMmRJQksxL1Zia0pHTHd4dTFIODNn?=
 =?utf-8?B?d0h5cHA5bndxa3g2Snd3RWY0TVMzcjU4Yis5eGR2aC8vUFpvUGlGNmFaTUVm?=
 =?utf-8?B?N251UkhUVU8yZDlWVkl6R1ByazQyZ3dUUjRDRGZGTTkwU2V6a3VZTHgrWGsx?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6873bfa2-c839-480a-ce34-08de268f2f72
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:42:35.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e40PdWN7jf3ei54GfKB2SjJP8alMSuV6E114o5Bg8dK601jkVzcbtANo+ermrLee30al7ONZ/Rvxo2HUQoh+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Nov 2025 10:42:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20611

On 18.11.25 10:47, Gourav Singh wrote:
> The IEC 62443 security requirement TC_CR1.7_1 (Validate
> strength of password-based authentication) is failing for
> Debian trixie because the required package `libpam-passwdqc`
> was not added. This commit adds the missing package to ensure
> compliance with the security requirements.
> 
> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
> ---
>  recipes-core/security-customizations/security-customizations.bb | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index 75a6a99..f638f8b 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -24,6 +24,7 @@ DEBIAN_DEPENDS = "customizations, sshd-regen-keys, libpam-google-authenticator,
>  DEBIAN_DEPENDS:append:buster = ", libpam-cracklib"
>  DEBIAN_DEPENDS:append:bullseye = ", libpam-cracklib"
>  DEBIAN_DEPENDS:append:bookworm = ", libpam-passwdqc"
> +DEBIAN_DEPENDS:append:trixie = ", libpam-passwdqc"
>  
>  do_install[cleandirs] += "${D}/etc/ssh/sshd_config.d/"
>  do_install () {

Thanks for noticing this! But can't we write it like this for all releases?

libpam-passwdqc | libpam-cracklib

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

