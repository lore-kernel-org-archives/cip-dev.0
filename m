Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A518C636CD
	for <webhook@archiver.kernel.org>; Fri, 10 Feb 2023 08:34:44 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.77])
 by mx.groups.io with SMTP id smtpd.web10.9761.1676018078963068837
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Feb 2023 00:34:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UCMAPEgw;
 spf=pass (domain: siemens.com, ip: 40.107.105.77, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W0FDWgYq6CTZrwMYUTSwIkGrRHQb6zljOHL620CYGm0tMhQqyn+Cd+Zn7AJr5OtAwfzdf3rs0ORP39866Sjhh5LhPMP4QdyczVWp3ylqDdzUPTxVFAS62cAZfAugrlMfcSoWJ7CjD3NJRG2tcNfETi5Elc4zf4lFyB8Im+irebY2EK/tt1wSwbn9MurV4qVDzMWiGETFO0OOsgFOoF3Q/Dixr2/dn9rI4eb/Aq9UoT1fMIMPPrjZPOhXJbc75OY+lHyDseaSFrxpgvzlow3TrfPg7SL6fse4Y6YGw+04lZte5Hj4vw6XxbEGzvNLFvUbQJbwtwrzAedLWnZJdvq2DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBuj04j4WTxNDPUm68wMx+SN/uzPG9/m2j4M5TbZLqo=;
 b=b2Bc9lrTP4leyVNFV7JU1GFUPqx+6IhSl1yIsYHHy/Pbn+TDadK/s7jBcLjD0VY6qi32wRGNa1vXlz3h8lmWFMXksEqcpbnOYg6B+g21QI2md40An9N5c55nC5vAmr6gldubLCz9tYPZmB3HEfLfgwn3NqMPn41Ejw7Gqzgz/VA/t+7m7HfLmm7ow1in+MIUxPxajNX1ypPUZYGY8XbzxMYgiSC6+UOyNhCOp6/FjxkdQ4K+ZLy0soGj2ptCs6S6EcwhXALqV4UHjD26i0SYWQVaFrlnFzzXWIDY5EgSFEYXpUilGTygd4B/gjjlEav8FBk7DfxR//SL5F/6Maibzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBuj04j4WTxNDPUm68wMx+SN/uzPG9/m2j4M5TbZLqo=;
 b=UCMAPEgw1Oymg51l0xB/z1PVE2BjOCxntTb14VmdpPXNkYzCI/jNuQnJPgJX/JaNGWr1XILgPs3gZDIg/AHHRA7CiPjjPZsEaPlFlz07YxeaOG5Dc6UqHWx3C6LaztxWHFV6H18V9nLREc0ThSYArqLLvGqTn0XKKot1ncHEEIdXhEaUtIPEgnlVV9Zr47YSWSQxKkGauQitgkzjJJy9eVBDCD4PfGkz61mi/s2u8ucSVIZFk5PX7eDhsmlXDtPfXKazlbSb5nkiuqw50aOgeCDeNPkWP2/0MX/dwmY0kff+o+1Pe91weGgJhTDEmCPT0+0/aSXRkQwnPsJossrZCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB7310.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 08:34:34 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%9]) with mapi id 15.20.6086.018; Fri, 10 Feb 2023
 08:34:34 +0000
Message-ID: <3e6f8121-c330-7b13-130d-1cb6d02a6864@siemens.com>
Date: Fri, 10 Feb 2023 09:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [isar-cip-core][PATCH v2 1/5] register image classes via
 layer.conf
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Schmidt, Adriaan (T CED SES-DE)" <adriaan.schmidt@siemens.com>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20230210064503.706699-1-felix.moessbauer@siemens.com>
 <20230210064503.706699-2-felix.moessbauer@siemens.com>
 <89c23ac5-c9f2-d267-496c-1437fd7bedd9@siemens.com>
 <aef3f8b5e3a66e2b24e56194fd03b90fd821f3b5.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <aef3f8b5e3a66e2b24e56194fd03b90fd821f3b5.camel@siemens.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020502090801090605050905"
X-ClientProxiedBy: FR2P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::23) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB7310:EE_
X-MS-Office365-Filtering-Correlation-Id: 112e4e61-661b-46cf-4015-08db0b41a341
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EdemTFvLcLyFkqwu02TugOr7SJxql1afmoCgx97tpuUTwjBZXPhR5PLQHsFxnSAYIbIiELcJlGvLVoMoJBYAUo5WKkdPyGdepFnAeDRiURjTExloZOinHdKMxGZEtJxJY48dNDm2ovjpJuVseY4H0DBGKwOqwBf/8Tae6POMz48g+7jZZQw8idNlvBPwl1TPBxv66drYzJg+Sf3vhLfPvabPX2J8Tz4nbtqs95K+PjW+DcgM99VR69fv4NizXJYrI/VFhpuzclUg5VURiZuMTYoTi3ooV4VUKD8CeXEukN8/j7dYsE239srVJh5O02hUjaMlRUh3RXLYeMwIv6QBiMPrmM43VKyIdjwnsv19Z2u77cWDyyLkSOx6umSA6kfGGPT+QI3n5hW72KEJf9DvAGk7q5oZAVQtJHIwWxtvqY3QK6z3a7sWp+LRNwvWmHsgPTUPziSNa3U+vKo+b3P9ka8uHL0AuWWQ7QBean9jfNiMcgWoZ8Mkelx4RgqRIPZpXzwM8X8tVwFQfQspyZ4xafIAJCcW5QGfV8ql3bXswy3VThUXElRECig6jqn3sFm9WS5A5bXMhsPVHtSZpUvy5IxMuFHNSKkaFKFSxfyo7I8EaNId0rsLbj7z8EX9wnAl1CHynnvoqlUo5SxjpeOZzZ8wFVasWUaXgr2jMI4prfRLScnBN5ujh4B49jkvrNPBzkqW6Vl4pMOfVedpaqEvA03oi5ogNw9tR+fA0lZtFOI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199018)(235185007)(5660300002)(26005)(86362001)(186003)(31696002)(8936002)(2616005)(38100700002)(83380400001)(6512007)(54906003)(110136005)(41300700001)(4326008)(66946007)(316002)(66476007)(8676002)(66556008)(6506007)(33964004)(53546011)(6666004)(478600001)(82960400001)(6486002)(107886003)(36756003)(31686004)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TVRTc3NqTmYxK0NwN3FRS3N1ejcwWktuazBOeFp0U2RGU2FCZkJRV0ljYUkz?=
 =?utf-8?B?UjhPMUJIeEpHaHp6dkNpTTBjWjRtbWNzZFo2WGl0amVKc1NZODRDZ2JpZmxn?=
 =?utf-8?B?NFUzcDZjWFdlYitNWmlpVGN1Wmo2R0FyRWR2V0JyU2NvamtnbHlmOWRxMEF2?=
 =?utf-8?B?R2p4U210TjRzd1E2M3FsaEkyREdNS1ZuZVpaUmxkM1ZjaC9keHpwNUxNSEd3?=
 =?utf-8?B?QVZ0T1YyTDVCUWxIUlp3U21XMmE4ZHdKdkE4TnRVVi9FUFcvMDV3dHM3VGJn?=
 =?utf-8?B?bDJ1SkFvWmVJWHlIOWdDdlh4c1NINEVleEZ3TEJyUkdVM0QrWUd6Q3JCeStF?=
 =?utf-8?B?aDM5dm5Zbm40OEZIQnRaNlRxcEI0VjZKUENaRFdkVWZidEtQT01oemM2d3Bl?=
 =?utf-8?B?Wit3Wjl2K2txL3hUOFBVd3BBQktxZjJ0bGFlcDRTcWVVR2x0VHM5ZjgrcHBu?=
 =?utf-8?B?cFNlZktOa2dhWDVFSzRoNDdXYm5XRkNjNnlobmlSZm1XVkpnVjMvdXlRNGw4?=
 =?utf-8?B?Slc1VnAvVU1UUUJtbEZSZEllZEhicTV4VDdMdHNCK2dQNlYvbGllSWxrTzQx?=
 =?utf-8?B?TkFZOXBMWWwyclU2WEQ3MWx2SzRmbis4ZFlLZTc4WHhwajZFZGIveWpCN0Jq?=
 =?utf-8?B?MGdYSGNlaEZDUmdwMEhvTUNYandkSjQwNk5pTEk5ZTJpZGNDRER1Rm1qTCtv?=
 =?utf-8?B?SmdpeE1SVE5oZ0VES2dGcFRyT04rOGkwQktlRllSVXpGZENHZk15clpMS054?=
 =?utf-8?B?Rjl3SFF6RUNSZUNublBMQnAyMGtEZGxIV2hWcDd5RU00d2tiVUJOa2FWQWZU?=
 =?utf-8?B?L0JGNjhrQ2NnMmJEMGRNZDNBNDdJa0tiOENWa2dsOGxia0F6OW5waitMKzhm?=
 =?utf-8?B?TURxcFdqNXVHSnVaclVoUE1GVDhBVTg5dWlSYWF4ZHpBMXRpSWVyTTQ3elQ1?=
 =?utf-8?B?UFFqNSthWW9LY0ZmdmJiNDVac2doVUYzRWFNSE1WSEFhWW5yRnp3YTJBOTZa?=
 =?utf-8?B?TWFVSDNLaFY1MklaWTMyaWc0M2ZjL2lZNG9RWHRzNTRWSlVTMUFkc3NGcm5a?=
 =?utf-8?B?T0o2UDl5MlQrZkhSanRjWTl3OTRhbFhhbjU2QVR5NDBQYU1nVFNETjA2OXc1?=
 =?utf-8?B?bFAwQ0Q4Q2RQWXhYUTNGSzJMeFF6dHVUZFdSQVhycU5iN09ENy9HN3E1Nitz?=
 =?utf-8?B?NFhlRlo0QldSWUZPeEpXT3VmaHo2RjYrYzVaOGwraTB3dis5WFhwenpoK21Y?=
 =?utf-8?B?UXdxK3NtZVF3cG1JYXRwaVlobHdYbEpHQlB3ODNrWW5nN2F2QXZmajZ5ZHh6?=
 =?utf-8?B?OUI0K001WjRLOGV3aE5xdXFNZzU3OVhqRko4Zkkxam5Ceks4NHU5VmJlUXFH?=
 =?utf-8?B?TzVMRkZwU2I2Z3Nkd2VjSXluak1hSEx0Y3FYUno0Z1BBak5LT3ltYmJWNm9n?=
 =?utf-8?B?V2xZMWswRk4yMng1c2lZbEp0ZC9ub2FSUytGa0M3SzlhUEpXWDdWT0xCSnMr?=
 =?utf-8?B?QUdObVNLamc4V3ZjRDNxQ2NqVmFyMzI4Y3hkelZ1VmlCMWxvMFg5aDlHRmZE?=
 =?utf-8?B?WHVpK2VscFlNQUNQY0FRdUMwOVhmQ1lLSGszZDhNdThESS96UU40a05nSjZ2?=
 =?utf-8?B?S29PYmdZS1ZYOEhndnBTTnpTTU11NndGNE5wWTRHekNlTDMxVzZQWExlRDk3?=
 =?utf-8?B?Y1BDTjJDSktYSkU4RTBKUDRwTndZZVMrU1ExM3pWT1RFdDFXRzlPd3hQR1hB?=
 =?utf-8?B?QlRweWRFS24zcW9leStQbjlORUc2cHBaZHBISlZ5VmtsVjZxTDRHdnNEanlU?=
 =?utf-8?B?ODZnTElDVHo2a01seG0vdGNvb3Fyc3AwZU5nYmJOVUxBTFFNSnl3dG1lb0RB?=
 =?utf-8?B?NU1DbnRGbFlnTHpJRVM4MjRHNm83VmE5TUcrYTBIangvbDYyaVpkU0poNzFm?=
 =?utf-8?B?VTNBWkkrNlI5cHFUOHVKakVFRFZEc2VLcGdYWERnSVN4TnBxeGhBY2RZblF6?=
 =?utf-8?B?VWY1enNpc1Q1ZStuVFB4Z0pETnhZT1J4UUtLVHRHTERoRXloTjVscDV4N002?=
 =?utf-8?B?L0FZZk5RS3JnMWJ4c3k0REY1OEovS05senpSQURscVZ1WWU4Mnk0UlpIOG1r?=
 =?utf-8?B?bVd6OXJueVhoV3JwMFRzWTdZNENyb3JpME9KN1N1SXdBYmhOQlMvL1ZwNkVC?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 112e4e61-661b-46cf-4015-08db0b41a341
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 08:34:34.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlTcoH1QgzuQWXGjdH3NGtsfRsoQDrnLcUdtmqeGS6/u1vvbaxRB+gmYAXPzrYWmgUDr+v7vP9VWtmV1eXqz8xdATyQZwle0J/bSv+zVa+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7310
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Feb 2023 08:34:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10634

--------------ms020502090801090605050905
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/10/23 09:29, Moessbauer, Felix (T CED INW-CN) wrote:
> On Fri, 2023-02-10 at 09:18 +0100, Gylstorff Quirin wrote:
>>
>>
>> On 2/10/23 07:44, Felix Moessbauer wrote:
>>> This patch registers the provided image classes via the
>>> bblayer.conf
>>> file. By that, no manual additions of these classes via kas is
>>> required
>>> and erronous implementations are detected early (e.g. mandatory
>>> inputs
>>> without defaults).
>>>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>>    conf/layer.conf | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/conf/layer.conf b/conf/layer.conf
>>> index 0c5fd39..2c888b2 100644
>>> --- a/conf/layer.conf
>>> +++ b/conf/layer.conf
>>> @@ -22,3 +22,5 @@ LAYERSERIES_COMPAT_cip-core = "next"
>>>
>>>    LAYERDIR_cip-core = "${LAYERDIR}"
>>>    LAYERDIR_cip-core[vardepvalue] = "isar-cip-core"
>>> +
>>> +IMAGE_CLASSES += "squashfs verity swupdate"
>> The Class swupdate is only available after patch 2 if I see it
>> correctly.
>> Quirin
> 
> Why do you think so? The swupdate class existed before. I just moved
> parts over to it, but the core logic has long been in the
> swupdate.bbclass.

swupdate.bbclass did not follow the pattern for IMAGE_CLASSES before 
patch 2. But this only nitpicking :-)

Quirin

> 
> Felix
> 

--------------ms020502090801090605050905
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
GTAwggdkMIIFTKADAgECAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEBCwUAMIGeMQsw
CQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQMA4GA1UE
CgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjMxHTAbBgNVBAsMFFNpZW1lbnMgVHJ1c3Qg
Q2VudGVyMScwJQYDVQQDDB5TaWVtZW5zIElzc3VpbmcgQ0EgRUUgRW5jIDIwMjAwHhcNMjEw
MjEwMDczNjM0WhcNMjQwMjEwMDczNjM0WjBlMREwDwYDVQQFEwhaMDAxMDhZVTEPMA0GA1UE
KhMGUXVpcmluMRIwEAYDVQQEEwlHeWxzdG9yZmYxEDAOBgNVBAoTB1NpZW1lbnMxGTAXBgNV
BAMTEEd5bHN0b3JmZiBRdWlyaW4wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCA
qN/x1wdiSvw0dSlpuclq8Fwi4S3ldLu4MdKANA3DfDb+nd5jbRSKI09GYII3iFV4YkNDUtlq
73VQoJX0udyZM8JoYQ5Z5HaOBNWcXTcjL48LKsZrKsk7UUP2FBn3/bR9VGslALN+8em+6qVr
ZDkxVfRl3xEMi5EgVtorSAIP/RfspM9XWb/WhZJCASsl4fY8+pOjrGxQnitRc6VYXwUZAM7r
L1qX0eLGwAnaa8b5OvNtAxE2VVkAjyTnE5NoiCnbsi6Q+zX3/Ai8zv4pqkbUsHNoLg+qzJsa
CdD5TtfpwNgJgdQfD6Z0F89b7Xg36G7KZllulvicX62fFqzwx2dlAgMBAAGjggLUMIIC0DA4
BgNVHSUEMTAvBggrBgEFBQcDBAYKKwYBBAGCNwoDBAYLKwYBBAGCNwoDBAEGCisGAQQBgjdD
AQEwHwYDVR0jBBgwFoAUtvmR44WfDDy2iXJTnkE0jXAq+b0wgfcGCCsGAQUFBwEBBIHqMIHn
MDIGCCsGAQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkIzLmNydDBB
BggrBgEFBQcwAoY1bGRhcDovL2FsLnNpZW1lbnMubmV0L0NOPVpaWlpaWkIzLEw9UEtJP2NB
Q2VydGlmaWNhdGUwSQYIKwYBBQUHMAKGPWxkYXA6Ly9hbC5zaWVtZW5zLmNvbS9DTj1aWlpa
WlpCMyxvPVRydXN0Y2VudGVyP2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9v
Y3NwLnNpZW1lbnMuY29tMEYGA1UdIAQ/MD0wOwYNKwYBBAGhaQcCAgMBAzAqMCgGCCsGAQUF
BwIBFhxodHRwczovL3d3dy5zaWVtZW5zLmNvbS9wa2kvMIHKBgNVHR8EgcIwgb8wgbyggbmg
gbaGJmh0dHA6Ly9jaC5zaWVtZW5zLmNvbS9wa2k/WlpaWlpaQjMuY3JshkFsZGFwOi8vY2wu
c2llbWVucy5uZXQvQ049WlpaWlpaQjMsTD1QS0k/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlz
dIZJbGRhcDovL2NsLnNpZW1lbnMuY29tL0NOPVpaWlpaWkIzLG89VHJ1c3RjZW50ZXI/Y2Vy
dGlmaWNhdGVSZXZvY2F0aW9uTGlzdDAdBgNVHQ4EFgQURT1zRzKUlh+WlA5LZInILLrGEJQw
DgYDVR0PAQH/BAQDAgQwMCcGA1UdEQQgMB6BHHF1aXJpbi5neWxzdG9yZmZAc2llbWVucy5j
b20wDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEALJcoEKoIAxLyJV+6HTpKciBe
E3w7ht2RSQjG/7EAgjf+kW0Nrp4TyrzteHR3A2sTmRJC2M7/DV763W93qPzPiinqtNlUEDte
KJlHBfr0OUio7i0RZqGvlCGPK1R6lu6e3n7NtApww6nPAveS95UuJnkYzO3gI0I2gUYqzTeJ
BYLxC++jZeO2Va1vSDnNjFUrcLoPrDeU6T3uLXrOF/3XMKlfiXIybQZoWPgNhVhu6N9lJAJ0
2eHQQVWeoaQKmoNuAki/YE1guHR+Rz9dyYa1vawjDNWX8z7wZzNq5c0riHbHYfDpYEfcfli5
/aQB1z3Zgz5SePHBkXMsf+jSrDJKAqmaSyhn4xFpxo8ZnJWQwDg1KbE33/bL0LpGMK7D6JmK
dk4s6t/717RYywFqBvBELzKYKnfQqSQy0AsuGOmrVKXlQXKc3IotXwreL6MOLuzGuNuPuXHi
NgZFiZC09CfWqlJFWTrIsLoT4KXoLqGOM7kjBDoEAaM+QAsy/aFPATsXv+KPfGcK8o5hziPY
g/HTh/c80ZPxq7H87VzCxgu20vxq5rMe6GUZTkTF2YKajVhFbFKp+bM+Uu8MOXZ6PNgsTmzL
8PqdrRK3TNT1S7v6wEQ/oeceSE6RDg6A89vg5QLWIAYMHt30IO/nTXgdL9uAcTuQLjmkWmiH
fWWqzhyrQVowggeEMIIFbKADAgECAhBavnHi3TH66Ts7d1icYK9VMA0GCSqGSIb3DQEBCwUA
MIGfMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEQ
MA4GA1UECgwHU2llbWVuczERMA8GA1UEBRMIWlpaWlpaQjIxHTAbBgNVBAsMFFNpZW1lbnMg
VHJ1c3QgQ2VudGVyMSgwJgYDVQQDDB9TaWVtZW5zIElzc3VpbmcgQ0EgRUUgQXV0aCAyMDIw
MB4XDTIxMDIxMDA3MzYyN1oXDTI0MDIxMDA3MzYyN1owZTERMA8GA1UEBRMIWjAwMTA4WVUx
DzANBgNVBCoTBlF1aXJpbjESMBAGA1UEBBMJR3lsc3RvcmZmMRAwDgYDVQQKEwdTaWVtZW5z
MRkwFwYDVQQDExBHeWxzdG9yZmYgUXVpcmluMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEAxtputBhOSIjdX+ZhaIzZXOkmsV3YBSNTrnA4MTG+TtL5wgss1pfH/YFV8CHLacVX
/cYnD09uaxevNSGV3rRLZF7A77gNl99BE8qqHPAXoB+/ZVQHzo3QdumqpqaO4bqTQYsk+jYC
eDEIlGyzDep9EAMdLK9jWoeYG68ayc6G062I0f8MUHC+oY3G14O454N487PcWj66UMh9zqGS
z0lk5AuGpC1xSks42Fs9TxNgLlh74UZPUZZWtp4+05eyyDay/kkuztI0jJmYMtg0ft7vGOuU
MzFVcxau7llvsv6z94ep/rmC0n+W0lQbTg9FEkeAE/ui/9uE5SqeMp4DSPk5MQIDAQABo4IC
8zCCAu8wKQYDVR0lBCIwIAYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICMB8GA1Ud
IwQYMBaAFNbv+6fnKrHAXUxohcItj1ZmfoLuMIH3BggrBgEFBQcBAQSB6jCB5zAyBggrBgEF
BQcwAoYmaHR0cDovL2FoLnNpZW1lbnMuY29tL3BraT9aWlpaWlpCMi5jcnQwQQYIKwYBBQUH
MAKGNWxkYXA6Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpCMixMPVBLST9jQUNlcnRpZmlj
YXRlMEkGCCsGAQUFBzAChj1sZGFwOi8vYWwuc2llbWVucy5jb20vQ049WlpaWlpaQjIsbz1U
cnVzdGNlbnRlcj9jQUNlcnRpZmljYXRlMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5zaWVt
ZW5zLmNvbTBGBgNVHSAEPzA9MDsGDSsGAQQBoWkHAgIDAQEwKjAoBggrBgEFBQcCARYcaHR0
cHM6Ly93d3cuc2llbWVucy5jb20vcGtpLzCBygYDVR0fBIHCMIG/MIG8oIG5oIG2hiZodHRw
Oi8vY2guc2llbWVucy5jb20vcGtpP1paWlpaWkIyLmNybIZBbGRhcDovL2NsLnNpZW1lbnMu
bmV0L0NOPVpaWlpaWkIyLEw9UEtJP2NlcnRpZmljYXRlUmV2b2NhdGlvbkxpc3SGSWxkYXA6
Ly9jbC5zaWVtZW5zLmNvbS9DTj1aWlpaWlpCMixvPVRydXN0Y2VudGVyP2NlcnRpZmljYXRl
UmV2b2NhdGlvbkxpc3QwHQYDVR0OBBYEFJc32FVWG9Weg/eke9wkqBgOTMDHMA4GA1UdDwEB
/wQEAwIHgDBVBgNVHREETjBMoCwGCisGAQQBgjcUAgOgHgwccXVpcmluLmd5bHN0b3JmZkBz
aWVtZW5zLmNvbYEccXVpcmluLmd5bHN0b3JmZkBzaWVtZW5zLmNvbTAMBgNVHRMBAf8EAjAA
MA0GCSqGSIb3DQEBCwUAA4ICAQCOXIgWGNMyJfE4Gbdgzqirk9am/SdeBV32YV5ZTNz43Zre
7Z3LRqtrhr09B+BfB/gfDcxAMwQctI15BwW90Yj7IveAf9/vWf3XPkUOLjc5Yicd4ABlWsvG
kZYK7UihD51ZYzDh3Weym8pp25LPLUA07M4+0s2J2RFxz0NqT9Ab0N9zqQKP4lCTM2nHh58+
2QUNlKGGyVG6cQkiZffWp260dL8sliUR96FMDHT55PYv6GoNOtUqA1rDpk4seZQFxDwBNW+E
E1DdKD3CXNMOyv4ZuUjjQvjhS1gleaVMxD+k1vTV4jFW0nnNX4uYCyT4KVdDlxtvs3xSVkZV
DWm2u+zo1biCfgGFtWb9ZfC2hv9GdOr14MJWONF3QDC4uINewUFdsAcD+nGab/7FiAIYNI2r
BDsih5BgMuWHIEJKGKWykFWkh6tjlkaEyWqdoFMpeVzd5wlp4fP/wZ7xg1OddBnhbYb1nCuC
xtYmQfSh9/Xp1u6WQMLYaQHvTULBVCeGzClFY4FPutT4pO7RS1F5L0GaFnjcIsiBp5I9ICAZ
PSdnIpShfEm47olJARhAx29FBN5JlisbzveSNBuNHS9QH5II0K7AClrOcATYO7hnxktvMh60
V4q0S6YD90WWkkRnwv7R3M9Zpohzs0kot3z0vsivYPDq+50h+kABUbjvO/x/bjCCCjwwgggk
oAMCAQICBGAcg7MwDQYJKoZIhvcNAQELBQAwgZkxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZC
YXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5zMREwDwYDVQQFEwha
WlpaWlpBMTEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxIjAgBgNVBAMMGVNpZW1l
bnMgUm9vdCBDQSBWMy4wIDIwMTYwHhcNMjAwNjI0MDk0NDU1WhcNMjYwNjI0MDk0NDU1WjCB
nzELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAO
BgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpaWlpaWkIyMR0wGwYDVQQLDBRTaWVtZW5zIFRy
dXN0IENlbnRlcjEoMCYGA1UEAwwfU2llbWVucyBJc3N1aW5nIENBIEVFIEF1dGggMjAyMDCC
AiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBAMoDusEPTAOAEOTwI7QkSd3bwzwKSgMb
uzXxUPaoYsEWCApzGe4ezh9ZZz00w9+lbkiSnuEkWuwX+FP50LLkgP1NUksigbwtsZ3dODeB
/H1GVg+5cV4oaWB3Rht5ePYFCROwskp4lUS6DGlunKc+t2NBkHesB0EWeiaJeZSJn0gAt2aj
FyEVP2wpwRHCaR/SjwmQPfCU1jqwuuU0+zS06ELRdS8rBiN0PXstS6Iboy+3jPpPlKnrtAum
jO2NTsfDBDt3q18+ZO48oKZENPda4FGfF0mxGP+0Xr0OII14W1bCMUwFEP/4UWlvFvtjpjUq
orhWV4bxJGe7E/oZ1nmmRn382sl+N3v2Ml/yyb59m7RChDRCm2QC2nvrzfi0hN6oPOa2VHZs
yqepMYHKJvBej2vk/twapZRsY43vbPztA51XFHcrdnJbsqH9RYqXVu4M275l0SN622V1vzsj
+kgMKXIxHfxT7jAl9v8HLFLTc+e9Bre29W1+wpw0d9qDbGGQYO+UN31TusMxpIhT1F5tLkeZ
wTLXUlFwA93cGTpArtn7XS03qCJ3E2IeUcwZydQOwH9FNTBIhUva0WXaefe2YofuefjC+Xox
FjvKzs1NeI8TarI2B1al9iruu2bzP72mS+jWdvk6KukQXEAtrlfaMLc+TmseQGmOxpD29HPK
dphnAgMBAAGjggSCMIIEfjCB+AYIKwYBBQUHAQEEgeswgegwQQYIKwYBBQUHMAKGNWxkYXA6
Ly9hbC5zaWVtZW5zLm5ldC9DTj1aWlpaWlpBMSxMPVBLST9jQUNlcnRpZmljYXRlMDIGCCsG
AQUFBzAChiZodHRwOi8vYWguc2llbWVucy5jb20vcGtpP1paWlpaWkExLmNydDBKBggrBgEF
BQcwAoY+bGRhcDovL2FsLnNpZW1lbnMuY29tL3VpZD1aWlpaWlpBMSxvPVRydXN0Y2VudGVy
P2NBQ2VydGlmaWNhdGUwIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLnNpZW1lbnMuY29tMB8G
A1UdIwQYMBaAFHBtoFDsqdAsZ50ZFf79BHM1w+LUMBIGA1UdEwEB/wQIMAYBAf8CAQAwggIc
BgNVHSAEggITMIICDzA1BggrBgEEAaFpBzApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNp
ZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCATApMCcGCCsGAQUFBwIBFhtodHRwOi8v
d3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMBATApMCcGCCsGAQUFBwIBFhto
dHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgQBATApMCcGCCsGAQUF
BwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMCAjApMCcG
CCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGhaQcCAgMB
AjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wOgYNKwYBBAGh
aQcCAgQBAjApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8wNwYK
KwYBBAGhaQcCBTApMCcGCCsGAQUFBwIBFhtodHRwOi8vd3d3LnNpZW1lbnMuY29tL3BraS8w
NQYIKwYBBAGhaWMwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5zaWVtZW5zLmNvbS9wa2kv
MIHHBgNVHR8Egb8wgbwwgbmggbaggbOGP2xkYXA6Ly9jbC5zaWVtZW5zLm5ldC9DTj1aWlpa
WlpBMSxMPVBLST9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdIYmaHR0cDovL2NoLnNpZW1lbnMu
Y29tL3BraT9aWlpaWlpBMS5jcmyGSGxkYXA6Ly9jbC5zaWVtZW5zLmNvbS91aWQ9WlpaWlpa
QTEsbz1UcnVzdGNlbnRlcj9hdXRob3JpdHlSZXZvY2F0aW9uTGlzdDAzBgNVHSUELDAqBggr
BgEFBQcDAgYIKwYBBQUHAwQGCisGAQQBgjcUAgIGCCsGAQUFBwMJMA4GA1UdDwEB/wQEAwIB
BjAdBgNVHQ4EFgQU1u/7p+cqscBdTGiFwi2PVmZ+gu4wDQYJKoZIhvcNAQELBQADggIBAFAr
jdme0uraRt5tKTzku+CORk9YnWvp+waEbNw3rQfUuuosObdJNmOMD/j9zv0lTELANwSNRP7Y
jhwyrWDycV80FbhK9EsIUh3frSCc1sbd3/9eGzkMsgSuY60GIHydwsZQe9JFyRDCCO+Rfz2G
Xu+wKh8ENQti6w4U2ygQw2aqtIsFQVQDczqjisfNBkGVSJyp9yXxa2JOrEOjddx5yHf1pVTU
2kNPah3licDQoZ0mCZxyluULJw3RKOWjl9P8A2VpIAPqbeJgaWor+/BzkzvtQ3yaJB5PPGlD
2GFQNJRcNUpQdpDs7cAUkwToikr3ygGVUgImfHghnDDZaYG0twxefqA8+h9lDckAHI+c0VMC
DMt4TAn6bFohAcIpvtafQ+L/+k5hXaBKv//k+ESHakvZud2DAKxw4bssHoc1F/Sse5kGOsbS
O+Ht3igs7vVY6coaYXY0VmMscrJUJtlfySCvNmDpxcJnxxj9P+/h2hzXiQPfjinEj7P6jNQI
2O7Cik2TPY5XLVNGjz5xQrEFLMDyKIwNLdghRLhzMSn/PYo5bqasZ/W982lSGGOErw1XpKVM
sRCyuzWZ1q3sQRd6uJioIiUmj7/V/wHFh4kpvao4oEcQ2NS8NVEBIMRt9qt9XEjVXWWiHVhd
ZCuH/Dy0Im4oK1++s1MjHl5Hd5LqtrtKMYIESzCCBEcCAQEwgbQwgZ8xCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMRAwDgYDVQQKDAdTaWVtZW5z
MREwDwYDVQQFEwhaWlpaWlpCMjEdMBsGA1UECwwUU2llbWVucyBUcnVzdCBDZW50ZXIxKDAm
BgNVBAMMH1NpZW1lbnMgSXNzdWluZyBDQSBFRSBBdXRoIDIwMjACEFq+ceLdMfrpOzt3WJxg
r1UwDQYJYIZIAWUDBAIBBQCgggJnMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTIzMDIxMDA4MzQyNlowLwYJKoZIhvcNAQkEMSIEILLS8wfrgoH7BIFdYtHn
p+WpZdtZn5eNmGADPyXBSHFoMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgcQGCSsGAQQBgjcQBDGBtjCBszCBnjELMAkGA1UEBhMC
REUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1l
bnMxETAPBgNVBAUTCFpaWlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEn
MCUGA1UEAwweU2llbWVucyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM0
6383MIHGBgsqhkiG9w0BCRACCzGBtqCBszCBnjELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJh
eWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpa
WlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEnMCUGA1UEAwweU2llbWVu
cyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEB
AQUABIIBAAD6qz8F8DdioygqVhF1/wvTywvuuMb4vHXJXn/qrVY8xBwaNGDdcqAVLq/BWLVc
rJUbEkuZK6BWxWlbMUfVYHWh4uE8mEnQhhQSLP9zrfT4x0CyzJrmEHNydWNzy7MAFNQpswhP
x5dy0x7HQnhtiZQD/6ZyYfNNtf0VNz10hsWo5+ijflThSvTwNBTYu5nsiIwNJENlcoNdjR0/
6SLwQFOYrv1hs/zFa3Va7UwX2ZKRG7IvekSx1Zk2kWieGL1Dx0mtaEqDYWhuBs+Nu7/3QaYF
sFOhXCmTYmWY5gzq4KVtg6SPaKSZb2mausEwcqNTety/NenRqoZMy2/8z4+fyPAAAAAAAAA=

--------------ms020502090801090605050905--

