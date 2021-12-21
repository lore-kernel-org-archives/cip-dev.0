Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4304BC433EF
	for <webhook@archiver.kernel.org>; Tue, 21 Dec 2021 13:23:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.5583.1640093002329729350
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Dec 2021 05:23:24 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1BLDNDX6022223;
 Tue, 21 Dec 2021 22:23:13 +0900
X-Iguazu-Qid: 2wHHDv11KDG8HDvcQq
X-Iguazu-QSIG: v=2; s=0; t=1640092993; q=2wHHDv11KDG8HDvcQq;
 m=gZv0gWRA8u/mZvn4igJcp/0oLxaAf4RoiYNZeH9Ln6I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 1BLDNBsB038088
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Dec 2021 22:23:12 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id A4A481000B6;
	Tue, 21 Dec 2021 22:23:11 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1BLDNB4u004590;
	Tue, 21 Dec 2021 22:23:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DsTBYQYvWPV6Ajq8bDRmab2229aEoPvDJ8lp+xxy0GWWpRRf2U4D+US5K8k/tv0V6Vq6wcO+or12CZRAIh7tkEh8A7JSfrRhKKdvrt/U8dAPpxEyFxMf9pzKSXt9axCxRybfEjDm6Pzyuelyx/SS9H/sfdDCoj/EZs0dCQ8LVGGA6GNIpaEcq8GLJ7hZj3k3FcGY6qnkmCxkabt6nCCW4FMBTuEPW97f++sbL3nQGPIk1QFks4/+DQufWfuXkdE4kulFE7xJKDmSWXCWYLqVzrL8+AwTC4/7OnmUdB84IErqfJL14o6jXTzefCswLC/A0fMS2u80HUIm3ty45gHOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9U/IfhBEtO42mHckiL5zLky8GOqSIn0ywibkSUWpF78=;
 b=hTPlojNYfs8biPcPRTYR2Dr6NcOBTGp1N2z2wCYXi6KvMsYaiyIVfbqMEfCHTykIpmcRjItqlUHb23OzJe4mpE1TPe8SbCHwKL6NqL6UbOm2vgb7yhF45Ya9L4uE/HlEx+hygM8rCl2ntpD2SCQKNgr3xw8L9eVJdnsRg42MmZRuci/dJIbi6LYZlTIwEcLCc+ch/9HDm8bLjQnYYb73c9Kv2jLp5d9l62vH8yWMqKrM7Qs1Ys4rcG4ocqyQlcaBx2IQXdrcj5huAz16eu0K6Y5c9CFqHP2JK5Sq9M5u/CabPvTDiixdJna+jVjPxMZKrg8UJj8xbvEjNQ9a5cHA8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <chris.paterson2@renesas.com>, <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>
Subject: Re: [cip-dev] 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33]
 5.10.86-rc1 review
Thread-Topic: [cip-dev] 5.10.85 breaks CIP testing Re: [PATCH 5.10 00/33]
 5.10.86-rc1 review
Thread-Index: AQHX8djbjKwco+6sfUmmAx/v/Jy7S6wz4IKAgAACOYCABxyzgIAALQsAgAHIeo0=
Date: Tue, 21 Dec 2021 13:23:09 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62520E6CDEEB3CFCA5E22C89927C9@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: <20211215172024.787958154@linuxfoundation.org>
 <20211215183223.GB10909@duo.ucw.cz> <Ybo2lbHVaASDyAcC@kroah.com>
 <OSZPR01MB6877AA8378F08F7071E53A58B77B9@OSZPR01MB6877.jpnprd01.prod.outlook.com>
 <20211220095806.GA21780@amd>
In-Reply-To: <20211220095806.GA21780@amd>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6fa7ae94-367f-3176-2176-0486bc1f19bf
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a84f8242-557a-41e6-b79c-08d9c485082f
x-ms-traffictypediagnostic: TYAPR01MB4318:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB43189D7492C63DAF8A50A107927C9@TYAPR01MB4318.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 fCnpO3Vjqp0viSwG5uNOUh4J84sX8UezB5MNJVA9X+MUDlBaRDpfWyF8FBrrKD19mZ9Mq5Pep0DFEqIbP1F1W2MEDK+NhRRq3Ym6Re4c1bIFwpHtSSbv2ROoZYOZVz3CyYhjdxCNZI5AFQCq23WgWIpiUS0Lw++3MfhzL3bWMyVmrPCEhpT1Cf9PESJ2gFCO627u2dmQPtdypEGJgwV9SCT03HngwkiQwtYk7JbqGkVIwV4JuezHDXVrU4jFxG/qwscG2kaADG/JqFSxACOYZbhXj2mNi3HxeuM3RTgwo6HnbxovGVJxcSIV8lnxlO3PNFx9awABqF+hmLcAfjwGbGTyEIHV4OneXVxyxGcNKPNAR5MFUyKC2wFl1IWV4TdO6LZiSkIhCk4Y5DYNtyLkPipDM+kEQkhHEFZ+LMJ6pVWA2uF8hU1swa/D1/W6JIVqOS+yc7Ev0MxR8bj2IXojkpHI0VX9IOCxnafqyiUjfCaQV9SdTOKYM8A2+XowItBU+/cGzHvn0UqeCdCSckjXzzwuZK3/oM2in6TIcSV7JwbKqGpayC7znP6lYr5ANGpUBqN9ylYQ4jD/1z32u3suGvIyoSE3+eS1//H5qUsGsRIi+uXBhDMW5AALFCsfAgiAJDuLiV3XJLXNCmzhx+HlFbVdIKFo7hNNkHiwYHsPPjYHOIXzLhuIdWF1N8EfxU0lWAVfEKbfakAIcCsZ9TDSdk2HdBnOcOK1GpLyQk9l1utDNWLCxQqWWkdzM0yVFCfxmGkSpr0b/5JeWfBVKtNPHmJFeFVcfmpt0mDfGeEJP94=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(9686003)(26005)(66476007)(76116006)(71200400001)(66946007)(7696005)(66556008)(66446008)(64756008)(6506007)(4326008)(55016003)(186003)(38100700002)(122000001)(33656002)(38070700005)(508600001)(8936002)(86362001)(52536014)(2906002)(316002)(5660300002)(110136005)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?eEMwZWVva3VsL09EcTBxUWNvR2NJdnFFbHFFU1J3YTlWempwRkp5WTV5?=
 =?iso-2022-jp?B?TWlBcENmWmpNTCtBdERxS3FNbDYreHVUZVphWW5HeVlHT0NDTXFGejFa?=
 =?iso-2022-jp?B?Uk40Q2lnYUlwbjRwYzI0N3RCSFAvMmhpSGJqMUw0ME1zVEVqYTYzSUdM?=
 =?iso-2022-jp?B?dVpGZ1VTMUNrMmxXY2JuRGRNdDBkUjRZNVVQR1l2QytxTU9pYThBK3NY?=
 =?iso-2022-jp?B?eTN3YVRoQUU1UGlpZlNwUDB0U3FNSEdkSmtGZjNZcTIwQ2xXdWlScHdT?=
 =?iso-2022-jp?B?cU5la1JkMGM0MUtkdSt4QW1GNHJ6aDlFNXE2ZkpwL3FDTVZ4NlpReU52?=
 =?iso-2022-jp?B?cS9tWithNm45clpOb1ZySGZpV0NDTDN0TjZoUytjYlQzRlluTWM3UkRN?=
 =?iso-2022-jp?B?U2xaNWxESENlbWpGSW1wcExJNlMvWFdhcGdRRXd5NmljY1NTSTkyUi9V?=
 =?iso-2022-jp?B?RXFnUDQzQTdxNEliZlJUSEJ2S0pWdzN0c0pnbFJ0QkE3azhEM2g0R2pN?=
 =?iso-2022-jp?B?eVlLajcycHhqdjNOOE1hZmdqZHZ4bDF3R3hudkNGN21makZDaGxuWkpC?=
 =?iso-2022-jp?B?WjFSc2RmK3MwdVg3Wm5XcGF1SlovYTZwTVl4UVFuK3FoZGRWZTdhamtI?=
 =?iso-2022-jp?B?WXFmdmRSa1pNOVJUakFmclBWcElRUFVrSVJnUFljZE5NT25FYjkwb1VM?=
 =?iso-2022-jp?B?dzBiajZHWDFJdmhmQVFrUDVMM09vZUxmQ0xjNUhvMWhpdThJWFlJTHNZ?=
 =?iso-2022-jp?B?WDhlUzM1d2QvWnVTd0taelRwcHFwdDQ2T2dNbTcrMlRMdzJibUV2T1J4?=
 =?iso-2022-jp?B?b1BNU0ZKOFpuRXUwUjEyN1pVYUIydExzMFQ1NDdwUitMcTJ2NDNibUp1?=
 =?iso-2022-jp?B?ZDMvWGZ6elpROHZpSHVYUnZwVnFCZS9xck5jUzcrT1RPcG0yQnRaNmxs?=
 =?iso-2022-jp?B?ZUMrWWNjZzFxWjlsV0JlT2FqZENhQlVGdzZYdGdVMGd4eEpVbVQ3Y2s4?=
 =?iso-2022-jp?B?T2tPa0xhMHR0TDAvMHBCZDl6RWlpTHJPMVpUV2pCc3N3UTdNUlRpR0g3?=
 =?iso-2022-jp?B?NVA1cHErbmh0VkZPN1FXd21zZGNkZnM2eVUxRFY1QTZwUU4wTGxCbHgw?=
 =?iso-2022-jp?B?U1Q4WGhFakdENzRYLzU4VjFQdS85eGV3L3VhSmtEYm9mR0NNUUx6VE9j?=
 =?iso-2022-jp?B?TVcwSUpUNkVjbFZQemUrVk9pMkpUQlFHdnNQUkJxTDZiOEszUms1ZFFa?=
 =?iso-2022-jp?B?b1g2OVFScjFCNTU5OUlBVTlvNHZhbzlvTGN5RnJzUzhMUzlQbGpDZ2Uw?=
 =?iso-2022-jp?B?M21aWFhLenN1UEM4Y3pUS0EzeE1menNnZ1RrdFdKc0pycXZxakdyTGVX?=
 =?iso-2022-jp?B?U1VaTUxpY3VueWZ3M20vTkl0bHlFckF5ZGNVSEwrUkhRZkhma0E4ei9O?=
 =?iso-2022-jp?B?OUYwVEpxZngwUnF3SW9MYlNDbmJKMWxyOVFuWnZZaWU3ZHI4VjlaeUZD?=
 =?iso-2022-jp?B?RmQ4U2VyMWxvR3JqSzA5ZVhNZWhkemlzbjZNZFlwRHhpV0djbmhHdW9u?=
 =?iso-2022-jp?B?UVhPdEpoQllyWko1SjNDUy9xOUNVMGM5dzZSbmVERnF4ZE0rYVFtaGNC?=
 =?iso-2022-jp?B?QTJDQ1Y2SDdEQzI0SXFPcmlYUmZRbmhqcFkwZElCTDFydSt2aXhTZks0?=
 =?iso-2022-jp?B?dk50eTRmOTFnNjk2bmh5VmFIeEtkcWpzUGtPcnRDRHIydS9ra3hLbk5L?=
 =?iso-2022-jp?B?d1Y5dVBnblRUWUlTQlBKT21mbUlGMXNZQWllRlBVQ1dFdWtZbnkwRk12?=
 =?iso-2022-jp?B?clJzRXVRaENua3hwWUhiaDVkeUZ1cnYrb2lxUHV1YjRxOExOZFljdjNq?=
 =?iso-2022-jp?B?TUNxdzJGL09GU3JlemlRay9YS3N3Y0dSN3VZRytkY0IvSGpDcm9vbUE4?=
 =?iso-2022-jp?B?ZzBCRGtHZS9ObUVkcDRndW10YXBndjNhYS8waDdRZnNPcERlR1pOMkt1?=
 =?iso-2022-jp?B?d3ZDS3ExMzk4SzRONHlPQk43QVArWUF1NHdVMEdOKzR5YnIzWHJGeEN6?=
 =?iso-2022-jp?B?V0EyVENzaWVBdFB3eDRwaHZCMkpCRTRnODE5Mlg2VElxc3hDUGlIbmli?=
 =?iso-2022-jp?B?Vk5IS2o1c0lMNU1xdGVpSHhBdk1aNjdyY2pNQVU5T0xVZ0pZKy8rbjdL?=
 =?iso-2022-jp?B?S29TclYvbTVsem1obUNJQ1Z2MXg3UC90TlQ3R2ZGRVM4WEJyQ3B2Rzcx?=
 =?iso-2022-jp?B?bHZOUmNhMGRkRkdKV090bUZLaDZTNTNhdFRaa0JGZFg2R0Q2MHB5SWlE?=
 =?iso-2022-jp?B?eXZmdkNjMzdvQ0VBbDVCWTBzZGVPTWU0YzBaNXJZRGs2TnYvYU1YZzlK?=
 =?iso-2022-jp?B?Z2t5L3B0bWQ5d2REZ1lEaWwwU0k4Vmh6Z1VSMGlrcjBSYjMvZUoxYnd1?=
 =?iso-2022-jp?B?VGJtbVpFbzVWbENKa0RDcU04eDIxT1hNV3E1OXhwenVpQk9Nek9LY01n?=
 =?iso-2022-jp?B?MXFCN3FQ?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a84f8242-557a-41e6-b79c-08d9c485082f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2021 13:23:09.6049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 a4GJ3+zP1NkbDj1BN4WwA3koehYrsltlmliizFTXODH0Xks92uUnRFv//e/u3KIjhFC0JZQ7BIHy0mtJBDVokA4qhInQtmbjZiOXkC3+IDVxPNsnZMg4YCJIVwDdA510
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4318
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Dec 2021 13:23:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7222

Hi,=0A=
=0A=
> We should do what our users are likely to do... they want stable=0A=
> kernel, and will not update toolchain in middle of product=0A=
> maintainance. [Updating toolchain when starting new product with given=0A=
> -cip kernel is more likely].=0A=
> =0A=
> I believe that means we should stick to specific version, but I'm not=0A=
> sure what version it is. We support Debian distro, likely gcc version=0A=
> from that distro would be a good option? Perhaps we should ask on TSC=0A=
> meeting tommorow?=0A=
=0A=
Yes, we recommend using GCC with the rootfs environment.=0A=
And weare using the same container at compile time.=0A=
=0A=
> =0A=
> 5.10 kernel was released in Dec 2020. At that time, gcc 8 and 9 were=0A=
> maintained, and gcc 10 was new (https://gcc.gnu.org/releases.html).=0A=
> =0A=
> To get some results for -stable testing, easiest options might be to=0A=
> disable gcc plugin support in Kconfig.=0A=
=0A=
+1.=0A=
Also, I think that this will not be necessary by preparing a build containe=
r=0A=
that matches the kernel.=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: cip-dev@lists.cip-project.org <cip-dev@lists.cip-projec=
t.org> =1B$B$,=1B(B Pavel Machek <pavel@denx.de> =1B$B$NBeM}$GAw?.=1B(B=0A=
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B20=1B$BF|=1B(B 18:58=0A=
=1B$B08@h=1B(B: Chris Paterson=0A=
CC: Pavel Machek; cip-dev@lists.cip-project.org=0A=
=1B$B7oL>=1B(B: Re: [cip-dev] 5.10.85 breaks CIP testing Re: [PATCH 5.10 00=
/33] 5.10.86-rc1 review=0A=
=0A=
Hi!=0A=
=0A=
> > > I believe we should not change build requirements in the middle of=0A=
> > > stable series.=0A=
> > >=0A=
> > > To our testing team: 5.10.85 introduced new requirements for the=0A=
> > > build. gmp.h is now required in our configs, and maybe something else=
.=0A=
>=0A=
> Hi Pavel, sorry for missing this email before now.=0A=
> I can look into supporting this, depending on the answers to the comments=
 below...=0A=
=0A=
Thank you.=0A=
=0A=
> > > Easiest fix might be to add=0A=
> > >=0A=
> > > # CONFIG_GCC_PLUGINS is not set=0A=
> > >=0A=
> > > to our configs. Alternatively I know which patch to revert.=0A=
> > >=0A=
> > > But I believe -stable should be the one doing the revert, as the patc=
h=0A=
> > > does not fix serious bug and introduces problem. Faster compile is=0A=
> > > nice but let mainline have those kind of changes.=0A=
> >=0A=
> > But that commit is needed to get gcc11 plugins to work with the 5.10.y=
=0A=
> > kernel tree.  So either we "break" it for old and obsolete gcc versions=
=0A=
> > (i.e. gcc7), or newer supported versions break.=0A=
>=0A=
> Well this leads us to an interesting point.=0A=
> At the moment we use GCC v8.1.0 for building all of our kernel trees (cip=
 & stable).=0A=
> What does CIP want to do mid/long term? Keep upgrading the version we use=
? Or try and support a specific version of GCC for 10 years?=0A=
> If the former, when do we want to upgrade?=0A=
> If the latter, which version?=0A=
>=0A=
=0A=
We should do what our users are likely to do... they want stable=0A=
kernel, and will not update toolchain in middle of product=0A=
maintainance. [Updating toolchain when starting new product with given=0A=
-cip kernel is more likely].=0A=
=0A=
I believe that means we should stick to specific version, but I'm not=0A=
sure what version it is. We support Debian distro, likely gcc version=0A=
from that distro would be a good option? Perhaps we should ask on TSC=0A=
meeting tommorow?=0A=
=0A=
5.10 kernel was released in Dec 2020. At that time, gcc 8 and 9 were=0A=
maintained, and gcc 10 was new (https://gcc.gnu.org/releases.html).=0A=
=0A=
To get some results for -stable testing, easiest options might be to=0A=
disable gcc plugin support in Kconfig.=0A=
=0A=
Best regards,=0A=
                                                                Pavel=0A=
--=0A=
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk=0A=
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany=0A=


