Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83E4C35274
	for <webhook@archiver.kernel.org>; Mon, 18 Dec 2023 10:42:24 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.42])
 by mx.groups.io with SMTP id smtpd.web11.41554.1702896140507498918
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Dec 2023 02:42:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=W4i7JZGo;
 spf=pass (domain: siemens.com, ip: 40.107.241.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLoWJikNFUBy+HtL3Cjgm2m8srXm4CmuvdIFhXE/K3+vGhnE2oKxIoNqlGJITcTSZXmDjVxkM5OAgIPf0JlkELYmmV31i7GZQFPF1XlSC6Wm2V8tY/Oay2PmqF1RC9QjNQrldQOt87QhoFWvwGz79/eVD3j6ezDbcgR+uxDhSYGl08cC7AombcXkrClbyXxIn2qtHbS21SeGT5nnZp3n+GHW1xWRnZexiXUcYLbGGoQdnoG18GZE9uor9u+AmVsZhhcisLrtz96EQiEfVP0QTPZC0Eu9/ltALDdmN5N62a5qAEZ+D+2ni7nflOB+WpkDcm+SFLvnOpcoTn9FxkQxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IX4DjLPayLK6zFYb8w9253jMemJeB/35B87auGAfroc=;
 b=ECLJgIC53zHJL5ogqcvuyZNsl+RqKYUyZW84NQ0Rx6Q/5NFCE62FMa/M4VjP+6jV5IEHWv03Gw9ZRD2jNmUH2dCm1cD/C8eRZDXaWHKXxbcxOzED2eFb4m9ZYTPrdDSuFv2CRVjaYkOqQjmjDDC8a/O7kmNbbndZ+g42L9AJBPqEiS2hmqx3jhKpFWeZOJOm8H/CpUVt5dfndgXQQj8Fja1Y7imG16LVKRsE7hXTsOCW+eNaDwjPbIVh8iBI0l4t6/KGzTS9jPGIAWtsSuwyfFyYOgVvVEwt8Kpi+EUFkhOevsll6hHbJhQB64jhh+r4awynwzUr8+LlJQVAQ1P5Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IX4DjLPayLK6zFYb8w9253jMemJeB/35B87auGAfroc=;
 b=W4i7JZGozl0JYcTZNcpxg01ZEEo5QAGhhdEKb5TVCh4n7FOdWVyZ7uV866LNqkKQ9qk9KFqVy8pz1pweDRJR3kc9fut/+9CHabr9AB4TF8ML4xhiiW/gOUxfojjO4GyDTwtWJimvtmUBG4HKxbPV2I2vKB4kubxW4aGuA93HM6TOJsgKREWpILkUmE+JDkY+TD6f9RpQAvChT0scYH+S2j0i6srXwtqFFpVK8UyWpAaI2g7hVLytCNK+Pucveq4j2astqzHBsZ71MWAZyG4rEKnqyyiSvwWw/n0ZuGs0bOVAlTU2z+CmEVj+1ByclSQhp5phujjktSWFr3jPlknZ5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GVXPR10MB8252.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Mon, 18 Dec
 2023 10:42:17 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::573:677e:776d:63d8%4]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 10:42:16 +0000
Message-ID: <ed0022cc-556c-41d3-9225-cb87cc7dc499@siemens.com>
Date: Mon, 18 Dec 2023 11:42:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-overlay-hook: Get
 Storage mount point from INITRAMFS_OVERLAY_STORAGE_PATH
Content-Language: en-US, de-DE
To: Moessbauer Felix <felix.moessbauer@siemens.com>, jan.kiszka@siemens.com,
 cip-dev@lists.cip-project.org
References: <20231215195526.1117565-1-Quirin.Gylstorff@siemens.com>
 <a7efd9b61a389b2178be82c1c2c889f41d04d9aa.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <a7efd9b61a389b2178be82c1c2c889f41d04d9aa.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GVXPR10MB8252:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cc8c78-efcf-439e-932a-08dbffb600bb
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	82Pf305ei6ZTT+DBjGYFR7WQQDgrGskxTpBgcUJmMzeiabu/cEcY/7fGnD96yArdNXnaTElVFrFm1FcNSI/oVjSdR6ds7/e4Ff14PLoE8VQHKcaAEqx5+HBvTV8JuX0FFC1JqXnslQ4JIjC/dnZe2HsUkIJnaErFthYmhjxDFgvY7Qpd3n03Kd1xE3jzfkQrGu4mI8s2orMoRstk1JWB7sfSYJQ0nggH1lv9VzIZRX2p05XB/Ud6sSl90rWJVjK6xMoQ3a7Y22P9eNTqpGQTB2gehAbSPKawEHqG25n3Nh/4oVRvZfAc8c1kzZp8moj9oLd3losvushz98W2tob+8nS8DgISoEIoyKp8EZSPW8aqfGbGLMnxt/OGI/iqkBlLt0dt+J74BkYK3rqTa7NFptq8KfVEB3f4wSdEPZE8YE8szeT/gPI9yBBh3rVt3D1nooFtKKMPPa6J8klG1T2HVcclpwtxvsHyvZwHxSsjnaBwx+3Hp7HzduqCbpfFRXWXYq+aklz/x3r/l+fQ3Lj39MfOBsOh9T6zR90//+VfSEXXffK7F53ZlVP/reN/re4NjsohMM1YIZgXfjop5f2uzG4L84chY6ezpjNaGp/kFYTHDkLWS25/WiTHAq1fAUDmPYGoP7ZQHwcHUCb8n6XyDg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(366004)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(31696002)(86362001)(36756003)(6506007)(53546011)(6512007)(6486002)(478600001)(4001150100001)(83380400001)(38100700002)(82960400001)(26005)(2616005)(41300700001)(5660300002)(66946007)(66556008)(66476007)(8936002)(8676002)(316002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WAYp57jz1vtopY2s0/3tmX90vLE5cFvAsSiV7RX1ouGwRRAAaSBpHuYpBu54?=
 =?us-ascii?Q?V7qMThI5YVYjTilD1sE4WCOQ2WLlhRdADqNr3wk+Tu6VvhjkWTNUEvxXyF8Q?=
 =?us-ascii?Q?PVyhSnxJdpaG+aH+asVvr+qtS/Q458OXLCsYSKexje1peVaLlHHlc9vXfxzy?=
 =?us-ascii?Q?FE1t5wtyR1aa9vuikIdsa1Qzz48jG5ZLyR2Pp9lKWgLxPJphFuDatjqN9mZ3?=
 =?us-ascii?Q?J3eGRS5R6OhNU63SwjZpOmA5BKLISvUPF8xCNZKLKROhpbTdGyCAFS4uq3qU?=
 =?us-ascii?Q?WIzjdcQ+yf4conFNG6YV541ocHtS9y0ak+9uEEEqFPrX6i5B9yRByrY2/uou?=
 =?us-ascii?Q?y4zx7fZ+hf+K2CAXCy1UdDAISo8/0JGQZjv8+7aux+IMN25m5LtOc+tCVUcC?=
 =?us-ascii?Q?trzVY3P4aa9siQ1agP9pmOBLwz3FbPfpdiOhDWlYmAKchqnpJXFti1AOJiex?=
 =?us-ascii?Q?uq1MEfBGbqKmqzp6HC+V1WO18oxt/sp/aaMGsdS2lem3z5r3px3f387i2+UJ?=
 =?us-ascii?Q?hBgxOeizWMk+ngM2ox//HHwiZqqnUsBH4KDUjiZ0/n8rXCuQaTg4jXyxrPwa?=
 =?us-ascii?Q?po+j31bNYdz6HWUEUVSgoWzu44wcN0EjapN4OBE4vEKBL05zBoN5O10YFnpg?=
 =?us-ascii?Q?dw/t1zPtdLkKa6Zuz8LJ0F2/dKdCxTONPMCniuRiHTXRtiYbGBKhA6YDoSBp?=
 =?us-ascii?Q?qQUlktV1F3+MpzcB9HwMJssVJelKkX4oIZZfFncYO8eqKQrGtB8EAl4nAuUX?=
 =?us-ascii?Q?aoHjS2MA6zuBR2AIFOkh/o/tzshpxW9+9snpuRoSvVK0CwPEv5v6zczZbDYa?=
 =?us-ascii?Q?o6c5H14qx5DzATJrm/fJltPrSKjhUq17oKQcV7H923wYVcVCVJ5oOXvDKzdc?=
 =?us-ascii?Q?EwKueRXiRqKQbAqE7lKehMj0OS1jMUHB2ON8p3v2NYX5faDCGWITx6NMsxv9?=
 =?us-ascii?Q?H3Ls5MpMlaxWishcT4KO819E1fpi6v1GfbJ8m1sHNnZVmCp+OUxyCPoEL5Mg?=
 =?us-ascii?Q?aDHLerKZxotYSHutvznn8EdiUzszEh49CEzWhw8OPRXaKpa6soM+vL3pdcT4?=
 =?us-ascii?Q?KI3mO3F7NnIKbRpmNYKYCDZalSjWwozp5xi1oqpIumC90vJL5QPTPVIfSm8G?=
 =?us-ascii?Q?/pcWhPPD9l1uBauBT5KBLl8N3aTO0nLbeZkQA+tq8OefeGLZ2OQQhe31ZP0e?=
 =?us-ascii?Q?QB0Bx8193BENbNZLk9kO4aX4T1l8mF+ERNupw7URztyr6LedqCG256nhWBtK?=
 =?us-ascii?Q?Bv/OB4wer5t4HhJzKa0+hIo/lxYpuoDs1Hn+IUIhF1p/tJNDXvtsborqkybY?=
 =?us-ascii?Q?nXHarZbitl64recUrQFC+I3zWDc+D4xoWzPMe8jGoQMTJS2vzAEYdqErEID4?=
 =?us-ascii?Q?7FPk8cw2JFi+tqx1OJ2l5mnwMZv1tk1/KbRsaw6+nnDHMjyIYqp/4ApcbWUZ?=
 =?us-ascii?Q?wBhaYkPhujNEsnDz/NNQbgTmj+z1X44QK/jkGd3D4NyRazKSeYPtJ9fA2V4E?=
 =?us-ascii?Q?WBZkupgtD69d1rPdspvwCS3RvT5PP2uLPb4CEZKF58oMc11dx2ZZKAXPIXG6?=
 =?us-ascii?Q?2DvxMgED+zVOn1ucM/XeQem6Gnwv51AFVJ9GK8/P9Iulk8L8hc7BbxxafEoC?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cc8c78-efcf-439e-932a-08dbffb600bb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 10:42:16.6698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bi59QXa9f1xP0EiepcJCNf+NqkyxO4UpCEG0ZamCKsg4VlY2Pt1GgsFR9Aaqr8pJltOPb8eJhHotkwJfHZDqmAVqJkyEWIqkth+qoJY8Emc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8252
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 18 Dec 2023 10:42:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14130



On 12/17/23 07:58, Moessbauer Felix wrote:
> On Fri, 2023-12-15 at 20:54 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows to set the overlay storage to another root directory for
>> example to store the overlay is /overlays.
> typo --------------------------|
>=20
>>
>> This restores a similar behaviour as from before:
>> 725dbc99cf9c4956fe7eb04d3932423782b7ce57.
>=20
> Hi Quirin, thanks for fixing this. Back then I was not aware that there
> is a use-case to change the overlay path (I considered these variables
> to be internal).
>=20
> Anyways, a bit more documentation would have avoided this confusion.
> Could you please add a comment per variable what to put in there.
>
I will add an comment.
The issue in this case was the we derived the mountpoint directory from=20
the variable `INITRAMFS_OVERLAY_STORAGE_LABEL`.

>>
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0.../initramfs-overlay-hook/files/overlay.script.tmpl=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 8 +++++-
>> --
>>  =C2=A01 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl b/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl
>> index d7da6fb..e9a5e40 100644
>> --- a/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl
>> +++ b/recipes-initramfs/initramfs-overlay-
>> hook/files/overlay.script.tmpl
>> @@ -1,4 +1,5 @@
>>  =C2=A0#!/bin/sh
>> +# vim: ft=3Dsh
>=20
> Either we add this to all scripts, or we don't. We should keep it
> consistent.
>
I will remove it in v2.


>>  =C2=A0#
>>  =C2=A0# CIP Core, generic profile
>>  =C2=A0#
>> @@ -32,12 +33,13 @@
>> ovl_storage_path=3D"${INITRAMFS_OVERLAY_STORAGE_PATH}"
>>  =C2=A0ovl_lower_dirs=3D"${INITRAMFS_OVERLAY_PATHS}"
>>  =20
>>  =C2=A0root_mount_storage=3D${rootmnt}${ovl_storage_path}
>> +storage_mount_point=3D"$(echo "${ovl_storage_path}" | awk -F/ '{print
>> FS$2}' )"
>=20
> How about subdirectories? Is this also supported, or would it break
> here?

Currently we only restore the previous behavior that it mounts on=20
/<storage_mountpoint>.
If the user sets OVERLAY_STORAGE_PATH to `/overlay/local/foo/bar/` this=20
works.

If we want to support the mount point as a subdirectory an additional=20
variable would be necessary.


Quirin

>=20
> Felix
>=20
>>  =20
>> -if ! mountpoint -q "${rootmnt}/var"; then
>> +if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if ! mount -t $(get_fst=
ype ${ovl_partition_device}) \
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ${ovl_partition_device} \
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ${rootmnt}/var; then
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0panic "Can't mount /var partition - overlay will not
>> work!"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ${rootmnt}${storage_mount_point}; then
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0panic "Can't mount ${storage_mount_point} partition -
>> overlay will not work!"
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>  =C2=A0fi
>>  =20
>=20

