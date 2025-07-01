Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C63C83038
	for <webhook@archiver.kernel.org>; Tue,  1 Jul 2025 14:00:04 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.12])
 by mx.groups.io with SMTP id smtpd.web10.11468.1751378399620276022
 for <cip-dev@lists.cip-project.org>;
 Tue, 01 Jul 2025 07:00:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FBx4veVN;
 spf=pass (domain: siemens.com, ip: 52.101.84.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qeg9nRNHuiidbhf3h5pBEZ9bsGzez2cDATuC+6v1GdtPvxLGY91zAyvgPtVwn1gkWRMq1+6PwNGvkVcngaIPKn0pbVEEqE1hhikGpNSojEls3qdGJlY3Cy3LkdujVfT7jIIyDTQPqi0tg59H8MzcmSINRIfjCxItuSPisPVbUv6W/et+XCHjCsaQP+9dRbRXfYG5di53zgASEbUF5FkwOZKquFMpyx/nxUbzboMgqCBKoEA+axlW8oYRoZhdah8Hcy5z9OzuM88znoAT5vp6Lydv4Y90eSTcmzFe80XDJsLa89+DeAh2Gdy2CvE0A3rTfh/SWcebyaTk4RCnxLjgYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa9fVx5a6WSZ13I/q+NZ2p/tOeNoO0CZqF+FMActojQ=;
 b=ojR901xpy3SzFM1uy0HH1aB/vf0mx0KkMxK9Rf+rd05FDKnYpTRIPhF9nEYDQQVfvzfOu7u3NpI3DAmNzNkiZs0d3wK+ubTAVEPGBDuZye5O5fUUojzSPJi3AwEDgmKJR0kg1/7NG4Mh631Ng6K88hm2SXkjCggyiOcSzWo6XwJU9Qq8rp2v4uzUyteNwNZsyqdcZCK8h8fb52bH0YIeWbYWSQm8aJMxyI6im2xgRbiMgZMbigbvwXIxsiFrwUPH44CKVdumgDFTBs+jWL832c60ph3apjcuT3sfZss9ZI8OBqr1nCfAuC1WNCA9uUODDA+Nj8KZHyNzfSiCIDtpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sa9fVx5a6WSZ13I/q+NZ2p/tOeNoO0CZqF+FMActojQ=;
 b=FBx4veVNROqEtncSsgpZmsNG/C9w79Qzbx0kRfUuOsnpuiDmn4zSQ8pd8CCF944bc8VUJ/pMGB0pq/C0bxcXS3kgXOnAHsmFcQUP2xwKH1OIfGbCiNAeptc3naE1xgjteAinCs3V4CCP1CKwN0YeaPK5cbO0y4T0F7UEuLMaiDy83Erkhnq2qDLbLlquGY0uzvR+h3fF85t42KeSbw40hLqHYNxsOJrmWZUIvRTut5qhY343nnfGKty5El+qErA4tLNHlhPauCg+31NTNvu/5Wtga7w/X1ZDL7ixWekHfiyqMFo9HyrV1JEufNdJBqFn4746OXKu0v0Ylo7RH1yOFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6216.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 13:59:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8901.018; Tue, 1 Jul 2025
 13:59:56 +0000
Message-ID: <065d9adf-dce3-4c3d-b2a1-04e98e9894b8@siemens.com>
Date: Tue, 1 Jul 2025 15:59:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][RFC 0/7] Immutable /etc
To: "Heinisch, Alexander (FT RPD CED SES-AT)"
 <alexander.heinisch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>
References: <20250630181516.1718712-1-alexander.heinisch@siemens.com>
 <881c1466-0b98-4f48-9faf-0c7c65cbfc57@siemens.com>
 <2fc7ada9-53fc-4fb7-90dd-45d275c90501@siemens.com>
 <a7ad4a8f36cb3606d772570b48b9d1fdeda24387.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <a7ad4a8f36cb3606d772570b48b9d1fdeda24387.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0291.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6216:EE_
X-MS-Office365-Filtering-Correlation-Id: 42658e6f-9de5-4070-dc48-08ddb8a78f61
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?zMgI7SUT02CEiJpEJ9La/52YqFic+Ud8ulEdsWWZ4NtNCDaX1PxSc7UkKxBV?=
 =?us-ascii?Q?IDKmmXiEBQxx44mcIfKfFUQ4LfbPEX1NWaDRd6NNDP99bIgncj8J0iYA5CNm?=
 =?us-ascii?Q?zsVzn/m49/KXozUuE0kNP81Mu8STf9lRL2LXcZ1FavuDCYc2LGW6iVmC7ih/?=
 =?us-ascii?Q?SB2VuxpmBwAOnb9kYmcgz81IOYuK1Yld8D8nJxcV08hLNgHKwMAlg9gJjvGc?=
 =?us-ascii?Q?c1Sc94C6p51+B49cMwnBf1NZfLpzMylWdxitDw38cB37lQHJe5kPW1jwD19D?=
 =?us-ascii?Q?+zM4olaFi3/begvcvs/8mi/C2RA3PHymkPVk4i+KF+DT5oz4XliUDF43ggOJ?=
 =?us-ascii?Q?vS/9eX92VaaZUGk4uuo3G9cI9QC92fnGpUiisaWl5LS+dn+XxeeZvifCwkT8?=
 =?us-ascii?Q?XcjwspI0yeh+LGOLuvNSt4juRBUvEs9vK1O6M3+9KpZSU1peFMm9NkEvL3Mh?=
 =?us-ascii?Q?oVSqciQe1i2sIDPfJQ9ZH0BnpK7+4iCF6ii/jBjuCL4FRaFrOnAZGUCkSoed?=
 =?us-ascii?Q?7keobdp1uPuaaRMwM3r0vqvvOFhpzV7ih31lvk42g+JQTwzGl223D17RxrZr?=
 =?us-ascii?Q?g9LwYM7ncihiWNCCscD6+VLyumZyKC6dKqQmFm9WS9jqir5yDgEILvS3axrR?=
 =?us-ascii?Q?7yw8xXF4u1gh3zOjFbD8aFjSX4WhopIKFpVNxQPD+8/20yUmOJ4aT+0nEls4?=
 =?us-ascii?Q?NWElfaLHrl4mRP6ORP7tfJ0zgVRs2qoDGW45O39x4RorBkoL85bSy7fKk2xX?=
 =?us-ascii?Q?95xZYWOJLV7NAg6Ow33zge/WTPfgaQzLzAKHZTKWYde9T/j6f8W9Q4JUiRg8?=
 =?us-ascii?Q?gKiK7oJZTayL9j+XDorog31IQrMhpSKTvFmyYUANnIKpbjdB70rhPaDYMnEx?=
 =?us-ascii?Q?1QBgBtliZ4zTI+vMkoXAhMybWruYppu+VcIeuuPV6HuS/DcqFal4xP0niJaJ?=
 =?us-ascii?Q?oqOq21LWWLa1Y/5ctPOkZ/25oj4pdUo2Bnt0H9J4eIRrd7EEBppnHrs2t6X1?=
 =?us-ascii?Q?EwK2MsyHXDODCTCYnUp94o4VM/FUY2wkaixCAt3KIWUTYJSIxhndAObUYrEk?=
 =?us-ascii?Q?+qLOAaDWlxIlOzgtbq2oCU0yW4ob3YY5+U1lVWRxLtjoJ6c2rsGeSV0IcRrS?=
 =?us-ascii?Q?aGJ739xFZAwwgCfSuRsn8/hqffmT1fO2DKj4cW+lo/JAEfXijpZZ9KZc5wJA?=
 =?us-ascii?Q?ywrBH+bFC92ml2uZHDAUrsIw++bjvCpezYoO+5wMGqux7x/gLHqmUAXww8fV?=
 =?us-ascii?Q?JcNAhuMe+vcO8/XdhvNa/xIcvMflmnUHtiOKvCF2EN1rtItQtxEZUEzLeFSD?=
 =?us-ascii?Q?EJL2g+5aRZ/md97OK7Wp7iU6BThslwHyIFl6Yz85L84z4WPa9TvpfKYxLGu3?=
 =?us-ascii?Q?1r1QmR7fTHzJh+VbFyLNKCsQ0cggJaWBfJDpMJwEU4lKVdi0AiO62xVCaKZ1?=
 =?us-ascii?Q?v+Kuz60g4N0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?s21ghjLj0V4GI1VqTSodmw9PSXoZHGap5gAfcyBP7S6BYFOV2Ox20f3WvxWh?=
 =?us-ascii?Q?NPSDOIeG/YshWDS/NoyHnM1nssFsgDGkBZJRM3jqtaLG4/IF0wpQyQMbDC97?=
 =?us-ascii?Q?W6pf2HQiq7PKK6SqmU6rbwBNC8tBX7sZnOdN/1w4dJDs+531EuSBepnk3Jws?=
 =?us-ascii?Q?08B1XhxIKBSIirwD/+R+R5TFZdUiAcCtUjlbuJ8VBVGu1W1KH1RzbZOI9C/f?=
 =?us-ascii?Q?cLFBrhLw4PVZOpAf+k7736m0k3bYMCV3pbSt2BN39f5QVZ+3tAh+RYINWGXb?=
 =?us-ascii?Q?+s5bg2sT7iz0NUrvIW7OMXCzLlof6zU+WUzjISZO498DZIQ6ePxt4D+kZAeY?=
 =?us-ascii?Q?eBxqob4K7pH9oHr0fUrccvmmQQCMKmMrW9oCkwXk6ZtkeMEz9ICdEI7hz71a?=
 =?us-ascii?Q?CkGi0mmcqhsyPqBvUfGhcSz+OvbQFMBYGfXdOvSKhyo85ykWdVKN8BfFNbGq?=
 =?us-ascii?Q?UoQV6B/2vGSkUrnh2/RhunrZZ+5kzuiNDOw2xf+BNPKYcPon+uH/owVHcl3L?=
 =?us-ascii?Q?s2EIK0/ZcTClpYuDkvnYiJ3WNlgEcU9KChkEJuutsh7xogXev1aRanVDE15Y?=
 =?us-ascii?Q?W/PRLKcZbKuGJtFMcr6aYdeBED07mxGVZ38ePf48fhJxt21woYo3d9CHG3in?=
 =?us-ascii?Q?VxBDRLkudbm8U6aL2j04IsWW4OOsC5RcvRj90TGJBNFWXDxxXlEukyDH1Nl2?=
 =?us-ascii?Q?8t+jRLuKihMAFXgpQ5RIFaAui6zpsNl7OOggMcDxOQV4/HzDAdhfHv6v8vTO?=
 =?us-ascii?Q?s4o6DI/rKfo7u/A/DcHtOLxCkhggg7Qncs119VLyTeUMtx0mYwyqeQ1CvJrj?=
 =?us-ascii?Q?5Ema6FlFg+BVVAb2MXLy5FpuKVp8Kh2rhoiQAoRk4HVBXSq6tRlMs9DXbmh8?=
 =?us-ascii?Q?IJilGywlp9MQVMoyQUeE7jpwneXaU+dLu2SZpyUKhLawvxrEfd/xNc3OEDvc?=
 =?us-ascii?Q?jACNa2TKX+/7Xw7DIY0EYW62h2g4zze/M9C5bd8//xgpUe1s3LCelPNDz669?=
 =?us-ascii?Q?NCY/hlcLgHTG1pPm0gylZ6BqUeYKLg+5y+Hx36Fqb4dvpaisiLcBxIs7e5ns?=
 =?us-ascii?Q?Vnrjl1o8vxBCJ9V4Rq6dTX2Z9xrFHPjL5Zo01x/9vpLWxSPGdttZ5IH34omc?=
 =?us-ascii?Q?esvkpYXjZ1I9gCdy82/4dHg9BVQJidJeP5KxAPfbRuZaNpbrqBfzHV7jLB/t?=
 =?us-ascii?Q?yUMbxycElT8gFnVrggtV3C5JmodOX1LP2PiP+PzvA3C4mud3idTapiW17p3T?=
 =?us-ascii?Q?JP6vmg5SwCTqZrWrAj2LI6wcdBO3VZRLa0zp6LzCttd5I31ol0i/Z4Bwfhg/?=
 =?us-ascii?Q?vgK7ZpZmSLLEcH+W7L0SyDs3notzoVXWb/+xfF/b7FXm3SoDPEvR0duiiATh?=
 =?us-ascii?Q?1+UmJjb9V9UAfuZDX1hcuLmwBeYgiFbjco5mGhHIUGEZI1k5+5E058FwPdSG?=
 =?us-ascii?Q?3A1q4ys0dCK0RsgOfI0hxmotHQjXjPDJIOexRTO8Ex6ZqmzwRPu7Qq8q040P?=
 =?us-ascii?Q?6Vg1Y+b1bVUXSTkvdfrd0keLm5oYX5RfxzA1R0qKy8qQL/SxcOMbfgM0UJhn?=
 =?us-ascii?Q?Tys3dVy8HhJcVTnbb7rTdmF94uxntzOMqOEFmjekOH2M8VhdmuLmJTgIHVdQ?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42658e6f-9de5-4070-dc48-08ddb8a78f61
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 13:59:56.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: azEupsnirRbaQjeEdZp+VS4xhKN0otR/HEDW8iHal8apCSX0tj9jJcANo83riUhuk8Rr7QRS6gNfnviJPgw38A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6216
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 01 Jul 2025 14:00:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19272

On 01.07.25 15:31, Heinisch, Alexander (FT RPD CED SES-AT) wrote:
> On Mon, 2025-06-30 at 22:11 +0200, Jan Kiszka wrote:
>> On 30.06.25 22:10, Jan Kiszka wrote:
>>> On 30.06.25 20:15, alexander.heinisch@siemens.com=C2=A0wrote:
>>>> From: Alexander Heinisch <alexander.heinisch@siemens.com>
>>>>
>>>> **NOTE:** The patch series appended to this RFC mainly covers
>>>> handling of /etc/machine-id (see below) in the proposed solution
>>>> and serves
>>>> as a basis to estimate additional complexity ro etc introduces.
>>>> Thus, be aware that some of the patches included are not to be
>>>> applied
>>>> on next, (yet), and therefore, this patchset does not cover all
>>>> cases and introduces some regression on the images built
>>>> (e.g. ssh-regen-keys)
>>>>
>>>> The setup used for the PoC was built using:
>>>>
>>>> ```
>>>> ./kas-container build kas-cip.yml:kas/board/qemu-
>>>> amd64.yml:kas/opt/6.1.yml:kas/opt/bookworm.yml:kas/opt/ebg-
>>>> swu.yml:kas/opt/readonly-etc.yml:kas/opt/machine-id-on-
>>>> var.yml:kas/opt/config-on-var-demo.yml
>>>> ```
>>>>
>>>> ## Background:
>>>>
>>>> During hardening activities we identified potential
>>>> security implications of having a rw /etc.
>>>> While this most certainly is a problem when attackers gain
>>>> root access to the device, it prohibits unnoticed configuration
>>>
>>> You likely mean, that rw /etc "allows" unnoticed changes.
> Yes! Seems I confused permits vs prohibits :-) Anyways, "allows" would
> have been the best choice :-)
>>>
>>>> changes by tools running on the system, as well.
>>>>
>>>
>>> Can you please elaborate more on the actual threat model? I'm not a
>>> fan of adding such complexity based on "something may go wrong".
>=20
> The main concern is that attackers or poorly configured services have
> access to configs on /etc if mounted rw.=20
>=20
> While systemd brings fine grained sandboxing capabilities, those are
> not always preconfigured in upstream packages (according to downstream
> / embedded requirements), and thus, constitute a high potential for
> bugs and security threats. I have to admit, proper hardening of the
> services is a must anyways, but nobody is perfect.

Then let's fix those issues upstream, one by one. The alternative of
working around that here, one by one, is not very appealing and also not
according to our principle (upstream first).

>=20
> Having a ro /etc prevents many of the following attacks to **persist**:
> - enabling/disabling/masking services,
> - extending /usr and /opt by enabling/loading systemd-sysext,
> - permanently mounting (external) storage devices,
> - reconfiguration of network interfaces / dns resolution,
> - modification of ssh-keys,=20
> - modification of udev rules to trigger certain actions,=20
> - auto load kernel modules,=20
> - add users / groups
> - ...
>=20
> Yes, bad guys having root access, can do everything anyways! But that
> way we can fix many issues at least after a reboot.

Again, I would be able to follow your proposal if only a few global
measures would be needed. But as all this requires pre-package modeling
modelling of /etc persistency or at least per-package qualification, I
would rather spend that time on fixing the root causes.

>=20
>>>
>>>> Further discussion is based on following observations:
>>>>
>>>> 1. Many services don't need to be reconfigured during runtime
>>>> =C2=A0=C2=A0 and shall remain static. With an (rw) overlay on /etc thi=
s
>>>> cannot
>>>> =C2=A0=C2=A0 be guaranteed.
>>>>
>>>> 2. Having fine granular overlays won't work either, because
>>>> =C2=A0=C2=A0 some services rely on files put in /etc directly.
>>>>
>>>> ### Systemd:
>>>>
>>>> Systemd maintainers suggest to have full /etc rw and
>>>> put immutable configuration to /usr.
>>>> While this theoretically could work, many programs
>>>> don't fall back to configuration on /usr and if so need
>>>> to be reconfigured (efforts not estimated yet).
>>>> Further potential to reconfigure services (permanently)
>>>> is still not prohibited, since in case of systemd
>>>> /etc has precedence over /usr (/lib) based configs.
>>>>
>>>> ## Proposal
>>>>
>>>> Therefore, our RFC proposes the following:
>>>>
>>>> 1. Having an immutable /etc
>>>>
>>>> 2. In case of non-epemeral, rw-able files use soft links to
>>>> /var/mutable/...
>>>> =C2=A0=C2=A0 In case attackers get (root) access, this still impacts t=
hose
>>>> =C2=A0=C2=A0 configuration but the rest remains static.
>>>>
>>>> 3. In case of ephemeral, rw-able files (e.g. config that can be
>>>> regenerated)
>>>> =C2=A0=C2=A0 same can be applied backed by tmpfs and config service /
>>>> tmpfiles.d
>>>>
>>>> 4. In case of rw-able dirctories fine grained overlays are ok.
>>>> =C2=A0=C2=A0 But most probably on hardened systems config tools exactl=
y
>>>> know
>>>> =C2=A0=C2=A0 which files to touch (so use can be limited quite
>>>> exhaustively).
>>>
>>> Are we the first to propose such a scheme? What do others do to
>>> achieve
>>> similar protection goals?
>=20
> 1. systemd / Lennart Poettering (see [1]):
>=20
> Two types of systems:
> 1.1: Zero persistency ro /usr ro /etc. The (re)booted machine is
> considered a completely different machine on every boot and, thus, a
> newly generated "random machine-id" is ok.
>=20
> 1.2: For Machines having persistency / config he proposes a rw rootfs
> and only an immutable /usr, but having /etc only (pre)populated with
> local config (which imo is not realistic). From the threat model
> described above, systemd itself, by putting precedence of etc over usr,
> does not support our case in that regards.=20
>=20
> 2. sytemd confext: Lets overlay etc with configs from
> /var/lib/confexts/ (among other locations). This if mounted mutable
> reduces /etc to ro as long as the config is mounted. As one can put
> unrestricted content to the confext (etc) this still exposes whole
> /etc. Further, in case we limit /etc to ro this still requires the
> machine-id hack to persist generated machine-ids. -> While nice when
> you plan to reconfigure your immutable system in the field, it does not
> help with the security concerns raised above.
>=20
> 3. yocto/poky suggest following scenarios:
>=20
> 3.1: run systemd-machine-id-setup at install time -> this either
> requires a non squashfs backed etc partition or a link / bindmnt.
>=20
> 3.2: have / read-only and an empty file there (for stateless) ->
> regenerates new machine-id on every boot
>=20
> 3.3: boot with / writable
>=20
> 4. elemental (rancher) / kairos (similar code base / fork): mounts /etc
> as rw backed by ephemeral storage  and bind mounts persistent portions
> of it. /etc/machine-id handling is done using cloud-config based
> workarounds copying machine-id to ephemeral /etc/machine-id in
> initramfs. -> Also introduces special treatment. Compared to my
> solution it requires special setup of a tmpfs overlay on /etc, special
> treatment to restore machine-id from persistent storage (cloud-config
> stage), masking of sytemd owns systemd-machine-id-commit service and
> custom script to persist generated machine-id later on in the boot
> process (also cloud-config). For the persistence they use bind mounts
> compared to links.
>=20
> 5. Some other systems run their rootfs in ram only and link persistent
> portions to persistent storage. (according to SO at least some versions
> of QNAP)
>=20
> [1]:
> https://github.com/systemd/systemd/issues/14131#issuecomment-689643106
>=20
>>>
>>> And how many services will now need lots of fine-tunings in order
>>> to set
>>> up all those links and folders?
>=20
> During our investigations we found following numbers of potential files
> at risk:
>=20
> downstream:
> - files on /etc (regular + links): 731
> - links needed for hardening wrt. /etc ro: 10
> - service modified for hardening wrt. /etc ro: 2
>=20
> isar-cip-core:
> - files on /etc (regular + links): 262
> - links needed wrt. /etc ro: 2
> - service modified wrt. /etc ro: 2
>=20
> services to be modified:
> - systemd-machine-id-commit
> - sshd-regen-keys.service
>=20
> In case of sshd a fine grained overlay further reduces the need to
> modify sshd-regen-keys.service and also the number of links.
>=20
>=20
> Thus, the added complexity basically reduces to special treatment of
> the machine-id and setting up links for the services we want to
> reconfigure. In case we find agreement, bringing a .bbclass to ease
> such setups further reduces complexity of such setup.
>=20
>=20
>>>
>>> This sounds like labeling a system for selinux: Can be done once,
>>> all
>>
>> ...labeling and creating the policies, of course.
>=20
> It's about hardening, and as you said selinux, apparmor and similar,
> don't come for free either. This proposal is also no replacement for

If hardening goes against maintainability, you lose security-wise on the
long run. That is an often ignored fact, sadly.

> the former. It just brings an additional layer, which imo, can be
> understood quite easily. Maintenance burden is something we have to
> take care of by providing the right tools e.g. bbclass to support
> developers, and probably also export of reports documenting such setup
> at build time.
>=20
> Imo, the main burden is having the /etc/machine-id setup which is kind
> of unaligned with systemd upstream vision.
>=20
> Nevertheless, I understand the skepticism. Maybe I overlooked
> something. Unfortunately, I have no better plan yet :-)
>=20

If the goal is to avoid persistency of sensitive configs across reboot,
come up with a proposal that keeps /etc in tmpfs and persist selectively
on normal reboot or when explicitly requested. That would provide a way
better chance to not collide with every second package of today while
improving their support for r/o configurations one by one.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

