Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F71C3DA61
	for <webhook@archiver.kernel.org>; Mon, 29 Jul 2024 12:00:36 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.web10.54319.1722254426727999596
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jul 2024 05:00:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=B4fn3LNV;
 spf=pass (domain: renesas.com, ip: 52.101.229.46, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZmaEd9cHdDQpnPhRR2EzM/maS1ZFpnm4tWKA2KBPVWMYjPAKYOsL/SuAa8qfHZ/re3iUmn/9PN20M+AG41HzCsXomycjaJXtFiFt1kDosHjEC2G3W9ovDjCBMD50ejkMyDekDSGA3QIiHgPycaflvdVre6IodhZXJpu5eG4iUegQnjy88nGb4tn6xxhqC26p/fFJs+EOCDOAh+c2Qn+ZHqB8pAOfNpNCMpmgXzDP88INjkpO+pnxsuXJYJlsHgl2xL+FittQIruGVhTGZOifAZdLfCvLTsxqliwWTBWt5ugMot0twPCTxpxDCtalfPDh9132nJu/PdQhjj4UHKZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MVTQa6ESdPGG4pY1KbnLgdK4q7o+N+st9tbbwpbS2k=;
 b=tnpZ1D1phahkidJAePkovY/TBxjacCapgFbaBy9aE+sn09braRelk7avigBXpxtW+uEFhMVBOZDsRIIaqzPICDFub3nnUUpU+EKWG3t/pmSSp16VP2PKRWVn+iVFW388/WcpVUSVO/YB1xofrSPenWGbgvW5rut1pMMh4LzzDTwCB/j13L3U7yIwGoT28A3UdOuohPXSFEPwvRmIoriaOxVxfdLdbLMPGHoALPX7qP97+wBDZEm/iC2WmKbbjyYZ9dvRKmN2+85lLVt+7C1r2uzKRhkjJbkXiNI4NqWHthQjkMbLq1UXXENgcKgCxZBR1PNDtyjyDmk0mBqu3WzfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MVTQa6ESdPGG4pY1KbnLgdK4q7o+N+st9tbbwpbS2k=;
 b=B4fn3LNV3UUTlGJxthnKKLb87Eq7nBc8cK31QuSNuFqDPnJ+cZMlPd4uKyG9NAVG+Hpz+jc9JirdnqxeGkqCVHhf5YgxoK1GB5I36JZm+s6rtSPIKi1axc4U2akO7qPb3XPGl4hfCniflc1duGoOdwmueBstT/pRU7LN8HvbVK8=
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com (2603:1096:405:f7::12)
 by TY1PR01MB10819.jpnprd01.prod.outlook.com (2603:1096:400:327::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Mon, 29 Jul
 2024 12:00:20 +0000
Received: from TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87]) by TYYPR01MB12402.jpnprd01.prod.outlook.com
 ([fe80::64e8:dbea:c288:5e87%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 12:00:20 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] Adding tests for 6.10.x
Thread-Topic: [cip-dev] Adding tests for 6.10.x
Thread-Index: AQHa34kTsxibemAaEEqP/xBSELro57IM1SeAgADJQRA=
Date: Mon, 29 Jul 2024 12:00:20 +0000
Message-ID: 
 <TYYPR01MB1240224190BB552D4C5507154B7B72@TYYPR01MB12402.jpnprd01.prod.outlook.com>
References: <ZqPp4nE4f1jOnJJI@duo.ucw.cz>
 <OS0PR01MB6388F7B33E56D44B35FA2B6792B62@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388F7B33E56D44B35FA2B6792B62@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB12402:EE_|TY1PR01MB10819:EE_
x-ms-office365-filtering-correlation-id: 1e9f1f94-d746-4df7-99e2-08dcafc6055f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bEUxTWZjeVU4NGNOQWZUZFgxWWUwemo3emorUTJwTk9McGVkK2p0azln?=
 =?iso-2022-jp?B?UkxHbExKNEJCdDg2bnBrc0tsZ29Cam5lL0hjeURoZExJODNHcG1HWU9S?=
 =?iso-2022-jp?B?TVNKd3B5YXppcUZCeGxjallCeFFzTFJPYUE4eEI2REhHZWJQZi9hdmY1?=
 =?iso-2022-jp?B?OTRJSUhVa3FuS0ZmMUlOUytpSVlPdzNETnNkaVg3ekV3Mm5BUngyZFEr?=
 =?iso-2022-jp?B?c0tMdDdIaURxbHRhaGRUR0NnZEx0OCs4aGkxNngyNTlIVGRiYUZTSVMw?=
 =?iso-2022-jp?B?NzVxaHRtaklrb0xzMG9ma2JsOGxCWk9LMGw0OE1Sd0RjZEVxV28yYkUx?=
 =?iso-2022-jp?B?L2daSnN4eERmb01xTUtiNWYybzhKUzlTbXRESEdoU2tBdnFGQmpkZGZJ?=
 =?iso-2022-jp?B?V3MrRlBva01CT1lndXlPL3Axb1pJQWxTN2t4RlB4UU16UlphZlZyN3Bx?=
 =?iso-2022-jp?B?b2h1OXBNM0UzcHg3bFc0Zlh2a2IvQjcxbFc5OThoQnFodHNuVjZnVzhp?=
 =?iso-2022-jp?B?M0FseENmSi9iQzI2NVhVNWxEbFByS25ZTGR4ajFjOUg1N1NybytvbWR2?=
 =?iso-2022-jp?B?TVpyYnRZZTRDMTk0bkRKY0J6YUl5Y3NUdGZkRWhSek8vUlFZU2FyYkpR?=
 =?iso-2022-jp?B?dkxtb2RNWjZkRGw3SWZWN3g3dlA1bHZQcUJ5WERKZUhjVWhTc3dDTG1B?=
 =?iso-2022-jp?B?eVgxZCtiQnRwOE1XNld1Z3JDci9QeDNOUTZuM2xTZ2dFNHI0c1VRTGRV?=
 =?iso-2022-jp?B?NUlrc1hNVlZGc1luMWJIYmNSOCtTdkh5RW5mUkoxdXl1UkJwOFh5bU90?=
 =?iso-2022-jp?B?emZHYytMRk9ZckFyajFZRUtrVFpoajF1MVlQczJQTk1QcWk1WWJSWWQz?=
 =?iso-2022-jp?B?Qk84azAzbTllYU01SWtqMys2RkZrWkNkZjlCalNEdW5iR1FWTVBkQVRq?=
 =?iso-2022-jp?B?cXV5MDdRZnBERStUUzRNTFVPWTR0bDZRT3lISGk0N1JaSU12d0hBQlNk?=
 =?iso-2022-jp?B?UU5EdDU0Y1dPVUU3dG5BOUZ6V3hCNXA5UlFxVjQrSHVWdlVLUCtEYVVY?=
 =?iso-2022-jp?B?aFhvcmU4cmtCYkx3cjVTdUFvTW5ONzVWRUE4RTRCbk9FZThZc2ZmYzhy?=
 =?iso-2022-jp?B?SHZXRTZXQlVIcmhveURIakRyUVdRR3dWRjN3akF2UWowOExjRS83bVVk?=
 =?iso-2022-jp?B?akxEOVZvY2xWdVgyTGFUM3lQMTJWYzdhZS9jMU91cmpiaXBRblFMY0dH?=
 =?iso-2022-jp?B?amtYYlM4Y05ycGZNMS9FWFNLNXVEdVRtUjEvbzM3NGYzSWZqcE42SEUv?=
 =?iso-2022-jp?B?SGNLTHhnbWhjZ2JKTUZkMzFsMWk1WFRUNnh6MzlPQlNwbkR1TGVoaU9Y?=
 =?iso-2022-jp?B?NHllSG1TMThGaUdBMll2ZUUrNjBpOUVZUEhQN1U1ckhvVEUyWFlSN2hJ?=
 =?iso-2022-jp?B?MmVoUStuaFNmN1lseUthTmc0OUYyR21hVFpzTCt3WEVWRk4rczNPbVNJ?=
 =?iso-2022-jp?B?MG85cjQ0NGRld3BnZEsxM096VWs0bzNtWjZkNlpQTVRPR0tCR1c0bTN3?=
 =?iso-2022-jp?B?ZXpXOFNPS2F6SXpmNWdJVVk4VzR2cWxYNjZhZndpdUQwazZsaVRkSVBR?=
 =?iso-2022-jp?B?clhpOVNrRVZEMjVHc2RYUXEwTFBVZE5HdGxlN3BRalQ3TEI0WENsaWdB?=
 =?iso-2022-jp?B?WHRUMS93aEZnL1pXblNOT2dJS01rYmZsL1IveGJ0eXArMmp2ODdUYXRi?=
 =?iso-2022-jp?B?RDVEbkVYMWFRNHRRQVVPOVIzRTRxVVNJeFhPWTkyWkFicVp5RjJ3ZDYz?=
 =?iso-2022-jp?B?NXZjc0gxQjg3Y0Z4d0IvVDRtdjlHNjBMVEk2VWtwL1FPTzhhWS9wbkd6?=
 =?iso-2022-jp?B?Z09XanNUNXVxZnVrdlQ3ZXBKMkdLZlgzMmN3ZzVqYlQwN2N4S2N6OFY5?=
 =?iso-2022-jp?B?SXA3UUVNb0pMdGxJeTlpaEREbittQT09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB12402.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Wi84cFpHUFFiblkxaVNna0ptOWRFWVVKeUMyK29vWndsNERsN28xKzRw?=
 =?iso-2022-jp?B?eVJBTk51dVNQWVJ2bm03aC9vdGVXZzFFQ2lSQU1LWThEaGhpTUFuVHZZ?=
 =?iso-2022-jp?B?dDdQVUltOUl5SFRwM3NCNi8zWEJoRkNnenpuL0R1Y3hjYXdhWEFvaHRT?=
 =?iso-2022-jp?B?YUlqYlIzd2s4V1dhR2syY1NaQUdVUEhHY3ZSQlp2cUVRMjhFR1RtYndL?=
 =?iso-2022-jp?B?c1A0QWJhMVRuR0FGNEc4MHBxRm8yTVlWTDNqZFR3dDhQM1BqMXZFWlRO?=
 =?iso-2022-jp?B?Ym0zZjE0WVMzRUk4RTJKSVJyMmgxWG5yaGFFWUlleTZleW5WQ1dHWDRl?=
 =?iso-2022-jp?B?UTZSTjNTaTRZRzZvTWl4dkU2NGlCd01keFRBQlZvMk53MEEvUFJ5dENY?=
 =?iso-2022-jp?B?eDNMamkzVWcrRmV6S3VRTTlRbGhUMlZINjQrMEJPOGhrSGU5Y2tBUEt1?=
 =?iso-2022-jp?B?MTc0UmVhaUpvaXFMejg1c25RWE4zdWJaS1pvQVZSVjAzUGRuaS9YNHVm?=
 =?iso-2022-jp?B?aXVXMUxvTERISnVvdkU2enY4UnEvMjEzZGk5T2NndWRZVDJnYm5FTCt0?=
 =?iso-2022-jp?B?MXFmL3Nwa3VFVUp5eXh0T3dodlJRNWJSbWpWUWNDN3MxS3E0by9HU0hW?=
 =?iso-2022-jp?B?ZDdaZ1hUTy9rT2FkWmlENExzS1JZZHVRYTEvd3BlVVNCcmJHTUZxclhn?=
 =?iso-2022-jp?B?NlFaNzFOY1grVWQ3bnBZeXV2Mjl1ejRpQnRDeTV1VnRFU3I3dlpkRm9H?=
 =?iso-2022-jp?B?ZktQZTdwUUdZWEFyWi9sTTViZU9HYWFZRDFlc2Q5YWpSYjBhN2FxdElk?=
 =?iso-2022-jp?B?L1lBdmt1UHNqeSswZVZ5SVRXdFNaR0lYMUNlNXc3V3d1NHBxQ2VLR1hJ?=
 =?iso-2022-jp?B?a3Z4aFE4YUZUbUVvRFEzRnlDU0tyRHlyQmFPUStuMy93dkhURjd3WkZp?=
 =?iso-2022-jp?B?OUFlUjFXRUN6Wi9nZktEK0RyR1VWMVlpLzZtNng2MS9iVVpNUEVFNEhM?=
 =?iso-2022-jp?B?ek9rUFByQlUwdmdTNDFNMmJVTVdmUS9PbUNFaXRMb3kvM3ZnUXVVNzZO?=
 =?iso-2022-jp?B?VTJrcmdnWWI4VXpkWFhOK1c2V1JhY1hXQWpqRUw0L2lKcHlsNml4RjNu?=
 =?iso-2022-jp?B?U0RaMWpZTWNOVkNhU3NCKzNLM0tLSlZMV1JrZGNnTEluY0FxcUhoaFJV?=
 =?iso-2022-jp?B?bFo2QWJkUUpsSVg4cWtYRWp3Sm1NVEs5YWZYMjhpVENLN3Z1M0VFdksv?=
 =?iso-2022-jp?B?YW1PbUgxYUkrc3dKZSt2OCs5VC9IVElmc1VSMXR2VXN1T2ZnT3pEWUxm?=
 =?iso-2022-jp?B?WC9JMW5BWnl6OXV4QjZYdmRkdkhyRFVlbzgzTWNoU2NYVVlPWmk2Vk1S?=
 =?iso-2022-jp?B?dTduRUVQQ05Ka1NlQkFEUFpiUWxDdFRsb2lDZkV6cm9oRGZPTlV4K240?=
 =?iso-2022-jp?B?MnFydjY0ZUo1OGhuY3duMGZxZUJEeTZ1NGg0eTY1ME1UT2laOFI1TjFw?=
 =?iso-2022-jp?B?OEZoekdVU2FjbithVEtXckViYU92T3VhNGpaN0JrRDJqOTY2aW45WVY0?=
 =?iso-2022-jp?B?aXoyaGhkb0dFOVdIVnZQeTQ4Y0dmYjBNdmFXWWgvUy9VMU5uRitnbWxI?=
 =?iso-2022-jp?B?bXhCT2VBSkF4UVVhdk0vRjM0NHcyNFhVeFV4N1lZNEs2SHgzN3g1UDMx?=
 =?iso-2022-jp?B?WFFZblY0Z2tmOVUvK2hzUjNpZUswY2lOajZKTzVjV3grZUk0ODF1b2tE?=
 =?iso-2022-jp?B?Q3pSWnZUUVFPZExUTzNwMlA1Vzg0TmZrT0gvUzhsMnNxdkhZZjVwbUMr?=
 =?iso-2022-jp?B?Y0lxcDE3bEpsQjh2N1hBN1lNZFU2Kzg2Y1lxbWZ4cy9mdFNsV0lySXFE?=
 =?iso-2022-jp?B?VkF4U0sxRmlNQUM2T0RjYWRaRzZDZm95clhKNktLczIxOFNuYkhEZTVW?=
 =?iso-2022-jp?B?dDU5MTRKYXJCcVcyc3BVRDVpcEpyUG5ETGJZSS9rSG1oblQ1MTMrbEQ1?=
 =?iso-2022-jp?B?MFk3RGRlQ2YvOU9HTXNPY0NRSVIwOXdKQ3BqNjBLanF0ZGhwaytIRzAr?=
 =?iso-2022-jp?B?WUlPTEdBSW9INVJDYlcxbUV5QlRIbXlERjZWVkt1RUcrYXVrTEQxbmdx?=
 =?iso-2022-jp?B?b3lONHZLWnY4TVVzNEZWU3pXUEpWUHNwUEt6Rjh1VSt4a1FiSGtpK1F2?=
 =?iso-2022-jp?B?bGdVT1ZBUzllSkphSDFNbWVMaUNaczRvM1F5MUgxS29UakYwNjhSRUZD?=
 =?iso-2022-jp?B?OTFtcCtGRkpWVmVhU3pweXBYTWsyN1ZmaCs0NFN4UnV1OFFNM2dQd3Ar?=
 =?iso-2022-jp?B?WjdwLzJZd0xIZmR2RzcvUWRDYnhNdTh1eHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB12402.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9f1f94-d746-4df7-99e2-08dcafc6055f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2024 12:00:20.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +9NqQn57P93lrtyTkpe7QFfNQRTI1Umz/tlDndoLeIFNFz9M1MO62TmTv/VgHAubFpvtD/QJVM6Zazszs3Ty8NwzySSDnILHQZTlfNtqvd8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jul 2024 12:00:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16632

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Monday, July 29, 2024 12:59 AM
>=20
> Hi Pavel,
>=20
> I sent MR for tests for 6.10.y tree.
>   https://gitlab.com/cip-project/cip-testing/linux-cip-pipelines/-
> /merge_requests/59

Thank you for this Iwamatsu-san.
I've tested it, including updating our build docker images.

I've also now enabled 5.10 testing in our Linux-stable-rc-ci repo.
Here's the first run: https://gitlab.com/cip-project/cip-testing/linux-stab=
le-rc-ci/-/pipelines/1391918486

Kind regards, Chris

>=20
> Best regards,
>   Nobuhiro
>=20
> > -----Original Message-----
> > From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> > Behalf Of Pavel Machek
> > Sent: Saturday, July 27, 2024 3:25 AM
> > To: chris.paterson2@renesas.com; cip-dev@lists.cip-project.org
> > Subject: [cip-dev] Adding tests for 6.10.x
> >
> > Hi!
> >
> > Could we start testing 6.10.x kernels? I guess 6.9.x configs could be
> used as
> > templates...
> >
> > Best regards,
> >
> > 								Pavel
> > --
> > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


