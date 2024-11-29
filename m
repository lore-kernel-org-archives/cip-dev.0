Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B0D6EC13
	for <webhook@archiver.kernel.org>; Fri, 29 Nov 2024 14:12:45 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web11.116540.1732889563621109599
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Nov 2024 06:12:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Yggt0h4v;
 spf=pass (domain: siemens.com, ip: 40.107.21.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TlivVeJ21Nbli3kLhPQmyFEwakvV08Llt3RuN9brfXM/OnBZQRoDIJ+iVXrEJMDFPOR7fGUt9EpGxSg/MvEPYZKhRVIRSB7g7WiuP5jolcsyk1NhwjBd4NO8vDPqann7gIuYWK0dnr1XT2fBxAG/ZXU4oRUjHAWi/LnVZRyCoh0vk/gl5n39YsWd9fGplBS+qEZ9m7WBCQijgRauajlszCD9ejFjo+0SdYElIAZoYRp43QRauIWDbgttYvwaknLJYOo0p/Ezsymt0gc7Mdc5PJpDdh+6fRt7I1ADXRjWEONChD5+B//GejvludJCT5WBBbnh2BRPxRvxVQNcX4EwNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9SluvD+qEIS8Dd5qvoxnT/+SDKGelmCkg3flfx4Mq3U=;
 b=S9njUdcRTIE9iyJs7iw4LWESDN3TLHcyJMaGPjRklHRiUVMmRK7zd+xFyU8JHKA3MB+x85YCxuihz6Ve6uxX2VhUfltdGAHrJhMaCMOlK/rAI4ShGhigzZMki0921eoJ5FTIFtpj0UsyBhRw5jQLMxhUDLApWin+rAHClyuYqi5uWOm5/ZBX6i6iMT3zgF3YxKd1DLA6Z7IaIMZb4g9tgIingzlIhvdRKMxlWr14e6dKQdrTbU6qc4T7sLhDw7EUt/0+xXcQkTVGIPvCIBLyWW+ndhsH6vEwMyPUhL+N0sw9ppLQuzlno4oCRXP2deO/iuTOiTqvY8xSa/V3xEF5cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9SluvD+qEIS8Dd5qvoxnT/+SDKGelmCkg3flfx4Mq3U=;
 b=Yggt0h4vVgHNogUm7d1hP5y+MEQggB5RPFnbTBssQa6PYH4PHPMeOh+kB3fhwS6M+qxlgoJ6snhWlPq5Pj8xxBg1d3MmSfOXe1MAGCSVDXdURMSlHk2oykuTlRLbWiYilFfqyb69MTcrZLDxHsYxjajYumjLhPvScfzpwJ2Xxr7S+kd2Wd1ihtAeGBhfMFD5g0GOlVpMm9184P/4SWj2a9csb09BifT72XTcK7qKm3ve6qhDWyT9fjvMsP61Gj6Vbl9fG0c7RRz1PK2/WRO5Ex1964OYgTs+9Gabh5JxEwmEBsnKS+1hhU9TShIGTu5hoXjBRg65gJw4MPqApLD1Fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8615.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.4; Fri, 29 Nov
 2024 14:12:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8207.009; Fri, 29 Nov 2024
 14:12:39 +0000
Message-ID: <d76564b5-777d-4dd3-920c-a8c903ba37ce@siemens.com>
Date: Fri, 29 Nov 2024 22:12:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: Hardware Support for Raspberry Pi 4
To: d.kauschke154@googlemail.com, cip-dev@lists.cip-project.org
References: <bf09c286-2b4d-4c39-b0bc-0880215d7c7d@siemens.com>
 <2202.1732718875254901355@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <2202.1732718875254901355@lists.cip-project.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P195CA0011.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8615:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a59442e-cc80-4c5c-09b3-08dd107fe1ef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?p9jVBlPMAI05KNNJ6ltoPjbQ53Th4wNgeSAGMmJ5oeEUSelFwRgFyr20W4uc?=
 =?us-ascii?Q?l71ibFSwAqG2AsF4oTyaRLeN9j6tk5fORB8UIEGAahYNKvFFXWtKxDWkxdiK?=
 =?us-ascii?Q?Zngndhs6IRRdwZAWBOmrHxYT1bmCpHYJTtnd7T2dW+UP5EgSC3Hk3RwlKpG+?=
 =?us-ascii?Q?IZiz/WUEz7/1GTQaGs622aXwG4tfbhPvg8n9YG26Ugth3tzN7qScsKA1Rdwb?=
 =?us-ascii?Q?pAR7peUwNHQhpRYwUDfsAC7lJsWXKY0cjl+TYkOL/kM5ArMze0sQzUqCvKR+?=
 =?us-ascii?Q?qr9icg2zdHzENpQwH+u5u43K+d/nu/sSuxagP7BIFuGJCoxCcP8mZjLBG3qi?=
 =?us-ascii?Q?Ezj2c7D7Csi2ELQ/WqhD4/BywP+TisSmx43sgFr672DB7pXjfe02+xJumOfo?=
 =?us-ascii?Q?Lx0H4HdvBfv1GoEGrtJerqL8fVsN/Zso7wAaXTIpmGpraVjSBpwxJ4r5Yg0o?=
 =?us-ascii?Q?UYfifqQum+2/GlheSSLuyH8YKgik0kXP0J+b0QyAmk0C1LVzyYmHaBrt1RyF?=
 =?us-ascii?Q?9d28GQagH8ztj+YwpJ6IawrXRpDTXjO0pwsR/J3Y9g/WX2n7BilD/UGaE/R1?=
 =?us-ascii?Q?HhTG0JC7tyIQM7maYOkl6k1h0bWgr81S9tmc5oJsNOrGLRtOEjuIFmEw20vW?=
 =?us-ascii?Q?chpR7JEXceoH3UGbkPNCq/TmMDkpNeaXxY9eRxlWlY4vIcqmXh0pEsgYhjqU?=
 =?us-ascii?Q?BERT3IzIBBvaMCq62yPlP9rPyr/0jHWa1JEvHDCqIrYflZEYkFsq3NYj/jvy?=
 =?us-ascii?Q?19NCR9P4U/XmsLqqsORYps1+uRoY9MPajq92H9jEnZOF/xF3KakL3pTYx7Lt?=
 =?us-ascii?Q?whnwERNKKpT5Eh3brBO90s6arI5LbIadSsDAiV6nzi7lH1bWKfVLVtNApj44?=
 =?us-ascii?Q?5toQpVatrJeygqzm76ZJpn8XfBezI8ouHkPZpTDJiByLnf3WhCJRkNTEvl38?=
 =?us-ascii?Q?0KRNtddKs3yAdIo0dsJcyubvue+53VjeuVz6RIQgFkMp8paEtkX0bZ4evrvL?=
 =?us-ascii?Q?03VsvIMQspw9bLrU7+aOuetdXiTst4PRB+JXBtNwJz+nOrhRBEcXWvk5Gz+x?=
 =?us-ascii?Q?aS9E+P2rHeKXR6SGFgX0O5Im6dxQRNGi1T8rhDdUJRUw/Ie9CxrGiXU+8Uix?=
 =?us-ascii?Q?Yc8TXIpPBdJz/vfqBm3uB0i8Nfcfa8ZU3vELj6r71qg74zzkNs4EYu0jt0jD?=
 =?us-ascii?Q?K5VTiA2Y0zj8a2IQISGEZXv5/kFfu02Kux/iXV/uA+rGypOtnLAaPNgBLhD6?=
 =?us-ascii?Q?KKNkUyR4xTSTzQgGbaoJJgG/LQMK/ErRW2IO3jdx6ehIRxetLpxNWFcf8wnd?=
 =?us-ascii?Q?zMX4RMw7sBtwwnCyO1j0qfJf03prtsn8TiVv0vxnWqOI1UOTVeD1RSFxZtDZ?=
 =?us-ascii?Q?pjc5tnc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?YpOXJUEIZS6tLJsnIUJAfKL19PJNPhmmw9w4rBAx1W9SEJrYe4u5FMnnX9TT?=
 =?us-ascii?Q?DSLgp13PHFfBEhf2zA3a1tTrf8UgwBXm5p2jOea/xVP+T97rBQ88QbLFS26n?=
 =?us-ascii?Q?n4Il/ebDXshcSNXoqmQ3PpsHMoQVu3466J4qhkj0ZMi/6BV7i+tuS9Duf1sJ?=
 =?us-ascii?Q?irbABQiouWeMLYotJKRb8daBtvNQxxRvJtb1lJwSeZSeHh2CTDMEyRBgFpLI?=
 =?us-ascii?Q?8uvVG2av4+jU8gV15sdixPrd9pfMdtL90dsS0ufSLVAWcVpdwCtHV21EiAmA?=
 =?us-ascii?Q?qLErTBzRuqIa0vrGamxevLvkB4m6Lasx6JhCJJMKjz9V4djbJsAU6QxDaXe1?=
 =?us-ascii?Q?nHS2zvtsCkq7cdy/jAIZw1/H+Erd/YH3cghXYajVgFqGVr7ivddOejOyjSCY?=
 =?us-ascii?Q?bdW1mbdhfngABGHvz65mfxjWVU163j3XTQ8ByGbCL39zpqOL6a88uunZr0sy?=
 =?us-ascii?Q?OlD77Y/axecWYABpYTBLrWaUztyCjLHMUILZLgR+K8SKKmQvRYghUE4l5gKe?=
 =?us-ascii?Q?M07bQUqpMfE2BoLVbRcs0gOhbtKqgg+rU7v0G71BVuSiKEqqCwgYrQcaArtW?=
 =?us-ascii?Q?cuwD97bdSR+nCzZ8ZVpBTKiXq1yGixf/JCkfIOpANS0mLwRUvXS0bzA2Ymru?=
 =?us-ascii?Q?/pR6H8rOup10hnwgiC20JbaFw/hjcfypPqbO5KRjpBcMnyS9+kYvL9sGroPU?=
 =?us-ascii?Q?YeVCj5Jm4AcKh45nEZ1SCTTjE094d3vIEXXZECaZbDJJukfy1oFPa480iuJ9?=
 =?us-ascii?Q?984hhJhHLN6Q0ZYYAAESF/Vrw+QTSHUjbXkGzvuyaHhfOdy1K+9lVCCoPBky?=
 =?us-ascii?Q?AOl6d7wL7y1ywOudLtO3q4Y7KD2fpwbYMiyDISz7t1dQz+Bk2dpJzuzLqyDH?=
 =?us-ascii?Q?Hm9Tk/nz9QCXYp3+SK+oHe7ML/oUlah/xvqMhpPBEqeHIoygdCtkq4r3Jo/y?=
 =?us-ascii?Q?+9IKKyaGN73TTIr+bLMFcRkQCW+/5jYqb8zVd9qJL59zp4HOcVM2wiRdE1Co?=
 =?us-ascii?Q?YG2BC5MpPV0wpWWMW9cOHMa0pfuiLenBe89qbyvE+orNYp3I7bbXduRlwDXD?=
 =?us-ascii?Q?gUwXR0BnptlllgWq3PLYERL0IkWT0H1ACOUNZDGaFMqnir8qagpQkAixuZFA?=
 =?us-ascii?Q?Z/f1+pRfP2+dY8BUcDf7HXap0GvzbTAw+4ZqbbPmKub+gpKGh4I4qlRIrab5?=
 =?us-ascii?Q?CHbPAjwQO3X6ZaI0zT0+stOzXfBVOpKn+QyKtKHSU3QBLhW8FhTcR0d5/wQM?=
 =?us-ascii?Q?pB3yk2+b/nsDQjeFVxglK4JClTUhiR2n6AEFk+6Q9KtDFkeX/+vZSItsLB2U?=
 =?us-ascii?Q?saI8LV5cTESugdC5evABLCOX7s4RCB9fFvI0F3Gmx4wpGL1vjSVZe5Y2QTIC?=
 =?us-ascii?Q?w6GDUYR728t5L5eZ/5pDOo2lp8UqaxtUlUvuMAyXyTrEF8yPccJPApHM805P?=
 =?us-ascii?Q?U6ELq0GFVVYSpEstvavdAKWS74hWBAawYfu7W0PMdG4waEeDJbG4zJz43eDV?=
 =?us-ascii?Q?61q93kL4g0hbaKcXxRDdeGhARIRqDkby7xZXsqSwGzyjMqGrhpBgCELWAcIJ?=
 =?us-ascii?Q?BLfVcDCHvH++6FUG8fzIjKmcHUCAx8vVLh+IHToGk1Kv0a6YMxD7DWH7rINW?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a59442e-cc80-4c5c-09b3-08dd107fe1ef
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 14:12:39.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD6MM7gNKzKCJ2CzGFQGLjgPZX0Itg6CLNzGzOsNWOOifaN0/QNRPueqwpo40Bkeb1agSvTrNmijaDkt0wR5XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8615
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Nov 2024 14:12:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17302

On 27.11.24 22:47, d.kauschke154@googlemail.com wrote:
> Hi Jan, hi Quirin,
> =C2=A0
> thank you for your detailed informations about the current state for the
> Raspi4.
> It sounds like a good starting point to build upon.
> =C2=A0
> On Wed, Nov 27, 2024 at 07:48 AM, Quirin Gylstorff wrote:
>=20
>     Hi David,
>=20
>     On 11/27/24 06:28, Jan Kiszka wrote:
>=20
>         Hi David,
>=20
>         On 25.11.24 16:00, d.kauschke154@googlemail.com wrote:
>=20
>             Hello everyone,
>=20
>             I am interested in understanding the current state of
>             hardware support
>             for the Raspberry Pi 4 within the cip project.
>             My goal is to use the Raspberry Pi 4 with secure boot and
>             secure update
>             mechanisms based on the cip project.
>=20
>             1)) What progress has been made so far in supporting the
>             Raspberry Pi 4
>             hardware in the cip project?
>             2)) How can any remaining gaps or challenges be addressed to
>             achieve
>             full support?
>=20
>         IIRC, Quirin once had a prototype for that, just not public. He m=
ay
>         answer best what was need or what would still be missing.
>=20
>     For our internal rpi4 prototype we used the following boot chain:
>=20
>     raspi firmware -> U-Boot -> efibootguard -> CIP kernel -> A/B
>=20
>     I added the following adaptations:
>     - Raspi-config for booting U-boot
>     - U-boot config for Raspi4 with EFI support
>     - Additional bcm2711_defconfig for CIP kernel(6.1.y-cip)
>     - wks for RPI4 and A/B rootfs
>=20
>     The rest of the cip stack should then work out of the box.
>=20
>     Quirin
>=20
> =C2=A0
> Would it be possible to share the Raspi4 prototype publicly? I think
> having access to it would not only help me but also encourage others in
> the community to contribute
> and improve on the work you've started.
> =C2=A0
>=20
>             3)) What steps or contributions would be most valuable in
>             advancing this
>             effort?
>=20
>         Baseline would be a booting image with a compatible CIP kernel. F=
rom
>         there, we would need to see what is missing for SWUpdate and
>         Secure Boot
>         (both via UEFI). Probably just the integration of a chain-loaded
>         recent
>         U-Boot as UEFI provider.
>=20
>         But note that no CIP member has so far expressed demand for
>         officially
>         supporting that hardware and its SoC. So you may have to bring an
>         RPi-specific recipe rule to add potentially disabled (and not
>         officially
>         supported) kernel features via a config snippet.
>=20
>         Jan
>=20
> Therefore CIP support for the Raspi4 platform is not planned in the
> medium term (next 1-2 years) , correct?
> So a possible starting approach could be to create a public meta-cip-
> raspberrypi4 on Github like the project https://github.com/siemens/meta-
> iot2050 <https://github.com/siemens/meta-iot2050> ?

I personally don't see a blocker for providing the required changes also
via isar-cip-core. It's just that we would not commit on that target to
be officially tested and, thus, long-term supported.

We can discuss this in the next Technical Steering Committee meeting to
see what other members think.

Jan

--=20
Siemens AG, Technology
Linux Expert Center

