Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA509C433F5
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 14:47:34 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com
 (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.106])
 by mx.groups.io with SMTP id smtpd.web10.10238.1646923651858754290
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Mar 2022 06:47:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=QTlgqTef;
 spf=pass (domain: renesas.com, ip: 40.107.114.106,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDQZETZAsZqFEAHKX4+poEDV0CfS4LElu3G5OhLBqRy7FwnVOWgK4J66PkpEZBnHLkK5FR4bLsqN3+wOrPh6RcdKhMZqfJ5ANmMXhsZEHHDJiufLU9JhQ/Uvbn4NNpBxxu9uKVisMW6aTtm8LWh08fKDQU8LPODfufGs39P5vw6lSOK6ELGeKXqaQBUfZsttENo/30ez9ysI6vKyAg/BpA2iCLEOyxgmd0ElqoeCaxIaEUDauJ0ZfmEQfAQs+iNiCWV81SM4l/icoXHj5p4gBRP0egLrnvH0yfIb89fEgV0yAUA5uNXW1+wqhWCF1y7rGGB2CV44zbS3obCEq+qTuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4JM9SQY7SCqiY4vk58O2dkKMGlcj8kzxESGH5RM+j8=;
 b=XK2bbiFIJ23Fh4Ibo6m2h7Xpte5Y3bVxuI/6Ef9bdnvycYtY3d401wmpx90UN1oW74VmRWpub0X3AT1iY21NgqLV2lIAwPTPidUes83CZejuuCYNz1cEnhGA9CQwEas6xe+cCcucRNZmBfgZwQ6rVY0VJsCjavxK0bnfRAN0tbN11HUxguqORhgDBzH5NS6XeNvEFELyNmuMklT+P5wCCvAQqeMsCQVijy/+Slr2SWFa6+//7iYfDbZI7G2vmJrh/HSKZEG3+3f2PUSqPmb86aCXjUZ8otAEPvB3BSSMiYHovLjlxay17FcLIUEp/7hqPbiZaUwefupFX/aCLv85kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4JM9SQY7SCqiY4vk58O2dkKMGlcj8kzxESGH5RM+j8=;
 b=QTlgqTefyNZCcH/0+lf/slz2QlUK0vh0ItH4pTAb9dV7J9n4wROjECgvOyvRyOmHl7B0L3QNVREukII5LrBVh2FwjlcHgIVPOejg6MDMWFWKlgDy8icRiQ4lq4KTNiAv8RJ/EhrMh/7kVkRDJvs+RhXVahbKQUjWq8mBWCdOegw=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:130::9)
 by TYXPR01MB1536.jpnprd01.prod.outlook.com (2603:1096:403:d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 10 Mar
 2022 14:47:28 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::684c:45d9:bd7c:c002%9]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 14:47:28 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Adding v4.9.y-rc testing support
Thread-Topic: Adding v4.9.y-rc testing support
Thread-Index: Adgy+xq6CQjO4FHnRhabwhOca814qgBgOr4wAARezaA=
Date: Thu, 10 Mar 2022 14:47:27 +0000
Message-ID: 
 <OSZPR01MB6877C7B91F24B07C6F1FFF99B70B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: 
 <OSZPR01MB68776F5E350C51B188876E3DB7099@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <TYAPR01MB625263A117252890F97F6B0D920B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYAPR01MB625263A117252890F97F6B0D920B9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da6db630-1774-46b7-7764-08da02a4e5d3
x-ms-traffictypediagnostic: TYXPR01MB1536:EE_
x-microsoft-antispam-prvs: 
 <TYXPR01MB153647DD588D9B46B0A3377FB70B9@TYXPR01MB1536.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ypgU+eTD8VBiDX1Y65+Z/cymK+1rpwHi3kXxJCIL6CMO4Xe0taSutck3S655t54LxDo0QFH6qLiFAXeiwsQVVe5KHqoFkSKyeEODlu8yI7XwMinq04ER+P0XpzuRhy6BgVgDYPBKGDhZhNufbXDeQ5Co7KSPsKuVYellJvgtoX6tUsAHMiIMkD36EWHohk6s9vVlSMtAKk541xHl+qNMTKmfRhsryC0pQ9kqBVJ1U5ziWJlQDqJ1jspugLM229ASZuTzJN5ad3qsr+8eMt4JbJIyTmwbZwu9se9yqtC9jrtFh539Cn5U0CBrG5cc8bOtBB7JRlbPyRMCwM+gulWYjP3pc6FrQM8EKjqWzgQAhV405BZiB178a37/5XTwiBaKwKYVH7YpgSXNRUREgTxK17N5RfrdNl+vXdXVFDn/gilYl+j+ZzuKukKxRXLZmqnCSsSW71B5pZgiWEZF7lipLacVnBBWtZkWnaLgGFoK89ZLc4bVWfr8Q728IkmiE7jQsPQ/EI9MQNkf8iRM9rOx6F63OlUmsnjv5y5xm1mNJV2CZk6yepkfopGo88ed9MIe6agDP1dos/qRco1ZyN/G7fd0/dzQE0Lo+pruscUHspyP2MFpWUQsZyfqUsXiX5nu1wtRExG7EMT8mWaETgL1RXh+V3cZFUzTkNcGuBcILAEcm+9Y7byrMToRf9UqLQqudsC5Oitjgxme0UA2SMdRvjtw90ZxZHesqynXh9hbSajQ6G6GXwGclIIL2WOxIVjvsn2t799g1axUXh75q4rDAWPJIM+qR8Fz6nzqXCoY7Pw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(66556008)(66946007)(2906002)(8676002)(64756008)(66446008)(66476007)(4326008)(122000001)(53546011)(45080400002)(71200400001)(52536014)(8936002)(38070700005)(6916009)(55016003)(5660300002)(86362001)(966005)(316002)(508600001)(33656002)(7696005)(6506007)(186003)(26005)(9686003)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YzRzbXBMb2FyeGdzQ3p5Y1JJU3F2QnZvbUdOcGtkNEFIaWZ3RnQvQ3Fr?=
 =?iso-2022-jp?B?UHluRUZZbjBoc2hYSXBvR2xjWk84Q2VtSmt3eDcxZ0RZRmJuLy9nZDJQ?=
 =?iso-2022-jp?B?SkhKbzF6VTNCWVZEK3I1bFJQd0M4S1luK0hnK3RpZVNwM2g4SWJWOEpO?=
 =?iso-2022-jp?B?UFBwYWw0VzFBOVFYamxncmhvMmpmVk1BL3dVdmttalRwWHFRNEhJWUly?=
 =?iso-2022-jp?B?aFFwTVdUOHJta0JraTB3QjU4VTRpWithcmUwWXR2N2paajBJZHV0VUNO?=
 =?iso-2022-jp?B?ZkdOSmFOSGhlTHFqSWQrQ2JCRmx1VU00S0hEZStIY0VWRVNnM09sSGdY?=
 =?iso-2022-jp?B?RGpwVTFvd21wZnljbFYvSG1wSzVMc1M5eEtMbElxd2gwbGhUV1dEK0Vn?=
 =?iso-2022-jp?B?ZmNQSzFlSmdWUHJieE9OVlZnUlU3MFp5cWkzUlhNeGZqdk5jdE0yZVlp?=
 =?iso-2022-jp?B?cUNZMnFVVkt2NDlMTFBqY1VjSk1mZmVORzVKT3l6SjVEYzkyV2FYSHFT?=
 =?iso-2022-jp?B?NEhqUEFjcFZHVVVXYUZzWHJ1V0xrTWg1ZFJvWnMxaFZvZmVEd1R2VGNN?=
 =?iso-2022-jp?B?RUNtdml1NWhHRloyN2ljMXlRSWluSGtrT2NkMDRidlVlbDJnRFJ5Yk9j?=
 =?iso-2022-jp?B?djVaRFhjaCtIeVJRd3F1N2pvdVFJTFdtOFg1T3ZVS0JSYzd6WlRqVnZL?=
 =?iso-2022-jp?B?NUtRaTl0Q3Brc3FLWk9KT0lqSkRsTTlScVRGbUcycGk3VzhPYXdFTTAz?=
 =?iso-2022-jp?B?eVRPLzc5UGdtNUFvSVN5aFQxNUlvMnpvTWxnbFR5d2pCdzdsREFjQmd2?=
 =?iso-2022-jp?B?cnFyUElWTnJYcU9vNDRvK1Y5VXl0QUlIaFpKenVWbGpSZzFKNi9tUGZF?=
 =?iso-2022-jp?B?R1JucXJwTjZTRDloWDNsL2Fta3F2Sjg1Wk1yRWJpU3B5bWxTWEpUMi9u?=
 =?iso-2022-jp?B?Sk9hSFNOMURVeERDZk02Zkh0L0FpUkhNeFcrMlRZQS9UVEFZRXh2Wmtm?=
 =?iso-2022-jp?B?SUJCNXAzeFlpT2E4WFFQeklPNm5xdDRYUlFMUlZyVTBGSWdJbncyUzdn?=
 =?iso-2022-jp?B?ZnBqWFpMeHJKRGh3Qkl0eEsyeFFrbG5WQVBNSDlNbDhHU3lVRXlRVTEx?=
 =?iso-2022-jp?B?eEpXeDF0bHFoREZtYmRScGdBNzVuT21PaDg3YTduM1dUaUxseXZSb1RJ?=
 =?iso-2022-jp?B?N2oxU0tNNUNURDBGZ2V3NDZHNUhHbVdlSElKOWJFN1RTb3VEeGp4U2NO?=
 =?iso-2022-jp?B?Ykl0Y1BLMXZiNjM0emt6aThHL2JmaDNZS3FSWjJ4emhHb1V1SlNzZkxu?=
 =?iso-2022-jp?B?N0pVOW5vamRlWWJRbGJQdTNBSmlKdmdMTmNqMnE2cEQraVVsS2hTeVlm?=
 =?iso-2022-jp?B?cVBiWXdEZEFXSXN5eXZ1Z3YzMTB0dXJPZkRDZTlRTnJWRVljcVBhZWx3?=
 =?iso-2022-jp?B?UFQyZmNNbUVYRW14bEdwWnRacnBEc0xRL3ltN2Y0ZFhxVGZtcDJMTHEx?=
 =?iso-2022-jp?B?dnNuMnUzQkl3ZGJYQUFkeGkzRktwTk9HN0R3SlFnblpDU1JZaWhGNUhp?=
 =?iso-2022-jp?B?dEVRdFZEWHlXRis0VjNmTmF1V25KdjBMZ1R4alZjcTFBZ0V6OWN5Qlk0?=
 =?iso-2022-jp?B?TjdaQkJhSGxGcWhhUXhTYUVXdHgyWjRsM042K1Q3b1p0SDc0TFJMM25H?=
 =?iso-2022-jp?B?SmM0bHoxL0VIbVJKck0yZU5STEs2TVhuZzBGMjJzK0s5dWVZeURmVXAw?=
 =?iso-2022-jp?B?OU1tUG4rekZwOUxYbTh5WEdZek5FVEErTzMvNGtFZ25aWWtnVmZQakpY?=
 =?iso-2022-jp?B?SDhqSWtWUElGZkkzcnZwb3VGb2FTalgyR09OcEFEaGdMRmY0QUZWYkl0?=
 =?iso-2022-jp?B?RXdySno0ZHJ2RWp4YmxNR1U4bjZ2RUdNbEQxK3kxUk1OQkVQcCtiY1hp?=
 =?iso-2022-jp?B?T291cXc3elhUYzF4YTRmZmI0VW0vOTVWeDJXU2pHejYxME1vNTFFTHRE?=
 =?iso-2022-jp?B?VCsweml0Y1JaY296ek1KMk9MV3MzWnZkQlJWYlEzem90THZXUEtoekJi?=
 =?iso-2022-jp?B?MWhHcXc1U2NDc3o4a2ZLRlR2V2tVUnlod2g5L25NMjVmc1JZdDd1MkZh?=
 =?iso-2022-jp?B?YThKemVIS25Ba2NwdFlLMWlLNmp1cU9QWk13eDUrTVBFczhnQXNnYjN3?=
 =?iso-2022-jp?B?cVE0Z0ZBb1lQN1hrWUI2MVQwdkx1NkZKZE1XbG5RRDRES0xkdzA2Zm5v?=
 =?iso-2022-jp?B?RUtYUlRxa1hhNjh0RmRhcm5VMVU5ckpRNjBDdHpsb2d1aGx3Sk5yN1Rv?=
 =?iso-2022-jp?B?QXNFWit5U2JyMElJaSs5SUNSd3pZV1dHa1FkQ0M2S2RTbzMzWmtzSGZZ?=
 =?iso-2022-jp?B?UFp4VHU4UXRlcHRjamJIaVJpemNvMmJMUTAzTXNpbGM2QUwvSHVLZGVY?=
 =?iso-2022-jp?B?cW5PUTRBPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 da6db630-1774-46b7-7764-08da02a4e5d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 14:47:27.9454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 OfLZGZjE02TSMUl/jZX9SMfnMVSncaTVaY5/O6hQTkacc2+mnubs/PKzSgkzYMLaIOfBiVaqK+1cog/FF4nCdjvNEzA4qUgJdMdvnvmYefk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXPR01MB1536
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 14:47:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7689

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: 10 March 2022 12:43
>=20
> Hi Chris,
>=20
> > Was this intentional? Or do we need to reinclude the siemens_am57xx-
> pxm3,
> > siemens_dcu2 and siemens_iot2000 configs in v4.9.y-cip?
>=20
> I apologize for this. The .config was filtered by gitignore and was there=
fore
> excluded from commits.
> I added these and committed.

Thank you.
All are now building as expected.

Kind regards, Chris

>=20
> Thank you for letting me know.
>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: Chris Paterson <Chris.Paterson2@renesas.com>
> > Sent: Tuesday, March 8, 2022 11:54 PM
> > To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C=
#T=1B(B)
> > <nobuhiro1.iwamatsu@toshiba.co.jp>
> > Cc: cip-dev@lists.cip-project.org
> > Subject: Adding v4.9.y-rc testing support
> >
> > Hello Iwamatsu-san, all,
> >
> > I've started to add v4.9.y-rc testing support.
> > Initially the build/test support [0] is identical to our v4.4.y-rc test=
ing [1].
> >
> > In a test run [2] however, we're seeing three failures.
> > Looking into it further, it looks like we didn't copy three configurati=
ons from
> > v4.4.y-cip to v4.9.y-cip [3].
> > Was this intentional? Or do we need to reinclude the siemens_am57xx-
> pxm3,
> > siemens_dcu2 and siemens_iot2000 configs in v4.9.y-cip?
> >
> > [0]
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-cip-pipelines%2F-
> %2Fblob%2Fpaters&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.co
> m%7C619038cf23f5442028b108da029388e0%7C53d82571da1947e49cb4625a1
> 66a4a2a%7C0%7C0%7C637825129919760321%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000&amp;sdata=3DWnMeGN28AeYWpHcPEYtQnH%2BPw9pv4ryRjgr4J
> MaDqCM%3D&amp;reserved=3D0
> > onc/test-4.9-stable/trees/linux-4.9.y.yml
> > [1]
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-cip-pipelines%2F-
> %2Fblob%2Fmaster&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.co
> m%7C619038cf23f5442028b108da029388e0%7C53d82571da1947e49cb4625a1
> 66a4a2a%7C0%7C0%7C637825129919760321%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000&amp;sdata=3DRo3OJHivCwtHEUmxcCYuoPcVnvgIGZeaNaQqmTwS
> 1Q0%3D&amp;reserved=3D0
> > /trees/linux-4.4.y.yml
> > [2]
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Fpipelines%2F486&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.co
> m%7C619038cf23f5442028b108da029388e0%7C53d82571da1947e49cb4625a1
> 66a4a2a%7C0%7C0%7C637825129919760321%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000&amp;sdata=3DAT76nNj%2B9L4E58rb02PDxvGarmW1ITAWx1Xwo%
> 2BOxY14%3D&amp;reserved=3D0
> > 998446
> > [3]
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-kernel%2Fcip-kernel-config%2F-
> %2Fcommit%2Fe737c&amp;data=3D04%7C01%7CChris.Paterson2%40renesas.c
> om%7C619038cf23f5442028b108da029388e0%7C53d82571da1947e49cb4625a
> 166a4a2a%7C0%7C0%7C637825129919760321%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000&amp;sdata=3DnBkHuYU8xFCSvgEJw3l4b8glqyEfi7HHSMzuQsgBB
> ds%3D&amp;reserved=3D0
> > 5ec22d2b7d3220d83855a952340f2357636
> >
> > Thanks, Chris


