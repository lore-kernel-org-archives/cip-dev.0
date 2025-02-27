Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48622C19F2E
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 14:57:00 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.82])
 by mx.groups.io with SMTP id smtpd.web10.12454.1740668209905342641
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 06:56:50 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FEAKPG4j;
 spf=pass (domain: siemens.com, ip: 40.107.241.82, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xoJoqzP5NnSZ6iSkvgKa/FrnAxrUqToLBaE+et1kS8wyj9806S0kv3fj5kxB52ywCrKe36QPhe8G7NKDICWc2FY+kUSOWz/QB17LP0hg1f65M5aGrSwhDQLeCmLkKyX0Z2RNPuAKipgfnqS9OB0XjLjibdnb11T16oWwShdJA8YWH/TQFhppUY9/Q/GChyiUpGE57f2DwGQ/zmoUphV2JBTH4REkzvS4ylqNQI0uGq0CWYLyzh9zPv9ej6RLdmb9WBP7xbx48aJEcThlUfwEhaOC+wIE13lRL6Ahe1dKo1lEXcD3MtZjLztdMlQyUm6rvDcRTBKlliMu5FU1fdRk6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=delz1Au/IzZUxf5ffkbs77TX3BqBVe7rwYh25mlYNeM=;
 b=D/+v28TH/5f2XTJ98wfcJRKYQxwgdlEljWflPC75xoklJaZQXgHpkuFTHpAsz/knO2CE9ytHHOByoWkFrbwlz8QxKh/JHPji2PRfNjLRBrJXafogxEF1SuqFQRLzMHlGg/+zLhf5jQBsMd/fiLki5ZGHatMYo7qQlZeyzUE/ouQm2v0wYfXO+fCwGB+xSyq3Smm980QUxRv/w92Zdtmq1suVlt/YkSIILub0JkXQoHk7eAn5TIr0e5u3H75zoN/LsHTdt0Xez+rkHsmn46QFidENm56ytTESYrN6C1GPonnnRv2am3zizE3CdybIib6WkMrPHuvbe+ElzMKoNgyRvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=delz1Au/IzZUxf5ffkbs77TX3BqBVe7rwYh25mlYNeM=;
 b=FEAKPG4j5tB3fc2tKzYlxqS5IHeoheV1JyKOb8pCpbiadV15MtwS0wKlFIqojHWBkmtpq+F2wCBPDVvCU+H/y0EmYYZNKvBXA9ulHdoYC+nGuqgBW3vA71McqkTlYuyNfXPZQl1S1UeTYjmazL1Xtd9uYeIHkz3rQBmrT5FvsfT4ufJ9cuCa7VJYGFPqFpShIIb+4ZYmeuaCXThGzLX51v3af4HEIcjJd4FzOjM54Yle4A5D7y9SrS9NB6YTowA3EAztWa6y6HCy77yeHSfx6cgQFiloY20NCmSRKAYY1d35rD/I1EqWy1eHRJmF8XexGwbiSeVWkwjcOqF2i61N+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AM9PR10MB4054.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Thu, 27 Feb
 2025 14:56:46 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 14:56:46 +0000
Message-ID: <533e3699-7ad7-4f5e-82f8-d69a075a7b11@siemens.com>
Date: Thu, 27 Feb 2025 15:56:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] initramfs-crypt-hook: add re-encryption recovery
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org,
 Jan Kiszka <jan.kiszka@siemens.com>
References: <20250227143022.323950-1-ch@denx.de>
 <20250227143022.323950-5-ch@denx.de>
 <8f3bbc52-69e3-4187-a229-8d9356b22fd0@siemens.com>
 <49f3a657-5c55-41bd-be89-5f40ffb0e87a@denx.de>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <49f3a657-5c55-41bd-be89-5f40ffb0e87a@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:610:32::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AM9PR10MB4054:EE_
X-MS-Office365-Filtering-Correlation-Id: 7be919ab-f108-43a3-b583-08dd573ef4e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1bb7vXudzHWPYZy9clGwk++frUm7In5qkIuazHKC0xdwMfg+gddPDNVaGHLT?=
 =?us-ascii?Q?L3KVCUkNzMY/kQ3mYwjYllkPl4gzr4EA1E1KR0hiuxHOYHnnbRQpFlX/UdWI?=
 =?us-ascii?Q?XD1jK7OQVYC0tNU1hNl7bCAlru0LclGF/A/ujLw9VoTSjEEqG0jhyaaqPwFI?=
 =?us-ascii?Q?iIajuNRgoVl9Hh18qkGaLYgHcwt+wpELa3HQRH8KfxgdVDD/hwtCIA5m1nLa?=
 =?us-ascii?Q?0r6kSnVShwahC9/M0j7PQxwOK6hOtLFJLqx/CC20ED5+9mir5j5ydSTgFq49?=
 =?us-ascii?Q?9edU+uvONRZgB3cKjHNg/fC6iKou2Kvy5EOU2Uglzl9Ojf7KZIc4ofuI16pb?=
 =?us-ascii?Q?RmTfY1foYxXmgubiZJOus+CG+tXz6QgTwz5ojijU6ADRXisbmH67xMHFk1g6?=
 =?us-ascii?Q?58xKcg6NA5oCtUN+sJMY908YqgCqlCnPD56IbfPQKQWxG3RVRNWPrfOf1flZ?=
 =?us-ascii?Q?uOYs9PL7575CI2H3YfUwRPnsVjlc9NBrnctHXAmJX4egm87HUX9i6RsTFe65?=
 =?us-ascii?Q?p4pUjcCOU41L4ZMgP5o60WCHDz8GEKMCtt9LaKBBiNkxipcFBI2MZxUJ+UH1?=
 =?us-ascii?Q?hamWzXeckSa0jWfOqahMfvOPj/ZORRFMDvUEgbZT0Ej3DIRvn1ZVn8P8Atwq?=
 =?us-ascii?Q?5tLazYm3+otBKVGVt5n2fzUJf1yWL0H+j/mALP8VTcDyBZEfcwhQ6lYp6lm6?=
 =?us-ascii?Q?t03W6Rstfnaa4bZCzB15YaCRNYsLi0JkRIK4/vLMa+fjLZS8zNY6iwHyMgSA?=
 =?us-ascii?Q?28pzVjuhiYLiwReXbtz/+2Ri4FGLUL9hSsi42oWFBydXNMFeub52Slhk1MpQ?=
 =?us-ascii?Q?Dnd8k2CH26XowidtaqLZa4xancJH1CTm4JTLAjgNVKT8Yy0Ccpu2H8BzBbYF?=
 =?us-ascii?Q?2HWA/vBUH1FW67SXvup8XM9BI17sP6Pv6ZKF87iRSNAIJlRoOwOL4LEeeWEn?=
 =?us-ascii?Q?esfdWxaYfY9rP0WejJoVWhpgQB21ewNn4rQIpVHp9TQoGXXv4WkupXvQEKdn?=
 =?us-ascii?Q?On3MPZPe9v11DIG1iVCObhc3zp3MncGwky1g4vOdIO5n9tyPrPrH9CFBaXiR?=
 =?us-ascii?Q?6S/Wtg4KpTKu80n9z6nic6e5DKybdb1UsTS5gXtobQRswrAsHtW6VKYX+zXN?=
 =?us-ascii?Q?2HGD31al4Qa7z3rBE0MEG6jwA+BuddZcARDaFVDwRt3e0pCcTrlm2tPxsfm+?=
 =?us-ascii?Q?QOuGae94G3+fM4EaVztagWrAtVqS5STcBqJnznCp1kVhEjYOnZxEYbfxwjuZ?=
 =?us-ascii?Q?xIYxBylHB1lkUzxVw73nzZR2Lq74DtJxEayxEEh0aiPZMiu34OHz5ux5HAsk?=
 =?us-ascii?Q?Vut5DgqFKaKFtFWeGsIKOtPt5roIfHxDOi/rPsStLnjutEppI6D5jlH8InB6?=
 =?us-ascii?Q?R7uO+CU/VZjjN0JwiAT9p0StrG+W?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h/mgtbuFlwzpu4RGB3KANdLRbDMWPS30H2q5jhn+k6mYAxr9Qs73/OiQMm6N?=
 =?us-ascii?Q?VZjnplCdROUxPZ+l+MOIihG2G1yqdwyz1HSL1fwBIBcHmufjXOUPvi7zhhHM?=
 =?us-ascii?Q?tvUSuPViVZjBQ1APHSm/lmFCLeK8w65tchjJwCZcbuFH1IVKgCIRUJSJt409?=
 =?us-ascii?Q?ugBi0PkU3HEJuuEhSyPkEO3WiaxTCSCUxnzYyV4HMJv8b8bUCVZrgeACfRmV?=
 =?us-ascii?Q?kjU+yyf4cTt4UjnHa9U5rOlWr7OtF6mbCMfMt83FskUnM7faZHo1huje5Xro?=
 =?us-ascii?Q?Sy4+KG2PyyvDur8xFXap9/1aF1DPQ2AvVxFpmL5vnUDvWlZeih+Tg8fEpWGe?=
 =?us-ascii?Q?grbvIpPhrLmTwzxSlNwmDQsM+yTrtx4Hz30A/Bke0/y02ADETdUfpxJnWkTI?=
 =?us-ascii?Q?56alTIPUnmH9hgbS260DhmwkCAmLGmuA4FFpxX3KT4ikGxoyDIs5xT3neaYa?=
 =?us-ascii?Q?+6JP5s7O+0le+YgSzT+AXVTbk9gpB8n75eMdbCm2XAHxDDcxYt9R4wq/Dekh?=
 =?us-ascii?Q?cKAbRlyq9YL7yP5M3LCFf7JHyNipdr+SxVP68la5mlCvPpRdTFUUt0NxBVWf?=
 =?us-ascii?Q?Qh7HYOK+4gws2QQwQbMTCenq1e4c66nWEp5sqQ+xxQJLpyaRSKfHzkRmAbLL?=
 =?us-ascii?Q?x6cF1dbB8E8T8BxiivVUpg+EbPMwwFDX9srprZUvfOex2yy00kczt3KzMEJb?=
 =?us-ascii?Q?G6TbrQYQyPEYQ8bCaBuCZHuo6DbzxPMCvHuzgPfTQVHFaHQ5a6y4bsgmTqCP?=
 =?us-ascii?Q?Ey8AOGwErxAqyIbDp8fypCzLgGihHC6tWFSMyi1l+MyCFfl0M/UQvpS2uynj?=
 =?us-ascii?Q?Gx3HDuZS3WapuoHnyhem1oe7CPF7bH1jRV2Y1AZht8GA1b5BVHBF3f9fs9vq?=
 =?us-ascii?Q?s5CWLPbi7UuOB7Pgxs6bqbSYTIPRPxHavhrHoL+UNRl3l9TpBUffq/rQ6RY4?=
 =?us-ascii?Q?4XdFuWfSu/Q0HvsuLLGBJpA2rHVdye7fJSlgf+BiodM/PRr9A5wXZ9gSa1OQ?=
 =?us-ascii?Q?iVPbrVXsM6T1maDvPIl4P84rXxWfUNdlQzzKeVM7RWvY2YLhz8tgzVAG28EU?=
 =?us-ascii?Q?/TSscUAnj+S9gbpHcgT6s0n+fmJ8hHGGnPIHOYs8sCtP9mn9FRZgsufClJ/5?=
 =?us-ascii?Q?chBGLSSB6zzbku8TQ1arBXpju63ZHjNf38Ma1AIlRMdIAN5Sug4cCsee9Nc7?=
 =?us-ascii?Q?Bs6997qOgdMkkTmhUDCupC4+Wb8KFAetumwDhlWCRO1dJVNiJm6GN17vKaHV?=
 =?us-ascii?Q?flWhgkVRBhTvs65xVa1BKxWrzcemftVVhzeNP76VcKv/0nV6bDEpOpmYLatn?=
 =?us-ascii?Q?+K7FIwFJzeG6qryLQHbKX0n2U4T7+llvXjnM9+HyqLpFkqsUW+ke2guH3N6c?=
 =?us-ascii?Q?Hl7n/2X2EQxzCspagAEfW8LYrsF0FMuc+KUbdFMBHd5joOMkeVIjevn7jf+K?=
 =?us-ascii?Q?H9NZY4y5s3U2XNlGdEjwIC0c06ycVLT5Y5rR3TSSkosLOMvnL51u8BTm1w/8?=
 =?us-ascii?Q?8yEzrBmw8Nc2XC3GAxnLY4ERXPXkWiPfNH+Ub/jXzZwqsq+eNdXl+B6WKRs2?=
 =?us-ascii?Q?Dvn8nfUmW4ODzNYp33MDsTD1aeznHZvb/YxZUX2xTK/tcbQQ+5WPR8l0QvhB?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be919ab-f108-43a3-b583-08dd573ef4e5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 14:56:46.5880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AgqQuxy09+D/lQEUWENtIQLpgPk+WYYs4xOVLQZOZ/MR5SCCmGOfdEG5/u/foUkKEfCPqHNrI4VW4pMh+R9WPV2RFpkfa3GN0gF3J59Y1pM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4054
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 14:57:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17950



On 2/27/25 15:46, Claudius Heine wrote:
> Hi Quirin,
>=20
> On 2025-02-27 3:37 pm, Quirin Gylstorff wrote:
>>
>>
>> On 2/27/25 15:30, Claudius Heine wrote:
>>> Integrate detection and recovery of power failures while a partition is
>>> being encrypted.
>>>
>>> There are possible scenarios:
>>> 1. Power-fail happens while the partition is reencrypted:
>>> =C2=A0=C2=A0 - The LUKS header contains `online-reencrypt-v2` and needs=
 to be
>>> =C2=A0=C2=A0=C2=A0=C2=A0 repaired with `cryptsetup repair` before it ca=
n continue.
>>> =C2=A0=C2=A0 - Also no resizing of the file system is necessary
>>> 2. Power-fail happens before the systemd-tpm2 token can be installed
>>> =C2=A0=C2=A0 - The LUKS header does not contain 'systemd-tpm2', thus it=
 needs=20
>>> to be
>>> =C2=A0=C2=A0=C2=A0=C2=A0 registered and the temporary encryption key ne=
eds to be removed
>>>
>>> In both scenarios the system after the reboot needs to have access to
>>> the temporary encryption key that was initially used. So using a random
>>> one, generated via `openssl rand` is not possible. Since it is only a
>>> temporary key and gets removed after the systemd-tpm2 token was
>>> installed, a known password can be used.
>>>
>>> The list of these scenarios is not complete, there might be other
>>> instances where a sudden power-fail could be fatal to the system, but
>>> these where the most obvious and risky ones.
>>>
>>> Signed-off-by: Claudius Heine <ch@denx.de>
>>> ---
>>> =C2=A0 .../files/local-top-complete=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 33 +++=
++++++++++++----
>>> =C2=A0 .../initramfs-crypt-hook_0.6.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++-
>>> =C2=A0 2 files changed, 29 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>>> complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-=20
>>> complete
>>> index 4b6451a..6034175 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
>>> @@ -72,6 +72,9 @@ reencrypt_existing_partition() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size=3D"$(expr "$part_size_block=
s" - 65536 )"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_byte=3D"$(expr "$reduced=
_size" \* 512)"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reduced_size_in_kb=3D"$(expr "$reduced_s=
ize_in_byte" / 1024)K"
>>> +
>>> +=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D"--reduce-device-size ${reduce_=
device_size}k"
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case $partition_fstype in
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ext*)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # reduce the fil=
esystem and partition by 32M to fit the=20
>>> LUKS header
>>> @@ -90,14 +93,25 @@ reencrypt_existing_partition() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 squashfs|swap|erofs|"")
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 [ "$debug" =3D "=
y" ] && echo "skip disk resize as it is not=20
>>> supported or unnecessary for fstype: '$partition_fstype'"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> +=C2=A0=C2=A0=C2=A0 luks)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Check if reencrypt was ab=
orted
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luk=
sDump --batch-mode "$1" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | grep -q "online-reencrypt-v2"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /us=
r/sbin/cryptsetup repair --batch-mode "$1" < "$2" || \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 panic "cryptsetup repair was not successful"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # already luks partition, d=
on't resize
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CRYPTSETUP_PARAMS=3D""
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "cannot re=
size partition, unsupported fstype:=20
>>> '$partition_fstype'"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 esac
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -x /usr/sbin/cryptsetup-reencrypt ]=
; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-reencr=
ypt --new --reduce-device-size=20
>>> "$reduce_device_size"k "$1" < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup-reencr=
ypt --new ${CRYPTSETUP_PARAMS}=20
>>> "$1" < "$2"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup reencr=
ypt --encrypt --reduce-device-=20
>>> size "$reduce_device_size"k "$1" < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/sbin/cryptsetup reencr=
ypt --encrypt=20
>>> ${CRYPTSETUP_PARAMS} "$1" < "$2"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> =C2=A0 }
>>> @@ -219,7 +233,7 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition is already encrypted, dec=
rypt and continue with=20
>>> next partition:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 decrypted_part=3D/dev/mapper/"$crypt_mou=
nt_name"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch=
-mode "$part_device" \
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | g=
rep -q "luks2"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | g=
rep -q "systemd-tpm2"; then
>> This should break encryption with clevis.
>=20
> I don't have a test setup for clevis, so any input on how to fix this,=20
> would be great.


If you set `CRYPT_BACKEND =3D "clevis" ` in the kas configuration of=20
isar-cip-core. You directly use clevis instead of systemd.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes=
-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.bb?ref_type=3Dhead=
s#L25

Quirin
>=20
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 open_tpm2_partit=
ion "$part_device" "$crypt_mount_name"=20
>>> "$tpm_device"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # check if we ar=
e trying to mount root, set ROOT to=20
>>> decrypted partition:
>>> @@ -230,6 +244,12 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> +=C2=A0=C2=A0=C2=A0 # If partition contains an aborted reencrypt luks h=
eader, switch=20
>>> to reencrypt mode:
>>> +=C2=A0=C2=A0=C2=A0 if /usr/sbin/cryptsetup luksDump --batch-mode "${pa=
rt_device}" \
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | g=
rep -q "online-reencrypt-v2"; then
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 partition_format=3D"reencry=
pt"
>>> +=C2=A0=C2=A0=C2=A0 fi
>>> +
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # If partition should not be encrypted, =
continue with next=20
>>> partition:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ "$partition_format" =3D "noencrypt"=
 ]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 then
>>> @@ -247,10 +267,11 @@ for partition_set in $partition_sets; do
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 watchdog_pid=3D$=
!
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>> -=C2=A0=C2=A0=C2=A0 # create random password for initial encryption
>>> -=C2=A0=C2=A0=C2=A0 # this will be dropped after reboot
>>> +=C2=A0=C2=A0=C2=A0 # use partuuid of the partition for initial encrypt=
ion password,=20
>>> this key
>>> +=C2=A0=C2=A0=C2=A0 # will be removed after the reencryption has finish=
ed and the=20
>>> TPM2 token is
>>> +=C2=A0=C2=A0=C2=A0 # registered:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tmp_key=3D/tmp/"$(basename "$part_device=
")-lukskey"
>>> -=C2=A0=C2=A0=C2=A0 openssl rand -base64 32 > "$tmp_key"
>>> +=C2=A0=C2=A0=C2=A0 lsblk -no partuuid "$part_device" > "$tmp_key"
>>
>> This has the security implication that until the tpm key is used the=20
>> device is insecure.
>=20
> Yes. As I noted in the commit message.
>=20
> The other method, I thought about was using the tpm2, where I am=20
> encrypting a known key, like the partuuid with an internal tpm2 key, and=
=20
> using the resulting encrypted blob as a hexstring for the password.
>=20
> But I am not very familiar with TPM2 on how to properly do that.
>=20
> Other options would be to create a password and store it in the TPM2=20
> NVRAM, but that would not be very secure as well.
>=20
> So any suggestions for improvment here would be great.
>=20
> regards,
> Claudius
>=20
>>
>> Quirin
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case "${partition_format}" in
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "reencrypt")
>>> diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-=20
>>> hook_0.6.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-=20
>>> hook_0.6.bb
>>> index c9a7f89..5e82521 100644
>>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.b=
b
>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.6.b=
b
>>> @@ -14,7 +14,6 @@ require recipes-initramfs/initramfs-hook/hook.inc
>>> =C2=A0 DEBIAN_DEPENDS .=3D ", \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cryptsetup, \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 awk, \
>>> -=C2=A0=C2=A0=C2=A0 openssl, \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 e2fsprogs, \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2-tools, \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 coreutils, \
>>> @@ -40,8 +39,8 @@ HOOK_ADD_MODULES =3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ecb aes_generic xts"
>>> =C2=A0 HOOK_COPY_EXECS =3D " \
>>> -=C2=A0=C2=A0=C2=A0 openssl mke2fs grep awk expr seq sleep basename uui=
dparse=20
>>> mountpoint \
>>> -=C2=A0=C2=A0=C2=A0 e2fsck resize2fs cryptsetup cmp \
>>> +=C2=A0=C2=A0=C2=A0 mke2fs grep awk expr seq sleep basename uuidparse m=
ountpoint \
>>> +=C2=A0=C2=A0=C2=A0 e2fsck resize2fs cryptsetup cmp lsblk \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm2_pcrread tpm2_testparms tpm2_flushco=
ntext \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /usr/lib/*/libgcc_s.so.1"
>>
>=20


