Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809C5C87FDB
	for <webhook@archiver.kernel.org>; Mon, 11 Aug 2025 10:01:15 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.48])
 by mx.groups.io with SMTP id smtpd.web10.44783.1754906473782018672
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Aug 2025 03:01:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=VMsBRbKT;
 spf=pass (domain: siemens.com, ip: 40.107.162.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E+Gx6mGk8L/t/UePnu3BJLBr08yVtp88NixX7BtMrqPf9nUYNcoakUgtnIBYuBYoCi0cEEQa++AJabkvKD2F86TVtObPFt2Ivb1LcF3rwg+g1HCR6CK/aqyejYgcN2li1pRSG8LWMK92PhtYl6vELbxgKests+JWqsq4rYr63v77/+9CtPUUfqtcV1ptVp/dXmKpsVnQ578YkFLP2A83O+lX4N4yvR+TMS9Q/OhiCvIuNWiOnjqrEuis2zJeaIeqYcLFueyFeZhdOSe6dfiDV7mh2t3OYVR47rJBsYG+5oC16L19wLiQtpDQ2zeifxF3Ezir0cDU1ZGbj/XI0mUqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL6dyR7c+ltiRB8haqq5NgIlzHR/aH/+2lms5me6MXE=;
 b=uJn6aKUR35qgO0vDtMaqcRpA5ZdcaxMEUiCGDrqlTUNsTKE8J6xisJ0jecd+1+h1247fyu/8uHcxCa/L9evN7+9OWR51s6R/REpunwAZrlvX4182BQSDoY3h8ubc8ldTrsSOuN5AYRPvJGvjhrnzh7AZT+gL6+R8c/AJcEogzPo8LpztnZlLxM4/byP7sAeVopoahjnU+g8VOP5Nn73LfQ2HELuVnFDPWd3dvNCMXaW6YRTP1Iqd6SV+r+3F+DNxrPblg0hZG396ALiTg6aLfO8TfB0WfhMNwlK88VdcJZwlBW4LSdF/AyE2v1F9NL1nS1QZUjbofKPcLxYjX8XxIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL6dyR7c+ltiRB8haqq5NgIlzHR/aH/+2lms5me6MXE=;
 b=VMsBRbKTjB9eQQpo2cki+0nqhUKC+hqV6LkPEvs1Dj7h/IXt0F8GEA7P/tV+scFleznKJbvSkug35xhyQC9Lf9hUw1H6n+Tqwp1+xT8UjFgJR8FwzK6Qs8MtH7aa4tl1jxninyxNmzNXOXS1lt1wdtBBfdlZ1RA/BTJQDx/mTEjNM4O5pW5wDtKGoRJULN6R/UTbHof3GQ6w9NilmWxlT8+9wo9vuF2Sr1CZFcO2aiAwsFJaenXlLxnVJaWGfPeUX2QvFzpn/iPoovS7hwi2qX1jox1e89l2YjG0tdM+Z0hfqtz7Bl4u7SNoMyqoGDUaiMsH7hpIGQZRm/ABJJMSiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by PAXPR10MB5616.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:246::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Mon, 11 Aug
 2025 10:01:10 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%6]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:01:09 +0000
Message-ID: <8e20d8c8-41ee-4d30-b51e-fd1f95c2b2dc@siemens.com>
Date: Mon, 11 Aug 2025 12:01:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 1/7] add factory-reset-helper
 to set the marker file
To: =?UTF-8?B?w4dldGluLCBHw7ZraGFuIChGVCBEIEVVIFRSIEMmRSk=?=
 <gokhan.cetin@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (FT RPD CED)" <jan.kiszka@siemens.com>
References: <20250731120043.333345-1-Quirin.Gylstorff@siemens.com>
 <20250731120043.333345-2-Quirin.Gylstorff@siemens.com>
 <PRAPR10MB54225CBF1FE9452C812D29F88022A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <PRAPR10MB54225CBF1FE9452C812D29F88022A@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|PAXPR10MB5616:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e33833-9242-4df6-2625-08ddd8bdfedc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?4sAd2MG+crKQPoPiT9TA/+Xok1C4SVHl9MMrF/xWGqIEiiV7u4/Z+stm82zD?=
 =?us-ascii?Q?Skk6a6gMn0vDZibmy5owZRw27DrCQRdoajXbWWCe0LpzvCPn53RWVtjZbjAH?=
 =?us-ascii?Q?zotYLhQGc446XhGXd6G7jD14rx++JSSeM7CRzU80XIscCW7DpxPJ5LMu8a5w?=
 =?us-ascii?Q?RvurRGQUcOBlo4kzM//t720W+BRyFax2mzzMYp8JzlYiy0oh3KmiF8726M89?=
 =?us-ascii?Q?Ili2sd+1HM2burPdZ7KHH7KfsW9G+/T+hz4d77NjF1HelFWvsQq0D9VvwM+i?=
 =?us-ascii?Q?L6m1sRNQCk8z4xFWiXZjHt/P8UPxXwAnjU9uEEq+3wVbzLvC1DaWs8m30FpO?=
 =?us-ascii?Q?8oN2ZhODcuRJJ66iFaHOlVFtxmA3RHxA7L++7vMB89ZOKYRzGTKoUshm1gBS?=
 =?us-ascii?Q?cnIDcG4Kr4s6USfNFyerxC+c7pklGKr6NlegaZEXr9wh3l3szahRJ4Nn4ozG?=
 =?us-ascii?Q?o7W1sMSM8GM4hEDIPDHxBc+PeqaGxOxOzUlQIdsG2qZQ8FqkSnbOuDQr11Va?=
 =?us-ascii?Q?r6u1htoheNIPxvoL/qalbLxaUJonqF6koEHCr4LMvAtNqmdPpSPgkRJEql6y?=
 =?us-ascii?Q?F3LwGglstRHz6DNUrpjOZT+iE5M8s24qRmo9b0RxySBN2U/+KSIJ7dZW8h1V?=
 =?us-ascii?Q?uJ/KcwVUNKo+yzetfatrzhRy9J+hbFvxYy2Tntwij1ofJ9GA5wJaMEANRGGW?=
 =?us-ascii?Q?yfMJPzmQejHnIFtQs4XR36gdyb08ZmjSXGv1zMNLrc0y3yRAfhn3PagyEvd6?=
 =?us-ascii?Q?CdmglsH9aJB/ifX5I56RhPMHL+vud5xZUaE7esSLpwJ+OeRyqDoBtol1pi6j?=
 =?us-ascii?Q?mZdnSntuS41A/728pZKnBdSuxg8UkiUCQmPDZQ3Pa8qZdHsAsDklveVxJMMX?=
 =?us-ascii?Q?SKDj5FWSrgHx6yjesY6PdNy3W4xGwJE9OBEvgF4BgKvE2snZbef1ZZQfWWHK?=
 =?us-ascii?Q?Bz6ZjcLnIvYdO+khCT/KVn/PsYTV0m+yitkLPeqkNiolm504CmrT2gblCWi/?=
 =?us-ascii?Q?+pKxSKxT048OdWypBNDw5XcKZhsgmKi4Knz+uqa1L+n9mRz9wCOHK6bcpdCN?=
 =?us-ascii?Q?YcAVVIVPBPEPlLOawAEaTLnXF3m1C/Dm2JmWStFxjWsNOuWo91BpU170SzRK?=
 =?us-ascii?Q?Zp+8t4p4RJt/5RnoiUoW7YbFPIKy6APwK4D0Dgg/igErophyBNInucC+iuQX?=
 =?us-ascii?Q?4Dy5hzmv8nzVfYPPp2e70pjNLFioRyJ4pwEsCAyUVc5sU2t8q3EIQMRBmXN8?=
 =?us-ascii?Q?X9RhX+MhrFI1pDNqE6WP79zi/70DrRWlmnlevy0cDY4IYz+yqC23e3BaPuMn?=
 =?us-ascii?Q?NJp8lLFxKy9pDzuCcf+8KAz3JhVET+0aZVuoNYoNRvCaC9h1IeATlsIE7y9d?=
 =?us-ascii?Q?yY4BmjWPiOxnOMw3oWhUxLpaMXX4N3J+Cs3g9V5nSevDbUKzsHOwnvzvzbZA?=
 =?us-ascii?Q?vWV1CjJ5nTk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WmeE+miAFD4PLsaZ3Mn2M7hIv8UUMPHU8aMegmKB+8izaFWrKoy61y5XcDac?=
 =?us-ascii?Q?zMHdrAqy8Z7N74Voj/01ziQ7m619JXfjjviqpQeiXJvF1wC1HAW3XPE+6B59?=
 =?us-ascii?Q?C6DpFNlDTtngyT385OpdRUfH4fiI6CnH696N+80ezW7xR4adYfGdZg5MQESp?=
 =?us-ascii?Q?i5Ed6+gzfQ1mbTZkfws80g/pZsIuyI5Eu7WvhN7Y2oV8ryVKIkUiEojD7dzv?=
 =?us-ascii?Q?E+lZ+0qyWQ15f04lw0x5yFCre5bQDyusWNypUxmW4EdlTee8aGwsSMITwcqi?=
 =?us-ascii?Q?42IC5vC+qkSzSrH3VZtJXAV7C7dxzzwFi9t3SYmUIm1DgPy0FCx/pa8JLovB?=
 =?us-ascii?Q?wS+tmVjB239BCW2MASNd4IUPJVevZov2pPrkg4hmv0lQVRxkmhS/NoxL3qo1?=
 =?us-ascii?Q?1PFawQiPuQj69zY6i/G0nNt+7RJsGq9NNIUrQMb8t0+jr7sIQCFI+u4dXIbZ?=
 =?us-ascii?Q?YYLKIVFfo2+OfUwo3HBHfi8LkZuCtWngiGRbjdNj+DS19Fh+empuT/Rb74G0?=
 =?us-ascii?Q?4F6l5f7nFRPupbCxbvwt5t4fq5N0WAvrp7qTutscHR7m30rjb1Oiy3nyTIaq?=
 =?us-ascii?Q?7cj/qIaTuzTRQPQblbSMU516wYoe3Br3wcKYpP1Z1ls6pmxTJpLr/MPvdxPZ?=
 =?us-ascii?Q?2osVFPZ5hVoE3NbkbsjGOPQbpjcIrag3IjMOkHqS7rJeJyhMpzLLEK9N647u?=
 =?us-ascii?Q?fd62tP8URqWkU2Q9LZNAMjHaehHR4/yqRi8viELZ8FKrh1awlhto0OMXQvsV?=
 =?us-ascii?Q?9fEojhI5tWKoUBtxE8JPqawe8/LK4rsWrcFNOcu/WT3V523n85Gy3E7aGban?=
 =?us-ascii?Q?9CyVoAc5/EHJfCU5Yb15jN06MWUziBGaD+P/v+btZe+Y9OQ0GvF5KxaxfTvA?=
 =?us-ascii?Q?d4wUJK+wjhTnj0G8Y1enYNk7aJh7H6+OUUtOig+LbujuARIh6AV6vj7VUUKY?=
 =?us-ascii?Q?aThZZM2V2a788+rEK2Ra/sLKhxRW4suRKUymZme6/TrRW0adHDP7Ee/Fkzgu?=
 =?us-ascii?Q?lKf3eJ/l0rkCbAAMqIupbEGcLdzFZXudhOFlG/8y5EjDy4HY8laCjMX+4uWI?=
 =?us-ascii?Q?0+3dvQtclQygBzglMyAalvM7zYbuLi5nU9MpT0Iw2wO36eVoF5qsmmP4skAD?=
 =?us-ascii?Q?kx6ZE6QWIv8d03brj8zYctY/42+nl14ACwGDGxVoQUHYKPfZuXRQsd8kjCuH?=
 =?us-ascii?Q?9KD7EQknIffw347uDHjsKDFMQ5axIdwk8BFMVbdv6VSuEYUhfdzbIpdLDTyQ?=
 =?us-ascii?Q?JTvnf8JHUq2j45wZEiDG7xkNIn9Plv606XTpHZtB77Vpit7MXqpg0VyHkFo5?=
 =?us-ascii?Q?m+koEDS5gxc8cyzUUFY33YkcPOhin1QBLtyVAYON+9Z+eY+kpx1aFoIkksLr?=
 =?us-ascii?Q?zxa8wAKhT5PTHucX9DCoD690OxnkucnsrCyoV55T98v130shuaXBsj/tWgdq?=
 =?us-ascii?Q?FTeTCrhI5SFeS5XjAbnWkMndwT2HaC2r7LbVX66IjLK6x+uBG26VN2TAdpBg?=
 =?us-ascii?Q?YsPL6z6Qq5kNe38ycmmfoFtXbbwwtYOV7ZYKARWQocmC8/zU3DG92Z9tOgpP?=
 =?us-ascii?Q?t19a9uDJx003wrT9DiJMirbJveUkQP3dJyAv45E/PtsoosiskKuyV2dy9Dmv?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e33833-9242-4df6-2625-08ddd8bdfedc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:01:09.7158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AFPZ2Eu/msQM3wri4OpUKQeveQX0lXsH+stnwSwF/RKI48s3VH0KZTz9xpxpc5kW75XmB6CRWNDdeXhwO/nC3WHqfINf42cSW4/VrIikNrQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5616
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Aug 2025 10:01:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19715



On 8/5/25 20:15, =C3=87etin, G=C3=B6khan (FT D EU TR C&E) wrote:
>> diff --git a/recipes-support/factory-reset-helper/files/get-factory-rese=
t-file.sh.tmpl
>> b/recipes-support/factory-reset-helper/files/get-factory-reset-file.sh.t=
mpl
>> new file mode 100644
>> index 0000000..639167e
>> --- /dev/null
>> +++ b/recipes-support/factory-reset-helper/files/get-factory-reset-file.
>> +++ sh.tmpl
>> @@ -0,0 +1,45 @@
>> +#!/bin/sh
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2025
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com> # #
>> +SPDX-License-Identifier: MIT
>> +
>> +marker=3D"$(basename ${FACTORY_RESET_MARKER})"
>> +marker_storage_device=3D"${FACTORY_RESET_MARKER_STORAGE_DEVICE}"
>> +storage_mnt=3D"$(findmnt findmnt  --first-only --output TARGET --nohead=
ings "${marker_storage_device}")"
>=20
> This needs to be fixed: storage_mnt=3D"$(findmnt --first-only --output TA=
RGET --noheadings "${marker_storage_device}")"
>=20
> Additionally, I haven't looked into the reason yet, but when running on c=
ip-core-image without any option,
> no link is populated into /dev/disk/by-partlabel, so this might not be us=
able with base image target.

What kernel and distro are you using.
>=20
>      "special device /dev/disk/by-partlabel/efi does not exist."
>      root@demo:~# ls -la /dev/disk
>      total 0
>      drwxr-xr-x  6 root root   120 Aug  5 17:40 .
>      drwxr-xr-x 15 root root 13660 Aug  5 17:40 ..
>      drwxr-xr-x  2 root root   220 Aug  5 17:40 by-diskseq
>      drwxr-xr-x  2 root root    60 Aug  5 17:40 by-id
>      drwxr-xr-x  2 root root    80 Aug  5 17:40 by-path
>      drwxr-xr-x  2 root root    60 Aug  5 17:40 by-uuid
>=20
>> +tmp_mount=3D$(mktemp -d)
>> +# check for marker
>> +if [ -z "${storage_mnt}" ]; then
>> +	while true; do
>> +	    sleep 1
>> +	    if [ -n "$(blkid --output value --match-tag TYPE
>> "${marker_storage_device}")" ]; then
>> +		break
>> +	    fi
>> +	    time_elapsed=3D"$(time_elapsed)"
>> +	    if [ "${time_elapsed}" -ge 30 ]; then
>=20
> Results with:
>      /usr/sbin/get-factory-reset.sh: 23: time_elapsed: not found
>      /usr/sbin/get-factory-reset.sh: 24: [: Illegal number:

I will take a look.

Quirin
>=20
>=20
>> +		log_end_msg 0
>> +		break
>> +	    fi
>> +	done
>> +	if ! mount -t "$(blkid --output value --match-tag TYPE
>> "${marker_storage_device}")" \
>> +		 "${marker_storage_device}" \
>> +		 "${tmp_mount}"; then
>> +		panic "Can't mount ${marker_storage_device}!"
>=20
> "panic" and "log_msg_end" are not usable at runtime.
>=20
>> +	fi
>> +	storage_mnt=3D"$tmp_mount"
>> +fi
>> +if [ -e "${storage_mnt}/${marker}" ]; then
>> +	echo "factory-reset was triggered"
>> +	# delete marker
>> +	rm "${storage_mnt}/${marker}"
>> +fi
>> +if mountpoint -q "$tmp_mount"; then
>> +	umount "$tmp_mount"
>> +fi
>> +rmdir "$tmp_mount"
>> +
>=20
> Thanks,
> Gokhan
>=20


