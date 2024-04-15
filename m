Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B08C4345F
	for <webhook@archiver.kernel.org>; Mon, 15 Apr 2024 09:33:56 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.57])
 by mx.groups.io with SMTP id smtpd.web10.16822.1713173630558472037
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 Apr 2024 02:33:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Ctx7/yhv;
 spf=pass (domain: siemens.com, ip: 40.107.22.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc7SETqMTN1zS6WJFMVpWlY0anCxezRG64NLHBggdrgkPBYOp5WTdzLRjhmaaq/MS19MT610IVMYobeVP9ki2zBo7ce7etgJc7VuzeXwRhPeujLg7C/IO1+cgFAX+hJ/slkc14UfWsPI8qq2XjpymmyPAfE2eBcRJGMXD8/iFkv48zsFxduB0+Sa9DA9t9z0XFzCsq7Nw+G47Knw046+4XC4Zm/ewB5vv1Ga5EeuIQs+KA72PydgYa/dHOhKosuE8TEEOfPu7Rx9ty50q3Th1ZhkwxEBJh+aH5nTOrG+aNckPEGnU1Cu42qLkVkiLzNL70kujF227Gto2eqj/gt+Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcnzfRek/De9ZZFuqks5MRc7YZk6jSMddRApKFRg4kA=;
 b=MpXiOcoLroG7/PBifWv5FNa626SY45zGiV49SZ8F/ehvlECrZmC/xg+usL2no+d7okMUaXejMLNmC5TWwaX29OApOU7tXABmdsvZ1HCfT5ZS29ki8qyiibK45Sz18YvoJUGd/iouPcv8hU68HsnABU6jVgrZPSPp6LeaKsAbCqva0q7AWPHLFHSX3qW+S6MPnB3Mj5KzTRRSltvgsEt3lTed9g5tXnrQZTE1I2TZIqiER9MKDXaRcjwRwd/9whOKvBF4e7sdETLHeRrj3IzgUMv3aUn5dJii3p0kq56xHSqszDne0JYZ4dNAKDl97GgYJV7UV4TL//Ox0xru+gTT6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcnzfRek/De9ZZFuqks5MRc7YZk6jSMddRApKFRg4kA=;
 b=Ctx7/yhvjslHIoPxsuwUce8phSCeLhThCr+baT6qir6GwO0yTJhFP0EfZIv0ClcOD3jiF9j7HXxOxghL6AC60jckp7Ay7wBmELn97m9oTPVKSkCVEG9nW96DSgHqIvgbm4lKtxuCkKkydf6vTKkzYHTW4+femJOkDXTTnJdvomTjis9VdNE6JSYUclQQBpW52DwFOXFZ4QtJW3mReSUXiWpn34k1GMyEUMJni8yKerT8Pd/SVXhebQ/N2dxHcWIIN0TleUUuNKup6Hq4Mi287LSRwRpiNWHeu0IWA3ocJPM7vRbImQLpR3m6mhzqlWoVBT82OFAFBYkYrczujVOOlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU4PR10MB9023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 09:33:47 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 09:33:47 +0000
Message-ID: <207aac86-e0dd-4083-8d20-c84002f7840a@siemens.com>
Date: Mon, 15 Apr 2024 11:33:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Bookworm with swupdate 2021.11: Error getting key 'kernelfile'
 from bootloader environment.
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 Hannah Kiekens <hannah.kiekens@essensium.com>,
 cip-dev@lists.cip-project.org,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
References: <CAP07BnkpBLJ0vnN3FUJZp+DDiWm8wjj5F3=wMNfabqjPJvMDDQ@mail.gmail.com>
 <71e9f4ce-970e-41b1-b4e6-ef16e184a77d@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <71e9f4ce-970e-41b1-b4e6-ef16e184a77d@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0197.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::7) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU4PR10MB9023:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2147e8-3991-47bc-29f4-08dc5d2f268d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JDeNaJTfmpZlr8NhWlGc8D+R7O3PCHKKOt1HztAjW6MMAaPIYesBSBF8vUhHc26XGJPdSuuWT9XFHLh3gu288Mm3RDb3IdX50b/tOUSvGlamSDiNUhwfyh4y1Lm1N9c1kUYzq5srjkP1KuQ6nEWuTzAxwhxbz/jbHbAgi2VaEPZFRFEn7Wgg2cojGr5N8N/Y17DXAA5W3jX1MmJuIYnMHzNPSd0ujgU6Jq+x2XYi/iksqHfTYnEBs6mPXsnykb/T2ORa9VLXCt29QTvVO0crHsEZeFTklXk8Fk4BVmlFbCBNqYc12xFugMufwHp1tBKJOIl0izwb9k9evWVXTxmlOcYIauThNkEMdXKisqmpPnEAQjGkJlWiMfFjMTvRlTYw/yUMU9YWRtXJZm1GNgH7JEHmC4SH+1I/rYB+b4WQDQQQ3kso5CWyBpyV4ZPayisfMaYAUP85Ck/HZGeO0BAFgyoVjcEA4MEpE96BPTkxocGg9b0W3P7nVy7iGV9jiI1uHkMmUFh69LqW05UlBCQcjMg5OMHZxlLtgJyoJF54LThjM2SRfrtXqVMfEYTpal/QNFG2dthZPcDO6JEcYVyPOWU6jVcobCZey2pJANooClrD0GrHvEOOEZOQMBFCEWnA45a/pJ/NRzBVqoRtRsHgdBmzqEy6K0AQ44n+MkqIGms=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?erzDSuaMx0Zp9xbhs/0OlLLQld0NOXCVHdC5ulmNmjFcZBzat3DND2ey+gHM?=
 =?us-ascii?Q?p1vuGru6wI9vtqUxjZ7QFGei7kIGav4c2QTD3fJTk7YwiYtVtzw3IXcwktpP?=
 =?us-ascii?Q?OqyW/qwGA+91MttaG70WlePVYJWCXPzwIaUD5fCDgMzW/124fw9KOj15e33O?=
 =?us-ascii?Q?jCWwN6QPsPt0fSjLcQFlYHvb8htoLPi/hym04C5A0fmTmhRT6tGnqwP+dTdP?=
 =?us-ascii?Q?RR22z8wzRwwYoCwLV0PawSMlBEi/+jV4fhuNHqKx6KyQh9gqjknLSc7QB+xP?=
 =?us-ascii?Q?7hy1HnGrmkqGdh9C+3gg53rg9Bq6ZbC4fQhLaKKHT0CFirGJdm0FNXhdleFd?=
 =?us-ascii?Q?CpIhFrecRJeVlJEJCQfX/brOEtERFY46Aup5yHnzqN9kDKIq1tVPEcaBZqlz?=
 =?us-ascii?Q?3ce2LRa4zDFNWB3nixc0X7BMlv59rutqvk91539YcJ2WDJNGyNTjHVMXmS4x?=
 =?us-ascii?Q?QYxiAsaKE+wnpKlS1gO6Gm2CJW8HhHCU3k05tLVGLRkU4DQEZHX8pXn0t/5F?=
 =?us-ascii?Q?qbCx3HCTXhKMee4O1uDFGrLYztPBKKGZk1i20kEXvCWPdCY44QGs/ST7+pWj?=
 =?us-ascii?Q?f8QvkpYJaIi27ZwIR65xgQ1TSzEozKPqv744LlOFuzW+Ty4lUcz9ilTOyXKG?=
 =?us-ascii?Q?cVoZJ5RC0JzcqvObk53e3pi6df7h7eF6Szz/r0B0NROMIcQmhqLrMdRQbemJ?=
 =?us-ascii?Q?G4VYuiY6fH7NNv5oKGo8+O+VJfTu/iDy7/o6fcDkFJxvLCPDXDU2GYz/6aBi?=
 =?us-ascii?Q?X1NOACJKaCc8SsWfEAJQHlCwoN+LPyEOXAMM6O43yiFAWjLYd4XrAiMDBbiM?=
 =?us-ascii?Q?j5d/ePcNddxlqw9tM8KP4JqUAjCkvc79DJq8sC53gDmYN4QxaDzvXPQadhem?=
 =?us-ascii?Q?rllRMmzom2zTCLs5BSR+ej2lOFGYG+n7jtJgTKT01gRmMZOzzXYzKeyU9/8t?=
 =?us-ascii?Q?+KtQqMdNOeYVx4OCzgFkPfao+BlsHTEbIlxVMNkyuUhOXRrZtUTN4Ue3c+JA?=
 =?us-ascii?Q?vREmh22wPscd9FPt8C/bgWljNQ7fmBF5TFWyBeK3xtbfvCw1kWS7v3IpT+yj?=
 =?us-ascii?Q?V6tb7L4pBkldcqxH9maJfFg1xsg+PuFodwWFtvNe+FQ6nWNIdGMU4Z4YVpVh?=
 =?us-ascii?Q?dgm24Scal4WTGid+mYvHYHy6lC9JW1041xMXqyXae6Zz3lYXzb3aJgiKzLTP?=
 =?us-ascii?Q?bR1ZdAAF5vKvhlSMI6UFXvkCKIwxsPtdjEyS8SpA+lFtZzKpgPipbZOmRsLc?=
 =?us-ascii?Q?xx3vsLaJQYWr73MTOFyeVcr+sXCyorRYs0JcJ1eZbn679NbgjL0RIRc5cDeS?=
 =?us-ascii?Q?JuppGP2kNZyW4Em68d7AP3fWFRs0XAE4qsHU+ka9tDVvG78aeO/HZcppcuDn?=
 =?us-ascii?Q?EhAOIzJDl96bUq009zZmu2TA7hByCfZF1JrV+E1SfasCIdb13g+DT/O5Vbpn?=
 =?us-ascii?Q?zNRhtv8paq+V6Hl8AUk/E1m3WoOViPiQovwSMIxqQGBGxyYBQrSuD+3nH6Cf?=
 =?us-ascii?Q?BCQlghGbjDdP0IT+dgZsJa7FKLoWuHIUypTsNx0tmpAz3b0u0WsyVakUaSxA?=
 =?us-ascii?Q?nLXA1H5be8CiV7ymYm4hRks1LQ3iNsCJAEy+addJPnD7QdoDHaGifOJ3nmEc?=
 =?us-ascii?Q?xg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2147e8-3991-47bc-29f4-08dc5d2f268d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 09:33:47.3691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QtcQ9lWw2dem8mmvyjdUlr4eeMf2SvcFkLNi8pn/ScQhq9W/1RVEM8vWliCtQlJJ10Yjyjg+2x43ApUM2/4Orp99p/2DKBEaI8K7kBQMm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9023
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 Apr 2024 09:33:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15556



On 4/11/24 6:45 PM, Jan Kiszka wrote:
> CC'ing folks who may have a clue as they may actually use that combo.
>=20
> On 11.04.24 17:09, Hannah Kiekens wrote:
>> Hi everyone!
>>
>> The roundrobin handler seems broken for the bookworm with swupdate
>> 2021.11 combination.
>> It is easy to reproduce with qemu on the next branch,
>> PREFERRED_VERSION_swupdate =3D "2021.11%" is the only change that's
>> needed. Log of this setup included at the end of the e-mail
>>
>> I am not seeing anything that's obviously different with bullseye.
>> We are using bullseye with swupdate 2021.11 on tag v1.3. I am working on
>> an upgrade path to bookworm
>=20
> So, bullseye and 2021.11 are still fine with current 'next'?
>=20
>>
>> Regards,
>> Hannah
>>
>> LOG:
>> root@demo:~# swupdate -v -i cip-core-image-cip-core-bookworm-qemu-amd64.=
swu
>> [TRACE] : SWUPDATE running : =C2=A0[swupdate_dgst_init] : public key / c=
ert
>> /usr/share/swupdate-signing/swupdate-sign.crt ignored, you need to set
>> SIGALG
>> Swupdate v2021.11.0
>>
>> Licensed under GPLv2. See source distribution for detailed copyright
>> notices.
>>
>> [INFO ] : SWUPDATE running : =C2=A0[lua_handlers_init] : Lua handler(s) =
found.
>> [INFO ] : SWUPDATE running : =C2=A0[main] : Running on cip-qemu-amd64
>> Revision cip-core-1.0
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : Registe=
red
>> handlers:
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 dummy
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 archive
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 tar
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 uboot
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 bootloader
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 uniqueuuid
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 lua
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 raw
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rawfile
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rawcopy
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rdiff_image
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 rdiff_file
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 readback
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 shellscript
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 preinstall
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 postinstall
>> [INFO ] : SWUPDATE running : =C2=A0[print_registered_handlers] : =C2=A0 =
=C2=A0 roundrobin
>> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Main loop dae=
mon
>> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : got no socket at
>> /tmp/swupdateprog from systemd
>> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : creating socket a=
t
>> /tmp/swupdateprog
>> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : got no socket at
>> /tmp/sockinstctrl from systemd
>> [TRACE] : SWUPDATE running : =C2=A0[listener_create] : creating socket a=
t
>> /tmp/sockinstctrl
>> [TRACE] : SWUPDATE running : =C2=A0[network_thread] : Incoming network
>> request: processing...
>> [INFO ] : SWUPDATE started : =C2=A0Software Update started !
>> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Software upda=
te
>> started
>> [TRACE] : SWUPDATE running : =C2=A0[extract_file_to_tmp] : Found file
>> [TRACE] : SWUPDATE running : =C2=A0[extract_file_to_tmp] : =C2=A0 filena=
me
>> sw-description
>> [TRACE] : SWUPDATE running : =C2=A0[extract_file_to_tmp] : =C2=A0 size 1=
267
>> [TRACE] : SWUPDATE running : =C2=A0[get_common_fields] : Version 0.2
>> [TRACE] : SWUPDATE running : =C2=A0[parse_hw_compatibility] : Accepted H=
w
>> Revision : cip-core-1.0
>> [TRACE] : SWUPDATE running : =C2=A0[add_properties] : Found properties f=
or
>> linux.efi:
>> [TRACE] : SWUPDATE running : =C2=A0[add_properties_cb] : =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Property
>> subtype: kernel
>> [TRACE] : SWUPDATE running : =C2=A0[_parse_files] : Found File: linux.ef=
i -->
>> linux.efi (C:BOOT0:linux.efi->BOOT0,C:BOOT1:linux.efi->BOOT1)
>> [TRACE] : SWUPDATE running : =C2=A0[add_properties] : Found properties f=
or
>> cip-core-image-cip-core-bookworm-qemu-amd64.squashfs:
>> [TRACE] : SWUPDATE running : =C2=A0[add_properties_cb] : =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Property
>> subtype: image
>> [TRACE] : SWUPDATE running : =C2=A0[add_properties_cb] : =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Property
>> configfilecheck:
>> /etc/os-release@not_match@IMAGE_UUID=3D7f15735e-dd28-48b3-a881-a2e7353d9=
3df
>> [TRACE] : SWUPDATE running : =C2=A0[_parse_images] : Found Image:
>> cip-core-image-cip-core-bookworm-qemu-amd64.squashfs in device :
>> C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.ef=
i->fedcba98-7654-3210-cafe-5e0710000002 for handler roundrobin
>> [TRACE] : SWUPDATE running : =C2=A0[check_hw_compatibility] : Hardware
>> cip-qemu-amd64 Revision: cip-core-1.0
>> [TRACE] : SWUPDATE running : =C2=A0[check_hw_compatibility] : Hardware
>> compatibility verified
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : Found file
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 filename
>> sw-description.sig
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size 1348 Not
>> required: skipping
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : Found file
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 filename
>> cip-core-image-cip-core-bookworm-qemu-amd64.squashfs
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size 119066624
>> required
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : Found file
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 filename linux.efi
>> [TRACE] : SWUPDATE running : =C2=A0[extract_files] : =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 size 16962560
>> required
>> [TRACE] : SWUPDATE running : =C2=A0[extract_padding] : Expecting 388 pad=
ding
>> bytes at end-of-file
>> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Valid image f=
ound:
>> copying to FLASH
>> [INFO ] : SWUPDATE running : =C2=A0Installation in progress
>> [TRACE] : SWUPDATE running : =C2=A0[install_single_image] : Found instal=
ler
>> for stream cip-core-image-cip-core-bookworm-qemu-amd64.squashfs roundrob=
in
>> [TRACE] : SWUPDATE running : =C2=A0[notify_helper] : Round Robin Handler=
: No
>> compiled-in config found, trying /etc/swupdate.handler.ini
>> [ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Error getting
>> key 'kernelfile' from bootloader environment.
>=20
> I suppose this is where the problem starts.
>

This is a regression introduced with=20
5e2c207abae61e073bc732d0b93ba390891cd0c7. SWUpdate 2021.11 still selects=20
the bootloader at compile time instead of runtime.

will post a patch.
Quirin

> Jan
>=20
>> [ERROR] : SWUPDATE failed [0] ERROR : Round Robin Handler: Could not
>> determine current root device.
>> [TRACE] : SWUPDATE running : =C2=A0[l_handler_wrapper] : [Lua handler]
>> returned: 1
>> [TRACE] : SWUPDATE running : =C2=A0[install_single_image] : Installer fo=
r
>> roundrobin not successful !
>> [ERROR] : SWUPDATE failed [1] Installation failed !
>> [TRACE] : SWUPDATE running : =C2=A0[network_initializer] : Main thread s=
leep
>> again !
>> [INFO ] : No SWUPDATE running : =C2=A0Waiting for requests...
>> [INFO ] : SWUPDATE running : =C2=A0[endupdate] : Swupdate *failed* !
>>
>>
>=20

