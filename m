Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730BCC47DDB
	for <webhook@archiver.kernel.org>; Tue, 23 Jan 2024 09:28:17 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.42])
 by mx.groups.io with SMTP id smtpd.web11.8274.1706002095900924204
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Jan 2024 01:28:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FPRZDL4m;
 spf=pass (domain: siemens.com, ip: 40.107.247.42, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhrt4fh4xnKQ76hS5DOb//JNhSxlbbCFIlsYsHiLwGZ3m9kiHROu4AItVW0UtjEXv0Ge8DVMvgrQPzbEgXXb/bkeJxMzU+ayatKLgKtuCm0iyXnUkSvbS00bgl4fW9AkR4NXMfFz14WecshR+y5j3dK+W2P2qIarml/DLOr2ddbsBn8y553uTawOaZlRTG8tZkHrQyeWKisatc3cmZkxARn67+5rlH+Rlk1ieuf39Sw4jfwDBGc6qaSMruKXgdmXA2B7XPr/u/VSU8RSuJ57fDXHF5UemQL4CqZDDletnrTyK4d+/AbjpPXga48Os+WTQa6LwIJjKU0b6O7Om5Tmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkeVJMqMgd4894kgcdvvMrWi2thcVInI5bclU9xWHpA=;
 b=Q9LtAS5hErObyvwLjVtN6CKR+gw/vxVlEsR/GMZAw53k7Pwvg4N3b8yFzUghNstbIfH50+LSihQyEaB2XykvZmB2kqi7ojHX2xMHO6VxaNjUY1TL7wZcXjWnH88ULI0HTlxTPaaXTv3S0JZJhSLiQ8le0fJGcntlkVz0fJDzNpqnaHfaAE7JOGZgV3ADuvn+0qPceJ9urzXeuMwl6t8BxDjJJxp6g+AypXk2HCD6RtHCXraZ3l3fcR8rL/l/KVFApNf1y9inJIaRipiukyRjCMS4Hh83jAMbEyqbKRBmMZhV/gX/yCtnCOqVT27018I7uUUkhLPBXjpCzL9DcjSkPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkeVJMqMgd4894kgcdvvMrWi2thcVInI5bclU9xWHpA=;
 b=FPRZDL4mC/SvlUAHc/9ScJPxAUS/XP0tb43g0fGzqATDPofpFDzSmRqaLl+jwTlZEHVx29kxLGSVACRJ3ybNIBQ3GPRoT9X6BIgNm1XNE7Ws46LMf8tl6wp8E39GwKNqsyDtAbSue+aBbf3WtnITkNbN0zzv4k4ywOK2thJ3NN+stbog4/sbz2py5Szc0IbGkQCLDfibx89KVc3nScNN4BcToYTa96Rw3aFN/ZoyZlz62gWktAEkkUZT5LX7SDVwl5Bwkieb/g0xbttC1w9pJKbXX2mYoaLxIXl6dBJAHXV5PnSvCMk0JnlrflBAthDU1J3uaYp4B1ntSfvZtUhSMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB8PR10MB3845.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:16f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 09:28:12 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5c76:8089:1f9b:63d9%4]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 09:28:10 +0000
Message-ID: <0c38e88e-aa93-494c-b8bb-5e258a4dbc20@siemens.com>
Date: Tue, 23 Jan 2024 10:28:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 2/4] swupdate: set SWU_HW_COMPAT
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240122123751.83696-1-Quirin.Gylstorff@siemens.com>
 <20240122123751.83696-3-Quirin.Gylstorff@siemens.com>
 <e3e6215aa9e705dffa9e38178dd8c5435ba41b4f.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <e3e6215aa9e705dffa9e38178dd8c5435ba41b4f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0032.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::6) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB8PR10MB3845:EE_
X-MS-Office365-Filtering-Correlation-Id: c3f5032d-e21c-4c13-f94e-08dc1bf59d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	u83lDOKr2H9WSCG5cQR7oS/eE7oplewWkvre8NMc3MOWUS/weMgI8L+a0Ho+DJsGT2TE8g9RbMyVeXCp96LPcIxZj038qOLbmebjpk43E0FJlhoBeoJ5fEt/Qe5UnTayYjkbkEQTfbTRI3yTKLK7y+eUVbJgL2gSJ9O6yDt6peVGBdbhLE8ws2Q+qUO/zrHIKCooCi10tbsfefialEU+g8MI/yz4tY72abJzh44rC+DF5q/5+1wlVyqYrsRXSdj6Et5+w3TAERly+XUPv8EMp8BQazKYIvnv65KmgQijRQjP+IwmVWoqjLzj/Z6AMk+HNxtZ+BGmdl8SLjnf+OHmUx8fSk7/e+Ztgv6DYrfPce7a4RHXsswqJx/RLxCGjuS67Lp3BZ8NSPOt1Xq0b/arlw86LKAow6X2jfNye5geFXPAYtI6i2mB479IdDuI2/+FLC2vGeE2LRlAh7bcHfs20qKWnnFJzjzeHYTxhUoGMHzA3XWy+2Ytxvc+hu4mWMTIbGvPM/MuXLWFD7TqmXtMllMLBOtzT1m0UBqOAT8kyehMj5Vnu62r5wjf5D4M5LVLGa2ccjK+uuAa/Cj3/eYI3nIr9bN6zOI3PdT3iX6uGB+nArLAot6F7wv0BPLbBjZWGL7oG/X3YgHOVqnTBK9Ghw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6636002)(31686004)(5660300002)(66946007)(66476007)(66556008)(110136005)(316002)(26005)(6486002)(6506007)(6512007)(53546011)(478600001)(83380400001)(2906002)(36756003)(86362001)(31696002)(38100700002)(82960400001)(41300700001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ft6tFHo6WFpPpgZWr+CgSDOK8u3o3bfs3EO2p5tUQyOxJzLm1NICVwx7J26q?=
 =?us-ascii?Q?+kuwrNRqvlGY8m3MVqkhlmGHVWoTQKvhsnJYyoBZbn0g503eKYN+9NbMWx34?=
 =?us-ascii?Q?ZpdjQfizcGvCN9XnLwOnCzE0QIfceopsRNSomp+uIc7qJfJZf3qxzSj4CCM8?=
 =?us-ascii?Q?VrZcOtoVksWCHSisJGdbxDaLRQHYWDRbxOHOdzxp0h7z8fajEjYFP5Sih+wa?=
 =?us-ascii?Q?UGwX0OgY9PI872dZTSMEmHPtwm8N6DmdlFJ1eVXf7Q7vDSf0gCLQJSMLgUDW?=
 =?us-ascii?Q?zXK9aWYKE+jaMMV0+HxsD2isJ0l/rEc5lQwPMUGEjkZqIgFNBtpaNJiOE8V1?=
 =?us-ascii?Q?suwlPc1ypcIFRMxARLP66ZWJW1dmGVUaAoEmZFDaBkdXq9kBM3l03XrTrsiZ?=
 =?us-ascii?Q?I4XeFdohnBxrkjQNOlpwIK4qt5skkB2qL2SCeA4ydIKvy3iN3zIJli8yW9T6?=
 =?us-ascii?Q?L6JYxiJyVjPcOGaKKyte4tNKPEcF4WqJ6d+GRSvkWSwrYWhjN/2MGdYWd15i?=
 =?us-ascii?Q?ie1xp3mWyesPdybsDpffr8CHwaGHi7MF2X040z6EkGkMruIHDGrSNUDldz66?=
 =?us-ascii?Q?sydjSpVTumd8aFXMPEJgW54jZRcwEplA8AXCeWd6lJmDM0Y0sdFWcRihwr2A?=
 =?us-ascii?Q?RJa/FvS3T4oJPWAP13nf9iO/MImOm8/EaIImaJ7L32IO3vzg3/DWncKExeHF?=
 =?us-ascii?Q?fdgkGlkheyyA6jH3Ml0fMzU8z3FZ+eH3pF4eifCw/p48E7/fZk/RSS7zeZdu?=
 =?us-ascii?Q?3uEfoa/x+NKFiz2hQG5tBIgO9qz+oqB7elBJ3FbtqNifHl7ks5/36uRQ1UOP?=
 =?us-ascii?Q?xFxOXgx4E9Mz+3zlnGM6f3qaP1HtzL7qu6GaYRAN/CkLkSMJXrdNCYCZ8iGG?=
 =?us-ascii?Q?j2t730ojcJlkTC1J7SKHdTe4NszP0aGSpeF0IyE8wHcxei7ENcIhRUxmQfoT?=
 =?us-ascii?Q?mvAz9gWd6sQzhpfx4lisbc5nsdvB5PLHt/K7CLTw+n/VPIrQtGUNDHmQz3yZ?=
 =?us-ascii?Q?Q3wdPV4w6Jf9kelAYZRdlqsCBwrIDBF2bNhtnA5Wjee9qmtSbRLsaVn+i+Kz?=
 =?us-ascii?Q?Kwsu0zigSMeUVmovM1ZBQy/tSB4J1LwmgK7rEeqVRXz+djnZARCxSW8wZXOZ?=
 =?us-ascii?Q?hNA90Hgel2+ehpMxAA7vMn4gWQnBAW4sujo03gmN3H3o23mampGFRSllqo7N?=
 =?us-ascii?Q?TdmULUa4Pba/q1dys/woikAFpuAam23uL7AtAcvUZvoLUQGyy8+UvbngaQgC?=
 =?us-ascii?Q?SBQClZNm21u6A9qvYGoP0UpwSCDbL+6lI+Gdp1AcfY+UlMKOqmTZbeEQ7+Xg?=
 =?us-ascii?Q?lLe9VrNgWWlyC18KyhDDWJZk6fhJgLmmtsSY6fh4qKngBgQYQ/ousfOR4n0u?=
 =?us-ascii?Q?QMTBB/0gm8rgDbazSQdpFewqN1b2MhHpejwxnI410nYKJYMAwk9D6gRg2kyQ?=
 =?us-ascii?Q?q8ONKWEcZ4hTISiVk76FJZ3XA1C4Ql81cpP7Ugmpje25Yi5VUpUlDaUYbIG6?=
 =?us-ascii?Q?cmJRDhkTlXMYL9S0iRAnWECTWRtKwphVL2SHAbqUCFLlyRIuPUxXRU8AQgUI?=
 =?us-ascii?Q?dnC1qAUhJKgxthx7SY7WI7Ru2gXH3eEZyHXCAvansK2ujIvswcGsJOOS1DI7?=
 =?us-ascii?Q?pw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3f5032d-e21c-4c13-f94e-08dc1bf59d6d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:28:10.3019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P32AP0N/gdk4DqJyqIWWY/bO80BiUmeCXIakMZltu6i7O4zK5nnmqrc1QLfYfiDvj2UVW/c7HhYUrgT0dbruGAYwg9jPdaQ9SNVtMxlPksE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3845
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Jan 2024 09:28:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14445



On 1/23/24 10:16, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-01-22 at 13:37 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> With this item SWUpdate from Debian can be used in place of a
>> build from isar-cip-core.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  =C2=A0recipes-core/images/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 2 +-
>>  =C2=A0recipes-core/swupdate-config/files/hwrevision.tmpl=C2=A0 | 2 +-
>>  =C2=A0recipes-core/swupdate-config/swupdate-config_0.1.bb | 2 +-
>>  =C2=A0recipes-core/swupdate/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
3 ---
>>  =C2=A04 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-
>> core/images/swupdate.inc
>> index 4983f7c..183503b 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -13,7 +13,7 @@ inherit image_uuid
>>  =C2=A0inherit read-only-rootfs
>>  =20
>>  =C2=A0SWU_SIGNED ?=3D "1"
>> -
>> +SWU_HW_COMPAT ?=3D "cip-core-1.0"
>>  =C2=A0IMAGE_INSTALL +=3D " swupdate"
>>  =20
>>  =C2=A0IMAGE_INSTALL +=3D " swupdate-handler-roundrobin"
>> diff --git a/recipes-core/swupdate-config/files/hwrevision.tmpl
>> b/recipes-core/swupdate-config/files/hwrevision.tmpl
>> index ec1d667..1eb0996 100644
>> --- a/recipes-core/swupdate-config/files/hwrevision.tmpl
>> +++ b/recipes-core/swupdate-config/files/hwrevision.tmpl
>> @@ -1 +1 @@
>> -cip-${MACHINE} ${IMAGE_HW_VERSION}
>> +cip-${MACHINE} ${MACHINE_HW_VERSION}
>> diff --git a/recipes-core/swupdate-config/swupdate-config_0.1.bb
>> b/recipes-core/swupdate-config/swupdate-config_0.1.bb
>> index 6991321..260c0f1 100644
>> --- a/recipes-core/swupdate-config/swupdate-config_0.1.bb
>> +++ b/recipes-core/swupdate-config/swupdate-config_0.1.bb
>> @@ -14,7 +14,7 @@ inherit dpkg-raw
>>  =C2=A0SRC_URI =3D "file://swupdate.cfg=C2=A0\
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 file=
://hwrevision.tmpl"
>>  =20
>> -MACHINE_HW_VERSION ??=3D ""
>> +MACHINE_HW_VERSION ??=3D "cip-core-1.0"
>>  =C2=A0TEMPLATE_FILES +=3D "hwrevision.tmpl"
>>  =C2=A0TEMPLATE_VARS +=3D "MACHINE MACHINE_HW_VERSION"
>>  =20
>> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-
>> core/swupdate/swupdate.inc
>> index cb1716b..818b431 100644
>> --- a/recipes-core/swupdate/swupdate.inc
>> +++ b/recipes-core/swupdate/swupdate.inc
>> @@ -34,9 +34,6 @@ DEPENDS +=3D
>> "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd', 'mtd-utils', '', d
>>  =20
>>  =C2=A0DEB_BUILD_PROFILES +=3D "${@'pkg.swupdate.nosigning' if not
>> d.getVar('SWU_SIGNED') =3D=3D '1' else ''}"
>>  =20
>> -# deactivate hardware compability for simple a/b rootfs update
>> -DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>=20
> This is a breaking change, which should be added to the changelog (do
> we even have one?).

As far as i known we don't have one till now.

Quirin
>=20
> Felix
>=20
>> -
>>  =C2=A0# add cross build and deactivate testing for arm based builds
>>  =C2=A0DEB_BUILD_PROFILES +=3D "cross nocheck"
>>  =20
>=20

