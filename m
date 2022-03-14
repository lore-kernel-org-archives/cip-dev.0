Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C087EC433EF
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 21:30:56 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.120])
 by mx.groups.io with SMTP id smtpd.web08.2549.1647293454329005100
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Mar 2022 14:30:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=FkvmUMWj;
 spf=pass (domain: renesas.com, ip: 40.107.113.120,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ncs1yz2BRQ1jkibDbXOPUmP53vt/ms0++F7lpHaHHHD+/EUFG+hvSC079RTYzn256yxpC2WfmVwKCabCloU+7DErJgFQkQ0mJmBx6/86mO05vZQXor2LJjf/CVV+EQEwpniI+cq8Bzg5/Y7gnzBI0H5F9695xQXmfX80muHeynBDgjvAOrrSn4997R3OoSwe8b556XHuUqAu01q4KpxV+ho1r3+ePVdoedfssCE0n2FycRwIgc0+U3f+VqJJB1YqbRfktL6S4/2w4051RHHcFyR6iyGmaW1sq205UuZ7xep/FRftfUSaF0ED3nBJfknFZD9XWq+uOVJ77IiwJALaHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B+AKSi6iJ8VZH/BiRMOt2kQ8weP/+4gBobv2FRgL4I=;
 b=TtEZEkq8gN+oj0bxMQtZucHloHbDUQ7e3Ln5xdNg/fLKAhh102mbFbqdox/fniEaDJodn3NCim825P6Twg1Uq1yRsJQX+UImCfR7aSbnmhNcP1AEVWlJsnLki78JVW3b+UBwXgcXb2mtQoYk8CjZs/YPkuNFhZIOFxpAivE6daVh3fQlTnykuQdvjbiButf2T9Jc8YugDxf9/KA9GpYXetM7ll6vto8+rOUsKgNgf3U7OC3rIafCFkfmAwXnhgpbxN/ojoI4XozzfYPQBna3YbxkQqIy4GKoD+lYKgxDAyJN/dOzUzfJY0Unuv6YIbIJJZGy9O/dEm48pjdwXVds/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B+AKSi6iJ8VZH/BiRMOt2kQ8weP/+4gBobv2FRgL4I=;
 b=FkvmUMWjUTtMaJjGkzs+62XfdzensWpVdqq5Uab/XNrxNcyY9PwY62IL7ImvNh1gsM5ZKDkVwvVUIbbYe8pgixkzDdoOfPdNIhV1hRc92sgtttDDylszUpvmOum8K0Mq5u2ypmB6jftsenJOdcFAa1OPmtP5lPCAsrOWEYgwr3A=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by OSAPR01MB7493.jpnprd01.prod.outlook.com (2603:1096:604:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 21:30:50 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::f4c0:b88d:ffb5:bbff]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::f4c0:b88d:ffb5:bbff%8]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 21:30:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: Boot error on altera board
Thread-Topic: Boot error on altera board
Thread-Index: AQHYN8rmGpFYo8bYBUu345QyBB8JWKy/ZYOQ
Date: Mon, 14 Mar 2022 21:30:50 +0000
Message-ID: 
 <OSZPR01MB68774B63F705CD38DD349325B70F9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20220314174233.GA990@duo.ucw.cz>
In-Reply-To: <20220314174233.GA990@duo.ucw.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99946dc7-8d12-41b3-4ef8-08da0601e953
x-ms-traffictypediagnostic: OSAPR01MB7493:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB74936AA42773EDF7C5AD3EF1B70F9@OSAPR01MB7493.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 O1H9iZ6mdUGd2OXVPISu3+t64ohv3/lFObasAtDDtKFcSTV3wr7nej3YnNb/Ywq7G8EXOgwiEAegl14jS+rBI5OsQxMLroVPw6aSbOQl8IJ2UjoWqqEvRWq0j3QSKmJIDV55a6ES8JSPxAPWZDOW7bH82q9J61m5yn7juLazJfm8X7K3ME4MXhwMBt9SxAGCtDJW7ZTp03RnPddS+kQPrpX9ijYBcmsr2fOVJxAItMdKagnXQgVaCX5ETwFK4H93JQ/xLnP4q9HrsNcnXMb8x8OhJnAoOVOQEYLXX0ACPEVlnlsh/VG3quVqlpBVMXq5018EHVK8l8QegE3G+7sav5Eub0TaEDNq8acd57cEDw9BYuauXQC09LrqeGcIxoVhKHSc8r+NT1e4kzjOthTnskxTA13BosxEKIJIRufrmpCFwkXFfLEkoIxqlSP4Pdp2YHdoLvvKN4VJhIbvYTLroY/ZZAlOQmZTF9/1uU2Y0AM03v4vNaQ1HNS2vNPivJjflUQm79HzV1pWAan6v3YGQmBhfF4fWYrB3HjaLdinW2akYZjVh51M5gBU9dqRRGj0D21L4o6FoaH39md3a3xJwA1CpasEAENeIXZnyRoBbqINSl8FcF74iB5Hnd4YxYlIMVc5dys9thEPgEj0Kpt65Sm6diJNdbqCSqussb1XiOmwdUzX85ZtF2slRkgv8kyWpECp1Uxj+Nknxx/ioNj4sv4DEhARiiEx6KYiNn0XFUp+5L0Lw1rOs2Cth6huT+JWE0Jm2Vjd0gxdMmyZN0He72DR1LkRoZS/qZgGqgCEbyx/luPReW/oZK6PB4a7ahKgF8gBjoi3DFHMW76fd6RFRw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(9686003)(8676002)(2906002)(76116006)(110136005)(66946007)(66556008)(66476007)(66446008)(64756008)(55016003)(71200400001)(6506007)(33656002)(966005)(7696005)(5660300002)(8936002)(52536014)(508600001)(26005)(38070700005)(186003)(83380400001)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?cwg++b9w3VcYQswyno4DBLZKC28Qs78NLl/syp0so9QyGuNUoRQCMrwK?=
 =?Windows-1252?Q?RGy5ous7LWtJgJfVKpGcNxO3v8DzJtUqb1Lsifs8E6XZe3ddA42psBcL?=
 =?Windows-1252?Q?Deoygg6YZtmunMSwk5cm+cODkIl41Aq9eBDV/z8E7P2lzdikumSoGbtg?=
 =?Windows-1252?Q?sAxnwXEGhUF/fIDekwEkSGTW1i2rSseERw/B/5E5I9xkLLmu3EA31Zrt?=
 =?Windows-1252?Q?2bFiBhUxGKNC5grdfXqmH3hQY4wRN5viNkeYcycXMsu23RghgHLiOhzH?=
 =?Windows-1252?Q?nPjpNkmnJQGxYzlQFyHyJyebkS/JpLYxAjL7XyHq4so5DDZeugnvj2g4?=
 =?Windows-1252?Q?H3yt8vN/c0eE82WG1Eqyb78PIBiVcpGjSNjPNb6pDOpzNuUC6HJZq7aF?=
 =?Windows-1252?Q?am208qzCAltbL+Sd3xJHziMAQitPIOm2RjvWdZoxwOqU1Tm8drwSPEbv?=
 =?Windows-1252?Q?cBqBYJiI7lRfCYCT6/hdpbxYUjf0uxXI4HEsJvVjbVl35VVKU2GM8dp6?=
 =?Windows-1252?Q?1uSnp0M9z5nHQpDGgUjS010LTnAvG5FEhttLfb+ncqeBYm8Ei95/mAB1?=
 =?Windows-1252?Q?/QeiXyi5kCmk5ioBhQPEvBUIk5XbJRj9vdPFvRclx3+XqeamOl0IhXff?=
 =?Windows-1252?Q?QmegzekRJZLDgqJAu5I3KMaztmGVAiNbra8qUkBhq5i+RYpIs8XYufu/?=
 =?Windows-1252?Q?sUvdulc00QCB1AIXRMEkv3QV3U8Z4CvsI3Slh9iEbDmQTe1j43yrEWw5?=
 =?Windows-1252?Q?T5WYyK4nWZaFApzyeu2+ddwgU+qbBM6/NFMl9qD+sQs037xU1TY3Apds?=
 =?Windows-1252?Q?vAvwzjbpwaIh1qRXlH3vMtW8GP0bzJsvMhD9fmD7IHIlyFTgHD4y0KNj?=
 =?Windows-1252?Q?+TcNTfWsdH3GiZR27FrIyzb7FG2PUGL33DGPcLnjQPAy551FbfquZSUt?=
 =?Windows-1252?Q?ZsVLK9VCm2e0TMs1asY+JBhwpSIxpTQPoG494OnARysvdRW0KpeTxdX8?=
 =?Windows-1252?Q?m5RFdHgLojF0/64seh4r1nG07xELBdAf76Tb0tFp56tKLzjyjO5rZ8Xs?=
 =?Windows-1252?Q?UmOFeQvjWDE9FxDmubXYUpo63/jr+7LE3g660j8H8BLv23o0oskrgK/a?=
 =?Windows-1252?Q?nOe1qJA/fOBEaIztc7ncQCajLY+9e0ksGuXVLc315cnd4GSoktN0Rx17?=
 =?Windows-1252?Q?N2ShJl18x6EKBseRVtbn/BShG7dvY5HKpLmo2ocHK+vdaxXrfO28N5/y?=
 =?Windows-1252?Q?MuLaGf9OtJVEy3OiCd4+YILfOZ+16q77wsNQjRMwI6lCc7I6W7cXsRkJ?=
 =?Windows-1252?Q?byMjSobcnyPTvV+Qsjeo33VJKMiKsrHvXItFOfe7DQGxDvgsH8MjWN3u?=
 =?Windows-1252?Q?ILdlA5Vma7S644zOQ7RcloCqS46xjk+GU9awZWg15NWVzllOXgFOt7xF?=
 =?Windows-1252?Q?tB1m6vvJcme0Jo6qOr41KElbr5+6Z49zEhRBHsrqKicaMv7UqwKK204s?=
 =?Windows-1252?Q?VMc52bSA3M5VmXcUZeNO96K0YBK+uiTUZ0zhhKxqCWxBd53ATcMhQOMy?=
 =?Windows-1252?Q?HbkdTwn9kxOiuZlxrZBiIwprqR6kIxplq9Fweg=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 99946dc7-8d12-41b3-4ef8-08da0601e953
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 21:30:50.5162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 6vGg6YkzZwW7lwLI3ew20Q0KVT1702XhrT8Qu16moLaiTfEBD9gdl2/oFzfe9XBlzSmsSXuIdgWKahy6BljV5GFem5kxV2UO/XJTPO6PhHw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB7493
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 21:30:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7724

Hello Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: 14 March 2022 17:43
>=20
> Hi!
>=20
> I got dhcp error on Altera board:
>=20
> dhcp
> =3D> dhcp
> bootloader-commands: Wait for prompt ['=3D>', 'Resetting CPU', 'Must RESE=
T
> board to recover', 'TIMEOUT', 'Retry count exceeded', 'Retry time exceede=
d;
> starting again', 'ERROR: The remote end did not respond in time.', 'File =
not
> found', 'Bad Linux ARM64 Image magic!', 'Wrong Ramdisk Image Format',
> 'Ramdisk image is corrupt or invalid', 'ERROR: Failed to allocate', 'TFTP=
 error:
> trying to overwrite reserved memory'] (timeout 00:05:02)
> dhcp
> ethernet@ff702000 Waiting for PHY auto negotiation to complete.........
> TIMEOUT !
> Could not initialize PHY ethernet@ff702000
> matched a bootloader error message: 'TIMEOUT' (3)
> end: 2.4.3 bootloader-commands (duration 00:00:12) [common]
> ...
> InfrastructureError: The Infrastructure is not working
> correctly. Please report this error to LAVA admins
>=20
> https://lava.ciplatform.org/scheduler/job/647916
>=20
> This was second attempt to run the test, let me try to re-run it.

Perhaps it was a random networking error at the lab in question.
Looking at https://lava.ciplatform.org/scheduler/device_type/de0-nano-soc m=
ost tests seem to be going through now.

Kind regards, Chris=20

>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

