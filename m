Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0500DC4332F
	for <webhook@archiver.kernel.org>; Thu,  9 Nov 2023 11:24:35 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.88])
 by mx.groups.io with SMTP id smtpd.web10.119223.1699529065153065148
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Nov 2023 03:24:25 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LonWs3Tp;
 spf=pass (domain: siemens.com, ip: 40.107.22.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRyYpU3++Ac0EYa6903RNuvBF2v7kVwaxaEzbhDuEya9ysWfMGrUyrC5IMiBpttowNVSSI0xWvtdx12oarvMB7ACukbj47l8+ZdKox/mxCaZPEM+runqcIdz9WelhoQdnticMPkt9E0sYe3fMQCE4p/HbONZGElIeGeWlHuJHaAtWAvY2i0B2KNGTIyPJ4C483PShVZSIV8JNkgH3P5/nEXFZzz4uLkrvkCZESGam7MmbUhkDODpRX3fwWGyuYzoDg2ZOQJsUqbaikeRZciwF/9SXTAwqHmKVJ0NCzEGpcvcVNdaWG0wB2b4otpCwE6i1HGweysfKCxCHiDgagK48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3IMIRrgSxWyM4FkuHmpW3SDI2UZwel/OL7Bwn8Jna8=;
 b=Rlk6AYphMYE8VzHNeRBR82rzirpoA5D7CYbv1GaFf38Z2i5oCmfZFzN50WilEgDBjXzcUiEXz+p4bGJTjD8AB4rdqcrmZpEE3zbhnVRBI+uHgD/xOfdO6XFlWKfBRQRPUCgP9aW+nsVflbGIL5zl1pw5dCT8pYAJqzii4/vojKmpbW8iOp9bs5llcd0Dj7bXNU979JZwtcvJiOxVCq513nIvXclUvAI6RtLnQ15jam4xX+LD/XedK03J28aY+WZDQsR29vkFXxlIEvrLJ1WLJFnI9ksuFbdb1vkp2RGnXatatC2D9Gm45Vk6fYyB0Geuq9fYGnLjC6hBIwWYtzSsKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3IMIRrgSxWyM4FkuHmpW3SDI2UZwel/OL7Bwn8Jna8=;
 b=LonWs3TpcZVv5nuMDmXXXXG8WO1zCKDhNG/9lMrVX9DGT2oiggLyGJeMELoGcr5uL3ydcS6CWrO049Wlmes93jUPjhc1AamcJnQHpggx2yEitCBzYTMGxi0d8FUtmExSAILrhdUO71DOTyDY+frmrhexcYnwUAqYc184HDysIWQeQz3gR3as6h9Gq+Bqy4/QXGQc7rnkdz++jKQiXIeLPiMDH2HaApRyHKaREOGsXpItRaLpGcQUbPu1J63W+WoBbjLuk92QS8+CIkXZSyUzP2sSHiS0ELho9GDeUmUKAeZoME389Zjr6OEaxRgjCrEn8qao0H+ZDi1YZsjzcU5SZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3865.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:42::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Thu, 9 Nov
 2023 11:24:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%4]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 11:24:22 +0000
Message-ID: <05341db4-c9a1-40a6-8b48-21d32ee53dec@siemens.com>
Date: Thu, 9 Nov 2023 12:24:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] added pcr_bank for clevis
Content-Language: en-US
To: "Sari, Sercan (ADV D EU TR C&E)" <sari.sercan@siemens.com>
References: <DU0PR10MB6898A9738AF1110D653D5DE5F0A7A@DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM>
 <f1a52e61-3404-41df-85fc-7453be0d4be7@siemens.com>
 <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
CC: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <588aaf59-facb-49db-bbfe-2c70c9866452@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3865:EE_
X-MS-Office365-Filtering-Correlation-Id: e93303bd-96be-41d1-6a2b-08dbe1166bf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jsMcK9aHEzT7ftaUB+9R22wMnIvEX1rMhjOOIWjchLeTTYjlZmKIWFxnisMPKOcAnLosFUdXhi7gYMcVxPXVXACHBDHitRr8dRsJQBvobIHVh5M/ElfNEUrsmkH9AqP0H9D/kkgy37VcTvm3J1KbUVujFT9XnZp5+uPMSLV8PpH22JTtwht1i0+uFEBkuXhH+BzUfDlThD6vITwNED7kdi2h8hNdpsvidG6xXMymVQLWz0TOUBVPDmQkp5Zw0de6Et8/IwWfXhs5UMwffCpYmTLec6QBoZvXKwuTw1jqk2f3KxzfyK6QKd+AtQqZUlppMGhrHiZJe6gRzY3QWTCB4yXCce1Esmsisd5h/VutNaBszsP5XV82QNTd2Dsotp5a3v9HVk2kfGh0bnJH8yrqAehJ4z8VmJWf1fcUOprXM2KcS3U8BM/7BLw0ChZIzy9GcTmiZHvQ5lM/GDstGYRtoZHNrkHh1D25m8jPNt0DirSJEpx82DPAJ/HZhwJ2t1dCWzBw/eKWWVJoG9NU+27zPDiEZAxVkQsTUN02Ba6z03NrhLfmJRFnmLQn475jJQFOIUyB1HA0PM4peLHxDYowLl7Wm0u4K5hFzV+cEReUU7yaG5Ds3J0K9yHGhTzxwI0LXKt9S/hzeTChjVwwxNWl4w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6862004)(86362001)(2616005)(6666004)(6506007)(26005)(54906003)(6636002)(316002)(66946007)(66556008)(37006003)(66476007)(44832011)(83380400001)(6512007)(6486002)(31686004)(8676002)(478600001)(8936002)(4326008)(53546011)(41300700001)(38100700002)(5660300002)(82960400001)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?JBc9GFqMdkJr2jifVu0/UdF42VmgVMCRtrMytiHfA/dpjfoHUXEJbOIT110L?=
 =?us-ascii?Q?gR7kBZOsuIOQfo2I6PSCDkGskIQBe2fRsNcsPwdYigRL9fhzIWFkofy+mTQH?=
 =?us-ascii?Q?Jm2lO8Olfxkp2vKQO6BH1WQAbDpc0ZJKdwTndliEodUtMGCmoAJ0niuBHkEE?=
 =?us-ascii?Q?5qWnjv14wGOZ0JCz4I6rqa4GXpEvbT79EP1SPZuWOFhpX/9SijEJmZoHRZlE?=
 =?us-ascii?Q?Nh/qP+k2WEaoi04ZI4CmwbIdUxOqdq5+Kp+qHd0JVOdv8JlECZfX0l8G7LSQ?=
 =?us-ascii?Q?SbZIoNAaknbY9yUt8riSeusZB2UzcWHkiMVb9vogiNuYKLpTvS6NfJuOD5uW?=
 =?us-ascii?Q?N3ikv+UMgcX8fehApjC6AnXyQMRZHf6KDIJm/GEyPS6/FRfU3vOp2NeYywwZ?=
 =?us-ascii?Q?CeDL4Rzwd/1XkOGRz1jh6gjBu/tMWe9B5jcWjhntiMM7kVmk9gIQfSaOPJGt?=
 =?us-ascii?Q?poxb6Px0qqavuJIQ5N4fAsWeZKaRuxrq7bdTeb6kcVFbWkJSvqxC8QwGvtah?=
 =?us-ascii?Q?T1kWXTXkuz+Nu+UW0I+92jK1UryCDQ0RvC5T4s/EiRpgitgykl+spSCiGCuD?=
 =?us-ascii?Q?gZ7vd1Eu7j5djc+DTPiVqvNGsgD0r15eF/xKfwnTwjaa1Idd0ThIOkcFO9UU?=
 =?us-ascii?Q?B1d+24RDGEhvu17wJnXbVGNfTg92RQC8sQTrDvojY9LrxSOGVROFsD8DqTJc?=
 =?us-ascii?Q?AtF953sT3GsqAxguGO9Ylm8066oQVYJB58bQYoQl9fPkYSO7g79SBktzLAgK?=
 =?us-ascii?Q?drAvNTYEME2VDQ4ivpWGx3qliaXB1FhNukRGQOoa5MIibkqUm4Y5y5OmUEOE?=
 =?us-ascii?Q?+wnQe1XVATI/+tZno7QGcy7l8vFAd7l7a8/d37kQp8FhzFG8choak7ffN0Xa?=
 =?us-ascii?Q?fkeE9ZrEwj0lMDH2013FIjbHEs9WhcbVTeGfi4qiAWm4MwGkyTA9QZrE8ygJ?=
 =?us-ascii?Q?yTxHENE6cYQ88IR//DliuSesOogLktO27y2Ksq0p30aArjxz6gk0qZkJE4BY?=
 =?us-ascii?Q?sH7DtcrKGhnCgXdZzI7qij7bO+3H7diTiJOM8jok9EBx8+8B6TBXzxFaJ4Xm?=
 =?us-ascii?Q?1P3uVG0dDvcU/EheLYVCdIRmqDn8KUPaL1VseiD5CYefetBb2yzL7miPqqh0?=
 =?us-ascii?Q?/5SzuqHgLitBguHdo2FffWTR04cSe/hY95VfP//wgPBqhuzPVZrAOfuywomk?=
 =?us-ascii?Q?s7IPPkOLTB1Se2bQKTnYzrXfT8zQrFTP6jaRXZEaiwA17gU3NcNRRNvgrpRL?=
 =?us-ascii?Q?GYTMQitq11ATpMdqARfh7IB6TViPqws5Crc6ligIZvr9X/ohR9az+i30xuzY?=
 =?us-ascii?Q?ngafpgc8g4qCaSQIRGW5OGhC36CYWtP+lnGyU/Ms+lygKZB97DlXYpdY7qtS?=
 =?us-ascii?Q?ZWG2OSuZMyqRFQcknExzCfTxwGgqA0cW7O9j5Ovz1uxYyzwGqPsMhXZMPqhI?=
 =?us-ascii?Q?4sPTb2kgBEfYcSIvFuZxSu+gTwZ5h+U0gKwh7fCeCzOyEjNzH6L+dbhVpW0g?=
 =?us-ascii?Q?RFUlzaEIHv2mj6enTIAE0KQ83vzYJRqw4nSU9UbjZFBqMXyQekfoDhTnx3la?=
 =?us-ascii?Q?lYwydFVkwTsklHYs/BWHxOjTk7favpfTc8Xbyuj9Qa08umJgDGK9W7dDoiBN?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93303bd-96be-41d1-6a2b-08dbe1166bf3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 11:24:22.1035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXQygMOBDAIpOhBluoZuSoO96youGiSpFj65VjZBqNrI27vboxGwWZv1QlhHwukbxae6ym6lAbTwl9wOh98yqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3865
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Nov 2023 11:24:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13548

On 02.11.23 09:08, Gylstorff Quirin wrote:
>=20
>=20
> On 11/2/23 07:10, Jan Kiszka wrote:
>> On 01.11.23 18:17, Sari, Sercan (ADV D EU TR C&E) wrote:
>>>
>>> clevis will fail to encrypt data when the TPM has multiple banks,
>>> such as SHA1 and SHA256, adding the pcr_bank information resolves
>>> this issue.
>>>
>>> Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
>>> ---
>>> =C2=A0 .../initramfs-crypt-hook/files/encrypt_partition.clevis.script=
=C2=A0 | 2 +-
>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.cl=
evis.script
>>> index 899f20e..957a3fd 100644
>>> ---
>>> a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
>>> +++
>>> b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis=
.script
>>> @@ -61,7 +61,7 @@ open_tpm2_partition() {
>>> =C2=A0 =C2=A0 enroll_tpm2_token() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if [ -x /usr/bin/clevis ]; then
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clevis luks bind -d "=
$1" tpm2 '{"pcr_ids":"7"}' < "$2"
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clevis luks bind -d "$1" tp=
m2 '{"pcr_bank":"sha256",
>>> "pcr_ids":"7"}' < "$2"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 panic "clevis no=
t available cannot enroll tpm2 key!"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fi
>>
>> Is sha265 the only reasonable setting here? Just asking as we are
>> hard-coding.
>>
>> Quirin, any remarks?
>=20
> I would make it configurable. clevice supports SHA1(default) and SHA256.
> Quirin
>=20

Some follow-up already scheduled, Sercan?

Jan

--=20
Siemens AG, Technology
Linux Expert Center


