Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900D0C4706C
	for <webhook@archiver.kernel.org>; Fri, 12 Jan 2024 15:28:34 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.51])
 by mx.groups.io with SMTP id smtpd.web11.9899.1705073311851124076
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jan 2024 07:28:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Le8u7jEH;
 spf=pass (domain: siemens.com, ip: 40.107.20.51, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgAwqmb+9bqQfwtHRGo30whTa0477c/33ArNNvn71XRdhDm9irOdbpLFu7mAAfk+tyQ0t3IXP+T7jbWGhVYy0INGYDUI0kWQGzzvraIAqNGiEuW4xEAMkJbtoXuV87KTPZNV6W9ZeSFbTNp6/qSdj4HcpBLD/hVDTQzFtnDWx+rXsKjezeAirusjJRC3lfcD5siqcnkjtgPYUt4VrzwVEow+giadj2XYGHMJnjHEKu36uckI7JtaKmaX8KaXIPfWhxCdL1Vk4AI+dAF2VqJ9Rd6Rz0nIcvYHeTsKFG2yrSWy1nQczneWIOu/QSUPDbEaLPkiB0jTDzP9owu9Q4hSlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t81Eb9SpE2q7PzLTDJlr7icoz9IAA+qAkJeS4RO9AX4=;
 b=Socf8WnnLzTSPsX5sndQuD4xxrrmklC+WMwoPOdqdza/+7a0HWhbNubKo3t8c8GfJVf61EL+9ur6MC3rnFvrDB2y30VdaK3WhKM5m/WN4tQbaPw/te3swjjp+5Sb2OuUilGYTngSk9R3mg8D9K59v4GADrDFROMs0z8eDVxF5vf9IXWcp/sSo9xSitoz3SNj2cPi+02MqhPli3ypoeYt693C8aY72T1XVqbzMSYHZNNsp7ve1zRWS/rbMbo+u8BAr/VQd3nPuZiVKoQlH15lpEAmwjnOUP2qDlVDIXY7lBu7hCgdU1qdLssGks9ylCNuXaR2TZTLT+B7CCIs+WcYUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t81Eb9SpE2q7PzLTDJlr7icoz9IAA+qAkJeS4RO9AX4=;
 b=Le8u7jEHQzkP0L2sh3F90/C2xJ6c9AvtSCqtQ8luDgCuDIxU+4A5xtG+c4w4xyBY4DejJ6HioaQU4QVq3qNT3BzK2TYf2xt4U4ly3sjCDqTanp9JbGTXeeIfRa3b0Rx+SwwL7no1bVr4DjTjQ2Zj70AltlII6c0SImY8qj92zR1WvKaPpW/pClteOwNQFKUSR9GKOW6Z3g0peYGetM0JxfJtjeLgwaLeJt1HPDJZ/ngp8k7OexO5zdIIYU6DwAL7ICoTnL6/o1Ul3ISFYEleoNFnlvkZMyHpcZgT+EC2aZMWMt5V36PnGNpQwYX+Ht63Z4fCN6NEGxk6lHQfQGFKpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3977.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Fri, 12 Jan
 2024 15:28:28 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 15:28:28 +0000
Message-ID: <057ab135-cef6-4f62-9e4b-d2b1bd0e91aa@siemens.com>
Date: Fri, 12 Jan 2024 16:28:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v5 7/7] doc/README.swupdate.md:
 add new section for bootloader updates
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
 <20240111200015.190376-8-Quirin.Gylstorff@siemens.com>
 <75575f6ff4179fcc189b103b042bc806b093c4b7.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <75575f6ff4179fcc189b103b042bc806b093c4b7.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0011.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::19) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3977:EE_
X-MS-Office365-Filtering-Correlation-Id: 967fa0bd-22d1-46b9-e01a-08dc13832019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QBcYhu/rFid/9owawfLKN7x9dmiaX/vvsiLxlpngZo9X5uf2O86UjWu2F58ezkdYhqzf5kldgT303Xv1Z3iOs0RYXMj8f45D7ohT/HZvrT4XouBzrbw6ZjgRu6pkNhGn2Od4jBFPZs+qsi3mRSYXLodWM5KQ+r7jE3gr1jvbua6k5djEsg2X8MxJdhQYV7YpVlqN+fff68Q+PyZhIRWDDhNmJNPdNbYlSDzEj5cpHs0G67nDPcqD/QruPEddU/9eEvLFkfKDno3xi/4LM0rMaczPcPFbpLgmMgIh1b9qFji3rP9tERCp0J1oNrZTBOkv3YiV4LguXbRvUVJOy2K0LOfK93Mi2BzNSX3rnzRNTGcEk6qzsEbzKNzAEgkUAv9K22H+vnp18W4xs0vj0/O87Z9sUy0GPXLcehySmI/iTSnJhN2zkTBvd+2h5pD7Dcly3/6ATs/EHNkTliOkNOD9Hp0Am+XrAeKpuxPap7bNyW5oOM36IKwEO7GIvU81T7YHJrATynEkDw7GaOEiOvb/hfFuqzm8THVYxHzOQRgtFhTcacTXqH9qruhD1aPW6mlwi851wHpJLVMi2FbQN97sLOHnUQ0usmY5iqx1y2DMgDUXNVN7Z5QCH8o4iw1/OIjlzkUrHmYwhSHEOyOt3bbGOAYwQinNjkWXXwCUlcKYPG0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(39860400002)(376002)(230273577357003)(230173577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(966005)(38100700002)(478600001)(31696002)(31686004)(82960400001)(83380400001)(53546011)(2616005)(6512007)(26005)(6506007)(110136005)(8936002)(8676002)(2906002)(316002)(15650500001)(5660300002)(66476007)(66556008)(66946007)(6636002)(36756003)(6486002)(86362001)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?h9XO6yWWNuHuzR9AirpT0VcUKzpjArcvD2T55+nI2iZwynlQhVDoS3C8lyR1?=
 =?us-ascii?Q?0SEH9Ukogxjqm2yr0zHCtcgmuYnOqM4KDcQU2EATCRYzHsLR5x3omwbDFW3s?=
 =?us-ascii?Q?4DWNgifxoxINrCwsUYkd+GEZmurNWRSGAWQ9d0KNI3ggvhm7rb58BX/Jqslv?=
 =?us-ascii?Q?WcnNex5DgXR5a5fOPfsdQn8zQ9NZnm0/JyXyjJTTlY3atzz5AT6o98Q71bYg?=
 =?us-ascii?Q?xw+Yy6Rj0egGEqg9JnuQemu7iQM8bx6UplGHBGekF12THMaVxrNXpkqB1c4B?=
 =?us-ascii?Q?6mrJxmBPhF1mhDfMT9glMPp9Vyt+VbY2ZDFoTWu/ku2liwPWaM49+KMoAx0m?=
 =?us-ascii?Q?5R25nRvoGKHH0XH+/fEUpwIBMzvCfrj3vHNHaD/tTZGrGE+go011niOHosdu?=
 =?us-ascii?Q?o1JeqIgdEj0/YxnraLsrGBmAirSHbXtkXViDTavN5WQUE7CivhyX1d7LWwmr?=
 =?us-ascii?Q?/s9dgS+zweGh0obsHCl30kOedanLXspS9PA6sc4dECtxs0uiWd80olQGr7l/?=
 =?us-ascii?Q?qtSC48/BC04EvXbQPiXxHeyQDBCGDiY9ZeRica4ksDhZ0Xj54lAmWlzLB/sE?=
 =?us-ascii?Q?U6PIH4nLy9QWOi6l5ngWyh4Q7gOSFQJaAOrr6JEv9z39RHevpw56QuU/mqn3?=
 =?us-ascii?Q?YfWZJY8byyQlgvMi/IXj+lT6YHwMjllMxKTpnc44Oa1gJpxcekXw+631OVIY?=
 =?us-ascii?Q?AsuPXByHrAV+f/o6U6cD3ZtbLDaTqs+mAH1cgrY6eCBcuyTqtNLBKrHTX0ZV?=
 =?us-ascii?Q?8UjjRPAOKcSZwj8PBK9wcTXuO3Xnr35wMJhS7iHZlBOmhqulK98mHb55ptzc?=
 =?us-ascii?Q?yPKs8HqLaSmEnyYQ+X8mdafOwT1MSL1gmf2DnfW/e8GQsVL7WdatPuByMoqA?=
 =?us-ascii?Q?fXT3Os/Z8w5ipOo3NVwcJic2yYCDBl5KKvk/ptHl305W1DYZdn2+VBRDo4QP?=
 =?us-ascii?Q?HBDhIoEroMe7DXhMp8DWQosfP6T2cA9VDZi6PV6ANZRbt7nx/JX89ZRDeCL9?=
 =?us-ascii?Q?1HigjAw8JcvxdB2+7bcPvwLSu0KR5BglZgdwNG/2ZnJ6WMYCce+kvaCBRqaz?=
 =?us-ascii?Q?Ax2fJifFbYq/xjRjw8Hl/Tv7ZZ/sDTEXa7fupk1qzsKg7fDoEW4Vu15BLlcm?=
 =?us-ascii?Q?xmG+DYrvL7TVzlmNuHER42s3w/Ay0LFtvmcr+qPWKE1XaprkMoQzpdLdtLrG?=
 =?us-ascii?Q?jwVyO2drna1gVbIipvwrCz5DA0bUIPEnxlBV4vLOg12MM6aHGG7kFjIfoClY?=
 =?us-ascii?Q?1WhfdxIx7P86Ntt0rDVwLOTuMFDDjjXSGvcrWqHYcLkgp091f9uLHYupd+Ag?=
 =?us-ascii?Q?iQjsLC9emX92SKyvGTMqVt975or1ppeggCcP73g53YKn1xVCVEiU72mBeiRB?=
 =?us-ascii?Q?QjNE2xRu1izOfrMEs/VwSf55AeRl/DBbStokqYUteKw/tzNcamZmQaESj1Tq?=
 =?us-ascii?Q?ts8skEkWJAsQMh4VgTv1ohq7GptAqzHJL9R08f1k9yYLA6VHuRELh3imXLtU?=
 =?us-ascii?Q?cImq7fNmGveMHmlsxkL4IF7LjmPE0G2243xiKK8tfh77gIlNqgAiL+5IPtOn?=
 =?us-ascii?Q?7ClFdNyJJSD8Gx7yghoVgtOuZlFHNOcR88Rd+wmfc+Nu9q6S4Y0a5myIb7SE?=
 =?us-ascii?Q?ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967fa0bd-22d1-46b9-e01a-08dc13832019
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 15:28:28.1036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa1iblqp6vcrahaMPoRNFTplipJEYJAU5ELQNsn9sG3LMUTLpHz5WpfaivlYVdi9XJOQ1tSYN2j/jpucXRO9rzjQ+ZRrHOgOug7S1NLb4xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3977
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jan 2024 15:28:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14352



On 1/12/24 15:12, Moessbauer, Felix (T CED OES-DE) wrote:
> Am Donnerstag, dem 11.01.2024 um 20:59 +0100 schrieb Quirin Gylstorff:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0doc/README.swupdate.md | 13 +++++++++++++
>>  =C2=A01 file changed, 13 insertions(+)
>>
>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>> index 00359c7..1c94699 100644
>> --- a/doc/README.swupdate.md
>> +++ b/doc/README.swupdate.md
>> @@ -7,6 +7,19 @@ Start with cloning the isar-cip-core repository:
>>  =C2=A0```
>>  =C2=A0host$ git clone
>> https://gitlab.com/cip-project/cip-core/isar-cip-core.git
>>  =C2=A0```
>> +## SWUpdate Efibootguard update
>> +
>> +:warning: **If the efibootguard binary is corrupted the system can
>> no longer boot**
>> +
>> +If you build a CIP Core image with SWUpdate support an additional
>> swu will
> -----^  ... swu file will be generated

>=20
>> +be generated. This swu ends on `*-ebg.swu` and contains a sw-
>> description to
>> +update only efibootguard. SWUpdate will copy the file to a temporary
>> location
>=20
> Does this mean, the -ebg.swu is always generated and only contains the
> update of the ebg loader? Only if the variable SWU_EBG_UPDATE=3D1 is set,
> the ebg update is included in the "normal" swu that also updates the
> kernel and the rootfs?

Yes this is the current behavior.

>=20
>> +and rename the binary in place to reduce the time the system can be
>> destroyed
>> +by a power failure. As FAT partitions have **no** atomic operations
>=20
> FAT partitions do not support an atomic file replace. The atomic file
> creation is supported, AFAIK From [1] only the driver locks against datar=
aces:
"
But looking at vfat source code (file namei_vfat.c), both rename and
lookup operation are locked by mutex, so during rename operation there
should not be access to read directory and therefore race condition
should not be there (which would cause reading inconsistent directory
during rename operation).

If you want atomic rename of two files independently of filesystem, you
can use RENAME_EXCHANGE flag. It exchanges that two specified files
atomically, so there would not be that race condition like in rename()
that in some period of time both "foo" and "bar" would point to same
inode.


But... if you are asking for consistency and atomicity at filesystem
level (e.g. you turn off disk / power supply during rename operation)
then this is not atomic and probably it cannot be implemented. When FAT
filesystem is mounted (either by Windows or Linux kernel) it is marked
by "dirty" flag and later when doing unmount, "dirty" flag is cleared.

This is there to ensure that operations like rename were finished and
were not stopped/killed in between. So future when you read from FAT
filesystem you would know if it is in consistent state or not.
"
[1]:=20
https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@pali/
Quirin
>=20
> Best regards,
> Felix
>=20
>> a small error
>> +window is still possible.
>> +
>> +If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also
>> stored in
>> +the `*.swu` file.
>>  =20
>>  =C2=A0# Building and testing the CIP Core image
>>  =20
>=20

