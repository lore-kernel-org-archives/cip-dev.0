Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E72CD1292
	for <webhook@archiver.kernel.org>; Mon,  8 Apr 2024 07:58:40 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.90])
 by mx.groups.io with SMTP id smtpd.web11.101311.1712563113575463928
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Apr 2024 00:58:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=C+oBMh3d;
 spf=pass (domain: siemens.com, ip: 40.107.20.90, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACh1o9CEm5qxxMxdn59OETHLzrjevLD27vBV/SJoKfPbdSWFyvNlTDy2VHVgFbMMh0RETVF5l6uRIjMAFus7vKO1pdZ7zgbNxx7E5CgC3TeG/xZ5B4kVaJ5pmT4St7CIm0h1CmHthQhvl2FuuWgMsC3CK+j53tFb8kSjDByOUyacJA74AY9psBxYcSV3t1M+T2PANQ67n8VVY1/mpCntq+DpIigHELPWna5Q8mb47CjEP6zDnhwMd0qgM13kPnQsUIxovhjxbRLl8q/ntk1lf88q+oXAbHJPTVdqqWL8Tx6pjU/4xfaJ7eu/704tfGTP060DntuiXCASnWFEer0R3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7y9b0qP6ybPyUmr7ham3ebdySClvr/eIp0EIhewQCrQ=;
 b=nynzfu+lqlYVm3BmdvafodC1QY90CG6ECFnal2GwbWU9DA0SS8RteNZHIvx34zY3RjCgRPvAKiTg4862+fyHxdLb6R0Hb3PEe+3TrTKwh722ZL5x60JjP/vr5/yF6FekB10SGMg0KI+vPFWItadjyxdQiQiWe3LECZ8y5JTjuRvzucaDxpxz4+LNjeXBCIzkZyRVu5ZIYpXQXpWQCbppnQ+oclARE8jnN4PI+9K8Goz+nRNvKZ1+2HACSpf2/V/3LP9I2aHLmHnlujyiokDUO+LdEdwGLW1gKMUKnx+g7g81XRgyNbACKXli9m31aE9j8rup5IU7OQzXQeaQ5QWnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7y9b0qP6ybPyUmr7ham3ebdySClvr/eIp0EIhewQCrQ=;
 b=C+oBMh3dSVL+x4AssyQrZ0F0G7RP97blHk8p8ZAvYOyS7JP3YwEfDzNFow5qK8B6e09iZSecLtMXdhCB6kzjymRIRDdaxTOTzjQ2tFuUKBMeYogGk+9qyMEEHelAlPR2Xt677JDtftk0M3ISKE+7E0Q8hEvDcugDUyD5uBzaQiTlqZRmk5mEVcf+FEJL+qKGwzwsewBZLiBTleBC2+Dc93bJLCsBjQZ31ZSUHyqesvmVBtjMIbMHjGhCXjhOUU5R1uwMS3JSrmNDpakp7N71xDxQKgmEXfv1psWrlkRwZPplvGEuTFpLvx+xWgyci6QNgvkSG71ATV+RFjVwK7FEiA==
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:473::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Mon, 8 Apr
 2024 07:58:30 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67a7:ac13:3db4:91cf%7]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 07:58:30 +0000
Message-ID: <59394034-cc91-414d-b9bf-e0ea34e150be@siemens.com>
Date: Mon, 8 Apr 2024 09:58:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] Revert "kas/opt/reproducible.yml: Move
 SOURCE_DATE_EPOCH to layer.conf"
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
CC: "dinesh.kumar@toshiba-tsip.com" <dinesh.kumar@toshiba-tsip.com>,
 "kazuhiro3.hayashi@toshiba.co.jp" <kazuhiro3.hayashi@toshiba.co.jp>,
 "venkata.pyla@toshiba-tsip.com" <venkata.pyla@toshiba-tsip.com>
References: <20240405064757.378647-1-felix.moessbauer@siemens.com>
 <9125cc93-e91e-4b98-ac76-dd5364dbf275@siemens.com>
 <c98dffde-715e-4542-8277-8313ffff7dd8@siemens.com>
 <5acc553aaee7b3cf78cac467e72194ee34c6e640.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <5acc553aaee7b3cf78cac467e72194ee34c6e640.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::10) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6755:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lEKanG2Qd9lImfl5C9qG+4BaB0KdZcabr80ITS9W4W3+OUiH2KOmKnPXRmT+fHd5ftzWREXuVxVU84SY5kgrZcM3KrsrVGkffOtVrk2KWUQ9GUvQ5FZ5KpUQYOvrTayFPf4Xtaq/bl9K7masDsY5XmQiLhZ6OpVZff41PPnapU74ZZ93rWjbbQgOFJJ4eyAs+6fHHwnwDow6eRmQ+tkwmuuUYhnewBlCtBzphCBaQzRscztI46/BbAIq7cvd3e73LH3B0Luee3whJmn1Of77vwuKveQSsFOhfRduxf9zhg+I4hP5sbe8CCFnDOUtStLXByn2lVwDMNgDhTq0UUthtELJRTAa2ObqduVfayHODmI5E1XWkZNbvnsxYKK4OBn4wLG3KHmJVEQr6inkjSBHXXSc1AvAFxk6kvD4UUwkJvqNmiPnVKgQEzUlBtWkgJZmVFHbHN/M/0L8F3W1Sewlw55vrNtKR1I5DBqNPLPSHHLLRupcK1YpySx1/KXfwP+t/FPpUs0ddZBpfleVDTgBXdkjTgqpvmazjR8DlcoS4C76fTDkfCA3zMhbfja7C/GBknWqsa1Fv/lGSSOK6LJqFhIGP+DRms4qatzQwPFNSRim4atnCmoxrcqqlJyK3leObF/mjaGPPLDaqrhzeF2NuRslKEWitfWVGgeKcXPuSH0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?uK0Vr6Bu8U4jf5FRLpKhubJoLrCuGnyI0M+dqHdc+9dXKS7msTw3dESAjgu3?=
 =?us-ascii?Q?g8hv94GPSdqSgNnD/qfMJhuwf370m9SvSHCFypulADJdhO2lKASj6uGqSvmz?=
 =?us-ascii?Q?FPgIIRscbMp1sWhsXBmBXMPd+iBjFMt9SzChiBr/lCQqWZsE3Y3pOBR/k9rr?=
 =?us-ascii?Q?D00CIUG1ZWMP0tGZ6U15LMdAgwCFV24lpqdEhu1mjJDZmPSdNxItez/Avsq0?=
 =?us-ascii?Q?zrRvSzHCbLiNWF87Ki54oIvOmy0B1k5NpI5YzsgM1PTeScJ1nT//Ufmu1t4o?=
 =?us-ascii?Q?ct4pqH0uY2iSGYFW++NWQGHfOh/OqX2MjWu+fU/w58pbdsSZFixdvNO+S/9t?=
 =?us-ascii?Q?5NdlQDLKXznSZUpiAfa78ZkVmbGs4BDO6nFQH8XVbUv7ovE+1m3HMI/pMNc8?=
 =?us-ascii?Q?pQLL5j6Jq7Z1T0WLt49VJND1Cw2zaC0Djv3DA/xPtKi0W+UGxM6E+dJBE/xT?=
 =?us-ascii?Q?MdHVpR9E0dp+tL0gDf2fmGT+Ye+/10hPG2Y4SKslwJhqfUTAWyCcwi3w8vIY?=
 =?us-ascii?Q?MmobtPG7YoEDTyrFywboazyprSBaqTh66HTaEtlv85SeAjiSRj8CssptwyX0?=
 =?us-ascii?Q?oXd+pCzQHxSPSc1vQlSFiu0f/FE0jmZp/W4T137JaAELu3y7ZSleKLg+2wRx?=
 =?us-ascii?Q?ZhI0Y17mOF2VmCYv7zoYOGnuJQ7dUe7/DPVG0J7n+spNA02DihE+fjluY63x?=
 =?us-ascii?Q?ok3qvRQCfLKKaYxV7+4z6p0K0S2H72Kwq2oljE+Njg8s2REzNl459RAcowkB?=
 =?us-ascii?Q?cVvw6fuwilHDxAfmZC1juXiD1o4Gd94NpYbtzOG6t1npxpwyCHuZz/elnl/D?=
 =?us-ascii?Q?uj5YWTq4X6W8qBb9m0CwHkzOU4YLnSZUrm5N/D0qTMn96Z/4S8ZZak/ECvW7?=
 =?us-ascii?Q?FeFAJfFBIADli7MIhjG37gnEg9IH5ET76+QGekyF2uogpWamhVRfm4O1BMPB?=
 =?us-ascii?Q?rTjr82TzO5YFZaeCt2+n5MbdRz+sqTjsxWhWO0KIokgvQjHT6GWkAP6EPir3?=
 =?us-ascii?Q?sEIPkYCfM3F12aE5b+NulCGgOIus9T0fnJz49yzZ7HSs9hBgAzh0Is5EyPHt?=
 =?us-ascii?Q?HybmLW6e7j0c+M01ER1E4PyB42+swghWJqM/F5OlAEh3EVWSo1YIYLh4rqgL?=
 =?us-ascii?Q?5syUDB+vnnDNqMkHIm2kbLmU8DwJYNcU7X47carHAoVPCFg0YgdNCm9SwVs2?=
 =?us-ascii?Q?gP56vIbbv0npgkV+s+yF22zxrvHfAqNfk5rVF91jIodYuKQ5QJtNdQ0cCepz?=
 =?us-ascii?Q?iO1hR2eOqoK5PIJB0RiD3kl0K/J571wEx89S2ua6MIUyfKw7pPIZeQMYNO9J?=
 =?us-ascii?Q?RfWVmwKEUXJOea7ZQvZ0HjdB9H5H1CVsASq65YJh9RJ8qlEKYArGm7G3v0Lp?=
 =?us-ascii?Q?hT5D1KC3i7YLfKPZNxO4plP9iNs/EVq5jptEUvS3phivdhTZZDszWwxYrjOn?=
 =?us-ascii?Q?EUWKTQXXpiAStphmuaSeOiF7TFpnSQivR0zQRjTLf6nR9ie42DeOYAN8I8Bz?=
 =?us-ascii?Q?fAbtf3A8VGpLdq4phyYkkEeEA29WztYFq8/ywh5qNxyUK4R5Vnh92A686ZC7?=
 =?us-ascii?Q?snLVWzWTtBbfI3xQR55wSJPauv2c7qvznLhUmqBBpkNNqS4FjoQzKHoUrorD?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2061c0a2-2335-4cc7-37a5-08dc57a1ae44
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 07:58:30.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ziDRQxpZX+axZQ9KSYKFrgo3b8NdHMOTlhvxqHKI5ly9QxG+jfbPAsbGIeCu34j9wX3f+KJUCNbJvMB3aWBXcx1k9dja+Br57Mn6HvZCIFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6755
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Apr 2024 07:58:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15497



On 4/8/24 9:16 AM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-04-08 at 09:02 +0200, Gylstorff Quirin wrote:
>>
>>
>> On 4/5/24 7:48 PM, Jan Kiszka wrote:
>>> On 05.04.24 08:47, Felix Moessbauer wrote:
>>>> This change is too invasive. The layer.conf is read after the
>>>> local
>>>> conf. By that, there is no way for a downstream user to set it to
>>>> a
>>>> different value.
>>>>
>>>> This reverts commit fcdbec9d2ab1daebd19e021c2b90ed30d0eeae00.
>>>>
>>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>>> ---
>>>>  =C2=A0 conf/layer.conf=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 2 --
>>>>  =C2=A0 kas/opt/reproducible.yml | 1 +
>>>>  =C2=A0 2 files changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/conf/layer.conf b/conf/layer.conf
>>>> index 82b4084..2c888b2 100644
>>>> --- a/conf/layer.conf
>>>> +++ b/conf/layer.conf
>>>> @@ -24,5 +24,3 @@ LAYERDIR_cip-core =3D "${LAYERDIR}"
>>>>  =C2=A0 LAYERDIR_cip-core[vardepvalue] =3D "isar-cip-core"
>>>>   =20
>>>>  =C2=A0 IMAGE_CLASSES +=3D "squashfs verity swupdate"
>>>> -
>>>> -SOURCE_DATE_EPOCH :=3D "${@bb.process.run("git -C ${LAYERDIR_cip-
>>>> core} log -1 --pretty=3D%ct | tr -d '\n'")[0]}"
>>>> diff --git a/kas/opt/reproducible.yml b/kas/opt/reproducible.yml
>>>> index bc71f28..5d6a896 100644
>>>> --- a/kas/opt/reproducible.yml
>>>> +++ b/kas/opt/reproducible.yml
>>>> @@ -13,4 +13,5 @@ header:
>>>>   =20
>>>>  =C2=A0 local_conf_header:
>>>>  =C2=A0=C2=A0=C2=A0 reproducible-builds: |
>>>> +=C2=A0=C2=A0=C2=A0 SOURCE_DATE_EPOCH :=3D "${@bb.process.run("git -C
>>>> ${LAYERDIR_cip-core} log -1 --pretty=3D%ct | tr -d '\n'")[0]}"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WIC_DEPLOY_PARTITIONS =3D "1"
>>>
>>> Let's fix the issue, rather than rolling back to conditional
>>> reproducibility. You could move the SOURCE_DATE_EPOCH assignment to
>>> kas-cip.yml, e.g.
>>
>>
>> Also since we had multiple issues with variables in layer.conf we
>> should
>> maybe we should not let layer conf set any build related variables.
>> E.g. IMAGE_CLASSES
>=20
> The IMAGE_CLASSES is fine IMHO, as this is non-invasive (at least it
> should be). However, the SOURCE_DATE_EPOCH as this IS invasive and pins
> all downstream layers the one defined by CIP.

It is something we don't see in yocto layers.
>=20
> @Quirin: As Jan prefers to not revert this patch, would you take over
> and redesign this?
Will do it.
Quirin

>=20
> Felix
>=20
>>
>> Quirin
>>>
>>> Jan
>>>
>=20

