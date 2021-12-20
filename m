Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBB5C433F5
	for <webhook@archiver.kernel.org>; Mon, 20 Dec 2021 07:17:01 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.135])
 by mx.groups.io with SMTP id smtpd.web12.2713.1639984618551122637
 for <cip-dev@lists.cip-project.org>;
 Sun, 19 Dec 2021 23:17:00 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=V+bbrliw;
 spf=pass (domain: renesas.com, ip: 40.107.113.135,
 mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6YHKbJ5LNY82sLI93MywH1WXO8sdJAZkh7VhvmIlgkkYAdnz++9l9KwnsJQDUswJmyQ2VTW2dGPZ7OTZBNolkewGUYGo1CdzaAf7CtuxUcD5+SgxTujwbY45zKjQDkAlHRe0IIUWBw59+V1TktEjLEQBnqVzPcPxNdWhkMOnIFSb7GdjGQWw89T3frIYDVqHjR8aWTmgMMXD4v1yA5+0TKZaX104UnKJ931ujuulGpAR/IRl3HdxIaW5ZUA8FfO0ek1U61zR+5G0waiaOtexYAsmrByLvAup7tTTL5xOs9x1GnCRvBN7jRBYeRsN4WigpKzHEHLgo+o3vFRPQJOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYMvz7C5Fc/RFCFigXluSBwYxDhuFtORUTdk61t8Z+4=;
 b=VugHM45wOfHGwBRD4/h39DrHFxLNBkFPn5YYPd251G7p+qWjtl38pxwZXKpevpuSHjQsN7PZvqZhThZQx6UuLCuIrQqANJIdUcyLzjxSLEuoxoWw6RxXcxJIgyG7B4U5G8zCWsNsy3Ljelm+sA/3Hg3k5uFRr1xvK8EshxzyO6RxHMfN9T0UJXWqVUhRBYXpukTwSJdPtFo5SAqxePem3HVYL562dMKCc8wllmpi+znMWy9Jv6+h864yHfnhebm5pGuRyTYGpfmgZg3P4zbsLw4bCBZEZ6bKOANhSUoZaDwbKdFJvluaCzFUmxrR4F3NZgCga7AMXZjkUpuWModRDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYMvz7C5Fc/RFCFigXluSBwYxDhuFtORUTdk61t8Z+4=;
 b=V+bbrliwncAVS8139/7dS0tuKFaAKZ6SompY0bHSm6Y9Wko8lun20AM7q84YmTtTkA6u5OeSmSo8SHpk1lhnpM0PgcetC/I5PrWnrDz69c6RsyjZHBQi5TlXNI9nUW2OtNJeDsSj3lhIH+Gr4iauGNkHXIOjCBZz9WqLhKW7JtQ=
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com (2603:1096:604:13d::6)
 by OSAPR01MB2306.jpnprd01.prod.outlook.com (2603:1096:603:16::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Mon, 20 Dec
 2021 07:16:53 +0000
Received: from OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b]) by OSZPR01MB6877.jpnprd01.prod.outlook.com
 ([fe80::94f4:a951:a861:bd5b%5]) with mapi id 15.20.4801.020; Mon, 20 Dec 2021
 07:16:53 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
Subject: RE: 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33] 5.10.86-rc1
 review
Thread-Topic: 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33] 5.10.86-rc1
 review
Thread-Index: AQHX8djMhWFUnPMh8ESXVyayu7bpUqwz4IKAgAACOoCABxtVYA==
Date: Mon, 20 Dec 2021 07:16:53 +0000
Message-ID: 
 <OSZPR01MB6877AA8378F08F7071E53A58B77B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
References: <20211215172024.787958154@linuxfoundation.org>
 <20211215183223.GB10909@duo.ucw.cz> <Ybo2lbHVaASDyAcC@kroah.com>
In-Reply-To: <Ybo2lbHVaASDyAcC@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 216fb0be-1c04-454f-cb79-08d9c388b2fa
x-ms-traffictypediagnostic: OSAPR01MB2306:EE_
x-microsoft-antispam-prvs: 
 <OSAPR01MB2306BD239E1635F82A410504B77B9@OSAPR01MB2306.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 iaDPX0+K+q8jsPNdlLmiXp5/FWbb8CvExfEa6ELX573CQRxV2UiOteNe7AMDo3yZGqzpeFamVa6dpBiVd1qDbFXlCtn4/aOz28gLAi4wNU22ltIj6OhiC6iIBSEvR5C9hETDQt0s04tVMYi5s51eN76kT38H06bwejBGet3/hQKtsj1v0cLFg4YB30fBF4pt+pqv7zVjj7YiKHpTKfSKHKhruZNiRXaRV6Uqjkez6V8OSyedB0PWDMyfasTVsrS9nmEsAgKfP6eXeu6xHMi5Lmx8EUzsD+jnekxdlZ2ghzvLr1UOhuHF72gM1/IZn1UC9kVq8A+26DL6cIiLuld3AY0cFGWjVrZjpEQuxaKlhjfmwOByrRsaMH37/Rv/9bhFc5kmoNxegoAYkTo5JTqIV015yspQHt5t1bqPqKhsUhi+x4zzlR1I84530TS7w027UsZQJa1ArKG1pKz5BkMsx49WW4dD260H5uAzFIPvxr4VYOwL+I/Dqi1/UGKJkMM6Uf1mMQCx7DxgW7/5Y3KqfBujNUwj6UaRUny4gJMToaKf+WC9JFd/9VvWm20ll2QPi4bVOZcqQvFyiAHi/LasY/GdTMizQbok8obfBkk3KiP3acjeDASwDZUX32I5fs6u1cf6/9P8BCVpNS7AYswunSCoPsZVu/RdSnitpGqs5IEb5sRTD9BnxDYfTZFkyUeijy/hajtV/4llfXAdgUfRW2MlZkN0bYXAmE6jRMA6qsQ5HxZhR8teyDOOIVD0dU54iiJdHV0X+RF/KHwQwmglLaXI33C7uifqljaFHISBlnA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB6877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(2906002)(8676002)(38070700005)(110136005)(7696005)(52536014)(508600001)(86362001)(122000001)(38100700002)(5660300002)(71200400001)(45080400002)(6506007)(8936002)(66446008)(186003)(76116006)(66476007)(9686003)(316002)(64756008)(66556008)(26005)(83380400001)(966005)(55016003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?+PKQzYXh/E1BYM4nxCHUvIOY/lPYG1fgqhV/pyWGDGzTD5WI8H6BszaL?=
 =?Windows-1252?Q?fNzcaNcneXQWb+2+F6DG3Ky/WZ7WzV7k1izWiO12qO+r/ienE1zjaHeT?=
 =?Windows-1252?Q?4oxEKVrkwAIIbVFA3o5A9Teo0QShITTeaeDPZiPaE2TxWaB01atBS3Dc?=
 =?Windows-1252?Q?hz9BcMEB2TSIrNOE6Ik76j8beHinmYKNPiAqAOq4J9gR5+cciIgYPQ+f?=
 =?Windows-1252?Q?RR+g5c1IQ/NWqLjKs6PvAGHRGNyEzZtZigbHAPtGPnDWC4Vv9l9Bi6bT?=
 =?Windows-1252?Q?sz9FKSuBAVVfkxFfeBm9ES0Bvaqx79YsRETL23LAcYp1XC4IOVzXHFcB?=
 =?Windows-1252?Q?H8RpnZU+crZAxCCDbqHxcKMhaxWKByXNQxEV8O1eAm+6ZbcNFCoQbB+R?=
 =?Windows-1252?Q?D0hf/9nTxiJ7EtzqFJvN99BbP5uss+rj1oPVHHaVD8qFo7RcltCbVSDd?=
 =?Windows-1252?Q?4UmGx3I7CG2ZlugD5EUb1ZpZuiZyYeg+uUWhuUWAXicZmEBr7Zlr+bcv?=
 =?Windows-1252?Q?FlgNDltKl46uVTazKLY5hIRAlG8mT7kmEhUP8JikFg1HNj7YWI+Q0PsG?=
 =?Windows-1252?Q?OV+SCN5oln73kM2wMk6p5t2VJREhV/eWOSi7b1bfpD1CoMn66HONS1dZ?=
 =?Windows-1252?Q?f5PIHo2mMOrwEOtuIeYK0pF7PmWjqiQ+OwpYRftHAFULtivseWvPB3hE?=
 =?Windows-1252?Q?uIwz6+VA8G9KUfgGLuue7+f/vHOfb1s45IixFloaunXlQX4P4KSdu4um?=
 =?Windows-1252?Q?h91xNvkMWc6VzGIuqI9kezBbcMfgWcQ8X98u+J+l/P9l/LtzDmk2OgiW?=
 =?Windows-1252?Q?so1qaH2tKXYkPnpm03U97dMSw4tM5nHdm+ZTmqMfxSYPXXFGzhnhqLQJ?=
 =?Windows-1252?Q?rBQHmI08EjezQU2vOPhd7CDNh/Vp/aBNHv+Y5BTeIo4OmxBekP3+JbXX?=
 =?Windows-1252?Q?MA9uufpgCMhmHF6KdC3pNyFVTw9FJrAJQ0h/OlfLLFq56ue9SNQcTgp9?=
 =?Windows-1252?Q?UluPoJk0vzUtsZa1UxXeu/t/ReGBTxw1eTdQOgBi2Sz8AsG/uaIrygMq?=
 =?Windows-1252?Q?BRDdZr5jRSBV35Go5BKo+69NbLoGjOOOKr8p0wE5qK4oFVlI82MRCr2k?=
 =?Windows-1252?Q?+UOMDk7/Lyb3Z6Onga+SI+EjXd4OoJdO9R0QNRQM5HxbJah9CnTvGQgC?=
 =?Windows-1252?Q?qo102EGdxnBst1OK92wA0RpYmmjA9v3TRva6wpcJCRh3KjWUCScD7hab?=
 =?Windows-1252?Q?6xR7rv6q2lcOVPHjxem3pQ+ElgAgzef8YWK304CWsfGbGLNxr6mq0yRS?=
 =?Windows-1252?Q?mQFFlpuNjEowMmnCe2fl31ET4S45fdeISX8Mhih5u+6moIq7sCrYo/8R?=
 =?Windows-1252?Q?tTiBoFyTWOAAFCptwQo/BFS/7kpvswC59A03EcezU2b6XA9WLMSo9+Fj?=
 =?Windows-1252?Q?A9xSyBAO8oJuZh8WlgYtu6FIrXMfgUJq136rmxyDiLgwJnU6RNpVm7pN?=
 =?Windows-1252?Q?BrG5q6CbxtAtD+Ptr+5M4gN+aCsoUxpio/pildClpvYbep4EeIaJkOBF?=
 =?Windows-1252?Q?I5p4l4AWSwbroe2s079pk4c1ZaaThTf88pna9EyAXCM/t+Ug7J9Jshib?=
 =?Windows-1252?Q?MVHmAIIZ3Sy1Wnzhol8ygUSG2vJ47C9ti900fVBBBeHFDbO+zyP5Dl2U?=
 =?Windows-1252?Q?Gxeq3J1/SCcfAbbHYYwAu1odkFFQ2i8LaJzH7TVqRPWcoNx63bKz455j?=
 =?Windows-1252?Q?yMqoCDxAKN2qY3dl2CBfAR1/mBQQJxlQTNwxvrF1ffa9pN+hNM5WdR9d?=
 =?Windows-1252?Q?wkUDrA=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB6877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 216fb0be-1c04-454f-cb79-08d9c388b2fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2021 07:16:53.4916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 dcwqGo306JZwqbFe4qmPYh/r19EiKzFK7wqiWAXM2f4RAds7TpyqwtdVVDkJmKeNCvphS/TMVSyOw5qg0PZscbmz65tZb7ZiF6UixbLQ9as=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2306
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Dec 2021 07:17:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7193

Hello,

> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: 15 December 2021 18:40
>=20
> On Wed, Dec 15, 2021 at 07:32:23PM +0100, Pavel Machek wrote:
> > Hi!
> >
> > > This is the start of the stable review cycle for the 5.10.86 release.
> > > There are 33 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> >
> > I'm getting the gmp.h failures :-(.
> >
> >
> https://jpn01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitla=
b
> .com%2Fcip-project%2Fcip-testing%2Flinux-stable-rc-ci%2F-
> %2Fpipelines%2F430434332&amp;data=3D04%7C01%7Cchris.paterson2%40ren
> esas.com%7Cef488aaeb0b84b91a25a08d9bffa5dd5%7C53d82571da1947e49c
> b4625a166a4a2a%7C0%7C0%7C637751904307960001%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> I6Mn0%3D%7C3000&amp;sdata=3Dd4fq1iITMmiW79nbbG0Tf4srDwikrnVaPW%
> 2BH%2FITD9sY%3D&amp;reserved=3D0
> >
> > I believe we should not change build requirements in the middle of
> > stable series.
> >
> > To our testing team: 5.10.85 introduced new requirements for the
> > build. gmp.h is now required in our configs, and maybe something else.

Hi Pavel, sorry for missing this email before now.
I can look into supporting this, depending on the answers to the comments b=
elow...

> >
> > Easiest fix might be to add
> >
> > # CONFIG_GCC_PLUGINS is not set
> >
> > to our configs. Alternatively I know which patch to revert.
> >
> > But I believe -stable should be the one doing the revert, as the patch
> > does not fix serious bug and introduces problem. Faster compile is
> > nice but let mainline have those kind of changes.
>=20
> But that commit is needed to get gcc11 plugins to work with the 5.10.y
> kernel tree.  So either we "break" it for old and obsolete gcc versions
> (i.e. gcc7), or newer supported versions break.

Well this leads us to an interesting point.
At the moment we use GCC v8.1.0 for building all of our kernel trees (cip &=
 stable).
What does CIP want to do mid/long term? Keep upgrading the version we use? =
Or try and support a specific version of GCC for 10 years?
If the former, when do we want to upgrade?
If the latter, which version?

Kind regards, Chris

>=20
> We are not in the business of keeping older versions of gcc always
> working, right?
>=20
> thanks,
>=20
> greg k-h

