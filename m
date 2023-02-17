Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF60C6379F
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 15:20:54 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.51])
 by mx.groups.io with SMTP id smtpd.web10.8906.1676647244648577247
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 07:20:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pE5TMOkW;
 spf=pass (domain: siemens.com, ip: 40.107.21.51, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oKr8ph1R7kMb4APyX04QvIzOqfFQFAHLms4L8GkpKgsimzpD8LHWhmoSf5JygGfgObxjJJrHQgizAoCxxHfOv/iHY+OVcfYj7no4XV3r2sgKnN/GoZx2H62LG9q2ma/wA+d7T6bQBkbAdQmBDeqsxY5VQesK+B235D6G3Vo/hwrjzDfaTIu0eCGp9a92BHRy25iVgB0JgYQ58ilgzPLszdu5dcCnci3uwJlifk+2zSUZz1BAyCsgWiIUnESZzSJa3d3eIJApWj+QBGnVHgErxhcBdn6fttx8lUx2SykkJ7n5TA60uf/zXtjGIdxbCQYkYLGM3YqLf/K4QgoHt+Uddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jy9diO2xXiQsUws8ikxS9kcsGvg5MfBwtXo1FOPdBLk=;
 b=kxlILvwfM40gqW15g7b0DnGi3RoivC9TpUEEWtuaWPasZQqAOV0480NTEtlL/N8D3wmseTigncjXUbzXk5qlw4+Jy6EmHLlfEuKpm0tfNayO8toE4elizp++gR0moDLlzinDJoF5cIU1eq3RdA0xhYuTk1ixqIY+tdzA3CPjK2SEEUwfEq02Tkihwo90O8qTjOiiCGGx7CxISbRYpaAPttNwezDMMHujuDzxvXhvz1wirypzaw0cgnI4b/aqNU/fJaMqbZS7GOxC1L3Q+sxc+A5QaRTA8CZn0XXZNep/ZkvIumBVBYeTOpn85pIAh5urrQOXujYF+drkfIUNJhQ3Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jy9diO2xXiQsUws8ikxS9kcsGvg5MfBwtXo1FOPdBLk=;
 b=pE5TMOkWSCEor3wKm2rGT/tUHg+FMhIX9zLXHJH8bHblNWBhRSFy5OogSVmw7NgCaqHoIOOaZ51p9/j85ZlWfMg8oE5Nl38i9S/B7ne/43g1y6IW52VlADk7AWJRNMbe0pQ7aYbdDHR/NNhgNkLuN+9OFYr1umRmoETkZSOmByMb9u8l+gVInJwDBmlNnvWVyEPnY72Z8B3TIlsb8Q3d7VjUDwN2YAnBqPlwpVV0qLsD1P4/rSi26EhG1V39TKE+WSfFTxTD7r9xd4ZMiYhjIA3pZWsDQjvGv/w/H9MDML4QjykHQWVfvezqL5v2fOm/6QJ6wVWkqacsVtksjYydMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PR3PR10MB3788.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Fri, 17 Feb
 2023 15:20:41 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%5]) with mapi id 15.20.6111.015; Fri, 17 Feb 2023
 15:20:41 +0000
Message-ID: <eead43b4-520d-aeb2-ba5b-e46d965306be@siemens.com>
Date: Fri, 17 Feb 2023 16:20:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][RFC v2 4/7] Add initramfs hook to
 encrypt a partition
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 christian.storm@siemens.com
References: <20230217130540.509910-1-Quirin.Gylstorff@siemens.com>
 <20230217130540.509910-5-Quirin.Gylstorff@siemens.com>
 <2012e77d-1892-1797-3161-b834ccebda86@siemens.com>
 <00766d63-d1cc-c792-c5bd-8c7d4a3778d4@siemens.com>
 <eed2cb77-0980-58e2-5dcd-7a3414a0531c@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <eed2cb77-0980-58e2-5dcd-7a3414a0531c@siemens.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090300070504070500070101"
X-ClientProxiedBy: FR0P281CA0048.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PR3PR10MB3788:EE_
X-MS-Office365-Filtering-Correlation-Id: 75db07c6-d9fa-4348-81af-08db10fa87cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pg9w/dL+mfTcLpju34oPoJ/LlDvnzJGICmr/382F6H3runhZ/6dOjOsSH+hFfropVG3NF8nV48m5NqmrbFspnZ9PvCSZxp07WPow7a31lIk4Qr4hL8e8szS+2n2AJTQhtakrLGdEk8IIq8SSihLioNe6xUFvBY4nKig95tULzjbNad4mvO9/7qFs55GeSZMsRWUGc56JmIrAi1CvB9wMS4iCx1iWJfvxpzv0Ol4JErVA7AUzeE2j8oESaK0WRdLYDOjwqwb/IqvheX/dN2achz4/2Y+7aC3x+4NNH2GG0jp0dIrFseEANDdsSZ0AEKNvWk7S5cMYRBjjM5xSGxY4wM76JDF0K/g30G7Pd3zp4t7PjCWL3Lqe6txAghD2yNqhYifP+kBN+whF8ae++3/2DcvGwm0F9KZCOlUhtpYzg/9LsP0+73KR1GVar6qqCSCAVpQA2qbpQ2OxDOmjH1EuMLoi3HF3ZP2guwS8kZ8/qeA8oqvqagtpk5qTZxRAUTD1MkVhpLmbqkKFviINrQE4nPJYytWz1tGGn72cthBkdpcdksJ599jWIsYYZhQeBijZ1fC0HVuBsRsFnVasEyEKpO76pzjjhgZbTtq78I4ghq6uMiUZgzSGpdULcK7ax4S734wR+KEO1NcV3TKJwh8pV8jljsfuplHXgqe8cnKQZ3TMEn53rDz9u2v0vE8d6Oy3Seg8F8e8VRdcL4y08zi/J3D1PtSdfasJlfal7uYirbMd0+MZJn6ax1LDS1wj0+oalXxBkUBkTos5A/Dk8vDpXQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199018)(6512007)(2616005)(186003)(26005)(38100700002)(2906002)(6486002)(36756003)(82960400001)(31686004)(6506007)(33964004)(478600001)(53546011)(86362001)(31696002)(83380400001)(235185007)(41300700001)(5660300002)(316002)(30864003)(6636002)(66556008)(8676002)(66946007)(66476007)(6666004)(8936002)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZUNUK2RUUnVvNGNSUm1UbHNubW92a01ob0p2YmxVSEw2em1YdFBoZG1PdDBh?=
 =?utf-8?B?eVZLM2ZqN0duT295NmdoWlV2UzR0ZG8yNlE5K3pEWGlxYnFFaXlxdjYxeVdZ?=
 =?utf-8?B?TmUrMmU2d21wNk1waDVVVjJJaWpYdDRqejJLVGc1blltMzdzeE1OSHlMaElC?=
 =?utf-8?B?ZWRzVlRlYW9SRDk1aGNRVkFmNFBsaDdxZHhzS0JLVTl0VDV0U1g3UXdRVHY3?=
 =?utf-8?B?RWZVVkpmb2tVOVVwQmVzYlBhNUR3dFFwczAyRXNVMzR6aS9hT0MzNXVyTlk4?=
 =?utf-8?B?blNxRlhmRG40N0Z2b0RpYmI5bnBndDNnVldTRHVHRUZJaVJSNGl5R1hLNWZo?=
 =?utf-8?B?ZDRkNTQzZUFIMjFCS05Sa2dJU0pVbXVlU0IzT2xDYTlyMFJhSnNZQ3VRb3BT?=
 =?utf-8?B?RldvZnBzS1o4cktVVVRIZStReDhpcld1RnR5ZkZtQWQyckF3bXhnYjlBeHJD?=
 =?utf-8?B?a2MxWmc1RGNiT0JPck1yRW5wNkJ2c3cvRUFkNHJkNmdUSVhTVkdnNGs1NjB3?=
 =?utf-8?B?V2h4VW8yMWlqZ1RKNXBDcERibTBNZituM2R3TTZnd1VsR1l5Y3lRME9zSkZS?=
 =?utf-8?B?QThZTXZBQkpzenpsZ0xMcHE4bTRDVEY3dnZXKytkMG5PdUlPK3ZXUFgrQkxl?=
 =?utf-8?B?ckZ2eU1zM3J5K3J2SFVVRXo5RHlMSXJDUkNBRFVtam92blNWM2VWTDRrQ1Rr?=
 =?utf-8?B?VlVlSWtCNVdIRXBKT2JNbVVZSGRIK2RwTHNaSGhkdlV2OUtveCtUUXArdUEy?=
 =?utf-8?B?WVppOTdqck1JRkhFczVHbG8zeW5STkljQnRUS2krQWxtVUh0eFBzdkxRRE5D?=
 =?utf-8?B?bWZ6OEE1Nm9aTWxJeGJwdTNBTEVFd0dpZmc2RndIaHd1WXFLZWYvVXQxeVQz?=
 =?utf-8?B?TVBVQzlKazEzWURHMnJqR3pRNmlybUJFbEt0emM5bXZZTFcwL0RFeGlOYmRo?=
 =?utf-8?B?dnFKVGgwUFZaaGJqQUswNVJVYTFucXdUaHd4dDJwMUc2L1kyNzZacHYwaTZ1?=
 =?utf-8?B?REl1Yk96TmxKbXhwbERDOXBSNHQyWEIremlXU1JmSGtuRUZVRmhCLzZlaG1U?=
 =?utf-8?B?VE1MVVBwYVdFRzhWT256bVZPWmlzZmVKc3lpL0tvSGFTWERGcHNaSjh4UmhO?=
 =?utf-8?B?UWtKUEh6U2I3UDlkRE12OG1RUWdveTF2N2lBYk9jN0RwcmlzUm9zQlZQMzNo?=
 =?utf-8?B?UTlBcjhQRnJ3dHpGcVlzVytJZThPMm5WZzI1bjBVUFhsdSswWGF2OVVuWW1B?=
 =?utf-8?B?Mzl1WmJtS01VMld5SXdqSDlIVmdEbTc5ZDE3VU1LTDUydm5GWk5NWkFMVG1z?=
 =?utf-8?B?dTJ2SmxtdzBYRDFvbHpUdjE4NmdiaEc4cjlEU253d3dta0toZU1XR0xJcEw5?=
 =?utf-8?B?WUlHd0hNcDByeXllNXNSUm0rWnpBVlc1bnI5ZlhUWkNiaERxY3B5OUZZNFBp?=
 =?utf-8?B?bXdZWmo3UWFLS3Nyd2hSZDlxOTgyQkd3b25CaG05RnJ4d1E5QXVlQW50dytK?=
 =?utf-8?B?L3JySWNZVnZjZWxOKzFEWmJhRjNNSkVDUVR4K1pSU1l6dDVsSkdHZkw1Tmx3?=
 =?utf-8?B?b3dCYjRpVWNYVEgzbUtURkxrTXZGK1ljcjBsVVM2VHp2RERrVThBY1JBSDlK?=
 =?utf-8?B?c1ZjZ0dvaExpaGh3RG02Y1liVTExV1BJenFIdTRuUFRCNExMcnFJUVRHV25J?=
 =?utf-8?B?T3dXQmhqOWUzYUl5MjFkU3NJYjR0aUhRaVo3NmdyRHRYMzNIMldnVWFxNGgv?=
 =?utf-8?B?d01xeXVYSDNRaEJQM1h2bi9ySUZ1MHR3dURlcHZkdHk5YS9kWkhYZDBOaEdt?=
 =?utf-8?B?NlZrM2xyc2xjT3FWZTVJeHcwcHZQVzJWNlp5ak5CQUI2MitmWWpZSnd0d0Nq?=
 =?utf-8?B?TlBhaFRwSGV0Zmxvd0czVDFvcitzQlg3eHlkQ0VVbllEb1M0aUZxTG9RT09J?=
 =?utf-8?B?ZTZZb2JjODVSU2hLcFllS0pJK0tzVGxGdGh3L3RIQmw3M0Y5ZFR4OS9GdkRK?=
 =?utf-8?B?cW45RG5BZGN1OTd5WmE3Tnl1TlBud2o0MTRpUWkwTDVPSHpwMjl3WWdoNzhv?=
 =?utf-8?B?WXA5K1BWZ2hqekxRcXRQUWpPRDIyM0s0VkoxTkg2MGl2bmZqUXFPUTBWVEtw?=
 =?utf-8?B?UFZEZnd5NGlzU3lrMWdLYzVrUFhYRXoxSFNyUEdyU2ZQQ3FNbjdheHdZZS9Z?=
 =?utf-8?B?dlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75db07c6-d9fa-4348-81af-08db10fa87cb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 15:20:41.2467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CcFpLNCLAN8bPJRkw2tQPa04fWsmte5felzbd+tHboQK+acPMbs6HkLea00Qv59pgNEFOx8MI6HfsXnO36qQFc5GVzEm8PsJE8je0wpDsEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3788
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 15:20:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10729

--------------ms090300070504070500070101
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/17/23 16:10, Jan Kiszka wrote:
> On 17.02.23 16:06, Gylstorff Quirin wrote:
>>
>>
>> On 2/17/23 15:53, Jan Kiszka wrote:
>>> On 17.02.23 14:05, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This creates a new luks encrypted ext4 partition with a the
>>>> key stored in the tpm2.
>>>>
>>>> The initial key is randomly generated and removed from the
>>>> LUKS partition. Therefore a new key cannot be added by the user
>>>> and if the LUKS header is corrupted the data is no longer readable.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>    .../files/encrypt_partition.env.tmpl          |   2 +
>>>>    .../files/encrypt_partition.hook              |  49 +++++++
>>>>    .../files/encrypt_partition.script            | 135 ++++++++++++++++++
>>>>    .../initramfs-crypt-hook_0.1.bb               |  37 +++++
>>>>    wic/x86-efibootguard.wks.in                   |   4 +-
>>>>    5 files changed, 225 insertions(+), 2 deletions(-)
>>>>    create mode 100644
>>>> recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>>>    create mode 100644
>>>> recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>>>    create mode 100644
>>>> recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>>>>    create mode 100644
>>>> recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>>>
>>>> diff --git
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>>> new file mode 100644
>>>> index 0000000..943fe4b
>>>> --- /dev/null
>>>> +++
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.env.tmpl
>>>> @@ -0,0 +1,2 @@
>>>> +PARTITIONS="${CRYPT_PARTITIONS}"
>>>> +REDUDUCE_DEVICE_SIZE="${CRYPT_REDUDUCE_DEVICE_SIZE}"
>>>
>>> Did you mean "REDUCE"?
>> That was my intenion will fix it in v3.
>>>
>>> And what is this variable for?
>>
>> If you use online reencryption on a populated partition you need to
>> create the space for the LUKS header. The necessary minimum size is 32MB.
>> As an alternative you can detach the LUKS header.
>>
> 
> And what does this variable contribute to that?

This variable is used to set the size by with cryptsetup reencrypt 
reduces the partition size.

Currently I am not sure if we need to adjust this size during the build 
or not.

Quirin

> 
>>
>>>
>>>> diff --git
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>>> new file mode 100644
>>>> index 0000000..96e084a
>>>> --- /dev/null
>>>> +++
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.hook
>>>> @@ -0,0 +1,49 @@
>>>> +#!/bin/sh
>>>> +# Copyright (C) Siemens AG, 2020-2022
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +
>>>> +PREREQ=""
>>>> +
>>>> +prereqs()
>>>> +{
>>>> +     echo "$PREREQ"
>>>> +}
>>>> +
>>>> +case $1 in
>>>> +prereqs)
>>>> +     prereqs
>>>> +     exit 0
>>>> +     ;;
>>>> +esac
>>>> +
>>>> +. /usr/share/initramfs-tools/scripts/functions
>>>> +. /usr/share/initramfs-tools/hook-functions
>>>> +
>>>> +manual_add_modules tpm
>>>> +manual_add_modules tpm_tis_core
>>>> +manual_add_modules tpm_tis
>>>> +manual_add_modules tpm_crb
>>>> +manual_add_modules dm_mod
>>>> +manual_add_modules dm_crypt
>>>> +
>>>> +copy_exec /usr/bin/openssl
>>>> +copy_exec /usr/sbin/mke2fs
>>>> +copy_exec /usr/bin/grep
>>>> +copy_exec /usr/bin/awk
>>>> +copy_exec /usr/bin/expr
>>>> +copy_exec /usr/sbin/e2fsck
>>>> +copy_exec /usr/sbin/resize2fs
>>>> +copy_exec /usr/sbin/cryptsetup
>>>> +copy_exec /usr/bin/systemd-cryptenroll
>>>> +copy_exec /usr/lib/systemd/systemd-cryptsetup
>>>> +
>>>> +if [ -x cryptsetup-reencrypt ]; then
>>>> +    copy_exec /usr/sbin/cryptsetup-reencrypt
>>>> +fi
>>>> +
>>>> +for _LIBRARY in /usr/lib/*/libtss2*; do
>>>> +    copy_exec "$_LIBRARY"
>>>> +done
>>>> +
>>>> +copy_file library /usr/share/encrypt_partition/encrypt_partition.env
>>>> /usr/share/encrypt_partition/encrypt_partition.env
>>>> diff --git
>>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>>>> new file mode 100644
>>>> index 0000000..e58794e
>>>> --- /dev/null
>>>> +++
>>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.script
>>>> @@ -0,0 +1,135 @@
>>>> +#!/bin/sh
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2023
>>>> +#
>>>> +# Authors:
>>>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +prereqs()
>>>> +{
>>>> +    # Make sure that this script is run last in local-top
>>>> +    local req
>>>> +    for req in "${0%/*}"/*; do
>>>> +        script="${req##*/}"
>>>> +        if [ "$script" != "${0##*/}" ]; then
>>>> +            printf '%s\n' "$script"
>>>> +        fi
>>>> +    done
>>>> +}
>>>> +case $1 in
>>>> +prereqs)
>>>> +    prereqs
>>>> +    exit 0
>>>> +    ;;
>>>> +esac
>>>> +
>>>> +. /scripts/functions
>>>> +
>>>> +# get configuration variables
>>>> +. /usr/share/encrypt_partition/encrypt_partition.env
>>>> +
>>>> +# load necessary kernel modules:
>>>> +modprobe tpm_tis
>>>> +modprobe tpm_crb
>>>> +
>>>> +# fixed tpm device or do we need to find it
>>>> +tpm_device=/dev/tpmrm0
>>>> +partition_sets="$PARTITIONS"
>>>> +
>>>> +open_tpm2_partition() {
>>>> +    if ! /usr/lib/systemd/systemd-cryptsetup attach
>>>> "$crypt_mount_name" \
>>>> +         "$1" - tpm2-device="$tpm_device"; then
>>>> +        panic "Can't decrypt '$1' !"
>>>> +    fi
>>>> +}
>>>> +
>>>> +enroll_tpm2_token() {
>>>> +    #check systemd version and export password if necessary
>>>> +    if [ -x /usr/bin/systemd-cryptenroll ]; then
>>>
>>> And if that file does not exist? No error? No bail-out?
>>>
>>
>> I will remove that check and move it to the hook and fail during build
>> time. Is that better?
> 
> I just want to avoid that a realistic error leads to improper error
> handling. Even worse if that could lead to a usable but unencrypted
> partition.
> 
>>
>>>> +        systemd_version=$(systemd-cryptenroll --version | \
>>>> +                              awk -F " " 'NR==1{print $2 }')
>>>> +        #check systemd version and export password if necessary
>>>> +        if [ "$systemd_version" -ge "251" ]; then
>>>> +            PASSWORD=$(cat "$2" )
>>>> +            export PASSWORD
>>>> +            /usr/bin/systemd-cryptenroll --tpm2-device="$tpm_device" \
>>>> +                                         --tpm2-pcrs=7 "$1"
>>>> +            PASSWORD=
>>>> +        else
>>>> +            panic "Unknown systemd version: '$systemd_version'!"
>>>> +        fi
>>>> +    fi
>>>> +}
>>>> +
>>>> +reencrypt_existing_partition() {
>>>> +    part_device=$(readlink -f "$partition")
>>>> +    part_size_blocks=$(cat /sys/class/block/"$(awk -v
>>>> dev=$part_device 'BEGIN{split(dev,a,"/"); print a[3]}' )"/size)
>>>> +    reduced_size=$(expr $part_size_blocks - 65536 )
>>>> +    reduced_size_in_byte=$(expr $reduced_size \* 512)
>>>> +    reduced_size_in_kb=$(expr $reduced_size_in_byte / 1024)K
>>>> +    resize2fs "$1" "$reduced_size_in_kb"
>>>> +    if [ -x cryptsetup-reencrypt ]; then
>>>> +        /usr/sbin/cryptsetup-reencrypt --new --reduce-device-size
>>>> "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>>>> +    else
>>>> +        /usr/sbin/cryptsetup reencrypt --encrypt
>>>> --reduce-device-size "${REDUDUCE_DEVICE_SIZE}" $1 < $2
>>>> +    fi
>>>> +
>>>> +}
>>>> +
>>>> +
>>>
>>> One newline should be enough here.
>> Will fix in v3.
>>
>>>
>>>> +if [ ! -e "$tpm_device" ]; then
>>>> +    panic "tpm device '$tpm_device' does not exists - cannot create
>>>> a encrypted device!"
>>>> +fi
>>>> +
>>>> +for partition_set in $partition_sets; do
>>>> +    partition_label=$(awk -v var=$partition_set
>>>> 'BEGIN{split(var,a,":"); print a[1]}')
>>>> +    partition_mountpoint=$(awk -v var=$partition_set
>>>> 'BEGIN{split(var,a,":"); print a[2]}')
>>>> +    partition_format=$(awk -v var=$partition_set
>>>> 'BEGIN{split(var,a,":"); print a[3]}')
>>>> +    partition=/dev/disk/by-partlabel/$partition_label
>>>> +    crypt_mount_name="encrypted_$partition_label"
>>>> +    decrypted_part=/dev/mapper/"$crypt_mount_name"
>>>> +
>>>> +    # check if partition is already encrypted with systemd-tpm2
>>>> +    if /usr/sbin/cryptsetup luksDump --batch-mode "$partition" \
>>>> +            | grep -q "systemd-tpm2"; then
>>>> +        open_tpm2_partition "$partition"
>>>> +        if ! mount -t $(get_fstype "${decrypted_part}")
>>>> "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>>>> +            panic "Can't mount encrypted partition
>>>> '${decrypted_part}'!"
>>>> +        fi
>>>> +        continue
>>>> +    fi
>>>> +
>>>> +    # create random password for initial encryption
>>>> +    # this will be dropped after reboot
>>>> +    tmp_key=/tmp/"$partition_label-lukskey"
>>>> +    openssl rand -base64 32 > "$tmp_key"
>>>> +
>>>> +    case "${partition_format}" in
>>>> +        "reencrypt")
>>>> +            reencrypt_existing_partition "$partition" "$tmp_key"
>>>> +            enroll_tpm2_token "$partition" "$tmp_key"
>>>> +            open_tpm2_partition "$partition"
>>>> +        ;;
>>>> +        "format")
>>>> +            /usr/sbin/cryptsetup luksFormat --batch-mode \
>>>> +                                 --type luks2 "$partition" < "$tmp_key"
>>>> +            enroll_tpm2_token "$partition" "$tmp_key"
>>>> +            open_tpm2_partition_tpm2_partition "$partition"
>>>> +            mke2fs -t ext4 "${decrypted_part}"
>>>
>>> We likely want to make this line configurable at recipe-level, both
>>> regarding fs options as well as the fs type itself.
>>
>> I will add an additional field to the configuration string.
>>
>>>
>>>> +        ;;
>>>> +        *)
>>>> +            panic "Unknown value ${partition_format}. Cannot create
>>>> a encrypted partition !"
>>>> +         ;;
>>>> +    esac
>>>> +
>>>> +    if ! mount -t $(get_fstype "${decrypted_part}")
>>>> "${decrypted_part}" "${rootmnt}${partition_mountpoint}"; then
>>>> +        panic "Can't mount encrypted partition '${decrypted_part}'!"
>>>> +    fi
>>>> +
>>>> +    # delete initial key
>>>> +    # afterwards no new keys can be enrolled
>>>> +    /usr/bin/systemd-cryptenroll "$partition" --wipe-slot=0
>>>> +done
>>>> diff --git
>>>> a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>>> b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>>> new file mode 100644
>>>> index 0000000..ba2b884
>>>> --- /dev/null
>>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
>>>> @@ -0,0 +1,37 @@
>>>> +#
>>>> +# CIP Core, generic profile
>>>> +#
>>>> +# Copyright (c) Siemens AG, 2020-2022
>>>> +#
>>>> +# Authors:
>>>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> +#
>>>> +# SPDX-License-Identifier: MIT
>>>> +
>>>> +
>>>> +inherit dpkg-raw
>>>> +
>>>> +DEBIAN_DEPENDS = "initramfs-tools, cryptsetup, systemd(>= 251), \
>>>> +    awk, openssl, libtss2-esys-3.0.2-0, libtss2-rc0, libtss2-mu0,
>>>> e2fsprogs"
>>>> +
>>>> +SRC_URI += "file://encrypt_partition.hook \
>>>> +            file://encrypt_partition.script \
>>>> +    file://encrypt_partition.env.tmpl"
>>>> +
>>>> +CRYPT_PARTITIONS ??= "home:/home:reencrypt var:/var:reencrypt"
>>>> +CRYPT_REDUDUCE_DEVICE_SIZE="32M"
>>>> +
>>>> +TEMPLATE_VARS = "CRYPT_PARTITIONS CRYPT_REDUDUCE_DEVICE_SIZE"
>>>> +TEMPLATE_FILES = "encrypt_partition.env.tmpl"
>>>> +
>>>> +do_install[cleandirs] += " \
>>>> +    ${D}/usr/share/initramfs-tools/hooks \
>>>> +    ${D}/usr/share/encrypt_partition \
>>>> +    ${D}/usr/share/initramfs-tools/scripts/local-bottom"
>>>> +do_install() {
>>>> +    install -m 0600 "${WORKDIR}/encrypt_partition.env"
>>>> "${D}/usr/share/encrypt_partition/encrypt_partition.env"
>>>> +    install -m 0755 "${WORKDIR}/encrypt_partition.script" \
>>>> +
>>>> "${D}/usr/share/initramfs-tools/scripts/local-bottom/encrypt_partition"
>>>> +    install -m 0755 "${WORKDIR}/encrypt_partition.hook" \
>>>> +        "${D}/usr/share/initramfs-tools/hooks/encrypt_partition"
>>>> +}
>>>> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
>>>> index b635a8b..1d29583 100644
>>>> --- a/wic/x86-efibootguard.wks.in
>>>> +++ b/wic/x86-efibootguard.wks.in
>>>> @@ -7,7 +7,7 @@ part --source rawcopy --sourceparams
>>>> "file=${IMAGE_FULLNAME}.squashfs" --align 1
>>>>    part --source empty --align 1024 --fixed-size 1G --uuid
>>>> "${ABROOTFS_PART_UUID_B}"
>>>>      # home and var are extra partitions
>>>> -part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home
>>>> --fstype=ext4 --label home --align 1024  --size 1G
>>>> -part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var
>>>> --fstype=ext4 --label var --align 1024  --size 2G
>>>> +part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home
>>>> --fstype=ext4 --label home --align 1024  --size 1G --extra-space=100M
>>>> +part /var --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/var
>>>> --fstype=ext4 --label var --align 1024  --size 2G --extra-space=100M
>>>>      bootloader --ptable gpt --append="console=tty0
>>>> console=ttyS0,115200 rootwait earlyprintk"
>>>
>>> Jan
>>>
>> Thanks for the review
>> Quirin
> 
> Jan
> 

--------------ms090300070504070500070101
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
hvcNAQkFMQ8XDTIzMDIxNzE1MjAzMFowLwYJKoZIhvcNAQkEMSIEIGJMra2RkzCQ0QUGBpKo
4uFGvf7O66yfwZLvSU66GTMaMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwgcQGCSsGAQQBgjcQBDGBtjCBszCBnjELMAkGA1UEBhMC
REUxDzANBgNVBAgMBkJheWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1l
bnMxETAPBgNVBAUTCFpaWlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEn
MCUGA1UEAwweU2llbWVucyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM0
6383MIHGBgsqhkiG9w0BCRACCzGBtqCBszCBnjELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJh
eWVybjERMA8GA1UEBwwITXVlbmNoZW4xEDAOBgNVBAoMB1NpZW1lbnMxETAPBgNVBAUTCFpa
WlpaWkIzMR0wGwYDVQQLDBRTaWVtZW5zIFRydXN0IENlbnRlcjEnMCUGA1UEAwweU2llbWVu
cyBJc3N1aW5nIENBIEVFIEVuYyAyMDIwAhBOiqUnRfg4QgewMbM06383MA0GCSqGSIb3DQEB
AQUABIIBAIb+UP7T8vFYP0vnzrIaJkExbgz4QRoJy5B6a5rtOtN1rE+VgnQf4QefMxnyRa6t
qC+etXj81GX++VL8bvIBspP6i4cbh5qmkxtHNWEoKzR5sJnoS8buDFLJCBCaayT7kOc1xaMw
EK6X+1nYCcqZEcQO/47CP6GvkFtOzQR8pGlcMbUi97GxoHiu7dXZgFPh1c+tiaMZmAiKC1zP
A68lPr/T2P68O4wHNItQbDiATBq69f7a3O850jUPFs4KgzdTBVUO0qvrMmpwBpER7Jd9mTd+
eKhTYOI6gtV7FWYy2dwb3IcTSu8hooBKXQUrXFf3Pb9z+sfHOhnWExMmsZS4Bf8AAAAAAAA=

--------------ms090300070504070500070101--

