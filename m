Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D926C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 15:54:23 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.68])
 by mx.groups.io with SMTP id smtpd.web10.25846.1716911653743140710
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 08:54:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iDR0upYO;
 spf=pass (domain: siemens.com, ip: 40.107.104.68, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixV4ArmaI49/pkQkYo17zHzN5l5X7kUTpbSGzK6v3uU6gHromhRw2Fxf9Gv76qzlD7YaGvU+NVOi8e9XofIzFU7fL1JnOyfySUyxK/+I8WP691BRhDZAhMPXJT2dvYaOKifm9Ki/Mb0dWjcqBT6qmLkuphKQoSulwdhr0rZRphr+I9mmsesZEGVUbfvfhKUX37V7R6Dg6nwUQRWk6ivPV2Yw8idS+maBbUcQGdspshQLc33zxQCu6tkB8QVEuY+ChRQYn0q5jfk9teWNhE0VJuimyhlzrLGUeI8d/6TBEjh2M058YVNKUl/hI2ByjtASKhVc3apj2LZ1SPxDei/OIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4AL/sy7DCLjpMp64oPJZmunThIMtrdXGmxWnTHfW4FY=;
 b=Jfqcy8tZ4wdvB5Ici72IKdMcvv1sNBQpcmgdW3ZTivm9M2jU/mj+XiwHB1m/U//ZttIxvziqklmVtas8/FEGvNhUwkZcDMFGqnJujjM/UN43oMg0KMI/lLsinMyOK/utB65HcnWiMaRTAKVPNQm+3oPqFtS/yG4B1RfZIo6gzgONqJNAMlIjZmKdxse9buTHKf4PqDVuZIObBDdlS7+4sPko4Qle0fA1t4nZ5tfhDLzNAImuHnO3IZsHMowSHljZONcu5ZrplFEH7XkgsSlRLMgVFeoHFO1sF2M/Ht0ngpRbAHPAzCtDdn8iUUa2ifVq7dXvKwshu/+fuHu3rJfuiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4AL/sy7DCLjpMp64oPJZmunThIMtrdXGmxWnTHfW4FY=;
 b=iDR0upYO4av/YLwlbdj8LNcQiwv3XtyPUOT+qu5/GYsaNzY+Sc8Y4VsJegZIQWoTUsqmeAEl+96gF7lxNimsAPtt9ewWoaPZyiucR+1JCSxLdGzpVTtwgNfOLLsgZ4q7a2cOg/NzReIhV3pfbzTYQbq0T2mdW7E+foSriRjEe6R+PQ48I2MeyQirjEc9LkBxgb3R6G0dIKqe7m0Jwvj4A6E8ne3wU1OuUULTNgIkHc/V1x163JgCQTmngrSJzyBG/iDVx7YeNf8yILzEfRxomgosrFrRlUOnifqkUtI/y2kjVbXCG14/V68ix3s/NaUMyCEvRXHIRCAUZsZ58BCMMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB8313.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 28 May
 2024 15:54:09 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 15:54:09 +0000
Message-ID: <5f868bba-89e0-4843-b5c2-14116b66c529@siemens.com>
Date: Tue, 28 May 2024 17:54:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/3] Move security-customizations
 to recipes-security
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
 <20240528144903.922587-2-Quirin.Gylstorff@siemens.com>
 <428716d7-3027-4c77-98ea-8e6ee0bf124c@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <428716d7-3027-4c77-98ea-8e6ee0bf124c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c127f06-bc89-459f-7b1f-08dc7f2e6983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aEljV1NtdEUyQ2ducE9vZUtqS0JNVHNyMXBKTHFZeVFlcWs4NnNGNktyR0hN?=
 =?utf-8?B?U09QRXQzY2t2d05VWVh0TWt4a3d1bU5Mc3dhTnIyMHd6TnNualJkWm0wNGRH?=
 =?utf-8?B?U3BhdkUvcUFuQjdjeHhEdlhUcW56Q3oyL0NiWHk3YnFFdjY4ZGJEdGJSU3VF?=
 =?utf-8?B?djBXYUNZNU5qR0R6M0pWSSs5TlBOaTZTenQvdHFEUUJMSC9JaktZSzl5amNk?=
 =?utf-8?B?YWhXVW5uUW1JTm9SV21GQkRZOFVxOUpSOVpiOS81STd5QjcvS0QzenAxdlBK?=
 =?utf-8?B?M05VNWdKV0Yrem1CY3VDRGtEaElJQzhxREZ1M3Y1VGh3cnVpTVNIeUh5SHlo?=
 =?utf-8?B?aGtXY09xYjdxeEl3aEpLM3lyOVFkeTA1SkU5ZXVBSVEzYWVibXphb21JUXhE?=
 =?utf-8?B?MXBGcW03bWs3dVREQ1dHc3FiNjFtQmQrV21XMWdVUDRxN28xOU9XUzFIM21T?=
 =?utf-8?B?UE01c3R4NGR2cVpsT0h5d0NjYUNES2R4MWVXc2RsZWN1Q2hOQVNXZWZvQlNq?=
 =?utf-8?B?ZzgvdW5heGh4R1JmT2ZEQmhZRXJ2RWgzT1paS1FmY1pyT0VvTWtUbWszQTVL?=
 =?utf-8?B?c1h5Z2FyZk9NV1ZxOC9yNS9VVlZzNHRXczZSVDVlTkpQMFlHTWhhUUowcEpB?=
 =?utf-8?B?aW5DajY5WFVQb2J1NjFwUkMvNHFwWTN0eVluYytIcFd3cjk4RTF6Um5ndXdJ?=
 =?utf-8?B?RHV1ZzA5aXR1ajBaM3kzaHZtNEFGelZuYVhFK054TUthQStKM1p4TEpEeEpi?=
 =?utf-8?B?TDcyNzhycnkrdVRyS2lIZFBXOE9mdm5mc1p3VFR5aGgrU2RVeXR5RUh5UjY1?=
 =?utf-8?B?VnJDbW9kWkpuSFZ2QkRSSHYwNnJoNlI0UzhwcnloL2JxU2tMcWNzNHVOaU9I?=
 =?utf-8?B?dlB4dDl1MC9iZ1JPSDl5bmJJUk52eGI3ZWcva251b0g3Q1FtemRXZnliK0xl?=
 =?utf-8?B?Q213K25YdkVteit5Y1FEK2VtbHlJR1VZUlVUaWJDeWs1ZDFKRVcxQllVRnRm?=
 =?utf-8?B?TUlvdm1XT3FmTlBLanRBU1FwM0VEMWsrNXRVcUhDSkUxWkdjRXp6N3NmUFFi?=
 =?utf-8?B?M2Mxa0ZuVlM2aVB2dEcyeGd6cHViM3Ara29oM1VpRXhnbEU3TWhDODhFM0w5?=
 =?utf-8?B?YUtlR0ErRW54bmszN2h5YkNTc1NUWmQvWHUra2RKWnVSQ0NHYmhPQllLbzZ2?=
 =?utf-8?B?a0tjc2p6SzFUa2pPMlNIR1MyVkdUcjh4QzdKNEkybFREVFdtb05TZFlWWDgw?=
 =?utf-8?B?dlljc1YrMk9vLzA3TVhFKzA3T3lvMjNqeE5ya29tVWZadTd5UUQ5SXlTNExm?=
 =?utf-8?B?emszVklSOVdHTUFzRnV0djNxOE5kalFOYVViMGpkc3VTVmFnam9FTlM2UzNQ?=
 =?utf-8?B?RzF4SVVpcUJOSTNwS21TWXQvemhNbzBVeWRjSzJha010d1hmSXhLbm9NbkJU?=
 =?utf-8?B?ZGdSU0M1UzlYTmpjZkdvOFdCUGM5TmRzMUdQVjliakRsVGU5Mm1EVVdPTXNT?=
 =?utf-8?B?QjQ1NXQ5bDVqb2FTR0cxd3UzTWtwTTI3SVFpd05Rdm5oU3hPTzFqc2VtbnFn?=
 =?utf-8?B?ckpCUk9tMmF3VExMZnhRZ0tHN2MwZnZrb2xnRmtzK3hmTWE2Z1dkMUVQTURH?=
 =?utf-8?B?UGw5R2dKSGppUU5Sd2xHc2FRWkxBOUQyM2cvb2VZTG1XUHdrYSsxdmRxdmE4?=
 =?utf-8?B?VjZ1dHdXUEJiV1M1SWwyUUVyYXRwVkE2a2QyeTdhOHdIa01sRkR6VTBnPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Z3d6RWc2ZWlyWmpRZWlNeUx0U3ZmY2dIRHBwWkxPMmRFb0xST2N0eDFUUTJK?=
 =?utf-8?B?MHYzemhsTm5zRWM0dFBLNmxFT0JuZi90Und2bGptMkY4cklzMnFndmVRdFNS?=
 =?utf-8?B?Yjc5NW1JUVVHWW9QYVRzS05oYVphb1BFalFaK0h6QWNuRFV3TXNXdmRhVnhE?=
 =?utf-8?B?V2w5aURHOW80TW92Q0lGeEFlNFNFaHB5UFNmUjZudGdzajdyUWdoWWpZUjhH?=
 =?utf-8?B?QWhIYXQxWFVHK3M1T1RtZnEyZU1FRGZCaEZUWlJqaVFORUxQOFhTNnRPWVJ6?=
 =?utf-8?B?dE9Td3d3RlhwbGVaeXBvRkpnKzgzYS9UajFRZm9xOUlNQUU2SVNoMExlMkdn?=
 =?utf-8?B?emtSZmFKdjEzMzd4K1B2UjBZYzJWUEdqSXRqbTJ0RmJPY1I0T3UvbGNQTFFo?=
 =?utf-8?B?TkpwVmdDR2tzWE1PNE1QYTRZK2xMdzBHd1JCajBRTjFPK3RDY0IvVnZjbDE4?=
 =?utf-8?B?d3NmR0ZyREduSXF5SzZNMW8wb2JkWlUycGlBeUNZZUJJODVKRzVaUmhQV0Za?=
 =?utf-8?B?S2NUK2JuQ0ZCN3pybVdEMHkzdFRVelpXRW0vR3pHZ0JoYTBxRzJ1UnhyNzRp?=
 =?utf-8?B?T1d0akwzaGM3K0JkNGE5VHhFR3FrQkZHeFlEUjNzVjJjQ2U4dmVwOWdNVkQ5?=
 =?utf-8?B?SUFQdXo0YUF4WGRhalZJUDErKzcvcDYxUHpKNVpvRDJlN1pFbWxmcUdvSTBz?=
 =?utf-8?B?MG5PNmZtcWxhQk5MY3JPZjNsVitzRDhIUzh1SFJYWG1OVHFIandKQndIb040?=
 =?utf-8?B?Z0dLY3NxT0FiNFM0WHBQODZMMjhnSkFYTmdNdm5UTmpVd1lpaUVVQUFHVzVW?=
 =?utf-8?B?OXdQYmQrQ1RZZkhtK1FBZ2Q0RXIzNFIzT2RXRGFwUko4MG5lOURqVXYzOTJu?=
 =?utf-8?B?elUrS0F0NmpOclBmWDRuVUlTZG5oaHAzcU52TC9aOWVJWUJ3aGY5OEhReDYy?=
 =?utf-8?B?bERQOEFpRUNOK2pxSmtvbEY2TUphejYwNWt1V2JYWG9ZMkZRSlNLcUhwSlVO?=
 =?utf-8?B?TG0vWVd0dGJJMHJpR0luMW03bG1vQ3RHdG5PT2JaT1hDS05XRUF6M3A2Y05O?=
 =?utf-8?B?bUhscVh0Y1dZTjJhQlZwbFV2RjNHOUFMU0I5ejcrdGhVTDVjS1FzenA4bGky?=
 =?utf-8?B?UGM1bGRtSHIzTkpuODMvTFRZdk1YQWExSHU2Nis0N3Z3OEowcGZqblpFL05P?=
 =?utf-8?B?S013NjUwTkdrMHoyOHFJMnEvZG1jaDNXK1l5UW1taVR3S2xFNEZyQXJhaWow?=
 =?utf-8?B?ZUhoaGxXWDM1R3o0bkszbWtHOEhHM3VBRkhhNHBIdHVwczN0M1ZjbGNPajd3?=
 =?utf-8?B?SHNTVWxDWHNnMzVBckFEWWxUeXl4dXpVUnZpN0MxR20rbTJwVmd6MG5iSW1m?=
 =?utf-8?B?R0ZwVndxZkdmdmprOVRSKzI1UW51YndWRVUwK3gzVkNDaFo1a2Y0TW9salRH?=
 =?utf-8?B?blN2ZjMreG1Db01pdXZIV2Z6U3BlY1NOWlpyam9oWnhPanNLRkU1eWhaUFR4?=
 =?utf-8?B?T1BaRjBKSklYaVk4THJCT3ZmdVpKN2FDK01WVzR3ankrZmNDMmdmS3dPNk9M?=
 =?utf-8?B?MEcyVnBFYWlxVVZrYVd5N1pUbEc4bFpXSndnZVVRK3p0UUhrd3dZNmNQRjFi?=
 =?utf-8?B?MlI0VUR6NVV4WXg1dkxKYzFneU04NEpsaXdQWk4yZWI5RDdUMU16MDVGeXB2?=
 =?utf-8?B?MzJNU3NHbzJmYjBSVkVwR28ydFdrWW1zYmxjT2ZHTU1zL0U2NGhWOGY4YjE1?=
 =?utf-8?B?Sk9YYi9nNEh5QlBCSGUyTWpmL3RRR2h0cUphMVYydWRTZ3ovOTQ4SjE0RWZX?=
 =?utf-8?B?ekEyRlBiNDVydXZFZnlxd0VhVHJhajVobXRkN0lLdEQvc2k3K1Q5Rko4bWEw?=
 =?utf-8?B?MWQyOWpHUmx4dTZhSXBEV1FqVU9JcW5lYWQ3Yjh4QWJKeDVRbVhXeVdyVkFl?=
 =?utf-8?B?c1lCQVVLYzhlck10eVhLYVF0cnNmbXhOMyswMEc3WS9jVzdrMUhQWnQvK0JI?=
 =?utf-8?B?UVljanNlQVV4bmRpSWR0K1dLQXBoWGM1SzlGVmtkYXhQZC9VcUw0OHVwRWpv?=
 =?utf-8?B?U054bDQxd2c4SkFYcXFiSUlRYzROODBHcTc0dDJzS05HYldNZURWQlkvcjd2?=
 =?utf-8?B?cEUwL0JjR2YvdTRORFdxWG5TdVZ2YjNLZXFDKzJWSm05QWFYTTlVekZRV3Ft?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c127f06-bc89-459f-7b1f-08dc7f2e6983
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 15:54:09.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvFslu4veOPEMkAd8VvRmFPmK+OTOiW04g90YSlzTUEvNSJTvHQ37iHEaawierc3RGKbUfCYEOprXQu9OlKS0IB8hJy2a6RhlVOCT4QZtKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8313
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 15:54:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15971



On 5/28/24 5:27 PM, Jan Kiszka wrote:
> On 28.05.24 16:42, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This increase the readability and organizes the the cip-core layer.
>>
> 
> Double "the".
> 
> But I'm not 100% sure about this move as typical isar layers so far had
> customization recipes under recipes-core. Not that this is written
> somewhere as well, but...

I can remove this patch. My goal would be that most of the items in this 
are moved to separate config recipes which can used by downstream.

Quirin
> 
> Jan
> 
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .../security-customizations/files/postinst                        | 0
>>   .../security-customizations/files/ssh-pam-remote.conf             | 0
>>   .../security-customizations/files/ssh-remote-session-term.conf    | 0
>>   .../security-customizations/security-customizations.bb            | 0
>>   4 files changed, 0 insertions(+), 0 deletions(-)
>>   rename {recipes-core => recipes-security}/security-customizations/files/postinst (100%)
>>   rename {recipes-core => recipes-security}/security-customizations/files/ssh-pam-remote.conf (100%)
>>   rename {recipes-core => recipes-security}/security-customizations/files/ssh-remote-session-term.conf (100%)
>>   rename {recipes-core => recipes-security}/security-customizations/security-customizations.bb (100%)
>>
>> diff --git a/recipes-core/security-customizations/files/postinst b/recipes-security/security-customizations/files/postinst
>> similarity index 100%
>> rename from recipes-core/security-customizations/files/postinst
>> rename to recipes-security/security-customizations/files/postinst
>> diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-security/security-customizations/files/ssh-pam-remote.conf
>> similarity index 100%
>> rename from recipes-core/security-customizations/files/ssh-pam-remote.conf
>> rename to recipes-security/security-customizations/files/ssh-pam-remote.conf
>> diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-security/security-customizations/files/ssh-remote-session-term.conf
>> similarity index 100%
>> rename from recipes-core/security-customizations/files/ssh-remote-session-term.conf
>> rename to recipes-security/security-customizations/files/ssh-remote-session-term.conf
>> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-security/security-customizations/security-customizations.bb
>> similarity index 100%
>> rename from recipes-core/security-customizations/security-customizations.bb
>> rename to recipes-security/security-customizations/security-customizations.bb
> 

