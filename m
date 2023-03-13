Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A008C61DA4
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 09:13:43 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.78])
 by mx.groups.io with SMTP id smtpd.web10.15170.1678698817290971430
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 02:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=apf7HJpF;
 spf=pass (domain: siemens.com, ip: 40.107.15.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OolyXzRd86zK79eXuJFidL2z3T+bJjFRiq8AEVpc+H22kD3ll6ouCLkVOWkt6l+wegDPkBHrmiyMLixxtxcIGrnC0jXpvX8TIAkxKDKC82fKrwkWE1ngDDRdSzFtn4qPdkfXMHilupSLYw2BA3nlF3MGrsaL+76LC0n2mxcBUykw5l1t0NYpfxauVBQWPwPDd4APb5OyE03FgDAlVX5QVerJmDQ21Rbgg8eAXeFQFcAhVs7jDBVEDfcP2mezxumz07BQk6t66yZa/44SP+OK6PEjjAM4jqK/RyQMsFFSfTzG+U64aXdYN96oh29r6IR0Fd9aMN+t7g47zBbS8EnJUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKG8UbliAy3mVr/8AusEUgshJgpaM4TGRzGrREQfQUg=;
 b=Qr0+nAkIXpIhioKaqpiv2omM9MwSDhH9+TFfJmJoVc1oVsJAxqtNz0rTG3xpk7hyZAFioQHm9a98hi6wGI7IBlzn0IDacAcPuwfkVDuIvlxP3UCeBpu0G53PCAPp4fFNjPs5odnkXX4V/P5xiVAh7I3MFGdujC/Q5uov1nKobXjjRRHrCk4q+lu8lcHCF1Fp1U3fjD9cp9K1wpf/qexUySDRtkkLgcO5GAYIjM6Pln+tNm9/uPQjdTz7yJYygduRTQ/66Fu8TUbCJsl0VrU2/pbawGDRXPmKcS3OyWJjtOHfu00eN1ZnelV/zqTnXoQcsKwa1HKKjP1z1uHqYaB+Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKG8UbliAy3mVr/8AusEUgshJgpaM4TGRzGrREQfQUg=;
 b=apf7HJpFZe7QlSP6Xtl+yx6ewaaSjEjkm1ANsq1q4U4QUEOIk2Ro41xlbB5wkt3H0tPpcypVlLBPz3HTGWquV00kLKh+/G3Aqf5zIPX5s4BwNE2/e4z4M+jNfyXW82STBcT/nMtbwY+sfPd4qianrD9U+Ju1M6fBhzrVkEPf5MpUASmASHQjPed8HBTp4mOH+u83J/uva7WWOK4lsoY2GFY4VDgGuLRR7fq+13chdoMu5XiCAfwUWJySPZq3wBdXB3RTrlSVYfCKvljd1UNAtOSPtMSnO0Zq+XxMWGWnuwGRYBO/kwBxwL43osrRHcv6M154CpYCM0EgJhuBDNxrZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB6205.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:589::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 09:13:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d4b2:77cc:31cd:a3a2%9]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 09:13:34 +0000
Message-ID: <c55fa4bc-41e9-fcb1-07db-b6f39bfc110e@siemens.com>
Date: Mon, 13 Mar 2023 10:13:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 3/7] start-qemu.sh: Create a
 tpm2 device
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, christian.storm@siemens.com
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
 <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
 <7f82c0c5-bd5d-09fb-3a9b-ed6c7237f74e@siemens.com>
 <e5d1629c-7b48-da7f-d39a-14e8c45c0555@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e5d1629c-7b48-da7f-d39a-14e8c45c0555@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB6205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0fee27-8e51-4a09-ac04-08db23a338b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GYA9jc3zJXEa47tEHlZt2OftRY3nYI0FPPtREQdivplkI7EWS7M/dz5GFg0pzZ7rL7abIC/UwFPBXC229ZxkjPrvp+3DYpqAuhiO9VwJZn6vbYfhRQSAgm+FO12k+C8s68xGYlj18oEmQMMgehFG2AzNB8VlGCr1pKmnsHtWEEiCLtRQTO8hJ9Pyt8N37GUe9dAiHmkpT30BAuNYYe5YEGWzu/ttR0YcSNtuugxrxCZzpFsAb7RN0ghkcD3nQS/sCNNHjHNTi1yhyzjBWcT+7mUC5HrIXLZqcaF+/R7upKrd9UyeMlPmIDF5Wd4y2SyyEPwQ2A4+TjogECYh96clbgZ78vDXf0ClzmSd8rqFSt+CK2Tkh2K3iSAdQUXvdI9Q7by/srdGF6EofBH23kJmWaTn1nj97wRa6+vybFKswSYWpnYnN63WVi8+e8WRzgA7mZyqm/zmnyj2uRBViKbzOATnZbnxf5IHKfOJ6jnys/1D+nukRqFPJMEpzX52tJxWrXTkxoXhTRdNLgkyCMvsIE2lp+FZoynYCl5fCeM6lGeu0oyNVZ5DVkYEroxoPreEVvQFqSax9a060ZkKsP15CebQ/aN49TSHbnLUp0I95niMceyuhFqX8Uuh8Qt12I0L9wyrxeO0j4RtZr6GbRhtE9Qjm5gTWDoFIYG3/pd2gWBkDFZ8aopfJMGyVsj1ueU9CMNwjCJ2fXCxvc/kvLY7+ci2DpWQnTCY2zQRZeHDSnk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(451199018)(31696002)(86362001)(82960400001)(38100700002)(36756003)(44832011)(2906002)(41300700001)(5660300002)(8936002)(6506007)(26005)(186003)(83380400001)(6512007)(53546011)(316002)(6636002)(2616005)(66556008)(6666004)(66946007)(8676002)(66476007)(478600001)(6486002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xqo1s34gHgqoK7PEtMKSs59P2tlzCl7aWAAb0VgzIKZJ1eR0vpXb2y/I/z9U?=
 =?us-ascii?Q?fWEzYmFIo7KYsxU6NEAN1POGfNfx1zH6KzW6D7c4MgLZPJAKWKPQ2kTmgfYQ?=
 =?us-ascii?Q?YiMwBOxWq8MtwEk4M3b7uURCQ0HPSP+73qjxEeHXdDiciENme+hXflEWfIFk?=
 =?us-ascii?Q?Gl8T7Wb5bSwDvMfCIivLsW5CZfzeUN3V+FVhgSAwvCGILb/D5vvw5Q8GXFBv?=
 =?us-ascii?Q?zceL3Ybe1q4rkaO7QhWptrK8MmQOYWQJHlcikann6OQPRw7+c3YwnlMTIMAp?=
 =?us-ascii?Q?TOIjxMTnp1vDG+CXKUbtU9nRTjRHWaHbKDli8cdeLdoPN84NbdEjFIKe4cRi?=
 =?us-ascii?Q?m0pDiWbDi1EYgK3DcNi4Ee8BOFKo8lQM37XGs2w34z2ICLUwDXIpiWf17YMm?=
 =?us-ascii?Q?l/gbF3yE7qYc1Z5FEA4ZC04AmXcBMrEAF0WmCq7HaNQ6Scj5qUz67ajBMRJ/?=
 =?us-ascii?Q?Y5I+/Uzi8injC9Rkm1e21Fq3tceHIwygdkBcLnOIbhUHoRjHXdDlTwdwe3SC?=
 =?us-ascii?Q?Yl5Rn6ugxhRHD0JwM1zwpT0EeYaEtrf+r6vWxQWABzn01L9Bmc3hb0Me1mnS?=
 =?us-ascii?Q?JeScEZBJ4/lcJLxaFFTqv+YUOaGTzvZy7eC8hULOBxpTp7l4h8+OrZgkuyiK?=
 =?us-ascii?Q?OJQaSfJMcm3mdiRHhlvOCandxlSh+bsV0wSCtUeutA1XL68hWI4sN6WnJKk9?=
 =?us-ascii?Q?5K2G0Hp8BOYvvDJgMETItO+nqhxwKxuzcx/2+ofZ2dEPR6iiR4Jh0/qH6RTv?=
 =?us-ascii?Q?qjRDXnOMSSmV5UUvnsPFOZN/nsg+wSHM8Ez3S0QAbys6pyBuU+oStFJeu4Vq?=
 =?us-ascii?Q?b4m3TWIbuXR00w4C7m//hYG3T/9f2daW9VT7lyhtrguu5kArJ+miUYIuXIiA?=
 =?us-ascii?Q?x1WRUQiQor1LRo9PUcKIfymQaS6yhN6VPwqGqIB+amFCAl0n3sngufjXrK06?=
 =?us-ascii?Q?rs8LfG8Ap5Xll/Jw2a+DVCWlAWC3BpaoD0NRu4ygx7ng18qWZ9efYgcb3Oeh?=
 =?us-ascii?Q?g6Ivjd/usXse1AKnthgrU/eyG9O/+l/bC0tvrj9PEgNqS5Y6H78lxf605Lkr?=
 =?us-ascii?Q?YNRYLoM+OHB0HMIrHxhLNDkReMuXzjqqAlR8DLWtoYZsMHb7LUsehXSJN+z3?=
 =?us-ascii?Q?pi7qv7egOnVwkDrJJrEMszwvrDy5qaMEZDcn70EcTuT15cLyFVfOAdOwHeLc?=
 =?us-ascii?Q?wHk/udi1wa7udEtCWekdqV2Smi4xebovd2Jj0MvNCAaBYBMSa3hF4Otg1v7+?=
 =?us-ascii?Q?rVTVYWnouHO2T5RCvo+h2Id4dvqgBKHdYYdzoXCQ1tm6/XPJP7FH5Ds3vk5k?=
 =?us-ascii?Q?cK7Tuen0fGBoYjopnx/aHoh1ZanfEz1Vks7u8l0yINHhLKJk74aNrBQ7sctJ?=
 =?us-ascii?Q?lXO7fjc1DnQ26aKluCa7RSKoIC5mWnsjrZv7GhtvtKaXDXJL7CR1nysuxk5e?=
 =?us-ascii?Q?DlJC/iAjztB43APG6KkkdmDcq7bBGH9e7004xHp8M35GZMNJ0aOoMptZNmCR?=
 =?us-ascii?Q?ausyihmB/LylCalNF0ZBCwrkPeuwGTbrLprKPGtzcQ0ANZLb2GK+he+IcO89?=
 =?us-ascii?Q?tpuQuh2dINM5AKLi+NdUAU2KfCxNhF/H5qTJCh5hzl94HcSsIl+5EN/gEzhF?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0fee27-8e51-4a09-ac04-08db23a338b7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 09:13:34.3914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsuyNCvw8vfTu6NxJpCOgQDcrRlEst5TugPik/tqRApSZ1yXo7BQdjel5VLt47x5+X3bMTDXOhQ8RX3ESlyFBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6205
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 09:13:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10995

On 13.03.23 09:13, Gylstorff Quirin wrote:
>=20
>=20
> On 3/13/23 08:08, Jan Kiszka wrote:
>> On 09.03.23 11:28, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> This allows testing the partition encryption with qemu.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 start-qemu.sh | 27 ++++++++++++++++++++++-----
>>> =C2=A0 1 file changed, 22 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/start-qemu.sh b/start-qemu.sh
>>> index fcfbc5b..b46b066 100755
>>> --- a/start-qemu.sh
>>> +++ b/start-qemu.sh
>>> @@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true"
>>> .config.yaml; then
>>> =C2=A0 elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWUPDATE_BOOT=3D"true"
>>> =C2=A0 fi
>>> +if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
>>> +=C2=A0=C2=A0=C2=A0 TPM2_ENCRYPTION=3D"true"
>>> +fi
>>> =C2=A0 =C2=A0 if [ -n "${QEMU_PATH}" ]; then
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_PATH=3D"${QEMU_PATH}/"
>>> @@ -143,7 +146,21 @@ QEMU_COMMON_OPTIONS=3D" \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -serial mon:stdio \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -netdev user,id=3Dnet,hostfwd=3Dtcp:127.=
0.0.1:22222-:22 \
>>> -=C2=A0=C2=A0=C2=A0 ${QEMU_EXTRA_ARGS}"
>>> +=C2=A0=C2=A0=C2=A0 "
>>> +
>>> +if [ "$TPM2_ENCRYPTION" =3D "true" ] && [ -x /usr/bin/swtpm ]; then
>>> +=C2=A0=C2=A0=C2=A0 swtpm_dir=3D"/tmp/qemu-swtpm"
>>> +=C2=A0=C2=A0=C2=A0 mkdir -p "${swtpm_dir}"
>>> +=C2=A0=C2=A0=C2=A0 rm "${swtpm_dir}"/*
>>
>> This kills the previous TPM state, preventing to power-cycle the VM. We
>> rather need to persist it aside the disk image. I'm massaging the script
>> in that direction.
>>
>=20
> This was for debugging purposes as the TPM is no longer accessible after
> a number of keys entered.
>=20

At least it is possible to encrypt a new image using the TPM state of a
previous run, just tested. In which cases exactly does this issue hurt?

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


