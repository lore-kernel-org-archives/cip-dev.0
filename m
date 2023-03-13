Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A7C6FD19
	for <webhook@archiver.kernel.org>; Mon, 13 Mar 2023 10:30:23 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.56])
 by mx.groups.io with SMTP id smtpd.web11.16512.1678703414262078871
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Mar 2023 03:30:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ndIS0p/b;
 spf=pass (domain: siemens.com, ip: 40.107.20.56, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMEAXUxVBkNxLwN7DP/ris0JbLOeWmK37HArQxPOQV2PHgLaPL9+JG44QDY34KXjfEUwdg/tf61LX5NoXokCrXMTCSBVgmWywJpdorXGqPE9HYm6QNIpNE91apgTfml+zxuX6ln1UY58GucLvzaFxwRNgTSqaCF75g/F5v+FU28iKNTpLQknvnBhDW7+NpdZuky/3R7wIy2oTYM6AST6Toi+PmmSvRbl5OtUGv7lM8ovfZK9PrJEz/uPedvZMkmzurx2BesOH3aZuySUAdxX/W4PAPXZbQsLs6noWyJw6JTnFAXgfVj3WkBxXP332wKIq9invxGKKmHblJMcvb9xvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mnNXUrQOeaXCFtEDJxehgO5sBjUcE2+K4/bYxOgSBbI=;
 b=VZ4tYvzyh10F6iNUHkoLa9Ian3Yy/6vlSK0rnINTpFV6tQIV2oNF5Z/OAAlyS086jRq3NkQReJG6CDajtrbbEZZjklopQ7hzLJ9abGD9YX0bI60smAN7ANYz6g6T7PYb5/QmBpdRAy+uJJ2qL2/BSblyMNCH2eE5vgyXMZN8xduSZJ7J7TjBGBnhZkhbU2OWVoI8jrFP1xzbSp/q8apDOZsuRxbwWFPslo6FvrKxJrtgLoZOYFxisP8iUzxqKWriN2rDtcwvCheJxfkxTci1vV/R7wYgkzgbzlgNw+C7RvWzYAy6ZMGJu1gNkVsXFoDHCe0qwo+ZoR3cLOKIzN02IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mnNXUrQOeaXCFtEDJxehgO5sBjUcE2+K4/bYxOgSBbI=;
 b=ndIS0p/byQ3ub4bflrSJGgHkEkc9SRxJmpZDRgHGZSNE7h55Xhno+78lLX31vxgwL+qlUP553D2UEO/oph3JCb/D7VGjhfV+uGyjUfKN84Wqyv+jorvBxNtg7i/VpZzLAoJ2mnEBSvQMxoagom7/V6NvYS6ypC1ch2n063yepXhJsqRKu1l7gAx+bQuuwvtg/Yyj+oLooOFT+jIi856VaW+dYXG/Lx00DDg0iiJt2e8E1N2ONM03XcfmZTi1oaY1Ssahuo4nL7BHnmxamwL7nbtTvU38O2Gei/bqBshI2gnI0wAaCojGDvjnmuqUpgLi6hDaszg/LSqdQQo6QBiu6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB3520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.24; Mon, 13 Mar
 2023 10:30:11 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::41d2:6320:6383:274e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::41d2:6320:6383:274e%3]) with mapi id 15.20.6178.024; Mon, 13 Mar 2023
 10:30:11 +0000
Message-ID: <fde29081-db60-d0d3-601c-113472f52616@siemens.com>
Date: Mon, 13 Mar 2023 11:29:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 3/7] start-qemu.sh: Create a
 tpm2 device
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 christian.storm@siemens.com
References: <20230309102821.307140-1-Quirin.Gylstorff@siemens.com>
 <20230309102821.307140-4-Quirin.Gylstorff@siemens.com>
 <7f82c0c5-bd5d-09fb-3a9b-ed6c7237f74e@siemens.com>
 <e5d1629c-7b48-da7f-d39a-14e8c45c0555@siemens.com>
 <c55fa4bc-41e9-fcb1-07db-b6f39bfc110e@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <c55fa4bc-41e9-fcb1-07db-b6f39bfc110e@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:610:50::16) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB3520:EE_
X-MS-Office365-Filtering-Correlation-Id: 08f7b35b-7678-4361-5d46-08db23adecb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/EIy76J4gFNVO98t6/gfwchfiOgITrTiU4pGRBHY+Pfms27S4v8dIhR5CDKBb4vPuRpRMBmvAHK1skf/FQ1imvrrZ5uGukZLsfkIFf8pF9DMDn3CSdqsz05lm8XM8QS3vKNF20ArFKH5o6OiqBwh21eEfKS1Bx8nD1D8kVJHYr8mKzyFIus4I/tdHsE7P37EB1IILjq+ssvdgyDgeLrRjoxSMrfHckBtzSrZ82d62ZIphCUeb82OmjVJeAPZL05Bi3MLrN/gjTwvKoOz3yM7RUObw2zyNYiEyE+3079PIjkKl0w6QHAgl6rTMuitkMsngBFH05uWPZ1faPGze6CDMzD/c2UucMXzn9X5XpVG53iPhCYvtS5SagU6TBMoMfkF+irVPt+99w/JO7yOniJOaJQvJ6CJaNB4CaNe8j+mvNiqGDf34s3vQpo8FIFpaOSaz05NS8U2XSmJyfi7T+br5ZD8bT5u3+T4XcyIAF4mUpxQM7jjbeiXJPOmufdPTzZpczxiSP6/UnjZjJVKRM9XZTCQ1tlb7i7n8q1xqhNCQVYkNiRoilC2X3qHmrXATlwzBJNxkYQLre7jbEt9k439U9ak5Werd52QcOniuVB9IE+wObkegpblzB/E2lt1qP/Rv43vW+EXBM3kJCGnoByDgk/M1qHCDJ0gViwUbc0NEoU7wtwuFJ8ZVFuuvReqa64xIyd0wkXEI6SAfb0enPiGlgLh6Qqmn9s0y0Z0kvwGNIo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(451199018)(31686004)(6636002)(41300700001)(8936002)(478600001)(66476007)(66556008)(8676002)(66946007)(31696002)(36756003)(86362001)(38100700002)(82960400001)(316002)(6512007)(53546011)(26005)(6666004)(6506007)(5660300002)(2906002)(186003)(6486002)(83380400001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?qucDmppj52tzqkTmGu/q2n+LiTqA1WSNk2+kjGzVTrgDizXfohDCzXalItqB?=
 =?us-ascii?Q?LqwQ0DN99WYpgwim1ROB4PDWBYFLOziJkuivsXAOfvpGMwWq7WNzhy/hzecW?=
 =?us-ascii?Q?vkgQ8VkERkiWEoEftFLIs3M5AoRmhmcLy1qb4Nytk6W1mtUkPtKvtnXwPY9a?=
 =?us-ascii?Q?1pf37jYZZSN9LQ/uH6Bf3q41dZce7TveWHZw96Zlu74qNxfjxeWcLbA3Gd/q?=
 =?us-ascii?Q?5YAfy0JBrBObWJh1LBo7ABJIPC7o/j6M8MndDlzqB0sxtcEH/CxMB0ESXyMN?=
 =?us-ascii?Q?wtMQJrjptfTnj+2KN3RnPKNBJUxHuWm45SjG4bOSjydS0kKSyymQY+KxL6z+?=
 =?us-ascii?Q?s9yNJvMTNVzPTiSbec56XiKTRL0fQjFrEfGKEPostFvOnnuF6Pxg8kXs1J4L?=
 =?us-ascii?Q?Elw/ORbELverzeUDnwSiFhV66ylIueG1Zffct6QDRLcgntM9PqsHuUU1pq9K?=
 =?us-ascii?Q?STN82m1TsQC5mZwzZAdsQv3iiaO36ta8EVc1la6ZZMNjx++k5AiKAXpfcLAs?=
 =?us-ascii?Q?W7FsKBQXQpbNx89ZpjxtVzNJx83enAnOU1QQs0PMTaEltCpJa6Q5Fdbyi+GT?=
 =?us-ascii?Q?rMDLdX5d483ocsQxdmaNzFF4bhhVCA17jGEB+tcRXD0aJWohx15vPz3JbFUe?=
 =?us-ascii?Q?CcX9eUr0eYFacJB2KmeamwK5H4I3mVK7IPrRZ/1sHRhh5I1AXlEa4QNNpU74?=
 =?us-ascii?Q?wWq1hPWqWQzgLk6lslJki8e294Pls0oWHsopcaz5fCyhS6a4mNULLT63vaBz?=
 =?us-ascii?Q?CQmFERMA07GurroimMOAyYCSYF1ZRpNPOrkf52LfXs9jtIVY19cHIyKDKp1d?=
 =?us-ascii?Q?VMXRCFJGtnVNu3mroprabwtM24cxRxxl7JOthaS/RsX2ev8K8LYRt1nBi1tg?=
 =?us-ascii?Q?Q1Ce1pcPt0hvvfQ39nY798vdzk49pPmGuoivtUZ3ccvJcRirS/zQ2Kv2xxGm?=
 =?us-ascii?Q?EOYpxRuHu9WCbj4tuQ5K8z3XvbfKUeLzKL3/S+DTUUGTyxrL075DKqlMqHYI?=
 =?us-ascii?Q?UZLefMlIKTwxO1umyLsc6tqw1OqqZxafzIC58j4NwgN87r2+wKmqdzTquBRK?=
 =?us-ascii?Q?/TrH3UQBH3fWMBizZt66RD1YbcTtfJij5iYVgE9gI6/e6blyIIU0Kb1k2FYZ?=
 =?us-ascii?Q?PqHj/PyqKQKG6cftVuh0lioa8rsiqeaqNWTAXjqw53sxIVtqNIqzy0cAgzpx?=
 =?us-ascii?Q?2FqiCpAR+Sowp9esAwKT5wWDcipsJ+WXrYFenANYojSX+ZlR/vOi4nRVTtoM?=
 =?us-ascii?Q?KwDtBXCq0hocFDvItX+OjzE0YyraeGf+YSla41qEqKaQtf1BVPMkAEcK01wr?=
 =?us-ascii?Q?Pk7CE4MuIi2n5tYMRFA+gBkoNJ7A+pGTLnpOh+JWQUfsgS8uHO3nM6Pt8bfn?=
 =?us-ascii?Q?Q1rMwZYVwWqVW6R2q+9PiS8wiaxlvADPal9TGThDnWsVzVxa3We5FedROUsp?=
 =?us-ascii?Q?DS1R4d2mZ5Obgg9VwIm/iCUF10obkCOukjaK3lVPlLgPv7Gbzz4x1jYaDMfH?=
 =?us-ascii?Q?fwWfuXlbp+91+QCZD4Ma4V+tt+JOsdUqvCtbZGyA/9DmUCqStJw+7yZzlR/5?=
 =?us-ascii?Q?k2lgT4a9i4s+sf59Jdn6ZehGYivYe6bvW4ZO4nXLAhNCGzBGsE1MbejnlJuN?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08f7b35b-7678-4361-5d46-08db23adecb3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2023 10:30:11.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1R2MuQtEflnO6XGD4SFrFzphqs193Npl4Az2Ax2u6iDaZVSpQngjbaYmQ1emyJomnpLL8Dy7De8MAnUnW5wUOJeuE1RY+VkQMjJZQ3O8GJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Mar 2023 10:30:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11000



On 3/13/23 10:13, Jan Kiszka wrote:
> On 13.03.23 09:13, Gylstorff Quirin wrote:
>>
>>
>> On 3/13/23 08:08, Jan Kiszka wrote:
>>> On 09.03.23 11:28, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This allows testing the partition encryption with qemu.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>  =C2=A0 start-qemu.sh | 27 ++++++++++++++++++++++-----
>>>>  =C2=A0 1 file changed, 22 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/start-qemu.sh b/start-qemu.sh
>>>> index fcfbc5b..b46b066 100755
>>>> --- a/start-qemu.sh
>>>> +++ b/start-qemu.sh
>>>> @@ -28,6 +28,9 @@ if grep -s -q "IMAGE_SECURE_BOOT: true"
>>>> .config.yaml; then
>>>>  =C2=A0 elif grep -s -q "IMAGE_SWUPDATE: true" .config.yaml; then
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SWUPDATE_BOOT=3D"true"
>>>>  =C2=A0 fi
>>>> +if grep -s -q "IMAGE_DATA_ENCRYPTION: true" .config.yaml; then
>>>> +=C2=A0=C2=A0=C2=A0 TPM2_ENCRYPTION=3D"true"
>>>> +fi
>>>>  =C2=A0 =C2=A0 if [ -n "${QEMU_PATH}" ]; then
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QEMU_PATH=3D"${QEMU_PATH}/"
>>>> @@ -143,7 +146,21 @@ QEMU_COMMON_OPTIONS=3D" \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -m 1G \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -serial mon:stdio \
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -netdev user,id=3Dnet,hostfwd=3Dtcp:12=
7.0.0.1:22222-:22 \
>>>> -=C2=A0=C2=A0=C2=A0 ${QEMU_EXTRA_ARGS}"
>>>> +=C2=A0=C2=A0=C2=A0 "
>>>> +
>>>> +if [ "$TPM2_ENCRYPTION" =3D "true" ] && [ -x /usr/bin/swtpm ]; then
>>>> +=C2=A0=C2=A0=C2=A0 swtpm_dir=3D"/tmp/qemu-swtpm"
>>>> +=C2=A0=C2=A0=C2=A0 mkdir -p "${swtpm_dir}"
>>>> +=C2=A0=C2=A0=C2=A0 rm "${swtpm_dir}"/*
>>>
>>> This kills the previous TPM state, preventing to power-cycle the VM. We
>>> rather need to persist it aside the disk image. I'm massaging the scrip=
t
>>> in that direction.
>>>
>>
>> This was for debugging purposes as the TPM is no longer accessible after
>> a number of keys entered.
>>
>=20
> At least it is possible to encrypt a new image using the TPM state of a
> previous run, just tested. In which cases exactly does this issue hurt?

After creating 8 keys/Images the 9th time you want to add a key to a new=20
the TPM will throw a error.

Quirin

>=20
> Jan
>=20

