Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DE5C021A4
	for <webhook@archiver.kernel.org>; Mon, 24 Feb 2025 12:42:26 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.47])
 by mx.groups.io with SMTP id smtpd.web11.88328.1740400940926387882
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Feb 2025 04:42:21 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XcN6OWL0;
 spf=pass (domain: siemens.com, ip: 40.107.22.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFBRLVWJleQOR/rfF549XbbrfX3kgVoUQ3slRRMm1UPiV+fswhKQZ0YMlnUWs7Ki3vd4Jy5JGN/SLfTVIa8TLPAhU077iaJFTIuCx1Kgf85TtOScDq6x8Ea+pIdMZK+GBGbIkuIMusvhyD4VEwe1r77/YQqqHoWFej0VCJFMnTcny1FWHmHu41hsGciD7OrFeMQPiuITCmM0n4U6MASBtPtZ35NofDyXXVRHXyOncTnXKYhYRguM9ryEu2ljrrVlLL0ACWKyAK055heP6vR+gUs80gs3NBL214J5SGLndN/vMnISRgpr8tuRL1nIKP1FdZN6TQSVPkfKeBHFP2Nolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2060G9cuLqxRgvjdJTstrcM8ID5Wa7fPW+3tTe6HQXY=;
 b=Rl+r/s43svsQwdXGi7Ug7qgks1hl9vGpYe3ls49p/MRECj5X+rdmM4fhFLW7vqlXTc7FBjy0+NLQqkGg151MQg1NNrdT3nLv+O1wS8hi7gUepZXxgCoCE2lH1RsQV123J8La3PVvWdC+O3ANpgrVp4hH263wMyDVQaivEXFAfH8IUA5H/7FwBQTAWz9knMj50FTsMCln5GhVEmAn1jPR27iz3c7cPq7NVorMqWKUAqQlJdfJ3dafVyQ7/V4SdW9SAf/ig8XV4UDrEpHn2pCvpEedLccIzT0Pv6vrntYofUxez8p6XsAic+4pQn86DVSKlSTDf3KkRTwvX7N8/W8uDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2060G9cuLqxRgvjdJTstrcM8ID5Wa7fPW+3tTe6HQXY=;
 b=XcN6OWL0qHRngAaAj+mhjgC3Q/rJ7USUbF3XP6Hl69+XjeuAYDIeLVBCr6cPZAOwyLpBL2FE9EqAifghgJSVixdU05Oa74qZc814jr/Gr63RiB+EkRf6dXmZKjon/fqckJ7d93shd2t2pGpd7wT9YU2SYr9TQbDvn7JhVQ80wnQ0+PhpSt/+vhYXQ1hbDM9RRbGdLBdRHHXgdlWpuQBcIJfD8Jbh+MG3bqvytQdm5xd8NYFyjwQfabQa8hmSs9K+b3pZvABawrDrPdmEWJxM6IW6n7//Rmg0CN6dc85d54ug7sdSzz3eBNI4UzjjvdyubxEqUn/ag9c09vWESs7ZXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3931.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:40::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 12:42:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 12:42:18 +0000
Message-ID: <f05430e8-0a36-42bb-9c67-d6ccf60c0ddc@siemens.com>
Date: Mon, 24 Feb 2025 13:42:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option from
 read-only-rootfs's fstab.
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 "Heinisch, Alexander (FT RPD CED SES-AT)" <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <1824F69F112B9158.31881@lists.cip-project.org>
 <AM7PR10MB33205157A04B7C1290C1B6CB86C72@AM7PR10MB3320.EURPRD10.PROD.OUTLOOK.COM>
 <6fce5303-59b6-4aee-b60d-d0d25c8a3a2a@siemens.com>
 <2010c1c9-c33d-48fe-911c-4d4dfdf46d0f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2010c1c9-c33d-48fe-911c-4d4dfdf46d0f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:610:50::22) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3931:EE_
X-MS-Office365-Filtering-Correlation-Id: de0b4a7d-3b49-4f87-bd1a-08dd54d0ac65
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iFyHwpPmvqO0BfaZDYYwKbDGRmR6DfhlXckOyFgmMNyViNJXlPfgD2YcOV3I?=
 =?us-ascii?Q?/1QLxMDlLPs2j6ox/7azaJCKR6Ad6r6fJnw/sJu2O+fA0dFfnSFyJvKS9oan?=
 =?us-ascii?Q?7XVQ0Y8oiqY6C2pAdAwkbvRVaeKR4gafLydSh51njk3F6PcdBF62+K9hM3Cu?=
 =?us-ascii?Q?69USBNIPrFGpH1h71as7nZv7CdLj0rX2KWnV4IVchDN05mHpQJ13mbHNulsz?=
 =?us-ascii?Q?nEW3hYkf9G20OkCWSPi79oOX4mNWKHmhl4QB20hUBS+dp9u/4C6qVWo4/OUM?=
 =?us-ascii?Q?hBKuAckvQB+0hc9gp8Ho4qk/X9QfZS26hNmWe2/rrCTWQRYwd2UYhy/YRoct?=
 =?us-ascii?Q?6qaawjgZSRNuYA/ijjDYCVZidcioNxginKnpFlh3yG//RhQyED1HC9N9P4uX?=
 =?us-ascii?Q?dZQhmt80Nbd9ihADn8GN1XWvZvq8iHUBddsXIEeKxj5q5Ag//XmnDVZkeiB9?=
 =?us-ascii?Q?5EC4l3MpyUhXavzv+MV7kTnhdelNx1EbyHm/WkOgRvJ5/0+pE+r0sQAJHGJu?=
 =?us-ascii?Q?oCKnNSsfOfhXRk996v+HLbpfn38gzVhjk7qjlYadFD5DoCBpTNkyDP8ph1R3?=
 =?us-ascii?Q?muEo5p8wEwkHILtZvYTbuqLZIMS5xjI/864irkypQu580O60WyonbyXRdAar?=
 =?us-ascii?Q?SNj1WvKD/JKNSDdAMnJw+q3CBfg4HUmnjaHGFJX6/fLXosBsBT0PEhkWtORx?=
 =?us-ascii?Q?l5vLdpzcQdYn7j/pqvX2uz48Ocj1tmVD3jxUwv+gWovq1fh7USODljw8ISkZ?=
 =?us-ascii?Q?vVz6Ob+wXwU+blyW1QWPOol/kqiDG+DW8Shk80zD31hbYCnYZC/jEw24/Wz3?=
 =?us-ascii?Q?0u9JanM2k5uAWKR2GyHF3O1LzIdbCcs/8rFjGUAOvlcXqO6pguO7u4f6j1P2?=
 =?us-ascii?Q?OIgYhf8X45ECWFuP7sERIu9F73P6hW+IPmRjRDZad0WnXJk3MYkOW3ZzhMZv?=
 =?us-ascii?Q?+B3HnH1geVVlimLCb6bTrb4802Iy6LiNVVcz/s7hl8+oUXMHbMLHa1tm9W7s?=
 =?us-ascii?Q?B4zaHl3pPckxPGjSOkIlCsAkthf+wNmP/SYZtuM8qN+rDqxPPkML1JoNGUtV?=
 =?us-ascii?Q?SxwkDJFB7EOZcEW7Z0APxpG+1DiGbaFQvXjfI4meVLWGcyO8iO0qRVMlnmM6?=
 =?us-ascii?Q?UJJr0dGu3W6hD5cdmFLvr80esnm3fbTTfiQrriovlE8eEnao0AmuMzW4A69v?=
 =?us-ascii?Q?4sjul3e8eCgBlX7R9ALgq9nudw/E/3WriRmFhhOhHJxSJFpvzKioexbBAZfq?=
 =?us-ascii?Q?TZ5bw8aK4ACR3yXFcADMZBJk9CJ7Z3kX7zsY/qWwhUa1CqiRLjdk9jSgS2HH?=
 =?us-ascii?Q?0MgCBmKUX0QGZzyWcMam5LZ3ioo2wbA2f1TrKNh7p3cnoA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KgGray07R4rl1Y6MFf9J41HFrNQLcr4kFA5I1jxH5nmXYNRdZAZIlPXqfyRz?=
 =?us-ascii?Q?wwPl2QRbbKgl8d9OSmbS+/XXpdvBFwhPKHXbKP8dk62rT1DXPL17rjpozEES?=
 =?us-ascii?Q?zHV2AuioRgCaLSn9FoJkYAU5diZk/7ksXW4w6tzG6E1L4Drd1N6U/4+Vsfgq?=
 =?us-ascii?Q?BvNuzxqb9ddKKQ91xrFcUXUxJa9+vmIRd1rhN5y3oXjrcHMwT5HTn/RSjAOW?=
 =?us-ascii?Q?KksfuKijCs4y77CdzxO2rqYz8AjI1nyz6kL0zMRYlEAw+A0Hlq6kgS6VHqFi?=
 =?us-ascii?Q?uYWyMzPYwJQjXkUsHHV6svIhC2yczCNVj1VdAhxNDe156/dHGQ9I8FX8IWTw?=
 =?us-ascii?Q?JAA/7+bUdbShx1bwTQwSIkkG68hTe5N7JXJlUfaDbkqdSSxEPHUMTnCgdxti?=
 =?us-ascii?Q?ty7vdl5bjQlFCW5KmigCBOa/rew+nKkCfC1UAhuVVKbQyTfmFenvf8vnLbL6?=
 =?us-ascii?Q?IZI2pR/jedPMHUuLuBceQs6GnaY+sz5Ni+2YT8xZNSuMoLaMiFC0HtwoIlyL?=
 =?us-ascii?Q?6zKfzkBzYvtDksB331gQr2mL8yhhBcWlEG71oR/q0rG+8AzlJSd6yn6IVTO7?=
 =?us-ascii?Q?J7zRTrxehAuTsnalJnLyjTSBESDFbLIk+yUOvOZmZOpwApF5FVccOcaXHoSO?=
 =?us-ascii?Q?PSBKBgOGPm5uZy9zOFj4FL6IX0t+bxZK5An2nh1lFZpYrYFc5mQJzozWaUku?=
 =?us-ascii?Q?ErBolI/eP/Z3/ZVT0k7xskn11GmGLlmJ4BIanyfBBo5dXFtttukVm4OoO76w?=
 =?us-ascii?Q?O68179hEoeYBe/jwcRtJ92kkhUEJWkTLEDI4XSb9gXErCwhwCQo0H50lZDwE?=
 =?us-ascii?Q?TJanNFBE9CXnhPpYZNvzJg1/5TWC4HIdgSsA2PPyhcs5ld1HJlwo6BErWUvo?=
 =?us-ascii?Q?mCGeDsdTSEkwl3iaDWHnLStOr1JVQY29O/h7pNeGfkT9pwOY4gL+4Zwg3p79?=
 =?us-ascii?Q?xJiYLKzkKXXEze+pm+SHz+C+tcLUBWGyFWgYplyoqI3NK+kyqv8kEd6Zf1nI?=
 =?us-ascii?Q?sah+5fxfIbpbeUa6nRMvL4msGsy8XoTwM5ZKIAPv5DRd+NvSXp+cYTfu4E88?=
 =?us-ascii?Q?MDYq6XYtvz5hLiXvctBWYrCk3z6o0hO7oM+Ji+pzOSed9ItXjS26yKFYRpd1?=
 =?us-ascii?Q?abpvXnkpB1jvPzY+mA3SKuGSI+/tws7rJQyjOk417cA8M/97mEMfJE1qSMU9?=
 =?us-ascii?Q?JNclkVCZemau4uOxY2o8aATeuoygSNG/lVfZCQbVBqwt5KdwKHbEd5keEYmM?=
 =?us-ascii?Q?8HxjUWJlEdniab84qIr+cAiOg9vI87dXN1w57V8/Vaqzi0UJ9CUURLExfPek?=
 =?us-ascii?Q?bbHUJVz5q22s3wCztskjbmxndo1XFR4fpjazR8umvfp/RhH66ErwIBGG852y?=
 =?us-ascii?Q?OH3aFR0VRfMEUp0vA715xXtFVtYz34hxG1vSgF7kKfDxbefEo8/polo9h23l?=
 =?us-ascii?Q?RKH7yOgpfKL/4A8PYrhC0b/ZIoFjH5YZHzofQ4cf1p/THB3jLcvLGA4NVMS/?=
 =?us-ascii?Q?RPB52YSrks4Pvb24doLbCkugK59HjVf8SeDm1Dhc2zMQa+eVn5vut0C9oHw/?=
 =?us-ascii?Q?XFt4TgUwU4vuel2bPAWbju3o5HivRKJd0i3w2AeSee7jmkH4icsJ+0yO2/J8?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de0b4a7d-3b49-4f87-bd1a-08dd54d0ac65
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 12:42:18.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaOSkPgJi4c0FcC3d2nYDNjvICaZ9K00c2CncK0Yl5yIQI7ady0oBxeN1LuLFzYpNkw158ogACIn+T5VGNAK4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Feb 2025 12:42:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17893

On 24.02.25 13:17, Quirin Gylstorff wrote:
>=20
>=20
> On 2/24/25 07:09, Jan Kiszka wrote:
>> On 21.02.25 13:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>> On Behalf Of Heinisch, Alexander via lists.cip-project.org
>>>> Sent: Montag, 17. Februar 2025 11:00
>>>> To: cip-dev@lists.cip-project.org
>>>> Cc: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>; Gylstorff,
>>>> Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>; Heinisch,
>>>> Alexander (FT RPD CED SES-AT) <alexander.heinisch@siemens.com>
>>>> Subject: [cip-dev] [isar-cip-core][PATCH 1/3] Removed "ro" option
>>>> from read-only-rootfs's fstab.
>>>>
>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>
>>>> Since we only support erofs and squashfs this option is not needed
>>>> any more. Further, it causes potential overlay rootfs variants to be
>>>> remounted read-only.
>>>>
>>>> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>> ---
>>>> =C2=A0 classes/read-only-rootfs.bbclass | 2 +-
>>>> =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-
>>>> rootfs.bbclass
>>>> index 35a3ab3..83ddc33 100644
>>>> --- a/classes/read-only-rootfs.bbclass
>>>> +++ b/classes/read-only-rootfs.bbclass
>>>> @@ -41,7 +41,7 @@ SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}=
"
>>>> =C2=A0 image_configure_fstab() {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo tee '${IMAGE_ROOTFS}/etc/fstab' <<=
 EOF=C2=A0 # Begin /etc/fstab
>>>> -/dev/root=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults,ro=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 =
0
>>>> +/dev/root=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
>>>> =C2=A0 LABEL=3Dvar=C2=A0=C2=A0=C2=A0 /var=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=
=A0=C2=A0 0
>>>> =C2=A0 proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /proc=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nosuid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>>> 0=C2=A0=C2=A0=C2=A0 0
>>>> =C2=A0 sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 nosuid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>>> 0=C2=A0=C2=A0=C2=A0 0
>>>> --=20
>>>> 2.39.5
>>>
>>> We observed `systemd-remount-fs` failing in a downstream layer.
>>> (using a ro squashfs and apply full disk encryption on top)
>>> Although, the service is executed in isar-cip-core as well, upstream,
>>> the service can be executed successfully.
>>>
>>> In essence what happens is that, the `systemd-remount-fs`
>>> remounts various mountpoints based on their settings in
>>> `/etc/fstab`
>>>
>>> ```
>>> root@device-mgmt:~# cat /etc/fstab
>>> # Begin /etc/fstab
>>> /dev/root=C2=A0=C2=A0=C2=A0 /=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
>>> LABEL=3Dvar=C2=A0=C2=A0=C2=A0 /var=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 auto=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 defaults=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 =
0
>>> proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /proc=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 proc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nos=
uid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0 0
>>> sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /sys=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sysfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no=
suid,noexec,nodev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=
=C2=A0 0
>>> devpts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /dev/pts=C2=A0=C2=A0=
=C2=A0 devpts=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gid=3D5,mode=3D620=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0=C2=A0=
=C2=A0=C2=A0 0
>>> tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /run=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 tmpfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> nodev,nosuid,size=3D500M,mode=3D755=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=
=A0 0
>>> devtmpfs=C2=A0=C2=A0=C2=A0 /dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 devtmpfs=C2=A0=C2=A0=C2=A0 mode=3D0755,nosuid=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 0=C2=A0=C2=A0=C2=A0 0
>>> # End /etc/fstab
>>> ```
>>>
>>> Since `defaults` in fstab renders to:
>>> `rw,suid,dev,exec,auto,nouser,async`
>>> the service fails trying to remount the `squashfs` as `rw` as shown
>>> below:
>>>
>>> ```
>>> root@device-mgmt:~# systemctl status systemd-remount-fs
>>> =C3=97 systemd-remount-fs.service - Remount Root and Kernel File System=
s
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Loaded: loaded (/lib/systemd/system/syst=
emd-remount-fs.service;
>>> enabled-ru>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Active: failed (Result: exit-code) since=
 Fri 2025-02-21
>>> 08:55:39 UTC; 5min>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Docs: man:systemd-remount-fs=
.service(8)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 https://www.freedesktop.org/wiki/Software/systemd/
>>> APIFileSystems
>>> =C2=A0=C2=A0=C2=A0=C2=A0 Process: 7530 ExecStart=3D/lib/systemd/systemd=
-remount-fs
>>> (code=3Dexited, statu>
>>> =C2=A0=C2=A0=C2=A0 Main PID: 7530 (code=3Dexited, status=3D1/FAILURE)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CPU: 15ms
>>> ```
>>>
>>> ```
>>> root@device-mgmt:~# journalctl --no-pager -u systemd-remount-fs
>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: Starting systemd-
>>> remount-fs.service - Remount Root and Kernel File Systems...
>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]: mount: /:
>>> cannot remount /dev/root read-write, is write-protected.
>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7531]:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
>>> dmesg(1) may have more information after failed mount system call.
>>> Feb 21 08:55:39 device-mgmt.local systemd-remount-fs[7530]: /bin/
>>> mount for / exited with exit status 32.
>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-
>>> fs.service: Main process exited, code=3Dexited, status=3D1/FAILURE
>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: systemd-remount-
>>> fs.service: Failed with result 'exit-code'.
>>> Feb 21 08:55:39 device-mgmt.local systemd[1]: Failed to start
>>> systemd-remount-fs.service - Remount Root and Kernel File Systems.
>>> ```
>>>
>>> The rootfs is mounted as follows:
>>>
>>> ```
>>> root@device-mgmt:~# mount | grep " / "
>>> /dev/mapper/verityroot on / type squashfs (ro,relatime,errors=3Dcontinu=
e)
>>> ```
>>>
>>> I understand why this happens on our system, but could not clarify
>>> why it does
>>> not happen upstream! So any idea, welcome!
>>>
>>
>> The same issue happens in upstream: secure boot on, data partition
>> encrypted, remount-fs fails. Which makes me wonder if our boot tests
>> should check for failing system services...
>>
>>> Nevertheless, after rethinking this patch. Maybe it was advisible to
>>> not use
>>> `default` here and either use a options like
>>> `suid,dev,exec,auto,nouser,async`
>>> or drop the line for `/dev/root` at all, keeping the mounts as they
>>> were setup
>>> in the initramfs.
>>>
>>> Any opinions, recommendations, hints, ...?
>>>
>>
>> According to the man pages, a left-out rw/ro means that mount will first
>> try rw and then, if it fails, ro. That would give us the desired
>> flexibility. Hard-coding the other values of "defaults" is the downside.
>>
> Will no also lead to error of systemd-remount?
>=20

It does not help, yes, just tried in vain.

>> On the other hand, what would be the mount options that the initramfs
>> will use? We do not have direct control over them as well, do we?
>=20
> The initramfs in standard Debian contains the fstab - so it would/could
> use the options from there.
>>
>> Quirin, other reasons why we want / in our fstab?
>=20
> The fstab of the readonly rootfs is an evolution of the original fstab
> from ISAR. It is also there as we disabled the fstab generation from
> wic.
>=20
>>
>> Another option: "ro" a parameter of read-only-rootfs.bbclass so that
>> your scenario can override the default.
>=20
> I would make it to option for all the fstab options.
>=20

Ok, let's go for some config variable then.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

