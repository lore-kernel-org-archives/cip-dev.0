Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B2AC001B0
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 12:04:23 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.53])
 by mx.groups.io with SMTP id smtpd.web11.105652.1692014655317630309
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 05:04:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=IP1ThSrD;
 spf=pass (domain: siemens.com, ip: 40.107.8.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP4nJ7P/qVtdqqDMhWia5kQJGEXYofN67DHsoVOCWA68MfgjGsW/SP0oQDrrsY8TKyL3RWCUg4Dp8uy+pGHJn1EV/TqUsSWpUkVteBDFsy49kH9NvZNhl4BUqhNzvPebNSSZ44dbI0AUXX23kbIGjOEzuJX4cHBYxqwlOevUoQI/adbRSLD5j9rCrJyaibQeKeo1cixjHTjfXcjUTn+HUdMiHo3i28h7hnGOq++Z5wibDrq2ZxoZj56/hL3idMXSrGD1NTmuleNW4L0rNgFrSo0X1EO/Gq7Tg1gcI6QA9xKTcHtuu4iRkTqRyaYJkGU+SdPdxCVs77GC2pN7Ur8nwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7AG/PYEo/h/FqzliojK8W5o0g6RkTcgUnr1kR1Pip4=;
 b=kSnQr7PbJyL5zsnWRcHZYtvYCOe6bDpkts6zNmZG8ZJTVgF4O3TEJICk0nJiFjdQZE2E40uwMM+3U3dx8J80L8TiSP5SnXzkG9PdlN87m2xuArxx3+4fLYNMKaqgfXSSXR84Vy+sQmOuhxJ34xqjlC7PkEEJfMcCs7Y+6aP4t/NG5HbP9K7FRu7RXw0Gu8HJg7bT/ifXQqG+XKrAukUW1htxzo352xbMUojdzvT5a/31JEswB3zpAFNh458qqtPcZjG70uDYROScPAwSXB7f/ryy2zY7sekWLVuO85U5A5oZW1BmwAy15rFxBqwECbDIbhTF4MxLo/6Vs/b42hhQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7AG/PYEo/h/FqzliojK8W5o0g6RkTcgUnr1kR1Pip4=;
 b=IP1ThSrDHcmkIB8Q0nkrzMIeayXMic0UN2nO0S7ceihZobjjNwofXjkdyRAKHa6zQSFmHEBHbXqen5wrhtWZTLMYh9lijeBQBdZur88JRDHNDh7SL7PbGABHk0xTJz4b10K48/pk4THnveXKlP+bNc1bVgqUt04WXPS2Eoc+9VstSRPA/IDq7IuGozExplz5wG8+WaA35arPryk+P5IS7hNsjJOwNzDpWsH0MP4DwoRnirbFR8P61m48tRH20w4owcLOJkkLrVjLzbMMWyD6+8s+SksQPFHeP+J/iJ1HCZZnc9PXgOo2SQFAxmwlwdKBdDpSE7Podl4cl2d4+eRw6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by VI1PR10MB7809.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 12:04:11 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 12:04:11 +0000
Message-ID: <cafaaf41-dce4-3da8-f14f-dc7ac4c20db8@siemens.com>
Date: Mon, 14 Aug 2023 14:04:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-3-stefan-koch@siemens.com>
 <dada78d8-aa43-470c-bdb2-d55c7f90dbd1@siemens.com>
 <88fa04c6796b3b2c69adb7d507f9a6b54b531c96.camel@siemens.com>
 <5d54eeeb-cce3-451c-a28a-95eb669694d9@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH 2/4] initramfs-crypt-hook: Check and repair
 filesystem to prevent resize2fs failure
In-Reply-To: <5d54eeeb-cce3-451c-a28a-95eb669694d9@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR03CA0384.namprd03.prod.outlook.com
 (2603:10b6:610:119::26) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|VI1PR10MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d530613-cb7a-424c-ef9e-08db9cbe922d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HQ6pDHiyfIxjqvyFHehGBjCcLRDLIspv3v2LFfGM7KJi7I8IlxqgX/3T6FsaR1JmGs/qvg32ItAO1ZTvnVj5IhWbwG/dDfq4TCyYGuPLPpUusZcc++XdvC97h/8x0H+tFyDqdVe3wy+BsVHHEdwYfeSishZGPSMAKxPhLc49rcJYyrv3xci+WXaFnULBwl7DQPNTJhrvJr4gS38VgwSgvu3kPhxA7qrNOjcF2Xo3bQ1yjkIy/8GqcziLX52OeajbU5oa75rl9Dy//LG9kCw98cLw1ttu8hPgZSR6eOpckauhhX+tI2tSVXkde5R0YMLJmwlw9tPvv6znfsh+Wal3iZZTDWnFLAIrQVHBi7bmRbtbHYof8OHbDsXdcJOic5QE5UB+VXBooGyliaDlSeUVS4InKhqm8WcvIiDBUFqiX3ceRvBqQKzwVHZZMC7xzBIKbRCwk4FKQZTFCWi3TPtGmLERxhgEQeR0pqswY+S+yMqdgmbN3qsu2uNVIzjKehT+4BKfuJ6L24RlR2rPecPLUi2ZnLEZv7rzZ6/lYmC1bSu2LIfJr2jIr1+URbUMHrLgj84KCReNUAhXs4cKjzqkQ1erypEE4byPLOSCuyrqyPMrCUHEZr6PiVTkYpKcyo1/yO7jrLMotL2i9uikzKcJLQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(186006)(1800799006)(451199021)(83380400001)(36756003)(31686004)(31696002)(86362001)(38100700002)(41300700001)(110136005)(478600001)(66946007)(6512007)(54906003)(66556008)(66476007)(316002)(8676002)(8936002)(966005)(5660300002)(4326008)(82960400001)(2616005)(107886003)(26005)(6506007)(6486002)(2906002)(6666004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xjxHZyceKUXPLpflU1325cLHrdHG+Tyr2Ts4NKd22xNcNFC0oHAxsvbGa/xy?=
 =?us-ascii?Q?s4dwlfqoIi1Q1u4lb2WyT79Tfe4PfJZ8ocDoPcRQ41nmWXqDczZN7k8QytKp?=
 =?us-ascii?Q?61Id4WZZmbMYLOpebZqNPSqp97uJBmWNNi6ck6SIwPxatN8shIdZdLIZL7TF?=
 =?us-ascii?Q?2FHro9e8snese33PiAcHcUX5aKrscqyLwJZhp6gHgWLYsRPJUzgB63pKkRD0?=
 =?us-ascii?Q?puWlr5aCKLyE++ohDn6QtLRlC3QHZ0O538VapkiZ/TCX//TUKWgDWeFTABe8?=
 =?us-ascii?Q?TSYJ7p2FPW7JRZp63Lp6Q7oasu3PWqtxdVGbzkDbo8XCsqK4cyIBqE2+0k9L?=
 =?us-ascii?Q?o1G3BdVvDhTu+qFrqwRfjkjjmHoFFzIJCdEGJOuSn4gBTDKfuLwTnVAmIidR?=
 =?us-ascii?Q?QWCv7w4dlxqA4F52r4BvdBiIcazz9SfzP0BLzg/4c3ibTHeK9viSpfC0ATNp?=
 =?us-ascii?Q?7Iu4eW07ltfv4Mh9GThstIwg2RNYWYb5qTsvW5GtkFB++Brzm7n/bAMyfJF5?=
 =?us-ascii?Q?F2NXlNx2XdswivIA2gSf/xsQhTEs37zVhcCGuUV7v5MXSRLBERNfPXO2Agz/?=
 =?us-ascii?Q?HWicDb1VuELtfTLjxluKgQaXMtRfkOSBkndCUnepEHLElOCsjzKUTjfRqRF4?=
 =?us-ascii?Q?W9gD4L+vtDB3LWrFtOiFS2TmkqtRA+g/rWK7+p8mpjn5vhph8clChYHKhMMJ?=
 =?us-ascii?Q?qvk5CMFO7FS7fMVZJKLYPZoRZpQ1RKWT0q/YNl27FsMV/vFF+olGZ14lufa5?=
 =?us-ascii?Q?WkXfNCFRffwiQNBKBf2vJw9ldCqS9q2nUoR7hjcHsuIm7R0UyY0/ELLE4RaM?=
 =?us-ascii?Q?g+WlvyYjxJ36SVjBeBPHu2EZLhGmTuIioJg7J61OpsXUQyn0vQ3LgeilLrL6?=
 =?us-ascii?Q?LFp78eqLrpVJai6NVDDvM2yuZ015z61xRXL/Me6kCElpGnVdWqkdbAmOsq+d?=
 =?us-ascii?Q?F7GxBJpD/dE2NEOEGqwLwlfMyu1BRVyFBZ7T67meIlAHFFObOy8Aahhvkw3Z?=
 =?us-ascii?Q?oBxiLFsh6Ukp2XwokGvs5185qsvHLN6avxzZ+r/05wDCdDQMr1bZSK7g1Vpd?=
 =?us-ascii?Q?EjmBH5YLi7Lsnz6cQwK9X0fp/rHvfDefybBGa7V3iq3DepKv+1ue+/XQXFvP?=
 =?us-ascii?Q?XrZxXf8PrXhj+rKIR7uve+9wFrRGSdAfwDSmbKd3RZ0lTS783o4xSMxDdvop?=
 =?us-ascii?Q?E3aPyIMcYV8dNlxasqyDt7yGCQ6/uTYS0iICCUpmS7RPhgMJ5dieE2OwUexu?=
 =?us-ascii?Q?tMv2p7aef0ptjxPtcr4eu/vT3cGnopm2j6oeyKJGXowhKUKSXSstySAGvW2O?=
 =?us-ascii?Q?m0xNsKLXoQh73Pe4LwAbNeDuGWlH0hAuv8IXr2FIJyTLXTJ4PpSrtYKtrC4N?=
 =?us-ascii?Q?ymrKCkDZxYadoccmj+KIuDWBXIUHNiExd0/sxvLCCWv8EeYUO2U80Rkhb7Xs?=
 =?us-ascii?Q?0LF5vqb8lyB9I9dX0S5f3aUtxB0DA3TuNEvRXTTgq90dl2RoQf9gPduomIRL?=
 =?us-ascii?Q?+a7OsP7/HSC8EUjqzAhcxKgNngbMiysO/Xte9p/6UJ3LWzTu++qpaJjVcPUy?=
 =?us-ascii?Q?dZdP/K7SFkBVYGwnG3NEGHt8m/uM99C1g6tejVWEevGJWJFEFEHJhWs0Neyi?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d530613-cb7a-424c-ef9e-08db9cbe922d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 12:04:11.5117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OYbDgvgnwFsMxA9u3/lWu29CZ/Mo75SHGg111Y0URjgoDMXEXvKgqI+ibsyi46u5AxbSC+wifNPKFgYE5Y8x/5EFMXfGtl4/pnDulYGLhRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7809
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 12:04:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12647



On 8/14/23 13:46, Jan Kiszka wrote:
> On 14.08.23 13:36, Koch, Stefan (DI PA DCP R&D 3) wrote:
>> On Thu, 2023-08-10 at 12:34 +0200, Jan Kiszka wrote:
>>> On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
>>>> This checks and repairs the filesystem first to ensure that
>>>> resize2fs will succeed.
>>>>
>>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>>> ---
>>>>  =C2=A0.../initramfs-crypt-hook/files/encrypt_partition.systemd.script=
=C2=A0 |
>>>> 1 +
>>>>  =C2=A01 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-crypt-
>>>> hook/files/encrypt_partition.systemd.script b/recipes-
>>>> initramfs/initramfs-crypt-
>>>> hook/files/encrypt_partition.systemd.script
>>>> index 83c3238..b32b2f2 100644
>>>> --- a/recipes-initramfs/initramfs-crypt-
>>>> hook/files/encrypt_partition.systemd.script
>>>> +++ b/recipes-initramfs/initramfs-crypt-
>>>> hook/files/encrypt_partition.systemd.script
>>>> @@ -87,6 +87,7 @@ reencrypt_existing_partition() {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size=3D"$(exp=
r "$part_size_blocks" - 65536 )"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_byte=
=3D"$(expr "$reduced_size" \* 512)"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0reduced_size_in_kb=3D=
"$(expr "$reduced_size_in_byte" /
>>>> 1024)K"
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0e2fsck -y -f "$1"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! resize2fs "$1" "=
${reduced_size_in_kb}"; then
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0panic "reencryption of filesystem $1 cannot
>>>> continue!"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>>
>>> Why is that needed? Conceptually, we should start with a clean fs,
>>> fresh
>>> from the image build, resized on first boot.
>>
>> In our case the problem could be setting some modifications with
>> tune2fs at image generation.
>=20
> Via wic or via custom post-processing?
>=20
>>
>> Additionally I have observed that resize2fs breaks without e2fsck
>> called before, when setting the break=3D kernel commandline argument, an=
d
>> mounting and unmounting (without forcing, just standard umount, no new
>> data was copied) the partition before disk encryption scripts are
>> running.
>>
Should the same behavior also occur with the expand partition on first=20
boot?
There is also no e2fsck after resize2fs.=20
https://github.com/ilbers/isar/blob/d454381fa90874fb9a8496f9b5980ebda874794=
5/meta/recipes-support/expand-on-first-boot/files/expand-last-partition.sh#=
L79

>> What is for cases that are using the reencrypt mechanism? The
>> partitions should be in a modified-state by former device usage and
>> just installing a image upgrade that enables disk encryption.
>>
>=20
> Re-encrypt is so far designed to only run on first boot against a clean
> disk, not used before. I'm not sure if we have more corner cases lurking
> behind the corner when we expand that. And we should have test cases for
> that expansion in isar-cip-core. Quirin, what do you think?

Re-encryption after modification was until now not in scope. I am sure=20
that there a corner cases. expand on first boot with disk encryption is=20
another issue.

Test case are required.


Quirin

>=20
> Jan
>=20

