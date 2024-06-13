Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087E0C27C4F
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 16:44:15 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.76])
 by mx.groups.io with SMTP id smtpd.web11.13634.1718297044524179359
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 09:44:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Ouuncr05;
 spf=pass (domain: siemens.com, ip: 40.107.7.76, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXljACipzUFCqUNk+/wYNcX4JhR/VUrsZ2bPnltM+v5S95PMLM7MLRJ6xAPNjkwR2+vKthXj/vy0l/lMra9BCE4sioZpt7MwS0L1Bs2SzDKk/B1rXa6rBFA/g2pHQIywnLYNmicL+7ZOFJfoDIWm8CKZoMABUx8tk2XRGk0hkLR74xSZb8BItQkf9WaYIwn9YxOhoI2wvogYSoZPrVSauPp52LSzeWQEMbEMuALM56bBAcjUus7/q+kz+xoYmOq1diVdqpjXI0BSbCTp0xS2hE/qOLcwW/yGwaMjdJSW4AM4qboflk94dMSlatPuCQ4XT1uVUuYXo+oz5nsBgtFBEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lgnZscUMHPFGBp2X1KGapzJ1b75TtM3Izb+iw98mYiQ=;
 b=fcFOFdPMdWSU2w70P+OKWbdY1hCsoeTSV/Cw7W5NNMFX/LUCUwE6Ad3Brsr/jTYzi87GfawYMqs9mQuki5NdaAbFxC5RkYn1tFQWidCsKxCOD5LgkpswaqOpHEFkPf2kbswDenusqNqJOOwKC6ww1YM3an1Qsse+PG8pcnn6WcVuDGMeCI0wan6HnMqwPo+k54PDAS569FIsvZOAVfLSAh7Kr0Udf5pB8Xlngx5Q+E6U4hBy1WVW0EwTH87XwRzTqBssY4sRSzRwNSLKK+zP73bAHNlL8uZqMVZ5IJNy2OolZrHrF5No18VkbJ93LjLchZikvvuRZWseYzYP3C0YDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lgnZscUMHPFGBp2X1KGapzJ1b75TtM3Izb+iw98mYiQ=;
 b=Ouuncr05W3EyO/B8DkwEhYpiQT4eeiGU2oX4p7XHY4XWaEmmcKrmA8kWp4/U1njKpsq5umef9VYpUFyPFdjd0/B6Lmbd6McfuOqP67hMZH8WAOsQRjow4Bt+3vr3eJjdTGmMI+c+2RbSr5lWV1lrxf8dmKQtl5d7KVBHh93ZVZp1vDjStoS4N7AUsaYgH/dXrLBxzF9P10nQBnqDC0zPrGHkk1RWCgNpIjjp+sYoTKRr4GSfDgSGx+74WfpOuxIICdmdNuJjYYtPaf/WLiBbBYzhsl1xK1f833IV2qrkut+AMJERA9uQcsXV5niaqZBUcQ89xeux6Zz2FV8ZOiZKNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 16:44:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7633.037; Thu, 13 Jun 2024
 16:44:00 +0000
Message-ID: <e996f229-9710-4b10-9820-3a743ed41bfb@siemens.com>
Date: Thu, 13 Jun 2024 18:43:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 0/2] wic ebg plugins support
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0065.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6747:EE_
X-MS-Office365-Filtering-Correlation-Id: 656d087d-f390-489c-c761-08dc8bc80716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WFhLQ2VVSUxvR29iUllsREFoS1dpbHo4VTZ1ZnEyQTZOaHRtVGFJMHl4cUZx?=
 =?utf-8?B?ZWFIQW1wWTYwK3J1SEVzM0ZHUGZvY1JzNURBVXp3MGFrTkswa3BreVhkMkJv?=
 =?utf-8?B?UXRQRytZRmo3cFl6YXJQc1BmS2VDMTJHd2tUd1BiMjMvL0ZSZW9mSmltWlg3?=
 =?utf-8?B?TWViRzhRSVh3d0wrQW5oZ0ZNV2NkV1IyOGxCd0V1a1hPbUhEOU1zR2ZpdEFl?=
 =?utf-8?B?WUw5TGNSak5vOU1JWjJJQXlibk5OZ3p4bSt3MEJ1a0VXbDRWYU1ENkJtNEQr?=
 =?utf-8?B?bEE2SEswWlRDaDRGU2N0YTB4amR4dWtwK2RuWk5HZ3U0VE1WbmJIVDFRMWQ0?=
 =?utf-8?B?R1lZVFhjU3V4T3JsaUN0bS9UU2ladkIwOE9aWTlmZDErOTZiTzhpdE1CRnlO?=
 =?utf-8?B?S2FLUVFMTFJiMDZtUTk5azlUZ09RelpNM0dDMjBraHR1emYwUVRUOWlHUERG?=
 =?utf-8?B?TC9WVnpwa0c2aTMycWV5dHhCSGNJRjRCK1YydUNKZE43cjJndG9FNUE2UlBj?=
 =?utf-8?B?OUlmUzRodCtmVU5tZE1aN1BxbnZPR3dZbE96akViZ081MzZxUE9CVTcxUTc4?=
 =?utf-8?B?emV4a21JQy9CS1Rlb0hGZGJ6eU1GcDk4d2UxUGV1R1FaeTRjNzVoNEplVnI5?=
 =?utf-8?B?S0lKWCsxODNoY0Z1Ym9TMHZGZ28xVEcxTW1KRy81NnlFd3V2eVp3L2dTWnFt?=
 =?utf-8?B?cTRkd2dCZmFYZGhWM2JzYmdBT3lyMnZpVU1WUmdpS3ZVU0g1OEl4M1EwZytI?=
 =?utf-8?B?eVFHMXhsdXpWRS8yK0EwemJ0T0xNSldzOUlNSmVqRHZKRTJiM2N5M2dCazJJ?=
 =?utf-8?B?bktIUDJITHBnS3VQbnpvY05qZFdmNzlrU2JnMGtKVWxla3FheVlwdTJiY3dQ?=
 =?utf-8?B?RDhRb3gzWHE5UzRJUG9oV2oyTUhlc1BNd1JNYVZ4VzlGaElVMU9Hb1lkbWZy?=
 =?utf-8?B?bU5NMnNjR0taRjFTemt3a0gzSTQ5MmJQdHlob0h5Y0NqSFpmOVlKZFozKzdF?=
 =?utf-8?B?U1Jub05OcnQ4UTgrZ2VLZnRsUHRtY3NKeXUxZDVVN0Fha1hac3BTbkdHRDZm?=
 =?utf-8?B?VWlBZEd2MGJ1eGVJYm5VVW5HcFVvN28rTnp5eitaS1VHK1kyc3ZOeXdSSnAw?=
 =?utf-8?B?eEtiaVFRbzlmbVFMT3hvUU5rd3hDR2crbmpPTnM3V21jNXRkQWtpY016ZVM4?=
 =?utf-8?B?OEVtRGJ1RmdZOHc3V1d6MGdzcElhampWdHU1S2g1b3ZTeE8xSHgrc3dUdmNQ?=
 =?utf-8?B?aHZ5WGpzVm9sZHZ3d1EvUDhid1JYaEYxbUtONXVoc1NYQWFCWXd3ZmxwazZj?=
 =?utf-8?B?VkdkSnl5cmtsTVhXcXR5SENKbFd5Mkd1UE1rRm95d0hEOHRqcHZnRnNaZ2JY?=
 =?utf-8?B?NWVCdTkrY1R6RTNsTEtVY0sySk92MkZXVUN6bkxDTkt2SjUxTmtycEVXVkFa?=
 =?utf-8?B?eGI0a1krZ0IyUmsvc0l4RzA5UmlPT1htRnI1NDd2L0hKdXZpUGs4enNrcGJB?=
 =?utf-8?B?QUFSZGdOdlJ2Rm9EcFdCMjE0TDJTNUN6bnVPa25mVVJ3ZFZhNDR5elVucVBu?=
 =?utf-8?B?OG1id1piUEovY1ZRUmpONWRmcEpsZWFpR3BqdThybk9WUlErc0lmNDlQSVl3?=
 =?utf-8?B?OTdLc3lmc21kRjFXNkVLcUhXcENkKzhoRFJSOUZkeVFva2VYalRwMzRxWEEw?=
 =?utf-8?B?WGQvSUxJUjJFdEdkaUxHTmM5MnEvOGpJZDRsTkZnSml4YlZJQTBqR0V2YU9j?=
 =?utf-8?Q?2ZnNoS7k9TCYq1FCbyW3AS5s/z0FlHzH9ZqkQln?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NFJxb1RVVHpjc3JNeks5U2lWWVRQS2xYRFcwVlEyT1NXRjloY0thRllMYmdD?=
 =?utf-8?B?WU1ielBZMkZ2L2kxMGxrYVV6OW5nSUV3Tis3TjRYY01QQklXY0IyRjZNb0pw?=
 =?utf-8?B?bVpVaFZ3ejhOaE9mL0EzekkwdVI2RVo4c0tZUUpIeFlRK3ZTeG84UmpOTTIy?=
 =?utf-8?B?S05aS2xJTkJDUk8yMVdUVi93YWFTaEFxa0VhSUFabE9qRjd2VUZxUW4zeUI3?=
 =?utf-8?B?cmQxRTNxN0twY2V4ek9mVnpGVmREcldKbU1zQ3VTTmFpbG1OQlBybCs5dllM?=
 =?utf-8?B?MDF5QzBBcDl3MHlQNTJMNzIrZWN6dzRScjR3bTRCazRSSTFjQk1rdko0M3o4?=
 =?utf-8?B?Q0d3dk5TMC9nd2c4MGpUUzg5THJ5blU3TW1XcHEvUDF4cmZuQlJRNGEwdXpD?=
 =?utf-8?B?a0x4UThmYlBvZ2NzS3BEZXF5bHBiNkJWUzdaR0E5dlpDWVVFVzFQbGRYMFNY?=
 =?utf-8?B?S2h2TUZJS2Q1aGpGQmllRExPaEUwMSt5QStNa0hLZ0dJZWRIT3B5eXpsUDUw?=
 =?utf-8?B?ajlwZWhjWXdqdUJtc1BrSmdiRDJmQmZTSkVUODlRYVZKZDg1cjRkTnFGdVk2?=
 =?utf-8?B?d1R5dlNoT29vcWszS2ZmSUErSnJjbDYzQWtHUEpJeVJ4OEZ6bkRVdGpYNEhv?=
 =?utf-8?B?cHZmYjZ6VlRpLzc4eHFZOFgwV2MwYXBycHUzT1VDdlZyWjhKR2tRbHRTeGRQ?=
 =?utf-8?B?OTF2MW96blBWaHVoemFlVzBrNWdkbWlPZitRRnU3YVQ2L2laTmRJQTNZZTZK?=
 =?utf-8?B?Y0NzMTBTTWNITXFVU1hlamNkSWhwUlJmSnY2c2ZNbHdyazZybkhSQXpsT2xq?=
 =?utf-8?B?NVVBendPYkdQdVdTdFZkK0pGWEZUaUdiSHJUR1NBQlFvREhncFB4VlpvbTRn?=
 =?utf-8?B?bVp3Wi9jQUY5ZWdsVC9MdHRpZ3lqZmRIS0hxRm5MUU50b2RZNUN5MDBvR2E3?=
 =?utf-8?B?SzlLQ0htZXB1ZU5QaHhJUmJFeVhMMm85RU5VeEpRU0ZUODJ1N0dadjdEYXpk?=
 =?utf-8?B?NTRJNUYxVmt1K0UxUzFoeWlsQ09GWXJ4K05NTEtmVklLaERLM1pydEtLays4?=
 =?utf-8?B?b2ZwZ1Y2c0txMkxEN2xuTzYzMkp3VE8yTzMvUkE5SThUaHRVWHRidllqWW4r?=
 =?utf-8?B?REdWL1ozMnFNUmZxQWZRU1lxOFVoaE9Ja3pXeHMrYU1lRlp1QjJsK0daSFFj?=
 =?utf-8?B?bDNod0Z3ejV6SzVJOGpuSitVOU8rdkJ2YlplVUxYK1o3U0J0OEhWK2hOQmRm?=
 =?utf-8?B?UlQyOWE3WlVUaXRpN3M3bzg1SHVZVkNMUGlQclpac2xCa3NKRlRTbTJqUFlk?=
 =?utf-8?B?NzZwenlMc013MUpyL2w5WHRJdGJ5MlkwdkZ3ZnFvTkhBVWgvNSsxaHhOWWdI?=
 =?utf-8?B?S20wVmUzOU5iclZJT2J5N1QxN2d0UVI3TlZibmIveEdRdldwRWloZDM5bjJp?=
 =?utf-8?B?VHgvQkdPSGw3bk85VFV3bFpVQ3ArQVNQNEhBN21jNWhlcUU4bFk4MUQ2b2tB?=
 =?utf-8?B?RVluTnpyMW80TnZpVlM2eWlzSGV2SXF4Nk9EaG9qZ29BemNmVDY0V2pzR092?=
 =?utf-8?B?MFdET2lQVVh2T2ZLc1VkdVRVU2lpSWpPcFpGQ2tTYytidmp0UDRXOVJUamNi?=
 =?utf-8?B?b3JqV2hNK3M2TlUrRm96V2Jld0EzVjRpRUo5OUNGcXMzbEE5RVZ3ZmJGK1FI?=
 =?utf-8?B?emxuNExmK2hIT0E4WGJ5TEUyRkttZXBuOWYxYnlpOVJBWVRFYWhPR29qSm1x?=
 =?utf-8?B?MXdyYVB1YkMxZWhOTUQ1eVloYVNaSTVQV3Bja2g1YmdZSDJmQkN6YzN1V1c5?=
 =?utf-8?B?RkJrQWcveThGQTFRZjZrakV0TlFtRllkVi9aWWdCRWZnMFk2OTQ5YUROU0t4?=
 =?utf-8?B?UmRvNDRVcWcyRG5YVHgvT2licElaRUdZem9zR1ZXK1NmcEZQRFBiMnJYdHVl?=
 =?utf-8?B?dm1XT1lvQUMvb3RPdTFNV0ZPOCtiM3dEQXRieVZSTnBnNjRVcGZlWkpGZzNJ?=
 =?utf-8?B?RzBvOEg3QmR5TEpScFM3eTVCSCtVdEJvUkdPaWJwTXlGM2UyVTZSdTBzT1dj?=
 =?utf-8?B?YWdTMGljaGt4VVVFcklIMGQzQlRnT045ajhvUWc1VDdDWHVRY0VzNjdkSEwz?=
 =?utf-8?B?VXRJRmxvcHRDNmhrV2RZenA1clNoVjM1dlNITlFqQ0hGek9aMWlZVmdBUSs1?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 656d087d-f390-489c-c761-08dc8bc80716
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 16:44:00.9200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7fvmU5vg0CVUIQgRBtYfwzRNPZZP6ot2l195b3YqDxKB213Lsoo2eaQql9siY5LfD8jNsgMj0wl9z7OIVUEmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 16:44:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16221

On 13.06.24 11:16, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This refactors the wic plugins for efibootguard to take the wks
> parameter `--size` and `--fixed-size` correct into account.
> 
> It will also fix the following sporadic build error by increasing the
> boot partition sizes.
> ```
>  INFO: sign with script /usr/bin/sign_secure_image.sh
>  ERROR: _exec_cmd: export PATH=//sbin://usr/sbin://usr/bin://usr/bin/None://bin:None:$PATH;mcopy -i /tmp/cip-core-image-security-cip-core-bookworm-qemu-arm64.wic/tmp.wic.yo_hrfgu/BOOT0.2.img -s /tmp/cip-core-image-security-cip-core-bookworm-qemu-arm64.wic/tmp.wic.yo_hrfgu/disk/BOOT0.2/* ::/ returned '1' instead of 0
>  output: Disk full
> ```
> 
> Changes v4:
>  - use the fixed-size partition parameter instead of size for the
>    ebg-sysparts.inc files and increase the size of the partitions
> Changes v3:
>  - remove unnecesary setting of FAT-Size(-F) and sector size(-S 512)
>    the sector size default is 512 and as FAT size should be caluclate
>    according to the partition size.
> Changes v2:
>  - replace size calculation with part.prepare_rootfs_msdos
> 
> Quirin Gylstorff (2):
>   wic/plugins/efibootguard*: Take --size and --fixed-size into account
>   wic/ebg*sysparts.inc increase the size of the boot partitions
> 
>  .../wic/plugins/source/efibootguard-boot.py   | 34 ++++---------------
>  .../wic/plugins/source/efibootguard-efi.py    | 30 ++--------------
>  wic/ebg-signed-sysparts.inc                   |  6 ++--
>  wic/ebg-sysparts.inc                          |  6 ++--
>  4 files changed, 15 insertions(+), 61 deletions(-)
> 

Thanks, applied, just in revers ordering to avoid that adding the first
fix makes the problem that the second one fixes non-sporadic.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


