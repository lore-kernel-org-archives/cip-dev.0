Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B9EE7DEF5
	for <webhook@archiver.kernel.org>; Mon,  2 Feb 2026 15:26:09 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.55337.1770045967722137750
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Feb 2026 07:26:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=sSVuBaa6;
 spf=pass (domain: siemens.com, ip: 52.101.70.55, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOw8JIoL27OEW5h7MlIUpdQ5cYd13zCIVJFDk55te6MAw7aqliwbWL5nffFJCcQrVKsD/hq3WQCmFGWT15oxOTNobEcda+9dxJHTmxfFSJvkfgB/lZGnoog1c2KTgBkGZRpEl0iri2D6iJrwJOrxLexTAxa4k+1L/kmRHg3SuzOE0SHLghCA9i1uzY0AgPtMxhQXyeop2GfjAnhrYcJTep1sQ2H1LArhUkY4JSSxiwNrsrKNQCWQaAnOU8cYzTzDMv4iAm9lEltRJnzKoAMAjq4+Rd0dzGd/PlxLoT3ltO4JQ9bKurPtwSNba/c2JT+/i0m9gHxiQwhXHXBoiaUYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CJ0d1uMADffVUzpwtInpR/fqrvtpmmWJ6tAP3E1zpQM=;
 b=ymLx42o2VM6e7B4x7Q3IuYHpoDqhGeAZ4Nabp4M9/8irmbhvjoOF6y68d/ZJDeMtnei/Xz6qXJSGAqdytyYE9D42oYSiMWQU6p4/gELPpNip86dzmr1Yl6PFPMijA5ac6yD/ZLBLchEc+MNKM6H8HMOP8vBtqUjkiKZYQK3u/l+26Ay5DeDD/QiA1HVKKWQfNpmkHbKcQbV0t64TGFAb1bdM1Bhl2OBafL10foSHfZfsw49GIWv/WScjPqbxn1CipnAruwkTKyMDduC3RPvw5aaneiOxFt+MrXEi4qvi2cWK3G5Y0mecHF8xmMRmRVv6bYj3KtZ1fSX68ZOJXGI7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJ0d1uMADffVUzpwtInpR/fqrvtpmmWJ6tAP3E1zpQM=;
 b=sSVuBaa6KZhbD1H9J+nKOmLGd6+/oEhRZI/Rk4znf83jBxpGZwwTOTThIxTVkOU2xNu7+7lbirTMuUMjtVO0JAyxC2AukgYO7sVjKjNMIzW4NW85+vKAyjEvwo23wLygxLHMQT6oQWKbK+t8XsBTFdpNvvx5Vi+Rfw+5FYQvt2Nrm+QCKtJq6+7qaKJONBB6x9DetHBfDd7QJA5m5gHp32XEqa74MtgK7LpfUEjtCNsOqIYFjQPYcKdk1kvKhjEaV9phWR1sY42H0YSTYpEmZfRbCVfNhqr45d7B6W22QyrWztAv8U6WSe5EQitrcKkpgDwcFcHV0BLwYny62etqOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3718.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 15:26:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9564.014; Mon, 2 Feb 2026
 15:26:04 +0000
Message-ID: <7b50a017-cd0a-4620-97bd-ac210093f60b@siemens.com>
Date: Mon, 2 Feb 2026 16:26:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 2/9] u-boot: Add
 U_BOOT_EXTRA_BUILDCMD to common rules.tmpl
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <cover.1770037068.git.jan.kiszka@siemens.com>
 <03d818137b9923826170a993ea9e7bbab01e9153.1770037068.git.jan.kiszka@siemens.com>
 <f1fb4b66-f549-44dc-8937-312a0bc6cb74@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <f1fb4b66-f549-44dc-8937-312a0bc6cb74@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3718:EE_
X-MS-Office365-Filtering-Correlation-Id: 43c86087-ab4c-4366-ca22-08de626f60bf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Zo8D6if0BmgocgNhNdmoxvNU+qCMaiqyxzZWAGppN/Bljm8JHSRbgqT7XBSg?=
 =?us-ascii?Q?VrIDuDBn4q5yzYUtuPtJ00ISJHZq/ncEdjZo1zEXCxX9bMEF9G0UAQKXfQge?=
 =?us-ascii?Q?dREs/tgId0DZhdwhOQVHsLgaQbK28XLO/zURw0GGCbkcLMKbj7rDGqrlp/Oh?=
 =?us-ascii?Q?A966FlsIH8tZvYgkI3qNqXquulNGBqJjwmAyjdGBus8BiR7CM/fGqteM21ad?=
 =?us-ascii?Q?tbjEwcSu8JQzI7se2lG4Rk0ZEDsufUw3EicbXgAEwHv/rRkPqc3Ea1E5DbGr?=
 =?us-ascii?Q?KaqNND1cOGq/0ElEVK+xBfJX3lG4v8/goMve8kmnr/mk9Itl6aLSsFf/dMyh?=
 =?us-ascii?Q?t2A72n6CNt07ZcsXcJoDVaVzU9tMrdTM7zkdfJ5elTQu3OCt+qiqUx6lYuKb?=
 =?us-ascii?Q?6C7rpbzpHFAbz71VWSO1r+ev4HlEAsT1mS3VYnygUNCQkaS8bPNZL4uZIsCX?=
 =?us-ascii?Q?j6AZ10oFBzH7TmUAujaCeTs6Uok0SkYrJgYFxxvJF+xwcDbMSxrQ8BmbPePJ?=
 =?us-ascii?Q?zYEzW1XezZZEHOsZLcRXobQZUj+Ntsydwj6uu1PH5o3iLkC4wODET+bEHLZB?=
 =?us-ascii?Q?Hz74KLg9vpJiDleVPQCjeeOqm0eZTECQ5/g9AgUkcmUPyi0hc3DeRj5XL8E9?=
 =?us-ascii?Q?is3frASUGXQ+83ZBE5d484k4LeHs/UErb+YaEy79M1DZUye2UTiBZ61S3H3o?=
 =?us-ascii?Q?3Q2NCajUB4IYXxulwE6Gxkjmmyeam314bs4P2sBefgH1tklc/L4ebxr6R67t?=
 =?us-ascii?Q?DDfrcMlfal5XTMVT67B98Q58KvweowCaSDGF5C2POXYO/3gWNWu5hX2JFBQG?=
 =?us-ascii?Q?nx69RU/hy83s+q10xQHFH6+WEtD6i98E94iydvd7NQ5/Ig3NOF4Hk7Ysz3zk?=
 =?us-ascii?Q?A1UU4bIL+NAQyLKYeDjVxECZ5/bwPuqxC7z+OGnDUSaJh3NAayiJreK4679H?=
 =?us-ascii?Q?GYy0izAwFZxs39rWSNw7Zt7NSOuQYcuOkKahgqDk7aXwVyGOiweREH8Xsxha?=
 =?us-ascii?Q?KAdsnalsMUKp2qpugGD0SibsFbCksRvLNRQ0D0x1xAg5QStbpQM57a6bSLTn?=
 =?us-ascii?Q?WLccabHuOWa3w6oJD/9RS4UE4a5SnZehP9pSYGqNEKqHtVqLfstDGdIpnVlR?=
 =?us-ascii?Q?bQZqVFAMxhMbaWcJsbYP+KhJVCTJSQKlqLm8IN7uvoi49A4pm9LNCXqxpZeZ?=
 =?us-ascii?Q?K98FvIJbryV3U9FXSyP6EO2VUqbJsqrf1yLq8jSYofE6YeGlhKVEJoD/589u?=
 =?us-ascii?Q?RQ1MR8lkavb+s73RR/f25jnyRilgNGtsI2VAi72WmyBWBnR9+uFMM1iCy7fU?=
 =?us-ascii?Q?TzT3o4KbK4125jW4ZTjDJif8OkrUn1i749eb0Q/BVsyRyr1/TUyiuMtSutr4?=
 =?us-ascii?Q?FMbIVCYAC+ESDKKKC3gft06y9nzMg3kWrbpP4yT1o9hqiw1vigxKoAtv0TUL?=
 =?us-ascii?Q?spoQInFpk/mkUNEVj23V1j21Zzu3CgpYCWhQOTHUx9hf8dBLgPyzYKUEWUCr?=
 =?us-ascii?Q?C27mqmfp2QKHzQxJO3MOXx1VGCtxeCLfu84FnP6KUgSdtF3tFGnBQmcY+gKC?=
 =?us-ascii?Q?N20L89gzbzin4fCZ4uA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hliTdm1W6kSgy7SUTvNrkNfTZZ4eU+OXoEyEKKBYLXmiIMQs8blhgsRKd3pQ?=
 =?us-ascii?Q?XmtD9zHLVubRdIN4FhukWMKuyt8/Z4J9iB71kaFjIEicfMdZSXGspw1NQEaK?=
 =?us-ascii?Q?6aTmW7s+nCNd/3muNELzQX3s73Yf10fi7s7jOlQVefZKuVnFm11btGX+4jw+?=
 =?us-ascii?Q?CBg6vTVUOtP6LtFHwAfnMSImcLFcsVlKbYbsZXjIM9MRoJgSRDiURU17Xa/p?=
 =?us-ascii?Q?U/9qwZelZxjZNIN+dEjPgHg1ycI1bd/UjlPrPridT27ONvmtE2zHzmJw5ssH?=
 =?us-ascii?Q?iawtwFv5QJn3UIKD75Mn58Qie/FBnxcnNjR9FHjLyv4jAPr75DDkOLVV+0ks?=
 =?us-ascii?Q?mqnwSEDuCPbGsnoiz18flLzi4hXjErcinjVWBtFZyQAq7CsL9ox31UrG/1MX?=
 =?us-ascii?Q?djLk29P656Nua4Bt5g8HmdIUEWsBjkZO3iaPl9lXDz6Nrc7wBkqID2W13EAP?=
 =?us-ascii?Q?JcdC2gwKwfXTS7+/TfQk7YDumK0k1jzllf+F1yTo4a/OBzN/u+Iha7QfNO42?=
 =?us-ascii?Q?/kVqFWiBFsV3MHBpEUI5Whd0pm8RtzV4R1bUUe/Oo0jYqHFi3MvpRjjnYfQC?=
 =?us-ascii?Q?adfWtQ0hXwraQM2IYTzgMckcWPY0tqQUbEx5qbkvbjuEHmIUzXw5F1bR9iji?=
 =?us-ascii?Q?S/KAJIlbLH2aRcfzxzlgHLfnaV9dOFcgsUOUhS9Aak489FW5sbsdggSV/mDS?=
 =?us-ascii?Q?pVo46n+6i+M4XAONFcOOndmcdZYkT24yOFZuSj3m41Ms7lS2MUn88Nscjamr?=
 =?us-ascii?Q?MHYpLWFBOPoKjLAJn33oxB0/NNoA2PX1BrqXz5eGNfCMM7JBgOIYkxfdi0VI?=
 =?us-ascii?Q?TvGgJ7Xy4wHTBvqllhZrMRnO/nOkfRmCRYbvvuX+syxumQ233d3wLL0f7Hj0?=
 =?us-ascii?Q?pJZ/71rC/dyOu0m+MgGSvQT7AqLF05+y25in2LYwCCqE6N9Vp+2LbfgnM6id?=
 =?us-ascii?Q?V0S5ddBd5it3iPDZ3+MGRBreM5R/jAPJSpYQL9NoU3oh7J1INvwB5JNHUFzN?=
 =?us-ascii?Q?BR/zstnnEXH7t2pCdjCSjQB1SBkv29wNNd2s9BsyhDL+8hsuRu6m/wdu/KO+?=
 =?us-ascii?Q?tt2R+M2HPtf4icrn/UogLMsgUzPwtXHX/IqUIBMRNuEZ6pbhgvsYA5NZo1wL?=
 =?us-ascii?Q?eTsn3801HzGGenWn4l8GnkQpexdSseG4mbk5QJvpJmPU06PCLfnd2GcE25X+?=
 =?us-ascii?Q?o+UvcF4Jr0hrmB0/T8691inM13U0zZyZlu8u0hZ996ai1DlILmJ9qXtKecdU?=
 =?us-ascii?Q?wX2on1JCKDn44aVq60udekzeBZ+OZeEI/3OGi7aZe+vl/8tNyQLcXIx2DSjV?=
 =?us-ascii?Q?sjVrise8S9tFiz+DixyUsPChMoWZ+grKjPCz6ezsUwS5cx5yhTXQYd3fH+J8?=
 =?us-ascii?Q?SLzCTGFIjlMeTB+0rkmXwpIH1VhZkhrq9sGMVYojIW98JrfYL8ikhJtpzmJT?=
 =?us-ascii?Q?eFlm3/O1B76qipn301cnSBE6DY+ZMoJfXGhKeQo5Uviqwfa5gyuWfmh37WG1?=
 =?us-ascii?Q?++AcTIUjIk44kf/hiOx6fzC4L7KyXZdTGukiTma+pWO8sUqU1a5d8Ns9iKot?=
 =?us-ascii?Q?HTc+NFAf1nYUa8eG4zaxUNjNp03+1iLYh2RcD+6Zu0DsGuyWnJ1HnD6hhxRa?=
 =?us-ascii?Q?xY0k0NLhIFvLgxwz8qXqEN/MX40DtqbuGYr7NvBo4wr2SpbYERmmfqSIke//?=
 =?us-ascii?Q?98kUkr8hig0hsyhLqyScDUfzI2vLxayAsZ2BBCXw8o8ETGmrtR+pu4JqTPyH?=
 =?us-ascii?Q?qBRKNjHMBRYFSuhUATs+mWHDHXh4n/g=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c86087-ab4c-4366-ca22-08de626f60bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 15:26:04.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9r4/FPb4xaGRpa1FgYXJ6b/xnJMkhO17glhCAeJyrhb8qS6C2TCdlFIEWwqxUYxKSgme3SWKWFDXnS/bZRzFEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3718
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Feb 2026 15:26:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21814

On 02.02.26 14:22, Quirin Gylstorff wrote:
>=20
>=20
> On 2/2/26 1:57 PM, Jan Kiszka via lists.cip-project.org wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Allows custom post-processing steps without having to fork the
>> rules.tmpl file.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>> =C2=A0 recipes-bsp/u-boot/files/rules.tmpl=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>> =C2=A0 recipes-bsp/u-boot/u-boot-common-2025.07.inc | 4 ++++
>> =C2=A0 2 files changed, 5 insertions(+)
>>
>> diff --git a/recipes-bsp/u-boot/files/rules.tmpl b/recipes-bsp/u-boot/
>> files/rules.tmpl
>> index bbf7bb5a..560a6540 100755
>> --- a/recipes-bsp/u-boot/files/rules.tmpl
>> +++ b/recipes-bsp/u-boot/files/rules.tmpl
>> @@ -31,6 +31,7 @@ override_dh_auto_build:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ./scripts/get_def=
ault_envs.sh >u-boot-initial-env; \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUIL=
D_TOOLS) NO_SDL=3D1
>> tools-only envtools
>> +=C2=A0=C2=A0=C2=A0 ${U_BOOT_EXTRA_BUILDCMD}
>> =C2=A0 =C2=A0 override_dh_auto_install:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mv tools/env/lib.a tools/env/libubootenv.=
a
>> diff --git a/recipes-bsp/u-boot/u-boot-common-2025.07.inc b/recipes-
>> bsp/u-boot/u-boot-common-2025.07.inc
>> index ed44bad0..7d91a8d1 100644
>> --- a/recipes-bsp/u-boot/u-boot-common-2025.07.inc
>> +++ b/recipes-bsp/u-boot/u-boot-common-2025.07.inc
>> @@ -39,6 +39,10 @@ S =3D "${WORKDIR}/u-boot-${PV}"
>> =C2=A0 DEBIAN_BUILD_DEPENDS +=3D ", libssl-dev:native, libssl-dev:
>> ${DISTRO_ARCH}, \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 libgnutls28-dev:native, libgnutls28-dev:$=
{DISTRO_ARCH}"
>> =C2=A0 +U_BOOT_EXTRA_BUILDCMD ?=3D ""
> Should we not add this variable to the rules.tmpl in Isar? The
> difference currently are secure boot signing and this variable?
>=20

Right, this could be valuable in upstream as well, but even then we
would currently still not able to use it due to our extra static key
injection steps.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

