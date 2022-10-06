Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1CBC433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 07:08:46 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.114])
 by mx.groups.io with SMTP id smtpd.web09.2995.1665040123758549271
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Oct 2022 00:08:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=LTumLEha;
 spf=pass (domain: bp.renesas.com, ip: 40.107.113.114,
 mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7a6m3Her0ceKz9JoYm07qyHcin2gqFvTRidbH5RtEj5dOZslR4Gsd/bwdP+mUkHL+GRyNDMYyOt/+vG4vjVCunUi5asEKoA82L4Ydr0zXQPFd+yEdNRh5JjZfl7qH8OEiwfT82qjpUzTvUHjPN9/QwhxKQhA+6hnxGymw8d9pha3Cy9AQQieN4aq768ZCvxEFA4UBv0P/jnNH/DbMiov0IFmWp/egxCuw8Rp/RviDv0XlxaSDFZP6/bNqxeR4JNs/Xq1jUTLc+b664XzcI0flHZLPPI5J6ObEiyH8DOnRfDN48/YQA8zLJIqQYDCZdxl1rKWA/KhJaWukka8wQhFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ck1SEhk0/B0h62wdn7RFoDJPIEflrGP8dGgjHyWSAfM=;
 b=oGkfOUUVGz7dv6SPFYLxLUAfKGAkt9eeaxqEDb4IGP+NW+fItPlHguxbhC1OJ7l5FHL0AnrouZfuhobSXiVwq2OJSn/R8QjioU6jwQ+c17kCZ7lDgbl52RXzhsyIiOqs1IT54kclP8a+PtawWvqEfP9725cWLm1l1ZaboMtvSnUK/j7jQxKbZL3xnEoAIDevlk5JENbWF5uYluo98YCwfMqfOzwVmwM6beiN9PpLQWKLG7CAMCiWd8Eutj5zk2NE3YADAoWoJG1eqy69FZQwNSunLwZRL0eQvjgCMs/hegLCc1/cSHVTnx7gtqe+Abx05Kyiavh6YTONXBUQ1IZzQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ck1SEhk0/B0h62wdn7RFoDJPIEflrGP8dGgjHyWSAfM=;
 b=LTumLEhaADtzZsU6K95c1n6T0VhDQ54DQ3Z3OSnw0GdHAe3VXiMq4w2urXOZROW5BPv+4ILgPyaci8WgdVmA0jv6rYHq9pAQvvJYj+/m2lDsjnvVygFnieNv8CDQeg/iNZMxm2qVnkL4NL892dWqMR0EIm++JsAN0bLkDiFnc0c=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by TYAPR01MB5931.jpnprd01.prod.outlook.com (2603:1096:404:805b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.33; Thu, 6 Oct
 2022 07:08:39 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::a920:4b7e:5340:eb0f%6]) with mapi id 15.20.5676.034; Thu, 6 Oct 2022
 07:08:39 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, Pavel Machek <pavel@denx.de>, Chris
 Paterson <Chris.Paterson2@renesas.com>, Hung Tran <hung.tran.jy@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: RE: Preparing isar-cip-core for RZ/Five
Thread-Topic: Preparing isar-cip-core for RZ/Five
Thread-Index: 
 AQHY12R70oH/O7MJs0O1EcsG6E6zC63900KAgAC8CgCAABMIgIAAA0MAgAF6TYCAAMtWgIAABa0AgAADGmA=
Date: Thu, 6 Oct 2022 07:08:39 +0000
Message-ID: 
 <OSZPR01MB701920EE0FC4FC6B7FAEF37AAA5C9@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <e47b7bf2-aa3b-3132-e9ba-dec7a747edd4@siemens.com>
 <TYCPR01MB105880E900B643CD41841600FB75B9@TYCPR01MB10588.jpnprd01.prod.outlook.com>
 <d97fd149-c1b6-c4b5-cf36-4306881c228b@siemens.com>
 <38ce5ead-f7b8-e8f0-52a3-dff81f0f5045@siemens.com>
 <964bc8ff-9118-77b9-118f-6b979cedbb8b@siemens.com>
 <b6504b75-d609-d46b-55fb-3fd2b00780c7@siemens.com>
 <20221005182151.GA16437@duo.ucw.cz>
 <d9228cb9-e1de-dbdf-930a-ec35fbae4d3f@siemens.com>
 <dffd60b3-a074-c62d-bb6e-ae9c268195b7@siemens.com>
In-Reply-To: <dffd60b3-a074-c62d-bb6e-ae9c268195b7@siemens.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|TYAPR01MB5931:EE_
x-ms-office365-filtering-correlation-id: 57c85fe1-c6d6-44ac-bae0-08daa769984e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 /d3d4vI5DIFgr+GJjbgnWw+yZsMCW6SF36eOtCljVVW+Ja9n/zrMpiOHesnQSWbHvE7OarV9lkVHVbYwiITwz4+Sumg48YaQfsWWX930p/S8RQb7qNoxYNzhrZCoKvtGWzhNlj2RzUv9Jn4IT0K1QMlEPU6FOhouUnyeQvIaFNaKVkx0JSJzuUB2OhPY3kSEAkYQSz4Hu04Rm+aMhXxlf63bars4sYtIJkY9qFMX0ltno5wvtajmXefClCDFuab+g62N6H0KIcgoZxV+gPLPzKud2n00yPMODWUep4nI1Fgr53sF9OLDiSEaMTa2inEfIdmUO3InlJfOwn99QZZgxsViOKO4KZdgVuxKWAxmZFuETdSpUGwECt71NWy6FYf7F4TzzkGpglX7wUsrwN+iT5hrkqM9QD7ZeoADLviIp25Npioz+43Yx8TaOiXBpc7kyct1DFoPxDsjBLF25NK+RJDE4vjiSCbzn2YcXMw0nGUvLSwghK+aWS3o+PAN1C2+6fQdN5SJLo0MgmSQVdL8QMt6hUs7+ej9jidgJ2AyFE6Kcj4jAE0xo2GJIDgHUFYS0u8qCbLrXQj90Ms8gsiXzxmLzVw9Wc1rJ5V9sCc963x+xOBvYNcXom9VYGbe58eKU0qJsSiR40pn6hsmhcWVQxWSxgu06UjQdr6dJreyzo4YBOl1b20/oJ/aVUsgrZJ6egvXvfOf8xtVYPcpt2vbXUsVwJJOAQCZceCHRQ8gIS+wkU0Gbx9+e2/Ktbz8uZgNNzq0DEAV/4UvFg/V+EkiVxjRe7HFbVcM39eOXOpxK6E=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199015)(38100700002)(186003)(38070700005)(122000001)(83380400001)(86362001)(52536014)(8936002)(66476007)(5660300002)(45080400002)(41300700001)(71200400001)(66446008)(110136005)(8676002)(64756008)(55016003)(478600001)(4326008)(66556008)(66946007)(53546011)(76116006)(6506007)(26005)(9686003)(7696005)(33656002)(2906002)(966005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Cy/QxS7v0SJcRpYNtp4LcD+H8HuEaDVi+5QAJHvNZ7l4t0JnqU8sUl9Nl51M?=
 =?us-ascii?Q?9hNQmqx9U1Icy864lvHGanZG2Hzfj9/2AQOUYiYF36LeYDLZW+Tt47dpzgNU?=
 =?us-ascii?Q?1f4zEglZoR0739iSbspnqNKX2rGZb9KyagM8ejsAT2BKsz8jnWTX9MiYXJB4?=
 =?us-ascii?Q?c9hxl2dbmmzlbVy2Y5MKXj/48mnn+X1NN76PqwOTeHlQm70U5usZmyVAV+Ga?=
 =?us-ascii?Q?w9fvPyawi1wsxDNfcZxeAWTu91yzuGAEnG0k1tKpAwKCBt6gGEuZUe2oo1Y4?=
 =?us-ascii?Q?7ZGy3a7PQwCT3iEN66ZqFTkC3mLfCQ1Ril2fha681dRsq/TXSVB8JLNnhexH?=
 =?us-ascii?Q?k6Zu7oACOWXAQU+GUvapz865v2ICZNApIaKLpJnWUd8RVUxf9EZ9d+npirTU?=
 =?us-ascii?Q?XzF7jobCNhjoFP4RiujwrwWCztK8Krsin36poreLoCHJduvBIu1w4eozY9qK?=
 =?us-ascii?Q?/67pz4s6ow9Sp5mMiux4CbDUZhd/v1vYjDxqoHVkb/qOnA6boI4rh6iJqIyx?=
 =?us-ascii?Q?vyEQm8YplqF1SRfRCSYNTfFh2d8etQkjirWbSOa1El3JWo7PAQGbN1x1iEu/?=
 =?us-ascii?Q?UYt/e4xUiSV80hAdP9S7A+ZCTVkMq5Cn/rLdJ7+4Xpn1aqDaSE+LAzh+XG/c?=
 =?us-ascii?Q?cIijXp2dalfL8n4SkrUEGw4wjv/OV2P89SE/ZY8+T1hFI7mQ7InZiMxs1S6m?=
 =?us-ascii?Q?VJSktE/f1daR7WKXlAWCFvtGvXGbRBqMP5achwOl7P8pbqp8QHH3+f7IjVAP?=
 =?us-ascii?Q?F2o5VEd5SCYHlz08sG42/cSeYXmh93L7inkZJFsOdixdG3CnhUKCOMyhJEy0?=
 =?us-ascii?Q?rISB4mXP//2h5kk2BQmmu5HKLpVRWyT4nUJbud7V7TUSflgG92ktWWhjF5xe?=
 =?us-ascii?Q?81G1D6OuokZ0PT/MGY0u1qmcCzSqf5KPt7cJkQitUsucpFhNBXQAEDCPW//b?=
 =?us-ascii?Q?4lNf0Eb3q2Fnvuz4+RWkVjzvMVuAYtQsf4yRv8bX6jQuZHKRNFQd9DEMp7Br?=
 =?us-ascii?Q?8jyRz8n8YkyOgKWUK1k0/0IhENEj5M5zECgxMnoLKlIK2ZPaU8YEOJhyiKeo?=
 =?us-ascii?Q?+umGopujZsZ5hgRc2C3oj/iiR+sBbZEF3dy98hGNunJPnobj1N+Z+tROLCUZ?=
 =?us-ascii?Q?Ohka2VFWdfNdJH56GPqz1OnSsg135oA+QY5A5ppwuBoupKUMzNeF9SlYAV5c?=
 =?us-ascii?Q?heDglEJlN6Y8zBlHOufywIj0gfbZbcXkH/HR9eO7wo+YaXTD+3LL48TR9n48?=
 =?us-ascii?Q?6E8VXUK5tlx9BHAIbYDA06mIxfjKmltm3gGUZQS2MJ5rtxzznp4shF/d1URg?=
 =?us-ascii?Q?1REw4Y9D37SV5c0mtAR8RXmOfmfOLlbKHN9XCJozLfrJ6XHap7n8//jQvcG6?=
 =?us-ascii?Q?oTCkgEc8A259OB2O8WRxia1DHTXsTK0zqw9/2vZuAkI5Y/zL+n+tpeHTyH8W?=
 =?us-ascii?Q?AIdGAfBFvgE6nzprsfYofScL0NS9Y3KfzSRRQvOuRJpy93jN1Wv7Ts64ymeY?=
 =?us-ascii?Q?OJvW9lNLXpRVXtp+DgrYa71ENmRY42jab9KZZzDuLGZTF6q4pNIaBqjYOCmG?=
 =?us-ascii?Q?LL0RlOQEbA4d0zgPBx+e65l/OAs0UZow4Aj5169pej1WSapnLNPSXqEBChWa?=
 =?us-ascii?Q?6KjnMwFhUEvJQvvto+0CxDo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 57c85fe1-c6d6-44ac-bae0-08daa769984e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 07:08:39.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 d0y2IBl+2ry+UI87CPyFFzuplFh42yhRN0Vb4To4AqJ3Bzruw4q0zW6o1tMli7W3B2wrtWmbihZ1qD17VO5JIn9yEnDcbvWr6FdLlJwcjDBXGnWz0v1S8945hsQ9C3Qu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5931
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 07:08:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9658

Hi Jan,

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: 06 October 2022 07:50
> To: Pavel Machek <pavel@denx.de>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Prabhakar Mahadev Lad
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Hung Tran
> <hung.tran.jy@renesas.com>
> Cc: cip-dev <cip-dev@lists.cip-project.org>
> Subject: Re: Preparing isar-cip-core for RZ/Five
>=20
> On 06.10.22 08:29, Jan Kiszka wrote:
> > On 05.10.22 20:21, Pavel Machek wrote:
> >> Hi!
> >>
> >>>> But due to the weird U-Boot setup, I had to add some hacks,
> rather
> >>>> than a proper boot process.
> >>>
> >>>
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi
> >>> tlab.com%2Fcip-project%2Fcip-core%2Fisar-cip-core%2F-
> %2Fcommits%2Fwi
> >>> p%2Frzfive&amp;data=3D05%7C01%7Cprabhakar.mahadev-
> lad.rj%40bp.renesas.
> >>>
> com%7Cc8b33a1b0332467e04ce08daa7670053%7C53d82571da1947e49cb4625a166
> >>>
> a4a2a%7C0%7C0%7C638006358079991069%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiM
> >>>
> C4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> >>>
> 7C%7C&amp;sdata=3DI2ajBytTSsUvSHp5wmkA1rgVz83rW%2B6aHGby1O2tyog%3D&amp
> >>> ;reserved=3D0
> >>>
> >>> Test by flashing the image to an SD-Card switching to SD booting
> on
> >>> the module.
> >>>
> >>> Maybe we can find a better solution for the boot procedure before
> >>> moving forward with this.
> >>>
> >>> Anyway, now we have a real distribution on this board. Pavel, can
> >>> you re-check what you observed, if those issues persist with
> Debian?
> >>
> >> I believe I was running Debian; two versions and Ubuntu, IIRC :-).
> >>
> >> Can you check if ldconfig and gcc work for you? That were the
> >> roadblocks I was hitting. If they do, I'll be interested in details
> >> of your setup.
> >>
> >
> > Hmm, seems the issue persists:
> >
> > root@demo:~# ldconfig
> > Illegal instruction
> >
> > [  297.146728] ldconfig[497]: unhandled signal 4 code 0x1 at
> > 0x00000000000380c8 in ldconfig[10000+83000] [  297.146768] CPU: 0
> PID:
> > 497 Comm: ldconfig Not tainted 5.10.83-cip1-riscv-renesas #1 [
> > 297.146775] epc: 00000000000380c8 ra : 0000000000015382 sp :
> > 0000003fffe01c10 [  297.146782]  gp : 0000000000099da8 tp :
> > 0000003fda772800 t0 : 0000003fda7787c0 [  297.146788]  t1 :
> > 0000003fda8065a8 t2 : 0000002acbbda7a0 s0 : 0000002afa2ec890 [
> > 297.146794]  s1 : 0000000000000001 a0 : 0000003fffe01d18 a1 :
> > 0000000000000001 [  297.146800]  a2 : 0000003fffe01c88 a3 :
> > 0000000000000000 a4 : 0000003fffe01d18 [  297.146806]  a5 :
> > 000000000009736e a6 : 0000003fffe01c80 a7 : 00000000000000dd [
> > 297.146812]  s2 : 0000003fffe01c88 s3 : 0000000000000000 s4 :
> > 0000000000000000 [  297.146819]  s5 : 00000000000105a4 s6 :
> > 000000000009e670 s7 : 0000002afa2ec850 [  297.146824]  s8 :
> > 0000002afa2ec710 s9 : 0000000000000000 s10: 0000002acbbe39c8 [
> > 297.146830]  s11: 0000002acbbe3938 t3 : 0000002acbaf2610 t4 :
> > 00000000000925a8 [  297.146835]  t5 : 0000000000000004 t6 :
> > 0000000000000000 [  297.146842] status: 0000000200004020 badaddr:
> > 00000000a01253cf cause: 0000000000000002
> >
> > (gdb) disassemble $pc,+0x10
> > Dump of assembler code from 0x380c8 to 0x380d8:
> > =3D> 0x00000000000380c8:  auipc   a2,0x66
> >    0x00000000000380cc:  addi    a2,a2,2000 # 0x9e898
> >    0x00000000000380d0:  sd      a0,0(a2)
> >    0x00000000000380d2:  mv      a5,sp
> >    0x00000000000380d4:  addi    a4,sp,416
> >    0x00000000000380d6:  sd      zero,0(a5)
> > End of assembler dump.
> >
> > Do we have any instruction set restrictions that prevents the usage
> of
> > distros on this CPU? Under QEMU, we come along here as well and
> > execute this without problems. Some infamous Intel CPU comes to my
> > mind at this point - hope, history does not repeat here....
> >
>=20
> auipc was introduced with ISA 2.0, around 2019 - please don't tell me
> we are on 1.0 here.
>=20
I have seen similar issue with yocto dunfell release, If I go higher up to =
kirkstone release I see there is patch=20
add-riscv-support.patch [0] (I haven't tried this release yet though).

[0] https://git.openembedded.org/openembedded-core/tree/meta/recipes-core/g=
libc/ldconfig-native-2.12.1?h=3Dkirkstone

Cheers,
Prabhakar

