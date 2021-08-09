Return-Path: <SRS0=wOTC=NA=lists.cip-project.org=bounce+64572+6662+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA716C4338F
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 06:57:32 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA64A60EE4
	for <cip-dev@archiver.kernel.org>; Mon,  9 Aug 2021 06:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DA64A60EE4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id AYxUYY4521723xyA7Y9d38Tg; Sun, 08 Aug 2021 23:57:31 -0700
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.119])
 by mx.groups.io with SMTP id smtpd.web08.19501.1628492248848113674
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Aug 2021 23:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=euPX5IdorNm7WRYumBLoBymQNmyUeDGyTeK41wx8HTaaM+8QfZJVzaNcXuzziF4s1ZMlJ4gq+zgszrMdMnWCukc879NYZnTKV1m4rZtezUCZ0W23o7OCEvEjg4jQ1FwZ8h/ZjgyUOc9AXSYuY5VU2AHHUzP42AThclLp9F4uf4iQX37Fbs5eDG/xQqoiSykOZC6+3Fo3+jfke+sZU9AgUqsSW18ouCQE6bGrvJHSLstAuIjHKiIdpHk7v6vC1DkjvBdHSGuT63IEfkIx357/3LEG6TF1lsvC6LOvtKKnbwQduoDsCqjkoVT/FIaQY8It5cGdVfwaov9BjXFUmXn2MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3y0Z0UbY7UfM8NKlHT2vnbVuoBfTzjN7Fc7GgzglA8Y=;
 b=cIksqA9/zPusiKhQzY9Xff7KGkOrvaikCQKIYD+oAYm0WXhB6cxW7c5JLs2Pog0qaJ9QwQbEk2PJlehHys2ca0/pRw9stRsh5U6qZvfjUBADe1XqOv55CNaYyE9tBw7gmPlTL68XHFOtOHSwQ1AJSLayfRo6P6Xy+FYajrJkN+xzd7VNA1zNogzStat9p4CogmLtBK71GeG3XqFwgXKBLMcmdDUYM1dgtvBawMC4IikZuwqHJM7hld5c0v7T0Lw3kfOhoEYLykeai5g3PY4iOF3KkXfoZm18/xGMK8zDpHNRnRS35TlS1kQ1xpRAY5oz5ZEgZksuOM7PIBvdd1SLWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB4516.jpnprd01.prod.outlook.com (2603:1096:604:36::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Mon, 9 Aug
 2021 06:57:24 +0000
X-Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::7841:8a53:7327:d552%3]) with mapi id 15.20.4394.021; Mon, 9 Aug 2021
 06:57:24 +0000
From: "Chris Paterson" <chris.paterson2@renesas.com>
To: "cip-members@lists.cip-project.org" <cip-members@lists.cip-project.org>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Subject: Re: [cip-dev] [cip-members] FW: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021
Thread-Topic: [cip-members] FW: [kernelci-members] KernelCI Hackfest #2 - Sept
 6-10 2021
Thread-Index: AQHXh3zW9rSeX/k4oEq4EIVv1f2AsatgsaGggAblbICAAzEe0A==
Date: Mon, 9 Aug 2021 06:57:24 +0000
Message-ID: 
 <OSZPR01MB6877795A38875E522117B49DB7F69@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <74f7b4cf-926f-d8bd-19c2-375cfe7a12b2@collabora.com>
 <OSZPR01MB6877A873F8EEFA24CC8D7331B7EF9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <CACe6DC5p_Fwdar-cvGWi2xUaEC2wBK6JD575Rj8h8zPQ=tLGqA@mail.gmail.com>
In-Reply-To: 
 <CACe6DC5p_Fwdar-cvGWi2xUaEC2wBK6JD575Rj8h8zPQ=tLGqA@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d405fcff-b950-4797-1b1a-08d95b02f152
x-ms-traffictypediagnostic: OSAPR01MB4516:
x-microsoft-antispam-prvs: 
 <OSAPR01MB4516FFA1D193691DA9AC1FD2B7F69@OSAPR01MB4516.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: 
 zdxcyM0gdK2YIdX9i8EogejaAfzG97oz62C6+fhxUV1/ol7hk1YKgS3CTaEbZsAZ8USTutr2Tn1fULt78+79lm9mz8ha5gcB0aVYNCbGOCnxuyWliMTJjIDUMvjNASLAUCGQZ0N3MWbBPUxxFtxSMpNkhNPxqRXft5muULuOxtfROAlLbCUBX50G2AYAOkGRavfBLauKEK5rfdtTuyn0XTi0EOwK+3rw18EVuICf4fnpJqDLFRpd/bvylKEGFiRcIfKm8BZXYqgY4rS16kiPIxwSNabaAYDjngHWRfLZ4SstvnZR2Jio+LAul6JJId7oaw1g3StOhSTg0iLX4v5LDDTM7p5ff6s3Majp+CTDl76Z607D/2hZ5nlbgY8aX/3zdfhgdMTZfrjq5f6RDxJJmK5AEZQr3rQ67iH2nwvCaJC+Hwu/BsPl692AzCiGOOgC8xM0ozbF9BzmJ/kTvYV8THIsgN3YYPEru+DcPFGIpdb1JI3lFJ3zo8oZtM7erbYM7HOBv4FmSB39tyqjsktFANnu2rgzaS6KbL36CHibyCTStwBQBOlpkegJLlAYewqxhGh6pD8ah7J4GEpJSN/D3JAyPmwl0Opk4jL0oM9s1gASIqeUN9QGG8VxohLagY3jqWhOHHjIYqXdmqKZWLGAvQbLJ9+macZmiV2gBRNtajF6KdQ4CGAX2lYObskkSCyfIS5FHAByI+J7wdOqGNnKYv2GzaG0o3JKlWCiNsgutCnfYz1CzbZ4/pBAPJCeO64pMxZCX16SDmNdx3Dxh20+npzLuX3K+HlajAp5GYE/Cg8E0VROihrQKrFQtvq2YUnkMFNbkmOXj0eZVoVI5ol3nw==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?T3hFUmFNaE1VNTRHSEdEdnZ3M0VtbmJFaitDSlk1NkxlcDFUNkljYWdO?=
 =?iso-2022-jp?B?cHYzRzNXM0Z6dVhHR2VYelZlaGFabFhpWEhzSThDczhmTzRITnlHRlNq?=
 =?iso-2022-jp?B?ak92V1p0YzRyVWY3WitwU1ptRlp6YjV5T3lrNFordFRldVdUanpYV29X?=
 =?iso-2022-jp?B?UGdwaXJ3Rk5yT01EOUNWK3g3aGk3S2EzUzUrZld3MkFhR2FLd1hBaTZl?=
 =?iso-2022-jp?B?eUxnM0s2WkcxU3MrRzFBQjdKOXQ2U1duaU84Q2kwWmtyQUxOS0dEenlz?=
 =?iso-2022-jp?B?WWt4b1pxd01kTHg3NGlPYWorTy9PZHNmQi9HeEh1Y1l4WmtTM0crRit1?=
 =?iso-2022-jp?B?Y0JiekVibmtTSjgwNlRTS1FHbzRaOW1MODdjUTlFN0c1MzBHcW9Lb1VU?=
 =?iso-2022-jp?B?VFhGQTEvU05Hd3Jaa3NlYXZ0TllrMEl6OVZ1VkVmL2JVNUQ3ZUdLam9z?=
 =?iso-2022-jp?B?dG1RN09tU2dtTjRSWEp0TE16cmVFYk1xVm9JeVJhMDNLU2pQeTNlcmwz?=
 =?iso-2022-jp?B?am56bXhKSkJ0UFNobFpBaTVPTktObjJWMUNhVkMwc0dISkJ1YXg5VUt6?=
 =?iso-2022-jp?B?SDFmWWt1MGFBVmFKc29Ob3VMakNKVFZjLzBUenNxNS9xdy9kM3hjOW94?=
 =?iso-2022-jp?B?cXlReGVZcXk2a2QzRk1LWS9EUlFrL2xLaUhLcVFQWTRGN0lpeHpmWGhG?=
 =?iso-2022-jp?B?MlB5UGRrV2QrNVhYN1NqVE43UEJsSW1EK2tMMVNhYkNMenVQYWw5Nzky?=
 =?iso-2022-jp?B?bzdPRTM0eG80NVMvTGhLQ0V6RHZDdU1CZFc5RWYrQ2FaVGxPc0xvdUlu?=
 =?iso-2022-jp?B?RFhacnNlamEzTGY1cy9UUi80aEJqN2V0eE5oVENEMDljV3RXUHFxNThZ?=
 =?iso-2022-jp?B?dHRGVnZua1ZQcmcrMHZ4Mm16NVdKSWFieFlMSUdCV1pheUhvc1pkVHg3?=
 =?iso-2022-jp?B?QStDd2xWd1lSOW4yUXM0UUR2c0U5c041OUw5REc4dXhMV1Mvcm5YV2t0?=
 =?iso-2022-jp?B?RmpWU2dWbFNmcmEyaHM3R0tDR2pBbzdZdHdzM0pnMURUT2Fybm9EUlU4?=
 =?iso-2022-jp?B?d20rMDhsckpFeitJclJWRlE5TU1DNSs2RHJoNVN6R0xlUjdUcUpzaGly?=
 =?iso-2022-jp?B?UkMvR3lvUHVFd0ROMytyc3FsS0kzSmJKeUJJQVBFZjZnbkdIcldqM3dq?=
 =?iso-2022-jp?B?eitWN0FvTUprRmdSUUhzQXE0dThxNXNkU0JMZTl2OTlUYVdEM1pqcDlo?=
 =?iso-2022-jp?B?ZmNOa3BZWTlJWng2Qm11ZXlOdFEyZkZQL1dwMGVhMjY2T3dHYitSaEhs?=
 =?iso-2022-jp?B?cTdVd2k4R05TOTByellNTWlrNTdPTU4rMDVuQXBrSkN6SGUwWDJSREdF?=
 =?iso-2022-jp?B?eGlOTWsveUkvVnluUXE4aktLMXQ5cGd2S3ppK3J0YzZEL2NNeTFONVNh?=
 =?iso-2022-jp?B?aVYvYmlXUElNU2grUzN6dEtrbG9yaTMxNEdUSVFJeHpVNXl5aWU0NDkw?=
 =?iso-2022-jp?B?blhMcUFoT3NWcEo4aWo0QTFCTGZQZ2pIYWFnTjc1VVQrVHBaandkZzl3?=
 =?iso-2022-jp?B?K2owY0pMcXNZR2FJVHI2RHB3T1JFNUpzbUtSSDRTdHRkM0FJUWVPbnVD?=
 =?iso-2022-jp?B?K2hmUWl0UGN3dGRxck11dVk4WUhQblV6Q2x5SDdiWDQ3SGpobDFJM3lI?=
 =?iso-2022-jp?B?M0wvL21tYlJhQ25mMmxJaW5jRXp2TXdFK0V0K0xPR3hsbXFBQVpyZWQ5?=
 =?iso-2022-jp?B?S28yQXd2QVd1Q0ltbmlUUHpFa2dYdVZsTDRSdTFTc1p4WlU2YVJVcTQx?=
 =?iso-2022-jp?B?eVpIdkREK2Z0QjNrNXIzTS9NQnU0dVNYVytYS1QzK2g3QUx3eGZCeDM4?=
 =?iso-2022-jp?B?ZkZSSDZ0SC95TVprRWtzcXVOR1Z4RzJGbW05U2w0UnRhSHNDalhZTVJa?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d405fcff-b950-4797-1b1a-08d95b02f152
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2021 06:57:24.4775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmOA/d5v7c29qsy4ujDgaQ6p9J5jXiZSzbJgoCU2+BtODqxQhOLT2Fitx4KgefHbr9ZmDFxN8rR5izvTLHig1jcNIEzl557VxFS3dkf4ujE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4516
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qmqIVX57XOFqH7PQnlauG1LWx4520388AA=
Content-Type: multipart/mixed; boundary="Xe1d0zGed45QiYMwLcei"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1628492251;
 bh=xkhamcfl+SjpdlB1u31XXfItKzt0quL7dnUNmjcgn/I=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=q4n9bVpm+Kk6Dkl9xgv6dp9Z5nEhX73gQ+ygnxvpgVmT46zhPQ1lGbGOImUw25CeqYJ
 +A/wnPt/i9xx9I3yNSINs5NIrAOS70In/sSWIxh4eV9U8MxzhKMFFLbKiI+XYGJMw2J+d
 AaYkXftn7QbAPPQaulap3eFPqoLfHJZmcto=

--Xe1d0zGed45QiYMwLcei
Content-Language: en-US
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Iwamatsu-san,

> From: cip-members@lists.cip-project.org <cip-members@lists.cip-
> project.org> On Behalf Of Nobuhiro Iwamatsu via lists.cip-project.org
> Sent: 07 August 2021 07:11
>=20
> Hi Chris,
>=20
> I am interested in this.
> Do you still accept this?

Of course! Thank you.
I'll forward your name to Guillaume.

Kind regards, Chris

>=20
> Best regards,
>   Nobuhiro
>=20
> 2021=1B$BG/=1B(B8=1B$B7n=1B(B3=1B$BF|=1B(B(=1B$B2P=1B(B) 5:59 Chris Pater=
son <chris.paterson2@renesas.com>:
> >
> > Hello all,
> >
> > The KernelCI project has announced it's second hackfest in September.
> > The first one was pretty successful in getting some new features added =
to
> KernelCI, and the hope is the same will happen next time as well.
> >
> > One hope from Alice and I is that we can get some CIP members involved
> to try and advance KernelCI + CIP integration/collaboration.
> > If you have any time available during the hackfest and would like to ge=
t
> involved, please let me and/or Guillaume know.
> >
> > Kind regards, Chris
> >
> >
> > -----Original Message-----
> > From: kernelci-members@groups.io <kernelci-members@groups.io> On
> Behalf Of Guillaume Tucker via groups.io
> > Sent: 02 August 2021 10:00
> > To: kernelci@groups.io
> > Cc: kernelci-members <kernelci-members@groups.io>; automated-
> testing@lists.yoctoproject.org; Collabora Kernel ML
> <kernel@collabora.com>; linux-kernel@vger.kernel.org; Jesse Barnes
> <jsbarnes@google.com>; Summer Wang <wangsummer@google.com>;
> linux-kselftest@vger.kernel.org; workflows@vger.kernel.org; kunit-
> dev@googlegroups.com; clang-built-linux <clang-built-
> linux@googlegroups.com>
> > Subject: [kernelci-members] KernelCI Hackfest #2 - Sept 6-10 2021
> >
> > The first KernelCI hackfest[1] early June was successful in getting
> > a number of kernel developers to work alongside the core KernelCI
> > team.  Test coverage was increased in particular with kselftest,
> > LTP, KUnit and a new test suite for libcamera.  We're now improving
> > documentation and tooling to make it easier for anyone to get
> > started.  Find out more about KernelCI on
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fkerne
> lci.org%2F&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C832b
> 1ef74f4e4951645208d9596a33b2%7C53d82571da1947e49cb4625a166a4a2a%7
> C0%7C0%7C637639134934176687%7CUnknown%7CTWFpbGZsb3d8eyJWIjoi
> MC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C100
> 0&amp;sdata=3DqAQvSZ4jek6NLkInJD3HBWtj%2BAfopqMKOwX0IkN4hlM%3D
> &amp;reserved=3D0.
> >
> > The second hackfest is scheduled for the 6th-10th September.  It
> > should be a good opportunity to start discussing and working on
> > upstream kernel testing topics ahead of the Linux Plumbers
> > Conference[2].
> >
> > Here's the project board where anyone can already add some ideas:
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Forgs%2Fkernelci%2Fprojects%2F5&amp;data=3D04%7C01%7Cchris.p
> aterson2%40renesas.com%7C832b1ef74f4e4951645208d9596a33b2%7C53d82
> 571da1947e49cb4625a166a4a2a%7C0%7C0%7C637639134934176687%7CUnkn
> own%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik
> 1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DorLWUKzJUOtPN9nf98KUN
> UPPEaz5OAW%2BRz%2FD2Vb9Big%3D&amp;reserved=3D0
> >
> > There is no registration system, but please reply to this email or
> > send a message on IRC (#kernelci libera.chat) or kernelci.slack.com
> > if you would like to take part so you'll get email updates and
> > invitations to the meetings and open hours sessions online.  You
> > may just drop in and out at any point during the hackfest as you
> > see fit.
> >
> > The hackfest features:
> >
> > * Daily open hours online using Big Blue Button to discuss things
> >   and get support from the KernelCI team
> >
> > * KernelCI team members available across most time zones to provide
> >   quick feedback
> >
> > * A curated list of topics and a project board to help set
> >   objectives and coordinate efforts between all contributors
> >
> >
> > As always, KernelCI is at the service of the kernel community so
> > please share any feedback you may have to help shape this upcoming
> > hackfest in the best possible way.
> >
> > Thanks,
> > Guillaume
> >
> >
> > [1]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Ffoun
> dation.kernelci.org%2Fblog%2F2021%2F06%2F24%2Fthe-first-ever-kernelci-
> hackfest%2F&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C83
> 2b1ef74f4e4951645208d9596a33b2%7C53d82571da1947e49cb4625a166a4a2a
> %7C0%7C0%7C637639134934176687%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=3D5qpPNgUnH0ykUFzsJ0Apv2Ho3T7%2FdEewxf6elAfDAKA%3
> D&amp;reserved=3D0
> > [2]
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww
> .linuxplumbersconf.org%2Fevent%2F11%2Fpage%2F104-accepted-
> microconferences%23cont-
> test&amp;data=3D04%7C01%7Cchris.paterson2%40renesas.com%7C832b1ef74
> f4e4951645208d9596a33b2%7C53d82571da1947e49cb4625a166a4a2a%7C0%7
> C0%7C637639134934176687%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=3Duugp%2BNxYO6iwP6VGA4vrl0Wwm0QOjgF7h0qYJI7G6LU%3D&amp
> ;reserved=3D0
> >
> >
> >
> >
> >
> >
>=20
>=20
> --
> Nobuhiro Iwamatsu
>=20
>=20
>=20
>=20


--Xe1d0zGed45QiYMwLcei
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6662): https://lists.cip-project.org/g/cip-dev/message/=
6662
Mute This Topic: https://lists.cip-project.org/mt/84738331/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--Xe1d0zGed45QiYMwLcei--
